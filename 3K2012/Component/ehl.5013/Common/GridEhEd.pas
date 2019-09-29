{*******************************************************}
{                                                       }
{                       EhLib 5.0                       }
{              Design window for TDBGridEh              }
{                     (Build 5.0.00)                    }
{   Copyright (c) 1998-2009 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}


unit GridEhEd {$IFDEF CIL} platform{$ENDIF};

{$I EhLib.Inc}
interface

uses
  Windows, Messages, SysUtils,
{$IFDEF CIL} Borland.Vcl.Design.DesignIntf,
             Borland.Vcl.Design.DesignEditors,
             Borland.Vcl.Design.ColnEdit,
             Variants,
{$ELSE}
  ColnEdit,
  {$IFDEF EH_LIB_6}Variants, DesignEditors, DesignIntf,
  {$ELSE}DsgnWnds, DsgnIntf, LibIntf, {$ENDIF}
{$ENDIF}
  Graphics, Controls, Forms,
  Dialogs, ImgList, Menus, ActnList, ExtCtrls, ComCtrls,
  DBGridEh, {DBGrids,} DBLookupEh,
{$IFDEF CIL}
  EhLibVCLNET,
{$ELSE}
  EhLibVCL, PSAPI, ToolsAPI,
{$ENDIF}
//  ColectEditorEh,
  ToolWin, ToolCtrlsEh, GridsEh, MemTableEh, DataDriverEh,
  Classes;

type
  TDBGridEhColumnsEditor = class(TCollectionEditor)
//  TDBGridEhColumnsEditor = class(TCollectionEditorEh)
    N1: TMenuItem;
    AddAllFields1: TMenuItem;
    RestoreDefaults1: TMenuItem;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    AddAllFieldsCmd: TAction;
    RestoreDefaultsCmd: TAction;
    procedure AddAllFieldsCmdExecute(Sender: TObject);
    procedure RestoreDefaultsCmdExecute(Sender: TObject);
    procedure AddAllFieldsCmdUpdate(Sender: TObject);
    procedure RestoreDefaultsCmdUpdate(Sender: TObject);
  private
    { Private declarations }
  protected
    function CanAdd(Index: Integer): Boolean; override;
  public
    { Public declarations }
  end;

{ TDBGridEhColumnsProperty }

  TDBGridEhColumnsProperty = class(TPropertyEditor {TClassProperty})
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure Edit; override;
  end;

{ TDBGridEhEditor }

  TDBGridEhEditor = class(TComponentEditor)
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

{ TDBGridEhFieldProperty }

  TDBGridEhFieldProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValueList(List: TStrings); virtual;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

