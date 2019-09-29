unit WinSkinIni;

{$B-}

interface

uses Classes, winconvert;

type
{ TQuickIni class }
  TQuickIni = class(TObject)
  private
    FAuto: boolean;
    FFileName: string;
    FIniFile: TStrings;
    function GetName(const Line: string): string;
    function GetValue(const Line, Name: string): string;
    function GetSectionIndex(const Section: string): Integer;
    function IsSection(const Line: string): Boolean;
    procedure SetFileName(Value: string);
    procedure SetIniFile(Value: TStrings);
  protected
    FSections: TStrings;
    procedure Compress(source, dest: TStream);
    procedure Decompress(source, Dest: TStream);
  public
    constructor Create;
    destructor Destroy; override;
    procedure LoadFromFile(aname: string);
    procedure SaveToFile(aname: string);
    procedure LoadFromStream(Stream: TStream);
    procedure SaveToStream(Stream: Tstream);
    procedure LoadFromZip(aname: string);
    procedure SavetoZip(aname: string);
    procedure DeleteKey(const Section, Ident: string);
    procedure EraseSection(const Section: string);
    function ReadBool(const Section, Ident: string; Default: Boolean): Boolean;
    function ReadInteger(const Section, Ident: string; Default: Longint): Longint;
    procedure ReadSection(const Section: string; Strings: TStrings);
    procedure ReadSections(Strings: TStrings);
    procedure ReadSectionValues(const Section: string; Strings: TStrings);
    function ReadString(const Section, Ident: string; Default: string): string;
    procedure RebuildSections;
    procedure WriteBool(const Section, Ident: string; Value: Boolean);
    procedure WriteInteger(const Section, Ident: string; Value: Longint);
    procedure WriteString(const Section, Ident: string; Value: string);
    property FileName: string read FFileName write SetFileName;
    property AutoSaveLoad: boolean read FAuto write FAuto;
    property IniFile: TStrings read FIniFile write SetIniFile;
    procedure Clear;
  end;

implementation

uses SysUtils;

const
  SStringsUnassignedError = 'The parameter Strings is unassigned!';
  StartBracket = '[';
  EndBracket = ']';
  Separator = '=';

{ TQuickIni }

constructor TQuickIni.Create;
begin
  FAuto := False;
  FIniFile := TStringList.Create;
  FSections := TStringList.Create;
//  if FileExists(FileName) then
//    LoadFromFile;
end;

destructor TQuickIni.Destroy;
begin
  FSections.Free;
  FIniFile.Free;
//  Finalize(FFileName);
end;

function TQuickIni.GetName(const Line: string): string;
var
  I: Integer;
begin
  I := Pos(Separator, Line);
  if I <> 0 then
    Result := Trim(Copy(Line, 1, I - 1))
  else
    Result := EmptyStr;
  result := lowercase(result);
end;

function TQuickIni.GetValue(const Line, Name: string): string;
var
  I: Integer;
begin
  Result := EmptyStr;
  if (Line <> EmptyStr) and (Name <> EmptyStr) then
  begin
    I := Pos(Separator, Line);
    if (Name = GetName(Line)) and (I <> 0) then
      Result := Trim(System.Copy(Line, I + 1, Maxint));
  end;
end;

function TQuickIni.IsSection(const Line: string): Boolean;
var
  S: string;
begin
  Result := False;
  if Line <> EmptyStr then
  begin
    S := Trim(Line);
    if (S[1] = StartBracket) and (S[System.Length(S)] = EndBracket) then
      Result := True;
  end;
end;

function TQuickIni.GetSectionIndex(const Section: string): Integer;

begin
  Result := FSections.IndexOf(StartBracket + Section + EndBracket);
  if Result >= 0 then
    Result := Integer(FSections.Objects[Result])
  else
    Result := -1;
end;

procedure TQuickIni.Decompress(source, Dest: TStream);
var
  LZH: TLZH;
  Size, Bytes: Longint;
