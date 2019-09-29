{*******************************************************}
{                                                       }
{                      EhLib v5.0                       }
{          TPropWriter, TPropReader objects             }
{    Delphi / Kylix Cross-Platform Runtime Library      }
{                    (Build 5.0.00)                     }
{                                                       }
{   Copyright (c) 2002-2009 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}
//{$I EhLibClx.Inc}

{$IFDEF EH_LIB_CLX}
unit QPropFilerEh;
{$ELSE}
unit PropFilerEh {$IFDEF CIL} platform {$ENDIF};
{$ENDIF}

interface

uses
{$IFDEF EH_LIB_CLX}
  Types, QForms, QGraphics, QControls,
{$ELSE}
  Windows, Forms, Controls,
  {$IFDEF EH_LIB_6} Variants, Types, {$ENDIF}
{$IFDEF CIL}
  EhLibVCLNET,
  System.Runtime.InteropServices, System.Reflection,
{$ELSE}
  EhLibVCL,
{$ENDIF}
{$ENDIF} //$ELSE EH_LIB_CLX
  SysUtils, Classes, TypInfo;

type
  TPropWriterEh = class;
  TPropReaderEh = class;

  TWriteOwnerPropsEventEh = procedure(Writer: TPropWriterEh) of object;
  TReadOwnerPropEventEh = procedure(Reader: TPropReaderEh; PropName: String;
    var Processed: Boolean) of object;

 {TPropWriterEh}

  TPropWriterEh = class(TWriter)
  private
    FCurRootsList: TList;
    FDefnBinPropList: TStringList;
    FDefnPropList: TStringList;
    FInterceptorList: TList;
    FLastRootsList: TList;
//    FLookupRoot: TComponent;
    FPropPath: String;
    FOnWriteOwnerProps: TWriteOwnerPropsEventEh;
    procedure BuildPropsList(AObject: TObject; sl: TStrings);
  protected
    procedure WriteAllProperties(Instance: TObject);
  public
    constructor Create(Stream: TStream; BufSize: Integer);
    destructor Destroy; override;
    procedure WritePropName(const PropName: string);
    procedure DefineBinaryProperty(const Name: string; ReadData, WriteData: TStreamProc; HasData: Boolean); override;
    procedure DefineObjectProperties(Instance: TObject);
    procedure DefineProperty(const Name: string; ReadData: TReaderProc; WriteData: TWriterProc; HasData: Boolean); override;
    procedure SaveObjectProperyValue(Instance: TObject; Path, FullPath: String);
    procedure WriteCollection(Value: TCollection);
    procedure WriteOwnerProperties(Owner: TComponent; PropList: TStrings);
    property OnWriteOwnerProps: TWriteOwnerPropsEventEh read FOnWriteOwnerProps write FOnWriteOwnerProps;
  end;

 {TPropReaderEh}

  TPropReaderEh = class(TReader)
  private
    FCanHandleExcepts: Boolean;
    FCollectionList: TList;
    FInterceptorList: TList;
    FPropName: String;
    FOnReadOwnerProp: TReadOwnerPropEventEh;
    function ReadSet(SetType: PTypeInfo): Integer;
    procedure SkipSetBody;
{$IFNDEF EH_LIB_5}
    procedure SkipValue;
    procedure SkipProperty;
    procedure PropertyError;
{$ENDIF}
  protected
    function Error(const Message: string): Boolean; override;
    procedure ReadCollection(Collection: TCollection);
    procedure ReadProperty(AInstance: TPersistent);
    procedure ReadPropValue(Instance: TPersistent; PropInfo: PPropInfo);
  public
    constructor Create(Stream: TStream; BufSize: Integer);
    destructor Destroy; override;
    procedure DefineBinaryProperty(const Name: string; ReadData,
      WriteData: TStreamProc; HasData: Boolean); override;
    procedure DefineProperty(const Name: string; ReadData: TReaderProc;
      WriteData: TWriterProc; HasData: Boolean); override;
    procedure ReadComponent(Component: TComponent);
    procedure ReadOwnerProperties(Component: TComponent);
    property OnReadOwnerProp: TReadOwnerPropEventEh read FOnReadOwnerProp write FOnReadOwnerProp;
  end;

{ TStoragePropertyInterceptor }

  TStoragePropertyInterceptor = class(TPersistent)
    FTarget: TObject;
  public
    constructor Create(ATarget: TObject); virtual;
    function NeedIntercept: Boolean; virtual;
    procedure Readed; virtual;
    property Target: TObject read FTarget;
  end;

{ TFormStoragePropertyInterceptor }

  TFormStoragePropertyInterceptor = class(TStoragePropertyInterceptor)
  private
    FActiveControl: TWinControl;
    FHeight: Integer;
    FLeft: Integer;
    FPixelsPerInch: Integer;
    FPosPresent: Boolean;
    FTop: Integer;
    FWidth: Integer;
    FWindowState: TWindowState;
    function GetHeight: Integer;
    function GetLeft: Integer;
    function GetTop: Integer;
    function GetWidth: Integer;
    procedure SetLeft(const Value: Integer);
    procedure SetTop(const Value: Integer);
  public
    constructor Create(ATarget: TObject); override;
    procedure Readed; override;
    function GetNotmalFormPlacement: TRect;
  published
    property ActiveControl: TWinControl write FActiveControl;
    property Height: Integer read GetHeight write FHeight;
    property Left: Integer read GetLeft write SetLeft;
    property PixelsPerInch: Integer write FPixelsPerInch;
    property Top: Integer read GetTop write SetTop;
    property Width: Integer read GetWidth write FWidth;
    property WindowState: TWindowState write FWindowState;
  end;

  TReadPropertyInterceptorClass = class of TStoragePropertyInterceptor;

  procedure RegisterReadPropertyInterceptor(Target: TClass; Interceptor: TReadPropertyInterceptorClass);
  procedure UnregisterReadPropertyInterceptor(Target: TClass; Interceptor: TReadPropertyInterceptorClass);
  function GetInterceptorForTarget(Target: TClass): TReadPropertyInterceptorClass;

  function GetNextPointSeparatedToken(Path: String): String;

  procedure GetComponentChildListEh(ParentComp, Root: TComponent; cl: TStrings; CheckInline: Boolean);
  function FindChildComponent(ParentComp, Root: TComponent; const AName: string; CheckInline: Boolean): TComponent;

var
  IsRaiseReadErrorEh: Boolean = False;

implementation

uses {$IFDEF EH_LIB_6} ConvUtils, RTLConsts {$ELSE} Consts {$ENDIF};

{$IFDEF CIL}

function CanRead(APropInfo: TPropInfo): Boolean;
begin
  Result := Borland.Vcl.TypInfo.CanRead(APropInfo);
end;

function CanWrite(APropInfo: TPropInfo): Boolean;
begin
  Result := Borland.Vcl.TypInfo.CanWrite(APropInfo);
end;

{$ELSE}

function CanRead(APropInfo: PPropInfo): Boolean;
begin
  Result := APropInfo^.GetProc <> nil;
end;

function CanWrite(APropInfo: PPropInfo): Boolean;
begin
  Result := APropInfo^.SetProc <> nil;
end;

{$ENDIF}

type

  TForChildListObj = class(TObject)
  private
    FChildList: TStringList;
    procedure GetChildList(ParentComp, Root: TComponent; cl: TStrings);
    procedure GetChildProc(Child: TComponent);
  public
    constructor Create;
    destructor Destroy; override;
  end;

constructor TForChildListObj.Create;
begin
  inherited Create;
  FChildList := TStringList.Create;
end;

destructor TForChildListObj.Destroy;
begin
  FreeAndNil(FChildList);
end;

procedure TForChildListObj.GetChildList(ParentComp, Root: TComponent; cl: TStrings);
var
  FilerAccess: TFilerAccess;
begin
  FChildList.Clear;
  FilerAccess := TFilerAccess.Create(ParentComp);
  FilerAccess.GetChildren(GetChildProc, Root);
  FilerAccess.Free;
  cl.Assign(FChildList);
