{*******************************************************}
{                                                       }
{                      EhLib v5.0                       }
{                    (Build 5.0.00)                     } 
{                                                       }
{   TPropStorageManagerEh, TIniPropStorageManEh,        }
{   TRegPropStorageManEh,  TPropStorageEh components    }
{                                                       }
{   Copyright (c) 2002-2006 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}
//{$I EhLibClx.Inc}

unit PropStorageEh;

interface

uses
  Windows, Forms, Controls, Registry, PropFilerEh, Dialogs, SysUtils,
{$IFDEF CIL}
  EhLibVCLNET,
{$ELSE}
  EhLibVCL,
{$ENDIF}
  Classes, IniFiles, TypInfo;

type

  TPropStorageEh = class;
  TPropertyNamesEh = class;

{ TPropStorageManagerEh }

  TPropStorageManagerEh = class(TComponent)
  private
    FWriteAsText: Boolean;
  protected
    property WriteAsText: Boolean read FWriteAsText write FWriteAsText default True;
  public
    constructor Create(AOwner: TComponent); override;
    procedure ReadProperties(PropStorage: TPropStorageEh); virtual;
    procedure ReadPropertiesStream(Stream: TStream; PropStorage: TPropStorageEh); virtual;
    procedure WriteProperties(PropStorage: TPropStorageEh); virtual;
    procedure WritePropertiesStream(PropStorage: TPropStorageEh; Stream: TStream); virtual;
    procedure WritePropertiesText(PropStorage: TPropStorageEh; Text: String); virtual;
  end;

{ TIniPropStorageManEh }

  TIniPropStorageManEh = class(TPropStorageManagerEh)
  private
    FIniFileName: String;
  public
    procedure ReadProperties(PropStorage: TPropStorageEh); override;
    procedure WritePropertiesStream(PropStorage: TPropStorageEh; Stream: TStream); override;
    procedure WritePropertiesText(PropStorage: TPropStorageEh; Text: String); override;
  published
    property IniFileName: String read FIniFileName write FIniFileName;
    property WriteAsText;
  end;

{ TRegPropStorageManEh }

  TRegistryKeyEh = (rkClassesRootEh, rkCurrentUserEh,
      rkLocalMachineEh, rkUsersEh, rkPerformanceDataEh,
      rkCurrentConfigEh, rkDynDataEh, rkCustomRegistryKeyEh);

  TRegPropStorageManEh = class(TPropStorageManagerEh)
  private
    FKey: HKEY;
    FPath: String;
    FRegistryKey: TRegistryKeyEh;
    procedure SerRegistryKey(const Value: TRegistryKeyEh);
    procedure SetKey(const Value: HKEY);
    procedure ReadPropertiesOld(PropStorage: TPropStorageEh);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ReadProperties(PropStorage: TPropStorageEh); override;
    procedure WritePropertiesStream(PropStorage: TPropStorageEh; Stream: TStream); override;
    procedure WritePropertiesText(PropStorage: TPropStorageEh; Text: String); override;
    property Key: HKEY read FKey write SetKey default HKEY_CURRENT_USER;
  published
    property RegistryKey: TRegistryKeyEh read FRegistryKey write SerRegistryKey default rkCurrentUserEh;
    property Path: String read FPath write FPath;
    property WriteAsText;
  end;

{ TPropStorageEh }

  TWriteCustomPropsEventEh = procedure(Sender: TObject; Writer: TPropWriterEh) of object;
  TReadPropEventEh = procedure(Sender: TObject; Reader: TPropReaderEh;
    PropName: String; var Processed: Boolean) of object;

  TPropStorageEh = class(TComponent)
  private
    FActive: Boolean;
    FAfterLoadProps: TNotifyEvent;
    FAfterSaveProps: TNotifyEvent;
    FBeforeLoadProps: TNotifyEvent;
    FBeforeSaveProps: TNotifyEvent;
    FDestroying: Boolean;
    FOnReadProp: TReadPropEventEh;
    FOnWriteCustomProps: TWriteCustomPropsEventEh;
    FOnSavePlacement: TNotifyEvent;
    FSaved: Boolean;
    FSaveFormCloseQuery: TCloseQueryEvent;
    FSaveFormDestroy: TNotifyEvent;
    FSaveFormShow: TNotifyEvent;
    FSection: String;
    FStorageManager: TPropStorageManagerEh;
    FStoredProps: TPropertyNamesEh;
    function GetForm: TForm;
    function GetSection: String;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RestoreEvents;
    procedure SetEvents;
    procedure SetSection(const Value: String);
    procedure SetStorageManager(const Value: TPropStorageManagerEh);
    procedure SetStoredProps(const Value: TPropertyNamesEh);
  protected
    procedure Loaded; override;
    procedure Save; dynamic;
    property Form: TForm read GetForm;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure ReadProp(Reader: TPropReaderEh; PropName: String; var Processed: Boolean);
    procedure WriteCustomProps(Writer: TPropWriterEh);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadProperties;
    procedure ReadPropValues(Stream: TStream);
    procedure SaveProperties;
    procedure WritePropValues(Stream: TStream);
  published
    property Active: Boolean read FActive write FActive default True;
    property Section: String read GetSection write SetSection;
    property StorageManager: TPropStorageManagerEh read FStorageManager write SetStorageManager;
    property StoredProps: TPropertyNamesEh read FStoredProps write SetStoredProps;
    property AfterLoadProps: TNotifyEvent read FAfterLoadProps write FAfterLoadProps;
    property AfterSaveProps: TNotifyEvent read FAfterSaveProps write FAfterSaveProps;
    property BeforeLoadProps: TNotifyEvent read FBeforeLoadProps write FBeforeLoadProps;
    property BeforeSaveProps: TNotifyEvent read FBeforeSaveProps write FBeforeSaveProps;
    property OnWriteCustomProps: TWriteCustomPropsEventEh read FOnWriteCustomProps write FOnWriteCustomProps;
    property OnReadProp: TReadPropEventEh read FOnReadProp write FOnReadProp;
  end;

