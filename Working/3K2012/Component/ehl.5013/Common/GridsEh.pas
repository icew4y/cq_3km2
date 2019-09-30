{*******************************************************}
{                                                       }
{                       EhLib 5.0                       }
{                TCustomGridEh component                }
{                    (Build 5.0.03)                     }
{                                                       }
{     This unit is a changed standard Grids.Pas unit    }
{     from Borland Delphi Visual Component Library      }
{ Copyright (c) 1995, 2001 Borland Software Corporation }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit GridsEh;

//{$R-,T-,H+,X+}

interface

uses Messages, {$IFDEF LINUX} WinUtils, {$ENDIF} Windows, SysUtils, Classes,
{$IFDEF EH_LIB_6} Types, {$ENDIF}
{$IFDEF CIL}
  EhLibVCLNET,
{$ELSE}
  EhLibVCL,
{$ENDIF}
  Graphics, Menus, Controls, Forms, StdCtrls, Mask, Dialogs, ExtCtrls;

const
  MaxCustomExtentsEh = MaxListSize;
  MaxShortIntEh = High(ShortInt);

type
  EInvalidGridOperationEh = class(Exception);

  TIntegerArray = array of Integer;
  TPointArray = array of TPoint;
  TDWORDArray = array of DWORD;

  { Internal grid types }
  TGetExtentsFuncEh = function(Index: Longint): Integer of object;

  TGridAxisDrawInfoEh = record
    EffectiveLineWidth: Integer;          //Width of line
    FixedBoundary: Integer;               //Boundary of fixed area
    GridBoundary: Integer;                //Boundary of visible data grid area <= GridExtent
    GridExtent: Integer;                  //Boundary of data grid area = ClientArea - ContraExtent
    LastFullVisibleCell: Longint;         //Last full visible data cell
    FullVisBoundary: Integer;             //Boundary of full visible data grid area <= GridExtent
    FixedCellCount: Integer;              //Fixed cell count
    FirstGridCell: Integer;               //First visible data cell
    GridCellCount: Integer;               //DataFixedColCount or DataFixedRowCount
    GetExtent: TGetExtentsFuncEh;         //ColWidths or RowWidths

    NoFrozenBoundary: Integer;            //Boundary of fixed area - Frozen Boundary
    FrozenCelCount: Integer;

    ContraCelCount: Integer;
    ContraExtent: Integer;
    FullGridExtent: Integer;              //Boundary of data grid area = ClientArea
    FullGridBoundary: Integer;            //=FullGridExtent (ContraCelCount > 0) or =GridBoundary
    FullGridCellCount: Integer;           //ColCount or RowCount
    DataOffset: Integer;                  //Offset of smooth data
    OutViewVisCellStart: Integer;         //FixedBoundary - DataOffset
    VirtualGridBoundary: Integer;         //Boundary of visible data grid area <= GridExtent + DataOffset
  end;

  TGridDrawInfoEh = record
    Horz, Vert: TGridAxisDrawInfoEh;
  end;

  TDrawLinesInfoEh = record
    PointsList: TPointArray;
    StrokeList: TDWORDArray;
    MaxStroke: Integer;
    LastCol: Longint;
    LastRow: Longint;
    VertColor: TColor;
    HorzColor: TColor;
  end;

  TGridState = (gsNormal, gsSelecting, gsRowSizing, gsColSizing,
    gsRowMoving, gsColMoving);
  TGridMovement = gsRowMoving..gsColMoving;

  TRCRRec = record
    Result: Integer;
    RectRgn: HRGN;
  end;

  { TInplaceEdit }
  { The inplace editor is not intended to be used outside the grid }

  TCustomGridEh = class;

  TInplaceEdit = class(TCustomMaskEdit)
  private
    FGrid: TCustomGridEh;
    FClickTime: Longint;
    procedure InternalMove(const Loc: TRect; Redraw: Boolean);
    procedure SetGrid(Value: TCustomGridEh);
    procedure CMShowingChanged(var Message: TMessage); message CM_SHOWINGCHANGED;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMPaste(var Message: TMessage); message WM_PASTE;
    procedure WMCut(var Message: TMessage); message WM_CUT;
    procedure WMClear(var Message: TMessage); message WM_CLEAR;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DblClick; override;
    function DoMouseWheel(Shift: TShiftState; WheelDelta: Integer;
      MousePos: TPoint): Boolean; override;
    function EditCanModify: Boolean; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure BoundsChanged; virtual;
    procedure UpdateContents; virtual;
    procedure WndProc(var Message: TMessage); override;
    property  Grid: TCustomGridEh read FGrid;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Deselect;
    procedure Hide;
//    procedure Invalidate; reintroduce;
    procedure Invalidate; override;
    procedure Move(const Loc: TRect);
    function PosEqual(const Rect: TRect): Boolean;
    procedure SetFocus; reintroduce;
    procedure UpdateLoc(const Loc: TRect);
    function Visible: Boolean;
    property MaxLength;
  end;

  { TGridLineColorsEh }

  TGridLineColorsEh = class(TPersistent)
  private
    FGrid: TCustomGridEh;
    FBrightColor: TColor;
    FDarkColor: TColor;
    FDataHorzColor: TColor;
    FDataVertColor: TColor;
    FFixedHorzColor: TColor;
    FFixedVertColor: TColor;
    FHorzAreaContraBorderColor: TColor;
    FHorzAreaContraHorzColor: TColor;
    FHorzAreaContraVertColor: TColor;
    FHorzAreaFrozenBorderColor: TColor;
    FHorzAreaFrozenHorzColor: TColor;
    FHorzAreaFrozenVertColor: TColor;
    FVertAreaContraBorderColor: TColor;
    FVertAreaContraHorzColor: TColor;
    FVertAreaContraVertColor: TColor;
    FVertAreaFrozenBorderColor: TColor;
    FVertAreaFrozenHorzColor: TColor;
    FVertAreaFrozenVertColor: TColor;
  protected
    property Grid: TCustomGridEh read FGrid;
  public
    constructor Create(AGrid: TCustomGridEh);

    function GetDarkColor: TColor; virtual;
    function GetBrightColor: TColor; virtual;

    function GetCellColor(ACol, ARow: Longint): TColor; virtual;
    function GetLeftBorderCellColor(ACol, ARow: Longint): TColor; virtual;
    function GetTopBorderCellColor(ACol, ARow: Longint): TColor; virtual;
    function GetRightBorderCellColor(ACol, ARow: Longint): TColor; virtual;
    function GetDownBorderCellColor(ACol, ARow: Longint): TColor; virtual;

    function GetFixedVertColor: TColor; virtual;
    function GetFixedHorzColor: TColor; virtual;
    function GetVertAreaFrozenVertColor: TColor; virtual;
    function GetVertAreaFrozenHorzColor: TColor; virtual;
    function GetHorzAreaFrozenVertColor: TColor; virtual;
    function GetHorzAreaFrozenHorzColor: TColor; virtual;
    function GetVertAreaFrozenBorderColor: TColor; virtual;
    function GetHorzAreaFrozenBorderColor: TColor; virtual;
    function GetDataVertColor: TColor; virtual;
    function GetDataHorzColor: TColor; virtual;
    function GetVertAreaContraVertColor: TColor; virtual;
    function GetVertAreaContraHorzColor: TColor; virtual;
    function GetHorzAreaContraVertColor: TColor; virtual;
    function GetHorzAreaContraHorzColor: TColor; virtual;
    function GetVertAreaContraBorderColor: TColor; virtual;
    function GetHorzAreaContraBorderColor: TColor; virtual;

    property DarkColor: TColor read FDarkColor write FDarkColor default clDefault;
    property BrightColor: TColor read FBrightColor write FBrightColor default clDefault;
    property FixedVertColor: TColor read FFixedVertColor write FFixedVertColor default clDefault;
    property FixedHorzColor: TColor read FFixedHorzColor write FFixedHorzColor default clDefault;
    property VertAreaFrozenVertColor: TColor read FVertAreaFrozenVertColor write FVertAreaFrozenVertColor default clDefault;
    property VertAreaFrozenHorzColor: TColor read FVertAreaFrozenHorzColor write FVertAreaFrozenHorzColor default clDefault;
    property HorzAreaFrozenVertColor: TColor read FHorzAreaFrozenVertColor write FHorzAreaFrozenVertColor default clDefault;
    property HorzAreaFrozenHorzColor: TColor read FHorzAreaFrozenHorzColor write FHorzAreaFrozenHorzColor default clDefault;
    property VertAreaFrozenBorderColor: TColor read FVertAreaFrozenBorderColor write FVertAreaFrozenBorderColor default clDefault;
    property HorzAreaFrozenBorderColor: TColor read FHorzAreaFrozenBorderColor write FHorzAreaFrozenBorderColor default clDefault;
    property DataVertColor: TColor read FDataVertColor write FDataVertColor default clDefault;
    property DataHorzColor: TColor read FDataHorzColor write FDataHorzColor default clDefault;
    property VertAreaContraVertColor: TColor read FVertAreaContraVertColor write FVertAreaContraVertColor default clDefault;
    property VertAreaContraHorzColor: TColor read FVertAreaContraHorzColor write FVertAreaContraHorzColor default clDefault;
    property HorzAreaContraVertColor: TColor read FHorzAreaContraVertColor write FHorzAreaContraVertColor default clDefault;
    property HorzAreaContraHorzColor: TColor read FHorzAreaContraHorzColor write FHorzAreaContraHorzColor default clDefault;
    property VertAreaContraBorderColor: TColor read FVertAreaContraBorderColor write FVertAreaContraBorderColor default clDefault;
    property HorzAreaContraBorderColor: TColor read FHorzAreaContraBorderColor write FHorzAreaContraBorderColor default clDefault;
  end;

  { TCustomGridEh }

  TGridOption = (goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine,
    goRangeSelect, goDrawFocusSelected, goRowSizing, goColSizing, goRowMoving,
    goColMoving, goEditing, goTabs, goRowSelect,
    goAlwaysShowEditor, goThumbTracking, goExtendVertLines);
  TGridOptions = set of TGridOption;
  TGridDrawState = set of (gdSelected, gdFocused, gdFixed, gdHotTrack, gdCurrent);
  TGridScrollDirection = set of (sdLeft, sdRight, sdUp, sdDown);

  TGridCoord = record
    X: Longint;
    Y: Longint;
  end;

  TGridRect = TRect;

  TEditStyle =  (esSimple, esEllipsis, esPickList);

  TSelectCellEvent = procedure (Sender: TObject; ACol, ARow: Longint;
    var CanSelect: Boolean) of object;
  TDrawCellEvent = procedure (Sender: TObject; ACol, ARow: Longint;
    Rect: TRect; State: TGridDrawState) of object;
  TGridEhCellMouseEvent = procedure (Grid: TCustomGridEh; Cell: TGridCoord;
    Button: TMouseButton; Shift: TShiftState; X, Y: Integer) of object;

  TCustomGridEh = class(TCustomControl)
  private
    FAnchor: TGridCoord;
    FBorderStyle: TBorderStyle;
    FCanEditModify: Boolean;
    FColCount: Longint;
    FColOffset: Integer;
    FColWidths: TIntegerArray;
    FContraColCount: Longint;
    FContraRowCount: Longint;
    FCurrent: TGridCoord;
    FDefaultColWidth: Integer;
    FDefaultDrawing: Boolean;
    FDefaultRowHeight: Integer;
    FEditorMode: Boolean;
    FFixedColor: TColor;
    FFixedCols: Integer;
    FFixedRows: Integer;
    FFlat: Boolean;
    FFrozenColCount: Longint;
    FFrozenRowCount: Longint;
    FGridLineColors: TGridLineColorsEh;
    FGridLineWidth: Integer;
    FHitTest: TPoint;
    FInplaceCol, FInplaceRow: Longint;
    FInplaceEdit: TInplaceEdit;
    FMoveIndex, FMovePos: Longint;
    FOnCellMouseClick: TGridEhCellMouseEvent;
    FOptions: TGridOptions;
    FRowCount: Longint;
    FRowHeights: TIntegerArray;
    FScrollBars: TScrollStyle;
    FTabStops: TIntegerArray;
    FTopLeft: TGridCoord;
    function CalcMaxTopLeft(const Coord: TGridCoord; const DrawInfo: TGridDrawInfoEh): TGridCoord;
    function CalcMinLeftTopNonVisiblePart(const MaxCell: TGridCoord; const DrawInfo: TGridDrawInfoEh): TSize;
    function GetColWidths(Index: Longint): Integer;
    function GetFullColCount: Longint;
    function GetFullRowCount: Longint;
    function GetRowHeights(Index: Longint): Integer;
    function GetSelection: TGridRect;
    function GetTabStops(Index: Longint): Boolean;
    function GetVisibleColCount: Integer;
    function GetVisibleRowCount: Integer;
    procedure CalcDrawInfoXY(var DrawInfo: TGridDrawInfoEh; UseWidth, UseHeight: Integer);
    procedure CancelMode;
    procedure ChangeSize(NewColCount, NewRowCount: Longint);
    procedure ClampInView(const Coord: TGridCoord; CheckX, CheckY: Boolean);
    procedure CMCancelMode(var Msg: TCMCancelMode); message CM_CANCELMODE;
    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
    procedure CMDesignHitTest(var Msg: TCMDesignHitTest); message CM_DESIGNHITTEST;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMShowingChanged(var Message: TMessage); message CM_SHOWINGCHANGED;
    procedure CMWantSpecialKey(var Msg: TCMWantSpecialKey); message CM_WANTSPECIALKEY;
    procedure DrawMove(const DrawInfo: TGridDrawInfoEh);
    procedure HideMove; virtual;
    procedure GridRectToScreenRect(GridRect: TGridRect; var ScreenRect: TRect; IncludeLine: Boolean);
    procedure Initialize;
    procedure InvalidateRect(ARect: TGridRect);
    procedure ModifyScrollBar(ScrollBar, ScrollCode, Pos: Cardinal; UseRightToLeft: Boolean);
    procedure MoveAdjust(var CellPos: Longint; FromIndex, ToIndex: Longint);
    procedure MoveAnchor(const NewAnchor: TGridCoord; Show: Boolean);
    procedure MoveAndScroll(Mouse, CellHit: Integer; var DrawInfo: TGridDrawInfoEh;
      var Axis: TGridAxisDrawInfoEh; Scrollbar: Integer; const MousePt: TPoint);
    procedure MoveCurrent(ACol, ARow: Longint; MoveAnchor, Show: Boolean);
    procedure MoveTopLeft(ALeft, ATop: Longint);
    procedure ReadColWidths(Reader: TReader);
    procedure ReadRowHeights(Reader: TReader);
    procedure ResizeCol(Index: Longint; OldSize, NewSize: Integer);
    procedure ResizeRow(Index: Longint; OldSize, NewSize: Integer);
    procedure ScrollDataInfo(DX, DY: Integer; var DrawInfo: TGridDrawInfoEh);
    procedure SelectionMoved(const OldSel: TGridRect);
    procedure SetBorderStyle(Value: TBorderStyle);
    procedure SetCol(Value: Longint);
    procedure SetColCount(Value: Longint);
    procedure SetColWidths(Index: Longint; Value: Integer);
    procedure SetContraColCount(const Value: Longint);
    procedure SetContraRowCount(const Value: Longint);
    procedure SetDefaultColWidth(Value: Integer);
    procedure SetDefaultRowHeight(Value: Integer);
    procedure SetEditorMode(Value: Boolean);
    procedure SetFixedColor(Value: TColor);
    procedure SetFixedCols(Value: Integer);
    procedure SetFixedRows(Value: Integer);
    procedure SetFlat(const Value: Boolean);
    procedure SetFrozenColCount(const Value: Longint);
    procedure SetFrozenRowCount(const Value: Longint);
    procedure SetGridLineWidth(Value: Integer);
    procedure SetLeftCol(Value: Longint);
    procedure SetOptions(Value: TGridOptions);
    procedure SetRow(Value: Longint);
    procedure SetRowCount(Value: Longint);
    procedure SetRowHeights(Index: Longint; Value: Integer);
    procedure SetScrollBars(Value: TScrollStyle);
    procedure SetSelection(Value: TGridRect);
    procedure SetTabStops(Index: Longint; Value: Boolean);
    procedure SetTopRow(Value: Longint);
    procedure TopLeftMoved(const OldTopLeft: TGridCoord; OldDataOffset: TSize);
    procedure UpdateScrollPos;
    procedure WMCancelMode(var Msg: TWMCancelMode); message WM_CANCELMODE;
    procedure WMChar(var Msg: TWMChar); message WM_CHAR;
    procedure WMCommand(var Message: TWMCommand); message WM_COMMAND;
    procedure WMGetDlgCode(var Msg: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMHScroll(var Msg: TWMHScroll); message WM_HSCROLL;
    procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMRButtonDown(var Message: TWMRButtonDown); message WM_RBUTTONDOWN;
    procedure WMMButtonDown(var Message: TWMMButtonDown); message WM_MBUTTONDOWN;
    procedure WMLButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMRButtonUp(var Message: TWMRButtonUp); message WM_RBUTTONUP;
    procedure WMMButtonUp(var Message: TWMMButtonUp); message WM_MBUTTONUP;
    procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMSetCursor(var Msg: TWMSetCursor); message WM_SETCURSOR;
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure WMSize(var Msg: TWMSize); message WM_SIZE;
    procedure WMTimer(var Msg: TWMTimer); message WM_TIMER;
    procedure WMVScroll(var Msg: TWMVScroll); message WM_VSCROLL;
    procedure WriteColWidths(Writer: TWriter);
    procedure WriteRowHeights(Writer: TWriter);
  protected
    DesignOptionsBoost: TGridOptions;

    FDataOffset: TSize;
    FDataPageSize: TSize;
    FGridDataSize: TSize;
    FSmoothPos: TPoint;

    FFixedLineColor: TColor;
    FGridState: TGridState;
    FLockPaint: Integer;
    FMouseDownCell: TGridCoord;
    FSaveCellExtents: Boolean;
    VirtualView: Boolean;
    FSizingIndex: Longint;
    FSizingPos, FSizingOfs: Integer;
    FHotTrackCell: TGridCoord;
    function IsActiveControl: Boolean;
    function BeginColumnDrag(var Origin, Destination: Integer; const MousePt: TPoint): Boolean; virtual;
    function BeginRowDrag(var Origin, Destination: Integer; const MousePt: TPoint): Boolean; virtual;
    function BoxRect(ALeft, ATop, ARight, ABottom: Longint): TRect;
    function CalcCoordFromPoint(X, Y: Integer; const DrawInfo: TGridDrawInfoEh): TGridCoord;
    function CanEditAcceptKey(Key: Char): Boolean; virtual;
    function CanEditModify: Boolean; virtual;
    function CanEditShow: Boolean; virtual;
    function CanGridAcceptKey(Key: Word; Shift: TShiftState): Boolean; virtual;
    function CellRect(ACol, ARow: Longint): TRect;
    function CellEditRect(ACol, ARow: Longint): TRect; virtual;
    function CheckCellMouseClick(var Message: TWMLButtonUp): Boolean; virtual;
    function CheckColumnDrag(var Origin, Destination: Integer; const MousePt: TPoint): Boolean; virtual;
    function CheckRowDrag(var Origin, Destination: Integer; const MousePt: TPoint): Boolean; virtual;
    function CreateEditor: TInplaceEdit; virtual;
    function CreateGridLineColors: TGridLineColorsEh; virtual;
    function DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function DrawMoveLine(FromPos: Integer; Smooth: Integer; WithDelay: Boolean): Integer;
    function EndColumnDrag(var Origin, Destination: Integer; const MousePt: TPoint): Boolean; virtual;
    function EndRowDrag(var Origin, Destination: Integer; const MousePt: TPoint): Boolean; virtual;
    function EnsureInplaceEditCreated: Boolean;
    function GetEditLimit: Integer; virtual;
    function GetEditMask(ACol, ARow: Longint): string; virtual;
    function GetEditStyle(ACol, ARow: Longint): TEditStyle; virtual;
    function GetEditText(ACol, ARow: Longint): string; virtual;
    function GetGridHeight: Integer;
    function GetGridWidth: Integer;
    function GetHorzScrollStep: Integer; virtual;
    function GetVertScrollStep: Integer; virtual;
    function IsSmoothHorzScroll: Boolean; virtual;
    function IsSmoothVertScroll: Boolean; virtual;
    function CanHotTackCell(X, Y: Integer): Boolean; virtual;
    function PaintLocked: Boolean;
    function ResizeLine(const AxisInfo: TGridAxisDrawInfoEh): Integer;
    function RestrictClipRegionAlignment(Canvas: TCanvas; Rect: TRect): TRCRRec;
    function SelectCell(ACol, ARow: Longint): Boolean; virtual;
    function Sizing(X, Y: Integer): Boolean;
    function GetChangingGridDataExtend(Index, Amount: Longint; Rows: Boolean): Int64;
    function GetChangingGridDataExtendForFixedData(Amount: Longint; Rows: Boolean): Int64;
    function GetChangingGridDataExtendForContraData(Amount: Longint; Rows: Boolean): Int64;
    function GetChangingGridDataExtendForColWidth(ColRowNum, Amount: Longint; Rows: Boolean): Int64;
    procedure AdjustSize(Index, Amount: Longint; Rows: Boolean); reintroduce; virtual;
    procedure CalcContraInfo(var DrawInfo: TGridDrawInfoEh; UseWidth, UseHeight: Integer);
    procedure CalcDrawInfo(var DrawInfo: TGridDrawInfoEh);
    procedure CalcFixedInfo(var DrawInfo: TGridDrawInfoEh);
    procedure CalcSizingState(X, Y: Integer; var State: TGridState; var Index: Longint;
      var SizingPos, SizingOfs: Integer; var FixedInfo: TGridDrawInfoEh); virtual;
    procedure CellMouseClick(Cell: TGridCoord; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer); virtual;
    procedure ChangeGridOrientation(RightToLeftOrientation: Boolean);
    procedure ColumnMoved(FromIndex, ToIndex: Longint); virtual;
    procedure ColWidthsChanged; virtual;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure GetDrawSizingLineBound(const DrawInfo: TGridDrawInfoEh; var StartPos, FinishPos: Integer); virtual;
    procedure DefineProperties(Filer: TFiler); override;
    procedure DeleteColumn(ACol: Longint); virtual;
    procedure DeleteRow(ARow: Longint); virtual;
    procedure DoExit; override;
    procedure DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState); virtual; abstract;
    procedure DrawContraInfo(DrawInfo: TGridDrawInfoEh);
    procedure DrawEdgeEh(ACanvas: TCanvas; qrc: TRect; IsDown, IsSelected, NeedLeft, NeedRight: Boolean);
    procedure DrawLines(DrawInfo: TGridDrawInfoEh; DoHorz, DoVert: Boolean;
      Col, Row: Longint; const CellBounds: array of Integer; OnColor, OffColor: TColor;
        Canvas: TCanvas; DrawLinesInfo: TDrawLinesInfoEh);
    procedure DrawGradientUnderDataLines(DrawInfo: TGridDrawInfoEh; AFrom, ATo: Integer);
    procedure DrawPolyline(Points: array of TPoint);
    procedure DrawPolyPolyline(PointsList: TPointArray; StrokeList: TDWORDArray; VCount: Integer);
    procedure DrawSizingLine(const DrawInfo: TGridDrawInfoEh); virtual;
    procedure FlatChanged; virtual;
    procedure FocusCell(ACol, ARow: Longint; MoveAnchor: Boolean);
    procedure HideEdit;
    procedure HideEditor; virtual;
    procedure InvalidateCell(ACol, ARow: Longint);
    procedure InvalidateCol(ACol: Longint);
    procedure InvalidateEditor;
    procedure InvalidateGrid;
    procedure InvalidateRow(ARow: Longint);
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure LockPaint;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MoveColRow(ACol, ARow: Longint; MoveAnchor, Show: Boolean);
    procedure MoveColumn(FromIndex, ToIndex: Longint);
    procedure MoveRow(FromIndex, ToIndex: Longint);
    procedure Paint; override;
    procedure RowHeightsChanged; virtual;
    procedure RowMoved(FromIndex, ToIndex: Longint); virtual;
    procedure ScrollData(DX, DY: Integer); virtual;
    procedure SetContraSize(NewContraColCount, NewContraRowCount: Integer); virtual;
    procedure SetEditText(ACol, ARow: Longint; const Value: string); virtual;
    procedure SetGridScrollInfo(BarFlag, Min, Max, PageSize, Pos: Integer);
    procedure ShowEditor; virtual;
    procedure ShowEditorChar(Ch: Char);
    procedure SizeChanged(OldColCount, OldRowCount: Longint); virtual;
    procedure SmoothScrollData(DX, DY: Integer);
    procedure SafeSmoothScrollData(DX, DY: Integer);
    procedure TimedScroll(Direction: TGridScrollDirection); virtual;
    procedure TopLeftChanged; virtual;
    procedure UnlockPaint;
    procedure UpdateDesigner;
    procedure UpdateFixedLineColor; virtual;
    procedure UpdateGridDataWidth;
    procedure UpdateGridDataHeight;
    procedure UpdateEdit; virtual;
    procedure UpdateText; virtual;
    procedure UpdateScrollRange;
    procedure UpdateHotTackInfo(X, Y: Integer); virtual;

    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default bsSingle;
    property Col: Longint read FCurrent.X write SetCol;
    property ColCount: Longint read FColCount write SetColCount default 5;
    property Color default clWindow;
    property ColWidths[Index: Longint]: Integer read GetColWidths write SetColWidths;
    property ContraColCount: Longint read FContraColCount write SetContraColCount default 0;
    property ContraRowCount: Longint read FContraRowCount write SetContraRowCount default 0;
    property DefaultColWidth: Integer read FDefaultColWidth write SetDefaultColWidth default 64;
    property DefaultDrawing: Boolean read FDefaultDrawing write FDefaultDrawing default True;
    property DefaultRowHeight: Integer read FDefaultRowHeight write SetDefaultRowHeight default 24;
    property EditorMode: Boolean read FEditorMode write SetEditorMode;
    property FixedColor: TColor read FFixedColor write SetFixedColor default clBtnFace;
    property FixedCols: Integer read FFixedCols write SetFixedCols default 1;
    property FixedRows: Integer read FFixedRows write SetFixedRows default 1;
    property FrozenColCount: Longint read FFrozenColCount write SetFrozenColCount;
    property FrozenRowCount: Longint read FFrozenRowCount write SetFrozenRowCount;
    property FullColCount: Longint read GetFullColCount;
    property FullRowCount: Longint read GetFullRowCount;
    property GridHeight: Integer read GetGridHeight;
    property GridLineColors: TGridLineColorsEh read FGridLineColors;
    property GridLineWidth: Integer read FGridLineWidth write SetGridLineWidth default 1;
    property GridWidth: Integer read GetGridWidth;
    property HitTest: TPoint read FHitTest;
    property InplaceEditor: TInplaceEdit read FInplaceEdit;
    property LeftCol: Longint read FTopLeft.X write SetLeftCol;
    property OnCellMouseClick: TGridEhCellMouseEvent read FOnCellMouseClick write FOnCellMouseClick;
    property Options: TGridOptions read FOptions write SetOptions default
     [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect];
    property ParentColor default False;
    property Row: Longint read FCurrent.Y write SetRow;
    property RowCount: Longint read FRowCount write SetRowCount default 5;
    property RowHeights[Index: Longint]: Integer read GetRowHeights write SetRowHeights;
    property ScrollBars: TScrollStyle read FScrollBars write SetScrollBars default ssBoth;
    property Selection: TGridRect read GetSelection write SetSelection;
    property TabStops[Index: Longint]: Boolean read GetTabStops write SetTabStops;
    property TopRow: Longint read FTopLeft.Y write SetTopRow;
    property VisibleColCount: Integer read GetVisibleColCount;
    property VisibleRowCount: Integer read GetVisibleRowCount;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function MouseCoord(X, Y: Integer): TGridCoord;
    procedure DefaultCellMouseClick(Cell: TGridCoord; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer); virtual;
    property Flat: Boolean read FFlat write SetFlat;
  published
    property TabStop default True;
  end;

  { TCustomDrawGrid }

  { A grid relies on the OnDrawCell event to display the cells.
     CellRect
       This method returns control relative screen coordinates of the cell or
       an empty rectangle if the cell is not visible.
     EditorMode
       Setting to true shows the editor, as if the F2 key was pressed, when
       goEditing is turned on and goAlwaysShowEditor is turned off.
     MouseToCell
       Takes control relative screen X, Y location and fills in the column and
       row that contain that point.
     OnColumnMoved
       Called when the user request to move a column with the mouse when
       the goColMoving option is on.
     OnDrawCell
       This event is passed the same information as the DrawCell method
       discussed above.
     OnGetEditMask
       Called to retrieve edit mask in the inplace editor when goEditing is
       turned on.
     OnGetEditText
       Called to retrieve text to edit when goEditing is turned on.
     OnRowMoved
       Called when the user request to move a row with the mouse when
       the goRowMoving option is on.
     OnSetEditText
       Called when goEditing is turned on to reflect changes to the text
       made by the editor.
     OnTopLeftChanged
       Invoked when TopRow or LeftCol change. }

  TGetEditEvent = procedure (Sender: TObject; ACol, ARow: Longint; var Value: string) of object;
  TSetEditEvent = procedure (Sender: TObject; ACol, ARow: Longint; const Value: string) of object;
  TMovedEvent = procedure (Sender: TObject; FromIndex, ToIndex: Longint) of object;

  TCustomDrawGridEh = class(TCustomGridEh)
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
//    procedure DrawContraCell(ACol, ARow: Longint; ARect: TRect;
//      AState: TGridDrawState); override;
    function GetEditMask(ACol, ARow: Longint): string; override;
    function GetEditText(ACol, ARow: Longint): string; override;
    procedure RowMoved(FromIndex, ToIndex: Longint); override;
    function SelectCell(ACol, ARow: Longint): Boolean; override;
    procedure SetEditText(ACol, ARow: Longint; const Value: string); override;
    procedure TopLeftChanged; override;
    property OnColumnMoved: TMovedEvent read FOnColumnMoved write FOnColumnMoved;
    property OnDrawCell: TDrawCellEvent read FOnDrawCell write FOnDrawCell;
    property OnGetEditMask: TGetEditEvent read FOnGetEditMask write FOnGetEditMask;
    property OnGetEditText: TGetEditEvent read FOnGetEditText write FOnGetEditText;
    property OnRowMoved: TMovedEvent read FOnRowMoved write FOnRowMoved;
    property OnSelectCell: TSelectCellEvent read FOnSelectCell write FOnSelectCell;
    property OnSetEditText: TSetEditEvent read FOnSetEditText write FOnSetEditText;
    property OnTopLeftChanged: TNotifyEvent read FOnTopLeftChanged write FOnTopLeftChanged;
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

    property ContraRowCount;
    property ContraColCount;
    property FullRowCount;
    property FullColCount;
    property FrozenColCount;
    property FrozenRowCount;
    property Flat;
  end;

  { TDrawGrid }

  TDrawGridEh = class(TCustomDrawGridEh)
  published
    property Align;
    property Anchors;
    property BiDiMode;
    property BorderStyle;
    property Color;
    property ColCount;
    property Constraints;
    property Ctl3D;
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
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ScrollBars;
    property ShowHint;
    property TabOrder;
    property Visible;
    property VisibleColCount;
    property VisibleRowCount;
    property OnClick;
    property OnColumnMoved;