{ TDBGridEhFieldProperty }

  TDBGridEhFieldAggProperty = class(TDBGridEhFieldProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;

{ TDBLookupComboboxEhEditor }

  TDBLookupComboboxEhEditor = class(TComponentEditor)
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

{ TDBGridEhDesignControler }

  TDBGridEhDesignControler = class(TDesignControlerEh, IDesignNotification)
  private
    FGridList: TList;
    FCornerImage: TBitmap;
  protected
   { IDesignNotification }
   {$IFDEF EH_LIB_6}
    procedure ItemDeleted(const ADesigner: IDesigner; AItem: TPersistent);
    procedure ItemInserted(const ADesigner: IDesigner; AItem: TPersistent);
    procedure ItemsModified(const ADesigner: IDesigner);
    procedure SelectionChanged(const ADesigner: IDesigner; const ASelection: IDesignerSelections);
    procedure DesignerOpened(const ADesigner: IDesigner; AResurrecting: Boolean);
    procedure DesignerClosed(const ADesigner: IDesigner; AGoingDormant: Boolean);
    {$ELSE}
    procedure ItemDeleted(const AItem: IPersistent);
    procedure ItemInserted(const AItem: IPersistent);
    procedure ItemsModified(const ADesigner: IUnknown);
    procedure SelectionChanged(const ASelection: IDesignerSelections);
    procedure DesignerInitialized(const ADesigner: IUnknown);
    procedure DesignerClosed(const ADesigner: IUnknown);
    {$ENDIF}
    procedure CreateDesingPanel(DBGridEh: TCustomDBGridEh);
  public
    constructor Create;
    destructor Destroy; override;
    function IsDesignHitTest(Control: TPersistent; X, Y: Integer; AShift: TShiftState): Boolean; override;
    function ControlIsObjInspSelected(Control: TPersistent): Boolean; override;
    function GetObjInspSelectedControl(BaseControl: TPersistent): TPersistent; override;
    function GetSelectComponentCornerImage: TBitmap; override;
    function GetDesignInfoItemClass: TCollectionItemClass; override;
    procedure DesignMouseDown(Control: TPersistent; X, Y: Integer; AShift: TShiftState); override;
    procedure RegisterChangeSelectedNotification(Control: TPersistent); override;
    procedure UnregisterChangeSelectedNotification(Control: TPersistent); override;
    procedure KeyProperyModified(Control: TControl); override;
  end;

{ TGridDesignPanelEh }

  TGridDesignPanelEh = class(TCustomPanel)
  private
    Grid: TCustomDBGridEh;
    DropdownMenu: TPopupMenu;
  protected
    procedure Paint; override;
    procedure CMDesignHitTest(var Msg: TCMDesignHitTest); message CM_DESIGNHITTEST;
    procedure WndProc(var Message: TMessage); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  public
    constructor CreateForGrid(AOwner: TCustomDBGridEh);
    procedure MenuClick(Sender: TObject);
    procedure UpdateState;
  end;

  TPanelMenuItem = class(TMenuItem)
  public
    ComponentEditor: IComponentEditor;
    VerbNo: Integer;
  end;

{ TSaveComponentDesignInfoEh }

  TSaveComponentDesignInfoItemEh = class(TCollectionItem)
  private
    FLeft: Integer;
    FTop: Integer;
    FComponentName: String;
  public
    InGrid: Boolean;
  published
    property Left: Integer read FLeft write FLeft;
    property Top: Integer read FTop write FTop;
    property ComponentName: String read FComponentName write FComponentName;
  end;

var
  DBGridEhColumnsEditor: TDBGridEhColumnsEditor;
  ComponentsBitmap: TStringList;
  GlobalHideConnectedComponens: Boolean;
  GlobalHideConnectedComponensLoaded: Boolean;

  function GetGlobalHideConnectedComponens: Boolean;

implementation

{$R *.dfm}

uses
{$IFDEF DESIGNTIME}
{$IFDEF EH_LIB_6}
{$IFDEF CIL}
  Borland.Vcl.Design.ComponentDesigner,
{$ELSE}
  ComponentDesigner,
{$ENDIF}
{$ELSE}
//  LibIntf,
{$ENDIF}
{$ENDIF}
  Registry;

procedure RestoreGlobalHideConnectedComponens;
begin
  GlobalHideConnectedComponensLoaded := True;
  Exit;
{$IFDEF DESIGNTIME}
{$IFDEF EH_LIB_6}
  if ActiveDesigner = nil then
  begin
    Exit;
  end;
  with TRegIniFile.Create(ActiveDesigner.Environment.GetBaseRegKey + '\' + EhLibRegKey) do
{$ELSE}
  with TRegIniFile.Create(DelphiIDE.GetBaseRegKey + '\' + EhLibRegKey) do
{$ENDIF}
  try
    GlobalHideConnectedComponens := ReadBool('', 'HideConnectedComponens', GlobalHideConnectedComponens);
//    ShowMessage('GlobalHideConnectedComponens:' + BoolToStr(GlobalHideConnectedComponens));
  finally
    Free;
  end;
{$ENDIF}
  GlobalHideConnectedComponensLoaded := True;
end;

function GetGlobalHideConnectedComponens: Boolean;
begin
  if not GlobalHideConnectedComponensLoaded then
    RestoreGlobalHideConnectedComponens;
  Result := GlobalHideConnectedComponens;
end;

procedure SaveGlobalHideConnectedComponens;
begin
{$IFDEF DESIGNTIME}
  {$IFDEF EH_LIB_6}
  if ActiveDesigner = nil then Exit;
  with TRegIniFile.Create(ActiveDesigner.Environment.GetBaseRegKey + '\' + EhLibRegKey) do
  {$ELSE}
  with TRegIniFile.Create(DelphiIDE.GetBaseRegKey + '\' + EhLibRegKey) do
  {$ENDIF}
  try
    WriteBool('', 'HideConnectedComponens', GlobalHideConnectedComponens);
  finally
    Free;
  end;
{$ENDIF}
end;

type
  TDataDriverEhCracker = class(TDataDriverEh)
  end;

{$IFDEF CIL}
{$ELSE}
function FindResourceGlobal(AClassName: String; ResType: PChar; var InModule: HMODULE): HRSRC;
var
  ph: THandle;
  ProcModules: array[0..1000] of HMODULE;
  cbNeeded, ModCount: Cardinal;
  i: Integer;
  FileName: array[0..MAX_PATH-1] of Char;
//  FN, RS: String;
begin
  Result := 0;
  ph := GetCurrentProcess;
  if EnumProcessModules(ph, @ProcModules[0], SizeOf(ProcModules), cbNeeded) then
  begin
    ModCount := cbNeeded div SizeOf(HMODULE);
    if ModCount > 1000 then ModCount := 1000;
//    ShowMessage('ModCount: ' + IntToStr(ModCount));
    for i := 0 to ModCount-1 do
    begin
      InModule := ProcModules[i];
      GetModuleFileNameEx(ph, InModule, FileName, SizeOf(FileName));
//      FN := FileName;
//      SetString(RS, ResType, StrLen(ResType));
//      if FileName = 'C:\RADStudio\6.0\bin\vcldesigner120.bpl' then
//        ShowMessage( FN + ':' + AClassName + ':' + RS );
      Result := FindResource(InModule, PChar(AClassName), ResType);
      if Result <> 0 then
        Exit;
    end;
  end;
end;

function GetDesigntimeBitmapOfComponent(Component: TComponent): TBitmap;
var
  HResInfo: THandle;
  BIndex: Integer;
  NewBM: TBitmap;
  TmpImage: TImage;
  AClassName, ResClassName: String;
  InModule: HMODULE;
  ResClass: TClass;

  procedure BevelRect(R: TRect);
  begin
    R.Right := R.Right-1;
    R.Bottom := R.Bottom-1;
    with NewBM.Canvas do
    begin
      Pen.Color := clBtnHighlight;
      PolyLine([Point(R.Left, R.Bottom), Point(R.Left, R.Top),
        Point(R.Right, R.Top)]);
      Pen.Color := clBtnShadow;
      PolyLine([Point(R.Right, R.Top), Point(R.Right, R.Bottom),
        Point(R.Left, R.Bottom)]);
    end;
  end;

begin
  AClassName := UpperCase(Component.ClassName);
  BIndex := ComponentsBitmap.IndexOf(AClassName);
  if BIndex >= 0 then
  begin
    Result := TBitmap(ComponentsBitmap.Objects[BIndex]);
    Exit;
  end;
  NewBM := TBitmap.Create;
  NewBM.Width := 28;
  NewBM.Height := 28;
  NewBM.Canvas.Brush.Color := clBtnFace;
  NewBM.Canvas.FillRect(NewBM.Canvas.ClipRect);
  TmpImage := TImage.Create(nil);
  TmpImage.Center := True;
  TmpImage.Transparent := True;
  HResInfo := 0;
  ResClass := Component.ClassType;
  ResClassName := UpperCase(ResClass.ClassName);
  while True do
  begin
{$IFDEF CIL}
{$ELSE}
    HResInfo := FindResourceGlobal(ResClassName, RT_BITMAP, InModule);
{$ENDIF}
    if HResInfo <> 0 then
    begin
      TmpImage.Picture.Bitmap.LoadFromResourceName(InModule, ResClassName);
      NewBM.Canvas.Draw(2,2,TmpImage.Picture.Graphic);
      Break;
    end;
    ResClass := ResClass.ClassParent;
    if ResClass = nil then Break;
    ResClassName := UpperCase(ResClass.ClassName);
  end;
  if HResInfo = 0 then
  begin
    HResInfo := FindResourceGlobal('NEWCOMP', RT_BITMAP, InModule);
    if HResInfo <> 0 then
    begin
      TmpImage.Picture.Bitmap.LoadFromResourceName(InModule, 'NEWCOMP');
      NewBM.Canvas.Draw(2,2,TmpImage.Picture.Graphic);
    end;
  end;
  BevelRect(NewBM.Canvas.ClipRect);
  TmpImage.Free;
  ComponentsBitmap.AddObject(AClassName, NewBM);
  Result := NewBM;
end;
{$ENDIF}

{ TDBGridEhColumnsProperty }

procedure TDBGridEhColumnsProperty.Edit;
var
  Obj: TPersistent;
begin
  Obj := GetComponent(0);
  while (Obj <> nil) and not (Obj is TComponent) do
    Obj := GetUltimateOwner(Obj);
  ShowCollectionEditorClass(Designer, TDBGridEhColumnsEditor, TComponent(Obj),
//    TCustomDBGridEh(Obj).Columns, 'Columns', [coAdd, coDelete, coMove]);
{$IFDEF CIL}
    TCollection(GetObjValue),
{$ELSE}
    TCollection(GetOrdValue),
{$ENDIF}
     'Columns', [coAdd, coDelete, coMove]);
end;

function TDBGridEhColumnsProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly {, paSubProperties}];
end;

function TDBGridEhColumnsProperty.GetValue: string;
begin
{$IFDEF CIL}
  FmtStr(Result, '(%s)', [GetPropType.Name]);
{$ELSE}
  FmtStr(Result, '(%s)', [GetPropType^.Name]);
{$ENDIF}
end;

{ TDBGridEhEditor }

procedure TDBGridEhEditor.ExecuteVerb(Index: Integer);
//var
//  Msg: TCMChanged;
begin
  case Index of
    0:
      ShowCollectionEditorClass(Designer, TDBGridEhColumnsEditor, Component,
        TCustomDBGridEh(Component).Columns, 'Columns', [coAdd, coDelete, coMove]);
    1:
      begin
        if GetGlobalHideConnectedComponens then
        begin
          GlobalHideConnectedComponens := False;
          SaveGlobalHideConnectedComponens;
        end else
        begin
          GlobalHideConnectedComponens := True;
          SaveGlobalHideConnectedComponens;
        end;

//        Msg.Msg := CM_CHANGED;
//        Msg.Unused := 0;
//        Msg.Child := TCustomDBGridEh(Component);
//        Msg.Result := 0;
{$IFDEF CIL}
{$ELSE}
        if (TCustomDBGridEh(Component).Owner is TWinControl) then
          BroadcastPerformMessageFor(TCustomDBGridEh(Component).Owner,
            TCustomDBGridEh, CM_CHANGED, 0, Longint(Component));
{$ENDIF}
//          TWinControl(TCustomDBGridEh(Component).Owner).Broadcast(Msg);
      end;
  end;
end;

function TDBGridEhEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'Columns Editor ...';
    1:
      begin
//        ShowMessage('GlobalHideConnectedComponens:' + BoolToStr(GlobalHideConnectedComponens));
        if GetGlobalHideConnectedComponens
          then Result := 'Show connected components'
          else Result := 'Hide connected components';
      end;
  end;
end;

function TDBGridEhEditor.GetVerbCount: Integer;
begin
//  Result := 2;
  Result := 1;
end;

{ TCustomDBGridEhCracker }

type
  TCustomDBGridEhCracker = class(TCustomDBGridEh)
  public
    procedure BeginLayout;
    procedure EndLayout;
  end;

procedure TCustomDBGridEhCracker.BeginLayout;
begin
  inherited BeginLayout;
end;

procedure TCustomDBGridEhCracker.EndLayout;
begin
  inherited EndLayout;
end;

type
  TCollectionCracker = class(TCollection);
{ TDBGridEhColumnsEditor }

procedure TDBGridEhColumnsEditor.AddAllFieldsCmdExecute(Sender: TObject);
var msgValue: Word;
//    i:Integer;
//    Col:TColumnEh;
  DBGridEh: TCustomDBGridEh;
begin
{$IFDEF CIL}
  DBGridEh := TCustomDBGridEh(Collection.Owner);
{$ELSE}
  DBGridEh := TCustomDBGridEh(TCollectionCracker(Collection).GetOwner);
{$ENDIF}
  if not Assigned(DBGridEh) then Exit;
  if (DBGridEh.Columns.State = csDefault) then
    DBGridEh.Columns.State := csCustomized
  else
  begin
{$IFDEF CIL}
    DBGridEh.Columns.BeginUpdate;
{$ELSE}
    TCustomDBGridEhCracker(DBGridEh).BeginLayout;
{$ENDIF}
    try
      if (DBGridEh.Columns.Count > 0) then
      begin
        msgValue := MessageDlg('Delete existing columns?',
          mtConfirmation, [mbYes, mbNo, mbCancel], 0);
        case msgValue of
          mrYes: DBGridEh.Columns.Clear;
          mrCancel: Exit;
        end;
      end;
     {for i := 0 to DBGridEh.DataSource.DataSet.FieldCount - 1 do
     begin
       Col := DBGridEh.Columns.Add;
       Col.FieldName := DBGridEh.DataSource.DataSet.Fields[i].FieldName;
     end;}
      DBGridEh.Columns.AddAllColumns(False);
    finally
{$IFDEF CIL}
      DBGridEh.Columns.EndUpdate;
{$ELSE}
      TCustomDBGridEhCracker(DBGridEh).EndLayout;
{$ENDIF}
      UpdateListbox;
    end;
  end;
  Designer.Modified;
end;

procedure TDBGridEhColumnsEditor.RestoreDefaultsCmdExecute(Sender: TObject);
var i: Integer;
  DBGridEh: TCustomDBGridEh;
begin
{$IFDEF CIL}
  DBGridEh := TCustomDBGridEh(Collection.Owner);
{$ELSE}
  DBGridEh := TCustomDBGridEh(TCollectionCracker(Collection).GetOwner);
{$ENDIF}
  if not Assigned(DBGridEh) then Exit;
  if (ListView1.SelCount > 0) then
  begin
    for i := 0 to ListView1.SelCount - 1 do
      DBGridEh.Columns[i].RestoreDefaults;
    Designer.Modified;
    UpdateListbox;
  end;
end;

procedure TDBGridEhColumnsEditor.AddAllFieldsCmdUpdate(Sender: TObject);
var DBGridEh: TCustomDBGridEh;
begin
{$IFDEF CIL}
  DBGridEh := TCustomDBGridEh(Collection.Owner);
{$ELSE}
  DBGridEh := TCustomDBGridEh(TCollectionCracker(Collection).GetOwner);
{$ENDIF}
  AddAllFieldsCmd.Enabled := Assigned(DBGridEh) and
    Assigned(DBGridEh.DataSource) and Assigned(DBGridEh.Datasource.Dataset) and
    (DBGridEh.Datasource.Dataset.FieldCount > 0);
end;

procedure TDBGridEhColumnsEditor.RestoreDefaultsCmdUpdate(Sender: TObject);
begin
  RestoreDefaultsCmd.Enabled := ListView1.Items.Count > 0;
end;

function TDBGridEhColumnsEditor.CanAdd(Index: Integer): Boolean;
var DBGridEh: TCustomDBGridEh;
begin
  Result := False;
{$IFDEF CIL}
  DBGridEh := TCustomDBGridEh(Collection.Owner);
{$ELSE}
  DBGridEh := TCustomDBGridEh(TCollectionCracker(Collection).GetOwner);
{$ENDIF}
  if Assigned(DBGridEh) then
    Result := (DBGridEh.Columns.State = csCustomized);
end;

{ TDBGridEhFieldProperty }

function TDBGridEhFieldProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paMultiSelect];
end;

procedure TDBGridEhFieldProperty.GetValueList(List: TStrings);
var
  Ehg: TCustomDBGridEh;
begin
  if (GetComponent(0) = nil) then Exit;
  if (GetComponent(0) is TColumnEh) then
    Ehg := (GetComponent(0) as TColumnEh).Grid
  else if (GetComponent(0) is TColumnFooterEh) then
    Ehg := (GetComponent(0) as TColumnFooterEh).Column.Grid
  else Exit;

  if (Ehg <> nil) and (TCustomDBGridEh(Ehg).DataSource <> nil) and (TCustomDBGridEh(Ehg).DataSource.DataSet <> nil) then
  begin
    TCustomDBGridEh(Ehg).DataSource.DataSet.GetFieldNames(List);
  end;
end;

procedure TDBGridEhFieldProperty.GetValues(Proc: TGetStrProc);
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

{ TDBGridEhFieldAggProperty }

procedure TDBGridEhFieldAggProperty.GetValueList(List: TStrings);
var
  Ehg: TCustomDBGridEh;
  AggList: TStringList;
begin
  if (GetComponent(0) = nil) then Exit;
  if (GetComponent(0) is TColumnEh) then
    Ehg := (GetComponent(0) as TColumnEh).Grid
  else if (GetComponent(0) is TColumnFooterEh) then
    Ehg := (GetComponent(0) as TColumnFooterEh).Column.Grid
  else Exit;

  if (Ehg <> nil) and (TCustomDBGridEh(Ehg).DataSource <> nil) and (TCustomDBGridEh(Ehg).DataSource.DataSet <> nil) then
  begin
    TCustomDBGridEh(Ehg).DataSource.DataSet.GetFieldNames(List);
    if TCustomDBGridEh(Ehg).DataSource.DataSet.AggFields.Count > 0 then
    begin
      AggList := TStringList.Create;
      try
        TCustomDBGridEh(Ehg).DataSource.DataSet.AggFields.GetFieldNames(AggList);
        List.AddStrings(AggList);
      finally
        AggList.Free;
      end;
    end;
  end;
end;

{ TDBLookupComboboxEhEditor }

procedure TDBLookupComboboxEhEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0:
      ShowCollectionEditorClass(Designer, TDBGridEhColumnsEditor, Component,
        TDBLookupComboboxEh(Component).DropDownBox.Columns, 'Columns', [coAdd, coDelete, coMove]);
  end;
end;

function TDBLookupComboboxEhEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'DropDownBox.Columns Editor ...';
  end;
end;

function TDBLookupComboboxEhEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

{ TDBGridEhDesignControler }

constructor TDBGridEhDesignControler.Create;
var
  LIDesignNotification: IDesignNotification;
  HResInfo: THandle;
  InModule: HMODULE;
//  Stream: TCustomMemoryStream;
//  Icon: TIcon;
  TmpImage: TImage;
begin
  inherited Create;
  FGridList := TList.Create;
  if Supports(TObject(Self), IDesignNotification, LIDesignNotification) then
  begin
  {$IFDEF EH_LIB_6}
    RegisterDesignNotification(LIDesignNotification);
  {$ENDIF}
  end;
  FCornerImage := TBitmap.Create;

{$IFDEF CIL}
{$ELSE}
  HResInfo := FindResourceGlobal('SELECT_BALL', RT_GROUP_ICON{RT_ICON}{RT_BITMAP}, InModule);
  if HResInfo <> 0 then
  begin
    TmpImage := TImage.Create(nil);
//    TmpImage.Transparent := True;
//    TmpImage.Picture.Icon.LoadFromResourceName(InModule, 'SELECT_BALL');
    TmpImage.Picture.Icon.Handle := LoadIcon(InModule, PChar('SELECT_BALL'));


//    DrawIconEx(FCornerImage.Canvas.Handle,
//      0, 0, TmpImage.Picture.Icon.Handle, 8, 8, 0, 0, DI_NORMAL);
    FCornerImage.Width := 32;
    FCornerImage.Height := 32;
    FCornerImage.Transparent := True;
    FCornerImage.Canvas.Draw(0,0, TmpImage.Picture.Graphic);
    TmpImage.Free;
  end;
{$ENDIF}
end;

destructor TDBGridEhDesignControler.Destroy;
//var
//  LIDesignNotification: IDesignNotification;
begin
  FreeAndNil(FGridList);
  FreeAndNil(FCornerImage);
//  if Supports(Self, IDesignNotification, LIDesignNotification) then
//    UnregisterDesignNotification(LIDesignNotification);
  inherited Destroy;
end;

function TDBGridEhDesignControler.ControlIsObjInspSelected(
  Control: TPersistent): Boolean;
begin
  Result := False;
  if GetObjInspSelectedControl(Control) = Control then
    Result := True;
end;

function TDBGridEhDesignControler.GetObjInspSelectedControl(BaseControl: TPersistent): TPersistent;
var
  List: IDesignerSelections;
{$IFDEF EH_LIB_6}
    LDesigner: IDesigner;
{$ELSE}
    LDesigner: IFormDesigner;
{$ENDIF}
begin
  Result := nil;
{$IFDEF EH_LIB_6}
  if Supports(FindRootDesigner(BaseControl), IDesigner, LDesigner) then
{$ELSE}
  if Supports(FindRootDesigner(BaseControl), IFormDesigner, LDesigner) then
{$ENDIF}
  begin
    List := CreateSelectionList;
    LDesigner.GetSelections(List);
    if (List <> nil) and (List.Count = 1) then
{$IFDEF EH_LIB_6}
      Result := List[0];
{$ELSE}
      Result := ExtractPersistent(List[0]);
{$ENDIF}
  end;
end;

function TDBGridEhDesignControler.GetSelectComponentCornerImage: TBitmap;
begin
  if not FCornerImage.Empty
    then Result := FCornerImage
    else Result := nil;
end;

function TDBGridEhDesignControler.GetDesignInfoItemClass: TCollectionItemClass;
begin
  Result := TSaveComponentDesignInfoItemEh;
end;

procedure TDBGridEhDesignControler.DesignMouseDown(Control: TPersistent; X,
  Y: Integer; AShift: TShiftState);
var
  DBGridEh: TCustomDBGridEh;
  Column: TColumnEh;
  Cell: TGridCoord;
  ARect: TRect;
{$IFDEF EH_LIB_6}
  LDesigner: IDesigner;
{$ELSE}
  LDesigner: IFormDesigner;
{$ENDIF}
begin
  if not IsDesignHitTest(Control, X, Y, AShift) then
    Exit;
  DBGridEh := (Control as TCustomDBGridEh);
  Cell := DBGridEh.MouseCoord(X, Y);
  if (DBGridEh.Columns.State = csCustomized) and (dgTitles in DBGridEh.Options)
    and (Cell.Y = 0) and (Cell.X >= DBGridEh.IndicatorOffset) then
  begin
    if DBGridEh.RowPanel then
    begin
      ARect := DBGridEh.CellRect(Cell.X, Cell.Y);
{$IFDEF CIL}
{$ELSE}
      Column := DBGridEh.GetColumnInRowPanelAtPos(Point(X-ARect.Left+TCustomDBGridEhCracker(DBGridEh).FDataOffset.cx, Y-ARect.Top));
{$ENDIF}
    end else
    Column := DBGridEh.Columns[Cell.X-DBGridEh.IndicatorOffset];
    if Column = nil then Exit;
{$IFDEF EH_LIB_6}
    if Supports(FindRootDesigner(DBGridEh), IDesigner, LDesigner) then
{$ELSE}
    if Supports(FindRootDesigner(DBGridEh), IFormDesigner, LDesigner) then
{$ENDIF}
    begin
      LDesigner.SelectComponent(Column);
      DBGridEh.Invalidate;
    end;
  end;
end;

function TDBGridEhDesignControler.IsDesignHitTest(Control: TPersistent; X,
  Y: Integer; AShift: TShiftState): Boolean;
var
  DBGridEh: TCustomDBGridEhCracker;
  Cell: TGridCoord;
  DSPanel: TGridDesignPanelEh;
begin
  Result := False;
  if not (Control is TCustomDBGridEh)
    then Exit
    else DBGridEh := TCustomDBGridEhCracker(Control as TCustomDBGridEh);
  Cell := DBGridEh.MouseCoord(X, Y);
{$IFDEF CIL}
// To do
{$ELSE}
  if DBGridEh.FrozenSizing(X,Y) or DBGridEh.Sizing(X,Y) then
    Exit;
{$ENDIF}
  if (ssLeft in AShift) and (dgTitles in DBGridEh.Options) and
     (Cell.Y = 0) and (Cell.X >= DBGridEh.IndicatorOffset) then
  begin
    Result := True;
  end else if (ssLeft in AShift) and Assigned(DBGridEh.DataSource) then
  begin
    DSPanel := TGridDesignPanelEh(DBGridEh.FindComponent('DesignTimePanel'));
    if DSPanel <> nil then
    begin
//      ShowMessage('X:'+IntToStr(X)+' Y:'+IntToStr(X)+'  Left:'+IntToStr(DSPanel.BoundsRect.Left));
{$IFDEF CIL}
{$ELSE}
      if PtInRect(DSPanel.BoundsRect, Point(X,Y)) then
{$ENDIF}
      begin
        Result := True;
      end;
    end;
  end;
end;

{$IFDEF EH_LIB_6}
procedure TDBGridEhDesignControler.DesignerClosed(
  const ADesigner: IDesigner; AGoingDormant: Boolean);
{$ELSE}
procedure TDBGridEhDesignControler.DesignerClosed(const ADesigner: IUnknown);
{$ENDIF}
begin

end;

{$IFDEF EH_LIB_6}
procedure TDBGridEhDesignControler.DesignerOpened(
  const ADesigner: IDesigner; AResurrecting: Boolean);
{$ELSE}
procedure TDBGridEhDesignControler.DesignerInitialized(const ADesigner: IUnknown);
{$ENDIF}
begin

end;

{$IFDEF EH_LIB_6}
procedure TDBGridEhDesignControler.ItemDeleted(const ADesigner: IDesigner;
  AItem: TPersistent);
{$ELSE}
procedure TDBGridEhDesignControler.ItemDeleted(const AItem: IPersistent);
{$ENDIF}
begin
{  if AItem is TCustomDBGridEh then
  begin
//    TCustomDBGridEh(AItem).DataSource := nil; //To restore hiden design-time components.
    ShowMessage('AItem.ClassName');
  end;}
end;

{$IFDEF EH_LIB_6}
procedure TDBGridEhDesignControler.ItemInserted(const ADesigner: IDesigner;
  AItem: TPersistent);
{$ELSE}
procedure TDBGridEhDesignControler.ItemInserted(const AItem: IPersistent);
{$ENDIF}
begin

end;

{$IFDEF EH_LIB_6}
procedure TDBGridEhDesignControler.ItemsModified(
  const ADesigner: IDesigner);
{$ELSE}
procedure TDBGridEhDesignControler.ItemsModified(const ADesigner: IUnknown);
{$ENDIF}
begin

end;

{$IFDEF EH_LIB_6}
procedure TDBGridEhDesignControler.SelectionChanged(
  const ADesigner: IDesigner; const ASelection: IDesignerSelections);
{$ELSE}
procedure TDBGridEhDesignControler.SelectionChanged(const ASelection: IDesignerSelections);
{$ENDIF}
var
  i: Integer;
  DSPanel: TGridDesignPanelEh;
begin
  if FGridList = nil then Exit;
  for i := 0 to FGridList.Count-1 do
  begin
    TCustomDBGridEh(FGridList[i]).InvalidateTitle;
    DSPanel := TGridDesignPanelEh(TCustomDBGridEh(FGridList[i]).FindComponent('DesignTimePanel'));
    if DSPanel <> nil then DSPanel.Invalidate;
  end;
end;

procedure TDBGridEhDesignControler.RegisterChangeSelectedNotification(
  Control: TPersistent);
begin
  if FGridList = nil then Exit;
  if FGridList.IndexOf(Control) < 0 then
    FGridList.Add(Control);
  if Control is TCustomDBGridEh then
    CreateDesingPanel(Control as TCustomDBGridEh);
end;

procedure TDBGridEhDesignControler.CreateDesingPanel(DBGridEh: TCustomDBGridEh);
begin
  TGridDesignPanelEh.CreateForGrid(DBGridEh);
end;

procedure TDBGridEhDesignControler.UnregisterChangeSelectedNotification(
  Control: TPersistent);
begin
  if FGridList = nil then Exit;
  FGridList.Remove(Control);
end;

procedure TDBGridEhDesignControler.KeyProperyModified(Control: TControl);
var
  i: Integer;
  DSPanel: TGridDesignPanelEh;
begin
  if FGridList = nil then Exit;
  for i := 0 to FGridList.Count-1 do
  begin
    DSPanel := TGridDesignPanelEh(TCustomDBGridEh(FGridList[i]).FindComponent('DesignTimePanel'));
    if DSPanel <> nil then DSPanel.UpdateState;
  end;
end;

{ TGridDesignPanelEh }

constructor TGridDesignPanelEh.CreateForGrid(AOwner: TCustomDBGridEh);
begin
  inherited Create(AOwner);
  Name := 'DesignTimePanel';
  Grid := AOwner;
  Parent := Grid;
  Width := 0;
  Height := 32 + 2;
  Left := Grid.Width - 32 * 4 - 2;
  Top := Grid.Height - 36;
  BevelOuter := bvNone;
  BorderStyle := bsSingle;
  Ctl3D := False;
  ParentCtl3D := False;
  Anchors := [akRight, akBottom];
  Caption := '';
//  Color := clInactiveCaptionText;
  Color := clSkyBlue;
end;

procedure TGridDesignPanelEh.Paint;
var
  ImageComponent: TComponent;
  bm: TBitmap;
  bf : BLENDFUNCTION;

{$IFDEF CIL}
{$ELSE}
  procedure DrawSelectedBorder(ARect: TRect);
  var
    bm: TBitmap;
  begin
    bm := DBGridEhDesigntControler.GetSelectComponentCornerImage;
//    bm := nil;
    if bm <> nil then
    begin
      Canvas.StretchDraw(Rect(ARect.Left-3, ARect.Top-3, ARect.Left+5, ARect.Top+5), bm);
      Canvas.StretchDraw(Rect(ARect.Right-3, ARect.Top-3, ARect.Right+5, ARect.Top+5), bm);
      Canvas.StretchDraw(Rect(ARect.Right-3, ARect.Bottom-3, ARect.Right+5, ARect.Bottom+5), bm);
      Canvas.StretchDraw(Rect(ARect.Left-3, ARect.Bottom-3, ARect.Left+5, ARect.Bottom+5), bm);
    end else
    begin
      Canvas.Brush.Color := clBlack;
      Canvas.FillRect(Rect(ARect.Left-2, ARect.Top-2, ARect.Left+3, ARect.Top+3));
      Canvas.FillRect(Rect(ARect.Right-2, ARect.Top-2, ARect.Right+3, ARect.Top+3));
      Canvas.FillRect(Rect(ARect.Right-2, ARect.Bottom-2, ARect.Right+3, ARect.Bottom+3));
      Canvas.FillRect(Rect(ARect.Left-2, ARect.Bottom-2, ARect.Left+3, ARect.Bottom+3));
    end;
  end;
{$ENDIF}

begin
  inherited Paint;
{$IFDEF CIL}
{$ELSE}
  if Assigned(Grid.DataSource) and (Grid.DataSource.Owner = Grid.Owner) then
  begin
    ImageComponent := Grid.DataSource;
    bm := GetDesigntimeBitmapOfComponent(ImageComponent);
    if bm <> nil then
    begin
      bf.BlendOp := AC_SRC_OVER;
      bf.BlendFlags := 0;
      bf.SourceConstantAlpha := Trunc(255/100*40); // 40% transparency
      bf.AlphaFormat := 0;
      Windows.AlphaBlend(Canvas.Handle, 2, 2, 28, 28,
        bm.Canvas.Handle, 0, 0, 28, 28, bf);
    end;
    if DBGridEhDesigntControler.GetObjInspSelectedControl(Grid) = ImageComponent then
    begin
      DrawSelectedBorder(Rect(2,2,32-3,29));
{      Canvas.Brush.Color := clBlack;
      Canvas.FillRect(Rect(0, 0, 5, 5));
      Canvas.FillRect(Rect(27, 0, 32, 5));
      Canvas.FillRect(Rect(27, ClientHeight-5, 32, ClientHeight));
      Canvas.FillRect(Rect(0, ClientHeight-5, 5, ClientHeight));}
    end;
  end;

  if Assigned(Grid.DataSource) and Assigned(Grid.DataSource.DataSet) and
    (Grid.DataSource.DataSet.Owner = Grid.Owner) then
  begin
    ImageComponent := Grid.DataSource.DataSet;
    bm := GetDesigntimeBitmapOfComponent(ImageComponent);
    if bm <> nil then
    begin
      bf.BlendOp := AC_SRC_OVER;
      bf.BlendFlags := 0;
      bf.SourceConstantAlpha := Trunc(255/100*40); // 40% transparency
      bf.AlphaFormat := 0;
      Windows.AlphaBlend(Canvas.Handle, 32+2, 2, 28, 28,
        bm.Canvas.Handle, 0, 0, 28, 28, bf);
    end;
    if DBGridEhDesigntControler.GetObjInspSelectedControl(Grid) = ImageComponent then
    begin
      DrawSelectedBorder(Rect(32+2,2,32*2-3,29));
{      Canvas.Brush.Color := clBlack;
      Canvas.FillRect(Rect(32, 0, 32+5, 5));
      Canvas.FillRect(Rect(32*2, 0, 32*2-5, 5));
      Canvas.FillRect(Rect(32*2, ClientHeight-5, 32*2-5, ClientHeight));
      Canvas.FillRect(Rect(32, ClientHeight-5, 32+5, ClientHeight));}
    end;
  end;

  if Assigned(Grid.DataSource) and
     Assigned(Grid.DataSource.DataSet) and
     (Grid.DataSource.DataSet is TCustomMemTableEh) and
     Assigned((Grid.DataSource.DataSet as TCustomMemTableEh).DataDriver) and
     ((Grid.DataSource.DataSet as TCustomMemTableEh).DataDriver.Owner = Grid.Owner) then
  begin
    ImageComponent := (Grid.DataSource.DataSet as TCustomMemTableEh).DataDriver;
    bm := GetDesigntimeBitmapOfComponent(ImageComponent);
    if bm <> nil then
    begin
      bf.BlendOp := AC_SRC_OVER;
      bf.BlendFlags := 0;
      bf.SourceConstantAlpha := Trunc(255/100*40); // 40% transparency
      bf.AlphaFormat := 0;
      Windows.AlphaBlend(Canvas.Handle, 32*2+2, 2, 28, 28,
        bm.Canvas.Handle, 0, 0, 28, 28, bf);
    end;
    if DBGridEhDesigntControler.GetObjInspSelectedControl(Grid) = ImageComponent then
    begin
      DrawSelectedBorder(Rect(32*2+2,2,32*3-3,29));
{      Canvas.Brush.Color := clBlack;
      Canvas.FillRect(Rect(32*2, 0, 32*2+5, 5));
      Canvas.FillRect(Rect(32*3, 0, 32*3-5, 5));
      Canvas.FillRect(Rect(32*3, ClientHeight-5, 32*3-5, ClientHeight));
      Canvas.FillRect(Rect(32*2, ClientHeight-5, 32*2+5, ClientHeight));}
    end;
  end;

  if Assigned(Grid.DataSource) and
     Assigned(Grid.DataSource.DataSet) and
     (Grid.DataSource.DataSet is TCustomMemTableEh) and
     Assigned((Grid.DataSource.DataSet as TCustomMemTableEh).DataDriver) and
     Assigned(TDataDriverEhCracker((Grid.DataSource.DataSet as TCustomMemTableEh).DataDriver).ProviderDataSet) and
     (TDataDriverEhCracker((Grid.DataSource.DataSet as TCustomMemTableEh).DataDriver).ProviderDataSet.Owner = Grid.Owner)
  then
  begin
    ImageComponent := TDataDriverEhCracker((Grid.DataSource.DataSet as TCustomMemTableEh).DataDriver).ProviderDataSet;
    bm := GetDesigntimeBitmapOfComponent(ImageComponent);
    if bm <> nil then
    begin
      bf.BlendOp := AC_SRC_OVER;
      bf.BlendFlags := 0;
      bf.SourceConstantAlpha := Trunc(255/100*40); // 40% transparency
      bf.AlphaFormat := 0;
      Windows.AlphaBlend(Canvas.Handle, 32*3+2, 2, 28, 28,
        bm.Canvas.Handle, 0, 0, 28, 28, bf);
    end;
    if DBGridEhDesigntControler.GetObjInspSelectedControl(Grid) = ImageComponent then
    begin
      DrawSelectedBorder(Rect(32*3+2,2,32*4-3,29));
{      Canvas.Brush.Color := clBlack;
      Canvas.FillRect(Rect(32*3, 0, 32*3+5, 5));
      Canvas.FillRect(Rect(32*4, 0, 32*4-5, 5));
      Canvas.FillRect(Rect(32*4, ClientHeight-5, 32*4-5, ClientHeight));
      Canvas.FillRect(Rect(32*3, ClientHeight-5, 32*3+5, ClientHeight));}
    end;
  end;
{$ENDIF}
end;

procedure TGridDesignPanelEh.CMDesignHitTest(var Msg: TCMDesignHitTest);
begin
//  if (ssLeft in KeysToShiftState(Msg.Keys)) then
    Msg.Result := Longint(BOOL(True));
//    ShowMessage('IsDesignHitTest = True');
end;

procedure TGridDesignPanelEh.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  ARect: TRect;
  P: TPoint;
  MenuItem: TPanelMenuItem;
  ComponentEditor: IComponentEditor;
  SelComponent: TComponent;
  i: Integer;
var
{$IFDEF EH_LIB_6}
  LDesigner: IDesigner;
{$ELSE}
  LDesigner: IFormDesigner;
{$ENDIF}
begin
{$IFDEF CIL}
{$ELSE}
  SelComponent := nil;
{$IFDEF EH_LIB_6}
  if Supports(FindRootDesigner(Grid), IDesigner, LDesigner) then
{$ELSE}
  if Supports(FindRootDesigner(Grid), IFormDesigner, LDesigner) then
{$ENDIF}
  begin
    ARect := Rect(2, 2, 32-2, ClientHeight-2);
    if PtInRect(ARect, Point(X,Y)) and Assigned(Grid.DataSource) and
       (Grid.DataSource.Owner = Grid.Owner) then
    begin
      SelComponent := Grid.DataSource;
      LDesigner.SelectComponent(SelComponent);
      Invalidate;
    end;

    ARect := Rect(32+2, 2, 32*2-2, ClientHeight-2);
    if PtInRect(ARect, Point(X,Y)) and
       Assigned(Grid.DataSource) and
       Assigned(Grid.DataSource.DataSet) and
       (Grid.DataSource.DataSet.Owner = Grid.Owner) then
    begin
      SelComponent := Grid.DataSource.DataSet;
      LDesigner.SelectComponent(SelComponent);
      Invalidate;
    end;

    ARect := Rect(32*2+2, 2, 32*3-2, ClientHeight-2);
    if PtInRect(ARect, Point(X,Y)) and
       Assigned(Grid.DataSource) and
       Assigned(Grid.DataSource.DataSet) and
       (Grid.DataSource.DataSet is TCustomMemTableEh) and
       Assigned((Grid.DataSource.DataSet as TCustomMemTableEh).DataDriver) and
       ((Grid.DataSource.DataSet as TCustomMemTableEh).DataDriver.Owner = Grid.Owner) then
    begin
      SelComponent := (Grid.DataSource.DataSet as TCustomMemTableEh).DataDriver;
      LDesigner.SelectComponent(SelComponent);
      Invalidate;
    end;

    ARect := Rect(32*3+2, 2, 32*4-2, ClientHeight-2);
    if PtInRect(ARect, Point(X,Y)) and
       Assigned(Grid.DataSource) and
       Assigned(Grid.DataSource.DataSet) and
       (Grid.DataSource.DataSet is TCustomMemTableEh) and
       Assigned((Grid.DataSource.DataSet as TCustomMemTableEh).DataDriver) and
       Assigned(TDataDriverEhCracker((Grid.DataSource.DataSet as TCustomMemTableEh).DataDriver).ProviderDataSet) and
       (TDataDriverEhCracker((Grid.DataSource.DataSet as TCustomMemTableEh).DataDriver).ProviderDataSet.Owner = Grid.Owner)
    then
    begin
      SelComponent := TDataDriverEhCracker((Grid.DataSource.DataSet as TCustomMemTableEh).DataDriver).ProviderDataSet;
      LDesigner.SelectComponent(SelComponent);
      Invalidate;
    end;

  end;

  if (ssRight in Shift) or ((ssLeft in Shift) and (ssDouble in Shift)) then
  begin
    if DropdownMenu = nil then
      DropdownMenu := TPopupMenu.Create(Self);
    DropdownMenu.Items.Clear;
//    DropdownMenu.Name := '';
    ComponentEditor := GetComponentEditor(SelComponent, LDesigner);
    if ComponentEditor = nil then Exit;
    for i := 0 to ComponentEditor.GetVerbCount-1 do
    begin
      MenuItem := TPanelMenuItem.Create(Self);
      MenuItem.Caption := ComponentEditor.GetVerb(i);
      MenuItem.ComponentEditor := ComponentEditor;
      MenuItem.VerbNo := i;
      MenuItem.OnClick := MenuClick;
      DropdownMenu.Items.Add(MenuItem);
    end;
    P := ClientToScreen(Point(X, Y));
    if (ssLeft in Shift) and (ssDouble in Shift) and (DropdownMenu.Items.Count > 0)
      then DropdownMenu.Items[0].Click
      else DropdownMenu.Popup(P.X, P.Y);

//    DropdownMenu.Free;
  end;
//  inherited MouseDown(Button, Shift, X, Y);
{$ENDIF}
end;

procedure TGridDesignPanelEh.MenuClick(Sender: TObject);
begin
//  ShowMessage('TGridDesignPanelEh.MenuClick');
  if Sender is TPanelMenuItem then
    if TPanelMenuItem(Sender).ComponentEditor <> nil then
      TPanelMenuItem(Sender).ComponentEditor.ExecuteVerb(TPanelMenuItem(Sender).VerbNo);
end;

procedure TGridDesignPanelEh.UpdateState;
var
  WidthX: Integer;

  i: Integer;
{$IFDEF CIL}
{$ELSE}
  function GetDesignInfoItem(ComponentName: String): TSaveComponentDesignInfoItemEh;
  var
    i: Integer;
    DesignInfoItem: TSaveComponentDesignInfoItemEh;
  begin
    Result := nil;
    for i := 0 to TCustomDBGridEhCracker(Grid).FDesignInfoCollection.Count-1 do
    begin
      DesignInfoItem := TSaveComponentDesignInfoItemEh(TCustomDBGridEhCracker(Grid).FDesignInfoCollection.Items[i]);
      if DesignInfoItem.ComponentName = ComponentName then
      begin
        Result := DesignInfoItem;
        Exit;
      end;
    end;
//    Result := TSaveComponentDesignInfoItemEh(TCustomDBGridEhCracker(Grid).FDesignInfoCollection.Add);
  end;

  procedure XModuleServicesSaveAll;
  var
    Form: TCustomForm;
    XModuleServices: IOTAModuleServices;
    XResult: HResult;
  begin
    if csDesigning in Grid.ComponentState then
    begin
      Form := GetParentForm(Self);
      if (Form <> nil) and (Form.Designer <> nil) then Form.Designer.Modified;

      XResult := BorlandIDEServices.QueryInterface(IOTAModuleServices, XModuleServices);
      if (XResult=S_Ok) and Assigned(XModuleServices) then XModuleServices.SaveAll;
    end;
  end;

  procedure HideComponent(Component: TComponent);
  var
    DesignInfoItem: TSaveComponentDesignInfoItemEh;
  begin
    if not (csLoading in Grid.ComponentState) and (Component.Name <> '') then
    begin
      if TCustomDBGridEhCracker(Grid).FDesignInfoCollection <> nil then
      begin
        DesignInfoItem := GetDesignInfoItem(Component.Name);
        if DesignInfoItem <> nil then
          DesignInfoItem.InGrid := True
        else
        begin
          DesignInfoItem := TSaveComponentDesignInfoItemEh(
            TCustomDBGridEhCracker(Grid).FDesignInfoCollection.Add);
//          if (Component.DesignInfo <> MakeLong(Word(-20), Word(-20))) then
//          begin
            DesignInfoItem.Left := LongRec(Component.DesignInfo).Lo;
            DesignInfoItem.Top := LongRec(Component.DesignInfo).Hi;
            DesignInfoItem.ComponentName := Component.Name;
            DesignInfoItem.InGrid := True;

            Component.DesignInfo := MakeLong(Word(-20), Word(-20));
            XModuleServicesSaveAll;

//          end;
        end;
      end;
    end;
  end;

  procedure RestoreNotUsedComponents();
  var
    i: Integer;
    DesignInfoItem: TSaveComponentDesignInfoItemEh;
    Component: TComponent;
  begin
    for i := TCustomDBGridEhCracker(Grid).FDesignInfoCollection.Count-1 downto 0 do
    begin
      DesignInfoItem := TSaveComponentDesignInfoItemEh(
        TCustomDBGridEhCracker(Grid).FDesignInfoCollection.Items[i]);
      if not DesignInfoItem.InGrid then
      begin
        Component := Grid.Owner.FindComponent(DesignInfoItem.ComponentName);
//        if Component <> nil
//          then ShowMessage(DesignInfoItem.ComponentName)
//          else ShowMessage(DesignInfoItem.ComponentName+' not found');
        if (Component <> nil) then
        begin
          if MakeLong(Word(DesignInfoItem.Left), Word(DesignInfoItem.Top)) <>
            MakeLong(Word(-20), Word(-20)) then
          begin
            Component.DesignInfo := MakeLong(Word(DesignInfoItem.Left), Word(DesignInfoItem.Top));
            XModuleServicesSaveAll;
          end;  
        end;
        TCustomDBGridEhCracker(Grid).FDesignInfoCollection.Delete(i);
      end;
    end;
  end;
{$ENDIF}
begin
{$IFDEF CIL}
{$ELSE}
//  if not Grid.HandleAllocated or (csDestroying in  ComponentState) then
//    ShowMessage(Grid.Name+':not HandleAllocated or (csDestroying in  ComponentState)');
  if not Grid.HandleAllocated or (csDestroying in  ComponentState) then Exit;
  WidthX := 0;

  if TCustomDBGridEhCracker(Grid).FDesignInfoCollection <> nil then
    for i := 0 to TCustomDBGridEhCracker(Grid).FDesignInfoCollection.Count-1 do
      TSaveComponentDesignInfoItemEh(
        TCustomDBGridEhCracker(Grid).FDesignInfoCollection.Items[i]).InGrid := False;

  if Assigned(Grid.DataSource) and (Grid.DataSource.Owner = Grid.Owner)
  then
  begin
    Inc(WidthX);
    if GetGlobalHideConnectedComponens then
      HideComponent(Grid.DataSource);
  end;

  if Assigned(Grid.DataSource) and Assigned(Grid.DataSource.DataSet) and
    (Grid.DataSource.DataSet.Owner = Grid.Owner) then
  begin
    Inc(WidthX);
    if GetGlobalHideConnectedComponens then
      HideComponent(Grid.DataSource.DataSet);
  end;

  if Assigned(Grid.DataSource) and
     Assigned(Grid.DataSource.DataSet) and
     (Grid.DataSource.DataSet is TCustomMemTableEh) and
     Assigned((Grid.DataSource.DataSet as TCustomMemTableEh).DataDriver) and
     ((Grid.DataSource.DataSet as TCustomMemTableEh).DataDriver.Owner = Grid.Owner) then
  begin
    Inc(WidthX);
    if GetGlobalHideConnectedComponens then
      HideComponent((Grid.DataSource.DataSet as TCustomMemTableEh).DataDriver);
  end;

  if Assigned(Grid.DataSource) and
     Assigned(Grid.DataSource.DataSet) and
     (Grid.DataSource.DataSet is TCustomMemTableEh) and
     Assigned((Grid.DataSource.DataSet as TCustomMemTableEh).DataDriver) and
     Assigned(TDataDriverEhCracker((Grid.DataSource.DataSet as TCustomMemTableEh).DataDriver).ProviderDataSet) and
     (TDataDriverEhCracker((Grid.DataSource.DataSet as TCustomMemTableEh).DataDriver).ProviderDataSet.Owner = Grid.Owner)
  then
  begin
    Inc(WidthX);
    if GetGlobalHideConnectedComponens then
      HideComponent(TDataDriverEhCracker((Grid.DataSource.DataSet as TCustomMemTableEh).DataDriver).ProviderDataSet);
  end;

  RestoreNotUsedComponents();

  if WidthX = 0
    then Width := 0
    else ClientWidth := 32 * WidthX;
  Left := Grid.ClientWidth - 32 * WidthX - 4;
  Visible := (WidthX > 0);

  Height := 32 + 2;
  Top := Grid.ClientHeight - 36;
//  BringToFront;

//  if not Visible then
//    ShowMessage(Grid.Name+':not Visible');
//  ShowMessage(Grid.Name);

//  Invalidate;
{$ENDIF}
end;

procedure TGridDesignPanelEh.WndProc(var Message: TMessage);
var
  AMouseMessage: TWMMouse;
begin
  if (Message.Msg = WM_LBUTTONDOWN) then
  begin
  {$IFDEF CIL}
    AMouseMessage := TWMMouse.Create(Message);
  {$ELSE}
    AMouseMessage := TWMMouse(Message);
  {$ENDIF}
    begin
      if not IsControlMouseMsg(AMouseMessage) then
      begin
        ControlState := ControlState + [csLButtonDown];
        Dispatch(Message);
        ControlState := ControlState - [csLButtonDown];
      end;
      Exit;
    end;
  end;
  inherited WndProc(Message);
end;

{ DoFinalize }

procedure DoFinalize;
var
  LIDesignNotification: IDesignNotification;
  i: Integer;
begin
  if Assigned(DBGridEhDesigntControler) then
  begin
    Supports(TObject(DBGridEhDesigntControler), IDesignNotification, LIDesignNotification);
{$IFDEF EH_LIB_6}
    UnregisterDesignNotification(LIDesignNotification);
{$ENDIF}
  end;
  DBGridEhDesigntControler := nil;
  for i := 0 to ComponentsBitmap.Count-1 do
    ComponentsBitmap.Objects[i].Free;
  FreeAndNil(ComponentsBitmap);
end;

initialization
  RestoreGlobalHideConnectedComponens;
  DBGridEhDesigntControler := TDBGridEhDesignControler.Create;
  ComponentsBitmap := TStringList.Create;
  ComponentsBitmap.Sorted := True;
finalization
  DoFinalize;
end.
