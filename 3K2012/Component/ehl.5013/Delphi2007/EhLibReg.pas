{*******************************************************}
{                                                       }
{                       EhLib v5.0                      }
{                     (Build 5.0.00)                    }
{                    Registration unit                  }
{                                                       }
{   Copyright (c) 1998-2004 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

{$IFDEF EH_LIB_CLX}
unit QEhLibReg;
{$ELSE}
unit EhLibReg {$IFDEF CIL} platform{$ENDIF};
{$ENDIF}

interface

{$IFDEF CIL}

{$R DBCtrlsEh.TDBCheckBoxEh.bmp}
{$R DBCtrlsEh.TDBComboBoxEh.bmp}
{$R DBCtrlsEh.TDBDateTimeEditEh.bmp}
{$R DBCtrlsEh.TDBEditEh.bmp}
{$R DBCtrlsEh.TDBNumberEditEh.bmp}
{$R DBGridEh.TDBGridEh.bmp}
{$R DBLookupEh.TDBLookupComboboxEh.bmp}
{$R DBSumLst.TDBSumList.bmp}
{$R PrnDbgeh.TPrintDBGridEh.bmp}
{$R PrViewEh.TPreviewBox.bmp}
{$R PropStorageEh.TIniPropStorageManEh.bmp}
{$R PropStorageEh.TPropStorageEh.bmp}
{$R PropStorageEh.TRegPropStorageManEh.bmp}

{$R DataDriverEh.TDataSetDriverEh.bmp}
{$R DataDriverEh.TSQLDataDriverEh.bmp}
{$R MemTableEh.TMemTableEh.bmp}

//{$R DBXDataDriverEh.TDBXDataDriverEh.bmp}
//{$R ADODataDriverEh.TADODataDriverEh.bmp}
//{$R BDEDataDriverEh.TBDEDataDriverEh.bmp}

{$ENDIF}


procedure Register;

implementation

uses Classes, TypInfo,
{$IFDEF CIL} Borland.Vcl.Design.DesignIntf,
             Borland.Vcl.Design.DesignEditors,
             Borland.Vcl.Design.VCLEditors, Variants,
             EhLibVCLNET,
{$ELSE}
             EhLibVCL,
 {$IFDEF EH_LIB_6}DesignIntf, DesignEditors, VCLEditors, Variants,
 {$ELSE}DsgnIntf, {$ENDIF}
{$ENDIF}
  DBGridEh, GridEhEd, DBSumLst, PrViewEh, ComCtrls, SysUtils,
  PropStorageEh, PropStorageEditEh, Windows,
  DBCtrlsEh, PrnDbgEh, DBLookupEh, DB, ToolCtrlsEh, Controls;


{ TListFieldProperty }

type
  TListFieldProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValueList(List: TStrings); virtual;
    procedure GetValues(Proc: TGetStrProc); override;
    function GetDataSourcePropName: string; virtual;
  end;

function TListFieldProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paMultiSelect];
end;


function GetPropertyValue(Instance: TPersistent; const PropName: string): TPersistent;
var
  PropInfo: PPropInfo;
begin
  Result := nil;
  PropInfo := TypInfo.GetPropInfo(Instance.ClassInfo, PropName);
  if (PropInfo <> nil) and (PropType_GetKind(PropInfo_getPropType(PropInfo)) = tkClass) then
    Result := TObject(GetObjectProp(Instance, PropInfo)) as TPersistent;
end;

procedure TListFieldProperty.GetValueList(List: TStrings);
var
  DataSource: TDataSource;
begin
  DataSource := GetPropertyValue(GetComponent(0), GetDataSourcePropName) as TDataSource;
  if (DataSource <> nil) and (DataSource.DataSet <> nil) then
    DataSource.DataSet.GetFieldNames(List);
end;

procedure TListFieldProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
  Values: TStringList;
begin
  Values := TStringList.Create;
  try
    GetValueList(Values);
    for I := 0 to Values.Count - 1 do Proc(Values[I]);
  finally
    Values.Free;
  end;
end;

function TListFieldProperty.GetDataSourcePropName: string;
begin
  Result := 'ListSource';
end;

{ TDBGridEhFieldProperty }

type

  TFilterDataFieldProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValueList(List: TStrings); virtual;
    procedure GetValues(Proc: TGetStrProc); override;
  end;


function TFilterDataFieldProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paMultiSelect];
end;

procedure TFilterDataFieldProperty.GetValueList(List: TStrings);
var
  Ehg : TCustomDBGridEh;
begin
  if (GetComponent(0) = nil) then Exit;

  if (GetComponent(0) is TSTColumnFilterEh)
    then  Ehg := (GetComponent(0) as TSTColumnFilterEh).Grid
    else Exit;

  if (Ehg <> nil) and (Ehg.DataSource <> nil) and (Ehg.DataSource.DataSet <> nil) then
       Ehg.DataSource.DataSet.GetFieldNames(List);
end;

procedure TFilterDataFieldProperty.GetValues(Proc: TGetStrProc);
var
  i: Integer;
  Values: TStringList;
