{*******************************************************}
{                                                       }
{                       EhLib v5.0                      }
{             TDBLookupComboboxEh component             }
{                      Build 5.0.00                     }
{                                                       }
{      Copyright (c) 2001-2009 by Dmitry V. Bolshakov   }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit DBLookupEh;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
{$IFDEF EH_LIB_6}Variants, {$ENDIF}
  StdCtrls, Mask, Db, DBCtrls, Buttons, DBCtrlsEh, ToolCtrlsEh, Menus,
{$IFDEF CIL}
  EhLibVCLNET,
{$ELSE}
  EhLibVCL,
{$ENDIF}
  DBLookupGridsEh, DBGridEh;

type

  TCustomDBLookupComboboxEh = class;

  TLookupComboboxDropDownBoxEh = class(TColumnDropDownBoxEh)
  published
    property Align;
    property AutoDrop;
    property Rows;
    property ShowTitles;
    property Sizable;
    property SpecRow;
    property Width;
  end;

{ TDataSourceLinkEh }

  TDataSourceLinkEh = class(TFieldDataLinkEh)
  private
    FDataIndependentValueAsText: Boolean;
    FDBLookupControl: TCustomDBLookupComboboxEh;
  protected
    constructor Create;
    procedure RecordChanged(Field: TField); override;
    procedure LayoutChanged; override;
  end;

{ TListSourceLinkEh }

  TListSourceLinkEh = class(TDataLink)
  private
    FDBLookupControl: TCustomDBLookupComboboxEh;
  protected
    procedure ActiveChanged; override;
    procedure DataSetChanged; override;
    procedure LayoutChanged; override;
  public
    constructor Create;
  end;

{ TDBLookupComboboxEh }

  TDBLookupComboboxEhStyle = (csDropDownListEh, csDropDownEh);

  TCustomDBLookupComboboxEh = class(TCustomDBEditEh, ILookupGridOwner)
  private
    FDataFields: TFieldsArrEh;
    FDataFieldName: String;
    FDataFieldsUpdating: Boolean;
    FDataList: TPopupDataGridEh;
    FDropDownBox: TLookupComboboxDropDownBoxEh;
    FInternalTextSetting: Boolean;
    FKeyFields: TFieldsArrEh;
    FKeyFieldName: String;
    FKeyTextIndependent: Boolean;
    FKeyValue: Variant;
    FListActive: Boolean;
    FListColumnMothed: Boolean;
    FListField: TField;
    FListFieldIndex: Integer;
    FListFieldName: String;
    FListFields: TList;
    FListLink: TListSourceLinkEh;
    FListSource: TDataSource;
    FListVisible: Boolean;
    FLockUpdateKeyTextIndependent: Boolean;
    FLookupMode: Boolean;
    FLookupSource: TDataSource;
    FMasterFields: TFieldsArrEh;
    FMasterFieldNames: String;
    FOnCloseUp: TCloseUpEventEh;
    FOnDropDown: TNotifyEvent;
    FOnKeyValueChanged: TNotifyEvent;
    FOnNotInList: TNotInListEventEh;
    FStyle: TDBLookupComboboxEhStyle;
    FTextBeenChanged: Boolean;
    function GetDataLink: TDataSourceLinkEh;
    function GetKeyFieldName: String;
    function GetListSource: TDataSource;
    function GetOnButtonClick: TButtonClickEventEh;
    function GetOnButtonDown: TButtonDownEventEh;
    function GetOnDropDownBoxCheckButton: TCheckTitleEhBtnEvent;
    function GetOnDropDownBoxDrawColumnCell: TDrawColumnEhCellEvent;
    function GetOnDropDownBoxGetCellParams: TGetCellEhParamsEvent;
    function GetOnDropDownBoxSortMarkingChanged: TNotifyEvent;
    function GetOnDropDownBoxTitleBtnClick: TTitleEhClickEvent;
    procedure CheckNotCircular;
    procedure CheckNotLookup;
    procedure CMCancelMode(var Message: TCMCancelMode); message CM_CANCELMODE;
    procedure CMMouseWheel(var Message: TCMMouseWheel); message CM_MOUSEWHEEL;
    procedure CMWantSpecialKey(var Message: TCMWantSpecialKey); message CM_WANTSPECIALKEY;
    procedure DataListKeyValueChanged(Sender: TObject);
    procedure EMReplacesel(var Message: TMessage); message EM_REPLACESEL;
