{------------------------------------------------------------------------------}
{ 单元名称: DWinCtl.pas                                                        }
{                                                                              }
{ 创建日期: 未知                                                               }
{                                                                              }
{ 功能介绍: 控件实现单元                                                       }
{ 修改: 增加DTEDIT控件                                                         }
{ 20080623: 增加BUTTON Moveed属性. 功能：当鼠标移动到控件上,此函数为TRUE       }
{ 20091102: 增加父类控件TDControl得到ClientRect属性 返回类型为TRect            }
{------------------------------------------------------------------------------}
unit DWinCtl;

interface

uses
  Windows, Classes, Graphics, Controls, AbstractCanvas, AbstractTextures, AsphyreTypes,
  AsphyreTextureFonts,
  Grids, Wil, Clipbrd, SysUtils, Math, Messages, Forms, uMyDxUnit;

type
  TButtonStyle = (bsButton, bsRadio, bsCheckBox);
  TClickSound = (csNone, csStone, csGlass, csNorm);
  TDGridDrawState = (gdNone, gdSelected, gdMoved);
  TDControl = class;
  TOnDirectPaint = procedure(Sender: TObject; dsurface: TAsphyreCanvas) of object;
  TOnKeyPress = procedure(Sender: TObject; var Key: Char) of object;
  TOnKeyDown = procedure(Sender: TObject; var Key: word; Shift: TShiftState) of object;
  TOnMouseMove = procedure(Sender: TObject; Shift: TShiftState; X, Y: integer) of object;
  TOnMouseDown = procedure(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer) of object;
  TOnMouseUp = procedure(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer) of object;
  TOnClick = procedure(Sender: TObject) of object;
  TOnClickEx = procedure(Sender: TObject; X, Y: integer) of object;
  TOnInRealArea = procedure(Sender: TObject; X, Y: integer; var IsRealArea: Boolean) of object;
  TOnGridSelect = procedure(Sender: TObject; ACol, ARow: integer; Shift: TShiftState) of object;
  TOnGridPaint = procedure(Sender: TObject; ACol, ARow: integer; Rect: TRect; State: TDGridDrawState; dsurface: TAsphyreCanvas) of object;
  TOnClickSound = procedure(Sender: TObject; Clicksound: TClickSound) of object;
  TOnChange = procedure(Sender: TObject) of object; //新加
  TOnInitialize = procedure (Sender: TObject) of object; //控件是否初始化
  TOnScroll = procedure(Sender: TObject; Increment: Integer) of object;
  TDImageIndex = class(TPersistent)
  private
    FOnChange: TNotifyEvent;
    FUp: Integer;
    FHot: Integer;
    FDown: Integer;
    FDisabled: Integer;
    procedure SetUp(Value: Integer);
    procedure SetHot(Value: Integer);
    procedure SetDown(Value: Integer);
    procedure SetDisabled(Value: Integer);
  protected
    procedure Changed; //dynamic;
  public
    constructor Create;
    procedure Assign(Source: TPersistent); override;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  published
    property Up: Integer read FUp write SetUp;
    property Hot: Integer read FHot write SetHot;
    property Down: Integer read FDown write SetDown;
    property Disabled: Integer read FDisabled write SetDisabled;
  end;
  {TDCustomControl = class(TCustomControl)
  private
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
    procedure WMSize(var Message: TMessage); message WM_SIZE;
  protected
    procedure AdjustClientRect(var Rect: TRect); override;
    procedure CreateParams(var Params: TCreateParams); override;
  public
    constructor Create(AOwner: TComponent); override;
  end;  }
  TDControl = class (TCustomControl)
  private
    FCaption: string;      //0x1F0
    FDParent: TDControl;   //0x1F4
    FEnableFocus: Boolean; //0x1F8
    FboInitialize: Boolean;
    FOnDirectPaint: TOnDirectPaint; //0x1FC
    FOnKeyPress: TOnKeyPress; //0x200
    FOnKeyDown: TOnKeyDown;   //0x204
    FOnMouseMove: TOnMouseMove; //0x208
    FOnMouseDown: TOnMouseDown; //0x20C
    FOnMouseUp: TOnMouseUp;     //0x210
    FOnDblClick: TNotifyEvent;  //0x214
    FOnClick: TOnClickEx;       //0x218
    FOnInRealArea: TOnInRealArea; //0x21C
    FOnInitialize: TOnInitialize; //控件初始化
    FOnBackgroundClick: TOnClick; //0x220
    FOnProcess: TNotifyEvent;
    function GetMouseMove: Boolean;
    procedure SetCaption (str: string);
    function GetClientRect: TRect;
  protected
    //加速进度条
    FGLeft: Integer;
    FGTop: Integer;
    FGWidth: Integer;
    FGHeight: Integer;
    //加速进度条结束
    FVisible: Boolean;
    procedure SetVisible (flag: Boolean);
    //为新控件后加 20090302
    //procedure DesignClick;  virtual;
    procedure CaptionChaged; dynamic;
  public
    Background: Boolean; //0x24D
    DControls: TList;    //0x250
    //FaceSurface: TAsphyreCanvas;
    WLib: TWMImages;     //0x254
    FaceIndex: integer;  //0x258
    WantReturn: Boolean; //Background老锭, Click狼 荤侩 咯何..
    constructor Create (AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
    procedure Loaded; override;
    function  SurfaceX (x: integer): integer;
    function  SurfaceY (y: integer): integer;
    function  LocalX (x: integer): integer;
    function  LocalY (y: integer): integer;
    procedure AddChild (dcon: TDControl);
    procedure ChangeChildOrder (dcon: TDControl);
    procedure Initialize;
    procedure Process; dynamic;
    function  InRange (x, y: integer): Boolean; dynamic;
    function  KeyPress (var Key: Char): Boolean; dynamic;
    function  KeyDown (var Key: Word; Shift: TShiftState): Boolean; dynamic;
    function  MouseMove (Shift: TShiftState; X, Y: Integer): Boolean; dynamic;
    function  MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; dynamic;
    function  MouseUp (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; dynamic;
    function  DblClick (X, Y: integer): Boolean; dynamic;
    function  Click (X, Y: integer): Boolean; dynamic;
    function  CanFocusMsg: Boolean;
    function  Focused: Boolean;
    procedure SetImgIndex (Lib: TWMImages; index: integer); dynamic;
    procedure DirectPaint (dsurface: TAsphyreCanvas); dynamic;
    property ClientRect: TRect read GetClientRect;

    property MouseMoveing: Boolean read GetMouseMove;
  published
    property OnProcess: TNotifyEvent read FOnProcess write FOnProcess;
    property OnDirectPaint: TOnDirectPaint read FOnDirectPaint write FOnDirectPaint;
    property OnKeyPress: TOnKeyPress read FOnKeyPress write FOnKeyPress;
    property OnKeyDown: TOnKeyDown read FOnKeyDown write FOnKeyDown;
    property OnMouseMove: TOnMouseMove read FOnMouseMove write FOnMouseMove;
    property OnMouseDown: TOnMouseDown read FOnMouseDown write FOnMouseDown;
    property OnMouseUp: TOnMouseUp read FOnMouseUp write FOnMouseUp;
    property OnDblClick: TNotifyEvent read FOnDblClick write FOnDblClick;
    property OnClick: TOnClickEx read FOnClick write FOnClick;
    property OnInRealArea: TOnInRealArea read FOnInRealArea write FOnInRealArea;
    property OnInitialize: TOnInitialize read FOnInitialize write FOnInitialize;
    property OnBackgroundClick: TOnClick read FOnBackgroundClick write FOnBackgroundClick;
    property Caption: string read FCaption write SetCaption;
    property DParent: TDControl read FDParent write FDParent;
    property Visible: Boolean read FVisible write SetVisible;
    property GTop: Integer read FGTop write FGTop;
    property GLeft: Integer read FGLeft write FGLeft;
    property GHeight: Integer read FGHeight write FGHeight;
    property GWidth: Integer read FGWidth write FGWidth;   
    property EnableFocus: Boolean read FEnableFocus write FEnableFocus;
    property Color;
    property Font;
    property Hint;
    property ShowHint;
    property Align;
  end;

  TDButton = class (TDControl)
  private
    FClickSound: TClickSound;
    FOnClick: TOnClickEx;
    FOnClickSound: TOnClickSound;
  public
    Downed: Boolean;
    constructor Create (AOwner: TComponent); override;
    function  MouseMove (Shift: TShiftState; X, Y: Integer): Boolean; override;
    function  MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
    function  MouseUp (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
  published
    property ClickCount: TClickSound read FClickSound write FClickSound;
    property OnClick: TOnClickEx read FOnClick write FOnClick;
    property OnClickSound: TOnClickSound read FOnClickSound write FOnClickSound;
  end;

  TDGrid = class (TDControl)
  private
    FColCount, FRowCount: integer;
    FColWidth, FRowHeight: integer;
    FViewTopLine: integer;
    SelectCell: TPoint;
    DownCell: TPoint;
    MoveCell: TPoint;
    FOnGridSelect: TOnGridSelect;
    FOnGridMouseMove: TOnGridSelect;
    FOnGridPaint: TOnGridPaint;
    function  GetColRow (x, y: integer; var acol, arow: integer): Boolean;
  public
    CX, CY: integer;
    Col, Row: integer;
    constructor Create (AOwner: TComponent); override;
    function  MouseMove (Shift: TShiftState; X, Y: Integer): Boolean; override;
    function  MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
    function  MouseUp (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
    function  Click (X, Y: integer): Boolean; override;
    procedure DirectPaint (dsurface: TAsphyreCanvas); override;
  published
    property ColCount: integer read FColCount write FColCount;
    property RowCount: integer read FRowCount write FRowCount;
    property ColWidth: integer read FColWidth write FColWidth;
    property RowHeight: integer read FRowHeight write FRowHeight;
    property ViewTopLine: integer read FViewTopLine write FViewTopLine;
    property OnGridSelect: TOnGridSelect read FOnGridSelect write FOnGridSelect;
    property OnGridMouseMove: TOnGridSelect read FOnGridMouseMove write FOnGridMouseMove;
    property OnGridPaint: TOnGridPaint read FOnGridPaint write FOnGridPaint;
  end;

  TDWindow = class (TDButton)
  private
    FFloating: Boolean;
    FboInitialize: Boolean;
  protected
    procedure SetVisible (flag: Boolean);
  public
    SpotX, SpotY: integer;
    DialogResult: TModalResult;
    constructor Create (AOwner: TComponent); override;
    function  MouseMove (Shift: TShiftState; X, Y: Integer): Boolean; override;
    function  MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
    function  MouseUp (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
    procedure Show;
    function  ShowModal: integer;
  published
    property Visible: Boolean read FVisible write SetVisible;
    property Floating: Boolean read FFloating write FFloating;
  end;

  TDWinManager = class (TComponent)
  private
  public
    DWinList: TList; //list of TDControl;
    constructor Create (AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AddDControl (dcon: TDControl; visible: Boolean);
    procedure DelDControl (dcon: TDControl);
    procedure ClearAll;
    procedure Process;
    function  KeyPress (var Key: Char): Boolean;
    function  KeyDown (var Key: Word; Shift: TShiftState): Boolean;
    function  MouseMove (Shift: TShiftState; X, Y: Integer): Boolean;
    function  MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
    function  MouseUp (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
    function  DblClick (X, Y: integer): Boolean;
    function  Click (X, Y: integer): Boolean;
    procedure DirectPaint (dsurface: TAsphyreCanvas);
  end;

  TDEdit = class(TDControl)
  private
    FPasswordChar: Char;
    FText: Widestring;
    FOnChange:TNotifyEvent;
    FFont:TFont;
    F3D:boolean;
    FColor:TColor;
    FTransparent:boolean;
    FMaxLength: Integer;
    XDif:integer;
    FSelCol:TColor;
    CursorTime:integer;
    InputStr:string;
    KeyByteCount: Byte;
    boDoubleByte: Boolean;
    SelStart:integer;
    SelStop:integer;

    procedure DoMove; //光标闪烁
    procedure DelSelText;
    function CopySelText():string;
    procedure SetText (str: Widestring);
    procedure SetMaxLength(const Value: Integer);
    procedure SetPasswordChar(Value: Char);
  protected
    DrawFocused:boolean;
    DrawEnabled:boolean;
    DrawHovered:boolean;
    CursorVisible:boolean;
    BlinkSpeed:integer;
    Hovered:boolean;
    function  GetSelCount:integer;
  public
    Moveed: Boolean; //20080624
    procedure SetFocus();
    property SelCount:integer read GetSelCount;
    function MouseToSelPos(AX:integer):integer;
    function  KeyDown (var Key: Word; Shift: TShiftState): Boolean; override;
    function  KeyPress (var Key: Char): Boolean; override;
    function  MouseMove (Shift: TShiftState; X, Y: Integer): Boolean; override;
    function  MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
    function  MouseUp (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
    procedure DirectPaint (dsurface: TAsphyreCanvas); override;
    procedure Update;override;
    constructor Create (AOwner: TComponent); override;
    procedure Paint; override;
    destructor Destroy; override;
  published
    property OnChange:TNotifyEvent read FOnChange write FOnChange;
    property Text: Widestring read FText write SetText;
    property MaxLength: Integer read FMaxLength write SetMaxLength;
    property Font:TFont read FFont write FFont;
    property Ctrl3D:boolean read F3D write F3D;
    property Color:TColor read FColor write FColor;
    property SelectionColor:TColor read FSelCol write FSelCol;
    property Transparent:boolean read FTransparent write FTransparent;
    property PasswordChar: Char read FPasswordChar write SetPasswordChar default #0;
  end;

{  TDCheckBox = class (TDControl)
  private
    FClickSound: TClickSound;
    FOnClick: TOnClickEx;
    FOnClickSound: TOnClickSound;
    FChecked: Boolean;
    procedure SetChecked(Value: Boolean);
    function GetChecked: Boolean;
  public
    Moveed: Boolean; //20080624
    constructor Create (AOwner: TComponent); override;
    function  MouseMove (Shift: TShiftState; X, Y: Integer): Boolean; override;
    //procedure DirectPaint (dsurface: TAsphyreCanvas); override;
    function  MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
    function  MouseUp (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
  published
    property ClickCount: TClickSound read FClickSound write FClickSound;
    property Checked: Boolean read GetChecked write SetChecked;
    property OnClick: TOnClickEx read FOnClick write FOnClick;
    property OnClickSound: TOnClickSound read FOnClickSound write FOnClickSound;
  end; }
{******************************************************************************}
  { TDListBoxItem }
  {TDComboListBox = class (TDControl)
  private
    FItems: TStrings;
    FIsDropDown: boolean;
    FItemIndex: integer;
    FItemSize: Integer;
  protected
  public
    FMouseItemIndex: Integer;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DirectPaint (dsurface: TAsphyreCanvas); override;
    function MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseMove (Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseUp (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
    function GetHeight(): Integer;
    property Items: TStrings read FItems write FItems;
  published
    property ItemIndex: integer read FItemIndex write FItemIndex;
    property IsDropDown: boolean read FIsDropDown write FIsDropDown;
  end;    }
{******************************************************************************}
  {TDComboBox = class(TDControl)
  private
    FText: string;
    FOnChange:TNotifyEvent;
    procedure SetItemIndex(const Value: integer);
    function GetItemIndex: integer;
    function GetItems(): TStrings;
    procedure SetItems(Value: TStrings);
  protected
    procedure DesignClick; override;
  public
    Moveed,Downed: Boolean;
    FListBox: TDComboListBox;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Clear;
    procedure DropDown;
    function MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseMove (Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseUp (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
  published
    property Items: TStrings read GetItems write SetItems;
    property ItemIndex: Integer read GetItemIndex write SetItemIndex;
    property Text: string read FText write FText;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;   }
{******************************************************************************}
  TDMemoScrollBarBar = class(TDControl)        
    private
      ClickY: Integer;
      CLickTheta: Real;
    public
      Downed: Boolean;
      FTheta: Real;   //新
      FItemsHeight: Integer;
      constructor Create (AOwner: TComponent); override;
      procedure Movebar(nposy : Real);
      procedure DirectPaint (dsurface: TAsphyreCanvas); override;
      function MouseUp (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
      function MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
      function MouseMove (Shift: TShiftState; X, Y: Integer): Boolean; override;
  end;

  TDMemoScrollBarUp = class(TDControl)
    public
      Downed: Boolean;
      constructor Create (AOwner: TComponent); override;
      procedure DirectPaint (dsurface: TAsphyreCanvas); override;
      function MouseUp (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
      function MouseMove (Shift: TShiftState; X, Y: Integer): Boolean; override;
      function MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
  end;

  TDMemoScrollBardown = class(TDControl)
    public
      Downed: Boolean;
      constructor Create (AOwner: TComponent); override;
      procedure DirectPaint (dsurface: TAsphyreCanvas); override;
      function MouseUp (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
      function MouseMove (Shift: TShiftState; X, Y: Integer): Boolean; override;
      function MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
  end;

  TDMemoScrollBar = class(TDControl)
    private
      FOnChange: TOnChange;
      function GetBarTheta():Real;
    public
      Downed: Boolean;
      BUp : TDMemoScrollBarUp;
      BDown : TDMemoScrollBarDown;
      Bar : TDMemoScrollBarBar;
      FArrowInc  : Real;   //新
      FPageInc   : Real;   //新
      function MouseUp (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
      function MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
      constructor Create (AOwner: TComponent); override;
      destructor Destroy; override;
      property Theta: Real read GetBarTheta;
    published
      property OnChange: TOnChange read FOnChange write FOnChange;
  end;
{******************************************************************************}
  {TDScrollLayout = class(TvgContent)
  private
  protected
    function GetClipRect: TvgRect; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
  end;
  
  TDScrollBox = class(TDControl)
  private
    FHScrollBar: TDScrollBar;  //竖的滚动条
    FLayout: TDScrollLayout;   //布局
    FAutoHide: boolean;         //是否自动隐藏
    FScrollResource: string;    //滚动资源
    FDisableMouseWheel: boolean; //鼠标是否可见
    procedure SetScrollResource(const Value: string);
  protected
    procedure HScrollChange(Sender: TObject); //竖的滚动条改变
    procedure VScrollChange(Sender: TObject); //横的滚动条改变
    procedure Loaded; override;      //界面图
  public
    constructor Create(AOwner: TComponent); override; 
    destructor Destroy; override;
    procedure AddObject(AObject: TvgObject); override; //添加类型
    procedure MouseWheel(Shift: TShiftState; WheelDelta: integer; var Handled: boolean); override; //鼠标按下
    procedure Realign; override;     //调整
    procedure Centre; //中央
    procedure ScrollTo(const Dx, Dy: single); //滚动到哪
    procedure InViewRect(const Rect: TvgRect); //可见范围
    procedure BeginUpdate;  //开始更新
    procedure EndUpdate;    //结束更新
  published
    property AutoHide: boolean read FAutoHide write FAutoHide default true;
    property HScrollBar: TvgScrollBar read FHScrollBar write FHScrollBar;
    property VScrollBar: TvgScrollBar read FVScrollBar write FVScrollBar;
    property DisableMouseWheel: boolean read FDisableMouseWheel write FDisableMouseWheel;
    property ScrollResource: string read FScrollResource write SetScrollResource;
  end; }
{******************************************************************************}
  TDMemo = class(TDButton)
    private
      FLines: TStringList;
      FLinesHeight: Integer;
      procedure SetLines(Value: TStringList);
      procedure SetLinesHeight(Value: Integer);
    public
      DScroll : TDMemoScrollBar;
      constructor Create (AOwner: TComponent); override;
      destructor Destroy; override;
      property Lines: TStringList read FLines write SetLines;
      property LinesHeight: Integer read FLinesHeight write SetLinesHeight;
    end;

  TDMapMini = class (TDButton)  //小地图专用控件
  public
    Moveed: Boolean;
    constructor Create (AOwner: TComponent); override;
    function  MouseMove (Shift: TShiftState; X, Y: Integer): Boolean; override;
  end;

procedure Register;
procedure SetDFocus (dcon: TDControl);
procedure ReleaseDFocus;
procedure SetDCapture (dcon: TDControl);
procedure ReleaseDCapture;

function ShortRect(const Rect1, Rect2: TRect): TRect;
function ShrinkRect(const Rect: TRect; const hIn, vIn: Integer): TRect;
//--------------为容器控件添加begin-------------------
function MoveRect(const Rect: TRect; const Point: TPoint): TRect;
//--------------为容器控件添加End---------------------
var
  MouseCaptureControl: TDControl; //mouse message
  FocusedControl: TDControl; //Key message
  MouseMoveControl: TDControl;
  MainWinHandle: integer;
  ModalDWindow: TDControl;
implementation
uses uDPopupMenu;
procedure Register;
begin
   RegisterComponents('MirGame', [TDWinManager, TDControl, TDButton, TDGrid, TDWindow, TDEdit, {TDCheckBox, TDComboBox,} TDMemo, TDMemoScrollBar, TDMapMini]);
end;
//--------------为容器控件添加begin-------------------
function MoveRect(const Rect: TRect; const Point: TPoint): TRect;
begin
  Result.Left := Rect.Left + Point.X;
  Result.Top := Rect.Top + Point.Y;
  Result.Right := Rect.Right + Point.X;
  Result.Bottom := Rect.Bottom + Point.Y;
end;
//--------------为容器控件添加End---------------------
function ShrinkRect(const Rect: TRect; const hIn, vIn: Integer): TRect;
begin
  Result.Left := Rect.Left + hIn;
  Result.Top := Rect.Top + vIn;
  Result.Right := Rect.Right - hIn;
  Result.Bottom := Rect.Bottom - vIn;
end;
//---------------------------------------------------------------------------
function ShortRect(const Rect1, Rect2: TRect): TRect;
begin
  Result.Left := Max(Rect1.Left, Rect2.Left);
  Result.Top := Max(Rect1.Top, Rect2.Top);
  Result.Right := Min(Rect1.Right, Rect2.Right);
  Result.Bottom := Min(Rect1.Bottom, Rect2.Bottom);
end;

procedure SetDFocus (dcon: TDControl);
begin
   FocusedControl := dcon;
end;

procedure ReleaseDFocus;
begin
   FocusedControl := nil;
end;

procedure SetDCapture (dcon: TDControl);
begin
   //SetCapture (MainWinHandle);
   MouseCaptureControl := dcon;
end;

procedure ReleaseDCapture;
begin
   //ReleaseCapture;
   MouseCaptureControl := nil;
end;

{----------------------------- TDControl -------------------------------}

constructor TDControl.Create (AOwner: TComponent);
begin
   inherited Create (AOwner);
   DParent := nil;
   inherited Visible := FALSE;
   FEnableFocus := FALSE;
   Background := FALSE;
   FboInitialize := False;
   FOnDirectPaint := nil;
   FOnKeyPress := nil;
   FOnKeyDown := nil;
   FOnMouseMove := nil;
   FOnMouseDown := nil;
   FOnMouseUp := nil;
   FOnInRealArea := nil;
   FOnInitialize := nil;
   DControls := TList.Create;
   FDParent := nil;
   FGLeft := 0;
   FGTop := 0;
   FGWidth := 0;
   FGHeight:= 0;
   Width := 80;
   Height:= 24;
   FCaption := '';
   FVisible := TRUE;
   //FaceSurface := nil;
   WLib := nil;
   FaceIndex := 0;
end;

destructor TDControl.Destroy;
begin
  if Self = MouseMoveControl then MouseMoveControl := nil;
  DControls.Free;
  inherited Destroy;
end;

function TDControl.Focused: Boolean;  //20080624
begin
  if FocusedControl = Self then Result := True
  else Result := False;
end;

procedure TDControl.SetCaption (str: string);
begin
   FCaption := str;
   if csDesigning in ComponentState then begin
      Refresh;
   end else CaptionChaged;
end;

procedure TDControl.Paint;
begin
   if csDesigning in ComponentState then begin
      if self is TDWindow then begin
         with Canvas do begin
            Pen.Color := clBlack;
            MoveTo (0, 0);
            LineTo (Width-1, 0);
            LineTo (Width-1, Height-1);
            LineTo (0, Height-1);
            LineTo (0, 0);
            LineTo (Width-1, Height-1);
            MoveTo (Width-1, 0);
            LineTo (0, Height-1);
            TextOut ((Width-TextWidth(Caption)) div 2, (Height-TextHeight(Caption)) div 2, Caption);
         end;
      end else begin
         with Canvas do begin
            Pen.Color := clBlack;
            MoveTo (0, 0);
            LineTo (Width-1, 0);
            LineTo (Width-1, Height-1);
            LineTo (0, Height-1);
            LineTo (0, 0);
            TextOut ((Width-TextWidth(Caption)) div 2, (Height-TextHeight(Caption)) div 2, Caption);
         end;
      end;
   end;
end;

procedure TDControl.Process;
var
  I: Integer;
begin
  if Assigned(FOnProcess) then FOnProcess(Self);
  for I := 0 to DControls.Count - 1 do
    if TDControl(DControls[I]).Visible then
      TDControl(DControls[I]).Process;
end;

procedure TDControl.Loaded;
var
   i: integer;
   dcon: TDControl;
begin
   if not (csDesigning in ComponentState) then begin
      if Parent <> nil then
         if TControl(Parent).ComponentCount > 0 then //20080629
         for i:=0 to TControl(Parent).ComponentCount-1 do begin
            if TControl(Parent).Components[i] is TDControl then begin
               dcon := TDControl(TControl(Parent).Components[i]);
               if dcon.DParent = self then begin
                  AddChild (dcon);
               end;
            end;
         end;
   end;
end;

//瘤开 谅钎甫 傈眉 谅钎肺 官厕
function  TDControl.SurfaceX (x: integer): integer;
var
   d: TDControl;
begin
   d := self;
   while TRUE do begin
      if d.DParent = nil then break;
      x := x + d.DParent.GLeft;
      d := d.DParent;
   end;
   Result := x;
end;

function  TDControl.SurfaceY (y: integer): integer;
var
   d: TDControl;
begin
   d := self;
   while TRUE do begin
      if d.DParent = nil then break;
      y := y + d.DParent.GTop;
      d := d.DParent;
   end;
   Result := y;
end;

//傈眉谅钎甫 按眉狼 谅钎肺 官厕
function  TDControl.LocalX (x: integer): integer;
var
   d: TDControl;
begin
   d := self;
   while TRUE do begin
      if d.DParent = nil then break;
      x := x - d.DParent.GLeft;
      d := d.DParent;
   end;
   Result := x;
end;

function  TDControl.LocalY (y: integer): integer;
var
   d: TDControl;
begin
   d := self;
   while TRUE do begin
      if d.DParent = nil then break;
      y := y - d.DParent.GTop;
      d := d.DParent;
   end;
   Result := y;
end;

procedure TDControl.AddChild (dcon: TDControl);
begin
   DControls.Add (Pointer (dcon));
end;

procedure TDControl.ChangeChildOrder (dcon: TDControl);
var
   i: integer;
begin
   if not (dcon is TDWindow) then exit;
   //if TDWindow(dcon).Floating then begin  //20081024修改
      if DControls.Count > 0 then //20080629
      for i:=0 to DControls.Count-1 do begin
         if dcon = DControls[i] then begin
            DControls.Delete (i);
            break;
         end;
      end;
      DControls.Add (dcon);
   //end;
end;

procedure TDControl.Initialize;
var
  I: Integer;
begin
  if Assigned (FOnInitialize) then begin
    FOnInitialize(Self);
  end;
end;

function  TDControl.InRange (x, y: integer): Boolean;
var
   inrange: Boolean;
   d: TAsphyreLockableTexture;
begin
   if (x >= GLeft) and (x < GLeft+GWidth) and (y >= GTop) and (y < GTop+GHeight) then begin
      inrange := TRUE;
      if Assigned (FOnInRealArea) then
         FOnInRealArea(self, x-GLeft, y-GTop, inrange)
      else
         if WLib <> nil then begin
            d := WLib.Images[FaceIndex];
          if (d <> nil) and (d.Format in [apf_DXT1..apf_DXT5]) then begin
            d := WLib.Alphas[FaceIndex];
          end;
            if d <> nil then
               //if d.Pixels[x-GLeft, y-GTop] <= 0 then
                  inrange := CheckTextureAlpha(d, X - GLeft, Y - GTop);
                  //inrange := FALSE;
         end;
      Result := inrange;
   end else
      Result := FALSE;
end;

function  TDControl.KeyPress (var Key: Char): Boolean;
var
   i: integer;
begin
   Result := FALSE;
   if Background then exit;
   if DControls.Count > 0 then //20080629
   for i:=DControls.Count-1 downto 0 do
      if TDControl(DControls[i]).Visible then
         if TDControl(DControls[i]).KeyPress(Key) then begin
            Result := TRUE;
            exit;
         end;
   if (FocusedControl=self) then begin
      if Assigned (FOnKeyPress) then FOnKeyPress (self, Key);
      Result := TRUE;
   end;
end;

function  TDControl.KeyDown (var Key: Word; Shift: TShiftState): Boolean;
var
   i: integer;
begin
   Result := FALSE;
   if Background then exit;
   if DControls.Count > 0 then //20080629
   for i:=DControls.Count-1 downto 0 do
      if TDControl(DControls[i]).Visible then
         if TDControl(DControls[i]).KeyDown(Key, Shift) then begin
            Result := TRUE;
            exit;
         end;
   if (FocusedControl=self) then begin
      if Assigned (FOnKeyDown) then FOnKeyDown (self, Key, Shift);
      Result := TRUE;
   end;
end;

function  TDControl.CanFocusMsg: Boolean;
begin
   if (MouseCaptureControl = nil) or ((MouseCaptureControl <> nil) and ((MouseCaptureControl=self) or (MouseCaptureControl=DParent))) then
      Result := TRUE
   else
      Result := FALSE;
end;

procedure TDControl.CaptionChaged;
begin

end;

function  TDControl.MouseMove (Shift: TShiftState; X, Y: Integer): Boolean;
var
  i: integer;
begin
   Result := FALSE;
   if DControls.Count > 0 then //20080629
   for i:=DControls.Count-1 downto 0 do
      if TDControl(DControls[i]).Visible then
         if TDControl(DControls[i]).MouseMove(Shift, X-GLeft, Y-GTop) then begin
            Result := TRUE;
            Exit;
         end;

   if (MouseCaptureControl <> nil) then begin //MouseCapture 捞搁 磊脚捞 快急
      if (MouseCaptureControl = self) then begin
        if Self is TDMapMini then begin  //小地图
          if InRange(x, y) then begin
            if Assigned (FOnMouseMove) then
              FOnMouseMove (self, Shift, X, Y);
            Result := TRUE;
          end;
        end else begin
          if Assigned (FOnMouseMove) then
            FOnMouseMove (self, Shift, X, Y);
          Result := TRUE;
        end;
      end;
      Exit;
   end;

   if Background then Exit;
   if InRange (X, Y) then begin
     MouseMoveControl := Self;
      if Assigned (FOnMouseMove) then
         FOnMouseMove (self, Shift, X, Y);
      Result := TRUE;
   end;
end;

function  TDControl.MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
var
   I: integer;
  // boMouseDown: Boolean; //20090424
begin
   Result := FALSE;
  // boMouseDown := False;
   if DControls.Count > 0 then //20080629
   for i:=DControls.Count-1 downto 0 do
      if TDControl(DControls[i]).Visible then begin
         if TDControl(DControls[i]).MouseDown(Button, Shift, X-GLeft, Y-GTop) then begin
            //TDControl(DControls[i]).DesignClick;
            Result := TRUE;
            //boMouseDown := True;
            Exit; //点TDwindow控件Combobox下拉框不隐藏是这的问题
                  //原理：点击TDwindow他会把他自己在DControls列表位置转移到最后  而这里循环是downto 所以查到点了他 就退出了
                  //      小类没执行到  所以执行不到隐藏过程
         end;
      end;
   //if boMouseDown then Exit;
   if Background then begin //如果是背景图层
      if Assigned (FOnBackgroundClick) then begin
         WantReturn := FALSE;
         FOnBackgroundClick (self);
         if WantReturn then Result := TRUE;
      end;
      ReleaseDFocus;
      Exit;
   end;
   if CanFocusMsg then begin
      if InRange (X, Y) or (MouseCaptureControl = self) then begin
        MouseMoveControl := nil;
        if Self is TDMapMini then begin  //小地图
          if InRange(x, y) then begin
            if Assigned (FOnMouseDown) then
              FOnMouseDown (self, Button, Shift, X, Y);
            if EnableFocus then SetDFocus (self);
            Result := TRUE;
          end;
        end else begin
          if Assigned (FOnMouseDown) then
             FOnMouseDown (self, Button, Shift, X, Y);
          if EnableFocus then SetDFocus (self);
          Result := TRUE;
        end;
      end;
   end;
end;

function  TDControl.MouseUp (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
var
   i: integer;
begin
   Result := FALSE;
   if DControls.Count > 0 then //20080629
   for i:=DControls.Count-1 downto 0 do
      if TDControl(DControls[i]).Visible then
         if TDControl(DControls[i]).MouseUp(Button, Shift, X-GLeft, Y-GTop) then begin
            Result := TRUE;
            exit;
         end;

   if (MouseCaptureControl <> nil) then begin //MouseCapture 捞搁 磊脚捞 快急
      if (MouseCaptureControl = self) then begin
         if Assigned (FOnMouseUp) then
            FOnMouseUp (self, Button, Shift, X, Y);
         Result := TRUE;
      end;
      exit;
   end;

   if Background then exit;
   if InRange (X, Y) then begin
      if Assigned (FOnMouseUp) then
         FOnMouseUp (self, Button, Shift, X, Y);
      Result := TRUE;
   end;
end;

function  TDControl.DblClick (X, Y: integer): Boolean;
var
   i: integer;
begin
   Result := FALSE;
   if (MouseCaptureControl <> nil) then begin //MouseCapture 捞搁 磊脚捞 快急
      if (MouseCaptureControl = self) then begin
         if Assigned (FOnDblClick) then
            FOnDblClick (self);
         Result := TRUE;
      end;
      exit;
   end;
   if DControls.Count > 0 then //20080629
   for i:=DControls.Count-1 downto 0 do
      if TDControl(DControls[i]).Visible then
         if TDControl(DControls[i]).DblClick(X-GLeft, Y-GTop) then begin
            Result := TRUE;
            exit;
         end;
   if Background then exit;
   if InRange (X, Y) then begin
      if Assigned (FOnDblClick) then
         FOnDblClick (self);
      Result := TRUE;
   end;
end;

function  TDControl.Click (X, Y: integer): Boolean;
var
   i: integer;
begin
   Result := FALSE;
   if (MouseCaptureControl <> nil) then begin //MouseCapture 捞搁 磊脚捞 快急
      if (MouseCaptureControl = self) then begin
         if Assigned (FOnClick) then
            FOnClick (self, X, Y);
         Result := TRUE;
      end;
      exit;
   end;
   if DControls.Count > 0 then //20080629
   for i:=DControls.Count-1 downto 0 do
      if TDControl(DControls[i]).Visible then
         if TDControl(DControls[i]).Click(X-GLeft, Y-GTop) then begin
            Result := TRUE;
            exit;
         end;
   if Background then exit;
   if InRange (X, Y) then begin
      if Assigned (FOnClick) then
         FOnClick (self, X, Y);
      Result := TRUE;
   end;
end;


procedure TDControl.SetImgIndex (Lib: TWMImages; index: integer);
var
   d: TAsphyreLockableTexture;
begin
  //FaceSurface := dsurface;
  if Lib <> nil then begin
    d := Lib.Images[index];
    WLib := Lib;
    FaceIndex := index;
    if d <> nil then begin
      GWidth := d.Width;
      GHeight := d.Height;
    end;
  end;
end;

procedure TDControl.SetVisible(flag: Boolean);
var
  I: Integer;
begin
  if flag then begin
    if not FboInitialize and not (csReading in ComponentState) then begin
      if DControls.Count > 0 then begin
        for I:=0 to DControls.Count - 1 do begin
          TDControl(DControls[I]).Visible := TDControl(DControls[I]).Visible;
        end;
      end;
      Initialize;
      FboInitialize := True;
    end;
  end;
  FVisible := flag;
end;

procedure TDControl.DirectPaint (dsurface: TAsphyreCanvas);
var
   i: integer;
   d: TAsphyreLockableTexture;
   vtRect: TRect;
   vbRect: TRect;
   PaintRect: TRect;
begin
  if Assigned (FOnDirectPaint) then
    FOnDirectPaint (self, dsurface)
  else
  if WLib <> nil then begin
    d := WLib.Images[FaceIndex];
    if d <> nil then begin
      dsurface.Draw (SurfaceX(GLeft), SurfaceY(GTop), d.ClientRect, d, TRUE);
    end;
  end;
  if DControls.Count > 0 then //20080629
  for i:=0 to DControls.Count-1 do
    if TDControl(DControls[i]).Visible then
      TDControl(DControls[i]).DirectPaint (dsurface);
end;
{--------------------- TDButton --------------------------}


constructor TDButton.Create (AOwner: TComponent);
begin
   inherited Create (AOwner);
   Downed := FALSE;
   FOnClick := nil;
   FEnableFocus := TRUE;
   FClickSound := csNone;
end;

function  TDButton.MouseMove (Shift: TShiftState; X, Y: Integer): Boolean;
begin
  Result := inherited MouseMove (Shift, X, Y);
  if (not Background) and (not Result) then begin
    Result := inherited MouseMove (Shift, X, Y);
    if MouseCaptureControl = self then begin
      if InRange (X, Y) then begin
        Downed := TRUE;
      end else Downed := FALSE;
    end;
  end;
end;

function  TDButton.MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
begin
  Result := FALSE;
  if inherited MouseDown (Button, Shift, X, Y) then begin
    if (not Background) and (MouseCaptureControl=nil) then begin
      if mbLeft = Button then begin
        Downed := TRUE;
        SetDCapture (self);
      end;
    end;
    Result := TRUE;
  end;
end;

function  TDButton.MouseUp (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
begin
  Result := FALSE;
  if inherited MouseUp (Button, Shift, X, Y) then begin
    ReleaseDCapture;
    if not Background then begin
      if Enabled then begin
        if InRange (X, Y) then begin
          if mbLeft = Button then begin  //20090212修改右键点控件不好使
            if Assigned (FOnClickSound) then FOnClickSound(self, FClickSound);
            if Assigned (FOnClick) then FOnClick(self, X, Y);
          end;
        end;
      end;
    end;
    Downed := FALSE;
    Result := TRUE;
    Exit;
  end else begin
    ReleaseDCapture;
    Downed := FALSE;
  end;
end;

{------------------------- TDGrid --------------------------}

constructor TDGrid.Create (AOwner: TComponent);
begin
   inherited Create (AOwner);
   FColCount := 8;
   FRowCount := 5;
   FColWidth := 36;
   FRowHeight:= 32;
   FOnGridSelect := nil;
   FOnGridMouseMove := nil;
   FOnGridPaint := nil;
end;

function  TDGrid.GetColRow (x, y: integer; var acol, arow: integer): Boolean;
begin
   Result := FALSE;
   if InRange (x, y) then begin
      acol := (x-GLeft) div FColWidth;
      arow := (y-GTop) div FRowHeight;
      Result := TRUE;
   end;
end;

function  TDGrid.MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
var
   acol, arow: integer;
begin
   Result := FALSE;
   if mbLeft = Button then begin
      if GetColRow (X, Y, acol, arow) then begin
         SelectCell.X := acol;
         SelectCell.Y := arow;
         SetDCapture (self);
         Result := TRUE;
      end;
   end;
end;

function  TDGrid.MouseMove (Shift: TShiftState; X, Y: Integer): Boolean;
var
   acol, arow: integer;
begin
   Result := FALSE;
   if InRange (X, Y) then begin
      if GetColRow (X, Y, acol, arow) then begin
         if Assigned (FOnGridMouseMove) then
            FOnGridMouseMove (self, acol, arow, Shift);
      end;
      Result := TRUE;
   end;
end;

function  TDGrid.MouseUp (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
var
   acol, arow: integer;
begin
   Result := FALSE;
   if mbLeft = Button then begin
      if GetColRow (X, Y, acol, arow) then begin
         if (SelectCell.X = acol) and (SelectCell.Y = arow) then begin
            Col := acol;
            Row := arow;
            if Assigned (FOnGridSelect) then
               FOnGridSelect (self, acol, arow, Shift);
         end;
         Result := TRUE;
      end;
      ReleaseDCapture;
   end;
end;

function  TDGrid.Click (X, Y: integer): Boolean;
{var
   acol, arow: integer; }
begin
   Result := FALSE;
  { if GetColRow (X, Y, acol, arow) then begin
      if Assigned (FOnGridSelect) then
         FOnGridSelect (self, acol, arow, []);
      Result := TRUE;
   end; }
end;

procedure TDGrid.DirectPaint (dsurface: TAsphyreCanvas);
var
   i, j: integer;
   rc: TRect;
begin
   if Assigned (FOnGridPaint) then
      if FRowCount > 0 then //20080629
      for i:=0 to FRowCount-1 do
         for j:=0 to FColCount-1 do begin
            rc := Rect (GLeft + j*FColWidth, GTop + i*FRowHeight, GLeft+j*(FColWidth+1)-1, GTop+i*(FRowHeight+1)-1);
            if (SelectCell.Y = i) and (SelectCell.X = j) then
              FOnGridPaint (self, j, i, rc, gdSelected, dsurface)
            else FOnGridPaint (self, j, i, rc, gdNone, dsurface);
         end;
end;


{--------------------- TDWindown --------------------------}


constructor TDWindow.Create (AOwner: TComponent);
begin
   inherited Create (AOwner);
   FFloating := FALSE;
   FboInitialize := False;
   FEnableFocus := TRUE;
   Width := 120;
   Height := 120;
end;

procedure TDWindow.SetVisible (flag: Boolean);
begin
  inherited SetVisible(flag);
  if Floating then begin
    if DParent <> nil then
       DParent.ChangeChildOrder (self);
  end;
end;

function  TDWindow.MouseMove (Shift: TShiftState; X, Y: Integer): Boolean;
//var
  // al, at: integer;
begin
   Result := inherited MouseMove (Shift, X, Y);
   if Result and FFloating and (MouseCaptureControl=self) then begin
      if (SpotX <> X) or (SpotY <> Y) then begin
         GLeft := GLeft + (X - SpotX);
         GTop := GTop + (Y - SpotY);
         //if al+Width < WINLEFT then al := WINLEFT - Width;
         //if al > WINRIGHT then al := WINRIGHT;
         //if at+Height < WINTOP then at := WINTOP - Height;
         //if at+Height > BOTTOMEDGE then at := BOTTOMEDGE-Height;
         //Left := al;
         //Top := at;
         SpotX := X;
         SpotY := Y;
      end;
   end;
end;

function  TDWindow.MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
begin
   Result := inherited MouseDown (Button, Shift, X, Y);
   if Result then begin
      //if Floating then begin   //20081024修改
         if DParent <> nil then
            DParent.ChangeChildOrder (self);
      //end;
      SpotX := X;
      SpotY := Y;
   end;
end;

function  TDWindow.MouseUp (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
begin
   Result := inherited MouseUp (Button, Shift, X, Y);
end;

procedure TDWindow.Show;
begin
   Visible := TRUE;
   if Floating then begin
      if DParent <> nil then
         DParent.ChangeChildOrder (self);
   end;
   if EnableFocus then SetDFocus (self);
end;

function  TDWindow.ShowModal: integer;
begin
   Result:=0;//Jacky
   Visible := TRUE;
   ModalDWindow := self;
   if EnableFocus then SetDFocus (self);
end;


{--------------------- TDWinManager --------------------------}


constructor TDWinManager.Create (AOwner: TComponent);
begin
   inherited Create (AOwner);
   DWinList := TList.Create;
   MouseCaptureControl := nil;
   FocusedControl := nil;
end;

destructor TDWinManager.Destroy;
begin
   DWinList.Free;
   inherited Destroy;
end;

procedure TDWinManager.ClearAll;
begin
   DWinList.Clear;
end;

procedure TDWinManager.AddDControl (dcon: TDControl; visible: Boolean);
begin
   dcon.Visible := visible;
   DWinList.Add (dcon);
end;

procedure TDWinManager.DelDControl (dcon: TDControl);
var
   i: integer;
begin
   if DWinList.Count > 0 then //20080629
   for i:=0 to DWinList.Count-1 do
      if DWinList[i] = dcon then begin
         DWinList.Delete (i);
         break;
      end;
end;

function  TDWinManager.KeyPress (var Key: Char): Boolean;
begin
   Result := FALSE;
  if (ActiveMenu <> nil) and ActiveMenu.Visible and (not ActiveMenu.Enabled) then
    ActiveMenu := nil;

  if ActiveMenu <> nil then begin
    if ActiveMenu.Visible then begin
      with ActiveMenu do
        Result := KeyPress(Key);
      Exit;
    end else
      ActiveMenu := nil;
    Key := #0;
  end;

   if ModalDWindow <> nil then begin
      if ModalDWindow.Visible then begin
         with ModalDWindow do
            Result := KeyPress (Key);
         exit;
      end else
         ModalDWindow := nil;
      Key := #0; //ModalDWindow啊 KeyDown阑 芭摹搁辑 Visible=false肺 函窍搁辑
             //KeyPress甫 促矫芭媚辑 ModalDwindow=nil捞 等促.
   end;

   if FocusedControl <> nil then begin
      if FocusedControl.Visible then begin
         Result := FocusedControl.KeyPress (Key);
      end else
         ReleaseDFocus;
   end;
   {for i:=0 to DWinList.Count-1 do begin
      if TDControl(DWinList[i]).Visible then begin
         if TDControl(DWinList[i]).KeyPress (Key) then begin
            Result := TRUE;
            break;
         end;
      end;
   end; }
end;

function  TDWinManager.KeyDown (var Key: Word; Shift: TShiftState): Boolean;
begin
   Result := FALSE;

  if (ActiveMenu <> nil) and ActiveMenu.Visible and (not ActiveMenu.Enabled) then
    ActiveMenu := nil;

  if ActiveMenu <> nil then begin
    if ActiveMenu.Visible then begin
      with ActiveMenu do
        Result := KeyDown(Key, Shift);
      Exit;
    end else ActiveMenu := nil;
  end;

   if ModalDWindow <> nil then begin
      if ModalDWindow.Visible then begin
         with ModalDWindow do
            Result := KeyDown (Key, Shift);
         exit;
      end else MOdalDWindow := nil;
   end;
   if FocusedControl <> nil then begin
      if FocusedControl.Visible then
         Result := FocusedControl.KeyDown (Key, Shift)
      else
         ReleaseDFocus;
   end;
   {for i:=0 to DWinList.Count-1 do begin
      if TDControl(DWinList[i]).Visible then begin
         if TDControl(DWinList[i]).KeyDown (Key, Shift) then begin
            Result := TRUE;
            break;
         end;
      end;
   end; }
end;

function  TDWinManager.MouseMove (Shift: TShiftState; X, Y: Integer): Boolean;
var
   i: integer;
begin
   Result := FALSE;
  if (ActiveMenu <> nil) and ActiveMenu.Visible and (not ActiveMenu.Enabled) then begin
    ActiveMenu.Hide;
    ActiveMenu := nil;
  end;
  if ActiveMenu <> nil then begin
    if ActiveMenu.Visible then begin
      with ActiveMenu do
        Result := MouseMove(Shift, LocalX(X), LocalY(Y));
      //Result := True;
      //Exit;
      if Result then Exit else begin
       { ActiveMenu.Hide;
        ActiveMenu := nil;  }
      end;
    end else begin
      ActiveMenu.Hide;
      ActiveMenu := nil;
    end;
  end;
   if ModalDWindow <> nil then begin
      if ModalDWindow.Visible then begin
         with ModalDWindow do
            MouseMove (Shift, LocalX(X), LocalY(Y));
         Result := TRUE;
         exit;
      end else MOdalDWindow := nil;
   end;
   if MouseCaptureControl <> nil then begin
      with MouseCaptureControl do
         Result := MouseMove (Shift, LocalX(X), LocalY(Y));
   end else
      if DWinList.Count > 0 then //20080629
      for i:=0 to DWinList.Count-1 do begin
         if TDControl(DWinList[i]).Visible then begin
            if TDControl(DWinList[i]).MouseMove (Shift, X, Y) then begin
               Result := TRUE;
               break;
            end;
         end;
      end;
end;

function  TDWinManager.MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
var
   i: integer;
begin
   Result := FALSE;
  if (ActiveMenu <> nil) and ActiveMenu.Visible and (not ActiveMenu.Enabled) then begin
    ActiveMenu.Hide;
    ActiveMenu := nil;
  end;
  if ActiveMenu <> nil then begin
    if ActiveMenu.Visible then begin
      with ActiveMenu do
        Result := MouseDown(Button, Shift, LocalX(X), LocalY(Y));
      if Result then Exit else begin
        ActiveMenu.Hide;
        ActiveMenu := nil;
      end;
    end else begin
      ActiveMenu.Hide;
      ActiveMenu := nil;
    end;
  end;
   if ModalDWindow <> nil then begin
      if ModalDWindow.Visible then begin
         with ModalDWindow do
            MouseDown (Button, Shift, LocalX(X), LocalY(Y));
         Result := TRUE;    
         exit;
      end else ModalDWindow := nil;     
   end;
   if MouseCaptureControl <> nil then begin
      with MouseCaptureControl do
         Result := MouseDown (Button, Shift, LocalX(X), LocalY(Y));
   end else
      if DWinList.Count > 0 then //20080629
      for i:=0 to DWinList.Count-1 do begin
         if TDControl(DWinList[i]).Visible then begin
            if TDControl(DWinList[i]).MouseDown (Button, Shift, X, Y) then begin
               Result := TRUE;
               break;
            end;
         end;
      end;
end;

function  TDWinManager.MouseUp (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
var
   i: integer;
begin
   Result := TRUE;
  if (ActiveMenu <> nil) and ActiveMenu.Visible and (not ActiveMenu.Enabled) then begin
    ActiveMenu.Hide;
    ActiveMenu := nil;
  end;
  if ActiveMenu <> nil then begin
    if ActiveMenu.Visible then begin
      with ActiveMenu do
        Result := MouseUp(Button, Shift, LocalX(X), LocalY(Y));
      if Result then Exit else begin
        {ActiveMenu.Hide;
        ActiveMenu := nil;  }
      end;
    end else begin
      ActiveMenu.Hide;
      ActiveMenu := nil;
    end;
  end;

   if ModalDWindow <> nil then begin
      if ModalDWindow.Visible then begin
         with ModalDWindow do
            Result := MouseUp (Button, Shift, LocalX(X), LocalY(Y));
         exit;
      end else ModalDWindow := nil;
   end;
   if MouseCaptureControl <> nil then begin
      with MouseCaptureControl do
         Result := MouseUp (Button, Shift, LocalX(X), LocalY(Y));
   end else
      if DWinList.Count > 0 then //20080629
      for i:=0 to DWinList.Count-1 do begin
         if TDControl(DWinList[i]).Visible then begin
            if TDControl(DWinList[i]).MouseUp (Button, Shift, X, Y) then begin
               Result := TRUE;
               break;
            end;
         end;
      end;
end;

procedure TDWinManager.Process;
var
  I: Integer;
begin
  for I := 0 to DWinList.Count - 1 do begin
    if TDControl(DWinList[I]).Visible then begin
      TDControl(DWinList[I]).Process;
    end;
  end;
  if ModalDWindow <> nil then begin
    if ModalDWindow.Visible then
      with ModalDWindow do
        Process;
  end;
  if ActiveMenu <> nil then begin
    if ActiveMenu.Visible then
      with ActiveMenu do begin
        Process;
      end;
  end;
end;

function  TDWinManager.DblClick (X, Y: integer): Boolean;
var
   i: integer;
begin
   Result := TRUE;
  if (ActiveMenu <> nil) and ActiveMenu.Visible and (not ActiveMenu.Enabled) then begin
    ActiveMenu.Hide;
    ActiveMenu := nil;
  end;
  if ActiveMenu <> nil then begin
    if ActiveMenu.Visible then begin
      with ActiveMenu do
        Result := DblClick(LocalX(X), LocalY(Y));
      Result := True;
      if Result then Exit else begin
        ActiveMenu.Hide;
        ActiveMenu := nil;
      end;
    end else begin
      ActiveMenu.Hide;
      ActiveMenu := nil;
    end;
  end;
   if ModalDWindow <> nil then begin
      if ModalDWindow.Visible then begin
         with ModalDWindow do
            Result := DblClick (LocalX(X), LocalY(Y));
         exit;
      end else ModalDWindow := nil;
   end;
   if MouseCaptureControl <> nil then begin
      with MouseCaptureControl do
         Result := DblClick (LocalX(X), LocalY(Y));
   end else
      if DWinList.Count > 0 then //20080629
      for i:=0 to DWinList.Count-1 do begin
         if TDControl(DWinList[i]).Visible then begin
            if TDControl(DWinList[i]).DblClick (X, Y) then begin
               Result := TRUE;
               break;
            end;
         end;
      end;
end;

function  TDWinManager.Click (X, Y: integer): Boolean;
var
   i: integer;
begin
   Result := TRUE;
  if (ActiveMenu <> nil) and ActiveMenu.Visible and (not ActiveMenu.Enabled) then begin
    ActiveMenu.Hide;
    ActiveMenu := nil;
  end;
  if ActiveMenu <> nil then begin
    if ActiveMenu.Visible then begin
      with ActiveMenu do
        Result := Click(LocalX(X), LocalY(Y));
      if Result then Exit else begin
        if MouseCaptureControl <> ActiveMenu.DControl then begin
          ActiveMenu.Hide;
          ActiveMenu := nil;
        end;
      end;
    end else begin
      ActiveMenu.Hide;
      ActiveMenu := nil;
    end;
  end;
   if ModalDWindow <> nil then begin
      if ModalDWindow.Visible then begin
         with ModalDWindow do
            Result := Click (LocalX(X), LocalY(Y));
         exit;
      end else ModalDWindow := nil;
   end;
   if MouseCaptureControl <> nil then begin
      with MouseCaptureControl do
         Result := Click (LocalX(X), LocalY(Y));
   end else
      if DWinList.Count > 0 then //20080629
      for i:=0 to DWinList.Count-1 do begin
         if TDControl(DWinList[i]).Visible then begin
            if TDControl(DWinList[i]).Click (X, Y) then begin
               Result := TRUE;
               break;
            end;
         end;
      end;
end;

procedure TDWinManager.DirectPaint (dsurface: TAsphyreCanvas);
var
   i: integer;
begin
   if DWinList.Count > 0 then //20080629 
   for i:=0 to DWinList.Count-1 do begin
      if TDControl(DWinList[i]).Visible then begin
         TDControl(DWinList[i]).DirectPaint (dsurface);
      end;
   end;
   if ModalDWindow <> nil then begin
      if ModalDWindow.Visible then
         with ModalDWindow do
            DirectPaint (dsurface);
   end;
  if ActiveMenu <> nil then begin
    if ActiveMenu.Visible then
      with ActiveMenu do begin
        DirectPaint(dsurface);
      end;
  end;
end;

{ TDEdit }
constructor TDEdit.Create(AOwner: TComponent);
begin
  inherited Create (AOwner);   //组件创建
  //F3D := true;
  FColor := clWhite;           //字体颜色
  {Width := 30;                //宽度
  Height := 19;                //高度}
  //Cursor := crIBeam;           //光标
  BorderWidth := 2;            //边框宽度
  Font := TFont.Create;        //字体创建
  //FCanGetFocus := true;
  Moveed := False; 
  BlinkSpeed := 20;            //光标闪烁
  FSelCol := clBlue;      //选择颜色
  FText:= '';
  KeyByteCount := 0;
  FMaxLength := 0;
  //FEnableFocus := True;        //是否有焦点
end;
//删除文字
procedure TDEdit.DelSelText;
var s:integer;
begin
  s := selStart;
  if SelStart > SelStop then s := SelStop;
  Delete(FText,S+1,SelCount);
  SelStart := s;
  SelStop := s;
end;
function TDEdit.CopySelText():string;
var
  s:Integer;
begin
  Result := '';
  s := SelStart;
  if SelStart > SelStop then s := SelStop;
  Result := Copy(FText,S+1,SelCount);
end;
//画的方法
procedure TDEdit.DirectPaint(dsurface: TAsphyreCanvas);
function CharRect(dsurface: TAsphyreCanvas; Index: Integer): TRect;
var
  sText: WideString;
  TextBefore: WideString;
  TextAfter: WideString;
  sLeft, sRight: Integer;
begin
     //-------modi by huasoft-------------------------------------
     // (2) Extract part of text prior to selector
    sText := FText;
    TextBefore := '';
    TextAfter := '';
    if (Index > 0) then TextBefore := Copy(sText, 1, Index);
    if (Index >= 0) then TextAfter := Copy(sText, 1, Index + 1);

     // (3) Determine selected position
      sLeft := 0 + AspTextureFont.TextWidth(TextBefore);

      if (TextAfter <> '') and (Index < Length(sText)) then
        sRight := 0 + AspTextureFont.TextWidth(TextAfter)
      else sRight := sLeft + (GHeight div 2);
    //--------------------------------------------------------------------
     // (4) Determine selected rectangle
    Result.Left := sLeft;
    Result.Right := sRight;
    Result.Top := 2;
    Result.Bottom := Height - 2;
end;
var 
    SelStartX:integer;
    SelStopX:integer;
    Ypos:integer;
    sTemPass: string;
    I: Integer;
    RectText: TRect;
    SelRect: TRect;
    ChRect: TRect;
    rgn:{THandle}HRGN;
begin
  if not FTransparent then begin
      dsurface.FillRect(ClientRect, FColor);
  end;
  inherited DirectPaint(dsurface);

    SelStartX := AspTextureFont.TextWidth(copy(FText,1,SelStart));
    SelStopX := AspTextureFont.TextWidth(copy(FText,1,SelStop));
    YPos := ((GHeight) - AspTextureFont.TextHeight(FText)) div 2;
    XDif := 0;
    if SelStopX > GWidth-5 then XDif := SelStopX-GWidth+AspTextureFont.TextWidth('W')*2;
    {*********此函数为选择了某字符而变色*******}
    //showmessage(inttostr(SurfaceX(Left)));
      //Canvas.FillRect(rect(X+SelStartX+1-XDif,Y+borderwidth+1,X+SelStopX+1-XDif,Y+Self.Height-BorderWidth));


    if (SelCount > 0) and (FocusedControl = Self) and Enabled then begin
      RectText := ShortRect(ShrinkRect(ClientRect, 2, 0), ClientRect);
      //if (RectText.Right > RectText.Left) and (RectText.Bottom > RectText.Top) then begin
        SelRect := RectText;
        if SelStart < SelStop then begin
          ChRect := CharRect(dsurface,SelStart);
          SelRect.Left := ClientRect.Left + Max((ChRect.Left), 0);
          ChRect := CharRect(dsurface,SelStop);
          SelRect.Right := ClientRect.Left + Min((ChRect.Left), GWidth) + 2;
        end else begin
          ChRect := CharRect(dsurface,SelStop);
          SelRect.Left := ClientRect.Left + Max((ChRect.Left), 0);
          ChRect := CharRect(dsurface,SelStart);
          SelRect.Right := ClientRect.Left + Min((ChRect.Left), GWidth) + 2;
        end;
        SelRect := ShrinkRect(SelRect, 1, 1);
      //Brush.Color := FSelCol;//FSelCol;
      //FillRect(SelRect);//下边
      dsurface.FillRect(SelRect, FSelCol);

      //end;
    end;
    //Brush.Style := bsClear;
    {******************************************}
    //输出Capiton内容
    if Enabled then begin
      if FPasswordChar = #0 then begin
        AspTextureFont.TextRect(rect(SurfaceX(GLeft),SurfaceY(GTop),SurfaceX(GLeft)+GWidth,SurfaceY(GTop)+GHeight),
            Bounds(0, 0, GWidth, GHeight), SurfaceX(GLeft)+BorderWidth-XDif, SurfaceY(GTop)+YPos + 1,FText, FFont.Color,[]);
        {rect(SurfaceX(GLeft),SurfaceY(GTop),SurfaceX(GLeft)+GWidth,SurfaceY(GTop)+GHeight),
          SurfaceX(GLeft)+BorderWidth-XDif, SurfaceY(GTop)+YPos + 1, FText, FFont.Color,[]);}
      end else begin
        sTemPass := '';
        for i := 1 to length(FText) do sTemPass := sTemPass + '*';
        AspTextureFont.TextRect(rect(SurfaceX(GLeft),SurfaceY(GTop),SurfaceX(GLeft)+GWidth,SurfaceY(GTop)+GHeight),
            Bounds(0, 0, GWidth, GHeight), SurfaceX(GLeft)+BorderWidth-XDif, SurfaceY(GTop)+YPos + 1,sTemPass, FFont.Color,[]);
          //SurfaceX(GLeft)+BorderWidth-XDif, SurfaceY(GTop)+YPos + 1,sTemPass, FFont.Color,[]);
      end;
    end;
    DoMove;
    if (FocusedControl=self) and Enabled then
      if cursorvisible then   //光标是否可见   闪烁用的这个
    begin
      //画光标
     //pen.Color := clWhite;
               //左                               //上                            //右
     //Rectangle(SurfaceX(GLeft)+SelStopX+BorderWidth-XDif,SurfaceY(GTop)+TextHeight('H') div 2 -2,SurfaceX(GLeft)+SelStopX-XDif+BorderWidth+2,SurfaceY(GTop)+GHeight-TextHeight('H') div 2+3);
     dsurface.FillRect(Rect(SurfaceX(GLeft)+SelStopX+BorderWidth-XDif,SurfaceY(GTop)+AspTextureFont.TextHeight('H') div 2 -2,SurfaceX(GLeft)+SelStopX-XDif+BorderWidth+2,SurfaceY(GTop)+GHeight-AspTextureFont.TextHeight('H') div 2+3), clWhite);
    end;
    {//Windows.DeleteObject(rgn);
    //TextOut(SurfaceX(Left)+BorderWidth-XDif,SurfaceY(Top)+YPos,FText);
    //Release;
     {DoMove;
    if (FocusedControl=self) and (cursorvisible) and Enabled then
      if cursorvisible then   //光标是否可见   闪烁用的这个
    begin
      //画光标
     pen.Color := clWhite;
               //左                               //上                            //右
     Rectangle(SurfaceX(GLeft)+SelStopX+BorderWidth-XDif,SurfaceY(GTop)+TextHeight('H') div 2 -2,SurfaceX(GLeft)+SelStopX-XDif+BorderWidth+2,SurfaceY(GTop)+GHeight-TextHeight('H') div 2+3);

    end;
//    UnLock;  
  Release;    }
  {end;  *) }
end;
//光标闪烁函数
procedure TDEdit.DoMove;
begin
  CursorTime := CursorTime + 1;
  If CursorTime > BlinkSpeed then
  begin
    CursorVisible := not CursorVisible;
    CursorTime := 0;
  end;
end;
//得到选择数量
function TDEdit.GetSelCount: integer;
begin
  result := abs(SelStop-SelStart);
end;
//最大输入数量
procedure TDEdit.SetMaxLength(const Value: Integer);
begin
  FMaxLength := Value;

  if (FMaxLength > 0) and (Length(string(FText)) > FMaxLength) then
  begin
    FText := Copy(FText, 1, FMaxLength);
    if (SelStart > Length(string(FText))) then SelStart := Length(string(FText));
  end;
end;

function TDEdit.KeyDown(var Key: Word; Shift: TShiftState): Boolean;
var
  Clipboard: TClipboard;
  AddTx: string;
begin
  //if not FVisible then ReleaseDFocus;
  if not FVisible or not DParent.FVisible then Exit;
  Result := inherited KeyDown(Key, Shift); //处理按键 主程序不执行了按键效果
  if (Result) and (not Background) and Enabled then begin
      //Result := inherited KeyDown(Key, Shift); 
      CursorVisible := true;
      CursorTime := 0;
      if key = VK_BACK then begin
        if SelCount = 0 then begin
          Delete(FText,SelStart,1);
          SelStart := SelStart-1;
          SelStop := SelStart;
        end else begin
          DelSelText;
        end;
        if (Assigned(FOnChange)) then FOnChange(Self);
      end;
      if key = VK_DELETE then begin
        if SelCount = 0 then begin
          Delete(FText,SelStart+1,1);
        end else
          DelSelText;
        if (Assigned(FOnChange)) then FOnChange(Self);
      end;
      if key = VK_LEFT then begin
        if ssShift in Shift then begin
          SelStop := SelStop-1;
        end else begin
          if SelStop < SelStart then begin
            SelStart := SelStop;
          end else begin
            if SelStop > SelStart then begin
              SelStart := SelStop;
            end else begin
              SelStart := SelStart-1;
              SelStop := SelStart;
            end;
          end;
        end;
      end;
      if key = VK_HOME then begin
        if ssShift in Shift then begin
          SelStop := 0;
        end else begin
          SelStart := 0;
          SelStop := 0;
        end;
      end;
      if key = VK_END then begin
        if ssShift in Shift then begin
          SelStop := Length(FText);
        end else begin
          SelStart := Length(FText);
          SelStop := Length(FText);
        end;
      end;
      if key = VK_RIGHT then begin
        if ssShift in Shift then begin
          SelStop := SelStop+1;
        end else begin
          if SelStop < SelStart then begin
            SelStart := SelStop;
          end else begin
            if SelStop > SelStart then begin
              SelStart := SelStop;
            end else begin
              SelStart := SelStart+1;
              SelStop := SelStart;
            end;
          end;
        end;
      end;

      if (Key = Byte('V')) and (ssCtrl in Shift) then begin   //粘贴代码
        Clipboard := TClipboard.Create();
        AddTx := Clipboard.AsText;
        Insert(AddTx, FText, SelStart + 1);
        Inc(SelStart, Length(AddTx));
        if (FMaxLength > 0) and (Length(FText) > FMaxLength) then begin
          FText := Copy(FText, 1, FMaxLength);
          if (SelStart > Length(FText)) then SelStart := Length(FText);
        end;
        SelStop := SelStart;
        Clipboard.Free();
        if (Assigned(FOnChange)) then FOnChange(Self);
      end;

      if (Key = Byte('C')) and (ssCtrl in Shift) then begin   //复制
        Clipboard := TClipboard.Create();
        Clipboard.AsText := CopySelText();
       //Showmessage(CopySelText);
        Clipboard.Free();
      end;

      if SelStart < 0 then SelStart := 0;
      if SelStart > Length(FText) then SelStart := Length(FText);
      if SelStop < 0 then SelStop := 0;
      if SelStop > Length(FText) then SelStop := Length(FText);
  end;
end;

function TDEdit.KeyPress(var Key: Char): Boolean;
begin

  if not FVisible or not DParent.FVisible then Exit;
  if (inherited KeyPress(Key)) and (not Background) then begin
      Result := inherited KeyPress(Key); //处理按键 主程序不执行了按键效果
    if Enabled then begin
      if (ord(key) > 31) and ((ord(key) < 127) or (ord(key) > 159)) then begin
        if SelCount > 0 then DelSelText;

          {if (FMaxLength > 0) and (Length(string(FText)) > FMaxLength) then
          begin
            FText := Copy(FText, 1, FMaxLength);
            if (SelStop > Length(string(FText))) then SelStop := Length(string(FText));
          end;  }

     //--------------By huasoft-------------------------------------------------------
        if ((FMaxLength < 1) or (Length(string(FText)) < FMaxLength)) then begin
        if  IsDBCSLeadByte(Ord(Key)) or boDoubleByte then //判断是否是汉字
        begin
            boDoubleByte :=true;
            Inc(KeyByteCount);          //字节数
            InputStr:=InputStr+ Key;
        end;


        if not boDoubleByte then begin
          if SelStart >= Length(FText) then begin
            FText := FText + Key;
          end else begin
            Insert(Key,FText,SelStart+1);
          end;
          Inc(SelStart);
        end else begin
          if KeyByteCount >= 2 then begin   //字节数为2则为汉字
            if SelStart >= Length(FText) then begin
              FText := FText + InputStr;
            end else begin
              Insert(InputStr,FText,SelStart+1);
            end;
          boDoubleByte := False;
          KeyByteCount := 0;
          InputStr := '';
          Inc(SelStart);
          end;
        end;
          //SelStart := SelStart+1;
          SelStop := SelStart;
        end;
        if (Assigned(FOnChange)) then FOnChange(Self);
      end;
    end;
  end;
end;

function TDEdit.MouseMove(Shift: TShiftState; X, Y: Integer): Boolean;
begin
  if not FVisible or not DParent.FVisible then Exit;
   //if ssLeft in Shift then begin
   Result := inherited MouseMove (Shift, X, Y);
   Moveed := Result;
   if ssLeft in Shift then begin
     if (not Background){ and (not Result)} then begin
        Result := inherited MouseMove (Shift, X, Y);
        if MouseCaptureControl = self then begin
           {if InRange (X, Y) then} SelStop := MouseToSelPos(x-Gleft);
           //else Downed := FALSE;
        end;
     end;
   end;

end;

//这个是鼠标按下的事件   没问题
function TDEdit.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer): Boolean;
begin
  if not FVisible or not DParent.FVisible then Exit;
   Result := FALSE;
   if inherited MouseDown (Button, Shift, X, Y) then begin
      if Enabled then begin
        if (not Background) and (MouseCaptureControl=nil) then begin
           SelStart := MouseToSelPos(x-Gleft);
           SelStop := SelStart;
           SetDCapture (self);
        end;
        Result := TRUE;
      end;
   end;
end;

function TDEdit.MouseToSelPos(AX: integer): integer;
var
  I:integer;
  AX1: Integer;
begin
  Result := length(FText);
  AX1 := AX-Borderwidth+XDif -3;
  if length(FText) <= 0 then begin //2080629
    Exit;
  end;
  for i := 0 to length(FText) do begin
    if Canvas.TextWidth(copy(FText,1,I)) >= AX1 then begin
      Result := I;
      break;
    end;
  end;
end;



procedure TDEdit.Update;
begin
  inherited;

end;


function TDEdit.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer): Boolean;
begin
   Result := FALSE;
   if inherited MouseUp (Button, Shift, X, Y) then begin
      if Enabled then begin
        ReleaseDCapture;
        if not Background then begin
           if InRange (X, Y) then begin
              if Assigned (FOnClick) then FOnClick(self, X, Y);
           end;
        end;
        Result := TRUE;
        exit;
      end;
   end else begin
      ReleaseDCapture;
   end;
end;

procedure TDEdit.SetText (str: Widestring);
begin
   FText := str;
   if csDesigning in ComponentState then begin
      Refresh;
   end;
end;

procedure TDEdit.SetFocus;
begin
  SetDFocus (self);
end;

destructor TDEdit.Destroy;
begin
  Font.Free;
  inherited;
end;

procedure TDEdit.SetPasswordChar(Value: Char);
begin
  if FPasswordChar <> Value then FPasswordChar := Value;
end;

procedure TDEdit.Paint;
begin
  if csDesigning in ComponentState then begin
    with Canvas do begin
      Brush.Color := clWhite;
      FillRect(ClipRect);
      Pen.Color := cl3DDkShadow;
      MoveTo(0, 0);
      LineTo(Width - 1, 0);
      LineTo(Width - 1, Height - 1);
      LineTo(0, Height - 1);
      LineTo(0, 0);
      TextOut((Width - TextWidth(Text)) div 2, (Height - TextHeight(Text)) div 2 - 1, Text);
    end;
  end;
end;

{ TDCheckBox }

(*constructor TDCheckBox.Create(AOwner: TComponent);
begin
   inherited Create (AOwner);
   Moveed := False;
   FChecked := False;
   FOnClick := nil;
   FEnableFocus := TRUE;
   FClickSound := csNone;
end;

{procedure TDCheckBox.DirectPaint(dsurface: TAsphyreCanvas);
begin

end;   }

function TDCheckBox.GetChecked: Boolean;
begin
  Result := FChecked;
end;

procedure TDCheckBox.SetChecked(Value: Boolean);
begin
  if FChecked <> Value then FChecked := Value;
end;

function TDCheckBox.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer): Boolean;
begin
   Result := FALSE;
   if inherited MouseDown (Button, Shift, X, Y) then begin
      if (not Background) and (MouseCaptureControl=nil) then begin
         SetDCapture (self);
      end;
      Result := TRUE;
   end;
end;

function TDCheckBox.MouseMove(Shift: TShiftState; X, Y: Integer): Boolean;
begin
   Result := inherited MouseMove (Shift, X, Y);
   Moveed := Result;
   if (not Background) and (not Result) then
      Result := inherited MouseMove (Shift, X, Y);
end;

function TDCheckBox.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer): Boolean;
begin
   Result := FALSE;
   if inherited MouseUp (Button, Shift, X, Y) then begin
      ReleaseDCapture;
      if not Background then begin
         if InRange (X, Y) then begin
           if Button = mbLeft then begin
            SetChecked(not FChecked);
            if Assigned (FOnClickSound) then FOnClickSound(self, FClickSound);
            if Assigned (FOnClick) then FOnClick(self, X, Y);
           end;
         end;
      end;
      Result := TRUE;
      exit;
   end else begin
      ReleaseDCapture;
   end;
end;   *)

{ TDComboListBox }
{constructor TDComboListBox.Create(AOwner: TComponent);
begin
  inherited Create (AOwner);
  FItems := TStringList.Create();
  FMouseItemIndex := -1;
  FItemIndex := -1;
  Height := 0;
  FItemSize := 20;
end;

destructor TDComboListBox.Destroy;
begin
  FItems.Free;
  inherited;
end;

procedure TDComboListBox.DirectPaint(dsurface: TAsphyreCanvas);
var
  I: Integer;
begin
  inherited DirectPaint(dsurface);
  with dsurface.Canvas do begin
    Brush.style := bssolid;
    Brush.Color := clWindow;
    pen.Color := $007F7F7F;
    Rectangle(SurfaceX(GLeft), SurfaceY(GTop) ,SurfaceX(GLeft)+GWidth,SurfaceY(GTop)+ GHeight);
    if FItems.Count > 0 then begin
      if FMouseItemIndex <> -1 then begin
        Brush.Color := clNavy;
        Pen.Color := clNavy;
        Rectangle(SurfaceX(GLeft)+2, SurfaceY(GTop)+FMouseItemIndex*FItemSize+2 ,SurfaceX(GLeft)+GWidth-2,SurfaceY(GTop)+FMouseItemIndex*FItemSize+FItemSize+2);
      end;
      SetBkMode (Handle, TRANSPARENT);
      for I:=0 to FItems.Count - 1 do begin
        if I <> FMouseItemIndex then Font.Color := clBlack else Font.Color := clWhite;
        TextOut (SurfaceX(GLeft) + 2, SurfaceY(GTop)+I*FItemSize+6, FItems.Strings[I]);
      end;
    end;
    Release;
  end;
end;

function TDComboListBox.GetHeight: Integer;
begin
  Result := 4;
  if FItems.Count > 0 then begin
    Result := FItems.Count * FItemSize + 4;
  end;
end;

function TDComboListBox.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer): Boolean;
begin
  Result := FALSE;
  if inherited MouseDown (Button, Shift, X, Y) then begin
    if (not Background) and (MouseCaptureControl=nil) then begin
       SetDCapture (self);
    end;
    Result := True;
  end;
end;

function TDComboListBox.MouseMove(Shift: TShiftState; X,
  Y: Integer): Boolean;
var
  ss: Integer;
begin
  Result := inherited MouseMove (Shift, X, Y);
  if (not Background) and (not Result) then begin
    Result := inherited MouseMove (Shift, X, Y);
  end else begin
    if FItems.Count >0 then begin
      ss := ((Y - GTop) - 1) div FItemSize;
      if ss >= FItems.Count then ss := FItems.Count - 1;
      if ss <= 0 then ss := 0;
      FMouseItemIndex := ss;
    end else FMouseItemIndex := -1;
  end;
end;

function TDComboListBox.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer): Boolean;
begin
  Result := FALSE;
  if inherited MouseUp (Button, Shift, X, Y) then begin
    ReleaseDCapture;
    if not Background then begin
      if InRange (X, Y) then begin
        if Button = mbLeft then begin
          if Assigned (FOnClick) then FOnClick(self, X, Y);
          if FMouseItemIndex <> - 1 then begin
            FItemIndex:= FMouseItemIndex;
            TDComboBox(DParent).Text := FItems.Strings[FItemIndex];
            FIsDropDown := False;
            FVisible:= False;
            if (Assigned(TDComboBox(DParent).OnChange)) then TDComboBox(DParent).OnChange(DParent);
          end;
          Result := TRUE;
        end;
      end;
    end;
    Result := TRUE;
    Exit;
  end else begin
    ReleaseDCapture;
  end;
end;  }

{ TDComboBox }

{procedure TDComboBox.Clear;
begin
  FListBox.FItems.Clear;
end;

constructor TDComboBox.Create(AOwner: TComponent);
begin
  inherited Create (AOwner);
  FText := 'ComboBox';
  FListBox := TDComboListBox.Create(Self);
  Loaded;
  FListBox.DParent := Self;
  AddChild(FListBox);
  FListBox.Visible := False;
end;

procedure TDComboBox.DesignClick;
begin
  if FListBox <> nil then begin
    if (MouseCaptureControl <> FListBox) and (FListBox.IsDropDown) then begin
      FListBox.IsDropDown := False;
      FListBox.Visible := False;
    end;
  end;
end;

destructor TDComboBox.Destroy;
begin
  FreeAndNil(FListBox);
  inherited;
end;

procedure TDComboBox.DropDown;
begin
  if (FListBox <> nil) and (not FListBox.IsDropDown) then begin
    FListBox.GLeft := 0;
    FListBox.GTop := GHeight;
    FListBox.GWidth := GWidth;
    FListBox.GHeight := FListBox.GetHeight;
    FListBox.FMouseItemIndex := -1;
    FListBox.Visible := True;
    FListBox.IsDropDown := true;
    //FListBox.Focused;
  end;
end;

function TDComboBox.GetItemIndex: integer;
begin
  if FListBox <> nil then
    Result := FListBox.ItemIndex
  else
    Result := -1; 
end;

function TDComboBox.GetItems: TStrings;
begin
  if FListBox <> nil then begin
    Result := FListBox.Items;
  end;
end;

procedure TDComboBox.SetItems(Value: TStrings);
begin
  if FListBox <> nil then begin
    FListBox.Items := Value;
  end;
end;

function TDComboBox.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer): Boolean;
begin
   Result := FALSE;
   if inherited MouseDown (Button, Shift, X, Y) then begin //是到自己的MouseDown事件里了
      if (not Background) and (MouseCaptureControl=nil) then begin
         SetDCapture (self);
      end;
      DropDown;  //打开下拉框
      Result := TRUE;
   end else DesignClick;
end;

function TDComboBox.MouseMove(Shift: TShiftState; X, Y: Integer): Boolean;
begin
   Result := inherited MouseMove (Shift, X, Y);
   Moveed := Result;
   if (not Background) and (not Result) then begin
      if MouseCaptureControl = self then
         if InRange (X, Y) then
          Downed := TRUE
         else
          Downed := FALSE;
   end;
end;

function TDComboBox.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer): Boolean;
begin
   Result := FALSE;
   if inherited MouseUp (Button, Shift, X, Y) then begin
      ReleaseDCapture;
      if not Background then begin
         if InRange (X, Y) then begin
           if Button = mbLeft then begin
            if Assigned (FOnClick) then FOnClick(self, X, Y);
           end;
         end;
      end;
      Result := TRUE;
      exit;
   end else begin
      ReleaseDCapture;
   end;
end;

procedure TDComboBox.SetItemIndex(const Value: integer);
begin
  if Value <> - 1 then begin
    if Value > FListBox.FItems.Count then FListBox.ItemIndex := FListBox.Items.Count - 1
    else FListBox.ItemIndex := Value;
    if FListBox.Items.Count > 0 then
    FText := FListBox.Items.Strings[FListBox.ItemIndex];
  end;
end;   }


{******************************************************************************}
{ TDScrollBarBar }
constructor TDMemoScrollBarBar.Create(AOwner: TComponent);
begin
  inherited Create (AOwner);
  GLeft := 1;
  FTheta:= 0.0; //起始位置
  FItemsHeight := 14;
end;

procedure TDMemoScrollBarBar.DirectPaint(dsurface: TAsphyreCanvas);
var
   d: TAsphyreLockableTexture;
begin
  inherited DirectPaint(dsurface);
  if WLib <> nil then begin //20080701
     d := WLib.Images[FaceIndex];
     if d <> nil then
        dsurface.Draw (SurfaceX(GLeft), SurfaceY(GTop), d.ClientRect, d, TRUE);
  end;

end;

function TDMemoScrollBarBar.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer): Boolean;
begin
   Result := FALSE;
   if inherited MouseDown (Button, Shift, X, Y) then begin
      if (not Background) and (MouseCaptureControl=nil) then begin
         ClickY := y;
         CLickTheta:= FTheta;
         Downed := TRUE;
         SetDCapture (self);
      end;
      Result := TRUE;
   end;
end;

function TDMemoScrollBarBar.MouseMove(Shift: TShiftState; X,
  Y: Integer): Boolean;
var
  AnchorArea: Integer;
begin
  Result := inherited MouseMove (Shift, X, Y);
  if (not Background) and (not Result) then begin
    Result := inherited MouseMove (Shift, X, Y);
  end else if ssLeft in Shift then begin
    if TDMemoScrollBar(DParent).FArrowInc > 0 then begin
      AnchorArea:= (DParent.GHeight) - (TDMemoScrollBar(DParent).BUp.GHeight+TDMemoScrollBar(DParent).BDown.GHeight+GHeight); //块的范围
      movebar(CLickTheta + (Y-ClickY)/AnchorArea);
    end;
  end;
end;

function TDMemoScrollBarBar.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer): Boolean;
begin
   Result := FALSE;
   if inherited MouseUp (Button, Shift, X, Y) then begin
      ReleaseDCapture;
      if not Background then begin
         if InRange (X, Y) then begin
            if mbLeft = Button then begin  //20090212修改右键点控件不好使
              if Assigned (FOnClick) then FOnClick(self, X, Y);
            end;
         end;
      end;
      Downed := FALSE;
      Result := TRUE;
      exit;
   end else begin
      ReleaseDCapture;
      Downed := FALSE;
   end;
end;

procedure TDMemoScrollBarBar.Movebar(nposy: Real);
var
 AnchorArea,ElemCount: Integer;
begin
  ElemCount:= (DParent.DParent.GHeight - 2) div FItemsHeight;  //一共能显示几行
  AnchorArea:= DParent.GHeight - (TDMemoScrollBar(DParent).BUp.GHeight+TDMemoScrollBar(DParent).BDown.GHeight+GHeight+1);  //滑块范围
  FTheta := Max(Min(nposy, 1.0), 0.0);
  if Assigned(TDMemoScrollBar(DParent).OnChange) then TDMemoScrollBar(DParent).OnChange(TDMemoScrollBar(DParent));
  GTop := {DParent.Top +}TDMemoScrollBar(DParent).BUp.GTop + TDMemoScrollBar(DParent).BUp.GHeight + TDMemoScrollBar(DParent).BDown.GHeight + 3 - GHeight + Round(FTheta * AnchorArea);  //滑块位置
end;


{ TDScrollBarUp }

constructor TDMemoScrollBarUp.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Downed := False;
  GLeft := 1;
end;

procedure TDMemoScrollBarUp.DirectPaint(dsurface: TAsphyreCanvas);
var
   d: TAsphyreLockableTexture;
begin
  inherited DirectPaint(dsurface);
  if WLib <> nil then begin //20080701
    if not Downed then
      d := WLib.Images[FaceIndex]
    else d := WLib.Images[FaceIndex+1];
     if d <> nil then
        dsurface.Draw (SurfaceX(GLeft), SurfaceY(GTop), d.ClientRect, d, TRUE);
  end;
end;

function TDMemoScrollBarUp.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer): Boolean;
begin
   Result := FALSE;
   if inherited MouseDown (Button, Shift, X, Y) then begin
      if (not Background) and (MouseCaptureControl=nil) then begin
        if mbLeft = Button then begin
          Downed := TRUE;
          SetDCapture (self);
          TDMemoScrollBar(DParent).Bar.MoveBar(TDMemoScrollBar(DParent).Theta-TDMemoScrollBar(DParent).FArrowInc);
        end;
      end;
      Result := TRUE;
   end;
end;

function TDMemoScrollBarUp.MouseMove(Shift: TShiftState; X,
  Y: Integer): Boolean;
begin
   Result := inherited MouseMove (Shift, X, Y);
   if (not Background) and (not Result) then begin
      Result := inherited MouseMove (Shift, X, Y);
      if MouseCaptureControl = self then
         if InRange (X, Y) then
          Downed := TRUE
         else
          Downed := FALSE;
   end;
end;

function TDMemoScrollBarUp.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer): Boolean;
begin
   Result := FALSE;
   if inherited MouseUp (Button, Shift, X, Y) then begin
      ReleaseDCapture;
      if not Background then begin
         if InRange (X, Y) then begin
            if mbLeft = Button then begin  //20090212修改右键点控件不好使
              //if Assigned (FOnClickSound) then FOnClickSound(self, FClickSound);
              //if Assigned (FOnClick) then FOnClick(self, X, Y);
            end;
         end;
      end;
      Downed := FALSE;
      Result := TRUE;
      exit;
   end else begin
      ReleaseDCapture;
      Downed := FALSE;
   end;
end;

{ TDScrollBardown }
constructor TDMemoScrollBardown.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Downed := False;
  GLeft := 1;
end;


procedure TDMemoScrollBardown.DirectPaint(dsurface: TAsphyreCanvas);
var
   d: TAsphyreLockableTexture;
begin
  inherited DirectPaint(dsurface);
  if WLib <> nil then begin //20080701
    if not Downed then
      d := WLib.Images[FaceIndex]
    else d := WLib.Images[FaceIndex+1];
     if d <> nil then
        dsurface.Draw (SurfaceX(GLeft), SurfaceY(GTop), d.ClientRect, d, TRUE);
  end;
end;

function TDMemoScrollBardown.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer): Boolean;
begin
   Result := FALSE;
   if inherited MouseDown (Button, Shift, X, Y) then begin
      if (not Background) and (MouseCaptureControl=nil) then begin
        if mbLeft = Button then begin
          Downed := TRUE;
          SetDCapture (self);
          TDMemoScrollBar(DParent).Bar.MoveBar(TDMemoScrollBar(DParent).Theta+TDMemoScrollBar(DParent).FArrowInc);
        end;
      end;
      Result := TRUE;
   end;
end;

function TDMemoScrollBardown.MouseMove(Shift: TShiftState; X,
  Y: Integer): Boolean;
begin
   Result := inherited MouseMove (Shift, X, Y);
   if (not Background) and (not Result) then begin
      Result := inherited MouseMove (Shift, X, Y);
      if MouseCaptureControl = self then
         if InRange (X, Y) then
          Downed := TRUE
         else
          Downed := FALSE;
   end;
end;

function TDMemoScrollBardown.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer): Boolean;
begin
   Result := FALSE;
   if inherited MouseUp (Button, Shift, X, Y) then begin
      ReleaseDCapture;
      if not Background then begin
         if InRange (X, Y) then begin
            if mbLeft = Button then begin  //20090212修改右键点控件不好使
              //if Assigned (FOnClickSound) then FOnClickSound(self, FClickSound);
              //if Assigned (FOnClick) then FOnClick(self, X, Y);
            end;
         end;
      end;
      Downed := FALSE;
      Result := TRUE;
      exit;
   end else begin
      ReleaseDCapture;
      Downed := FALSE;
   end;
end;

{ TDScrollBar }
constructor TDMemoScrollBar.Create(AOwner: TComponent);
begin
  inherited Create (AOwner);
  Bar := TDMemoScrollBarbar.create(Self);
  BUp := TDMemoScrollBarUp.create(Self);
  Bdown := TDMemoScrollBarDown.create(Self);
  Bar.DParent := Self;
  BUp.DParent := Self;
  BDown.DParent := Self;
  AddChild(Bar);
  AddChild(BUp);
  AddChild(BDown);
  FArrowInc:= 0.1;
  FPageInc := 0.25;
end;

destructor TDMemoScrollBar.Destroy;
begin
  FreeAndNil(Bar);
  FreeAndNil(BUp);
  FreeAndNil(Bdown);
  inherited;
end;

function TDMemoScrollBar.GetBarTheta: Real;
begin
  Result := Bar.FTheta;
end;

function TDMemoScrollBar.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer): Boolean;
var
  AnchorArea: Integer;
begin
   Result := FALSE;
   if inherited MouseDown (Button, Shift, X, Y) then begin
      if (not Background) and (MouseCaptureControl=nil) then begin
         if mbLeft = Button then begin
           Downed := TRUE;
           AnchorArea:= (GHeight) - (BUp.GHeight+BDown.GHeight); //块的范围
           if (Y > Bar.GTop+Bar.GHeight) then Bar.Movebar(Bar.FTheta + FPageInc);
           if (Y < Bar.GTop) then Bar.Movebar(Bar.FTheta - FPageInc);
           SetDCapture (self);
         end;
      end;
      Result := TRUE;
   end;
end;

function TDMemoScrollBar.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer): Boolean;
begin
   if inherited MouseUp (Button, Shift, X, Y) then begin
      ReleaseDCapture;
      if not Background then begin
         if InRange (X, Y) then begin
            if mbLeft = Button then begin  //20090212修改右键点控件不好使
              if Assigned (FOnClick) then FOnClick(self, X, Y);
            end;
         end;
      end;
      Downed := FALSE;
      Result := TRUE;
      exit;
   end else begin
      ReleaseDCapture;
      Downed := FALSE;
   end;
end;

{******************************************************************************}
{ TDMemo }
constructor TDMemo.Create(AOwner: TComponent);
begin
  inherited Create (AOwner);
  FLines := TStringList.Create;
  FLinesHeight := 14; //每行高度
  DScroll := nil;
end;

destructor TDMemo.Destroy;
begin
  FreeAndNil(FLines);
  inherited;
end;

procedure TDMemo.SetLines(Value: TStringList);
begin
  FLines.Assign(Value);
end;

{procedure TDControl.DesignClick;
begin

end;}

procedure TDMemo.SetLinesHeight(Value: Integer);
begin
  FLinesHeight := Value;
  DScroll.Bar.FItemsHeight := Value;
end;

function TDControl.GetClientRect: TRect;
begin
  Result.Left := SurfaceX(GLeft);
  Result.Top := SurfaceY(GTop);
  Result.Right := Result.Left + GWidth;
  Result.Bottom := Result.Top + GHeight;
end;
//--------------为容器控件添加begin-------------------
{ TDImageIndex }
constructor TDImageIndex.Create;
begin
  inherited;
  FUp := -1;
  FDown := -1;
  FHot := -1;
  FDisabled := -1;
end;

procedure TDImageIndex.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TDImageIndex then begin
    FUp := TDImageIndex(Source).Up;
    FDown := TDImageIndex(Source).Down;
    FHot := TDImageIndex(Source).Hot;
    FDisabled := TDImageIndex(Source).Disabled;
    Changed;
  end;
end;

procedure TDImageIndex.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TDImageIndex.SetDisabled(Value: Integer);
begin
  if FDisabled <> Value then begin
    FDisabled := Value;
    Changed;
  end;
end;

procedure TDImageIndex.SetDown(Value: Integer);
begin
  if FDown <> Value then begin
    FDown := Value;
    Changed;
  end;
end;

procedure TDImageIndex.SetHot(Value: Integer);
begin
  if FHot <> Value then begin
    FHot := Value;
    Changed;
  end;
end;

procedure TDImageIndex.SetUp(Value: Integer);
begin
  if FUp <> Value then begin
    FUp := Value;
    Changed;
  end;
end;
//--------------为容器控件添加End-------------------

{ TDMapMini }

constructor TDMapMini.Create(AOwner: TComponent);
begin
   inherited Create (AOwner);
   FEnableFocus := False;
   Downed := False;
end;

function TDMapMini.MouseMove(Shift: TShiftState; X, Y: Integer): Boolean;
begin
  Result := inherited MouseMove (Shift, X, Y);
  Moveed := Result;
  if (not Background) and (not Result) then begin
    Result := inherited MouseMove (Shift, X, Y);
    if MouseCaptureControl = self then begin
      if InRange (X, Y) then begin
        Downed := TRUE;
        Moveed := False;
      end else Downed := FALSE;
    end;
  end;
end;

function TDControl.GetMouseMove: Boolean;
begin
  Result := MouseMoveControl = Self;
end;

{ TDCustomControl }
{
procedure TDCustomControl.AdjustClientRect(var Rect: TRect);
begin
  inherited AdjustClientRect(Rect);
  Canvas.Font := Font;
  Inc(Rect.Top, Canvas.TextHeight('0'));
  InflateRect(Rect, -1, -1);
  if Ctl3D then InflateRect(Rect, -1, -1);
end;

procedure TDCustomControl.CMCtl3DChanged(var Message: TMessage);
begin
  inherited;
  Invalidate;
  Realign;
end;

procedure TDCustomControl.CMDialogChar(var Message: TCMDialogChar);
begin
  with Message do
    if IsAccel(CharCode, Caption) and CanFocus then
    begin
      SelectFirst;
      Result := 1;
    end else
      inherited;
end;

procedure TDCustomControl.CMTextChanged(var Message: TMessage);
begin
  Invalidate;
  Realign;
end;

constructor TDCustomControl.Create(AOwner: TComponent);
begin
  inherited Create(aowner);
  ControlStyle := [csAcceptsControls, csCaptureMouse, csClickEvents,
    csSetCaption, csDoubleClicks, csReplicatable, csParentBackground];
  Width := 60;
  Height := 30;
end;

procedure TDCustomControl.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params.WindowClass do
    Style := Style and not (CS_HREDRAW or CS_VREDRAW);
end;

procedure TDCustomControl.WMSize(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;  }

end.
