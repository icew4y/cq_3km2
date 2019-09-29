//格式化一下：
{ **********
  *          *
  * DLL linking is provided by Benjamin Rosseaux, www.0ok.de,          *
  * mailto:benjamin@0ok.de          *
  *          *
  * This DLL Loader code is coyyrighted: (C) 2004, Benjamin Rosseaux      *
  *          *
  ********** }

unit DLLLoader;

interface

uses
  Windows, Classes;

const
  IMPORTED_NAME_OFFSET = $00000002;
  IMAGE_ORDINAL_FLAG32 = $80000000;
  IMAGE_ORDINAL_MASK32 = $0000FFFF;

  RTL_CRITSECT_TYPE = 0;
  RTL_RESOURCE_TYPE = 1;

  DLL_PROCESS_ATTACH = 1;
  DLL_THREAD_ATTACH = 2;
  DLL_THREAD_DETACH = 3;
  DLL_PROCESS_DETACH = 0;

  IMAGE_SizeHeader = 20;

  IMAGE_FILE_RELOCS_STRIPPED = $0001;
  IMAGE_FILE_EXECUTABLE_IMAGE = $0002;
  IMAGE_FILE_LINE_NUMS_STRIPPED = $0004;
  IMAGE_FILE_LOCAL_SYMS_STRIPPED = $0008;
  IMAGE_FILE_AGGRESIVE_WS_TRIM = $0010;
  IMAGE_FILE_BYTES_REVERSED_LO = $0080;
  IMAGE_FILE_32BIT_MACHINE = $0100;
  IMAGE_FILE_DEBUG_STRIPPED = $0200;
  IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP = $0400;
  IMAGE_FILE_NET_RUN_FROM_SWAP = $0800;
  IMAGE_FILE_SYSTEM = $1000;
  IMAGE_FILE_DLL = $2000;
  IMAGE_FILE_UP_SYSTEM_ONLY = $4000;
  IMAGE_FILE_BYTES_REVERSED_HI = $8000;

  IMAGE_FILE_MACHINE_UNKNOWN = 0;
  IMAGE_FILE_MACHINE_I386 = $14C;
  IMAGE_FILE_MACHINE_R3000 = $162;
  IMAGE_FILE_MACHINE_R4000 = $166;
  IMAGE_FILE_MACHINE_R10000 = $168;
  IMAGE_FILE_MACHINE_ALPHA = $184;
  IMAGE_FILE_MACHINE_POWERPC = $1F0;

  IMAGE_NUMBEROF_DIRECTORY_ENTRIES = 16;

  IMAGE_SUBSYSTEM_UNKNOWN = 0;
  IMAGE_SUBSYSTEM_NATIVE = 1;
  IMAGE_SUBSYSTEM_WINdoWS_GUI = 2;
  IMAGE_SUBSYSTEM_WINdoWS_CUI = 3;
  IMAGE_SUBSYSTEM_OS2_CUI = 5;
  IMAGE_SUBSYSTEM_POSIX_CUI = 7;
  IMAGE_SUBSYSTEM_RESERVED = 8;

  IMAGE_DIRECTORY_ENTRY_EXPORT = 0;
  IMAGE_DIRECTORY_ENTRY_IMPORT = 1;
  IMAGE_DIRECTORY_ENTRY_RESOURCE = 2;
  IMAGE_DIRECTORY_ENTRY_EXCEPTION = 3;
  IMAGE_DIRECTORY_ENTRY_SECURITY = 4;
  IMAGE_DIRECTORY_ENTRY_BASERELOC = 5;
  IMAGE_DIRECTORY_ENTRY_DEBUG = 6;
  IMAGE_DIRECTORY_ENTRY_COPYRIGHT = 7;
  IMAGE_DIRECTORY_ENTRY_GLOBALPTR = 8;
  IMAGE_DIRECTORY_ENTRY_TLS = 9;
  IMAGE_DIRECTORY_ENTRY_LOAD_CONFIG = 10;
  IMAGE_DIRECTORY_ENTRY_BOUND_IMPORT = 11;
  IMAGE_DIRECTORY_ENTRY_IAT = 12;

  IMAGE_SIZEOF_SHORT_NAME = 8;

  IMAGE_SCN_TYIMAGE_REG = $00000000;
  IMAGE_SCN_TYIMAGE_DSECT = $00000001;
  IMAGE_SCN_TYIMAGE_NOLOAD = $00000002;
  IMAGE_SCN_TYIMAGE_GROUP = $00000004;
  IMAGE_SCN_TYIMAGE_NO_PAD = $00000008;
  IMAGE_SCN_TYIMAGE_COPY = $00000010;
  IMAGE_SCN_CNT_CODE = $00000020;
  IMAGE_SCN_CNT_INITIALIZED_DATA = $00000040;
  IMAGE_SCN_CNT_UNINITIALIZED_DATA = $00000080;
  IMAGE_SCN_LNK_OTHER = $00000100;
  IMAGE_SCN_LNK_INFO = $00000200;
  IMAGE_SCN_TYIMAGE_OVER = $0000400;
  IMAGE_SCN_LNK_REMOVE = $00000800;
  IMAGE_SCN_LNK_COMDAT = $00001000;
  IMAGE_SCN_MEM_PROTECTED = $00004000;
  IMAGE_SCN_MEM_FARDATA = $00008000;
  IMAGE_SCN_MEM_SYSHEAP = $00010000;
  IMAGE_SCN_MEM_PURGEABLE = $00020000;
  IMAGE_SCN_MEM_16BIT = $00020000;
  IMAGE_SCN_MEM_LOCKED = $00040000;
  IMAGE_SCN_MEM_PRELOAD = $00080000;
  IMAGE_SCN_ALIGN_1ByteS = $00100000;
  IMAGE_SCN_ALIGN_2ByteS = $00200000;
  IMAGE_SCN_ALIGN_4ByteS = $00300000;
  IMAGE_SCN_ALIGN_8ByteS = $00400000;
  IMAGE_SCN_ALIGN_16ByteS = $00500000;
  IMAGE_SCN_ALIGN_32ByteS = $00600000;
  IMAGE_SCN_ALIGN_64ByteS = $00700000;
  IMAGE_SCN_LNK_NRELOC_OVFL = $01000000;
  IMAGE_SCN_MEM_DISCARDABLE = $02000000;
  IMAGE_SCN_MEM_NOT_CACHED = $04000000;
  IMAGE_SCN_MEM_NOT_PAGED = $08000000;
  IMAGE_SCN_MEM_SHARED = $10000000;
  IMAGE_SCN_MEM_EXECUTE = $20000000;
  IMAGE_SCN_MEM_READ = $40000000;
  IMAGE_SCN_MEM_WRITE = LongWord($80000000);

  IMAGE_REL_BASED_ABSOLUTE = 0;
  IMAGE_REL_BASED_HIGH = 1;
  IMAGE_REL_BASED_LOW = 2;
  IMAGE_REL_BASED_HIGHLOW = 3;
  IMAGE_REL_BASED_HIGHADJ = 4;
  IMAGE_REL_BASED_MIPS_JMPADDR = 5;
  IMAGE_REL_BASED_SECTION = 6;
  IMAGE_REL_BASED_REL32 = 7;

  IMAGE_REL_BASED_MIPS_JMPADDR16 = 9;
  IMAGE_REL_BASED_IA64_IMM64 = 9;
  IMAGE_REL_BASED_DIR64 = 10;
  IMAGE_REL_BASED_HIGH3ADJ = 11;

  PAGE_NOACCESS = 1;
  PAGE_REAdoNLY = 2;
  PAGE_READWRITE = 4;
  PAGE_WRITECOPY = 8;
  PAGE_EXECUTE = $10;
  PAGE_EXECUTE_READ = $20;
  PAGE_EXECUTE_READWRITE = $40;
  PAGE_EXECUTE_WRITECOPY = $80;
  PAGE_GUARD = $100;
  PAGE_NOCACHE = $200;
  MEM_COMMIT = $1000;
  MEM_RESERVE = $2000;
  MEM_DECOMMIT = $4000;
  MEM_RELEASE = $8000;
  MEM_FREE = $10000;
  MEM_PRIVATE = $20000;
  MEM_MAPPED = $40000;
  MEM_RESET = $80000;
  MEM_TOP_doWN = $100000;
  SEC_FILE = $800000;
  SEC_IMAGE = $1000000;
  SEC_RESERVE = $4000000;
  SEC_COMMIT = $8000000;
  SEC_NOCACHE = $10000000;
  MEM_IMAGE = SEC_IMAGE;

