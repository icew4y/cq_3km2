{*******************************************************}
{                                                       }
{                       EhLib v5.0                      }
{     TDBLookupGridEh, TPopupDataGridEh components      }
{                      Build 5.0.01                     }
{                                                       }
{      Copyright (c) 2002-2009 by Dmitry V. Bolshakov   }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit DBLookupGridsEh;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, GridsEh, DBGridEh, ToolCtrlsEh,
{$IFDEF CIL}
  EhLibVCLNET,
{$ELSE}
  EhLibVCL,
{$ENDIF}
{$IFDEF EH_LIB_5} Contnrs, {$ENDIF}
{$IFDEF EH_LIB_6}Variants, {$ENDIF}
  DB, {DBGrids, }Graphics, StdCtrls, Forms;

type

  TDBLookupGridEh = class;

{ TLookupGridDataLinkEh }

  TLookupGridDataLinkEh = class(TDataLink)
  private
    FDBLookupGrid: TDBLookupGridEh;
  protected
    procedure ActiveChanged; override;
{$IFDEF CIL}
    procedure FocusControl(const Field: TField); override;
{$ELSE}
    procedure FocusControl(Field: TFieldRef); override;
{$ENDIF}
    procedure LayoutChanged; override;
    procedure RecordChanged(Field: TField); override;
  public
    constructor Create;
  end;

{ TGridColumnSpecCellEh }

  TGridColumnSpecCellEh = class(TPersistent)
  private
    FOwner: TPersistent;
    FFont: TFont;
    FColor: TColor;
    FText: String;
    function GetColor: TColor;
    function GetFont: TFont;
    function GetText: String;
    function IsColorStored: Boolean;
    function IsFontStored: Boolean;
    function IsTextStored: Boolean;
    procedure FontChanged(Sender: TObject);
    procedure SetColor(const Value: TColor);
    procedure SetFont(const Value: TFont);
    procedure SetText(const Value: String);
  protected
    FColorAssigned: Boolean;
    FFontAssigned: Boolean;
    FTextAssigned: Boolean;
    function DefaultColor: TColor;
    function DefaultFont: TFont;
    function DefaultText: String;
    function GetOwner: TPersistent; override;
  public
    constructor Create(Owner: TPersistent);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Text: String read GetText write SetText stored IsTextStored;
    property Color: TColor read GetColor write SetColor stored IsColorStored;
    property Font: TFont read GetFont write SetFont stored IsFontStored;
  end;

{ TDBLookupGridColumnEh }

  TDBLookupGridColumnEh = class(TColumnEh)
  private
    FSpecCell: TGridColumnSpecCellEh;
    function GetGrid: TDBLookupGridEh;
    procedure SetSpecCell(const Value: TGridColumnSpecCellEh);
  protected
    procedure SetWidth(Value: Integer); override;
    procedure SetIndex(Value: Integer); override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    property Grid: TDBLookupGridEh read GetGrid;
  published
    property Alignment;
    property AutoFitColWidth;
    property Checkboxes;
    property Color;
    property EndEllipsis;
    property FieldName;
    property Font;
    property ImageList;
    property ImeMode;
    property ImeName;
    property KeyList;
    property MaxWidth;
    property MinWidth;
    property NotInKeyListIndex;
    property PickList;
    property PopupMenu;
    property ShowImageAndText;
    property SpecCell: TGridColumnSpecCellEh read FSpecCell write SetSpecCell;
    property Tag;
    property Title;
    property ToolTips;
    property Visible;
    property Width;
    property OnGetCellParams; // { TODO : Remove event. Grid.Columns doesn't have parent and IDE can create event. }
  end;

{ TDBLookupGridColumnDefValuesEh}

  TDBLookupGridColumnDefValuesEh = class(TColumnDefValuesEh)
  published
    property EndEllipsis;
    property Title;
    property ToolTips;
  end;

