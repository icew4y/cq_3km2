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
unit AspDWinCtl;

interface

uses
  Windows, Classes, Graphics, Controls, AbstractCanvas, AbstractTextures,
  AsphyreTextureFonts,
  AspWil, Clipbrd, SysUtils, Math, uMyDxUnit;

type
  TButtonStyle = (bsButton, bsRadio, bsCheckBox);
  TClickSound = (csNone, csStone, csGlass, csNorm);
  TAspDGridDrawState = (gdNone, gdSelected, gdMoved);
  TAspDControl = class;
  TAspDPageControl = class;
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
  TOnGridPaint = procedure(Sender: TObject; ACol, ARow: integer; Rect: TRect; State: TAspDGridDrawState; dsurface: TAsphyreCanvas) of object;
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
  TAspDControl = class (TCustomControl)
  private
    FCaption: string;      //0x1F0
    FDParent: TAspDControl;   //0x1F4
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
    function  GetMouseMove: Boolean;
    procedure SetCaption (str: string);
    function  GetClientRect: TRect; override;
    procedure SetDParent(Value: TAspDControl);
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
    WLib: TAspWMImages;     //0x254
    FaceIndex: integer;  //0x258
    WantReturn: Boolean; //Background老锭, Click狼 荤侩 咯何..
    constructor Create (AOwner: TComponent); override;
    destructor Destroy; override;

    procedure BringToFront;
    procedure Paint; override;
    procedure Loaded; override;
    procedure UnLoaded;
    function  SurfaceX (x: integer): integer;
    function  SurfaceY (y: integer): integer;
    function  LocalX (x: integer): integer;
    function  LocalY (y: integer): integer;
    procedure AddChild (dcon: TAspDControl);
    procedure ChangeChildOrder (dcon: TAspDControl);
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
    procedure SetImgIndex (Lib: TAspWMImages; index: integer); virtual;
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
    property DParent: TAspDControl read FDParent write SetDParent;
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
    property Enabled;
  end;

  TAspDButton = class (TAspDControl)
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

  TAspDGrid = class (TAspDControl)
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

  TAspDWindow = class (TAspDButton)
  private
    FFloating: Boolean;
    //FboInitialize: Boolean; 
    FDPageControl: TAspDPageControl;

    procedure SetDPageControl(Value: TAspDPageControl);
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
    property DPageControl: TAspDPageControl read FDPageControl write SetDPageControl;
  end;

  TAspDPageControl = class(TAspDWindow)
  private
    FOnChange: TNotifyEvent;
    FActivePage: Integer;
    FTabRect: TRect;
    FTabGRect: TRect;
    procedure SetActivePage(Value: Integer);

    procedure SetTabLeft(Value: Integer);
    function GetTabLeft: Integer;

    function GetTabTop: Integer;
    procedure SetTabTop(Value: Integer);

    function GetTabWidth: Integer;
    procedure SetTabWidth(Value: Integer);

    function GetTabHeight: Integer;
    procedure SetTabHeight(Value: Integer);

    procedure SetTabGLeft(Value: Integer);
    function GetTabGLeft: Integer;

    function GetTabGTop: Integer;
    procedure SetTabGTop(Value: Integer);

    function GetTabGWidth: Integer;
    procedure SetTabGWidth(Value: Integer);

    function GetTabGHeight: Integer;
    procedure SetTabGHeight(Value: Integer);
  protected

  public
    Tabs: TList;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Add(D: TAspDControl);
    procedure Delete(D: TAspDControl);
  published
    property ActivePage: Integer read FActivePage write SetActivePage;
    property TabLeft: Integer read GetTabLeft write SetTabLeft;
    property TabTop: Integer read GetTabTop write SetTabTop;
    property TabWidth: Integer read GetTabWidth write SetTabWidth;
    property TabHeight: Integer read GetTabHeight write SetTabHeight;
    property TabGLeft: Integer read GetTabGLeft write SetTabGLeft;
    property TabGTop: Integer read GetTabGTop write SetTabGTop;
    property TabGWidth: Integer read GetTabGWidth write SetTabGWidth;
    property TabGHeight: Integer read GetTabGHeight write SetTabGHeight;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TAspDWinManager = class (TComponent)
  private
  public
    DWinList: TList; //list of TAspDControl;
    constructor Create (AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AddDControl (dcon: TAspDControl; visible: Boolean);
    procedure DelDControl (dcon: TAspDControl);
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


  TAspDEdit = class(TAspDControl)
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

    SelStop:integer;
    FReadOnly : Boolean;
    procedure DoMove; //光标闪烁
    procedure DelSelText;
    function CopySelText():string;
    procedure SetText (str: Widestring);
    procedure SetMaxLength(const Value: Integer);
    procedure SetSelLength(Value: Integer);
    function GetSelLength: Integer;
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
    SelStart:integer;
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
    property ReadOnly : Boolean read FReadOnly write FReadOnly;
    property Color:TColor read FColor write FColor;
    property SelLength :Integer read GetSelLength write SetSelLength;
    property SelectionColor:TColor read FSelCol write FSelCol;
    property Transparent:boolean read FTransparent write FTransparent;
    property PasswordChar: Char read FPasswordChar write SetPasswordChar default #0;
  end;

  //增加DEdit菜单支持By TasNat at: 2012-06-30 15:46:33
  TAspDEditMenuProc = procedure (DEdit : TAspDEdit);
  TAspDEditMenu = class(TAspDControl)
    DEdit : TAspDEdit;
    Menus : TStringList;              
  public
    FocusItemIndex : Integer;//鼠标所在项
    ItemHeight : DWord;
    XX, YY : Integer;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DirectPaint (dsurface: TAsphyreCanvas); override;
    function MouseMove (Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
    procedure Popup(ADEdit : TAspDEdit; X, Y: Integer);
  end;

{  TDCheckBox = class (TAspDControl)
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
  {TDComboListBox = class (TAspDControl)
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
  {TDComboBox = class(TAspDControl)
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
  TAspDMemoScrollBarBar = class(TAspDControl)        
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

  TAspDMemoScrollBarUp = class(TAspDControl)
    public
      Downed: Boolean;
      constructor Create (AOwner: TComponent); override;
      procedure DirectPaint (dsurface: TAsphyreCanvas); override;
      function MouseUp (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
      function MouseMove (Shift: TShiftState; X, Y: Integer): Boolean; override;
      function MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
  end;

  TAspDMemoScrollBardown = class(TAspDControl)
    public
      Downed: Boolean;
      constructor Create (AOwner: TComponent); override;
      procedure DirectPaint (dsurface: TAsphyreCanvas); override;
      function MouseUp (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
      function MouseMove (Shift: TShiftState; X, Y: Integer): Boolean; override;
      function MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
  end;

  TAspDMemoScrollBar = class(TAspDControl)
    private
      FOnChange: TOnChange;
      function GetBarTheta():Real;
    public
      Downed: Boolean;
      BUp : TAspDMemoScrollBarUp;
      BDown : TAspDMemoScrollBarDown;
      Bar : TAspDMemoScrollBarBar;
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
  
  TDScrollBox = class(TAspDControl)
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
  TAspDMemo = class(TAspDButton)
    private
      FLines: TStringList;
      FLinesHeight: Integer;
      procedure SetLines(Value: TStringList);
      procedure SetLinesHeight(Value: Integer);
    public
      DScroll : TAspDMemoScrollBar;
      constructor Create (AOwner: TComponent); override;
      destructor Destroy; override;
      property Lines: TStringList read FLines write SetLines;
      property LinesHeight: Integer read FLinesHeight write SetLinesHeight;
    end;

  TAspDMapMini = class (TAspDButton)  //小地图专用控件
  public
    Moveed: Boolean;
    constructor Create (AOwner: TComponent); override;
    function  MouseMove (Shift: TShiftState; X, Y: Integer): Boolean; override;
  end;

procedure Register;
procedure SetDFocus (dcon: TAspDControl);
procedure ReleaseDFocus;
procedure SetDCapture (dcon: TAspDControl);
procedure ReleaseDCapture;

function ShortRect(const Rect1, Rect2: TRect): TRect;
//--------------为容器控件添加begin-------------------
function MoveRect(const Rect: TRect; const Point: TPoint): TRect;
//--------------为容器控件添加End---------------------
var
  MouseCaptureControl: TAspDControl; //mouse message
  FocusedControl: TAspDControl; //Key message
  MouseMoveControl: TAspDControl;
  MainWinHandle: integer;
  ModalDWindow: TAspDControl;
implementation
uses uAspDPopupMenu;

procedure Register;
begin
   RegisterComponents('AspMirGame', [TAspDWinManager, TAspDControl, TAspDButton, TAspDGrid, TAspDWindow, TAspDEdit, {TDCheckBox, TDComboBox,} TAspDMemo, TAspDMemoScrollBar, TAspDMapMini, TAspDPageControl]);
end;
var
  lDEditMenu : TAspDEditMenu;

//--------------为容器控件添加begin-------------------
function MoveRect(const Rect: TRect; const Point: TPoint): TRect;
begin
  Result.Left := Rect.Left + Point.X;
  Result.Top := Rect.Top + Point.Y;
  Result.Right := Rect.Right + Point.X;
  Result.Bottom := Rect.Bottom + Point.Y;
end;

//---------------------------------------------------------------------------
function ShortRect(const Rect1, Rect2: TRect): TRect;
begin
  Result.Left := Max(Rect1.Left, Rect2.Left);
  Result.Top := Max(Rect1.Top, Rect2.Top);
  Result.Right := Min(Rect1.Right, Rect2.Right);
  Result.Bottom := Min(Rect1.Bottom, Rect2.Bottom);
end;

procedure SetDFocus (dcon: TAspDControl);
begin
   FocusedControl := dcon;
end;

procedure ReleaseDFocus;
begin
   FocusedControl := nil;
end;

procedure SetDCapture (dcon: TAspDControl);
begin
   //SetCapture (MainWinHandle);
   MouseCaptureControl := dcon;
end;

procedure ReleaseDCapture;
begin
   //ReleaseCapture;
   MouseCaptureControl := nil;
end;


{----------------------------- TAspDControl -------------------------------}

constructor TAspDControl.Create (AOwner: TComponent);
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

destructor TAspDControl.Destroy;
var
  I: Integer;
  dcon: TAspDControl;
begin
  if Self = MouseMoveControl then MouseMoveControl := nil;
  DControls.Free;
  if DParent <> nil then
    for I := DParent.DControls.Count - 1 downto 0 do begin
      dcon := TAspDControl(DParent.DControls.Items[I]);
      if dcon = Self then begin
        DParent.DControls.Delete(I);
        Break;
      end;
    end;
  inherited Destroy;
end;

procedure TAspDControl.BringToFront;
var
  I: Integer;
begin
  if not ((Self is TAspDWindow) or (Self is TAspDPageControl)) then Exit;
  if DParent <> nil then begin
    for I := 0 to DParent.DControls.Count - 1 do begin
      if Self = DParent.DControls[I] then begin
        DParent.DControls.Delete(I);
        Break;
      end;
    end;
    DParent.DControls.Add(Self);
  end;
end;

function TAspDControl.Focused: Boolean;  //20080624
begin
  if FocusedControl = Self then Result := True
  else Result := False;
end;

procedure TAspDControl.SetCaption (str: string);
begin
   FCaption := str;
   if csDesigning in ComponentState then begin
      Refresh;
   end else CaptionChaged;
end;

procedure TAspDControl.SetDParent(Value: TAspDControl);
var
  I: Integer;
begin
{  if csDesigning in ComponentState then begin
    Parent := Value;
  end;}
  if Value <> FDParent then begin
    if FDParent <> nil then UnLoaded;
    FDParent := Value;
    if FDParent <> nil then begin
      //SetCanvas(FDParent.Canvas);
      for I := 0 to FDParent.DControls.Count - 1 do
        if Self = FDParent.DControls[I] then Exit;
      //FDParent.DControls.Add(Self);
      FDParent.AddChild(Self);

    end;
  end;
end;

procedure TAspDControl.UnLoaded;
var
  I: Integer;
  dcon: TAspDControl;
begin
  if DParent <> nil then
    for I := DParent.DControls.Count - 1 downto 0 do begin
      dcon := TAspDControl(DParent.DControls.Items[I]);
      if dcon = Self then begin
        DParent.DControls.Delete(I);
      end;
    end;
end;

procedure TAspDControl.Paint;
begin
   if csDesigning in ComponentState then begin
      if self is TAspDWindow then begin
         with Canvas do begin
            Brush.Color := Color;
            FillRect(ClipRect);
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
            Brush.Color := Color;
            FillRect(ClipRect);
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

procedure TAspDControl.Process;
var
  I: Integer;
begin
  if Assigned(FOnProcess) then FOnProcess(Self);
  for I := 0 to DControls.Count - 1 do
    if TAspDControl(DControls[I]).Visible then
      TAspDControl(DControls[I]).Process;
end;

procedure TAspDControl.Loaded;
{var
   i: integer;
   dcon: TAspDControl;}
begin
   {if not (csDesigning in ComponentState) then begin
      if Parent <> nil then
         if TControl(Parent).ComponentCount > 0 then //20080629
         for i:=0 to TControl(Parent).ComponentCount-1 do begin
            if TControl(Parent).Components[i] is TAspDControl then begin
               dcon := TAspDControl(TControl(Parent).Components[i]);
               if dcon.DParent = self then begin
                  AddChild (dcon);
               end;
            end;
         end;
   end;}

   inherited;
end;

//瘤开 谅钎甫 傈眉 谅钎肺 官厕
function  TAspDControl.SurfaceX (x: integer): integer;
var
   d: TAspDControl;
begin
   d := self;
   while TRUE do begin
      if d.DParent = nil then break;
      x := x + d.DParent.GLeft;
      d := d.DParent;
   end;
   Result := x;
end;

function  TAspDControl.SurfaceY (y: integer): integer;
var
   d: TAspDControl;
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
function  TAspDControl.LocalX (x: integer): integer;
var
   d: TAspDControl;
begin
   d := self;
   while TRUE do begin
      if d.DParent = nil then break;
      x := x - d.DParent.GLeft;
      d := d.DParent;
   end;
   Result := x;
end;

function  TAspDControl.LocalY (y: integer): integer;
var
   d: TAspDControl;
begin
   d := self;
   while TRUE do begin
      if d.DParent = nil then break;
      y := y - d.DParent.GTop;
      d := d.DParent;
   end;
   Result := y;
end;

procedure TAspDControl.AddChild (dcon: TAspDControl);
begin
   DControls.Add (Pointer (dcon));
end;

procedure TAspDControl.ChangeChildOrder (dcon: TAspDControl);
var
   i: integer;
begin
   if not (dcon is TAspDWindow) then exit;
   //if TAspDWindow(dcon).Floating then begin  //20081024修改
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

procedure TAspDControl.Initialize;
var
  I: Integer;
begin
  if Assigned (FOnInitialize) then begin
    FOnInitialize(Self);
  end;
end;

function  TAspDControl.InRange (x, y: integer): Boolean;
var
   linrange: Boolean;
   d: TAsphyreLockableTexture;
begin
   if (x >= GLeft) and (x < GLeft+GWidth) and (y >= GTop) and (y < GTop+GHeight) then begin
      linrange := TRUE;
      if Assigned (FOnInRealArea) then
         FOnInRealArea(self, x-GLeft, y-GTop, linrange)
      else
         if WLib <> nil then begin
            d := WLib.Images[FaceIndex];
            if d <> nil then
             linrange := CheckTextureAlpha(d, X - GLeft, Y - GTop);

         end;
      Result := linrange;
   end else
      Result := FALSE;
end;

function  TAspDControl.KeyPress (var Key: Char): Boolean;
var
   i: integer;
begin
   Result := FALSE;
   if Background then exit;
   if DControls.Count > 0 then //20080629
   for i:=DControls.Count-1 downto 0 do
      if TAspDControl(DControls[i]).Visible then
         if TAspDControl(DControls[i]).KeyPress(Key) then begin
            Result := TRUE;
            exit;
         end;
   if (FocusedControl=self) then begin
      if Assigned (FOnKeyPress) then FOnKeyPress (self, Key);
      Result := TRUE;
   end;
end;

function  TAspDControl.KeyDown (var Key: Word; Shift: TShiftState): Boolean;
var
   i: integer;
begin
   Result := FALSE;
   if Background then exit;
   if DControls.Count > 0 then //20080629
   for i:=DControls.Count-1 downto 0 do
      if TAspDControl(DControls[i]).Visible then
         if TAspDControl(DControls[i]).KeyDown(Key, Shift) then begin
            Result := TRUE;
            exit;
         end;
   if (FocusedControl=self) then begin
      if Assigned (FOnKeyDown) then FOnKeyDown (self, Key, Shift);
      Result := TRUE;
   end;
end;

function  TAspDControl.CanFocusMsg: Boolean;
begin
   if (MouseCaptureControl = nil) or ((MouseCaptureControl <> nil) and ((MouseCaptureControl=self) or (MouseCaptureControl=DParent))) then
      Result := TRUE
   else
      Result := FALSE;
end;

procedure TAspDControl.CaptionChaged;
begin

end;

function  TAspDControl.MouseMove (Shift: TShiftState; X, Y: Integer): Boolean;
var
  i: integer;
begin
   Result := FALSE;
   if DControls.Count > 0 then //20080629
   for i:=DControls.Count-1 downto 0 do
      if TAspDControl(DControls[i]).Visible then
         if TAspDControl(DControls[i]).MouseMove(Shift, X-GLeft, Y-GTop) then begin
            Result := TRUE;
            Exit;
         end;

   if (MouseCaptureControl <> nil) then begin //MouseCapture 捞搁 磊脚捞 快急
      if (MouseCaptureControl = self) then begin
        if Self is TAspDMapMini then begin  //小地图
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

function  TAspDControl.MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
var
   I: integer;
  // boMouseDown: Boolean; //20090424
begin
   Result := FALSE;
  // boMouseDown := False;
   if DControls.Count > 0 then //20080629
   for i:=DControls.Count-1 downto 0 do
      if TAspDControl(DControls[i]).Visible then begin
         if TAspDControl(DControls[i]).MouseDown(Button, Shift, X-GLeft, Y-GTop) then begin
            //TAspDControl(DControls[i]).DesignClick;
            Result := TRUE;
            //boMouseDown := True;
            Exit; //点TAspDWindow控件Combobox下拉框不隐藏是这的问题
                  //原理：点击TAspDWindow他会把他自己在DControls列表位置转移到最后  而这里循环是downto 所以查到点了他 就退出了
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
        if Self is TAspDMapMini then begin  //小地图
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

function  TAspDControl.MouseUp (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
var
   i: integer;
begin
   Result := FALSE;             // add by liuzhigang on 2011-12-01 主要是为了防止按下后再移动的过程中触发其他事件.
   if (DControls.Count > 0) and (MouseCaptureControl<>Self) then //20080629
   begin
     for i:=DControls.Count-1 downto 0 do
        if TAspDControl(DControls[i]).Visible then
           if TAspDControl(DControls[i]).MouseUp(Button, Shift, X-GLeft, Y-GTop) then begin
              Result := TRUE;
              exit;
           end;
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

function  TAspDControl.DblClick (X, Y: integer): Boolean;
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
      if TAspDControl(DControls[i]).Visible then
         if TAspDControl(DControls[i]).DblClick(X-GLeft, Y-GTop) then begin
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

function  TAspDControl.Click (X, Y: integer): Boolean;
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
      if TAspDControl(DControls[i]).Visible then
         if TAspDControl(DControls[i]).Click(X-GLeft, Y-GTop) then begin
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


procedure TAspDControl.SetImgIndex (Lib: TAspWMImages; index: integer);
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

procedure TAspDControl.SetVisible(flag: Boolean);
var
  I: Integer;
begin
  if flag then begin
    if not FboInitialize and (ComponentState * [csReading, csLoading] = []) then begin
      if DControls.Count > 0 then begin
        for I:=0 to DControls.Count - 1 do begin
          TAspDControl(DControls[I]).Visible := TAspDControl(DControls[I]).Visible;
        end;
      end;
      Initialize;
      FboInitialize := True;
    end;
  end;
  FVisible := flag;
end;

procedure TAspDControl.DirectPaint (dsurface: TAsphyreCanvas);
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
    if TAspDControl(DControls[i]).Visible then
      TAspDControl(DControls[i]).DirectPaint (dsurface);
end;
{--------------------- TAspDButton --------------------------}


constructor TAspDButton.Create (AOwner: TComponent);
begin
   inherited Create (AOwner);
   Downed := FALSE;
   FOnClick := nil;
   FEnableFocus := TRUE;
   FClickSound := csNone;
end;

function  TAspDButton.MouseMove (Shift: TShiftState; X, Y: Integer): Boolean;
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

function  TAspDButton.MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
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

function  TAspDButton.MouseUp (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
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

{------------------------- TAspDGrid --------------------------}

constructor TAspDGrid.Create (AOwner: TComponent);
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

function  TAspDGrid.GetColRow (x, y: integer; var acol, arow: integer): Boolean;
begin
   Result := FALSE;
   if InRange (x, y) then begin
      acol := (x-GLeft) div FColWidth;
      arow := (y-GTop) div FRowHeight;
      Result := TRUE;
   end;
end;

function  TAspDGrid.MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
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

function  TAspDGrid.MouseMove (Shift: TShiftState; X, Y: Integer): Boolean;
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

function  TAspDGrid.MouseUp (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
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

function  TAspDGrid.Click (X, Y: integer): Boolean;
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

procedure TAspDGrid.DirectPaint (dsurface: TAsphyreCanvas);
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


{--------------------- TAspDWindown --------------------------}


constructor TAspDWindow.Create (AOwner: TComponent);
begin
   inherited Create (AOwner);
   FFloating := FALSE;
   FboInitialize := False;
   FEnableFocus := TRUE;
   Width := 120;
   Height := 120;
   FDPageControl := nil;
end;

procedure TAspDWindow.SetDPageControl(Value: TAspDPageControl);
begin
  if FDPageControl <> Value then begin
    if FDPageControl <> nil then
      FDPageControl.Delete(Self);
    FDPageControl := Value;
    FDPageControl.Add(Self);
    FDPageControl.ActivePage := FDPageControl.Tabs.Count - 1;
  end;
end;

procedure TAspDWindow.SetVisible (flag: Boolean);
begin
  inherited SetVisible(flag);
  if Floating then begin
    if DParent <> nil then
       DParent.ChangeChildOrder (self);
  end;
end;

function  TAspDWindow.MouseMove (Shift: TShiftState; X, Y: Integer): Boolean;
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

function  TAspDWindow.MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
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

function  TAspDWindow.MouseUp (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
begin
  Result := inherited MouseUp (Button, Shift, X, Y);
end;

procedure TAspDWindow.Show;
begin
   Visible := TRUE;
   if Floating then begin
      if DParent <> nil then
         DParent.ChangeChildOrder (self);
   end;
   if EnableFocus then SetDFocus (self);
end;

function  TAspDWindow.ShowModal: integer;
begin
   Result:=0;//Jacky
   Visible := TRUE;
   ModalDWindow := self;
   if EnableFocus then SetDFocus (self);
end;

{ TDPageControl }

procedure TAspDPageControl.Add(D: TAspDControl);
begin
  Tabs.Add(D);
end;

constructor TAspDPageControl.Create(AOwner: TComponent);
begin
  inherited Create(Aowner);
  Tabs := TList.Create;
  FActivePage := 0;
  Width := 120;
  Height := 120;
  FTabRect := Bounds(Left, Top, Width, Height);
  FTabGRect := Bounds(GLeft, GTop, GWidth, GHeight);
end;

procedure TAspDPageControl.Delete(D: TAspDControl);
begin
  Tabs.Remove(D);
end;

destructor TAspDPageControl.Destroy;
begin
  Tabs.Free;
  inherited Destroy;
end;

function TAspDPageControl.GetTabGHeight: Integer;
begin
  Result := FTabGRect.Bottom;
end;

function TAspDPageControl.GetTabGLeft: Integer;
begin
  Result := FTabGRect.Left;
end;

function TAspDPageControl.GetTabGTop: Integer;
begin
  Result := FTabGRect.Top;
end;

function TAspDPageControl.GetTabGWidth: Integer;
begin
  Result := FTabGRect.Right;
end;

function TAspDPageControl.GetTabHeight: Integer;
begin
  Result := FTabRect.Bottom;
end;

function TAspDPageControl.GetTabLeft: Integer;
begin
  Result := FTabRect.Left;
end;

function TAspDPageControl.GetTabTop: Integer;
begin
  Result := FTabRect.Top;
end;

function TAspDPageControl.GetTabWidth: Integer;
begin
  Result := FTabRect.Right;
end;

procedure TAspDPageControl.SetActivePage(Value: Integer);
var
  I: Integer;
begin
  if (FActivePage <> Value) and (Value >= 0) and (Value < DControls.Count) then begin
    FActivePage := Value;
    for I := 0 to Tabs.Count - 1 do begin
      TAspDControl(Tabs[I]).Visible := False;
      if csDesigning in ComponentState then begin
        TAspDControl(Tabs[I]).Width := 0;
        TAspDControl(Tabs[I]).Height := 0;
      end;
    end;
    TAspDControl(Tabs[FActivePage]).Visible := True;
    if csDesigning in ComponentState then begin
      TAspDControl(Tabs[FActivePage]).Left := FTabRect.Left;
      TAspDControl(Tabs[FActivePage]).Top := FTabRect.Top;
      TAspDControl(Tabs[FActivePage]).Width := FTabRect.Right;
      TAspDControl(Tabs[FActivePage]).Height := FTabRect.Bottom;
    end else begin
      TAspDControl(Tabs[FActivePage]).GLeft := FTabGRect.Left;
      TAspDControl(Tabs[FActivePage]).GTop := FTabGRect.Top;
      TAspDControl(Tabs[FActivePage]).GWidth := FTabGRect.Right;
      TAspDControl(Tabs[FActivePage]).GHeight := FTabGRect.Bottom;
    end;  
    TAspDControl(Tabs[FActivePage]).BringToFront;
    if Assigned(FOnChange) then FOnChange(Self);
  end;
end;

procedure TAspDPageControl.SetTabGHeight(Value: Integer);
begin
  FTabGRect.Bottom := Value;
end;

procedure TAspDPageControl.SetTabGLeft(Value: Integer);
begin
  FTabGRect.Left := Value;
end;

procedure TAspDPageControl.SetTabGTop(Value: Integer);
begin
  FTabGRect.Top := Value;
end;

procedure TAspDPageControl.SetTabGWidth(Value: Integer);
begin
  FTabGRect.Right := Value;
end;

procedure TAspDPageControl.SetTabHeight(Value: Integer);
begin
  FTabRect.Bottom := Min(Value, Height);
end;

procedure TAspDPageControl.SetTabLeft(Value: Integer);
begin
  FTabRect.Left := Min(Value, Width);
end;

procedure TAspDPageControl.SetTabTop(Value: Integer);
begin
  FTabRect.Top := Min(Value, Height);
end;

procedure TAspDPageControl.SetTabWidth(Value: Integer);
begin
  FTabRect.Right := Min(Value, Width);
end;



{--------------------- TAspDWinManager --------------------------}


constructor TAspDWinManager.Create (AOwner: TComponent);
begin
   inherited Create (AOwner);
   DWinList := TList.Create;
   MouseCaptureControl := nil;
   FocusedControl := nil;
end;

destructor TAspDWinManager.Destroy;
begin
   DWinList.Free;
   inherited Destroy;
end;

procedure TAspDWinManager.ClearAll;
begin
   DWinList.Clear;
end;

procedure TAspDWinManager.AddDControl (dcon: TAspDControl; visible: Boolean);
begin
   dcon.Visible := visible;
   DWinList.Add (dcon);
end;

procedure TAspDWinManager.DelDControl (dcon: TAspDControl);
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

function  TAspDWinManager.KeyPress (var Key: Char): Boolean;
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
      if TAspDControl(DWinList[i]).Visible then begin
         if TAspDControl(DWinList[i]).KeyPress (Key) then begin
            Result := TRUE;
            break;
         end;
      end;
   end; }
end;

function  TAspDWinManager.KeyDown (var Key: Word; Shift: TShiftState): Boolean;
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
      if TAspDControl(DWinList[i]).Visible then begin
         if TAspDControl(DWinList[i]).KeyDown (Key, Shift) then begin
            Result := TRUE;
            break;
         end;
      end;
   end; }
end;

function  TAspDWinManager.MouseMove (Shift: TShiftState; X, Y: Integer): Boolean;
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
         if TAspDControl(DWinList[i]).Visible then begin
            if TAspDControl(DWinList[i]).MouseMove (Shift, X, Y) then begin
               Result := TRUE;
               break;
            end;
         end;
      end;
end;

function  TAspDWinManager.MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
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
         if TAspDControl(DWinList[i]).Visible then begin
            if TAspDControl(DWinList[i]).MouseDown (Button, Shift, X, Y) then begin
               Result := TRUE;
               break;
            end;
         end;
      end;
end;

function  TAspDWinManager.MouseUp (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
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
         if TAspDControl(DWinList[i]).Visible then begin
            if TAspDControl(DWinList[i]).MouseUp (Button, Shift, X, Y) then begin
               Result := TRUE;
               break;
            end;
         end;
      end;
end;

procedure TAspDWinManager.Process;
var
  I: Integer;
begin
  for I := 0 to DWinList.Count - 1 do begin
    if TAspDControl(DWinList[I]).Visible then begin
      TAspDControl(DWinList[I]).Process;
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

function  TAspDWinManager.DblClick (X, Y: integer): Boolean;
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
         if TAspDControl(DWinList[i]).Visible then begin
            if TAspDControl(DWinList[i]).DblClick (X, Y) then begin
               Result := TRUE;
               break;
            end;
         end;
      end;
end;

function  TAspDWinManager.Click (X, Y: integer): Boolean;
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
         if TAspDControl(DWinList[i]).Visible then begin
            if TAspDControl(DWinList[i]).Click (X, Y) then begin
               Result := TRUE;
               break;
            end;
         end;
      end;
end;

procedure TAspDWinManager.DirectPaint (dsurface: TAsphyreCanvas);
var
   i: integer;
begin
   if DWinList.Count > 0 then //20080629 
   for i:=0 to DWinList.Count-1 do begin
      if TAspDControl(DWinList[i]).Visible then begin
        try
          TAspDControl(DWinList[i]).DirectPaint (dsurface);
        except
          //修复在异常导致部分界面不显示 By TasNat at: 2012-07-03 13:06:02
        end;
      end;
   end;
   try
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
  end else if (lDEditMenu <> nil) {and (lDEditMenu.DEdit = Self)} and lDEditMenu.Visible then
      lDEditMenu.DirectPaint(dsurface);
  except
          //修复在异常导致部分界面不显示 By TasNat at: 2012-07-03 13:06:02
  end;
end;

procedure DEditMenu_Cut(DEdit : TAspDEdit);
var
  Key: Word;
begin
  Key := Ord('x');
  DEdit.KeyDown(Key, [ssCtrl]);
end;


procedure DEditMenu_Copy(DEdit : TAspDEdit);
var
  Key: Word;
begin
  Key := Ord('c');
  DEdit.KeyDown(Key, [ssCtrl]);
end;

procedure DEditMenu_Paste(DEdit : TAspDEdit);
var
  Key: Word;
begin
  Key := Ord('v');
  DEdit.KeyDown(Key, [ssCtrl]);
end;

procedure DEditMenu_Delete(DEdit : TAspDEdit);
var
  Key: Word;
begin
  Key := VK_DELETE;
  DEdit.KeyDown(Key, [ssCtrl]);
end;

procedure DEditMenu_SelectAll(DEdit : TAspDEdit);
begin

end;



constructor TAspDEditMenu.Create(AOwner: TComponent);
begin
  inherited;
  ItemHeight := 15;
  GWidth := 50;

  Menus := TStringList.Create;
  Menus.AddObject('  剪切', TObject(@DEditMenu_Cut));
  Menus.AddObject('  复制', TObject(@DEditMenu_Copy));
  Menus.AddObject('  粘贴', TObject(@DEditMenu_Paste));
  Menus.AddObject('  删除', TObject(@DEditMenu_Delete));
  Menus.AddObject('-', nil);
  Menus.AddObject('  全选', TObject(@DEditMenu_SelectAll));
  GHeight := Menus.Count * ItemHeight;
  Visible := False;
end;

destructor TAspDEditMenu.Destroy;
begin
  Menus.Free;
  inherited;
end;


procedure TAspDEditMenu.DirectPaint (dsurface: TAsphyreCanvas);
var
  I : Integer;
begin
  for I := 0 to Menus.Count - 1 do begin

    if FocusItemIndex <> I then
      dsurface.FillRect(Bounds(SurfaceX(GLeft), SurfaceY(GTop) + ItemHeight * I, GWidth, ItemHeight), clWhite)
    else
      dsurface.FillRect(Bounds(SurfaceX(GLeft), SurfaceY(GTop) + ItemHeight * I, GWidth, ItemHeight), clBlue);
    if Menus[I] = '-' then begin
      dsurface.FillRect(Bounds(SurfaceX(GLeft), SurfaceY(GTop) + AspTextureFont.TextHeight('bp') div 2  + ItemHeight * I, GWidth, 1), 0);
      Continue;
    end;
    if FocusItemIndex = I then
      AspTextureFont.TextOut(SurfaceX(GLeft),      //-16777209    -16777187
            SurfaceY(GTop) + ItemHeight * I, clWhite, Menus[I], [])
    else
    if Menus.Objects[I] <> nil then
      AspTextureFont.TextOut(SurfaceX(GLeft),      //-16777209    -16777187
            SurfaceY(GTop) + ItemHeight * I, $00000007, Menus[I], [])
    else
      AspTextureFont.TextOut(SurfaceX(GLeft),
            SurfaceY(GTop) + ItemHeight * I, $FF6D6D6D, Menus[I], [])
  end;
  {AspTextureFont.TextOut(SurfaceX(GLeft) + 50,
            SurfaceY(GTop) , clGrayText, Format('%d.%d',[XX, YY]), [])}
end;

function TAspDEditMenu.MouseMove (Shift: TShiftState; X, Y: Integer): Boolean;
begin
  Dec(X, GLeft);
  if (X > 0) and (X < GWidth) then
    FocusItemIndex := (Y - GTop) div ItemHeight
  else
    //FocusItemIndex := -1;
end;

function TAspDEditMenu.MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
begin
  Result := (FocusItemIndex >= 0) and (FocusItemIndex < Menus.Count) and (Menus.Objects[FocusItemIndex] <> nil);
  if Result then
    TAspDEditMenuProc(Menus.Objects[FocusItemIndex])(DEdit);
  Visible := False;
end;

procedure TAspDEditMenu.Popup(ADEdit : TAspDEdit; X, Y: Integer);
begin
  DEdit := ADEdit;
  GLeft := X;
  GTop := Y;
  GTop := Min(GTop, DisplaySize.y - GHeight);
  GLeft := Min(GLeft, DisplaySize.x - GWidth);
  Visible := True;
  if DEdit.SelCount > 0 then begin
    Menus.Objects[0] := TObject(@DEditMenu_Cut);
    Menus.Objects[1] := TObject(@DEditMenu_Copy);
    //Menus.AddObject('粘贴', TObject(@DEditMenu_Paste);
    Menus.Objects[3] := TObject(@DEditMenu_Delete);
  end else begin
    Menus.Objects[0] := nil;
    Menus.Objects[1] := nil;
    Menus.Objects[3] := nil;
  end;

  if DEdit.SelCount <> DEdit.GetTextLen then //全选
    Menus.Objects[5] := TObject(@DEditMenu_SelectAll)
  else
    Menus.Objects[5] := nil;

  if Clipboard.AsText = '' then //粘贴
    Menus.Objects[2] := TObject(@DEditMenu_Paste)
  else
    Menus.Objects[2] := nil;
   
end;


{ TAspDEdit }
constructor TAspDEdit.Create(AOwner: TComponent);
begin
  inherited Create (AOwner);   //组件创建
  if lDEditMenu = nil then begin
    lDEditMenu := TAspDEditMenu.Create(nil);
    lDEditMenu.DParent := nil;
  end;
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
procedure TAspDEdit.DelSelText;
var s:integer;
begin
  s := selStart;
  if SelStart > SelStop then s := SelStop;
  Delete(FText,S+1,SelCount);
  SelStart := s;
  SelStop := s;
end;

function TAspDEdit.CopySelText():string;
var
  s:Integer;
begin
  Result := '';
  s := SelStart;
  if SelStart > SelStop then s := SelStop;
  Result := Copy(FText,S+1,SelCount);
end;
//画的方法
procedure TAspDEdit.DirectPaint(dsurface: TAsphyreCanvas);
function CharPos(Index: Integer): Integer;
var
  sText: WideString;
  TextBefore: WideString;
begin
     //-------modi by huasoft-------------------------------------
     // (2) Extract part of text prior to selector
    sText := FText;
    TextBefore := '';

    if (Index > 0) then TextBefore := Copy(sText, 1, Index);

    Result := AspTextureFont.TextWidth(TextBefore);
end;
var 
    SelStartX:integer;
    SelStopX:integer;
    Ypos:integer;
    sTemPass: string;
    I: Integer;
    TextHeight : Integer;
    SelRect: TRect;
    fC : TColor;
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
    fC := FFont.Color;
    TextHeight := AspTextureFont.TextHeight(FText);
    if (SelCount > 0) and (FocusedControl = Self) and Enabled then begin
      SelRect := Bounds(SurfaceX(GLeft) + 2, SurfaceY(GTop) + (GHeight - TextHeight) div 2, GWidth - 1, TextHeight);
      SelRect.Left := SurfaceX(GLeft) + 2 + CharPos(Min(SelStart, SelStop));
      SelRect.Right := SurfaceX(GLeft) + 2 + Min(CharPos(Max(SelStart, SelStop)), GWidth);
      dsurface.FillRect(SelRect, FSelCol);
      fC := $FFFFFFFF;//选择后字体颜色为白色
      //end;
    end;
    //Brush.Style := bsClear;
    {******************************************}
    //输出Capiton内容
    if Enabled then begin
      if FPasswordChar = #0 then begin
        AspTextureFont.TextRect(rect(SurfaceX(GLeft),SurfaceY(GTop),SurfaceX(GLeft)+GWidth,SurfaceY(GTop)+GHeight),
            Bounds(0, 0, GWidth, GHeight), SurfaceX(GLeft)+BorderWidth-XDif, SurfaceY(GTop)+YPos + 1,FText, fC,[]);
        {rect(SurfaceX(GLeft),SurfaceY(GTop),SurfaceX(GLeft)+GWidth,SurfaceY(GTop)+GHeight),
          SurfaceX(GLeft)+BorderWidth-XDif, SurfaceY(GTop)+YPos + 1, FText, FFont.Color,[]);}
      end else begin
        sTemPass := '';
        for i := 1 to length(FText) do sTemPass := sTemPass + '*';
        AspTextureFont.TextRect(rect(SurfaceX(GLeft),SurfaceY(GTop),SurfaceX(GLeft)+GWidth,SurfaceY(GTop)+GHeight),
            Bounds(0, 0, GWidth, GHeight), SurfaceX(GLeft)+BorderWidth-XDif, SurfaceY(GTop)+YPos + 1,sTemPass, fC,[]);
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

     dsurface.FillRect(Bounds(SurfaceX(GLeft)+SelStopX+BorderWidth-XDif,
                            SurfaceY(GTop) + (GHeight - TextHeight) div 2+ 2,
                            1,
                            TextHeight - 2), FFont.Color);
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
procedure TAspDEdit.DoMove;
begin
  CursorTime := CursorTime + 1;
  If CursorTime > BlinkSpeed then
  begin
    CursorVisible := not CursorVisible;
    CursorTime := 0;
  end;
end;
//得到选择数量
function TAspDEdit.GetSelCount: integer;
begin
  result := abs(SelStop-SelStart);
end;
//最大输入数量
procedure TAspDEdit.SetMaxLength(const Value: Integer);
begin
  FMaxLength := Value;

  if (FMaxLength > 0) and (Length(string(FText)) > FMaxLength) then
  begin
    FText := Copy(FText, 1, FMaxLength);
    if (SelStart > Length(string(FText))) then SelStart := Length(string(FText));
  end;
end;

function TAspDEdit.KeyDown(var Key: Word; Shift: TShiftState): Boolean;
var
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
      if (ssCtrl in Shift) then begin
        case Key of
          Byte('V'),Byte('v') : begin   //粘贴代码
            DelSelText;//先删除选择的文字By TasNat at:2012-12-13 10:37:33
            AddTx := Clipboard.AsText;
            Insert(AddTx, FText, SelStart + 1);
            Inc(SelStart, Length(AddTx));
            if (FMaxLength > 0) and (Length(FText) > FMaxLength) then begin
              FText := Copy(FText, 1, FMaxLength);
              if (SelStart > Length(FText)) then SelStart := Length(FText);
            end;
            SelStop := SelStart;
            if (Assigned(FOnChange)) then FOnChange(Self);
          end;
          Byte('C'),Byte('c'): begin   //复制
            Clipboard.AsText := CopySelText();
          end;
          Byte('X'),Byte('x'): if SelCount > 0 then begin   //剪贴
            Clipboard.AsText := CopySelText();
            DelSelText;
            if (Assigned(FOnChange)) then FOnChange(Self);
          end;
        end;
      end;
      if SelStart < 0 then SelStart := 0;
      if SelStart > Length(FText) then SelStart := Length(FText);
      if SelStop < 0 then SelStop := 0;
      if SelStop > Length(FText) then SelStop := Length(FText);
  end;
end;

function TAspDEdit.KeyPress(var Key: Char): Boolean;
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

function TAspDEdit.MouseMove(Shift: TShiftState; X, Y: Integer): Boolean;
begin
  if not FVisible or not DParent.FVisible then Exit;
  if (lDEditMenu <> nil) and (lDEditMenu.DEdit = Self) and lDEditMenu.Visible then
    lDEditMenu.MouseMove(Shift, SurfaceX(X), SurfaceY(Y));
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
function TAspDEdit.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
begin
  Result := (lDEditMenu <> nil) and (lDEditMenu.DEdit = Self) and lDEditMenu.Visible and
    lDEditMenu.MouseDown(Button, Shift, X, Y);
  if not FVisible or not DParent.FVisible or Result then Exit;
   Result := FALSE;
   if inherited MouseDown (Button, Shift, X, Y) then begin
      if Enabled then begin
        if (not Background) and (MouseCaptureControl=nil) then begin
           case Button of
             mbRight : if (ActiveMenu = nil) or (not ActiveMenu.Visible) then lDEditMenu.Popup(Self, SurfaceX(X),SurfaceY(Y));
             {mbLeft : }else begin
               SelStart := MouseToSelPos(x-Gleft);
               SelStop := SelStart;
               SetDCapture (self);
             end;
           end;

        end;
        Result := TRUE;
      end;
   end;
end;

function TAspDEdit.MouseToSelPos(AX: integer): integer;
var
  I:integer;
  AX1: Integer;
begin
  Result := length(FText);
  AX1 := AX-Borderwidth+XDif -3;
  if Result <= 0 then begin //2080629
    Exit;
  end;
  for i := 0 to Result do begin
    if AspTextureFont.TextWidth(copy(FText,1,I)) >= AX1 then begin
      Result := I;
      break;
    end;
  end;
end;

procedure TAspDEdit.SetSelLength(Value: Integer);
begin
  if SelStart > 0 then
    SelStop := SelStart + Value;
end;


function TAspDEdit.GetSelLength: Integer;
begin
  Result := SelStart;
  if Result > 0 then
    Result := SelStop + Result;
end;

procedure TAspDEdit.Update;
begin
  inherited;

end;


function TAspDEdit.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
begin
   Result := FALSE;
   if inherited MouseUp(Button, Shift, X, Y) then begin
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

procedure TAspDEdit.SetText (str: Widestring);
begin
   FText := str;
   if csDesigning in ComponentState then begin
      Refresh;
   end;
end;

procedure TAspDEdit.SetFocus;
begin
  SetDFocus (self);
end;

destructor TAspDEdit.Destroy;
begin
  Font.Free;
  inherited;
end;

procedure TAspDEdit.SetPasswordChar(Value: Char);
begin
  if FPasswordChar <> Value then FPasswordChar := Value;
end;

procedure TAspDEdit.Paint;
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
constructor TAspDMemoScrollBarBar.Create(AOwner: TComponent);
begin
  inherited Create (AOwner);
  GLeft := 1;
  FTheta:= 0.0; //起始位置
  FItemsHeight := 14;
end;

procedure TAspDMemoScrollBarBar.DirectPaint(dsurface: TAsphyreCanvas);
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

function TAspDMemoScrollBarBar.MouseDown(Button: TMouseButton;
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

function TAspDMemoScrollBarBar.MouseMove(Shift: TShiftState; X,
  Y: Integer): Boolean;
var
  AnchorArea: Integer;
begin
  Result := inherited MouseMove (Shift, X, Y);
  if (not Background) and (not Result) then begin
    Result := inherited MouseMove (Shift, X, Y);
  end else if ssLeft in Shift then begin
    if TAspDMemoScrollBar(DParent).FArrowInc > 0 then begin
      AnchorArea:= (DParent.GHeight) - (TAspDMemoScrollBar(DParent).BUp.GHeight+TAspDMemoScrollBar(DParent).BDown.GHeight+GHeight); //块的范围
      movebar(CLickTheta + (Y-ClickY)/AnchorArea);
    end;
  end;
end;

function TAspDMemoScrollBarBar.MouseUp(Button: TMouseButton; Shift: TShiftState;
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

procedure TAspDMemoScrollBarBar.Movebar(nposy: Real);
var
 AnchorArea,ElemCount: Integer;
begin
  ElemCount:= (DParent.DParent.GHeight - 2) div FItemsHeight;  //一共能显示几行
  AnchorArea:= DParent.GHeight - (TAspDMemoScrollBar(DParent).BUp.GHeight+TAspDMemoScrollBar(DParent).BDown.GHeight+GHeight+1);  //滑块范围
  FTheta := Max(Min(nposy, 1.0), 0.0);
  if Assigned(TAspDMemoScrollBar(DParent).OnChange) then TAspDMemoScrollBar(DParent).OnChange(TAspDMemoScrollBar(DParent));
  GTop := {DParent.Top +}TAspDMemoScrollBar(DParent).BUp.GTop + TAspDMemoScrollBar(DParent).BUp.GHeight + TAspDMemoScrollBar(DParent).BDown.GHeight + 3 - GHeight + Round(FTheta * AnchorArea);  //滑块位置
end;


{ TDScrollBarUp }

constructor TAspDMemoScrollBarUp.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Downed := False;
  GLeft := 1;
end;

procedure TAspDMemoScrollBarUp.DirectPaint(dsurface: TAsphyreCanvas);
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

function TAspDMemoScrollBarUp.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer): Boolean;
begin
   Result := FALSE;
   if inherited MouseDown (Button, Shift, X, Y) then begin
      if (not Background) and (MouseCaptureControl=nil) then begin
        if mbLeft = Button then begin
          Downed := TRUE;
          SetDCapture (self);
          TAspDMemoScrollBar(DParent).Bar.MoveBar(TAspDMemoScrollBar(DParent).Theta-TAspDMemoScrollBar(DParent).FArrowInc);
        end;
      end;
      Result := TRUE;
   end;
end;

function TAspDMemoScrollBarUp.MouseMove(Shift: TShiftState; X,
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

function TAspDMemoScrollBarUp.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
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
constructor TAspDMemoScrollBardown.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Downed := False;
  GLeft := 1;
end;


procedure TAspDMemoScrollBardown.DirectPaint(dsurface: TAsphyreCanvas);
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

function TAspDMemoScrollBardown.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer): Boolean;
begin
   Result := FALSE;
   if inherited MouseDown (Button, Shift, X, Y) then begin
      if (not Background) and (MouseCaptureControl=nil) then begin
        if mbLeft = Button then begin
          Downed := TRUE;
          SetDCapture (self);
          TAspDMemoScrollBar(DParent).Bar.MoveBar(TAspDMemoScrollBar(DParent).Theta+TAspDMemoScrollBar(DParent).FArrowInc);
        end;
      end;
      Result := TRUE;
   end;
end;

function TAspDMemoScrollBardown.MouseMove(Shift: TShiftState; X,
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

function TAspDMemoScrollBardown.MouseUp(Button: TMouseButton; Shift: TShiftState;
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
constructor TAspDMemoScrollBar.Create(AOwner: TComponent);
begin
  inherited Create (AOwner);
  Bar := TAspDMemoScrollBarbar.create(Self);
  BUp := TAspDMemoScrollBarUp.create(Self);
  Bdown := TAspDMemoScrollBarDown.create(Self);
  Bar.DParent := Self;
  BUp.DParent := Self;
  BDown.DParent := Self;
  AddChild(Bar);
  AddChild(BUp);
  AddChild(BDown);
  FArrowInc:= 0.1;
  FPageInc := 0.25;
end;

destructor TAspDMemoScrollBar.Destroy;
begin
  FreeAndNil(Bar);
  FreeAndNil(BUp);
  FreeAndNil(Bdown);
  inherited;
end;

function TAspDMemoScrollBar.GetBarTheta: Real;
begin
  Result := Bar.FTheta;
end;

function TAspDMemoScrollBar.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
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

function TAspDMemoScrollBar.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
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
{ TAspDMemo }
constructor TAspDMemo.Create(AOwner: TComponent);
begin
  inherited Create (AOwner);
  FLines := TStringList.Create;
  FLinesHeight := 14; //每行高度
  DScroll := nil;
end;

destructor TAspDMemo.Destroy;
begin
  FreeAndNil(FLines);
  inherited;
end;

procedure TAspDMemo.SetLines(Value: TStringList);
begin
  FLines.Assign(Value);
end;

{procedure TAspDControl.DesignClick;
begin

end;}

procedure TAspDMemo.SetLinesHeight(Value: Integer);
begin
  FLinesHeight := Value;
  DScroll.Bar.FItemsHeight := Value;
end;

function TAspDControl.GetClientRect: TRect;
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

{ TAspDMapMini }

constructor TAspDMapMini.Create(AOwner: TComponent);
begin
   inherited Create (AOwner);
   FEnableFocus := False;
   Downed := False;
end;

function TAspDMapMini.MouseMove(Shift: TShiftState; X, Y: Integer): Boolean;
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

function TAspDControl.GetMouseMove: Boolean;
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

initialization


end.