type
  PPointer = ^Pointer;

  PLongWord = ^LongWord;
  PPLongWord = ^PLongWord;

  PWORD = ^WORD;
  PPWORD = ^PWord;

  HInst = LongWord;
  HMODULE = HInst;

  PWordArray = ^TWordArray;
  TWordArray = array[0..(2147483647 div SizeOf(WORD)) - 1] of WORD;

  PLongWordArray = ^TLongWordArray;
  TLongWordArray = array[0..(2147483647 div SizeOf(LongWord)) - 1] of LongWord;

  PImagedoSHeader = ^TImagedoSHeader;

  TImagedoSHeader = packed record
    Signature: Word;
    PartPag: Word;
    PageCnt: Word;
    ReloCnt: Word;
    HdrSize: Word;
    MinMem: Word;
    MaxMem: Word;
    ReloSS: Word;
    ExeSP: Word;
    ChkSum: Word;
    ExeIP: Word;
    ReloCS: Word;
    TablOff: Word;
    Overlay: Word;
    Reserved: packed array[0..3] of WORD;
    OEMID: Word;
    OEMInfo: Word;
    Reserved2: packed array[0..9] of WORD;
    LFAOffset: LongWord;
  end;

  TISHMisc = packed record
    case Integer of
      0:
      (PhysicalAddress: LongWord);
      1:
      (VirtualSize: LongWord);
  end;

  PImageExportDirectory = ^TImageExportDirectory;

  TImageExportDirectory = packed record
    Characteristics: LongWord;
    TimeDateStamp: LongWord;
    MajorVersion: Word;
    MinorVersion: Word;
    Name: LongWord;
    Base: LongWord;
    NumberOffunctions: LongWord;
    NumberOfNames: LongWord;
    AddressOffunctions: PPLongWord;
    AddressOfNames: PPLongWord;
    AddressOfNameOrdinals: PPWORD;
  end;

  PImageSectionHeader = ^TImageSectionHeader;

  TImageSectionHeader = packed record
    Name: packed array[0..IMAGE_SizeOf_SHORT_NAME - 1] of Byte;
    Misc: TISHMisc;
    VirtualAddress: LongWord;
    SizeOfRawData: LongWord;
    PointerToRawData: LongWord;
    PointerToRelocations: LongWord;
    PointerToLinenumbers: LongWord;
    NumberOfRelocations: Word;
    NumberOfLinenumbers: Word;
    Characteristics: LongWord;
  end;

  PImageSectionHeaders = ^TImageSectionHeaders;
  TImageSectionHeaders = array[0..(2147483647 div SizeOf(TImageSectionHeader)) - 1] of TImageSectionHeader;

  PImageDataDirectory = ^TImageDataDirectory;

  TImageDataDirectory = packed record
    VirtualAddress: LongWord;
    Size: LongWord;
  end;

  PImageFileHeader = ^TImageFileHeader;

  TImageFileHeader = packed record
    Machine: Word;
    NumberOfSections: Word;
    TimeDateStamp: LongWord;
    PointerToSymbolTable: LongWord;
    NumberOfSymbols: LongWord;
    SizeOfOptionalHeader: Word;
    Characteristics: Word;
  end;

  PImageOptionalHeader = ^TImageOptionalHeader;

  TImageOptionalHeader = packed record
    Magic: Word;
    MajorLinkerVersion: Byte;
    MinorLinkerVersion: Byte;
    SizeOfCode: LongWord;
    SizeOfInitializedData: LongWord;
    SizeOfUninitializedData: LongWord;
    AddressOfEntryPoint: LongWord;
    BaseOfCode: LongWord;
    BaseOfData: LongWord;
    ImageBase: LongWord;
    SectionAlignment: LongWord;
    FileAlignment: LongWord;
    MajorOperatingSystemVersion: Word;
    MinorOperatingSystemVersion: Word;
    MajorImageVersion: Word;
    MinorImageVersion: Word;
    MajorSubsystemVersion: Word;
    MinorSubsystemVersion: Word;
    Win32VersionValue: LongWord;
    SizeOfImage: LongWord;
    SizeOfHeaders: LongWord;
    CheckSum: LongWord;
    Subsystem: Word;
    DllCharacteristics: Word;
    SizeOfStackReserve: LongWord;
    SizeOfStackCommit: LongWord;
    SizeOfHeapReserve: LongWord;
    SizeOfHeapCommit: LongWord;
    LoaderFlags: LongWord;
    NumberOfRvaAndSizes: LongWord;
    DataDirectory: packed array[0..IMAGE_NUMBEROF_DIRECTORY_ENTRIES - 1] of TImageDataDirectory;
  end;

  PImageNTHeaders = ^TImageNTHeaders;

  TImageNTHeaders = packed record
    Signature: LongWord;
    FileHeader: TImageFileHeader;
    OptionalHeader: TImageOptionalHeader;
  end;

  PImageImportDescriptor = ^TImageImportDescriptor;

  TImageImportDescriptor = packed record
    OriginalFirstThunk: LongWord;
    TimeDateStamp: LongWord;
    ForwarderChain: LongWord;
    Name: LongWord;
    FirstThunk: LongWord;
  end;

  PImageBaseRelocation = ^TImageBaseRelocation;

  TImageBaseRelocation = packed record
    VirtualAddress: LongWord;
    SizeOfBlock: LongWord;
  end;

  PImageThunkData = ^TImageThunkData;

  TImageThunkData = packed record
    ForwarderString: LongWord;
    Funktion: LongWord;
    Ordinal: LongWord;
    AddressOfData: LongWord;
  end;

  PSection = ^TSection;

  TSection = packed record
    Base: Pointer;
    RVA: LongWord;
    Size: LongWord;
    Characteristics: LongWord;
  end;

  TSections = array of TSection;

  TDLLEntryProc = function(HInstDLL: HMODULE; dwReason: LongWord;
    lpvReserved: Pointer): Boolean; stdcall;

  TNameOrID = (niName, niID);

  TExternalLibrary = record
    LibraryName: string;
    LibraryHandle: HInst;
  end;

  TExternalLibrarys = array of TExternalLibrary;

  PDLLfunctionImport = ^TDLLfunctionImport;

  TDLLfunctionImport = record
    NameOrID: TNameOrID;
    Name: string;
    ID: Integer;
  end;

  PDLLImport = ^TDLLImport;

  TDLLImport = record
    LibraryName: string;
    LibraryHandle: HInst;
    Entries: array of TDLLfunctionImport;
  end;

  TImports = array of TDLLImport;

  PDLLfunctionExport = ^TDLLfunctionExport;

  TDLLfunctionExport = record
    Name: string;
    Index: Integer;
    functionPointer: Pointer;
  end;

  TExports = array of TDLLfunctionExport;

  TExportTreeLink = Pointer;

  PExportTreeNode = ^TExportTreeNode;

  TExportTreeNode = record
    TheChar: Char;
    Link: TExportTreeLink;
    LinkExist: Boolean;
    Prevoius, Next, Up, Down: PExportTreeNode;
  end;

  TExportTree = class
  private
    Root: PExportTreeNode;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Dump;
    function Add(functionName: string; Link: TExportTreeLink): Boolean;
    function Delete(functionName: string): Boolean;
    function Find(functionName: string; var Link: TExportTreeLink): Boolean;
  end;

  TDLLLoader = class
  private
    ImageBase: Pointer;
    ImageBaseDelta: Integer;
    DLLProc: TDLLEntryProc;
    ExternalLibraryArray: TExternalLibrarys;
    ImportArray: TImports;
    ExportArray: TExports;
    Sections: TSections;
    ExportTree: TExportTree;
    function FindExternalLibrary(LibraryName: string): Integer;
    function LoadExternalLibrary(LibraryName: string): Integer;
    function GetExternalLibraryHandle(LibraryName: string): HInst;
  public
    constructor Create;
    destructor Destroy; override;
    function Load(Stream: TStream): Boolean;
    function Unload: Boolean;
    function FindExport(functionName: string): Pointer;
    function FindExportPerIndex(functionIndex: Integer): Pointer;
    function GetExportList: TStringList;
  end;