{ TDBLookupGridEh }

  TDBLookupGridEh = class(TCustomDBGridEh)
  private
    FDataFieldName: string;
    FDataFields: TFieldsArrEh;
    FDataLink: TLookupGridDataLinkEh;
    FHasFocus: Boolean;
    FKeyFieldName: string;
    FKeyFields: TFieldsArrEh;
    FKeyRowVisible: Boolean;
    FKeySelected: Boolean;
    FKeyValue: Variant;
    FListActive: Boolean;
    FListField: TField;
    FListFieldIndex: Integer;
    FListFieldName: string;
    FListFields: TObjectList;
    //FListLink: TLookupCtrlListLinkEh;
    FLockPosition: Boolean;
    FLookupMode: Boolean;
    FLookupSource: TDataSource;
    FMasterFieldNames: string;
    FMasterFields: TFieldsArrEh;
    FMousePos: Integer;
    FPopup: Boolean;
    FRecordCount: Integer;
    FRecordIndex: Integer;
    FRowCount: Integer;
    FSearchText: string;
    FSelectedItem: string;
    FSpecRow: TSpecRowEh;
    FOptions: TDBLookupGridEhOptions;
    function GetAutoFitColWidths: Boolean;
    function GetDataField: TField;
    function GetDataSource: TDataSource;
    function GetKeyFieldName: string;
    function GetListLink: TGridDataLinkEh;
    function GetListSource: TDataSource;
    function GetReadOnly: Boolean;
    function GetShowTitles: Boolean;
    function GetTitleRowHeight: Integer;
    function GetUseMultiTitle: Boolean;
    procedure CheckNotCircular;
    procedure CheckNotLookup;
    procedure CMRecreateWnd(var Message: TMessage); message CM_RECREATEWND;
    procedure CMHintShow(var Message: TCMHintShow); message CM_HINTSHOW;
    procedure DataLinkRecordChanged(Field: TField);
    procedure SelectCurrent;
    procedure SelectItemAt(X, Y: Integer);
    procedure SelectSpecRow;
    procedure SetAutoFitColWidths(const Value: Boolean);
    procedure SetDataFieldName(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetKeyFieldName(const Value: string);
    procedure SetKeyValue(const Value: Variant);
    procedure SetListFieldName(const Value: string);
    procedure SetListSource(Value: TDataSource);
    procedure SetLookupMode(Value: Boolean);
    procedure SetOptions(const Value: TDBLookupGridEhOptions);
    procedure SetReadOnly(Value: Boolean);
    procedure SetRowCount(Value: Integer);
    procedure SetShowTitles(const Value: Boolean);
    procedure SetSpecRow(const Value: TSpecRowEh);
    procedure SetUseMultiTitle(const Value: Boolean);
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMSetCursor(var Msg: TWMSetCursor); message WM_SETCURSOR;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;
  protected
    FSpecRowHeight: Integer;
    FLGAutoFitColWidths: Boolean;
    FInternalWidthSetting: Boolean;
    FInternalHeightSetting: Boolean;
    function CanDrawFocusRowRect: Boolean; override;
    function CanModify: Boolean; virtual;
    function CellHave3DRect(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState): Boolean; override;
    function CompatibleVarValue(AFieldsArr: TFieldsArrEh; AVlaue: Variant): Boolean; virtual;
    function CreateColumnDefValues: TColumnDefValuesEh; override;
    function CreateColumns: TDBGridColumnsEh; override;
    function DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function GetBorderSize: Integer; virtual;
    function GetKeyIndex: Integer;
    function GetSpecRowHeight: Integer; virtual;
    function GetSubTitleRows: Integer; override;
    function GetDataRowHeight: Integer; virtual;
    procedure ColWidthsChanged; override;
    procedure CreateWnd; override;
    procedure DataChanged; override;
    procedure DefineFieldMap; override;
    procedure DrawSubTitleCell(ACol, ARow: Longint;  DataCol, DataRow: Integer;
      CellType: TCellAreaTypeEh; ARect: TRect; AState: TGridDrawState; var Highlighted: Boolean); override;
    procedure GetDatasetFieldList(FieldList: TList); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyValueChanged; virtual;
    procedure LayoutChanged; override;
    procedure ListLinkDataChanged; virtual;
    procedure LinkActive(Value: Boolean); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure ProcessSearchKey(Key: Char); virtual;
//    procedure RowHeightsChanged; override;
    procedure Scroll(Distance: Integer); override;
    procedure SelectKeyValue(const Value: Variant); virtual;
    procedure SpecRowChanged(Sender: TObject); virtual;
    procedure TimerScroll; override;
    procedure UpdateActive; override;
    procedure UpdateColumnsList; virtual;
    procedure UpdateDataFields; virtual;
    procedure UpdateListFields; virtual;
    procedure UpdateRowCount; override;
    procedure UpdateScrollBar; override;
    property HasFocus: Boolean read FHasFocus;
    property ParentColor default False;
    property TitleRowHeight: Integer read GetTitleRowHeight;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function DataRect: TRect;
    function GetColumnsWidthToFit: Integer;
    function HighlightDataCellColor(DataCol, DataRow: Integer; const Value: string;
      AState: TGridDrawState; var AColor: TColor; AFont: TFont): Boolean; override;
    function LocateKey: Boolean; virtual;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    property AutoFitColWidths: Boolean read GetAutoFitColWidths write SetAutoFitColWidths;
    property DataField: string read FDataFieldName write SetDataFieldName;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property Field: TField read GetDataField;
    property KeyField: string read GetKeyFieldName write SetKeyFieldName;
    property KeyValue: Variant read FKeyValue write SetKeyValue;
    property ListActive: Boolean read FListActive;
    property ListField: string read FListFieldName write SetListFieldName;
    property ListFieldIndex: Integer read FListFieldIndex write FListFieldIndex default 0;
    property ListFields: TObjectList read FListFields;
    property ListLink: TGridDataLinkEh read GetListLink;
    property ListSource: TDataSource read GetListSource write SetListSource;
    property Options: TDBLookupGridEhOptions read FOptions write SetOptions
      default [dlgColLinesEh];
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property SearchText: string read FSearchText write FSearchText;
    property SelectedItem: String read FSelectedItem;
    property SpecRow: TSpecRowEh read FSpecRow write SetSpecRow;
    property ShowTitles: Boolean read GetShowTitles write SetShowTitles;
    property RowCount: Integer read FRowCount write SetRowCount stored False;
    property Color;
    property UseMultiTitle: Boolean read GetUseMultiTitle write SetUseMultiTitle;
    property OnClick;
    property OnColumnMoved;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  end;

{ TPopupDataGridEh }
  TPopupDataGridEh = class(TDBLookupGridEh)
  private
    FOnMouseCloseUp: TCloseUpEventEh;
    FOnUserKeyValueChange: TNotifyEvent;
    FSizeGrip: TSizeGripEh;
    FSizeGripResized: Boolean;
    FUserKeyValueChanged: Boolean;
    FKeySelection: Boolean;
    function CheckNewSize(var NewWidth, NewHeight: Integer): Boolean;
    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
    procedure CMSetSizeGripChangePosition(var Message: TMessage); message cm_SetSizeGripChangePosition;
    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBKGND;
    procedure WMMouseActivate(var Message: TWMMouseActivate); message WM_MOUSEACTIVATE;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMWindowPosChanging(var Message: TWMWindowPosChanging); message WM_WINDOWPOSCHANGING;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DrawBorder; override;
    procedure KeyValueChanged; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure UpdateBorderWidth;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function CanFocus: Boolean; {$IFDEF EH_LIB_5} override; {$ENDIF}
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    property Ctl3D;
    property ParentCtl3D;
    property SizeGrip: TSizeGripEh read FSizeGrip;
    property SizeGripResized: Boolean read FSizeGripResized write FSizeGripResized;
    property OnDrawColumnCell;
    property OnUserKeyValueChange: TNotifyEvent read FOnUserKeyValueChange write FOnUserKeyValueChange;
    property OnMouseCloseUp: TCloseUpEventEh read FOnMouseCloseUp write FOnMouseCloseUp;
  end;

implementation

uses DBConsts{$IFDEF EH_LIB_6}, VDBConsts, Types{$ENDIF};

var
  SearchTickCount: Integer = 0;

function iif(Condition: Boolean; V1, V2: Integer): Integer;
begin
  if (Condition) then Result := V1 else Result := V2;
end;

{ TLookupGridDataLinkEh }

constructor TLookupGridDataLinkEh.Create;
begin
  inherited Create;
end;

procedure TLookupGridDataLinkEh.ActiveChanged;
begin
  if FDBLookupGrid <> nil then FDBLookupGrid.UpdateDataFields;
end;

{$IFDEF CIL}
procedure TLookupGridDataLinkEh.FocusControl(const Field: TField);
begin
  if (Field <> nil) and (Field = FDBLookupGrid.Field) and
    (FDBLookupGrid <> nil) and FDBLookupGrid.CanFocus then
  begin
    FDBLookupGrid.SetFocus;
  end;
end;
{$ELSE}
procedure TLookupGridDataLinkEh.FocusControl(Field: TFieldRef);
begin
  if (Field^ <> nil) and (Field^ = FDBLookupGrid.Field) and
    (FDBLookupGrid <> nil) and FDBLookupGrid.CanFocus then
  begin
    Field^ := nil;
    FDBLookupGrid.SetFocus;
  end;
end;
{$ENDIF}

procedure TLookupGridDataLinkEh.LayoutChanged;
begin
  if FDBLookupGrid <> nil then FDBLookupGrid.UpdateDataFields;
end;

procedure TLookupGridDataLinkEh.RecordChanged(Field: TField);
begin
  if FDBLookupGrid <> nil then FDBLookupGrid.DataLinkRecordChanged(Field);
end;

{ TGridColumnSpecCellEh }

constructor TGridColumnSpecCellEh.Create(Owner: TPersistent);
begin
  inherited Create;
  FOwner := Owner;
  FFont := TFont.Create;
  FFont.Assign(DefaultFont);
  FFont.OnChange := FontChanged;
end;

destructor TGridColumnSpecCellEh.Destroy;
begin
  FreeAndNil(FFont);
  inherited;
end;

function TGridColumnSpecCellEh.DefaultColor: TColor;
begin
  if Assigned(FOwner) and (FOwner is TDBLookupGridColumnEh) and
    Assigned((TDBLookupGridColumnEh(FOwner)).Grid)
    then with TDBLookupGridColumnEh(FOwner) do
      Result := GetGrid.SpecRow.Color
  else Result := FColor;
end;

function TGridColumnSpecCellEh.DefaultFont: TFont;
begin
  if Assigned(FOwner) and (FOwner is TDBLookupGridColumnEh) and
    Assigned(TDBLookupGridColumnEh(FOwner).Grid)
    then with TDBLookupGridColumnEh(FOwner) do
      Result := GetGrid.SpecRow.Font
  else Result := FFont;
end;

function TGridColumnSpecCellEh.DefaultText: String;
begin
  if Assigned(FOwner) and (FOwner is TDBLookupGridColumnEh) and
    Assigned(TDBLookupGridColumnEh(FOwner).Grid)
    then with TDBLookupGridColumnEh(FOwner) do
      Result := GetGrid.SpecRow.CellText[Index]
  else Result := FText;
end;

function TGridColumnSpecCellEh.GetColor: TColor;
begin
  if not FColorAssigned
    then Result := DefaultColor
    else Result := FColor;
end;

function TGridColumnSpecCellEh.GetFont: TFont;
var
  Save: TNotifyEvent;
begin
  if not FFontAssigned and (FFont.Handle <> DefaultFont.Handle) then
  begin
    Save := FFont.OnChange;
    FFont.OnChange := nil;
    FFont.Assign(DefaultFont);
    FFont.OnChange := Save;
  end;
  Result := FFont;
end;

procedure TGridColumnSpecCellEh.FontChanged(Sender: TObject);
begin
  FFontAssigned := True;
end;

function TGridColumnSpecCellEh.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

function TGridColumnSpecCellEh.GetText: String;
begin
  if not FTextAssigned
    then Result := DefaultText
    else Result := FText;
end;

function TGridColumnSpecCellEh.IsColorStored: Boolean;
begin
  Result := FColorAssigned;
end;

function TGridColumnSpecCellEh.IsFontStored: Boolean;
begin
  Result := FFontAssigned;
end;

function TGridColumnSpecCellEh.IsTextStored: Boolean;
begin
  Result := FTextAssigned;
end;

procedure TGridColumnSpecCellEh.SetColor(const Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    FColorAssigned := True;
  end;
end;

procedure TGridColumnSpecCellEh.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TGridColumnSpecCellEh.SetText(const Value: String);
begin
  if FText <> Value then
  begin
    FText := Value;
    FTextAssigned := True;
  end;
end;

procedure TGridColumnSpecCellEh.Assign(Source: TPersistent);
begin
  if Source is TGridColumnSpecCellEh then
  begin
    Text := TGridColumnSpecCellEh(Source).Text;
    Color := TGridColumnSpecCellEh(Source).Color;
    if TGridColumnSpecCellEh(Source).FFontAssigned then
      Font := TGridColumnSpecCellEh(Source).Font;
  end else
    inherited Assign(Source);
end;

{ TDBLookupGridColumnEh }

constructor TDBLookupGridColumnEh.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FSpecCell := TGridColumnSpecCellEh.Create(Self);
end;

destructor TDBLookupGridColumnEh.Destroy;
begin
  FreeAndNil(FSpecCell);
  inherited Destroy;
end;

function TDBLookupGridColumnEh.GetGrid: TDBLookupGridEh;
begin
  Result := TDBLookupGridEh(inherited Grid);
end;

procedure TDBLookupGridColumnEh.SetIndex(Value: Integer);
var i: Integer;
  s: String;

  procedure SetSpecCell;
  var ss: TStringList;
    i: Integer;
  begin
    with Grid as TDBLookupGridEh do
    begin
      ss := TStringList.Create;
      try
        for i := 0 to Columns.Count - 1 do
          ss.Add(SpecRow.CellText[i]);
        ss.Move(Index, Value);
        s := '';
        for i := 0 to Columns.Count - 1 do
          s := s + ss[i] + ';';
        Delete(s, Length(s), 1);
        SpecRow.CellsText := s;
      finally
        ss.Free;
      end;
    end;
  end;

begin
  with Grid as TDBLookupGridEh do
  begin
    if SeenPassthrough and DataLink.Active and (Index <> Value) then
    begin
      BeginUpdate;
      try
        if Index = ListFieldIndex then
          ListFieldIndex := Value
        else
        begin
          if ListFieldIndex > Index then
            ListFieldIndex := ListFieldIndex - 1;
          if ListFieldIndex >= Value then
            ListFieldIndex := ListFieldIndex + 1;
        end;
        SetSpecCell;
        IsStored := True;
        try
          inherited SetIndex(Value);
        finally
          IsStored := False;
        end;
        s := '';
        for i := 0 to Columns.Count - 1 do
          s := s + Columns[i].Field.FieldName + ';';
        Delete(s, Length(s), 1);
        ListField := s;
      finally
        EndUpdate;
      end;
    end else
    begin
      if DataLink.Active and (Index <> Value) then
        SetSpecCell;
      inherited SetIndex(Value);
    end;
  end
end;

procedure TDBLookupGridColumnEh.SetSpecCell(const Value: TGridColumnSpecCellEh);
begin
  FSpecCell.Assign(Value);
end;

procedure TDBLookupGridColumnEh.SetWidth(Value: Integer);
begin
  if SeenPassthrough then
  begin
    IsStored := True;
    try
      inherited SetWidth(Value);
    finally
      IsStored := False;
    end;
  end else
    inherited SetWidth(Value);
end;

{ TDBLookupGridEh }

constructor TDBLookupGridEh.Create(AOwner: TComponent);
begin
//  inherited CreateNew(AOwner,0);
{$IFDEF CIL}
{$ELSE}
  FNoDesigntControler := True;
{$ENDIF}
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable]; //Really not Replicatable, only for CtrlGrid
//  if NewStyleControls
//    then ControlStyle := [csOpaque]
//    else ControlStyle := [csOpaque, csFramed];
  ParentColor := False;
  TabStop := True;
  FLookupSource := TDataSource.Create(Self);
  FDataLink := TLookupGridDataLinkEh.Create;
  FDataLink.FDBLookupGrid := Self;
  FListFields := TObjectList.Create(False);
  FKeyValue := Null;
  FSpecRow := TSpecRowEh.Create(Self);
  FSpecRow.OnChanged := SpecRowChanged;
  inherited Options := [dgColLines, dgRowSelect];
  OptionsEh := OptionsEh + [dghTraceColSizing];
  FOptions := [dlgColLinesEh];
  HorzScrollBar.Tracking := True;
  VertScrollBar.Tracking := True;
  Flat := True;
  //UseMultiTitle := True;
  ReadOnly := True;
  DrawMemoText := True;
  TabStop := False;
  FLGAutoFitColWidths := False;
  //HorzScrollBar.Visible := True;
  VTitleMargin := 5;
  ReadOnly := False;
//  TryUseMemTableInt := False;
end;

destructor TDBLookupGridEh.Destroy;
begin
  FreeAndNil(FSpecRow);
  FreeAndNil(FListFields);
//  FListFields := nil;
  FDataLink.FDBLookupGrid := nil;
  FreeAndNil(FDataLink);
//  FDataLink := nil;
  inherited Destroy;
end;

function TDBLookupGridEh.CanModify: Boolean;
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
  Result := FListActive and not ReadOnly and ((FDataLink.DataSource = nil) or
    (Length(FMasterFields) <> 0) and MasterFieldsCanModify);
end;

procedure TDBLookupGridEh.CheckNotCircular;
begin
  if ListLink.Active and ListLink.DataSet.IsLinkedTo(DataSource) then
    DatabaseError(SCircularDataLink);
end;

procedure TDBLookupGridEh.CheckNotLookup;
begin
  if FLookupMode then DatabaseError(SPropDefByLookup);
  if FDataLink.DataSourceFixed then DatabaseError(SDataSourceFixed);
end;

procedure TDBLookupGridEh.UpdateDataFields;
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
  //FDataField := nil;
  //FMasterField := nil;
  FMasterFieldNames := '';
  if FDataLink.Active and (FDataFieldName <> '') then
  begin
    CheckNotCircular;
    FDataFields := GetFieldsProperty(FDataLink.DataSet, Self, FDataFieldName);
    if (Length(FDataFields) = 1) and (FDataFields[0].FieldKind = fkLookup)
      then FMasterFields := GetFieldsProperty(FDataLink.DataSet, Self, FDataFields[0].KeyFields)
      else FMasterFields := FDataFields;
    FMasterFieldNames := MasterFieldNames;
  end;
  SetLookupMode((Length(FDataFields) = 1) and (FDataFields[0].FieldKind = fkLookup));
  DataLinkRecordChanged(nil);
end;

procedure TDBLookupGridEh.DataLinkRecordChanged(Field: TField);
  function FieldFound(Value: TField): Boolean;
  var i: Integer;
  begin
    Result := False;
    for i := 0 to Length(FMasterFields) - 1 do
      if FMasterFields[i] = Value then
      begin
        Result := True;
        Exit;
      end;
  end;
begin
  if (Field = nil) or FieldFound(Field) then
    if Length(FMasterFields) > 0
      then SetKeyValue(FDataLink.DataSet.FieldValues[FMasterFieldNames])
      else SetKeyValue(Null);
end;

function TDBLookupGridEh.GetBorderSize: Integer;
//var
//  Params: TCreateParams;
//  R: TRect;
begin
  Result := 0;
  if not HandleAllocated then Exit;
  Result := Height - ClientHeight;
  {CreateParams(Params);
  SetRect(R, 0, 0, 0, 0);
  AdjustWindowRectEx(R, Params.Style, False, Params.ExStyle);
  Result := R.Bottom - R.Top; // + FBorderWidth*2;
  }
end;

function TDBLookupGridEh.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

function TDBLookupGridEh.GetKeyFieldName: string;
begin
  if FLookupMode then Result := '' else Result := FKeyFieldName;
end;

function TDBLookupGridEh.GetListSource: TDataSource;
begin
  if FLookupMode then Result := nil else Result := ListLink.DataSource;
end;

function TDBLookupGridEh.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

function TDBLookupGridEh.GetDataRowHeight: Integer;
begin
  Result := DefaultRowHeight;
  if dgRowLines in inherited Options then Inc(Result, GridLineWidth);
end;

function TDBLookupGridEh.GetSpecRowHeight: Integer;
{var
  DC: HDC;
  SaveFont: HFont;
  Metrics: TTextMetric;}
begin
  Result := DefaultRowHeight;
  if dgRowLines in inherited Options then Inc(Result, GridLineWidth);
  {Result := 0;
  if not Assigned(SpecRow) then Exit;
  DC := GetDC(0);
  SaveFont := SelectObject(DC, SpecRow.Font.Handle);
  GetTextMetrics(DC, Metrics);
  SelectObject(DC, SaveFont);
  ReleaseDC(0, DC);
  Result := Metrics.tmHeight;}
end;

procedure TDBLookupGridEh.KeyValueChanged;
begin
  if not SpecRow.Visible then
    SpecRow.Selected := False
  else
  begin
    SpecRow.Selected := VarEquals(FKeyValue, SpecRow.Value);
    if not FLockPosition and not SpecRow.Selected and SpecRow.ShowIfNotInKeyList then
      if not LocateKey
        then SpecRow.Selected := True
        else ListLinkDataChanged
  end;

  if ListActive and not FLockPosition then
    if not LocateKey and not SpecRow.Selected then
      ListLink.DataSet.First
    else
      ListLinkDataChanged;

  if FListField <> nil then
    if SpecRow.Visible and SpecRow.Selected
      then FSelectedItem := SpecRow.CellText[ListFieldIndex]
      else FSelectedItem := FListField.DisplayText
  else FSelectedItem := '';
end;

procedure TDBLookupGridEh.UpdateListFields;
var
  DataSet: TDataSet;
  ResultField: TField;
  i: Integer;
begin
  try
    FListActive := False;
    //FKeyField := nil;
    FListField := nil;
    FListFields.Clear;
    if ListLink.Active and (FKeyFieldName <> '') then
    begin
      CheckNotCircular;
      DataSet := ListLink.DataSet;
      FKeyFields := GetFieldsProperty(DataSet, Self, FKeyFieldName);
      try
        DataSet.GetFieldList(FListFields, FListFieldName);
      except
        DatabaseErrorFmt(SFieldNotFound, [Self.Name, FListFieldName]);
      end;
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

    if FLookupMode
      then FKeyFieldName := Field.LookupKeyFields
      else FKeyFieldName := KeyField;
    if ListLink.Active and (FKeyFieldName <> '') then
    begin
      DataSet := ListLink.DataSet;
      FKeyFields := GetFieldsProperty(DataSet, Self, FKeyFieldName);
      if FLookupMode then
      begin
        ResultField := GetFieldProperty(DataSet, Self, Field.LookupResultField);
        FListField := ResultField;
      end else
      begin
        if (ListFieldIndex >= 0) and (ListFieldIndex < ListFields.Count)
          then FListField := TField(ListFields[ListFieldIndex])
          else FListField := TField(ListFields[0]);
      end;
    end;

  finally
    if ListActive
      then KeyValueChanged
      else ListLinkDataChanged;
  end;
end;

procedure TDBLookupGridEh.ListLinkDataChanged;
begin
  if ListActive then
  begin
    if MemTableSupport then
    begin
      FRecordIndex := ListLink.DataSet.RecNo-1;
      FRecordCount := ListLink.DataSet.RecordCount;
    end else
    begin
      FRecordIndex := ListLink.ActiveRecord;
      FRecordCount := ListLink.RecordCount;
    end;
    FKeySelected := not VarIsNull(KeyValue) or
      not ListLink.DataSet.BOF;
  end else
  begin
    FRecordIndex := 0;
    FRecordCount := 0;
    FKeySelected := False;
  end;
  if HandleAllocated then
  begin
    UpdateScrollBar; //
    LayoutChanged;
    //UpdateActive;
    //Invalidate;
  end;
end;

function TDBLookupGridEh.LocateKey: Boolean;
var
  KeySave: Variant;
begin
  Result := False;
  try
    KeySave := FKeyValue;
    if not VarIsNull(FKeyValue) and (ListLink.DataSet <> nil) and
      ListLink.DataSet.Active and CompatibleVarValue(FKeyFields, FKeyValue) and
      ListLink.DataSet.Locate(FKeyFieldName, FKeyValue, []) then
    begin
      Result := True;
      FKeyValue := KeySave;
      if MemTableSupport then
        SafeMoveTop(Row - VisibleRowCount div 2);
    end;
  except
  end;
end;

procedure TDBLookupGridEh.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if (FDataLink <> nil) and (AComponent = DataSource)
      then DataSource := nil;
//    if (ListLink <> nil) and (AComponent = ListSource)
//      then ListSource := nil;
  end;
end;

procedure TDBLookupGridEh.ProcessSearchKey(Key: Char);
var
  TickCount: Integer;
  S: string;
  CharMsg: TMsg;
begin
  if (FListField <> nil) and (FListField.FieldKind in [fkData, fkInternalCalc]) and
    (FListField.DataType in [ftString, ftWideString]) then
    case Key of
      #8, #27: SearchText := '';
      #32..High(Char):
        if CanModify then
        begin
          TickCount := GetTickCount;
          if TickCount - SearchTickCount > 2000 then SearchText := '';
          SearchTickCount := TickCount;
          if SysLocale.FarEast and CharInSetEh(Key, LeadBytes) then
            if PeekMessage(CharMsg, Handle, WM_CHAR, WM_CHAR, PM_REMOVE) then
            begin
              if CharMsg.Message = WM_Quit then
              begin
                PostQuitMessage(CharMsg.wparam);
                Exit;
              end;
              SearchText := SearchText + Key;
              Key := Char(CharMsg.wParam);
            end;
          if Length(SearchText) < 32 then
          begin
            S := SearchText + Key;
            try
              if ListLink.DataSet.Locate(FListField.FieldName, S,
                [loCaseInsensitive, loPartialKey]) then
              begin
                SelectKeyValue(ListLink.DataSet.FieldValues[FKeyFieldName] {FKeyField.Value});
                SearchText := S;
              end;
            except
              { If you attempt to search for a string larger than what the field
                can hold, and exception will be raised.  Just trap it and
                reset the SearchText back to the old value. }
              SearchText := S;
            end;
          end;
        end;
    end;
end;

procedure TDBLookupGridEh.SelectKeyValue(const Value: Variant);
begin
  if Length(FMasterFields) > 0 then
  begin
    if FDataLink.Edit then
      FDataLink.DataSet.FieldValues[FMasterFieldNames] := Value;
  end else
    SetKeyValue(Value);
  UpdateActive;
  Repaint;
  Click;
end;

procedure TDBLookupGridEh.SetDataFieldName(const Value: string);
begin
  if FDataFieldName <> Value then
  begin
    FDataFieldName := Value;
    UpdateDataFields;
  end;
end;

procedure TDBLookupGridEh.SetDataSource(Value: TDataSource);
begin
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

procedure TDBLookupGridEh.SetKeyFieldName(const Value: string);
begin
  CheckNotLookup;
  if FKeyFieldName <> Value then
  begin
    FKeyFieldName := Value;
    UpdateListFields;
    UpdateColumnsList;
  end;
end;

procedure TDBLookupGridEh.SetKeyValue(const Value: Variant);
begin
  if not VarEquals(FKeyValue, Value) then
  begin
    FKeyValue := Value;
    KeyValueChanged;
  end
end;

procedure TDBLookupGridEh.SetListFieldName(const Value: string);
begin
  if FListFieldName <> Value then
  begin
    FListFieldName := Value;
    UpdateListFields;
    UpdateColumnsList;
  end;
end;

procedure TDBLookupGridEh.SetListSource(Value: TDataSource);
begin
  CheckNotLookup;
  inherited DataSource := Value;
  {ListLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);}
