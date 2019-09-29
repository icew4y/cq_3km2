{************************************************}
{                                                }
{               EurekaLog v 6.x                  }
{              Hook Unit - EHook                 }
{                                                }
{  Copyright (c) 2001 - 2007 by Fabio Dell'Aria  }
{                                                }
{************************************************}

unit EHook;

{$I Exceptions.inc}

interface

uses Windows; 

type
  THandle = Cardinal;
  PPointer = ^Pointer;
  PShortInt = ^ShortInt;

function HookProcedureEx(ProcAddr, NewProc: Pointer; ProcName: string): Pointer;
function UnhookProcedure(ProcAddr: Pointer): Boolean;

function HookDllProcedureEx(ImportModule, ExportModule, ProcName: string;
  NewProc: Pointer): Pointer;
function TryHookDllProcedureEx(ImportModules: array of string;
  ExportModule, ProcName: string; NewProc: Pointer;
  var CallProc: Pointer; CanFail: Boolean): Boolean;

function HookVirtualMethod(AClass: TClass; Index: Integer; Method: Pointer): Pointer;
function UnhookVirtualMethod(AClass: TClass; Index: Integer): Boolean;

procedure JumpToMem(Addr, Jump: Pointer);

function GetFunctionSize(Addr, MaxSize: DWord): DWord;
function GetAsmSize(Start: Pointer; var Size: Byte): Boolean;

implementation

uses Classes, SysUtils, ECore;

const
  EProcNullStr = '不能钩一个null程序 ("%s").';
  ESharedAreaStr = '不能钩子模块"%s"设成共享区.'{'Cannot hook the module "%s" located into the shared-area.'};
  EHookingErrorStr = '不能钩子程序 "%s".'{'Cannot hook the procedure "%s".'};

  SharedMem = $7FFFFFFF; // Don't use major value because Delphi3 don't support it.

  ModRmMod = $C0; // XX??????
  ModRmRM = $07; //  ?????XXX

  OperSizeOver = $66; // Change the operand size from 32 to 16/8 bits.
  AddrSizeOver = $67; // Change the address size from 32 to 16/8 bits.

  OpCodePrefixes: set of Byte =
    [$F0, $F2, $F3, $2E, $36, $3E, $26, $64, $65, OperSizeOver, AddrSizeOver];

  OpCodeShortJump: set of Byte = [$70..$7F, $E0..$E3, $EB]; // 1 OpCode byte

  OpCodeReturn: set of Byte = [$C2, $C3..$CA, $CB]; // "Return" first byte OpCodes

  OpCodeLongJump1Byte: set of Byte = [$E8..$E9]; // 1 OpCode byte

  OpCodeLongJump2Bytes: set of Byte = [$80..$8F]; // 2 OpCode bytes, 1th = $0F

  AsmConst: array [0..255] of Byte = ($EE, $EE, $EE, $EE, $F1, $0B, $00, $00,
    $0E, $0E, $FE, $FE, $F1, $EB, $00, $FF, $EE, $EE, $EE, $EE, $E1, $EB, $E0,
    $E0, $EE, $FE, $FE, $FE, $F1, $FB, $F0, $F0, $EE, $EE, $EE, $EE, $F1, $FB,
    $FF, $F0, $EE, $EE, $EE, $EE, $E1, $EB, $EF, $E0, $0E, $0E, $0E, $0E, $01,
    $0B, $FF, $F0, $FE, $FE, $FE, $FE, $F1, $FB, $FF, $F0, $E0, $E0, $E0, $E0,
    $E0, $E0, $E0, $E0, $E0, $E0, $E0, $E0, $E0, $E0, $E0, $E0, $E0, $E0, $E0,
    $E0, $E0, $E0, $E0, $E0, $E0, $E0, $E0, $E0, $E0, $E0, $E0, $E0, $E0, $E0,
    $EE, $EE, $EF, $EF, $EF, $EF, $EB, $EE, $E1, $EE, $F0, $F0, $E0, $E0, $E1,
    $E1, $E1, $E1, $E1, $E1, $E1, $01, $F1, $F1, $F1, $F1, $F1, $F1, $E1, $E1,
    $BE, $BE, $BE, $BE, $BE, $BE, $BE, $BE, $BE, $BE, $BE, $BE, $BE, $BE, $BE,
    $BE, $E0, $E0, $E0, $E0, $E0, $E0, $E0, $E0, $E0, $E0, $ED, $E0, $E0, $E0,
    $E0, $E0, $04, $04, $04, $E4, $E0, $E0, $E0, $E0, $01, $0B, $00, $E0, $E0,
    $E0, $E0, $E0, $E1, $E1, $E1, $E1, $E1, $E1, $E1, $E1, $FB, $FB, $EB, $EB,
    $EB, $EB, $EB, $EB, $EE, $EE, $E2, $E0, $EE, $EE, $EE, $EE, $03, $00, $02,
    $00, $00, $01, $00, $00, $FE, $EE, $EE, $EE, $E1, $E1, $F0, $E0, $EE, $EE,
    $EE, $EE, $EE, $EE, $EE, $EE, $E1, $E1, $E1, $E1, $E1, $E1, $F1, $E1, $EB,
    $EB, $ED, $E1, $E0, $E0, $E0, $E0, $FF, $E0, $EF, $EF, $E0, $E0, $EE, $EE,
    $E0, $E0, $E0, $E0, $E0, $E0, $EE, $FE);

type
  EHookError = class(Exception);
  EProcNull = class(EHookError);
  EHookingError = class(EHookError);
  ESharedArea = class(EHookError);

  TRedirectOpCodes = packed record
    JMPOpCode: Byte;
    JMPDistance: DWord;
  end;

  TPrefixes = set of Byte;

  THookedProcedure = record
    OriginalProc, HookedBlockPt: Pointer;
    HookedBlockSize: DWord;
    POriginalAsmPt: Pointer;
    POriginalAsmSize: DWord;
  end;
  PHookedProcedure = ^ THookedProcedure;

  PSaveDLLProc = ^TSaveDLLProc;
  TSaveDLLProc = packed record
    HookModule: THandle;
    ExportModule: string;
    OldProc, NewProc: Pointer;
  end;

  THookedData = packed record
    ClassType: TClass;
    OriginalMethod: Pointer;
    Index: Integer;
  end;
  PHookedData = ^THookedData;

  PWin9xDebugThunk = ^TWin9xDebugThunk;
  TWin9xDebugThunk = packed record
    PUSH: Byte;    // PUSH instruction opcode ($68)
    Addr: Pointer; // The actual address of the DLL routine
    JMP: Byte;     // JMP instruction opcode ($E9)
    Rel: Integer;  // Relative displacement (a Kernel32 address)
  end;

  IMAGE_IMPORT_DESCRIPTOR = packed record
    UnUsed: array [0..11] of Byte;
    Name: DWord;
    FirstThunk: DWord;  // RVA to IAT
  end;
  PImageImportDescriptor = ^IMAGE_IMPORT_DESCRIPTOR;

  IMAGE_THUNK_DATA = packed record
    Function_: DWord; // PDWord
  end;
  PImageThunkData = ^IMAGE_THUNK_DATA;

  PImageDosHeader = ^TImageDosHeader;
  TImageDosHeader = packed record    // DOS .EXE header
      e_magic: Word;                 // Magic number
      UnUsed: array [0..57] of Byte;
      _lfanew: LongInt;              // File address of new exe header
  end;

  THookedMethodsList = class(TList)
  private
    FLock: TRTLCriticalSection;
    function GetItem(Index: Integer): PHookedData;
  protected
  public
    constructor Create;
    destructor Destroy; override;
    procedure Lock;
    procedure Unlock;
    procedure Delete(Index: Integer);
    property Items[Index: Integer]: PHookedData read GetItem; default;
  end;

const
  TRedirectOpCodesSize = SizeOf(TRedirectOpCodes);

var
  HookedProcedures, DllList: TList;
  HookedMethodsList: THookedMethodsList;

//------------------------------------------------------------------------------

{ THookedMethods }

constructor THookedMethodsList.Create;
begin
  inherited;
  InitializeCriticalSection(FLock);
end;

function THookedMethodsList.GetItem(Index: Integer): PHookedData;
begin
  Result := PHookedData(TList(Self).Items[Index]);
end;

procedure THookedMethodsList.Lock;
begin
  EnterCriticalSection(FLock);
end;

procedure THookedMethodsList.Unlock;
begin
  LeaveCriticalSection(FLock);
end;

procedure THookedMethodsList.Delete(Index: Integer);
var
  Data: PHookedData;
  Ptr: Pointer;
begin
  Ptr := Items[Index];
  Data := PHookedData(Ptr);
  Dispose(Data);
  inherited;
end;

destructor THookedMethodsList.Destroy;
var
  I: Integer;
begin
  Lock;
  try
    for I := 0 to HookedMethodsList.Count - 1 do
      UnhookVirtualMethod(HookedMethodsList[0]^.ClassType, HookedMethodsList[0]^.Index);
  finally
    Unlock;
  end;
  DeleteCriticalSection(FLock);
  inherited;
end;

//------------------------------------------------------------------------------

function GetVirtualMethod(AClass: TClass; const Index: Integer): Pointer;
begin
  Result := PPointer(Integer(AClass) + (Index * 4))^
end;

procedure SetVirtualMethod(AClass: TClass; Index: Integer; Method: Pointer);
var
  PatchAddress: PPointer;
  OldProtectionCode: DWord;
begin
  PatchAddress := PPointer(Integer(AClass) + (Index * 4));
  if (FindHInstance(PatchAddress) = 0) then Exit; // Check for unloaded module...
  VirtualProtect(PatchAddress, 4, PAGE_EXECUTE_READWRITE, @OldProtectionCode);
  PatchAddress^ := Method;
  VirtualProtect(PatchAddress, 4, OldProtectionCode, @OldProtectionCode);
  FlushInstructionCache(GetCurrentProcess, PatchAddress, 4);
end;

function HookVirtualMethod(AClass: TClass; Index: Integer; Method: Pointer): Pointer;
var
  HData: PHookedData;
  n: Integer;
begin
  Result := nil;
  if (Assigned(HookedMethodsList)) then
  begin
    HookedMethodsList.Lock;
    try
      Result := GetVirtualMethod(AClass, Index);
      if (Result = Method) then
      begin // Just hooked...
        for n := 0 to (HookedMethodsList.Count - 1) do
        begin
          if ((HookedMethodsList[n]^.ClassType = AClass) and
          (HookedMethodsList[n]^.Index = Index)) then
          begin
            Result := HookedMethodsList[n]^.OriginalMethod;
            Break;
          end;
        end;
      end
      else
      begin // First hook...
        SetVirtualMethod(AClass, Index, Method);
        New(HData);
        HData^.ClassType := AClass;
        HData^.OriginalMethod := Result;
        HData^.Index := Index;
        HookedMethodsList.Add(HData);
      end;
    finally
      HookedMethodsList.Unlock;
    end;
  end;
end;

function UnhookVirtualMethod(AClass: TClass; Index: Integer): Boolean;
var
  n: Integer;
begin
  Result := False;
  if (Assigned(HookedMethodsList)) then
  begin
    HookedMethodsList.Lock;
    try
      for n := 0 to (HookedMethodsList.Count - 1) do
      begin
        if ((HookedMethodsList[n]^.ClassType = AClass) and
        (HookedMethodsList[n]^.Index = Index)) then
        begin
          SetVirtualMethod(AClass, Index, HookedMethodsList[n]^.OriginalMethod);
          HookedMethodsList.Delete(n);
          Result := True;
          Break;
        end;
      end;
    finally
      HookedMethodsList.Unlock;
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure WriteMem(Addr: Pointer; const Data; Size: DWord);
var
  OldProtectionCode: DWord;
begin
  VirtualProtect(Addr, Size, PAGE_EXECUTE_READWRITE, @OldProtectionCode);
  Move(Data, Addr^, Size);
  VirtualProtect(Addr, Size, oldProtectionCode, @OldProtectionCode);
  FlushInstructionCache(GetCurrentProcess, Addr, Size);
end;

procedure JumpToMem(Addr, Jump: Pointer);
var
  JumpOpCode: TRedirectOpCodes;
begin
  JumpOpCode.JMPOpCode := $E9; // JMP OpCode
  JumpOpCode.JMPDistance := (DWord(Jump) - DWord(Addr) - 5); // JMP Distance
  WriteMem(Addr, JumpOpCode, TRedirectOpCodesSize);
end;

function ModuleFileName(HModule: THandle): string;
var
  Buff: array[0..MAX_PATH - 1] of Char;
begin
  GetModuleFileName(HModule, Buff, SizeOf(Buff));
  Result := Buff;
end;

function ModRMByte(Prefixes: TPrefixes; OpCodeSize, OpCode, ModRM, SID: Byte): Byte;
var
  RmMod, RmRM: Byte;

  function AddrSize: Byte;
  begin
    Result := 4;
    if (OperSizeOver in Prefixes) then Dec(Result, 2);
  end;

  function SIDSize: Byte;
  begin
    Result := 1;
    if (SID and $07 = $05) then Inc(Result, 4);
  end;

begin
  Result := 0;
  RmMod := (ModRM and ModRmMod) shr 6;
  RmRM := (ModRM and ModRmRM);
  if (not (AddrSizeOver in Prefixes)) then
    case rmMod of // 32 bit mode...
      0: begin
          Result := 0;
          if (RmRM = 4) then Inc(Result, SIDSize)
          else
            if (RmRM = 5) then Inc(Result, 4);
        end;
      1: begin
          Result := 1;
          if (RmRM = 4) then Inc(Result);
        end;
      2: begin
          Result := 4;
          if (RmRM = 4) then Inc(Result);
        end;
      3: Result := 0;
    end
  else
    case rmMod of // 16 bit mode...
      0: begin
          Result := 0;
          if (RmRM = 6) then Inc(Result, 2);
        end;
      1: Result := 1;
      2: Result := 2;
      3: Result := 0;
    end;

  if (opCodeSize = 1) then // OpCode extensions...
  begin
    if (OpCode in [$6B, $80, $82, $83, $C0, $C1, $C6]) then Inc(Result)
    else
      if (OpCode in [$69, $81, $C7]) then Inc(Result, AddrSize)
      else
        if (OpCode = $F6) and (ModRM and $38 = 0) then Inc(Result)
        else
          if (OpCode = $F7) and (ModRM and $38 = 0) then Inc(Result, AddrSize);
  end
  else
    if (OpCode in [$70, $71, $72, $73, $A4, $AC, $BA, $C2, $C4, $C5, $C6]) then Inc(Result);
end;

function GetAsmSize(Start: Pointer; var Size: Byte): Boolean;
var
  OpCode, OpCodeSize, OpCodeType, Mask, Shift, ModRM, PrefixesSize: Byte;
  Ptr: PByte;
  Prefixes: TPrefixes;
begin
  Size := 1;
  Prefixes := [];
  Ptr := Start;
  repeat
    OpCode := Ptr^;
    if (OpCode in [AddrSizeOver, OperSizeOver]) then Prefixes := Prefixes + [OpCode];
    Inc(Ptr);
  until (not (OpCode in OpCodePrefixes));
  PrefixesSize := (DWord(Ptr) - DWord(Start) - 1);
  if (OpCode = $0F) then
  begin
    OpCodeSize := 2;
    OpCode := Ptr^;
    Inc(Ptr);
    Mask := $F0;
    Shift := 4;
  end
  else
  begin
    OpCodeSize := 1;
    Mask := $0F;
    Shift := 0;
  end;
  OpCodeType := ((AsmConst[OpCode] and Mask) shr Shift);
  Result := (OpCodeType <> $0F);
  if (Result) then
  begin
    if (OpCodeType < $0E) then
    begin
      Size := (OpCodeType + OpCodeSize);
      if (Size > OpCodeSize + 6) then
      begin
        Dec(Size, 7);
        if (OperSizeOver in Prefixes) then Dec(Size, 2);
      end;
    end
    else
    begin
      ModRM := Ptr^;
      Inc(Ptr);
      Size := (ModRMByte(Prefixes, OpCodeSize, OpCode, ModRM, Ptr^) + OpCodeSize + 1);
    end;
    Inc(Size, PrefixesSize);
  end;
end;

function GetFunctionSize(Addr, MaxSize: DWord): DWord;
var
  AsmSize: DWord;
  OpSize, OpCode: Byte;
  Pt, PtEnd: PChar;
begin
  Result := 1;

  if (MaxSize = 0) then
  begin
    Result := 0;
    Exit;
  end;

  try
    Pt := PChar(Addr);
    PtEnd := PChar(Pt + MaxSize - 1);
    AsmSize := 0;
    while (Pt <= PtEnd) do
    begin
      if (GetAsmSize(Pt, OpSize)) then
      begin
        // Skip the prefixes OpCodes...
        while ((PByte(Pt)^ in OpCodePrefixes) and (Pt <= PtEnd)) do Inc(Pt);

        OpCode := PByte(Pt)^;
        if (OpCode in OpCodeReturn) then
        begin
          Result := (AsmSize + OpSize);
          Exit;
        end;
      end
      else OpSize := 1;
      Inc(AsmSize, OpSize);
      Inc(Pt, OpSize);
    end;
  except
    Result := 0;
  end;
end;

function CalculateRelocatedAsmSize(Addr: Pointer; Size: Word): DWord;
var
  AsmSize: DWord;
  OpSize, OpCode: Byte;
  Pt, PtStart, PtEnd, JmpTo: PChar;
  Delta: Integer;
begin
  Pt := PChar(Addr);
  PtStart := Pt;
  PtEnd := PChar(Pt + Size - 1);
  Result := Size;
  AsmSize := 0;
  while (AsmSize < Size) do
  begin
    if (GetAsmSize(Pt, OpSize)) then
    begin
      // Skip the prefixes OpCodes...
      while ((PByte(Pt)^ in OpCodePrefixes) and (Pt <= PtEnd)) do Inc(Pt);

      OpCode := PByte(Pt)^;
      if (OpCode in OpCodeShortJump) then
      begin
        Delta := PShortInt(Pt + 1)^;
        JmpTo := (Pt + 2 + Delta);
        if ((JmpTo < PtStart) or (JmpTo > PtEnd + 1)) then Inc(Result, 5);
      end;
    end
    else OpSize := 1;
    Inc(AsmSize, OpSize);
    Inc(Pt, OpSize);
  end;
end;

procedure RelocateMemory(NewAddr, OldAddr: Pointer; Size: DWord);
var
  AsmSize: DWord;
  OpSize, OpCode, OpBytes: Byte;
  OldPt, Pt, PtStart, PtEnd, JmpTo, ShortJumpsPt: PChar;
  NewDistance, Distance, Delta: Integer;
begin
  OldPt := OldAddr;
  Pt := PChar(NewAddr);
  PtStart := Pt;
  PtEnd := PChar(Pt + Size - 1);
  ShortJumpsPt := (Pt + Size + SizeOf(TRedirectOpCodes));
  AsmSize := 0;
  while (AsmSize < Size) do
  begin
    if (GetAsmSize(Pt, OpSize)) then
    begin
      // Skip the prefixes OpCodes...
      while ((PByte(Pt)^ in OpCodePrefixes) and (Pt <= PtEnd)) do Inc(Pt);

      // Check for 2 bytes OpCode instructions...
      OpCode := PByte(Pt)^;
      if (OpCode = $0F) then // 2 bytes OpCode size
      begin
        Inc(Pt);
        OpCode := PByte(Pt)^;
        Dec(OpSize);
        OpBytes := 2;
      end
      else OpBytes := 1;

      // Search for relative Jump/Call instructions...
      if ((OpBytes = 1) and (OpCode in OpCodeShortJump)) then
      begin
        Distance := PShortInt(Pt + 1)^;
        JmpTo := (Pt + 2 + Distance);

        // Check if need relocation...
        if (JmpTo < PtStart) or (JmpTo > (PtEnd + 1)) then
        begin
          JmpTo := (OldPt + Integer(AsmSize) + OpSize + Distance);
          JumpToMem(ShortJumpsPt, JmpTo);
          Distance := (ShortJumpsPt - (Pt + 2));
          WriteMem((Pt + 1), Distance, 1);
          Inc(ShortJumpsPt, SizeOf(TRedirectOpCodes));
        end;
      end
      else
        if ((OpBytes = 1) and (OpCode in OpCodeLongJump1Byte)) or
          ((OpBytes = 2) and (OpCode in OpCodeLongJump2Bytes)) then
        begin
          Distance := PInteger(Pt + 1)^;
          JmpTo := (Pt + 5 + Distance);

          // Check if need relocation...
          if (JmpTo < PtStart) or (JmpTo > (PtEnd + 1)) then
          begin
            Delta := (OldPt + Integer(AsmSize) - Pt + (OpBytes - 1));
            NewDistance := (Distance + Delta);
            WriteMem(Pt + 1, NewDistance, 4);
          end;
        end;
    end
    else OpSize := 1;
    Inc(AsmSize, OpSize);
    Inc(Pt, OpSize);
  end;
end;

function HookProcedure(ProcAddr, NewProc: Pointer): Pointer;
var
  PProc, Pt, PAsm: PChar;
  AsmSize, FullAsmSize, OldProtectionCode: DWord;
  OpSize: Byte;
  n: Integer;
  PHookedBlock: PHookedProcedure;
begin
  for n := 0 to HookedProcedures.Count - 1 do
  begin
    PHookedBlock := PHookedProcedure(HookedProcedures[n]);
    if (ProcAddr = PHookedBlock^.OriginalProc) then
    begin
      Result := PHookedBlock^.HookedBlockPt;
      Exit;
    end;
  end;

  PProc := ProcAddr;
  Pt := PProc;
  AsmSize := 0;
  repeat
    if (not (GetAsmSize(Pt, OpSize))) then OpSize := 1;
    Inc(AsmSize, OpSize);
    Inc(Pt, OpSize);
  until (AsmSize >= 5);
  FullAsmSize := (CalculateRelocatedAsmSize(PProc, AsmSize) + SizeOf(TRedirectOpCodes));
  GetMem(PAsm, FullAsmSize);

  // Save hooked data...
  New(PHookedBlock);
  PHookedBlock^.OriginalProc := ProcAddr;
  PHookedBlock^.HookedBlockPt := PAsm;
  PHookedBlock^.HookedBlockSize := FullAsmSize;
  PHookedBlock^.POriginalAsmSize := AsmSize;
  GetMem(PHookedBlock^.POriginalAsmPt, AsmSize);
  Move(PProc^, PHookedBlock^.POriginalAsmPt^, AsmSize);
  HookedProcedures.Add(PHookedBlock);

  // Transform this data-block into executable code-block.
  VirtualProtect(PAsm, FullAsmSize, PAGE_EXECUTE_READWRITE, @OldProtectionCode);

  // Copy first ASM instructions from Procedure to Hook block...
  Move(PProc^, PAsm^, AsmSize);

  RelocateMemory(PAsm, PProc, AsmSize);

  JumpToMem((PAsm + AsmSize), (PProc + AsmSize)); // JMP from Hook block to Procedure...
  JumpToMem(PProc, NewProc); // JMP from Procedure to Hook block...

  Result := PAsm;
end;

function HookProcedureEx(ProcAddr, NewProc: Pointer; ProcName: string): Pointer;
begin
  ProcAddr := Pointer(ConvertAddress(DWord(ProcAddr)));
  NewProc := Pointer(ConvertAddress(DWord(NewProc)));

  if (ProcAddr = nil) then
    raise EProcNull.CreateFmt(EProcNullStr, [ProcName])
  else
    if (DWord(ProcAddr) > SharedMem) and // Shared Area...
      (Win32Platform <> VER_PLATFORM_WIN32_NT) then // Win9X/ME ...
      raise ESharedArea.CreateFmt(ESharedAreaStr,
        [ModuleFileName(FindHInstance(ProcAddr))]);

  try
    Result := HookProcedure(ProcAddr, NewProc);
  except
    raise EHookingError.CreateFmt(EHookingErrorStr, [ProcName]);
  end;
end;

function UnhookProcedure(ProcAddr: Pointer): Boolean;
var
  n: Integer;
  PHookedBlock: PHookedProcedure;
begin
  Result := False;
  n := 0;
  while (n <= HookedProcedures.Count - 1) do
  begin
    PHookedBlock := PHookedProcedure(HookedProcedures[n]);
    if (ProcAddr = PHookedBlock^.OriginalProc) then
    begin
      WriteMem(PHookedBlock^.OriginalProc, PHookedBlock^.POriginalAsmPt^, PHookedBlock^.POriginalAsmSize);
      FreeMem(PHookedBlock^.POriginalAsmPt, PHookedBlock^.POriginalAsmSize);
      FreeMem(PHookedBlock^.HookedBlockPt, PHookedBlock^.HookedBlockSize);
      FreeMem(PHookedBlock, SizeOf(THookedProcedure));
      HookedProcedures.Delete(n);
      Result := True;
    end;
    Inc(n);
  end;
end;

function HookDllProcedure(ImportModule: THandle; ExportModule: string; OldProc, NewProc: Pointer;
  ProcName: string; CanFail, Unhook: Boolean): Pointer;
var
  FromProcDebugThunk, ImportThunk: PWin9xDebugThunk;
  IsThunked, FoundProc: Boolean;
  NtHeader: PImageNtHeaders;
  ImportDir: TImageDataDirectory;
  ImportDesc: PImageImportDescriptor;
  CurrName: PChar;
  ImportEntry: PImageThunkData;
  Base: Pointer;
  SaveDLLProc: PSaveDLLProc;

  function IsWin9xDebugThunk(P: Pointer): Boolean;
  begin
    with PWin9xDebugThunk(P)^ do
      Result := (PUSH = $68) and (JMP = $E9);
  end;

  // Mapped or loaded image related functions
  function PeMapImgNtHeaders(const BaseAddress: Pointer): PImageNtHeaders;
  begin
    Result := nil;
    if (not IsValidBlockAddr(DWord(BaseAddress), SizeOf(TImageDosHeader))) then Exit;

    if (PImageDosHeader(BaseAddress)^.e_magic <> IMAGE_DOS_SIGNATURE) or
      (PImageDosHeader(BaseAddress)^._lfanew = 0) then Exit;

    Result := PImageNtHeaders(DWORD(BaseAddress) + DWORD(PImageDosHeader(BaseAddress)^._lfanew));
    if (not IsValidBlockAddr(DWord(Result), SizeOf(TImageNtHeaders))) or
      (Result^.Signature <> IMAGE_NT_SIGNATURE) then Result := nil
  end;

  procedure CheckFail;
  begin
    if (not CanFail) then
      raise EHookingError.CreateFmt(EHookingErrorStr, [ProcName]);
  end;

begin
  Result := nil;

  if (OldProc = nil) then
    raise EProcNull.CreateFmt(EProcNullStr, [ProcName]);

  if (ImportModule > SharedMem) and // Shared Area...
    (Win32Platform <> VER_PLATFORM_WIN32_NT) then // Win9X/ME ...
    raise ESharedArea.CreateFmt(ESharedAreaStr, [ModuleFileName(ImportModule)]);

  Base := Pointer(ImportModule);
  FromProcDebugThunk := PWin9xDebugThunk(OldProc);
  IsThunked := (Win32Platform <> VER_PLATFORM_WIN32_NT) and IsWin9xDebugThunk(FromProcDebugThunk);
  NtHeader := PeMapImgNtHeaders(Base);
  if (NtHeader = nil) then
  begin
    CheckFail;
    Exit;
  end;

  ImportDir := NtHeader.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_IMPORT];
  if (ImportDir.VirtualAddress = 0) then
  begin
    CheckFail;
    Exit;
  end;

  ImportDesc := PImageImportDescriptor(DWORD(Base) + ImportDir.VirtualAddress);
  while (ImportDesc^.Name <> 0) do
  begin
    CurrName := (PChar(Base) + ImportDesc^.Name);
    if (StrIComp(CurrName, PChar(ExportModule)) = 0) then
    begin
      ImportEntry := PImageThunkData(DWORD(Base) + ImportDesc^.FirstThunk);
      while (ImportEntry^.Function_ <> 0) do
      begin
        if IsThunked then
        begin
          ImportThunk := PWin9xDebugThunk(ImportEntry^.Function_);
          FoundProc := IsWin9xDebugThunk(ImportThunk) and
            (ImportThunk^.Addr = FromProcDebugThunk^.Addr);
        end
        else
          FoundProc := Pointer(ImportEntry^.Function_) = OldProc;
        if FoundProc then
        begin
          WriteMem(@ImportEntry^.Function_, NewProc, 4);
          if (not Unhook) then
          begin
            New(SaveDLLProc);
            SaveDLLProc^.OldProc := OldProc;
            SaveDLLProc^.NewProc := NewProc;
            SaveDLLProc^.HookModule := ImportModule;
            SaveDLLProc^.ExportModule := ExportModule;
            DllList.Add(SaveDLLProc);
          end;
          Result := OldProc;
        end;
        Inc(ImportEntry);
      end;
    end;
    Inc(ImportDesc);
  end;

  if (not CanFail) and (Result = nil) then
    raise EHookingError.CreateFmt(EHookingErrorStr, [ProcName]);