//    procedure ListMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ListMouseCloseUp(Sender: TObject; Accept: Boolean);
    procedure ListColumnMoved(Sender: TObject; FromIndex, ToIndex: Longint);
    procedure SetDataFieldName(const Value: String);
    procedure SetDropDownBox(const Value: TLookupComboboxDropDownBoxEh);
    procedure SetKeyFieldName(const Value: String);
    procedure SetKeyValue(const Value: Variant);
    procedure SetListFieldName(const Value: String);
    procedure SetListSource(Value: TDataSource);
    procedure SetLookupMode(Value: Boolean);
    procedure SetOnButtonClick(const Value: TButtonClickEventEh);
    procedure SetOnButtonDown(const Value: TButtonDownEventEh);
    procedure SetOnDropDownBoxCheckButton(const Value: TCheckTitleEhBtnEvent);
    procedure SetOnDropDownBoxDrawColumnCell(const Value: TDrawColumnEhCellEvent);
    procedure SetOnDropDownBoxGetCellParams(const Value: TGetCellEhParamsEvent);
    procedure SetOnDropDownBoxSortMarkingChanged(const Value: TNotifyEvent);
    procedure SetOnDropDownBoxTitleBtnClick(const Value: TTitleEhClickEvent);
    procedure SetStyle(const Value: TDBLookupComboboxEhStyle);
    procedure UpdateKeyTextIndependent;
    procedure UpdateReadOnly;
    procedure WMChar(var Message: TWMChar); message WM_CHAR;
    procedure WMCut(var Message: TMessage); message WM_CUT;
    procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMPaste(var Message: TMessage); message WM_PASTE;
    procedure WMSetCursor(var Message: TWMSetCursor); message WM_SETCURSOR;
  protected
    function ButtonEnabled: Boolean; override;
    function CanModify(TryEdit: Boolean): Boolean; virtual;
    function CreateDataLink: TFieldDataLinkEh; override;
    function CreateEditButton: TEditButtonEh; override;
    function CompatibleVarValue(AFieldsArr: TFieldsArrEh; AVlaue: Variant): Boolean; virtual;
    function DefaultAlignment: TAlignment; override;
    function DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function GetDataField: TField; reintroduce;
    function GetDisplayText(Field: TField): String;
    function GetDisplayTextForPaintCopy: String; override;
    function GetListFieldsWidth: Integer; virtual;
    function GetVariantValue: Variant; override;
    function IsValidChar(InputChar: Char): Boolean; override;
    function LocateStr(Str: String; PartialKey: Boolean): Boolean; virtual;
    function LocateDataSourceKey(DataSource: TDataSource): Boolean; virtual;
    function SpecListMode: Boolean; virtual;
    function FullListSource: TDataSource;
    function TraceMouseMoveForPopupListbox(Sender: TObject; Shift: TShiftState; X, Y: Integer): Boolean;
    function UsedListSource: TDataSource;
    procedure ActiveChanged; override;
    procedure ButtonDown(IsDownButton: Boolean); override;
    procedure Click; override;
    procedure DataChanged; override;
    procedure EditButtonMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer); override;
    procedure InternalSetText(AText: String); override;
    procedure InternalSetValue(AValue: Variant); override;
    procedure HookOnChangeEvent(Sender: TObject);
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyValueChanged; virtual;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure ListLinkDataChanged; virtual;
    procedure Loaded; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure ProcessSearchStr(Str: String); virtual;
    procedure SelectKeyValue(const Value: Variant); virtual;
    procedure SetEditText(Value: String);
    procedure SetFocused(Value: Boolean); override;
    procedure SpecRowChanged(Sender: TObject); virtual;
    procedure UpdateDataFields; virtual;
    procedure UpdateListFields; virtual;
    procedure UpdateListLinkDataSource; virtual;
    property DataLink: TDataSourceLinkEh read GetDataLink;
    property ListActive: Boolean read FListActive;
    property ListFields: TList read FListFields;
    property ListLink: TListSourceLinkEh read FListLink;
    property OnButtonClick: TButtonClickEventEh read GetOnButtonClick write SetOnButtonClick;
    property OnButtonDown: TButtonDownEventEh read GetOnButtonDown write SetOnButtonDown;
  protected
    { ILookupGridOwner }
    procedure SetDropDownBoxListSource(AListSource: TDataSource);
    procedure ILookupGridOwner.SetListSource = SetDropDownBoxListSource;
    function GetLookupGrid: TCustomDBGridEh;
    function GetOptions: TDBLookupGridEhOptions;
    procedure SetOptions(Value: TDBLookupGridEhOptions);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function LocateKey: Boolean; virtual;
    procedure ClearDataProps;
    procedure CloseUp(Accept: Boolean); override;
    procedure DefaultHandler(var Message); override;
    procedure DropDown; override;
    procedure SelectAll; virtual;
    procedure SelectNextValue(IsPrior: Boolean);
    procedure UpdateData; override;
    property DataField: String read FDataFieldName write SetDataFieldName;
    property DataList: TPopupDataGridEh read FDataList;
    //property DataSource: TDataSource read GetDataSource write SetDataSource; //Internal error: E4983
    property DropDownBox: TLookupComboboxDropDownBoxEh read FDropDownBox write SetDropDownBox;
    property Field: TField read GetDataField;
    property KeyField: String read GetKeyFieldName write SetKeyFieldName;
    property KeyValue: Variant read FKeyValue write SelectKeyValue;
    property ListField: String read FListFieldName write SetListFieldName;
    property ListFieldIndex: Integer read FListFieldIndex write FListFieldIndex default 0;
    property ListSource: TDataSource read GetListSource write SetListSource;
    property ListVisible: Boolean read FListVisible;
    property Style: TDBLookupComboboxEhStyle read FStyle write SetStyle default csDropDownListEh;
    property Text;
    property OnCloseUp: TCloseUpEventEh read FOnCloseUp write FOnCloseUp;
    property OnDropDown: TNotifyEvent read FOnDropDown write FOnDropDown;
    property OnKeyValueChanged: TNotifyEvent read FOnKeyValueChanged write FOnKeyValueChanged;
    property OnNotInList: TNotInListEventEh read FOnNotInList write FOnNotInList;
    property OnDropDownBoxCheckButton: TCheckTitleEhBtnEvent
      read GetOnDropDownBoxCheckButton write SetOnDropDownBoxCheckButton;
    property OnDropDownBoxDrawColumnCell: TDrawColumnEhCellEvent
      read GetOnDropDownBoxDrawColumnCell write SetOnDropDownBoxDrawColumnCell;
    property OnDropDownBoxGetCellParams: TGetCellEhParamsEvent
      read GetOnDropDownBoxGetCellParams write SetOnDropDownBoxGetCellParams;
    property OnDropDownBoxSortMarkingChanged: TNotifyEvent
      read GetOnDropDownBoxSortMarkingChanged write SetOnDropDownBoxSortMarkingChanged;
    property OnDropDownBoxTitleBtnClick: TTitleEhClickEvent
      read GetOnDropDownBoxTitleBtnClick write SetOnDropDownBoxTitleBtnClick;
  end;

  TDBLookupComboboxEh = class(TCustomDBLookupComboboxEh)
  published
    property Alignment;
    property AlwaysShowBorder;
    property AutoSelect;
    property AutoSize;
    property BorderStyle;
    property Anchors;
    property BiDiMode;
    property Constraints;
    property DragKind;
    property Images;
    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
    property Color;
    property Ctl3D;
    property DataField;
    property DataSource;
    property DragCursor;
    property DragMode;
    property DropDownBox;
    property Enabled;
    property EditButton;
    property EditButtons;
    property Font;
    property Flat;
    property HighlightRequired;
    property ImeMode;
    property ImeName;
    property KeyField;
    property ListField;
    property ListFieldIndex;
    property ListSource;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property Style;
    property TabOrder;
    property TabStop;
    property Tooltips;
    property Visible;
    property WordWrap;
    property OnButtonClick;
    property OnButtonDown;
    property OnChange;
    property OnClick;
    property OnCloseUp;
    property OnCheckDrawRequiredState;
{$IFDEF EH_LIB_5}
    property OnContextPopup;
{$ENDIF}
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDropDown;
    property OnDropDownBoxCheckButton;
    property OnDropDownBoxDrawColumnCell;
    property OnDropDownBoxGetCellParams;
    property OnDropDownBoxSortMarkingChanged;
    property OnDropDownBoxTitleBtnClick;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetImageIndex;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnKeyValueChanged;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnNotInList;
    property OnUpdateData;
    property OnStartDrag;
  end;

implementation

uses DbConsts, Clipbrd{$IFDEF EH_LIB_6}, VDBConsts, Types{$ENDIF};

const
{$IFDEF EH_LIB_10}
  MemoTypes = [ftMemo, ftWideMemo];
{$ELSE}
  MemoTypes = [ftMemo];
{$ENDIF}

function VarEquals(const V1, V2: Variant): Boolean;
var i: Integer;
begin
  Result := not (VarIsArray(V1) xor VarIsArray(V2));
  if not Result then Exit;
  Result := False;
  try
    if VarIsArray(V1) and VarIsArray(V2) and
      (VarArrayDimCount(V1) = VarArrayDimCount(V2)) and
      (VarArrayLowBound(V1, 1) = VarArrayLowBound(V2, 1)) and
      (VarArrayHighBound(V1, 1) = VarArrayHighBound(V2, 1))
      then
      for i := VarArrayLowBound(V1, 1) to VarArrayHighBound(V1, 1) do
      begin
        Result := V1[i] = V2[i];
        if not Result then Exit;
      end
    else
      Result := V1 = V2;
  except
  end;
end;

{ TDataSourceLinkEh }

constructor TDataSourceLinkEh.Create;
begin
  inherited Create;
  MultiFields := True;
end;

procedure TDataSourceLinkEh.LayoutChanged;
begin
  if FDBLookupControl <> nil then FDBLookupControl.UpdateDataFields;
end;

procedure TDataSourceLinkEh.RecordChanged(Field: TField);
begin
  inherited RecordChanged(Field);
end;

{ TListSourceLinkEh }

constructor TListSourceLinkEh.Create;
begin
  inherited Create;
  VisualControl := True;
end;

procedure TListSourceLinkEh.ActiveChanged;
begin
  if FDBLookupControl <> nil then FDBLookupControl.UpdateListFields;
end;

procedure TListSourceLinkEh.DataSetChanged;
begin
  if FDBLookupControl <> nil then FDBLookupControl.ListLinkDataChanged;
end;

procedure TListSourceLinkEh.LayoutChanged;
begin
  if FDBLookupControl <> nil then FDBLookupControl.UpdateListFields;
end;

{ TCustomDBLookupComboboxEh }

constructor TCustomDBLookupComboboxEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FLookupSource := TDataSource.Create(Self);
  FListLink := TListSourceLinkEh.Create;
  FListLink.FDBLookupControl := Self;
  FListFields := TList.Create;
  FKeyValue := Null;

  FDataList := TPopupDataGridEh.Create(Self);
  FDataList.Parent := Self;
  FDataList.Visible := False;
  FDataList.Ctl3D := True;
  FDataList.ParentCtl3D := False;
  //FDataList.OnMouseUp := ListMouseUp;
  FDataList.OnMouseCloseUp := ListMouseCloseUp;
  FDataList.OnUserKeyValueChange := DataListKeyValueChanged;


  FDropDownBox := TLookupComboboxDropDownBoxEh.Create(Self);
  FDropDownBox.Rows := 7;
  FDropDownBox.SpecRow.OnChanged := SpecRowChanged;
  FKeyTextIndependent := True;
end;

destructor TCustomDBLookupComboboxEh.Destroy;
begin
  FreeAndNil(FListFields);
//  FListFields := nil;
  FListLink.FDBLookupControl := nil;
  FreeAndNil(FListLink);
//  FListLink := nil;
  FreeAndNil(FDropDownBox);
//  FDropDownBox := nil;
  inherited Destroy;
end;

function TCustomDBLookupComboboxEh.CanModify(TryEdit: Boolean): Boolean;
  function MasterFieldsCanModify: Boolean;
  var i: Integer;
  begin
    Result := True;
    for i := 0 to Length(FMasterFields) - 1 do
      if not FMasterFields[i].CanModify then
      begin
        Result := False;
        Exit;
      end;
  end;
begin
  Result := (FKeyTextIndependent or FListActive) and
    not ReadOnly and
    ((FDataLink.DataSource = nil) or (Length(FMasterFields) <> 0) and MasterFieldsCanModify);
  if TryEdit and Result and (Length(FMasterFields) <> 0) then
    Result := FDataLink.Edit;
end;

function TCustomDBLookupComboboxEh.CreateEditButton: TEditButtonEh;
begin
  Result := TVisibleEditButtonEh.Create(Self {,FEditSpeedButton});
end;

function TCustomDBLookupComboboxEh.CreateDataLink: TFieldDataLinkEh;
begin
  Result := TFieldDataLinkEh(TDataSourceLinkEh.Create);
  TDataSourceLinkEh(Result).FDBLookupControl := Self;
end;

procedure TCustomDBLookupComboboxEh.CheckNotCircular;
begin
  if FListLink.Active and FListLink.DataSet.IsLinkedTo(DataSource) then
    DatabaseError(SCircularDataLink);
end;

procedure TCustomDBLookupComboboxEh.CheckNotLookup;
begin
  if FLookupMode then DatabaseError(SPropDefByLookup);
  if FDataLink.DataSourceFixed then DatabaseError(SDataSourceFixed);
end;

function TCustomDBLookupComboboxEh.DefaultAlignment: TAlignment;
begin
  if FKeyTextIndependent then Result := inherited DefaultAlignment
  else Result := taLeftJustify;
end;

procedure TCustomDBLookupComboboxEh.UpdateDataFields;
  function MasterFieldNames: String;
  var i: Integer;
  begin
    Result := '';
    for i := 0 to Length(FMasterFields) - 1 do
      if Result = '' then
        Result := FMasterFields[i].FieldName else
        Result := Result + ';' + FMasterFields[i].FieldName;
  end;
begin
  if FDataFieldsUpdating then Exit;
  FDataFieldsUpdating := True;
  try
    SetLength(FDataFields, 0); //FDataField := nil;
    SetLength(FMasterFields, 0); //FMasterField := nil;
    FMasterFieldNames := '';
    if FDataLink.DataSetActive and (FDataFieldName <> '') then
    begin
      CheckNotCircular;
      FDataFields := GetFieldsProperty(FDataLink.DataSet, Self, FDataFieldName);
      if (Length(FDataFields) = 1) and (FDataFields[0].FieldKind = fkLookup) then
        FMasterFields := GetFieldsProperty(FDataLink.DataSet, Self, FDataFields[0].KeyFields)
      else
        FMasterFields := FDataFields;
      FMasterFieldNames := MasterFieldNames;
    end;
    SetLookupMode((Length(FDataFields) = 1) and (FDataFields[0].FieldKind = fkLookup));
    if FMasterFieldNames = '' then DataLink.FieldName := FDataFieldName
    else DataLink.FieldName := FMasterFieldNames;
    UpdateKeyTextIndependent;
    UpdateReadOnly;
    UpdateEditButtonControlsState; //UpdateButtonState;
    if not FKeyTextIndependent then
      DataLink.RecordChanged(nil);
  finally
    FDataFieldsUpdating := False;
  end;
end;

procedure TCustomDBLookupComboboxEh.UpdateListFields;
var
  DataSet: TDataSet;
  ResultField: TField;
  i: Integer;
  OldModified: Boolean;
begin
  if ListVisible then Exit;
  FListActive := False;
  UpdateEditButtonControlsState;
  //FKeyField := nil;
  FListField := nil;
  FListFields.Clear;
  if FListLink.Active and (FKeyFieldName <> '') then
  begin
    CheckNotCircular;
    DataSet := FListLink.DataSet;
    FKeyFields := GetFieldsProperty(DataSet, Self, FKeyFieldName);
    GetFieldsProperty(FListFields, DataSet, Self, FListFieldName);
    if FLookupMode then
    begin
      ResultField := GetFieldProperty(DataSet, Self, FDataFields[0].LookupResultField);
      if FListFields.IndexOf(ResultField) < 0 then
        FListFields.Insert(0, ResultField);
      FListField := ResultField;
    end else
    begin
      if FListFields.Count = 0 then
        for i := 0 to Length(FKeyFields) - 1 do FListFields.Add(FKeyFields[i]);
      if (FListFieldIndex >= 0) and (FListFieldIndex < FListFields.Count) then
        FListField := TField(FListFields[FListFieldIndex]) else
        FListField := TField(FListFields[0]);
    end;
    FListActive := True;
  end;
  UpdateKeyTextIndependent;
  UpdateReadOnly;
  UpdateEditButtonControlsState; //UpdateButtonState;
  //KeyValueChanged; //Comment to avoid update data on loss focus
  OldModified := Modified;
  if not FKeyTextIndependent then
    if not FListActive then
      if csDesigning in ComponentState then
        SetEditText(Name)
      else {if not DataIndepended then}
        SetEditText('')
    else if FFocused and SpecListMode and LocateDataSourceKey(FullListSource) then
      SetEditText(GetDisplayText(FullListSource.DataSet.FieldByName(FListField.FieldName)))
    else if DropDownBox.SpecRow.Visible and
      (DropDownBox.SpecRow.LocateKey(FKeyValue) or
      (DropDownBox.SpecRow.ShowIfNotInKeyList and not LocateKey)
      ) then
      SetEditText(DropDownBox.SpecRow.CellText[ListFieldIndex])
    else if not LocateKey then
      SetEditText('')
    else
      SetEditText(GetDisplayText(FListField));
  if OldModified <> Modified then
  begin
    Modified := OldModified;
    FDataLink.SetModified(OldModified);
  end;
  Invalidate;
end;

procedure TCustomDBLookupComboboxEh.DataChanged;
begin
  //if (Field = nil) or (Field = FMasterField) then
  if DataIndepended and
    (TDataSourceLinkEh(FDataLink).FDataIndependentValueAsText = True) then
  begin
    SetEditText(VarToStr(DataLink.DataIndependentValue));
    LocateStr(Text, False);
  end else
  begin
    if DataLink.DataSetActive and (Length(FMasterFields) > 0) and
      (FMasterFieldNames <> '') then
      SetKeyValue(DataLink.DataSet.FieldValues[FMasterFieldNames])
    else if DataIndepended then
      SetKeyValue(DataLink.DataIndependentValue)
    else
      SetKeyValue(Null);

    if ListActive then
      if FFocused and SpecListMode and LocateDataSourceKey(FullListSource) then
        SetEditText(GetDisplayText(FullListSource.DataSet.FieldByName(FListField.FieldName)))
      else if DropDownBox.SpecRow.Visible and
        (DropDownBox.SpecRow.LocateKey(FKeyValue) or
        (DropDownBox.SpecRow.ShowIfNotInKeyList and not LocateKey)
        )
      then
        SetEditText(DropDownBox.SpecRow.CellText[ListFieldIndex])
      else if not LocateKey then
        SetEditText('');
  end;
  Modified := False;