end;

procedure TDBLookupGridEh.SetLookupMode(Value: Boolean);
begin
  if FLookupMode <> Value then
    if Value then
    begin
      FMasterFields := GetFieldsProperty(FDataFields[0].DataSet, Self, FDataFields[0].KeyFields);
      FLookupSource.DataSet := FDataFields[0].LookupDataSet;
      FKeyFieldName := FDataFields[0].LookupKeyFields;
      FLookupMode := True;
      ListLink.DataSource := FLookupSource;
    end else
    begin
      ListLink.DataSource := nil;
      FLookupMode := False;
      FKeyFieldName := '';
      FLookupSource.DataSet := nil;
      FMasterFields := FDataFields;
    end;
end;

procedure TDBLookupGridEh.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

function TDBLookupGridEh.GetDataField: TField;
begin
  if Length(FDataFields) = 0
    then Result := nil
    else Result := FDataFields[0];
end;

procedure TDBLookupGridEh.SetSpecRow(const Value: TSpecRowEh);
begin
  FSpecRow.Assign(Value);
end;

procedure TDBLookupGridEh.SpecRowChanged(Sender: TObject);
begin
  if not (csLoading in ComponentState) then
    Invalidate;
end;

function TDBLookupGridEh.GetListLink: TGridDataLinkEh;
begin
  Result := inherited DataLink;