implementation

function StrToInt(S: string): Integer;
var
  C: Integer;
begin
  Val(S, Result, C);
end;

function CreateExportTreeNode(AChar: Char): PExportTreeNode;
begin
  GetMem(RESULT, SizeOf(TExportTreeNode));
  Result^.TheChar := AChar;
  Result^.Link := nil;
  Result^.LinkExist := False;
  Result^.Prevoius := nil;
  Result^.Next := nil;
  Result^.Up := nil;
  Result^.Down := nil;
end;

procedure DestroyExportTreeNode(Node: PExportTreeNode);
begin
  if Assigned(Node) then
  begin
    DestroyExportTreeNode(Node^.Next);
    DestroyExportTreeNode(Node^.Down);
    FreeMem(Node);
  end;
end;

constructor TExportTree.Create;
begin
  inherited Create;
  Root := nil;
end;

destructor TExportTree.Destroy;
begin
  DestroyExportTreeNode(Root);
  inherited Destroy;
end;

procedure TExportTree.Dump;
var
  Ident: Integer;

  procedure DumpNode(Node: PExportTreeNode);
  var
    SubNode: PExportTreeNode;
    IdentCounter, IdentOld: Integer;
  begin
    for IdentCounter := 1 to Ident do
      Write(' ');
    Write(Node^.TheChar);
    IdentOld := Ident;
    SubNode := Node^.Next;
    while Assigned(SubNode) do
    begin
      Write(SubNode.TheChar);
      if not Assigned(SubNode^.Next) then
        break;
      Inc(Ident);
      SubNode := SubNode^.Next;
    end;
    Writeln;
    Inc(Ident);
    while Assigned(SubNode) and (SubNode <> Node) do
    begin
      if Assigned(SubNode^.Down) then
        DumpNode(SubNode^.Down);
      SubNode := SubNode^.Prevoius;
      Dec(Ident);
    end;
    Ident := IdentOld;
    if Assigned(Node^.Down) then
      DumpNode(Node^.Down);
  end;