end;

function TCustomDBLookupComboboxEh.GetKeyFieldName: String;
begin
  if FLookupMode then Result := '' else Result := FKeyFieldName;
end;

function TCustomDBLookupComboboxEh.GetListSource: TDataSource;
begin
  if FLookupMode then Result := nil else Result := FListSource//FListLink.DataSource;
end;

function TCustomDBLookupComboboxEh.UsedListSource: TDataSource;
begin
  if Focused and Assigned(DropDownBox.ListSource) and not (csDesigning in ComponentState) then
    Result := DropDownBox.ListSource
  else if FLookupMode then
    Result := FLookupSource
  else
    Result := ListSource;
end;

function TCustomDBLookupComboboxEh.SpecListMode: Boolean;
begin
  Result := (UsedListSource <> nil) and (UsedListSource = DropDownBox.ListSource);
end;

function TCustomDBLookupComboboxEh.FullListSource: TDataSource;
begin
  if FLookupMode
    then Result := FLookupSource
    else Result := ListSource;
end;

function TCustomDBLookupComboboxEh.LocateDataSourceKey(DataSource: TDataSource): Boolean;
begin
  Result := False;
  if (DataSource = nil) or (DataSource.DataSet = nil) then Exit;

  if not VarIsNull(FKeyValue) and DataSource.DataSet.Active and
    CompatibleVarValue(FKeyFields, FKeyValue) and
    DataSource.DataSet.Locate(FKeyFieldName, FKeyValue, [])
  then
    Result := True;
end;

procedure TCustomDBLookupComboboxEh.UpdateListLinkDataSource;
begin
  FListLink.DataSource := UsedListSource;
end;

procedure TCustomDBLookupComboboxEh.KeyValueChanged;
begin
  FDataLink.Modified;
  Modified := True;
  if not FKeyTextIndependent then
    if ListActive then
    begin
      if LocateKey and not DropDownBox.SpecRow.LocateKey(FKeyValue) then
        SetEditText(GetDisplayText(FListField));
      {else if KeyValue = Null then
        SetEditText('')}
    end
    else if csDesigning in ComponentState then
      SetEditText(Name);
  {else if Style = csDropDownListEh then
    SetEditText('');}
  if FListVisible then
    FDataList.KeyValue := KeyValue;
  if (Style = csDropDownListEh) and HandleAllocated then SelectAll;
  if Assigned(FOnKeyValueChanged) then FOnKeyValueChanged(Self);
end;

procedure TCustomDBLookupComboboxEh.ListLinkDataChanged;
begin
end;

function TCustomDBLookupComboboxEh.ButtonEnabled: Boolean;
begin
  Result := inherited ButtonEnabled and
    (ListActive or Assigned(OnButtonClick) or Assigned(OnButtonDown));
end;

function TCustomDBLookupComboboxEh.LocateKey: Boolean;
var
  KeySave: Variant;
begin
  Result := False;
  try
    KeySave := FKeyValue;
    if not VarIsNull(FKeyValue) and FListLink.DataSet.Active and
      CompatibleVarValue(FKeyFields, FKeyValue) and
      FListLink.DataSet.Locate(FKeyFieldName, FKeyValue, []) then
    begin
      Result := True;
      FKeyValue := KeySave;
    end;
  except
  end;
end;

procedure TCustomDBLookupComboboxEh.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
    if (FListLink <> nil) and (AComponent = ListSource)
      then ListSource := nil
    else if (FDropDownBox <> nil) and (AComponent = FDropDownBox.ListSource) then
    begin
      FDropDownBox.ListSource := nil;
      Reset;
    end;
end;

procedure TCustomDBLookupComboboxEh.ProcessSearchStr(Str: String);
var
  S, SearchText: String;
  OldSelLenght: Integer;