end;

procedure TDBLookupGridEh.LinkActive(Value: Boolean);
begin
  if csDestroying in ComponentState then Exit;
  UpdateListFields;
  inherited LinkActive(Value);
  UpdateColumnsList;
end;

procedure TDBLookupGridEh.DataChanged;
begin
  inherited DataChanged;
  ListLinkDataChanged;
end;

procedure TDBLookupGridEh.LayoutChanged;
begin
  if AcquireLayoutLock then
  try
    //UpdateListFields;
    inherited LayoutChanged;
  finally
    EndLayout;
  end;
end;

procedure TDBLookupGridEh.SelectCurrent;
begin
  FLockPosition := True;
  try
    if not VarEquals(ListLink.DataSet.FieldValues[FKeyFieldName], KeyValue) then
      SelectKeyValue(ListLink.DataSet.FieldValues[FKeyFieldName]);
  finally
    FLockPosition := False;
  end;
end;

procedure TDBLookupGridEh.SelectItemAt(X, Y: Integer);
var
  Delta: Integer;
  Cell: TGridCoord;
  ADataBox: TGridRect;
begin
  if FSpecRow.Visible and (Y > TitleRowHeight) and (Y <= TitleRowHeight + FSpecRowHeight) then
  begin
    SelectSpecRow;
  end else
  begin
    if Y < TitleRowHeight + FSpecRowHeight then Exit; //Y := TitleRowHeight + FSpecRowHeight;
    if Y >= ClientHeight then Y := ClientHeight - 1;
    Cell := MouseCoord(X, Y);
    ADataBox := DataBox;
    if (Cell.X >= ADataBox.Left) and (Cell.X <= ADataBox.Right) and
      (Cell.Y >= ADataBox.Top) and (Cell.Y <= ADataBox.Bottom) then
    begin
      Delta := (Cell.Y - TopDataOffset) - FRecordIndex;
      //if (Delta <> 0) {or (KeyValue = Null)} then
      //begin
      ListLink.DataSet.MoveBy(Delta);
      SelectCurrent;
      //end;
    end;
  end;
