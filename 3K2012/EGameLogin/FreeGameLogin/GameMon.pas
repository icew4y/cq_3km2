unit GameMon;

interface

uses Windows, SysUtils, Messages, TlHelp32, Forms;

type
  TProcessInfo=Record
    ExeFile:string;
    ProcessID:Dword;
  end;
  sProcessInfo=^TProcessInfo;
var
  ProcessInfo                 : TProcessInformation;
  AsmBuf                      : array[0..20] of Byte = ($B8, $00, $00, $00, $00, $68, $00, $00, $00, $00, $FF, $D0, $B8, $00, $00, $00, 00, $6A, $00, $FF, $D0);



//寻找窗口 回调函数
function EnumWindowsProc(ahwnd: hwnd; lParam: lParam): Boolean; stdcall;
procedure Enum_Proccess;
//结束进程
procedure EndProcess(AFileName: string);
implementation
uses Common, Main, GameLoginShare;
{!------反外挂代码开始-------!}
//钩子函数
function EnabledDebugPrivilege(const bEnabled: Boolean): Boolean;
var
  hToken                      : THandle;
  tp                     : TOKEN_PRIVILEGES;
  a                           : DWORD;
const
  SE_DEBUG_NAME               = 'SeDebugPrivilege';
begin
  Result := False;
  if (OpenProcessToken(GetCurrentProcess(), TOKEN_ADJUST_PRIVILEGES, hToken)) then begin
    tp.PrivilegeCount := 1;
    LookupPrivilegeValue(nil, SE_DEBUG_NAME, tp.Privileges[0].Luid);
    if bEnabled then
      tp.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED
    else
      tp.Privileges[0].Attributes := 0;
    a := 0;
    AdjustTokenPrivileges(hToken, False, tp, SizeOf(tp), nil, a);
    Result := GetLastError = ERROR_SUCCESS;
    CloseHandle(hToken);
  end;
end;

function EjectDll(pid: cardinal; Dll: string): cardinal;
type
  PDebugModule = ^TDebugModule;
  TDebugModule = packed record
    Reserved: array[0..1] of cardinal;
    Base: cardinal;
    Size: cardinal;
    Flags: cardinal;
    Index: Word;
    Unknown: Word;
    LoadCount: Word;
    ModuleNameOffset: Word;
    ImageName: array[0..$FF] of char;
  end;
type
  PDebugModuleInformation = ^TDebugModuleInformation;
  TDebugModuleInformation = record
    Count: cardinal;
    Modules: array[0..0] of TDebugModule;
  end;
type
  PDebugBuffer = ^TDebugBuffer;
  TDebugBuffer = record
    SectionHandle: THandle;
    SectionBase: Pointer;
    RemoteSectionBase: Pointer;
    SectionBaseDelta: cardinal;
    EventPairHandle: THandle;
    Unknown: array[0..1] of cardinal;
    RemoteThreadHandle: THandle;
    InfoClassMask: cardinal;
    SizeOfInfo: cardinal;
    AllocatedSize: cardinal;
    SectionSize: cardinal;
    ModuleInformation: PDebugModuleInformation;
    BackTraceInformation: Pointer;
    HeapInformation: Pointer;
    LockInformation: Pointer;
    Reserved: array[0..7] of Pointer;
  end;
const
  PDI_MODULES                 = $01;
  ntdll                       = 'ntdll.dll';
var
  HNtDll                      : HMODULE;
type
  TFNRtlCreateQueryDebugBuffer = function(Size: cardinal; EventPair: Boolean): PDebugBuffer; stdcall;
  TFNRtlQueryProcessDebugInformation = function(ProcessID,
    DebugInfoClassMask: cardinal; var DebugBuffer: TDebugBuffer): Integer; stdcall;
  TFNRtlDestroyQueryDebugBuffer = function(DebugBuffer: PDebugBuffer): Integer; stdcall;
var
  RtlCreateQueryDebugBuffer   : TFNRtlCreateQueryDebugBuffer;
  RtlQueryProcessDebugInformation: TFNRtlQueryProcessDebugInformation;
  RtlDestroyQueryDebugBuffer  : TFNRtlDestroyQueryDebugBuffer;

  function LoadRtlQueryDebug: LongBool;
  begin
    HNtDll := LoadLibrary(ntdll);
    if HNtDll <> 0 then begin
      RtlCreateQueryDebugBuffer := GetProcAddress(HNtDll, 'RtlCreateQueryDebugBuffer');
      RtlQueryProcessDebugInformation := GetProcAddress(HNtDll, 'RtlQueryProcessDebugInformation');
      RtlDestroyQueryDebugBuffer := GetProcAddress(HNtDll, 'RtlDestroyQueryDebugBuffer');
    end;
    Result := Assigned(RtlCreateQueryDebugBuffer) and
      Assigned(RtlQueryProcessDebugInformation) and
      Assigned(RtlQueryProcessDebugInformation);
  end;

  function ReleaseRtlQueryDebug: LongBool;
  begin
    Result := FreeLibrary(HNtDll);
  end;

