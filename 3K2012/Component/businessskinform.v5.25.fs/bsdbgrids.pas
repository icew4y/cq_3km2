{*******************************************************************}
{                                                                   }
{       Almediadev Visual Component Library                         }
{       BusinessSkinForm                                            }
{       Version 5.25                                                }
{                                                                   }
{       Copyright (c) 2000-2006 Almediadev                          }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{       Home:  http://www.almdev.com                                }
{       Support: support@almdev.com                                 }
{                                                                   }
{*******************************************************************}

unit bsDBGrids;

{$R-}
{$WARNINGS OFF}
{$HINTS OFF}

interface

uses Windows, SysUtils, Messages, Classes, Controls, Forms, StdCtrls,
  Graphics, bsSkinGrids, DBCtrls, Db, Menus, ImgList, bsSkinCtrls, bsUtils,
  bsSkinBoxCtrls, bsMessages, bsSkinData, bsdbctrls
  {$IFNDEF VER130}, Variants {$ENDIF};

type
  TbsColumnValue = (cvColor, cvWidth, cvFont, cvAlignment, cvReadOnly, cvTitleColor,
    cvTitleCaption, cvTitleAlignment, cvTitleFont, cvImeMode, cvImeName);
  TbsColumnValues = set of TbsColumnValue;

const
  ColumnTitleValues = [cvTitleColor..cvTitleFont];
  cm_DeferLayout = WM_USER + 100;

type
  TbsColumn = class;
  TbsSkinCustomDBGrid = class;

  TbsColumnTitle = class(TPersistent)
  private
    FColumn: TbsColumn;
    FCaption: string;
    FFont: TFont;
    FColor: TColor;
    FAlignment: TAlignment;
    procedure FontChanged(Sender: TObject);
    function GetAlignment: TAlignment;
    function GetColor: TColor;
    function GetCaption: string;
    function GetFont: TFont;
    function IsAlignmentStored: Boolean;
    function IsColorStored: Boolean;
    function IsFontStored: Boolean;
    function IsCaptionStored: Boolean;
    procedure SetAlignment(Value: TAlignment);
    procedure SetColor(Value: TColor);
    procedure SetFont(Value: TFont);
    procedure SetCaption(const Value: string); virtual;
  protected
    procedure RefreshDefaultFont;
  public
    constructor Create(Column: TbsColumn);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function DefaultAlignment: TAlignment;
    function DefaultColor: TColor;
    function DefaultFont: TFont;
    function DefaultCaption: string;
    procedure RestoreDefaults; virtual;
    property Column: TbsColumn read FColumn;
  published
    property Alignment: TAlignment read GetAlignment write SetAlignment
      stored IsAlignmentStored;
    property Caption: string read GetCaption write SetCaption stored IsCaptionStored;
    property Color: TColor read GetColor write SetColor stored IsColorStored;
    property Font: TFont read GetFont write SetFont stored IsFontStored;
  end;

  TbsColumnButtonStyle = (cbsAuto, cbsEllipsis, cbsNone);

  TbsColumn = class(TCollectionItem)
  private
    FField: TField;
    FFieldName: string;
    FColor: TColor;
    FWidth: Integer;
    FTitle: TbsColumnTitle;
    FFont: TFont;
    FImeMode: TImeMode;
    FImeName: TImeName;
    FPickList: TStrings;
    FPopupMenu: TPopupMenu;
    FDropDownRows: Cardinal;
    FButtonStyle: TbsColumnButtonStyle;
    FAlignment: TAlignment;
    FReadonly: Boolean;
    FAssignedValues: TbsColumnValues;
    FVisible: Boolean;
    FExpanded: Boolean;
    FStored: Boolean;
    procedure FontChanged(Sender: TObject);
    function  GetAlignment: TAlignment;
    function  GetColor: TColor;
    function  GetExpanded: Boolean;
    function  GetField: TField;
    function  GetFont: TFont;
    function  GetImeMode: TImeMode;
    function  GetImeName: TImeName;
    function  GetParentColumn: TbsColumn;
    function  GetPickList: TStrings;
    function  GetReadOnly: Boolean;
    function  GetShowing: Boolean;
    function  GetWidth: Integer;
    function  GetVisible: Boolean;
    function  IsAlignmentStored: Boolean;
    function  IsColorStored: Boolean;
    function  IsFontStored: Boolean;
    function  IsImeModeStored: Boolean;
    function  IsImeNameStored: Boolean;
    function  IsReadOnlyStored: Boolean;
    function  IsWidthStored: Boolean;
    procedure SetAlignment(Value: TAlignment); virtual;
    procedure SetButtonStyle(Value: TbsColumnButtonStyle);
    procedure SetColor(Value: TColor);
    procedure SetExpanded(Value: Boolean);
    procedure SetField(Value: TField); virtual;
    procedure SetFieldName(const Value: String);
    procedure SetFont(Value: TFont);
    procedure SetImeMode(Value: TImeMode); virtual;
    procedure SetImeName(Value: TImeName); virtual;
    procedure SetPickList(Value: TStrings);
    procedure SetPopupMenu(Value: TPopupMenu);
    procedure SetReadOnly(Value: Boolean); virtual;
    procedure SetTitle(Value: TbsColumnTitle);
    procedure SetWidth(Value: Integer); virtual;
    procedure SetVisible(Value: Boolean);
    function GetExpandable: Boolean;
  protected
    function  CreateTitle: TbsColumnTitle; virtual;
    function  GetGrid: TbsSkinCustomDBGrid;
    function GetDisplayName: string; override;
    procedure RefreshDefaultFont;
    procedure SetIndex(Value: Integer); override;
    property IsStored: Boolean read FStored write FStored default True;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function  DefaultAlignment: TAlignment;
    function  DefaultColor: TColor;
    function  DefaultFont: TFont;
    function  DefaultImeMode: TImeMode;
    function  DefaultImeName: TImeName;
    function  DefaultReadOnly: Boolean;
    function  DefaultWidth: Integer;
    function  Depth: Integer;
    procedure RestoreDefaults; virtual;
    property  Grid: TbsSkinCustomDBGrid read GetGrid;
    property  AssignedValues: TbsColumnValues read FAssignedValues;
    property  Expandable: Boolean read GetExpandable;
    property  Field: TField read GetField write SetField;
    property  ParentColumn: TbsColumn read GetParentColumn;
    property  Showing: Boolean read GetShowing;
  published
    property  Alignment: TAlignment read GetAlignment write SetAlignment
      stored IsAlignmentStored;
    property  ButtonStyle: TbsColumnButtonStyle read FButtonStyle write SetButtonStyle
      default cbsAuto;
    property  Color: TColor read GetColor write SetColor stored IsColorStored;
    property  DropDownRows: Cardinal read FDropDownRows write FDropDownRows default 7;
    property  Expanded: Boolean read GetExpanded write SetExpanded default True;
    property  FieldName: String read FFieldName write SetFieldName;
    property  Font: TFont read GetFont write SetFont stored IsFontStored;
    property  ImeMode: TImeMode read GetImeMode write SetImeMode stored IsImeModeStored;
    property  ImeName: TImeName read GetImeName write SetImeName stored IsImeNameStored;
    property  PickList: TStrings read GetPickList write SetPickList;
    property  PopupMenu: TPopupMenu read FPopupMenu write SetPopupMenu;
    property  ReadOnly: Boolean read GetReadOnly write SetReadOnly
      stored IsReadOnlyStored;
    property  Title: TbsColumnTitle read FTitle write SetTitle;
    property  Width: Integer read GetWidth write SetWidth stored IsWidthStored;
    property  Visible: Boolean read GetVisible write SetVisible;
  end;

  TbsColumnClass = class of TbsColumn;

  TbsDBGridColumnsState = (csDefault, csCustomized);

  TbsDBGridColumns = class(TCollection)
  private
    FGrid: TbsSkinCustomDBGrid;
    function GetColumn(Index: Integer): TbsColumn;
    function InternalAdd: TbsColumn;
    procedure SetColumn(Index: Integer; Value: TbsColumn);
    procedure SetState(NewState: TbsDBGridColumnsState);
    function GetState: TbsDBGridColumnsState;
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(Grid: TbsSkinCustomDBGrid; ColumnClass: TbsColumnClass);
    function  Add: TbsColumn;
    procedure LoadFromFile(const Filename: string);
    procedure LoadFromStream(S: TStream);
    procedure RestoreDefaults;
    procedure RebuildColumns;
    procedure SaveToFile(const Filename: string);
    procedure SaveToStream(S: TStream);
    property State: TbsDBGridColumnsState read GetState write SetState;
    property Grid: TbsSkinCustomDBGrid read FGrid;
    property Items[Index: Integer]: TbsColumn read GetColumn write SetColumn; default;
  end;

  TbsGridDataLink = class(TDataLink)
  private
    FGrid: TbsSkinCustomDBGrid;
    FFieldCount: Integer;
    FFieldMap: array of Integer;
    FModified: Boolean;
    FInUpdateData: Boolean;
    FSparseMap: Boolean;
    function GetDefaultFields: Boolean;
    function GetFields(I: Integer): TField;
  protected
    procedure ActiveChanged; override;
    procedure BuildAggMap;
    procedure DataSetChanged; override;
    procedure DataSetScrolled(Distance: Integer); override;
    procedure FocusControl(Field: TFieldRef); override;
    procedure EditingChanged; override;
    function IsAggRow(Value: Integer): Boolean; virtual;
    procedure LayoutChanged; override;
    procedure RecordChanged(Field: TField); override;
    procedure UpdateData; override;
    function  GetMappedIndex(ColIndex: Integer): Integer;
  public
    constructor Create(AGrid: TbsSkinCustomDBGrid);
    destructor Destroy; override;
    function AddMapping(const FieldName: string): Boolean;
    procedure ClearMapping;
    procedure Modified;
    procedure Reset;
    property DefaultFields: Boolean read GetDefaultFields;
    property FieldCount: Integer read FFieldCount;
    property Fields[I: Integer]: TField read GetFields;
    property SparseMap: Boolean read FSparseMap write FSparseMap;
  end;

  TbsBookmarkList = class
  private
    FList: TStringList;
    FGrid: TbsSkinCustomDBGrid;
    FCache: TBookmarkStr;
    FCacheIndex: Integer;
    FCacheFind: Boolean;
    FLinkActive: Boolean;
    function GetCount: Integer;
    function GetCurrentRowSelected: Boolean;
    function GetItem(Index: Integer): TBookmarkStr;
    procedure SetCurrentRowSelected(Value: Boolean);
    procedure StringsChanged(Sender: TObject);
  protected
    function CurrentRow: TBookmarkStr;
    function Compare(const Item1, Item2: TBookmarkStr): Integer;
    procedure LinkActive(Value: Boolean);
  public
    constructor Create(AGrid: TbsSkinCustomDBGrid);
    destructor Destroy; override;
    procedure Clear;           // free all bookmarks
    procedure Delete;          // delete all selected rows from dataset
    function  Find(const Item: TBookmarkStr; var Index: Integer): Boolean;
    function  IndexOf(const Item: TBookmarkStr): Integer;
    function  Refresh: Boolean;// drop orphaned bookmarks; True = orphans found
    property Count: Integer read GetCount;
    property CurrentRowSelected: Boolean read GetCurrentRowSelected
      write SetCurrentRowSelected;
    property Items[Index: Integer]: TBookmarkStr read GetItem; default;
  end;

  TbsDBGridOption = (dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator,
    dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect,
    dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect);
  TbsDBGridOptions = set of TbsDBGridOption;

  TDrawDataCellEvent = procedure (Sender: TObject; const Rect: TRect; Field: TField;
    State: TGridDrawState) of object;
  TDrawColumnCellEvent = procedure (Sender: TObject; const Rect: TRect;
    DataCol: Integer; Column: TbsColumn; State: TGridDrawState) of object;
  TDBGridClickEvent = procedure (Column: TbsColumn) of object;
  TGetDBCellParamEvent = procedure (Sender: TObject; Column: TbsColumn;  State: TGridDrawState;
    var ABGColor: TColor; AFont: TFont) of object;

  TbsSkinCustomDBGrid = class(TbsSkinCustomGrid)
  private
    FUseColumnsFont: Boolean;
    FOnGetCellParam: TGetDBCellParamEvent;
    FSaveMultiSelection: Boolean;
    FMouseWheelSupport: Boolean;
    FSkinMessage: TbsSkinMessage;
    FPickListBoxSkinDataName: String;
    FPickListBoxCaptionMode: Boolean;
    FIndicators: TImageList;
    FTitleFont: TFont;
    FReadOnly: Boolean;
    FOriginalImeName: TImeName;
    FOriginalImeMode: TImeMode;
    FUserChange: Boolean;
    FIsESCKey: Boolean;
    FLayoutFromDataset: Boolean;
    FOptions: TbsDBGridOptions;
    FTitleOffset, FIndicatorOffset: Byte;
    FUpdateLock: Byte;
    FLayoutLock: Byte;
    FInColExit: Boolean;
    FDefaultDrawing: Boolean;
    FSelfChangingTitleFont: Boolean;
    FSelecting: Boolean;
    FSelRow: Integer;
    FDataLink: TbsGridDataLink;
    FOnColEnter: TNotifyEvent;
    FOnColExit: TNotifyEvent;
    FOnDrawDataCell: TDrawDataCellEvent;
    FOnDrawColumnCell: TDrawColumnCellEvent;
    FEditText: string;
    FColumns: TbsDBGridColumns;
    FVisibleColumns: TList;
    FBookmarks: TbsBookmarkList;
    FSelectionAnchor: TBookmarkStr;
    FOnEditButtonClick: TNotifyEvent;
    FOnColumnMoved: TMovedEvent;
    FOnCellClick: TDBGridClickEvent;
    FOnTitleClick: TDBGridClickEvent;
    FDragCol: TbsColumn;
    function AcquireFocus: Boolean;
    procedure DataChanged;
    procedure EditingChanged;
    function GetDataSource: TDataSource;
    function GetFieldCount: Integer;
    function GetFields(FieldIndex: Integer): TField;
    function GetSelectedField: TField;
    function GetSelectedIndex: Integer;
    procedure InternalLayout;
    procedure MoveCol(RawCol, Direction: Integer);
    function PtInExpandButton(X,Y: Integer; var MasterCol: TbsColumn): Boolean;
    procedure ReadColumns(Reader: TReader);
    procedure RecordChanged(Field: TField);
    procedure SetIme;
    procedure SetColumns(Value: TbsDBGridColumns);
    procedure SetDataSource(Value: TDataSource);
    procedure SetOptions(Value: TbsDBGridOptions);
    procedure SetSelectedField(Value: TField);
    procedure SetSelectedIndex(Value: Integer);
    procedure SetTitleFont(Value: TFont);
    procedure TitleFontChanged(Sender: TObject);
    procedure UpdateData;
    procedure UpdateActive;
    procedure UpdateIme;
    procedure UpdateScrollBar;
    procedure UpdateRowCount;
    procedure WriteColumns(Writer: TWriter);
    procedure CMBiDiModeChanged(var Message: TMessage); message CM_BIDIMODECHANGED;
    procedure CMExit(var Message: TMessage); message CM_EXIT;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMParentFontChanged(var Message: TMessage); message CM_PARENTFONTCHANGED;
    procedure CMDeferLayout(var Message); message cm_DeferLayout;
    procedure CMDesignHitTest(var Msg: TCMDesignHitTest); message CM_DESIGNHITTEST;
    procedure WMSetCursor(var Msg: TWMSetCursor); message WM_SETCURSOR;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;
    procedure WMIMEStartComp(var Message: TMessage); message WM_IME_STARTCOMPOSITION;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SetFOCUS;
    procedure WMKillFocus(var Message: TMessage); message WM_KillFocus;
  protected
    FUpdateFields: Boolean;
    FAcquireFocus: Boolean;
    procedure DrawSkinCheckImage(Cnvs: TCanvas; R: TRect; AChecked: Boolean);
    procedure WMChar(var Msg: TWMChar); message WM_CHAR;
    procedure PickListBoxOnCheckButtonClick(Sender: TObject);
    procedure SetHScrollBar(Value: TbsSkinScrollBar); override;
    procedure UpdateScrollPos(UpDateVert: Boolean); override;
    procedure UpdateScrollRange(UpDateVert: Boolean); override;

    function  RawToDataColumn(ACol: Integer): Integer;
    function  DataToRawColumn(ACol: Integer): Integer;
    function  AcquireLayoutLock: Boolean;
    procedure BeginLayout;
    procedure BeginUpdate;
    procedure CalcSizingState(X, Y: Integer; var State: TbsGridState;
      var Index: Longint; var SizingPos, SizingOfs: Integer;
      var FixedInfo: TbsGridDrawInfo); override;
    procedure CancelLayout;
    function  CanEditAcceptKey(Key: Char): Boolean; override;
    function  CanEditModify: Boolean; override;
    function  CanEditShow: Boolean; override;
    procedure CellClick(Column: TbsColumn); dynamic;
    procedure ColumnMoved(FromIndex, ToIndex: Longint); override;
    function CalcTitleRect(Col: TbsColumn; ARow: Integer;
      var MasterCol: TbsColumn): TRect;
    function ColumnAtDepth(Col: TbsColumn; ADepth: Integer): TbsColumn;
    procedure ColEnter; dynamic;
    procedure ColExit; dynamic;
    procedure ColWidthsChanged; override;
    function  CreateColumns: TbsDBGridColumns; dynamic;
    function  CreateEditor: TbsSkinInplaceEdit; override;
    procedure CreateWnd; override;
    procedure DeferLayout;
    procedure DefineFieldMap; virtual;
    procedure DefineProperties(Filer: TFiler); override;
    procedure DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState); override;
    procedure DrawSkinCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState);
    procedure DrawDefaultCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState);
    procedure DrawDataCell(const Rect: TRect; Field: TField;
      State: TGridDrawState); dynamic; { obsolete }
    procedure DrawColumnCell(const Rect: TRect; DataCol: Integer;
      Column: TbsColumn; State: TGridDrawState); dynamic;
    procedure EditButtonClick; dynamic;
    procedure EndLayout;
    procedure EndUpdate;
    function  GetColField(DataCol: Integer): TField;
    function  GetEditLimit: Integer; override;
    function  GetEditMask(ACol, ARow: Longint): string; override;
    function  GetEditText(ACol, ARow: Longint): string; override;
    function  GetFieldValue(ACol: Integer): string;
    function  HighlightCell(DataCol, DataRow: Integer; const Value: string;
      AState: TGridDrawState): Boolean; virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure InvalidateTitles;
    procedure LayoutChanged; virtual;
    procedure LinkActive(Value: Boolean); virtual;
    procedure Loaded; override;
    procedure WMMouseWheel(var Message: TWMMouseWheel); message WM_MOUSEWHEEL;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Scroll(Distance: Integer); virtual;
    procedure SetColumnAttributes; virtual;
    procedure SetEditText(ACol, ARow: Longint; const Value: string); override;
    function  StoreColumns: Boolean;
    procedure TimedScroll(Direction: TGridScrollDirection); override;
    procedure TitleClick(Column: TbsColumn); dynamic;
    procedure TopLeftChanged; override;
    function UseRightToLeftAlignmentForField(const AField: TField;
      Alignment: TAlignment): Boolean;
    function BeginColumnDrag(var Origin, Destination: Integer;
      const MousePt: TPoint): Boolean; override;
    function CheckColumnDrag(var Origin, Destination: Integer;
      const MousePt: TPoint): Boolean; override;
    function EndColumnDrag(var Origin, Destination: Integer;
      const MousePt: TPoint): Boolean; override;
    property Columns: TbsDBGridColumns read FColumns write SetColumns;
    property DefaultDrawing: Boolean read FDefaultDrawing write FDefaultDrawing default True;
    property DataLink: TbsGridDataLink read FDataLink;
    property IndicatorOffset: Byte read FIndicatorOffset;
    property LayoutLock: Byte read FLayoutLock;
    property Options: TbsDBGridOptions read FOptions write SetOptions
      default [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines,
      dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit];
    property ParentColor default False;
    property ReadOnly: Boolean read FReadOnly write FReadOnly default False;
    property SelectedRows: TbsBookmarkList read FBookmarks;
    property TitleFont: TFont read FTitleFont write SetTitleFont;
    property UpdateLock: Byte read FUpdateLock;
    property SaveMultiSelection: Boolean read
      FSaveMultiSelection write FSaveMultiSelection;
    property OnGetCellParam: TGetDBCellParamEvent
      read FOnGetCellParam write FOnGetCellParam;
    property OnColEnter: TNotifyEvent read FOnColEnter write FOnColEnter;
    property OnColExit: TNotifyEvent read FOnColExit write FOnColExit;
    property OnDrawDataCell: TDrawDataCellEvent read FOnDrawDataCell
      write FOnDrawDataCell; { obsolete }
    property OnDrawColumnCell: TDrawColumnCellEvent read FOnDrawColumnCell
      write FOnDrawColumnCell;
    property OnEditButtonClick: TNotifyEvent read FOnEditButtonClick
      write FOnEditButtonClick;
    property OnColumnMoved: TMovedEvent read FOnColumnMoved write FOnColumnMoved;
    property OnCellClick: TDBGridClickEvent read FOnCellClick write FOnCellClick;
    property OnTitleClick: TDBGridClickEvent read FOnTitleClick write FOnTitleClick;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ChangeSkinData; override;
    procedure DefaultDrawDataCell(const Rect: TRect; Field: TField;
      State: TGridDrawState); { obsolete }
    procedure DefaultDrawColumnCell(const Rect: TRect; DataCol: Integer;
      Column: TbsColumn; State: TGridDrawState);
    procedure DefaultHandler(var Msg); override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    procedure ShowPopupEditor(Column: TbsColumn; X: Integer = Low(Integer);
      Y: Integer = Low(Integer)); dynamic;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function ValidFieldIndex(FieldIndex: Integer): Boolean;
    property SkinMessage: TbsSkinMessage read FSkinMessage write FSkinMessage;
    property EditorMode;
    property FieldCount: Integer read GetFieldCount;
    property Fields[FieldIndex: Integer]: TField read GetFields;
    property SelectedField: TField read GetSelectedField write SetSelectedField;
    property SelectedIndex: Integer read GetSelectedIndex write SetSelectedIndex;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property PickListBoxSkinDataName: String read FPickListBoxSkinDataName
                                         write FPickListBoxSkinDataName;
    property PickListBoxCaptionMode: Boolean read FPickListBoxCaptionMode
                                         write FPickListBoxCaptionMode;
    property MouseWheelSupport: Boolean
      read FMouseWheelSupport write FMouseWheelSupport;
    property UseColumnsFont: Boolean
      read FUseColumnsFont write FUseColumnsFont;
  published
    property Font;
  end;

  TbsSkinDBGrid = class(TbsSkinCustomDBGrid)
  public
    property Canvas;
    property SelectedRows;
  published
    property UseColumnsFont;
    property DefaultRowHeight;
    property DefaultColWidth;
    property BiDiMode;
    property MouseWheelSupport;
    property SkinMessage;
    property SaveMultiSelection;
    property PickListBoxSkinDataName;
    property PickListBoxCaptionMode;
    property Align;
    property Anchors;
    property BorderStyle;
    property Color;
    property Columns stored False; 
    property Constraints;
    property Ctl3D;
    property DataSource;
    property DefaultDrawing;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property FixedColor;
    property Font;
    property ImeMode;
    property ImeName;
    property Options;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property TitleFont;
    property Visible;
    property OnCellClick;
    property OnColEnter;
    property OnColExit;
    property OnColumnMoved;
    property OnDrawDataCell;  { obsolete }
    property OnDrawColumnCell;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEditButtonClick;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
    property OnTitleClick;
    property OnGetCellParam;
  end;