end;

procedure TDBLookupGridEh.SelectSpecRow;
begin
  FLockPosition := True;
  try
    if not VarEquals(FSpecRow.Value, KeyValue) then
      SelectKeyValue(FSpecRow.Value);
    SpecRow.Selected := True;
  finally
    FLockPosition := False;
  end;
end;

procedure TDBLookupGridEh.SetRowCount(Value: Integer);
var NewHeight: Integer;
begin
  if Value < 1 then Value := 1;
  if Value > 100 then Value := 100;
  NewHeight := 0;
  if dgTitles in inherited Options then NewHeight := RowHeights[0];
  if dgRowLines in inherited Options then Inc(NewHeight, GridLineWidth);
  Inc(NewHeight, DefaultRowHeight * Value);
  if dgRowLines in inherited Options then Inc(NewHeight, Value * GridLineWidth);
  Inc(NewHeight, GetBorderSize);
  Height := NewHeight + FSpecRowHeight;
end;

procedure TDBLookupGridEh.SetShowTitles(const Value: Boolean);
begin
  if ShowTitles <> Value then
  begin
    if Value
      then inherited Options := inherited Options + [dgTitles]
      else inherited Options := inherited Options - [dgTitles];
    //if ShowTitles then TitleRowHeight := RowHeights[0] else TitleRowHeight := 0;
    //if HandleAllocated then
    Height := RowCount * GetDataRowHeight + GetBorderSize + TitleRowHeight + FSpecRowHeight;
  end;
end;

function TDBLookupGridEh.GetShowTitles: Boolean;
begin
  Result := dgTitles in inherited Options;
end;

function TDBLookupGridEh.HighlightDataCellColor(DataCol, DataRow: Integer; const Value: string;
  AState: TGridDrawState; var AColor: TColor; AFont: TFont): Boolean;
begin
  Result := False;
  if not VarIsNull(KeyValue) and ListLink.Active and
    VarEquals(ListLink.DataSet.FieldValues[FKeyFieldName], KeyValue) then
    Result := (UpdateLock = 0);
  if Result then
  begin
    AColor := clHighlight;
    AFont.Color := clHighlightText;
  end;  
end;

procedure TDBLookupGridEh.UpdateActive;
var
  NewRow: Integer;
//  Field: TField;
  function GetKeyRowIndex: Integer;
  var
    FieldValue: Variant;
    ActiveRecord: Integer;
    I: Integer;
  begin
    Result := -1;
    if MemTableSupport then
      Result := ListLink.DataSet.RecNo-1
    else
    begin
      ActiveRecord := ListLink.ActiveRecord;
      try
        if not VarIsNull(KeyValue) then
          for I := 0 to FRecordCount - 1 do
          begin
            ListLink.ActiveRecord := I;
            FieldValue := ListLink.DataSet.FieldValues[FKeyFieldName]; //  FKeyField.Value;
            if VarEquals(FieldValue, KeyValue) then
            begin
              Result := I;
              Exit;
              ListLink.ActiveRecord := ActiveRecord;
            end;
          end;
      finally
        ListLink.ActiveRecord := ActiveRecord;
      end;
    end;
  end;
begin
  if not FInplaceSearchingInProcess then
    StopInplaceSearch;
  FKeyRowVisible := False;
  if ListLink.Active and HandleAllocated and not (csLoading in ComponentState) then
  begin
    NewRow := GetKeyRowIndex;
    if NewRow >= 0 then
    begin
      Inc(NewRow, TopDataOffset);
      if Row <> NewRow then
      begin
        if not (dgAlwaysShowEditor in inherited Options) then HideEditor;
        MoveColRow(Col, NewRow, False, False);
        InvalidateEditor;
      end;
//      Field := SelectedField;
  //    if Assigned(Field) and (Field.Text <> FEditText) then
  //      InvalidateEditor;
      FKeyRowVisible := True;
    end
  end;
end;

function TDBLookupGridEh.GetKeyIndex: Integer;
var
  FieldValue: Variant;
begin
  if not VarIsNull(KeyValue) then
    for Result := 0 to FRecordCount - 1 do
    begin
      ListLink.ActiveRecord := Result;
      FieldValue := ListLink.DataSet.FieldValues[FKeyFieldName]; //  FKeyField.Value;
      ListLink.ActiveRecord := FRecordIndex;
      if VarEquals(FieldValue, KeyValue) then Exit;
    end;
  Result := -1;
end;

function TDBLookupGridEh.CanDrawFocusRowRect: Boolean;
begin
  Result := FKeyRowVisible;
end;

procedure TDBLookupGridEh.KeyDown(var Key: Word; Shift: TShiftState);
var
  Delta, KeyIndex: Integer;
begin
  if CanModify then
  begin
    Delta := 0;
    case Key of
      VK_UP: Delta := -1;
      VK_LEFT: if not HorzScrollBar.IsScrollBarVisible then Delta := -1;
      VK_DOWN: Delta := 1;
      VK_RIGHT: if not HorzScrollBar.IsScrollBarVisible then Delta := 1;
      VK_PRIOR: Delta := 1 - DataRowCount;
      VK_NEXT: Delta := DataRowCount - 1;
      VK_HOME: Delta := -Maxint;
      VK_END: Delta := Maxint;
    end;
    if Delta <> 0 then
    begin
      SearchText := '';
      if (Delta < 0) and (ListLink.DataSet.Bof or SpecRow.Selected) and SpecRow.Visible then
      begin
        SelectSpecRow;
        ListLink.DataSet.First;
        Exit;
      end else if (Delta > 0) and SpecRow.Selected then
        ListLink.DataSet.First;
      if Delta = -Maxint
        then ListLink.DataSet.First
      else if Delta = Maxint
        then ListLink.DataSet.Last
      else
      begin
        if not MemTableSupport then
        begin
          KeyIndex := GetKeyIndex;
          if KeyIndex >= 0 then
            ListLink.DataSet.MoveBy(KeyIndex - FRecordIndex)
          else
          begin
            KeyValueChanged;
            Delta := 0;
          end;
        end;  
        ListLink.DataSet.MoveBy(Delta);
      end;
      SelectCurrent;
    end else
      inherited KeyDown(Key, Shift);
  end else
    inherited KeyDown(Key, Shift);
end;

procedure TDBLookupGridEh.Scroll(Distance: Integer);
begin
  BeginUpdate;
  inherited Scroll(Distance);
  ListLinkDataChanged;
  EndUpdate;
end;

procedure TDBLookupGridEh.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var Cell: TGridCoord;
  ADataBox: TGridRect;