begin
  Ident := 0;
  DumpNode(Root);
end;

function TExportTree.Add(FunctionName: string; Link: TExportTreeLink): Boolean;
var
  StringLength, Position, PositionCounter: Integer;
  NewNode, LastNode, Node: PExportTreeNode;
  StringChar, NodeChar: Char;
begin
  Result := False;
  StringLength := Length(FunctionName);
  if StringLength > 0 then
  begin
    LastNode := nil;
    Node := Root;
    for Position := 1 to StringLength do
    begin
      StringChar := FunctionName[Position];
      if Assigned(Node) then
      begin
        NodeChar := Node^.TheChar;
        if NodeChar = StringChar then
        begin
          LastNode := Node;
          Node := Node^.Next;
        end
        else
        begin
          while (NodeChar < StringChar) and Assigned(Node^.Down) do
          begin
            Node := Node^.Down;
            NodeChar := Node^.TheChar;
          end;

          if NodeChar = StringChar then
          begin
            LastNode := Node;
            Node := Node^.Next;
          end
          else
          begin
            NewNode := CreateExportTreeNode(StringChar);
            if NodeChar < StringChar then
            begin
              NewNode^.Down := Node^.Down;
              NewNode^.Up := Node;
              if Assigned(NewNode^.Down) then
              begin
                NewNode^.Down^.Up := NewNode;
              end;
              NewNode^.Prevoius := Node^.Prevoius;
              Node^.Down := NewNode;
            end
            else if NodeChar > StringChar then
            begin
              NewNode^.Down := Node;
              NewNode^.Up := Node^.Up;
              if Assigned(NewNode^.Up) then
              begin
                NewNode^.Up^.Down := NewNode;
              end;
              NewNode^.Prevoius := Node^.Prevoius;
              if not Assigned(NewNode^.Up) then
              begin
                if Assigned(NewNode^.Prevoius) then
                begin
                  NewNode^.Prevoius^.Next := NewNode;
                end
                else
                begin
                  Root := NewNode;
                end;
              end;
              Node^.Up := NewNode;
            end;
            LastNode := NewNode;
            Node := LastNode^.Next;
          end;
        end;
      end
      else
      begin
        for PositionCounter := Position to StringLength do
        begin
          NewNode := CreateExportTreeNode(functionName[PositionCounter]);
          if Assigned(LastNode) then
          begin
            NewNode^.Prevoius := LastNode;
            LastNode^.Next := NewNode;
            LastNode := LastNode^.Next;
          end
          else
          begin
            if not Assigned(Root) then
            begin
              Root := NewNode;
              LastNode := Root;
            end;
          end;
        end;
        break;
      end;
    end;

    if Assigned(LastNode) then
    begin
      if not LastNode^.LinkExist then
      begin
        LastNode^.Link := Link;
        LastNode^.LinkExist := True;
        Result := True;
      end;
    end;
  end;
end;

function TExportTree.Delete(FunctionName: string): Boolean;
var
  StringLength, Position: Integer;
  Node: PExportTreeNode;
  StringChar, NodeChar: Char;
begin
  Result := False;
  StringLength := Length(FunctionName);
  if StringLength > 0 then
  begin
    Node := Root;
    for Position := 1 to StringLength do
    begin
      StringChar := FunctionName[Position];
      if Assigned(Node) then
      begin
        NodeChar := Node^.TheChar;
        while (NodeChar <> StringChar) and Assigned(Node^.Down) do
        begin
          Node := Node^.Down;
          NodeChar := Node^.TheChar;
        end;
        if NodeChar = StringChar then
        begin
          if (Position = StringLength) and Node^.LinkExist then
          begin
            Node^.LinkExist := False;
            Result := True;
            break;
          end;
          Node := Node^.Next;
        end;
      end
      else
      begin
        break;
      end;
    end;
  end;
end;

function TExportTree.Find(FunctionName: string; var Link: TExportTreeLink): Boolean;
var
  StringLength, Position: Integer;
  Node: PExportTreeNode;
  StringChar, NodeChar: Char;