begin
  Values := TStringList.Create;
  try
    GetValueList(Values);
    for i := 0 to Values.Count - 1 do Proc(Values[i]);
  finally
    Values.Free;
  end;
end;

{ TDateProperty
  Date property editor for Value property of TDBDateTimeEditEh components. }

type
  TVarDateProperty = class(TPropertyEditor)
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

function TVarDateProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect, paRevertable];
end;

function TVarDateProperty.GetValue: string;
var
  v: Variant;
begin
  v := GetVarValue;
  if v = Null then
    Result := ''
  else if TCustomDBDateTimeEditEh(GetComponent(0)).Kind = dtkDateEh then
    Result := DateToStr(v)
  else if TCustomDBDateTimeEditEh(GetComponent(0)).Kind = dtkTimeEh then
    Result := TimeToStr(v)
  else
    Result := DateTimeToStr(v);
end;

procedure TVarDateProperty.SetValue(const Value: string);
var
  v: Variant;
begin
  if Value = '' then
    v := Null
  else if TCustomDBDateTimeEditEh(GetComponent(0)).Kind = dtkDateEh then
    v := StrToDate(Value)
  else if TCustomDBDateTimeEditEh(GetComponent(0)).Kind = dtkTimeEh then
    v := StrToTime(Value)
  else
    v := StrToDateTime(Value);
  SetVarValue(v);
end;

{ TNumberProperty
  Date property editor for Value property of TCustomDBNumberEditEh components. }

type
  TVarNumberProperty = class(TPropertyEditor)
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

function TVarNumberProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect, paRevertable];
end;

function TVarNumberProperty.GetValue: string;
var
  v: Variant;
begin
  v := GetVarValue;
  if v = Null then Result := ''
  else Result := FloatToStr(v);
end;

procedure TVarNumberProperty.SetValue(const Value: string);
var
  v: Variant;
begin
  if Value = '' then v := Null
  else v := StrToFloat(Value);
  SetVarValue(v);
end;

// Property storing

{ TPropertyNamesEhProperty }

type
  TPropertyNamesEhProperty = class(TPropertyEditor {TClassProperty})
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure Edit; override;
  end;

{ TPropStorageEhEditor }

  TPropStorageEhEditor = class(TComponentEditor)
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

{ TPropertyNamesEhProperty }

procedure TPropertyNamesEhProperty.Edit;
var
  Obj: TPersistent;
begin
  Obj := GetComponent(0);
  while (Obj <> nil) and not (Obj is TComponent) do
    Obj := GetUltimateOwner(Obj);
  if EditPropStorage(TPropStorageEh(Obj)) then
    Designer.Modified;
end;

function TPropertyNamesEhProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly {, paSubProperties}];
end;

function TPropertyNamesEhProperty.GetValue: string;
begin
{$IFDEF CIL}
  FmtStr(Result, '(%s)', [GetPropType.Name]);
{$ELSE}
  FmtStr(Result, '(%s)', [GetPropType^.Name]);
{$ENDIF}
end;

{ TPropStorageEhEditor }

procedure TPropStorageEhEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0: if EditPropStorage(TPropStorageEh(Component))  then
         Designer.Modified;
  end;
end;

function TPropStorageEhEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'Stored properties ...';
  end;
end;

function TPropStorageEhEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

{$IFDEF EH_LIB_6}
type
 TPropStorageEhSelectionEditor = class(TSelectionEditor)
 public
   procedure RequiresUnits(Proc: TGetStrProc); override;
 end;

{ TPropStorageEhSelectionEditor }

procedure TPropStorageEhSelectionEditor.RequiresUnits(Proc: TGetStrProc);
begin
   inherited RequiresUnits(Proc);
   Proc('PropFilerEh');
end;

type
 TTDBLookupComboboxEhSelectionEditor = class(TSelectionEditor)
 public
   procedure RequiresUnits(Proc: TGetStrProc); override;
 end;

{ TPropStorageEhSelectionEditor }

procedure TTDBLookupComboboxEhSelectionEditor.RequiresUnits(Proc: TGetStrProc);
begin
   inherited RequiresUnits(Proc);
   Proc('DBGridEh');
end;

{$ENDIF}


{ TRegistryKeyProperty }
type

  TRegistryKeyProperty = class(TIntegerProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

{ TRegistryKeyProperty }

function TRegistryKeyProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect, paSortList, paValueList];
end;

function TRegistryKeyProperty.GetValue: string;
begin
  if not RegistryKeyToIdent(HKEY(GetOrdValue), Result) then
    FmtStr(Result, '%d', [GetOrdValue]);
end;

procedure TRegistryKeyProperty.GetValues(Proc: TGetStrProc);
begin
  GetRegistryKeyValues(Proc);
end;

procedure TRegistryKeyProperty.SetValue(const Value: string);
var
  NewValue: Longint;
begin
  if IdentToRegistryKey(Value, NewValue)
    then SetOrdValue(NewValue)
    else inherited SetValue(Value);
end;


procedure Register;
begin


