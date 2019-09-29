unit MemLibrary;

interface

uses
  Windows;


function memLoadLibrary(pLib: Pointer): DWord;
function memGetProcAddress(dwLibHandle: DWord; pFunctionName: PChar): Pointer; stdcall;
function memFreeLibrary(dwHandle: DWord): Boolean;


implementation

function GetProcAddressX(dwLibraryHandle: DWord; pFunctionName: PChar): Pointer; stdcall;
var
  NtHeader: PImageNtHeaders;
  DosHeader: PImageDosHeader;
  DataDirectory: PImageDataDirectory;
  ExportDirectory: PImageExportDirectory;
  i: Integer;
  iExportOrdinal: Integer;
  ExportName: string;
  dwPosDot: DWord;
  dwNewmodule: DWord;
  pFirstExportName: Pointer;
  pFirstExportAddress: Pointer;
  pFirstExportOrdinal: Pointer;
  pExportAddr: PDWord;
  pExportNameNow: PDWord;
  pExportOrdinalNow: PWord;
begin
  Result := nil;
  DosHeader := Pointer(dwLibraryHandle);
  if (pFunctionName = nil) then
    Exit;

  if (isBadReadPtr(DosHeader, sizeof(TImageDosHeader)) or
    (DosHeader^.e_magic <> IMAGE_DOS_SIGNATURE)) then
    Exit; {Wrong PE (DOS) Header}

  NtHeader := Pointer(DWord(DosHeader^._lfanew) + DWord(DosHeader));
  if (isBadReadPtr(NtHeader, sizeof(TImageNTHeaders)) or
    (NtHeader^.Signature <> IMAGE_NT_SIGNATURE)) then
    Exit; {Wrong PW (NT) Header}

  DataDirectory := @NtHeader^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXPORT];
  if (DataDirectory = nil) or (DataDirectory^.VirtualAddress = 0) then
    Exit; {Library has no exporttable}

  ExportDirectory := Pointer(DWord(DosHeader) + DWord(DataDirectory^.VirtualAddress));
  if isBadReadPtr(ExportDirectory, SizeOf(TImageExportDirectory)) then
    Exit;

  pFirstExportName := Pointer(DWord(ExportDirectory^.AddressOfNames) + DWord(DosHeader));
  pFirstExportOrdinal := Pointer(DWord(ExportDirectory^.AddressOfNameOrdinals) + DWord(DosHeader));
  pFirstExportAddress := Pointer(DWord(ExportDirectory^.AddressOfFunctions) + DWord(DosHeader));

  if (integer(pFunctionName) > $FFFF) then {is FunctionName a PChar?}
  begin
    iExportOrdinal := -1; {if we dont find the correct ExportOrdinal}
    for i := 0 to ExportDirectory^.NumberOfNames - 1 do {for each export do}
    begin
      pExportNameNow := Pointer(Integer(pFirstExportName) + SizeOf(Pointer) * i);
      if (not isBadReadPtr(pExportNameNow, SizeOf(DWord))) then
      begin
        ExportName := PChar(pExportNameNow^ + DWord(DosHeader));
        if (ExportName = pFunctionName) then {is it the export we search? Calculate the ordinal.}
        begin
          pExportOrdinalNow := Pointer(Integer(pFirstExportOrdinal) + SizeOf(Word) * i);
          if (not isBadReadPtr(pExportOrdinalNow, SizeOf(Word))) then
            iExportOrdinal := pExportOrdinalNow^;
        end;
      end;
    end;
  end else {no PChar, calculate the ordinal directly}
    iExportOrdinal := DWord(pFunctionName) - DWord(ExportDirectory^.Base);

  if (iExportOrdinal < 0) or (iExportOrdinal > Integer(ExportDirectory^.NumberOfFunctions)) then
    Exit; {havent found the ordinal}

  pExportAddr := Pointer(iExportOrdinal * 4 + Integer(pFirstExportAddress));
  if (isBadReadPtr(pExportAddr, SizeOf(DWord))) then
    Exit;

  {Is the Export outside the ExportSection? If not its NT spezific forwared function}
  if (pExportAddr^ < DWord(DataDirectory^.VirtualAddress)) or
    (pExportAddr^ > DWord(DataDirectory^.VirtualAddress + DataDirectory^.Size)) then
  begin
    if (pExportAddr^ <> 0) then {calculate export address}
      Result := Pointer(pExportAddr^ + DWord(DosHeader));
  end else
  begin {forwarded function (like kernel32.EnterCriticalSection -> NTDLL.RtlEnterCriticalSection)}
    ExportName := PChar(dwLibraryHandle + pExportAddr^);
    dwPosDot := Pos('.', ExportName);
    if (dwPosDot > 0) then
    begin
      dwNewModule := GetModuleHandle(PChar(Copy(ExportName, 1, dwPosDot - 1)));
      if (dwNewModule = 0) then
        dwNewModule := LoadLibrary(PChar(Copy(ExportName, 1, dwPosDot - 1)));
      if (dwNewModule <> 0) then
        result := GetProcAddressX(dwNewModule, PChar(Copy(ExportName, dwPosDot + 1, Length(ExportName))));
    end;
  end;