begin
  if (FListField <> nil) and (FListField.FieldKind in [fkData, fkInternalCalc]) {and
    (FListField.DataType in [ftString, ftWideString])} then
    if CanModify(True) then
    begin
      if (Length(Str) = 1) and (Str[1] = #8) then {BACKSPACE}
      begin
        if Length(Text) = SelLength then
        begin
          SelStart := MAXINT;
          SelLength := -1;
        end else
        begin
          OldSelLenght := Abs(SelLength);
          SelStart := MAXINT;
          SelLength := -OldSelLenght - 1;
        end
      end else
      begin
        SearchText := Copy(Text, 1, SelStart);
        S := SearchText + Str;
        LocateStr(S, True);
      end;
    end;
end;

procedure TCustomDBLookupComboboxEh.HookOnChangeEvent(Sender: TObject);
begin
  FTextBeenChanged := True;
end;

function TCustomDBLookupComboboxEh.LocateStr(Str: String; PartialKey: Boolean): Boolean;
var
  Options: TLocateOptions;
  CurOnChangeEvent: TNotifyEvent;
begin
  Result := False;
  if not FListActive or not CanModify(True) then Exit;
  if PartialKey then
    Options := [loCaseInsensitive, loPartialKey]
  else
    Options := [loCaseInsensitive];
  try
    Result := FListLink.DataSet.Locate(FListField.FieldName, Str, Options);
    if Result then
    begin
      FTextBeenChanged := False;
      CurOnChangeEvent := OnChange;
      OnChange := HookOnChangeEvent;
      SetKeyValue(FListLink.DataSet.FieldValues[FKeyFieldName]);
      SetEditText(GetDisplayText(FListField));
      SelStart := Length(Text);
      SelLength := Length(Str) - SelStart;
      OnChange := CurOnChangeEvent;
      if FTextBeenChanged and Assigned(OnChange) then
        OnChange(Self);
    end else if Style = csDropDownEh then
      SetKeyValue(Null);
  except
    { If you attempt to search for a String larger than what the field
      can hold, and exception will be raised.  Just trap it and
      reset the SearchText back to the old value. }
    if Style = csDropDownListEh then
    begin
      SetEditText(Text);
      SelStart := Length(Text);
      SelLength := Length(Text) - SelStart;
    end else
      SetKeyValue(Null);
  end;
end;

procedure TCustomDBLookupComboboxEh.SelectKeyValue(const Value: Variant);
begin
  if Length(FMasterFields) > 0 then
  begin
    if FDataLink.Edit then
      FDataLink.DataSet.FieldValues[FMasterFieldNames] := Value;
  end else
  begin
    SetKeyValue(Value);
    if FDataPosting then Exit;
    try
      UpdateData;
    except
      FDataLink.Reset;
      raise;
    end;
  end;
  if ListActive and not LocateKey and not
    ( DropDownBox.SpecRow.Visible and
     (DropDownBox.SpecRow.LocateKey(FKeyValue) or
     (DropDownBox.SpecRow.ShowIfNotInKeyList and not LocateKey))
    )
  then
    SetEditText('');
//  Repaint;
//  Click;
end;

procedure TCustomDBLookupComboboxEh.SetDataFieldName(const Value: String);
begin
  if FDataFieldName <> Value then
  begin
    FDataFieldName := Value;
    UpdateDataFields;
  end;
end;

procedure TCustomDBLookupComboboxEh.SetKeyFieldName(const Value: String);
begin
  CheckNotLookup;
  if FKeyFieldName <> Value then
  begin
    FKeyFieldName := Value;
    FDataList.KeyField := Value;
    UpdateListFields;
  end;
end;

procedure TCustomDBLookupComboboxEh.SetKeyValue(const Value: Variant);
begin
  if not VarEquals(FKeyValue, Value) then
  begin
    FKeyValue := Value;
    KeyValueChanged;
  end;
end;

procedure TCustomDBLookupComboboxEh.SetListFieldName(const Value: String);
begin
  if FListFieldName <> Value then
  begin
    FListFieldName := Value;
    FDataList.ListField := Value;
    UpdateListFields;
  end;
end;

type
  TWinControlCracker = class(TWinControl) end;

procedure TCustomDBLookupComboboxEh.SetListSource(Value: TDataSource);
begin
  CheckNotLookup;
  //FListLink.DataSource := Value;
  FListSource := Value;
  UpdateListLinkDataSource;
  if csDesigning in ComponentState then //for columns editor
  begin
    FDataList.ListSource := Value;
    if Value <> nil then
{$IFDEF CIL}
      SendNotification(Value, FDataList, opRemove);
{$ELSE}
      TWinControlCracker(Value).Notification(FDataList, opRemove);
{$ENDIF}
      //Value.RemoveFreeNotification(FDataList);
  end;
  if Value <> nil then Value.FreeNotification(Self);
end;

procedure TCustomDBLookupComboboxEh.SetLookupMode(Value: Boolean);
begin
  if FLookupMode <> Value then
    if Value then
    begin
      FMasterFields := GetFieldsProperty(FDataFields[0].DataSet, Self, FDataFields[0].KeyFields);
      FLookupSource.DataSet := FDataFields[0].LookupDataSet;
      FKeyFieldName := FDataFields[0].LookupKeyFields;
      FLookupMode := True;
//      FListLink.DataSource := FLookupSource;
      FListLink.DataSource := UsedListSource;
      if csDesigning in ComponentState then //for columns editor
        FDataList.ListSource := FLookupSource;
    end else
    begin
      FListLink.DataSource := nil;
      if csDesigning in ComponentState then //for columns editor
        FDataList.ListSource := nil;
      FLookupMode := False;
      FKeyFieldName := '';
      FLookupSource.DataSet := nil;
      FMasterFields := FDataFields;
    end;
end;

procedure TCustomDBLookupComboboxEh.WMKillFocus(var Message: TWMKillFocus);
begin
  if FListVisible and not (Message.FocusedWnd = FDataList.Handle) then
    CloseUp(False);
  inherited;
end;

{procedure TCustomDBLookupComboboxEh.ListMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    CloseUp(PtInRect(FDataList.ClientRect, Point(X, Y)));
end;}

procedure TCustomDBLookupComboboxEh.ListMouseCloseUp(Sender: TObject; Accept: Boolean);
begin
  CloseUp(Accept);
end;

procedure TCustomDBLookupComboboxEh.DropDown;
var
  P: TPoint;
  I: Integer;
  S: String;
  ADropDownAlign: TDropDownAlign;
begin
  if not FListVisible and ListActive then
  begin
    if not FFocused then SetFocus;
    if not Focused then Exit;
    if Assigned(FOnDropDown) then FOnDropDown(Self);
    FDataList.KeyValue := Null;
    FDataList.SpecRow := DropDownBox.SpecRow;
    FDataList.Color := Color;
    FDataList.Font := Font;
    FDataList.ShowTitles := FDropDownBox.ShowTitles;
    FDataList.UseMultiTitle := FDropDownBox.UseMultiTitle;

    FDataList.ReadOnly := not CanModify(False);
    if ListLink.DataSet.IsSequenced and
      (ListLink.DataSet.RecordCount > 0) and
      (FDropDownBox.Rows > ListLink.DataSet.RecordCount) then
      FDataList.RowCount := ListLink.DataSet.RecordCount else
      FDataList.RowCount := FDropDownBox.Rows;
    FDataList.KeyField := FKeyFieldName;
    for I := 0 to ListFields.Count - 1 do
      S := S + TField(ListFields[I]).FieldName + ';';
    FDataList.ListField := S;
    FDataList.ListFieldIndex := ListFields.IndexOf(FListField);
    FDataList.AutoFitColWidths := False;
    FDataList.ListSource := ListLink.DataSource;
    if (FDropDownBox.Width = -1) then
      FDataList.ClientWidth := FDataList.GetColumnsWidthToFit
    else if FDropDownBox.Width > 0 then
      FDataList.Width := FDropDownBox.Width
    else
      FDataList.Width := Width;
    if (FDataList.Width < Width) then
      FDataList.Width := Width;
    //FDataList.Columns.State := csCustomized;
    FDataList.AutoFitColWidths := FDropDownBox.AutoFitColWidths;
    FDataList.KeyValue := KeyValue;
    FDataList.ReadOnly := not CanModify(False);
    FListColumnMothed := False;
    DataList.OnColumnMoved := ListColumnMoved;
    ADropDownAlign := FDropDownBox.Align;
    { This alignment is for the ListField, not the control }
    if DBUseRightToLeftAlignment(Self, FListField) then
    begin
      if ADropDownAlign = daLeft then
        ADropDownAlign := daRight
      else if ADropDownAlign = daRight then
        ADropDownAlign := daLeft;
    end;
    {case ADropDownAlign of
      daRight: Dec(P.X, FDataList.Width - Width);
      daCenter: Dec(P.X, (FDataList.Width - Width) div 2);
    end;}
    P := AlignDropDownWindow(Self, FDataList, ADropDownAlign);
    SetWindowPos(FDataList.Handle, HWND_TOP {MOST}, P.X, P.Y, 0, 0,
      SWP_NOSIZE or SWP_NOACTIVATE or SWP_SHOWWINDOW);
    FDataList.Visible := True; //???
    FDataList.SizeGrip.Visible := FDropDownBox.Sizable;
    FDataList.RowCount := FDataList.RowCount; //To update row count for horz scroll bar
//    FDataList.UpdateScrollBar;
    FListVisible := True;
    Repaint;
    FDataList.SizeGripResized := False;
    inherited DropDown;
    FDroppedDown := True;
  end;
//  else CloseUp(False);
end;

procedure TCustomDBLookupComboboxEh.CloseUp(Accept: Boolean);
var
  ListValue: Variant;
begin
  if FListVisible then
  begin
    if GetCapture <> 0 then SendMessage(GetCapture, WM_CANCELMODE, 0, 0);
    //SetFocus;
    ListValue := FDataList.KeyValue;
    SetWindowPos(FDataList.Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or
      SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
    FDataList.Visible := False; //???
    FListVisible := False;
    if FDataList.SizeGripResized then
    begin
      DropDownBox.Rows := FDataList.RowCount;
      DropDownBox.Width := FDataList.Width;
    end;
    DataList.OnColumnMoved := nil;
    FDataList.AutoFitColWidths := False;
    FDataList.ListSource := nil;
    if FListColumnMothed then
    begin
      if FDataList.Columns.State = csDefault then
      begin
        ListFieldIndex := FDataList.ListFieldIndex;
        ListField := FDataList.ListField;
      end;
      DropDownBox.SpecRow.CellsText := FDataList.SpecRow.CellsText;
    end;
    Invalidate;
    FDroppedDown := False;
    inherited CloseUp(Accept);
    if Accept and CanModify(True) then
    begin
      SetKeyValue(ListValue); //??? SelectKeyValue(ListValue);
      if DropDownBox.SpecRow.Visible then
        if DropDownBox.SpecRow.LocateKey(FKeyValue) or
          (DropDownBox.SpecRow.ShowIfNotInKeyList and not LocateKey)
          then
          SetEditText(DropDownBox.SpecRow.CellText[ListFieldIndex]);
      SelectAll;
    end;
    if (Style = csDropDownEh) and HandleAllocated then SelectAll;
    {else if FEditTextFromDataList then
    begin
      FEditTextFromDataList := False;
      SetEditText(FEditTextOldValue);
      SelectAll;
    end};
    if Assigned(FOnCloseUp) then FOnCloseUp(Self, Accept);
  end;
end;

procedure TCustomDBLookupComboboxEh.WMSetCursor(var Message: TWMSetCursor);
var
  P: TPoint;
begin
  GetCursorPos(P);
  P := ScreenToClient(P);
  if (Style = csDropDownListEh) then Windows.SetCursor(LoadCursor(0, idc_Arrow))
  else inherited;
end;

function TCustomDBLookupComboboxEh.TraceMouseMoveForPopupListbox(Sender: TObject;
  Shift: TShiftState; X, Y: Integer): Boolean;
var
  ListPos: TPoint;
  MousePos: TSmallPoint;
begin
  Result := False;
  if FListVisible and (GetCaptureControl = Sender) then
  begin
    ListPos := FDataList.ScreenToClient(TControl(Sender).ClientToScreen(Point(X, Y)));
    if PtInRect(FDataList.DataRect, ListPos) then
    begin
      TControl(Sender).Perform(WM_CANCELMODE, 0, 0);
      MousePos := PointToSmallPoint(ListPos);
      SendMessage(FDataList.Handle, WM_LBUTTONDOWN, 0, SmallPointToInteger(MousePos));
      Result := True;
    end;
  end;
end;

procedure TCustomDBLookupComboboxEh.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  if (Button = mbLeft) and (Style = csDropDownListEh) and not (ssDouble in Shift)  and
    not PtInRect(ButtonRect, Point(X, Y)) and ButtonEnabled and not FDroppedDown then
  begin
    FNoClickCloseUp := True;
    DropDown;
  end;
end;

procedure TCustomDBLookupComboboxEh.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  if TraceMouseMoveForPopupListbox(Self, Shift, X, Y) then
    Exit;
  inherited MouseMove(Shift, X, Y);
end;

procedure TCustomDBLookupComboboxEh.EditButtonMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  ListPos: TPoint;
  MousePos: TSmallPoint;
begin
  if FListVisible and (GetCaptureControl = Sender) and
    (Sender = FEditButtonControlList[0].EditButtonControl) then
  begin
    ListPos := FDataList.ScreenToClient(TControl(Sender).ClientToScreen(Point(X, Y)));
    if PtInRect(FDataList.DataRect, ListPos) then
    begin
      TControl(Sender).Perform(WM_CANCELMODE, 0, 0);
      MousePos := PointToSmallPoint(ListPos);
      SendMessage(FDataList.Handle, WM_LBUTTONDOWN, 0, SmallPointToInteger(MousePos));
    end;
  end;
end;

procedure TCustomDBLookupComboboxEh.Click;
begin
  inherited Click;
  if ButtonEnabled and FDroppedDown and not FNoClickCloseUp and
    (Style = csDropDownListEh)
    then CloseUp(False);
  FNoClickCloseUp := False;
end;

procedure TCustomDBLookupComboboxEh.CMCancelMode(var Message: TCMCancelMode);
  function CheckDataListChilds: Boolean;
  var i: Integer;
  begin
    Result := False;
    if FDataList <> nil then
      for i := 0 to FDataList.ControlCount - 1 do
        if FDataList.Controls[I] = Message.Sender then
        begin
          Result := True;
          Exit;
        end;
  end;
begin
  if (Message.Sender <> Self) and not ContainsControl(Message.Sender) and
    (Message.Sender <> FDataList) and not CheckDataListChilds
{and (Message.Sender <> FEditSpeedButton)}then
    CloseUp(False);
end;

procedure TCustomDBLookupComboboxEh.InternalSetText(AText: String);
begin
  if FKeyTextIndependent then
    SetEditText(AText)
  else
  begin
    if Style = csDropDownEh then SetEditText(AText);
    LocateStr(AText, False);
  end;
end;

procedure TCustomDBLookupComboboxEh.InternalSetValue(AValue: Variant);
begin
  SetKeyValue(AValue);
end;

procedure TCustomDBLookupComboboxEh.SetEditText(Value: String);
begin
  FInternalTextSetting := True;
  try
    inherited InternalSetText(Value);
  finally
    FInternalTextSetting := False;
  end;
end;

procedure TCustomDBLookupComboboxEh.CMWantSpecialKey(var Message: TCMWantSpecialKey);
begin
  if (Message.CharCode in [VK_RETURN, VK_ESCAPE]) and FListVisible then
  begin
    //CloseUp(Message.CharCode = VK_RETURN);
    Message.Result := 1;
  end else
    inherited;
end;

//type
//  TDBLookupListBoxCra cker = class(TDBLookupGridEh) end;

procedure TCustomDBLookupComboboxEh.KeyDown(var Key: Word; Shift: TShiftState);
  function MasterFieldsRequired: Boolean;
  var i: Integer;
  begin
    Result := False;
    for i := 0 to Length(FMasterFields) - 1 do
      if FMasterFields[i].Required then
      begin
        Result := True;
        Exit;
      end;
  end;
begin
  inherited KeyDown(Key, Shift);
  if ListActive and DropDownBox.SpecRow.Visible and
    (DropDownBox.SpecRow.ShortCut = ShortCut(Key, Shift)) then
  begin
    SetKeyValue(DropDownBox.SpecRow.Value);
    SetEditText(DropDownBox.SpecRow.CellText[ListFieldIndex]);
    SelectAll;
    Key := 0;
  end;
  if ListActive and ((Key = VK_UP) or (Key = VK_DOWN)) then
    {if ssAlt in Shift then
    begin
      if FListVisible then CloseUp(True) else DropDown;
      Key := 0;
    end else}
    if CanModify(True) then
      if not FListVisible then
      begin
        SelectNextValue(Key = VK_UP);
        Key := 0;
      end;
  if (Key <> 0) and FListVisible and ((Key in [VK_UP, VK_DOWN, VK_PRIOR, VK_NEXT, VK_CONTROL]) or
    ((Key in [VK_HOME, VK_END]) and (ssCtrl in Shift))) then
  begin
    FDataList.KeyDown(Key, Shift);
    Key := 0;
  end;
  if (Key = VK_DELETE) and (Style = csDropDownListEh) and CanModify(True) then
  begin
    if (SelLength = Length(Text)) and (Length(FMasterFields) > 0) or not MasterFieldsRequired then
    begin
      SetKeyValue(Null);
      SetEditText('');
    end;
    Key := 0;
  end;
end;

procedure TCustomDBLookupComboboxEh.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited KeyUp(Key, Shift);
  if FListVisible and (Key = VK_CONTROL) then
    FDataList.KeyUp(Key, Shift);
end;

procedure TCustomDBLookupComboboxEh.KeyPress(var Key: Char);
begin
  if FListVisible and CharInSetEh(Key, [#13, #27]) then
  begin
    CloseUp(Key = #13);
    Key := #0;
  end;
  inherited KeyPress(Key);
  case Key of
    #8:
      if (Style = csDropDownListEh) then
      begin
        ProcessSearchStr(Key);
        Key := #0;
      end;
    {#13:
    begin
      Key := #0;
      FDataLink.UpdateRecord;
      SelectAll;
    end;}
    #32..High(Char):
      begin
        if DropDownBox.AutoDrop and not FListVisible and FListActive then DropDown;
        if (Style = csDropDownListEh) then
        begin
          ProcessSearchStr(GetCompleteKeyPress);
          Key := #0;
        end;
      end;
  end;
end;

procedure TCustomDBLookupComboboxEh.DataListKeyValueChanged(Sender: TObject);
begin
end;

procedure TCustomDBLookupComboboxEh.DefaultHandler(var Message);
var
  Msg: TMessage;
begin
  VarToMessage(Message, Msg);
{$IFDEF CIL}
  with TWMMouse.Create(Msg) do
{$ELSE}
  with TWMMouse(Message) do
{$ENDIF}
    case Msg of
      WM_LBUTTONDBLCLK, WM_LBUTTONDOWN, WM_LBUTTONUP,
        WM_MBUTTONDBLCLK, WM_MBUTTONDOWN, WM_MBUTTONUP,
        WM_RBUTTONDBLCLK, WM_RBUTTONDOWN, WM_RBUTTONUP:
        if (Style = csDropDownListEh) or PtInRect(ButtonRect, Point(XPos, YPos)) then
        begin
          if Msg = WM_RBUTTONUP then
            Perform(WM_CONTEXTMENU, Handle,
              SmallPointToInteger(PointToSmallPoint(ClientToScreen(Point(XPos, YPos))))
            );
          Exit;
        end;
    end;
  inherited DefaultHandler(Message);
end;

function TCustomDBLookupComboboxEh.GetListFieldsWidth: Integer;
var
  DC: HDC;
  SaveFont: HFont;
  Metrics: TTextMetric;
  NullSize: TSize;
  i: Integer;
begin
  DC := GetDC(0);
  try
    SaveFont := SelectObject(DC, Font.Handle);
    GetTextMetrics(DC, Metrics);
    GetTextExtentPoint32(DC, '0', 1, NullSize);
    SelectObject(DC, SaveFont);

    Result := 0;
    for i := 0 to ListFields.Count - 1 do
      Inc(Result, TField(ListFields[i]).DisplayWidth * (NullSize.cX - Metrics.tmOverhang) + Metrics.tmOverhang + 4);
  finally
    ReleaseDC(0, DC);
  end
end;

function TCustomDBLookupComboboxEh.GetVariantValue: Variant;
begin
  Result := FKeyValue;
//  if FKeyTextIndependent then inherited GetVariantValue
//  else Result := FKeyValue;
end;

function TCustomDBLookupComboboxEh.IsValidChar(InputChar: Char): Boolean;
begin
  if FListActive then Result := FListField.IsValidChar(InputChar)
  else Result := inherited IsValidChar(InputChar);
end;

procedure TCustomDBLookupComboboxEh.ActiveChanged;
begin
  inherited ActiveChanged;
  UpdateDataFields;
end;

procedure TCustomDBLookupComboboxEh.ButtonDown(IsDownButton: Boolean);
begin
  if (EditButton.Style in [ebsUpDownEh, ebsAltUpDownEh]) and (FDownButton <> 0) then
  begin
    if EditCanModify then
    begin
      SelectNextValue(FDownButton = 1);
    end;
  end else
    inherited ButtonDown(IsDownButton);
end;

procedure TCustomDBLookupComboboxEh.WMCut(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
  if Style = csDropDownEh then LocateStr(Text, False);
end;

procedure TCustomDBLookupComboboxEh.WMPaste(var Message: TMessage);
begin
  if ReadOnly then Exit;
  FDataLink.Edit;
  if Style = csDropDownEh then
  begin
    inherited;
    LocateStr(Text, False);
  end else
    if Clipboard.HasFormat(CF_TEXT) then
      ProcessSearchStr(Clipboard.AsText);
end;

procedure TCustomDBLookupComboboxEh.SetStyle(const Value: TDBLookupComboboxEhStyle);
begin
  FStyle := Value;
  UpdateReadOnly;
end;

procedure TCustomDBLookupComboboxEh.SelectAll;
begin
  SendMessage(Handle, EM_SETSEL, MAXINT, 0);
end;

procedure TCustomDBLookupComboboxEh.SelectNextValue(IsPrior: Boolean);
var Delta: Integer;
begin
  if CanModify(True) and ListLink.Active then
  begin
    if not LocateKey then
      ListLink.DataSet.First
    else
    begin
      if IsPrior then Delta := -1 else Delta := 1;
      ListLink.DataSet.MoveBy(Delta);
    end;
    SetKeyValue(FListLink.DataSet.FieldValues[FKeyFieldName]);
    if FFocused then SelectAll;
  end;
end;

procedure TCustomDBLookupComboboxEh.UpdateData;
var RecheckInList: Boolean;
begin
  if FListActive and Assigned(FOnNotInList) {and Focused} then
  begin
    RecheckInList := False;
    if not FListLink.DataSet.Locate(FListField.FieldName, Text, [loCaseInsensitive]) then
    begin
      FOnNotInList(Self, Text, RecheckInList);
      if RecheckInList and FListLink.DataSet.Locate(FListField.FieldName, Text, [loCaseInsensitive]) then
        SetKeyValue(FListLink.DataSet.FieldValues[FKeyFieldName]);
    end;
  end;
  ValidateEdit;
  if PostDataEvent then Exit;
  if DataIndepended and FListActive and not LocateKey and (Text <> '') and
    (Style = csDropDownEh) and not DropDownBox.SpecRow.Visible then
  begin
    TDataSourceLinkEh(FDataLink).FDataIndependentValueAsText := True;
    FDataLink.SetValue(Text);
  end else
  begin
    TDataSourceLinkEh(FDataLink).FDataIndependentValueAsText := False;
    FDataLink.SetValue(Value);
  end;
end;

procedure TCustomDBLookupComboboxEh.WMChar(var Message: TWMChar);
  function SpecialKey: Boolean;
  begin
    Result := (Message.CharCode = VK_DELETE) or
      ([ssCtrl, ssAlt] * KeyDataToShiftState(Message.KeyData) <> []);
  end;
var OldSelStart: Integer;
begin
  inherited;
  if (Style = csDropDownEh) and not SpecialKey and not (Message.CharCode = 0) then
    if not ((SelStart = Length(Text)) and (SelLength = 0)) or (Message.CharCode = VK_BACK) then
    begin
      OldSelStart := SelStart;
      if LocateStr(Text, False) then
      begin
        SelStart := Length(Text);
        SelLength := OldSelStart - SelStart;
      end;
    end else
      ProcessSearchStr('');
end;

procedure TCustomDBLookupComboboxEh.WMKeyDown(var Message: TWMKeyDown);
var OldSelStart: Integer;
begin
  if (Style = csDropDownEh) and (Message.CharCode = VK_DELETE) then
  begin
    FDataLink.Edit;
    inherited;
    OldSelStart := SelStart;
    if LocateStr(Text, False) then
    begin
      SelStart := Length(Text);
      SelLength := OldSelStart - SelStart;
    end;
  end
  else inherited;
end;

procedure TCustomDBLookupComboboxEh.SetDropDownBox(const Value: TLookupComboboxDropDownBoxEh);
begin
  FDropDownBox.Assign(Value);
end;

procedure TCustomDBLookupComboboxEh.EMReplacesel(var Message: TMessage);
var OldSelStart: Integer;
  S: String;
begin
  if Style = csDropDownListEh then
    S := Copy(Text, 1, SelStart) + IntPtrToString(Message.LParam) + Copy(Text, SelStart + SelLength + 1, Length(Text))
  else
  begin
    inherited;
    S := Text;
  end;

  OldSelStart := SelStart;
  if LocateStr(S, False) then
  begin
    SelStart := Length(Text);
    SelLength := OldSelStart - SelStart;
  end;
end;

procedure TCustomDBLookupComboboxEh.UpdateReadOnly;
begin
  SetControlReadOnly(not FDataLink.Editing{not CanModify(False)} or (Style = csDropDownListEh));
end;

procedure TCustomDBLookupComboboxEh.UpdateKeyTextIndependent;
begin
  if not FLockUpdateKeyTextIndependent then
    FKeyTextIndependent := (DataSource = nil) and (DataField = '') and
      (ListSource = nil) and (ListField = '') and (KeyField = '');
end;

procedure TCustomDBLookupComboboxEh.ClearDataProps;
begin
  FKeyTextIndependent := True;
  try
    FLockUpdateKeyTextIndependent := True;
    DataSource := nil;
    DataField := '';
    KeyField := '';
    ListField := '';
    ListSource := nil;
  finally
    FLockUpdateKeyTextIndependent := False;
    UpdateKeyTextIndependent;
  end;
end;

function TCustomDBLookupComboboxEh.GetDataLink: TDataSourceLinkEh;
begin
  Result := TDataSourceLinkEh(FDataLink);
end;

function TCustomDBLookupComboboxEh.GetDataField: TField;
begin
  if Length(FDataFields) = 0 then Result := nil
  else Result := FDataFields[0];
end;

function TCustomDBLookupComboboxEh.GetOnButtonClick: TButtonClickEventEh;
begin
  Result := inherited OnButtonClick;
end;

procedure TCustomDBLookupComboboxEh.SetOnButtonClick(const Value: TButtonClickEventEh);
begin
  if @Value <> @OnButtonClick then
  begin
    inherited OnButtonClick := Value;
    UpdateEditButtonControlsState; //UpdateButtonState;
  end;
end;

function TCustomDBLookupComboboxEh.GetOnButtonDown: TButtonDownEventEh;
begin
  Result := inherited OnButtonDown;
end;

procedure TCustomDBLookupComboboxEh.SetOnButtonDown(const Value: TButtonDownEventEh);
begin
  if @Value <> @OnButtonDown then
  begin
    inherited OnButtonDown := Value;
    UpdateEditButtonControlsState; //UpdateButtonState;
  end;
end;

procedure TCustomDBLookupComboboxEh.SpecRowChanged(Sender: TObject);
begin
  if not (csLoading in ComponentState) then
  begin
    DataChanged;
    UpdateListFields;
    FDataList.SpecRow := DropDownBox.SpecRow;
  end;
end;

procedure TCustomDBLookupComboboxEh.CMMouseWheel(var Message: TCMMouseWheel);
{$IFDEF CIL}
var
  Temp: TMessage;
{$ENDIF}
begin
{$IFDEF CIL}
  Temp := UnwrapMessage(Message);
  if FListVisible then
    with Temp do
      if FDataList.Perform(CM_MOUSEWHEEL, WParam, LParam) <> 0 then
begin
        Exit;
        Result := 1;
      end;
{$ELSE}
  if FListVisible then
    with TMessage(Message) do
      if FDataList.Perform(CM_MOUSEWHEEL, WParam, LParam) <> 0 then
      begin
        Exit;
        Result := 1;
      end;
{$ENDIF}
  inherited;
end;

function TCustomDBLookupComboboxEh.DoMouseWheelDown(Shift: TShiftState;
  MousePos: TPoint): Boolean;
begin
  Result := inherited DoMouseWheelDown(Shift, MousePos);
  if not Result and (Shift = []) and not ReadOnly and FDataLink.Edit then
  begin
    SelectNextValue(False);
    Result := True;
  end;
end;

function TCustomDBLookupComboboxEh.DoMouseWheelUp(Shift: TShiftState;
  MousePos: TPoint): Boolean;
begin
  Result := inherited DoMouseWheelUp(Shift, MousePos);
  if not Result and (Shift = []) and not ReadOnly and FDataLink.Edit then
  begin
    SelectNextValue(True);
    Result := True;
  end;
end;

function TCustomDBLookupComboboxEh.GetOnDropDownBoxCheckButton: TCheckTitleEhBtnEvent;
begin
  Result := FDataList.OnCheckButton;
end;

function TCustomDBLookupComboboxEh.GetOnDropDownBoxDrawColumnCell: TDrawColumnEhCellEvent;
begin
  Result := FDataList.OnDrawColumnCell;
end;

function TCustomDBLookupComboboxEh.GetOnDropDownBoxGetCellParams: TGetCellEhParamsEvent;
begin
  Result := FDataList.OnGetCellParams;
end;

function TCustomDBLookupComboboxEh.GetOnDropDownBoxSortMarkingChanged: TNotifyEvent;
begin
  Result := FDataList.OnSortMarkingChanged;
end;

function TCustomDBLookupComboboxEh.GetOnDropDownBoxTitleBtnClick: TTitleEhClickEvent;
begin
  Result := FDataList.OnTitleBtnClick;
end;

procedure TCustomDBLookupComboboxEh.SetOnDropDownBoxCheckButton(const Value: TCheckTitleEhBtnEvent);
begin
  FDataList.OnCheckButton := Value;
end;

procedure TCustomDBLookupComboboxEh.SetOnDropDownBoxDrawColumnCell(const Value: TDrawColumnEhCellEvent);
begin
  FDataList.OnDrawColumnCell := Value;
end;

procedure TCustomDBLookupComboboxEh.SetOnDropDownBoxGetCellParams(const Value: TGetCellEhParamsEvent);
begin
  FDataList.OnGetCellParams := Value;
end;

procedure TCustomDBLookupComboboxEh.SetOnDropDownBoxSortMarkingChanged(const Value: TNotifyEvent);
begin
  FDataList.OnSortMarkingChanged := Value;
end;

procedure TCustomDBLookupComboboxEh.SetOnDropDownBoxTitleBtnClick(const Value: TTitleEhClickEvent);
begin
  FDataList.OnTitleBtnClick := Value;
end;

procedure TCustomDBLookupComboboxEh.ListColumnMoved(Sender: TObject; FromIndex, ToIndex: Integer);
begin
  FListColumnMothed := True;
end;

procedure TCustomDBLookupComboboxEh.Loaded;
begin
  inherited Loaded;
  FDataList.SpecRow := DropDownBox.SpecRow;
end;

function TCustomDBLookupComboboxEh.GetLookupGrid: TCustomDBGridEh;
begin
  Result := FDataList;
end;

function TCustomDBLookupComboboxEh.GetOptions: TDBLookupGridEhOptions;
begin
  Result := FDataList.Options;
end;

procedure TCustomDBLookupComboboxEh.SetOptions(Value: TDBLookupGridEhOptions);
begin
  FDataList.Options := Value;
end;

function TCustomDBLookupComboboxEh.GetDisplayTextForPaintCopy: String;
begin
  if (csDesigning in ComponentState) and not (FDataLink.Active) then
    Result := Name
  else if (csPaintCopy in ControlState) and (FDataLink.Field <> nil) and FListlink.Active then
  begin
    if FListlink.DataSet.Locate(FKeyFieldName, FDataLink.DataSet.FieldValues[FMasterFieldNames], []) then
      Result := GetDisplayText(FListField)
    else
      Result := '';
  end else
    Result := EditText;
end;

function TCustomDBLookupComboboxEh.GetDisplayText(Field: TField): String;
begin
  if Field = nil then
    Result := ''
  else if Field.DataType in MemoTypes
    then Result := Field.AsString
    else Result := Field.DisplayText;
end;

procedure TCustomDBLookupComboboxEh.SetDropDownBoxListSource(AListSource: TDataSource);
begin
  if AListSource <> nil then AListSource.FreeNotification(Self);
end;

function TCustomDBLookupComboboxEh.CompatibleVarValue(AFieldsArr: TFieldsArrEh; AVlaue: Variant): Boolean;
begin
  Result := True;
  if Length(AFieldsArr) > 1 then
    Result := (VarArrayHighBound(AVlaue, 1) - VarArrayLowBound(AVlaue, 1) = Length(AFieldsArr)-1 );
{  Result := ((Length(AFieldsArr) = 1) and not VarIsArray(AVlaue)) or
            ((Length(AFieldsArr) > 1) and VarIsArray(AVlaue) and
             ( VarArrayHighBound(AVlaue, 1) - VarArrayLowBound(AVlaue, 1) = Length(AFieldsArr)-1 )
            );
}
end;

procedure TCustomDBLookupComboboxEh.SetFocused(Value: Boolean);
begin
  inherited SetFocused(Value);
  UpdateListLinkDataSource;
end;

end.