begin
  Cell := MouseCoord(X, Y);
  ADataBox := DataBox;
  if not CellTreeElementMouseDown(X, Y, True) and
    ((Cell.X >= ADataBox.Left) and (Cell.X <= ADataBox.Right) and
    (Cell.Y >= ADataBox.Top) and (Cell.Y <= ADataBox.Bottom)) or
    (SpecRow.Visible and (TopDataOffset - 1 = Cell.Y))
    then
  begin
    if Assigned(OnMouseDown) then OnMouseDown(Self, Button, Shift, X, Y);
    if Button = mbLeft then
    begin
      SearchText := '';
      if not FPopup then
      begin
        SetFocus;
        if not HasFocus then Exit;
      end;
      if CanModify then
        if ssDouble in Shift then
        begin
          if FRecordIndex = (Y - TitleRowHeight) div GetDataRowHeight then DblClick;
        end else
        begin
          if not MouseCapture then Exit;
          FTracking := True;
          FDataTracking := True;
          if Y > TitleRowHeight then
            SelectItemAt(X, Y);
        end;
    end;
  end else
{$IFDEF EH_LIB_5}inherited MouseDown(Button, Shift, X, Y){$ENDIF};
end;

procedure TDBLookupGridEh.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  if FTracking and FDataTracking then
  begin
    SelectItemAt(X, Y);
    FMousePos := Y;
    TimerScroll;
    if Assigned(OnMouseMove) then OnMouseMove(Self, Shift, X, Y);
  end else
    inherited MouseMove(Shift, X, Y);
end;

procedure TDBLookupGridEh.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  if FTracking and FDataTracking then
  begin
    StopTracking;
    if Y > TitleRowHeight then
      SelectItemAt(X, Y);
    if Assigned(OnMouseUp) then OnMouseUp(Self, Button, Shift, X, Y);
  end else
    inherited MouseUp(Button, Shift, X, Y);
end;

procedure TDBLookupGridEh.TimerScroll;
var
  Delta, Distance, Interval: Integer;
begin
  Delta := 0;
  Distance := 0;
  if FMousePos < 0 then
  begin
    Delta := -1;
    Distance := -FMousePos;
  end;
  if FMousePos >= ClientHeight then
  begin
    Delta := 1;
    Distance := FMousePos - ClientHeight + 1;
  end;
  if Delta = 0
    then StopTimer
  else
  begin
    if SpecRow.Visible and (FMousePos < 0) and ListLink.DataSet.Bof then
      SelectSpecRow
    else if ListLink.DataSet.MoveBy(Delta) <> 0 then SelectCurrent;
    Interval := 200 - Distance * 15;
    if Interval < 0 then Interval := 0;
//    SetTimer(Handle, 1, Interval, nil);
//    FTimerActive := True;
    ResetTimer(Interval);
  end;
end;

procedure TDBLookupGridEh.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  BorderSize, TextHeight, SpecRowHeight, Rows, AddLine: Integer;
begin
  BorderSize := GetBorderSize;
  TextHeight := GetDataRowHeight;
  SpecRowHeight := GetSpecRowHeight;
  //if ShowTitles then TitleRowHeight := RowHeights[0] else TitleRowHeight := 0;
  if Assigned(SpecRow) and SpecRow.Visible
    then FSpecRowHeight := SpecRowHeight
    else FSpecRowHeight := 0;
  Rows := (AHeight - BorderSize - TitleRowHeight - FSpecRowHeight) div TextHeight;
  if Rows < 1 then Rows := 1;
  FRowCount := Rows;
  {if Assigned(ListLink) and (ListLink.BufferCount <> Rows) then
  begin
    ListLink.BufferCount := Rows;
    ListLinkDataChanged;
  end;}
  AddLine := 0;
  if dgRowLines in inherited Options then Inc(AddLine, GridLineWidth);
  inherited SetBounds(ALeft, ATop, AWidth, Rows * TextHeight + BorderSize + TitleRowHeight + FSpecRowHeight + AddLine);
end;

function TDBLookupGridEh.GetTitleRowHeight: Integer;
begin
  if ShowTitles then Result := RowHeights[0] else Result := 0;
end;

procedure TDBLookupGridEh.UpdateScrollBar;
var
  Pos, Max: Integer;
  Page: Cardinal;
  ScrollInfo: TScrollInfo;
begin
  if MemTableSupport then
  begin
    inherited UpdateScrollBar;
    Exit;
  end;
  if not HandleAllocated then Exit;
  Pos := 0;
  Max := 0;
  Page := 0;
  if not ListLink.Active then
    Max := 2
  else if (ListLink.DataSet <> nil) and ListLink.DataSet.IsSequenced then
  begin
    Page := DataRowCount;
    Max := ListLink.DataSet.RecordCount - 1;
    if ListLink.DataSet.State in [dsInactive, dsBrowse, dsEdit] then
      Pos := ListLink.DataSet.RecNo - ListLink.ActiveRecord - 1;
    //ListLink.ActiveRecord := 0;
    //if FRecordCount <> 0 then ListLink.ActiveRecord := FRecordIndex;
  end else if FRecordCount = DataRowCount then
  begin
    Max := 4;
    if not ListLink.DataSet.BOF then
      if not ListLink.DataSet.EOF then Pos := 2 else Pos := 4;
  end;
  ScrollInfo.cbSize := SizeOf(TScrollInfo);
  ScrollInfo.fMask := SIF_ALL;
  if not GetScrollInfo(Handle, SB_VERT, ScrollInfo) or
    (ScrollInfo.nMin <> 0) or (ScrollInfo.nMax <> Max) or
    (ScrollInfo.nPage <> Page) or (ScrollInfo.nPos <> Pos) then
  begin
    ScrollInfo.nMin := 0;
    ScrollInfo.nMax := Max;
    ScrollInfo.nPos := Pos;
    ScrollInfo.nPage := Page;
    SetScrollInfo(Handle, SB_VERT, ScrollInfo, True);
  end;
end;

procedure TDBLookupGridEh.UpdateRowCount;
begin
  if FInternalHeightSetting then Exit;
  FInternalHeightSetting := True;
  try
    //Height := RowCount * GetDataRowHeight + GetBorderSize + TitleRowHeight + FSpecRowHeight;
  //if HandleAllocated then UpdateScrollBar;
    inherited UpdateRowCount;
  finally
    FInternalHeightSetting := False;
  end;
  //FRowCount := DataRowCount;
  ListLinkDataChanged;
end;

type TColumnEhCracker = class(TColumnEh) end;

procedure TDBLookupGridEh.ColWidthsChanged;
var i, w: Integer;
begin
  w := 0;
  inherited ColWidthsChanged;
  if FInternalWidthSetting = True then Exit;
  if HandleAllocated and (FGridState = gsColSizing) and AutoFitColWidths then
  begin
    for i := 0 to ColCount - 1 do
    begin
      Inc(w, ColWidths[i]);
      if dgColLines in inherited Options then Inc(w, GridLineWidth);
    end;
    FInternalWidthSetting := True;
    //FAutoFitColWidths := False;
    try
      ClientWidth := w;
      for i := 0 to Columns.Count - 1 do
        TColumnEhCracker(Columns[i]).FInitWidth := Columns[i].Width;
    finally
      FInternalWidthSetting := False;
      //FAutoFitColWidths := True;
    end;
  end;
end;

procedure TDBLookupGridEh.UpdateColumnsList;
var i: Integer;
begin
  if FInternalWidthSetting then Exit;
  FInternalWidthSetting := True;
  try
    if FLGAutoFitColWidths then
      inherited AutoFitColWidths := True;
    for i := 0 to Columns.Count - 1 do
      TColumnEhCracker(Columns[i]).FInitWidth := Columns[i].Width;
    inherited AutoFitColWidths := False;
  finally
    FInternalWidthSetting := False;
  end;
  RowCount := RowCount;
end;

function TDBLookupGridEh.GetUseMultiTitle: Boolean;
begin
  Result := inherited UseMultiTitle;
end;

procedure TDBLookupGridEh.SetUseMultiTitle(const Value: Boolean);
begin
  inherited UseMultiTitle := Value;
  RowCount := RowCount;
end;

{procedure TDBLookupGridEh.RowHeightsChanged;
begin
  if FInternalHeightSetting then Exit;
  inherited RowHeightsChanged;
  Height := RowCount * GetDataRowHeight + GetBorderSize + TitleRowHeight + FSpecRowHeight;
end;}

function TDBLookupGridEh.DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  Result := True;
  if ListLink.DataSet <> nil then
  begin
    if MemTableSupport then
    begin
      if Shift = [] then
        inherited DoMouseWheelDown(Shift, MousePos);
    end else
      ListLink.DataSet.MoveBy(FRecordCount - FRecordIndex);
    Result := True;
  end;
end;

function TDBLookupGridEh.DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  Result := True;
  if ListLink.DataSet <> nil then
  begin
    if MemTableSupport then
    begin
      if Shift = [] then
        inherited DoMouseWheelUp(Shift, MousePos);
    end else
      ListLink.DataSet.MoveBy(-FRecordIndex - 1);
    Result := True;
  end;
