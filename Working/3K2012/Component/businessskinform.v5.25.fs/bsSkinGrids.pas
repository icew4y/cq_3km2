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
                     
unit bsSkinGrids;

{$P+,S-,W-,R-}
{$WARNINGS OFF}
{$HINTS OFF}

interface

uses Messages, Windows, SysUtils, Classes, Graphics, Menus, Controls, Forms,
     StdCtrls, Mask, bsSkinData, bsSkinCtrls, bsSkinMenus;

const
  MaxCustomExtents = MaxListSize;
  MaxShortInt = High(ShortInt);

type
  bsEInvalidGridOperation = class(Exception);

  { Internal grid types }
  TbsGetExtentsFunc = function(Index: Longint): Integer of object;

  TbsGridAxisDrawInfo = record
    EffectiveLineWidth: Integer;
    FixedBoundary: Integer;
    GridBoundary: Integer;
    GridExtent: Integer;
    LastFullVisibleCell: Longint;
    FullVisBoundary: Integer;
    FixedCellCount: Integer;
    FirstGridCell: Integer;
    GridCellCount: Integer;
    GetExtent: TbsGetExtentsFunc;
  end;

  TbsGridDrawInfo = record
    Horz, Vert: TbsGridAxisDrawInfo;
  end;

  TbsGridState = (gsNormal, gsSelecting, gsRowSizing, gsColSizing,
    gsRowMoving, gsColMoving);
  TbsGridMovement = gsRowMoving..gsColMoving;

  { TInplaceEdit }
  { The inplace editor is not intended to be used outside the grid }

  TbsSkinCustomGrid = class;
  
  TbsSkinInplaceEdit = class(TCustomMaskEdit)
  private
    FGrid: TbsSkinCustomGrid;
    FClickTime: Longint;
    FSysPopupMenu: TbsSkinPopupMenu;
    procedure DoUndo(Sender: TObject);
    procedure DoCut(Sender: TObject);
    procedure DoCopy(Sender: TObject);
    procedure DoPaste(Sender: TObject);
    procedure DoDelete(Sender: TObject);
    procedure DoSelectAll(Sender: TObject);
    procedure CreateSysPopupMenu;
    procedure WMAFTERDISPATCH(var Message: TMessage); message WM_AFTERDISPATCH;
    procedure WMCONTEXTMENU(var Message: TWMCONTEXTMENU); message WM_CONTEXTMENU;
    procedure InternalMove(const Loc: TRect; Redraw: Boolean);
    procedure SetGrid(Value: TbsSkinCustomGrid);
    procedure CMShowingChanged(var Message: TMessage); message CM_SHOWINGCHANGED;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMPaste(var Message); message WM_PASTE;
    procedure WMCut(var Message); message WM_CUT;
    procedure WMClear(var Message); message WM_CLEAR;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DblClick; override;
    function EditCanModify: Boolean; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure BoundsChanged; virtual;
    procedure UpdateContents; virtual;
    procedure WndProc(var Message: TMessage); override;
    property  Grid: TbsSkinCustomGrid read FGrid;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Deselect;
    procedure Hide;
    procedure Invalidate;
    procedure Move(const Loc: TRect);
    function PosEqual(const Rect: TRect): Boolean;
    procedure SetFocus;
    procedure UpdateLoc(const Loc: TRect);
    function Visible: Boolean;
  end;

  { TbsSkinCustomGrid }

  TGridOption = (goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine,
    goRangeSelect, goDrawFocusSelected, goRowSizing, goColSizing, goRowMoving,
    goColMoving, goEditing, goTabs, goRowSelect,
    goAlwaysShowEditor, goThumbTracking);
  TGridOptions = set of TGridOption;
  TGridDrawState = set of (gdSelected, gdFocused, gdFixed);
  TGridScrollDirection = set of (sdLeft, sdRight, sdUp, sdDown);

  TGridCoord = record
    X: Longint;
    Y: Longint;
  end;

  TGridRect = record
    case Integer of
      0: (Left, Top, Right, Bottom: Longint);
      1: (TopLeft, BottomRight: TGridCoord);
  end;

  TSelectCellEvent = procedure (Sender: TObject; ACol, ARow: Longint;
    var CanSelect: Boolean) of object;
  TDrawCellEvent = procedure (Sender: TObject; ACol, ARow: Longint;
    Rect: TRect; State: TGridDrawState) of object;

  TbsSkinCustomGrid = class(TbsSkinControl)
  private
    FUseSkinFont: Boolean;
    FUseSkinCellHeight: Boolean;
    FGridLineColor: TColor;
    FHScrollBar: TbsSkinScrollBar;
    FVScrollBar: TbsSkinScrollBar;
    FAnchor: TGridCoord;
    FBorderStyle: TBorderStyle;
    FCanEditModify: Boolean;
    FColCount: Longint;
    FColWidths: Pointer;
    FTabStops: Pointer;
    FCurrent: TGridCoord;
    FDefaultColWidth: Integer;
    FDefaultRowHeight: Integer;
    FDefaultCellHeight: Integer;
    FFixedCols: Integer;
    FFixedRows: Integer;
    FFixedColor: TColor;
    FGridLineWidth: Integer;
    FOptions: TGridOptions;
    FRowCount: Longint;
    FRowHeights: Pointer;
    FTopLeft: TGridCoord;
    FSizingIndex: Longint;
    FSizingPos, FSizingOfs: Integer;
    FMoveIndex, FMovePos: Longint;
    FHitTest: TPoint;
    FInplaceEdit: TbsSkinInplaceEdit;
    FInplaceCol, FInplaceRow: Longint;
    FColOffset: Integer;
    FDefaultDrawing: Boolean;
    FEditorMode: Boolean;

    procedure SetGridLineColor(Value: TColor);

    procedure SetDefaultCellHeight(Value: Integer);
    procedure OnVScrollBarChange(Sender: TObject);
    procedure OnVScrollBarPageUp(Sender: TObject);
    procedure OnVScrollBarPageDown(Sender: TObject);
    procedure OnHScrollBarChange(Sender: TObject);
    procedure OnVScrollBarUpButtonClick(Sender: TObject);
    procedure OnVScrollBarDownButtonClick(Sender: TObject);
    procedure OnHScrollBarUpButtonClick(Sender: TObject);
    procedure OnHScrollBarDownButtonClick(Sender: TObject);
    procedure OnHScrollBarPageUp(Sender: TObject);
    procedure OnHScrollBarPageDown(Sender: TObject);

    function CalcCoordFromPoint(X, Y: Integer;
      const DrawInfo: TbsGridDrawInfo): TGridCoord;
    procedure CalcDrawInfoXY(var DrawInfo: TbsGridDrawInfo;
      UseWidth, UseHeight: Integer);
    function CalcMaxTopLeft(const Coord: TGridCoord;
      const DrawInfo: TbsGridDrawInfo): TGridCoord;
    procedure CancelMode;
    procedure ChangeGridOrientation(RightToLeftOrientation: Boolean);
    procedure ChangeSize(NewColCount, NewRowCount: Longint);
    procedure ClampInView(const Coord: TGridCoord);
    procedure DrawSizingLine(const DrawInfo: TbsGridDrawInfo);
    procedure DrawMove;
    procedure FocusCell(ACol, ARow: Longint; MoveAnchor: Boolean);
    procedure GridRectToScreenRect(GridRect: TGridRect;
      var ScreenRect: TRect; IncludeLine: Boolean);
    procedure HideEdit;
    procedure Initialize;
    procedure InvalidateGrid;
    procedure InvalidateRect(ARect: TGridRect);
    procedure ModifyScrollBar(ScrollBar, ScrollCode, Pos: Cardinal;
      UseRightToLeft: Boolean);
    procedure MoveAdjust(var CellPos: Longint; FromIndex, ToIndex: Longint);
    procedure MoveAnchor(const NewAnchor: TGridCoord);
    procedure MoveAndScroll(Mouse, CellHit: Integer; var DrawInfo: TbsGridDrawInfo;
      var Axis: TbsGridAxisDrawInfo; Scrollbar: Integer; const MousePt: TPoint);