//    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawCell;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetEditMask;
    property OnGetEditText;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnRowMoved;
    property OnSelectCell;
    property OnSetEditText;
    property OnStartDock;
    property OnStartDrag;
    property OnTopLeftChanged;
  end;

{ TGridDragWinEh }

  TGridDragWinEh = class(TWinControl)
  private
    FAlphaBlendValue: Byte;
    FTransparentColorValue: TColor;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure SetLayeredAttribs;
  public
    constructor Create(AOwner: TComponent); override;
    function Visible: Boolean;
    procedure Show;
    procedure MoveToFor(Control: TControl; NewPos: TPoint); overload; virtual;
    procedure MoveToFor(Control: TControl; NewPos: TPoint; NewWidth, NewHeight: Integer); overload; virtual;
    procedure StartShow(Control: TControl; Pos: TPoint; Width, Height: Integer); overload; virtual;
    procedure StartShow(Control: TControl; Pos: TPoint; Height: Integer); overload; virtual;
    procedure TemporaryHide;

  end;

{ TGridDragBoxEh }

  TGridDragBoxEh = class(TGridDragWinEh)
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

{ TGridMoveLineEh }

  TGridMoveLineEh = class(TGridDragWinEh)
  protected
    sHigh7: TShape;
    sHigh5: TShape;
    sHigh3: TShape;
    sLine: TShape;
    sLow3: TShape;
    sLow5: TShape;
    sLow7: TShape;

    hLeft7: TShape;
    hLeft5: TShape;
    hLeft3: TShape;
    hLine: TShape;
    hRight3: TShape;
    hRight5: TShape;
    hRight7: TShape;

    FIsVert: Boolean;
    procedure CreateParams(var Params: TCreateParams); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure StartShow(Control: TControl; Pos: TPoint; AIsVert: Boolean; Size: Integer); virtual;
    procedure MoveToFor(Control: TControl; NewPos: TPoint); override;
    procedure UpdateOrientationData;
    property IsVert: Boolean read FIsVert;
  end;

  function GetDragBoxEh: TGridDragWinEh;
  function GetMoveLineEh: TGridMoveLineEh;

  function GridCoord(X, Y: Longint): TGridCoord;

implementation

uses Math, ToolCtrlsEh, Consts{, RTLConsts, Themes};

function GridCoord(X, Y: Longint): TGridCoord;
begin
  Result.X := X;
  Result.Y := Y;
end;

procedure InvalidOp(const id: string);
begin
  raise EInvalidGridOperationEh.Create(id);
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

  function Includes(const P1: TPoint; P2: TPoint): Boolean;
  begin
    with P1 do
      Result := PtInRect(X, Y, R1) or PtInRect(X, Y, R2);
  end;

  function Build(var R: TRect; const P1, P2, P3: TPoint): Boolean;
  begin
    Build := True;
    with R do
      if Includes(P1, R.TopLeft) then
      begin
        Left := P1.X;
        Top := P1.Y;
        if Includes(P3, R.BottomRight) then
        begin
          Right := P3.X;
          Bottom := P3.Y;
        end else
        begin
          Right := P2.X;
          Bottom := P2.Y;
        end
      end
      else if Includes(P2, R.TopLeft) then
      begin
        Left := P2.X;
        Top := P2.Y;
        Bottom := P3.Y;
        Right := P3.X;
      end
      else
        Build := False;
  end;

begin
  XorRects[0] := EmptyRect;
  XorRects[1] := EmptyRect;
  XorRects[2] := EmptyRect;
  XorRects[3] := EmptyRect;
//  FillChar(XorRects, SizeOf(XorRects), 0);
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

procedure ModifyExtents(var Extents: TIntegerArray; Index, Amount: Longint; Default: Integer);
// Adds or deletes itmes in Extents  from 'Index' with 'Amount'.
var
  LongSize, OldSize: LongInt;
  NewSize: Integer;
  I: Integer;
begin
  if Amount <> 0 then
  begin
    if Length(Extents) = 0
      then OldSize := 0
      else OldSize := Extents[0];
    if (Index < 0) or (OldSize < Index) then InvalidOp(SIndexOutOfRange);
    LongSize := OldSize + Amount;
    if LongSize < 0 then InvalidOp(STooManyDeleted)
    else if LongSize >= MaxListSize - 1 then InvalidOp(SGridTooLarge);
    NewSize := Cardinal(LongSize);
    if NewSize > 0 then Inc(NewSize);
    SetLength(Extents, NewSize);
    if Length(Extents) <> 0 then
    begin
     I  := Index + 1;
      while I < NewSize do
      begin
        Extents[I] := Default;
        Inc(I);
      end;
      Extents[0] := NewSize-1;
    end;
  end;
end;

procedure UpdateExtents(var Extents: TIntegerArray; NewSize: Longint;
  Default: Integer);
var
  OldSize: Integer;
begin
  OldSize := 0;
  if Length(Extents) <> 0 then OldSize := Extents[0];
  ModifyExtents(Extents, OldSize, NewSize - OldSize, Default);
end;

procedure MoveExtent(var Extents: TIntegerArray; FromIndex, ToIndex: Longint);
var
  Extent, I: Integer;
begin
  if Length(Extents) <> 0 then
  begin
    Extent := Extents[FromIndex];
    if FromIndex < ToIndex then
      for I := FromIndex + 1 to ToIndex do
        Extents[I - 1] := Extents[I]
    else if FromIndex > ToIndex then
      for I := FromIndex - 1 downto ToIndex do
        Extents[I + 1] := Extents[I];
    Extents[ToIndex] := Extent;
  end;
end;

function CompareExtents(E1, E2: TIntegerArray): Boolean;
var
  I: Integer;
begin
  Result := False;
  if Length(E1) <> 0 then
  begin
    if Length(E2) <> 0 then
    begin
      for I := 0 to E1[0] do
        if E1[I] <> E2[I] then Exit;
      Result := True;
    end
  end
  else Result := Length(E2) = 0;
end;

{procedure KillMessage(Wnd: HWnd; Msg: Integer);
// Delete the requested message from the queue, but throw back
// any WM_QUIT msgs that PeekMessage may also return
var
  M: TMsg;
begin
  M.Message := 0;
  if PeekMessage(M, Wnd, Msg, Msg, pm_Remove) and (M.Message = WM_QUIT) then
    PostQuitMessage(M.wparam);
end;
}

{ TGridDragWinEh }

constructor TGridDragWinEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Color := cl3DDkShadow;
  FAlphaBlendValue := 200;
  BorderWidth := 0;
  inherited Visible := False;
end;

procedure TGridDragWinEh.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := WS_POPUP {or WS_BORDER};
    WindowClass.Style := WindowClass.Style or CS_SAVEBITS;
    if NewStyleControls then
      ExStyle := WS_EX_TOOLWINDOW;
    // CS_DROPSHADOW requires Windows XP or above
//    if {FShadow and} CheckWin32Version(5, 1) then
//      WindowClass.Style := WindowClass.style or CS_DROPSHADOW;
//    if NewStyleControls then ExStyle := WS_EX_TOOLWINDOW;
    AddBiDiModeExStyle(ExStyle);
{$IFNDEF VER140} //not Delphi6
{$IFNDEF CIL}
    if Assigned(SetLayeredWindowAttributes) then
{$ENDIF}
{$ENDIF}
      Params.ExStyle := Params.ExStyle or WS_EX_LAYERED;
  end;
end;

procedure TGridDragWinEh.CreateWindowHandle(const Params: TCreateParams);
begin
  inherited CreateWindowHandle(Params);
  SetLayeredAttribs;
end;

procedure TGridDragWinEh.SetLayeredAttribs;
const
  cUseAlpha: array [Boolean] of Integer = (0, LWA_ALPHA);
  cUseColorKey: array [Boolean] of Integer = (0, LWA_COLORKEY);
var
  AStyle: Integer;
begin
  if not (csDesigning in ComponentState) and
{$IFNDEF VER140} //not Delphi6
{$IFNDEF CIL}
    (Assigned(SetLayeredWindowAttributes)) and 
{$ENDIF}
{$ENDIF}
    HandleAllocated then
  begin
    AStyle := GetWindowLong(Handle, GWL_EXSTYLE);
    if (FAlphaBlendValue <> 255) or (FTransparentColorValue <> 0) then
    begin
      if (AStyle and WS_EX_LAYERED) = 0 then
        SetWindowLong(Handle, GWL_EXSTYLE, AStyle or WS_EX_LAYERED);
      SetLayeredWindowAttributes(Handle, FTransparentColorValue, FAlphaBlendValue,
        cUseAlpha[FAlphaBlendValue <> 255] or cUseColorKey[FTransparentColorValue <> 0]);
    end
    else
    begin
      SetWindowLong(Handle, GWL_EXSTYLE, AStyle and not WS_EX_LAYERED);
      RedrawWindow(Handle, nil, 0, RDW_ERASE or RDW_INVALIDATE or RDW_FRAME or RDW_ALLCHILDREN);
    end;
  end;
end;

procedure TGridDragWinEh.MoveToFor(Control: TControl; NewPos: TPoint);
var
  AbsPos: TPoint;
begin
  AbsPos := Control.ClientToScreen(NewPos);
  SetBounds(AbsPos.X, AbsPos.Y, Width, Height);
end;

procedure TGridDragWinEh.MoveToFor(Control: TControl; NewPos: TPoint; NewWidth, NewHeight: Integer);
var
  AbsPos: TPoint;
begin
  AbsPos := Control.ClientToScreen(NewPos);
  SetBounds(AbsPos.X, AbsPos.Y, NewWidth, NewHeight);
end;

procedure TGridDragWinEh.StartShow(Control: TControl; Pos: TPoint; Width, Height: Integer);
var
  AbsPos: TPoint;
begin
  AbsPos := Control.ClientToScreen(Pos);
  SetBounds(AbsPos.X, AbsPos.Y, Width, Height);
  inherited Visible := True;
  SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE or
    SWP_NOSIZE or SWP_NOACTIVATE);
end;

procedure TGridDragWinEh.StartShow(Control: TControl; Pos: TPoint; Height: Integer);
begin
  StartShow(Control, Pos, Width, Height);
end;

function TGridDragWinEh.Visible: Boolean;
begin
  Result := inherited Visible;
end;

procedure TGridDragWinEh.Show;
begin
//  if
end;

procedure TGridDragWinEh.TemporaryHide;
begin
  SetBounds(Left, Top, 0, 0);
end;

{ TGridDragBoxEh }

constructor TGridDragBoxEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
//  Color := clWhite;
end;

procedure TGridDragBoxEh.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
//  if CheckWin32Version(5, 1) then
//    Params.WindowClass.Style := Params.WindowClass.style or CS_DROPSHADOW;
end;

{ TGridMoveLineEh }

constructor TGridMoveLineEh.Create(AOwner: TComponent);
var
  LineColor: TColor;
begin
  inherited Create(AOwner);
  Color := clWhite;
  Width := 7;
  Height := 7;
  FAlphaBlendValue := 255;
  FTransparentColorValue := clWhite;
  LineColor := clRed;
  FIsVert := True;
//  Visible := False;

// Vertical
  sLine := TShape.Create(Self);
  sLow3 := TShape.Create(Self);
  sLow5 := TShape.Create(Self);
  sLow7 := TShape.Create(Self);
  sHigh3 := TShape.Create(Self);
  sHigh5 := TShape.Create(Self);
  sHigh7 := TShape.Create(Self);

  with sHigh7 do
  begin
    Name := 'sHigh7';
    Parent := Self;
    SetBounds(0,0,7,1);
    Pen.Color := LineColor
  end;
  with sHigh5 do
  begin
    Name := 'sHigh5';
    Parent := Self;
    SetBounds(1,1,5,1);
    Pen.Color := LineColor
  end;
  with sHigh3 do
  begin
    Name := 'sHigh3';
    Parent := Self;
    SetBounds(2,2,3,1);
    Pen.Color := LineColor
  end;
  with sLine do
  begin
    Name := 'sLine';
    Parent := Self;
    SetBounds(3,3,1,1);
    Anchors := [akLeft, akTop, akBottom];
    Pen.Color := LineColor
  end;
  with sLow3 do
  begin
    Name := 'sLow3';
    Parent := Self;
    SetBounds(2,4,3,1);
    Anchors := [akLeft, akBottom];
    Pen.Color := LineColor;
  end;
  with sLow5 do
  begin
    Name := 'sLow5';
    Parent := Self;
    SetBounds(1,5,5,1);
    Anchors := [akLeft, akBottom];
    Pen.Color := LineColor;
  end;
  with sLow7 do
  begin
    Name := 'sLow7';
    Parent := Self;
    SetBounds(0,6,7,1);
    Anchors := [akLeft, akBottom];
    Pen.Color := LineColor;
  end;

// Horizontal
  hLeft7 := TShape.Create(Self);
  hLeft5 := TShape.Create(Self);
  hLeft3 := TShape.Create(Self);
  hLine := TShape.Create(Self);
  hRight3 := TShape.Create(Self);
  hRight5 := TShape.Create(Self);
  hRight7 := TShape.Create(Self);

  with hLeft7 do
  begin
    Name := 'hLeft7';
    Parent := Self;
    SetBounds(0,0,1,7);
    Pen.Color := LineColor
  end;
  with hLeft5 do
  begin
    Name := 'hLeft5';
    Parent := Self;
    SetBounds(1,1,1,5);
    Pen.Color := LineColor
  end;
  with hLeft3 do
  begin
    Name := 'hLeft3';
    Parent := Self;
    SetBounds(2,2,1,3);
    Pen.Color := LineColor
  end;
  with hLine do
  begin
    Name := 'hLine';
    Parent := Self;
    SetBounds(3,3,1,1);
    Anchors := [akLeft, akTop, akRight];
    Pen.Color := LineColor
  end;
  with hRight3 do
  begin
    Name := 'hRight3';
    Parent := Self;
    SetBounds(4,2,1,3);
    Anchors := [akTop, akRight];
    Pen.Color := LineColor;
  end;
  with hRight5 do
  begin
    Name := 'hRight5';
    Parent := Self;
    SetBounds(5,1,1,5);
    Anchors := [akTop, akRight];
    Pen.Color := LineColor;
  end;
  with hRight7 do
  begin
    Name := 'hRight7';
    Parent := Self;
    SetBounds(6,0,1,7);
    Anchors := [akTop, akRight];
    Pen.Color := LineColor;
  end;

end;

procedure TGridMoveLineEh.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
//  if CheckWin32Version(5, 1) then
//    Params.WindowClass.Style := Params.WindowClass.style or CS_DROPSHADOW;
end;

procedure TGridMoveLineEh.StartShow(Control: TControl; Pos: TPoint; AIsVert: Boolean; Size: Integer);
begin
  FIsVert := AIsVert;
  UpdateOrientationData;
  Pos.X := Pos.X - 3;
  Pos.Y := Pos.Y - 4;
  Size := Size + 8;
  if IsVert
    then inherited StartShow(Control, Pos, 7, Size)
    else inherited StartShow(Control, Pos, Size, 7)
end;

procedure TGridMoveLineEh.MoveToFor(Control: TControl; NewPos: TPoint);
begin
  NewPos.X := NewPos.X - 3;
  NewPos.Y := NewPos.Y - 4;
  inherited MoveToFor(Control, NewPos);
end;

procedure TGridMoveLineEh.UpdateOrientationData;
var
  VertVisible, HorzVisible: Boolean;
begin
  if FIsVert then
  begin
    VertVisible := True;
    HorzVisible := False;
  end else
  begin
    VertVisible := False;
    HorzVisible := True;
  end;

  sHigh7.Visible := VertVisible;
  sHigh5.Visible := VertVisible;
  sHigh3.Visible := VertVisible;
  sLine.Visible := VertVisible;
  sLow3.Visible := VertVisible;
  sLow5.Visible := VertVisible;
  sLow7.Visible := VertVisible;

  hLeft7.Visible := HorzVisible;
  hLeft5.Visible := HorzVisible;
  hLeft3.Visible := HorzVisible;
  hLine.Visible := HorzVisible;
  hRight3.Visible := HorzVisible;
  hRight5.Visible := HorzVisible;
  hRight7.Visible := HorzVisible;

end;

var
  FDragBox: TGridDragWinEh;
  FMoveLine: TGridMoveLineEh;

function GetDragBoxEh: TGridDragWinEh;
begin
  if FDragBox = nil then
  begin
    FDragBox := TGridDragBoxEh.Create(Application);
    FDragBox.ParentWindow := Application.Handle;
  end;
  Result := FDragBox;
end;

function GetMoveLineEh: TGridMoveLineEh;
begin
  if FMoveLine = nil then
  begin
    FMoveLine := TGridMoveLineEh.Create(Application);
    FMoveLine.ParentWindow := Application.Handle;
  end;
  Result := FMoveLine;
end;

type
  TSelection = record
    StartPos, EndPos: Integer;
  end;

constructor TInplaceEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ParentCtl3D := False;
  Ctl3D := False;
  TabStop := False;
  BorderStyle := bsNone;
  DoubleBuffered := False;
end;

procedure TInplaceEdit.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or ES_MULTILINE;
end;

procedure TInplaceEdit.SetGrid(Value: TCustomGridEh);
begin
  FGrid := Value;
end;

procedure TInplaceEdit.CMShowingChanged(var Message: TMessage);
begin
  { Ignore showing using the Visible property }
end;

procedure TInplaceEdit.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  inherited;
  if goTabs in Grid.Options then
    Message.Result := Message.Result or DLGC_WANTTAB;
end;

procedure TInplaceEdit.WMPaste(var Message: TMessage);
begin
  if not EditCanModify then Exit;
  inherited
end;

procedure TInplaceEdit.WMClear(var Message: TMessage);
begin
  if not EditCanModify then Exit;
  inherited;
end;

procedure TInplaceEdit.WMCut(var Message: TMessage);
begin
  if not EditCanModify then Exit;
  inherited;
end;

procedure TInplaceEdit.DblClick;
begin
{$IFDEF CIL}
//  Grid.DblClick;
{$ELSE}
  Grid.DblClick;
{$ENDIF}
end;

function TInplaceEdit.DoMouseWheel(Shift: TShiftState; WheelDelta: Integer;
  MousePos: TPoint): Boolean;
begin
{$IFDEF CIL}
//  Result := Grid.DoMouseWheel(Shift, WheelDelta, MousePos);
{$ELSE}
  Result := Grid.DoMouseWheel(Shift, WheelDelta, MousePos);
{$ENDIF}
end;

function TInplaceEdit.EditCanModify: Boolean;
begin
  Result := Grid.CanEditModify;
end;

procedure TInplaceEdit.KeyDown(var Key: Word; Shift: TShiftState);

  procedure SendToParent;
  begin
    Grid.KeyDown(Key, Shift);
    Key := 0;
  end;

  procedure ParentEvent;
  var
    GridKeyDown: TKeyEvent;
  begin
{$IFDEF CIL}
//    GridKeyDown := Grid.OnKeyDown;
{$ELSE}
    GridKeyDown := Grid.OnKeyDown;
{$ENDIF}
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
//    SendMessage(Handle, EM_GETSEL, Longint(@Result.StartPos), Longint(@Result.EndPos));
    MessageSendGetSel(Handle, Result.StartPos, Result.EndPos);
  end;

  function CaretPos: Integer;
  var
    P: TPoint;
  begin
    Windows.GetCaretPos(P);
    Result := SendMessage(Handle, EM_CHARFROMPOS, 0, MakeLong(P.X, P.Y));
  end;

  function RightSide: Boolean;
  begin
    with Selection do
      Result := (CaretPos = GetTextLen) and
        ((StartPos = 0) or (EndPos = StartPos)) and (EndPos = GetTextLen);
   end;

  function LeftSide: Boolean;
  begin
    with Selection do
      Result := (CaretPos = 0) and (StartPos = 0) and
        ((EndPos = 0) or (EndPos = GetTextLen));
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
    VK_DELETE:
      if Ctrl then
        SendToParent
      else
        if not Grid.CanEditModify then Key := 0;
  end;
  if Key <> 0 then
  begin
    ParentEvent;
    inherited KeyDown(Key, Shift);
  end;
end;

procedure TInplaceEdit.KeyPress(var Key: Char);
var
  Selection: TSelection;