{$IFDEF EH_LIB_6}
  GroupDescendentsWith(TDBSumList, Controls.TControl);
  GroupDescendentsWith(TPrintDBGridEh, Controls.TControl);

  GroupDescendentsWith(TPropStorageEh, Controls.TControl);
  GroupDescendentsWith(TPropStorageManagerEh, Controls.TControl);
{$ENDIF}

  RegisterComponents('EhLib', [TDBGridEh]);
  RegisterComponents('EhLib', [TPrintDBGridEh]);
  RegisterComponentEditor(TDBGridEh, TDBGridEhEditor);
  RegisterPropertyEditor(TypeInfo(TCollection), TCustomDBGridEh, 'Columns', TDBGridEhColumnsProperty);
  RegisterPropertyEditor(TypeInfo(string), TSTColumnFilterEh, 'KeyField', TListFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TSTColumnFilterEh, 'ListField', TListFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TSTColumnFilterEh, 'DataField', TFilterDataFieldProperty);

  RegisterComponents('EhLib', [TDBEditEh, TDBDateTimeEditEh, TDBNumberEditEh,
    TDBComboBoxEh, TDBLookupComboboxEh, TDBCheckBoxEh]);

  RegisterPropertyEditor(TypeInfo(string), TDBLookupComboboxEh, 'KeyField', TListFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TDBLookupComboboxEh, 'ListField', TListFieldProperty);

  RegisterPropertyEditor(TypeInfo(TCollection), TColumnDropDownBoxEh, 'Columns', TDBGridEhColumnsProperty);
  RegisterComponentEditor(TDBLookupComboboxEh, TDBLookupComboboxEhEditor);

  RegisterPropertyEditor(TypeInfo(Variant), TCustomDBDateTimeEditEh, 'Value', TVarDateProperty);
  RegisterPropertyEditor(TypeInfo(Variant), TCustomDBNumberEditEh, 'Value', TVarNumberProperty);

  RegisterPropertyEditor(TypeInfo(string), TColumnEh, 'FieldName', TDBGridEhFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TColumnFooterEh, 'FieldName', TDBGridEhFieldAggProperty);

  RegisterPropertyEditor(TypeInfo(string), TPrintDBGridEh, 'PrintFontName', TFontNameProperty);

  RegisterPropertyEditor(TypeInfo(TStrings), TPropStorageEh, 'StoredProps', TPropertyNamesEhProperty);
  RegisterComponentEditor(TPropStorageEh, TPropStorageEhEditor);
{$IFDEF EH_LIB_6}
  RegisterSelectionEditor(TPropStorageEh, TPropStorageEhSelectionEditor);
  RegisterSelectionEditor(TCustomDBLookupComboboxEh, TTDBLookupComboboxEhSelectionEditor);
{$ENDIF}


  RegisterComponents('EhLib', [TDBSumList]);
  RegisterComponents('EhLib', [TPreviewBox]);

  RegisterComponents('EhLib', [TPropStorageEh, TIniPropStorageManEh, TRegPropStorageManEh]);
  RegisterPropertyEditor(TypeInfo(HKEY), TRegPropStorageManEh, 'Key', TRegistryKeyProperty);

  { Property Category registration }
{$IFDEF EH_LIB_6}
  RegisterPropertyEditor(TypeInfo(TShortCut), TEditButtonEh, 'ShortCut', TShortCutProperty);
  RegisterPropertyEditor(TypeInfo(TShortCut), TSpecRowEh, 'ShortCut', TShortCutProperty);

  RegisterPropertiesInCategory(sDatabaseCategoryName, [TypeInfo(TDBGridColumnsEh)]);
  RegisterPropertyInCategory(sDatabaseCategoryName, TColumnEh, 'FieldName');
  RegisterPropertiesInCategory(sLocalizableCategoryName, TColumnEh, ['Picklist', 'KeyList']); { Do not localize }
  RegisterPropertiesInCategory(sLocalizableCategoryName, [TypeInfo(TColumnTitleEh)]);
  RegisterPropertiesInCategory(sVisualCategoryName, TColumnEh, ['AlwaysShowEditButton',
    'AutoFitColWidth', 'WordWrap', 'EndEllipsis', 'Checkboxes']);

{$ELSE}
{$IFDEF EH_LIB_5}
  RegisterPropertiesInCategory(TDatabaseCategory, [TypeInfo(TDBGridColumnsEh)]);
  RegisterPropertyInCategory(TDatabaseCategory, TColumnEh, 'FieldName');
  RegisterPropertiesInCategory(TLocalizableCategory, TColumnEh, ['Picklist', 'KeyList']); { Do not localize }
  RegisterPropertiesInCategory(TLocalizableCategory, [TypeInfo(TColumnTitleEh)]);
  RegisterPropertiesInCategory(TVisualCategory, TColumnEh, ['AlwaysShowEditButton',
    'AutoFitColWidth', 'WordWrap', 'EndEllipsis', 'Checkboxes']);
{$ENDIF}
{$ENDIF}


{$IFDEF EH_LIB_CLX}
{$ELSE}
{$ENDIF}

end;

end.