var
  hProc                       : cardinal;
  hMod                        : cardinal;
  TempVar                     : cardinal;
  DbgBuffer                   : PDebugBuffer;
  i, j                        : Integer;
  pd                          : PDWORD;
  pRemoteFunc                 : Pointer;
begin
  Result := 0;
  if pid = 0 then Exit;
  EnabledDebugPrivilege(True);
  LoadRtlQueryDebug;
  DbgBuffer := RtlCreateQueryDebugBuffer(0, False);
  if Assigned(DbgBuffer) then try
    if RtlQueryProcessDebugInformation(pid, PDI_MODULES, DbgBuffer^) >= 0 then
      for i := 0 to DbgBuffer.ModuleInformation.Count - 1 do
        if UpperCase(DbgBuffer.ModuleInformation.Modules[i].ImageName) =
          UpperCase(Dll) then begin
          hMod := DbgBuffer.ModuleInformation.Modules[i].Base;
          j := DbgBuffer.ModuleInformation.Modules[i].LoadCount;
          Break;
        end;
  finally
    RtlDestroyQueryDebugBuffer(DbgBuffer);
    ReleaseRtlQueryDebug;
  end;
  hProc := OpenProcess(PROCESS_ALL_ACCESS, False, pid);
  try
    TempVar := DWORD(GetProcAddress(GetModuleHandle('Kernel32'), 'FreeLibrary'));
    pd := @AsmBuf[1];
    pd^ := TempVar;
    pd := @AsmBuf[6];
    pd^ := hMod;
    TempVar := DWORD(GetProcAddress(GetModuleHandle('Kernel32'), 'ExitThread'));
    pd := @AsmBuf[13];
    pd^ := TempVar;
    pRemoteFunc := VirtualAllocEx(hProc, nil, 21, MEM_COMMIT, PAGE_EXECUTE_READWRITE);
    if WriteProcessMemory(hProc, pRemoteFunc, @AsmBuf[0], 21, TempVar) then
      for i := 0 to j - 1 do begin
        TempVar := 0;
        Result := CreateRemoteThread(hProc, nil, 0, pRemoteFunc, nil, 0, TempVar);
      end;
  finally
    CloseHandle(hProc);
  end;
end;
{!钩子处理函数结束!}

//寻找窗口 回调函数
function EnumWindowsProc(ahwnd: hwnd; lParam: lParam): Boolean; stdcall;
var
  Str                         : array[0..144] of char;
  i                           : Integer;
  Title                    : string;
begin
  Result := False;
  if IsWindowVisible(ahwnd) then begin
    GetWindowText(ahwnd, @Str, 144);    //取标题
    if Str <> '' then begin
      if g_GameMonTitle.Count <> 0 then begin
        for i := 0 to g_GameMonTitle.Count - 1 do begin
          Title := g_GameMonTitle.Strings[I];
            if Pos(LowerCase(Title), LowerCase(Str)) > 0 then  begin
              FrmMain.TimerKillCheat.Enabled := False;
              PostMessage(ahwnd, WM_CLOSE, 0, 0); //关闭窗口
              //EndProcess(ClientFileName); //关闭热血进程
              FrmMain.Caption := '';
              Application.MessageBox(PChar('发现非法外挂或加速器，已经关闭此软件！' + #13
                + '如果没关闭成功，请自己关闭！' + #13
                + '请从新运行登陆器！'+ #13
                + #13 + '可疑文件：' + Str), '警告：', MB_Ok + MB_ICONWARNING);
//              Application.Terminate;
              asm //关闭程序
                MOV FS:[0],0;
                MOV DS:[0],EAX;
              end;
            end;
        end;
      end;
    end;
  end;
  Result := True;
end;
//结束进程
procedure EndProcess(AFileName: string);
const
   PROCESS_TERMINATE = $0001;
var
   ContinueLoop: BOOL;
   FSnapShotHandle: THandle;
   FProcessEntry32: TProcessEntry32;
begin
   FSnapShotHandle := CreateToolhelp32SnapShot(TH32CS_SNAPPROCESS, 0);
   FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
   ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
   while integer(ContinueLoop) <> 0 do
   begin
     if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile))=UpperCase(AFileName)) or (UpperCase(FProcessEntry32.szExeFile )=UpperCase(AFileName))) then
     TerminateProcess(OpenProcess(PROCESS_TERMINATE, BOOL(0),FProcessEntry32.th32ProcessID), 0);
     ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
   end;
