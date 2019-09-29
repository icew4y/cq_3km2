{************************************************}
{                                                }
{               EurekaLog v 6.x                  }
{          Memory Leaks Unit - ELeaks            }
{                                                }
{  Copyright (c) 2001 - 2007 by Fabio Dell'Aria  }
{                                                }
{************************************************}

unit ELeaks;

{$I Exceptions.inc}

{$W+} // Enable Stack-Frames generation.
{$O+} // Enable Optimization.

interface

uses
  Windows;

const
  RawCallStackLength    = 35;
  FramesCallStackLength = 35;

type
  TCallStackItem   = DWord;
  TRawCallStack    = array [0..RawCallStackLength - 1] of TCallStackItem;
  TFramesCallStack = array [0..FramesCallStackLength - 1] of TCallStackItem;

var
  // Wrong Block routines...
  OverrunProc, MultiFreeProc: procedure;

  // Finalization routine...
  FinalizationProc: procedure;

  // Leaks routines...
  ResetLeaks, ShowLeaks: procedure;
  AddLeak: procedure(const LeakType: string; LeakSize, LeakCount: DWord;
    LeakCallStack: TRawCallStack);

implementation

const
  MagicCodeValue6 = $100FAB10;
  MagicCodeValue5 = $000FAB10;

  MaxLeaks = 1024;

type
  // Memory Pages State.
  // In Win 32 a Memory Page Size = 4096 bytes...
  TPageState = (bsUnknown, bsReadable, bsUnreadable);

  // Max of 4 Gb RAM = (1024 * 1024) Memory Pages...
  TMemoryPages = array [0..1024*1024-1] of TPageState;
  PMemoryPages = ^ TMemoryPages;

  TLeakError = (leNone, leOverrun, leMultiFree);

  TLeaksOption = (loCatchLeaks, loGroupsSonLeaks, loHideBorlandLeaks,
    loFreeAllLeaks, loCatchLeaksExceptions);

  TLeaksOptions = set of TLeaksOption;

  TBlockType  = (btData, btObject);

  TBlockState = (bsAllocated, bsReleased, bsRemoved);

  PPointerRecord = ^ TPointerRecord;
  TPointerRecord = record
    Prev, Next     : PPointerRecord;   // Next and Previous Block.
    BlockState     : TBlockState;
    BlockType      : TBlockType;
    Size           : DWord;
    RawCallStack   : TRawCallStack;
    FramesCallStack: TFramesCallStack;
    MagicCode      : DWord;            // Must to be the LAST field!
  end;

  PPointerFooter = ^ TPointerFooter;
  TPointerFooter = record
    MagicCode: DWord; // Must to be the FIRST field!
  end;

var
  OldMemoryManager : TMemoryManager;
  AllocatedList_Lock: Boolean;
  AllocatedList_Start, AllocatedList_End: PPointerRecord;
  TObjectCreate, TObjectNewInstance: Pointer;
  IsMemoryManagerOwner: Boolean;
  MMWindow: THandle;

  InstallNewMemoryManager: Boolean;
  UseNewMemoryManager    : Boolean;

  LeaksOptions: TLeaksOptions;

  BlockOverHead: Integer = SizeOf(TPointerRecord);
  BlockOverFoot: Integer = SizeOf(TPointerFooter);

  MemoryPages: PMemoryPages;

// -----------------------------
// INTERNAL PROFILER VARIABLES |
// -----------------------------
{.$DEFINE LEAK_PROFILER} // Use to show the internal execution time.
{$IFDEF LEAK_PROFILER}
  mSecPurge0, mSecPurge1, mSecPurge2,
  mSec0, mSec1, mSec2, mSec3, mSec4, mSec5, mSec6, mSecTotal: DWord;
{$ENDIF}

const
  MessageBoxFlags =
    (MB_OK or MB_ICONWARNING or MB_TOPMOST or MB_TASKMODAL or MB_SERVICE_NOTIFICATION);

//------------------------------------------------------------------------------
// String routines...
//------------------------------------------------------------------------------

function UpperCase(const S: string): string;
var
  Ch: Char;
  L: Integer;
  Source, Dest: PChar;
begin
  L := Length(S);
  SetLength(Result, L);
  Source := Pointer(S);
  Dest := Pointer(Result);
  while L <> 0 do
  begin
    Ch := Source^;
    if (Ch >= 'a') and (Ch <= 'z') then Dec(Ch, 32);
    Dest^ := Ch;
    Inc(Source);
    Inc(Dest);
    Dec(L);
  end;
end;

function ExtractFileName(const FileName: string): string;
var
  n: Integer;
begin
  for n := Length(FileName) downto 1 do
    if (FileName[n] = '\') then
    begin
      Result := Copy(FileName, n + 1, MaxInt);
      Exit;
    end;

  Result := FileName;
end;

//------------------------------------------------------------------------------
// Utility routines...
//------------------------------------------------------------------------------

function IsObjectCreation: Boolean;
asm
  CMP  EBP, 0 // No stack frames...
  JE   @@No

{$IFDEF Delphi5Down}
  MOV  EAX, [EBP + 8]
  SUB  EAX, 9
  MOV  EDX, TObjectNewInstance
  CMP  EAX, EDX
  JE   @@Yes
{$ELSE}
  {$IFDEF Delphi10Up}
    MOV  EAX, [EBP + 8]
    SUB  EAX, 15
    CMP  EAX, TObjectNewInstance
    JE   @@Yes
  {$ELSE}
    MOV  EAX, [EBP + 12]
    SUB  EAX, 15
    CMP  EAX, TObjectNewInstance
    JE   @@Yes
    MOV  EAX, [EBP + 16]
    SUB  EAX, 15
    CMP  EAX, TObjectNewInstance
    JE   @@Yes
  {$ENDIF}
{$ENDIF}

@@No:
  MOV  EAX, False
  RET

@@Yes:
  MOV  EAX, True
end;

function CallerOfReallocMem: DWord;
asm
  CMP  EBP, 0 // No stack frames...
  JE   @@SetToNil

  MOV  EAX, EBP
  ADD  EAX, 12
  RET

@@SetToNil:
  MOV  EAX, 0 {nil}
end;

(* function CallerOfFreeMem: Pointer;
asm
  CMP  EBP, 0 // No ctack frames...
  JE   @@SetToNil

  MOV  EAX, [EBP]
{$IFDEF Delphi5Down}
  MOV  EAX, [EAX + 8]
{$ELSE}
  {$IFDEF Delphi10Up}
    MOV  EAX, [EAX + 8]
  {$ELSE}
    MOV  EAX, [EAX + 12]
  {$ENDIF}
{$ENDIF}
  RET

@@SetToNil:
  MOV  EAX, 0 {nil}
end; *)

function GetReadableSize(Address, Size: DWord): DWord;
const
  ReadAttributes = [PAGE_READONLY, PAGE_READWRITE, PAGE_WRITECOPY, PAGE_EXECUTE,
    PAGE_EXECUTE_READ, PAGE_EXECUTE_READWRITE, PAGE_EXECUTE_WRITECOPY];
var
  MemInfo: TMemoryBasicInformation;
  Tmp: DWord;
begin
  Result := 0;
  if (VirtualQuery(Pointer(Address), MemInfo, SizeOf(MemInfo)) = SizeOf(MemInfo)) and
    (MemInfo.State = MEM_COMMIT) and (MemInfo.Protect in ReadAttributes) then
  begin
    Result := (MemInfo.RegionSize - (Address - DWord(MemInfo.BaseAddress)));
    if (Result < Size) then
    begin
      repeat
        Tmp := GetReadableSize((DWord(MemInfo.BaseAddress) + MemInfo.RegionSize), (Size - Result));
        if (Tmp > 0) then Inc(Result, Tmp)
        else Result := 0;
      until (Result >= Size) or (Tmp = 0);
    end;
  end;
end;

function IsValidBlockAddr(Address, Size: DWord): Boolean;
var
  PageStart, PageEnd: DWord;
begin
  PageStart := (Address shr 12);
  PageEnd := ((Address + Size - 1) shr 12);
  if ((MemoryPages <> nil) and (PageStart = PageEnd)) then
  begin
    // Check if the Page state is just in Cache...
    if (MemoryPages^[PageStart] <> bsUnknown) then
    begin
      Result := (MemoryPages^[PageStart] = bsReadable);
      if (Result) then
      try
        // Read the first byte,
        // to check the Page Status validity...
        asm
          MOV  EAX, [Address]
          MOV  AL,  [EAX]
        end;
      except
        MemoryPages^[PageStart] := bsUnreadable;
      end;
    end
    else
    begin
      Result := (GetReadableSize(Address, Size) >= Size);
      if (Result) then MemoryPages^[PageStart] := bsReadable
      else MemoryPages^[PageStart] := bsUnreadable;
    end;
  end
  else
  Result := (GetReadableSize(Address, Size) >= Size);
end;

function IsValidClass(ClassType: TClass): Boolean;
begin
  Result :=
    // Valid pointer...
    (ClassType <> nil) and
    // Valid ClassName pointer...
    (IsValidBlockAddr(DWord(ClassType), 4)) and
    // Readable ClassName size...
    (IsValidBlockAddr(PDWord(Integer(ClassType) + vmtClassName)^, 1)) and
    // Valid ClassName value...
    (IsValidBlockAddr(PDWord(Integer(ClassType) + vmtClassName)^ + 1,
      PByte(Integer(ClassType) + vmtClassName)^));
end;

{function IsValidObject(Obj: TObject): Boolean;
begin
  Result :=
    // Valid pointer...
    (Obj <> nil) and (IsValidBlockAddr(DWord(Obj), 4)) and
    // Valid Class pointer...
    (IsValidClass(TClass(PDWord(Obj)^)));
end;}

function IsAParentClassStr(ClassPtr: TClass; const Parent: string): Boolean;
begin
  Result := False;
  while (ClassPtr <> nil) and (not Result) do
  begin
    if (not IsValidClass(ClassPtr)) then Exit;

    Result := (UpperCase(ClassPtr.ClassName) = UpperCase(Parent));
    if (not Result) then ClassPtr := ClassPtr.ClassParent;
  end;
end;

function ConvertAddress(Addr: Pointer): Pointer;
type
  TJMPCode = packed record
    JMPOpCode: Word;
    JMPPtr: ^Pointer;
    MOVOpCode: Word;
  end;
  PJMPCode = ^TJMPCode;
var
  JMP: PJMPCode;
begin
  Result := Addr;
  if (IsValidBlockAddr(DWord(Addr), 8)) then
  begin
    JMP := PJMPCode(Addr);
    if (JMP^.JMPOpCode = $25FF) and (IsValidBlockAddr(DWord(JMP^.JMPPtr), 4)) then
      Result := JMP^.JMPPtr^;
  end;
end;

//------------------------------------------------------------------------------
// Thread safe data routines...
//------------------------------------------------------------------------------

{$W-}

procedure LockVariable(var Variable: Boolean);

  function LockCheck(var Variable: Boolean): Boolean;
  asm
    MOV  ECX, EAX // EAX = @Variable
    MOV  AL,  False
    MOV  DL,  True
  {$IFDEF Delphi3} // Due a Delphi3 ASM compiled BUG!!!
    DB $F0, $0F, $B0, $11
  {$ELSE}
    LOCK CMPXCHG [ECX], DL
  {$ENDIF}
  end;

begin
  while LockCheck(Variable) do
  begin
    Sleep(0);
    if (not LockCheck(Variable)) then Break;
    Sleep(10);
  end;
end;

procedure UnlockVariable(var Variable: Boolean);
begin
  Variable := False;
end;

{$W+}

//------------------------------------------------------------------------------
// Call Stack routines...
//------------------------------------------------------------------------------

procedure GetFramesCallStackDump(var StackList: TFramesCallStack);
type
  PStackFrame = ^TStackFrame;
  TStackFrame = packed record
    Next: PStackFrame;
    Call: DWord;
  end;
var
  TopOfStack, BaseOfStack: DWord;
  Idx: Integer;
  StackFrame: PStackFrame;
begin
  asm
    MOV  StackFrame, EBP
    MOV  BaseOfStack, EBP
    MOV  EAX, FS:[4]
    MOV  TopOfStack, EAX
  end;

  // Skip first 3 levels...
  StackFrame := StackFrame^.Next;
  StackFrame := StackFrame^.Next;
  StackFrame := StackFrame^.Next;

  // Save StackFrames Call Stack...
  for Idx := 0 to (FramesCallStackLength - 1) do
  begin
    if ((DWord(StackFrame) <= BaseOfStack) or (DWord(StackFrame) >= TopOfStack)) then
    begin
      FillChar(StackList[Idx], SizeOf(TCallStackItem) * (FramesCallStackLength - Idx), #0);
      Break;
    end;

    BaseOfStack    := DWord(StackFrame);
    StackList[Idx] := StackFrame^.Call;
    StackFrame     := StackFrame^.Next;
  end;
end;

{$W-}

procedure GetRawCallStackDump(var StackList: TRawCallStack; FirstAddr: DWord);
begin
  if (FirstAddr = 0) then
  begin
    FillChar(StackList, SizeOf(StackList), #0);
    Exit;
  end;

  StackList[0] := PDWord(FirstAddr)^;
  Move(Pointer(FirstAddr + 4)^, StackList[1], SizeOf(TRawCallStack) - SizeOf(TCallStackItem));
end;

{$W+}

procedure PurgeCallStack(StackList: PDWord; Items: DWord);
type
  Codes = array[0..6] of byte;
  PCodes = ^Codes;
var
  // Current Stack Item...
  Idx: Integer;
  // Pointer of first intruction's code to disassembler...
  PointAddr: DWord;
  // Address pointer to ASM "CALL" instruction...
  CalledAddr: DWord;
  // Relative jump size for ASM "CALL" instruction...
  RelativeJump: Integer;
  // Array of instruction's codes...
  Code: PCodes;
  // Check the validity iof current Stack item...
  OKValue: Boolean;
  // CallStack useful Last Index (= useful size - 1)...
  UsefulLastIdx: Integer;

  PStart: Pointer;
begin
  PStart := StackList;

  for Idx := 0 to (Items - 1) do
  begin
    OKValue := False;
    PointAddr := (StackList^ - SizeOf(Codes));
    if (IsValidBlockAddr(PointAddr, SizeOf(Codes))) then
    begin
      Code := PCodes(PointAddr);

      // CALL ????????
      // E8 XX XX XX XX
      // Relative jump (+-32bit)
      if Code^[2] = $E8 then
      begin
        Move(Code^[3], RelativeJump, 4);
        CalledAddr := Round((StackList^ - 7) + 2) + RelativeJump + 5;
        if (IsValidBlockAddr(CalledAddr, 1)) then
        begin
          Dec(StackList^, 5);
          OkValue := True;
        end;
      end
      else
        if (Code^[5] = $FF) and
          (Code^[6] >= $D0) and (Code^[6] <= $D7) then
        begin
          Dec(StackList^, 2);
          OkValue := True;
        end
        else
          if (Code^[5] = $FF) and
            (Code^[6] in [$10, $11, $12, $13, $16, $17]) then
          begin
            Dec(StackList^, 2);
            OkValue := True;
          end
          else
            if (Code^[4] = $FF) and
              (Code^[5] in [$50, $51, $52, $53, $55, $56, $57]) then
            begin
              Dec(StackList^, 3);
              OkValue := True;
            end
            else
              if (Code^[1] = $FF) and
                (Code^[2] in [$90, $91, $92, $93, $95, $96, $97]) then
              begin
                Dec(StackList^, 6);
                OkValue := True;
              end
              else
                if (Code^[4] = $FF) and
                  (Code^[5] = $14) and (Code^[6] = $24) then
                begin
                  Dec(StackList^, 3);
                  OkValue := True;
                end
                else
                  if (Code^[3] = $FF) and
                    (Code^[4] = $54) and (Code^[5] = $24) then
                  begin
                    Dec(StackList^, 4);
                    OkValue := True;
                  end
                  else
                    if (Code^[0] = $FF) and
                      (Code^[1] = $94) and (Code^[2] = $24) then
                    begin
                      Dec(StackList^, 7);
                      OkValue := True;
                    end
                    else
                      if (Code^[1] = $FF) and (Code^[2] = $15) then
                      begin
                        Move(Code^[3], RelativeJump, 4);
                        if (IsValidBlockAddr(RelativeJump, 4)) then
                        begin
                          Dec(StackList^, 6);
                          OkValue := True;
                        end;
                      end;
    end;
    // Set as invalid item...
    if (not OKValue) then StackList^ := 0;
    
    Inc(StackList);
  end;

  // Removed invalid items...
  StackList := PStart;
  Idx := 0;
  UsefulLastIdx := (Items - 1);
  while (Idx <= (UsefulLastIdx - 1)) do
  begin
    if (StackList^ = 0) then
    begin
      Move(PDWord(DWord(StackList) + 4)^, StackList^, ((UsefulLastIdx - Idx) * 4));
      PDWord(DWord(PStart) + DWord(UsefulLastIdx) * 4)^ := 0;
      Dec(UsefulLastIdx);
    end
    else
    begin
      Inc(Idx);
      Inc(StackList);
    end;
  end;
end;

//------------------------------------------------------------------------------
// Memory manager routines...
//------------------------------------------------------------------------------

{$W-}

procedure SetOurPointer(var P: Pointer; Size: Integer; BlockType: TBlockType; FirstAddr: DWord);
var
  Ptr: PPointerRecord;
  PFoot: PPointerFooter;
begin
  if (P = nil) then Exit;

  // Get Ptr pointer...
  Ptr := PPointerRecord(P);

  // Set OverHead data...
  Ptr^.BlockState := bsAllocated;
  Ptr^.BlockType := BlockType;
  Ptr^.Size := (Size - BlockOverHead - BlockOverFoot);
  GetRawCallStackDump(Ptr^.RawCallStack, FirstAddr);
  GetFramesCallStackDump(Ptr^.FramesCallStack);
  Ptr^.MagicCode := MagicCodeValue6;

  // Set OverFoot data...
  PFoot := PPointerFooter(PChar(Ptr) + Size - BlockOverFoot);
  PFoot^.MagicCode := MagicCodeValue6;

  // Move the P pointer to skip the OverHead block...
  Inc(PChar(P), BlockOverHead);

  // Add Ptr to the allocation list...
  LockVariable(AllocatedList_Lock);

    if (AllocatedList_End <> nil) then
    begin
      Ptr^.Prev := AllocatedList_End;
      Ptr.Next := nil;
      AllocatedList_End^.Next := Ptr;
      AllocatedList_End := Ptr;
    end
    else
    begin
      AllocatedList_Start := Ptr;
      AllocatedList_End := Ptr;
      Ptr.Prev := nil;
      Ptr.Next := nil;
    end;

  UnlockVariable(AllocatedList_Lock);
end;

function CheckOurPointer(var P: Pointer; ClearData: Boolean;
  var Error: TLeakError): Boolean;
var
  Ptr: PPointerRecord;
  PFoot: PPointerFooter;
  Overrun, MultiFree: Boolean;
begin
  Error := leNone;
  Result := False;
  if (P = nil) then Exit;

  // Get Ptr pointer...
  Ptr := PPointerRecord(PChar(P) - BlockOverHead);
  Result := (Ptr^.MagicCode = MagicCodeValue6);

  // Is our pointer ? ...
  if (Result) then
  begin
    Overrun := False;

    // Check for MultiFree...
    MultiFree := (Ptr^.BlockState = bsReleased);

    if (not MultiFree) then
    begin
      // Set the block as Released...
      Ptr^.BlockState := bsReleased;

      // Check for Overrun...
      PFoot := PPointerFooter(PChar(Ptr) + Ptr^.Size + BlockOverHead);
      Overrun := (PFoot^.MagicCode <> MagicCodeValue6);

      // Remove Ptr from the allocation list...
      LockVariable(AllocatedList_Lock);

        Ptr^.BlockState := bsReleased;
        if (Ptr^.Prev <> nil) then Ptr^.Prev^.Next := Ptr^.Next;
        if (Ptr^.Next <> nil) then Ptr^.Next^.Prev := Ptr^.Prev;

        if (AllocatedList_Start = Ptr) then AllocatedList_Start := Ptr^.Next;
        if (AllocatedList_End = Ptr) then AllocatedList_End := Ptr^.Prev;

      UnlockVariable(AllocatedList_Lock);

      // Clear Data to invalidate data after its free...
      // TODO: ...
//      if (ClearData) then FillChar(P^, Ptr^.Size, #0);
    end;

    // Move the P pointer to its original location...
    Dec(PChar(P), BlockOverhead);

    // Call wrong block routines...
    if (loCatchLeaksExceptions in LeaksOptions) then
    begin
      if (Overrun) then Error := leOverrun;
      if (MultiFree) then Error := leMultiFree
    end;
  end;
end;

procedure HandleError(Error: TLeakError);
begin
  if (Error = leOverrun) and (Assigned(OverrunProc)) then OverrunProc
  else
    if (Error = leMultiFree) and (Assigned(MultiFreeProc)) then MultiFreeProc;
end;

{$W+}

//------------------------------------------------------------------------------

function NewGetMem(Size: Integer): Pointer;

  function GetDataCaller: DWord;
  asm
    CMP  EBP, 0 // No ctack frames...
    JE   @@SetToNil

    MOV  EAX, EBP

  {$IFDEF Delphi10}
    ADD  EAX, 8
  {$ENDIF}
  {$IFDEF Delphi9}
    ADD  EAX, 12
  {$ENDIF}
  {$IFDEF Delphi7}
    ADD  EAX, 16
  {$ENDIF}
  {$IFDEF Delphi6}
    ADD  EAX, 12
  {$ENDIF}
  {$IFDEF Delphi5}
    ADD  EAX, 8
  {$ENDIF}
  {$IFDEF Delphi4}
    ADD  EAX, 8
  {$ENDIF}
  {$IFDEF Delphi3}
    ADD  EAX, 8
  {$ENDIF}
    RET

  @@SetToNil:
    MOV  EAX, 0 {nil}
  end;

  function GetObjectCaller: DWord;
  asm
    CALL GetDataCaller
    ADD  EAX, 44
  end;

begin
  if (UseNewMemoryManager) then
  begin
    // Increased the size to store the BlockOverhead...
    Inc(Size, BlockOverhead + BlockOverFoot);

    // Get the memory...
    Result := OldMemoryManager.GetMem(Size);

    if IsObjectCreation() then
      SetOurPointer(Result, Size, btObject, GetObjectCaller)
    else
      SetOurPointer(Result, Size, btData, GetDataCaller);
  end
  else
    Result := OldMemoryManager.GetMem(Size);
end;

function NewFreeMem(P: Pointer): Integer;
var
  Error: TLeakError;
begin
  CheckOurPointer(P, True, Error);

  // Free the memory...
  Result := OldMemoryManager.FreeMem(P);

  HandleError(Error);
end;

function NewReallocMem(P: Pointer; Size: Integer): Pointer;
var
  Error: TLeakError;
begin
  CheckOurPointer(P, False, Error);

  if ((P <> nil) and (UseNewMemoryManager)) then
    Inc(Size, BlockOverhead + BlockOverFoot);

  // Realloc the memory...
  Result := OldMemoryManager.ReallocMem(P, Size);

  if (UseNewMemoryManager) then
    SetOurPointer(Result, Size, btData, CallerOfReallocMem);

  HandleError(Error);    
end;

//------------------------------------------------------------------------------
// Leaks utility routines...
//------------------------------------------------------------------------------

function FindNextValidLeak(P: PPointerRecord): PPointerRecord;
begin
  Result := P;
  while (Result <> nil) and (Result^.BlockState = bsRemoved) do
    Result := Result^.Next;
end;

function IsALeakChild(PFather, PSon: PPointerRecord): Boolean;
var
  n: Integer;
begin
  for n := 1 to (RawCallStackLength - 2) do
  begin
    Result := (PFather^.RawCallStack[0] = PSon^.RawCallStack[n]) and
      (PFather^.RawCallStack[1] = PSon^.RawCallStack[n + 1]);
    if (Result) Then Exit;
  end;
  if (not Result) and (PFather^.RawCallStack[0] = PFather^.FramesCallStack[0]) then
    for n := 1 to (FramesCallStackLength - 2) do
    begin
      Result := (PFather^.FramesCallStack[0] = PSon^.FramesCallStack[n]) and
        (PFather^.FramesCallStack[1] = PSon^.FramesCallStack[n + 1]);
      if (Result) Then Exit;
    end;
end;

function AreTheSameLeak(P1, P2: PPointerRecord): Boolean;
begin
  Result := False;
  if (P1 = nil) or (P2 = nil) then Exit;

  Result := (P1^.RawCallStack[0] = P2^.RawCallStack[0]) and (P1^.Size = P2^.Size);
end;

procedure FindLeakSons(PFather: PPointerRecord);
var
  PNext, PSon: PPointerRecord;
begin
  if (PFather^.BlockType <> btObject) then Exit;

  PSon := FindNextValidLeak(PFather^.Next);
  while (PSon <> nil) do
  begin
    if (IsALeakChild(PFather, PSon)) then
    begin
      PNext := FindNextValidLeak(PSon^.Next);
      FindLeakSons(PSon);
      Inc(PFather^.Size, PSon^.Size);
      PSon^.BlockState := bsRemoved;
      PSon := PNext;
    end
    else PSon := FindNextValidLeak(PSon^.Next);
  end;
end;

procedure GetLeakCount(Ptr: PPointerRecord);
var
  FirstPtr: PPointerRecord;
  Size, Count: DWord;
begin
  Count := 1;
  Size := Ptr^.Size;
  FirstPtr := Ptr;
  repeat
    Ptr := FindNextValidLeak(Ptr^.Next);
    if (AreTheSameLeak(FirstPtr, Ptr)) then
    begin
      Ptr^.BlockState := bsRemoved;
      Inc(Count);
      Inc(Size, Ptr^.Size);
    end;
  until (Ptr = nil);
  FirstPtr^.Size := Size;
  FirstPtr^.MagicCode := Count;
end;

function FindLeakAddress(Ptr: PPointerRecord): Pointer;
type
  TLongObjectCreate = packed record
    MovDL_OpCode, MovDL_Val: Byte; // B2, 01
    MovEAX_OpCode: Byte;           // A1
    MovEAX_ClassType: ^Pointer;
    Call_OpCode: Byte;             // E8
    Call_ClassCreate: DWord;
  end;
  PLongObjectCreate = ^TLongObjectCreate;

  TShortObjectCreate = packed record
    MovDL_OpCode, MovDL_Val: Byte; // B2, 01
    Call_OpCode: Byte;             // E8
    Call_ClassCreate: DWord;
  end;
  PShortObjectCreate = ^TShortObjectCreate;
var
  Obj: TObject;
  ClassCreatePtr: Pointer;
  PLongCall: PLongObjectCreate;
  PShortCall: PShortObjectCreate;
  n: Integer;
begin
  Result := nil;
  // Data block...
  if (Ptr^.BlockType = btData) then Result := Pointer(Ptr^.RawCallStack[0])
  else // Object block...
  begin
    Obj := TObject(PChar(Ptr) + SizeOf(TPointerRecord));
    ClassCreatePtr := Obj.ClassType;
    // Search for a Long TObject creation...
    for n := 0 to (RawCallStackLength - 1) do
    begin
      PLongCall := Pointer(PChar(Ptr^.RawCallStack[n]) - SizeOf(PLongCall^) + 5);
      if (IsValidBlockAddr(DWord(PLongCall), SizeOf(PLongCall^))) and
        (IsValidBlockAddr(DWord(PLongCall^.MovEAX_ClassType), 4)) then
      begin
        if (PLongCall^.MovDL_OpCode = $B2) and (PLongCall^.MovDL_Val = $01) and
          (PLongCall^.MovEAX_OpCode = $A1) and (PLongCall^.Call_OpCode = $E8) and
          (PLongCall^.MovEAX_ClassType^ = ClassCreatePtr) then
        begin
          if (n > 0) then
          begin
            Move(Ptr^.RawCallStack[n], Ptr^.RawCallStack[0], (RawCallStackLength - n) * 4);
            FillChar(Ptr^.RawCallStack[RawCallStackLength - n], n * 4, #0);
          end;
          Result := Pointer(Ptr^.RawCallStack[0]);
          Exit;
        end;
      end;
    end;

    // Search for a Short TObject creation...
    for n := 0 to (RawCallStackLength - 1) do
    begin
      PShortCall := Pointer(PChar(Ptr^.RawCallStack[n]) - SizeOf(PShortCall^) + 5);
      if (IsValidBlockAddr(DWord(PShortCall), SizeOf(PShortCall^))) then
      begin
        if (PShortCall^.MovDL_OpCode = $B2) and (PShortCall^.MovDL_Val = $01) and
          (PShortCall^.Call_OpCode = $E8) and (PShortCall^.Call_ClassCreate +
          DWord(PShortCall) + SizeOf(PShortCall^) = DWord(TObjectCreate)) then
        begin
          if (n > 0) then
          begin
            Move(Ptr^.RawCallStack[n], Ptr^.RawCallStack[0], (RawCallStackLength - n) * 4);
            FillChar(Ptr^.RawCallStack[RawCallStackLength - n], n * 4, #0);
          end;
          Result := Pointer(Ptr^.RawCallStack[0]);
          Exit;
        end;
      end;
    end;
  end;
end;

procedure PurgeInvalidLeaks;

  procedure RemoveMemBlock(ObjectName: string; Size: DWord);
  var
    P: PPointerRecord;
    ObjName: string;
    Remove: Boolean;
    BlockType: TBlockType;
  begin
    if (ObjectName = '') then BlockType := btData
    else BlockType := btObject;
    Remove := False;
    P := AllocatedList_Start;
    while (P <> nil) do
    begin
      if (P^.BlockType = BlockType) and (P^.Size = Size) and (P^.BlockState <> bsRemoved) then
      begin
        if (BlockType = btData) then Remove := True
        else
        begin
          ObjName := TObject(Pointer(PChar(P) + SizeOf(TPointerRecord))).ClassName;
          if (ObjName = ObjectName) then Remove := True;
        end;
        if (Remove) then
        begin
          P^.BlockState:= bsRemoved;
          Exit;
        end;
      end;
      P := P^.Next;
    end;
  end;

  function FindLeakClassName(ClassName: string): Boolean;
  var
    P: PPointerRecord;
    Obj: TObject;
  begin
    Result := False;
    if (ClassName = '') then Exit;

    P := AllocatedList_Start;
    while (P <> nil) do
    begin
      if (P^.BlockType = btObject) and (P^.BlockState <> bsRemoved) then
      begin
        Obj := TObject(Pointer(PChar(P) + SizeOf(TPointerRecord)));
        if (IsAParentClassStr(Obj.ClassType, ClassName)) then
        begin
          Result := True;
          Exit;
        end;
      end;
      P := P^.Next;
    end;
  end;

begin
{$IFDEF Delphi6}
  if (loHideBorlandLeaks in LeaksOptions) then
  begin
    RemoveMemBlock('THelpManager', 48);
    RemoveMemBlock('TObjectList', 20);
    RemoveMemBlock('TObjectList', 20);
    RemoveMemBlock('TObjectList', 20);
    RemoveMemBlock('TWinHelpViewer', 36);
    RemoveMemBlock('THelpManager', 48);
    RemoveMemBlock('', 16);
    RemoveMemBlock('', 16);
    RemoveMemBlock('', 16);
  end;
{$ENDIF}
  if (FindLeakClassName('TForm')) then
  begin
    RemoveMemBlock('', 60);
    RemoveMemBlock('', 32);
    RemoveMemBlock('', 32);
{$IFDEF Delphi3}
    RemoveMemBlock('', 22);
{$ENDIF}
{$IFDEF Delphi5Down}
    RemoveMemBlock('', 32);
{$ENDIF}
{$IFDEF Delphi9Up}
    RemoveMemBlock('', 64);
{$ENDIF}
  end;
end;

procedure RemoveExtraLeaks;
var
  Count: Integer;
  P: PPointerRecord;
begin
  Count := 0;
  P := AllocatedList_Start;
  while (P <> nil) do
  begin
    if (Count > MaxLeaks) then P^.BlockState := bsRemoved
    else
      if (P^.BlockState <> bsRemoved) then Inc(Count);
    P := P^.Next;
  end;
end;

//------------------------------------------------------------------------------
// Internal leaks report routines...
//------------------------------------------------------------------------------

procedure Internal_ResetLeaks;
begin
  if (Assigned(ResetLeaks)) then ResetLeaks;
end;

procedure Internal_AddLeak(Ptr: PPointerRecord);
var
  LeakType: string;
  Data: Pointer;
begin
  if (not Assigned(AddLeak)) then Exit;

  if (Ptr^.BlockState = bsAllocated) and (Ptr^.BlockType = btObject) then
  begin
    Data := Pointer(PChar(Ptr) + SizeOf(TPointerRecord));
    LeakType := TObject(Data).ClassName
  end
  else
    LeakType := 'Data';

  AddLeak(LeakType, Ptr^.Size, Ptr^.MagicCode, Ptr^.RawCallStack);
end;

procedure Internal_ShowLeaks;
begin
  if (Assigned(ShowLeaks)) then ShowLeaks;
end;

//------------------------------------------------------------------------------
// Leaks handling routines...
//------------------------------------------------------------------------------

procedure PurgeCallStacks;
var
  P: PPointerRecord;
  ExcAddr: Pointer;
{$IFDEF LEAK_PROFILER}
  mSec: DWord;
{$ENDIF}
begin
{$IFDEF LEAK_PROFILER}
  mSecPurge0 := 0;
  mSecPurge1 := 0;
  mSecPurge2 := 0;
{$ENDIF}

  // Purge all Call Stack...
  P := AllocatedList_Start;
  while (P <> nil) do
  begin
{$IFDEF LEAK_PROFILER}
    mSec := GetTickCount;
{$ENDIF}

    PurgeCallStack(@P^.RawCallStack, RawCallStackLength);
    PurgeCallStack(@P^.FramesCallStack, FramesCallStackLength);

{$IFDEF LEAK_PROFILER}
    mSec := (GetTickCount - mSec);
    Inc(mSecPurge0, mSec);

    mSec := GetTickCount;
{$ENDIF}

    ExcAddr := FindLeakAddress(P);

{$IFDEF LEAK_PROFILER}
    mSec := (GetTickCount - mSec);
    Inc(mSecPurge1, mSec);

    mSec := GetTickCount;
{$ENDIF}

    // Check if Raw CallStack contains caller address...
    if (ExcAddr = nil) then
    begin // Try to use the StackFrames CallStack...
      FillChar(P^.RawCallStack, SizeOf(TRawCallStack), #0);
      Move(P^.FramesCallStack, P^.RawCallStack, SizeOf(TFramesCallStack));
      ExcAddr := FindLeakAddress(P);
      if (ExcAddr = nil) then
        FillChar(P^.FramesCallStack, SizeOf(P^.FramesCallStack), #0);
    end;

{$IFDEF LEAK_PROFILER}
    mSec := (GetTickCount - mSec);
    Inc(mSecPurge2, mSec);
{$ENDIF}

    P := P^.Next;
  end;
end;

procedure RemoveLeaksSons;
var
  P: PPointerRecord;
begin
  if not (loGroupsSonLeaks in LeaksOptions) then Exit;

  P := AllocatedList_Start;
  while (P <> nil) do
  begin
    FindLeakSons(P);
    P := P^.Next;
  end;
end;

procedure FreeAllLeaks;
var
  OldP, P: PPointerRecord;
begin
  if not (loFreeAllLeaks in LeaksOptions) then Exit;

  P := AllocatedList_Start;
  while (P <> nil) do
  begin
    OldP := P;
    P := P^.Next;
    OldMemoryManager.FreeMem(OldP);
  end;
end;

procedure CountAllLeaks;
var
  P: PPointerRecord;
begin
  P := AllocatedList_Start;
  while (P <> nil) do
  begin
    if (P^.BlockState <> bsRemoved) then GetLeakCount(P);
    P := P^.Next;
  end;
end;

{procedure ShowCallStack(P: PPointerRecord);
var
  n: Integer;
  Line: string;
begin
  Line := '';
  for n := 0 to (RawCallStackLength - 1) do
    if (P^.RawCallStack[n] <> 0) then
      Line := (Line + IntToHex(P^.RawCallStack[n], 8) + #13#10);
  MessageBox(0, PChar(Line), '', 0);
end;}

procedure HandleAnyLeak;
var
  P: PPointerRecord;
  ExcAddr: Pointer;
  ContainsLeaks: Boolean;
begin
  ContainsLeaks := False;
  P := AllocatedList_Start;
  while (P <> nil) do
  begin
    if (P^.BlockState <> bsRemoved) then
    begin
      ExcAddr := Pointer(P^.RawCallStack[0]);
//      ShowCallStack(P);
      if (ExcAddr <> nil) then
      try
        if (not ContainsLeaks) then
        begin
          Internal_ResetLeaks;
          ContainsLeaks := True;
        end;
        Internal_AddLeak(P);
      except
      end;
    end;
    P := P^.Next;
  end;
  if (ContainsLeaks) then Internal_ShowLeaks;
end;

procedure LeaksCheck;
var
{$IFDEF LEAK_PROFILER}
  Str0, Str1, Str2, Str3, Str4, Str5, Str6, TotalStr,
    PurgeStr0, PurgeStr1, PurgeStr2: string;
{$ENDIF}
  DebugSection: string;
begin
  if (AllocatedList_Start = nil) then Exit;

  try
    DebugSection := 'Initialize the Memory Pages Cache';

    // Initialize the Memory Pages Cache...
    GetMem(MemoryPages, SizeOf(TMemoryPages));
    FillChar(MemoryPages^, SizeOf(TMemoryPages), bsUnknown);

    DebugSection := 'Lock AllocatedList_Lock';
    LockVariable(AllocatedList_Lock);
    try
      // Check for a just-freed memory block...
      if (not IsValidBlockAddr(DWord(AllocatedList_Start), SizeOf(TPointerRecord))) then
      begin
        if (DebugHook = 1) then
          MessageBox(0,
            'The application contains some memory leaks but it''s impossible to show ' +
            'them because another Memory Manager has already freed them.' + #13#10 +
            'Try to replaced the Memory Manager used with the last FastMM4 Memory ' +
            'Manager (http://fastmm.sourceforge.net).',
            'Error', MessageBoxFlags);
        Exit;
      end;

      // Purge any unusable Memory Leaks (as Borland Delphi 6 leaks)...
  {$IFDEF LEAK_PROFILER}
      mSec0 := GetTickCount;
  {$ENDIF}
      DebugSection := 'PurgeInvalidLeaks';
      PurgeInvalidLeaks;
  {$IFDEF LEAK_PROFILER}
      mSec0 := (GetTickCount - mSec0);
  {$ENDIF}

      // Remove extra leaks...
  {$IFDEF LEAK_PROFILER}
      mSec1 := GetTickCount;
  {$ENDIF}
      DebugSection := 'RemoveExtraLeaks';
      RemoveExtraLeaks;
  {$IFDEF LEAK_PROFILER}
      mSec1 := (GetTickCount - mSec1);
  {$ENDIF}

      // Purge all Call-Stacks (Raw and Frames)...
  {$IFDEF LEAK_PROFILER}
      mSec2 := GetTickCount;
  {$ENDIF}
      DebugSection := 'PurgeCallStacks';
      PurgeCallStacks;
  {$IFDEF LEAK_PROFILER}
      mSec2 := (GetTickCount - mSec2);
  {$ENDIF}

      // Count all Memory Leaks...
  {$IFDEF LEAK_PROFILER}
      mSec3 := GetTickCount;
  {$ENDIF}
      DebugSection := 'CountAllLeaks';
      CountAllLeaks;
  {$IFDEF LEAK_PROFILER}
      mSec3 := (GetTickCount - mSec3);
  {$ENDIF}

      // Remove all Memory Leaks Sons...
  {$IFDEF LEAK_PROFILER}
      mSec4 := GetTickCount;
  {$ENDIF}
      DebugSection := 'RemoveLeaksSons';
      RemoveLeaksSons;
  {$IFDEF LEAK_PROFILER}
      mSec4 := (GetTickCount - mSec4);
  {$ENDIF}
                                          
      // Handle any Memory Leaks...
  {$IFDEF LEAK_PROFILER}
      mSec5 := 0;
  {$ENDIF}
      DebugSection := 'HandleAnyLeak';
      HandleAnyLeak;

      // Free the Memory Leaks Blocks...
  {$IFDEF LEAK_PROFILER}
      mSec6 := GetTickCount;
  {$ENDIF}
      DebugSection := 'FreeAllLeaks';
      FreeAllLeaks;
  {$IFDEF LEAK_PROFILER}
      mSec6 := (GetTickCount - mSec6);
  {$ENDIF}
    finally
      DebugSection := 'Unlock AllocatedList_Lock';    
      UnlockVariable(AllocatedList_Lock);
      DebugSection := 'Free The Memory Pages Cache';
      FreeMem(MemoryPages, SizeOf(TMemoryPages));
    end;
  except
    MessageBox(0, PChar('Error in ELeaks "' + DebugSection + '" section.'),
      'Error', MessageBoxFlags);
  end;

{$IFDEF LEAK_PROFILER}
  mSecTotal := (mSec0 + mSec1 + mSec2 + mSec3 + mSec4 + mSec5 + mSec6);
  Str(mSecTotal, TotalStr);
  Str(mSec0, Str0);
  Str(mSec1, Str1);
  Str(mSec2, Str2);
  Str(mSec3, Str3);
  Str(mSec4, Str4);
  Str(mSec5, Str5);
  Str(mSec6, Str6);
  Str(mSecPurge0, PurgeStr0);
  Str(mSecPurge1, PurgeStr1);
  Str(mSecPurge2, PurgeStr2);
  MessageBox(0, PChar(
    'Total: ' + TotalStr + #13#10 +
    '----------'#13#10 +
    'PurgeInvalidLeaks: ' + Str0 +  #13#10 +
    'RemoveExtraLeaks: ' + Str1 + #13#10 +
    'PurgeCallStacks Total: ' + Str2 + #13#10 +
    '----------'#13#10 +
    '  PurgeCallStacks 0: ' + PurgeStr0 + #13#10 +
    '  PurgeCallStacks 1: ' + PurgeStr1 + #13#10 +
    '  PurgeCallStacks 2: ' + PurgeStr2 + #13#10 +
    '----------'#13#10 +
    'CountAllLeaks: ' + Str3 + #13#10 +
    'RemoveLeaksSons: ' + Str4 + #13#10 +
    'HandleAnyLeak: ' + Str5 + #13#10 +
    'FreeAllLeaks: ' + Str6 + #13#10),
    'Times (ms)', MB_OK or MB_ICONINFORMATION or MB_TASKMODAL);
{$ENDIF}
end;

//------------------------------------------------------------------------------
// Design-Time routines...
//------------------------------------------------------------------------------

function IsIntoIDE: Boolean;
const
{$IFNDEF CBuilder}
  {$IFDEF Delphi9Up}
    RADExeName = 'BDS.EXE';
  {$ELSE}
    RADExeName = 'DELPHI32.EXE';
  {$ENDIF}
{$ELSE}
  {$IFDEF Delphi10Up}
    RADExeName = 'BDS.EXE';
  {$ELSE}
    RADExeName = 'BCB.EXE';
  {$ENDIF}
{$ENDIF}
var
  Buff: array[0..MAX_PATH - 1] of Char;
  FileName: string;
begin
  if (GetModuleFileName(MainInstance, Buff, SizeOf(Buff)) > 0) then
    FileName := Buff
  else
    FileName := '';
  Result := UpperCase(ExtractFileName(FileName)) = RADExeName;
end;

function GetOptionsFromExeFile(var Leaks: TLeaksOptions): Boolean;
var
  UseMainModuleOptions: Boolean;

  function GetRawOptions(Module: THandle; var MainOptions: Boolean): Boolean;
  var
    LeaksPtr: ^ TLeaksOptions;
    MainPtr: ^ Boolean;
    MagicCode, ResSize: DWord;
    Version: Word;

    function GetResourceData(Module: THandle; ResName,
      ResType: PChar; var Size: DWord): Pointer;
    var
      InfoBlock: HRSRC;
      GlobalMemoryBlock: HGLOBAL;
    begin
      Result := nil;
      InfoBlock := FindResource(Module, ResName, ResType);
      if (InfoBlock <> 0) then
      begin
        Size := SizeofResource(Module, InfoBlock);
        GlobalMemoryBlock := LoadResource(Module, InfoBlock);
        if (GlobalMemoryBlock <> 0) then Result := LockResource(GlobalMemoryBlock);
      end;
    end;

  begin
    Result := False;
    LeaksPtr := GetResourceData(Module, 'ELDATA', RT_RCDATA, ResSize);
    if (LeaksPtr <> nil) then
    begin
      MagicCode := PDWord(LeaksPtr)^;
      if ((MagicCode = MagicCodeValue6) or (MagicCode = MagicCodeValue5)) then
      begin
        Inc(LeaksPtr, 4);
        Version := PWord(LeaksPtr)^;

        // A WORKAROUND about a "6.0, 6.0.1, 6.0.2 RC 1" bug on version saving...
        if ((Version >= 600) and (Version <= 602)) then
          Version := (6000 + Version mod 600);

        if (Version >= 6000) then
        begin
          Inc(LeaksPtr, 10);
          Leaks := LeaksPtr^;
          MainPtr := Pointer(LeaksPtr);
          Inc(MainPtr, 1);
          MainOptions := MainPtr^;
          Result := (loCatchLeaks in Leaks);
        end;
      end;
    end;
  end;

begin
  Result := GetRawOptions(HInstance, UseMainModuleOptions);
  if (HInstance <> MainInstance) and (UseMainModuleOptions) then
    Result := GetRawOptions(MainInstance, UseMainModuleOptions);
end;

//------------------------------------------------------------------------------
// Initialization/Finalization routines...
//------------------------------------------------------------------------------

var
  NewMemoryManager: TMemoryManager = (
    GetMem: NewGetMem;
    FreeMem: NewFreeMem;
    ReallocMem: NewReallocMem);

procedure EnableMemoryLeaksCheck;

  function ModuleName: string;
  var
    Buffer: array[0..260] of Char;
  begin
    SetString(Result, Buffer, GetModuleFileName(HInstance, Buffer, SizeOf(Buffer)));
    Result := ExtractFileName(Result);
  end;

  function IsCompiledWithPackages: Boolean;
  begin
    Result := (DWord(FindClassHInstance(System.TObject)) <> DWord(HInstance));
  end;

  procedure IsMMSetInOtherModule;
  var
    UniqueProcessIDString: string;
  begin
    Str(GetCurrentProcessID, UniqueProcessIDString);
    UniqueProcessIDString := (UniqueProcessIDString + '_EurekaLog_Leak');
    MMWindow := FindWindow('STATIC', PChar(UniqueProcessIDString));
    if (MMWindow = 0) then
    begin
      MMWindow := CreateWindow('STATIC', PChar(UniqueProcessIDString),
        WS_POPUP, 0, 0, 0, 0, 0, 0, HInstance, nil);
      if (MMWindow <> 0) then
        SetWindowLong(MMWindow, GWL_USERDATA, Integer(@NewMemoryManager));
      IsMemoryManagerOwner := True;
    end
    else
    begin
      NewMemoryManager := PMemoryManager(GetWindowLong(MMWindow, GWL_USERDATA))^;
      IsMemoryManagerOwner := False;
    end;
  end;                   

begin
  if (IsCompiledWithPackages) then
  begin
    InstallNewMemoryManager := False;
    if (DebugHook = 1) then
      MessageBox(0, PChar('The "Memory Leaks Catches" is disabled in the "' + ModuleName +
        '" module, because compiled with RunTime-Packages.'), 'Error', MessageBoxFlags);
    Exit;
  end;

  // Assign the Memory Pages Cache...
  MemoryPages := nil;

  // Assign the TObject variables...
  TObjectNewInstance := ConvertAddress(@TObject.NewInstance);
  TObjectCreate      := ConvertAddress(@TObject.Create);

  // Initialize the Block Data List...
  AllocatedList_Start := nil;
  AllocatedList_End := nil;
  AllocatedList_Lock := False;

  // Initialize the Wrong Block routines...
  OverrunProc   := nil;
  MultiFreeProc := nil;

  // Call at the Finalization section...
  FinalizationProc := nil;

  // Initialize Leak routines...
  ResetLeaks := nil;
  ShowLeaks  := nil;
  AddLeak    := nil;

  // Get the original memory manager...
  GetMemoryManager(OldMemoryManager);

  // EXPERIMENTAL. DO NOT UNCOMMENT!!!
//  IsMMSetInOtherModule;

  // Replace memory manager with ours...
  SetMemoryManager(NewMemoryManager);
end;

procedure DisableMemoryLeaksCheck;
begin
  // Disable the use of the new Memory Manager...
  UseNewMemoryManager := False;

  // Memory leaks check...
  LeaksCheck;

  // Restore the original manager...
  SetMemoryManager(OldMemoryManager);

  if (IsMemoryManagerOwner) then
  begin
    if (MMWindow <> 0) then
    begin
      DestroyWindow(MMWindow);
      MMWindow := 0;
    end;
  end;
end;

procedure Init;
begin
  try
    IsMemoryManagerOwner := True;
    MMWindow := 0;

    InstallNewMemoryManager := (not IsIntoIDE);
    if (not InstallNewMemoryManager) then Exit;

    InstallNewMemoryManager := GetOptionsFromExeFile(LeaksOptions);
    if (not InstallNewMemoryManager) then Exit;

    // Enable the use of the new Memory Manager...
    UseNewMemoryManager := True;

    if (InstallNewMemoryManager) then EnableMemoryLeaksCheck;
  except
    MessageBox(0, 'Error in ELeaks Initialization.', 'Error', MessageBoxFlags);
  end;
end;

procedure Done;
begin
  try
    if (InstallNewMemoryManager) then DisableMemoryLeaksCheck;
    if (Assigned(FinalizationProc)) then FinalizationProc;
  except
    MessageBox(0, 'Error in ELeaks Finalization.', 'Error', MessageBoxFlags);
  end;
end;

//------------------------------------------------------------------------------

initialization
  Init;

finalization
  Done;

end.