end;

procedure ChangeReloc(baseorgp, basedllp, relocp: pointer; size: cardinal);
type
  TRelocblock = record
    vaddress: integer;
    size: integer;
  end;
  PRelocblock = ^TRelocblock;
var
  myreloc: PRelocblock;
  reloccount: integer;
  startp: ^word;
  i: cardinal;
  p: ^cardinal;
  dif: cardinal;
begin
  myreloc := relocp;
  dif := cardinal(basedllp) - cardinal(baseorgp);
  startp := pointer(cardinal(relocp) + 8);
  while myreloc^.vaddress <> 0 do
  begin
    reloccount := (myreloc^.size - 8) div sizeof(word);
    for i := 0 to reloccount - 1 do
    begin
      if (startp^ xor $3000 < $1000) then
      begin
        p := pointer(myreloc^.vaddress + startp^ mod $3000 + integer(basedllp));
        p^ := p^ + dif;
      end;
      startp := pointer(cardinal(startp) + sizeof(word));
    end;
    myreloc := pointer(startp);
    startp := pointer(cardinal(startp) + 8);
  end;
end;

procedure CreateImportTable(dllbasep, importp: pointer); stdcall;
type
  timportblock = record
    Characteristics: cardinal;
    TimeDateStamp: cardinal;
    ForwarderChain: cardinal;
    Name: pchar;
    FirstThunk: pointer;
  end;
  pimportblock = ^timportblock;
var
  myimport: pimportblock;
  thunksread, thunkswrite: ^pointer;
  dllname: pchar;
  dllh: thandle;
  old: cardinal;
begin
  myimport := importp;
  while (myimport^.FirstThunk <> nil) and (myimport^.Name <> nil) do
  begin
    dllname := pointer(integer(dllbasep) + integer(myimport^.name));
    dllh := LoadLibrary(dllname);
    thunksread := pointer(integer(myimport^.FirstThunk) + integer(dllbasep));
    thunkswrite := thunksread;
    if integer(myimport^.TimeDateStamp) = -1 then
      thunksread := pointer(integer(myimport^.Characteristics) + integer(dllbasep));
    while (thunksread^ <> nil) do
    begin
      if VirtualProtect(thunkswrite, 4, PAGE_EXECUTE_READWRITE, old) then
      begin
        if (cardinal(thunksread^) and $80000000 <> 0) then
          thunkswrite^ := GetProcAddress(dllh, pchar(cardinal(thunksread^) and $FFFF)) else
          thunkswrite^ := GetProcAddress(dllh, pchar(integer(dllbasep) + integer(thunksread^) + 2));
        VirtualProtect(thunkswrite, 4, old, old);
      end;
      inc(thunksread, 1);
      inc(thunkswrite, 1);
    end;
    myimport := pointer(integer(myimport) + sizeof(timportblock));
  end;
end;


function memLoadLibrary(pLib: Pointer): DWord;
var
  DllMain: function(dwHandle, dwReason, dwReserved: DWord): DWord; stdcall;
  IDH: PImageDosHeader;
  INH: PImageNtHeaders;
  SEC: PImageSectionHeader;
  dwSecCount: DWord;
  dwLen: DWord;
  dwmemsize: DWord;
  i: Integer;
  pAll: Pointer;