begin
  Result := False;
  StringLength := Length(FunctionName);
  if StringLength > 0 then
  begin
    Node := Root;
    for Position := 1 to StringLength do
    begin
      StringChar := FunctionName[Position];
      if Assigned(Node) then
      begin
        NodeChar := Node^.TheChar;
        while (NodeChar <> StringChar) and Assigned(Node^.Down) do
        begin
          Node := Node^.Down;
          NodeChar := Node^.TheChar;
        end;
        if NodeChar = StringChar then
        begin
          if (Position = StringLength) and Node^.LinkExist then
          begin
            Link := Node^.Link;
            Result := True;
            break;
          end;
          Node := Node^.Next;
        end;
      end
      else
      begin
        break;
      end;
    end;
  end;
end;

constructor TDLLLoader.Create;
begin
  inherited Create;

  ImageBase := nil;
  DLLProc := nil;
  ExternalLibraryArray := nil;
  ImportArray := nil;
  ExportArray := nil;
  Sections := nil;
  ExportTree := nil;
end;

destructor TDLLLoader.Destroy;
begin
  if @DLLProc <> nil then
    Unload;
  if Assigned(ExportTree) then
    ExportTree.Destroy;

  inherited Destroy;
end;

function TDLLLoader.FindExternalLibrary(LibraryName: string): Integer;
var
  I: Integer;
begin
  Result := -1;

  for I := 0 to Length(ExternalLibraryArray) - 1 do
  begin
    if ExternalLibraryArray[I].LibraryName = LibraryName then
    begin
      Result := I;
      exit;
    end;
  end;
end;

function TDLLLoader.LoadExternalLibrary(LibraryName: string): Integer;
begin
  Result := FindExternalLibrary(LibraryName);

  if Result < 0 then
  begin
    Result := Length(ExternalLibraryArray);
    SetLength(ExternalLibraryArray, Length(ExternalLibraryArray) + 1);
    ExternalLibraryArray[RESULT].LibraryName := LibraryName;
    ExternalLibraryArray[RESULT].LibraryHandle := LoadLibrary(PChar(LibraryName));
  end;
end;

function TDLLLoader.GetExternalLibraryHandle(LibraryName: string): LongWord;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Length(ExternalLibraryArray) - 1 do
  begin
    if ExternalLibraryArray[I].LibraryName = LibraryName then
    begin
      Result := ExternalLibraryArray[I].LibraryHandle;
      exit;
    end;
  end;
end;

