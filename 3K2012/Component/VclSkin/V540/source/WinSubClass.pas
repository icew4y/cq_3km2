unit WinSubClass;

{$I Compilers.inc}

{.$define combobox}
{.$define buttontest}
{.$define resiztest}
{.$define scrollbartest}
{.$define combox}

{$WARNINGS OFF}
{$HINTS OFF}
{$RANGECHECKS OFF}

{$DEFINE progress}

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, ComCtrls, Forms,
  Menus, Messages, ExtCtrls, StdCtrls, Buttons, CommCtrl, imglist,
  winskindata, tabs, TypInfo, Dialogs, Grids;

const
  CM_Scroll1 = 161;
  CM_Scroll2 = 513;
  CM_Scroll3 = 162;
  CM_Scroll4 = 514;
  C_Paramv = 7;
  C_Paramh = 6;
  c_paramB = 1;
  SBM_GETSCROLLBARINFO = 235;

type
  TSkinControlState = (scMouseIn, scDown);
  TAcControl = class(TControl);
  TAcWinControl = class(TWinControl);
  TAcGraphicControl = class(TGraphicControl);
  TSkinAcListView = class(TCustomListView);
  TSkinScrollbar = class;

  TSkinControl = class(TComponent)
  protected
    state: set of TSkinControlState;
    fCanvas: TCanvas;
    done: boolean;
    isdraw: boolean;
    enabled: boolean;
    focused: boolean;
    caption: wideString;
    FObjectInst, FPrevWndProc: pointer;
    skinned: boolean;
    isunicode: boolean;
    procedure FillBG(dc: HDC; rc: TRect);
    procedure FillParentBG(dc: HDC; rc: TRect);
    procedure doLogMsg(aid: string; msg: TMessage);
    procedure Default(var Msg: TMessage);
    procedure Invalidate;
    procedure WMPaint(message: TMessage);
    procedure WMERASEBKGND(var Msg: TMessage);
    function GetWindowLongEx(ahWnd: HWND; nIndex: Integer): Longint;
    procedure SetParentBK(value: boolean);
    procedure DrawFocus(hDC: HDC; wString: WideString; rc: TRect; uFormat: UINT);
//     procedure Notification(AComponent: TComponent;Operation: TOperation);override;
  public
    fsd: TSkinData;
    hwnd: HWND;
    OldWndProc: TWndMethod;
    control: Twincontrol;
    boundsrect: Trect;
    GControl: TGraphicControl;
    newColor: boolean;
    oldcolor: Tcolor;
    Inited: boolean;
    skinstate: integer;
    skinform: Tcomponent;
    kind: integer;
    sizing: boolean;
    parentbk: boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Init(sf: Tcomponent; sd: TSkinData; acanvas: TCanvas; acolor: boolean = false); virtual;
    procedure Inithwnd(ahwnd: Thandle; sd: TSkinData; acanvas: TCanvas; sf: Tcomponent); virtual;
    procedure MouseLeave;
    procedure Unsubclass; virtual;
    procedure NewWndProc(var Message: TMessage);
    function BeforeProc(var Message: TMessage): boolean; virtual;
    procedure AfterProc(var Message: TMessage); virtual;
    procedure PaintControl(adc: HDC = 0); virtual;
    procedure DrawControl(dc: HDC; rc: TRect); virtual;
    procedure SkinChange; virtual;
    function GetState: integer; virtual;
    procedure SetColor;
    procedure RestoreColor;
    procedure DrawBMPSkin(abmp: Tbitmap; rc: TRect; aObject: TdataSkinObject;
      I, N: integer; trans: integer);
    procedure DrawSkinMap(dc: HDC; rc: TRect;
      aObject: TdataSkinObject; I, N: integer);
    procedure DrawSkinMap1(dc: HDC; rc: TRect;
      bmp: Tbitmap; I, N: integer);
    procedure DrawSkinMap2(dc: HDC; rc: TRect;
      bmp: Tbitmap; I, N: integer);
    procedure DrawSkin(rc: TRect; aObject: TdataSkinObject;
      I, N: integer; trans: integer);
    procedure DrawSkinMap3(acanvas: Tcanvas; rc: TRect;
      bmp: Tbitmap; I, N: integer);
    procedure DrawBuf(dc: HDC; rc: TRect);
    procedure DrawCaption(acanvas: TCanvas; rc: TRect; text: widestring;
      enabled, defaulted: boolean; Alignment: word = DT_CENTER);
    procedure DrawImgCaption(acanvas: TCanvas; rc: TRect;
      ImgList: hImageList; imgIndex: integer; text: widestring; talign: integer = DT_CENTER);
    function TextHeight(dc: HDC; const s: string): integer;
    function GetParentColor(acolor: Tcolor): Tcolor;
    function CheckBiDi(dw: dword): dword;
  end;

  TArrowButton = class(TCustomControl)
  private
    procedure WMLButtonDown(var aMsg: TMessage); message WM_LButtonDown;
    procedure WMLButtonUP(var aMsg: TMessage); message WM_LButtonUP;
//    procedure WMERASEBKGND(var Msg: TMessage);message WM_ERASEBKGND;
    procedure CMMouseEnter(var aMsg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var aMsg: TMessage); message CM_MOUSELEAVE;
  protected
    procedure Paint; override;
  public
    cw: integer;
    control: TWincontrol;
    obj: TSkinControl;
    hwnd: Thandle;
    state: set of TSkinControlState;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Attach(aobj: Tskincontrol; acontrol: Twincontrol);
    procedure MoveArrow(r: TRect);
  end;

  TSkinDateTime = class(TSkinControl)
  private
  protected
    arrow: TArrowButton;
    procedure AfterProc(var Message: TMessage); override;
    procedure DrawControl(dc: HDC; rc: TRect); override;
  public
    destructor Destroy; override;
    procedure Init(sf: Tcomponent; sd: TSkinData; acanvas: TCanvas; acolor: boolean = false); override;
  end;

  TWScrollbar = class(TCustompanel)
  private
    procedure WMLButtonDown(var aMsg: TMessage); message WM_LButtonDown;
    procedure WMMouseMove(var aMsg: TMessage); message WM_MouseMove;
    procedure WMMouseLeave(var aMsg: TMessage); message WM_MouseLeave;
    procedure WMLButtonDBClick(var aMsg: TMessage); message WM_LBUTTONDBLCLK;
    procedure WMLButtonUp(var aMsg: TMessage); message WM_LButtonUp;
    procedure WMERASEBKGND(var Msg: TMessage); message WM_ERASEBKGND;
  protected
    Len: Integer;
    thumbTop, thumbbottom: integer;
    OffsetSC, trackp: tpoint;
    trackthumb: integer;
    fdown: boolean;
    sbDir: integer;
    ERASEBKGND: boolean;
    scrollpos: integer;
    procedure Paint; override;
    procedure GetThumb(rc: TRect);
    function GetScrollPos(p: Tpoint): integer;
    function GetControlInfo(var info: tagScrollBarInfo): boolean;
    function GetControlInfo2(var info: tagScrollBarInfo): boolean;
    procedure CreateParams(var Params: TCreateParams); override;
  public
    CW: integer;
    hwnd: Thandle;
    control: TWincontrol;
    obj: TSkinControl;
    sbType: byte;
    sbRect: Trect;
//    scrollpos:integer;
    sbVisible: boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Attach(aobj: TSkinControl; aControl: Twincontrol; aType: byte);
    procedure AttachHwnd(aobj: TSkinControl; ahwnd: Thandle; aType: byte);
    procedure SetPosition(ahwnd: Thandle);
    procedure ButtonUp;
    procedure HideScrollbar;
    procedure DoLog(Message: TMessage);
  end;

  TSkinButton = class(TSkinControl)
  protected
    btemp: Tbitmap;
    MultiLine: boolean;
    trans: boolean;
    redraw: boolean;
    isdefault: boolean;
    procedure DrawBtnText(acanvas: TCanvas; rc: TRect;
      text: string; Alignment: word = DT_CENTER);
    procedure DoMouseDown(var Message: TWMMouse);
    procedure WMEnable(var Message: TMessage);
    procedure SetRedraw(b: boolean);
    function GetFontColor(var acolor: Tcolor): boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Init(sf: Tcomponent; sd: TSkinData; acanvas: TCanvas; acolor: boolean = false); override;
    function BeforeProc(var Message: TMessage): boolean; override;
    procedure AfterProc(var Message: TMessage); override;
    procedure DrawControl(dc: HDC; rc: TRect); override;
  end;

  TSkinBitButton = class(TSkinButton)
  protected
    procedure DrawGlyph(acanvas: Tcanvas; rc: TRect;
      bmp: Tbitmap; I, N: integer);
    procedure DrawPicControl(dc: HDC; rc: TRect);
  public
    isPicture: boolean;
    PicField: string;
    procedure DrawControl(dc: HDC; rc: TRect); override;
  end;

  TMPBtnType = (btPlay, btPause, btStop, btNext, btPrev, btStep, btBack,
    btRecord, btEject);
  TButtonSet = set of TMPBtnType;
  TMPGlyph = (mgEnabled, mgDisabled, mgColored);
  TMPButton = record
    Visible: Boolean;
    Enabled: Boolean;
    Colored: Boolean;
    Auto: Boolean;
    Bitmaps: array[TMPGlyph] of TBitmap;
  end;

  TWMediaPlayer = class(TCustompanel)
  private
    procedure WMLButtonDown(var aMsg: TMessage); message WM_LButtonDown;
//    procedure WMMouseMove(Var aMsg: TMessage);message WM_MouseMove;
//    procedure WMMouseLeave(Var aMsg: TMessage);message WM_MouseLeave;
//    procedure WMLButtonDBClick(Var aMsg: TMessage);message WM_LBUTTONDBLCLK;
    procedure WMLButtonUp(var aMsg: TMessage); message WM_LButtonUp;
//    procedure WMERASEBKGND(var Msg: TMessage);message WM_ERASEBKGND;
    procedure LoadBitmaps;
    procedure DestroyBitmaps;
    procedure CheckButtons;
    procedure FindButton(XPos, YPos: Integer);
  protected
    Buttons: array[TMPBtnType] of TMPButton;
    count: integer;
    fsd: TSkinData;
    IsDown: boolean;
    BtnClick: TMPBtnType;
    BtnFocuse: TMPBtnType;
    BtnWidth: integer;
    procedure Paint; override;
    procedure DrawButton(acanvas: Tcanvas; Btn: TMPBtnType; R: TRect);
  public
    obj: TWincontrol;
    skincontrol: TSkincontrol;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Attach(askin: TSkinControl; aObj: Twincontrol);
    procedure SetPosition(aObj: Twincontrol);
  end;

  TSkinMP = class(TSkinControl)
  protected
    mp: TWMediaPlayer;
//     Buttons: array[TMPBtnType] of TMPButton;
//     procedure LoadBitmaps;
//     procedure DestroyBitmaps;
//     procedure DrawGlyph( acanvas:Tcanvas; rc:TRect;
//       bmp:Tbitmap;I,N:integer);
    procedure Unsubclass; override;
    procedure AfterProc(var Message: TMessage); override;
  public
//     constructor Create(AOwner: TComponent); override;
//     destructor Destroy; override;
    procedure Init(sf: Tcomponent; sd: TSkinData; acanvas: TCanvas; acolor: boolean = false); override;
//     procedure DrawControl( dc:HDC; rc:TRect);override;
  end;

  TSkinMenuButton = class(TSkinButton)
  protected
    procedure DrawGlyph(acanvas: Tcanvas; rc: TRect;
      bmp: Tbitmap; I, N: integer);
  public
    procedure DrawControl(dc: HDC; rc: TRect); override;
  end;

  TSkinSpeedButton = class(TSkinBitButton)
  protected
    FReentr: Boolean;                   // RF: flag for reentrancy
    procedure DrawPicbtn(acanvas: Tcanvas; rc: TRect);
  public
//     GControl : TGraphicControl;
    PicField: string;
    gcanvas: Tcanvas;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DrawSpeedbtn(acanvas: Tcanvas; rc: TRect);
    procedure InitGraphicControl(sf: Tcomponent; sd: TSkinData; acanvas: TCanvas);
    procedure AfterProc(var Message: TMessage); override;
    function BeforeProc(var Message: TMessage): boolean; override;
    procedure PaintControl(adc: HDC = 0); override;
    procedure WMPaintSpeed(var Message: Tmessage);
  end;

  TSkinCheckBox = class(TSkinControl)
  protected
    state: integer;
    trans: boolean;
  public
    function BeforeProc(var Message: TMessage): boolean; override;
    procedure AfterProc(var Message: TMessage); override;
    procedure DrawControl(dc: HDC; rc: TRect); override;
    procedure Init(sf: Tcomponent; sd: TSkinData; acanvas: TCanvas; acolor: boolean = false); override;
  end;

  TComboxScrollBar = class;
  TSkinScrollbarH = class;
  TSkinComBox = class(TSkinControl)
  protected
    dwStyle, ExStyle: longword;
    hlist, hbtn: Thandle;
    isDrop: boolean;
//     box :Tskinscrollbar;
    FBtnObjectInst, FBtnPrevWndProc: pointer;
    vb: TSkinScrollbarH;
    db: TComboxScrollBar;
    info: tagCOMBOBOXINFO;
    rBtn: TRect;
    procedure FindBtn;
    procedure DrawSkinMap3(dc: HDC; rc: TRect;
      bmp: Tbitmap; I, N: integer);
    procedure DrawControl1(dc: HDC; rc: TRect);
    procedure ButtonProc(var Message: TMessage);
    procedure CNCommand(var Message: TWMCommand);
//     procedure FindScrollbar;
    procedure Unsubclass; override;
    procedure DrawEdit(dc: HDC; rc: TRect);
    procedure SkinDropList;
    procedure DeleteDropList;
    procedure DrawBorder(dc: HDC; rc: TRect);
    procedure DrawArrow(dc: HDC; rc: TRect; i: integer);
  public
    HasButton: boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AfterProc(var Message: TMessage); override;
    procedure DrawControl(dc: HDC; rc: TRect); override;
    procedure Init(sf: Tcomponent; sd: TSkinData; acanvas: TCanvas; acolor: boolean = false); override;
    procedure Inithwnd(ahwnd: Thandle; sd: TSkinData; acanvas: TCanvas; sf: Tcomponent); override;
  end;

  TSkinRadioButton = class(TSkinControl)
  protected
    trans: boolean;
  public
    procedure Init(sf: Tcomponent; sd: TSkinData; acanvas: TCanvas; acolor: boolean = false); override;
    procedure AfterProc(var Message: TMessage); override;
    function BeforeProc(var Message: TMessage): boolean; override;
    procedure DrawControl(dc: HDC; rc: TRect); override;
  end;

  TSkinStatusBar = class(TSkinControl)
  protected
    procedure Defaultpaint(acanvas: Tcanvas; rc: TRect; I: integer;
      text: widestring = ''; Align: TAlignment = taLeftJustify);
    procedure drawitem(dc: HDC; rc: TRect; I: integer;
      text: widestring = ''; Align: TAlignment = taLeftJustify);
  public
    SizeGrip: boolean;
    function BeforeProc(var Message: TMessage): boolean; override;
    procedure DrawControl(dc: HDC; rc: TRect); override;
  end;

  TSkinBox = class(TSkinControl)
  protected
  public
    border: integer;
    procedure AfterProc(var Message: TMessage); override;
    procedure Init(sf: Tcomponent; sd: TSkinData; acanvas: TCanvas; acolor: boolean = false); override;
    procedure Unsubclass; override;
  end;

  TSkinGroupBox = class(TSkinControl)
  protected
    procedure DefaultDraw(dc: HDC; rc: TRect);
  public
    border: integer;
    procedure Init(sf: Tcomponent; sd: TSkinData; acanvas: TCanvas; acolor: boolean = false); override;
    function BeforeProc(var Message: TMessage): boolean; override;
    procedure DrawControl(dc: HDC; rc: TRect); override;
  end;

  TSkinUpDown = class(TSkinControl)
  protected
    procedure DrawButton(acanvas: Tcanvas; rc: TRect; n, ar: integer);
    procedure DrawSkinButton(dc: HDC; rc: TRect; n, ar: integer);
    procedure DrawBackGround(msg: Tmessage);
  public
    inedit: boolean;
    dir: integer;
    function BeforeProc(var Message: TMessage): boolean; override;
    procedure DrawControl(dc: HDC; rc: TRect); override;
  end;


  TSkinTabPosition = (StTop, Stbottom, Stleft, Stright);
  TSkinTab = class(TSkinControl)
  protected
    CloseRect: array of TRect;
    Position: TSkinTabPosition;
    unicode: boolean;
    procedure Drawitem(dc: HDC; rc: TRect; I: integer);
    procedure ERASEBKGND(dc: HDC);
    procedure GetPosition;
//     procedure WMPaint(var msg:Tmessage);
    procedure ClipUpdown(dc: HDC; rc: Trect);
    function FindScroll: boolean;
    procedure DrawTabBorder(adc: HDC);
    procedure drawCloseBtn(rc: TRect; i: integer);
    function BeforeProc(var Message: TMessage): boolean; override;
//     procedure AfterProc(var Message: TMessage);override;
    function ClickClose(var Message: TMessage): boolean;
  public
    tabbmp, borderbmp: Tbitmap;
    Drawtemp: Tbitmap;
    updown: TskinUpdown;
    showclose: boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DrawControl(dc: HDC; rc: TRect); override;
//     function  BeforeProc(var Message: TMessage):boolean;override;
    procedure Init(sf: Tcomponent; sd: TSkinData; acanvas: TCanvas; acolor: boolean = false); override;
    procedure Inithwnd(ahwnd: Thandle; sd: TSkinData; acanvas: TCanvas; sf: Tcomponent); override;
    procedure inittab;
    procedure SkinChange; override;
  end;

  TSkinTab31 = class(TSkinControl)
  protected
    tabbmp: Tbitmap;
    updown: TskinUpdown;
    scroller: Twincontrol;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function BeforeProc(var Message: TMessage): boolean; override;
    procedure DrawControl(dc: HDC; rc: TRect); override;
     //Procedure Inithwnd(ahwnd:Thandle;sd:TSkinData;acanvas:TCanvas;sf:Tcomponent);override;
    procedure Init(sf: Tcomponent; sd: TSkinData; acanvas: TCanvas; acolor: boolean = false); override;
    procedure inittab;
    procedure SkinChange; override;
  end;

  TSkinTabBtn = class(TSkinControl)
  protected
  public
    function BeforeProc(var Message: TMessage): boolean; override;
    procedure DrawControl(dc: HDC; rc: TRect); override;
  end;

  TSkinTransObj = class(TSkinControl)
  protected
    procedure ERASEBKGND(dc: HDC);
  public
//     Brush,Oldbrush: HBrush;
    function BeforeProc(var Message: TMessage): boolean; override;
    procedure AfterProc(var Message: TMessage); override;
  end;

  TSkinProgress = class(TSkinControl)
  protected
  public
    function BeforeProc(var Message: TMessage): boolean; override;
    procedure DrawControl1(dc: HDC; rc: TRect);
    procedure DrawControl(dc: HDC; rc: TRect); override;
  end;

  TSkinTrackBar = class(TSkinControl)
  protected
    procedure Drawthumb(PDraw: PNMCustomDraw);
    function CustomDraw(PDraw: PNMCustomDraw): integer;
    procedure DrawTrack(PDraw: PNMCustomDraw);
  public
    procedure Init(sf: Tcomponent; sd: TSkinData; acanvas: TCanvas; acolor: boolean = false); override;
    procedure skinchange; override;
    procedure Unsubclass; override;
    function BeforeProc(var Message: TMessage): boolean; override;
  end;

  TSkinToolbar = class(TSkinControl)
  protected
    gradCol1, gradCol2: integer;
//     procedure Drawthumb(PDraw:PNMCustomDraw);
//     function CustomDraw(PDraw:PNMCustomDraw):integer;
    procedure ERASEBKGND(msg: Tmessage);
  public
    function BeforeProc(var Message: TMessage): boolean; override;
    procedure Init(sf: Tcomponent; sd: TSkinData; acanvas: TCanvas; acolor: boolean = false); override;
  end;

  TSkinEdit = class(TSkinControl)
  protected
    procedure FindUPDown(ahwnd: Thandle; sd: TSkinData; acanvas: TCanvas);
    procedure DrawControl1(dc: HDC; rc: TRect);
    procedure PaintControl1(adc: HDC = 0);
  public
    updown: TSkinUpDown;
//     procedure Init(aControl:Twincontrol;sd:TSkinData;acanvas:TCanvas;acolor:boolean=false);override;
//     procedure Inithwnd(ahwnd:Thandle;sd:TSkinData;acanvas:TCanvas);override;
    procedure AfterProc(var Message: TMessage); override;
    procedure DrawControl(dc: HDC; rc: TRect); override;
  end;

  TSkinSizer = class(TSkinControl)
  protected
  public
//      Procedure Init(sf:Tcomponent;sd:TSkinData;acanvas:TCanvas;acolor:boolean=false);override;
    function BeforeProc(var Message: TMessage): boolean; override;
    procedure DrawControl(dc: HDC; rc: TRect); override;
  end;

  TSkinBoxH = class(TSkinControl)
  protected
  public
    function BeforeProc(var Message: TMessage): boolean; override;
//      procedure DrawControl( dc:HDC; rc:TRect);override;
  end;

  TSkinTabSheet = class(TSkinControl)
  protected
  public
    procedure DrawControl(dc: HDC; rc: TRect); override;
//      Procedure Init(sf:Tcomponent;sd:TSkinData;acanvas:TCanvas;acolor:boolean=false);override;
    function BeforeProc(var Message: TMessage): boolean; override;
  end;

  TSkinObjImage = class(TSkinControl)
  protected
    procedure ChangeImage;
    procedure SetRzImage;
    procedure SetRzRadio;
    procedure SetDevCheck;
  public
    kind: integer;
    procedure Init(sf: Tcomponent; sd: TSkinData; acanvas: TCanvas; acolor: boolean = false); override;
    procedure SkinChange; override;
    procedure Unsubclass; override;
  end;

  TSkinAdvPage = class(TSkinControl)
  protected
    updown: TskinUpdown;
    procedure ChangeImage;
    procedure SetAdvPage;
    function FindScroll: boolean;
  public
    kind: integer;
    procedure Init(sf: Tcomponent; sd: TSkinData; acanvas: TCanvas; acolor: boolean = false); override;
    procedure SkinChange; override;
    procedure Unsubclass; override;
    procedure DrawControl(dc: HDC; rc: TRect); override;
  end;

  TScrollBarPos = record
    Btn: integer;
    ScrollArea: integer;
    Thumb: integer;
    ThumbPos: integer;
    MsgID: integer;
  end;
  TSkinScroll = (HB, VB);

  TSkinScrollBar = class(TSkinControl)
  protected
    nobe: boolean;
    procedure AfterProc(var Message: TMessage); override;
    function BeforeProc(var Message: TMessage): boolean; override;
    procedure SetScrollbarPos(message: TMessage);
    procedure Unsubclass; override;
    procedure DrawBorder(dc: HDC; rc: TRect);
    procedure BENCPAINT(adc: HDC);
  public
    hb, vb: TWscrollbar;
    postype: integer;
    painted: boolean;
    border: boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure InitScrollbar(acontrol: Twincontrol; sd: TSkinData; acanvas: TCanvas; sf: Tcomponent); virtual;
    procedure DrawControl(dc: HDC; rc: TRect); override;
    procedure SkinChange; override;
  end;

  TComboxScrollBar = class(TSkinControl)
  protected
    nobe: boolean;
    cw, len: integer;
    scrollpos: integer;
    thumbtop, thumbBottom: integer;
    OffsetSC, trackp: tpoint;
    trackthumb: integer;
    fdown: boolean;
    sbDir: integer;
    procedure AfterProc(var Message: TMessage); override;
    function BeforeProc(var Message: TMessage): boolean; override;
//    procedure SetScrollbarPos(message:TMessage);
    procedure PaintScrollbar(dc: HDC; rc: TRect; sbtype: integer);
    procedure Unsubclass; override;
    procedure GetThumb(rc: TRect);
    function WMNCPaint(var message: TMessage): boolean;
    function NCLButtonDown(var Message: TMessage): boolean;
  public
    postype: integer;
    painted: boolean;
    border: boolean;
//    Info:array[HB..VB] of SCROLLINFO;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DrawControl(dc: HDC; rc: TRect); override;
  end;

  TSkinScrollBarH = class(TSkinControl)
  protected
    procedure AfterProc(var Message: TMessage); override;
    procedure SetScrollbarPos(message: TMessage);
    procedure Unsubclass; override;
  public
    hb, vb: TWscrollbar;
    postype: integer;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Inithwnd(ahwnd: Thandle; sd: TSkinData; acanvas: TCanvas; sf: Tcomponent); override;
    procedure DrawControl(dc: HDC; rc: TRect); override;
  end;

  TSkinScControl = class(TSkinControl)
  protected
    downBtn: integer;
    SP: TScrollBarPos;
    sb: TWscrollbar;
    procedure AfterProc(var Message: TMessage); override;
  public
    procedure DrawControl(dc: HDC; rc: TRect); override;
    procedure InitScrollbar(acontrol: Twincontrol; sd: TSkinData; acanvas: TCanvas; sf: Tcomponent);
    procedure Unsubclass; override;
    destructor Destroy; override;
  end;

{  TSkinSCeControl = class(TSkinControl)
  protected
     sb:TEscrollbar;
     sceControl:Tcontrol;
     procedure AfterProc(var Message: TMessage);override;
  public
     procedure DrawControl( dc:HDC; rc:TRect);override;
     procedure InitScrollbar(acontrol:Twincontrol;ascrollbar:Tcontrol;aType:integer;
                             sd:TSkinData;sf:Tcomponent);
     procedure Unsubclass;override;
  end;}

  TSkinHeader = class(TSkinControl)
  protected
    Items: array of TRect;
    indexitem: integer;
//     trackinfo : TTrackMouseEvent;
    procedure WMMouseMove(var Message: TMessage);
    procedure DrawItem(ImgList: hImageList; acanvas: Tcanvas; rc: Trect; index: Integer);
    procedure DrawItemImgCaption(acanvas: TCanvas; rc: TRect;
      ImgList: hImageList; imgIndex: integer; text: widestring; talign: integer = DT_CENTER);
  public
    destructor Destroy; override;
    procedure Inithwnd(ahwnd: Thandle; sd: TSkinData; acanvas: TCanvas; sf: Tcomponent); override;
    procedure Init(sf: Tcomponent; sd: TSkinData; acanvas: TCanvas; acolor: boolean = false); override;
    function BeforeProc(var Message: TMessage): boolean; override;
    procedure AfterProc(var Message: TMessage); override;
    procedure DrawControl(dc: HDC; rc: TRect); override;
  end;

  TSkinListView = class(TSkinScrollBar)
  protected
    FHeaderInstance: Pointer;
    FDefHeaderProc: Pointer;
    hHwnd: THandle;
    header: Tskinheader;
    procedure SetHeaderOwnerDraw;
    procedure DrawHeaderItem(DrawItemStruct: TDrawItemStruct);
    procedure Drawheader;
    procedure drawitem(dc: HDC; rc: TRect; acolumn: TListColumn);
    procedure WMNotify(var Message: TWMNotify);
  public
    procedure InitScrollbar(acontrol: Twincontrol; sd: TSkinData; acanvas: TCanvas; sf: Tcomponent); override;
//     function BeforeProc(var Message: TMessage):boolean;override;
    procedure HeaderProc(var Message: TMessage);
  end;

function GetProperty(control: TObject; aprop: string): string;
function GetIntProperty(control: TObject; aprop: string): integer;
function GetEnumProperty(control: TObject; aprop: string): string;
function GetStringProp(control: TObject; aprop: string): widestring;
function GetObjProp(control: TObject; aprop: string; MinClass: TClass): Tobject;
function GetObjMethod(control: TObject; aprop: string): TMethod;
procedure SetProperty(control: TObject; aprop, value: string);
function StringReplaceW(s, s1, s2: widestring): widestring;
procedure CopyBMP(src: Tbitmap; var dst: Tbitmap);
procedure FillColor(dc: HDC; rc: TRect; acolor: Tcolor);
function GetDisableImg(FOriginal: TBitmap): Tbitmap;

procedure DrawArrow(ACanvas: TCanvas; X, Y, Orientation: integer);
procedure MyDrawCaption(acanvas: TCanvas; rc: TRect;
  text: widestring; enabled, defaulted: boolean; Alignment: TAlignment = taCenter);
procedure MyDrawImgCaption(acanvas: TCanvas; rc: TRect;
  ImgList: TCustomImageList; imgIndex: integer;
  text: string; enabled, defaulted: boolean; Alignment: TAlignment = taCenter);

 //{$R MPLAYER}

implementation
uses ImgUtil, WinSkinForm, winskindlg;

const
  _maxcaption = 80;

function IsPopupWindow(hwnd: Thandle): boolean;
var
  style: dword;
begin
  style := GetWindowLong(hWnd, GWL_STYLE);
  result := false;
  if (style and ws_popup) > 0 then result := true;
  if GetParent(hWnd) = 65556 then result := true;
end;

procedure CopyBMP(src: Tbitmap; var dst: Tbitmap);
begin
  dst.Width := src.Width;
  dst.Height := src.Height;
  dst.PixelFormat := src.PixelFormat;
  dst.Canvas.Draw(0, 0, src);
end;

function GetFormCaption(ahwnd: Thandle): widestring;
var
  buf: array[0..1000] of char;
begin
  result := '';
  if Win32PlatformIsUnicode then begin
    SetLength(Result, GetWindowTextLengthW(ahwnd) + 1);
    GetWindowTextW(ahwnd, PWideChar(Result), Length(Result));
    SetLength(Result, Length(Result) - 1);
  end else begin
    sendmessage(ahwnd, WM_GETTEXT, 1000, integer(@buf));
    result := strpas(buf);
  end;
end;

{procedure TControlSubClass.winpaint(var Message: TMessage);
var  DC: HDC;
  PS: TPaintStruct;
  hwnd : Thandle;
begin
     hwnd:=Twincontrol(control).handle;
     canvas.handle := BeginPaint(hwnd, ps);
     PaintControl;
     if not done then orgWindowProc(Message);
     EndPaint(hwnd, ps);
     Canvas.Handle := 0;
     message.result:=0;

  Canvas.Lock;
  try
    Canvas.Handle := message.wparam;
    try
     PaintControl;
    finally
    end;
  finally
    Canvas.Unlock;
  end;
  message.result:=0;
end;}

constructor TSkinControl.Create(AOwner: TComponent);
begin
  inherited create(aowner);
  hwnd := 0;
  Gcontrol := nil;
  control := nil;
  inited := false;
  skinstate := 0;
  skinform := nil;
  isunicode := false;
  skinned := true;
  kind := 0;
  sizing := false;
  parentbk := false;
end;

//in Tfrom : skincontrol will destory when owner (control) is destory
//in Hwnd window : skincontrol will destory when capture wm_ncdestory message
//Unsubclass : used for unskin, restore old color.

procedure TSkinControl.Init(sf: Tcomponent; sd: TSkinData; acanvas: TCanvas; acolor: boolean = false);
begin
  if inited then exit;
  newcolor := acolor;
  fsd := sd;
  skinform := sf;
  fCanvas := acanvas;
  control := Twincontrol(owner);
  hwnd := control.handle;

  isunicode := IsWindowUnicode(hwnd);

  OldWndProc := Control.WindowProc;
  Control.WindowProc := NewWndProc;
//   control.DoubleBuffered:=true;
  Twinskinform(skinform).addcontrollist(self);

//   Focused := (GetFocus= hWnd);
//   enabled := (GetWindowLong(hWnd,GWL_STYLE) and WS_DISABLED)=0;
//   caption:=getformcaption(hwnd);

  if newcolor then begin
    setparentbk(true);
    oldcolor := Taccontrol(control).color;
    Taccontrol(control).color := fsd.colors[csButtonFace];
  end;
  if parentbk then kind := 1;

  control.Invalidate;
  inited := true;
  skinstate := skin_active;
end;

procedure TSkinControl.SetColor;
begin
end;

procedure TSkinControl.SetParentBK(value: boolean);
var
  PropInfo: PPropInfo;
  s: string;
begin
{$IFDEF DELPHI_7}
  if xoParentBackGround in fsd.options then exit;
  if control = nil then exit;
  PropInfo := GetPropInfo(control, 'ParentBackground');
  if PropInfo <> nil then begin
    if value then begin
      s := lowercase(GetEnumProp(control, PropInfo));
      if s = 'true' then parentbk := true
      else parentbk := false;
      if parentbk then
        SetProperty(control, 'ParentBackground', 'False');
    end else begin
      if parentbk then
        SetProperty(control, 'ParentBackground', 'True');
    end;
  end;
{$ENDIF}
end;

procedure TSkinControl.RestoreColor;
begin
end;

procedure TSkinControl.Inithwnd(ahwnd: Thandle; sd: TSkinData; acanvas: TCanvas; sf: Tcomponent);
begin
  fsd := sd;
  fCanvas := acanvas;
  skinform := sf;
  hwnd := ahwnd;
  enabled := true;
  kind := 0;
  Twinskinform(skinform).addcontrollist(self);
  isunicode := IsWindowUnicode(hwnd);
  caption := getformcaption(hwnd);
  FObjectInst := MakeObjectInstance(NewWndProc);
  if isunicode then begin
    FPrevWndProc := Pointer(GetWindowLongw(hwnd, GWL_WNDPROC));
    SetWindowLongw(hwnd, GWL_WNDPROC, LongInt(FObjectInst));
  end else begin
    FPrevWndProc := Pointer(GetWindowLong(hwnd, GWL_WNDPROC));
    SetWindowLong(hwnd, GWL_WNDPROC, LongInt(FObjectInst));
  end;
  if hwnd <> 0 then
    InvalidateRect(hwnd, 0, true);
  inited := true;
  skinstate := skin_active;
end;

procedure TSkinControl.Unsubclass;
begin
  if not skinned then exit;
  skinned := false;
  if skinstate = skin_deleted then exit;
  if newcolor and (control <> nil) then begin
    setparentbk(false);
    Taccontrol(control).color := oldcolor;
  end;
end;

procedure TSkinControl.SkinChange;
begin
  if newcolor and (control <> nil) then
    Taccontrol(control).color := fsd.colors[csButtonFace];
  Invalidate;
//      setproperty(control,'Color',inttostr(fsd.colors[csButtonFace]));
end;

destructor TSkinControl.Destroy;
var
  s: string;
begin
{     s:=caption;
     if control<>nil then s:=s+' '+control.ClassName;
     if gcontrol<>nil then s:=s+' '+gcontrol.ClassName;
     skinaddlog('skincontrol destory '+s); }

  if assigned(oldwndproc) then begin
    if control <> nil then Control.WindowProc := OldWndProc;
    oldwndproc := nil;
  end;
  if fobjectinst <> nil then begin
    if isunicode then
      SetWindowLongw(hwnd, GWL_WNDPROC, LongInt(FPrevWndProc))
    else
      SetWindowLong(hwnd, GWL_WNDPROC, LongInt(FPrevWndProc));
    FreeObjectInstance(FObjectInst);
    fobjectinst := nil;
  end;

  if skinform <> nil then Twinskinform(skinform).DeleteControl(self);
  inherited destroy;
end;

function TSkinControl.GetParentColor(acolor: Tcolor): Tcolor;
var
  pcontrol: TacControl;
  PropInfo: PPropInfo;
begin
  result := acolor;
  if control <> nil then begin
    pcontrol := TAccontrol(control.parent);
    if pcontrol <> nil then begin
      PropInfo := GetPropInfo(pcontrol, 'Color');
      if (PropInfo <> nil) and
        (propinfo^.PropType^.Kind = tkInteger) then
        result := GetOrdProp(pcontrol, PropInfo)
      else
        result := acolor;
    end;
  end;
end;

procedure TSkinControl.NewWndProc(var Message: TMessage);
var
  s: string;
begin
  done := false;
  if message.msg = CN_SkinEnabled then begin
    skinned := message.WParam > 0;
    if skinned then Invalidate;
  end else
    if skinned then begin
      if BeforeProc(message) then begin
        default(Message);
        AfterProc(message);
      end;
    end
    else default(Message);
end;

procedure TSkinControl.Default(var Msg: TMessage);
begin
  if assigned(oldwndproc) then
    OldWndProc(Msg)
  else
    msg.result := CallWindowProc(FPrevWndProc, hwnd, Msg.msg, msg.WParam, msg.LParam);
end;

{procedure TSkinControl.Notification(AComponent: TComponent;Operation: TOperation);
var j:integer;
    sf:TWinskinform;
begin
  inherited Notification(AComponent, Operation);

  if (Operation = opInsert) and (AComponent <> nil)
     and (AComponent is Tcontrol) then begin
      sf:=TWinskinform(skinform);
      sf.AddComp(Tcontrol(acomponent),sf.FForm);
      skinaddlog(format('Notification Insert :%s,%s',[acomponent.classname,acomponent.name]));
  end;
end;  }

procedure TSkinControl.MouseLeave;
begin
  if hwnd > 0 then sendmessage(hwnd, CM_MOUSELEAVE, 0, 0);
//  Twinskinform(owner).activeskincontrol:=nil;
end;

procedure TSkinControl.Invalidate;
begin
  //if control<>nil then control.Invalidate
  //else
  if gcontrol <> nil then gcontrol.invalidate
  else if (hwnd > 0) then begin
    InvalidateRect(hwnd, 0, true);
    UpdateWindow(hwnd);
  end;
end;

procedure TSkinControl.PaintControl(adc: HDC = 0);
var
  dc: HDC;
  rc: TRect;
begin
  if GetWindowRect(hWnd, rc) then begin;
    try
      boundsrect := rc;
      OffsetRect(rc, -rc.left, -rc.top);
      if (adc = 0) then begin
        DC := GetWindowDC(hWnd);
        try
          Drawcontrol(dc, rc);
        finally
          ReleaseDC(hwnd, DC);
        end;
      end else begin
         //dc:=adc;
         //boundsrect:=rc;
         //OffsetRect( rc, -rc.left, -rc.top );
        Drawcontrol(adc, rc);
      end;
    except
    end;
  end;
end;

procedure FillColor(dc: HDC; rc: TRect; acolor: Tcolor);
var
  Brush: HBrush;
begin
  Brush := CreateSolidBrush(acolor);
  try
    fillrect(dc, rc, brush);
  finally
    DeleteObject(Brush);
  end;
end;

procedure TSkinControl.FillBG(dc: HDC; rc: TRect);
var
  Brush: HBrush;
begin
  Brush := CreateSolidBrush(fsd.colors[csButtonFace]);
  try
    fillrect(dc, rc, brush);
  finally
    DeleteObject(Brush);
  end;
end;

function TSkinControl.GetWindowLongEx(ahWnd: HWND; nIndex: Integer): Longint;
begin
  if isunicode then
    result := GetWindowLongw(ahWnd, nIndex)
  else
    result := GetWindowLong(ahWnd, nIndex);
end;

procedure TSkinControl.FillParentBG(dc: HDC; rc: TRect);
var
  Brush: HBrush;
  acolor: Tcolor;
begin
  acolor := getparentcolor(fsd.colors[csButtonFace]);
  Brush := CreateSolidBrush(COLORREF(acolor));
  try
    fillrect(dc, rc, brush);
  finally
    DeleteObject(Brush);
  end;
end;

procedure TSkinControl.DrawFocus(hDC: HDC; wString: WideString; rc: TRect; uFormat: UINT);

var
  r1: Trect;
//const
//  Alignments: array[TAlignment] of Word = (DT_LEFT,DT_RIGHT,DT_CENTER );
begin
  r1 := rc;
  Tnt_DrawTextW(hdc, caption, r1, uformat or DT_CALCRECT or DT_NOCLIP);
  if uformat and dt_center > 0 then
    OffsetRect(r1, ((rc.right - rc.left) - (r1.right - r1.left)) div 2,
      ((rc.Bottom - rc.Top) - (r1.Bottom - r1.Top)) div 2 - 1)
  else if uformat and DT_RIGHT > 0 then begin
    OffsetRect(r1, ((rc.right - rc.left) - (r1.right - r1.left)), 0);
  end;
  InflateRect(r1, 2, 1);
  if r1.Top < rc.Top then r1.Top := rc.Top;
  if r1.Bottom > rc.Bottom then r1.Bottom := rc.Bottom;
  if r1.Right > rc.Right then r1.Right := rc.Right;
  if r1.Left < rc.Left then r1.Left := rc.Left;
  DrawFocusRect(hdc, r1);
end;

procedure TSkinControl.doLogMsg(aid: string; msg: TMessage);
var
  s: string;
begin
{$IFDEF test}
  s := MsgtoStr(msg);
  if s = '' then exit;
  if SkinCanLog then Logstring.add(aid + s);
{$ENDIF}
end;

procedure TSkinControl.AfterProc(var Message: TMessage);
begin
  case message.msg of
    WM_Paint:
      PaintControl(message.WParam);
    WM_KILLFOCUS, WM_SETFOCUS:
      Invalidate;
//          PaintControl;
    WM_SETTEXT: begin
        Invalidate;
      end;
    CN_SkinEnabled: skinned := message.WParam > 0;
    wm_enable, CM_ENABLEDCHANGED: Invalidate;
  end;
end;

function TSkinControl.BeforeProc(var Message: TMessage): boolean;
begin
  result := false;
  case message.msg of
    CN_IsSkined: message.result := 1;
    WM_NCDESTROY: begin
        result := false;
        skinstate := skin_deleted;
        default(message);
        if skinned then begin
             //skinned:=false;
          Unsubclass;
        end;
          //can't free,leave it,until skinform free;
          //         free;
      end;
  else result := true;
  end;
end;

procedure TSkinControl.DrawControl(dc: HDC; rc: TRect);
begin
end;

function TSkinControl.GetState: integer;
begin
  result := 1;
end;

function GetProperty(control: TObject; aprop: string): string;
var
  PropInfo: PPropInfo;
  s: string;
  i: integer;
begin
  s := '';
  i := 0;
  if control <> nil then begin
    PropInfo := GetPropInfo(control, aprop);
    if PropInfo <> nil then begin
      if propinfo^.PropType^.Kind = tkEnumeration then
        s := GetEnumProp(control, PropInfo)
      else if propinfo^.PropType^.Kind = tkInteger then begin
//           i:= GetInt64Prop(control,PropInfo);
        i := GetOrdProp(control, PropInfo);
        s := inttostr(i);
      end;
    end;
  end;
  result := s;
end;

function GetIntProperty(control: TObject; aprop: string): integer;
var
  PropInfo: PPropInfo;
begin
  result := -1;
  if control <> nil then begin
    PropInfo := GetPropInfo(control, aprop);
    if (PropInfo <> nil) and
      (propinfo^.PropType^.Kind = tkInteger) then begin
//           i:= GetInt64Prop(control,PropInfo);
      result := GetOrdProp(control, PropInfo);
    end;
  end;
end;

function GetEnumProperty(control: TObject; aprop: string): string;
var
  PropInfo: PPropInfo;
begin
  result := '';
  if control <> nil then begin
    PropInfo := GetPropInfo(control, aprop);
    if (PropInfo <> nil) then
      result := GetEnumProp(control, PropInfo);
  end;
end;

{$IFNDEF COMPILER_5a}

procedure AssignWideStr(var Dest: WideString; const Source: WideString);
begin
  Dest := Source;
end;

procedure IntGetWideStrProp(Instance: TObject; PropInfo: PPropInfo;
  var Value: WideString); assembler;
asm
        { ->    EAX Pointer to instance         }
        {       EDX Pointer to property info    }
        {       ECX Pointer to result string    }

        PUSH    ESI
        PUSH    EDI
        MOV     EDI,EDX

        MOV     EDX,[EDI].TPropInfo.Index       { pass index in EDX }
        CMP     EDX,$80000000
        JNE     @@hasIndex
        MOV     EDX,ECX                         { pass value in EDX }
@@hasIndex:
        MOV     ESI,[EDI].TPropInfo.GetProc
        CMP     [EDI].TPropInfo.GetProc.Byte[3],$FE
        JA      @@isField
        JB      @@isStaticMethod

@@isVirtualMethod:
        MOVSX   ESI,SI                          { sign extend slot offset }
        ADD     ESI,[EAX]                       { vmt + slot offset }
        CALL    DWORD PTR [ESI]
        JMP     @@exit

@@isStaticMethod:
        CALL    ESI
        JMP     @@exit

@@isField:
  AND  ESI,$00FFFFFF
  MOV  EDX,[EAX+ESI]
  MOV  EAX,ECX
  CALL  AssignWideStr

@@exit:
        POP     EDI
        POP     ESI
end;

function GetWideStrProp(Instance: TObject; PropInfo: PPropInfo): WideString;
begin
  IntGetWideStrProp(Instance, PropInfo, Result);
end;

procedure SetWideStrProp(Instance: TObject; PropInfo: PPropInfo;
  const Value: WideString); assembler;
asm
        { ->    EAX Pointer to instance         }
        {       EDX Pointer to property info    }
        {       ECX Pointer to string value     }

        PUSH    ESI
        PUSH    EDI
        MOV     ESI,EDX

        MOV     EDX,[ESI].TPropInfo.Index       { pass index in EDX }
        CMP     EDX,$80000000
        JNE     @@hasIndex
        MOV     EDX,ECX                         { pass value in EDX }
@@hasIndex:
        MOV     EDI,[ESI].TPropInfo.SetProc
        CMP     [ESI].TPropInfo.SetProc.Byte[3],$FE
        JA      @@isField
        JB      @@isStaticMethod

@@isVirtualMethod:
        MOVSX   EDI,DI
        ADD     EDI,[EAX]
        CALL    DWORD PTR [EDI]
        JMP     @@exit

@@isStaticMethod:
        CALL    EDI
        JMP     @@exit

@@isField:
  AND  EDI,$00FFFFFF
  ADD  EAX,EDI
  MOV  EDX,ECX
  CALL  AssignWideStr

@@exit:
        POP     EDI
        POP     ESI
end;
{$ENDIF}
//TypInfo.pas

function GetStringProp(control: TObject; aprop: string): widestring;
var
  PropInfo: PPropInfo;
  s: string;
begin
  result := '';
  if control <> nil then begin
    PropInfo := GetPropInfo(control, aprop);
    if PropInfo <> nil then begin
      case PropInfo^.PropType^.Kind of
{$IFDEF VER200}
        tkUString: result := GetStrProp(control, PropInfo);
{$ENDIF}
        tkWString: result := GetWideStrProp(control, PropInfo);
      else result := StrToWideStr(GetStrProp(control, PropInfo));
      end;
    end;
  end;
end;

function GetControlCaption(control: TACControl): widestring;
var
  PropInfo: PPropInfo;
  s: string;
  aprop: string;
begin
  result := '';
  aprop := 'Caption';
  if control <> nil then begin
    PropInfo := GetPropInfo(control, aprop);
    if PropInfo <> nil then begin
      case PropInfo^.PropType^.Kind of
        tkWString: result := control.caption;
      else result := StrToWideStr(control.caption);
      end;
    end;
  end;
end;

function GetObjMethod(control: TObject; aprop: string): TMethod;
var
  PropInfo: PPropInfo;
begin
//   result:=nil;
  if control <> nil then begin
    PropInfo := GetPropInfo(control, aprop);
    if PropInfo <> nil then begin
      result := GetMethodProp(control, PropInfo);
    end;
  end;
end;

function GetObjProp(control: TObject; aprop: string; MinClass: TClass): Tobject;
var
  PropInfo: PPropInfo;
begin
  result := nil;
  if control <> nil then begin
    PropInfo := GetPropInfo(control, aprop);
    if PropInfo <> nil then begin
      result := GetObjectProp(control, PropInfo, MinClass);
    end;
  end;
end;

procedure SetProperty(control: TObject; aprop, value: string);
var
  PropInfo: PPropInfo;
begin
  if control <> nil then begin
    PropInfo := GetPropInfo(control, aprop);
    if PropInfo <> nil then begin
      if propinfo^.PropType^.Kind = tkEnumeration then
        SetEnumProp(control, PropInfo, value)
      else if propinfo^.PropType^.Kind = tkInteger then
        SetOrdProp(control, PropInfo, strtoint(value))
      else if propinfo^.PropType^.Kind = tkString then
        SetStrProp(control, PropInfo, value)
      else if propinfo^.PropType^.Kind = tkLString then
        SetStrProp(control, PropInfo, value)
      else if propinfo^.PropType^.Kind = tkWString then
        SetStrProp(control, PropInfo, value);
    end;
  end;
end;

procedure TSkinButton.DoMouseDown(var Message: TWMMouse);
var
  acontrol: Taccontrol;
  p: Tpoint;
begin
  acontrol := TACcontrol(control);
  with Message do
    if (acontrol.Width > 32768) or (acontrol.Height > 32768) then begin
      GetCursorPos(p);
      p := acontrol.ScreenToClient(p);
      acontrol.MouseDown(mbLeft, KeysToShiftState(Keys), p.X, p.Y);
//        with acontrol.CalcCursorPos do
//          acontrol.MouseDown(mbLeft, KeysToShiftState(Keys), p.X, p.Y);
    end else
      acontrol.MouseDown(mbLeft, KeysToShiftState(Keys), Message.XPos, Message.YPos);
end;

{procedure TSkinButton.SetRedraw(b:boolean);
begin
   redraw:=b;
   if b then begin
       KillTimer(hwnd, 1);
       sendmessage(hwnd,WM_SETREDRAW,1,0);
       Application.ProcessMessages;
   end else begin
       KillTimer(hwnd, 1);
       sendmessage(hwnd,WM_SETREDRAW,0,0);
       SetTimer(hwnd, 1, 100, nil);
   end;
end;   }

procedure TSkinButton.SetRedraw(b: boolean);
var
  dw: dword;
begin
//   redraw:=b;
  dw := GetWindowLong(hwnd, GWL_STYLE);
  if b then begin
    KillTimer(hwnd, 1);
    if redraw then
      dw := dw or WS_VISIBLE;
    redraw := false;
  end else begin
    KillTimer(hwnd, 1);
    redraw := true;
    dw := dw and not WS_VISIBLE;
    SetTimer(hwnd, 1, 100, nil);
  end;
  SetWindowLong(hwnd, GWL_STYLE, dw);
end;

function TSkinButton.BeforeProc(var Message: TMessage): boolean;
var
  s: string;
  sf: Twinskinform;
begin
{$IFDEF buttontest}
  s := MsgtoStr(message);
  if s <> '' then begin
    s := format('Button %s %1x %s', [caption, hwnd, s]);
    fsd.dodebug(s);
      //skinaddlog(s);
  end;
{$ENDIF}
{    if message.msg= CM_VISIBLECHANGED then begin
        if message.wParam=0 then begin
            if redraw then setredraw(true);
        end;
        result:=true;
        exit;
    end else if isdefault then begin
       default(message);
       result:=false;
       exit;
    end;  }

  result := true;
  case message.msg of
    WM_LBUTTONDOWN, WM_LBUTTONDBLCLK:
      begin
        if not Focused then begin
          SetFocus(hwnd);
        end;
        state := state + [scDown];
        PaintControl(0);
        result := false;
        if (kind = 0) and (control <> nil) then DoMouseDown(TWMMouse(message));
      end;
{   WM_LBUTTONUP:
      if scDown in state then begin
         state:=state-[scDown];
         PaintControl(0);
         setredraw(false);
         skinned:=false;
         sendmessage(hwnd,WM_LBUTTONDOWN,message.WParam,message.LParam);
         application.ProcessMessages;
         sendmessage(hwnd,WM_LBUTTONUP,message.WParam,message.LParam);
         skinned:=true;
         setredraw(true);
         if IsWindowVisible(hwnd) then
            Invalidate;
         application.ProcessMessages;
         result:=false;
      end;  }
{    WM_LBUTTONDOWN, WM_LBUTTONDBLCLK:
      begin
       if not Focused then  begin
        SetFocus(hwnd);
       end;
       state:=state+[scDown];
       setredraw(false);
//       sendmessage(hwnd,WM_SETREDRAW,0,0);
       default(message);
//       sendmessage(hwnd,WM_SETREDRAW,1,0);
       setredraw(true);
       PaintControl(0);
       result:=false;
      end;
    WM_LBUTTONUP:
      if scDown in state then begin
         state:=state-[scDown];
         setredraw(false);
         default(message);
         setredraw(true);
         if IsWindowVisible(hwnd) then
            Invalidate;
         result:=false;
      end;}
    WM_TIMER: begin
        setredraw(true);
        result := false;
      end;
    WM_ERASEBKGND: begin
        message.Result := 1;
        result := false;
      end;
    wm_paint: begin
        wmpaint(message);
        result := false;
      end;
{    wm_enable,CM_ENABLEDCHANGED:begin
        WMEnable(message);
        result:=false;
      end;   }
  else result := inherited beforeProc(message);
  end;
end;

{function TSkinButton.BeforeProc(var Message: TMessage):boolean;
 var s:string;
     sf: Twinskinform;
begin
    if message.msg= CM_VISIBLECHANGED then begin
        if message.wParam=0 then begin
            if redraw then setredraw(true);
        end;
        result:=true;
        exit;
    end else if isdefault then begin
       default(message);
       result:=false;
       exit;
    end;

    result:=true;
    case message.msg of
    WM_LBUTTONDOWN, WM_LBUTTONDBLCLK:
      begin
       if not Focused then  begin
        SetFocus(hwnd);
       end;
       state:=state+[scDown];
       PaintControl(0);
       result:=false;
      end;
    WM_LBUTTONUP:
      if scDown in state then begin
         state:=state-[scDown];
         PaintControl(0);
         setredraw(false);
         isdefault:=true;
         sendmessage(hwnd,WM_LBUTTONDOWN,message.WParam,message.LParam);
         sendmessage(hwnd,WM_LBUTTONUP,message.WParam,message.LParam);
         isdefault:=false;
         setredraw(true);
         if IsWindowVisible(hwnd) then
            Invalidate;
         result:=false;
      end;
    WM_TIMER : begin
         setredraw(true);
         result:=false;
       end;
    WM_ERASEBKGND:begin
         message.Result:=1;
         result:=false;
      end;
    wm_paint: begin
        wmpaint(message);
        result:=false;
      end;
    else result:=inherited beforeProc(message);
    end;
end;}

procedure TSkinButton.WMEnable(var Message: TMessage);
var
  dw: dword;
begin
{   dw:=GetWindowLong(hWnd,GWL_STYLE);
   dw := dw and ( not WS_VISIBLE);
   SetWindowLong( hwnd, GWL_STYLE, dw);
   dw := dw or WS_VISIBLE;
   SetWindowLong( hwnd, GWL_STYLE, dw);}
  default(Message);
  Invalidate;
end;

procedure TSkinButton.AfterProc(var Message: TMessage);
var
  sf: Twinskinform;
  s: string;
begin
  case message.msg of
{     CM_MOUSEENTER:
      if Enabled then begin
        state:=state+[scMouseIn];
        Invalidate;
      end;
   CM_MOUSELEAVE:
      if Enabled then begin
        state:=state-[scMouseIn];
        state:=state-[scDown];
        Invalidate;
      end;  }

    WM_MOUSEMove: begin
        if enabled and (not (scmousein in state)) then begin
          state := state + [scMouseIn];
          Invalidate;
        end;
        WinSkinData.DoTrackMouse(hwnd);
      end;
    WM_MOUSELEAVE: begin
//          if (scDown in state) then begin
        state := state - [scMouseIn];
        state := state - [scDown];
        invalidate;
//          end;
      end;

    WM_LBUTTONUP:
      if scDown in state then begin
        state := state - [scDown];
         //PaintControl(0);
        Invalidate;
        s := lowercase(GetWindowClassname(hwnd));
        if control <> nil then begin
          TACcontrol(control).Click;
//           postMessage(getparent(hwnd),WM_COMMAND,BN_CLICKED,hWnd)
        end else if (s = 'tbutton') then
          postMessage(getparent(hwnd), WM_COMMAND, BN_CLICKED, hWnd)
        else
          postMessage(getparent(hwnd), WM_COMMAND, BN_CLICKED * $100 + GetDlgCtrlID(hwnd), hWnd);
      end;

    WM_SETTEXT: PaintControl(0);
    CM_FOCUSCHANGED: invalidate;
    CM_DIALOGKEY: invalidate;
    WM_KEYDOWN:
      if Message.WParam = VK_SPACE then begin
        state := state + [scDown];
        Invalidate;
      end;

    WM_KEYUP:
      if Message.WParam = VK_SPACE then begin
        state := state - [scDown];
        Invalidate;
      end;
  else inherited AfterProc(message);
  end;
end;

{procedure TSkinButton.DrawControl( dc:HDC; rc:TRect);
var i:integer;
    r1:Trect;
    acolor:Tcolor;
    bfont,cfont:Hfont;
    temp:Tbitmap;
begin
    if fsd.button=nil then exit;
    if fsd.Button.map.empty then exit;
    i:=1;

    temp:=Tbitmap.create;

    Focused := (GetFocus= hWnd);
    enabled := (GetWindowLong(hWnd,GWL_STYLE) and WS_DISABLED)=0;
    caption:=getformcaption(hwnd);
    if (caption='') and (control<>nil) then
      caption:=Taccontrol(control).caption;

    if focused then i:=4;
    if (scDown in state)  then i:=2
    else if (scMouseIn in state) then i:=4;
    if not enabled then i:=3;

    r1:=rc;
    offsetrect(r1,-r1.left,-r1.top);
    temp.width:=r1.right;
    temp.height:=r1.bottom;
    DrawBMPSkin(temp,r1,fsd.button,i,5,fsd.button.Trans);

    bfont:=sendmessage(hwnd,wm_getfont,0,0);
    cfont:=selectobject(temp.canvas.handle,bfont);

    SetTextColor(temp.canvas.handle,fsd.colors[csButtonText]);
    if (i=1) then
       SetTextColor(temp.canvas.handle,fsd.button.normalcolor2);
    if (i=4) then
       SetTextColor(temp.canvas.handle,fsd.button.overcolor2);
    if (i=2) then
       SetTextColor(temp.canvas.handle,fsd.button.downcolor2);
    if not enabled then
      SetTextColor(temp.canvas.handle,COLORREF(clBtnShadow));

    DrawCaption(temp.canvas,r1,caption,enabled,false);
//    DrawBuf( dc,rc);
    BitBlt(dc,rc.left ,rc.top,rc.right-rc.left,rc.bottom-rc.Top,
                 temp.Canvas.Handle ,0 ,0 ,Srccopy);
    selectobject(temp.canvas.handle,cfont);
    temp.Free;
end;}

constructor TSkinButton.Create(AOwner: TComponent);
begin
  inherited create(aowner);
  btemp := Tbitmap.create;
  trans := false;
  isdefault := false;
end;

destructor TSkinButton.Destroy;
begin
  if btemp <> nil then btemp.free;
  btemp := nil;
  inherited destroy;
end;

procedure TSkinButton.Init(sf: Tcomponent; sd: TSkinData; acanvas: TCanvas; acolor: boolean = false);
var
  s: string;
begin
  inherited init(sf, sd, acanvas, acolor);
  kind := 0;
  s := lowercase(control.classname);
  if pos('trz', s) = 1 then kind := 1;
  if pos('tel', s) = 1 then kind := 1;
  if (control.Tag = 5555) or (xoTransparent in fsd.options) then
    trans := true;
end;

procedure TSkinButton.DrawBtnText(acanvas: TCanvas; rc: TRect;
  text: string; Alignment: word = DT_CENTER);
const
  Alignments: array[TAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
var
  r1: TRect;
  DrawStyle: Longint;
  s, s1: string;
begin
  DrawStyle := DT_EXPANDTABS or Alignment or dt_WordBreak;
{   if multiline then begin
      DrawStyle := DrawStyle or dt_WordBreak;
      s:=WideStringToStringEx(caption);
      s:=stringreplace(s,'||',#13#10,[rfReplaceAll]);
      caption := StrToWideStr(s);
   end;}
  s := StrToWideStr('||');
  s1 := StrToWideStr(#13#10);
  caption := StringReplaceW(caption, s, s1);
  r1 := rc;
  inflaterect(r1, -2, -2);
  SetBkMode(aCanvas.Handle, TRANSPARENT);
  with ACanvas do begin
    Tnt_DrawTextW(ACanvas.Handle, caption, r1, DrawStyle or DT_CALCRECT or DT_NOCLIP);
    offsetrect(r1, -r1.Left, -r1.Top);
    drawstyle := checkBiDi(drawStyle);
     //DrawText(ACanvas.Handle,PChar(Text),Length(Text),r1,DrawStyle or DT_CALCRECT or DT_NOCLIP);
    if Alignment = dt_center then
      OffsetRect(r1, ((rc.right - rc.left) - (r1.right - r1.left)) div 2,
        ((rc.Bottom - rc.Top) - (r1.Bottom - r1.Top)) div 2 - 1)
    else begin
      OffsetRect(r1, 0, ((rc.Bottom - rc.Top) - (r1.Bottom - r1.Top)) div 2 - 1);
      r1.Left := rc.left;
      r1.right := rc.Right;
    end;
//     DrawText(ACanvas.Handle, PChar(Text),-1,r1,DrawStyle);
    Tnt_DrawTextW(ACanvas.Handle, caption, r1, DrawStyle);
    SetBkMode(aCanvas.Handle, OPAQUE);
    if focused and not (xoNoFocusRect in fsd.Options) then begin
      InflateRect(r1, 2, 2);
      DrawFocusRect(r1);
    end;
  end;
end;

function TSkinButton.GetFontColor(var acolor: Tcolor): boolean;
var
  font: Tfont;
  b: boolean;
  PropInfo: PPropInfo;
begin
  b := false;
  font := Tfont(GetObjProp(control, 'Font', Tfont));
  if font <> nil then begin
    PropInfo := GetPropInfo(font, 'Color');
    if (PropInfo <> nil) and
      (propinfo^.PropType^.Kind = tkInteger) then begin
      acolor := GetOrdProp(control, PropInfo);
      b := true;
    end;
  end;
  result := b;
end;

procedure TSkinButton.DrawControl(dc: HDC; rc: TRect);
var
  i: integer;
  r1: Trect;
  acolor, color0: Tcolor;
  bfont, cfont: Hfont;
  style: dword;
  isdefault: boolean;
  font: Tfont;
  s: string;
begin
  if fsd.button = nil then exit;
  if fsd.Button.map.empty then exit;
  i := 1;

  style := GetWindowLong(hWnd, GWL_STYLE);
  Focused := (GetFocus = hWnd);
  enabled := (style and WS_DISABLED) = 0;
//    dw:= ( style and $0f );
//    isdefault := (( style and $0f ) = BS_DEFPUSHBUTTON );
  s := lowercase(GetEnumProperty(control, 'Default'));
  isdefault := (s = 'true');

  multiline := false;

  if (control <> nil) then begin
    caption := GetStringProp(control, 'Caption');
    s := lowercase(GetEnumProperty(control, 'MultiLine'));
    if s = 'true' then multiline := true;
  end else
    caption := getformcaption(hwnd);

  if focused then i := 5;
  if isdefault then i := 5;
  if (scDown in state) then i := 2
  else if (scMouseIn in state) then i := 4;
  if not enabled then i := 3;

  r1 := rc;
  offsetrect(r1, -r1.left, -r1.top);
  btemp.width := r1.right;
  btemp.height := r1.bottom;

  if trans then
    DrawParentImage(control, btemp.canvas.handle, true)
  else
    fillBG(btemp.canvas.handle, r1);
{   if (not  (xoTransparent in fsd.options)) or (control=nil) then begin
     fillBG(btemp.canvas.handle,r1);
   end
   else if control<>nil then
      DrawParentImage(control,btemp.canvas.handle,true);}
   //else FillBG(btemp.canvas.handle,r1);     }

  DrawSkinMap(btemp.canvas.handle, r1, fsd.button, I, fsd.Button.frame);

  if control <> nil then begin
    font := Tfont(GetObjProp(control, 'Font', Tfont));
    if font <> nil then btemp.canvas.font.assign(font);
//      if (i=1) and (fsd.button.newnormal) then
    if (fsd.button.newnormal) then
      btemp.canvas.Font.Color := fsd.button.normalcolor2;
    if (i = 4) and (fsd.button.newover) then
      btemp.canvas.Font.Color := fsd.button.overcolor2;
    if (i = 2) and (fsd.Button.newdown) then
      btemp.canvas.Font.Color := fsd.button.downcolor2;
    if not enabled then
      btemp.canvas.Font.Color := clBtnShadow;
//      getfontcolor(color0);
  end else begin
    bfont := sendmessage(hwnd, wm_getfont, 0, 0);
    cfont := selectobject(btemp.canvas.handle, bfont);
    SetTextColor(btemp.canvas.handle, ColorToRGB(fsd.colors[csButtonText]));
//    if (i=1) and (fsd.button.newnormal) then
    if (fsd.button.newnormal) then
      SetTextColor(btemp.canvas.handle, ColorToRGB(fsd.button.normalcolor2));
//    if ((i=4) or (i=5)) and (fsd.button.newover) then
    if (i = 4) and (fsd.button.newover) then
      SetTextColor(btemp.canvas.handle, ColorToRGB(fsd.button.overcolor2));
    if (i = 2) and (fsd.Button.newdown) then
      SetTextColor(btemp.canvas.handle, ColorToRGB(fsd.button.downcolor2));
    if not enabled then
      SetTextColor(btemp.canvas.handle, ColorToRGB(clBtnShadow));
  end;

  DrawBtnText(btemp.canvas, r1, caption);
//    Bitmapdraw(dc,rc,btemp);
  BitBlt(dc, rc.left, rc.top, rc.right - rc.left, rc.bottom - rc.Top,
    btemp.Canvas.Handle, 0, 0, Srccopy);
  selectobject(btemp.canvas.handle, cfont);
{$IFDEF buttontest}
  skinaddlog(format('Button Draw %s %1x %1x', [caption, hwnd, dc]));
{$ENDIF}

end;

{procedure TSkinButton.DrawControl( dc:HDC; rc:TRect);
var i:integer;
    r1:Trect;
    acolor:Tcolor;
    bfont,cfont:Hfont;
begin
    if fsd.button=nil then exit;
    if fsd.Button.map.empty then exit;
    i:=1;

    Focused := (GetFocus= hWnd);
    enabled := (GetWindowLong(hWnd,GWL_STYLE) and WS_DISABLED)=0;
    caption:=getformcaption(hwnd);
    if (caption='') and (control<>nil) then
      caption:=Taccontrol(control).caption;

    if focused then i:=4;
    if (scDown in state)  then i:=2
    else if (scMouseIn in state) then i:=4;
    if not enabled then i:=3;

    r1:=rc;
    offsetrect(r1,-r1.left,-r1.top);
    bg.width:=r1.right;
    bg.height:=r1.bottom;
    DrawSkin(r1,fsd.button,i,5,fsd.button.Trans);
//    DrawSkinMap( dc:HDC; rc:TRect;aObject:TdataSkinObject;I,N:integer)

    bfont:=sendmessage(hwnd,wm_getfont,0,0);
    cfont:=selectobject(bg.canvas.handle,bfont);

    SetTextColor(bg.canvas.handle,fsd.colors[csButtonText]);
    if (i=1) then
       SetTextColor(bg.canvas.handle,fsd.button.normalcolor2);
    if (i=4) then
       SetTextColor(bg.canvas.handle,fsd.button.overcolor2);
    if (i=2) then
       SetTextColor(bg.canvas.handle,fsd.button.downcolor2);
    if not enabled then
      SetTextColor(bg.canvas.handle,COLORREF(clBtnShadow));

    DrawCaption(bg.canvas,r1,caption,enabled,false);
    SetBkMode(bg.canvas.handle,OPAQUE);
    DrawBuf( dc,rc);
    selectobject(bg.canvas.handle,cfont);

end;}

{procedure TButtonGlyph.CalcButtonLayout(Canvas: TCanvas; const Client: TRect;
  const Offset: TPoint; const Caption: string; Layout: TButtonLayout; Margin,
  Spacing: Integer; var GlyphPos: TPoint; var TextBounds: TRect;
  BiDiFlags: LongInt);}

{procedure TSkinBitButton.DrawControl( dc:HDC; rc:TRect);
var btn:TBitBtn;
    acolor:Tcolor;
    i,n,j:integer;
    spacing,margin:integer;
    r1,TextBounds:Trect;
    Layout: TButtonLayout;
    TextPos: TPoint;
    GlyphPos, ClientSize, GlyphSize, TextSize: TPoint;
    TotalSize: TPoint;
    DrawStyle: Longint;
    cfont,bfont:Hfont;
begin
    if fsd.button=nil then exit;
    if fsd.Button.map.empty then exit;
    DrawStyle:=DT_LEFT;}

function StringReplaceW(s, s1, s2: widestring): widestring;
var
  i, p, l: integer;
begin
  result := s;
  l := length(s);
  p := pos(s1, s);
  if p > 0 then begin
    result := copy(s, 1, p - 1) + s2 + copy(s, p + length(s1), l);
  end;
end;

procedure TSkinBitButton.DrawControl(dc: HDC; rc: TRect);
var
  acolor: Tcolor;
  i, j: integer;
  r1, TextBounds: Trect;
  Layout: TButtonLayout;
  NumGlyphs, margin, spacing: integer;
  TextPos: TPoint;
  GlyphPos, ClientSize, GlyphSize, TextSize: TPoint;
  TotalSize: TPoint;
  DrawStyle: Longint;
  cfont, bfont: Hfont;
  font: Tfont;
  style: dword;
  s, s1: widestring;
  bglyph: Tbitmap;
  bglist: Timagelist;
  imageindex, disabledindex: integer;
  isdefault: boolean;
  s2, bname: string;
begin
  if fsd.button = nil then exit;
  if fsd.Button.map.empty then exit;

  s := lowercase(GetEnumProperty(gcontrol, 'Visible'));
  if s = 'false' then exit;

  if Length(PicField) > 0 then begin
    drawPicControl(dc, rc);
    exit;
  end;
//    DrawStyle:=DT_LEFT;

  Focused := (GetFocus = hWnd);
  style := GetWindowLong(hWnd, GWL_STYLE);
  enabled := (style and WS_DISABLED) = 0;
//    caption:=getformcaption(hwnd);
    //dw :=  ( style and $0f );
    //isdefault := (dw = BS_DEFPUSHBUTTON );
  s2 := lowercase(GetEnumProperty(control, 'Default'));
  isdefault := (s2 = 'true');
  if control <> nil then
    caption := GetStringProp(control, 'Caption')
//       caption := GetControlCaption(TACControl(control))
  else
    caption := getformcaption(hwnd);
//    btn:=TBitBtn(control);
//    if btn.default then i:=5;
//    s:=lowercase(GetEnumProperty(control,'Default'));

  i := 1;
  if Focused then i := 5;
  if isdefault then i := 5;
  if (scDown in state) then i := 2
  else if (scMouseIn in state) then i := 4;
  if not enabled then i := 3;

  case i of
    1: j := 1;
    2: j := 3;
    3: j := 2;
    4: j := 1;
  else j := 1;
  end;

  r1 := rc;
  offsetrect(r1, -r1.left, -r1.top);
  btemp.width := r1.right;
  btemp.height := r1.bottom;

  bfont := sendmessage(hwnd, wm_getfont, 0, 0);
  cfont := selectobject(btemp.canvas.handle, bfont);

  if trans then
    DrawParentImage(control, btemp.canvas.handle, true)
  else
    fillBG(btemp.canvas.handle, r1);

  DrawSkinMap(btemp.canvas.handle, r1, fsd.button, I, fsd.button.frame);

  ClientSize := Point(rc.Right - rc.Left, rc.Bottom - rc.Top);

  font := Tfont(GetObjProp(control, 'Font', Tfont));
  bglyph := Tbitmap(GetObjProp(control, 'Glyph', Tbitmap));
  bglist := Timagelist(GetObjProp(control, 'Images', Timagelist));
  NumGlyphs := GetIntProperty(control, 'NumGlyphs');
  imageindex := GetIntProperty(control, 'ImageIndex');
  disabledindex := GetIntProperty(control, 'DisabledIndex');
  if NumGlyphs < 0 then NumGlyphs := 1;
  Margin := GetIntProperty(control, 'Margin');
  Spacing := GetIntProperty(control, 'Spacing');

  s := lowercase(GetEnumProperty(control, 'Layout'));
  if s = 'blglyphleft' then layout := blGlyphLeft
  else if s = 'blglyphright' then layout := blGlyphRight
  else if s = 'blglyphtop' then layout := blGlyphTop
  else if s = 'blglyphbottom' then layout := blGlyphbottom;

  if (bGlyph <> nil) and (not bglyph.Empty) then
    GlyphSize := Point(bGlyph.Width div NumGlyphs, bglyph.Height)
  else if (bglist <> nil) and (imageindex <> -1) then
    GlyphSize := Point(bglist.Width, bglist.Height)
  else GlyphSize := Point(0, 0);

  btemp.canvas.font.assign(font);

  DrawStyle := dt_WordBreak;
  s := StrToWideStr('||');
  s1 := StrToWideStr(#13#10);
  caption := StringReplaceW(caption, s, s1);

  TextBounds := r1;                     //Rect(0, 0, r1.right-GlyphSize.x, 0);
  inflaterect(TextBounds, -2, -2);
  case Layout of
    blGlyphLeft, blGlyphRight: Dec(TextBounds.Right, GlyphSize.X + 2);
    blGlyphTop, blGlyphBottom: Dec(TextBounds.Bottom, GlyphSize.y + 2)
  end;

  if Length(Caption) > 0 then begin
//    TextBounds := r1;//Rect(0, 0, r1.right-GlyphSize.x, 0);
//    DrawText(btemp.canvas.handle, PChar(Caption),-1, TextBounds,DT_CALCRECT or dt_left);
    Tnt_DrawTextW(btemp.canvas.handle, caption, TextBounds, DT_CALCRECT or dt_left or dt_WordBreak);
    TextSize := Point(TextBounds.Right - TextBounds.Left, TextBounds.Bottom -
      TextBounds.Top);
  end else begin
    TextBounds := Rect(0, 0, 0, 0);
    TextSize := Point(0, 0);
  end;

  if Layout in [blGlyphLeft, blGlyphRight] then begin
    GlyphPos.Y := (ClientSize.y - GlyphSize.Y + 1) div 2;
    TextPos.Y := (ClientSize.y - TextSize.Y + 1) div 2;
  end else begin
    GlyphPos.X := (ClientSize.x - GlyphSize.X + 1) div 2;
    TextPos.X := (ClientSize.x - TextSize.X + 1) div 2;
  end;

//  margin:=btn.margin;
//  spacing:=btn.spacing;
  if (TextSize.X = 0) or (GlyphSize.X = 0) then
    Spacing := 0;

  s := lowercase(GetEnumProperty(control, 'Alignment'));

  if (Margin = -1) or (s = 'tacenter') then begin
    if Spacing = -1 then begin
      TotalSize := Point(GlyphSize.X + TextSize.X, GlyphSize.Y + TextSize.Y);
      if Layout in [blGlyphLeft, blGlyphRight] then
        Margin := (ClientSize.x - TotalSize.X) div 3
      else
        Margin := (ClientSize.y - TotalSize.Y) div 3;
      Spacing := Margin;
    end else begin
      TotalSize := Point(GlyphSize.X + Spacing + TextSize.X, GlyphSize.Y +
        Spacing + TextSize.Y);
      if Layout in [blGlyphLeft, blGlyphRight] then
        Margin := (ClientSize.x - TotalSize.X) div 2
      else
        Margin := (ClientSize.y - TotalSize.Y) div 2;
    end;
  end else begin
    if Spacing = -1 then begin
      TotalSize := Point(ClientSize.x - (Margin + GlyphSize.X), ClientSize.y -
        (Margin + GlyphSize.Y));
      if Layout in [blGlyphLeft, blGlyphRight] then
        Spacing := (TotalSize.X - TextSize.X) div 2
      else
        Spacing := (TotalSize.Y - TextSize.Y) div 2;
    end;
  end;

  case Layout of
    blGlyphLeft:
      begin
        GlyphPos.X := Margin;
        TextPos.X := GlyphPos.X + GlyphSize.X + Spacing;
        DrawStyle := DT_left or DrawStyle;
      end;
    blGlyphRight:
      begin
        GlyphPos.X := ClientSize.x - Margin - GlyphSize.X;
        TextPos.X := GlyphPos.X - Spacing - TextSize.X;
        DrawStyle := DT_RIGHT or DrawStyle;
      end;
    blGlyphTop:
      begin
        GlyphPos.Y := Margin;
        TextPos.Y := GlyphPos.Y + GlyphSize.Y + Spacing;
        DrawStyle := DT_center or DrawStyle;
      end;
    blGlyphBottom:
      begin
        GlyphPos.Y := ClientSize.y - Margin - GlyphSize.Y;
        TextPos.Y := GlyphPos.Y - Spacing - TextSize.Y;
        DrawStyle := DT_center or DrawStyle;
      end;
  end;
  r1 := rect(glyphpos.x, glyphpos.y, 0, 0);
  if (bglyph <> nil) and (not bglyph.Empty) then
    DrawGlyph(btemp.canvas, r1, bglyph, j, NumGlyphs)
  else if (bglist <> nil) then begin
    if enabled then begin
      if (imageindex <> -1) then
        bglist.Draw(btemp.canvas, r1.Left, r1.Top, ImageIndex, Enabled);
    end else begin
      if (disabledindex <> -1) then
        bglist.Draw(btemp.canvas, r1.Left, r1.Top, disabledIndex, enabled)
      else if (imageindex <> -1) then
        bglist.Draw(btemp.canvas, r1.Left, r1.Top, ImageIndex, Enabled);
    end;
  end;

  TextBounds := rect(textpos.x, textpos.y, textpos.x + TextSize.x, textpos.y + TextSize.y);

  SetBkMode(btemp.Canvas.Handle, TRANSPARENT);

//  if (i=1) and (fsd.button.newnormal) then
  if (fsd.button.newnormal) then
    btemp.canvas.Font.Color := fsd.button.normalcolor2;
  if (i = 4) and (fsd.button.newover) then
    btemp.canvas.Font.Color := fsd.button.overcolor2;
  if (i = 2) and (fsd.Button.newdown) then
    btemp.canvas.Font.Color := fsd.button.downcolor2;

  if not enabled then
    btemp.canvas.Font.Color := clBtnShadow;

      //    btemp.canvas.Font.Assign(btn.Font);
     // DrawText(btemp.canvas.Handle, PChar(btn.caption),Length(btn.caption),TextBounds,DrawStyle);

  if length(caption) > 0 then begin
    drawstyle := checkbidi(drawstyle);
    Tnt_DrawTextW(btemp.canvas.Handle, caption, TextBounds, DrawStyle);
    SetBkMode(btemp.canvas.Handle, OPAQUE);
    if focused and not (xoNoFocusRect in fsd.Options) then begin
      InflateRect(TextBounds, 2, 2);
      DrawFocusRect(btemp.canvas.Handle, TextBounds);
    end;
  end;

  BitBlt(dc, rc.left, rc.top, rc.right - rc.left, rc.bottom - rc.Top,
    btemp.Canvas.Handle, 0, 0, Srccopy);
  selectobject(btemp.canvas.handle, cfont);
end;

procedure TSkinBitButton.DrawPicControl(dc: HDC; rc: TRect);
var
  acolor: Tcolor;
  i, j: integer;
  r1, TextBounds: Trect;
  Layout: TButtonLayout;
  NumGlyphs, margin, spacing: integer;
  TextPos: TPoint;
  GlyphPos, ClientSize, GlyphSize, TextSize: TPoint;
  TotalSize: TPoint;
  DrawStyle: Longint;
  cfont, bfont: Hfont;
  font: Tfont;
  style: dword;
  s, s1: widestring;
  isdefault: boolean;
  GlyphObj: TObject;
  bGlyph: TGraphic;
begin
  Focused := (GetFocus = hWnd);
  style := GetWindowLong(hWnd, GWL_STYLE);
  enabled := (style and WS_DISABLED) = 0;
    //isdefault := (dw = BS_DEFPUSHBUTTON );
  if control <> nil then
    caption := GetStringProp(control, 'Caption')
  else
    caption := getformcaption(hwnd);

  i := 1;
  if Focused then i := 5;
//    if isdefault then i:=5;
  if (scDown in state) then i := 2
  else if (scMouseIn in state) then i := 4;
  if not enabled then i := 3;

  case i of
    1: j := 1;
    2: j := 3;
    3: j := 2;
    4: j := 1;
  else j := 1;
  end;

  r1 := rc;
  offsetrect(r1, -r1.left, -r1.top);
  btemp.width := r1.right;
  btemp.height := r1.bottom;

  bfont := sendmessage(hwnd, wm_getfont, 0, 0);
  cfont := selectobject(btemp.canvas.handle, bfont);

  if trans then
    DrawParentImage(control, btemp.canvas.handle, true)
  else
    fillBG(btemp.canvas.handle, r1);


  DrawSkinMap(btemp.canvas.handle, r1, fsd.button, I, fsd.button.frame);

  ClientSize := Point(rc.Right - rc.Left, rc.Bottom - rc.Top);
  NumGlyphs := 1;

  GlyphObj := TObject(GetObjectProp(control, PicField, TObject));
  if (GlyphObj <> nil) then begin
    bGlyph := TGraphic(GetObjectProp(control, PicField, TGraphic));
  end else bGlyph := nil;

  if (bGlyph <> nil) {and Assigned(bglyph.Graphic)} then
    GlyphSize := Point(bGlyph.Width div NumGlyphs, bglyph.Height)
  else GlyphSize := Point(0, 0);

  font := Tfont(GetObjProp(control, 'Font', Tfont));
  NumGlyphs := GetIntProperty(control, 'NumGlyphs');
  if NumGlyphs < 0 then NumGlyphs := 1;
  Margin := GetIntProperty(control, 'Margin');
  Spacing := GetIntProperty(control, 'Spacing');

  s := lowercase(GetEnumProperty(control, 'Layout'));
  if s = 'blglyphleft' then layout := blGlyphLeft
  else if s = 'blglyphright' then layout := blGlyphRight
  else if s = 'blglyphtop' then layout := blGlyphTop
  else if s = 'blglyphbottom' then layout := blGlyphbottom;


  btemp.canvas.font.assign(font);

  DrawStyle := dt_WordBreak;
  s := StrToWideStr('||');
  s1 := StrToWideStr(#13#10);
  caption := StringReplaceW(caption, s, s1);

  TextBounds := r1;                     //Rect(0, 0, r1.right-GlyphSize.x, 0);
  inflaterect(TextBounds, -2, -2);
  case Layout of
    blGlyphLeft, blGlyphRight: Dec(TextBounds.Right, GlyphSize.X + 2);
    blGlyphTop, blGlyphBottom: Dec(TextBounds.Bottom, GlyphSize.y + 2)
  end;

  if Length(Caption) > 0 then begin
//    TextBounds := r1;//Rect(0, 0, r1.right-GlyphSize.x, 0);
//    DrawText(btemp.canvas.handle, PChar(Caption),-1, TextBounds,DT_CALCRECT or dt_left);
    Tnt_DrawTextW(btemp.canvas.handle, caption, TextBounds, DT_CALCRECT or dt_left or dt_WordBreak);
    TextSize := Point(TextBounds.Right - TextBounds.Left, TextBounds.Bottom -
      TextBounds.Top);
  end else begin
    TextBounds := Rect(0, 0, 0, 0);
    TextSize := Point(0, 0);
  end;

  if Layout in [blGlyphLeft, blGlyphRight] then begin
    GlyphPos.Y := (ClientSize.y - GlyphSize.Y + 1) div 2;
    TextPos.Y := (ClientSize.y - TextSize.Y + 1) div 2;
  end else begin
    GlyphPos.X := (ClientSize.x - GlyphSize.X + 1) div 2;
    TextPos.X := (ClientSize.x - TextSize.X + 1) div 2;
  end;

//  margin:=btn.margin;
//  spacing:=btn.spacing;
  if (TextSize.X = 0) or (GlyphSize.X = 0) then
    Spacing := 0;

  s := lowercase(GetEnumProperty(control, 'Alignment'));

  if (Margin = -1) or (s = 'tacenter') then begin
    if Spacing = -1 then begin
      TotalSize := Point(GlyphSize.X + TextSize.X, GlyphSize.Y + TextSize.Y);
      if Layout in [blGlyphLeft, blGlyphRight] then
        Margin := (ClientSize.x - TotalSize.X) div 3
      else
        Margin := (ClientSize.y - TotalSize.Y) div 3;
      Spacing := Margin;
    end else begin
      TotalSize := Point(GlyphSize.X + Spacing + TextSize.X, GlyphSize.Y +
        Spacing + TextSize.Y);
      if Layout in [blGlyphLeft, blGlyphRight] then
        Margin := (ClientSize.x - TotalSize.X) div 2
      else
        Margin := (ClientSize.y - TotalSize.Y) div 2;
    end;
  end else begin
    if Spacing = -1 then begin
      TotalSize := Point(ClientSize.x - (Margin + GlyphSize.X), ClientSize.y -
        (Margin + GlyphSize.Y));
      if Layout in [blGlyphLeft, blGlyphRight] then
        Spacing := (TotalSize.X - TextSize.X) div 2
      else
        Spacing := (TotalSize.Y - TextSize.Y) div 2;
    end;
  end;

  case Layout of
    blGlyphLeft:
      begin
        GlyphPos.X := Margin;
        TextPos.X := GlyphPos.X + GlyphSize.X + Spacing;
        DrawStyle := DT_left or DrawStyle;
      end;
    blGlyphRight:
      begin
        GlyphPos.X := ClientSize.x - Margin - GlyphSize.X;
        TextPos.X := GlyphPos.X - Spacing - TextSize.X;
        DrawStyle := DT_RIGHT or DrawStyle;
      end;
    blGlyphTop:
      begin
        GlyphPos.Y := Margin;
        TextPos.Y := GlyphPos.Y + GlyphSize.Y + Spacing;
        DrawStyle := DT_center or DrawStyle;
      end;
    blGlyphBottom:
      begin
        GlyphPos.Y := ClientSize.y - Margin - GlyphSize.Y;
        TextPos.Y := GlyphPos.Y - Spacing - TextSize.Y;
        DrawStyle := DT_center or DrawStyle;
      end;
  end;
  r1 := rect(glyphpos.x, glyphpos.y, 0, 0);
  if (bglyph <> nil) {and Assigned(bglyph.Graphic)} then
    btemp.Canvas.Draw(r1.left, r1.top, bglyph);

  TextBounds := rect(textpos.x, textpos.y, textpos.x + TextSize.x, textpos.y + TextSize.y);

  SetBkMode(btemp.Canvas.Handle, TRANSPARENT);

  if (i = 1) and (fsd.button.newnormal) then
    btemp.canvas.Font.Color := fsd.button.normalcolor2;
  if (i = 4) and (fsd.button.newover) then
    btemp.canvas.Font.Color := fsd.button.overcolor2;
  if (i = 2) and (fsd.Button.newdown) then
    btemp.canvas.Font.Color := fsd.button.downcolor2;

  if not enabled then
    btemp.canvas.Font.Color := clBtnShadow;

      //    btemp.canvas.Font.Assign(btn.Font);
     // DrawText(btemp.canvas.Handle, PChar(btn.caption),Length(btn.caption),TextBounds,DrawStyle);

  if length(caption) > 0 then begin
    Tnt_DrawTextW(btemp.canvas.Handle, caption, TextBounds, DrawStyle);
    SetBkMode(btemp.canvas.Handle, OPAQUE);
    if focused and not (xoNoFocusRect in fsd.Options) then begin
      InflateRect(TextBounds, 2, 2);
      DrawFocusRect(btemp.canvas.Handle, TextBounds);
    end;
  end;

  BitBlt(dc, rc.left, rc.top, rc.right - rc.left, rc.bottom - rc.Top,
    btemp.Canvas.Handle, 0, 0, Srccopy);
  selectobject(btemp.canvas.handle, cfont);
end;

procedure TSkinBitButton.DrawGlyph(acanvas: Tcanvas; rc: TRect;
  bmp: Tbitmap; I, N: integer);
var
  atemp: Tbitmap;
  w, h, x, j: integer;
begin
  atemp := Tbitmap.create;
  j := i;
//    if n<>4 then i:=1;
  if j > n then i := 1;
  w := bmp.width div n;
  h := bmp.height;
  atemp.height := h;
  atemp.width := w;
  x := (i - 1) * w;

  if (j = 2) and (n = 1) then begin
    atemp.Free;
    atemp := GetDisableImg(bmp);
  end else begin
    atemp.canvas.copyrect(rect(0, 0, w, h), bmp.canvas, rect(x, 0, x + w, h));
  end;

//    atemp.canvas.copyrect( rect(0,0,w,h),bmp.canvas,rect(x,0,x+w,h));
//    if (j=2) then
//       ConvertBitmapToGrayscale (atemp);

  atemp.Transparent := true;
  atemp.TransparentMode := tmAuto;

//      atemp.Transparent:=true;
//    temp.Transparentcolor:=clFuchsia;
//    atemp.Transparentcolor:=atemp.Canvas.Pixels[0, h-1];
//      atemp.Transparentcolor:=atemp.Canvas.Pixels[0, 0];

  acanvas.draw(rc.left, rc.top, atemp);

  atemp.free;
end;

constructor TWMediaPlayer.Create(AOwner: TComponent);
begin
  inherited create(aowner);
  LoadBitmaps;
end;

destructor TWMediaPlayer.Destroy;
begin
  inherited destroy;
  DestroyBitmaps;
end;

procedure TWMediaPlayer.attach(askin: TSkinControl; aObj: Twincontrol);
var
  s: string;
  parenthwnd: Thandle;
  dw: Dword;
begin
  obj := aobj;
  skincontrol := askin;
  fsd := askin.fsd;
  tag := fsd.DisableTag;
  setposition(obj);
  parent := obj.Parent;
end;

procedure TWMediaPlayer.SetPosition(aObj: Twincontrol);
begin
  obj := aobj;
  width := obj.Width;
  height := obj.Height;                 //div 2;
  left := obj.Left;
  top := obj.Top;
end;

procedure TWMediaPlayer.LoadBitmaps;
const
  BtnStateName: array[TMPGlyph] of PChar = ('EN', 'DI', 'CL');
  BtnTypeName: array[TMPBtnType] of PChar = ('MPPLAY', 'MPPAUSE', 'MPSTOP',
    'MPNEXT', 'MPPREV', 'MPSTEP', 'MPBACK', 'MPRECORD', 'MPEJECT');

var
  I: TMPBtnType;
  J: TMPGlyph;
  ResName: array[0..40] of Char;
begin
  for I := Low(Buttons) to High(Buttons) do
  begin
    for J := Low(TMPGlyph) to High(TMPGlyph) do
    begin
      Buttons[I].Bitmaps[J] := TBitmap.Create;
      Buttons[I].Bitmaps[J].Handle := LoadBitmap(HInstance,
        StrFmt(ResName, '%s_%s', [BtnStateName[J], BtnTypeName[I]]));
    end;
  end;
end;

procedure TWMediaPlayer.DestroyBitmaps;
var
  I: TMPBtnType;
  J: TMPGlyph;
begin
  for I := Low(Buttons) to High(Buttons) do begin
    for J := Low(TMPGlyph) to High(TMPGlyph) do
      Buttons[I].Bitmaps[J].Free;
  end;
end;

procedure TWMediaPlayer.WMLButtonDown(var aMsg: TMessage);
begin
  IsDown := true;
  inherited;
  obj.Perform(amsg.Msg, amsg.WParam, amsg.LParam);
  ReleaseCapture;
  Findbutton(amsg.LParamLo, amsg.LParamHi);
  BtnClick := BtnFocuse;
  invalidate;
end;

procedure TWMediaPlayer.WMLButtonUp(var aMsg: TMessage);
begin
  IsDown := false;
  inherited;
  Findbutton(amsg.LParamLo, amsg.LParamHi);
  if btnfocuse = btnclick then
    obj.Perform(amsg.Msg, amsg.WParam, amsg.LParam);
  btnclick := btnfocuse;
  invalidate;
end;

procedure TWMediaPlayer.CheckButtons;
var
  I: TMPBtnType;
  svisible: string;
  senable: string;
  s: string;
begin
  svisible := GetSetProp(obj, 'VisibleButtons', true);
  count := 0;
  for I := Low(Buttons) to High(Buttons) do begin
    s := GetEnumName(TypeInfo(TMPBtnType), Ord(i));
    buttons[i].Visible := pos(s, svisible) > 0;
    if buttons[i].Visible then inc(count);
  end;
end;

procedure TWMediaPlayer.FindButton(XPos, YPos: Integer);
var
  I: TMPBtnType;
  X: Integer;
begin
  {which button was clicked}
  X := 0;
  for I := Low(Buttons) to High(Buttons) do
  begin
    if Buttons[I].Visible then
    begin
      if (XPos >= X) and (XPos <= X + BtnWidth) then begin
        Break;
      end;
      Inc(X, BtnWidth);
    end;
  end;
  BtnFocuse := I;
end;

procedure TWMediaPlayer.Paint;
var
  I: TMPBtnType;
  svisible: string;
  senable: string;
  scolor: string;
  s: string;
  temp: Tbitmap;
  r1, rc: Trect;
  w, h, x, j: integer;
begin
 //   inherited Paint;
  svisible := GetSetProp(obj, 'VisibleButtons', true);
  senable := GetSetProp(obj, 'EnabledButtons', true);
  scolor := GetSetProp(obj, 'ColoredButtons', true);
  count := 0;
  for I := Low(Buttons) to High(Buttons) do begin
    s := GetEnumName(TypeInfo(TMPBtnType), Ord(i));
    buttons[i].Visible := pos(s, svisible) > 0;
    if buttons[i].Visible then inc(count);
    buttons[i].Enabled := pos(s, senable) > 0;
    buttons[i].Colored := pos(s, scolor) > 0;
  end;
  rc := rect(0, 0, width, height);

  if count = 0 then begin
    fillcolor(canvas.Handle, rc, fsd.colors[csButtonFace]);
    exit;
  end;
//    rc:=rect(0,0,obj.width,obj.height);
  w := rc.right div count;
  h := rc.Bottom;
  btnwidth := w;
  temp := Tbitmap.create;
  temp.width := rc.Right;
  temp.Height := h;
  temp.Canvas.brush.Color := fsd.colors[csButtonFace];
  temp.Canvas.FillRect(rc);
  x := 0;
  for I := Low(Buttons) to High(Buttons) do begin
    r1 := rect(x, 0, x + w, h);
    j := 1;
    if buttons[i].Visible then begin
      DrawButton(temp.canvas, i, r1);
      inc(x, w);
    end;
  end;

  BitBlt(canvas.Handle, rc.left, rc.top, rc.right, rc.bottom,
    temp.Canvas.Handle, 0, 0, Srccopy);
  temp.free;
end;

procedure TWMediaPlayer.DrawButton(acanvas: Tcanvas; Btn: TMPBtnType; R: TRect);
var
  j: integer;
  TheGlyph: TMPGlyph;
  Bitmap: TBitmap;
  x, y: integer;
begin
  if Buttons[Btn].Enabled then begin
    TheGlyph := mgEnabled;
    if Buttons[Btn].Colored then
      TheGlyph := mgColored;
  end else TheGlyph := mgDisabled;

  j := 1;
  if IsDown and (btn = BtnClick) then j := 2;
  if TheGlyph = mgDisabled then j := 3;

  DrawRect2(acanvas.handle, r, fsd.button.map,
    fsd.button.r, j, fsd.button.frame, fsd.button.trans, fsd.button.tile);

  Bitmap := Buttons[Btn].Bitmaps[TheGlyph];
  X := (r.Right - r.Left - Bitmap.Width) div 2;
  Y := (r.Bottom - r.Top - Bitmap.Height) div 2;
  if j = 2 then begin
    Inc(X);
    Inc(Y);
  end;
  acanvas.BrushCopy(Bounds(r.Left + X, Y, Bitmap.Width, Bitmap.Height),
    Bitmap, Rect(0, 0, Bitmap.Width, Bitmap.Height), clOlive);
end;

procedure TSkinMP.Init(sf: Tcomponent; sd: TSkinData; acanvas: TCanvas; acolor: boolean = false);
var
  s: string;
begin
  inherited init(sf, sd, acanvas, acolor);
  mp := TWMediaPlayer.create(sf);
  mp.attach(self, control);
  mp.Visible := control.Visible;
{    mp.fsd := sd;
    mp.obj:=control;
    mp.Width:= control.Width ;
    mp.Height:= control.Height div 2;
    mp.left:=0;
    mp.top:=0;
    mp.Parent := control;}
end;

procedure TSkinMP.AfterProc(var Message: TMessage);
begin
  case message.msg of
    CM_VISIBLECHANGED: begin
        mp.Visible := control.Visible;
      end;
    WM_WINDOWPOSCHANGED: begin
        if mp <> nil then mp.SetPosition(control);
      end;
  else inherited Afterproc(message);
  end;
end;

procedure TSkinMP.Unsubclass;
begin
  inherited unsubclass;
  if skinstate <> skin_deleted then begin
    if mp <> nil then mp.free;
    mp := nil;
  end else begin
  end;
end;

procedure TSkinMenuButton.DrawGlyph(acanvas: Tcanvas; rc: TRect;
  bmp: Tbitmap; I, N: integer);
var
  atemp: Tbitmap;
  w, h, x, j: integer;
begin
  atemp := Tbitmap.create;
  j := i;
//    if n<>4 then i:=1;
  if j > n then i := 1;
  w := bmp.width div n;
  h := bmp.height;
  atemp.height := h;
  atemp.width := w;
  x := (i - 1) * w;

  if (j = 2) and (n = 1) then begin
    atemp.Free;
    atemp := GetDisableImg(bmp);
  end else begin
    atemp.canvas.copyrect(rect(0, 0, w, h), bmp.canvas, rect(x, 0, x + w, h));
  end;

//    atemp.canvas.copyrect( rect(0,0,w,h),bmp.canvas,rect(x,0,x+w,h));
//    if (j=2) then
//       ConvertBitmapToGrayscale (atemp);

  atemp.Transparent := true;
  atemp.TransparentMode := tmAuto;

//      atemp.Transparent:=true;
//    temp.Transparentcolor:=clFuchsia;
//    atemp.Transparentcolor:=atemp.Canvas.Pixels[0, h-1];
//      atemp.Transparentcolor:=atemp.Canvas.Pixels[0, 0];

  acanvas.draw(rc.left, rc.top, atemp);

  atemp.free;
end;

procedure TSkinMenuButton.DrawControl(dc: HDC; rc: TRect);
var
  acolor: Tcolor;
  i: integer;
  r1, r2, TextBounds: Trect;
  TextPos: TPoint;
  ClientSize, GlyphSize, TextSize: TPoint;
  arrowsize, GlyphPos, arrowpos: TPoint;
  TotalSize: TPoint;

  x, y: integer;
  DrawStyle: Longint;
  cfont, bfont: Hfont;
  font: Tfont;
  style: dword;
  s, s1: widestring;
  isdefault: boolean;
  bglyph: Tbitmap;
  Margin, Spacing: integer;
  Layout: TButtonLayout;

begin
  if fsd.button = nil then exit;
  if fsd.Button.map.empty then exit;
//    DrawStyle:=DT_LEFT;

  Focused := (GetFocus = hWnd);
  style := GetWindowLong(hWnd, GWL_STYLE);
  enabled := (style and WS_DISABLED) = 0;
    //isdefault := (dw = BS_DEFPUSHBUTTON );
  if control <> nil then
    caption := GetStringProp(control, 'Caption')
//       caption := GetControlCaption(TACControl(control))
  else
    caption := getformcaption(hwnd);

  i := 1;
  if Focused then i := 4;
//    if isdefault then i:=5;
  if (scDown in state) then i := 2
  else if (scMouseIn in state) then i := 4;
  if not enabled then i := 3;

  r1 := rc;
  offsetrect(r1, -r1.left, -r1.top);
  btemp.width := r1.right;
  btemp.height := r1.bottom;

  bfont := sendmessage(hwnd, wm_getfont, 0, 0);
  cfont := selectobject(btemp.canvas.handle, bfont);
  bglyph := Tbitmap(GetObjProp(control, 'Glyph', Tbitmap));
  Margin := GetIntProperty(control, 'Margin');
  Spacing := GetIntProperty(control, 'Spacing');

  Layout := blGlyphLeft;
  if (bGlyph <> nil) and (not bglyph.Empty) then
    GlyphSize := Point(bGlyph.Width, bglyph.Height)
  else GlyphSize := Point(0, 0);

  if trans then
    DrawParentImage(control, btemp.canvas.handle, true)
  else
    fillBG(btemp.canvas.handle, r1);


  DrawSkinMap(btemp.canvas.handle, r1, fsd.button, I, fsd.button.frame);

  ClientSize := Point(rc.Right - rc.Left, rc.Bottom - rc.Top);

  font := Tfont(GetObjProp(control, 'Font', Tfont));


  arrowsize := Point(8, 3);

  btemp.canvas.font.assign(font);

  DrawStyle := dt_WordBreak;
  s := StrToWideStr('||');
  s1 := StrToWideStr(#13#10);
  caption := StringReplaceW(caption, s, s1);

  TextBounds := Rect(0, 0, r1.right - GlyphSize.x - arrowsize.X, r1.Bottom);
  inflaterect(TextBounds, -2, -2);

  if Length(Caption) > 0 then begin
//    TextBounds := r1;//Rect(0, 0, r1.right-GlyphSize.x, 0);
//    DrawText(btemp.canvas.handle, PChar(Caption),-1, TextBounds,DT_CALCRECT or dt_left);
    Tnt_DrawTextW(btemp.canvas.handle, caption, TextBounds, DT_CALCRECT or dt_left or dt_WordBreak);
    TextSize := Point(TextBounds.Right - TextBounds.Left, TextBounds.Bottom -
      TextBounds.Top);
  end else begin
    TextBounds := Rect(0, 0, 0, 0);
    TextSize := Point(0, 0);
  end;

  if (Margin = -1) then begin
    if Spacing = -1 then begin
      TotalSize := Point(GlyphSize.X + TextSize.X + arrowsize.X, GlyphSize.Y + TextSize.Y + arrowsize.Y);
      if Layout in [blGlyphLeft, blGlyphRight] then
        Margin := (ClientSize.x - TotalSize.X) div 4
      else
        Margin := (ClientSize.y - TotalSize.Y) div 4;
      Spacing := Margin;
    end else begin
      TotalSize := Point(GlyphSize.X + Spacing + TextSize.X + spacing + arrowsize.X, GlyphSize.Y +
        Spacing * 2 + TextSize.Y + arrowsize.Y);
      if Layout in [blGlyphLeft, blGlyphRight] then
        Margin := (ClientSize.x - TotalSize.X) div 2
      else
        Margin := (ClientSize.y - TotalSize.Y) div 2;
    end;
  end else begin
    if Spacing = -1 then begin
      TotalSize := Point(ClientSize.x - (Margin * 2 + GlyphSize.X - arrowsize.X), ClientSize.y -
        (Margin * 2 + GlyphSize.Y - arrowsize.Y));
      if Layout in [blGlyphLeft, blGlyphRight] then
        Spacing := (TotalSize.X - TextSize.X) div 2
      else
        Spacing := (TotalSize.Y - TextSize.Y) div 2;
    end;
  end;

  GlyphPos.X := Margin;
  GlyphPos.Y := (ClientSize.y - GlyphSize.Y) div 2;

  TextPos.Y := (ClientSize.y - TextSize.Y + 1) div 2;
  textpos.x := GlyphPos.x + GlyphSize.X + Spacing;

  arrowpos.X := TextPos.x + Spacing * 2 + TextSize.x;
  arrowpos.Y := (ClientSize.y - arrowsize.Y) div 2;

  r2 := rect(glyphpos.x, glyphpos.y, 0, 0);
  if (bglyph <> nil) and (not bglyph.Empty) then
    DrawGlyph(btemp.canvas, r2, bglyph, 1, 1);

  TextBounds := rect(textpos.x, textpos.y, textpos.x + TextSize.x, textpos.y + TextSize.y);

  if (i = 1) and (fsd.button.newnormal) then
    btemp.canvas.Font.Color := fsd.button.normalcolor2;
  if (i = 4) and (fsd.button.newover) then
    btemp.canvas.Font.Color := fsd.button.overcolor2;
  if (i = 2) and (fsd.Button.newdown) then
    btemp.canvas.Font.Color := fsd.button.downcolor2;

  btemp.Canvas.Brush.Color := clWindowText;
  btemp.Canvas.Pen.Color := clWindowText;
  if not enabled then begin
    btemp.canvas.Font.Color := clBtnShadow;
    btemp.Canvas.Brush.Color := clBtnShadow;
    btemp.Canvas.Pen.Color := clBtnShadow;
  end;

  X := arrowpos.X;
  Y := arrowpos.y + 2;
  btemp.Canvas.Polygon([Point(X, Y), Point(X - 3, Y - 3), Point(X + 3, Y - 3)]);

  SetBkMode(btemp.Canvas.Handle, TRANSPARENT);
  Tnt_DrawTextW(btemp.canvas.Handle, caption, TextBounds, DrawStyle);
  SetBkMode(btemp.canvas.Handle, OPAQUE);
  if focused and not (xoNoFocusRect in fsd.Options) then begin
    InflateRect(TextBounds, 2, 2);
    DrawFocusRect(btemp.canvas.Handle, TextBounds);
  end;

  BitBlt(dc, rc.left, rc.top, rc.right - rc.left, rc.bottom - rc.Top,
    btemp.Canvas.Handle, 0, 0, Srccopy);
  selectobject(btemp.canvas.handle, cfont);
end;

procedure TSkinSpeedButton.InitGraphicControl(sf: Tcomponent; sd: TSkinData; acanvas: TCanvas);
begin
  fsd := sd;
  fCanvas := acanvas;
  gcontrol := TGraphicControl(owner);
  skinform := sf;
  OldWndProc := gControl.WindowProc;
  gControl.WindowProc := NewWndProc;
  Twinskinform(skinform).addcontrollist(self);
  skinstate := skin_active;
  if (gcontrol.Tag = 5555) or (xoTransparent in fsd.options) then
    trans := true;
end;

constructor TSkinSpeedButton.Create(AOwner: TComponent);
begin
  inherited create(aowner);
  fReentr := False;
  picfield := '';
//   gcanvas:=Tcanvas.create;
end;

destructor TSkinSpeedButton.Destroy;
begin
//   gcanvas.free;
  if assigned(oldwndproc) then begin
    if gcontrol <> nil then gControl.WindowProc := OldWndProc;
    oldwndproc := nil;
  end;
  inherited destroy;
end;

function TSkinSpeedButton.BeforeProc(var Message: TMessage): boolean;
var
  rc: Trect;
  C: TCanvas;
begin
  result := true;
  case message.msg of
    WM_LBUTTONDOWN, WM_LBUTTONDBLCLK:
      begin
        default(message);
        state := state + [scDown];
        PaintControl;
        result := false;
      end;
    WM_LBUTTONUP:
      begin
        result := true;
      end;
    WM_Paint: begin
        WMPaintSpeed(message);
        result := false;
//        message.result:=1;
      end;
  else result := inherited beforeProc(message);
  end;
end;

{procedure TSkinSpeedButton.WMPaintSpeed(var Message:Tmessage);
var  C : TControlCanvas;
     rc:TREct;
begin
   rc:=gcontrol.ClientRect;
   OffsetRect( rc, -rc.left, -rc.top );
   C := TControlCanvas.Create;
   C.handle :=  TWMPaint(Message).DC;
   try
     C.Control := gControl;
     DrawSpeedbtn( c,rc);
//    DrawSpeedbtn(TAcGraphicControl(gcontrol).Canvas,rc);
   finally
     C.Free;
   end;
    message.result:=1;
end;     }

procedure TSkinSpeedButton.WMPaintSpeed(var Message: Tmessage);
var
  C: TControlCanvas;
  rc: TREct;
begin
  rc := gcontrol.ClientRect;
  OffsetRect(rc, -rc.left, -rc.top);
  if TWMPaint(Message).DC <> 0 then begin
    TAcGraphicControl(gcontrol).Canvas.Lock;
    try
      TAcGraphicControl(gcontrol).Canvas.Handle := TWMPaint(Message).DC;
      try
        DrawSpeedbtn(TAcGraphicControl(gcontrol).Canvas, rc);
      finally
        TAcGraphicControl(gcontrol).Canvas.Handle := 0;
      end;
    finally
      TAcGraphicControl(gcontrol).Canvas.Unlock;
    end;
  end;
  message.result := 1;
end;

procedure TSkinSpeedButton.AfterProc(var Message: TMessage);
begin
  case message.msg of
    CM_MOUSEENTER:
      begin
        state := state + [scMouseIn];
//        if gcontrol.Visible then
//           gcontrol.Invalidate;
        PaintControl;
      end;
    CM_MOUSELEAVE:
      begin
        state := state - [scMouseIn];
        state := state - [scDown];
//        if gcontrol.Visible then
//           gcontrol.Invalidate ;
        if gcontrol.Visible then
          PaintControl;
      end;

    WM_LBUTTONUP:
      begin
        state := state - [scDown];
        PaintControl;
//       TSpeedButton(gcontrol).click;
      end;

    WM_KEYDOWN:
      if Message.WParam = VK_SPACE then begin
        state := state + [scDown];
        PaintControl;
      end;

    WM_KEYUP:
      if Message.WParam = VK_SPACE then begin
        state := state - [scDown];
        PaintControl;
      end;
    WM_NCDESTROY, CM_RELEASE: begin
        if assigned(oldwndproc) then begin
          gControl.WindowProc := OldWndProc;
          oldwndproc := nil;
        end;
      end;
    CM_FOCUSCHANGED: begin
      end;
    wm_enable, CM_ENABLEDCHANGED: ;

  else inherited AfterProc(Message);
  end;
end;

{procedure TSkinSpeedButton.PaintControl(adc:HDC=0);
var rc:TRect;
    C : TControlCanvas;
begin
   rc:=gcontrol.ClientRect;
   OffsetRect( rc, -rc.left, -rc.top );
   C := TControlCanvas.Create;
   try
//    C.Control := gControl;
//   if TAcGraphicControl(gcontrol).Canvas.handle<>0 then
//     DrawSpeedbtn(TAcGraphicControl(gcontrol).Canvas,rc);
//   Application.ProcessMessages;

    DrawSpeedbtn(TAcGraphicControl(gcontrol).Canvas,rc);
//    DrawSpeedbtn(gcontrol.c,rc);
   finally
    C.Free;
   end;
end;}

procedure TSkinSpeedButton.PaintControl(adc: HDC = 0);
var
  rc: TRect;
  C: TControlCanvas;
begin
  rc := gcontrol.ClientRect;
  OffsetRect(rc, -rc.left, -rc.top);
  if TAcGraphicControl(gcontrol).Canvas.Handle <> 0 then begin
    TAcGraphicControl(gcontrol).Canvas.Lock;
    try
      DrawSpeedbtn(TAcGraphicControl(gcontrol).Canvas, rc);
    finally
      TAcGraphicControl(gcontrol).Canvas.Unlock;
    end;
  end;
end;

procedure TSkinSpeedButton.DrawSpeedbtn(acanvas: Tcanvas; rc: TRect);
var
  acolor: Tcolor;
  i, n, j: integer;
  r1, TextBounds: Trect;
  TextPos: TPoint;
  GlyphPos, ClientSize, GlyphSize, TextSize: TPoint;
  TotalSize: TPoint;
  DrawStyle: Longint;
  Layout: TButtonLayout;
  NumGlyphs, margin, spacing: integer;
  bglyph: Tbitmap;
  s: string;
  font: Tfont;
  flat: boolean;
  enable: boolean;
begin
  if fsd.button = nil then exit;
  if fsd.Button.map.empty then exit;

  s := lowercase(GetEnumProperty(gcontrol, 'Visible'));
  if s = 'false' then exit;

  if length(Picfield) > 0 then begin
    drawpicbtn(acanvas, rc);
    exit;
  end;

 // RF: flag for reentrancy
  if fReentr then Exit;
  fReentr := True;
// acanvas.Lock;
  try

    DrawStyle := DT_LEFT or dt_WordBreak;

    i := 1;

    if (scDown in state) then i := 2
    else if (scMouseIn in state) then i := 4;

    s := lowercase(GetEnumProperty(gcontrol, 'Enabled'));
    if s = 'true' then enable := true
    else enable := false;

    if not enable then i := 3;

    s := lowercase(GetEnumProperty(gcontrol, 'Down'));
    if s = 'true' then i := 2;


    j := 1;
    case i of
      1: j := 1;
      2: j := 3;
      3: j := 2;
      4: j := 1;
    end;
    if s = 'true' then j := 4;

    caption := GetStringProp(gcontrol, 'Caption');
    font := Tfont(GetObjProp(gcontrol, 'Font', Tfont));
    bglyph := Tbitmap(GetObjProp(gcontrol, 'Glyph', Tbitmap));
    NumGlyphs := GetIntProperty(gcontrol, 'NumGlyphs');
    if NumGlyphs < 0 then NumGlyphs := 1;
//   bglist := Timagelist(GetObjProp(gcontrol,'Images',Timagelist));
//   imageindex := GetIntProperty(gcontrol,'ImageIndex') ;
//   disabledindex := GetIntProperty(gcontrol,'DisabledIndex') ;
    s := lowercase(GetEnumProperty(gcontrol, 'Flat'));
    if s = 'true' then flat := true
    else flat := false;

    Margin := GetIntProperty(gcontrol, 'Margin');
    Spacing := GetIntProperty(gcontrol, 'Spacing');
    s := lowercase(GetEnumProperty(gcontrol, 'Layout'));

    if s = 'blglyphleft' then layout := blGlyphLeft
    else if s = 'blglyphright' then layout := blGlyphRight
    else if s = 'blglyphtop' then layout := blGlyphTop
    else if s = 'blglyphbottom' then layout := blGlyphbottom;

    r1 := rc;
    offsetrect(r1, -r1.left, -r1.top);

    try
      if (r1.Right > 0) and (r1.Bottom > 0) then begin
        btemp.width := r1.right;
        btemp.height := r1.bottom;
      end else begin
        fReentr := False;
        exit;
      end;
    except
      fReentr := False;
      exit;
    end;

    if font <> nil then btemp.canvas.font.assign(font);

    if trans then
      DrawParentImage(gcontrol, btemp.canvas.handle, true)
    else
      fillBG(btemp.canvas.handle, r1);
{   if not  (xoTransparent in fsd.options) then begin
     fillBG(btemp.canvas.handle,r1);
   end
   else  if gcontrol<>nil then
      DrawParentImage(gcontrol,btemp.canvas.handle,true);}

//   if flat , don't paint background image.
    if (i in [2, 4]) or (not Flat) then
      DrawSkinMap(btemp.canvas.handle, r1, fsd.button, I, fsd.button.frame);

    ClientSize := Point(r1.right, r1.bottom);

    if (bGlyph <> nil) and (not bGlyph.empty) then
      GlyphSize := Point(bGlyph.Width div NumGlyphs, bglyph.Height)
    else begin
      GlyphSize := Point(0, 0);
    end;

    TextBounds := r1;
    inflaterect(TextBounds, -2, -2);
    case Layout of
      blGlyphLeft, blGlyphRight: Dec(TextBounds.Right, GlyphSize.X + 2);
      blGlyphTop, blGlyphBottom: Dec(TextBounds.Bottom, GlyphSize.y + 2)
    end;

    if Length(Caption) > 0 then begin
    //offsetrect(TextBounds,-TextBounds.Left,-TextBounds.Top);
    //TextBounds := Rect(0, 0, clientsize.x,clientsize.y);
      Tnt_DrawTextW(btemp.canvas.handle, Caption, TextBounds, DT_CALCRECT or dt_left or dt_WordBreak);
      TextSize := Point(TextBounds.Right - TextBounds.Left, TextBounds.Bottom -
        TextBounds.Top);
    end else begin
      TextBounds := Rect(0, 0, 0, 0);
      TextSize := Point(0, 0);
    end;

    if GlyphSize.X * GlyphSize.y = 0 then begin
//    if (i=1) and (fsd.button.newnormal) then
      if (fsd.button.newnormal) then
        btemp.canvas.Font.Color := fsd.button.normalcolor2;
      if (i = 4) and (fsd.button.newover) then
        btemp.canvas.Font.Color := fsd.button.overcolor2;
      if (i = 2) and (fsd.Button.newdown) then
        btemp.canvas.Font.Color := fsd.button.downcolor2;
      if not enable then btemp.canvas.Font.Color := clBtnShadow;
      DrawBtnText(btemp.canvas, r1, caption);
      aCanvas.draw(rc.left, rc.top, btemp);
      fReentr := False;
//    acanvas.Unlock();
      exit;
    end;

    if Layout in [blGlyphLeft, blGlyphRight] then begin
      GlyphPos.Y := (ClientSize.y - GlyphSize.Y + 1) div 2;
      TextPos.Y := (ClientSize.y - TextSize.Y + 1) div 2;
    end else begin
      GlyphPos.X := (ClientSize.x - GlyphSize.X + 1) div 2;
      TextPos.X := (ClientSize.x - TextSize.X + 1) div 2;
    end;

  { if there is no text or no bitmap, then Spacing is irrelevant }
    if (GlyphSize.X = 0) or (TextSize.X = 0) then
      Spacing := 0;

  { adjust Margin and Spacing }
    if Margin = -1 then begin
      if Spacing = -1 then begin
        TotalSize := Point(GlyphSize.X + TextSize.X, GlyphSize.Y + TextSize.Y);
        if Layout in [blGlyphLeft, blGlyphRight] then
          Margin := (ClientSize.x - TotalSize.X) div 3
        else
          Margin := (ClientSize.y - TotalSize.Y) div 3;
        Spacing := Margin;
      end else begin
        TotalSize := Point(GlyphSize.X + Spacing + TextSize.X, GlyphSize.Y +
          Spacing + TextSize.Y);
        if Layout in [blGlyphLeft, blGlyphRight] then
          Margin := (r1.right - TotalSize.X) div 2 + 1
        else
          Margin := (ClientSize.y - TotalSize.Y) div 2 + 1;
      end;
    end else begin
      if Spacing = -1 then begin
        TotalSize := Point(ClientSize.x - (Margin + GlyphSize.X), ClientSize.y -
          (Margin + GlyphSize.Y));
        if Layout in [blGlyphLeft, blGlyphRight] then
          Spacing := (TotalSize.X - TextSize.X) div 2
        else
          Spacing := (TotalSize.Y - TextSize.Y) div 2;
      end;
    end;

    case Layout of
      blGlyphLeft:
        begin
          GlyphPos.X := Margin;
          TextPos.X := GlyphPos.X + GlyphSize.X + Spacing;
          DrawStyle := DT_left or dt_WordBreak;
        end;
      blGlyphRight:
        begin
          GlyphPos.X := ClientSize.x - Margin - GlyphSize.X;
          TextPos.X := GlyphPos.X - Spacing - TextSize.X;
          DrawStyle := DT_RIGHT or dt_WordBreak;
        end;
      blGlyphTop:
        begin
          GlyphPos.Y := Margin;
          TextPos.Y := GlyphPos.Y + GlyphSize.Y + Spacing;
          DrawStyle := DT_center or dt_WordBreak;
        end;
      blGlyphBottom:
        begin
          GlyphPos.Y := ClientSize.y - Margin - GlyphSize.Y;
          TextPos.Y := GlyphPos.Y - Spacing - TextSize.Y;
          DrawStyle := DT_center or dt_WordBreak;
        end;
    end;
    r1 := rect(glyphpos.x, glyphpos.y, 0, 0);
    DrawGlyph(btemp.canvas, r1, bglyph, j, NumGlyphs);
    TextBounds := rect(textpos.x, textpos.y, textpos.x + TextSize.x, textpos.y + TextSize.y);

    SetBkMode(btemp.Canvas.Handle, TRANSPARENT);

    if (i = 1) and (fsd.button.newnormal) then
      btemp.canvas.Font.Color := fsd.button.normalcolor2;
    if (i = 4) and (fsd.button.newover) then
      btemp.canvas.Font.Color := fsd.button.overcolor2;
    if (i = 2) and (fsd.Button.newdown) then
      btemp.canvas.Font.Color := fsd.button.downcolor2;
    if not enable then
      btemp.canvas.Font.Color := clBtnShadow;

//  DrawText(bg.canvas.Handle, PChar(btn.caption),Length(btn.caption),TextBounds,DrawStyle);
//  acanvas.draw(rc.left,rc.top,BG);
    drawstyle := CheckBiDi(drawstyle);
    Tnt_DrawTextW(btemp.canvas.Handle, caption, TextBounds, DrawStyle);
    aCanvas.draw(rc.left, rc.top, btemp);
  finally
    fReentr := False;
//  acanvas.Unlock();
  end;

end;

procedure TSkinSpeedButton.DrawPicbtn(acanvas: Tcanvas; rc: TRect);
var
  acolor: Tcolor;
  i, n, j: integer;
  r1, TextBounds: Trect;
  TextPos: TPoint;
  GlyphPos, ClientSize, GlyphSize, TextSize: TPoint;
  TotalSize: TPoint;
  DrawStyle: Longint;
  Layout: TButtonLayout;
  NumGlyphs, margin, spacing: integer;

  GlyphObj: TObject;
  bGlyph: TGraphic;

  s: string;
  font: Tfont;
  flat: boolean;
  enable: boolean;
begin
  if fsd.button = nil then exit;
  if fsd.Button.map.empty then exit;

 // RF: flag for reentrancy
  if fReentr then Exit;
  fReentr := True;
// acanvas.Lock;
  try

    DrawStyle := DT_LEFT or dt_WordBreak;

    i := 1;

    if (scDown in state) then i := 2
    else if (scMouseIn in state) then i := 4;

    s := lowercase(GetEnumProperty(gcontrol, 'Enabled'));
    if s = 'true' then enable := true
    else enable := false;

    if not enable then i := 3;

    s := lowercase(GetEnumProperty(gcontrol, 'Down'));
    if s = 'true' then i := 2;


    j := 1;
    case i of
      1: j := 1;
      2: j := 3;
      3: j := 2;
      4: j := 1;
    end;
    if s = 'true' then j := 4;

    GlyphObj := TObject(GetObjectProp(gcontrol, PicField, TObject));
    if (GlyphObj <> nil) then begin
      bGlyph := TGraphic(GetObjectProp(gcontrol, PicField, TGraphic));
    end else bGlyph := nil;

    caption := GetStringProp(gcontrol, 'Caption');
    font := Tfont(GetObjProp(gcontrol, 'Font', Tfont));
//   bglyph := Tbitmap(GetObjProp(gcontrol,'Glyph',Tbitmap));
    NumGlyphs := GetIntProperty(gcontrol, 'NumGlyphs');
    if NumGlyphs < 0 then NumGlyphs := 1;
//   bglist := Timagelist(GetObjProp(gcontrol,'Images',Timagelist));
//   imageindex := GetIntProperty(gcontrol,'ImageIndex') ;
//   disabledindex := GetIntProperty(gcontrol,'DisabledIndex') ;
    s := lowercase(GetEnumProperty(gcontrol, 'Flat'));
    if s = 'true' then flat := true
    else flat := false;

    Margin := GetIntProperty(gcontrol, 'Margin');
    Spacing := GetIntProperty(gcontrol, 'Spacing');
    s := lowercase(GetEnumProperty(gcontrol, 'Layout'));

    if s = 'blglyphleft' then layout := blGlyphLeft
    else if s = 'blglyphright' then layout := blGlyphRight
    else if s = 'blglyphtop' then layout := blGlyphTop
    else if s = 'blglyphbottom' then layout := blGlyphbottom;

    r1 := rc;
    offsetrect(r1, -r1.left, -r1.top);

    try
      if (r1.Right > 0) and (r1.Bottom > 0) then begin
        btemp.width := r1.right;
        btemp.height := r1.bottom;
      end else begin
        fReentr := False;
        exit;
      end;
    except
      fReentr := False;
      exit;
    end;

    if font <> nil then btemp.canvas.font.assign(font);

    if trans then
      DrawParentImage(gcontrol, btemp.canvas.handle, true)
    else
      fillBG(btemp.canvas.handle, r1);
{   if not  (xoTransparent in fsd.options) then begin
     fillBG(btemp.canvas.handle,r1);
   end
   else  if gcontrol<>nil then
      DrawParentImage(gcontrol,btemp.canvas.handle,true);}

//   if flat , don't paint background image.
    if (i in [2, 4]) or (not Flat) then
      DrawSkinMap(btemp.canvas.handle, r1, fsd.button, I, fsd.button.frame);

    ClientSize := Point(r1.right, r1.bottom);

    if (bGlyph <> nil) and (not bGlyph.empty) then
      GlyphSize := Point(bGlyph.Width div NumGlyphs, bglyph.Height)
    else begin
      GlyphSize := Point(0, 0);
    end;

    TextBounds := r1;
    inflaterect(TextBounds, -2, -2);
    case Layout of
      blGlyphLeft, blGlyphRight: Dec(TextBounds.Right, GlyphSize.X + 2);
      blGlyphTop, blGlyphBottom: Dec(TextBounds.Bottom, GlyphSize.y + 2)
    end;

    if Length(Caption) > 0 then begin
    //offsetrect(TextBounds,-TextBounds.Left,-TextBounds.Top);
    //TextBounds := Rect(0, 0, clientsize.x,clientsize.y);
      Tnt_DrawTextW(btemp.canvas.handle, Caption, TextBounds, DT_CALCRECT or dt_left or dt_WordBreak);
      TextSize := Point(TextBounds.Right - TextBounds.Left, TextBounds.Bottom -
        TextBounds.Top);
    end else begin
      TextBounds := Rect(0, 0, 0, 0);
      TextSize := Point(0, 0);
    end;

    if GlyphSize.X * GlyphSize.y = 0 then begin
      if (i = 1) and (fsd.button.newnormal) then
        btemp.canvas.Font.Color := fsd.button.normalcolor2;
      if (i = 4) and (fsd.button.newover) then
        btemp.canvas.Font.Color := fsd.button.overcolor2;
      if (i = 2) and (fsd.Button.newdown) then
        btemp.canvas.Font.Color := fsd.button.downcolor2;
      if not enable then btemp.canvas.Font.Color := clBtnShadow;
      DrawBtnText(btemp.canvas, r1, caption);
      aCanvas.draw(rc.left, rc.top, btemp);
      fReentr := False;
//    acanvas.Unlock();
      exit;
    end;

    if Layout in [blGlyphLeft, blGlyphRight] then begin
      GlyphPos.Y := (ClientSize.y - GlyphSize.Y + 1) div 2;
      TextPos.Y := (ClientSize.y - TextSize.Y + 1) div 2;
    end else begin
      GlyphPos.X := (ClientSize.x - GlyphSize.X + 1) div 2;
      TextPos.X := (ClientSize.x - TextSize.X + 1) div 2;
    end;

  { if there is no text or no bitmap, then Spacing is irrelevant }
    if (GlyphSize.X = 0) or (TextSize.X = 0) then
      Spacing := 0;

  { adjust Margin and Spacing }
    if Margin = -1 then begin
      if Spacing = -1 then begin
        TotalSize := Point(GlyphSize.X + TextSize.X, GlyphSize.Y + TextSize.Y);
        if Layout in [blGlyphLeft, blGlyphRight] then
          Margin := (ClientSize.x - TotalSize.X) div 3
        else
          Margin := (ClientSize.y - TotalSize.Y) div 3;
        Spacing := Margin;
      end else begin
        TotalSize := Point(GlyphSize.X + Spacing + TextSize.X, GlyphSize.Y +
          Spacing + TextSize.Y);
        if Layout in [blGlyphLeft, blGlyphRight] then
          Margin := (r1.right - TotalSize.X) div 2 + 1
        else
          Margin := (ClientSize.y - TotalSize.Y) div 2 + 1;
      end;
    end else begin
      if Spacing = -1 then begin
        TotalSize := Point(ClientSize.x - (Margin + GlyphSize.X), ClientSize.y -
          (Margin + GlyphSize.Y));
        if Layout in [blGlyphLeft, blGlyphRight] then
          Spacing := (TotalSize.X - TextSize.X) div 2
        else
          Spacing := (TotalSize.Y - TextSize.Y) div 2;
      end;
    end;

    case Layout of
      blGlyphLeft:
        begin
          GlyphPos.X := Margin;
          TextPos.X := GlyphPos.X + GlyphSize.X + Spacing;
          DrawStyle := DT_left or dt_WordBreak;
        end;
      blGlyphRight:
        begin
          GlyphPos.X := ClientSize.x - Margin - GlyphSize.X;
          TextPos.X := GlyphPos.X - Spacing - TextSize.X;
          DrawStyle := DT_RIGHT or dt_WordBreak;
        end;
      blGlyphTop:
        begin
          GlyphPos.Y := Margin;
          TextPos.Y := GlyphPos.Y + GlyphSize.Y + Spacing;
          DrawStyle := DT_center or dt_WordBreak;
        end;
      blGlyphBottom:
        begin
          GlyphPos.Y := ClientSize.y - Margin - GlyphSize.Y;
          TextPos.Y := GlyphPos.Y - Spacing - TextSize.Y;
          DrawStyle := DT_center or dt_WordBreak;
        end;
    end;
    r1 := rect(glyphpos.x, glyphpos.y, 0, 0);

//  DrawGlyph(btemp.canvas,r1,bglyph,j,NumGlyphs);
    if (bglyph <> nil) {and Assigned(bglyph.Graphic)} then
      btemp.Canvas.Draw(r1.left, r1.top, bglyph);

    TextBounds := rect(textpos.x, textpos.y, textpos.x + TextSize.x, textpos.y + TextSize.y);

    SetBkMode(btemp.Canvas.Handle, TRANSPARENT);

    if (i = 1) and (fsd.button.newnormal) then
      btemp.canvas.Font.Color := fsd.button.normalcolor2;
    if (i = 4) and (fsd.button.newover) then
      btemp.canvas.Font.Color := fsd.button.overcolor2;
    if (i = 2) and (fsd.Button.newdown) then
      btemp.canvas.Font.Color := fsd.button.downcolor2;
    if not enable then
      btemp.canvas.Font.Color := clBtnShadow;

//  DrawText(bg.canvas.Handle, PChar(btn.caption),Length(btn.caption),TextBounds,DrawStyle);
//  acanvas.draw(rc.left,rc.top,BG);
    drawstyle := CheckBiDi(drawstyle);
    Tnt_DrawTextW(btemp.canvas.Handle, caption, TextBounds, DrawStyle);
    aCanvas.draw(rc.left, rc.top, btemp);
  finally
    fReentr := False;
//  acanvas.Unlock();
  end;

end;



procedure TSkinControl.DrawCaption(acanvas: TCanvas; rc: TRect;
  text: widestring; enabled, defaulted: boolean; Alignment: word = DT_CENTER);
const
  Alignments: array[TAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
var
  r1: TRect;
  DrawStyle: Longint;
begin
  DrawStyle := DT_EXPANDTABS or Alignment;
  r1 := rc;
  SetBkMode(aCanvas.Handle, TRANSPARENT);
  with ACanvas do begin
    Brush.Style := bsClear;
    font.style := [];
//       Calculate vertical layout
//     DrawText(ACanvas.Handle,PChar(Text),Length(Text),r1,DrawStyle or DT_CALCRECT or DT_NOCLIP);
    tnt_DrawTextw(ACanvas.Handle, Text, r1, DrawStyle or DT_CALCRECT or DT_NOCLIP);
    if Alignment = dt_center then
      OffsetRect(r1, ((rc.right - rc.left) - (r1.right - r1.left)) div 2,
        ((rc.Bottom - rc.Top) - (r1.Bottom - r1.Top)) div 2 - 1)
    else begin
      OffsetRect(r1, 0, ((rc.Bottom - rc.Top) - (r1.Bottom - r1.Top)) div 2 - 1);
      r1.Left := rc.left;
      r1.right := rc.Right;
    end;
    if not enabled then Font.Color := clBtnShadow;
//     DrawText(ACanvas.Handle, PChar(Text),-1,r1,DrawStyle);
    DrawStyle := CheckBiDi(DrawStyle);
    Tnt_DrawTextW(ACanvas.Handle, text, r1, DrawStyle);
  end;
end;


procedure TSkinControl.DrawImgCaption(acanvas: TCanvas; rc: TRect;
  ImgList: hImageList; imgIndex: integer; text: widestring; talign: integer = DT_CENTER);
var
  imgrect, textrect, r1, r2: TRect;
  DrawStyle: Longint;
  h, w, margin: integer;
begin
  ImageList_GetIconSize(ImgList, w, h);
  if (imgindex <> -1) and (ImgList <> 0) and ((rc.Right - rc.left) > w) then begin
    imgrect := rect(0, 0, w, h);
  end else begin
    imgrect := rect(0, 0, 0, 0);
    w := 0;
  end;
      //DrawStyle:= DrawStyle or dt_WordBreak ;
  DrawStyle := DT_END_ELLIPSIS or DT_EXPANDTABS or dt_WordBreak; //DT_SINGLELINE;// or DT_CENTER;
  textrect := rc;
  if (ImgList <> 0) and (imgindex <> -1) then dec(textrect.right, -(2 + w));
  if Length(Text) > 0 then
    TNT_DrawTextw(acanvas.Handle, Text, textrect, DrawStyle or DT_CALCRECT or DT_NOCLIP)
//     DrawText(acanvas.Handle,PChar(Text),Length(Text),textrect,DrawStyle or DT_CALCRECT or DT_NOCLIP)
  else textrect.right := textrect.left;
  offsetrect(imgrect, rc.left, rc.top);

  case talign of
    DT_CENTER:
      margin := (rc.right - rc.left - w - (textrect.right - textrect.left)) div 2;
    DT_Left:
      margin := 3;
    DT_right:
      margin := (rc.right - rc.left - w - (textrect.right - textrect.left)) - 2;
  end;
  if margin < 2 then margin := 1;
  offsetrect(imgrect, margin, (rc.bottom - rc.top - w) div 2);
  OffsetRect(textrect, margin + w,
    ((rc.Bottom - rc.Top) - (textrect.Bottom - textrect.Top)) div 2);

  if (ImgList <> 0) and (ImgIndex <> -1) then
    ImageList_Draw(imglist, ImgIndex, ACanvas.handle,
      imgrect.Left, imgrect.Top, ILD_TRANSPARENT);

  if Length(Text) = 0 then exit;

  SetBkMode(aCanvas.Handle, TRANSPARENT);
  ACanvas.Brush.Style := bsClear;
  ACanvas.font.style := [];
  if not enabled then ACanvas.Font.Color := clBtnShadow;
  if textrect.Left < rc.Left then textrect.Left := rc.Left;
  if textrect.right > rc.right then textrect.right := rc.right;
  DrawStyle := CheckBiDi(DrawStyle);
//   DrawText(ACanvas.Handle, PChar(Text),Length(Text),textrect,DrawStyle);
  Tnt_DrawTextW(ACanvas.Handle, Text, textrect, DrawStyle);
end;

{procedure TSkinControl.DrawImgCaption(acanvas: TCanvas; rc:TRect;
 ImgList:TCustomImageList;imgIndex:integer;
 text:string; enabled,default:boolean;Alignment: TAlignment=taCenter);
const
  Alignments: array[TAlignment] of Word = (DT_LEFT,DT_RIGHT,DT_CENTER );
var
  r1: TRect;
  DrawStyle: Longint;
begin
   DrawStyle := DT_EXPANDTABS or DT_SINGLELINE or Alignments[Alignment];
   r1.Left := rc.Left + 6;
   r1.Top := rc.Top + 1;
   r1.Right := r1.Left + 16;
   r1.Bottom := r1.Top + 16;
   if (ImgIndex>-1) and (ImgIndex <ImgList.Count) then
      ImgList.Draw(ACanvas, r1.Left, r1.Top, ImgIndex,Enabled);

   rc.left:=r1.right;
   r1:=rc;

   SetBkMode(aCanvas.Handle, TRANSPARENT);
   with ACanvas do begin
     Brush.Style := bsClear;
//     if Default then
//        Font.Style := Font.Style + [fsBold];
     font.style:=[];
     DrawText(Handle,PChar(Text),Length(Text),r1,DrawStyle or DT_CALCRECT or DT_NOCLIP);
     OffsetRect(r1, ((rc.right - rc.left) - (r1.right - r1.left)) div 2,
        ((rc.Bottom - rc.Top) - (r1.Bottom - r1.Top)) div 2);
     Font.Color := fsd.colors[csButtonText];
     if not enabled then
          Font.Color := clBtnShadow;
     DrawText(Handle, PChar(Text),Length(Text),r1,DrawStyle);
   end;
end;}

procedure TSkinControl.DrawSkinMap(dc: HDC; rc: TRect;
  aObject: TdataSkinObject; I, N: integer);
var
  temp: Tbitmap;
  adc: HDC;
begin
  if (rc.right < rc.left) or (rc.bottom < rc.top) then exit;
  temp := GetHMap(rc, aobject.map, aobject.r, i, n, aobject.tile);
  if aobject.trans = 1 then begin
    DrawTranmap(DC, rc, temp);
  end else
    BitBlt(dc, rc.left, rc.top, rc.right - rc.left, rc.bottom - rc.Top,
      temp.Canvas.Handle, 0, 0, Srccopy);
  temp.free;
end;

function TSkinControl.CheckBiDi(dw: dword): dword;
begin
  if (control <> nil) and (control.BiDiMode = bdRightToLeft) then
    dw := dw or dt_RtlReading;
  if (gcontrol <> nil) and (gcontrol.BiDiMode = bdRightToLeft) then
    dw := dw or dt_RtlReading;
  result := dw;
end;

procedure TSkinControl.DrawBuf(dc: HDC; rc: TRect);
begin
//    fcanvas.handle:=dc;
//    fcanvas.draw(rc.left,rc.top,BG);
  BitBlt(dc, rc.left, rc.top, rc.right - rc.left, rc.bottom - rc.Top,
    bg.Canvas.Handle, 0, 0, Srccopy);
end;

procedure TSkinControl.WMPaint(message: TMessage);
var
  ps: TPaintStruct;
  dc: HDC;
  rc: Trect;
begin
  if (message.wParam = 0) then begin
    DC := BeginPaint(hWnd, ps);
  end else begin
    DC := message.wParam;
  end;

  if GetWindowRect(hWnd, rc) then begin
//       GetWindowRect( hWnd, rc );
    boundsrect := rc;
    OffsetRect(rc, -rc.left, -rc.top);
//       try
    Drawcontrol(dc, rc);
//       except
//       end;
  end;

  if (message.wParam = 0) then
    EndPaint(hWnd, ps);
end;

procedure TSkinControl.WMERASEBKGND(var Msg: TMessage);
var
  r: Trect;
  i: integer;
begin
  i := 0;
  if (control <> nil) then i := control.Tag;
  if (control <> nil) or (i = 8888) then
    DrawParentImage(control, msg.wparam, true)
  else begin
    GetClientRect(hwnd, r);
    fillParentBG(msg.wparam, r);
  end;

//    FillRect( msg.wparam,r,fsd.BGbrush);
  Msg.Result := 1;
end;

procedure TSkinControl.DrawBMPSkin(abmp: Tbitmap; rc: TRect; aObject: TdataSkinObject;
  I, N: integer; trans: integer);
var
  temp: Tbitmap;
begin
  if ((rc.right - rc.left) < 0) or ((rc.bottom - rc.top) < 0) then exit;
  temp := GetHMap(rc, aobject.map, aobject.r, i, n, aobject.tile);
  fillBG(abmp.canvas.handle, rc);
  if trans = 1 then begin
    temp.Transparent := true;
    temp.Transparentcolor := clFuchsia;
//        temp.Transparentcolor:= temp.Canvas.Pixels[0, 0];
  end;
  abmp.canvas.draw(0, 0, temp);
  temp.free;
end;

procedure TSkinControl.DrawSkin(rc: TRect; aObject: TdataSkinObject;
  I, N: integer; trans: integer);
var
  temp: Tbitmap;
begin
  if ((rc.right - rc.left) < 0) or ((rc.bottom - rc.top) < 0) then exit;
  temp := GetHMap(rc, aobject.map, aobject.r, i, n, aobject.tile);
  fillBG(bg.canvas.handle, rc);
  if trans = 1 then begin
    temp.Transparent := true;
    temp.Transparentcolor := clFuchsia;
//        temp.Transparentcolor:= temp.Canvas.Pixels[0, 0];
  end;
  bg.canvas.draw(0, 0, temp);
  temp.free;
end;

procedure TSkinControl.DrawSkinMap1(dc: HDC; rc: TRect;
  bmp: Tbitmap; I, N: integer);
var
  temp: Tbitmap;
  w, h, x: integer;
  adc: HDC;
  acanvas: Tcanvas;
begin
  if (rc.right < rc.left) or (rc.bottom < rc.top) then exit;
  temp := Tbitmap.create;
  w := bmp.width div n;
  h := bmp.height;
  temp.height := rc.bottom - rc.top;
  temp.width := rc.right - rc.left;
  x := (i - 1) * w;
  temp.canvas.copyrect(rect(0, 0, rc.right - rc.left, rc.bottom - rc.top),
    bmp.canvas, rect(x, 0, x + w, h));
  acanvas := Tcanvas.create;
  acanvas.handle := dc;
  try
    temp.Transparent := true;
    temp.Transparentcolor := clFuchsia;
//    temp.Transparentcolor:=temp.Canvas.Pixels[0, 0];
    acanvas.draw(rc.left, rc.top, temp);
  finally
    temp.free;
    acanvas.free;
  end;
end;

procedure TSkinControl.DrawSkinMap3(acanvas: Tcanvas; rc: TRect;
  bmp: Tbitmap; I, N: integer);
var
  temp1: Tbitmap;
  w, h, x: integer;
begin
  if (rc.right < rc.left) or (rc.bottom < rc.top) then exit;
  temp1 := Tbitmap.create;
  w := bmp.width div n;
  h := bmp.height;
  temp1.height := rc.bottom - rc.top;
  temp1.width := rc.right - rc.left;
  x := (i - 1) * w;
  temp1.canvas.copyrect(rect(0, 0, rc.right - rc.left, rc.bottom - rc.top),
    bmp.canvas, rect(x, 0, x + w, h));

  temp1.Transparent := true;
  temp1.Transparentcolor := clFuchsia;

  acanvas.draw(rc.left, rc.top, temp1);
  temp1.free;
end;

procedure TSkinControl.DrawSkinMap2(dc: HDC; rc: TRect;
  bmp: Tbitmap; I, N: integer);
var
  temp: Tbitmap;
  w, h, x: integer;
begin
  if (rc.right < rc.left) or (rc.bottom < rc.top) then exit;
  temp := Tbitmap.create;
  w := bmp.width div n;
  h := bmp.height;
  temp.height := rc.bottom - rc.top;
  temp.width := rc.right - rc.left;
  x := (i - 1) * w;
  temp.canvas.copyrect(rect(0, 0, rc.right - rc.left, rc.bottom - rc.top),
    bmp.canvas, rect(x, 0, x + w, h));

{    fcanvas.handle:=dc;
    temp.Transparent:=true;
    temp.Transparentcolor:=clFuchsia;
//    temp.Transparentcolor:=temp.Canvas.Pixels[0, 0];
    fcanvas.draw(rc.left,rc.top,temp);}

  DrawTranmap(DC, rc, temp);
  temp.free;
end;

{procedure TSkinControl.DrawSkinMap2( dc:HDC; rc:TRect;
       bmp:Tbitmap;I,N:integer);
var mask:Tbitmap;
    w,h,x:integer;
begin
    if (rc.right<rc.left) or (rc.bottom<rc.top) then exit;
    mask:=Tbitmap.create;
    mask.assign(bmp);
    mask.mask(clFuchsia);
    w:=bmp.width div n;
    h:=bmp.height;
    x:=(i-1)*w;
    TransparentStretchBlt(dc,rc.left,rc.Top,rc.Right-rc.Left,rc.Bottom-rc.Top,
       bmp.Canvas.Handle,x,0,x+w,h,mask.Handle,x,0);
    mask.free;
end;}

function TSkinStatusBar.BeforeProc(var Message: TMessage): boolean;
var
  r: Trect;
begin
//    result:=inherited BeforeProc(message);
//    exit;
//Draw child control
  result := true;
  case message.msg of
    WM_ERASEBKGND: begin
        message.result := 1;
        result := false;
      end;
    WM_Paint: begin
        wmpaint(message);
        result := false;
      end;
  else result := inherited BeforeProc(message);
  end;
end;

procedure TSkinStatusBar.DrawControl(dc: HDC; rc: TRect);
const
  Alignments: array[TAlignment] of Longint = (DT_LEFT, DT_RIGHT, DT_CENTER);
var
  i, n, j, m, w1, h1: integer;
  r, r1, r2: Trect;
  sb: Tstatusbar;
  dwstyle: dword;
  bfont, cfont: Hfont;
  Flags: TAlignment;
  text: widestring;
  b: boolean;
begin
  sb := Tstatusbar(control);
  n := sb.Panels.count;
  r1 := rc;
  b := false;
  offsetrect(r1, -r1.left, -r1.top);
  bg.width := r1.right;
  bg.height := r1.bottom;
  bg.canvas.brush.color := fsd.colors[csButtonFace];
  bg.canvas.fillrect(r1);

  bg.canvas.Font := TAcControl(control).Font;
  bg.canvas.font.style := [];
  if fsd.statusbar <> nil then
    bg.canvas.Font.Color := fsd.statusbar.normalcolor2;
//  bfont:=sendmessage(hwnd,wm_getfont,0,0);
//  cfont := selectobject(bg.canvas.handle,bfont);

  if fsd.statusbar <> nil then
    SetTextColor(bg.canvas.handle, ColorToRGB(fsd.statusbar.normalcolor2));

  if (sb.simplepanel) or (sb.Panels.count = 0) then begin
    j := 1;
    if (sb.bidimode = bdRightToLeft) then
      Flags := taRightJustify
    else
      Flags := taLeftJustify;
    text := GetStringProp(sb, 'simpletext');
    if (fsd.statusbar <> nil) and (not fsd.statusbar.map.empty) then
      drawitem(bg.canvas.handle, rc, j, text, Flags)
    else
      Defaultpaint(bg.canvas, rc, j, text, Flags);

    if text = '' then text := ' ';
    r2 := rc;
    InflateRect(r2, -2, 0);
    DrawCaption(bg.canvas, r2, text, true, false, Alignments[flags]);

  end else begin
    m := 0;
    for i := 0 to n - 1 do begin
      j := 0;
      flags := sb.Panels[i].alignment;
      if (sb.Panels[i].bidimode = bdRightToLeft) then begin
        if Flags = taLeftJustify then
          Flags := taRightJustify
        else if Flags = taRightJustify then
          Flags := taLeftJustify;
      end;

      if sb.Panels[i].Bevel = pblowered then j := 1;
      if sb.Panels[i].Bevel = pbNone then j := 3;
      if sb.Panels[i].Bevel = pbRaised then j := 2;
      if sendmessage(hwnd, SB_GETRECT, i, integer(@r)) <> 0 then begin
         //InflateRect( r, 2, 0 );
        inc(r.Right, 2);
        if i = n - 1 then r.Right := rc.Right;
        text := GetStringProp(sb.Panels[i], 'Text');

        if (fsd.statusbar <> nil) and (not fsd.statusbar.map.empty) then
          drawitem(bg.canvas.handle, r, j, text, Flags)
        else
          Defaultpaint(bg.canvas, r, j, text, Flags);

        if sb.Panels[i].Style = psText then begin
          if text = '' then text := ' ';
          InflateRect(r, -2, 0);
          DrawCaption(bg.canvas, r, text, true, false, Alignments[flags]);
        end;
      end;
    end;
  end;

  dwstyle := GetWindowLong(hWnd, GWL_STYLE);
  if (dwstyle and SBARS_SIZEGRIP) > 0 then begin
    r1.Right := rc.Right - 1;
    r1.bottom := rc.bottom - 1;
    if (fsd.ExtraImages <> nil) and (not fsd.ExtraImages.map.empty) then begin
      w1 := fsd.ExtraImages.map.width div fsd.ExtraImages.frame;
      h1 := fsd.ExtraImages.map.height;
      r1.left := r1.right - w1;
      r1.top := r1.bottom - h1;
      DrawSkinMap1(bg.canvas.handle, r1, fsd.ExtraImages.map, 5, fsd.ExtraImages.frame);
    end;
  end;


  DrawBuf(dc, rc);

  if control <> nil then
    TAcWincontrol(control).PaintControls(dc, nil);

  if assigned(sb.ondrawpanel) and (n > 0) then begin
    for i := 0 to n - 1 do begin
      if sendmessage(hwnd, SB_GETRECT, i, integer(@r)) <> 0 then begin
        InflateRect(r, -2, -2);
        sb.ondrawpanel(sb, sb.Panels[i], r);
      end;
    end;
  end;
//  selectobject(bg.canvas.handle,cfont);
end;

{procedure TSkinStatusBar.DrawControl( dc:HDC; rc:TRect);
var i,n,j,m,l,w1,h1:integer;
    r,r1,r2:Trect;
    bfont,cfont:Hfont;
    dwstyle:dword;
    issimple:boolean;
    Buffer: array[0..128] of Char;
    s:string;
begin
//   if fsd.statusbar=nil then exit;
  n:=sendmessage(hwnd,SB_GETPARTS,0,integer(@l));
  r1:=rc;
  offsetrect(r1,-r1.left,-r1.top);
  bg.width:=r1.right;
  bg.height:=r1.bottom;
  bg.canvas.brush.color:=fsd.colors[csButtonFace];
  bg.canvas.fillrect(r1);

  bg.canvas.Font.style := [];
  bfont:=sendmessage(hwnd,wm_getfont,0,0);
  cfont := selectobject(bg.canvas.handle,bfont);
  if fsd.statusbar<>nil then
        SetTextColor(bg.canvas.handle,fsd.statusbar.normalcolor2);

  issimple:= (sendmessage(hwnd,SB_ISSIMPLE,0,0)>0);
  if (issimple) or (n=0) then begin
      j:=1;
      sendmessage(hwnd,SB_GETTEXT,0,integer(@buffer));
      s:=buffer;
      if (fsd.statusbar<>nil) and (not fsd.statusbar.map.empty) then
         drawitem(bg.canvas.handle,rc,j,s,taLeftJustify)
      else
         Defaultpaint(bg.canvas.handle,rc,j,s,taLeftJustify);
  end else begin
    m:=0;
    for i:= 0 to n-1 do begin
      m:= sendmessage(hwnd,SB_GETTEXT,i,integer(@buffer));
      m := m div 16;
      s:=buffer;
      case m of
         0 : j:=1;
         SBT_NOBORDERS : j:=0;
         SBT_POPOUT : j :=2;
         else j:=0;
      end;
      if sendmessage(hwnd,SB_GETRECT,i,integer(@r))<>0 then begin
         if i=n-1 then r.Right := rc.Right;
         if (fsd.statusbar<>nil) and (not fsd.statusbar.map.empty) then
           drawitem(bg.canvas.handle,r,j,s,taLeftJustify)
         else
           Defaultpaint(bg.canvas.handle,r,j,s,taLeftJustify);
      end;
    end;
  end;

  dwstyle:= GetWindowLong(hWnd,GWL_STYLE);
  if (dwstyle and SBARS_SIZEGRIP)>0 then begin
     r1.Right := rc.Right - 1;
     r1.bottom := rc.bottom - 1;
     if (fsd.ExtraImages<>nil) and (not fsd.ExtraImages.map.empty) then begin
        w1:= fsd.ExtraImages.map.width div fsd.ExtraImages.frame;
        h1:= fsd.ExtraImages.map.height;
        r1.left:=r1.right - w1 ;
        r1.top:= r1.bottom - h1;
        DrawSkinMap1( bg.canvas.handle,r1,fsd.ExtraImages.map,5,fsd.ExtraImages.frame);
     end;
  end;

  DrawBuf( dc,rc);
  selectobject(bg.canvas.handle,cfont);
end;}

procedure TSkinStatusBar.drawitem(dc: HDC; rc: TRect; I: integer; text: widestring = ''; Align: TAlignment = taLeftJustify);
const
  Alignments: array[TAlignment] of Longint = (DT_LEFT, DT_RIGHT, DT_CENTER);
var
  temp: TBitmap;
  FontHeight: Integer;
  Flags: Longint;
  acolor: Tcolor;
begin
  if (rc.right < rc.left) or (rc.bottom < rc.top) then exit;
  temp := GetHMap(rc, fsd.statusbar.map, fsd.statusbar.r, i, 3, fsd.statusbar.tile);
  BitBlt(dc, rc.left, rc.top, rc.right - rc.left, rc.bottom - rc.top,
    temp.Canvas.Handle, 0, 0, Srccopy);
  temp.free;
{    if text='' then text:=' ';
    InflateRect( rc, -2, 0 );
    DrawCaption(dc,rc,text,true,false,Alignments[Align]);}
end;


procedure TSkinStatusBar.Defaultpaint(acanvas: Tcanvas; rc: TRect; I: integer;
  text: widestring = ''; Align: TAlignment = taLeftJustify);
var
  TopColor, BottomColor: TColor;
  FontHeight: Integer;
  Flags: Longint;

  procedure AdjustColors(Bevel: TStatusPanelBevel);
  begin
    TopColor := clBtnHighlight;
    if Bevel = pbLowered then TopColor := clBtnShadow;
    BottomColor := clBtnShadow;
    if Bevel = pbLowered then BottomColor := clBtnHighlight;
  end;

begin
  if i = 1 then begin
    AdjustColors(pbLowered);
    Frame3D(acanvas, Rc, TopColor, BottomColor, 1);
  end else if i = 2 then begin
    AdjustColors(pbRaised);
    Frame3D(acanvas, Rc, TopColor, BottomColor, 1);
  end;

//  if text='' then text:=' ';
//  InflateRect( rc, -2, 0 );
//  DrawCaption(dc,rc,text,true,false,Alignments[Align]);

{  with bg.Canvas do begin
    Brush.Color := fsd.colors[csButtonFace];
    FillRect(rc);
    SetBkMode(Handle, TRANSPARENT);
    Font := TAcControl(control).Font;
    font.style:=[];
    FontHeight := TextHeight('W');
    with rc do  begin
      Top := ((Bottom + Top) - FontHeight) div 2;
      Bottom := Top + FontHeight;
    end;
    Flags := DT_EXPANDTABS or DT_VCENTER or Alignments[Align];
//    Flags := DrawTextBiDiModeFlags(Flags);
    DrawText(Handle, PChar(text), -1, rc, Flags);
  end;}
end;

procedure TSkinGroupBox.Init(sf: Tcomponent; sd: TSkinData; acanvas: TCanvas; acolor: boolean = false);
var
  s: string;
begin
  inherited init(sf, sd, acanvas, acolor);
  if control = nil then exit;
//   s := lowercase(GetEnumProperty(control,'Transparent'));
//   if s='true' then kind:=1;
  kind := 1;
end;

function TSkinGroupBox.BeforeProc(var Message: TMessage): boolean;
var
  r: Trect;
begin
  result := true;
  result := inherited BeforeProc(message);
  if kind = 0 then exit;
  case message.msg of
    //has problem in TScrollbox.
{      WM_ERASEBKGND:begin
             WMERASEBKGND(message);
             message.Result:=1;
             result:=false;
          end;   }
    WM_Paint: begin
        wmpaint(message);
        result := false;
      end;
  end;
end;

procedure TSkinGroupBox.DrawControl(dc: HDC; rc: TRect);
var
  r, r1: Trect;
  oldcolor, i: integer;
  bfont, cfont: Hfont;
  OldMode: integer;
  font: Tfont;
  dw: dword;
begin
  defaultdraw(dc, rc);
  exit;
  if (fsd.box = nil) or (fsd.box.map.empty) then exit;
  i := 1;
  DrawSkinMap(dc, rc, fsd.box, I, fsd.box.frame);

  caption := getformcaption(hwnd);
  if (control <> nil) then
    caption := GetStringProp(control, 'Caption')
  else
    caption := getformcaption(hwnd);

  if control <> nil then begin
    font := Tfont(GetObjProp(control, 'Font', Tfont));
    if font <> nil then begin
      bfont := font.Handle;
      SetTextColor(dc, ColorToRGB(font.Color));
    end;
  end else
    bfont := sendmessage(hwnd, wm_getfont, 0, 0);

//   if (control<>nil) then
//     bfont := Taccontrol(control).font.Handle;

  cfont := selectobject(dc, bfont);
  OldMode := SetBkMode(dc, TRANSPARENT);
//   oldcolor := setbkcolor(dc,fsd.colors[csButtonFace]);
  r1 := rect(rc.Left + 10, rc.top + 1, rc.right, rc.bottom);
//   DrawText(dc, PChar(caption),-1,r1,DT_EXPANDTABS or DT_Left);
  Tnt_DrawTextW(dc, caption, r1, DT_EXPANDTABS or DT_Left);
//   setbkcolor(dc,oldcolor);
  SetBkMode(dc, OldMode);
  selectobject(dc, cfont);

  if (control <> nil) and (kind = 1) then
    TAcWincontrol(control).PaintControls(dc, nil);
end;

function TSkincontrol.TextHeight(dc: HDC; const s: string): integer;
var
  asize: TSize;
begin
  asize.cX := 0;
  asize.cY := 0;
  Windows.GetTextExtentPoint32(dc, PChar(s), Length(s), asize);
  result := asize.cy;
end;

procedure TSkinGroupBox.DefaultDraw(dc: HDC; rc: TRect);
var
  r, r1: Trect;
  oldcolor, i, h: integer;
  bfont, cfont: Hfont;
  oldbrush, nbrush: HBRUSH;
  oldpen, npen: Hpen;
  oldmode: integer;
  font: Tfont;
  exstyle: dword;
  dw: dword;
begin
  caption := getformcaption(hwnd);
  if (caption = '') and (control <> nil) then begin
    caption := GetStringProp(control, 'Caption');
  end;

  if control <> nil then FillBG(dc, rc);

{   if control<>nil then
      DrawParentImage(control,dc,true)
   else FillBG(dc,rc);}

{   bfont:=sendmessage(hwnd,wm_getfont,0,0);
   if (control<>nil) then
     bfont := Taccontrol(control).font.Handle;}

  bfont := sendmessage(hwnd, wm_getfont, 0, 0);
  if control <> nil then begin
      //font := Tfont(GetObjProp(control,'Font',Tfont));
    font := Taccontrol(control).font;
    if font <> nil then begin
      bfont := font.Handle;
      SetTextColor(dc, ColorToRGB(font.Color));
    end;
  end;

  cfont := selectobject(dc, bfont);

  h := TextHeight(dc, '0');

  npen := CreatePen(PS_SOLID, 1, fsd.colors[csButtonShadow]);
  r1 := Rect(0, H div 2 - 1, rc.right, rc.bottom);
  r := r1;
  if kind = 0 then begin
    framerect(dc, r, fsd.BGBrush);
    InflateRect(R, -1, -1);
    framerect(dc, r, fsd.BGBrush);
  end;

  nbrush := GetStockObject(NULL_BRUSH);
  oldbrush := selectobject(dc, nbrush);
  oldpen := selectobject(dc, npen);
  r1 := Rect(1, H div 2 - 1, rc.right - 1, rc.bottom - 1);
  RoundRect(dc, r1.left, r1.top, r1.right, r1.bottom, 5, 5);

  selectobject(dc, oldBrush);
  selectobject(dc, oldpen);
  deleteobject(npen);

//   OldMode := SetBkMode(dc, TRANSPARENT);
  dw := DT_EXPANDTABS;
  oldcolor := setbkcolor(dc, fsd.colors[csButtonFace]);
  ExStyle := GetWindowLong(hWnd, GWL_ExSTYLE);
  if (exstyle and WS_EX_Right) > 0 then begin
    r1 := rect(rc.Left, rc.top, rc.right - 8, rc.bottom);
    dw := dw or DT_Right;
    dw := checkBidi(dw);
    Tnt_DrawTextW(dc, caption, r1, dw);
  end else begin
    r1 := rect(rc.Left + 8, rc.top, rc.right, rc.bottom);
    dw := dw or DT_Left;
    Tnt_DrawTextW(dc, caption, r1, dw);
  end;
  setbkcolor(dc, oldcolor);
  selectobject(dc, cfont);
//   SetBkMode(dc, OldMode);

  if (control <> nil) and (kind = 1) then
    TAcWincontrol(control).PaintControls(dc, nil);

end;

procedure TSkinBox.AfterProc(var Message: TMessage);
begin
end;

procedure TSkinBox.Init(sf: Tcomponent; sd: TSkinData; acanvas: TCanvas; acolor: boolean = false);
begin
//   inherited init(sf,sd,acanvas,acolor);
  newcolor := acolor;
  fsd := sd;
  fCanvas := acanvas;
  control := Twincontrol(owner);
  hwnd := control.handle;
  skinform := sf;
  Twinskinform(sf).addcontrollist(self);
//   OldWndProc:= Control.WindowProc;
//   Control.WindowProc := NewWndProc;

  if newcolor then begin
    setparentbk(true);
    oldcolor := Taccontrol(control).color;
    Taccontrol(control).color := fsd.colors[csButtonFace];
  end;
end;

procedure TSkinBox.Unsubclass;
var
  b: boolean;
begin
  b := true;
  if skinstate = skin_destory then b := false;
  if b and newcolor and (control <> nil) then begin
    setparentbk(false);
    Taccontrol(control).color := oldcolor;
  end;
  skinstate := skin_uninstall;
end;

function copypchar(pstr: pchar; len: integer): string;
begin
  if len > 0 then begin
    setlength(result, len);
    move(pstr, result[1], len);
  end;
end;

procedure MyDrawCaption(acanvas: TCanvas; rc: TRect;
  text: widestring; enabled, defaulted: boolean; Alignment: TAlignment = taCenter);
const
  Alignments: array[TAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
var
  r1: TRect;
  DrawStyle: Longint;
begin
  DrawStyle := DT_EXPANDTABS or DT_SINGLELINE or Alignments[Alignment];
  r1 := rc;
  SetBkMode(aCanvas.Handle, TRANSPARENT);
  with ACanvas do begin
    Brush.Style := bsClear;
    font.style := [];
//       Calculate vertical layout
//     DrawText(ACanvas.Handle,PChar(Text),Length(Text),r1,DrawStyle or DT_CALCRECT or DT_NOCLIP);
    tnt_drawtextw(ACanvas.Handle, Text, r1, DrawStyle or DT_CALCRECT or DT_NOCLIP);
    OffsetRect(r1, ((rc.right - rc.left) - (r1.right - r1.left)) div 2,
      ((rc.Bottom - rc.Top) - (r1.Bottom - r1.Top)) div 2);
    if not enabled then
      Font.Color := clBtnShadow;
     //DrawText(ACanvas.Handle, PChar(Text),Length(Text),r1,DrawStyle);
    Tnt_DrawTextW(ACanvas.Handle, Text, r1, DrawStyle);
  end;
end;

procedure DrawArrow(ACanvas: TCanvas; X, Y, Orientation: integer);
begin
  case Orientation of
    0:
      begin
        ACanvas.MoveTo(X, Y);
        ACanvas.LineTo(X, Y - 1);

        ACanvas.MoveTo(X + 1, Y + 1);
        ACanvas.LineTo(X + 4, Y + 4);

        ACanvas.MoveTo(X, Y + 1);
        ACanvas.LineTo(X + 3, Y + 4);

        ACanvas.MoveTo(X, Y + 2);
        ACanvas.LineTo(X + 2, Y + 4);


        ACanvas.MoveTo(X - 1, Y + 1);
        ACanvas.LineTo(X - 4, Y + 4);

        ACanvas.MoveTo(X, Y + 2);
        ACanvas.LineTo(X - 3, Y + 4);

        ACanvas.MoveTo(X, Y + 1);
        ACanvas.LineTo(X - 2, Y + 4);
      end;
    1:
      begin
        ACanvas.MoveTo(X, Y + 3);
        ACanvas.LineTo(X, Y + 4);

        ACanvas.MoveTo(X + 1, Y + 2);
        ACanvas.LineTo(X + 4, Y - 1);

        ACanvas.MoveTo(X, Y + 2);
        ACanvas.LineTo(X + 3, Y - 1);

        ACanvas.MoveTo(X, Y + 1);
        ACanvas.LineTo(X + 2, Y + 0);

        ACanvas.MoveTo(X - 1, Y + 2);
        ACanvas.LineTo(X - 4, Y - 1);

        ACanvas.MoveTo(X, Y + 2);
        ACanvas.LineTo(X - 3, Y - 1);

        ACanvas.MoveTo(X, Y + 1);
        ACanvas.LineTo(X - 2, Y + 0);
      end;
    2:                                  //left
      begin
        ACanvas.MoveTo(X, Y);
        ACanvas.lineTo(X + 1, Y + 2);
        ACanvas.LineTo(X + 1, Y - 2);
        ACanvas.LineTo(X - 1, Y);
        ACanvas.LineTo(X + 1, Y + 2);
      end;
    3:                                  //right
      begin
        ACanvas.MoveTo(X, Y);
        ACanvas.lineTo(X - 1, Y + 2);
        ACanvas.LineTo(X - 1, Y - 2);
        ACanvas.LineTo(X + 1, Y);
        ACanvas.LineTo(X - 1, Y + 2);
      end;
  end;
end;

procedure MyDrawImgCaption(acanvas: TCanvas; rc: TRect;
  ImgList: TCustomImageList; imgIndex: integer;
  text: string; enabled, defaulted: boolean; Alignment: TAlignment = taCenter);
const
  Alignments: array[TAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
var
  r1: TRect;
  DrawStyle: Longint;
begin
  DrawStyle := DT_EXPANDTABS or DT_SINGLELINE or Alignments[Alignment];
  r1.Left := rc.Left + 6;
  r1.Top := rc.Top + 1;
  r1.Right := r1.Left + 16;
  r1.Bottom := r1.Top + 16;
  if (ImgIndex > -1) and (ImgIndex < ImgList.Count) then
    ImgList.Draw(ACanvas, r1.Left, r1.Top, ImgIndex, Enabled);

  rc.left := r1.right;
  r1 := rc;

  SetBkMode(aCanvas.Handle, TRANSPARENT);
  with ACanvas do begin
    Brush.Style := bsClear;
//     if Default then
//        Font.Style := Font.Style + [fsBold];
    font.style := [];
    DrawText(Handle, PChar(Text), Length(Text), r1, DrawStyle or DT_CALCRECT or DT_NOCLIP);
    OffsetRect(r1, ((rc.right - rc.left) - (r1.right - r1.left)) div 2,
      ((rc.Bottom - rc.Top) - (r1.Bottom - r1.Top)) div 2);
    if not enabled then
      Font.Color := clBtnShadow;
//     DrawText(Handle, PChar(Text),Length(Text),r1,DrawStyle);
    Tnt_DrawTextW(Handle, Text, r1, DrawStyle);
  end;
end;

function TSkinTransObj.BeforeProc(var Message: TMessage): boolean;
begin
  result := true;
  case message.msg of
    WM_ERASEBKGND: begin
        ERASEBKGND(message.wparam);
        message.result := 1;
        result := false;
      end;
    WM_Paint: begin
        SetBkColor(message.wparam, fsd.colors[csButtonFace]);
      end;
  else result := inherited beforeproc(message);
  end;
end;

procedure TSkinTransObj.AfterProc(var Message: TMessage);
begin
  inherited;
end;

procedure TSkinTransObj.ERASEBKGND(dc: HDC);
var
  rc, r1: Trect;
  n: integer;
begin
  GetWindowRect(hWnd, rc);
  OffsetRect(rc, -rc.left, -rc.top);
  fillbg(dc, rc);
end;

constructor TSkinTab.Create(AOwner: TComponent);
begin
  inherited create(aowner);
  tabbmp := Tbitmap.create;
  borderbmp := Tbitmap.create;
  Drawtemp := Tbitmap.create;
  Drawtemp.PixelFormat := pf24bit;
  showclose := false;
end;

destructor TSkinTab.Destroy;
begin
  tabbmp.free;
  borderbmp.free;
  Drawtemp.free;
  inherited destroy;
end;

function TSkinTab.ClickClose(var Message: TMessage): boolean;
var
  p: TPoint;
  i, j: integer;
begin
  result := false;
  p := Point(message.LParamLo, message.LParamHi);
  for i := 0 to high(closerect) do begin
    if PtInrect(closerect[i], p) then begin
      j := sendmessage(TWinskinForm(skinform).Hwnd, CN_TabSheetClose, hwnd, i);
      if j = 0 then
        Tpagecontrol(control).Pages[i].free;
            //ShowMessage('Click CloseBtn '+inttostr(i));
      result := true;
    end;
  end;
end;

function TSkinTab.BeforeProc(var Message: TMessage): boolean;
begin
  case message.msg of
    wm_paint: begin
//           if kind<>2 then begin
        wmpaint(message);
        result := false;
//           end else result:=true;
      end;
    WM_LBUTTONDOWN: begin
        if showclose and clickclose(message) then begin
          result := false;
          message.Result := 0;
          exit;
        end else
          result := inherited beforeProc(message);
      end;
  else result := inherited beforeProc(message);
  end;
end;

{procedure TSkinTab.AfterProc(var Message: TMessage);
var i:integer;
begin
    case message.msg of
      CN_TabSheetClose:begin
         i := sendmessage( TWinskinForm(skinform).Hwnd,message.Msg,hwnd,message.WParam);
         if i=0 then
            Tpagecontrol(control).Pages[message.WParam].free;
         message.result:=0;
       end;
    else inherited AfterProc(message);
    end;
end;}

procedure TSkinTab.Init(sf: Tcomponent; sd: TSkinData; acanvas: TCanvas; acolor: boolean = false);
begin
  inherited init(sf, sd, acanvas, acolor);
  enabled := (GetWindowLong(hWnd, GWL_STYLE) and WS_DISABLED) = 0;
{   Focused := (GetFocus= hWnd);
   enabled := (GetWindowLong(hWnd,GWL_STYLE) and WS_DISABLED)=0;
   caption:=getformcaption(hwnd);}
  if (owner.Tag = 7777) and (owner is Tpagecontrol)
    and (Tpagecontrol(control).TabPosition = tpTop) then showclose := true;
  inittab;
  FindScroll;
  skinned := true;
  unicode := IsWindowUnicode(hwnd);
end;

procedure TSkinTab.Inithwnd(ahwnd: Thandle; sd: TSkinData; acanvas: TCanvas; sf: Tcomponent);
begin
  inherited Inithwnd(ahwnd, sd, acanvas, sf);

  Focused := (GetFocus = hWnd);
  enabled := (GetWindowLong(hWnd, GWL_STYLE) and WS_DISABLED) = 0;
  caption := getformcaption(hwnd);
  inittab;
  FindScroll;
  skinned := true;
  unicode := IsWindowUnicode(hwnd);
end;

procedure TSkinTab.SkinChange;
begin
  inherited skinchange;
  inittab;
end;

procedure TSkinTab.inittab;
begin
  tabbmp.empty;
  borderbmp.empty;
  GetPosition;
  if (fsd.tab <> nil) and (not fsd.tab.map.empty) then
    CopyBMP(fsd.tab.Map, tabbmp);
  if (fsd.tab.style = 0) and (not fsd.tab.maskmap.empty) then
    CopyBMP(fsd.tab.maskMap, borderbmp);

  if (fsd.tab.style = 1) and (fsd.TabSheet <> nil) and
    (not fsd.tabsheet.map.empty) then
    CopyBMP(fsd.tabsheet.Map, borderbmp);

  tabbmp.PixelFormat := pf24bit;
  borderbmp.PixelFormat := pf24bit;
  case position of
    stleft: begin
        Drehen270Grad(borderbmp);
      end;
    stright: begin
        Drehen90Grad(borderbmp);
      end;
    stbottom: begin
        SpiegelnVertikal(borderbmp);
        SpiegelnVertikal(tabbmp);
      end;
  end;

{   if (fsd.tab<>nil) and (not fsd.tab.map.empty)
     and (not fsd.tab.maskmap.empty) then begin
//       tabbmp.assign(fsd.tab.map);
//       borderbmp.assign(fsd.tab.maskmap);
       CopyBMP(fsd.tab.Map,tabbmp);
       CopyBMP(fsd.tab.maskMap,borderbmp);
       tabbmp.PixelFormat:= pf24bit;
       borderbmp.PixelFormat:= pf24bit;
      case position of
        stleft: begin
             Drehen270Grad(borderbmp);
           end;
        stright: begin
             Drehen90Grad(borderbmp);
           end;
        stbottom: begin
             SpiegelnVertikal(borderbmp);
             SpiegelnVertikal(tabbmp);
           end;
      end;
   end;}
end;

{function TSkinTab.BeforeProc(var Message: TMessage):boolean;
begin
    result:=inherited BeforeProc(message);
    //label dispear in tab
    case message.msg of
      WM_PAINT: begin
          wmpaint(message);
          result:=false;
      end;
      else result:=inherited BeforeProc(message);
    end;
    result:=true;
    case message.msg of
      WM_NCPAINT,WM_PRINTCLIENT: begin
          DrawTabborder(message.wparam);
          Message.Result := 0;
          result:=false;
      end;
      WM_ERASEBKGND: begin
          DrawTabborder(message.wparam);
          message.result:=1;
          result:=false;
      end;
      else result:=inherited BeforeProc(message);
    end;
end;}

procedure TSkinTab.DrawTabBorder(adc: HDC);
var
  rt: Trect;
  dc: HDC;
  i: integer;
begin
  if (fsd.tab.maskmap <> nil) and (not fsd.tab.maskmap.empty) then begin
      //if adc=0 then  DC := GetWindowDC( hWnd )
      //else dc:=adc;
    DC := GetWindowDC(hWnd);
    GetClientRect(hwnd, rt);
//      i:=SendMessage( hWnd, TCM_ADJUSTRECT, 0, integer(@RT) );
    TabCtrl_AdjustRect(hWnd, false, @RT);
//      GetClientRect(hwnd,rt);
    InflateRect(rt, 4, 2);
    offsetrect(rt, 0, 1);
    DrawRect2(DC, rt, fsd.tab.maskmap, rect(4, 5, 4, 4), 1, 1);
      //end;
      //if adc=0 then
    ReleaseDC(hwnd, DC);
  end;
end;


function TSkinTab.FindScroll: boolean;
var
  Wnd: THandle;
begin
  Wnd := FindWindowEx(hwnd, 0, 'msctls_updown32', nil);
  if (Wnd <> 0) and (updown = nil) then begin
    updown := Tskinupdown.create(self.owner);
    updown.inithwnd(wnd, fsd, fcanvas, skinform);
  end;
  result := (GetWindowLong(wnd, GWL_STYLE) and WS_visible) > 0;
end;

procedure TSkinTab.ERASEBKGND(dc: HDC);
var
  rc, r1: Trect;
  n: integer;
begin
  if GetWindowRect(hWnd, rc) then
    FillRect(dc, rc, fsd.BGbrush);
end;

procedure TSkinTab.GetPosition;
var
  dwStyle: longint;
begin
  dwStyle := GetWindowLong(hWnd, GWL_STYLE);
  if (dwStyle and TCS_BOTTOM) > 0 then begin
    if (dwStyle and TCS_VERTICAL) > 0 then
      position := stRight
    else
      position := stBottom;
  end else begin
    if (dwStyle and TCS_VERTICAL) > 0 then
      position := stLeft
    else
      position := stTop;
  end;
end;

{procedure TSkinTab.WMPaint(var msg:Tmessage);
var
  DC, MemDC: HDC;
  MemBitmap, OldBitmap: HBITMAP;
  PS: TPaintStruct;
  rc:Trect;
begin
//   inherited wmpaint(msg);
    getwindowrect(hwnd,rc);
    offsetrect(rc,-rc.left,-rc.top);
    DC := GetDC(0);
    MemBitmap := CreateCompatibleBitmap(DC, rc.Right, rc.Bottom);
    ReleaseDC(0, DC);
    MemDC := CreateCompatibleDC(0);
    OldBitmap := SelectObject(MemDC, MemBitmap);
    try
      DC := BeginPaint(hwnd, PS);
      //control.Perform(WM_ERASEBKGND, MemDC, MemDC);
      SetBkMode(MemDC, TRANSPARENT);

      Msg.wparam := MemDC;
      OldWndProc(msg);
      Msg.wparam := 0;
      BitBlt(DC, 0, 0, rc.Right, rc.Bottom, MemDC, 0, 0, SRCCOPY);
      EndPaint(hwnd, PS);
    finally
      SelectObject(MemDC, OldBitmap);
      DeleteDC(MemDC);
      DeleteObject(MemBitmap);
    end;
end;}


procedure TSkinTab.DrawControl(dc: HDC; rc: TRect);
var
  i, j, n, m, bw, w, h, x, y, truerect: integer;
  rt, r1, r2, r3, r4: Trect;
  item: TC_ITEM;
  s: string;
  b: boolean;
  acolor: Tcolor;
  TCItemW: TTCItemW;
  TCItem: TTCItem;
  Buffer: array[0.._maxcaption - 1] of Char;
  imglist: Himagelist;
  bfont, cfont: Hfont;
  wnd: Thandle;
  ws: widestring;
  isTabcontrol: boolean;
begin
  b := (fsd.tab <> nil) and (not fsd.tab.map.empty);

  rt := rc;
  SendMessage(hWnd, TCM_ADJUSTRECT, 0, integer(@RT));
  InflateRect(rt, 4, 4);

  m := sendmessage(hwnd, TCM_GETITEMCOUNT, 0, 0);
  n := sendmessage(hwnd, TCM_GETCURFOCUS, 0, 0);
  sendmessage(hwnd, TCM_GETITEMRECT, n, integer(@r1));
  imglist := sendmessage(hwnd, TCM_GETIMAGELIST, 0, 0);
  case position of
    sttop: inc(rt.top, 1);
    stbottom: dec(rt.bottom, 1);
    stleft: inc(rt.left, 1);
    stright: dec(rt.right, 1);
  end;
  setlength(closerect, m);

  if b then begin
      //tab area
    case position of
      sttop: r2 := rect(rc.left, rc.top, rc.right, rt.top);
      stbottom: r2 := rect(rc.left, rt.bottom, rc.right, rc.bottom);
      stleft: r2 := rect(rc.left, rc.top, rt.left, rc.bottom);
      stright: r2 := rect(rt.right, rc.top, rc.right, rc.bottom);
    end;
    if position in [sttop, stbottom] then begin
      w := r2.right - r2.left;
      h := r2.bottom - r2.top;
    end else begin
      h := r2.right - r2.left;
      w := r2.bottom - r2.top;
    end;
    Drawtemp.width := w;
    Drawtemp.height := h;

    fillparentbg(Drawtemp.canvas.handle, rect(0, 0, w, h));
//      fillbg(Drawtemp.canvas.handle,rect(0,0,w,h));
//      Drawtemp.canvas.Font.Color := fsd.colors[csButtonText];
    bfont := sendmessage(hwnd, wm_getfont, 0, 0);
    cfont := selectobject(drawtemp.canvas.handle, bfont);

    for i := 0 to m - 1 do begin
      if unicode then begin
        TCItemW.mask := TCIF_IMAGE or TCIF_STATE or TCIF_TEXT;
        TCItemW.pszText := Pwidechar(@buffer);
        TCItemW.cchTextMax := _maxcaption;
        SendMessage(Hwnd, TCM_GETITEMW, I, Longint(@TCItemW));
        ws := _Wstr(TCItemW.pszText, -1);
      end else begin
        TCItem.mask := TCIF_IMAGE or TCIF_STATE or TCIF_TEXT;
        TCItem.pszText := Pchar(@buffer);
        TCItem.cchTextMax := _maxcaption;
        SendMessage(Hwnd, TCM_GETITEM, I, Longint(@TCItem));
        ws := StrToWideStr(buffer);
      end;

      TrueRect := sendmessage(hwnd, TCM_GETITEMRECT, i, integer(@r1));
      if TrueRect = 0 then continue;
      case position of
        sttop: offsetrect(r1, 0, 1);
        stbottom: offsetrect(r1, 0, -rt.bottom - 1);
        stleft: r1 := rect(w - r1.bottom, r1.left, w - r1.top, r1.right);
        stright: r1 := rect(r1.top - 1, rc.right - r1.right, r1.bottom - 1, rc.right - r1.left);
      end;

      if i <> n then j := 1 else j := 2;
      drawitem(Drawtemp.canvas.handle, r1, j);
      if showclose then
        drawCloseBtn(r1, i);

      if (position = sttop) or (position = stbottom) then
        selectobject(drawtemp.canvas.handle, bfont);

      if (j = 1) then
        SetTextColor(Drawtemp.canvas.handle, ColorToRGB(fsd.tab.normalcolor2));
      if (j = 2) then
        SetTextColor(Drawtemp.canvas.handle, ColorToRGB(fsd.tab.overcolor2));

      if unicode then
        DrawImgCaption(Drawtemp.canvas, r1, imglist, TCItemW.iImage, ws)
      else
        DrawImgCaption(Drawtemp.canvas, r1, imglist, TCItem.iImage, ws);
//         DrawImgCaption(Drawtemp.canvas,r1,imglist,TCItem.iImage,ws);
    end;                                //end for
    selectobject(drawtemp.canvas.handle, cfont);

    if position = stright then
      Drehen90Grad(drawtemp)
    else if position = stleft then
      Drehen270Grad(drawtemp);
    if FindScroll then begin
      clipUpdown(dc, r2);
    end else begin
      BitBlt(dc, r2.left, r2.top, r2.right, r2.bottom,
        drawtemp.Canvas.Handle, 0, 0, SrcCopy);
    end;
  end;

  if (borderbmp.Empty) then exit;
//   istabcontrol := (control<>nil) and (control is Tpagecontrol);
  if (fsd.tab.style = 0) then begin
    try
      //DrawBorder(Dc,rt,borderbmp,rect(4,5,4,2),1,1);
      DrawRect2(Dc, rt, borderbmp, rect(4, 5, 4, 4), 1, 1);
    except
    end;
  end else begin
    DrawRect2(Dc, rt, borderbmp, fsd.TabSheet.r, 1, 1);
//      DrawBorder(Dc,rt,borderbmp,fsd.TabSheet.r,1,1);
  end;
   //paint control of TTabsheet
  if (control <> nil) and (kind = 2) then
    TAcWincontrol(control).PaintControls(dc, nil);
end;

procedure TSkinTab.ClipUpdown(dc: HDC; rc: Trect);
var
  r1, r2: Trect;
  MyRgn: hRgn;
begin
  getwindowrect(updown.hwnd, r1);
  getwindowrect(hwnd, r2);
  offsetrect(r1, -r2.left, -r2.top);
  offsetrect(r2, -r2.left, -r2.top);
  MyRgn := CreateRectRgn(0, 0, r2.right, r2.bottom);
  SelectClipRgn(dc, MyRgn);
  ExcludeClipRect(dc, r1.left, r1.top, r1.right, r1.bottom);
  BitBlt(dc, rc.left, rc.top, rc.right, rc.bottom,
    drawtemp.Canvas.Handle, 0, 0, SrcCopy);
  SelectClipRgn(dc, 0);
  DeleteObject(MyRgn);
end;

procedure TSkinTab.drawitem(dc: HDC; rc: TRect; I: integer);
var
  temp: TBitmap;
begin
  DrawRect2(DC, rc, tabbmp, fsd.tab.r, i, fsd.tab.frame,
    fsd.tab.trans, fsd.tab.tile);
end;

procedure TSkinTab.drawCloseBtn(rc: TRect; i: integer);
var
  x, y, bw: integer;
  Acanvas: TCanvas;
begin
  bw := 6;
  x := rc.Right - bw - 2;
  y := rc.Top + 2;
  acanvas := Drawtemp.Canvas;
    //acanvas.Pen.Color:=fsd.colors[csButtonShadow] ;

  ACanvas.MoveTo(X, Y);
  ACanvas.LineTo(X + bw, Y);
  ACanvas.LineTo(X + bw, Y + bw);
  ACanvas.LineTo(X, Y + bw);
  ACanvas.LineTo(X, Y);
  ACanvas.LineTo(X + bw, Y + bw);

  ACanvas.MoveTo(X + bw, Y);
  ACanvas.LineTo(X, Y + bw);
  closerect[i] := rect(x, y, x + bw, y + bw);
end;

constructor TSkinTab31.Create(AOwner: TComponent);
begin
  inherited create(aowner);
  tabbmp := Tbitmap.create;
end;

destructor TSkinTab31.Destroy;
begin
  tabbmp.free;
  inherited destroy;
end;

type
  TAcTabset = class(TTabset);

procedure TSkinTab31.Init(sf: Tcomponent; sd: TSkinData; acanvas: TCanvas; acolor: boolean = false);
begin
  control := Twincontrol(owner);
  hwnd := control.handle;
  inherited inithwnd(hwnd, sd, acanvas, sf);
  inittab;
  if control.Components[0] is Tscroller then begin
    scroller := TwinControl(control.Components[0]);
    updown := Tskinupdown.create(self.owner);
    updown.dir := 1;
    updown.inithwnd(scroller.handle, sd, acanvas, skinform);
  end;
end;

function TSkinTab31.BeforeProc(var Message: TMessage): boolean;
var
  r: Trect;
begin
  result := true;
  case message.msg of
    WM_ERASEBKGND: begin
//          GetClientRect(hwnd,r);
//          FillRect( message.wparam,r,fsd.BGbrush);
        message.result := 1;
        result := false;
      end;
    WM_Paint: begin
        wmpaint(message);
          //result:=false;
      end;
  else result := inherited BeforeProc(message);
  end;
end;

procedure TSkinTab31.inittab;
begin
//   tabbmp.assign(nil);
  if (fsd.tab <> nil) and (not fsd.tab.map.empty) then begin
//     tabbmp.assign(fsd.tab.map);
    CopyBMP(fsd.tab.Map, tabbmp);
    SpiegelnVertikal(tabbmp);
  end;
end;

procedure TSkinTab31.SkinChange;
begin
  inherited skinchange;
  inittab;
end;

procedure TSkinTab31.DrawControl(dc: HDC; rc: TRect);
const
  EdgeWidth = 9;                        { This controls the angle of the tab edges }
var
  i, j, n, m, start, stop, w: integer;
  rt, r1: Trect;
  drawtemp: Tbitmap;
  tabset: TAcTabset;
begin
  if (fsd.tab = nil) or (fsd.tab.map.empty) then exit;

  drawtemp := Tbitmap.create;
  tabset := TACTabset(control);
  rt := rc;
  offsetrect(rt, -rt.left, -rt.Top);
  Drawtemp.width := rt.right;
  Drawtemp.height := rt.Bottom;

  fillbg(Drawtemp.canvas.handle, rt);
  Drawtemp.canvas.Font := tabset.canvas.font;

  m := tabset.tabs.count;
  n := tabset.tabindex;
  start := tabset.startmargin;
  stop := rt.right - tabset.endmargin;
  for i := tabset.FirstIndex to m - 1 do begin
    if i <> n then j := 1 else j := 2;
    w := drawtemp.canvas.TextWidth(tabset.Tabs[i]);
    w := w + EdgeWidth;
    if (Scroller.visible and ((start + 12 + w) <= stop)) or
      (not Scroller.visible and ((Start + w) <= Stop)) then begin
      r1 := rect(start, 0, start + w, rt.bottom);
      DrawRect2(drawtemp.canvas.handle, r1, tabbmp, fsd.tab.r, j, fsd.tab.frame,
        fsd.tab.trans, fsd.tab.tile);

      if (j = 1) then
        SetTextColor(Drawtemp.canvas.handle, fsd.tab.normalcolor2);
      if (j = 2) then
        SetTextColor(Drawtemp.canvas.handle, fsd.tab.overcolor2);

      DrawCaption(drawtemp.canvas, r1, tabset.Tabs[i], true, true);
      inc(start, w);                    { add to list }
    end;
  end;

//   if FindScroll then begin
//         clipUpdown(dc,r2);
//   end else begin
  BitBlt(dc, rc.left, rc.top, rc.right - rc.top, rc.bottom - rc.top,
    drawtemp.Canvas.Handle, 0, 0, SrcCopy);
//   end;
  drawtemp.free;
end;

function TSkinCheckBox.BeforeProc(var Message: TMessage): boolean;
begin
  result := inherited beforeProc(message);
  case message.msg of
    wm_paint, wm_print:
      if kind = 1 then begin
        wmpaint(message);
        result := false;
      end;
    WM_ERASEBKGND:
      if trans then begin
        WMERASEBKGND(message);
        message.Result := 1;
        result := false;
      end;
  end;
end;

procedure TSkinCheckBox.AfterProc(var Message: TMessage);
begin
  case message.msg of
    WM_LBUTTONDOWN, WM_LBUTTONDBLCLK:
      Invalidate;
    BM_SETCHECK: begin
        state := message.WParam + 1;
        Invalidate;
      end;
    WM_LBUTTONUP: Invalidate;
    CM_BASE + 208: Invalidate;          //LMD control CM_LMDAFTEREXIT
//    WM_USER+1011 :Invalidate;
    //CM_MOUSELEAVE,CM_MOUSEENTER: Invalidate;
    CM_EXIT: Invalidate;                //TMS Control
//    WM_ERASEBKGND: if kind=0 then WMERASEBKGND(message);
  else inherited AfterProc(message);
  end;
end;

procedure TSkinCheckBox.Init(sf: Tcomponent; sd: TSkinData; acanvas: TCanvas; acolor: boolean = false);
var
  s: string;
begin
  inherited init(sf, sd, acanvas, acolor);
  state := 0;
  kind := 0;
  if control = nil then exit;

  if (fsd.Button = nil) or (fsd.button.checkmap.empty) then
    kind := 0
  else kind := 1;

  if (control.Tag = 5555) or (xoTransparent in fsd.options) then
    trans := true;
end;

procedure TSkinCheckBox.DrawControl(dc: HDC; rc: TRect);
var
  cs, n, i, w, bs, w1, j, h: integer;
  oldmode: integer;
  dw: Dword;
  r, r1, r2: Trect;
  PropInfo: PPropInfo;
  s: string;
  cState: TCheckBoxState;
  bfont, cfont: Hfont;
  oldc: COLORREF;
begin
  if (fsd.Button = nil) or (fsd.button.checkmap.empty) then begin
    kind := 0;
//      if control<>nil then control.Invalidate;
    exit;
  end;

  n := fsd.button.checkframe;
  w := fsd.button.checkmap.width div n;
  cs := fsd.button.checkmap.height;
   //w1:=GetSystemMetrics(SM_CXMENUCHECK);
  if w < 15 then w1 := w
  else w1 := w;
//   w1:=15;
  bs := sendmessage(hwnd, BM_GETSTATE, 0, 0);

  i := 1;
  if (bs and BST_CHECKED) = BST_CHECKED then i := 2;
//   else if (bs and BST_UNCHECKED)=BST_UNCHECKED then i:=1;

  if (control <> nil) then begin
    PropInfo := GetPropInfo(control, 'State');
    if PropInfo <> nil then begin
      s := lowercase(GetEnumProp(control, PropInfo));
      if pos('uncheck', s) > 0 then i := 1
      else if pos('check', s) > 0 then i := 2
      else if pos('gray', s) > 0 then i := 4;
    end else begin
      PropInfo := GetPropInfo(control, 'Checked');
      if PropInfo <> nil then begin
        s := lowercase(GetEnumProp(control, PropInfo));
        if s = 'true' then i := 2
        else i := 3;
      end;
    end;
    PropInfo := GetPropInfo(control, 'DataField');
    if (PropInfo <> nil) and (state <> 0) then begin
      i := state;
      if state = 3 then i := 4
    end;
    PropInfo := GetPropInfo(control, 'DataBinding');
    if (PropInfo <> nil) then begin
      i := 1;
    end;
  end;

  dw := GetWindowLong(hWnd, GWL_STYLE);
  if ((dw and WS_DISABLED) > 0) then i := i + 2;
  if (bs and BST_INDETERMINATE) = BST_INDETERMINATE then i := 4;

  if n = 12 then begin
    j := i;
    case j of
      2: i := 5;
      3: i := 4;
      4: i := 8;
    end;
    if (bs and BST_INDETERMINATE) = BST_INDETERMINATE then begin
      if ((dw and WS_DISABLED) > 0) then i := 12
      else i := 9;
    end;
  end;

  r.top := rc.top + (rc.bottom - rc.top - cs) div 2;
  r.bottom := r.top + cs;
  r1 := rc;
  r2 := rc;
  if (dw and BS_LEFTTEXT) = 0 then begin
//     if w>14 then r.left:=rc.left +2
//     else r.left:=rc.left+(14-w) div 2 +1;
    r.left := rc.left;
    r.right := r.left + w1;
     //r1.Right:=r1.Left+w1+1;
    r2.Left := r.Right + 2;
    dw := DT_Left;
    if (control <> nil) and (control.BiDiMode = bdRighttoLeft) then
      dw := dw or dt_RtlReading;
  end else begin
     //if w>15 then r.right:=rc.right-1
     //else r.right:=rc.right-(15-w) div 2;
    r.right := rc.right;
    r.left := r.right - w1;
//     r1.left:=r1.right-w1-3;
    r2.Right := r.Left - 2;
    if (control <> nil) and (control.BiDiMode = bdRightToLeft) then
      dw := DT_Right or dt_RtlReading
    else dw := DT_Left;
  end;
  dw := dw or DT_EXPANDTABS or dt_WordBreak;

  if (kind = 1) and (not trans) then begin
    fillBG(dc, rc);
  end;

  DrawSkinMap2(dc, r, fsd.button.checkmap, i, N);

  if kind = 0 then exit;

  caption := getformcaption(hwnd);
  if (control <> nil) then begin
    caption := GetStringProp(control, 'Caption');
  end else
    caption := getformcaption(hwnd);


  bfont := sendmessage(hwnd, wm_getfont, 0, 0);
  if (control <> nil) then begin
    bfont := Taccontrol(control).font.Handle;
    if control.Enabled then
      oldc := settextcolor(dc, ColorToRGB(Taccontrol(control).font.Color))
    else
      oldc := SetTextColor(dc, ColorToRGB(clBtnShadow));
  end;
  cfont := selectobject(dc, bfont);
  oldcolor := setbkcolor(dc, fsd.colors[csButtonFace]);
  OldMode := SetBkMode(dc, TRANSPARENT);

//   h:=TextHeight(dc,'0');
//   offsetrect(r2,0, (r2.Bottom-r2.Top-h) div 2);
  r1 := r2;
  Tnt_DrawTextW(dc, caption, r1, dw or DT_CALCRECT or DT_NOCLIP);
  offsetrect(r2, 0, (r2.Bottom - r2.Top - r1.bottom) div 2);

//   if not control.Enabled then
  if (GetFocus = hWnd) and (length(caption) > 0) and isvista then
    DrawFocus(dc, caption, r2, dw);
  Tnt_DrawTextW(dc, caption, r2, dw);
  SetBkMode(dc, OldMode);
  SetTextColor(dc, oldc);
  setbkcolor(dc, oldcolor);
  selectobject(dc, cfont);

end;

procedure TSkinRadioButton.Init(sf: Tcomponent; sd: TSkinData; acanvas: TCanvas; acolor: boolean = false);
var
  s: string;
begin
  inherited init(sf, sd, acanvas, acolor);
  kind := 0;
  if control = nil then exit;
  if (fsd.Button = nil) or (fsd.button.radiomap.empty) then
    kind := 0
  else kind := 1;
  if (control.Tag = 5555) or (xoTransparent in fsd.options) then
    trans := true;
end;

procedure TSkinRadioButton.AfterProc(var Message: TMessage);
begin
  case message.msg of
    WM_LBUTTONDOWN, WM_LBUTTONDBLCLK: Invalidate;
    WM_LBUTTONUP: Invalidate;
    BM_SETCHECK: Invalidate;
    CM_BASE + 208: Invalidate;          //LMD control CM_LMDAFTEREXIT
    CM_EXIT:
      Invalidate;                       //TMS Control
//    WM_ERASEBKGND:
//      if kind=0 then WMERASEBKGND(message);
  else inherited AfterProc(message);
  end;
end;

function TSkinRadioButton.BeforeProc(var Message: TMessage): boolean;
begin
  result := inherited beforeProc(message);
  case message.msg of
    wm_paint, wm_print:                 // begin
      if kind = 1 then begin
        wmpaint(message);
        result := false;
      end;
    WM_ERASEBKGND:
      if trans then begin
        WMERASEBKGND(message);
        message.Result := 1;
        result := false;
      end;
//    else inherited beforeProc(message);
  end;
end;

procedure TSkinRadioButton.DrawControl(dc: HDC; rc: TRect);
var
  cs, n, i, w, w1, j, h: integer;
  oldmode: integer;
  r, r1, r2: Trect;
  bs: integer;
  dw: Dword;
  PropInfo: PPropInfo;
  s: string;
  bfont, cfont: Hfont;
  oldc: COLORREF;
begin
  if (fsd.Button = nil) or (fsd.button.radiomap.empty) then begin
    kind := 0;
//      if control<>nil then control.Invalidate;
    exit;
  end;

  n := fsd.button.radioframe;
  w := fsd.button.radiomap.width div n;
  cs := fsd.button.radiomap.height;
   //w1:=GetSystemMetrics(SM_CXMENUCHECK);
  if w < 15 then w1 := w
  else w1 := w;

  i := 1;
  bs := sendmessage(hwnd, BM_GETCHECK, 0, 0);
  if (bs and BST_CHECKED) = BST_CHECKED then i := 2
  else if (bs and BST_UNCHECKED) = BST_UNCHECKED then i := 1;

  r1 := rc;
  if control <> nil then begin
    PropInfo := GetPropInfo(control, 'Checked');
    if PropInfo <> nil then begin
      s := lowercase(GetEnumProp(control, PropInfo));
      if s = 'true' then i := 2
      else i := 1;
    end;
  end;

  dw := GetWindowLong(hWnd, GWL_STYLE);
  if (dw and WS_DISABLED) > 0 then i := i + 2;

  if n = 8 then begin
    j := i;
    case j of
      2: i := 5;
      3: i := 4;
      4: i := 8;
    end;
  end;

  r.top := rc.top + (rc.bottom - rc.top - cs) div 2;
  r.bottom := r.top + cs;
  r2 := rc;
  if (dw and BS_LEFTTEXT) = 0 then begin
     {if w>14 then r.left:=rc.left
     else r.left:=rc.left+(14-w) div 2;}
    r.Left := rc.Left;
    r.right := r.left + w1;
     //r1.right:=r1.left+w1+1;
    dw := DT_Left;
    r2.Left := r.Right + 2;
    if (control <> nil) and (control.BiDiMode = bdRightToLeft) then
      dw := dw or dt_RtlReading;
  end else begin
     {if w>14 then r.right:=rc.right-1
     else r.right:=rc.right-(14-w) div 2;}
    r.Right := rc.Right - 1;
    r.left := r.right - w1;
     //r1.left:=r1.right-w1-3;
    if (control <> nil) and (control.BiDiMode = bdRightToLeft) then
      dw := DT_Right or dt_RtlReading
    else dw := DT_Left;

     {if control.BiDiMode = bdLeftToRight then
       dw := DT_Left
     else dw := DT_Right or dt_RtlReading;}
    r2.Right := r.left - 2;
  end;
  dw := dw or DT_EXPANDTABS or dt_WordBreak;

  if (kind = 1) and (not trans) then begin
    fillBG(dc, rc);
  end;

  DrawSkinMap2(dc, r, fsd.button.radiomap, i, N);

  if kind = 0 then exit;

  caption := getformcaption(hwnd);
  if (control <> nil) then begin
    caption := GetStringProp(control, 'Caption');
  end;

  bfont := sendmessage(hwnd, wm_getfont, 0, 0);
  if (control <> nil) then begin
    bfont := Taccontrol(control).font.Handle;
    if control.Enabled then
      oldc := settextcolor(dc, ColorToRGB(Taccontrol(control).font.Color))
    else
      oldc := SetTextColor(dc, ColorToRGB(clBtnShadow));
  end;
  cfont := selectobject(dc, bfont);
  oldcolor := setbkcolor(dc, fsd.colors[csButtonFace]);
  OldMode := SetBkMode(dc, TRANSPARENT);

  r1 := r2;
  Tnt_DrawTextW(dc, caption, r1, dw or DT_CALCRECT or DT_NOCLIP);
  offsetrect(r2, 0, (r2.Bottom - r2.Top - r1.bottom) div 2);

  if (GetFocus = hWnd) and (length(caption) > 0) and isvista then
    DrawFocus(dc, caption, r2, dw);
  Tnt_DrawTextW(dc, caption, r2, dw);
  SetBkMode(dc, oldmode);
  SetTextColor(dc, oldc);
  setbkcolor(dc, oldcolor);
  selectobject(dc, cfont);
end;

procedure TSkinTrackBar.Init(sf: Tcomponent; sd: TSkinData; acanvas: TCanvas; acolor: boolean = false);
begin
  inherited Init(sf, sd, acanvas, acolor);
    //caused pagecontrol flicker
    //    skinchange;
end;

procedure TSkinTrackBar.Skinchange;
var
  h: Thandle;
begin
  h := setfocus(hwnd);
  if h <> hwnd then setfocus(h);
end;

procedure TSkinTrackBar.Unsubclass;
begin
  inherited unsubclass;
//   skinchange;
end;

function TSkinTrackBar.BeforeProc(var Message: TMessage): boolean;
begin
  result := true;
  case message.msg of
      {WM_ERASEBKGND: begin
          message.result:=1;
          result:=false;
      end;   }
    WM_Notify, CN_NOTIFY: begin
        if TWMNotify(message).NMHdr^.code = NM_CUSTOMDRAW then begin
          message.Result := CustomDraw(PNMCustomDraw(message.lParam));
          result := false;
        end;
      end;
  else result := inherited BeforeProc(message);
  end;
end;

function TSkinTrackBar.CustomDraw(PDraw: PNMCustomDraw): integer;
var
  r: Trect;
begin
  case Pdraw^.dwDrawStage of
      {CDDS_POSTERASE:begin
            GetClientRect(hwnd,r);
            fillBG(pdraw^.hdc,r);
            result:=CDRF_SKIPDEFAULT;
          end; }
    CDDS_PREPAINT:
      result := CDRF_NOTIFYITEMDRAW;
    CDDS_ITEMPREPAINT: begin
        case Pdraw^.dwItemSpec of
          TBCD_TICS: result := CDRF_DODEFAULT;
          TBCD_THUMB: begin
              Drawthumb(pdraw);
              result := CDRF_SKIPDEFAULT; // CDRF_DODEFAULT;
            end;
          TBCD_CHANNEL: begin
              DrawTrack(pdraw);
              result := CDRF_SKIPDEFAULT; //CDRF_DODEFAULT;
            end;
        end;
      end;
  end;
end;

procedure TSkinTrackBar.DrawTrack(PDraw: PNMCustomDraw);
var
  r, dst, src: TRect;
  bmp: Tbitmap;
  w, h, x, y: integer;
  dwstyle: dword;
  dc: HDC;
begin
  sendmessage(hwnd, TBM_GETCHANNELRECT, 0, integer(@r));
  dwstyle := GetWindowLong(hWnd, GWL_STYLE);
  dc := pdraw^.hdc;

  if ((dwstyle and TBS_VERT) > 0) and (fsd.trackbarvert <> nil) then begin
    dst := rect(r.top, r.Left, r.Bottom, r.Right);
    src := fsd.TrackBarVert.r;
    bmp := fsd.TrackBarVert.map;
    w := bmp.Width;
    h := bmp.Height;
    if bmp.Width < (dst.Right - dst.Left) then
      x := (dst.Right - dst.Left - bmp.Width) div 2
    else x := 0;
//        DrawRectV(pdraw^.hdc,r,fsd.TrackBarVert.map,fsd.TrackBarVert.r,1,1);
    StretchBlt(dc, dst.Left + x, dst.Top, w, src.Top,
      bmp.canvas.handle, 0, 0, w, src.Top, SRCCOPY);
    StretchBlt(dc, dst.Left + x, dst.Top + src.Top, w, dst.Bottom - dst.Top - src.Top - src.Bottom,
      bmp.canvas.handle, 0, src.Top, w, h - src.Top - src.Bottom, SRCCOPY);
    StretchBlt(dc, dst.Left + x, dst.Bottom - src.Bottom, w, src.Bottom,
      bmp.canvas.handle, 0, y + h - src.Bottom, w, src.Bottom, SRCCOPY);
  end else if (fsd.trackbar <> nil) then begin
    dst := r;
    src := fsd.TrackBar.r;
    bmp := fsd.TrackBar.map;
    w := bmp.Width;
    h := bmp.Height;
    if h < (dst.bottom - dst.top) then
      y := (dst.bottom - dst.top) div 2
    else y := 0;

        //DrawRectH(pdraw^.hdc,r,fsd.TrackBar.map,fsd.TrackBar.r,1,1);
    StretchBlt(dc, dst.Left, dst.Top + y, src.Left, h,
      bmp.canvas.handle, 0, 0, src.Left, h, SRCCOPY);
    StretchBlt(dc, dst.Left + src.Left, dst.Top + y, dst.Right - dst.Left - src.Left - src.Right, h,
      bmp.canvas.handle, src.Left, 0, w - src.Left - src.Right, h, SRCCOPY);
    StretchBlt(dc, dst.Right - src.Right, dst.Top + y, src.Right, h,
      bmp.canvas.handle, w - src.Right, 0, src.Right, h, SRCCOPY);
  end;
end;

{procedure TSkinTrackBar.Drawthumb(PDraw:PNMCustomDraw);
var r:TRect;
    temp:Tbitmap;
    w,h,x:integer;
    adc:HDC;
begin
   sendmessage(hwnd,TBM_GETTHUMBRECT,0,integer(@r));
    temp:=Tbitmap.create;
    w:=bmp.width div n;
    h:=bmp.height;
    temp.height:=rc.bottom-rc.top;
    temp.width:=rc.right-rc.left;
    x:=(i-1)*w;
    temp.canvas.copyrect( rect(0,0,rc.right-rc.left,rc.bottom-rc.top),
             bmp.canvas,rect(x,0,x+w,h));
    adc:= fcanvas.handle;
    fcanvas.handle:=dc;

    temp.Transparent:=true;
    temp.Transparentcolor:=clFuchsia;
//    temp.Transparentcolor:=temp.Canvas.Pixels[0, 0];

    fcanvas.draw(rc.left,rc.top,temp);

    temp.free;
    fcanvas.handle:=adc;
end;  }

procedure TSkinTrackBar.Drawthumb(PDraw: PNMCustomDraw);
var
  r: TRect;
  acolor: Tcolor;
  temp: Tbitmap;
  dwstyle: dword;
  ftemp: Tcanvas;
begin
  if (not IsWindow(hwnd)) then begin
    exit;
    if control <> nil then
      hwnd := control.handle
    else Exit;
  end;
  dwstyle := GetWindowLong(hWnd, GWL_STYLE);
  sendmessage(hwnd, TBM_GETTHUMBRECT, 0, integer(@r));
  temp := nil;
  if ((dwstyle and TBS_VERT) > 0) and (fsd.trackvert <> nil) then
    temp := fsd.TrackVert.Map
  else if (fsd.trackhorz <> nil) then
    temp := fsd.TrackHorz.Map;

  if temp <> nil then begin
    DrawSkinMap1(pdraw^.hdc, r, temp, 2, 5)
  end else begin
    ftemp := Tcanvas.create;
    ftemp.Handle := pdraw^.hdc;
    ftemp.pen.color := fsd.colors[csButtonShadow];
    ftemp.Rectangle(r);
    ftemp.free;
  end;
end;

procedure TSkinToolbar.Init(sf: Tcomponent; sd: TSkinData; acanvas: TCanvas; acolor: boolean = false);
var
  c0: Tcolor;
begin
  inherited init(sf, sd, acanvas, acolor);
  c0 := fsd.GetCaptionColor();
  gradCol1 := Blend(clgray, c0, 150);
  gradCol2 := Blend(fsd.colors[csButtonFace], clwhite, 150);
end;

function TSkinToolbar.BeforeProc(var Message: TMessage): boolean;
begin
  result := true;
  case message.msg of
    WM_ERASEBKGND: begin
        ERASEBKGND(message);
        message.result := 1;
        result := false;
      end;
    WM_Notify, CN_NOTIFY: begin
        { if TWMNotify(message).NMHdr^.code=NM_CUSTOMDRAW then begin
            message.Result:=CustomDraw(PNMCustomDraw(message.lParam));
            result:=false;
         end; }
      end;
  else result := inherited BeforeProc(message);
  end;
end;

procedure TSkinToolbar.ERASEBKGND(msg: Tmessage);
var
  Brush: HBrush;
  r: Trect;
  old: integer;
begin
  GetClientRect(hwnd, r);
  if fsd.Toolbar <> nil then begin
    old := SetStretchBltMode(msg.WParam, STRETCH_DELETESCANS);
    StretchBlt(msg.WParam, r.left, r.top, r.right - r.left, r.bottom - r.top,
      fsd.Toolbar.map.canvas.handle, 0, 0, fsd.Toolbar.map.Width, fsd.Toolbar.map.Height, SRCCOPY);
    SetStretchBltMode(msg.WParam, old);
  end else
    GradFill(msg.WParam, r, gradCol2, gradCol1);
end;


procedure TSkinUpDown.DrawBackGround(msg: Tmessage);
var
  Brush: HBrush;
  r: Trect;
begin
  if control = nil then begin
    GetClientRect(hwnd, r);
    Brush := CreateSolidBrush(clwhite);
    fillrect(msg.wparam, r, brush);
    DeleteObject(Brush);
  end;
end;

function TSkinUpDown.BeforeProc(var Message: TMessage): boolean;
begin
  result := true;
  case message.msg of
    WM_LBUTTONDOWN, WM_LBUTTONDBLCLK: begin
        default(message);
        state := state + [scDown];
        PaintControl;
        result := false;
      end;

    WM_LBUTTONUP: begin
        state := state - [scDown];
        default(message);
        PaintControl;
        result := false;
      end;

    WM_ERASEBKGND: begin
        DrawBackGround(message);
        message.result := 1;
        result := false;
      end;
    WM_Paint: begin
        wmpaint(message);
        result := false;
      end;
  else result := inherited BeforeProc(message);
  end;
end;

function TSkinProgress.BeforeProc(var Message: TMessage): boolean;
begin
{$IFDEF progress}
  result := true;
  case message.msg of
    WM_ERASEBKGND: begin
        message.result := 1;
        result := false;
      end;
    WM_Paint: begin
        if (fsd.Progress <> nil) and (not fsd.progress.map.empty) then begin
          wmpaint(message);
          message.result := 0;
          result := false;
        end;
      end;
  else result := inherited BeforeProc(message);
  end;
{$ELSE}
  result := inherited BeforeProc(message);
{$ENDIF}
end;

procedure TSkinUpDown.DrawControl(dc: HDC; rc: TRect);
var
  r, r1, r2: Trect;
  p: TPoint;
  h, i, l: integer;
  temp: Tbitmap;
  dwstyle: dword;
  b: boolean;
  Brush: HBrush;
  phwnd: Thandle;
begin
    //getclientrect(hwnd,r1);
  if inedit then begin
        //GetWindowRect(hwnd,r);
        //offsetrect(r,-r.Left,-r.Right);
    getclientrect(hwnd, r);
    Brush := CreateSolidBrush(clwhite);
    fillrect(dc, r, brush);
    DeleteObject(Brush);
//        InflateRect(rc,-1,-1);
    phwnd := getparent(hwnd);
    getwindowrect(phwnd, r2);
    getwindowrect(hwnd, r1);
    if (r1.Top - r2.Top) < 3 then inc(rc.Top, 3 - (r1.Top - r2.Top));
    if (r2.Bottom - r1.Bottom) < 3 then dec(rc.Bottom, 3 - (r2.Bottom - r1.Bottom));
    if (r2.right - r1.Right) < 3 then dec(rc.Right, 3 - (r2.right - r1.Right));
  end;
  r1 := rc;
  offsetrect(r1, -r1.Left, -r1.Top);
  r2 := r1;
  temp := Tbitmap.create;
  temp.width := r1.right;
  temp.height := r1.bottom;
  temp.canvas.brush.color := fsd.colors[csButtonFace];
  temp.canvas.fillrect(rect(0, 0, r1.right, r1.bottom));

  GetCursorPos(p);
  ScreenToClient(hwnd, p);
  dwstyle := GetWindowLong(hWnd, GWL_STYLE);
  enabled := (dwstyle and WS_DISABLED) = 0;

  i := 1;
  b := (dwstyle and UDS_HORZ) = 0;
  if dir = 1 then b := false;

  if b then begin                       //vert
    h := (r1.Bottom - r1.Top) div 2;
    if (p.Y < H) then begin
      if (scDown in state) then i := 2
      else if (scMouseIn in state) then i := 4;
    end;
    if not enabled then i := 3;
    r := rect(r1.left, r1.top, r1.right, r1.top + h);
//      b:=(fsd.VSpin<>nil) and (not fsd.VSpin.MaskMap.empty);
    b := (fsd.VSpin <> nil);
    if b then
      DrawSkinButton(temp.canvas.handle, r, i, 0)
    else
      DrawButton(temp.canvas, r, i, 0);

    i := 1;
    if (p.Y >= H) then begin
      if (scDown in state) then i := 2
      else if (scMouseIn in state) then i := 4;
    end;
    if not enabled then i := 3;

    r := rect(r1.left, r1.top + h, r1.right, r1.bottom);
    if b then
      DrawSkinButton(temp.canvas.handle, r, i, 1)
    else
      DrawButton(temp.canvas, r, i, 1);
  end else begin
    h := (r1.right - r1.left) div 2;
    if (p.x < H) then begin
      if (scDown in state) then i := 2
      else if (scMouseIn in state) then i := 4;
    end;
    if not enabled then i := 3;
    r := rect(r1.left, r1.top, r1.left + h, r1.bottom);
//      b:=(fsd.HSpin<>nil) and (not fsd.HSpin.MaskMap.empty);
    b := (fsd.HSpin <> nil);
    if b then
      DrawSkinButton(temp.canvas.handle, r, i, 2)
    else
      DrawButton(temp.canvas, r, i, 2);

    i := 1;
    if (p.x >= H) then begin
      if (scDown in state) then i := 2
      else if (scMouseIn in state) then i := 4;
    end;
    if not enabled then i := 3;

    r := rect(r1.left + h, r1.top, r1.right, r1.bottom);
    if b then DrawSkinButton(temp.canvas.handle, r, i, 3)
    else
      DrawButton(temp.canvas, r, i, 3);
  end;

  BitBlt(dc, rc.left, rc.top, r1.right, r1.bottom,
    temp.Canvas.Handle, 0, 0, SrcCopy);
  temp.free;
end;

procedure TSkinUpDown.DrawSkinButton(dc: HDC; rc: TRect; n, ar: integer);
var
  i, w, h: integer;
  r1: Trect;
begin
  if ar > 1 then begin
    i := (ar - 2) * 4 + n;
    DrawRect1(dc, rc, fsd.HSpin.map, i, fsd.HSpin.frame, 1);
    if not fsd.HSpin.MaskMap.empty then begin
      w := fsd.HSpin.MaskMap.Width div fsd.HSpin.frame;
      r1.Left := rc.left + (rc.Right - rc.Left - w) div 2;
      r1.Top := rc.Top + (rc.Bottom - rc.Top - fsd.HSpin.MaskMap.height) div 2;
      r1.right := r1.left + w;
      r1.Bottom := r1.Top + fsd.HSpin.MaskMap.height;
      DrawRect1(dc, r1, fsd.HSpin.maskmap, i, fsd.HSpin.frame, 1);
    end;
  end else begin
    i := ar * 4 + n;
//     DrawSkinMap2( dc,rc,fsd.VSpin.map,i,fsd.VSpin.frame);
    DrawRect1(DC, rc, fsd.VSpin.map, i, fsd.VSpin.frame, 1);
    if not fsd.VSpin.MaskMap.empty then begin
      w := fsd.VSpin.MaskMap.Width div fsd.VSpin.frame;
//       if
      r1.Left := rc.left + (rc.Right - rc.Left - w) div 2;
      r1.Top := rc.Top + (rc.Bottom - rc.Top - fsd.VSpin.MaskMap.height) div 2;
      r1.right := r1.left + w;
      r1.Bottom := r1.Top + fsd.VSpin.MaskMap.height;
      DrawRect1(dc, r1, fsd.VSpin.maskmap, i, fsd.VSpin.frame, 1);
    end;
  end;
end;

procedure TSkinUpDown.DrawButton(acanvas: Tcanvas; rc: TRect; n, ar: integer);
var
  hb, ob: Hbrush;
  adc: HDC;
begin
  case n of
    1: acanvas.brush.color := fsd.colors[csButtonFace];
    2: acanvas.brush.color := fsd.colors[csButtonShadow];
    3: acanvas.brush.color := fsd.colors[csButtonFace];
    4: acanvas.brush.color := fsd.colors[csButtonShadow];
  end;
  acanvas.pen.color := fsd.colors[csButtonDkshadow];

  acanvas.Rectangle(rc);
  if ar < 2 then
    DrawArrow(acanvas, rc.Left + ((rc.Right - rc.Left) div 2),
      rc.Top + ((rc.Bottom - rc.Top) div 2) - 2, ar)
  else
    DrawArrow(acanvas, rc.Left + ((rc.Right - rc.Left) div 2),
      rc.Top + ((rc.Bottom - rc.Top) div 2), ar)
end;

procedure TSkinProgress.DrawControl(dc: HDC; rc: TRect);
var
  r, r1: Trect;
  pbmp, temp: TBitMap;
//    bmax,bpos:Int64;
  bmax, bpos, bmin: Integer;
  style: dword;
begin
  if (fsd.Progress = nil) or fsd.progress.map.empty then exit;
  style := GetWindowLong(hWnd, GWL_STYLE);
  if (fsd.Progress.style = 1) then begin
    DrawControl1(dc, rc);
    exit;
  end;
  pbmp := Tbitmap.create;
  pbmp.PixelFormat := pf24bit;
//   fcanvas.handle:=dc;
  r1 := rc;
  if (style and PBS_VERTICAL) > 0 then
    r1 := Rect(0, 0, rc.bottom - rc.top, rc.right - rc.left);


  pbmp.width := r1.right;
  pbmp.height := r1.bottom;
  pbmp.canvas.brush.color := fsd.colors[csButtonFace];
  pbmp.canvas.fillrect(r1);

  temp := GetHMap(r1, fsd.Progress.map, fsd.Progress.r, 1, 2, fsd.Progress.tile);
  temp.Transparent := true;
  temp.Transparentcolor := clFuchsia;

  pbmp.canvas.draw(r1.left, r1.top, temp);
  temp.free;

  bpos := sendmessage(hwnd, PBM_GETPOS, 0, 0);
  bmax := sendmessage(hwnd, PBM_GETRANGE, 0, 0);
  bmin := sendmessage(hwnd, PBM_GETRANGE, 1, 0);
  if (bmax > 0) and (bpos > 0) then begin
    r := r1;
//     r.right:= r1.left+round((r1.right-r1.left)/bmax*bpos);
    r.right := r1.left + MulDiv((r1.right - r1.left), (bpos - bmin), (bmax - bmin));
    if (r.right > r.left) then begin
      temp := GetHMap(r, fsd.Progress.map, fsd.Progress.r, 2, 2, fsd.Progress.tile);
      temp.Transparent := true;
      temp.Transparentcolor := clFuchsia;
      pbmp.canvas.draw(r1.left, r1.top, temp);
      temp.free;
    end;
  end;

  if (style and PBS_VERTICAL) > 0 then
    Drehen270Grad(pbmp);

//   temp
  BitBlt(dc, rc.left, rc.top, rc.right - rc.left, rc.bottom - rc.Top,
    pbmp.Canvas.Handle, 0, 0, Srccopy);

  pbmp.Free;
end;

{procedure TSkinProgress.DrawControl( dc:HDC; rc:TRect);
var r,r1:Trect;
    pbmp,temp:TBitMap;
    bmax,bpos:integer;

begin
   if (fsd.Progress=nil) or fsd.progress.map.empty then exit;
   if  (fsd.Progress.style=1) then begin
       DrawControl1( dc,rc);
       exit;
   end;

   r:=rc;
//   fcanvas.handle:=dc;
   r1:=rc;
   bg.width:=r1.right;
   bg.height:=r1.bottom;
   bg.canvas.brush.color:=fsd.colors[csButtonFace];
   bg.canvas.fillrect(r1);

   temp:=GetHMap(rc,fsd.Progress.map,fsd.Progress.r,1,2,fsd.Progress.tile);
   temp.Transparent:=true;
   temp.Transparentcolor:=clFuchsia;

   bg.canvas.draw(rc.left,rc.top,temp);
   temp.free;

   bpos:=sendmessage(hwnd,PBM_GETPOS,0,0);
   bmax:=sendmessage(hwnd,PBM_GETRANGE,0,0);

   if (bmax>0) and (bpos>0) then begin
     r.right:= rc.left+(rc.right-rc.left)*bpos div bmax;

     temp:=GetHMap(r,fsd.Progress.map,fsd.Progress.r,2,2,fsd.Progress.tile);
     temp.Transparent:=true;
     temp.Transparentcolor:=clFuchsia;

     bg.canvas.draw(rc.left,rc.top,temp);
     temp.free;
   end;

   BitBlt(dc,rc.left ,rc.top,rc.right-rc.left,rc.bottom-rc.Top,
                 bg.Canvas.Handle ,0 ,0 ,Srccopy);
end;}

procedure TSkinProgress.DrawControl1(dc: HDC; rc: TRect);
var
  r, r1: Trect;
  temp, pbmp: TBitMap;
  i, n, w, h, y, bmax, bpos: integer;
  style: dword;
begin
  if (fsd.progressChunk = nil) or fsd.progressChunk.map.empty then exit;

  style := GetWindowLong(hWnd, GWL_STYLE);
  pbmp := Tbitmap.create;
  pbmp.PixelFormat := pf24bit;

//   fcanvas.handle:=dc;
  r1 := rc;

  if (style and PBS_VERTICAL) > 0 then
    r1 := Rect(0, 0, rc.bottom - rc.top, rc.right - rc.left);
  r := r1;

  pbmp.width := r1.right;
  pbmp.height := r1.bottom;
  pbmp.canvas.brush.color := fsd.colors[csButtonFace];
  pbmp.canvas.fillrect(r1);

   //always be strech
  temp := GetHMap(r1, fsd.Progress.map, fsd.Progress.r, 1, 1, 0); //fsd.Progress.tile);
  temp.Transparent := true;
  temp.Transparentcolor := clFuchsia;
  pbmp.canvas.draw(r1.left, r1.top, temp);
//   temp.free; // we use in trunck

  bpos := sendmessage(hwnd, PBM_GETPOS, 0, 0);
  bmax := sendmessage(hwnd, PBM_GETRANGE, 0, 0);

  if (bmax > 0) and (bpos > 0) then begin
//     r.right:= rc.left+(rc.right-rc.left)*bpos div bmax;
    r.right := r1.left + MulDiv((r1.right - r1.left), bpos, bmax);

    h := fsd.progressChunk.map.height;
    w := fsd.progressChunk.map.width;
    y := (r.Bottom - h) div 2;

    if fsd.ProgressChunk.tile = 1 then begin
      temp.Width := r.Right - r.Left;
      temp.Height := h;
      n := (r.Right - r.Left) div w;
      for i := 0 to n do begin
        temp.canvas.draw(i * w, 0, fsd.progressChunk.map);
      end;
      pbmp.canvas.draw(2 + fsd.progressChunk.r.left, rc.top + y, temp);
    end else begin
      temp.width := r.right;
      temp.height := r.bottom - 4;
      drawrectH(temp.Canvas.Handle, r, fsd.progresschunk.Map, fsd.progresschunk.r,
        1, 1, fsd.progresschunk.Tile);
      pbmp.canvas.draw(2, 2, temp);
         //r1:=rect(0,0,fsd.progressChunk.map.width,fsd.progressChunk.map.Height);
         //pbmp.canvas.copyrect(r,fsd.progressChunk.map.canvas,r1);
    end;
  end;
  if (style and PBS_VERTICAL) > 0 then
    Drehen270Grad(pbmp);
  BitBlt(dc, rc.left, rc.top, rc.right - rc.left, rc.bottom - rc.Top,
    pbmp.Canvas.Handle, 0, 0, Srccopy);
  temp.free;
  pbmp.free;

//   fcanvas.handle:=dc;
//   fcanvas.draw(rc.left,rc.top,BG);
end;

{procedure TSkinEdit.Init(aControl:Twincontrol;sd:TSkinData;acanvas:TCanvas;acolor:boolean=false);
begin
   inherited Init(acontrol,sd,acanvas,acolor);
   FindUPDown(hwnd,sd,acanvas);
end;

procedure TSkinEdit.inithwnd(ahwnd:Thandle;sd:TSkinData;acanvas:TCanvas);
begin
   inherited Inithwnd(ahwnd,sd,acanvas);
   FindUPDown(ahwnd,sd,acanvas);
end; }

procedure TSkinEdit.AfterProc(var Message: TMessage);
var
  BEMsg: TMessage;
begin
//inherited AfterProc(message);
//exit;
  case message.msg of
    CM_BEPAINT: begin
        if Message.LParam = BE_ID then begin
          if Message.WParam <> 0 then begin
            BEMsg.Msg := WM_PAINT;
            BEMsg.WParam := Message.WParam;
            BEMsg.LParam := 0;
            Default(BEMsg);
          end;
          Message.Result := BE_ID;
        end;
      end;
    WM_Print:
      PaintControl1(message.WParam);
    WM_Paint: begin
        PaintControl(message.WParam);
      end;
  else inherited AfterProc(message);
  end;
end;

procedure TSkinEdit.FindUPDown(ahwnd: Thandle; sd: TSkinData; acanvas: TCanvas);
var
  hctrl: Thandle;
  s: string;
begin
  hCtrl := GetTopWindow(ahWnd);
  while (hCtrl <> 0) do begin
    s := lowercase(getwindowclassname(hctrl));
    if (s = 'msctls_updown32') or (pos('spin', s) > 0) or (pos('updown', s) > 0) then begin
      updown := Tskinupdown.create(self.owner);
      updown.inithwnd(hCtrl, sd, acanvas, skinform);
      updown.inedit := true;
      break;
    end;
    hCtrl := GetNextWindow(hCtrl, GW_HWNDNEXT);
  end;
end;

{procedure TSkinEdit.DrawControl( dc:HDC; rc:TRect);
var r,r1:Trect;
    acolor:Tcolor;
    s:string;
begin
   if updown=nil then findupdown(hwnd,fsd,fcanvas);
   getclientrect(hwnd,r1);
   r:=rc;
   if (r.right=(r1.right-r1.left)) or
      (r.bottom=(r1.bottom-r1.top)) then exit;
   fcanvas.handle:=dc;
   fcanvas.brush.handle:=GetCurrentObject(dc,OBJ_BRUSH);
   InflateRect(rc,-1,-1);
   fcanvas.FrameRect(rc);
   if updown=nil then begin
     InflateRect(rc,-1,-1);
     fcanvas.FrameRect(rc);
   end;
   acolor:=fcanvas.brush.color;
   fcanvas.brush.color:=fsd.colors[csButtonShadow];
   fcanvas.FrameRect(r);
   fcanvas.brush.color:=acolor;
end;}

procedure TSkinEdit.DrawControl(dc: HDC; rc: TRect);
var
  r, r1: Trect;
  acolor: Tcolor;
  c1: Tcolor;
  b1, b2: HBRUSH;
  s: string;
begin
  if (xcSpin in Fsd.SkinControls) and (updown = nil) then findupdown(hwnd, fsd, fcanvas);
  getclientrect(hwnd, r1);
  r := rc;
  if (r.right = (r1.right - r1.left)) or
    (r.bottom = (r1.bottom - r1.top)) then exit;
  r1 := rc;
  B1 := CreateSolidBrush(fsd.colors[csButtonShadow]);
  FrameRect(dc, r1, b1);

  c1 := clwhite;
  B2 := CreateSolidBrush(c1);
  InflateRect(r1, -1, -1);
  FrameRect(dc, r1, b2);

  InflateRect(r1, -1, -1);
  FrameRect(dc, r1, b2);
//   dec(r1.Bottom);
//   FrameRect(dc,r1,b2);

  deleteobject(B2);
  deleteobject(B1);
end;

procedure TSkinEdit.PaintControl1(adc: HDC = 0);
var
  dc: HDC;
  rc: TRect;
begin
  if GetWindowRect(hWnd, rc) then begin;
    try
      boundsrect := rc;
      OffsetRect(rc, -rc.left, -rc.top);
      if adc = 0 then DC := GetWindowDC(hWnd)
      else dc := adc;
      try
        Drawcontrol1(dc, rc);
      finally
        if adc = 0 then ReleaseDC(hwnd, DC);
      end;
    except
    end;
  end;
end;

procedure TSkinEdit.DrawControl1(dc: HDC; rc: TRect);
var
  r, r1: Trect;
  acolor: Tcolor;
  s: string;
begin
//   if updown=nil then findupdown(hwnd,fsd,fcanvas);
  getclientrect(hwnd, r1);
  r := rc;
{$IFDEF edittest}
  s := format('Edit rect %1x %1d %1d %1d %1d', [hwnd, rc.left, rc.top, rc.right, rc.bottom]);
  skinaddlog(s);
  s := format('Edit Clientrect %1d %1d %1d %1d', [r1.left, r1.top, r1.right, r1.bottom]);
  skinaddlog(s);
{$ENDIF}
  if (r.right <= (r1.right - r1.left + 2)) or
    (r.bottom <= (r1.bottom - r1.top + 2)) then exit;
  fcanvas.handle := dc;
  fcanvas.brush.handle := GetCurrentObject(dc, OBJ_BRUSH);
  InflateRect(rc, -1, -1);
  fcanvas.FrameRect(rc);

  acolor := fcanvas.brush.color;
  fcanvas.brush.color := fsd.colors[csButtonShadow];
  fcanvas.FrameRect(r);
  fcanvas.brush.color := acolor;
  fcanvas.handle := 0;
end;

constructor TSkinCombox.Create(AOwner: TComponent);
begin
  inherited create(aowner);
  isDrop := false;
  HasButton := false;

//   box:=Tskinscrollbar.create(nil);
end;

destructor TSkinCombox.Destroy;
begin
//   box.free;
  if (hbtn <> 0) and (fbtnobjectinst <> nil) then begin
    SetWindowLong(hbtn, GWL_WNDPROC, LongInt(FbtnPrevWndProc));
    FreeObjectInstance(FbtnObjectInst);
    fbtnobjectinst := nil;
    hbtn := 0;
  end;
  if vb <> nil then begin
    vb.free;
    vb := nil;
  end;
  inherited destroy;
end;

procedure TSkinCombox.Unsubclass;
begin
  inherited unsubclass;
  if (hbtn <> 0) and (fbtnobjectinst <> nil) then begin
    SetWindowLong(hbtn, GWL_WNDPROC, LongInt(FbtnPrevWndProc));
    FreeObjectInstance(FbtnObjectInst);
    fbtnobjectinst := nil;
    hbtn := 0;
  end;
  if vb <> nil then begin
    vb.Unsubclass;
    vb.free;
    vb := nil;
  end;
  if db <> nil then begin
    db.Unsubclass;
    db.free;
    db := nil;
  end;
end;

procedure TSkinCombox.FindBtn;
begin
  hbtn := GetTopWindow(hWnd);
  if hbtn <> 0 then begin
    FBtnObjectInst := MakeObjectInstance(ButtonProc);
    FBtnPrevWndProc := Pointer(GetWindowLong(hbtn, GWL_WNDPROC));
    SetWindowLong(hbtn, GWL_WNDPROC, LongInt(FBtnObjectInst));
  end;
end;

procedure TSkinCombox.Init(sf: Tcomponent; sd: TSkinData; acanvas: TCanvas; acolor: boolean = false);
begin
  if inited then exit;
  inherited init(sf, sd, acanvas, acolor);
  dwStyle := GetWindowLong(hWnd, GWL_STYLE);
  vb := nil;
  if ((dwStyle and CBS_SIMPLE) = CBS_SIMPLE) and
    ((dwStyle and CBS_DROPDOWN) = 0) then begin
    fillchar(info, sizeof(info), #0);
    info.cbSize := sizeof(tagCOMBOBOXINFO);
    if (@pGetComboBoxInfo <> nil) and pGetComboBoxInfo(hwnd, info) then begin
      hList := info.hwndList;
      dwStyle := GetWindowLong(hlist, GWL_STYLE);
      if not ispopupwindow(hlist) and
        (dwstyle and ws_child > 0) then begin
        vb := TSkinScrollbarH.Create(owner);
        vb.Inithwnd(hlist, sd, nil, skinform);
//            db:=TComboxScrollbar.Create(owner);
//            db.Inithwnd(hlist,sd,nil,skinform);
      end;
    end;
  end else begin
{$IFDEF demo}
{$ELSE}
    SkinDropList;
{$ENDIF}
    if not isunicode then findbtn;
    hList := 0;
  end;
end;

procedure TSkinCombox.Inithwnd(ahwnd: Thandle; sd: TSkinData; acanvas: TCanvas; sf: Tcomponent);
begin
  if inited then exit;
  inherited Inithwnd(ahwnd, sd, acanvas, sf);
  dwStyle := GetWindowLongEx(hWnd, GWL_STYLE);
  vb := nil;
  if ((dwStyle and CBS_SIMPLE) = CBS_SIMPLE) and
    ((dwStyle and CBS_DROPDOWN) = 0) then begin
    fillchar(info, sizeof(info), #0);
    info.cbSize := sizeof(tagCOMBOBOXINFO);
    if (@pGetComboBoxInfo <> nil) and pGetComboBoxInfo(hwnd, info) then begin
      hList := info.hwndList;
      dwStyle := GetWindowLongEx(hlist, GWL_STYLE);
      if not ispopupwindow(hlist) and
        (dwstyle and ws_child > 0) then begin
//            vb:=TSkinScrollbarH.Create(owner);
//            vb.Inithwnd(hlist,sd,nil,skinform);
      end;
    end;
  end else begin
    if not isunicode then findbtn;
    hList := 0;
  end;
end;

{Procedure TSkinCombox.Init(sf:Tcomponent;sd:TSkinData;acanvas:TCanvas;acolor:boolean=false);
begin
   if inited then exit;
   inherited init(sf,sd,acanvas,acolor);
   dwStyle := GetWindowLong( hWnd, GWL_STYLE );
   vb:=nil;
   if true then begin
      fillchar(info,sizeof(info),#0);
      info.cbSize:=sizeof(tagCOMBOBOXINFO);
      if GetComboBoxInfo(hwnd,info) then begin
         hList:=info.hwndList ;
         dwStyle := GetWindowLong( hlist, GWL_STYLE );
         if not ispopupwindow(hlist) and (dwstyle and ws_child > 0) then begin
            vb:=TSkinScrollbarH.Create(owner);
            vb.Inithwnd(hlist,sd,nil,skinform);
         end;
      end;
   end else begin
      findbtn;
      hList:=0;
   end;
end; }

procedure TSkinCombox.ButtonProc(var Message: TMessage);
var
  s: string;
begin
  message.result := CallWindowProc(FBtnPrevWndProc, hbtn, message.msg,
    message.WParam, message.LParam);

  case message.msg of
    WM_LBUTTONDOWN, WM_LBUTTONDBLCLK:
      begin
        state := state + [scDown];
        invalidate;
      end;
    wm_paint: begin
        paintcontrol;
      end;
    WM_LBUTTONUP:
      begin
        state := state - [scDown];
        invalidate;
      end;
  end;
end;

procedure TSkinCombox.SkinDropList;
begin
{$IFDEF demo}
{$ELSE}

  dwStyle := GetWindowLong(hWnd, GWL_STYLE);
  if ((dwStyle and CBS_DROPDOWN) = CBS_DROPDOWN) then begin
    fillchar(info, sizeof(info), #0);
    info.cbSize := sizeof(tagCOMBOBOXINFO);
    if (@pGetComboBoxInfo <> nil) and pGetComboBoxInfo(hwnd, info) then begin
      hList := info.hwndList;
      db := TComboxScrollBar.Create(owner);
      db.Inithwnd(hlist, fsd, nil, skinform);
    end else begin
      db := nil;
    end;
  end;
{$ENDIF}
end;

procedure TSkinCombox.DeleteDropList;
begin
  db.Unsubclass;
  db.Free;
  db := nil;
end;

procedure TSkinCombox.CNCommand(var Message: TWMCommand);
begin
  case Message.NotifyCode of
    CBN_DROPDOWN: begin
        isDrop := true;
//        fsd.DoDebug('CBN_DROPDOWN');
//        SkinDropList;
      end;
    CBN_CLOSEUP: begin
        isDrop := false;
//        fsd.DoDebug('CBN_DROPUP');
//        DeleteDropList;
      end;
  end;
end;

{type
  TAcCombo = class(TCustomCombo);

procedure TSkinCombox.FindScrollbar;
var barinfo : tagScrollBarInfo;
    b:boolean;
    r:TRect;
    ahwnd:Thandle;
begin
   ahwnd:=TAcCombo(control).ListHandle;
   fillchar(barinfo,sizeof(barinfo),#0);
   barinfo.cbSize := SizeOf(barinfo);
   b:= GetScrollBarInfo(hlist, OBJID_VSCROLL, barinfo);
   if b then
     r:= barinfo.rcScrollBar;
end;}

procedure TSkinCombox.AfterProc(var Message: TMessage);
var
  s: string;
  p: Tpoint;
begin
{$IFDEF combobox}
  s := MsgtoStr(message);
  if s <> '' then skinaddlog('****Combobox ' + s);
{$ENDIF}
  case message.msg of
{    CM_MOUSEENTER:
      if Enabled then begin
        state:=state+[scMouseIn];
//        invalidate;
      end;}
    CM_MOUSELEAVE:
      if (scMouseIn in state) then begin
        state := state - [scMouseIn];
        invalidate;
      end;
    WM_KILLFOCUS, WM_SETFOCUS: ;
    WM_MouseMove: begin
        P := point(Message.LParamLo, Message.LParamhi);
        if (scMouseIn in state) then begin
          if not PtInRect(rbtn, p) and Enabled then begin
            state := state - [scMouseIn];
            invalidate;
          end;
        end else if PtInRect(rbtn, p) and Enabled then begin
          state := state + [scMouseIn];
          invalidate;
        end;
      end;
    WM_LBUTTONDOWN, WM_LBUTTONDBLCLK:
      begin
//       vb.AttachHwnd(self,hlist,sb_Vert);
//       vb.Invalidate;
        state := state + [scDown];
        invalidate;
      end;
    WM_NCPaint: invalidate;
    WM_DRAWITEM: invalidate;
    WM_LBUTTONUP:
      begin
        state := state - [scDown];
        invalidate;
      end;
    CN_COMMAND: CNCommand(TWMCommand(message));
{    WM_CTLCOLORLISTBOX : begin
         if hlist<>message.LParam then begin
             hlist:=message.LParam;
             skinaddlog('******* skin combobox');
          //   box.Inithwnd(hlist,fsd,fcanvas,skinform);
         end;
      end;}
  else inherited AfterProc(message);
  end;
end;

procedure TSkinCombox.DrawSkinMap3(dc: HDC; rc: TRect;
  bmp: Tbitmap; I, N: integer);
var
  temp: Tbitmap;
  w, h, x: integer;
begin
  temp := Tbitmap.create;
  w := bmp.width div n;
  h := bmp.height;
//    temp.height:=rc.bottom-rc.top;
  temp.height := h;
  temp.width := rc.right - rc.left;
  x := (i - 1) * w;
  temp.canvas.copyrect(rect(0, 0, rc.right - rc.left, h),
    bmp.canvas, rect(x, 0, x + w, h));

  DrawTranmap(DC, rc, temp);
  temp.free;
end;

procedure TSkinCombox.DrawBorder(dc: HDC; rc: TRect);
var
  r, r1: Trect;
  acolor: Tcolor;
  c1: Tcolor;
  b1, b2: HBRUSH;
  s: string;
  Exstyle: dword;
begin
  getclientrect(hwnd, r1);

  if (r.right = (r1.right - r1.left)) or
    (r.bottom = (r1.bottom - r1.top)) then exit;
  r1 := rc;
  B1 := CreateSolidBrush(fsd.colors[csButtonShadow]);
  FrameRect(dc, r1, b1);

  c1 := clwhite;
  B2 := CreateSolidBrush(c1);
  InflateRect(r1, -1, -1);
  FrameRect(dc, r1, b2);

  deleteobject(B2);
  deleteobject(B1);
end;

procedure TSkinCombox.DrawArrow(dc: HDC; rc: TRect; i: integer);
var
  w: integer;
  r1, r2: Trect;
begin
//    w:= fsd.comboxarrow.Map.Width div fsd.comboxarrow.frame;
  GetWindowRect(hbtn, r1);
  GetWindowRect(hwnd, r2);
  offsetrect(r1, -r2.left, -r2.Top);
//    r1:=Rect(0,0,width,control.Height-4);
//    r2:=Rect((i-1)*w,0,i*w,fsd.comboxarrow.Map.height);
  FillColor(dc, r1, fsd.colors[csbuttonface]);
  DrawSkinMap1(dc, r1, fsd.comboxarrow.map, i, fsd.comboxarrow.frame);
end;

procedure TSkinCombox.DrawControl(dc: HDC; rc: TRect);
var
  cs, w, h, i, m, w1, h1, rg: integer;
  r, r1, r2: Trect;
begin
  if (fsd.combox = nil) or (fsd.combox.map.empty) then exit;
//   if isdrop then findscrollbar;
  dwStyle := GetWindowLong(hWnd, GWL_STYLE);
  ExStyle := GetWindowLong(hWnd, GWL_ExSTYLE);

  fillchar(info, sizeof(info), #0);
  info.cbSize := sizeof(tagCOMBOBOXINFO);
  if @pGetComboBoxInfo <> nil then begin
    pGetComboBoxInfo(hwnd, info);
    rbtn := info.rcButton;
    if (info.stateButton and STATE_SYSTEM_INVISIBLE) = STATE_SYSTEM_INVISIBLE then begin
    //  drawedit(dc,rc);
      exit;
    end;
  end;

  if fsd.combox.style = 1 then begin
    DrawControl1(dc, rc);
    exit;
  end;

  r := rc;
  offsetrect(r, -r.left, -r.Top);
  r1 := r;
  r2 := r;

  Focused := (GetFocus = hWnd);
  enabled := (dwstyle and WS_DISABLED) = 0;

  i := 1;
  if focused then i := 4;

  if (scDown in state) then i := 2
  else if (scMouseIn in state) then i := 4;
  if not enabled then i := 3;

  w1 := GetSystemMetrics(SM_CXHSCROLL);

  if not HasButton then begin

    if fsd.combox.style = 2 then begin
      if (exstyle and WS_EX_LEFTSCROLLBAR) = 0 then
        DrawRect2(dc, r2, fsd.combox.map, fsd.combox.r, i, fsd.ComBox.frame, 1)
      else if Assigned(fsd.Comboxborder) then begin
        //r2.right:=r.left+w1+2;
        DrawRect2(dc, r2, fsd.Comboxborder.map, fsd.Comboxborder.r, i, fsd.Comboxborder.frame, 1);
      end;
      exit;
    end;
  end else begin
    DrawBorder(dc, rc);
    DrawArrow(dc, rc, i);
    exit;
  end;

  if (exstyle and WS_EX_LEFTSCROLLBAR) = 0 then begin
    rg := ExcludeClipRect(dc, r1.left + 2, r1.top + 2, r1.right - w1 - 4, r1.bottom - 2);
    r2.Left := r.Right - w1 - 2;
    r1 := r2;
    r1.Right := r.Right - 2;
    DrawSkinMap(dc, r, fsd.Comboxborder, i, fsd.Comboxborder.frame);
    DrawSkinMap2(dc, r2, fsd.combox.map, i, fsd.ComBox.frame);
  end else begin
    rg := ExcludeClipRect(dc, r.left + w1 + 4, r.top + 2, r.right - 2, r.bottom - 2);
    r2.right := r.left + w1 + 2;
    r1 := r2;
    r1.left := 2;
    r1.Right := r1.left + w1;
    DrawSkinMap(dc, r, fsd.Comboxborder, i, fsd.Comboxborder.frame);
    DrawSkinMap2(dc, r2, fsd.combox.maskmap, i, fsd.ComBox.frame);
  end;

  rbtn := r2;

  if (fsd.ExtraImages <> nil) and (not fsd.ExtraImages.map.empty) then begin
    w := fsd.ExtraImages.map.width div fsd.ExtraImages.frame;
    h := fsd.ExtraImages.map.height;
    r1.left := r1.left + (r1.right - r1.left - w) div 2;
    r1.top := r1.top + (r1.bottom - r1.top - h) div 2;
    r1.right := r1.left + w;
    r1.bottom := r1.top + h;
    DrawSkinMap1(dc, r1, fsd.ExtraImages.map, i, fsd.ExtraImages.frame);
//       fcanvas.copyrect(r1,fsd.ExtraImages.map.canvas,rect(0,0,w1,h1));
//      DrawSkinMap2( dc,r1,fsd.ExtraImages.map,i,fsd.ExtraImages.frame);
  end;
//   ExcludeClipRect(dc,0,0,0,0);
//   deleteobject(rg);
//   SetWindowRgn(hwnd,0,false);
end;

procedure TSkinCombox.DrawEdit(dc: HDC; rc: TRect);
var
  r1: Trect;
  c1: Tcolor;
  b1, b2: HBRUSH;
begin
  r1 := rc;
  B1 := CreateSolidBrush(fsd.colors[csButtonShadow]);
  FrameRect(dc, r1, b1);
  deleteobject(B1);

  c1 := clwhite;
  B2 := CreateSolidBrush(c1);
  InflateRect(r1, -1, -1);
  FrameRect(dc, r1, b2);
  deleteobject(B2);
end;

procedure TSkinCombox.DrawControl1(dc: HDC; rc: TRect);
var
  w, w1, h, h1, i: integer;
  r, r1, r2: Trect;
  c: Tcolor;
  temp: Tbitmap;
  b: HBRUSH;
begin
  r := rc;
  offsetrect(r, -r.left, -r.Top);

  Focused := (GetFocus = hWnd);
  enabled := (dwStyle and WS_DISABLED) = 0;

  i := 1;
  if not enabled then i := 3;
  if focused then i := 4;

  if (scDown in state) then i := 2
  else if (scMouseIn in state) then i := 4;

  r1 := r;
  w1 := fsd.combox.map.width div fsd.combox.frame;
  h := fsd.combox.map.height;
  h1 := GetSystemMetrics(SM_CYVTHUMB);

  fcanvas.handle := dc;
  c := fcanvas.brush.color;
  fcanvas.brush.handle := GetCurrentObject(dc, OBJ_BRUSH);
  InflateRect(R1, -1, -1);
  fcanvas.FrameRect(R1);

  InflateRect(R1, -1, -1);
   //background
  r2 := r1;
  if (exstyle and WS_EX_LEFTSCROLLBAR) = 0 then
    r1.left := r1.right - h1
  else
    r1.Right := r1.Left + h1;
  fcanvas.fillRect(R1);

   //do not strech button
  r1 := r2;
  if (exstyle and WS_EX_LEFTSCROLLBAR) = 0 then
    r1.left := r1.right - w1            //GetSystemMetrics(SM_CYVTHUMB)
  else
    r1.Right := r1.Left + w1;           //GetSystemMetrics(SM_CYVTHUMB);

  if (h < h1) then r1.Bottom := r1.Top + h;

  c := fcanvas.brush.color;
  fcanvas.brush.color := fsd.colors[csButtonShadow];
  fcanvas.FrameRect(R);
  fcanvas.brush.color := c;

//   fcanvas.FrameRect(R1);
  rbtn := r1;
  DrawSkinMap1(dc, r1, fsd.combox.map, i, fsd.combox.frame);

//   w:= fsd.ComBox.map.width div fsd.ComBox.frame;
//   h:= fsd.ComBox.map.height;
//   r2:=rect((i-1)*w,0,i*w,h);
//   fcanvas.copyrect(r1,fsd.ComBox.map.canvas,r2);
end;

constructor TArrowButton.Create(AOwner: TComponent);
begin
  control := nil;
  cw := GetSystemMetrics(SM_CXHSCROLL);
  hwnd := 0;
  tabstop := false;
  inherited create(aowner);
end;

destructor TArrowButton.Destroy;
begin
  inherited destroy;
end;

procedure TArrowButton.Attach(aobj: Tskincontrol; acontrol: Twincontrol);
var
  ExStyle: dword;
  Style: dword;
  r, r2: TRect;
begin
  obj := aobj;
  control := acontrol;
  hwnd := control.Handle;
  ExStyle := GetWindowLong(hWnd, GWL_ExSTYLE);
  getwindowrect(hwnd, r);
  offsetrect(r, -r.Left, -r.Right);
  ParentWindow := hwnd;
  self.width := cw;
  self.height := control.Height - 4;    //cw+1;
  self.Top := 0;

  if (exstyle and WS_EX_LEFTSCROLLBAR) = 0 then begin
    self.Left := r.Right - cw - 4;
  end else begin
    self.left := 2;
  end;
  Style := GetWindowLong(hWnd, GWL_STYLE);
  Style := Style or WS_CLIPCHILDREN;
  SetWindowLong(hWnd, GWL_STYLE, style);
end;

procedure TArrowButton.MoveArrow(r: TRect);
var
  ExStyle: dword;
begin
  ExStyle := GetWindowLong(hWnd, GWL_ExSTYLE);
  if (exstyle and WS_EX_LEFTSCROLLBAR) = 0 then begin
    self.Left := r.Right - cw - 4;
  end else begin
    self.left := 2;
  end;
end;

procedure TArrowButton.CMMouseEnter(var aMsg: TMessage);
begin
  if control.Enabled then begin
    state := state + [scMouseIn];
    invalidate;
  end;
end;

procedure TArrowButton.CMMouseLeave(var aMsg: TMessage);
begin
  if control.Enabled then begin
    state := state - [scMouseIn];
    invalidate;
  end;
end;

procedure TArrowButton.WMLButtonDown(var aMsg: TMessage);
var
  p: Tpoint;
begin
  inherited;
  inc(amsg.LParamLo, self.Left);
  inc(amsg.LParamHi, self.Top);
  postmessage(hwnd, WM_LButtonDown, amsg.WParam, amsg.lparam);
  postmessage(hwnd, WM_LBUTTONUP, amsg.WParam, amsg.lparam);
  invalidate;
end;

procedure TArrowButton.WMLButtonUP(var aMsg: TMessage);
var
  p: Tpoint;
begin
  inherited;
  windows.setfocus(hwnd);
//    invalidate;
end;

procedure TArrowButton.Paint;
var
  i, w: integer;
  r1, r2: Trect;
begin
  i := 1;
  if (scMouseIn in state) then i := 4;
  w := obj.fsd.comboxarrow.Map.Width div obj.fsd.comboxarrow.frame;
  r1 := Rect(0, 0, width, control.Height - 4);
  r2 := Rect((i - 1) * w, 0, i * w, obj.fsd.comboxarrow.Map.height);
  canvas.Brush.color := obj.fsd.colors[csbuttonface];
  canvas.FillRect(r1);
  canvas.copyrect(r1, obj.fsd.comboxarrow.map.canvas, r2);
end;

destructor TSkinDateTime.Destroy;
begin
  inherited destroy;
end;

procedure TSkinDateTime.Init(sf: Tcomponent; sd: TSkinData; acanvas: TCanvas; acolor: boolean = false);
begin
  if inited then exit;
  inherited init(sf, sd, acanvas, acolor);
  arrow := TArrowButton.create(self);
  arrow.attach(self, control);
end;

procedure TSkinDateTime.AfterProc(var Message: TMessage);
var
  s: string;
  dwstyle: dword;
begin
  case message.msg of
    WM_Size: begin
        if arrow <> nil then arrow.repaint;
          //invalidate;
      end;
  else inherited Afterproc(message);
  end;
end;

procedure TSkinDateTime.DrawControl(dc: HDC; rc: TRect);
var
  r, r1: Trect;
  acolor: Tcolor;
  c1: Tcolor;
  b1, b2: HBRUSH;
  s: string;
  Exstyle: dword;
begin
  getclientrect(hwnd, r1);

  arrow.MoveArrow(rc);
  if (r.right = (r1.right - r1.left)) or
    (r.bottom = (r1.bottom - r1.top)) then exit;
  r1 := rc;
  B1 := CreateSolidBrush(fsd.colors[csButtonShadow]);
  FrameRect(dc, r1, b1);

  c1 := clwhite;
  B2 := CreateSolidBrush(c1);
  InflateRect(r1, -1, -1);
  FrameRect(dc, r1, b2);

//   InflateRect(r1,-1,-1);
//   FrameRect(dc,r1,b2);
//   dec(r1.Bottom);
//   FrameRect(dc,r1,b2);

  deleteobject(B2);
  deleteobject(B1);
end;

constructor TWScrollbar.Create(AOwner: TComponent);
begin
  control := nil;
  cw := GetSystemMetrics(SM_CXHSCROLL);
  hwnd := 0;
  tabstop := false;
  inherited create(aowner);
  scrollpos := -1;
end;

destructor TWScrollbar.Destroy;
begin
  inherited destroy;
end;

procedure TWScrollbar.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do begin
    ExStyle := WS_EX_TOOLWINDOW;
  end;
end;

procedure TWScrollbar.attach(aobj: TSkinControl; aControl: Twincontrol; aType: byte);
var
  s: string;
  parenthwnd: Thandle;
  dw: Dword;
begin
  obj := aobj;
  hwnd := acontrol.handle;
  control := acontrol;
  sbtype := aType;
  sbDir := sbType;
  color := obj.GetParentColor(obj.fsd.colors[csbuttonface]);

  if (sbdir = sb_CTL) and (control <> nil) then begin
    s := lowercase(GetEnumProperty(control, 'Kind'));
    if s = 'sbhorizontal' then sbdir := sb_HORZ
    else sbdir := sb_vert;
//      if control.ClassName='T32ScrollBar' then
//          sbtype:=sb_vert;
  end;

  parenthwnd := GetParent(hWnd);
//   dw:=GetWindowLong(parenthwnd,GWL_STYLE) ;
//   if parenthwnd= 0 then exit;
  ParentWindow := parenthwnd;
  setposition(hwnd);
//   SetWindowLong(ParentWindow,GWL_STYLE,dw or WS_CLIPSIBLINGS ) ;
end;

procedure TWScrollbar.attachHwnd(aobj: TSkinControl; ahwnd: Thandle; aType: byte);
var
  s: string;
  parenthwnd: Thandle;
begin
  obj := aobj;
  hwnd := ahwnd;
  control := nil;
  sbtype := aType;
  sbDir := sbType;

  parenthwnd := GetParent(hWnd);
  ParentWindow := parenthwnd;
  setposition(hwnd);
end;
// MapWindowPoints(ComboWnd, Handle, Point, 1);

procedure TWScrollbar.HideScrollbar;
begin
  ShowWindow(handle, SW_HIDE);
  sbVisible := false;
  visible := false;
end;

procedure TWScrollbar.ButtonUp;
begin
  fdown := false;
  ReleaseCapture;
  if sbtype = SB_CTL then invalidate;
end;

procedure TWScrollbar.SetPosition(ahwnd: Thandle);
var
  parenthwnd, prehwnd: Thandle;
  r1: TRect;
  p, p1: Tpoint;
  barinfo: tagScrollBarInfo;
  b: boolean;
  dw: dword;
begin
  hwnd := ahwnd;
  parenthwnd := GetParent(hWnd);
  fillchar(barinfo, sizeof(barinfo), #0);
  barinfo.cbSize := SizeOf(barinfo);
  if sbtype = SB_VERT then begin
    b := obj.fsd.GetScrollBarInfo(hwnd, OBJID_VSCROLL, barinfo);
  end else if sbtype = SB_Horz then begin
    b := obj.fsd.GetScrollBarInfo(hwnd, OBJID_HSCROLL, barinfo);
  end else if sbtype = SB_CTL then
    b := GetControlInfo2(barinfo);

  sbVisible := b;

  if not b then begin
    exit;                               //recreatewnd
  end;

  dw := GetWindowLong(hWnd, GWL_STYLE);
  if (dw and ws_visible) = 0 then begin
    sbVisible := false;
    ShowWindow(handle, SW_HIDE);
    exit;
  end;

  if ((barinfo.rgstate[0] and STATE_SYSTEM_INVISIBLE) > 0) then begin
    if sbDir = SB_vert then
      ShowWindow(handle, SW_HIDE)
    else
      ShowWindow(handle, SW_HIDE);
    sbVisible := false;
  end else begin
    r1 := barinfo.rcScrollBar;

    p := r1.TopLeft;
    windows.screentoclient(hwnd, p);
    sbrect.TopLeft := p;
    p := r1.BottomRight;
    windows.screentoclient(hwnd, p);
    sbrect.BottomRight := p;

    offsetrect(r1, -r1.left, -r1.top);
    if sbDir = SB_vert then len := r1.Bottom
    else len := r1.Right;

    p := point(barinfo.rcScrollBar.Left, barinfo.rcScrollBar.Top);
    offsetSC := p;
    windows.screentoclient(parenthwnd, p);

//      p1:=barinfo.rcScrollBar.TopLeft;
//      MapWindowPoints(0,hwnd,P1, 1);

    prehwnd := GetNextWindow(hwnd, GW_HWNDPREV);
    if prehwnd = 0 then prehwnd := HWND_TOP;
    ShowWindow(handle, SW_Show);
    sbVisible := true;
    if sbtype <> SB_CTL then begin
      SetWindowPos(handle, prehwnd, p.x, p.Y, r1.Right, r1.Bottom, 0); //SWP_NOREDRAW);
      MoveWindow(handle, p.x, p.Y, r1.Right, r1.Bottom, true);
    end else begin
      p := point(barinfo.rcScrollBar.Left, barinfo.rcScrollBar.Top);
      SetWindowPos(handle, prehwnd, p.x, p.Y, r1.Right, r1.Bottom, 0); //SWP_NOREDRAW);
      MoveWindow(handle, p.x, p.Y, r1.Right, r1.Bottom, true);
    end;
  end;
end;

function TWScrollbar.GetScrollPos(p: Tpoint): integer;
var
  x: integer;
begin
  if sbDir = SB_Horz then x := p.x
  else x := p.y;

  if x < cw then result := SB_LINEUP
  else if x < thumbtop then result := SB_PAGEUP
  else if x < thumbbottom then result := SB_THUMBTRACK
  else if x < len - cw then result := SB_PAGEDOWN
  else result := SB_LINEDOWN;
end;

procedure TWScrollbar.WMERASEBKGND(var Msg: TMessage);
begin
//    inherited;
//    if obj.sizing then inherited;
  Msg.Result := 1;
end;

procedure TWScrollbar.WMLButtonDBClick(var aMsg: TMessage);
begin
  WMLButtonDown(amsg);
end;

function TWScrollbar.GetControlInfo(var info: tagScrollBarInfo): boolean;
var
  sb: TScrollbar;
  p: TPoint;
  asize: integer;
  amax: integer;
begin
  result := false;
  if control = nil then exit;
  sb := TScrollbar(control);
  result := true;

  p := point(0, 0);
  windows.ClientToScreen(hwnd, p);

  info.rcScrollBar := sb.ClientRect;
  offsetrect(info.rcScrollBar, p.x, p.Y);

  if sbDir = sb_horz then len := info.rcScrollBar.Right - info.rcScrollBar.Left
  else len := info.rcScrollBar.bottom - info.rcScrollBar.top;

  amax := sb.Max - sb.Min;

  if sb.PageSize <> 0 then begin
    asize := MulDiv(len - 2 * cw, sb.pagesize - 1, amax);
    if sb.Position <> sb.Min then
      info.xyThumbTop := cw + MulDiv(len - 2 * cw, sb.Position - sb.Min, amax)
    else
      info.xyThumbTop := cw;
  end else begin
    asize := cw;
    if sb.Position <> sb.Min then
      info.xyThumbTop := cw + MulDiv(len - 3 * cw, sb.Position - sb.Min, amax)
    else
      info.xyThumbTop := cw;
  end;
  info.xyThumbBottom := info.xyThumbTop + asize;
end;

function TWScrollbar.GetControlInfo2(var info: tagScrollBarInfo): boolean;
var
  sb: TScrollbar;
  p: TPoint;
  asize: integer;
  amax: integer;
  si: SCROLLINFO;
begin
  result := false;
  if control = nil then exit;
  sb := TScrollbar(control);
  result := true;

  p := point(0, 0);
  windows.ClientToScreen(hwnd, p);

//   info.rcScrollBar := sb.ClientRect;
  info.rcScrollBar := sb.BoundsRect;
//   offsetrect(info.rcScrollBar,p.x,p.Y);


  si.cbSize := sizeof(si);
  si.fMask := SIF_ALL;

  if sbDir = sb_horz then begin
    GetScrollInfo(hWnd, SB_CTL, si);
  end else begin
    GetScrollInfo(hWnd, SB_CTL, si);
  end;

  if sbDir = sb_horz then len := info.rcScrollBar.Right - info.rcScrollBar.Left
  else len := info.rcScrollBar.bottom - info.rcScrollBar.top;

  amax := si.nMax - si.nMin;
  if amax = 0 then amax := 9999999;
  if si.nPage <> 0 then begin
    asize := MulDiv(len - 2 * cw, si.nPage - 1, amax);
    if asize < 8 then begin
      asize := 8;
      if si.npos <> si.nMin then
        info.xyThumbTop := cw + Muldiv(len - 2 * cw - asize, si.nPos - si.nMin, amax)
      else
        info.xyThumbTop := cw;
    end else begin
      if si.npos <> si.nMin then
        info.xyThumbTop := cw + MulDiv(len - 2 * cw, si.npos - si.nMin, amax)
      else
        info.xyThumbTop := cw;
    end;
  end else begin
    asize := cw;
    if si.npos <> si.nMin then
      info.xyThumbTop := cw + MulDiv(len - 3 * cw, si.npos - si.nMin, amax)
    else
      info.xyThumbTop := cw;
  end;
  info.xyThumbBottom := info.xyThumbTop + asize;
end;

procedure TWScrollbar.WMMouseLeave(var aMsg: TMessage);
begin
  if not fdown then begin
    scrollpos := -1;
    invalidate();
  end;
end;

procedure TWScrollbar.WMMouseMove(var aMsg: TMessage);
var
  p: Tpoint;
  i: integer;
begin
  inherited;
  P := point(amsg.LParamLo, amsg.LParamhi);
  i := getscrollpos(p);
  if i <> scrollpos then begin
    scrollpos := i;
    invalidate();
  end;
  WinSkinData.DoTrackMouse(Handle);
end;

procedure TWScrollbar.WMLButtonDown(var aMsg: TMessage);
var
  p: Tpoint;
  x: integer;
  barinfo: tagScrollBarInfo;
  b: boolean;
begin
  inherited;
  P := point(amsg.LParamLo, amsg.LParamhi);
  GetCursorPos(trackp);
  fillchar(barinfo, sizeof(barinfo), #0);
  barinfo.cbSize := SizeOf(barinfo);
  if sbtype = SB_VERT then begin
    b := obj.fsd.GetScrollBarInfo(hwnd, OBJID_VSCROLL, barinfo);
  end else if sbtype = SB_Horz then begin
    b := obj.fsd.GetScrollBarInfo(hwnd, OBJID_HSCROLL, barinfo);
  end else if sbtype = SB_CTL then
    b := GetControlInfo(barinfo);

  if b then begin
    trackthumb := barinfo.xyThumbTop;
  end;

  scrollpos := getscrollpos(p);
  if sbtype = SB_CTL then begin
  end else begin
    offsetSC := point(barinfo.rcScrollBar.Left, barinfo.rcScrollBar.Top);
    amsg.LParamLo := amsg.LParamLo + offsetSc.x; // inc(amsg.LParamLo,offsetSc.x);
    amsg.LParamHi := amsg.LParamHi + offsetSc.y; //inc(amsg.LParamHi,offsetSc.y);
  end;

  fdown := true;
  invalidate;
  scrollpos := getscrollpos(p);
  releasecapture;

  if sbtype = SB_VERT then begin
    sendmessage(hwnd, CM_Scroll1, C_Paramv, amsg.lparam);
  end else if sbtype = SB_HORZ then
    sendmessage(hwnd, CM_Scroll1, C_Paramh, amsg.lparam)
  else
    sendmessage(hwnd, CM_Scroll2, c_paramB, amsg.lparam);

  fdown := false;
  ReleaseCapture;
  if sbtype = SB_CTL then invalidate;
end;

procedure TWScrollbar.WMLButtonUp(var aMsg: TMessage);
var
  p: Tpoint;
  x: integer;
begin
  inherited;
  P := point(amsg.LParamLo, amsg.LParamhi);
  if sbdir <> SB_CTL then begin
    inc(amsg.LParamLo, offsetSc.x);
    inc(amsg.LParamHi, offsetSc.y);
  end;
  fdown := false;
  ReleaseCapture;
  if sbtype = SB_VERT then
    postmessage(hwnd, CM_Scroll3, C_Paramv, amsg.lparam)
  else if sbtype = SB_HORZ then
    postmessage(hwnd, CM_Scroll3, C_Paramh, amsg.lparam)
  else
    postmessage(hwnd, CM_Scroll4, c_paramB, amsg.lparam);
  if sbtype = SB_CTL then invalidate;
end;

procedure TWScrollbar.doLog(Message: TMessage);
var
  s: string;
begin
{$IFDEF test}
  s := MsgtoStr(message);
  if s <> '' then form1.memo2.lines.add(s);
{$ENDIF}
end;

procedure TWScrollbar.GetThumb(rc: TRect);
var
  p: Tpoint;
  size: integer;
begin
  GetCursorPos(p);
  size := thumbbottom - thumbtop;
  thumbtop := trackthumb;
  if (sbDir = sb_Vert) then
    inc(thumbtop, p.Y - trackp.y)
  else
    inc(thumbtop, p.x - trackp.x);

  if thumbtop < cw then thumbtop := cw;
  if thumbtop > Len - cw - size then thumbtop := Len - cw - size;
  thumbbottom := thumbtop + size;
end;

procedure TWScrollbar.Paint;
var
  rc, rc1, rc2: TRect;
  p: Tpoint;
  barinfo: tagScrollBarInfo;
  b, sbenable: boolean;
  temp: TBitmap;
  fsd: TSkindata;
  bw, i1, i2, swidth, n: integer;
begin
//   if not sbvisible then exit;
  fsd := obj.fsd;
  if (fsd.SArrow = nil) or fsd.sarrow.map.empty then exit;

  fillchar(barinfo, sizeof(barinfo), #0);
  barinfo.cbSize := SizeOf(barinfo);
  if sbtype = SB_VERT then begin
    b := fsd.GetScrollBarInfo(hwnd, OBJID_VSCROLL, barinfo);
  end else if sbtype = SB_Horz then begin
    b := fsd.GetScrollBarInfo(hwnd, OBJID_HSCROLL, barinfo);
  end else if sbtype = SB_CTL then
    b := GetControlInfo2(barinfo);
//     b:= GetScrollBarInfo(obj.hwnd, OBJID_CLIENT, barinfo);

  if not b then exit;                   //recreatewnd
  if (barinfo.rgstate[0] and STATE_SYSTEM_INVISIBLE) > 0 then exit;

  if (barinfo.rgstate[0] and STATE_SYSTEM_UNAVAILABLE) > 0 then
    sbEnable := false
  else sbEnable := true;

//   if self.enabled<>sbenable then self.Enabled:=sbenable;

  bw := cw;
  rc := barinfo.rcScrollBar;
  offsetrect(rc, -rc.left, -rc.top);
  if (rc.Bottom < 0) or (rc.Right < 0) then exit;
  if (rc.Bottom > Height) or (rc.Right > Width) then exit;
//   if (rc.right>fsd.cxMax) or (rc.Bottom>fsd.cyMax) then exit;

  if sbtype = SB_vert then len := rc.Bottom
  else len := rc.Right;

  swidth := fsd.SArrow.map.height;
//   if swidth>cw then swidth:=cw;
  if abs(swidth - cw) > 2 then swidth := cw;

   //Tscrollbar
  if sbtype = SB_CTL then begin
    if sbDir = sb_Horz then rc.bottom := swidth
    else rc.right := swidth;
  end;

  temp := Tbitmap.create;

  try
    temp.width := rc.right;
    temp.height := rc.bottom;
  except
    temp.Free;
    exit;
  end;

  SetStretchBltMode(temp.canvas.handle, STRETCH_DELETESCANS);
  temp.canvas.brush.color := fsd.colors[csbuttonface];
  temp.canvas.fillrect(rc);
   //for ws_vscroll ws_hscroll
  if sbtype <> SB_CTL then begin
    if sbDir = sb_Horz then rc.bottom := swidth
    else rc.right := swidth;
  end;

  rc1 := rc;
  i1 := 1;
  if not sbEnable then i1 := 3;
  if sbDir = SB_Horz then begin
    rc1.left := rc1.left + bw;
    rc1.right := rc1.right - bw;
    DrawRect2(temp.canvas.handle, rc1, fsd.HBar.map,
      fsd.HBar.r, i1, 4, fsd.hbar.trans, fsd.hbar.tile);
  end else begin
    rc1.top := rc1.top + bw;
    rc1.bottom := rc1.bottom - bw;
    DrawRect2(temp.canvas.handle, rc1, fsd.VBar.map,
      fsd.VBar.r, i1, 4, fsd.vbar.trans, fsd.hbar.tile);
  end;

   //Button
  rc1 := rc;
  rc2 := rc;
  if (sbDir = SB_Horz) then begin       //HBar
    if (rc.right) < 2 * bw then bw := rc.right div 2;
    rc1.right := rc1.left + bw;
    rc2.left := rc2.right - bw;
    i1 := 1;
    i2 := 5;
  end else begin                        // SB_VERT
    if rc.bottom < 2 * bw then bw := rc.bottom div 2;
    rc1.bottom := rc1.top + bw;
    rc2.top := rc2.bottom - bw;
    i1 := 9;
    i2 := 13;
//      if fdown and (scrollpos=SB_LINEUP) then inc(i1);
//      if fdown and (scrollpos=SB_LINEDown) then inc(i2);
  end;
  if (scrollpos = SB_LINELeft) then begin
    if fdown then inc(i1)
    else inc(i1, 3);
  end;
  if (scrollpos = SB_LINERight) then begin
    if fdown then inc(i2)
    else inc(i2, 3);
  end;
  obj.DrawSkinMap3(temp.canvas, rc1, fsd.SArrow.map, i1, 23);
  obj.DrawSkinMap3(temp.canvas, rc2, fsd.SArrow.map, i2, 23);

  if fdown and (scrollpos = SB_THUMBTRACK) and (sbtype <> sb_Ctl) then
    GetThumb(rc)
  else begin
    thumbtop := barinfo.xyThumbTop;
    thumbBottom := barinfo.xyThumbBottom;
  end;

  i1 := 1;
  if (scrollpos = SB_THUMBTRACK) then begin
    if fdown then inc(i1)
    else inc(i1, 2);
  end;
  if sbEnable then begin
    if (sbDir = SB_VERT) then begin
      i2 := 20;
      rc1 := Rect(0, thumbtop, swidth, thumbbottom);
      if (thumbtop < Height) and (thumbbottom < Height) then
        DrawRect2(temp.canvas.handle, rc1, fsd.VSlider.map,
          fsd.Vslider.r, i1, fsd.Hslider.frame, fsd.hslider.trans)
    end else begin                      // SB_HORZ
      i2 := 17;
      rc1 := Rect(thumbtop, 0, thumbbottom, swidth);
      if (thumbtop < Width) and (thumbbottom < Width) then
        DrawRect2(temp.canvas.handle, rc1, fsd.HSlider.map,
          fsd.Hslider.r, i1, fsd.Hslider.frame, fsd.hslider.trans)
    end;
    if (scrollpos = SB_THUMBTRACK) then begin
      if fdown then inc(i2)
      else inc(i2, 2);
    end;
    bw := fsd.SArrow.map.Height;
    if (thumbbottom - thumbtop + 2) > bw then begin
      n := (thumbbottom - thumbtop - bw) div 2;
      if (sbDir = SB_VERT) then begin
        rc2 := Rect(0, thumbtop + n, swidth, thumbtop + n + bw);
        if (rc2.Top < Height) and (rc2.Bottom < Height) then
          obj.DrawSkinMap3(temp.canvas, rc2, fsd.SArrow.map, i2, 23);
      end else begin
        rc2 := Rect(thumbtop + n, 0, thumbtop + n + bw, swidth);
        if (rc2.left < Width) and (rc2.Right < Width) then
          obj.DrawSkinMap3(temp.canvas, rc2, fsd.SArrow.map, i2, 23);
      end;
    end;
  end;
   //windows.getclientrect(hwnd,rc);
  rc := clientrect;
  if sbtype = SB_CTL then
    StretchBlt(canvas.Handle, rc.Left, rc.Top, rc.Right, rc.Bottom,
      temp.Canvas.Handle, 0, 0, temp.width, temp.height, Srccopy)
  else
    StretchBlt(canvas.Handle, 0, 0, temp.width, temp.height,
      temp.Canvas.Handle, 0, 0, temp.width, temp.height, Srccopy);

  temp.free;
end;

{constructor TEScrollbar.Create(AOwner: TComponent);
begin
    control:=nil;
    cw:= GetSystemMetrics( SM_CXHSCROLL );
    hwnd:=0;
    inherited create(aowner);
end;

destructor TEScrollbar.Destroy;
begin
    inherited destroy;
end;

procedure TEScrollbar.attach(aobj:TSkinControl;aParentControl:Twincontrol;
                             aScrollbar:Tcontrol;aType:byte);
var s:string;
begin
   obj:=aobj;
   Pcontrol:=aParentControl;
   hwnd:=aParentControl.handle;
   control:=ascrollbar;
   sbtype:=aType;
   sbDir:=sbType;

   if (aType=255) and (control<>nil) then begin
      s:=lowercase(GetEnumProperty(control,'Kind'));
      if s='sbhorizontal' then sbdir:=sb_HORZ
      else sbdir:=sb_vert;
   end;

   ParentWindow:=GetParent(hWnd);
   setposition;
end;

procedure TEScrollbar.ButtonUp;
begin
    fdown:=false;
    ReleaseCapture;
    invalidate;
end;

procedure TEScrollbar.HideScrollbar;
begin
    ShowWindow(handle,SW_HIDE);
    sbVisible:=false;
end;

procedure TEScrollbar.SetPosition;
var r1:TRect;
    p,p1:Tpoint;
    barinfo : tagScrollBarInfo;
    b:boolean;
    Parenthwnd: Thandle;
begin
   fillchar(barinfo,sizeof(barinfo),#0);
   barinfo.cbSize := SizeOf(barinfo);
   GetControlInfo(barinfo);
//   sbVisible:=b;

   if barinfo.rgstate[0] >0 then begin
       ShowWindow(handle,SW_HIDE);
       sbVisible:=false;
   end else begin
      r1:= barinfo.rcScrollBar;
      sbrect:=r1;
      ParentHwnd := GetParent(hWnd);
      p:=point(r1.Left,r1.Top);

      MapWindowPoints(hwnd,parenthwnd,P, 1);

      offsetrect(r1,-r1.Left,-r1.Top);
      if sbDir=SB_vert then len:=r1.Bottom
      else len:=r1.Right;

      SetWindowPos(handle, HWND_TOP, p.X,p.y,r1.Right,r1.Bottom,SWP_SHOWWINDOW or SWP_NOREDRAW);

//      if sbDir=SB_vert then
//      SetWindowPos(handle, HWND_TOP, r1.Left,r1.Top,r1.Right,r1.Bottom,SWP_SHOWWINDOW or SWP_NOREDRAW)
//      else
//       SetWindowPos(handle, HWND_TOP, r1.Left,r1.Top,r1.Right,r1.Bottom,SWP_SHOWWINDOW or SWP_NOREDRAW);
   end;
end;

function TEScrollbar.GetControlInfo(var info:tagScrollBarInfo):boolean;
var p:TPoint;
    asize:integer;
    pagesize,amax,amin:integer;
    position:integer;
    s:string;
begin
   result:=false;
   if control=nil then exit;

   p:=point(0,0);
   windows.ClientToScreen(hwnd,p);

   info.rcScrollBar := rect(control.left,control.top,
              control.left+control.Width,control.top+control.height);

//   offsetrect(info.rcScrollBar,p.x,p.Y);

   if sbDir=sb_horz then len:=info.rcScrollBar.Right-info.rcScrollBar.Left
   else len:=info.rcScrollBar.bottom-info.rcScrollBar.top;

   PageSize := GetIntProperty(control,'PageSize') ;
   amax := GetIntProperty(control,'Max') ;
   amin := GetIntProperty(control,'Min') ;
   Position := GetIntProperty(control,'Position') ;

//   s := lowercase(GetEnumProperty(control,'Visible'));
//   if s='true' then sbVisible:=true
//   else sbVisible:=false;
   sbVisible:=control.Visible;
   result:=sbVisible;

   if PageSize<>0 then begin
       asize:=MulDiv(len-2*cw,pagesize-amin,amax);
       if Position<>0 then
          info.xyThumbTop := cw+MulDiv(len-2*cw,Position,amax)
       else
          info.xyThumbTop := cw;
   end else begin
      asize:=cw;
      if Position<>0 then
         info.xyThumbTop := cw+MulDiv(len-3*cw,Position,amax)
      else
         info.xyThumbTop := cw;
   end;
   info.xyThumbBottom := info.xyThumbTop+asize;
end;

function TEScrollbar.GetScrollPos(p:Tpoint):integer;
var x:integer;
begin
    if sbDir=SB_Horz then x:=p.x
    else x:=p.y;

    if x<cw then result:=SB_LINEUP
    else if x<thumbtop then result:=SB_PAGEUP
    else if x<thumbbottom then result:=SB_THUMBTRACK
    else if x<len-cw then result:=SB_PAGEDOWN
    else result:=SB_LINEDOWN;
end;

procedure TEScrollbar.GetThumb(rc:TRect);
var p:Tpoint;
    size:integer;
begin
    GetCursorPos(p);
    size:=thumbbottom-thumbtop;
    thumbtop:=trackthumb;
    if(sbDir=sb_Vert) then
         inc(thumbtop,p.Y-trackp.y)
    else
         inc(thumbtop,p.x-trackp.x);

    if thumbtop<cw then thumbtop:=cw;
    if thumbtop>Len-cw-size then thumbtop:=Len-cw-size;
    thumbbottom:=thumbtop+size;
end;

procedure TEScrollbar.WMLButtonDown(Var aMsg: TMessage);
var  p:Tpoint;
     x:integer;
     barinfo : tagScrollBarInfo;
     b:boolean;
begin
    inherited;
    P := point(amsg.LParamLo,amsg.LParamhi);
//    inc(amsg.LParamLo,Sbrect.left);
//    inc(amsg.LParamHi,sbRect.top);
    GetCursorPos(trackp);
    fillchar(barinfo,sizeof(barinfo),#0);
    barinfo.cbSize := SizeOf(barinfo);
    b:= GetControlInfo(barinfo);

    if b then begin
      trackthumb:=barinfo.xyThumbTop;
    end;

    scrollpos:=getscrollpos(p);

//    SetCapture(handle);
    fdown:=true;
    invalidate;
    control.Perform(CM_Scroll2,c_paramB,amsg.lparam);
//    postmessage(hwnd,CM_Scroll2,c_paramB,amsg.lparam);
end;

procedure TEScrollbar.WMERASEBKGND(var Msg: TMessage);
begin
   Msg.Result := 1;
end;

procedure TEScrollbar.Paint;
var rc,rc1,rc2:TRect;
    p:Tpoint;
    barinfo : tagScrollBarInfo;
    b,sbenable:boolean;
    temp:TBitmap;
    fsd:TSkindata;
    bw,i1,i2,swidth:integer;
begin
   fsd:=obj.fsd;
   if (fsd.SArrow=nil) or fsd.sarrow.map.empty then exit;

   fillchar(barinfo,sizeof(barinfo),#0);
   barinfo.cbSize := SizeOf(barinfo);

   b:= GetControlInfo(barinfo);

   if barinfo.rgstate[0]>1 then
      sbEnable:=false;

   bw:=cw;
   rc:= barinfo.rcScrollBar;
   offsetrect(rc,-rc.left,-rc.top);
   if sbtype=SB_vert then len:=rc.Bottom
   else len:=rc.Right;

   swidth:=fsd.SArrow.map.height;
   if swidth+3<cw then swidth:=cw;

   temp:=Tbitmap.create;
   temp.width:=rc.right;
   temp.height:=rc.bottom;
   SetStretchBltMode(temp.canvas.handle,STRETCH_DELETESCANS);
   temp.canvas.brush.color:=fsd.colors[csbuttonface];
   temp.canvas.fillrect(rc);

   if sbDir=sb_Horz then rc.bottom:=swidth
   else rc.right:=swidth;

   rc1:=rc;
   i1:=1;
   if not sbEnable then i1:=3;
   if sbDir=SB_Horz then begin
     rc1.left:=rc1.left+bw;
     rc1.right:=rc1.right-bw;
     DrawRect2(temp.canvas.handle,rc1,fsd.HBar.map,
                   fsd.HBar.r,i1,4,fsd.hbar.trans,fsd.hbar.tile);
   end else begin
     rc1.top:=rc1.top+bw;
     rc1.bottom:=rc1.bottom-bw;
     DrawRect2(temp.canvas.handle,rc1,fsd.VBar.map,
                   fsd.VBar.r,i1,4,fsd.vbar.trans,fsd.hbar.tile);
   end;

   //Button
   rc1 := rc; rc2 := rc;
   if ( sbDir=SB_Horz ) then begin //HBar
      if (rc.right)<2*bw then  bw := rc.right  div 2;
      rc1.right := rc1.left + bw;
      rc2.left := rc2.right - bw;
      i1:=1;i2:=5;
      if fdown and (scrollpos=SB_LINELeft) then inc(i1);
      if fdown and (scrollpos=SB_LINERight) then inc(i2);
   end else begin// SB_VERT
      if rc.bottom<2*bw then bw := rc.bottom div 2;
      rc1.bottom := rc1.top + bw;
      rc2.top := rc2.bottom - bw;
      i1:=9;i2:=13;
      if fdown and (scrollpos=SB_LINEUP) then inc(i1);
      if fdown and (scrollpos=SB_LINEDown) then inc(i2);
   end;
   obj.DrawSkinMap3( temp.canvas,rc1,fsd.SArrow.map,i1,23);
   obj.DrawSkinMap3( temp.canvas,rc2,fsd.SArrow.map,i2,23);

   if (scrollpos=SB_THUMBTRACK) then
      GetThumb(rc)
   else begin
      thumbtop:=barinfo.xyThumbTop;
      thumbBottom:=barinfo.xyThumbBottom;
   end;
//      thumbtop:=barinfo.xyThumbTop;
//      thumbBottom:=barinfo.xyThumbBottom;

   i1:=1;
   if fdown and (scrollpos=SB_THUMBTRACK) then
      inc(i1);

   if ( sbDir=SB_VERT ) then begin
        rc1:=Rect(0,thumbtop,swidth,thumbbottom);
        DrawRect2(temp.canvas.handle,rc1,fsd.VSlider.map,
                   fsd.Vslider.r,i1,fsd.Hslider.frame,fsd.hslider.trans)
   end else begin// SB_HORZ
        rc1:=Rect(thumbtop,0,thumbbottom,swidth);
        DrawRect2(temp.canvas.handle,rc1,fsd.HSlider.map,
                   fsd.Hslider.r,i1,fsd.Hslider.frame,fsd.hslider.trans)
   end;


   StretchBlt(canvas.Handle,0,0,temp.width,temp.height,
                 temp.Canvas.Handle ,0 ,0 ,temp.width,temp.height,Srccopy);
   temp.free;
end;}

constructor TSkinScrollbar.Create(AOwner: TComponent);
begin
  inherited create(aowner);
  hb := nil;
  vb := nil;
  sizing := false;
  border := false;
  kind := 0;
  nobe := true;
end;

destructor TSkinScrollbar.Destroy;
begin
//   if control=nil then begin
  if hb <> nil then
    hb.free;
  if vb <> nil then
    vb.free;
  hb := nil;
  vb := nil;
//   end;
  inherited;
end;

procedure TSkinScrollbar.InitScrollbar(acontrol: Twincontrol; sd: TSkinData; acanvas: TCanvas; sf: Tcomponent);
var
  s: string;
  PropInfo: PPropInfo;
begin
  fsd := sd;
  skinform := sf;
  control := acontrol;
  hwnd := control.handle;
  painted := (Win32Platform = VER_PLATFORM_WIN32_NT) and (Win32MajorVersion >= 5) and (Win32MinorVersion >= 1);

  Twinskinform(skinform).addcontrollist(self);
  s := lowercase(GetEnumProperty(control, 'BorderStyle'));
  if s <> 'bsnone' then border := true;
  if control <> nil then s := control.classname;
  if s = 'TImageScrollBox' then border := false;

  if kind = 1 then border := false;

  PropInfo := GetPropInfo(control, 'FixedColor');
  if (PropInfo <> nil) and
    (propinfo^.PropType^.Kind = tkInteger) then begin
    oldcolor := Tcolor(GetOrdProp(control, PropInfo));
    newcolor := true;
    SetProperty(control, 'FixedColor', inttostr(fsd.colors[csbuttonface]));
  end;

  hb := TWscrollbar.create(self);
  hb.attach(self, control, sb_horz);
  vb := TWscrollbar.create(self);
  vb.attach(self, control, sb_vert);
  hb.Enabled := control.Enabled;
  vb.Enabled := control.Enabled;
  if not control.Visible then begin
    vb.HideScrollbar;
    hb.HideScrollbar;
  end;
  OldWndProc := Control.WindowProc;
  Control.WindowProc := NewWndProc;
end;

procedure TSkinScrollBar.SkinChange;
var
  s: string;
  PropInfo: PPropInfo;
begin
//   inherited Skinchange;
  PropInfo := GetPropInfo(control, 'FixedColor');
  if (PropInfo <> nil) and
    (propinfo^.PropType^.Kind = tkInteger) then begin
    oldcolor := Tcolor(GetOrdProp(control, PropInfo));
    newcolor := true;
    SetProperty(control, 'FixedColor', inttostr(fsd.colors[csbuttonface]));
  end;
end;

procedure TSkinScrollBar.SetScrollbarPos(message: TMessage);
begin
  if hb <> nil then hb.SetPosition(hwnd);
  if vb <> nil then vb.SetPosition(hwnd);
end;

procedure TSkinScrollBar.DrawBorder(dc: HDC; rc: TRect);
var
  r, r1: Trect;
  acolor: Tcolor;
  c1: Tcolor;
  b1, b2: HBRUSH;
  s: string;
begin
  r1 := rc;
  B1 := CreateSolidBrush(fsd.colors[csButtonShadow]);
//   B1:=CreateSolidBrush(fsd.colors[csButtonDkshadow]);
  FrameRect(dc, r1, b1);

  c1 := fsd.colors[csButtonface];       //clwhite;
  B2 := CreateSolidBrush(c1);
  InflateRect(r1, -1, -1);
  FrameRect(dc, r1, b2);

  deleteobject(B2);
  deleteobject(B1);
end;

procedure TSkinScrollBar.DrawControl(dc: HDC; rc: TRect);
var
  r: Trect;
  style: dword;
begin
//   painted:=true;
  style := GetWindowLong(hWnd, GWL_STYLE);
  if (vb <> nil) then begin
    if vb.sbvisible then vb.Invalidate
    else if (style and ws_vscroll) > 0 then
      vb.SetPosition(hwnd);
  end;
  if (hb <> nil) then begin
    if hb.sbvisible then hb.Invalidate
    else if (style and ws_hscroll) > 0 then
      hb.SetPosition(hwnd);
  end;
  if (vb <> nil) and (hb <> nil) and vb.sbvisible and hb.sbvisible then begin
    r := rect(vb.sbRect.left + 2, hb.sbRect.top + 2, vb.sbRect.right + 2, hb.sbRect.bottom + 2);
    FillBG(dc, r);
  end;
//   if border then drawborder(dc,rc);
end;

procedure TSkinScrollbar.BENCPAINT(adc: HDC);
var
  rc: TRect;
begin
  if GetWindowRect(hWnd, rc) then begin;
    try
      OffsetRect(rc, -rc.left, -rc.top);
      DrawBorder(adc, rc);
    except
    end;
  end;
end;

function TSkinScrollbar.BeforeProc(var Message: TMessage): boolean;
var
  DC: HDC;
begin
  case message.msg of
    WM_NCPAINT:
      begin
        if border then begin
          default(message);
          DC := GetWindowDC(Control.Handle);
          BENCPaint(DC);
          ReleaseDC(Control.Handle, DC);
          Result := False;
        end else result := true;
      end
  else result := inherited beforeProc(message);
  end;
end;

procedure TSkinScrollbar.AfterProc(var Message: TMessage);
var
  s: string;
  dwstyle: dword;
begin
{$IFDEF scrollbartest}
  s := MsgtoStr(message);
  if s <> '' then fsd.DoDebug('Scrollbar ' + s);
{$ENDIF}
  case message.msg of
    CM_VISIBLECHANGED: begin
        if message.wParam = 0 then begin
          vb.HideScrollbar;
          hb.HideScrollbar;
        end else begin
          SetScrollbarPos(message);
        end;
      end;
    CM_ENABLEDCHANGED: begin
        hb.Enabled := control.Enabled;
        vb.Enabled := control.Enabled;
      end;
    CM_RECREATEWND: begin
        if (control <> nil) and (skinform <> nil) then
          postmessage(Twinskinform(skinform).hwnd, CN_ReCreateWnd, hwnd, 0);
      end;
    WM_Size, WM_WINDOWPOSCHANGED: begin
        sizing := true;
        SetScrollbarPos(message);
          //invalidate;
      end;
    WM_VSCROLL: begin
        vb.scrollpos := message.WParamLo;
        vb.Invalidate;
      end;
    WM_HSCROLL: begin
        hb.scrollpos := message.WParamLo;
        hb.Invalidate;
      end;
    WM_MOUSEWHEEL: begin
        if (vb <> nil) and vb.sbvisible then vb.Invalidate;
        if (hb <> nil) and hb.sbvisible then hb.Invalidate;
      end;
    CM_BENCPAINT: begin
        if Message.LParam = BE_ID then begin
          if Message.WParam <> 0 then begin
            BENCPAINT(Message.WParam);
          end;
          Message.Result := BE_ID;
        end;
      end;
  else inherited Afterproc(message);
  end;
end;

procedure TSkinScrollBar.Unsubclass;
begin
  if newcolor then
    SetProperty(control, 'FixedColor', inttostr(oldcolor));
  newcolor := false;
  inherited unsubclass;
  if skinstate <> skin_deleted then begin
    if hb <> nil then hb.free;
    hb := nil;
    if vb <> nil then vb.free;
    vb := nil;
  end else begin
  end;
end;

constructor TComboxScrollBar.Create(AOwner: TComponent);
begin
  inherited create(aOwner);
  control := nil;
  cw := GetSystemMetrics(SM_CXHSCROLL);
end;

destructor TComboxScrollBar.Destroy;
begin
  inherited destroy;
end;

procedure TComboxScrollBar.AfterProc(var Message: TMessage);
begin
  case message.msg of
    WM_NCPaint: begin
        PaintControl;
      end;
    WM_HSCROLL: begin
        PaintControl;
      end;
    WM_VSCROLL: begin
        PaintControl;
      end;
    $1AE: paintcontrol;
  else inherited AfterProc(message);
  end;
end;

function TComboxScrollBar.WMNCPaint(var message: TMessage): boolean;
var
  style: Dword;
begin
{   style:=GetWindowLong(hWnd,GWL_STYLE);
   if  (style and WS_VSCROLL) >0 then begin
      style := style and (not WS_VSCROLL);
      SetWindowLong(hWnd,GWL_STYLE,style);
      default(message);
      style := style or WS_VSCROLL;
      SetWindowLong(hWnd,GWL_STYLE,style);
      paintcontrol(message.WParam);
   end else begin
      default(message);
   end;      }
//   result:=false;
  result := true;
end;

function TComboxScrollBar.BeforeProc(var Message: TMessage): boolean;
var
  s: string;
begin
{$IFDEF combox}
  s := MsgtoStr(message);
  if s <> '' then begin
    s := format('ComboxScrollbar %s %1x %1x', [s, message.msg, message.wparam, message.lparam]);
  end else begin
    s := format('ComboxScrollbar %1x %1x %1x', [message.msg, message.wparam, message.lparam]);
  end;
  skinaddlog(s);
{$ENDIF}
  case message.msg of
    WM_NCMouseMove: begin
        if message.wparam in [HTVSCROLL, HTHSCROLL] then
          result := false;
      end;
    WM_NCPAINT: begin
        result := WMNCPaint(message);
      end;
    WM_NCLButtonDown: begin
        if NCLButtonDown(message) then result := false
        else result := true;
      end;
  else result := inherited BeforeProc(message);
  end;
end;

function TComboxScrollBar.NCLButtonDown(var Message: TMessage): boolean;
var
  p0, p: Tpoint;
  msgid: longword;
  pos: integer;
  barinfo: tagScrollBarInfo;
  b: boolean;
  bar: integer;
  bw: integer;
  trackpos, inloop: boolean;
  Msg: TMsg;
  x, x0, maxx, minx, oldpos, oldthumb, xthumb: integer;
  si: SCROLLINFO;
begin
  result := false;
  if message.wparam <> HTVSCROLL then exit;

  fillchar(barinfo, sizeof(barinfo), #0);
  barinfo.cbSize := SizeOf(barinfo);
  P := point(message.LParamLo, message.LParamhi);
  if (message.wParam = HTHSCROLL) then begin
    msgid := WM_HSCROLL;
    bar := SB_Horz;
    b := fsd.GetScrollBarInfo(hwnd, OBJID_HSCROLL, barinfo);
  end else if (message.wParam = HTVSCROLL) then begin
    msgid := WM_VSCROLL;
    bar := SB_Vert;
    b := fsd.GetScrollBarInfo(hwnd, OBJID_VSCROLL, barinfo);
  end;

  if not b then exit;

  if bar = SB_Horz then x := p.x - barinfo.rcScrollBar.left
  else x := p.y - barinfo.rcScrollBar.top;

  if (x < barinfo.xyThumbTop) or (x > barinfo.xyThumbBottom) then exit;
    //drag thumb

  SetCapture(hwnd);
  GetCursorPos(p0);

  si.cbSize := sizeof(SCROLLINFO);
  si.fMask := SIF_ALL;

  GetScrollInfo(hWnd, bar, si);

  oldpos := si.nPos;
  oldthumb := barinfo.xyThumbTop - cw;
  x0 := oldpos;
  maxx := (barinfo.rcScrollBar.Bottom - barinfo.rcScrollBar.Top) - 2 * cw;
  bw := (barinfo.xyThumbBottom - barinfo.xyThumbTop);
  SetCapture(hwnd);

  trackpos := true;
  repeat
    if PeekMessage(Msg, 0, 0, 0, PM_REMOVE) then begin
      case Msg.message of
        WM_Mousemove, WM_NCMouseMove: begin
            TranslateMessage(Msg);
            DispatchMessage(Msg);
            GetCursorPos(p);
            if (bar = SB_Vert) then begin
              xthumb := oldthumb + p.y - p0.y;
            end else begin
              xthumb := oldthumb + p.x - p0.x;
            end;
            if xthumb < 0 then xthumb := 0;

            if si.npage = 0 then begin
              if xthumb > maxx - bw then xthumb := maxx - bw;
              x := muldiv(xthumb, (si.nMax - si.nmin), maxx) + si.nmin;
              if x > si.nmax then x := si.nmax;
            end else begin
              if xthumb > (maxx - bw) then xthumb := maxx - bw + 1;
              x := muldiv(xthumb, (si.nmax - si.nmin - si.nPage), maxx - bw) + si.nmin;
//               if x>si.nMax-si.nMin-si.nPage-4 then
//               fsd.DoDebug(format('thumb %1d x %1d max %1d',[xthumb,x,si.nMax]));
              if x >= (si.nmax - si.npage) then
                x := si.nmax - si.npage + 1;
            end;

            if x < si.nmin then x := si.nmin;
            if x <> x0 then begin
              si.fMask := SIF_POS;
              si.npos := x;
              si.nTrackPos := x;
//                si.thumbpos:=xthumb;
//                SetScrollInfo(hwnd,bar,si,false);
              sendmessage(hwnd, msgid, MAKEWPARAM(SB_THUMBTRACK, x), 0);
            end;
            x0 := x;
          end;
        WM_NCLBUTTONUP, WM_LBUTTONUP: begin
//              setscrollbar(true,sp[bar].MsgID);
            trackpos := false;
            sendmessage(hwnd, msgid, MAKEWPARAM(SB_THUMBPOSITION, x), 0);
            postmessage(hwnd, msgid, SB_ENDSCROLL, 0);
          end;
      else
        TranslateMessage(Msg);
        DispatchMessage(Msg);
      end;
    end;
  until not trackpos;
  ReleaseCapture;
  result := true;
end;

procedure TComboxScrollBar.Unsubclass;
begin
  inherited unsubclass;
end;

procedure TComboxScrollBar.GetThumb(rc: TRect);
var
  p: Tpoint;
  size: integer;
begin
  GetCursorPos(p);
  size := thumbbottom - thumbtop;
  thumbtop := trackthumb;
  if (sbDir = sb_Vert) then
    inc(thumbtop, p.Y - trackp.y)
  else
    inc(thumbtop, p.x - trackp.x);

  if thumbtop < cw then thumbtop := cw;
  if thumbtop > Len - cw - size then thumbtop := Len - cw - size;
  thumbbottom := thumbtop + size;
end;

//paint two bar,check two bar

procedure TComboxScrollBar.DrawControl(dc: HDC; rc: TRect);
begin
  paintscrollbar(dc, rc, SB_Vert);
end;

procedure TComboxScrollBar.PaintScrollbar(dc: HDC; rc: TRect; sbtype: integer);
var
  rc1, rc2, rr, rr2, rr1: TRect;
  p: Tpoint;
  b, sbenable: boolean;
  temp: TBitmap;
  bw, i1, i2, swidth, n: integer;
  _width, _height: integer;
  barinfo: tagScrollBarInfo;
begin
//   if not sbvisible then exit;
  if (fsd.SArrow = nil) or fsd.sarrow.map.empty then exit;
  GetWindowRect(hwnd, rr1);
  _width := rr1.Right - rr1.Left;
  _height := rr1.Bottom - rr1.Top;
  fillchar(barinfo, sizeof(barinfo), #0);
  barinfo.cbSize := SizeOf(barinfo);
  if sbtype = SB_VERT then begin
    b := fsd.GetScrollBarInfo(hwnd, OBJID_VSCROLL, barinfo);
  end else if sbtype = SB_Horz then begin
    b := fsd.GetScrollBarInfo(hwnd, OBJID_HSCROLL, barinfo);
  end;

  if not b then exit;                   //recreatewnd
  if (barinfo.rgstate[0] and STATE_SYSTEM_INVISIBLE) > 0 then exit;

  if (barinfo.rgstate[0] and STATE_SYSTEM_UNAVAILABLE) > 0 then
    sbEnable := false
  else sbEnable := true;

  bw := cw;
  rr := barinfo.rcScrollBar;
  rr2 := rr;
//   _width:= rr.Right-rr.Left;
//   _height:= rr.Bottom-rr.Top;
  offsetrect(rr, -rr.left, -rr.top);
  if (rr.Bottom < 0) or (rr.Right < 0) then exit;

  if (rr.Bottom > _height) or (rr.Right > _width) then exit;

  if sbtype = SB_vert then len := rc.Bottom
  else len := rc.Right;

  swidth := fsd.SArrow.map.height;
   //swidth
  if abs(swidth - cw) > 2 then swidth := cw;

  if sbtype = SB_vert then rr.Right := swidth
  else rr.Bottom := swidth;

  temp := Tbitmap.create;

  try
    temp.width := rr.Right;
    temp.height := rr.Bottom;
  except
    temp.Free;
    exit;
  end;

  SetStretchBltMode(temp.canvas.handle, STRETCH_DELETESCANS);
  temp.canvas.brush.color := fsd.colors[csbuttonface];
  temp.canvas.fillrect(rr);
   //for ws_vscroll ws_hscroll
//   if sbtype<>SB_CTL then begin
//     if sbDir=sb_Horz then rc.bottom:=swidth
//     else rc.right:=swidth;
//   end;

  rc1 := rr;
  i1 := 1;
  if not sbEnable then i1 := 3;
  if sbtype = SB_Horz then begin
    rc1.left := rc1.left + bw;
    rc1.right := rc1.right - bw;
    DrawRect2(temp.canvas.handle, rc1, fsd.HBar.map,
      fsd.HBar.r, i1, 4, fsd.hbar.trans, fsd.hbar.tile);
  end else begin
    rc1.top := rc1.top + bw;
    rc1.bottom := rc1.bottom - bw;
    DrawRect2(temp.canvas.handle, rc1, fsd.VBar.map,
      fsd.VBar.r, i1, 4, fsd.vbar.trans, fsd.hbar.tile);
  end;

   //Button
  rc1 := rr;
  rc2 := rr;
  if (sbtype = SB_Horz) then begin      //HBar
    if (rc.right) < 2 * bw then bw := rc.right div 2;
    rc1.right := rc1.left + bw;
    rc2.left := rc2.right - bw;
    i1 := 1;
    i2 := 5;
  end else begin                        // SB_VERT
    if rc.bottom < 2 * bw then bw := rc.bottom div 2;
    rc1.bottom := rc1.top + bw;
    rc2.top := rc2.bottom - bw;
    i1 := 9;
    i2 := 13;
//      if fdown and (scrollpos=SB_LINEUP) then inc(i1);
//      if fdown and (scrollpos=SB_LINEDown) then inc(i2);
  end;
  if (scrollpos = SB_LINELeft) then begin
    if fdown then inc(i1)
    else inc(i1, 3);
  end;
  if (scrollpos = SB_LINERight) then begin
    if fdown then inc(i2)
    else inc(i2, 3);
  end;
  DrawSkinMap3(temp.canvas, rc1, fsd.SArrow.map, i1, 23);
  DrawSkinMap3(temp.canvas, rc2, fsd.SArrow.map, i2, 23);

  if fdown and (scrollpos = SB_THUMBTRACK) then
    GetThumb(rr)
  else begin
    thumbtop := barinfo.xyThumbTop;
    thumbBottom := barinfo.xyThumbBottom;
  end;

  i1 := 1;
  if (scrollpos = SB_THUMBTRACK) then begin
    if fdown then inc(i1)
    else inc(i1, 2);
  end;
  if sbEnable then begin
    if (sbtype = SB_VERT) then begin
      i2 := 20;
      rc1 := Rect(0, thumbtop, swidth, thumbbottom);
      if (thumbtop < _Height) and (thumbbottom < _Height) then
        DrawRect2(temp.canvas.handle, rc1, fsd.VSlider.map,
          fsd.Vslider.r, i1, fsd.Hslider.frame, fsd.hslider.trans)
    end else begin                      // SB_HORZ
      i2 := 17;
      rc1 := Rect(thumbtop, 0, thumbbottom, swidth);
      if (thumbtop < _Width) and (thumbbottom < _Width) then
        DrawRect2(temp.canvas.handle, rc1, fsd.HSlider.map,
          fsd.Hslider.r, i1, fsd.Hslider.frame, fsd.hslider.trans)
    end;
    if (scrollpos = SB_THUMBTRACK) then begin
      if fdown then inc(i2)
      else inc(i2, 2);
    end;
    bw := fsd.SArrow.map.Height;
    if (thumbbottom - thumbtop + 2) > bw then begin
      n := (thumbbottom - thumbtop - bw) div 2;
      if (sbtype = SB_VERT) then begin
        rc2 := Rect(0, thumbtop + n, swidth, thumbtop + n + bw);
        if (rc2.Top < _Height) and (rc2.Bottom < _Height) then
          DrawSkinMap3(temp.canvas, rc2, fsd.SArrow.map, i2, 23);
      end else begin
        rc2 := Rect(thumbtop + n, 0, thumbtop + n + bw, swidth);
        if (rc2.left < _Width) and (rc2.Right < _Width) then
          DrawSkinMap3(temp.canvas, rc2, fsd.SArrow.map, i2, 23);
      end;
    end;
  end;

  StretchBlt(Dc, rr2.Left - rr1.Left, rr2.Top - rr1.Top, temp.width, temp.height,
    temp.Canvas.Handle, 0, 0, temp.width, temp.height, Srccopy);

  temp.free;
end;

constructor TSkinScrollbarH.Create(AOwner: TComponent);
begin
  inherited create(aowner);
  hb := nil;
  vb := nil;
end;

destructor TSkinScrollbarH.Destroy;
begin
  if hb <> nil then hb.free;
  if vb <> nil then vb.free;
  hb := nil;
  vb := nil;
  inherited;
end;

procedure TSkinScrollbarH.InitHwnd(ahwnd: Thandle; sd: TSkinData; acanvas: TCanvas; sf: Tcomponent);
begin
  skinform := sf;
  fsd := sd;
  fCanvas := acanvas;
  hwnd := ahwnd;
  control := nil;
  Twinskinform(skinform).addcontrollist(self);

  hb := TWscrollbar.create(self);
  hb.attachhwnd(self, hwnd, sb_horz);
  vb := TWscrollbar.create(self);
  vb.attachhwnd(self, hwnd, sb_vert);

  FObjectInst := MakeObjectInstance(NewWndProc);
  FPrevWndProc := Pointer(GetWindowLong(hwnd, GWL_WNDPROC));
  SetWindowLong(hwnd, GWL_WNDPROC, LongInt(FObjectInst));

  skinstate := skin_active;
end;

procedure TSkinScrollBarH.SetScrollbarPos(message: TMessage);
begin
  if hb <> nil then hb.SetPosition(hwnd);
  if vb <> nil then vb.SetPosition(hwnd);
end;

procedure TSkinScrollbarH.AfterProc(var Message: TMessage);
var
  s: string;
begin
  if not IsWindowVisible(hwnd) then
    vb.HideScrollbar;
  case message.msg of
//       WM_NCPaint:begin
    WM_Size, WM_NCPaint: begin
        SetScrollbarPos(message);
        invalidate;
      end;
    WM_VSCROLL: begin
        if vb <> nil then begin
          vb.scrollpos := message.WParamLo;
          vb.Invalidate;
        end;
      end;
    WM_HSCROLL: begin
        if hb <> nil then begin
          hb.scrollpos := message.WParamLo;
          hb.Invalidate;
        end;
      end;
  else inherited Afterproc(message);
  end;
end;

procedure TSkinScrollBarH.Unsubclass;
begin
  inherited unsubclass;
  if skinstate <> skin_deleted then begin
    if hb <> nil then hb.free;
    hb := nil;
    if vb <> nil then vb.free;
    vb := nil;
  end;
end;

procedure TSkinScrollBarH.DrawControl(dc: HDC; rc: TRect);
var
  r: Trect;
begin
  if (vb <> nil) and vb.sbvisible then vb.Invalidate;
  if (hb <> nil) and hb.sbvisible then hb.Invalidate;
  if (vb <> nil) and (hb <> nil) and vb.sbvisible and hb.sbvisible then begin
    r := rect(vb.sbRect.left, hb.sbRect.top, vb.sbRect.right + 2, hb.sbRect.bottom + 2);
    FillBG(dc, r);
  end;
end;

procedure TSkinHeader.Inithwnd(ahwnd: Thandle; sd: TSkinData; acanvas: TCanvas; sf: Tcomponent);
begin
  inherited InitHwnd(ahwnd, sd, acanvas, sf);
  indexitem := -1;
//   trackinfo.cbSize:=16;
//   trackinfo.hwndTrack:=ahwnd;
//   trackinfo.dwFlags:=2;
//   Twinskinform(owner).addcontrollist(self);
end;

procedure TSkinHeader.Init(sf: Tcomponent; sd: TSkinData; acanvas: TCanvas; acolor: boolean = false);
begin
  inherited init(sf, sd, acanvas, acolor);
  indexitem := -1;
end;

destructor TSkinHeader.Destroy;
begin
  setlength(items, 0);
  inherited destroy;
end;

function TSkinHeader.BeforeProc(var Message: TMessage): boolean;
var
  s: string;
begin
  result := true;
{$IFDEF headertest}
  case message.msg of
    WM_Notify: begin
        s := 'HeaderControl WM_Notify ' + inttostr(TWMNotify(message).NMHdr^.code);
      end;
  else s := MsgtoStr(message);
  end;
  if s <> '' then skinaddlog('HeaderControl ' + s);
{$ENDIF headertest}

  case message.msg of
    WM_ERASEBKGND:
      if (fsd.header <> nil) and (not fsd.header.map.empty) then begin
//          ERASEBKGND(message.wparam);
        message.result := 1;
        result := false;
      end;
    wm_paint: begin
        wmpaint(message);
        result := false;
      end;
  else result := inherited beforeproc(message);
  end;
end;

procedure TSkinHeader.WMMouseMove(var Message: TMessage);
var
  i: integer;
  p: Tpoint;
begin
  P := point(Message.LParamLo, Message.LParamhi);
  for i := 0 to high(items) do begin
    if PtInRect(items[i], p) and (i <> indexitem) then begin
      indexitem := i;
      invalidate;
//         fsd.DoDebug('hower:'+inttostr(i));
    end;
  end;
  WinSkinData.DoTrackMouse(hwnd);
end;

procedure TSkinHeader.AfterProc(var Message: TMessage);
var
  trackinfo: TTrackMouseEvent;
begin
  case message.msg of
    WM_MOUSEMOVE: WMMouseMove(message);
    WM_MOUSELEAVE: begin
        indexitem := -1;
        invalidate;
      end;
  else inherited Afterproc(message);
  end;
end;

procedure TSkinHeader.DrawControl(dc: HDC; rc: TRect);
var
  r1: TRect;
  i, n, x: integer;
  bfont, cfont: Hfont;
  temp, temp2: Tbitmap;
  imglist: Himagelist;
begin
  if (fsd.header = nil) or (fsd.header.map.empty) then exit;

  x := 0;
  temp := Tbitmap.create;
  temp.width := rc.right - rc.left;
  temp.height := rc.bottom - rc.top;
  bfont := sendmessage(hwnd, wm_getfont, 0, 0);
  enabled := true;

//   temp.canvas.Font.Color := fsd.colors[csButtonText];
//   temp.canvas.Font.style := [];
  cfont := selectobject(temp.canvas.handle, bfont);

  SetBkMode(temp.canvas.Handle, TRANSPARENT);

  imglist := sendmessage(hwnd, HDM_GETIMAGELIST, 0, 0);
  n := Header_GetItemCount(hwnd);
  SetLength(items, n);
  for i := 0 to n - 1 do begin
    if Header_GetItemRect(hwnd, i, @r1) <> 0 then begin
      drawitem(imglist, temp.canvas, r1, i);
      Items[i] := r1;
      InflateRect(Items[i], -3, 0);
      if x < r1.right then x := r1.right;
    end;
  end;
  if x < rc.right then begin
    r1 := rect(x, rc.top, rc.right, rc.bottom);
    temp2 := GetHMap(r1, fsd.header.map, fsd.header.r, 1,
      fsd.header.frame, fsd.header.tile);
    temp.canvas.draw(r1.left, r1.top, temp2);
    temp2.free;
  end;
  BitBlt(dc, rc.left, rc.top, rc.right - rc.left, rc.bottom - rc.top,
    temp.Canvas.Handle, 0, 0, Srccopy);
  selectobject(temp.canvas.handle, cfont);
  temp.free;
end;

procedure TSkinHeader.DrawItemImgCaption(acanvas: TCanvas; rc: TRect;
  ImgList: hImageList; imgIndex: integer; text: widestring; talign: integer = DT_CENTER);
var
  imgrect, textrect, r1, r2: TRect;
  DrawStyle: Longint;
  h, w, margin: integer;
begin
  ImageList_GetIconSize(ImgList, w, h);
  if (imgindex <> -1) and (ImgList <> 0) and ((rc.Right - rc.left) > w) then begin
    imgrect := rect(0, 0, w, h);
  end else begin
    imgrect := rect(0, 0, 0, 0);
    w := 0;
  end;
      //DrawStyle:= DrawStyle or dt_WordBreak ;
  DrawStyle := DT_END_ELLIPSIS or DT_EXPANDTABS; //DT_SINGLELINE;// or DT_CENTER;
  textrect := rc;
  if (ImgList <> 0) and (imgindex <> -1) then dec(textrect.right, -(2 + w));
  if Length(Text) > 0 then
    TNT_DrawTextw(acanvas.Handle, Text, textrect, DrawStyle or DT_CALCRECT or DT_NOCLIP)
//     DrawText(acanvas.Handle,PChar(Text),Length(Text),textrect,DrawStyle or DT_CALCRECT or DT_NOCLIP)
  else textrect.right := textrect.left;
  offsetrect(imgrect, rc.left, rc.top);

  case talign of
    DT_CENTER:
      margin := (rc.right - rc.left - w - (textrect.right - textrect.left)) div 2;
    DT_Left:
      margin := 3;
    DT_right:
      margin := (rc.right - rc.left - w - (textrect.right - textrect.left)) - 2;
  end;
  if margin < 2 then margin := 1;
  offsetrect(imgrect, margin, (rc.bottom - rc.top - w) div 2);
  OffsetRect(textrect, margin + w,
    ((rc.Bottom - rc.Top) - (textrect.Bottom - textrect.Top)) div 2);

  if (ImgList <> 0) and (ImgIndex <> -1) then
    ImageList_Draw(imglist, ImgIndex, ACanvas.handle,
      imgrect.Left, imgrect.Top, ILD_TRANSPARENT);

  if Length(Text) = 0 then exit;

  SetBkMode(aCanvas.Handle, TRANSPARENT);
  ACanvas.Brush.Style := bsClear;
  ACanvas.font.style := [];

  if fsd.hasColors[csText] then
    ACanvas.Font.Color := fsd.colors[csText];

  if not enabled then ACanvas.Font.Color := clBtnShadow;
  if textrect.Left < rc.Left then textrect.Left := rc.Left;
  if textrect.right > rc.right then textrect.right := rc.right;
  DrawStyle := CheckBiDi(DrawStyle);
//   DrawText(ACanvas.Handle, PChar(Text),Length(Text),textrect,DrawStyle);
  Tnt_DrawTextW(ACanvas.Handle, Text, textrect, DrawStyle);
end;

procedure TSkinHeader.DrawItem(ImgList: hImageList; acanvas: Tcanvas; rc: Trect; index: Integer);
var
  Item: THDItemW;
  Buffer: array[0..200] of Char;
  temp: Tbitmap;
  text: widestring;
  DrawStyle: Longint;
  imgindex: integer;
  r1: Trect;
  i: integer;
begin
  FillChar(Item, SizeOf(Item), 0);
  FillChar(Buffer, SizeOf(Buffer), 0);
//   Item.pszText:=buffer;
  Item.pszText := Pwidechar(@buffer);
  Item.cchTextMax := SizeOf(Buffer);
  Item.mask := HDI_TEXT or HDI_FORMAT or HDI_IMAGE;
  SendMessage(Hwnd, HDM_GETITEMW, index, Longint(@Item));
  i := 1;
  if index = indexitem then i := 2;
  temp := GetHMap(rc, fsd.header.map, fsd.header.r, i,
    fsd.header.frame, fsd.header.tile);

  text := _Wstr(Item.pszText, -1);
  if text <> '' then begin
    case (item.fmt and $0FF) of
      HDF_CENTER: DrawStyle := DT_CENTER;
      HDF_RIGHT: DrawStyle := DT_Right;
    else DrawStyle := DT_Left;
    end;
    r1 := rc;
    if item.fmt and (LVCFMT_IMAGE or LVCFMT_COL_HAS_IMAGES) = 0 then begin
      item.iImage := -1;
    end;
    offsetrect(r1, -r1.Left, -r1.Top);
      //DrawStyle:= DrawStyle or dt_WordBreak ;
    DrawItemImgCaption(temp.canvas, r1, imglist, item.iImage, text, DrawStyle);
  end;
  BitBlt(acanvas.handle, rc.left, rc.top, rc.right - rc.left, rc.bottom - rc.top,
    temp.Canvas.Handle, 0, 0, Srccopy);
  temp.free;

{  DrawText(dc,PChar(Text),Length(Text),r1,DrawStyle or DT_CALCRECT );
   case DrawStyle of
      DT_CENTER :
         OffsetRect(r1,((rc.right-rc.left)-(r1.right-r1.left)) div 2,
                       ((rc.Bottom-rc.Top)-(r1.Bottom-r1.Top)) div 2);
      DT_Right  :
         OffsetRect(r1, ((rc.right-rc.left)-(r1.right-r1.left)-4),
                      ((rc.Bottom - rc.Top) - (r1.Bottom - r1.Top)) div 2);
      else  OffsetRect(r1, 4,((rc.Bottom - rc.Top) - (r1.Bottom - r1.Top)) div 2);
   end;
   DrawText(dc, PChar(text), -1, r1, Drawstyle);}
end;

procedure TSkinListview.InitScrollbar(acontrol: Twincontrol; sd: TSkinData; acanvas: TCanvas; sf: Tcomponent);
var
  hhwnd: Thandle;
begin
  inherited initScrollbar(acontrol, sd, acanvas, sf);
//    hhwnd := 0 ;
  hhwnd := SendMessage(acontrol.handle, LVM_GETHEADER, 0, 0);
  if hhwnd <> 0 then begin
    header := Tskinheader.create(self.owner);
    header.inithwnd(hhwnd, sd, acanvas, sf);
  end;
end;

{function TSkinListview.BeforeProc(var Message: TMessage):boolean;
begin
    case message.msg of
      WM_Notify: begin
         WMNotify(TWMNotify(message));
//         if (message.result=CDRF_NOTIFYITEMDRAW) //then result:=false;
//            or (message.result=CDRF_SKIPDEFAULT) then result:=false;
      end;
      else  inherited beforeproc(message);
    end;
end; }

procedure TSkinListview.WMNotify(var Message: TWMNotify);
var
  s: string;
begin
  s := '';
  with Message do
    case NMHdr^.code of
//      NM_RELEASEDCAPTURE: s:='NM_RELEASEDCAPTURE '+inttostr(NMHdr^.code);
      NM_CUSTOMDRAW: begin
          s := 'NM_CUSTOMDRAW ';
          with PNMCustomDraw(NMHdr)^ do begin
            case dwDrawStage of
              CDDS_PREPAINT: begin
                  s := s + 'CDDS_PREPAINT ';
                  Result := CDRF_NOTIFYITEMDRAW;
                end;
              CDDS_ITEMPREPAINT: begin
                  s := s + 'CDDS_ITEMPREPAINT ';
//                 result:=CDRF_SKIPDEFAULT;
                end;
            end;
          end;
        end;
      HDN_BEGINDRAG: s := 'Header HDN_BEGINDRAG' + inttostr(NMHdr^.code);
      HDN_ENDDRAG: s := 'Header HDN_ENDDRAG';
      HDN_ITEMCLICKW: s := 'Header HDN_ITEMCLICKW';
    else s := ' WMNotify' + inttostr(NMHdr^.code);
    end;
//  if s<>''  then skinaddlog(s);
end;

procedure TSkinListview.SetHeaderOwnerDraw;
var
  hHeader: THandle;
  hdi: THDItem;
  i: Integer;
  flg: Boolean;
  view: TSkinAcListView;
begin
  if fsd.header = nil then exit;
  if fsd.header.map.empty then exit;

  view := TSkinAcListView(control);

  hHeader := SendMessage(hwnd, LVM_GETHEADER, 0, 0);

  flg := False;

  for i := 1 to view.Columns.Count do begin
    hdi.mask := HDI_FORMAT;
    Header_GetItem(hHeader, i - 1, hdi);
    hdi.mask := HDI_FORMAT;
    if hdi.fmt <> HDF_OWNERDRAW then
      Flg := True;
    hdi.fmt := HDF_OWNERDRAW;
    Header_SetItem(hHeader, i - 1, hdi);
  end;
end;

procedure TSkinListview.HeaderProc(var Message: TMessage);
begin
  case message.msg of
{       WM_DRAWITEM: begin
          if (TWMDrawItem(Message).DrawItemStruct^.CtlType = ODT_HEADER) then         begin
//              DrawHeaderItem(TWMDrawItem(Message).DrawItemStruct^);
//             done:=true;
//             Message.Result := 0;
          end;
       end;   }
    WM_ERASEBKGND:
      if (fsd.header <> nil) and (not fsd.header.map.empty) then begin
//          ERASEBKGND(message.wparam);
        message.result := 1;
        done := true;
      end;
{      WM_Paint:
        if (fsd.header<>nil) and (not fsd.header.map.empty) then begin
//          ERASEBKGND(message.wparam);
          Drawheader;
          message.result:=0;
          done:=true;
      end;}
  else with message do
      Result := CallWindowProc(FDefHeaderProc, hhwnd, Msg, WParam, LParam);
  end;
end;

procedure TSkinListview.DrawHeaderItem(DrawItemStruct: TDrawItemStruct);
const
  LV_MAX_COLS = 255;
var
  s, anchor, stripped: string;
  ali: DWord;
  xsize, ysize: Integer;
  vcenter, iCount, ID: Integer;
  parr: array[0..LV_MAX_COLS] of Integer;
  view: TSkinAcListView;
  r1: Trect;

  function Min(a, b: Integer): Integer;
  begin
    if a > b then
      Result := b
    else
      Result := a;
  end;

begin
  for iCount := 0 to LV_MAX_COLS do
    parr[iCount] := iCount;

  view := TSkinAcListView(control);
  iCount := view.Columns.count;
  SendMessage(Hwnd, LVM_GETCOLUMNORDERARRAY, iCount, longint(@parr));

  with DrawItemStruct do begin
    if (Integer(itemID) < view.Columns.Count) then begin
      s := view.Columns[parr[itemID]].Caption;

      fCanvas.Handle := hDC;
      fCanvas.Brush.Color := clwhite;
      r1 := rcitem;
//      Inflaterect(r1,2,2);
//      offsetrect(r1,-1,-1);
//      fCanvas.Fillrect(r1);
{      Inflaterect(rcitem,-2,-1);

      case Columns[itemID].Alignment of
      taLeftJustify:ali := DT_LEFT;
      taCenter:ali := DT_CENTER;
      taRightJustify:ali := DT_RIGHT;
      else
        ali := 0;
      end;}
    end;
  end;
end;

procedure TSkinListview.Drawheader;
var
  dc: HDC;
  rc, r1: TRect;
  view: TSkinAcListView;
  i, x: integer;
begin
  if not GetWindowRect(hhWnd, rc) then exit;
  OffsetRect(rc, -rc.left, -rc.top);
  DC := GetWindowDC(hhWnd);
  view := TSkinAcListView(control);
  x := 1;
  for i := 0 to view.Columns.count - 1 do begin
    r1 := rect(x, rc.top, x + view.columns[i].width, rc.bottom);
    drawitem(dc, r1, view.columns[i]);
    x := x + view.columns[i].width;
  end;
  if x < rc.right then begin
    r1 := rect(x, rc.top, rc.right, rc.bottom);
    drawitem(dc, r1, nil);
  end;
  ReleaseDC(hhwnd, DC);
end;

procedure TSkinListview.drawitem(dc: HDC; rc: TRect; acolumn: TListColumn);
const
  Alignments: array[TAlignment] of Longint = (DT_LEFT, DT_RIGHT, DT_CENTER);
var
  temp: TBitmap;
  FontHeight: Integer;
  Flags: Longint;
  acolor: Tcolor;
begin
  if (rc.right < rc.left) or (rc.bottom < rc.top) then exit;
  temp := GetHMap(rc, fsd.header.map, fsd.header.r, 1,
    fsd.header.frame, fsd.statusbar.tile);
  BitBlt(dc, rc.left, rc.top, rc.right - rc.left, rc.bottom - rc.top,
    temp.Canvas.Handle, 0, 0, Srccopy);
  temp.free;
  if acolumn = nil then exit;
{    if text='' then exit;
  with fCanvas do begin
    SetBkMode(Handle, TRANSPARENT);
    Font := TAcControl(control).Font;
    font.style:=[];
    FontHeight := TextHeight('W');
    if (fsd.GetPrecolor(acolor,fsd.statusbar.normalcolor)) then
          fcanvas.Font.Color:= acolor;
    with rc do  begin
      Top := ((Bottom + Top) - FontHeight) div 2;
      Bottom := Top + FontHeight;
//      left:=left+fsd.statusbar.r.left;
      left:=left+2;
    end;
    Flags := DT_EXPANDTABS or DT_VCENTER or Alignments[Align];
//    Flags := DrawTextBiDiModeFlags(Flags);
    DrawText(Handle, PChar(text), -1, rc, Flags);
  end;}
end;


function TSkinSizer.BeforeProc(var Message: TMessage): boolean;
begin
  result := inherited beforeProc(message);
{    result:=true;
    case message.msg of
      WM_ERASEBKGND: begin
       Message.Result := 0;
       result:=false;
      end;
    else result:=inherited beforeProc(message);
    end;  }
end;

procedure TSkinSizer.DrawControl(dc: HDC; rc: TRect);
var
  b1: HBRUSH;
begin
  B1 := CreateSolidBrush(fsd.colors[csButtonFace]);
  fillRect(dc, rc, b1);
  deleteobject(B1);
end;

procedure TSkinTabsheet.DrawControl(dc: HDC; rc: TRect);
var
  b1: HBRUSH;
begin
  B1 := CreateSolidBrush(fsd.colors[csButtonFace]);
  fillRect(dc, rc, b1);
  deleteobject(B1);
  if control <> nil then
    TAcWincontrol(control).PaintControls(dc, nil);
end;

function TSkinTabsheet.BeforeProc(var Message: TMessage): boolean;
var
  r: Trect;
begin
  result := inherited beforeProc(message);
  case message.msg of
    wm_paint, wm_print:
      if kind = 0 then begin
        wmpaint(message);
        result := false;
      end;
    WM_ERASEBKGND:
      if kind = 0 then begin
        GetClientRect(hwnd, r);
        FillRect(message.wparam, r, fsd.BGbrush);
        message.Result := 1;
        result := false;
      end;
  end;
end;

{Procedure TSkinTabsheet.Init(sf:Tcomponent;sd:TSkinData;acanvas:TCanvas;acolor:boolean=false);
begin
   inherited init(sf,sd,acanvas,acolor);
end;   }

function TSkinBoxH.BeforeProc(var Message: TMessage): boolean;
var
  b1: HBRUSH;
  dc: HDC;
  rc: Trect;
begin
//   inherited beforeProc(message);
  result := true;
  case message.msg of
    WM_ERASEBKGND: begin
        dc := message.WParam;
        GetWindowRect(hWnd, rc);
        offsetrect(rc, -rc.Left, -rc.Top);
        B1 := CreateSolidBrush(fsd.colors[csButtonFace]);
        fillRect(dc, rc, b1);
        deleteobject(B1);
        Message.Result := 0;
        result := false;
      end;
    WM_CTLCOLORSTATIC: begin
        default(message);
        message.Result := fsd.BGBrush;
        result := false;
      end;
  else result := inherited beforeProc(message);
  end;
end;

destructor TSkinScControl.Destroy;
begin
  if sb <> nil then
    sb.free;
  sb := nil;
  inherited;
end;

procedure TSkinScControl.InitScrollbar(acontrol: Twincontrol; sd: TSkinData; acanvas: TCanvas; sf: Tcomponent);
begin
  fsd := sd;
  skinform := sf;
  control := acontrol;
  hwnd := control.handle;

  Twinskinform(skinform).addcontrollist(self);

  sb := TWscrollbar.create(self);
  sb.ShowHint := control.ShowHint;
  sb.Hint := control.Hint;
  sb.attach(self, control, sb_ctl);

  if not control.Visible then begin
    sb.HideScrollbar;
  end;

  OldWndProc := Control.WindowProc;
  Control.WindowProc := NewWndProc;
end;

//       SBM_SETSCROLLINFO: begin

procedure TSkinScControl.AfterProc(var Message: TMessage);
var
  s: string;
  dwstyle: dword;
begin
  case message.msg of
    CM_VISIBLECHANGED: begin
        if message.wParam = 0 then begin
          sb.HideScrollbar;
        end else begin
          if sb <> nil then sb.SetPosition(hwnd);
        end;
      end;
    WM_WINDOWPOSCHANGED: begin
        if sb <> nil then sb.SetPosition(hwnd);
      end;
    WM_NCPaint: begin
        if control <> nil then
          hwnd := control.handle;
        if sb <> nil then sb.SetPosition(hwnd);
      end;
    SBM_SETSCROLLINFO: begin
        if sb <> nil then sb.Invalidate;
      end;
    CN_VSCROLL: begin
        if sb <> nil then sb.Invalidate;
      end;
  else inherited Afterproc(message);
  end;
end;

procedure TSkinScControl.DrawControl(dc: HDC; rc: TRect);
begin
  if (sb <> nil) then sb.Invalidate;
end;

procedure TSkinScControl.Unsubclass;
begin
  inherited unsubclass;
  if skinstate <> skin_deleted then begin
    if sb <> nil then sb.free;
    sb := nil;
  end;
end;

{procedure TSkinSceControl.InitScrollbar(acontrol:Twincontrol;ascrollbar:Tcontrol;aType:integer;
              sd:TSkinData;sf:Tcomponent);
begin
   fsd:=sd;
   skinform:=sf;
   control:=nil;
   scecontrol := ascrollbar;
   hwnd:=0;

   Twinskinform(skinform).addcontrollist(self);
   sb:=TEscrollbar.create(owner);
   sb.attach(self,acontrol,ascrollbar,atype);

   OldWndProc:= scecontrol.WindowProc;
   scecontrol.WindowProc := NewWndProc;
end;

procedure TSkinSceControl.AfterProc(var Message: TMessage);
var s:string;
begin
    case message.msg of
       wm_Lbuttondown:begin
           if sb.fdown then sb.buttonup;
         end;
       WM_NCPaint:begin
          if control<>nil then
             hwnd := control.handle;
          if sb<>nil then sb.SetPosition;
       end;
       SBM_SETSCROLLINFO:begin
          if sb<>nil then sb.Invalidate;
       end;
       WM_WINDOWPOSCHANGED : begin
          if sb<>nil then sb.SetPosition;
       end;
    else inherited Afterproc(message);
    end;
end;

procedure TSkinSceControl.DrawControl( dc:HDC; rc:TRect);
begin
  if sb<>nil then sb.Invalidate;
end;

procedure TSkinSceControl.Unsubclass;
begin
   inherited unsubclass;
   if assigned(oldwndproc) then begin
         if scecontrol<>nil then sceControl.WindowProc := OldWndProc;
         oldwndproc:=nil;
   end;
   if sb<>nil then sb.free;
   sb:=nil;
end;}

procedure TSkinObjImage.Init(sf: Tcomponent; sd: TSkinData; acanvas: TCanvas; acolor: boolean = false);
begin
  if inited then exit;
  fsd := sd;
  skinform := sf;
  fCanvas := acanvas;
  control := Twincontrol(owner);
  hwnd := control.handle;

  Twinskinform(skinform).addcontrollist(self);
  ChangeImage;
//   control.Invalidate;
  inited := true;
  skinstate := skin_active;
end;

procedure TSkinObjImage.ChangeImage;
begin
  if kind = 1 then SetRzImage
  else if kind = 2 then SetRzRadio
  else if kind = 3 then setDevCheck;
end;

procedure TSkinObjImage.SetRzRadio;
var
  i, n, w, h, x: integer;
  temp, bmp, sbmp: Tbitmap;
  r1, r2: TRect;
begin
  if fsd.Button = nil then exit;
  if fsd.button.radiomap.empty then exit;

  n := fsd.button.radioframe;
  sbmp := fsd.button.radiomap;
  w := sbmp.width div n;
  h := sbmp.Height;
  temp := Tbitmap.create;
  temp.Width := w * 6;
  temp.Height := h;

  r1 := rect(0, 0, w, h);
  temp.Canvas.CopyRect(rect(0, 0, w, h), sbmp.Canvas, r1);
  temp.Canvas.CopyRect(rect(w * 2, 0, w * 3, h), sbmp.Canvas, r1);

  r1 := rect(w, 0, 2 * w, h);
  temp.Canvas.CopyRect(rect(w, 0, w * 2, h), sbmp.Canvas, r1);
  temp.Canvas.CopyRect(rect(w * 3, 0, w * 4, h), sbmp.Canvas, r1);

  r1 := rect(2 * w, 0, 3 * w, h);
  temp.Canvas.CopyRect(rect(w * 4, 0, w * 5, h), sbmp.Canvas, r1);
  r1 := rect(3 * w, 0, 4 * w, h);
  temp.Canvas.CopyRect(rect(w * 5, 0, w * 6, h), sbmp.Canvas, r1);

  bmp := TBitmap(GetObjProp(control, 'CustomGlyphs', TBitmap));
  if bmp <> nil then begin
     //copybmp(temp,bmp);
    bmp.assign(temp);
    setproperty(control, 'transparentcolor', inttostr(clFuchsia));
    setproperty(control, 'UseCustomGlyphs', 'false');
    setproperty(control, 'UseCustomGlyphs', 'true');
  end;
  temp.free;
end;

procedure TSkinObjImage.SetDevCheck;
var
  i, n, w, h, x: integer;
  temp, bmp, sbmp: Tbitmap;
  r1, r2: TRect;
  obj1: TObject;
begin
  if fsd.Button = nil then exit;
  if fsd.button.checkmap.empty then exit;

  n := fsd.button.checkframe;
  sbmp := fsd.button.checkmap;
  w := sbmp.width div n;
  h := sbmp.Height;
  temp := Tbitmap.create;
  temp.Width := w * 6;
  temp.Height := h;

  r1 := rect(0, 0, w, h);
  temp.Canvas.CopyRect(rect(0, 0, w, h), sbmp.Canvas, r1);
  temp.Canvas.CopyRect(rect(w * 3, 0, w * 4, h), sbmp.Canvas, r1);

  r1 := rect(w, 0, 2 * w, h);
  temp.Canvas.CopyRect(rect(w, 0, w * 2, h), sbmp.Canvas, r1);
  temp.Canvas.CopyRect(rect(w * 4, 0, w * 5, h), sbmp.Canvas, r1);

  if n = 5 then begin
    r1 := rect(4 * w, 0, 5 * w, h);
    temp.Canvas.CopyRect(rect(2 * w, 0, w * 3, h), sbmp.Canvas, r1);
    temp.Canvas.CopyRect(rect(w * 5, 0, w * 6, h), sbmp.Canvas, r1);
  end;

  obj1 := GetObjectProp(control, 'Properties');
  if obj1 <> nil then begin
    bmp := TBitmap(GetObjProp(obj1, 'Glyph', TBitmap));
    if bmp <> nil then begin
         //copybmp(temp,bmp);
      bmp.Assign(temp);
      bmp.TransparentColor := clFuchsia;
      bmp.Transparent := false;
    end;
  end;
  temp.free;
end;

procedure TSkinObjImage.SetRzImage;
var
  i, n, w, h, x: integer;
  temp, bmp: Tbitmap;
  r1, r2: TRect;
begin
  if fsd.Button = nil then exit;
  if fsd.button.checkmap.empty then exit;

  n := fsd.button.checkframe;
  w := fsd.button.checkmap.width div n;
  h := fsd.button.CheckMap.Height;
  temp := Tbitmap.create;
  temp.Width := w * 9;
  temp.Height := h;

  r1 := rect(0, 0, w, h);
  r2 := rect(0, 0, w, h);
  temp.Canvas.CopyRect(rect(0, 0, w, h), fsd.button.CheckMap.Canvas, r1);
  temp.Canvas.CopyRect(rect(w * 3, 0, w * 4, h), fsd.button.CheckMap.Canvas, r1);
  r1 := rect(w, 0, 2 * w, h);
  temp.Canvas.CopyRect(rect(w, 0, w + w, h), fsd.button.CheckMap.Canvas, r1);
  temp.Canvas.CopyRect(rect(w * 4, 0, w * 5, h), fsd.button.CheckMap.Canvas, r1);

  r1 := rect(2 * w, 0, 3 * w, h);
  temp.Canvas.CopyRect(rect(6 * w, 0, 7 * w, h), fsd.button.CheckMap.Canvas, r1);
  r1 := rect(3 * w, 0, 4 * w, h);
  temp.Canvas.CopyRect(rect(7 * w, 0, 8 * w, h), fsd.button.CheckMap.Canvas, r1);

  if n = 5 then begin
    r1 := rect(4 * w, 0, 5 * w, h);
    temp.Canvas.CopyRect(rect(2 * w, 0, 3 * w, h), fsd.button.CheckMap.Canvas, r1);
    temp.Canvas.CopyRect(rect(5 * w, 0, 6 * w, h), fsd.button.CheckMap.Canvas, r1);
    temp.Canvas.CopyRect(rect(8 * w, 0, 9 * w, h), fsd.button.CheckMap.Canvas, r1);
  end;

  bmp := TBitmap(GetObjProp(control, 'CustomGlyphs', TBitmap));
  if bmp <> nil then begin
     //copybmp(temp,bmp);
    bmp.assign(temp);
    setproperty(control, 'transparentcolor', inttostr(clFuchsia));
    setproperty(control, 'UseCustomGlyphs', 'false');
    setproperty(control, 'UseCustomGlyphs', 'true');
  end;
  temp.free;
end;

procedure TSkinObjImage.SkinChange;
begin
  ChangeImage;
end;

procedure TSkinObjImage.Unsubclass;
var
  obj1: Tobject;
  bmp: Tbitmap;
begin
  if kind = 1 then
    setproperty(control, 'UseCustomGlyphs', 'false');
  if kind = 2 then
    setproperty(control, 'UseCustomGlyphs', 'false');
  if kind = 3 then begin
    obj1 := GetObjectProp(control, 'Properties');
    if obj1 <> nil then begin
      bmp := TBitmap(GetObjProp(obj1, 'Glyph', TBitmap));
      if bmp <> nil then
        bmp.Assign(nil);
    end;
  end;
end;

procedure TSkinAdvPage.Init(sf: Tcomponent; sd: TSkinData; acanvas: TCanvas; acolor: boolean = false);
begin
  if inited then exit;
  inherited init(sf, sd, acanvas, acolor);

  ChangeImage;
//   control.Invalidate;
  inited := true;
  skinstate := skin_active;
end;

function TSkinAdvPage.FindScroll: boolean;
var
  Wnd: THandle;
begin
  Wnd := FindWindowEx(hwnd, 0, 'msctls_updown32', nil);
  if (Wnd <> 0) and (updown = nil) then begin
    updown := Tskinupdown.create(self.owner);
    updown.inithwnd(wnd, fsd, fcanvas, skinform);
  end;
  result := (GetWindowLong(wnd, GWL_STYLE) and WS_visible) > 0;
end;

procedure TSkinAdvPage.ChangeImage;
begin
  if kind = 4 then setAdvPage;
end;

procedure TSkinAdvPage.SkinChange;
begin
  ChangeImage;
end;

procedure TSkinAdvPage.SetAdvPage;
var
  temp, bmp, sbmp: Tbitmap;
  r1, r2: TRect;
begin
  if fsd.tab = nil then exit;
  r1 := Rect(0, 0, 100, 21);
  temp := GetHMap(r1, fsd.tab.map, fsd.tab.r, 1, fsd.tab.frame, fsd.tab.trans, 0);
  bmp := TBitmap(GetObjProp(control, 'TabBackGround', TBitmap));
  if bmp <> nil then begin
    bmp.assign(temp);
  end;
  temp.free;
  temp := GetHMap(r1, fsd.tab.map, fsd.tab.r, 2, fsd.tab.frame, fsd.tab.trans, 0);
  bmp := TBitmap(GetObjProp(control, 'TabBackGroundActive', TBitmap));
  if bmp <> nil then begin
    bmp.assign(temp);
  end;
  temp.free;
//   obj1 := GetObjectProp(control,'Properties');
//   if obj1<>nil then begin
end;

procedure TSkinAdvPage.Unsubclass;
var
  obj1: Tobject;
  bmp: Tbitmap;
begin
  bmp := TBitmap(GetObjProp(control, 'TabBackGround', TBitmap));
  if bmp <> nil then bmp.Assign(nil);
  bmp := TBitmap(GetObjProp(control, 'TabBackGroundActive', TBitmap));
  if bmp <> nil then bmp.Assign(nil);
end;

procedure TSkinAdvPage.DrawControl(dc: HDC; rc: TRect);
begin
  FindScroll();
end;

function TSkinTabBtn.BeforeProc(var Message: TMessage): boolean;
begin
  case message.msg of
    wm_paint: begin
        wmpaint(message);
        result := false;
      end;
  else result := inherited beforeProc(message);
  end;
end;

procedure TSkinTabBtn.DrawControl(dc: HDC; rc: TRect);
var
  i, j, n, m, bw, w, h, x, y, truerect: integer;
  rt, r1, r2, r3, r4: Trect;
  item: TC_ITEM;
  s: string;
  b: boolean;
  acolor: Tcolor;
  TCItemW: TTCItemW;
  TCItem: TTCItem;
  Buffer: array[0.._maxcaption - 1] of Char;
  imglist: Himagelist;
  bfont, cfont: Hfont;
  wnd: Thandle;
  ws: widestring;
  Drawtemp: Tbitmap;
begin
  b := (fsd.button <> nil) and (not fsd.button.map.empty);

  rt := rc;
  enabled := control.Enabled;
  SendMessage(hWnd, TCM_ADJUSTRECT, 0, integer(@RT));
  InflateRect(rt, 4, 4);
  inc(rt.top, 1);
  r2 := rect(rc.left, rc.top, rc.right, rt.top);
  w := r2.right - r2.left;
  h := r2.bottom - r2.top;

  m := sendmessage(hwnd, TCM_GETITEMCOUNT, 0, 0);
  n := sendmessage(hwnd, TCM_GETCURFOCUS, 0, 0);
  sendmessage(hwnd, TCM_GETITEMRECT, n, integer(@r1));
  imglist := sendmessage(hwnd, TCM_GETIMAGELIST, 0, 0);

  drawtemp := Tbitmap.create;
  Drawtemp.PixelFormat := pf24bit;
  if b then begin
      //tab area
    Drawtemp.width := w;
    Drawtemp.height := h;

    fillbg(Drawtemp.canvas.handle, rect(0, 0, w, h));

    bfont := sendmessage(hwnd, wm_getfont, 0, 0);
    cfont := selectobject(drawtemp.canvas.handle, bfont);
//         drawtemp.Canvas.Font.Assign(Tacwincontrol(control).font);

    SetTextColor(Drawtemp.canvas.handle, ColorToRGB(clblack));
    for i := 0 to m - 1 do begin
      if isunicode then begin
        TCItemW.mask := TCIF_IMAGE or TCIF_STATE or TCIF_TEXT;
        TCItemW.pszText := Pwidechar(@buffer);
        TCItemW.cchTextMax := _maxcaption;
        SendMessage(Hwnd, TCM_GETITEMW, I, Longint(@TCItemW));
        ws := _Wstr(TCItemW.pszText, -1);
      end else begin
        TCItem.mask := TCIF_IMAGE or TCIF_STATE or TCIF_TEXT;
        TCItem.pszText := Pchar(@buffer);
        TCItem.cchTextMax := _maxcaption;
        SendMessage(Hwnd, TCM_GETITEM, I, Longint(@TCItem));
        ws := StrToWideStr(buffer);
      end;

      TrueRect := sendmessage(hwnd, TCM_GETITEMRECT, i, integer(@r1));
      if TrueRect = 0 then continue;

      offsetrect(r1, 0, 1);

      if i = n then j := 2 else j := 1;
      DrawRect2(Drawtemp.canvas.Handle, r1, fsd.Button.Map, fsd.button.r, j, fsd.button.frame,
        fsd.button.trans, fsd.button.tile);

      if (j = 1) and (fsd.button.newnormal) then
        SetTextColor(Drawtemp.canvas.handle, ColorToRGB(fsd.button.normalcolor2));
      if (j = 2) and (fsd.Button.newdown) then
        SetTextColor(Drawtemp.canvas.handle, ColorToRGB(fsd.button.downcolor2));

      if isunicode then
        DrawImgCaption(Drawtemp.canvas, r1, imglist, TCItemW.iImage, ws)
      else
        DrawImgCaption(Drawtemp.canvas, r1, imglist, TCItem.iImage, ws);
    end;                                //end for
    selectobject(drawtemp.canvas.handle, cfont);

    BitBlt(dc, r2.left, r2.top, r2.right, r2.bottom,
      drawtemp.Canvas.Handle, 0, 0, SrcCopy);
  end;
  drawtemp.Free;
end;

function GetDisableImg(FOriginal: TBitmap): Tbitmap;
const
  ROP_DSPDxax = $00E20746;
var
  TmpImage, DDB, MonoBmp: TBitmap;
  IWidth, IHeight: Integer;
  IRect, ORect: TRect;
  I: TButtonState;
  DestDC: HDC;
begin
  TmpImage := TBitmap.Create;
  IWidth := FOriginal.Width;
  IHeight := FOriginal.Height;

  TmpImage.Width := FOriginal.Width;
  TmpImage.Height := FOriginal.Height;
  IRect := Rect(0, 0, TmpImage.Width, TmpImage.Height);
  TmpImage.Canvas.Brush.Color := clBtnFace;
  TmpImage.Palette := CopyPalette(FOriginal.Palette);

  MonoBmp := nil;
  DDB := nil;
  try
    MonoBmp := TBitmap.Create;
    DDB := TBitmap.Create;
    DDB.Assign(FOriginal);
    DDB.HandleType := bmDDB;
              { Create a disabled version }
    with MonoBmp do
    begin
      Assign(FOriginal);
      HandleType := bmDDB;
      Canvas.Brush.Color := clBlack;
      Width := IWidth;
      if Monochrome then
      begin
        Canvas.Font.Color := clWhite;
        Monochrome := False;
        Canvas.Brush.Color := clWhite;
      end;
      Monochrome := True;
    end;

    with TmpImage.Canvas do
    begin
      Brush.Color := clBtnFace;
      FillRect(IRect);
      Brush.Color := clBtnHighlight;
      SetTextColor(Handle, clBlack);
      SetBkColor(Handle, clWhite);
      BitBlt(Handle, 1, 1, IWidth, IHeight,
        MonoBmp.Canvas.Handle, 0, 0, ROP_DSPDxax);
      Brush.Color := clBtnShadow;
      SetTextColor(Handle, clBlack);
      SetBkColor(Handle, clWhite);
      BitBlt(Handle, 0, 0, IWidth, IHeight,
        MonoBmp.Canvas.Handle, 0, 0, ROP_DSPDxax);
    end;
  finally
    DDB.Free;
    MonoBmp.Free;
  end;
  result := TmpImage;
end;

end.