begin
  Result := 0;

  IDH := pLib;
  if isBadReadPtr(IDH, SizeOf(TImageDosHeader)) or (IDH^.e_magic <> IMAGE_DOS_SIGNATURE) then
    Exit;

  INH := pointer(cardinal(pLib) + cardinal(IDH^._lfanew));
  if isBadReadPtr(INH, SizeOf(TImageNtHeaders)) or (INH^.Signature <> IMAGE_NT_SIGNATURE) then
    Exit;

// if (pReserved <> nil) then
//    dwLen := Length(pReserved)+1
// else
  dwLen := 0;

  SEC := Pointer(Integer(INH) + SizeOf(TImageNtHeaders));
  dwMemSize := INH^.OptionalHeader.SizeOfImage;
  if (dwMemSize = 0) then Exit;

  pAll := VirtualAlloc(nil, dwMemSize + dwLen, MEM_COMMIT or MEM_RESERVE, PAGE_EXECUTE_READWRITE);
  if (pAll = nil) then Exit;

  dwSecCount := INH^.FileHeader.NumberOfSections;
  CopyMemory(pAll, IDH, DWord(SEC) - DWord(IDH) + dwSecCount * SizeOf(TImageSectionHeader));
// CopyMemory(Pointer(DWord(pAll) + dwMemSize),pReserved,dwLen-1);
  CopyMemory(Pointer(DWord(pAll) + dwMemSize), nil, dwLen - 1);
  for i := 0 to dwSecCount - 1 do
  begin
    CopyMemory(Pointer(DWord(pAll) + SEC^.VirtualAddress),
      Pointer(DWord(pLib) + DWord(SEC^.PointerToRawData)),
      SEC^.SizeOfRawData);
    SEC := Pointer(Integer(SEC) + SizeOf(TImageSectionHeader));
  end;

  if (INH^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_BASERELOC].VirtualAddress <> 0) then
    ChangeReloc(Pointer(INH^.OptionalHeader.ImageBase),
      pAll,
      Pointer(DWord(pAll) + INH^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_BASERELOC].VirtualAddress),
      INH^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_BASERELOC].Size);
  CreateImportTable(pAll, Pointer(DWord(pAll) + INH^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_IMPORT].VirtualAddress));

  @DllMain := Pointer(INH^.OptionalHeader.AddressOfEntryPoint + DWord(pAll));
// if (INH^.OptionalHeader.AddressOfEntryPoint <> 0) and (bDllMain) then
  if INH^.OptionalHeader.AddressOfEntryPoint <> 0 then
  begin
    try
//      if (pReserved <> nil) then
//        DllMain(DWord(pAll),DLL_PROCESS_ATTACH,DWord(pAll)+dwMemSize)
//      else
      DllMain(DWord(pAll), DLL_PROCESS_ATTACH, 0);
    except
    end;
  end;
  Result := DWord(pAll);
end;


function memFreeLibrary(dwHandle: DWord): Boolean;
var
  IDH: PImageDosHeader;
  INH: PImageNTHeaders;
begin
  Result := false;
  if (dwHandle = 0) then
    Exit;

  IDH := Pointer(dwHandle);
  if (IDH^.e_magic <> IMAGE_DOS_SIGNATURE) then
    Exit;

  INH := Pointer(DWord(IDH^._lfanew) + DWord(IDH));
  if (INH^.Signature <> IMAGE_NT_SIGNATURE) then
    Exit;

  if VirtualFree(Pointer(dwHandle), INH^.OptionalHeader.SizeOfImage, MEM_DECOMMIT) then
    Result := True;
end;


function memGetProcAddress(dwLibHandle: DWord; pFunctionName: PChar): Pointer; stdcall;
var
  NtHeader: PImageNtHeaders;
  DosHeader: PImageDosHeader;
  DataDirectory: PImageDataDirectory;
  ExportDirectory: PImageExportDirectory;
  i: Integer;
  iExportOrdinal: Integer;
  ExportName: string;
  dwPosDot: DWord;
  dwNewmodule: DWord;
  pFirstExportName: Pointer;
  pFirstExportAddress: Pointer;
  pFirstExportOrdinal: Pointer;
  pExportAddr: PDWord;
  pExportNameNow: PDWord;
  pExportOrdinalNow: PWord;