end;

procedure TForChildListObj.GetChildProc(Child: TComponent);
begin
  FChildList.AddObject(Child.Name, Child);
end;

var
  ForChildListObj: TForChildListObj;

procedure GetComponentChildListEh(ParentComp, Root: TComponent; cl: TStrings; CheckInline: Boolean);
begin
  if ForChildListObj = nil then
    ForChildListObj := TForChildListObj.Create;

{$IFDEF EH_LIB_5}
  if CheckInline and (csInline in ParentComp.ComponentState) then
    ForChildListObj.GetChildList(ParentComp, ParentComp, cl)
  else
{$ENDIF}
  if CheckInline and (ParentComp <> Root) then
    ForChildListObj.GetChildList(ParentComp, ParentComp.Owner, cl)
  else
    ForChildListObj.GetChildList(ParentComp, Root, cl);
end;

function FindChildComponent(ParentComp, Root: TComponent; const AName: string; CheckInline: Boolean): TComponent;
var
  ChildList: TStringList;
  Idx: Integer;
begin
  ChildList := TStringList.Create;
  try
    GetComponentChildListEh(ParentComp, Root, ChildList, CheckInline);

    Idx := ChildList.IndexOf(AName);
    if Idx > -1
      then Result := TComponent(ChildList.Objects[Idx])
      else Result := nil;

  finally
    ChildList.Free;
  end;
end;

function GetNextPointSeparatedToken(Path: String): String;
var
  PPos: Integer;
begin
  PPos := Pos('.', Path);
  if PPos > 0
    then Result := Copy(Path, 1, PPos-1)
    else Result := Path;
end;

type
//  PMethod = ^TMethod;
  TIntegerSet = set of 0..SizeOf(Integer) * 8 - 1;

  TMethodObj = class(TObject)
  private
    FMethod: TMethod;
  public
    property Method: TMethod read FMethod write FMethod;
  end;

  TStreamProcObj = class(TObject)
  private
    FMethod: TStreamProc;
  public
    property Method: TStreamProc read FMethod write FMethod;
  end;


var
  InterceptorList: TList;
  TargetList: TList;

procedure RegisterReadPropertyInterceptor(Target: TClass; Interceptor: TReadPropertyInterceptorClass);
var
  i: Integer;
begin
  if InterceptorList = nil then
  begin
    InterceptorList := TList.Create;
    TargetList := TList.Create;
  end;
  for i:= TargetList.Count - 1 downto 0 do
    if (TargetList[i] = TObject(Target)) then
      UnregisterReadPropertyInterceptor(Target, TReadPropertyInterceptorClass(InterceptorList[i]));
  InterceptorList.Add(TObject(Interceptor));
  TargetList.Add(TObject(Target));
end;

procedure UnregisterReadPropertyInterceptor(Target: TClass; Interceptor: TReadPropertyInterceptorClass);
var
  i: Integer;
begin
  for i:= TargetList.Count - 1 downto 0 do
    if (TargetList[i] = TObject(Target)) and (InterceptorList[i] = TObject(Interceptor)) then
    begin
      InterceptorList.Delete(i);
      TargetList.Delete(i);
    end;
end;

function GetInterceptorForTarget(Target: TClass): TReadPropertyInterceptorClass;

  function GetClassDeep(Target: TClass; ClassName: String): Integer;
  var
    ParentTarget: TClass;
  begin
    Result := 0;
    ParentTarget := Target;
    while True do
    begin
      if UpperCase(ParentTarget.ClassName) = UpperCase(ClassName) then
        Exit;
      Inc(Result);
      ParentTarget := ParentTarget.ClassParent;
      if ParentTarget = nil then
      begin
        Result := MAXINT;
        Exit;
      end;
    end;
  end;

var
  Deep, MeenDeep, i: Integer;
begin
  Result := nil;
  if TargetList = nil then Exit;
  MeenDeep := MAXINT;
  for i := 0 to TargetList.Count - 1 do
  begin
    if Target.InheritsFrom(TClass(TargetList[i])) then
    begin
      Deep := GetClassDeep(Target, TClass(TargetList[i]).ClassName);
      if Deep < MeenDeep then
      begin
        MeenDeep := Deep;
        Result := TReadPropertyInterceptorClass(InterceptorList[i]);
      end;
    end;
  end;
end;

function SameText(const S1, S2: string): Boolean;
begin
  Result := (CompareText(S1, S2) = 0)
end;


{$IFNDEF EH_LIB_5}

function FindNestedComponent(Root: TComponent; const NamePath: string): TComponent;
var
  Current, Found: TComponent;
  S, P: PChar;
  Name: string;