{ TPropertyNamesEh }

  TPropertyNamesEh = class(TStringList)
  private
    FRoot: TComponent;
    procedure SetRoot(const Value: TComponent);
  protected
    function CompareStrings(const S1, S2: string): Integer; {$IFDEF EH_LIB_6} override; {$ENDIF}
    function CheckPropertyPath(Path: String): Boolean;
    function CheckObjectPropertyPath(Instance: TObject; PropPath: String): Boolean;
    procedure CheckPropertyNames;
  public
    function Add(const S: string): Integer; override;
    property Root: TComponent read FRoot write SetRoot;
  end;

  procedure GetDefinePropertyList(AObject: TPersistent; sl: TStrings);

  function DefaultPropStorageManager: TPropStorageManagerEh;
  function SetDefaultPropStorageManager(NewStorageManager: TPropStorageManagerEh): TPropStorageManagerEh;

function RegistryKeyToIdent(RootKey: Longint; var Ident: string): Boolean;
function IdentToRegistryKey(const Ident: string; var RootKey: Longint): Boolean;
procedure GetRegistryKeyValues(Proc: TGetStrProc);

implementation

function GetDefaultSection(Component: TComponent): String;
var
  F: TCustomForm;
  Owner: TComponent;
begin
  if Component <> nil then
  begin
    if Component is TCustomForm then
      Result := Component.ClassName
    else
    begin
      Result := Component.Name;
      if Component is TControl then
      begin
        F := GetParentForm(TControl(Component));
        if F <> nil then
          Result := F.ClassName + Result
        else
        begin
          if TControl(Component).Parent <> nil then
            Result := TControl(Component).Parent.Name + Result;
        end;
      end else
      begin
        Owner := Component.Owner;
        if Owner is TForm then
          Result := Format('%s.%s', [Owner.ClassName, Result]);
      end;
    end;
  end
  else Result := '';
end;

function GetDefaultIniName: string;
begin
  Result := ExtractFileName(ChangeFileExt(Application.ExeName, '.INI'));
end;

function GetDefaultRegKey: string;
begin
  if Application.Title <> '' then
    Result := Application.Title
  else Result := ExtractFileName(ChangeFileExt(Application.ExeName, ''));
  Result := 'Software\' + Result;
end;

{$IFNDEF EH_LIB_5}

type
  TStreamOriginalFormat = (sofUnknown, sofBinary, sofText);

const
  FilerSignature: array[1..4] of Char = 'TPF0';

function TestStreamFormat(Stream: TStream): TStreamOriginalFormat;
var
  Pos: Integer;
  Signature: Integer;