const
  IndicatorWidth = 11;

implementation

uses Math, DBConsts, Dialogs, bsConst;

{$R BSDBGRIDS.RES}

const
  bmArrow = 'BSDBGARROW';
  bmEdit = 'BSDBEDIT';
  bmInsert = 'BSDBINSERT';
  bmMultiDot = 'BSDBMULTIDOT';
  bmMultiArrow = 'BSDBMULTIARROW';

  MaxMapSize = (MaxInt div 2) div SizeOf(Integer);  { 250 million }


type
  TParentGrid = class(TbsSkinCustomDBGrid);

{ Error reporting }

procedure RaiseGridError(const S: string);
begin
//  raise EInvalidGridOperation.Create(S);
end;

procedure KillMessage(Wnd: HWnd; Msg: Integer);
var
  M: TMsg;
begin
  M.Message := 0;
  if PeekMessage(M, Wnd, Msg, Msg, pm_Remove) and (M.Message = WM_QUIT) then
    PostQuitMessage(M.wparam);
end;

{ TDBGridInplaceEdit }

type
  TEditStyle = (esSimple, esEllipsis, esPickList, esDataList);

  TbsDBPopupListbox = class;

  TDBGridInplaceEdit = class(TbsSkinInplaceEdit)
  private
    FButtonWidth: Integer;
    FDataList: TbsPopupDataList;
    FPickList: TbsDBPopupListbox;
    FActiveList: TWinControl;
    FLookupSource: TDatasource;
    FEditStyle: TEditStyle;
    FListVisible: Boolean;
    FTracking: Boolean;
    FPressed: Boolean;
    procedure ListMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SetEditStyle(Value: TEditStyle);
    procedure StopTracking;
    procedure TrackButton(X,Y: Integer);
    procedure CMCancelMode(var Message: TCMCancelMode); message CM_CancelMode;
    procedure WMCancelMode(var Message: TMessage); message WM_CancelMode;
    procedure WMKillFocus(var Message: TMessage); message WM_KillFocus;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message wm_LButtonDblClk;
    procedure WMPaint(var Message: TWMPaint); message wm_Paint;
    procedure WMSetCursor(var Message: TWMSetCursor); message WM_SetCursor;
    function OverButton(const P: TPoint): Boolean;
    function ButtonRect: TRect;
  protected
    function IsValidChar(Key: Char): Boolean;
    procedure KeyPress(var Key: Char); override;
    procedure BoundsChanged; override;
    procedure DoDropDownKeys(var Key: Word; Shift: TShiftState);
    procedure DropDown;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure PaintWindow(DC: HDC); override;
    procedure UpdateContents; override;
    procedure WndProc(var Message: TMessage); override;
    property  EditStyle: TEditStyle read FEditStyle write SetEditStyle;
    property  ActiveList: TWinControl read FActiveList write FActiveList;
    property  DataList: TbsPopupDataList read FDataList;
    property  PickList: TbsDBPopupListbox read FPickList;
  public
    procedure CloseUp(Accept: Boolean);
    constructor Create(Owner: TComponent); override;
  end;

{ TbsDBPopupListbox }

  TbsDBPopupListbox = class(TbsPopupListBox)
  protected
    FListBoxWindowProc: TWndMethod;
    procedure ListBoxWindowProcHook(var Message: TMessage);
    procedure ListBoxMouseMove(Sender: TObject; Shift: TShiftState;
              X, Y: Integer);
  public
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
  end;

constructor TbsDBPopupListbox.Create(Owner: TComponent);
begin
  inherited;
  FListBoxWindowProc := ListBox.WindowProc;
  ListBox.WindowProc := ListBoxWindowProcHook;
  ListBox.OnMouseMove := ListBoxMouseMove;
end;

destructor TbsDBPopupListbox.Destroy;
begin
  inherited;
end;

procedure TbsDBPopupListbox.ListBoxWindowProcHook(var Message: TMessage);
var
  FOld: Boolean;
begin
  FOld := True;
  case Message.Msg of
     WM_LBUTTONUP:
       begin
         TDBGridInPlaceEdit(Owner).CloseUp(True);
       end;
     WM_RBUTTONDOWN, WM_RBUTTONUP,
     WM_MBUTTONDOWN, WM_MBUTTONUP,
     WM_LBUTTONDOWN:
       begin
         FOLd := False;
       end;
     WM_MOUSEACTIVATE:
      begin
        Message.Result := MA_NOACTIVATE;
      end;
  end;
  if FOld then FListBoxWindowProc(Message);
end;

procedure TbsDBPopupListbox.ListBoxMouseMove(Sender: TObject; Shift: TShiftState;
                           X, Y: Integer);

var
  Index: Integer;
begin
  Index := ListBox.ItemAtPos(Point (X, Y), True);
  if (Index >= 0) and (Index < Items.Count)
  then
    ItemIndex := Index;
end;

constructor TDBGridInplaceEdit.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  FLookupSource := TDataSource.Create(Self);
  FButtonWidth := GetSystemMetrics(SM_CXVSCROLL);
  FEditStyle := esSimple;
end;

procedure TDBGridInplaceEdit.KeyPress(var Key: Char);
begin
  if not IsValidChar(Key) then
  begin
    Key := #0;
    MessageBeep(0)
  end;
  if Key <> #0 then inherited KeyPress(Key);
end;

function TDBGridInplaceEdit.IsValidChar(Key: Char): Boolean;
var
  CharCode: Integer;
  DBGrid: TbsSkinCustomDBGrid;
  FT: TFieldType;
  CellIndex: Integer;
begin
  DBGrid := TbsSkinCustomDBGrid(Grid);
  if dgIndicator in  DBGrid.Options
  then
    CellIndex :=  DBGrid.Col - 1
  else
    CellIndex :=  DBGrid.Col;
  if not Assigned(DBGrid.Columns[CellIndex].Field) then Exit;
  FT := DBGrid.Columns[CellIndex].Field.DataType;
  if (Key = '-') or (Key = '+') or (Key = DecimalSeparator)
  then
    begin
      case FT of
        ftSmallint, ftInteger,
        ftFloat, ftCurrency:
          Result := not (
                    ((Key = DecimalSeparator) and
                     (Pos(DecimalSeparator, Text) <> 0)) or
                    ((Key = '-') and (Pos('-', Text) <> 0)) or
                    ((Key = '+') and (Pos('+', Text) <> 0)));
        else
          Result := True;
      end
    end
  else
    Result := True;
end;

procedure TDBGridInplaceEdit.BoundsChanged;
var
  R: TRect;
begin
  Windows.SetRect(R, 2, 2, Width - 2, Height);
  if FEditStyle <> esSimple then
    if not TbsSkinCustomDBGrid(Owner).UseRightToLeftAlignment then
      Dec(R.Right, FButtonWidth)
    else
      Inc(R.Left, FButtonWidth - 2);
  SendMessage(Handle, EM_SETRECTNP, 0, LongInt(@R));
  SendMessage(Handle, EM_SCROLLCARET, 0, 0);
  if SysLocale.FarEast then
    SetImeCompositionWindow(Font, R.Left, R.Top);
end;

procedure TDBGridInplaceEdit.CloseUp(Accept: Boolean);
var
  MasterField: TField;
  ListValue: Variant;
