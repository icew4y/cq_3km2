{************************************************}
{                                                }
{               EurekaLog v 6.x                  }
{         BaseModule Unit - EBaseModule          }
{                                                }
{  Copyright (c) 2001 - 2007 by Fabio Dell'Aria  }
{                                                }
{************************************************}

unit EBaseModule;

{$I Exceptions.inc}

interface

uses
  Windows, SysUtils, Classes, IniFiles, TypInfo, ECore;

const
  // "Program" word
  ProgramWord = 'PROGRAM';

  // "Library" word
  LibraryWord = 'LIBRARY';

  // "Package" word
  PackageWord = 'PACKAGE';

  // "Uses" word
  UsesWord = 'USES';

  // Contains word
  ContainsWord = 'CONTAINS';

  // requires word
  RequiresWord = 'REQUIRES';

  // Unit name for the "Exception Handler" (Program, DLLs)
  MainUnitName = 'ExceptionLog';

  // Buffer Size for store (in RAM)
  // text of Source file (for insert/remove "ExceptionLog" unit).
  BuffSize = 30000; // WARNING !!! (Don't increases this value over 32000)

  // Number of comment symbols
  CommentsNumber = 4;

  // Comment and "quote start" symbols
  StartComments: array[0..CommentsNumber - 1] of string = ('{', '(*', '//', '''');

  // Comment and "quote end" symbols
  EndComments: array[0..CommentsNumber - 1] of string = ('}', '*)', #13#10, '''');

  // Set uses for check pascal names...
  NameSet: set of char = ['a'..'z', 'A'..'Z', '0'..'9', '_'];

type
  TInstalledType = (itNone, itCompiled, itInstalled);

  TBaseModule = class(TEurekaModuleOptions)
  protected
    FName: string; // WARNING !!! Don't save this field.
    FVersion: Word; // WARNING !!! Don't save this field.
    FCompiledDate: TDateTime; // WARNING !!! Don't save this field.
    FEncryptPassword: string;

    class function GetText(const FileName: string): string; virtual;
    function GetCppBuilderOutputFile: string;
    function GetOutputDir: string; virtual;
    procedure SetDebugOptions(Active: Boolean); virtual;
    procedure InsertText(const FileName: string; StartPos: Integer; Text: PChar); virtual;
    procedure DeleteText(const FileName: string; StartPos, EndPos: integer); virtual;
    procedure GetModuleInfo(var MType: TModuleType; var ext: string); virtual;
    function GetOptionFile: string;
    function SetBplFile(SourceFile: string): string; virtual;
    function GetCompiledFile: string;
    function GetMapFile: string;
    function GetModuleType: TModuleType;
    function GetRealFileName(FileName: string; Compiled: Boolean): string; virtual;

    // Procedures...
    procedure ErrorMessage(const Msg: string); virtual;
    function IsReadOnly: Boolean; virtual;

    function GetCommandLineOption(const Opt: string): string;

    function ExecProgram(const CommandLine: string): Integer; virtual;
  public
    // Procedures...
    constructor Create(ModuleName: string);

    procedure GetUnitDirs(List: TStrings); virtual;
    procedure Assign(Source: TEurekaModuleOptions); override;
    procedure SetToDefaultOptions; override;
    procedure MakeLine(Active: Boolean); virtual;
    procedure BeforeCompile;
    procedure AfterCompile;
    function BuildMapFile: Boolean; virtual;
    procedure LoadOptionsFromFile(FileName: string);
    procedure SaveOptionsToFile(FileName: string);
    procedure LoadOptionsFromDefaultOptionFile;
    procedure LoadOptions;
    procedure SaveOptionsToDefaultOptionFile;
    procedure SaveOptions;

    // Properties...
    property Version: Word read FVersion;
    property Name: string read FName write FName;
    property EncryptPassword: string read FEncryptPassword write FEncryptPassword;
    property OptionFile: string read GetOptionFile;
    property CompiledFile: string read GetCompiledFile;
    property MapFile: string read GetMapFile;
    property ModuleType: TModuleType read GetModuleType;
    property CompiledDate: TDateTime read FCompiledDate;
  end;

  TBaseClass = class of TBaseModule;

  TModules = class(TList)
  private
    function GetItem(Index: Integer): TBaseModule;
    procedure SetItem(Index: Integer; Value: TBaseModule);
    function GetCurrentModule: TBaseModule; virtual;
  public
    // Procedures...
    destructor Destroy; override;
    procedure Delete(Index: Integer);
    procedure AddModule(ClassType: TBaseClass; AModuleName: string; LoadType: TLoadType);
    function FindByName(ModuleName: string): Integer;
    // Properties...
    property Items[Index: Integer]: TBaseModule read GetItem write SetItem; default;
    property CurrentModule: TBaseModule read GetCurrentModule;
  end;

  TPersonalityType = (ptDelphiWin32, ptCppBuilderWin32);

  TOptionType = (otProjectFileExt, otPackageFileExt, otOptionFileExt,
                 otOldOptionFileExt, otRequiredFileExt, otSourceFileExt,
                 otCmdLineProjectExt, otOptionFileFirstLine, otOptionFileLastLine);

  TCustomPersonality = class(TObject)
  public
    class function GetOptionValue(Option: TOptionType;
      const Field: string): string; virtual;
    class function IsOptionEqual(Value: string; Option: TOptionType;
      const Field: string): Boolean;
    class function GetPersonality: TPersonalityType; virtual;
  end;

  TPersonalityClass = Class of TCustomPersonality;

  TDelphiWin32Personality = class(TCustomPersonality)
  public
    class function GetOptionValue(Option: TOptionType;
      const Field: string): string; override;
    class function GetPersonality: TPersonalityType; override;
  end;

  TCppBuilderWin32Personality = class(TCustomPersonality)
  public
    class function GetOptionValue(Option: TOptionType;
      const Field: string): string; override;
    class function GetPersonality: TPersonalityType; override;
  end;

var
  ModuleOptions: TModules;
  Compiled: Boolean;
  GetCurrentModuleNameProc: function: string;
  IsAcceptableProject: function(const FileName: string): Boolean;
  MasterOptionsFile: string = '';
  CheckCompiler: procedure = nil;
  CurrentPersonality: function: TPersonalityClass;

function IsEurekaLogOptionsFile(FName: string): Boolean;
function IsEurekaLogPackage(const FileName: string): Boolean;
function OptionFileExt(const FileName: string): string;
function OldOptionFileExt(const FileName: string): string;
function EurekaLogFirstLine(const FileName: string): string;
function EurekaLogLastLine(const FileName: string): string;
function DefaultOptionFile: string;
function AdjustDir(Dir: string; WithFile: Boolean): string;
function GetCppFileOptionValue(FileName, OptionName: string): string;

implementation

uses EConsts, ETypes, EBorlandDebug, EResource,
  EZLib, EEncrypt, EHash {$IFDEF EUREKALOG_DEMO} ,ECheck {$ENDIF};

const
  TUnhandledModules: set of TModuleType =
{$IFDEF PROFESSIONAL}
  [mtUnknown];
{$ELSE}
  [mtUnknown, mtPackage, mtLibrary];
{$ENDIF}

type
{$IFDEF Delphi4Up}
  TInternalIniFile = TCustomIniFile;
{$ELSE}
  TInternalIniFile = TIniFile;
{$ENDIF}

  TInMemIniFile = class(TInternalIniFile)
  private
{$IFDEF Delphi4Up}
    FSections: TStringList;
    FOldFilename, FFirstLine, FLastLine, FSectionLine, FXMLLastLine: string;
    FTime1, FTime2, FTime3: TFileTime;
    FFileOK: Boolean;
    function AddSection(const Section: string): TStrings;
    function GetDataRange(const Data: string; var StartIdx, EndIdx: Integer): string;
    procedure LoadValues;
    procedure GetStrings(List: TStrings);
    procedure SetStrings(List: TStrings);
{$ENDIF}
  public
    constructor Create(const FileName, OldFileName, FirstLine, LastLine,
      SectionLine, XMLLastLine: string);
{$IFDEF Delphi4Up}
    destructor Destroy; override;
    procedure Clear;
    procedure EncodeData(List: TStrings); virtual;
    procedure DecodeData(List: TStrings); virtual;
    function ReadString(const Section, Ident, Default: string): string; override;
    procedure WriteString(const Section, Ident, Value: string); override;
    procedure UpdateFile; override;
    // Abstract methods...
    procedure DeleteKey(const Section, Ident: string); override;
    procedure EraseSection(const Section: string); override;
    procedure ReadSection(const Section: string; Strings: TStrings); override;
    procedure ReadSections(Strings: TStrings); override;
    procedure ReadSectionValues(const Section: string; Strings: TStrings); override;
{$ENDIF}
  end;

  // Windows import functions types...
  //----------------------------------------------------------------------------
  TArrayImageSectionHeader = array[0..MaxInt shr 6] of TImageSectionHeader;
  PArrayImageSectionHeader = ^TArrayImageSectionHeader;

  TFuncRecord = record
    DLL, Proc, Hook: string;
  end;

  PHeader = ^THeader;
  THeader = packed record
    Unused: array[0..59] of Byte; // unused information.
    Offset: DWord;
  end;

  TImageData = record
    Headers: PImageNtHeaders;
    BaseOfCode, ImageBase, SizeOfHeaders: DWord;
  end;

  PThunk_Data = ^TThunk_Data;
  TThunk_Data = packed record
    AddressOfData: DWord;
  end;

  PImport_Function = ^TImport_Function;
  TImport_Function = packed record
    Ordinal: SmallInt;
    Name: array[0..255] of Char;
  end;

  PImportDescriptor = ^TImportDescriptor;
  TImportDescriptor = packed record
    OriginalFirstThunk: DWord;
    TimeDateStamp: DWord;
    ForwarderChain: DWord;
    Name: DWord;
    FirstThunk: DWord;
  end;

  PAsmLongJump = ^TAsmLongJump;
  TAsmLongJump = packed record
    OpCode: Word; // $25FF
    Addr: DWord;
  end;

  PAsmJump = ^TAsmJump;
  TAsmJump = packed record
    JMP_OpCode: Byte; // $E9
    Distance: Integer;
    NOP_OpCode: Byte; // $90
  end;

  PRelocationDescriptor = ^TRelocationDescriptor;
  TRelocationDescriptor = packed record
    VirtualAddress: DWord;
    SizeOfBlock: DWord;
    TypeOffset: array[0..MaxInt shr 2] of Word;
  end;

//------------------------------------------------------------------------------

procedure InternalCheckCompiler;
begin
  // Nothing...
end;

// Check for load of old .DPR file...
// ... converted by Delphi 2007 into a .BDSPROJ and after in a .DPROJ file!
// ... converted by C++Builder 2007 into a .BDSPROJ and after in a .CBPROJ file!
function IsConvertingOldOptionsFile(const FileName: string): boolean;
begin
{$IFDEF Delphi11Up}
  if (CurrentPersonality = TDelphiWin32Personality) then
    Result := ((CompareText(ExtractFileExt(FileName), '.bdsproj') = 0) and
      (not FileExists(FileName)) and (FileExists(ChangeFileExt(FileName, '.dpr'))))
  else
    Result := ((CompareText(ExtractFileExt(FileName), '.bdsproj') = 0) and
      (not FileExists(FileName)) and (FileExists(ChangeFileExt(FileName, '.bpr'))));
{$ELSE}
  Result := False;
{$ENDIF}
end;

function IsEurekaLogPackage(const FileName: string): Boolean;
var
  Buff: array[0..MAX_PATH - 1] of Char;
begin
  GetModuleFileName(HInstance, Buff, SizeOf(Buff));
  Result :=
  (CompareText(FileName,
    ChangeFileExt(Buff, CurrentPersonality.GetOptionValue(otPackageFileExt, FileName))) = 0);
end;

function IsEurekaLogOptionsFile(FName: string): Boolean;

  function CheckOptionFile(FileName: string): Boolean;
  var
    Cfg: TIniFile;
  begin
    Result := False;
    FileName := ExpandFileName(FileName);

    if (not FileExists(FileName)) then Exit;

    Cfg := TiniFile.Create(FileName);
    try
      Result := (Cfg.ReadInteger(EurekaLogSection, 'Activate', -1) <> -1);
    finally
      Cfg.Free;
    end;
  end;

begin
  if (IsConvertingOldOptionsFile(FName)) then
  begin
    Result := True;
    Exit;
  end;

  Result := (CheckOptionFile(FName)) or
    (CheckOptionFile(ChangeFileExt(FName, OptionFileExt(FName))) or
    CheckOptionFile(ChangeFileExt(FName, OldOptionFileExt(FName))));
end;

//------------------------------------------------------------------------------

{ TCustomPersonality }

class function TCustomPersonality.GetOptionValue(Option: TOptionType;
  const Field: string): string;
begin
  // Abstract method...
  Result := '';
end;

class function TCustomPersonality.IsOptionEqual(Value: string;
  Option: TOptionType; const Field: string): Boolean;
begin
  Result := (CompareText(Value, GetOptionValue(Option, Field)) = 0);
end;

class function TCustomPersonality.GetPersonality: TPersonalityType;
begin
  // Abstract method...
  Result := ptDelphiWin32;
end;

{ TDelphiWin32Personality }

class function TDelphiWin32Personality.GetPersonality: TPersonalityType;
begin
  Result := ptDelphiWin32;
end;

class function TDelphiWin32Personality.GetOptionValue(Option: TOptionType;
  const Field: string): string;
begin
  case Option of
{$IFDEF Delphi9Up}
  {$IFDEF Delphi10Down}
    otProjectFileExt: Result := '.bdsproj';
    otPackageFileExt: Result := '.bdsproj';
    otOptionFileExt: Result := '.bdsproj';
  {$ELSE}
    otProjectFileExt:
      if (CompareText(ExtractFileExt(Field), '.bdsproj') = 0) then Result := '.bdsproj'
      else Result := '.dproj';
    otPackageFileExt:
      if (CompareText(ExtractFileExt(Field), '.bdsproj') = 0) then Result := '.bdsproj'
      else Result := '.dproj';
    otOptionFileExt:
      if (CompareText(ExtractFileExt(Field), '.bdsproj') = 0) then Result := '.bdsproj'
      else Result := '.dproj';
  {$ENDIF}
{$ELSE}
    otProjectFileExt: Result := '.dpr';
    otPackageFileExt: Result := '.dpk';
    otOptionFileExt: Result := '.dof';
{$ENDIF}
    otOldOptionFileExt:
{$IFDEF Delphi11Up}
      if (IsConvertingOldOptionsFile(Field)) then Result := '.dof'
      else
        if (CompareText(ExtractFileExt(Field), '.bdsproj') = 0) then Result := '.bdsproj'
        else Result := '.dof';
{$ELSE}
      Result := '.dof';
{$ENDIF}
    otRequiredFileExt: Result := '.dcp';
    otSourceFileExt: Result := '.pas';
    otCmdLineProjectExt: Result := '.dpr';
    otOptionFileFirstLine:
{$IFDEF Delphi11Up}
      if (IsConvertingOldOptionsFile(Field)) then Result := EurekaLogFirstLine_TXT
      else
        if (CompareText(ExtractFileExt(Field), '.dproj') = 0) or
          (CompareText(ExtractFileExt(Field), '.bdsproj') = 0) then Result := EurekaLogFirstLine_XML
        else Result := EurekaLogFirstLine_TXT;
{$ELSE}
  {$IFDEF EurekaLog_XML_Options}
      Result := EurekaLogFirstLine_XML;
  {$ELSE}
      Result := EurekaLogFirstLine_TXT;
  {$ENDIF}
{$ENDIF}
    otOptionFileLastLine:
{$IFDEF Delphi11Up}
      if (IsConvertingOldOptionsFile(Field)) then Result := EurekaLogLastLine_TXT
      else
        if (CompareText(ExtractFileExt(Field), '.dproj') = 0) or
          (CompareText(ExtractFileExt(Field), '.bdsproj') = 0) then Result := EurekaLogLastLine_XML
        else Result := EurekaLogLastLine_TXT;
{$ELSE}
  {$IFDEF EurekaLog_XML_Options}
      Result := EurekaLogLastLine_XML;
  {$ELSE}
      Result := EurekaLogLastLine_TXT;
  {$ENDIF}
{$ENDIF}
  end;
end;

//------------------------------------------------------------------------------

{ TCppBuilderWin32Personality }

class function TCppBuilderWin32Personality.GetPersonality: TPersonalityType;
begin
  Result := ptCppBuilderWin32;
end;

class function TCppBuilderWin32Personality.GetOptionValue(Option: TOptionType;
  const Field: string): string;
begin
  case Option of
{$IFDEF Delphi9Up}
  {$IFDEF Delphi10Down}
    otProjectFileExt: Result := '.bdsproj';
    otPackageFileExt: Result := '.bdsproj';
    otOptionFileExt : Result := '.bdsproj';
  {$ELSE}
    otProjectFileExt:
      if (CompareText(ExtractFileExt(Field), '.bdsproj') = 0) then Result := '.bdsproj'
      else Result := '.cbproj';
    otPackageFileExt:
      if (CompareText(ExtractFileExt(Field), '.bdsproj') = 0) then Result := '.bdsproj'
      else Result := '.cbproj';
    otOptionFileExt:
      if (CompareText(ExtractFileExt(Field), '.bdsproj') = 0) then Result := '.bdsproj'
      else Result := '.cbproj';
  {$ENDIF}
{$ELSE}
    otProjectFileExt: Result := '.bpr';
    otPackageFileExt: Result := '.bpk';
    otOptionFileExt:  Result := '.bpr';
{$ENDIF}
    otOldOptionFileExt:
{$IFDEF Delphi11Up}
      if (IsConvertingOldOptionsFile(Field)) then Result := '.bpr'
      else
        if (CompareText(ExtractFileExt(Field), '.bdsproj') = 0) then Result := '.bdsproj'
        else Result := '.bpr';
{$ELSE}
      Result := '.bpr';
{$ENDIF}
    otRequiredFileExt    : Result := '.bpi';
    otSourceFileExt      : Result := '.cpp';
    otCmdLineProjectExt  : Result := '.mak';
    otOptionFileFirstLine: Result := EurekaLogFirstLine_XML;
    otOptionFileLastLine : Result := EurekaLogLastLine_XML;
  end;
end;

//------------------------------------------------------------------------------

{ TInMemIniFile }

constructor TInMemIniFile.Create(const FileName, OldFileName, FirstLine, LastLine,
  SectionLine, XMLLastLine: string);
begin
  inherited Create(FileName);
{$IFDEF Delphi4Up}
  FFileOk := False;
  FOldFileName := OldFileName;
  FFirstLine := FirstLine;
  FLastLine := LastLine;
  FSectionLine := SectionLine;
  FXMLLastLine := XMLLastLine;
  FSections := TStringList.Create;
  LoadValues;
{$ENDIF}
end;

{$IFDEF Delphi4Up}

destructor TInMemIniFile.Destroy;
begin
  if (FSections <> nil) then Clear;
  FSections.Free;
  inherited;
end;

function TInMemIniFile.AddSection(const Section: string): TStrings;
begin
  Result := TStringList.Create;
  try
    FSections.AddObject(Section, Result);
  except
    Result.Free;
  end;
end;

procedure TInMemIniFile.Clear;
var
  I: Integer;
begin
  for I := 0 to (FSections.Count - 1) do
    TStrings(FSections.Objects[I]).Free;
  FSections.Clear;
end;

procedure TInMemIniFile.GetStrings(List: TStrings);
var
  I, J: Integer;
  Strings: TStrings;
begin
  List.BeginUpdate;
  try
    for I := 0 to (FSections.Count - 1) do
    begin
      List.Add('[' + FSections[I] + ']');
      Strings := TStrings(FSections.Objects[I]);
      for J := 0 to (Strings.Count - 1) do List.Add(Strings[J]);
      List.Add('');
    end;
  finally
    List.EndUpdate;
  end;
end;

function TInMemIniFile.GetDataRange(const Data: string; var StartIdx, EndIdx: Integer): string;
var
  Idx: Integer;
  List, Tmp: TStrings;
begin
  Result := '';
  List := TStringList.Create;
  try
    List.Text := Data;
    Idx := List.IndexOf('[' + FSectionLine + ']');
    if (Idx <> -1) then
    begin
      StartIdx := Idx;
      Inc(Idx);
      while (Idx <= (List.Count - 1)) and (List[Idx] <> '') and
        (not (List[Idx][1] in [' ', '[', '<'])) and
        (Pos(FLastLine, List[Idx]) = 0) do Inc(Idx);
      EndIdx := (Idx - 1);
      Tmp := TStringList.Create;
      try
        for Idx := StartIdx to EndIdx do Tmp.Add(List[Idx]);
        Result := Tmp.Text;
      finally
        Tmp.Free;
      end;
    end;
  finally
    List.Free;
  end;
end;

procedure TInMemIniFile.LoadValues;
var
  List: TStringList;
  Idx1, Idx2: Integer;
  Data: string;
  h: THandle;
begin
  Data := '';
  List := TStringList.Create;
  try
    if (FileExists(FileName)) then
    begin
      h := FileOpen(FileName, fmOpenReadWrite);
      FFileOk := GetFileTime(h, @FTime1, @FTime2, @FTime3);
      FileClose(h);
      List.LoadFromFile(FileName);
    end;
    Data := GetDataRange(List.Text, Idx1, Idx2);
    if (Data = '') then
    begin
      if (FileExists(FOldFileName)) then List.LoadFromFile(FOldFileName);
      Data := GetDataRange(List.Text, Idx1, Idx2);
    end;
    List.Text := Data;
    SetStrings(List);
    DecodeData(List);
    SetStrings(List);
  finally
    List.Free;
  end;
end;

procedure TInMemIniFile.DecodeData(List: TStrings);
var
  n, i: Integer;
  OldText, s: string;

  function IsEncoded(const Text: string): Boolean;

    function IsValidChar(ch: char): Boolean;
    const
      OkChars: set of char = ['0'..'9', 'a'..'f', 'A'..'F'];
    begin
      Result := (ch in OkChars);
    end;

  var
    n: Integer;
  begin
    Result := (Pos('>', Text) = 0) and (Pos('<', Text) = 0);
    if (Result) then
    begin
      n := 1;
      while (n <= (Length(Text) - 2)) do
      begin
        if (Text[n] = '%') then
        begin
          if (Text[n + 1] = '%') then Inc(n)
          else
            Result := (IsValidChar(Text[n + 1])) and (IsValidChar(Text[n + 2]));
          if (not Result) then Break;
        end;
        Inc(n);
      end;
    end;
  end;

begin
  if (List.Count = 0) then Exit;
  if (ReadInteger(FSectionLine, 'EurekaLog Version', 0) < 464) then Exit;

  OldText := List.Text;
  if (not IsEncoded(OldText)) then Exit;
  try
    for n := 0 to (List.Count - 1) do
      if ((List[n] <> FFirstLine) and (List[n] <> FLastLine)) then
      begin
        i := 1;
        s := List[n];
        while (i <= Length(s) - 2) do
        begin
          if (s[i] = '%') then
          begin
            if (s[i + 1] <> '%') then
              s := Copy(s, 1, (i - 1)) + Chr(StrToInt('$' + Copy(s, (i + 1), 2))) +
                Copy(s, (i + 3), Length(s))
            else Inc(i);
          end;
          Inc(i);
        end;
        List[n] := s;
      end;
    List.Text := QuickStringReplace(List.Text, '%%', '%');
  except
    List.Text := OldText;
  end;
end;

procedure TInMemIniFile.EncodeData(List: TStrings);
const
  TInvalidChars: set of Char = [#0..#31, '&', '<', '>', '-', #127..#255];
var
  n, i: Integer;
  s: string;
begin
  if (List.Count = 0) then Exit;

  List.Text := QuickStringReplace(List.Text, '%', '%%');
  for n := 0 to (List.Count - 1) do
    if ((List[n] <> FFirstLine) and (List[n] <> FLastLine)) then
    begin
      i := 1;
      s := List[n];
      while (i <= Length(s)) do
      begin
        if (s[i] in TInvalidChars) then
        begin
          s := Copy(s, 1, (i - 1)) + '%' + IntToHex(Ord(s[i]), 2) + Copy(s, (i + 1), Length(s));
          Inc(i, 3);
        end
        else Inc(i);
      end;
      List[n] := s;
    end;
end;

function TInMemIniFile.ReadString(const Section, Ident, Default: string): string;
var
  I: Integer;
  Strings: TStrings;
begin
  I := FSections.IndexOf(Section);
  if (I >= 0) then
  begin
    Strings := TStrings(FSections.Objects[I]);
    I := Strings.IndexOfName(Ident);
    if (I >= 0) then
    begin
      Result := Copy(Strings[I], Length(Ident) + 2, Maxint);
      Exit;
    end;
  end;
  Result := Default;
end;

procedure TInMemIniFile.SetStrings(List: TStrings);
var
  I: Integer;
  S: string;
  Strings: TStrings;
begin
  Clear;
  Strings := nil;
  for I := 0 to (List.Count - 1) do
  begin
    S := List[I];
    if ((S <> '') and (S[1] <> ';')) then
      if ((S[1] = '[') and (S[Length(S)] = ']')) then
        Strings := AddSection(Copy(S, 2, Length(S) - 2))
      else
        if (Strings <> nil) then Strings.Add(S);
  end;
end;

procedure TInMemIniFile.WriteString(const Section, Ident, Value: String);
var
  I: Integer;
  S: string;
  Strings: TStrings;
begin
  I := FSections.IndexOf(Section);
  if (I >= 0) then
    Strings := TStrings(FSections.Objects[I]) else
    Strings := AddSection(Section);
  S := Ident + '=' + Value;
  I := Strings.IndexOfName(Ident);
  if (I >= 0) then Strings[I] := S else Strings.Add(S);
end;

procedure TInMemIniFile.UpdateFile;
var
  Ini, Tmp: TStrings;
  Idx1, Idx2, n: Integer;
  Text, Data: string;
{$IFDEF UseIniFile}
  SectionData: string;
{$ENDIF}
  h: THandle;

  procedure DeleteLine(List: TStrings; var Idx: Integer; const Line: string; Up: Boolean);
  var
    Index, n: Integer;
  begin
    Index := Idx;
    if (Up) and (Index > 0) then
    begin
      Dec(Index);
      n := Pos(Line, List[Index]);
      if (n > 0) then
      begin
        List[Index] := TrimRight(Copy(List[Index], 1, n - 1));
        if (List[Index] = '') then Idx := Index;
      end;
    end
    else
      if (not Up) and (Index < List.Count - 1) then
      begin
        Inc(Index);
        n := Pos(Line, List[Index]);
        if (n > 0) then
        begin
          List[Index] := TrimLeft(Copy(List[Index], n + Length(Line), Length(List[Index])));
          if (List[Index] = '') then Idx := Index;
        end;
      end;
  end;

begin
  Tmp := TStringList.Create;
  try
    GetStrings(Tmp);
    if ((Tmp.Count > 0) and (Tmp[Tmp.Count - 1] = '')) then Tmp[Tmp.Count - 1] := FLastLine
    else Tmp.Add(FLastLine);
    Tmp.Insert(0, FFirstLine);
    EncodeData(Tmp);
    Data := Tmp.Text;
  finally
    Tmp.Free;
  end;
{$IFDEF UseIniFile}
  SectionData := (Copy(Data, (Length(FSectionLine) + 7), Length(Data)) + #0);
  if WritePrivateProfileSection(PChar(FSectionLine), PChar(SectionData),
    PChar(FileName)) then Exit;
{$ENDIF}
  Ini := TStringList.Create;
  try
    if (FileExists(FileName)) then Ini.LoadFromFile(FileName);
    Text := Ini.Text;
    if (GetDataRange(Text, Idx1, Idx2) <> '') then // Found old data.
    begin
      DeleteLine(Ini, Idx1, FFirstLine, True);
      DeleteLine(Ini, Idx2, FLastLine, False);
      for n := 1 to (Idx2 - Idx1 + 1) do Ini.Delete(Idx1);
      Ini.Insert(Idx1, Trim(Data));
    end
    else
    begin // Not found any old data.
      if (FXMLLastLine <> '') then // Save in a XML file.
      begin
        Idx1 := Pos(FXMLLastLine, Text);
        if (Idx1 > 0) then Insert(Data, Text, Idx1)
        else Text := (Text + #13#10 + Data);
      end
      else // Store in a standard INI file.
      begin
        Text := (Text + #13#10 + Data);
      end;
      Ini.Text := Text;
    end;
    Ini.SaveToFile(FileName);
    if (FFileOK) then
    begin
      h := FileOpen(FileName, fmOpenReadWrite);
      SetFileTime(h, @FTime1, @FTime2, @FTime3);
      FileClose(h);
    end;
  finally
    Ini.Free;
  end;
end;

// Abstract methods...
procedure TInMemIniFile.DeleteKey(const Section, Ident: String);
begin
end;

procedure TInMemIniFile.EraseSection(const Section: string);
begin
end;

procedure TInMemIniFile.ReadSection(const Section: string; Strings: TStrings);
begin
end;

procedure TInMemIniFile.ReadSections(Strings: TStrings);
begin
end;

procedure TInMemIniFile.ReadSectionValues(const Section: string; Strings: TStrings);
begin
end;
{$ENDIF}

//------------------------------------------------------------------------------

function IncludeLastBackslash(Source: string): string;
begin
  Source := Trim(Source);
  if Source = '' then Result := '\'
  else
  begin
    Result := Source;
    if Copy(Source, length(Source), 1) <> '\' then Result := Result + '\';
  end;
end;

function IsXMLText(const Text: string): Boolean;
begin
  Result := (Pos('<?XML', UpperCase(Trim(Text))) > 0);
end;

function PosEx(const Subst, Source: string; idx: Integer): Integer;
begin
  Result := Pos(Subst, Copy(Source, idx, Length(Source)));
  if (Result > 0) then Inc(Result, idx - 1);
end;

function ProcessText(Text: string): string;
var
  n: Integer;
  IsXML: Boolean;

  function ElaborateText(XML: Boolean): Boolean;
  const
    Line1 = #13#10;
    Line2 = '\'#13#10;
    LastLine = '"/>'#13#10;
  var
    count, delta: Integer;
    LineEnd: string;
  begin
    if (XML) then LineEnd := Line1 else LineEnd := Line2;
    Result := False;
    delta := (Length(LastLine) - Length(LineEnd));
    if (Copy(Text, n, Length(LineEnd)) = LineEnd) and
      ((not XML) or (Copy(Text, n - delta, Length(LastLine)) <> LastLine)) then
    begin
      Delete(Text, n, Length(LineEnd));
      count := 0;
      while (n + count <= Length(Text)) and (Text[n + count] = ' ') do Inc(count);
      Delete(Text, n, count);
      Result := True;
    end;
  end;

begin
  n := 0;
  IsXML := (IsXMLtext(Text));
  while (n <= Length(Text)) do
    if (not ElaborateText(IsXML)) then Inc(n);
  Result := Text;
end;

function GetCppFileOptionValue(FileName, OptionName: string): string;
var
  Buffer: TStringList;
  Text, LineEnd: string;
  n: Integer;
begin
  Result := '';
  Buffer := TStringList.Create;
  try
    Buffer.LoadFromFile(FileName);
    Text := ProcessText(Buffer.Text);
  finally
    Buffer.Free;
  end;
  if (IsXMLText(Text)) then
  begin
    OptionName := '<' + OptionName + ' value="';
    LineEnd := '"/>';
  end
  else
  begin
    OptionName := #13#10 + OptionName + ' = ';
    LineEnd := #13#10;
  end;
  n := Pos(OptionName, Text);
  if (n > 0) then
  begin
    Inc(n, Length(OptionName));
    Result := Trim(Copy(Text, n, PosEx(LineEnd, Text, n) - n));
  end;
end;

function InternalIsAcceptableProject(const FileName: string): Boolean;
const
  DLLResWizard = '// Do not edit. This file is machine generated by the Resource DLL Wizard.';
var
  St: TStringList;
begin
  St := TStringList.Create;
  try
    St.Text := TBaseModule.GetText(FileName);
    Result := (St.Count = 0) or (St[0] <> DLLResWizard);
  finally
    St.Free;
  end;
end;

function GetImageData(HModule: THandle): TImageData;
begin
  with Result do
  begin
    Headers := PImageNtHeaders(HModule + PHeader(HModule).Offset);
    BaseOfCode := Headers^.OptionalHeader.BaseOfCode;
    ImageBase := Headers^.OptionalHeader.ImageBase;
    SizeOfHeaders := Headers^.OptionalHeader.SizeOfHeaders;
  end;
end;

procedure ModifyImportFunction(Mem: TMemoryStream; DLLName, ProcName: string;
  NewProcAddr: DWord);
var
  ThunkData: PThunk_Data;
  ImpF: PImport_Function;
  I, DeltaImp, DeltaRel, RelocEnd: DWord;
  Addr: PAsmLongJump;
  ImgData: TImageData;
  SecHead: PArrayImageSectionHeader;
  Reloc: PRelocationDescriptor;
  FuncName: string;

  function hModule: THandle;
  begin
    Result := THandle(Mem.Memory);
  end;

  function SecDelta(n: Integer): Integer;
  var
    I: Integer;
  begin
    Result := 0;
    for I := 0 to ImgData.Headers^.FileHeader.NumberOfSections - 1 do
      if (SecHead[I].VirtualAddress =
        ImgData.Headers^.OptionalHeader.DataDirectory[n].VirtualAddress) then
      begin
        Result := SecHead[I].VirtualAddress - SecHead[I].PointerToRawData;
        Break;
      end;
  end;

  function DLLNameFromThunkData(TD: PThunk_Data): string;
  var
    FT: DWord;
    Imp: PImportDescriptor;
  begin
    Imp := PImportDescriptor(hModule +
      ImgData.Headers^.OptionalHeader.DataDirectory[1].VirtualAddress - DeltaImp);
    FT := DWord(TD) - hModule + DeltaImp;
    Result := '';
    while (Imp^.Name <> 0) and (Imp^.FirstThunk < FT) do
    begin
      Result := UpperCase(PChar(hModule + Imp^.Name - DeltaImp));
      Inc(Imp);
    end;
  end;

begin
  DLLName := UpperCase(DLLName);
  ProcName := UpperCase(ProcName);

  ImgData := GetImageData(hModule);

  SecHead := PArrayImageSectionHeader(DWord(ImgData.Headers) +
    SizeOf(ImgData.Headers^));

  DeltaImp := SecDelta(1);
  DeltaRel := SecDelta(5);

  Reloc := PRelocationDescriptor(hModule +
    ImgData.Headers^.OptionalHeader.DataDirectory[5].VirtualAddress - DeltaRel);

  RelocEnd := (DWord(Reloc) +
    ImgData.Headers^.OptionalHeader.DataDirectory[5].Size - 1);

  while (DWord(Reloc) <= RelocEnd) do
  begin
    for I := 0 to (Reloc^.SizeOfBlock - 8) div 2 - 1 do
    begin
      if (Reloc^.TypeOffset[I] shr 12 = 3) then // Relocable address...
      begin
        Addr := PAsmLongJump(hModule + Reloc^.VirtualAddress -
          ImgData.BaseOfCode + ImgData.SizeOfHeaders +
          Reloc^.TypeOffset[I] and $FFF - 2);

        try // Used to avoid the overflow cases...
          if (Addr^.OpCode = $25FF) and // JMP...
            (Addr^.Addr >= ImgData.ImageBase + DeltaImp) and // Function addr.
            (Addr^.Addr <= ImgData.ImageBase + DWord(Mem.Size) - 4) then
          begin
            ThunkData := PThunk_Data(hModule + Addr^.Addr -
              ImgData.ImageBase - DeltaImp);
            if (ThunkData^.AddressOfData >= DeltaImp) and
              (ThunkData^.AddressOfData <= DWord(Mem.Size) - 4) then
            begin
              ImpF := PImport_Function(hModule +
                ThunkData^.AddressOfData - DeltaImp);
              FuncName := UpperCase(ImpF.Name);
              if (FuncName = ProcName) and
                (DLLNameFromThunkData(ThunkData) = DLLName) then
              begin
                PAsmJump(Addr)^.JMP_OpCode := $E9;
                PAsmJump(Addr)^.Distance := NewProcAddr -
                  (DWord(Addr) - hModule) - 5 + ImgData.SizeOfHeaders;
                PAsmJump(Addr)^.NOP_OpCode := $90;

                // Disable the address relocation...
                Reloc^.TypeOffset[I] := Reloc^.TypeOffset[I] and $FFF;
              end;
            end;
          end;
        except
          Break;
        end;
      end;
    end;
    Inc(DWord(Reloc), Reloc^.SizeOfBlock);
  end;
end;

// Elaborate the command-line compiler parameter...

procedure ElaborateParameter(Prm: string; Size: Integer; var Opt, Val: string);
var
  n: Integer;
begin
  // Remove spaces...
  Prm := Trim(Prm);

  // Remove initial quotes...
  if (length(Prm) > 0) and (Prm[1] = '"') and
    (Prm[length(Prm)] = '"') then
    Prm := Copy(Prm, 2, length(Prm) - 2);

  // Remove path quotes...
  n := 1;
  while (n <= Length(Prm)) do
    if (Prm[n] = '"') then Delete(Prm, n, 1) else Inc(n);

  // Set all options symbol to '-'...
  if (length(Prm) > 0) and (Prm[1] = '/') then Prm[1] := '-';

  Opt := UpperCase(Copy(Prm, 1, Size));
  Val := Copy(Prm, Size + 1, length(Prm));
end;

// This function kill spaces, linebreak (#13#10), directives and comments,
// from Txt string starting to Idx position char...

function KillInutilChars(Txt: string; var idx: integer; SkipDir: boolean): boolean;
var
  i, old, start: integer;
  s: string;
begin
  Result := False;
  repeat
    old := Idx;

    // Search spaces and "#13#10" chars...
    while (Idx <= Length(Txt)) and ((Txt[Idx] <= #32)) do Inc(Idx);

    // Search directives and comments...
    I := 0;
    while (I <= CommentsNumber) and
      (Copy(Txt, Idx, Length(StartComments[I])) <> StartComments[I]) do Inc(I);

    // Found a directive or comment "Start",
    // and search the "End"...
    if (I <= CommentsNumber) then
    begin
      start := Idx;
      Inc(Idx, Length(StartComments[I]));
      while (Idx <= Length(Txt)) and
        (Copy(Txt, Idx, Length(EndComments[I])) <> EndComments[I]) do Inc(Idx);
      if Idx <= Length(Txt) then
      begin
        Inc(Idx, Length(EndComments[I]));
        if (not SkipDir) then
        begin
          s := UpperCase(Copy(Txt, start, Idx - start));
          if (Copy(s, 1, 2) = '(*') then s := Copy(s, 3, Length(s) - 4)
          else
            if (Copy(s, 1, 1) = '{') then s := Copy(s, 2, Length(s) - 2);
          if (Copy(s, 1, 1) = '$') then // Check for a directive.
          begin
            i := 1;
            while (i <= Length(s)) do
              if (Copy(s, i, 2) = '  ') then Delete(s, i, 1) else Inc(i);
            if (s <> '$IFDEF EUREKALOG') then
            begin
              Idx := start;
              Result := True;
              Exit;
            end;
          end;
        end;
      end;
    end;
    Result := (Result) or (Idx <> old);
  until Idx = old;
end;

procedure WriteStrings(Cnf: TInternalIniFile; Section, CountName, Prefix: string; Value: string);
var
  I: Integer;
  Tmp: TStringList;
begin
  Tmp := TStringList.Create;
  Tmp.Text := Value;
  Cnf.WriteInteger(Section, CountName, Tmp.Count);
  for I := 0 to Tmp.Count - 1 do
  begin
    Cnf.WriteString(Section, Prefix + IntToStr(I), '"' + Tmp[I] + '"');
  end;
  Tmp.Free;
end;

procedure ReadStrings(Cnf: TInternalIniFile; Section, CountName, Prefix, Default: string;
  var Value: string);
var
  I, C: Integer;
  Tmp: TStringList;
  s: string;
begin
  Tmp := TStringList.Create;
  C := Cnf.ReadInteger(Section, CountName, 0);
  if C > 0 then
    for I := 0 to C - 1 do
    begin
      s := Cnf.ReadString(Section, Prefix + IntToStr(I), Default);
      if (Length(s) > 1) and (s[1] = '"') and (s[Length(s)] = '"') then
        s := Copy(s, 2, Length(s) - 2);
      Tmp.Add(s);
    end
  else
    Tmp.Add(Default);
  Value := Tmp.Text;
  if (Length(Value) > 1) and (Copy(Value, length(Value) - 1, 2) = #13#10) then
    Delete(Value, Length(Value) - 1, 2);
  Tmp.Free;
end;

procedure ReadKeyList(Root: HKey; Key: string; List: TStrings);
var
  Reg: HKey;
  Len: DWORD;
  I, KCount, KLen: Integer;
  S: string;
begin
  List.Clear;
  if (Key <> '') and (Key[1] = '\') then Delete(Key, 1, 1);
  if RegOpenKeyEx(Root, PChar(Key), 0, KEY_READ, Reg) = ERROR_SUCCESS then
  begin
    if RegQueryInfoKey(Reg, nil, nil, nil, nil, nil,
      nil, @KCount, @KLen, nil, nil, nil) = ERROR_SUCCESS then
    begin
      SetString(S, nil, KLen + 1);
      for I := 0 to KCount - 1 do
      begin
        Len := KLen + 1;
        RegEnumValue(Reg, I, PChar(S), Len, nil, nil, nil, nil);
        S := Copy(S, 1, Len) + '=' + ReadKey(Root, Key, S);
        List.Add(PChar(S));
      end;
    end;
    RegCloseKey(Reg);
  end;
end;

// This function returns the Option File Extension...

function OptionFileExt(const FileName: string): string;
begin
  Result := CurrentPersonality.GetOptionValue(otOptionFileExt, FileName)
end;

function OldOptionFileExt(const FileName: string): string;
begin
  Result := CurrentPersonality.GetOptionValue(otOldOptionFileExt, FileName)
end;

function EurekaLogFirstLine(const FileName: string): string;
begin
  Result := CurrentPersonality.GetOptionValue(otOptionFileFirstLine, FileName);
end;

function EurekaLogLastLine(const FileName: string): string;
begin
  Result := CurrentPersonality.GetOptionValue(otOptionFileLastLine, FileName);
end;

// This function returns the "DefProj.elf" complete Path...

function DefaultOptionFile: string;
begin
  if (CurrentPersonality.GetPersonality = ptDelphiWin32) then
    Result := (RADDir + '\Bin\' + 'DefProj.dof')
  else
    Result := (RADDir + '\Bin\' + 'Default.bpr');
end;

function EurekaDefaultOptionFile: string;
begin
  Result := ChangeFileExt(DefaultOptionFile, '.eof');
end;

procedure EnvironmentStringsToList(List: TStrings);
var
  Env, Ptr: PChar;
  ThisVar: string;
begin
  ReadKeyList(HKEY_CURRENT_USER, RADRegKeyName + '\Environment Variables', List);
  Env := GetEnvironmentStrings;
  if Assigned(Env) then
  try
    Ptr := Env;
    while Ptr^ <> #0 do
    begin
      ThisVar := StrPas(Ptr);
      Inc(Ptr, Length(ThisVar) + 1);
      if (List.IndexOf(ThisVar) = -1) then List.Add(ThisVar);
    end;
  finally
    FreeEnvironmentStrings(Env);
  end;
  if (List.Values[DEFINEDirName] = '') then List.Add(DEFINEDirName + '=' + RADDir);
end;

// This function converts "$(DELPHI/BCB)\xx\yy" syntax into real path...

function AdjustDir(Dir: string; WithFile: Boolean): string;
var
  I, J: Integer;
  Name, Value: string;
  Variables: TStringList;
begin
  Result := Dir;
  if (Pos('$', Dir) = 0) and (ExtractFilePath(Dir) = '') then Exit;

  Variables := TStringList.Create;
  EnvironmentStringsToList(Variables);
  try
    while (Pos('$(', Dir) > 0) do
    begin
      I := Pos('$(', Dir);
      J := Pos(')', Copy(Dir, I + 2, Length(Dir)));
      if J > 0 then
      begin
        Name := Copy(Dir, I + 2, J - I);
        Value := Variables.Values[Name];
        Dir := Copy(Dir, 1, I - 1) + Value +
          Copy(Dir, I + Length(Name) + 3, Length(Dir));
      end;
    end;
    if (not WithFile) and (Dir <> '') and (Dir[Length(Dir)] <> '\') then Dir := Dir + '\';
    Result := Dir;
  finally
    Variables.Free;
  end;
end;

function TBaseModule.BuildMapFile: Boolean;
const
  // Consts uses for Map parsing...
  LineStr = 'Line numbers for ';
  SegmentsStr = 'Detailed map of segments';
  StartStr0 = ' Start         Length     Name                   Class';
  StartStr1 = ' Start Length Name Class'; // For CBuilder 6 linker

{$IFDEF Delphi10Up}
  PublicStrDelphi = '  Address             Publics by Value';
{$ELSE}
  PublicStrDelphi = '  Address         Publics by Value';
{$ENDIF}

  PublicStrCppBuilder = '  Address         Publics by Value';

  ICODESeg = '2';

  SymbolNames: array[0..SymbolsCount - 1] of string = (
    VCL_Const, {VCL Applications}
    VCL_Const2, {VCL Applications}
    CLX_Const, {CLX Applications}
    CLX_Const2, {CLX Applications}
    ISAPI_Const, {ISAPI Applications}
    CGI_Const, {CGI Applications}
    IWebSrv_Const, {IntraWeb Server Controller}
    IWebApp_Const, {IntraWeb Application}
    IWebRes_Const, {IntraWeb HTTPAppResponse}
    NTService_Const, {NT Services}
    IndyThread_Const, {Indy Threads}
    ClassesInit_Const, {Classes.Initialization}    
    ClassesFInit_Const, {Classes.Finalization}
    VariantsFInit_Const, {Variants.Finalization}
    SysUtilsInit_Const, {SysUtils.Initialization}    
    SysUtilsFInit_Const, {SysUtils.Finalization}
    SystemFInit_Const, {System.Finalization}
    ELeaksFInit_Const, {ELeaks.Finalization}
    ExceptionLogFInit_Const, {ExceptionLog.Finalization}
    FastMM4FInit_Const {FastMM4.Finalization}        
    );

  // Hooked functions inside the Win32 PE file...
  HookedFunctions: array[0..6] of TFuncRecord = (
    (DLL: Kernel32; Proc: 'RaiseException'; Hook: 'ExceptionLog.HookedRaise'),
    (DLL: Kernel32; Proc: 'CreateThread'; Hook: 'ExceptionLog.HookedCreateThread'),
    (DLL: Kernel32; Proc: 'ResumeThread'; Hook: 'ExceptionLog.HookedResumeThread'),
    (DLL: Kernel32; Proc: 'ExitThread'; Hook: 'ExceptionLog.HookedExitThread'),
    (DLL: Kernel32; Proc: 'RtlUnwind'; Hook: 'ExceptionLog.HookedRtlUnwind'),
    (DLL: Kernel32; Proc: 'WriteFile'; Hook: 'ExceptionLog.HookedWriteFile'),
    (DLL: Kernel32; Proc: 'UnhandledExceptionFilter'; Hook: 'ExceptionLog.HookedUnhandledExceptionFilter'));

  // Diagram of compression method...
  //----------------------------------------------------------------------------
  //
  //        |=0 -> 1 byte (2 bits Line, 5 bits Addr - w/o ProcName)
  // Bit 0 -|
  //        |             |=0 -> 1 byte (3 bits Line, 3 bits Addr - with ProcName)
  //        |=1 -> Bit 1 -|
  //                      |               |=0 -> 2 bytes (5 bits Line, 7 bits Addr)
  //                      |      | Bit 3 -|
  //                      |      |        |=1 -> 4 bytes (12 bits Addr, 16 bits Line
  //                      |=1 -> |                                      as SmallInt)
  //                             |        |=0 -> w/o ProcName
  //                             | Bit 2 -|
  //                                      |=1 -> with ProcName
  //
  //----------------------------------------------------------------------------

type
  TUnitRec = record
    UnitName: String;
    FirstLineNo, StartAddr, UnitSize, NextUnit: DWord;
  end;
  PUnitRec = ^TUnitRec;

var
  SegClass: array [0..15] of Char;
  FunctionsAddr: array[low(HookedFunctions)..high(HookedFunctions)] of DWord;
  MapPos, StartMap, EndMap, OldMapPos: PChar;
  StartAddr, UnitSize, NextUnit, ProcedureIdx, StartProc,
    ProcedureCount, UnitSizePos, OldPos, ProcAddr, ProcSize, UnitEnd: DWord;
  FoundProc, Index, Finish, SymbolsSize, EndProc: Integer;
  PublicStr, MasterUnit, LastUnitName, UnitName, ProcedureName, LastClassName,
    NewClassName, UnitExt: String;
  CodeSegment: Char;
  CodeSegments: set of Char;
  InitBaseAddr, StartCODESeg, StartICODESeg, LastLine, LineNo, LastAddr,
    LastBaseAddr, LineAddr, AddrDiff, UnitsNumber, UnitsNumberPos, MagicWord: DWord;
  LineDiff: SmallInt;
  ProcedureList: TStringList;
  CompilationDate: TDateTime;
  OptionsStream, OutputStream, LineStream, ExeStream, SymbolsStream: TMemoryStream;
  DotIdx: Byte;
  FByte: Byte;
  FWord: Word;
  FDWord: DWord;
  DebugSize, UnitIdx: integer;
  ProcedureOK, FirstInitAddr: Boolean;
  IsICODESeg: Boolean;  
  UnitRec: PUnitRec;
  UnitList: TList;
  ZResPointer, ZResPointer2: Pointer;
  ZResSize, ZResSize2: Integer;
  CurrentUnit, SpacesUnitProc: Integer;
  MemoryLeaksState: Byte;
  UseMainModuleOptions: Boolean;

  // Read a Hex (8 chars) value from current map (MapPos) position...

  function ReadHex: DWord;
  var
    i: integer;
    Mul: DWord;
    c: Byte;
  begin
    Result := 0;
    Mul := 32;
    for i := 0 to 7 do
    begin
      c := PByte(MapPos)^;
      case Char(c) of
        '0'..'9': dec(c, 48);
        'A'..'F': dec(c, 55);
        'a'..'f': dec(c, 87);
      end;
      Dec(Mul, 4);
      Inc(Result, c shl Mul);
      Inc(MapPos);
    end;
  end;

  // Read a Word (6 chars) value from current map (MapPos) position...

  function ReadInt: DWord;
  var
    i: integer;
    Mul: DWord;
    c: Byte;
  begin
    Result := 0;
    Mul := 100000;
    for i := 0 to 5 do
    begin
      c := PByte(MapPos)^;
      if c <> 32 then // 32 = ASCII space code.
      begin
        c := c - 48;
        Inc(Result, c * Mul);
      end;
      Mul := Mul div 10;
      Inc(MapPos);
    end;
  end;

  // Read a String from current map (MapPos) position...

  function ReadString(SkipFirstDot: Boolean): string;
  const
    EndChars0: set of char = [#13, #0, '(', ')'];
    EndChars1: set of char = [')'];
  var
    Start: PChar;
    EndChars: set of char;
  begin
    if (MapPos^ = '(') then
    begin
      EndChars := EndChars1;
      Inc(MapPos);
    end
    else
    begin
      EndChars := EndChars0;
      if (CurrentPersonality.GetPersonality = ptDelphiWin32) then EndChars := (EndChars + [' ']);
    end;

    if (SkipFirstDot) then
    begin
      while (not (MapPos^ in EndChars)) and (MapPos^ <> '.') do Inc(MapPos);
      if (MapPos^ = '.') then Inc(MapPos);
    end;
    Start := MapPos;
    while not (MapPos^ in EndChars) do Inc(MapPos);
    SetString(Result, Start, MapPos - Start);
  end;

  function ExtractProcName(const Src: string): string;
  var
    idx: integer;
    UntName: string;
  begin
    // Remove the Unit Name...
    idx := Pos('.', Src);
    if idx > 0 then
    begin
      UntName := UpperCase(Copy(Src, 1, idx - 1));
      if UntName = UpperCase(PUnitRec(UnitList[CurrentUnit])^.UnitName) then
        Result := Copy(Src, idx + 1, 255)
      else Result := Src;
    end
    else Result := Src;
  end;

  function ExtractUnitName(const Src: string): string;
  var
    idx: integer;
  begin
    idx := Pos(' ACBP=', Src);
    if idx > 0 then
      Result := Copy(Src, 1, idx - 1)
    else
      Result := Src;

    idx := Pos('|', Result);
    if idx > 0 then
      Result := Copy(Result, idx + 1, 255)
    else
      Result := ChangeFileExt(ExtractFileName(Result), '');
  end;

{$IFDEF Delphi10Up}
  function ExtractProcedureName(const Src: string): string;
  var
    Idx: Integer;
  begin
    Idx := Pos('.', Src);
    if (Idx = 0) then Result := Src
    else
    begin

    end;
  end;
{$ENDIF}

  // This function try go to the next line...

  function GoToNextLine: boolean;
  begin
    while not (MapPos^ in [#10, #0]) do
      Inc(MapPos);
    if MapPos^ = #10 then
    begin
      inc(MapPos);
      result := true;
    end
    else
      result := false;
  end;

  // This function try to skip the n lines...

  function SkipLines(n: integer): boolean;
  var
    i: integer;
  begin
    i := 0;
    while (i < n) and (GoToNextLine) do
      Inc(i);
    Result := (i = n);
  end;

  // This function search a specific section from current map (MapPos) position...

  function GotoSection(Section: string; EndLine: Boolean): boolean;
  var
    NewPos: PChar;
    St: string;
  begin
    Result := False;
    NewPos := MapPos;
    while (NewPos < EndMap) and (not Result) do
    begin
      if NewPos^ <> #13 then // Check for End Of Line.
        Inc(NewPos)
      else
      begin
        if ((NewPos + 4)^ = Section[3]) and
          ((NewPos + 3)^ = Section[2]) and
          ((NewPos + 2)^ = Section[1]) then
        begin
          SetString(St, NewPos + 2, Length(Section));
          Result := (Section = St);
        end;
        Inc(NewPos);
      end;
    end;
    if Result then
    begin
      MapPos := NewPos + 1;
      if EndLine then
        GoToNextLine
      else
        Inc(MapPos, Length(Section));
    end;
  end;

  // This function find the first line were "column" position contain "val"...
  // WARNING - Use it only starting from line start...

  function FindFirstLine(column: integer; val: char): boolean;
  var
    NewPos: PChar;
  begin
    Result := False;
    NewPos := MapPos;
    repeat
      if (NewPos + column < EndMap) and ((NewPos + column)^ = val) then
      begin
        Result := True;
        MapPos := NewPos;
      end
      else
      begin
        while not (NewPos^ in [#10, #0]) do
          inc(NewPos);
        if NewPos^ = #10 then
          Inc(NewPos);
      end;
    until (Result) or (NewPos = EndMap);
  end;

  // This function Encrypt the string...
  procedure WriteString(Stream: TStream; st: String; ClassAndProcName: Boolean);
  var
    B, Dot: Byte;
    Classname, ProcName: string;
  begin
    Dot := Pos('.', st);
    ClassAndProcName := (ClassAndProcName and (Dot > 0));
    if (not ClassAndProcName) then
    begin
      B := Length(st);
      Stream.Write(B, 1);
      Encrypt(st[1], st[1], B);
      Stream.Write(st[1], B);
    end
    else
    begin
      ClassName := Copy(st, 1, Dot - 1);
      ProcName := Copy(st, Dot + 1, Length(st));

      // Write string length (and $80 Class-present bit)...
      B := (Length(ClassName) or $80);
      Stream.Write(B, 1);

      // Write Class name...
      B := Length(ClassName);
      Encrypt(ClassName[1], ClassName[1], B);
      Stream.Write(ClassName[1], B);

      // Write Procedure name...
      WriteString(Stream, ProcName, False);
    end;
  end;

  function SimpleUnitName(const FileName: string): string;
  var
    Idx: Integer;
  begin
    Idx := Pos('.', FileName);
    if (Idx > 0) then Result := Copy(FileName, 1, (Idx - 1))
    else Result := FileName;
  end;

  procedure MapError(ErrorCode: Integer);
  begin
    raise Exception.CreateFmt(EDebugInfoNotActive, [MapFile, ErrorCode]);
  end;

  function FindUnit(UnitName: string; Idx: Integer): Integer;
  var
    I: Integer;
  begin
    UnitName := UpperCase(UnitName);
    Result := -1;
    for i := Idx to UnitList.Count - 1 do
      if (UpperCase(PUnitRec(UnitList[i])^.UnitName) = UnitName) then
      begin
        Result := i;
        Break;
      end;
  end;

  function FindProcByAddr(Addr: DWord): Integer;
  var
    L, H, I, C: Integer;
  begin
    Result := -1;
    L := 0;
    H := ProcedureList.Count - 1;
    while L <= H do
    begin
      I := (L + H) shr 1;
      if ((I = 0) and (Addr < DWord(ProcedureList.Objects[I]))) or
        ((I > 0) and ((Addr > DWord(ProcedureList.Objects[I - 1])) and
        (Addr <= DWord(ProcedureList.Objects[I])))) then C := 0
      else
        C := DWord(ProcedureList.Objects[I]) - Addr;
      if C < 0 then
        L := I + 1
      else
      begin
        H := I - 1;
        if C = 0 then
          Result := I;
      end;
    end;
  end;

  function GetProcedureBySymbol(SymbolName: string): Integer;
  var
    Index, UnitIndex: Integer;
    UnitName, ProcedureName: string;
  begin
    Result := -1;
    UnitName := UpperCase(Copy(SymbolName, 1, Pos('.', SymbolName) - 1));
    ProcedureName := UpperCase(Copy(SymbolName, length(UnitName) + 2, 255));
    UnitIndex := -1;
    repeat
      UnitIndex := FindUnit(UnitName, UnitIndex + 1);
      if (UnitIndex <> -1) then
      begin
        UnitEnd := PUnitRec(UnitList[UnitIndex])^.StartAddr +
          PUnitRec(UnitList[UnitIndex])^.UnitSize - 1;
        EndProc := FindProcByAddr(UnitEnd);
        if (EndProc <> -1) then
        begin
          Dec(EndProc);
          StartProc := FindProcByAddr(PUnitRec(UnitList[UnitIndex])^.StartAddr);
          if (StartProc <> DWord(-1)) then
          begin
            for Index := StartProc to EndProc do
            begin
              if (UpperCase(ProcedureList[Index]) = ProcedureName) then Result := Index
              else
                if (Result <> -1) then Break;
            end;
  {$IFDEF Delphi10Up}
            if (Result = -1) then
            begin
              StartProc := (FindProcByAddr(PUnitRec(UnitList[UnitList.Count - 1])^.StartAddr) + 1);
              EndProc := (ProcedureList.Count - 1);
              for Index := StartProc to EndProc do
              begin
                if (UpperCase(ProcedureList[Index]) = ProcedureName) then
                begin
                  Result := Index;
                  Break;
                end;
              end;
            end;
  {$ENDIF}
          end;
        end;
      end;
    until (CurrentPersonality = TDelphiWin32Personality) or
      ((Result <> -1) or (UnitIndex = -1));

    // Try to search the Symbol directly on the Procedures list!
    // NOTE: A WorkAround for the incomplete .MAP files.
    if ((Result = -1) and (CurrentPersonality = TCppBuilderWin32Personality)) then
    begin
      Result := ProcedureList.IndexOf(SymbolName);
    end;
  end;

  // Check the Delphi7Up unit names (ex: MainForm.General.MyProject.pas)...
  function TwoDots(const S: string): Boolean;
  {$IFDEF Delphi7Up}
  var
    n, c: Integer;
  {$ENDIF}
  begin
    Result := False;
{$IFDEF Delphi7Up}
    c := 0;
    for n := 1 to Length(S) do
      if (S[n] = '.') then
      begin
        Inc(c);
        if (c = 2) then
        begin
          Result := True;
          Exit;
        end;
      end;
{$ENDIF}
  end;

  function DebugNotFoundProcedure: Boolean;
  begin
    Result := ECore.ReadBool(EurekaIni, 'IDE', 'DebugNotFoundProcedure', False);
    ECore.WriteBool(EurekaIni, 'IDE', 'DebugNotFoundProcedure', Result);
  end;

  procedure StripRelocationTable(Data: TStream);
  const
    IMAGE_NT_OPTIONAL_HDR32_MAGIC = $10B;
    Buffer_Size = $100000; // 1MByte
  type
    PPESectionHeaderArray = ^TPESectionHeaderArray;
    TPESectionHeaderArray = array[0..$7FFFFFFF div SizeOf(TImageSectionHeader) - 1] of TImageSectionHeader;
  var
    EXESig: Word;
    PEHeaderOffset, PESig: DWord;
    PEHeader: TImageFileHeader;
    PEOptHeader: TImageOptionalHeader;
    PESectionHeaders: PPESectionHeaderArray;
    BytesLeft, Bytes: DWord;
    Buffer: Pointer;
    I: Integer;
    RelocVirtualAddr, RelocPhysOffset, RelocPhysSize: DWord;
    TmpStream: TMemoryStream;
  begin
    PESectionHeaders := nil;
    try
      RelocPhysOffset := 0;
      RelocPhysSize := 0;

      Data.Position := 0;

      Data.Read(EXESig, SizeOf(EXESig));
      if (EXESig <> $5A4D {'MZ'}) then Exit;

      Data.Position := $3C;
      Data.Read(PEHeaderOffset, SizeOf(PEHeaderOffset));
      if (PEHeaderOffset = 0) then Exit;

      Data.Position := PEHeaderOffset;
      Data.Read(PESig, SizeOf(PESig));
      if (PESig <> $00004550 {'PE'#0#0}) then Exit;

      Data.Read(PEHeader, SizeOf(PEHeader));
      if (PEHeader.Characteristics and IMAGE_FILE_DLL <> 0) then Exit;

      if (PEHeader.Characteristics and IMAGE_FILE_RELOCS_STRIPPED <> 0) then Exit;

      PEHeader.Characteristics := PEHeader.Characteristics or IMAGE_FILE_RELOCS_STRIPPED;
      if (PEHeader.SizeOfOptionalHeader <> SizeOf(PEOptHeader)) then Exit;

      Data.Read(PEOptHeader, SizeOf(PEOptHeader));
      if (PEOptHeader.Magic <> IMAGE_NT_OPTIONAL_HDR32_MAGIC) then Exit;

      if (PEOptHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_BASERELOC].VirtualAddress = 0) or
        (PEOptHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_BASERELOC].Size = 0) then Exit;

      RelocVirtualAddr := PEOptHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_BASERELOC].VirtualAddress;
      PEOptHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_BASERELOC].VirtualAddress := 0;
      PEOptHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_BASERELOC].Size := 0;
      PEOptHeader.CheckSum := 0;
      GetMem(PESectionHeaders, PEHeader.NumberOfSections * SizeOf(TImageSectionHeader));
      Data.Read(PESectionHeaders^, PEHeader.NumberOfSections * SizeOf(TImageSectionHeader));
      for I := 0 to (PEHeader.NumberOfSections - 1) do
      begin
        with PESectionHeaders[I] do
          if (VirtualAddress = RelocVirtualAddr) and (SizeOfRawData <> 0) then
          begin
            RelocPhysOffset := PointerToRawData;
            RelocPhysSize := SizeOfRawData;
            SizeOfRawData := 0;
            Break;
          end;
      end;
      if (RelocPhysOffset = 0) then Exit;

      if (RelocPhysSize = 0) then Exit;

      for I := 0 to (PEHeader.NumberOfSections - 1) do
      begin
        with PESectionHeaders[I] do
        begin
          if PointerToRawData > RelocPhysOffset then
            Dec(PointerToRawData, RelocPhysSize);
          if PointerToLinenumbers > RelocPhysOffset then
            Dec(PointerToLinenumbers, RelocPhysSize);
          if (PointerToRelocations <> 0) then Exit;
        end;
      end;
      if (PEOptHeader.ImageBase < $400000) then Exit;

      Data.Position := 0;
      try
        TmpStream := TMemoryStream.Create;
        try
          GetMem(Buffer, Buffer_Size);
          try
            BytesLeft := RelocPhysOffset;
            while (BytesLeft <> 0) do
            begin
              Bytes := BytesLeft;
              if (Bytes > Buffer_Size) then Bytes := Buffer_Size;
              Data.Read(Buffer^, Bytes);
              TmpStream.Write(Buffer^, Bytes);
              Dec(BytesLeft, Bytes);
            end;
            Data.Position := (Data.Position + Integer(RelocPhysSize));
            BytesLeft := (Data.Size - Data.Position);
            while (BytesLeft <> 0) do
            begin
              Bytes := BytesLeft;
              if (Bytes > Buffer_Size) then Bytes := Buffer_Size;
              Data.Read(Buffer^, Bytes);
              TmpStream.Write(Buffer^, Bytes);
              Dec(BytesLeft, Bytes);
            end;
            TmpStream.Position := (PEHeaderOffset + SizeOf(PESig));
            TmpStream.Write(PEHeader, SizeOf(PEHeader));
            TmpStream.Write(PEOptHeader, SizeOf(PEOptHeader));
            TmpStream.Write(PESectionHeaders^,
              PEHeader.NumberOfSections * SizeOf(TImageSectionHeader));
            TmpStream.Position := 0;
            Data.Position := 0;
            Data.CopyFrom(TmpStream, TmpStream.Size);
            Data.Size := TmpStream.Size;
          finally
            FreeMem(Buffer);
          end;
        finally
          TmpStream.Free;
        end;
      except
        // Nothing...
      end;
    finally
      FreeMem(PESectionHeaders);
    end;
  end;

  procedure CalcCrc32(Data: TMemoryStream);
  var
    OptHeader: PImageOptionalHeader;
  begin
    if (PWord(Data.Memory)^ <> $5A4D {MZ}) then Exit;
    
    OptHeader := PImageOptionalHeader(DWord(Data.Memory) + PDWord(DWord(Data.Memory) + $3C)^ + $18);
    OptHeader^.CheckSum := 0;
    OptHeader^.CheckSum := GetCRC32(Data.Memory, Data.Size);
  end;

begin // BuildMapFile...
  Result := False;
  if FileExists(MapFile) then
  begin
    if (CurrentPersonality.GetPersonality = ptCppBuilderWin32) then
    begin
      SpacesUnitProc := 35;
      CompleteMapFile(MapFile); // To add the Source Line addr into the MapFile...
      PublicStr := PublicStrCppBuilder;
    end
    else
    begin
      SpacesUnitProc := 36;
      PublicStr := PublicStrDelphi;      
    end;

    // Open and read the Map File...
    with TFileStream.Create(MapFile, fmOpenRead or fmShareDenyNone) do
    begin
      GetMem(MapPos, Size + 1);
      StartMap := MapPos;
      EndMap := StartMap + Size;
      EndMap^ := #0; // Set the terminated char (#0).
      ReadBuffer(MapPos^, Size);
      Free;
    end;

    // Search for "START" section...
    if GoToSection(StartStr0, True) or
      ((CurrentPersonality.GetPersonality = ptCppBuilderWin32) and
      GoToSection(StartStr1, True)) then
    begin
      FindFirstLine(49, 'C');
      CodeSegment := (MapPos + 4)^; // Set the CodeSegment number.
      // Search for "SEGMENTS" section...
      // --------------------------------
      // - All Unit names (dcu and pas) -
      // --------------------------------
      if GoToSection(SegmentsStr, True) then
      begin
        GoToNextLine;
        FindFirstLine(4, CodeSegment);
        UnitList := TList.Create;

        // Filter only the "CODE" segment...
        while (MapPos + 4)^ = CodeSegment do
        begin
          Inc(MapPos, 6);
          New(UnitRec);
          UnitRec.StartAddr := ReadHex;
          Inc(MapPos, 1);
          UnitRec.UnitSize := ReadHex;
          Inc(MapPos, SpacesUnitProc);
          if (CurrentPersonality.GetPersonality = ptDelphiWin32) then
            UnitRec.UnitName := ReadString(False)
          else
            UnitRec.UnitName := ExtractUnitName(ReadString(False));
          UnitRec.FirstLineNo := 0;
          UnitRec.NextUnit := 0;
          UnitList.Add(UnitRec);
          GoToNextLine; // Skip to the next line.
        end;

        // Search for "PUBLIC" section...
        // -------------------------------------
        // - Class method and procedure names. -
        // -------------------------------------
        if GoToSection(PublicStr, True) then
        begin
          CurrentUnit := 0;
          GoToNextLine;
          FindFirstLine(4, CodeSegment);
          ProcedureList := TStringList.Create;

          StrLCopy(SegClass, (StartMap + 138), 6);
          if (SegClass = '.itext') then
          begin
            OldMapPos := MapPos;
            MapPos := (StartMap + 64);
            StartCODESeg := ReadHex;
            MapPos := (StartMap + 119);
            StartICODESeg := ReadHex;
            MapPos := OldMapPos;
            InitBaseAddr := (StartICODESeg - StartCODESeg);
          end
          else InitBaseAddr := 0;

          CodeSegments := [CodeSegment];
{$IFDEF Delphi10Up}
          CodeSegments := (CodeSegments + [ICODESeg]);
{$ENDIF}

          // Filter only the "CODE" segment...
          while ((MapPos + 4)^ in CodeSegments) do
          begin
            if (CurrentPersonality.GetPersonality = ptCppBuilderWin32) or
              ((MapPos + 21)^ <> '.') then // Filter only the visible procedures...
            begin
{$IFDEF Delphi10Up}
              IsICODESeg := ((MapPos + 4)^ = ICODESeg);
{$ENDIF}
              Inc(MapPos, 6);
              StartAddr := ReadHex;
{$IFDEF Delphi10Up}
              if (IsICODESeg) then Inc(StartAddr, InitBaseAddr);
{$ENDIF}
              Inc(MapPos, 7);
              if (CurrentPersonality.GetPersonality = ptDelphiWin32) then
              begin
{$IFDEF Delphi10Up}
                ProcedureName := ReadString(True);
{$ELSE}
                ProcedureName := ReadString(False);
{$ENDIF}
                ProcedureList.AddObject(ProcedureName, TObject(StartAddr));
              end
              else
              begin
                while (PUnitRec(UnitList[CurrentUnit])^.StartAddr +
                  PUnitRec(UnitList[CurrentUnit])^.UnitSize < StartAddr) and
                  (CurrentUnit < UnitList.Count - 1) do
                  inc(CurrentUnit);

                ProcedureName := ExtractProcName(ReadString(False));
                if (ProcedureName <> '') then // Check for '__tpdsc__' directive...
                  ProcedureList.AddObject(ProcedureName, TObject(StartAddr));
              end;
            end;
            GoToNextLine;
          end;
          // Create the "Extra Debug Info" stream...
          LineStream := TMemoryStream.Create;

          // Search for "SYMBOLS" info...
          // -----------------------------
          // -  Store the Symbol Names.  -
          // -----------------------------
          if (ModuleType <> mtPackage) then
          begin
            Finish := high(HookedFunctions);
            if (CurrentPersonality.GetPersonality = ptDelphiWin32) then Dec(Finish);

            for Index := low(HookedFunctions) to Finish do
            begin
              FoundProc := GetProcedureBySymbol(HookedFunctions[Index].Hook);
              if (FoundProc <> -1) then
                FunctionsAddr[Index] := DWord(ProcedureList.Objects[FoundProc])
              else
                if DebugNotFoundProcedure then
                  raise Exception.CreateFmt('Cannot find the "%s" procedure.',
                    [HookedFunctions[Index].Hook]);
            end;
          end;
          SymbolsStream := TMemoryStream.Create;
          try
            SymbolsSize := 0;
            SymbolsStream.Write(SymbolsSize, 4);
            for Index := low(SymbolNames) to high(SymbolNames) do
            begin
              FoundProc := GetProcedureBySymbol(SymbolNames[Index]);
              if (FoundProc <> -1) then
              begin
                // Storing the procedure info...
                SymbolsStream.Write(Byte(Index), 1);
                ProcAddr := DWord(ProcedureList.Objects[FoundProc]);
                SymbolsStream.Write(ProcAddr, 4);
                if (FoundProc < EndProc) then
                  ProcSize := (DWord(ProcedureList.Objects[FoundProc + 1]) - ProcAddr)
                else
                  ProcSize := (UnitEnd - ProcAddr + 1);
                SymbolsStream.Write(ProcSize, 4);
              end;
            end;
            // Write the SymbolsSize...
            SymbolsStream.Position := 0;
            SymbolsSize := (SymbolsStream.Size - 4);
            SymbolsStream.Write(SymbolsSize, 4);

            // Search for "LINE" section...
            // -------------------------------
            // - Unit name and Line address. -
            // -------------------------------
            // Encrypt the compressed data...
            InitKey(EncryptPassword);

            ProcedureIdx := 0;
            ProcedureCount := ProcedureList.Count;

            LastUnitName := '';
            UnitsNumber := 0;
            UnitsNumberPos := LineStream.Position;
            LineStream.Write(UnitsNumber, 4);
            while GoToSection(LineStr, False) do
            begin
              Inc(UnitsNumber);
              MasterUnit := ReadString(False);
              UnitName := ExtractFileName(ReadString(False));
              if (UnitName = LastUnitName) then
              begin
                LastBaseAddr := InitBaseAddr;
                FirstInitAddr := True;
              end
              else
              begin
                LastBaseAddr := 0;
                FirstInitAddr := False;
              end;
              LastUnitName := UnitName;
              UnitExt := ExtractFileExt(UnitName);
              if (CurrentPersonality.IsOptionEqual(UnitExt, otSourceFileExt, UnitName)) and
                (not TwoDots(UnitName)) then
                Delete(UnitName, (Length(UnitName) - Length(UnitExt) + 1), Length(UnitExt));
              SkipLines(2);
              LineNo := ReadInt;
              Inc(MapPos, 6);
              StartAddr := (ReadHex + LastBaseAddr);
              LineAddr := StartAddr;
              Dec(MapPos, 20);
              WriteString(LineStream, UnitName, False);
              LineStream.Write(LineNo, 4);
              LineStream.Write(StartAddr, 4);
              UnitSizePos := LineStream.Position;
              UnitSize := 0;
              LineStream.Write(UnitSize, 4);
              NextUnit := 0;
              LineStream.Write(NextUnit, 4);

              // Read the line number and address...
              LastLine := LineNo;
              LastAddr := LineAddr;
              LastClassName := '';
              repeat
                LineNo := ReadInt;
                Inc(MapPos, 6);
                LineAddr := (ReadHex + LastBaseAddr);

                if (csoDoNotStoreProcNames in CallStackOptions) then ProcedureOK := False
                else
                begin
                  // Check for Procedures...
                  if (LastBaseAddr = 0) then // Simple CODE segment...
                  begin
                    while (ProcedureIdx < ProcedureCount - 1) and
                      (DWord(ProcedureList.Objects[ProcedureIdx]) < LineAddr) do
                      Inc(ProcedureIdx);

                    ProcedureOK := (ProcedureIdx < ProcedureCount) and
                      (LineAddr = DWord(ProcedureList.Objects[ProcedureIdx]));

                    if (ProcedureOK) then ProcedureName := ProcedureList[ProcedureIdx]
                    else ProcedureName := '';

                    if (ProcedureOK) and (ProcedureName = SimpleUnitName(UnitName)) then
                    begin
                      if (CompareText(UnitExt, '.pas') = 0) then ProcedureName := 'Initialization'
                      else ProcedureName := '';
                    end;
                  end
                  else
                  begin // ICODE segment...
                    if (FirstInitAddr) then
                    begin
                      ProcedureName := 'Initialization';
                      ProcedureOK := True;
                      FirstInitAddr := False;
                    end
                    else ProcedureOK := False;
                  end;
                end;

                // Write the Line & Address infos...
                LineDiff := (LineNo - LastLine) - 1;
                AddrDiff := (LineAddr - LastAddr) - 1;

                if (not ProcedureOK) and
                  (LineDiff <= 3) and (LineDiff >= 0) and (AddrDiff <= 31) then
                begin // 1 byte (2 bits Line, 5 bits Addr - w/o ProcName)
                  FByte := (Word(LineDiff) shl 6) or (AddrDiff shl 1);
                  LineStream.Write(FByte, 1);
                end
                else
                  if (ProcedureOK) and
                    (LineDiff <= 7) and (LineDiff >= 0) and (AddrDiff <= 7) then
                  begin // 1 byte (3 bits Line, 3 bits Addr - with ProcName)
                    FByte := 1 or
                      (Word(LineDiff) shl 5) or (AddrDiff shl 2);
                    LineStream.Write(FByte, 1);
                  end
                  else
                    if (LineDiff <= 31) and (LineDiff >= 0) and
                      (AddrDiff <= 127) then
                    begin // 2 bytes (5 bits Line, 7 bits Addr)
                      FWord := 3 or // 0000 0011
                        (LineDiff shl 11) or (Word(AddrDiff) shl 4);
                      if ProcedureOK then
                        FWord := FWord or 4; // 00000X00
                      LineStream.Write(FWord, 2);
                    end
                    else
                    begin // 4 bytes (12 bits Addr, 16 bits Line as SmallInt)
                      // NOTE: $FFF = 4095 is used to store AddrDiff = 0.
                      if (AddrDiff < 4095) or (AddrDiff = DWord(-1)) then
                      begin
                        FDWord := 11 or // 0000 1011
                          (AddrDiff shl 20) or (Word(LineDiff) shl 4);
                        if ProcedureOK then
                          FDWord := FDWord or 4; // 00000X00
                        LineStream.Write(FDWord, 4);
                      end
                      else
                      begin // Other 4 bytes
                        if ProcedureOK then FDWord := $FFEFFFEF // FFEFFFE0 - 1111
                        else FDWord := $FFEFFFEB; // FFEFFFE0 - 1111; // FFFFFFF0 - 1011
                        LineStream.Write(FDWord, 4);
                        LineStream.Write(LineDiff, 2);
                        FWord := AddrDiff;
                        LineStream.Write(FWord, 2);
                      end;
                    end;

                // Write the Procedure's name...
                if ProcedureOK then
                begin
                  DotIdx := Pos('.', ProcedureName);
                  if DotIdx > 0 then
                  begin
                    NewClassName := Copy(ProcedureName, 1, DotIdx - 1);
                    if LastClassName = NewClassName then
                      ProcedureName := Copy(ProcedureName, DotIdx, 255);
                    LastClassName := NewClassName;
                  end;
                  WriteString(LineStream, ProcedureName, True);
                end;
                LastLine := LineNo;
                LastAddr := LineAddr;

                if (MapPos^ = #13) and ((MapPos + 2)^ <> #13) then
                  Inc(MapPos, 2);
              until (MapPos^ = #13) and ((MapPos + 3)^ = #10);
              Inc(MapPos, 2); // Skip last line breaks.

              // Calculate and write the UnitSize...
              OldPos := LineStream.Position;
              LineStream.Position := UnitSizePos;
              UnitSize := (LastAddr - StartAddr + 1);
              LineStream.Write(UnitSize, 4);
              NextUnit := OldPos - UnitSizePos - 8;
              LineStream.Write(NextUnit, 4);
              LineStream.Position := OldPos;
            end;
            OldPos := LineStream.Position;
            LineStream.Position := UnitsNumberPos;
            LineStream.Write(UnitsNumber, 4);
            LineStream.Position := OldPos;
            OutputStream := TMemoryStream.Create;

            // Write the Debug information size...
            DebugSize := LineStream.Size;
            OutputStream.Write(DebugSize, 4);

            // Write Debug information...
            LineStream.Position := 0;
            OutputStream.CopyFrom(LineStream, DebugSize);

            Freemem(StartMap);
            StartMap := nil;

            ExeStream := TMemoryStream.Create;
            try
              ExeStream.LoadFromFile(CompiledFile);

              ZCompress(OutputStream.Memory, OutputStream.Size, ZResPointer, ZResSize);
              try
                OutputStream.Clear;

                // Write MagicNumber word...
                MagicWord := MagicNumber6;
                OutputStream.Write(MagicWord, 4);

                // Write EurekaLog Version...
                OutputStream.Write(EurekaLogCurrentVersion, 2);

                // Write CompilationDate...
                FCompiledDate := GetGMTDateTime(Now);
                CompilationDate := (FCompiledDate); // GMT normalized.
                OutputStream.Write(CompilationDate, 8);

                // Write MemoryLeaks state...
                MemoryLeaksState := Byte(LeaksOptions);
                OutputStream.Write(MemoryLeaksState, 1);

                // Write UseMainModuleOptions state...
                UseMainModuleOptions := (boUseMainModuleOptions in BehaviourOptions);
                OutputStream.Write(UseMainModuleOptions, 1);

                // Write Symbols Info...
                SymbolsStream.Position := 0;
                OutputStream.CopyFrom(SymbolsStream, SymbolsStream.Size);

                // Save the compressed options...
                OptionsStream := TMemoryStream.Create;
                try
                  SaveToStream(OptionsStream);
                  ZCompress(OptionsStream.Memory, OptionsStream.Size, ZResPointer2, ZResSize2);
                  try
                    // Save the compresses data...
                    OutputStream.Write(ZResSize2, 4);
                    OutputStream.Write(ZResPointer2^, ZResSize2);
                  finally
                    FreeMem(ZResPointer2, ZResSize2);
                  end;
                finally
                  OptionsStream.Free;
                end;

                // Write the enctypted MagicWord (to check the password)...
                Encrypt(MagicWord, MagicWord, 4);
                OutputStream.Write(MagicWord, 4);

                // Save the compresses data...
                OutputStream.Write(ZResPointer^, ZResSize);

                // Save the EurekaLog data into the "ELDATA" Win32 PE resource...
                WriteResourceInStream(ExeStream, 'ELDATA',
                  OutputStream.Memory, OutputStream.Size);
              finally
                FreeMem(ZResPointer, ZResSize);
              end;

              // Hook the DLL Calls (via Win32 PE)...
              if (ModuleType <> mtPackage) then
                for Index := low(HookedFunctions) to high(HookedFunctions) do
                begin
                  if (FunctionsAddr[Index] <> 0) then
                    ModifyImportFunction(ExeStream,
                      HookedFunctions[Index].DLL,
                      HookedFunctions[Index].Proc,
                      FunctionsAddr[Index]);
                end;
            finally
              if (cfoReduceFileSize in CompiledFileOptions) then
                StripRelocationTable(ExeStream);

              if (cfoCheckFileCorruption in CompiledFileOptions) then
                CalcCrc32(ExeStream);

              ExeStream.Position := 0;
              if not DeleteFile(CompiledFile) then Sleep(1000); // To allow the AntiVirus to release the file.
              ExeStream.SaveToFile(CompiledFile);
              ExeStream.Free;
            end;
          finally
            SymbolsStream.Free;
          end;

          OutputStream.Free;
          LineStream.Free;
          ProcedureList.Free;
          for UnitIdx := 0 to UnitList.Count - 1 do
            Dispose(PUnitRec(UnitList[UnitIdx]));
          UnitList.Free;
        end
        else
          MapError(1);
      end
      else
        MapError(2);
    end
    else
      MapError(3);

    if (StartMap <> nil) then FreeMem(StartMap);
  end
  else
    MapError(4);
end;

procedure TBaseModule.Assign(Source: TEurekaModuleOptions);
begin
  inherited;
  if (Source is TBaseModule) then
    EncryptPassword := TBaseModule(Source).EncryptPassword;
end;

procedure TBaseModule.SetToDefaultOptions;
begin
  inherited;
  EncryptPassword := '';
end;

// This function Add or Remove, the "ExceptionLog" unit from the units list...
// ...and return the module type (Program or Library)

procedure TBaseModule.MakeLine(Active: Boolean);
const
  SharedUnits: array[0..18] of string =
  ('ShareMem', 'nxReplacementMemoryManager', 'FastShareMem', 'RecyclerMM',
    'WinMem', 'MultiMM', 'ShareMemRep', 'BigBrain', 'BigBrainPro', 'TopMemory',
    'FastMM', 'FastMM3', 'FastMM4', 'ShareFastMemory', 'FastMemory', 'nxShareMem',
	  'QMemory', 'ShareQmm', 'SimpleShareMem');
var
  // Buffer for store Source text (for search "Uses" word).
  Text: string;

  // "ExceptionLog" for GDI application,
  UnitName: string;

  // The first reserved word (Program/Library/Package)...
  FirstWord: string;

  I: Integer;

  pre, post, sep: string;

  // Contain "Uses" (for Programs or Libraries) or "Contains" (for Packages) word...
  UnitsWord: string;

  // Variable uses for scanning Buffer.
  Idx: Integer;

  // Variable uses for store the start index of "Uses" word.
  StartUses: Integer;

  // Variable uses for store the start index of first Unit.
  StartUnit: Integer;

  // List of all units.
  UnitList, RequiresList: TStringList;

  // This function stors the Unit's name list...

  function StoreUnitNames(Txt: string; var Index: integer;
    Units: TStringList): boolean;
  var
    old: integer;
    stop: boolean;
  begin
    stop := False;
    repeat
      old := index;

      // Kill spaces, linebreak (#13#10), directives and comments...
      KillInutilChars(Txt, Index, True);

      while (Index <= Length(Txt)) and (Txt[Index] in NameSet) do Inc(Index);

      // Kill spaces, linebreak (#13#10), directives and comments...
      KillInutilChars(Txt, Index, True);

      if (Index <= Length(Txt) - 2) and (Copy(Txt, Index, 2) = 'IN') then
      begin
        inc(Index, 2);

        // Kill spaces, linebreak (#13#10), directives and comments...
        KillInutilChars(Txt, Index, True);
      end;

      // Check for separator (',' or ';')...
      if (Index <= Length(Txt)) and (Txt[Index] in [',', ';']) then
      begin
        stop := Txt[Index] = ';';
        Units.Add(Copy(Txt, old, Index - old + 1));
        Inc(Index);
      end;
    until (stop) or (Index > Length(Txt)) or (Index = old);

    // Result is True only if the sequence ends with ";" char...
    Result := stop;
  end;

  // This function searches one Unit into a List of Unit's names...

  function FindUnits(List: TStringList; Names: array of string): integer;
  var
    i, j, n, s: integer;
  begin
    i := 0;
    Result := -1;
    while (i <= List.Count - 1) and (Result = -1) do
    begin
      n := 1;
      // Kill spaces, linebreak (#13#10), directives and comments...
      KillInutilChars(List[i], n, True);

      s := n;
      while (n <= Length(List[i])) and (List[i][n] in NameSet) do Inc(n);

      for j := low(Names) to high(Names) do
      begin
        if UpperCase(Copy(List[i], s, n - s)) = UpperCase(Names[j]) then
        begin
          Result := i;
          Break;
        end;
      end;
      if Result = -1 then inc(i);
    end;
  end;

  // This function return the total length of first Idx strings...

  function ListLen(List: TStringList; Index: integer): integer;
  var
    i: Integer;
  begin
    Result := 0;
    if (Index >= 0) and (Index <= List.Count - 1) then
      for i := 0 to Index do
        Result := Result + Length(List[i]);
  end;

  // This function remove "Name" unit from text...
  // P.S: this function uses the local varibles...

  function RemoveUnit(Index: integer): boolean;
  var
    Name: string;
    Start: integer;
  begin
    Result := False;

    if I <> -1 then
    begin

      Name := UnitList[Index];

      // Remove "Uses/Contains" because there is only one Unit.
      if UnitList.Count = 1 then
      begin
        if (Copy(Text, Idx, 4) = #13#10#13#10) then Inc(Idx, 4)
        else
          if (Copy(Text, Idx, 2) = #13#10) then Inc(Idx, 2);
        DeleteText(FName, StartUses - 1, Idx - 1);
        UnitList.Clear;
        Result := true;
      end
      else

        // Many Units in "Uses/Contains" word...
      begin
        if Index = UnitList.Count - 1 then Dec(StartUnit);
        Start := ListLen(UnitList, Index - 1) + StartUnit - 1;
        Idx := ListLen(UnitList, Index - 1) +
          StartUnit - 1 + Length(UnitList[Index]);
        if (I = 0) and (Idx <= Length(Text) - 4) and
          (Copy(Text, Idx + 1, 4) = #13#10'  ') then Inc(Idx, 4);
        DeleteText(FName, Start, Idx);
        UnitList.Delete(I);
        Result := true;
      end;
    end;
  end;

begin  // MakeLine...
  if (CurrentPersonality.GetPersonality <> ptDelphiWin32) then Exit;

  // Set the Map-File and UnitDebugInfo options.
  SetDebugOptions(Active);

  Text := UpperCase(GetText(FName));
  Idx := 1;

  // Kill spaces, linebreak (#13#10), directives and comments...
  KillInutilChars(Text, Idx, True);

  // 7 = length of "Program", "Library" and "Package" words...
  FirstWord := Copy(Text, Idx, 7);

  // Search for "Program/Library" word...
  if (FirstWord = ProgramWord) or (FirstWord = LibraryWord) then
  begin
    if (FirstWord <> PackageWord) then UnitsWord := UsesWord
    else UnitsWord := ContainsWord;
    UnitName := MainUnitName;

    Inc(Idx, Length(FirstWord));

    // Found "Program/Library/Package" word...
    if KillInutilChars(Text, Idx, True) then
    begin
      // Search Module Name...
      while (Idx <= Length(Text)) and (Text[Idx] in NameSet) do Inc(Idx);
      KillInutilChars(Text, Idx, True);

      // Search "(Input,Output)" syntax...
      // ...only for "Program" module...
      if (FirstWord = ProgramWord) then
      begin
        if (Idx <= Length(Text)) and (Text[Idx] = '(') then
        begin
          Inc(Idx);
          KillInutilChars(Text, Idx, True);
          for I := 0 to 2 do
          begin
            while (Idx <= Length(Text)) and
              (Text[Idx] in (NameSet + [','])) do
              Inc(Idx);
            KillInutilChars(Text, Idx, True);
          end;
          if (Idx <= Length(Text)) and (Text[Idx] = ')') then
          begin
            Inc(Idx);
            KillInutilChars(Text, Idx, True);
          end;
        end;
      end;

      // Search ";" Module Name terminator...
      if (Idx <= Length(Text)) and (Text[Idx] = ';') then
      begin
        Inc(Idx);

        // If Module is Package then skip the "requires" section...
        if (FirstWord = PackageWord) then
        begin
          KillInutilChars(Text, Idx, True);
          if Copy(Text, Idx, Length(UnitsWord)) = RequiresWord then
          begin
            Inc(Idx, Length(RequiresWord));

            // Found "Requires" word...
            if KillInutilChars(Text, Idx, True) then
            begin
              if Idx <= Length(Text) then
              begin

                // Store all RequiresUnit names...
                RequiresList := TStringList.Create;
                StoreUnitNames(Text, Idx, RequiresList);
                RequiresList.Free;
              end;
            end;
          end;
        end;

        // Search for "Uses/Contains" word...
        if (Idx <= Length(Text)) then
        begin
          KillInutilChars(Text, Idx, True);
          StartUses := Idx;
          if Copy(Text, Idx, Length(UnitsWord)) = UnitsWord then
          begin
            Inc(Idx, Length(UnitsWord));

            // Found "Uses/Contains" word...
            if KillInutilChars(Text, Idx, not Active) then
            begin
              if (Idx <= Length(Text)) then
              begin
                StartUnit := Idx;

                // Store all Unit names...
                UnitList := TStringList.Create;
                if StoreUnitNames(Text, Idx, UnitList) then
                begin

                  // Find "ExceptionLog2" unit...
                  I := FindUnits(UnitList, ['ExceptionLog2']);

                  // If found the old UnitName, remove it...
                  if (I <> -1) then
                  begin
                    if (not IsReadOnly) then RemoveUnit(I)
                    else
                      ErrorMessage('Cannot remove the "ExceptionLog2" unit ' +
                        'from this project.' + #13#10 + 'Set the "' +
                        ExtractFileName(FName) + '" file as writable.');
                  end;

                  // Find "ExceptionLog" unit...
                  I := FindUnits(UnitList, [UnitName]);
                  if I <> -1 then
                  begin

                    // Remove "ExceptionLog" unit...
                    if (not Active) then
                    begin
                      if (not IsReadOnly) then RemoveUnit(I)
                      else
                        ErrorMessage('Cannot remove the "' + UnitName + '" unit ' +
                          'from this project.' + #13#10 + 'Set the "' +
                          ExtractFileName(FName) + '" file as writable.');
                    end;
                  end
                  else

                  // Not find "ExceptionLog" unit...
                  begin
                    if Active then
                    begin

                      // If at first position, is ShareMem,
                      // then write ExceptionLog at second,
                      // else at first.
                      if FindUnits(UnitList, SharedUnits) = 0 then
                      begin
                        I := 1;
                        pre := #13#10'  ';
                        post := '';
                      end
                      else
                      begin
                        I := 0;
                        pre := '';
                        post := #13#10'  ';
                      end;

                      if I = UnitList.Count then
                        sep := ';'
                      else
                        sep := ',';
                      if (not IsReadOnly) then
                        InsertText(FName, StartUnit + ListLen(UnitList, I - 1) - 1,
                          PChar(pre + UnitName + sep + post))
                      else
                        ErrorMessage('Cannot add the "' + UnitName + '" unit ' +
                          'into this project.' + #13#10 +
                          'Deactivate EurekaLog in this project or set the "' +
                          ExtractFileName(FName) + '" file as writable.');
                    end;
                  end;
                  UnitList.Free;
                end;
              end;
            end;
          end
          else
          begin // "Uses/Contains" word not found...
            if Active then
              if (not IsReadOnly) then
                InsertText(FName, Idx - 1, PChar(LowerCase(UnitsWord) + ' ' +
                  UnitName + ';'#13#10#13#10))
              else
                ErrorMessage('Cannot add the "' + UnitName + '" unit ' +
                  'into this project.' + #13#10 +
                  'Deactivate EurekaLog in this project or set the "' +
                  ExtractFileName(FName) + '" file as writable.');
          end;
        end;
      end;
    end;
  end;
end;

{ TBaseModule }

constructor TBaseModule.Create(ModuleName: string);
begin
  inherited Create(ModuleName, False);
  FName := ModuleName;
  FVersion := 0;
  FCompiledDate := 0;
end;

// This procedure load from DOF file the EurekaLog options...

procedure TBaseModule.LoadOptionsFromFile(FileName: string);
var
  Opt: TInMemIniFile;
  S, M, EnumName, FreezeMessage: string;
  I, J, L, N: Integer;
  t: TMessageType;
  op: TLogOption;
  sw: TShowOption;
  snd: TCommonSendOption;
  edo: TExceptionDialogOption;
  cso: TCallStackOption;
  bo: TBehaviourOption;
  lo: TLeaksOption;
  cfo: TCompiledFileOption;
  DefaulTBaseModule: TBaseModule;
  BoolTmp, SetExcDlgTypeToNone: Boolean;
  Filter: PEurekaExceptionFilter;
begin
  if (MasterOptionsFile <> '') then FileName := MasterOptionsFile;
  if (IsEurekaLogOptionsFile(FileName)) then
  begin
    SetExcDlgTypeToNone := False;
    FreezeMessage := '';
    Opt := TInMemIniFile.Create(FileName,
      ChangeFileExt(FileName, OldOptionFileExt(FileName)), EurekaLogFirstLine(FileName),
      EurekaLogLastLine(FileName), EurekaLogSection, IniAppendLine);
    DefaulTBaseModule := TBaseModule.Create(''); // Create to load default values...
    try
      // WARNING!!! Don't change 400 as default EurekaLog Version number...
      FVersion := Opt.ReadInteger(EurekaLogSection, 'EurekaLog Version', 400);

      // A WORKAROUND about a "6.0, 6.0.1, 6.0.2 RC 1" bug on version saving...
      if ((FVersion >= 600) and (FVersion <= 602)) then
        FVersion := (6000 + FVersion mod 600);

      // Load the sets e/o enumerates types...
      //--------------------------------------
      FLogOptions := DefaulTBaseModule.LogOptions;
      for op := low(TLogOption) to high(TLogOption) do
      begin
        i := Opt.ReadInteger(EurekaLogSection,
          GetEnumName(TypeInfo(TLogOption), Ord(op)), -1);
        if (i <> -1) then
          case i of
            0: FLogOptions := FLogOptions - [op];
            1: FLogOptions := FLogOptions + [op];
          end;
      end;

      FShowOptions := DefaulTBaseModule.ShowOptions;
      for sw := low(TShowOption) to high(TShowOption) do
      begin
        i := Opt.ReadInteger(EurekaLogSection,
          GetEnumName(TypeInfo(TShowOption), Ord(sw)), -1);
        if (i <> -1) then
          case i of
            0: FShowOptions := FShowOptions - [sw];
            1: FShowOptions := FShowOptions + [sw];
          end;
      end;

      FCommonSendOptions := DefaulTBaseModule.CommonSendOptions;
      for snd := low(TCommonSendOption) to high(TCommonSendOption) do
      begin
        i := Opt.ReadInteger(EurekaLogSection,
          GetEnumName(TypeInfo(TCommonSendOption), Ord(snd)), -1);
        if (i <> -1) then
          case i of
            0: FCommonSendOptions := FCommonSendOptions - [snd];
            1: FCommonSendOptions := FCommonSendOptions + [snd];
          end;
      end;

      FExceptionDialogOptions := DefaulTBaseModule.ExceptionDialogOptions;
      for edo := low(TExceptionDialogOption) to high(TExceptionDialogOption) do
      begin
        if (FVersion >= 500) then
          i := Opt.ReadInteger(EurekaLogSection,
            GetEnumName(TypeInfo(TExceptionDialogOption), Ord(edo)), -1)
        else
        begin
          if (edo = edoSendErrorReportChecked) then
          begin
            i := Opt.ReadInteger(EurekaLogSection, 'edoShowExceptionDialog', -1);
            SetExcDlgTypeToNone := (i = 0);
            i := Opt.ReadInteger(EurekaLogSection, 'edoSendEmailChecked', -1);
          end;
        end;
        if (i <> -1) then
          case i of
            0: FExceptionDialogOptions := FExceptionDialogOptions - [edo];
            1: FExceptionDialogOptions := FExceptionDialogOptions + [edo];
          end;
      end;

      FCallStackOptions := DefaulTBaseModule.CallStackOptions;
      for cso := low(TCallStackOption) to high(TCallStackOption) do
      begin
        i := Opt.ReadInteger(EurekaLogSection,
          GetEnumName(TypeInfo(TCallStackOption), Ord(cso)), -1);
        if (i <> -1) then
          case i of
            0: FCallStackOptions := FCallStackOptions - [cso];
            1: FCallStackOptions := FCallStackOptions + [cso];
          end;
      end;

      FBehaviourOptions := DefaulTBaseModule.BehaviourOptions;
      for bo := low(TBehaviourOption) to high(TBehaviourOption) do
      begin
        i := Opt.ReadInteger(EurekaLogSection,
          GetEnumName(TypeInfo(TBehaviourOption), Ord(bo)), -1);
        if (i <> -1) then
          case i of
            0: FBehaviourOptions := FBehaviourOptions - [bo];
            1: FBehaviourOptions := FBehaviourOptions + [bo];
          end;
      end;

      FLeaksOptions := DefaulTBaseModule.LeaksOptions;
      for lo := low(TLeaksOption) to high(TLeaksOption) do
      begin
        i := Opt.ReadInteger(EurekaLogSection,
          GetEnumName(TypeInfo(TLeaksOption), Ord(lo)), -1);
        if (i <> -1) then
          case i of
            0: FLeaksOptions := FLeaksOptions - [lo];
            1: FLeaksOptions := FLeaksOptions + [lo];
          end;
      end;

      FCompiledFileOptions := DefaulTBaseModule.CompiledFileOptions;
      for cfo := low(TCompiledFileOption) to high(TCompiledFileOption) do
      begin
      i := Opt.ReadInteger(EurekaLogSection,
        GetEnumName(TypeInfo(TCompiledFileOption), Ord(cfo)), -1);
      if (i <> -1) then
        case i of
          0: FCompiledFileOptions := FCompiledFileOptions - [cfo];
          1: FCompiledFileOptions := FCompiledFileOptions + [cfo];
        end;
      end;
      //--------------------------------------

      FActivateLog := Opt.ReadBool(EurekaLogSection, 'Activate',
        DefaulTBaseModule.ActivateLog);
      FActivateHandle := Opt.ReadBool(EurekaLogSection, 'Activate Handle',
        DefaulTBaseModule.ActivateHandle);
      FSaveLogFile := Opt.ReadBool(EurekaLogSection, 'Save Log File',
        DefaulTBaseModule.SaveLogFile);
      FForegroundTab := TForegroundType(Opt.ReadInteger(EurekaLogSection,
        'Foreground Tab', integer(DefaulTBaseModule.ForegroundTab)));
      if (FVersion < 600) then
      begin
        if FForegroundTab = ftProcesses then FForegroundTab := ftCPU;
      end;
      if (FVersion < 500) then
      begin
        BoolTmp := Opt.ReadBool(EurekaLogSection, 'EurekaLogLook',
          (edoUseEurekaLogLookAndFeel in DefaulTBaseModule.ExceptionDialogOptions));
        if (BoolTmp) then ExceptionDialogOptions := ExceptionDialogOptions + [edoUseEurekaLogLookAndFeel]
        else ExceptionDialogOptions := ExceptionDialogOptions - [edoUseEurekaLogLookAndFeel];
      end;
      FFreezeActivate := Opt.ReadBool(EurekaLogSection, 'Freeze Activate',
        DefaulTBaseModule.FreezeActivate);
      FFreezeTimeout := Opt.ReadInteger(EurekaLogSection, 'Freeze Timeout',
        DefaulTBaseModule.FreezeTimeout);
      if (FVersion < 422) then
        FFreezeTimeout := FFreezeTimeout div 1000;
      if (FVersion < 600) then
        FreezeMessage := Opt.ReadString(EurekaLogSection, 'Freeze Message', '');
      FSMTPFrom := Opt.ReadString(EurekaLogSection, 'SMTP From',
        DefaulTBaseModule.FSMTPFrom);
      FSMTPHost := Opt.ReadString(EurekaLogSection, 'SMTP Host',
        DefaulTBaseModule.FSMTPHost);
      FSMTPPort := Opt.ReadInteger(EurekaLogSection, 'SMTP Port',
        DefaulTBaseModule.FSMTPPort);
      FSMTPUserID := Opt.ReadString(EurekaLogSection, 'SMTP UserID',
        DefaulTBaseModule.FSMTPUserID);
      FSMTPPassword := Opt.ReadString(EurekaLogSection, 'SMTP Password',
        DefaulTBaseModule.FSMTPPassword);
      if (FVersion < 500) then
      begin
        BoolTmp := Opt.ReadBool(EurekaLogSection, 'SMTP ShowDialog',
          (sndShowSendDialog in DefaulTBaseModule.CommonSendOptions));
        if (BoolTmp) then FCommonSendOptions := FCommonSendOptions + [sndShowSendDialog]
        else FCommonSendOptions := FCommonSendOptions - [sndShowSendDialog];

        BoolTmp := Opt.ReadBool(EurekaLogSection, 'Send Entire Log',
          (sndSendEntireLog in DefaulTBaseModule.CommonSendOptions));
        if (BoolTmp) then FCommonSendOptions := FCommonSendOptions + [sndSendEntireLog]
        else FCommonSendOptions := FCommonSendOptions - [sndSendEntireLog];

        BoolTmp := Opt.ReadBool(EurekaLogSection, 'Attach Screenshot',
          (sndSendScreenshot in DefaulTBaseModule.CommonSendOptions));
        if (BoolTmp) then FCommonSendOptions := FCommonSendOptions + [sndSendScreenshot]
        else FCommonSendOptions := FCommonSendOptions - [sndSendScreenshot];
      end;
      FOutputPath := Opt.ReadString(EurekaLogSection, 'Output Path',
        DefaulTBaseModule.OutputPath);

      FEncryptPassword := Opt.ReadString(EurekaLogSection, 'Encrypt Password',
        DefaulTBaseModule.EncryptPassword);
      FAutoCloseDialogSecs := Opt.ReadInteger(EurekaLogSection, 'AutoCloseDialogSecs',
        DefaulTBaseModule.AutoCloseDialogSecs);
      FWebSendMode := TWebSendMode(Opt.ReadInteger(EurekaLogSection,
        'WebSendMode', Integer(DefaulTBaseModule.WebSendMode)));
      FSupportURL := Opt.ReadString(EurekaLogSection, 'SupportULR',
        DefaulTBaseModule.SupportURL);
      ReadStrings(Opt, EurekaLogSection, 'HTMLLayout Count',
        'HTMLLine', DefaulTBaseModule.HTMLLayout, FHTMLLayout);
      FAutoCrashOperation := TTerminateBtnOperation(Opt.ReadInteger(EurekaLogSection,
        'AutoCrashOperation', Integer(DefaulTBaseModule.AutoCrashOperation)));
      AutoCrashNumber := Opt.ReadInteger(EurekaLogSection, 'AutoCrashNumber',
        DefaulTBaseModule.AutoCrashNumber);
      AutoCrashMinutes := Opt.ReadInteger(EurekaLogSection, 'AutoCrashMinutes',
        DefaulTBaseModule.AutoCrashMinutes);
      FWebURL := Opt.ReadString(EurekaLogSection, 'WebURL',
        DefaulTBaseModule.WebURL);
      FWebUserID := Opt.ReadString(EurekaLogSection, 'WebUserID',
        DefaulTBaseModule.WebUserID);
      FWebPassword := Opt.ReadString(EurekaLogSection, 'WebPassword',
        DefaulTBaseModule.WebPassword);
      FWebPort := Opt.ReadInteger(EurekaLogSection, 'WebPort',
        DefaulTBaseModule.WebPort);
      FAttachedFiles := Opt.ReadString(EurekaLogSection, 'AttachedFiles',
        DefaulTBaseModule.AttachedFiles);

      FProxyURL := Opt.ReadString(EurekaLogSection, 'ProxyURL',
        DefaulTBaseModule.ProxyURL);
      FProxyUserID := Opt.ReadString(EurekaLogSection, 'ProxyUser',
        DefaulTBaseModule.ProxyUserID);
      FProxyPassword := Opt.ReadString(EurekaLogSection, 'ProxyPassword',
        DefaulTBaseModule.ProxyPassword);
      FProxyPort := Opt.ReadInteger(EurekaLogSection, 'ProxyPort',
        DefaulTBaseModule.ProxyPort);
      FTrakerUserID := Opt.ReadString(EurekaLogSection, 'TrakerUser',
       DefaulTBaseModule.TrakerUserID);
      FTrakerPassword := Opt.ReadString(EurekaLogSection, 'TrakerPassword',
        DefaulTBaseModule.TrakerPassword);
      FTrakerAssignTo := Opt.ReadString(EurekaLogSection, 'TrakerAssignTo',
        DefaulTBaseModule.TrakerAssignTo);
      FTrakerProject := Opt.ReadString(EurekaLogSection, 'TrakerProject',
        DefaulTBaseModule.TrakerProject);
      FTrakerCategory := Opt.ReadString(EurekaLogSection, 'TrakerCategory',
        DefaulTBaseModule.TrakerCategory);
      FTrakerTrialID := Opt.ReadString(EurekaLogSection, 'TrakerTrialID',
        DefaulTBaseModule.TrakerTrialID);
      FZipPassword := Opt.ReadString(EurekaLogSection, 'ZipPassword',
        DefaulTBaseModule.ZipPassword);
      FPreBuildEvent := Opt.ReadString(EurekaLogSection, 'PreBuildEvent',
        DefaulTBaseModule.PreBuildEvent);
      FPostSuccessfulBuildEvent := Opt.ReadString(EurekaLogSection, 'PostSuccessfulBuildEvent',
        DefaulTBaseModule.PostSuccessfulBuildEvent);
      FPostFailureBuildEvent := Opt.ReadString(EurekaLogSection, 'PostFailureBuildEvent',
        DefaulTBaseModule.PostFailureBuildEvent);
      FExceptionDialogType := TExceptionDialogType(Opt.ReadInteger(EurekaLogSection,
        'ExceptionDialogType', Integer(DefaulTBaseModule.ExceptionDialogType)));

      if (FVersion < 500) then
      begin
        if (FVersion < 450) then
        begin
          BoolTmp := not Opt.ReadBool(EurekaLogSection, 'Mute Mode',
            (DefaulTBaseModule.ExceptionDialogType = edtNone))
        end
        else
        begin
          BoolTmp := Opt.ReadBool(EurekaLogSection, 'ShowExceptionDialog',
            (DefaulTBaseModule.ExceptionDialogType <> edtNone));
        end;
        if (not BoolTmp) then FExceptionDialogType := edtNone;
      end;

      if (FVersion >= 600) then
      begin
        FExceptionDialogType := TExceptionDialogType(
          Opt.ReadInteger(EurekaLogSection, 'ExceptionDialogType',
          Integer(DefaulTBaseModule.ExceptionDialogType)));
      end;

      FAppendLogs := Opt.ReadBool(EurekaLogSection, 'Append to Log',
        DefaulTBaseModule.AppendLogs);

      if (FVersion < 600) then
      begin
        BoolTmp := Opt.ReadBool(EurekaLogSection, 'Show TerminateBtn',
          (DefaulTBaseModule.TerminateBtnOperation = tbNone));
        if (not BoolTmp) then TerminateBtnOperation := tbNone;
      end;

      FTerminateBtnOperation := TTerminateBtnOperation(Opt.ReadInteger(EurekaLogSection,
        'TerminateBtn Operation', Integer(DefaulTBaseModule.TerminateBtnOperation)));

      FErrorsNumberToSave := Opt.ReadInteger(EurekaLogSection, 'Errors Number',
        DefaulTBaseModule.ErrorsNumberToSave);

      if (FVersion < 450) and (FErrorsNumberToSave = 0) then
      begin
        FErrorsNumberToSave := 32;
      end;

      FErrorsNumberToShowTerminateBtn := Opt.ReadInteger(EurekaLogSection,
        'Errors Terminate', DefaulTBaseModule.ErrorsNumberToShowTerminateBtn);

      FEmailAddresses := Opt.ReadString(EurekaLogSection, 'Email Address',
        DefaulTBaseModule.EmailAddresses);

      FEmailSubject := Opt.ReadString(EurekaLogSection, 'Email Object',
        DefaulTBaseModule.EmailSubject);

      FEmailSendMode :=
        TEmailSendMode(Opt.ReadInteger(EurekaLogSection, 'Email Send Options',
        Integer(DefaulTBaseModule.EmailSendMode)));
      if (FVersion < 450) and (FEmailSendMode <> esmNoSend) then
      begin
        if (FSMTPHost <> '') then FEmailSendMode := esmSMTPClient
        else FEmailSendMode := esmEmailClient;
      end;

      FExceptionsFilters.Clear;
      N := Opt.ReadInteger(EurekaLogSection, 'Count', 0);
      for I := 0 to N - 1 do
      begin
        New(Filter);
        if (FVersion < 600) then
        begin
          S := Opt.ReadString(EurekaLogSection, 'T' + IntToStr(I), '');
          Filter^.ExceptionClassName := S;
          L := Opt.ReadInteger(EurekaLogSection, 'NM' + IntToStr(I), 0);
          if L = 0 then Filter^.ExceptionMessage :=
            Opt.ReadString(EurekaLogSection, 'M' + IntToStr(I), '')
          else
          begin
            M := '';
            for J := 0 to L - 1 do
            begin
              S := Opt.ReadString(EurekaLogSection,
                'M' + IntToHex(I, 2) + IntToHex(J, 2), '');
              if (M <> '') then M := (M + #13#10);
              M := (M + S);
            end;
            Filter^.ExceptionMessage := M;
          end;
          if (Filter^.ExceptionMessage = '') then
          begin
            Filter^.ExceptionType := fetUnhandled;
            Filter^.DialogType := fdtNone;
            Filter^.HandlerType := fhtNone;
            Filter^.ActionType := fatNone;
          end
          else
          begin
            Filter^.ExceptionType := fetUnhandled;
            Filter^.DialogType := fdtMessageBox;
            Filter^.HandlerType := fhtNone;
            Filter^.ActionType := fatNone;
          end;
        end
        else
        begin
          Filter^.Active := Opt.ReadBool(EurekaLogSection, 'Act' + IntToStr(I), True);

          S := Opt.ReadString(EurekaLogSection, 'T' + IntToStr(I), '');
          Filter^.ExceptionClassName := S;
          L := Opt.ReadInteger(EurekaLogSection, 'NM' + IntToStr(I), 0);
          M := '';
          for J := 0 to L - 1 do
          begin
            S := Opt.ReadString(EurekaLogSection,
              'M' + IntToHex(I, 2) + IntToHex(J, 2), '');
            if (M <> '') then M := (M + #13#10);
            M := (M + S);
          end;
          Filter^.ExceptionMessage := M;

          Filter^.ExceptionType := TFilterExceptionType(Opt.ReadInteger(EurekaLogSection,
            'Z' + IntToStr(I), Integer(fetUnhandled)));
          Filter^.DialogType := TFilterDialogType(Opt.ReadInteger(EurekaLogSection,
            'D' + IntToStr(I), Integer(fdtEurekaLog)));
          Filter^.HandlerType := TFilterHandlerType(Opt.ReadInteger(EurekaLogSection,
            'H' + IntToStr(I), Integer(fhtEurekaLog)));
          Filter^.ActionType := TFilterActionType(Opt.ReadInteger(EurekaLogSection,
            'A' + IntToStr(I), Integer(fatNone)));
        end;
        ExceptionsFilters.Add(Filter);
      end;
      ReadStrings(Opt, EurekaLogSection, 'Email Message Line Count',
        'Line', DefaulTBaseModule.EmailMessage, FEmailMessage);
      for t := low(TMessageType) to high(TMessageType) do
      begin
        EnumName := GetEnumName(TypeInfo(TMessageType), Ord(t));
        if ((t in [mtSendDialog_Caption..mtSendDialog_Sending]) and
          (FVersion < 500)) then
        begin
          EnumName := ('mtSMTP' + Copy(EnumName, 7, Length(EnumName)));
        end;
        ReadStrings(Opt, EurekaLogSection, 'Count ' + EnumName, EnumName,
          DefaultBaseModule.CustomizedTexts[t], FCustomizedTexts[t]);
      end;
      FTextsCollection := Opt.ReadString(EurekaLogSection, 'TextsCollection',
        DefaulTBaseModule.TextsCollection);
      if (FreezeMessage <> '') then
        CustomizedTexts[mtException_AntiFreeze] := FreezeMessage;
      if (SetExcDlgTypeToNone) then FExceptionDialogType := edtNone;
    finally
      DefaulTBaseModule.Free;
      Opt.Free;
    end;
  end
  else SetToDefaultOptions;
end;

procedure TBaseModule.LoadOptions;
begin
  LoadOptionsFromFile(OptionFile);
end;

procedure TBaseModule.LoadOptionsFromDefaultOptionFile;
begin
  LoadOptionsFromFile(EurekaDefaultOptionFile);
end;

// This procedure save into DOF file the EurekaLog options...

procedure TBaseModule.SaveOptionsToFile(FileName: string);
var
  Opt: TInMemIniFile;
  I, J: Integer;
  TempStr: TStringList;
  t: TMessageType;
  op: TLogOption;
  lo: TLeaksOption;
  sw: TShowOption;
  snd: TCommonSendOption;
  edo: TExceptionDialogOption;
  cso: TCallStackOption;
  bo: TBehaviourOption;
  cfo: TCompiledFileOption;
begin
  if (not IsAcceptableProject(FileName)) and ((FileName <> EurekaDefaultOptionFile)) then Exit;
  Opt := TInMemIniFile.Create(FileName,
    ChangeFileExt(FileName, OldOptionFileExt(FileName)), EurekaLogFirstLine(FileName),
    EurekaLogLastLine(FileName), EurekaLogSection, IniAppendLine);
  if (Opt.ReadInteger(EurekaLogSection, 'Count', -1) <> -1) then
    Opt.EraseSection(EurekaLogSection);
  Opt.WriteInteger(EurekaLogSection, 'EurekaLog Version', EurekaLogCurrentVersion);
  Opt.WriteBool(EurekaLogSection, 'Activate', FActivateLog);
  Opt.WriteBool(EurekaLogSection, 'Activate Handle', FActivateHandle);
  Opt.WriteBool(EurekaLogSection, 'Save Log File', FSaveLogFile);
  Opt.WriteInteger(EurekaLogSection, 'Foreground Tab', integer(FForegroundTab));
  Opt.WriteBool(EurekaLogSection, 'Freeze Activate', FFreezeActivate);
  Opt.WriteInteger(EurekaLogSection, 'Freeze Timeout', FFreezeTimeout);
  Opt.WriteString(EurekaLogSection, 'SMTP From', FSMTPFrom);
  Opt.WriteString(EurekaLogSection, 'SMTP Host', FSMTPHost);
  Opt.WriteInteger(EurekaLogSection, 'SMTP Port', FSMTPPort);
  Opt.WriteString(EurekaLogSection, 'SMTP UserID', FSMTPUserID);
  Opt.WriteString(EurekaLogSection, 'SMTP Password', FSMTPPassword);
  Opt.WriteBool(EurekaLogSection, 'Append to Log', FAppendLogs);
  Opt.WriteInteger(EurekaLogSection, 'TerminateBtn Operation',
    Integer(FTerminateBtnOperation));
  Opt.WriteInteger(EurekaLogSection, 'Errors Number', FErrorsNumberToSave);
  Opt.WriteInteger(EurekaLogSection, 'Errors Terminate',
    FErrorsNumberToShowTerminateBtn);
  Opt.WriteString(EurekaLogSection, 'Email Address', FEmailAddresses);
  Opt.WriteString(EurekaLogSection, 'Email Object', FEmailSubject);
  Opt.WriteInteger(EurekaLogSection, 'Email Send Options', Integer(FEmailSendMode));
  Opt.WriteString(EurekaLogSection, 'Output Path', FOutputPath);

  Opt.WriteString(EurekaLogSection, 'Encrypt Password', FEncryptPassword);
  Opt.WriteInteger(EurekaLogSection, 'AutoCloseDialogSecs', FAutoCloseDialogSecs);
  Opt.WriteInteger(EurekaLogSection, 'WebSendMode', Integer(FWebSendMode));
  Opt.WriteString(EurekaLogSection, 'SupportULR', FSupportURL);
  WriteStrings(Opt, EurekaLogSection, 'HTMLLayout Count', 'HTMLLine', FHTMLLayout);
  Opt.WriteInteger(EurekaLogSection, 'AutoCrashOperation', Integer(FAutoCrashOperation));
  Opt.WriteInteger(EurekaLogSection, 'AutoCrashNumber', FAutoCrashNumber);
  Opt.WriteInteger(EurekaLogSection, 'AutoCrashMinutes', FAutoCrashMinutes);
  Opt.WriteString(EurekaLogSection, 'WebURL', FWebURL);
  Opt.WriteString(EurekaLogSection, 'WebUserID', FWebUserID);
  Opt.WriteString(EurekaLogSection, 'WebPassword', FWebPassword);
  Opt.WriteInteger(EurekaLogSection, 'WebPort', FWebPort);
  Opt.WriteString(EurekaLogSection, 'AttachedFiles', FAttachedFiles);

  Opt.WriteString(EurekaLogSection, 'ProxyURL', FProxyURL);
  Opt.WriteString(EurekaLogSection, 'ProxyUser', FProxyUserID);
  Opt.WriteString(EurekaLogSection, 'ProxyPassword', FProxyPassword);
  Opt.WriteInteger(EurekaLogSection, 'ProxyPort', FProxyPort);
  Opt.WriteString(EurekaLogSection, 'TrakerUser', FTrakerUserID);
  Opt.WriteString(EurekaLogSection, 'TrakerPassword', FTrakerPassword);
  Opt.WriteString(EurekaLogSection, 'TrakerAssignTo', FTrakerAssignTo);
  Opt.WriteString(EurekaLogSection, 'TrakerProject', FTrakerProject);
  Opt.WriteString(EurekaLogSection, 'TrakerCategory', FTrakerCategory);
  Opt.WriteString(EurekaLogSection, 'TrakerTrialID', FTrakerTrialID);
  Opt.WriteString(EurekaLogSection, 'ZipPassword', FZipPassword);
  Opt.WriteString(EurekaLogSection, 'PreBuildEvent', FPreBuildEvent);
  Opt.WriteString(EurekaLogSection, 'PostSuccessfulBuildEvent', FPostSuccessfulBuildEvent);
  Opt.WriteString(EurekaLogSection, 'PostFailureBuildEvent', FPostFailureBuildEvent);
  Opt.WriteInteger(EurekaLogSection, 'ExceptionDialogType', Integer(FExceptionDialogType));
  
  Opt.WriteInteger(EurekaLogSection, 'Count', FExceptionsFilters.Count);
  TempStr := TStringList.Create;
  for I := 0 to (FExceptionsFilters.Count - 1) do
  begin
    Opt.WriteBool(EurekaLogSection, 'Act' + IntToStr(I),
      FExceptionsFilters[I]^.Active);
    Opt.WriteString(EurekaLogSection, 'T' + IntToStr(I),
      FExceptionsFilters[I]^.ExceptionClassName);
    TempStr.Text := FExceptionsFilters[I]^.ExceptionMessage;
    Opt.WriteInteger(EurekaLogSection, 'NM' + IntToStr(I), TempStr.Count);
    for J := 0 to TempStr.Count - 1 do
      Opt.WriteString(EurekaLogSection,
        'M' + IntToHex(I, 2) + IntToHex(J, 2), TempStr[J]);
    Opt.WriteInteger(EurekaLogSection, 'Z' + IntToStr(I),
      Integer(FExceptionsFilters[I]^.ExceptionType));
    Opt.WriteInteger(EurekaLogSection, 'D' + IntToStr(I),
      Integer(FExceptionsFilters[I]^.DialogType));
    Opt.WriteInteger(EurekaLogSection, 'H' + IntToStr(I),
      Integer(FExceptionsFilters[I]^.HandlerType));
    Opt.WriteInteger(EurekaLogSection, 'A' + IntToStr(I),
      Integer(FExceptionsFilters[I]^.ActionType));
  end;
  WriteStrings(Opt, EurekaLogSection, 'EMail Message Line Count', 'Line', FEmailMessage);

  // Save the sets e/o enumerates types...
  //--------------------------------------
  for op := low(TLogOption) to high(TLogOption) do
  begin
    Opt.WriteBool(EurekaLogSection, GetEnumName(TypeInfo(TLogOption), Ord(op)),
      op in FLogOptions);
  end;
  for sw := low(TShowOption) to high(TShowOption) do
  begin
    Opt.WriteBool(EurekaLogSection, GetEnumName(TypeInfo(TShowOption), Ord(sw)),
      sw in FShowOptions);
  end;
  for snd := low(TCommonSendOption) to high(TCommonSendOption) do
  begin
    Opt.WriteBool(EurekaLogSection, GetEnumName(TypeInfo(TCommonSendOption), Ord(snd)),
      snd in FCommonSendOptions);
  end;
  for edo := low(TExceptionDialogOption) to high(TExceptionDialogOption) do
  begin
    Opt.WriteBool(EurekaLogSection, GetEnumName(TypeInfo(TExceptionDialogOption), Ord(edo)),
      edo in FExceptionDialogOptions);
  end;
  for cso := low(TCallStackOption) to high(TCallStackOption) do
  begin
    Opt.WriteBool(EurekaLogSection, GetEnumName(TypeInfo(TCallStackOption), Ord(cso)),
      cso in FCallStackOptions);
  end;
  for bo := low(TBehaviourOption) to high(TBehaviourOption) do
  begin
    Opt.WriteBool(EurekaLogSection, GetEnumName(TypeInfo(TBehaviourOption), Ord(bo)),
      bo in FBehaviourOptions);
  end;
  for lo := low(TLeaksOption) to high(TLeaksOption) do
  begin
    Opt.WriteBool(EurekaLogSection, GetEnumName(TypeInfo(TLeaksOption), Ord(lo)),
      lo in FLeaksOptions);
  end;
  for cfo := low(TCompiledFileOption) to high(TCompiledFileOption) do
  begin
    Opt.WriteBool(EurekaLogSection, GetEnumName(TypeInfo(TCompiledFileOption), Ord(cfo)),
      cfo in FCompiledFileOptions);
  end;
  for t := low(TMessageType) to high(TMessageType) do
  begin
    WriteStrings(Opt, EurekaLogSection, 'Count ' +
      GetEnumName(TypeInfo(TMessageType), Ord(t)),
      GetEnumName(TypeInfo(TMessageType), Ord(t)), FCustomizedTexts[t]);
  end;
  Opt.WriteString(EurekaLogSection, 'TextsCollection', FTextsCollection);
{$IFDEF Delphi4Up}
  Opt.UpdateFile;
{$ENDIF}
  Opt.Free;
  TempStr.Free;
end;

procedure TBaseModule.ErrorMessage(const Msg: string);
begin
  raise Exception.Create('[EurekaLog ERROR]: ' + Msg);
end;

function TBaseModule.IsReadOnly: Boolean;
begin
  Result := (FileExists(FName)) and (not IsWritableFile(FName));
end;

{$IFDEF Delphi6Up}
function TBaseModule.GetRealFileName(FileName: string; Compiled: Boolean): string;
var
  PackageName, Ext, Prefix, Suffix, Version, DpkText: string;
  MType: TModuleType;

  function GetDirectiveValue(FileText, DirectiveName: string): string;
  var
    Idx: Integer;
  begin
    Result := '';
    DirectiveName := ('{$' + DirectiveName + ' ''');
    Idx := Pos(DirectiveName, FileText);
    if (Idx > 0) then
    begin
      Inc (Idx, Length(DirectiveName));
      Result := Copy(FileText, Idx, PosEx('''}', FileText, Idx) - Idx);
    end;
  end;

begin
  GetModuleInfo(MType, Ext);
  if ((CurrentPersonality.GetPersonality = ptDelphiWin32) and (MType = mtPackage)) then
  begin
    PackageName := ChangeFileExt(Name, '.dpk');
    if (FileExists(PackageName)) then
    begin
      with TStringList.Create do
      try
        LoadFromFile(PackageName);
        DpkText := UpperCase(Text);
      finally
        Free;
      end;
    end
    else DpkText := '';
    Prefix := GetDirectiveValue(DpkText, 'LIBPREFIX');
    Suffix := GetDirectiveValue(DpkText, 'LIBSUFFIX');
    Version := GetDirectiveValue(DpkText, 'LIBVERSION');
    if (Compiled) then
    begin
      FileName := ExtractFilePath(FileName) + Prefix +
        ChangeFileExt(ExtractFileName(FileName), '') + Suffix +
        ExtractFileExt(FileName);
      if (Version <> '') then FileName := FileName + '.' + Version;
    end
    else
    begin
      FileName := ChangeFileExt(FileName, '.map');
    end;
    Result := FileName;
  end
  else
  begin
    if (not Compiled) then Result := ChangeFileExt(FileName, '.map')
    else Result := FileName;
  end;
end;
{$ELSE}
function TBaseModule.GetRealFileName(FileName: string; Compiled: Boolean): string;
begin
  if (not Compiled) then Result := ChangeFileExt(FileName, '.map')
  else Result := FileName;
end;
{$ENDIF}

procedure TBaseModule.SaveOptions;
begin
  SaveOptionsToFile(OptionFile);
end;

procedure TBaseModule.SaveOptionsToDefaultOptionFile;
begin
  SaveOptionsToFile(EurekaDefaultOptionFile);
end;

function TBaseModule.GetOptionFile: string;
begin
  Result := ChangeFileExt(FName, OptionFileExt(FName));
end;

class function TBaseModule.GetText(const FileName: string): string;
var
  s: TStringList;
begin
  Result := '';
  s := TStringList.Create;
  try
    if (FileExists(FileName)) then s.LoadFromFile(FileName);
    Result := s.Text;
  finally
    s.Free;
  end;
end;

procedure TBaseModule.DeleteText(const FileName: string; StartPos,
  EndPos: integer);
var
  s: TStringList;
  Text: string;
begin
  Inc(StartPos);
  Inc(EndPos);
  Text := GetText(FileName);
  Delete(Text, StartPos, EndPos - StartPos);
  s := TStringList.Create;
  try
    s.Text := Text;
    s.SaveToFile(FileName);
  finally
    s.Free;
  end;
end;

procedure TBaseModule.InsertText(const FileName: string; StartPos: integer;
  Text: PChar);
var
  s: TStringList;
  Txt: string;
begin
  Inc(StartPos);
  Txt := GetText(FileName);
  Insert(Text, Txt, StartPos);
  s := TStringList.Create;
  try
    s.Text := Txt;
    s.SaveToFile(FileName);
  finally
    s.Free;
  end;
end;

procedure TBaseModule.SetDebugOptions(Active: Boolean);
begin
end;

procedure TBaseModule.GetModuleInfo(var MType: TModuleType; var ext: string);

  procedure GetDelphiModuleInfo;
  var
    FirstWord: string;

    // Buffer for store Source text.
    Text: string;

    Idx, Start: integer;

    Ext2: string;
  begin
    ext := '';
    MType := mtUnknown;
    Text := UpperCase(GetText(FName));
    Idx := 1;

    // Kill spaces, linebreak (#13#10), directives and comments...
    KillInutilChars(Text, Idx, True);

    // 7 = length of "Program", "Library" and "Package" words...
    FirstWord := Copy(Text, Idx, 7);

    // Search for "Program/Library/Package" word...
    if (FirstWord = ProgramWord) then
    begin
      ext := '.exe';
      MType := mtProgram;
    end
    else
      if (FirstWord = LibraryWord) then
      begin
        ext := '.dll';
        MType := mtLibrary;
      end
      else
        if (FirstWord = PackageWord) then
        begin
          ext := '.bpl';
          MType := mtPackage;
        end;

    // Search for the command-line new exception...
    Ext2 := GetCommandLineOption('-TX');
    if (Pos('.', Ext2) = 0) then Ext2 := '.' + Ext2;

    if (Ext2 <> '.') then ext := Ext2;

    // Search for "{$E NewExtension}" directive...
    Start := Pos('{$E ', Text);
    if Start > 0 then
    begin
      Inc(Start, 4);
      Idx := Start;
      while (Idx <= Length(Text)) and (Text[Idx] <> '}') and
        (Text[Idx] <> #13) do Inc(Idx);
      if (Idx <= Length(Text)) and (Text[Idx] = '}') then
      begin
        ext := LowerCase(Copy(Text, Start, (Idx - Start)));
        if (ext <> '') and (ext[1] <> '.') then
          ext := '.' + copy(ext, 1, 3);
      end;
    end;
  end;

  procedure GetCppBuilderModuleInfo;
  var
    LFLAGS, Flag: string;
  begin
    MType := mtUnknown;
    ext := ExtractFileExt(GetCppBuilderOutputFile);
    LFLAGS := GetCppFileOptionValue(FName, 'LFLAGS');
    if (LFLAGS <> '') then
    begin
      if (Pos('-Tpe', LFLAGS) > 0) then MType := mtProgram
      else
        if (Pos('-Tpd', LFLAGS) > 0) then MType := mtLibrary
        else
          if (Pos('-Tpp', LFLAGS) > 0) then MType := mtPackage;
    end
    else
    begin
      Flag := GetCppFileOptionValue(FName, 'property category="win32.*.win32b.ilink32" name="option.Tpe.enabled"');
      if (Flag = '1') then MType := mtProgram
      else
      begin
        Flag := GetCppFileOptionValue(FName, 'property category="win32.*.win32b.ilink32" name="option.Tpd.enabled"');
        if (Flag = '1') then MType := mtLibrary
        else
        begin
          Flag := GetCppFileOptionValue(FName, 'property category="win32.*.win32b.ilink32" name="option.Tpp.enabled"');
          if (Flag = '1') then MType := mtPackage;
        end;
      end;
    end;
    if (MType = mtUnknown) then
    begin
      if (CompareText(ext, '.exe') = 0) then MType := mtProgram
      else
        if (CompareText(ext, '.dll') = 0) then MType := mtLibrary
        else
        if (CompareText(ext, '.bpl') = 0) then MType := mtPackage
    end;
  end;

begin
  if (CurrentPersonality.GetPersonality = ptDelphiWin32) then GetDelphiModuleInfo
  else GetCppBuilderModuleInfo;
end;

function TBaseModule.GetModuleType: TModuleType;
var
  ext: string;
begin
  // A Delphi 3/4 workaround IDE ToolsAPI BUG...
  Result := mtUnknown;
  if (Self = nil) then Exit;

  GetModuleInfo(Result, ext);
end;

function TBaseModule.GetCommandLineOption(const Opt: string): string;
var
  i: Integer;
  Option, Value: string;

  procedure GetOptionFromCfgFile(const ConfigFile: string; var OutputDir: string);
  var
    i: integer;
    Cfg: TStringList;
    Option, Value: string;
  begin
    if FileExists(ConfigFile) then
    begin
      Cfg := TStringList.Create;
      try
        Cfg.LoadFromFile(ConfigFile);
        for i := 0 to Cfg.Count - 1 do
        begin
          ElaborateParameter(Cfg[i], Length(Opt), Option, Value);
          if Option = Opt then OutputDir := Value;
        end;
      finally
        Cfg.Free;
      end;
    end;
  end;

begin
  Result := '';
  if (not IsConsole) {is Design-Time} then Exit;

  // Elaborate DCC32.CFG file into DCC32 dir (command-line configuration file)...
  GetOptionFromCfgFile(ExtractFilePath(ParamStr(0)) + 'dcc32.cfg', Result);

  // Elaborate DCC32.CFG file into current dir (command-line configuration file)...
  GetOptionFromCfgFile('dcc32.cfg', Result);

{$IFDEF Delphi4Up}
  // Elaborate ProjectName.cfg file...
  GetOptionFromCfgFile(ChangeFileExt(OptionFile, '.cfg'), Result);
{$ENDIF}

  // Elaborate parameter options...
  for i := 1 to ParamCount do
  begin
    ElaborateParameter(ParamStr(i), Length(Opt), Option, Value);
    if (Option = Opt) then Result := Value;
  end;
end;

function TBaseModule.GetCppBuilderOutputFile: string;
var
  Build_Active, Build_Dir, Build_Name, Build_File, TargetBuild: string;
  Idx: Integer;
begin
  Result := '';
  if (CompareText('.bdsproj', ExtractFileExt(FName)) = 0) then
  begin
    Build_Active := '';
    if ((ParamCount > 0) and (ParamStr(ParamCount)[1] <> '-')) then
    begin
      TargetBuild := ParamStr(ParamCount);
      for Idx := 0 to 9 do
      begin
        Build_Name := GetCppFileOptionValue(FName,
          Format('property category="build.config.%d" name="key"', [Idx]));
        if (CompareText(Build_Name, TargetBuild) = 0) then
        begin
          Build_Active := IntToStr(Idx);
          Break;
        end;
      end;
    end;
    if (Build_Active = '') then
      Build_Active := GetCppFileOptionValue(FName,
        'property category="build.config" name="active"');
    if (Build_Active <> '') then
    begin
//      Build_Name := Format('property category="build.config.%s" name="win32.win32b.builddir"', [Build_Active]);
      Build_Name := GetCppFileOptionValue(FName,
        Format('property category="build.config.%s" name="key"', [Build_Active]));
      Build_Dir := GetCppFileOptionValue(FName,
        Format('property category="win32.%s.win32b.ilink32" name="option.outputdir.arg.1"',
        [Build_Name]));
      if (Build_Dir = '') then
        Build_Dir := GetCppFileOptionValue(FName,
          'property category="win32.*.win32b.ilink32" name="option.outputdir.arg.1"');
      if (Build_Dir = '') then Build_Dir := ExtractFilePath(FName);
      if (Build_Dir <> '') then
      begin
        if (ExtractFileDrive(Build_Dir) = '') then // Relative path.
          Build_Dir := (ExtractFilePath(FName) + Build_Dir);
        Build_Dir := IncludeLastBackslash(Build_Dir);
      end;
      Build_File := GetCppFileOptionValue(FName, 'property category="build.node" name="name"');
      Result := (AdjustDir(Build_Dir, False) + Build_File);
    end;
  end
  else
  begin
    Build_File := AdjustDir(GetCppFileOptionValue(FName, 'PROJECT'), True);
    if (ExtractFilePath(Build_File) = '') then
      Build_File := (ExtractFilePath(FName) + Build_File);
    Result := Build_File;
  end;
end;

// This function return output dir of the current module (project or package)...
function TBaseModule.GetOutputDir: string;
begin
  if (CurrentPersonality.GetPersonality = ptDelphiWin32) then
  begin
    if (ModuleType <> mtPackage) then
      Result := GetCommandLineOption('-E') // Projects.
    else
      Result := GetCommandLineOption('-LE'); // Packages.
  end
  else Result := ExtractFilePath(GetCppBuilderOutputFile);
end;

procedure TBaseModule.GetUnitDirs(List: TStrings);
begin
  // ...
end;

// This function return the default Packages output dir...

function TBaseModule.SetBplFile(SourceFile: string): string;
var
  BplPath, LibName, BPLName: string;
begin
{$IFDEF Delphi9Down}
  LibName := 'Library';
  BPLName := 'Package DPL Output';
{$ELSE}
  if (CurrentPersonality.GetPersonality = ptCppBuilderWin32) then
  begin
    LibName := 'CppPaths';
    BPLName := 'BPLOutput';
  end
  else
  begin
    LibName := 'Library';
    BPLName := 'Package DPL Output';
  end;
{$ENDIF}
  SourceFile := ChangeFileExt(SourceFile, '.bpl');
  BplPath := ReadKey(HKEY_CURRENT_USER, RADRegistryKey + '\' + LibName, BPLName);
  if (BplPath <> '') then
    Result := (ExtractFilePath(AdjustDir(BplPath, False)) + ExtractFileName(SourceFile))
  else
    Result := SourceFile;
end;

function TBaseModule.GetCompiledFile: string;
var
  OutputDir, NewExt: string;
  ModuleType: TModuleType;
begin
  Result := '';
  if (Self = nil) then Exit;
  
  Result := Name;
  GetModuleInfo(ModuleType, NewExt);
  case ModuleType of
    mtProgram: ;
    mtLibrary: ;
    mtPackage: Result := SetBplFile(Result);
  end;
  OutputDir := GetOutputDir;
  if (OutputDir <> '') then
    Result := ExtractFilePath(IncludeLastBackslash(OutputDir)) +
      ExtractFileName(Result);

  Result := GetRealFileName(ChangeFileExt(Result, NewExt), True);
end;

function TBaseModule.GetMapFile: string;
begin
  Result := GetRealFileName(CompiledFile, False);
end;

{ TBaseModules }

function GetCurrentModuleName: string;
begin
  if (ModuleOptions.Count > 0) then
    Result := ModuleOptions[0].Name else Result := '';
end;

procedure TModules.AddModule(ClassType: TBaseClass; AModuleName: string; LoadType: TLoadType);
var
  P: TBaseModule;
begin
  P := ClassType.Create(AModuleName);
  Add(P);
  case LoadType of
    ltLoadModuleOptions: P.LoadOptions;
    ltLoadDefaultOptions: P.LoadOptionsFromDefaultOptionFile;
  end;
end;

destructor TModules.Destroy;
var
  i: integer;
begin
  for i := 0 to Count - 1 do Items[0].Free;
  inherited;
end;

function TModules.FindByName(ModuleName: string): Integer;
var
  i: integer;
begin
  i := 0;
  while (i <= Count - 1) and
    (UpperCase(Trim(Items[i].Name)) <> UpperCase(Trim(ModuleName))) do inc(i);
{$IFDEF Delphi11Up}
  if (i = Count) then
  begin
    i := 0;
    while (i <= Count - 1) and
      (UpperCase(Trim(ChangeFileExt(Items[i].Name, OptionFileExt('')))) <>
      UpperCase(Trim(ModuleName))) do inc(i);
  end;
{$ENDIF}
  if (i = Count) then Result := -1
  else Result := i;
end;

function TModules.GetCurrentModule: TBaseModule;
var
  i: integer;
begin
  i := ModuleOptions.FindByName(GetCurrentModuleNameProc);
  if (i <> -1) then Result := ModuleOptions[i] else Result := nil;
end;

function TModules.GetItem(Index: Integer): TBaseModule;
begin
  Result := TBaseModule(TList(Self).Items[Index]);
end;

procedure TModules.Delete(Index: integer);
var
  Ptr: Pointer;
begin
  Ptr := Items[Index];
  TBaseModule(Ptr).Free;
  inherited;
end;

procedure TModules.SetItem(Index: Integer; Value: TBaseModule);
begin
  TList(Self).Items[Index] := Pointer(Value);
end;

function TBaseModule.ExecProgram(const CommandLine: string): Integer;
var
  ProcInfo: TProcessInformation;
  hProcess: THandle;
  StartInfo: TStartupInfo;
begin
  FillChar(StartInfo, SizeOf(StartInfo), 0);
  if not CreateProcess(nil, PChar(CommandLine), nil, nil, False,
    CREATE_DEFAULT_ERROR_MODE + NORMAL_PRIORITY_CLASS, nil, nil,
    StartInfo, ProcInfo) then
    raise Exception.CreateFmt('Cannot execute the "%s" command.', [CommandLine]);
  hProcess := ProcInfo.hProcess; // Save the process handle.
  //Close the thread handle as soon as it is no longer needed.
  CloseHandle(ProcInfo.hThread);
  WaitForSingleObject(hProcess, INFINITE);
  GetExitCodeProcess(hProcess, DWord(Result));
  CloseHandle(hProcess);
end;

procedure TBaseModule.BeforeCompile;
begin
  if (ModuleType in TUnhandledModules) or
    (not IsAcceptableProject(FName)) then Exit;

  MakeLine(ActivateLog);
  DeleteFile(MapFile);
  Compiled := True;

{$IFDEF Delphi5Up}
  if (ActivateLog) and (ExpandEnvVar(PreBuildEvent) <> '') then
    ExecProgram(ExpandEnvVar(PreBuildEvent));
{$ENDIF}
end;

procedure TBaseModule.AfterCompile;

  function InstalledPackage: Boolean;
  begin
    Result := (ModuleType = mtPackage) and
      (GetModuleHandle(PChar(ExtractFileName(CompiledFile))) <> 0);
  end;

begin
  if (ModuleType in TUnhandledModules) or
    (not IsAcceptableProject(FName)) then Exit;

  // AutoCompleteCompile or NormalCompile ???
  if (Compiled) then
    if (FileExists(MapFile)) then
    begin // Successful compilation...
      Compiled := False;
      if (ActivateLog) and (not InstalledPackage) then BuildMapFile;
      CheckCompiler;
{$IFDEF Delphi5Up}
      if (ActivateLog) and (ExpandEnvVar(PostSuccessfulBuildEvent) <> '') then
        ExecProgram(ExpandEnvVar(PostSuccessfulBuildEvent));
{$ENDIF}
    end
{$IFDEF Delphi5Up}
    else // Falire compilation...
    if (ActivateLog) and (ExpandEnvVar(PostFailureBuildEvent) <> '') then
      ExecProgram(ExpandEnvVar(PostFailureBuildEvent));
{$ENDIF}
end;

//------------------------------------------------------------------------------

function InternalGetCurrentPersonality: TPersonalityClass;
begin
{$IFDEF CBuilder}
  Result := TCppBuilderWin32Personality;
{$ELSE}
  Result := TDelphiWin32Personality;
{$ENDIF}
end;

//------------------------------------------------------------------------------

procedure Init;
begin
  CurrentPersonality := InternalGetCurrentPersonality;

  if (not Assigned(CheckCompiler)) then
    @CheckCompiler := @InternalCheckCompiler;
  ModuleOptions := TModules.Create;
  GetCurrentModuleNameProc := GetCurrentModuleName;
  Compiled := False;
  @IsAcceptableProject := @InternalIsAcceptableProject;
end;

procedure Done;
begin
  ModuleOptions.Free;
  ModuleOptions := nil;
end;

//------------------------------------------------------------------------------

initialization
  SafeExec(Init, 'EBaseModule.Init');

finalization
  SafeExec(Done, 'EBaseModule.Done');

end.