begin
  Result := nil;
  if NamePath = '' then Exit;
  Current := Root;
  P := PChar(Pointer(NamePath));
  while P^ <> #0 do
  begin
    S := P;
    while not (P^ in ['.', '-', #0]) do Inc(P);
    SetString(Name, S, P - S);
    Found := Current.FindComponent(Name);
    if (Found = nil) and SameText(Name, 'Owner') then  { Do not translate }
      Found := Current;
    if Found = nil then Exit;
    if P^ = '.' then Inc(P);
    if P^ = '-' then Inc(P);
    if P^ = '>' then Inc(P);
    Current := Found;
  end;
  Result := Current;
end;

{$ENDIF}

{ TPropWriterEh }

constructor TPropWriterEh.Create(Stream: TStream; BufSize: Integer);
begin
  inherited Create(Stream, BufSize);
  FDefnPropList := TStringList.Create;
  FDefnBinPropList := TStringList.Create;
  FLastRootsList := TList.Create;
  FCurRootsList := TList.Create;
end;

destructor TPropWriterEh.Destroy;
var
 i: Integer;
begin
  for i := 0 to FDefnPropList.Count-1 do
    FDefnPropList.Objects[i].Free;
  FreeAndNil(FDefnPropList);
  for i := 0 to FDefnBinPropList.Count-1 do
    FDefnBinPropList.Objects[i].Free;
  FreeAndNil(FDefnBinPropList);
  FreeAndNil(FLastRootsList);
  FreeAndNil(FCurRootsList);
  inherited Destroy;
end;

procedure TPropWriterEh.BuildPropsList(AObject: TObject; sl: TStrings);
var
//  PropList: PPropList;
  PropList: TPropListArray;
//  {PropCount,} FSize: Integer;
  i, j: Integer;
  SubO: TObject;
  subsl: TStrings;
begin
  subsl := TStringList.Create;
{  PropCount := GetPropList(AObject.ClassInfo, tkProperties, nil);
  FSize := PropCount * SizeOf(Pointer);
  GetMem(PropList, FSize);
  GetPropList(AObject.ClassInfo, tkProperties, PropList);}
  PropList := GetPropListAsArray(AObject.ClassInfo, tkProperties);
  for i := 0 to Length(PropList) - 1 do
  begin
    if PropType_getKind(PropInfo_getPropType(PropList[i])) = tkClass then
    begin
      SubO := GetObjectProp(AObject, PropList[i]);
      if Assigned(SubO) then
      begin
        subsl.Clear;
        if not (SubO is TComponent) then
        begin
          BuildPropsList(SubO, subsl);
          for j := 0 to subsl.Count - 1 do
            sl.Add(String(PropList[i].Name) + '.' + subsl[j]);
        end;
        if (SubO is TCollection) then
          sl.Add(String(PropList[i].Name));
      end;
    end else
      sl.Add(String(PropList[i].Name));
  end;
//  FreeMem(PropList, FSize);
  subsl.Clear;

  DefineObjectProperties(AObject);
  sl.AddStrings(FDefnPropList);
  sl.AddStrings(FDefnBinPropList);

  subsl.Free;
end;

procedure TPropWriterEh.WriteOwnerProperties(Owner: TComponent; PropList: TStrings);
var
  i, j, Level: Integer;
  Path: String;
  PPos: Integer;
  CompName: String;
  NewComponent, CurOwner: TComponent;
begin
  Root := Owner;
//  FLookupRoot := Root;
  WriteSignature;
{$IFDEF EH_LIB_12}
  WriteUTF8Str(Owner.ClassName);
  WriteUTF8Str(Owner.Name);
{$ELSE}
  WriteStr(Owner.ClassName);
  WriteStr(Owner.Name);
{$ENDIF}

  FInterceptorList := TList.Create;

  //Write Owner properties
  for i := 0 to PropList.Count-1 do
  begin
    Path := PropList[i];
    PPos := Pos('.', Path);
    if PPos > 0
      then CompName := Copy(Path, 1, PPos-1)
      else raise Exception.Create('Component name is empty.');
    Delete(Path, 1, PPos);
    if CompName = '<P>' then
      SaveObjectProperyValue(Owner, Path, PropList[i]);

    FLastRootsList.Clear;
    FLastRootsList.Capacity := FCurRootsList.Capacity;
    for j := 0 to FCurRootsList.Count - 1 do
      FLastRootsList.Add(FCurRootsList[j]);

//    FLastRootsList.Assign(FCurRootsList);
    FCurRootsList.Clear;

  end;

  if Assigned(OnWriteOwnerProps) then
    OnWriteOwnerProps(Self);

  WriteListEnd;

  //Write Owned components
  for i := 0 to PropList.Count-1 do
  begin
    Path := PropList[i];
    CompName := GetNextPointSeparatedToken(Path);
    Delete(Path, 1, Length(CompName)+1);

    if CompName = '<P>'
      then Continue
      ;//else NewComponent := Owner.FindComponent(CompName);

    CurOwner := Owner;
    Level := 1;

    while CompName <> '<P>' do
    begin
      if CompName = '' then
        raise Exception.Create('Component name is empty.');

      NewComponent := FindChildComponent(CurOwner, Root, CompName, True);
      if NewComponent = nil then Break;
//      NewComponent := CurOwner.FindComponent(CompName);
      CurOwner := NewComponent;

      if FCurRootsList.Count < Level then
      begin
        if FCurRootsList.Count > 0 then
          WriteListEnd; // End of properties
{$IFDEF EH_LIB_12}
        WriteUTF8Str(NewComponent.ClassName);
        WriteUTF8Str(NewComponent.Name);
{$ELSE}
        WriteStr(NewComponent.ClassName);
        WriteStr(NewComponent.Name);
{$ENDIF}
        FCurRootsList.Add(NewComponent);
      end else if FCurRootsList.Count > Level then
      begin
        if CompName <> TComponent(FCurRootsList[Level-1]).Name then
        begin
          WriteListEnd; // End of properties
          for j := FCurRootsList.Count - 1 downto Level - 1 do
          begin
            WriteListEnd; // End of object
            FCurRootsList.Delete(j);
          end;
//          FCurRootsList.Delete(FCurRootsList.Count-1);
{$IFDEF EH_LIB_12}
          WriteUTF8Str(NewComponent.ClassName);
          WriteUTF8Str(NewComponent.Name);
{$ELSE}
          WriteStr(NewComponent.ClassName);
          WriteStr(NewComponent.Name);
{$ENDIF}
          FCurRootsList.Add(NewComponent);
        end;
      end else
      begin  // FCurRootsList.Count = Level
        if CompName <> TComponent(FCurRootsList[Level-1]).Name then
        begin
          WriteListEnd; // End of properties
          for j := FCurRootsList.Count downto Level do
          begin
            WriteListEnd; // End of object
//            WriteListEnd;
            FCurRootsList.Delete(j-1);
          end;
{$IFDEF EH_LIB_12}
          WriteUTF8Str(NewComponent.ClassName);
          WriteUTF8Str(NewComponent.Name);
{$ELSE}
          WriteStr(NewComponent.ClassName);
          WriteStr(NewComponent.Name);
{$ENDIF}
          FCurRootsList.Add(NewComponent);
        end;
      end;

      CompName := GetNextPointSeparatedToken(Path);
      Delete(Path, 1, Length(CompName)+1);
      Inc(Level);
    end;

    SaveObjectProperyValue(TObject(FCurRootsList[FCurRootsList.Count-1]), Path, PropList[i]);
  end;

  WriteListEnd; // End of properties
  for j := FCurRootsList.Count - 1 downto 0 do
  begin
    WriteListEnd; // End of object
    FCurRootsList.Delete(j);
  end;
  WriteListEnd;

  FlushBuffer;

  for i := FInterceptorList.Count-1 downto 0 do
    with TStoragePropertyInterceptor(FInterceptorList[i]) do
      Free;
  FInterceptorList.Free;
end;

procedure TPropWriterEh.SaveObjectProperyValue(Instance: TObject; Path, FullPath: String);
var
  PropInfo: PPropInfo;
  PropType: PTypeInfo;
  PropName: String;

  procedure WriteCollectionItemAsProperty(Item: TCollectionItem; Path, FullPath: String);
  var
    OldAncestor: TPersistent;
    SavePropPath: string;
  begin
    OldAncestor := Ancestor;
    SavePropPath := FPropPath;
    try
      FPropPath := FPropPath + '__Item' + IntToStr(Item.Index) + '.';
      SaveObjectProperyValue(Item, Path, FullPath);
    finally
      Ancestor := OldAncestor;
      FPropPath := SavePropPath;
    end;
  end;

  procedure WritePropPath;
  begin
    WritePropName(PropInfo_getName(PropInfo));
  end;

  procedure WriteSet(Value: Longint);
  var
    I: Integer;
    BaseType: PTypeInfo;
  begin
{$IFDEF CIL}
    BaseType := GetTypeData(PropType).CompType;
{$ELSE}
    BaseType := GetTypeData(PropType)^.CompType^;
{$ENDIF}
    WriteValue(vaSet);
    for I := 0 to SizeOf(TIntegerSet) * 8 - 1 do
      if I in TIntegerSet(Value) then
{$IFDEF EH_LIB_12}
        WriteUTF8Str(GetEnumName(BaseType, I));
{$ELSE}
        WriteStr(GetEnumName(BaseType, I));
{$ENDIF}
    WriteStr('');
  end;

  procedure WriteIntProp(IntType: PTypeInfo; Value: Longint);
{$IFDEF EH_LIB_5}
  var
    Ident: string;
    IntToIdent: TIntToIdent;
{$ENDIF}
  begin
{$IFDEF EH_LIB_5}
    IntToIdent := FindIntToIdent(IntType);
    if Assigned(IntToIdent) and IntToIdent(Value, Ident) then
      WriteIdent(Ident)
    else
{$ENDIF}
      WriteInteger(Value);
  end;

  procedure WriteCollectionProp(Collection: TCollection);
  var
    SavePropPath: string;
  begin
    WritePropPath;
    SavePropPath := FPropPath;
    try
      FPropPath := '';
      WriteCollection(Collection);
    finally
      FPropPath := SavePropPath;
    end;
  end;

  procedure WriteOrdProp;
  var
    Value: Longint;
  begin
    Value := GetOrdProp(Instance, PropInfo);
    WritePropPath;
    case PropType_GetKind(PropType) of
      tkInteger:
        WriteIntProp(PropInfo_getPropType(PropInfo), Value);
      tkChar:
        WriteChar(Chr(Value));
      tkSet:
        WriteSet(Value);
      tkEnumeration:
        WriteIdent(GetEnumName(PropType, Value));
    end;
  end;

  procedure WriteFloatProp;
  var
    Value: Extended;
  begin
    Value := GetFloatProp(Instance, PropInfo);
    WritePropPath;
    WriteFloat(Value);
  end;

  procedure WriteInt64Prop;
  var
    Value: Int64;
  begin
    Value := GetInt64Prop(Instance, PropInfo);
    WritePropPath;
    WriteInteger(Value);
  end;

  procedure WriteStrProp;
  var
    Value: WideString;
  begin
{$IFDEF EH_LIB_6}
    Value := GetWideStrProp(Instance, PropInfo);
    WritePropPath;
    WriteWideString(Value);
{$ELSE}
    Value := GetStrProp(Instance, PropInfo);
    WritePropPath;
    WriteString(Value);
{$ENDIF}
  end;

  function OwnedBy(Component, Owner: TComponent): Boolean;
  begin
    Result := True;
    while Component <> nil do
      if Component = Owner then
        Exit
      else
        Component := Component.Owner;
    Result := False;
  end;

  function GetComponentValue(Component: TComponent): string;
  begin
    if Component.Owner = Root then //LookupRoot then
      Result := Component.Name
    else if Component = Root then //LookupRoot then
      Result := 'Owner'                                                       { Do not translate }
    else if (Component.Owner <> nil) and (Component.Owner.Name <> '') and
      (Component.Name <> '') then
      if OwnedBy(Component.Owner, Root) then//LookupRoot) then
        Result := GetComponentValue(Component.Owner) + '.' + Component.Name
      else
        Result := Component.Owner.Name + '.' + Component.Name
    else if Component.Name <> '' then
      Result := Component.Name + '.Owner'                                     { Do not translate }
    else Result := '';
  end;

  procedure WriteObjectProp;
  var
    Value: TObject;
    OldAncestor: TPersistent;
    SavePropPath, ComponentValue: string;
  begin
    Value := GetObjectProp(Instance, PropInfo);
    if Value = nil then
    begin
      WritePropPath;
      WriteValue(vaNil);
    end
    else if Value is TPersistent then
      if (Value is TComponent)
{$IFDEF EH_LIB_6} and not (csSubComponent in TComponent(Value).ComponentStyle) {$ENDIF} then
      begin
        ComponentValue := GetComponentValue(TComponent(Value));
        // ComponentValue will never be '' since we are to always
        // write out the value (in other words: it is not the default)
        // but it doesn't hurt to check
        if ComponentValue <> '' then
        begin
          WritePropPath;
          WriteIdent(ComponentValue);
        end;
      end else
      begin

        OldAncestor := Ancestor;
        SavePropPath := FPropPath;
        try
          FPropPath := FPropPath + PropInfo_getName(PropInfo) + '.';

          if Path <> '' then
            SaveObjectProperyValue(Value, Path, FullPath)
          else
          begin
            WriteAllProperties(Value);
          end;

        finally
          Ancestor := OldAncestor;
          FPropPath := SavePropPath;
        end;

        if (Value is TCollection) and (Path = '') then
          WriteCollectionProp(TCollection(Value));
      end;
  end;

{$IFDEF EH_LIB_6}

{$IFDEF CIL}
  procedure WriteInterfaceProp;
  begin
  end;
{$ELSE}
  procedure WriteInterfaceProp;
  var
    Intf: IInterface;
    Value: TComponent;
  var
    SR: IInterfaceComponentReference;
    RefStr: String;
  begin
    Intf := GetInterfaceProp(Instance, PropInfo);
    if Intf = nil then
    begin
      WritePropPath;
      WriteValue(vaNil);
    end
    else if Supports(Intf, IInterfaceComponentReference, SR) then
    begin
      Value := SR.GetComponent;
      RefStr := GetComponentValue(Value);
      Assert(RefStr <> '', 'Component reference name should always be non blank');
      WritePropPath;
      WriteIdent(RefStr);
    end;
    // The else case will not happen because we are to always write out the
    // property at this point, so it will be nil, or support the reference
  end;
{$ENDIF} // {CIL $ELSE}

{$ENDIF} // EH_LIB_6

  procedure WriteMethodProp;
  var
    Value: TMethod;
  begin
    Value := GetMethodProp(Instance, PropInfo);
    WritePropPath;
    if Value.Code = nil then
      WriteValue(vaNil)
    else
      WriteIdent(Root.MethodName(Value.Code));//LookupRoot.MethodName(Value.Code));
  end;

{$IFNDEF EH_LIB_6}

  procedure WriteVariant(const Value: Variant);
  var
    VType: Integer;
  begin
    if VarIsArray(Value) then raise EWriteError.Create(SWriteError);
    VType := VarType(Value);
    case VType and varTypeMask of
      varEmpty: WriteValue(vaNil);
      varNull: WriteValue(vaNull);
      varOleStr: WriteWideString(Value);
      varString: WriteString(Value);
      varByte, varSmallInt, varInteger: WriteInteger(Value);
      varSingle: WriteSingle(Value);
      varDouble: WriteFloat(Value);
      varCurrency: WriteCurrency(Value);
      varDate: WriteDate(Value);
      varBoolean:
        if Value then
          WriteValue(vaTrue) else
          WriteValue(vaFalse);
    else
      try
        WriteString(Value);
      except
        raise EWriteError.Create(SWriteError);
      end;
    end;
  end;

{$ENDIF}

  procedure WriteVariantProp;
  var
    Value: Variant;
  begin
    Value := GetVariantProp(Instance, PropInfo);
    WritePropPath;
    WriteVariant(Value);
  end;

  function CheckInterceptor(var Instance: TObject; const PropName: string): Boolean;
  var
    InterceptorClass: TReadPropertyInterceptorClass;
    Interceptor: TStoragePropertyInterceptor;
    i: Integer;
  begin
    Result := False;
    InterceptorClass := GetInterceptorForTarget(Instance.ClassType);
    if InterceptorClass = nil then Exit;
    Interceptor := nil;
    for i := 0 to FInterceptorList.Count - 1 do
    begin
      if Instance = TStoragePropertyInterceptor(FInterceptorList[i]).FTarget then
      begin
        Interceptor := TStoragePropertyInterceptor(FInterceptorList[i]);
        Break;
      end;
    end;
    if Interceptor = nil then
    begin
      Interceptor := InterceptorClass.Create(Instance);
      FInterceptorList.Add(Interceptor);
    end;
    PropInfo := GetPropInfo(Interceptor.ClassInfo, PropName);
    if (PropInfo = nil) or not CanRead(PropInfo) then Exit;
    Instance := Interceptor;
    Result := True;
  end;

var
  PPos, Index, i, j: Integer;
//  WriterProc: TWriterProc;
  Collection: TCollection;
  sl: TStringList;
  Suffix: String;
begin
  if Path = '' then
    raise Exception.Create('Property name is empty.');
  PPos := Pos('.', Path);
  if PPos > 0 then
  begin
    PropName := Copy(Path, 1, PPos-1);
    Delete(Path, 1, PPos);
  end else
  begin
    PropName := Path;
    Path := '';
  end;
  if (PropName = '<ForAllItems>') or (Copy(PropName, 1, 5) = '<Item') then
  begin
    if not (Instance is TCollection) then
      raise Exception.Create('Component type is not Collection.');
    Collection := TCollection(Instance);

    if PropName = '<ForAllItems>' then
    begin
      if (Path = '') and (Collection.Count > 0) then
      begin
        sl := TStringList.Create;
        BuildPropsList(Collection.Items[0], sl);
        for i := 0 to Collection.Count - 1 do
          for j := 0 to sl.Count - 1 do
          begin
            Suffix := sl[j];
            WriteCollectionItemAsProperty(Collection.Items[i], Suffix,
              Copy(FullPath, 1, Length(FullPath) - Length(Path) - Length('.<ForAllItems>')) + '<Item' + IntToStr(j) + '>.' + Suffix);
          end;
        sl.Free;
      end else
        for i := 0 to Collection.Count-1 do
          WriteCollectionItemAsProperty(Collection.Items[i], Path,
            Copy(FullPath, 1, Length(FullPath) - Length(Path) - Length('.<ForAllItems>')) + '<Item' + IntToStr(i) + '>.' + Path);
    end else
    begin
      i := StrToInt(Copy(Copy(PropName, 1, Length(PropName)-1), 6, 100));
      if Path = '' then
      begin
        sl := TStringList.Create;
        BuildPropsList(Collection.Items[i], sl);
        for j := 0 to sl.Count - 1 do
        begin
          Suffix := sl[j];
          WriteCollectionItemAsProperty(Collection.Items[i], Suffix, FullPath + '.' + Suffix);
        end;
        sl.Free;
      end else
        WriteCollectionItemAsProperty(Collection.Items[i], Path, FullPath);
    end

  end else
  begin

    if not CheckInterceptor(Instance, PropName) then
      PropInfo := GetPropInfo(Instance.ClassInfo, PropName);

    if PropInfo = nil then // Check in Define properies list
    begin
      DefineObjectProperties(Instance);
      if (FDefnPropList.IndexOf(PropName) >= 0) then
      begin
        Index := FDefnPropList.IndexOf(PropName);
        if Assigned(FDefnPropList.Objects[Index]) and
           (TMethodObj(FDefnPropList.Objects[Index]).Method.Code <> nil) then
        begin
          WritePropName(PropName);
{$IFDEF CIL}
          TMethodObj(FDefnPropList.Objects[Index]).Method.Invoke([Self]);
{$ELSE}
          TWriterProc((TMethodObj(FDefnPropList.Objects[Index]).Method))(Self);
{$ENDIF}
        end;
      end else if FDefnBinPropList.IndexOf(PropName) >= 0 then
      begin
        Index := FDefnBinPropList.IndexOf(PropName);
        if Assigned(FDefnBinPropList.Objects[Index]) then
        begin
          WritePropName(PropName);
//{$IFDEF CIL}
//{ DONE : Convert TMethod to delegate }
          WriteBinary(TStreamProcObj(FDefnBinPropList.Objects[Index]).Method);
//{$ELSE}
//          WriteBinary(TStreamProc((TMethodObj(FDefnBinPropList.Objects[Index]).Method)));
//{$ENDIF}
        end;
      end else
        raise Exception.Create('Invalide property name: ' + PropName);
    end else
    begin
      if  CanRead(PropInfo) and
{$IFDEF EH_LIB_6}
       ((CanWrite(PropInfo)) or
       ((PropType_getKind(PropInfo_getPropType(PropInfo)) = tkClass) and
        (GetObjectProp(Instance, PropInfo) is TComponent) and
        (csSubComponent in TComponent(GetObjectProp(Instance, PropInfo)).ComponentStyle))) then
{$ELSE}
        (PPropInfo(PropInfo)^.GetProc <> nil) then
{$ENDIF}
      begin
        PropType := PropInfo_getPropType(PropInfo);
        case PropType_getKind(PropType) of
          tkInteger, tkChar, tkEnumeration, tkSet:
            WriteOrdProp;
          tkFloat:
            WriteFloatProp;
          tkString, tkLString, tkWString:
            WriteStrProp;
          tkClass:
            WriteObjectProp;
          tkMethod:
            WriteMethodProp;
          tkVariant:
            WriteVariantProp;
          tkInt64:
            WriteInt64Prop;
{$IFDEF EH_LIB_6}
          tkInterface:
            WriteInterfaceProp;
{$ENDIF}
{$IFDEF EH_LIB_12}
          tkUString:
            WriteStrProp;
{$ENDIF}
        end;
      end;
    end
  end;
end;

procedure TPropWriterEh.WritePropName(const PropName: string);
begin
{$IFDEF EH_LIB_12}
  WriteUTF8Str(FPropPath + PropName);
{$ELSE}
  WriteStr(FPropPath + PropName);
{$ENDIF}
end;

procedure TPropWriterEh.DefineBinaryProperty(const Name: string; ReadData,
  WriteData: TStreamProc; HasData: Boolean);
var
  Pm: TStreamProcObj;
begin
  Pm := TStreamProcObj.Create;
{$IFDEF CIL}
  Pm.Method := @WriteData;
{$ELSE}
  Pm.Method := WriteData;
//  Pm.Method := TMethod(WriteData);
{$ENDIF}
  FDefnBinPropList.AddObject(Name, Pm);
end;

procedure TPropWriterEh.DefineProperty(const Name: string;
  ReadData: TReaderProc; WriteData: TWriterProc; HasData: Boolean);
var
  Pm: TMethodObj;
begin
  Pm := TMethodObj.Create;
{$IFDEF CIL}
  Pm.Method := @WriteData;
{$ELSE}
  Pm.Method := TMethod(WriteData);
{$ENDIF}
  FDefnPropList.AddObject(Name, Pm);
end;

procedure TPropWriterEh.WriteCollection(Value: TCollection);
var
  I: Integer;
  OldAncestor: TPersistent;
begin
  OldAncestor := Ancestor;
  Ancestor := nil;
  try
    WriteValue(vaCollection);
    if Value <> nil then
      for I := 0 to Value.Count - 1 do
      begin
        WriteListBegin;
        WriteAllProperties(Value.Items[I]);
        WriteListEnd;
      end;
    WriteListEnd;
  finally
    Ancestor := OldAncestor;
  end;
end;

procedure TPropWriterEh.WriteAllProperties(Instance: TObject);
var
  I: Integer;
  sl: TStringList;
begin
  sl := TStringList.Create;
  BuildPropsList(Instance, sl);

  for I := 0 to sl.Count - 1 do
    SaveObjectProperyValue(Instance, sl[i], sl[i]);
  sl.Free;
end;

procedure TPropWriterEh.DefineObjectProperties(Instance: TObject);
var
  i: Integer;
  FilerAccess: TFilerAccess;
begin
  for i := 0 to FDefnPropList.Count-1 do
    FDefnPropList.Objects[i].Free;
  FDefnPropList.Clear;
  for i := 0 to FDefnBinPropList.Count-1 do
    FDefnBinPropList.Objects[i].Free;
  FDefnBinPropList.Clear;
  if Instance is TPersistent then
  begin
    FilerAccess := TFilerAccess.Create(TPersistent(Instance));
    FilerAccess.DefineProperties(Self);
    FilerAccess.Free;
  end;
end;

{ TPropReaderEh }

procedure ReadError(const Ident: string);
begin
  raise EReadError.Create(Ident);
end;

procedure PropValueError;
begin
  ReadError(SInvalidPropertyValue);
end;

{$IFNDEF EH_LIB_5}

procedure PropertyNotFound;
begin
  ReadError(SUnknownProperty);
end;

{$ENDIF}

constructor TPropReaderEh.Create(Stream: TStream; BufSize: Integer);
begin
  inherited Create(Stream, BufSize);
  FCollectionList := TList.Create;
end;

destructor TPropReaderEh.Destroy;
begin
  FreeAndNil(FCollectionList);
  inherited Destroy;
end;

procedure TPropReaderEh.ReadComponent(Component: TComponent);
var
  I: Integer;
  Flags: TFilerFlags;
  CompName: String;
  OldOwner, OldParen, SubsComp: TComponent;
  FilerAccess: TFilerAccess;
begin
  SubsComp := nil;
  FilerAccess := nil;
  ReadPrefix(Flags, I);

  ReadStr; { Ignore class name }
  CompName := ReadStr;

  if Component = nil
    then Component := FindChildComponent(Parent, Root, CompName, True)
    else Owner := Component;

  if Component = nil then
  begin
    SubsComp := TComponent.Create(nil);
    Component := SubsComp;
  end;

  FInterceptorList := TList.Create;

  while not EndOfList do ReadProperty(Component);
  ReadListEnd;

  for i := 0 to FCollectionList.Count-1 do
    TCollection(FCollectionList[i]).EndUpdate;
  FCollectionList.Clear;

  for i := FInterceptorList.Count-1 downto 0 do
    with TStoragePropertyInterceptor(FInterceptorList[i]) do
      begin
        Readed;
        Free;
      end;
  FInterceptorList.Free;

  OldOwner := Owner;
  OldParen := Parent;
  try
    FilerAccess := TFilerAccess.Create(Component);
    Owner := FilerAccess.GetChildOwner;
    Parent := FilerAccess.GetChildParent;
    while not EndOfList do ReadComponent(nil);
    ReadListEnd;
  finally
    Owner := OldOwner;
    Parent := OldParen;
    FilerAccess.Free;
  end;

  if SubsComp <> nil then
    SubsComp.Free;
end;

procedure TPropReaderEh.ReadCollection(Collection: TCollection);
var
  Item: TPersistent;
begin
  Collection.BeginUpdate;
  try
    if not EndOfList then Collection.Clear;
    while not EndOfList do
    begin
      if NextValue in [vaInt8, vaInt16, vaInt32] then ReadInteger;
      Item := Collection.Add;
      ReadListBegin;
      while not EndOfList do ReadProperty(Item);
      ReadListEnd;
    end;
    ReadListEnd;
  finally
    Collection.EndUpdate;
  end;
end;

procedure TPropReaderEh.ReadProperty(AInstance: TPersistent);
var
  I, J, L: Integer;
  Instance: TPersistent;
  PropInfo: PPropInfo;
  PropValue: TObject;
  PropPath: string;

  procedure HandleException(E: Exception);
  var
    Name: string;
  begin
    Name := '';
    if AInstance is TComponent then
      Name := TComponent(AInstance).Name;
    if Name = '' then Name := AInstance.ClassName;
    raise EReadError.CreateFmt(SPropertyException, [Name, DotSep, PropPath, E.Message]);
  end;

  procedure PropPathError;
  begin
    SkipValue;
    ReadError(SInvalidPropertyPath);
  end;

  function ReadCollectionItemAsProperty(Collection: TCollection; var PropName: String): TPersistent;
  var
    i, Index: Integer;
    S, SIndex: String;
  begin
    S := Copy(PropName, Length('__Item') + 1, Length(PropName));
    SIndex := '';
    Result := Collection;
    for i := 1 to Length(S) do
      if CharInSetEh(S[i], ['0','1','2','3','4','5','6','7','8','9'])
        then SIndex := SIndex + S[i]
        else Break;
    if SIndex <> ''
      then Index := StrToInt(SIndex)
      else Exit;
    if Collection.Count > Index then
    begin
      PropName := Copy(PropName, Length('__Item') + Length('SIndex') + 1, Length(PropName));
      Result := Collection.Items[Index];
    end;
    if FCollectionList.IndexOf(Collection) = -1 then
    begin
      Collection.BeginUpdate;
      FCollectionList.Add(Collection);
    end;
  end;

  function CheckInterceptor(Instance: TPersistent; const PropName: string): Boolean;
  var
    InterceptorClass: TReadPropertyInterceptorClass;
    Interceptor: TStoragePropertyInterceptor;
    i: Integer;
  begin
    Result := False;
    InterceptorClass := GetInterceptorForTarget(Instance.ClassType);
    if InterceptorClass = nil then Exit;
    Interceptor := nil;
    for i := 0 to FInterceptorList.Count - 1 do
    begin
//      if InterceptorClass = TStoragePropertyInterceptor(FInterceptorList[i]).ClassType then
      if Instance = TStoragePropertyInterceptor(FInterceptorList[i]).FTarget then
      begin
        Interceptor := TStoragePropertyInterceptor(FInterceptorList[i]);
        Break;
      end;
    end;
    if Interceptor = nil then
    begin
      Interceptor := InterceptorClass.Create(Instance);
      FInterceptorList.Add(Interceptor);
    end;
    PropInfo := GetPropInfo(Interceptor.ClassInfo, PropName);
    if (PropInfo = nil) or not CanWrite(PropInfo) then Exit;
    ReadPropValue(Interceptor, PropInfo);
    Result := True;
  end;

var
  Processed: Boolean;
  FilerAccess: TFilerAccess;
begin
  try
    PropPath := ReadStr;
    try
      I := 1;
      L := Length(PropPath);
      Instance := AInstance;
      FCanHandleExcepts := True;
      PropValue := nil;
      while True do
      begin
        J := I;
        while (I <= L) and (PropPath[I] <> '.') do Inc(I);
        FPropName := Copy(PropPath, J, I - J);

        if (PropValue is TCollection) and (Copy(FPropName, 1, 6) = '__Item') then
        begin
          Instance := ReadCollectionItemAsProperty(TCollection(PropValue), FPropName);
          if Instance <> nil then
          begin
            Inc(I);
            Continue;
          end;
        end;

        if I > L then Break;
        PropInfo := GetPropInfo(Instance.ClassInfo, FPropName);
        if PropInfo = nil then
{$IFDEF EH_LIB_6}
          PropertyError(FPropName);
{$ELSE}
          PropertyError;
{$ENDIF}
        PropValue := nil;
        if PropType_getKind(PropInfo_getPropType(PropInfo)) = tkClass then
          PropValue := GetObjectProp(Instance, PropInfo);
        if not (PropValue is TPersistent) then PropPathError;
        Instance := TPersistent(PropValue);
        Inc(I);
      end;
      if CheckInterceptor(Instance, FPropName) then Exit;
      if (Instance = AInstance) and Assigned(OnReadOwnerProp) then
      begin
        Processed := False; 
        OnReadOwnerProp(Self, FPropName, Processed);
        if Processed then Exit;
      end;
      PropInfo := GetPropInfo(Instance.ClassInfo, FPropName);
      if PropInfo <> nil
        then ReadPropValue(Instance, PropInfo)
      else
      begin
        { Cannot reliably recover from an error in a defined property }
        FCanHandleExcepts := False;
        FilerAccess := TFilerAccess.Create(Instance);
        FilerAccess.DefineProperties(Self);
        FilerAccess.Free;
        FCanHandleExcepts := True;
        if FPropName <> '' then
{$IFDEF EH_LIB_6}
          PropertyError(FPropName);
{$ELSE}
          PropertyError;
{$ENDIF}
      end;
    except
      on E: Exception do HandleException(E);
    end;
  except
    on E: Exception do
      if not FCanHandleExcepts or not Error(E.Message) then raise;
  end;
end;

function TPropReaderEh.Error(const Message: string): Boolean;
begin
  Result := inherited Error(Message);
  if not IsRaiseReadErrorEh then
    Result := True;
end;

procedure TPropReaderEh.ReadPropValue(Instance: TPersistent; PropInfo: PPropInfo);
//const
//  NilMethod: TMethod = (Code: nil; Data: nil);
var
  PropType: PTypeInfo;
//  Method: TMethod;

  procedure SetIntIdent(Instance: TPersistent; PropInfo: PPropInfo;
    const Ident: string);
{$IFDEF EH_LIB_5}
  var
    V: Longint;
    IdentToInt: TIdentToInt;
{$ENDIF}
  begin
{$IFDEF EH_LIB_5}
    IdentToInt := FindIdentToInt(PropInfo_getPropType(PropInfo));
    if Assigned(IdentToInt) and IdentToInt(Ident, V) then
      SetOrdProp(Instance, PropInfo, V)
    else
{$ENDIF}
      PropValueError;
  end;

  procedure SetObjectIdent(Instance: TPersistent; PropInfo: PPropInfo; Ident: string);
  var
    Component: TComponent;
    GlobalName: String;

    function MakeGlobalReference: Boolean;
    var
      P: Integer;
    begin
      Result := False;
      P := 1;
      while (P <= Length(Ident)) and (Ident[P] <> '.') do
        Inc(P);
      if P > Length(Ident) then
        Exit;
      GlobalName := Copy(Ident, 1, P - 1);
      Ident := Copy(Ident, P + 1, 1024);
      Result := True;
    end;

  begin
    Component := FindNestedComponent(Root, Ident);
    if Component <> nil then
      SetObjectProp(Instance, PropInfo, Component)
    else if MakeGlobalReference then
    begin
      Component := FindGlobalComponent(GlobalName);
      if Component <> nil then
      begin
        Component := FindNestedComponent(Component, Ident);
        if Component <> nil then
          SetObjectProp(Instance, PropInfo, Component);
      end;
    end;
    //FFixups.Add(TPropFixup.Create(Instance, Root, PropInfo, '', Ident));
  end;

{$IFNDEF EH_LIB_6}

  function ReadVariant: Variant;
  const
    ValTtoVarT: array[TValueType] of Integer = (varNull, varError, varByte,
      varSmallInt, varInteger, varDouble, varString, varError, varBoolean,
      varBoolean, varError, varError, varString, varEmpty, varError, varSingle,
      varCurrency, varDate, varOleStr
{$IFDEF EH_LIB_5}
      , varError
{$ENDIF}
      );
  var
    ValType: TValueType;
  begin
    ValType := NextValue;
    case ValType of
      vaNil, vaNull:
      begin
        if ReadValue = vaNil then
          VarClear(Result) else
          Result := NULL;
      end;
      vaInt8: TVarData(Result).VByte := Byte(ReadInteger);
      vaInt16: TVarData(Result).VSmallint := Smallint(ReadInteger);
      vaInt32: TVarData(Result).VInteger := ReadInteger;
      vaExtended: TVarData(Result).VDouble := ReadFloat;
      vaSingle: TVarData(Result).VSingle := ReadSingle;
      vaCurrency: TVarData(Result).VCurrency := ReadCurrency;
      vaDate: TVarData(Result).VDate := ReadDate;
      vaString, vaLString: Result := ReadString;
      vaWString: Result := ReadWideString;
      vaFalse, vaTrue: TVarData(Result).VBoolean := ReadValue = vaTrue;
    else
      raise EReadError.Create(SReadError);
    end;
    TVarData(Result).VType := ValTtoVarT[ValType];
  end;

{$ENDIF}

  // This is isolated into a local to help reduce transient VarClears
  procedure SetVariantReference;
  begin
    SetVariantProp(Instance, PropInfo, ReadVariant);
  end;

{$IFDEF EH_LIB_6}

  procedure SetInterfaceReference;
  var
    Intf: IInterface;
  begin
    if NextValue = vaNil then
    begin
      ReadValue;
      Intf := nil;
      SetInterfaceProp(Instance, PropInfo, Intf);
    end
    else
      //FFixups.Add(TPropIntfFixup.Create(Instance, Root, PropInfo, '', ReadIdent));
  end;

{$ENDIF}

begin
  if not CanWrite(PropInfo) then
{$IFDEF EH_LIB_6}
    if not ((PropType_getKind(PropInfo_getPropType(PropInfo)) = tkClass) and
       (GetObjectProp(Instance, PropInfo) is TComponent) and
       (csSubComponent in TComponent(GetObjectProp(Instance, PropInfo)).ComponentStyle)) then
{$ENDIF}
      ReadError(SReadOnlyProperty);
  PropType := PropInfo_getPropType(PropInfo);
  case PropType_getKind(PropType) of
    tkInteger:
      if NextValue = vaIdent then
        SetIntIdent(Instance, PropInfo, ReadIdent)
      else
        SetOrdProp(Instance, PropInfo, ReadInteger);
    tkChar:
      SetOrdProp(Instance, PropInfo, Ord(ReadChar));
    tkEnumeration:
      SetOrdProp(Instance, PropInfo, GetEnumValue(PropType, ReadIdent));
    tkFloat:
      SetFloatProp(Instance, PropInfo, ReadFloat);
    tkString, tkLString:
      SetStrProp(Instance, PropInfo, ReadString);
    tkWString:
{$IFDEF EH_LIB_6}
      SetWideStrProp(Instance, PropInfo, ReadWideString);
{$ELSE}
      SetStrProp(Instance, PropInfo, ReadWideString);
{$ENDIF}
    tkSet:
      SetOrdProp(Instance, PropInfo, ReadSet(PropType));
    tkClass:
      case NextValue of
        vaNil:
          begin
            ReadValue;
            SetOrdProp(Instance, PropInfo, 0);
          end;
        vaCollection:
          begin
            ReadValue;
            ReadCollection(TCollection(GetObjectProp(Instance, PropInfo)));
          end
      else
        SetObjectIdent(Instance, PropInfo, ReadIdent);
      end;
    tkMethod:
      raise Exception.Create('Unexpected Kind of Method: "tkMethod"');
{      if NextValue = vaNil then
      begin
        ReadValue;
        SetMethodProp(Instance, PropInfo, NilMethod);
      end
      else
      begin
        Method.Code :=  FindMethod(Root, ReadIdent);
        Method.Data := Root;
        if Method.Code <> nil then SetMethodProp(Instance, PropInfo, Method);
      end;}
    tkVariant:
      SetVariantReference;
{$IFDEF EH_LIB_5}
    tkInt64:
      SetInt64Prop(Instance, PropInfo, ReadInt64);
{$ENDIF}
{$IFDEF EH_LIB_6}
    tkInterface:
      SetInterfaceReference;
{$ENDIF}
{$IFDEF EH_LIB_12}
    tkUString:
      SetWideStrProp(Instance, PropInfo, ReadWideString);
{$ENDIF}
  end;
end;

procedure TPropReaderEh.DefineProperty(const Name: string;
  ReadData: TReaderProc; WriteData: TWriterProc; HasData: Boolean);
begin
  if SameText(Name, FPropName) and Assigned(ReadData) then
  begin
    ReadData(Self);
    FPropName := '';
  end;
end;

procedure TPropReaderEh.DefineBinaryProperty(const Name: string;
  ReadData, WriteData: TStreamProc; HasData: Boolean);
var
  Stream: TMemoryStream;
  Count: Longint;
{$IFDEF CIL}
  ABuffer: array of Byte;
{$ENDIF}
begin
  if SameText(Name, FPropName) and Assigned(ReadData) then
  begin
    if  ReadValue <> vaBinary then
    begin
//      Dec(FBufPos);
//      SkipValue;
      FCanHandleExcepts := True;
      PropValueError;
    end;
    Stream := TMemoryStream.Create;
    try
      Read(Count, SizeOf(Count));
      Stream.SetSize(Count);
{$IFDEF CIL}
{ DONE : Read(Stream.Memory, 0, Count); does not work}
      ABuffer := Stream.Memory;
      Read(ABuffer, 0, Count);
{$ELSE}
      Read(Stream.Memory^, Count);
{$ENDIF}
      FCanHandleExcepts := True;
      ReadData(Stream);
    finally
      Stream.Free;
    end;
    FPropName := '';
  end;
end;

procedure TPropReaderEh.ReadOwnerProperties(Component: TComponent);
begin
  ReadSignature;
  Root := Component;
  Owner := Root;
  ReadComponent(Component);
end;

function EnumValue(EnumType: PTypeInfo; const EnumName: string): Integer;
begin
  Result := GetEnumValue(EnumType, EnumName);
  if Result = -1 then PropValueError;
end;

function TPropReaderEh.ReadSet(SetType: PTypeInfo): Integer;
{$IFDEF CIL}
begin
  Result := inherited ReadSet(SetType);
end;
{$ELSE}
var
  EnumType: PTypeInfo;
  EnumName: string;
begin
  try
    if ReadValue <> vaSet then PropValueError;
    EnumType := GetTypeData(SetType)^.CompType^;
    Result := 0;
    while True do
    begin
      EnumName := ReadStr;
      if EnumName = '' then Break;
      Include(TIntegerSet(Result), EnumValue(EnumType, EnumName));
    end;
  except
    SkipSetBody;
    raise;
  end;
end;
{$ENDIF}

procedure TPropReaderEh.SkipSetBody;
begin
  while ReadStr <> '' do begin end;
end;

{$IFNDEF EH_LIB_5}

procedure TPropReaderEh.PropertyError;
begin
  SkipValue;
  PropertyNotFound;
end;

procedure TPropReaderEh.SkipValue;

  procedure SkipList;
  begin
    while not EndOfList do SkipValue;
    ReadListEnd;
  end;

  procedure SkipBytes(Count: Longint);
  var
    Bytes: array[0..255] of Char;
  begin
    while Count > 0 do
      if Count > SizeOf(Bytes) then
      begin
        Read(Bytes, SizeOf(Bytes));
        Dec(Count, SizeOf(Bytes));
      end
      else
      begin
        Read(Bytes, Count);
        Count := 0;
      end;
  end;

  procedure SkipBinary;
  var
    Count: Longint;
  begin
    Read(Count, SizeOf(Count));
    SkipBytes(Count);
  end;

  procedure SkipCollection;
  begin
    while not EndOfList do
    begin
      if NextValue in [vaInt8, vaInt16, vaInt32] then SkipValue;
      SkipBytes(1);
      while not EndOfList do SkipProperty;
      ReadListEnd;
    end;
    ReadListEnd;
  end;

begin
  case ReadValue of
    vaNull: begin end;
    vaList: SkipList;
    vaInt8: SkipBytes(1);
    vaInt16: SkipBytes(2);
    vaInt32: SkipBytes(4);
    vaExtended: SkipBytes(SizeOf(Extended));
    vaString, vaIdent: ReadStr;
    vaFalse, vaTrue: begin end;
    vaBinary: SkipBinary;
    vaSet: SkipSetBody;
    vaCollection: SkipCollection;
  end;
end;

procedure TPropReaderEh.SkipProperty;
begin
  ReadStr; { Skips property name }
  SkipValue;
end;

{$ENDIF}

{ TStoragePropertyInterceptor }

constructor TStoragePropertyInterceptor.Create(ATarget: TObject);
begin
  inherited Create;
  FTarget := ATarget;
end;

function TStoragePropertyInterceptor.NeedIntercept: Boolean;
begin
  Result := True;
end;

procedure TStoragePropertyInterceptor.Readed;
begin

end;

function GetFormNormalPlacement(Form: TCustomForm): TRect;
{$IFNDEF EH_LIB_CLX}
var
  Placement: TWindowPlacement;
{$ENDIF}
begin
{$IFNDEF EH_LIB_CLX}
  if (Form.WindowState <> wsNormal) and Form.HandleAllocated then
  begin
    Placement.length := SizeOf(TWindowPlacement);
{$IFDEF CIL}
    GetWindowPlacement(Form.Handle, Placement);
{$ELSE}
    GetWindowPlacement(Form.Handle, @Placement);
{$ENDIF}
    Result := Placement.rcNormalPosition;
  end else
{$ENDIF}
    Result := Rect(Form.Left, Form.Top, Form.Left + Form.Width, Form.Top + Form.Height);
end;

{ TFormStoragePropertyInterceptor }

constructor TFormStoragePropertyInterceptor.Create(ATarget: TObject);
var
  PlacementRect: TRect;
begin
  inherited Create(ATarget);
  if (Target <> nil) and (Target is TCustomForm) then
  begin
    PlacementRect := GetFormNormalPlacement(TCustomForm(Target));
    FTop := PlacementRect.Top;
    FLeft := PlacementRect.Left;
    FHeight := PlacementRect.Bottom - PlacementRect.Top;
    FWidth := PlacementRect.Right - PlacementRect.Left;
  end;
  FPixelsPerInch := TForm(Target).PixelsPerInch;
  FWindowState := TForm(Target).WindowState;
  FActiveControl := TForm(Target).ActiveControl;
end;

function TFormStoragePropertyInterceptor.GetTop: Integer;
begin
  Result := 0;
  if (Target <> nil) and (Target is TCustomForm) then
    Result := GetFormNormalPlacement(TCustomForm(Target)).Top
end;

function TFormStoragePropertyInterceptor.GetLeft: Integer;
begin
  Result := 0;
  if (Target <> nil) and (Target is TCustomForm) then
    Result := GetFormNormalPlacement(TCustomForm(Target)).Left;
end;

function TFormStoragePropertyInterceptor.GetHeight: Integer;
var
  PlacementRect: TRect;
begin
  Result := 0;
  if (Target <> nil) and (Target is TCustomForm) then
  begin
    PlacementRect := GetFormNormalPlacement(TCustomForm(Target));
    Result := PlacementRect.Bottom - PlacementRect.Top;
  end;
end;

function TFormStoragePropertyInterceptor.GetWidth: Integer;
var
  PlacementRect: TRect;
begin
  Result := 0;
  if (Target <> nil) and (Target is TCustomForm) then
  begin
    PlacementRect := GetFormNormalPlacement(TCustomForm(Target));
    Result := PlacementRect.Right - PlacementRect.Left;
  end;
end;

function TFormStoragePropertyInterceptor.GetNotmalFormPlacement: TRect;
begin
end;

{$HINTS OFF}

type
{$IFDEF EH_LIB_CLX}
  TNastyForm = class(TScrollingWidget)
  private
{$IFDEF EH_LIB_7}
    FActivated: Boolean;
    FDeactivated: Boolean;
    FBorderIcons: TBorderIcons;
    FActive: Boolean;
    FKeyPreview: Boolean;
    FDropTarget: Boolean;
    FShown: Boolean;
    FSizeGrip: Boolean;
    FModalResult: TModalResult;
    FBorderStyle: TFormBorderStyle;
{$ENDIF}
    FActiveControl: TWidgetControl;
  end;
{$ELSE}
  TNastyForm = class(TScrollingWinControl)
  private
    FActiveControl: TWinControl;
    FFocusedControl: TWinControl;
    FBorderIcons: TBorderIcons;
    FBorderStyle: TFormBorderStyle;
    FSizeChanging: Boolean;
    FWindowState: TWindowState;
    FShowAction: TShowAction;
    FKeyPreview: Boolean;
    FActive: Boolean;
    FFormStyle: TFormStyle;
    FPosition: TPosition;
  end;
{$ENDIF}

{$HINTS ON}

procedure TFormStoragePropertyInterceptor.Readed;
{$IFNDEF EH_LIB_CLX}
var
  Placement: TWindowPlacement;
{$ENDIF}
begin
  inherited Readed;
  FHeight := MulDiv(FHeight, Screen.PixelsPerInch, FPixelsPerInch);
  FLeft := MulDiv(FLeft, Screen.PixelsPerInch, FPixelsPerInch);
  FTop := MulDiv(FTop, Screen.PixelsPerInch, FPixelsPerInch);
  FWidth := MulDiv(FWidth, Screen.PixelsPerInch, FPixelsPerInch);
  if (Target <> nil) then
  begin
    TCustomForm(Target).WindowState := FWindowState;
{$IFDEF CIL}
    TCustomForm(Target).ActiveControl := FActiveControl;
{$ELSE}
    TNastyForm(Target).FActiveControl := FActiveControl;
{$ENDIF}

    if TCustomForm(Target).WindowState <> wsNormal then
    begin
{$IFDEF CIL}
      GetWindowPlacement(TCustomForm(Target).Handle, Placement);
{$ELSE}
      GetWindowPlacement(TCustomForm(Target).Handle, @Placement);
{$ENDIF}
      Placement.rcNormalPosition.Left := FLeft;
      Placement.rcNormalPosition.Top := FTop;
      Placement.rcNormalPosition.Right := FLeft + FWidth;
      Placement.rcNormalPosition.Bottom := FTop + FHeight;
{$IFDEF CIL}
      SetWindowPlacement(TCustomForm(Target).Handle, Placement);
{$ELSE}
      SetWindowPlacement(TCustomForm(Target).Handle, @Placement);
{$ENDIF}
    end else
      TCustomForm(Target).SetBounds(FLeft, FTop, FWidth, FHeight);
    if (TForm(Target).Position in [poScreenCenter, poDesktopCenter]) and
      not (csDesigning in TCustomForm(Target).ComponentState) and FPosPresent
    then
{$IFDEF CIL}
{ TODO : Realize Position }
//      TCustomForm(Target).Position := poDesigned;
{$ELSE}
      TNastyForm(Target).FPosition := poDesigned;
{$ENDIF}

  end;
end;

procedure TFormStoragePropertyInterceptor.SetLeft(const Value: Integer);
begin
  FPosPresent := True;
  FLeft := Value;
end;

procedure TFormStoragePropertyInterceptor.SetTop(const Value: Integer);
begin
  FPosPresent := True;
  FTop := Value;
end;

initialization
  RegisterReadPropertyInterceptor(TCustomForm, TFormStoragePropertyInterceptor);
finalization
  FreeAndNil(InterceptorList);
  FreeAndNil(TargetList);
  FreeAndNil(ForChildListObj);
end.