//    procedure MoveCurrent(ACol, ARow: Longint; MoveAnchor, Show: Boolean);
    procedure MoveTopLeft(ALeft, ATop: Longint);
    procedure ResizeCol(Index: Longint; OldSize, NewSize: Integer);
    procedure ResizeRow(Index: Longint; OldSize, NewSize: Integer);
    procedure SelectionMoved(const OldSel: TGridRect);
    procedure ScrollDataInfo(DX, DY: Integer; var DrawInfo: TbsGridDrawInfo);
    procedure TopLeftMoved(const OldTopLeft: TGridCoord);
    function GetColWidths(Index: Longint): Integer;
    function GetRowHeights(Index: Longint): Integer;
    function GetSelection: TGridRect;
    function GetTabStops(Index: Longint): Boolean;
    function GetVisibleRowCount: Integer;
    function GetVisibleColCount: Integer;
    function IsActiveControl: Boolean;
    procedure ReadColWidths(Reader: TReader);
    procedure ReadRowHeights(Reader: TReader);
    procedure SetBorderStyle(Value: TBorderStyle);
    procedure SetCol(Value: Longint);
    procedure SetColWidths(Index: Longint; Value: Integer);
    procedure SetDefaultColWidth(Value: Integer);
    procedure SetDefaultRowHeight(Value: Integer);
    procedure SetEditorMode(Value: Boolean);
    procedure SetFixedColor(Value: TColor);
    procedure SetFixedCols(Value: Integer);
    procedure SetFixedRows(Value: Integer);
    procedure SetGridLineWidth(Value: Integer);
    procedure SetLeftCol(Value: Longint);
    procedure SetOptions(Value: TGridOptions);
    procedure SetRow(Value: Longint);
    procedure SetRowHeights(Index: Longint; Value: Integer);
    procedure SetSelection(Value: TGridRect);
    procedure SetTabStops(Index: Longint; Value: Boolean);
    procedure SetTopRow(Value: Longint);
    procedure UpdateText;
    procedure UpdateEdit; 
    procedure WriteColWidths(Writer: TWriter);
    procedure WriteRowHeights(Writer: TWriter);
    procedure CMCancelMode(var Msg: TMessage); message CM_CANCELMODE;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMDesignHitTest(var Msg: TCMDesignHitTest); message CM_DESIGNHITTEST;
    procedure CMWanTbsecialKey(var Msg: TCMWantSpecialKey); message CM_WANTSPECIALKEY;
    procedure CMShowingChanged(var Message: TMessage); message CM_SHOWINGCHANGED;
    procedure WMChar(var Msg: TWMChar); message WM_CHAR;
    procedure WMCancelMode(var Msg: TWMCancelMode); message WM_CANCELMODE;
    procedure WMCommand(var Message: TWMCommand); message WM_COMMAND;
    procedure WMGetDlgCode(var Msg: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMHScroll(var Msg: TWMHScroll); message WM_HSCROLL;
    procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMLButtonDown(var Message: TMessage); message WM_LBUTTONDOWN;
    procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMSetCursor(var Msg: TWMSetCursor); message WM_SETCURSOR;
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure WMSize(var Msg: TWMSize); message WM_SIZE;
    procedure WMTimer(var Msg: TWMTimer); message WM_TIMER;
    procedure WMPAINT(var Msg: TWMPAINT); message WM_PAINT;
    procedure WMVScroll(var Msg: TWMVScroll); message WM_VSCROLL;
  protected
    FInCheckScrollBars: Boolean;
    FGridState: TbsGridState;
    FSaveCellExtents: Boolean;
    DesignOptionsBoost: TGridOptions;
    VirtualView: Boolean;

    //
    procedure SetColCount(Value: Longint); virtual;
    procedure MoveCurrent(ACol, ARow: Longint; MoveAnchor, Show: Boolean); virtual;
    procedure SetRowCount(Value: Longint); virtual;
    //

    procedure SetHScrollBar(Value: TbsSkinScrollBar); virtual;
    procedure SetVScrollBar(Value: TbsSkinScrollBar); virtual;

    procedure UpdateScrollPos(UpDateVert: Boolean); virtual;
    procedure UpdateScrollRange(UpDateVert: Boolean); virtual;
    procedure GetSkinData; override;
    procedure CalcDrawInfo(var DrawInfo: TbsGridDrawInfo);
    procedure CalcFixedInfo(var DrawInfo: TbsGridDrawInfo);
    procedure CalcSizingState(X, Y: Integer; var State: TbsGridState;
      var Index: Longint; var SizingPos, SizingOfs: Integer;
      var FixedInfo: TbsGridDrawInfo); virtual;
    function CreateEditor: TbsSkinInplaceEdit; virtual;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure AdjustSize(Index, Amount: Longint; Rows: Boolean); reintroduce; dynamic;
    function BoxRect(ALeft, ATop, ARight, ABottom: Longint): TRect;
    procedure DoExit; override;
    function CellRect(ACol, ARow: Longint): TRect;
    function CanEditAcceptKey(Key: Char): Boolean; dynamic;
    function CanGridAcceptKey(Key: Word; Shift: TShiftState): Boolean; dynamic;
    function CanEditModify: Boolean; dynamic;
    function CanEditShow: Boolean; virtual;
    function DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function GetEditText(ACol, ARow: Longint): string; dynamic;
    procedure SetEditText(ACol, ARow: Longint; const Value: string); dynamic;
    function GetEditMask(ACol, ARow: Longint): string; dynamic;
    function GetEditLimit: Integer; dynamic;
    function GetGridWidth: Integer;
    function GetGridHeight: Integer;
    procedure HideEditor;
    procedure ShowEditor;
    procedure ShowEditorChar(Ch: Char);
    procedure InvalidateEditor;
    procedure MoveColumn(FromIndex, ToIndex: Longint);
    procedure ColumnMoved(FromIndex, ToIndex: Longint); dynamic;
    procedure MoveRow(FromIndex, ToIndex: Longint);
    procedure RowMoved(FromIndex, ToIndex: Longint); dynamic;
    procedure DrawCell(ACol, ARow: Longint; ARect: TRect;
      AState: TGridDrawState); virtual; abstract;
    procedure DefineProperties(Filer: TFiler); override;
    procedure MoveColRow(ACol, ARow: Longint; MoveAnchor, Show: Boolean);
    function SelectCell(ACol, ARow: Longint): Boolean; virtual;
    procedure SizeChanged(OldColCount, OldRowCount: Longint); dynamic;
    function Sizing(X, Y: Integer): Boolean;
    procedure ScrollData(DX, DY: Integer);
    procedure InvalidateCell(ACol, ARow: Longint);
    procedure InvalidateCol(ACol: Longint);
    procedure InvalidateRow(ARow: Longint);
    procedure TopLeftChanged; dynamic;
    procedure TimedScroll(Direction: TGridScrollDirection); dynamic;
    procedure Paint; override;
    procedure ColWidthsChanged; dynamic;
    procedure RowHeightsChanged; dynamic;
    procedure DeleteColumn(ACol: Longint); virtual;
    procedure DeleteRow(ARow: Longint); virtual;
    procedure UpdateDesigner;
    function BeginColumnDrag(var Origin, Destination: Integer;
      const MousePt: TPoint): Boolean; dynamic;
    function BeginRowDrag(var Origin, Destination: Integer;
      const MousePt: TPoint): Boolean; dynamic;
    function CheckColumnDrag(var Origin, Destination: Integer;
      const MousePt: TPoint): Boolean; dynamic;
    function CheckRowDrag(var Origin, Destination: Integer;
      const MousePt: TPoint): Boolean; dynamic;
    function EndColumnDrag(var Origin, Destination: Integer;
      const MousePt: TPoint): Boolean; dynamic;
    function EndRowDrag(var Origin, Destination: Integer;
      const MousePt: TPoint): Boolean; dynamic;
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default bsSingle;
    property Col: Longint read FCurrent.X write SetCol;
    property Color default clWindow;
    property ColCount: Longint read FColCount write SetColCount default 5;
    property ColWidths[Index: Longint]: Integer read GetColWidths write SetColWidths;
    property DefaultColWidth: Integer read FDefaultColWidth write SetDefaultColWidth default 64;
    property DefaultDrawing: Boolean read FDefaultDrawing write FDefaultDrawing default True;
    property DefaultRowHeight: Integer read FDefaultRowHeight write SetDefaultRowHeight default 24;
    property EditorMode: Boolean read FEditorMode write SetEditorMode;
    property FixedColor: TColor read FFixedColor write SetFixedColor default clBtnFace;
    property FixedCols: Integer read FFixedCols write SetFixedCols default 1;
    property FixedRows: Integer read FFixedRows write SetFixedRows default 1;
    property GridHeight: Integer read GetGridHeight;
    property GridLineWidth: Integer read FGridLineWidth write SetGridLineWidth default 1;
    property GridWidth: Integer read GetGridWidth;
    property HitTest: TPoint read FHitTest;
    property InplaceEditor: TbsSkinInplaceEdit read FInplaceEdit;
    property LeftCol: Longint read FTopLeft.X write SetLeftCol;
    property Options: TGridOptions read FOptions write SetOptions
      default [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine,
      goRangeSelect];
    property ParentColor default False;
    property Row: Longint read FCurrent.Y write SetRow;
    property RowCount: Longint read FRowCount write SetRowCount default 5;
    property RowHeights[Index: Longint]: Integer read GetRowHeights write SetRowHeights;
    property Selection: TGridRect read GetSelection write SetSelection;
    property TabStops[Index: Longint]: Boolean read GetTabStops write SetTabStops;
    property TopRow: Longint read FTopLeft.Y write SetTopRow;
    property VisibleColCount: Integer read GetVisibleColCount;
    property VisibleRowCount: Integer read GetVisibleRowCount;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure CMVisibleChanged(var Message: TMessage); message CM_VISIBLECHANGED;
  public
    // skin properties
    FixedCellRect, SelectCellRect, FocusCellRect: TRect;
    FixedCellLeftOffset, FixedCellRightOffset: Integer;
    FixedCellTextRect: TRect;
    CellLeftOffset, CellRightOffset: Integer;
    CellTextRect: TRect;
    LinesColor, BGColor: TColor;
    FontName: String;
    FontStyle: TFontStyles;
    FontHeight: Integer;
    FontColor, SelectFontColor, FocusFontColor: TColor;
    FixedFontName: String;
    FixedFontStyle: TFontStyles;
    FixedFontHeight: Integer;
    FixedFontColor: TColor;
    Picture: TBitMap;
    CellStretchEffect, FixedCellStretchEffect: Boolean;
    ShowFocus: Boolean;
    procedure ChangeSkinData; override;
    function GetNewTextRect(CellR: TRect; AState: TGridDrawState): TRect;
    //
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function MouseCoord(X, Y: Integer): TGridCoord;
  published
    property TabStop default True;
    property UseSkinFont: Boolean read FUseSkinFont write FUseSkinFont;
    property UseSkinCellHeight: Boolean read
      FUseSkinCellHeight write FUseSkinCellHeight;
    property HScrollBar: TbsSkinScrollBar read FHScrollBar
                                          write SetHScrollBar;
    property VScrollBar: TbsSkinScrollBar read FVScrollBar
                                          write SetVScrollBar;
    property GridLineColor: TColor read FGridLineColor write SetGridLineColor;
    property DefaultCellHeight: Integer read FDefaultCellHeight
                                        write SetDefaultCellHeight;
  end;

  { TbsSkinDrawGrid }

  TGetEditEvent = procedure (Sender: TObject; ACol, ARow: Longint; var Value: string) of object;
  TSetEditEvent = procedure (Sender: TObject; ACol, ARow: Longint; const Value: string) of object;
  TMovedEvent = procedure (Sender: TObject; FromIndex, ToIndex: Longint) of object;

  TbsSkinDrawGrid = class(TbsSkinCustomGrid)
  private
    FOnColumnMoved: TMovedEvent;
    FOnDrawCell: TDrawCellEvent;
    FOnGetEditMask: TGetEditEvent;
    FOnGetEditText: TGetEditEvent;
    FOnRowMoved: TMovedEvent;
    FOnSelectCell: TSelectCellEvent;
    FOnSetEditText: TSetEditEvent;
    FOnTopLeftChanged: TNotifyEvent;
  protected
    procedure ColumnMoved(FromIndex, ToIndex: Longint); override;
    procedure DrawCell(ACol, ARow: Longint; ARect: TRect;
      AState: TGridDrawState); override;
    function GetEditMask(ACol, ARow: Longint): string; override;
    function GetEditText(ACol, ARow: Longint): string; override;
    procedure RowMoved(FromIndex, ToIndex: Longint); override;
    function SelectCell(ACol, ARow: Longint): Boolean; override;
    procedure SetEditText(ACol, ARow: Longint; const Value: string); override;
    procedure TopLeftChanged; override;
  public
    function CellRect(ACol, ARow: Longint): TRect;
    procedure MouseToCell(X, Y: Integer; var ACol, ARow: Longint);
    property Canvas;
    property Col;
    property ColWidths;
    property EditorMode;
    property GridHeight;
    property GridWidth;
    property LeftCol;
    property Selection;
    property Row;
    property RowHeights;
    property TabStops;
    property TopRow;
  published
    property Align;
    property Anchors;
    property BiDiMode;
    property BorderStyle;
    property Color;
    property ColCount;
    property Constraints;
    property DefaultColWidth;
    property DefaultRowHeight;
    property DefaultDrawing;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property FixedColor;
    property FixedCols;
    property RowCount;
    property FixedRows;
    property Font;
    property GridLineWidth;
    property Options;
    property ParentBiDiMode;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property VisibleColCount;
    property VisibleRowCount;
    property OnClick;
    property OnColumnMoved: TMovedEvent read FOnColumnMoved write FOnColumnMoved;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawCell: TDrawCellEvent read FOnDrawCell write FOnDrawCell;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetEditMask: TGetEditEvent read FOnGetEditMask write FOnGetEditMask;
    property OnGetEditText: TGetEditEvent read FOnGetEditText write FOnGetEditText;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnRowMoved: TMovedEvent read FOnRowMoved write FOnRowMoved;
    property OnSelectCell: TSelectCellEvent read FOnSelectCell write FOnSelectCell;
    property OnSetEditText: TSetEditEvent read FOnSetEditText write FOnSetEditText;
    property OnStartDock;
    property OnStartDrag;
    property OnTopLeftChanged: TNotifyEvent read FOnTopLeftChanged write FOnTopLeftChanged;
  end;

  { TbsSkinStringGrid }

  TbsSkinStringGrid = class;

  TbsSkinStringGridStrings = class(TStrings)
  private
    FGrid: TbsSkinStringGrid;
    FIndex: Integer;
    procedure CalcXY(Index: Integer; var X, Y: Integer);
  protected
    function Get(Index: Integer): string; override;
    function GetCount: Integer; override;
    function GetObject(Index: Integer): TObject; override;
    procedure Put(Index: Integer; const S: string); override;
    procedure PutObject(Index: Integer; AObject: TObject); override;
    procedure SetUpdateState(Updating: Boolean); override;
  public
    constructor Create(AGrid: TbsSkinStringGrid; AIndex: Longint);
    function Add(const S: string): Integer; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear; override;
    procedure Delete(Index: Integer); override;
    procedure Insert(Index: Integer; const S: string); override;
  end;


  TbsSkinStringGrid = class(TbsSkinDrawGrid)
  private
    FData: Pointer;
    FRows: Pointer;
    FCols: Pointer;
    FUpdating: Boolean;
    FNeedsUpdating: Boolean;
    FEditUpdate: Integer;
    procedure DisableEditUpdate;
    procedure EnableEditUpdate;
    procedure Initialize;
    procedure Update(ACol, ARow: Integer); reintroduce;
    procedure SetUpdateState(Updating: Boolean);
    function GetCells(ACol, ARow: Integer): string;
    function GetCols(Index: Integer): TStrings;
    function GetObjects(ACol, ARow: Integer): TObject;
    function GetRows(Index: Integer): TStrings;
    procedure SetCells(ACol, ARow: Integer; const Value: string);
    procedure SetCols(Index: Integer; Value: TStrings);
    procedure SetObjects(ACol, ARow: Integer; Value: TObject);
    procedure SetRows(Index: Integer; Value: TStrings);
    function EnsureColRow(Index: Integer; IsCol: Boolean): TbsSkinStringGridStrings;
    function EnsureDataRow(ARow: Integer): Pointer;
  protected
    procedure ColumnMoved(FromIndex, ToIndex: Longint); override;
    procedure DrawCell(ACol, ARow: Longint; ARect: TRect;
      AState: TGridDrawState); override;
    function GetEditText(ACol, ARow: Longint): string; override;
    procedure SetEditText(ACol, ARow: Longint; const Value: string); override;
    procedure RowMoved(FromIndex, ToIndex: Longint); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Cells[ACol, ARow: Integer]: string read GetCells write SetCells;
    property Cols[Index: Integer]: TStrings read GetCols write SetCols;
    property Objects[ACol, ARow: Integer]: TObject read GetObjects write SetObjects;
    property Rows[Index: Integer]: TStrings read GetRows write SetRows;
  end;

implementation

uses Math, Consts, bsUtils, Clipbrd, bsConst;

type
  PIntArray = ^TIntArray;
  TIntArray = array[0..MaxCustomExtents] of Integer;

procedure InvalidOp(const id: string);
begin
  raise bsEInvalidGridOperation.Create(id);
end;

function GridRect(Coord1, Coord2: TGridCoord): TGridRect;
begin
  with Result do
  begin
    Left := Coord2.X;
    if Coord1.X < Coord2.X then Left := Coord1.X;
    Right := Coord1.X;
    if Coord1.X < Coord2.X then Right := Coord2.X;
    Top := Coord2.Y;
    if Coord1.Y < Coord2.Y then Top := Coord1.Y;
    Bottom := Coord1.Y;
    if Coord1.Y < Coord2.Y then Bottom := Coord2.Y;
  end;
end;

function PointInGridRect(Col, Row: Longint; const Rect: TGridRect): Boolean;
begin
  Result := (Col >= Rect.Left) and (Col <= Rect.Right) and (Row >= Rect.Top)
    and (Row <= Rect.Bottom);
end;

type
  TXorRects = array[0..3] of TRect;

procedure XorRects(const R1, R2: TRect; var XorRects: TXorRects);
var
  Intersect, Union: TRect;

  function PtInRect(X, Y: Integer; const Rect: TRect): Boolean;
  begin
    with Rect do Result := (X >= Left) and (X <= Right) and (Y >= Top) and
      (Y <= Bottom);
  end;

  function Includes(const P1: TPoint; var P2: TPoint): Boolean;
  begin
    with P1 do
    begin
      Result := PtInRect(X, Y, R1) or PtInRect(X, Y, R2);
      if Result then P2 := P1;
    end;
  end;

  function Build(var R: TRect; const P1, P2, P3: TPoint): Boolean;
  begin
    Build := True;
    with R do
      if Includes(P1, TopLeft) then
      begin
        if not Includes(P3, BottomRight) then BottomRight := P2;
      end
      else if Includes(P2, TopLeft) then BottomRight := P3
      else Build := False;
  end;

begin
  FillChar(XorRects, SizeOf(XorRects), 0);
  if not Bool(IntersectRect(Intersect, R1, R2)) then
  begin
    { Don't intersect so its simple }
    XorRects[0] := R1;
    XorRects[1] := R2;
  end
  else
  begin
    UnionRect(Union, R1, R2);
    if Build(XorRects[0],
      Point(Union.Left, Union.Top),
      Point(Union.Left, Intersect.Top),
      Point(Union.Left, Intersect.Bottom)) then
      XorRects[0].Right := Intersect.Left;
    if Build(XorRects[1],
      Point(Intersect.Left, Union.Top),
      Point(Intersect.Right, Union.Top),
      Point(Union.Right, Union.Top)) then
      XorRects[1].Bottom := Intersect.Top;
    if Build(XorRects[2],
      Point(Union.Right, Intersect.Top),
      Point(Union.Right, Intersect.Bottom),
      Point(Union.Right, Union.Bottom)) then
      XorRects[2].Left := Intersect.Right;
    if Build(XorRects[3],
      Point(Union.Left, Union.Bottom),
      Point(Intersect.Left, Union.Bottom),
      Point(Intersect.Right, Union.Bottom)) then
      XorRects[3].Top := Intersect.Bottom;
  end;
end;

procedure ModifyExtents(var Extents: Pointer; Index, Amount: Longint;
  Default: Integer);
var
  LongSize, OldSize: LongInt;
  NewSize: Integer;
  I: Integer;
begin
  if Amount <> 0 then
  begin
    if not Assigned(Extents) then OldSize := 0
    else OldSize := PIntArray(Extents)^[0];
    if (Index < 0) or (OldSize < Index) then InvalidOp(SIndexOutOfRange);
    LongSize := OldSize + Amount;
    if LongSize < 0 then InvalidOp(STooManyDeleted)
    else if LongSize >= MaxListSize - 1 then InvalidOp(SGridTooLarge);
    NewSize := Cardinal(LongSize);
    if NewSize > 0 then Inc(NewSize);
    ReallocMem(Extents, NewSize * SizeOf(Integer));
    if Assigned(Extents) then
    begin
      I := Index + 1;
      while I < NewSize do
      begin
        PIntArray(Extents)^[I] := Default;
        Inc(I);
      end;
      PIntArray(Extents)^[0] := NewSize-1;
    end;
  end;
end;

procedure UpdateExtents(var Extents: Pointer; NewSize: Longint;
  Default: Integer);
var
  OldSize: Integer;
begin
  OldSize := 0;
  if Assigned(Extents) then OldSize := PIntArray(Extents)^[0];
  ModifyExtents(Extents, OldSize, NewSize - OldSize, Default);
end;

procedure MoveExtent(var Extents: Pointer; FromIndex, ToIndex: Longint);
var
  Extent: Integer;
begin
  if Assigned(Extents) then
  begin
    Extent := PIntArray(Extents)^[FromIndex];
    if FromIndex < ToIndex then
      Move(PIntArray(Extents)^[FromIndex + 1], PIntArray(Extents)^[FromIndex],
        (ToIndex - FromIndex) * SizeOf(Integer))
    else if FromIndex > ToIndex then
      Move(PIntArray(Extents)^[ToIndex], PIntArray(Extents)^[ToIndex + 1],
        (FromIndex - ToIndex) * SizeOf(Integer));
    PIntArray(Extents)^[ToIndex] := Extent;
  end;
end;

function CompareExtents(E1, E2: Pointer): Boolean;
var
  I: Integer;
begin
  Result := False;
  if E1 <> nil then
  begin
    if E2 <> nil then
    begin
      for I := 0 to PIntArray(E1)^[0] do
        if PIntArray(E1)^[I] <> PIntArray(E2)^[I] then Exit;
      Result := True;
    end
  end
  else Result := E2 = nil;
end;

function LongMulDiv(Mult1, Mult2, Div1: Longint): Longint; stdcall;
  external 'kernel32.dll' name 'MulDiv';

type
  TSelection = record
    StartPos, EndPos: Integer;
  end;

constructor TbsSkinInplaceEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ParentCtl3D := False;
  Ctl3D := False;
  TabStop := False;
  BorderStyle := bsNone;
  FSysPopupMenu := nil;
end;

destructor TbsSkinInplaceEdit.Destroy;
begin
  if FSysPopupMenu <> nil then FSysPopupMenu.Free;
  inherited;
end;

procedure TbsSkinInplaceEdit.WMCONTEXTMENU;
var
  X, Y: Integer;
  P: TPoint;
begin
  if PopupMenu <> nil
  then
    inherited
  else
    begin
      CreateSysPopupMenu;
      X := Message.XPos;
      Y := Message.YPos;
      if (X < 0) or (Y < 0)
      then
        begin
          X := Width div 2;
          Y := Height div 2;
          P := Point(0, 0);
          P := ClientToScreen(P);
          X := X + P.X;
          Y := Y + P.Y;
        end;
      if FSysPopupMenu <> nil
      then
        FSysPopupMenu.Popup2(Self, X, Y)
    end;
end;

procedure TbsSkinInplaceEdit.WMAFTERDISPATCH;
begin
  if FSysPopupMenu <> nil
  then
    begin
      FSysPopupMenu.Free;
      FSysPopupMenu := nil;
    end;
end;

procedure TbsSkinInplaceEdit.DoUndo;
begin
  Undo;
end;

procedure TbsSkinInplaceEdit.DoCut;
begin
  CutToClipboard;
end;

procedure TbsSkinInplaceEdit.DoCopy;
begin
  CopyToClipboard;
end;

procedure TbsSkinInplaceEdit.DoPaste;
begin
  PasteFromClipboard;
end;

procedure TbsSkinInplaceEdit.DoDelete;
begin
  ClearSelection;
end;

procedure TbsSkinInplaceEdit.DoSelectAll;
begin
  SelectAll;
end;

procedure TbsSkinInplaceEdit.CreateSysPopupMenu;

function IsSelected: Boolean;
var
  i, j: Integer;
begin
  GetSel(i, j);
  Result := (i < j);
end;

function IsFullSelected: Boolean;
var
  i, j: Integer;
begin
  GetSel(i, j);
  Result := (i = 0) and (j = Length(Text));
end;

var
  Item: TMenuItem;
begin
  if FSysPopupMenu <> nil then FSysPopupMenu.Free;

  FSysPopupMenu := TbsSkinPopupMenu.Create(Self);
  FSysPopupMenu.ComponentForm := TForm(GetParentForm(Self));

  Item := TMenuItem.Create(FSysPopupMenu);
  with Item do
  begin
    if (FGrid.SkinData <> nil) and (FGrid.SkinData.ResourceStrData <> nil)
    then
      Caption := FGrid.SkinData.ResourceStrData.GetResStr('EDIT_UNDO')
    else
      Caption := BS_Edit_Undo;
    OnClick := DoUndo;
    Enabled := Self.CanUndo;
  end;
  FSysPopupMenu.Items.Add(Item);

  Item := TMenuItem.Create(FSysPopupMenu);
  Item.Caption := '-';
  FSysPopupMenu.Items.Add(Item);

  Item := TMenuItem.Create(FSysPopupMenu);
  with Item do
  begin
    if (FGrid.SkinData <> nil) and (FGrid.SkinData.ResourceStrData <> nil)
    then
      Caption := FGrid.SkinData.ResourceStrData.GetResStr('EDIT_CUT')
    else
      Caption := BS_Edit_Cut;
    Enabled := IsSelected and not Self.ReadOnly;
    OnClick := DoCut;
  end;
  FSysPopupMenu.Items.Add(Item);

  Item := TMenuItem.Create(FSysPopupMenu);
  with Item do
  begin
    if (FGrid.SkinData <> nil) and (FGrid.SkinData.ResourceStrData <> nil)
    then
      Caption := FGrid.SkinData.ResourceStrData.GetResStr('EDIT_COPY')
    else
      Caption := BS_Edit_Copy;
    Enabled := IsSelected;
    OnClick := DoCopy;
  end;
  FSysPopupMenu.Items.Add(Item);

  Item := TMenuItem.Create(FSysPopupMenu);
  with Item do
  begin
    if (FGrid.SkinData <> nil) and (FGrid.SkinData.ResourceStrData <> nil)
    then
      Caption := FGrid.SkinData.ResourceStrData.GetResStr('EDIT_PASTE')
    else
      Caption := BS_Edit_Paste;
    Enabled := (ClipBoard.AsText <> '') and not ReadOnly;
    OnClick := DoPaste;
  end;
  FSysPopupMenu.Items.Add(Item);

  Item := TMenuItem.Create(FSysPopupMenu);
  with Item do
  begin
    if (FGrid.SkinData <> nil) and (FGrid.SkinData.ResourceStrData <> nil)
    then
      Caption := FGrid.SkinData.ResourceStrData.GetResStr('EDIT_DELETE')
    else
      Caption := BS_Edit_Delete;
    Enabled := IsSelected and not Self.ReadOnly;
    OnClick := DoDelete;
  end;
  FSysPopupMenu.Items.Add(Item);

  Item := TMenuItem.Create(FSysPopupMenu);
  Item.Caption := '-';
  FSysPopupMenu.Items.Add(Item);

  Item := TMenuItem.Create(FSysPopupMenu);
  with Item do
  begin
     if (FGrid.SkinData <> nil) and (FGrid.SkinData.ResourceStrData <> nil)
    then
      Caption := FGrid.SkinData.ResourceStrData.GetResStr('EDIT_SELECTALL')
    else
      Caption := BS_Edit_SelectAll;
    Enabled := not IsFullSelected;
    OnClick := DoSelectAll;
  end;
  FSysPopupMenu.Items.Add(Item);
end;


procedure TbsSkinInplaceEdit.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or ES_MULTILINE;
end;

procedure TbsSkinInplaceEdit.SetGrid(Value: TbsSkinCustomGrid);
begin
  FGrid := Value;
end;

procedure TbsSkinInplaceEdit.CMShowingChanged(var Message: TMessage);
begin
end;

procedure TbsSkinInplaceEdit.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  inherited;
  if goTabs in Grid.Options then
    Message.Result := Message.Result or DLGC_WANTTAB;
end;

procedure TbsSkinInplaceEdit.WMPaste(var Message);
begin
  if not EditCanModify then Exit;
  inherited
end;

procedure TbsSkinInplaceEdit.WMClear(var Message);
begin
  if not EditCanModify then Exit;
  inherited;
end;

procedure TbsSkinInplaceEdit.WMCut(var Message);
begin
  if not EditCanModify then Exit;
  inherited;
end;

procedure TbsSkinInplaceEdit.DblClick;
begin
  Grid.DblClick;
end;

function TbsSkinInplaceEdit.EditCanModify: Boolean;
begin
  Result := Grid.CanEditModify;
end;

procedure TbsSkinInplaceEdit.KeyDown(var Key: Word; Shift: TShiftState);

  procedure SendToParent;
  begin
    Grid.KeyDown(Key, Shift);
    Key := 0;
  end;

  procedure ParentEvent;
  var
    GridKeyDown: TKeyEvent;
  begin
    GridKeyDown := Grid.OnKeyDown;
    if Assigned(GridKeyDown) then GridKeyDown(Grid, Key, Shift);
  end;

  function ForwardMovement: Boolean;
  begin
    Result := goAlwaysShowEditor in Grid.Options;
  end;

  function Ctrl: Boolean;
  begin
    Result := ssCtrl in Shift;
  end;

  function Selection: TSelection;
  begin
    SendMessage(Handle, EM_GETSEL, Longint(@Result.StartPos), Longint(@Result.EndPos));
  end;

  function RightSide: Boolean;
  begin
    with Selection do
      Result := ((StartPos = 0) or (EndPos = StartPos)) and
        (EndPos = GetTextLen);
   end;

  function LeftSide: Boolean;
  begin
    with Selection do
      Result := (StartPos = 0) and ((EndPos = 0) or (EndPos = GetTextLen));
  end;

begin
  case Key of
    VK_UP, VK_DOWN, VK_PRIOR, VK_NEXT, VK_ESCAPE: SendToParent;
    VK_INSERT:
      if Shift = [] then SendToParent
      else if (Shift = [ssShift]) and not Grid.CanEditModify then Key := 0;
    VK_LEFT: if ForwardMovement and (Ctrl or LeftSide) then SendToParent;
    VK_RIGHT: if ForwardMovement and (Ctrl or RightSide) then SendToParent;
    VK_HOME: if ForwardMovement and (Ctrl or LeftSide) then SendToParent;
    VK_END: if ForwardMovement and (Ctrl or RightSide) then SendToParent;
    VK_F2:
      begin
        ParentEvent;
        if Key = VK_F2 then
        begin
          Deselect;
          Exit;
        end;
      end;
    VK_TAB: if not (ssAlt in Shift) then SendToParent;
  end;
  if (Key = VK_DELETE) and not Grid.CanEditModify then Key := 0;
  if Key <> 0 then
  begin
    ParentEvent;
    inherited KeyDown(Key, Shift);
  end;
end;

procedure TbsSkinInplaceEdit.KeyPress(var Key: Char);
var
  Selection: TSelection;
begin
  Grid.KeyPress(Key);
  if (Key in [#32..#255]) and not Grid.CanEditAcceptKey(Key) then
  begin
    Key := #0;
    MessageBeep(0);
  end;
  case Key of
    #9, #27: Key := #0;
    #13:
      begin
        SendMessage(Handle, EM_GETSEL, Longint(@Selection.StartPos), Longint(@Selection.EndPos));
        if (Selection.StartPos = 0) and (Selection.EndPos = GetTextLen) then
          Deselect else
          SelectAll;
        Key := #0;
      end;
    ^H, ^V, ^X, #32..#255:
      if not Grid.CanEditModify then Key := #0;
  end;
  if Key <> #0 then inherited KeyPress(Key);
end;

procedure TbsSkinInplaceEdit.KeyUp(var Key: Word; Shift: TShiftState);
begin
  Grid.KeyUp(Key, Shift);
end;

procedure TbsSkinInplaceEdit.WndProc(var Message: TMessage);
var
  FOld: Boolean;
begin
  FOld := True;
  case Message.Msg of
    WM_SETFOCUS:
      begin
        if (GetParentForm(Self) = nil) or GetParentForm(Self).SetFocusedControl(Grid) then Dispatch(Message);
        Exit;
      end;
    WM_LBUTTONDOWN:
      begin
        if ((GetMessageTime - FClickTime) < GetDoubleClickTime) then
          Message.Msg := WM_LBUTTONDBLCLK;
        FClickTime := 0;
      end;
  end;
  if FOld then inherited WndProc(Message);
end;

procedure TbsSkinInplaceEdit.Deselect;
begin
  SendMessage(Handle, EM_SETSEL, $7FFFFFFF, Longint($FFFFFFFF));
end;

procedure TbsSkinInplaceEdit.Invalidate;
var
  Cur: TRect;
begin
  ValidateRect(Handle, nil);
  InvalidateRect(Handle, nil, True);
  Windows.GetClientRect(Handle, Cur);
  MapWindowPoints(Handle, Grid.Handle, Cur, 2);
  ValidateRect(Grid.Handle, @Cur);
  InvalidateRect(Grid.Handle, @Cur, False);
end;

procedure TbsSkinInplaceEdit.Hide;
begin
  if HandleAllocated and IsWindowVisible(Handle) then
  begin
    Invalidate;
    SetWindowPos(Handle, 0, 0, 0, 0, 0, SWP_HIDEWINDOW or SWP_NOZORDER or
      SWP_NOREDRAW);
    if Focused then Windows.SetFocus(Grid.Handle);
  end;
end;

function TbsSkinInplaceEdit.PosEqual(const Rect: TRect): Boolean;
var
  Cur: TRect;
begin
  GetWindowRect(Handle, Cur);
  MapWindowPoints(HWND_DESKTOP, Grid.Handle, Cur, 2);
  Result := EqualRect(Rect, Cur);
end;

procedure TbsSkinInplaceEdit.InternalMove(const Loc: TRect; Redraw: Boolean);
begin
  if IsRectEmpty(Loc) then Hide
  else
  begin
    CreateHandle;
    Redraw := Redraw or not IsWindowVisible(Handle);
    Invalidate;
    with Loc do
      SetWindowPos(Handle, HWND_TOP, Left, Top, Right - Left, Bottom - Top,
        SWP_SHOWWINDOW or SWP_NOREDRAW);
    BoundsChanged;
    if Redraw then Invalidate;
    if Grid.Focused then
      Windows.SetFocus(Handle);
  end;
end;

procedure TbsSkinInplaceEdit.BoundsChanged;
var
  R: TRect;
begin
  R := Rect(2, 2, Width - 2, Height);
  SendMessage(Handle, EM_SETRECTNP, 0, LongInt(@R));
  SendMessage(Handle, EM_SCROLLCARET, 0, 0);
end;

procedure TbsSkinInplaceEdit.UpdateLoc(const Loc: TRect);
begin
  InternalMove(Loc, False);
end;

function TbsSkinInplaceEdit.Visible: Boolean;
begin
  Result := IsWindowVisible(Handle);
end;

procedure TbsSkinInplaceEdit.Move(const Loc: TRect);
begin
  InternalMove(Loc, True);
end;

procedure TbsSkinInplaceEdit.SetFocus;
begin
  if IsWindowVisible(Handle) then
    Windows.SetFocus(Handle);
end;

procedure TbsSkinInplaceEdit.UpdateContents;
begin
  Text := '';
  EditMask := Grid.GetEditMask(Grid.Col, Grid.Row);
  Text := Grid.GetEditText(Grid.Col, Grid.Row);
  MaxLength := Grid.GetEditLimit;
end;

{ TbsSkinCustomGrid }

constructor TbsSkinCustomGrid.Create(AOwner: TComponent);
const
  GridStyle = [csCaptureMouse, csOpaque, csDoubleClicks];
begin
  inherited Create(AOwner);
  FHScrollBar := nil;
  FVScrollBar := nil;
  FUseSkinCellHeight := True;
  FUseSkinFont := False;
  Ctl3D := False;
  if NewStyleControls then
    ControlStyle := GridStyle else
    ControlStyle := GridStyle + [csFramed];
  FCanEditModify := True;
  FColCount := 5;
  FRowCount := 5;
  FFixedCols := 1;
  FFixedRows := 1;
  FGridLineWidth := 1;
  FOptions := [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine,
    goRangeSelect];
  DesignOptionsBoost := [goColSizing, goRowSizing];
  FFixedColor := clBtnFace;
  FBorderStyle := bsSingle;
  FDefaultColWidth := 64;
  FDefaultRowHeight := 20;
  FDefaultCellHeight := 20;
  FDefaultDrawing := True;
  FSaveCellExtents := True;
  FEditorMode := False;
  Picture := nil;
  Color := clWindow;
  ParentColor := False;
  TabStop := True;
  SetBounds(Left, Top, FColCount * FDefaultColWidth,
    FRowCount * FDefaultRowHeight);
  Initialize;
  FSkinDataName := 'grid';
  FGridLineColor := clWindowText;
  FInCheckScrollBars := False;
end;

destructor TbsSkinCustomGrid.Destroy;
begin
  FInplaceEdit.Free;
  inherited Destroy;
  FreeMem(FColWidths);
  FreeMem(FRowHeights);
  FreeMem(FTabStops);
end;

procedure TbsSkinCustomGrid.CMVisibleChanged;
begin
  inherited;
  if FVScrollBar <> nil then FVScrollBar.Visible := Self.Visible;
  if FHScrollBar <> nil then FHScrollBar.Visible := Self.Visible; 
end;

procedure TbsSkinCustomGrid.SetDefaultCellHeight(Value: Integer);
begin
  FDefaultCellHeight := Value;
  if FIndex = -1 then DefaultRowHeight := FDefaultCellHeight;
end;

procedure TbsSkinCustomGrid.SetGridLineColor;
begin
  FGridLineColor := Value;
  if FIndex = -1 then RePaint; 
end;

procedure TbsSkinCustomGrid.Notification;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FHScrollBar)
  then FHScrollBar := nil;
  if (Operation = opRemove) and (AComponent = FVScrollBar)
  then FVScrollBar := nil;
end;

procedure TbsSkinCustomGrid.SetHScrollBar;
begin
  FHScrollBar := Value;
  if FHScrollBar <> nil
  then
    begin
      FHScrollBar.Enabled := True;
      FHScrollBar.Visible := False;
      if goThumbTracking in Options
      then
        FHScrollBar.OnChange := OnHScrollBarChange
      else
        FHScrollBar.OnLastChange := OnHScrollBarChange;
      FHScrollBar.OnUpButtonClick := OnHScrollBarUpButtonClick;
      FHScrollBar.OnDownButtonClick := OnHScrollBarDownButtonClick;
      FHScrollBar.OnPageUp := OnHScrollBarPageUp;
      FHScrollBar.OnPageDown := OnHScrollBarPageDown;
      UpdateScrollRange(True);
    end;
end;

procedure TbsSkinCustomGrid.SetVScrollBar;
begin
  FVScrollBar := Value;
  if FVScrollBar <> nil
  then
    begin
      FVScrollBar.Enabled := True;
      FVScrollBar.Visible := False;
      if goThumbTracking in Options
      then
        FVScrollBar.OnChange := OnVScrollBarChange
      else
        FVScrollBar.OnLastChange := OnVScrollBarChange;
      FVScrollBar.OnUpButtonClick := OnVScrollBarUpButtonClick;
      FVScrollBar.OnDownButtonClick := OnVScrollBarDownButtonClick;
      FVScrollBar.OnPageUp := OnVScrollBarPageUp;
      FVScrollBar.OnPageDown := OnVScrollBarPageDown;
      UpdateScrollRange(True);
    end;  
end;

procedure TbsSkinCustomGrid.OnVScrollBarUpButtonClick(Sender: TObject);
begin
  SendMessage(Handle, WM_VSCROLL,
    MakeWParam(SB_LINEDOWN, VScrollBar.Position), 0);
end;

procedure TbsSkinCustomGrid.OnVScrollBarDownButtonClick(Sender: TObject);
begin
  SendMessage(Handle, WM_VSCROLL,
    MakeWParam(SB_LINEUP, VScrollBar.Position), 0);
end;

procedure TbsSkinCustomGrid.OnHScrollBarUpButtonClick(Sender: TObject);
begin
  FHScrollBar.Position := FHScrollBar.Position + FHScrollBar.SmallChange;
  SendMessage(Handle, WM_HSCROLL,
    MakeWParam(SB_THUMBPOSITION, FHScrollBar.Position), 0);
end;

procedure TbsSkinCustomGrid.OnHScrollBarDownButtonClick(Sender: TObject);
begin
  FHScrollBar.Position := FHScrollBar.Position - FHScrollBar.SmallChange;
  SendMessage(Handle, WM_HSCROLL,
    MakeWParam(SB_THUMBPOSITION, FHScrollBar.Position), 0);
end;

procedure TbsSkinCustomGrid.OnVScrollBarPageUp(Sender: TObject);
begin
  SendMessage(Handle, WM_VSCROLL,
  MakeWParam(SB_PAGEUP, 0), 0);
end;

procedure TbsSkinCustomGrid.OnVScrollBarPageDown(Sender: TObject);
begin
  SendMessage(Handle, WM_VSCROLL,
  MakeWParam(SB_PAGEDOWN, 0), 0);
end;

procedure TbsSkinCustomGrid.OnHScrollBarPageUp(Sender: TObject);
begin
  SendMessage(Handle, WM_HSCROLL,
  MakeWParam(SB_PAGEUP, 0), 0);
end;

procedure TbsSkinCustomGrid.OnHScrollBarPageDown(Sender: TObject);
begin
  SendMessage(Handle, WM_HSCROLL,
  MakeWParam(SB_PAGEDOWN, 0), 0);
end;

procedure TbsSkinCustomGrid.OnVScrollBarChange(Sender: TObject);
begin
  SendMessage(Handle, WM_VSCROLL,
  MakeWParam(SB_THUMBPOSITION, FVScrollBar.Position), 0);
end;

procedure TbsSkinCustomGrid.OnHScrollBarChange(Sender: TObject);
begin
  SendMessage(Handle, WM_HSCROLL,
  MakeWParam(SB_THUMBPOSITION, FHScrollBar.Position), 0);
end;

function TbsSkinCustomGrid.GetNewTextRect;
var
  SR1, SR2, R: TRect;
  OX, OY: Integer;
begin
  if FIndex < 0
  then
    begin
      Result := CellR;
      Exit;
    end
  else
    begin
      R := CellR;
      if gdFixed in AState
      then
        begin
          SR1 := FixedCellRect;
          SR2 := FixedCellTextRect;
        end
      else
        begin
          SR1 := SelectCellRect;
          SR2 := CellTextRect;
        end;

      if not IsNullRect(SR2)
      then
        begin
          if not UseSkinCellHeight
          then
            OY := RectHeight(R) - RectHeight(FixedCellRect)
          else
            OY := 0;  
          OX := RectWidth(CellR) - RectWidth(SR1);
          Inc(R.Left, SR2.Left);
          Inc(R.Top, SR2.Top);
          R.Right := R.Left + RectWidth(SR2) + OX;
          R.Bottom := R.Top + RectHeight(SR2) + OY;
        end;
      Result := R;
    end
end;

procedure TbsSkinCustomGrid.ChangeSkinData;
var
  i, Old: Integer;
begin
  GetSkinData;
  if FIndex > -1
  then
    begin
      Old := DefaultRowHeight;
      i := RectHeight(SelectCellRect);
      if (i <> Old) and FUseSkinCellHeight
      then
        DefaultRowHeight := i
      else
        Invalidate;
    end
  else
    begin
      DefaultRowHeight := FDefaultCellHeight;
      Invalidate;
    end;
  UpDateScrollRange(True);
  if FVScrollBar <> nil then FVScrollBar.Align := FVScrollBar.Align;
  if FHScrollBar <> nil then FHScrollBar.Align := FHScrollBar.Align;
end;

procedure TbsSkinCustomGrid.GetSkinData;
begin
  Picture := nil;
  FIndex := -1;
  inherited;
  if FIndex > -1
  then
    if TbsDataSkinControl(FSD.CtrlList.Items[FIndex]) is TbsDataSkinGridControl
    then
      with TbsDataSkinGridControl(FSD.CtrlList.Items[FIndex]) do
      begin
        //
        if (PictureIndex <> -1) and (PictureIndex < FSD.FActivePictures.Count)
        then
          Picture := TBitMap(FSD.FActivePictures.Items[PictureIndex])
        else
          Picture := nil;
        //
        Self.FixedCellRect := FixedCellRect;
        Self.SelectCellRect := SelectCellRect;
        Self.FocusCellRect := FocusCellRect;
        Self.FixedCellLeftOffset := FixedCellLeftOffset;
        Self.FixedCellRightOffset := FixedCellRightOffset;
        Self.FixedCellTextRect := FixedCellTextRect;
        Self.CellLeftOffset := CellLeftOffset;
        Self.CellRightOffset := CellRightOffset;
        Self.CellTextRect := CellTextRect;
        Self.LinesColor := LinesColor;
        Self.BGColor := BGColor;
        //
        Self.FontName := FontName;
        Self.FontStyle := FontStyle;
        Self.FontHeight := FontHeight;
        Self.FontColor := FontColor;
        Self.SelectFontColor := SelectFontColor;
        Self.FocusFontColor := FocusFontColor;
        Self.FixedFontName := FixedFontName;
        Self.FixedFontStyle := FixedFontStyle;
        Self.FixedFontHeight := FixedFontHeight;
        Self.FixedFontColor := FixedFontColor;
        Self.CellStretchEffect := CellStretchEffect;
        Self.FixedCellStretchEffect := FixedCellStretchEffect;
        Self.ShowFocus := ShowFocus;

        if IsNullRect(Self.SelectCellRect)
        then
          Self.SelectCellRect := Self.FocusCellRect; 
        if IsNullRect(Self.FocusCellRect)
        then
          Self.FocusCellRect := Self.SelectCellRect;

        if IsNullRect(Self.FixedCellRect)
        then
          begin
            FIndex := -1;
            Picture := nil;
          end;
          
      end;
end;

procedure TbsSkinCustomGrid.AdjustSize(Index, Amount: Longint; Rows: Boolean);
var
  NewCur: TGridCoord;
  OldRows, OldCols: Longint;
  MovementX, MovementY: Longint;
  MoveRect: TGridRect;
  ScrollArea: TRect;
  AbsAmount: Longint;

  function DoSizeAdjust(var Count: Longint; var Extents: Pointer;
    DefaultExtent: Integer; var Current: Longint): Longint;
  var
    I: Integer;
    NewCount: Longint;
  begin
    NewCount := Count + Amount;
    if NewCount < Index then InvalidOp(STooManyDeleted);
    if (Amount < 0) and Assigned(Extents) then
    begin
      Result := 0;
      for I := Index to Index - Amount - 1 do
        Inc(Result, PIntArray(Extents)^[I]);
    end
    else
      Result := Amount * DefaultExtent;
    if Extents <> nil then
      ModifyExtents(Extents, Index, Amount, DefaultExtent);
    Count := NewCount;
    if Current >= Index then
      if (Amount < 0) and (Current < Index - Amount) then Current := Index
      else Inc(Current, Amount);
  end;

begin
  if Amount = 0 then Exit;
  NewCur := FCurrent;
  OldCols := ColCount;
  OldRows := RowCount;
  MoveRect.Left := FixedCols;
  MoveRect.Right := ColCount - 1;
  MoveRect.Top := FixedRows;
  MoveRect.Bottom := RowCount - 1;
  MovementX := 0;
  MovementY := 0;
  AbsAmount := Amount;
  if AbsAmount < 0 then AbsAmount := -AbsAmount;
  if Rows then
  begin
    MovementY := DoSizeAdjust(FRowCount, FRowHeights, DefaultRowHeight, NewCur.Y);
    MoveRect.Top := Index;
    if Index + AbsAmount <= TopRow then MoveRect.Bottom := TopRow - 1;
  end
  else
  begin
    MovementX := DoSizeAdjust(FColCount, FColWidths, DefaultColWidth, NewCur.X);
    MoveRect.Left := Index;
    if Index + AbsAmount <= LeftCol then MoveRect.Right := LeftCol - 1;
  end;
  GridRectToScreenRect(MoveRect, ScrollArea, True);
  if not IsRectEmpty(ScrollArea) then
  begin
    ScrollWindow(Handle, MovementX, MovementY, @ScrollArea, @ScrollArea);
    UpdateWindow(Handle);
  end;
  SizeChanged(OldCols, OldRows);
  if (NewCur.X <> FCurrent.X) or (NewCur.Y <> FCurrent.Y) then
    MoveCurrent(NewCur.X, NewCur.Y, True, True);
end;

function TbsSkinCustomGrid.BoxRect(ALeft, ATop, ARight, ABottom: Longint): TRect;
var
  GridRect: TGridRect;
begin
  GridRect.Left := ALeft;
  GridRect.Right := ARight;
  GridRect.Top := ATop;
  GridRect.Bottom := ABottom;
  GridRectToScreenRect(GridRect, Result, False);
end;

procedure TbsSkinCustomGrid.DoExit;
begin
  inherited DoExit;
  if not (goAlwaysShowEditor in Options) then HideEditor;
end;

function TbsSkinCustomGrid.CellRect(ACol, ARow: Longint): TRect;
begin
  Result := BoxRect(ACol, ARow, ACol, ARow);
end;

function TbsSkinCustomGrid.CanEditAcceptKey(Key: Char): Boolean;
begin
  Result := True;
end;

function TbsSkinCustomGrid.CanGridAcceptKey(Key: Word; Shift: TShiftState): Boolean;
begin
  Result := True;
end;

function TbsSkinCustomGrid.CanEditModify: Boolean;
begin
  Result := FCanEditModify;
end;

function TbsSkinCustomGrid.CanEditShow: Boolean;
begin
  Result := ([goRowSelect, goEditing] * Options = [goEditing]) and
    FEditorMode and not (csDesigning in ComponentState) and HandleAllocated and
    ((goAlwaysShowEditor in Options) or IsActiveControl);
end;

function TbsSkinCustomGrid.IsActiveControl: Boolean;
var
  H: Hwnd;
  ParentForm: TCustomForm;
begin
  Result := False;
  ParentForm := GetParentForm(Self);
  if Assigned(ParentForm) then
  begin
    if (ParentForm.ActiveControl = Self) then
      Result := True
  end
  else
  begin
    H := GetFocus;
    while IsWindow(H) and (Result = False) do
    begin
      if H = WindowHandle then
        Result := True
      else
        H := GetParent(H);
    end;
  end;
end;

function TbsSkinCustomGrid.GetEditMask(ACol, ARow: Longint): string;
begin
  Result := '';
end;

function TbsSkinCustomGrid.GetEditText(ACol, ARow: Longint): string;
begin
  Result := '';
end;

procedure TbsSkinCustomGrid.SetEditText(ACol, ARow: Longint; const Value: string);
begin
end;

function TbsSkinCustomGrid.GetEditLimit: Integer;
begin
  Result := 0;
end;

procedure TbsSkinCustomGrid.HideEditor;
begin
  FEditorMode := False;
  HideEdit;
end;

procedure TbsSkinCustomGrid.ShowEditor;
begin
  FEditorMode := True;
  UpdateEdit;
end;

procedure TbsSkinCustomGrid.ShowEditorChar(Ch: Char);
begin
  ShowEditor;
  if FInplaceEdit <> nil then
    PostMessage(FInplaceEdit.Handle, WM_CHAR, Word(Ch), 0);
end;

procedure TbsSkinCustomGrid.InvalidateEditor;
begin
  FInplaceCol := -1;
  FInplaceRow := -1;
  UpdateEdit;
end;

procedure TbsSkinCustomGrid.ReadColWidths(Reader: TReader);
var
  I: Integer;
begin
  with Reader do
  begin
    ReadListBegin;
    for I := 0 to ColCount - 1 do ColWidths[I] := ReadInteger;
    ReadListEnd;
  end;
end;

procedure TbsSkinCustomGrid.ReadRowHeights(Reader: TReader);
var
  I: Integer;
begin
  with Reader do
  begin
    ReadListBegin;
    for I := 0 to RowCount - 1 do RowHeights[I] := ReadInteger;
    ReadListEnd;
  end;
end;

procedure TbsSkinCustomGrid.WriteColWidths(Writer: TWriter);
var
  I: Integer;
begin
  with Writer do
  begin
    WriteListBegin;
    for I := 0 to ColCount - 1 do WriteInteger(ColWidths[I]);
    WriteListEnd;
  end;
end;

procedure TbsSkinCustomGrid.WriteRowHeights(Writer: TWriter);
var
  I: Integer;
begin
  with Writer do
  begin
    WriteListBegin;
    for I := 0 to RowCount - 1 do WriteInteger(RowHeights[I]);
    WriteListEnd;
  end;
end;

procedure TbsSkinCustomGrid.DefineProperties(Filer: TFiler);

  function DoColWidths: Boolean;
  begin
    if Filer.Ancestor <> nil then
      Result := not CompareExtents(TbsSkinCustomGrid(Filer.Ancestor).FColWidths, FColWidths)
    else
      Result := FColWidths <> nil;
  end;

  function DoRowHeights: Boolean;
  begin
    if Filer.Ancestor <> nil then
      Result := not CompareExtents(TbsSkinCustomGrid(Filer.Ancestor).FRowHeights, FRowHeights)
    else
      Result := FRowHeights <> nil;
  end;


begin
  inherited DefineProperties(Filer);
  if FSaveCellExtents then
    with Filer do
    begin
      DefineProperty('ColWidths', ReadColWidths, WriteColWidths, DoColWidths);
      DefineProperty('RowHeights', ReadRowHeights, WriteRowHeights, DoRowHeights);
    end;
end;

procedure TbsSkinCustomGrid.MoveColumn(FromIndex, ToIndex: Longint);
var
  Rect: TGridRect;
begin
  if FromIndex = ToIndex then Exit;
  if Assigned(FColWidths) then
  begin
    MoveExtent(FColWidths, FromIndex + 1, ToIndex + 1);
    MoveExtent(FTabStops, FromIndex + 1, ToIndex + 1);
  end;
  MoveAdjust(FCurrent.X, FromIndex, ToIndex);
  MoveAdjust(FAnchor.X, FromIndex, ToIndex);
  MoveAdjust(FInplaceCol, FromIndex, ToIndex);
  Rect.Top := 0;
  Rect.Bottom := VisibleRowCount;
  if FromIndex < ToIndex then
  begin
    Rect.Left := FromIndex;
    Rect.Right := ToIndex;
  end
  else
  begin
    Rect.Left := ToIndex;
    Rect.Right := FromIndex;
  end;
  InvalidateRect(Rect);
  ColumnMoved(FromIndex, ToIndex);
  if Assigned(FColWidths) then
    ColWidthsChanged;
  UpdateEdit;
end;

procedure TbsSkinCustomGrid.ColumnMoved(FromIndex, ToIndex: Longint);
begin
end;

procedure TbsSkinCustomGrid.MoveRow(FromIndex, ToIndex: Longint);
begin
  if Assigned(FRowHeights) then
    MoveExtent(FRowHeights, FromIndex + 1, ToIndex + 1);
  MoveAdjust(FCurrent.Y, FromIndex, ToIndex);
  MoveAdjust(FAnchor.Y, FromIndex, ToIndex);
  MoveAdjust(FInplaceRow, FromIndex, ToIndex);
  RowMoved(FromIndex, ToIndex);
  if Assigned(FRowHeights) then
    RowHeightsChanged;
  UpdateEdit;
end;

procedure TbsSkinCustomGrid.RowMoved(FromIndex, ToIndex: Longint);
begin
end;

function TbsSkinCustomGrid.MouseCoord(X, Y: Integer): TGridCoord;
var
  DrawInfo: TbsGridDrawInfo;
begin
  CalcDrawInfo(DrawInfo);
  Result := CalcCoordFromPoint(X, Y, DrawInfo);
  if Result.X < 0 then Result.Y := -1
  else if Result.Y < 0 then Result.X := -1;
end;

procedure TbsSkinCustomGrid.MoveColRow(ACol, ARow: Longint; MoveAnchor,
  Show: Boolean);
begin
  MoveCurrent(ACol, ARow, MoveAnchor, Show);
end;

function TbsSkinCustomGrid.SelectCell(ACol, ARow: Longint): Boolean;
begin
  Result := True;
end;

procedure TbsSkinCustomGrid.SizeChanged(OldColCount, OldRowCount: Longint);
begin
end;

function TbsSkinCustomGrid.Sizing(X, Y: Integer): Boolean;
var
  DrawInfo: TbsGridDrawInfo;
  State: TbsGridState;
  Index: Longint;
  Pos, Ofs: Integer;
begin
  State := FGridState;
  if State = gsNormal then
  begin
    CalcDrawInfo(DrawInfo);
    CalcSizingState(X, Y, State, Index, Pos, Ofs, DrawInfo);
  end;
  Result := State <> gsNormal;
end;

procedure TbsSkinCustomGrid.TopLeftChanged;
begin
  if FEditorMode and (FInplaceEdit <> nil) then FInplaceEdit.UpdateLoc(CellRect(Col, Row));
end;

procedure FillDWord(var Dest; Count, Value: Integer); register;
asm
  XCHG  EDX, ECX
  PUSH  EDI
  MOV   EDI, EAX
  MOV   EAX, EDX
  REP   STOSD
  POP   EDI
end;

function StackAlloc(Size: Integer): Pointer; register;
asm
  POP   ECX          { return address }
  MOV   EDX, ESP
  ADD   EAX, 3
  AND   EAX, not 3   // round up to keep ESP dword aligned
  CMP   EAX, 4092
  JLE   @@2
@@1:
  SUB   ESP, 4092
  PUSH  EAX          { make sure we touch guard page, to grow stack }
  SUB   EAX, 4096
  JNS   @@1
  ADD   EAX, 4096
@@2:
  SUB   ESP, EAX
  MOV   EAX, ESP     { function result = low memory address of block }
  PUSH  EDX          { save original SP, for cleanup }
  MOV   EDX, ESP
  SUB   EDX, 4
  PUSH  EDX          { save current SP, for sanity check  (sp = [sp]) }
  PUSH  ECX          { return to caller }
end;

procedure StackFree(P: Pointer); register;
asm
  POP   ECX                     { return address }
  MOV   EDX, DWORD PTR [ESP]
  SUB   EAX, 8
  CMP   EDX, ESP                { sanity check #1 (SP = [SP]) }
  JNE   @@1
  CMP   EDX, EAX                { sanity check #2 (P = this stack block) }
  JNE   @@1
  MOV   ESP, DWORD PTR [ESP+4]  { restore previous SP  }
@@1:
  PUSH  ECX                     { return to caller }
end;

procedure TbsSkinCustomGrid.Paint;
var
  LineColor: TColor;
  DrawInfo: TbsGridDrawInfo;
  Sel: TGridRect;
  UpdateRect: TRect;
  R, AFocRect, FocRect: TRect;
  PointsList: PIntArray;
  StrokeList: PIntArray;
  MaxStroke: Integer;
  FrameFlags1, FrameFlags2: DWORD;
  B: TBitMap;

  procedure DrawLines(DoHorz, DoVert: Boolean; Col, Row: Longint;
    const CellBounds: array of Integer; OnColor, OffColor: TColor);

  const
    FlatPenStyle = PS_Geometric or PS_Solid or PS_EndCap_Flat or PS_Join_Miter;

    procedure DrawAxisLines(const AxisInfo: TbsGridAxisDrawInfo;
      Cell, MajorIndex: Integer; UseOnColor: Boolean);
    var
      Line: Integer;
      LogBrush: TLOGBRUSH;
      Index: Integer;
      Points: PIntArray;
      StopMajor, StartMinor, StopMinor: Integer;
    begin
      with Canvas, AxisInfo do
      begin
        if EffectiveLineWidth <> 0 then
        begin
          Pen.Width := GridLineWidth;
          if UseOnColor then
            Pen.Color := OnColor
          else
            Pen.Color := OffColor;
          if Pen.Width > 1 then
          begin
            LogBrush.lbStyle := BS_Solid;
            LogBrush.lbColor := Pen.Color;
            LogBrush.lbHatch := 0;
            Pen.Handle := ExtCreatePen(FlatPenStyle, Pen.Width, LogBrush, 0, nil);
          end;
          Points := PointsList;
          Line := CellBounds[MajorIndex] + EffectiveLineWidth shr 1 +
            GetExtent(Cell);
          //!!! ??? Line needs to be incremented for RightToLeftAlignment ???
          if UseRightToLeftAlignment and (MajorIndex = 0) then Inc(Line);
          StartMinor := CellBounds[MajorIndex xor 1];
          StopMinor := CellBounds[2 + (MajorIndex xor 1)];
          StopMajor := CellBounds[2 + MajorIndex] + EffectiveLineWidth;
          Index := 0;
          repeat
            Points^[Index + MajorIndex] := Line;         { MoveTo }
            Points^[Index + (MajorIndex xor 1)] := StartMinor;
            Inc(Index, 2);
            Points^[Index + MajorIndex] := Line;         { LineTo }
            Points^[Index + (MajorIndex xor 1)] := StopMinor;
            Inc(Index, 2);
            Inc(Cell);
            Inc(Line, GetExtent(Cell) + EffectiveLineWidth);
          until Line > StopMajor;
           { 2 integers per point, 2 points per line -> Index div 4 }
          PolyPolyLine(Canvas.Handle, Points^, StrokeList^, Index shr 2);
        end;
      end;
    end;

  begin
    if (CellBounds[0] = CellBounds[2]) or (CellBounds[1] = CellBounds[3]) then Exit;
    if not DoHorz then
    begin
      DrawAxisLines(DrawInfo.Vert, Row, 1, DoHorz);
      DrawAxisLines(DrawInfo.Horz, Col, 0, DoVert);
    end
    else
    begin
      DrawAxisLines(DrawInfo.Horz, Col, 0, DoVert);
      DrawAxisLines(DrawInfo.Vert, Row, 1, DoHorz);
    end;
  end;

  procedure DrawSkinCell(B: TBitMap; AState: TGridDrawState; W, H: Integer);
  var
    Buffer: TBitMap;
  begin
    if not FUseSkinCellHeight
    then
      begin
        Buffer := TBitMap.Create;
        B.Width := W;
        B.Height := H;
      end;

    if (gdFixed in AState)
    then
      begin
        if FUseSkinCellHeight
        then
          CreateHSkinImage(FixedCellLeftOffset, FixedCellRightOffset,
           B, Picture, FixedCellRect, W, H, FixedCellStretchEffect)
        else
          CreateHSkinImage(FixedCellLeftOffset, FixedCellRightOffset,
           Buffer, Picture, FixedCellRect, W, H, CellStretchEffect);
        if FUseSkinFont
        then
          with Canvas do
          begin
            Font.Name := FixedFontName;
            Font.Height := FixedFontHeight;
            Font.Color := FixedFontColor;
            Font.Style := FixedFontStyle;
          end
        else
          begin
            Canvas.Font.Assign(Self.Font);
            Canvas.Font.Color := FixedFontColor;
          end;
        if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
        then
          Canvas.Font.Charset := SkinData.ResourceStrData.CharSet
        else
          Canvas.Font.CharSet := Self.Font.CharSet;
      end
    else
    if (gdFocused in AState) or (goRowSelect in Options)
    then 
      begin
        if FUseSkinCellHeight
        then
          CreateHSkinImage(CellLeftOffset, CellRightOffset,
            B, Picture, FocusCellRect, W, H, CellStretchEffect)
        else
          CreateHSkinImage(CellLeftOffset, CellRightOffset,
            Buffer, Picture, FocusCellRect, W, H, CellStretchEffect);
        if FUseSkinFont
        then
          with Canvas do
          begin
            Font.Name := FontName;
            Font.Height := FontHeight;
            Font.Color := FocusFontColor;
            Font.Style := FontStyle;
          end
        else
          begin
            Canvas.Font.Assign(Self.Font);
            Canvas.Font.Color := FocusFontColor;
          end;
        if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
        then
          Canvas.Font.Charset := SkinData.ResourceStrData.CharSet
        else
          Canvas.Font.CharSet := Self.Font.CharSet;
      end
    else
    if (gdSelected in AState)
    then
      begin
        if FUseSkinCellHeight
        then
          CreateHSkinImage(CellLeftOffset, CellRightOffset,
            B, Picture, SelectCellRect, W, H, CellStretchEffect)
        else
          CreateHSkinImage(CellLeftOffset, CellRightOffset,
            Buffer, Picture, SelectCellRect, W, H, CellStretchEffect);
        if FUseSkinFont
        then
          with Canvas do
          begin
            Font.Name := FontName;
            Font.Height := FontHeight;
            Font.Color := SelectFontColor;
            Font.Style := FontStyle;
          end
        else
          begin
            Canvas.Font.Assign(Self.Font);
            Canvas.Font.Color := SelectFontColor;
          end;
        if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
        then
          Canvas.Font.Charset := SkinData.ResourceStrData.CharSet
        else
          Canvas.Font.CharSet := Self.Font.CharSet;
      end;
    if not FUseSkinCellHeight
    then
      begin
        B.Canvas.StretchDraw(Rect(0, 0, W, H), Buffer);
        Buffer.Free;
      end;

    if ShowFocus and (gdFocused in AState) and
       not (goRowSelect in Options) and   (FIndex <> -1)
    then
      begin
        B.Canvas.Brush.Style := bsSolid;
        B.Canvas.Brush.Color := FSD.SkinColors.cBtnFace;
        B.Canvas.DrawFocusRect(Rect(0, 0, B.Width, B.Height));
        B.Canvas.Brush.Style := bsClear;
      end;
      
  end;

  procedure DrawCells(ACol, ARow: Longint; StartX, StartY, StopX, StopY: Integer;
    Color: TColor; IncludeDrawState: TGridDrawState);
  var
    CurCol, CurRow: Longint;
    AWhere, Where, TempRect: TRect;
    DrawState: TGridDrawState;
    Focused: Boolean;
  begin
    CurRow := ARow;
    Where.Top := StartY;
    while (Where.Top < StopY) and (CurRow < RowCount) do
    begin
      CurCol := ACol;
      Where.Left := StartX;
      Where.Bottom := Where.Top + RowHeights[CurRow];
      while (Where.Left < StopX) and (CurCol < ColCount) do
      begin
        Where.Right := Where.Left + ColWidths[CurCol];
        if (Where.Right > Where.Left) and RectVisible(Canvas.Handle, Where) then
        begin
          DrawState := IncludeDrawState;
          Focused := IsActiveControl;
          if Focused and (CurRow = Row) and (CurCol = Col)  then
            Include(DrawState, gdFocused);
          if PointInGridRect(CurCol, CurRow, Sel) then
            Include(DrawState, gdSelected);
          if not (gdFocused in DrawState) or not (goEditing in Options) or
            not FEditorMode or (csDesigning in ComponentState) then
          begin
            if DefaultDrawing or (csDesigning in ComponentState) then
              with Canvas do
              begin
                if FIndex < 0
                then
                  begin
                    Font := Self.Font;
                    if (gdSelected in DrawState) and
                       (not (gdFocused in DrawState) or
                       ([goDrawFocusSelected, goRowSelect] * Options <> []))
                    then
                      begin
                        Brush.Color := clHighlight;
                        Font.Color := clHighlightText;
                        FillRect(Where)
                      end
                    else
                      begin
                        Brush.Color := Color;
                        FillRect(Where);
                        if gdFixed in DrawState
                        then
                          begin
                            R := Where;
                            Frm3D(Canvas, R, clBtnHighLight, clBtnShadow);
                          end;
                      end;
                  end
                else
                  if not (gdSelected in DrawState) and
                     not (gdFocused in DrawState) and
                     not (gdFixed in DrawState)
                  then
                    begin
                      if FUseSkinFont
                      then
                        begin
                          Font.Name := FontName;
                          Font.Height := FontHeight;
                          Font.Color := FontColor;
                          Font.Style := FontStyle;
                        end
                      else
                        begin
                          Font.Assign(Self.Font);
                          Font.Color := FontColor;
                        end;
                      if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
                      then
                        Font.Charset := SkinData.ResourceStrData.CharSet
                      else
                        Font.CharSet := Self.Font.CharSet;
                      Brush.Color := BGColor;
                      FillRect(Where);
                    end
                  else
                    begin
                      B := TBitMap.Create;
                      DrawSkinCell(B, DrawState,
                      RectWidth(Where), RectHeight(Where));
                      Draw(Where.Left, Where.Top, B);
                      B.Free;
                    end;
              end;

            DrawCell(CurCol, CurRow, Where, DrawState);

            if FIndex < 0
            then
            if DefaultDrawing and not (csDesigning in ComponentState) and
              (gdFocused in DrawState) and
              ([goEditing, goAlwaysShowEditor] * Options <> [goEditing, goAlwaysShowEditor])
              and not (goRowSelect in Options)
            then
            begin
              if not UseRightToLeftAlignment
              then
                DrawFocusRect(Canvas.Handle, Where)
              else
                begin
                  AWhere := Where;
                  AWhere.Left := Where.Right;
                  AWhere.Right := Where.Left;
                  DrawFocusRect(Canvas.Handle, AWhere)
                end;
            end;

          end;
        end;
        Where.Left := Where.Right + DrawInfo.Horz.EffectiveLineWidth;
        Inc(CurCol);
      end;
      Where.Top := Where.Bottom + DrawInfo.Vert.EffectiveLineWidth;
      Inc(CurRow);
    end;
  end;


begin
  if (Width <= 0) or (Height <=0) then Exit;
  GetSkinData;
  
  if UseRightToLeftAlignment then ChangeGridOrientation(True);

  UpdateRect := Canvas.ClipRect;

  CalcDrawInfo(DrawInfo);
  with DrawInfo do
  begin
    if (Horz.EffectiveLineWidth > 0) or (Vert.EffectiveLineWidth > 0) then
    begin
      { Draw the grid line in the four areas (fixed, fixed), (variable, fixed),
        (fixed, variable) and (variable, variable) }
      if FIndex > -1
      then
        LineColor := LinesColor
      else
        LineColor := FGridLineColor;

      MaxStroke := Max(Horz.LastFullVisibleCell - LeftCol + FixedCols,
                        Vert.LastFullVisibleCell - TopRow + FixedRows) + 3;
      PointsList := StackAlloc(MaxStroke * sizeof(TPoint) * 2);
      StrokeList := StackAlloc(MaxStroke * sizeof(Integer));
      FillDWord(StrokeList^, MaxStroke, 2);

      if ColorToRGB(Color) = clSilver then LineColor := clGray;

      DrawLines(goFixedHorzLine in Options, goFixedVertLine in Options,
        0, 0, [0, 0, Horz.FixedBoundary, Vert.FixedBoundary], LineColor{clBlack}, FixedColor);

      DrawLines(goFixedHorzLine in Options, goFixedVertLine in Options,
        LeftCol, 0, [Horz.FixedBoundary, 0, Horz.GridBoundary,
        Vert.FixedBoundary], LineColor{clBlack}, FixedColor);

      DrawLines(goFixedHorzLine in Options, goFixedVertLine in Options,
        0, TopRow, [0, Vert.FixedBoundary, Horz.FixedBoundary,
        Vert.GridBoundary], LineColor{clBlack}, FixedColor);

      // skin
      DrawLines(goHorzLine in Options, goVertLine in Options, LeftCol,
        TopRow, [Horz.FixedBoundary, Vert.FixedBoundary, Horz.GridBoundary,
        Vert.GridBoundary], LineColor, Color);
      //

      StackFree(StrokeList);
      StackFree(PointsList);
    end;

    { Draw the cells in the four areas }
    Sel := Selection;
    FrameFlags1 := 0;
    FrameFlags2 := 0;
    if goFixedVertLine in Options then
    begin
      FrameFlags1 := BF_RIGHT;
      FrameFlags2 := BF_LEFT;
    end;
    if goFixedHorzLine in Options then
    begin
      FrameFlags1 := FrameFlags1 or BF_BOTTOM;
      FrameFlags2 := FrameFlags2 or BF_TOP;
    end;
    if not IsRightToLeft
    then
      DrawCells(0, 0, 0, 0, Horz.FixedBoundary, Vert.FixedBoundary, FixedColor,
       [gdFixed])
    else
      DrawCells(0, 0, 1, 0, Horz.FixedBoundary, Vert.FixedBoundary, FixedColor,
       [gdFixed]);
    DrawCells(LeftCol, 0, Horz.FixedBoundary - FColOffset, 0, Horz.GridBoundary,  //!! clip
      Vert.FixedBoundary, FixedColor, [gdFixed]);
    if not IsRightToLeft
    then
      DrawCells(0, TopRow, 0, Vert.FixedBoundary, Horz.FixedBoundary,
        Vert.GridBoundary, FixedColor, [gdFixed])
    else
      DrawCells(0, TopRow, 1, Vert.FixedBoundary, Horz.FixedBoundary,
        Vert.GridBoundary, FixedColor, [gdFixed]);
    DrawCells(LeftCol, TopRow, Horz.FixedBoundary - FColOffset,                   //!! clip
      Vert.FixedBoundary, Horz.GridBoundary, Vert.GridBoundary, Color, []);

    if not (csDesigning in ComponentState) and
      (goRowSelect in Options) and DefaultDrawing and Focused then
    begin
      GridRectToScreenRect(GetSelection, FocRect, False);
      if (FIndex < 0) or ((FIndex <> -1) and ShowFocus)
      then
        if not UseRightToLeftAlignment
        then
          begin
            if FIndex <> -1
            then
              Canvas.Brush.Color := FSD.SkinColors.cBtnHighLight
             else
              Canvas.Brush.Color := clBtnHighLight;
            Canvas.DrawFocusRect(FocRect)
          end
        else
          begin
            AFocRect := FocRect;
            AFocRect.Left := FocRect.Right;
            AFocRect.Right := FocRect.Left;
            if FIndex <> -1
            then
              Canvas.Brush.Color := FSD.SkinColors.cBtnHighLight
             else
              Canvas.Brush.Color := clBtnHighLight;
            Canvas.DrawFocusRect(AFocRect)
          end;
    end;

    { Fill in area not occupied by cells }
     if Horz.GridBoundary < Horz.GridExtent then
        begin
          if FIndex > -1
          then
            Canvas.Brush.Color := BGColor
          else
            Canvas.Brush.Color := Color;
          if not IsRightToLeft
          then
            Canvas.FillRect(Rect(Horz.GridBoundary, 0, Horz.GridExtent + 1, Vert.GridBoundary))
          else
            Canvas.FillRect(Rect(Horz.GridBoundary, -20, Horz.GridExtent + 1, Vert.GridBoundary));
        end;

        if Vert.GridBoundary < Vert.GridExtent then
        begin
          if FIndex > -1
          then
            Canvas.Brush.Color := BGColor
          else
            Canvas.Brush.Color := Color;
           if not IsRightToLeft
          then
            Canvas.FillRect(Rect(0, Vert.GridBoundary, Horz.GridExtent, Vert.GridExtent))
          else
            Canvas.FillRect(Rect(-20, Vert.GridBoundary, Horz.GridExtent, Vert.GridExtent));
         end;
      end;

   if UseRightToLeftAlignment then ChangeGridOrientation(False);
end;

function TbsSkinCustomGrid.CalcCoordFromPoint(X, Y: Integer;
  const DrawInfo: TbsGridDrawInfo): TGridCoord;

  function DoCalc(const AxisInfo: TbsGridAxisDrawInfo; N: Integer): Integer;
  var
    I, Start, Stop: Longint;
    Line: Integer;
  begin
    with AxisInfo do
    begin
      if N < FixedBoundary then
      begin
        Start := 0;
        Stop :=  FixedCellCount - 1;
        Line := 0;
      end
      else
      begin
        Start := FirstGridCell;
        Stop := GridCellCount - 1;
        Line := FixedBoundary;
      end;
      Result := -1;
      for I := Start to Stop do
      begin
        Inc(Line, GetExtent(I) + EffectiveLineWidth);
        if N < Line then
        begin
          Result := I;
          Exit;
        end;
      end;
    end;
  end;

  function DoCalcRightToLeft(const AxisInfo: TbsGridAxisDrawInfo; N: Integer): Integer;
  var
    I, Start, Stop: Longint;
    Line: Integer;
  begin
    N := ClientWidth - N;
    with AxisInfo do
    begin
      if N < FixedBoundary then
      begin
        Start := 0;
        Stop :=  FixedCellCount - 1;
        Line := ClientWidth;
      end
      else
      begin
        Start := FirstGridCell;
        Stop := GridCellCount - 1;
        Line := FixedBoundary;
      end;
      Result := -1;
      for I := Start to Stop do
      begin
        Inc(Line, GetExtent(I) + EffectiveLineWidth);
        if N < Line then
        begin
          Result := I;
          Exit;
        end;
      end;
    end;
  end;

begin
  if not UseRightToLeftAlignment then
    Result.X := DoCalc(DrawInfo.Horz, X)
  else
    Result.X := DoCalcRightToLeft(DrawInfo.Horz, X);
  Result.Y := DoCalc(DrawInfo.Vert, Y);
end;

procedure TbsSkinCustomGrid.CalcDrawInfo(var DrawInfo: TbsGridDrawInfo);
begin
  CalcDrawInfoXY(DrawInfo, ClientWidth, ClientHeight);
end;

procedure TbsSkinCustomGrid.CalcDrawInfoXY(var DrawInfo: TbsGridDrawInfo;
  UseWidth, UseHeight: Integer);

  procedure CalcAxis(var AxisInfo: TbsGridAxisDrawInfo; UseExtent: Integer);
  var
    I: Integer;
  begin
    with AxisInfo do
    begin
      GridExtent := UseExtent;
      GridBoundary := FixedBoundary;
      FullVisBoundary := FixedBoundary;
      LastFullVisibleCell := FirstGridCell;
      for I := FirstGridCell to GridCellCount - 1 do
      begin
        Inc(GridBoundary, GetExtent(I) + EffectiveLineWidth);
        if GridBoundary > GridExtent + EffectiveLineWidth then
        begin
          GridBoundary := GridExtent;
          Break;
        end;
        LastFullVisibleCell := I;
        FullVisBoundary := GridBoundary;
      end;
    end;
  end;

begin
  CalcFixedInfo(DrawInfo);
  CalcAxis(DrawInfo.Horz, UseWidth);
  CalcAxis(DrawInfo.Vert, UseHeight);
end;

procedure TbsSkinCustomGrid.CalcFixedInfo(var DrawInfo: TbsGridDrawInfo);

  procedure CalcFixedAxis(var Axis: TbsGridAxisDrawInfo; LineOptions: TGridOptions;
    FixedCount, FirstCell, CellCount: Integer; GetExtentFunc: TbsGetExtentsFunc);
  var
    I: Integer;
  begin
    with Axis do
    begin
      if LineOptions * Options = [] then
        EffectiveLineWidth := 0
      else
        EffectiveLineWidth := GridLineWidth;

      FixedBoundary := 0;
      for I := 0 to FixedCount - 1 do
        Inc(FixedBoundary, GetExtentFunc(I) + EffectiveLineWidth);

      FixedCellCount := FixedCount;
      FirstGridCell := FirstCell;
      GridCellCount := CellCount;
      GetExtent := GetExtentFunc;
    end;
  end;

begin
  CalcFixedAxis(DrawInfo.Horz, [goFixedVertLine, goVertLine], FixedCols,
    LeftCol, ColCount, GetColWidths);
  CalcFixedAxis(DrawInfo.Vert, [goFixedHorzLine, goHorzLine], FixedRows,
    TopRow, RowCount, GetRowHeights);
end;

{ Calculates the TopLeft that will put the given Coord in view }
function TbsSkinCustomGrid.CalcMaxTopLeft(const Coord: TGridCoord;
  const DrawInfo: TbsGridDrawInfo): TGridCoord;

  function CalcMaxCell(const Axis: TbsGridAxisDrawInfo; Start: Integer): Integer;
  var
    Line: Integer;
    I, Extent: Longint;
  begin
    Result := Start;
    with Axis do
    begin
      Line := GridExtent + EffectiveLineWidth;
      for I := Start downto FixedCellCount do
      begin
        Extent := GetExtent(I);
        Dec(Line, Extent);
        Dec(Line, EffectiveLineWidth);
        if Line < FixedBoundary then Break;
        if Extent > 0 then Result := I;
      end;
    end;
  end;

begin
  Result.X := CalcMaxCell(DrawInfo.Horz, Coord.X);
  Result.Y := CalcMaxCell(DrawInfo.Vert, Coord.Y);
end;

procedure TbsSkinCustomGrid.CalcSizingState(X, Y: Integer; var State: TbsGridState;
  var Index: Longint; var SizingPos, SizingOfs: Integer;
  var FixedInfo: TbsGridDrawInfo);

  procedure CalcAxisState(const AxisInfo: TbsGridAxisDrawInfo; Pos: Integer;
    NewState: TbsGridState);
  var
    I, Line, Back, Range: Integer;
  begin
    if UseRightToLeftAlignment then
      Pos := ClientWidth - Pos;
    with AxisInfo do
    begin
      Line := FixedBoundary;
      Range := EffectiveLineWidth;
      Back := 0;
      if Range < 7 then
      begin
        Range := 7;
        Back := (Range - EffectiveLineWidth) shr 1;
      end;
      for I := FirstGridCell to GridCellCount - 1 do
      begin
        Inc(Line, GetExtent(I));
        if Line > GridBoundary then Break;
        if (Pos >= Line - Back) and (Pos <= Line - Back + Range) then
        begin
          State := NewState;
          SizingPos := Line;
          SizingOfs := Line - Pos;
          Index := I;
          Exit;
        end;
        Inc(Line, EffectiveLineWidth);
      end;
      if (GridBoundary = GridExtent) and (Pos >= GridExtent - Back)
        and (Pos <= GridExtent) then
      begin
        State := NewState;
        SizingPos := GridExtent;
        SizingOfs := GridExtent - Pos;
        Index := LastFullVisibleCell + 1;
      end;
    end;
  end;

  function XOutsideHorzFixedBoundary: Boolean;
  begin
    with FixedInfo do
      if not UseRightToLeftAlignment then
        Result := X > Horz.FixedBoundary
      else
        Result := X < ClientWidth - Horz.FixedBoundary;
  end;

  function XOutsideOrEqualHorzFixedBoundary: Boolean;
  begin
    with FixedInfo do
      if not UseRightToLeftAlignment then
        Result := X >= Horz.FixedBoundary
      else
        Result := X <= ClientWidth - Horz.FixedBoundary;
  end;


var
  EffectiveOptions: TGridOptions;
begin
  State := gsNormal;
  Index := -1;
  EffectiveOptions := Options;
  if csDesigning in ComponentState then
    EffectiveOptions := EffectiveOptions + DesignOptionsBoost;
  if [goColSizing, goRowSizing] * EffectiveOptions <> [] then
    with FixedInfo do
    begin
      Vert.GridExtent := ClientHeight;
      Horz.GridExtent := ClientWidth;
      if (XOutsideHorzFixedBoundary) and (goColSizing in EffectiveOptions) then
      begin
        if Y >= Vert.FixedBoundary then Exit;
        CalcAxisState(Horz, X, gsColSizing);
      end
      else if (Y > Vert.FixedBoundary) and (goRowSizing in EffectiveOptions) then
      begin
        if XOutsideOrEqualHorzFixedBoundary then Exit;
        CalcAxisState(Vert, Y, gsRowSizing);
      end;
    end;
end;

procedure TbsSkinCustomGrid.ChangeGridOrientation(RightToLeftOrientation: Boolean);
var
  Org: TPoint;
  Ext: TPoint;
begin
  if RightToLeftOrientation then
  begin
    Org := Point(ClientWidth,0);
    Ext := Point(-1,1);
    SetMapMode(Canvas.Handle, mm_Anisotropic);
    SetWindowOrgEx(Canvas.Handle, Org.X, Org.Y, nil);
    SetViewportExtEx(Canvas.Handle, ClientWidth, ClientHeight, nil);
    SetWindowExtEx(Canvas.Handle, Ext.X*ClientWidth, Ext.Y*ClientHeight, nil);
  end
  else
  begin
    Org := Point(0,0);
    Ext := Point(1,1);
    SetMapMode(Canvas.Handle, mm_Anisotropic);
    SetWindowOrgEx(Canvas.Handle, Org.X, Org.Y, nil);
    SetViewportExtEx(Canvas.Handle, ClientWidth, ClientHeight, nil);
    SetWindowExtEx(Canvas.Handle, Ext.X*ClientWidth, Ext.Y*ClientHeight, nil);
  end;
end;

procedure TbsSkinCustomGrid.ChangeSize(NewColCount, NewRowCount: Longint);
var
  OldColCount, OldRowCount: Longint;
  OldDrawInfo: TbsGridDrawInfo;

  procedure MinRedraw(const OldInfo, NewInfo: TbsGridAxisDrawInfo; Axis: Integer);
  var
    R: TRect;
    First: Integer;
  begin
    First := Min(OldInfo.LastFullVisibleCell, NewInfo.LastFullVisibleCell);
    // Get the rectangle around the leftmost or topmost cell in the target range.
    R := CellRect(First and not Axis, First and Axis);
    R.Bottom := Height;
    R.Right := Width;
    Windows.InvalidateRect(Handle, @R, False);
  end;

  procedure DoChange;
  var
    Coord: TGridCoord;
    NewDrawInfo: TbsGridDrawInfo;
  begin
    if FColWidths <> nil then
    begin
      UpdateExtents(FColWidths, ColCount, DefaultColWidth);
      UpdateExtents(FTabStops, ColCount, Integer(True));
    end;
    if FRowHeights <> nil then
      UpdateExtents(FRowHeights, RowCount, DefaultRowHeight);
    Coord := FCurrent;
    if Row >= RowCount then Coord.Y := RowCount - 1;
    if Col >= ColCount then Coord.X := ColCount - 1;
    if (FCurrent.X <> Coord.X) or (FCurrent.Y <> Coord.Y) then
      MoveCurrent(Coord.X, Coord.Y, True, True);
    if (FAnchor.X <> Coord.X) or (FAnchor.Y <> Coord.Y) then
      MoveAnchor(Coord);
    if VirtualView or
      (LeftCol <> OldDrawInfo.Horz.FirstGridCell) or
      (TopRow <> OldDrawInfo.Vert.FirstGridCell) then
      InvalidateGrid
    else if HandleAllocated then
    begin
      CalcDrawInfo(NewDrawInfo);
      MinRedraw(OldDrawInfo.Horz, NewDrawInfo.Horz, 0);
      MinRedraw(OldDrawInfo.Vert, NewDrawInfo.Vert, -1);
    end;
    UpdateScrollRange(True);
    SizeChanged(OldColCount, OldRowCount);
  end;

begin
  if HandleAllocated then
    CalcDrawInfo(OldDrawInfo);
  OldColCount := FColCount;
  OldRowCount := FRowCount;
  FColCount := NewColCount;
  FRowCount := NewRowCount;
  if FixedCols > NewColCount then FFixedCols := NewColCount - 1;
  if FixedRows > NewRowCount then FFixedRows := NewRowCount - 1;
  try
    DoChange;
  except
    { Could not change size so try to clean up by setting the size back }
    FColCount := OldColCount;
    FRowCount := OldRowCount;
    DoChange;
    InvalidateGrid;
    raise;
  end;
end;

{ Will move TopLeft so that Coord is in view }
procedure TbsSkinCustomGrid.ClampInView(const Coord: TGridCoord);
var
  DrawInfo: TbsGridDrawInfo;
  MaxTopLeft: TGridCoord;
  OldTopLeft: TGridCoord;
begin
  if not HandleAllocated then Exit;
  CalcDrawInfo(DrawInfo);
  with DrawInfo, Coord do
  begin
    if (X > Horz.LastFullVisibleCell) or
      (Y > Vert.LastFullVisibleCell) or (X < LeftCol) or (Y < TopRow) then
    begin
      OldTopLeft := FTopLeft;
      MaxTopLeft := CalcMaxTopLeft(Coord, DrawInfo);
      Update;
      if X < LeftCol then FTopLeft.X := X
      else if X > Horz.LastFullVisibleCell then FTopLeft.X := MaxTopLeft.X;
      if Y < TopRow then FTopLeft.Y := Y
      else if Y > Vert.LastFullVisibleCell then FTopLeft.Y := MaxTopLeft.Y;
      TopLeftMoved(OldTopLeft);
    end;
  end;
end;

procedure TbsSkinCustomGrid.DrawSizingLine(const DrawInfo: TbsGridDrawInfo);
var
  OldPen: TPen;
begin
  OldPen := TPen.Create;
  try
    with Canvas, DrawInfo do
    begin
      OldPen.Assign(Pen);
      Pen.Style := psDot;
      Pen.Mode := pmXor;
      Pen.Width := 1;
      try
        if FGridState = gsRowSizing then
        begin
          MoveTo(0, FSizingPos);
          LineTo(Horz.GridBoundary, FSizingPos);
        end
        else
        begin
          MoveTo(FSizingPos, 0);
          LineTo(FSizingPos, Vert.GridBoundary);
        end;
      finally
        Pen := OldPen;
      end;
    end;
  finally
    OldPen.Free;
  end;
end;

procedure TbsSkinCustomGrid.DrawMove;
var
  OldPen: TPen;
  Pos: Integer;
  R: TRect;
begin
  OldPen := TPen.Create;
  try
    with Canvas do
    begin
      OldPen.Assign(Pen);
      try
        Pen.Style := psDot;
        Pen.Mode := pmXor;
        Pen.Width := 5;
        if FGridState = gsRowMoving then
        begin
          R := CellRect(0, FMovePos);
          if FMovePos > FMoveIndex then
            Pos := R.Bottom else
            Pos := R.Top;
          MoveTo(0, Pos);
          LineTo(ClientWidth, Pos);
        end
        else
        begin
          R := CellRect(FMovePos, 0);
          if FMovePos > FMoveIndex then
            if not UseRightToLeftAlignment then
              Pos := R.Right
            else
              Pos := R.Left
          else
            if not UseRightToLeftAlignment then
              Pos := R.Left
            else
              Pos := R.Right;
          MoveTo(Pos, 0);
          LineTo(Pos, ClientHeight);
        end;
      finally
        Canvas.Pen := OldPen;
      end;
    end;
  finally
    OldPen.Free;
  end;
end;

procedure TbsSkinCustomGrid.FocusCell(ACol, ARow: Longint; MoveAnchor: Boolean);
begin
  MoveCurrent(ACol, ARow, MoveAnchor, True);
  UpdateEdit;
  Click;
end;

procedure TbsSkinCustomGrid.GridRectToScreenRect(GridRect: TGridRect;
  var ScreenRect: TRect; IncludeLine: Boolean);

  function LinePos(const AxisInfo: TbsGridAxisDrawInfo; Line: Integer): Integer;
  var
    Start, I: Longint;
  begin
    with AxisInfo do
    begin
      Result := 0;
      if Line < FixedCellCount then
        Start := 0
      else
      begin
        if Line >= FirstGridCell then
          Result := FixedBoundary;
        Start := FirstGridCell;
      end;
      for I := Start to Line - 1 do
      begin
        Inc(Result, GetExtent(I) + EffectiveLineWidth);
        if Result > GridExtent then
        begin
          Result := 0;
          Exit;
        end;
      end;
    end;
  end;

  function CalcAxis(const AxisInfo: TbsGridAxisDrawInfo;
    GridRectMin, GridRectMax: Integer;
    var ScreenRectMin, ScreenRectMax: Integer): Boolean;
  begin
    Result := False;
    with AxisInfo do
    begin
      if (GridRectMin >= FixedCellCount) and (GridRectMin < FirstGridCell) then
        if GridRectMax < FirstGridCell then
        begin
          FillChar(ScreenRect, SizeOf(ScreenRect), 0); { erase partial results }
          Exit;
        end
        else
          GridRectMin := FirstGridCell;
      if GridRectMax > LastFullVisibleCell then
      begin
        GridRectMax := LastFullVisibleCell;
        if GridRectMax < GridCellCount - 1 then Inc(GridRectMax);
        if LinePos(AxisInfo, GridRectMax) = 0 then
          Dec(GridRectMax);
      end;

      ScreenRectMin := LinePos(AxisInfo, GridRectMin);
      ScreenRectMax := LinePos(AxisInfo, GridRectMax);
      if ScreenRectMax = 0 then
        ScreenRectMax := ScreenRectMin + GetExtent(GridRectMin)
      else
        Inc(ScreenRectMax, GetExtent(GridRectMax));
      if ScreenRectMax > GridExtent then
        ScreenRectMax := GridExtent;
      if IncludeLine then Inc(ScreenRectMax, EffectiveLineWidth);
    end;
    Result := True;
  end;

var
  DrawInfo: TbsGridDrawInfo;
  Hold: Integer;
begin
  FillChar(ScreenRect, SizeOf(ScreenRect), 0);
  if (GridRect.Left > GridRect.Right) or (GridRect.Top > GridRect.Bottom) then
    Exit;
  CalcDrawInfo(DrawInfo);
  with DrawInfo do
  begin
    if GridRect.Left > Horz.LastFullVisibleCell + 1 then Exit;
    if GridRect.Top > Vert.LastFullVisibleCell + 1 then Exit;

    if CalcAxis(Horz, GridRect.Left, GridRect.Right, ScreenRect.Left,
      ScreenRect.Right) then
    begin
      CalcAxis(Vert, GridRect.Top, GridRect.Bottom, ScreenRect.Top,
        ScreenRect.Bottom);
    end;
  end;
  if UseRightToLeftAlignment and (Canvas.CanvasOrientation = coLeftToRight) then
  begin
    Hold := ScreenRect.Left;
    ScreenRect.Left := ClientWidth - ScreenRect.Right;
    ScreenRect.Right := ClientWidth - Hold;
  end;
end;

procedure TbsSkinCustomGrid.Initialize;
begin
  FTopLeft.X := FixedCols;
  FTopLeft.Y := FixedRows;
  FCurrent := FTopLeft;
  FAnchor := FCurrent;
  if goRowSelect in Options then FAnchor.X := ColCount - 1;
end;

procedure TbsSkinCustomGrid.InvalidateCell(ACol, ARow: Longint);
var
  Rect: TGridRect;
begin
  Rect.Top := ARow;
  Rect.Left := ACol;
  Rect.Bottom := ARow;
  Rect.Right := ACol;
  InvalidateRect(Rect);
end;

procedure TbsSkinCustomGrid.InvalidateCol(ACol: Longint);
var
  Rect: TGridRect;
begin
  if not HandleAllocated then Exit;
  Rect.Top := 0;
  Rect.Left := ACol;
  Rect.Bottom := VisibleRowCount+1;
  Rect.Right := ACol;
  InvalidateRect(Rect);
end;

procedure TbsSkinCustomGrid.InvalidateRow(ARow: Longint);
var
  Rect: TGridRect;
begin
  if not HandleAllocated then Exit;
  Rect.Top := ARow;
  Rect.Left := 0;
  Rect.Bottom := ARow;
  Rect.Right := VisibleColCount+1;
  InvalidateRect(Rect);
end;

procedure TbsSkinCustomGrid.InvalidateGrid;
begin
  Invalidate;
end;

procedure TbsSkinCustomGrid.InvalidateRect(ARect: TGridRect);
var
  InvalidRect: TRect;
begin
  if not HandleAllocated then Exit;
  GridRectToScreenRect(ARect, InvalidRect, True);
  Windows.InvalidateRect(Handle, @InvalidRect, False);
end;

procedure TbsSkinCustomGrid.ModifyScrollBar(ScrollBar, ScrollCode, Pos: Cardinal;
  UseRightToLeft: Boolean);
var
  NewTopLeft, MaxTopLeft: TGridCoord;
  OldNewTopLeftX: Integer;
  DrawInfo: TbsGridDrawInfo;
  RTLFactor: Integer;

  function Min: Longint;
  begin
    if ScrollBar = SB_HORZ then Result := FixedCols
    else Result := FixedRows;
  end;

  function Max: Longint;
  begin
    if ScrollBar = SB_HORZ then Result := MaxTopLeft.X
    else Result := MaxTopLeft.Y;
  end;

  function PageUp: Longint;
  var
    MaxTopLeft: TGridCoord;
  begin
    MaxTopLeft := CalcMaxTopLeft(FTopLeft, DrawInfo);
    if ScrollBar = SB_HORZ then
      Result := FTopLeft.X - MaxTopLeft.X else
      Result := FTopLeft.Y - MaxTopLeft.Y;
    if Result < 1 then Result := 1;
  end;

  function PageDown: Longint;
  var
    DrawInfo: TbsGridDrawInfo;
  begin
    CalcDrawInfo(DrawInfo);
    with DrawInfo do
      if ScrollBar = SB_HORZ then
        Result := Horz.LastFullVisibleCell - FTopLeft.X else
        Result := Vert.LastFullVisibleCell - FTopLeft.Y;
    if Result < 1 then Result := 1;
  end;

  function CalcScrollBar(Value, ARTLFactor: Longint): Longint;
  begin
    Result := Value;
    case ScrollCode of
      SB_LINEUP:
        Dec(Result, ARTLFactor);
      SB_LINEDOWN:
        Inc(Result, ARTLFactor);
      SB_PAGEUP:
        Dec(Result, PageUp * ARTLFactor);
      SB_PAGEDOWN:
        Inc(Result, PageDown * ARTLFactor);
      SB_THUMBPOSITION, SB_THUMBTRACK:
        if (goThumbTracking in Options) or (ScrollCode = SB_THUMBPOSITION) then
        begin
          if (not UseRightToLeftAlignment) or (ARTLFactor = 1) then
            Result := Min + LongMulDiv(Pos, Max - Min, MaxShortInt)
          else
            Result := Max - LongMulDiv(Pos, Max - Min, MaxShortInt);
        end;
      SB_BOTTOM:
        Result := Max;
      SB_TOP:
        Result := Min;
    end;
  end;

  procedure ModifyPixelScrollBar(Code, Pos: Cardinal);
  var
    NewOffset: Integer;
    OldOffset: Integer;
    R: TGridRect;
    GridSpace, ColWidth: Integer;
  begin
    NewOffset := FColOffset;
    ColWidth := ColWidths[DrawInfo.Horz.FirstGridCell];
    GridSpace := ClientWidth - DrawInfo.Horz.FixedBoundary;
    case Code of
      SB_LINEUP: Dec(NewOffset, Canvas.TextWidth('0') * RTLFactor);
      SB_LINEDOWN: Inc(NewOffset, Canvas.TextWidth('0') * RTLFactor);
      SB_PAGEUP: Dec(NewOffset, GridSpace * RTLFactor);
      SB_PAGEDOWN: Inc(NewOffset, GridSpace * RTLFactor);
      SB_THUMBPOSITION,
      SB_THUMBTRACK:
        if (goThumbTracking in Options) or (Code = SB_THUMBPOSITION) then
        begin
          if not UseRightToLeftAlignment then
            NewOffset := Pos
          else
            NewOffset := Max - Integer(Pos);
        end;
      SB_BOTTOM: NewOffset := 0;
      SB_TOP: NewOffset := ColWidth - GridSpace;
    end;
    if NewOffset < 0 then
      NewOffset := 0
    else if NewOffset >= ColWidth - GridSpace then
      NewOffset := ColWidth - GridSpace;
    if NewOffset <> FColOffset then
    begin
      OldOffset := FColOffset;
      FColOffset := NewOffset;
      ScrollData(OldOffset - NewOffset, 0);
      FillChar(R, SizeOf(R), 0);
      R.Bottom := FixedRows;
      InvalidateRect(R);
      Update;
      UpdateScrollPos(True);
    end;
  end;

begin
  if (not UseRightToLeftAlignment) or (not UseRightToLeft) then
    RTLFactor := 1
  else
    RTLFactor := -1;
  if Visible and CanFocus and TabStop and not (csDesigning in ComponentState) then
    SetFocus;
  CalcDrawInfo(DrawInfo);
  if (ScrollBar = SB_HORZ) and (ColCount = 1) then
  begin
    ModifyPixelScrollBar(ScrollCode, Pos);
    Exit;
  end;
  MaxTopLeft.X := ColCount - 1;
  MaxTopLeft.Y := RowCount - 1;
  MaxTopLeft := CalcMaxTopLeft(MaxTopLeft, DrawInfo);
  NewTopLeft := FTopLeft;
  if ScrollBar = SB_HORZ then
    repeat
      //
      OldNewTopLeftX := NewTopLeft.X;

      NewTopLeft.X := CalcScrollBar(NewTopLeft.X, RTLFactor);
      //
      if OldNewTopLeftX = NewTopLeft.X then Break;
    until (NewTopLeft.X <= FixedCols) or (NewTopLeft.X >= MaxTopLeft.X)
      or (ColWidths[NewTopLeft.X] > 0)
  else
    repeat
      //
      OldNewTopLeftX := NewTopLeft.X;

      NewTopLeft.Y := CalcScrollBar(NewTopLeft.Y, 1);
      //
      if OldNewTopLeftX = NewTopLeft.X then Break;
    until (NewTopLeft.Y <= FixedRows) or (NewTopLeft.Y >= MaxTopLeft.Y)
      or (RowHeights[NewTopLeft.Y] > 0);
  NewTopLeft.X := Math.Max(FixedCols, Math.Min(MaxTopLeft.X, NewTopLeft.X));
  NewTopLeft.Y := Math.Max(FixedRows, Math.Min(MaxTopLeft.Y, NewTopLeft.Y));
  if (NewTopLeft.X <> FTopLeft.X) or (NewTopLeft.Y <> FTopLeft.Y) then
    MoveTopLeft(NewTopLeft.X, NewTopLeft.Y);
end;

procedure TbsSkinCustomGrid.MoveAdjust(var CellPos: Longint; FromIndex, ToIndex: Longint);
var
  Min, Max: Longint;
begin
  if CellPos = FromIndex then CellPos := ToIndex
  else
  begin
    Min := FromIndex;
    Max := ToIndex;
    if FromIndex > ToIndex then
    begin
      Min := ToIndex;
      Max := FromIndex;
    end;
    if (CellPos >= Min) and (CellPos <= Max) then
      if FromIndex > ToIndex then
        Inc(CellPos) else
        Dec(CellPos);
  end;
end;

procedure TbsSkinCustomGrid.MoveAnchor(const NewAnchor: TGridCoord);
var
  OldSel: TGridRect;
begin
  if [goRangeSelect, goEditing] * Options = [goRangeSelect] then
  begin
    OldSel := Selection;
    FAnchor := NewAnchor;
    if goRowSelect in Options then FAnchor.X := ColCount - 1;
    ClampInView(NewAnchor);
    SelectionMoved(OldSel);
  end
  else MoveCurrent(NewAnchor.X, NewAnchor.Y, True, True);
end;

procedure TbsSkinCustomGrid.MoveCurrent(ACol, ARow: Longint; MoveAnchor,
  Show: Boolean);
var
  OldSel: TGridRect;
  OldCurrent: TGridCoord;
begin
  if (ACol < 0) or (ARow < 0) or (ACol >= ColCount) or (ARow >= RowCount) then
    InvalidOp(SIndexOutOfRange);
  if SelectCell(ACol, ARow) then
  begin
    OldSel := Selection;
    OldCurrent := FCurrent;
    FCurrent.X := ACol;
    FCurrent.Y := ARow;
    if not (goAlwaysShowEditor in Options) then HideEditor;
    if MoveAnchor or not (goRangeSelect in Options) then
    begin
      FAnchor := FCurrent;
      if goRowSelect in Options then FAnchor.X := ColCount - 1;
    end;
    if goRowSelect in Options then FCurrent.X := FixedCols;
    if Show then ClampInView(FCurrent);
    SelectionMoved(OldSel);
    with OldCurrent do InvalidateCell(X, Y);
    with FCurrent do InvalidateCell(ACol, ARow);
  end;
end;

procedure TbsSkinCustomGrid.MoveTopLeft(ALeft, ATop: Longint);
var
  OldTopLeft: TGridCoord;
begin
  if (ALeft = FTopLeft.X) and (ATop = FTopLeft.Y) then Exit;
  Update;
  OldTopLeft := FTopLeft;
  FTopLeft.X := ALeft;
  FTopLeft.Y := ATop;
  TopLeftMoved(OldTopLeft);
end;

procedure TbsSkinCustomGrid.ResizeCol(Index: Longint; OldSize, NewSize: Integer);
begin
  InvalidateGrid;
end;

procedure TbsSkinCustomGrid.ResizeRow(Index: Longint; OldSize, NewSize: Integer);
begin
  InvalidateGrid;
end;

procedure TbsSkinCustomGrid.SelectionMoved(const OldSel: TGridRect);
var
  OldRect, NewRect: TRect;
  AXorRects: TXorRects;
  I: Integer;
begin
  if not HandleAllocated then Exit;
  GridRectToScreenRect(OldSel, OldRect, True);
  GridRectToScreenRect(Selection, NewRect, True);
  XorRects(OldRect, NewRect, AXorRects);
  for I := Low(AXorRects) to High(AXorRects) do
    Windows.InvalidateRect(Handle, @AXorRects[I], False);
end;

procedure TbsSkinCustomGrid.ScrollDataInfo(DX, DY: Integer;
  var DrawInfo: TbsGridDrawInfo);
var
  ScrollArea: TRect;
  ScrollFlags: Integer;
begin
  with DrawInfo do
  begin
    ScrollFlags := SW_INVALIDATE;
    if not DefaultDrawing then
      ScrollFlags := ScrollFlags or SW_ERASE;
    { Scroll the area }
    if DY = 0 then
    begin
      { Scroll both the column titles and data area at the same time }
      if not UseRightToLeftAlignment then
        ScrollArea := Rect(Horz.FixedBoundary, 0, Horz.GridExtent-1, Vert.GridExtent)
      else
      begin
        ScrollArea := Rect(ClientWidth - Horz.GridExtent + 1, 0, ClientWidth - Horz.FixedBoundary, Vert.GridExtent);
        DX := -DX;
      end;
      ScrollWindowEx(Handle, DX, 0, @ScrollArea, @ScrollArea, 0, nil, ScrollFlags);
    end
    else if DX = 0 then
    begin
      { Scroll both the row titles and data area at the same time }
      ScrollArea := Rect(0, Vert.FixedBoundary, Horz.GridExtent, Vert.GridExtent);
      ScrollWindowEx(Handle, 0, DY, @ScrollArea, @ScrollArea, 0, nil, ScrollFlags);
    end
    else
    begin
      { Scroll titles and data area separately }
      { Column titles }
      ScrollArea := Rect(Horz.FixedBoundary, 0, Horz.GridExtent-1, Vert.FixedBoundary);
      ScrollWindowEx(Handle, DX, 0, @ScrollArea, @ScrollArea, 0, nil, ScrollFlags);
      { Row titles }
      ScrollArea := Rect(0, Vert.FixedBoundary, Horz.FixedBoundary, Vert.GridExtent);
      ScrollWindowEx(Handle, 0, DY, @ScrollArea, @ScrollArea, 0, nil, ScrollFlags);
      { Data area }
      ScrollArea := Rect(Horz.FixedBoundary, Vert.FixedBoundary, Horz.GridExtent,
        Vert.GridExtent);
      ScrollWindowEx(Handle, DX, DY, @ScrollArea, @ScrollArea, 0, nil, ScrollFlags);
    end;
  end;
  if goRowSelect in Options then
    InvalidateRect(Selection);
end;

procedure TbsSkinCustomGrid.ScrollData(DX, DY: Integer);
var
  DrawInfo: TbsGridDrawInfo;
begin
  CalcDrawInfo(DrawInfo);
  ScrollDataInfo(DX, DY, DrawInfo);
end;

procedure TbsSkinCustomGrid.TopLeftMoved(const OldTopLeft: TGridCoord);

  function CalcScroll(const AxisInfo: TbsGridAxisDrawInfo;
    OldPos, CurrentPos: Integer; var Amount: Longint): Boolean;
  var
    Start, Stop: Longint;
    I: Longint;
  begin
    Result := False;
    with AxisInfo do
    begin
      if OldPos < CurrentPos then
      begin
        Start := OldPos;
        Stop := CurrentPos;
      end
      else
      begin
        Start := CurrentPos;
        Stop := OldPos;
      end;
      Amount := 0;
      for I := Start to Stop - 1 do
      begin
        Inc(Amount, GetExtent(I) + EffectiveLineWidth);
        if Amount > (GridBoundary - FixedBoundary) then
        begin
          { Scroll amount too big, redraw the whole thing }
          InvalidateGrid;
          Exit;
        end;
      end;
      if OldPos < CurrentPos then Amount := -Amount;
    end;
    Result := True;
  end;

var
  DrawInfo: TbsGridDrawInfo;
  Delta: TGridCoord;
  R: TRect;
begin
  UpdateScrollPos(True);
  CalcDrawInfo(DrawInfo);
  if CalcScroll(DrawInfo.Horz, OldTopLeft.X, FTopLeft.X, Delta.X) and
    CalcScroll(DrawInfo.Vert, OldTopLeft.Y, FTopLeft.Y, Delta.Y) then
    ScrollDataInfo(Delta.X, Delta.Y, DrawInfo);
  TopLeftChanged;
  R.Left := GridWidth;
  if R.Left >= Width then R.Left := Width - 1;
  R.Top := 0;
  R.Right := Width;
  R.Bottom := Height;
  Windows.InvalidateRect(Handle, @R, True);
end;

procedure TbsSkinCustomGrid.UpdateScrollPos;
var
  DrawInfo: TbsGridDrawInfo;
  MaxTopLeft: TGridCoord;
  GridSpace, ColWidth: Integer;

  procedure SetScroll(Code: Word; Value: Integer);
  begin
    if UseRightToLeftAlignment and (Code = SB_HORZ) then
      if ColCount <> 1 then Value := MaxShortInt - Value
      else                  Value := (ColWidth - GridSpace) - Value;
     case Code of
       SB_HORZ:
         if FHScrollBar <> nil then
         begin
           FHScrollBar.SimplySetPosition(Value);
         end;
       SB_VERT:
         if (FVScrollBar <> nil) and UpDateVert then
         begin
           FVScrollBar.SimplySetPosition(Value);
         end;
     end;
  end;

begin
  if (not HandleAllocated) then Exit;
  CalcDrawInfo(DrawInfo);
  MaxTopLeft.X := ColCount - 1;
  MaxTopLeft.Y := RowCount - 1;
  MaxTopLeft := CalcMaxTopLeft(MaxTopLeft, DrawInfo);
    if ColCount = 1 then
    begin
      ColWidth := ColWidths[DrawInfo.Horz.FirstGridCell];
      GridSpace := ClientWidth - DrawInfo.Horz.FixedBoundary;
      if (FColOffset > 0) and (GridSpace > (ColWidth - FColOffset)) then
        ModifyScrollbar(SB_HORZ, SB_THUMBPOSITION, ColWidth - GridSpace, True)
      else
        SetScroll(SB_HORZ, FColOffset)
    end
    else
      SetScroll(SB_HORZ, LongMulDiv(FTopLeft.X - FixedCols, MaxShortInt,
        MaxTopLeft.X - FixedCols));


    SetScroll(SB_VERT, LongMulDiv(FTopLeft.Y - FixedRows, MaxShortInt,
      MaxTopLeft.Y - FixedRows));
end;

type
  ParentControl = class(TWinControl);

procedure TbsSkinCustomGrid.UpdateScrollRange;
var
  MaxTopLeft, OldTopLeft: TGridCoord;
  DrawInfo: TbsGridDrawInfo;
  Updated: Boolean;
  VVisibleChanged, HVisibleChanged: Boolean;
  VVisible, HVisible: Boolean;
  K: Integer;

  procedure DoUpdate;
  begin
    if not Updated then
    begin
      Update;
      Updated := True;
    end;
  end;

  procedure CalcSizeInfo;
  begin
    CalcDrawInfoXY(DrawInfo, DrawInfo.Horz.GridExtent, DrawInfo.Vert.GridExtent);
    MaxTopLeft.X := ColCount - 1;
    MaxTopLeft.Y := RowCount - 1;
    MaxTopLeft := CalcMaxTopLeft(MaxTopLeft, DrawInfo);
  end;

  procedure SetAxisRange(var Max, Old, Current: Longint; Code: Word;
    Fixeds: Integer);
  begin
    CalcSizeInfo;
    if Fixeds < Max then
      begin
        case Code of
          SB_HORZ:
            if FHScrollBar <> nil then
            begin
              FHScrollBar.SetRange(0, MaxShortInt, FHScrollBar.Position, 0);
              K := ColCount - GetVisibleColCount - FixedCols;
              if K = 0 then K := 1;
              FHScrollBar.SmallChange := FHScrollBar.Max div K;

              if FHScrollBar.SmallChange = 0
              then FHScrollBar.SmallChange := 1;

              FHScrollBar.LargeChange := FHScrollBar.SmallChange;
              if not FHScrollBar.Visible
              then
                begin
                  HVisible := True;
                  HVisibleChanged := True;
                end;
            end;
          SB_VERT:
            if (FVScrollBar <> nil) and UpDateVert then
            begin
              FVScrollBar.SetRange(0, MaxShortInt, FVScrollBar.Position, 0);
              FVScrollBar.SmallChange := FVScrollBar.Max div
               (RowCount - GetVisibleRowCount - FixedRows);
              if FVScrollBar.SmallChange = 0
              then FVScrollBar.SmallChange := 1;
              FVScrollBar.LargeChange := FVScrollBar.SmallChange;
              if not FVScrollBar.Visible
              then
                begin
                  VVisibleChanged := True;
                  VVisible := True;
                end;
            end
        end;
      end
    else
      begin
        case Code of
          SB_HORZ:
            if FHScrollBar <> nil then
            begin
              FHScrollBar.SetRange(0, 0, 0, 0);
              if FHScrollBar.Visible
              then
                begin
                  HVisibleChanged := True;
                  HVisible := False;
                end;
            end;
          SB_VERT:
            if (FVScrollBar <> nil) and UpDateVert then
            begin
              FVScrollBar.SetRange(0, 0, 0, 0);
              if FVScrollBar.Visible
              then
                begin
                  VVisibleChanged := True;
                  VVisible := False;
                end;
            end;
        end;
      end;
    if Old > Max then
    begin
      DoUpdate;
      Current := Max;
    end;
  end;

  procedure SetHorzRange;
  var
    Range: Integer;
  begin
      if ColCount = 1 then
      begin
        Range := ColWidths[0] - ClientWidth;
        if Range < 0 then Range := 0;
        // skinscroll
        if (FHScrollBar <> nil)
        then
          if Range > 0
          then
            begin
              FHScrollBar.SetRange(0, Range, FHScrollBar.Position, 0);
              K := ColCount - GetVisibleColCount - FixedCols;
              if K = 0 then K := 1;
              FHScrollBar.SmallChange := FHScrollBar.Max div K;
              if FHScrollBar.SmallChange = 0
              then FHScrollBar.SmallChange := 1;
              FHScrollBar.LargeChange := FHScrollBar.SmallChange;
              if not FHScrollBar.Visible
              then
                begin
                  HVisibleChanged := True;
                  HVisible:= True;
                end;
            end
          else
            if FHScrollBar.Visible
            then
              begin
                HVisibleChanged := True;
                HVisible:= False;
              end;
      end
      else
        SetAxisRange(MaxTopLeft.X, OldTopLeft.X, FTopLeft.X, SB_HORZ, FixedCols);
  end;

  procedure SetVertRange;
  begin
    SetAxisRange(MaxTopLeft.Y, OldTopLeft.Y, FTopLeft.Y, SB_VERT, FixedRows);
  end;

var
  R: TRect;
begin
  if not HandleAllocated or not Showing or FInCheckScrollBars then Exit;

  VVisibleChanged := False;
  HVisibleChanged := False;

  with DrawInfo do
  begin
    Horz.GridExtent := ClientWidth;
    Vert.GridExtent := ClientHeight;
  end;
  OldTopLeft := FTopLeft;
  { Temporarily mark us as not having scroll bars to avoid recursion }
  Updated := False;
  SetHorzRange;
  DrawInfo.Vert.GridExtent := ClientHeight;
  SetVertRange;
  if DrawInfo.Horz.GridExtent <> ClientWidth then
  begin
    DrawInfo.Horz.GridExtent := ClientWidth;
    SetHorzRange;
  end;
  UpdateScrollPos(True);
  if (FTopLeft.X <> OldTopLeft.X) or (FTopLeft.Y <> OldTopLeft.Y) then
    TopLeftMoved(OldTopLeft);

  FInCheckScrollBars := True;
  if VVisibleChanged then FVScrollBar.Visible := VVisible;
  if HVisibleChanged then FHScrollBar.Visible := HVisible;
  FInCheckScrollBars := False;

  if (FVScrollBar <> nil) and (FHScrollBar <> nil)
  then
    begin
      if not FVScrollBar.Visible and FHScrollBar.Both
      then
        FHScrollBar.Both := False
      else
        if FVScrollBar.Visible and not FHScrollBar.Both
        then
          FHScrollBar.Both := True;
    end;
  if (Self.Align <> alNone) and (HVisibleChanged or VVisibleChanged)
  then
    begin
      R := Parent.ClientRect;
      FInCheckScrollBars := True;
      ParentControl(Parent).AlignControls(nil, R);
      Invalidate;
      FInCheckScrollBars := False;
    end;
end;

function TbsSkinCustomGrid.CreateEditor: TbsSkinInplaceEdit;
begin
  Result := TbsSkinInplaceEdit.Create(Self);
end;

procedure TbsSkinCustomGrid.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style or WS_TABSTOP;
    Style := Style and not WS_VSCROLL;
    Style := Style and not WS_HSCROLL;
    WindowClass.style := CS_DBLCLKS;
  end;
end;

procedure TbsSkinCustomGrid.KeyDown(var Key: Word; Shift: TShiftState);
var
  NewTopLeft, NewCurrent, MaxTopLeft: TGridCoord;
  DrawInfo: TbsGridDrawInfo;
  PageWidth, PageHeight: Integer;
  RTLFactor: Integer;

  procedure CalcPageExtents;
  begin
    CalcDrawInfo(DrawInfo);
    PageWidth := DrawInfo.Horz.LastFullVisibleCell - LeftCol;
    if PageWidth < 1 then PageWidth := 1;
    PageHeight := DrawInfo.Vert.LastFullVisibleCell - TopRow;
    if PageHeight < 1 then PageHeight := 1;
  end;

  procedure Restrict(var Coord: TGridCoord; MinX, MinY, MaxX, MaxY: Longint);
  begin
    with Coord do
    begin
      if X > MaxX then X := MaxX
      else if X < MinX then X := MinX;
      if Y > MaxY then Y := MaxY
      else if Y < MinY then Y := MinY;
    end;
  end;

begin
  inherited KeyDown(Key, Shift);
  if not CanGridAcceptKey(Key, Shift) then Key := 0;
  if not UseRightToLeftAlignment then
    RTLFactor := 1
  else
    RTLFactor := -1;
  NewCurrent := FCurrent;
  NewTopLeft := FTopLeft;
  CalcPageExtents;
  if ssCtrl in Shift then
    case Key of
      VK_UP: Dec(NewTopLeft.Y);
      VK_DOWN: Inc(NewTopLeft.Y);
      VK_LEFT:
        if not (goRowSelect in Options) then
        begin
          Dec(NewCurrent.X, PageWidth * RTLFactor);
          Dec(NewTopLeft.X, PageWidth * RTLFactor);
        end;
      VK_RIGHT:
        if not (goRowSelect in Options) then
        begin
          Inc(NewCurrent.X, PageWidth * RTLFactor);
          Inc(NewTopLeft.X, PageWidth * RTLFactor);
        end;
      VK_PRIOR: NewCurrent.Y := TopRow;
      VK_NEXT: NewCurrent.Y := DrawInfo.Vert.LastFullVisibleCell;
      VK_HOME:
        begin
          NewCurrent.X := FixedCols;
          NewCurrent.Y := FixedRows;
        end;
      VK_END:
        begin
          NewCurrent.X := ColCount - 1;
          NewCurrent.Y := RowCount - 1;
        end;
    end
  else
    case Key of
      VK_UP: Dec(NewCurrent.Y);
      VK_DOWN: Inc(NewCurrent.Y);
      VK_LEFT:
        if goRowSelect in Options then
          Dec(NewCurrent.Y, RTLFactor) else
          Dec(NewCurrent.X, RTLFactor);
      VK_RIGHT:
        if goRowSelect in Options then
          Inc(NewCurrent.Y, RTLFactor) else
          Inc(NewCurrent.X, RTLFactor);
      VK_NEXT:
        begin
          Inc(NewCurrent.Y, PageHeight);
          Inc(NewTopLeft.Y, PageHeight);
        end;
      VK_PRIOR:
        begin
          Dec(NewCurrent.Y, PageHeight);
          Dec(NewTopLeft.Y, PageHeight);
        end;
      VK_HOME:
        if goRowSelect in Options then
          NewCurrent.Y := FixedRows else
          NewCurrent.X := FixedCols;
      VK_END:
        if goRowSelect in Options then
          NewCurrent.Y := RowCount - 1 else
          NewCurrent.X := ColCount - 1;
      VK_TAB:
        if not (ssAlt in Shift) then
        repeat
          if ssShift in Shift then
          begin
            Dec(NewCurrent.X);
            if NewCurrent.X < FixedCols then
            begin
              NewCurrent.X := ColCount - 1;
              Dec(NewCurrent.Y);
              if NewCurrent.Y < FixedRows then NewCurrent.Y := RowCount - 1;
            end;
            Shift := [];
          end
          else
          begin
            Inc(NewCurrent.X);
            if NewCurrent.X >= ColCount then
            begin
              NewCurrent.X := FixedCols;
              Inc(NewCurrent.Y);
              if NewCurrent.Y >= RowCount then NewCurrent.Y := FixedRows;
            end;
          end;
        until TabStops[NewCurrent.X] or (NewCurrent.X = FCurrent.X);
      VK_F2: EditorMode := True;
    end;
  MaxTopLeft.X := ColCount - 1;
  MaxTopLeft.Y := RowCount - 1;
  MaxTopLeft := CalcMaxTopLeft(MaxTopLeft, DrawInfo);
  Restrict(NewTopLeft, FixedCols, FixedRows, MaxTopLeft.X, MaxTopLeft.Y);
  if (NewTopLeft.X <> LeftCol) or (NewTopLeft.Y <> TopRow) then
    MoveTopLeft(NewTopLeft.X, NewTopLeft.Y);
  Restrict(NewCurrent, FixedCols, FixedRows, ColCount - 1, RowCount - 1);
  if (NewCurrent.X <> Col) or (NewCurrent.Y <> Row) then
    FocusCell(NewCurrent.X, NewCurrent.Y, not (ssShift in Shift));
end;

procedure TbsSkinCustomGrid.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  if not (goAlwaysShowEditor in Options) and (Key = #13) then
  begin
    if FEditorMode then
      HideEditor else
      ShowEditor;
    Key := #0;
  end;
end;

procedure TbsSkinCustomGrid.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  CellHit: TGridCoord;
  DrawInfo: TbsGridDrawInfo;
  MoveDrawn: Boolean;
begin
  MoveDrawn := False;
  HideEdit;
  if not (csDesigning in ComponentState) and
    (CanFocus or (GetParentForm(Self) = nil)) then
  begin
    SetFocus;
    if not IsActiveControl then
    begin
      MouseCapture := False;
      Exit;
    end;
  end;
  if (Button = mbLeft) and (ssDouble in Shift) then
    DblClick
  else if Button = mbLeft then
  begin
    CalcDrawInfo(DrawInfo);
    { Check grid sizing }
    CalcSizingState(X, Y, FGridState, FSizingIndex, FSizingPos, FSizingOfs,
      DrawInfo);
    if FGridState <> gsNormal then
    begin
      if UseRightToLeftAlignment then
        FSizingPos := ClientWidth - FSizingPos;
      DrawSizingLine(DrawInfo);
      Exit;
    end;
    CellHit := CalcCoordFromPoint(X, Y, DrawInfo);
    if (CellHit.X >= FixedCols) and (CellHit.Y >= FixedRows) then
    begin
      if goEditing in Options then
      begin
        if (CellHit.X = FCurrent.X) and (CellHit.Y = FCurrent.Y) then
          ShowEditor
        else
        begin
          MoveCurrent(CellHit.X, CellHit.Y, True, True);
          UpdateEdit;
        end;
        Click;
      end
      else
      begin
        FGridState := gsSelecting;
        SetTimer(Handle, 1, 60, nil);
        if ssShift in Shift then
          MoveAnchor(CellHit)
        else
          MoveCurrent(CellHit.X, CellHit.Y, True, True);
      end;
    end
    else if (goRowMoving in Options) and (CellHit.X >= 0) and
      (CellHit.X < FixedCols) and (CellHit.Y >= FixedRows) then
    begin
      FMoveIndex := CellHit.Y;
      FMovePos := FMoveIndex;
      if BeginRowDrag(FMoveIndex, FMovePos, Point(X,Y)) then
      begin
        FGridState := gsRowMoving;
        Update;
        DrawMove;
        MoveDrawn := True;
        SetTimer(Handle, 1, 60, nil);
      end;
    end
    else if (goColMoving in Options) and (CellHit.Y >= 0) and
      (CellHit.Y < FixedRows) and (CellHit.X >= FixedCols) then
    begin
      FMoveIndex := CellHit.X;
      FMovePos := FMoveIndex;
      if BeginColumnDrag(FMoveIndex, FMovePos, Point(X,Y)) then
      begin
        FGridState := gsColMoving;
        Update;
        DrawMove;
        MoveDrawn := True;
        SetTimer(Handle, 1, 60, nil);
      end;
    end;
  end;
  try
    inherited MouseDown(Button, Shift, X, Y);
  except
    if MoveDrawn then DrawMove;
  end;
end;

procedure TbsSkinCustomGrid.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  DrawInfo: TbsGridDrawInfo;
  CellHit: TGridCoord;
begin
  CalcDrawInfo(DrawInfo);
  case FGridState of
    gsSelecting, gsColMoving, gsRowMoving:
      begin
        CellHit := CalcCoordFromPoint(X, Y, DrawInfo);
        if (CellHit.X >= FixedCols) and (CellHit.Y >= FixedRows) and
          (CellHit.X <= DrawInfo.Horz.LastFullVisibleCell+1) and
          (CellHit.Y <= DrawInfo.Vert.LastFullVisibleCell+1) then
          case FGridState of
            gsSelecting:
              if ((CellHit.X <> FAnchor.X) or (CellHit.Y <> FAnchor.Y)) then
                MoveAnchor(CellHit);
            gsColMoving:
              MoveAndScroll(X, CellHit.X, DrawInfo, DrawInfo.Horz, SB_HORZ, Point(X,Y));
            gsRowMoving:
              MoveAndScroll(Y, CellHit.Y, DrawInfo, DrawInfo.Vert, SB_VERT, Point(X,Y));
          end;
      end;
    gsRowSizing, gsColSizing:
      begin
        DrawSizingLine(DrawInfo); { XOR it out }
        if FGridState = gsRowSizing then
          FSizingPos := Y + FSizingOfs else
          FSizingPos := X + FSizingOfs;
        DrawSizingLine(DrawInfo); { XOR it back in }
      end;
  end;
  inherited MouseMove(Shift, X, Y);
end;

procedure TbsSkinCustomGrid.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  DrawInfo: TbsGridDrawInfo;
  NewSize: Integer;

  function ResizeLine(const AxisInfo: TbsGridAxisDrawInfo): Integer;
  var
    I: Integer;
  begin
    with AxisInfo do
    begin
      Result := FixedBoundary;
      for I := FirstGridCell to FSizingIndex - 1 do
        Inc(Result, GetExtent(I) + EffectiveLineWidth);
      Result := FSizingPos - Result;
    end;
  end;

begin
  try
    case FGridState of
      gsSelecting:
        begin
          MouseMove(Shift, X, Y);
          KillTimer(Handle, 1);
          UpdateEdit;
          Click;
        end;
      gsRowSizing, gsColSizing:
        begin
          CalcDrawInfo(DrawInfo);
          DrawSizingLine(DrawInfo);
          if UseRightToLeftAlignment then
            FSizingPos := ClientWidth - FSizingPos;
          if FGridState = gsColSizing then
          begin
            NewSize := ResizeLine(DrawInfo.Horz);
            if NewSize > 1 then
            begin
              ColWidths[FSizingIndex] := NewSize;
              UpdateDesigner;
            end;
          end
          else
          begin
            NewSize := ResizeLine(DrawInfo.Vert);
            if NewSize > 1 then
            begin
              RowHeights[FSizingIndex] := NewSize;
              UpdateDesigner;
            end;
          end;
        end;
      gsColMoving:
        begin
          DrawMove;
          KillTimer(Handle, 1);
          if EndColumnDrag(FMoveIndex, FMovePos, Point(X,Y))
            and (FMoveIndex <> FMovePos) then
          begin
            MoveColumn(FMoveIndex, FMovePos);
            UpdateDesigner;
          end;
          UpdateEdit;
        end;
      gsRowMoving:
        begin
          DrawMove;
          KillTimer(Handle, 1);
          if EndRowDrag(FMoveIndex, FMovePos, Point(X,Y))
            and (FMoveIndex <> FMovePos) then
          begin
            MoveRow(FMoveIndex, FMovePos);
            UpdateDesigner;
          end;
          UpdateEdit;
        end;
    else
      UpdateEdit;
    end;
    inherited MouseUp(Button, Shift, X, Y);
  finally
    FGridState := gsNormal;
  end;
end;

procedure TbsSkinCustomGrid.MoveAndScroll(Mouse, CellHit: Integer;
  var DrawInfo: TbsGridDrawInfo; var Axis: TbsGridAxisDrawInfo;
  ScrollBar: Integer; const MousePt: TPoint);
begin
  if UseRightToLeftAlignment and (ScrollBar = SB_HORZ) then
    Mouse := ClientWidth - Mouse;
  if (CellHit <> FMovePos) and
    not((FMovePos = Axis.FixedCellCount) and (Mouse < Axis.FixedBoundary)) and
    not((FMovePos = Axis.GridCellCount-1) and (Mouse > Axis.GridBoundary)) then
  begin
    DrawMove;   // hide the drag line
    if (Mouse < Axis.FixedBoundary) then
    begin
      if (FMovePos > Axis.FixedCellCount) then
      begin
        ModifyScrollbar(ScrollBar, SB_LINEUP, 0, False);
        Update;
        CalcDrawInfo(DrawInfo);    // this changes contents of Axis var
      end;
      CellHit := Axis.FirstGridCell;
    end
    else if (Mouse >= Axis.FullVisBoundary) then
    begin
      if (FMovePos = Axis.LastFullVisibleCell) and
        (FMovePos < Axis.GridCellCount -1) then
      begin
        ModifyScrollBar(Scrollbar, SB_LINEDOWN, 0, False);
        Update;
        CalcDrawInfo(DrawInfo);    // this changes contents of Axis var
      end;
      CellHit := Axis.LastFullVisibleCell;
    end
    else if CellHit < 0 then CellHit := FMovePos;
    if ((FGridState = gsColMoving) and CheckColumnDrag(FMoveIndex, CellHit, MousePt))
      or ((FGridState = gsRowMoving) and CheckRowDrag(FMoveIndex, CellHit, MousePt)) then
      FMovePos := CellHit;
    DrawMove;
  end;
end;

function TbsSkinCustomGrid.GetColWidths(Index: Longint): Integer;
begin
  if (FColWidths = nil) or (Index >= ColCount) then
    Result := DefaultColWidth
  else
    Result := PIntArray(FColWidths)^[Index + 1];
end;

function TbsSkinCustomGrid.GetRowHeights(Index: Longint): Integer;
begin
  if (FRowHeights = nil) or (Index >= RowCount) then
    Result := DefaultRowHeight
  else
    Result := PIntArray(FRowHeights)^[Index + 1];
end;

function TbsSkinCustomGrid.GetGridWidth: Integer;
var
  DrawInfo: TbsGridDrawInfo;
begin
  CalcDrawInfo(DrawInfo);
  Result := DrawInfo.Horz.GridBoundary;
end;

function TbsSkinCustomGrid.GetGridHeight: Integer;
var
  DrawInfo: TbsGridDrawInfo;
begin
  CalcDrawInfo(DrawInfo);
  Result := DrawInfo.Vert.GridBoundary;
end;

function TbsSkinCustomGrid.GetSelection: TGridRect;
begin
  Result := GridRect(FCurrent, FAnchor);
end;

function TbsSkinCustomGrid.GetTabStops(Index: Longint): Boolean;
begin
  if FTabStops = nil then Result := True
  else Result := Boolean(PIntArray(FTabStops)^[Index + 1]);
end;

function TbsSkinCustomGrid.GetVisibleColCount: Integer;
var
  DrawInfo: TbsGridDrawInfo;
begin
  CalcDrawInfo(DrawInfo);
  Result := DrawInfo.Horz.LastFullVisibleCell - LeftCol + 1;
end;

function TbsSkinCustomGrid.GetVisibleRowCount: Integer;
var
  DrawInfo: TbsGridDrawInfo;
begin
  CalcDrawInfo(DrawInfo);
  Result := DrawInfo.Vert.LastFullVisibleCell - TopRow + 1;
end;

procedure TbsSkinCustomGrid.SetBorderStyle(Value: TBorderStyle);
begin
  if FBorderStyle <> Value then
  begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;

procedure TbsSkinCustomGrid.SetCol(Value: Longint);
begin
  if Col <> Value then FocusCell(Value, Row, True);
end;

procedure TbsSkinCustomGrid.SetColCount(Value: Longint);
begin
  if FColCount <> Value then
  begin
    if Value < 1 then Value := 1;
    if Value <= FixedCols then FixedCols := Value - 1;
    ChangeSize(Value, RowCount);
    if goRowSelect in Options then
    begin
      FAnchor.X := ColCount - 1;
      Invalidate;
    end;
  end;
end;

procedure TbsSkinCustomGrid.SetColWidths(Index: Longint; Value: Integer);
begin
  if FColWidths = nil then
    UpdateExtents(FColWidths, ColCount, DefaultColWidth);
  if Index >= ColCount then InvalidOp(SIndexOutOfRange);
  if Value <> PIntArray(FColWidths)^[Index + 1] then
  begin
    ResizeCol(Index, PIntArray(FColWidths)^[Index + 1], Value);
    PIntArray(FColWidths)^[Index + 1] := Value;
    ColWidthsChanged;
  end;
end;

procedure TbsSkinCustomGrid.SetDefaultColWidth(Value: Integer);
begin
  if FColWidths <> nil then UpdateExtents(FColWidths, 0, 0);
  FDefaultColWidth := Value;
  ColWidthsChanged;
  InvalidateGrid;
end;

procedure TbsSkinCustomGrid.SetDefaultRowHeight(Value: Integer);
begin
  if FRowHeights <> nil then UpdateExtents(FRowHeights, 0, 0);
  FDefaultRowHeight := Value;
  RowHeightsChanged;
  InvalidateGrid;
end;

procedure TbsSkinCustomGrid.SetFixedColor(Value: TColor);
begin
  if FFixedColor <> Value then
  begin
    FFixedColor := Value;
    InvalidateGrid;
  end;
end;

procedure TbsSkinCustomGrid.SetFixedCols(Value: Integer);
begin
  if FFixedCols <> Value then
  begin
    if Value < 0 then InvalidOp(SIndexOutOfRange);
    if Value >= ColCount then InvalidOp(SFixedColTooBig);
    FFixedCols := Value;
    Initialize;
    InvalidateGrid;
  end;
end;

procedure TbsSkinCustomGrid.SetFixedRows(Value: Integer);
begin
  if FFixedRows <> Value then
  begin
    if Value < 0 then InvalidOp(SIndexOutOfRange);
    if Value >= RowCount then InvalidOp(SFixedRowTooBig);
    FFixedRows := Value;
    Initialize;
    InvalidateGrid;
  end;
end;

procedure TbsSkinCustomGrid.SetEditorMode(Value: Boolean);
begin
  if not Value then
    HideEditor
  else
  begin
    ShowEditor;
    if FInplaceEdit <> nil then FInplaceEdit.Deselect;
  end;
end;

procedure TbsSkinCustomGrid.SetGridLineWidth(Value: Integer);
begin
  if FGridLineWidth <> Value then
  begin
    FGridLineWidth := Value;
    InvalidateGrid;
  end;
end;

procedure TbsSkinCustomGrid.SetLeftCol(Value: Longint);
begin
  if FTopLeft.X <> Value then MoveTopLeft(Value, TopRow);
end;

procedure TbsSkinCustomGrid.SetOptions(Value: TGridOptions);
begin
  if FOptions <> Value then
  begin
    if goRowSelect in Value then
      Exclude(Value, goAlwaysShowEditor);
    FOptions := Value;
    if not FEditorMode then
      if goAlwaysShowEditor in Value then
        ShowEditor else
        HideEditor;
    if goRowSelect in Value then MoveCurrent(Col, Row,  True, False);
    InvalidateGrid;
  end;
end;

procedure TbsSkinCustomGrid.SetRow(Value: Longint);
begin
  if Row <> Value then FocusCell(Col, Value, True);
end;

procedure TbsSkinCustomGrid.SetRowCount(Value: Longint);
begin
  if FRowCount <> Value then
  begin
    if Value < 1 then Value := 1;
    if Value <= FixedRows then FixedRows := Value - 1;
    ChangeSize(ColCount, Value);
  end;
end;

procedure TbsSkinCustomGrid.SetRowHeights(Index: Longint; Value: Integer);
begin
  if FRowHeights = nil then
    UpdateExtents(FRowHeights, RowCount, DefaultRowHeight);
  if Index >= RowCount then InvalidOp(SIndexOutOfRange);
  if Value <> PIntArray(FRowHeights)^[Index + 1] then
  begin
    ResizeRow(Index, PIntArray(FRowHeights)^[Index + 1], Value);
    PIntArray(FRowHeights)^[Index + 1] := Value;
    RowHeightsChanged;
  end;
end;

procedure TbsSkinCustomGrid.SetSelection(Value: TGridRect);
var
  OldSel: TGridRect;
begin
  OldSel := Selection;
  FAnchor := Value.TopLeft;
  FCurrent := Value.BottomRight;
  SelectionMoved(OldSel);
end;

procedure TbsSkinCustomGrid.SetTabStops(Index: Longint; Value: Boolean);
begin
  if FTabStops = nil then
    UpdateExtents(FTabStops, ColCount, Integer(True));
  if Index >= ColCount then InvalidOp(SIndexOutOfRange);
  PIntArray(FTabStops)^[Index + 1] := Integer(Value);
end;

procedure TbsSkinCustomGrid.SetTopRow(Value: Longint);
begin
  if FTopLeft.Y <> Value then MoveTopLeft(LeftCol, Value);
end;

procedure TbsSkinCustomGrid.HideEdit;
begin
  if FInplaceEdit <> nil then
    try
      UpdateText;
    finally
      FInplaceCol := -1;
      FInplaceRow := -1;
      FInplaceEdit.Hide;
    end;
end;

procedure TbsSkinCustomGrid.UpdateEdit;

  procedure UpdateEditor;
  begin
    FInplaceCol := Col;
    FInplaceRow := Row;
    if FIndex > -1
    then
      begin
        FInplaceEdit.Color := BGColor;
        if FUseSkinFont
        then
          begin
            FInplaceEdit.Font.Name := Self.FontName;
            FInplaceEdit.Font.Color := Self.FontColor;
            FInplaceEdit.Font.Style := Self.FontStyle;
            FInplaceEdit.Font.Height := Self.FontHeight;
          end
        else
          begin
            FInplaceEdit.Font.Assign(Self.Font);
            FInplaceEdit.Font.Color := FontColor;
          end;
      end
    else
      begin
        FInplaceEdit.Color := clWindow;
        FInplaceEdit.Font := Font;
      end;
    if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
    then
      FInplaceEdit.Font.Charset := SkinData.ResourceStrData.CharSet
    else
      FInplaceEdit.Font.CharSet := Self.Font.CharSet;
    FInplaceEdit.UpdateContents;
    if FInplaceEdit.MaxLength = -1 then FCanEditModify := False
    else FCanEditModify := True;
    FInplaceEdit.SelectAll;
  end;

begin
  if CanEditShow then
  begin
    if FInplaceEdit = nil then
    begin
      FInplaceEdit := CreateEditor;
      FInplaceEdit.SetGrid(Self);
      FInplaceEdit.Parent := Self;
      UpdateEditor;
    end
    else
    begin
      if (Col <> FInplaceCol) or (Row <> FInplaceRow) then
      begin
        HideEdit;
        UpdateEditor;
      end;
    end;
    if CanEditShow then FInplaceEdit.Move(CellRect(Col, Row));
  end;
end;

procedure TbsSkinCustomGrid.UpdateText;
begin
  if (FInplaceCol <> -1) and (FInplaceRow <> -1) then
    SetEditText(FInplaceCol, FInplaceRow, FInplaceEdit.Text);
end;

procedure TbsSkinCustomGrid.WMChar(var Msg: TWMChar);
begin
  if (goEditing in Options) and (Char(Msg.CharCode) in [^H, #32..#255]) then
    ShowEditorChar(Char(Msg.CharCode))
  else
    inherited;
end;

procedure TbsSkinCustomGrid.WMCommand(var Message: TWMCommand);
begin
  with Message do
  begin
    if (FInplaceEdit <> nil) and (Ctl = FInplaceEdit.Handle) then
      case NotifyCode of
        EN_CHANGE: UpdateText;
      end;
  end;
end;

procedure TbsSkinCustomGrid.WMGetDlgCode(var Msg: TWMGetDlgCode);
begin
  Msg.Result := DLGC_WANTARROWS;
  if goRowSelect in Options then Exit;
  if goTabs in Options then Msg.Result := Msg.Result or DLGC_WANTTAB;
  if goEditing in Options then Msg.Result := Msg.Result or DLGC_WANTCHARS;
end;

procedure TbsSkinCustomGrid.WMKillFocus(var Msg: TWMKillFocus);
begin
  inherited;
  InvalidateRect(Selection);
  if (FInplaceEdit <> nil) and (Msg.FocusedWnd <> FInplaceEdit.Handle) then
    HideEdit;
end;

procedure TbsSkinCustomGrid.WMLButtonDown(var Message: TMessage);
begin
  inherited;
  if FInplaceEdit <> nil then FInplaceEdit.FClickTime := GetMessageTime;
end;

procedure TbsSkinCustomGrid.WMNCHitTest(var Msg: TWMNCHitTest);
begin
  DefaultHandler(Msg);
  FHitTest := ScreenToClient(SmallPointToPoint(Msg.Pos));
end;

procedure TbsSkinCustomGrid.WMSetCursor(var Msg: TWMSetCursor);
var
  DrawInfo: TbsGridDrawInfo;
  State: TbsGridState;
  Index: Longint;
  Pos, Ofs: Integer;
  Cur: HCURSOR;
begin
  Cur := 0;
  with Msg do
  begin
    if HitTest = HTCLIENT then
    begin
      if FGridState = gsNormal then
      begin
        CalcDrawInfo(DrawInfo);
        CalcSizingState(FHitTest.X, FHitTest.Y, State, Index, Pos, Ofs,
          DrawInfo);
      end else State := FGridState;
      if State = gsRowSizing then
        Cur := Screen.Cursors[crVSplit]
      else if State = gsColSizing then
        Cur := Screen.Cursors[crHSplit]
    end;
  end;
  if Cur <> 0 then SetCursor(Cur)
  else inherited;
end;

procedure TbsSkinCustomGrid.WMSetFocus(var Msg: TWMSetFocus);
begin
  inherited;
  if (FInplaceEdit = nil) or (Msg.FocusedWnd <> FInplaceEdit.Handle) then
  begin
    InvalidateRect(Selection);
    UpdateEdit;
  end;
end;

procedure TbsSkinCustomGrid.WMSize(var Msg: TWMSize);
begin
  inherited;
  if (UseRightToLeftAlignment) or ((FIndex = -1) and (goRowSelect in Options))
  then Invalidate;
  if not FInCheckScrollBars then UpdateScrollRange(True);
end;

procedure TbsSkinCustomGrid.WMVScroll(var Msg: TWMVScroll);
begin
  ModifyScrollBar(SB_VERT, Msg.ScrollCode, Msg.Pos, True);
end;

procedure TbsSkinCustomGrid.WMHScroll(var Msg: TWMHScroll);
begin
  ModifyScrollBar(SB_HORZ, Msg.ScrollCode, Msg.Pos, True);
end;

procedure TbsSkinCustomGrid.CancelMode;
var
  DrawInfo: TbsGridDrawInfo;
begin
  try
    case FGridState of
      gsSelecting:
        KillTimer(Handle, 1);
      gsRowSizing, gsColSizing:
        begin
          CalcDrawInfo(DrawInfo);
          DrawSizingLine(DrawInfo);
        end;
      gsColMoving, gsRowMoving:
        begin
          DrawMove;
          KillTimer(Handle, 1);
        end;
    end;
  finally
    FGridState := gsNormal;
  end;
end;

procedure TbsSkinCustomGrid.WMCancelMode(var Msg: TWMCancelMode);
begin
  inherited;
  CancelMode;
end;

procedure TbsSkinCustomGrid.CMCancelMode(var Msg: TMessage);
begin
  if Assigned(FInplaceEdit) then FInplaceEdit.WndProc(Msg);
  inherited;
  CancelMode;
end;

procedure TbsSkinCustomGrid.CMFontChanged(var Message: TMessage);
begin
  if FInplaceEdit <> nil then FInplaceEdit.Font := Font;
  inherited;
end;

procedure TbsSkinCustomGrid.CMDesignHitTest(var Msg: TCMDesignHitTest);
begin
  Msg.Result := Longint(BOOL(Sizing(Msg.Pos.X, Msg.Pos.Y)));
end;

procedure TbsSkinCustomGrid.CMWanTbsecialKey(var Msg: TCMWantSpecialKey);
begin
  inherited;
  if (goEditing in Options) and (Char(Msg.CharCode) = #13) then Msg.Result := 1;
end;

procedure TbsSkinCustomGrid.TimedScroll(Direction: TGridScrollDirection);
var
  MaxAnchor, NewAnchor: TGridCoord;
begin
  NewAnchor := FAnchor;
  MaxAnchor.X := ColCount - 1;
  MaxAnchor.Y := RowCount - 1;
  if (sdLeft in Direction) and (FAnchor.X > FixedCols) then Dec(NewAnchor.X);
  if (sdRight in Direction) and (FAnchor.X < MaxAnchor.X) then Inc(NewAnchor.X);
  if (sdUp in Direction) and (FAnchor.Y > FixedRows) then Dec(NewAnchor.Y);
  if (sdDown in Direction) and (FAnchor.Y < MaxAnchor.Y) then Inc(NewAnchor.Y);
  if (FAnchor.X <> NewAnchor.X) or (FAnchor.Y <> NewAnchor.Y) then
    MoveAnchor(NewAnchor);
end;

procedure TbsSkinCustomGrid.WMTimer(var Msg: TWMTimer);
var
  Point: TPoint;
  DrawInfo: TbsGridDrawInfo;
  ScrollDirection: TGridScrollDirection;
  CellHit: TGridCoord;
  LeftSide: Integer;
  RightSide: Integer;
begin
  if not (FGridState in [gsSelecting, gsRowMoving, gsColMoving]) then Exit;
  GetCursorPos(Point);
  Point := ScreenToClient(Point);
  CalcDrawInfo(DrawInfo);
  ScrollDirection := [];
  with DrawInfo do
  begin
    CellHit := CalcCoordFromPoint(Point.X, Point.Y, DrawInfo);
    case FGridState of
      gsColMoving:
        MoveAndScroll(Point.X, CellHit.X, DrawInfo, Horz, SB_HORZ, Point);
      gsRowMoving:
        MoveAndScroll(Point.Y, CellHit.Y, DrawInfo, Vert, SB_VERT, Point);
      gsSelecting:
      begin
        if not UseRightToLeftAlignment then
        begin
          if Point.X < Horz.FixedBoundary then Include(ScrollDirection, sdLeft)
          else if Point.X > Horz.FullVisBoundary then Include(ScrollDirection, sdRight);
        end
        else
        begin
          LeftSide := ClientWidth - Horz.FullVisBoundary;
          RightSide := ClientWidth - Horz.FixedBoundary;
          if Point.X < LeftSide then Include(ScrollDirection, sdRight)
          else if Point.X > RightSide then Include(ScrollDirection, sdLeft);
        end;
        if Point.Y < Vert.FixedBoundary then Include(ScrollDirection, sdUp)
        else if Point.Y > Vert.FullVisBoundary then Include(ScrollDirection, sdDown);
        if ScrollDirection <> [] then  TimedScroll(ScrollDirection);
      end;
    end;
  end;
end;

procedure TbsSkinCustomGrid.ColWidthsChanged;
begin
  UpdateScrollRange(True);
  UpdateEdit;
end;

procedure TbsSkinCustomGrid.RowHeightsChanged;
begin
  UpdateScrollRange(True);
  UpdateEdit;
end;

procedure TbsSkinCustomGrid.DeleteColumn(ACol: Longint);
begin
  MoveColumn(ACol, ColCount-1);
  ColCount := ColCount - 1;
end;

procedure TbsSkinCustomGrid.DeleteRow(ARow: Longint);
begin
  MoveRow(ARow, RowCount - 1);
  RowCount := RowCount - 1;
end;

procedure TbsSkinCustomGrid.UpdateDesigner;
var
  ParentForm: TCustomForm;
begin
  if (csDesigning in ComponentState) and HandleAllocated and
    not (csUpdating in ComponentState) then
  begin
    ParentForm := GetParentForm(Self);
    if Assigned(ParentForm) and Assigned(ParentForm.Designer) then
      ParentForm.Designer.Modified;
  end;
end;

function TbsSkinCustomGrid.DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  Result := inherited DoMouseWheelDown(Shift, MousePos);
  if not Result then
  begin
    if Row < RowCount - 1 then Row := Row + 1;
    Result := True;
  end;
end;

function TbsSkinCustomGrid.DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  Result := inherited DoMouseWheelUp(Shift, MousePos);
  if not Result then
  begin
    if Row > FixedRows then Row := Row - 1;
    Result := True;
  end;
end;

function TbsSkinCustomGrid.CheckColumnDrag(var Origin,
  Destination: Integer; const MousePt: TPoint): Boolean;
begin
  Result := True;
end;

function TbsSkinCustomGrid.CheckRowDrag(var Origin,
  Destination: Integer; const MousePt: TPoint): Boolean;
begin
  Result := True;
end;

function TbsSkinCustomGrid.BeginColumnDrag(var Origin, Destination: Integer; const MousePt: TPoint): Boolean;
begin
  Result := True;
end;

function TbsSkinCustomGrid.BeginRowDrag(var Origin, Destination: Integer; const MousePt: TPoint): Boolean;
begin
  Result := True;
end;

function TbsSkinCustomGrid.EndColumnDrag(var Origin, Destination: Integer; const MousePt: TPoint): Boolean;
begin
  Result := True;
end;

function TbsSkinCustomGrid.EndRowDrag(var Origin, Destination: Integer; const MousePt: TPoint): Boolean;
begin
  Result := True;
end;

procedure TbsSkinCustomGrid.WMPAINT;
begin
  inherited;
  if not FInCheckScrollBars then UpDateScrollRange(True);
end;

procedure TbsSkinCustomGrid.CMShowingChanged(var Message: TMessage);
begin
  inherited;
end;

{ TbsSkinDrawGrid }

function TbsSkinDrawGrid.CellRect(ACol, ARow: Longint): TRect;
begin
  Result := inherited CellRect(ACol, ARow);
end;

procedure TbsSkinDrawGrid.MouseToCell(X, Y: Integer; var ACol, ARow: Longint);
var
  Coord: TGridCoord;
begin
  Coord := MouseCoord(X, Y);
  ACol := Coord.X;
  ARow := Coord.Y;
end;

procedure TbsSkinDrawGrid.ColumnMoved(FromIndex, ToIndex: Longint);
begin
  if Assigned(FOnColumnMoved) then FOnColumnMoved(Self, FromIndex, ToIndex);
end;

function TbsSkinDrawGrid.GetEditMask(ACol, ARow: Longint): string;
begin
  Result := '';
  if Assigned(FOnGetEditMask) then FOnGetEditMask(Self, ACol, ARow, Result);
end;

function TbsSkinDrawGrid.GetEditText(ACol, ARow: Longint): string;
begin
  Result := '';
  if Assigned(FOnGetEditText) then FOnGetEditText(Self, ACol, ARow, Result);
end;

procedure TbsSkinDrawGrid.RowMoved(FromIndex, ToIndex: Longint);
begin
  if Assigned(FOnRowMoved) then FOnRowMoved(Self, FromIndex, ToIndex);
end;

function TbsSkinDrawGrid.SelectCell(ACol, ARow: Longint): Boolean;
begin
  Result := True;
  if Assigned(FOnSelectCell) then FOnSelectCell(Self, ACol, ARow, Result);
end;

procedure TbsSkinDrawGrid.SetEditText(ACol, ARow: Longint; const Value: string);
begin
  if Assigned(FOnSetEditText) then FOnSetEditText(Self, ACol, ARow, Value);
end;

procedure TbsSkinDrawGrid.DrawCell(ACol, ARow: Longint; ARect: TRect;
  AState: TGridDrawState);
var
  Hold: Integer;
begin
  if Assigned(FOnDrawCell) then
  begin
    if UseRightToLeftAlignment then
    begin
      ARect.Left := ClientWidth - ARect.Left;
      ARect.Right := ClientWidth - ARect.Right;
      Hold := ARect.Left;
      ARect.Left := ARect.Right;
      ARect.Right := Hold;
      ChangeGridOrientation(False);
    end;
    FOnDrawCell(Self, ACol, ARow, ARect, AState);
    if UseRightToLeftAlignment then ChangeGridOrientation(True);
  end;
end;

procedure TbsSkinDrawGrid.TopLeftChanged;
begin
  inherited TopLeftChanged;
  if Assigned(FOnTopLeftChanged) then FOnTopLeftChanged(Self);
end;

{ StrItem management for TStringSparseList }

type
  PStrItem = ^TStrItem;
  TStrItem = record
    FObject: TObject;
    FString: string;
  end;

function NewStrItem(const AString: string; AObject: TObject): PStrItem;
begin
  New(Result);
  Result^.FObject := AObject;
  Result^.FString := AString;
end;

procedure DisposeStrItem(P: PStrItem);
begin
  Dispose(P);
end;

{ Sparse array classes for TbsSkinStringGrid }

type

  PPointer = ^Pointer;

{ Exception classes }

  EStringSparseListError = class(Exception);

{ TbsarsePointerArray class}

{ Used by TbsarseList.  Based on Sparse1Array, but has Pointer elements
  and Integer index, just like TPointerList/TList, and less indirection }

  { Apply function for the applicator:
        TheIndex        Index of item in array
        TheItem         Value of item (i.e pointer element) in section
        Returns: 0 if success, else error code. }
  TbsAApply = function(TheIndex: Integer; TheItem: Pointer): Integer;

  TSecDir = array[0..4095] of Pointer;  { Enough for up to 12 bits of sec }
  PSecDir = ^TSecDir;
  TbsAQuantum = (SPASmall, SPALarge);   { Section size }

  TbsarsePointerArray = class(TObject)
  private
    secDir: PSecDir;
    slotsInDir: Word;
    indexMask, secShift: Word;
    FHighBound: Integer;
    FSectionSize: Word;
    cachedIndex: Integer;
    cachedPointer: Pointer;
    { Return item[i], nil if slot outside defined section. }
    function  GetAt(Index: Integer): Pointer;
    { Return address of item[i], creating slot if necessary. }
    function  MakeAt(Index: Integer): PPointer;
    { Store item at item[i], creating slot if necessary. }
    procedure PutAt(Index: Integer; Item: Pointer);
  public
    constructor Create(Quantum: TbsAQuantum);
    destructor  Destroy; override;

    { Traverse SPA, calling apply function for each defined non-nil
      item.  The traversal terminates if the apply function returns
      a value other than 0. }
    { NOTE: must be static method so that we can take its address in
      TbsarseList.ForAll }
    function  ForAll(ApplyFunction: Pointer {TbsAApply}): Integer;

    { Ratchet down HighBound after a deletion }
    procedure ResetHighBound;

    property HighBound: Integer read FHighBound;
    property SectionSize: Word read FSectionSize;
    property Items[Index: Integer]: Pointer read GetAt write PutAt; default;
  end;

{ TbsarseList class }

  TbsarseList = class(TObject)
  private
    FList: TbsarsePointerArray;
    FCount: Integer;    { 1 + HighBound, adjusted for Insert/Delete }
    FQuantum: TbsAQuantum;
    procedure NewList(Quantum: TbsAQuantum);
  protected
    procedure Error; virtual;
    function  Get(Index: Integer): Pointer;
    procedure Put(Index: Integer; Item: Pointer);
  public
    constructor Create(Quantum: TbsAQuantum);
    destructor  Destroy; override;
    procedure Clear;
    procedure Delete(Index: Integer);
    procedure Exchange(Index1, Index2: Integer);
    function ForAll(ApplyFunction: Pointer {TbsAApply}): Integer;
    procedure Insert(Index: Integer; Item: Pointer);
    procedure Move(CurIndex, NewIndex: Integer);
    property Count: Integer read FCount;
    property Items[Index: Integer]: Pointer read Get write Put; default;
  end;

{ TStringSparseList class }

  TStringSparseList = class(TStrings)
  private
    FList: TbsarseList;                 { of StrItems }
    FOnChange: TNotifyEvent;
  protected
    function  Get(Index: Integer): String; override;
    function  GetCount: Integer; override;
    function  GetObject(Index: Integer): TObject; override;
    procedure Put(Index: Integer; const S: String); override;
    procedure PutObject(Index: Integer; AObject: TObject); override;
    procedure Changed; virtual;
    procedure Error; virtual;
  public
    constructor Create(Quantum: TbsAQuantum);
    destructor  Destroy; override;
    procedure ReadData(Reader: TReader);
    procedure WriteData(Writer: TWriter);
    procedure DefineProperties(Filer: TFiler); override;
    procedure Delete(Index: Integer); override;
    procedure Exchange(Index1, Index2: Integer); override;
    procedure Insert(Index: Integer; const S: String); override;
    procedure Clear; override;
    property List: TbsarseList read FList;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

{ TbsarsePointerArray }

const
  SPAIndexMask: array[TbsAQuantum] of Byte = (15, 255);
  SPASecShift: array[TbsAQuantum] of Byte = (4, 8);

{ Expand Section Directory to cover at least `newSlots' slots. Returns: Possibly
  updated pointer to the Section Directory. }
function  ExpandDir(secDir: PSecDir; var slotsInDir: Word;
  newSlots: Word): PSecDir;
begin
  Result := secDir;
  ReallocMem(Result, newSlots * SizeOf(Pointer));
  FillChar(Result^[slotsInDir], (newSlots - slotsInDir) * SizeOf(Pointer), 0);
  slotsInDir := newSlots;
end;

{ Allocate a section and set all its items to nil. Returns: Pointer to start of
  section. }
function  MakeSec(SecIndex: Integer; SectionSize: Word): Pointer;
var
  SecP: Pointer;
  Size: Word;
begin
  Size := SectionSize * SizeOf(Pointer);
  GetMem(secP, size);
  FillChar(secP^, size, 0);
  MakeSec := SecP
end;

constructor TbsarsePointerArray.Create(Quantum: TbsAQuantum);
begin
  SecDir := nil;
  SlotsInDir := 0;
  FHighBound := -1;
  FSectionSize := Word(SPAIndexMask[Quantum]) + 1;
  IndexMask := Word(SPAIndexMask[Quantum]);
  SecShift := Word(SPASecShift[Quantum]);
  CachedIndex := -1
end;

destructor TbsarsePointerArray.Destroy;
var
  i:  Integer;
  size: Word;
begin
  { Scan section directory and free each section that exists. }
  i := 0;
  size := FSectionSize * SizeOf(Pointer);
  while i < slotsInDir do begin
    if secDir^[i] <> nil then
      FreeMem(secDir^[i], size);
    Inc(i)
  end;

  { Free section directory. }
  if secDir <> nil then
    FreeMem(secDir, slotsInDir * SizeOf(Pointer));
end;

function  TbsarsePointerArray.GetAt(Index: Integer): Pointer;
var
  byteP: PChar;
  secIndex: Cardinal;
begin
  { Index into Section Directory using high order part of
    index.  Get pointer to Section. If not null, index into
    Section using low order part of index. }
  if Index = cachedIndex then
    Result := cachedPointer
  else begin
    secIndex := Index shr secShift;
    if secIndex >= slotsInDir then
      byteP := nil
    else begin
      byteP := secDir^[secIndex];
      if byteP <> nil then begin
        Inc(byteP, (Index and indexMask) * SizeOf(Pointer));
      end
    end;
    if byteP = nil then Result := nil else Result := PPointer(byteP)^;
    cachedIndex := Index;
    cachedPointer := Result
  end
end;

function  TbsarsePointerArray.MakeAt(Index: Integer): PPointer;
var
  dirP: PSecDir;
  p: Pointer;
  byteP: PChar;
  secIndex: Word;
begin
  { Expand Section Directory if necessary. }
  secIndex := Index shr secShift;       { Unsigned shift }
  if secIndex >= slotsInDir then
    dirP := expandDir(secDir, slotsInDir, secIndex + 1)
  else
    dirP := secDir;

  { Index into Section Directory using high order part of
    index.  Get pointer to Section. If null, create new
    Section.  Index into Section using low order part of index. }
  secDir := dirP;
  p := dirP^[secIndex];
  if p = nil then begin
    p := makeSec(secIndex, FSectionSize);
    dirP^[secIndex] := p
  end;
  byteP := p;
  Inc(byteP, (Index and indexMask) * SizeOf(Pointer));
  if Index > FHighBound then
    FHighBound := Index;
  Result := PPointer(byteP);
  cachedIndex := -1
end;

procedure TbsarsePointerArray.PutAt(Index: Integer; Item: Pointer);
begin
  if (Item <> nil) or (GetAt(Index) <> nil) then
  begin
    MakeAt(Index)^ := Item;
    if Item = nil then
      ResetHighBound
  end
end;

function  TbsarsePointerArray.ForAll(ApplyFunction: Pointer {TbsAApply}):
  Integer;
var
  itemP: PChar;                         { Pointer to item in section }
  item: Pointer;
  i, callerBP: Cardinal;
  j, index: Integer;
begin
  { Scan section directory and scan each section that exists,
    calling the apply function for each non-nil item.
    The apply function must be a far local function in the scope of
    the procedure P calling ForAll.  The trick of setting up the stack
    frame (taken from TurboVision's TCollection.ForEach) allows the
    apply function access to P's arguments and local variables and,
    if P is a method, the instance variables and methods of P's class }
  Result := 0;
  i := 0;
  asm
    mov   eax,[ebp]                     { Set up stack frame for local }
    mov   callerBP,eax
  end;
  while (i < slotsInDir) and (Result = 0) do begin
    itemP := secDir^[i];
    if itemP <> nil then begin
      j := 0;
      index := i shl SecShift;
      while (j < FSectionSize) and (Result = 0) do begin
        item := PPointer(itemP)^;
        if item <> nil then
          { ret := ApplyFunction(index, item.Ptr); }
          asm
            mov   eax,index
            mov   edx,item
            push  callerBP
            call  ApplyFunction
            pop   ecx
            mov   @Result,eax
          end;
        Inc(itemP, SizeOf(Pointer));
        Inc(j);
        Inc(index)
      end
    end;
    Inc(i)
  end;
end;

procedure TbsarsePointerArray.ResetHighBound;
var
  NewHighBound: Integer;

  function  Detector(TheIndex: Integer; TheItem: Pointer): Integer; far;
  begin
    if TheIndex > FHighBound then
      Result := 1
    else
    begin
      Result := 0;
      if TheItem <> nil then NewHighBound := TheIndex
    end
  end;

begin
  NewHighBound := -1;
  ForAll(@Detector);
  FHighBound := NewHighBound
end;

{ TbsarseList }

constructor TbsarseList.Create(Quantum: TbsAQuantum);
begin
  NewList(Quantum)
end;

destructor TbsarseList.Destroy;
begin
  if FList <> nil then FList.Destroy
end;

procedure TbsarseList.Clear;
begin
  FList.Destroy;
  NewList(FQuantum);
  FCount := 0
end;

procedure TbsarseList.Delete(Index: Integer);
var
  I: Integer;
begin
  if (Index < 0) or (Index >= FCount) then Exit;
  for I := Index to FCount - 1 do
    FList[I] := FList[I + 1];
  FList[FCount] := nil;
  Dec(FCount);
end;

procedure TbsarseList.Error;
begin
  raise EListError.Create('List index out of bounds (%d)');
end;

procedure TbsarseList.Exchange(Index1, Index2: Integer);
var
  temp: Pointer;
begin
  temp := Get(Index1);
  Put(Index1, Get(Index2));
  Put(Index2, temp);
end;

{ Jump to TbsarsePointerArray.ForAll so that it looks like it was called
  from our caller, so that the BP trick works. }

function TbsarseList.ForAll(ApplyFunction: Pointer {TbsAApply}): Integer; assembler;
asm
        MOV     EAX,[EAX].TbsarseList.FList
        JMP     TbsarsePointerArray.ForAll
end;

function  TbsarseList.Get(Index: Integer): Pointer;
begin
  if Index < 0 then Error;
  Result := FList[Index]
end;

procedure TbsarseList.Insert(Index: Integer; Item: Pointer);
var
  i: Integer;
begin
  if Index < 0 then Error;
  I := FCount;
  while I > Index do
  begin
    FList[i] := FList[i - 1];
    Dec(i)
  end;
  FList[Index] := Item;
  if Index > FCount then FCount := Index;
  Inc(FCount)
end;

procedure TbsarseList.Move(CurIndex, NewIndex: Integer);
var
  Item: Pointer;
begin
  if CurIndex <> NewIndex then
  begin
    Item := Get(CurIndex);
    Delete(CurIndex);
    Insert(NewIndex, Item);
  end;
end;

procedure TbsarseList.NewList(Quantum: TbsAQuantum);
begin
  FQuantum := Quantum;
  FList := TbsarsePointerArray.Create(Quantum)
end;

procedure TbsarseList.Put(Index: Integer; Item: Pointer);
begin
  if Index < 0 then Error;
  FList[Index] := Item;
  FCount := FList.HighBound + 1
end;

{ TStringSparseList }

constructor TStringSparseList.Create(Quantum: TbsAQuantum);
begin
  FList := TbsarseList.Create(Quantum)
end;

destructor  TStringSparseList.Destroy;
begin
  if FList <> nil then begin
    Clear;
    FList.Destroy
  end
end;

procedure TStringSparseList.ReadData(Reader: TReader);
var
  i: Integer;
begin
  with Reader do begin
    i := Integer(ReadInteger);
    while i > 0 do begin
      InsertObject(Integer(ReadInteger), ReadString, nil);
      Dec(i)
    end
  end
end;

procedure TStringSparseList.WriteData(Writer: TWriter);
var
  itemCount: Integer;

  function  CountItem(TheIndex: Integer; TheItem: Pointer): Integer; far;
  begin
    Inc(itemCount);
    Result := 0
  end;

  function  StoreItem(TheIndex: Integer; TheItem: Pointer): Integer; far;
  begin
    with Writer do
    begin
      WriteInteger(TheIndex);           { Item index }
      WriteString(PStrItem(TheItem)^.FString);
    end;
    Result := 0
  end;

begin
  with Writer do
  begin
    itemCount := 0;
    FList.ForAll(@CountItem);
    WriteInteger(itemCount);
    FList.ForAll(@StoreItem);
  end
end;

procedure TStringSparseList.DefineProperties(Filer: TFiler);
begin
  Filer.DefineProperty('List', ReadData, WriteData, True);
end;

function  TStringSparseList.Get(Index: Integer): String;
var
  p: PStrItem;
begin
  p := PStrItem(FList[Index]);
  if p = nil then Result := '' else Result := p^.FString
end;

function  TStringSparseList.GetCount: Integer;
begin
  Result := FList.Count
end;

function  TStringSparseList.GetObject(Index: Integer): TObject;
var
  p: PStrItem;
begin
  p := PStrItem(FList[Index]);
  if p = nil then Result := nil else Result := p^.FObject
end;

procedure TStringSparseList.Put(Index: Integer; const S: String);
var
  p: PStrItem;
  obj: TObject;
begin
  p := PStrItem(FList[Index]);
  if p = nil then obj := nil else obj := p^.FObject;
  if (S = '') and (obj = nil) then   { Nothing left to store }
    FList[Index] := nil
  else
    FList[Index] := NewStrItem(S, obj);
  if p <> nil then DisposeStrItem(p);
  Changed
end;

procedure TStringSparseList.PutObject(Index: Integer; AObject: TObject);
var
  p: PStrItem;
begin
  p := PStrItem(FList[Index]);
  if p <> nil then
    p^.FObject := AObject
  else if AObject <> nil then
    FList[Index] := NewStrItem('',AObject);
  Changed
end;

procedure TStringSparseList.Changed;
begin
  if Assigned(FOnChange) then FOnChange(Self)
end;

procedure TStringSparseList.Error;
begin
  raise EStringSparseListError.Create(SPutObjectError);
end;

procedure TStringSparseList.Delete(Index: Integer);
var
  p: PStrItem;
begin
  p := PStrItem(FList[Index]);
  if p <> nil then DisposeStrItem(p);
  FList.Delete(Index);
  Changed
end;

procedure TStringSparseList.Exchange(Index1, Index2: Integer);
begin
  FList.Exchange(Index1, Index2);
end;

procedure TStringSparseList.Insert(Index: Integer; const S: String);
begin
  FList.Insert(Index, NewStrItem(S, nil));
  Changed
end;

procedure TStringSparseList.Clear;

  function  ClearItem(TheIndex: Integer; TheItem: Pointer): Integer; far;
  begin
    DisposeStrItem(PStrItem(TheItem));    { Item guaranteed non-nil }
    Result := 0
  end;

begin
  FList.ForAll(@ClearItem);
  FList.Clear;
  Changed
end;

{ TbsSkinStringGridStrings }

{ AIndex < 0 is a column (for column -AIndex - 1)
  AIndex > 0 is a row (for row AIndex - 1)
  AIndex = 0 denotes an empty row or column }

constructor TbsSkinStringGridStrings.Create(AGrid: TbsSkinStringGrid; AIndex: Longint);
begin
  inherited Create;
  FGrid := AGrid;
  FIndex := AIndex;
end;

procedure TbsSkinStringGridStrings.Assign(Source: TPersistent);
var
  I, Max: Integer;
begin
  if Source is TStrings then
  begin
    BeginUpdate;
    Max := TStrings(Source).Count - 1;
    if Max >= Count then Max := Count - 1;
    try
      for I := 0 to Max do
      begin
        Put(I, TStrings(Source).Strings[I]);
        PutObject(I, TStrings(Source).Objects[I]);
      end;
    finally
      EndUpdate;
    end;
    Exit;
  end;
  inherited Assign(Source);
end;

procedure TbsSkinStringGridStrings.CalcXY(Index: Integer; var X, Y: Integer);
begin
  if FIndex = 0 then
  begin
    X := -1; Y := -1;
  end else if FIndex > 0 then
  begin
    X := Index;
    Y := FIndex - 1;
  end else
  begin
    X := -FIndex - 1;
    Y := Index;
  end;
end;

{ Changes the meaning of Add to mean copy to the first empty string }
function TbsSkinStringGridStrings.Add(const S: string): Integer;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    if Strings[I] = '' then
    begin
      Strings[I] := S;
      Result := I;
      Exit;
    end;
  Result := -1;
end;

procedure TbsSkinStringGridStrings.Clear;
var
  SSList: TStringSparseList;
  I: Integer;

  function BlankStr(TheIndex: Integer; TheItem: Pointer): Integer; far;
  begin
    Objects[TheIndex] := nil;
    Strings[TheIndex] := '';
    Result := 0;
  end;

begin
  if FIndex > 0 then
  begin
    SSList := TStringSparseList(TbsarseList(FGrid.FData)[FIndex - 1]);
    if SSList <> nil then SSList.List.ForAll(@BlankStr);
  end
  else if FIndex < 0 then
    for I := Count - 1 downto 0 do
    begin
      Objects[I] := nil;
      Strings[I] := '';
    end;
end;

procedure TbsSkinStringGridStrings.Delete(Index: Integer);
begin
  InvalidOp(sInvalidStringGridOp);
end;

function TbsSkinStringGridStrings.Get(Index: Integer): string;
var
  X, Y: Integer;
begin
  CalcXY(Index, X, Y);
  if X < 0 then Result := '' else Result := FGrid.Cells[X, Y];
end;

function TbsSkinStringGridStrings.GetCount: Integer;
begin
  { Count of a row is the column count, and vice versa }
  if FIndex = 0 then Result := 0
  else if FIndex > 0 then Result := Integer(FGrid.ColCount)
  else Result := Integer(FGrid.RowCount);
end;

function TbsSkinStringGridStrings.GetObject(Index: Integer): TObject;
var
  X, Y: Integer;
begin
  CalcXY(Index, X, Y);
  if X < 0 then Result := nil else Result := FGrid.Objects[X, Y];
end;

procedure TbsSkinStringGridStrings.Insert(Index: Integer; const S: string);
begin
  InvalidOp(sInvalidStringGridOp);
end;

procedure TbsSkinStringGridStrings.Put(Index: Integer; const S: string);
var
  X, Y: Integer;
begin
  CalcXY(Index, X, Y);
  FGrid.Cells[X, Y] := S;
end;

procedure TbsSkinStringGridStrings.PutObject(Index: Integer; AObject: TObject);
var
  X, Y: Integer;
begin
  CalcXY(Index, X, Y);
  FGrid.Objects[X, Y] := AObject;
end;

procedure TbsSkinStringGridStrings.SetUpdateState(Updating: Boolean);
begin
  FGrid.SetUpdateState(Updating);
end;

{ TbsSkinStringGrid }

constructor TbsSkinStringGrid.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Initialize;
end;

destructor TbsSkinStringGrid.Destroy;
  function FreeItem(TheIndex: Integer; TheItem: Pointer): Integer; far;
  begin
    TObject(TheItem).Free;
    Result := 0;
  end;

begin
  if FRows <> nil then
  begin
    TbsarseList(FRows).ForAll(@FreeItem);
    TbsarseList(FRows).Free;
  end;
  if FCols <> nil then
  begin
    TbsarseList(FCols).ForAll(@FreeItem);
    TbsarseList(FCols).Free;
  end;
  if FData <> nil then
  begin
    TbsarseList(FData).ForAll(@FreeItem);
    TbsarseList(FData).Free;
  end;
  inherited Destroy;
end;

procedure TbsSkinStringGrid.ColumnMoved(FromIndex, ToIndex: Longint);

  function MoveColData(Index: Integer; ARow: TStringSparseList): Integer; far;
  begin
    ARow.Move(FromIndex, ToIndex);
    Result := 0;
  end;

begin
  TbsarseList(FData).ForAll(@MoveColData);
  Invalidate;
  inherited ColumnMoved(FromIndex, ToIndex);
end;

procedure TbsSkinStringGrid.RowMoved(FromIndex, ToIndex: Longint);
begin
  TbsarseList(FData).Move(FromIndex, ToIndex);
  Invalidate;
  inherited RowMoved(FromIndex, ToIndex);
end;

function TbsSkinStringGrid.GetEditText(ACol, ARow: Longint): string;
begin
  Result := Cells[ACol, ARow];
  if Assigned(FOnGetEditText) then FOnGetEditText(Self, ACol, ARow, Result);
end;

procedure TbsSkinStringGrid.SetEditText(ACol, ARow: Longint; const Value: string);
begin
  DisableEditUpdate;
  try
    if Value <> Cells[ACol, ARow] then Cells[ACol, ARow] := Value;
  finally
    EnableEditUpdate;
  end;
  inherited SetEditText(ACol, ARow, Value);
end;

procedure TbsSkinStringGrid.DrawCell(ACol, ARow: Longint; ARect: TRect;
  AState: TGridDrawState);
var
  R: TRect;
  S: String;
  TX, TY: Integer;
begin
  if DefaultDrawing
  then
    with Canvas do
    begin
      R := GetNewTextRect(ARect, AState);
      Brush.Style := bsClear;
      S := Cells[ACol, ARow];
      TX := R.Left + 2;
      TY := R.Top + RectHeight(R) div 2 - TextHeight(S) div 2;
      TextRect(R, TX, TY, S);
      Brush.Style := bsSolid;
    end;
  inherited DrawCell(ACol, ARow, ARect, AState);
end;

procedure TbsSkinStringGrid.DisableEditUpdate;
begin
  Inc(FEditUpdate);
end;

procedure TbsSkinStringGrid.EnableEditUpdate;
begin
  Dec(FEditUpdate);
end;

procedure TbsSkinStringGrid.Initialize;
var
  quantum: TbsAQuantum;
begin
  if FCols = nil then
  begin
    if ColCount > 512 then quantum := SPALarge else quantum := SPASmall;
    FCols := TbsarseList.Create(quantum);
  end;
  if RowCount > 256 then quantum := SPALarge else quantum := SPASmall;
  if FRows = nil then FRows := TbsarseList.Create(quantum);
  if FData = nil then FData := TbsarseList.Create(quantum);
end;

procedure TbsSkinStringGrid.SetUpdateState(Updating: Boolean);
begin
  FUpdating := Updating;
  if not Updating and FNeedsUpdating then
  begin
    InvalidateGrid;
    FNeedsUpdating := False;
  end;
end;

procedure TbsSkinStringGrid.Update(ACol, ARow: Integer);
begin
  if not FUpdating then InvalidateCell(ACol, ARow)
  else FNeedsUpdating := True;
  if (ACol = Col) and (ARow = Row) and (FEditUpdate = 0) then InvalidateEditor;
end;

function  TbsSkinStringGrid.EnsureColRow(Index: Integer; IsCol: Boolean):
  TbsSkinStringGridStrings;
var
  RCIndex: Integer;
  PList: ^TbsarseList;
begin
  if IsCol then PList := @FCols else PList := @FRows;
  Result := TbsSkinStringGridStrings(PList^[Index]);
  if Result = nil then
  begin
    if IsCol then RCIndex := -Index - 1 else RCIndex := Index + 1;
    Result := TbsSkinStringGridStrings.Create(Self, RCIndex);
    PList^[Index] := Result;
  end;
end;

function  TbsSkinStringGrid.EnsureDataRow(ARow: Integer): Pointer;
var
  quantum: TbsAQuantum;
begin
  Result := TStringSparseList(TbsarseList(FData)[ARow]);
  if Result = nil then
  begin
    if ColCount > 512 then quantum := SPALarge else quantum := SPASmall;
    Result := TStringSparseList.Create(quantum);
    TbsarseList(FData)[ARow] := Result;
  end;
end;

function TbsSkinStringGrid.GetCells(ACol, ARow: Integer): string;
var
  ssl: TStringSparseList;
begin
  ssl := TStringSparseList(TbsarseList(FData)[ARow]);
  if ssl = nil then Result := '' else Result := ssl[ACol];
end;

function TbsSkinStringGrid.GetCols(Index: Integer): TStrings;
begin
  Result := EnsureColRow(Index, True);
end;

function TbsSkinStringGrid.GetObjects(ACol, ARow: Integer): TObject;
var
  ssl: TStringSparseList;
begin
  ssl := TStringSparseList(TbsarseList(FData)[ARow]);
  if ssl = nil then Result := nil else Result := ssl.Objects[ACol];
end;

function TbsSkinStringGrid.GetRows(Index: Integer): TStrings;
begin
  Result := EnsureColRow(Index, False);
end;

procedure TbsSkinStringGrid.SetCells(ACol, ARow: Integer; const Value: string);
begin
  TbsSkinStringGridStrings(EnsureDataRow(ARow))[ACol] := Value;
  EnsureColRow(ACol, True);
  EnsureColRow(ARow, False);
  Update(ACol, ARow);
end;

procedure TbsSkinStringGrid.SetCols(Index: Integer; Value: TStrings);
begin
  EnsureColRow(Index, True).Assign(Value);
end;

procedure TbsSkinStringGrid.SetObjects(ACol, ARow: Integer; Value: TObject);
begin
  TbsSkinStringGridStrings(EnsureDataRow(ARow)).Objects[ACol] := Value;
  EnsureColRow(ACol, True);
  EnsureColRow(ARow, False);
  Update(ACol, ARow);
end;

procedure TbsSkinStringGrid.SetRows(Index: Integer; Value: TStrings);
begin
  EnsureColRow(Index, False).Assign(Value);
end;

end.