begin
  if FListVisible then
  begin
    if GetCapture <> 0 then SendMessage(GetCapture, WM_CANCELMODE, 0, 0);
    if FActiveList = FDataList
    then
      ListValue := FDataList.KeyValue
    else
      if FPickList.ItemIndex <> -1 then
        ListValue := FPickList.Items[FPicklist.ItemIndex];
    if FActiveList = FDataList
    then
      begin
        SetWindowPos(FActiveList.Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or
         SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
      end
    else
      TbsDBPopupListBox(FActiveList).Hide;
    FActiveList.Visible := False;
    FListVisible := False;
    if Assigned(FDataList) then FDataList.ListSource := nil;
    FLookupSource.Dataset := nil;
    Invalidate;
    if Accept then
      if FActiveList = FDataList then
        with TbsSkinCustomDBGrid(Grid), Columns[SelectedIndex].Field do
        begin
          MasterField := DataSet.FieldByName(KeyFields);
          if MasterField.CanModify and FDataLink.Edit then
            MasterField.Value := ListValue;
        end
      else
        if (not VarIsNull(ListValue)) and EditCanModify then
          with TbsSkinCustomDBGrid(Grid), Columns[SelectedIndex].Field do
            Text := ListValue;
  end;
end;

procedure TDBGridInplaceEdit.DoDropDownKeys(var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_UP, VK_DOWN:
      if ssAlt in Shift then
      begin
        if FListVisible then CloseUp(True) else DropDown;
        Key := 0;
      end;
    VK_RETURN, VK_ESCAPE:
      if FListVisible and not (ssAlt in Shift) then
      begin
        CloseUp(Key = VK_RETURN);
        Key := 0;
      end;
  end;
end;

procedure TDBGridInplaceEdit.DropDown;
var
  P: TPoint;
  I,J,Y: Integer;
  Column: TbsColumn;
begin
  if not FListVisible and Assigned(FActiveList) then
  begin
    FActiveList.Width := Width;
    with TbsSkinCustomDBGrid(Grid) do
      Column := Columns[SelectedIndex];
    if FActiveList = FDataList then
    with Column.Field do
    begin
      FDataList.Font := Font;
      FDataList.RowCount := Column.DropDownRows;
      FLookupSource.DataSet := LookupDataSet;
      FDataList.KeyField := LookupKeyFields;
      FDataList.ListField := LookupResultField;
      FDataList.ListSource := FLookupSource;
      FDataList.KeyValue := DataSet.FieldByName(KeyFields).Value;
      FDataList.SkinData := Grid.SkinData;
      FDataList.SkinDataName := TbsSkinCustomDbGrid(Grid).PickListBoxSkinDataName;
      FDataList.ChangeSkinData;
      FDataList.Width := Column.Width;
      if FDataList.FIndex = -1
      then
        begin
          FDataList.Font := Font;
        end;
      P := Parent.ClientToScreen(Point(Left, Top));
      Y := P.Y + Height;
      if Y + FActiveList.Height > Screen.Height then Y := P.Y - FActiveList.Height;
      SetWindowPos(FActiveList.Handle, HWND_TOP, P.X, Y, 0, 0,
      SWP_NOSIZE or SWP_NOACTIVATE or SWP_SHOWWINDOW);
      FListVisible := True;
      Invalidate;
      Windows.SetFocus(Handle);
    end
    else
    begin
      //
      with FPickList do
      begin
        SkinData := Grid.SkinData;
        SkinDataName := TbsSkinCustomDbGrid(Grid).PickListBoxSkinDataName;
        CaptionMode := TbsSkinCustomDbGrid(Grid).PickListBoxCaptionMode;
        if CaptionMode
        then
        begin
          Caption := Column.Title.Caption;
          OnCheckButtonClick := TbsSkinCustomDbGrid(Grid).PickListBoxOnCheckButtonClick;
        end;
      end;  
      FPickList.ChangeSkinData;
      //
      if FPickList.FIndex = -1
      then
        begin
          FPickList.Font := Font;
        end;
      FPickList.Items := Column.Picklist;
      if FPickList.Items.Count >= Integer(Column.DropDownRows) then
        FPickList.Height := Integer(Column.DropDownRows) * FPickList.ListBox.ItemHeight + 4
      else
        FPickList.Height := FPickList.Items.Count * FPickList.ListBox.ItemHeight + 4;
      if Column.Field.IsNull then
        FPickList.ItemIndex := -1
      else
        FPickList.ItemIndex := FPickList.Items.IndexOf(Column.Field.Text);
      J := FPickList.ClientWidth;
      for I := 0 to FPickList.Items.Count - 1 do
      begin
        Y := FPickList.Canvas.TextWidth(FPickList.Items[I]);
        if Y > J then J := Y;
      end;
      FPickList.ClientWidth := J;
    end;
    P := Parent.ClientToScreen(Point(Left, Top));
    Y := P.Y + Height;
    if Y + FActiveList.Height > Screen.Height then Y := P.Y - FActiveList.Height;
    TbsDBPopupListBox(FActiveList).Show(Point(P.X, Y));
    FListVisible := True;
    Invalidate;
    Windows.SetFocus(Handle);
  end;
end;

type
  TWinControlCracker = class(TWinControl) end;

procedure TDBGridInplaceEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if (EditStyle = esEllipsis) and (Key = VK_RETURN) and (Shift = [ssCtrl]) then
  begin
    TbsSkinCustomDBGrid(Grid).EditButtonClick;
    KillMessage(Handle, WM_CHAR);
  end
  else
    inherited KeyDown(Key, Shift);
end;

procedure TDBGridInplaceEdit.ListMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    CloseUp(PtInRect(FActiveList.ClientRect, Point(X, Y)));
end;

procedure TDBGridInplaceEdit.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  if (Button = mbLeft) and (FEditStyle <> esSimple) and
    OverButton(Point(X,Y)) then
  begin
    if FListVisible then
      CloseUp(False)
    else
    begin
      MouseCapture := True;
      FTracking := True;
      TrackButton(X, Y);
      if Assigned(FActiveList) then
        DropDown;
    end;
  end;
  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TDBGridInplaceEdit.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  ListPos: TPoint;
  MousePos: TSmallPoint;
begin
  if FTracking then
  begin
    TrackButton(X, Y);
    if FListVisible then
    begin
      ListPos := FActiveList.ScreenToClient(ClientToScreen(Point(X, Y)));
      if PtInRect(FActiveList.ClientRect, ListPos) then
      begin
        StopTracking;
        MousePos := PointToSmallPoint(ListPos);
        SendMessage(FActiveList.Handle, WM_LBUTTONDOWN, 0, Integer(MousePos));
        Exit;
      end;
    end;
  end;
  inherited MouseMove(Shift, X, Y);
end;

procedure TDBGridInplaceEdit.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  WasPressed: Boolean;
begin
  WasPressed := FPressed;
  StopTracking;
  if (Button = mbLeft) and (FEditStyle = esEllipsis) and WasPressed then
    TbsSkinCustomDBGrid(Grid).EditButtonClick;
  inherited MouseUp(Button, Shift, X, Y);
end;

procedure TDBGridInplaceEdit.PaintWindow(DC: HDC);
var
  CIndex: Integer;
  ButtonData: TbsDataSkinButtonControl;
  SkinColor: TColor;

procedure DrawSkinButton(C: TCanvas; R: TRect; ADown: Boolean);
var
  B: TBitMap;
  NewCLRect: TRect;
  FSkinPicture: TBitMap;
  NewLtPoint, NewRTPoint, NewLBPoint, NewRBPoint: TPoint;
  XO, YO: Integer;
begin
  B := TBitMap.Create;
  B.Width := RectWidth(R);
  B.Height := RectHeight(R);
  with ButtonData do
  begin
    XO := RectWidth(R) - RectWidth(SkinRect);
    YO := RectHeight(R) - RectHeight(SkinRect);
    NewLTPoint := LTPoint;
    NewRTPoint := Point(RTPoint.X + XO, RTPoint.Y);
    NewLBPoint := Point(LBPoint.X, LBPoint.Y + YO);
    NewRBPoint := Point(RBPoint.X + XO, RBPoint.Y + YO);
    NewClRect := Rect(CLRect.Left, ClRect.Top,
      CLRect.Right + XO, ClRect.Bottom + YO);
    FSkinPicture := TBitMap(TParentGrid(Grid).SkinData.FActivePictures.Items[ButtonData.PictureIndex]);
    //
    if ADown and not IsNullRect(DownSkinRect)
    then
      begin
        CreateSkinImage(LTPoint, RTPoint, LBPoint, RBPoint, CLRect,
        NewLtPoint, NewRTPoint, NewLBPoint, NewRBPoint, NewCLRect,
        B, FSkinPicture, DownSkinRect, B.Width, B.Height, True,
        LeftStretch, TopStretch, RightStretch, BottomStretch, StretchEffect);
        SkinColor := DownFontColor;
      end
    else
       begin
         CreateSkinImage(LTPoint, RTPoint, LBPoint, RBPoint, CLRect,
         NewLtPoint, NewRTPoint, NewLBPoint, NewRBPoint, NewCLRect,
         B, FSkinPicture, SkinRect, B.Width, B.Height, True,
         LeftStretch, TopStretch, RightStretch, BottomStretch, StretchEffect);
         SkinColor := FontColor;
       end;
   end;
  C.Draw(R.Left, R.Top, B);
  B.Free;
end;

procedure DrawButton(R: TRect);
var
  SaveIndex: Integer;
  C: TCanvas;
begin
  SaveIndex := SaveDC(DC);
  C := TCanvas.Create;
  C.Handle := DC;
  with C do
  begin
    if ButtonData = nil
    then
      begin
        Brush.Color := Color;
        Brush.Style := bsClear;
        Rectangle(R.Left, R.Top, R.Right, R.Bottom);
        DrawArrowImage(C, R, Font.Color, 4);
      end
    else
      begin
        DrawSkinButton(C, R, FPressed);
        DrawArrowImage(C, R, SkinColor, 4);
      end;
  end;
  C.Handle := 0;
  C.Free;
  RestoreDC(DC, SaveIndex);
end;

procedure DrawButton2(R: TRect);
var
  SaveIndex: Integer;
  C: TCanvas;
  W, X, Y: Integer;
begin
  SaveIndex := SaveDC(DC);
  C := TCanvas.Create;
  C.Handle := DC;
  with C do
  begin
    X := R.Left + ((R.Right - R.Left) shr 1) - 1;
    Y := R.Top + ((R.Bottom - R.Top) shr 1) - 1;
    W := FButtonWidth shr 3;
    if W = 0 then W := 1;
    if ButtonData = nil
    then
      begin
        Brush.Color := Color;
        FillRect(R);
        Pen.Color := Font.Color;
      end
    else
      begin
        DrawSkinButton(C, R, FPressed);
        Pen.Color := SkinColor;
      end;
    Rectangle(X, Y, X + W, Y + W);
    Rectangle(X - (W * 2), Y, X - (W * 2) + W, Y + W);
    Rectangle(X + (W * 2), Y, X + (W * 2) + W, Y + W);
  end;
  C.Handle := 0;
  C.Free;
  RestoreDC(DC, SaveIndex);
end;

var
  R: TRect;
begin
  //
  ButtonData := nil;
  if (TParentGrid(Grid).SkinData <> nil)
  then
    CIndex := TParentGrid(Grid).SkinData.GetControlIndex('resizebutton')
  else
    CIndex := -1;
  if CIndex <> -1
  then
    ButtonData := TbsDataSkinButtonControl(TParentGrid(Grid).SkinData.CtrlList[CIndex]);

  if FEditStyle <> esSimple
  then
    begin
      R := ButtonRect;
      if FEditStyle in [esDataList, esPickList]
      then
        DrawButton(R)
      else
        DrawButton2(R);
    ExcludeClipRect(DC, R.Left, R.Top, R.Right, R.Bottom);
  end;
  inherited PaintWindow(DC);
end;

procedure TDBGridInplaceEdit.SetEditStyle(Value: TEditStyle);
begin
  with TbsSkinCustomDBGrid(Grid) do
    Self.ReadOnly := Columns[SelectedIndex].ReadOnly;
  if Value = FEditStyle then Exit;
  FEditStyle := Value;
  case Value of
    esPickList:
      begin
        if FPickList = nil then
        begin
          FPickList := TbsDBPopupListbox.Create(Self);
          FPickList.Visible := False;
          FPickList.Parent := Self;
          FPickList.OnMouseUp := ListMouseUp;
        end;
        FActiveList := FPickList;
      end;
    esDataList:
      begin
        if FDataList = nil then
        begin
          FDataList := TbsPopupDataList.Create(Self);
          FDataList.Visible := False;
          FDataList.Parent := Self;
          FDataList.OnMouseUp := ListMouseUp;
        end;
        FActiveList := FDataList;
      end;
  else  { cbsNone, cbsEllipsis, or read only field }
    FActiveList := nil;
  end;
  Repaint;
end;

procedure TDBGridInplaceEdit.StopTracking;
begin
  if FTracking then
  begin
    TrackButton(-1, -1);
    FTracking := False;
    MouseCapture := False;
  end;
end;

procedure TDBGridInplaceEdit.TrackButton(X,Y: Integer);
var
  NewState: Boolean;
  R: TRect;
begin
  R := ButtonRect;
  NewState := PtInRect(R, Point(X, Y));
  if FPressed <> NewState then
  begin
    FPressed := NewState;
    InvalidateRect(Handle, @R, False);
  end;
end;

procedure TDBGridInplaceEdit.UpdateContents;
var
  Column: TbsColumn;
  NewStyle: TEditStyle;
  MasterField: TField;
begin
  with TbsSkinCustomDBGrid(Grid) do
    Column := Columns[SelectedIndex];
  NewStyle := esSimple;
  case Column.ButtonStyle of
   cbsEllipsis: NewStyle := esEllipsis;
   cbsAuto:
     if Assigned(Column.Field) then
     with Column.Field do
     begin
       { Show the dropdown button only if the field is editable }
       if FieldKind = fkLookup then
       begin
         MasterField := Dataset.FieldByName(KeyFields);
         { Column.DefaultReadonly will always be True for a lookup field.
           Test if Column.ReadOnly has been assigned a value of True }
         if Assigned(MasterField) and MasterField.CanModify and
           not ((cvReadOnly in Column.AssignedValues) and Column.ReadOnly) then
           with TbsSkinCustomDBGrid(Grid) do
             if not ReadOnly and DataLink.Active and not Datalink.ReadOnly then
               NewStyle := esDataList
       end
       else
       if Assigned(Column.Picklist) and (Column.PickList.Count > 0) and
         not Column.Readonly then
         NewStyle := esPickList
       else if DataType in [ftDataset, ftReference] then
         NewStyle := esEllipsis;
     end;
  end;
  EditStyle := NewStyle;
  inherited UpdateContents;
  //
  if Grid.FIndex > -1
   then
      begin
        Self.Color := Grid.BGColor;
        if TParentGrid(Grid).UseSkinFont
        then
          with Font do
          begin
            Name := Grid.FontName;
            Color := Grid.FontColor;
            Style := Grid.FontStyle;
            Height := Grid.FontHeight;
            if (Grid.SkinData <> nil) and (Grid.SkinData.ResourceStrData <> nil)
            then
              CharSet := Grid.SkinData.ResourceStrData.CharSet
            else
              CharSet := TParentGrid(Grid).Font.CharSet;
          end
        else
          begin
            if TParentGrid(Grid).UseColumnsFont
            then
              Font.Assign(Column.Font)
            else
              Font.Assign(TParentGrid(Grid).Font);
            Font.Color := Grid.FontColor;
            if (Grid.SkinData <> nil) and (Grid.SkinData.ResourceStrData <> nil)
            then
              Font.CharSet := Grid.SkinData.ResourceStrData.CharSet;
          end;
      end
    else
      begin
        Color := clWindow;
        Font := TParentGrid(Grid).Font;
        if (Grid.SkinData <> nil) and (Grid.SkinData.ResourceStrData <> nil)
        then
          Font.CharSet := Grid.SkinData.ResourceStrData.CharSet;
      end;
  ImeMode := Column.ImeMode;
  ImeName := Column.ImeName;
end;

procedure TDBGridInplaceEdit.CMCancelMode(var Message: TCMCancelMode);

function NotActiveListHandle: Boolean;
begin
  if FActiveList <> nil
  then
    if FActiveList is TbsDBPopupListbox
    then
      begin
        with TbsDBPopupListbox(FActiveList) do
        begin
          Result := (Message.Sender <> FPickList) and
                    (Message.Sender <> FPickList.ListBox);
          if FPickList.ScrollBar <> nil
          then
            Result := Result and (Message.Sender <> FPickList.ScrollBar);
        end
      end
    else
    if FActiveList is TbsPopupDataList
    then
      begin
        with TbsPopupDataList(FActiveList) do
        begin
          Result := (Message.Sender <> FDataList);
          if FDataList.FScrollBar <> nil
          then
            Result := Result and (Message.Sender <> FDataList.FScrollBar);
        end
      end
    else
      Result := False;
end;

begin
  if (Message.Sender <> Self) and (Message.Sender <> FActiveList) and
     NotActiveListHandle
  then
    CloseUp(False);
end;

procedure TDBGridInplaceEdit.WMCancelMode(var Message: TMessage);
begin
  StopTracking;
  inherited;
end;

procedure TDBGridInplaceEdit.WMKillFocus(var Message: TMessage);
begin
  if not SysLocale.FarEast then inherited
  else
  begin
    ImeName := Screen.DefaultIme;
    ImeMode := imDontCare;
    inherited;
    if HWND(Message.WParam) <> TbsSkinCustomDBGrid(Grid).Handle then
      ActivateKeyboardLayout(Screen.DefaultKbLayout, KLF_ACTIVATE);
  end;
  CloseUp(False);
  with TParentGrid(Grid) do
   if FIndex = -1 then InvalidateCell(Col, Row);
end;

function TDBGridInplaceEdit.ButtonRect: TRect;
begin
  if not TbsSkinCustomDBGrid(Owner).UseRightToLeftAlignment then
    Result := Rect(Width - FButtonWidth, 0, Width, Height)
  else
    Result := Rect(0, 0, FButtonWidth, Height);
end;

function TDBGridInplaceEdit.OverButton(const P: TPoint): Boolean;
begin
  Result := PtInRect(ButtonRect, P);
end;

procedure TDBGridInplaceEdit.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
  with Message do
  if (FEditStyle <> esSimple) and OverButton(Point(XPos, YPos)) then
    Exit;
  inherited;
end;

procedure TDBGridInplaceEdit.WMPaint(var Message: TWMPaint);
begin
  PaintHandler(Message);
end;

procedure TDBGridInplaceEdit.WMSetCursor(var Message: TWMSetCursor);
var
  P: TPoint;
begin
  GetCursorPos(P);
  P := ScreenToClient(P);
  if (FEditStyle <> esSimple) and OverButton(P) then
    Windows.SetCursor(LoadCursor(0, idc_Arrow))
  else
    inherited;
end;

procedure TDBGridInplaceEdit.WndProc(var Message: TMessage);
begin
  case Message.Msg of
    wm_KeyDown, wm_SysKeyDown, wm_Char:
      if EditStyle in [esPickList, esDataList] then
      with TWMKey(Message) do
      begin
        DoDropDownKeys(CharCode, KeyDataToShiftState(KeyData));
        if FActiveList is TbsDBPopupListBox
        then
          begin
            if (CharCode <> 0) and FListVisible
            then
              begin
                with TMessage(Message) do
                  SendMessage(TbsDBPopupListbox(FActiveList).ListBox.Handle, Msg, WParam, LParam);
                Exit;
              end;
          end
        else
          begin
            if (CharCode <> 0) and FListVisible
            then
              begin
                with TMessage(Message) do
                  SendMessage(FActiveList.Handle, Msg, WParam, LParam);
                Exit;
              end;
          end;
      end
  end;
  inherited;
end;


{ TbsGridDataLink }

type
  TIntArray = array[0..MaxMapSize] of Integer;
  PIntArray = ^TIntArray;

constructor TbsGridDataLink.Create(AGrid: TbsSkinCustomDBGrid);
begin
  inherited Create;
  FGrid := AGrid;
  VisualControl := True;
end;

destructor TbsGridDataLink.Destroy;
begin
  ClearMapping;
  inherited Destroy;
end;

function TbsGridDataLink.GetDefaultFields: Boolean;
var
  I: Integer;
begin
  Result := True;
  if DataSet <> nil then Result := DataSet.DefaultFields;
  if Result and SparseMap then
  for I := 0 to FFieldCount-1 do
    if FFieldMap[I] < 0 then
    begin
      Result := False;
      Exit;
    end;
end;

function TbsGridDataLink.GetFields(I: Integer): TField;
begin
  if (0 <= I) and (I < FFieldCount) and (FFieldMap[I] >= 0) then
    Result := DataSet.FieldList[FFieldMap[I]]
  else
    Result := nil;
end;

function TbsGridDataLink.AddMapping(const FieldName: string): Boolean;
var
  Field: TField;
  NewSize: Integer;
begin
  Result := True;
  if FFieldCount >= MaxMapSize then RaiseGridError(STooManyColumns);
  if SparseMap then
    Field := DataSet.FindField(FieldName)
  else
    Field := DataSet.FieldByName(FieldName);

  if FFieldCount = Length(FFieldMap) then
  begin
    NewSize := Length(FFieldMap);
    if NewSize = 0 then
      NewSize := 8
    else
      Inc(NewSize, NewSize);
    if (NewSize < FFieldCount) then
      NewSize := FFieldCount + 1;
    if (NewSize > MaxMapSize) then
      NewSize := MaxMapSize;
    SetLength(FFieldMap, NewSize);
  end;
  if Assigned(Field) then
  begin
    FFieldMap[FFieldCount] := Dataset.FieldList.IndexOfObject(Field);
    Field.FreeNotification(FGrid);
  end
  else
    FFieldMap[FFieldCount] := -1;
  Inc(FFieldCount);
end;

procedure TbsGridDataLink.ActiveChanged;
begin
  FGrid.LinkActive(Active);
  FModified := False;
end;

procedure TbsGridDataLink.ClearMapping;
begin
  FFieldMap := nil;
  FFieldCount := 0;
end;

procedure TbsGridDataLink.Modified;
begin
  FModified := True;
end;

procedure TbsGridDataLink.DataSetChanged;
begin
  FGrid.DataChanged;
  FModified := False;
end;

procedure TbsGridDataLink.DataSetScrolled(Distance: Integer);
begin
  FGrid.Scroll(Distance);
end;

procedure TbsGridDataLink.LayoutChanged;
var
  SaveState: Boolean;
begin
  { FLayoutFromDataset determines whether default column width is forced to
    be at least wide enough for the column title.  }
  SaveState := FGrid.FLayoutFromDataset;
  FGrid.FLayoutFromDataset := True;
  try
    FGrid.LayoutChanged;
  finally
    FGrid.FLayoutFromDataset := SaveState;
  end;
  inherited LayoutChanged;
end;

procedure TbsGridDataLink.FocusControl(Field: TFieldRef);
begin
  if Assigned(Field) and Assigned(Field^) then
  begin
    FGrid.SelectedField := Field^;
    if (FGrid.SelectedField = Field^) and FGrid.AcquireFocus then
    begin
      Field^ := nil;
      FGrid.ShowEditor;
    end;
  end;
end;

procedure TbsGridDataLink.EditingChanged;
begin
  FGrid.EditingChanged;
end;

procedure TbsGridDataLink.RecordChanged(Field: TField);
begin
  FGrid.RecordChanged(Field);
  FModified := False;
end;

procedure TbsGridDataLink.UpdateData;
begin
  FInUpdateData := True;
  try
    if FModified then FGrid.UpdateData;
    FModified := False;
  finally
    FInUpdateData := False;
  end;
end;

function TbsGridDataLink.GetMappedIndex(ColIndex: Integer): Integer;
begin
  if (0 <= ColIndex) and (ColIndex < FFieldCount) then
    Result := FFieldMap[ColIndex]
  else
    Result := -1;
end;

procedure TbsGridDataLink.Reset;
begin
  if FModified then RecordChanged(nil) else Dataset.Cancel;
end;

function TbsGridDataLink.IsAggRow(Value: Integer): Boolean;
begin
  Result := False;
end;

procedure TbsGridDataLink.BuildAggMap;
begin
end;

{ TbsColumnTitle }
constructor TbsColumnTitle.Create(Column: TbsColumn);
begin
  inherited Create;
  FColumn := Column;
  FFont := TFont.Create;
  FFont.Assign(DefaultFont);
  FFont.OnChange := FontChanged;
end;

destructor TbsColumnTitle.Destroy;
begin
  FFont.Free;
  inherited Destroy;
end;

procedure TbsColumnTitle.Assign(Source: TPersistent);
begin
  if Source is TbsColumnTitle then
  begin
    if cvTitleAlignment in TbsColumnTitle(Source).FColumn.FAssignedValues then
      Alignment := TbsColumnTitle(Source).Alignment;
    if cvTitleColor in TbsColumnTitle(Source).FColumn.FAssignedValues then
      Color := TbsColumnTitle(Source).Color;
    if cvTitleCaption in TbsColumnTitle(Source).FColumn.FAssignedValues then
      Caption := TbsColumnTitle(Source).Caption;
    if cvTitleFont in TbsColumnTitle(Source).FColumn.FAssignedValues then
      Font := TbsColumnTitle(Source).Font;
  end
  else
    inherited Assign(Source);
end;

function TbsColumnTitle.DefaultAlignment: TAlignment;
begin
  Result := taLeftJustify;
end;

function TbsColumnTitle.DefaultColor: TColor;
var
  Grid: TbsSkinCustomDBGrid;
begin
  Grid := FColumn.GetGrid;
  if Assigned(Grid) then
    Result := Grid.FixedColor
  else
    Result := clBtnFace;
end;

function TbsColumnTitle.DefaultFont: TFont;
var
  Grid: TbsSkinCustomDBGrid;
begin
  Grid := FColumn.GetGrid;
  if Assigned(Grid) then
    Result := Grid.TitleFont
  else
    Result := FColumn.Font;
end;

function TbsColumnTitle.DefaultCaption: string;
var
  Field: TField;
begin
  Field := FColumn.Field;
  if Assigned(Field) then
    Result := Field.DisplayName
  else
    Result := FColumn.FieldName;
end;

procedure TbsColumnTitle.FontChanged(Sender: TObject);
begin
  Include(FColumn.FAssignedValues, cvTitleFont);
  FColumn.Changed(True);
end;

function TbsColumnTitle.GetAlignment: TAlignment;
begin
  if cvTitleAlignment in FColumn.FAssignedValues then
    Result := FAlignment
  else
    Result := DefaultAlignment;
end;

function TbsColumnTitle.GetColor: TColor;
begin
  if cvTitleColor in FColumn.FAssignedValues then
    Result := FColor
  else
    Result := DefaultColor;
end;

function TbsColumnTitle.GetCaption: string;
begin
  if cvTitleCaption in FColumn.FAssignedValues then
    Result := FCaption
  else
    Result := DefaultCaption;
end;

function TbsColumnTitle.GetFont: TFont;
var
  Save: TNotifyEvent;
  Def: TFont;
begin
  if not (cvTitleFont in FColumn.FAssignedValues) then
  begin
    Def := DefaultFont;
    if (FFont.Handle <> Def.Handle) or (FFont.Color <> Def.Color) then
    begin
      Save := FFont.OnChange;
      FFont.OnChange := nil;
      FFont.Assign(DefaultFont);
      FFont.OnChange := Save;
    end;
  end;
  Result := FFont;
end;

function TbsColumnTitle.IsAlignmentStored: Boolean;
begin
  Result := (cvTitleAlignment in FColumn.FAssignedValues) and
    (FAlignment <> DefaultAlignment);
end;

function TbsColumnTitle.IsColorStored: Boolean;
begin
  Result := (cvTitleColor in FColumn.FAssignedValues) and
    (FColor <> DefaultColor);
end;

function TbsColumnTitle.IsFontStored: Boolean;
begin
  Result := (cvTitleFont in FColumn.FAssignedValues);
end;

function TbsColumnTitle.IsCaptionStored: Boolean;
begin
  Result := (cvTitleCaption in FColumn.FAssignedValues) and
    (FCaption <> DefaultCaption);
end;

procedure TbsColumnTitle.RefreshDefaultFont;
var
  Save: TNotifyEvent;
begin
  if (cvTitleFont in FColumn.FAssignedValues) then Exit;
  Save := FFont.OnChange;
  FFont.OnChange := nil;
  try
    FFont.Assign(DefaultFont);
  finally
    FFont.OnChange := Save;
  end;
end;

procedure TbsColumnTitle.RestoreDefaults;
var
  FontAssigned: Boolean;
begin
  FontAssigned := cvTitleFont in FColumn.FAssignedValues;
  FColumn.FAssignedValues := FColumn.FAssignedValues - ColumnTitleValues;
  FCaption := '';
  RefreshDefaultFont;
  { If font was assigned, changing it back to default may affect grid title
    height, and title height changes require layout and redraw of the grid. }
  FColumn.Changed(FontAssigned);
end;

procedure TbsColumnTitle.SetAlignment(Value: TAlignment);
begin
  if (cvTitleAlignment in FColumn.FAssignedValues) and (Value = FAlignment) then Exit;
  FAlignment := Value;
  Include(FColumn.FAssignedValues, cvTitleAlignment);
  FColumn.Changed(False);
end;

procedure TbsColumnTitle.SetColor(Value: TColor);
begin
  if (cvTitleColor in FColumn.FAssignedValues) and (Value = FColor) then Exit;
  FColor := Value;
  Include(FColumn.FAssignedValues, cvTitleColor);
  FColumn.Changed(False);
end;

procedure TbsColumnTitle.SetFont(Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TbsColumnTitle.SetCaption(const Value: string);
var
  Grid: TbsSkinCustomDBGrid;
begin
  if Column.IsStored then
  begin
    if (cvTitleCaption in FColumn.FAssignedValues) and (Value = FCaption) then Exit;
    FCaption := Value;
    Include(Column.FAssignedValues, cvTitleCaption);
    Column.Changed(False);
  end
  else
  begin
    Grid := Column.GetGrid;
    if Assigned(Grid) and (Grid.Datalink.Active) and Assigned(Column.Field) then
      Column.Field.DisplayLabel := Value;
  end;
end;


{ TbsColumn }

constructor TbsColumn.Create(Collection: TCollection);
var
  Grid: TbsSkinCustomDBGrid;
begin
  Grid := nil;
  if Assigned(Collection) and (Collection is TbsDBGridColumns) then
    Grid := TbsDBGridColumns(Collection).Grid;
  if Assigned(Grid) then Grid.BeginLayout;
  try
    inherited Create(Collection);
    FDropDownRows := 7;
    FButtonStyle := cbsAuto;
    FFont := TFont.Create;
    FFont.Assign(DefaultFont);
    FFont.OnChange := FontChanged;
    FImeMode := imDontCare;
    FImeName := Screen.DefaultIme;
    FTitle := CreateTitle;
    FVisible := True;
    FExpanded := True;
    FStored := True;
  finally
    if Assigned(Grid) then Grid.EndLayout;
  end;
end;

destructor TbsColumn.Destroy;
begin
  FTitle.Free;
  FFont.Free;
  FPickList.Free;
  inherited Destroy;
end;

procedure TbsColumn.Assign(Source: TPersistent);
begin
  if Source is TbsColumn then
  begin
    if Assigned(Collection) then Collection.BeginUpdate;
    try
      RestoreDefaults;
      FieldName := TbsColumn(Source).FieldName;
      if cvColor in TbsColumn(Source).AssignedValues then
        Color := TbsColumn(Source).Color;
      if cvWidth in TbsColumn(Source).AssignedValues then
        Width := TbsColumn(Source).Width;
      if cvFont in TbsColumn(Source).AssignedValues then
        Font := TbsColumn(Source).Font;
      if cvImeMode in TbsColumn(Source).AssignedValues then
        ImeMode := TbsColumn(Source).ImeMode;
      if cvImeName in TbsColumn(Source).AssignedValues then
        ImeName := TbsColumn(Source).ImeName;
      if cvAlignment in TbsColumn(Source).AssignedValues then
        Alignment := TbsColumn(Source).Alignment;
      if cvReadOnly in TbsColumn(Source).AssignedValues then
        ReadOnly := TbsColumn(Source).ReadOnly;
      Title := TbsColumn(Source).Title;
      DropDownRows := TbsColumn(Source).DropDownRows;
      ButtonStyle := TbsColumn(Source).ButtonStyle;
      PickList := TbsColumn(Source).PickList;
      PopupMenu := TbsColumn(Source).PopupMenu;
      FVisible := TbsColumn(Source).FVisible;
      FExpanded := TbsColumn(Source).FExpanded;
    finally
      if Assigned(Collection) then Collection.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

function TbsColumn.CreateTitle: TbsColumnTitle;
begin
  Result := TbsColumnTitle.Create(Self);
end;

function TbsColumn.DefaultAlignment: TAlignment;
begin
  if Assigned(Field) then
    Result := FField.Alignment
  else
    Result := taLeftJustify;
end;

function TbsColumn.DefaultColor: TColor;
var
  Grid: TbsSkinCustomDBGrid;
begin
  Grid := GetGrid;
  if Assigned(Grid) then
    Result := Grid.Color
  else
    Result := clWindow;
end;

function TbsColumn.DefaultFont: TFont;
var
  Grid: TbsSkinCustomDBGrid;
begin
  Grid := GetGrid;
  if Assigned(Grid) then
    Result := Grid.Font
  else
    Result := FFont;
end;

function TbsColumn.DefaultImeMode: TImeMode;
var
  Grid: TbsSkinCustomDBGrid;
begin
  Grid := GetGrid;
  if Assigned(Grid) then
    Result := Grid.ImeMode
  else
    Result := FImeMode;
end;

function TbsColumn.DefaultImeName: TImeName;
var
  Grid: TbsSkinCustomDBGrid;
begin
  Grid := GetGrid;
  if Assigned(Grid) then
    Result := Grid.ImeName
  else
    Result := FImeName;
end;

function TbsColumn.DefaultReadOnly: Boolean;
var
  Grid: TbsSkinCustomDBGrid;
begin
  Grid := GetGrid;
  Result := (Assigned(Grid) and Grid.ReadOnly) or
    (Assigned(Field) and FField.ReadOnly);
end;

function TbsColumn.DefaultWidth: Integer;
var
  W: Integer;
  RestoreCanvas: Boolean;
  TM: TTextMetric;
begin
  if GetGrid = nil then
  begin
    Result := 64;
    Exit;
  end;
  with GetGrid do
  begin
    if Assigned(Field) then
    begin
      RestoreCanvas := not HandleAllocated;
      if RestoreCanvas then
        Canvas.Handle := GetDC(0);
      try
        Canvas.Font := Self.Font;
        GetTextMetrics(Canvas.Handle, TM);
        Result := Field.DisplayWidth * (Canvas.TextWidth('0') - TM.tmOverhang)
          + TM.tmOverhang + 4;
        if dgTitles in Options then
        begin
          Canvas.Font := Title.Font;
          W := Canvas.TextWidth(Title.Caption) + 4;
          if Result < W then
            Result := W;
        end;
      finally
        if RestoreCanvas then
        begin
          ReleaseDC(0,Canvas.Handle);
          Canvas.Handle := 0;
        end;
      end;
    end
    else
      Result := DefaultColWidth;
  end;
end;

procedure TbsColumn.FontChanged;
begin
  Include(FAssignedValues, cvFont);
  Title.RefreshDefaultFont;
  Changed(False);
end;

function TbsColumn.GetAlignment: TAlignment;
begin
  if cvAlignment in FAssignedValues then
    Result := FAlignment
  else
    Result := DefaultAlignment;
end;

function TbsColumn.GetColor: TColor;
begin
  if cvColor in FAssignedValues then
    Result := FColor
  else
    Result := DefaultColor;
end;

function TbsColumn.GetExpanded: Boolean;
begin
  Result := FExpanded and Expandable;
end;

function TbsColumn.GetField: TField;
var
  Grid: TbsSkinCustomDBGrid;
begin    { Returns Nil if FieldName can't be found in dataset }
  Grid := GetGrid;
  if (FField = nil) and (Length(FFieldName) > 0) and Assigned(Grid) and
    Assigned(Grid.DataLink.DataSet) then
  with Grid.Datalink.Dataset do
    if Active or (not DefaultFields) then
      SetField(FindField(FieldName));
  Result := FField;
end;

function TbsColumn.GetFont: TFont;
var
  Save: TNotifyEvent;
begin
  if not (cvFont in FAssignedValues) and (FFont.Handle <> DefaultFont.Handle) then
  begin
    Save := FFont.OnChange;
    FFont.OnChange := nil;
    FFont.Assign(DefaultFont);
    FFont.OnChange := Save;
  end;
  Result := FFont;
end;

function TbsColumn.GetGrid: TbsSkinCustomDBGrid;
begin
  if Assigned(Collection) and (Collection is TbsDBGridColumns) then
    Result := TbsDBGridColumns(Collection).Grid
  else
    Result := nil;
end;

function TbsColumn.GetDisplayName: string;
begin
  Result := FFieldName;
  if Result = '' then Result := inherited GetDisplayName;
end;

function TbsColumn.GetImeMode: TImeMode;
begin
  if cvImeMode in FAssignedValues then
    Result := FImeMode
  else
    Result := DefaultImeMode;
end;

function TbsColumn.GetImeName: TImeName;
begin
  if cvImeName in FAssignedValues then
    Result := FImeName
  else
    Result := DefaultImeName;
end;

function TbsColumn.GetParentColumn: TbsColumn;
var
  Col: TbsColumn;
  Fld: TField;
  I: Integer;
begin
  Result := nil;
  Fld := Field;
  if (Fld <> nil) and (Fld.ParentField <> nil) and (Collection <> nil) then
    for I := Index - 1 downto 0 do
    begin
      Col := TbsColumn(Collection.Items[I]);
      if Fld.ParentField = Col.Field then
      begin
        Result := Col;
        Exit;
      end;
    end;
end;

function TbsColumn.GetPickList: TStrings;
begin
  if FPickList = nil then FPickList := TStringList.Create;
  Result := FPickList;
end;

function TbsColumn.GetReadOnly: Boolean;
begin
  if cvReadOnly in FAssignedValues then
    Result := FReadOnly
  else
    Result := DefaultReadOnly;
end;

function TbsColumn.GetShowing: Boolean;
var
  Col: TbsColumn;
begin
  Result := not Expanded and Visible;
  if Result then
  begin
    Col := Self;
    repeat
      Col := Col.ParentColumn;
    until (Col = nil) or not Col.Expanded;
    Result := Col = nil;
  end;
end;

function TbsColumn.GetVisible: Boolean;
var
  Col: TbsColumn;
begin
  Result := FVisible;
  if Result then
  begin
    Col := ParentColumn;
    Result := Result and ((Col = nil) or Col.Visible);
  end;
end;

function TbsColumn.GetWidth: Integer;
begin
  if not Showing then
    Result := -1
  else if cvWidth in FAssignedValues then
    Result := FWidth
  else
    Result := DefaultWidth;
end;

function TbsColumn.IsAlignmentStored: Boolean;
begin
  Result := (cvAlignment in FAssignedValues) and (FAlignment <> DefaultAlignment);
end;

function TbsColumn.IsColorStored: Boolean;
begin
  Result := (cvColor in FAssignedValues) and (FColor <> DefaultColor);
end;

function TbsColumn.IsFontStored: Boolean;
begin
  Result := (cvFont in FAssignedValues);
end;

function TbsColumn.IsImeModeStored: Boolean;
begin
  Result := (cvImeMode in FAssignedValues) and (FImeMode <> DefaultImeMode);
end;

function TbsColumn.IsImeNameStored: Boolean;
begin
  Result := (cvImeName in FAssignedValues) and (FImeName <> DefaultImeName);
end;

function TbsColumn.IsReadOnlyStored: Boolean;
begin
  Result := (cvReadOnly in FAssignedValues) and (FReadOnly <> DefaultReadOnly);
end;

function TbsColumn.IsWidthStored: Boolean;
begin
  Result := (cvWidth in FAssignedValues) and (FWidth <> DefaultWidth);
end;

procedure TbsColumn.RefreshDefaultFont;
var
  Save: TNotifyEvent;
begin
  if cvFont in FAssignedValues then Exit;
  Save := FFont.OnChange;
  FFont.OnChange := nil;
  try
    FFont.Assign(DefaultFont);
  finally
    FFont.OnChange := Save;
  end;
end;

procedure TbsColumn.RestoreDefaults;
var
  FontAssigned: Boolean;
begin
  FontAssigned := cvFont in FAssignedValues;
  FTitle.RestoreDefaults;
  FAssignedValues := [];
  RefreshDefaultFont;
  FPickList.Free;
  FPickList := nil;
  ButtonStyle := cbsAuto;
  Changed(FontAssigned);
end;

procedure TbsColumn.SetAlignment(Value: TAlignment);
var
  Grid: TbsSkinCustomDBGrid;
begin
  if IsStored then
  begin
    if (cvAlignment in FAssignedValues) and (Value = FAlignment) then Exit;
    FAlignment := Value;
    Include(FAssignedValues, cvAlignment);
    Changed(False);
  end
  else
  begin
    Grid := GetGrid;
    if Assigned(Grid) and (Grid.Datalink.Active) and Assigned(Field) then
      Field.Alignment := Value;
  end;
end;

procedure TbsColumn.SetButtonStyle(Value: TbsColumnButtonStyle);
begin
  if Value = FButtonStyle then Exit;
  FButtonStyle := Value;
  Changed(False);
end;

procedure TbsColumn.SetColor(Value: TColor);
begin
  if (cvColor in FAssignedValues) and (Value = FColor) then Exit;
  FColor := Value;
  Include(FAssignedValues, cvColor);
  Changed(False);
end;

procedure TbsColumn.SetField(Value: TField);
begin
  if FField = Value then Exit;
  if Assigned(FField) and
     (GetGrid <> nil) then
    FField.RemoveFreeNotification(GetGrid);
  FField := Value;
  if Assigned(Value) then
  begin
    if GetGrid <> nil then
      FField.FreeNotification(GetGrid);
    FFieldName := Value.FullName;
  end;
  if not IsStored then
  begin
    if Value = nil then
      FFieldName := '';
    RestoreDefaults;
  end;
  Changed(False);
end;

procedure TbsColumn.SetFieldName(const Value: String);
var
  AField: TField;
  Grid: TbsSkinCustomDBGrid;
begin
  AField := nil;
  Grid := GetGrid;
  if Assigned(Grid) and Assigned(Grid.DataLink.DataSet) and
    not (csLoading in Grid.ComponentState) and (Length(Value) > 0) then
      AField := Grid.DataLink.DataSet.FindField(Value); { no exceptions }
  FFieldName := Value;
  SetField(AField);
  Changed(False);
end;

procedure TbsColumn.SetFont(Value: TFont);
begin
  FFont.Assign(Value);
  Include(FAssignedValues, cvFont);
  Changed(False);
end;

procedure TbsColumn.SetImeMode(Value: TImeMode);
begin
  if (cvImeMode in FAssignedValues) or (Value <> DefaultImeMode) then
  begin
    FImeMode := Value;
    Include(FAssignedValues, cvImeMode);
  end;
  Changed(False);
end;

procedure TbsColumn.SetImeName(Value: TImeName);
begin
  if (cvImeName in FAssignedValues) or (Value <> DefaultImeName) then
  begin
    FImeName := Value;
    Include(FAssignedValues, cvImeName);
  end;
  Changed(False);
end;

procedure TbsColumn.SetIndex(Value: Integer);
var
  Grid: TbsSkinCustomDBGrid;
  Fld: TField;
  I, OldIndex: Integer;
  Col: TbsColumn;
begin
  OldIndex := Index;
  Grid := GetGrid;

  if IsStored then
  begin
    Grid.BeginLayout;
    try
      I := OldIndex + 1;  // move child columns along with parent
      while (I < Collection.Count) and (TbsColumn(Collection.Items[I]).ParentColumn = Self) do
        Inc(I);
      Dec(I);
      if OldIndex > Value then   // column moving left
      begin
        while I > OldIndex do
        begin
          Collection.Items[I].Index := Value;
          Inc(OldIndex);
        end;
        inherited SetIndex(Value);
      end
      else
      begin
        inherited SetIndex(Value);
        while I > OldIndex do
        begin
          Collection.Items[OldIndex].Index := Value;
          Dec(I);
        end;
      end;
    finally
      Grid.EndLayout;
    end;
  end
  else
  begin
    if (Grid <> nil) and Grid.Datalink.Active then
    begin
      if Grid.AcquireLayoutLock then
      try
        Col := Grid.ColumnAtDepth(Grid.Columns[Value], Depth);
        if (Col <> nil) then
        begin
          Fld := Col.Field;
          if Assigned(Fld) then
            Field.Index := Fld.Index;
        end;
      finally
        Grid.EndLayout;
      end;
    end;
    inherited SetIndex(Value);
  end;
end;

procedure TbsColumn.SetPickList(Value: TStrings);
begin
  if Value = nil then
  begin
    FPickList.Free;
    FPickList := nil;
    Exit;
  end;
  PickList.Assign(Value);
end;

procedure TbsColumn.SetPopupMenu(Value: TPopupMenu);
begin
  FPopupMenu := Value;
  if Value <> nil then Value.FreeNotification(GetGrid);
end;

procedure TbsColumn.SetReadOnly(Value: Boolean);
var
  Grid: TbsSkinCustomDBGrid;
begin
  Grid := GetGrid;
  if not IsStored and Assigned(Grid) and Grid.Datalink.Active and Assigned(Field) then
    Field.ReadOnly := Value
  else
  begin
    if (cvReadOnly in FAssignedValues) and (Value = FReadOnly) then Exit;
    FReadOnly := Value;
    Include(FAssignedValues, cvReadOnly);
    Changed(False);
  end;
end;

procedure TbsColumn.SetTitle(Value: TbsColumnTitle);
begin
  FTitle.Assign(Value);
end;

procedure TbsColumn.SetWidth(Value: Integer);
var
  Grid: TbsSkinCustomDBGrid;
  TM: TTextMetric;
  DoSetWidth: Boolean;
begin
  DoSetWidth := IsStored;
  if not DoSetWidth then
  begin
    Grid := GetGrid;
    if Assigned(Grid) then
    begin
      if Grid.HandleAllocated and Assigned(Field) and Grid.FUpdateFields then
      with Grid do
      begin
        Canvas.Font := Self.Font;
        GetTextMetrics(Canvas.Handle, TM);
        Field.DisplayWidth := (Value + (TM.tmAveCharWidth div 2) - TM.tmOverhang - 3)
          div TM.tmAveCharWidth;
      end;
      if (not Grid.FLayoutFromDataset) or (cvWidth in FAssignedValues) then
        DoSetWidth := True;
    end
    else
      DoSetWidth := True;
  end;
  if DoSetWidth then
  begin
    if ((cvWidth in FAssignedValues) or (Value <> DefaultWidth))
      and (Value <> -1) then
    begin
      FWidth := Value;
      Include(FAssignedValues, cvWidth);
    end;
    Changed(False);
  end;
end;

procedure TbsColumn.SetVisible(Value: Boolean);
begin
  if Value <> FVisible then
  begin
    FVisible := Value;
    Changed(True);
  end;
end;

procedure TbsColumn.SetExpanded(Value: Boolean);
const
  Direction: array [Boolean] of ShortInt = (-1,1);
var
  Grid: TbsSkinCustomDBGrid;
  WasShowing: Boolean;
begin
  if Value <> FExpanded then
  begin
    Grid := GetGrid;
    WasShowing := (Grid <> nil) and Grid.Columns[Grid.SelectedIndex].Showing;
    FExpanded := Value;
    Changed(True);
    if (Grid <> nil) and WasShowing then
    begin
      if not Grid.Columns[Grid.SelectedIndex].Showing then
        // The selected cell was hidden by this expand operation
        // Select 1st child (next col = 1) when parent is expanded
        // Select child's parent (prev col = -1) when parent is collapsed
        Grid.MoveCol(Grid.Col, Direction[FExpanded]);
    end;
  end;
end;

function TbsColumn.Depth: Integer;
var
  Col: TbsColumn;
begin
  Result := 0;
  Col := ParentColumn;
  if Col <> nil then Result := Col.Depth + 1;
end;

function TbsColumn.GetExpandable: Boolean;
var
  Fld: TField;
begin
  Fld := Field;
  Result := (Fld <> nil) and (Fld.DataType in [ftADT, ftArray]);
end;

{ TbsDBGridColumns }

constructor TbsDBGridColumns.Create(Grid: TbsSkinCustomDBGrid; ColumnClass: TbsColumnClass);
begin
  inherited Create(ColumnClass);
  FGrid := Grid;
end;

function TbsDBGridColumns.Add: TbsColumn;
begin
  Result := TbsColumn(inherited Add);
end;

function TbsDBGridColumns.GetColumn(Index: Integer): TbsColumn;
begin
  Result := TbsColumn(inherited Items[Index]);
end;

function TbsDBGridColumns.GetOwner: TPersistent;
begin
  Result := FGrid;
end;

procedure TbsDBGridColumns.LoadFromFile(const Filename: string);
var
  S: TFileStream;
begin
  S := TFileStream.Create(Filename, fmOpenRead);
  try
    LoadFromStream(S);
  finally
    S.Free;
  end;
end;

type
  TbsColumnsWrapper = class(TComponent)
  private
    FColumns: TbsDBGridColumns;
  published
    property Columns: TbsDBGridColumns read FColumns write FColumns;
  end;

procedure TbsDBGridColumns.LoadFromStream(S: TStream);
var
  Wrapper: TbsColumnsWrapper;
begin
  Wrapper := TbsColumnsWrapper.Create(nil);
  try
    Wrapper.Columns := FGrid.CreateColumns;
    S.ReadComponent(Wrapper);
    Assign(Wrapper.Columns);
  finally
    Wrapper.Columns.Free;
    Wrapper.Free;
  end;
end;

procedure TbsDBGridColumns.RestoreDefaults;
var
  I: Integer;
begin
  BeginUpdate;
  try
    for I := 0 to Count-1 do
      Items[I].RestoreDefaults;
  finally
    EndUpdate;
  end;
end;

procedure TbsDBGridColumns.RebuildColumns;

  procedure AddFields(Fields: TFields; Depth: Integer);
  var
    I: Integer;
  begin
    Inc(Depth);
    for I := 0 to Fields.Count-1 do
    begin
      Add.FieldName := Fields[I].FullName;
      if Fields[I].DataType in [ftADT, ftArray] then
        AddFields((Fields[I] as TObjectField).Fields, Depth);
    end;
  end;

begin
  if Assigned(FGrid) and Assigned(FGrid.DataSource) and
    Assigned(FGrid.Datasource.Dataset) then
  begin
    FGrid.BeginLayout;
    try
      Clear;
      AddFields(FGrid.Datasource.Dataset.Fields, 0);
    finally
      FGrid.EndLayout;
    end
  end
  else
    Clear;
end;

procedure TbsDBGridColumns.SaveToFile(const Filename: string);
var
  S: TStream;
begin
  S := TFileStream.Create(Filename, fmCreate);
  try
    SaveToStream(S);
  finally
    S.Free;
  end;
end;

procedure TbsDBGridColumns.SaveToStream(S: TStream);
var
  Wrapper: TbsColumnsWrapper;
begin
  Wrapper := TbsColumnsWrapper.Create(nil);
  try
    Wrapper.Columns := Self;
    S.WriteComponent(Wrapper);
  finally
    Wrapper.Free;
  end;
end;

procedure TbsDBGridColumns.SetColumn(Index: Integer; Value: TbsColumn);
begin
  Items[Index].Assign(Value);
end;

procedure TbsDBGridColumns.SetState(NewState: TbsDBGridColumnsState);
begin
  if NewState = State then Exit;
  if NewState = csDefault then
    Clear
  else
    RebuildColumns;
end;

procedure TbsDBGridColumns.Update(Item: TCollectionItem);
var
  Raw: Integer;
begin
  if (FGrid = nil) or (csLoading in FGrid.ComponentState) then Exit;
  if Item = nil then
  begin
    FGrid.LayoutChanged;
  end
  else
  begin
    Raw := FGrid.DataToRawColumn(Item.Index);
    FGrid.InvalidateCol(Raw);
    FGrid.ColWidths[Raw] := TbsColumn(Item).Width;
  end;
end;

function TbsDBGridColumns.InternalAdd: TbsColumn;
begin
  Result := Add;
  Result.IsStored := False;
end;

function TbsDBGridColumns.GetState: TbsDBGridColumnsState;
begin
  Result := TbsDBGridColumnsState((Count > 0) and Items[0].IsStored);
end;

{ TbsBookmarkList }

constructor TbsBookmarkList.Create(AGrid: TbsSkinCustomDBGrid);
begin
  inherited Create;
  FList := TStringList.Create;
  FList.OnChange := StringsChanged;
  FGrid := AGrid;
end;

destructor TbsBookmarkList.Destroy;
begin
  Clear;
  FList.Free;
  inherited Destroy;
end;

procedure TbsBookmarkList.Clear;
begin
  if FList.Count = 0 then Exit;
  FList.Clear;
  FGrid.Invalidate;
end;

function TbsBookmarkList.Compare(const Item1, Item2: TBookmarkStr): Integer;
begin
  with FGrid.Datalink.Datasource.Dataset do
    Result := CompareBookmarks(TBookmark(Item1), TBookmark(Item2));
end;

function TbsBookmarkList.CurrentRow: TBookmarkStr;
begin
  if not FLinkActive then RaiseGridError(sDataSetClosed);
  Result := FGrid.Datalink.Datasource.Dataset.Bookmark;
end;

function TbsBookmarkList.GetCurrentRowSelected: Boolean;
var
  Index: Integer;
begin
  Result := Find(CurrentRow, Index);
end;

function TbsBookmarkList.Find(const Item: TBookmarkStr; var Index: Integer): Boolean;
var
  L, H, I, C: Integer;
begin
  if (Item = FCache) and (FCacheIndex >= 0) then
  begin
    Index := FCacheIndex;
    Result := FCacheFind;
    Exit;
  end;
  Result := False;
  L := 0;
  H := FList.Count - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    C := Compare(FList[I], Item);
    if C < 0 then L := I + 1 else
    begin
      H := I - 1;
      if C = 0 then
      begin
        Result := True;
        L := I;
      end;
    end;
  end;
  Index := L;
  FCache := Item;
  FCacheIndex := Index;
  FCacheFind := Result;
end;

function TbsBookmarkList.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TbsBookmarkList.GetItem(Index: Integer): TBookmarkStr;
begin
  Result := FList[Index];
end;

function TbsBookmarkList.IndexOf(const Item: TBookmarkStr): Integer;
begin
  if not Find(Item, Result) then
    Result := -1;
end;

procedure TbsBookmarkList.LinkActive(Value: Boolean);
begin
  Clear;
  FLinkActive := Value;
end;

procedure TbsBookmarkList.Delete;
var
  I: Integer;
begin
  with FGrid.Datalink.Datasource.Dataset do
  begin
    DisableControls;
    try
      for I := FList.Count-1 downto 0 do
      begin
        Bookmark := FList[I];
        Delete;
        FList.Delete(I);
      end;
    finally
      EnableControls;
    end;
  end;
end;

function TbsBookmarkList.Refresh: Boolean;
var
  I: Integer;
begin
  Result := False;
  with FGrid.DataLink.Datasource.Dataset do
  try
    CheckBrowseMode;
    for I := FList.Count - 1 downto 0 do
      if not BookmarkValid(TBookmark(FList[I])) then
      begin
        Result := True;
        FList.Delete(I);
      end;
  finally
    UpdateCursorPos;
    if Result then FGrid.Invalidate;
  end;
end;

procedure TbsBookmarkList.SetCurrentRowSelected(Value: Boolean);
var
  Index: Integer;
  Current: TBookmarkStr;
begin
  Current := CurrentRow;
  if (Length(Current) = 0) or (Find(Current, Index) = Value) then Exit;
  if Value then
    FList.Insert(Index, Current)
  else
    FList.Delete(Index);
  FGrid.InvalidateRow(FGrid.Row);
end;

procedure TbsBookmarkList.StringsChanged(Sender: TObject);
begin
  FCache := '';
  FCacheIndex := -1;
end;


{ TbsSkinCustomDBGrid }

var
  DrawBitmap: TBitmap;
  UserCount: Integer;

procedure UsesBitmap;
begin
  if UserCount = 0 then
    DrawBitmap := TBitmap.Create;
  Inc(UserCount);
end;

procedure ReleaseBitmap;
begin
  Dec(UserCount);
  if UserCount = 0 then DrawBitmap.Free;
end;

procedure WriteText(ACanvas: TCanvas; ARect: TRect; DX, DY: Integer;
  const Text: string; Alignment: TAlignment; ARightToLeft: Boolean);
const
  AlignFlags : array [TAlignment] of Integer =
    ( DT_LEFT or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX,
      DT_RIGHT or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX,
      DT_CENTER or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX );
  RTL: array [Boolean] of Integer = (0, DT_RTLREADING);
var
  B, R: TRect;
  Hold, Left, Top: Integer;
  I: TColorRef;
begin
  I := ColorToRGB(ACanvas.Brush.Color);
  if GetNearestColor(ACanvas.Handle, I) = I then
  begin                       { Use ExtTextOut for solid colors }
    { In BiDi, because we changed the window origin, the text that does not
      change alignment, actually gets its alignment changed. }
    if (ACanvas.CanvasOrientation = coRightToLeft) and (not ARightToLeft) then
      ChangeBiDiModeAlignment(Alignment);
    case Alignment of
      taLeftJustify:
        Left := ARect.Left + DX + 2;
      taRightJustify:
        Left := ARect.Right - ACanvas.TextWidth(Text) - 3;
    else { taCenter }
      Left := ARect.Left + (ARect.Right - ARect.Left) shr 1
        - (ACanvas.TextWidth(Text) shr 1);
    end;
    Top := ARect.Top + RectHeight(ARect) div 2 - ACanvas.TextHeight(Text) div 2;
    ACanvas.TextRect(ARect, Left, Top, Text);
  end
  else begin                  { Use FillRect and Drawtext for dithered colors }
    DrawBitmap.Canvas.Lock;
    try
      with DrawBitmap, ARect do { Use offscreen bitmap to eliminate flicker and }
      begin                     { brush origin tics in painting / scrolling.    }
        Width := Max(Width, Right - Left);
        Height := Max(Height, Bottom - Top);
        R := Rect(DX, DY, Right - Left - 1, Bottom - Top - 1);
        B := Rect(0, 0, Right - Left, Bottom - Top);
      end;
      with DrawBitmap.Canvas do
      begin
        Font := ACanvas.Font;
        Font.Color := ACanvas.Font.Color;
        Brush := ACanvas.Brush;
        Brush.Style := bsSolid;
        FillRect(B);
        SetBkMode(Handle, TRANSPARENT);
        if (ACanvas.CanvasOrientation = coRightToLeft) then
          ChangeBiDiModeAlignment(Alignment);
        DrawText(Handle, PChar(Text), Length(Text), R,
          AlignFlags[Alignment] or RTL[ARightToLeft]);
      end;
      if (ACanvas.CanvasOrientation = coRightToLeft) then  
      begin
        Hold := ARect.Left;
        ARect.Left := ARect.Right;
        ARect.Right := Hold;
      end;
      ACanvas.CopyRect(ARect, DrawBitmap.Canvas, B);
    finally
      DrawBitmap.Canvas.Unlock;
    end;
  end;
end;

constructor TbsSkinCustomDBGrid.Create(AOwner: TComponent);
var
  Bmp: TBitmap;
begin
  inherited Create(AOwner);
  inherited DefaultDrawing := False;
  FUseColumnsFont := False;
  FSaveMultiSelection := False;
  FMouseWheelSupport := False;
  FSkinMessage := nil;
  FAcquireFocus := True;
  Bmp := TBitmap.Create;
  try
    Bmp.LoadFromResourceName(HInstance, bmArrow);
    FIndicators := TImageList.CreateSize(Bmp.Width, Bmp.Height);
    FIndicators.AddMasked(Bmp, clWhite);
    Bmp.LoadFromResourceName(HInstance, bmEdit);
    FIndicators.AddMasked(Bmp, clWhite);
    Bmp.LoadFromResourceName(HInstance, bmInsert);
    FIndicators.AddMasked(Bmp, clWhite);
    Bmp.LoadFromResourceName(HInstance, bmMultiDot);
    FIndicators.AddMasked(Bmp, clWhite);
    Bmp.LoadFromResourceName(HInstance, bmMultiArrow);
    FIndicators.AddMasked(Bmp, clWhite);
  finally
    Bmp.Free;
  end;
  FTitleOffset := 1;
  FIndicatorOffset := 1;
  FUpdateFields := True;
  FOptions := [dgEditing, dgTitles, dgIndicator, dgColumnResize,
    dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit];
  if SysLocale.PriLangID = LANG_KOREAN then
    Include(FOptions, dgAlwaysShowEditor);
  DesignOptionsBoost := [goColSizing];
  VirtualView := True;
  UsesBitmap;
  inherited Options := [goFixedHorzLine, goFixedVertLine, goHorzLine,
    goVertLine, goColSizing, goColMoving, goTabs, goEditing];
  FColumns := CreateColumns;
  FVisibleColumns := TList.Create;
  inherited RowCount := 2;
  inherited ColCount := 2;
  FDataLink := TbsGridDataLink.Create(Self);
  Color := clWindow;
  ParentColor := False;
  FTitleFont := TFont.Create;
  FTitleFont.OnChange := TitleFontChanged;
  FSaveCellExtents := False;
  FUserChange := True;
  FDefaultDrawing := True;
  FBookmarks := TbsBookmarkList.Create(Self);
  HideEditor;
  FPickListBoxSkinDataName := 'listbox';
end;

destructor TbsSkinCustomDBGrid.Destroy;
begin
  FColumns.Free;
  FColumns := nil;
  FVisibleColumns.Free;
  FVisibleColumns := nil;
  FDataLink.Free;
  FDataLink := nil;
  FIndicators.Free;
  FTitleFont.Free;
  FTitleFont := nil;
  FBookmarks.Free;
  FBookmarks := nil;
  inherited Destroy;
  ReleaseBitmap;
end;

procedure TbsSkinCustomDBGrid.ChangeSkinData;
begin
  inherited;
  InternalLayout;
end;

procedure TbsSkinCustomDBGrid.WMMouseWheel;
begin
  if FMouseWheelSupport
  then
    begin
      if DataSource.DataSet.Active
      then
        begin
          if Message.WheelDelta > 0 then DataSource.DataSet.Prior
          else
          if Message.WheelDelta < -0 then DataSource.DataSet.Next;
        end;
    end
  else
    inherited;
end;

procedure TbsSkinCustomDBGrid.PickListBoxOnCheckButtonClick;
begin
  if InplaceEditor.Visible
  then
    begin
      TDBGridInplaceEdit(InplaceEditor).CloseUp(True);
    end;  
end;

procedure TbsSkinCustomDBGrid.SetHScrollBar;
begin
  inherited;
  if HScrollBar <> nil then HScrollBar.PageSize := 0;
end;

procedure TbsSkinCustomDBGrid.UpdateScrollPos;
begin
  inherited UpdateScrollPos(False);
end;

procedure TbsSkinCustomDBGrid.UpdateScrollRange;
begin
  inherited UpdateScrollRange(False);
end;

function TbsSkinCustomDBGrid.AcquireFocus: Boolean;
begin
  Result := True;
  if FAcquireFocus and CanFocus and not (csDesigning in ComponentState) then
  begin
    SetFocus;
    Result := Focused or (InplaceEditor <> nil) and InplaceEditor.Focused;
  end;
end;

function TbsSkinCustomDBGrid.RawToDataColumn(ACol: Integer): Integer;
begin
  Result := ACol - FIndicatorOffset;
end;

function TbsSkinCustomDBGrid.DataToRawColumn(ACol: Integer): Integer;
begin
  Result := ACol + FIndicatorOffset;
end;

function TbsSkinCustomDBGrid.AcquireLayoutLock: Boolean;
begin
  Result := (FUpdateLock = 0) and (FLayoutLock = 0);
  if Result then BeginLayout;
end;

procedure TbsSkinCustomDBGrid.BeginLayout;
begin
  BeginUpdate;
  if FLayoutLock = 0 then Columns.BeginUpdate;
  Inc(FLayoutLock);
end;

procedure TbsSkinCustomDBGrid.BeginUpdate;
begin
  Inc(FUpdateLock);
end;

procedure TbsSkinCustomDBGrid.CancelLayout;
begin
  if FLayoutLock > 0 then
  begin
    if FLayoutLock = 1 then
      Columns.EndUpdate;
    Dec(FLayoutLock);
    EndUpdate;
  end;
end;

function TbsSkinCustomDBGrid.CanEditAcceptKey(Key: Char): Boolean;
begin
  with Columns[SelectedIndex] do
    Result := FDatalink.Active and Assigned(Field) and Field.IsValidChar(Key);
end;

function TbsSkinCustomDBGrid.CanEditModify: Boolean;
begin
  Result := False;
  if not ReadOnly and FDatalink.Active and not FDatalink.Readonly then
  with Columns[SelectedIndex] do
    if (not ReadOnly) and Assigned(Field) and Field.CanModify
      and (not (Field.DataType in ftNonTextTypes) or Assigned(Field.OnSetText)) then
    begin
      FDatalink.Edit;
      Result := FDatalink.Editing;
      if Result then FDatalink.Modified;
    end;
end;

function TbsSkinCustomDBGrid.CanEditShow: Boolean;
var
  CellIndex: Integer;
begin
  Result := (LayoutLock = 0) and inherited CanEditShow;
  if Result
  then
    begin
     if dgIndicator in Options
     then
       CellIndex := Col - 1
     else
      CellIndex := Col;
     if (CellIndex >= 0) and (Columns.Count > 0) and (Columns[CellIndex].Field <> nil) and
     (Columns[CellIndex].Field.DataType = ftBoolean)
     then
       begin
         Result := False;
       end;
    end;
end;

procedure TbsSkinCustomDBGrid.CellClick(Column: TbsColumn);
begin
  if Assigned(FOnCellClick) then FOnCellClick(Column);
end;

procedure TbsSkinCustomDBGrid.ColEnter;
begin
  UpdateIme;
  if Assigned(FOnColEnter) then FOnColEnter(Self);
end;

procedure TbsSkinCustomDBGrid.ColExit;
begin
  if Assigned(FOnColExit) then FOnColExit(Self);
end;

procedure TbsSkinCustomDBGrid.ColumnMoved(FromIndex, ToIndex: Longint);
begin
  FromIndex := RawToDataColumn(FromIndex);
  ToIndex := RawToDataColumn(ToIndex);
  Columns[FromIndex].Index := ToIndex;
  if Assigned(FOnColumnMoved) then FOnColumnMoved(Self, FromIndex, ToIndex);
end;

procedure TbsSkinCustomDBGrid.ColWidthsChanged;
var
  I: Integer;
begin
  inherited ColWidthsChanged;
  if (FDatalink.Active or (FColumns.State = csCustomized)) and
    AcquireLayoutLock then
  try
    for I := FIndicatorOffset to ColCount - 1 do
      FColumns[I - FIndicatorOffset].Width := ColWidths[I];
  finally
    EndLayout;
  end;
end;

function TbsSkinCustomDBGrid.CreateColumns: TbsDBGridColumns;
begin
  Result := TbsDBGridColumns.Create(Self, TbsColumn);
end;

function TbsSkinCustomDBGrid.CreateEditor: TbsSkinInplaceEdit;
begin
  Result := TDBGridInplaceEdit.Create(Self);
end;

procedure TbsSkinCustomDBGrid.CreateWnd;
begin
  BeginUpdate;   { prevent updates in WMSize message that follows WMCreate }
  try
    inherited CreateWnd;
  finally
    EndUpdate;
  end;
  UpdateRowCount;
  UpdateActive;
  UpdateScrollBar;
  FOriginalImeName := ImeName;
  FOriginalImeMode := ImeMode;
end;

procedure TbsSkinCustomDBGrid.DataChanged;
begin
  if not HandleAllocated then Exit;
  UpdateRowCount;
  UpdateScrollBar;
  UpdateActive;
  InvalidateEditor;
  ValidateRect(Handle, nil);
  Invalidate;
end;

procedure TbsSkinCustomDBGrid.DefaultHandler(var Msg);
var
  P: TPopupMenu;
  Cell: TGridCoord;
begin
  inherited DefaultHandler(Msg);
  if TMessage(Msg).Msg = wm_RButtonUp then
    with TWMRButtonUp(Msg) do
    begin
      Cell := MouseCoord(XPos, YPos);
      if (Cell.X < FIndicatorOffset) or (Cell.Y < 0) then Exit;
      P := Columns[RawToDataColumn(Cell.X)].PopupMenu;
      if (P <> nil) and P.AutoPopup then
      begin
        SendCancelMode(nil);
        P.PopupComponent := Self;
        with ClientToScreen(SmallPointToPoint(Pos)) do
          P.Popup(X, Y);
        Result := 1;
      end;
    end;
end;

procedure TbsSkinCustomDBGrid.DeferLayout;
var
  M: TMsg;
begin
  if HandleAllocated and
    not PeekMessage(M, Handle, cm_DeferLayout, cm_DeferLayout, pm_NoRemove) then
    PostMessage(Handle, cm_DeferLayout, 0, 0);
  CancelLayout;
end;

procedure TbsSkinCustomDBGrid.DefineFieldMap;
var
  I: Integer;
begin
  if FColumns.State = csCustomized then
  begin   { Build the column/field map from the column attributes }
    DataLink.SparseMap := True;
    for I := 0 to FColumns.Count-1 do
      FDataLink.AddMapping(FColumns[I].FieldName);
  end
  else   { Build the column/field map from the field list order }
  begin
    FDataLink.SparseMap := False;
    with Datalink.Dataset do
      for I := 0 to FieldList.Count - 1 do
        with FieldList[I] do if Visible then Datalink.AddMapping(FullName);
  end;
end;

function TbsSkinCustomDBGrid.UseRightToLeftAlignmentForField(const AField: TField;
  Alignment: TAlignment): Boolean;
begin
  Result := False;
  if IsRightToLeft then
    Result := OkToChangeFieldAlignment(AField, Alignment);
end;

procedure TbsSkinCustomDBGrid.DefaultDrawDataCell(const Rect: TRect; Field: TField;
  State: TGridDrawState);
var
  Alignment: TAlignment;
  Value: string;
begin
  Alignment := taLeftJustify;
  Value := '';
  if Assigned(Field) then
  begin
    Alignment := Field.Alignment;
    Value := Field.DisplayText;
  end;
  WriteText(Canvas, Rect, 2, 2, Value, Alignment,
    UseRightToLeftAlignmentForField(Field, Alignment));
end;

procedure TbsSkinCustomDBGrid.DefaultDrawColumnCell(const Rect: TRect;
  DataCol: Integer; Column: TbsColumn; State: TGridDrawState);
var
  Value: string;
begin
  Value := '';
  Value := Column.Field.DisplayText;
  WriteText(Canvas, Rect, 2, 2, Value, Column.Alignment,
  UseRightToLeftAlignmentForField(Column.Field, Column.Alignment));
end;

procedure TbsSkinCustomDBGrid.ReadColumns(Reader: TReader);
begin
  Columns.Clear;
  Reader.ReadValue;
  Reader.ReadCollection(Columns);
end;

procedure TbsSkinCustomDBGrid.WriteColumns(Writer: TWriter);
begin
  if Columns.State = csCustomized then
    Writer.WriteCollection(Columns)
  else  // ancestor state is customized, ours is not
    Writer.WriteCollection(nil);
end;

procedure TbsSkinCustomDBGrid.DefineProperties(Filer: TFiler);
var
  StoreIt: Boolean;
  vState: TbsDBGridColumnsState;
begin
  vState := Columns.State;
  if Filer.Ancestor = nil then
    StoreIt := vState = csCustomized
  else
    if vState <> TbsSkinCustomDBGrid(Filer.Ancestor).Columns.State then
      StoreIt := True
    else
      begin
      {$IFNDEF VER130}
        StoreIt := (vState = csCustomized) and
         (not CollectionsEqual(Columns, TbsSkinCustomDBGrid(Filer.Ancestor).Columns, Self, TbsSkinCustomDBGrid(Filer.Ancestor)));
      {$ELSE}
         StoreIt := (vState = csCustomized) and
         (not CollectionsEqual(Columns, TbsSkinCustomDBGrid(Filer.Ancestor).Columns));
      {$ENDIF}
      end;


  Filer.DefineProperty('Columns', ReadColumns, WriteColumns, StoreIt);
end;

function TbsSkinCustomDBGrid.ColumnAtDepth(Col: TbsColumn; ADepth: Integer): TbsColumn;
begin
  Result := Col;
  while (Result <> nil) and (Result.Depth > ADepth) do
    Result := Result.ParentColumn;
end;

function TbsSkinCustomDBGrid.CalcTitleRect(Col: TbsColumn; ARow: Integer;
  var MasterCol: TbsColumn): TRect;
var
  I,J: Integer;
  InBiDiMode: Boolean;
  DrawInfo: TbsGridDrawInfo;
begin
  MasterCol := ColumnAtDepth(Col, ARow);
  if MasterCol = nil then Exit;

  I := DataToRawColumn(MasterCol.Index);
  if I >= LeftCol then
    J := MasterCol.Depth
  else
  begin
    I := LeftCol;
    if Col.Depth > ARow then
      J := ARow
    else
      J := Col.Depth;
  end;

  Result := CellRect(I, J);

  InBiDiMode := UseRightToLeftAlignment and
                (Canvas.CanvasOrientation = coLeftToRight);

  for I := Col.Index to Columns.Count-1 do
  begin
    if ColumnAtDepth(Columns[I], ARow) <> MasterCol then Break;
    if not InBiDiMode then
    begin
      J := CellRect(DataToRawColumn(I), ARow).Right;
      if J = 0 then Break;
      Result.Right := Max(Result.Right, J);
    end
    else
    begin
      J := CellRect(DataToRawColumn(I), ARow).Left;
      if J >= ClientWidth then Break;
      Result.Left := J;
    end;
  end;
  J := Col.Depth;
  if (J <= ARow) and (J < FixedRows-1) then
  begin
    CalcFixedInfo(DrawInfo);
    Result.Bottom := DrawInfo.Vert.FixedBoundary - DrawInfo.Vert.EffectiveLineWidth;
  end;
end;

procedure TbsSkinCustomDBGrid.DrawSkinCheckImage(Cnvs: TCanvas; R: TRect; AChecked: Boolean);

procedure DrawCImage(X, Y: Integer; C: TCanvas; IR: TRect; DestCnvs: TCanvas);
var
  B: TBitMap;
begin
  B := TBitMap.Create;
  B.Width := RectWidth(IR);
  B.Height := RectHeight(IR);
  B.Canvas.CopyRect(Rect(0, 0, B.Width, B.Height), C, IR);
  B.Transparent := True;
  DestCnvs.Draw(X, Y, B);
  B.Free;
end;

var
  CIData: TbsDataSkinCheckRadioControl;
  CIIndex: Integer;
  X, Y: Integer;
  B: TBitMap;
  IR: TRect;
begin
  CIIndex := FSD.GetControlIndex('checkbox');
  if CIIndex = -1 then Exit;
  CIData := TbsDataSkinCheckRadioControl(FSD.CtrlList[CIIndex]);
  with CIData do
  begin
    if AChecked then IR := CheckImageRect else IR := UnCheckImageRect;
    X := R.Left + RectWidth(R) div 2 - RectWidth(IR) div 2;
    Y := R.Top + RectHeight(R) div 2 - RectHeight(IR) div 2;
    DrawCImage(X, Y,
    TBitMap(FSD.FActivePictures.Items[PictureIndex]).Canvas, 
    IR, Cnvs);
  end;
end;

procedure TbsSkinCustomDBGrid.DrawCell;
begin
  if FIndex <> -1
  then
    DrawSkinCell(ACol, ARow, ARect, AState)
  else
    DrawDefaultCell(ACol, ARow, ARect, AState);
end;

procedure TbsSkinCustomDBGrid.DrawSkinCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState);

  function RowIsMultiSelected: Boolean;
  var
    Index: Integer;
  begin
    Result := (dgMultiSelect in Options) and Datalink.Active and
      FBookmarks.Find(Datalink.Datasource.Dataset.Bookmark, Index);
  end;

  procedure DrawTitleCell(ACol, ARow: Integer; Column: TbsColumn; var AState: TGridDrawState);
  var
    B, Buffer: TBitMap;
    R, TextRct, TitleRect: TRect;
    MasterCol: TbsColumn;
    Hold: Integer;
    BGC: TColor;
  begin
    TitleRect := CalcTitleRect(Column, ARow, MasterCol);

    B := TBitMap.Create;
    if UseSkinCellHeight
    then
      CreateHSkinImage(FixedCellLeftOffset, FixedCellRightOffset,
          B, Picture, FixedCellRect, RectWidth(TitleRect), RectHeight(TitleRect), False)
    else
      begin
        Buffer := TBitMap.Create;
        CreateHSkinImage(FixedCellLeftOffset, FixedCellRightOffset,
          Buffer, Picture, FixedCellRect, RectWidth(TitleRect), RectHeight(FixedCellRect), False);
        B.Width := RectWidth(TitleRect);
        B.Height := RectHeight(TitleRect);
        B.Canvas.StretchDraw(Rect(0, 0, B.Width, B.Height), Buffer);
        Buffer.Free;
      end;

    if UseSkinFont
    then
      with B.Canvas do
      begin
        Font.Name := FixedFontName;
        Font.Height := FixedFontHeight;
        Font.Color := FixedFontColor;
        Font.Style := FixedFontStyle;
        Brush.Style := bsClear;
        if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
        then
          Font.CharSet := SkinData.ResourceStrData.CharSet
        else
          Font.Charset := Self.Font.Charset;
      end
    else
      with B.Canvas do
      begin
        Brush.Style := bsClear;
        Font.Assign(Self.TitleFont);
        Font.Color := FixedFontColor;
        if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
        then
          Font.CharSet := SkinData.ResourceStrData.CharSet
      end;

   TextRct := FixedCellTextRect;
   if not UseSkinCellHeight
   then
     begin
       Inc(TextRct.Bottom, RectHeight(TitleRect) - RectHeight(FixedCellRect));
     end;
   Inc(TextRct.Right, B.Width - RectWidth(FixedCellRect));

   BGC := 0;

   if Assigned(FOnGetCellParam) then FOnGetCellParam(Self, Column, AState, BGC, B.Canvas.Font);

   if MasterCol <> nil
   then
    with MasterCol.Title do
      WriteText(B.Canvas, TextRct, 0, 0,
        Caption, Alignment, IsRightToLeft);

    if not IsRighttoLeft
    then
      Canvas.Draw(TitleRect.Left, TitleRect.Top, B)
    else
      begin
        Hold := TitleRect.Left;
        TitleRect.Left := TitleRect.Right;
        TitleRect.Right := Hold;
        R := Rect(0, 0, B.Width, B.Height);
        Canvas.CopyRect(TitleRect, B.Canvas, R);
      end;

    B.Free;
    AState := AState - [gdFixed];
  end;

  procedure DrawIndicatorCell(Indicator: Integer);
  var
    B, Buffer: TBitMap;
    IX, IY: Integer;
    IRect: TRect;
  begin
    B := TBitMap.Create;
    if UseSkinCellHeight
    then
      CreateHSkinImage(FixedCellLeftOffset, FixedCellRightOffset,
          B, Picture, FixedCellRect, RectWidth(ARect), RectHeight(ARect), False)
    else
      begin
        Buffer := TBitMap.Create;
        CreateHSkinImage(FixedCellLeftOffset, FixedCellRightOffset,
          Buffer, Picture, FixedCellRect, RectWidth(ARect), RectHeight(FixedCellRect), False);
        B.Width := RectWidth(ARect);
        B.Height := RectHeight(ARect);
        B.Canvas.StretchDraw(Rect(0, 0, B.Width, B.Height), Buffer);
        Buffer.Free;
      end;
    IRect := FixedCellTextRect;
    Inc(IRect.Right, B.Width - RectWidth(FixedCellRect));
    if not UseSkinCellHeight
    then
     begin
       Inc(IRect.Bottom, RectHeight(ARect) - RectHeight(FixedCellRect));
     end;
    IX := IRect.Left + RectWidth(IRect) div 2 - FIndicators.Width div 2;
    IY := IRect.Top + RectHeight(IRect) div 2 - FIndicators.Height div 2;
    FIndicators.Draw(B.Canvas, IX, IY, Indicator, True);
    Canvas.Draw(ARect.Left, ARect.Top, B);
    B.Free;
  end;

  procedure DrawFixedCell;
  var
    B, Buffer: TBitMap;
  begin
    B := TBitMap.Create;
    if UseSkinCellHeight
    then
      CreateHSkinImage(FixedCellLeftOffset, FixedCellRightOffset,
        B, Picture, FixedCellRect, RectWidth(ARect), RectHeight(ARect), False)
    else
     begin
        Buffer := TBitMap.Create;
        CreateHSkinImage(FixedCellLeftOffset, FixedCellRightOffset,
        Buffer, Picture, FixedCellRect, RectWidth(ARect), RectHeight(FixedCellRect), False);
        B.Width := RectWidth(ARect);
        B.Height := RectHeight(ARect);
        B.Canvas.StretchDraw(Rect(0, 0, B.Width, B.Height), Buffer);
        Buffer.Free;
      end;
    Canvas.Draw(ARect.Left, ARect.Top, B);
    B.Free;
  end;

  procedure DrawSelectedCell(AText: String; ADrawColumn: TbsColumn);
  var
    B, Buffer: TBitMap;
    R, TextRct: TRect;
    Hold: Integer;
    BGC: TColor;
  begin
    B := TBitMap.Create;
    if UseSkinCellHeight
    then
      CreateHSkinImage(CellLeftOffset, CellRightOffset,
           B, Picture, SelectCellRect, RectWidth(ARect), RectHeight(ARect), False)
    else
      begin
        Buffer := TBitMap.Create;
        CreateHSkinImage(CellLeftOffset, CellRightOffset,
           Buffer, Picture, SelectCellRect, RectWidth(ARect), RectHeight(SelectCellRect), False);
        B.Width := RectWidth(ARect);
        B.Height := RectHeight(ARect);
        B.Canvas.StretchDraw(Rect(0, 0, B.Width, B.Height), Buffer);
        Buffer.Free;
      end;
    if UseSkinFont
    then
      with B.Canvas do
      begin
        Font.Name := FontName;
        Font.Height := FontHeight;
        Font.Color := SelectFontColor;
        Font.Style := FontStyle;
        if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
        then
          Font.CharSet := SkinData.ResourceStrData.CharSet
        else
          Font.Charset := Self.Font.Charset;
        Brush.Style := bsClear;
      end
    else
      with B.Canvas do
      begin
        if FUseColumnsFont
        then
          Font.Assign(ADrawColumn.Font)
        else
          Font.Assign(Self.Font);
        Font.Color := SelectFontColor;
        Brush.Style := bsClear;
        if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
        then
          Font.CharSet := SkinData.ResourceStrData.CharSet;
      end;
    TextRct := CellTextRect;
    Inc(TextRct.Right, B.Width - RectWidth(SelectCellRect));
    if not UseSkinCellHeight
    then
      begin
        Inc(TextRct.Bottom, RectHeight(ARect) - RectHeight(SelectCellRect));
      end;
     BGC := 0;
     if Assigned(FOnGetCellParam) then FOnGetCellParam(Self, ADrawColumn, AState, BGC, B.Canvas.Font);

     if Assigned(ADrawColumn.FField) and (ADrawColumn.FField.DataType = ftBoolean)
     then
       DrawSkinCheckImage(B.Canvas, TextRct, aDrawColumn.FField.AsBoolean)
     else
       WriteText(B.Canvas, TextRct, 0, 0, AText, ADrawColumn.Alignment,
                 UseRightToLeftAlignmentForField(ADrawColumn.Field, ADrawColumn.Alignment));

    if not IsRighttoLeft
    then
      Canvas.Draw(ARect.Left, ARect.Top, B)
    else
      begin
        Hold := ARect.Left;
        ARect.Left := ARect.Right;
        ARect.Right := Hold;
        R := Rect(0, 0, B.Width, B.Height);
        Canvas.CopyRect(ARect, B.Canvas, R);
      end;
    B.Free;
  end;

  procedure DrawFocusedCell(AText: String; ADrawColumn: TbsColumn);
  var
    B, Buffer: TBitMap;
    R, TextRct: TRect;
    Hold: Integer;
    BGC: TColor;
  begin
    B := TBitMap.Create;
    if UseSkinCellHeight
    then
      CreateHSkinImage(CellLeftOffset, CellRightOffset,
         B, Picture, FocusCellRect, RectWidth(ARect), RectHeight(ARect), False)
    else
      begin
        Buffer := TBitMap.Create;
        CreateHSkinImage(CellLeftOffset, CellRightOffset,
         Buffer, Picture, FocusCellRect, RectWidth(ARect), RectHeight(FocusCellRect), False);
        B.Width := RectWidth(ARect);
        B.Height := RectHeight(ARect);
        B.Canvas.StretchDraw(Rect(0, 0, B.Width, B.Height), Buffer);
        Buffer.Free;
      end;
    if UseSkinFont
    then
      with B.Canvas do
      begin
        Font.Name := FontName;
        Font.Height := FontHeight;
        Font.Color := FocusFontColor;
        Font.Style := FontStyle;
        if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
        then
          Font.CharSet := SkinData.ResourceStrData.CharSet
        else
          Font.Charset := Self.Font.Charset;
        Brush.Style := bsClear;
      end
    else
      with B.Canvas do
      begin
        if FUseColumnsFont
        then
          Font.Assign(ADrawColumn.Font)
        else
          Font.Assign(Self.Font);
        Font.Color := FocusFontColor;
        Brush.Style := bsClear;
        if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
        then
          Font.CharSet := SkinData.ResourceStrData.CharSet;
      end;
    TextRct := CellTextRect;
    Inc(TextRct.Right, B.Width - RectWidth(SelectCellRect));
    if not UseSkinCellHeight
    then
      begin
        Inc(TextRct.Bottom, RectHeight(ARect) - RectHeight(SelectCellRect));
      end;
     BGC := 0;
     if Assigned(FOnGetCellParam) then FOnGetCellParam(Self, ADrawColumn, AState, BGC, B.Canvas.Font);
    if Assigned(ADrawColumn.FField)
    then
      if ADrawColumn.FField.DataType = ftBoolean
      then
        DrawSkinCheckImage(B.Canvas, TextRct, ADrawColumn.FField.AsBoolean)
      else
        WriteText(B.Canvas, TextRct, 0, 0, AText, ADrawColumn.Alignment,
                  UseRightToLeftAlignmentForField(ADrawColumn.Field, ADrawColumn.Alignment));
    if not IsRighttoLeft
    then
      Canvas.Draw(ARect.Left, ARect.Top, B)
    else
      begin
        Hold := ARect.Left;
        ARect.Left := ARect.Right;
        ARect.Right := Hold;
        R := Rect(0, 0, B.Width, B.Height);
        Canvas.CopyRect(ARect, B.Canvas, R);
      end;
    B.Free;
  end;

var
  OldActive: Integer;
  Indicator: Integer;
  Value: string;
  DrawColumn: TbsColumn;
  MultiSelected: Boolean;
  Buffer: TBitMap;
  R: TRect;
  BGC: TColor;
begin
  Indicator := -1;
  Dec(ARow, FTitleOffset);
  Dec(ACol, FIndicatorOffset);
  if (gdFixed in AState) and (ACol < 0) then
  begin
    if Assigned(DataLink) and DataLink.Active  then
    begin
      MultiSelected := False;
      if ARow >= 0 then
      begin
        OldActive := FDataLink.ActiveRecord;
        try
          FDatalink.ActiveRecord := ARow;
          MultiSelected := RowIsMultiselected;
        finally
          FDatalink.ActiveRecord := OldActive;
        end;
      end;
      if (ARow = FDataLink.ActiveRecord) or MultiSelected then
      begin
        Indicator := 0;
        if FDataLink.DataSet <> nil then
          case FDataLink.DataSet.State of
            dsEdit: Indicator := 1;
            dsInsert: Indicator := 2;
            dsBrowse:
              if MultiSelected then
                if (ARow <> FDatalink.ActiveRecord) then
                  Indicator := 3
                else
                  Indicator := 4;  // multiselected and current row
          end;
        DrawIndicatorCell(Indicator);
        if ARow = FDatalink.ActiveRecord then
          FSelRow := ARow + FTitleOffset;
      end;
    end;
  end
  else with Canvas do
  begin
    DrawColumn := Columns[ACol];
    if not DrawColumn.Showing then Exit;
    if not (gdFixed in AState) then
    begin
      if UseSkinFont
      then
        begin
          Font.Name := FontName;
          Font.Height := FontHeight;
          Font.Color := FontColor;
          Font.Style := FontStyle;
          Brush.Color := BGColor;
          if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
          then
            Font.CharSet := SkinData.ResourceStrData.CharSet
          else
            Font.Charset := Self.Font.Charset;
        end
      else
        begin
          if FUseColumnsFont
          then
            Font.Assign(DrawColumn.Font)
          else
            Font.Assign(Self.Font);
          Font.Color := FontColor;
          if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
          then
            Font.CharSet := SkinData.ResourceStrData.CharSet;
          Brush.Color := BGColor;
        end;
    end;

    if ARow < 0
    then
      begin
        BGC := Self.BGColor;
        if Assigned(FOnGetCellParam) then FOnGetCellParam(Self, DrawColumn, AState, BGC, Canvas.Font);
        if BGC <> Canvas.Brush.Color then Canvas.Brush.Color := BGC;
        DrawTitleCell(ACol, ARow + FTitleOffset, DrawColumn, AState)
      end
    else if (FDataLink = nil) or not FDataLink.Active then
      FillRect(ARect)
    else
    begin
      Value := '';
      OldActive := FDataLink.ActiveRecord;
      try
        FDataLink.ActiveRecord := ARow;
        if Assigned(DrawColumn.Field) then
          Value := DrawColumn.Field.DisplayText;

        BGC := Self.BGColor;
        if Assigned(FOnGetCellParam) then FOnGetCellParam(Self, DrawColumn, AState, BGC, Canvas.Font);
        if BGC <> Canvas.Brush.Color then Canvas.Brush.Color := BGC;

        if FDefaultDrawing then
        if Focused and ((gdFocused in AState) or
           ((gdSelected in AState) and (dgRowSelect in Options)))
        then
          DrawFocusedCell(Value, DrawColumn)
        else
        if (gdSelected in AState) or HighlightCell(ACol, ARow, Value, AState)
        then
          DrawSelectedCell(Value, DrawColumn)
        else
          if Assigned(DrawColumn.FField)and
             (DrawColumn.FField.DataType = ftBoolean)
          then
            begin
              Buffer := TBitMap.Create;
              Buffer.Width := RectWidth(ARect);
              Buffer.Height := RectHeight(ARect);
              R := Rect(0, 0, Buffer.Width, Buffer.Height);
              Buffer.Canvas.Brush.Color := Canvas.Brush.Color;
              Buffer.Canvas.FillRect(R);
              DrawSkinCheckImage(Buffer.Canvas, R, DrawColumn.FField.AsBoolean);
              Canvas.Draw(ARect.Left, ARect.Top, Buffer);
              Buffer.Free;
            end
          else
            WriteText(Canvas, ARect, 2, 2, Value, DrawColumn.Alignment,
            UseRightToLeftAlignmentForField(DrawColumn.Field, DrawColumn.Alignment));

        if (Columns.State = csDefault) then
          DrawDataCell(ARect, DrawColumn.Field, AState);
        DrawColumnCell(ARect, ACol, DrawColumn, AState);
      finally
        FDataLink.ActiveRecord := OldActive;
      end;
    end;
  end;
  if (gdFixed in AState) and ([dgRowLines, dgColLines] * Options =
    [dgRowLines, dgColLines]) and (Indicator = -1)
  then
    DrawFixedCell;
end;

procedure TbsSkinCustomDBGrid.DrawDefaultCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState);
var
  FrameOffs: Byte;

  function RowIsMultiSelected: Boolean;
  var
    Index: Integer;
  begin
    Result := (dgMultiSelect in Options) and Datalink.Active and
      FBookmarks.Find(Datalink.Datasource.Dataset.Bookmark, Index);
  end;

  procedure DrawTitleCell(ACol, ARow: Integer; Column: TbsColumn; var AState: TGridDrawState);
  const
    ScrollArrows: array [Boolean, Boolean] of Integer =
      ((DFCS_SCROLLRIGHT, DFCS_SCROLLLEFT), (DFCS_SCROLLLEFT, DFCS_SCROLLRIGHT));
  var
    MasterCol: TbsColumn;
    TitleRect, TextRect, ButtonRect: TRect;
    I: Integer;
    InBiDiMode: Boolean;
  begin
    TitleRect := CalcTitleRect(Column, ARow, MasterCol);

    if MasterCol = nil then
    begin
      Canvas.FillRect(ARect);
      Exit;
    end;

    Canvas.Font := MasterCol.Title.Font;
    Canvas.Brush.Color := MasterCol.Title.Color;
    if [dgRowLines, dgColLines] * Options = [dgRowLines, dgColLines] then
      InflateRect(TitleRect, -1, -1);
    TextRect := TitleRect;
    I := GetSystemMetrics(SM_CXHSCROLL);
    if ((TextRect.Right - TextRect.Left) > I) and MasterCol.Expandable then
    begin
      Dec(TextRect.Right, I);
      ButtonRect := TitleRect;
      ButtonRect.Left := TextRect.Right;
      I := SaveDC(Canvas.Handle);
      try
        Canvas.FillRect(ButtonRect);
        InflateRect(ButtonRect, -1, -1);
        IntersectClipRect(Canvas.Handle, ButtonRect.Left,
          ButtonRect.Top, ButtonRect.Right, ButtonRect.Bottom);
        InflateRect(ButtonRect, 1, 1);
        { DrawFrameControl doesn't draw properly when orienatation has changed.
          It draws as ExtTextOut does. }
        InBiDiMode := Canvas.CanvasOrientation = coRightToLeft;
        if InBiDiMode then { stretch the arrows box }
          Inc(ButtonRect.Right, GetSystemMetrics(SM_CXHSCROLL) + 4);
        DrawFrameControl(Canvas.Handle, ButtonRect, DFC_SCROLL,
          ScrollArrows[InBiDiMode, MasterCol.Expanded] or DFCS_FLAT);
      finally
        RestoreDC(Canvas.Handle, I);
      end;
    end;
    with MasterCol.Title do
      WriteText(Canvas, TextRect, FrameOffs, FrameOffs, Caption, Alignment,
        IsRightToLeft);
    if [dgRowLines, dgColLines] * Options = [dgRowLines, dgColLines] then
    begin
      InflateRect(TitleRect, 1, 1);
      DrawEdge(Canvas.Handle, TitleRect, BDR_RAISEDINNER, BF_BOTTOMRIGHT);
      DrawEdge(Canvas.Handle, TitleRect, BDR_RAISEDINNER, BF_TOPLEFT);
    end;
    AState := AState - [gdFixed];  // prevent box drawing later
  end;

var
  OldActive: Integer;
  Indicator: Integer;
  Highlight: Boolean;
  Value: string;
  DrawColumn: TbsColumn;
  MultiSelected: Boolean;
  ALeft: Integer;
  X, Y: Integer;
  BGC: TColor;
begin
  if csLoading in ComponentState then
  begin
    Canvas.Brush.Color := Color;
    Canvas.FillRect(ARect);
    Exit;
  end;

  Dec(ARow, FTitleOffset);
  Dec(ACol, FIndicatorOffset);

  if (gdFixed in AState) and ([dgRowLines, dgColLines] * Options =
    [dgRowLines, dgColLines]) then
  begin
    InflateRect(ARect, -1, -1);
    FrameOffs := 1;
  end
  else
    FrameOffs := 2;

  if (gdFixed in AState) and (ACol < 0) then
  begin
    Canvas.Brush.Color := FixedColor;
    Canvas.FillRect(ARect);
    if Assigned(DataLink) and DataLink.Active  then
    begin
      MultiSelected := False;
      if ARow >= 0 then
      begin
        OldActive := FDataLink.ActiveRecord;
        try
          FDatalink.ActiveRecord := ARow;
          MultiSelected := RowIsMultiselected;
        finally
          FDatalink.ActiveRecord := OldActive;
        end;
      end;
      if (ARow = FDataLink.ActiveRecord) or MultiSelected then
      begin
        Indicator := 0;
        if FDataLink.DataSet <> nil then
          case FDataLink.DataSet.State of
            dsEdit: Indicator := 1;
            dsInsert: Indicator := 2;
            dsBrowse:
              if MultiSelected then
                if (ARow <> FDatalink.ActiveRecord) then
                  Indicator := 3
                else
                  Indicator := 4;  // multiselected and current row
          end;
        ALeft := ARect.Right - FIndicators.Width - FrameOffs;
        if Canvas.CanvasOrientation = coRightToLeft then Inc(ALeft);
        FIndicators.Draw(Canvas, ALeft,
          (ARect.Top + ARect.Bottom - FIndicators.Height) shr 1, Indicator, True);
        if ARow = FDatalink.ActiveRecord then
          FSelRow := ARow + FTitleOffset;
      end;
    end;
  end
  else with Canvas do
  begin
    DrawColumn := Columns[ACol];
    if not DrawColumn.Showing then Exit;
    if not (gdFixed in AState) then
    begin
      Font := DrawColumn.Font;
      Brush.Color := DrawColumn.Color
    end;
    if ARow < 0 then
      DrawTitleCell(ACol, ARow + FTitleOffset, DrawColumn, AState)
    else if (FDataLink = nil) or not FDataLink.Active then
      FillRect(ARect)
    else
    begin
      Value := '';
      OldActive := FDataLink.ActiveRecord;
      try
        FDataLink.ActiveRecord := ARow;
        if Assigned(DrawColumn.Field) then
          Value := DrawColumn.Field.DisplayText;
        Highlight := HighlightCell(ACol, ARow, Value, AState);
        if Highlight then
        begin
          Brush.Color := clHighlight;
          Font.Color := clHighlightText;
        end;
        if not Enabled then
          Font.Color := clGrayText;
        //
        BGC := Canvas.Brush.Color;
        if Assigned(FOnGetCellParam) then FOnGetCellParam(Self, DrawColumn, AState, BGC, Canvas.Font);
        if BGC <> Canvas.Brush.Color then Canvas.Brush.Color := BGC;
        // draw cell
        if FDefaultDrawing
        then
          if Assigned(DrawColumn.Field) and
             (DrawColumn.FField.DataType = ftBoolean)
          then
            begin
              Canvas.FillRect(ARect);
              X := ARect.Left + RectWidth(ARect) div 2 - 4;
              Y := ARect.Top + RectHeight(ARect) div 2 - 4;
              if DrawColumn.FField.AsBoolean
              then
                DrawCheckImage(Canvas, X, Y, Canvas.Font.Color);
            end
          else
            WriteText(Canvas, ARect, 2, 2, Value, DrawColumn.Alignment,
             UseRightToLeftAlignmentForField(DrawColumn.Field, DrawColumn.Alignment));

        if Columns.State = csDefault then
          DrawDataCell(ARect, DrawColumn.Field, AState);
        DrawColumnCell(ARect, ACol, DrawColumn, AState);
      finally
        FDataLink.ActiveRecord := OldActive;
      end;
      if FDefaultDrawing and (gdSelected in AState)
        and ((dgAlwaysShowSelection in Options) or Focused)
        and not (csDesigning in ComponentState)
        and not (dgRowSelect in Options)
        and (UpdateLock = 0)
        and (ValidParentForm(Self).ActiveControl = Self) then
        Windows.DrawFocusRect(Handle, ARect);
    end;
  end;
  if (gdFixed in AState) and ([dgRowLines, dgColLines] * Options =
    [dgRowLines, dgColLines]) then
  begin
    InflateRect(ARect, 1, 1);
    DrawEdge(Canvas.Handle, ARect, BDR_RAISEDINNER, BF_BOTTOMRIGHT);
    DrawEdge(Canvas.Handle, ARect, BDR_RAISEDINNER, BF_TOPLEFT);
  end;
end;

procedure TbsSkinCustomDBGrid.DrawDataCell(const Rect: TRect; Field: TField;
  State: TGridDrawState);
begin
  if Assigned(FOnDrawDataCell) then FOnDrawDataCell(Self, Rect, Field, State);
end;

procedure TbsSkinCustomDBGrid.DrawColumnCell(const Rect: TRect; DataCol: Integer;
  Column: TbsColumn; State: TGridDrawState);
begin
  if Assigned(OnDrawColumnCell) then
    OnDrawColumnCell(Self, Rect, DataCol, Column, State);
end;

procedure TbsSkinCustomDBGrid.EditButtonClick;
begin
  if Assigned(FOnEditButtonClick) then
    FOnEditButtonClick(Self)
  else
    ShowPopupEditor(Columns[SelectedIndex]);
end;

procedure TbsSkinCustomDBGrid.EditingChanged;
begin
  if dgIndicator in Options then InvalidateCell(0, FSelRow);
end;

procedure TbsSkinCustomDBGrid.EndLayout;
begin
  if FLayoutLock > 0 then
  begin
    try
      try
        if FLayoutLock = 1 then
          InternalLayout;
      finally
        if FLayoutLock = 1 then
          FColumns.EndUpdate;
      end;
    finally
      Dec(FLayoutLock);
      EndUpdate;
    end;
  end;
end;

procedure TbsSkinCustomDBGrid.EndUpdate;
begin
  if FUpdateLock > 0 then
    Dec(FUpdateLock);
end;

function TbsSkinCustomDBGrid.GetColField(DataCol: Integer): TField;
begin
  Result := nil;
  if (DataCol >= 0) and FDatalink.Active and (DataCol < Columns.Count) then
    Result := Columns[DataCol].Field;
end;

function TbsSkinCustomDBGrid.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

function TbsSkinCustomDBGrid.GetEditLimit: Integer;
begin
  Result := 0;
  if Assigned(SelectedField) and (SelectedField.DataType in [ftString, ftWideString]) then
    Result := SelectedField.Size;
end;

function TbsSkinCustomDBGrid.GetEditMask(ACol, ARow: Longint): string;
begin
  Result := '';
  if FDatalink.Active then
  with Columns[RawToDataColumn(ACol)] do
    if Assigned(Field) then
      Result := Field.EditMask;
end;

function TbsSkinCustomDBGrid.GetEditText(ACol, ARow: Longint): string;
begin
  Result := '';
  if FDatalink.Active then
  with Columns[RawToDataColumn(ACol)] do
    if Assigned(Field) then
      Result := Field.Text;
  FEditText := Result;
end;

function TbsSkinCustomDBGrid.GetFieldCount: Integer;
begin
  Result := FDatalink.FieldCount;
end;

function TbsSkinCustomDBGrid.GetFields(FieldIndex: Integer): TField;
begin
  Result := FDatalink.Fields[FieldIndex];
end;

function TbsSkinCustomDBGrid.GetFieldValue(ACol: Integer): string;
var
  Field: TField;
begin
  Result := '';
  Field := GetColField(ACol);
  if Field <> nil then Result := Field.DisplayText;
end;

function TbsSkinCustomDBGrid.GetSelectedField: TField;
var
  Index: Integer;
begin
  Index := SelectedIndex;
  if Index <> -1 then
    Result := Columns[Index].Field
  else
    Result := nil;
end;

function TbsSkinCustomDBGrid.GetSelectedIndex: Integer;
begin
  Result := RawToDataColumn(Col);
end;

function TbsSkinCustomDBGrid.HighlightCell(DataCol, DataRow: Integer;
  const Value: string; AState: TGridDrawState): Boolean;
var
  Index: Integer;
begin
  Result := False;
  if (dgMultiSelect in Options) and Datalink.Active then
    Result := FBookmarks.Find(Datalink.Datasource.Dataset.Bookmark, Index);
  if not Result then
    Result := (gdSelected in AState)
      and ((dgAlwaysShowSelection in Options) or Focused)
        { updatelock eliminates flicker when tabbing between rows }
      and ((UpdateLock = 0) or (dgRowSelect in Options));
end;

procedure TbsSkinCustomDBGrid.KeyDown(var Key: Word; Shift: TShiftState);
var
  KeyDownEvent: TKeyEvent;

  procedure ClearSelection;
  begin
    if (dgMultiSelect in Options) then
    begin
      FBookmarks.Clear;
      FSelecting := False;
    end;
  end;

  procedure DoSelection(Select: Boolean; Direction: Integer);
  var
    AddAfter: Boolean;
  begin
    AddAfter := False;
    BeginUpdate;
    try
      if (dgMultiSelect in Options) and FDatalink.Active then
        if Select and (ssShift in Shift) then
        begin
          if not FSelecting then
          begin
            FSelectionAnchor := FBookmarks.CurrentRow;
            FBookmarks.CurrentRowSelected := True;
            FSelecting := True;
            AddAfter := True;
          end
          else
          with FBookmarks do
          begin
            AddAfter := Compare(CurrentRow, FSelectionAnchor) <> -Direction;
            if not AddAfter then
              CurrentRowSelected := False;
          end
        end
        else
          ClearSelection;
      FDatalink.MoveBy(Direction);
      if AddAfter then FBookmarks.CurrentRowSelected := True;
    finally
      EndUpdate;
    end;
  end;

  procedure NextRow(Select: Boolean);
  begin
    with FDatalink.Dataset do
    begin
      if (State = dsInsert) and not Modified and not FDatalink.FModified then
        if FDataLink.EOF then Exit else Cancel
      else
        DoSelection(Select, 1);
      if FDataLink.EOF and CanModify and (not ReadOnly) and (dgEditing in Options) then
        Append;
    end;
  end;

  procedure PriorRow(Select: Boolean);
  begin
    with FDatalink.Dataset do
      if (State = dsInsert) and not Modified and FDataLink.EOF and
        not FDatalink.FModified then
        Cancel
      else
        DoSelection(Select, -1);
  end;

  procedure Tab(GoForward: Boolean);
  var
    ACol, Original: Integer;
  begin
    ACol := Col;
    Original := ACol;
    BeginUpdate;    { Prevent highlight flicker on tab to next/prior row }
    try
      while True do
      begin
        if GoForward then
          Inc(ACol) else
          Dec(ACol);
        if ACol >= ColCount then
        begin
          NextRow(False);
          ACol := FIndicatorOffset;
        end
        else if ACol < FIndicatorOffset then
        begin
          PriorRow(False);
          ACol := ColCount - FIndicatorOffset;
        end;
        if ACol = Original then Exit;
        if TabStops[ACol] then
        begin
          MoveCol(ACol, 0);
          Exit;
        end;
      end;
    finally
      EndUpdate;
    end;
  end;

  function DeletePrompt: Boolean;
  var
    Msg: string;
  begin
    if (FBookmarks.Count > 1) then
    begin
      if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
      then
        Msg := SkinData.ResourceStrData.GetResStr('DB_MULTIPLEDELETE_QUESTION')
      else
        Msg := BS_DB_MULTIPLEDELETE_QUESTION
    end
    else
    begin
      if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
      then
        Msg := SkinData.ResourceStrData.GetResStr('DB_DELETE_QUESTION')
      else
        Msg := BS_DB_DELETE_QUESTION;
    end;
    if FSkinMessage <> nil
    then
      Result := not (dgConfirmDelete in Options) or
      (FSkinMessage.MessageDlg(Msg, mtConfirmation, mbOKCancel, 0) <> idCancel)
    else
      Result := not (dgConfirmDelete in Options) or
      (MessageDlg(Msg, mtConfirmation, mbOKCancel, 0) <> idCancel);
  end;

const
  RowMovementKeys = [VK_UP, VK_PRIOR, VK_DOWN, VK_NEXT, VK_HOME, VK_END];

begin
  KeyDownEvent := OnKeyDown;
  if Assigned(KeyDownEvent) then KeyDownEvent(Self, Key, Shift);
  if not FDatalink.Active or not CanGridAcceptKey(Key, Shift) then Exit;
  if UseRightToLeftAlignment then
    if Key = VK_LEFT then
      Key := VK_RIGHT
    else if Key = VK_RIGHT then
      Key := VK_LEFT;
  with FDatalink.DataSet do
    if ssCtrl in Shift then
    begin
      if (Key in RowMovementKeys) then ClearSelection;
      case Key of
        VK_UP, VK_PRIOR: FDataLink.MoveBy(-FDatalink.ActiveRecord);
        VK_DOWN, VK_NEXT: FDataLink.MoveBy(FDatalink.BufferCount - FDatalink.ActiveRecord - 1);
        VK_LEFT: MoveCol(FIndicatorOffset, 1);
        VK_RIGHT: MoveCol(ColCount - 1, -1);
        VK_HOME: First;
        VK_END: Last;
        VK_DELETE:
          if (not ReadOnly) and not IsEmpty
            and CanModify and DeletePrompt then
          if FBookmarks.Count > 0 then
            FBookmarks.Delete
          else
            Delete;
      end
    end
    else
      case Key of
        VK_UP: PriorRow(True);
        VK_DOWN: NextRow(True);
        VK_LEFT:
          if dgRowSelect in Options then
            PriorRow(False) else
            MoveCol(Col - 1, -1);
        VK_RIGHT:
          if dgRowSelect in Options then
            NextRow(False) else
            MoveCol(Col + 1, 1);
        VK_HOME:
          if (ColCount = FIndicatorOffset+1)
            or (dgRowSelect in Options) then
          begin
            ClearSelection;
            First;
          end
          else
            MoveCol(FIndicatorOffset, 1);
        VK_END:
          if (ColCount = FIndicatorOffset+1)
            or (dgRowSelect in Options) then
          begin
            ClearSelection;
            Last;
          end
          else
            MoveCol(ColCount - 1, -1);
        VK_NEXT:
          begin
            ClearSelection;
            FDataLink.MoveBy(VisibleRowCount);
          end;
        VK_PRIOR:
          begin
            ClearSelection;
            FDataLink.MoveBy(-VisibleRowCount);
          end;
        VK_INSERT:
          if CanModify and (not ReadOnly) and (dgEditing in Options) then
          begin
            ClearSelection;
            Insert;
          end;
        VK_TAB: if not (ssAlt in Shift) then Tab(not (ssShift in Shift));
        VK_ESCAPE:
          begin
            if SysLocale.PriLangID = LANG_KOREAN then
              FIsESCKey := True;
            FDatalink.Reset;
            ClearSelection;
            if not (dgAlwaysShowEditor in Options) then HideEditor;
          end;
        VK_F2: EditorMode := True;
      end;
end;

procedure TbsSkinCustomDBGrid.WMChar;
var
  CellIndex: Integer;
begin
  if dgIndicator in Options
  then
    CellIndex := Col - 1
  else
    CellIndex := Col;
  if (CellIndex >= 0) and (Columns.Count > 0) and (Columns[CellIndex].Field <> nil)
     and (Columns[CellIndex].Field.DataType = ftBoolean)
  then
    begin
      if (Msg.CharCode = VK_RETURN) or (Msg.CharCode = VK_SPACE)
      then
        if not ReadOnly
        then
          begin
            FDatalink.Edit;
            FDatalink.Modified;
            if Columns[CellIndex ].Field.AsBoolean = True
            then
              Columns[CellIndex ].Field.AsBoolean := False
            else
             Columns[CellIndex ].Field.AsBoolean := True;
          end;
    end
  else
    inherited;
end;

procedure TbsSkinCustomDBGrid.KeyPress(var Key: Char);
begin
  FIsESCKey := False;
  if not (dgAlwaysShowEditor in Options) and (Key = #13) then
    FDatalink.UpdateData;
  inherited KeyPress(Key);
end;

procedure TbsSkinCustomDBGrid.InternalLayout;

  function FieldIsMapped(F: TField): Boolean;
  var
    X: Integer;
  begin
    Result := False;
    if F = nil then Exit;
    for X := 0 to FDatalink.FieldCount-1 do
      if FDatalink.Fields[X] = F then
      begin
        Result := True;
        Exit;
      end;
  end;

  procedure CheckForPassthroughs;  // check for Columns.State flip-flop
  var
    SeenPassthrough: Boolean;
    I, J: Integer;
    Column: TbsColumn;
  begin
    SeenPassthrough := False;
    for I := 0 to FColumns.Count-1 do
      if not FColumns[I].IsStored then
        SeenPassthrough := True
      else if SeenPassthrough then
      begin  // we have both persistent and non-persistent columns.  Kill the latter
        for J := FColumns.Count-1 downto 0 do
        begin
          Column := FColumns[J];
          if not Column.IsStored then
            Column.Free;
        end;
        Exit;
      end;
  end;

  procedure ReseTbsColumnFieldBindings;
  var
    I, J, K: Integer;
    Fld: TField;
    Column: TbsColumn;
  begin
    if FColumns.State = csDefault then
    begin
       { Destroy columns whose fields have been destroyed or are no longer
         in field map }
      if (not FDataLink.Active) and (FDatalink.DefaultFields) then
        FColumns.Clear
      else
        for J := FColumns.Count-1 downto 0 do
          with FColumns[J] do
          if not Assigned(Field)
            or not FieldIsMapped(Field) then Free;
      I := FDataLink.FieldCount;
      if (I = 0) and (FColumns.Count = 0) then Inc(I);
      for J := 0 to I-1 do
      begin
        Fld := FDatalink.Fields[J];
        if Assigned(Fld) then
        begin
          K := J;
          while (K < FColumns.Count) and (FColumns[K].Field <> Fld) do
            Inc(K);
          if K < FColumns.Count then
            Column := FColumns[K]
          else
          begin
            Column := FColumns.InternalAdd;
            Column.Field := Fld;
          end;
        end
        else
          Column := FColumns.InternalAdd;
        Column.Index := J;
      end;
    end
    else
    begin
      { Force columns to reaquire fields (in case dataset has changed) }
      for I := 0 to FColumns.Count-1 do
        FColumns[I].Field := nil;
    end;
  end;

  procedure MeasureTitleHeights;
  var
    I, J, K, D, B: Integer;
    RestoreCanvas: Boolean;
    Heights: array of Integer;
  begin
    RestoreCanvas := not HandleAllocated;
    if RestoreCanvas then
      Canvas.Handle := GetDC(0);
    try
      Canvas.Font := Font;
      // row heights
      if UseSkinCellHeight
      then
       if FIndex = -1
        then
          begin
            K := Canvas.TextHeight('Wg') + 3;
            if dgRowLines in Options then
            Inc(K, GridLineWidth);
            DefaultRowHeight := K;
          end
        else
          DefaultRowHeight := SelectCellRect.Bottom - SelectCellRect.Top;

      B := GetSystemMetrics(SM_CYHSCROLL);
      if dgTitles in Options then
      begin
        SetLength(Heights, FTitleOffset+1);
        for I := 0 to FColumns.Count-1 do
        begin
          Canvas.Font := FColumns[I].Title.Font;
          D := FColumns[I].Depth;
          if D <= High(Heights) then
          begin
            // title height
            if (FIndex = -1) or not UseSkinFont
            then
              begin
                J := Canvas.TextHeight('Wg') + 4;
                if FColumns[I].Expandable and (B > J) then
                J := B;
              end
            else
              J := FixedCellRect.Bottom - FixedCellRect.Top;
            Heights[D] := Max(J, Heights[D]);
          end;
        end;
        if Heights[0] = 0 then
        begin
          Canvas.Font := FTitleFont;
          if (FIndex = -1) or not UseSkinFont
          then
            Heights[0] := Canvas.TextHeight('Wg') + 4
          else
            Heights[0] := FixedCellRect.Bottom - FixedCellRect.Top;
        end;
        for I := 0 to High(Heights)-1 do
          RowHeights[I] := Heights[I];
      end;
    finally
      if RestoreCanvas then
      begin
        ReleaseDC(0,Canvas.Handle);
        Canvas.Handle := 0;
      end;
    end;
  end;

var
  I, J: Integer;
begin
  if (csLoading in ComponentState) then Exit;

  if HandleAllocated then KillMessage(Handle, cm_DeferLayout);

  CheckForPassthroughs;
  FIndicatorOffset := 0;
  if dgIndicator in Options then
    Inc(FIndicatorOffset);
  FDatalink.ClearMapping;
  if FDatalink.Active then DefineFieldMap;
  DoubleBuffered := (FDatalink.Dataset <> nil) and FDatalink.Dataset.ObjectView;
  ReseTbsColumnFieldBindings;
  FVisibleColumns.Clear;
  for I := 0 to FColumns.Count-1 do
    if FColumns[I].Showing then FVisibleColumns.Add(FColumns[I]);
  ColCount := FColumns.Count + FIndicatorOffset;
  inherited FixedCols := FIndicatorOffset;
  FTitleOffset := 0;
  if dgTitles in Options then
  begin
    FTitleOffset := 1;
    if (FDatalink <> nil) and (FDatalink.Dataset <> nil)
      and FDatalink.Dataset.ObjectView then
    begin
      for I := 0 to FColumns.Count-1 do
      begin
        if FColumns[I].Showing then
        begin
          J := FColumns[I].Depth;
          if J >= FTitleOffset then FTitleOffset := J+1;
        end;
      end;
    end;
  end;
  UpdateRowCount;
  MeasureTitleHeights;
  SetColumnAttributes;
  UpdateActive;
  Invalidate;
end;

procedure TbsSkinCustomDBGrid.LayoutChanged;
begin
  if AcquireLayoutLock then
    EndLayout;
end;

procedure TbsSkinCustomDBGrid.LinkActive(Value: Boolean);
var
  Comp: TComponent;
  I: Integer;
begin
  if not Value then HideEditor;
  FBookmarks.LinkActive(Value);
  try
    LayoutChanged;
  finally
    for I := ComponentCount-1 downto 0 do
    begin
      Comp := Components[I];   // Free all the popped-up subgrids
      if (Comp is TbsSkinCustomDBGrid)
        and (TbsSkinCustomDBGrid(Comp).DragKind = dkDock) then
        Comp.Free;
    end;
    UpdateScrollBar;
    if Value and (dgAlwaysShowEditor in Options) then ShowEditor;
  end;
end;

procedure TbsSkinCustomDBGrid.Loaded;
begin
  inherited Loaded;
  if FColumns.Count > 0 then
    ColCount := FColumns.Count;
  LayoutChanged;
end;

function TbsSkinCustomDBGrid.PtInExpandButton(X,Y: Integer; var MasterCol: TbsColumn): Boolean;
var
  Cell: TGridCoord;
  R: TRect;
begin
  MasterCol := nil;
  Result := False;
  Cell := MouseCoord(X,Y);
  if (Cell.Y < FTitleOffset) and FDatalink.Active
    and (Cell.X >= FIndicatorOffset)
    and (RawToDataColumn(Cell.X) < Columns.Count) then
  begin
    R := CalcTitleRect(Columns[RawToDataColumn(Cell.X)], Cell.Y, MasterCol);
    if not UseRightToLeftAlignment then
      R.Left := R.Right - GetSystemMetrics(SM_CXHSCROLL)
    else
      R.Right := R.Left + GetSystemMetrics(SM_CXHSCROLL);
    Result := MasterCol.Expandable and PtInRect(R, Point(X,Y));
  end;
end;

procedure TbsSkinCustomDBGrid.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  Cell: TGridCoord;
  OldCol,OldRow: Integer;
  MasterCol: TbsColumn;
  CellIndex: Integer;
begin

  if (Button = mbRight) and FSaveMultiSelection and 
     (dgMultiSelect in Options) and (PopupMenu <> nil) and 
     (SelectedRows.Count > 1)
  then
    Exit;

  if not AcquireFocus then Exit;
  if (ssDouble in Shift) and (Button = mbLeft) then
  begin
    DblClick;
    Exit;
  end;

  if Sizing(X, Y) then
  begin
    FDatalink.UpdateData;
    inherited MouseDown(Button, Shift, X, Y);
    Exit;
  end;

  Cell := MouseCoord(X, Y);
  if (Cell.X < 0) and (Cell.Y < 0) then
  begin
    inherited MouseDown(Button, Shift, X, Y);
    Exit;
  end;

  if (DragKind = dkDock) and (Cell.X < FIndicatorOffset) and
    (Cell.Y < FTitleOffset) and (not (csDesigning in ComponentState)) then
  begin
    BeginDrag(false);
    Exit;
  end;

  if PtInExpandButton(X,Y, MasterCol) then
  begin
    MasterCol.Expanded := not MasterCol.Expanded;
    ReleaseCapture;
    UpdateDesigner;
    Exit;
  end;

  if ((csDesigning in ComponentState) or (dgColumnResize in Options)) and
    (Cell.Y < FTitleOffset) then
  begin
    FDataLink.UpdateData;
    inherited MouseDown(Button, Shift, X, Y);
    Exit;
  end;

  if FDatalink.Active then
    with Cell do
    begin
      BeginUpdate;   { eliminates highlight flicker when selection moves }
      try
        FDatalink.UpdateData; // validate before moving
        HideEditor;
        OldCol := Col;
        OldRow := Row;
        if (Y >= FTitleOffset) and (Y - Row <> 0) then
          FDatalink.MoveBy(Y - Row);
        if X >= FIndicatorOffset then
          MoveCol(X, 0);
        if (dgMultiSelect in Options) and FDatalink.Active then
          with FBookmarks do
          begin
            FSelecting := False;
            if ssCtrl in Shift then
              CurrentRowSelected := not CurrentRowSelected
            else
            begin
              Clear;
              CurrentRowSelected := True;
            end;
          end;

        if dgIndicator in Options
        then
          CellIndex := Cell.X - 1
        else
          CellIndex := Cell.X;

        if CellIndex >= 0 then

        if (Columns.Count > 0) and (Columns[CellIndex].Field <> nil) and
            (Columns[CellIndex].Field.DataType = ftBoolean)
        then
          begin
            if not ReadOnly and ((X = OldCol) and (Y = OldRow))
            then
              begin
                FDatalink.Edit;
                FDatalink.Modified;
                if Columns[CellIndex].Field.AsBoolean = True
                then
                  Columns[CellIndex].Field.AsBoolean := False
                else
                  Columns[CellIndex].Field.AsBoolean := True;
              end;
          end
        else
        if (Button = mbLeft) and
          (((X = OldCol) and (Y = OldRow)) or (dgAlwaysShowEditor in Options)) then
          ShowEditor         { put grid in edit mode }
        else
          InvalidateEditor;  { draw editor, if needed }
      finally
        EndUpdate;
      end;
    end;
end;

procedure TbsSkinCustomDBGrid.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  Cell: TGridCoord;
  SaveState: TbsGridState;
begin
  SaveState := FGridState;
  inherited MouseUp(Button, Shift, X, Y);
  if (SaveState = gsRowSizing) or (SaveState = gsColSizing) or
    ((InplaceEditor <> nil) and (InplaceEditor.Visible) and
     (PtInRect(InplaceEditor.BoundsRect, Point(X,Y)))) then Exit;
  Cell := MouseCoord(X,Y);
  if (Button = mbLeft) and (Cell.X >= FIndicatorOffset) and (Cell.Y >= 0) then
    if Cell.Y < FTitleOffset then
      TitleClick(Columns[RawToDataColumn(Cell.X)])
    else
      CellClick(Columns[SelectedIndex]);
end;

procedure TbsSkinCustomDBGrid.MoveCol(RawCol, Direction: Integer);
var
  OldCol: Integer;
begin
  FDatalink.UpdateData;
  if RawCol >= ColCount then
    RawCol := ColCount - 1;
  if RawCol < FIndicatorOffset then RawCol := FIndicatorOffset;
  if Direction <> 0 then
  begin
    while (RawCol < ColCount) and (RawCol >= FIndicatorOffset) and
      (ColWidths[RawCol] <= 0) do
      Inc(RawCol, Direction);
    if (RawCol >= ColCount) or (RawCol < FIndicatorOffset) then Exit;
  end;
  OldCol := Col;
  if RawCol <> OldCol then
  begin
    if not FInColExit then
    begin
      FInColExit := True;
      try
        ColExit;
      finally
        FInColExit := False;
      end;
      if Col <> OldCol then Exit;
    end;
    if not (dgAlwaysShowEditor in Options) then HideEditor;
    Col := RawCol;
    ColEnter;
  end;
end;

procedure TbsSkinCustomDBGrid.Notification(AComponent: TComponent;
  Operation: TOperation);
var
  I: Integer;
  NeedLayout: Boolean;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FSkinMessage <> nil) and
    (AComponent = FSkinMessage) then FSkinMessage := nil;
  if (Operation = opRemove) then
  begin
    if (AComponent is TPopupMenu) then
    begin
      for I := 0 to Columns.Count-1 do
        if Columns[I].PopupMenu = AComponent then
          Columns[I].PopupMenu := nil;
    end
    else if (FDataLink <> nil) then
      if (AComponent = DataSource)  then
        DataSource := nil
      else if (AComponent is TField) then
      begin
        NeedLayout := False;
        BeginLayout;
        try
          for I := 0 to Columns.Count-1 do
            with Columns[I] do
              if Field = AComponent then
              begin
                Field := nil;
                NeedLayout := True;
              end;
        finally
          if NeedLayout and Assigned(FDatalink.Dataset)
            and not FDatalink.Dataset.ControlsDisabled then
            EndLayout
          else
            DeferLayout;
        end;
      end;
  end;
end;

procedure TbsSkinCustomDBGrid.RecordChanged(Field: TField);
var
  I: Integer;
  CField: TField;
begin
  if not HandleAllocated then Exit;
  if Field = nil then
    Invalidate
  else
  begin
    for I := 0 to Columns.Count - 1 do
      if Columns[I].Field = Field then
        InvalidateCol(DataToRawColumn(I));
  end;
  CField := SelectedField;
  if ((Field = nil) or (CField = Field)) and
    (Assigned(CField) and (CField.Text <> FEditText) and
    ((SysLocale.PriLangID <> LANG_KOREAN) or FIsESCKey)) then
  begin
    InvalidateEditor;
    if InplaceEditor <> nil then InplaceEditor.Deselect;
  end;
end;

procedure TbsSkinCustomDBGrid.Scroll(Distance: Integer);
var
  OldRect, NewRect: TRect;
  RowHeight: Integer;
begin
  if not HandleAllocated then Exit;
  OldRect := BoxRect(0, Row, ColCount - 1, Row);
  if (FDataLink.ActiveRecord >= RowCount - FTitleOffset) then UpdateRowCount;
  UpdateScrollBar;
  UpdateActive;
  NewRect := BoxRect(0, Row, ColCount - 1, Row);
  ValidateRect(Handle, @OldRect);
  InvalidateRect(Handle, @OldRect, False);
  InvalidateRect(Handle, @NewRect, False);
  if Distance <> 0 then
  begin
    HideEditor;
    try
      if Abs(Distance) > VisibleRowCount then
      begin
        Invalidate;
        Exit;
      end
      else
      begin
        RowHeight := DefaultRowHeight;
        if dgRowLines in Options then Inc(RowHeight, GridLineWidth);
        if dgIndicator in Options then
        begin
          OldRect := BoxRect(0, FSelRow, ColCount - 1, FSelRow);
          InvalidateRect(Handle, @OldRect, False);
        end;
        NewRect := BoxRect(0, FTitleOffset, ColCount - 1, 1000);
        ScrollWindowEx(Handle, 0, -RowHeight * Distance, @NewRect, @NewRect,
          0, nil, SW_Invalidate);
        if dgIndicator in Options then
        begin
          NewRect := BoxRect(0, Row, ColCount - 1, Row);
          InvalidateRect(Handle, @NewRect, False);
        end;
      end;
    finally
      if dgAlwaysShowEditor in Options then ShowEditor;
    end;
  end;
  if UpdateLock = 0 then Update;
end;

procedure TbsSkinCustomDBGrid.SetColumns(Value: TbsDBGridColumns);
begin
  Columns.Assign(Value);
end;

function ReadOnlyField(Field: TField): Boolean;
var
  MasterField: TField;
begin
  Result := Field.ReadOnly;
  if not Result and (Field.FieldKind = fkLookup) then
  begin
    Result := True;
    if Field.DataSet = nil then Exit;
    MasterField := Field.Dataset.FindField(Field.KeyFields);
    if MasterField = nil then Exit;
    Result := MasterField.ReadOnly;
  end;
end;

procedure TbsSkinCustomDBGrid.SetColumnAttributes;
var
  I: Integer;
begin
  for I := 0 to FColumns.Count-1 do
  with FColumns[I] do
  begin
    TabStops[I + FIndicatorOffset] := Showing and not ReadOnly and DataLink.Active and
      Assigned(Field) and not (Field.FieldKind = fkCalculated) and not ReadOnlyField(Field);
    ColWidths[I + FIndicatorOffset] := Width;
  end;
  if (dgIndicator in Options) then
  if FIndex = -1
  then
    ColWidths[0] := IndicatorWidth
  else
    if FixedCellLeftOffset + FixedCellRightOffset >= IndicatorWidth
    then
      ColWidths[0] := FixedCellLeftOffset + FixedCellRightOffset
    else
      ColWidths[0] := IndicatorWidth;
end;

procedure TbsSkinCustomDBGrid.SetDataSource(Value: TDataSource);
begin
  if Value = FDatalink.Datasource then Exit;
  FBookmarks.Clear;
  FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

procedure TbsSkinCustomDBGrid.SetEditText(ACol, ARow: Longint; const Value: string);
begin
  FEditText := Value;
end;

procedure TbsSkinCustomDBGrid.SetOptions(Value: TbsDBGridOptions);
const
  LayoutOptions = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator,
    dgColLines, dgRowLines, dgRowSelect, dgAlwaysShowSelection];
var
  NewGridOptions: TGridOptions;
  ChangedOptions: TbsDBGridOptions;
begin
  if FOptions <> Value then
  begin
    NewGridOptions := [];
    if dgColLines in Value then
      NewGridOptions := NewGridOptions + [goFixedVertLine, goVertLine];
    if dgRowLines in Value then
      NewGridOptions := NewGridOptions + [goFixedHorzLine, goHorzLine];
    if dgColumnResize in Value then
      NewGridOptions := NewGridOptions + [goColSizing, goColMoving];
    if dgTabs in Value then Include(NewGridOptions, goTabs);
    if dgRowSelect in Value then
    begin
      Include(NewGridOptions, goRowSelect);
      Exclude(Value, dgAlwaysShowEditor);
      Exclude(Value, dgEditing);
    end;
    if dgEditing in Value then Include(NewGridOptions, goEditing);
    if dgAlwaysShowEditor in Value then Include(NewGridOptions, goAlwaysShowEditor);
    inherited Options := NewGridOptions;
    if dgMultiSelect in (FOptions - Value) then FBookmarks.Clear;
    ChangedOptions := (FOptions + Value) - (FOptions * Value);
    FOptions := Value;
    if ChangedOptions * LayoutOptions <> [] then LayoutChanged;
  end;
end;

procedure TbsSkinCustomDBGrid.SetSelectedField(Value: TField);
var
  I: Integer;
begin
  if Value = nil then Exit;
  for I := 0 to Columns.Count - 1 do
    if Columns[I].Field = Value then
      MoveCol(DataToRawColumn(I), 0);
end;

procedure TbsSkinCustomDBGrid.SetSelectedIndex(Value: Integer);
begin
  MoveCol(DataToRawColumn(Value), 0);
end;

procedure TbsSkinCustomDBGrid.SetTitleFont(Value: TFont);
begin
  FTitleFont.Assign(Value);
  if dgTitles in Options then LayoutChanged;
end;

function TbsSkinCustomDBGrid.StoreColumns: Boolean;
begin
  Result := Columns.State = csCustomized;
end;

procedure TbsSkinCustomDBGrid.TimedScroll(Direction: TGridScrollDirection);
begin
  if FDatalink.Active then
  begin
    with FDatalink do
    begin
      if sdUp in Direction then
      begin
        FDataLink.MoveBy(-ActiveRecord - 1);
        Exclude(Direction, sdUp);
      end;
      if sdDown in Direction then
      begin
        FDataLink.MoveBy(RecordCount - ActiveRecord);
        Exclude(Direction, sdDown);
      end;
    end;
    if Direction <> [] then inherited TimedScroll(Direction);
  end;
end;

procedure TbsSkinCustomDBGrid.TitleClick(Column: TbsColumn);
begin
  if Assigned(FOnTitleClick) then FOnTitleClick(Column);
end;

procedure TbsSkinCustomDBGrid.TitleFontChanged(Sender: TObject);
begin
  if (not FSelfChangingTitleFont) and not (csLoading in ComponentState) then
    ParentFont := False;
  if dgTitles in Options then LayoutChanged;
end;

procedure TbsSkinCustomDBGrid.UpdateActive;
var
  NewRow: Integer;
  Field: TField;
begin
  if FDatalink.Active and HandleAllocated and not (csLoading in ComponentState) then
  begin
    NewRow := FDatalink.ActiveRecord + FTitleOffset;
    if Row <> NewRow then
    begin
      if not (dgAlwaysShowEditor in Options) then HideEditor;
      MoveColRow(Col, NewRow, False, False);
      InvalidateEditor;
    end;
    Field := SelectedField;
    if Assigned(Field) and (Field.Text <> FEditText) then
      InvalidateEditor;
  end;
end;

procedure TbsSkinCustomDBGrid.UpdateData;
var
  Field: TField;
begin
  Field := SelectedField;
  if Assigned(Field) then
    Field.Text := FEditText;
end;

procedure TbsSkinCustomDBGrid.UpdateRowCount;
var
  OldRowCount: Integer;
begin
  OldRowCount := RowCount;
  if RowCount <= FTitleOffset then RowCount := FTitleOffset + 1;
  FixedRows := FTitleOffset;
  with FDataLink do
    if not Active or (RecordCount = 0) or not HandleAllocated then
      RowCount := 1 + FTitleOffset
    else
    begin
      RowCount := 1000;
      FDataLink.BufferCount := VisibleRowCount;
      RowCount := RecordCount + FTitleOffset;
      if dgRowSelect in Options then TopRow := FixedRows;
      UpdateActive;
    end;
  if OldRowCount <> RowCount then Invalidate;
end;


type
  TParentControl = class(TWinControl);

procedure TbsSkinCustomDBGrid.UpdateScrollBar;
var
  Pos: Integer;
  OldVisible, VVisible, VVisibleChanged: Boolean;
  R: TRect;
begin

  if (csDestroying in ComponentState) then Exit;

  VVisibleChanged := False;
  if FDatalink.Active and HandleAllocated then
    with FDatalink.DataSet do
    begin
      if (VScrollBar <> nil)
      then
        begin
          OldVisible := VScrollBar.Visible;
          VVisible := Self.RowCount >= Self.VisibleRowCount;
          VVisibleChanged := OldVisible <> VVisible;
          if IsSequenced
          then
            begin
              if RecNo <> -1
              then
                VScrollBar.SetRange(1, Integer(DWORD(RecordCount)) + Self.VisibleRowCount - 1,
                  RecNo, Self.VisibleRowCount);
            end
          else
            begin
              if FDataLink.BOF then Pos := 0
              else if FDataLink.EOF then Pos := 4
              else Pos := 2;
              VScrollBar.SetRange(0, 4, Pos, 0);
            end;
        end;
    end
  else
    if (VScrollBar <>  nil) and VScrollBar.Visible
    then
      begin
        VVisible := False;
        VVisibleChanged := True;
      end;

  FInCheckScrollBars := True;
  if VVisibleChanged then VScrollBar.Visible := VVisible;
  FInCheckScrollBars := False;

   if (VScrollBar <> nil) and (HScrollBar <> nil)
  then
    begin
      if not VScrollBar.Visible and HScrollBar.Both
      then
        HScrollBar.Both := False
      else
        if VScrollBar.Visible and not HScrollBar.Both
        then
          HScrollBar.Both := True;
    end;
  if (Self.Align <> alNone) and VVisibleChanged
  then
    begin
      R := Parent.ClientRect;
      TParentControl(Parent).AlignControls(nil, R);
      FInCheckScrollBars := True;
      Invalidate;
      FInCheckScrollBars := False;
    end;
end;


function TbsSkinCustomDBGrid.ValidFieldIndex(FieldIndex: Integer): Boolean;
begin
  Result := DataLink.GetMappedIndex(FieldIndex) >= 0;
end;

procedure TbsSkinCustomDBGrid.CMParentFontChanged(var Message: TMessage);
begin
  inherited;
  if ParentFont then
  begin
    FSelfChangingTitleFont := True;
    try
      TitleFont := Font;
    finally
      FSelfChangingTitleFont := False;
    end;
    LayoutChanged;
  end;
end;

procedure TbsSkinCustomDBGrid.CMBiDiModeChanged(var Message: TMessage);
var
  Loop: Integer;
begin
  inherited;
  for Loop := 0 to ComponentCount - 1 do
    if Components[Loop] is TbsSkinCustomDBGrid then
      with Components[Loop] as TbsSkinCustomDBGrid do
        { Changing the window, echos down to the subgrid }
        if Parent <> nil then
          Parent.BiDiMode := Self.BiDiMode;
end;

procedure TbsSkinCustomDBGrid.CMExit(var Message: TMessage);
begin
  try
    if FDatalink.Active then
      with FDatalink.Dataset do
        if (dgCancelOnExit in Options) and (State = dsInsert) and
          not Modified and not FDatalink.FModified then
          Cancel else
          FDataLink.UpdateData;
  except
    SetFocus;
    raise;
  end;
  inherited;
end;

procedure TbsSkinCustomDBGrid.CMFontChanged(var Message: TMessage);
var
  I: Integer;
begin
  inherited;
  BeginLayout;
  try
    for I := 0 to Columns.Count-1 do
      Columns[I].RefreshDefaultFont;
  finally
    EndLayout;
  end;
end;

procedure TbsSkinCustomDBGrid.CMDeferLayout(var Message);
begin
  if AcquireLayoutLock then
    EndLayout
  else
    DeferLayout;
end;

procedure TbsSkinCustomDBGrid.CMDesignHitTest(var Msg: TCMDesignHitTest);
var
  MasterCol: TbsColumn;
begin
  inherited;
  if (Msg.Result = 1) and ((FDataLink = nil) or
    ((Columns.State = csDefault) and
     (FDataLink.DefaultFields or (not FDataLink.Active)))) then
    Msg.Result := 0
  else if (Msg.Result = 0) and (FDataLink <> nil) and (FDataLink.Active)
    and (Columns.State = csCustomized)
    and PtInExpandButton(Msg.XPos, Msg.YPos, MasterCol) then
    Msg.Result := 1;
end;

procedure TbsSkinCustomDBGrid.WMSetCursor(var Msg: TWMSetCursor);
begin
  if (csDesigning in ComponentState) and
      ((FDataLink = nil) or
       ((Columns.State = csDefault) and
        (FDataLink.DefaultFields or not FDataLink.Active))) then
    Windows.SetCursor(LoadCursor(0, IDC_ARROW))
  else inherited;
end;

procedure TbsSkinCustomDBGrid.WMSize(var Message: TWMSize);
begin
  inherited;
  if UpdateLock = 0 then UpdateRowCount;
  InvalidateTitles;
end;

procedure TbsSkinCustomDBGrid.WMVScroll(var Message: TWMVScroll);
var
  i, j: Integer;
begin
  if not AcquireFocus then Exit;
  if FDatalink.Active then
    with Message, FDataLink.DataSet do
      case ScrollCode of
        SB_LINEUP: FDataLink.MoveBy(-FDatalink.ActiveRecord - 1);
        SB_LINEDOWN: FDataLink.MoveBy(FDatalink.RecordCount - FDatalink.ActiveRecord);
        SB_PAGEUP: FDataLink.MoveBy(-VisibleRowCount);
        SB_PAGEDOWN: FDataLink.MoveBy(VisibleRowCount);
        SB_THUMBPOSITION:
          if (VScrollBar <> nil)
          then
            with VScrollBar do
            begin
              if IsSequenced
              then
                begin
                  i := VScrollBar.Position;
                  if i <= 1 then First
                  else if i >= RecordCount then Last
                  else RecNo := i;
                end
              else
                case Position of
                  0: First;
                  1: FDataLink.MoveBy(-VisibleRowCount);
                  2: Exit;
                  3: FDataLink.MoveBy(VisibleRowCount);
                  4: Last;
                end;
            end;
        SB_BOTTOM: Last;
        SB_TOP: First;
      end;
end;

procedure TbsSkinCustomDBGrid.SetIme;
var
  Column: TbsColumn;
begin
  if not SysLocale.FarEast then Exit;
  if Columns.Count = 0 then Exit;

  ImeName := FOriginalImeName;
  ImeMode := FOriginalImeMode;
  Column := Columns[SelectedIndex];
  if Column.IsImeNameStored then ImeName := Column.ImeName;
  if Column.IsImeModeStored then ImeMode := Column.ImeMode;

  if InplaceEditor <> nil then
  begin
    TDBGridInplaceEdit(Self).ImeName := ImeName;
    TDBGridInplaceEdit(Self).ImeMode := ImeMode;
  end;
end;

procedure TbsSkinCustomDBGrid.UpdateIme;
begin
  if not SysLocale.FarEast then Exit;
  SetIme;
  SetImeName(ImeName);
  SetImeMode(Handle, ImeMode);
end;

procedure TbsSkinCustomDBGrid.WMIMEStartComp(var Message: TMessage);
begin
  inherited;
  ShowEditor;
end;

procedure TbsSkinCustomDBGrid.WMSetFocus(var Message: TWMSetFocus);
begin
  if not ((InplaceEditor <> nil) and
    (Message.FocusedWnd = InplaceEditor.Handle)) then SetIme;
  inherited;
end;

procedure TbsSkinCustomDBGrid.WMKillFocus(var Message: TMessage);
begin
  if not SysLocale.FarEast then inherited
  else
  begin
    ImeName := Screen.DefaultIme;
    ImeMode := imDontCare;
    inherited;
    if not ((InplaceEditor <> nil) and
      (HWND(Message.WParam) = InplaceEditor.Handle)) then
      ActivateKeyboardLayout(Screen.DefaultKbLayout, KLF_ACTIVATE);
  end;
end;

{ Defer action processing to datalink }

function TbsSkinCustomDBGrid.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := (DataLink <> nil) and DataLink.ExecuteAction(Action);
end;

function TbsSkinCustomDBGrid.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := (DataLink <> nil) and DataLink.UpdateAction(Action);
end;

procedure TbsSkinCustomDBGrid.ShowPopupEditor(Column: TbsColumn; X, Y: Integer);
var
  SubGrid: TbsSkinCustomDBGrid;
  DS: TDataSource;
  I: Integer;
  FloatRect: TRect;
  Cmp: TControl;
begin
  if not ((Column.Field <> nil) and (Column.Field is TDataSetField)) then  Exit;

  // find existing popup for this column field, if any, and show it
  for I := 0 to ComponentCount-1 do
    if Components[I] is TbsSkinCustomDBGrid then
    begin
      SubGrid := TbsSkinCustomDBGrid(Components[I]);
      if (SubGrid.DataSource <> nil) and
        (SubGrid.DataSource.DataSet = (Column.Field as TDatasetField).NestedDataset) and
        SubGrid.CanFocus then
      begin
        SubGrid.Parent.Show;
        SubGrid.SetFocus;
        Exit;
      end;
    end;

  // create another instance of this kind of grid
  SubGrid := TbsSkinCustomDBGrid(TComponentClass(Self.ClassType).Create(Self));
  try
    DS := TDataSource.Create(SubGrid); // incestuous, but easy cleanup
    DS.Dataset := (Column.Field as TDatasetField).NestedDataset;
    DS.DataSet.CheckBrowseMode;
    SubGrid.DataSource := DS;
    SubGrid.Columns.State := Columns.State;
    SubGrid.Columns[0].Expanded := True;
    SubGrid.Visible := False;
    SubGrid.FloatingDockSiteClass := TCustomDockForm;
    FloatRect.TopLeft := ClientToScreen(CellRect(Col, Row).BottomRight);
    if X > Low(Integer) then FloatRect.Left := X;
    if Y > Low(Integer) then FloatRect.Top := Y;
    FloatRect.Right := FloatRect.Left + Width;
    FloatRect.Bottom := FloatRect.Top + Height;
    SubGrid.ManualFloat(FloatRect);
//    SubGrid.ManualDock(nil,nil,alClient);
    SubGrid.Parent.BiDiMode := Self.BiDiMode; { This carries the BiDi setting }
    I := SubGrid.CellRect(SubGrid.ColCount-1, 0).Right;
    if (I > 0) and (I < Screen.Width div 2) then
      SubGrid.Parent.ClientWidth := I
    else
      SubGrid.Parent.Width := Screen.Width div 4;
    SubGrid.Parent.Height := Screen.Height div 4;
    SubGrid.Align := alClient;
    SubGrid.DragKind := dkDock;
    SubGrid.Color := Color;
    SubGrid.Ctl3D := Ctl3D;
    SubGrid.Cursor := Cursor;
    SubGrid.Enabled := Enabled;
    SubGrid.FixedColor := FixedColor;
    SubGrid.Font := Font;
    SubGrid.HelpContext := HelpContext;
    SubGrid.IMEMode := IMEMode;
    SubGrid.IMEName := IMEName;
    SubGrid.Options := Options;
    Cmp := Self;
    while (Cmp <> nil) and (TbsSkinCustomDBGrid(Cmp).PopupMenu = nil) do
      Cmp := Cmp.Parent;
    if Cmp <> nil then
      SubGrid.PopupMenu := TbsSkinCustomDBGrid(Cmp).PopupMenu;
    SubGrid.TitleFont := TitleFont;
    SubGrid.Visible := True;
    SubGrid.Parent.Show;
  except
    SubGrid.Free;
    raise;
  end;
end;

procedure TbsSkinCustomDBGrid.CalcSizingState(X, Y: Integer;
  var State: TbsGridState; var Index, SizingPos, SizingOfs: Integer;
  var FixedInfo: TbsGridDrawInfo);
var
  R: TGridCoord;
begin
  inherited CalcSizingState(X, Y, State, Index, SizingPos, SizingOfs, FixedInfo);
  if (State = gsColSizing) and (FDataLink <> nil)
    and (FDatalink.Dataset <> nil) and FDataLink.Dataset.ObjectView then
  begin
    R := MouseCoord(X, Y);
    R.X := RawToDataColumn(R.X);
    if (R.X >= 0) and (R.X < Columns.Count) and (Columns[R.X].Depth > R.Y) then
      State := gsNormal;
  end;
end;

function TbsSkinCustomDBGrid.CheckColumnDrag(var Origin, Destination: Integer;
  const MousePt: TPoint): Boolean;
var
  I, ARow: Integer;
  DestCol: TbsColumn;
begin
  Result := inherited CheckColumnDrag(Origin, Destination, MousePt);
  if Result and (FDatalink.Dataset <> nil) and FDatalink.Dataset.ObjectView then
  begin
    assert(FDragCol <> nil);
    ARow := FDragCol.Depth;
    if Destination <> Origin then
    begin
      DestCol := ColumnAtDepth(Columns[RawToDataColumn(Destination)], ARow);
      if DestCol.ParentColumn <> FDragCol.ParentColumn then
        if Destination < Origin then
          DestCol := Columns[FDragCol.ParentColumn.Index+1]
        else
        begin
          I := DestCol.Index;
          while DestCol.ParentColumn <> FDragCol.ParentColumn do
          begin
            Dec(I);
            DestCol := Columns[I];
          end;
        end;
      if (DestCol.Index > FDragCol.Index) then
      begin
        I := DestCol.Index + 1;
        while (I < Columns.Count) and (ColumnAtDepth(Columns[I],ARow) = DestCol) do
          Inc(I);
        DestCol := Columns[I-1];
      end;
      Destination := DataToRawColumn(DestCol.Index);
    end;
  end;
end;

function TbsSkinCustomDBGrid.BeginColumnDrag(var Origin, Destination: Integer;
  const MousePt: TPoint): Boolean;
var
  I, ARow: Integer;
begin
  Result := inherited BeginColumnDrag(Origin, Destination, MousePt);
  if Result and (FDatalink.Dataset <> nil) and FDatalink.Dataset.ObjectView then
  begin
    ARow := MouseCoord(MousePt.X, MousePt.Y).Y;
    FDragCol := ColumnAtDepth(Columns[RawToDataColumn(Origin)], ARow);
    if FDragCol = nil then Exit;
    I := DataToRawColumn(FDragCol.Index);
    if Origin <> I then Origin := I;
    Destination := Origin;
  end;
end;

function TbsSkinCustomDBGrid.EndColumnDrag(var Origin, Destination: Integer;
  const MousePt: TPoint): Boolean;
begin
  Result := inherited EndColumnDrag(Origin, Destination, MousePt);
  FDragCol := nil;
end;

procedure TbsSkinCustomDBGrid.InvalidateTitles;
var
  R: TRect;
  DrawInfo: TbsGridDrawInfo;
begin
  if HandleAllocated and (dgTitles in Options) then
  begin
    CalcFixedInfo(DrawInfo);
    R := Rect(0, 0, Width, DrawInfo.Vert.FixedBoundary);
    InvalidateRect(Handle, @R, False);
  end;
end;

procedure TbsSkinCustomDBGrid.TopLeftChanged;
begin
  InvalidateTitles; 
  inherited TopLeftChanged;
end;

end.