end;

procedure TDBLookupGridEh.CreateWnd;
begin
  inherited CreateWnd;
  RowCount := RowCount;
end;

{function TDBLookupGridEh.CalcTitleOffset: Integer;
begin
  Result := inherited CalcTitleOffset;
  if SpecRow.Visible then Result := Result + 1;
end;}

procedure TDBLookupGridEh.DrawSubTitleCell(ACol, ARow: Integer;
   DataCol, DataRow: Integer; CellType: TCellAreaTypeEh; ARect: TRect;
   AState: TGridDrawState; var Highlighted: Boolean);
var //Field: TField;
  S: String;
  AAlignment: TAlignment;
  DrawColumn: TDBLookupGridColumnEh;
begin
  Dec(ACol, IndicatorOffset);
  DrawColumn := TDBLookupGridColumnEh(Columns[ACol]);
  Canvas.Font := SpecRow.Font;
  S := DrawColumn.SpecCell.Text; // SpecRow.CellText[ACol];
  AAlignment := DrawColumn.Alignment;
  if UseRightToLeftAlignment then ChangeBiDiModeAlignment(AAlignment);
  Canvas.Brush.Color := DrawColumn.SpecCell.Color; //SpecRow.Color;
  if SpecRow.Selected then
  begin
    Canvas.Font.Color := clHighlightText;
    Canvas.Brush.Color := clHighlight;
  end;
  WriteCellText(DrawColumn, Canvas, ARect, True, 2, 1, S, AAlignment, tlTop, False, False, 0, 0);
  if SpecRow.Selected then
  begin
    Canvas.Font.Color := clWindowText;
    Canvas.Brush.Color := clWindow;
    Windows.DrawFocusRect(Canvas.Handle, BoxRect(FixedCols, ARow, ColCount, ARow));
  end;
end;

function TDBLookupGridEh.CellHave3DRect(ACol, ARow: Integer; ARect: TRect; AState: TGridDrawState): Boolean;
begin
  if SpecRow.Visible and (TopDataOffset - 1 = ARow)
    then Result := False
    else Result := inherited CellHave3DRect(ACol, ARow, ARect, AState);
end;

function TDBLookupGridEh.DataRect: TRect;
begin
  Result := BoxRect(IndicatorOffset, iif(SpecRow.Visible, TopDataOffset - 1, TopDataOffset), ColCount - 1,
    iif(FooterRowCount > 0, RowCount - FooterRowCount - 2, RowCount));
end;

procedure TDBLookupGridEh.DefineFieldMap;
var
  I: Integer;
begin
  if Columns.State = csCustomized then
  begin { Build the column/field map from the column attributes }
    DataLink.SparseMap := True;
    for I := 0 to Columns.Count - 1 do
      DataLink.AddMapping(Columns[I].FieldName);
  end else { Build the column/field map from the field list order }
  begin
    DataLink.SparseMap := False;
    for I := 0 to ListFields.Count - 1 do
      with TField(ListFields[I]) do Datalink.AddMapping(FieldName);
  end;
end;

procedure TDBLookupGridEh.GetDatasetFieldList(FieldList: TList);
var i: Integer;
begin
  for i := 0 to ListFields.Count - 1 do
    FieldList.Add(ListFields[i]);
end;

function TDBLookupGridEh.GetAutoFitColWidths: Boolean;
begin
  Result := FLGAutoFitColWidths;
end;

procedure TDBLookupGridEh.SetAutoFitColWidths(const Value: Boolean);
begin
  if AutoFitColWidths <> Value then
  begin
    FLGAutoFitColWidths := Value;
    HorzScrollBar.Visible := not FLGAutoFitColWidths;
    RowCount := RowCount; 
    UpdateScrollBar;
    UpdateColumnsList;
  end;
end;

function TDBLookupGridEh.GetColumnsWidthToFit: Integer;
var i: Integer;
begin
  Result := 0;
  for i := 0 to Columns.Count - 1 do
  begin
    if Columns[i].Visible then
      if AutoFitColWidths
        then Inc(Result, TColumnEhCracker(Columns[i]). {DefaultWidth} FInitWidth)
        else Inc(Result, Columns[i].Width);
    if dgColLines in inherited Options then Inc(Result, GridLineWidth);
  end;
end;

procedure TDBLookupGridEh.SetOptions(const Value: TDBLookupGridEhOptions);
var
  NewGridOptions, NewNoGridOptions: TDBGridOptions;
  NewGridOptionsEh, NewNoGridOptionsEh: TDBGridEhOptions;
begin
  if FOptions <> Value then
  begin
    FOptions := Value;
    NewGridOptions := [];
    NewNoGridOptions := [];
    if dlgColumnResizeEh in FOptions
      then NewGridOptions := NewGridOptions + [dgColumnResize]
      else NewNoGridOptions := NewNoGridOptions + [dgColumnResize];
    if dlgColLinesEh in FOptions
      then NewGridOptions := NewGridOptions + [dgColLines]
      else NewNoGridOptions := NewNoGridOptions + [dgColLines];
    if dlgRowLinesEh in FOptions
      then NewGridOptions := NewGridOptions + [dgRowLines]
      else NewNoGridOptions := NewNoGridOptions + [dgRowLines];

    inherited Options := inherited Options + NewGridOptions - NewNoGridOptions;

    NewGridOptionsEh := [];
    NewNoGridOptionsEh := [];
    if dlgAutoSortMarkingEh in FOptions
      then NewGridOptionsEh := NewGridOptionsEh + [dghAutoSortMarking]
      else NewNoGridOptionsEh := NewNoGridOptionsEh + [dghAutoSortMarking];
    if dlgMultiSortMarkingEh in FOptions
      then NewGridOptionsEh := NewGridOptionsEh + [dghMultiSortMarking]
      else NewNoGridOptionsEh := NewNoGridOptionsEh + [dghMultiSortMarking];

    inherited OptionsEh := inherited OptionsEh + NewGridOptionsEh - NewNoGridOptionsEh;
  end;
end;

function TDBLookupGridEh.CreateColumns: TDBGridColumnsEh;
begin
  Result := TDBGridColumnsEh.Create(Self, TDBLookupGridColumnEh);
end;

function TDBLookupGridEh.CreateColumnDefValues: TColumnDefValuesEh;
begin
  Result := TDBLookupGridColumnDefValuesEh.Create(Self);
end;

{CM messages processing}

procedure TDBLookupGridEh.CMRecreateWnd(var Message: TMessage);
begin
  if FInternalWidthSetting
    then Exit
    else Inherited;
end;

{WM messages processing}

procedure TDBLookupGridEh.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result := DLGC_WANTARROWS or DLGC_WANTCHARS;
end;

procedure TDBLookupGridEh.WMKillFocus(var Message: TWMKillFocus);
begin
  FHasFocus := False;
  inherited;
  Invalidate;
end;

procedure TDBLookupGridEh.WMSetFocus(var Message: TWMSetFocus);
begin
  SearchText := '';
  FHasFocus := True;
  inherited;
  Invalidate;
end;

procedure TDBLookupGridEh.WMSetCursor(var Msg: TWMSetCursor);
var
  Cell: TGridCoord;
begin
  Cell := MouseCoord(HitTest.X, HitTest.Y);
  if SpecRow.Visible and (TopDataOffset - 1 = Cell.Y) then
    Exit;
  inherited;
end;

procedure TDBLookupGridEh.WMSize(var Message: TWMSize);
begin
  if FInternalWidthSetting then
    inherited
  else
  begin
    FInternalWidthSetting := True;
    if FLGAutoFitColWidths then
      FAutoFitColWidths := True;
    try
      inherited;
    finally
      FInternalWidthSetting := False;
      FAutoFitColWidths := False;
    end;
  end;
end;

procedure TDBLookupGridEh.WMVScroll(var Message: TWMVScroll);
var
  SI: TScrollInfo;
  OldRecNo: Integer;
  OldActiveRec: Integer;