begin
  Pos := Stream.Position;
  Signature := 0;
  Stream.Read(Signature, sizeof(Signature));
  Stream.Position := Pos;
  if (Byte(Signature) = $FF) or (Signature = Integer(FilerSignature)) then
    Result := sofBinary
    // text format may begin with "object", "inherited", or whitespace
  else if Char(Signature) in ['o','O','i','I',' ',#13,#11,#9] then
    Result := sofText
  else
    Result := sofUnknown;
end;

{$ENDIF}

type
  TDefinePropertyFiler = class(TFiler)
  private
    fsl: TStrings;
  public
    procedure FlushBuffer; override;
    procedure DefineProperty(const Name: String; ReadData: TReaderProc; WriteData: TWriterProc; HasData: Boolean); override;
    procedure DefineBinaryProperty(const Name: String; ReadData, WriteData: TStreamProc; HasData: Boolean); override;
    procedure GetDefinedObjectPropertyNames(AObject: TPersistent; sl: TStrings);
  end;

procedure GetDefinePropertyList(AObject: TPersistent; sl: TStrings);
var
  dpf: TDefinePropertyFiler;
begin
  dpf := TDefinePropertyFiler.Create(nil,0);
  dpf.GetDefinedObjectPropertyNames(AObject, sl);
  dpf.Free;
end;

{ TDefinePropertyFiler }

procedure TDefinePropertyFiler.DefineBinaryProperty(const Name: String;
  ReadData, WriteData: TStreamProc; HasData: Boolean);
begin
  fsl.Add(Name);
end;

procedure TDefinePropertyFiler.DefineProperty(const Name: String;
  ReadData: TReaderProc; WriteData: TWriterProc; HasData: Boolean);
begin
  fsl.Add(Name);
end;

procedure TDefinePropertyFiler.FlushBuffer;
begin

end;

procedure TDefinePropertyFiler.GetDefinedObjectPropertyNames(
  AObject: TPersistent; sl: TStrings);
var
  FilerAccess: TFilerAccess;
begin
  fsl := sl;
  FilerAccess := TFilerAccess.Create(AObject);
  FilerAccess.DefineProperties(Self);
  FilerAccess.Free;
end;

var
  FDefaultStorageManager: TPropStorageManagerEh;

function DefaultPropStorageManager: TPropStorageManagerEh;
begin
  Result := FDefaultStorageManager;
end;

function SetDefaultPropStorageManager(NewStorageManager: TPropStorageManagerEh): TPropStorageManagerEh;
begin
  Result := FDefaultStorageManager;
  FDefaultStorageManager := NewStorageManager;
end;

{ TPropStorageManagerEh }

constructor TPropStorageManagerEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FWriteAsText := True;
end;

procedure TPropStorageManagerEh.WriteProperties(PropStorage: TPropStorageEh);
var
  ss: TStringStream;
  st: TMemoryStream;
begin
  st := nil;
  ss := nil;
  try
    st := TMemoryStream.Create;
    PropStorage.WritePropValues(st);
    st.Position := 0;
    if WriteAsText then
    begin
      ss := TStringStream.Create('');
      ObjectBinaryToText(st, ss);
      WritePropertiesText(PropStorage, ss.DataString);
    end else
      WritePropertiesStream(PropStorage, st);
  finally
    st.Free;
    ss.Free;
  end;
end;

procedure TPropStorageManagerEh.WritePropertiesText(PropStorage: TPropStorageEh; Text: String);
begin
end;

procedure TPropStorageManagerEh.WritePropertiesStream(PropStorage: TPropStorageEh; Stream: TStream);
begin
end;

procedure TPropStorageManagerEh.ReadProperties(PropStorage: TPropStorageEh);
begin
end;

procedure TPropStorageManagerEh.ReadPropertiesStream(Stream: TStream; PropStorage: TPropStorageEh);
var
  ms: TMemoryStream;
begin
  ms := nil;
  if TestStreamFormat(Stream) = sofUnknown then
    raise Exception.Create('Invalid stream format.');
  try
    if TestStreamFormat(Stream) = sofText then
    begin
      ms := TMemoryStream.Create;
      ObjectTextToBinary(Stream, ms);
      ms.Position := 0;
      Stream := ms;
    end;
    PropStorage.ReadPropValues(Stream);
  finally
    ms.Free;
  end;  
end;

{ TIniPropStorageManEh }

procedure TIniPropStorageManEh.ReadProperties(PropStorage: TPropStorageEh);
var
  ss: TMemoryStream;
  sl: TStrings;
  ini: TCustomIniFile;
  i: Integer;
  Buffer: TBytes;
begin
  ss := nil;
  sl := nil;
  ini := nil;
  try
    ini := TIniFile.Create(IniFileName);  //TMemIniFile does't found file (if it not in current dir)
    sl := TStringList.Create;

    if not ini.SectionExists(PropStorage.Section) then
      Exit;
    ini.ReadSectionValues(PropStorage.Section, sl);
    for i := 0 to sl.Count - 1 do
      sl.Strings[i] := sl.Values['Line' + IntToStr(i)];

    ss := TMemoryStream.Create();
    StreamWriteBytes(ss, BytesOf(sl[0]));
    ss.Position := 0;
//    ss.Write(BytesOf(sl[0]));

    if TestStreamFormat(ss) <> sofText then
    begin
      ss.Seek(0, soFromEnd);
      for i := 1 to sl.Count - 1 do
//        ss.WriteString(sl[i]);
        StreamWriteBytes(ss, BytesOf(sl[i]));
      ss.Position := 0;

{$IFDEF CIL}
      HexToBinEh(ss.Memory, Buffer, ss.Size);
{$ELSE}
//      SetString(Buffer, nil, ss.Size div 2);
//      SetLength(Buffer, ss.Size div 2);
//      HexToBin(PChar(ss.DataString), PChar(Buffer), ss.Size);
      HexToBinEh(ss.Memory, Buffer, ss.Size);
{$ENDIF}
      ss.Size := 0;
//      ss.WriteString(Buffer);
      StreamWriteBytes(ss, Buffer);
      ss.Position := 0;
    end else
    begin
      ss.Position := 0;
//      ss.WriteString(sl.Text);
      StreamWriteBytes(ss, BytesOf(sl.Text));
      ss.Position := 0;
    end;

    ReadPropertiesStream(ss, PropStorage);

  finally
    ss.Free;
    sl.Free;
    ini.Free;
  end;
end;

procedure TIniPropStorageManEh.WritePropertiesStream(PropStorage: TPropStorageEh; Stream: TStream);
var
  ini: TCustomIniFile;
  Buffer: TBytes;
  Text, Line: String;
  i, Pos: Integer;
begin
  ini := nil;
  Buffer := nil;
  try
    ini := TIniFile.Create(IniFileName);
//    GetMem(Buffer, Stream.Size);
//    SetString(Text, nil, Stream.Size*2);
//    Stream.ReadBuffer(Buffer^, Stream.Size);
    StreamReadBytes(Stream, Buffer, Stream.Size);
//    BinToHex(Buffer, PChar(Text), Stream.Size);
    BinToHexEh(Buffer, Text, Stream.Size);
    i := 0;
    Pos := 1;
    while Pos <= Length(Text) do
    begin
      Line := Copy(Text, Pos, 80);
      ini.WriteString(PropStorage.Section, 'Line' + IntToStr(i), '''' + Line + '''');
      Inc(Pos, 80);
      Inc(i);
    end;

    while ini.ValueExists(PropStorage.Section, 'Line' + IntToStr(i)) do
    begin
      ini.DeleteKey(PropStorage.Section, 'Line' + IntToStr(i));
      Inc(i);
    end;
  finally
//    FreeMem(Buffer);
    ini.Free;
  end;
end;

procedure TIniPropStorageManEh.WritePropertiesText(PropStorage: TPropStorageEh; Text: String);
var
  sl: TStrings;
  ini: TCustomIniFile;
  i: Integer;
begin
  sl := nil;
  ini := nil;
  try
    sl := TStringList.Create;
    sl.Text := Text;

    ini := TIniFile.Create(IniFileName);

    for i := 0 to sl.Count - 1 do
      ini.WriteString(PropStorage.Section, 'Line' + IntToStr(i), '''' + sl[i] + '''');

    i := sl.Count;
    while ini.ValueExists(PropStorage.Section, 'Line' + IntToStr(i)) do
    begin
      ini.DeleteKey(PropStorage.Section, 'Line' + IntToStr(i));
      Inc(i);
    end;
  finally
    sl.Free;
    ini.Free;
  end;
end;

{$IFNDEF EH_LIB_CLX}

{ TRegPropStorageManEh }

const
  RegistryKeys: array[0..6] of TIdentMapEntry = (
    (Value: Integer(HKEY_CLASSES_ROOT); Name: 'HKEY_CLASSES_ROOT'),
    (Value: Integer(HKEY_CURRENT_USER); Name: 'HKEY_CURRENT_USER'),
    (Value: Integer(HKEY_LOCAL_MACHINE); Name: 'HKEY_LOCAL_MACHINE'),
    (Value: Integer(HKEY_USERS); Name: 'HKEY_USERS'),
    (Value: Integer(HKEY_PERFORMANCE_DATA); Name: 'HKEY_PERFORMANCE_DATA'),
    (Value: Integer(HKEY_CURRENT_CONFIG); Name: 'HKEY_CURRENT_CONFIG'),
    (Value: Integer(HKEY_DYN_DATA); Name: 'HKEY_DYN_DATA'));

function RegistryKeyToIdent(RootKey: Longint; var Ident: string): Boolean;
begin
  Result := IntToIdent(RootKey, Ident, RegistryKeys);
end;

function IdentToRegistryKey(const Ident: string; var RootKey: Longint): Boolean;
begin
  Result := IdentToInt(Ident, RootKey, RegistryKeys);
end;

procedure GetRegistryKeyValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  for I := Low(RegistryKeys) to High(RegistryKeys) do Proc(RegistryKeys[I].Name);
end;

constructor TRegPropStorageManEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FKey := HKEY_CURRENT_USER;
  FRegistryKey := rkCurrentUserEh;
end;

destructor TRegPropStorageManEh.Destroy;
begin
  inherited Destroy;
end;

procedure TRegPropStorageManEh.ReadProperties(PropStorage: TPropStorageEh);
var
  ss: TMemoryStream;
  reg: TRegistry;
  IsPresent: Boolean;
  Buffer: TBytes;
  sKeys, sVals, sl: TStringList;
  i, LinePos: Integer;
begin
  ss := nil;
  reg := nil;
  sKeys := nil;
  sVals := nil;
  sl := nil;
  try

    reg := TRegistry.Create;

    reg.RootKey := Key;
    if Path = ''
      then IsPresent := reg.KeyExists(GetDefaultRegKey)
      else IsPresent := reg.KeyExists(Path);

    if IsPresent then
    begin
      if Path = ''
        then reg.OpenKey(GetDefaultRegKey, False)
        else reg.OpenKey(Path, False);
      if reg.ValueExists(PropStorage.Section) then
      begin
        ReadPropertiesOld(PropStorage);
        reg.DeleteValue(PropStorage.Section);
        Exit;
      end;
      reg.CloseKey;
    end;

    if Path = ''
      then IsPresent := reg.OpenKey(GetDefaultRegKey + '\' + PropStorage.Section, False)
      else IsPresent := reg.OpenKey(Path + '\' + PropStorage.Section, False);

    if not IsPresent then Exit;

//    sKeys := TStringList.Create;
    sVals := TStringList.Create;
    sl := TStringList.Create;

//    reg.GetKeyNames(sKeys);
    reg.GetValueNames(sVals);

    for i := 0 to sVals.Count - 1 do
    begin
      LinePos := sVals.IndexOf('Line' + FormatFloat('0000000000', i));
      if LinePos < 0  then Break;
      sl.Add(reg.ReadString(sVals[LinePos]));
    end;

    if sl.Count = 0 then Exit;

    ss := TMemoryStream.Create;
    StreamWriteBytes(ss, BytesOf(sl[0]));
    ss.Position := 0;

    if TestStreamFormat(ss) <> sofText then
    begin
      ss.Seek(0, soFromEnd);
      for i := 1 to sl.Count - 1 do
//        ss.WriteString(sl[i]);
        StreamWriteBytes(ss, BytesOf(sl[i]));
      ss.Position := 0;

//      SetString(Buffer, nil, ss.Size div 2);
//      HexToBin(PChar(ss.DataString), PChar(Buffer), ss.Size);
      HexToBinEh(ss.Memory, Buffer, ss.Size);

      ss.Size := 0;
//      ss.WriteString(Buffer);
      StreamWriteBytes(ss, Buffer);
      ss.Position := 0;
    end else
    begin
      ss.Position := 0;
//      ss.WriteString(sl.Text);
      StreamWriteBytes(ss, BytesOf(sl.Text));
      ss.Position := 0;
    end;

    ReadPropertiesStream(ss, PropStorage);

  finally
    ss.Free;
    reg.Free;
    sKeys.Free;
    sVals.Free;
    sl.Free;
  end;
end;

procedure TRegPropStorageManEh.ReadPropertiesOld(PropStorage: TPropStorageEh);
var
  ss: TMemoryStream;
  reg: TRegistry;
  IsPresent: Boolean;
//  Buffer: String;
  Buffer: TBytes;
begin
  ss := nil;
  reg := nil;
  try

    reg := TRegistry.Create;

    reg.RootKey := Key;
    if Path = ''
      then IsPresent := reg.OpenKey(GetDefaultRegKey, False)
      else IsPresent := reg.OpenKey(Path, False);
    if not IsPresent then Exit;

    if not reg.ValueExists(PropStorage.Section) then Exit;

    ss := TMemoryStream.Create;

    if reg.GetDataType(PropStorage.Section) = rdBinary then
    begin
//      SetString(Buffer, nil, reg.GetDataSize(PropStorage.Section));
      { TODO : Check it }
      SetLength(Buffer, reg.GetDataSize(PropStorage.Section));
{$IFDEF CIL}
      reg.ReadBinaryData(PropStorage.Section, Buffer, Length(Buffer));
{$ELSE}
      reg.ReadBinaryData(PropStorage.Section, PChar(Buffer)^, Length(Buffer));
{$ENDIF}
      StreamWriteBytes(ss, Buffer);
    end else
      StreamWriteBytes(ss, BytesOf(reg.ReadString(PropStorage.Section)));

    ss.Position := 0;

    ReadPropertiesStream(ss, PropStorage);

  finally
    ss.Free;
    reg.Free;
  end;
end;

procedure TRegPropStorageManEh.SerRegistryKey(const Value: TRegistryKeyEh);
const RegistryKeyToHKeyArr: array [TRegistryKeyEh] of HKEY =
  (HKEY_CLASSES_ROOT, HKEY_CURRENT_USER, HKEY_LOCAL_MACHINE, HKEY_USERS,
   HKEY_PERFORMANCE_DATA, HKEY_CURRENT_CONFIG, HKEY_DYN_DATA, 0);
begin
  if FRegistryKey <> Value then
  begin
    FRegistryKey := Value;
    if FRegistryKey <> rkCustomRegistryKeyEh then
      FKey := RegistryKeyToHKeyArr[FRegistryKey];
  end;
end;

procedure TRegPropStorageManEh.SetKey(const Value: HKEY);
begin
  if FKey <> Value then
  begin
    FKey := Value;
    case FKey of
      HKEY_CLASSES_ROOT: FRegistryKey := rkClassesRootEh;
      HKEY_CURRENT_USER: FRegistryKey := rkCurrentUserEh;
      HKEY_LOCAL_MACHINE: FRegistryKey := rkLocalMachineEh;
      HKEY_USERS: FRegistryKey := rkUsersEh;
      HKEY_PERFORMANCE_DATA: FRegistryKey := rkPerformanceDataEh;
      HKEY_CURRENT_CONFIG: FRegistryKey := rkCurrentConfigEh;
      HKEY_DYN_DATA: FRegistryKey := rkDynDataEh;
    else
      FRegistryKey := rkCustomRegistryKeyEh;
    end;
  end;
end;

procedure TRegPropStorageManEh.WritePropertiesStream(PropStorage: TPropStorageEh; Stream: TStream);
var
  reg: TRegistry;
  Buffer: TBytes;
  Text, Line: String;
  i, Pos: Integer;
begin
  reg := nil;
  Buffer := nil;
  try
    reg := TRegistry.Create;
    reg.RootKey := Key;

    if Path = ''
      then reg.OpenKey(GetDefaultRegKey + '\' + PropStorage.Section, True)
      else reg.OpenKey(Path + '\' + PropStorage.Section, True);
//    GetMem(Buffer, Stream.Size);

//    SetString(Text, nil, Stream.Size*2);
//    Stream.ReadBuffer(Buffer^, Stream.Size);
//    BinToHex(Buffer, PChar(Text), Stream.Size);
    StreamReadBytes(Stream, Buffer, Stream.Size);
    BinToHexEh(Buffer, Text, Stream.Size);

    i := 0;
    Pos := 1;
    while Pos <= Length(Text) do
    begin
      Line := Copy(Text, Pos, 80);
      reg.WriteString('Line' + FormatFloat('0000000000', i), Line );
      Inc(Pos, 80);
      Inc(i);
    end;


    while reg.ValueExists('Line' + FormatFloat('0000000000', i)) do
    begin
      reg.DeleteValue('Line' + FormatFloat('0000000000', i));
      Inc(i);
    end;

//    SetString(Buffer, nil, Stream.Size - Stream.Position);
//    Stream.ReadBuffer(PChar(Buffer)^, Stream.Size - Stream.Position);
//    reg.WriteBinaryData(PropStorage.Section, PChar(Buffer)^, Length(Buffer));

  finally
//    FreeMem(Buffer);
    reg.Free;
  end;

end;

procedure TRegPropStorageManEh.WritePropertiesText(PropStorage: TPropStorageEh; Text: String);
var
  reg: TRegistry;
  sl: TStrings;
  i: Integer;
begin
  reg := nil;
  sl := nil;
  try
    sl := TStringList.Create;
    sl.Text := Text;

    reg := TRegistry.Create;
    reg.RootKey := Key;

    if Path = ''
      then reg.OpenKey(GetDefaultRegKey + '\' + PropStorage.Section, True)
      else reg.OpenKey(Path + '\' + PropStorage.Section, True);


    for i := 0 to sl.Count - 1 do
      reg.WriteString('Line' + FormatFloat('0000000000', i), sl[i] );

    i := sl.Count;
    while reg.ValueExists('Line' + FormatFloat('0000000000', i)) do
    begin
      reg.DeleteValue('Line' + FormatFloat('0000000000', i));
      Inc(i);
    end;

//    reg.WriteString(PropStorage.Section, Text);

  finally
    sl.Free;
    reg.Free;
  end;
end;

{$ENDIF}

{ TPropStorageEh }

constructor TPropStorageEh.Create(AOwner: TComponent);

{$ifdef eval}
  {$INCLUDE eval}
{$else}
begin
{$endif}

  inherited Create(AOwner);
  FSection := '';
  FActive := True;
  FStoredProps := TPropertyNamesEh.Create;
  FStoredProps.Root := AOwner;
end;

destructor TPropStorageEh.Destroy;
begin
  if not (csDesigning in ComponentState) then
    RestoreEvents;
  FreeAndNil(FStoredProps);
  inherited Destroy;
end;

procedure TPropStorageEh.Loaded;
var
  Loading: Boolean;
begin
  Loading := csLoading in ComponentState;
  inherited Loaded;
  if not (csDesigning in ComponentState) then
  begin
    if Loading then SetEvents;
  end;
end;

function TPropStorageEh.GetForm: TForm;
begin
  if Owner is TCustomForm
    then Result := TForm(Owner as TCustomForm)
    else Result := nil;
end;

procedure TPropStorageEh.SetEvents;
begin
  if Owner is TCustomForm then
  begin
    with TForm(Form) do
    begin
      FSaveFormShow := OnShow;
      OnShow := FormShow;
      FSaveFormCloseQuery := OnCloseQuery;
      OnCloseQuery := FormCloseQuery;
      FSaveFormDestroy := OnDestroy;
      OnDestroy := FormDestroy;
    end;
  end;
end;

procedure TPropStorageEh.RestoreEvents;
begin
  if (Owner <> nil) and (Owner is TCustomForm) then
    with TForm(Form) do
    begin
      OnShow := FSaveFormShow;
      OnCloseQuery := FSaveFormCloseQuery;
      OnDestroy := FSaveFormDestroy;
    end;
end;

procedure TPropStorageEh.FormShow(Sender: TObject);
begin
  if Active then
    try
      LoadProperties;
    except
      if IsRaiseReadErrorEh then
        Application.HandleException(Self);
    end;
  if Assigned(FSaveFormShow) then
    FSaveFormShow(Sender);
end;

procedure TPropStorageEh.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if Assigned(FSaveFormCloseQuery) then
    FSaveFormCloseQuery(Sender, CanClose);
  if CanClose and Active and (Owner is TCustomForm) and Form.HandleAllocated then
    try
      SaveProperties;
    except
      Application.HandleException(Self);
    end;
end;

procedure TPropStorageEh.FormDestroy(Sender: TObject);
begin
  if Active and not FSaved then
  begin
    FDestroying := True;
    try
      SaveProperties;
    except
      Application.HandleException(Self);
    end;
    FDestroying := False;
  end;
  if Assigned(FSaveFormDestroy) then
    FSaveFormDestroy(Sender);
end;

function TPropStorageEh.GetSection: String;
begin
  Result := FSection;
  if (Result = '') and not (csDesigning in ComponentState) then
    Result := GetDefaultSection(Owner);
end;

procedure TPropStorageEh.SetSection(const Value: String);
begin
  FSection := Value;
end;

procedure TPropStorageEh.Save;
begin
  if Assigned(FOnSavePlacement) then FOnSavePlacement(Self);
end;

procedure TPropStorageEh.SetStorageManager(const Value: TPropStorageManagerEh);
begin
  if FStorageManager <> Value then
  begin
    FStorageManager := Value;
    if Value <> nil then Value.FreeNotification(Self);
  end;
end;

procedure TPropStorageEh.SetStoredProps(const Value: TPropertyNamesEh);
begin
  FStoredProps.Assign(Value);
end;

procedure TPropStorageEh.WritePropValues(Stream: TStream);
var
  pw: TPropWriterEh;
begin
  pw := TPropWriterEh.Create(Stream, 1024);
  pw.OnWriteOwnerProps := WriteCustomProps;
  try
    pw.WriteOwnerProperties(Owner, StoredProps);
  finally
    pw.Free;
  end;
end;

procedure TPropStorageEh.ReadPropValues(Stream: TStream);
var
  pr: TPropReaderEh;
begin
  pr := TPropReaderEh.Create(Stream, 1024);
  pr.OnReadOwnerProp := ReadProp;
  try
    pr.ReadOwnerProperties(Owner);
  finally
    pr.Free;
  end;
end;

procedure TPropStorageEh.LoadProperties;
begin
  if Assigned(BeforeLoadProps) then
    BeforeLoadProps(Self);
  FSaved := False;
  if StorageManager <> nil then
    StorageManager.ReadProperties(Self)
  else if DefaultPropStorageManager <> nil then
    DefaultPropStorageManager.ReadProperties(Self);
  if Assigned(AfterLoadProps) then
    AfterLoadProps(Self);
end;

procedure TPropStorageEh.SaveProperties;
begin
  if Assigned(BeforeSaveProps) then
    BeforeSaveProps(Self);
  if StorageManager <> nil then
  begin
    StorageManager.WriteProperties(Self);
    FSaved := True;
  end else if DefaultPropStorageManager <> nil then
  begin
    DefaultPropStorageManager.WriteProperties(Self);
    FSaved := True;
  end;
  if Assigned(AfterSaveProps) then
    AfterSaveProps(Self);
end;

procedure TPropStorageEh.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FStorageManager) then
    StorageManager := nil;
end;

procedure TPropStorageEh.WriteCustomProps(Writer: TPropWriterEh);
begin
  if Assigned(OnWriteCustomProps) then
    OnWriteCustomProps(Self, Writer);
end;

procedure TPropStorageEh.ReadProp(Reader: TPropReaderEh; PropName: String;
  var Processed: Boolean);
begin
  if Assigned(OnReadProp) then
    OnReadProp(Self, Reader, PropName, Processed);
end;

{ TPropertyNamesEh }

function TPropertyNamesEh.CheckPropertyPath(Path: String): Boolean;
var
  Token: String;
  CurObject: TComponent;
begin
  CurObject := Root;
  Result := False;
  Token := GetNextPointSeparatedToken(Path);
  while True do
  begin
    if Token = '' then
      raise Exception.Create('Invalide property path: "' + Path + '"');
    if UpperCase(Token) = '<P>' then
    begin
      Result := CheckObjectPropertyPath(CurObject, Copy(Path, Length('<P>') + 2, Length(Path)));
      Exit;
    end;
    if (CurObject is TComponent)
      then CurObject := FindChildComponent(CurObject, Root, Token, True)
      else CurObject := nil;
    if CurObject = nil then Exit;
{$IFDEF CIL}
    Borland.Delphi.System.Delete(Path, 1, Length(Token) + 1);
{$ELSE}
    System.Delete(Path, 1, Length(Token) + 1);
{$ENDIF}
    Token := GetNextPointSeparatedToken(Path);
  end;
end;

function TPropertyNamesEh.CheckObjectPropertyPath(Instance: TObject; PropPath: String): Boolean;
var
  PropInfo: PPropInfo;
  PropName: String;
  dpl: TStringList;
//  ci: TCollectionItem;
  c: TCollection;
  i: Integer;
  ciList: TList;
  InterceptorClass: TReadPropertyInterceptorClass;

  function IsSpecCollectionPropName(PropName: String): Boolean;
  begin
    Result := (Instance is TCollection) and
              ( (UpperCase(PropName) = UpperCase('<ForAllItems>'))
                or
                (UpperCase(Copy(PropName, 1, 5)) = UpperCase('<Item') )
              );
  end;

begin
  ciList := TList.Create;
  try
    Result := False;
    while True do
    begin
      PropName := GetNextPointSeparatedToken(PropPath);
{$IFDEF CIL}
      Borland.Delphi.System.Delete(PropPath, 1, Length(PropName) + 1);
{$ELSE}
      System.Delete(PropPath, 1, Length(PropName) + 1);
{$ENDIF}

      if IsSpecCollectionPropName(PropName) then
      begin
        c := TCollection(Instance);
        if NlsUpperCase(PropName) = UpperCase('<ForAllItems>') then
        begin
          Result := True;
          Exit;
//        Some TCollectionItem does not allows to create with Collection = nil and get AV.
//        So does not check path after <ForAllItems>
//          ci := c.ItemClass.Create(nil);
//          Instance := ci;
//          ciList.Add(ci);
        end else if (Copy(PropName, 1, 5) = '<Item') then
        begin
          i := StrToInt(Copy(Copy(PropName, 1, Length(PropName)-1), 6, 100));
          if i < c.Count then
            Instance := c.Items[i];
        end;
        if PropPath = '' then
        begin
          Result := True;
          Exit;
        end;
        Continue;
      end;

      InterceptorClass := GetInterceptorForTarget(Instance.ClassType);
      if InterceptorClass <> nil then
      begin
        PropInfo := GetPropInfo(InterceptorClass.ClassInfo, PropName);
        if PropInfo = nil then
          PropInfo := GetPropInfo(Instance.ClassInfo, PropName);
      end else
        PropInfo := GetPropInfo(Instance.ClassInfo, PropName);
      if PropInfo = nil then
        if Instance is TPersistent then
        begin
          dpl := TStringList.Create;
          try
{$IFDEF EH_LIB_6}
            dpl.CaseSensitive := False;
{$ENDIF}
            GetDefinePropertyList(TPersistent(Instance), dpl);
            if dpl.IndexOf(PropName) = -1 then
              Exit;
          finally
            dpl.Free;
          end;
        end;
      if PropPath = '' then
      begin
        Result := True;
        Exit;
      end;
{$IFDEF CIL}
      if PropInfo.PropType.Kind = tkClass then
      begin
        Instance := GetObjectProp(Instance, PropInfo);
        if Instance = nil then
          Exit;
      end;
{$ELSE}
      if PropInfo^.PropType^.Kind = tkClass then
      begin
        Instance := TObject(GetOrdProp(Instance, PropInfo));
        if Instance = nil then
          Exit;
      end;
{$ENDIF}
    end;
  finally
    for i := 0 to ciList.Count - 1 do
      TCollectionItem(ciList[i]).Free;
    ciList.Free;
  end;
end;

procedure TPropertyNamesEh.CheckPropertyNames;
var
  i: Integer;
begin
  for i := Count - 1 downto 0 do
    if not CheckPropertyPath(Strings[i]) then
      Delete(i);
end;

function TPropertyNamesEh.CompareStrings(const S1, S2: string): Integer;
  function CompareStr(S1, S2: string): Integer;
  var
    Token1, Token2: String;
  begin
    Result := 0;
    if (S1 = '') and (S2 = '') then Exit;
    Token1 := GetNextPointSeparatedToken(S1);
    Token2 := GetNextPointSeparatedToken(S2);
 { TODO : Compare collection ____Item[i]: i as number }
    if (UpperCase(Token1) = '<P>') and (UpperCase(Token2) <> '<P>') then
      Result := -1
    else if (UpperCase(Token1) <> '<P>') and (UpperCase(Token2) = '<P>') then
      Result := 1
    else if (Copy(Token1, 1, 1) = '<') and
       (Copy(Token2, 1, 1) <> '<')
    then
      Result := 1
    else if (Copy(Token2, 1, 1) = '<') and
            (Copy(Token1, 1, 1) <> '<')
    then
      Result := -1
    else
    begin
      Result := NlsCompareText(Token1, Token2);
      if Result = 0 then
      begin
{$IFDEF CIL}
        Borland.Delphi.System.Delete(S1, 1, Length(Token1)+1);
        Borland.Delphi.System.Delete(S2, 1, Length(Token1)+1);
{$ELSE}
        System.Delete(S1, 1, Length(Token1)+1);
        System.Delete(S2, 1, Length(Token1)+1);
{$ENDIF}
        Result := CompareStr(S1, S2);
      end;
    end;
  end;
begin
  Result := CompareStr(S1, S2);
end;

procedure TPropertyNamesEh.SetRoot(const Value: TComponent);
begin
  FRoot := Value;
  CheckPropertyNames;
end;

function TPropertyNamesEh.Add(const S: string): Integer;
var
  i: Integer;
begin
  Result := -1;
  if (Root <> nil) and not (csLoading in Root.ComponentState) and not CheckPropertyPath(S)
  then
    Exit;
  for i := 0 to Count - 1 do
    if CompareStrings(Strings[i], S) = 0 then
      Exit
    else if CompareStrings(Strings[i], S) > 0 then
    begin
      Insert(i, S);
      Result := i;
      Exit;
    end;
  inherited Add(S);
end;

initialization
  RegisterIntegerConsts(TypeInfo(HKEY), IdentToRegistryKey, RegistryKeyToIdent);
finalization
  FreeAndNil(FDefaultStorageManager);
end.