begin
    // Decompress in memory blob.
  LZH := TLZH.Create;
  try
    LZH.StreamIn := source;
    LZH.StreamOut := dest;
    LZH.StreamIn.Position := 0;
    LZH.StreamOut.Position := 0;

       // Uncompressed file size
    LZH.StreamIn.Read(size, sizeof(Longint));
    Bytes := Size;

       // Decompress rest of stream.
    LZH.LZHUnpack(Bytes, LZH.GetBlockStream, LZH.PutBlockStream);
  finally
    LZH.Free;
  end;
end;

procedure TQuickIni.compress(source, dest: TStream);
var
  LZH: TLZH;
  Size, Bytes: Longint;
begin
    // Decompress in memory blob.
  LZH := TLZH.Create;
  try
    LZH.StreamIn := Source;
    LZH.StreamOut := dest;
    LZH.StreamIn.Position := 0;
    LZH.StreamOut.Position := 0;

        //write uncompressed size
    Size := LZH.StreamIn.Size;
    LZH.StreamOut.Write(Size, sizeof(Longint));

        // Compress stream.
    LZH.LZHPack(Bytes, LZH.GetBlockStream, LZH.PutBlockStream);
  finally
    LZH.Free;
  end;
end;

procedure TQuickIni.LoadFromZip(aname: string);
var
  r, r2: TMemoryStream;
begin
  r := Tmemorystream.create;
  r2 := Tmemorystream.create;
  try
    r2.loadfromfile(aname);
    Decompress(r2, r);
    r.Seek(0, soFromBeginning);
    loadfromstream(r);
  finally
    r.free;
    r2.free;
  end;
end;

procedure TQuickIni.SavetoZip(aname: string);
var
  m, m2: TMemoryStream;
begin
  m := Tmemorystream.create;
  m2 := Tmemorystream.create;
  try
    savetostream(m);
    compress(m, m2);
    m2.savetofile(aname);
  finally
    m.free;
    m2.free;
  end;
end;

procedure TQuickIni.LoadFromFile(aname: string);
var
  Stream: TStream;
begin
  Stream := TFileStream.Create(aname, fmOpenRead or fmShareDenyWrite);
  LoadFromStream(Stream);
  Stream.Free;
end;
 { TODO : 111 }

procedure TQuickIni.LoadFromStream(Stream: TStream);
var
  Ptr, Start: PAnsiChar;
  StmStr {,Str}: Ansistring;
  Size: integer;
  Str: string;
  I: integer;