function TDLLLoader.Load(Stream: TStream): Boolean;
var
  ImagedoSHeader: TImagedoSHeader;
  ImageNTHeaders: TImageNTHeaders;
  OldProtect: LongWord;

  function ConvertPointer(RVA: LongWord): Pointer;
  var
    I: Integer;
  begin
    Result := nil;
    for I := 0 to Length(Sections) - 1 do
    begin
      if (RVA < (Sections[I].RVA + Sections[I].Size)) and
        (RVA >= Sections[I].RVA) then
      begin
        Result := Pointer(LongWord((RVA - LongWord(Sections[I].RVA)) +
          LongWord(Sections[I].Base)));
        exit;
      end;
    end;
  end;

  function ReadImageHeaders: Boolean;
  begin
    Result := False;
    if Stream.Size > 0 then
    begin
      FillChar(ImageNTHeaders, SizeOf(TImageNTHeaders), #0);
      if Stream.Read(ImagedoSHeader, SizeOf(TImagedoSHeader)) <>
        SizeOf(TImagedoSHeader) then
        exit;
      if ImagedoSHeader.Signature <> $5A4D then
        exit;
      if Stream.Seek(ImagedoSHeader.LFAOffset, soFromBeginning) <>
        LongInt(ImagedoSHeader.LFAOffset) then
        exit;
      if Stream.Read(ImageNTHeaders.Signature, SizeOf(LongWord)) <>
        SizeOf(LongWord) then
        exit;
      if ImageNTHeaders.Signature <> $00004550 then
        exit;
      if Stream.Read(ImageNTHeaders.FileHeader, SizeOf(TImageFileHeader)) <>
        SizeOf(TImageFileHeader) then
        exit;
      if ImageNTHeaders.FileHeader.Machine <> $14C then
        exit;
      if Stream.Read(ImageNTHeaders.OptionalHeader,
        ImageNTHeaders.FileHeader.SizeOfOptionalHeader)
        <> ImageNTHeaders.FileHeader.SizeOfOptionalHeader then
        exit;

      Result := True;
    end;
  end;

  function InitializeImage: Boolean;
  var
    SectionBase: Pointer;
    OldPosition: Integer;
  begin
    Result := False;
    if ImageNTHeaders.FileHeader.NumberOfSections > 0 then
    begin
      ImageBase := VirtualAlloc(nil, ImageNTHeaders.OptionalHeader.SizeOfImage,
        MEM_RESERVE, PAGE_NOACCESS);
      ImageBaseDelta := LongWord(ImageBase) -
        ImageNTHeaders.OptionalHeader.ImageBase;
      SectionBase := VirtualAlloc(ImageBase,
        ImageNTHeaders.OptionalHeader.SizeOfHeaders, MEM_COMMIT,
        PAGE_READWRITE);
      OldPosition := Stream.Position;
      Stream.Seek(0, soFromBeginning);
      Stream.Read(SectionBase^, ImageNTHeaders.OptionalHeader.SizeOfHeaders);
      VirtualProtect(SectionBase, ImageNTHeaders.OptionalHeader.SizeOfHeaders,
        PAGE_REAdoNLY, OldProtect);
      Stream.Seek(OldPosition, soFromBeginning);

      Result := True;
    end;
  end;

  function ReadSections: Boolean;
  var
    I: Integer;
    Section: TImageSectionHeader;
    SectionHeaders: PImageSectionHeaders;
  begin
    Result := False;

    if ImageNTHeaders.FileHeader.NumberOfSections > 0 then
    begin
      GetMem(SectionHeaders,
        ImageNTHeaders.FileHeader.NumberOfSections * SizeOf
        (TImageSectionHeader));
      if Stream.Read(SectionHeaders^,
        (ImageNTHeaders.FileHeader.NumberOfSections * SizeOf
        (TImageSectionHeader))) <>
        (ImageNTHeaders.FileHeader.NumberOfSections * SizeOf
        (TImageSectionHeader)) then
        exit;
      SetLength(Sections, ImageNTHeaders.FileHeader.NumberOfSections);
      for I := 0 to ImageNTHeaders.FileHeader.NumberOfSections - 1 do
      begin
        Section := SectionHeaders^[I];
        Sections[I].RVA := Section.VirtualAddress;
        Sections[I].Size := Section.SizeOfRawData;
        if Sections[I].Size < Section.Misc.VirtualSize then
        begin
          Sections[I].Size := Section.Misc.VirtualSize;
        end;
        Sections[I].Characteristics := Section.Characteristics;
        Sections[I].Base := VirtualAlloc
          (Pointer(LongWord(Sections[I].RVA + LongWord(ImageBase))),
          Sections[I].Size, MEM_COMMIT, PAGE_READWRITE);
        FillChar(Sections[I].Base^, Sections[I].Size, #0);
        if Section.PointerToRawData <> 0 then
        begin
          Stream.Seek(Section.PointerToRawData, soFromBeginning);
          if Stream.Read(Sections[I].Base^, Section.SizeOfRawData) <> LongInt
            (Section.SizeOfRawData) then
            exit;
        end;
      end;
      FreeMem(SectionHeaders);

      Result := True;
    end;
  end;

  function ProcessRelocations: Boolean;
  var
    Relocations: PChar;
    Position: LongWord;
    BaseRelocation: PImageBaseRelocation;
    Base: Pointer;
    NumberOfRelocations: LongWord;
    Relocation: PWordArray;
    RelocationCounter: LongInt;
    RelocationPointer: Pointer;
    RelocationType: LongWord;
  begin
    if ImageNTHeaders.OptionalHeader.DataDirectory
      [IMAGE_DIRECTORY_ENTRY_BASERELOC].VirtualAddress <> 0 then
    begin
      Result := False;
      Relocations := ConvertPointer(ImageNTHeaders.OptionalHeader.DataDirectory
        [IMAGE_DIRECTORY_ENTRY_BASERELOC].VirtualAddress);
      Position := 0;
      while Assigned(Relocations) and
        (Position < ImageNTHeaders.OptionalHeader.DataDirectory
        [IMAGE_DIRECTORY_ENTRY_BASERELOC].Size) do
      begin
        BaseRelocation := PImageBaseRelocation(Relocations);
        Base := ConvertPointer(BaseRelocation^.VirtualAddress);
        if not Assigned(Base) then
          exit;
        NumberOfRelocations := (BaseRelocation^.SizeOfBlock - SizeOf
          (TImageBaseRelocation)) div SizeOf(WORD);
        Relocation := Pointer(LongWord(LongWord(BaseRelocation) + SizeOf
          (TImageBaseRelocation)));
        for RelocationCounter := 0 to NumberOfRelocations - 1 do
        begin
          RelocationPointer := Pointer
            (LongWord(LongWord(Base) + (Relocation^[RelocationCounter]
            and $FFF)));
          RelocationType := Relocation^[RelocationCounter] shr 12;
          case RelocationType of
            IMAGE_REL_BASED_ABSOLUTE:
              begin
              end;
            IMAGE_REL_BASED_HIGH:
              begin
                PWORD(RelocationPointer)^ :=
                  (LongWord(((LongWord(PWORD(RelocationPointer)^ + LongWord
                  (ImageBase)
                  - ImageNTHeaders.OptionalHeader.ImageBase))))
                  shr 16) and $FFFF;
              end;
            IMAGE_REL_BASED_LOW:
              begin
                PWORD(RelocationPointer)^ := LongWord
                  (((LongWord(PWORD(RelocationPointer)^ + LongWord(ImageBase)
                  - ImageNTHeaders.OptionalHeader.ImageBase))))
                  and $FFFF;
              end;
            IMAGE_REL_BASED_HIGHLOW:
              begin
                PPointer(RelocationPointer)^ := Pointer
                  ((LongWord(LongWord(PPointer(RelocationPointer)^) + LongWord
                  (ImageBase) - ImageNTHeaders.OptionalHeader.ImageBase))
                  );
              end;
            IMAGE_REL_BASED_HIGHADJ:
              begin
          // ???
              end;
            IMAGE_REL_BASED_MIPS_JMPADDR:
              begin
          // Only for MIPS CPUs ;)
              end;
          end;
        end;
        Relocations := Pointer
          (LongWord(LongWord(Relocations) + BaseRelocation^.SizeOfBlock));
        Inc(Position, BaseRelocation^.SizeOfBlock);
      end;
    end;

    Result := True;
  end;

  function ProcessImports: Boolean;
  var
    ImportDescriptor: PImageImportDescriptor;
    ThunkData: PLongWord;
    Name: PChar;
    DLLImport: PDLLImport;
    DLLfunctionImport: PDLLfunctionImport;
    functionPointer: Pointer;
  begin
    if ImageNTHeaders.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_IMPORT]
      .VirtualAddress <> 0 then
    begin
      ImportDescriptor := ConvertPointer
        (ImageNTHeaders.OptionalHeader.DataDirectory
        [IMAGE_DIRECTORY_ENTRY_IMPORT].VirtualAddress);
      if Assigned(ImportDescriptor) then
      begin
        SetLength(ImportArray, 0);
        while ImportDescriptor^.Name <> 0 do
        begin
          Name := ConvertPointer(ImportDescriptor^.Name);
          SetLength(ImportArray, Length(ImportArray) + 1);
          LoadExternalLibrary(Name);
          DLLImport := @ImportArray[Length(ImportArray) - 1];
          DLLImport^.LibraryName := Name;
          DLLImport^.LibraryHandle := GetExternalLibraryHandle(Name);
          DLLImport^.Entries := nil;
          if ImportDescriptor^.TimeDateStamp = 0 then
          begin
            ThunkData := ConvertPointer(ImportDescriptor^.FirstThunk);
          end
          else
          begin
            ThunkData := ConvertPointer(ImportDescriptor^.OriginalFirstThunk);
          end;
          while ThunkData^ <> 0 do
          begin
            SetLength(DLLImport^.Entries, Length(DLLImport^.Entries) + 1);
            DLLfunctionImport := @DLLImport^.Entries[Length(DLLImport^.Entries) - 1];
            if (ThunkData^ and IMAGE_ORDINAL_FLAG32) <> 0 then
            begin
              DLLfunctionImport^.NameOrID := niID;
              DLLfunctionImport^.ID := ThunkData^ and IMAGE_ORDINAL_MASK32;
              DLLfunctionImport^.Name := '';
              functionPointer := GetProcAddress(DLLImport^.LibraryHandle,
                PChar(ThunkData^ and IMAGE_ORDINAL_MASK32));
            end
            else
            begin
              Name := ConvertPointer(LongWord(ThunkData^) + IMPORTED_NAME_OFFSET);
              DLLfunctionImport^.NameOrID := niName;
              DLLfunctionImport^.ID := 0;
              DLLfunctionImport^.Name := Name;
              functionPointer := GetProcAddress(DLLImport^.LibraryHandle, Name);
            end;
            PPointer(ThunkData)^ := functionPointer;
            Inc(ThunkData);
          end;
          Inc(ImportDescriptor);
        end;
      end;
    end;

    Result := True;
  end;

  function ProtectSections: Boolean;
  var
    I: Integer;
    Characteristics: LongWord;
    Flags: LongWord;
  begin
    Result := False;
    if ImageNTHeaders.FileHeader.NumberOfSections > 0 then
    begin
      for I := 0 to ImageNTHeaders.FileHeader.NumberOfSections - 1 do
      begin
        Characteristics := Sections[I].Characteristics;
        Flags := 0;
        if (Characteristics and IMAGE_SCN_MEM_EXECUTE) <> 0 then
        begin
          if (Characteristics and IMAGE_SCN_MEM_READ) <> 0 then
          begin
            if (Characteristics and IMAGE_SCN_MEM_WRITE) <> 0 then
            begin
              Flags := Flags or PAGE_EXECUTE_READWRITE;
            end
            else
            begin
              Flags := Flags or PAGE_EXECUTE_READ;
            end;
          end
          else if (Characteristics and IMAGE_SCN_MEM_WRITE) <> 0 then
          begin
            Flags := Flags or PAGE_EXECUTE_WRITECOPY;
          end
          else
          begin
            Flags := Flags or PAGE_EXECUTE;
          end;
        end
        else if (Characteristics and IMAGE_SCN_MEM_READ) <> 0 then
        begin
          if (Characteristics and IMAGE_SCN_MEM_WRITE) <> 0 then
          begin
            Flags := Flags or PAGE_READWRITE;
          end
          else
          begin
            Flags := Flags or PAGE_REAdoNLY;
          end;
        end
        else if (Characteristics and IMAGE_SCN_MEM_WRITE) <> 0 then
        begin
          Flags := Flags or PAGE_WRITECOPY;
        end
        else
        begin
          Flags := Flags or PAGE_NOACCESS;
        end;
        if (Characteristics and IMAGE_SCN_MEM_NOT_CACHED) <> 0 then
        begin
          Flags := Flags or PAGE_NOCACHE;
        end;
        VirtualProtect(Sections[I].Base, Sections[I].Size, Flags, OldProtect);
      end;

      Result := True;
    end;
  end;

  function InitializeLibrary: Boolean;
  begin
    Result := False;
    @DLLProc := ConvertPointer
      (ImageNTHeaders.OptionalHeader.AddressOfEntryPoint);
    if DLLProc(Cardinal(ImageBase), DLL_PROCESS_ATTACH, nil) then
    begin
      Result := True;
    end;
  end;

  function ProcessExports: Boolean;
  var
    I: Integer;
    ExportDirectory: PImageExportDirectory;
    ExportDirectorySize: LongWord;
    functionNamePointer: Pointer;
    functionName: PChar;
    functionIndexPointer: Pointer;
    functionIndex: LongWord;
    functionPointer: Pointer;
    ForwarderCharPointer: PChar;
    ForwarderString: string;
    ForwarderLibrary: string;
    ForwarderLibraryHandle: HInst;

    function ParseStringToNumber(AString: string): LongWord;
    var
      CharCounter: Integer;
    begin
      Result := 0;
      for CharCounter := 0 to Length(AString) - 1 do
      begin
        if AString[CharCounter] in ['0'..'9'] then
        begin
          Result := (RESULT * 10) + Byte
            (Byte(AString[CharCounter]) - Byte('0'));
        end
        else
        begin
          exit;
        end;
      end;
    end;

  begin
    if ImageNTHeaders.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXPORT]
      .VirtualAddress <> 0 then
    begin
      ExportTree := TExportTree.Create;
      ExportDirectory := ConvertPointer
        (ImageNTHeaders.OptionalHeader.DataDirectory
        [IMAGE_DIRECTORY_ENTRY_EXPORT].VirtualAddress);
      if Assigned(ExportDirectory) then
      begin
        ExportDirectorySize := ImageNTHeaders.OptionalHeader.DataDirectory
          [IMAGE_DIRECTORY_ENTRY_EXPORT].Size;
        SetLength(ExportArray, ExportDirectory^.NumberOfNames);
        for I := 0 to ExportDirectory^.NumberOfNames - 1 do
        begin
          functionNamePointer := ConvertPointer
            (LongWord(ExportDirectory^.AddressOfNames));
          functionNamePointer := ConvertPointer
            (PLongWordArray(functionNamePointer)^[I]);
          functionName := functionNamePointer;
          functionIndexPointer := ConvertPointer
            (LongWord(ExportDirectory^.AddressOfNameOrdinals));
          functionIndex := PWordArray(functionIndexPointer)^[I];
          functionPointer := ConvertPointer
            (LongWord(ExportDirectory^.AddressOffunctions));
          functionPointer := ConvertPointer(PLongWordArray(functionPointer)
            ^[functionIndex]);
          ExportArray[I].Name := functionName;
          ExportArray[I].Index := functionIndex;
          if (LongWord(ExportDirectory) < LongWord(functionPointer)) and
            (LongWord(functionPointer) < (LongWord(ExportDirectory)
            + ExportDirectorySize)) then
          begin
            ForwarderCharPointer := functionPointer;
            ForwarderString := ForwarderCharPointer;
            while ForwarderCharPointer^ <> '.' do
              Inc(ForwarderCharPointer);
            ForwarderLibrary := COPY(ForwarderString, 1,
              POS('.', ForwarderString) - 1);
            LoadExternalLibrary(ForwarderLibrary);
            ForwarderLibraryHandle := GetExternalLibraryHandle
              (ForwarderLibrary);
            if ForwarderCharPointer^ = '#' then
            begin
              Inc(ForwarderCharPointer);
              ForwarderString := ForwarderCharPointer;
              ForwarderCharPointer := ConvertPointer
                (ParseStringToNumber(ForwarderString));
              ForwarderString := ForwarderCharPointer;
            end
            else
            begin
              ForwarderString := ForwarderCharPointer;
              ExportArray[I].functionPointer := GetProcAddress
                (ForwarderLibraryHandle, PChar(ForwarderString));
            end;
          end
          else
          begin
            ExportArray[I].functionPointer := functionPointer;
          end;
          ExportTree.Add(ExportArray[I].Name, ExportArray[I].functionPointer);
        end
      end;
    end;
    Result := True;
  end;