end;

function TryHookDllProcedureEx(ImportModules: array of string;
  ExportModule, ProcName: string; NewProc: Pointer;
  var CallProc: Pointer; CanFail: Boolean): Boolean;
var
  TmpProc, OldProc: Pointer;
  HModule: THandle;
  n: integer;
begin
  Result := False;
  OldProc := GetProcAddress(GetModuleHandle(PChar(ExportModule)), PChar(ProcName));

  for n := low(ImportModules) to high(ImportModules) do
  begin
    HModule := GetModuleHandle(PChar(ImportModules[n]));
    if (HModule <> 0) then
    begin
      TmpProc := HookDllProcedure(HModule, ExportModule, OldProc, NewProc,
        ExportModule + '.' + ProcName, CanFail, False);
      Result := (Result) or (TmpProc <> nil);
    end;
  end;

  CallProc := OldProc; // WARNING don't move to HERE!!!
end;

function HookDllProcedureEx(ImportModule, ExportModule, ProcName: string;
  NewProc: Pointer): Pointer;
var
  OldProc: Pointer;
begin
  OldProc := GetProcAddress(GetModuleHandle(PChar(ExportModule)), PChar(ProcName));

  Result := HookDllProcedure(GetModuleHandle(PChar(ImportModule)), ExportModule,
    OldProc, NewProc, ExportModule + '.' + ProcName, False, False);
end;

//------------------------------------------------------------------------------

procedure Init;
begin
  DllList := TList.Create;
  HookedMethodsList := THookedMethodsList.Create;
  HookedProcedures := TList.Create;
end;

procedure Done;
var
  n: Integer;
  P: PSaveDLLProc;
  PHookedBlock: PHookedProcedure;
begin
  for n := 0 to DllList.Count - 1 do
  begin
    P := PSaveDLLProc(DllList[n]);
    HookDLLProcedure(P^.HookModule, P^.ExportModule, P^.NewProc, P^.OldProc, '', True, True);
    Dispose(P);
  end;
  DllList.Free;
  DllList := nil;
  HookedMethodsList.Free;
  HookedMethodsList := nil;
  for n := HookedProcedures.Count - 1 downto 0 do
  begin
    PHookedBlock := HookedProcedures[n];
    UnhookProcedure(PHookedBlock^.OriginalProc);
  end;
  HookedProcedures.Free;
  HookedProcedures := nil;
end;

//------------------------------------------------------------------------------

initialization
  SafeExec(Init, 'EHook.Init');

finalization
  SafeExec(Done, 'EHook.Done');

end.