end;

//枚举某进程模块
procedure Enum_Module(ProcessID: LongWord);
var
  hSnapshot                   : LongWord;
  ModuleEntry                 : TModuleEntry32;
  FoundModule                 : Boolean;
  i                           : Integer;
  Module                   : string;
begin
  ModuleEntry.dwSize := SizeOf(ModuleEntry);
  hSnapshot := CreateToolhelp32Snapshot(TH32CS_SNAPMODULE, ProcessID);
  FoundModule := Module32First(hSnapshot, ModuleEntry);
  while (FoundModule) do begin
      for i := 0 to g_GameMonModule.Count - 1 do begin
        Module := g_GameMonModule.Strings[I];//GetValidStr3(g_GameTools.Strings[i], s, ['=']);
        {if LowerCase('TjBin.dll') = LowerCase(ModuleEntry.szModule) then begin    //20100624 注释
          if ModuleEntry.th32ProcessID <> ProcessInfo.dwProcessId then begin
            EjectDll(ModuleEntry.th32ProcessID, ModuleEntry.szExePath); //卸载钩子
            Exit;
          end;
        end;}
          if (LowerCase(Module) = LowerCase(ModuleEntry.szModule)) or (LowerCase('TjBin.dll') = LowerCase(ModuleEntry.szModule)) then begin//20100624 增加
            if ProcessInfo.hProcess <> 0 then begin
              TerminateProcess(ProcessInfo.hProcess, 0); //关闭登陆器进程
            end;
              FrmMain.TimerKillCheat.Enabled := False;
              //EndProcess(ClientFileName); //关闭热血进程
              FrmMain.Caption := '';
              Application.MessageBox(PChar('发现非法外挂或加速器，已经关闭此软件！' + #13
                + '如果没关闭成功，请自己关闭！' + #13
                + '请从新运行登陆器！'+ #13
                + #13 + '可疑文件：' + ModuleEntry.szExePath), '警告：', MB_Ok + MB_ICONWARNING);
              //EndProcess(ClientFileName); //关闭热血进程
              asm //关闭程序
                MOV FS:[0],0;
                MOV DS:[0],EAX;
              end;
          end;
      end;
      FoundModule := Module32Next(hSnapshot, ModuleEntry);
  end;
  CloseHandle(hSnapshot);
end;

procedure Enum_Proccess;
var
  hSnapshot                   : LongWord;
  ProcessEntry                : TProcessEntry32;
  FoundProcess                : Boolean;
  I: Integer;
  p:sProcessInfo;
begin
  hSnapshot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  ProcessEntry.dwSize := SizeOf(ProcessEntry);
  FoundProcess := Process32First(hSnapshot, ProcessEntry);
  while FoundProcess do begin
      for i := 0 to g_GameMonProcess.Count - 1 do begin

        New(p);
        p.ExeFile:=ProcessEntry.szExeFile;
        p.ProcessID:=ProcessEntry.th32ProcessID;
        if p.ExeFile = g_GameMonProcess.Strings[I] then begin
            EndProcess(p.ExeFile);
            FrmMain.TimerKillCheat.Enabled := False;
           // EndProcess(ClientFileName); //关闭热血进程
           FrmMain.Caption := '';
            Application.MessageBox(PChar('发现非法外挂或加速器，已经关闭此软件！' + #13
                + '如果没关闭成功，请自己关闭！' + #13
                + '请从新运行登陆器！'+ #13
                + #13 + '可疑文件：' + p.ExeFile), '警告：', MB_Ok + MB_ICONWARNING);
            asm //关闭程序
              MOV FS:[0],0;
              MOV DS:[0],EAX;
            end;
        end;
        Dispose(p);
      end;
    Enum_Module(ProcessEntry.th32ProcessID);
    FoundProcess := Process32Next(hSnapshot, ProcessEntry);
  end;
  CloseHandle(hSnapshot);
end;
{!------反外挂代码结束-------!}
end.