begin
  SearchText := '';
  if not ListLink.Active then
    Exit;
  if MemTableSupport then
  begin
    inherited
  end else
    with Message, ListLink.DataSet do
      case ScrollCode of
        SB_LINEUP: MoveBy(-FRecordIndex - 1);
        SB_LINEDOWN: MoveBy(FRecordCount - FRecordIndex);
        SB_PAGEUP: MoveBy(-FRecordIndex - FRecordCount + 1);
        SB_PAGEDOWN: MoveBy(FRecordCount - FRecordIndex + FRecordCount - 2);
        SB_THUMBPOSITION:
          begin
            case Pos of
              0: First;
              1: MoveBy(-FRecordIndex - FRecordCount + 1);
              2: Exit;
              3: MoveBy(FRecordCount - FRecordIndex + FRecordCount - 2);
              4: Last;
            end;
          end;
        SB_BOTTOM: Last;
        SB_TOP: First;
        SB_THUMBTRACK:
          if IsSequenced then
          begin
            SI.cbSize := SizeOf(SI);
            SI.fMask := SIF_TRACKPOS;
            GetScrollInfo(Self.Handle, SB_VERT, SI);
            OldActiveRec := ListLink.ActiveRecord;
            ListLink.ActiveRecord := 0;
            OldRecNo := RecNo - 1;
            if SI.nTrackPos < OldRecNo then
              MoveBy(SI.nTrackPos - OldRecNo)
            else if SI.nTrackPos > OldRecNo then
              MoveBy(SI.nTrackPos - OldRecNo + ListLink.RecordCount - 1)
            else
              ListLink.ActiveRecord := OldActiveRec;
          end;
      end;
end;

function TDBLookupGridEh.CompatibleVarValue(AFieldsArr: TFieldsArrEh; AVlaue: Variant): Boolean;
begin
  Result := True

// Ignore checking because TVariantField, TVarBytesField can have VarArray value.  
{  Result := ((Length(AFieldsArr) = 1) and not VarIsArray(AVlaue)) or
            ((Length(AFieldsArr) > 1) and VarIsArray(AVlaue) and
             ( VarArrayHighBound(AVlaue, 1) - VarArrayLowBound(AVlaue, 1) = Length(AFieldsArr)-1 )
            );}
end;

function TDBLookupGridEh.GetSubTitleRows: Integer;
begin
  Result := inherited GetSubTitleRows;
  if (SpecRow <> nil) and SpecRow.Visible then
    Result := Result + 1;
end;

procedure TDBLookupGridEh.CMHintShow(var Message: TCMHintShow);
{$IFDEF CIL}
var
  AHintInfo: THintInfo;
{$ENDIF}
begin
{$IFDEF CIL}
  if Message.OriginalMessage.LParam = 0 then Exit;
  AHintInfo := Message.HintInfo;
  AHintInfo.HintStr := Hint;
  Message.HintInfo := AHintInfo;
{$ELSE}
  Message.HintInfo^.HintStr := Hint;
{$ENDIF}
  inherited;
end;

{ TPopupDataGridEh }

constructor TPopupDataGridEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csNoDesignVisible, csReplicatable];
  FPopup := True;
  FSizeGrip := TSizeGripEh.Create(Self);
  with FSizeGrip do
  begin
    Parent := Self;
    TriangleWindow := True;
  end;
  ShowHint := True;
end;

destructor TPopupDataGridEh.Destroy;
begin
  FreeAndNil(FSizeGrip);
  inherited Destroy;
end;

function TPopupDataGridEh.CheckNewSize(var NewWidth, NewHeight: Integer): Boolean;
begin
  Result := True;
  if NewWidth < GetSystemMetrics(SM_CXVSCROLL) then
    NewWidth := GetSystemMetrics(SM_CXVSCROLL);
  if NewHeight < GetSystemMetrics(SM_CYVSCROLL) then
    NewHeight := GetSystemMetrics(SM_CYVSCROLL);
end;

procedure TPopupDataGridEh.CMSetSizeGripChangePosition(var Message: TMessage);
begin
  FSizeGrip.ChangePosition(TSizeGripChangePosition(Message.WParam));
end;

procedure TPopupDataGridEh.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := WS_POPUP or WS_CLIPCHILDREN;
    if not Ctl3D then
      Style := Style or WS_BORDER;
    //if ScrollBars in [ssHorizontal, ssBoth] then Style := Style or WS_HSCROLL;
    ExStyle := WS_EX_TOOLWINDOW;
    AddBiDiModeExStyle(ExStyle);
    WindowClass.Style := CS_SAVEBITS or CS_HREDRAW;
  end;
  UpdateBorderWidth;
end;

procedure TPopupDataGridEh.KeyDown(var Key: Word; Shift: TShiftState);
begin
  FUserKeyValueChanged := True;
  try
    inherited KeyDown(Key, Shift);
  finally
    FUserKeyValueChanged := False;
  end;
end;

procedure TPopupDataGridEh.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited KeyUp(Key, Shift);
end;

procedure TPopupDataGridEh.KeyValueChanged;
begin
  inherited KeyValueChanged;
  if Assigned(OnUserKeyValueChange) and FUserKeyValueChanged then
    OnUserKeyValueChange(Self);
end;

procedure TPopupDataGridEh.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FUserKeyValueChanged := True;
  FKeySelection := True;
  try
    inherited MouseDown(Button, Shift, X, Y);
    if CellTreeElementMouseDown(X, Y, True) then
      FKeySelection := False;
  finally
    FUserKeyValueChanged := False;
  end;
end;

procedure TPopupDataGridEh.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  FUserKeyValueChanged := True;
  try
    inherited MouseMove(Shift, X, Y);
    if ([ssLeft, ssRight, ssMiddle] * Shift = []) and not ReadOnly then
      SelectItemAt(X, Y);
  finally
    FUserKeyValueChanged := False;
  end;
end;

procedure TPopupDataGridEh.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var Cell: TGridCoord;
  ADataBox: TGridRect;
  AGridState: TGridState;
begin
//  FUserKeyValueChanged := True;
  try
    AGridState := FGridState;
    inherited MouseUp(Button, Shift, X, Y);
    if not (AGridState = gsNormal) or not FKeySelection then Exit;
    if not PtInRect(Rect(0, 0, Width, Height), Point(X, Y)) then
      OnMouseCloseUp(Self, False)
    else
    begin
      Cell := MouseCoord(X, Y);
      ADataBox := DataBox;
      if ((Cell.X >= ADataBox.Left) and (Cell.X <= ADataBox.Right) and
        (Cell.Y >= ADataBox.Top) and (Cell.Y <= ADataBox.Bottom)) or
        (SpecRow.Visible and (TopDataOffset - 1 = Cell.Y)) then
        OnMouseCloseUp(Self, True)
    end
  finally
//    FUserKeyValueChanged := False;
  end;
end;

procedure TPopupDataGridEh.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
  Message.Result := 1;
  //inherited;
end;

procedure TPopupDataGridEh.WMMouseActivate(var Message: TWMMouseActivate);
begin
  Message.Result := MA_NOACTIVATE;
end;

procedure TPopupDataGridEh.WMSize(var Message: TWMSize);
begin
  inherited;
  if FSizeGrip <> nil then FSizeGrip.UpdatePosition;
  FSizeGripResized := True;
end;

procedure TPopupDataGridEh.WMWindowPosChanging(var Message: TWMWindowPosChanging);
{$IFDEF CIL}
var
  r: TWindowPos;
begin
  r := Message.WindowPos;
  if ComponentState * [csReading, csDestroying] = [] then
    with r do
      if (flags and SWP_NOSIZE = 0) and not CheckNewSize(cx, cy) then
        flags := flags or SWP_NOSIZE;
  Message.WindowPos := r;
  inherited;
end;
{$ELSE}
begin
  if ComponentState * [csReading, csDestroying] = [] then
    with Message.WindowPos^ do
      if (flags and SWP_NOSIZE = 0) and not CheckNewSize(cx, cy) then
        flags := flags or SWP_NOSIZE;
  inherited;
end;
{$ENDIF}

procedure TPopupDataGridEh.DrawBorder;
var
  DC: HDC;
  R: TRect;
begin
  if Ctl3D = True then
  begin
    DC := GetWindowDC(Handle);
    try
      GetWindowRect(Handle, R);
      OffsetRect(R, -R.Left, -R.Top);
      DrawEdge(DC, R, BDR_RAISEDOUTER, BF_RECT);
//      InflateRect(R, -1, -1);
//      DrawEdge(DC, R, BDR_RAISEDINNER, BF_RECT);
    finally
      ReleaseDC(Handle, DC);
    end;
  end;
end;

function TPopupDataGridEh.CanFocus: Boolean;
begin
  Result := False;
end;

procedure TPopupDataGridEh.CMCtl3DChanged(var Message: TMessage);
begin
  inherited;
  UpdateBorderWidth;
  RecreateWnd;
end;

procedure TPopupDataGridEh.UpdateBorderWidth;
begin
  if Ctl3D
    then FBorderWidth := 1//2
    else FBorderWidth := 0;
end;

end.