begin
  if not assigned(Stream) then exit;

  FIniFile.BeginUpdate;
  FSections.BeginUpdate;
  try
    Size := Stream.Size - Stream.Position;
    SetString(StmStr, nil, Size);
    Stream.Read(Pointer(StmStr)^, Size);
    FIniFile.Clear;
    FSections.Clear;
    Ptr := Pointer(StmStr);
    I := 0;
    if Ptr <> nil then
      while Ptr^ <> #0 do
      begin
        Start := Ptr;
        while not (Ptr^ in [#0, #10, #13]) do
          Inc(Ptr);
        SetString(Str, Start, Ptr - Start);
        Str := Trim(Str);
        if (Str <> '') and (Str[1] <> ';') then
        begin
          FIniFile.Add(Str);
          if (Str[1] = '[') and (Str[Length(Str)] = ']') then
          begin
            FSections.AddObject(Trim(Str), TObject(I));
          end;
          inc(I);
        end;
        if Ptr^ = #13 then Inc(Ptr);
        if Ptr^ = #10 then Inc(Ptr);
      end;
  finally
    FSections.EndUpdate;
    FIniFile.EndUpdate;
  end;
end;

procedure TQuickIni.SaveToFile(aname: string);
begin
//  if AutoSaveLoad then
  FIniFile.SaveToFile(aname);
end;

procedure TQuickIni.SaveToStream(Stream: Tstream);
begin
//  if AutoSaveLoad then
  if assigned(stream) then
    FIniFile.SaveTostream(stream);
end;

{ Read all Names of one Section }
{ TODO : 111 }

procedure TQuickIni.ReadSection(const Section: string; Strings: TStrings);
var
  I: Integer;
  N: string;
begin
  Assert(Assigned(Strings), SStringsUnassignedError);
  Strings.BeginUpdate;
  try
    Strings.Clear;
    if FIniFile.Count > 0 then
    begin
      I := GetSectionIndex(Section);
      if I <> -1 then
      begin
        Inc(I);
        while (I < FIniFile.Count) and not IsSection(FIniFile[I]) do
        begin
          N := GetName(FIniFile[I]);
          if N <> EmptyStr then Strings.Add(N);
          Inc(I);
        end;
      end;
    end;
  finally
    Strings.EndUpdate;
  end;
end;

{ Read all Sections of the Ini-File }

procedure TQuickIni.ReadSections(Strings: TStrings);
var
  I: Integer;
  Section: string;
begin
  Assert(Assigned(Strings), SStringsUnassignedError);
  Strings.Assign(FSections);
  I := 0;
  while I < Strings.Count do
  begin
    Strings.Objects[I] := nil;
    Section := Trim(Strings.Strings[I]);
    System.Delete(Section, 1, 1);
    System.Delete(Section, System.Length(Section), 1);
    Strings.Strings[I] := Trim(Section);
    Inc(I);
  end;
end;

{ Reads a String-Value of Ident in one Section.
  The result is Default if
  o Section doesn't exists
  o Ident doesn't exists
  o Ident doesn't have any assigned value }
{ TODO : 111 }

function TQuickIni.ReadString(const Section, Ident: string; Default: string): string;
var
  I: Integer;
  V, s: string;
begin
  Result := Default;
  s := lowercase(ident);
  if FIniFile.Count > 0 then
  begin
    I := GetSectionIndex(Section);
    if I <> -1 then
    begin
      Inc(I);
      while (I < FIniFile.Count) and not IsSection(FIniFile[I]) do
      begin
        if GetName(FIniFile[I]) = s then
        begin
          V := GetValue(FIniFile[I], s);
          if V <> EmptyStr then
            Result := V;
          break;
        end;
        Inc(I);
      end;
    end;
  end;
end;

{ Reads an Integer-Value of Ident in one Section }
{ TODO : 111 }

function TQuickIni.ReadInteger(const Section, Ident: string; Default: Longint): Longint;
var
  IntStr: string;
begin
  IntStr := ReadString(Section, Ident, '');
  // convert a Hex-Value
  if (Length(IntStr) > 2) and (IntStr[1] = '0') and ((IntStr[2] = 'X') or (IntStr[2] = 'x')) then
    IntStr := '$' + System.Copy(IntStr, 3, Maxint);
  Result := StrToIntDef(IntStr, Default);
end;

{ Reads a Bool-Value of Ident in one Section }

function TQuickIni.ReadBool(const Section, Ident: string; Default: Boolean): Boolean;
begin
  Result := ReadInteger(Section, Ident, Ord(Default)) <> 0;
end;

{ Reads all Names + Values of one Section }

procedure TQuickIni.ReadSectionValues(const Section: string; Strings: TStrings);
var
  I: Integer;
begin
  Assert(Assigned(Strings), SStringsUnassignedError);
  Strings.BeginUpdate;
  try
    Strings.Clear;
    if FIniFile.Count > 0 then
    begin
      I := GetSectionIndex(Section);
      if I <> -1 then
      begin
        Inc(I);
        while (I < FIniFile.Count) and not IsSection(FIniFile[I]) do
        begin
          if (FIniFile[I] <> '') then
            Strings.Add(FIniFile[I]);
          Inc(I);
        end;
      end;
    end;
  finally
    Strings.EndUpdate;
  end;
end;

{ Writes a String-Value for Ident in one Section.
  Note: If Section and/or Ident don't exist, they will be placed in the Ini-File }

procedure TQuickIni.WriteString(const Section, Ident: string; Value: string);
var
  I: Integer;
  Q: integer;
  s: string;
begin
  I := GetSectionIndex(Section);
  s := lowercase(ident);
  // Section exists
  if I >= 0 then
  begin
    Inc(I);
    while (I < FIniFile.Count) and not IsSection(FIniFile[I])
      and (GetName(FIniFile[I]) <> s) do
    begin
      Inc(I);
    end;
    // End of File or Ident doesn't exists in the Section
    if (I >= FIniFile.Count) then
    begin
      if Ident <> EmptyStr then
      begin
        FIniFile.Add(Ident + Separator + Value);
      end
    end
    else if (I < FIniFile.Count) and IsSection(FIniFile[I]) then
    begin
      if Ident <> EmptyStr then
      begin
        FIniFile.Insert(I, Ident + Separator + Value);
        Inc(I);
        Q := FSections.IndexOf(FIniFile[I]);
        FSections.Objects[Q] := TObject(I + 1);
      end
    end
    // Ident does exists in the section
    else if Ident <> EmptyStr then
    begin
      FIniFile[I] := Ident + Separator + Value;
    end;
  end
  // Section doesn't exists, so add new [Section] with Ident=Value
  else
  begin
    I := FIniFile.Add(StartBracket + Section + EndBracket);
    FSections.AddObject(StartBracket + Section + EndBracket, TObject(I));
    if Ident <> EmptyStr then
    begin
      FIniFile.Add(Ident + Separator + Value);
    end;
  end;
//  SaveToFile;
end;

{ Writes an Integer-Value for Ident in one Section }

procedure TQuickIni.WriteInteger(const Section, Ident: string; Value: Longint);
begin
  WriteString(Section, Ident, IntToStr(Value));
end;

{ Writes a Bool-Value for Ident in one Section }

procedure TQuickIni.WriteBool(const Section, Ident: string; Value: Boolean);
const
  Values: array[Boolean] of string = ('0', '1');
begin
  WriteString(Section, Ident, Values[Value]);
end;

{ Deletes the Value of Ident in one Section.
  Note: Only if Section and Ident exist, the Value of Ident will be set to NULL }

procedure TQuickIni.DeleteKey(const Section, Ident: string);
var
  I: Integer;
begin
  I := GetSectionIndex(Section);
  if I <> -1 then
  begin
    Inc(I);
    while (I < FIniFile.Count) and not IsSection(FIniFile[I]) and
      (GetName(FIniFile[I]) <> Ident) do Inc(I);
    // Ident does exists
    if not (I >= FIniFile.Count) and not IsSection(FIniFile[I]) then
    begin
      FIniFile.Delete(I);
//      SaveToFile;
    end;
  end;
end;

procedure TQuickIni.EraseSection(const Section: string);
var
  I: Integer;
begin
  I := GetSectionIndex(Section);
  if I <> -1 then
  begin
    // Delete Section-Header
    FIniFile.Delete(I);
    // Delete Section-Items
    while (I < FIniFile.Count) and not IsSection(FIniFile[I]) do
      FIniFile.Delete(I);
    if I > 0 then FIniFile.Insert(I, EmptyStr);
//    SaveToFile;
  end;
end;

procedure TQuickIni.SetFileName(Value: string);
begin
  if Value <> FFileName then
  begin
    FFileName := Value;
//    if FileExists(Value) and FAuto then
//      LoadFromFile;
  end;
end;

procedure TQuickIni.SetIniFile(Value: TStrings);
begin
  FIniFile.Assign(Value);
  RebuildSections;
end;

procedure TQuickIni.RebuildSections;
var
  I: integer;
  Count: integer;
begin
  FSections.Clear;
  I := 0;
  Count := FIniFile.Count;
  while I < Count do
  begin
    if (FIniFile[I] <> '') and (FIniFile[I][1] = '[') and (FIniFile[I][Length(FIniFile[I])] = ']') then
    begin
      if assigned(FSections) then
        FSections.AddObject(Trim(FIniFile[I]), TObject(I));
    end;
    inc(I);
  end;
end;

procedure TQuickIni.Clear;
begin
  FIniFile.Clear;
  FSections.Clear;
end;

end.