begin
  Grid.KeyPress(Key);
  if (Key >= #32) and not Grid.CanEditAcceptKey(Key) then
  begin
    Key := #0;
    MessageBeep(0);
  end;
  case Key of
    #9, #27: Key := #0;
    #13:
      begin
        MessageSendGetSel(Handle, Selection.StartPos, Selection.EndPos);
//        SendMessage(Handle, EM_GETSEL, Longint(@Selection.StartPos), Longint(@Selection.EndPos));
        if (Selection.StartPos = 0) and (Selection.EndPos = GetTextLen) then
          Deselect else
          SelectAll;
        Key := #0;
      end;
    ^H, ^V, ^X, #32..High(Char):
      if not Grid.CanEditModify then Key := #0;
  end;
  if Key <> #0 then inherited KeyPress(Key);
end;

procedure TInplaceEdit.KeyUp(var Key: Word; Shift: TShiftState);
begin
{$IFDEF CIL}
//  Grid.KeyUp(Key, Shift);
{$ELSE}
  Grid.KeyUp(Key, Shift);
{$ENDIF}
end;

procedure TInplaceEdit.WndProc(var Message: TMessage);
begin
  case Message.Msg of
    WM_SETFOCUS:
      begin
        if (GetParentForm(Self) = nil) or GetParentForm(Self).SetFocusedControl(Grid) then
          Dispatch(Message);
        Exit;
      end;
    WM_LBUTTONDOWN:
      begin
        if UINT(GetMessageTime - FClickTime) < GetDoubleClickTime then
          Message.Msg := WM_LBUTTONDBLCLK;
        FClickTime := 0;
      end;
  end;
  inherited WndProc(Message);
end;

procedure TInplaceEdit.Deselect;
begin
  SendMessage(Handle, EM_SETSEL, $7FFFFFFF, Longint($FFFFFFFF));
end;

procedure TInplaceEdit.Invalidate;
var
  Cur: TRect;
begin
  ValidateRect(Handle, nil);
  InvalidateRect(Handle, nil, True);
  Windows.GetClientRect(Handle, Cur);
  MapWindowPoints(Handle, Grid.Handle, Cur, 2);
  WindowsValidateRect(Grid.Handle, Cur);
  WindowsInvalidateRect(Grid.Handle, Cur, False);
end;

procedure TInplaceEdit.Hide;
begin
  if HandleAllocated and IsWindowVisible(Handle) then
  begin
    Invalidate;
    SetWindowPos(Handle, 0, 0, 0, 0, 0, SWP_HIDEWINDOW or SWP_NOZORDER or
      SWP_NOREDRAW);
    if Focused then Windows.SetFocus(Grid.Handle);
  end;
end;

function TInplaceEdit.PosEqual(const Rect: TRect): Boolean;
var
  Cur: TRect;
begin
  GetWindowRect(Handle, Cur);
  MapWindowPoints(HWND_DESKTOP, Grid.Handle, Cur, 2);
  Result := EqualRect(Rect, Cur);
end;

procedure TInplaceEdit.InternalMove(const Loc: TRect; Redraw: Boolean);
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

procedure TInplaceEdit.BoundsChanged;
var
  R: TRect;
begin
  R := Rect(2, 2, Width - 2, Height);
//  SendMessage(Handle, EM_SETRECTNP, 0, LongInt(@R));
  SendStructMessage(Handle, EM_SETRECTNP, 0, R);
  SendMessage(Handle, EM_SCROLLCARET, 0, 0);
end;

procedure TInplaceEdit.UpdateLoc(const Loc: TRect);
begin
  InternalMove(Loc, False);
end;

function TInplaceEdit.Visible: Boolean;
begin
  Result := IsWindowVisible(Handle);
end;

procedure TInplaceEdit.Move(const Loc: TRect);
begin
  InternalMove(Loc, True);
end;

procedure TInplaceEdit.SetFocus;
begin
  if IsWindowVisible(Handle) then
    Windows.SetFocus(Handle);
end;

procedure TInplaceEdit.UpdateContents;
begin
  Text := '';
  EditMask := Grid.GetEditMask(Grid.Col, Grid.Row);
  Text := Grid.GetEditText(Grid.Col, Grid.Row);
  MaxLength := Grid.GetEditLimit;
end;

{ TCustomGridEh }

constructor TCustomGridEh.Create(AOwner: TComponent);
const
  GridStyle = [csCaptureMouse, csOpaque, csDoubleClicks];
begin
  inherited Create(AOwner);
  if NewStyleControls then
    ControlStyle := GridStyle
  else
    ControlStyle := GridStyle + [csFramed];
{$IFDEF EH_LIB_7}
  ControlStyle := ControlStyle + [csNeedsBorderPaint];
{$ENDIF}
  FCanEditModify := True;
  FColCount := 5;
  FRowCount := 5;
  FFixedCols := 1;
  FFixedRows := 1;
  FGridLineWidth := 1;
  FOptions := [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine,
    goRangeSelect];
  DesignOptionsBoost := [goColSizing, goRowSizing, goColMoving];
  FFixedColor := clBtnFace;
  FScrollBars := ssBoth;
  FBorderStyle := bsSingle;
  FDefaultColWidth := 64;
  FDefaultRowHeight := 24;
  FDefaultDrawing := True;
  FSaveCellExtents := True;
  FEditorMode := False;
  Color := clWindow;
  ParentColor := False;
  TabStop := True;
  SetBounds(Left, Top, FColCount * FDefaultColWidth,
    FRowCount * FDefaultRowHeight);
  Initialize;
  FFixedLineColor := clBlack;
  FGridLineColors := CreateGridLineColors;
  FMouseDownCell := MouseCoord(-1, -1);
  UpdateGridDataWidth;
  UpdateGridDataHeight;
  FHotTrackCell.X := -1;
  FHotTrackCell.Y := -1;
end;

destructor TCustomGridEh.Destroy;
begin
  FreeAndNil(FInplaceEdit);
  inherited Destroy;
//  FreeMem(FColWidths);
//  FreeMem(FRowHeights);
//  FreeMem(FTabStops);
  FreeAndNil(FGridLineColors);
end;

procedure TCustomGridEh.SetContraSize(NewContraColCount, NewContraRowCount: Integer);
var
  OldContraColCount, OldContraRowCount: Integer;
begin
  OldContraColCount := FContraColCount;
  OldContraRowCount := FContraRowCount;

  FContraColCount := NewContraColCount;
  FContraRowCount := NewContraRowCount;
  try
    if Length(FColWidths) <> 0 then
      UpdateExtents(FColWidths, FullColCount, DefaultColWidth);
    if Length(FTabStops) <> 0 then
      UpdateExtents(FTabStops, FullColCount, Integer(True));
    if Length(FRowHeights) <> 0 then
      UpdateExtents(FRowHeights, FullRowCount, DefaultRowHeight);
  except
    FContraColCount := OldContraColCount;
    FContraRowCount := OldContraRowCount;
  end;

  Invalidate;
  UpdateScrollRange;
end;

function TCustomGridEh.BoxRect(ALeft, ATop, ARight, ABottom: Longint): TRect;
var
  GridRect: TGridRect;
begin
  GridRect.Left := ALeft;
  GridRect.Right := ARight;
  GridRect.Top := ATop;
  GridRect.Bottom := ABottom;
  GridRectToScreenRect(GridRect, Result, False);
end;

procedure TCustomGridEh.DoExit;
begin
  inherited DoExit;
  if not (goAlwaysShowEditor in Options) then HideEditor;
end;

function TCustomGridEh.CellRect(ACol, ARow: Longint): TRect;
begin
  Result := BoxRect(ACol, ARow, ACol, ARow);
end;

function TCustomGridEh.CellEditRect(ACol, ARow: Longint): TRect;
begin
  Result := CellRect(ACol, ARow);
end;

function TCustomGridEh.CanEditAcceptKey(Key: Char): Boolean;
begin
  Result := True;
end;

function TCustomGridEh.CanGridAcceptKey(Key: Word; Shift: TShiftState): Boolean;
begin
  Result := True;
end;

function TCustomGridEh.CanEditModify: Boolean;
begin
  Result := FCanEditModify;
end;

function TCustomGridEh.CanEditShow: Boolean;
begin
  Result := ([goRowSelect, goEditing] * Options = [goEditing]) and
    FEditorMode and not (csDesigning in ComponentState) and HandleAllocated and
    ((goAlwaysShowEditor in Options) or IsActiveControl);
end;

function TCustomGridEh.IsActiveControl: Boolean;
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

function TCustomGridEh.GetEditMask(ACol, ARow: Longint): string;
begin
  Result := '';
end;

function TCustomGridEh.GetEditText(ACol, ARow: Longint): string;
begin
  Result := '';
end;

procedure TCustomGridEh.SetEditText(ACol, ARow: Longint; const Value: string);
begin
end;

function TCustomGridEh.GetEditLimit: Integer;
begin
  Result := 0;
end;

function TCustomGridEh.GetEditStyle(ACol, ARow: Longint): TEditStyle;
begin
  Result := esSimple;
end;

procedure TCustomGridEh.HideEditor;
begin
  FEditorMode := False;
  HideEdit;
end;

procedure TCustomGridEh.ShowEditor;
begin
  FEditorMode := True;
  UpdateEdit;
end;

procedure TCustomGridEh.ShowEditorChar(Ch: Char);
begin
  ShowEditor;
  if FInplaceEdit <> nil then
    PostMessage(FInplaceEdit.Handle, WM_CHAR, Ord(Ch), 0);
end;

procedure TCustomGridEh.InvalidateEditor;
begin
  FInplaceCol := -1;
  FInplaceRow := -1;
  UpdateEdit;
end;

procedure TCustomGridEh.ReadColWidths(Reader: TReader);
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

procedure TCustomGridEh.ReadRowHeights(Reader: TReader);
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

procedure TCustomGridEh.WriteColWidths(Writer: TWriter);
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

procedure TCustomGridEh.WriteRowHeights(Writer: TWriter);
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

procedure TCustomGridEh.DefineProperties(Filer: TFiler);

  function DoColWidths: Boolean;
  begin
    if Filer.Ancestor <> nil then
      Result := not CompareExtents(TCustomGridEh(Filer.Ancestor).FColWidths, FColWidths)
    else
      Result := Length(FColWidths) <> 0;
  end;

  function DoRowHeights: Boolean;
  begin
    if Filer.Ancestor <> nil then
      Result := not CompareExtents(TCustomGridEh(Filer.Ancestor).FRowHeights, FRowHeights)
    else
      Result := Length(FRowHeights) <> 0;
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

procedure TCustomGridEh.MoveColumn(FromIndex, ToIndex: Longint);
var
  Rect: TGridRect;
  InvalidRect: TRect;
  DrawInfo: TGridDrawInfoEh;
begin
  if FromIndex = ToIndex then Exit;
  if Length(FColWidths) > 0 then
  begin
    MoveExtent(FColWidths, FromIndex + 1, ToIndex + 1);
    MoveExtent(FTabStops, FromIndex + 1, ToIndex + 1);
  end;
  MoveAdjust(FCurrent.X, FromIndex, ToIndex);
  MoveAdjust(FAnchor.X, FromIndex, ToIndex);
  MoveAdjust(FInplaceCol, FromIndex, ToIndex);
  Rect.Top := 0;
  CalcDrawInfo(DrawInfo);
  Rect.Bottom := DrawInfo.Vert.LastFullVisibleCell - TopRow + 1;//VisibleRowCount;
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
//ddd  InvalidateRect(Rect);
  if HandleAllocated then
  begin
    GridRectToScreenRect(Rect, InvalidRect, True);
    InvalidRect.Bottom := DrawInfo.Vert.FullGridExtent;
    WindowsInvalidateRect(Handle, InvalidRect, False);
  end;
  ColumnMoved(FromIndex, ToIndex);
  if Length(FColWidths) > 0 then
    ColWidthsChanged;
  UpdateEdit;
end;

procedure TCustomGridEh.ColumnMoved(FromIndex, ToIndex: Longint);
begin
end;

procedure TCustomGridEh.MoveRow(FromIndex, ToIndex: Longint);
var
  Rect: TGridRect;
  InvalidRect: TRect;
  DrawInfo: TGridDrawInfoEh;
begin
  if Length(FRowHeights) <> 0 then
    MoveExtent(FRowHeights, FromIndex + 1, ToIndex + 1);
  MoveAdjust(FCurrent.Y, FromIndex, ToIndex);
  MoveAdjust(FAnchor.Y, FromIndex, ToIndex);
  MoveAdjust(FInplaceRow, FromIndex, ToIndex);

  Rect.Left := 0;
  CalcDrawInfo(DrawInfo);
  Rect.Right := DrawInfo.Horz.LastFullVisibleCell - LeftCol + 1;
  if FromIndex < ToIndex then
  begin
    Rect.Top := FromIndex;
    Rect.Bottom := ToIndex;
  end
  else
  begin
    Rect.Top := ToIndex;
    Rect.Bottom := FromIndex;
  end;
  if HandleAllocated then
  begin
    GridRectToScreenRect(Rect, InvalidRect, True);
    InvalidRect.Right := DrawInfo.Horz.FullGridExtent;
    WindowsInvalidateRect(Handle, InvalidRect, False);
  end;

  RowMoved(FromIndex, ToIndex);
  if Length(FRowHeights) <> 0 then
    RowHeightsChanged;
  UpdateEdit;
end;

procedure TCustomGridEh.RowMoved(FromIndex, ToIndex: Longint);
begin
end;

function TCustomGridEh.MouseCoord(X, Y: Integer): TGridCoord;
var
  DrawInfo: TGridDrawInfoEh;
begin
  CalcDrawInfo(DrawInfo);
  Result := CalcCoordFromPoint(X, Y, DrawInfo);
  if Result.X < 0 then Result.Y := -1
  else if Result.Y < 0 then Result.X := -1;
end;

procedure TCustomGridEh.MoveColRow(ACol, ARow: Longint; MoveAnchor,
  Show: Boolean);
begin
  MoveCurrent(ACol, ARow, MoveAnchor, Show);
end;

function TCustomGridEh.SelectCell(ACol, ARow: Longint): Boolean;
begin
  Result := True;
end;

procedure TCustomGridEh.SizeChanged(OldColCount, OldRowCount: Longint);
begin
//  UpdateGridDataWidth;
end;

function TCustomGridEh.Sizing(X, Y: Integer): Boolean;
var
  DrawInfo: TGridDrawInfoEh;
  State: TGridState;
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

procedure TCustomGridEh.TopLeftChanged;
var
  MousePos: TPoint;
begin
  if FEditorMode and (FInplaceEdit <> nil)
    then FInplaceEdit.UpdateLoc(CellEditRect(Col, Row));
  MousePos := ScreenToClient(Mouse.CursorPos);
  UpdateHotTackInfo(MousePos.X, MousePos.Y);
end;

(*
procedure FillDWord(var Dest; Count, Value: Integer); register;
asm
  XCHG  EDX, ECX
  PUSH  EDI
  MOV   EDI, EAX
  MOV   EAX, EDX
  REP   STOSD
  POP   EDI
end;

{ StackAlloc allocates a 'small' block of memory from the stack by
  decrementing SP.  This provides the allocation speed of a local variable,
  but the runtime size flexibility of heap allocated memory.  }
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

{ StackFree pops the memory allocated by StackAlloc off the stack.
- Calling StackFree is optional - SP will be restored when the calling routine
  exits, but it's a good idea to free the stack allocated memory ASAP anyway.
- StackFree must be called in the same stack context as StackAlloc - not in
  a subroutine or finally block.
- Multiple StackFree calls must occur in reverse order of their corresponding
  StackAlloc calls.
- Built-in sanity checks guarantee that an improper call to StackFree will not
  corrupt the stack. Worst case is that the stack block is not released until
  the calling routine exits. }
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
*)

function RestrictClipRegion(Canvas: TCanvas; Rect: TRect): TRCRRec;
var
  RectRgn: HRGN;
begin
  Result.RectRgn := CreateRectRgn(0, 0, 0, 0);
  Result.Result := GetClipRgn(Canvas.Handle, Result.RectRgn);
  RectRgn := CreateRectRgn(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom);
  ExtSelectClipRgn(Canvas.Handle, RectRgn, RGN_AND);
  DeleteObject(RectRgn);
end;

procedure RestoreClipRegion(Canvas: TCanvas; RCR: TRCRRec);
begin
  if RCR.Result = 0
    then SelectClipRgn(Canvas.Handle, 0)
    else SelectClipRgn(Canvas.Handle, RCR.RectRgn);
  DeleteObject(RCR.RectRgn);
end;

procedure TCustomGridEh.DrawLines(DrawInfo: TGridDrawInfoEh; DoHorz, DoVert: Boolean;
 Col, Row: Longint; const CellBounds: array of Integer; OnColor, OffColor: TColor;
  Canvas: TCanvas; DrawLinesInfo: TDrawLinesInfoEh);

{ Cellbounds is 4 integers: StartX, StartY, StopX, StopY
  Horizontal lines:  MajorIndex = 0
  Vertical lines:    MajorIndex = 1 }

const
  FlatPenStyle = PS_Geometric or PS_Solid or PS_EndCap_Flat or PS_Join_Miter;

  procedure DrawAxisLines(const AxisInfo: TGridAxisDrawInfoEh;
    Cell, MajorIndex: Integer; UseOnColor: Boolean; LastCell: Longint);
  var
    Line: Integer;
    LogBrush: TLOGBRUSH;
    Index: Integer;
    Points: TPointArray;
    StopMajor, StartMinor, StopMinor, StopIndex: Integer;
    LineIncr: Integer;
  begin
    Points := nil;
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
        Points := DrawLinesInfo.PointsList;
        Line := CellBounds[MajorIndex] + EffectiveLineWidth shr 1 +
          AxisInfo.GetExtent(Cell);
        //!!! ??? Line needs to be incremented for RightToLeftAlignment ???
// Fix in DrawPolyPolyline   if UseRightToLeftAlignment and (MajorIndex = 0) then Inc(Line);
        StartMinor := CellBounds[MajorIndex xor 1];
        StopMinor := CellBounds[2 + (MajorIndex xor 1)];
        StopMajor := CellBounds[2 + MajorIndex] + EffectiveLineWidth;
        StopIndex := DrawLinesInfo.MaxStroke * 2;
        Index := 0;
        repeat
          if MajorIndex <> 0 then
          begin
            Points[Index].Y := Line;
            Points[Index].X := StartMinor;
          end else
          begin
            Points[Index].X := Line;
            Points[Index].Y := StartMinor;
          end;
          Inc(Index);
          if MajorIndex <> 0 then
          begin
            Points[Index].Y := Line;
            Points[Index].X := StopMinor;
          end else
          begin
            Points[Index].X := Line;
            Points[Index].Y := StopMinor;
          end;
          Inc(Index);
          // Skip hidden columns/rows.  We don't have stroke slots for them
          // A column/row with an extent of -EffectiveLineWidth is hidden
          repeat
            Inc(Cell);
            LineIncr := AxisInfo.GetExtent(Cell) + EffectiveLineWidth;
          until (LineIncr > 0) or (Cell > LastCell);
          Inc(Line, LineIncr);
        until (Line > StopMajor) or (Cell > LastCell) or (Index > StopIndex);
//        until (Line > StopMajor) or (Cell > LastCell) or (Index > StopIndex);
         { 2 integers per point, 2 points per line -> Index div 4 }
(*{$IFDEF CIL}
        PolyPolyLine(Canvas.Handle, Points, DrawLinesInfo.StrokeList, Index shr 1);
{$ELSE}
        PolyPolyLine(Canvas.Handle, Pointer(Points)^, Pointer(DrawLinesInfo.StrokeList)^, Index shr 1);
{$ENDIF}*)
        DrawPolyPolyline(Points, DrawLinesInfo.StrokeList, Index);
      end;
    end;
  end;

begin
  if (CellBounds[0] = CellBounds[2]) or (CellBounds[1] = CellBounds[3]) then
    Exit;
  if not DoHorz then
  begin
    DrawAxisLines(DrawInfo.Vert, Row, 1, DoHorz, DrawLinesInfo.LastRow);
    DrawAxisLines(DrawInfo.Horz, Col, 0, DoVert, DrawLinesInfo.LastCol);
  end
  else
  begin
    DrawAxisLines(DrawInfo.Horz, Col, 0, DoVert, DrawLinesInfo.LastCol);
    DrawAxisLines(DrawInfo.Vert, Row, 1, DoHorz, DrawLinesInfo.LastRow);
  end;
end;

procedure TCustomGridEh.DrawGradientUnderDataLines(DrawInfo: TGridDrawInfoEh; AFrom, ATo: Integer);
var
  i: Integer;
  HLinePos: Integer;
  StartPost, FinishPost: Integer;
  AColor: TColor;
begin
  if not (goVertLine in Options) then Exit;
  HLinePos := -GridLineWidth;
  StartPost := DrawInfo.Vert.GridBoundary;
  FinishPost := DrawInfo.Vert.ContraExtent;
  if AFrom <= DrawInfo.Horz.FixedBoundary then
  begin
    for i := 0 to DrawInfo.Horz.FixedCellCount-DrawInfo.Horz.FrozenCelCount-1 do
    begin
      Inc(HLinePos, ColWidths[i]+GridLineWidth);
      FillGradientEh(Canvas, Rect(HLinePos, StartPost, HLinePos+1, FinishPost),
        GridLineColors.GetDarkColor, Color);
    end;
    if DrawInfo.Horz.FrozenCelCount > 0 then
    begin
      for i := DrawInfo.Horz.FixedCellCount-DrawInfo.Horz.FrozenCelCount to DrawInfo.Horz.FixedCellCount-2 do
      begin
        Inc(HLinePos, ColWidths[i]+GridLineWidth);
        FillGradientEh(Canvas, Rect(HLinePos, StartPost, HLinePos+1, FinishPost),
          GridLineColors.GetBrightColor, Color);
      end;
      Inc(HLinePos, ColWidths[DrawInfo.Horz.FixedCellCount-1]+GridLineWidth);
      FillGradientEh(Canvas, Rect(HLinePos, StartPost, HLinePos+1, FinishPost),
        GridLineColors.GetDarkColor, Color);
    end;
  end;
  if ATo > DrawInfo.Horz.FixedBoundary then
  begin
    HLinePos := DrawInfo.Horz.OutViewVisCellStart-GridLineWidth;
    for i := DrawInfo.Horz.FirstGridCell to DrawInfo.Horz.LastFullVisibleCell do
    begin
      Inc(HLinePos, ColWidths[i]+GridLineWidth);
      FillGradientEh(Canvas, Rect(HLinePos, StartPost, HLinePos+1, FinishPost),
        GridLineColors.GetBrightColor, Color);
    end;
  end;

  if ATo >= DrawInfo.Horz.ContraExtent then
  begin
    if DrawInfo.Horz.ContraCelCount > 0 then
    begin
      HLinePos := DrawInfo.Horz.ContraExtent;
      for i := DrawInfo.Horz.GridCellCount to DrawInfo.Horz.FullGridCellCount-1 do
      begin
        if i = DrawInfo.Horz.GridCellCount
          then AColor := GridLineColors.GetDarkColor
          else AColor := GridLineColors.GetBrightColor;
        FillGradientEh(Canvas, Rect(HLinePos, StartPost, HLinePos+1, FinishPost),
          AColor, Color);
        Inc(HLinePos, ColWidths[i]+GridLineWidth);
      end;
    end;
  end;
end;


procedure TCustomGridEh.Paint;
var
//  LineColor: TColor;
  DrawInfo: TGridDrawInfoEh;
  Sel: TGridRect;
  UpdateRect: TRect;
  AFocRect, FocRect: TRect;
  PointsList: TPointArray;
  StrokeList: TDWORDArray;
  MaxStroke: Integer;
  FrameFlags1, FrameFlags2: DWORD;

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
        if (Where.Right > Where.Left) {and RectVisible(Canvas.Handle, Where)} then
        begin
          DrawState := IncludeDrawState;
          Focused := IsActiveControl;
          if (CurCol = FHotTrackCell.X) and (CurRow = FHotTrackCell.Y) then
            Include(DrawState, gdHotTrack);
          if CurRow = Row then
            if goRowSelect in Options then
            begin
              if CurCol >= FixedCols-FrozenColCount then
                Include(DrawState, gdCurrent);
            end else
            begin
              if CurCol = Col then
                Include(DrawState, gdCurrent);
            end;
          if Focused and (gdCurrent in DrawState) then
            Include(DrawState, gdFocused);
          if PointInGridRect(CurCol, CurRow, Sel) then
            Include(DrawState, gdSelected);
          if True{not (gdFocused in DrawState) or not (goEditing in Options) or
            not FEditorMode or (csDesigning in ComponentState)} then
          begin
            if DefaultDrawing or (csDesigning in ComponentState) then
              with Canvas do
              begin
                Font := Self.Font;
                if (gdSelected in DrawState) and
                  (not (gdFocused in DrawState) or
                  ([goDrawFocusSelected, goRowSelect] * Options <> [])) then
                begin
                  Brush.Color := clHighlight;
                  Font.Color := clHighlightText;
                end
                else
                  Brush.Color := Color;
                FillRect(Where);
              end;
            DrawCell(CurCol, CurRow, Where, DrawState);
            if DefaultDrawing and (gdFixed in DrawState) and Ctl3D and
              ((FrameFlags1 or FrameFlags2) <> 0) then
            begin
              TempRect := Where;
              if (FrameFlags1 and BF_RIGHT) = 0 then
                Inc(TempRect.Right, DrawInfo.Horz.EffectiveLineWidth)
              else if (FrameFlags1 and BF_BOTTOM) = 0 then
                Inc(TempRect.Bottom, DrawInfo.Vert.EffectiveLineWidth);
              DrawEdgeEh(Canvas, TempRect, False, False, True, True);
              DrawEdgeEh(Canvas, TempRect, False, False, True, True);
            end;

            if DefaultDrawing and not (csDesigning in ComponentState) and
              (gdFocused in DrawState) and
              ([goEditing, goAlwaysShowEditor] * Options <>
              [goEditing, goAlwaysShowEditor])
              and not (goRowSelect in Options) then
            begin
              if not UseRightToLeftAlignment then
                DrawFocusRect(Canvas.Handle, Where)
              else
              begin
                AWhere := Where;
                AWhere.Left := Where.Right;
                AWhere.Right := Where.Left;
                DrawFocusRect(Canvas.Handle, AWhere);
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

  procedure DrawOneLine(Left, Top, Right, Bottom: Integer; Color: TColor);
  begin
    PointsList[0].X := Left;
    PointsList[0].Y := Top;
    PointsList[1].X := Right;
    PointsList[1].Y := Bottom;
    Canvas.Pen.Color := Color;
(*
{$IFDEF CIL}
    PolyPolyLine(Canvas.Handle, PointsList, StrokeList, 1);
{$ELSE}
    PolyPolyLine(Canvas.Handle, Pointer(PointsList)^, Pointer(StrokeList)^, 1);
{$ENDIF}
*)
    DrawPolyPolyline(PointsList, StrokeList, 2);
  end;

var
  OldRectRgn, RectRgn: HRGN;
  r: Integer;
  DrawLinesInfo: TDrawLinesInfoEh;
  I: Integer;
  RCR: TRCRRec;
begin
  if PaintLocked then Exit;
  if UseRightToLeftAlignment then ChangeGridOrientation(True);

  CalcDrawInfo(DrawInfo);

  OldRectRgn := 0;
  r := 0;
  if (ContraRowCount > 0) or (ContraColCount > 0) then
  begin
    OldRectRgn := CreateRectRgn(0, 0, 0, 0);
    r := GetClipRgn(Canvas.Handle, OldRectRgn);
    if UseRightToLeftAlignment then
      RectRgn := CreateRectRgn(DrawInfo.Horz.FullGridExtent - DrawInfo.Horz.ContraExtent,
        0, DrawInfo.Horz.FullGridExtent, DrawInfo.Vert.ContraExtent)
    else
      RectRgn := CreateRectRgn(0, 0, DrawInfo.Horz.ContraExtent, DrawInfo.Vert.ContraExtent);
    ExtSelectClipRgn(Canvas.Handle, RectRgn, RGN_AND);
    DeleteObject(RectRgn);
  end;

  UpdateRect := Canvas.ClipRect;

  with DrawInfo do
  begin
    if (Horz.EffectiveLineWidth > 0) or (Vert.EffectiveLineWidth > 0) then
    begin
      { Draw the grid line in the four areas (fixed, fixed), (variable, fixed),
        (fixed, variable) and (variable, variable) }
//      LineColor := clSilver;
      MaxStroke := Max(Horz.LastFullVisibleCell - LeftCol + FixedCols,
                        Vert.LastFullVisibleCell - TopRow + FixedRows) + 3;
//      PointsList := StackAlloc(MaxStroke * sizeof(TPoint) * 2);
//      StrokeList := StackAlloc(MaxStroke * sizeof(Integer));
      SetLength(PointsList, MaxStroke * 2 ); // two points per stroke
      SetLength(StrokeList, MaxStroke);
      for I := 0 to MaxStroke - 1 do
        StrokeList[I] := 2;

//      if ColorToRGB(Color) = clSilver then LineColor := clGray;

      DrawLinesInfo.PointsList := PointsList;
      DrawLinesInfo.StrokeList := StrokeList;
      DrawLinesInfo.MaxStroke := MaxStroke;
      DrawLinesInfo.LastCol := DrawInfo.Horz.LastFullVisibleCell;
      DrawLinesInfo.LastRow := DrawInfo.Vert.LastFullVisibleCell;

// Fixed area
      DrawLines(DrawInfo, goFixedHorzLine in Options, goFixedVertLine in Options,
        0, 0, [0, 0, Horz.FixedBoundary, Vert.NoFrozenBoundary],
        GridLineColors.GetCellColor(0, 0), FixedColor, Canvas, DrawLinesInfo);

// Frozen rows in fixed area
      DrawLines(DrawInfo, goFixedHorzLine in Options, goFixedVertLine in Options,
        0, FixedRows-FrozenRowCount, [0, Vert.NoFrozenBoundary, Horz.NoFrozenBoundary, Vert.FixedBoundary],
        GridLineColors.GetCellColor(0, FixedRows-FrozenRowCount),{ FFixedLineColor,} FixedColor, Canvas, DrawLinesInfo);

// Frozen area
      DrawLines(DrawInfo, goFixedHorzLine in Options, goFixedVertLine in Options,
        FixedCols-FrozenColCount, FixedRows-FrozenRowCount,
        [Horz.NoFrozenBoundary, Vert.NoFrozenBoundary, Horz.FixedBoundary-1, Vert.FixedBoundary-1],
        GridLineColors.GetCellColor(FixedCols-FrozenColCount, FixedRows-FrozenRowCount){LineColor}, FixedColor, Canvas, DrawLinesInfo);

      if Vert.FrozenCelCount > 0 then
        DrawOneLine(Horz.NoFrozenBoundary, Vert.FixedBoundary-1,
          Horz.FixedBoundary, Vert.FixedBoundary-1,
          GridLineColors.GetDownBorderCellColor(FixedCols-1, FixedRows-1));
      if Horz.FrozenCelCount > 0 then
        DrawOneLine(Horz.FixedBoundary-1, Vert.NoFrozenBoundary,
          Horz.FixedBoundary-1, Vert.FixedBoundary,
          GridLineColors.GetRightBorderCellColor(FixedCols-1, FixedRows-1));


      if (FDataOffset.cx <> 0) then
         RCR := RestrictClipRegionAlignment(Canvas,
           Rect(Horz.FixedBoundary, 0, Horz.GridBoundary, Vert.FixedBoundary));

// Fixed rows in data cols
      DrawLines(DrawInfo, goFixedHorzLine in Options, goFixedVertLine in Options,
        LeftCol, 0, [Horz.OutViewVisCellStart, 0, Horz.GridBoundary, Vert.NoFrozenBoundary],
        GridLineColors.GetCellColor(LeftCol, 0){FFixedLineColor}, FixedColor, Canvas, DrawLinesInfo);

// Frozen rows in data cols
      DrawLines(DrawInfo, goFixedHorzLine in Options, goFixedVertLine in Options,
        LeftCol, FixedRows-FrozenRowCount,
        [Horz.OutViewVisCellStart, Vert.NoFrozenBoundary, Horz.GridBoundary, Vert.FixedBoundary],
        GridLineColors.GetCellColor(LeftCol, FixedRows-FrozenRowCount){LineColor}, FixedColor, Canvas, DrawLinesInfo);

      if Vert.FrozenCelCount > 0 then
        DrawOneLine(Horz.FixedBoundary, Vert.FixedBoundary-1,
          Horz.GridBoundary, Vert.FixedBoundary-1,
          GridLineColors.GetDownBorderCellColor(LeftCol, FixedRows-1));

      if (FDataOffset.cx <> 0) then
        RestoreClipRegion(Canvas, RCR);
//      RestoreDataDrawOriginClipRegion(RCR);

      if (FDataOffset.cy <> 0) then
        RCR := RestrictClipRegionAlignment(Canvas,
          Rect(0, Vert.FixedBoundary, Horz.FixedBoundary, Vert.GridBoundary));

// Data rows in fixed cols
      DrawLines(DrawInfo, goFixedHorzLine in Options, goFixedVertLine in Options,
        0, TopRow, [0, Vert.OutViewVisCellStart, Horz.NoFrozenBoundary, Vert.GridBoundary],
        GridLineColors.GetCellColor(0, TopRow){FFixedLineColor}, FixedColor, Canvas, DrawLinesInfo);

// Data rows in frozen cols

      if Horz.FrozenCelCount > 0 then
      begin
        DrawLines(DrawInfo, goFixedHorzLine in Options, goFixedVertLine in Options,
          FixedCols-FrozenColCount, TopRow,
          [Horz.NoFrozenBoundary, Vert.OutViewVisCellStart, Horz.FixedBoundary-1, Vert.GridBoundary],
          GridLineColors.GetCellColor(FixedCols-FrozenColCount, TopRow){LineColor}, FixedColor, Canvas, DrawLinesInfo);
        DrawOneLine(
          Horz.FixedBoundary-1, Vert.OutViewVisCellStart, Horz.FixedBoundary-1, Vert.GridBoundary,
          GridLineColors.GetRightBorderCellColor(FixedCols-1, TopRow));
      end;

      if (FDataOffset.cy <> 0) then
        RestoreClipRegion(Canvas, RCR);

      if (FDataOffset.cx <> 0) or (FDataOffset.cy <> 0) then
         RCR := RestrictClipRegionAlignment(Canvas,
           Rect(Horz.FixedBoundary, Vert.FixedBoundary, Horz.GridBoundary, Vert.GridBoundary));
// Data cells
      DrawLines(DrawInfo, goHorzLine in Options, goVertLine in Options, LeftCol, TopRow,
        [Horz.OutViewVisCellStart, Vert.OutViewVisCellStart, Horz.GridBoundary, Vert.GridBoundary],
        GridLineColors.GetCellColor(LeftCol, TopRow){LineColor}, Color, Canvas, DrawLinesInfo);

      if (FDataOffset.cx <> 0) or (FDataOffset.cy <> 0) then
        RestoreClipRegion(Canvas, RCR);

//      StackFree(StrokeList);
//      StackFree(PointsList);
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

    DrawCells(0, 0, 0, 0, Horz.FixedBoundary, Vert.NoFrozenBoundary,
      FixedColor, [gdFixed]);
    DrawCells(0, FixedRows-FrozenRowCount,
      0, Vert.NoFrozenBoundary, Horz.NoFrozenBoundary, Vert.FixedBoundary,
      FixedColor, [gdFixed]);
    DrawCells(FixedCols-FrozenColCount, FixedRows-FrozenRowCount,
      Horz.NoFrozenBoundary, Vert.NoFrozenBoundary, Horz.FixedBoundary, Vert.FixedBoundary,
      Color, []);

//Top cells in data cols
    if FDataOffset.cx <> 0 then
       RCR := RestrictClipRegionAlignment(Canvas,
         Rect(Horz.FixedBoundary, 0, Horz.GridBoundary, Vert.NoFrozenBoundary));

    DrawCells(LeftCol, 0,
      Horz.OutViewVisCellStart, 0, Horz.GridBoundary, Vert.NoFrozenBoundary, //!! clip
      FixedColor, [gdFixed]);
    DrawCells(LeftCol, FixedRows-FrozenRowCount,
      Horz.OutViewVisCellStart, Vert.NoFrozenBoundary, Horz.GridBoundary, Vert.FixedBoundary, //!! clip
      Color, []);

    if (FDataOffset.cx <> 0) then
      RestoreClipRegion(Canvas, RCR);
//    RestoreDataDrawOriginClipRegion(RCR);

//Fixed and Frozen colls
    if FDataOffset.cy <> 0 then
       RCR := RestrictClipRegionAlignment(Canvas,
         Rect(0, Vert.FixedBoundary, Horz.FixedBoundary, Vert.GridBoundary));

    DrawCells(0, TopRow,
      0, Vert.OutViewVisCellStart, Horz.NoFrozenBoundary, Vert.GridBoundary, FixedColor, [gdFixed]);
    DrawCells(FixedCols-FrozenColCount, TopRow,
      Horz.NoFrozenBoundary, Vert.OutViewVisCellStart, Horz.FixedBoundary, Vert.GridBoundary,
      Color, []);

    if (FDataOffset.cy <> 0) then
      RestoreClipRegion(Canvas, RCR);

//Data cells
    if (FDataOffset.cx <> 0) or (FDataOffset.cy <> 0) then
       RCR := RestrictClipRegionAlignment(Canvas,
         Rect(Horz.FixedBoundary, Vert.FixedBoundary,
              Horz.GridBoundary, Vert.GridBoundary));

    DrawCells(LeftCol, TopRow, Horz.OutViewVisCellStart,                   //!! clip
      Vert.OutViewVisCellStart, Horz.GridBoundary, Vert.GridBoundary, Color, []);

    if (FDataOffset.cx <> 0) or (FDataOffset.cy <> 0) then
      RestoreClipRegion(Canvas, RCR);

    if not (csDesigning in ComponentState) and
      (goRowSelect in Options) and DefaultDrawing and Focused then
    begin
      GridRectToScreenRect(GetSelection, FocRect, False);
      if not UseRightToLeftAlignment then
        Canvas.DrawFocusRect(FocRect)
      else
      begin
        AFocRect := FocRect;
        AFocRect.Left := FocRect.Right;
        AFocRect.Right := FocRect.Left;
        DrawFocusRect(Canvas.Handle, AFocRect);
      end;
    end;

    { Fill in area not occupied by cells }
    if Horz.GridBoundary < Horz.GridExtent then
    begin
      Canvas.Brush.Color := Color;
      Canvas.FillRect(Rect(Horz.GridBoundary, 0, Horz.GridExtent, Vert.GridBoundary));
    end;
    if Vert.GridBoundary < Vert.GridExtent then
    begin
      Canvas.Brush.Color := Color;
      Canvas.FillRect(Rect(0, Vert.GridBoundary, Horz.FixedBoundary+1, Vert.GridExtent));
      Canvas.FillRect(Rect(Horz.FixedBoundary+1, Vert.GridBoundary, Horz.GridExtent, Vert.GridExtent));
    end;

    if goExtendVertLines in Options then
    begin
      DrawGradientUnderDataLines(DrawInfo, 0, Horz.FixedBoundary);
      DrawGradientUnderDataLines(DrawInfo, Horz.FixedBoundary+1, Horz.GridBoundary);
    end;
  end;

  if (ContraRowCount > 0) or (ContraColCount > 0) then
  begin
    if r = 0
      then SelectClipRgn(Canvas.Handle, 0)
      else SelectClipRgn(Canvas.Handle, OldRectRgn);
    DeleteObject(OldRectRgn);
  end;

  DrawContraInfo(DrawInfo);

  if UseRightToLeftAlignment then ChangeGridOrientation(False);
end;

function TCustomGridEh.RestrictClipRegionAlignment(Canvas: TCanvas;
  Rect: TRect): TRCRRec;
var
  RectRgn: HRGN;
begin
  if UseRightToLeftAlignment then
  begin
    Rect.Left := ClientWidth - Rect.Left;
    Rect.Right := ClientWidth - Rect.Right;
  end;
  Result.RectRgn := CreateRectRgn(0, 0, 0, 0);
  Result.Result := GetClipRgn(Canvas.Handle, Result.RectRgn);
  RectRgn := CreateRectRgn(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom);
  ExtSelectClipRgn(Canvas.Handle, RectRgn, RGN_AND);
  DeleteObject(RectRgn);
end;

procedure TCustomGridEh.DrawContraInfo(DrawInfo: TGridDrawInfoEh);
var
  PointsList: TPointArray;
  StrokeList: TDWORDArray;
  {LineIncr, i,} MaxStroke: Integer;
//  LineColor: TColor;
  FrameFlags1, FrameFlags2: DWORD;

  procedure DrawFirstContraLine(Left, Top, Right, Bottom: Integer; Color: TColor);
  begin
    PointsList[0].X := Left;
    PointsList[0].Y := Top;
    PointsList[1].X := Right;
    PointsList[1].Y := Bottom;
    Canvas.Pen.Color := Color;
(*
{$IFDEF CIL}
    PolyPolyLine(Canvas.Handle, PointsList, StrokeList, 1);
{$ELSE}
    PolyPolyLine(Canvas.Handle, Pointer(PointsList)^, Pointer(StrokeList)^, 1);
{$ENDIF}
*)
    DrawPolyPolyline(PointsList, StrokeList, 2);
  end;

  procedure DrawContraCells(ACol, ARow: Longint; StartX, StartY, StopX, StopY: Integer;
    Color: TColor; IncludeDrawState: TGridDrawState);
  var
    CurCol, CurRow: Longint;
    AWhere, Where, TempRect: TRect;
    DrawState: TGridDrawState;
//    Focused: Boolean;
  begin
    CurRow := ARow;
    Where.Top := StartY;
    while (Where.Top < StopY) and (CurRow < FullRowCount) do
    begin
      CurCol := ACol;
      Where.Left := StartX;
      Where.Bottom := Where.Top + {Contra}RowHeights[CurRow];
      while (Where.Left < StopX) and (CurCol < FullColCount) do
      begin
        Where.Right := Where.Left + {Contra}ColWidths[CurCol];
        if (Where.Right > Where.Left) and RectVisible(Canvas.Handle, Where) then
        begin
          DrawState := IncludeDrawState;
//          Focused := IsActiveControl;
//          if Focused and (CurRow = Row) and (CurCol = Col)  then
//            Include(DrawState, gdFocused);
//          if PointInGridRect(CurCol, CurRow, Sel) then
//            Include(DrawState, gdSelected);
          if not (gdFocused in DrawState) or not (goEditing in Options) or
            not FEditorMode or (csDesigning in ComponentState) then
          begin
            if DefaultDrawing or (csDesigning in ComponentState) then
              with Canvas do
              begin
                Font := Self.Font;
                if (gdSelected in DrawState) and
                  (not (gdFocused in DrawState) or
                  ([goDrawFocusSelected, goRowSelect] * Options <> [])) then
                begin
                  Brush.Color := clHighlight;
                  Font.Color := clHighlightText;
                end
                else
                  Brush.Color := Color;
                FillRect(Where);
              end;
            DrawCell(CurCol, CurRow, Where, DrawState);
            if DefaultDrawing and (gdFixed in DrawState) and Ctl3D and
              ((FrameFlags1 or FrameFlags2) <> 0) then
            begin
              TempRect := Where;
              if (FrameFlags1 and BF_RIGHT) = 0 then
                Inc(TempRect.Right, DrawInfo.Horz.EffectiveLineWidth)
              else if (FrameFlags1 and BF_BOTTOM) = 0 then
                Inc(TempRect.Bottom, DrawInfo.Vert.EffectiveLineWidth);
              DrawEdgeEh(Canvas, TempRect, False, False, True, True);
              DrawEdgeEh(Canvas, TempRect, False, False, True, True);
            end;

            if DefaultDrawing and not (csDesigning in ComponentState) and
              (gdFocused in DrawState) and
              ([goEditing, goAlwaysShowEditor] * Options <>
              [goEditing, goAlwaysShowEditor])
              and not (goRowSelect in Options) then
            begin
              if not UseRightToLeftAlignment then
                DrawFocusRect(Canvas.Handle, Where)
              else
              begin
                AWhere := Where;
                AWhere.Left := Where.Right;
                AWhere.Right := Where.Left;
                DrawFocusRect(Canvas.Handle, AWhere);
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

var
  RCR, RCR1: TRCRRec;
  DrawLinesInfo: TDrawLinesInfoEh;
  I: Integer;
begin

  with DrawInfo do
  begin
      MaxStroke := Trunc(MaxValue( [DrawInfo.Horz.LastFullVisibleCell - LeftCol + FixedCols,
                              DrawInfo.Vert.LastFullVisibleCell - TopRow + FixedRows,
                              DrawInfo.Horz.ContraCelCount,
                              DrawInfo.Vert.ContraCelCount])) + 3;

      SetLength(PointsList, MaxStroke * 2); // two points per stroke
      SetLength(StrokeList, MaxStroke);

      for I := 0 to MaxStroke - 1 do
        StrokeList[I] := 2;

      DrawLinesInfo.PointsList := PointsList;
      DrawLinesInfo.StrokeList := StrokeList;
      DrawLinesInfo.MaxStroke := MaxStroke;
      DrawLinesInfo.LastCol := DrawInfo.Horz.FullGridCellCount-1;
      DrawLinesInfo.LastRow := DrawInfo.Vert.FullGridCellCount-1;

      //Horz
      DrawLines(DrawInfo, goFixedHorzLine in Options, goFixedVertLine in Options,
        0, RowCount,
        [0, Vert.ContraExtent+1, Horz.NoFrozenBoundary, Vert.FullGridExtent],
        GridLineColors.GetCellColor(0, RowCount){FFixedLineColor}, FixedColor, Canvas, DrawLinesInfo);

      DrawLines(DrawInfo, goFixedHorzLine in Options, goFixedVertLine in Options,
        FixedCols-FrozenColCount, RowCount,
        [Horz.NoFrozenBoundary, Vert.ContraExtent+1, Horz.FixedBoundary-1, Vert.FullGridExtent],
        GridLineColors.GetCellColor(FixedCols-FrozenColCount, RowCount){LineColor}, FixedColor, Canvas, DrawLinesInfo);
      if Horz.FrozenCelCount > 0 then
        DrawFirstContraLine(Horz.FixedBoundary-1, Vert.ContraExtent+1,
          Horz.FixedBoundary-1, Vert.FullGridExtent,
          GridLineColors.GetRightBorderCellColor(FixedCols-1, RowCount){FFixedLineColor});
      DrawFirstContraLine(0, Vert.ContraExtent,
        Horz.FixedBoundary, Vert.ContraExtent,
        GridLineColors.GetTopBorderCellColor(FixedCols-FrozenColCount, RowCount){FFixedLineColor});

//      RCR := SetDataDrawOriginClipRegion(
//        Horz.FixedBoundary, Vert.ContraExtent+1, Horz.GridBoundary, Vert.FullGridExtent);
    if (FDataOffset.cx <> 0) or (FDataOffset.cy <> 0) then
       RCR := RestrictClipRegionAlignment(Canvas,
         Rect(Horz.FixedBoundary, Vert.ContraExtent,
              Horz.GridBoundary, Vert.FullGridExtent));

      DrawLines(DrawInfo, goHorzLine in Options, goVertLine in Options,
        LeftCol, RowCount,
        [Horz.OutViewVisCellStart, Vert.ContraExtent+1, Horz.GridBoundary, Vert.FullGridExtent],
        GridLineColors.GetCellColor(LeftCol, RowCount){LineColor}, Color, Canvas, DrawLinesInfo);
      DrawFirstContraLine(Horz.OutViewVisCellStart, Vert.ContraExtent,
        Horz.GridBoundary, Vert.ContraExtent,
        GridLineColors.GetTopBorderCellColor(LeftCol, RowCount){FFixedLineColor});

      if (FDataOffset.cx <> 0) or (FDataOffset.cy <> 0) then
        RestoreClipRegion(Canvas, RCR);
//      RestoreDataDrawOriginClipRegion(RCR);


      //Vert
      DrawLines(DrawInfo, goFixedHorzLine in Options, goFixedVertLine in Options,
        ColCount, 0,
        [Horz.ContraExtent+1, 0, Horz.FullGridExtent, Vert.NoFrozenBoundary],
        GridLineColors.GetCellColor(ColCount, 0){FFixedLineColor}, FixedColor, Canvas, DrawLinesInfo);
      DrawLines(DrawInfo, goFixedHorzLine in Options, goFixedVertLine in Options,
        ColCount, FixedRows-FrozenRowCount,
        [Horz.ContraExtent+1, Vert.NoFrozenBoundary, Horz.FullGridExtent, Vert.FixedBoundary-1],
        GridLineColors.GetCellColor(ColCount, FixedRows-FrozenRowCount){LineColor}, FixedColor, Canvas, DrawLinesInfo);

      if Vert.FrozenCelCount > 0 then
        DrawFirstContraLine(Horz.ContraExtent+1, Vert.FixedBoundary-1,
          Horz.FullGridExtent, Vert.FixedBoundary-1,
          GridLineColors.GetLeftBorderCellColor(ColCount, FixedRows-1){FFixedLineColor});
      DrawFirstContraLine(Horz.ContraExtent, 0,
        Horz.ContraExtent, Vert.FixedBoundary,
        GridLineColors.GetLeftBorderCellColor(ColCount, FixedRows-FrozenRowCount){FFixedLineColor});

      DrawLines(DrawInfo, goHorzLine in Options, goVertLine in Options,
        ColCount, TopRow,
        [Horz.ContraExtent+1, Vert.FixedBoundary, Horz.FullGridExtent, Vert.GridBoundary],
        GridLineColors.GetCellColor(ColCount, TopRow){LineColor}, Color, Canvas, DrawLinesInfo);
      DrawFirstContraLine(Horz.ContraExtent, Vert.FixedBoundary,
        Horz.ContraExtent, Vert.GridBoundary,
        GridLineColors.GetLeftBorderCellColor(ColCount, TopRow){FFixedLineColor});

      //Corner
      DrawLines(DrawInfo, goHorzLine in Options, goVertLine in Options,
        ColCount, RowCount,
        [Horz.ContraExtent+1, Vert.ContraExtent+1, Horz.FullGridExtent, Vert.FullGridExtent],
        GridLineColors.GetCellColor(ColCount, RowCount){LineColor}, Color, Canvas, DrawLinesInfo);
      DrawFirstContraLine(Horz.ContraExtent, Vert.ContraExtent,
        Horz.ContraExtent, Vert.FullGridExtent,
        GridLineColors.GetLeftBorderCellColor(ColCount, RowCount){FFixedLineColor});
      DrawFirstContraLine(Horz.ContraExtent, Vert.ContraExtent,
        Horz.FullGridExtent, Vert.ContraExtent,
        GridLineColors.GetTopBorderCellColor(ColCount, RowCount){FFixedLineColor});

//      FreeMemory(PointsList);
//      FreeMemory(StrokeList);
//    end;

    { Draw the cells in the four areas }
//    Sel := Selection;
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

// Horz
    if Horz.ContraExtent < Horz.FullGridExtent then
      if (ContraRowCount > 0) or (ContraColCount > 0) then
        if UseRightToLeftAlignment then
          RCR := RestrictClipRegion(Canvas,
            Rect(Horz.FullGridExtent-Horz.GridBoundary,
              Vert.ContraExtent, Horz.FullGridExtent, Vert.FullGridExtent))
        else
           RCR := RestrictClipRegion(Canvas,
              Rect(0, Vert.ContraExtent, Horz.GridBoundary, Vert.FullGridExtent));

    DrawContraCells(0, RowCount,
      0, Vert.ContraExtent+1, Horz.NoFrozenBoundary, Vert.FullGridExtent,
      FixedColor, [gdFixed]);
    DrawContraCells(FixedCols-FrozenColCount, RowCount,
      Horz.NoFrozenBoundary, Vert.ContraExtent+1, Horz.FixedBoundary, Vert.FullGridExtent,
      Color, []);

    if (FDataOffset.cx <> 0) or (FDataOffset.cy <> 0) then
       RCR1 := RestrictClipRegionAlignment(Canvas,
         Rect(Horz.FixedBoundary, Vert.ContraExtent,
              Horz.GridExtent, Vert.FullGridExtent));

    DrawContraCells(LeftCol, RowCount,
      Horz.OutViewVisCellStart, Vert.ContraExtent+1, Horz.GridBoundary, Vert.FullGridExtent, //!! clip
      Color, []);

    if (FDataOffset.cx <> 0) or (FDataOffset.cy <> 0) then
      RestoreClipRegion(Canvas, RCR1);

    if Horz.ContraExtent < Horz.FullGridExtent then
      RestoreClipRegion(Canvas, RCR);

// Vert
    RCR.RectRgn := 0;
    if Vert.ContraExtent < Vert.FullGridExtent then
      if (ContraRowCount > 0) or (ContraColCount > 0) then
        if UseRightToLeftAlignment then
          RCR := RestrictClipRegion(Canvas,
            Rect(0, 0, Horz.FullGridExtent-Horz.ContraExtent, Vert.GridBoundary))
        else
          RCR := RestrictClipRegion(Canvas,
            Rect(Horz.ContraExtent, 0, Horz.FullGridExtent, Vert.GridBoundary));

    DrawContraCells(ColCount, 0,
      Horz.ContraExtent+1, 0, Horz.FullGridExtent, Vert.NoFrozenBoundary,
      FixedColor, [gdFixed]);
    DrawContraCells(ColCount, FixedRows-FrozenRowCount,
      Horz.ContraExtent+1, Vert.NoFrozenBoundary, Horz.FullGridExtent, Vert.FixedBoundary,
      Color, []);

    DrawContraCells(ColCount, TopRow,
      Horz.ContraExtent+1, Vert.FixedBoundary, Horz.FullGridExtent, Vert.GridBoundary, //!! clip
      Color, []);

    if RCR.RectRgn <> 0 then
      RestoreClipRegion(Canvas, RCR);

//Corner
    DrawContraCells(ColCount, RowCount,
      Horz.ContraExtent+1, Vert.ContraExtent+1, Horz.FullGridExtent, Vert.FullGridExtent, //!! clip
      Color, []);

    { Fill in area not occupied by cells }
    if (DrawInfo.Horz.ContraExtent < DrawInfo.Horz.FullGridExtent) and
       (DrawInfo.Vert.GridBoundary < DrawInfo.Vert.GridExtent) then
    begin
      Canvas.Brush.Color := Color;
      Canvas.FillRect(Rect(Horz.ContraExtent, Vert.GridBoundary, Horz.FullGridExtent, Vert.GridExtent));
    end;
    if (DrawInfo.Vert.ContraExtent < DrawInfo.Vert.FullGridExtent) and
       (DrawInfo.Horz.GridBoundary < DrawInfo.Horz.GridExtent) then
    begin
      Canvas.Brush.Color := Color;
      Canvas.FillRect(Rect(Horz.GridBoundary, Vert.ContraExtent, Horz.ContraExtent, Vert.FullGridExtent));
    end;

    if goExtendVertLines in Options then
    begin
      DrawGradientUnderDataLines(DrawInfo, Horz.ContraExtent, Horz.FullGridExtent);
    end;

  end;
end;

function TCustomGridEh.CalcCoordFromPoint(X, Y: Integer;
  const DrawInfo: TGridDrawInfoEh): TGridCoord;

  function DoCalc(const AxisInfo: TGridAxisDrawInfoEh; N: Integer): Integer;
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
      else if N > ContraExtent then
      begin
        Start := GridCellCount;
        Stop := GridCellCount + ContraCelCount - 1;
        Line := ContraExtent + EffectiveLineWidth;
      end else
      begin
        Start := FirstGridCell;
        Stop := GridCellCount - 1;
        Line := FixedBoundary - DataOffset;
      end;
      Result := -1;
      for I := Start to Stop do
      begin
        Inc(Line, AxisInfo.GetExtent(I) + EffectiveLineWidth);
        if N < Line then
        begin
          Result := I;
          Exit;
        end;
      end;
    end;
  end;

  function DoCalcRightToLeft(const AxisInfo: TGridAxisDrawInfoEh; N: Integer): Integer;
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
//        Line := ClientWidth;
        Line := 0;
      end
      else
      begin
        Start := FirstGridCell;
        Stop := GridCellCount - 1;
        Line := FixedBoundary - DataOffset;
      end;
      Result := -1;
      for I := Start to Stop do
      begin
        Inc(Line, AxisInfo.GetExtent(I) + EffectiveLineWidth);
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

procedure TCustomGridEh.CalcDrawInfo(var DrawInfo: TGridDrawInfoEh);
begin
  if HandleAllocated
    then CalcDrawInfoXY(DrawInfo, ClientWidth, ClientHeight)
    else CalcDrawInfoXY(DrawInfo, Width, Height);
end;

procedure TCustomGridEh.CalcDrawInfoXY(var DrawInfo: TGridDrawInfoEh;
  UseWidth, UseHeight: Integer);

  procedure CalcAxis(var AxisInfo: TGridAxisDrawInfoEh; UseExtent: Integer);
  var
    I: Integer;
  begin
    with AxisInfo do
    begin
      FullGridExtent := UseExtent;
      GridExtent := {UseExtent - }ContraExtent;
      OutViewVisCellStart := FixedBoundary - DataOffset;
      GridBoundary := OutViewVisCellStart;
      FullVisBoundary := FixedBoundary;
      LastFullVisibleCell := FirstGridCell;
      for I := FirstGridCell to GridCellCount - 1 do
      begin
        Inc(GridBoundary, AxisInfo.GetExtent(I) + EffectiveLineWidth);
        if GridBoundary > GridExtent{ + EffectiveLineWidth} then
        begin
          GridBoundary := GridExtent{ + DataOffset};
//          VirtualGridBoundary := GridExtent +
          Break;
        end;
        LastFullVisibleCell := I;
        FullVisBoundary := GridBoundary;
      end;
      if ContraCelCount > 0
        then FullGridBoundary := FullGridExtent
        else FullGridBoundary := GridBoundary;
    end;
  end;

begin
  CalcContraInfo(DrawInfo, UseWidth, UseHeight);
  CalcFixedInfo(DrawInfo);
  CalcAxis(DrawInfo.Horz, UseWidth);
  CalcAxis(DrawInfo.Vert, UseHeight);
end;

procedure TCustomGridEh.CalcContraInfo(var DrawInfo: TGridDrawInfoEh;
  UseWidth, UseHeight: Integer);

  procedure CalcContraAxis(var Axis: TGridAxisDrawInfoEh; LineOptions: TGridOptions;
    DataCelCount, ContraCellCount: Integer; GetExtentFunc: TGetExtentsFuncEh; UseExtent, ADataOffset: Integer);
  var
    I: Integer;
  begin
    with Axis do
    begin
      if LineOptions * Options = [] then
        EffectiveLineWidth := 0
      else
        EffectiveLineWidth := GridLineWidth;

      ContraCelCount := ContraCellCount;
      DataOffset := ADataOffset;

      ContraExtent := UseExtent;
      for I := DataCelCount to DataCelCount + ContraCellCount - 1 do
        Dec(ContraExtent, GetExtentFunc(I) + EffectiveLineWidth);
      if ContraCelCount > 0 then
        Dec(ContraExtent, EffectiveLineWidth); //Bottom line
//      GetContraExtent := GetExtentFunc;
    end;
  end;

begin
  CalcContraAxis(DrawInfo.Horz, [goFixedVertLine, goVertLine], ColCount, ContraColCount,
    {Contra} GetColWidths,  UseWidth, FDataOffset.cx);
  CalcContraAxis(DrawInfo.Vert, [goFixedHorzLine, goHorzLine], RowCount, ContraRowCount,
    {Contra} GetRowHeights, UseHeight, FDataOffset.cy);
end;

procedure TCustomGridEh.CalcFixedInfo(var DrawInfo: TGridDrawInfoEh);

  procedure CalcFixedAxis(var Axis: TGridAxisDrawInfoEh; LineOptions: TGridOptions;
    FixedCount, FirstCell, CellCount: Integer; GetExtentFunc: TGetExtentsFuncEh;
    FrozenCount: Integer);
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
      FullGridCellCount := CellCount + ContraCelCount;
      Axis.GetExtent := GetExtentFunc;

      NoFrozenBoundary := FixedBoundary;
      FrozenCelCount := FrozenCount;
      for I := 0 to FrozenCelCount - 1 do
        Dec(NoFrozenBoundary, GetExtentFunc(FixedCellCount - I - 1) + EffectiveLineWidth);
    end;
  end;

begin
  CalcFixedAxis(DrawInfo.Horz, [goFixedVertLine, goVertLine], FixedCols,
    LeftCol, ColCount, GetColWidths, FrozenColCount);
  CalcFixedAxis(DrawInfo.Vert, [goFixedHorzLine, goHorzLine], FixedRows,
    TopRow, RowCount, GetRowHeights, FrozenRowCount);
end;

{ Calculates the TopLeft that will put the given Coord in view }
function TCustomGridEh.CalcMaxTopLeft(const Coord: TGridCoord;
  const DrawInfo: TGridDrawInfoEh): TGridCoord;

  function CalcMaxCell(const Axis: TGridAxisDrawInfoEh; Start: Integer): Integer;
  var
    Line: Integer;
    I, Extent: Longint;
  begin
    Result := Start;
    if Start < Axis.FixedCellCount then
      Start := Axis.FixedCellCount;
    with Axis do
    begin
      Line := GridExtent + EffectiveLineWidth;
      for I := Start downto FixedCellCount do
      begin
        Extent := Axis.GetExtent(I);
        if Extent > 0 then
        begin
          Dec(Line, Extent);
          Dec(Line, EffectiveLineWidth);
          if Line <= FixedBoundary then
          begin
            if (Result = Start) and (Axis.GetExtent(Start) <= 0) then
              Result := I;
            Break;
          end;
          Result := I;
        end;
      end;
    end;
  end;

begin
  Result.X := CalcMaxCell(DrawInfo.Horz, Coord.X);
  Result.Y := CalcMaxCell(DrawInfo.Vert, Coord.Y);
end;

function TCustomGridEh.CalcMinLeftTopNonVisiblePart(const MaxCell: TGridCoord;
  const DrawInfo: TGridDrawInfoEh): TSize;

  function CalcPartialCell(const Axis: TGridAxisDrawInfoEh; Start: Integer): Longint;
  var
    Line: Integer;
    I, Extent: Longint;
  begin
    Result := 0;
    Line := Axis.GridExtent;
    for i := Start downto Axis.FixedCellCount do
    begin
      Extent := Axis.GetExtent(I);
      if Extent > 0 then
      begin
        Dec(Line, Extent);
        Dec(Line, Axis.EffectiveLineWidth);
        if Line <= Axis.FixedBoundary then
        begin
          if i = Start
            then Result := 0
            else Result := Axis.FixedBoundary - Line;
          Break;
        end;
      end;
    end;
  end;

begin
  Result.cx := CalcPartialCell(DrawInfo.Horz, MaxCell.X);
  Result.cy := CalcPartialCell(DrawInfo.Vert, MaxCell.Y);
end;

procedure TCustomGridEh.CalcSizingState(X, Y: Integer; var State: TGridState;
  var Index: Longint; var SizingPos, SizingOfs: Integer;
  var FixedInfo: TGridDrawInfoEh);

  procedure CalcAxisState(const AxisInfo: TGridAxisDrawInfoEh; Pos: Integer;
    NewState: TGridState);
  var
    I, Line, Back, Range: Integer;
  begin
    if (NewState = gsColSizing) and UseRightToLeftAlignment then
      Pos := ClientWidth - Pos;
    with AxisInfo do
    begin
      Range := EffectiveLineWidth;
      Back := 0;
      if Range < 7 then
      begin
        Range := 7;
        Back := (Range - EffectiveLineWidth) shr 1;
      end;
      Line := NoFrozenBoundary;
      for I := FixedCellCount - FrozenCelCount to FixedCellCount - 1 do
      begin
        Inc(Line, AxisInfo.GetExtent(I));
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
      //Data
      Line := FixedBoundary - AxisInfo.DataOffset;
      for I := FirstGridCell to GridCellCount - 1 do
      begin
        Inc(Line, AxisInfo.GetExtent(I));
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
        if FullVisBoundary = FixedBoundary
          then Index := LastFullVisibleCell
          else Index := LastFullVisibleCell + 1;
        Exit;
      end;

      //Contra
      if (ContraCelCount > 0) and (Pos >= ContraExtent)
        and (Pos <= GridExtent + Back) then
      begin
        State := NewState;
        SizingPos := GridExtent;
        SizingOfs := GridExtent - Pos;
        Index := GridCellCount;
        Exit;
      end;

      Line := ContraExtent + EffectiveLineWidth;
      for I := GridCellCount to GridCellCount + ContraCelCount - 2 do
      begin
        Inc(Line, AxisInfo.GetExtent(I));
        if Line > FullGridBoundary then Break;
        if (Pos >= Line - Back) and (Pos <= Line - Back + Range) then
        begin
          State := NewState;
          SizingPos := Line;
          SizingOfs := Line - Pos;
          Index := I + 1;
          Exit;
        end;
        Inc(Line, EffectiveLineWidth);
      end;
    end;
  end;

  function XOutsideHorzFixedBoundary: Boolean;
  begin
    with FixedInfo do
      if not UseRightToLeftAlignment then
        Result := X > Horz.NoFrozenBoundary //FixedBoundary
      else
        Result := X < ClientWidth - Horz.NoFrozenBoundary; //FixedBoundary;
  end;

  function XOutsideOrEqualHorzFixedBoundary: Boolean;
  begin
    with FixedInfo do
      if not UseRightToLeftAlignment then
        Result := X >= Horz.NoFrozenBoundary // FixedBoundary
      else
        Result := X <= ClientWidth - Horz.NoFrozenBoundary; // FixedBoundary;
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
//      Vert.GridExtent := ClientHeight;     //? Why need this line.
//      Horz.GridExtent := ClientWidth;      //? Why need this line.
      if (XOutsideHorzFixedBoundary) and (goColSizing in EffectiveOptions) then
      begin
        if Y >= Vert.NoFrozenBoundary{FixedBoundary} then Exit;
        CalcAxisState(Horz, X, gsColSizing);
      end
      else if (Y > Vert.NoFrozenBoundary{FixedBoundary}) and (goRowSizing in EffectiveOptions) then
      begin
        if XOutsideOrEqualHorzFixedBoundary then Exit;
        CalcAxisState(Vert, Y, gsRowSizing);
      end;
    end;
end;

procedure TCustomGridEh.ChangeGridOrientation(RightToLeftOrientation: Boolean);
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

procedure TCustomGridEh.AdjustSize(Index, Amount: Longint; Rows: Boolean);
// Adds or deletes rows or columns from 'Index' with 'Amount'.
var
  NewCur: TGridCoord;
  OldRows, OldCols, TabColColunt, TabNewCur: Longint;
  MovementX, MovementY: Longint;
  MoveRect: TGridRect;
  ScrollArea: TRect;
  AbsAmount: Longint;

  function DoSizeAdjust(var Count: Longint; var Extents: TIntegerArray;
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
        Inc(Result, Extents[I]);
    end
    else
      Result := Amount * DefaultExtent;
    if Extents <> nil then
      ModifyExtents(Extents, Index, Amount, DefaultExtent);
    Count := NewCount;
    if Current >= Index then
      if (Amount < 0) and (Current < Index - Amount)
        then Current := Index
        else Inc(Current, Amount);
    if Current >= Count then
      Current := Count - 1;
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
(*    if IsSmoothVertScroll and (RowCount < OldRows) then
    begin
      FGridDataSize.cy := FGridDataSize.cy +
       GetChangingGridDataExtend(OldCols, RowCount - OldRows, True);
    end;*)

    MovementY := DoSizeAdjust(FRowCount, FRowHeights, DefaultRowHeight, NewCur.Y);

(*    if IsSmoothVertScroll and (RowCount > OldCols) then
    begin
      FGridDataSize.cy := FGridDataSize.cy +
        GetChangingGridDataExtend(OldCols, RowCount - OldRows, True);
    end;*)

    MoveRect.Top := Index;
    if Index + AbsAmount <= TopRow then MoveRect.Bottom := TopRow - 1;
  end
  else
  begin
    TabColColunt := FColCount;
    TabNewCur := NewCur.X;
    DoSizeAdjust(TabColColunt, FTabStops, Integer(True), TabNewCur);

    MovementX := DoSizeAdjust(FColCount, FColWidths, DefaultColWidth, NewCur.X);

    MoveRect.Left := Index;
    if Index + AbsAmount <= LeftCol then MoveRect.Right := LeftCol - 1;
  end;
  GridRectToScreenRect(MoveRect, ScrollArea, True);
  if not IsRectEmpty(ScrollArea) then
  begin
    WindowsScrollWindow(Handle, MovementX, MovementY, ScrollArea, ScrollArea);
    UpdateWindow(Handle);
  end;
  if (ContraRowCount > 0) or (ContraColCount > 0) then Invalidate;
  SizeChanged(OldCols, OldRows);
  if (NewCur.X <> FCurrent.X) or (NewCur.Y <> FCurrent.Y) then
    MoveCurrent(NewCur.X, NewCur.Y, True, True);
  UpdateScrollRange;
end;

procedure TCustomGridEh.ChangeSize(NewColCount, NewRowCount: Longint);
var
  OldColCount, OldRowCount: Longint;
  OldDrawInfo: TGridDrawInfoEh;
  OldGridDataWidth: TSize;

  procedure MinRedraw(const OldInfo, NewInfo: TGridAxisDrawInfoEh; Axis: Integer);
  var
    R: TRect;
    First: Integer;
  begin
    First := Min(OldInfo.LastFullVisibleCell, NewInfo.LastFullVisibleCell);
    // Get the rectangle around the leftmost or topmost cell in the target range.
    R := CellRect(First and not Axis, First and Axis);
    R.Bottom := Height;
    R.Right := Width;
    WindowsInvalidateRect(Handle, R, False);
  end;

  procedure DoChange;
  var
    Coord: TGridCoord;
    NewDrawInfo: TGridDrawInfoEh;
  begin
    if Length(FColWidths) <> 0 then
      UpdateExtents(FColWidths, FullColCount, DefaultColWidth);
    if Length(FTabStops) <> 0 then
      UpdateExtents(FTabStops, FullColCount, Integer(True));
    if Length(FRowHeights) <> 0 then
      UpdateExtents(FRowHeights, FullRowCount, DefaultRowHeight);
    Coord := FCurrent;
    if Row >= RowCount then Coord.Y := RowCount - 1;
    if Col >= ColCount then Coord.X := ColCount - 1;
    if (FCurrent.X <> Coord.X) or (FCurrent.Y <> Coord.Y) then
      MoveCurrent(Coord.X, Coord.Y, True, True);
    if (FAnchor.X <> Coord.X) or (FAnchor.Y <> Coord.Y) then
      MoveAnchor(Coord, False);
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
    UpdateScrollRange;
    SizeChanged(OldColCount, OldRowCount);
  end;

begin
  if HandleAllocated then
    CalcDrawInfo(OldDrawInfo);

  OldColCount := FColCount;
  OldRowCount := FRowCount;

(*  if IsSmoothHorzScroll and (NewColCount < OldColCount) then
  begin
    FGridDataSize.cx := FGridDataSize.cx +
      GetChangingGridDataExtend(OldColCount, NewColCount - OldColCount, False);
  end;
  if IsSmoothVertScroll and (NewRowCount < OldRowCount) then
  begin
    FGridDataSize.cy := FGridDataSize.cy +
      GetChangingGridDataExtend(OldRowCount, NewRowCount - OldRowCount, True);
  end;*)
  FColCount := NewColCount;
  FRowCount := NewRowCount;
  if FixedCols > NewColCount then FFixedCols := NewColCount - 1;
  if FixedRows > NewRowCount then FFixedRows := NewRowCount - 1;
  OldGridDataWidth := FGridDataSize;

  try
    DoChange;

(*    if IsSmoothHorzScroll and (NewColCount > OldColCount) then
    begin
      FGridDataSize.cx := FGridDataSize.cx +
        GetChangingGridDataExtend(OldColCount, NewColCount - OldColCount, False);
    end;
    if IsSmoothVertScroll and (NewRowCount > OldRowCount) then
    begin
      FGridDataSize.cy := FGridDataSize.cy +
        GetChangingGridDataExtend(OldRowCount, NewRowCount - OldRowCount, True);
    end;*)

  except
    { Could not change size so try to clean up by setting the size back }
    FGridDataSize := OldGridDataWidth;
    FColCount := OldColCount;
    FRowCount := OldRowCount;
    DoChange;
    InvalidateGrid;
    raise;
  end;
end;

{ Will move TopLeft so that Coord is in view }
procedure TCustomGridEh.ClampInView(const Coord: TGridCoord; CheckX, CheckY: Boolean);
var
  DrawInfo: TGridDrawInfoEh;
  MaxTopLeft: TGridCoord;
  OldTopLeft: TGridCoord;
  OldDataOffset: TSize;
  LastPartialVisibleSize: TSize;
begin
  if not HandleAllocated then Exit;
  CalcDrawInfo(DrawInfo);
  with DrawInfo, Coord do
  begin
    if (X > Horz.LastFullVisibleCell) or
      (Y > Vert.LastFullVisibleCell) or
      (X < LeftCol) or
      (Y < TopRow) or
      ((X = LeftCol) and (FDataOffset.cx > 0)) or
      ((Y = TopRow) and (FDataOffset.cy > 0)) then
    begin
      OldTopLeft := FTopLeft;
      OldDataOffset := FDataOffset;
      MaxTopLeft := CalcMaxTopLeft(Coord, DrawInfo);
//      LastPartialVisibleSize := CalcLastPartialVisibleSize(MaxTopLeft, DrawInfo);
      LastPartialVisibleSize := CalcMinLeftTopNonVisiblePart(Coord, DrawInfo);
      Update;
      if CheckX then
      begin
      if (X = LeftCol) and (FDataOffset.cx > 0) then
        FDataOffset.cx := 0
      else if (X < LeftCol) and (X >= FixedCols)  then
      begin
        FTopLeft.X := X;
        FDataOffset.cx := 0;
      end else if X > Horz.LastFullVisibleCell then
      begin
        FTopLeft.X := MaxTopLeft.X;
        if IsSmoothHorzScroll and (FTopLeft.X > FixedCols) and (LastPartialVisibleSize.cx <> 0) then
        begin
          Dec(FTopLeft.X);
          FDataOffset.cx := LastPartialVisibleSize.cx;
        end;
      end;
      end;

      if CheckY then
      begin
      if (Y = TopRow) and (FDataOffset.cy > 0) then
        FDataOffset.cy := 0
      else if (Y < TopRow) and (Y >= FixedRows) then
      begin
        FTopLeft.Y := Y;
        FDataOffset.cy := 0;
      end else if Y > Vert.LastFullVisibleCell then
      begin
        FTopLeft.Y := MaxTopLeft.Y;
        if IsSmoothVertScroll and (FTopLeft.Y > FixedRows) and (LastPartialVisibleSize.cy <> 0) then
        begin
          Dec(FTopLeft.Y);
          FDataOffset.cy := LastPartialVisibleSize.cy;
        end;
      end;
      end;  
      TopLeftMoved(OldTopLeft, OldDataOffset);
    end;
  end;
end;

procedure TCustomGridEh.GetDrawSizingLineBound(const DrawInfo: TGridDrawInfoEh;
  var StartPos, FinishPos: Integer);
begin
  if FGridState = gsRowSizing then
    if UseRightToLeftAlignment then
    begin
      StartPos := DrawInfo.Horz.FullGridExtent;
      FinishPos := DrawInfo.Horz.FullGridExtent - DrawInfo.Horz.FullGridBoundary;
    end else
    begin
      StartPos := 0;
      FinishPos := DrawInfo.Horz.FullGridBoundary;
    end
  else
  begin
    StartPos := 0;
    FinishPos := DrawInfo.Vert.FullGridBoundary;
  end;
end;

procedure TCustomGridEh.DrawSizingLine(const DrawInfo: TGridDrawInfoEh);
var
  OldPen: TPen;
  StartPos, FinishPos: Integer;
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
        GetDrawSizingLineBound(DrawInfo, StartPos, FinishPos);
        if FGridState = gsRowSizing then
        begin
          MoveTo(StartPos, FSizingPos);
          LineTo(FinishPos, FSizingPos);
        end
        else
        begin
          MoveTo(FSizingPos, StartPos);
          LineTo(FSizingPos, FinishPos);
       end;
      finally
        Pen := OldPen;
      end;
    end;
  finally
    OldPen.Free;
  end;
end;

procedure TCustomGridEh.DrawMove(const DrawInfo: TGridDrawInfoEh);
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
        Pen.Color := clWhite;
        if FGridState = gsRowMoving then
        begin
          R := CellRect(0, FMovePos);
          if FMovePos > FMoveIndex then
            Pos := R.Bottom else
            Pos := R.Top;
          MoveTo(0, Pos);
          LineTo(ClientWidth, Pos);
        end
        else // gsColMoving
        begin
          R := CellRect(FMovePos, 0);
          if FMovePos > FMoveIndex then
            if not UseRightToLeftAlignment then
              Pos := R.Right
            else
              Pos := R.Left
          else
            if not UseRightToLeftAlignment then
              Pos := R.Left-1
            else
              Pos := R.Right;
//          MoveTo(Pos, 0);
//          LineTo(Pos, ClientHeight);
          if GetMoveLineEh.Visible then
            GetMoveLineEh.MoveToFor(Self, Point(Pos, 0))
          else
            GetMoveLineEh.StartShow(Self, Point(Pos, 0), True, DrawInfo.Vert.FullGridBoundary);
        end;
      finally
        Canvas.Pen := OldPen;
      end;
    end;
  finally
    OldPen.Free;
  end;
end;

procedure TCustomGridEh.HideMove;
begin
  GetMoveLineEh.Hide;
end;

function TCustomGridEh.DrawMoveLine(FromPos: Integer; Smooth: Integer; WithDelay: Boolean): Integer;
var
  OldPen: TPen;
  Pos: Integer;
  R: TRect;

  procedure DrawSmoothMoveLine;
  var
    MovePos, IncPos: Integer;
  begin
    if FromPos < Pos then
      IncPos := 1
    else if FromPos > Pos then
     IncPos := -1
    else
      Exit;
    MovePos := FromPos;
    while True do
    begin
      Canvas.MoveTo(0, MovePos);
      Canvas.LineTo(ClientWidth, MovePos);
      Canvas.MoveTo(0, MovePos);
      Canvas.LineTo(ClientHeight, MovePos);
      if MovePos = Pos then
        Break;
      Inc(MovePos, IncPos);
    end;
  end;

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
        Pen.Color := clWhite;
        if FGridState = gsRowMoving then
        begin
          R := CellRect(0, FMovePos);
          if FMovePos > FMoveIndex then
            Pos := R.Bottom else
            Pos := R.Top;
          MoveTo(0, Pos);
          LineTo(ClientWidth, Pos);
          Result := Pos;
        end
        else // gsColMoving
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
          DrawSmoothMoveLine;    
          MoveTo(Pos, 0);
          LineTo(Pos, ClientHeight);
          Result := Pos;
        end;
      finally
        Canvas.Pen := OldPen;
      end;
    end;
  finally
    OldPen.Free;
  end;
end;

procedure TCustomGridEh.FocusCell(ACol, ARow: Longint; MoveAnchor: Boolean);
begin
  MoveCurrent(ACol, ARow, MoveAnchor, True);
  UpdateEdit;
  Click;
end;

procedure TCustomGridEh.GridRectToScreenRect(GridRect: TGridRect;
  var ScreenRect: TRect; IncludeLine: Boolean);

  function LinePos(const AxisInfo: TGridAxisDrawInfoEh; Line: Integer): Integer;
  var
    Start, I: Longint;
  begin
    with AxisInfo do
    begin
      Result := 0;
      if Line < FixedCellCount then
        Start := 0
      else if (ContraCelCount > 0) and (Line >= GridCellCount) then
      begin
        Start := GridCellCount;//Line;
        Result := ContraExtent + EffectiveLineWidth;
      end else
      begin
        if Line >= FirstGridCell then
          Result := FixedBoundary - DataOffset;
        Start := FirstGridCell;
      end;
      for I := Start to Line - 1 do
      begin
        Inc(Result, AxisInfo.GetExtent(I) + EffectiveLineWidth);
        if Result > FullGridExtent then
        begin
          Result := 0;
          Exit;
        end;
      end;
    end;
  end;

  function CalcAxis(const AxisInfo: TGridAxisDrawInfoEh;
    GridRectMin, GridRectMax: Integer;
    var ScreenRectMin, ScreenRectMax: Integer): Boolean;
  begin
    Result := False;
    with AxisInfo do
    begin
      if GridRectMin > FullGridCellCount + 1 then
        GridRectMin := FullGridCellCount//GridCellCount
      else if (GridRectMin >= FixedCellCount) and (GridRectMin < FirstGridCell) then
        if GridRectMax < FirstGridCell then
        begin
          ScreenRect := EmptyRect; { erase partial results}
          Exit;
        end
        else
          GridRectMin := FirstGridCell;


      if GridRectMax > LastFullVisibleCell then
      begin
        if (ContraCelCount > 0) and (GridRectMax >= GridCellCount) then
        begin
          if GridRectMax >= FullGridCellCount then
            GridRectMax := FullGridCellCount - 1;
        end else
        begin
          GridRectMax := LastFullVisibleCell;
          if GridRectMax < GridCellCount - 1 then Inc(GridRectMax);
          if LinePos(AxisInfo, GridRectMax) = 0 then
            Dec(GridRectMax);
        end;
      end;

      ScreenRectMin := LinePos(AxisInfo, GridRectMin);
      ScreenRectMax := LinePos(AxisInfo, GridRectMax);
      if ScreenRectMax = 0 then
        ScreenRectMax := ScreenRectMin + AxisInfo.GetExtent(GridRectMin)
      else
        Inc(ScreenRectMax, AxisInfo.GetExtent(GridRectMax));
      if (GridRectMax >= GridCellCount) and (ScreenRectMax > FullGridExtent) then
        ScreenRectMax := FullGridExtent
      else if (GridRectMax < GridCellCount) and (ScreenRectMax > GridExtent) then
        ScreenRectMax := GridExtent;
      if (GridRectMin >= FixedCellCount) and (ScreenRectMin < FixedBoundary) then
        ScreenRectMin := FixedBoundary;
//      if ScreenRectMax > FullGridExtent then
//        ScreenRectMax := GridExtent;
      if IncludeLine then Inc(ScreenRectMax, EffectiveLineWidth);
    end;
    Result := True;
  end;

var
  DrawInfo: TGridDrawInfoEh;
  Hold: Integer;
begin
  ScreenRect := EmptyRect;
  if (GridRect.Left > GridRect.Right) or (GridRect.Top > GridRect.Bottom) then
    Exit;
  CalcDrawInfo(DrawInfo);
  with DrawInfo do
  begin
    if GridRect.Left > Horz.LastFullVisibleCell + 1 then
      if not ((Horz.ContraCelCount > 0) and
              (GridRect.Right >= Horz.GridCellCount){ and
              (GridRect.Right < Horz.FullGridCellCount)})
      then
        Exit;

    if GridRect.Top > Vert.LastFullVisibleCell + 1 then
      if not ((Vert.ContraCelCount > 0) and
        (GridRect.Bottom >= Vert.GridCellCount){ and
        (GridRect.Bottom < Vert.FullGridCellCount)})
      then
        Exit;

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

procedure TCustomGridEh.Initialize;
begin
  FTopLeft.X := FixedCols;
  FTopLeft.Y := FixedRows;
  FCurrent := FTopLeft;
  FAnchor := FCurrent;
  if goRowSelect in Options then
    FAnchor.X := ColCount - 1;
end;

procedure TCustomGridEh.InvalidateCell(ACol, ARow: Longint);
var
  Rect: TGridRect;
begin
  Rect.Top := ARow;
  Rect.Left := ACol;
  Rect.Bottom := ARow;
  Rect.Right := ACol;
  InvalidateRect(Rect);
end;

procedure TCustomGridEh.InvalidateCol(ACol: Longint);
var
  Rect: TGridRect;
begin
  if not HandleAllocated then Exit;
  Rect.Top := 0;
  Rect.Left := ACol;
  Rect.Bottom := TopRow+VisibleRowCount+1;
  Rect.Right := ACol;
  InvalidateRect(Rect);
  if ContraRowCount > 0 then
  begin
    Rect.Top := RowCount;
    Rect.Left := ACol;
    Rect.Bottom := FullRowCount-1;
    Rect.Right := ACol;
    InvalidateRect(Rect);
  end;
end;

procedure TCustomGridEh.InvalidateRow(ARow: Longint);
var
  Rect: TGridRect;
begin
  if not HandleAllocated then Exit;
  Rect.Top := ARow;
  Rect.Left := 0;
  Rect.Bottom := ARow;
  Rect.Right := VisibleColCount+1;
  InvalidateRect(Rect);
  if ContraColCount > 0 then
  begin
    Rect.Top := ARow;
    Rect.Left := ColCount;
    Rect.Bottom := ARow;
    Rect.Right := FullColCount-1;
    InvalidateRect(Rect);
  end;
end;

procedure TCustomGridEh.InvalidateGrid;
begin
  Invalidate;
end;

procedure TCustomGridEh.InvalidateRect(ARect: TGridRect);
var
  InvalidRect: TRect;
begin
  if not HandleAllocated then Exit;
  GridRectToScreenRect(ARect, InvalidRect, True);
  WindowsInvalidateRect(Handle, InvalidRect, False);
end;

procedure TCustomGridEh.ModifyScrollBar(ScrollBar, ScrollCode, Pos: Cardinal;
  UseRightToLeft: Boolean);
var
  NewTopLeft, MaxTopLeft: TGridCoord;
  DrawInfo: TGridDrawInfoEh;
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
    DrawInfo: TGridDrawInfoEh;
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
            Result := Min + LongMulDiv(Pos, Max - Min, MaxShortIntEh)
          else
            Result := Max - LongMulDiv(Pos, Max - Min, MaxShortIntEh);
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
      R := EmptyRect;
      R.Bottom := FixedRows;
      InvalidateRect(R);
      Update;
      UpdateScrollPos;
    end;
  end;

  procedure ModifySmoothHorzScrollBar(Code, Pos: Cardinal);
  var
    NewOffset: Integer;
  begin
    NewOffset := 0;
    case Code of
      SB_LINEUP: NewOffset := -GetHorzScrollStep * RTLFactor;
      SB_LINEDOWN: NewOffset := GetHorzScrollStep * RTLFactor;
      SB_PAGEUP: NewOffset := -FDataPageSize.cx * RTLFactor;
      SB_PAGEDOWN: NewOffset := FDataPageSize.cx * RTLFactor;
      SB_THUMBPOSITION,
      SB_THUMBTRACK:
        if (goThumbTracking in Options) or (Code = SB_THUMBPOSITION) then
        begin
          if not UseRightToLeftAlignment then
            NewOffset := Integer(Pos) - FSmoothPos.X
          else
            NewOffset := FSmoothPos.X - Integer(Pos);
        end;
      SB_BOTTOM: NewOffset := 0;
      SB_TOP: NewOffset := FGridDataSize.cx - FDataPageSize.cx;
    end;
    SafeSmoothScrollData(NewOffset, 0);
  end;

  procedure ModifySmoothVertScrollBar(Code, Pos: Cardinal);
  var
    NewOffset: Integer;
  begin
    NewOffset := 0;
    case Code of
      SB_LINEUP: NewOffset := -GetVertScrollStep * RTLFactor;
      SB_LINEDOWN: NewOffset := GetVertScrollStep * RTLFactor;
      SB_PAGEUP: NewOffset := -FDataPageSize.cy * RTLFactor;
      SB_PAGEDOWN: NewOffset := FDataPageSize.cy * RTLFactor;
      SB_THUMBPOSITION,
      SB_THUMBTRACK:
        if (goThumbTracking in Options) or (Code = SB_THUMBPOSITION) then
        begin
          NewOffset := Integer(Pos) - FSmoothPos.Y
        end;
      SB_BOTTOM: NewOffset := 0;
      SB_TOP: NewOffset := FGridDataSize.cy - FDataPageSize.cy;
    end;
    SafeSmoothScrollData(0, NewOffset);
  end;

var
  Temp: Longint;
begin
  if (not UseRightToLeftAlignment) or (not UseRightToLeft) then
    RTLFactor := 1
  else
    RTLFactor := -1;
  if Visible and CanFocus and TabStop and not (csDesigning in ComponentState) then
    SetFocus;
  CalcDrawInfo(DrawInfo);
  if (ScrollBar = SB_HORZ) then
    if IsSmoothHorzScroll then
    begin
      ModifySmoothHorzScrollBar(ScrollCode, Pos);
      Exit;
    end else if (ColCount = 1) then
    begin
      ModifySmoothHorzScrollBar(ScrollCode, Pos);
      Exit;
    end;
  if (ScrollBar = SB_VERT) then
    if IsSmoothVertScroll then
    begin
      ModifySmoothVertScrollBar(ScrollCode, Pos);
      Exit;
    end;
  MaxTopLeft.X := ColCount - 1;
  MaxTopLeft.Y := RowCount - 1;
  MaxTopLeft := CalcMaxTopLeft(MaxTopLeft, DrawInfo);
  NewTopLeft := FTopLeft;
  if ScrollBar = SB_HORZ then
    repeat
      Temp := NewTopLeft.X;
      NewTopLeft.X := CalcScrollBar(NewTopLeft.X, RTLFactor);
    until (NewTopLeft.X <= FixedCols) or (NewTopLeft.X >= MaxTopLeft.X)
      or (ColWidths[NewTopLeft.X] > 0) or (Temp = NewTopLeft.X)
  else
    repeat
      Temp := NewTopLeft.Y;
      NewTopLeft.Y := CalcScrollBar(NewTopLeft.Y, 1);
    until (NewTopLeft.Y <= FixedRows) or (NewTopLeft.Y >= MaxTopLeft.Y)
      or (RowHeights[NewTopLeft.Y] > 0) or (Temp = NewTopLeft.Y);
  NewTopLeft.X := Math.Max(FixedCols, Math.Min(MaxTopLeft.X, NewTopLeft.X));
  NewTopLeft.Y := Math.Max(FixedRows, Math.Min(MaxTopLeft.Y, NewTopLeft.Y));
  if (NewTopLeft.X <> FTopLeft.X) or (NewTopLeft.Y <> FTopLeft.Y) then
    MoveTopLeft(NewTopLeft.X, NewTopLeft.Y);
end;

procedure TCustomGridEh.MoveAdjust(var CellPos: Longint; FromIndex, ToIndex: Longint);
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

procedure TCustomGridEh.MoveAnchor(const NewAnchor: TGridCoord; Show: Boolean);
var
  OldSel: TGridRect;
begin
  if [goRangeSelect, goEditing] * Options = [goRangeSelect] then
  begin
    OldSel := Selection;
    FAnchor := NewAnchor;
    if goRowSelect in Options then FAnchor.X := ColCount - 1;
    ClampInView(NewAnchor, True, True);
    SelectionMoved(OldSel);
  end
  else MoveCurrent(NewAnchor.X, NewAnchor.Y, True, Show);
end;

procedure TCustomGridEh.MoveCurrent(ACol, ARow: Longint; MoveAnchor,
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
    if goRowSelect in Options then FCurrent.X := LeftCol;
    if Show then ClampInView(FCurrent, not (goRowSelect in Options), True);
    SelectionMoved(OldSel);
    with OldCurrent do InvalidateCell(X, Y);
    with FCurrent do InvalidateCell(ACol, ARow);
  end;
end;

procedure TCustomGridEh.MoveTopLeft(ALeft, ATop: Longint);
var
  OldTopLeft: TGridCoord;
  OldDataOffset: TSize;
begin
  if (ALeft = FTopLeft.X) and (ATop = FTopLeft.Y) then Exit;
  Update;
  OldTopLeft := FTopLeft;
  FTopLeft.X := ALeft;
  FTopLeft.Y := ATop;
  OldDataOffset := FDataOffset;
  if OldTopLeft.X <> ALeft then
    FDataOffset.cx := 0;
  if OldTopLeft.Y <> ATop then
    FDataOffset.cy := 0;
  TopLeftMoved(OldTopLeft, OldDataOffset);
end;

procedure TCustomGridEh.ResizeCol(Index: Longint; OldSize, NewSize: Integer);
var
  DrawInfo: TGridDrawInfoEh;
begin
  InvalidateGrid;
  if IsSmoothHorzScroll then
  begin
    FGridDataSize.cx := FGridDataSize.cx +
      GetChangingGridDataExtendForColWidth(Index, NewSize - OldSize, False);

    if (Index < FixedCols) or (Index >= ColCount) then
    begin
      CalcDrawInfo(DrawInfo);
      FDataPageSize.cx := DrawInfo.Horz.GridExtent - DrawInfo.Horz.FixedBoundary;
      if FDataPageSize.cx < 0 then FDataPageSize.cx := 0;
    end;
  end;
end;

procedure TCustomGridEh.ResizeRow(Index: Longint; OldSize, NewSize: Integer);
var
  DrawInfo: TGridDrawInfoEh;
begin
  InvalidateGrid;
  if IsSmoothVertScroll then
  begin
    FGridDataSize.cy := FGridDataSize.cy +
      GetChangingGridDataExtendForColWidth(Index, NewSize - OldSize, True);

    if (Index < FixedRows) or (Index >= RowCount) then
    begin
      CalcDrawInfo(DrawInfo);
      FDataPageSize.cy := DrawInfo.Vert.GridExtent - DrawInfo.Vert.FixedBoundary;
      if FDataPageSize.cy < 0 then FDataPageSize.cy := 0;
    end;
  end;
end;

procedure TCustomGridEh.SelectionMoved(const OldSel: TGridRect);
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
    WindowsInvalidateRect(Handle, AXorRects[I], False);
end;

function TCustomGridEh.IsSmoothHorzScroll: Boolean;
begin
  Result := goRowSelect in Options;
end;

function TCustomGridEh.IsSmoothVertScroll: Boolean;
begin
  Result := False;
end;

function TCustomGridEh.GetHorzScrollStep: Integer;
begin
  Result := FDataPageSize.cx div 20;
  if Result = 0 then
    Result := 1;
end;

function TCustomGridEh.GetVertScrollStep: Integer;
begin
  Result := FDataPageSize.cy div 20;
  if Result = 0 then
    Result := 1;
end;

procedure TCustomGridEh.UpdateGridDataWidth;
var
  i: Integer;
  DrawInfo: TGridDrawInfoEh;
begin
//  if not IsSmoothHorzScroll then Exit;
  FGridDataSize.cx := 0;
  for i := FixedCols to ColCount-1 do
  begin
    FGridDataSize.cx := FGridDataSize.cx + ColWidths[i] + GridLineWidth;
    if i < LeftCol then
      FSmoothPos.X := FGridDataSize.cx;
  end;
  CalcDrawInfo(DrawInfo);
  FDataPageSize.cx := DrawInfo.Horz.GridExtent - DrawInfo.Horz.FixedBoundary;
  if FDataPageSize.cx < 0 then FDataPageSize.cx := 0;
end;

procedure TCustomGridEh.UpdateGridDataHeight;
var
  i: Integer;
  DrawInfo: TGridDrawInfoEh;
begin
//  if not IsSmoothHorzScroll then Exit;
  FGridDataSize.cy := 0;
  for i := FixedRows to RowCount-1 do
  begin
    FGridDataSize.cy := FGridDataSize.cy + RowHeights[i] + GridLineWidth;
    if i < TopRow then
      FSmoothPos.Y := FGridDataSize.cy;
  end;
  CalcDrawInfo(DrawInfo);
  FDataPageSize.cy := DrawInfo.Vert.GridExtent - DrawInfo.Vert.FixedBoundary;
  if FDataPageSize.cy < 0 then FDataPageSize.cy := 0;
end;

function TCustomGridEh.GetChangingGridDataExtend(Index, Amount: Longint; Rows: Boolean): Int64;
var
  i: Integer;
  FromIndex, ToIndex: Integer;
begin
  Result := 0;
  if Rows then
  begin
    if Amount < 0 then // Deleting, Before delete
    begin
      if Index < FixedRows then
        FromIndex := FixedRows
      else if Index >= RowCount then
        FromIndex := RowCount + Amount
      else
        FromIndex := Index;
      if (Index < RowCount) and (Index + Amount >= RowCount) then
        Dec(FromIndex, Index - Amount - RowCount);
      ToIndex := FromIndex - Amount - 1;
      for i := FromIndex to ToIndex do
        Dec(Result, RowHeights[i] + GridLineWidth);
    end else // Adding, After add.
    begin
      if Index < FixedRows then
        FromIndex := FixedRows
      else if Index >= RowCount-Amount then
        FromIndex := RowCount-Amount
      else
        FromIndex := Index;
      ToIndex := FromIndex + Amount - 1;
      for i := FromIndex to ToIndex do
        Inc(Result, RowHeights[i] + GridLineWidth);
    end;
  end else
  begin
    if Amount < 0 then // Deleting, Before delete
    begin
      if Index < FixedCols then
        FromIndex := FixedCols
      else if Index >= ColCount then
        FromIndex := ColCount + Amount
      else
        FromIndex := Index;
      if (Index < ColCount) and (Index + Amount >= ColCount) then
        Dec(FromIndex, Index - Amount - ColCount);
      ToIndex := FromIndex - Amount - 1;
      for i := FromIndex to ToIndex do
        Dec(Result, ColWidths[i] + GridLineWidth);
    end else // Adding, After add.
    begin
      if Index < FixedCols then
        FromIndex := FixedCols
      else if Index >= ColCount-Amount then
        FromIndex := ColCount-Amount
      else
        FromIndex := Index;
      ToIndex := FromIndex + Amount - 1;
      for i := FromIndex to ToIndex do
        Inc(Result, ColWidths[i] + GridLineWidth);
    end;
  end;
end;

function TCustomGridEh.GetChangingGridDataExtendForFixedData(Amount: Longint; Rows: Boolean): Int64;
var
  i: Integer;
  FromIndex, ToIndex: Integer;
begin
  Result := 0;
  if Rows then
  begin
    if Amount < 0 then // Deleting, Before delete
    begin
      FromIndex := FixedCols - Amount;
      ToIndex := FromIndex + Amount - 1;
      for i := FromIndex to ToIndex do
        Inc(Result, RowHeights[i] + GridLineWidth);
    end else // Adding, After add.
    begin
      FromIndex := FixedRows;
      ToIndex := FromIndex + Amount - 1;
      for i := FromIndex to ToIndex do
        Dec(Result, RowHeights[i] + GridLineWidth);
    end;
  end else
  begin
    if Amount < 0 then // Deleting, Before delete
    begin
      FromIndex := FixedCols - Amount;
      ToIndex := FromIndex + Amount - 1;
      for i := FromIndex to ToIndex do
        Inc(Result, ColWidths[i] + GridLineWidth);
    end else // Adding, After add.
    begin
      FromIndex := FixedCols;
      ToIndex := FromIndex + Amount - 1;
      for i := FromIndex to ToIndex do
        Dec(Result, ColWidths[i] + GridLineWidth);
    end;
  end;
end;

function TCustomGridEh.GetChangingGridDataExtendForContraData(Amount: Longint; Rows: Boolean): Int64;
var
  i: Integer;
  FromIndex, ToIndex: Integer;
begin
  Result := 0;
  if Rows then
  begin
  end else
  begin
    if Amount < 0 then // Deleting, Before delete
    begin
      FromIndex := FullColCount - Amount;
      ToIndex := FromIndex + Amount - 1;
      for i := FromIndex to ToIndex do
        Dec(Result, ColWidths[i] + GridLineWidth);
    end else // Adding, After add.
    begin
      FromIndex := FullColCount;
      ToIndex := FromIndex + Amount - 1;
      for i := FromIndex to ToIndex do
        Inc(Result, ColWidths[i] + GridLineWidth);
    end;
  end;
end;

function TCustomGridEh.GetChangingGridDataExtendForColWidth(ColRowNum, Amount: Longint; Rows: Boolean): Int64;
begin
  Result := 0;
  if Rows then
  begin
    if (ColRowNum >= FixedRows) and (ColRowNum < RowCount) then
      Result := Amount;
  end else
  begin
    if (ColRowNum >= FixedCols) and (ColRowNum < ColCount) then
      Result := Amount;
  end;
end;

(*
procedure TCustomGridEh.SmoothScrollHorzData(DX: Integer);
var
  LeftShift, ColShift, RestShift: Integer;
  DrawInfo: TGridDrawInfoEh;
  i: Integer;
  RestColsWidth: Integer;
  GridDataWidth: Integer;
  RestDataExceeded: Boolean;
  OldTopLeft: TGridCoord;
  OldColDataOffset: Integer;
begin
  OldColDataOffset := FColDataOffset;
  LeftShift := FColDataOffset + DX;
  ColShift := LeftCol;
  RestShift := DX;
  if DX > 0 then
  begin
    CalcDrawInfo(DrawInfo);
    GridDataWidth := DrawInfo.Horz.GridExtent - DrawInfo.Horz.FixedBoundary;

    RestDataExceeded := False;
    RestColsWidth := -FColDataOffset;
    for i := LeftCol to ColCount - 1 do
    begin
      Inc(RestColsWidth, ColWidths[i] + GridLineWidth);
      if RestColsWidth >= GridDataWidth + DX then
      begin
        RestDataExceeded := True;
        Break;
      end;
    end;
    if RestDataExceeded = False then
    begin
      DX := RestColsWidth - GridDataWidth;
      if DX <= 0 then Exit;
      LeftShift := FColDataOffset + DX;
      RestShift := DX;
    end;

    while LeftShift >= ColWidths[ColShift] + GridLineWidth do
    begin
      Dec(LeftShift, ColWidths[ColShift] + GridLineWidth);
      Inc(ColShift);
      RestShift := LeftShift;
    end;

  end else if (LeftCol = FixedCols) and (FColDataOffset < -RestShift) then
  begin
    RestShift := -FColDataOffset;
    LeftShift := 0;
  end else if LeftShift < 0 then
  begin
    Dec(ColShift);
    while True do
    begin
      Inc(LeftShift, ColWidths[ColShift] + GridLineWidth);
      if (LeftShift > 0) or (ColShift <= FixedCols) then
      begin
        if LeftShift < 0 then
        begin
          RestShift := 0;
          LeftShift := 0;
//          FColDataOffset := -FColDataOffset;
        end else
        begin
          FColDataOffset := FColDataOffset - LeftShift;
          RestShift := 0;
        end;
        Break;
      end;
      Dec(ColShift);
    end;
  end;
  LeftCol := ColShift;
  FColDataOffset := LeftShift;
//  ScrollData(-RestShift, 0, 0);
  ScrollData(-RestShift, 0);
  if RestShift <> 0 then
    TopLeftChanged;

  UpdateScrollPos;
end;
*)

procedure TCustomGridEh.SmoothScrollData(DX, DY: Integer);
var
  OldTopLeft: TGridCoord;
  OldColDataOffset: TSize;
{  NewColDataOffset: Integer;}
//  FRowDataOffset: Integer;

  procedure SmoothScrollAxisData(const AxisInfo: TGridAxisDrawInfoEh; DataShift: Integer;
    var StartDrawCell, AxisDataOffset: Integer);
  var
    i: Integer;
    NewDataOffset: Integer;
    BackShift: Integer;
  begin
    NewDataOffset := AxisDataOffset + DataShift;

    if DataShift > 0 then
    begin
      for i := AxisInfo.FirstGridCell to AxisInfo.GridCellCount - 1 do
      begin
        if NewDataOffset > AxisInfo.GetExtent(i) + AxisInfo.EffectiveLineWidth then
        begin
          Inc(StartDrawCell);
          Dec(NewDataOffset, AxisInfo.GetExtent(i) + AxisInfo.EffectiveLineWidth);
        end else
          Break;
      end;
    end else
    begin
      if NewDataOffset < 0 then
      begin
        BackShift := - NewDataOffset;
        Dec(StartDrawCell);
        for i := StartDrawCell downto AxisInfo.FixedCellCount do
        begin
          if BackShift > AxisInfo.GetExtent(i) + AxisInfo.EffectiveLineWidth then
          begin
            Dec(StartDrawCell);
            Dec(BackShift, AxisInfo.GetExtent(i) + AxisInfo.EffectiveLineWidth);
          end else
          begin
            NewDataOffset := AxisInfo.GetExtent(i) + AxisInfo.EffectiveLineWidth - BackShift;
            Break;
          end;
        end;
      end;
    end;

    AxisDataOffset := NewDataOffset;
  end;

var
  DrawInfo: TGridDrawInfoEh;
begin

  CalcDrawInfo(DrawInfo);
  OldTopLeft := FTopLeft;
  OldColDataOffset := FDataOffset;

{$IFDEF CIL}
// FDataOffset.cx doesn't work
{$ELSE}
  if DX <> 0 then
    SmoothScrollAxisData(DrawInfo.Horz, DX, FTopLeft.X, FDataOffset.cx);
  if DY <> 0 then
    SmoothScrollAxisData(DrawInfo.Vert, DY, FTopLeft.Y, FDataOffset.cy);
{$ENDIF}

  TopLeftMoved(OldTopLeft, OldColDataOffset);
end;


procedure TCustomGridEh.SafeSmoothScrollData(DX, DY: Integer);

  procedure CalcScrollAxisData(const AxisInfo: TGridAxisDrawInfoEh; var DataShift: Integer;
    StartDrawCell, AxisDataOffset: Integer);
  var
    i: Integer;
    RestWidth: Integer;
    BackShift: Integer;
  begin
    if DataShift >= 0 then
    begin
      RestWidth := AxisInfo.FixedBoundary - AxisDataOffset - DataShift;
      for i := AxisInfo.FirstGridCell to AxisInfo.GridCellCount - 1 do
      begin
        Inc(RestWidth, AxisInfo.GetExtent(i) + AxisInfo.EffectiveLineWidth);
        if RestWidth >= AxisInfo.GridExtent then
          Break;
      end;
      if RestWidth < AxisInfo.GridExtent then
        DataShift := DataShift - (AxisInfo.GridExtent - RestWidth);
    end;
    if DataShift < 0 then
    begin
      BackShift := - (AxisDataOffset + DataShift);
      if BackShift > 0 then
      begin
        for i := StartDrawCell-1 downto AxisInfo.FixedCellCount do
        begin
          if BackShift > AxisInfo.GetExtent(i) + AxisInfo.EffectiveLineWidth then
          begin
            Dec(BackShift, AxisInfo.GetExtent(i) + AxisInfo.EffectiveLineWidth);
          end else
          begin
            BackShift := 0;
            Break;
          end;
        end;
      end;
      if BackShift > 0 then
        DataShift := DataShift + BackShift;
    end;
  end;

var
  DrawInfo: TGridDrawInfoEh;
begin
  CalcDrawInfo(DrawInfo);
  if IsSmoothHorzScroll
    then CalcScrollAxisData(DrawInfo.Horz, DX, FTopLeft.X, FDataOffset.cx)
    else DX := 0;
  if IsSmoothVertScroll
    then CalcScrollAxisData(DrawInfo.Vert, DY, FTopLeft.Y, FDataOffset.cy)
    else DY := 0;
  if (DX <> 0) or (DY <> 0) then
    SmoothScrollData(DX, DY);
end;

procedure TCustomGridEh.ScrollDataInfo(DX, DY: Integer;
  var DrawInfo: TGridDrawInfoEh);
var
  ScrollArea: TRect;
  ScrollFlags: LongWord;
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
        ScrollArea := Rect(Horz.FixedBoundary, 0, Horz.GridExtent, Vert.FullGridExtent)
      else
      begin
        ScrollArea := Rect(ClientWidth - Horz.GridExtent, 0, ClientWidth - Horz.FixedBoundary, Vert.FullGridExtent);
        DX := -DX;
      end;
      WindowsScrollWindowEx(Handle, DX, 0, ScrollArea, ScrollArea, 0, ScrollFlags);
    end
    else if DX = 0 then
    begin
      { Scroll both the row titles and data area at the same time }
      ScrollArea := Rect(0, Vert.FixedBoundary, Horz.FullGridExtent, Vert.GridExtent);
      WindowsScrollWindowEx(Handle, 0, DY, ScrollArea, ScrollArea, 0, ScrollFlags);
    end
    else
    begin
      { Scroll titles and data area separately }
      { Column titles }
      ScrollArea := Rect(Horz.FixedBoundary, 0, Horz.GridExtent, Vert.FixedBoundary);
      WindowsScrollWindowEx(Handle, DX, 0, ScrollArea, ScrollArea, 0, ScrollFlags);
      { Row titles }
      ScrollArea := Rect(0, Vert.FixedBoundary, Horz.FixedBoundary, Vert.GridExtent);
      WindowsScrollWindowEx(Handle, 0, DY, ScrollArea, ScrollArea, 0, ScrollFlags);
      { Data area }
      ScrollArea := Rect(Horz.FixedBoundary, Vert.FixedBoundary, Horz.GridExtent,
        Vert.GridExtent);
      WindowsScrollWindowEx(Handle, DX, DY, ScrollArea, ScrollArea, 0, ScrollFlags);
      { Contra Columns }
      ScrollArea := Rect(Horz.FixedBoundary, Vert.GridExtent, Horz.GridExtent, Vert.FullGridExtent);
      WindowsScrollWindowEx(Handle, DX, 0, ScrollArea, ScrollArea, 0, ScrollFlags);
      { Contra Rows }
      ScrollArea := Rect(Horz.GridExtent, Vert.FixedBoundary, Horz.FullGridExtent, Vert.GridExtent);
      WindowsScrollWindowEx(Handle, 0, DY, ScrollArea, ScrollArea, 0, ScrollFlags);
    end;
  end;
  if goRowSelect in Options then
    InvalidateRect(Selection);
end;

procedure TCustomGridEh.ScrollData(DX, DY: Integer);
var
  DrawInfo: TGridDrawInfoEh;
begin
  CalcDrawInfo(DrawInfo);
  ScrollDataInfo(DX, DY, DrawInfo);
end;

procedure TCustomGridEh.TopLeftMoved(const OldTopLeft: TGridCoord; OldDataOffset: TSize);

  function CalcScroll(const AxisInfo: TGridAxisDrawInfoEh;
    OldPos, CurrentPos: Integer; var Amount: Longint; OldOffset, CurOffset: Integer): Boolean;
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
        Amount := -OldOffset;
      end
      else
      begin
        Start := CurrentPos;
        Stop := OldPos;
        Amount := OldOffset;
      end;
      for I := Start to Stop - 1 do
      begin
        Inc(Amount, AxisInfo.GetExtent(I) + EffectiveLineWidth);
        if Amount > (GridBoundary - FixedBoundary) then
        begin
          { Scroll amount too big, redraw the whole thing }
          InvalidateGrid;
          Exit;
        end;
      end;
      if OldPos < CurrentPos then
      begin
        Amount := Amount + CurOffset;
        Amount := -Amount;
      end else
        Amount := Amount - CurOffset;

    end;
    Result := True;
  end;

var
  DrawInfo: TGridDrawInfoEh;
  Delta: TGridCoord;
begin
  UpdateScrollPos;
  CalcDrawInfo(DrawInfo);
  if CalcScroll(DrawInfo.Horz, OldTopLeft.X, FTopLeft.X, Delta.X, OldDataOffset.cx, FDataOffset.cx) and
    CalcScroll(DrawInfo.Vert, OldTopLeft.Y, FTopLeft.Y, Delta.Y, OldDataOffset.cy, FDataOffset.cy)
  then
    ScrollDataInfo(Delta.X, Delta.Y, DrawInfo);
  TopLeftChanged;
end;

procedure TCustomGridEh.SetGridScrollInfo(BarFlag, Min, Max, PageSize, Pos: Integer);
var
  SIOld, SINew: TScrollInfo;
begin
  SIOld.cbSize := SizeOf(SIOld);
  SIOld.fMask := SIF_ALL;
  GetScrollInfo(Self.Handle, BarFlag, SIOld);
  SINew := SIOld;
  SINew.nMin := Min;
  SINew.nPage := PageSize;
  SINew.nMax := Max;
  SINew.nPos := Pos;
  if (SINew.nMin <> SIOld.nMin) or (SINew.nMax <> SIOld.nMax) or
    (SINew.nPage <> SIOld.nPage) or (SINew.nPos <> SIOld.nPos) then
    SetScrollInfo(Self.Handle, BarFlag, SINew, True);
end;

procedure TCustomGridEh.UpdateScrollPos;
var
  DrawInfo: TGridDrawInfoEh;
  MaxTopLeft: TGridCoord;
  GridSpace, ColWidth: Integer;
  i: Integer;

  procedure SetScroll(Code: Word; Value: Integer);
  begin
    if UseRightToLeftAlignment and (Code = SB_HORZ) then
      if ColCount <> 1 then Value := MaxShortIntEh - Value
      else                  Value := (ColWidth - GridSpace) - Value;
    if GetScrollPos(Handle, Code) <> Value then
      SetScrollPos(Handle, Code, Value, True);
  end;

begin
  if (not HandleAllocated) or (ScrollBars = ssNone) then Exit;
  CalcDrawInfo(DrawInfo);
  MaxTopLeft.X := ColCount - 1;
  MaxTopLeft.Y := RowCount - 1;
  MaxTopLeft := CalcMaxTopLeft(MaxTopLeft, DrawInfo);
  if ScrollBars in [ssHorizontal, ssBoth] then
    if IsSmoothHorzScroll then
    begin
      FSmoothPos.X := 0;
      for i := FixedCols to LeftCol-1 do
        Inc(FSmoothPos.X, ColWidths[i] + GridLineWidth);
      Inc(FSmoothPos.X, FDataOffset.cx);
      if UseRightToLeftAlignment then
        FSmoothPos.X := FGridDataSize.cx - FSmoothPos.X - FDataPageSize.cx;
      SetGridScrollInfo(SB_HORZ, 0, FGridDataSize.cx-1, FDataPageSize.cx, FSmoothPos.X);
    end else if ColCount = 1 then
    begin
      ColWidth := ColWidths[DrawInfo.Horz.FirstGridCell];
      GridSpace := ClientWidth - DrawInfo.Horz.FixedBoundary;
      if (FColOffset > 0) and (GridSpace > (ColWidth - FColOffset)) then
        ModifyScrollbar(SB_HORZ, SB_THUMBPOSITION, ColWidth - GridSpace, True)
      else
        SetScroll(SB_HORZ, FColOffset)
    end
    else
      SetScroll(SB_HORZ, LongMulDiv(FTopLeft.X - FixedCols, MaxShortIntEh,
        MaxTopLeft.X - FixedCols));
  if ScrollBars in [ssVertical, ssBoth] then
    if IsSmoothVertScroll then
    begin
      FSmoothPos.Y := 0;
      for i := FixedRows to TopRow-1 do
        Inc(FSmoothPos.Y, RowHeights[i] + GridLineWidth);
      Inc(FSmoothPos.Y, FDataOffset.cy);
      SetGridScrollInfo(SB_VERT, 0, FGridDataSize.cy-1, FDataPageSize.cy, FSmoothPos.Y);
    end else
      SetScroll(SB_VERT, LongMulDiv(FTopLeft.Y - FixedRows, MaxShortIntEh,
        MaxTopLeft.Y - FixedRows));
end;

procedure TCustomGridEh.UpdateScrollRange;
var
  MaxTopLeft, OldTopLeft: TGridCoord;
  DrawInfo: TGridDrawInfoEh;
  OldScrollBars: TScrollStyle;
  Updated: Boolean;

  procedure DoUpdate;
  begin
    if not Updated then
    begin
      Update;
      Updated := True;
    end;
  end;

  function ScrollBarVisible(Code: Word): Boolean;
  var
    Min, Max: Integer;
  begin
    Result := False;
    if (ScrollBars = ssBoth) or
      ((Code = SB_HORZ) and (ScrollBars = ssHorizontal)) or
      ((Code = SB_VERT) and (ScrollBars = ssVertical)) then
    begin
      GetScrollRange(Handle, Code, Min, Max);
      Result := Min <> Max;
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
//      SetScrollRange(Handle, Code, 0, MaxShortIntEh, True)
      SetGridScrollInfo(Code, 0, MaxShortIntEh, 0, 0)
    else
//      SetScrollRange(Handle, Code, 0, 0, True);
      SetGridScrollInfo(Code, 0, 0, 0, 0);
    if Old > Max then
    begin
      DoUpdate;
      Current := Max;
    end;
  end;

  procedure UpdateHorzViewArea;
  var
    MaxSmoothPos: Integer;
    i: Integer;
  begin
    CalcDrawInfoXY(DrawInfo, DrawInfo.Horz.GridExtent, DrawInfo.Vert.GridExtent);
    MaxSmoothPos := 0;
    for i := FixedCols to ColCount-1 do
      Inc(MaxSmoothPos, ColWidths[i] + GridLineWidth);
    Dec(MaxSmoothPos, DrawInfo.Horz.GridExtent-DrawInfo.Horz.FixedBoundary);
    if FSmoothPos.X > MaxSmoothPos then
      SafeSmoothScrollData(MaxSmoothPos - FSmoothPos.X, 0);
    FDataPageSize.cx := DrawInfo.Horz.GridExtent - DrawInfo.Horz.FixedBoundary;
    if FDataPageSize.cx < 0 then FDataPageSize.cx := 0;
    SetGridScrollInfo(SB_HORZ, 0, FGridDataSize.cx-1, FDataPageSize.cx, FSmoothPos.X);
  end;

  procedure UpdateVertViewArea;
  var
    MaxSmoothPos: Integer;
    i: Integer;
  begin
    CalcDrawInfoXY(DrawInfo, DrawInfo.Horz.GridExtent, DrawInfo.Vert.GridExtent);
    MaxSmoothPos := 0;
    for i := FixedRows to RowCount-1 do
      Inc(MaxSmoothPos, RowHeights[i] + GridLineWidth);
    Dec(MaxSmoothPos, DrawInfo.Vert.GridExtent-DrawInfo.Vert.FixedBoundary);
    if FSmoothPos.Y > MaxSmoothPos then
      SafeSmoothScrollData(MaxSmoothPos - FSmoothPos.Y, 0);
    FDataPageSize.cy := DrawInfo.Vert.GridExtent - DrawInfo.Vert.FixedBoundary;
    if FDataPageSize.cy < 0 then FDataPageSize.cy := 0;
    SetGridScrollInfo(SB_VERT, 0, FGridDataSize.cy-1, FDataPageSize.cy, FSmoothPos.Y);
  end;

  procedure SetHorzRange;
  var
    Range: Integer;
  begin
    if OldScrollBars in [ssHorizontal, ssBoth] then
      if IsSmoothHorzScroll then
      begin
        UpdateHorzViewArea;
      end else if ColCount = 1 then
      begin
        Range := ColWidths[0] - ClientWidth;
        if Range < 0 then Range := 0;
        SetScrollRange(Handle, SB_HORZ, 0, Range, True);
      end
      else
        SetAxisRange(MaxTopLeft.X, OldTopLeft.X, FTopLeft.X, SB_HORZ, FixedCols);
  end;

  procedure SetVertRange;
  begin
    if OldScrollBars in [ssVertical, ssBoth] then
      if IsSmoothVertScroll then
        UpdateVertViewArea
      else
        SetAxisRange(MaxTopLeft.Y, OldTopLeft.Y, FTopLeft.Y, SB_VERT, FixedRows);
  end;

begin
  if (ScrollBars = ssNone) or not HandleAllocated or not Showing then Exit;
  with DrawInfo do
  begin
    Horz.GridExtent := ClientWidth;
    Vert.GridExtent := ClientHeight;
    { Ignore scroll bars for initial calculation }
    if ScrollBarVisible(SB_HORZ) then
      Inc(Vert.GridExtent, GetSystemMetrics(SM_CYHSCROLL));
    if ScrollBarVisible(SB_VERT) then
      Inc(Horz.GridExtent, GetSystemMetrics(SM_CXVSCROLL));
  end;
  OldTopLeft := FTopLeft;
  { Temporarily mark us as not having scroll bars to avoid recursion }
  OldScrollBars := FScrollBars;
  FScrollBars := ssNone;
  Updated := False;
  try
    { Update scrollbars }
    SetHorzRange;
    DrawInfo.Vert.GridExtent := ClientHeight;
    SetVertRange;
    if DrawInfo.Horz.GridExtent <> ClientWidth then
    begin
      DrawInfo.Horz.GridExtent := ClientWidth;
      SetHorzRange;
    end;
  finally
    FScrollBars := OldScrollBars;
  end;
  UpdateScrollPos;
  if IsSmoothHorzScroll and (FTopLeft.Y = OldTopLeft.Y) then
    Exit
  else if (FTopLeft.X <> OldTopLeft.X) or (FTopLeft.Y <> OldTopLeft.Y) then
    TopLeftMoved(OldTopLeft, FDataOffset);
end;

function TCustomGridEh.CreateEditor: TInplaceEdit;
begin
  Result := TInplaceEdit.Create(Self);
end;

function TCustomGridEh.EnsureInplaceEditCreated: Boolean;
begin
  Result := True;
  if FInplaceEdit = nil then
  begin
    FInplaceEdit := CreateEditor;
    FInplaceEdit.SetGrid(Self);
    FInplaceEdit.Parent := Self;
    Result := False;
  end
end;

procedure TCustomGridEh.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style or WS_TABSTOP;
    if FScrollBars in [ssVertical, ssBoth] then Style := Style or WS_VSCROLL;
    if FScrollBars in [ssHorizontal, ssBoth] then Style := Style or WS_HSCROLL;
    WindowClass.style := CS_DBLCLKS;
    if FBorderStyle = bsSingle then
      if NewStyleControls and Ctl3D then
      begin
        Style := Style and not WS_BORDER;
        ExStyle := ExStyle or WS_EX_CLIENTEDGE;
      end
      else
        Style := Style or WS_BORDER;
  end;
end;

procedure TCustomGridEh.KeyDown(var Key: Word; Shift: TShiftState);
var
  NewTopLeft, NewCurrent, MaxTopLeft: TGridCoord;
  DrawInfo: TGridDrawInfoEh;
  PageWidth, PageHeight: Integer;
  RTLFactor: Integer;
  NeedsInvalidating: Boolean;

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
  NeedsInvalidating := False;
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
          NeedsInvalidating := UseRightToLeftAlignment;
        end;
      VK_END:
        begin
          NewCurrent.X := ColCount - 1;
          NewCurrent.Y := RowCount - 1;
          NeedsInvalidating := UseRightToLeftAlignment;
        end;
    end
  else
    case Key of
      VK_UP: Dec(NewCurrent.Y);
      VK_DOWN: Inc(NewCurrent.Y);
      VK_LEFT:
        if goRowSelect in Options then
        begin
//          Dec(NewCurrent.Y, RTLFactor) else
          SafeSmoothScrollData(-GetHorzScrollStep, 0);
          Exit;
        end else
            Dec(NewCurrent.X, RTLFactor);
      VK_RIGHT:
        if goRowSelect in Options then
//          Inc(NewCurrent.Y, RTLFactor) else
        begin
          SafeSmoothScrollData(GetHorzScrollStep, 0);
          Exit;
        end else
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
  Restrict(NewCurrent, FixedCols-FrozenColCount, FixedRows-FrozenRowCount, ColCount - 1, RowCount - 1);
  if (NewCurrent.X <> Col) or (NewCurrent.Y <> Row) then
    FocusCell(NewCurrent.X, NewCurrent.Y, not (ssShift in Shift)); 
  if NeedsInvalidating then Invalidate;
end;

procedure TCustomGridEh.KeyPress(var Key: Char);
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

function TCustomGridEh.CanHotTackCell(X, Y: Integer): Boolean;
begin
  Result := False;
end;

procedure TCustomGridEh.UpdateHotTackInfo(X, Y: Integer);
var
  CellHit: TGridCoord;
  DrawInfo: TGridDrawInfoEh;
begin
  if (csDesigning in ComponentState) then
    Exit;
  CalcDrawInfo(DrawInfo);
  CellHit := CalcCoordFromPoint(X, Y, DrawInfo);
  if CanHotTackCell(CellHit.X, CellHit.Y) then
  begin
//        if (FHotTrackCell.X <> -1) or (FHotTrackCell.Y <> -1) then
//          InvalidateCell(FHotTrackCell.X, FHotTrackCell.Y);
    if (CellHit.X <> FHotTrackCell.X) or (CellHit.Y <> FHotTrackCell.Y) then
    begin
      if (FHotTrackCell.X >= 0) and (FHotTrackCell.Y >= 0) then
        InvalidateCell(FHotTrackCell.X, FHotTrackCell.Y);
      FHotTrackCell := CellHit;
      if (FHotTrackCell.X >= 0) and (FHotTrackCell.Y >= 0) then
       InvalidateCell(FHotTrackCell.X, FHotTrackCell.Y);
    end;
  end else
  if (FHotTrackCell.X <> -1) or (FHotTrackCell.Y <> -1) then
  begin
    if (FHotTrackCell.X >= 0) and (FHotTrackCell.Y >= 0) then
      InvalidateCell(FHotTrackCell.X, FHotTrackCell.Y);
    FHotTrackCell.X := -1;
    FHotTrackCell.Y := -1;
  end;
end;

procedure TCustomGridEh.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  CellHit: TGridCoord;
  DrawInfo: TGridDrawInfoEh;
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
      if (FGridState = gsColSizing) and UseRightToLeftAlignment then
        FSizingPos := ClientWidth - FSizingPos;
      DrawSizingLine(DrawInfo);
      Exit;
    end;
    CellHit := CalcCoordFromPoint(X, Y, DrawInfo);
    if (CellHit.X >= FixedCols-FrozenColCount) and (CellHit.Y >= FixedRows-FrozenRowCount) and
       (CellHit.X < ColCount) and (CellHit.Y < RowCount) then
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
          MoveAnchor(CellHit, True)
        else
          MoveCurrent(CellHit.X, CellHit.Y, True, True);
      end;
    end
    else if (goRowMoving in Options) and (CellHit.X >= 0) and (CellHit.X < FixedCols)
        and (CellHit.Y >= FixedRows) and (CellHit.Y < RowCount) then
    begin
      FMoveIndex := CellHit.Y;
      FMovePos := FMoveIndex;
      if BeginRowDrag(FMoveIndex, FMovePos, Point(X,Y)) then
      begin
        FGridState := gsRowMoving;
        Update;
        DrawMove(DrawInfo);
        MoveDrawn := True;
        SetTimer(Handle, 1, 60, nil);
      end;
    end
    else if (goColMoving in Options) and (CellHit.Y >= 0) and (CellHit.Y < FixedRows)
        and (CellHit.X >= FixedCols) and (CellHit.X < ColCount) then
    begin
      FMoveIndex := CellHit.X;
      FMovePos := FMoveIndex;
      if BeginColumnDrag(FMoveIndex, FMovePos, Point(X,Y)) then
      begin
        FGridState := gsColMoving;
        Update;
        DrawMove(DrawInfo);
        MoveDrawn := True;
        SetTimer(Handle, 1, 60, nil);
      end;
    end;
  end;
  try
    inherited MouseDown(Button, Shift, X, Y);
  except
    if MoveDrawn then HideMove;
  end;
end;

procedure TCustomGridEh.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  DrawInfo: TGridDrawInfoEh;
  CellHit: TGridCoord;
  CheckMoveAndScroll: Boolean;
begin
  CalcDrawInfo(DrawInfo);
  case FGridState of
    gsSelecting, gsColMoving, gsRowMoving:
      begin
        CellHit := CalcCoordFromPoint(X, Y, DrawInfo);
        if csDesigning in ComponentState then
          CheckMoveAndScroll := True
        else
          CheckMoveAndScroll :=
            (CellHit.X >= FixedCols-FrozenColCount) and (CellHit.Y >= FixedRows-FrozenRowCount) and
            (CellHit.X <= Min(DrawInfo.Horz.LastFullVisibleCell+1, DrawInfo.Horz.GridCellCount-1)) and
            (CellHit.Y <= Min(DrawInfo.Vert.LastFullVisibleCell+1, DrawInfo.Vert.GridCellCount-1));
        if CheckMoveAndScroll then
        begin
          case FGridState of
            gsSelecting:
              if ((CellHit.X <> FAnchor.X) or (CellHit.Y <> FAnchor.Y)) then
                MoveAnchor(CellHit, True);
            gsColMoving:
              MoveAndScroll(X, CellHit.X, DrawInfo, DrawInfo.Horz, SB_HORZ, Point(X,Y));
            gsRowMoving:
              MoveAndScroll(Y, CellHit.Y, DrawInfo, DrawInfo.Vert, SB_VERT, Point(X,Y));
          end;
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
    else
    begin
      UpdateHotTackInfo(X, Y);
    end;
  end;
  inherited MouseMove(Shift, X, Y);
end;

procedure TCustomGridEh.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  DrawInfo: TGridDrawInfoEh;
  NewSize: Integer;
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
          if (FGridState = gsColSizing) and UseRightToLeftAlignment then
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
//          DrawMove;
          HideMove;
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
          DrawMove(DrawInfo);
//          HideMove;
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

procedure TCustomGridEh.CellMouseClick(Cell: TGridCoord; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(FOnCellMouseClick)
    then FOnCellMouseClick(Self, Cell, Button, Shift, X, Y)
    else DefaultCellMouseClick(Cell, Button, Shift, X, Y);
end;

procedure TCustomGridEh.DefaultCellMouseClick(Cell: TGridCoord;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
end;

function TCustomGridEh.CheckCellMouseClick(var Message: TWMLButtonUp): Boolean;
begin
  Result := (FGridState = gsNormal) and (Message.XPos >= 0) and (Message.YPos >= 0);
end;

procedure TCustomGridEh.MoveAndScroll(Mouse, CellHit: Integer;
  var DrawInfo: TGridDrawInfoEh; var Axis: TGridAxisDrawInfoEh;
  ScrollBar: Integer; const MousePt: TPoint);
begin
  if UseRightToLeftAlignment and (ScrollBar = SB_HORZ) then
    Mouse := ClientWidth - Mouse;
  if (CellHit <> FMovePos) and
    not((Axis.DataOffset = 0) and
        (FMovePos = Axis.FixedCellCount) and (Mouse < Axis.FixedBoundary))
    and
    not(
        (FMovePos = Axis.GridCellCount-1) and (Mouse > Axis.GridBoundary)) then
  begin
    DrawMove(DrawInfo);   // hide the drag line
    if (Mouse < Axis.FixedBoundary) then
    begin
      if (FMovePos > Axis.FixedCellCount) or (Axis.DataOffset > 0) then
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
    else if CellHit < 0 then
      CellHit := FMovePos;
    if ((FGridState = gsColMoving) and CheckColumnDrag(FMoveIndex, CellHit, MousePt))
      or ((FGridState = gsRowMoving) and CheckRowDrag(FMoveIndex, CellHit, MousePt)) then
      FMovePos := CellHit;
    DrawMove(DrawInfo);
  end;
end;

function TCustomGridEh.GetColWidths(Index: Longint): Integer;
begin
  if (Length(FColWidths) = 0) or (Index >= FullColCount) then
    Result := DefaultColWidth
  else
    Result := FColWidths[Index + 1];
end;

function TCustomGridEh.GetRowHeights(Index: Longint): Integer;
begin
  if (Length(FRowHeights) = 0) or (Index >= FullRowCount) then
    Result := DefaultRowHeight
  else
    Result := FRowHeights[Index + 1];
end;

function TCustomGridEh.GetGridWidth: Integer;
var
  DrawInfo: TGridDrawInfoEh;
begin
  CalcDrawInfo(DrawInfo);
  Result := DrawInfo.Horz.GridBoundary;
end;

function TCustomGridEh.GetGridHeight: Integer;
var
  DrawInfo: TGridDrawInfoEh;
begin
  CalcDrawInfo(DrawInfo);
  Result := DrawInfo.Vert.GridBoundary;
end;

function TCustomGridEh.GetSelection: TGridRect;
begin
  Result := GridRect(FCurrent, FAnchor);
end;

function TCustomGridEh.GetTabStops(Index: Longint): Boolean;
begin
  if Length(FTabStops) = 0 then Result := True
  else Result := Boolean(FTabStops[Index + 1]);
end;

function TCustomGridEh.GetVisibleColCount: Integer;
var
  DrawInfo: TGridDrawInfoEh;
begin
  CalcDrawInfo(DrawInfo);
  Result := DrawInfo.Horz.LastFullVisibleCell - LeftCol + 1;
end;

function TCustomGridEh.GetVisibleRowCount: Integer;
var
  DrawInfo: TGridDrawInfoEh;
begin
  CalcDrawInfo(DrawInfo);
  Result := DrawInfo.Vert.LastFullVisibleCell - TopRow + 1;
end;

procedure TCustomGridEh.SetBorderStyle(Value: TBorderStyle);
begin
  if FBorderStyle <> Value then
  begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;

procedure TCustomGridEh.SetCol(Value: Longint);
begin
  if Col <> Value then FocusCell(Value, Row, True);
end;

procedure TCustomGridEh.SetColCount(Value: Longint);
begin
  if FColCount <> Value then
  begin
    if Value < 1 then Value := 1;
    if Value <= FixedCols then FixedCols := Value - 1;
    if ContraColCount = 0 then
      ChangeSize(Value, RowCount)
    else if Value > FColCount then
      AdjustSize(ColCount, Value - FColCount, False)
    else
      AdjustSize(Value, Value - FColCount, False);
    if goRowSelect in Options then
    begin
      FAnchor.X := ColCount - 1;
      Invalidate;
    end;
    UpdateGridDataWidth;
    UpdateScrollRange;
  end;
end;

procedure TCustomGridEh.SetContraColCount(const Value: Longint);
///var
//  OldFullColCount, OldContraColCount: Integer;
begin
  if FContraColCount <> Value then
  begin
    if FContraColCount < 0 then
      InvalidOp('FContraColCount can not be negative.');
//    if FContraColCount >= ColCount - FixedCols then
//      InvalidOp('FContraColCount can not be less or eqal then fixed colums.');
    SetContraSize(Value, FContraRowCount);
    UpdateGridDataWidth;
    UpdateScrollRange;
  end;
end;

procedure TCustomGridEh.SetColWidths(Index: Longint; Value: Integer);
begin
  if Length(FColWidths) = 0 then
    UpdateExtents(FColWidths, FullColCount, DefaultColWidth);
  if Index >= FullColCount then InvalidOp(SIndexOutOfRange);
  if Value <> FColWidths[Index + 1] then
  begin
    ResizeCol(Index, FColWidths[Index + 1], Value);
    FColWidths[Index + 1] := Value;
    ColWidthsChanged;
  end;
end;

procedure TCustomGridEh.SetDefaultColWidth(Value: Integer);
begin
  if Length(FColWidths) <> 0 then
    UpdateExtents(FColWidths, 0, 0);
  FDefaultColWidth := Value;
  ColWidthsChanged;
  InvalidateGrid;
end;

procedure TCustomGridEh.SetDefaultRowHeight(Value: Integer);
begin
  if Length(FRowHeights) <> 0 then UpdateExtents(FRowHeights, 0, 0);
  FDefaultRowHeight := Value;
  RowHeightsChanged;
  InvalidateGrid;
end;

procedure TCustomGridEh.SetFixedColor(Value: TColor);
begin
  if FFixedColor <> Value then
  begin
    FFixedColor := Value;
    InvalidateGrid;
  end;
end;

procedure TCustomGridEh.SetFixedCols(Value: Integer);
begin
  if FFixedCols <> Value then
  begin
    if Value < 0 then InvalidOp(SIndexOutOfRange);
    if Value >= ColCount then InvalidOp(SFixedColTooBig);
    FFixedCols := Value;
    UpdateGridDataWidth;
    UpdateScrollRange;
    Initialize;
    InvalidateGrid;
  end;
end;

procedure TCustomGridEh.SetFixedRows(Value: Integer);
begin
  if FFixedRows <> Value then
  begin
    if Value < 0 then InvalidOp(SIndexOutOfRange);
    if Value >= RowCount then InvalidOp(SFixedRowTooBig);
    FFixedRows := Value;
    UpdateGridDataHeight;
    UpdateScrollRange;
    Initialize;
    InvalidateGrid;
  end;
end;

procedure TCustomGridEh.SetEditorMode(Value: Boolean);
begin
  if not Value then
    HideEditor
  else
  begin
    ShowEditor;
    if FInplaceEdit <> nil then FInplaceEdit.Deselect;
  end;
end;

procedure TCustomGridEh.SetGridLineWidth(Value: Integer);
begin
  if FGridLineWidth <> Value then
  begin
    FGridLineWidth := Value;
    InvalidateGrid;
  end;
end;

procedure TCustomGridEh.SetLeftCol(Value: Longint);
begin
  if FTopLeft.X <> Value then MoveTopLeft(Value, TopRow);
end;

procedure TCustomGridEh.SetOptions(Value: TGridOptions);
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
    if goRowSelect in Value then
    begin
      MoveCurrent(Col, Row,  True, False);
      UpdateGridDataWidth;
      UpdateGridDataHeight;
    end;
    UpdateScrollRange;
    InvalidateGrid;
  end;
end;

procedure TCustomGridEh.SetRow(Value: Longint);
begin
  if Row <> Value then FocusCell(Col, Value, True);
end;

procedure TCustomGridEh.SetRowCount(Value: Longint);
begin
  if FRowCount <> Value then
  begin
    if Value < 1 then Value := 1;
    if Value <= FixedRows then FixedRows := Value - 1;

    if ContraRowCount = 0 then
      ChangeSize(ColCount, Value)
    else if Value > FRowCount then
      AdjustSize(RowCount, Value - FRowCount, True)
    else
      AdjustSize(Value, Value - FRowCount, True);
    UpdateGridDataHeight;
    UpdateScrollRange;
  end;
end;

procedure TCustomGridEh.SetContraRowCount(const Value: Longint);
begin
  if FContraRowCount <> Value then
  begin
    if FContraRowCount < 0 then
      InvalidOp('FContraRowCount can not be negative.');

//    FContraRowCount := Value;
    SetContraSize(FContraColCount, Value);
    UpdateGridDataHeight;
    UpdateScrollRange;
  end;
end;

function TCustomGridEh.GetFullColCount: Longint;
begin
  Result := ColCount + ContraColCount;
end;

function TCustomGridEh.GetFullRowCount: Longint;
begin
  Result := RowCount + ContraRowCount;
end;

procedure TCustomGridEh.SetRowHeights(Index: Longint; Value: Integer);
begin
  if Length(FRowHeights) = 0 then
    UpdateExtents(FRowHeights, FullRowCount, DefaultRowHeight);
  if Index >= FullRowCount then InvalidOp(SIndexOutOfRange);
  if Value <> FRowHeights[Index + 1] then
  begin
    ResizeRow(Index, FRowHeights[Index + 1], Value);
    FRowHeights[Index + 1] := Value;
    RowHeightsChanged;
  end;
end;

procedure TCustomGridEh.SetScrollBars(Value: TScrollStyle);
begin
  if FScrollBars <> Value then
  begin
    FScrollBars := Value;
    RecreateWnd;
  end;
end;

procedure TCustomGridEh.SetSelection(Value: TGridRect);
var
  OldSel: TGridRect;
begin
  OldSel := Selection;
  FAnchor.X := Value.Left;
  FAnchor.Y := Value.Top;
  FCurrent.X := Value.Right;
  FCurrent.Y := Value.Bottom;
  SelectionMoved(OldSel);
end;

procedure TCustomGridEh.SetTabStops(Index: Longint; Value: Boolean);
begin
  if Length(FTabStops) = 0 then
    UpdateExtents(FTabStops, FullColCount, Integer(True));
  if Index >= FullColCount then InvalidOp(SIndexOutOfRange);
  FTabStops[Index + 1] := Integer(Value);
end;

procedure TCustomGridEh.SetTopRow(Value: Longint);
begin
  if FTopLeft.Y <> Value then MoveTopLeft(LeftCol, Value);
end;

procedure TCustomGridEh.HideEdit;
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

procedure TCustomGridEh.UpdateEdit;

  procedure UpdateEditor;
  begin
    FInplaceCol := Col;
    FInplaceRow := Row;
    FInplaceEdit.UpdateContents;
    if FInplaceEdit.MaxLength = -1
      then FCanEditModify := False
      else FCanEditModify := True;
    FInplaceEdit.SelectAll;
  end;

begin
  if CanEditShow then
  begin
    if EnsureInplaceEditCreated then
      UpdateEditor
    else
    begin
      if (Col <> FInplaceCol) or (Row <> FInplaceRow) then
      begin
        HideEdit;
        UpdateEditor;
      end;
    end;
    if CanEditShow then FInplaceEdit.Move(CellEditRect(Col, Row));
  end;
end;

procedure TCustomGridEh.UpdateText;
begin
  if (FInplaceCol <> -1) and (FInplaceRow <> -1) then
    SetEditText(FInplaceCol, FInplaceRow, FInplaceEdit.Text);
end;

procedure TCustomGridEh.WMChar(var Msg: TWMChar);
begin
  if (goEditing in Options) and (CharInSetEh(Char(Msg.CharCode), [^H]) or
     (Char(Msg.CharCode) >= #32)) then
    ShowEditorChar(Char(Msg.CharCode))
  else
    inherited;
end;

procedure TCustomGridEh.WMCommand(var Message: TWMCommand);
begin
  with Message do
  begin
    if (FInplaceEdit <> nil) and (Ctl = FInplaceEdit.Handle) then
      case NotifyCode of
        EN_CHANGE: UpdateText;
      end;
  end;
end;

procedure TCustomGridEh.WMGetDlgCode(var Msg: TWMGetDlgCode);
begin
  Msg.Result := DLGC_WANTARROWS;
  if goRowSelect in Options then Exit;
  if goTabs in Options then Msg.Result := Msg.Result or DLGC_WANTTAB;
  if goEditing in Options then Msg.Result := Msg.Result or DLGC_WANTCHARS;
end;

procedure TCustomGridEh.WMKillFocus(var Msg: TWMKillFocus);
begin
  inherited;
  InvalidateRect(Selection);
  if (FInplaceEdit <> nil) and (Msg.FocusedWnd <> FInplaceEdit.Handle) then
    HideEdit;
end;

procedure TCustomGridEh.WMLButtonDown(var Message: TWMLButtonDown);
var
  DrawInfo: TGridDrawInfoEh;
begin
  inherited;
  if FInplaceEdit <> nil then FInplaceEdit.FClickTime := GetMessageTime;
  CalcDrawInfo(DrawInfo);
  FMouseDownCell := CalcCoordFromPoint(Message.XPos, Message.YPos, DrawInfo);
  if (FMouseDownCell.X < 0) and (FMouseDownCell.Y < 0) then
    FMouseDownCell := MouseCoord(-1, -1);
end;

procedure TCustomGridEh.WMRButtonDown(var Message: TWMRButtonDown);
var
  DrawInfo: TGridDrawInfoEh;
begin
  inherited;
  if FInplaceEdit <> nil then FInplaceEdit.FClickTime := GetMessageTime;
  CalcDrawInfo(DrawInfo);
  FMouseDownCell := CalcCoordFromPoint(Message.XPos, Message.YPos, DrawInfo);
  if (FMouseDownCell.X < 0) and (FMouseDownCell.Y < 0) then
    FMouseDownCell := MouseCoord(-1, -1);
end;

procedure TCustomGridEh.WMMButtonDown(var Message: TWMMButtonDown);
var
  DrawInfo: TGridDrawInfoEh;
begin
  inherited;
  if FInplaceEdit <> nil then FInplaceEdit.FClickTime := GetMessageTime;
  CalcDrawInfo(DrawInfo);
  FMouseDownCell := CalcCoordFromPoint(Message.XPos, Message.YPos, DrawInfo);
  if (FMouseDownCell.X < 0) and (FMouseDownCell.Y < 0) then
    FMouseDownCell := MouseCoord(-1, -1);
end;

procedure TCustomGridEh.WMLButtonUp(var Message: TWMLButtonUp);
var
  DrawInfo: TGridDrawInfoEh;
  CellHit: TGridCoord;
  ARect: TRect;
  CheckCellMouse: Boolean;
begin
  CheckCellMouse := CheckCellMouseClick(Message);
  inherited;
  if CheckCellMouse then
  begin
    CalcDrawInfo(DrawInfo);
    CellHit := CalcCoordFromPoint(Message.XPos, Message.YPos, DrawInfo);
    if (FMouseDownCell.X >= 0) and (FMouseDownCell.Y >= 0) and
      (FMouseDownCell.X = CellHit.X) and (FMouseDownCell.Y = CellHit.Y) then
    begin
      ARect := CellRect(CellHit.X, CellHit.Y);
      CellMouseClick(CellHit, mbLeft, KeysToShiftState(Message.Keys),
        Message.XPos - ARect.Left, Message.YPos - ARect.Top);
    end;
  end;
end;

procedure TCustomGridEh.WMRButtonUp(var Message: TWMRButtonUp);
var
  DrawInfo: TGridDrawInfoEh;
  CellHit: TGridCoord;
  ARect: TRect;
  CheckCellMouse: Boolean;
begin
  CheckCellMouse := CheckCellMouseClick(Message);
  inherited;
  if CheckCellMouse then
  begin
    CalcDrawInfo(DrawInfo);
    CellHit := CalcCoordFromPoint(Message.XPos, Message.YPos, DrawInfo);
    if (FMouseDownCell.X >= 0) and (FMouseDownCell.Y >= 0) and
      (FMouseDownCell.X = CellHit.X) and (FMouseDownCell.Y = CellHit.Y) then
    begin
      ARect := CellRect(CellHit.X, CellHit.Y);
      CellMouseClick(CellHit, mbRight, KeysToShiftState(Message.Keys),
        Message.XPos - ARect.Left, Message.YPos - ARect.Top);
    end;
  end;
end;

procedure TCustomGridEh.WMMButtonUp(var Message: TWMMButtonUp);
var
  DrawInfo: TGridDrawInfoEh;
  CellHit: TGridCoord;
  ARect: TRect;
  CheckCellMouse: Boolean;
begin
  CheckCellMouse := CheckCellMouseClick(Message);
  inherited;
  if CheckCellMouse then
  begin
    CalcDrawInfo(DrawInfo);
    CellHit := CalcCoordFromPoint(Message.XPos, Message.YPos, DrawInfo);
    if (FMouseDownCell.X >= 0) and (FMouseDownCell.Y >= 0) and
      (FMouseDownCell.X = CellHit.X) and (FMouseDownCell.Y = CellHit.Y) then
    begin
      ARect := CellRect(CellHit.X, CellHit.Y);
      CellMouseClick(CellHit, mbMiddle, KeysToShiftState(Message.Keys),
        Message.XPos - ARect.Left, Message.YPos - ARect.Top);
    end;
  end;
end;

procedure TCustomGridEh.WMNCHitTest(var Msg: TWMNCHitTest);
begin
  DefaultHandler(Msg);
  FHitTest := ScreenToClient(SmallPointToPoint(Msg.Pos));
end;

procedure TCustomGridEh.WMSetCursor(var Msg: TWMSetCursor);
var
  DrawInfo: TGridDrawInfoEh;
  State: TGridState;
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
      end else
        State := FGridState;
      if State = gsRowSizing then
        Cur := Screen.Cursors[crVSplit]
      else if State = gsColSizing then
        Cur := Screen.Cursors[crHSplit]
    end;
  end;
  if Cur <> 0 then SetCursor(Cur)
  else inherited;
end;

procedure TCustomGridEh.WMSetFocus(var Msg: TWMSetFocus);
begin
  inherited;
  if (FInplaceEdit = nil) or (Msg.FocusedWnd <> FInplaceEdit.Handle) then
  begin
    InvalidateRect(Selection);
    UpdateEdit;
  end;
end;

procedure TCustomGridEh.WMSize(var Msg: TWMSize);
begin
  inherited;
  UpdateScrollRange;
  if UseRightToLeftAlignment then Invalidate
  else if (ContraRowCount > 0) or (ContraColCount > 0) then
    Invalidate;
end;

procedure TCustomGridEh.WMVScroll(var Msg: TWMVScroll);
var
  SI: TScrollInfo;
  Pos: Integer;
begin
  Pos := Msg.Pos;
  if Msg.ScrollCode = SB_THUMBPOSITION then
  begin
    SI.cbSize := sizeof(SI);
    SI.fMask := SIF_ALL;
    GetScrollInfo(Self.Handle, SB_VERT, SI);
    Pos := SI.nTrackPos;
  end;
  ModifyScrollBar(SB_VERT, Msg.ScrollCode, Pos, True);
end;

procedure TCustomGridEh.WMHScroll(var Msg: TWMHScroll);
begin
  ModifyScrollBar(SB_HORZ, Msg.ScrollCode, Msg.Pos, True);
end;

procedure TCustomGridEh.CancelMode;
var
  DrawInfo: TGridDrawInfoEh;
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
//          DrawMove;
          HideMove;
          KillTimer(Handle, 1);
        end;
    end;
  finally
    FGridState := gsNormal;
  end;
end;

procedure TCustomGridEh.WMCancelMode(var Msg: TWMCancelMode);
begin
  inherited;
  CancelMode;
end;

procedure TCustomGridEh.CMCancelMode(var Msg: TCMCancelMode);
{$IFDEF CIL}
var
  OrigMsg: TMessage;
{$ENDIF}
begin
  if Assigned(FInplaceEdit) then
{$IFDEF CIL}
  begin
    OrigMsg := Msg.OriginalMessage;
    FInplaceEdit.WndProc(OrigMsg);
  end;
{$ELSE}
    FInplaceEdit.WndProc(TMessage(Msg));
{$ENDIF}
  inherited;
  CancelMode;
end;

procedure TCustomGridEh.CMFontChanged(var Message: TMessage);
begin
  if FInplaceEdit <> nil then FInplaceEdit.Font := Font;
  inherited;
end;

procedure TCustomGridEh.CMCtl3DChanged(var Message: TMessage);
begin
  inherited;
  RecreateWnd;
end;

procedure TCustomGridEh.CMDesignHitTest(var Msg: TCMDesignHitTest);
begin
  Msg.Result := Longint(BOOL(Sizing(Msg.Pos.X, Msg.Pos.Y)));
end;

procedure TCustomGridEh.CMWantSpecialKey(var Msg: TCMWantSpecialKey);
begin
  inherited;
  if (goEditing in Options) and (Char(Msg.CharCode) = #13) then Msg.Result := 1;
end;

procedure TCustomGridEh.TimedScroll(Direction: TGridScrollDirection);
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
    MoveAnchor(NewAnchor, True);
end;

procedure TCustomGridEh.WMTimer(var Msg: TWMTimer);
var
  APoint: TPoint;
  DrawInfo: TGridDrawInfoEh;
  ScrollDirection: TGridScrollDirection;
  CellHit: TGridCoord;
  LeftSide: Integer;
  RightSide: Integer;
  OldLeftCol, OldHorzSmoothPos: Integer;

  procedure ResetScrollTimer(Mouse, CellHit: Integer;
    var DrawInfo: TGridDrawInfoEh; var Axis: TGridAxisDrawInfoEh;
    ScrollBar: Integer; const MousePt: TPoint);
  var
    Distance, MaxSize, Delay: Integer;
    ScreenPt, ScreenBrd: TPoint;
  begin
    if FMovePos >= Axis.FixedCellCount then
    begin
      if Mouse < Axis.FixedBoundary then
      begin
        ScreenPt := ClientToScreen(MousePt);
        ScreenBrd := ClientToScreen(Point(Axis.FixedBoundary, MousePt.Y));
        MaxSize := ScreenBrd.X;
        if MaxSize > 200 then
          MaxSize := 200;
        Distance := ScreenBrd.X - ScreenPt.X;
        if Distance > MaxSize then
          Distance := MaxSize;
        if (Distance <= 10)
          then Distance := 1
          else Distance := Distance - 10;
        Delay := 60 + Trunc( MaxSize / Distance * 1.5);
        SetTimer(Handle, 1, Delay, nil);
        Exit;
      end else if (Mouse < Axis.GridExtent) and
         ( (OldLeftCol < LeftCol) or (OldHorzSmoothPos < FSmoothPos.X) ) then
      begin
        Delay := 60 + Trunc(200 * 1.5);
        SetTimer(Handle, 1, Delay, nil);
        Exit;
      end else if Mouse > Axis.GridExtent then
      begin
        ScreenPt := ClientToScreen(MousePt);
        ScreenBrd := ClientToScreen(Point(Axis.GridExtent, MousePt.Y));
        MaxSize := Screen.DesktopWidth - ScreenBrd.X;
        if MaxSize > 200 then
          MaxSize := 200;
        Distance := ScreenPt.X - ScreenBrd.X;
        if Distance > MaxSize then
          Distance := MaxSize;
        if (Distance <= 10)
          then Distance := 1
          else Distance := Distance - 10;
        Delay := 60 + Trunc( MaxSize / Distance * 1.5);
        SetTimer(Handle, 1, Delay, nil);
        Exit;
      end
    end;
    SetTimer(Handle, 1, 60, nil);
  end;

begin
  if not (FGridState in [gsSelecting, gsRowMoving, gsColMoving]) then Exit;
  GetCursorPos(APoint);
  APoint := ScreenToClient(APoint);
  CalcDrawInfo(DrawInfo);
  ScrollDirection := [];
  with DrawInfo do
  begin
    CellHit := CalcCoordFromPoint(APoint.X, APoint.Y, DrawInfo);
    case FGridState of
      gsColMoving:
        begin
          OldLeftCol := LeftCol;
          OldHorzSmoothPos := FSmoothPos.X;
          MoveAndScroll(APoint.X, CellHit.X, DrawInfo, Horz, SB_HORZ, APoint);
          ResetScrollTimer(APoint.X, CellHit.X, DrawInfo, Horz, SB_HORZ, APoint);
        end;
      gsRowMoving:
        MoveAndScroll(APoint.Y, CellHit.Y, DrawInfo, Vert, SB_VERT, APoint);
      gsSelecting:
      begin
        if not UseRightToLeftAlignment then
        begin
          if APoint.X < Horz.FixedBoundary then Include(ScrollDirection, sdLeft)
          else if APoint.X > Horz.FullVisBoundary then Include(ScrollDirection, sdRight);
        end
        else
        begin
          LeftSide := ClientWidth - Horz.FullVisBoundary;
          RightSide := ClientWidth - Horz.FixedBoundary;
          if APoint.X < LeftSide then Include(ScrollDirection, sdRight)
          else if APoint.X > RightSide then Include(ScrollDirection, sdLeft);
        end;
        if APoint.Y < Vert.FixedBoundary then Include(ScrollDirection, sdUp)
        else if APoint.Y > Vert.FullVisBoundary then Include(ScrollDirection, sdDown);
        if ScrollDirection <> [] then  TimedScroll(ScrollDirection);
      end;
    end;
  end;
end;

procedure TCustomGridEh.ColWidthsChanged;
begin
//  UpdateGridDataWidth;
  UpdateScrollRange;
  UpdateEdit;
end;

procedure TCustomGridEh.RowHeightsChanged;
begin
  UpdateScrollRange;
  UpdateEdit;
end;

procedure TCustomGridEh.DeleteColumn(ACol: Longint);
begin
  MoveColumn(ACol, FullColCount-1);
  ColCount := ColCount - 1;
end;

procedure TCustomGridEh.DeleteRow(ARow: Longint);
begin
  LockPaint;
  try
    if Row = ARow then
      Row := Row - 1;
    MoveRow(ARow, FullRowCount - 1);
    RowCount := RowCount - 1;
  finally
    UnlockPaint;
  end;
end;

procedure TCustomGridEh.UpdateDesigner;
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

function TCustomGridEh.DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  Result := inherited DoMouseWheelDown(Shift, MousePos);
  if not Result then
  begin
    if IsSmoothVertScroll then
      SafeSmoothScrollData(0, GetVertScrollStep)
    else if Row < RowCount - 1 then
      Row := Row + 1;
    Result := True;
  end;
end;

function TCustomGridEh.DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  Result := inherited DoMouseWheelUp(Shift, MousePos);
  if not Result then
  begin
    if IsSmoothVertScroll then
      SafeSmoothScrollData(0, -GetVertScrollStep)
    else if Row > FixedRows then
      Row := Row - 1;
    Result := True;
  end;
end;

function TCustomGridEh.CheckColumnDrag(var Origin,
  Destination: Integer; const MousePt: TPoint): Boolean;
begin
  Result := True;
end;

function TCustomGridEh.CheckRowDrag(var Origin,
  Destination: Integer; const MousePt: TPoint): Boolean;
begin
  Result := True;
end;

function TCustomGridEh.BeginColumnDrag(var Origin, Destination: Integer; const MousePt: TPoint): Boolean;
begin
  Result := True;
end;

function TCustomGridEh.BeginRowDrag(var Origin, Destination: Integer; const MousePt: TPoint): Boolean;
begin
  Result := True;
end;

function TCustomGridEh.EndColumnDrag(var Origin, Destination: Integer; const MousePt: TPoint): Boolean;
begin
  Result := True;
end;

function TCustomGridEh.EndRowDrag(var Origin, Destination: Integer; const MousePt: TPoint): Boolean;
begin
  Result := True;
end;

procedure TCustomGridEh.CMShowingChanged(var Message: TMessage);
begin
  inherited;
  if Showing then UpdateScrollRange;
end;

procedure TCustomGridEh.SetFlat(const Value: Boolean);
begin
  if FFlat <> Value then
  begin
    FFlat := Value;
    UpdateFixedLineColor;
    FlatChanged;
    Invalidate;
  end;
end;

procedure TCustomGridEh.UpdateFixedLineColor;
begin
  if Flat
    then FFixedLineColor := clGray
    else FFixedLineColor := clBlack;
end;

procedure TCustomGridEh.SetFrozenColCount(const Value: Longint);
begin
  FFrozenColCount := Value;
  Invalidate;
end;

procedure TCustomGridEh.SetFrozenRowCount(const Value: Longint);
begin
  FFrozenRowCount := Value;
  Invalidate;
end;

function TCustomGridEh.CreateGridLineColors: TGridLineColorsEh;
begin
  Result := TGridLineColorsEh.Create(Self);
end;

procedure TCustomGridEh.DrawEdgeEh(ACanvas: TCanvas; qrc: TRect;
  IsDown, IsSelected: Boolean; NeedLeft, NeedRight: Boolean);

  procedure Swap(var a, b: Integer);
  var c: Integer;
  begin
    c := a;
    a := b;
    b := c;
  end;

var
  ThreeDLine: Integer;
  TopLeftFlag, BottomRightFlag: Integer;
begin
  TopLeftFlag := BF_TOPLEFT;
  BottomRightFlag := BF_BOTTOMRIGHT;
  if UseRightToLeftAlignment then
  begin
    WindowsLPtoDP(Canvas.Handle, qrc);
    Swap(qrc.Left, qrc.Right);
    ChangeGridOrientation(False);
    TopLeftFlag := BF_TOPRIGHT;
    BottomRightFlag := BF_BOTTOMLEFT;
  end;

  if Flat then
  begin
    if IsSelected or IsDown
      then ThreeDLine := BDR_SUNKENINNER
      else ThreeDLine := BDR_RAISEDINNER;

    Canvas.Pen.Color := Canvas.Brush.Color;
    if UseRightToLeftAlignment then
    begin
      Canvas.Polyline([Point(qrc.Left, qrc.Bottom - 1), Point(qrc.Right, qrc.Bottom - 1)]);
      if NeedRight then
        DrawEdge(Canvas.Handle, qrc, ThreeDLine, BF_LEFT);
      DrawEdge(Canvas.Handle, qrc, ThreeDLine, BF_TOP);
      if NeedLeft
        then Canvas.Polyline([Point(qrc.Right - 1, qrc.Bottom - 1), Point(qrc.Right - 1, qrc.Top - 1)]);
    end else
    begin
      if NeedRight
        then Canvas.Polyline([Point(qrc.Left, qrc.Bottom - 1), Point(qrc.Right - 1, qrc.Bottom - 1), Point(qrc.Right - 1, qrc.Top - 1)])
        else Canvas.Polyline([Point(qrc.Left, qrc.Bottom - 1), Point(qrc.Right, qrc.Bottom - 1)]);
      if NeedLeft
        then DrawEdge(Canvas.Handle, qrc, ThreeDLine, TopLeftFlag)
        else DrawEdge(Canvas.Handle, qrc, ThreeDLine, BF_TOP);
    end;
  end else
  begin
    if IsSelected or IsDown
      then ThreeDLine := BDR_SUNKENINNER
      else ThreeDLine := BDR_RAISEDINNER;
    if NeedLeft and NeedRight then
      DrawEdge(Canvas.Handle, qrc, ThreeDLine, BF_RECT)
    else
    begin
      if NeedLeft
        then DrawEdge(Canvas.Handle, qrc, ThreeDLine, TopLeftFlag)
        else DrawEdge(Canvas.Handle, qrc, ThreeDLine, BF_TOP);
      if NeedRight
        then DrawEdge(Canvas.Handle, qrc, ThreeDLine, BottomRightFlag)
        else DrawEdge(Canvas.Handle, qrc, ThreeDLine, BF_BOTTOM);
    end;
  end;
  if UseRightToLeftAlignment then ChangeGridOrientation(True);
end;

procedure TCustomGridEh.FlatChanged;
begin

end;

function TCustomGridEh.ResizeLine(const AxisInfo: TGridAxisDrawInfoEh): Integer;
var
  I: Integer;
begin
  with AxisInfo do
  begin
    if FSizingIndex >= GridCellCount then
    begin
      Result := ContraExtent - EffectiveLineWidth;
      for I := GridCellCount to FSizingIndex do
        Inc(Result, AxisInfo.GetExtent(I) + EffectiveLineWidth);
      Result := Result - FSizingPos;
    end else
    begin
      if FSizingIndex < FixedCellCount then
      begin
        Result := NoFrozenBoundary;
        for I := FixedCellCount - FrozenCelCount to FSizingIndex - 1 do
          Inc(Result, AxisInfo.GetExtent(I) + EffectiveLineWidth);
      end else
      begin
        Result := FixedBoundary - DataOffset;
        for I := FirstGridCell to FSizingIndex - 1 do
          Inc(Result, AxisInfo.GetExtent(I) + EffectiveLineWidth);
      end;
      Result := FSizingPos - Result;
    end;
  end;
end;

procedure TCustomGridEh.DrawPolyPolyline(PointsList: TPointArray;
  StrokeList: TDWORDArray; VCount: Integer);
var
  i: Integer;
begin
  if UseRightToLeftAlignment then
  begin
    for i := 0 to VCount-1 do
    begin
      PointsList[i].X := PointsList[i].X + 1;
    end;
  end;
{$IFDEF CIL}
  PolyPolyLine(Canvas.Handle, PointsList, StrokeList, VCount shr 1);
{$ELSE}
  PolyPolyLine(Canvas.Handle, Pointer(PointsList)^, Pointer(StrokeList)^, VCount shr 1);
{$ENDIF}
end;

procedure TCustomGridEh.DrawPolyline(Points: array of TPoint);
var
  i: Integer;
begin
  if UseRightToLeftAlignment then
  begin
    for i := 0 to Length(Points)-1 do
    begin
      Points[i].X := Points[i].X + 1;
    end;
  end;
  Canvas.Polyline(Points);
end;

procedure TCustomGridEh.LockPaint;
begin
  Inc(FLockPaint);
end;

procedure TCustomGridEh.UnlockPaint;
begin
  if FLockPaint > 0 then
    Dec(FLockPaint);
end;

function TCustomGridEh.PaintLocked: Boolean;
begin
  Result := (FLockPaint > 0);
end;

{ TCustomDrawGridEh }

function TCustomDrawGridEh.CellRect(ACol, ARow: Longint): TRect;
begin
  Result := inherited CellRect(ACol, ARow);
end;

procedure TCustomDrawGridEh.MouseToCell(X, Y: Integer; var ACol, ARow: Longint);
var
  Coord: TGridCoord;
begin
  Coord := MouseCoord(X, Y);
  ACol := Coord.X;
  ARow := Coord.Y;
end;

procedure TCustomDrawGridEh.ColumnMoved(FromIndex, ToIndex: Longint);
begin
  if Assigned(FOnColumnMoved) then FOnColumnMoved(Self, FromIndex, ToIndex);
end;

function TCustomDrawGridEh.GetEditMask(ACol, ARow: Longint): string;
begin
  Result := '';
  if Assigned(FOnGetEditMask) then FOnGetEditMask(Self, ACol, ARow, Result);
end;

function TCustomDrawGridEh.GetEditText(ACol, ARow: Longint): string;
begin
  Result := '';
  if Assigned(FOnGetEditText) then FOnGetEditText(Self, ACol, ARow, Result);
end;

procedure TCustomDrawGridEh.RowMoved(FromIndex, ToIndex: Longint);
begin
  if Assigned(FOnRowMoved) then FOnRowMoved(Self, FromIndex, ToIndex);
end;

function TCustomDrawGridEh.SelectCell(ACol, ARow: Longint): Boolean;
begin
  Result := True;
  if Assigned(FOnSelectCell) then FOnSelectCell(Self, ACol, ARow, Result);
end;

procedure TCustomDrawGridEh.SetEditText(ACol, ARow: Longint; const Value: string);
begin
  if Assigned(FOnSetEditText) then FOnSetEditText(Self, ACol, ARow, Value);
end;

procedure TCustomDrawGridEh.DrawCell(ACol, ARow: Longint; ARect: TRect;
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

{procedure TCustomDrawGridEh.DrawContraCell(ACol, ARow: Integer; ARect: TRect; AState: TGridDrawState);
begin
  //
end;
}

procedure TCustomDrawGridEh.TopLeftChanged;
begin
  inherited TopLeftChanged;
  if Assigned(FOnTopLeftChanged) then FOnTopLeftChanged(Self);
end;

{ TGridLineColorsEh }

constructor TGridLineColorsEh.Create(AGrid: TCustomGridEh);
begin
  inherited Create;
  FGrid := AGrid;
  FBrightColor := clDefault;
  FDarkColor := clDefault;

  FDataHorzColor := clDefault;
  FDataVertColor := clDefault;
  FFixedHorzColor := clDefault;
  FFixedVertColor := clDefault;

  FHorzAreaContraBorderColor := clDefault;
  FHorzAreaContraHorzColor := clDefault;
  FHorzAreaContraVertColor := clDefault;
  FHorzAreaFrozenBorderColor := clDefault;
  FHorzAreaFrozenHorzColor := clDefault;
  FHorzAreaFrozenVertColor := clDefault;
  FVertAreaContraBorderColor := clDefault;
  FVertAreaContraHorzColor := clDefault;
  FVertAreaContraVertColor := clDefault;
  FVertAreaFrozenBorderColor := clDefault;
  FVertAreaFrozenHorzColor := clDefault;
  FVertAreaFrozenVertColor := clDefault;

end;

function TGridLineColorsEh.GetBrightColor: TColor;
begin
  if BrightColor = clDefault then
    if ColorToRGB(Grid.Color) = clSilver
      then Result := clGray
      else Result := clSilver
  else
    Result := BrightColor;
end;

function TGridLineColorsEh.GetDarkColor: TColor;
begin
  if DarkColor = clDefault then
    if Grid.Flat
      then Result := clGray
      else Result := clGray{cl3DDkShadow//clBlack}
  else
    Result := DarkColor;
end;

function TGridLineColorsEh.GetCellColor(ACol, ARow: Integer): TColor;
begin
  with Grid do
  begin
    if (ACol < FixedCols - FrozenColCount) or (ARow < FixedRows - FrozenRowCount) then
      Result := GetDarkColor
    else if (ACol < ColCount) and (ARow < RowCount) then
      Result := GetBrightColor
    else if (ACol < ColCount) and (ARow >= RowCount) then
      Result := GetVertAreaContraVertColor
    else if (ACol >= ColCount) and (ARow < RowCount) then
      Result := GetHorzAreaContraHorzColor
    else
      Result := GetVertAreaContraVertColor;
  end;
end;

function TGridLineColorsEh.GetLeftBorderCellColor(ACol, ARow: Integer): TColor;
begin
  with Grid do
  begin
{    if (ACol <= FixedCols - FrozenColCount) or (ARow <= FixedRows - FrozenRowCount) then
      Result := GetFixedVertColor
    else if (ACol <= FixedCols) then
      Result := GetVertAreaFrozenVertColor}
    if (ACol = ColCount)
      then Result := GetVertAreaContraBorderColor
      else Result := GetBrightColor;
  end;
end;

function TGridLineColorsEh.GetRightBorderCellColor(ACol, ARow: Integer): TColor;
begin
  with Grid do
  begin
    if (FrozenColCount > 0) and (ACol = FixedCols-1)
      then Result := GetVertAreaFrozenBorderColor
      else Result := GetBrightColor;
  end;
end;

function TGridLineColorsEh.GetTopBorderCellColor(ACol, ARow: Integer): TColor;
begin
  with Grid do
  begin
    if (ARow = RowCount)
      then Result := GetHorzAreaContraBorderColor
      else Result := GetBrightColor;
  end;
end;

function TGridLineColorsEh.GetDownBorderCellColor(ACol, ARow: Integer): TColor;
begin
  with Grid do
  begin
    if (FrozenRowCount > 0) and (ARow = FixedRows-1)
      then Result := GetDarkColor
      else Result := GetBrightColor;
  end;
end;

function TGridLineColorsEh.GetDataHorzColor: TColor;
begin
  if DataHorzColor = clDefault
    then Result := GetBrightColor
    else Result := DataHorzColor;
end;

function TGridLineColorsEh.GetDataVertColor: TColor;
begin
  if DataVertColor = clDefault
    then Result := GetBrightColor
    else Result := DataVertColor;
end;

function TGridLineColorsEh.GetFixedHorzColor: TColor;
begin
  if FixedHorzColor = clDefault
    then Result := GetDarkColor
    else Result := FixedHorzColor;
end;

function TGridLineColorsEh.GetFixedVertColor: TColor;
begin
  if FixedVertColor = clDefault
    then Result := GetDarkColor
    else Result := FixedVertColor;
end;

function TGridLineColorsEh.GetHorzAreaContraBorderColor: TColor;
begin
  if HorzAreaContraBorderColor = clDefault
    then Result := GetDarkColor
    else Result := HorzAreaContraBorderColor;
end;

function TGridLineColorsEh.GetHorzAreaContraHorzColor: TColor;
begin
  if HorzAreaContraHorzColor = clDefault
    then Result := GetBrightColor
    else Result := HorzAreaContraHorzColor;
end;

function TGridLineColorsEh.GetHorzAreaContraVertColor: TColor;
begin
  if HorzAreaContraVertColor = clDefault
    then Result := GetBrightColor
    else Result := HorzAreaContraVertColor;
end;

function TGridLineColorsEh.GetHorzAreaFrozenBorderColor: TColor;
begin
  if HorzAreaFrozenBorderColor = clDefault
    then Result := GetDarkColor
    else Result := HorzAreaFrozenBorderColor;
end;

function TGridLineColorsEh.GetHorzAreaFrozenHorzColor: TColor;
begin
  if HorzAreaFrozenHorzColor = clDefault
    then Result := GetBrightColor
    else Result := HorzAreaFrozenHorzColor;
end;

function TGridLineColorsEh.GetHorzAreaFrozenVertColor: TColor;
begin
  if HorzAreaFrozenVertColor = clDefault
    then Result := GetBrightColor
    else Result := HorzAreaFrozenVertColor;
end;

function TGridLineColorsEh.GetVertAreaContraBorderColor: TColor;
begin
  if VertAreaContraBorderColor = clDefault
    then Result := GetDarkColor
    else Result := VertAreaContraBorderColor;
end;

function TGridLineColorsEh.GetVertAreaContraHorzColor: TColor;
begin
  if VertAreaContraHorzColor = clDefault
    then Result := GetBrightColor
    else Result := VertAreaContraHorzColor;
end;

function TGridLineColorsEh.GetVertAreaContraVertColor: TColor;
begin
  if VertAreaContraVertColor = clDefault
    then Result := GetBrightColor
    else Result := VertAreaContraVertColor;
end;

function TGridLineColorsEh.GetVertAreaFrozenBorderColor: TColor;
begin
  if VertAreaFrozenBorderColor = clDefault
    then Result := GetDarkColor
    else Result := VertAreaFrozenBorderColor;
end;

function TGridLineColorsEh.GetVertAreaFrozenHorzColor: TColor;
begin
  if VertAreaFrozenHorzColor = clDefault
    then Result := GetBrightColor
    else Result := VertAreaFrozenHorzColor;
end;

function TGridLineColorsEh.GetVertAreaFrozenVertColor: TColor;
begin
  if VertAreaFrozenVertColor = clDefault
    then Result := GetBrightColor
    else Result := VertAreaFrozenVertColor;
end;

end.