begin
  Result := False;
  if Assigned(Stream) then
  begin
    Stream.Seek(0, soFromBeginning);
    if Stream.Size > 0 then
    begin
      if ReadImageHeaders then
      begin
        if InitializeImage then
        begin
          if ReadSections then
          begin
            if ProcessRelocations then
            begin
              if ProcessImports then
              begin
                if ProtectSections then
                begin
                  if InitializeLibrary then
                  begin
                    if ProcessExports then
                    begin
                      Result := True;
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

function TDLLLoader.Unload: Boolean;
var
  I, J: Integer;
begin
  Result := False;
  if @DLLProc <> nil then
  begin
    DLLProc(LongWord(ImageBase), DLL_PROCESS_DETACH, nil);
  end;
  for I := 0 to Length(Sections) - 1 do
  begin
    if Assigned(Sections[I].Base) then
    begin
      VirtualFree(Sections[I].Base, 0, MEM_RELEASE);
    end;
  end;
  SetLength(Sections, 0);
  for I := 0 to Length(ExternalLibraryArray) - 1 do
  begin
    ExternalLibraryArray[I].LibraryName := '';
    FreeLibrary(ExternalLibraryArray[I].LibraryHandle);
  end;
  SetLength(ExternalLibraryArray, 0);
  for I := 0 to Length(ImportArray) - 1 do
  begin
    for J := 0 to Length(ImportArray[I].Entries) - 1 do
    begin
      ImportArray[I].Entries[J].Name := '';
    end;
    SetLength(ImportArray[I].Entries, 0);
  end;
  SetLength(ImportArray, 0);
  for I := 0 to Length(ExportArray) - 1 do
    ExportArray[I].Name := '';
  SetLength(ExportArray, 0);
  VirtualFree(ImageBase, 0, MEM_RELEASE);
  if Assigned(ExportTree) then
  begin
    ExportTree.Destroy;
    ExportTree := nil;
  end;
end;

function TDLLLoader.FindExport(FunctionName: string): Pointer;
var
  I: Integer;
begin
  Result := nil;
  if Assigned(ExportTree) then
  begin
    ExportTree.Find(FunctionName, Result);
  end
  else
  begin
    for I := 0 to Length(ExportArray) - 1 do
    begin
      if ExportArray[I].Name = FunctionName then
      begin
        Result := ExportArray[I].functionPointer;
        exit;
      end;
    end;
  end;
end;

function TDLLLoader.FindExportPerIndex(FunctionIndex: Integer): Pointer;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Length(ExportArray) - 1 do
  begin
    if ExportArray[I].Index = FunctionIndex then
    begin
      Result := ExportArray[I].FunctionPointer;
      exit;
    end;
  end;
end;

function TDLLLoader.GetExportList: TStringList;
var
  I: Integer;
begin
  Result := TStringList.Create;
  for I := 0 to Length(ExportArray) - 1 do
    Result.Add(ExportArray[I].Name);
  Result.Sort;
end;

end.