begin
  Result := nil;
  if pFunctionName = nil then Exit;

  DosHeader := Pointer(dwLibHandle);
  if isBadReadPtr(DosHeader, sizeof(TImageDosHeader)) or (DosHeader^.e_magic <> IMAGE_DOS_SIGNATURE) then
    Exit; {Wrong PE (DOS) Header}

  NtHeader := Pointer(DWord(DosHeader^._lfanew) + DWord(DosHeader));
  if isBadReadPtr(NtHeader, sizeof(TImageNTHeaders)) or (NtHeader^.Signature <> IMAGE_NT_SIGNATURE) then
    Exit; {Wrong PW (NT) Header}

  DataDirectory := @NtHeader^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXPORT];
  if (DataDirectory = nil) or (DataDirectory^.VirtualAddress = 0) then
    Exit; {Library has no exporttable}

  ExportDirectory := Pointer(DWord(DosHeader) + DWord(DataDirectory^.VirtualAddress));
  if isBadReadPtr(ExportDirectory, SizeOf(TImageExportDirectory)) then
    Exit;

  pFirstExportName := Pointer(DWord(ExportDirectory^.AddressOfNames) + DWord(DosHeader));
  pFirstExportOrdinal := Pointer(DWord(ExportDirectory^.AddressOfNameOrdinals) + DWord(DosHeader));
  pFirstExportAddress := Pointer(DWord(ExportDirectory^.AddressOfFunctions) + DWord(DosHeader));

  if (integer(pFunctionName) > $FFFF) then {is FunctionName a PChar?}
  begin
    iExportOrdinal := -1; {if we dont find the correct ExportOrdinal}
    for i := 0 to ExportDirectory^.NumberOfNames - 1 do {for each export do}
    begin
      pExportNameNow := Pointer(Integer(pFirstExportName) + SizeOf(Pointer) * i);
      if (not isBadReadPtr(pExportNameNow, SizeOf(DWord))) then
      begin
        ExportName := PChar(pExportNameNow^ + DWord(DosHeader));
        if (ExportName = pFunctionName) then {is it the export we search? Calculate the ordinal.}
        begin
          pExportOrdinalNow := Pointer(Integer(pFirstExportOrdinal) + SizeOf(Word) * i);
          if (not isBadReadPtr(pExportOrdinalNow, SizeOf(Word))) then
            iExportOrdinal := pExportOrdinalNow^;
        end;
      end;
    end;
  end else {no PChar, calculate the ordinal directly}
    iExportOrdinal := DWord(pFunctionName) - DWord(ExportDirectory^.Base);

  if (iExportOrdinal < 0) or (iExportOrdinal > Integer(ExportDirectory^.NumberOfFunctions)) then
    Exit; {havent found the ordinal}

  pExportAddr := Pointer(iExportOrdinal * 4 + Integer(pFirstExportAddress));
  if (isBadReadPtr(pExportAddr, SizeOf(DWord))) then
    Exit;

{Is the Export outside the ExportSection? If not its NT spezific forwared function}
  if (pExportAddr^ < DWord(DataDirectory^.VirtualAddress)) or
    (pExportAddr^ > DWord(DataDirectory^.VirtualAddress + DataDirectory^.Size)) then
  begin
    if (pExportAddr^ <> 0) then {calculate export address}
      Result := Pointer(pExportAddr^ + DWord(DosHeader));
  end
  else
  begin {forwarded function (like kernel32.EnterCriticalSection -> NTDLL.RtlEnterCriticalSection)}
    ExportName := PChar(dwLibHandle + pExportAddr^);
    dwPosDot := Pos('.', ExportName);
    if (dwPosDot > 0) then
    begin
      dwNewModule := GetModuleHandle(PChar(Copy(ExportName, 1, dwPosDot - 1)));
      if (dwNewModule = 0) then
        dwNewModule := LoadLibrary(PChar(Copy(ExportName, 1, dwPosDot - 1)));
      if (dwNewModule <> 0) then
        result := GetProcAddressX(dwNewModule, PChar(Copy(ExportName, dwPosDot + 1, Length(ExportName))));
    end;
  end;
end;

end.

