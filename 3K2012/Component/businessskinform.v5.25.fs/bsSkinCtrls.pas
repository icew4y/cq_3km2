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

unit bsSkinCtrls;

{$P+,S-,W-,R-}
{$WARNINGS OFF}
{$HINTS OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Menus, ExtCtrls, bsSkinData, StdCtrls, bsSkinMenus, ComCtrls, CommCtrl,
  ImgList, bsSkinHint;

const
  // Billenium Effects messages
  BE_ID           = $41A2;
  BE_BASE         = CM_BASE + $0C4A;
  CM_BEPAINT      = BE_BASE + 0; // Paint client area to Billenium Effects' DC
  CM_BENCPAINT    = BE_BASE + 1; // Paint non client area to Billenium Effects' DC
  CM_BEFULLRENDER = BE_BASE + 2; // Paint whole control to Billenium Effects' DC
  CM_BEWAIT       = BE_BASE + 3; // Don't execute effect yet
  CM_BERUN        = BE_BASE + 4; // Execute effect now!
type

  TbsControlButton = record
    R: TRect;
    MouseIn: Boolean;
    Down: Boolean;
    Visible: Boolean;
  end;

  TbsSkinWinControl = class(TWinControl)
  protected
    FSD: TbsSkinData;
    procedure Notification(AComponent: TComponent;  Operation: TOperation); override;
    procedure SetSkinData(Value: TbsSkinData); virtual;
  public
    procedure ChangeSkinData; virtual;
    destructor Destroy; override;
    constructor Create(AOwner: TComponent); override;
    property SkinData: TbsSkinData read FSD write SetSkinData;
  end;

  TbsSkinControl = class(TCustomControl)
  protected
    FromWMPaint: Boolean;
    FSD: TbsSkinData;
    FSkinDataName: String;
    FRgn: HRgn;
    FOnMouseEnter, FOnMouseLeave: TNotifyEvent;
    procedure Notification(AComponent: TComponent;  Operation: TOperation); override;
    procedure GetSkinData; virtual;
    procedure WMMOVE(var Msg: TWMMOVE); message WM_MOVE;
    procedure WMEraseBkgnd(var Msg: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure WMPaint(var Msg: TWMPaint); message WM_PAINT;
    procedure SetSkinDataName(Value: String); virtual;
    procedure SetSkinData(Value: TbsSkinData); virtual;

    procedure CreateControlDefaultImage(B: TBitMap); virtual;
    procedure CreateControlSkinImage(B: TBitMap); virtual;

  public
    FIndex: Integer;
    procedure Paint; override;
    procedure ChangeSkinData; virtual;
    procedure BeforeChangeSkinData; virtual;
    procedure AfterChangeSkinData; virtual;
    destructor Destroy; override;
    constructor Create(AOwner: TComponent); override;
  published
    property Anchors;
    property TabOrder;
    property Visible;
    property SkinData: TbsSkinData read FSD write SetSkinData;
    property SkinDataName: String read FSkinDataName write SetSkinDataName;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
  end;

  TbsSkinCustomControl = class(TbsSkinControl)
  protected
    FForceBackground: Boolean;
    FDrawbackground: Boolean;
    FDefaultWidth: Integer;
    FDefaultHeight: Integer;
    FDefaultFont: TFont;
    FUseSkinFont: Boolean;

    LTPt, RTPt, LBPt, RBPt: TPoint;
    SkinRect, ClRect: TRect;
    NewLTPoint, NewRTPoint, NewLBPoint, NewRBPoint: TPoint;
    NewClRect: TRect;
    Picture, MaskPicture: TBitMap;
    ResizeMode: Integer;
    StretchEffect: Boolean;

    LeftStretch, TopStretch, RightStretch, BottomStretch: Boolean;


    procedure OnDefaultFontChange(Sender: TObject);
    procedure SetDefaultWidth(Value: Integer);
    procedure SetDefaultHeight(Value: Integer);
    procedure SetDefaultFont(Value: TFont);
    procedure DefaultFontChange; virtual;
    function GetNewRect(R: TRect): TRect;
    function GetResizeMode: Integer;
    procedure CalcSize(var W, H: Integer); virtual;

    procedure CreateSkinControlImage(B, SB: TBitMap; R: TRect);

    procedure GetSkinData; override;
    procedure CreateControlRegion;
    procedure SetControlRegion; virtual;

    procedure CreateControlDefaultImage(B: TBitMap); override;
    procedure CreateControlSkinImage(B: TBitMap); override;

    function GetRealClientWidth: Integer;
    function GetRealClientHeight: Integer;
    function GetRealClientLeft: Integer;
    function GetRealClientTop: Integer;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure ChangeSkinData; override;
    property RealClientRect: TRect read NewClRect;
    property RealClientWidth: integer read GetRealClientWidth;
    property RealClientHeight: integer read GetRealClientHeight;
    property RealClientLeft: integer read GetRealClientLeft;
    property RealClientTop: integer read GetRealClientTop;
    procedure Paint; override;
    property ForcebackGround: Boolean read FForceBackGround write FForceBackGround;
    property DrawbackGround: Boolean read FDrawBackground write FDrawBackground;
  published
    property DefaultFont: TFont read FDefaultFont write SetDefaultFont;
    property DefaultWidth: Integer read FDefaultWidth write SetDefaultWidth;
    property DefaultHeight: Integer read FDefaultHeight write SetDefaultHeight;
    property UseSkinFont: Boolean read FUseSkinFont write FUseSkinFont;
  end;

  TbsSkinBevel = class(TBevel)
  protected
    FSD: TbsSkinData;
    FSkinDataName: String;
    FIndex: Integer;
    FDividerMode: Boolean;
    procedure SetDividerMode(Value: Boolean);
    procedure SetSkinData(Value: TbsSkinData);
  public
    LightColor, DarkColor: TColor;
    constructor Create(AOwner: TComponent); override;
    procedure Paint; override;
    procedure ChangeSkinData;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
  published
    property SkinData: TbsSkinData read FSD write SetSkinData;
    property SkinDataName: String read FSkinDataName write FSkinDataName;
    property DividerMode: Boolean read FDividerMode write SetDividerMode;
  end;

  TbsSkinBorderStyle = (bvFrame, bvRaised, bvLowered, bvNone);
  TbsSkinPanelNumGlyphs = 1..2;

  TbsSkinPanel = class(TbsSkinCustomControl)
  protected
    FCMaxWidth, FCMinWidth, FCMaxHeight, FCMinHeight: Integer;
    FCheckedMode: Boolean;
    FChecked: Boolean;
    FOnChecked: TNotifyEvent;
    FGlyph: TBitMap;
    FNumGlyphs: TbsSkinPanelNumGlyphs;
    FSpacing: Integer;
    FRealHeight: Integer;
    FRollUpState: Boolean;
    FRollUpMode: Boolean;
    FCaptionMode: Boolean;
    FBorderStyle: TbsSkinBorderStyle;
    FDefaultCaptionHeight: Integer;
    FDefaultAlignment: TAlignment;
    FAutoEnabledControls: Boolean;
    FCaptionImageList: TCustomImageList;
    FCaptionImageIndex: Integer;
    procedure Notification(AComponent: TComponent;  Operation: TOperation); override;
    procedure SetCaptionImageIndex(Value: Integer);
    procedure SetCheckedMode(Value: Boolean);
    procedure SetChecked(Value: Boolean);
    procedure SetGlyph(Value: TBitMap);
    procedure SetNumGlyphs(Value: TbsSkinPanelNumGlyphs);
    procedure SetSpacing(Value: Integer);
    procedure SetRollUpMode(Value: Boolean);
    procedure SetDefaultAlignment(Value: TAlignment);
    procedure SetDefaultCaptionHeight(Value: Integer); virtual;
    procedure SetBorderStyle(Value: TbsSkinBorderStyle);
    procedure SetRollUpState(Value: Boolean);
    procedure SetCaptionMode(Value: Boolean); virtual;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure AdjustClientRect(var Rect: TRect); override;
    procedure GetSkinData; override;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;

    procedure CreateControlDefaultImage(B: TBitMap); override;
    procedure CreateControlSkinImage(B: TBitMap); override;

    procedure HideControls;
    procedure ShowControls;

    procedure SkinDrawCheckImage(X, Y: Integer; Cnvs: TCanvas; IR: TRect; DestCnvs: TCanvas);

  public
    FontName: String;
    FontStyle: TFontStyles;
    FontHeight: Integer;
    FontColor: TColor;
    Alignment: TAlignment;
    CaptionRect: TRect;
    NewCaptionRect: TRect;
    NewRollUpMarkerRect: TRect;
    BGPictureIndex: Integer;
    CheckImageRect, UnCheckImageRect: TRect;
    FOnChangeRollUpState: TNotifyEvent;
    MarkFrameRect: TRect;
    FrameRect: TRect;
    FrameLeftOffset, FrameRightOffset: Integer;
    FrameTextRect: TRect;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ChangeSkinData; override;
    procedure DoRollUp(ARollUp: Boolean);
    procedure Paint; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    function GetSkinClientRect: TRect;
    procedure PaintskinTo(C: TCanvas; X, Y: Integer);
  published
    property CaptionImageList: TCustomImageList read FCaptionImageList write FCaptionImageList;
    property CaptionImageIndex: Integer read FCaptionImageIndex write SetCaptionImageIndex;
    property RealHeight: Integer read FRealHeight write FRealHeight;
    property AutoEnabledControls: Boolean
      read FAutoEnabledControls write FAutoEnabledControls;
    property CheckedMode: Boolean read FCheckedMode write SetCheckedMode;
    property Checked: Boolean read FChecked write SetChecked;
    property DefaultAlignment: TAlignment
      read FDefaultAlignment write SetDefaultAlignment;
    property DefaultCaptionHeight: Integer
      read FDefaultCaptionHeight write SetDefaultCaptionHeight;
    property BorderStyle: TbsSkinBorderStyle
      read FBorderStyle write SetBorderStyle;
    property CaptionMode: Boolean read FCaptionMode write SetCaptionMode;
    property RollUpMode: Boolean read FRollUpMode write SetRollUpMode;
    property RollUpState: Boolean read FRollUpState write SetRollUpState;
    property Glyph: TBitMap read FGlyph write SetGlyph;
    property NumGlyphs: TbsSkinPanelNumGlyphs read FNumGlyphs write SetNumGlyphs;
    property Spacing: Integer read FSpacing write SetSpacing;
    property Caption;
    property Constraints;
    property Align;
    property DockSite;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnChecked: TNotifyEvent read FOnChecked write FOnChecked;
    property OnChangeRollUpState: TNotifyEvent
      read FOnChangeRollUpState write FOnChangeRollUpState;
    property OnCanResize;
    property OnClick;
    property OnConstrainedResize;
    property OnDockDrop;
    property OnDockOver;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetSiteInfo;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
  end;

  TbsPaintPanelEvent = procedure(Cnvs: TCanvas; R: TRect) of object;

  TbsSkinPaintPanel = class(TbsSkinPanel)
  private
    FOnPanelPaint: TbsPaintPanelEvent;
  protected
    procedure CreateControlDefaultImage(B: TBitMap); override;
    procedure CreateControlSkinImage(B: TBitMap); override;
    procedure WMEraseBkgnd(var Msg: TWMEraseBkgnd); message WM_ERASEBKGND;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property OnPanelPaint: TbsPaintPanelEvent
      read FOnPanelPaint write FOnPanelPaint;
  end;

  TbsSkinStatusBar = class(TbsSkinPanel)
  private
    FSizeGrip: Boolean;
    FShowGrip: Boolean;
    procedure SetSizeGrip(Value: Boolean);
    procedure SetShowGrip(Value: Boolean);
  protected
    procedure SetSkinData(Value: TbsSkinData); override;
    procedure GetSkinData; override;
    procedure AdjustClientRect(var Rect: TRect); override;
    procedure DrawDefaultGripper(R: TRect; Cnvs: TCanvas; C1, C2: TColor);
    procedure CreateControlDefaultImage(B: TBitMap); override;
    procedure CreateControlSkinImage(B: TBitMap); override;
    function GetGripRect: TRect;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
  public
    GripperRect: TRect;
    GripperTransparent: Boolean;
    GripperTransparentColor: TColor;
    constructor Create(AOwner: TComponent); override;
    property ShowGrip: Boolean read FShowGrip write SetShowGrip;
  published
    property SizeGrip: Boolean read FSizeGrip write SetSizeGrip;
  end;

  TbsSkinToolBar = class(TbsSkinPanel)
  private
    FAdjustControls: Boolean;
    // scroll
    FCanScroll: Boolean;
    FHotScroll: Boolean;
    TimerMode: Integer;
    SMax, SPosition, SPage, SOldPosition: Integer;
    FHSizeOffset: Integer;
    FScrollOffset: Integer;
    FScrollTimerInterval: Integer;
    Buttons: array[0..1] of TbsControlButton;
    ButtonData: TbsDataSkinButtonControl;
    //
    FImages: TCustomImageList;
    FDisabledImages: TCustomImageList;
    FHotImages: TCustomImageList;
    FFlat: Boolean;
    FAutoShowHideCaptions: Boolean;
    FShowCaptions: Boolean;
    FWidthWithCaptions: Integer;
    FWidthWithoutCaptions: Integer;
    procedure SetFlat(Value: Boolean);
    procedure SetDisabledImages(Value: TCustomImageList);
    procedure SetHotImages(Value: TCustomImageList);
    procedure SetImages(Value: TCustomImageList);
    procedure SetShowCaptions(Value: Boolean);
    // scroll
    procedure SetScrollOffset(Value: Integer);
    procedure SetScrollTimerInterval(Value: Integer);
    procedure DrawButton(Cnvs: TCanvas; i: Integer);
  protected
    procedure WMSETCURSOR(var Message: TWMSetCursor); message WM_SetCursor;
    procedure CreateControlSkinImage(B: TBitMap); override;
    procedure GetSkinData; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure SetSkinData(Value: TbsSkinData); override;
    procedure SetSkinDataName(Value: String); override;
    // scroll
    procedure WMTimer(var Message: TWMTimer); message WM_Timer;
    procedure WMNCCALCSIZE(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCPAINT(var Message: TMessage); message WM_NCPAINT;
    procedure WMSIZE(var Message: TWMSIZE); message WM_SIZE;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure WndProc(var Message: TMessage); override;
    procedure SetButtonsVisible(AVisible: Boolean);
    procedure ButtonClick(I: Integer);
    procedure ButtonDown(I: Integer);
    procedure ButtonUp(I: Integer);
    procedure GetHRange;
    procedure GetScrollInfo;
    procedure HScrollControls(AOffset: Integer);
    procedure AdjustClientRect(var Rect: TRect); override;
    procedure StartTimer;
    procedure StopTimer;
    procedure WMWindowPosChanging(var Message: TWMWindowPosChanging); message WM_WINDOWPOSCHANGING;
    procedure AdjustAllControls;
  public
    constructor Create(AOwner: TComponent); override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
  published
    // scroll
    property CanScroll: Boolean read FCanScroll write FCanScroll;
    property HotScroll: Boolean read FHotScroll write FHotScroll;
    property ScrollOffset: Integer read FScrollOffset write SetScrollOffset;
    property ScrollTimerInterval: Integer
      read FScrollTimerInterval write SetScrollTimerInterval;
    //
    property AdjustControls: Boolean read FAdjustControls write FAdjustControls;
    property WidthWithCaptions: Integer
      read FWidthWithCaptions write FWidthWithCaptions;
    property WidthWithoutCaptions: Integer
      read FWidthWithoutCaptions write FWidthWithoutCaptions;
    property AutoShowHideCaptions: Boolean
      read FAutoShowHideCaptions write FAutoShowHideCaptions;
    property ShowCaptions: Boolean read FShowCaptions write SetShowCaptions;  
    property Flat: Boolean read FFlat write SetFlat;
    property Images: TCustomImageList read FImages write SetImages;
    property HotImages: TCustomImageList read FHotImages write SetHotImages;
    property DisabledImages: TCustomImageList read FDisabledImages write SetDisabledImages;
  end;

  TbsSkinGroupBox = class(TbsSkinPanel)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TbsExPanelRollKind = (rkRollHorizontal, rkRollVertical);

  TbsSkinExPanel = class(TbsSkinCustomControl)
  private
    FCMaxWidth, FCMinWidth, FCMaxHeight, FCMinHeight: Integer;
    FGlyph: TBitMap;
    FNumGlyphs: TbsSkinPanelNumGlyphs;
    FSpacing: Integer;
    FOnChangeRollState: TNotifyEvent;
    FOnClose: TNotifyEvent;
    StopCheckSize: Boolean;
    FRollState: Boolean;
    FRollKind: TbsExPanelRollKind;
    FDefaultCaptionHeight: Integer;
    FRealWidth, FRealHEight: Integer;
    FShowRollButton: Boolean;
    FShowCloseButton: Boolean;
    FCaptionImageList: TCustomImageList;
    FCaptionImageIndex: Integer;
    procedure Notification(AComponent: TComponent;  Operation: TOperation); override;
    procedure SetCaptionImageIndex(Value: Integer);
    function GetRollWidth: Integer;
    function GetRollHeight: Integer;
    procedure SetShowRollButton(Value: Boolean);
    procedure SetShowCloseButton(Value: Boolean);
    procedure SetGlyph(Value: TBitMap);
    procedure SetNumGlyphs(Value: TbsSkinPanelNumGlyphs);
    procedure SetSpacing(Value: Integer);
  protected

    Buttons: array[0..1] of TbsControlButton;
    OldActiveButton, ActiveButton, CaptureButton: Integer;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;

    procedure CreateControlDefaultImage(B: TBitMap); override;
    procedure CreateControlSkinImage(B: TBitMap); override;
    procedure SetDefaultCaptionHeight(Value: Integer);
    procedure AdjustClientRect(var Rect: TRect); override;
    procedure HideControls;
    procedure ShowControls;
    procedure SetRollState(Value: Boolean);
    procedure SetRollKind(Value: TbsExPanelRollKind);
    //
    procedure ButtonDown(I: Integer; X, Y: Integer);
    procedure ButtonUp(I: Integer; X, Y: Integer);
    procedure ButtonEnter(I: Integer);
    procedure ButtonLeave(I: Integer);
    procedure DrawButton(Cnvs: TCanvas; i: Integer);
    procedure TestActive(X, Y: Integer);
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure GetSkinData; override;

  public
    //
    RollHSkinRect, RollVSkinRect: TRect;
    RollLeftOffset, RollRightOffset,
    RollTopOffset, RollBottomOffset: Integer;
    RollVCaptionRect, RollHCaptionRect: TRect;
    CloseButtonRect, CloseButtonActiveRect, CloseButtonDownRect: TRect;
    HRollButtonRect, HRollButtonActiveRect, HRollButtonDownRect: TRect;
    HRestoreButtonRect, HRestoreButtonActiveRect, HRestoreButtonDownRect: TRect;
    VRollButtonRect, VRollButtonActiveRect, VRollButtonDownRect: TRect;
    VRestoreButtonRect, VRestoreButtonActiveRect, VRestoreButtonDownRect: TRect;
    CaptionRect: TRect;
    FontName: String;
    FontStyle: TFontStyles;
    FontHeight: Integer;
    FontColor: TColor;
    //
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure ChangeSkinData; override;
    procedure Close;
  published
    property CaptionImageList: TCustomImageList read FCaptionImageList write FCaptionImageList;
    property CaptionImageIndex: Integer read FCaptionImageIndex write SetCaptionImageIndex;
    property Glyph: TBitMap read FGlyph write SetGlyph;
    property NumGlyphs: TbsSkinPanelNumGlyphs read FNumGlyphs write SetNumGlyphs;
    property Spacing: Integer read FSpacing write SetSpacing;

    property RealWidth: Integer read FRealWidth write FRealWidth;
    property RealHeight: Integer read FRealHeight write FRealHeight;

    property ShowRollButton: Boolean
      read FShowRollButton write SetShowRollButton;
    property ShowCloseButton: Boolean
      read FShowCloseButton write SetShowCloseButton;
    property DefaultCaptionHeight: Integer
      read FDefaultCaptionHeight write SetDefaultCaptionHeight;
    property RollState: Boolean read FRollState write SetRollState;
    property RollKind: TbsExPanelRollKind read FRollKind write SetRollKind;
    property Align;
    property Caption;
    property DockSite;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnCanResize;
    property OnClick;
    property OnConstrainedResize;
    property OnDockDrop;
    property OnDockOver;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetSiteInfo;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
    property OnChangeRollState: TNotifyEvent
      read FOnChangeRollState write FOnChangeRollState;
    property OnClose: TNotifyEvent read FOnClose write FOnClose;
  end;

  TbsNumGlyphs = 1..4;
  TbsButtonLayout = (blGlyphLeft, blGlyphRight, blGlyphTop, blGlyphBottom);

  TbsSkinButton = class(TbsSkinCustomControl)
  protected
    // animation
    AnimateTimer: TTimer;
    CurrentFrame: Integer;
    AnimateInc: Boolean;
    //
    FSkinImagesMenu: TbsSkinImagesMenu;
    FUseImagesMenuImage: Boolean;
    FUseImagesMenuCaption: Boolean;
    FSpaceSupport: Boolean;
    //
    FUseSkinFontColor: Boolean;
    FUseSkinSize: Boolean;
    RepeatTimer: TTimer;
    FRepeatMode: Boolean;
    FRepeatInterval: Integer;
    FActive: Boolean;
    FAllowAllUp: Boolean;
    FAllowAllUpCheck: Boolean;
    FDefault: Boolean;
    FCancel: Boolean;
    FModalResult: TModalResult;
    FClicksDisabled: Boolean;
    FCanFocused: Boolean;
    FDown: Boolean;
    FMouseIn, FMouseDown: Boolean;
    FGroupIndex: Integer;
    FGlyph: TBitMap;
    FNumGlyphs: TbsNumGlyphs;
    FMargin: Integer;
    FSpacing: Integer;
    FLayout: TbsButtonLayout;
    FOnClick: TNotifyEvent;
    //
    MorphTimer: TTimer;
    FMorphKf: Double;

    FImageList: TCustomImageList;
    FImageIndex: Integer;
    procedure SetImageIndex(Value: Integer);

    procedure RepeatTimerProc(Sender: TObject);
    procedure StartRepeat;
    procedure StopRepeat;
    procedure StartMorph;
    procedure StopMorph;
    procedure DoMorph(Sender: TObject);
    //
    procedure StartAnimate(AInc: Boolean);
    procedure StopAnimate;
    procedure DoAnimate(Sender: TObject);
    function GetAnimationFrameRect: TRect;
    //
    procedure SetDefault(Value: Boolean);
    function GetGlyphNum(AIsDown, AIsMouseIn: Boolean): Integer;
    function IsFocused: Boolean;
    procedure SetCanFocused(Value: Boolean);
    procedure CreateStrechButtonImage(B: TBitMap; R: TRect;
      ADown, AMouseIn: Boolean);
    procedure CreateButtonImage(B: TBitMap; R: TRect;
      ADown, AMouseIn: Boolean); virtual;
    procedure SetLayout(Value : TbsButtonLayout);
    procedure SetMargin(Value: Integer);
    procedure SetSpacing(Value: Integer);
    procedure SetGroupIndex(Value: Integer);
    procedure SetDown(Value: Boolean);
    procedure DoAllUp;
    procedure SetNumGlyphs(Value: TbsNumGlyphs);
    procedure SetGlyph(Value: TBitMap);
    procedure GetSkinData; override;
    procedure WMEraseBkgnd(var Msg: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
    procedure CMFocusChanged(var Message: TCMFocusChanged); message CM_FOCUSCHANGED;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure CreateControlDefaultImage(B: TBitMap); override;
    procedure CreateControlSkinImage(B: TBitMap); override;

    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); override;

    procedure Notification(AComponent: TComponent;  Operation: TOperation); override;

    procedure WMSETFOCUS(var Message: TWMSETFOCUS); message WM_SETFOCUS;
    procedure WMKILLFOCUS(var Message: TWMKILLFOCUS); message WM_KILLFOCUS;
    procedure WndProc(var Message: TMessage); override;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;

    procedure ReDrawControl;

    procedure CreateWnd; override;

    procedure CalcSize(var W, H: Integer); override;
    function EnableMorphing: Boolean;
    function EnableAnimation: Boolean;


    procedure DrawMenuMarker(C: TCanvas; R: TRect; AActive, ADown: Boolean); 

    procedure OnImagesMenuChanged(Sender: TObject);

    procedure SetSkinImagesMenu(Value: TbsSkinImagesMenu);

    property SkinImagesMenu: TbsSkinImagesMenu
     read FSkinImagesMenu write SetSkinImagesMenu;
    property UseImagesMenuImage: Boolean
      read FUseImagesMenuImage write FUseImagesMenuImage;
    property UseImagesMenuCaption: Boolean
      read FUseImagesMenuCaption write FUseImagesMenuCaption;
  public
    FontName: String;
    FontStyle: TFontStyles;
    FontHeight: Integer;
    FontColor, ActiveFontColor, DownFontColor, DisabledFontColor: TColor;
    ActiveSkinRect, DownSkinRect, DisabledSkinRect: TRect;
    AnimateSkinRect: TRect;
    FrameCount: Integer;
    AnimateInterval: Integer;
    Morphing: Boolean;
    MorphKind: TbsMorphKind;
    ShowFocus: Boolean;
    //
    MenuMarkerFlatRect,
    MenuMarkerRect,
    MenuMarkerActiveRect,
    MenuMarkerDownRect: TRect;
    MenuMarkerTransparentColor: TColor;
    //
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ChangeSkinData; override;
    procedure Click; override;
    procedure Paint; override;
    procedure ButtonClick; virtual;
    procedure RefreshButton;
  published
    property ImageList: TCustomImageList read FImageList write FImageList;
    property ImageIndex: Integer read FImageIndex write SetImageIndex;

    property UseSkinSize: Boolean read FUseSkinSize write FUseSkinSize;
    property UseSkinFontColor: Boolean read FUseSkinFontColor write FUseSkinFontColor;
    property RepeatMode: Boolean read FRepeatMode write FRepeatMode;
    property RepeatInterval: Integer
      read  FRepeatInterval write FRepeatInterval;
    property AllowAllUp: Boolean read FAllowAllUp write FAllowAllUp;
    property PopupMenu;
    property ShowHint;
    property TabStop;
    property TabOrder;
    property CanFocused: Boolean read FCanFocused write SetCanFocused;
    property Action;
    property ParentShowHint;
    property Down: Boolean read FDown write SetDown;
    property GroupIndex: Integer read FGroupIndex write SetGroupIndex;
    property Caption;
    property Glyph: TBitMap read FGlyph write SetGlyph;
    property NumGlyphs: TbsNumGlyphs read FNumGlyphs write SetNumGlyphs;
    property Margin: Integer read FMargin write SetMargin default -1;
    property Spacing: Integer read FSpacing write SetSpacing default 4;
    property Layout: TbsButtonLayout read FLayout write SetLayout default blGlyphLeft;
    property Align;
    property Enabled;
    property Cancel: Boolean read FCancel write FCancel default False;
    property Default: Boolean read FDefault write SetDefault default False;
    property ModalResult: TModalResult read FModalResult write FModalResult default 0;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnEnter;
    property OnExit;
  end;

  TbsSkinMenuButton = class(TbsSkinButton)
  protected
    FOnShowTrackMenu: TNotifyEvent;
    FOnHideTrackMenu: TNotifyEvent;
    FTrackButtonMode: Boolean;
    FMenuTracked: Boolean;
    FSkinPopupMenu: TbsSkinPopupMenu;
    procedure CreateButtonImage(B: TBitMap; R: TRect;
      ADown, AMouseIn: Boolean); override;

    function CanMenuTrack(X, Y: Integer): Boolean;
    procedure TrackMenu;
    procedure SetTrackButtonMode(Value: Boolean);
    procedure GetSkinData; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure WMCLOSESKINMENU(var Message: TMessage); message WM_CLOSESKINMENU;
    function GetNewTrackButtonRect: TRect;
    procedure WndProc(var Message: TMessage); override;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure CreateControlDefaultImage(B: TBitMap); override;
    procedure CreateControlSkinResizeImage(B: TBitMap;
      ADown, AMouseIn: Boolean);
    procedure CreateControlSkinResizeImage2(B: TBitMap;
      ADown, AMouseIn: Boolean);
    procedure OnImagesMenuClose(Sender: TObject);
  public
    TrackButtonRect: TRect;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property SkinPopupMenu: TbsSkinPopupMenu read FSkinPopupMenu
                                             write FSkinPopupMenu;
    property TrackButtonMode: Boolean read FTrackButtonMode
                                      write SetTrackButtonMode;

    property SkinImagesMenu;
    property UseImagesMenuImage;
    property UseImagesMenuCaption;

    property OnShowTrackMenu: TNotifyEvent read FOnShowTrackMenu
                                           write FOnShowTrackMenu;
    property OnHideTrackMenu: TNotifyEvent read FOnHideTrackMenu
                                           write FOnHideTrackMenu;
  end;

  TbsSkinCheckRadioBox = class(TbsSkinCustomControl)
  protected
    FWordWrap: Boolean;
    FAllowGrayed: Boolean;
    FState: TCheckBoxState;
    FImages: TCustomImageList;
    FImageIndex: Integer;
    FFLat: Boolean;
    FClicksDisabled: Boolean;
    FCanFocused: Boolean;
    FMouseIn: Boolean;
    FGroupIndex: Integer;
    FOnClick: TNotifyEvent;
    FChecked: Boolean;
    CIRect, NewTextArea: TRect;
    FRadio: Boolean;
    MorphTimer: TTimer;
    FMorphKf: Double;
    procedure SetWordWrap(Value: Boolean);
    procedure SetImageIndex(Value: Integer);
    procedure SetImages(Value: TCustomImageList);
    procedure SetFlat(Value: Boolean);
    procedure DoMorph(Sender: TObject);
    procedure StartMorph;
    procedure StopMorph;
    function IsFocused: Boolean;
    procedure SkinDrawCheckImage(X, Y: Integer; Cnvs: TCanvas; IR: TRect; DestCnvs: TCanvas);
    procedure SkinDrawGrayedCheckImage(X, Y: Integer; Cnvs: TCanvas; IR: TRect; DestCnvs: TCanvas);
    procedure SetCheckState; virtual;
    procedure SetCanFocused(Value: Boolean);
    procedure SetRadio(Value: Boolean);
    procedure SetChecked(Value: Boolean);
    procedure CreateImage(B: TBitMap; R: TRect; AMouseIn: Boolean);
    procedure CreateImage2(B: TBitMap; R: TRect; AChecked: Boolean); 
    procedure UnCheckAll;
    procedure GetSkinData; override;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure ReDrawControl;
    procedure CalcSize(var W, H: Integer); override;

    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); override;

    procedure WMSETFOCUS(var Message: TWMSETFOCUS); message WM_SETFOCUS;
    procedure WMKILLFOCUS(var Message: TWMKILLFOCUS); message WM_KILLFOCUS;
    procedure WMMOVE(var Msg: TWMMOVE); message WM_MOVE;
    procedure WMEraseBkgnd(var Msg: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WndProc(var Message: TMessage); override;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;

    procedure CreateControlDefaultImage(B: TBitMap); override;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    function EnableMorphing: Boolean;
    procedure SetState(Value: TCheckBoxState);
    procedure SetAllowGrayed(Value: Boolean);
  public
    FontName: String;
    FontStyle: TFontStyles;
    FontHeight: Integer;
    FontColor, ActiveFontColor, FrameFontColor, UnEnabledFontColor: TColor;
    ActiveSkinRect, CheckImageArea, TextArea,
    CheckImageRect, UnCheckImageRect: TRect;
    ActiveCheckImageRect, ActiveUnCheckImageRect: TRect;
    UnEnabledCheckImageRect, UnEnabledUnCheckImageRect: TRect;
    Morphing: Boolean;
    MorphKind: TbsMorphKind;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ChangeSkinData; override;
    procedure Paint; override;
    procedure PaintSkinTo(C: TCanvas; X, Y: Integer; AChecked: Boolean);
  published
    property WordWrap: boolean read FWordWrap write SetWordWrap;
    property AllowGrayed: Boolean read FAllowGrayed write SetAllowGrayed;
    property State: TCheckBoxState read FState write SetState;
    property Images: TCustomImageList read FImages write SetImages;
    property ImageIndex: Integer read FImageIndex write SetImageIndex;
    property Flat: Boolean read FFlat write SetFlat;
    property PopupMenu;
    property ShowHint;
    property TabStop;
    property TabOrder;
    property CanFocused: Boolean read FCanFocused write SetCanFocused;
    property Action;
    property Radio: Boolean read FRadio write SetRadio;
    property Checked: Boolean read FChecked write SetChecked;
    property GroupIndex: Integer read FGroupIndex write FGroupIndex;
    property Caption;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
    property Align;
    property Enabled;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnEnter;
    property OnExit;
  end;

  TbsSkinGauge = class(TbsSkinCustomControl)
  protected
    FUseSkinSize: Boolean;
    FMinValue, FMaxValue, FValue: Integer;
    FVertical: Boolean;
    FProgressText: String;
    FShowPercent: Boolean;
    FShowProgressText: Boolean;
    procedure SetShowProgressText(Value: Boolean);
    procedure SetShowPercent(Value: Boolean);
    procedure SetProgressText(Value: String);
    procedure SetVertical(AValue: Boolean);
    procedure SetMinValue(AValue: Integer);
    procedure SetMaxValue(AValue: Integer);
    procedure SetValue(AValue: Integer);
    procedure GetSkinData; override;
    procedure CreateImage(B: TBitMap);
    procedure CalcSize(var W, H: Integer); override;
    procedure DrawProgressText(C: TCanvas; AValue: Integer);
    procedure CreateControlDefaultImage(B: TBitMap); override;
    procedure CreateControlSkinImage(B: TBitMap); override;
    procedure WMEraseBkgnd(var Msg: TWMEraseBkgnd); message WM_ERASEBKGND;
    function GetPaintValue: Integer; virtual;
  public
    ProgressRect, ProgressArea: TRect;
    NewProgressArea: TRect;
    BeginOffset, EndOffset: Integer;
    FontName: String;
    FontStyle: TFontStyles;
    FontHeight: Integer;
    FontColor: TColor;
    ProgressTransparent: Boolean;
    ProgressTransparentColor: TColor;
    ProgressStretch: Boolean;
    constructor Create(AOwner: TComponent); override;
    function CalcProgressRect(R: TRect; AV: Boolean; AValue: Integer): TRect;
    procedure Paint; override;
  published
    property UseSkinSize: Boolean read FUseSkinSize write FUseSkinSize;
    property ProgressText: String read FProgressText write SetProgressText;
    property ShowProgressText: Boolean read FShowProgressText write SetShowProgressText;
    property ShowPercent: Boolean read FShowPercent write SetShowPercent;

    property MinValue: Integer read FMinValue write SetMinValue;
    property MaxValue: Integer read FMaxValue write SetMaxValue;
    property Value: Integer read FValue write SetValue;
    property Vertical: Boolean read FVertical write SetVertical;
    property Align;
    property Enabled;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property PopupMenu;
    property ShowHint;
  end;

  TbsSkinTextLabel = class(TGraphicControl)
  private
    FIndex: Integer;
    FSD: TbsSkinData;
    FSkinDataName: String;
    FDefaultFont: TFont;
    FUseSkinFont: Boolean;
    FUseSkinColor: Boolean;
    //
    FLines: TStrings;
    FAlignment: TAlignment;
    FAutoSize: Boolean;
    FLayout: TTextLayout;
    FWordWrap: Boolean;

    procedure SetSkinData(Value: TbsSkinData);
    procedure SetDefaultFont(Value: TFont);
    procedure SetLines(Value: TStrings);
    procedure SetAlignment(Value: TAlignment);
    procedure SetLayout(Value: TTextLayout);
    procedure SetWordWrap(Value: Boolean);
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure OnTextChange(Sender: TObject);
  protected
    function GetLabelText: string; virtual;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure SetAutoSize(Value: Boolean); virtual;
    procedure DoDrawText(var Rect: TRect; Flags: Longint);
  public
    FontName: String;
    FontStyle: TFontStyles;
    FontHeight: Integer;
    FontColor: TColor;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Canvas;
    procedure AdjustBounds; dynamic;
    procedure ChangeSkinData;
    procedure GetSkinData;
    procedure Paint; override;
  published
    property UseSkinFont: Boolean read FUseSkinFont write FUseSkinFont;
    property UseSkinColor: Boolean read FUseSkinColor write FUseSkinColor;
    property Lines: TStrings read FLines write SetLines;
    property DefaultFont: TFont read FDefaultFont write SetDefaultFont;
    property SkinData: TbsSkinData read FSD write SetSkinData;
    property SkinDataName: String read FSkinDataName write FSkinDataName;
    property Font;
    property Align;
    property Alignment: TAlignment read FAlignment write SetAlignment
      default taLeftJustify;
    property AutoSize: Boolean read FAutoSize write SetAutoSize default True;
    property Layout: TTextLayout read FLayout write SetLayout default tlTop;
    property WordWrap: Boolean read FWordWrap write SetWordWrap default False;
    property Anchors;
    property BiDiMode;
    property Constraints;                                      
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property ParentBiDiMode;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

  TbsSkinLinkImage = class(TImage)
  private
    FURL: String;
  protected
    procedure Click; override;
  public
    constructor Create(AOwner : TComponent); override;
  published
    property URL: string read FURL write FURL;
  end;

  TbsSkinLinkLabel = class(TCustomLabel)
  protected
    FMouseIn: Boolean;
    FIndex: Integer;
    FSD: TbsSkinData;
    FSkinDataName: String;
    FDefaultFont: TFont;
    FUseSkinFont: Boolean;
    FDefaultActiveFontColor: TColor;
     FURL: String;
    FUseUnderLine: Boolean;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure SetSkinData(Value: TbsSkinData);
    procedure SetDefaultFont(Value: TFont);
    property Transparent;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure GetSkinData;
    procedure DoDrawText(var Rect: TRect; Flags: Longint); override;
    procedure SetUseUnderLine(Value: Boolean);
  public
    FontName: String;
    FontStyle: TFontStyles;
    FontHeight: Integer;
    FontColor, ActiveFontColor: TColor;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ChangeSkinData;
    procedure Click; override;
  published
    property UseUnderLine: Boolean read FUseUnderLine write SetUseUnderLine;
    property UseSkinFont: Boolean read FUseSkinFont write FUseSkinFont;
    property DefaultActiveFontColor: TColor
      read FDefaultActiveFontColor write FDefaultActiveFontColor;
    property URL: String read FURL write FURL;
    property DefaultFont: TFont read FDefaultFont write SetDefaultFont;
    property SkinData: TbsSkinData read FSD write SetSkinData;
    property SkinDataName: String read FSkinDataName write FSkinDataName;
    property Font;
    property Align;
    property Alignment;
    property Anchors;
    property AutoSize;
    property BiDiMode;
    property Caption;
    property Color;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property FocusControl;
    property ParentBiDiMode;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowAccelChar;
    property ShowHint;
    property Layout;
    property Visible;
    property WordWrap;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

  TbsSkinButtonLabel = class(TGraphicControl)
  protected
    FWebStyle: Boolean;
    FMouseIn, FDown: Boolean;
    FIndex: Integer;
    FSD: TbsSkinData;
    FSkinDataName: String;
    FDefaultFont: TFont;
    FUseSkinFont: Boolean;
    FDefaultActiveFontColor: TColor;
    FGlyph: TBitMap;
    FNumGlyphs: TbsNumGlyphs;
    FMargin: Integer;
    FSpacing: Integer;
    FLayout: TbsButtonLayout;
    FImageList: TCustomImageList;
    FImageIndex: Integer;
    procedure SetImageIndex(Value: Integer);
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure SetSkinData(Value: TbsSkinData);
    procedure SetDefaultFont(Value: TFont);
    procedure SetLayout(Value : TbsButtonLayout);
    procedure SetMargin(Value: Integer);
    procedure SetSpacing(Value: Integer);
    procedure SetNumGlyphs(Value: TbsNumGlyphs);
    procedure SetGlyph(Value: TBitMap);
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure SetWebStyle(Value: Boolean);
  public
    FontColor: TColor;
    ActiveFontColor: TColor;
    FontName: String;
    FontHeight: Integer;
    FontStyle: TFontStyles;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ChangeSkinData;
    procedure Paint; override;
  published
    property ImageList: TCustomImageList read FImageList write FImageList;
    property ImageIndex: Integer read FImageIndex write SetImageIndex;
    property WebStyle: Boolean read FWebStyle write SetWebStyle;
    property Glyph: TBitMap read FGlyph write SetGlyph;
    property NumGlyphs: TbsNumGlyphs read FNumGlyphs write SetNumGlyphs;
    property Margin: Integer read FMargin write SetMargin default -1;
    property Spacing: Integer read FSpacing write SetSpacing default 4;
    property Layout: TbsButtonLayout read FLayout write SetLayout default blGlyphLeft;
    property UseSkinFont: Boolean read FUseSkinFont write FUseSkinFont;
    property DefaultActiveFontColor: TColor
      read FDefaultActiveFontColor write FDefaultActiveFontColor;
    property DefaultFont: TFont read FDefaultFont write SetDefaultFont;
    property SkinData: TbsSkinData read FSD write SetSkinData;
    property SkinDataName: String read FSkinDataName write FSkinDataName;
    property Align;
    property Anchors;
    property AutoSize;
    property BiDiMode;
    property Caption;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property ParentBiDiMode;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;


  TbsEllipsType = (bsetNone, bsetEndEllips, bsetPathEllips);

  TbsSkinStdLabel = class(TCustomLabel)
  protected
    FEllipsType: TbsEllipsType;
    FIndex: Integer;
    FSD: TbsSkinData;
    FSkinDataName: String;
    FDefaultFont: TFont;
    FUseSkinFont: Boolean;
    FUseSkinColor: Boolean;
    procedure SetEllipsType(const Value: TbsEllipsType);
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure SetSkinData(Value: TbsSkinData);
    procedure SetDefaultFont(Value: TFont);
    property Transparent;
    procedure DoDrawText(var Rect: TRect; Flags: Longint); override;
    procedure DoDrawText2(C: TCanvas; var Rect: TRect; Flags: Longint; AText: String);
  public
    FontName: String;
    FontStyle: TFontStyles;
    FontHeight: Integer;
    FontColor: TColor;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure GetSkinData;
    procedure ChangeSkinData;
    procedure PaintSkinTo(C: TCanvas; X, Y: Integer; AText: String);
  published
    property EllipsType: TbsEllipsType read FEllipsType write SetEllipsType;
    property UseSkinFont: Boolean read FUseSkinFont write FUseSkinFont;
    property UseSkinColor: Boolean read FUseSkinColor write FUseSkinColor;
    property DefaultFont: TFont read FDefaultFont write SetDefaultFont;
    property SkinData: TbsSkinData read FSD write SetSkinData;
    property SkinDataName: String read FSkinDataName write FSkinDataName;
    property Font;
    property Align;
    property Alignment;
    property Anchors;
    property AutoSize;
    property BiDiMode;
    property Caption;
    property Color;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property FocusControl;
    property ParentBiDiMode;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowAccelChar;
    property ShowHint;
    property Layout;
    property Visible;
    property WordWrap;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

  TbsEllipsType2 = (bsetNoneEllips, bsetEllips);

  TbsSkinLabel = class(TbsSkinCustomControl)
  protected
    FEllipsType: TbsEllipsType2;
    FUseSkinSize: Boolean;
    FAlignment: TAlignment;
    FAutoSize: Boolean;
    FBorderStyle: TbsSkinBorderStyle;
    FUseSkinFontColor: Boolean;
    procedure SetEllipsType(Value: TbsEllipsType2);
    procedure SetBorderStyle(Value: TbsSkinBorderStyle);
    procedure DrawLabelText(Cnvs: TCanvas; R: TRect);
    function CalcWidthOffset: Integer; virtual;
    procedure AdjustBounds;
    procedure PaintLabel(B: TBitMap);
    procedure SetAutoSizeX(Value: Boolean);
    procedure SetAlignment(Value: TAlignment);
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure CalcSize(var W, H: Integer); override;
    procedure GetSkinData; override;
    procedure CreateControlDefaultImage(B: TBitMap); override;
    procedure CreateControlSkinImage(B: TBitMap); override;
    procedure SetControlRegion; override;
    procedure WMEraseBkgnd(var Msg: TWMEraseBkgnd); message WM_ERASEBKGND;
  public
    FontName: String;
    FontStyle: TFontStyles;
    FontHeight: Integer;
    FontColor: TColor;
    constructor Create(AOwner: TComponent); override;
  published
    property EllipsType: TbsEllipsType2 read FEllipsType write SetEllipsType;
    property UseSkinSize: Boolean read FUseSkinSize write FUseSkinSize;
    property UseSkinFontColor: Boolean
      read FUseSkinFontColor write FUseSkinFontColor;
    property BorderStyle: TbsSkinBorderStyle
      read FBorderStyle write SetBorderStyle;
    property Alignment: TAlignment read FAlignment write SetAlignment
      default taLeftJustify;
    property Align;
    property Caption;
    property DragCursor;
    property BiDiMode;
    property DragKind;
    property DragMode;
    property Enabled;
    property PopupMenu;
    property ShowHint;
    property Visible;
    property AutoSize: Boolean read FAutoSize write SetAutoSizeX;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

  TbsSkinTrackBar = class(TbsSkinCustomControl)
  protected
    FClicksDisabled: Boolean;
    FCanFocused: Boolean;
    Offset1, Offset2, BOffset: Integer;
    BR: TRect;
    FMinValue, FMaxValue, FValue: Integer;
    FVertical: Boolean;
    FMouseSupport, FDown: Boolean;
    OMPos: Integer;
    OldBOffset: Integer;
    FOnChange: TNotifyEvent;
    FOnLastChange: TNotifyEvent;
    FOnStartDragButton: TNotifyEvent;
    FJumpWhenClick: Boolean;
    function IsFocused: Boolean;
    procedure SetCanFocused(Value: Boolean);
    procedure SetVertical(AValue: Boolean);
    procedure SetMinValue(AValue: Integer);
    procedure SetMaxValue(AValue: Integer);
    procedure SetValue(AValue: Integer);
    procedure GetSkinData; override;
    procedure CreateImage(B: TBitMap);
    procedure CalcSize(var W, H: Integer); override;
    function CalcButtonRect(R: TRect): TRect;
    function CalcValue(AOffset: Integer): Integer;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;

    procedure WMMOUSEWHEEL(var Message: TMessage); message WM_MOUSEWHEEL;
    procedure WMSETFOCUS(var Message: TWMSETFOCUS); message WM_SETFOCUS;
    procedure WMKILLFOCUS(var Message: TWMKILLFOCUS); message WM_KILLFOCUS;
    procedure WndProc(var Message: TMessage); override;
    procedure CMWantSpecialKey(var Msg: TCMWantSpecialKey); message CM_WANTSPECIALKEY;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;

    procedure CreateControlDefaultImage(B: TBitMap); override;
    procedure CreateControlSkinImage(B: TBitMap); override;

    procedure WMEraseBkgnd(var Msg: TWMEraseBkgnd); message WM_ERASEBKGND;

  public
    TrackArea, NewTrackArea, ButtonRect, ActiveButtonRect: TRect;
    ButtonTransparent: Boolean;
    ButtonTransparentColor: TColor;
    constructor Create(AOwner: TComponent); override;
  published
    property JumpWhenClick: Boolean read FJumpWhenClick write FJumpWhenClick;
    property PopupMenu;
    property ShowHint;
    property TabStop;
    property TabOrder;
    property CanFocused: Boolean read FCanFocused write SetCanFocused;
    property MouseSupport: Boolean read FMouseSupport write FMouseSupport;
    property MinValue: Integer read FMinValue write SetMinValue;
    property MaxValue: Integer read FMaxValue write SetMaxValue;
    property Value: Integer read FValue write SetValue;
    property Vertical: Boolean read FVertical write SetVertical;
    property Align;
    property Enabled;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnLastChange: TNotifyEvent read FOnLastChange write FOnLastChange;
    property OnStartDragButton: TNotifyEvent
      read FOnStartDragButton write FOnStartDragButton;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
  end;

  TbsSkinScrollBar = class(TbsSkinCustomControl)
  private
    FNormalSkinDataName: String;
    FBothSkinDataName: String;
    Offset1, Offset2, BOffset: Integer;
    NewTrackArea: TRect;
    FDown: Boolean;
    OMPos, OldPosition, FScrollWidth: Integer;
    OldBOffset: Integer;
    MX, MY: Integer;
    MouseD: Boolean;
  protected
    WaitMode: Boolean;
    FBothMarkerWidth: Integer;
    FClicksDisabled: Boolean;
    FCanFocused: Boolean;
    //
    FOnChange: TNotifyEvent;
    FOnUpButtonClick: TNotifyEvent;
    FOnDownButtonClick: TNotifyEvent;
    FOnLastChange: TNotifyEvent;
    FOnPageUp: TNotifyEvent;
    FOnPageDown: TNotifyEvent;
    //
    TimerMode: Integer;
    ActiveButton, OldActiveButton, CaptureButton: Integer;
    Buttons: array[0..2] of TbsControlButton;
    FMin, FMax, FSmallChange,
    FLargeChange, FPosition: Integer;
    FKind: TScrollBarKind;
    FPageSize: Integer;
    procedure SetBoth(Value: Boolean);
    procedure SetBothMarkerWidth(Value: Integer);
    function IsFocused: Boolean;
    procedure SetCanFocused(Value: Boolean);
    procedure TestActive(X, Y: Integer);
    procedure SetPageSize(AValue: Integer);
    procedure ButtonDown(I: Integer; X, Y: Integer);
    procedure ButtonUp(I: Integer; X, Y: Integer);
    procedure ButtonEnter(I: Integer);
    procedure ButtonLeave(I: Integer);
    procedure CalcRects;
    function CalcValue(AOffset: Integer): Integer;
    procedure SetKind(AValue: TScrollBarKind);
    procedure SetPosition(AValue: Integer);
    procedure SetMin(AValue: Integer);
    procedure SetMax(AValue: Integer);
    procedure SetSmallChange(AValue: Integer);
    procedure SetLargeChange(AValue: Integer);

    procedure CalcSize(var W, H: Integer); override;
    procedure GetSkinData; override;

    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure WMTimer(var Message: TWMTimer); message WM_Timer;
    procedure StartScroll;
    procedure StopTimer;

    procedure DrawButton(Cnvs: TCanvas; i: Integer);

    procedure WMMOUSEWHEEL(var Message: TMessage); message WM_MOUSEWHEEL;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure WMSETFOCUS(var Message: TWMSETFOCUS); message WM_SETFOCUS;
    procedure WMKILLFOCUS(var Message: TWMKILLFOCUS); message WM_KILLFOCUS;
    procedure WMEraseBkgnd(var Msg: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WndProc(var Message: TMessage); override;
    procedure CMWantSpecialKey(var Msg: TCMWantSpecialKey); message CM_WANTSPECIALKEY;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;

    procedure CreateControlDefaultImage(B: TBitMap); override;
    procedure CreateControlSkinImage(B: TBitMap); override;

  public
    FBoth: Boolean;
    TrackArea: TRect;
    UpButtonRect, ActiveUpButtonRect, DownUpButtonRect: TRect;
    DownButtonRect, ActiveDownButtonRect, DownDownButtonRect: TRect;
    ThumbRect, ActiveThumbRect, DownThumbRect: TRect;
    ThumbOffset1, ThumbOffset2: Integer;
    ThumbTransparent: Boolean;
    ThumbTransparentColor: TColor;
    GlyphRect, ActiveGlyphRect, DownGlyphRect: TRect;
    procedure SimplySetPosition(AValue: Integer);
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetRange(AMin, AMax, APosition, APageSize: Integer);
  published
    property Enabled;
    property Both: Boolean read FBoth write SetBoth;
    property BothMarkerWidth: Integer
      read FBothMarkerWidth write SetBothMarkerWidth;
    property BothSkinDataName: String
      read FBothSkinDataName write FBothSkinDataName;  
    property TabStop;
    property TabOrder;
    property CanFocused: Boolean read FCanFocused write SetCanFocused;
    property Align;
    property Kind: TScrollBarKind read FKind write SetKind;
    property PageSize: Integer read FPageSize write SetPageSize;
    property Min: Integer read FMin write SetMin;
    property Max: Integer read FMax write SetMax;
    property Position: Integer read FPosition write SetPosition;
    property SmallChange: Integer read FSmallChange write SetSmallChange;
    property LargeChange: Integer read FLargeChange write SetLargeChange;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnLastChange: TNotifyEvent read FOnLastChange write FOnLastChange;
    property OnUpButtonClick: TNotifyEvent read FOnUpButtonClick write FOnUpButtonClick;
    property OnDownButtonClick: TNotifyEvent read FOnDownButtonClick write FOnDownButtonClick;
    property OnPageUp: TNotifyEvent read FOnPageUp write FOnPageUp;
    property OnPageDown: TNotifyEvent read FOnPageDown write FOnPageDown;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
  end;

  TbsSkinCoolBar = class(TCoolBar)
  protected
    FSkinBevel: Boolean;
    FIndex: Integer;
    FSD: TbsSkinData;
    FSkinDataName: String;
    procedure DrawGrip(C: TCanvas; R: TRect); 
    procedure PaintNCSkin(ADC: HDC; AUseExternalDC: Boolean);
    procedure SetSkinBevel(Value: Boolean);
    procedure SetSkinData(Value: TbsSkinData);
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure WMNCCALCSIZE(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMSIZE(var Message: TWMSIZE); message WM_SIZE;
    procedure WMNCPAINT(var Message: TMessage); message WM_NCPAINT;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure CMBENCPaint(var Message: TMessage); message CM_BENCPAINT;
    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    function GetCaptionSize(Band: TCoolBand): Integer;
    function GetCaptionFontHeight: Integer;
  public
    LTPt, RTPt, LBPt, RBPt: TPoint;
    SkinRect, ClRect, NewClRect, ItemRect: TRect;
    NewLTPoint, NewRTPoint, NewLBPoint, NewRBPoint: TPoint;
    FSkinPicture: TBitMap;
    BGPictureIndex: Integer;
    HGripRect, VGripRect: TRect;
    GripOffset1, GripOffset2: Integer;
    LeftStretch, TopStretch, RightStretch, BottomStretch: Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure GetSkinData;
    procedure ChangeSkinData;
  published
    property SkinDataName: String read FSkinDataName write FSkinDataName;
    property SkinData: TbsSkinData read FSD write SetSkinData;
    property SkinBevel: Boolean read FSkinBevel write SetSkinBevel;
    property Align;
    property Anchors;
    property AutoSize;
    property BevelEdges;
    property BevelInner;
    property BevelOuter;
    property BevelKind;
    property BevelWidth;
    property BorderWidth;
    property Color;
    property Constraints;
    property DockSite;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnCanResize;
    property OnClick;
    property OnConstrainedResize;
    property OnDockDrop;
    property OnDockOver;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetSiteInfo;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
  end;

  TbsSkinControlBar = class(TCustomControlBar)
  protected
    FSkinBevel: Boolean;
    FIndex: Integer;
    FSD: TbsSkinData;
    FSkinDataName: String;
    procedure PaintNCSkin(ADC: HDC; AUseExternalDC: Boolean);
    procedure SetSkinBevel(Value: Boolean);
    procedure SetSkinData(Value: TbsSkinData);
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure WMNCCALCSIZE(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMSIZE(var Message: TWMSIZE); message WM_SIZE;
    procedure WMNCPAINT(var Message: TMessage); message WM_NCPAINT;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure PaintControlFrame(Canvas: TCanvas; AControl: TControl;
      var ARect: TRect); override;
    procedure CMBENCPaint(var Message: TMessage); message CM_BENCPAINT;
  public
    LTPt, RTPt, LBPt, RBPt: TPoint;
    SkinRect, ClRect, NewClRect, ItemRect: TRect;
    NewLTPoint, NewRTPoint, NewLBPoint, NewRBPoint: TPoint;
    FSkinPicture: TBitMap;
    BGPictureIndex: Integer;
    LeftStretch, TopStretch, RightStretch, BottomStretch: Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
    property Canvas;
    procedure GetSkinData;
    procedure ChangeSkinData;
  published
    property SkinDataName: String read FSkinDataName write FSkinDataName;
    property SkinData: TbsSkinData read FSD write SetSkinData;
    property SkinBevel: Boolean read FSkinBevel write SetSkinBevel;
    property Align;
    property Anchors;
    property AutoDrag;
    property AutoSize;
    property BevelEdges;
    property BevelInner;
    property BevelOuter;
    property BevelKind;
    property BevelWidth;
    property BorderWidth;
    property Color;
    property Constraints;
    property DockSite;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property Picture;
    property PopupMenu;
    property RowSize;
    property RowSnap;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnBandDrag;
    property OnBandInfo;
    property OnBandMove;
    property OnBandPaint;
    property OnCanResize;
    property OnClick;
    property OnConstrainedResize;
    property OnDockDrop;
    property OnDockOver;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetSiteInfo;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnPaint;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
  end;

  TbsSkinSplitter = class(TSPlitter)
  protected
    FTransparent: Boolean;
    FDefaultSize: Integer;
    FIndex: Integer;
    FSD: TbsSkinData;
    FSkinDataName: String;
    procedure SetSkinData(Value: TbsSkinData);
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure SetTransparent(Value: Boolean);
  public
    LTPt, RTPt, LBPt: TPoint;
    SkinRect: TRect;
    FSkinPicture: TBitMap;
    StretchEffect: Boolean;
    GripperRect: TRect;
    GripperTransparent: Boolean;
    GripperTransparentColor: TColor;
    procedure GetSkinData;
    procedure ChangeSkinData;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
  published
    property Transparent: Boolean read FTransparent write SetTransparent;
    property DefaultSize: Integer read FDefaultSize write FDefaultSize;
    property SkinDataName: String read FSkinDataName write FSkinDataName;
    property SkinData: TbsSkinData read FSD write SetSkinData;
    property OnClick;
    property OnDblClick;
  end;

  TbsSkinCustomRadioGroup = class(TbsSkinGroupBox)
  private
    FImages: TCustomImageList;
    FButtonSkinDataName: String;
    FButtons: TList;
    FItems: TStrings;
    FItemIndex: Integer;
    FColumns: Integer;
    FReading: Boolean;
    FUpdating: Boolean;
    FButtonDefaultFont: TFont;
    procedure SetImages(Value: TCustomImageList);
    procedure SetButtonDefaultFont(Value: TFont);
    procedure SetButtonSkinDataName(Value: String);
    procedure ArrangeButtons;
    procedure ButtonClick(Sender: TObject);
    procedure ItemsChange(Sender: TObject);
    procedure SetButtonCount(Value: Integer);
    procedure SetColumns(Value: Integer);
    procedure SetItemIndex(Value: Integer);
    procedure SetItems(Value: TStrings);
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
  protected
    procedure UpdateButtons;
    procedure SetSkinData(Value: TbsSkinData); override;
    procedure Loaded; override;
    procedure ReadState(Reader: TReader); override;
    function CanModify: Boolean; virtual;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    property Columns: Integer read FColumns write SetColumns default 1;
    property ItemIndex: Integer read FItemIndex write SetItemIndex default -1;
    property Items: TStrings read FItems write SetItems;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure UpdateButtonsFont;
    procedure ChangeSkinData; override;
    procedure FlipChildren(AllLevels: Boolean); override;
    property ButtonDefaultFont: TFont
      read FButtonDefaultFont write SetButtonDefaultFont;
    property ButtonSkinDataName: String
      read FButtonSkinDataName write SetButtonSkinDataName;
    property Images: TCustomImageList read FImages write SetImages;
  end;

  TbsSkinCustomCheckGroup = class(TbsSkinGroupBox)
  private
    FImages: TCustomImageList;
    FItemIndex: Integer;
    FButtonSkinDataName: String;
    FButtons: TList;
    FItems: TStrings;
    FColumns: Integer;
    FReading: Boolean;
    FUpdating: Boolean;
    FButtonDefaultFont: TFont;
    procedure SetButtonDefaultFont(Value: TFont);
    procedure SetButtonSkinDataName(Value: String);
    procedure ArrangeButtons;
    procedure ButtonClick(Sender: TObject);
    procedure ItemsChange(Sender: TObject);
    procedure SetButtonCount(Value: Integer);
    procedure SetColumns(Value: Integer);
    procedure SetItems(Value: TStrings);
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure SetImages(Value: TCustomImageList);
  protected
    procedure UpdateButtons;
    procedure SetSkinData(Value: TbsSkinData); override;
    procedure Loaded; override;
    procedure ReadState(Reader: TReader); override;
    function CanModify: Boolean; virtual;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;

    function GetCheckedStatus(Index: Integer): Boolean;
    procedure SetCheckedStatus(Index: Integer; Value: Boolean);

    property Columns: Integer read FColumns write SetColumns default 1;
    property Items: TStrings read FItems write SetItems;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure UpdateButtonsFont;
    procedure ChangeSkinData; override;
    procedure FlipChildren(AllLevels: Boolean); override;
    property ButtonDefaultFont: TFont
      read FButtonDefaultFont write SetButtonDefaultFont;
    property ButtonSkinDataName: String
      read FButtonSkinDataName write SetButtonSkinDataName;
    property ItemChecked[Index: Integer]: Boolean read GetCheckedStatus write SetCheckedStatus;
    property ItemIndex: Integer read FItemIndex;
    property Images: TCustomImageList read FImages write SetImages;
  end;

  TbsSkinCheckGroup = class(TbsSkinCustomCheckGroup)
  published
    property Images;
    property ButtonSkinDataName;
    property ButtonDefaultFont;
    property Align;
    property Anchors;
    property BiDiMode;
    property Caption;
    property Color;
    property Columns;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property Items;
    property ItemIndex;
    property Constraints;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnStartDock;
    property OnStartDrag;
  end;

  TbsSkinRadioGroup = class(TbsSkinCustomRadioGroup)
  published
    property Images;
    property ButtonSkinDataName;
    property ButtonDefaultFont;
    property Align;
    property Anchors;
    property BiDiMode;
    property Caption;
    property Color;
    property Columns;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ItemIndex;
    property Items;
    property Constraints;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnStartDock;
    property OnStartDrag;
  end;

  TbsSkinCustomTreeView = class(TCustomTreeView)
  protected
    FInCheckScrollBars: Boolean;
    FSD: TbsSkinData;
    FSkinDataName: String;
    FIndex: Integer;
    FDefaultFont: TFont;
    FUseSkinFont: Boolean;
    FDefaultColor: TColor;

    FVScrollBar: TbsSkinScrollBar;
    FHScrollBar: TbsSkinScrollBar;

    procedure Notification(AComponent: TComponent;
     Operation: TOperation); override;
    procedure SetDefaultColor(Value: TColor);
    procedure SetDefaultFont(Value: TFont);
    procedure SetSkinData(Value: TbsSkinData);
    procedure SetVScrollBar(Value: TbsSkinScrollBar);
    procedure SetHScrollBar(Value: TbsSkinScrollBar);
    procedure WMNCCALCSIZE(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCPAINT(var Message: TWMNCPAINT); message WM_NCPAINT;
    procedure WndProc(var Message: TMessage); override;
    procedure CMVisibleChanged(var Message: TMessage); message CM_VISIBLECHANGED;
    procedure OnVScrollBarChange(Sender: TObject);
    procedure OnHScrollBarChange(Sender: TObject);
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Change(Node: TTreeNode); override;
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ChangeSkinData; virtual;
    procedure UpDateScrollBars;
    property HScrollBar: TbsSkinScrollBar read FHScrollBar
                                          write SetHScrollBar;
    property VScrollBar: TbsSkinScrollBar read FVScrollBar
                                          write SetVScrollBar;
    property DefaultFont: TFont read FDefaultFont write SetDefaultFont;
    property SkinData: TbsSkinData read FSD write SetSkinData;
    property SkinDataName: String read FSkinDataName write FSkinDataName;
    property DefaultColor: TColor read FDefaultColor write SetDefaultColor;
    property UseSkinFont: Boolean read FUseSkinFont write FUseSkinFont;
  end;

  TbsSkinTreeView = class(TbsSkinCustomTreeView)
  published
    property Items;
    property HScrollBar;
    property VScrollBar;
    property DefaultFont;
    property UseSkinFont;
    property SkinData;
    property SkinDataName;
    property DefaultColor;

    property Align;
    property Anchors;
    property AutoExpand;
    property BiDiMode;
    property ChangeDelay;
    property Color;
    property Constraints;
    property DragKind;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property HideSelection;
    property HotTrack;
    property Images;
    property Indent;
    {$IFDEF VER140}
    property MultiSelect;
    property MultiSelectStyle;
    {$ENDIF}

   {$IFDEF VER150}
    property MultiSelect;
    property MultiSelectStyle;
    {$ENDIF}
    property ParentBiDiMode;
    property ParentColor default False;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property RightClickSelect;
    property RowSelect;
    property ShowButtons;
    property ShowHint;
    property ShowLines;
    property ShowRoot;
    property SortType;
    property StateImages;
    property TabOrder;
    property TabStop default True;
    property ToolTips;
    property Visible;
    {$IFDEF VER140}
    property OnAddition;
    {$ENDIF}
    {$IFDEF VER150}
    property OnAddition;
    {$ENDIF}
    property OnAdvancedCustomDraw;
    property OnAdvancedCustomDrawItem;
    property OnChange;
    property OnChanging;
    property OnClick;
    property OnCollapsed;
    property OnCollapsing;
    property OnCompare;
    property OnContextPopup;
    {$IFDEF VER140}
    property OnCreateNodeClass;
    {$ENDIF}
    {$IFDEF VER150}
    property OnCreateNodeClass;
    {$ENDIF}
    property OnCustomDraw;
    property OnCustomDrawItem;
    property OnDblClick;
    property OnDeletion;
    property OnDragDrop;
    property OnDragOver;
    property OnEdited;
    property OnEditing;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnExpanding;
    property OnExpanded;
    property OnGetImageIndex;
    property OnGetSelectedIndex;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

  TbsDrawHeaderSectionEvent = procedure (Cnvs: TCanvas; Column: TListColumn;
                               Pressed: Boolean; R: TRect) of object;

  TbsSkinCustomListView = class(TCustomListView)
  protected
    FHeaderSkinDataName: String;
    FInCheckScrollBars: Boolean;
    FromSB: Boolean;
    FSD: TbsSkinData;
    FSkinDataName: String;
    FIndex: Integer;
    FDefaultFont: TFont;
    FUseSkinFont: Boolean;
    FDefaultColor: TColor;
    //
    FVScrollBar: TbsSkinScrollBar;
    FHScrollBar: TbsSkinScrollBar;
    FOldVScrollBarPos: Integer;
    FOldHScrollBarPos: Integer;
    //
    FHeaderHandle: HWND;
    FHeaderInstance: Pointer;
    FDefHeaderProc: Pointer;
    FActiveSection: Integer;
    FHeaderDown: Boolean;
    FHeaderInDivider: Boolean;
    //
    FHIndex: Integer;
    HLTPt, HRTPt, HLBPt, HRBPt: TPoint;
    HSkinRect, HClRect: TRect;
    HNewLTPoint, HNewRTPoint, HNewLBPoint, HNewRBPoint: TPoint;
    HNewClRect: TRect;
    HPicture: TBitMap;
    HFontColor, HActiveFontColor, HDownFontColor: TColor;
    HActiveSkinRect, HDownSkinRect: TRect;
    HStretchEffect: Boolean;
    HLeftStretch, HTopStretch, HRightStretch, HBottomStretch: Boolean;
    //
    FOnDrawHeaderSection: TbsDrawHeaderSectionEvent;
    //
    procedure HGetSkinData;
    function GetHeaderSectionRect(Index: Integer): TRect;
    procedure Notification(AComponent: TComponent;
     Operation: TOperation); override;
    procedure SetDefaultColor(Value: TColor);
    procedure SetDefaultFont(Value: TFont);
    procedure SetSkinData(Value: TbsSkinData);

    procedure UpDateScrollBars1;
    procedure UpDateScrollBars2;
    procedure UpDateScrollBars3;
    procedure SetVScrollBar(Value: TbsSkinScrollBar);
    procedure SetHScrollBar(Value: TbsSkinScrollBar);
    procedure WMNCCALCSIZE(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCPAINT(var Message: TWMNCPAINT); message WM_NCPAINT;
    procedure CMVisibleChanged(var Message: TMessage); message CM_VISIBLECHANGED;
    procedure WndProc(var Message: TMessage); override;
    procedure OnVScrollBarChange(Sender: TObject);
    procedure OnHScrollBarChange(Sender: TObject);
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Loaded; override;
    //
    procedure HeaderWndProc(var Message: TMessage);
    procedure DrawHeaderSection(Cnvs: TCanvas; Column: TListColumn;
      Active, Pressed: Boolean; R: TRect);
    procedure PaintHeader(DC: HDC);
    procedure CreateWnd; override;
    //
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure UpDateScrollBars;
    procedure ChangeSkinData;
    property HScrollBar: TbsSkinScrollBar read FHScrollBar
                                          write SetHScrollBar;
    property VScrollBar: TbsSkinScrollBar read FVScrollBar
                                          write SetVScrollBar;
    property DefaultFont: TFont read FDefaultFont write SetDefaultFont;
    property UseSkinFont: Boolean read FUseSkinFont write FUseSkinFont;
    property SkinData: TbsSkinData read FSD write SetSkinData;
    property SkinDataName: String read FSkinDataName write FSkinDataName;
    property DefaultColor: TColor read FDefaultColor write SetDefaultColor;
    property HeaderSkinDataName: String
      read FHeaderSkinDataName write FHeaderSkinDataName;
    property OnDrawHeaderSection: TbsDrawHeaderSectionEvent
      read FOnDrawHeaderSection write FOnDrawHeaderSection;  
  end;

  TbsSkinListView = class(TbsSkinCustomListView)
  published
    property DefaultFont;
    property DefaultColor;
    property UseSkinFont;
    property SkinData;
    property SkinDataName;
    property Anchors;
    property Action;
    property Align;
    property AllocBy;
    property BiDiMode;
    property Checkboxes;
    property Color;
    property Columns;
    property ColumnClick;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property FullDrag;
    property GridLines;
    property HideSelection;
    property HotTrack;
    property HotTrackStyles;
    property HoverTime;
    property IconOptions;
    property Items;
    property LargeImages;
    property MultiSelect;
    property OwnerData;
    property OwnerDraw;
    property ReadOnly default False;
    property RowSelect;
    property ParentBiDiMode;
    property ParentColor default False;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowColumnHeaders;
    property ShowWorkAreas;
    property ShowHint;
    property SmallImages;
    property SortType;
    property StateImages;
    property TabOrder;
    property TabStop default True;
    property ViewStyle;
    property Visible;
    property HeaderSkinDataName;
    property HScrollBar;
    property VScrollBar;
    property OnAdvancedCustomDraw;
    property OnAdvancedCustomDrawItem;
    property OnAdvancedCustomDrawSubItem;
    property OnChange;
    property OnChanging;
    property OnClick;
    property OnColumnClick;
    property OnColumnDragged;
    property OnColumnRightClick;
    property OnCompare;
    property OnContextPopup;
    property OnCustomDraw;
    property OnCustomDrawItem;
    property OnCustomDrawSubItem;
    property OnDrawHeaderSection;
    property OnData;
    property OnDataFind;
    property OnDataHint;
    property OnDataStateChange;
    property OnDblClick;
    property OnDeletion;
    property OnDrawItem;
    property OnEdited;
    property OnEditing;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetImageIndex;
    property OnGetSubItemImage;
    property OnDragDrop;
    property OnDragOver;
    property OnInfoTip;
    property OnInsert;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnSelectItem;
    property OnStartDock;
    property OnStartDrag;
  end;

  TbsSkinRichEdit = class(TCustomRichEdit)
  protected
    FSkinSupport: Boolean;
    FSD: TbsSkinData;
    FSkinDataName: String;
    FIndex: Integer;
    FDefaultFont: TFont;
    FDefaultColor: TColor;
    //
    FVScrollBar: TbsSkinScrollBar;
    FHScrollBar: TbsSkinScrollBar;
    FOldVScrollBarPos: Integer;
    FOldHScrollBarPos: Integer;

    procedure Notification(AComponent: TComponent;
     Operation: TOperation); override;
    procedure SetDefaultColor(Value: TColor);
    procedure SetDefaultFont(Value: TFont);
    procedure SetSkinData(Value: TbsSkinData);

    procedure SetVScrollBar(Value: TbsSkinScrollBar);
    procedure SetHScrollBar(Value: TbsSkinScrollBar);
    function VScrollDisabled: boolean;
    function HScrollDisabled: boolean;
    procedure WMNCCALCSIZE(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMMOUSEWHEEL(var Message: TMessage); message WM_MOUSEWHEEL;
    procedure WMNCPAINT(var Message: TWMNCPAINT); message WM_NCPAINT;
    procedure WndProc(var Message: TMessage); override;
    procedure OnVScrollBarChange(Sender: TObject);
    procedure OnHScrollBarChange(Sender: TObject);

    procedure Loaded; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure OnVScrollBarUpButtonClick(Sender: TObject);
    procedure OnVScrollBarDownButtonClick(Sender: TObject);
    procedure Change; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure UpDateScrollBars;
    procedure ChangeSkinData;
  published
    property Align;
    property Alignment;
    property Anchors;
    property BiDiMode;
    property Color;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property HideSelection;
    property ImeMode;
    property ImeName;
    property Constraints;
    property Lines;
    property MaxLength;
    property ParentBiDiMode;
    property ParentFont;
    property ParentShowHint;
    property PlainText;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop default True;
    property Visible;
    property WantTabs;
    property WantReturns;
    property WordWrap;
    property SkinSupport: Boolean read FSkinSupport write FSkinSupport;
    property HScrollBar: TbsSkinScrollBar read FHScrollBar
                                          write SetHScrollBar;
    property VScrollBar: TbsSkinScrollBar read FVScrollBar
                                          write SetVScrollBar;
    property DefaultFont: TFont read FDefaultFont write SetDefaultFont;
    property SkinData: TbsSkinData read FSD write SetSkinData;
    property SkinDataName: String read FSkinDataName write FSkinDataName;
    property DefaultColor: TColor read FDefaultColor write SetDefaultColor;
    property OnChange;
    property OnContextPopup;
    property OnDragDrop;
    property OnDragOver;
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
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnProtectChange;
    property OnResizeRequest;
    property OnSaveClipboard;
    property OnSelectionChange;
    property OnStartDock;
    property OnStartDrag;
  end;

  TbsStatusPanelNumGlyphs = 1..2;

  TbsSkinStatusPanel = class(TbsSkinLabel)
  private
    FImageList: TCustomImageList;
    FImageIndex: Integer;
    FGlyph: TBitMap;
    FNumGlyphs: TbsStatusPanelNumGlyphs;
    procedure SetImageIndex(Value: Integer);
    procedure SetNumGlyphs(Value: TbsStatusPanelNumGlyphs);
    procedure SetGlyph(Value: TBitMap);
  protected
    procedure Notification(AComponent: TComponent;  Operation: TOperation); override;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CreateControlDefaultImage(B: TBitMap); override;
    procedure CreateControlSkinImage(B: TBitMap); override;
    function CalcWidthOffset: Integer; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property ImageList: TCustomImageList read FImageList write FImageList;
    property ImageIndex: Integer read FImageIndex write SetImageIndex;
    property NumGlyphs: TbsStatusPanelNumGlyphs read FNumGlyphs write SetNumGlyphs;
    property Glyph: TBitMap read FGlyph write SetGlyph;
  end;

  TbsGraphicSkinControl = class(TGraphicControl)
  protected
    FSD: TbsSkinData;
    FSkinDataName: String;
    FOnMouseEnter, FOnMouseLeave: TNotifyEvent;
    procedure Notification(AComponent: TComponent;  Operation: TOperation); override;
    procedure GetSkinData; virtual;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure SetSkinData(Value: TbsSkinData); virtual;

    procedure CreateControlDefaultImage(B: TBitMap); virtual;
    procedure CreateControlSkinImage(B: TBitMap); virtual;

  public
    FIndex: Integer;
    procedure Paint; override;
    procedure ChangeSkinData; virtual;
    procedure BeforeChangeSkinData; virtual;
    destructor Destroy; override;
    constructor Create(AOwner: TComponent); override;
  published
    property Anchors;
    property Visible;
    property SkinData: TbsSkinData read FSD write SetSkinData;
    property SkinDataName: String read FSkinDataName write FSkinDataName;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
  end;

  TbsGraphicSkinCustomControl = class(TbsGraphicSkinControl)
  protected
    FDefaultWidth: Integer;
    FDefaultHeight: Integer;
    FDefaultFont: TFont;
    FUseSkinFont: Boolean;

    LTPt, RTPt, LBPt, RBPt: TPoint;
    SkinRect, ClRect: TRect;
    NewLTPoint, NewRTPoint, NewLBPoint, NewRBPoint: TPoint;
    NewClRect: TRect;
    Picture: TBitMap;
    ResizeMode: Integer;
    StretchEffect: Boolean;
    LeftStretch, TopStretch, RightStretch, BottomStretch: Boolean;
    function GetRealClientWidth: Integer;
    function GetRealClientHeight: Integer;
    function GetRealClientLeft: Integer;
    function GetRealClientTop: Integer;

    procedure OnDefaultFontChange(Sender: TObject);
    procedure SetDefaultWidth(Value: Integer);
    procedure SetDefaultHeight(Value: Integer);
    procedure SetDefaultFont(Value: TFont);
    procedure DefaultFontChange; virtual;
    function GetNewRect(R: TRect): TRect;
    function GetResizeMode: Integer;
    procedure CalcSize(var W, H: Integer); virtual;

    procedure CreateSkinControlImage(B, SB: TBitMap; R: TRect);

    procedure GetSkinData; override;

    procedure CreateControlDefaultImage(B: TBitMap); override;
    procedure CreateControlSkinImage(B: TBitMap); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure ChangeSkinData; override;
    property RealClientRect: TRect read NewClRect;
    property RealClientWidth: integer read GetRealClientWidth;
    property RealClientHeight: integer read GetRealClientHeight;
    property RealClientLeft: integer read GetRealClientLeft;
    property RealClientTop: integer read GetRealClientTop;
  published
    property DefaultFont: TFont read FDefaultFont write SetDefaultFont;
    property DefaultWidth: Integer read FDefaultWidth write SetDefaultWidth;
    property DefaultHeight: Integer read FDefaultHeight write SetDefaultHeight;
    property UseSkinFont: Boolean read FUseSkinFont write FUseSkinFont;
  end;

  TbsSkinSpeedButton = class(TbsGraphicSkinCustomControl)
  protected
    // animation
    AnimateTimer: TTimer;
    CurrentFrame: Integer;
    AnimateInc: Boolean;
    //
    FSkinImagesMenu: TbsSkinImagesMenu;
    FUseImagesMenuImage: Boolean;
    FUseImagesMenuCaption: Boolean;
    FDrawColorMarker: Boolean;
    FColorMarkerValue: TColor;
    //
    FUseSkinSize: Boolean;
    FUseSkinFontColor: Boolean;
    FButtonImages: TCustomImageList;
    FImageIndex: Integer;
    RepeatTimer: TTimer;
    FRepeatMode: Boolean;
    FRepeatInterval: Integer;
    FFlat: Boolean;
    FAllowAllUp: Boolean;
    FAllowAllUpCheck: Boolean;
    FDown: Boolean;
    FMouseIn, FMouseDown: Boolean;
    FGroupIndex: Integer;
    FGlyph: TBitMap;
    FNumGlyphs: TbsNumGlyphs;
    FMargin: Integer;
    FSpacing: Integer;
    FLayout: TbsButtonLayout;
    MorphTimer: TTimer;
    FMorphKf: Double;
    FShowCaption: Boolean;
    FWidthWithCaption: Integer;
    FWidthWithoutCaption: Integer;
    //
    procedure StartAnimate(AInc: Boolean);
    procedure StopAnimate;
    procedure DoAnimate(Sender: TObject);
    function GetAnimationFrameRect: TRect;
    //
    procedure SetShowCaption(const Value: Boolean);
    procedure SetImageIndex(Value: Integer);
    procedure RepeatTimerProc(Sender: TObject);
    procedure StartRepeat;
    procedure StopRepeat;
    procedure StartMorph;
    procedure StopMorph;
    procedure DoMorph(Sender: TObject);
    function GetTransparent: Boolean;
    procedure SetTransparent(Value: Boolean);
    procedure SetFlat(Value: Boolean);
    function GetGlyphNum(AIsDown, AIsMouseIn: Boolean): Integer;
    procedure CreateStrechButtonImage(B: TBitMap; R: TRect;
      ADown, AMouseIn: Boolean);
    procedure CreateButtonImage(B: TBitMap; R: TRect; ADown, AMouseIn: Boolean); virtual;
    procedure SetLayout(Value : TbsButtonLayout);
    procedure SetGroupIndex(Value: Integer);
    procedure SetDown(Value: Boolean);
    procedure SetMargin(Value: Integer);
    procedure SetSpacing(Value: Integer);
    procedure DoAllUp;
    procedure SetNumGlyphs(Value: TbsNumGlyphs);
    procedure SetGlyph(Value: TBitMap);
    procedure GetSkinData; override;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure ReDrawControl;

    procedure CreateControlDefaultImage(B: TBitMap); override;
    procedure CreateControlSkinImage(B: TBitMap); override;

    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); override;
    procedure CalcSize(var W, H: Integer); override;
    function EnableMorphing: Boolean;
    function EnableAnimation: Boolean;
    procedure Notification(AComponent: TComponent;  Operation: TOperation); override;
    procedure DrawMenuMarker(C: TCanvas; R: TRect; AActive, ADown: Boolean; AFlat: Boolean);
    //
    procedure SetSkinImagesMenu(Value: TbsSkinImagesMenu);
    procedure OnImagesMenuChanged(Sender: TObject);
    property SkinImagesMenu: TbsSkinImagesMenu
     read FSkinImagesMenu write SetSkinImagesMenu;
    property UseImagesMenuImage: Boolean
      read FUseImagesMenuImage write FUseImagesMenuImage;
    property UseImagesMenuCaption: Boolean
      read FUseImagesMenuCaption write FUseImagesMenuCaption;
  public
    FontName: String;
    FontStyle: TFontStyles;
    FontHeight: Integer;
    FontColor, ActiveFontColor, DownFontColor, DisabledFontColor: TColor;
    ActiveSkinRect, DownSkinRect, DisabledSkinRect: TRect;
    Morphing: Boolean;
    MorphKind: TbsMorphKind;
    AnimateSkinRect: TRect;
    FrameCount: Integer;
    AnimateInterval: Integer;
    //
    MenuMarkerRect,
    MenuMarkerActiveRect,
    MenuMarkerDownRect: TRect;
    MenuMarkerFlatRect: TRect;
    MenuMarkerTransparentColor: TColor;
    //
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ChangeSkinData; override;
    procedure Paint; override;
    procedure ButtonClick; virtual;
    procedure RefreshButton;
  published
    property ImageList: TCustomImageList read FButtonImages write FButtonImages; 
    property UseSkinSize: Boolean read FUseSkinSize write FUseSkinSize;
    property UseSkinFontColor: Boolean read FUseSkinFontColor write FUseSkinFontColor;
    property WidthWithCaption: Integer
      read FWidthWithCaption write FWidthWithCaption;
    property WidthWithoutCaption: Integer
      read FWidthWithoutCaption write FWidthWithoutCaption;
    property ImageIndex: Integer read FImageIndex write SetImageIndex;
    property RepeatMode: Boolean read FRepeatMode write FRepeatMode;
    property RepeatInterval: Integer
      read  FRepeatInterval write FRepeatInterval;
    property Transparent: Boolean read GetTransparent write SetTransparent;
    property Flat: Boolean read FFlat write SetFlat;
    property AllowAllUp: Boolean read FAllowAllUp write FAllowAllUp;
    property PopupMenu;
    property ShowHint;
    property Action;
    property ParentShowHint;
    property Down: Boolean read FDown write SetDown;
    property GroupIndex: Integer read FGroupIndex write SetGroupIndex;
    property Caption;
    property ShowCaption: Boolean read FShowCaption write SetShowCaption;
    property Glyph: TBitMap read FGlyph write SetGlyph;
    property NumGlyphs: TbsNumGlyphs read FNumGlyphs write SetNumGlyphs;
    property Align;
    property Margin: Integer read FMargin write SetMargin default -1;
    property Spacing: Integer read FSpacing write SetSpacing default 4;
    property Layout: TbsButtonLayout read FLayout write SetLayout default blGlyphLeft;
    property Enabled;
    property OnClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
  end;

  TbsTrackPosition = (bstpRight, bstpBottom);

  TbsSkinMenuSpeedButton = class(TbsSkinSpeedButton)
  protected
    FOnShowTrackMenu: TNotifyEvent;
    FOnHideTrackMenu: TNotifyEvent;
    FTrackButtonMode: Boolean;
    FMenuTracked: Boolean;
    FSkinPopupMenu: TbsSkinPopupMenu;
    FNewStyle: Boolean;
    FTrackPosition: TbsTrackPosition;
    procedure OnImagesMenuClose(Sender: TObject);
    procedure CreateButtonImage(B: TBitMap; R: TRect; ADown, AMouseIn: Boolean); override;
    function CanMenuTrack(X, Y: Integer): Boolean;
    procedure TrackMenu;
    procedure SetTrackButtonMode(Value: Boolean);
    procedure GetSkinData; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure WMCLOSESKINMENU(var Message: TMessage); message WM_CLOSESKINMENU;
    function GetNewTrackButtonRect: TRect;
    procedure CreateControlDefaultImage(B: TBitMap); override;
    procedure CreateNewStyleControlDefaultImage(B: TBitMap);
    procedure CreateControlSkinResizeImage(B: TBitMap; ADown, AMouseIn: Boolean);
    procedure CreateControlSkinResizeImage2(B: TBitMap; ADown, AMouseIn: Boolean);
    procedure CreateNewStyleControlSkinResizeImage(B: TBitMap; ADown, AMouseIn: Boolean);
    procedure SetNewStyle(Value: Boolean);
    procedure SetTrackPosition(Value: TbsTrackPosition);
    procedure DrawResizeButton(ButtonData: TbsDataSkinButtonControl; C: TCanvas; ButtonR: TRect; AMouseIn, ADown: Boolean);
  public
    TrackButtonRect: TRect;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
  published
    property NewStyle: Boolean read FNewStyle write SetNewStyle;
    property TrackPosition: TbsTrackPosition
      read FTrackPosition write SetTrackPosition;
    property SkinImagesMenu;
    property UseImagesMenuImage;
    property UseImagesMenuCaption;

    property SkinPopupMenu: TbsSkinPopupMenu read FSkinPopupMenu
                                             write FSkinPopupMenu;
    property TrackButtonMode: Boolean read FTrackButtonMode
                                      write SetTrackButtonMode;
    property OnShowTrackMenu: TNotifyEvent read FOnShowTrackMenu
                                           write FOnShowTrackMenu;
    property OnHideTrackMenu: TNotifyEvent read FOnHideTrackMenu
                                           write FOnHideTrackMenu;
  end;

  TbsCustomDrawSkinSectionEvent = procedure(HeaderControl: THeaderControl;
    Section: THeaderSection; const Rect: TRect; Active, Pressed: Boolean;
    Cnvs: TCanvas) of object;

  TbsSkinHeaderControl = class(THeaderControl)
  protected
    FSD: TbsSkinData;
    FSkinDataName: String;
    FIndex: Integer;
    FDefaultFont: TFont;
    FUseSkinFont: Boolean;
    FDefaultHeight: Integer;
    //
    InDivider: Boolean;
    FDown: Boolean;
    FDownInDivider: Boolean;
    FInTracking: Boolean;
    FActiveSection, FOldActiveSection: Integer;
    FOnSkinSectionClick: TSectionNotifyEvent;
    FOnDrawSkinSection: TbsCustomDrawSkinSectionEvent;
    procedure SetDefaultHeight(Value: Integer);
    function GetSkinItemRect(Index: Integer): TRect;
    procedure PaintWindow(DC: HDC); override;
    procedure WMPaint(var Msg: TWMPaint); message WM_PAINT;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    function DrawSkinSection(Cnvs: TCanvas; Index: Integer; Active, Pressed: Boolean): TRect;
    procedure DrawSkinSectionR(Cnvs: TCanvas; Section: THeaderSection; Active, Pressed: Boolean; R: TRect);
     procedure CreateParams(var Params: TCreateParams); override;
    procedure TestActive(X, Y: Integer);
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
                        X, Y: Integer); override;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure WndProc(var Message:TMessage); override;
    procedure CreateWnd; override;
    procedure DrawSection(Section: THeaderSection; const Rect: TRect;
      Pressed: Boolean); override;
    procedure SetDefaultFont(Value: TFont);
    procedure SetSkinData(Value: TbsSkinData);
    procedure Notification(AComponent: TComponent;  Operation: TOperation); override;
  public
    LTPt, RTPt, LBPt, RBPt: TPoint;
    SkinRect, ClRect: TRect;
    NewLTPoint, NewRTPoint, NewLBPoint, NewRBPoint: TPoint;
    NewClRect: TRect;
    StretchEffect: Boolean;
    LeftStretch, TopStretch, RightStretch, BottomStretch: Boolean;
    Picture: TBitMap;
    FontName: String;
    FontStyle: TFontStyles;
    FontHeight: Integer;
    FontColor, ActiveFontColor, DownFontColor: TColor;
    ActiveSkinRect, DownSkinRect: TRect;
    //
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure GetSkinData;
    procedure ChangeSkinData;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override; 
  published
    property DefaultFont: TFont read FDefaultFont write SetDefaultFont;
    property DefaultHeight: Integer read FDefaultHeight write SetDefaultHeight;
    property UseSkinFont: Boolean read FUseSkinFont write FUseSkinFont;
    property SkinData: TbsSkinData read FSD write SetSkinData;
    property SkinDataName: String read FSkinDataName write FSkinDataName;
    property OnSkinSectionClick: TSectionNotifyEvent
      read FOnSkinSectionClick write FOnSkinSectionClick;
    property OnDrawSkinSection: TbsCustomDrawSkinSectionEvent
      read FOnDrawSkinSection write FOnDrawSkinSection;
  end;

  TbsNumThumbStates = 1..2;
  TbsSliderOrientation = (soHorizontal, soVertical);
  TbsSliderOption = (soShowFocus, soShowPoints, soSmooth,
                     soRulerOpaque, soThumbOpaque);
  TbsSliderOptions = set of TbsSliderOption;
  TbsSliderImage = (siHThumb, siHRuler, siVThumb, siVRuler);
  TbsSliderImages = set of TbsSliderImage;
  TbsSliderImageArray = array[TbsSliderImage] of TBitmap;
  TbsJumpMode = (jmNone, jmHome, jmEnd, jmNext, jmPrior);

  TbsSkinCustomSlider = class(TbsSkinControl)
  private
    FUseSkinThumb: Boolean;
    FTransparent: Boolean;
    FUserImages: TbsSliderImages;
    FImages: TbsSliderImageArray;
    FEdgeSize: Integer;
    FRuler: TBitmap;
    FPaintBuffered: Boolean;
    FRulerOrg: TPoint;
    FThumbRect: TRect;
    FThumbDown: Boolean;
    FNumThumbStates: TbsNumThumbStates;
    FPointsRect: TRect;
    FOrientation: TbsSliderOrientation;
    FOptions: TbsSliderOptions;
    FBevelWidth: Integer;
    FMinValue: Longint;
    FMaxValue: Longint;
    FIncrement: Longint;
    FValue: Longint;
    FHit: Integer;
    FFocused: Boolean;
    FSliding: Boolean;
    FTracking: Boolean;
    FTimerActive: Boolean;
    FMousePos: TPoint;
    FStartJump: TbsJumpMode;
    FReadOnly: Boolean;
    FOnChange: TNotifyEvent;
    FOnChanged: TNotifyEvent;
    FOnDrawPoints: TNotifyEvent;
    procedure SetTransparent(Value: Boolean);
    function GetImage(Index: Integer): TBitmap;
    procedure SetImage(Index: Integer; Value: TBitmap);
    procedure SliderImageChanged(Sender: TObject);
    procedure SetEdgeSize(Value: Integer);
    function GetNumThumbStates: TbsNumThumbStates;
    procedure SetNumThumbStates(Value: TbsNumThumbStates);
    procedure SetOrientation(Value: TbsSliderOrientation);
    procedure SetOptions(Value: TbsSliderOptions);
    procedure SetMinValue(Value: Longint);
    procedure SetMaxValue(Value: Longint);
    procedure SetIncrement(Value: Longint);
    procedure SetReadOnly(Value: Boolean);
    function GetThumbOffset: Integer;
    procedure SetThumbOffset(Value: Integer);
    procedure SetValue(Value: Longint);
    procedure ThumbJump(Jump: TbsJumpMode);
    function GetThumbPosition(var Offset: Integer): TPoint;
    function JumpTo(X, Y: Integer): TbsJumpMode;
    procedure InvalidateThumb;
    procedure StopTracking;
    procedure TimerTrack;
    function StoreImage(Index: Integer): Boolean;
    procedure CreateElements;
    procedure BuildRuler(R: TRect);
    procedure BuildSkinRuler(R: TRect);
    procedure AdjustElements;
    procedure ReadUserImages(Stream: TStream);
    procedure WriteUserImages(Stream: TStream);
    procedure InternalDrawPoints(ACanvas: TCanvas; PointsStep, PointsHeight,
      ExtremePointsHeight: Longint);
    procedure DrawThumb(Canvas: TCanvas; Origin: TPoint; Highlight: Boolean);
    procedure DrawSkinThumb(Canvas: TCanvas; Origin: TPoint; Highlight: Boolean);
    function GetValueByOffset(Offset: Integer): Longint;
    function GetOffsetByValue(Value: Longint): Integer;
    function GetRulerLength: Integer;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMFocusChanged(var Message: TCMFocusChanged); message CM_FOCUSCHANGED;
    procedure WMGetDlgCode(var Msg: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMTimer(var Message: TMessage); message WM_TIMER;
    procedure WMMOVE(var Msg: TWMMOVE); message WM_MOVE;

  protected
    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Loaded; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    function CanModify: Boolean; virtual;
    function GetSliderRect: TRect; virtual;
    function GetSliderValue: Longint; virtual;
    procedure Change; dynamic;
    procedure Changed; dynamic;
    procedure Sized; virtual;
    procedure RangeChanged; virtual;
    procedure SetRange(Min, Max: Longint);
    procedure ThumbMouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); virtual;
    procedure ThumbMouseMove(Shift: TShiftState; X, Y: Integer); virtual;
    procedure ThumbMouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); virtual;
    property ThumbOffset: Integer read GetThumbOffset write SetThumbOffset;
    property SliderRect: TRect read GetSliderRect;
    property ImageHThumb: TBitmap index Ord(siHThumb) read GetImage
      write SetImage stored StoreImage;
    property ImageHRuler: TBitmap index Ord(siHRuler) read GetImage
      write SetImage  stored StoreImage;
    property ImageVThumb: TBitmap index Ord(siVThumb) read GetImage
      write SetImage stored StoreImage;
    property ImageVRuler: TBitmap index Ord(siVRuler) read GetImage
      write SetImage stored StoreImage;
    property NumThumbStates: TbsNumThumbStates read GetNumThumbStates
      write SetNumThumbStates default 2;
    property Orientation: TbsSliderOrientation read FOrientation
      write SetOrientation default soHorizontal;
    property EdgeSize: Integer read FEdgeSize write SetEdgeSize default 2;
    property Options: TbsSliderOptions read FOptions write SetOptions
      default [soShowFocus, soShowPoints, soSmooth];
    property ReadOnly: Boolean read FReadOnly write SetReadOnly default False;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnChanged: TNotifyEvent read FOnChanged write FOnChanged;
    property OnDrawPoints: TNotifyEvent read FOnDrawPoints write FOnDrawPoints;
    procedure GetSkinData; override;
  public
    HRulerRect: TRect;
    HThumbRect: TRect;
    VRulerRect: TRect;
    VThumbRect: TRect;
    SkinEdgeSize: Integer;
    BGColor: TColor;
    PointsColor: TColor;
    Picture: TBitMap;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
    procedure DefaultDrawPoints(PointsStep, PointsHeight,
      ExtremePointsHeight: Longint); virtual;
    procedure ChangeSkinData; override;
    property Canvas;
    property Increment: Longint read FIncrement write SetIncrement default 10;
    property MinValue: Longint read FMinValue write SetMinValue default 0;
    property MaxValue: Longint read FMaxValue write SetMaxValue default 100;
    property Value: Longint read FValue write SetValue default 0;
    property Transparent: Boolean read FTransparent write SetTransparent;
    property UseSkinThumb: Boolean read FUseSkinThumb write FUseSkinThumb;
  end;

{ TbsSlider }

  TbsSkinSlider = class(TbsSkinCustomSlider)
  published
    property Align;
    property Color;
    property Cursor;
    property DragMode;
    property DragCursor;
    property Enabled;
    property ImageHThumb;
    property ImageHRuler;
    property ImageVThumb;
    property ImageVRuler;
    property Increment;
    property MinValue;
    property MaxValue;
    property NumThumbStates;
    property Orientation;
    property EdgeSize;
    property Options;
    property ParentColor;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop default True;
    property Value;
    property Transparent;
    property UseSkinThumb;
    property Visible;
    property Anchors;
    property Constraints;
    property DragKind;
    property OnChange;
    property OnChanged;
    property OnDrawPoints;
    property OnClick;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnMouseMove;
    property OnMouseDown;
    property OnMouseUp;
    property OnKeyDown;
    property OnKeyUp;
    property OnKeyPress;
    property OnDragOver;
    property OnDragDrop;
    property OnEndDrag;
    property OnStartDrag;
    property OnContextPopup;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnEndDock;
    property OnStartDock;
  end;

  TbsSkinButtonsBar = class;
  TbsButtonBarSection = class;
  TbsButtonBarItems = class;

  TbsButtonBarItem = class(TCollectionItem)
  private
    FText: String;
    FImageIndex: Integer;
    FOnClick: TNotifyEvent;
    FOnDblClick: TNotifyEvent;
    FTag: Integer;
    FLayout: TbsButtonLayout;
    FMargin: Integer;
    FSpacing: Integer;
    FHint: String;
    procedure SetText(const Value: string);
    procedure SetImageIndex(const Value: Integer);
    procedure ItemClick(const Value: TNotifyEvent);
    procedure ItemDBlClick(const Value: TNotifyEvent);
    procedure SetLayout(Value: TbsButtonLayout);
    procedure SetMargin(Value: Integer);
    procedure SetSpacing(Value: Integer);
  protected
    function GetDisplayName: string; override;
    procedure Click;
    procedure DblClick;
  public
    constructor Create(Collection: TCollection); override;
    procedure Assign(Source: TPersistent); override;
  published
    property Text: string read FText write SetText;
    property Hint: string read FHint write FHint;
    property ImageIndex:integer read FImageIndex write SetImageIndex;
    property Tag: Integer read FTag write FTag;
    property Layout: TbsButtonLayout read FLayout write SetLayout;
    property Margin: Integer read FMargin write SetMargin;
    property Spacing: Integer read FSpacing write SetSpacing;
    property OnClick:TNotifyEvent read FonClick write ItemClick;
    property OnDblClick:TNotifyEvent read FonDblClick write ItemDblClick;
  end;

  TbsButtonBarItems = class(TCollection)
  private
    FSection: TbsButtonBarSection;
    function GetItem(Index: Integer): TbsButtonBarItem;
    procedure SetItem(Index: Integer; Value: TbsButtonBarItem);
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(Section: TbsButtonBarSection);
    function Add: TbsButtonBarItem;
    property Items[Index: Integer]: TbsButtonBarItem read GetItem write SetItem; default;
  end;

  TbsButtonBarSection = class(TCollectionItem)
  private
    FText: string;
    FItems: TbsButtonBarItems;
    FOnClick: TNotifyEvent;
    FOnDblClick: TNotifyEvent;
    FImageIndex: Integer;
    FTag: Integer;
    FHint: String;
    FMargin: Integer;
    FSpacing: Integer;
    procedure SetText(const Value: string);
    procedure SetItems(const Value: TbsButtonBarItems);
    procedure SectionClick(const Value: TNotifyEvent);
    procedure SectionDblClick(const Value: TNotifyEvent);
    procedure SetImageIndex(Value: Integer);
    procedure SetMargin(Value: Integer);
    procedure SetSpacing(Value: Integer);
  protected
    function GetDisplayName: string; override;
    procedure Click;
    procedure DblClick;
  public
    constructor Create(Collection: TCollection); override;
    destructor  Destroy;override;
    procedure Assign(Source: TPersistent); override;
  published
    property Text: string read FText write SetText;
    property Hint: string read FHint write FHint;
    property Items: TbsButtonBarItems read FItems write SetItems;
    property Tag: Integer read FTag write FTag;
    property ImageIndex: Integer read FImageIndex write SetImageIndex;
    property Margin: Integer read FMargin write SetMargin;
    property Spacing: Integer read FSpacing write SetSpacing;
    property OnClick:TNotifyEvent read FOnClick write SectionClick;
    property OnDblClick:TNotifyEvent read FOnDblClick write SectionDblClick;
  end;

  TbsButtonBarSections = class(TCollection)
  private
    FButtonsBar: TbsSkinButtonsBar;
    function GetItem(Index: Integer): TbsButtonBarSection;
    procedure SetItem(Index: Integer; Value: TbsButtonBarSection);
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    function GetButtonsBar: TbsSkinButtonsBar;
    constructor Create(ButtonsBar: TbsSkinButtonsBar);
    function Add: TbsButtonBarSection;
    property Items[Index: Integer]: TbsButtonBarSection read GetItem write SetItem; default;
  end;

  TbsSectionButton = class(TbsSkinSpeedButton)
  private
    FItemIndex: Integer;
    FButtonsBar: TbsSkinButtonsBar;
  protected
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
  public
    constructor CreateEx(AOwner: TComponent; AButtonsBar: TbsSkinButtonsBar; AIndex: Integer);
    procedure ButtonClick; override;
  end;

  TbsSectionItem = class(TbsSkinSpeedButton)
  private
    FItemIndex: Integer;
    FButtonsBar: TbsSkinButtonsBar;
    FSectionIndex: Integer;
  protected
    FWebStyle: Boolean;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
  public
    constructor CreateEx(AOwner: TComponent; AButtonsBar: TbsSkinButtonsBar; ASectionIndex, AIndex: Integer; AWebStyle: Boolean);
    procedure ButtonClick; override;
    procedure Paint; override;
  end;

  TbsSkinButtonsBar = class(TbsSkinPanel)
  private
    FWebStyle: Boolean;
    FShowItemHint: Boolean;
    FShowButtons: Boolean;
    FDefaultSectionFont: TFont;
    FDefaultItemFont: TFont;
    FUpButton, FDownButton: TbsSkinButton;
    TopIndex: Integer;
    VisibleCount: Integer;
    FItemHeight: Integer;
    FItemsTransparent: Boolean;
    FItemsPanel: TbsSkinPanel;
    FSections: TbsButtonBarSections;
    FSectionIndex: Integer;
    FItemImages: TCustomImageList;
    FSectionImages: TCustomImageList;
    FSectionButtons: TList;
    FSectionItems: TList;
    FSectionButtonSkinDataName: String;
    FDefaultButtonHeight: Integer;
    procedure SetShowButtons(Value: Boolean);
    procedure SetDefaultButtonHeight(Value: Integer);
    procedure SetDefaultSectionFont(Value: TFont);
    procedure SetDefaultItemFont(Value: TFont);
    procedure SetItemHeight(Value: Integer);
    procedure SetItemsTransparent(Value: Boolean);
    procedure SetSections(Value: TbsButtonBarSections);
    procedure UpdateSection(Index: Integer);
    procedure UpdateSections;
    procedure UpdateItems;
    procedure SetSectionIndex(const Value: integer);
    procedure SetItemImages(const Value: TCustomImageList);
    procedure SetSectionImages(const Value: TCustomImageList);
    procedure CheckVisibleItems;
    procedure OnItemPanelResize(Sender: TObject);
  protected
    procedure CreateWnd; override;
    procedure SetSkinData(Value: TbsSkinData); override;
    procedure ClearSections;
    procedure ClearItems;
    procedure OpenSection(Index: Integer);
    procedure ArangeItems;
    procedure ShowUpButton;
    procedure ShowDownButton;
    procedure HideUpButton;
    procedure HideDownButton;
    procedure UpButtonClick(Sender: TObject);
    procedure DownButtonClick(Sender: TObject);
  public
    procedure ScrollUp;
    procedure ScrollDown;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Notification(AComponent:TComponent; Operation:TOperation);override;
    procedure UpDateSectionButtons;
    procedure ChangeSkinData; override;
  published
    property WebStyle: Boolean read FWebStyle write FWebStyle;
    property ShowItemHint: Boolean read FShowItemHint write FShowItemHint;
    property ShowButtons: Boolean read FShowButtons write SetShowButtons;
    property DefaultSectionFont: TFont read FDefaultSectionFont write SetDefaultSectionFont;
    property DefaultButtonHeight: Integer
      read FDefaultButtonHeight write SetDefaultButtonHeight;
    property DefaultItemFont: TFont read FDefaultItemFont write SetDefaultItemFont;
    property Align default alLeft;
    property Enabled;
    property SectionButtonSkinDataName: String
      read FSectionButtonSkinDataName
      write FSectionButtonSkinDataName; 
    property ItemHeight: Integer read FItemHeight write SetItemHeight;
    property ItemsTransparent: Boolean read FItemsTransparent write SetItemsTransparent;
    property ItemImages: TCustomImageList read FItemImages write SetItemImages;
    property SectionImages:TCustomImageList read FSectionImages write SetSectionImages;
    property Sections: TbsButtonBarSections read FSections write SetSections;
    property SectionIndex:integer read FSectionIndex write SetSectionIndex;
    property PopupMenu;
    property ShowHint;
    property Hint;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
  end;

  {TbsSkinNoteBook}

  TbsSkinPage = class(TbsSkinPanel)
  private
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
  protected
    FImageIndex: Integer;
    procedure ReadState(Reader: TReader); override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property ImageIndex: Integer read FImageIndex write FImageIndex;
    property Caption;
    property Height stored False;
    property TabOrder stored False;
    property Visible stored False;
    property Width stored False;
  end;

  TbsSkinNotebook = class(TbsSkinPanel)
  private
    FAccess: TStrings;
    FPageIndex: Integer;
    FOnPageChanged: TNotifyEvent;
    FButtonsMode: Boolean;
    FButtons: TList;
    FImages: TCustomImageList;
    FButtonSkinDataName: String;
    procedure SetImages(const Value: TCustomImageList);
    procedure ClearButtons;
    procedure SetPages(Value: TStrings);
    procedure SetActivePage(const Value: string);
    function GetActivePage: string;
    procedure SetPageIndex(Value: Integer);
    procedure SetButtonsMode(Value: Boolean);
  protected
    procedure Notification(AComponent: TComponent;  Operation: TOperation); override;
    procedure CreateParams(var Params: TCreateParams); override;
    function GetChildOwner: TComponent; override;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    procedure ReadState(Reader: TReader); override;
    procedure ShowControl(AControl: TControl); override;
    procedure UpdateButtons;
  public
    FPageList: TList;
    procedure UpdateButton(APageIndex: Integer; ACaption: String);
    procedure Loaded; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property ActivePage: string read GetActivePage write SetActivePage stored False;
    property ButtonsMode: Boolean read FButtonsMode write SetButtonsMode;
     property ButtonSkinDataName: String
      read FButtonSkinDataName
      write FButtonSkinDataName;
    property Images: TCustomImageList read FImages write SetImages;
    property Align;
    property Anchors;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Font;
    property Enabled;
    property Constraints;
    property PageIndex: Integer read FPageIndex write SetPageIndex default 0;
    property Pages: TStrings read FAccess write SetPages stored False;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnPageChanged: TNotifyEvent read FOnPageChanged write FOnPageChanged;
    property OnStartDock;
    property OnStartDrag;
  end;

  TbsPageButton = class(TbsSkinSpeedButton)
  private
    FPageIndex: Integer;
    FNoteBook: TbsSkinNoteBook;
  public
    constructor CreateEx(AOwner: TComponent; ANoteBook: TbsSkinNoteBook; APageIndex: Integer);
    procedure ButtonClick; override;
  end;

 TbsSkinXFormButton = class(TbsSkinButton)
 private
   FDefImage: TBitMap;
   FDefActiveImage: TBitMap;
   FDefDownImage: TBitMap;
   FDefMask: TBitMap;
   FDefActiveFontColor: TColor;
   FDefDownFontColor: TColor;
   procedure SetDefImage(Value: TBitMap);
   procedure SetDefActiveImage(Value: TBitMap);
   procedure SetDefDownImage(Value: TBitMap);
   procedure SetDefMask(Value: TBitMap);
 protected
    procedure SetControlRegion; override;
    procedure DrawDefaultButton(C: TCanvas);
    procedure CreateControlDefaultImage(B: TBitMap); override;
    procedure Loaded; override;
 public
   constructor Create(AOwner: TComponent); override;
   destructor Destroy; override;
   procedure ChangeSkinData; override;
   procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
 published
   property DefImage: TBitMap read FDefImage write SetDefImage;
   property DefActiveImage: TBitMap read FDefActiveImage write SetDefActiveImage;
   property DefDownImage: TBitMap read FDefDownImage write SetDefDownImage;
   property DefMask: TBitMap read FDefMask write SetDefMask;
   property DefActiveFontColor: TColor
    read FDefActiveFontColor write FDefActiveFontColor;
   property DefDownFontColor: TColor
    read FDefDownFontColor write FDefDownFontColor;
 end;


 TbsScrollType = (stHorizontal, stVertical);
 TbsSkinScrollPanel = class(TbsSkinControl)
 private
   FClicksDisabled: Boolean;
   FCanFocused: Boolean;
   FHotScroll: Boolean;
   TimerMode: Integer;
   SMax, SPosition, SPage, SOldPosition: Integer;
   FAutoSize: Boolean;
   FVSizeOffset: Integer;
   FHSizeOffset: Integer;
   FScrollType: TbsScrollType;
   FScrollOffset: Integer;
   FScrollTimerInterval: Integer;
   Buttons: array[0..1] of TbsControlButton;
   PanelData: TbsDataSkinPanelControl;
   ButtonData: TbsDataSkinButtonControl;
   procedure SetScrollType(Value: TbsScrollType);
   procedure SetScrollOffset(Value: Integer);
   procedure SetScrollTimerInterval(Value: Integer);
   procedure DrawButton(Cnvs: TCanvas; i: Integer);
   procedure SetPosition(const Value: integer);
 protected
   procedure GetSkinData; override;
   procedure KeyDown(var Key: Word; Shift: TShiftState); override;
   procedure WMSETCURSOR(var Message: TWMSetCursor); message WM_SetCursor;
   procedure WMMOUSEWHEEL(var Message: TMessage); message WM_MOUSEWHEEL;
   procedure WMTimer(var Message: TWMTimer); message WM_Timer;
   procedure WMNCCALCSIZE(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
   procedure WMNCPAINT(var Message: TMessage); message WM_NCPAINT;
   procedure WMSIZE(var Message: TWMSIZE); message WM_SIZE;
   procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
   procedure CMWantSpecialKey(var Msg: TCMWantSpecialKey); message CM_WANTSPECIALKEY;
   procedure CreateControlDefaultImage(B: TBitMap); override;
   procedure CreateControlSkinImage(B: TBitMap); override;
   procedure WndProc(var Message: TMessage); override;
   procedure SetButtonsVisible(AVisible: Boolean);
   procedure ButtonClick(I: Integer);
   procedure ButtonDown(I: Integer);
   procedure ButtonUp(I: Integer);
   procedure GetHRange;
   procedure GetVRange;
   procedure VScrollControls(AOffset: Integer);
   procedure HScrollControls(AOffset: Integer);
   procedure AdjustClientRect(var Rect: TRect); override;
   procedure StartTimer;
   procedure StopTimer;
   procedure Loaded; override;
   procedure CMBENCPaint(var Message: TMessage); message CM_BENCPAINT;
 public
   constructor Create(AOwner: TComponent); override;
   destructor Destroy; override;
   procedure Paint; override;
   procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
   procedure UpDateSize;
   procedure GetScrollInfo;
   property Position: integer read SPosition write SetPosition;
 published
   property CanFocused: Boolean read FCanFocused write FCanFocused;
   property HotScroll: Boolean read FHotScroll write FHotScroll;
   property AutoSize: Boolean read FAutoSize write FAutoSize;
   property Align;
   property ScrollType: TbsScrollType read FScrollType write SetScrollType;
   property ScrollOffset: Integer read FScrollOffset write SetScrollOffset;
   property ScrollTimerInterval: Integer
     read FScrollTimerInterval write SetScrollTimerInterval;
 end;

 TbsSkinGraphicButton = class(TbsSkinMenuSpeedButton)
 protected
   FGraphicMenu: TbsSkinImagesMenu;
   FGraphicImages: TCustomImageList;

   procedure InitImages; virtual;
   procedure InitItems; virtual;

   function GetMenuDefaultFont: TFont;
   procedure SetMenuDefaultFont(Value: TFont);
   function GetMenuUseSkinFont: Boolean;
   procedure SetMenuUseSkinFont(Value: Boolean);
   function GetMenuAlphaBlend: Boolean;
   procedure SetMenuAlphaBlend(Value: Boolean);
   function GetMenuAlphaBlendAnimation: Boolean;
   procedure SetMenuAlphaBlendAnimation(Value: Boolean);
   function GetMenuAlphaBlendValue: Integer;
   procedure SetMenuAlphaBlendValue(Value: Integer);

   function GetMenuShowHints: Boolean;
   procedure SetMenuShowHints(Value: Boolean);

   function GetMenuSkinHint: TbsSkinHint;
   procedure SetMenuSkinHint(Value: TbsSkinHint);

   function GetGraphicMenuItems: TbsImagesMenuItems;
   function GetSelectedItem: TbsImagesMenuItem;

   function GetItemIndex: Integer;
   procedure SetItemIndex(Value: Integer);

   procedure Loaded; override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property SelectedItem: TbsImagesMenuItem read GetSelectedItem;
  published
    property ItemIndex: Integer read GetItemIndex write SetItemIndex;
    property MenuSkinHint: TbsSkinHint read GetMenuSkinHint write SetMenuSkinHint;
    property MenuShowHints: Boolean read GetMenuShowHints write SetMenuShowHints;
    property GraphicItems: TbsImagesMenuItems read GetGraphicMenuItems;
    property MenuUseSkinFont: Boolean read GetMenuUseSkinFont write SetMenuUseSkinFont;
    property MenuDefaultFont: TFont read GetMenuDefaultFont write SetMenuDefaultFont;
    property MenuAlphaBlend: Boolean read GetMenuAlphaBlend write SetMenuAlphaBlend;
    property MenuAlphaBlendValue: Integer read GetMenuAlphaBlendValue write SetMenuAlphaBlendValue;
    property MenuAlphaBlendAnimation: Boolean read GetMenuAlphaBlendAnimation write SetMenuAlphaBlendAnimation;
  end;


 TbsSkinGradientStyleButton = class(TbsSkinGraphicButton)
 protected
   procedure InitImages; override;
   procedure InitItems; override;
 end;

 TbsSkinBrushStyleButton = class(TbsSkinGraphicButton)
 protected
   procedure InitImages; override;
   procedure InitItems; override;
 end;

 TbsSkinPenStyleButton = class(TbsSkinGraphicButton)
 protected
   procedure InitImages; override;
   procedure InitItems; override;
 end;

 TbsSkinPenWidthButton = class(TbsSkinGraphicButton)
 protected
   procedure InitImages; override;
   procedure InitItems; override;
 end;

 TbsSkinShadowStyleButton = class(TbsSkinGraphicButton)
 protected
   procedure InitImages; override;
   procedure InitItems; override;
 end;

 procedure NotebookHandlesNeeded(Notebook: TbsSkinNotebook);

 procedure DrawImageAndText(Cnvs: TCanvas; R: TRect; Margin, Spacing: Integer;
            Layout: TbsButtonLayout;
            Caption: String; ImageIndex: Integer; IL: TCustomIMageList; ADown: Boolean;
            AEnabled: Boolean; ADrawColorMarker: Boolean; AColorMarkerValue: TColor);


implementation

{$R *.res}

Uses bsUtils, ActnList, bsEffects, ShellAPI;

type
  TParentControl = class(TWinControl);

const
  MorphTimerInterval = 20;
  MorphInc = 0.2;

  ImagesResNames: array[TbsSliderImage] of PChar =
    ('BS_HTB', 'BS_HRL', 'BS_VTB', 'BS_VRL');
  Indent = 6;
  JumpInterval = 400;
  ButtonSize = 12;
  HTBUTTON1 = HTOBJECT + 100;
  HTBUTTON2 = HTOBJECT + 101;


procedure NotebookHandlesNeeded(Notebook: TbsSkinNotebook);
var
  I: Integer;
begin
  if Notebook <> nil then
    for I := 0 to Notebook.FPageList.Count - 1 do
      with TbsSkinPage(Notebook.FPageList[I]) do
      begin
        DisableAlign;
        try
          HandleNeeded;
          ControlState := ControlState - [csAlignmentNeeded];
        finally
          EnableAlign;
        end;
      end;
end;

procedure CalcLCoord(Layout: TbsButtonLayout; R: TRect; gw, gh, tw, th: Integer;
  Spacing, Margin: Integer; var tx, ty, gx, gy: Integer);
var
  H, W, H1, W1: Integer;
begin
 H := R.Top + RectHeight(R) div 2;
 W := R.Left + RectWidth(R) div 2;
 if Margin = -1
 then
   begin
     W1 := (tw + gw + Spacing) div 2;
     H1 := (th + gh + Spacing) div 2;
     case Layout of
       blGlyphRight:
         begin
           tx := W - W1;
           ty := H - th div 2;
           gx := W + W1 - gw;
           gy := H - gh div 2;
         end;
      blGlyphLeft:
         begin
           gx := W - W1;
           gy := H - gh div 2;
           tx := W + W1 - tw;
           ty := H - th div 2;
         end;
      blGlyphTop:
         begin
           tx := W - tw div 2;
           ty := H + H1 - th;
           gx := W - gw div 2;
           gy := H - H1;
        end;
     blGlyphBottom:
        begin
          gx := W - gw div 2;
          gy := H + H1 - gh;
          tx := W - tw div 2;
          ty := H - H1;
       end;
     end;
   end
 else
   begin
     case Layout of
       blGlyphRight:
         begin
           gy := H - gh div 2;
           gx := R.Right - gw - Margin;
           tx := gx - Spacing - tw;
           ty := H - th div 2;
         end;
       blGlyphLeft:
         begin
           gy := H - gh div 2;
           gx := R.Left + Margin;
           tx := gx + gw + Spacing;
           ty := H - th div 2;
         end;
       blGlyphTop:
          begin
            gy := R.Top +  Margin;
            gx := W - gw div 2;
            ty := gy + gh + Spacing;
            tx := W - tw div 2;
          end;
      blGlyphBottom:
          begin
            gy := R.Bottom - gh - Margin;
            gx := W - gw div 2;
            ty := gy - Spacing - th;
            tx := W - tw div 2;
         end;
       end;
    end;
end;


procedure DrawImageAndText(Cnvs: TCanvas; R: TRect; Margin, Spacing: Integer;
            Layout: TbsButtonLayout;
            Caption: String; ImageIndex: Integer; IL: TCustomIMageList; ADown: Boolean;
            AEnabled: Boolean; ADrawColorMarker: Boolean; AColorMarkerValue: TColor);

var
  gw, gh: Integer;
  tw, th: Integer;
  TX, TY, GX, GY: Integer;
  TR: TRect;
begin
  if (ImageIndex < 0) or (IL = nil) or (ImageIndex >= IL.Count)
  then
    begin
      gw := 0;
      gh := 0;
    end
  else
    begin
      gw := IL.Width;
      gh := IL.Height;
    end;
  with Cnvs do
  begin
    if Caption = ''
    then
      begin
        tw := 0;
        th := 0;
      end
    else
      begin
        TR := Rect(0, 0, RectWidth(R), RectHeight(R));
        if (Layout = blGlyphLeft) or (Layout = blGlyphRight)
        then
          begin
            Dec(TR.Right, gw);
          end
        else
        if (Layout = blGlyphTop) or (Layout = blGlyphBottom)
        then
          begin
            Dec(TR.Bottom, gh);
          end;
        DrawText(Handle, PChar(Caption), Length(Caption), TR,
             DT_EXPANDTABS or DT_WORDBREAK or DT_CALCRECT);
        tw := RectWidth(TR);
        th := RectHeight(TR);
      end;
    Brush.Style := bsClear;
  end;
  CalcLCoord(Layout, R, gw, gh, tw, th, Spacing, Margin, TX, TY, GX, GY);
  if ADown
  then
    begin
      Inc(GX); Inc(GY);
      Inc(TX); Inc(TY);
    end;
  if Caption <> ''
  then
    begin
      TR := Rect(TX, TY, TX + tw, TY + th);
      Inc(TR.Right, 2);
      DrawText(Cnvs.Handle, PChar(Caption), Length(Caption), TR, DT_EXPANDTABS or DT_VCENTER or DT_CENTER or DT_WORDBREAK);
    end;
  if gw <> 0
  then
    begin
      IL.Draw(Cnvs, GX, GY, ImageIndex, AEnabled);
      if ADrawColorMarker
      then
        with Cnvs do
        begin
          Pen.Color := AColorMarkerValue;
          MoveTo(GX, GY + IL.Height - 2);
          LineTo(GX + IL.Width, GY + IL.Height - 2);
          MoveTo(GX, GY + IL.Height - 1);
          LineTo(GX + IL.Width, GY + IL.Height - 1);
          MoveTo(GX, GY + IL.Height);
          LineTo(GX + IL.Width, GY + IL.Height);
        end;
    end
  else
    if ADrawColorMarker
    then
      with Cnvs do
      begin
        if Caption <> ''
        then
          begin
            Pen.Color := AColorMarkerValue;
            MoveTo(TR.Left, TR.Bottom  - 1);
            LineTo(TR.Right, TR.Bottom  - 1);
            MoveTo(TR.Left, TR.Bottom );
            LineTo(TR.Right, TR.Bottom);
            MoveTo(TR.Left, TR.Bottom  + 1);
            LineTo(TR.Right, TR.Bottom  + 1);
          end
        else
          begin
            Brush.Color := AColorMarkerValue;
            Brush.Style := bsSolid;
            FillRect(Rect(R.Left + 2, R.Top + 2, R.Right - 2, R.Bottom -2));
          end;
     end;
end;


procedure DrawGlyphAndText(Cnvs: TCanvas;
  R: TRect; Margin, Spacing: Integer; Layout: TbsButtonLayout;
  Caption: String; Glyph: TBitMap; NumGlyphs, GlyphNum: Integer; ADown: Boolean;
  ADrawColorMarker: Boolean; AColorMarkerValue: TColor);
var
  gw, gh: Integer;
  tw, th: Integer;
  TX, TY, GX, GY: Integer;
  TR: TRect;
begin
  if Glyph.Empty
  then
    begin
      gw := 0;
      gh := 0;
    end
  else
    begin
      gw := Glyph.Width div NumGlyphs;
      gh := Glyph.Height;
    end;
  with Cnvs do
  begin
    if Caption = ''
    then
      begin
        tw := 0;
        th := 0;
      end
    else
      begin
        TR := Rect(0, 0, RectWidth(R), RectHeight(R));
        if (Layout = blGlyphLeft) or (Layout = blGlyphRight)
        then
          begin
            Dec(TR.Right, gw);
          end
        else
        if (Layout = blGlyphTop) or (Layout = blGlyphBottom)
        then
          begin
            Dec(TR.Bottom, gh);
          end;
        DrawText(Handle, PChar(Caption), Length(Caption), TR,
                 DT_EXPANDTABS or DT_WORDBREAK or DT_CALCRECT);
        tw := RectWidth(TR);
        th := RectHeight(TR);
        Brush.Style := bsClear;
     end;
  end;

  CalcLCoord(Layout, R, gw, gh, tw, th, Spacing, Margin, TX, TY, GX, GY);

  if ADown
  then
    begin
      Inc(GX); Inc(GY);
      Inc(TX); Inc(TY);
    end;

  if Caption <> ''
  then
    begin
      TR := Rect(TX, TY, TX + tw, TY + th);
      Inc(TR.Right, 2);
      DrawText(Cnvs.Handle, PChar(Caption),
        Length(Caption), TR, DT_EXPANDTABS or DT_VCENTER or DT_CENTER or DT_WORDBREAK);
    end;
      
  if not Glyph.Empty then DrawGlyph(Cnvs, GX, GY, Glyph, NumGlyphs, GlyphNum);

  if not Glyph.Empty
  then
    begin
      if ADrawColorMarker
      then
        with Cnvs do
        begin
          Pen.Color := AColorMarkerValue;
          MoveTo(GX, GY + Glyph.Height - 2);
          LineTo(GX + Glyph.Width, GY + Glyph.Height - 2);
          MoveTo(GX, GY + Glyph.Height - 1);
          LineTo(GX + Glyph.Width, GY + Glyph.Height - 1);
          MoveTo(GX, GY + Glyph.Height);
          LineTo(GX + Glyph.Width, GY + Glyph.Height);
        end;
    end
  else
    if ADrawColorMarker
    then
      with Cnvs do
      begin
        if Caption <> ''
        then
          begin
            Pen.Color := AColorMarkerValue;
            MoveTo(TR.Left, TR.Bottom  - 1);
            LineTo(TR.Right, TR.Bottom  - 1);
            MoveTo(TR.Left, TR.Bottom);
            LineTo(TR.Right, TR.Bottom);
            MoveTo(TR.Left, TR.Bottom  + 1);
            LineTo(TR.Right, TR.Bottom  + 1);
          end
        else
          begin
            Brush.Color := AColorMarkerValue;
            Brush.Style := bsSolid;
            FillRect(Rect(R.Left + 2, R.Top + 2, R.Right - 2, R.Bottom -2));
          end;
     end;

end;


constructor TbsSkinWinControl.Create;
begin
  inherited Create(AOwner);
  FSD := nil;
end;

destructor TbsSkinWinControl.Destroy;
begin
  inherited Destroy;
end;

procedure TbsSkinWinControl.ChangeSkinData;
begin
  RePaint;
end;

procedure TbsSkinWinControl.SetSkinData;
begin
  FSD := Value;
  if (FSD <> nil) then
  if not FSD.Empty and not (csDesigning in ComponentState)
  then
    ChangeSkinData;
end;

procedure TbsSkinWinControl.Notification;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FSD) then FSD := nil;
end;

constructor TbsSkinControl.Create;
begin
  inherited Create(AOwner);
  FSD := nil;
  Frgn := 0;
  FIndex := -1;
end;

destructor TbsSkinControl.Destroy;
begin
  inherited Destroy;
end;

procedure TbsSkinControl.WMPaint(var Msg: TWMPaint);
begin
  FromWMPaint := True;
  inherited;
  FromWMPaint := False;
end;


procedure TbsSkinControl.CMMouseEnter;
begin
  inherited;
  if (csDesigning in ComponentState) then Exit;
  if Assigned(FOnMouseEnter) then FOnMouseEnter(Self);
end;

procedure TbsSkinControl.CMMouseLeave;
begin
  inherited;
  if (csDesigning in ComponentState) then Exit;
  if Assigned(FOnMouseLeave) then FOnMouseLeave(Self);
end;

procedure TbsSkinControl.WMEraseBkGnd;
begin
end;

procedure TbsSkinControl.WMMOVE;
begin
  inherited;
end;

procedure TbsSkinControl.BeforeChangeSkinData;
begin
  FIndex := -1;
end;

procedure TbsSkinControl.AfterChangeSkinData;
begin
end;

procedure TbsSkinControl.ChangeSkinData;
begin
  GetSkinData;
  RePaint;
end;

procedure TbsSkinControl.SetSkinDataName;
begin
  FSkinDataName := Value;
end;

procedure TbsSkinControl.SetSkinData;
begin
  FSD := Value;
  if (FSD <> nil) then
  if not FSD.Empty and not (csDesigning in ComponentState)
  then
    ChangeSkinData;
end;

procedure TbsSkinControl.GetSkinData;
begin
  if (FSD = nil) or FSD.Empty
  then
    FIndex := -1
  else
    FIndex := FSD.GetControlIndex(FSkinDataName);
end;

procedure TbsSkinControl.Paint;
var
  Buffer: TBitMap;
begin
  if (Width <= 0) or (Height <= 0) then Exit;
  GetSkinData;
  Buffer := TBitMap.Create;
  Buffer.Width := Width;
  Buffer.Height := Height;
  if FIndex <> -1
  then
    CreateControlSkinImage(Buffer)
  else
    CreateControlDefaultImage(Buffer);
  Canvas.Draw(0, 0, Buffer);
  Buffer.Free;
end;

procedure TbsSkinControl.CreateControlDefaultImage;
begin
end;

procedure TbsSkinControl.CreateControlSkinImage;
begin
end;

procedure TbsSkinControl.Notification;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FSD) then FSD := nil;
end;

constructor TbsSkinCustomControl.Create;
begin
  inherited Create(AOwner);
  FForceBackground := False;
  FDrawBackground := True;
  FDefaultWidth := 0;
  FDefaultHeight := 0;
  FDefaultFont := TFont.Create;
  FDefaultFont.OnChange := OnDefaultFontChange;
  StretchEffect := False;
  with FDefaultFont do
  begin
    Name := 'ËÎÌו';
    Charset := GB2312_CHARSET;
    Style := [];
    Height := -12;
  end;
  FUseSkinFont := False;
end;


destructor TbsSkinCustomControl.Destroy;
begin
  if FRgn <> 0
  then
    begin
      DeleteObject(FRgn);
      FRgn := 0;
    end;
  FDefaultFont.Free;
  inherited Destroy;
end;

procedure TbsSkinCustomControl.Paint;
var
  LB, RB, TB, BB, ClB: TBitMap;
  SaveIndex, X, Y, XCnt, YCnt, w, h, w1, h1: Integer;
begin
  if (Width <= 0) or (Height <= 0) then Exit;
  GetSkinData;
  W := Width;
  H := Height;
  CalcSize(W, H);
  if (FIndex <> -1) and FForceBackground and (ResizeMode = 1)
  then
    begin
      LB := TBitMap.Create;
      TB := TBitMap.Create;
      RB := TBitMap.Create;
      BB := TBitMap.Create;
      CreateSkinBorderImages(LtPt, RTPt, LBPt, RBPt, ClRect,
         NewLTPoint, NewRTPoint, NewLBPoint, NewRBPoint, NewClRect,
         LB, TB, RB, BB, Picture, SkinRect, Width, Height,
           LeftStretch, TopStretch, RightStretch, BottomStretch);
      CreateControlSkinImage(TB);
      // draw backgound
      if FDrawBackground
      then
      begin
      w := RectWidth(ClRect);
      h := RectHeight(ClRect);
      w1 := RectWidth(NewClRect);
      h1 := REctHeight(NewCLRect);
      XCnt := w1 div w;
      YCnt := h1 div h;
      Clb := TBitMap.Create;
      Clb.Width := w;
      Clb.Height := h;
      Clb.Canvas.CopyRect(Rect(0, 0, w, h), Picture.Canvas,
      Rect(SkinRect.Left + ClRect.Left, SkinRect.Top + ClRect.Top,
           SkinRect.Left + ClRect.Right,
           SkinRect.Top + ClRect.Bottom));
      SaveIndex := SaveDC(Canvas.Handle);
      IntersectClipRect(Canvas.Handle, NewCLRect.Left, NewCLRect.Top, NewCLRect.Right, NewClRect.Bottom);
      for X := 0 to XCnt do
      for Y := 0 to YCnt do
       begin
         Canvas.Draw(NewClRect.Left + X * w, NewClRect.Top + Y * h, Clb);
       end;
      Clb.Free;
      RestoreDC(Canvas.Handle, SaveIndex);
      end;
      //
      Canvas.Draw(0, 0, TB);
      Canvas.Draw(0, TB.Height, LB);
      Canvas.Draw(Width - RB.Width, TB.Height, RB);
      Canvas.Draw(0, Height - BB.Height, BB);
      LB.Free;
      TB.Free;
      RB.Free;
      BB.Free;
    end
  else
    inherited;
end;

function TbsSkinCustomControl.GetRealClientWidth: integer;
begin
  Result := NewClRect.Right - NewClRect.Left;
end;

function TbsSkinCustomControl.GetRealClientHeight: integer;
begin
  Result := NewClRect.Bottom - NewClRect.Top;
end;

function TbsSkinCustomControl.GetRealClientLeft: integer;
begin
  Result := NewClRect.Left;
end;

function TbsSkinCustomControl.GetRealClientTop: integer;
begin
  Result := NewClRect.Top;
end;

procedure TbsSkinCustomControl.SetDefaultWidth;
begin
  FDefaultWidth := Value;
  if (FIndex = -1) and (FDefaultWidth > 0) then Width := FDefaultWidth;
end;

procedure TbsSkinCustomControl.SetDefaultHeight;
begin
  FDefaultHeight := Value;
  if (FIndex = -1) and (FDefaultHeight > 0) then Height := FDefaultHeight;
end;

procedure TbsSkinCustomControl.DefaultFontChange;
begin
end;

procedure TbsSkinCustomControl.SetDefaultFont;
begin
  FDefaultFont.Assign(Value);
  DefaultFontChange;
end;

procedure TbsSkinCustomControl.OnDefaultFontChange;
begin
  DefaultFontChange;
  if FIndex = -1 then RePaint;
end;

procedure TbsSkinCustomControl.CreateControlDefaultImage;
var
  R: TRect;
begin
  with B.Canvas do
  begin
    Brush.Color := clBtnFace;
    R := ClientRect;
    FillRect(R);
  end;
end;

procedure TbsSkinCustomControl.ChangeSkinData;
var
  W, H: Integer;
  UpDate: Boolean;
begin
  GetSkinData;

  W := Width;
  H := Height;

  if FIndex <> -1
  then
    begin
      CalcSize(W, H);
      Update := (W <> Width) or (H <> Height);
      if W <> Width then Width := W;
      if H <> Height then Height := H;
    end
  else
    begin
      UpDate := False;
      if FDefaultWidth > 0 then Width := FDefaultWidth;
      if FDefaultHeight > 0 then Height := FDefaultHeight;
    end;

  if (not UpDate) or (FIndex = -1)
  then
    begin
      SetControlRegion;
      RePaint;
    end;
    
end;

procedure TbsSkinCustomControl.SetBounds;
var
  UpDate: Boolean;
  R: TRect;
begin
  GetSkinData;
  UpDate := ((Width <> AWidth) or (Height <> AHeight)) and (FIndex <> -1);
  if UpDate
  then
    begin
      CalcSize(AWidth, AHeight);
      if ResizeMode = 0 then NewClRect := ClRect;
    end;
  if Parent is TbsSkinToolbar
  then
    begin
      if TbsSkinToolbar(Parent).AdjustControls
      then
        with TbsSkinToolbar(Parent) do
        begin
          R := GetSkinClientRect;
          ATop := R.Top + RectHeight(R) div 2 - AHeight div 2;
        end;
    end;
  inherited;
  if UpDate
  then
    begin
      SetControlRegion;
      RePaint;
    end;
end;

procedure TbsSkinCustomControl.CalcSize;
var
  XO, YO: Integer;
begin
  if ResizeMode > 0
  then
    begin
      XO := W - RectWidth(SkinRect);
      YO := H - RectHeight(SkinRect);
      NewLTPoint := LTPt;
      case ResizeMode of
        1:
          begin
            NewRTPoint := Point(RTPt.X + XO, RTPt.Y);
            NewLBPoint := Point(LBPt.X, LBPt.Y + YO);
            NewRBPoint := Point(RBPt.X + XO, RBPt.Y + YO);
            NewClRect := Rect(CLRect.Left, ClRect.Top,
              CLRect.Right + XO, ClRect.Bottom + YO);
          end;
        2:
          begin
            H := RectHeight(SkinRect);
            NewRTPoint := Point(RTPt.X + XO, RTPt.Y );
            NewClRect := ClRect;
            Inc(NewClRect.Right, XO);
          end;
        3:
          begin
            W := RectWidth(SkinRect);
            NewLBPoint := Point(LBPt.X, LBPt.Y + YO);
            NewClRect := ClRect;
            Inc(NewClRect.Bottom, YO);
          end;
      end;
    end
  else
    if (FIndex <> -1) and (ResizeMode = 0)
    then
      begin
        W := RectWidth(SkinRect);
        H := RectHeight(SkinRect);
        NewClRect := CLRect;
      end;
end;

procedure TbsSkinCustomControl.CreateControlSkinImage;
begin
  CreateSkinControlImage(B, Picture, SkinRect);
end;

procedure TbsSkinCustomControl.CreateSkinControlImage;
begin
  case ResizeMode of
    0:
      begin
        B.Width := RectWidth(R);
        B.Height := RectHeight(R);
        B.Canvas.CopyRect(Rect(0, 0, B.Width, B.Height), SB.Canvas, R);
      end;
    1: if not FForcebackground
       then
         CreateSkinImage(LTPt, RTPt, LBPt, RBPt, CLRect,
            NewLtPoint, NewRTPoint, NewLBPoint, NewRBPoint, NewCLRect,
            B, SB, R, Width, Height, True,
            LeftStretch, TopStretch, RightStretch, BottomStretch,
            StretchEffect);
    2: CreateHSkinImage(LTPt.X, RectWidth(SkinRect) - RTPt.X,
          B, SB, R, Width, Height, StretchEffect);
    3: CreateVSkinImage(LTPt.Y, RectHeight(SkinRect) - LBPt.Y,
          B, SB, R, Width, Height, StretchEffect);
  end;
end;

function TbsSkinCustomControl.GetResizeMode;
begin
  if IsNullRect(SkinRect)
  then
    Result := -1
  else
  if (RBPt.X <> 0) and (RBPt.Y <> 0)
  then
    Result := 1
  else
  if (RTPt.X <> 0) or (RTPT.Y <> 0)
  then
    Result := 2
  else
  if (LBPt.X <> 0) or (LBPt.Y <> 0)
  then
    Result := 3
  else
    Result := 0;
end;

function TbsSkinCustomControl.GetNewRect;
var
  XO, YO: Integer;
  LeftTop, LeftBottom, RightTop, RightBottom: TRect;

function CorrectResizeRect: TRect;
var
  NR: TRect;
begin
  NR := R;
  if PointInRect(LeftTop, R.TopLeft) and
     PointInRect(RightBottom, R.BottomRight)
  then
    begin
      Inc(NR.Right, XO);
      Inc(NR.Bottom, YO);
    end
  else
  if PointInRect(LeftTop, R.TopLeft) and
     PointInRect(RightTop, R.BottomRight)
  then
    Inc(NR.Right, XO)
  else
    if PointInRect(LeftBottom, R.TopLeft) and
       PointInRect(RightBottom, R.BottomRight)
    then
      begin
        Inc(NR.Right, XO);
        OffsetRect(NR, 0, YO);
      end
    else
      if PointInRect(LeftTop, R.TopLeft) and
         PointInRect(LeftBottom, R.BottomRight)
      then
        Inc(NR.Bottom, YO)
      else
        if PointInRect(RightTop, R.TopLeft) and
           PointInRect(RightBottom, R.BottomRight)
        then
          begin
            OffsetRect(NR, XO, 0);
            Inc(NR.Bottom, YO);
          end;
  Result := NR;
end;

begin
  XO := Width - RectWidth(SkinRect);
  YO := Height - RectHeight(SkinRect);
  Result := R;
  case ResizeMode of
    1:
      begin
        LeftTop := Rect(0, 0, LTPt.X, LTPt.Y);
        LeftBottom := Rect(0, LBPt.Y, LBPt.X, RectHeight(SkinRect));
        RightTop := Rect(RTPt.X, 0, RectWidth(SkinRect), RTPt.Y);
        RightBottom := Rect(RBPt.X, RBPt.Y,
          RectWidth(SkinRect), RectHeight(SkinRect));
        Result := R;
        if RectInRect(R, LeftTop)
        then Result := R
        else
        if RectInRect(R, RightTop)
        then OffsetRect(Result, XO, 0)
        else
        if RectInRect(R, LeftBottom)
        then OffsetRect(Result, 0, YO)
        else
        if RectInRect(R, RightBottom)
        then
          OffsetRect(Result,  XO, YO)
        else
          Result := CorrectResizeRect;
      end;
    2:
      begin
        if (R.Left <= LTPt.X) and (R.Right >= RTPt.X)
        then
          Inc(Result.Right, XO)
        else
        if (R.Left >= RTPt.X) and (R.Right > RTPt.X)
        then
          OffsetRect(Result, XO, 0);
      end;
     3:
      begin
        if (R.Top <= LTPt.Y) and (R.Bottom >= LBPt.Y)
        then
          Inc(Result.Bottom, YO)
        else
          if (R.Top >= LBPt.Y) and (R.Bottom > LBPt.X)
          then
            OffsetRect(Result, 0, YO);
      end;
  end;
end;

procedure TbsSkinCustomControl.GetSkinData;
begin
  inherited;
  if FIndex <> -1
  then
    if TbsDataSkinControl(FSD.CtrlList.Items[FIndex]) is TbsDataSkinCustomControl
    then
      with TbsDataSkinCustomControl(FSD.CtrlList.Items[FIndex]) do
      begin
        LTPt := LTPoint;
        RTPt := RTPoint;
        LBPt := LBPoint;
        RBPt := RBPoint;
        Self.SkinRect := SkinRect;
        Self.StretchEffect := StretchEffect;
        Self.LeftStretch := LeftStretch;
        Self.TopStretch := TopStretch; 
        Self.RightStretch := RightStretch;
        Self.BottomStretch := BottomStretch;
        Self.ClRect := ClRect;
        if (PictureIndex <> -1) and (PictureIndex < FSD.FActivePictures.Count)
        then
          Picture := TBitMap(FSD.FActivePictures.Items[PictureIndex])
        else
          Picture := nil;
        if (MaskPictureIndex <> -1) and (MaskPictureIndex < FSD.FActivePictures.Count)
        then
          MaskPicture := TBitMap(FSD.FActivePictures.Items[MaskPictureIndex])
        else
          MaskPicture := nil;
        ResizeMode := GetResizeMode;
      end
    else
      begin
        ResizeMode := 0;
        Picture := nil;
        MaskPicture := nil;
      end;
end;

procedure TbsSkinCustomControl.CreateControlRegion;
var
  TempRgn: HRGN;
  Offset: Integer;
  W, H: Integer;
begin
  W := Width;
  H := Height;
  CalcSize(W, H);
  TempRgn := FRgn;
  case ResizeMode of
    0:
      CreateSkinSimplyRegion(FRgn, MaskPicture);
    1:
      CreateSkinRegion
       (FRgn, LTPt, RTPt, LBPt, RBPt, ClRect,
        NewLtPoint, NewRTPoint, NewLBPoint, NewRBPoint, NewClRect,
        MaskPicture, Width, Height);
    2:
      begin
        Offset := Width - RectWidth(SkinRect);
        CreateSkinRegion(FRgn,
          LTPt, RTPt, LTPt, RTPt, ClRect,
          LTPt, Point(RTPt.X + Offset, RTPt.Y),
          LTPt, Point(RTPt.X + Offset, RTPt.Y), NewClRect,
          MaskPicture, Width, Height);
      end;
    3:
      begin
        Offset := Height - RectHeight(SkinRect);
        CreateSkinRegion(FRgn,
          LTPt, LTPt, LBPt, LBPt, ClRect,
          LTPt, LTPt,
          Point(LBPt.X, LBPt.Y + Offset),
          Point(LBPt.X, LBPt.Y + Offset), NewClRect,
          MaskPicture, Width, Height);
      end;
  end;
  SetWindowRgn(Handle, FRgn, True);
  if TempRgn <> 0 then DeleteObject(TempRgn);
end;

procedure TbsSkinCustomControl.SetControlRegion;
begin
  if ((MaskPicture = nil) or (FIndex = -1)) and (FRgn <> 0)
  then
    begin
      SetWindowRgn(Handle, 0, True);
      DeleteObject(FRgn);
      FRgn := 0;
    end
  else
    if (MaskPicture <> nil) and (FIndex <> -1)
    then CreateControlRegion;
end;

//=========== TbsSkinButton ===============
constructor TbsSkinButton.Create;
begin
  inherited;
  TabStop := True;
  FUseSkinSize := True;
  FUseSkinFontColor := True;
  FSpaceSupport := True;
  AnimateTimer := nil;
  RepeatTimer := nil;
  FRepeatMode := False;
  FRepeatInterval := 100;
  FActive := False;
  MorphTimer := nil;
  FAllowAllUp := False;
  FAllowAllUpCheck := False;
  FSkinDataName := 'button';
  FCanFocused := True;
  FDown := False;
  FMouseDown := False;
  FMouseIn := False;
  Width := 75;
  Height := 25;
  FGroupIndex := 0;
  FGlyph := TBitMap.Create;
  FNumGlyphs := 1;
  FMargin := -1;
  FSpacing := 1;
  FLayout := blGlyphLeft;
  FMorphKf := 0;
  FSkinImagesMenu := nil;
  FUseImagesMenuImage := False;
  FUseImagesMenuCaption := False;
  FImageList := nil;
  FImageIndex := -1;
end;

destructor TbsSkinButton.Destroy;
begin
  FGlyph.Free;
  StopMorph;
  if RepeatTimer <> nil then RepeatTimer.Free;
  RepeatTimer := nil;
  if AnimateTimer <> nil then StopAnimate;
  inherited;
end;

procedure TbsSkinButton.SetImageIndex(Value: Integer);
begin
  if FImageIndex <> Value
  then
    begin
      FImageIndex := Value;
      RePaint;
    end;
end;

procedure TbsSkinButton.DrawMenuMarker;
var
  Buffer: TBitMap;
  SR: TRect;
  X, Y: Integer;
begin
  if ADown then SR := MenuMarkerDownRect else
    if AActive then SR := MenuMarkerActiveRect else
        SR := MenuMarkerRect;
  Buffer := TBitMap.Create;
  Buffer.Width := RectWidth(SR);
  Buffer.Height := RectHeight(SR);

  Buffer.Canvas.CopyRect(Rect(0, 0, Buffer.Width, Buffer.Height),
    Picture.Canvas, SR);

  Buffer.Transparent := True;
  Buffer.TransparentMode := tmFixed;
  Buffer.TransparentColor := MenuMarkerTransparentColor;

  X := R.Left + RectWidth(R) div 2 - RectWidth(SR) div 2;
  Y := R.Top + RectHeight(R) div 2 - RectHeight(SR) div 2;

  C.Draw(X, Y, Buffer);

  Buffer.Free;
end;

procedure TbsSkinButton.Notification;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FSkinImagesMenu)
  then FSkinImagesMenu := nil;
  if (Operation = opRemove) and (AComponent = FImageList)
  then FImageList := nil;
end;

procedure TbsSkinButton.OnImagesMenuChanged(Sender: TObject);
begin
  RePaint;
end;

procedure TbsSkinButton.SetSkinImagesMenu(Value: TbsSkinImagesMenu);
begin
  FSkinImagesMenu := Value;
  if Value <> nil
  then
    begin
      FSkinImagesMenu.OnInternalChange := OnImagesMenuChanged;
    end;
  OnImagesMenuChanged(Self);
end;

procedure TbsSkinButton.RefreshButton;
begin
  FMouseIn := False;
  FDown := False;
  if EnableMorphing then FMorphKf := 0;
  if EnableAnimation then StopAnimate;
  RePaint;
end;

function TbsSkinButton.EnableAnimation: Boolean;
begin
  Result := (SkinData <> nil) and not SkinData.Empty and
            SkinData.EnableSkinEffects;
end;

function TbsSkinButton.EnableMorphing: Boolean;
begin
  Result := Morphing and (SkinData <> nil) and not SkinData.Empty and
            SkinData.EnableSkinEffects;
end;

procedure TbsSkinButton.StartAnimate;
begin
  StopAnimate;
  AnimateInc := AInc;
  if not AnimateInc then CurrentFrame := FrameCount else  CurrentFrame := 1;
  AnimateTimer := TTimer.Create(Self);
  AnimateTimer.Enabled := False;
  AnimateTimer.OnTimer := DoAnimate;
  AnimateTimer.Interval := AnimateInterval;
  AnimateTimer.Enabled := True;
end;

procedure TbsSkinButton.StopAnimate;
begin
  CurrentFrame := 0;
  if AnimateTimer <> nil
  then
    begin
      AnimateTimer.Enabled := False;
      AnimateTimer.Free;
      AnimateTimer := nil;
    end;  
end;

procedure TbsSkinButton.DoAnimate(Sender: TObject);
begin
  if AnimateInc
  then
    begin
      if CurrentFrame <= FrameCount
      then
        begin
         Inc(CurrentFrame);
         RePaint;
       end;
      if CurrentFrame > FrameCount then StopAnimate;
    end
  else
    begin
      if CurrentFrame >= 0
      then
        begin
          Dec(CurrentFrame);
          RePaint;
        end;
      if CurrentFrame <= 0 then StopAnimate;
    end;
end;

procedure TbsSkinButton.CalcSize(var W, H: Integer);
begin
  if FUseSkinSize or (ResizeMode = 1) then inherited;
end;

procedure TbsSkinButton.WMEraseBkgnd;
begin
  if not FromWMPaint
  then
    PaintWindow(Msg.DC);
end;

procedure TbsSkinButton.Click;
begin
  if ActionLink = nil then inherited;
end;

procedure TbsSkinButton.RepeatTimerProc;
begin
  ButtonClick;
end;

procedure TbsSkinButton.StartRepeat;
begin
  if RepeatTimer <> nil then RepeatTimer.Free;
  RepeatTimer := TTimer.Create(Self);
  RepeatTimer.Enabled := False;
  RepeatTimer.OnTimer := RepeatTimerProc;
  RepeatTimer.Interval := FRepeatInterval;
  RepeatTimer.Enabled := True;
end;

procedure TbsSkinButton.StopRepeat;
begin
  if RepeatTimer = nil then Exit;
  RepeatTimer.Enabled := False;
  RepeatTimer.Free;
  RepeatTimer := nil;
end;

procedure TbsSkinButton.StartMorph;
begin
  if MorphTimer <> nil then Exit;
  MorphTimer := TTimer.Create(Self);
  MorphTimer.Interval := MorphTimerInterval;
  MorphTimer.OnTimer := DoMorph;
  MorphTimer.Enabled := True;
end;

procedure TbsSkinButton.StopMorph;
begin
  if MorphTimer = nil then Exit;
  MorphTimer.Free;
  MorphTimer := nil;
end;

procedure TbsSkinButton.DoMorph;
begin
  if (FIndex = -1) or not EnableMorphing
  then
    begin
      if (FMouseIn or IsFocused) then FMorphKf := 1 else FMorphKf := 0;
      StopMorph;
    end
  else
  if (FMouseIn or IsFocused) and (FMorphKf < 1)
  then
    begin
      FMorphKf := FMorphKf + MorphInc;
      RePaint;
    end
  else
  if not (FMouseIn or IsFocused) and (FMorphKf > 0)
  then
    begin
      FMorphKf := FMorphKf - MorphInc;
      RePaint;
    end
  else
    begin
      if (FMouseIn or IsFocused) then FMorphKf := 1 else FMorphKf := 0;
      StopMorph;
      RePaint;
    end;
end;

procedure TbsSkinButton.ReDrawControl;
begin
  if EnableMorphing and (FIndex <> -1)
  then StartMorph
  else RePaint;
end;

procedure TbsSkinButton.SetDefault(Value: Boolean);
var
  Form: TCustomForm;
begin
  FDefault := Value;
  if HandleAllocated and FCanFocused
  then
    begin
      Form := GetParentForm(Self);
      if Form <> nil then
        Form.Perform(CM_FOCUSCHANGED, 0, Longint(Form.ActiveControl));
    end;
end;

procedure TbsSkinButton.CMDialogKey(var Message: TCMDialogKey);
begin
  with Message do
   if FActive and (CharCode = VK_RETURN) and Enabled
   then
     begin
       ButtonClick;
       Result := 1;
     end
   else
   if (CharCode = VK_ESCAPE) and FCancel and FCanFocused and
      (KeyDataToShiftState(Message.KeyData) = []) and CanFocus
   then
     begin
       ButtonClick;
       Result := 1;
     end
   else
     inherited;
end;

procedure TbsSkinButton.CreateWnd;
begin
  inherited CreateWnd;
  FActive := FDefault;
end;

procedure TbsSkinButton.CMFocusChanged(var Message: TCMFocusChanged);
begin

  with Message do
    if Sender is TbsSkinButton then
      FActive := Sender = Self
    else
      FActive := FDefault;

  if CanFocused and FDefault
  then
    if (Message.Sender <> Self) and (Message.Sender is TbsSkinButton) and
       FMouseIn
    then
      begin
        FMouseIn := False;
        ReDrawControl;
      end
    else
    if (Message.Sender <> Self) and not (Message.Sender is TbsSkinButton) and
       not FMouseIn
    then
      begin
        if EnableMorphing then FMorphKf := 1;
        FMouseIn := True;
        ReDrawControl;
      end;
  inherited;
end;

procedure TbsSkinButton.ButtonClick;
var
  Form: TCustomForm;
begin
  if FCanFocused
  then
    begin
      Form := GetParentForm(Self);
      if Form <> nil then Form.ModalResult := ModalResult;
    end;
 { Call OnClick if assigned and not equal to associated action's OnExecute.
    If associated action's OnExecute assigned then call it, otherwise, call
    OnClick. }
  if Assigned(FOnClick) and (Action <> nil) and (@FOnClick <> @Action.OnExecute)
  then
    FOnClick(Self)
  else
    if not (csDesigning in ComponentState) and (ActionLink <> nil)
    then
      ActionLink.Execute
     else
       if Assigned(FOnClick) then FOnClick(Self);
// if Assigned(FOnClick) then FOnClick(Self);
end;

procedure TbsSkinButton.CMEnabledChanged;
begin
  inherited;
  if EnableMorphing
  then
    begin
      StopMorph;
      FMorphKf := 0;
    end;
  FMouseIn := False;  
  RePaint;
end;

procedure TbsSkinButton.ChangeSkinData;
begin
  StopMorph;
  StopAnimate;
  FMorphKf := 0;
  inherited;
  if EnableMorphing and (FIndex <> -1) and (IsFocused or FMouseIn)
  then
    FMorphKf := 1;
end;

procedure TbsSkinButton.SetGroupIndex;
begin
  FGroupIndex := Value;
  if FGroupIndex <> 0 then CanFocused := False;
end;

function TbsSkinButton.IsFocused;
begin
  Result := Focused and FCanFocused;
end;

procedure TbsSkinButton.CMDialogChar;
begin
  with Message do
    if IsAccel(CharCode, Caption) and CanFocus and FCanFocused
    then
      begin
        SetFocus;
        ButtonClick;
        Result := 1;
      end
    else
     inherited;
end;

procedure TbsSkinButton.SetCanFocused;
begin
  FCanFocused := Value;
  TabStop := FCanFocused;
end;

procedure TbsSkinButton.WMSETFOCUS;
begin
  inherited;
  if FCanFocused
  then
    begin
      if (FIndex <> -1) and EnableAnimation and not IsNullRect(AnimateSkinRect) then StartAnimate(True);
      ReDrawControl;
    end;
end;

procedure TbsSkinButton.WMKILLFOCUS;
begin
  if FRepeatMode and (RepeatTimer <> nil) then StopRepeat;
  if (GroupIndex = 0) and FDown then FDown := False;
  inherited;
  if FCanFocused
  then
    begin
      if (FIndex <> -1)and EnableAnimation and not IsNullRect(AnimateSkinRect) then StartAnimate(False);
      ReDrawControl;
    end;
end;

procedure TbsSkinButton.WndProc(var Message: TMessage);
begin
  if FCanFocused then
  case Message.Msg of
    WM_KEYDOWN:
      if (TWMKEYDOWN(Message).CharCode = VK_SPACE) and FSpaceSupport
      then
        begin
          if (FIndex <> -1) and not IsNullRect(AnimateSkinRect) then StopAnimate;
          Down := True;
          if FRepeatMode then ButtonClick;
        end
      else
      if (TWMKEYDOWN(Message).CharCode = VK_RETURN) and FSpaceSupport
      then
        begin
          ButtonClick;
        end;
    WM_KEYUP:
      if (TWMKEYUP(Message).CharCode = VK_SPACE)
      then
        begin
          Down := False;
          ButtonClick;
        end;
    WM_LBUTTONDOWN, WM_LBUTTONDBLCLK:
      if not (csDesigning in ComponentState) and not Focused then
      begin
        FClicksDisabled := True;
        Windows.SetFocus(Handle);
        FClicksDisabled := False;
        if not Focused then Exit;
      end;
    CN_COMMAND:
      if FClicksDisabled then Exit;
  end;
  inherited WndProc(Message);
end;

procedure TbsSkinButton.ActionChange(Sender: TObject; CheckDefaults: Boolean);

  procedure CopyImage(ImageList: TCustomImageList; Index: Integer);
  begin
    with FGlyph do
    begin
      Width := ImageList.Width;
      Height := ImageList.Height;
      Canvas.Brush.Color := clFuchsia;
      Canvas.FillRect(Rect(0, 0, Width, Height));
      ImageList.Draw(Canvas, 0, 0, Index);
    end;
  end;

begin
  inherited ActionChange(Sender, CheckDefaults);
  if Sender is TCustomAction then
    with TCustomAction(Sender) do
    begin
      if (FGlyph.Empty) and (ActionList <> nil) and (ActionList.Images <> nil) and
        (ImageIndex >= 0) and (ImageIndex < ActionList.Images.Count) then
      begin
        CopyImage(ActionList.Images, ImageIndex);
        RePaint;
      end;
    end;
end;

procedure TbsSkinButton.SetLayout;
begin
  if FLayout <> Value
  then
    begin
      FLayout := Value;
      RePaint;
    end;  
end;

procedure TbsSkinButton.SetSpacing;
begin
  if Value <> FSpacing
  then
    begin
      FSpacing := Value;
      RePaint;
    end;
end;

procedure TbsSkinButton.SetMargin;
begin
  if (Value <> FMargin) and (Value >= -1)
  then
    begin
      FMargin := Value;
      RePaint;
    end;
end;

procedure TbsSkinButton.SetDown;
begin
  FDown := Value;
  if EnableMorphing
  then
     begin
       FMorphKf := 1;
       if not FDown then StartMorph else StopMorph;
     end;
  RePaint;    
  if (GroupIndex <> 0) and FDown and not FAllowAllUp then DoAllUp;
end;

procedure TbsSkinButton.DoAllUp;
var
  PC: TWinControl;
  i: Integer;
begin
  if Parent = nil then Exit;
  PC := TWinControl(Parent);
  for i := 0 to PC.ControlCount - 1 do
   if (PC.Controls[i] is TbsSkinButton) and
      (PC.Controls[i] <> Self)
   then
     with TbsSkinButton(PC.Controls[i]) do
       if (GroupIndex = Self.GroupIndex) and
          (GroupIndex <> 0) and FDown
       then
         Down := False;
end;

procedure TbsSkinButton.SetGlyph;
begin
  FGlyph.Assign(Value);
  RePaint;
end;

procedure TbsSkinButton.SetNumGlyphs;
begin
  FNumGlyphs := Value;
  RePaint;
end;

function TbsSkinButton.GetAnimationFrameRect: TRect;
var
  fs: Integer;
begin
  if RectWidth(AnimateSkinRect) > RectWidth(SkinRect)
  then
    begin
      fs := RectWidth(AnimateSkinRect) div FrameCount;
      Result := Rect(AnimateSkinRect.Left + (CurrentFrame - 1) * fs,
                 AnimateSkinRect.Top,
                 AnimateSkinRect.Left + CurrentFrame * fs,
                 AnimateSkinRect.Bottom);
    end
  else
    begin
      fs := RectHeight(AnimateSkinRect) div FrameCount;
      Result := Rect(AnimateSkinRect.Left,
                     AnimateSkinRect.Top + (CurrentFrame - 1) * fs,
                     AnimateSkinRect.Right,
                     AnimateSkinRect.Top + CurrentFrame * fs);
    end;
end;

procedure TbsSkinButton.GetSkinData;
begin
  inherited;
  if FIndex <> -1
  then
    begin
      if TbsDataSkinControl(FSD.CtrlList.Items[FIndex]) is TbsDataSkinButtonControl
      then
        with TbsDataSkinButtonControl(FSD.CtrlList.Items[FIndex]) do
        begin
          if  not FUseSkinSize and (MaskPictureIndex <> -1)
          then
            MaskPicture := nil;
          Self.FontName := FontName;
          Self.FontColor := FontColor;
          Self.ActiveFontColor := ActiveFontColor;
          Self.DownFontColor := DownFontColor;
          Self.FontStyle := FontStyle;
          Self.FontHeight := FontHeight;
          Self.ActiveSkinRect := ActiveSkinRect;
          Self.DownSkinRect := DownSkinRect;
          if IsNullRect(ActiveSkinRect) then Self.ActiveSkinRect := SkinRect;
          if IsNullRect(DownSkinRect) then Self.DownSkinRect := Self.ActiveSkinRect;
          Self.DisabledSkinRect := DisabledSkinRect;
          Self.DisabledFontColor := DisabledFontColor;
          Self.Morphing := Morphing;
          Self.MorphKind := MorphKind;
          Self.AnimateSkinRect := AnimateSkinRect; 
          Self.FrameCount := FrameCount;
          Self.AnimateInterval := AnimateInterval;
          Self.ShowFocus := ShowFocus;
          //
          Self.MenuMarkerRect := MenuMarkerRect;
          Self.MenuMarkerActiveRect := MenuMarkerActiveRect;
          Self.MenuMarkerDownRect := MenuMarkerDownRect;
          Self.MenuMarkerFlatRect := MenuMarkerFlatRect;
          Self.MenuMarkerTransparentColor := MenuMarkerTransparentColor;
          if IsNullRect(Self.MenuMarkerActiveRect)
          then
            Self.MenuMarkerActiveRect := Self.MenuMarkerRect;
          if IsNullRect(Self.MenuMarkerDownRect)
          then
            Self.MenuMarkerDownRect := Self.MenuMarkerActiveRect;
          //
        end;
     if EnableAnimation and (AnimateTimer <> nil) and (CurrentFrame <= FrameCount) and
        (CurrentFrame > 0)
     then
       begin
         if AnimateInc
         then
           ActiveSkinRect := GetAnimationFrameRect
         else
           SkinRect := GetAnimationFrameRect;
       end;
   end
  else
    AnimateSkinRect := NullRect;
end;

function TbsSkinButton.GetGlyphNum;
begin
  if AIsDown and AIsMouseIn and (FNumGlyphs > 2)
  then
    Result := 3
  else
  if AIsMouseIn and (FNumGlyphs > 3)
  then
    Result := 4
  else
    if not Enabled and (FNumGlyphs > 1)
    then
      Result := 2
    else
      Result := 1;
end;

procedure TbsSkinButton.CreateStrechButtonImage(B: TBitMap; R: TRect;
      ADown, AMouseIn: Boolean);
var
  TR: TRect;
  S: String;
begin
  //
  if ResizeMode = 0
  then
    B.Canvas.CopyRect(Rect(0, 0, B.Width, B.Height), Picture.Canvas, R)
  else
  if (ResizeMode = 2) or (ResizeMode = 3)
  then
    CreateStretchImage(B, Picture, R, ClRect, True);
  //
  if not FUseSkinFont
  then
    B.Canvas.Font.Assign(FDefaultFont)
  else
    with B.Canvas.Font do
    begin
      Name := FontName;
      Height := FontHeight;
      Style := FontStyle;
    end;

  with B.Canvas.Font do
  begin

    if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
    then
      Charset := SkinData.ResourceStrData.CharSet
    else
      CharSet := FDefaultFont.Charset;

    if Enabled and not FUseSkinFontColor
    then
      begin
        Color := FDefaultFont.Color;
      end
    else
    if not Enabled
    then
      Color := DisabledFontColor
    else
    if ADown and AMouseIn
    then
      Color := DownFontColor
    else
      if AMouseIn
      then Color := ActiveFontColor
      else Color := FontColor;
  end;
  TR := ClRect;
  TR.Right := TR.Right + (B.Width - RectWidth(R));
  TR.Bottom := TR.Bottom + (B.Height - RectHeight(R));

  if ShowFocus and Focused
  then
    begin
      B.Canvas.Brush.Style := bsSolid;
      B.Canvas.Brush.Color := FSD.SkinColors.cBtnFace;
      B.Canvas.DrawFocusRect(TR);
      B.Canvas.Brush.Style := bsClear;
    end;

  if (FSkinImagesMenu <> nil) and (FSkinImagesMenu.SelectedItem <> nil) and
      FUseImagesMenuImage
  then
    begin
      if FUseImagesMenuCaption
      then
        S := FSkinImagesMenu.SelectedItem.Caption
      else
        S := Caption;
      DrawImageAndText(B.Canvas, TR, FMargin, FSpacing, FLayout,
        S, FSkinImagesMenu.SelectedItem.ImageIndex, FSkinImagesMenu.Images,
        ADown and AMouseIn, Enabled, False, 0);
    end
  else
  if (FImageList <> nil) and (FImageIndex >= 0) and
     (FImageIndex < FImageList.Count)
  then
    begin
      DrawImageAndText(B.Canvas, TR, FMargin, FSpacing, FLayout,
        Caption, FImageIndex, FImageList,
        ADown and AMouseIn, Enabled, False, 0);
    end
  else
   DrawGlyphAndText(B.Canvas,
    TR, FMargin, FSpacing, FLayout,
    Caption, FGlyph, FNumGlyphs, GetGlyphNum(ADown, AMouseIn), ADown and AMouseIn, False, 0);

end;

procedure TbsSkinButton.CreateButtonImage;
var
  S: String;
begin
 if (not FUseSkinSize) and (ResizeMode <> 1)
  then
    begin
      CreateStrechButtonImage(B, R, ADown, AMouseIn);
      Exit;
    end;
  CreateSkinControlImage(B, Picture, R);
  if not FUseSkinFont
  then
    B.Canvas.Font.Assign(FDefaultFont)
  else
    with B.Canvas.Font do
    begin
      Name := FontName;
      Height := FontHeight;
      Style := FontStyle;
    end;

  with B.Canvas.Font do
  begin

    if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
    then
      Charset := SkinData.ResourceStrData.CharSet
    else
      CharSet := FDefaultFont.Charset;

    if Enabled and not FUseSkinFontColor
    then
      begin
        Color := FDefaultFont.Color;
      end
    else
    if not Enabled
    then
      Color := DisabledFontColor
    else
    if ADown and AMouseIn
    then
      Color := DownFontColor
    else
      if AMouseIn
      then Color := ActiveFontColor
      else Color := FontColor;
  end;

  if ShowFocus and Focused
  then
    begin
      B.Canvas.Brush.Style := bsSolid;
      B.Canvas.Brush.Color := FSD.SkinColors.cBtnFace;
      B.Canvas.DrawFocusRect(NewClRect);
      B.Canvas.Brush.Style := bsClear;
    end;


  if (FSkinImagesMenu <> nil) and (FSkinImagesMenu.SelectedItem <> nil) and
      FUseImagesMenuImage
  then
    begin
      if FUseImagesMenuCaption
      then
        S := FSkinImagesMenu.SelectedItem.Caption
      else
        S := Caption;
      DrawImageAndText(B.Canvas, NewClRect, FMargin, FSpacing, FLayout,
        S, FSkinImagesMenu.SelectedItem.ImageIndex, FSkinImagesMenu.Images,
        ADown and AMouseIn, Enabled, False, 0);
    end
  else
  if (FImageList <> nil) and (FImageIndex >= 0) and
     (FImageIndex < FImageList.Count)
  then
    begin
      DrawImageAndText(B.Canvas, NewClRect, FMargin, FSpacing, FLayout,
        Caption, FImageIndex, FImageList,
        ADown and AMouseIn, Enabled, False, 0);
    end
  else
    DrawGlyphAndText(B.Canvas,
      NewClRect, FMargin, FSpacing, FLayout,
      Caption, FGlyph, FNumGlyphs, GetGlyphNum(ADown, AMouseIn), ADown and AMouseIn, False, 0);

end;

procedure TbsSkinButton.CreateControlDefaultImage;
var
  R: TRect;
  IsDown: Boolean;
  S: String;
begin
  IsDown := False;
  R := ClientRect;
  if FDown and (((FMouseIn or (IsFocused and not FMouseDown)) and
     (GroupIndex = 0)) or (GroupIndex  <> 0))
  then
    begin
      Frame3D(B.Canvas, R, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
      B.Canvas.Brush.Color := BS_XP_BTNDOWNCOLOR;
      B.Canvas.FillRect(R);
      IsDown := True;
    end
  else
    if FMouseIn or IsFocused
    then
      begin
        Frame3D(B.Canvas, R, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
        B.Canvas.Brush.Color := BS_XP_BTNACTIVECOLOR;
        B.Canvas.FillRect(R);
      end
    else
      begin
        Frame3D(B.Canvas, R, clBtnShadow, clBtnShadow, 1);
        B.Canvas.Brush.Color := clBtnFace;
        B.Canvas.FillRect(R);
      end;

  B.Canvas.Font.Assign(FDefaultFont);
  if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
  then
    B.Canvas.Font.Charset := SkinData.ResourceStrData.CharSet;
    
  if not Enabled then B.Canvas.Font.Color := clBtnShadow;

  if (FSkinImagesMenu <> nil) and (FSkinImagesMenu.SelectedItem <> nil) and
      FUseImagesMenuImage
  then
    begin
      if FUseImagesMenuCaption
      then
        S := FSkinImagesMenu.SelectedItem.Caption
      else
        S := Caption;
      DrawImageAndText(B.Canvas, ClientRect, FMargin, FSpacing, FLayout,
        S, FSkinImagesMenu.SelectedItem.ImageIndex, FSkinImagesMenu.Images,
        FDown and FMouseIn, Enabled, False, 0);
    end
  else
  if (FImageList <> nil) and (FImageIndex >= 0) and
     (FImageIndex < FImageList.Count)
  then
    begin
      DrawImageAndText(B.Canvas, ClientRect, FMargin, FSpacing, FLayout,
        Caption, FImageIndex, FImageList,
        FDown and FMouseIn, Enabled, False, 0);
    end
  else
    DrawGlyphAndText(B.Canvas,
    ClientRect, FMargin, FSpacing, FLayout,
    Caption, FGlyph, FNumGlyphs, GetGlyphNum(FDown, FMouseIn), IsDown, False, 0);
end;

procedure TbsSkinButton.CreateControlSkinImage;
begin

end;

procedure TbsSkinButton.Paint;
var
  Buffer, ABuffer: TBitMap;
  PBuffer, APBuffer: TbsEffectBmp;
begin
  GetSkinData;
  if FIndex = -1
  then
    inherited
  else
    begin
      Buffer := TBitMap.Create;
      Buffer.Width := Width;
      Buffer.Height := Height;
      if EnableMorphing and (FMorphKf < 1) and (FMorphKf > 0) and Enabled
      then
        begin
          ABuffer := TBitMap.Create;
          ABuffer.Width := Width;
          ABuffer.Height := Height;
          CreateButtonImage(Buffer, SkinRect, False, False);
          CreateButtonImage(ABuffer, ActiveSkinRect, False, True);
          PBuffer := TbsEffectBmp.CreateFromhWnd(Buffer.Handle);
          APBuffer := TbsEffectBmp.CreateFromhWnd(ABuffer.Handle);
          case MorphKind of
            mkDefault: PBuffer.Morph(APBuffer, FMorphKf);
            mkGradient: PBuffer.MorphGrad(APBuffer, FMorphKf);
            mkLeftGradient: PBuffer.MorphLeftGrad(APBuffer, FMorphKf);
            mkRightGradient: PBuffer.MorphRightGrad(APBuffer, FMorphKf);
            mkLeftSlide: PBuffer.MorphLeftSlide(APBuffer, FMorphKf);
            mkRightSlide: PBuffer.MorphRightSlide(APBuffer, FMorphKf);
            mkPush: PBuffer.MorphPush(APBuffer, FMorphKf);
          end;
          PBuffer.Draw(Canvas.Handle, 0, 0);
          PBuffer.Free;
          APBuffer.Free;
          ABuffer.Free;
          Buffer.Free;
        end
      else
        begin
          if (not Enabled) and not IsNullRect(DisabledSkinRect)
          then
            CreateButtonImage(Buffer, DisabledSkinRect, False, False)
          else
          if FDown and (((FMouseIn or (IsFocused and not FMouseDown)) and
            (GroupIndex = 0)) or (GroupIndex  <> 0))
          then
            CreateButtonImage(Buffer, DownSkinRect, True, True)
          else
            if (IsFocused or FMouseIn) or (not (IsFocused or FMouseIn) and
                EnableMorphing and (FMorphKf = 1))
            then
              CreateButtonImage(Buffer, ActiveSkinRect, False, True)
            else
              CreateButtonImage(Buffer, SkinRect, False, False);
          Canvas.Draw(0, 0, Buffer);
          Buffer.Free;
        end;
    end;
end;

procedure TbsSkinButton.CMTextChanged;
begin
  inherited;
  RePaint;
end;

procedure TbsSkinButton.CMMouseEnter(var Message: TMessage);
var
  CanPaint: Boolean;
begin
  inherited;
  if (csDesigning in ComponentState) then Exit;
  FMouseIn := True;
  if GroupIndex <> 0
  then
    CanPaint := not FDown
  else
    CanPaint := not IsFocused or FDown;
  if CanPaint
  then
    begin
      if FDown
      then
        begin
          if EnableMorphing then FMorphKf := 1;
          RePaint;
        end
      else
        begin
          if (FIndex <> -1) and EnableAnimation and  not IsNullRect(AnimateSkinRect) then StartAnimate(True);
          ReDrawControl;
        end;
    end;
  if FDown and FRepeatMode and (GroupIndex = 0) then StartRepeat;
end;


procedure TbsSkinButton.CMMouseLeave(var Message: TMessage);
var
  CanPaint: Boolean;
begin
  inherited;
  if (csDesigning in ComponentState) then Exit;
  if not (FCanFocused and FDefault and FActive and not Focused)
  then
    FMouseIn := False;

  if GroupIndex <> 0
  then
    CanPaint := not FDown
  else
    CanPaint := not IsFocused or FDown;

  if CanPaint
  then
     begin
       if (FIndex <> -1) and EnableAnimation and not IsNullRect(AnimateSkinRect) then StartAnimate(False);
       ReDrawControl;
     end;

  if FDown and FRepeatMode and (RepeatTimer <> nil) and (GroupIndex = 0) then StopRepeat;
end;

procedure TbsSkinButton.MouseDown;
begin
  inherited;
  if Button = mbLeft
  then
    begin
      if (FIndex <> -1) and EnableAnimation and not IsNullRect(AnimateSkinRect) then StopAnimate;
      FMouseDown := True;
      if not FDown
      then
        begin
          FMouseIn := True;
          Down := True;
          if FRepeatMode and (GroupIndex = 0)
          then
            StartRepeat
          else
            if (GroupIndex <> 0) then ButtonClick;
          FAllowAllUpCheck := False;
        end
      else
        if (GroupIndex <> 0) then FAllowAllUpCheck := True;
    end;
end;

procedure TbsSkinButton.MouseUp;
var
  CheckDown: Boolean;
begin
  if Button = mbLeft
  then
    begin
      FMouseDown := False;
      CheckDown := FDown;
      if GroupIndex = 0
      then
        begin
          if FMouseIn
          then
            begin
              Down := False;
              if FRepeatMode and (RepeatTimer <> nil)  then StopRepeat;
              if CheckDown then ButtonClick;
           end
            else
              begin
                FDown := False;
                if FRepeatMode and (RepeatTimer <> nil) then StopRepeat;
              end;
        end
      else
        if (GroupIndex <> 0) and FDown and FAllowAllUp and
           FAllowAllUpCheck and FMouseIn
        then
          begin
            Down := False;
            ButtonClick;
          end;
   end;
  if HandleAllocated and Visible then inherited;
end;

//==============TbsSkinMenuButton==========//
constructor TbsSkinMenuButton.Create;
begin
  inherited;
  FSkinDataName := 'toolmenubutton';
  FTrackButtonMode := False;
  FMenuTracked := False;
  FSkinPopupMenu := nil;
  FSpaceSupport := False;
end;

destructor TbsSkinMenuButton.Destroy;
begin
  inherited;
end;

procedure TbsSkinMenuButton.CreateControlSkinResizeImage2;
var
  R, R1: TRect;
  isDown: Boolean;
  E: Boolean;
  B1, B2: TBitMap;
  SRect, ARect, DRect: TRect;
  S: String;
begin
  isDown := False;
  R := Rect(0, 0, Width, Height);
  SRect := SkinRect;
  if IsNullRect(ActiveSkinRect) then ARect := SRect else ARect := ActiveSkinRect;
  if IsNullRect(DownSkinRect) then DRect := ARect else DRect := DownSkinRect;

  if FTrackButtonMode
  then
    begin
      B1 := TBitMap.Create;
      B1.Width := Width - 15;
      B1.Height := Height;
      B2 := TBitMap.Create;
      B2.Width := 15;
      B2.Height := Height;
      if FMenuTracked
      then
        begin
          CreateStretchImage(B1, Picture, ARect, ClRect, True);
          CreateStretchImage(B2, Picture, DRect, ClRect, True);
        end
      else
        begin
          if ADown and AMouseIn
          then
            begin
              CreateStretchImage(B1, Picture, DRect, ClRect, True);
              CreateStretchImage(B2, Picture, DRect, ClRect, True);
              isDown := True;
            end
          else
          if AMouseIn
          then
            begin
              CreateStretchImage(B1, Picture, ARect, ClRect, True);
              CreateStretchImage(B2, Picture, ARect, ClRect, True);
            end
          else
            begin
              CreateStretchImage(B1, Picture, SRect, ClRect, True);
              CreateStretchImage(B2, Picture, SRect, ClRect, True);
            end;
        end;
      B.Canvas.Draw(0, 0, B1);
      B.Canvas.Draw(Width - 15, 0, B2);
      B1.Free;
      B2.Free;
    end
  else
    begin
      if ADown and AMouseIn
      then
        begin
          CreateStretchImage(B, Picture, DRect, ClRect, True);
          IsDown := True;
        end
      else
        if AMouseIn
        then
          begin
            CreateStretchImage(B, Picture, ARect, ClRect, True);
          end
        else
          begin
            CreateStretchImage(B, Picture, SRect, ClRect, True);
          end;
    end;

  R := ClientRect;
  Dec(R.Right, 15);

  if not FUseSkinFont
  then
    B.Canvas.Font.Assign(FDefaultFont)
  else
    with B.Canvas.Font do
    begin
      Name := FontName;
      Height := FontHeight;
      Style := FontStyle;
    end;

  with B.Canvas.Font do
  begin

    if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
    then
      Charset := SkinData.ResourceStrData.CharSet
    else
      CharSet := FDefaultFont.Charset;

    if Enabled and not FUseSkinFontColor
    then
      begin
        Color := FDefaultFont.Color;
      end
    else  
    if not Enabled
    then
      Color := DisabledFontColor
    else
    if IsDown
    then
      Color := DownFontColor
    else
      if AMouseIn
      then Color := ActiveFontColor
      else Color := FontColor;
  end;

  if ShowFocus and Focused
  then
    begin
      B.Canvas.Brush.Style := bsSolid;
      B.Canvas.Brush.Color := FSD.SkinColors.cBtnFace;
      B.Canvas.DrawFocusRect(NewClRect);
      B.Canvas.Brush.Style := bsClear;
    end;


  
  if (FSkinImagesMenu <> nil) and (FSkinImagesMenu.SelectedItem <> nil) and
      FUseImagesMenuImage
  then
    begin
      if FUseImagesMenuCaption
      then
        S := FSkinImagesMenu.SelectedItem.Caption
      else
        S := Caption;
      DrawImageAndText(B.Canvas, R, FMargin, FSpacing, FLayout,
        S, FSkinImagesMenu.SelectedItem.ImageIndex, FSkinImagesMenu.Images,
        isDown, Enabled, False, 0);
    end
  else
  if (FImageList <> nil) and (FImageIndex >= 0) and
     (FImageIndex < FImageList.Count)
  then
    begin
      DrawImageAndText(B.Canvas, R, FMargin, FSpacing, FLayout,
        Caption, FImageIndex, FImageList,
        isDown, Enabled, False, 0);
    end
  else
    DrawGlyphAndText(B.Canvas, R, FMargin, FSpacing, FLayout,
                     Caption, FGlyph, FNumGlyphs, GetGlyphNum(ADown, AMouseIn),  isDown, False, 0);

  R.Left := Width - 15;
  Inc(R.Right, 15);
  if (ADown and AMouseIn) or FMenuTracked
  then
    begin
      Inc(R.Top, 2);
      Inc(R.Left, 2);
    end;

  if not IsNullRect(MenuMarkerRect)
  then
    begin
      DrawMenuMarker(B.Canvas, R, AMouseIn, (ADown and AMouseIn) or FMenuTracked);
    end
  else
  if FMenuTracked
  then
    DrawTrackArrowImage(B.Canvas, R, DownFontColor)
  else
    DrawTrackArrowImage(B.Canvas, R, B.Canvas.Font.Color);
end;

procedure TbsSkinMenuButton.CreateControlSkinResizeImage;
var
  R, R1: TRect;
  isDown: Boolean;
  E: Boolean;
  B1, B2: TBitMap;
  SRect, ARect, DRect: TRect;
  NewLtPoint1, NewRTPoint1, NewLBPoint1, NewRBPoint1: TPoint;
  NewClRect1: TRect;
  NewLtPoint2, NewRTPoint2, NewLBPoint2, NewRBPoint2: TPoint;
  NewClRect2: TRect;
  XO, YO: Integer;
  S: String;
begin
  isDown := False;
  R := Rect(0, 0, Width, Height);
  SRect := SkinRect;
  if IsNullRect(ActiveSkinRect) then ARect := SRect else ARect := ActiveSkinRect;
  if IsNullRect(DownSkinRect) then DRect := ARect else DRect := DownSkinRect;

  if FTrackButtonMode
  then
    begin
      XO := (Width - 15) - RectWidth(SRect);
      YO := Height - RectHeight(SRect);

      NewLTPoint1 := LTPt;
      NewRTPoint1 := Point(RTPt.X + XO, RTPt.Y);
      NewLBPoint1 := Point(LBPt.X, LBPt.Y + YO);
      NewRBPoint1 := Point(RBPt.X + XO, RBPt.Y + YO);
      NewClRect1 := Rect(CLRect.Left, ClRect.Top,
       CLRect.Right + XO, ClRect.Bottom + YO);

      XO := 15 - RectWidth(SRect);
      YO := Height - RectHeight(SRect);

      NewLTPoint2 := LTPt;
      NewRTPoint2 := Point(RTPt.X + XO, RTPt.Y);
      NewLBPoint2 := Point(LBPt.X, LBPt.Y + YO);
      NewRBPoint2 := Point(RBPt.X + XO, RBPt.Y + YO);
      NewClRect2 := Rect(CLRect.Left, ClRect.Top,
      CLRect.Right + XO, ClRect.Bottom + YO);
    end;  

  if FTrackButtonMode
  then
    begin
      R := Rect(0, 0, Width - 15, Height);
      R1 := Rect(Width - 15, 0, Width, Height);
      B1 := TBitMap.Create;
      B2 := TBitMap.Create;
      if FMenuTracked
      then
        begin
          CreateSkinImage(LTPt, RTPt, LBPt, RBPt, CLRect,
          NewLtPoint1, NewRTPoint1, NewLBPoint1, NewRBPoint1, NewCLRect1,
            B1, Picture, ARect, Self.Width - 15, Height, True,
            LeftStretch, TopStretch, RightStretch, BottomStretch,
            StretchEffect);
            B.Canvas.Draw(0, 0, B1);
          CreateSkinImage(LTPt, RTPt, LBPt, RBPt, CLRect,
          NewLtPoint2, NewRTPoint2, NewLBPoint2, NewRBPoint2, NewCLRect2,
            B2, Picture, DRect, 15, Height, True,
            LeftStretch, TopStretch, RightStretch, BottomStretch,
            StretchEffect);
          B.Canvas.Draw(Self.Width - 15, 0, B2);
        end
      else
        begin
          if ADown and AMouseIn
          then
            begin
              CreateSkinImage(LTPt, RTPt, LBPt, RBPt, CLRect,
                NewLtPoint1, NewRTPoint1, NewLBPoint1, NewRBPoint1, NewCLRect1,
                B1, Picture, DRect, Self.Width - 15, Height, True,
                LeftStretch, TopStretch, RightStretch, BottomStretch,
                StretchEffect);
                B.Canvas.Draw(0, 0, B1);
              CreateSkinImage(LTPt, RTPt, LBPt, RBPt, CLRect,
                NewLtPoint2, NewRTPoint2, NewLBPoint2, NewRBPoint2, NewCLRect2,
                B2, Picture, DRect, 15, Height, True,
                LeftStretch, TopStretch, RightStretch, BottomStretch,
                StretchEffect);
                B.Canvas.Draw(Self.Width - 15, 0, B2);
              isDown := True;
            end
          else
          if AMouseIn
          then
            begin
              CreateSkinImage(LTPt, RTPt, LBPt, RBPt, CLRect,
                NewLtPoint1, NewRTPoint1, NewLBPoint1, NewRBPoint1, NewCLRect1,
                B1, Picture, ARect, Self.Width - 15, Height, True,
                LeftStretch, TopStretch, RightStretch, BottomStretch,
                StretchEffect);
                B.Canvas.Draw(0, 0, B1);
              CreateSkinImage(LTPt, RTPt, LBPt, RBPt, CLRect,
                NewLtPoint2, NewRTPoint2, NewLBPoint2, NewRBPoint2, NewCLRect2,
                B2, Picture, ARect, 15, Height, True,
                LeftStretch, TopStretch, RightStretch, BottomStretch,
                StretchEffect);
                B.Canvas.Draw(Self.Width - 15, 0, B2);
            end
          else
            begin
              CreateSkinImage(LTPt, RTPt, LBPt, RBPt, CLRect,
               NewLtPoint1, NewRTPoint1, NewLBPoint1, NewRBPoint1, NewCLRect1,
               B1, Picture, SRect, Self.Width - 15, Height, True,
               LeftStretch, TopStretch, RightStretch, BottomStretch,
               StretchEffect);
              B.Canvas.Draw(0, 0, B1);
              CreateSkinImage(LTPt, RTPt, LBPt, RBPt, CLRect,
                NewLtPoint2, NewRTPoint2, NewLBPoint2, NewRBPoint2, NewCLRect2,
                B2, Picture, SRect, 15, Height, True,
                LeftStretch, TopStretch, RightStretch, BottomStretch,
                StretchEffect);
                B.Canvas.Draw(Self.Width - 15, 0, B2);
              end;
        end;
      B1.Free;
      B2.Free;
    end
  else
    begin
      if ADown and AMouseIn
      then
        begin
          CreateSkinImage(LTPt, RTPt, LBPt, RBPt, CLRect,
          NewLtPoint, NewRTPoint, NewLBPoint, NewRBPoint, NewCLRect,
            B, Picture, DRect, Width, Height, True,
            LeftStretch, TopStretch, RightStretch, BottomStretch,
            StretchEffect);
          IsDown := True;
        end
      else
        if AMouseIn
        then
          begin
            CreateSkinImage(LTPt, RTPt, LBPt, RBPt, CLRect,
              NewLtPoint, NewRTPoint, NewLBPoint, NewRBPoint, NewCLRect,
            B, Picture, ARect, Width, Height, True,
            LeftStretch, TopStretch, RightStretch, BottomStretch,
            StretchEffect);
          end
       else
         begin
            CreateSkinImage(LTPt, RTPt, LBPt, RBPt, CLRect,
            NewLtPoint, NewRTPoint, NewLBPoint, NewRBPoint, NewCLRect,
              B, Picture, SRect, Width, Height, True,
            LeftStretch, TopStretch, RightStretch, BottomStretch,
            StretchEffect);
         end;
    end;
  R := ClientRect;
  Dec(R.Right, 15);

  if not FUseSkinFont
  then
    B.Canvas.Font.Assign(FDefaultFont)
  else
    with B.Canvas.Font do
    begin
      Name := FontName;
      Height := FontHeight;
      Style := FontStyle;
    end;

  with B.Canvas.Font do
  begin

    if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
    then
      Charset := SkinData.ResourceStrData.CharSet
    else
      CharSet := FDefaultFont.Charset;

    if Enabled and not FUseSkinFontColor
    then
      begin
        Color := FDefaultFont.Color;
      end
    else  
    if not Enabled
    then
      Color := DisabledFontColor
    else
    if IsDown
    then
      Color := DownFontColor
    else
      if AMouseIn
      then Color := ActiveFontColor
      else Color := FontColor;
  end;

  if ShowFocus and Focused
  then
    begin
      B.Canvas.Brush.Style := bsSolid;
      B.Canvas.Brush.Color := FSD.SkinColors.cBtnFace;
      B.Canvas.DrawFocusRect(NewClRect);
      B.Canvas.Brush.Style := bsClear;
    end;


  if (FSkinImagesMenu <> nil) and (FSkinImagesMenu.SelectedItem <> nil) and
      FUseImagesMenuImage
  then
    begin
      if FUseImagesMenuCaption
      then
        S := FSkinImagesMenu.SelectedItem.Caption
      else
        S := Caption;
      DrawImageAndText(B.Canvas, R, FMargin, FSpacing, FLayout,
        S, FSkinImagesMenu.SelectedItem.ImageIndex, FSkinImagesMenu.Images,
        isDown, Enabled, False, 0);
    end
  else
  if (FImageList <> nil) and (FImageIndex >= 0) and
     (FImageIndex < FImageList.Count)
  then
    begin
      DrawImageAndText(B.Canvas, R, FMargin, FSpacing, FLayout,
        Caption, FImageIndex, FImageList,
        isDown, Enabled, False, 0);
    end
  else
   DrawGlyphAndText(B.Canvas, R, FMargin, FSpacing, FLayout,
                    Caption, FGlyph, FNumGlyphs, GetGlyphNum(ADown, AMouseIn),  isDown, False, 0);


  R.Left := Width - 15;
  Inc(R.Right, 15);
  if (ADown and AMouseIn) or FMenuTracked
  then
    begin
      Inc(R.Top, 2);
      Inc(R.Left, 2);
    end;

  if not IsNullRect(MenuMarkerRect)
  then
    begin
      DrawMenuMarker(B.Canvas, R, AMouseIn, (ADown and AMouseIn) or FMenuTracked);
    end
  else
  if FMenuTracked
  then
    DrawTrackArrowImage(B.Canvas, R, DownFontColor)
  else
    DrawTrackArrowImage(B.Canvas, R, B.Canvas.Font.Color);


end;

procedure TbsSkinMenuButton.CreateButtonImage;
begin
  if (SkinDataName = 'resizebutton') or (SkinDataName = 'resizetoolbutton')
  then
    begin
      CreateControlSkinResizeImage(B, ADown, AMouseIn)
    end
  else
  if (SkinDataName = 'toolbutton') or (SkinDataName = 'bigtoolbutton')
  then
    begin
      CreateControlSkinResizeImage2(B, ADown, AMouseIn);
    end
  else
  if FMenuTracked and FTrackButtonMode and
     not IsNullRect(TrackButtonRect) and not IsNullRect(DownSkinRect)
  then
    begin
      inherited CreateButtonImage(B, ActiveSkinRect, False, True);
      R := TrackButtonRect;
      OffsetRect(R, DownSkinRect.Left, DownSkinRect.Top);
        B.Canvas.CopyRect(GetNewTrackButtonRect, Picture.Canvas,
       R);
    end
  else
    inherited;
end;

procedure TbsSkinMenuButton.CreateControlDefaultImage;
var
  R, R1: TRect;
  isDown: Boolean;
  S: String;
begin
  IsDown := False;
  if FTrackButtonMode
  then
    begin
      R := Rect(0, 0, Width - 15, Height);
      R1 := Rect(Width - 15, 0, Width, Height);
      if FMenuTracked
      then
        begin
          Frame3D(B.Canvas, R, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
          B.Canvas.Brush.Color := BS_XP_BTNACTIVECOLOR;
          B.Canvas.FillRect(R);
          Frame3D(B.Canvas, R1, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
          B.Canvas.Brush.Color := BS_XP_BTNDOWNCOLOR;
          B.Canvas.FillRect(R1);
        end
      else
        begin
          if FDown and FMouseIn
          then
            begin
              Frame3D(B.Canvas, R, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
              B.Canvas.Brush.Color := BS_XP_BTNDOWNCOLOR;
              B.Canvas.FillRect(R);
              Frame3D(B.Canvas, R1, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
              B.Canvas.Brush.Color := BS_XP_BTNDOWNCOLOR;
              B.Canvas.FillRect(R1);
              isDown := True;
            end
          else
          if FMouseIn or IsFocused
          then
            begin
              Frame3D(B.Canvas, R, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
              B.Canvas.Brush.Color := BS_XP_BTNACTIVECOLOR;
              B.Canvas.FillRect(R);
              Frame3D(B.Canvas, R1, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
              B.Canvas.Brush.Color := BS_XP_BTNACTIVECOLOR;
              B.Canvas.FillRect(R1);
            end
          else
            begin
              Frame3D(B.Canvas, R, clBtnShadow, clBtnShadow, 1);
              B.Canvas.Brush.Color := clBtnFace;
              B.Canvas.FillRect(R);
              Frame3D(B.Canvas, R1, clBtnShadow, clBtnShadow, 1);
              B.Canvas.Brush.Color := clBtnFace;
              B.Canvas.FillRect(R1);
            end;
        end;
    end
  else
    begin
      R := Rect(0, 0, Width, Height);
      if FDown and FMouseIn
      then
        begin
          Frame3D(B.Canvas, R, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
          B.Canvas.Brush.Color := BS_XP_BTNDOWNCOLOR;
          B.Canvas.FillRect(R);
        end
      else
        if FMouseIn or IsFocused
        then
          begin
            Frame3D(B.Canvas, R, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
            B.Canvas.Brush.Color := BS_XP_BTNACTIVECOLOR;
            B.Canvas.FillRect(R);
          end
       else
         begin
           Frame3D(B.Canvas, R, clBtnShadow, clBtnShadow, 1);
           B.Canvas.Brush.Color := clBtnFace;
           B.Canvas.FillRect(R);
         end;
    end;
  R := ClientRect;
  Dec(R.Right, 15);
  B.Canvas.Font.Assign(FDefaultFont);
  if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
  then
    B.Canvas.Font.Charset := SkinData.ResourceStrData.CharSet;

  if (FSkinImagesMenu <> nil) and (FSkinImagesMenu.SelectedItem <> nil) and
      FUseImagesMenuImage
  then
    begin
      if FUseImagesMenuCaption
      then
        S := FSkinImagesMenu.SelectedItem.Caption
      else
        S := Caption;
      DrawImageAndText(B.Canvas, R, FMargin, FSpacing, FLayout,
        S, FSkinImagesMenu.SelectedItem.ImageIndex, FSkinImagesMenu.Images,
        isDown, Enabled, False, 0);
    end
  else
  if (FImageList <> nil) and (FImageIndex >= 0) and
     (FImageIndex < FImageList.Count)
  then
    begin
      DrawImageAndText(B.Canvas, R, FMargin, FSpacing, FLayout,
        Caption, FImageIndex, FImageList,
        isDown, Enabled, False, 0);
    end
  else
   DrawGlyphAndText(B.Canvas, R, FMargin, FSpacing, FLayout,
                  Caption, FGlyph, FNumGlyphs, GetGlyphNum(FDown, FMouseIn),  isDown, False, 0);
  R.Left := Width - 15;
  Inc(R.Right, 15);
  if (FDown and FMouseIn) or FMenuTracked
  then
    begin
      Inc(R.Top, 2);
      Inc(R.Left, 2);
    end;
  DrawTrackArrowImage(B.Canvas, R, clBtnText);
end;

procedure TbsSkinMenuButton.CMDialogChar;
begin
  if not FTrackButtonMode and CanMenuTrack(0, 0)
  then
    begin
      with Message do
      if IsAccel(CharCode, Caption) and CanFocus and FCanFocused
      then
        begin
          SetFocus;
          FMenuTracked := True;
          Down := True;
          TrackMenu;
          Result := 1;
        end
      else
        inherited;
    end
  else
    inherited;  
end;

procedure TbsSkinMenuButton.WndProc;
var
  FOld: Boolean;
begin
  FOld := True;
  if FCanFocused and (FSkinPopupMenu <> nil) then
  case Message.Msg of
    WM_KEYDOWN:
      if (TWMKEYDOWN(Message).CharCode = VK_SPACE)
      then
        begin
          if not FTrackButtonMode and CanMenuTrack(0, 0)
          then
            begin
              FMenuTracked := True;
              Down := True;
              TrackMenu;
              FOld := False;
            end;
        end;
    WM_KEYUP:
      if (TWMKEYUP(Message).CharCode = VK_SPACE) and not FMenuTracked
      then
        begin
          Down := False;
          if Assigned(FOnClick) then FOnClick(Self);
          FOld := False;
        end
      else
      if (TWMKEYUP(Message).CharCode = VK_RETURN) and not FMenuTracked
      then
        begin
          if Assigned(FOnClick) then FOnClick(Self);
        end
   end;
  if FOld then inherited;
end;

function TbsSkinMenuButton.GetNewTrackButtonRect;
var
  RM, Off: Integer;
  R: TRect;
begin
  RM := GetResizeMode;
  R := TrackButtonRect;
  case RM of
    2:
      begin
        Off := Width - RectWidth(SkinRect);
        OffsetRect(R, Off, 0);
      end;
    3:
      begin
        Off := Height - RectHeight(SkinRect);
        OffsetRect(R, 0, Off);
      end;
  end;
  Result := R;
end;

function TbsSkinMenuButton.CanMenuTrack;
var
  R: TRect;
begin
  if (FSkinPopupMenu = nil) and (FSkinImagesMenu = nil)
  then
    begin
     Result := False;
     Exit;
   end;
   if not FTrackButtonMode
   then
     Result := True
   else
     begin
       if (FIndex <> -1) and (SkinDataName <> 'resizebutton') and
       (SkinDataName <> 'resizetoolbutton') and (SkinDataName <> 'toolbutton')
       and (SkinDataName <> 'bigtoolbutton')
       then R := GetNewTrackButtonRect
       else R := Rect(Width - 15, 0, Width, Height);
       Result := PointInRect(R, Point(X, Y));
     end;
end;

procedure TbsSkinMenuButton.WMCLOSESKINMENU;
begin
  FMenuTracked := False;
  Down := False;
  if Assigned(FOnHideTrackMenu) then FOnHideTrackMenu(Self);
end;

procedure TbsSkinMenuButton.OnImagesMenuClose;
begin
  FMenuTracked := False;
  Down := False;
  FMouseIn := False;
  ReDrawControl;
  if Assigned(FOnHideTrackMenu) then FOnHideTrackMenu(Self);
end;

procedure TbsSkinMenuButton.TrackMenu;
var
  R: TRect;
  P: TPoint;
begin
  if FSkinPopupMenu <> nil
  then
    begin
      P := ClientToScreen(Point(0, 0));
      R := Rect(P.X, P.Y, P.X + Width, P.Y + Height);
      FSkinPopupMenu.PopupFromRect2(Self, R, False);
      if Assigned(FOnShowTrackMenu) then FOnShowTrackMenu(Self);
    end;
  if FSkinImagesMenu <> nil
  then
    begin
      P := ClientToScreen(Point(0, 0));
      R := Rect(P.X, P.Y, P.X + Width, P.Y + Height);
      FSkinImagesMenu.OnInternalMenuClose := OnImagesMenuClose;
      FSkinImagesMenu.PopupFromRect(R);
      if Assigned(FOnShowTrackMenu) then FOnShowTrackMenu(Self);
    end;
end;

procedure TbsSkinMenuButton.Notification;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FSkinPopupMenu)
  then FSkinPopupMenu := nil;
end;

procedure TbsSkinMenuButton.CMMouseEnter(var Message: TMessage);
begin
  if (csDesigning in ComponentState) then Exit;
  if not FMenuTracked then inherited else FMouseIn := True;
end;

procedure TbsSkinMenuButton.CMMouseLeave(var Message: TMessage);
begin
  if (csDesigning in ComponentState) then Exit;
  if not FMenuTracked then inherited else FMouseIn := False;
end;

procedure TbsSkinMenuButton.GetSkinData;
begin
  inherited;
  if FIndex <> -1
  then
    if TbsDataSkinControl(FSD.CtrlList.Items[FIndex]) is TbsDataSkinMenuButtonControl
    then
      with TbsDataSkinMenuButtonControl(FSD.CtrlList.Items[FIndex]) do
      begin
        Self.TrackButtonRect := TrackButtonRect;
      end;
end;

procedure TbsSkinMenuButton.SetTrackButtonMode;
begin
  FTrackButtonMode := Value;
  if FIndex = - 1 then RePaint;
end;

procedure TbsSkinMenuButton.MouseDown;
begin
  if Button <> mbLeft
  then
    begin
      inherited;
      Exit;
    end;
  FMenuTracked := CanMenuTrack(X, Y);
  FMouseIn := True;
  if (FIndex <> -1) and not IsNullRect(AnimateSkinRect) then StopAnimate;
  if FMenuTracked
  then
    begin
      if not FDown then Down := True;
      TrackMenu;
    end
  else
    inherited;
end;

procedure TbsSkinMenuButton.MouseUp;
begin
  if not FMenuTracked then inherited;
end;

//=========== TbsSkinPanel ================

constructor TbsSkinPanel.Create;
begin
  inherited Create(AOwner);
  ControlStyle := [csAcceptsControls, csCaptureMouse, csClickEvents,
    csSetCaption, csOpaque, csDoubleClicks, csReplicatable];
  FForceBackGround := True;
  Width := 150;
  Height := 150;
  NewClRect := NullRect;
  FRollUpMode := False;
  FCaptionMode := False;
  FRealHeight := -1;
  FSkinDataName := 'panel';
  BGPictureIndex := -1;
  FDefaultCaptionHeight := 22;
  FNumGlyphs := 1;
  FGlyph := TBitMap.Create;
  FSpacing := 2;
  FAutoEnabledControls := True;
  FCMaxWidth := 0;
  FCMinWidth := 0;
  FCMaxHeight := 0;
  FCMinHeight := 0;
  FCaptionImageList := nil;
  FCaptionImageIndex := -1;
end;

destructor TbsSkinPanel.Destroy;
begin
  FGlyph.Free;
  inherited;
end;

procedure TbsSkinPanel.Notification;
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FCaptionImageList)
  then FCaptionImageList := nil;
end;

procedure TbsSkinPanel.SetCaptionImageIndex(Value: Integer);
begin
  if FCaptionImageIndex <> Value
  then
    begin
      FCaptionImageIndex := Value;
      RePaint;
    end;
end;

procedure TbsSkinPanel.PaintskinTo(C: TCanvas; X, Y: Integer);
var
  B: TBitMap;
begin
  B := TBitmap.Create;
  B.Width := Width;
  B.Height := Height;
  GetSkinData;
  if Findex = -1
  then
    begin
      CreateControlDefaultImage(B);
    end
  else
    begin
      CreateControlSkinImage(B);
    end;
  C.Draw(X, Y, B);
  B.Free;  
end;

function TbsSkinPanel.GetSkinClientRect: TRect;
begin
  Result := Rect(0, 0, Width, Height);
  AdjustClientRect(Result);
end;

procedure TbsSkinPanel.SkinDrawCheckImage(X, Y: Integer; Cnvs: TCanvas; IR: TRect; DestCnvs: TCanvas);
var
  B: TBitMap;
begin
  B := TBitMap.Create;
  B.Width := RectWidth(IR);
  B.Height := RectHeight(IR);
  B.Canvas.CopyRect(Rect(0, 0, B.Width, B.Height), Cnvs, IR);
  B.Transparent := True;
  DestCnvs.Draw(X, Y, B);
  B.Free;
end;

procedure TbsSkinPanel.SetCheckedMode;
begin
  FCheckedMode := Value;
  RePaint;
end;

procedure TbsSkinPanel.SetChecked;
var
  i: Integer;
begin
  FChecked := Value;
  if FCheckedMode then RePaint;
  if FAutoEnabledControls and FCheckedMode
  then
    begin
      for i := 0 to ControlCount -1 do
        Controls[i].Enabled := FChecked;
    end;
  if Assigned(FOnChecked) then FOnChecked(Self);
end;

procedure TbsSkinPanel.ShowControls;
var
  i: Integer;
begin
  for i := 0 to ControlCount - 1 do
    Controls[i].Visible := True;
  EnableAlign;
end;

procedure TbsSkinPanel.HideControls;
var
  i: Integer;
begin
  DisableAlign;
  for i := 0 to ControlCount - 1 do
    Controls[i].Visible := False;
end;

procedure TbsSkinPanel.CMEnabledChanged;
begin
  inherited;
  RePaint;
end;

procedure TbsSkinPanel.SetNumGlyphs;
begin
  FNumGlyphs := Value;
  RePaint;
end;

procedure TbsSkinPanel.SetGlyph;
begin
  FGlyph.Assign(Value);
  RePaint;
end;

procedure TbsSkinPanel.SetSpacing;
begin
  FSpacing := Value;
  RePaint;
end;

procedure TbsSkinPanel.SetDefaultAlignment(Value: TAlignment);
begin
  FDefaultAlignment := Value;
  if (FIndex = -1) and FCaptionMode then RePaint;
end;

procedure TbsSkinPanel.SetDefaultCaptionHeight;
begin
  FDefaultCaptionHeight := Value;
  if (FIndex = -1) and FCaptionMode
  then
    begin
      RePaint;
      ReAlign;
    end
end;

procedure TbsSkinPanel.SetBorderStyle;
begin
  FBorderStyle := Value;
  if FIndex = -1
  then
    begin
      RePaint;
      ReAlign;
    end;
end;

procedure TbsSkinPanel.SetRollUpMode(Value: Boolean);
begin
  FRollUpMode := Value;
  if (FIndex = -1) and CaptionMode then RePaint;
end;


procedure TbsSkinPanel.CreateControlDefaultImage;

function GetGlyphTextWidth: Integer;
begin
  Result := B.Canvas.TextWidth(Caption);
  if not FGlyph.Empty then Result := Result + FGlyph.Width div FNumGlyphs + FSpacing;
end;

var
  R, CR: TRect;
  TX, TY, CS: Integer;
  GX, GY: Integer;
  GlyphNum: Integer;
begin
  inherited;
  R := Rect(0, 0, Width, Height);
  case FBorderStyle of
    bvLowered:
      Frame3D(B.Canvas, R, clBtnShadow, clBtnHighLight, 1);
    bvRaised:
      Frame3D(B.Canvas, R, clBtnHighLight, clBtnShadow, 1);
    bvFrame:
      Frame3D(B.Canvas, R, clBtnShadow, clBtnShadow, 1);
  end;
  if FCaptionMode
  then
    begin
      if FBorderStyle = bvFrame
      then
        begin
          R := Rect(0, 0, Width, FDefaultCaptionHeight);
          Frame3D(B.Canvas, R, clBtnShadow, clBtnShadow, 1);
          Frame3D(B.Canvas, R, clBtnHighLight, clBtnFace, 1);
        end
      else
        begin
          R := Rect(1, 1, Width - 1, FDefaultCaptionHeight);
          Frame3D(B.Canvas, R, clBtnShadow, clBtnHighLight, 1);
          Frame3D(B.Canvas, R, clBtnHighLight, clBtnShadow, 1);
        end;

      if FCheckedMode
      then
        Inc(R.Left, 20);

      if RollUpMode
      then
        Dec(R.Right, 10);

      with B.Canvas do
      begin
        Font.Assign(FDefaultFont);
        if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
        then
          Font.Charset := SkinData.ResourceStrData.CharSet;
        TY := R.Top + RectHeight(R) div 2 - TextHeight(Caption) div 2;
        TX := R.Left + 2;
        case FDefaultAlignment of
          taCenter: TX := TX + RectWidth(R) div 2 - GetGlyphTextWidth div 2;
          taRightJustify: TX := R.Right - GetGlyphTextWidth;
        end;
        if FCheckedMode
        then
          begin
            CS := 14;
            CR.Left := 5;
            CR.Top := R.Top + RectHeight(R) div 2 - CS div 2;
            CR.Right := CR.Left + CS;
            CR.Bottom := CR.Top + CS;
            Frame3D(B.Canvas, CR, clBtnShadow, clBtnShadow, 1);
            if FChecked then DrawCheckImage(B.Canvas, CR.Left + 3, CR.Top + 2,
            clBtnText);
          end;

        if FGlyph.Empty and (FCaptionImageList <> nil) and (FCaptionImageIndex >= 0) and
          (FCaptionImageIndex < FCaptionImageList.Count)
        then
          begin
           GY := R.Top + RectHeight(R) div 2 - FCaptionImageList.Height div 2;
           GX := TX;
           TX := GX + FCaptionImageList.Width + FSpacing;
          end
       else
        if not FGlyph.Empty
        then
          begin
            GY := R.Top + RectHeight(R) div 2 - FGlyph.Height div 2;
            GX := TX;
            TX := GX + FGlyph.Width div FNumGlyphs + FSpacing;
            GlyphNum := 1;
            if not Enabled and (NumGlyphs = 2) then GlyphNum := 2;
          end;

        Brush.Style := bsClear;
        TextRect(R, TX, TY, Caption);
        if FGlyph.Empty and (FCaptionImageList <> nil) and (FCaptionImageIndex >= 0) and
          (FCaptionImageIndex < FCaptionImageList.Count)
        then
         begin
          FCaptionImageList.Draw(B.Canvas, GX, GY, FCaptionImageIndex, Enabled);
         end
        else
        if not FGlyph.Empty
        then DrawGlyph(B.Canvas, GX, GY, FGlyph, NumGlyphs, GlyphNum);
      end;
      if FRollUpMode
      then
        begin
          R.Left := R.Right;
          R.Right := R.Left + 10;
          if FRollUpState
          then DrawArrowImage(B.Canvas, R, clBtnText, 4)
          else DrawArrowImage(B.Canvas, R, clBtnText, 3);
        end;
  end;
end;

procedure TbsSkinPanel.MouseUp;
begin
  if (FRollUpMode or FCheckedMode) and FCaptionMode and (Button = mbLeft)
  then
    begin
      if ((FIndex <> -1) and (PointInRect(NewCaptionRect, Point(X, Y)) or
                              PointInRect(NewRollUpMarkerRect, Point(X, Y))))
         or
         ((FIndex = -1) and PointInRect(Rect(1, 1, Width - 1, FDefaultCaptionHeight),
           Point(X, Y)))
      then
        begin
          if CheckedMode
          then
            Checked := not Checked;

          if RollUpMode
          then
            RollUpState := not FRollUpState;
        end;
    end;
  inherited;
end;

procedure TbsSkinPanel.DoRollUp(ARollUp: Boolean);
begin
  if FIndex <> -1
  then
    begin
      if ARollUp and (FRealHeight = -1)
      then
        begin
          FRealHeight := Height;
          HideControls;
          Height := NewClRect.Top + (Height - NewClRect.Bottom);
        end
      else
        if not ARollUp and (FRealHeight <> -1)
        then
          begin
            Height := FRealHeight;
            FRealHeight := -1;
            ShowControls;
          end;
    end
  else
    begin
      if ARollUp and (FRealHeight = -1)
      then
        begin
          FRealHeight := Height;
          HideControls;
          Height := FDEfaultCaptionHeight + 1;
        end
      else
        if not ARollUp and (FRealHeight <> -1)
        then
          begin
            Height := FRealHeight;
            FRealHeight := -1;
            ShowControls;
          end;
    end;
end;

procedure TbsSkinPanel.SetRollUpState;
begin
  if FRollUpState = Value then Exit;
  if FRollUpMode
  then
    begin
      //
      FCMaxWidth := Constraints.MaxWidth;
      FCMinWidth := Constraints.MinWidth;
      FCMaxHeight := Constraints.MaxHeight;
      FCMinHeight := Constraints.MinHeight;
      Constraints.MaxWidth := 0;
      Constraints.MaxHeight := 0;
      Constraints.MinHeight := 0;
      Constraints.MinWidth := 0;
      //
      FRollUpState := Value;
      DoRollUp(FRollUpState);
      if Assigned (FOnChangeRollUpState) then FOnChangeRollUpState(Self);
    end
  else
    begin
      //
      Constraints.MaxWidth := FCMaxWidth;
      Constraints.MinWidth := FCMinWidth;
      Constraints.MaxHeight := FCMaxHeight;
      Constraints.MinHeight := FCMinHeight;
      //
      FRollUpState := False;
    end;  
end;

procedure TbsSkinPanel.SetCaptionMode;
begin
  FCaptionMode := Value;
  RePaint;
  ReAlign;
end;

procedure TbsSkinPanel.SetBounds;
begin
  inherited;
  if FIndex = -1 then RePaint;
end;

procedure TbsSkinPanel.GetSkinData;
begin
  inherited;
  BGPictureIndex := -1;
  if FIndex <> -1
  then
    if TbsDataSkinControl(FSD.CtrlList.Items[FIndex]) is TbsDataSkinPanelControl
    then
      with TbsDataSkinPanelControl(FSD.CtrlList.Items[FIndex]) do
      begin
        Self.CaptionRect := CaptionRect;
        Self.Alignment := Alignment;
        Self.FontName := FontName;
        Self.FontColor := FontColor;
        Self.FontStyle := FontStyle;
        Self.FontHeight := FontHeight;
        Self.BGPictureIndex := BGPictureIndex;
        Self.CheckImageRect := CheckImageRect;
        Self.UnCheckImageRect := UnCheckImageRect;
        Self.MarkFrameRect := MarkFrameRect;
        Self.FrameRect := FrameRect;
        Self.FrameTextRect := FrameTextRect;
        Self.FrameLeftOffset := FrameLeftOffset;
        Self.FrameRightOffset := FrameRightOffset;
      end;
end;

procedure TbsSkinPanel.AdjustClientRect(var Rect: TRect);
begin
  inherited AdjustClientRect(Rect);
  if (FIndex <> -1) and not (csDesigning in ComponentState)
  then
    begin
      if (BGPictureIndex = -1) and not ((BorderStyle = bvNone) and not CaptionMode and
         (ResizeMode = 1))
      then Rect := NewClRect;
    end
  else
    begin
      if FBorderStyle <> bvNone then InflateRect(Rect, -1, -1);
      if FCaptionMode then Rect.Top := Rect.Top + FDefaultCaptionHeight;
    end;
end;

procedure TbsSkinPanel.CreateControlSkinImage;

function GetGlyphTextWidth: Integer;
begin
  Result := B.Canvas.TextWidth(Caption);
  if not FGlyph.Empty then Result := Result + FGlyph.Width div FNumGlyphs + FSpacing;
end;

procedure DrawCaption;
var
  TX, TY, GX, GY, CW, CH: Integer;
  GlyphNum: Integer;
  MR, CR, CapRect, R: TRect;
  Buffer: TBitMap;
  Offset: Integer;
  W, FX: Integer;
begin
  CapRect := NewCaptionRect;
  if FRollUpMode then Dec(CapRect.Right, 12);

  if FCheckedMode
  then
    begin
      CW := RectWidth(CheckImageRect);
      CH := RectHeight(CheckImageRect);
      CR.Left := CapRect.Left;
      CR.Top := CapRect.Top + RectHeight(CapRect) div 2 - CH div 2;
      CR.Right := CR.Left + CW;
      CR.Bottom := CR.Top + CH;
      if FChecked
      then
        SkinDrawCheckImage(CR.Left, CR.Top, Picture.Canvas, CheckImageRect, B.Canvas)
      else
        SkinDrawCheckImage(CR.Left, CR.Top, Picture.Canvas, UnCheckImageRect, B.Canvas);
      Inc(CapRect.Left, CW + 2);
    end;

  with B.Canvas do
  begin
    if FUseSkinFont
    then
      begin
        Font.Name := FontName;
        Font.Height := FontHeight;
        Font.Style := FontStyle;
      end
    else
      Font.Assign(FDefaultFont);

   if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
   then
     Font.Charset := SkinData.ResourceStrData.CharSet
   else
     Font.CharSet := FDefaultFont.Charset;

    Font.Color := FontColor;
    TY := CapRect.Top +
      RectHeight(CapRect) div 2 - TextHeight(Caption) div 2;
    TX := CapRect.Left;
    case Alignment of
      taCenter: TX := TX +
        RectWidth(CapRect) div 2 - GetGlyphTextWidth div 2;
      taRightJustify: TX := CapRect.Right - GetGlyphTextWidth;
    end;

    Brush.Style := bsClear;

    if FGlyph.Empty and (FCaptionImageList <> nil) and (FCaptionImageIndex >= 0) and
       (FCaptionImageIndex < FCaptionImageList.Count)
    then
      begin
        GY := CapRect.Top + RectHeight(CapRect) div 2 - FCaptionImageList.Height div 2;
        GX := TX;
        TX := GX + FCaptionImageList.Width + FSpacing;
      end
    else
    if not FGlyph.Empty
    then
      begin
        GY := CapRect.Top + RectHeight(CapRect) div 2 - FGlyph.Height div 2;
        GX := TX;
        TX := GX + FGlyph.Width div FNumGlyphs + FSpacing;
        GlyphNum := 1;
        if not Enabled and (NumGlyphs = 2) then GlyphNum := 2;
       end;


     if FRollUpMode
     then
       begin
         R := CapRect;
         R.Left := R.Right;
         R.Right := R.Right + 10;
         if not IsNullRect(MarkFrameRect)
         then
           begin
             MR := Rect(R.Left, R.Top,
                        R.Left + RectWidth(MarkFrameRect),
                        CaptionRect.Top + RectHeight(MarkFrameRect));
             B.Canvas.CopyRect(MR, Picture.Canvas, MarkFrameRect);
           end;
         if FRollUpState
         then DrawArrowImage(B.Canvas, R, FontColor, 4)
         else DrawArrowImage(B.Canvas, R, FontColor, 3);
       end;

    if not IsNullRect(Self.FrameRect)
    then
      begin
        Offset := RectWidth(Self.FrameRect) - RectWidth(Self.FrameTextRect);
        W := TextWidth(Caption) + Offset;
        Buffer := TBitMap.Create;
        CreateHSkinImage(FrameLeftOffset, FrameRightOffset, Buffer,
        Picture, Self.FrameRect, W, RectHeight(Self.FrameRect), False);
        //
        case Alignment of
          taLeftJustify:
            begin
              FX := TX;
              TX := FX + Self.FrameTextRect.Left;
            end;
          taCenter:
            begin
              FX := TX - Self.FrameTextRect.Left - 2;
              GX := GX - Self.FrameTextRect.Left;
              TX := FX + Self.FrameTextRect.Left;
            end;
          taRightJustify:
            begin
              FX := TX - Offset;
              TX := FX + Self.FrameTextRect.Left;
              GX := GX - Offset;
            end;
        end;
        //
        Draw(FX, CaptionRect.Top, Buffer);
        Buffer.Free;
      end;

    TextRect(CapRect, TX, TY, Caption);
    
    if FGlyph.Empty and (FCaptionImageList <> nil) and (FCaptionImageIndex >= 0) and
       (FCaptionImageIndex < FCaptionImageList.Count)
    then
      begin
        FCaptionImageList.Draw(B.Canvas, GX, GY, FCaptionImageIndex, Enabled);
      end
    else
    if not FGlyph.Empty
    then DrawGlyph(B.Canvas, GX, GY, FGlyph, NumGlyphs, GlyphNum);
  end;
end;

var
  X, Y, XCnt, YCnt, XO, YO, w, h, w1, h1: Integer;
begin
  if (BorderStyle = bvNone) and (ResizeMode = 1) and not CaptionMode and
     not StretchEffect
  then
    with B.Canvas do
    begin
      w1 := Width;
      h1 := Height;
      w := RectWidth(ClRect);
      h := RectHeight(ClRect);
      XCnt := w1 div w;
      YCnt := h1 div h;
      for X := 0 to XCnt do
      for Y := 0 to YCnt do
      begin
        if X * w + w > w1 then XO := X * w + w - w1 else XO := 0;
        if Y * h + h > h1 then YO := Y * h + h - h1 else YO := 0;
        CopyRect(Rect(X * w, Y * h, X * w + w - XO, Y * h + h - YO),
                 Picture.Canvas,
                 Rect(SkinRect.Left + ClRect.Left, SkinRect.Top + ClRect.Top,
                 SkinRect.Left + ClRect.Right - XO,
                 SkinRect.Top + ClRect.Bottom - YO));
      end;           
    end
  else
    begin
      inherited;
      if ResizeMode > 0
      then NewCaptionRect := GetNewRect(CaptionRect)
      else NewCaptionRect := CaptionRect;
      if (Caption <> '') and not IsNullRect(CaptionRect)
      then DrawCaption;
    end;
end;


procedure TbsSkinPanel.Paint;
var
  RealPicture: TBitMap;
  X, Y, XCnt, YCnt: Integer;
  w, h, w1, h1: Integer;
begin
  GetSkinData;
  if (FIndex =-1) or ((FIndex <> -1) and not FForceBackground and StretchEffect)
  then
    inherited
  else
  if (BorderStyle = bvNone) and (ResizeMode = 1) and not CaptionMode and
      FForcebackground
  then
    begin
      w := RectWidth(ClRect);
      h := RectHeight(ClRect);
      w1 := Width;
      h1 := Height;
      XCnt := w1 div w;
      YCnt := h1 div h;
      RealPicture := TBitMap.Create;
      RealPicture.Width := w;
      RealPicture.Height := h;
      RealPicture.Canvas.CopyRect(Rect(0, 0, w, h), Picture.Canvas,
      Rect(SkinRect.Left + ClRect.Left, SkinRect.Top + ClRect.Top,
           SkinRect.Left + ClRect.Right,
           SkinRect.Top + ClRect.Bottom));
      for X := 0 to XCnt do
      for Y := 0 to YCnt do
       begin
         Canvas.Draw(X * w, Y * h, RealPicture);
       end;
      RealPicture.Free;
    end
  else
  if BGPictureIndex <> -1
  then
    begin
      RealPicture := TBitMap(FSD.FActivePictures.Items[BGPictureIndex]);
      if (Width > 0) and (Height > 0)
      then
        begin
          XCnt := Width div RealPicture.Width;
          YCnt := Height div RealPicture.Height;
          for X := 0 to XCnt do
          for Y := 0 to YCnt do
          Canvas.Draw(X * RealPicture.Width, Y * RealPicture.Height, RealPicture);
        end;
    end
  else
    inherited;
end;

procedure TbsSkinPanel.ChangeSkinData;
var
  TempOldHeight: Integer;
begin
  inherited;
  if FRollUpState
  then
    begin
      TempOldHeight := FRealHeight;
      FRealHeight := -1;
      DoRollUp(True);
      FRealHeight := TempOldHeight;
    end
  else
    ReAlign;
end;

procedure TbsSkinPanel.CMTextChanged;
begin
  if FCaptionMode then RePaint;
end;

procedure TbsSkinPanel.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    WindowClass.style := WindowClass.style and not (CS_HREDRAW or CS_VREDRAW);
  end;
end;

constructor TbsSkinPaintPanel.Create;
begin
  inherited Create(AOwner);
  FForceBackground := False;
end;

procedure TbsSkinPaintPanel.WMEraseBkgnd;
begin
  if not FromWMPaint
  then
    PaintWindow(Msg.DC);
end;

procedure TbsSkinPaintPanel.CreateControlDefaultImage(B: TBitMap);
begin
  inherited;
  if Assigned(FOnPanelPaint) then FOnPanelPaint(B.Canvas, Self.GetSkinClientRect);
end;

procedure TbsSkinPaintPanel.CreateControlSkinImage(B: TBitMap); 
begin
  inherited;
  if Assigned(FOnPanelPaint) then FOnPanelPaint(B.Canvas, Self.GetSkinClientRect);
end;

constructor TbsSkinGroupBox.Create;
begin
  inherited;
  FSkinDataName := 'groupbox';
  CaptionMode := True;
end;

constructor TbsSkinToolBar.Create;
begin
  inherited;
  FAdjustControls := True;
  ForcebackGround := False;
  FSkinDataName := 'toolpanel';
  FCanScroll := False;
  FDefaultHeight := 0;
  Height := 25;
  BorderStyle := bvNone;
  FAutoShowHideCaptions := False;
  FShowCaptions := False;
  FWidthWithCaptions := 0;
  FWidthWithoutCaptions := 0;
  // scroll
  FHotScroll := False;
  TimerMode := 0;
  ButtonData := nil;
  FScrollOffset := 0;
  FScrollTimerInterval := 50;
  Buttons[0].Visible := False;
  Buttons[1].Visible := False;
  FHSizeOffset := 0;
  SMax := 0;
  SPosition := 0;
  SOldPosition := 0;
  SPage := 0;
  //
end;

procedure TbsSkinToolBar.WMSETCURSOR(var Message: TWMSetCursor);
begin
  if (Message.HitTest = HTBUTTON1) or
     (Message.HitTest = HTBUTTON2)
  then
    begin
      Message.HitTest :=  HTCLIENT;
    end;
  inherited;
end;

procedure TbsSkinToolBar.AdjustAllControls;
var
  i: Integer;
  R: TRect;
begin
  R := Self.GetSkinClientRect;
  for i := 0 to Self.ControlCount - 1 do
  begin
    if not (Controls[I] is TbsSkinControl) and
       not (Controls[I] is TbsGraphicSkinControl)
       and (Controls[I].Align = alNone)
   then
     begin
       Controls[I].Top := R.Top + RectHeight(R) div 2 - Controls[I].Height div 2;
     end;
  end;
end;

procedure TbsSkinToolBar.WMWindowPosChanging;
begin
  inherited;
  if HandleAllocated and Self.AdjustControls
  then
    begin
      AdjustAllControls;
    end;
end;

procedure TbsSkinToolBar.CreateControlSkinImage(B: TBitMap);
begin
  if ((Buttons[0].Visible) or (Buttons[1].Visible)) and (ResizeMode = 2)
  then
    begin
      CreateHSkinImage3(LTPt.X, RectWidth(SkinRect) - RTPt.X,
          B, Picture, SkinRect, Width, Height, StretchEffect);
    end
  else
    inherited;
end;

procedure TbsSkinToolBar.SetBounds;
var
  MaxWidth, OldWidth: Integer;
  i: Integer;
begin
  OldWidth := Width;
  inherited;
  if FAdjustControls then
   for i := 0 to ControlCount - 1 do
     with Controls[I] do SetBounds(Left, Top, Width, Height);
  if not FCanScroll then Exit;
  if (OldWidth <> Width)
  then
    begin
      if (OldWidth < Width) and (OldWidth <> 0)
      then FHSizeOffset := Width - OldWidth
      else FHSizeOffset := 0;
    end
  else
    FHSizeOffset := 0;
  if Align <> alNone then GetScrollInfo;
  AdjustAllControls;
end;

procedure TbsSkinToolBar.StartTimer;
begin
  KillTimer(Handle, 1);
  SetTimer(Handle, 1, Self.ScrollTimerInterval, nil);
end;

procedure TbsSkinToolBar.StopTimer;
begin
  KillTimer(Handle, 1);
  TimerMode := 0;
end;

procedure TbsSkinToolBar.AdjustClientRect(var Rect: TRect);
var
  RLeft, RTop, VMax, HMax: Integer;
begin
  inherited;
  if FCanScroll and (Buttons[0].Visible) or (Buttons[1].Visible)
  then
    begin
      RTop := 0;
      RLeft := - SPosition;
      HMax := Max(SMax, ClientWidth);
      VMax := ClientHeight;
      Rect := Bounds(RLeft, RTop,  HMax, VMax);
      if (FIndex <> -1) and not (csDesigning in ComponentState)
      then
        begin
          if (BorderStyle <> bvNone) or (ResizeMode <> 1)
          then
            begin
              Rect.Top := NewClRect.Top;
              Rect.Bottom := NewClRect.Bottom;
            end;
        end
     else
       begin
          Rect.Top := 1;
          Rect.Bottom := Rect.Bottom - 1;
       end;
    end;
end;

procedure TbsSkinToolBar.HScrollControls(AOffset: Integer);
begin
  ScrollBy(-AOffset, 0);
  RePaint;
end;

procedure TbsSkinToolBar.GetScrollInfo;
begin
  if FCanScroll then GetHRange;
end;

procedure TbsSkinToolBar.GetHRange;
var
  i, FMax, W, MaxRight, Offset: Integer;
begin
  if Width = 0 then Exit;
  MaxRight := 0;
  if ControlCount > 0
  then
  for i := 0 to ControlCount - 1 do
  with Controls[i] do
  begin
   if Visible
   then
     if Left + Width > MaxRight then MaxRight := left + Width;
  end;
  if MaxRight = 0
  then
    begin
      if Buttons[1].Visible then SetButtonsVisible(False);
      Exit;
    end;
  W := ClientWidth;
  FMax := MaxRight + SPosition;
  if (FMax > W)
  then
    begin
      if not Buttons[1].Visible then  SetButtonsVisible(True);
      if (SPosition > 0) and (MaxRight < W) and (FHSizeOffset > 0)
      then
        begin
          if FHSizeOffset > SPosition then FHSizeOffset := SPosition;
          SMax := FMax - 1;
          SPosition := SPosition - FHSizeOffset;
          SPage := W;
          HScrollControls(-FHSizeOffset);
          SOldPosition := SPosition;
        end
     else
       begin
         if (FHSizeOffset = 0) and ((FMax - 1) < SMax) and (SPosition > 0) and
            (MaxRight < W)
         then
           begin
             SMax := FMax - 1;
             SPosition := SPosition - (W - MaxRight);
             SPage := W;
             HScrollControls(MaxRight - W);
             FHSizeOffset := 0;
             SOldPosition := SPosition;
           end
         else
           begin
             SMax := FMax - 1;
             SPage := W;
           end;
          FHSizeOffset := 0;
          SOldPosition := SPosition;
        end;
    end
  else
    begin
      if SPosition > 0 then HScrollControls(-SPosition);
      FHSizeOffset := 0;
      SMax := 0;
      SPosition := 0;
      SPage := 0;
      if Buttons[1].Visible then SetButtonsVisible(False);
   end;
end;

procedure TbsSkinToolBar.ButtonUp(I: Integer);
begin
  case I of
    0:
      begin
        StopTimer;
        TimerMode := 0;
        ButtonClick(0);
      end;
    1:
      begin
        StopTimer;
        TimerMode := 0;
        ButtonClick(1);
      end;
  end;
end;

procedure TbsSkinToolBar.ButtonDown(I: Integer);
begin
  case I of
    0:
      begin
        TimerMode := 1;
        StartTimer;
      end;
    1:
      begin
        TimerMode := 2;
        StartTimer;
      end;
  end;
end;

procedure TbsSkinToolBar.ButtonClick;
var
  SOffset: Integer;
begin
  if FScrollOffset = 0
  then
    SOffset := ClientWidth
  else
    SOffset := FScrollOffset;
  case I of
    0:
        begin
          SPosition := SPosition - SOffset;
          if SPosition < 0 then SPosition := 0;
          if (SPosition - SOldPosition <> 0)
          then
            HScrollControls(SPosition - SOldPosition)
          else
            StopTimer;
        end;
    1:
        begin
          SPosition := SPosition + SOffset;
          if SPosition > SMax - SPage + 1 then SPosition := SMax - SPage + 1;
          if (SPosition - SOldPosition <> 0)
          then
            HScrollControls(SPosition - SOldPosition)
          else
            StopTimer;
        end;
  end;
end;

procedure TbsSkinToolBar.SetButtonsVisible;
begin
  if Buttons[0].Visible <> AVisible
  then
    begin
      Buttons[0].Visible := AVisible;
      Buttons[1].Visible := AVisible;
      if not (Parent is TbsSkinCoolBar)
      then
        begin
          ReCreateWnd;
          HandleNeeded;
        end;
    end;
end;

procedure TbsSkinToolBar.WndProc;
var
  B: Boolean;
  P: TPoint;
begin
  B := True;
  case Message.Msg of
    WM_WINDOWPOSCHANGING:
    if Self.HandleAllocated and (Align = alNone)
    then
      begin
        GetScrollInfo;
      end;
    WM_NCHITTEST:
      if not (csDesigning in ComponentState) and FCanScroll then
      begin
        P.X := LoWord(Message.lParam);
        P.Y := HiWord(Message.lParam);
        P := ScreenToClient(P);
        if (P.X < 0) and Buttons[0].Visible
        then
          begin
            Message.Result := HTBUTTON1;
            B := False;
          end
        else
        if (P.X > ClientWidth) and Buttons[1].Visible
        then
          begin
            Message.Result := HTBUTTON2;
            B := False;
          end;
      end;

    WM_NCLBUTTONDOWN, WM_NCLBUTTONDBLCLK:
       if FCanScroll then
       begin
         if Message.wParam = HTBUTTON1
         then
           begin
             Buttons[0].Down := True;
             SendMessage(Handle, WM_NCPAINT, 0, 0);
             ButtonDown(0);
           end
         else
         if Message.wParam = HTBUTTON2
         then
           begin
             Buttons[1].Down := True;
             SendMessage(Handle, WM_NCPAINT, 0, 0);
             ButtonDown(1);
           end;
       end;

    WM_NCLBUTTONUP:
       if FCanScroll then
       begin
         if Message.wParam = HTBUTTON1
         then
           begin
             Buttons[0].Down := False;
             SendMessage(Handle, WM_NCPAINT, 0, 0);
             ButtonUp(0);
           end
         else
         if Message.wParam = HTBUTTON2
         then
           begin
             Buttons[1].Down := False;
             SendMessage(Handle, WM_NCPAINT, 0, 0);
             ButtonUp(1);
           end;
       end;

     WM_NCMOUSEMOVE:
       if FCanScroll then
       begin
         if (Message.wParam = HTBUTTON1) and (not Buttons[0].MouseIn)
         then
           begin
             Buttons[0].MouseIn := True;
             Buttons[1].MouseIn := False;
             SendMessage(Handle, WM_NCPAINT, 0, 0);
             if FHotScroll
             then
               begin
                 TimerMode := 1;
                 StartTimer;
               end;
           end
         else
         if (Message.wParam = HTBUTTON2) and (not Buttons[1].MouseIn)
         then
           begin
             Buttons[1].MouseIn := True;
             Buttons[0].MouseIn := False;
             SendMessage(Handle, WM_NCPAINT, 0, 0);
             if FHotScroll
             then
               begin
                 TimerMode := 2;
                 StartTimer;
               end;
           end;
       end;

    WM_MOUSEMOVE:
      begin
        if Buttons[0].MouseIn and Buttons[0].Visible
        then
          begin
            if TimerMode <> 0 then StopTimer;
            Buttons[0].MouseIn := False;
            SendMessage(Handle, WM_NCPAINT, 0, 0);
          end
        else
        if Buttons[1].MouseIn and Buttons[1].Visible
        then
          begin
            if TimerMode <> 0 then StopTimer;
            Buttons[1].MouseIn := False;
            SendMessage(Handle, WM_NCPAINT, 0, 0);
          end;
      end;
  end;
  if B then inherited;
end;

procedure TbsSkinToolBar.CMMOUSELEAVE;
var
  P: TPoint;
begin
  inherited;
  if (csDesigning in ComponentState) or not FCanScroll then Exit;
  GetCursorPos(P);
  if WindowFromPoint(P) <> Handle
  then
    if Buttons[0].MouseIn and Buttons[0].Visible
    then
      begin
        if TimerMode <> 0 then StopTimer;
        Buttons[0].MouseIn := False;
        SendMessage(Handle, WM_NCPAINT, 0, 0);
      end
    else
      if Buttons[1].MouseIn and Buttons[1].Visible
      then
        begin
          if TimerMode <> 0 then StopTimer;
          Buttons[1].MouseIn := False;
          SendMessage(Handle, WM_NCPAINT, 0, 0);
        end;
end;

procedure TbsSkinToolBar.WMSIZE;
begin
  inherited;
  if FCanScroll and (Buttons[0].Visible or Buttons[1].Visible)
  then
    begin
      Buttons[0].R := Rect(0, 0, ButtonSize, Height);
      Buttons[1].R := Rect(Width - ButtonSize, 0, Width, Height);
      SendMessage(Handle, WM_NCPAINT, 0, 0);
    end;
end;

procedure TbsSkinToolBar.WMNCPaint;
var
  Cnvs: TCanvas;
  DC: HDC;
begin
  if FCanScroll and (Buttons[0].Visible or Buttons[1].Visible)
  then
    begin
      DC := GetWindowDC(Handle);
      Cnvs := TCanvas.Create;
      Cnvs.Handle := DC;
      if Buttons[0].Visible then DrawButton(Cnvs, 0);
      if Buttons[1].Visible then DrawButton(Cnvs, 1);
      Cnvs.Handle := 0;
      ReleaseDC(Handle, DC);
      Cnvs.Free;
    end;  
end;

procedure TbsSkinToolBar.WMNCCALCSIZE;
begin
  if FCanScroll
  then
    begin
      GetSkinData;
      with TWMNCCALCSIZE(Message).CalcSize_Params^.rgrc[0] do
      begin
        if Buttons[0].Visible then Inc(Left, ButtonSize);
        if Buttons[1].Visible then Dec(Right, ButtonSize);
      end;
    end;  
end;

procedure TbsSkinToolBar.GetSkinData;
var
  CIndex: Integer;
begin
  inherited;
  ButtonData := nil;
  if FIndex <> -1
  then
    begin
      CIndex := FSD.GetControlIndex('resizebutton');
      if CIndex <> -1
      then
       ButtonData := TbsDataSkinButtonControl(FSD.CtrlList[CIndex]);
    end;   
end;


procedure TbsSkinToolBar.WMTimer;
begin
  inherited;
  if FCanScroll then
  case TimerMode of
    1: ButtonClick(0);
    2: ButtonClick(1);
  end;    
end;

procedure TbsSkinToolBar.SetScrollTimerInterval;
begin
  if Value > 0 then FScrollTimerInterval := Value;
end;

procedure TbsSkinToolBar.SetScrollOffset;
begin
  if Value >= 0 then FScrollOffset := Value;
end;

procedure TbsSkinToolBar.DrawButton;
var
  B: TBitMap;
  R, NewCLRect: TRect;
  FSkinPicture: TBitMap;
  NewLtPoint, NewRTPoint, NewLBPoint, NewRBPoint: TPoint;
  XO, YO: Integer;
  C: TColor;
begin
  B := TBitMap.Create;
  B.Width := RectWidth(Buttons[i].R);
  B.Height := RectHeight(Buttons[i].R);
  R := Rect(0, 0, B.Width, B.Height);
  GetSkinData;
  if ButtonData = nil
  then
    begin
      C := clBtnText;
      if ((Buttons[I].Down and Buttons[I].MouseIn)) or
          (Buttons[I].MouseIn and HotScroll)
      then
        begin
          Frame3D(B.Canvas, R, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
          B.Canvas.Brush.Color := BS_XP_BTNDOWNCOLOR;
          B.Canvas.FillRect(R);
        end
      else
      if Buttons[I].MouseIn
      then
        begin
          Frame3D(B.Canvas, R, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
          B.Canvas.Brush.Color := BS_XP_BTNACTIVECOLOR;
          B.Canvas.FillRect(R);
        end
      else
        begin
          Frame3D(B.Canvas, R, clBtnShadow, clBtnShadow, 1);
          B.Canvas.Brush.Color := clBtnFace;
          B.Canvas.FillRect(R);
        end;
    end
  else
    with ButtonData, Buttons[I] do
    begin
      //
      XO := RectWidth(R) - RectWidth(SkinRect);
      YO := RectHeight(R) - RectHeight(SkinRect);
      NewLTPoint := LTPoint;
      NewRTPoint := Point(RTPoint.X + XO, RTPoint.Y);
      NewLBPoint := Point(LBPoint.X, LBPoint.Y + YO);
      NewRBPoint := Point(RBPoint.X + XO, RBPoint.Y + YO);
      NewClRect := Rect(CLRect.Left, ClRect.Top,
        CLRect.Right + XO, ClRect.Bottom + YO);
      FSkinPicture := TBitMap(FSD.FActivePictures.Items[ButtonData.PictureIndex]);
      //
      if (Down and not IsNullRect(DownSkinRect) and MouseIn) or
         (MouseIn and HotScroll and not IsNullRect(DownSkinRect))
      then
        begin
          CreateSkinImage(LTPoint, RTPoint, LBPoint, RBPoint, CLRect,
          NewLtPoint, NewRTPoint, NewLBPoint, NewRBPoint, NewCLRect,
          B, FSkinPicture, DownSkinRect, B.Width, B.Height, True,
          LeftStretch, TopStretch, RightStretch, BottomStretch,
          StretchEffect);
          C := DownFontColor;
        end
      else
      if MouseIn and not IsNullRect(ActiveSkinRect)
      then
        begin
          CreateSkinImage(LTPoint, RTPoint, LBPoint, RBPoint, CLRect,
          NewLtPoint, NewRTPoint, NewLBPoint, NewRBPoint, NewCLRect,
          B, FSkinPicture, ActiveSkinRect, B.Width, B.Height, True,
          LeftStretch, TopStretch, RightStretch, BottomStretch,
          StretchEffect);
          C := ActiveFontColor;
        end
      else
        begin
          CreateSkinImage(LTPoint, RTPoint, LBPoint, RBPoint, CLRect,
          NewLtPoint, NewRTPoint, NewLBPoint, NewRBPoint, NewCLRect,
          B, FSkinPicture, SkinRect, B.Width, B.Height, True,
          LeftStretch, TopStretch, RightStretch, BottomStretch,
          StretchEffect);
          C := FontColor;
        end;
   end;
  //
  case I of
    0: DrawArrowImage(B.Canvas, R, C, 1);
    1: DrawArrowImage(B.Canvas, R, C, 2);
  end;
  //
  Cnvs.Draw(Buttons[I].R.Left, Buttons[I].R.Top, B);
  B.Free;
end;

procedure TbsSkinToolBar.SetShowCaptions(Value: Boolean);
var
  I: Integer;
begin
  if FShowCaptions <> Value
  then
    begin
      FShowCaptions := Value;
      if FAutoShowHideCaptions
      then
        for I := 0 to ControlCount - 1 do
          if Controls[I] is TbsSkinSpeedButton
          then
            TbsSkinSpeedButton(Controls[I]).ShowCaption := FShowCaptions;
      if (FWidthWithCaptions <> 0) and (FWidthWithoutCaptions <> 0)
      then
        begin
          if FShowCaptions
          then Width := FWidthWithCaptions
          else Width := FWidthWithoutCaptions;
        end;
    end;        
end;

procedure TbsSkinToolBar.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if AComponent = FImages then Images := nil;
    if AComponent = FHotImages then HotImages := nil;
    if AComponent = FDisabledImages then DisabledImages := nil;
  end;
end;

procedure TbsSkinToolBar.SetSkinDataName(Value: String);
var
  I: Integer;
begin
  inherited;
  if (csDesigning in ComponentState) and not
     (csLoading in ComponentState)
  then
  for I := 0 to ControlCount - 1 do
  if Controls[I] is TbsSkinMenuSpeedButton
  then
    with TbsSkinMenuSpeedButton(Controls[I]) do
    begin
      if Self.SkinDataName = 'resizetoolpanel'
      then
        SkinDataName := 'resizetoolbutton'
      else
      if Self.SkinDataName = 'panel'
      then
        SkinDataName := 'resizebutton'
      else
      if TrackButtonMode
      then
        begin
          if Self.SkinDataName = 'bigtoolpanel'
          then
            SkinDataName := 'bigtoolmenutrackbutton'
          else
            SkinDataName := 'toolmenutrackbutton';
        end
      else
        begin
          if Self.SkinDataName = 'bigtoolpanel'
          then
            SkinDataName := 'bigtoolmenubutton'
          else
            SkinDataName := 'toolmenubutton';
        end;
    end
  else
  if Controls[I] is TbsSkinSpeedButton
  then
    with TbsSkinSpeedButton(Controls[I]) do
    begin
      if Self.SkinDataName = 'resizetoolpanel'
      then
         SkinDataName := 'resizetoolbutton'
      else
      if Self.SkinDataName = 'panel'
      then
        SkinDataName := 'resizebutton'
      else
      if Self.SkinDataName = 'bigtoolpanel'
      then
        SkinDataName := 'bigtoolbutton'
      else
        SkinDataName := 'toolbutton';
    end;
end;

procedure TbsSkinToolBar.SetSkinData(Value: TbsSkinData);
var
  I: Integer;
begin
  inherited;
  for I := 0 to ControlCount - 1 do
    if Controls[I] is TbsSkinSpeedButton
    then
      TbsSkinSpeedButton(Controls[I]).SkinData := Self.SkinData
    else
    if Controls[I] is TbsSkinBevel
    then
      TbsSkinBevel(Controls[I]).SkinData := Self.SkinData
end;

procedure TbsSkinToolBar.SetFlat(Value: Boolean);
var
  I: Integer;
begin
  FFlat := Value;
  for I := 0 to ControlCount - 1 do
    if Controls[I] is TbsSkinSpeedButton
     then
       TbsSkinSpeedButton(Controls[I]).Flat := FFlat;
end;

procedure TbsSkinToolBar.SetDisabledImages(Value: TCustomImageList);
begin
  FDisabledImages := Value;
end;

procedure TbsSkinToolBar.SetHotImages(Value: TCustomImageList);
begin
  FHotImages := Value;
end;

procedure TbsSkinToolBar.SetImages(Value: TCustomImageList);
var
  I: Integer;
begin
  FImages := Value;
  for I := 0 to ControlCount - 1 do
    if Controls[I] is TbsSkinSpeedButton
     then
       TbsSkinSpeedButton(Controls[I]).RePaint;
end;

constructor TbsSkinStatusBar.Create;
begin
  inherited;
  FSkinDataName := 'statusbar';
  Align := alBottom;
  Height := 21;
  BorderStyle := bvNone;
  FSizeGrip := False;
  FShowGrip := True;
  FForceBackGround := False;
end;

procedure TbsSkinStatusBar.WMNCHitTest;
var
  R: TRect;
  P: TPoint;
begin
  if not (csDesigning in ComponentState) and FSizeGrip and FShowGrip
  then
    begin
      R := GetGripRect;
      P := ScreenToClient(SmallPointToPoint(TWMNCHitTest(Message).Pos));
      if PointInRect(R, P)
      then
        Message.Result := HTBOTTOMRIGHT
      else
        Message.Result := HTCLIENT;
    end
  else
    inherited;
end;

function TbsSkinStatusBar.GetGripRect: TRect;
var
  R: TRect;
begin
  R := GetSkinClientRect;
  if (FIndex <> -1) and not IsNullRect(GripperRect)
  then
    begin
      Result := Rect(R.Right, R.Bottom - RectHeight(GripperRect),
        R.Right + RectWidth(GripperRect), R.Bottom);
    end
  else
    begin
      Result := Rect(R.Right, R.Top, R.Right + RectHeight(R), R.Bottom);
      Dec(Result.Bottom, 2);
      Inc(Result.Left, 2);
    end;
end;

procedure TbsSkinStatusBar.CreateControlDefaultImage(B: TBitMap);
var
  R: TRect;
begin
  inherited;
  if FSizeGrip and FShowGrip
  then
    begin
      R := GetGripRect;
      DrawDefaultGripper(R, B.Canvas, clBtnShadow, clBtnHighLight);
    end;
end;

procedure TbsSkinStatusBar.CreateControlSkinImage(B: TBitMap);
var
  R: TRect;
  GripperBuffer: TBitMap;
begin
  inherited;
  R := GetGripRect;
  if FSizeGrip and FShowGrip
  then
    begin
      if IsNullRect(GripperRect)
      then
         DrawDefaultGripper(R, B.Canvas, SkinData.SkinColors.cBtnShadow, SkinData.SkinColors.cBtnHighLight)
      else
        begin
          GripperBuffer := TBitMap.Create;
          GripperBuffer.Width := RectWidth(GripperRect);
          GripperBuffer.Height := RectHeight(GripperRect);
          GripperBuffer.Canvas.CopyRect(
             Rect(0, 0, GripperBuffer.Width, GripperBuffer.Height),
            Picture.Canvas, GripperRect);
          if GripperTransparent
          then
            begin
              GripperBuffer.Transparent := True;
              GripperBuffer.TransparentMode := tmFixed;
              GripperBuffer.TransparentColor := GripperTransparentColor;
            end;
          B.Canvas.Draw(R.Left, R.Top, GripperBuffer);
          GripperBuffer.Free;
        end;
    end;
end;

procedure TbsSkinStatusBar.DrawDefaultGripper(R: TRect; Cnvs: TCanvas; C1, C2: TColor);
var
  I, Count: Integer;
  k: Integer;
begin
  Count := RectWidth(R) div 3;
  k := 3;
  with Cnvs do
  begin
    for i := 0 to Count do
    if R.Left + k + 2 <= R.Right then
    begin
      Pen.Color := C1;
      MoveTo(R.Left + k, R.Bottom);
      LineTo(R.Right, R.Top + k);
      Pen.Color := C2;
      MoveTo(R.Left + k + 1, R.Bottom);
      LineTo(R.Right, R.Top + k + 1);
      Inc(k, 3);
    end;
  end;
end;

procedure TbsSkinStatusBar.AdjustClientRect(var Rect: TRect);
begin
  inherited AdjustClientRect(Rect);
  if FSizeGrip and FShowGrip
  then
    begin
      if (FIndex <> -1) and not IsNullRect(GripperRect)
      then
        Dec(Rect.Right, RectWidth(GripperRect))
      else
        Dec(Rect.Right, RectHeight(Rect));
    end;
end;

procedure TbsSkinStatusBar.SetShowGrip(Value: Boolean);
begin
  FShowGrip := Value;
  RePaint;
  ReAlign;
end;

procedure TbsSkinStatusBar.SetSizeGrip(Value: Boolean);
begin
  FSizeGrip := Value;
  RePaint;
  ReAlign;
end;

procedure TbsSkinStatusBar.GetSkinData;
begin
  inherited;
  if FIndex <> -1
  then
    begin
      if TbsDataSkinControl(FSD.CtrlList.Items[FIndex]) is TbsDataSkinPanelControl
      then
        with TbsDataSkinPanelControl(FSD.CtrlList.Items[FIndex]) do
        begin
          Self.GripperRect := GripperRect;
          Self.GripperTransparent := GripperTransparent;
          Self.GripperTransparentColor := GripperTransparentColor;
        end;
     end;
end;

procedure TbsSkinStatusBar.SetSkinData;
var
  I: Integer;
begin
  inherited;
  for I := 0 to ControlCount - 1 do
  if Controls[I] is TbsSkinControl
  then
    TbsSkinControl(Controls[I]).SkinData := Self.SkinData
end;

//=========== TbsSkinCheckRadioBox ===============

constructor TbsSkinCheckRadioBox.Create;
begin
  inherited;
  FWordWrap := False;
  FAllowGrayed := False;
  FState := cbUnchecked;
  FFlat := True;
  FCanFocused := True;
  TabStop := False;
  FMouseIn := False;
  Width := 150;
  Height := 25;
  FGroupIndex := 0;
  FSkinDataName := 'checkbox';
  MorphTimer := nil;
  FImages := nil;
  FImageIndex := 0;
end;

destructor TbsSkinCheckRadioBox.Destroy;
begin
  StopMorph;
  inherited;
end;

procedure TbsSkinCheckRadioBox.SetWordWrap;
begin
  if FWordWrap <> Value
  then
    begin
      FWordWrap := Value;
      if FFlat then RePaint;
    end;  
end;

procedure TbsSkinCheckRadioBox.SetAllowGrayed(Value: Boolean);
begin
  FAllowGrayed := Value;
  RePaint;
end;

procedure TbsSkinCheckRadioBox.SetState(Value: TCheckBoxState);
begin
  FState := Value;
  if FState = cbChecked
  then
    FChecked := True
  else
    FChecked := False;
  RePaint;  
  if Assigned(FOnClick) then FOnClick(Self);
end;

function TbsSkinCheckRadioBox.EnableMorphing: Boolean;
begin
  Result := Morphing and (SkinData <> nil) and not SkinData.Empty and
            SkinData.EnableSkinEffects;
end;


procedure TbsSkinCheckRadioBox.PaintSkinTo(C: TCanvas; X, Y: Integer; AChecked: Boolean);
var
  Buffer, ABuffer: TBitMap;
  PBuffer, APBuffer: TbsEffectBmp;
  IR, TR, TR1: TRect;
  IX, IY, TY: Integer;
  ImX, ImY: Integer;
  Cl: TColor;
begin
  GetSkinData;
  if FFlat
  then
    begin
      Buffer := TBitMap.Create;
      Buffer.Width := Width;
      Buffer.Height := Height;
      GetParentImage(Self, Buffer.Canvas);
      if FIndex = -1
      then
        with Buffer.Canvas do
        begin
          IR := Rect(3, Height div 2 - 7, 17, Height div 2 + 7);
          // draw caption
          Font := DefaultFont;
          if (SkinData <> nil) and (SkinData.ResourceStrData <>  nil)
          then
            Font.Charset := SkinData.ResourceStrData.CharSet;
          Brush.Style := bsClear;
          if not FWordWrap
          then
            begin
              TR := Rect(0, 0, 0, 0);
              DrawText(Buffer.Canvas.Handle, PChar(Caption), Length(Caption), TR,
                DT_CALCRECT)
            end
          else
            begin
              TR := ClientRect;
              TR.Left := 22;
              if (FImages <> nil) and (ImageIndex >= 0) and (ImageIndex < FImages.Count)
              then
                begin
                  TR.Left := TR.Left + FImages.Width;
                end;
              TR1 := TR;
              DrawText(Buffer.Canvas.Handle, PChar(Caption), Length(Caption), TR1,
                DT_EXPANDTABS or DT_WORDBREAK  or DT_CALCRECT);
              TY := Height div 2 - RectHeight(TR1) div 2;
              if TY < 0 then TY := 0;
              TR1 := Rect(TR1.Left, TY, TR1.Right, TY + RectHeight(TR1));
              TR := ClientRect;
            end;
          OffsetRect(TR, 22, Height div 2 - RectHeight(TR) div 2);
          if TR.Right > Width - 2 then TR.Right := Width - 2;
          if (FImages <> nil) and (ImageIndex >= 0) and (ImageIndex < FImages.Count)
          then
            begin
              ImX := TR.Left;
              ImY := Height div 2 - FImages.Height div 2;
              FIMages.Draw(Buffer.Canvas, ImX, ImY, FImageIndex, Enabled);
              OffsetRect(TR, FImages.Width + 5, 0);
            end;
          Brush.Style := bsClear;
          if not Enabled then Font.Color := clBtnShadow;
          if FWordWrap
          then
            DrawText(Buffer.Canvas.Handle, PChar(Caption), Length(Caption), TR1,
               DT_EXPANDTABS or DT_WORDBREAK)
          else
            BSDrawText(Buffer.Canvas, Caption, TR);
          // draw glyph
          Frame3D(Buffer.Canvas, IR, clbtnShadow, clbtnShadow, 1);
          Pen.Color := clBlack;
          if AChecked
          then
            begin
              if Enabled then Cl := clBlack else Cl := clBtnShadow;
              if FRadio
              then DrawRadioImage(Buffer.Canvas, 7, Height div 2 - 3, Cl)
              else DrawCheckImage(Buffer.Canvas, 7, Height div 2 - 4, Cl);
            end;
        end
      else
        with Buffer.Canvas do
        begin
          // draw glyph
          IX := 3;
          IY := Height div 2 - RectHeight(CheckImageRect) div 2;
          if not Enabled
          then
            begin
              if FState = cbGrayed
              then
                SkinDrawGrayedCheckImage(IX, IY, Picture.Canvas,  UnEnabledCheckImageRect, Buffer.Canvas)
              else
              if AChecked
              then
                SkinDrawCheckImage(IX, IY, Picture.Canvas, UnEnabledCheckImageRect, Buffer.Canvas)
              else
                SkinDrawCheckImage(IX, IY, Picture.Canvas, UnEnabledUnCheckImageRect, Buffer.Canvas);
            end
          else
          if FMouseIn
          then
            begin
              if FState = cbGrayed
              then
                SkinDrawGrayedCheckImage(IX, IY, Picture.Canvas, ActiveCheckImageRect, Buffer.Canvas)
              else
              if AChecked
              then
                SkinDrawCheckImage(IX, IY, Picture.Canvas, ActiveCheckImageRect, Buffer.Canvas)
              else
                SkinDrawCheckImage(IX, IY, Picture.Canvas, ActiveUnCheckImageRect, Buffer.Canvas);
            end
          else
            begin
              if FState = cbGrayed
              then
                SkinDrawGrayedCheckImage(IX, IY, Picture.Canvas, CheckImageRect, Buffer.Canvas)
              else
              if AChecked
              then
                SkinDrawCheckImage(IX, IY, Picture.Canvas, CheckImageRect, Buffer.Canvas)
              else
                SkinDrawCheckImage(IX, IY, Picture.Canvas, UnCheckImageRect, Buffer.Canvas);
            end;

          // draw caption
          if FUseSkinFont
          then
            begin
              Font.Name := FontName;
              Font.Height := FontHeight;
              Font.Style := FontStyle;
             end
          else
            Font.Assign(FDefaultFont);
          if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
          then
            Font.Charset := SkinData.ResourceStrData.CharSet
          else
            Font.CharSet := FDefaultFont.Charset;
          if not FWordWrap
          then
            begin
              TR := Rect(0, 0, 0, 0);
              DrawText(Buffer.Canvas.Handle, PChar(Caption), Length(Caption), TR,
                DT_CALCRECT);
             end
           else
            begin
              TR := ClientRect;
              TR.Left := RectWidth(CheckIMageRect) + 7;
              if (FImages <> nil) and (ImageIndex >= 0) and (ImageIndex < FImages.Count)
              then
                begin
                  TR.Left := TR.Left + FImages.Width;
                end;
              TR1 := TR;
              DrawText(Buffer.Canvas.Handle, PChar(Caption), Length(Caption), TR1,
                DT_EXPANDTABS or DT_WORDBREAK  or DT_CALCRECT);
              TY := Height div 2 - RectHeight(TR1) div 2;
              if TY < 0 then TY := 0;
              TR1 := Rect(TR1.Left, TY, TR1.Right, TY + RectHeight(TR1));
              TR := ClientRect;
            end;
          OffsetRect(TR, IX + RectWidth(CheckIMageRect) + 4, Height div 2 - RectHeight(TR) div 2);
          if TR.Right > Width - 2 then TR.Right := Width - 2;
          //
          if (FImages <> nil) and (ImageIndex >= 0) and (ImageIndex < FImages.Count)
          then
            begin
              ImX := TR.Left;
              ImY := Height div 2 - FImages.Height div 2;
              FIMages.Draw(Buffer.Canvas, ImX, ImY, FImageIndex, Enabled);
              OffsetRect(TR, FImages.Width + 8, 0);
            end;
          //
          Brush.Style := bsClear;
          if not Enabled
          then Font.Color := UnEnabledFontColor
          else Font.Color := FrameFontColor;
          if FWordWrap
          then
            DrawText(Buffer.Canvas.Handle, PChar(Caption), Length(Caption), TR1,
               DT_EXPANDTABS or DT_WORDBREAK)
          else
            BSDrawText(Buffer.Canvas, Caption, TR);
        end;
      C.Draw(X, Y, Buffer);
      Buffer.Free;
    end
  else
  if FIndex = -1
  then
    inherited
  else
    begin
      Buffer := TBitMap.Create;
      Buffer.Width := Width;
      Buffer.Height := Height;
      CreateImage2(Buffer, SkinRect, AChecked);
      C.Draw(X, Y, Buffer);
      Buffer.Free;
   end;
end;


procedure TbsSkinCheckRadioBox.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if AComponent = FImages then Images := nil;
  end;
end;

procedure TbsSkinCheckRadioBox.SetImages(Value: TCustomImageList);
begin
  FImages := Value;
  RePaint;
end;

procedure TbsSkinCheckRadioBox.SetImageIndex(Value: Integer);
begin
  FImageIndex := Value;
  RePaint;
end;

procedure TbsSkinCheckRadioBox.WMMOVE(var Msg: TWMMOVE);
begin
  inherited;
  if FFlat then Invalidate;
end;


procedure TbsSkinCheckRadioBox.SkinDrawGrayedCheckImage(X, Y: Integer; Cnvs: TCanvas; IR: TRect; DestCnvs: TCanvas);
var
  B: TBitMap;
  Buffer: TbsEffectBmp;
begin
  B := TBitMap.Create;
  B.Width := RectWidth(IR);
  B.Height := RectHeight(IR);
  B.Canvas.CopyRect(Rect(0, 0, B.Width, B.Height), Cnvs, IR);
  Buffer := TbsEffectBmp.CreateFromhWnd(B.Handle);
  Buffer.ChangeBrightness(0.5);
  Buffer.Draw(B.Canvas.Handle, 0, 0);
  Buffer.Free;
  B.Transparent := True;
  DestCnvs.Draw(X, Y, B);
  B.Free;
end;

procedure TbsSkinCheckRadioBox.SkinDrawCheckImage(X, Y: Integer; Cnvs: TCanvas; IR: TRect; DestCnvs: TCanvas);
var
  B: TBitMap;
begin
  B := TBitMap.Create;
  B.Width := RectWidth(IR);
  B.Height := RectHeight(IR);
  B.Canvas.CopyRect(Rect(0, 0, B.Width, B.Height), Cnvs, IR);
  B.Transparent := True;
  DestCnvs.Draw(X, Y, B);
  B.Free;
end;

procedure TbsSkinCheckRadioBox.SetFlat;
begin
  FFlat := Value;
  RePaint;
end;

procedure TbsSkinCheckRadioBox.CMEnabledChanged;
begin
  inherited;
  if EnableMorphing
  then
    begin
      StopMorph;
      FMorphKf := 0;
    end;
  FMouseIn := False;
  RePaint;
end;

procedure TbsSkinCheckRadioBox.DoMorph;
begin
  if (FIndex = -1) or not EnableMorphing
  then
    begin
      if (FMouseIn or IsFocused) then FMorphKf := 1 else FMorphKf := 0;
      StopMorph;
    end
  else
  if (FMouseIn or IsFocused) and (FMorphKf < 1)
  then
    begin
      FMorphKf := FMorphKf + MorphInc;
      RePaint;
    end
  else
  if (not FMouseIn and not IsFocused) and (FMorphKf > 0)
  then
    begin
      FMorphKf := FMorphKf - MorphInc;
      RePaint;
    end
  else
    begin
      if (FMouseIn or IsFocused) then FMorphKf := 1 else FMorphKf := 0;
      StopMorph;
      RePaint;
    end;
end;

procedure TbsSkinCheckRadioBox.StartMorph;
begin
  if MorphTimer <> nil then Exit;
  MorphTimer := TTimer.Create(Self);
  MorphTimer.Interval := MorphTimerInterval;
  MorphTimer.OnTimer := DoMorph;
  MorphTimer.Enabled := True;
end;

procedure TbsSkinCheckRadioBox.StopMorph;
begin
  if MorphTimer = nil then Exit;
  MorphTimer.Free;
  MorphTimer := nil;
end;

procedure TbsSkinCheckRadioBox.Paint;
var
  Buffer, ABuffer: TBitMap;
  PBuffer, APBuffer: TbsEffectBmp;
  IR, TR, TR1: TRect;
  IX, IY, TY: Integer;
  ImX, ImY: Integer;
  C: TColor;
begin
  GetSkinData;
  if FFlat
  then
    begin
      Buffer := TBitMap.Create;
      Buffer.Width := Width;
      Buffer.Height := Height;
      GetParentImage(Self, Buffer.Canvas);
      if FIndex = -1
      then
        with Buffer.Canvas do
        begin
          IR := Rect(3, Height div 2 - 7, 17, Height div 2 + 7);
          // draw caption
          Font := DefaultFont;
          if (SkinData <> nil) and (SkinData.ResourceStrData <>  nil)
          then
            Font.Charset := SkinData.ResourceStrData.CharSet;
          Brush.Style := bsClear;
          if not FWordWrap
          then
            begin
              TR := Rect(0, 0, 0, 0);
              DrawText(Buffer.Canvas.Handle, PChar(Caption), Length(Caption), TR,
                DT_CALCRECT)
            end
          else
            begin
              TR := ClientRect;
              TR.Left := 22;
              if (FImages <> nil) and (ImageIndex >= 0) and (ImageIndex < FImages.Count)
              then
                begin
                  TR.Left := TR.Left + FImages.Width;
                end;
              TR1 := TR;  
              DrawText(Buffer.Canvas.Handle, PChar(Caption), Length(Caption), TR1,
                DT_EXPANDTABS or DT_WORDBREAK  or DT_CALCRECT);
              TY := Height div 2 - RectHeight(TR1) div 2;
              if TY < 0 then TY := 0;
              TR1 := Rect(TR1.Left, TY, TR1.Right, TY + RectHeight(TR1));
              TR := ClientRect;
            end;
          OffsetRect(TR, 22, Height div 2 - RectHeight(TR) div 2);
          if TR.Right > Width - 2 then TR.Right := Width - 2;
          if (FImages <> nil) and (ImageIndex >= 0) and (ImageIndex < FImages.Count)
          then
            begin
              ImX := TR.Left;
              ImY := Height div 2 - FImages.Height div 2;
              FIMages.Draw(Buffer.Canvas, ImX, ImY, FImageIndex, Enabled);
              OffsetRect(TR, FImages.Width + 5, 0);
            end;
          Brush.Style := bsClear;
          if not Enabled then Font.Color := clBtnShadow;
          if FWordWrap
          then
            DrawText(Buffer.Canvas.Handle, PChar(Caption), Length(Caption), TR1,
               DT_EXPANDTABS or DT_WORDBREAK)
          else
            BSDrawText(Buffer.Canvas, Caption, TR);
          // draw glyph
          if FMouseIn
          then
            Frame3D(Buffer.Canvas, IR, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1)
          else
            Frame3D(Buffer.Canvas, IR, clbtnShadow, clbtnShadow, 1);
          Pen.Color := clBlack;
          if (FState = cbGrayed) and not FRadio
          then
            begin
              C := clGrayText;
              DrawCheckImage(Buffer.Canvas, 7, Height div 2 - 4, C);
           end
          else
          if FChecked
          then
            begin
              if Enabled then C := clBlack else C := clBtnShadow;
              if FRadio
              then DrawRadioImage(Buffer.Canvas, 7, Height div 2 - 3, C)
              else DrawCheckImage(Buffer.Canvas, 7, Height div 2 - 4, C);
            end;
          // draw focus
          InflateRect(TR, 2, 1);
          Inc(TR.Right, 1 );
          Brush.Style := bsSolid;
          Brush.Color := clBtnFace;
          if IsFocused
          then
            if Caption <> ''
            then
              begin
                if FWordWrap
                then
                  begin
                    InflateRect(TR1, 2, 1);
                    DrawFocusRect(TR1);
                  end
                else
                  DrawFocusRect(TR)
              end
            else
              if (FImages <> nil) and (ImageIndex >= 0) and (ImageIndex < FImages.Count)
              then
                DrawFocusRect(Rect(ImX - 1, ImY - 1,
                  ImX + FImages.Width + 1, ImY + FImages.Height + 1));
        end
      else
        with Buffer.Canvas do
        begin
          // draw glyph
          IX := 3;
          IY := Height div 2 - RectHeight(CheckImageRect) div 2;
          if not Enabled
          then
            begin
              if FState = cbGrayed
              then
                SkinDrawGrayedCheckImage(IX, IY, Picture.Canvas,  UnEnabledCheckImageRect, Buffer.Canvas)
              else
              if FChecked
              then
                SkinDrawCheckImage(IX, IY, Picture.Canvas, UnEnabledCheckImageRect, Buffer.Canvas)
              else
                SkinDrawCheckImage(IX, IY, Picture.Canvas, UnEnabledUnCheckImageRect, Buffer.Canvas);
            end
          else
          if FMouseIn
          then
            begin
              if FState = cbGrayed
              then
                SkinDrawGrayedCheckImage(IX, IY, Picture.Canvas, ActiveCheckImageRect, Buffer.Canvas)
              else
              if FChecked
              then
                SkinDrawCheckImage(IX, IY, Picture.Canvas, ActiveCheckImageRect, Buffer.Canvas)
              else
                SkinDrawCheckImage(IX, IY, Picture.Canvas, ActiveUnCheckImageRect, Buffer.Canvas);
            end
          else
            begin
              if FState = cbGrayed
              then
                SkinDrawGrayedCheckImage(IX, IY, Picture.Canvas, CheckImageRect, Buffer.Canvas)
              else
              if FChecked
              then
                SkinDrawCheckImage(IX, IY, Picture.Canvas, CheckImageRect, Buffer.Canvas)
              else
                SkinDrawCheckImage(IX, IY, Picture.Canvas, UnCheckImageRect, Buffer.Canvas);
            end;

          // draw caption
          if FUseSkinFont
          then
            begin
              Font.Name := FontName;
              Font.Height := FontHeight;
              Font.Style := FontStyle;
             end
          else
            Font.Assign(FDefaultFont);
          if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
          then
            Font.Charset := SkinData.ResourceStrData.CharSet
          else
            Font.CharSet := FDefaultFont.Charset;
          if not FWordWrap
          then
            begin
              TR := Rect(0, 0, 0, 0);
              DrawText(Buffer.Canvas.Handle, PChar(Caption), Length(Caption), TR,
                DT_CALCRECT);
             end
           else
            begin
              TR := ClientRect;
              TR.Left := RectWidth(CheckIMageRect) + 7;
              if (FImages <> nil) and (ImageIndex >= 0) and (ImageIndex < FImages.Count)
              then
                begin
                  TR.Left := TR.Left + FImages.Width;
                end;
              TR1 := TR;
              DrawText(Buffer.Canvas.Handle, PChar(Caption), Length(Caption), TR1,
                DT_EXPANDTABS or DT_WORDBREAK  or DT_CALCRECT);
              TY := Height div 2 - RectHeight(TR1) div 2;
              if TY < 0 then TY := 0;
              TR1 := Rect(TR1.Left, TY, TR1.Right, TY + RectHeight(TR1));
              TR := ClientRect;
            end;
          OffsetRect(TR, IX + RectWidth(CheckIMageRect) + 4, Height div 2 - RectHeight(TR) div 2);
          if TR.Right > Width - 2 then TR.Right := Width - 2;
          //
          if (FImages <> nil) and (ImageIndex >= 0) and (ImageIndex < FImages.Count)
          then
            begin
              ImX := TR.Left;
              ImY := Height div 2 - FImages.Height div 2;
              FIMages.Draw(Buffer.Canvas, ImX, ImY, FImageIndex, Enabled);
              OffsetRect(TR, FImages.Width + 8, 0);
            end;
          //
          Brush.Style := bsClear;
          if not Enabled
          then Font.Color := UnEnabledFontColor
          else Font.Color := FrameFontColor;
          if FWordWrap
          then
            DrawText(Buffer.Canvas.Handle, PChar(Caption), Length(Caption), TR1,
               DT_EXPANDTABS or DT_WORDBREAK)
          else
            BSDrawText(Buffer.Canvas, Caption, TR);
          // drawfocus
          InflateRect(TR, 2, 1);
          Inc(TR.Right, 1 );
          Brush.Style := bsSolid;
          if IsFocused
          then
            if Caption <> ''
            then
              begin
                Brush.Color := FSD.SkinColors.cBtnFace;
                if FWordWrap
                then
                  begin
                    InflateRect(TR1, 2, 1);
                    DrawFocusRect(TR1);
                  end
                else
                  DrawFocusRect(TR)
              end
            else
              if (FImages <> nil) and (ImageIndex >= 0) and (ImageIndex < FImages.Count)
              then
                begin
                  Brush.Color := FSD.SkinColors.cBtnFace;
                  DrawFocusRect(Rect(ImX - 1, ImY - 1,
                    ImX + FImages.Width + 1, ImY + FImages.Height + 1));
                end;
        end;
      Self.Canvas.Draw(0, 0, Buffer);
      Buffer.Free;
    end
  else
  if FIndex = -1
  then
    inherited
  else
    if EnableMorphing and (FMorphKf < 1) and (FMorphKf > 0)
    then
      begin
        Buffer := TBitMap.Create;
        ABuffer := TBitMap.Create;
        CreateImage(Buffer, SkinRect, False);
        CreateImage(ABuffer, ActiveSkinRect, True);
        PBuffer := TbsEffectBmp.CreateFromhWnd(Buffer.Handle);
        APBuffer := TbsEffectBmp.CreateFromhWnd(ABuffer.Handle);
        case MorphKind of
          mkDefault: PBuffer.Morph(APBuffer, FMorphKf);
          mkGradient: PBuffer.MorphGrad(APBuffer, FMorphKf);
          mkLeftGradient: PBuffer.MorphLeftGrad(APBuffer, FMorphKf);
          mkRightGradient: PBuffer.MorphRightGrad(APBuffer, FMorphKf);
          mkLeftSlide: PBuffer.MorphLeftSlide(APBuffer, FMorphKf);
          mkRightSlide: PBuffer.MorphRightSlide(APBuffer, FMorphKf);
          mkPush: PBuffer.MorphPush(APBuffer, FMorphKf);
        end;
        PBuffer.Draw(Canvas.Handle, 0, 0);
        PBuffer.Free;
        APBuffer.Free;
        Buffer.Free;
        ABuffer.Free;
      end
    else
      begin
        Buffer := TBitMap.Create;
        Buffer.Width := Width;
        Buffer.Height := Height;
        if FMouseIn or IsFocused
        then CreateImage(Buffer, ActiveSkinRect, FMouseIn or IsFocused)
        else CreateImage(Buffer, SkinRect, FMouseIn or IsFocused);
        Canvas.Draw(0, 0, Buffer);
        Buffer.Free;
     end;
end;

function TbsSkinCheckRadioBox.IsFocused;
begin
  Result := Focused and FCanFocused;
end;

procedure TbsSkinCheckRadioBox.SetCheckState;
begin
  if FRadio
  then
    begin
      if not Checked
      then
        Checked := True;
    end
  else
    begin
      Checked := not FChecked;
    end;
end;

procedure TbsSkinCheckRadioBox.CMDialogChar;
begin
  with Message do
    if IsAccel(CharCode, Caption) and CanFocus and FCanFocused
    then
      begin
        SetFocus;
        SetCheckState;
        Result := 1;
      end
    else
     inherited;
end;

procedure TbsSkinCheckRadioBox.SetCanFocused;
begin
  FCanFocused := Value;
  if FCanFocused then TabStop := True else TabStop := False;
end;

procedure TbsSkinCheckRadioBox.WMSETFOCUS;
begin
  inherited;
  if FCanFocused
  then
    if FFlat then Invalidate else ReDrawControl;
end;

procedure TbsSkinCheckRadioBox.WMKILLFOCUS;
begin
  inherited;
  if FCanFocused
  then
    if FFlat then Invalidate else ReDrawControl;
end;

procedure TbsSkinCheckRadioBox.WMEraseBkgnd;
begin
  if not FromWMPaint and not Flat
  then
    PaintWindow(Msg.DC);
end;

procedure TbsSkinCheckRadioBox.WndProc(var Message: TMessage);
begin
  if FCanFocused then
  case Message.Msg of
    WM_KEYUP:
      if IsFocused then
        with TWMKeyUp(Message) do
        begin
          if CharCode = VK_SPACE then SetCheckState;
        end;
    WM_LBUTTONDOWN, WM_LBUTTONDBLCLK:
      if not (csDesigning in ComponentState) and not Focused then
      begin
        FClicksDisabled := True;
        Windows.SetFocus(Handle);
        FClicksDisabled := False;
        if not Focused then Exit;
      end;
    CN_COMMAND:
      if FClicksDisabled then Exit;
  end;
  inherited WndProc(Message);
end;

procedure TbsSkinCheckRadioBox.ActionChange(Sender: TObject; CheckDefaults: Boolean);
begin
  inherited ActionChange(Sender, CheckDefaults);
  if Sender is TCustomAction then
    with TCustomAction(Sender) do
    begin
      if not CheckDefaults or (Self.Checked = False) then
        Self.Checked := Checked;
    end;
end;

procedure TbsSkinCheckRadioBox.SetRadio;
begin
  FRadio := Value;
  if (csDesigning in ComponentState) and not
     (csLoading in ComponentState)
  then
    begin
      if FRadio
      then
        begin
          FSkinDataName := 'radiobox';
          FGroupIndex := 1;
        end
      else
        begin
          FSkinDataName := 'checkbox';
          FGroupIndex := 0;
        end;
    end;
  RePaint;
end;

procedure TbsSkinCheckRadioBox.CalcSize;
var
  NewCIArea: TRect;
  Offset: Integer;
  CIW, CIH: Integer;
begin
  if FFlat then Exit;
  inherited;
  Offset := W - RectWidth(SkinRect);
  NewTextArea := TextArea;
  Inc(NewTextArea.Right, Offset);
  NewCIArea := CheckImageArea;
  if CheckImageArea.Right > TextArea.Right
  then
    OffsetRect(NewCIArea, Offset, 0);
  CIW := RectWidth(CheckImageRect);
  CIH := RectHeight(CheckImageRect);
  CIRect.Left := NewCIArea.Left + RectWidth(NewCIArea) div 2 - CIW div 2;
  CIRect.Top := NewCIArea.Top + RectHeight(NewCIArea) div 2 - CIH div 2;
  CIRect.Right := CIRect.Left + CIW;
  CIRect.Bottom := CIRect.Top + CIH;
end;

procedure TbsSkinCheckRadioBox.SetChecked;
begin
  FChecked := Value;
  if FChecked then FState := cbChecked else
  if FState = cbChecked then  FState := cbUnChecked;
  RePaint;
  if FChecked and (GroupIndex <> 0) then UnCheckAll;
  if (FRadio and FChecked) or not FRadio
  then
    if Assigned(FOnClick) then FOnClick(Self);
end;

procedure TbsSkinCheckRadioBox.ReDrawControl;
begin
  if EnableMorphing and (FIndex <> -1)
  then StartMorph
  else RePaint;
end;

procedure TbsSkinCheckRadioBox.UnCheckAll;
var
  PC: TWinControl;
  i: Integer;
begin
  if Parent = nil then Exit;
  PC := TWinControl(Parent);
  for i := 0 to PC.ControlCount - 1 do
   if (PC.Controls[i] is TbsSkinCheckRadioBox) and
      (PC.Controls[i] <> Self)
   then
     with TbsSkinCheckRadioBox(PC.Controls[i]) do
       if (GroupIndex = Self.GroupIndex) and
          (GroupIndex <> 0) and Checked
       then
         Checked := False;
end;

procedure TbsSkinCheckRadioBox.ChangeSkinData;
begin
  if FFlat
  then
    begin
      GetSkinData;
      RePaint;
    end
  else
   inherited;
end;

procedure TbsSkinCheckRadioBox.GetSkinData;
begin
  inherited;
  if FIndex <> -1
  then
    begin
      if TbsDataSkinControl(FSD.CtrlList.Items[FIndex]) is TbsDataSkinCheckRadioControl
      then
        with TbsDataSkinCheckRadioControl(FSD.CtrlList.Items[FIndex]) do
        begin
          Self.FontName := FontName;
          Self.FontColor := FontColor;
          Self.ActiveFontColor := ActiveFontColor;
          Self.FrameFontColor := FrameFontColor;
          Self.UnEnabledFontColor := UnEnabledFontColor;
          Self.FontStyle := FontStyle;
          Self.FontHeight := FontHeight;
          Self.ActiveSkinRect := ActiveSkinRect;
          if IsNullRect(ActiveSkinRect) then Self.ActiveSkinRect := SkinRect;
          Self.CheckImageArea := CheckImageArea;
          Self.TextArea := TextArea;
          Self.CheckImageRect := CheckImageRect;
          Self.UnCheckImageRect := UnCheckImageRect;
          Self.ActiveCheckImageRect := ActiveCheckImageRect;
          Self.UnEnabledCheckImageRect := UnEnabledCheckImageRect;
          Self.UnEnabledUnCheckImageRect := UnEnabledUnCheckImageRect;
          if IsNullRect(UnEnabledCheckImageRect)
          then
            Self.UnEnabledCheckImageRect := CheckImageRect;
          if IsNullRect(UnEnabledUnCheckImageRect)
          then
            Self.UnEnabledUnCheckImageRect := UnCheckImageRect;
          if IsNullRect(ActiveCheckImageRect)
          then
            Self.ActiveCheckImageRect := CheckImageRect;
          Self.ActiveUnCheckImageRect := ActiveUnCheckImageRect;
          if IsNullRect(ActiveUnCheckImageRect)
          then
            Self.ActiveUnCheckImageRect := UnCheckImageRect;
          Self.Morphing := Morphing;
          Self.MorphKind := MorphKind;
          if FFlat
          then
            begin
              Self.Morphing := False;
              MaskPicture := nil;
            end;
        end;
     end;
end;

procedure TbsSkinCheckRadioBox.CreateImage2(B: TBitMap; R: TRect; AChecked: Boolean);
var
  IX, IY: Integer;
begin
  CreateSkinControlImage(B, Picture, R);
  with B.Canvas do
  begin
    IX := CIRect.Left;
    IY := CIRect.Top + RectHeight(CIRect) div 2 - RectHeight(CheckImageRect) div 2;
    if not Enabled
    then
      begin
        if FState = cbGrayed
        then
          SkinDrawGrayedCheckImage(IX, IY, Picture.Canvas, UnEnabledCheckImageRect, B.Canvas)
        else
        if AChecked
        then
          SkinDrawCheckImage(IX, IY, Picture.Canvas, UnEnabledCheckImageRect, B.Canvas)
        else
          SkinDrawCheckImage(IX, IY, Picture.Canvas, UnEnabledUnCheckImageRect, B.Canvas);
      end
    else
      begin
        if FState = cbGrayed
        then
          SkinDrawGrayedCheckImage(IX, IY, Picture.Canvas, CheckImageRect, B.Canvas)
        else
         if AChecked
        then
          SkinDrawCheckImage(IX, IY, Picture.Canvas, CheckImageRect, B.Canvas)
        else
          SkinDrawCheckImage(IX, IY, Picture.Canvas, UnCheckImageRect, B.Canvas);
      end;

    if FUseSkinFont
    then
      begin
        Font.Name := FontName;
        Font.Height := FontHeight;
        Font.Style := FontStyle;
      end
    else
      Font.Assign(FDefaultFont);
    if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
    then
      Font.Charset := SkinData.ResourceStrData.CharSet
    else
      Font.CharSet := FDefaultFont.Charset;
    Font.Color := FontColor;
    if not Enabled then Font.Color := UnEnabledFontColor;
    Brush.Style := bsClear;
  end;
  BSDrawText(B.Canvas, Caption, NewTextArea);
end;


procedure TbsSkinCheckRadioBox.CreateImage;
var
  IX, IY: Integer;
begin
  CreateSkinControlImage(B, Picture, R);
  with B.Canvas do
  begin
    IX := CIRect.Left;
    IY := CIRect.Top + RectHeight(CIRect) div 2 - RectHeight(CheckImageRect) div 2;
    if not Enabled
    then
      begin
        if FState = cbGrayed
        then
          SkinDrawGrayedCheckImage(IX, IY, Picture.Canvas, UnEnabledCheckImageRect, B.Canvas)
        else
        if FChecked
        then
          SkinDrawCheckImage(IX, IY, Picture.Canvas, UnEnabledCheckImageRect, B.Canvas)
        else
          SkinDrawCheckImage(IX, IY, Picture.Canvas, UnEnabledUnCheckImageRect, B.Canvas);
      end
    else
    if FMouseIn
    then
      begin
        if FState = cbGrayed
        then
          SkinDrawGrayedCheckImage(IX, IY, Picture.Canvas, ActiveCheckImageRect, B.Canvas)
        else
        if FChecked
        then
          SkinDrawCheckImage(IX, IY, Picture.Canvas, ActiveCheckImageRect, B.Canvas)
        else
          SkinDrawCheckImage(IX, IY, Picture.Canvas, ActiveUnCheckImageRect, B.Canvas);
      end
    else
      begin
        if FState = cbGrayed
        then
          SkinDrawGrayedCheckImage(IX, IY, Picture.Canvas, CheckImageRect, B.Canvas)
        else
        if FChecked
        then
          SkinDrawCheckImage(IX, IY, Picture.Canvas, CheckImageRect, B.Canvas)
        else
          SkinDrawCheckImage(IX, IY, Picture.Canvas, UnCheckImageRect, B.Canvas);
      end;

    if FUseSkinFont
    then
      begin
        Font.Name := FontName;
        Font.Height := FontHeight;
        Font.Style := FontStyle;
      end
    else
      Font.Assign(FDefaultFont);
    if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
    then
      Font.Charset := SkinData.ResourceStrData.CharSet
    else
      Font.CharSet := FDefaultFont.Charset;
    if AMouseIn
    then Font.Color := ActiveFontColor
    else Font.Color := FontColor;
    if not Enabled then Font.Color := UnEnabledFontColor;
    Brush.Style := bsClear;
  end;
  BSDrawText(B.Canvas, Caption, NewTextArea);
end;

procedure TbsSkinCheckRadioBox.CreateControlDefaultImage(B: TBitMap);
var
  R, IR, TR: TRect;
  C: TColor;
begin
  inherited;
  if isFocused or FMouseIn
  then
    begin
      R := ClientRect;
      Frame3D(B.Canvas, R, clbtnShadow, clbtnShadow, 1);
    end;
  with B.Canvas do
  begin
    Font.Assign(DefaultFont);
    if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
    then
      Font.Charset := SkinData.ResourceStrData.CharSet;
    if not Enabled then Font.Color := clBtnShadow;
    Pen.Color := clBlack;
    Brush.Style := bsClear;
    IR := Rect(3, Height div 2 - 7, 17, Height div 2 + 7);
    TR := Rect(19, 0, Width, Height);
    BSDrawText(B.Canvas, Caption, TR);
  end;

  if FMouseIn
  then
    Frame3D(B.Canvas, IR, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1)
  else
    Frame3D(B.Canvas, IR, clbtnShadow, clbtnShadow, 1);

  if (FState = cbGrayed) and not FRadio
  then
    begin
      C := clGrayText;
      DrawCheckImage(B.Canvas, 7, Height div 2 - 4, C);
    end
  else
  if FChecked
  then
    begin
      if Enabled then C := clBlack else C := clBtnShadow;
      if FRadio
      then DrawRadioImage(B.Canvas, 7, Height div 2 - 3, C)
      else DrawCheckImage(B.Canvas, 7, Height div 2 - 4, C);
    end;
end;

procedure TbsSkinCheckRadioBox.CMTextChanged;
begin
  inherited;
  RePaint;
end;

procedure TbsSkinCheckRadioBox.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  if (csDesigning in ComponentState) then Exit;
  FMouseIn := True;
  ReDrawControl;
end;

procedure TbsSkinCheckRadioBox.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  if (csDesigning in ComponentState) then Exit;
  FMouseIn := False;
  ReDrawControl;
end;

procedure TbsSkinCheckRadioBox.MouseDown;
begin
  if not FMouseIn
  then
    begin
      FMouseIn := True;
      RedrawControl;
    end;
  inherited;
end;

procedure TbsSkinCheckRadioBox.MouseUp;
begin
  inherited;
  if (Button = mbLeft) and FMouseIn
  then
    begin
      if (not FAllowGrayed) or FRadio
      then
        SetCheckState
      else
        begin
          if FState = cbUnchecked
          then
            begin
              FState := cbGrayed;
              RePaint;
              if Assigned(FOnClick) then FOnClick(Self);
            end
          else
            SetCheckState;
        end;
    end;
end;

constructor TbsSkinGauge.Create;
begin
  inherited;
  FUseSkinSize := True;
  FMinValue := 0;
  FMaxValue := 100;
  FValue := 50;
  FVertical := False;
  Width := 100;
  Height := 20;
  BeginOffset := 0;
  EndOffset := 0;
  FProgressText := '';
  FShowPercent := False;
  FShowProgressText := False;
  FSkinDataName := 'gauge';
end;

function TbsSkinGauge.GetPaintValue: Integer;
begin
  Result := FValue;
end;

procedure TbsSkinGauge.WMEraseBkgnd;
begin
  if not FromWMPaint
  then
    PaintWindow(Msg.DC);
end;

procedure TbsSkinGauge.Paint;
var
  B1, B2: TBitMap;
  V: Integer;
begin
  if csPaintCopy in ControlState
  then
    begin
      V := GetPaintValue;
    end
  else
    V := FValue;
  if FUseSkinSize or (FIndex = -1)
  then
    inherited
  else
    begin
      B1 := TBitMap.Create;
      B1.Width := Width;
      B1.Height := Height;
      B2 := TBitMap.Create;
      GetSkinData;
      CreateControlSkinImage(B2);
      B1.Canvas.StretchDraw(Rect(0, 0, B1.Width, B1.Height), B2);
      B2.Free;
      DrawProgressText(B1.Canvas, V);
      Canvas.Draw(0, 0, B1);
      B1.Free;
    end;
end;

procedure TbsSkinGauge.DrawProgressText;
var
  Percent: Integer;
  S: String;
  TX, TY: Integer;
  F: TLogFont;
begin
  if (FIndex = -1)
  then
    C.Font.Assign(FDefaultFont)
  else
  if (FIndex <> -1) and not FUseSkinFont
  then
    begin
      C.Font.Assign(FDefaultFont);
      C.Font.Color := FontColor;
    end
  else
    with C do
    begin
      Font.Name := FontName;
      Font.Height := FontHeight;
      Font.Style := FontStyle;
      Font.Color := FontColor;
    end;

   if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
   then
     C.Font.Charset := SkinData.ResourceStrData.CharSet
   else
     C.Font.CharSet := FDefaultFont.Charset;

  if MaxValue = MinValue
  then
    Percent := 0
  else
    Percent := Trunc((AValue - FMinValue) / (FMaxValue - FMinValue) * 100);
//  if (Percent = 100) and (AValue <> FMaxValue) then Percent := 99;
  S := '';
  if FShowProgressText then S := S + FProgressText;
  if FShowPercent then S := S + IntToStr(Percent) + '%';
  if S = '' then Exit;
  with C do
  begin
    if FVertical
    then
      begin
        GetObject(Font.Handle, SizeOf(F), @F);
        F.lfEscapement := round(900);
        Font.Handle := CreateFontIndirect(F);
        TX := Width div 2 - TextHeight(S) div 2;
        TY := Height div 2 + TextWidth(S) div 2;
      end
    else
      begin
        TX := Width div 2 - TextWidth(S) div 2;
        TY := Height div 2 - TextHeight(S) div 2;
      end;
    Brush.Style := bsClear;
    TextOut(TX, TY, S);
  end;
end;

procedure TbsSkinGauge.SetShowProgressText;
begin
  FShowProgressText := Value;
  RePaint;
end;

procedure TbsSkinGauge.SetShowPercent;
begin
  FShowPercent := Value;
  RePaint;
end;

procedure TbsSkinGauge.SetProgressText;
begin
  FProgressText := Value;
  RePaint;
end;

function TbsSkinGauge.CalcProgressRect;
var
  kf: Double;
  Offset: Integer;
begin
   if FMinValue = FMaxValue
  then
    Kf := 0
  else
    kf := (AValue - FMinValue) / (FMaxValue - FMinValue);
  if FVertical
  then
    begin
      Offset := Trunc(RectHeight(R) * kf);
      R.Top := R.Bottom - Offset;
      Result := R;
    end
  else
    begin
      Offset := Trunc(RectWidth(R) * kf);
      R.Right := R.Left + Offset;
      Result := R;
    end;
end;

procedure TbsSkinGauge.CalcSize;
var
  Offset: Integer;
  W1, H1: Integer;
begin
  if not FUseSkinSize
  then
    begin
      W1 := W;
      H1 := H;
    end;  
  inherited;
  if ResizeMode > 0
  then
    begin
      if FVertical
      then
        begin
          Offset := H - RectHeight(SkinRect);
          NewProgressArea := ProgressArea;
          Inc(NewProgressArea.Bottom, Offset);
        end
      else
        begin
          Offset := W - RectWidth(SkinRect);
          NewProgressArea := ProgressArea;
          Inc(NewProgressArea.Right, Offset);
        end
    end
  else
    NewProgressArea := ProgressArea;
  if not FUseSkinSize
  then
    begin
      W := W1;
      H := H1;
    end;
end;

procedure TbsSkinGauge.CreateControlSkinImage;
var
  PR, PR1, PR2: TRect;
  i, Cnt, Off: Integer;
  w1, w2: Integer;
  B1, Buffer, Buffer2: TBitMap;
  V: Integer;
begin
  inherited;

  if csPaintCopy in ControlState
  then
    begin
      V := GetPaintValue;
    end
  else
    V := FValue;

  PR := CalcProgressRect(NewProgressArea, FVertical, V);
  if (RectHeight(PR) = 0) or (RectWidth(PR) = 0)
  then
    begin
      if FUseSkinSize then DrawProgressText(B.Canvas, V);
      Exit;
    end;

  Buffer := TBitMap.Create;
  Buffer.Width := RectWidth(PR);
  Buffer.Height := RectHeight(PR);
  
  with Buffer.Canvas do
  begin
    if FVertical
    then
      begin
        if RectHeight(PR) - BeginOffset - EndOffset > 0
        then
          begin
            PR1 := Rect(0, 0, Buffer.Width, Buffer.Height);
            Inc(PR1.Top, BeginOffset);
            Dec(PR1.Bottom, EndOffset);
            PR2 := ProgressRect;
            Inc(PR2.Top, BeginOffset);
            Dec(PR2.Bottom, EndOffset);
            w1 := RectHeight(PR1);
            w2 := RectHeight(PR2);
            if w2 = 0 then Exit;
            Cnt := w1 div w2;
            if (ProgressStretch)
            then
              begin
                if (RectWidth(PR2) > 0) and (RectHeight(PR2) > 0)
                then
                  begin
                    Buffer2 := TBitMap.Create;
                    Buffer2.Width := RectWidth(PR2);
                    Buffer2.Height := RectHeight(PR2);
                    Buffer2.Canvas.CopyRect(Rect(0, 0, Buffer2.Width, Buffer2.Height),
                                            Picture.Canvas, PR2);
                    StretchDraw(PR1, Buffer2);
                    Buffer2.Free;
                  end;
              end
            else
            for i := 0 to Cnt do
            begin
              if i * w2 + w2 > w1 then Off := i * w2 + w2 - w1 else Off := 0;
                CopyRect(Rect(PR1.Left, PR1.Bottom - (i * w2 + w2 - Off),
                              PR1.Right, PR1.Bottom - i * w2),
                         Picture.Canvas,
                         Rect(PR2.Left, PR2.Top + Off,
                              PR2.Right, PR2.Bottom));
            end;
          end;

         PR1 := Rect(0, 0, Buffer.Width, Buffer.Height);

         CopyRect(Rect(PR1.Left, PR1.Top,
                  PR1.Right, PR1.Top + BeginOffset),
                  Picture.Canvas,
                  Rect(ProgressRect.Left, ProgressRect.Top,
                  ProgressRect.Right, ProgressRect.Top + BeginOffset));

         CopyRect(Rect(PR1.Left, PR1.Bottom - EndOffset,
                  PR1.Right, PR1.Bottom),
                  Picture.Canvas,
                  Rect(ProgressRect.Left, ProgressRect.Bottom - EndOffset,
                  ProgressRect.Right, ProgressRect.Bottom));
      end
    else
      begin
        if RectWidth(PR) - BeginOffset - EndOffset > 0
        then
          begin
            PR1 := Rect(0, 0, Buffer.Width, Buffer.Height);
            Inc(PR1.Left, BeginOffset);
            Dec(PR1.Right, EndOffset);
            PR2 := ProgressRect;
            Inc(PR2.Left, BeginOffset);
            Dec(PR2.Right, EndOffset);
            w1 := RectWidth(PR1);
            w2 := RectWidth(PR2);
            if w2 = 0 then Exit;
            Cnt := w1 div w2;
            if ProgressStretch
            then
              begin
                if (RectWidth(PR1) > 0) and (RectHeight(PR1) > 0)
                then
                  begin
                    Buffer2 := TBitMap.Create;
                    Buffer2.Width := RectWidth(PR2);
                    Buffer2.Height := RectHeight(PR2);
                    Buffer2.Canvas.CopyRect(Rect(0, 0, Buffer2.Width, Buffer2.Height),
                                            Picture.Canvas, PR2);
                    StretchDraw(PR1, Buffer2);
                    Buffer2.Free;
                  end;
              end
            else
            for i := 0 to Cnt do
            begin
              if i * w2 + w2 > w1 then Off := i * w2 + w2 - w1 else Off := 0;
                CopyRect(Rect(PR1.Left + i * w2, PR1.Top,
                         PR1.Left + i * w2 + w2 - Off, PR1.Bottom),
                     Picture.Canvas,
                     Rect(PR2.Left, PR2.Top, PR2.Right - Off, PR2.Bottom));
            end;
          end;

        PR1 := Rect(0, 0, Buffer.Width, Buffer.Height);
        
        CopyRect(Rect(PR1.Left, PR1.Top,
                 PR1.Left + BeginOffset, PR1.Bottom),
                 Picture.Canvas,
                 Rect(ProgressRect.Left, ProgressRect.Top,
                 ProgressRect.Left + BeginOffset, ProgressRect.Bottom));
        CopyRect(Rect(PR1.Right - EndOffset, PR1.Top,
                 PR1.Right, PR1.Bottom),
                 Picture.Canvas,
                 Rect(ProgressRect.Right - EndOffset, ProgressRect.Top,
                 ProgressRect.Right, ProgressRect.Bottom));
      end;
  end;

  if ProgressTransparent
  then
    begin
      Buffer.Transparent := True;
      Buffer.TransparentMode := tmFixed;
      Buffer.TransparentColor := ProgressTransparentColor;
    end;

  B.Canvas.Draw(PR.Left, PR.Top, Buffer);

  Buffer.Free;

  if FUseSkinSize then DrawProgressText(B.Canvas, V);
end;

procedure TbsSkinGauge.CreateImage;
begin
  CreateSkinControlImage(B, Picture, SkinRect);
end;

procedure TbsSkinGauge.CreateControlDefaultImage(B: TBitMap);
var
  R, PR: TRect;
  V: Integer;
begin
  if csPaintCopy in ControlState
  then
    begin
      V := GetPaintValue;
    end
  else
    V := FValue;
  R := ClientRect;
  B.Canvas.Brush.Color := clWindow;
  B.Canvas.FillRect(R);
  Frame3D(B.Canvas, R, clbtnShadow, clbtnShadow, 1);
  R := Rect(1, 1, Width - 1, Height - 1);
  PR := CalcProgressRect(R, FVertical, V);
  if not IsNullRect(PR)
  then
    begin
      B.Canvas.Brush.Color := BS_XP_BTNACTIVECOLOR;
      B.Canvas.FillRect(PR);
    end;
  DrawProgressText(B.Canvas, V);
end;

procedure TbsSkinGauge.SetVertical;
var
  S: Integer;
begin
  FVertical:= AValue;
  if (csDesigning in ComponentState) and not
     (csLoading in ComponentState)
  then
    begin
      if FVertical
      then
        begin
          FSkinDataName := 'vgauge';
          if Width > Height
          then
            begin
              S := Width;
              Width := Height;
              Height := S;
            end;
          FDefaultWidth := FDefaultHeight;
          FDefaultHeight := 0;
        end
      else
        begin
          FSkinDataName := 'gauge';
          if Width < Height
          then
            begin
              S := Width;
              Width := Height;
              Height := S;
            end;
          FDefaultHeight := FDefaultWidth;
          FDefaultWidth := 0;
        end;
    end;
end;

procedure TbsSkinGauge.SetMinValue;
begin
  FMinValue := AValue;
  if FValue < FMinValue then FValue := FMinValue;
  RePaint;
end;

procedure TbsSkinGauge.SetMaxValue;
begin
  FMaxValue := AValue;
  if FValue > FMaxValue then FValue := FMaxValue;
  RePaint;
end;

procedure TbsSkinGauge.SetValue;
begin
  if AValue > FMaxValue
  then AValue := FMaxValue else
  if AValue < FMinValue
  then AValue := FMinValue;
  if AValue <> FValue
  then
    begin
      FValue := AValue;
      // RePaint;
      Invalidate;
    end;
end;

procedure TbsSkinGauge.GetSkinData;
begin
  inherited;
  if FIndex <> -1
  then
    if TbsDataSkinControl(FSD.CtrlList.Items[FIndex]) is TbsDataSkinGaugeControl
    then
      with TbsDataSkinGaugeControl(FSD.CtrlList.Items[FIndex]) do
      begin
        if not FUseSkinSize and (MaskPictureIndex <> -1)
        then
          MaskPicture := nil;
        Self.FVertical := Vertical;
        Self.ProgressRect := ProgressRect;
        Self.ProgressArea := ProgressArea;
        Self.BeginOffset := BeginOffset;
        Self.EndOffset := EndOffset;
        Self.FontName := FontName;
        Self.FontStyle := FontStyle;
        Self.FontHeight := FontHeight;
        Self.FontColor := FontColor;
        Self.ProgressTransparent := ProgressTransparent;
        Self.ProgressTransparentColor := ProgressTransparentColor;
        Self.ProgressStretch := ProgressStretch;
      end;
end;

constructor TbsSkinTrackBar.Create;
begin
  inherited;
  FJumpWhenClick := False;
  FCanFocused := False;
  TabStop := False;
  FMinValue := 0;
  FMaxValue := 100;
  FValue := 50;
  FVertical := False;
  Width := 100;
  Height := 20;
  FMouseSupport := True;
  FDown := False;
  FSkinDataName := 'htrackbar';
end;

procedure TbsSkinTrackBar.WMEraseBkgnd;
begin
  if not FromWMPaint
  then
    PaintWindow(Msg.DC);
end;

procedure TbsSkinTrackBar.KeyDown;
begin
  inherited KeyDown(Key, Shift);
  if FCanFocused then
  case Key of
    VK_UP, VK_RIGHT:
      begin
        Value := Value + 1;
        if Assigned(FOnLastChange) then FOnLastChange(Self);
      end;
    VK_DOWN, VK_LEFT:
     begin
       Value := Value - 1;
       if Assigned(FOnLastChange) then FOnLastChange(Self);
     end;
  end;
end;

procedure TbsSkinTrackBar.WMMOUSEWHEEL;
begin
  if IsFocused
  then
    if Vertical
    then
      begin
        if Message.WParam > 0
        then
          Value := Value + 1
        else
          Value := Value - 1;
        if Assigned(FOnLastChange) then FOnLastChange(Self);
      end
    else
      begin
        if Message.WParam > 0
        then
          Value := Value - 1
        else
          Value := Value + 1;
        if Assigned(FOnLastChange) then FOnLastChange(Self);  
      end;
end;

procedure TbsSkinTrackBar.CMWantSpecialKey(var Msg: TCMWantSpecialKey);
begin
  inherited;
  if FCanFocused then 
  case Msg.CharCode of
    VK_UP, VK_DOWN, VK_LEFT, VK_RIGHT: Msg.Result := 1;
  end;
end;

function TbsSkinTrackBar.IsFocused;
begin
  Result := Focused and FCanFocused;
end;

procedure TbsSkinTrackBar.SetCanFocused;
begin
  FCanFocused := Value;
  if FCanFocused then TabStop := True else TabStop := False;
end;

procedure TbsSkinTrackBar.WMSETFOCUS;
begin
  inherited;
  if FCanFocused then RePaint;
end;

procedure TbsSkinTrackBar.WMKILLFOCUS;
begin
  inherited;
  if FCanFocused then RePaint;
end;

procedure TbsSkinTrackBar.WndProc(var Message: TMessage);
begin
  if FCanFocused then
  case Message.Msg of
    WM_LBUTTONDOWN, WM_LBUTTONDBLCLK:
      if not (csDesigning in ComponentState) and not Focused then
      begin
        FClicksDisabled := True;
        Windows.SetFocus(Handle);
        FClicksDisabled := False;
        if not Focused then Exit;
      end;
    CN_COMMAND:
      if FClicksDisabled then Exit;
  end;
  inherited WndProc(Message);
end;

function TbsSkinTrackBar.CalcValue;
var
  kf: Double;
begin
  if (Offset2 - Offset1) <= 0
  then kf := 0
  else kf := AOffset / (Offset2 - Offset1);
  if kf > 1 then kf := 1 else
  if kf < 0 then kf := 0;
  Result := FMinValue + Round((FMaxValue - FMinValue) * kf);
end;

function TbsSkinTrackBar.CalcButtonRect;
var
  kf: Double;
  BW, BH: Integer;
begin
  if FMinValue = FMaxValue
  then
    Kf := 0
  else
    kf := (FValue - FMinValue) / (FMaxValue - FMinValue);
  if FIndex = -1
  then
    begin
      if FVertical
      then
        begin
          BW := Width - 4;
          BH := BW div 2;
        end
      else
        begin
          BH := Height - 4;
          BW := BH div 2;
         end;
    end
  else
    begin
      BW := RectWidth(ButtonRect);
      BH := RectHeight(ButtonRect);
    end;
  if FVertical
  then
    begin
      Offset1 := R.Top + BH div 2;
      Offset2 := R.Bottom - BH div 2;
      BOffset := Round((Offset2 - Offset1) * Kf);
      Result := Rect(R.Left + RectWidth(R) div 2 - BW div 2,
       Offset2 - BOffset - BH div 2,
       R.Left + RectWidth(R) div 2 - BW div 2 + BW,
       Offset2 - BOffset - BH div 2 + BH);
    end
  else
    begin
      Offset1 := R.Left + BW div 2;
      Offset2 := R.Right - BW div 2;
      BOffset := Round((Offset2 - Offset1) * kf);
      Result := Rect(Offset1 + BOffset - BW div 2,
        R.Top + RectHeight(R) div 2 - BH div 2,
        Offset1 + BOffset - BW div 2 + BW,
        R.Top + RectHeight(R) div 2 - BH div 2 + BH);
    end;
end;

procedure TbsSkinTrackBar.CalcSize;
var
  Offset: Integer;
begin
  inherited;
  if ResizeMode > 0
  then
    begin
      if FVertical
      then
        begin
          Offset := H - RectHeight(SkinRect);
          NewTrackArea := TrackArea;
          Inc(NewTrackArea.Bottom, Offset);
        end
      else
        begin
          Offset := W - RectWidth(SkinRect);
          NewTrackArea := TrackArea;
          Inc(NewTrackArea.Right, Offset);
        end
    end
  else
    NewTrackArea := TrackArea;
end;

procedure TbsSkinTrackBar.CreateControlSkinImage;
var
  B1: TBitMap;
begin
  inherited;
  BR := CalcButtonRect(NewTrackArea);

  B1 := TBitMap.Create;
  B1.Width := RectWidth(BR);
  B1.Height := RectHeight(BR);

  with B1.Canvas do
   if FDown or IsFocused
    then
      CopyRect(Rect(0, 0, B1.Width, B1.Height),
             Picture.Canvas, ActiveButtonRect)
     else
       CopyRect(Rect(0, 0, B1.Width, B1.Height),
             Picture.Canvas, ButtonRect);

  if ButtonTransparent
  then
    begin
      B1.Transparent := True;
      B1.TransparentMode := tmFixed;
      B1.TransparentColor := ButtonTransparentColor;
     end;

  B.Canvas.Draw(BR.Left, BR.Top, B1);
  B1.Free;
end;

procedure TbsSkinTrackBar.CreateImage;
begin
  CreateSkinControlImage(B, Picture, SkinRect);
end;

procedure TbsSkinTrackBar.MouseDown;
begin
  inherited;
  if FMouseSupport and
     PtInRect(Rect(BR.Left, BR.Top, BR.Right + 1, BR.Bottom + 1), Point(X, Y))
  then
    begin
      if FVertical then OMPos := Y else OMPos := X;
      OldBOffset := BOffset;
      FDown := True;
      RePaint;
      if Assigned(FOnStartDragButton) then FOnStartDragButton(Self);
    end;
end;

procedure TbsSkinTrackBar.MouseUp;
var
  Off: Integer;
  Off2: Integer;
begin
  inherited;
  if FMouseSupport and FDown
  then
    begin
      FDown := False;
      RePaint;
      if Assigned(FOnLastChange) then FOnLastChange(Self);
    end
  else
  if FMouseSupport and not FDown and FJumpWhenClick
  then
    begin
      if FIndex <> -1
      then
        begin
          if FVertical
          then
            Off2 := NewTrackArea.Top
          else
            Off2 := NewTrackArea.Left;
        end
      else
        Off2 := 2;
      if FVertical
      then
        Off := Height - Y - RectHeight(BR) div 2 - Off2
      else
        Off := X - RectWidth(BR) div 2 - Off2;
      Value := CalcValue(Off);
    end;
end;

procedure TbsSkinTrackBar.MouseMove;
var
  Off: Integer;
begin
  if FMouseSupport and FDown
  then
    begin
      if Vertical
      then
        begin
          Off := OMPos - Y;
          Off := OldBOffset + Off;
        end
      else
        begin
          Off := X - OMPos;
          Off := OldBOffset + Off;
        end;
      Value := CalcValue(Off);
    end;
  inherited;
end;


procedure TbsSkinTrackBar.CreateControlDefaultImage;
var
  R, LR, BR1: TRect;
begin
  inherited;
  R := ClientRect;
  Frame3D(B.Canvas, R, clbtnShadow, clbtnShadow, 1);
  R := Rect(2, 2, Width - 2, Height - 2);
  if FVertical
  then
    LR := Rect(Width div 2 - 1, 4, Width div 2 + 1, Height - 4)
  else
    LR := Rect(4, Height div 2 - 1, Width - 4, Height div 2 + 1);
  BR := CalcButtonRect(R);
  Frame3D(B.Canvas, LR, clbtnShadow, clbtnHighLight, 1);
  BR1 := BR;
  with B.Canvas do
  begin
    Brush.Style := bsSolid;
    if FDown
    then
      begin
        Frame3D(B.Canvas, BR1, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
        Brush.Color := BS_XP_BTNDOWNCOLOR;
        FillRect(BR1);
      end
    else
    if IsFocused
    then
      begin
        Frame3D(B.Canvas, BR1, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
        Brush.Color := BS_XP_BTNACTIVECOLOR;
        FillRect(BR1);
      end
    else
      begin
        Frame3D(B.Canvas, BR1, clBtnShadow, clBtnShadow, 1);
        Brush.Color := clBtnFace;
        FillRect(BR1);
      end;
  end;
end;

procedure TbsSkinTrackBar.SetVertical;
var
  S: Integer;
begin
  FVertical := AValue;
  if (csDesigning in ComponentState) and not
     (csLoading in ComponentState)
  then
    begin
      if FVertical
      then
        begin
          FSkinDataName := 'trackbar';
          if Width > Height
          then
            begin
              S := Width;
              Width := Height;
              Height := S;
            end;
          FDefaultWidth := FDefaultHeight;
          FDefaultHeight := 0;
        end
      else
        begin
          FSkinDataName := 'htrackbar';
          if Width < Height
          then
            begin
              S := Width;
              Width := Height;
              Height := S;
            end;
          FDefaultHeight := FDefaultWidth;
          FDefaultWidth := 0;
        end;
    end;
end;

procedure TbsSkinTrackBar.SetMinValue;
begin
  FMinValue := AValue;
  if FValue < FMinValue then FValue := FMinValue;
  RePaint;
end;

procedure TbsSkinTrackBar.SetMaxValue;
begin
  FMaxValue := AValue;
  if FValue > FMaxValue then FValue := FMaxValue;
  RePaint;
end;

procedure TbsSkinTrackBar.SetValue;
begin
  if AValue > MaxValue then AValue := MaxValue else
    if AValue < MinValue then AValue := MinValue;
  if AValue <> FValue
  then
    begin
      FValue := AValue;
      RePaint;
      if Assigned(FOnChange) then FOnChange(Self);
    end;
end;

procedure TbsSkinTrackBar.GetSkinData;
begin
  inherited;
  if FIndex <> -1
  then
    if TbsDataSkinControl(FSD.CtrlList.Items[FIndex]) is TbsDataSkinTrackBarControl
    then
      with TbsDataSkinTrackBarControl(FSD.CtrlList.Items[FIndex]) do
      begin
        Self.FVertical := Vertical;
        Self.ButtonRect := ButtonRect;
        if IsNullRect(ActiveButtonRect)
        then
          Self.ActiveButtonRect := ButtonRect
        else
          Self.ActiveButtonRect := ActiveButtonRect;
        Self.TrackArea := TrackArea;
        Self.ButtonTransparent := ButtonTransparent;
        Self.ButtonTransparentColor := ButtonTransparentColor;
      end;
end;


const
  ELLIPSSTYLE : array[TbsEllipsType] of DWORD = (0, DT_END_ELLIPSIS, DT_PATH_ELLIPSIS);

constructor TbsSkinStdLabel.Create;
begin
  inherited;
  FEllipsType := bsetNone;
  Transparent := True;
  FSD := nil;
  FSkinDataName := 'stdlabel';
  FDefaultFont := TFont.Create;
  FUseSkinFont := False;
  FUseSkinColor := True;
end;

destructor TbsSkinStdLabel.Destroy;
begin
  FDefaultFont.Free;
  inherited;
end;

procedure TbsSkinStdLabel.SetEllipsType(const Value: TbsEllipsType);
begin
  if FEllipsType <> Value
  then
    begin
      FEllipsType := Value;
      Invalidate;
    end;
end;

procedure TbsSkinStdLabel.PaintSkinTo;
const
  Alignments: array[TAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
  WordWraps: array[Boolean] of Word = (0, DT_WORDBREAK);
var
  Rect, CalcRect: TRect;
  DrawStyle: Longint;
begin
  with C do
  begin
    if not Transparent then
    begin
      Brush.Color := Self.Color;
      Brush.Style := bsSolid;
      FillRect(ClientRect);
    end;
    Brush.Style := bsClear;
    Rect := ClientRect;
    { DoDrawText takes care of BiDi alignments }
    DrawStyle := DT_EXPANDTABS or WordWraps[WordWrap] or Alignments[Alignment] or
      ELLIPSSTYLE[FEllipsType];
    { Calculate vertical layout }
    if Layout <> tlTop then
    begin
      CalcRect := Rect;
      DoDrawText2(C, CalcRect, DrawStyle or DT_CALCRECT, AText);
      if Layout = tlBottom then OffsetRect(Rect, 0, Height - CalcRect.Bottom)
      else OffsetRect(Rect, 0, (Height - CalcRect.Bottom) div 2);
    end;
    OffsetRect(Rect, X, Y);
    DoDrawText2(C, Rect, DrawStyle, AText);
  end;
end;

procedure TbsSkinStdLabel.DoDrawText2(C: TCanvas; var Rect: TRect; Flags: Longint; AText: String);
var
  LText: string;
begin
  GetSkinData;

  LText := AText;
  if (Flags and DT_CALCRECT <> 0) and ((LText = '') or ShowAccelChar and
    (LText[1] = '&') and (LText[2] = #0)) then LText := LText + ' ';
  if not ShowAccelChar then Flags := Flags or DT_NOPREFIX;

  Flags := Flags or ELLIPSSTYLE[FEllipsType];

  Flags := DrawTextBiDiModeFlags(Flags);

  if FIndex <> -1
  then
    with C.Font do
    begin
      if FUseSkinFont
      then
        begin
          Name := FontName;
          Style := FontStyle;
          Height := FontHeight;
        end
      else
        C.Font := Self.Font;
      if FUseSkinColor then Color := FontColor else Color := Self.Font.Color;
    end
  else
    if FUseSkinFont
    then
      C.Font := DefaultFont
    else
      C.Font := Self.Font;

  if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
  then
    C.Font.Charset := SkinData.ResourceStrData.CharSet
  else
    C.Font.CharSet := FDefaultFont.Charset;

  if not Enabled
  then
    begin
      OffsetRect(Rect, 1, 1);
      if FIndex <> -1
      then
        C.Font.Color := FSD.SkinColors.cBtnHighLight
      else
        C.Font.Color := clBtnHighlight;

      if Self.EllipsType <> bsetNone
      then
        DrawTextEx(C.Handle, PChar(LText), Length(LText), Rect, Flags, nil)
      else
        DrawText(C.Handle, PChar(LText), Length(LText), Rect, Flags);

      OffsetRect(Rect, -1, -1);
      if FIndex <> -1
      then
        C.Font.Color := FSD.SkinColors.cBtnShadow
      else
        C.Font.Color := clBtnShadow;

      if Self.EllipsType <> bsetNone
      then
        DrawTextEx(C.Handle, PChar(LText), Length(LText), Rect, Flags, nil)
      else
        DrawText(C.Handle, PChar(LText), Length(LText), Rect, Flags);
    end
  else
    if Self.EllipsType <> bsetNone
    then
      DrawTextEx(C.Handle, PChar(LText), Length(LText), Rect, Flags, nil)
    else
      DrawText(C.Handle, PChar(LText), Length(LText), Rect, Flags);
end;

procedure TbsSkinStdLabel.DoDrawText(var Rect: TRect; Flags: Longint);
var
  LText: string;
begin
  GetSkinData;

  LText := GetLabelText;
  if (Flags and DT_CALCRECT <> 0) and ((LText = '') or ShowAccelChar and
    (LText[1] = '&') and (LText[2] = #0)) then LText := LText + ' ';
  if not ShowAccelChar then Flags := Flags or DT_NOPREFIX;

  Flags := Flags or ELLIPSSTYLE[FEllipsType];

  Flags := DrawTextBiDiModeFlags(Flags);

  if FIndex <> -1
  then
    with Canvas.Font do
    begin
      if FUseSkinFont
      then
        begin
          Name := FontName;
          Style := FontStyle;
          Height := FontHeight;
        end
      else
        Canvas.Font := Self.Font;
      if FUseSkinColor then Color := FontColor else Color := Self.Font.Color;
    end
  else
    if FUseSkinFont
    then
      Canvas.Font := DefaultFont
    else
      Canvas.Font := Self.Font;

  if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
  then
    Canvas.Font.Charset := SkinData.ResourceStrData.CharSet
  else
    Canvas.Font.CharSet := FDefaultFont.Charset;

  if not Enabled
  then
    begin
      OffsetRect(Rect, 1, 1);
      if FIndex <> -1
      then
        Canvas.Font.Color := FSD.SkinColors.cBtnHighLight
      else
        Canvas.Font.Color := clBtnHighlight;

      if Self.EllipsType <> bsetNone
      then
        DrawTextEx(Canvas.Handle, PChar(LText), Length(LText), Rect, Flags, nil)
      else
        DrawText(Canvas.Handle, PChar(LText), Length(LText), Rect, Flags);

      OffsetRect(Rect, -1, -1);
      if FIndex <> -1
      then
        Canvas.Font.Color := FSD.SkinColors.cBtnShadow
      else
        Canvas.Font.Color := clBtnShadow;
      if Self.EllipsType <> bsetNone
      then
        DrawTextEx(Canvas.Handle, PChar(LText), Length(LText), Rect, Flags, nil)
      else
        DrawText(Canvas.Handle, PChar(LText), Length(LText), Rect, Flags);
    end
  else
    if Self.EllipsType <> bsetNone
    then
      DrawTextEx(Canvas.Handle, PChar(LText), Length(LText), Rect, Flags, nil)
    else
      DrawText(Canvas.Handle, PChar(LText), Length(LText), Rect, Flags);
end;

procedure TbsSkinStdLabel.SetDefaultFont;
begin
  FDefaultFont.Assign(Value);
end;

procedure TbsSkinStdLabel.Notification;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FSD) then FSD := nil;
end;

procedure TbsSkinStdLabel.GetSkinData;
begin
  if (FSD = nil) or FSD.Empty
  then
    FIndex := -1
  else
    FIndex := FSD.GetControlIndex(FSkinDataName);
  if (FIndex <> -1)
  then
    if TbsDataSkinControl(FSD.CtrlList.Items[FIndex]) is TbsDataSkinStdLabelControl
    then
      with TbsDataSkinStdLabelControl(FSD.CtrlList.Items[FIndex]) do
      begin
        Self.FontName := FontName;
        Self.FontColor := FontColor;
        Self.FontStyle := FontStyle;
        Self.FontHeight := FontHeight;
      end
end;

procedure TbsSkinStdLabel.ChangeSkinData;
begin
  GetSkinData;
  if AutoSize then AdjustBounds;
  RePaint;
end;

procedure TbsSkinStdLabel.SetSkinData;
begin
  FSD := Value;
  if (FSD <> nil) then ChangeSkinData;
end;

constructor TbsSkinLabel.Create;
begin
  inherited;
  FEllipsType := bsetNoneEllips;
  FUseSkinFontColor := True;
  FUseSkinSize := True;
  Width := 75;
  Height := 21;
  FAutoSize := False;
  FSkinDataName := 'label';
end;

procedure TbsSkinLabel.WMEraseBkgnd;
begin
  if not FromWMPaint
  then
    PaintWindow(Msg.DC);
end;

procedure TbsSkinLabel.SetEllipsType(Value: TbsEllipsType2);
begin
  if FEllipsType <> Value
  then
    begin
      FEllipsType := Value;
      Invalidate;
    end;
end;

procedure TbsSkinLabel.SetControlRegion; 
begin
  if UseSkinSize then inherited;
end;

procedure TbsSkinLabel.SetBorderStyle;
begin
  FBorderStyle := Value;
  if FIndex = -1
  then
    begin
      RePaint;
      ReAlign;
    end;
end;

procedure TbsSkinLabel.GetSkinData;
begin
  inherited;
  if FIndex <> -1
  then
    if TbsDataSkinControl(FSD.CtrlList.Items[FIndex]) is TbsDataSkinLabelControl
    then
      with TbsDataSkinLabelControl(FSD.CtrlList.Items[FIndex]) do
      begin
        Self.FontName := FontName;
        Self.FontColor := FontColor;
        Self.FontStyle := FontStyle;
        Self.FontHeight := FontHeight;
        if ResizeMode = 0 then FAutoSize := False;
      end;
end;

procedure TbsSkinLabel.DrawLabelText;
var
  TX, TY: Integer;
  S: String;
begin
  with Cnvs do
  begin
    if (FIndex <> -1) and UseSkinFont
    then
      begin
        Font.Name := FontName;
        Font.Style := FontStyle;
        Font.Height := FontHeight;
        Font.Color := FontColor;
      end
    else
    if (FIndex <> -1) and not UseSkinFont
    then
      begin
        Font.Assign(DefaultFont);
        Font.Color := FontColor;
      end
    else
      Font.Assign(DefaultFont);

    if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
    then
      Font.Charset := SkinData.ResourceStrData.CharSet
    else
      Font.CharSet := FDefaultFont.Charset;
      
    S := Caption;

    if FEllipsType <> bsetNoneEllips
    then
      CorrectTextbyWidth(Cnvs, S, RectWidth(R));

    TY := R.Top + RectHeight(R) div 2 - TextHeight(S) div 2;
    TX := R.Left;
    case FAlignment of
      taRightJustify: TX := R.Right - TextWidth(S);
      taCenter: TX := R.Left + RectWidth(R) div 2 - TextWidth(S) div 2;
    end;
    Brush.Style := bsClear;
    if not FUseSkinFontColor then Font.Color := FDefaultFont.Color;
    TextRect(R, TX, TY, S);
  end;
end;

procedure TbsSkinLabel.CreateControlDefaultImage;
var
  R: TRect;
begin
  inherited;
  R := ClientRect;
  case FBorderStyle of
    bvLowered:
      Frm3D(B.Canvas, R, clBtnShadow, clBtnHighLight);
    bvRaised:
      Frm3D(B.Canvas, R, clBtnHighLight, clBtnShadow);
    bvFrame:
      Frm3D(B.Canvas, R, clBtnShadow, clBtnShadow);
  end;
  DrawLabelText(B.Canvas, Rect(3, 3, Width - 3, Height - 3));
end;

procedure TbsSkinLabel.CreateControlSkinImage;
var
  R: TRect;
begin
  if FUseSkinSize or (ResizeMode = 1)
  then
    begin
      inherited;
      DrawLabelText(B.Canvas, NewClRect);
    end
  else
    begin
      R := NewClRect;
      Inc(R.Bottom, Height - RectHeight(SkinRect));
      CreateStretchImage(B, Picture, SkinRect, ClRect, True);
      DrawLabelText(B.Canvas, R);
    end;
end;

procedure TbsSkinLabel.PaintLabel;
begin
  CreateSkinControlImage(B, Picture, SkinRect);
end;

procedure TbsSkinLabel.CalcSize;
var
  Offset: Integer;
  XO: Integer;
begin
  if UseSkinSize or (ResizeMode = 1)
  then
    inherited
  else
    begin
      XO := W - RectWidth(SkinRect);
      NewLTPoint := LTPt;
      NewRTPoint := Point(RTPt.X + XO, RTPt.Y );
      NewClRect := ClRect;
      Inc(NewClRect.Right, XO);
    end;
  Offset := CalcWidthOffset;
  if (Offset > 0) and FAutoSize then W := W + Offset;
end;

function TbsSkinLabel.CalcWidthOffset;
begin
  if (FIndex <> -1)
  then
    begin
      with Canvas do
      begin
        if FUseSkinFont
        then
          begin
            Font.Name := FontName;
            Font.Height := FontHeight;
            Font.Style := FontStyle;
          end
        else
           Font.Assign(DefaultFont);
        if ResizeMode = 0
        then
          Result := 0
        else
          Result := TextWidth(Caption) - RectWidth(NewClRect);
      end;
    end
  else
    begin
      Canvas.Font.Assign(DefaultFont);
      Result := Canvas.TextWidth(Caption) - (Width - 4);
    end;
end;

procedure TbsSkinLabel.AdjustBounds;
var
  Offset: Integer;
begin
  if (Align = alTop) or (Align = alBottom)  or (Align = alClient) then Exit;
  Offset := CalcWidthOffset;
  if Offset <> 0 then Width := Width + Offset;
end;

procedure TbsSkinLabel.SetAlignment(Value: TAlignment);
begin
  if FAlignment <> Value
  then
    begin
      FAlignment := Value;
      RePaint;
    end;
end;

procedure TbsSkinLabel.SetAutoSizeX(Value: Boolean);
begin
  FAutoSize := Value;
  if FAutoSize then AdjustBounds;
end;

procedure TbsSkinLabel.CMTextChanged(var Message: TMessage);
begin
  if FAutoSize then AdjustBounds;
  RePaint;
end;

constructor TbsSkinStatusPanel.Create;
begin
  inherited;
  FGlyph := TBitMap.Create;
  FNumGlyphs := 1;
  FSkinDataName := 'statuspanel';
  Width := 120;
  FImageList := nil;
  FImageIndex := -1;
end;

destructor TbsSkinStatusPanel.Destroy;
begin
  FGlyph.Free;
  inherited;
end;

procedure TbsSkinStatusPanel.Notification(AComponent: TComponent;  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FImageList)
  then FImageList:= nil;
end;

procedure TbsSkinStatusPanel.SetImageIndex(Value: Integer);
begin
  if FImageIndex <> Value
  then
    begin
      FImageIndex := Value;
      RePaint;
    end;
end;


function TbsSkinStatusPanel.CalcWidthOffset;
var
  X: Integer;
begin
  if FGlyph.Empty and (FImageList <> nil) and (FImageIndex >= 0) and
  (FImageIndex < FImageList.Count)
  then
    begin
      X := FImageList.Width + 3
    end
  else
  if not FGlyph.Empty
  then
    X := FGlyph.Width div FNumGlyphs + 3
  else
    X := 0;
  if FIndex <> -1
  then
    begin
      with Canvas do
      begin
        if UseSkinFont
        then
          begin
            Font.Name := FontName;
            Font.Height := FontHeight;
            Font.Style := FontStyle;
          end
        else
          Font.Assign(DefaultFont);    
        if ResizeMode = 0
        then
          Result := 0
        else
          Result := TextWidth(Caption) + X - RectWidth(NewClRect);
     end
   end
 else
   begin
     Canvas.Font.Assign(DefaultFont);
     Result := Canvas.TextWidth(Caption) + X - (Width - 4);
   end;
end;

procedure TbsSkinStatusPanel.CMEnabledChanged;
begin
  inherited;
  RePaint;
end;

procedure TbsSkinStatusPanel.SetNumGlyphs;
begin
  FNumGlyphs := Value;
  RePaint;
  if FAutoSize then AdjustBounds;
end;

procedure TbsSkinStatusPanel.SetGlyph;
begin
  FGlyph.Assign(Value);
  RePaint;
  if FAutoSize then AdjustBounds;
end;

procedure TbsSkinStatusPanel.CreateControlDefaultImage;
var
  R: TRect;
  GW, GX, GY: Integer;
  GlyphNum: Integer;
begin
  R := ClientRect;
  with  B.Canvas do
  begin
    Brush.Color := clBtnFace;
    FillRect(R);
  end;
  case FBorderStyle of
    bvLowered:
      Frm3D(B.Canvas, R, clBtnShadow, clBtnHighLight);
    bvRaised:
      Frm3D(B.Canvas, R, clBtnHighLight, clBtnShadow);
    bvFrame:
      Frm3D(B.Canvas, R, clBtnShadow, clBtnShadow);
  end;
  R := Rect(3, 3, Width - 3, Height - 3);
  if FGlyph.Empty and (FImageList <> nil) and (FImageIndex >= 0) and
  (FImageIndex < FImageList.Count)
  then
    begin
      GW := FImageList.Width;
      GX := R.Left;
      GY := R.Top + RectHeight(R) div 2 - FImageList.Height div 2;
      FImageList.Draw(B.Canvas, GX, GY, FImageIndex, Enabled);
      Inc(R.Left, GW + 2);
    end
  else
  if not FGlyph.Empty
  then
    begin
      GW := FGlyph.Width div FNumGlyphs;
      Inc(R.Left, GW + 2);
      if Enabled then GlyphNum := 1 else GlyphNum := 2; 
      DrawGlyph(B.Canvas, 3, B.Height div 2 - FGlyph.Height div 2, Glyph, NumGlyphs, GlyphNum);
    end;
  DrawLabelText(B.Canvas, R);
end;

procedure TbsSkinStatusPanel.CreateControlSkinImage;
var
  R: TRect;
  GlyphNum, GX, GY, GW: Integer;
begin
  CreateSkinControlImage(B, Picture, SkinRect);
  R := NewClRect;
  if FGlyph.Empty and (FImageList <> nil) and (FImageIndex >= 0) and
  (FImageIndex < FImageList.Count)
  then
    begin
      GW := FImageList.Width;
      GX := R.Left;
      GY := R.Top + RectHeight(R) div 2 - FImageList.Height div 2;
      FImageList.Draw(B.Canvas, GX, GY, FImageIndex, Enabled);
      Inc(R.Left, GW + 2);
    end
  else
  if not FGlyph.Empty
  then
    begin
      GW := FGlyph.Width div FNumGlyphs;
      GX := R.Left;
      GY := R.Top + RectHeight(R) div 2 - FGlyph.Height div 2;
      if Enabled then GlyphNum := 1 else GlyphNum := 2;
      DrawGlyph(B.Canvas, GX, GY, Glyph, NumGlyphs, GlyphNum);
      Inc(R.Left, GW + 2);
    end;
  DrawLabelText(B.Canvas, R);
end;
//============ TbsSkinScrollBar ===============
const
  SBUTTONW = 16;
  BUTCOUNT = 3;
  THUMB = 0;
  UPBUTTON = 1;
  DOWNBUTTON = 2;


constructor TbsSkinScrollBar.Create;
begin
  inherited;
  FCanFocused := False;
  TabStop := False;
  FMin := 0;
  FMax := 100;
  FPosition := 0;
  FSmallChange := 1;
  FLargeChange := 1;
  FPageSize := 0;
  WaitMode := False;
  TimerMode := 0;
  ActiveButton := -1;
  OldActiveButton := -1;
  CaptureButton := -1;
  FOnChange := nil;
  Width := 200;
  Height := 19;
  FBothMarkerWidth := 19;
  FDefaultHeight := 19;
  FNormalSkinDataName := '';
  FBothSkinDataName := 'bothhscrollbar';
  FSkinDataName := 'hscrollbar';
end;

destructor TbsSkinScrollBar.Destroy;
begin
  inherited;
end;

procedure TbsSkinScrollBar.WMEraseBkgnd;
begin
  if not FromWMPaint
  then
    PaintWindow(Msg.DC);
end;

procedure TbsSkinScrollBar.SetBoth(Value: Boolean);
begin
  if FBoth <> Value
  then
    begin
      FBoth := Value;
      if not (csDesigning in ComponentState)
      then
        if FBoth
        then
          begin
            FNormalSkinDataName := SkinDataName;
            SkinDataName := FBothSkinDataName;
          end
        else
          if FNormalSkinDataName <> ''
          then
            SkinDataName := FNormalSkinDataName;
        if FIndex = -1
        then
          RePaint
        else
         ChangeSkinData;
    end;
end;

procedure TbsSkinScrollBar.CMEnabledChanged;
begin
  inherited;
  RePaint;
end;

procedure TbsSkinScrollBar.SetBothMarkerWidth;
begin
  if Value >= 0
  then
    begin
      FBothMarkerWidth := Value;
      if FIndex = -1 then RePaint;
    end;
end;

procedure TbsSkinScrollBar.KeyDown;
begin
  inherited KeyDown(Key, Shift);
  if FCanFocused then 
  case Key of
    VK_DOWN, VK_RIGHT: Position := Position + FSmallChange;
    VK_UP, VK_LEFT: Position := Position - FSmallChange;
  end;
end;

procedure TbsSkinScrollBar.WMMOUSEWHEEL;
begin
  if IsFocused
  then
    if Message.WParam > 0
    then
      Position := FPosition - FSmallChange
    else
      Position := FPosition + FSmallChange;
end;

procedure TbsSkinScrollBar.CMWantSpecialKey(var Msg: TCMWantSpecialKey);
begin
  inherited;
  if FCanFocused then 
  case Msg.CharCode of
    VK_UP, VK_DOWN, VK_LEFT, VK_RIGHT: Msg.Result := 1;
  end;
end;

function TbsSkinScrollBar.IsFocused;
begin
  Result := Focused and FCanFocused;
end;

procedure TbsSkinScrollBar.SetCanFocused;
begin
  FCanFocused := Value;
  if FCanFocused then TabStop := True else TabStop := False;
end;

procedure TbsSkinScrollBar.WMSETFOCUS;
begin
  inherited;
  if FCanFocused then RePaint;
end;

procedure TbsSkinScrollBar.WMKILLFOCUS;
begin
  inherited;
  if FCanFocused then RePaint;
end;

procedure TbsSkinScrollBar.WndProc(var Message: TMessage);
begin
  if FCanFocused then
  case Message.Msg of
    WM_LBUTTONDOWN, WM_LBUTTONDBLCLK:
      if not (csDesigning in ComponentState) and not Focused then
      begin
        FClicksDisabled := True;
        Windows.SetFocus(Handle);
        FClicksDisabled := False;
        if not Focused then Exit;
      end;
    CN_COMMAND:
      if FClicksDisabled then Exit;
  end;
  inherited WndProc(Message);
end;

procedure TbsSkinScrollBar.GetSkinData;
begin
  inherited;
  if FIndex <> -1
  then
    if TbsDataSkinControl(FSD.CtrlList.Items[FIndex]) is TbsDataSkinScrollBarControl
    then
      with TbsDataSkinScrollBarControl(FSD.CtrlList.Items[FIndex]) do
      begin
        Self.TrackArea := TrackArea;
        Self.UpButtonRect := UpButtonRect;

        Self.ActiveUpButtonRect := ActiveUpButtonRect;
        Self.DownUpButtonRect := DownUpButtonRect;

        if IsNullRect(Self.DownUpButtonRect)
        then
          Self.DownUpButtonRect := Self.ActiveUpButtonRect;

        Self.DownButtonRect := DownButtonRect;
        Self.ActiveDownButtonRect := ActiveDownButtonRect;
        Self.DownDownButtonRect := DownDownButtonRect;

        if IsNullRect(Self.DownDownButtonRect)
        then
          Self.DownDownButtonRect := Self.ActiveDownButtonRect;

        Self.ThumbRect := ThumbRect;
        Self.ActiveThumbRect := ActiveThumbRect;
        if IsNullRect(Self.ActiveThumbRect)
        then
          Self.ActiveThumbRect := Self.ThumbRect;

        Self.DownThumbRect := DownThumbRect;
        if IsNullRect(Self.DownThumbRect)
        then
          Self.DownThumbRect := Self.ActiveThumbRect;
        Self.ThumbOffset1 := ThumbOffset1;
        Self.ThumbOffset2 := ThumbOffset2;
        Self.ThumbTransparent := ThumbTransparent;
        Self.ThumbTransparentColor := ThumbTransparentColor;
        Self.GlyphRect := GlyphRect;
        Self.ActiveGlyphRect := ActiveGlyphRect;
        if isNullRect(ActiveGlyphRect)
        then Self.ActiveGlyphRect := GlyphRect; 
        Self.DownGlyphRect := DownGlyphRect;
        if isNullRect(DownGlyphRect)
        then Self.DownGlyphRect := Self.ActiveGlyphRect;
      end;
end;


procedure TbsSkinScrollBar.CalcSize;
begin
  inherited;
  CalcRects;
end;

procedure TbsSkinScrollBar.SetPageSize;
begin
  if AValue + FPosition <= FMax - FMin + 1
  then
    FPageSize := AValue;
  RePaint;
end;

procedure TbsSkinScrollBar.StopTimer;
begin
  KillTimer(Handle, 1);
  TimerMode := 0;
end;

procedure TbsSkinScrollBar.TestActive(X, Y: Integer);
var
  i, j: Integer;
begin
  j := -1;
  OldActiveButton := ActiveButton;
  for i := 0 to BUTCOUNT - 1 do
  begin
    if PtInRect(Buttons[i].R, Point(X, Y))
    then
      begin
        j := i;
        Break;
      end;
  end;

  ActiveButton := j;

  if (CaptureButton <> -1) and
     (ActiveButton <> CaptureButton) and (ActiveButton <> -1)
  then
    ActiveButton := -1;

  if (OldActiveButton <> ActiveButton)
  then
    begin
      if OldActiveButton <> - 1
      then
        ButtonLeave(OldActiveButton);

      if ActiveButton <> -1
      then
        ButtonEnter(ActiveButton);
    end;
end;

procedure TbsSkinScrollBar.CreateControlSkinImage;
var
  i: Integer;
begin
  inherited;
  CalcRects;
  for i := 1 to BUTCOUNT - 1 do DrawButton(B.Canvas, i);
  if Enabled then 
  DrawButton(B.Canvas, THUMB);
end;

procedure TbsSkinScrollBar.DrawButton;
var
  R1, R2: TRect;
  C: TColor;
  ThumbB: TBitMap;
begin
  if FIndex = -1
  then
    with Buttons[i] do
    begin
      R1 := R;
      with Cnvs do
      begin
        if (Down and MouseIn) or ((i = THUMB) and (Down or IsFocused))
        then
          begin
            Frame3D(Cnvs, R1, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
            Brush.Color := BS_XP_BTNDOWNCOLOR;
           FillRect(R1);
         end
        else
          if MouseIn
          then
            begin
              Frame3D(Cnvs, R1, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
              Brush.Color := BS_XP_BTNACTIVECOLOR;
              FillRect(R1);
            end
         else
           begin
             Frame3D(Cnvs, R1, clBtnShadow, clBtnShadow, 1);
             Brush.Color := clBtnFace;
             FillRect(R1);
           end;
     end;

   C := clBlack;

    case i of
      DOWNBUTTON:
        case Kind of
          sbHorizontal:
            DrawArrowImage(Cnvs, R1, C, 1);
          sbVertical:
            DrawArrowImage(Cnvs, R1, C, 3);
        end;
      UPBUTTON:
        case Kind of
          sbHorizontal:
            DrawArrowImage(Cnvs, R1, C, 2);
          sbVertical:
            DrawArrowImage(Cnvs, R1, C, 4);
        end;
    end;
  end
  else
    begin
      if I = THUMB
      then
        with Buttons[THUMB] do
        begin
          if Down or IsFocused
          then R1 := DownThumbRect
          else if MouseIn then R1 := ActiveThumbRect
          else R1 := ThumbRect;
          ThumbB := TBitMap.Create;
          ThumbB.Width := RectWidth(R);
          ThumbB.Height := RectHeight(R);
          if FPageSize = 0
          then
            ThumbB.Canvas.CopyRect(Rect(0, 0, ThumbB.Width, ThumbB.Height), Picture.Canvas, R1)
          else
            case Kind of
              sbHorizontal:
                CreateHSkinImage(ThumbOffset1, ThumbOffset2, ThumbB, Picture, R1,
                  ThumbB.Width, ThumbB.Height, False);
              sbVertical:
                CreateVSkinImage(ThumbOffset1, ThumbOffset2, ThumbB, Picture, R1,
                  ThumbB.Width, ThumbB.Height, False);
            end;
          // draw glyph
          if Down or IsFocused
          then R1 := DownGlyphRect
          else if MouseIn then R1 := ActiveGlyphRect
          else R1 := GlyphRect;
          if not IsNullRect(R1)
          then
            begin
              R2 := Rect(ThumbB.Width div 2 - RectWidth(R1) div 2,
                         ThumbB.Height div 2 - RectHeight(R1) div 2,
                         ThumbB.Width div 2 - RectWidth(R1) div 2 + RectWidth(R1),
                         ThumbB.Height div 2 - RectHeight(R1) div 2 + RectHeight(R1));
              ThumbB.Canvas.CopyRect(R2, Picture.Canvas, R1)
            end;
          //

          if ThumbTransparent
          then
            begin
              ThumbB.Transparent := True;
              ThumbB.TransparentMode := tmFixed;
              ThumbB.TransparentColor := ThumbTransparentColor;
            end;
            
          Cnvs.Draw(R.Left, R.Top, ThumbB);
          ThumbB.Free;
        end
      else
        begin
          R1 := NullRect;
          case I of
            UPBUTTON:
            with Buttons[UPBUTTON] do
            begin
              if Down and MouseIn
              then R1 := DownUpButtonRect
              else if MouseIn then R1 := ActiveUpButtonRect;
            end;
            DOWNBUTTON:
            with Buttons[DOWNBUTTON] do
            begin
              if Down and MouseIn
              then R1 := DownDownButtonRect
              else if MouseIn then R1 := ActiveDownButtonRect;
            end
          end;
          if not IsNullRect(R1)
          then
            Cnvs.CopyRect(Buttons[i].R, Picture.Canvas, R1);
        end;
    end;
end;

procedure TbsSkinScrollBar.CalcRects;
var
  Kf: Double;
  i, j, k, XMin, XMax: Integer;
  Offset: Integer;
  ThumbW, ThumbH: Integer;
  NewWidth: Integer;
begin
  if FMin = FMax
  then Kf := 0
  else kf := (FPosition - FMin) / (FMax - FMin);

  if FIndex = -1
  then
    begin
      ThumbW := SBUTTONW;
      if FBoth
      then
        NewWidth := Width - BothMarkerWidth
      else
        NewWidth := Width;
      case FKind of
        sbHorizontal:
          begin
            Buttons[DOWNBUTTON].R := Rect(1, 1, 1 + SBUTTONW, Height - 1);
            Buttons[UPBUTTON].R := Rect(NewWidth - SBUTTONW - 1, 1, NewWidth - 1, Height - 1);
            NewTrackArea := Rect(SBUTTONW + 1, 1, NewWidth - SBUTTONW - 1, Height - 1);
            if FPageSize = 0
            then
              begin
                Offset1 := NewTrackArea.Left + ThumbW div 2;
                Offset2 := NewTrackArea.Right - ThumbW div 2;
                BOffset := Round((Offset2 - Offset1) * kf);
                Buttons[THUMB].R :=
                 Rect(Offset1 + BOffset - ThumbW div 2, NewTrackArea.Top,
                     Offset1 + BOffset + ThumbW div 2, NewTrackArea.Bottom);
              end
            else
              begin
                i := RectWidth(NewTrackArea);
                j := FMax - FMin + 1;
                if j = 0 then kf := 0 else kf := FPageSize / j;
                j := Round(i * kf);
                if j < ThumbW then j := ThumbW;
                XMin := FMin;
                XMax := FMax - FPageSize + 1;
                if XMax > XMin
                then
                  kf := (FPosition - XMin) / (XMax - XMin)
                else
                  kf := 1;
                Offset1 := NewTrackArea.Left + j div 2;
                Offset2 := NewTrackArea.Right - j div 2;
                BOffset := Round((Offset2 - Offset1) * kf);
                Buttons[THUMB].R :=
                 Rect(Offset1 + BOffset - j div 2, NewTrackArea.Top,
                     Offset1 + BOffset + j div 2, NewTrackArea.Bottom);
              end;
          end;
        sbVertical:
          begin
            Buttons[DOWNBUTTON].R := Rect(1, 1, Width - 1, 1 + SBUTTONW);
            Buttons[UPBUTTON].R := Rect(1, Height - SBUTTONW - 1, Width - 1, Height - 1);
            NewTrackArea := Rect(1, SBUTTONW + 1, Width - 1, Height - SBUTTONW - 1);
            if PageSize = 0
            then
              begin
                Offset1 := NewTrackArea.Top + ThumbW div 2;
                Offset2 := NewTrackArea.Bottom - ThumbW div 2;
                BOffset := Round((Offset2 - Offset1) * kf);
                Buttons[THUMB].R :=
                  Rect(NewTrackArea.Left, Offset1 + BOffset - ThumbW div 2,
                       NewTrackArea.Right, Offset1 + BOffset + ThumbW div 2);
              end
            else
              begin
                i := RectHeight(NewTrackArea);
                j := FMax - FMin + 1;
                if j = 0 then kf := 0 else kf := FPageSize / j;
                j := Round(i * kf);
                if j < ThumbW then j := ThumbW;
                XMin := FMin;
                XMax := FMax - FPageSize + 1;
                if XMax - XMin > 0
                then
                  kf := (FPosition - XMin) / (XMax - XMin)
                else
                  kf := 0;
                Offset1 := NewTrackArea.Top + j div 2;
                Offset2 := NewTrackArea.Bottom - j div 2;
                BOffset := Round((Offset2 - Offset1) * kf);
                Buttons[THUMB].R :=
                  Rect(NewTrackArea.Left, Offset1 + BOffset - j div 2,
                      NewTrackArea.Right, Offset1 + BOffset + j div 2);
             end;
          end;
      end;
    end
   else
     begin
       ThumbW := RectWidth(ThumbRect);
       ThumbH := RectHeight(ThumbRect);
       case FKind of
         sbHorizontal:
           begin
             Offset := Width - RectWidth(SkinRect);
             NewTrackArea := TrackArea;
             Inc(NewTrackArea.Right, Offset);
             Buttons[UPBUTTON].R := UpButtonRect;
             Buttons[DOWNBUTTON].R := DownButtonRect;
             //
             if UpButtonRect.Left > RTPt.X
             then
               OffsetRect(Buttons[UPBUTTON].R, Offset, 0);
             if DownButtonRect.Left > RTPt.X
             then
               OffsetRect(Buttons[DOWNBUTTON].R, Offset, 0);
             if FPageSize = 0
             then
               begin
                 Offset1 := NewTrackArea.Left + ThumbW div 2;
                 Offset2 := NewTrackArea.Right - ThumbW div 2;
                 BOffset := Round((Offset2 - Offset1) * kf);
                 Buttons[THUMB].R :=
                   Rect(Offset1 + BOffset - ThumbW div 2,
                        NewTrackArea.Top + RectHeight(NewTrackArea) div 2 - ThumbH div 2,
                        Offset1 + BOffset + ThumbW div 2,
                        NewTrackArea.Top + RectHeight(NewTrackArea) div 2 - ThumbH div 2 + ThumbH);
               end
             else
               begin
                 i := RectWidth(NewTrackArea);
                 j := FMax - FMin + 1;
                 if j = 0 then kf := 0 else kf := FPageSize / j;
                 j := Round(i * kf);
                 if j < ThumbW then j := ThumbW;
                 XMin := FMin;
                 XMax := FMax - FPageSize + 1;
                 if XMax <= XMin
                 then
                   kf := 1
                 else
                   kf := (FPosition - XMin) / (XMax - XMin);
                 Offset1 := NewTrackArea.Left + j div 2;
                 Offset2 := NewTrackArea.Right - j div 2;
                 BOffset := Round((Offset2 - Offset1) * kf);
                 Buttons[THUMB].R :=
                 Rect(Offset1 + BOffset - j div 2,
                      NewTrackArea.Top + RectHeight(NewTrackArea) div 2 - ThumbH div 2,
                      Offset1 + BOffset + j div 2,
                      NewTrackArea.Top + RectHeight(NewTrackArea) div 2 - ThumbH div 2 +
                      ThumbH);
              end;
           end;
         sbVertical:
           begin
             Offset := Height - RectHeight(SkinRect);
             NewTrackArea := TrackArea;
             Inc(NewTrackArea.Bottom, Offset);
             Buttons[UPBUTTON].R := UpButtonRect;
             Buttons[DOWNBUTTON].R := DownButtonRect;
             if UpButtonRect.Top > LBPt.Y
             then
               OffsetRect(Buttons[UPBUTTON].R, 0, Offset);
             if DownButtonRect.Top > LBPt.Y
             then
               OffsetRect(Buttons[DOWNBUTTON].R, 0, Offset);
             if PageSize = 0
             then
              begin
                Offset1 := NewTrackArea.Top + ThumbH div 2;
                Offset2 := NewTrackArea.Bottom - ThumbH div 2;
                BOffset := Round((Offset2 - Offset1) * kf);
                Buttons[THUMB].R :=
                  Rect(NewTrackArea.Left + RectWidth(NewTrackArea) div 2 -
                       ThumbW div 2,
                       Offset1 + BOffset - ThumbH div 2,
                       NewTrackArea.Left + RectWidth(NewTrackArea) div 2 -
                       ThumbW div 2 + ThumbW,
                       Offset1 + BOffset + ThumbH div 2);
              end
             else
               begin
                 i := RectHeight(NewTrackArea);
                 j := FMax - FMin + 1;
                 if j = 0 then kf := 0 else kf := FPageSize / j;
                 j := Round(i * kf);
                 if j < ThumbH then j := ThumbH;
                 XMin := FMin;
                 XMax := FMax - FPageSize + 1;
                 if XMax - XMin <= 0
                 then
                   kf := 0
                 else
                   kf := (FPosition - XMin) / (XMax - XMin);
                 Offset1 := NewTrackArea.Top + j div 2;
                 Offset2 := NewTrackArea.Bottom - j div 2;
                 BOffset := Round((Offset2 - Offset1) * kf);
                 Buttons[THUMB].R :=
                   Rect(NewTrackArea.Left + RectWidth(NewTrackArea) div 2 -
                        ThumbW div 2,
                        Offset1 + BOffset - j div 2,
                        NewTrackArea.Left + RectWidth(NewTrackArea) div 2 -
                        ThumbW div 2 + ThumbW,
                        Offset1 + BOffset + j div 2);
               end;
           end;
       end;
     end;
end;

procedure TbsSkinScrollBar.SetKind;
var
  S: Integer;
begin
  if AValue <> FKind
  then
    begin
      FKind := AValue;
      RePaint;
    end;
  if (csDesigning in ComponentState) and not
     (csLoading in ComponentState)
  then
    begin
      if FKind = sbVertical
      then
        begin
          FSkinDataName := 'vscrollbar';
          if Width > Height
          then
            begin
              S := Width;
              Width := Height;
              Height := S;
            end;
          FDefaultWidth := FDefaultHeight;
          FDefaultHeight := 0;
        end
      else
        begin
          FSkinDataName := 'hscrollbar';
          if Width < Height
          then
            begin
              S := Width;
              Width := Height;
              Height := S;
            end;
          FDefaultHeight := FDefaultWidth;
          FDefaultWidth := 0;
        end;
    end;
end;

procedure TbsSkinScrollBar.SimplySetPosition;
var
  TempValue: Integer;
begin
  if FPageSize = 0
  then
    begin
      if AValue < FMin then TempValue := FMin else
      if AValue > FMax then TempValue := FMax else
      TempValue := AValue;
    end
  else
    begin
      if AValue < FMin then TempValue := FMin else
      if AValue > FMax - FPageSize + 1 then
      TempValue := FMax - FPageSize + 1  else
      TempValue := AValue;
    end;
  if TempValue <> FPosition
  then
    begin
      FPosition := TempValue;
      RePaint;
   end;
end;

procedure TbsSkinScrollBar.SetPosition;
var
  TempValue: Integer;
begin
  if FPageSize = 0
  then
    begin
      if AValue < FMin then TempValue := FMin else
      if AValue > FMax then TempValue := FMax else
      TempValue := AValue;
    end
  else
    begin
      if AValue < FMin then TempValue := FMin else
      if AValue > FMax - FPageSize + 1 then
      TempValue := FMax - FPageSize + 1  else
      TempValue := AValue;
    end;
  if TempValue <> FPosition
  then
    begin
      FPosition := TempValue;
      RePaint;
      if Assigned(FOnChange) then FOnChange(Self);
    end;
end;

procedure TbsSkinScrollBar.SetRange;
begin
  FMin := AMin;
  FMax := AMax;
  FPageSize := APageSize;
  if FPageSize = 0
  then
    begin
      if APosition < FMin then FPosition := FMin else
      if APosition > FMax then FPosition := FMax else
      FPosition := APosition;
    end
  else
    begin
      if APosition < FMin then FPosition := FMin else
      if APosition > FMax - FPageSize + 1 then
      FPosition := FMax - FPageSize + 1  else
      FPosition := APosition;
    end;
  RePaint;
end;

procedure TbsSkinScrollBar.SetMax;
begin
  FMax := AValue;
  if FPageSize = 0
  then
    begin
      if FPosition > FMax then FPosition := FMax;
    end
  else
    begin
      if FPageSize + FPosition > FMax - FMin
      then
        FPosition := (FMax - FMin) - FPageSize + 1;
      if FPosition < FMin then FPosition := FMin;
    end;
  RePaint;
end;

procedure TbsSkinScrollBar.SetMin;
begin
  FMin := AValue;
  if FPosition < FMin then FPosition := FMin;
  RePaint;
end;

procedure TbsSkinScrollBar.SetSmallChange;
begin
  FSmallChange := AValue;
  RePaint;
end;

procedure TbsSkinScrollBar.SetLargeChange;
begin
  FLargeChange := AValue;
  RePaint;
end;

procedure TbsSkinScrollBar.CreateControlDefaultImage;
var
  R: TRect;
  i: Integer;
  j: Integer;
begin
  CalcRects;
  R := ClientRect;
  with B.Canvas do
  begin
    Brush.Color := clBtnFace;
    FillRect(R);
  end;
  if Enabled then j :=  0 else j := 1;
  for i := j to BUTCOUNT - 1 do DrawButton(B.Canvas, i);
end;

procedure TbsSkinScrollBar.MouseDown;
var
  i: Integer;
  j: Integer;
begin
  inherited;
  if Button <> mbLeft
  then
    begin
      inherited;
      Exit;
    end;
  MouseD := True;
  CalcRects;
  TimerMode := 0;
  WaitMode := True;
  j := -1;
  for i := 0 to BUTCOUNT - 1 do
  begin
    if PtInRect(Buttons[i].R, Point(X, Y))
    then
      begin
        j := i;
        Break;
      end;
  end;
  if j <> -1
  then
    begin
      CaptureButton := j;
      ButtonDown(j, X, Y);
    end
  else
    begin
      if PtInRect(NewTrackArea, Point(X, Y))
      then
        case Kind of
          sbHorizontal:
            begin
              if X < Buttons[THUMB].R.Left
              then
                begin
                  Position := Position - LargeChange;
                  TimerMode := 3;
                  SetTimer(Handle, 1, 500, nil);
                  if Assigned(FOnPageUp) then FOnPageUp(Self);
                end
              else
                begin
                  Position := Position + LargeChange;
                  TimerMode := 4;
                  SetTimer(Handle, 1, 500, nil);
                  if Assigned(FOnPageDown) then FOnPageDown(Self);
                end;
            end;
          sbVertical:
           begin
             if Y < Buttons[THUMB].R.Top
              then
                begin
                  Position := Position - LargeChange;
                  TimerMode := 3;
                  SetTimer(Handle, 1, 500, nil);
                  if Assigned(FOnPageUp) then FOnPageUp(Self);
                end
              else
                begin
                  Position := Position + LargeChange;
                  TimerMode := 4;
                  SetTimer(Handle, 1, 500, nil);
                  if Assigned(FOnPageDown) then FOnPageDown(Self);
                end;
           end;
        end;
    end;
end;

procedure TbsSkinScrollBar.MouseUp;
begin
  inherited;
  MouseD := False;
  if (TimerMode >= 3) then StopTimer;
  if CaptureButton <> -1
  then ButtonUp(CaptureButton, X, Y);
  if (Button = mbLeft) and (CaptureButton = 0) and Assigned(FOnLastChange)
  then
    FOnLastChange(Self);
  CaptureButton := -1;
end;

function TbsSkinScrollBar.CalcValue;
var
  kf: Double;
  TempPos: Integer;
begin
  if FPageSize = 0
  then
    begin
      if (Offset2 - Offset1) <= 0
      then kf := 0
      else kf := AOffset / (Offset2 - Offset1);
      if kf > 1 then kf := 1 else
      if kf < 0 then kf := 0;
      Result := FMin + Round((FMax - FMin) * kf);
    end
  else
    begin
      case Kind of
        sbVertical:
          begin
            Offset1 := NewTrackArea.Top + RectHeight(Buttons[THUMB].R) div 2;
            Offset2 := NewTrackArea.Bottom - RectHeight(Buttons[THUMB].R) div 2;
          end;
        sbHorizontal:
          begin
            Offset1 := NewTrackArea.Left + RectWidth(Buttons[THUMB].R) div 2;
            Offset2 := NewTrackArea.Right - RectWidth(Buttons[THUMB].R) div 2;
          end;
      end;
      TempPos := OldBOffset + AOffset;
      if (Offset2 - Offset1) <= 0
      then kf := 0
      else kf := TempPos / (Offset2 - Offset1);
      if kf > 1 then kf := 1 else
      if kf < 0 then kf := 0;
      Result := FMin + Round((FMax - FMin - FPageSize + 1) * kf);
    end;
end;

procedure TbsSkinScrollBar.MouseMove;
var
  Off: Integer;
begin
  MX := X; MY := Y;
  TestActive(X, Y);
  if FDown
  then
    case Kind of
      sbVertical:
        begin
          if PageSize = 0
          then
            begin
              Off := Y - OMPos;
              Off := OldBOffset + Off;
              Position := CalcValue(Off);
            end
          else
            Off := Y - OMPos;
          Position := CalcValue(Off);
        end;
      sbHorizontal:
        begin
          if PageSize = 0
          then
            begin
              Off := X - OMPos;
              Off := OldBOffset + Off;
              Position := CalcValue(Off);
            end
          else
            Off := X - OMPos;
          Position := CalcValue(Off);
        end;
    end;
  inherited;
end;

procedure TbsSkinScrollBar.ButtonDown;
begin
  Buttons[i].Down := True;
  RePaint;
  case i of
    THUMB:
      with Buttons[THUMB] do
      begin
        if Kind = sbVertical then OMPos := Y else OMPos := X;
        OldBOffset := BOffset;
        OldPosition := Position;
        case Kind of
         sbHorizontal:
           begin
             FScrollWidth := NewTrackArea.Right - R.Right;
             if FScrollWidth <= 0
             then FScrollWidth := R.Left - NewTrackArea.Left;
           end;
         sbVertical:
           begin
             FScrollWidth := NewTrackArea.Bottom - R.Bottom;
             if FScrollWidth <= 0
             then FScrollWidth := R.Top - NewTrackArea.Top;
           end;
        end;
        FDown := True;
        RePaint;
      end;
    DOWNBUTTON:
      with Buttons[UPBUTTON] do
      begin
        if Assigned(FOnDownButtonClick)
        then
          FOnDownButtonClick(Self)
        else
          Position := Position - SmallChange;
        TimerMode := 1;
        SetTimer(Handle, 1, 500, nil);
      end;
    UPBUTTON:
      with Buttons[DOWNBUTTON] do
      begin
        if Assigned(FOnUpButtonClick)
        then
          FOnUpButtonClick(Self)
        else
          Position := Position + SmallChange;
        TimerMode := 2;
        SetTimer(Handle, 1, 500, nil);
      end;
  end;
end;

procedure TbsSkinScrollBar.ButtonUp;
begin
  Buttons[i].Down := False;
  if ActiveButton <> i then Buttons[i].MouseIn := False;
  RePaint;
  case i of
    THUMB:
      begin
        FDown := False;
      end;
    UPBUTTON:
      with Buttons[UPBUTTON] do
      begin
        StopTimer;
      end;
    DOWNBUTTON:
      with Buttons[DOWNBUTTON] do
      begin
        StopTimer;
      end;
  end;
end;

procedure TbsSkinScrollBar.ButtonEnter(I: Integer);
begin
  Buttons[i].MouseIn := True;
  RePaint;
  case i of
    THUMB:
      with Buttons[THUMB] do
      begin
      end;
    UPBUTTON:
      with Buttons[UPBUTTON] do
      begin
        if Down then SetTimer(Handle, 1, 50, nil);
      end;
    DOWNBUTTON:
      with Buttons[DOWNBUTTON] do
      begin
        if Down then SetTimer(Handle, 1, 50, nil);
      end;
  end;
end;

procedure TbsSkinScrollBar.ButtonLeave(I: Integer);
begin
  Buttons[i].MouseIn := False;
  RePaint;
  case i of
    THUMB:
      with Buttons[THUMB] do
      begin
      end;
    UPBUTTON:
      with Buttons[UPBUTTON] do
      begin
        if Down then  KillTimer(Handle, 1);
      end;
    DOWNBUTTON:
      with Buttons[DOWNBUTTON] do
      begin
        if Down then  KillTimer(Handle, 1);
      end;
  end;
end;


procedure TbsSkinScrollBar.StartScroll;
begin
  KillTimer(Handle, 1);
  SetTimer(Handle, 1, 50, nil);
end;

procedure TbsSkinScrollBar.WMTimer;
var
  CanScroll: Boolean;
begin
  inherited;
  if WaitMode
  then
    begin
      WaitMode := False;
      StartScroll;
      Exit;
    end;
  case TimerMode of
    1:
      begin
        if Assigned(FOnDownButtonClick)
        then
          FOnDownButtonClick(Self)
        else
          Position := Position - SmallChange;
      end;
    2:
      begin
        if Assigned(FOnUpButtonClick)
        then
          FOnUpButtonClick(Self)
        else
          Position := Position + SmallChange;
      end;
    3:
      begin
        TestActive(MX, MY);
        case Kind of
          sbHorizontal: CanScroll := MX < Buttons[THUMB].R.Left;
          sbVertical: CanScroll := MY < Buttons[THUMB].R.Top;
        end;
        if CanScroll
        then
          begin
            Position := Position - LargeChange;
            if Assigned(FOnPageUp) then FOnPageUp(Self);
          end
        else
          StopTimer;
      end;
    4:
      begin
        TestActive(MX, MY);
        case Kind of
          sbHorizontal: CanScroll := MX > Buttons[THUMB].R.Right;
          sbVertical: CanScroll := MY > Buttons[THUMB].R.Bottom;
        end;
        if CanScroll
        then
          begin
            Position := Position + LargeChange;
            if Assigned(FOnPageDown) then FOnPageDown(Self);
          end
        else
          StopTimer;
      end;
  end;
end;

procedure TbsSkinScrollBar.CMMouseLeave;
begin
  inherited;
  if (csDesigning in ComponentState) then Exit;
  if (ActiveButton <> -1) and (CaptureButton = -1) and not FDown
  then
    begin
      Buttons[ActiveButton].MouseIn := False;
      RePaint;
      ActiveButton := -1;
    end;
  if MouseD and (TimerMode > 3) then StopTimer;
end;

procedure TbsSkinScrollBar.CMMouseEnter;
begin
  inherited;
end;

constructor TbsSkinSplitter.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle + [csOpaque];
  FSkinPicture := nil;
  FIndex := -1;
  FDefaultSize := 10;
  FSkinDataName := 'vsplitter';
  StretchEffect := False;
  FTransparent := False;
end;

procedure TbsSkinSplitter.SetTransparent;
begin
  if FTransparent = Value then Exit;
  FTransparent := Value;
  if FTransparent
  then
    ControlStyle := ControlStyle - [csOpaque]
  else
    ControlStyle := ControlStyle + [csOpaque];
  Repaint;
end;

destructor  TbsSkinSplitter.Destroy;
begin
  inherited;
end;

procedure TbsSkinSplitter.Paint;
var
  Buffer: TBitMap;
  GripperBuffer: TBitMap;
  GX, GY: Integer;
begin

  if FTransparent then Exit;

  if (Width <= 0) or (Height <= 0) then Exit;
  GetSkinData;
  if (FIndex <> -1) and (Align <> alNone) and (Align <> alClient)
  then
    begin
      Buffer := TBitMap.Create;
      if (Align = alTop) or (Align = alBottom)
      then
        CreateHSkinImage(LTPt.X, RectWidth(SkinRect) - RtPt.X,
          Buffer, FSkinPicture, SkinRect, Width, RectHeight(SkinRect), StretchEffect)
      else
        CreateVSkinImage(LTPt.Y, RectHeight(SkinRect) - LBPt.Y,
          Buffer, FSkinPicture, SkinRect, RectWidth(SkinRect), Height, StretchEffect);
      // draw gripper
      if not IsNullRect(GripperRect)
      then
        begin
          GripperBuffer := TBitMap.Create;
          GripperBuffer.Width := RectWidth(GripperRect);
          GripperBuffer.Height := RectHeight(GripperRect);
          GripperBuffer.Canvas.CopyRect(
            Rect(0, 0, GripperBuffer.Width, GripperBuffer.Height),
            FSkinPicture.Canvas, GripperRect);
          GX := Buffer.Width div 2 - GripperBuffer.Width div 2;
          GY := Buffer.Height div 2 - GripperBuffer.Height div 2;
          if GripperTransparent
          then
            begin
              GripperBuffer.Transparent := True;
              GripperBuffer.TransparentMode := tmFixed;
              GripperBuffer.TransparentColor := GripperTransparentColor;
            end;
          Buffer.Canvas.Draw(GX, GY, GripperBuffer);
          GripperBuffer.Free;
        end;
      //
      Canvas.Draw(0, 0, Buffer);
      Buffer.Free;
    end
  else
    inherited;
end;

procedure TbsSkinSplitter.Notification;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FSD) then FSD := nil;
end;

procedure TbsSkinSplitter.GetSkinData;
begin
  if (FSD = nil) or FSD.Empty
  then
    FIndex := -1
  else
    FIndex := FSD.GetControlIndex(FSkinDataName);
  FSkinPicture := nil;
  if FIndex <> -1
  then
    if TbsDataSkinControl(FSD.CtrlList.Items[FIndex]) is TbsDataSkinSplitterControl
    then
      with TbsDataSkinSplitterControl(FSD.CtrlList.Items[FIndex]) do
      begin
        LTPt := LTPoint;
        RTPt := RTPoint;
        LBPt := LBPoint;
        Self.SkinRect := SkinRect;
        Self.StretchEffect := StretchEffect;
        if (PictureIndex <> -1) and (PictureIndex < FSD.FActivePictures.Count)
        then
          FSkinPicture := TBitMap(FSD.FActivePictures.Items[PictureIndex])
        else
          FSkinPicture := nil;
        Self.GripperRect := GripperRect;
        Self.GripperTransparent := GripperTransparent;
        Self.GripperTransparentColor := GripperTransparentColor;
      end;
end;

procedure TbsSkinSplitter.ChangeSkinData;
var
  lMinSize: Integer;
begin
  GetSkinData;
  if (Align = alTop) or (Align = alBottom)
  then
    begin
      if (FIndex = -1) or FTransparent
      then
        lMinSize := FDefaultSize
      else
        lMinSize := RectHeight(SkinRect);
      Height := lMinSize;
    end
  else
    begin
      if (FIndex = -1) or FTransparent
      then
        lMinSize := FDefaultSize
      else
        lMinSize := RectWidth(SkinRect);
     Width := lMinSize;
    end;
  RePaint;
end;

procedure TbsSkinSplitter.SetSkinData;
begin
  FSD := Value;
  ChangeSkinData;
end;

constructor TbsSkinControlBar.Create(AOwner: TComponent);
begin
  inherited;
  FSkinPicture := nil;
  FIndex := -1;
  if (csDesigning in ComponentState)
  then
    begin
      AutoSize := True;
      AutoDrag := False;
      RowSnap := False;
    end;
  BevelKind := bkNone;
  FSkinDataName := 'controlbar';
end;

destructor TbsSkinControlBar.Destroy;
begin
  inherited;
end;

procedure TbsSkinControlBar.CMBENCPAINT;
var
  C: TCanvas;
begin
  if (Message.LParam = BE_ID)
  then
    begin
      if (Message.wParam <> 0) and FSkinBevel
      then
        begin
          C := TControlCanvas.Create;
          C.Handle := Message.wParam;
          PaintNCSkin(0, False);
          C.Handle := 0;
          C.Free;
        end;
      Message.Result := BE_ID;
    end
  else
    inherited;
end;

procedure TbsSkinControlBar.Notification;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FSD) then FSD := nil;
end;

procedure TbsSkinControlBar.WMSIZE;
begin
  inherited;
  GetSkinData;
  if (FIndex <> -1) and FSkinBevel then PaintNCSkin(0, False);
end;

procedure TbsSkinControlBar.SetSkinBevel;
begin
  FSkinBevel := Value;
  if FIndex <> -1 then RecreateWnd;
end;

procedure TbsSkinControlBar.PaintNCSkin;
var
  LeftBitMap, TopBitMap, RightBitMap, BottomBitMap: TBitMap;
  DC: HDC;
  Cnvs: TControlCanvas;
  OX, OY: Integer;
begin
  if not AUseExternalDC then  DC := GetWindowDC(Handle) else DC := ADC;
  Cnvs := TControlCanvas.Create;
  Cnvs.Handle := DC;
  LeftBitMap := TBitMap.Create;
  TopBitMap := TBitMap.Create;
  RightBitMap := TBitMap.Create;
  BottomBitMap := TBitMap.Create;
  //
  OX := Width - RectWidth(SkinRect);
  OY := Height - RectHeight(SkinRect);
  NewLTPoint := LTPt;
  NewRTPoint := Point(RTPt.X + OX, RTPt.Y);
  NewLBPoint := Point(LBPt.X, LBPt.Y + OY);
  NewRBPoint := Point(RBPt.X + OX, RBPt.Y + OY);
  NewClRect := Rect(ClRect.Left, ClRect.Top,
    ClRect.Right + OX, ClRect.Bottom + OY);
  //
  CreateSkinBorderImages(LTPt, RTPt, LBPt, RBPt, ClRect,
      NewLTPoint, NewRTPoint, NewLBPoint, NewRBPoint, NewCLRect,
      LeftBitMap, TopBitMap, RightBitMap, BottomBitMap,
      FSkinPicture, SkinRect, Width, Height, LeftStretch, TopStretch, RightStretch, BottomStretch);

  if NewClRect.Bottom > NewClRect.Top
  then
    ExcludeClipRect(Cnvs.Handle,
      NewClRect.Left, NewClRect.Top, NewClRect.Right, NewClRect.Bottom);

  Cnvs.Draw(0, 0, TopBitMap);
  Cnvs.Draw(0, TopBitMap.Height, LeftBitMap);
  Cnvs.Draw(Width - RightBitMap.Width, TopBitMap.Height, RightBitMap);
  Cnvs.Draw(0, Height - BottomBitMap.Height, BottomBitMap);
  //
  TopBitMap.Free;
  LeftBitMap.Free;
  RightBitMap.Free;
  BottomBitMap.Free;
  Cnvs.Handle := 0;
  if not AUseExternalDC then ReleaseDC(Handle, DC);
  Cnvs.Free;
end;

procedure TbsSkinControlBar.Paint;
var
  X, Y, XCnt, YCnt, w, h,
  rw, rh, XO, YO: Integer;
  Buffer: TBitMap;
  i: Integer;
  R: TRect;
  B: TBitMap;
begin
  GetSkinData;
  if FIndex = -1
  then
    begin
      inherited;
      Exit;
    end;
  if (ClientWidth > 0) and (ClientHeight > 0)
  then
    begin
      Buffer := TBitMap.Create;
      Buffer.Width := ClientWidth;
      Buffer.Height := ClientHeight;

      if BGPictureIndex = -1
      then
        begin
          w := RectWidth(ClRect);
          h := RectHeight(ClRect);
          rw := Buffer.Width;
          rh := Buffer.Height;
          with Buffer.Canvas do
          begin
            XCnt := rw div w;
            YCnt := rh div h;
            for X := 0 to XCnt do
            for Y := 0 to YCnt do
            begin
              if X * w + w > rw then XO := X * W + W - rw else XO := 0;
              if Y * h + h > rh then YO := Y * h + h - rh else YO := 0;
                CopyRect(Rect(X * w, Y * h,X * w + w - XO, Y * h + h - YO),
                   FSkinPicture.Canvas,
                   Rect(SkinRect.Left + ClRect.Left,
                        SkinRect.Top + ClRect.Top,
                        SkinRect.Left + ClRect.Right - XO,
                         SkinRect.Top + ClRect.Bottom - YO));
            end;
          end;
        end
      else
        begin
          B := TBitMap(FSD.FActivePictures.Items[BGPictureIndex]);
          XCnt := Width div B.Width;
          YCnt := Height div B.Height;
          for X := 0 to XCnt do
          for Y := 0 to YCnt do
            Buffer.Canvas.Draw(X * B.Width, Y * B.Height, B);
        end;

        // draw controls frame
          for i := 0 to ControlCount - 1 do
            if Controls[i].Visible
            then
               begin
                 R := Controls[i].BoundsRect;
                 Dec(R.Left, 11);
                 Dec(R.Top, 2);
                 Inc(R.Right, 2);
                 Inc(R.Bottom, 2);
                 PaintControlFrame(Buffer.Canvas, Controls[i], R);
               end;
      Canvas.Draw(0, 0, Buffer);
      Buffer.Free;
    end;
end;

procedure TbsSkinControlBar.PaintControlFrame;
var
  LeftB, TopB, RightB, BottomB: TBitMap;
  W, H, IW, IH: Integer;
begin
  GetSkinData;
  if FIndex <> -1
  then
    begin
      LeftB := TBitMap.Create;
      TopB := TBitMap.Create;
      RightB := TBitMap.Create;
      BottomB := TBitMap.Create;
      W := RectWidth(ARect);
      H := RectHeight(ARect);
      IW := RectWidth(ItemRect);
      IH := RectHeight(ItemRect);
      //
      CreateSkinBorderImages(
        Point(12, 3), Point(IW - 3, 3),
        Point(12, IH - 3), Point(IW - 3, IH - 3),
        Rect(11, 2, IW - 2, IH - 2),
        Point(12, 3), Point(W - 3, 3),
        Point(12, H - 3), Point(W - 3, H - 3),
        Rect(11, 2, W - 2, H - 2),
        LeftB, TopB, RightB, BottomB,
        FSkinPicture, ItemRect,  W, H, LeftStretch, TopStretch, RightStretch, BottomStretch);
      //
      Canvas.Draw(ARect.Left, ARect.Top, TopB);
      Canvas.Draw(ARect.Left, ARect.Top + TopB.Height, LeftB);
      Canvas.Draw(ARect.Right - RightB.Width, ARect.Top + TopB.Height, RightB);
      Canvas.Draw(ARect.Left, ARect.Bottom - BottomB.Height, BottomB);
      //
      LeftB.Free;
      TopB.Free;
      RightB.Free;
      BottomB.Free;
    end
  else
    inherited;
end;

procedure TbsSkinControlBar.GetSkinData;
begin
  if (FSD = nil) or FSD.Empty
  then
    FIndex := -1
  else
    FIndex := FSD.GetControlIndex(FSkinDataName);
  BGPictureIndex := -1;
  FSkinPicture := nil;
  if FIndex <> -1
  then
    if TbsDataSkinControl(FSD.CtrlList.Items[FIndex]) is TbsDataSkinControlBar
    then
      with TbsDataSkinControlBar(FSD.CtrlList.Items[FIndex]) do
      begin
        LTPt := LTPoint;
        RTPt := RTPoint;
        LBPt := LBPoint;
        RBPt := RBPoint;
        Self.SkinRect := SkinRect;
        Self.ClRect := ClRect;
        if (PictureIndex <> -1) and (PictureIndex < FSD.FActivePictures.Count)
        then
          FSkinPicture := TBitMap(FSD.FActivePictures.Items[PictureIndex])
        else
          FSkinPicture := nil;
        Self.ItemRect := ItemRect;
        Self.BGPictureIndex := BGPictureIndex;
        Self.LeftStretch := LeftStretch;
        Self.TopStretch := TopStretch;
        Self.RightStretch := RightStretch;
        Self.BottomStretch := BottomStretch;
      end;
end;

procedure TbsSkinControlBar.ChangeSkinData;
var
  R: TRect;
begin
  GetSkinData;
  if FSkinBevel then ReCreateWnd;
  R := ClientRect;
  AdjustClientRect(R);
  RePaint;
end;

procedure TbsSkinControlBar.SetSkinData;
begin
  FSD := Value;
  ChangeSkinData;
end;

procedure TbsSkinControlBar.WMNCCALCSIZE;
begin
  GetSkinData;
  if FIndex <> -1
  then
    begin
      if FSkinBevel then
      with TWMNCCALCSIZE(Message).CalcSize_Params^.rgrc[0] do
      begin
        Inc(Left, ClRect.Left);
        Inc(Top,  ClRect.Top);
        Dec(Right, RectWidth(SkinRect) - ClRect.Right);
        Dec(Bottom, RectHeight(SkinRect) - ClRect.Bottom);
        if Right < Left then Right := Left;
        if Bottom < Top
        then Bottom := Top;
      end;  
    end
  else
    inherited;
end;

procedure TbsSkinControlBar.WMNCPAINT(var Message: TMessage);
begin
  GetSkinData;
  if FIndex <> -1
  then
    begin
      if FSkinBevel then PaintNCSkin(0, False);
    end
  else
    inherited;
end;

procedure TbsSkinControlBar.CreateParams;
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style and not WS_BORDER;
    ExStyle := ExStyle and not WS_EX_CLIENTEDGE;
  end;
end;

procedure TbsSkinControlBar.WMEraseBkgnd;
begin
  if FIndex = -1 then inherited else Message.Result := 1;
end;


{ TbsGroupButton }

type
  TbsGroupButton = class(TbsSkinCheckRadioBox)
  private
    FInClick: Boolean;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
  public
    constructor InternalCreate(RadioGroup: TbsSkinCustomRadioGroup);
    destructor Destroy; override;
  end;

  TbsCheckGroupButton = class(TbsSkinCheckRadioBox)
  private
    FInClick: Boolean;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
  public
    constructor InternalCreate(CheckGroup: TbsSkinCustomCheckGroup);
    destructor Destroy; override;
  end;


constructor TbsGroupButton.InternalCreate(RadioGroup: TbsSkinCustomRadioGroup);
begin
  inherited Create(RadioGroup);
  RadioGroup.FButtons.Add(Self);
  Visible := False;
  Enabled := RadioGroup.Enabled;
  ParentShowHint := False;
  OnClick := RadioGroup.ButtonClick;
  Parent := RadioGroup;
  Radio := True;
  CanFocused := True;
  SkinDataName := 'radiobox';
  GroupIndex := 1;
  Flat := True;
end;

destructor TbsGroupButton .Destroy;
begin
  TbsSkinCustomRadioGroup(Owner).FButtons.Remove(Self);
  inherited Destroy;
end;

procedure TbsGroupButton .CNCommand(var Message: TWMCommand);
begin
  if not FInClick then
  begin
    FInClick := True;
    try
      if ((Message.NotifyCode = BN_CLICKED) or
        (Message.NotifyCode = BN_DOUBLECLICKED)) and
        TbsSkinCustomRadioGroup(Parent).CanModify then
        inherited;
    except
      Application.HandleException(Self);
    end;
    FInClick := False;
  end;
end;

procedure TbsGroupButton.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  TbsSkinCustomRadioGroup(Parent).KeyPress(Key);
  if (Key = #8) or (Key = ' ') then
  begin
    if not TbsSkinCustomRadioGroup(Parent).CanModify then Key := #0;
  end;
end;

procedure TbsGroupButton.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  TbsSkinCustomRadioGroup(Parent).KeyDown(Key, Shift);
end;

constructor TbsCheckGroupButton.InternalCreate(CheckGroup: TbsSkinCustomCheckGroup);
begin
  inherited Create(CheckGroup);
  CheckGroup.FButtons.Add(Self);
  Visible := False;
  Enabled := CheckGroup.Enabled;
  ParentShowHint := False;
  OnClick := CheckGroup.ButtonClick;
  Parent := CheckGroup;
  Radio := False;
  CanFocused := True;
  SkinDataName := 'checkbox';
  Flat := True;
end;

destructor TbsCheckGroupButton .Destroy;
begin
  TbsSkinCustomCheckGroup(Owner).FButtons.Remove(Self);
  inherited Destroy;
end;

function TbsSkinCustomCheckGroup.CanModify: Boolean;
begin
  Result := True;
end;

procedure TbsSkinCustomCheckGroup.GetChildren(Proc: TGetChildProc; Root: TComponent);
begin
end;

procedure TbsCheckGroupButton .CNCommand(var Message: TWMCommand);
begin
  if not FInClick then
  begin
    FInClick := True;
    try
      if ((Message.NotifyCode = BN_CLICKED) or
        (Message.NotifyCode = BN_DOUBLECLICKED)) and
        TbsSkinCustomCheckGroup(Parent).CanModify then
        inherited;
    except
      Application.HandleException(Self);
    end;
    FInClick := False;
  end;
end;

procedure TbsCheckGroupButton .KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  TbsSkinCustomCheckGroup(Parent).KeyPress(Key);
  if (Key = #8) or (Key = ' ') then
  begin
    if not TbsSkinCustomCheckGroup(Parent).CanModify then Key := #0;
  end;
end;

procedure TbsCheckGroupButton .KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  TbsSkinCustomCheckGroup(Parent).KeyDown(Key, Shift);
end;

{ TbsSkinCustomRadioGroup }

constructor TbsSkinCustomRadioGroup.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := [csSetCaption, csDoubleClicks];
  FButtons := TList.Create;
  FItems := TStringList.Create;
  TStringList(FItems).OnChange := ItemsChange;
  FItemIndex := -1;
  FColumns := 1;
  FButtonSkinDataName := 'radiobox';
  FButtonDefaultFont := TFont.Create;
  with FButtonDefaultFont do
  begin
    Name := 'ËÎÌו';
    Charset := GB2312_CHARSET;
    Style := [];
    Height := -12;
  end;
end;

procedure TbsSkinCustomRadioGroup.SetImages(Value: TCustomImageList);
var
  I: Integer;
begin
  FImages := Value;
  if FButtons.Count > 0
  then
    for I := 0 to FButtons.Count - 1 do
      with TbsGroupButton (FButtons[I]) do
        Images := Self.Images; 
end;

procedure TbsSkinCustomRadioGroup.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if AComponent = FImages then Images := nil;
  end;
end;


procedure TbsSkinCustomRadioGroup.SetButtonDefaultFont;
var
  I: Integer;
begin
  FButtonDefaultFont.Assign(Value);
  if FButtons.Count > 0
  then
    for I := 0 to FButtons.Count - 1 do
      with TbsGroupButton (FButtons[I]) do
      begin
        DefaultFont.Assign(FButtonDefaultFont);
      end;
end;

destructor TbsSkinCustomRadioGroup.Destroy;
begin
  FButtonDefaultFont.Free;
  SetButtonCount(0);
  TStringList(FItems).OnChange := nil;
  FItems.Free;
  FButtons.Free;
  inherited Destroy;
end;

procedure TbsSkinCustomRadioGroup.ChangeSkinData;
begin
  inherited;
  Self.ArrangeButtons;
end;

procedure TbsSkinCustomRadioGroup.SetSkinData;
var
  I: Integer;
begin
  inherited;
  if FButtons.Count > 0
  then
   for I := 0 to FButtons.Count - 1 do
     with TbsGroupButton (FButtons[I]) do
       SkinData := Value;
end;

procedure TbsSkinCustomRadioGroup.SetButtonSkinDataName;
var
  I: Integer;
begin
  FButtonSkinDataName := Value;
  if FButtons.Count > 0
  then
   for I := 0 to FButtons.Count - 1 do
     with TbsGroupButton (FButtons[I]) do
       SkinDataName := Value;
end;

procedure TbsSkinCustomRadioGroup.FlipChildren(AllLevels: Boolean);
begin
  { The radio buttons are flipped using BiDiMode }
end;

procedure TbsSkinCustomRadioGroup.ArrangeButtons;
var
  ButtonsPerCol, ButtonWidth, ButtonHeight, TopMargin, I: Integer;
  DeferHandle: THandle;
  ALeft: Integer;
  ButtonsRect: TRect;
begin
  if (FButtons.Count <> 0) and not FReading then
  begin
    ButtonsRect := Rect(0, 0, Width, Height);
    AdjustClientRect(ButtonsRect);
    ButtonsPerCol := (FButtons.Count + FColumns - 1) div FColumns;
    ButtonWidth := RectWidth(ButtonsRect) div FColumns - 2;
    I := RectHeight(ButtonsRect);
    ButtonHeight := I div ButtonsPerCol;
    TopMargin := ButtonsRect.Top;
    DeferHandle := BeginDeferWindowPos(FButtons.Count);
    try
      for I := 0 to FButtons.Count - 1 do
        with TbsGroupButton(FButtons[I]) do
        begin
          BiDiMode := Self.BiDiMode;
          ALeft := (I div ButtonsPerCol) * ButtonWidth + ButtonsRect.Left + 1;
          if UseRightToLeftAlignment then
            ALeft := RectWidth(ButtonsRect) - ALeft - ButtonWidth;
          DeferHandle := DeferWindowPos(DeferHandle, Handle, 0,
            ALeft,
            (I mod ButtonsPerCol) * ButtonHeight + TopMargin,
            ButtonWidth, ButtonHeight,
            SWP_NOZORDER or SWP_NOACTIVATE);
          Visible := True;
        end;
    finally
      EndDeferWindowPos(DeferHandle);
    end;
  end;
end;

procedure TbsSkinCustomRadioGroup.ButtonClick(Sender: TObject);
begin
  if not FUpdating then
  begin
    FItemIndex := FButtons.IndexOf(Sender);
    Changed;
    Click;
  end;
end;

procedure TbsSkinCustomRadioGroup.ItemsChange(Sender: TObject);
begin
  if not FReading then
  begin
    if FItemIndex >= FItems.Count then FItemIndex := FItems.Count - 1;
    UpdateButtons;
  end;
end;

procedure TbsSkinCustomRadioGroup.Loaded;
begin
  inherited Loaded;
  ArrangeButtons;
end;

procedure TbsSkinCustomRadioGroup.ReadState(Reader: TReader);
begin
  FReading := True;
  inherited ReadState(Reader);
  FReading := False;
  UpdateButtons;
end;

procedure TbsSkinCustomRadioGroup.UpDateButtonsFont;
var
  i: Integer;
begin
  if FButtons.Count > 0
  then
   for I := 0 to FButtons.Count - 1 do
     with TbsGroupButton (FButtons[I]) do
     begin
       DefaultFont.Assign(FButtonDefaultFont);
       UseSkinFont := Self.UseSkinFont;
       Invalidate;
     end;
end;

procedure TbsSkinCustomRadioGroup.SetButtonCount(Value: Integer);
var
  i: Integer;
begin
  while FButtons.Count < Value do TbsGroupButton .InternalCreate(Self);
  while FButtons.Count > Value do TbsGroupButton (FButtons.Last).Free;
  if FButtons.Count > 0
  then
   for I := 0 to FButtons.Count - 1 do
     with TbsGroupButton (FButtons[I]) do
     begin
       ImageIndex := I;
       SkinData := Self.SkinData;
       SkinDataName := ButtonSkinDataName;
       DefaultFont.Assign(FButtonDefaultFont);
       UseSkinFont := Self.UseSkinFont;
     end;
end;

procedure TbsSkinCustomRadioGroup.SetColumns(Value: Integer);
begin
  if Value < 1 then Value := 1;
  if Value > 16 then Value := 16;
  if FColumns <> Value then
  begin
    FColumns := Value;
    ArrangeButtons;
    Invalidate;
  end;
end;

procedure TbsSkinCustomRadioGroup.SetItemIndex(Value: Integer);
begin
  if FReading then FItemIndex := Value else
  begin
    if Value < -1 then Value := -1;
    if Value >= FButtons.Count then Value := FButtons.Count - 1;
    if FItemIndex <> Value then
    begin
      if FItemIndex >= 0 then
        TbsGroupButton (FButtons[FItemIndex]).Checked := False;
      FItemIndex := Value;
      if FItemIndex >= 0 then
        TbsGroupButton (FButtons[FItemIndex]).Checked := True;
    end;
  end;
end;

procedure TbsSkinCustomRadioGroup.SetItems(Value: TStrings);
begin
  FItems.Assign(Value);
end;

procedure TbsSkinCustomRadioGroup.UpdateButtons;
var
  I: Integer;
begin
  SetButtonCount(FItems.Count);
  for I := 0 to FButtons.Count - 1 do
    TbsGroupButton (FButtons[I]).Caption := FItems[I];
  if FItemIndex >= 0 then
  begin
    FUpdating := True;
    TbsGroupButton (FButtons[FItemIndex]).Checked := True;
    FUpdating := False;
  end;
  ArrangeButtons;
  Invalidate;
end;

procedure TbsSkinCustomRadioGroup.CMEnabledChanged(var Message: TMessage);
var
  I: Integer;
begin
  inherited;
  for I := 0 to FButtons.Count - 1 do
    TbsGroupButton(FButtons[I]).Enabled := Enabled;
end;

procedure TbsSkinCustomRadioGroup.CMFontChanged(var Message: TMessage);
begin
  inherited;
  ArrangeButtons;
end;

procedure TbsSkinCustomRadioGroup.WMSize(var Message: TWMSize);
begin
  inherited;
  ArrangeButtons;
end;

function TbsSkinCustomRadioGroup.CanModify: Boolean;
begin
  Result := True;
end;

procedure TbsSkinCustomRadioGroup.GetChildren(Proc: TGetChildProc; Root: TComponent);
begin
end;


{ TbsSkinCustomCheckGroup }

constructor TbsSkinCustomCheckGroup.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := [csSetCaption, csDoubleClicks];
  FButtons := TList.Create;
  FItems := TStringList.Create;
  TStringList(FItems).OnChange := ItemsChange;
  FColumns := 1;
  FItemIndex := -1;
  FButtonSkinDataName := 'checkbox';
  FButtonDefaultFont := TFont.Create;
  with FButtonDefaultFont do
  begin
    Name := 'ËÎÌו';
    Charset := GB2312_CHARSET;
    Style := [];
    Height := -12;
  end;
end;

procedure TbsSkinCustomCheckGroup.UpDateButtonsFont;
var
  i: Integer;
begin
  if FButtons.Count > 0
  then
   for I := 0 to FButtons.Count - 1 do
     with TbsCheckGroupButton (FButtons[I]) do
     begin
       DefaultFont.Assign(FButtonDefaultFont);
       UseSkinFont := Self.UseSkinFont;
       Invalidate;
     end;
end;

procedure TbsSkinCustomCheckGroup.SetButtonDefaultFont;
var
  I: Integer;
begin
  FButtonDefaultFont.Assign(Value);
  if FButtons.Count > 0
  then
    for I := 0 to FButtons.Count - 1 do
      with TbsCheckGroupButton (FButtons[I]) do
        DefaultFont.Assign(FButtonDefaultFont);
end;

destructor TbsSkinCustomCheckGroup.Destroy;
begin
  FButtonDefaultFont.Free;
  SetButtonCount(0);
  TStringList(FItems).OnChange := nil;
  FItems.Free;
  FButtons.Free;
  inherited Destroy;
end;

procedure TbsSkinCustomCheckGroup.SetImages(Value: TCustomImageList);
var
  I: Integer;
begin
  FImages := Value;
  if FButtons.Count > 0
  then
    for I := 0 to FButtons.Count - 1 do
      with TbsCheckGroupButton (FButtons[I]) do
        Images := Self.Images;
end;

procedure TbsSkinCustomCheckGroup.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if AComponent = FImages then Images := nil;
  end;
end;

function TbsSkinCustomCheckGroup.GetCheckedStatus(Index: Integer): Boolean;
begin
  if (Index >= 0) and (Index < FButtons.Count)
  then
    Result := TbsCheckGroupButton(FButtons[Index]).Checked
  else
    Result := False;
end;

procedure TbsSkinCustomCheckGroup.SetCheckedStatus(Index: Integer; Value: Boolean);
begin
  if (Index >= 0) and (Index < FButtons.Count)
  then
    TbsCheckGroupButton(FButtons[Index]).Checked := Value;
end;

procedure TbsSkinCustomCheckGroup.UpdateButtons;
var
  I: Integer;
begin
  SetButtonCount(FItems.Count);
  for I := 0 to FButtons.Count - 1 do
    TbsGroupButton (FButtons[I]).Caption := FItems[I];
  ArrangeButtons;
  Invalidate;
end;

procedure TbsSkinCustomCheckGroup.ChangeSkinData;
begin
  inherited;
  Self.ArrangeButtons;
end;

procedure TbsSkinCustomCheckGroup.SetSkinData;
var
  I: Integer;
begin
  inherited;
  if FButtons.Count > 0
  then
   for I := 0 to FButtons.Count - 1 do
     with TbsCheckGroupButton (FButtons[I]) do
       SkinData := Value;
end;

procedure TbsSkinCustomCheckGroup.SetButtonSkinDataName;
var
  I: Integer;
begin
  FButtonSkinDataName := Value;
  if FButtons.Count > 0
  then
   for I := 0 to FButtons.Count - 1 do
     with TbsCheckGroupButton (FButtons[I]) do
       SkinDataName := Value;
end;

procedure TbsSkinCustomCheckGroup.FlipChildren(AllLevels: Boolean);
begin
  { The radio buttons are flipped using BiDiMode }
end;

procedure TbsSkinCustomCheckGroup.ArrangeButtons;
var
  ButtonsPerCol, ButtonWidth, ButtonHeight, TopMargin, I: Integer;
  DeferHandle: THandle;
  ALeft: Integer;
  ButtonsRect: TRect;
begin
  if (FButtons.Count <> 0) and not FReading then
  begin
    ButtonsRect := Rect(0, 0, Width, Height);
    AdjustClientRect(ButtonsRect);
    ButtonsPerCol := (FButtons.Count + FColumns - 1) div FColumns;
    ButtonWidth := RectWidth(ButtonsRect) div FColumns - 2;
    I := RectHeight(ButtonsRect);
    ButtonHeight := I div ButtonsPerCol;
    TopMargin := ButtonsRect.Top;
    DeferHandle := BeginDeferWindowPos(FButtons.Count);
    try
      for I := 0 to FButtons.Count - 1 do
        with TbsCheckGroupButton(FButtons[I]) do
        begin
          BiDiMode := Self.BiDiMode;
          ALeft := (I div ButtonsPerCol) * ButtonWidth + ButtonsRect.Left + 1;
          if UseRightToLeftAlignment then
            ALeft := RectWidth(ButtonsRect) - ALeft - ButtonWidth;
          DeferHandle := DeferWindowPos(DeferHandle, Handle, 0,
            ALeft,
            (I mod ButtonsPerCol) * ButtonHeight + TopMargin,
            ButtonWidth, ButtonHeight,
            SWP_NOZORDER or SWP_NOACTIVATE);
          Visible := True;
        end;
    finally
      EndDeferWindowPos(DeferHandle);
    end;
  end;
end;

procedure TbsSkinCustomCheckGroup.ButtonClick(Sender: TObject);
begin
  if not FUpdating then
  begin
    FItemIndex := FButtons.IndexOf(Sender);
    Changed;
    Click;
  end;
end;

procedure TbsSkinCustomCheckGroup.ItemsChange(Sender: TObject);
begin
  if not FReading then
  begin
    UpdateButtons;
  end;
end;

procedure TbsSkinCustomCheckGroup.Loaded;
begin
  inherited Loaded;
  ArrangeButtons;
end;

procedure TbsSkinCustomCheckGroup.ReadState(Reader: TReader);
begin
  FReading := True;
  inherited ReadState(Reader);
  FReading := False;
  UpdateButtons;
end;

procedure TbsSkinCustomCheckGroup.SetButtonCount(Value: Integer);
var
  i: Integer;
begin
  while FButtons.Count < Value do TbsCheckGroupButton .InternalCreate(Self);
  while FButtons.Count > Value do TbsCheckGroupButton (FButtons.Last).Free;
  if FButtons.Count > 0
  then
   for I := 0 to FButtons.Count - 1 do
     with TbsCheckGroupButton (FButtons[I]) do
     begin
       ImageIndex := I;
       SkinData := Self.SkinData;
       SkinDataName := ButtonSkinDataName;
       DefaultFont.Assign(FButtonDefaultFont);
       UseSkinFont := Self.UseSkinFont;
     end;
end;

procedure TbsSkinCustomCheckGroup.SetColumns(Value: Integer);
begin
  if Value < 1 then Value := 1;
  if Value > 16 then Value := 16;
  if FColumns <> Value then
  begin
    FColumns := Value;
    ArrangeButtons;
    Invalidate;
  end;
end;

procedure TbsSkinCustomCheckGroup.SetItems(Value: TStrings);
begin
  FItems.Assign(Value);
end;

procedure TbsSkinCustomCheckGroup.CMEnabledChanged(var Message: TMessage);
var
  I: Integer;
begin
  inherited;
  for I := 0 to FButtons.Count - 1 do
    TbsCheckGroupButton(FButtons[I]).Enabled := Enabled;
end;

procedure TbsSkinCustomCheckGroup.CMFontChanged(var Message: TMessage);
begin
  inherited;
  ArrangeButtons;
end;

procedure TbsSkinCustomCheckGroup.WMSize(var Message: TWMSize);
begin
  inherited;
  ArrangeButtons;
end;


constructor TbsSkinCustomTreeView.Create(AOwner: TComponent);
begin
  inherited;
  FVScrollBar := nil;
  FHScrollBar := nil;
  FSD := nil;
  FIndex := -1;
  FDefaultFont := TFont.Create;
  with FDefaultFont do
  begin
    Name := 'ËÎÌו';
    Charset := GB2312_CHARSET;
    Style := [];
    Height := -12;
  end;
  FDefaultColor := clWindow;
  FSkinDataName := 'treeview';
  FInCheckScrollBars := False;
  FUseSkinFont := False;
end;

destructor TbsSkinCustomTreeView.Destroy;
begin
  FDefaultFont.Free;
  inherited;
end;

procedure TbsSkinCustomTreeView.CMVisibleChanged;
begin
  inherited;
  if FVScrollBar <> nil then FVScrollBar.Visible := Self.Visible;
  if FHScrollBar <> nil then FHScrollBar.Visible := Self.Visible; 
end;

procedure TbsSkinCustomTreeView.Loaded;
begin
  inherited;
  ChangeSkinData;
end;

procedure TbsSkinCustomTreeView.SetDefaultColor;
begin
  FDefaultColor := Value;
  if FIndex = -1 then Color := Value;
end;

procedure TbsSkinCustomTreeView.SetDefaultFont;
begin
  FDefaultFont.Assign(Value);
  if FIndex =  -1 then Font.Assign(Value);
end;

procedure TbsSkinCustomTreeView.ChangeSkinData;
begin
  if (csLoading in ComponentState) then Exit;
  if (FSD = nil) or FSD.Empty
  then
    FIndex := -1
  else
    FIndex := FSD.GetControlIndex(FSkinDataName);

  if FIndex <> -1
  then
    begin
      if TbsDataSkinControl(FSD.CtrlList.Items[FIndex]) is
         TbsDataSkinTreeView
      then
        with TbsDataSkinTreeView(FSD.CtrlList.Items[FIndex]) do
        begin
          if FUseSkinFont
          then
            begin
              Font.Name := FontName;
              Font.Style := FontStyle;
              Font.Height := FontHeight;
            end
          else
            Font.Assign(FDefaultFont);
            Font.Color := FontColor;
            Color := BGColor;
        end;
    end
  else
    begin
      Color := FDefaultColor;
      Font.Assign(FDefaultFont);
    end;

   if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
   then
     Font.Charset := SkinData.ResourceStrData.CharSet
   else
     Font.Charset := FDefaultFont.Charset;

  if Images <> nil then Images.BkColor := Self.Color;
  if StateImages <> nil then StateImages.BkColor := Self.Color;
  UpDateScrollBars;
  if FVScrollBar <> nil then FVScrollBar.Align := FVScrollBar.Align;
  if FHScrollBar <> nil then FHScrollBar.Align := FHScrollBar.Align;
end;

procedure TbsSkinCustomTreeView.SetSkinData;
begin
  FSD := Value;
  if (FSD <> nil) then
  if not FSD.Empty and not (csDesigning in ComponentState)
  then
    ChangeSkinData;
end;

procedure TbsSkinCustomTreeView.Notification;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FSD) then FSD := nil;
  if (Operation = opRemove) and (AComponent = FVScrollBar)
  then FVScrollBar := nil;
  if (Operation = opRemove) and (AComponent = FHScrollBar)
  then FHScrollBar := nil;
end;

procedure TbsSkinCustomTreeView.Change;
begin
  inherited;
  UpDateScrollBars;
end;

procedure TbsSkinCustomTreeView.WMNCCALCSIZE;
begin
end;

procedure TbsSkinCustomTreeView.WMNCPAINT;
begin
end;

procedure TbsSkinCustomTreeView.SetVScrollBar;
begin
  FVScrollBar := Value;
  if FVScrollBar <> nil
  then
    with FVScrollBar do
    begin
      Enabled := True;
      Visible := False;
      OnChange := OnVScrollBarChange;
    end;
  UpDateScrollBars;
end;

procedure TbsSkinCustomTreeView.SetHScrollBar;
begin
  FHScrollBar := Value;
  if FHScrollBar <> nil
  then
    with FHScrollBar do
    begin
      Enabled := True;
      Visible := False;
      OnChange := OnHScrollBarChange;
    end;
  UpDateScrollBars;
end;

procedure TbsSkinCustomTreeView.WndProc;
begin
  inherited;
  case Message.Msg of
    WM_SIZE, WM_PAINT:
      if not FInCheckScrollBars then UpDateScrollBars;
    WM_KEYDOWN, WM_LBUTTONUP:
       UpDateScrollBars;
  end;
end;

procedure TbsSkinCustomTreeView.UpDateScrollBars;
var
  Min, Max, Pos, Page: Integer;
  R: TRect;
  OldVisible, HVisibleChanged, VVisibleChanged: Boolean;
begin
  if (csLoading in ComponentState) or FInCheckScrollBars then Exit;
  VVisibleChanged := False;
  HVisibleChanged := False;
  if FVScrollBar <> nil
  then
    begin
      GetScrollRange(Handle, SB_VERT, Min, Max);
      Pos := GetScrollPos(Handle, SB_VERT);
      Page := TreeView_GetVisibleCount(Handle);
      FInCheckScrollBars := True;
      OldVisible := FVScrollBar.Visible;
      FVScrollBar.Visible := (Max > 0) and (Max >= Page) and
                   (Max < treeview_GetCount(Handle)) and Self.Visible;
      VVisibleChanged := FVScrollBar.Visible <> OldVisible;
      FInCheckScrollBars := False;
      if FVScrollBar.Visible
      then
         FVScrollBar.SetRange(Min, Max, Pos, Page);
    end;

  if FHScrollBar <> nil
  then
    begin
      GetScrollRange(Handle, SB_HORZ, Min, Max);
      Pos := GetScrollPos(Handle, SB_HORZ);
      FInCheckScrollBars := True;
      OldVisible := FHScrollBar.Visible;
      FHScrollBar.Visible := (Max > Width) and Self.Visible;
      HVisibleChanged := FHScrollBar.Visible <> OldVisible;
      FInCheckScrollBars := False;
      if FHScrollBar.Visible
      then
        FHScrollBar.SetRange(Min, Max, Pos, Width);
    end;

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
      FInCheckScrollBars := True;
      R := Parent.ClientRect;
      TParentControl(Parent).AlignControls(nil, R);
      FInCheckScrollBars := False;
    end;
end;

procedure TbsSkinCustomTreeView.OnVScrollBarChange;
begin
  SendMessage(Handle, WM_VSCROLL,
   MakeWParam(SB_THUMBPOSITION, FVSCROLLBAR.Position), 0);
end;

procedure TbsSkinCustomTreeView.OnHScrollBarChange;
begin
 SendMessage(Handle, WM_HSCROLL,
   MakeWParam(SB_THUMBPOSITION, FHSCROLLBAR.Position), 0);
end;

procedure TbsSkinCustomTreeView.CreateParams;
begin
  inherited;
  with Params do
    Style := Style and not (WS_HSCROLL or WS_VSCROLL);
end;

constructor TbsSkinCustomListView.Create(AOwner: TComponent);
begin
  inherited;
  FHeaderSkinDataName := 'resizebutton';
  FHIndex := -1;
  FHeaderHandle := 0;
  FHeaderInstance := MakeObjectInstance(HeaderWndProc);
  FDefHeaderProc := nil;
  FInCheckScrollBars := False;
  FVScrollBar := nil;
  FHScrollBar := nil;
  FOldVScrollBarPos := 0;
  FOldHScrollBarPos := 0;
  FSD := nil;
  FIndex := -1;
  FDefaultFont := TFont.Create;
  with FDefaultFont do
  begin
    Name := 'ËÎÌו';
    Charset := GB2312_CHARSET;
    Style := [];
    Height := -12;
  end;
  Font.Assign(FDefaultFont);
  FDefaultColor := clWindow;
  FSkinDataName := 'listview';
  FUseSkinFont := False;
  FDefaultColor := clWindow;
  FSkinDataName := 'listview';
end;

destructor TbsSkinCustomListView.Destroy;
begin
  FDefaultFont.Free;
  if FHeaderHandle <> 0 then
    SetWindowLong(FHeaderHandle, GWL_WNDPROC, LongInt(FDefHeaderProc));
  FreeObjectInstance(FHeaderInstance);
  FHeaderHandle := 0;
  inherited;
end;

procedure TbsSkinCustomListView.HGetSkinData;
begin
  if (FSD = nil) or FSD.Empty
  then
    FHIndex := -1
  else
    FHIndex := FSD.GetControlIndex(FHeaderSkinDataName);
  if FHIndex <> -1
  then
    if TbsDataSkinControl(FSD.CtrlList.Items[FHIndex]) is TbsDataSkinButtonControl
    then
      with TbsDataSkinButtonControl(FSD.CtrlList.Items[FHIndex]) do
      begin
        HLTPt := LTPoint;
        HRTPt := RTPoint;
        HLBPt := LBPoint;
        HRBPt := RBPoint;
        HSkinRect := SkinRect;
        HClRect := ClRect;
        HStretchEffect := StretchEffect;
        HLeftStretch := LeftStretch;
        HTopStretch := TopStretch;
        HRightStretch := RightStretch;
        HBottomStretch := BottomStretch;
        if (PictureIndex <> -1) and (PictureIndex < FSD.FActivePictures.Count)
        then
          HPicture := TBitMap(FSD.FActivePictures.Items[PictureIndex])
        else
          HPicture := nil;
        //
        HFontColor := FontColor;
        HActiveFontColor := ActiveFontColor;
        HDownFontColor := DownFontColor;
        HActiveSkinRect := ActiveSkinRect;
        HDownSkinRect := DownSkinRect;
        if IsNullRect(HActiveSkinRect) then HActiveSkinRect := SkinRect;
        if IsNullRect(HDownSkinRect) then HDownSkinRect := HActiveSkinRect;
      end
    else
      HPicture := nil;
end;

procedure TbsSkinCustomListView.CreateWnd;
begin
  inherited;
end;

procedure TbsSkinCustomListView.DrawHeaderSection;
var
  SR, BR, DR: TRect;
  S: String;
  B, B1: TBitMap;
  W, H, TX, TY, GX, GY, XO, YO: Integer;
begin
  if (RectWidth(R) <= 0) or (RectHeight(R) <= 0) then Exit;
  S := Column.Caption;
  B := TBitMap.Create;
  W := RectWidth(R);
  H := RectHeight(R);
  B.Width := W;
  B.Height := H;
  BR := Rect(0, 0, B.Width, B.Height);
  HGetSkinData;
  if FHIndex = -1
  then
  with B.Canvas do
  begin
    //
    if Pressed
    then
      begin
        Frame3D(B.Canvas, BR, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
        Brush.Color := BS_XP_BTNDOWNCOLOR;
      end
    else
    if Active
    then
      begin
        Frame3D(B.Canvas, BR, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
        Brush.Color := BS_XP_BTNACTIVECOLOR;
      end
    else
      begin
        Frame3D(B.Canvas, BR, clBtnShadow, clBtnShadow, 1);
        Brush.Color := clBtnFace;
      end;
    //
    FillRect(BR);
    Brush.Style := bsClear;
    Font := Self.Font;
    Font.Color := clBtnText;
  end
  else
  with B.Canvas do
  begin
    Font := Self.Font;
    if Pressed
    then
       begin
         SR := HDownSkinRect;
         Font.Color := HDownFontColor;
       end
     else
       begin
         SR := HSkinRect;
         Font.Color := HFontColor;
       end;
      //
      XO := RectWidth(BR) - RectWidth(HSkinRect);
      YO := RectHeight(BR) - RectHeight(HSkinRect);

      if (HLBPt.X = 0) and (HLBPt.Y = 0)
      then
        begin
          B1 := TBitMap.Create;
          B1.Width := RectWidth(R);
          B1.Height := RectHeight(HSkinRect);
          CreateHSkinImage(HLTPt.X, RectWidth(SR) - HRTPt.X,
            B1, HPicture, SR, B1.Width, B1.Height, HStretchEffect);
          DR := Rect(0, 0, B.Width, B.Height);
          B.Canvas.StretchDraw(DR, B1);
          B1.Free;
        end
      else
        begin
          HNewLTPoint := HLTPt;
          HNewRTPoint := Point(HRTPt.X + XO, HRTPt.Y);
          HNewLBPoint := Point(HLBPt.X, HLBPt.Y + YO);
          HNewRBPoint := Point(HRBPt.X + XO, HRBPt.Y + YO);
          HNewClRect := Rect(HCLRect.Left, HClRect.Top,
          HCLRect.Right + XO, HClRect.Bottom + YO);
          CreateSkinImage(HLTPt, HRTPt, HLBPt, HRBPt, hCLRect,
            HNewLtPoint, HNewRTPoint, HNewLBPoint, HNewRBPoint, HNewCLRect,
            B, HPicture, SR, B.Width, B.Height, True,
            HLeftStretch, HTopStretch, HRightStretch, HBottomStretch,
            HStretchEffect);
        end;
  end;

  if Assigned(FOnDrawHeaderSection)
  then
    FOnDrawHeaderSection(B.Canvas, Column, Pressed, Rect(0, 0, B.Width, B.Height))
  else
  with B.Canvas do
  begin
    Brush.Style := bsClear;
    Inc(BR.Left, 5); Dec(BR.Right, 5);
    if (SmallImages <> nil) and (Column.ImageIndex >= 0) and
        (Column.ImageIndex < SmallImages.Count)
    then
      begin
        CorrectTextbyWidth(B.Canvas, S, RectWidth(BR) - 10 - SmallImages.Width);
        GX := BR.Left;
        if S = Column.Caption then
         case Column.Alignment of
           taRightJustify: GX := BR.Right - TextWidth(S) - SmallImages.Width - 10;
           taCenter: GX := BR.Left + RectWidth(BR) div 2 -
                     (TextWidth(S) + SmallImages.Width + 10) div 2;
         end;
        TX := GX + SmallImages.Width + 10;
        TY := BR.Top + RectHeight(BR) div 2 - TextHeight(S) div 2;
        GY := BR.Top + RectHeight(BR) div 2 - SmallImages.Height div 2;
        SmallImages.Draw(B.Canvas, GX, GY, Column.ImageIndex, True);
      end
     else
       begin
         CorrectTextbyWidth(B.Canvas, S, RectWidth(BR));
         TX := BR.Left;
         TY := BR.Top + RectHeight(BR) div 2 - TextHeight(S) div 2;
         case Column.Alignment of
            taRightJustify: TX := BR.Right - TextWidth(S) - 10;
           taCenter: TX := RectWidth(BR) div 2 - TextWidth(S) div 2;
         end;
       end;
    TextRect(BR, TX, TY, S);
  end;
  Cnvs.Draw(R.Left, R.Top, B);
  B.Free;
end;

function TbsSkinCustomListView.GetHeaderSectionRect(Index: Integer): TRect;
var
  SectionOrder: array of Integer;
  R: TRect;
begin
  if Self.FullDrag
  then
    begin
      SetLength(SectionOrder, Columns.Count);
      Header_GetOrderArray(FHeaderHandle, Columns.Count, PInteger(SectionOrder));
      Header_GETITEMRECT(FHeaderHandle, SectionOrder[Index] , @R);
    end
  else
    Header_GETITEMRECT(FHeaderHandle, Index, @R);
  Result := R;
end;

procedure TbsSkinCustomListView.PaintHeader;

var
  Cnvs: TControlCanvas;
  i, RightOffset, Xo, YO: Integer;
  DR, R, BGR, HR: TRect;
  PS: TPaintStruct;
  B, B1: TBitMap;
begin
  if DC = 0 then DC := BeginPaint(FHeaderHandle, PS);
  try
    Cnvs := TControlCanvas.Create;
    Cnvs.Handle := DC;
    RightOffset := 0;
    with Cnvs do
    begin
      for i := 0 to Header_GetItemCount(FHeaderHandle) - 1 do
      begin
        R := GetHeaderSectionRect(i);
        DrawHeaderSection(Cnvs, Columns[i], False, (FActiveSection = I) and FHeaderDown, R);
        if RightOffset < R.Right then RightOffset := R.Right;
      end;
    end;
    Windows.GetWindowRect(FHeaderHandle, HR);
    BGR := Rect(RightOffset, 0, RectWidth(HR) + 1, RectHeight(HR));
    HGetSkinData;
    if BGR.Left < BGR.Right then
    if FhIndex = -1
    then
      with Cnvs do
      begin
        Brush.Color := clBtnFace;
        Fillrect(BGR);
        Frame3D(Cnvs, BGR, clBtnShadow, clBtnShadow, 1);
      end
    else
      begin
        //
        B := TBitMap.Create;
        B.Width := RectWidth(BGR);
        B.Height := RectHeight(BGR);
        XO := RectWidth(BGR) - RectWidth(HSkinRect);
        YO := RectHeight(BGR) - RectHeight(HSkinRect);
        if (HLBPt.X = 0) and (HLBPt.Y = 0)
        then
          begin
            B1 := TBitMap.Create;
            B1.Width := RectWidth(BGR);
            B1.Height := RectHeight(HSkinRect);
            CreateHSkinImage2(HLtPt.X, RectWidth(HSkinRect) - HRTPt.X,
              B1, HPicture, HSkinRect, B1.Width, B1.Height, HStretchEffect);
            DR := Rect(0, 0, B.Width, B.Height);
            B.Canvas.StretchDraw(DR, B1);
            B1.Free;
          end
        else
          begin
            HNewLTPoint := HLTPt;
            HNewRTPoint := Point(HRTPt.X + XO, HRTPt.Y);
            HNewLBPoint := Point(HLBPt.X, HLBPt.Y + YO);
            HNewRBPoint := Point(HRBPt.X + XO, HRBPt.Y + YO);
            HNewClRect := Rect(HCLRect.Left, HClRect.Top,
            HCLRect.Right + XO, HClRect.Bottom + YO);
            CreateSkinImage2(HLTPt, HRTPt, HLBPt, HRBPt, HCLRect,
              HNewLtPoint, HNewRTPoint, HNewLBPoint, HNewRBPoint, HNewCLRect,
              B, HPicture, HSkinRect, B.Width, B.Height, True,
              HLeftStretch, HTopStretch, HRightStretch, HBottomStretch,
              HStretchEffect);
          end;
        Cnvs.Draw(BGR.Left, BGR.Top, B);
        B.Free;
      end;
    Cnvs.Handle := 0;
    Cnvs.Free;
  finally
    if DC = 0
    then
      EndPaint(FHeaderHandle, PS)
    else
      ReleaseDC(FHeaderHandle, DC);
  end;
end;

procedure TbsSkinCustomListView.HeaderWndProc(var Message: TMessage);
var
  X, Y: Integer;

function GetSectionFromPoint(P: TPoint): Integer;
var
  i: Integer;
  R: TRect;
begin
  FActiveSection := -1;
  for i := 0 to Columns.Count - 1 do
  begin
    R := GetHeaderSectionRect(i);
    if PtInRect(R, Point(X, Y))
    then
      begin
        FActiveSection := i;
        Break;
      end;
  end;
end;

var
  Info: THDHitTestInfo;
begin
  if Message.Msg  = WM_WINDOWPOSCHANGING
  then
    begin
      TWMWINDOWPOSCHANGING(Message).WindowPos.cx := TWMWINDOWPOSCHANGING(Message).WindowPos.cx + 4;
    end
  else
  if Message.Msg  = WM_PAINT
  then
    begin
      PaintHeader(TWMPAINT(MESSAGE).DC);
    end
  else
  if Message.Msg  = WM_ERASEBKGND
  then
    begin
      Message.Result := 1;
    end
  else
    Message.Result := CallWindowProc(FDefHeaderProc, FHeaderHandle,
      Message.Msg, Message.WParam, Message.LParam);
  case Message.Msg of
    WM_LBUTTONDOWN:
      begin
        X := TWMLBUTTONDOWN(Message).XPos;
        Y := TWMLBUTTONDOWN(Message).YPos;
        GetSectionFromPoint(Point(X, Y));
        //
        Info.Point.X := X;
        Info.Point.Y := Y;
        SendMessage(FHeaderHandle, HDM_HITTEST, 0, Integer(@Info));
        FHeaderDown := not (Info.Flags = HHT_ONDIVIDER);
        //
        RedrawWindow(FHeaderHandle, 0, 0, RDW_INVALIDATE);
      end;
    WM_LBUTTONUP:
      begin
        FHeaderDown := False;
        FActiveSection := -1;
        RedrawWindow(FHeaderHandle, 0, 0, RDW_INVALIDATE);
      end;
  end;
end;

procedure TbsSkinCustomListView.CMVisibleChanged;
begin
  inherited;
  if FVScrollBar <> nil then FVScrollBar.Visible := Self.Visible;
  if FHScrollBar <> nil then FHScrollBar.Visible := Self.Visible;
end;

procedure TbsSkinCustomListView.SetDefaultColor;
begin
  FDefaultColor := Value;
  if FIndex = -1 then Color := Value;
end;

procedure TbsSkinCustomListView.Loaded;
begin
  inherited;
  ChangeSkinData;
end;

procedure TbsSkinCustomListView.ChangeSkinData;
begin
  if (FSD = nil) or FSD.Empty
  then
    FIndex := -1
  else
    FIndex := FSD.GetControlIndex(FSkinDataName);
  if FIndex <> -1
  then
    begin
      if TbsDataSkinControl(FSD.CtrlList.Items[FIndex]) is
         TbsDataSkinListView
      then
      with TbsDataSkinListView(FSD.CtrlList.Items[FIndex]) do
      begin
        if FUseSkinFont
          then
            begin
              Font.Name := FontName;
              Font.Style := FontStyle;
              Font.Height := FontHeight;
            end
          else
            Font.Assign(FDefaultFont);
          Font.Color := FontColor;
          Color := BGColor;
      end;
    end
  else
    begin
      Color := FDefaultColor;
      Font := FDefaultFont;
    end;
  if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
  then
    Font.Charset := SkinData.ResourceStrData.CharSet
  else
    Font.CharSet := FDefaultFont.CharSet;
  UpDateScrollBars;
  if FVScrollBar <> nil then FVScrollBar.Align := FVScrollBar.Align;
  if FHScrollBar <> nil then FHScrollBar.Align := FHScrollBar.Align;
  if (ViewStyle = vsReport) and (FHeaderHandle <> 0)
  then
    InvalidateRect(FHeaderHandle, nil, True);
end;

procedure TbsSkinCustomListView.SetDefaultFont;
begin
  FDefaultFont.Assign(Value);
  if FIndex =  -1 then Font.Assign(Value);
end;

procedure TbsSkinCustomListView.SetSkinData;
begin
  FSD := Value;
  if (FSD <> nil) then
  if not FSD.Empty and not (csDesigning in ComponentState)
  then
    ChangeSkinData;
end;

procedure TbsSkinCustomListView.Notification;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FSD) then FSD := nil;
  if (Operation = opRemove) and (AComponent = FVScrollBar)
  then FVScrollBar := nil;
  if (Operation = opRemove) and (AComponent = FHScrollBar)
  then FHScrollBar := nil;
end;

procedure TbsSkinCustomListView.WMNCCALCSIZE;
begin
end;

procedure TbsSkinCustomListView.WMNCPAINT;
begin
end;

procedure TbsSkinCustomListView.SetVScrollBar;
begin
  FVScrollBar := Value;
  if FVScrollBar <> nil
  then
    with FVScrollBar do
    begin
      Enabled := True;
      Visible := False;
      OnChange := OnVScrollBarChange;
    end;
  UpDateScrollBars;
end;

procedure TbsSkinCustomListView.SetHScrollBar;
begin
  FHScrollBar := Value;
  if FHScrollBar <> nil
  then
    with FHScrollBar do
    begin
      Enabled := True;
      Visible := False;
      OnChange := OnHScrollBarChange;
    end;
  UpDateScrollBars;
end;

procedure TbsSkinCustomListView.WndProc;
var
  WndClass: String;
begin
  case Message.Msg of
    WM_PARENTNOTIFY:
       with TWMPARENTNOTIFY(Message) do
       begin
         SetLength(WndClass, 80);
         SetLength(WndClass, GetClassName(ChildWnd, PChar(WndClass), Length(WndClass)));
         if (Event = WM_CREATE) and (FHeaderHandle <> 0) and ShowColumnHeaders and
            (WndClass = 'SysHeader32')
         then
           begin
             SetWindowLong(FHeaderHandle, GWL_WNDPROC, LongInt(FDefHeaderProc));
             FHeaderHandle := 0;
           end;

         if (Event = WM_CREATE) and (FHeaderHandle = 0) and ShowColumnHeaders and
            (WndClass = 'SysHeader32')
         then
           begin
             FHeaderHandle := ChildWnd;
             FDefHeaderProc := Pointer(GetWindowLong(FHeaderHandle, GWL_WNDPROC));
             SetWindowLong(FHeaderHandle, GWL_WNDPROC, LongInt(FHeaderInstance));
           end;
        end;
  end;
  inherited;
  case Message.Msg of
     WM_SIZE, WM_PAINT:
      if not FInCheckScrollBars then UpDateScrollBars;
     WM_KEYDOWN, WM_LBUTTONUP:
      UpDateScrollBars;
  end;
end;

procedure TbsSkinCustomListView.UpDateScrollBars;
begin
  if HandleAllocated and not FromSB and (Width > 5) and (Height > 5) then
  case ViewStyle of
    vsIcon, vsSmallIcon: UpDateScrollBars1;
    vsReport: UpDateScrollBars2;
    vsList: UpDateScrollBars3;
  end;
end;

procedure TbsSkinCustomListView.UpDateScrollBars3;
var
  IC, IPP, Min, Max, Pos, Page: Integer;
  R: TRect;
  IH: Integer;
  OldVisible, HVisibleChanged, VVisibleChanged: Boolean;
begin
  if FInCheckScrollBars then Exit;

  VVisibleChanged := False;
  HVisibleChanged := False;

  if (FVScrollBar <> nil) and FVScrollBar.Visible
  then
    begin
      FInCheckScrollBars := True;
      FVScrollBar.Visible := False;
      FInCheckScrollBars := False;
      VVisibleChanged := True;
    end;
    
  if FHScrollBar <> nil
  then
    begin
      GetScrollRange(Handle, SB_HORZ, Min, Max);
      Pos := GetScrollPos(Handle, SB_HORZ);
      IH := 1;
      if Items.Count > 0
      then
        begin
          ListView_GetItemRect(Handle, 0, R, LVIR_BOUNDS);
          IH := RectWidth(R);
        end;
      if IH = 0 then IH := 1;
      Page := Width div IH;
      IC := ListView_GetItemCount(Handle);
      IPP := ListView_GetCountPerPage(Handle);
      OldVisible := FHScrollBar.Visible;
      FInCheckScrollBars := True;
      FHScrollBar.Visible := (IC > IPP) and Self.Visible;
      FInCheckScrollBars := False;
      HVisibleChanged := FHScrollBar.Visible <> OldVisible;
      if FHScrollBar.Visible
      then
        begin
          FHScrollBar.SetRange(Min, Max, Pos, Page);
          FHScrollBar.SmallChange := 1;
          FHScrollBar.LargeChange := 1;
          FOldHScrollBarPos := Pos;
        end;
   end;

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
      FInCheckScrollBars := True;
      R := Parent.ClientRect;
      TParentControl(Parent).AlignControls(nil, R);
      FInCheckScrollBars := False;
    end;
end;

procedure TbsSkinCustomListView.UpDateScrollBars2;
var
  Min, Max, Pos: Integer;
  OldVisible, HVisibleChanged, VVisibleChanged: Boolean;
  R: TRect;
begin
  if FInCheckScrollBars then Exit;

  VVisibleChanged := False;
  HVisibleChanged := False;

  if FVScrollBar <> nil
  then
    begin
      GetScrollRange(Handle, SB_VERT, Min, Max);
      Pos := GetScrollPos(Handle, SB_VERT);
      OldVisible := FVScrollBar.Visible;
      FInCheckScrollBars := True;
      FVScrollBar.Visible := (Max + 1 > ListView_GetCountPerPage(Handle)) and Self.Visible;;
      FInCheckScrollBars := False;
      VVisibleChanged := FVScrollBar.Visible <> OldVisible;
      if FVScrollBar.Visible
      then
        begin
          FVScrollBar.SetRange(Min, Max, Pos, ListView_GetCountPerPage(Handle));
          FOldVScrollBarPos := Pos;
          FVScrollBar.SmallChange := 1;
          FVScrollBar.LargeChange := ListView_GetCountPerPage(Handle);
          if FVScrollBar.LargeChange < 1 then FVScrollBar.LargeChange := 1;
        end;
    end;
  if FHScrollBar <> nil
  then
    begin
      GetScrollRange(Handle, SB_HORZ, Min, Max);
      Pos := GetScrollPos(Handle, SB_HORZ);
      OldVisible := FHScrollBar.Visible;
      FInCheckScrollBars := True;
      FHScrollBar.Visible  := (Max > Width) and Self.Visible;
      FInCheckScrollBars := False;
      HVisibleChanged := FHScrollBar.Visible <> OldVisible;
      if FHScrollBar.Visible
      then
        begin
          FHScrollBar.SetRange(Min, Max, Pos, Width);
          FOldHScrollBarPos := Pos;
        end;
   end;

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
      FInCheckScrollBars := True;
      R := Parent.ClientRect;
      TParentControl(Parent).AlignControls(nil, R);
      FInCheckScrollBars := False;
    end;
end;

procedure TbsSkinCustomListView.UpDateScrollBars1;
var
  Min, Max, Pos: Integer;
  R: TRect;
  OldVisible, HVisibleChanged, VVisibleChanged: Boolean;
begin
  if FInCheckScrollBars then Exit;

  VVisibleChanged := False;
  HVisibleChanged := False;

  if FVScrollBar <> nil
  then
    begin
      GetScrollRange(Handle, SB_VERT, Min, Max);
      Pos := GetScrollPos(Handle, SB_VERT);
      OldVisible := FVScrollBar.Visible;
      FInCheckScrollBars := True;
      FVScrollBar.Visible  := (Max > Height) and Self.Visible;;
      FInCheckScrollBars := False;
      VVisibleChanged := FVScrollBar.Visible <> OldVisible;
      if FVScrollBar.Visible
      then
        begin
          Listview_GEtItemRect(Handle, 0, R, LVIR_BOUNDS);
          FVScrollBar.SmallChange := RectHeight(R) div 2;
          FVScrollBar.LargeChange := RectHeight(R) div 2;
          if FVScrollBar.SmallChange = 0 then FVScrollBar.SmallChange := 1;
          if FVScrollBar.LargeChange = 0 then FVScrollBar.LargeChange := 1;
          FVScrollBar.SetRange(Min, Max, Pos, Height);
          FOldVScrollBarPos := Pos;
        end;
    end;

  if FHScrollBar <> nil
  then
    begin
      GetScrollRange(Handle, SB_HORZ, Min, Max);
      Pos := GetScrollPos(Handle, SB_HORZ);
      OldVisible := FHScrollBar.Visible;
      FInCheckScrollBars := True;
      FHScrollBar.Visible  := (Max > Width) and Self.Visible;
      FInCheckScrollBars := False;
      HVisibleChanged := FHScrollBar.Visible <> OldVisible;
      if FHScrollBar.Visible
      then
        begin
          Listview_GEtItemRect(Handle, 0, R, LVIR_BOUNDS);
          FHScrollBar.SmallChange := RectHeight(R) div 2;
          FHScrollBar.LargeChange := RectHeight(R) div 2;
          if FHScrollBar.SmallChange = 0 then FHScrollBar.SmallChange := 1;
          if FHScrollBar.LargeChange = 0 then FHScrollBar.LargeChange := 1;
          FHScrollBar.SetRange(Min, Max, Pos, Width);
          FOldHScrollBarPos := Pos;
        end;
   end;

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
      FInCheckScrollBars := True;
      R := Parent.ClientRect;
      TParentControl(Parent).AlignControls(nil, R);
      FInCheckScrollBars := False;
    end;
end;

procedure TbsSkinCustomListView.OnVScrollBarChange;
var
  H: Integer;
  R: TRect;
begin
  FromSB := True;

  if (ViewStyle = vsIcon) or (ViewStyle = vsSmallIcon)
  then
    Scroll(0, FVSCROLLBAR.Position - FOldVScrollBarPos)
  else
    begin
      ListView_GetItemRect(Handle, 0, R, LVIR_BOUNDS);
      H := RectHeight(R);
      Scroll(0, (FVSCROLLBAR.Position - FOldVScrollBarPos) * H);
    end;

  FOldVScrollBarPos := FVSCROLLBAR.Position;
  FromSB := False;
end;

procedure TbsSkinCustomListView.OnHScrollBarChange;
var
  i: Integer;
begin
  FromSB := True;
  if ViewStyle = vsList
  then
    begin
      if FOldHScrollBarPos > FHSCROLLBAR.Position
      then
        begin
          for i := 1 to FOldHScrollBarPos - FHSCROLLBAR.Position do
            SendMessage(Handle, WM_HSCROLL, MakeWParam(SB_LINEUP, 0) , 0)
        end
      else
        begin
          for i := 1 to FHSCROLLBAR.Position - FOldHScrollBarPos do
            SendMessage(Handle, WM_HSCROLL, MakeWParam(SB_LINEDOWN, 0), 0);
        end;
     end
  else
    Scroll(FHSCROLLBAR.Position - FOldHScrollBarPos, 0);
  FOldHScrollBarPos := FHSCROLLBAR.Position;
  FromSB := False;
end;

procedure TbsSkinCustomListView.CreateParams;
begin
  inherited;
  with Params do
    Style := Style and not (WS_HSCROLL or WS_VSCROLL);
end;

constructor TbsSkinRichEdit.Create(AOwner: TComponent);
begin
  inherited;
  FSkinSupport := False;
  FVScrollBar := nil;
  FHScrollBar := nil;
  FOldVScrollBarPos := 0;
  FOldHScrollBarPos := 0;
  FSD := nil;
  FIndex := -1;
  FDefaultFont := TFont.Create;
  with FDefaultFont do
  begin
    Name := 'ËÎÌו';
    Charset := GB2312_CHARSET;
    Style := [];
    Height := -12;
  end;
  Font.Assign(FDefaultFont);
  FDefaultColor := clWindow;
  FSkinDataName := 'richedit';
  ScrollBars := ssBoth;
end;

destructor TbsSkinRichEdit.Destroy;
begin
  FDefaultFont.Free;
  inherited;
end;


function TbsSkinRichEdit.HScrollDisabled: boolean;
var
  P: TPoint;
  BarInfo: TScrollBarInfo;
begin
  BarInfo.cbSize := SizeOf(BarInfo);
  MyGetScrollBarInfo(Handle, OBJID_HSCROLL, BarInfo);
  if STATE_SYSTEM_INVISIBLE and BarInfo.rgstate[0] = STATE_SYSTEM_INVISIBLE
  then
    Result := true
  else
    Result := false;
end;

function TbsSkinRichEdit.VScrollDisabled: boolean;
var
  P: TPoint;
  BarInfo: TScrollBarInfo;
begin
  BarInfo.cbSize := SizeOf(BarInfo);
  MyGetScrollBarInfo(Handle, OBJID_VSCROLL, BarInfo);
  if STATE_SYSTEM_INVISIBLE and BarInfo.rgstate[0] = STATE_SYSTEM_INVISIBLE
  then
    Result := true
  else
    Result := false;
end;

procedure TbsSkinRichEdit.Change;
begin
  inherited;
  UpDateScrollBars;
end;

procedure TbsSkinRichEdit.WMMOUSEWHEEL;
begin
  inherited;
  UpDateScrollBars;
end;

procedure TbsSkinRichEdit.SetDefaultColor;
begin
  FDefaultColor := Value;
  if (FIndex = -1) and FSkinSupport then Color := Value;
end;

procedure TbsSkinRichEdit.SetDefaultFont;
begin
  FDefaultFont.Assign(Value);
  if (FIndex =  -1) and FSkinSupport then Font.Assign(Value);
end;

procedure TbsSkinRichEdit.Loaded;
begin
  inherited;
  ChangeSkinData;
end;

procedure TbsSkinRichEdit.ChangeSkinData;
begin
  if (FSD = nil) or FSD.Empty
  then
    FIndex := -1
  else
    FIndex := FSD.GetControlIndex(FSkinDataName);
  if FSkinSupport
  then
  if FIndex <> -1
  then
    begin
      if TbsDataSkinControl(FSD.CtrlList.Items[FIndex]) is
         TbsDataSkinRichEdit
      then
      with TbsDataSkinRichEdit(FSD.CtrlList.Items[FIndex]) do
      begin
        Font.Name := FontName;
        Font.Color := FontColor;
        Font.Style := FontStyle;
        Font.Height := FontHeight;
        Color := BGColor;
      end;
    end
  else
    begin
      Color := FDefaultColor;
      Font.Assign(FDefaultFont);
    end;
  if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
  then
    Font.Charset := SkinData.ResourceStrData.CharSet
  else
    Font.CharSet := FDefaultFont.CharSet;
  UpDateScrollBars;
  if FVScrollBar <> nil then FVScrollBar.Align := FVScrollBar.Align;
  if FHScrollBar <> nil then FHScrollBar.Align := FHScrollBar.Align;
end;

procedure TbsSkinRichEdit.SetSkinData;
begin
  FSD := Value;
  if (FSD <> nil) then
  if not FSD.Empty and not (csDesigning in ComponentState)
  then
    ChangeSkinData;
end;

procedure TbsSkinRichEdit.Notification;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FSD) then FSD := nil;
end;

procedure TbsSkinRichEdit.WMNCCALCSIZE;
begin
end;

procedure TbsSkinRichEdit.WMNCPAINT;
begin
  inherited;
end;

procedure TbsSkinRichEdit.SetVScrollBar;
begin
  FVScrollBar := Value;
  if FVScrollBar <> nil
  then
    with FVScrollBar do
    begin
      OnChange := OnVScrollBarChange;
      OnUpButtonClick := OnVScrollBarUpButtonClick;
      OnDownButtonClick := OnVScrollBarDownButtonClick;
    end;
  UpDateScrollBars;
end;

procedure TbsSkinRichEdit.SetHScrollBar;
begin
  FHScrollBar := Value;
  if FHScrollBar <> nil
  then
    with FHScrollBar do
    begin
      OnChange := OnHScrollBarChange;
    end;
  UpDateScrollBars;
end;

procedure TbsSkinRichEdit.WndProc;
begin
  inherited;
  case Message.Msg of
    WM_SIZE, WM_KEYDOWN, WM_LBUTTONUP, WM_LBUTTONDOWN:
    UpDateScrollBars;
  end;
end;

procedure TbsSkinRichEdit.UpDateScrollBars;
var
  Min, Max, Pos, Page: Integer;
  SI: TScrollInfo;
begin
  if FVScrollBar <> nil
  then
    begin
      SI.cbSize := SizeOf(TScrollInfo);
      SI.fMask := SIF_ALL;
      GetScrollInfo(Handle, SB_VERT, SI);
      Min := SI.nMin;
      Max := SI.nMax;
      Page := SI.nPage;
      Pos := SI.nPos;
      if not VScrollDisabled
      then
        begin
          if not FVScrollBar.Enabled
          then
            FVScrollBar.Enabled := True;
          FVScrollBar.SetRange(Min, Max, Pos, Page);
        end
      else
        begin
          FVScrollBar.Enabled := False;
          SetScrollRange(Handle, SB_VERT, 0, 0, False);
        end;
    end;

  if FHScrollBar <> nil
  then
    begin
      SI.cbSize := SizeOf(TScrollInfo);
      SI.fMask := SIF_ALL;
      GetScrollInfo(Handle, SB_HORZ, SI);
      Min := SI.nMin;
      Max := SI.nMax;
      Page := SI.nPage;
      Pos := SI.nPos;
      if not HScrollDisabled
      then
        begin
          if not FHScrollBar.Enabled
          then
            FHScrollBar.Enabled := True;
          FHScrollBar.SetRange(Min, Max, Pos, Page);
        end
      else
        begin
          FHScrollBar.Enabled := False;
          SetScrollRange(Handle, SB_HORZ, 0, 0, False);
        end;
    end;
end;

procedure TbsSkinRichEdit.OnVScrollBarChange;
begin
  SendMessage(Handle, WM_VSCROLL,
   MakeWParam(SB_THUMBPOSITION, FVSCROLLBAR.Position), 0);
end;

procedure TbsSkinRichEdit.OnVScrollBarUpButtonClick;
begin
  if FVScrollBar.Position < FVScrollBar.Max - FVScrollBar.PageSize + 1
  then
    SendMessage(Handle, WM_VSCROLL,
     MakeWParam(SB_LINEDOWN, FVSCROLLBAR.Position), 0);
  UpDateScrollBars;
end;

procedure TbsSkinRichEdit.OnVScrollBarDownButtonClick;
begin
  if FVScrollBar.Position <> 0
  then
    SendMessage(Handle, WM_VSCROLL,
  MakeWParam(SB_LINEUP, FVSCROLLBAR.Position), 0);
  UpDateScrollBars;
end;

procedure TbsSkinRichEdit.OnHScrollBarChange;
begin
  SendMessage(Handle, WM_HSCROLL,
   MakeWParam(SB_THUMBPOSITION, FHSCROLLBAR.Position), 0);
end;

procedure TbsSkinRichEdit.CreateParams;
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style and not WS_BORDER;
    ExStyle := ExStyle and not WS_EX_CLIENTEDGE;
  end;
end;


constructor TbsGraphicSkinControl.Create;
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csOpaque];
  FSD := nil;
  FIndex := -1;
end;

destructor TbsGraphicSkinControl.Destroy;
begin
  inherited Destroy;
end;

procedure TbsGraphicSkinControl.CMMouseEnter;
begin
  inherited;
  if (csDesigning in ComponentState) then Exit;
  if Assigned(FOnMouseEnter) then FOnMouseEnter(Self);
end;

procedure TbsGraphicSkinControl.CMMouseLeave;
begin
  inherited;
  if (csDesigning in ComponentState) then Exit;
  if Assigned(FOnMouseLeave) then FOnMouseLeave(Self);
end;

procedure TbsGraphicSkinControl.BeforeChangeSkinData;
begin
  FIndex := -1;
end;

procedure TbsGraphicSkinControl.ChangeSkinData;
begin
  GetSkinData;
  RePaint;
end;

procedure TbsGraphicSkinControl.SetSkinData;
begin
  FSD := Value;
  if (FSD <> nil) then
  if not FSD.Empty and not (csDesigning in ComponentState)
  then
    ChangeSkinData;
end;

procedure TbsGraphicSkinControl.GetSkinData;
begin
  if (FSD = nil) or FSD.Empty
  then
    FIndex := -1
  else
    FIndex := FSD.GetControlIndex(FSkinDataName);
end;

procedure TbsGraphicSkinControl.Paint;
var
  Buffer: TBitMap;
begin
  if (Width <= 0) or (Height <= 0) then Exit;
  GetSkinData;
  Buffer := TBitMap.Create;
  Buffer.Width := Width;
  Buffer.Height := Height;
  if FIndex <> -1
  then
    CreateControlSkinImage(Buffer)
  else
    CreateControlDefaultImage(Buffer);
  Canvas.Draw(0, 0, Buffer);
  Buffer.Free;
end;

procedure TbsGraphicSkinControl.CreateControlDefaultImage;
begin
end;

procedure TbsGraphicSkinControl.CreateControlSkinImage;
begin
end;

procedure TbsGraphicSkinControl.Notification;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FSD) then FSD := nil;
end;

constructor TbsGraphicSkinCustomControl.Create;
begin
  inherited Create(AOwner);
  FDefaultWidth := 0;
  FDefaultHeight := 0;
  FDefaultFont := TFont.Create;
  FDefaultFont.OnChange := OnDefaultFontChange;
  with FDefaultFont do
  begin
    Name := 'ËÎÌו';
    Charset := GB2312_CHARSET;
    Style := [];
    Height := -12;
  end;
  FUseSkinFont := False;
  StretchEffect := False;
end;

destructor TbsGraphicSkinCustomControl.Destroy;
begin
  FDefaultFont.Free;
  inherited Destroy;
end;

function TbsGraphicSkinCustomControl.GetRealClientWidth: integer;
begin
  Result := NewClRect.Right - NewClRect.Left;
end;

function TbsGraphicSkinCustomControl.GetRealClientHeight: integer;
begin
  Result := NewClRect.Bottom - NewClRect.Top;
end;

function TbsGraphicSkinCustomControl.GetRealClientLeft: integer;
begin
  Result := NewClRect.Left;
end;

function TbsGraphicSkinCustomControl.GetRealClientTop: integer;
begin
  Result := NewClRect.Top;
end;


procedure TbsGraphicSkinCustomControl.SetDefaultWidth;
begin
  FDefaultWidth := Value;
  if (FIndex = -1) and (FDefaultWidth > 0) then Width := FDefaultWidth;
end;

procedure TbsGraphicSkinCustomControl.SetDefaultHeight;
begin
  FDefaultHeight := Value;
  if (FIndex = -1) and (FDefaultHeight > 0) then Height := FDefaultHeight;
end;

procedure TbsGraphicSkinCustomControl.DefaultFontChange;
begin
end;

procedure TbsGraphicSkinCustomControl.SetDefaultFont;
begin
  FDefaultFont.Assign(Value);
  DefaultFontChange;
end;

procedure TbsGraphicSkinCustomControl.OnDefaultFontChange;
begin
  DefaultFontChange;
  if FIndex = -1 then RePaint;
end;

procedure TbsGraphicSkinCustomControl.CreateControlDefaultImage;
var
  R: TRect;
begin
  with B.Canvas do
  begin
    Brush.Color := clBtnFace;
    R := ClientRect;
    FillRect(R);
  end;
end;

procedure TbsGraphicSkinCustomControl.ChangeSkinData;
var
  W, H: Integer;
  UpDate: Boolean;
begin
  GetSkinData;

  W := Width;
  H := Height;

  if FIndex <> -1
  then
    begin
      CalcSize(W, H);
      Update := (W <> Width) or (H <> Height);
      if W <> Width then Width := W;
      if H <> Height then Height := H;
    end
  else
    begin
      UpDate := False;
      if FDefaultWidth > 0 then Width := FDefaultWidth;
      if FDefaultHeight > 0 then Height := FDefaultHeight;
    end;

  if (not UpDate) or (FIndex = -1) then RePaint;

end;

procedure TbsGraphicSkinCustomControl.SetBounds;
var
  UpDate: Boolean;
  R: TRect;
begin
  GetSkinData;
  UpDate := ((Width <> AWidth) or (Height <> AHeight)) and (FIndex <> -1);
  if UpDate
  then
    begin
      CalcSize(AWidth, AHeight);
      if ResizeMode = 0 then NewClRect := ClRect;
    end;

  if Parent is TbsSkinToolbar
  then
    begin
       if TbsSkinToolbar(Parent).AdjustControls
      then
        with TbsSkinToolbar(Parent) do
        begin
          R := GetSkinClientRect;
          ATop := R.Top + RectHeight(R) div 2 - AHeight div 2;
        end;
    end;

  inherited;
  if UpDate then RePaint;
end;

procedure TbsGraphicSkinCustomControl.CalcSize;
var
  XO, YO: Integer;
begin
  if ResizeMode > 0
  then
    begin
      XO := W - RectWidth(SkinRect);
      YO := H - RectHeight(SkinRect);
      NewLTPoint := LTPt;
      case ResizeMode of
        1:
          begin
            NewRTPoint := Point(RTPt.X + XO, RTPt.Y);
            NewLBPoint := Point(LBPt.X, LBPt.Y + YO);
            NewRBPoint := Point(RBPt.X + XO, RBPt.Y + YO);
            NewClRect := Rect(CLRect.Left, ClRect.Top,
              CLRect.Right + XO, ClRect.Bottom + YO);
          end;
        2:
          begin
            H := RectHeight(SkinRect);
            NewRTPoint := Point(RTPt.X + XO, RTPt.Y );
            NewClRect := ClRect;
            Inc(NewClRect.Right, XO);
          end;
        3:
          begin
            W := RectWidth(SkinRect);
            NewLBPoint := Point(LBPt.X, LBPt.Y + YO);
            NewClRect := ClRect;
            Inc(NewClRect.Bottom, YO);
          end;
      end;
    end
  else
    if (FIndex <> -1) and (ResizeMode = 0)
    then
      begin
        W := RectWidth(SkinRect);
        H := RectHeight(SkinRect);
        NewClRect := CLRect;
      end;
end;

procedure TbsGraphicSkinCustomControl.CreateControlSkinImage;
begin
  CreateSkinControlImage(B, Picture, SkinRect);
end;

procedure TbsGraphicSkinCustomControl.CreateSkinControlImage;
begin
  case ResizeMode of
    0:
      begin
        B.Width := RectWidth(R);
        B.Height := RectHeight(R);
        B.Canvas.CopyRect(Rect(0, 0, B.Width, B.Height), SB.Canvas, R);
      end;
    1: CreateSkinImage(LTPt, RTPt, LBPt, RBPt, CLRect,
         NewLtPoint, NewRTPoint, NewLBPoint, NewRBPoint, NewCLRect,
         B, SB, R, Width, Height, True,
         LeftStretch, TopStretch, RightStretch, BottomStretch,
         StretchEffect);
    2: CreateHSkinImage(LTPt.X, RectWidth(SkinRect) - RTPt.X,
          B, SB, R, Width, Height, StretchEffect);
    3: CreateVSkinImage(LTPt.Y, RectHeight(SkinRect) - LBPt.Y,
          B, SB, R, Width, Height, StretchEffect);
  end;
end;

function TbsGraphicSkinCustomControl.GetResizeMode;
begin
  if IsNullRect(SkinRect)
  then
    Result := -1
  else   
  if (RBPt.X <> 0) and (RBPt.Y <> 0)
  then
    Result := 1
  else
  if (RTPt.X <> 0) or (RTPT.Y <> 0)
  then
    Result := 2
  else
  if (LBPt.X <> 0) or (LBPt.Y <> 0)
  then
    Result := 3
  else
    Result := 0;  
end;

function TbsGraphicSkinCustomControl.GetNewRect;
var
  XO, YO: Integer;
  LeftTop, LeftBottom, RightTop, RightBottom: TRect;

function CorrectResizeRect: TRect;
var
  NR: TRect;
begin
  NR := R;
  if PointInRect(LeftTop, R.TopLeft) and
     PointInRect(RightBottom, R.BottomRight)
  then
    begin
      Inc(NR.Right, XO);
      Inc(NR.Bottom, YO);
    end
  else
  if PointInRect(LeftTop, R.TopLeft) and
     PointInRect(RightTop, R.BottomRight)
  then
    Inc(NR.Right, XO)
  else
    if PointInRect(LeftBottom, R.TopLeft) and
       PointInRect(RightBottom, R.BottomRight)
    then
      begin
        Inc(NR.Right, XO);
        OffsetRect(NR, 0, YO);
      end
    else
      if PointInRect(LeftTop, R.TopLeft) and
         PointInRect(LeftBottom, R.BottomRight)
      then
        Inc(NR.Bottom, YO)
      else
        if PointInRect(RightTop, R.TopLeft) and
           PointInRect(RightBottom, R.BottomRight)
        then
          begin
            OffsetRect(NR, XO, 0);
            Inc(NR.Bottom, YO);
          end;
  Result := NR;
end;

begin
  XO := Width - RectWidth(SkinRect);
  YO := Height - RectHeight(SkinRect);
  Result := R;
  case ResizeMode of
    1:
      begin
        LeftTop := Rect(0, 0, LTPt.X, LTPt.Y);
        LeftBottom := Rect(0, LBPt.Y, LBPt.X, RectHeight(SkinRect));
        RightTop := Rect(RTPt.X, 0, RectWidth(SkinRect), RTPt.Y);
        RightBottom := Rect(RBPt.X, RBPt.Y,
          RectWidth(SkinRect), RectHeight(SkinRect));
        Result := R;
        if RectInRect(R, LeftTop)
        then Result := R
        else
        if RectInRect(R, RightTop)
        then OffsetRect(Result, XO, 0)
        else
        if RectInRect(R, LeftBottom)
        then OffsetRect(Result, 0, YO)
        else
        if RectInRect(R, RightBottom)
        then
          OffsetRect(Result,  XO, YO)
        else
          Result := CorrectResizeRect;
      end;
    2:
      begin
        if (R.Left <= LTPt.X) and (R.Right >= RTPt.X)
        then
          Inc(Result.Right, XO)
        else
        if (R.Left >= RTPt.X) and (R.Right > RTPt.X)
        then
          OffsetRect(Result, XO, 0);
      end;
     3:
      begin
        if (R.Top <= LTPt.Y) and (R.Bottom >= LBPt.Y)
        then
          Inc(Result.Bottom, YO)
        else
          if (R.Top >= LBPt.Y) and (R.Bottom > LBPt.X)
          then
            OffsetRect(Result, 0, YO);
      end;
  end;
end;

procedure TbsGraphicSkinCustomControl.GetSkinData;
begin
  inherited;
  if FIndex <> -1
  then
    if TbsDataSkinControl(FSD.CtrlList.Items[FIndex]) is TbsDataSkinCustomControl
    then
      with TbsDataSkinCustomControl(FSD.CtrlList.Items[FIndex]) do
      begin
        LTPt := LTPoint;
        RTPt := RTPoint;
        LBPt := LBPoint;
        RBPt := RBPoint;
        Self.SkinRect := SkinRect;
        Self.ClRect := ClRect;
        Self.StretchEffect := StretchEffect;
        Self.LeftStretch := LeftStretch;
        Self.TopStretch := TopStretch;
        Self.RightStretch := RightStretch;
        Self.BottomStretch := BottomStretch;
        if (PictureIndex <> -1) and (PictureIndex < FSD.FActivePictures.Count)
        then
          Picture := TBitMap(FSD.FActivePictures.Items[PictureIndex])
        else
          Picture := nil;
        ResizeMode := GetResizeMode;
      end
    else
      begin
        ResizeMode := 0;
        Picture := nil;
      end;
end;

//=========== TbsSkinButton ===============
constructor TbsSkinSpeedButton.Create;
begin
  inherited;
  FUseSkinSize := True;
  UseSkinFontColor := True;
  FImageIndex := 0;
  FButtonImages := nil;
  AnimateTimer := nil;
  RepeatTimer := nil;
  FRepeatMode := False;
  FRepeatInterval := 100;
  MorphTimer := nil;
  FAllowAllUpCheck := False;
  FAllowAllUp := False;
  ControlStyle := [csCaptureMouse, csDoubleClicks, csOpaque];
  Transparent := False;
  FSkinDataName := 'toolbutton';
  FDown := False;
  FMouseDown := False;
  FMouseIn := False;
  Width := 25;
  Height := 25;
  FGroupIndex := 0;
  FGlyph := TBitMap.Create;
  FNumGlyphs := 1;
  FMargin := -1;
  FSpacing := 1;
  FLayout := blGlyphLeft;
  FShowCaption := True;
  FWidthWithCaption := 0;
  FWidthWithoutCaption := 0;
  FSkinImagesMenu := nil;
  FUseImagesMenuImage := False;
  FUseImagesMenuCaption := False;
  FDrawColorMarker := False;
  FColorMarkerValue := 0;
end;

destructor TbsSkinSpeedButton.Destroy;
begin
  if RepeatTimer <> nil then StopRepeat;
  if AnimateTimer <> nil then StopAnimate;
  FGlyph.Free;
  StopMorph;
  inherited;
end;

procedure TbsSkinSpeedButton.DrawMenuMarker;
var
  Buffer: TBitMap;
  SR: TRect;
  X, Y: Integer;
begin
  if ADown then SR := MenuMarkerDownRect else
    if AActive then SR := MenuMarkerActiveRect else
      if AFlat then SR := MenuMarkerFlatRect else
        SR := MenuMarkerRect;
  Buffer := TBitMap.Create;
  Buffer.Width := RectWidth(SR);
  Buffer.Height := RectHeight(SR);

  Buffer.Canvas.CopyRect(Rect(0, 0, Buffer.Width, Buffer.Height),
    Picture.Canvas, SR);

  Buffer.Transparent := True;
  Buffer.TransparentMode := tmFixed;
  Buffer.TransparentColor := MenuMarkerTransparentColor;

  X := R.Left + RectWidth(R) div 2 - RectWidth(SR) div 2;
  Y := R.Top + RectHeight(R) div 2 - RectHeight(SR) div 2;

  C.Draw(X, Y, Buffer);

  Buffer.Free;
end;

procedure TbsSkinSpeedButton.OnImagesMenuChanged(Sender: TObject);
begin
  RePaint;
end;

procedure TbsSkinSpeedButton.SetSkinImagesMenu(Value: TbsSkinImagesMenu);
begin
  FSkinImagesMenu := Value;
  if Value <> nil
  then
    begin
      FSkinImagesMenu.OnInternalChange := OnImagesMenuChanged;
    end;
  OnImagesMenuChanged(Self);
end;

procedure TbsSkinSpeedButton.Notification;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FSkinImagesMenu)
  then FSkinImagesMenu := nil;
  if (Operation = opRemove) and (AComponent = FButtonImages)
  then FButtonImages := nil;
end;

procedure TbsSkinSpeedButton.RefreshButton;
begin
  FMouseIn := False;
  FDown := False;
  if EnableMorphing then FMorphKf := 0;
  if EnableAnimation then StopAnimate;
  RePaint;
end;  

procedure TbsSkinSpeedButton.CMDialogChar(var Message: TCMDialogChar);
begin
  with Message do
    if IsAccel(CharCode, Caption) and Enabled and Visible and
      (Parent <> nil) and Parent.Showing then
    begin
      ButtonClick;
      Result := 1;
    end else
      inherited;
end;

function TbsSkinSpeedButton.EnableMorphing: Boolean;
begin
  Result := Morphing and (SkinData <> nil) and not SkinData.Empty and
            SkinData.EnableSkinEffects;
end;

function TbsSkinSpeedButton.EnableAnimation: Boolean;
begin
  Result := (SkinData <> nil) and not SkinData.Empty and
            SkinData.EnableSkinEffects;
end;

procedure TbsSkinSpeedButton.StartAnimate;
begin
  StopAnimate;
  AnimateInc := AInc;
  if not AnimateInc then CurrentFrame := FrameCount else  CurrentFrame := 1;
  AnimateTimer := TTimer.Create(Self);
  AnimateTimer.Enabled := False;
  AnimateTimer.OnTimer := DoAnimate;
  AnimateTimer.Interval := AnimateInterval;
  AnimateTimer.Enabled := True;
end;

procedure TbsSkinSpeedButton.StopAnimate;
begin
  CurrentFrame := 0;
  if AnimateTimer <> nil
  then
    begin
      AnimateTimer.Enabled := False;
      AnimateTimer.Free;
      AnimateTimer := nil;
    end;  
end;

procedure TbsSkinSpeedButton.DoAnimate(Sender: TObject);
begin
  if AnimateInc
  then
    begin
      if CurrentFrame <= FrameCount
      then
        begin
         Inc(CurrentFrame);
         RePaint;
       end;
      if CurrentFrame > FrameCount then StopAnimate;
    end
  else
    begin
      if CurrentFrame >= 0
      then
        begin
          Dec(CurrentFrame);
          RePaint;
        end;
      if CurrentFrame <= 0 then StopAnimate;
    end;
end;

procedure TbsSkinSpeedButton.CalcSize(var W, H: Integer);
begin
  if FUseSkinSize or (ResizeMode = 1) then inherited;
end;

procedure TbsSkinSpeedButton.SetShowCaption(const Value: Boolean);
begin
  if FShowCaption <> Value
  then
    begin
      FShowCaption := Value;
      if (FWidthWithCaption > 0) and (FWidthWithoutCaption > 0)
      then
        begin
          if FShowCaption
          then Width := FWidthWithCaption
          else Width := FWidthWithoutCaption;
        end
      else
        RePaint;
    end;
end;

procedure TbsSkinSpeedButton.SetImageIndex(Value: Integer);
begin
  FImageIndex := Value;
  if Parent is TbsSkinToolBar then RePaint;
end;

procedure TbsSkinSpeedButton.RepeatTimerProc;
begin
  ButtonClick;
end;

procedure TbsSkinSpeedButton.StartRepeat;
begin
  if RepeatTimer <> nil then RepeatTimer.Free;
  RepeatTimer := TTimer.Create(Self);
  RepeatTimer.Enabled := False;
  RepeatTimer.OnTimer := RepeatTimerProc;
  RepeatTimer.Interval := FRepeatInterval;
  RepeatTimer.Enabled := True;
end;

procedure TbsSkinSpeedButton.StopRepeat;
begin
  if RepeatTimer = nil then Exit;
  RepeatTimer.Enabled := False;
  RepeatTimer.Free;
  RepeatTimer := nil;
end;

procedure TbsSkinSpeedButton.DoMorph;
begin
  if (FIndex = -1) or not EnableMorphing
  then
    begin
      if FMouseIn then FMorphKf := 1 else FMorphKf := 0;
      StopMorph;
    end
  else
  if FMouseIn and (FMorphKf < 1)
  then
    begin
      FMorphKf := FMorphKf + MorphInc;
      RePaint;
    end
  else
  if not FMouseIn and (FMorphKf > 0)
  then
    begin
      FMorphKf := FMorphKf - MorphInc;
      RePaint;
    end
  else
    begin
      if FMouseIn then FMorphKf := 1 else FMorphKf := 0;
      StopMorph;
      RePaint;
    end;
end;

procedure TbsSkinSpeedButton.StartMorph;
begin
  if MorphTimer <> nil then Exit;
  MorphTimer := TTimer.Create(Self);
  MorphTimer.Interval := MorphTimerInterval;
  MorphTimer.OnTimer := DoMorph;
  MorphTimer.Enabled := True;
end;

procedure TbsSkinSpeedButton.StopMorph;
begin
  if MorphTimer = nil then Exit;
  MorphTimer.Free;
  MorphTimer := nil;
end;


procedure TbsSkinSpeedButton.SetTransparent;
begin
  if Value
  then ControlStyle := ControlStyle - [csOpaque]
  else ControlStyle := ControlStyle + [csOpaque];
  RePaint;
end;

function TbsSkinSpeedButton.GetTransparent;
begin
  Result := not (csOpaque in ControlStyle);
end;

procedure TbsSkinSpeedButton.SetFlat;
begin
  FFlat := Value;
  Transparent := FFlat;
  RePaint;
end;

procedure TbsSkinSpeedButton.ButtonClick;
begin
  if Assigned(OnClick) then OnClick(Self);
end;

procedure TbsSkinSpeedButton.CMEnabledChanged;
begin
  inherited;
  if EnableMorphing
  then
    begin
      StopMorph;
      FMorphKf := 0;
    end;
  FMouseIn := False;
  RePaint;
end;

procedure TbsSkinSpeedButton.ChangeSkinData;
begin
  StopAnimate;
  StopMorph;
  inherited;
  if EnableMorphing and (FIndex <> -1) and FMouseIn and not Transparent
  then
    FMorphKf := 1;
end;

procedure TbsSkinSpeedButton.SetGroupIndex;
begin
  FGroupIndex := Value;
end;

procedure TbsSkinSpeedButton.ActionChange(Sender: TObject; CheckDefaults: Boolean);

  procedure CopyImage(ImageList: TCustomImageList; Index: Integer);
  begin
    with FGlyph do
    begin
      Width := ImageList.Width;
      Height := ImageList.Height;
      Canvas.Brush.Color := clFuchsia;
      Canvas.FillRect(Rect(0, 0, Width, Height));
      ImageList.Draw(Canvas, 0, 0, Index);
    end;
  end;

begin
  inherited ActionChange(Sender, CheckDefaults);
  if Sender is TCustomAction then
    with TCustomAction(Sender) do
    begin
      if (FGlyph.Empty) and (ActionList <> nil) and (ActionList.Images <> nil) and
        (ImageIndex >= 0) and (ImageIndex < ActionList.Images.Count) then
      begin
        CopyImage(ActionList.Images, ImageIndex);
        RePaint;
      end;
    end;
end;

procedure TbsSkinSpeedButton.ReDrawControl;
begin
  if EnableMorphing and (FIndex <> -1) and not Transparent
  then StartMorph
  else RePaint;
end;

procedure TbsSkinSpeedButton.SetLayout;
begin
  if FLayout <> Value
  then
    begin
      FLayout := Value;
      RePaint;
    end;  
end;

procedure TbsSkinSpeedButton.SetSpacing;
begin
  if Value <> FSpacing
  then
    begin
      FSpacing := Value;
      RePaint;
    end;
end;

procedure TbsSkinSpeedButton.SetMargin;
begin
  if (Value <> FMargin) and (Value >= -1)
  then
    begin
      FMargin := Value;
      RePaint;
    end;
end;

procedure TbsSkinSpeedButton.SetDown;
begin
  FDown := Value;
  if EnableMorphing
  then
     begin
       FMorphKf := 1;
       if not FDown then StartMorph else StopMorph;
     end;
  RePaint;   
  if (GroupIndex <> 0) and FDown and not FAllowAllUp then DoAllUp;
end;

procedure TbsSkinSpeedButton.DoAllUp;
var
  PC: TWinControl;
  i: Integer;
begin
  if Parent = nil then Exit;
  PC := TWinControl(Parent);
  for i := 0 to PC.ControlCount - 1 do
   if (PC.Controls[i] is TbsSkinSpeedButton) and
      (PC.Controls[i] <> Self)
   then
     with TbsSkinSpeedButton(PC.Controls[i]) do
       if (GroupIndex = Self.GroupIndex) and
          (GroupIndex <> 0) and FDown
       then
         Down := False;
end;

procedure TbsSkinSpeedButton.SetGlyph;
begin
  FGlyph.Assign(Value);
  RePaint;
end;

procedure TbsSkinSpeedButton.SetNumGlyphs;
begin
  FNumGlyphs := Value;
  RePaint;
end;

function TbsSkinSpeedButton.GetAnimationFrameRect: TRect;
var
  fs: Integer;
begin
  if RectWidth(AnimateSkinRect) > RectWidth(SkinRect)
  then
    begin
      fs := RectWidth(AnimateSkinRect) div FrameCount;
      Result := Rect(AnimateSkinRect.Left + (CurrentFrame - 1) * fs,
                 AnimateSkinRect.Top,
                 AnimateSkinRect.Left + CurrentFrame * fs,
                 AnimateSkinRect.Bottom);
    end
  else
    begin
      fs := RectHeight(AnimateSkinRect) div FrameCount;
      Result := Rect(AnimateSkinRect.Left,
                     AnimateSkinRect.Top + (CurrentFrame - 1) * fs,
                     AnimateSkinRect.Right,
                     AnimateSkinRect.Top + CurrentFrame * fs);
    end;
end;

procedure TbsSkinSpeedButton.GetSkinData;
begin
  inherited;
  if FIndex <> -1
  then
    begin
      if TbsDataSkinControl(FSD.CtrlList.Items[FIndex]) is TbsDataSkinButtonControl
      then
        with TbsDataSkinButtonControl(FSD.CtrlList.Items[FIndex]) do
        begin
          Self.FontName := FontName;
          Self.FontColor := FontColor;
          Self.ActiveFontColor := ActiveFontColor;
          Self.DownFontColor := DownFontColor;
          Self.DisabledFontColor := DisabledFontColor;
          Self.FontStyle := FontStyle;
          Self.FontHeight := FontHeight;
          Self.ActiveSkinRect := ActiveSkinRect;
          Self.DownSkinRect := DownSkinRect;
          if IsNullRect(ActiveSkinRect) then Self.ActiveSkinRect := SkinRect;
          if IsNullRect(DownSkinRect) then Self.DownSkinRect := Self.ActiveSkinRect;
          Self.DisabledSkinRect := DisabledSkinRect;
          Self.Morphing := Morphing;
          Self.MorphKind := MorphKind;
          if Transparent then Self.Morphing := False;
          Self.AnimateSkinRect := AnimateSkinRect; 
          Self.FrameCount := FrameCount;
          Self.AnimateInterval := AnimateInterval;
          //
          Self.MenuMarkerRect := MenuMarkerRect;
          Self.MenuMarkerActiveRect := MenuMarkerActiveRect;
          Self.MenuMarkerDownRect := MenuMarkerDownRect;
          Self.MenuMarkerFlatRect := MenuMarkerFlatRect;
          Self.MenuMarkerTransparentColor := MenuMarkerTransparentColor;
          if IsNullRect(Self.MenuMarkerActiveRect)
          then
            Self.MenuMarkerActiveRect := Self.MenuMarkerRect;
          if IsNullRect(Self.MenuMarkerDownRect)
          then
            Self.MenuMarkerDownRect := Self.MenuMarkerActiveRect;
          if IsNullRect(Self.MenuMarkerFlatRect)
          then
            Self.MenuMarkerFlatRect := Self.MenuMarkerRect;
          //
        end;
     if EnableAnimation and (AnimateTimer <> nil) and (CurrentFrame <= FrameCount) and
        (CurrentFrame > 0)
     then
       begin
         if AnimateInc
         then
           ActiveSkinRect := GetAnimationFrameRect
         else
           SkinRect := GetAnimationFrameRect;
       end;
   end
   else
     ActiveSkinRect := NullRect;
end;

function TbsSkinSpeedButton.GetGlyphNum;
begin
  if AIsDown and AIsMouseIn and (FNumGlyphs > 2)
  then
    Result := 3
  else
  if AIsMouseIn and (FNumGlyphs > 3)
  then
    Result := 4
  else
    if not Enabled and (FNumGlyphs > 1)
    then
      Result := 2
    else
      Result := 1;
end;

procedure TbsSkinSpeedButton.CreateStrechButtonImage(B: TBitMap; R: TRect;
      ADown, AMouseIn: Boolean);
var
  TR: TRect;
  IL: TCustomImageList;
  E: Boolean;
  _Caption: String;
begin
  //
  if ResizeMode = 0
  then
    B.Canvas.CopyRect(Rect(0, 0, B.Width, B.Height), Picture.Canvas, R)
  else
  if (ResizeMode = 2) or (ResizeMode = 3)
  then
    CreateStretchImage(B, Picture, R, ClRect, True);
  //
  TR := ClRect;
  TR.Right := TR.Right + (B.Width - RectWidth(R));
  TR.Bottom := TR.Bottom + (B.Height - RectHeight(R));
  if FShowCaption then _Caption := Caption else _Caption := '';
  if not FUseSkinFont
  then
    B.Canvas.Font.Assign(FDefaultFont)
  else
    with B.Canvas.Font do
    begin
      Name := FontName;
      Height := FontHeight;
      Style := FontStyle;
    end;
  if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
  then
    B.Canvas.Font.Charset := SkinData.ResourceStrData.CharSet
  else
    B.Canvas.Font.CharSet := FDefaultFont.Charset;
  with B.Canvas.Font do
  begin
    if Enabled and not FUseSkinFontColor
    then
      begin
        Color := FDefaultFont.Color;
      end
    else
    if not Enabled
    then
      Color := DisabledFontColor
    else
    if ADown and AMouseIn
    then
      Color := DownFontColor
    else
      if AMouseIn
      then Color := ActiveFontColor
      else Color := FontColor;
  end;

  if (FSkinImagesMenu <> nil) and (FSkinImagesMenu.SelectedItem <> nil) and
      FUseImagesMenuImage
  then
    begin
      if FUseImagesMenuCaption
      then
        _Caption := FSkinImagesMenu.SelectedItem.Caption;

      DrawImageAndText(B.Canvas, NewClRect, FMargin, FSpacing, FLayout,
        _Caption, FSkinImagesMenu.SelectedItem.ImageIndex, FSkinImagesMenu.Images,
        ADown and AMouseIn, Enabled, False, 0);
    end
  else
  if FGlyph.Empty and (Parent is TbsSkinToolBar)
  then
    begin
      if not Enabled and (TbsSkinToolBar(Parent).DisabledImages <> nil)
      then
        IL := TbsSkinToolBar(Parent).DisabledImages
      else
      if (AMouseIn or ADown) and (TbsSkinToolBar(Parent).HotImages <> nil)
      then
        IL := TbsSkinToolBar(Parent).HotImages
      else
        IL := TbsSkinToolBar(Parent).Images;
      E := Enabled;
      if not Enabled and (TbsSkinToolBar(Parent).DisabledImages <> nil)
      then
        E := True;
      DrawImageAndText(B.Canvas, NewClRect, FMargin, FSpacing, FLayout,
        _Caption, FImageIndex, IL, ADown and AMouseIn, E, FDrawColorMarker, FColorMarkerValue);
    end
  else
  if FGlyph.Empty and (FButtonImages <> nil) and (FImageIndex >= 0) and
     (FImageIndex < FButtonImages.Count)
  then
    begin
      DrawImageAndText(B.Canvas, TR, FMargin, FSpacing, FLayout,
        _Caption, FImageIndex, FButtonImages, ADown and AMouseIn, Enabled, FDrawColorMarker, FColorMarkerValue);
    end
  else
    DrawGlyphAndText(B.Canvas,
      TR, FMargin, FSpacing, FLayout,
      _Caption, FGlyph, FNumGlyphs, GetGlyphNum(ADown, AMouseIn), ADown and AMouseIn, FDrawColorMarker, FColorMarkerValue);
end;

procedure TbsSkinSpeedButton.CreateButtonImage;
var
  IL: TCustomImageList;
  E: Boolean;
  _Caption: String;
begin
  if (not FUseSkinSize) and (ResizeMode <> 1)
  then
    begin
      CreateStrechButtonImage(B, R, ADown, AMouseIn);
      Exit;
    end;
  
  if FShowCaption then _Caption := Caption else _Caption := '';
  CreateSkinControlImage(B, Picture, R);
  if not FUseSkinFont
  then
    B.Canvas.Font.Assign(FDefaultFont)
  else
    with B.Canvas.Font do
    begin
      Name := FontName;
      Height := FontHeight;
      Style := FontStyle;
    end;
  if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
  then
    B.Canvas.Font.Charset := SkinData.ResourceStrData.CharSet
  else
    B.Canvas.Font.CharSet := FDefaultFont.Charset;
  with B.Canvas.Font do
  begin
    if Enabled and not FUseSkinFontColor
    then
      begin
        Color := FDefaultFont.Color;
      end
    else
    if not Enabled
    then
      Color := DisabledFontColor
    else
    if ADown and AMouseIn
    then
      Color := DownFontColor
    else
      if AMouseIn
      then Color := ActiveFontColor
      else Color := FontColor;
  end;

  if (FSkinImagesMenu <> nil) and (FSkinImagesMenu.SelectedItem <> nil) and
      FUseImagesMenuImage
  then
    begin
      if FUseImagesMenuCaption
      then
        _Caption:= FSkinImagesMenu.SelectedItem.Caption;
        
      DrawImageAndText(B.Canvas, NewClRect, FMargin, FSpacing, FLayout,
        _Caption, FSkinImagesMenu.SelectedItem.ImageIndex, FSkinImagesMenu.Images,
        ADown and AMouseIn, Enabled, FDrawColorMarker, FColorMarkerValue);
    end
  else
  if FGlyph.Empty and (Parent is TbsSkinToolBar)
  then
    begin
      if not Enabled and (TbsSkinToolBar(Parent).DisabledImages <> nil)
      then
        IL := TbsSkinToolBar(Parent).DisabledImages
      else
      if (AMouseIn or ADown) and (TbsSkinToolBar(Parent).HotImages <> nil)
      then
        IL := TbsSkinToolBar(Parent).HotImages
      else
        IL := TbsSkinToolBar(Parent).Images;
      E := Enabled;
      if not Enabled and (TbsSkinToolBar(Parent).DisabledImages <> nil)
      then
        E := True;
      DrawImageAndText(B.Canvas, NewClRect, FMargin, FSpacing, FLayout,
        _Caption, FImageIndex, IL, ADown and AMouseIn, E, FDrawColorMarker, FColorMarkerValue);
    end
  else
  if FGlyph.Empty and (FButtonImages <> nil) and (FImageIndex >= 0) and
     (FImageIndex < FButtonImages.Count)
  then
    begin
      DrawImageAndText(B.Canvas, NewClRect, FMargin, FSpacing, FLayout,
        _Caption, FImageIndex, FButtonImages, ADown and AMouseIn, Enabled, FDrawColorMarker, FColorMarkerValue);
    end
  else
    DrawGlyphAndText(B.Canvas,
      NewClRect, FMargin, FSpacing, FLayout,
      _Caption, FGlyph, FNumGlyphs, GetGlyphNum(ADown, AMouseIn), ADown and AMouseIn, FDrawColorMarker, FColorMarkerValue);
end;

procedure TbsSkinSpeedButton.CreateControlDefaultImage;
var
  R: TRect;
  IsDown: Boolean;
  IL: TCustomImageList;
  E: Boolean;
  _Caption: String;
begin
  if FShowCaption then _Caption := Caption else _Caption := '';  
  IsDown := False;
  R := ClientRect;
  if FDown and ((FMouseIn and (GroupIndex = 0)) or (GroupIndex  <> 0))
  then
    begin
      Frame3D(B.Canvas, R, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
      B.Canvas.Brush.Color := BS_XP_BTNDOWNCOLOR;
      B.Canvas.FillRect(R);
      IsDown := True;
    end
  else
    if FMouseIn
    then
      begin
        Frame3D(B.Canvas, R, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
        B.Canvas.Brush.Color := BS_XP_BTNACTIVECOLOR;
        B.Canvas.FillRect(R);
      end
    else
      begin
        if not (csDesigning in ComponentState) and FFlat
        then
          begin
            if not Transparent
            then
              begin
                B.Canvas.Brush.Color := clBtnFace;
                B.Canvas.FillRect(R);
              end;
          end
        else
          begin
            Frame3D(B.Canvas, R, clBtnShadow, clBtnShadow, 1);
            B.Canvas.Brush.Color := clBtnFace;
            B.Canvas.FillRect(R);
          end;
      end;

  B.Canvas.Font.Assign(FDefaultFont);
  if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
  then
    B.Canvas.Font.Charset := SkinData.ResourceStrData.CharSet
  else
    B.Canvas.Font.CharSet := FDefaultFont.Charset;

  if not Enabled then B.Canvas.Font.Color := clBtnShadow;

  if (FSkinImagesMenu <> nil) and (FSkinImagesMenu.SelectedItem <> nil) and
      FUseImagesMenuImage
  then
    begin
      if FUseImagesMenuCaption
      then
        _Caption:= FSkinImagesMenu.SelectedItem.Caption;

      DrawImageAndText(B.Canvas, ClientRect, FMargin, FSpacing, FLayout,
        _Caption, FSkinImagesMenu.SelectedItem.ImageIndex, FSkinImagesMenu.Images,
        FDown and FMouseIn, Enabled, FDrawColorMarker, FColorMarkerValue);
    end
  else
  if FGlyph.Empty and (Parent is TbsSkinToolBar)
  then
    begin
      if not Enabled and (TbsSkinToolBar(Parent).DisabledImages <> nil)
      then
        IL := TbsSkinToolBar(Parent).DisabledImages
      else
      if (FMouseIn or FDown) and (TbsSkinToolBar(Parent).HotImages <> nil)
      then
        IL := TbsSkinToolBar(Parent).HotImages
      else
        IL := TbsSkinToolBar(Parent).Images;
      E := Enabled;
      if not Enabled and (TbsSkinToolBar(Parent).DisabledImages <> nil)
      then
        E := True;
      DrawImageAndText(B.Canvas, ClientRect, FMargin, FSpacing, FLayout,
        _Caption, FImageIndex, IL, FDown and FMouseIn, E, FDrawColorMarker, FColorMarkerValue);
    end
  else
  if FGlyph.Empty and (FButtonImages <> nil) and (FImageIndex >= 0) and
     (FImageIndex < FButtonImages.Count)
  then
    begin
      DrawImageAndText(B.Canvas, ClientRect, FMargin, FSpacing, FLayout,
        _Caption, FImageIndex, FButtonImages, FDown and FMouseIn, Enabled, FDrawColorMarker, FColorMarkerValue);
    end
  else
  DrawGlyphAndText(B.Canvas,
    ClientRect, FMargin, FSpacing, FLayout,
    _Caption, FGlyph, FNumGlyphs, GetGlyphNum(FDown, FMouseIn), IsDown, FDrawColorMarker, FColorMarkerValue);
end;

procedure TbsSkinSpeedButton.CreateControlSkinImage;
begin
end;

procedure TbsSkinSpeedButton.Paint;
var
  Buffer, ABuffer: TBitMap;
  PBuffer, APBuffer: TbsEffectBmp;
  IL: TCustomImageList;
  E: Boolean;
  _Caption: String;
begin
  GetSkinData;
  if FShowCaption then _Caption := Caption else _Caption := '';
  if FIndex = -1
  then
    begin
      if FDown and (((FMouseIn and (GroupIndex = 0)) or (GroupIndex  <> 0)))
      then
        inherited
      else
      if FMouseIn
      then
        inherited
      else
        if Transparent
        then
          begin
            Canvas.Font.Assign(FDefaultFont);
            if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
            then
              Canvas.Font.Charset := SkinData.ResourceStrData.CharSet
            else
              Canvas.Font.CharSet := FDefaultFont.Charset;
            if not Enabled then Canvas.Font.Color := clBtnShadow;

            if (FSkinImagesMenu <> nil) and (FSkinImagesMenu.SelectedItem <> nil) and
               FUseImagesMenuImage
            then
              begin
                if FUseImagesMenuCaption
                then
                  _Caption:= FSkinImagesMenu.SelectedItem.Caption;
                DrawImageAndText(Canvas, ClientRect, FMargin, FSpacing, FLayout,
                _Caption, FSkinImagesMenu.SelectedItem.ImageIndex, FSkinImagesMenu.Images,
                False, Enabled, FDrawColorMarker, FColorMarkerValue);
              end
            else
            if FGlyph.Empty and (Parent is TbsSkinToolBar)
            then
              begin
                if not Enabled and (TbsSkinToolBar(Parent).DisabledImages <> nil)
                then
                  IL := TbsSkinToolBar(Parent).DisabledImages
                else
                  IL := TbsSkinToolBar(Parent).Images;
                 E := Enabled;
                 if not Enabled and (TbsSkinToolBar(Parent).DisabledImages <> nil)
                 then
                   E := True;
                  DrawImageAndText(Canvas, ClientRect, FMargin, FSpacing, FLayout,
                    _Caption, FImageIndex, IL, False, E, FDrawColorMarker, FColorMarkerValue);
              end
            else
            if FGlyph.Empty and (FButtonImages <> nil) and (FImageIndex >= 0) and
               (FImageIndex < FButtonImages.Count)
            then
              begin
                DrawImageAndText(Canvas, ClientRect, FMargin, FSpacing, FLayout,
                  _Caption, FImageIndex, FButtonImages, False, Enabled, FDrawColorMarker, FColorMarkerValue);
              end
            else
              DrawGlyphAndText(Canvas,
                ClientRect, FMargin, FSpacing, FLayout,
               _Caption, FGlyph, FNumGlyphs, GetGlyphNum(FDown, FMouseIn), False, FDrawColorMarker, FColorMarkerValue);
          end
        else
          inherited;
    end
  else
    begin
      if EnableMorphing and (FMorphKf <> 1) and (FMorphKf <> 0) and not Transparent
      then
        begin
          Buffer := TBitMap.Create;
          ABuffer := TBitMap.Create;
          Buffer.Width := Width;
          Buffer.Height := Height;
          ABuffer.Width := Width;
          ABuffer.Height := Height;
          CreateButtonImage(Buffer, SkinRect, False, False);
          CreateButtonImage(ABuffer, ActiveSkinRect, False, True);
          PBuffer := TbsEffectBmp.CreateFromhWnd(Buffer.Handle);
          APBuffer := TbsEffectBmp.CreateFromhWnd(ABuffer.Handle);
          case MorphKind of
            mkDefault: PBuffer.Morph(APBuffer, FMorphKf);
            mkGradient: PBuffer.MorphGrad(APBuffer, FMorphKf);
            mkLeftGradient: PBuffer.MorphLeftGrad(APBuffer, FMorphKf);
            mkRightGradient: PBuffer.MorphRightGrad(APBuffer, FMorphKf);
            mkLeftSlide: PBuffer.MorphLeftSlide(APBuffer, FMorphKf);
            mkRightSlide: PBuffer.MorphRightSlide(APBuffer, FMorphKf);
            mkPush: PBuffer.MorphPush(APBuffer, FMorphKf);
          end;
          PBuffer.Draw(Canvas.Handle, 0, 0);
          PBuffer.Free;
          APBuffer.Free;
          Buffer.Free;
          ABuffer.Free;
        end
      else
      if FDown and (((FMouseIn and (GroupIndex = 0)) or (GroupIndex  <> 0)))
      then
        begin
          Buffer := TBitMap.Create;
          Buffer.Width := Width;
          Buffer.Height := Height;
          CreateButtonImage(Buffer, DownSkinRect, True, True);
          Canvas.Draw(0, 0, Buffer);
          Buffer.Free;
        end
      else
        if FMouseIn or (not FMouseIn and EnableMorphing and (FMorphKf = 1))
        then
          begin
            Buffer := TBitMap.Create;
            Buffer.Width := Width;
            Buffer.Height := Height;
            CreateButtonImage(Buffer, ActiveSkinRect, False, True);
            Canvas.Draw(0, 0, Buffer);
            Buffer.Free;
          end
        else
          begin
            if Transparent
            then
              begin
                with Canvas.Font do
                begin
                  if FUseSkinFont
                  then
                    begin
                      Name := FontName;
                      Style := FontStyle;
                    end
                  else
                    Canvas.Font.Assign(FDefaultFont);

                  if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
                  then
                    Charset := SkinData.ResourceStrData.CharSet
                  else
                    CharSet := FDefaultFont.Charset;

                  if Self.Enabled
                  then
                    begin
                      if FUseSkinFontColor
                      then
                        Color := SkinData.SkinColors.cBtnText
                      else
                        Color := FDefaultFont.Color;  
                    end
                  else
                    Color := SkinData.SkinColors.cBtnShadow;
                  if FUseSkinFont
                  then
                     Height := FontHeight;
                end;

              if (FSkinImagesMenu <> nil) and (FSkinImagesMenu.SelectedItem <> nil) and
                  FUseImagesMenuImage
              then
                begin
                  if FUseImagesMenuCaption
                  then
                    _Caption:= FSkinImagesMenu.SelectedItem.Caption;
                  DrawImageAndText(Canvas, NewClRect, FMargin, FSpacing, FLayout,
                  _Caption, FSkinImagesMenu.SelectedItem.ImageIndex, FSkinImagesMenu.Images,
                  False, Enabled, FDrawColorMarker, FColorMarkerValue);
                end
              else
                if FGlyph.Empty and (Parent is TbsSkinToolBar)
                then
                  begin
                    if not Enabled and (TbsSkinToolBar(Parent).DisabledImages <> nil)
                    then
                      IL := TbsSkinToolBar(Parent).DisabledImages
                    else
                      IL := TbsSkinToolBar(Parent).Images;
                    E := Enabled;
                    if not Enabled and (TbsSkinToolBar(Parent).DisabledImages <> nil)
                    then
                      E := True;
                     DrawImageAndText(Canvas, NewClRect, FMargin, FSpacing, FLayout,
                       _Caption, FImageIndex, IL, False, E, FDrawColorMarker, FColorMarkerValue);
                  end
                else
               if FGlyph.Empty and (FButtonImages <> nil) and (FImageIndex >= 0) and
                  (FImageIndex < FButtonImages.Count)
                then
                  begin
                    DrawImageAndText(Canvas, NewClRect, FMargin, FSpacing, FLayout,
                       _Caption, FImageIndex, FButtonImages, False, Enabled, FDrawColorMarker, FColorMarkerValue);
                  end
                else
                  DrawGlyphAndText(Canvas,
                    NewClRect, FMargin, FSpacing, FLayout,
                    _Caption, FGlyph, FNumGlyphs, GetGlyphNum(FDown, FMouseIn), False, FDrawColorMarker, FColorMarkerValue);
              end
            else
              begin
                Buffer := TBitMap.Create;
                Buffer.Width := Width;
                Buffer.Height := Height;
                if not Enabled and not IsNullRect(DisabledSkinRect)
                then
                  CreateButtonImage(Buffer, DisabledSkinRect, False, False)
                else
                  CreateButtonImage(Buffer, SkinRect, False, False);
                Canvas.Draw(0, 0, Buffer);
                Buffer.Free;
              end;
          end;
    end;
end;

procedure TbsSkinSpeedButton.CMTextChanged;
begin
  inherited;
  RePaint;
end;

procedure TbsSkinSpeedButton.CMMouseEnter(var Message: TMessage);
var
  CanPaint: Boolean;
begin
  inherited;
  if not Enabled then Exit;
  if (csDesigning in ComponentState) then Exit;
  FMouseIn := True;
  CanPaint := ((GroupIndex <> 0) and not FDown) or (GroupIndex = 0);
  if CanPaint and not Enabled then CanPaint := False;
  if CanPaint
  then
    begin
      if FDown
      then
        begin
          if EnableMorphing then FMorphKf := 1;
          RePaint;
        end
      else
        begin
          if (FIndex <> -1) and EnableAnimation and not IsNullRect(AnimateSkinRect) then StartAnimate(True);
          ReDrawControl;
        end;  
    end;
  if FDown and RepeatMode and (GroupIndex = 0) then StartRepeat;
end;


procedure TbsSkinSpeedButton.CMMouseLeave(var Message: TMessage);
var
  CanPaint: Boolean;
begin
  inherited;
  if not Enabled then Exit;
  if (csDesigning in ComponentState) then Exit;
  FMouseIn := False;
  CanPaint := ((GroupIndex <> 0) and not FDown) or (GroupIndex = 0);
  if CanPaint and not Enabled then CanPaint := False;
  if ((GroupIndex <> 0) and not FDown) or (GroupIndex = 0)
  then
    begin
      if (FIndex <> -1) and EnableAnimation and not IsNullRect(AnimateSkinRect) then StartAnimate(False);
      ReDrawControl;
    end;
  if FDown and RepeatMode and (RepeatTimer <> nil) and (GroupIndex = 0) then StopRepeat;
end;

procedure TbsSkinSpeedButton.MouseDown;
begin
  inherited;
  if Button = mbLeft
  then
    begin
      if (FIndex <> -1) and EnableAnimation and not IsNullRect(AnimateSkinRect) then StopAnimate;
      FMouseDown := True;
      if not FDown
      then
        begin
          FMouseIn := True;
          Down := True;
          if FRepeatMode and (GroupIndex = 0)
          then
            StartRepeat
          else
            if (GroupIndex <> 0) then ButtonClick;
          FAllowAllUpCheck := False;
        end
      else
        if (GroupIndex <> 0) then FAllowAllUpCheck := True;
    end;
end;

procedure TbsSkinSpeedButton.MouseUp;
var
  CheckDown: Boolean;
begin
  inherited;
  if Button = mbLeft
  then
    begin
      FMouseDown := False;
      CheckDown := FDown;
      if GroupIndex = 0
      then
        begin
          if FMouseIn
          then
            begin
              Down := False;
              if RepeatMode then StopRepeat;
              if CheckDown then ButtonClick;
            end
             else
               begin
                 FDown := False;
                 if RepeatMode and (RepeatTimer <> nil) then StopRepeat;
               end;
        end
      else
        if (GroupIndex <> 0) and FDown and FAllowAllUp and
           FAllowAllUpCheck and FMouseIn
        then
          begin
            Down := False;
            ButtonClick;
          end;
   end;
end;

constructor TbsSkinMenuSpeedButton.Create;
begin
  inherited;
  FNewStyle := False;
  FSkinDataName := 'toolmenubutton';
  FTrackButtonMode := False;
  FMenuTracked := False;
  FSkinPopupMenu := nil;
  FTrackPosition := bstpRight;
end;

destructor TbsSkinMenuSpeedButton.Destroy;
begin
  inherited;
end;

procedure TbsSkinMenuSpeedButton.SetTrackPosition(Value: TbsTrackPosition);
begin
  FTrackPosition := Value;
  RePaint;
end;

procedure TbsSkinMenuSpeedButton.SetNewStyle;
begin
  FNewStyle := Value;
  if FNewStyle then SkinDataName := 'resizetoolbutton';
end;

procedure TbsSkinMenuSpeedButton.OnImagesMenuClose;
begin
  FMenuTracked := False;
  Down := False;
  if Assigned(FOnHideTrackMenu) then FOnHideTrackMenu(Self);
  FMouseIn := False;
  RePaint;
end;

procedure TbsSkinMenuSpeedButton.DrawResizeButton(ButtonData: TbsDataSkinButtonControl;
  C: TCanvas; ButtonR: TRect; AMouseIn, ADown: Boolean);
var
  Buffer: TBitMap;
  CIndex: Integer;
  BtnSkinPicture: TBitMap;
  BtnLtPoint, BtnRTPoint, BtnLBPoint, BtnRBPoint: TPoint;
  BtnCLRect: TRect;
  BSR, ABSR, DBSR, R1: TRect;
  XO, YO: Integer;
begin
  Buffer := TBitMap.Create;
  Buffer.Width := RectWidth(ButtonR);
  Buffer.Height := RectHeight(ButtonR);
  //
  with ButtonData do
  begin
    XO := RectWidth(ButtonR) - RectWidth(SkinRect);
    YO := RectHeight(ButtonR) - RectHeight(SkinRect);
    BtnLTPoint := LTPoint;
    BtnRTPoint := Point(RTPoint.X + XO, RTPoint.Y);
    BtnLBPoint := Point(LBPoint.X, LBPoint.Y + YO);
    BtnRBPoint := Point(RBPoint.X + XO, RBPoint.Y + YO);
    BtnClRect := Rect(CLRect.Left, ClRect.Top,
      CLRect.Right + XO, ClRect.Bottom + YO);
    BtnSkinPicture := TBitMap(SkinData.FActivePictures.Items[ButtonData.PictureIndex]);

    BSR := SkinRect;
    ABSR := ActiveSkinRect;
    DBSR := DownSkinRect;
    if IsNullRect(ABSR) then ABSR := BSR;
    if IsNullRect(DBSR) then DBSR := ABSR;
    //
    if ADown and AMouseIn
    then
      begin
        CreateSkinImage(LTPoint, RTPoint, LBPoint, RBPoint, CLRect,
        BtnLtPoint, BtnRTPoint, BtnLBPoint, BtnRBPoint, BtnCLRect,
        Buffer, BtnSkinPicture, DBSR, Buffer.Width, Buffer.Height, True,
        LeftStretch, TopStretch, RightStretch, BottomStretch,
        StretchEffect);
      end
    else
    if AMouseIn
    then
      begin
        CreateSkinImage(LTPoint, RTPoint, LBPoint, RBPoint, CLRect,
        BtnLtPoint, BtnRTPoint, BtnLBPoint, BtnRBPoint, BtnCLRect,
        Buffer, BtnSkinPicture, ABSR, Buffer.Width, Buffer.Height, True,
        LeftStretch, TopStretch, RightStretch, BottomStretch,
        StretchEffect);
      end
    else
      begin
        CreateSkinImage(LTPoint, RTPoint, LBPoint, RBPoint, CLRect,
        BtnLtPoint, BtnRTPoint, BtnLBPoint, BtnRBPoint, BtnCLRect,
        Buffer, BtnSkinPicture, BSR, Buffer.Width, Buffer.Height, True,
        LeftStretch, TopStretch, RightStretch, BottomStretch,
        StretchEffect);
      end;
   end;
  C.Draw(ButtonR.Left, ButtonR.Top, Buffer);
  Buffer.Free;
end;

procedure TbsSkinMenuSpeedButton.CreateControlSkinResizeImage2;
var
  R, R1: TRect;
  isDown: Boolean;
  IL: TCustomImageList;
  E: Boolean;
  _Caption: String;
  B1, B2: TBitMap;
  SRect, ARect, DRect: TRect;
begin
  if FShowCaption then _Caption := Caption  else _Caption := '';
  isDown := False;
  R := Rect(0, 0, Width, Height);
  SRect := SkinRect;
  if IsNullRect(ActiveSkinRect) then ARect := SRect else ARect := ActiveSkinRect;
  if IsNullRect(DownSkinRect) then DRect := ARect else DRect := DownSkinRect;

  if FTrackButtonMode
  then
    begin
      B1 := TBitMap.Create;
      B1.Width := Width - 15;
      B1.Height := Height;
      B2 := TBitMap.Create;
      B2.Width := 15;
      B2.Height := Height;
      if FMenuTracked
      then
        begin
          CreateStretchImage(B1, Picture, ARect, ClRect, True);
          CreateStretchImage(B2, Picture, DRect, ClRect, True);
          B.Canvas.Draw(0, 0, B1);
          B.Canvas.Draw(Width - 15, 0, B2);
        end
      else
        begin
          if ADown and AMouseIn
          then
            begin
              CreateStretchImage(B1, Picture, DRect, ClRect, True);
              CreateStretchImage(B2, Picture, DRect, ClRect, True);
              B.Canvas.Draw(0, 0, B1);
              B.Canvas.Draw(Width - 15, 0, B2);
              isDown := True;
            end
          else
          if AMouseIn
          then
            begin
              CreateStretchImage(B1, Picture, ARect, ClRect, True);
              CreateStretchImage(B2, Picture, ARect, ClRect, True);
              B.Canvas.Draw(0, 0, B1);
              B.Canvas.Draw(Width - 15, 0, B2);
            end
          else
            if not FFlat
            then
              begin
                CreateStretchImage(B1, Picture, SRect, ClRect, True);
                CreateStretchImage(B2, Picture, SRect, ClRect, True);
                B.Canvas.Draw(0, 0, B1);
                B.Canvas.Draw(Width - 15, 0, B2);
              end;
        end;
      B1.Free;
      B2.Free;
    end
  else
    begin
      if ADown and AMouseIn
      then
        begin
          CreateStretchImage(B, Picture, DRect, ClRect, True);
          IsDown := True;
        end
      else
        if AMouseIn
        then
          begin
            CreateStretchImage(B, Picture, ARect, ClRect, True);
          end
       else
         begin
           if not FFlat
           then
             begin
               CreateStretchImage(B, Picture, SRect, ClRect, True);
             end;
         end;
    end;

  R := ClientRect;
  Dec(R.Right, 15);

  if not FUseSkinFont
  then
    B.Canvas.Font.Assign(FDefaultFont)
  else
    with B.Canvas.Font do
    begin
      Name := FontName;
      Height := FontHeight;
      Style := FontStyle;
    end;

  with B.Canvas.Font do
  begin

    if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
    then
      Charset := SkinData.ResourceStrData.CharSet
    else
      CharSet := FDefaultFont.Charset;
    if Enabled and not FUseSkinFontColor
    then
      begin
        Color := FDefaultFont.Color;
      end
    else
    if not Enabled
    then
      Color := DisabledFontColor
    else
    if IsDown
    then
      Color := DownFontColor
    else
      if AMouseIn
      then Color := ActiveFontColor
      else Color := FontColor;
  end;

  if (FSkinImagesMenu <> nil) and (FSkinImagesMenu.SelectedItem <> nil) and
      FUseImagesMenuImage
  then
    begin
      if FUseImagesMenuCaption
      then
        _Caption := FSkinImagesMenu.SelectedItem.Caption;

      DrawImageAndText(B.Canvas, R, FMargin, FSpacing, FLayout,
        _Caption, FSkinImagesMenu.SelectedItem.ImageIndex, FSkinImagesMenu.Images,
        IsDown, Enabled, FDrawColorMarker, FColorMarkerValue);
    end
  else
  if FGlyph.Empty and (Parent is TbsSkinToolBar)
  then
    begin
      if not Enabled and (TbsSkinToolBar(Parent).DisabledImages <> nil)
      then
        IL := TbsSkinToolBar(Parent).DisabledImages
      else
      if (AMouseIn or ADown) and (TbsSkinToolBar(Parent).HotImages <> nil)
      then
        IL := TbsSkinToolBar(Parent).HotImages
      else
        IL := TbsSkinToolBar(Parent).Images;
      E := Enabled;
      if not Enabled and (TbsSkinToolBar(Parent).DisabledImages <> nil)
      then
        E := False;
      DrawImageAndText(B.Canvas, R, FMargin, FSpacing, FLayout,
        _Caption, FImageIndex, IL, isDown, E, FDrawColorMarker, FColorMarkerValue);
    end
  else
  if FGlyph.Empty and (FButtonImages <> nil) and (FImageIndex >= 0) and
     (FImageIndex < FButtonImages.Count)
  then
    begin
      DrawImageAndText(B.Canvas, R, FMargin, FSpacing, FLayout,
        _Caption, FImageIndex, FButtonImages, isDown, Enabled, FDrawColorMarker, FColorMarkerValue);
    end
  else
  DrawGlyphAndText(B.Canvas, R, FMargin, FSpacing, FLayout,
                  _Caption, FGlyph, FNumGlyphs, GetGlyphNum(ADown, AMouseIn), isDown, FDrawColorMarker, FColorMarkerValue);
  R.Left := Width - 15;
  Inc(R.Right, 15);
  if (ADown and AMouseIn) or FMenuTracked
  then
    begin
      Inc(R.Top, 2);
      Inc(R.Left, 2);
    end;
  
  if not IsNullRect(MenuMarkerRect)
  then
    begin
      DrawMenuMarker(B.Canvas, R, AMouseIn, (ADown and AMouseIn) or FMenuTracked, False);
    end
  else
  if FMenuTracked
  then
    DrawTrackArrowImage(B.Canvas, R, DownFontColor)
  else
    DrawTrackArrowImage(B.Canvas, R, B.Canvas.Font.Color);
end;

procedure TbsSkinMenuSpeedButton.CreateNewStyleControlSkinResizeImage;
var
  isDown: Boolean;
  IL: TCustomImageList;
  E: Boolean;
  _Caption: String;
  R, R1, R2: TRect;
  ButtonData1, ButtonData2: TbsDataSkinButtonControl;
  CIndex: Integer;
begin
  if FShowCaption then _Caption := Caption  else _Caption := '';

  R1 := Rect(0, 0, Width, Height);

  if TrackButtonMode and AMouseIn
  then
    begin
      if (TrackPosition = bstpRight)
      then
       begin
         R1 := Rect(0, 0, Width - 15, Height);
         R2 := Rect(Width - 15, 0, Width, Height);
       end
      else
       begin
         R1 := Rect(0, 0, Width, Height - 15);
         R2 := Rect(0, Height - 15, Width, Height);
       end;
     end
  else
    if (TrackPosition = bstpRight)
    then
      R2 := Rect(Width - 15, 0, Width, Height)
    else
      R2 := Rect(0, Height - 15, Width, Height);

  CIndex := FSD.GetControlIndex('resizetoolbutton');
  if CIndex = -1 then CIndex := FSD.GetControlIndex('resizebutton');
  if CIndex = -1 then Exit;
  ButtonData1 := TbsDataSkinButtonControl(SkinData.CtrlList[CIndex]);

  if FTrackButtonMode and AMouseIn
  then
    begin
      if TrackPosition = bstpRight
      then
        CIndex := FSD.GetControlIndex('vtracktoolbutton')
      else
        CIndex := FSD.GetControlIndex('htracktoolbutton');
      if CIndex = -1
      then
        ButtonData2 := ButtonData1
      else
        begin
          ButtonData2 := TbsDataSkinButtonControl(SkinData.CtrlList[CIndex]);
          R1 := Rect(0, 0, Width, Height);
        end;
    end;

  IsDown := AMouseIn and ADown;

  if FTrackButtonMode and FMenuTracked then isDown := False;

  DrawResizeButton(ButtonData1, B.Canvas, R1, AMouseIn, IsDown);

  if TrackPosition = bstpRight
  then
    R1 := Rect(0, 0, Width - 15, Height)
  else
    R1 := Rect(0, 0, Width, Height - 15);

  if FTrackButtonMode and AMouseIn
  then
    begin
      DrawResizeButton(ButtonData2, B.Canvas, R2, AMouseIn, FMenuTracked);
    end;

  if not FUseSkinFont
  then
    B.Canvas.Font.Assign(FDefaultFont)
  else
    with B.Canvas.Font do
    begin
      Name := FontName;
      Height := FontHeight;
      Style := FontStyle;
    end;

  with B.Canvas.Font do
  begin

    if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
    then
      Charset := SkinData.ResourceStrData.CharSet
    else
      CharSet := FDefaultFont.Charset;
    if Enabled and not FUseSkinFontColor
    then
      begin
        Color := FDefaultFont.Color;
      end
    else
    if not Enabled
    then
      Color := DisabledFontColor
    else
    if IsDown
    then
      Color := DownFontColor
    else
      if AMouseIn
      then Color := ActiveFontColor
      else Color := FontColor;
  end;

  if (FSkinImagesMenu <> nil) and (FSkinImagesMenu.SelectedItem <> nil) and
      FUseImagesMenuImage
  then
    begin
      if FUseImagesMenuCaption
      then
        _Caption := FSkinImagesMenu.SelectedItem.Caption;

      DrawImageAndText(B.Canvas, R1, FMargin, FSpacing, FLayout,
        _Caption, FSkinImagesMenu.SelectedItem.ImageIndex, FSkinImagesMenu.Images,
        IsDown, Enabled, FDrawColorMarker, FColorMarkerValue);
    end
  else
  if FGlyph.Empty and (Parent is TbsSkinToolBar)
  then
    begin
      if not Enabled and (TbsSkinToolBar(Parent).DisabledImages <> nil)
      then
        IL := TbsSkinToolBar(Parent).DisabledImages
      else
      if (AMouseIn or ADown) and (TbsSkinToolBar(Parent).HotImages <> nil)
      then
        IL := TbsSkinToolBar(Parent).HotImages
      else
        IL := TbsSkinToolBar(Parent).Images;
      E := Enabled;
      if not Enabled and (TbsSkinToolBar(Parent).DisabledImages <> nil)
      then
        E := False;
      DrawImageAndText(B.Canvas, R1, FMargin, FSpacing, FLayout,
        _Caption, FImageIndex, IL, IsDown, E, FDrawColorMarker, FColorMarkerValue);
    end
  else
  if FGlyph.Empty and (FButtonImages <> nil) and (FImageIndex >= 0) and
     (FImageIndex < FButtonImages.Count)
  then
    begin
      DrawImageAndText(B.Canvas, R1, FMargin, FSpacing, FLayout,
        _Caption, FImageIndex, FButtonImages, isDown, Enabled, FDrawColorMarker, FColorMarkerValue);
    end
  else
  DrawGlyphAndText(B.Canvas, R1, FMargin, FSpacing, FLayout,
                  _Caption, FGlyph, FNumGlyphs, GetGlyphNum(ADown, AMouseIn), IsDown,
                  FDrawColorMarker, FColorMarkerValue);

  R := R2;

  IsDown := AMouseIn and ADown;

  if FTrackButtonMode and not FMenuTracked then isDown := False;

  if IsDown
  then
    begin
      Inc(R.Top, 1);
      Inc(R.Left, 1);
    end;

  if not IsNullRect(MenuMarkerRect)
  then
    begin
      DrawMenuMarker(B.Canvas, R, AMouseIn, (ADown and AMouseIn) or FMenuTracked, False);
    end
  else
  if FMenuTracked
  then
    DrawTrackArrowImage(B.Canvas, R, DownFontColor)
  else
    DrawTrackArrowImage(B.Canvas, R, B.Canvas.Font.Color);
end;


procedure TbsSkinMenuSpeedButton.CreateControlSkinResizeImage;
var
  R, R1: TRect;
  isDown: Boolean;

  IL: TCustomImageList;
  E: Boolean;
  _Caption: String;
  B1, B2: TBitMap;
  SRect, ARect, DRect: TRect;
  NewLtPoint1, NewRTPoint1, NewLBPoint1, NewRBPoint1: TPoint;
  NewClRect1: TRect;
  NewLtPoint2, NewRTPoint2, NewLBPoint2, NewRBPoint2: TPoint;
  NewClRect2: TRect;
  XO, YO: Integer;
begin
  if FShowCaption then _Caption := Caption  else _Caption := '';
  isDown := False;
  R := Rect(0, 0, Width, Height);
  SRect := SkinRect;
  if IsNullRect(ActiveSkinRect) then ARect := SRect else ARect := ActiveSkinRect;
  if IsNullRect(DownSkinRect) then DRect := ARect else DRect := DownSkinRect;

  if FTrackButtonMode
  then
    begin
      XO := (Width - 15) - RectWidth(SRect);
      YO := Height - RectHeight(SRect);

      NewLTPoint1 := LTPt;
      NewRTPoint1 := Point(RTPt.X + XO, RTPt.Y);
      NewLBPoint1 := Point(LBPt.X, LBPt.Y + YO);
      NewRBPoint1 := Point(RBPt.X + XO, RBPt.Y + YO);
      NewClRect1 := Rect(CLRect.Left, ClRect.Top,
       CLRect.Right + XO, ClRect.Bottom + YO);

      XO := 15 - RectWidth(SRect);
      YO := Height - RectHeight(SRect);

      NewLTPoint2 := LTPt;
      NewRTPoint2 := Point(RTPt.X + XO, RTPt.Y);
      NewLBPoint2 := Point(LBPt.X, LBPt.Y + YO);
      NewRBPoint2 := Point(RBPt.X + XO, RBPt.Y + YO);
      NewClRect2 := Rect(CLRect.Left, ClRect.Top,
      CLRect.Right + XO, ClRect.Bottom + YO);
    end;  

  if FTrackButtonMode
  then
    begin
      R := Rect(0, 0, Width - 15, Height);
      R1 := Rect(Width - 15, 0, Width, Height);
      B1 := TBitMap.Create;
      B2 := TBitMap.Create;
      if FMenuTracked
      then
        begin
          CreateSkinImage(LTPt, RTPt, LBPt, RBPt, CLRect,
          NewLtPoint1, NewRTPoint1, NewLBPoint1, NewRBPoint1, NewCLRect1,
            B1, Picture, ARect, Self.Width - 15, Height, True,
            LeftStretch, TopStretch, RightStretch, BottomStretch,
            StretchEffect);
            B.Canvas.Draw(0, 0, B1);
          CreateSkinImage(LTPt, RTPt, LBPt, RBPt, CLRect,
          NewLtPoint2, NewRTPoint2, NewLBPoint2, NewRBPoint2, NewCLRect2,
            B2, Picture, DRect, 15, Height, True,
            LeftStretch, TopStretch, RightStretch, BottomStretch,
            StretchEffect);
          B.Canvas.Draw(Self.Width - 15, 0, B2);
        end
      else
        begin
          if ADown and AMouseIn
          then
            begin
              CreateSkinImage(LTPt, RTPt, LBPt, RBPt, CLRect,
                NewLtPoint1, NewRTPoint1, NewLBPoint1, NewRBPoint1, NewCLRect1,
                B1, Picture, DRect, Self.Width - 15, Height, True,
                LeftStretch, TopStretch, RightStretch, BottomStretch,
                StretchEffect);
                B.Canvas.Draw(0, 0, B1);
              CreateSkinImage(LTPt, RTPt, LBPt, RBPt, CLRect,
                NewLtPoint2, NewRTPoint2, NewLBPoint2, NewRBPoint2, NewCLRect2,
                B2, Picture, DRect, 15, Height, True,
                LeftStretch, TopStretch, RightStretch, BottomStretch,
                StretchEffect);
                B.Canvas.Draw(Self.Width - 15, 0, B2);
              isDown := True;
            end
          else
          if AMouseIn
          then
            begin
              CreateSkinImage(LTPt, RTPt, LBPt, RBPt, CLRect,
                NewLtPoint1, NewRTPoint1, NewLBPoint1, NewRBPoint1, NewCLRect1,
                B1, Picture, ARect, Self.Width - 15, Height, True,
                LeftStretch, TopStretch, RightStretch, BottomStretch,
                StretchEffect);
                B.Canvas.Draw(0, 0, B1);
              CreateSkinImage(LTPt, RTPt, LBPt, RBPt, CLRect,
                NewLtPoint2, NewRTPoint2, NewLBPoint2, NewRBPoint2, NewCLRect2,
                B2, Picture, ARect, 15, Height, True,
                LeftStretch, TopStretch, RightStretch, BottomStretch,
                StretchEffect);
                B.Canvas.Draw(Self.Width - 15, 0, B2);
            end
          else
            if not FFlat
            then
              begin
                CreateSkinImage(LTPt, RTPt, LBPt, RBPt, CLRect,
                  NewLtPoint1, NewRTPoint1, NewLBPoint1, NewRBPoint1, NewCLRect1,
                  B1, Picture, SRect, Self.Width - 15, Height, True,
                  LeftStretch, TopStretch, RightStretch, BottomStretch,
                  StretchEffect);
                B.Canvas.Draw(0, 0, B1);
                CreateSkinImage(LTPt, RTPt, LBPt, RBPt, CLRect,
                  NewLtPoint2, NewRTPoint2, NewLBPoint2, NewRBPoint2, NewCLRect2,
                  B2, Picture, SRect, 15, Height, True,
                  LeftStretch, TopStretch, RightStretch, BottomStretch,
                  StretchEffect);
                B.Canvas.Draw(Self.Width - 15, 0, B2);
              end;
        end;
      B1.Free;
      B2.Free;
    end
  else
    begin
      if ADown and AMouseIn
      then
        begin
          CreateSkinImage(LTPt, RTPt, LBPt, RBPt, CLRect,
          NewLtPoint, NewRTPoint, NewLBPoint, NewRBPoint, NewCLRect,
            B, Picture, DRect, Width, Height, True,
            LeftStretch, TopStretch, RightStretch, BottomStretch,
            StretchEffect);
          IsDown := True;
        end
      else
        if AMouseIn
        then
          begin
            CreateSkinImage(LTPt, RTPt, LBPt, RBPt, CLRect,
              NewLtPoint, NewRTPoint, NewLBPoint, NewRBPoint, NewCLRect,
            B, Picture, ARect, Width, Height, True,
            LeftStretch, TopStretch, RightStretch, BottomStretch,
            StretchEffect);
          end
       else
         begin
           if not FFlat
           then
             begin
               CreateSkinImage(LTPt, RTPt, LBPt, RBPt, CLRect,
               NewLtPoint, NewRTPoint, NewLBPoint, NewRBPoint, NewCLRect,
                 B, Picture, SRect, Width, Height, True,
                 LeftStretch, TopStretch, RightStretch, BottomStretch,
                 StretchEffect);
             end;
         end;
    end;
  R := ClientRect;
  Dec(R.Right, 15);

  if not FUseSkinFont
  then
    B.Canvas.Font.Assign(FDefaultFont)
  else
    with B.Canvas.Font do
    begin
      Name := FontName;
      Height := FontHeight;
      Style := FontStyle;
    end;

  with B.Canvas.Font do
  begin

    if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
    then
      Charset := SkinData.ResourceStrData.CharSet
    else
      CharSet := FDefaultFont.Charset;
    if Enabled and not FUseSkinFontColor
    then
      begin
        Color := FDefaultFont.Color;
      end
    else
    if not Enabled
    then
      Color := DisabledFontColor
    else
    if IsDown
    then
      Color := DownFontColor
    else
      if AMouseIn
      then Color := ActiveFontColor
      else Color := FontColor;
  end;

  if (FSkinImagesMenu <> nil) and (FSkinImagesMenu.SelectedItem <> nil) and
      FUseImagesMenuImage
  then
    begin
      if FUseImagesMenuCaption
      then
        _Caption := FSkinImagesMenu.SelectedItem.Caption;

      DrawImageAndText(B.Canvas, R, FMargin, FSpacing, FLayout,
        _Caption, FSkinImagesMenu.SelectedItem.ImageIndex, FSkinImagesMenu.Images,
        IsDown, Enabled, FDrawColorMarker, FColorMarkerValue);
    end
  else
  if FGlyph.Empty and (Parent is TbsSkinToolBar)
  then
    begin
      if not Enabled and (TbsSkinToolBar(Parent).DisabledImages <> nil)
      then
        IL := TbsSkinToolBar(Parent).DisabledImages
      else
      if (AMouseIn or ADown) and (TbsSkinToolBar(Parent).HotImages <> nil)
      then
        IL := TbsSkinToolBar(Parent).HotImages
      else
        IL := TbsSkinToolBar(Parent).Images;
      E := Enabled;
      if not Enabled and (TbsSkinToolBar(Parent).DisabledImages <> nil)
      then
        E := False;
      DrawImageAndText(B.Canvas, R, FMargin, FSpacing, FLayout,
        _Caption, FImageIndex, IL, isDown, E, FDrawColorMarker, FColorMarkerValue);
    end
  else
  if FGlyph.Empty and (FButtonImages <> nil) and (FImageIndex >= 0) and
     (FImageIndex < FButtonImages.Count)
  then
    begin
      DrawImageAndText(B.Canvas, R, FMargin, FSpacing, FLayout,
        _Caption, FImageIndex, FButtonImages, isDown, Enabled, FDrawColorMarker, FColorMarkerValue);
    end
  else
  DrawGlyphAndText(B.Canvas, R, FMargin, FSpacing, FLayout,
                  _Caption, FGlyph, FNumGlyphs, GetGlyphNum(ADown, AMouseIn), isDown,
                  FDrawColorMarker, FColorMarkerValue);
  R.Left := Width - 15;
  Inc(R.Right, 15);
  if (ADown and AMouseIn) or FMenuTracked
  then
    begin
      Inc(R.Top, 2);
      Inc(R.Left, 2);
    end;

  if not IsNullRect(MenuMarkerRect)
  then
    begin
      DrawMenuMarker(B.Canvas, R, AMouseIn, (ADown and AMouseIn) or FMenuTracked, False);
    end
  else
  if FMenuTracked
  then
    DrawTrackArrowImage(B.Canvas, R, DownFontColor)
  else
    DrawTrackArrowImage(B.Canvas, R, B.Canvas.Font.Color);
end;

procedure TbsSkinMenuSpeedButton.CreateButtonImage;
begin
  if NewStyle and (SkinDataName = 'resizetoolbutton')
  then
    begin
      CreateNewStyleControlSkinResizeImage(B, ADown, AMouseIn);
    end
  else
  if (SkinDataName = 'toolbutton') or (SkinDataName = 'bigtoolbutton')
  then
    begin
      CreateControlSkinResizeImage2(B, ADown, AMouseIn);
    end
  else
  if (SkinDataName = 'resizebutton') or (SkinDataName = 'resizetoolbutton')
  then
    begin
      CreateControlSkinResizeImage(B, ADown, AMouseIn);
    end
  else
  if FMenuTracked and FTrackButtonMode and
     not IsNullRect(TrackButtonRect) and not IsNullRect(DownSkinRect)
  then
    begin
      inherited CreateButtonImage(B, ActiveSkinRect, False, True);
      R := TrackButtonRect;
      OffsetRect(R, DownSkinRect.Left, DownSkinRect.Top);
        B.Canvas.CopyRect(GetNewTrackButtonRect, Picture.Canvas,
       R);
    end
  else
    inherited;
end;

procedure TbsSkinMenuSpeedButton.Paint;
var
  R: TRect;
  IL: TCustomImageList;
  E: Boolean;
  _Caption: String;
begin
  if FShowCaption then _Caption := Caption  else _Caption := '';
  GetSkinData;
  if not FMouseIn and not FDown and not FMenuTracked and Transparent
  then
    begin
      if (FIndex = -1) or (SkinDataName = 'resizebutton') or (SkinDataName = 'toolbutton')
         or (SkinDataName = 'bigtoolbutton') or (SkinDataName = 'resizetoolbutton')
      then
        begin
          R := ClientRect;
          if NewStyle and (FTrackPosition = bstpBottom)
          then
            Dec(R.Bottom, 15)
          else
            Dec(R.Right, 15);
        end
      else
        R := NewClRect;


     if FUseSkinFont and (FIndex <> -1)
     then
       with Canvas.Font do
       begin
         Name := FontName;
         Style := FontStyle;
         Height := FontHeight;
       end
     else
       Canvas.Font.Assign(FDefaultFont);

     if FIndex <> -1
     then
       with Canvas.Font do
       begin
         if Enabled
         then
           begin
             if FUseSkinFontColor
             then Color := FSD.SkinColors.cBtnText
             else Color := FDefaultFont.Color;
           end
         else
           Color := FSD.SkinColors.cBtnShadow;
       end;

     if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
     then
       Canvas.Font.Charset := SkinData.ResourceStrData.CharSet
     else
       Canvas.Font.CharSet := FDefaultFont.Charset;
      if not Enabled then Canvas.Font.Color := clBtnShadow;
      if (FSkinImagesMenu <> nil) and (FSkinImagesMenu.SelectedItem <> nil) and
      FUseImagesMenuImage
     then
      begin
        if FUseImagesMenuCaption
        then
        _Caption := FSkinImagesMenu.SelectedItem.Caption;

        DrawImageAndText(Canvas, R, FMargin, FSpacing, FLayout,
          _Caption, FSkinImagesMenu.SelectedItem.ImageIndex, FSkinImagesMenu.Images,
        False, Enabled, FDrawColorMarker, FColorMarkerValue);
      end
      else
      if FGlyph.Empty and (Parent is TbsSkinToolBar)
      then
        begin
          if not Enabled and (TbsSkinToolBar(Parent).DisabledImages <> nil)
          then
            IL := TbsSkinToolBar(Parent).DisabledImages
          else
            IL := TbsSkinToolBar(Parent).Images;
          E := Enabled;
          if not Enabled and (TbsSkinToolBar(Parent).DisabledImages <> nil)
          then
            E := True;
          DrawImageAndText(Canvas, R, FMargin, FSpacing, FLayout,
           _Caption, FImageIndex, IL, False, E, FDrawColorMarker, FColorMarkerValue);
        end
      else
      if FGlyph.Empty and (FButtonImages <> nil) and (FImageIndex >= 0) and
       (FImageIndex < FButtonImages.Count)
      then
        begin
          DrawImageAndText(Canvas, R, FMargin, FSpacing, FLayout,
         _Caption, FImageIndex, FButtonImages, False, Enabled, FDrawColorMarker, FColorMarkerValue);
       end
       else
        DrawGlyphAndText(Canvas, R, FMargin, FSpacing, FLayout,
          _Caption, FGlyph, FNumGlyphs, GetGlyphNum(FDown, FMouseIn), False, FDrawColorMarker, FColorMarkerValue);

      if (FIndex <> -1) and (SkinDataName <> 'resizebutton')
         and (SkinDataName <> 'resizebutton') and (SkinDataName <> 'toolbutton') and
             (SkinDataName <> 'resizetoolbutton')
      then
        begin
          R.Left := R.Right;
          R.Right := Width;
        end
      else
        begin
          if NewStyle and (FTrackPosition = bstpBottom)
          then
            begin
              R.Top := Height - 15;
              R.Bottom := Height;
            end
          else
            begin
              R.Left := Width - 15;
              R.Right := Width;
            end;  
        end;

      if (FDown and FMouseIn) or FMenuTracked
      then
        begin
          Inc(R.Top, 2);
          Inc(R.Left, 2);
        end;

      if (FIndex <> -1) and not IsNullRect(MenuMarkerFlatRect)
      then
        begin
          DrawMenuMarker(Canvas, R, False, False, True);
        end
      else
      if FIndex = -1
      then
        DrawTrackArrowImage(Canvas, R, clBtnText)
      else
        DrawTrackArrowImage(Canvas, R, SkinData.SkinColors.cBtnText);
    end
  else
    inherited;
end;

procedure TbsSkinMenuSpeedButton.CreateNewStyleControlDefaultImage(B: TBitMap);
var
  R, R1: TRect;
  isDown: Boolean;
  IL: TCustomImageList;
  E: Boolean;
  _Caption: String;
begin
  if FShowCaption then _Caption := Caption  else _Caption := '';
  isDown := False;

  R := Rect(0, 0, Width, Height);

  if TrackPosition = bstpBottom
  then
    R1 := Rect(0, Height - 15, Width, Height)
  else
    R1 := Rect(Width - 15, 0, Width, Height);

  if FTrackButtonMode and FMouseIn
  then
    begin
      if TrackPosition = bstpBottom
      then
        begin
          R := Rect(0, 0, Width, Height - 15);
          R1 := Rect(0, Height - 15, Width, Height);
        end
      else
        begin
          R := Rect(0, 0, Width - 15, Height);
          R1 := Rect(Width - 15, 0, Width, Height);
        end;
      if FMenuTracked
      then
        begin
          B.Canvas.Brush.Color := BS_XP_BTNACTIVECOLOR;
          B.Canvas.FillRect(R);
          Frame3D(B.Canvas, R, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
          B.Canvas.Brush.Color := BS_XP_BTNDOWNCOLOR;
          B.Canvas.FillRect(R1);
          Frame3D(B.Canvas, R1, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
        end
      else
        begin
          if FDown and FMouseIn
          then
            begin
              Frame3D(B.Canvas, R, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
              B.Canvas.Brush.Color := BS_XP_BTNDOWNCOLOR;
              B.Canvas.FillRect(R);
              Frame3D(B.Canvas, R1, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
              B.Canvas.Brush.Color := BS_XP_BTNACTIVECOLOR;
              B.Canvas.FillRect(R1);
              isDown := True;
            end
          else
          if FMouseIn
          then
            begin
              Frame3D(B.Canvas, R, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
              B.Canvas.Brush.Color := BS_XP_BTNACTIVECOLOR;
              B.Canvas.FillRect(R);
              Frame3D(B.Canvas, R1, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
              B.Canvas.Brush.Color := BS_XP_BTNACTIVECOLOR;
              B.Canvas.FillRect(R1);
            end
          else
            if not FFlat
            then
              begin
                Frame3D(B.Canvas, R, clBtnShadow, clBtnShadow, 1);
                B.Canvas.Brush.Color := clBtnFace;
                B.Canvas.FillRect(R);
                Frame3D(B.Canvas, R1, clBtnShadow, clBtnShadow, 1);
                B.Canvas.Brush.Color := clBtnFace;
                B.Canvas.FillRect(R1);
              end
            else
              begin
                B.Canvas.Brush.Color := clBtnFace;
                B.Canvas.FillRect(R);
                B.Canvas.FillRect(R1);
              end;
        end;
    end
  else
    begin
      if FDown and FMouseIn
      then
        begin
          Frame3D(B.Canvas, R, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
          B.Canvas.Brush.Color := BS_XP_BTNDOWNCOLOR;
          B.Canvas.FillRect(R);
          IsDown := True;
        end
      else
        if FMouseIn
        then
          begin
            Frame3D(B.Canvas, R, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
            B.Canvas.Brush.Color := BS_XP_BTNACTIVECOLOR;
            B.Canvas.FillRect(R);
          end
       else
         begin
           if not FFlat
           then
             Frame3D(B.Canvas, R, clBtnShadow, clBtnShadow, 1);
           B.Canvas.Brush.Color := clBtnFace;
           B.Canvas.FillRect(R);
         end;
    end;

  R := ClientRect;

  if TrackPosition = bstpBottom
  then
    Dec(R.Bottom, 15)
  else
    Dec(R.Right, 15);

  B.Canvas.Font.Assign(FDefaultFont);
  if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
  then
    B.Canvas.Font.Charset := SkinData.ResourceStrData.CharSet
  else
    B.Canvas.Font.CharSet := FDefaultFont.Charset;

  if not Enabled then B.Canvas.Font.Color := clBtnShadow;
  if (FSkinImagesMenu <> nil) and (FSkinImagesMenu.SelectedItem <> nil) and
      FUseImagesMenuImage
     then
      begin
        if FUseImagesMenuCaption
        then
        _Caption := FSkinImagesMenu.SelectedItem.Caption;

        DrawImageAndText(B.Canvas, R, FMargin, FSpacing, FLayout,
          _Caption, FSkinImagesMenu.SelectedItem.ImageIndex, FSkinImagesMenu.Images,
        IsDown, Enabled, FDrawColorMarker, FColorMarkerValue);
      end
   else
  if FGlyph.Empty and (Parent is TbsSkinToolBar)
  then
    begin
      if not Enabled and (TbsSkinToolBar(Parent).DisabledImages <> nil)
      then
        IL := TbsSkinToolBar(Parent).DisabledImages
      else
      if (FMouseIn or FDown) and (TbsSkinToolBar(Parent).HotImages <> nil)
      then
        IL := TbsSkinToolBar(Parent).HotImages
      else
        IL := TbsSkinToolBar(Parent).Images;
      E := Enabled;
      if not Enabled and (TbsSkinToolBar(Parent).DisabledImages <> nil)
      then
        E := False;
      DrawImageAndText(B.Canvas, R, FMargin, FSpacing, FLayout,
        _Caption, FImageIndex, IL, isDown, E, FDrawColorMarker, FColorMarkerValue);
    end
  else
  if FGlyph.Empty and (FButtonImages <> nil) and (FImageIndex >= 0) and
     (FImageIndex < FButtonImages.Count)
  then
    begin
      DrawImageAndText(B.Canvas, R, FMargin, FSpacing, FLayout,
        _Caption, FImageIndex, FButtonImages, isDown, Enabled, FDrawColorMarker, FColorMarkerValue);
    end
  else
  DrawGlyphAndText(B.Canvas, R, FMargin, FSpacing, FLayout,
                  _Caption, FGlyph, FNumGlyphs, GetGlyphNum(FDown, FMouseIn),  isDown, FDrawColorMarker, FColorMarkerValue);

  R := R1;

  IsDown := FMouseIn and FDown;

  if FTrackButtonMode and not FMenuTracked then isDown := False;

  if IsDown
  then
    begin
      Inc(R.Top, 2);
      Inc(R.Left, 2);
    end;

  DrawTrackArrowImage(B.Canvas, R, clBtnText);
end;

procedure TbsSkinMenuSpeedButton.CreateControlDefaultImage;
var
  R, R1: TRect;
  isDown: Boolean;
  IL: TCustomImageList;
  E: Boolean;
  _Caption: String;
begin
  if FNewStyle
  then
    begin
      CreateNewStyleControlDefaultImage(B);
      Exit;
    end;
  if FShowCaption then _Caption := Caption  else _Caption := '';
  isDown := False;
  R := Rect(0, 0, Width, Height);
  if FTrackButtonMode
  then
    begin
      R := Rect(0, 0, Width - 15, Height);
      R1 := Rect(Width - 15, 0, Width, Height);
      if FMenuTracked
      then
        begin
          B.Canvas.Brush.Color := BS_XP_BTNACTIVECOLOR;
          B.Canvas.FillRect(R);
          Frame3D(B.Canvas, R, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
          B.Canvas.Brush.Color := BS_XP_BTNDOWNCOLOR;
          B.Canvas.FillRect(R1);
          Frame3D(B.Canvas, R1, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
        end
      else
        begin
          if FDown and FMouseIn
          then
            begin
              Frame3D(B.Canvas, R, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
              B.Canvas.Brush.Color := BS_XP_BTNDOWNCOLOR;
              B.Canvas.FillRect(R);
              Frame3D(B.Canvas, R1, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
              B.Canvas.Brush.Color := BS_XP_BTNDOWNCOLOR;
              B.Canvas.FillRect(R1);
              isDown := True;
            end
          else
          if FMouseIn
          then
            begin
              Frame3D(B.Canvas, R, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
              B.Canvas.Brush.Color := BS_XP_BTNACTIVECOLOR;
              B.Canvas.FillRect(R);
              Frame3D(B.Canvas, R1, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
              B.Canvas.Brush.Color := BS_XP_BTNACTIVECOLOR;
              B.Canvas.FillRect(R1);
            end
          else
            if not FFlat
            then
              begin
                Frame3D(B.Canvas, R, clBtnShadow, clBtnShadow, 1);
                B.Canvas.Brush.Color := clBtnFace;
                B.Canvas.FillRect(R);
                Frame3D(B.Canvas, R1, clBtnShadow, clBtnShadow, 1);
                B.Canvas.Brush.Color := clBtnFace;
                B.Canvas.FillRect(R1);
              end
            else
              begin
                B.Canvas.Brush.Color := clBtnFace;
                B.Canvas.FillRect(R);
                B.Canvas.FillRect(R1);
              end;
        end;
    end
  else
    begin
      if FDown and FMouseIn
      then
        begin
          Frame3D(B.Canvas, R, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
          B.Canvas.Brush.Color := BS_XP_BTNDOWNCOLOR;
          B.Canvas.FillRect(R);
          IsDown := True;
        end
      else
        if FMouseIn
        then
          begin
            Frame3D(B.Canvas, R, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
            B.Canvas.Brush.Color := BS_XP_BTNACTIVECOLOR;
            B.Canvas.FillRect(R);
          end
       else
         begin
           if not FFlat
           then
             Frame3D(B.Canvas, R, clBtnShadow, clBtnShadow, 1);
           B.Canvas.Brush.Color := clBtnFace;
           B.Canvas.FillRect(R);
         end;
    end;
  R := ClientRect;
  Dec(R.Right, 15);
  B.Canvas.Font.Assign(FDefaultFont);
  if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
  then
    B.Canvas.Font.Charset := SkinData.ResourceStrData.CharSet
  else
    B.Canvas.Font.CharSet := FDefaultFont.Charset;

  if not Enabled then B.Canvas.Font.Color := clBtnShadow;
  if (FSkinImagesMenu <> nil) and (FSkinImagesMenu.SelectedItem <> nil) and
      FUseImagesMenuImage
     then
      begin
        if FUseImagesMenuCaption
        then
        _Caption := FSkinImagesMenu.SelectedItem.Caption;

        DrawImageAndText(B.Canvas, R, FMargin, FSpacing, FLayout,
          _Caption, FSkinImagesMenu.SelectedItem.ImageIndex, FSkinImagesMenu.Images,
        IsDown, Enabled, FDrawColorMarker, FColorMarkerValue);
      end
   else
  if FGlyph.Empty and (Parent is TbsSkinToolBar)
  then
    begin
      if not Enabled and (TbsSkinToolBar(Parent).DisabledImages <> nil)
      then
        IL := TbsSkinToolBar(Parent).DisabledImages
      else
      if (FMouseIn or FDown) and (TbsSkinToolBar(Parent).HotImages <> nil)
      then
        IL := TbsSkinToolBar(Parent).HotImages
      else
        IL := TbsSkinToolBar(Parent).Images;
      E := Enabled;
      if not Enabled and (TbsSkinToolBar(Parent).DisabledImages <> nil)
      then
        E := False;
      DrawImageAndText(B.Canvas, R, FMargin, FSpacing, FLayout,
        _Caption, FImageIndex, IL, isDown, E, FDrawColorMarker, FColorMarkerValue);
    end
  else
  if FGlyph.Empty and (FButtonImages <> nil) and (FImageIndex >= 0) and
     (FImageIndex < FButtonImages.Count)
  then
    begin
      DrawImageAndText(B.Canvas, R, FMargin, FSpacing, FLayout,
        _Caption, FImageIndex, FButtonImages, isDown, Enabled, FDrawColorMarker, FColorMarkerValue);
    end
  else
  DrawGlyphAndText(B.Canvas, R, FMargin, FSpacing, FLayout,
                  _Caption, FGlyph, FNumGlyphs, GetGlyphNum(FDown, FMouseIn),  isDown, FDrawColorMarker, FColorMarkerValue);
  R.Left := Width - 15;
  Inc(R.Right, 15);
  if (FDown and FMouseIn) or FMenuTracked
  then
    begin
      Inc(R.Top, 2);
      Inc(R.Left, 2);
    end;
  DrawTrackArrowImage(B.Canvas, R, clBtnText);
end;

function TbsSkinMenuSpeedButton.GetNewTrackButtonRect;
var
  RM, Off: Integer;
  R: TRect;
begin
  RM := GetResizeMode;
  R := TrackButtonRect;
  case RM of
    2:
      begin
        Off := Width - RectWidth(SkinRect);
        OffsetRect(R, Off, 0);
      end;
    3:
      begin
        Off := Height - RectHeight(SkinRect);
        OffsetRect(R, 0, Off);
      end;
  end;
  Result := R;
end;

function TbsSkinMenuSpeedButton.CanMenuTrack;
var
  R: TRect;
begin
  if (FSkinPopupMenu = nil) and (FSkinImagesMenu = nil)
  then
    begin
     Result := False;
     Exit;
   end;
   if not FTrackButtonMode
   then
     Result := True
   else
     begin
       if (FIndex <> -1) and (SkinDataName <> 'resizebutton') and
       (SkinDataName <> 'resizetoolbutton') and (SkinDataName <> 'toolbutton')
       and (SkinDataName <> 'bigtoolbutton')
       then R := GetNewTrackButtonRect
       else
         if NewStyle
         then
           begin
             if TrackPosition = bstpRight
             then
               R := Rect(Width - 15, 0, Width, Height)
             else
               R := Rect(0, Height - 15, Width, Height);
           end
         else
          R := Rect(Width - 15, 0, Width, Height);
       Result := PointInRect(R, Point(X, Y));
     end;
end;

procedure TbsSkinMenuSpeedButton.WMCLOSESKINMENU;
begin
  FMenuTracked := False;
  Down := False;
  if Assigned(FOnHideTrackMenu) then FOnHideTrackMenu(Self);
end;

procedure TbsSkinMenuSpeedButton.TrackMenu;
var
  R: TRect;
  P: TPoint;
begin
  if FSkinPopupMenu <> nil
  then
    begin
      P := ClientToScreen(Point(0, 0));
      R := Rect(P.X, P.Y, P.X + Width, P.Y + Height);
      FSkinPopupMenu.PopupFromRect2(Self, R, False);
      if Assigned(FOnShowTrackMenu) then FOnShowTrackMenu(Self);
    end;
  if FSkinImagesMenu <> nil
  then
    begin
      P := ClientToScreen(Point(0, 0));
      R := Rect(P.X, P.Y, P.X + Width, P.Y + Height);
      FSkinImagesMenu.OnInternalMenuClose := OnImagesMenuClose;
      FSkinImagesMenu.PopupFromRect(R);
      if Assigned(FOnShowTrackMenu) then FOnShowTrackMenu(Self);
    end;
end;

procedure TbsSkinMenuSpeedButton.Notification;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FSkinPopupMenu)
  then FSkinPopupMenu := nil;
end;

procedure TbsSkinMenuSpeedButton.CMMouseEnter(var Message: TMessage);
begin
  if (csDesigning in ComponentState) then Exit;
  if not FMenuTracked then inherited else FMouseIn := True;
end;

procedure TbsSkinMenuSpeedButton.CMMouseLeave(var Message: TMessage);
begin
  if (csDesigning in ComponentState) then Exit;
  if not FMenuTracked then inherited else FMouseIn := False;
end;

procedure TbsSkinMenuSpeedButton.GetSkinData;
begin
  inherited;
  if FIndex <> -1
  then
    if TbsDataSkinControl(FSD.CtrlList.Items[FIndex]) is TbsDataSkinMenuButtonControl
    then
      with TbsDataSkinMenuButtonControl(FSD.CtrlList.Items[FIndex]) do
      begin
        Self.TrackButtonRect := TrackButtonRect;
      end;
end;

procedure TbsSkinMenuSpeedButton.SetTrackButtonMode;
begin
  FTrackButtonMode := Value;
  if FIndex = - 1 then RePaint;
end;

procedure TbsSkinMenuSpeedButton.MouseDown;
begin
  if Button <> mbLeft
  then
    begin
      inherited;
      Exit;
    end;
  FMenuTracked := CanMenuTrack(X, Y);
  FMouseIn := True;
  if FMenuTracked
  then
    begin
      if not FDown then Down := True;
      TrackMenu;
    end
  else
    inherited;
end;

procedure TbsSkinMenuSpeedButton.MouseUp;
begin
  if not FMenuTracked then inherited;
end;

constructor TbsSkinTextLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable] - [csOpaque];
  Width := 65;
  Height := 65;
  FAutoSize := True;
  FLines := TStringList.Create;
  TStringList(FLines).OnChange := OnTextChange;
  FSkinDataName := 'stdlabel';
  FDefaultFont := TFont.Create;
  FUseSkinFont := False;
  FUseSkinColor := True;
end;

destructor TbsSkinTextLabel.Destroy;
begin
  FLines.Free;
  FDefaultFont.Free;
  inherited;
end;

procedure TbsSkinTextLabel.OnTextChange(Sender: TObject);
begin
  if FAutoSize then AdjustBounds;
  Invalidate;
end;


procedure TbsSkinTextLabel.SetDefaultFont;
begin
  FDefaultFont.Assign(Value);
end;

procedure TbsSkinTextLabel.Notification;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FSD) then FSD := nil;
end;


procedure TbsSkinTextLabel.GetSkinData;
begin
  if (FSD = nil) or FSD.Empty
  then
    FIndex := -1
  else
    FIndex := FSD.GetControlIndex(FSkinDataName);
  if FIndex <> -1
  then
    if TbsDataSkinControl(FSD.CtrlList.Items[FIndex]) is TbsDataSkinStdLabelControl
    then
      with TbsDataSkinStdLabelControl(FSD.CtrlList.Items[FIndex]) do
      begin
        Self.FontName := FontName;
        Self.FontStyle := FontStyle;
        Self.FontHeight := FontHeight;
        Self.FontColor := FontColor;
      end;
end;

procedure TbsSkinTextLabel.ChangeSkinData;
begin
  GetSkinData;
  if FAutoSize then AdjustBounds;
  RePaint;
end;

procedure TbsSkinTextLabel.SetSkinData;
begin
  FSD := Value;
  if (FSD <> nil) then ChangeSkinData;
end;

procedure TbsSkinTextLabel.SetLines;
begin
  FLines.Assign(Value);
  RePaint;
end;

function TbsSkinTextLabel.GetLabelText: string;
begin
  Result := FLines.Text;
end;

procedure TbsSkinTextLabel.DoDrawText(var Rect: TRect; Flags: Longint);
var
  LText: string;
begin
  GetSkinData;

  LText := GetLabelText;
  Flags := DrawTextBiDiModeFlags(Flags);

  if FIndex <> -1
  then
    with Canvas.Font do
    begin
      if FUseSkinFont
      then
        begin
          Name := FontName;
          Style := FontStyle;
          Height := FontHeight;
        end
      else
        Canvas.Font := Self.Font;
      if FUseSkinColor then Color := FontColor else Color := Self.Font.Color;
    end
  else
    if FUseSkinFont
    then
      Canvas.Font := DefaultFont
    else
      Canvas.Font := Self.Font;

  if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
  then
    Canvas.Font.Charset := SkinData.ResourceStrData.CharSet
  else
    Canvas.Font.CharSet := FDefaultFont.Charset;

  if not Enabled then
  begin
    OffsetRect(Rect, 1, 1);
    if FIndex <> -1
    then
      Canvas.Font.Color := FSD.SkinColors.cBtnHighLight
    else
      Canvas.Font.Color := clBtnHighlight;
    DrawText(Canvas.Handle, PChar(LText), Length(LText), Rect, Flags);
    OffsetRect(Rect, -1, -1);
    if FIndex <> -1
    then
      Canvas.Font.Color := FSD.SkinColors.cBtnShadow
    else
      Canvas.Font.Color := clBtnShadow;
    DrawText(Canvas.Handle, PChar(LText), Length(LText), Rect, Flags);
  end
  else
    begin
      DrawText(Canvas.Handle, PChar(LText), Length(LText), Rect, Flags);
    end;
end;

procedure TbsSkinTextLabel.Paint;
const
  Alignments: array[TAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
  WordWraps: array[Boolean] of Word = (0, DT_WORDBREAK);
var
  Rect, CalcRect: TRect;
  DrawStyle: Longint;
begin
  with Canvas do
  begin
    Brush.Style := bsClear;
    Rect := ClientRect;
    { DoDrawText takes care of BiDi alignments }
    DrawStyle := DT_EXPANDTABS or WordWraps[FWordWrap] or Alignments[FAlignment];
    { Calculate vertical layout }
    if FLayout <> tlTop then
    begin
      CalcRect := Rect;
      DoDrawText(CalcRect, DrawStyle or DT_CALCRECT);
      Dec(CalcRect.Bottom, Canvas.TextHeight('A'));
      if FLayout = tlBottom then OffsetRect(Rect, 0, Height - CalcRect.Bottom)
      else OffsetRect(Rect, 0, (Height - CalcRect.Bottom) div 2);
    end;
    DoDrawText(Rect, DrawStyle);
  end;
end;

procedure TbsSkinTextLabel.Loaded;
begin
  inherited Loaded;
  AdjustBounds;
end;

procedure TbsSkinTextLabel.AdjustBounds;
const
  WordWraps: array[Boolean] of Word = (0, DT_WORDBREAK);
var
  DC: HDC;
  X: Integer;
  Rect, R: TRect;
  AAlignment: TAlignment;
begin
  if not (csReading in ComponentState) and FAutoSize then
  begin
    Rect := ClientRect;
    DC := GetDC(0);
    Canvas.Handle := DC;
    DoDrawText(Rect, (DT_EXPANDTABS or DT_CALCRECT) or WordWraps[FWordWrap]);
    X := Left;
    AAlignment := FAlignment;
    if UseRightToLeftAlignment then ChangeBiDiModeAlignment(AAlignment);
    if AAlignment = taRightJustify then Inc(X, Width - Rect.Right);
    Dec(Rect.Bottom, Canvas.TextHeight('A'));
    Canvas.Handle := 0;
    ReleaseDC(0, DC);
    SetBounds(X, Top, Rect.Right, Rect.Bottom);
  end;
end;

procedure TbsSkinTextLabel.SetAlignment(Value: TAlignment);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    Invalidate;
  end;
end;

procedure TbsSkinTextLabel.SetAutoSize(Value: Boolean);
begin
  if FAutoSize <> Value then
  begin
    FAutoSize := Value;
    AdjustBounds;
  end;
end;

procedure TbsSkinTextLabel.SetLayout(Value: TTextLayout);
begin
  if FLayout <> Value then
  begin
    FLayout := Value;
    Invalidate;
  end;
end;

procedure TbsSkinTextLabel.SetWordWrap(Value: Boolean);
begin
  if FWordWrap <> Value then
  begin
    FWordWrap := Value;
    AdjustBounds;
    Invalidate;
  end;
end;

procedure TbsSkinTextLabel.CMFontChanged(var Message: TMessage);
begin
  inherited;
  AdjustBounds;
  Invalidate;
end;

// ======================== TbsSkinExPanel ============================= //

constructor TbsSkinExPanel.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := [csAcceptsControls, csCaptureMouse, csClickEvents,
    csSetCaption, csOpaque, csDoubleClicks, csReplicatable];
  Forcebackground := True;
  DrawBackground := True;
  FNumGlyphs := 1;
  FGlyph := TBitMap.Create;
  FSpacing := 2;
  FDefaultCaptionHeight := 21;
  Width := 150;
  Height := 100;
  FRollKind := rkRollVertical;
  ActiveButton := -1;
  OldActiveButton := -1;
  CaptureButton := -1;
  FShowRollButton := True;
  FShowCloseButton := True;
  FRollState := False;
  FRealWidth := 0;
  FRealHeight := 0;
  StopCheckSize := False;
  FSkinDataName := 'expanel';
  FCMaxWidth := 0;
  FCMinWidth := 0;
  FCMaxHeight := 0;
  FCMinHeight := 0;
  FCaptionImageList := nil;
  FCaptionImageIndex := -1;
end;

destructor TbsSkinExPanel.Destroy;
begin
  FGlyph.Free;
  inherited;
end;

procedure TbsSkinExPanel.Notification;
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FCaptionImageList)
  then FCaptionImageList := nil;
end;

procedure TbsSkinExPanel.SetCaptionImageIndex(Value: Integer);
begin
  if FCaptionImageIndex <> Value
  then
    begin
      FCaptionImageIndex := Value;
      RePaint;
    end;
end;


procedure TbsSkinExPanel.SetNumGlyphs;
begin
  FNumGlyphs := Value;
  RePaint;
end;

procedure TbsSkinExPanel.SetGlyph;
begin
  FGlyph.Assign(Value);
  RePaint;
end;

procedure TbsSkinExPanel.SetSpacing;
begin
  FSpacing := Value;
  RePaint;
end;

procedure TbsSkinExPanel.ChangeSkinData;
begin
  inherited;
  if FRollState
  then
    begin
      if FRollKind = rkRollVertical
      then Height := GetRollHeight
      else Width := GetRollWidth;
    end
  else
    ReAlign;
end;

procedure TbsSkinExPanel.Close;
begin
  Visible := False;
  if not (csDesigning in ComponentState) and
    Assigned(FOnClose)
  then
    FOnClose(Self);
end;

procedure TbsSkinExPanel.GetSkinData;
begin
  inherited;
  if FIndex <> -1
  then
    if TbsDataSkinControl(FSD.CtrlList.Items[FIndex]) is TbsDataSkinExPanelControl
    then
      with TbsDataSkinExPanelControl(FSD.CtrlList.Items[FIndex]) do
      begin
        Self.CaptionRect := CaptionRect;
        Self.FontName := FontName;
        Self.FontColor := FontColor;
        Self.FontStyle := FontStyle;
        Self.FontHeight := FontHeight;
        Self.RollHSkinRect := RollHSkinRect;
        Self.RollVSkinRect := RollVSkinRect;
        Self.RollLeftOffset := RollLeftOffset;
        Self.RollRightOffset := RollRightOffset;
        Self.RollTopOffset := RollTopOffset;
        Self.RollBottomOffset := RollBottomOffset;
        Self.RollVCaptionRect := RollVCaptionRect;
        Self.RollHCaptionRect := RollHCaptionRect;
        Self.CloseButtonRect := CloseButtonRect;
        Self.CloseButtonActiveRect := CloseButtonActiveRect;
        Self.CloseButtonDownRect := CloseButtonDownRect;

        Self.HRollButtonRect := HRollButtonRect;
        Self.HRollButtonActiveRect := HRollButtonActiveRect;
        if IsNullRect(Self.HRollButtonActiveRect)
        then Self.HRollButtonActiveRect := Self.HRollButtonRect;
        Self.HRollButtonDownRect := HRollButtonDownRect;
        if IsNullRect(Self.HRollButtonDownRect)
        then Self.HRollButtonDownRect := Self.HRollButtonActiveRect;

        Self.HRestoreButtonRect := HRestoreButtonRect;
        Self.HRestoreButtonActiveRect := HRestoreButtonActiveRect;
        if IsNullRect(Self.HRestoreButtonActiveRect)
        then Self.HRestoreButtonActiveRect := Self.HRestoreButtonRect;
        Self.HRestoreButtonDownRect := HRestoreButtonDownRect;
        if IsNullRect(Self.HRestoreButtonDownRect)
        then Self.HRestoreButtonDownRect := Self.HRestoreButtonActiveRect;

        Self.VRollButtonRect := VRollButtonRect;
        Self.VRollButtonActiveRect := VRollButtonActiveRect;
        if IsNullRect(Self.VRollButtonActiveRect)
        then Self.VRollButtonActiveRect := Self.VRollButtonRect;
        Self.VRollButtonDownRect := VRollButtonDownRect;
        if IsNullRect(Self.VRollButtonDownRect)
        then Self.VRollButtonDownRect := Self.VRollButtonActiveRect;

        Self.VRestoreButtonRect := VRestoreButtonRect;
        Self.VRestoreButtonActiveRect := VRestoreButtonActiveRect;
        if IsNullRect(Self.VRestoreButtonActiveRect)
        then Self.VRestoreButtonActiveRect := Self.VRestoreButtonRect;
        Self.VRestoreButtonDownRect := VRestoreButtonDownRect;
        if IsNullRect(Self.VRestoreButtonDownRect)
        then Self.VRestoreButtonDownRect := Self.VRestoreButtonActiveRect;
      end;
end;

procedure TbsSkinExPanel.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  if FRollState and not StopCheckSize
  then
    begin
      if (FRollKind = rkRollHorizontal) and (AWidth <> GetRollWidth)
      then AWidth := GetRollWidth
      else
      if (FRollKind = rkRollVertical) and (AHeight <> GetRollHeight)
      then AHeight := GetRollHeight
    end;
  inherited;
end;

procedure TbsSkinExPanel.CMTextChanged;
begin
  inherited;
  RePaint;
end;

procedure TbsSkinExPanel.SetShowRollButton(Value: Boolean);
begin
  FShowRollButton := Value;
  RePaint;
end;

procedure TbsSkinExPanel.SetShowCloseButton(Value: Boolean);
begin
  FShowCloseButton := Value;
  RePaint;
end;

function TbsSkinExPanel.GetRollWidth: Integer;
begin
  if FIndex = -1
  then
    Result := FDefaultCaptionHeight
  else
    Result := RectWidth(RollHSkinRect);
end;

function TbsSkinExPanel.GetRollHeight: Integer;
begin
  if FIndex = -1
  then
    Result := FDefaultCaptionHeight
  else
    Result := RectHeight(RollVSkinRect);
end;

procedure TbsSkinExPanel.SetRollKind(Value: TbsExPanelRollKind);
begin
  FRollKind := Value;
  RePaint;
end;

procedure TbsSkinExPanel.SetDefaultCaptionHeight;
begin
  FDefaultCaptionHeight := Value;
  if FIndex = -1
  then
    begin
      RePaint;
      ReAlign;
    end
end;

procedure TbsSkinExPanel.CreateControlDefaultImage(B: TBitMap);
var
  R, CR: TRect;
  GlyphNum, BW, CROffset, TX, TY, GX, GY: Integer;
  F: TLogFont;
begin
  BW := FDefaultCaptionHeight - 6;
  R := Rect(0, 0, Width, Height);
  if FRollState and (FRollKind = rkRollHorizontal)
  then
    with B.Canvas do
    begin
      Brush.Color := clBtnFace;
      FillRect(R);
      CR := R;
      Frame3D(B.Canvas, R, clBtnShadow, clBtnShadow, 1);
      Frame3D(B.Canvas, R, clBtnHighLight, clBtnFace, 1);
      CROffset := 0;
      if FShowCloseButton
      then
        begin
          begin
            Buttons[0].R := Rect(3, 3, 3 + BW, 3 + BW);
            CROffset := CROffset + RectHeight(Buttons[0].R);
          end;
        end
      else
        Buttons[0].R := Rect(0, 0, 0, 3);

      if FShowRollButton
      then
        begin
          Buttons[1].R := Rect(3, Buttons[0].R.Bottom, 3 + BW, Buttons[0].R.Bottom + BW);
          CROffset := CROffset + RectHeight(Buttons[1].R);
        end
      else
        Buttons[1].R := Rect(0, 0, 0, 0);
      //
      Font := DefaultFont;
      if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
      then
        Font.Charset := SkinData.ResourceStrData.CharSet;
        
      GetObject(Font.Handle, SizeOf(F), @F);
      F.lfEscapement := round(900);
      Font.Handle := CreateFontIndirect(F);
      Inc(CR.Top, CROffset + 2);
      TX := CR.Left + RectWidth(CR) div 2 - TextHeight(Caption) div 2;
      TY := CR.Bottom - 2 ;
      Brush.Style := bsClear;
      if FGlyph.Empty and (FCaptionImageList <> nil) and (FCaptionImageIndex >= 0) and
       (FCaptionImageIndex < FCaptionImageList.Count)
       then
         begin
           GX := CR.Left + RectWidth(CR) div 2 - FCaptionImageList.Width div 2;
           GY := CR.Bottom - FCaptionImageList.Height - 2;
           FCaptionImageList.Draw(B.Canvas, GX, GY, FCaptionImageIndex, Enabled);
           TY := TY - FCaptionImageList.Height - FSpacing - 2;
         end
       else
      if not FGlyph.Empty
      then
        begin
          GX := CR.Left + RectWidth(CR) div 2 - (FGlyph.Width div NumGlyphs) div 2;
          GY := CR.Bottom - FGlyph.Height - 2;
          GlyphNum := 1;
          if not Enabled and (NumGlyphs = 2) then GlyphNum := 2;
          DrawGlyph(B.Canvas, GX, GY, FGlyph, NumGlyphs, GlyphNum);
          TY := TY - FGlyph.Height - FSpacing - 2;
        end;
      TextRect(CR, TX, TY, Caption);
      //
    end
  else
    with B.Canvas do
    begin
      Frame3D(B.Canvas, R, clBtnShadow, clBtnShadow, 1);
      Brush.Color := clBtnFace;
      FillRect(R);
      CR := Rect(0, 0, Width, FDefaultCaptionHeight);
      CROffset := 0;
      Frame3D(B.Canvas, CR, clBtnShadow, clBtnShadow, 1);
      Frame3D(B.Canvas, CR, clBtnHighLight, clBtnFace, 1);

      if FShowCloseButton
      then
        begin
          Buttons[0].R := Rect(Width - BW - 2, 3, Width - 2, 3 + BW);
          CROffset := CROffset + RectWidth(Buttons[1].R);
        end
      else
        Buttons[0].R := Rect(Width - 2, 0, 0, 0);

      if FShowRollButton
      then
        begin
          Buttons[1].R := Rect(Buttons[0].R.Left - BW, 3, Buttons[0].R.Left, 3 + BW);
          CROffset := CROffset + RectWidth(Buttons[1].R);
        end
      else
        Buttons[1].R := Rect(0, 0, 0, 0);
      //
      Inc(CR.Left, 2);
      Dec(CR.Right, CROffset + 2);
      //
      Brush.Style := bsClear;
      Font := DefaultFont;
      if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
      then
        Font.Charset := SkinData.ResourceStrData.CharSet;
      //
       if FGlyph.Empty and (FCaptionImageList <> nil) and (FCaptionImageIndex >= 0) and
       (FCaptionImageIndex < FCaptionImageList.Count)
       then
         begin
           GX := CR.Left;
           GY := CR.Top + RectHeight(CR) div 2 - FCaptionImageList.Height div 2;
           FCaptionImageList.Draw(B.Canvas, GX, GY, FCaptionImageIndex, Enabled);
           Inc(CR.Left, FCaptionImageList.Width + FSpacing);
         end
       else
      if not FGlyph.Empty
       then
         begin
           GX := CR.Left;
           GY := CR.Top + RectHeight(CR) div 2 - FGlyph.Height div 2;
           GlyphNum := 1;
           if not Enabled and (NumGlyphs = 2) then GlyphNum := 2;
           DrawGlyph(B.Canvas, GX, GY, FGlyph, NumGlyphs, GlyphNum);
           Inc(CR.Left, FGlyph.Width div NumGlyphs + FSpacing);
         end;
       BSDrawText2(B.Canvas, Caption, CR);
     end;
  if FShowCloseButton then DrawButton(B.Canvas, 0);
  if FShowRollButton then DrawButton(B.Canvas, 1);
end;

procedure TbsSkinExPanel.CreateControlSkinImage(B: TBitMap);
var
  CR: TRect;
  F: TLogFont;
  CROffset, BO, TX, TY, GX, GY, GlyphNum: Integer;
begin
  with B.Canvas.Font do
  begin
    if FUseSkinFont
    then
      begin
        Name := FontName;
        Style := FontStyle;
        Height := FontHeight;
      end
    else
      Assign(FDefaultFont);
    Color := FontColor;
  end;

  if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
  then
    B.Canvas.Font.Charset := SkinData.ResourceStrData.CharSet
  else
    B.Canvas.Font.CharSet := FDefaultFont.Charset;

  B.Canvas.Brush.Style := bsClear;
  if FRollState and (FRollKind = rkRollHorizontal)
  then
    begin
      CreateVSkinImage(RollTopOffset, RollBottomOffset,
        B, Picture, RollHSkinRect, GetRollWidth, Height, False);
      CR := RollHCaptionRect;
      Inc(CR.Bottom, Height - RectHeight(RollHSkinRect));

      CROffset := 0;
      BO := 0;
      if FShowCloseButton
      then
        begin
          begin
            Buttons[0].R := Rect(CR.Left, CR.Top,
              CR.Left + RectWidth(Self.CloseButtonRect),
              CR.Top + RectHeight(Self.CloseButtonRect));
            CROffset := CROffset + RectHeight(Buttons[0].R);
            BO := 2;
          end;
        end
      else
        Buttons[0].R := Rect(0, 0, 0, CR.Top);

      if FShowRollButton
      then
        begin
          Buttons[1].R := Rect(CR.Left, Buttons[0].R.Bottom + BO,
            CR.Left + RectWidth(Self.HRollButtonRect),
            Buttons[0].R.Bottom + RectHeight(Self.HRollButtonRect) + BO);
          CROffset := CROffset + RectHeight(Buttons[1].R) + BO;
        end
      else
        Buttons[1].R := Rect(0, 0, 0, 0);
      Inc(CR.Top, CROffset);
      GetObject(B.Canvas.Font.Handle, SizeOf(F), @F);
      F.lfEscapement := round(900);
      B.Canvas.Font.Handle := CreateFontIndirect(F);
      TX := CR.Left + RectWidth(CR) div 2 - B.Canvas.TextHeight(Caption) div 2;
      TY := CR.Bottom;

      if FGlyph.Empty and (FCaptionImageList <> nil) and (FCaptionImageIndex >= 0) and
       (FCaptionImageIndex < FCaptionImageList.Count)
       then
         begin
           GX := CR.Left + RectWidth(CR) div 2 - FCaptionImageList.Width div 2;
           GY := CR.Bottom - FCaptionImageList.Height;
           FCaptionImageList.Draw(B.Canvas, GX, GY, FCaptionImageIndex, Enabled);
           TY := TY - FCaptionImageList.Height - FSpacing;
         end
       else
      if not FGlyph.Empty
       then
         begin
           GX := CR.Left + RectWidth(CR) div 2 - (FGlyph.Width div NumGlyphs) div 2;
           GY := CR.Bottom - FGlyph.Height;
           GlyphNum := 1;
           if not Enabled and (NumGlyphs = 2) then GlyphNum := 2;
           DrawGlyph(B.Canvas, GX, GY, FGlyph, NumGlyphs, GlyphNum);
           TY := TY - FGlyph.Height - FSpacing;
         end;
      B.Canvas.TextRect(CR, TX, TY, Caption);
    end
  else
    if FRollState and (FRollKind = rkRollVertical)
    then
      begin
        CreateHSkinImage(RollLeftOffset, RollRightOffset,
          B, Picture, RollVSkinRect, Width, GetRollHeight, False);
        CR := RollVCaptionRect;
        Inc(CR.Right, Width - RectWidth(RollVSkinRect));
        CROffset := 0;
        BO := 0;
        if FShowCloseButton
        then
         begin
           Buttons[0].R := Rect(CR.Right - RectWidth(CloseButtonRect), CR.Top,
             CR.Right, CR.Top + RectHeight(CloseButtonRect));
           CROffset := CROffset + RectWidth(Buttons[1].R);
           BO := 2;
         end
        else
          Buttons[0].R := Rect(CR.Right, 0, 0, 0);

        if FShowRollButton
        then
          begin
            Buttons[1].R := Rect(Buttons[0].R.Left - RectWidth(VRollButtonRect) - BO,
            CR.Top, Buttons[0].R.Left - BO, CR.Top + RectHeight(VRollButtonRect));
            CROffset := CROffset + RectWidth(Buttons[1].R) + BO;
          end
        else
          Buttons[1].R := Rect(0, 0, 0, 0);
        Dec(CR.Right, CROffset);
        
       if FGlyph.Empty and (FCaptionImageList <> nil) and (FCaptionImageIndex >= 0) and
       (FCaptionImageIndex < FCaptionImageList.Count)
       then
         begin
           GX := CR.Left;
           GY := CR.Top + RectHeight(CR) div 2 - FCaptionImageList.Height div 2;
           FCaptionImageList.Draw(B.Canvas, GX, GY, FCaptionImageIndex, Enabled);
           Inc(CR.Left, FCaptionImageList.Width + FSpacing);
         end
       else
        if not FGlyph.Empty
        then
         begin
           GX := CR.Left;
           GY := CR.Top + RectHeight(CR) div 2 - FGlyph.Height div 2;
           GlyphNum := 1;
           if not Enabled and (NumGlyphs = 2) then GlyphNum := 2;
           DrawGlyph(B.Canvas, GX, GY, FGlyph, NumGlyphs, GlyphNum);
           Inc(CR.Left, FGlyph.Width div NumGlyphs + FSpacing);
         end;
        BSDrawText2(B.Canvas, Caption, CR);
      end
   else
     begin
       inherited;
       CR := CaptionRect;
       Inc(CR.Right, Width - RectWidth(SkinRect));
       CROffset := 0;
       BO := 0;
       if FShowCloseButton
       then
        begin
          Buttons[0].R := Rect(CR.Right - RectWidth(CloseButtonRect), CR.Top,
           CR.Right, CR.Top + RectHeight(CloseButtonRect));
          CROffset := CROffset + RectWidth(Buttons[1].R);
          BO := 2;
        end
       else
         Buttons[0].R := Rect(CR.Right, 0, 0, 0);

       if FShowRollButton
       then
         begin
           Buttons[1].R := Rect(Buttons[0].R.Left - RectWidth(VRollButtonRect) - BO,
           CR.Top, Buttons[0].R.Left - BO, CR.Top + RectHeight(VRollButtonRect));
           CROffset := CROffset + RectWidth(Buttons[1].R) + BO;
         end
       else
         Buttons[1].R := Rect(0, 0, 0, 0);
       Dec(CR.Right, CROffset);

       if FGlyph.Empty and (FCaptionImageList <> nil) and (FCaptionImageIndex >= 0) and
       (FCaptionImageIndex < FCaptionImageList.Count)
       then
         begin
           GX := CR.Left;
           GY := CR.Top + RectHeight(CR) div 2 - FCaptionImageList.Height div 2;
           FCaptionImageList.Draw(B.Canvas, GX, GY, FCaptionImageIndex, Enabled);
           Inc(CR.Left, FCaptionImageList.Width + FSpacing);
         end
       else
       if not FGlyph.Empty
       then
         begin
           GX := CR.Left;
           GY := CR.Top + RectHeight(CR) div 2 - FGlyph.Height div 2;
           GlyphNum := 1;
           if not Enabled and (NumGlyphs = 2) then GlyphNum := 2;
           DrawGlyph(B.Canvas, GX, GY, FGlyph, NumGlyphs, GlyphNum);
           Inc(CR.Left, FGlyph.Width div NumGlyphs + FSpacing);
         end;
       BSDrawText2(B.Canvas, Caption, CR);
     end;

  if FShowCloseButton then DrawButton(B.Canvas, 0);
  if FShowRollButton then DrawButton(B.Canvas, 1);
end;

procedure TbsSkinExPanel.AdjustClientRect(var Rect: TRect);
begin
  inherited AdjustClientRect(Rect);
  if (FIndex <> -1) and not (csDesigning in ComponentState)
  then
    Rect := NewClRect
  else
    begin
      Rect.Top := Rect.Top + FDefaultCaptionHeight;
      Inc(Rect.Left, 1);
      Dec(Rect.Right, 1);
      Dec(Rect.Bottom, 1);
    end;
end;

procedure TbsSkinExPanel.ShowControls;
var
  i: Integer;
begin
  for i := 0 to ControlCount - 1 do
    Controls[i].Visible := True;
  EnableAlign;
end;

procedure TbsSkinExPanel.HideControls;
var
  i: Integer;
begin
  DisableAlign;
  for i := 0 to ControlCount - 1 do
    Controls[i].Visible := False;
end;

procedure TbsSkinExPanel.SetRollState;
begin
  if FRollState = Value then Exit;
  FRollState := Value;
  StopCheckSize := True;
  if FRollState
  then
    begin
      FForceBackground := False;
      //
      FCMaxWidth := Constraints.MaxWidth;
      FCMinWidth := Constraints.MinWidth;
      FCMaxHeight := Constraints.MaxHeight;
      FCMinHeight := Constraints.MinHeight;
      Constraints.MaxWidth := 0;
      Constraints.MaxHeight := 0;
      Constraints.MinHeight := 0;
      Constraints.MinWidth := 0;
      //
      HideControls;
      case FRollKind of
        rkRollVertical:
          if FRealHeight = 0 then
          begin
            FRealHeight := Height;
            Height := GetRollHeight;
          end;
        rkRollHorizontal:
          if FRealWidth = 0 then
          begin
            FRealWidth := Width;
            Width := GetRollWidth;
          end;
      end;
    end
  else
    begin
      FForceBackground := True;
      //
      Constraints.MaxWidth := FCMaxWidth;
      Constraints.MinWidth := FCMinWidth;
      Constraints.MaxHeight := FCMaxHeight;
      Constraints.MinHeight := FCMinHeight;
      //
      case FRollKind of
        rkRollVertical:
          begin
            Height := FRealHeight;
            FRealHeight := 0;
          end;
        rkRollHorizontal:
          begin
            Width := FRealWidth;
            FRealWidth := 0;
          end;
      end;
      ShowControls;
    end;
  StopCheckSize := False;
  if not (csDesigning in ComponentState) and
    Assigned(FOnChangeRollState)
  then
    FOnChangeRollState(Self);
end;


procedure TbsSkinExPanel.CMMouseEnter;
begin
  inherited;
  if (csDesigning in ComponentState) then Exit;
  TestActive(-1, -1);
end;

procedure TbsSkinExPanel.CMMouseLeave;
var
  i: Integer;
begin
  inherited;
  if (csDesigning in ComponentState) then Exit;
  for i := 0 to 1 do
    if Buttons[i].MouseIn
    then
       begin
         Buttons[i].MouseIn := False;
         DrawButton(Canvas, i);
       end;
end;

procedure TbsSkinExPanel.MouseDown;
begin
  TestActive(X, Y);
  if ActiveButton <> -1
  then
    begin
      CaptureButton := ActiveButton;
      ButtonDown(ActiveButton, X, Y);
    end;
  inherited;
end;

procedure TbsSkinExPanel.MouseUp;
begin
  inherited;
  if CaptureButton <> -1
  then ButtonUp(CaptureButton, X, Y);
  CaptureButton := -1;
end;

procedure TbsSkinExPanel.MouseMove;
begin
  inherited;
  TestActive(X, Y);
end;

procedure TbsSkinExPanel.TestActive(X, Y: Integer);
var
  i, j: Integer;
  i1, i2: Integer;
begin
  if FShowCloseButton then i1 := 0 else i1 := 1;
  if FShowRollButton then i2 := 1 else i2 := 0;

  if i1 > i2 then Exit;

  j := -1;
  OldActiveButton := ActiveButton;

  for i := i1 to i2 do
  begin
    if PtInRect(Buttons[i].R, Point(X, Y))
    then
      begin
        j := i;
        Break;
      end;
  end;

  ActiveButton := j;

  if (CaptureButton <> -1) and
     (ActiveButton <> CaptureButton) and (ActiveButton <> -1)
  then
    ActiveButton := -1;

  if (OldActiveButton <> ActiveButton)
  then
    begin
      if OldActiveButton <> - 1
      then
        ButtonLeave(OldActiveButton);

      if ActiveButton <> -1
              then
        ButtonEnter(ActiveButton);
    end;
end;

procedure TbsSkinExPanel.ButtonDown;
begin
  Buttons[i].MouseIn := True;
  Buttons[i].Down := True;
  DrawButton(Canvas, i);
end;

procedure TbsSkinExPanel.ButtonUp;
begin
  Buttons[i].Down := False;
  if ActiveButton <> i then Buttons[i].MouseIn := False;
  DrawButton(Canvas, i);
  if Buttons[i].MouseIn
  then
  case i of
    0:  Close;
    1:
        begin
          RollState := not RollState;
          TestActive(X, Y);
          RePaint;
        end;
  end;
end;

procedure TbsSkinExPanel.ButtonEnter(I: Integer);
begin
  Buttons[i].MouseIn := True;
  DrawButton(Canvas, i);
end;

procedure TbsSkinExPanel.ButtonLeave(I: Integer);
begin
  Buttons[i].MouseIn := False;
  DrawButton(Canvas, i);
end;

procedure TbsSkinExPanel.DrawButton;
var
  C: TColor;
  R1: TRect;
  SR, AR, DR: TRect;
begin
  if FIndex = -1
  then
    begin
    with Buttons[i] do
    if not IsNullRect(R) then
    begin
      R1 := R;
      Cnvs.Brush.Color := clBtnface;
      Cnvs.FillRect(R);
      if Down and MouseIn
      then
        begin
          Frame3D(Cnvs, R1, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
          Cnvs.Brush.Color := BS_XP_BTNDOWNCOLOR;
          Cnvs.FillRect(R1);
        end
      else
        if MouseIn
        then
          begin
            Frame3D(Cnvs, R1, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
            Cnvs.Brush.Color := BS_XP_BTNACTIVECOLOR;
            Cnvs.FillRect(R1);
          end
        else
          begin
            Cnvs.Brush.Color := clBtnFace;
            Cnvs.FillRect(R1);
          end;
      C := clBlack;
      R1 := R;
      if Down and MouseIn
      then
        begin
          Inc(R1.Left, 2);
          Inc(R1.Top, 2);
        end;
      case i of
        1:
          if FRollKind = rkRollVertical
          then
            begin
              if FRollState
              then
                DrawArrowImage(Cnvs, R1, C, 4)
              else
                DrawArrowImage(Cnvs, R1, C, 3);
            end
          else
            begin
              if FRollState
              then
                DrawArrowImage(Cnvs, R1, C, 2)
              else
                DrawArrowImage(Cnvs, R1, C, 1);
            end;
        0: DrawRCloseImage(Cnvs, R1, C);
      end;
    end
    end
  else
  if not IsNullRect(Buttons[i].R)
  then 
    with Buttons[i] do
    begin
      if i = 0
      then
        begin
          SR := CloseButtonRect;
          AR := CloseButtonActiveRect;
          DR := CloseButtonDownRect;
        end
      else
        if not FRollState
        then
          begin
            case RollKind of
              rkRollHorizontal:
                begin
                  SR := HRollButtonRect;
                  AR := HRollButtonActiveRect;
                  DR := HRollButtonDownRect;
                end;
              rkRollVertical:
                begin
                  SR := VRollButtonRect;
                  AR := VRollButtonActiveRect;
                  DR := VRollButtonDownRect;
                end;
            end;
          end
        else
          begin
            case RollKind of
              rkRollHorizontal:
                begin
                  SR := HRestoreButtonRect;
                  AR := HRestoreButtonActiveRect;
                  DR := HRestoreButtonDownRect;
                end;
              rkRollVertical:
                begin
                  SR := VRestoreButtonRect;
                  AR := VRestoreButtonActiveRect;
                  DR := VRestoreButtonDownRect;
                end;
            end;
          end;

      if Down and MouseIn
      then
        Cnvs.CopyRect(R, Picture.Canvas, DR)
      else
      if MouseIn
      then
        Cnvs.CopyRect(R, Picture.Canvas, AR)
      else
        Cnvs.CopyRect(R, Picture.Canvas, SR);
   end;
end;

constructor TbsSkinHeaderControl.Create(AOwner: TComponent);
begin
  inherited;
  FDefaultHeight := 0;
  FOldActiveSection := -1;
  FActiveSection := -1;
  FIndex := -1;
  FDefaultFont := TFont.Create;
  with FDefaultFont do
  begin
    Name := 'ËÎÌו';
    Charset := GB2312_CHARSET;
    Style := [];
    Height := -12;
  end;
  FSkinDataName := 'resizebutton';
  FUseSkinFont := False;
  FDownInDivider := False;
  InDivider := False;
  FDown := False;
end;

destructor TbsSkinHeaderControl.Destroy;
begin
  FDefaultFont.Free;
  inherited;
end;

procedure TbsSkinHeaderControl.SetBounds;
var
  UpDate: Boolean;
begin
  GetSkinData;
  UpDate := Height <> AHeight;
  if UpDate
  then
    begin
      if (FIndex <> -1) and (LBPt.X = 0) and (LBPt.Y = 0)
      then
        AHeight := RectHeight(SkinRect)
      else
      if (FIndex = -1) and (FDefaultHeight <> 0)
      then
        AHeight := FDefaultHeight;
    end;
  inherited;
end;

procedure TbsSkinHeaderControl.SetDefaultHeight;
begin
  FDefaultHeight := Value;
  if (FIndex = -1) and (FDefaultHeight > 0) then Height := FDefaultHeight;
end;

procedure TbsSkinHeaderControl.Notification;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FSD) then FSD := nil;
end;

procedure TbsSkinHeaderControl.GetSkinData;
begin
  if (FSD = nil) or FSD.Empty
  then
    FIndex := -1
  else
    FIndex := FSD.GetControlIndex(FSkinDataName);
  if FIndex <> -1
  then
    if TbsDataSkinControl(FSD.CtrlList.Items[FIndex]) is TbsDataSkinButtonControl
    then
      with TbsDataSkinButtonControl(FSD.CtrlList.Items[FIndex]) do
      begin
        LTPt := LTPoint;
        RTPt := RTPoint;
        LBPt := LBPoint;
        RBPt := RBPoint;
        Self.SkinRect := SkinRect;
        Self.ClRect := ClRect;
        Self.StretchEffect := StretchEffect;
        Self.LeftStretch := LeftStretch;
        Self.TopStretch := TopStretch; 
        Self.RightStretch := RightStretch;
        Self.BottomStretch := BottomStretch;
        if (PictureIndex <> -1) and (PictureIndex < FSD.FActivePictures.Count)
        then
          Picture := TBitMap(FSD.FActivePictures.Items[PictureIndex])
        else
          Picture := nil;
        //
        Self.FontName := FontName;
        Self.FontColor := FontColor;
        Self.ActiveFontColor := ActiveFontColor;
        Self.DownFontColor := DownFontColor;
        Self.FontStyle := FontStyle;
        Self.FontHeight := FontHeight;
        Self.ActiveSkinRect := ActiveSkinRect;
        Self.DownSkinRect := DownSkinRect;
        if IsNullRect(ActiveSkinRect) then Self.ActiveSkinRect := SkinRect;
        if IsNullRect(DownSkinRect) then Self.DownSkinRect := Self.ActiveSkinRect;
      end
    else
      Picture := nil;
end;

procedure TbsSkinHeaderControl.ChangeSkinData;
begin
  GetSkinData;
  if (FIndex <> -1) and (LBPt.X = 0) and (LBPt.Y = 0)
  then
    Height := RectHeight(SkinRect)
  else
    if (FIndex = -1) and (FDefaultHeight <> 0)
    then
      Height := FDefaultHeight;
  RePaint;
end;

procedure TbsSkinHeaderControl.SetDefaultFont;
begin
  FDefaultFont.Assign(Value);
  if FIndex =  -1 then Font.Assign(Value);
end;

procedure TbsSkinHeaderControl.SetSkinData;
begin
  FSD := Value;
  if (FSD <> nil) then
  if not FSD.Empty and not (csDesigning in ComponentState)
  then
    ChangeSkinData;
end;

function TbsSkinHeaderControl.GetSkinItemRect;
var
  SectionOrder: array of Integer;
  R: TRect;
begin
  if Self.DragReorder
  then
    begin
      SetLength(SectionOrder, Sections.Count);
      Header_GetOrderArray(Handle, Sections.Count, PInteger(SectionOrder));
      Header_GETITEMRECT(Handle, SectionOrder[Index] , @R);
    end
  else
    Header_GETITEMRECT(Handle, Index, @R);
  Result := R;
end;

procedure TbsSkinHeaderControl.DrawSkinSectionR;
var
  BR, SR, TR: TRect;
  S: String;
  B: TBitMap;
  W, H, TX, TY, GX, GY, XO, YO, TXO, TYO: Integer;
begin
  GetSkinData;
  if (RectWidth(R) <= 0) or (RectHeight(R) <= 0) then Exit;
  S := Section.Text;
  B := TBitMap.Create;
  W := RectWidth(R);
  if (LBPt.X = 0) and (LBPt.Y = 0) and (FIndex <> -1)
  then
    H := RectHeight(SkinRect)
  else
    H := RectHeight(R);
  B.Width := W;
  B.Height := H;
  BR := Rect(0, 0, B.Width, B.Height);
  if FIndex = -1
  then
    with B.Canvas do
    begin
      //
      if Pressed
      then
        begin
          Frame3D(B.Canvas, BR, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
          Brush.Color := BS_XP_BTNDOWNCOLOR;
        end
      else
      if Active
      then
        begin
          Frame3D(B.Canvas, BR, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
          Brush.Color := BS_XP_BTNACTIVECOLOR;
        end
      else
        begin
          Frame3D(B.Canvas, BR, clBtnShadow, clBtnShadow, 1);
          Brush.Color := clBtnFace;
        end;
      //
      FillRect(BR);
      Font := FDefaultFont;
      if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
      then
        Font.Charset := SkinData.ResourceStrData.CharSet
      else
        Font.CharSet := FDefaultFont.Charset;
    end
  else
    with B.Canvas do
    begin
      if FUseSkinFont
      then
        with Font do
        begin
          Name := FontName;
          Height := FontHeight;
          Style := FontStyle;
        end
      else
        Font := FDefaultFont;

      if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
      then
        Font.Charset := SkinData.ResourceStrData.CharSet
      else
        Font.CharSet := FDefaultFont.Charset;

      if Pressed
      then
        begin
          SR := DownSkinRect;
          Font.Color := DownFontColor;
        end
      else
      if Active
      then
        begin
          SR := ActiveSkinRect;
          Font.Color := ActiveFontColor;
        end
      else
        begin
          SR := SkinRect;
          Font.Color := FontColor;
        end;
      //
      XO := RectWidth(BR) - RectWidth(SkinRect);
      if (LBPt.X = 0) and (LBPt.Y = 0)
      then
        begin
          CreateHSkinImage(LTPt.X, RectWidth(SkinRect) - RTPt.X,
          B, Picture, SR, B.Width, B.Height, StretchEffect);
        end
      else
        begin
          YO := RectHeight(BR) - RectHeight(SkinRect);
          NewLTPoint := LTPt;
          NewRTPoint := Point(RTPt.X + XO, RTPt.Y);
          NewLBPoint := Point(LBPt.X, LBPt.Y + YO);
          NewRBPoint := Point(RBPt.X + XO, RBPt.Y + YO);
          NewClRect := Rect(CLRect.Left, ClRect.Top,
          CLRect.Right + XO, ClRect.Bottom + YO);
          //
          CreateSkinImage(LTPt, RTPt, LBPt, RBPt, CLRect,
            NewLtPoint, NewRTPoint, NewLBPoint, NewRBPoint, NewCLRect,
            B, Picture, SR, B.Width, B.Height, True,
            LeftStretch, TopStretch, RightStretch, BottomStretch,
            StretchEffect);
        end;
    end;

  if FIndex = -1
  then
    TR := Rect(2, 2, B.Width - 2, B.Height - 2)
  else
    begin
      TXO := RectWidth(SkinRect) - ClRect.Right;
      TYO := RectHeight(SkinRect) - ClRect.Bottom;
      TR := Rect(ClRect.Left, ClRect.Top, B.Width - TXO, B.Height - TYO);
    end;

  if Assigned(FOnDrawSkinSection)
  then
    begin
      FOnDrawSkinSection(Self, Section, TR, Active, Pressed, B.Canvas)
    end
  else
    with B.Canvas do
    begin
      Brush.Style := bsClear;
      Inc(BR.Left, 5); Dec(BR.Right, 5);
      if (Images <> nil) and (Section.ImageIndex >= 0) and
      (Section.ImageIndex < Images.Count)
        then
          begin
           CorrectTextbyWidth(B.Canvas, S, RectWidth(TR) - 10 - Images.Width);
           GX := TR.Left;
           if S = Section.Text then
           case Section.Alignment of
             taRightJustify: GX := TR.Right - TextWidth(S) - Images.Width - 10;
             taCenter: GX := TR.Left + RectWidth(TR) div 2 -
                          (TextWidth(S) + Images.Width + 10) div 2;
           end;
           TX := GX + Images.Width + 10;
           TY := TR.Top + RectHeight(TR) div 2 - TextHeight(S) div 2;
           GY := TR.Top + RectHeight(TR) div 2 - Images.Height div 2;
           Images.Draw(B.Canvas, GX, GY, Section.ImageIndex, True);
         end
       else
         begin
           CorrectTextbyWidth(B.Canvas, S, RectWidth(TR));
           TX := TR.Left;
           case Section.Alignment of
             taRightJustify: TX := TR.Right - TextWidth(S) - 10;
             taCenter: TX := TR.Left + RectWidth(TR) div 2 - TextWidth(S) div 2;
           end;
           TY := TR.Top + RectHeight(TR) div 2 - TextHeight(S) div 2;
         end;
      TextRect(TR, TX, TY, S);
    end;
  Cnvs.Draw(R.Left, R.Top, B);
  B.Free;
end;

function TbsSkinHeaderControl.DrawSkinSection;
var
  R: TRect;
begin
  R := GetSkinItemRect(Index);
  Result := R;
  DrawSkinSectionR(Cnvs, Sections[Index], Active, Pressed, R);
end;

procedure TbsSkinHeaderControl.PaintWindow(DC: HDC);
var
  i, SaveIndex: Integer;
  RightOffset, XO, YO: Integer;
  R1, BGR: TRect;
  B: TBitMap;
begin
  GetSkinData;
  if not HandleAllocated or (Handle = 0) then Exit;
  if (Width <= 0) or (Height <=0) then Exit;
  SaveIndex := SaveDC(DC);
  try
    Canvas.Handle := DC;
    RightOffset := 0;
    for I := 0 to Sections.Count - 1 do
    begin
      R1 := DrawSkinSection(Canvas, I, (I = FActiveSection) and not FDown,
       (I = FActiveSection) and FDown);
      if RightOffset < R1.Right then RightOffset := R1.Right;
    end;
    BGR := Rect(RightOffset, 0, Width + 1, Height);
    if BGR.Left < BGR.Right then
    if FIndex = -1
    then
      with Canvas do
      begin
        Brush.Color := clBtnFace;
        Fillrect(BGR);
        Frame3D(Canvas, BGR, clBtnShadow, clBtnShadow, 1);
      end
    else
      begin
        //
        B := TBitMap.Create;
        B.Width := RectWidth(BGR);
        if (LBPt.X = 0) and (LBPt.Y = 0)
        then
          B.Height := RectHeight(SkinRect)
        else
          B.Height := RectHeight(BGR);

        XO := RectWidth(BGR) - RectWidth(SkinRect);

        if (LBPt.X = 0) and (LBPt.Y = 0)
        then
          begin
            CreateHSkinImage2(LTPt.X, RectWidth(SkinRect) - RTPt.X,
            B, Picture, SkinRect, B.Width, B.Height, StretchEffect);
          end
        else
          begin
            YO := RectHeight(BGR) - RectHeight(SkinRect);
            NewLTPoint := LTPt;
            NewRTPoint := Point(RTPt.X + XO, RTPt.Y);
            NewLBPoint := Point(LBPt.X, LBPt.Y + YO);
            NewRBPoint := Point(RBPt.X + XO, RBPt.Y + YO);
            NewClRect := Rect(CLRect.Left, ClRect.Top,
            CLRect.Right + XO, ClRect.Bottom + YO);
            //
            CreateSkinImage2(LTPt, RTPt, LBPt, RBPt, CLRect,
              NewLtPoint, NewRTPoint, NewLBPoint, NewRBPoint, NewCLRect,
              B, Picture, SkinRect, B.Width, B.Height, True,
              LeftStretch, TopStretch, RightStretch, BottomStretch,
              StretchEffect);
          end;
        Canvas.Draw(BGR.Left, BGR.Top, B);
        B.Free;  
      end;
    Canvas.Handle := 0;
  finally
    RestoreDC(DC, SaveIndex);
  end;
end;

procedure TbsSkinHeaderControl.WMPaint;
begin
  PaintHandler(Msg);
end;

procedure TbsSkinHeaderControl.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  Message.Result := 1;
end;

procedure TbsSkinHeaderControl.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
end;

procedure TbsSkinHeaderControl.TestActive(X, Y: Integer);
var
  i: Integer;
  R: TRect;
begin
  FOldActiveSection := FActiveSection;

  FActiveSection := -1;
  for i := 0 to Sections.Count - 1 do
  begin
    R := GetSkinItemRect(i);
    if PtInRect(R, Point(X, Y))
    then
      begin
        FActiveSection := i;
        Break;
      end;
  end;

  if (FOldActiveSection <> FActiveSection)
  then
    begin
      if (FOldActiveSection <> - 1) and not FInTracking
      then
        DrawSkinSection(Canvas, FOldActiveSection, False, False);
      if (FActiveSection <> -1) and not FInTracking
      then
        DrawSkinSection(Canvas, FActiveSection, True, False);
    end;
end;

procedure TbsSkinHeaderControl.MouseMove;
begin
 inherited;
 if FDown and DragReOrder then FInTracking := True else FInTracking := False;
 if not (csDesigning in ComponentState) and not FInTracking
 then
   TestActive(X, Y);
  if FDownInDivider then Invalidate;
end;

procedure TbsSkinHeaderControl.MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer);
begin
  if (Button = mbLeft) and not InDivider and (Style = hsButtons)
  then
    begin
      FDown := True;
      Invalidate;
    end;

  if (Button = mbLeft) and InDivider
  then FDownInDivider := True
  else FDownInDivider := False;

  inherited;
end;

procedure TbsSkinHeaderControl.MouseUp;
var
  FTempTracking: Boolean;
begin
  inherited;
  FTempTracking := FInTracking;
  FDownInDivider := False;
  FInTracking := False;
  FActiveSection := -1;
  FOldActiveSection := -1;
  if (Button = mbLeft) and not (csDesigning in ComponentState) and (Style = hsButtons)
  then
    begin
      TestActive(X, Y);
      Invalidate;
      FDown := False;
      if (FActiveSection <> -1) and not InDivider and not FTempTracking and
         Assigned(FOnSkinSectionClick)
      then
        FOnSkinSectionClick(Self, Sections[FActiveSection]);
    end;
end;

procedure TbsSkinHeaderControl.CMMouseEnter;
begin
  if (csDesigning in ComponentState) then Exit;
  if not FDown then Invalidate;
end;

procedure TbsSkinHeaderControl.CMMouseLeave;
begin
  if (csDesigning in ComponentState) then Exit;
  FActiveSection := -1;
  FOldActiveSection := -1;
  if not FDown then Invalidate;
end;

procedure TbsSkinHeaderControl.WndProc;
begin
  inherited;
  case Message.Msg of
     HDM_HITTEST:
        begin
          if PHDHitTestInfo(Message.LParam)^.Flags = HHT_ONDIVIDER
          then
            InDivider := True
          else
            InDivider := False;
        end;
    end;
end;

procedure TbsSkinHeaderControl.CreateWnd;
var
  i: Integer;
begin
  inherited;
  for i := 0 to Sections.Count - 1 do Sections[i].Style := hsOwnerDraw;
end;

procedure TbsSkinHeaderControl.DrawSection(Section: THeaderSection; const Rect: TRect;
                                           Pressed: Boolean);
var
  SectionOrder: array of Integer;
  i, Index: Integer;
begin
  if Self.DragReorder
  then
    begin
      SetLength(SectionOrder, Sections.Count);
      Header_GetOrderArray(Handle, Sections.Count, PInteger(SectionOrder));
      for i := 0 to Sections.Count - 1 do
       if SectionOrder[i] = Section.Index then Break;
      Index := i;
    end
  else
    Index := Section.Index;

  Self.DrawSkinSectionR(Canvas, Sections[Index], False, Pressed, Rect);
end;

constructor TbsSkinLinkImage.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  AutoSize := True;
  Cursor := crHandPoint;
end;

procedure TbsSkinLinkImage.Click;
begin
  inherited Click;
  ShellExecute(0, 'open', PChar(FURL), nil, nil, SW_SHOWNORMAL);
end;

constructor TbsSkinLinkLabel.Create;
begin
  inherited;
  FUseUnderLine := True;
  FIndex := -1;
  Transparent := True;
  FSD := nil;
  FSkinDataName := 'stdlabel';
  FDefaultFont := TFont.Create;
  with FDefaultFont do
  begin
    Name := 'ËÎÌו';
    Charset := GB2312_CHARSET;
    Height := -12;
    Style := [fsUnderLine];
  end;
  Font.Assign(FDefaultFont);
  Cursor := crHandPoint;
  FUseSkinFont := False;
  FDefaultActiveFontColor := clBlue;
  FURL := '';
end;

destructor TbsSkinLinkLabel.Destroy;
begin
  FDefaultFont.Free;
  inherited;
end;

procedure TbsSkinLinkLabel.SetUseUnderLine;
begin
  if FUseUnderLine <> Value
  then
    begin
      FUseUnderLine := Value;
      RePaint;
    end;
end;

procedure TbsSkinLinkLabel.DoDrawText(var Rect: TRect; Flags: Longint);
var
  Text: string;
begin
  GetSkinData;

  Text := GetLabelText;
  if (Flags and DT_CALCRECT <> 0) and ((Text = '') or ShowAccelChar and
    (Text[1] = '&') and (Text[2] = #0)) then Text := Text + ' ';
  if not ShowAccelChar then Flags := Flags or DT_NOPREFIX;
  Flags := DrawTextBiDiModeFlags(Flags);

  if FIndex <> -1
  then
    with Canvas.Font do
    begin
      if FUseSkinFont
      then
        begin
          Name := FontName;
          Style := FontStyle;
          Height := FontHeight;
          if FUseUnderLine
          then
            Style := Style + [fsUnderLine]
          else
            Style := Style - [fsUnderLine];
        end
      else
        begin
          Canvas.Font := Self.Font;
          if FUseUnderLine
          then
            Style := Style + [fsUnderLine]
          else
            Style := Style - [fsUnderLine];
        end;  
      if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
      then
        Charset := SkinData.ResourceStrData.CharSet
      else
        CharSet := FDefaultFont.Charset;
      if FMouseIn
      then
        Color := ActiveFontColor
      else
        Color := FontColor;
    end
  else
    begin
      if FUseSkinFont
      then
        Canvas.Font := DefaultFont
      else
        Canvas.Font := Self.Font;

      if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
      then
        Canvas.Font.Charset := SkinData.ResourceStrData.CharSet
      else
        Canvas.Font.CharSet := FDefaultFont.Charset;

      if FMouseIn then Canvas.Font.Color := FDefaultActiveFontColor;
      Canvas.Font.Style := Canvas.Font.Style + [fsUnderLine];
    end;

  if not Enabled then
  begin
    OffsetRect(Rect, 1, 1);
    if FIndex <> -1
    then
      Canvas.Font.Color := FSD.SkinColors.cBtnHighLight
    else
      Canvas.Font.Color := clBtnHighlight;
    DrawText(Canvas.Handle, PChar(Text), Length(Text), Rect, Flags);
    OffsetRect(Rect, -1, -1);
    if FIndex <> -1
    then
      Canvas.Font.Color := FSD.SkinColors.cBtnShadow
    else
      Canvas.Font.Color := clBtnShadow;
    DrawText(Canvas.Handle, PChar(Text), Length(Text), Rect, Flags);
  end
  else
    begin
      if FUseUnderLine
      then
        Canvas.Font.Style := Canvas.Font.Style + [fsUnderLine]
      else
        Canvas.Font.Style := Canvas.Font.Style - [fsUnderLine];
      DrawText(Canvas.Handle, PChar(Text), Length(Text), Rect, Flags);
    end;
end;

procedure TbsSkinLinkLabel.Click;
begin
  inherited;
  if FURL <> ''
  then
    ShellExecute(0, 'open', PChar(FURL), nil, nil, SW_SHOWNORMAL);
end;

procedure TbsSkinLinkLabel.CMMouseEnter;
begin
  inherited;
  if (csDesigning in ComponentState) then Exit;
  FMouseIn := True;
  RePaint;
end;

procedure TbsSkinLinkLabel.CMMouseLeave;
begin
  inherited;
  if (csDesigning in ComponentState) then Exit;
  FMouseIn := False;
  RePaint;
end;

procedure TbsSkinLinkLabel.SetDefaultFont;
begin
  FDefaultFont.Assign(Value);
end;

procedure TbsSkinLinkLabel.Notification;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FSD) then FSD := nil;
end;

procedure TbsSkinLinkLabel.GetSkinData;
begin
  if (FSD = nil) or FSD.Empty
  then
    FIndex := -1
  else
    FIndex := FSD.GetControlIndex(FSkinDataName);
  if (FIndex <> -1)
  then
    if TbsDataSkinControl(FSD.CtrlList.Items[FIndex]) is TbsDataSkinStdLabelControl
    then
      with TbsDataSkinStdLabelControl(FSD.CtrlList.Items[FIndex]) do
      begin
        Self.FontName := FontName;
        Self.FontColor := FontColor;
        Self.FontStyle := FontStyle;
        Self.FontHeight := FontHeight;
        Self.ActiveFontColor := ActiveFontColor;
      end
end;

procedure TbsSkinLinkLabel.ChangeSkinData;
begin
  GetSkinData;
  RePaint;
end;

procedure TbsSkinLinkLabel.SetSkinData;
begin
  FSD := Value;
  if (FSD <> nil) then ChangeSkinData;
end;

constructor TbsSkinButtonLabel.Create;
begin
  inherited;
  FIndex := -1;
  ControlStyle := ControlStyle + [csSetCaption] - [csOpaque];
  FWebStyle := False;
  FSkinDataName := 'stdlabel';
  FDefaultFont := TFont.Create;
  with FDefaultFont do
  begin
    Name := 'ËÎÌו';
    Charset := GB2312_CHARSET;
    Style := [];
    Height := -12;
  end;
  FUseSkinFont := False;
  FDefaultActiveFontColor := clBlue;
  FNumGlyphs := 1;
  FMargin := -1;
  FSpacing := 1;
  FImageIndex := -1;
  FImageList := nil;
  FLayout := blGlyphLeft;
  FGlyph := TBitMap.Create;
  Width := 100;
  Height := 50;
end;

destructor TbsSkinButtonLabel.Destroy;
begin
  FDefaultFont.Free;
  FGlyph.Free;
  inherited;
end;

procedure TbsSkinButtonLabel.SetImageIndex(Value: Integer);
begin
  if FImageIndex <> Value
  then
    begin
      FImageIndex := Value;
      RePaint;
    end;
end;

procedure TbsSkinButtonLabel.CMTextChanged;
begin
  inherited;
  RePaint;
end;

procedure TbsSkinButtonLabel.MouseDown;
begin
  FDown := True;
  RePaint;
  inherited;
end;

procedure TbsSkinButtonLabel.MouseUp;
begin
  FDown := False;
  RePaint;
  inherited;
end;

procedure TbsSkinButtonLabel.SetGlyph;
begin
  FGlyph.Assign(Value);
  RePaint;
end;

procedure TbsSkinButtonLabel.SetNumGlyphs;
begin
  FNumGlyphs := Value;
  RePaint;
end;

procedure TbsSkinButtonLabel.SetLayout;
begin
  if FLayout <> Value
  then
    begin
      FLayout := Value;
      RePaint;
    end;
end;

procedure TbsSkinButtonLabel.SetSpacing;
begin
  if Value <> FSpacing
  then
    begin
      FSpacing := Value;
      RePaint;
    end;
end;

procedure TbsSkinButtonLabel.SetMargin;
begin
  if (Value <> FMargin) and (Value >= -1)
  then
    begin
      FMargin := Value;
      RePaint;
    end;
end;

procedure TbsSkinButtonLabel.CMMouseEnter;
begin
  inherited;
  if (csDesigning in ComponentState) then Exit;
  FMouseIn := True;
  RePaint;
end;

procedure TbsSkinButtonLabel.CMMouseLeave;
begin
  inherited;
  if (csDesigning in ComponentState) then Exit;
  FMouseIn := False;
  RePaint;
end;

procedure TbsSkinButtonLabel.SetDefaultFont;
begin
  FDefaultFont.Assign(Value);
  RePaint;
end;

procedure TbsSkinButtonLabel.Notification;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FSD) then FSD := nil;
  if (Operation = opRemove) and (AComponent = FImageList)
  then FImageList := nil;
end;

procedure TbsSkinButtonLabel.ChangeSkinData;
begin
  if (FSD = nil) or FSD.Empty
  then
    FIndex := -1
  else
    FIndex := FSD.GetControlIndex(FSkinDataName);

  if (FIndex <> -1)
  then
    begin
      if TbsDataSkinControl(FSD.CtrlList.Items[FIndex]) is TbsDataSkinStdLabelControl
      then
        with TbsDataSkinStdLabelControl(FSD.CtrlList.Items[FIndex]) do
        begin
          Self.FontName := FontName;
          Self.FontColor := FontColor;
          Self.FontHeight := FontHeight;
          Self.ActiveFontColor := ActiveFontColor;
          Self.FontStyle := FontStyle;
        end
    end;

  RePaint;
end;

procedure TbsSkinButtonLabel.SetSkinData;
begin
  FSD := Value;
  if (FSD <> nil) then ChangeSkinData;
end;

procedure TbsSkinButtonLabel.SetWebStyle(Value: Boolean);
begin
  FWebStyle := Value;
  if (csDesigning in ComponentState) then
   if Value then Cursor := crHandPoint else Cursor := crDefault;	
end;

procedure TbsSkinButtonLabel.Paint;

function GetGlyphNum: Integer;
begin
  if FDown and FMouseIn and (FNumGlyphs > 2)
  then
    Result := 3
  else
  if FMouseIn and (FNumGlyphs > 3)
  then
    Result := 4
  else
    if not Enabled and (FNumGlyphs > 1)
    then
      Result := 2
    else
      Result := 1;
end;


begin
  if FIndex <> -1
  then
    with Canvas.Font do
    begin
      if FUseSkinFont
      then
        begin
          Name := FontName;
          Height := FontHeight;
          Style := FontStyle;
        end
      else
        Canvas.Font := FDefaultFont;

      if FMouseIn
      then
        Color := ActiveFontColor
      else
        Color := FontColor;
    end
  else
    begin
      Canvas.Font := FDefaultFont;
      if FMouseIn
      then
        Canvas.Font.Color := FDefaultActiveFontColor;
   end;

  if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
  then
    Canvas.Font.Charset := SkinData.ResourceStrData.CharSet
  else
    Canvas.Font.CharSet := FDefaultFont.Charset;

  if FWebStyle
  then
    if FMouseIn
    then Canvas.Font.Style := Canvas.Font.Style + [fsUnderLine]
    else Canvas.Font.Style := Canvas.Font.Style - [fsUnderLine];


  if (FImageList <> nil) and (FImageIndex >= 0) and
     (FImageIndex < FImageList.Count)
  then
    begin
      DrawImageAndText(Canvas, ClientRect, FMargin, FSpacing, FLayout,
        Caption, FImageIndex, FImageList,
        FDown and not FWebStyle, Enabled, False, 0);
    end
  else
  DrawGlyphAndText(Canvas,
    ClientRect, FMargin, FSpacing, FLayout,
    Caption, FGlyph, FNumGlyphs, GetGlyphNum, FDown and not FWebStyle, False, 0);
end;

// ======================== TbsSkinCustomSlider ======================= //

constructor TbsSkinCustomSlider.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlState := ControlState + [csCreating];
  ControlStyle := [csClickEvents, csCaptureMouse, csAcceptsControls,
    csDoubleClicks, csOpaque];
  TabStop := True;  
  Width := 150;
  Height := 40;
  FNumThumbStates := 2;
  FBevelWidth := 1;
  FOrientation := soHorizontal;
  FOptions := [soShowFocus, soShowPoints, soSmooth];
  FEdgeSize := 2;
  FMinValue := 0;
  FMaxValue := 100;
  FIncrement := 10;
  CreateElements;
  FSkinDataName := 'slider';
  Picture := nil;
  FUseSkinThumb := True;
  ControlState := ControlState - [csCreating];
end;

destructor TbsSkinCustomSlider.Destroy;
var
  I: TbsSliderImage;
begin
  FOnChange := nil;
  FOnChanged := nil;
  FOnDrawPoints := nil;
  FRuler.Free;
  for I := Low(FImages) to High(FImages) do begin
    FImages[I].OnChange := nil;
    FImages[I].Free;
  end;
  inherited Destroy;
end;

procedure TbsSkinCustomSlider.GetSkinData;
begin
  inherited;
  if FIndex <> -1
  then
    if TbsDataSkinControl(FSD.CtrlList.Items[FIndex]) is TbsDataSkinSlider
    then
      with TbsDataSkinSlider(FSD.CtrlList.Items[FIndex]) do
      begin
        if (PictureIndex <> -1) and (PictureIndex < FSD.FActivePictures.Count)
        then
          Picture := TBitMap(FSD.FActivePictures.Items[PictureIndex])
        else
          Picture := nil;
        Self.HRulerRect := HRulerRect;
        Self.HThumbRect := HThumbRect;
        Self.VRulerRect := VRulerRect;
        Self.VThumbRect := VThumbRect;
        Self.SkinEdgeSize := EdgeSize;
        Self.BGColor := BGColor;
        Self.PointsColor := PointsColor;
      end;
end;

procedure TbsSkinCustomSlider.ChangeSkinData;
begin
  AdjustElements;
end;

procedure TbsSkinCustomSlider.WMMOVE(var Msg: TWMMOVE);
begin
  inherited;
  if FTransparent then Invalidate;
end;

procedure TbsSkinCustomSlider.SetTransparent(Value: Boolean);
begin
  FTransparent := Value;
  Invalidate;
end;

procedure TbsSkinCustomSlider.Loaded;
var
  I: TbsSliderImage;
begin
  inherited Loaded;
  for I := Low(FImages) to High(FImages) do
    if I in FUserImages then SetImage(Ord(I), FImages[I]);
end;

procedure TbsSkinCustomSlider.AlignControls(AControl: TControl; var Rect: TRect);
begin
  inherited AlignControls(AControl, Rect);
end;

procedure TbsSkinCustomSlider.WMPaint(var Message: TWMPaint);
var
  DC, MemDC: HDC;
  MemBitmap, OldBitmap: HBITMAP;
  PS: TPaintStruct;
begin
  if FPaintBuffered then inherited
  else begin
    Canvas.Lock;
    try
      MemDC := GetDC(0);
      MemBitmap := CreateCompatibleBitmap(MemDC, ClientWidth, ClientHeight);
      ReleaseDC(0, MemDC);
      MemDC := CreateCompatibleDC(0);
      OldBitmap := SelectObject(MemDC, MemBitmap);
      try
        DC := Message.DC;
        Perform(WM_ERASEBKGND, MemDC, MemDC);
        FPaintBuffered := True;
        Message.DC := MemDC;
        try
          WMPaint(Message);
        finally
          Message.DC := DC;
          FPaintBuffered := False;
        end;
        if DC = 0 then DC := BeginPaint(Handle, PS);
        BitBlt(DC, 0, 0, ClientWidth, ClientHeight, MemDC, 0, 0, SRCCOPY);
        if Message.DC = 0 then EndPaint(Handle, PS);
      finally
        SelectObject(MemDC, OldBitmap);
        DeleteDC(MemDC);
        DeleteObject(MemBitmap);
      end;
    finally
      Canvas.Unlock;
    end;
  end;
end;

procedure TbsSkinCustomSlider.Paint;
var
  R: TRect;
  HighlightThumb: Boolean;
  P: TPoint;
  Offset: Integer;
  Buffer: TBitMap;
begin
  GetSkinData;
  if csPaintCopy in ControlState then begin
    Offset := GetOffsetByValue(GetSliderValue);
    P := GetThumbPosition(Offset);
  end else
  P := Point(FThumbRect.Left, FThumbRect.Top);
  R := GetClientRect;

  if FTransparent
  then
    begin
      Buffer := TBitMap.Create;
      Buffer.Width := Width;
      Buffer.Height := Height;
      GetParentImage(Self, Buffer.Canvas);
      Canvas.Draw(0, 0, Buffer);
      Buffer.Free;
    end
  else
    with Canvas do begin
      if FIndex = -1
      then
        Brush.Color := Color
      else
        Brush.Color := BGColor;
      FillRect(R);
    end;

  if FRuler.Width > 0 then begin
    if (soRulerOpaque in Options) and (FIndex = -1)
    then FRuler.Transparent := False else FRuler.Transparent := True;
    Canvas.Draw(FRulerOrg.X, FRulerOrg.Y, FRuler);
  end;

  if (soShowFocus in Options) and FFocused and
    not (csDesigning in ComponentState) then
  begin
    R := SliderRect;
    InflateRect(R, -2, -2);
    Canvas.DrawFocusRect(R);
  end;

  if (soShowPoints in Options) then begin
    if Assigned(FOnDrawPoints) then FOnDrawPoints(Self)
    else InternalDrawPoints(Canvas, Increment, 3, 5);
  end;

  if csPaintCopy in ControlState then
    HighlightThumb := not Enabled else
  HighlightThumb := FThumbDown or not Enabled;

  if (FIndex = -1) or not FUseSkinThumb
  then
    DrawThumb(Canvas, P, HighlightThumb)
  else
    DrawSkinThumb(Canvas, P, HighlightThumb);
end;

function TbsSkinCustomSlider.CanModify: Boolean;
begin
  Result := True;
end;

function TbsSkinCustomSlider.GetSliderValue: Longint;
begin
  Result := FValue;
end;

function TbsSkinCustomSlider.GetSliderRect: TRect;
begin
  Result := Bounds(0, 0, Width, Height);
end;

procedure TbsSkinCustomSlider.DrawSkinThumb;
var
  Buffer: TBitMap;
  R: TRect;
begin
  if Orientation = soHorizontal
  then R := HThumbRect
  else R := VThumbRect;

  if Highlight
  then R.Left := R.Left + (R.Right - R.Left) div 2
  else R.Right := R.Left + (R.Right - R.Left) div 2;

  Buffer := TBitMap.Create;
  Buffer.Width := RectWidth(R);
  Buffer.Height := RectHeight(R);
  Buffer.Canvas.CopyRect(Rect(0, 0, Buffer.Width, Buffer.Height), Picture.Canvas, R);
  Buffer.Transparent := True;
  Canvas.Draw(Origin.X, Origin.Y, Buffer);
  Buffer.Free;
end;

procedure TbsSkinCustomSlider.DrawThumb(Canvas: TCanvas; Origin: TPoint;
  Highlight: Boolean);
var
  R: TRect;
  Image: TBitmap;
  Buffer: TBitMap;
begin

  if Orientation = soHorizontal then Image := ImageHThumb
  else Image := ImageVThumb;
  R := Rect(0, 0, Image.Width, Image.Height);
  if NumThumbStates = 2 then begin
    if Highlight then R.Left := (R.Right - R.Left) div 2
    else R.Right := (R.Right - R.Left) div 2;
  end;

  Buffer := TBitMap.Create;
  Buffer.Width := RectWidth(R);
  Buffer.Height := RectHeight(R);
  Buffer.Canvas.CopyRect(Rect(0, 0, Buffer.Width, Buffer.Height), Image.Canvas, R);
  if soThumbOpaque in Options
  then Buffer.Transparent := False else Buffer.Transparent := True;
  Canvas.Draw(Origin.X, Origin.Y, Buffer);
  Buffer.Free;
end;

procedure TbsSkinCustomSlider.InternalDrawPoints(ACanvas: TCanvas; PointsStep,
  PointsHeight, ExtremePointsHeight: Longint);
const
  MinInterval = 3;
var
  RulerLength: Integer;
  Interval, Scale, PointsCnt, I, Val: Longint;
  X, H, X1, X2, Y1, Y2: Integer;
  Range: Double;
  HThumbWidth, VThumbHeight: Integer;
  NumStates: Integer;
begin

  RulerLength := GetRulerLength;
  if (FIndex = -1) or not FUseSkinThumb
  then
    begin
      HThumbWidth := FImages[siHThumb].Width;
      VThumbHeight := FImages[siVThumb].Height;
      NumStates := NumThumbStates;
    end
  else
    begin
      HThumbWidth := RectWidth(HThumbRect);
      VThumbHeight := RectHeight(VThumbRect);
      NumStates := 2;
    end;

  if (FIndex = -1)
  then
    ACanvas.Pen.Color := clWindowText
  else
    ACanvas.Pen.Color := PointsColor;

  Scale := 0;
  Range := MaxValue - MinValue;
  repeat
    Inc(Scale);
    PointsCnt := Round(Range / (Scale * PointsStep)) + 1;
    if PointsCnt > 1 then
      Interval := RulerLength div (PointsCnt - 1)
    else Interval := RulerLength;
  until (Interval >= MinInterval + 1) or (Interval >= RulerLength);
  Val := MinValue;
  for I := 1 to PointsCnt do begin
    H := PointsHeight;
    if I = PointsCnt then Val := MaxValue;
    if (Val = MaxValue) or (Val = MinValue) then H := ExtremePointsHeight;
    X := GetOffsetByValue(Val);
    if Orientation = soHorizontal then begin
      X1 := X + (HThumbWidth div NumStates) div 2;
      Y1 := FPointsRect.Top;
      X2 := X1;
      Y2 := Y1 + H;
    end
    else begin
      X1 := FPointsRect.Left;
      Y1 := X + VThumbHeight div 2;
      X2 := X1 + H;
      Y2 := Y1;
    end;
    with ACanvas do begin
      MoveTo(X1, Y1);
      LineTo(X2, Y2);
    end;
    Inc(Val, Scale * PointsStep);
  end;
end;

procedure TbsSkinCustomSlider.DefaultDrawPoints(PointsStep, PointsHeight,
  ExtremePointsHeight: Longint);
begin
  InternalDrawPoints(Canvas, PointsStep, PointsHeight, ExtremePointsHeight);
end;

procedure TbsSkinCustomSlider.CreateElements;
var
  I: TbsSliderImage;
begin
  FRuler := TBitmap.Create;
  for I := Low(FImages) to High(FImages) do SetImage(Ord(I), nil);
  AdjustElements;
end;

procedure TbsSkinCustomSlider.BuildSkinRuler(R: TRect);
var
  TmpBmp: TBitmap;
begin
  TmpBmp := TBitmap.Create;
  try
    if Orientation = soHorizontal
    then
     begin
       TmpBmp.Width := R.Right - R.Left - 2 * Indent;
       TmpBmp.Height := RectHeight(HRulerRect);
       CreateHSkinImage(SkinEdgeSize, SkinEdgeSize, TmpBmp, Picture, HRulerRect,
         TmpBmp.Width, TmpBmp.Height, False);
      end
    else
      begin
        TmpBmp.Height := R.Bottom - R.Top - 2 * Indent;
        TmpBmp.Width := RectWidth(HRulerRect);
        CreateVSkinImage(SkinEdgeSize, SkinEdgeSize, TmpBmp, Picture, VRulerRect,
          TmpBmp.Width, TmpBmp.Height, False);
      end;
    FRuler.Assign(TmpBmp);
  finally
    TmpBmp.Free;
  end;
end;

procedure TbsSkinCustomSlider.BuildRuler(R: TRect);
var
  DstR, BmpR: TRect;
  I, L, B, N, C, Offs, Len, RulerWidth: Integer;
  TmpBmp: TBitmap;
  Index: TbsSliderImage;
begin
  TmpBmp := TBitmap.Create;
  try
    if Orientation = soHorizontal then Index := siHRuler
    else Index := siVRuler;
    if Orientation = soHorizontal then begin
      L := R.Right - R.Left - 2 * Indent;
      if L < 0 then L := 0;
      TmpBmp.Width := L;
      TmpBmp.Height := FImages[Index].Height;
      L := TmpBmp.Width - 2 * FEdgeSize;
      B := FImages[Index].Width - 2 * FEdgeSize;
      RulerWidth := FImages[Index].Width;
    end
    else begin
      TmpBmp.Width := FImages[Index].Width;
      TmpBmp.Height := R.Bottom - R.Top - 2 * Indent;
      L := TmpBmp.Height - 2 * FEdgeSize;
      B := FImages[Index].Height - 2 * FEdgeSize;
      RulerWidth := FImages[Index].Height;
    end;
    N := (L div B) + 1;
    C := L mod B;
    for I := 0 to N - 1 do begin
      if I = 0 then begin
        Offs := 0;
        Len := RulerWidth - FEdgeSize;
      end
      else begin
        Offs := FEdgeSize + I * B;
        if I = N - 1 then Len := C + FEdgeSize
        else Len := B;
      end;
      if Orientation = soHorizontal then
        DstR := Rect(Offs, 0, Offs + Len, TmpBmp.Height)
      else DstR := Rect(0, Offs, TmpBmp.Width, Offs + Len);
      if I = 0 then Offs := 0
      else
        if I = N - 1 then Offs := FEdgeSize + B - C
        else Offs := FEdgeSize;
      if Orientation = soHorizontal then
        BmpR := Rect(Offs, 0, Offs + DstR.Right - DstR.Left, TmpBmp.Height)
      else
        BmpR := Rect(0, Offs, TmpBmp.Width, Offs + DstR.Bottom - DstR.Top);
      TmpBmp.Canvas.CopyRect(DstR, FImages[Index].Canvas, BmpR);
    end;
    FRuler.Assign(TmpBmp);
  finally
    TmpBmp.Free;
  end;
end;

procedure TbsSkinCustomSlider.AdjustElements;
var
  SaveValue: Longint;
  R: TRect;
  HThumbHeight, HThumbWidth,
  VThumbHeight, VThumbWidth: Integer;
  NumStates: Integer;
begin
  GetSkinData;

  SaveValue := Value;
  R := SliderRect;

  if FIndex = -1
  then
    BuildRuler(R)
  else
    BuildSkinRuler(R);

  if (FIndex = -1) or not FUseSkinThumb
  then
    begin
      HThumbHeight := FImages[siHThumb].Height;
      HThumbWidth := FImages[siHThumb].Width;
      VThumbHeight := FImages[siVThumb].Height;
      VThumbWidth := FImages[siVThumb].Width;
      NumStates := NumThumbStates;
    end
  else
    begin
      HThumbHeight := RectHeight(HThumbRect);
      HThumbWidth := RectWidth(HThumbRect);
      VThumbHeight := RectHeight(VThumbRect);
      VThumbWidth := RectWidth(VThumbRect);
      NumStates := 2;
    end;

    if Orientation = soHorizontal then begin
    if HThumbHeight > FRuler.Height then begin
      FThumbRect := Bounds(R.Left + Indent, R.Top + Indent,
        HThumbWidth div NumStates, HThumbHeight);
      FRulerOrg := Point(R.Left + Indent, R.Top + Indent +
        (HThumbHeight - FRuler.Height) div 2);
      FPointsRect := Rect(FRulerOrg.X, R.Top + Indent +
        HThumbHeight + 1,
        FRulerOrg.X + FRuler.Width, R.Bottom - R.Top - 1);
    end
    else begin
      FThumbRect := Bounds(R.Left + Indent, R.Top + Indent +
        (FRuler.Height - HThumbHeight) div 2,
        HThumbWidth div NumStates, HThumbHeight);
      FRulerOrg := Point(R.Left + Indent, R.Top + Indent);
      FPointsRect := Rect(FRulerOrg.X, R.Top + Indent + FRuler.Height + 1,
        FRulerOrg.X + FRuler.Width, R.Bottom - R.Top - 1);
    end;
  end
  else begin
    if VThumbWidth div NumThumbStates > FRuler.Width then
    begin
      FThumbRect := Bounds(R.Left + Indent, R.Top + Indent,
        VThumbWidth div NumStates, VThumbHeight);
      FRulerOrg := Point(R.Left + Indent + (VThumbWidth div NumStates -
        FRuler.Width) div 2, R.Top + Indent);
      FPointsRect := Rect(R.Left + Indent + VThumbWidth div NumStates + 1,
        FRulerOrg.Y, R.Right - R.Left - 1, FRulerOrg.Y + FRuler.Height);
    end
    else begin
      FThumbRect := Bounds(R.Left + Indent + (FRuler.Width -
        VThumbWidth div NumStates) div 2, R.Top + Indent,
        VThumbWidth div NumStates, VThumbHeight);
      FRulerOrg := Point(R.Left + Indent, R.Top + Indent);
      FPointsRect := Rect(R.Left + Indent + FRuler.Width + 1, FRulerOrg.Y,
        R.Right - R.Left - 1, FRulerOrg.Y + FRuler.Height);
    end;
  end;

  Value := SaveValue;
  Invalidate;
end;

procedure TbsSkinCustomSlider.Sized;
begin
  AdjustElements;
end;

procedure TbsSkinCustomSlider.Change;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TbsSkinCustomSlider.Changed;
begin
  if Assigned(FOnChanged) then FOnChanged(Self);
end;

procedure TbsSkinCustomSlider.RangeChanged;
begin
end;

procedure TbsSkinCustomSlider.DefineProperties(Filer: TFiler);

  function DoWrite: Boolean;
  begin
    if Assigned(Filer.Ancestor) then
      Result := FUserImages <> TbsSkinCustomSlider(Filer.Ancestor).FUserImages
    else Result := FUserImages <> [];
  end;

begin
  if Filer is TReader then inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('UserImages', ReadUserImages, WriteUserImages,
     DoWrite);
end;

procedure TbsSkinCustomSlider.ReadUserImages(Stream: TStream);
begin
  Stream.ReadBuffer(FUserImages, SizeOf(FUserImages));
end;

procedure TbsSkinCustomSlider.WriteUserImages(Stream: TStream);
begin
  Stream.WriteBuffer(FUserImages, SizeOf(FUserImages));
end;

function TbsSkinCustomSlider.StoreImage(Index: Integer): Boolean;
begin
  Result := TbsSliderImage(Index) in FUserImages;
end;

function TbsSkinCustomSlider.GetImage(Index: Integer): TBitmap;
begin
  Result := FImages[TbsSliderImage(Index)];
end;

procedure TbsSkinCustomSlider.SliderImageChanged(Sender: TObject);
begin
  if not (csCreating in ControlState) then Sized;
end;

procedure TbsSkinCustomSlider.SetImage(Index: Integer; Value: TBitmap);
var
  Idx: TbsSliderImage;
begin
  Idx := TbsSliderImage(Index);
  if FImages[Idx] = nil then begin
    FImages[Idx] := TBitmap.Create;
    FImages[Idx].OnChange := SliderImageChanged;
  end;
  if Value = nil then begin
    FImages[Idx].Handle := LoadBitmap(HInstance, ImagesResNames[Idx]);
    Exclude(FUserImages, Idx);
    if not (csReading in ComponentState) then begin
      if Idx in [siHThumb, siVThumb] then Exclude(FOptions, soThumbOpaque)
      else Exclude(FOptions, soRulerOpaque);
      Invalidate;
    end;
  end
  else begin
    FImages[Idx].Assign(Value);
    Include(FUserImages, Idx);
  end;
end;

procedure TbsSkinCustomSlider.SetEdgeSize(Value: Integer);
var
  MaxSize: Integer;
begin
  if Orientation = soHorizontal then MaxSize := FImages[siHRuler].Width
  else MaxSize := FImages[siVRuler].Height;
  if Value * 2 < MaxSize then
    if Value <> FEdgeSize then begin
      FEdgeSize := Value;
      Sized;
    end;
end;

function TbsSkinCustomSlider.GetNumThumbStates: TbsNumThumbStates;
begin
  Result := FNumThumbStates;
end;

procedure TbsSkinCustomSlider.SetNumThumbStates(Value: TbsNumThumbStates);
begin
  if FNumThumbStates <> Value then begin
    FNumThumbStates := Value;
    AdjustElements;
  end;
end;

procedure TbsSkinCustomSlider.SetOrientation(Value: TbsSliderOrientation);
begin
  if Orientation <> Value then begin
    FOrientation := Value;
    Sized;
    if ComponentState * [csLoading, csUpdating] = [] then
      SetBounds(Left, Top, Height, Width);
  end;
end;

procedure TbsSkinCustomSlider.SetOptions(Value: TbsSliderOptions);
begin
  if Value <> FOptions then begin
    FOptions := Value;
    Invalidate;
  end;
end;

procedure TbsSkinCustomSlider.SetRange(Min, Max: Longint);
begin
  if (Min < Max) or (csReading in ComponentState) then begin
    FMinValue := Min;
    FMaxValue := Max;
    if not (csReading in ComponentState) then
      if Min + Increment > Max then FIncrement := Max - Min;
    if (soShowPoints in Options) then Invalidate;
    Self.Value := FValue;
    RangeChanged;
  end;
end;

procedure TbsSkinCustomSlider.SetMinValue(Value: Longint);
begin
  if FMinValue <> Value then SetRange(Value, MaxValue);
end;

procedure TbsSkinCustomSlider.SetMaxValue(Value: Longint);
begin
  if FMaxValue <> Value then SetRange(MinValue, Value);
end;

procedure TbsSkinCustomSlider.SetIncrement(Value: Longint);
begin
  if (Value > 0) and (FIncrement <> Value) then begin
    FIncrement := Value;
    Self.Value := FValue;
    Invalidate;
  end;
end;

function TbsSkinCustomSlider.GetValueByOffset(Offset: Integer): Longint;
var
  Range: Double;
  R: TRect;
  VThumbHeight: Integer;
begin
  // *
  R := SliderRect;

  if (FIndex = -1) or not FUseSkinThumb
  then
    VThumbHeight := FImages[siVThumb].Height
  else
    VThumbHeight := RectHeight(VThumbRect);

  if Orientation = soVertical then
    Offset := ClientHeight - Offset - VThumbHeight;
  Range := MaxValue - MinValue;
  Result := Round((Offset - R.Left - Indent) * Range / GetRulerLength);
  if not (soSmooth in Options) then
    Result := Round(Result / Increment) * Increment;
  Result := Min(MinValue + Max(Result, 0), MaxValue);
end;

function TbsSkinCustomSlider.GetOffsetByValue(Value: Longint): Integer;
var
  Range: Double;
  R: TRect;
  MinIndent: Integer;
  VThumbHeight: Integer;
begin
  if (FIndex = -1) or not FUseSkinThumb
  then
    VThumbHeight := FImages[siVThumb].Height
  else
    VThumbHeight := RectHeight(VThumbRect);

  R := SliderRect;
  Range := MaxValue - MinValue;
  if Orientation = soHorizontal then
    MinIndent := R.Left + Indent
  else
    MinIndent := R.Top + Indent;
  Result := Round((Value - MinValue) / Range * GetRulerLength) + MinIndent;
  if Orientation = soVertical then
    Result := R.Top + R.Bottom - Result - VThumbHeight;
  Result := Max(Result, MinIndent);
end;

function TbsSkinCustomSlider.GetThumbPosition(var Offset: Integer): TPoint;
var
  R: TRect;
  MinIndent: Integer;
begin
  R := SliderRect;
  if Orientation = soHorizontal then
    MinIndent := R.Left + Indent
  else
    MinIndent := R.Top + Indent;
  Offset := Min(GetOffsetByValue(GetValueByOffset(Min(Max(Offset, MinIndent),
    MinIndent + GetRulerLength))), MinIndent + GetRulerLength);
  if Orientation = soHorizontal then begin
    Result.X := Offset;
    Result.Y := FThumbRect.Top;
  end
  else begin
    Result.Y := Offset;
    Result.X := FThumbRect.Left;
  end;
end;

function TbsSkinCustomSlider.GetThumbOffset: Integer;
begin
  if Orientation = soHorizontal then Result := FThumbRect.Left
  else Result := FThumbRect.Top;
end;

procedure TbsSkinCustomSlider.InvalidateThumb;
begin
  if HandleAllocated then
    InvalidateRect(Handle, @FThumbRect, not (csOpaque in ControlStyle));
end;

procedure TbsSkinCustomSlider.SetThumbOffset(Value: Integer);
var
  ValueBefore: Longint;
  P: TPoint;
begin
  ValueBefore := FValue;
  P := GetThumbPosition(Value);
  InvalidateThumb;
  FThumbRect := Bounds(P.X, P.Y, RectWidth(FThumbRect), RectHeight(FThumbRect));
  InvalidateThumb;
  if FSliding then begin
    FValue := GetValueByOffset(Value);
    if ValueBefore <> FValue then Change;
  end;
end;

function TbsSkinCustomSlider.GetRulerLength: Integer;
begin
  if (FIndex = -1) or not FUseSkinThumb
  then
    begin
      if Orientation = soHorizontal then begin
        Result := FRuler.Width;
        Dec(Result, FImages[siHThumb].Width div NumThumbStates);
      end
      else begin
        Result := FRuler.Height;
        Dec(Result, FImages[siVThumb].Height);
      end;
    end
  else
    begin
      if Orientation = soHorizontal then begin
        Result := FRuler.Width;
        Dec(Result, RectWidth(HThumbRect) div 2);
      end
      else begin
        Result := FRuler.Height;
        Dec(Result, RectHeight(VThumbRect));
      end;
    end;
end;

procedure TbsSkinCustomSlider.SetValue(Value: Longint);
var
  ValueChanged: Boolean;
begin
  if Value > MaxValue then Value := MaxValue;
  if Value < MinValue then Value := MinValue;
  ValueChanged := FValue <> Value;
  FValue := Value;
  ThumbOffset := GetOffsetByValue(Value);
  if ValueChanged then Change;
end;

procedure TbsSkinCustomSlider.SetReadOnly(Value: Boolean);
begin
  if FReadOnly <> Value then begin
    if Value then begin
      StopTracking;
      if FSliding then ThumbMouseUp(mbLeft, [], 0, 0);
    end;
    FReadOnly := Value;
  end;
end;

procedure TbsSkinCustomSlider.ThumbJump(Jump: TbsJumpMode);
var
  NewValue: Longint;
begin
  if Jump <> jmNone then begin
    case Jump of
      jmHome: NewValue := MinValue;
      jmPrior:
        NewValue := (Round(Value / Increment) * Increment) - Increment;
      jmNext:
        NewValue := (Round(Value / Increment) * Increment) + Increment;
      jmEnd: NewValue := MaxValue;
      else Exit;
    end;
    if NewValue >= MaxValue then NewValue := MaxValue
    else if NewValue <= MinValue then NewValue := MinValue;
    if (NewValue <> Value) then Value := NewValue;
  end;
end;

function TbsSkinCustomSlider.JumpTo(X, Y: Integer): TbsJumpMode;
begin
  Result := jmNone;
  if Orientation = soHorizontal then begin
    if FThumbRect.Left > X then Result := jmPrior
    else if FThumbRect.Right < X then Result := jmNext;
  end
  else if Orientation = soVertical then begin
    if FThumbRect.Top > Y then Result := jmNext
    else if FThumbRect.Bottom < Y then Result := jmPrior;
  end;
end;

procedure TbsSkinCustomSlider.WMTimer(var Message: TMessage);
begin
  TimerTrack;
end;

procedure TbsSkinCustomSlider.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  InvalidateThumb;
end;

procedure TbsSkinCustomSlider.CMFocusChanged(var Message: TCMFocusChanged);
var
  Active: Boolean;
begin
  with Message do Active := (Sender = Self);
  if Active <> FFocused then begin
    FFocused := Active;
    if (soShowFocus in Options) then Invalidate;
  end;
  inherited;
end;

procedure TbsSkinCustomSlider.WMGetDlgCode(var Msg: TWMGetDlgCode);
begin
  Msg.Result := DLGC_WANTARROWS;
end;

procedure TbsSkinCustomSlider.WMSize(var Message: TWMSize);
begin
  inherited;
  if not (csReading in ComponentState) then Sized;
end;

procedure TbsSkinCustomSlider.StopTracking;
begin
  if FTracking then begin
    if FTimerActive then begin
      KillTimer(Handle, 1);
      FTimerActive := False;
    end;
    FTracking := False;
    MouseCapture := False;
    Changed;
  end;
end;

procedure TbsSkinCustomSlider.TimerTrack;
var
  Jump: TbsJumpMode;
begin
  Jump := JumpTo(FMousePos.X, FMousePos.Y);
  if Jump = FStartJump then begin
    ThumbJump(Jump);
    if not FTimerActive then begin
      SetTimer(Handle, 1, JumpInterval, nil);
      FTimerActive := True;
    end;
  end;
end;

procedure TbsSkinCustomSlider.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  Rect: TRect;
  P: TPoint;
begin
  inherited MouseDown(Button, Shift, X, Y);
  if (Button = mbLeft) and not (ssDouble in Shift) then begin
    if CanFocus then SetFocus;
    P := Point(X, Y);
    if PtInRect(FThumbRect, P) then
      ThumbMouseDown(Button, Shift, X, Y)
    else begin
      with FRulerOrg, FRuler do
        Rect := Bounds(X, Y, Width, Height);
      InflateRect(Rect, Ord(Orientation = soVertical) * 3,
        Ord(Orientation = soHorizontal) * 3);
      if PtInRect(Rect, P) and CanModify and not ReadOnly then begin
        MouseCapture := True;
        FTracking := True;
        FMousePos := P;
        FStartJump := JumpTo(X, Y);
        TimerTrack;
      end;
    end;
  end;
end;

procedure TbsSkinCustomSlider.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  if (csLButtonDown in ControlState) and FSliding then
    ThumbMouseMove(Shift, X, Y)
  else if FTracking then FMousePos := Point(X, Y);
  inherited MouseMove(Shift, X, Y);
end;

procedure TbsSkinCustomSlider.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  StopTracking;
  if FSliding then ThumbMouseUp(Button, Shift, X, Y);
  inherited MouseUp(Button, Shift, X, Y);
end;

procedure TbsSkinCustomSlider.KeyDown(var Key: Word; Shift: TShiftState);
var
  Jump: TbsJumpMode;
begin
  Jump := jmNone;
  if Shift = [] then begin
    if Key = VK_HOME then Jump := jmHome
    else if Key = VK_END then Jump := jmEnd;
    if Orientation = soHorizontal then begin
      if Key = VK_LEFT then Jump := jmPrior
      else if Key = VK_RIGHT then Jump := jmNext;
    end
    else begin
      if Key = VK_UP then Jump := jmNext
      else if Key = VK_DOWN then Jump := jmPrior;
    end;
  end;
  if (Jump <> jmNone) and CanModify and not ReadOnly then begin
    Key := 0;
    ThumbJump(Jump);
    Changed;
  end;
  inherited KeyDown(Key, Shift);
end;

procedure TbsSkinCustomSlider.ThumbMouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if CanFocus then SetFocus;
  if (Button = mbLeft) and CanModify and not ReadOnly then begin
    FSliding := True;
    FThumbDown := True;
    if Orientation = soHorizontal then FHit := X - FThumbRect.Left
    else FHit := Y - FThumbRect.Top;
    InvalidateThumb;
    Update;
  end;
end;

procedure TbsSkinCustomSlider.ThumbMouseMove(Shift: TShiftState; X, Y: Integer);
begin
  if (csLButtonDown in ControlState) and CanModify and not ReadOnly then
  begin
    if Orientation = soHorizontal then ThumbOffset := X - FHit
    else ThumbOffset := Y - FHit;
  end;
end;

procedure TbsSkinCustomSlider.ThumbMouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbLeft) then begin
    FSliding := False;
    FThumbDown := False;
    InvalidateThumb;
    Update;
    if CanModify and not ReadOnly then Changed;
  end;
end;

constructor TbsSkinBevel.Create;
begin
  inherited;
  FSD := nil;
  FSkinDataName := 'bevel';
  LightColor := clBtnHighLight;
  DarkColor := clBtnShadow;
  FIndex := -1;
  FDividerMode := False;
end;

procedure TbsSkinBevel.SetBounds;
var
  R: TRect;
begin
   if Parent is TbsSkinToolbar
  then
    begin
       if TbsSkinToolbar(Parent).AdjustControls
      then
        with TbsSkinToolbar(Parent) do
        begin
          R := GetSkinClientRect;
          ATop := R.Top + RectHeight(R) div 2 - AHeight div 2;
        end;
    end;
  inherited;
end;

procedure TbsSkinBevel.SetSkinData(Value: TbsSkinData);
begin
  FSD := Value;
  ChangeSkinData;
end;

procedure TbsSkinBevel.SetDividerMode(Value: Boolean);
begin
  FDividerMode := Value;
  RePaint;
end;

procedure TbsSkinBevel.ChangeSkinData;
begin
  if (FSD = nil) or FSD.Empty
  then
    FIndex := -1
  else
    FIndex := FSD.GetControlIndex(FSkinDataName);
  if FIndex = -1
  then
    begin
      LightColor := clBtnHighLight;
      DarkColor := clBtnShadow;
    end
  else
    if TbsDataSkinControl(FSD.CtrlList.Items[FIndex]) is TbsDataSkinBevel
    then
      with TbsDataSkinBevel(FSD.CtrlList.Items[FIndex]) do
      begin
        Self.LightColor := LightColor;
        Self.DarkColor := DarkColor;
      end;
  RePaint;
end;

procedure TbsSkinBevel.Paint;
const
  XorColor = $00FFD8CE;
var
  Color1, Color2: TColor;
  Temp: TColor;

  procedure BevelRect(const R: TRect);
  begin
    with Canvas do
    begin
      Pen.Color := Color1;
      PolyLine([Point(R.Left, R.Bottom), Point(R.Left, R.Top),
        Point(R.Right, R.Top)]);
      Pen.Color := Color2;
      PolyLine([Point(R.Right, R.Top), Point(R.Right, R.Bottom),
        Point(R.Left, R.Bottom)]);
    end;
  end;

  procedure BevelLine(C: TColor; X1, Y1, X2, Y2: Integer);
  begin
    with Canvas do
    begin
      Pen.Color := C;
      MoveTo(X1, Y1);
      LineTo(X2, Y2);
    end;
  end;

begin
  with Canvas do
  begin
    if (csDesigning in ComponentState) then
    begin
      if (Shape = bsSpacer) then
      begin
        Pen.Style := psDot;
        Pen.Mode := pmXor;
        Pen.Color := XorColor;
        Brush.Style := bsClear;
        Rectangle(0, 0, ClientWidth, ClientHeight);
        Exit;
      end
      else
      begin
        Pen.Style := psSolid;
        Pen.Mode  := pmCopy;
        Pen.Color := clBlack;
        Brush.Style := bsSolid;
      end;
    end;

    Pen.Width := 1;

    // must be skin

    if Style = bsLowered then
    begin
      Color1 := DarkColor;
      Color2 := LightColor;
    end
    else
    begin
      Color1 := LightColor;
      Color2 := DarkColor;
    end;

    //
    if FDividerMode
    then
      begin
        case Shape of
          bsTopLine, bsBottomLine:
            BevelRect(Rect(2, Height div 2 - 1, Width - 2, Height div 2));
          bsLeftLine, bsRightLine, bsBox, bsFrame:
            BevelRect(Rect(Width div 2 - 1, 2, Width div 2, Height - 2));
        end;
      end
    else
    case Shape of
      bsBox: BevelRect(Rect(0, 0, Width - 1, Height - 1));
      bsFrame:
        begin
          Temp := Color1;
          Color1 := Color2;
          BevelRect(Rect(1, 1, Width - 1, Height - 1));
          Color2 := Temp;
          Color1 := Temp;
          BevelRect(Rect(0, 0, Width - 2, Height - 2));
        end;
      bsTopLine:
        begin
          BevelLine(Color1, 0, 0, Width, 0);
          BevelLine(Color2, 0, 1, Width, 1);
        end;
      bsBottomLine:
        begin
          BevelLine(Color1, 0, Height - 2, Width, Height - 2);
          BevelLine(Color2, 0, Height - 1, Width, Height - 1);
        end;
      bsLeftLine:
        begin
          BevelLine(Color1, 0, 0, 0, Height);
          BevelLine(Color2, 1, 0, 1, Height);
        end;
      bsRightLine:
        begin
          BevelLine(Color1, Width - 2, 0, Width - 2, Height);
          BevelLine(Color2, Width - 1, 0, Width - 1, Height);
        end;
    end;
  end;
end;

// TbsSkinButtonsBar

constructor TbsButtonBarSection.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FItems := TbsButtonBarItems.create(self);
  FHint := '';
  FTag := 0;
  FSpacing := 1;
  FMargin := -1;
end;

procedure TbsButtonBarSection.SetMargin;
begin
  FMargin := Value;
  Changed(False);
end;

procedure TbsButtonBarSection.SetSpacing;
begin
  FSpacing := Value;
  Changed(False);
end;

procedure TbsButtonBarSection.Assign(Source: TPersistent);
begin
  if Source is TbsButtonBarSection then
  begin
    Text := TbsButtonBarSection(Source).Text;
    ImageIndex := TbsButtonBarSection(Source).ImageIndex;
    Tag := TbsButtonBarSection(Source).Tag;
    OnClick := TbsButtonBarSection(source).OnClick;
    OnDblClick := TbsButtonBarSection(source).OnDblClick;
    Margin := TbsButtonBarSection(source).Margin;
    Spacing := TbsButtonBarSection(source).Spacing;
  end
  else inherited Assign(Source);
end;

function TbsButtonBarSection.GetDisplayName: string;
begin
  Result := Text;
  if Result = '' then Result := inherited GetDisplayName;
end;


procedure TbsButtonBarSection.SetText(const Value: string);
begin
  if FText <> Value then
  begin
    FText := Value;
    Changed(False);
  end;
end;

procedure TbsButtonBarSection.SetItems(const Value: TbsButtonBarItems);
begin
  FItems.assign(Value);
end;

destructor TbsButtonBarSection.Destroy;
begin
  FItems.Free;
  inherited;
end;

procedure TbsButtonBarSection.SectionClick(const Value: TNotifyEvent);
begin
  FonClick := Value;
end;

procedure TbsButtonBarSection.SectionDblClick(const Value: TNotifyEvent);
begin
  FonDblClick := Value;
end;

procedure TbsButtonBarSection.Click;
begin
  if assigned(onClick) then
    onclick(self);
end;

procedure TbsButtonBarSection.DblClick;
begin
  if assigned(onDblClick) then
    onDblclick(self);
end;

procedure TbsButtonBarSection.SetImageIndex(Value: Integer);
begin
  if FImageIndex <> Value then
  begin
    FImageIndex := Value;
    Changed(False);
  end;
end;

constructor TbsButtonBarSections.Create(ButtonsBar: TbsSkinButtonsBar);
begin
  inherited Create(TbsButtonBarSection);
  FButtonsBar := ButtonsBar;
end;

function TbsButtonBarSections.GetButtonsBar: TbsSkinButtonsBar;
begin
  Result := FButtonsBar;
end;

function TbsButtonBarSections.Add: TbsButtonBarSection;
begin
  Result := TbsButtonBarSection(inherited Add);
end;

function TbsButtonBarSections.GetItem(Index: Integer): TbsButtonBarSection;
begin
  Result := TbsButtonBarSection(inherited GetItem(Index));
end;

function TbsButtonBarSections.GetOwner: TPersistent;
begin
  Result := FButtonsBar;
end;

procedure TbsButtonBarSections.SetItem(Index: Integer; Value: TbsButtonBarSection);
begin
  inherited SetItem(Index, Value);
end;

procedure TbsButtonBarSections.Update(Item: TCollectionItem);
begin
  if Item = nil
  then FButtonsBar.UpdateSections
  else FButtonsBar.UpdateSection(Item.Index);
  if Count = 0 then FButtonsBar.ClearSections;
end;

constructor TbsSkinButtonsBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FWebStyle := False;
  FShowButtons := True;
  FShowItemHint := True;

  FDefaultSectionFont := TFont.Create;
  with FDefaultSectionFont do
  begin
    Name := 'ËÎÌו';
    Charset := GB2312_CHARSET;
    Style := [];
    Height := -12;
  end;

  FDefaultItemFont := TFont.Create;
  with FDefaultItemFont do
  begin
    Name := 'ËÎÌו';
    Style := [];
    Height := -12;
  end;

  FUpButton := nil;
  FDownButton := nil;

  FSectionButtonSkinDataName := 'toolbutton';

  BorderStyle := bvFrame;
  FItemsPanel := TbsSkinPanel.Create(Self);
  with FItemsPanel do
  begin
    Parent := Self;
    Align := alClient;
    BorderStyle := bvNone;
    OnResize := OnItemPanelResize;
  end;
  Width := 150;
  FDefaultButtonHeight := 25;
  FItemHeight := 60;
  FItemsTransparent := True;
  Align := alLeft;
  FSectionButtons := TList.Create;
  FSectionItems := TList.Create ;
  FSections := TbsButtonBarSections.Create(Self);
end;

destructor TbsSkinButtonsBar.Destroy;
begin
  FDefaultSectionFont.Free;
  FDefaultItemFont.Free;
  ClearItems;
  ClearSections;
  FSectionButtons.Free;
  FSectionItems.Free;
  FItemsPanel.Free;
  FSections.Free;
  inherited Destroy;
end;

procedure TbsSkinButtonsBar.SetShowButtons;
begin
  FShowButtons := Value;
  UpdateSections;
end;

procedure TbsSkinButtonsBar.OnItemPanelResize(Sender: TObject);
begin
  CheckVisibleItems; 
end;

procedure TbsSkinButtonsBar.SetDefaultButtonHeight(Value: Integer);
begin
  FDefaultButtonHeight := Value;
  UpDateSectionButtons;
end;

procedure TbsSkinButtonsBar.SetDefaultSectionFont;
begin
  FDefaultSectionFont.Assign(Value);
end;

procedure TbsSkinButtonsBar.SetDefaultItemFont;
begin
  FDefaultItemFont.Assign(Value);
end;

procedure TbsSkinButtonsBar.ChangeSkinData;
begin
  inherited;
  CheckVisibleItems;
end;

procedure TbsSkinButtonsBar.ShowUpButton;
begin
  FUpButton := TbsSkinButton.Create(Self);
  with FUpButton do
  begin
    CanFocused := False;
    Width := 18;
    Height := 18;
    Spacing := 0;
    SkinDataName := 'resizebutton';
    RepeatMode := True;
    RepeatInterval := 150;
    Caption := '';
    NumGlyphs := 1;
    Glyph.LoadFromResourceName(HInstance, 'BS_BB_UP');
    OnClick := UpButtonClick;
    SkinData := Self.SkinData;
    Top := - Height;
    Parent := FItemsPanel;
  end;
end;

procedure TbsSkinButtonsBar.ShowDownButton;
begin
  FDownButton := TbsSkinButton.Create(Self);
  with FDownButton do
  begin
    CanFocused:= False;
    Width := 18;
    Height := 18;
    Spacing := 0;
    SkinDataName := 'resizebutton';
    RepeatMode := True;
    RepeatInterval := 150;
    Glyph.LoadFromResourceName(HInstance, 'BS_BB_DOWN');
    Caption := '';
    NumGlyphs := 1;
    OnClick := DownButtonClick;
    SkinData := Self.SkinData;
    Top := - Height;
    Parent := FItemsPanel;
  end;
end;

procedure TbsSkinButtonsBar.HideUpButton;
begin
  FUpButton.Free;
  FUpButton := nil;
end;

procedure TbsSkinButtonsBar.HideDownButton;
begin
  FDownButton.Free;
  FDownButton := nil;
end;

procedure TbsSkinButtonsBar.UpButtonClick(Sender: TObject);
begin
  ScrollUp;
end;

procedure TbsSkinButtonsBar.DownButtonClick(Sender: TObject);
begin
  ScrollDown;
end;

procedure TbsSkinButtonsBar.ArangeItems;
var
  I, J: Integer;
begin

  if (TopIndex > 0) and (FUpButton = nil)
  then
    ShowUpButton
  else
    if (TopIndex = 0) and (FUpButton <> nil) then HideUpButton;

  if (TopIndex + VisibleCount < FSectionItems.Count) and (FDownButton = nil)
  then
    ShowDownButton
  else
  if (TopIndex + VisibleCount >= FSectionItems.Count) and (FDownButton <> nil)
  then
    HideDownButton;


  if FUpButton <> nil
  then
    with FUpButton do
      SetBounds(FItemsPanel.Width - Width - 5, 5, Width, Height);

  if FDownButton <> nil
  then
    with FDownButton do
      SetBounds(FItemsPanel.Width - Width - 5, FItemsPanel.Height - Height - 5, Width, Height);

  J := 0;
  for I := 0 to FSectionItems.Count - 1 do
  with TbsSectionItem(FSectionItems.Items[I]) do
  if Visible
  then
    begin
      SetBounds(0, J, FItemsPanel.Width, FItemHeight);
      Inc(J, FItemHeight);
      Parent := FItemsPanel;
    end;

end;

procedure TbsSkinButtonsBar.CheckVisibleItems;
var
  I: Integer;
  OldVisibleCount, OldTopIndex: Integer;
  CanVisible: Boolean;
begin
  OldVisibleCount := VisibleCount;
  OldTopIndex := TopIndex;
  VisibleCount := FItemsPanel.Height div FItemHeight;

  if VisibleCount > FSectionItems.Count
  then VisibleCount := FSectionItems.Count;

  if VisibleCount = FSectionItems.Count
  then
    TopIndex := 0
  else
    if (TopIndex + VisibleCount > FSectionItems.Count) and (TopIndex > 0)
    then
     begin
       TopIndex := TopIndex - (VisibleCount - OldVisibleCount);
       if TopIndex < 0 then TopIndex := 0;
     end;

  for I := 0 to FSectionItems.Count - 1 do
  with TbsSectionItem(FSectionItems.Items[I]) do
  begin
    CanVisible := (I >= TopIndex) and (I <= TopIndex + VisibleCount - 1);
    if CanVisible and not Visible
    then
      begin
        if I < OldTopIndex
        then
          begin
            Top := 0;
            Visible := CanVisible;
          end
        else
          begin
            Top := FItemsPanel.Height;
            Visible := CanVisible;
          end;
      end
    else
      begin
        Visible := CanVisible;
        if not Visible then Parent := nil;
      end;
  end;

  ArangeItems;
end;

procedure TbsSkinButtonsBar.ScrollUp;
begin
  if (TopIndex = 0) or (VisibleCount = 0) then Exit;
  TbsSectionItem(FSectionItems.Items[TopIndex + VisibleCount - 1]).Visible := False;
  Dec(TopIndex);
  TbsSectionItem(FSectionItems.Items[TopIndex]).Visible := True;
  ArangeItems;
end;

procedure TbsSkinButtonsBar.ScrollDown;
begin
  if VisibleCount = 0 then Exit;
  if TopIndex + VisibleCount >= FSectionItems.Count then Exit;
  TbsSectionItem(FSectionItems.Items[TopIndex]).Visible := False;
  Inc(TopIndex);
  TbsSectionItem(FSectionItems.Items[TopIndex + VisibleCount - 1]).Visible := True;
  ArangeItems;
end;

procedure TbsSkinButtonsBar.SetItemHeight;
begin
  FItemHeight := Value;
  UpdateItems;
end;

procedure TbsSkinButtonsBar.SetItemsTransparent;
begin
  FItemsTransparent := Value;
  UpdateItems;
end;

procedure TbsSkinButtonsBar.UpDateSectionButtons;
var
  I: Integer;
begin
  if Sections.Count = 0 then Exit;
  for I := 0 to Sections.Count - 1 do UpdateSection(I);
end;

procedure TbsSkinButtonsBar.OpenSection(Index: Integer);
var
  I: Integer;
begin

  if FSectionIndex = Index then Exit;

  FSectionIndex := Index;

  if FShowButtons
  then
    begin
      for I := 0 to FSectionButtons.Count - 1 do
      with TbsSectionButton(FSectionButtons.Items[I]) do
      begin
       if (FItemIndex > FSectionIndex) and (Align <> alBottom) then Align := alBottom;
      end;

      for I := FSectionButtons.Count - 1 downto 0 do
      with TbsSectionButton(FSectionButtons.Items[I]) do
      begin
        if (FItemIndex <= FSectionIndex) and (Align <> alTop) then Align := alTop;
      end;
    end;

  UpdateItems;

  Sections[Index].Click;
end;

procedure TbsSkinButtonsBar.ClearItems;
var
  I: Integer;
begin
  if FSectionItems = nil then Exit;
  if FSectionItems.Count = 0 then Exit;
  for I := FSectionItems.Count - 1 downto 0 do
  begin
    TbsSectionItem(FSectionItems.Items[I]).Free;
  end;
  FSectionItems.Clear;
end;

procedure TbsSkinButtonsBar.ClearSections;
var
  I: Integer;
begin
  if FSectionButtons = nil then Exit;
  if FSectionButtons.Count = 0 then Exit;
  for I := 0 to FSectionButtons.Count - 1 do
  begin
    TbsSectionButton(FSectionButtons.Items[I]).Free;
  end;
  FSectionButtons.Clear;
end;

procedure TbsSkinButtonsBar.SetSkinData;
begin
  inherited;
  if FItemsPanel <> nil
  then
    begin
      FItemsPanel.SkinData := Value;
      UpdateSections; 
    end;
end;

procedure TbsSkinButtonsBar.CreateWnd;
begin
  inherited CreateWnd;
  UpdateSections;
  UpdateItems;
end;

procedure TbsSkinButtonsBar.SetSections(Value: TbsButtonBarSections);
begin
  FSections.Assign(Value);
end;

procedure TbsSkinButtonsBar.UpdateSection(Index: Integer);
var
  S: TbsButtonBarSection;
  I: Integer;
  B: Boolean;
begin
  if not HandleAllocated then Exit;
  if FSections.Count = 0 then Exit;
  if not FShowButtons
  then
    begin
      UpdateItems;
      Exit;
    end;
  S := TbsButtonBarSection(Sections.Items[Index]);
  for I := 0 to FSectionButtons.Count - 1 do
  with TbsSectionButton(FSectionButtons.Items[I]) do
  if FItemIndex = Index then
  begin
    DefaultHeight := DefaultButtonHeight;
    Hint := S.Hint;
    Margin := S.Margin;
    Spacing := S.Spacing;
    ShowHint := Self.ShowItemHint;
    B := Caption <> S.Text;
    if B then Caption := S.Text;
    if (S.ImageIndex <> -1) and (FSectionImages <> nil) and (S.ImageIndex < FSectionImages.Count)
    then
      begin
        ImageIndex := S.ImageIndex;
        FButtonImages := FSectionImages;
      end
    else
      begin
        ImageIndex := -1;
        FButtonImages := nil;
      end;
    RePaint;
    if (FSectionIndex = Index) and not B then UpdateItems;
    Break;
  end;
end;

procedure TbsSkinButtonsBar.UpdateSections;
var
  I: Integer;
  S: TbsButtonBarSection;
begin
  if not HandleAllocated then Exit;
  if FSections.Count = 0 then Exit;

  ClearSections;

  if not FShowButtons
  then
    begin
      CheckVisibleItems;
      Exit;
    end;

  for I := FSectionIndex downto 0  do
  begin
    S := TbsButtonBarSection(Sections.Items[I]);
    FSectionButtons.Add(TbsSectionButton.CreateEx(Self, Self, I));
    with TbsSectionButton(FSectionButtons.Items[FSectionButtons.Count - 1]) do
    begin
      Align := alTop;
      Parent := Self;
      DefaultHeight := DefaultButtonHeight;
      SkinData := Self.SkinData;
      Caption := S.Text;
      Hint := S.Hint;
      Margin := S.Margin;
      Spacing := S.Spacing;
      ShowHint := Self.ShowItemHint;
      if (S.ImageIndex <> -1) and (FSectionImages <> nil) and (S.ImageIndex < FSectionImages.Count)
      then
        begin
          ImageIndex := S.ImageIndex;
          FButtonImages := FSectionImages;
        end
      else
        begin
          ImageIndex := -1;
          FButtonImages := nil;
        end;
    end;
  end;

  for I := Sections.Count - 1 downto  FSectionIndex + 1  do
  begin
    S := TbsButtonBarSection(Sections.Items[I]);
    FSectionButtons.Add(TbsSectionButton.CreateEx(Self, Self, I));
    with TbsSectionButton(FSectionButtons.Items[FSectionButtons.Count - 1]) do
    begin
      Align := alBottom;
      Parent := Self;
      DefaultHeight := DefaultButtonHeight;
      SkinData := Self.SkinData;
      Caption := S.Text;
      Hint := S.Hint;
      Margin := S.Margin;
      Spacing := S.Spacing;
      ShowHint := Self.ShowItemHint;
      if (S.ImageIndex <> -1) and (FSectionImages <> nil) and (S.ImageIndex < FSectionImages.Count)
      then
        begin
          ImageIndex := S.ImageIndex;
          FButtonImages := FSectionImages;
        end
      else
        begin
          ImageIndex := -1;
          FButtonImages := nil;
        end;
    end;
  end;

 CheckVisibleItems;
end;

procedure TbsSkinButtonsBar.UpdateItems;
var
  I: Integer;
  It: TbsButtonBarItem;
begin
  if not HandleAllocated then Exit;
  if FSections.Count = 0 then Exit;
  if FShowButtons and (FSectionButtons.Count = 0) then Exit;
  ClearItems;
  if FUpButton <> nil then HideUpButton;
  if FDownButton <> nil then HideDownButton;
  if FSections.Items[FSectionIndex].Items.Count = 0 then Exit;
  TopIndex := 0;
  for I := 0 to FSections.Items[FSectionIndex].Items.Count - 1 do
  begin
    It := TbsButtonBarItem(FSections.Items[FSectionIndex].Items[I]);
    FSectionItems.Add(TbsSectionItem.CreateEx(FItemsPanel, Self, FSectionIndex, I, FWebStyle));
    with TbsSectionItem(FSectionItems.Items[FSectionItems.Count - 1]) do
    begin
      DefaultHeight := FItemHeight;
      FWebStyle := Self.WebStyle;
      Transparent := FItemsTransparent or FWebStyle;
      if FWebStyle then Cursor := crHandPoint else Cursor := crDefault;
      SkinData := Self.SkinData;
      Caption := It.Text;
      Hint := It.Hint;
      ShowHint := Self.ShowItemHint;
      if (It.ImageIndex <> -1) and (FItemImages <> nil) and (It.ImageIndex < FitemImages.Count)
      then
        begin
          ImageIndex := It.ImageIndex;
          FButtonImages := FItemImages;
        end
      else
        begin
          ImageIndex := -1;
          FButtonImages := nil;
        end;
      Layout := It.Layout;
      Margin := It.Margin;
      Spacing := It.Spacing;
    end;
  end;
  CheckVisibleItems;
end;

procedure TbsSkinButtonsBar.SetSectionIndex(const Value: integer);
begin
  if (Value >= 0) and (Value <> FSectionIndex) and (Value < Sections.Count)
  then
    begin
      OpenSection(Value);
    end;
end;

procedure TbsSkinButtonsBar.SetItemImages(const Value: TCustomImageList);
begin
  FItemImages := Value;
  UpdateItems;
end;

procedure TbsSkinButtonsBar.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (operation=opremove) and (Acomponent = FItemImages) then
    SetItemImages(nil);
  if (operation=opremove) and (Acomponent=FSectionImages) then
    SetSectionImages(nil);
end;

procedure TbsSkinButtonsBar.SetSectionImages(const Value: TCustomImageList);
begin
  FSectionImages := Value;
  UpDateSectionButtons;
end;

procedure TbsButtonBarItem.Assign(Source: TPersistent);
begin
  if Source is TbsButtonBarItem then
  begin
    Text := TbsButtonBarItem(Source).Text;
    ImageIndex := TbsButtonBarItem(source).ImageIndex;
    OnClick:= TbsButtonBarItem(source).OnClick;
    OnDblClick := TbsButtonBarItem(source).OnDblClick;
    Tag := TbsButtonBarItem(source).Tag;
    Layout := TbsButtonBarItem(source).Layout;
    Margin := TbsButtonBarItem(source).Margin;
    Spacing := TbsButtonBarItem(source).Spacing;
  end
  else inherited Assign(Source);
end;

procedure TbsButtonBarItem.Click;
begin
  if Assigned(OnClick) then OnClick(Self);
end;

procedure TbsButtonBarItem.DblClick;
begin
  if Assigned(OnDblClick) then OnDblClick(Self);
end;

constructor TbsButtonBarItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FTag := 0;
  FLayout := blGlyphTop;
  FMargin := -1;
  FSpacing := 1;
  FHint := '';
end;

function TbsButtonBarItem.GetDisplayName: string;
begin
  Result := Text;
  if Result = '' then Result := inherited GetDisplayName;
end;


procedure TbsButtonBarItem.SetImageIndex(const Value: integer);
begin
  if FImageIndex<>value then
  begin
    FImageIndex := Value;
    changed(false)
  end;
end;

procedure TbsButtonBarItem.ItemClick(const Value: TNotifyEvent);
begin
  FOnClick := Value;
end;

procedure TbsButtonBarItem.ItemDblClick(const Value: TNotifyEvent);
begin
  FOnDblClick := Value;
end;


procedure TbsButtonBarItem.SetText(const Value: string);
begin
  if FText <> Value then
  begin
    FText := Value;
    Changed(False);
  end;
end;

procedure TbsButtonBarItem.SetLayout;
begin
  FLayout := Value;
  Changed(False);
end;

procedure TbsButtonBarItem.SetMargin;
begin
  FMargin := Value;
  Changed(False);
end;

procedure TbsButtonBarItem.SetSpacing;
begin
  FSpacing := Value;
  Changed(False);
end;

function TbsButtonBarItems.Add: TbsButtonBarItem;
begin
  Result := TbsButtonBarItem(inherited Add);
end;

constructor TbsButtonBarItems.Create(Section: TbsButtonBarSection);
begin
  inherited Create(TbsButtonBarItem);
  FSection := Section;
end;

function TbsButtonBarItems.GetItem(Index: Integer): TbsButtonBarItem;
begin
  Result := TbsButtonBarItem(inherited GetItem(Index));
end;

function TbsButtonBarItems.GetOwner: TPersistent;
begin
  Result := FSection;
end;

procedure TbsButtonBarItems.SetItem(Index: Integer; Value: TbsButtonBarItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TbsButtonBarItems.Update(Item: TCollectionItem);
begin
  FSection.Changed(False);
end;

constructor TbsSectionButton.CreateEx;
begin
  inherited Create(AOwner);
  FButtonsBar := AButtonsBar;
  FItemIndex := AIndex;
  NumGlyphs := 1;
  Spacing := 5;
  SkinDataName := FButtonsBar.SectionButtonSkinDataName;
  DefaultFont := FButtonsBar.DefaultSectionFont;
  UseSkinFont := FButtonsBar.UseSkinFont;
end;

procedure TbsSectionButton.MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); 
begin
  inherited;
  if (Button = mbLeft) and (ssDouble in Shift)
  then
    FButtonsBar.Sections[FItemIndex].DblClick;
end;

procedure TbsSectionButton.ButtonClick;
begin
  FButtonsBar.Sections[FItemIndex].Click;
  FButtonsBar.OpenSection(FItemIndex);
  inherited;
end;

constructor TbsSectionItem.CreateEx;
begin
  inherited Create(AOwner);
  FWebStyle := AWebStyle;
  if FWebStyle
  then
    begin
      Cursor := crHandPoint;
      Transparent := True;
     end;
  FButtonsBar := AButtonsBar;
  FItemIndex := AIndex;
  FSectionIndex := ASectionIndex;
  Flat := True;
  SkinDataName := 'resizebutton';
  NumGlyphs := 1;
  Layout := blGlyphTop;
  Spacing := 5;
  DefaultFont := FButtonsBar.DefaultItemFont;
  UseSkinFont := FButtonsBar.UseSkinFont;
end;

procedure TbsSectionItem.Paint;

function GetGlyphNum: Integer;
begin
  if FDown and FMouseIn and (FNumGlyphs > 2)
  then
    Result := 3
  else
  if FMouseIn and (FNumGlyphs > 3)
  then
    Result := 4
  else
    if not Enabled and (FNumGlyphs > 1)
    then
      Result := 2
    else
      Result := 1;
end;

var
  LabelFontColor, LabelActiveFontColor: TColor;
  LabelData: TbsDataSkinStdLabelControl;
  CIndex: Integer;
  R: TRect;
begin
  if not FWebStyle
  then
    begin
      inherited;
      Exit;
    end;
  //
  if (FSD = nil) or FSD.Empty
  then
    CIndex := -1
  else
    CIndex := FSD.GetControlIndex('stdlabel');
  if CIndex <> -1
  then
    with TbsDataSkinStdLabelControl(FSD.CtrlList[CIndex]) do
    begin
      LabelFontColor := FontColor;
      LabelActiveFontColor := ActiveFontColor;
    end
  else
    begin
      LabelFontColor := DefaultFont.Color;
      LabelActiveFontColor := clBlue;
    end;
  //
  GetSkinData;
  if FIndex <> -1
  then
    with Canvas.Font do
    begin
      if FUseSkinFont
      then
        begin
          Name := FontName;
          Height := FontHeight;
          Style := FontStyle;
        end
      else
        Canvas.Font := FDefaultFont;

      if FMouseIn
      then
        Color := LabelActiveFontColor
      else
        Color := LabelFontColor;
    end
  else
    begin
      Canvas.Font := FDefaultFont;
      if FMouseIn
      then
        Canvas.Font.Color := clBlue;
   end;

  if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
  then
    Canvas.Font.Charset := SkinData.ResourceStrData.CharSet
  else
    Canvas.Font.CharSet := FDefaultFont.Charset;

  if FWebStyle
  then
    if FMouseIn
    then Canvas.Font.Style := Canvas.Font.Style + [fsUnderLine]
    else Canvas.Font.Style := Canvas.Font.Style - [fsUnderLine];

  R := Rect(0, 0, Width, Height);
  DrawImageAndText(Canvas, R, FMargin, FSpacing, FLayout,
                 Caption, FImageIndex, FButtonImages, False, Enabled, False, 0);
end;

procedure TbsSectionItem.MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); 
begin
  inherited;
  if (Button = mbLeft) and (ssDouble in Shift)
  then
    FButtonsBar.Sections[FSectionIndex].Items[FItemIndex].DblClick;
end;

procedure TbsSectionItem.ButtonClick;
begin
  FButtonsBar.Sections[FSectionIndex].Items[FItemIndex].Click;
  inherited;
end;

{TbsSkinNoteBook}
type
  TbsPageAccess = class(TStrings)
  private
    PageList: TList;
    Notebook: TbsSkinNoteBook;
  protected
    function GetCount: Integer; override;
    function Get(Index: Integer): string; override;
    procedure Put(Index: Integer; const S: string); override;
    function GetObject(Index: Integer): TObject; override;
    procedure SetUpdateState(Updating: Boolean); override;
  public
    constructor Create(APageList: TList; ANotebook: TbsSkinNoteBook);
    procedure Clear; override;
    procedure Delete(Index: Integer); override;
    procedure Insert(Index: Integer; const S: string); override;
    function Add(const S: string): Integer; override;
    procedure Move(CurIndex, NewIndex: Integer); override;
  end;

constructor TbsPageAccess.Create(APageList: TList; ANotebook: TbsSkinNoteBook);
begin
  inherited Create;
  PageList := APageList;
  Notebook := ANotebook;
end;

function TbsPageAccess.GetCount: Integer;
begin
  Result := PageList.Count;
end;

function TbsPageAccess.Get(Index: Integer): string;
begin
  Result := TbsSkinPage(PageList[Index]).Caption;
end;

procedure TbsPageAccess.Put(Index: Integer; const S: string);
var
  Form: TCustomForm;
begin
  TbsSkinPage(PageList[Index]).Caption := S;
  if NoteBook.ButtonsMode then NoteBook.UpdateButton(Index, S);
  if csDesigning in NoteBook.ComponentState then
  begin
    Form := GetParentForm(NoteBook);
    if (Form <> nil) and (Form.Designer <> nil) then
      Form.Designer.Modified;
  end;
end;

function TbsPageAccess.GetObject(Index: Integer): TObject;
begin
  Result := PageList[Index];
end;

procedure TbsPageAccess.SetUpdateState(Updating: Boolean);
begin
  { do nothing }
end;

procedure TbsPageAccess.Clear;
var
  I: Integer;
  Form: TCustomForm;
begin
  for I := 0 to PageList.Count - 1 do
    TbsSkinPage(PageList[I]).Free;
  PageList.Clear;
  if NoteBook.ButtonsMode then NoteBook.UpdateButtons;
  if csDesigning in NoteBook.ComponentState then
  begin
    Form := GetParentForm(NoteBook);
    if (Form <> nil) and (Form.Designer <> nil) then
      Form.Designer.Modified;
  end;
end;

procedure TbsPageAccess.Delete(Index: Integer);
var
  Form: TCustomForm;
begin
  TbsSkinPage(PageList[Index]).Free;
  PageList.Delete(Index);
  NoteBook.PageIndex := 0;
  if NoteBook.ButtonsMode then NoteBook.UpdateButtons;
  if csDesigning in NoteBook.ComponentState then
  begin
    Form := GetParentForm(NoteBook);
    if (Form <> nil) and (Form.Designer <> nil) then
      Form.Designer.Modified;
  end;
end;

function TbsPageAccess.Add;
var
  Page: TbsSkinPage;
  Form: TCustomForm;
begin
  Page := TbsSkinPage.Create(Notebook);
  with Page do
  begin
    Parent := Notebook;
    Caption := S;
  end;
  PageList.Add(Page);
  NoteBook.PageIndex := PageList.Count - 1;
  Result := PageList.Count - 1;
  if NoteBook.ButtonsMode then NoteBook.UpdateButtons;
  if csDesigning in NoteBook.ComponentState then
  begin
    Form := GetParentForm(NoteBook);
    if (Form <> nil) and (Form.Designer <> nil) then
      Form.Designer.Modified;
  end;
end;

procedure TbsPageAccess.Insert(Index: Integer; const S: string);
var
  Page: TbsSkinPage;
  Form: TCustomForm;
begin
  Page := TbsSkinPage.Create(Notebook);
  with Page do
  begin
    Parent := Notebook;
    Caption := S;
  end;
  PageList.Insert(Index, Page);

  NoteBook.PageIndex := Index;
  if NoteBook.ButtonsMode then NoteBook.UpdateButtons;

  if csDesigning in NoteBook.ComponentState then
  begin
    Form := GetParentForm(NoteBook);
    if (Form <> nil) and (Form.Designer <> nil) then
      Form.Designer.Modified;
  end;
end;

procedure TbsPageAccess.Move(CurIndex, NewIndex: Integer);
var
  AObject: TObject;
begin
  if CurIndex <> NewIndex then
  begin
    AObject := PageList[CurIndex];
    PageList[CurIndex] := PageList[NewIndex];
    PageList[NewIndex] := AObject;
  end;
  if NoteBook.ButtonsMode then NoteBook.UpdateButtons;
end;

constructor TbsSkinPage.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Visible := False;
  ControlStyle := ControlStyle + [csNoDesignVisible];
  Align := alClient;
  BorderStyle := bvNone;
  FImageIndex := -1;
end;

procedure TbsSkinPage.ReadState(Reader: TReader);
begin
  if Reader.Parent is TbsSkinNoteBook then
    TbsSkinNotebook(Reader.Parent).FPageList.Add(Self); 
  inherited ReadState(Reader);
end;

procedure TbsSkinPage.WMNCHitTest(var Message: TWMNCHitTest);
begin
  if not (csDesigning in ComponentState) then
    Message.Result := HTTRANSPARENT
  else
    inherited;
end;

constructor TbsPageButton.CreateEx;
begin
  inherited Create(AOwner);
  FNoteBook := ANoteBook;
  FPageIndex := APageIndex;
  NumGlyphs := 1;
  Spacing := 5;
  SkinDataName := FNoteBook.ButtonSkinDataName;
end;

procedure TbsPageButton.ButtonClick;
begin
  FNoteBook.PageIndex := FPageIndex;
  inherited;
end;

var
  Registered: Boolean = False;
  
constructor TbsSkinNoteBook.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csAcceptsControls,
   csCaptureMouse, csClickEvents];
  FButtonsMode := False;
  FButtonSkinDataName := 'toolbutton';
  FButtons := TList.Create;
  BorderStyle := bvFrame;
  Width := 150;
  Height := 150;
  FPageList := TList.Create;
  FAccess := TbsPageAccess.Create(FPageList, Self);
  FPageIndex := -1;
  FAccess.Add('Default');
  PageIndex := 0;
  Exclude(FComponentStyle, csInheritable);
  if not Registered then
  begin
    Classes.RegisterClasses([TbsSkinPage]);
    Registered := True;
  end;
end;

destructor TbsSkinNoteBook.Destroy;
begin
  FAccess.Free;
  FPageList.Free;
  ClearButtons;
  FButtons.Free;
  inherited Destroy;
end;

procedure TbsSkinNoteBook.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (operation=opremove) and (Acomponent = FImages) then
    SetImages(nil);
end;

procedure TbsSkinNoteBook.SetImages(const Value: TCustomImageList);
begin
  FImages := Value;
  if FButtonsMode then UpDateButtons;
end;

procedure TbsSkinNoteBook.UpdateButton;
var
  I: Integer;
  P: TbsSkinPage;
begin
  for I := 0 to FButtons.Count - 1 do
  with TbsPageButton(FButtons.Items[I]) do
  if FPageIndex = APageIndex
  then
    begin
      P := TbsSkinPage(FPageList.Items[APageIndex]);
      Caption := ACaption;
      FButtonImages := FImages;
      ImageIndex := P.ImageIndex;
      RePaint;
    end;
end;

procedure TbsSkinNoteBook.UpdateButtons;
var
  I: Integer;
  P: TbsSkinPage;
begin
  if Pages.Count = 0 then Exit;
  ClearButtons;
  for I := 0 to Pages.Count - 1  do
  begin
    FButtons.Add(TbsPageButton.CreateEx(Self, Self, I));
    P := TbsSkinPage(FPageList.Items[I]);
    with TbsPageButton(FButtons.Items[FButtons.Count - 1]) do
    begin
      if I <= Self.PageIndex
      then
        begin
          Top := Self.Height;
          Align := alTop;
        end
      else
        begin
          Top := Self.Height;
          Align := alBottom;
        end;
      Parent := Self;
      DefaultHeight := 25;
      SkinData := Self.SkinData;
      Caption := Pages[I];
      if (P.ImageIndex <> -1) and (FImages <> nil) and (P.ImageIndex < FImages.Count)
      then
        begin
          FButtonImages := FImages;
          ImageIndex := P.ImageIndex;
        end
      else
        begin
          FButtonImages := nil;
          ImageIndex := -1;
        end;
    end;
  end;
end;

procedure TbsSkinNoteBook.ClearButtons;
var
  I: Integer;
begin
  if FButtons = nil then Exit;
  if FButtons.Count = 0 then Exit;
  for I := 0 to FButtons.Count - 1 do
  begin
    TbsSkinSpeedButton(FButtons.Items[I]).Free;
  end;
  FButtons.Clear;
end;

procedure TbsSkinNoteBook.SetButtonsMode(Value: Boolean);
begin
  FButtonsMode := Value;
  if FButtonsMode then UpDateButtons else ClearButtons;
end;

procedure TbsSkinNoteBook.Loaded;
begin
  inherited;
  if (FPageIndex <> -1) and (FPageIndex >= 0) and (FPageIndex < FPageList.Count)
  then
    with TbsSkinPage(FPageList[FPageIndex]) do
      SkinData := Self.SkinData;
  if FButtonsMode then UpDateButtons;
  NotebookHandlesNeeded(Self);
end;

procedure TbsSkinNoteBook.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style or WS_CLIPCHILDREN;
    WindowClass.style := WindowClass.style and not (CS_HREDRAW or CS_VREDRAW);
  end;
end;

function TbsSkinNoteBook.GetChildOwner: TComponent;
begin
  Result := Self;
end;

procedure TbsSkinNoteBook.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  I: Integer;
begin
  for I := 0 to FPageList.Count - 1 do Proc(TControl(FPageList[I]));
end;

procedure TbsSkinNoteBook.ReadState(Reader: TReader);
begin
  Pages.Clear;
  inherited ReadState(Reader);
  if (FPageIndex <> -1) and (FPageIndex >= 0) and (FPageIndex < FPageList.Count) then
    with TbsSkinPage(FPageList[FPageIndex]) do
    begin
      BringToFront;
      SkinData := Self.SkinData;
      Visible := True;
      Align := alClient;
    end
  else FPageIndex := -1;
end;

procedure TbsSkinNoteBook.ShowControl(AControl: TControl);
var
  I: Integer;
begin
  for I := 0 to FPageList.Count - 1 do
    if FPageList[I] = AControl then
    begin
      SetPageIndex(I);
      Exit;
    end;
  inherited ShowControl(AControl);
end;

procedure TbsSkinNoteBook.SetPages(Value: TStrings);
begin
  FAccess.Assign(Value);
  UpdateButtons;
end;

procedure TbsSkinNoteBook.SetPageIndex(Value: Integer);
var
  ParentForm: TCustomForm;
  I: Integer;
begin
  if csLoading in ComponentState then
  begin
    FPageIndex := Value;
    Exit;
  end;
  if (Value <> FPageIndex) and (Value >= 0) and (Value < FPageList.Count) then
  begin
    ParentForm := GetParentForm(Self);
    if ParentForm <> nil then
      if ContainsControl(ParentForm.ActiveControl) then
        ParentForm.ActiveControl := Self;
    with TbsSkinPage(FPageList[Value]) do
    begin
      BringToFront;
      SkinData := Self.SkinData;
      Visible := True;
      Align := alClient;
    end;
    if (FPageIndex >= 0) and (FPageIndex < FPageList.Count) then
      TbsSkinPage(FPageList[FPageIndex]).Visible := False;
    FPageIndex := Value;
    if ParentForm <> nil then
      if ParentForm.ActiveControl = Self then SelectFirst;
    //
    if FButtonsMode
    then
      begin
        for I := FButtons.Count - 1 downto 0 do
          with TbsPageButton(FButtons.Items[I]) do
          begin
            if (FPageIndex > Self.PageIndex) and (Align <> alBottom) then Align := alBottom;
          end;
        for I := 0 to FButtons.Count - 1 do
          with TbsPageButton(FButtons.Items[I]) do
          begin
            if (FPageIndex <= Self.PageIndex) and (Align <> alTop) then Align := alTop;
          end;
      end;
    //
    if Assigned(FOnPageChanged) then
      FOnPageChanged(Self);
  end;
end;

procedure TbsSkinNoteBook.SetActivePage(const Value: string);
begin
  SetPageIndex(FAccess.IndexOf(Value));
end;

function TbsSkinNoteBook.GetActivePage: string;
begin
  Result := FAccess[FPageIndex];
end;

constructor TbsSkinXFormButton.Create(AOwner: TComponent);
begin
  inherited;
  FDefImage := TBitMap.Create;
  FDefActiveImage := TBitMap.Create;
  FDefDownImage := TBitMap.Create;
  FDefMask := TBitMap.Create;
  CanFocused := False;
  FDefActiveFontColor := 0;
  FDefDownFontColor := 0;
end;

destructor TbsSkinXFormButton.Destroy;
begin
  FDefImage.Free;
  FDefActiveImage.Free;
  FDefDownImage.Free;
  FDefMask.Free;
  inherited;
end;

procedure TbsSkinXFormButton.SetControlRegion;
var
  TempRgn: HRGN;
begin
  if (FIndex = -1) and (FDefImage <> nil) and not FDefImage.Empty
  then
    begin
      TempRgn := FRgn;
      
      if FDefMask.Empty and (FRgn <> 0)
      then
        begin
          SetWindowRgn(Handle, 0, True);
        end
      else
        begin
          CreateSkinSimplyRegion(FRgn, FDefMask);
          SetWindowRgn(Handle, FRgn, True);
        end;

      if TempRgn <> 0 then DeleteObject(TempRgn);
    end
  else
    inherited;
end;

procedure TbsSkinXFormButton.SetBounds;
begin
  inherited;
  if (FIndex = -1) and (FDefImage <> nil) and not FDefImage.Empty
  then
    begin
      if Width <> FDefImage.Width then Width := FDefImage.Width;
      if Height <> FDefImage.Height then Height := FDefImage.Height;
    end;
end;

procedure TbsSkinXFormButton.DrawDefaultButton;
var
  IsDown: Boolean;
  R: TRect;
begin
  with C do
  begin
    R := ClientRect;
    Font.Assign(FDefaultFont);
    if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
    then
      Font.Charset := SkinData.ResourceStrData.CharSet
    else
      Font.Charset := FDefaultFont.CharSet;

    IsDown := FDown and (((FMouseIn or (IsFocused and not FMouseDown)) and
             (GroupIndex = 0)) or (GroupIndex  <> 0));
    if IsDown and not FDefDownImage.Empty
    then
      Draw(0, 0, FDefDownImage)
    else
    if (FMouseIn or IsFocused) and not FDefActiveImage.Empty
    then
      Draw(0, 0, FDefActiveImage)
    else
      Draw(0, 0, FDefImage);
    if IsDown
    then
      Font.Color := FDefDownFontColor
    else
    if FMouseIn or IsFocused
    then
      Font.Color := FDefActiveFontColor;
    DrawGlyphAndText(C, ClientRect, FMargin, FSpacing, FLayout,
     Caption, FGlyph, FNumGlyphs, GetGlyphNum(FDown, FMouseIn), IsDown, False, 0);
  end;
end;

procedure TbsSkinXFormButton.CreateControlDefaultImage;
begin
  if (FIndex = -1) and not FDefImage.Empty
  then
    DrawDefaultButton(B.Canvas)
  else
    inherited;
end;

procedure TbsSkinXFormButton.ChangeSkinData;
begin
  GetSkinData;
  if (FIndex = -1) and not FDefImage.Empty
  then
    begin
      Width := FDefImage.Width;
      Height := FDEfImage.Width;
      SetControlRegion;
      RePaint;
    end
  else
    inherited;  
end;

procedure TbsSkinXFormButton.SetDefImage(Value: TBitMap);
begin
  FDefImage.Assign(Value);
  if not FDefImage.Empty
  then
    begin
      DefaultHeight := FDefImage.Height;
      DefaultWidth := FDefImage.Width;
    end;
end;

procedure TbsSkinXFormButton.SetDefActiveImage(Value: TBitMap);
begin
  FDefActiveImage.Assign(Value);
end;

procedure TbsSkinXFormButton.SetDefDownImage(Value: TBitMap);
begin
  FDefDownImage.Assign(Value);
end;

procedure TbsSkinXFormButton.SetDefMask(Value: TBitMap);
begin
  FDefMask.Assign(Value);
  if not FDefImage.Empty
  then
    SetControlRegion;
end;

procedure TbsSkinXFormButton.Loaded;
begin
  inherited;
  if (FIndex = -1) and (FDefMask <> nil) and not FDefMask.Empty
  then
    SetControlRegion;
end;

{TbsSkinScrollPanel}

constructor TbsSkinScrollPanel.Create;
begin
  inherited;
  FClicksDisabled := False;
  FCanFocused := False;
  FHotScroll := False;
  TimerMode := 0;
  PanelData := nil;
  ButtonData := nil;
  ControlStyle := ControlStyle + [csAcceptsControls];
  FScrollOffset := 0;
  FScrollTimerInterval := 50;
  Width := 150;
  Height := 30;
  FIndex := -1;
  Buttons[0].Visible := False;
  Buttons[1].Visible := False;
  FVSizeOffset := 0;
  FHSizeOffset := 0;
  SMax := 0;
  SPosition := 0;
  SOldPosition := 0;
  SPage := 0;
  FAutoSize := False;
  FSkinDataName := 'panel';
end;

procedure TbsSkinScrollPanel.CMBENCPAINT;
var
  C: TCanvas;
begin
  if (Message.LParam = BE_ID)
  then
    begin
      if (Message.wParam <> 0) and (Buttons[0].Visible or Buttons[1].Visible)
      then
        begin
          C := TControlCanvas.Create;
          C.Handle := Message.wParam;
          if Buttons[0].Visible then DrawButton(C, 0);
          if Buttons[1].Visible then DrawButton(C, 1);
          C.Handle := 0;
          C.Free;
        end;
      Message.Result := BE_ID;
    end
  else
    inherited;
end;

procedure TbsSkinScrollPanel.WMSETCURSOR(var Message: TWMSetCursor);
begin
  if (Message.HitTest = HTBUTTON1) or
     (Message.HitTest = HTBUTTON2)
  then
    begin
      Message.HitTest :=  HTCLIENT;
    end;
  inherited;
end;

procedure TbsSkinScrollPanel.SetPosition(const Value: integer);
begin
  if Value <> SPosition
  then
    begin
      SPosition := Value;
      GetScrollInfo;
    end;
end;

procedure TbsSkinScrollPanel.WMMOUSEWHEEL;
begin
  if Focused and FCanFocused
  then
    if Message.WParam > 0
    then
      ButtonClick(0)
    else
      ButtonClick(1);
end;

procedure TbsSkinScrollPanel.KeyDown;
begin
  inherited KeyDown(Key, Shift);
  if FCanFocused then
  case Key of
    VK_UP, VK_LEFT: ButtonClick(0);
    VK_DOWN, VK_RIGHT: ButtonClick(1);
  end;
end;

procedure TbsSkinScrollPanel.CMWantSpecialKey(var Msg: TCMWantSpecialKey);
begin
  inherited;
  if FCanFocused then
  case Msg.CharCode of
    VK_UP, VK_DOWN, VK_LEFT, VK_RIGHT: Msg.Result := 1;
  end;
end;

procedure TbsSkinScrollPanel.Loaded;
begin
  inherited Loaded;
  if FAutoSize then UpDateSize;
end;

procedure TbsSkinScrollPanel.GetSkinData;
var
  CIndex: Integer;
begin
  PanelData := nil;
  ButtonData := nil;
  if (FSD = nil) or FSD.Empty then Exit;
  CIndex := FSD.GetControlIndex(FSkinDataName);
  if CIndex <> -1
  then
    PanelData := TbsDataSkinPanelControl(FSD.CtrlList[CIndex]);
  CIndex := FSD.GetControlIndex('resizebutton');
  if CIndex <> -1
  then
    ButtonData := TbsDataSkinButtonControl(FSD.CtrlList[CIndex]);
end;

destructor TbsSkinScrollPanel.Destroy;
begin
  inherited;
end;

procedure TbsSkinScrollPanel.UpDateSize;
begin
  SetBounds(Left, Top, Width, Height);
end;

procedure TbsSkinScrollPanel.StartTimer;
begin
  KillTimer(Handle, 1);
  SetTimer(Handle, 1, Self.ScrollTimerInterval, nil);
end;

procedure TbsSkinScrollPanel.StopTimer;
begin
  KillTimer(Handle, 1);
  TimerMode := 0;
end;

procedure TbsSkinScrollPanel.WMTimer;
begin
  inherited;
  case TimerMode of
    1: ButtonClick(0);
    2: ButtonClick(1);
  end;    
end;

procedure TbsSkinScrollPanel.AdjustClientRect(var Rect: TRect);
var
  RLeft, RTop, VMax, HMax: Integer;
begin
  case FScrollType of
    stHorizontal:
      begin
        RTop := 0;
        RLeft := - SPosition;
        HMax := Max(SMax, ClientWidth);
        VMax := ClientHeight;
      end;
    stVertical:
      begin
        RLeft := 0;
        RTop := - SPosition;
        VMax := Max(SMax, ClientHeight);
        HMax := ClientWidth;
      end;
  end;
  Rect := Bounds(RLeft, RTop,  HMax, VMax);
  inherited AdjustClientRect(Rect);
end;

procedure TbsSkinScrollPanel.VScrollControls(AOffset: Integer);
begin
  ScrollBy(0, -AOffset);
end;

procedure TbsSkinScrollPanel.HScrollControls(AOffset: Integer);
begin
  ScrollBy(-AOffset, 0);
end;

procedure TbsSkinScrollPanel.SetBounds;
var
  i, MaxHeight, MaxWidth, OldHeight, OldWidth: Integer;
begin
  OldWidth := Width;
  OldHeight := Height;
  if FAutoSize
  then
    if FScrollType = stHorizontal
    then
      begin
        MaxHeight := 0;
        if ControlCount > 0
        then
          for i := 0 to ControlCount - 1 do
          with Controls[i] do
          begin
            if Visible
            then
            if Top + Height > MaxHeight then MaxHeight := Top + Height;
          end;
        if MaxHeight <> 0 then AHeight := MaxHeight;
      end
    else
      begin
        MaxWidth := 0;
        if ControlCount > 0
        then
          for i := 0 to ControlCount - 1 do
          with Controls[i] do
          begin
            if Visible
            then
            if Left + Width > MaxWidth then MaxWidth := Left + Width;
          end;
        if MaxWidth <> 0 then AWidth := MaxWidth;
      end;
  inherited;
  if (OldWidth <> Width)
  then
    begin
      if (OldWidth < Width) and (OldWidth <> 0)
      then FHSizeOffset := Width - OldWidth
      else FHSizeOffset := 0;
    end
  else
    FHSizeOffset := 0;
  if (OldHeight <> Height)
  then
    begin
      if (OldHeight < Height) and (OldHeight <> 0)
      then FVSizeOffset := Height - OldHeight
      else FVSizeOffset := 0;
    end
  else
    FVSizeOffset := 0;
  if Align <> alNone then GetScrollInfo;
end;

procedure TbsSkinScrollPanel.GetHRange;
var
  i, FMax, W, MaxRight, Offset: Integer;
begin
  MaxRight := 0;
  if ControlCount > 0
  then
  for i := 0 to ControlCount - 1 do
  with Controls[i] do
  begin
   if Visible
   then
     if Left + Width > MaxRight then MaxRight := left + Width;
  end;
  if MaxRight = 0
  then
    begin
      if Buttons[1].Visible then SetButtonsVisible(False);
      Exit;
    end;
  W := ClientWidth;
  FMax := MaxRight + SPosition;
  if (FMax > W)
  then
    begin
      if not Buttons[1].Visible then  SetButtonsVisible(True);
      if (SPosition > 0) and (MaxRight < W) and (FHSizeOffset > 0)
      then
        begin
          if FHSizeOffset > SPosition then FHSizeOffset := SPosition;
          SMax := FMax - 1;
          SPosition := SPosition - FHSizeOffset;
          SPage := W;
          HScrollControls(-FHSizeOffset);
          SOldPosition := SPosition;
        end
     else
       begin
         if (FHSizeOffset = 0) and ((FMax - 1) < SMax) and (SPosition > 0) and
            (MaxRight < W)
         then
           begin
             SMax := FMax - 1;
             SPosition := SPosition - (W - MaxRight);
             SPage := W;
             HScrollControls(MaxRight - W);
             FHSizeOffset := 0;
             SOldPosition := SPosition;
           end
         else
           begin
             SMax := FMax - 1;
             SPage := W;
           end;
          FHSizeOffset := 0;
          SOldPosition := SPosition;
        end;
    end
  else
    begin
      if SPosition > 0 then HScrollControls(-SPosition);
      FHSizeOffset := 0;
      SMax := 0;
      SPosition := 0;
      SPage := 0;
      if Buttons[1].Visible then SetButtonsVisible(False);
   end;
end;

procedure TbsSkinScrollPanel.GetVRange;
var
  i, MaxBottom, H, Offset: Integer;
  FMax: Integer;
begin
  MaxBottom := 0;
  if ControlCount > 0
  then
    for i := 0 to ControlCount - 1 do
    with Controls[i] do
    begin
      if Visible
      then
        if Top + Height > MaxBottom then MaxBottom := Top + Height;
    end;
  if MaxBottom = 0
  then
    begin
      if Buttons[1].Visible then SetButtonsVisible(False);
      Exit;
    end;
  H := ClientHeight;
  FMax := MaxBottom + SPosition;
  if FMax > H
  then
    begin
      if not Buttons[1].Visible then SetButtonsVisible(True);

      if (SPosition > 0) and (MaxBottom < H) and (FVSizeOffset > 0)
      then
        begin
          if FVSizeOffset > SPosition then FVSizeOffset := SPosition;
          SMax := FMax - 1;
          SPosition := SPosition - FVSizeOffset;
          SPage := H;
          VScrollControls(- FVSizeOffset);
          FVSizeOffset := 0;
          SOldPosition := SPosition;
        end
      else
        begin
          if (FVSizeOffset = 0) and ((FMax - 1) < SMax) and (SPosition > 0) and
             (MaxBottom < H)
            then
              begin
                SMax := FMax - 1;
                SPosition := SPosition - (H - MaxBottom);
                SPage := H;
                VScrollControls(MaxBottom - H);
                FVSizeOffset := 0;
                SOldPosition := SPosition;
              end
            else
              begin
                SMax := FMax - 1;
                SPage := H;
              end;
          FVSizeOffset := 0;
          SOldPosition := SPosition;
        end;
    end
   else
     begin
       if SPosition > 0 then VScrollControls(-SPosition);
       FVSizeOffset := 0;
       SOldPosition := 0;
       SMax := 0;
       SPage := 0;
       SPosition := 0;
       if Buttons[1].Visible then SetButtonsVisible(False);
     end;
end;

procedure TbsSkinScrollPanel.GetScrollInfo;
begin
  if FScrollType = stHorizontal
  then
    GetHRange
  else
    GetVRange;
end;

procedure TbsSkinScrollPanel.SetButtonsVisible;
begin
  if Buttons[0].Visible <> AVisible
  then
    begin
      Buttons[0].Visible := AVisible;
      Buttons[1].Visible := AVisible;
      if not (Parent is TbsSkinCoolBar)
      then
        begin
          ReCreateWnd;
          HandleNeeded;
        end;
    end;
end;

procedure TbsSkinScrollPanel.ButtonDown(I: Integer);
begin
  case I of
    0:
      begin
        TimerMode := 1;
        StartTimer;
      end;
    1:
      begin
        TimerMode := 2;
        StartTimer;
      end;
  end;
end;

procedure TbsSkinScrollPanel.ButtonUp(I: Integer);
begin
  case I of
    0:
      begin
        StopTimer;
        TimerMode := 0;
        ButtonClick(0);
      end;
    1:
      begin
        StopTimer;
        TimerMode := 0;
        ButtonClick(1);
      end;
  end;
end;

procedure TbsSkinScrollPanel.ButtonClick;
var
  SOffset: Integer;
begin
  if FScrollOffset = 0
  then
    SOffset := ClientWidth
  else
    SOffset := FScrollOffset;
  case I of
    0:
      if FScrollType = stHorizontal
      then
        begin
          SPosition := SPosition - SOffset;
          if SPosition < 0 then SPosition := 0;
          if (SPosition - SOldPosition <> 0)
          then
            HScrollControls(SPosition - SOldPosition)
          else
            StopTimer;
        end
      else
        begin
          SPosition := SPosition - SOffset;
          if SPosition < 0 then SPosition := 0;
          if (SPosition - SOldPosition <> 0)
          then
            VScrollControls(SPosition - SOldPosition)
          else
            StopTimer;
        end;
    1:
      if FScrollType = stHorizontal
      then
        begin
          SPosition := SPosition + SOffset;
          if SPosition > SMax - SPage + 1 then SPosition := SMax - SPage + 1;
          if (SPosition - SOldPosition <> 0)
          then
            HScrollControls(SPosition - SOldPosition)
          else
            StopTimer;
        end
      else
        begin
          SPosition := SPosition + SOffset;
          if SPosition > SMax - SPage + 1 then SPosition := SMax - SPage + 1;
          if (SPosition - SOldPosition <> 0)
          then
            VScrollControls(SPosition - SOldPosition)
          else
            StopTimer;
        end;
  end;
end;

procedure TbsSkinScrollPanel.CMMOUSELEAVE;
var
  P: TPoint;
begin
  inherited;
  if (csDesigning in ComponentState) then Exit;
  GetCursorPos(P);
  if WindowFromPoint(P) <> Handle
  then
    if Buttons[0].MouseIn and Buttons[0].Visible
    then
      begin
        if TimerMode <> 0 then StopTimer;
        Buttons[0].MouseIn := False;
        SendMessage(Handle, WM_NCPAINT, 0, 0);
      end
    else
      if Buttons[1].MouseIn and Buttons[1].Visible
      then
        begin
          if TimerMode <> 0 then StopTimer;
          Buttons[1].MouseIn := False;
          SendMessage(Handle, WM_NCPAINT, 0, 0);
        end;
end;

procedure TbsSkinScrollPanel.WndProc;
var
  B: Boolean;
  P: TPoint;
begin

  B := True;
  case Message.Msg of
    WM_WINDOWPOSCHANGING:
      if Self.HandleAllocated and (Align = alNone)
      then
        GetScrollInfo;
    WM_NCHITTEST:
      if not (csDesigning in ComponentState) then
      begin
        P.X := LoWord(Message.lParam);
        P.Y := HiWord(Message.lParam);
        P := ScreenToClient(P);
        if (((FScrollType = stVertical) and (P.Y < 0)) or
           ((FScrollType = stHorizontal) and (P.X < 0))) and Buttons[0].Visible
        then
          begin
            Message.Result := HTBUTTON1;
            B := False;
          end
        else
        if (((FScrollType = stVertical) and (P.Y > ClientHeight)) or
           ((FScrollType = stHorizontal) and (P.X > ClientWidth))) and Buttons[1].Visible
        then
          begin
            Message.Result := HTBUTTON2;
            B := False;
          end;
      end;

    WM_LBUTTONDOWN, WM_LBUTTONDBLCLK:
    begin
      if FCanFocused and not (csDesigning in ComponentState) and not Focused
      then
        begin
          FClicksDisabled := True;
          Windows.SetFocus(Handle);
          FClicksDisabled := False;
          if not Focused then Exit;
        end;
    end;

    WM_NCLBUTTONDOWN, WM_NCLBUTTONDBLCLK:
       begin
         if Message.wParam = HTBUTTON1
         then
           begin
             Buttons[0].Down := True;
             SendMessage(Handle, WM_NCPAINT, 0, 0);
             ButtonDown(0);
           end
         else
         if Message.wParam = HTBUTTON2
         then
           begin
             Buttons[1].Down := True;
             SendMessage(Handle, WM_NCPAINT, 0, 0);
             ButtonDown(1);
           end;

         if FCanFocused and not (csDesigning in ComponentState) and not Focused
         then
           begin
             FClicksDisabled := True;
             Windows.SetFocus(Handle);
             FClicksDisabled := False;
             if not Focused then Exit;
           end;

       end;

    WM_NCLBUTTONUP:
       begin
         if Message.wParam = HTBUTTON1
         then
           begin
             Buttons[0].Down := False;
             SendMessage(Handle, WM_NCPAINT, 0, 0);
             ButtonUp(0);
           end
         else
         if Message.wParam = HTBUTTON2
         then
           begin
             Buttons[1].Down := False;
             SendMessage(Handle, WM_NCPAINT, 0, 0);
             ButtonUp(1);
           end;
       end;

     WM_NCMOUSEMOVE:
       begin
         if (Message.wParam = HTBUTTON1) and (not Buttons[0].MouseIn)
         then
           begin
             Buttons[0].MouseIn := True;
             Buttons[1].MouseIn := False;
             SendMessage(Handle, WM_NCPAINT, 0, 0);
             if FHotScroll
             then
               begin
                 TimerMode := 1;
                 StartTimer;
               end;
           end
         else
         if (Message.wParam = HTBUTTON2) and (not Buttons[1].MouseIn)
         then
           begin
             Buttons[1].MouseIn := True;
             Buttons[0].MouseIn := False;
             SendMessage(Handle, WM_NCPAINT, 0, 0);
             if FHotScroll
             then
               begin
                 TimerMode := 2;
                 StartTimer;
               end;
           end;
       end;

    WM_MOUSEMOVE:
      begin
        if Buttons[0].MouseIn and Buttons[0].Visible
        then
          begin
            if TimerMode <> 0 then StopTimer;
            Buttons[0].MouseIn := False;
            SendMessage(Handle, WM_NCPAINT, 0, 0);
          end
        else
        if Buttons[1].MouseIn and Buttons[1].Visible
        then
          begin
            if TimerMode <> 0 then StopTimer;
            Buttons[1].MouseIn := False;
            SendMessage(Handle, WM_NCPAINT, 0, 0);
          end;
      end;
    CN_COMMAND:
      if FClicksDisabled then Exit;
  end;
  if B then inherited;
end;

procedure TbsSkinScrollPanel.Paint;
var
  X, Y, XCnt, YCnt, w, h,
  rw, rh, XO, YO: Integer;
  Buffer: TBitMap;
  B, FSkinPicture: TBitMap;
begin
  GetSkinData;
  if PanelData = nil
  then
    begin
      inherited;
      Exit;
    end;

  FSkinPicture := TBitMap(FSD.FActivePictures.Items[PanelData.PictureIndex]);

  if (ClientWidth > 0) and (ClientHeight > 0)
  then
    with PanelData do
    begin
      Buffer := TBitMap.Create;
      Buffer.Width := ClientWidth;
      Buffer.Height := ClientHeight;

      if BGPictureIndex = -1
      then
        begin
          w := RectWidth(ClRect);
          h := RectHeight(ClRect);
          rw := Buffer.Width;
          rh := Buffer.Height;
          with Buffer.Canvas do
          begin
            XCnt := rw div w;
            YCnt := rh div h;
            for X := 0 to XCnt do
            for Y := 0 to YCnt do
            begin
              if X * w + w > rw then XO := X * W + W - rw else XO := 0;
              if Y * h + h > rh then YO := Y * h + h - rh else YO := 0;
                CopyRect(Rect(X * w, Y * h,X * w + w - XO, Y * h + h - YO),
                   FSkinPicture.Canvas,
                   Rect(SkinRect.Left + ClRect.Left,
                        SkinRect.Top + ClRect.Top,
                        SkinRect.Left + ClRect.Right - XO,
                         SkinRect.Top + ClRect.Bottom - YO));
            end;
          end;
        end
      else
        begin
          B := TBitMap(FSD.FActivePictures.Items[BGPictureIndex]);
          XCnt := Width div B.Width;
          YCnt := Height div B.Height;
          for X := 0 to XCnt do
          for Y := 0 to YCnt do
            Buffer.Canvas.Draw(X * B.Width, Y * B.Height, B);
        end;
      Canvas.Draw(0, 0, Buffer);
      Buffer.Free;
    end;
end;

procedure TbsSkinScrollPanel.SetScrollOffset;
begin
  if Value >= 0 then FScrollOffset := Value;
end;

procedure TbsSkinScrollPanel.SetScrollType(Value: TbsScrollType);
begin
  if FScrollType <> Value
  then
    begin
      FScrollType := Value;
      SMax := 0;
      SPosition := 0;
      SOldPosition := 0;
      SPage := 0;
      Buttons[0].Visible := False;
      Buttons[1].Visible := False;
      ReCreateWnd;
    end;  
end;

procedure TbsSkinScrollPanel.CreateControlDefaultImage(B: TBitMap);
begin
  with B.Canvas do
  begin
    Brush.Color := clBtnFace;
    FillRect(ClientRect);
  end;
end;

procedure TbsSkinScrollPanel.CreateControlSkinImage(B: TBitMap);
begin
  with B.Canvas do
  begin
    Brush.Color := clBtnFace;
    FillRect(ClientRect);
  end;
end;

procedure TbsSkinScrollPanel.WMNCCALCSIZE;
begin
  GetSkinData;
  with TWMNCCALCSIZE(Message).CalcSize_Params^.rgrc[0] do
  begin
    if FScrollType = stHorizontal
    then
      begin
        if Buttons[0].Visible then Inc(Left, ButtonSize);
        if Buttons[1].Visible then Dec(Right, ButtonSize);
      end
    else
      begin
        if Buttons[0].Visible then Inc(Top, ButtonSize);
        if Buttons[1].Visible then Dec(Bottom, ButtonSize);
      end;
  end;
end;

procedure TbsSkinScrollPanel.WMNCPaint;
var
  Cnvs: TCanvas;
  DC: HDC;
begin
  if Buttons[0].Visible or Buttons[1].Visible
  then
    begin
      DC := GetWindowDC(Handle);
      Cnvs := TCanvas.Create;
      Cnvs.Handle := DC;
      if Buttons[0].Visible then DrawButton(Cnvs, 0);
      if Buttons[1].Visible then DrawButton(Cnvs, 1);
      Cnvs.Handle := 0;
      ReleaseDC(Handle, DC);
      Cnvs.Free;
    end;
end;

procedure TbsSkinScrollPanel.WMSIZE;
begin
  inherited;
  if ScrollType = stHorizontal
  then
    begin
      Buttons[0].R := Rect(0, 0, ButtonSize, Height);
      Buttons[1].R := Rect(Width - ButtonSize, 0, Width, Height);
    end
  else
    begin
      Buttons[0].R := Rect(0, 0, Width, ButtonSize);
      Buttons[1].R := Rect(0, Height - ButtonSize, Width, Height);
    end;
  SendMessage(Handle, WM_NCPAINT, 0, 0);
end;

procedure TbsSkinScrollPanel.SetScrollTimerInterval;
begin
  if Value > 0 then FScrollTimerInterval := Value;
end;

procedure TbsSkinScrollPanel.DrawButton;
var
  B: TBitMap;
  R, NewCLRect: TRect;
  FSkinPicture: TBitMap;
  NewLtPoint, NewRTPoint, NewLBPoint, NewRBPoint: TPoint;
  XO, YO: Integer;
  C: TColor;
begin
  B := TBitMap.Create;
  B.Width := RectWidth(Buttons[i].R);
  B.Height := RectHeight(Buttons[i].R);
  R := Rect(0, 0, B.Width, B.Height);
  GetSkinData;
  if ButtonData = nil
  then
    begin
      C := clBtnText;
      if ((Buttons[I].Down and Buttons[I].MouseIn)) or
          (Buttons[I].MouseIn and HotScroll)
      then
        begin
          Frame3D(B.Canvas, R, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
          B.Canvas.Brush.Color := BS_XP_BTNDOWNCOLOR;
          B.Canvas.FillRect(R);
        end
      else
      if Buttons[I].MouseIn
      then
        begin
          Frame3D(B.Canvas, R, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
          B.Canvas.Brush.Color := BS_XP_BTNACTIVECOLOR;
          B.Canvas.FillRect(R);
        end
      else
        begin
          Frame3D(B.Canvas, R, clBtnShadow, clBtnShadow, 1);
          B.Canvas.Brush.Color := clBtnFace;
          B.Canvas.FillRect(R);
        end;
    end
  else
    with ButtonData, Buttons[I] do
    begin
      //
      XO := RectWidth(R) - RectWidth(SkinRect);
      YO := RectHeight(R) - RectHeight(SkinRect);
      NewLTPoint := LTPoint;
      NewRTPoint := Point(RTPoint.X + XO, RTPoint.Y);
      NewLBPoint := Point(LBPoint.X, LBPoint.Y + YO);
      NewRBPoint := Point(RBPoint.X + XO, RBPoint.Y + YO);
      NewClRect := Rect(CLRect.Left, ClRect.Top,
        CLRect.Right + XO, ClRect.Bottom + YO);
      FSkinPicture := TBitMap(FSD.FActivePictures.Items[ButtonData.PictureIndex]);
      //
      if (Down and not IsNullRect(DownSkinRect) and MouseIn) or
         (MouseIn and HotScroll and not IsNullRect(DownSkinRect))
      then
        begin
          CreateSkinImage(LTPoint, RTPoint, LBPoint, RBPoint, CLRect,
          NewLtPoint, NewRTPoint, NewLBPoint, NewRBPoint, NewCLRect,
          B, FSkinPicture, DownSkinRect, B.Width, B.Height, True,
          LeftStretch, TopStretch, RightStretch, BottomStretch,
          StretchEffect);
          C := DownFontColor;
        end
      else
      if MouseIn and not IsNullRect(ActiveSkinRect)
      then
        begin
          CreateSkinImage(LTPoint, RTPoint, LBPoint, RBPoint, CLRect,
          NewLtPoint, NewRTPoint, NewLBPoint, NewRBPoint, NewCLRect,
          B, FSkinPicture, ActiveSkinRect, B.Width, B.Height, True,
          LeftStretch, TopStretch, RightStretch, BottomStretch,
          StretchEffect);
          C := ActiveFontColor;
        end
      else
        begin
          CreateSkinImage(LTPoint, RTPoint, LBPoint, RBPoint, CLRect,
          NewLtPoint, NewRTPoint, NewLBPoint, NewRBPoint, NewCLRect,
          B, FSkinPicture, SkinRect, B.Width, B.Height, True,
          LeftStretch, TopStretch, RightStretch, BottomStretch,
          StretchEffect);
          C := FontColor;
        end;
   end;
  //
  if FScrollType = stHorizontal
  then
    begin
      case I of
        0: DrawArrowImage(B.Canvas, R, C, 1);
        1: DrawArrowImage(B.Canvas, R, C, 2);
      end;
    end
  else
    begin
      case I of
        0: DrawArrowImage(B.Canvas, R, C, 3);
        1: DrawArrowImage(B.Canvas, R, C, 4);
      end;
    end;
  //
  Cnvs.Draw(Buttons[I].R.Left, Buttons[I].R.Top, B);
  B.Free;
end;

// TbsSkinCoolBar

const
  GripSizeIE3 = 8;
  GripSizeIE4 = 5;
  ControlMargin = 4;
  BandBorderSize = 2;
  IDMask = $7FFFFFFF;

constructor TbsSkinCoolBar.Create(AOwner: TComponent);
begin
  inherited;
  FSkinPicture := nil;
  FIndex := -1;
  FSkinDataName := 'controlbar';
  FSkinBevel := True;
end;

destructor TbsSkinCoolBar.Destroy;
begin
  inherited;
end;


function TbsSkinCoolBar.GetCaptionFontHeight: Integer;
var
  TxtMetric: TTextMetric;
begin
  Result := 0;
  if HandleAllocated then
    with TControlCanvas.Create do
    try
      Control := Self;
      Font := Self.Font;
      if (GetTextMetrics(Handle, TxtMetric)) then
        Result := TxtMetric.tmHeight;
    finally
      Free;
    end;
end;

function TbsSkinCoolBar.GetCaptionSize(Band: TCoolBand): Integer;
var
  Text: string;
  Adjust, DesignText: Boolean;
begin
  Result := 0;
  Adjust := False;
  if (Band <> nil) and ((csDesigning in ComponentState) or Band.Visible) then
  begin
    DesignText := (csDesigning in ComponentState) and
      (Band.Control = nil) and (Band.Text = '');
    if ShowText or DesignText then
    begin
      if DesignText then
        Text := Band.DisplayName
      else
        Text := Band.Text;
      if Text <> '' then
      begin
        Adjust := True;
        if Vertical then
          Result := GetCaptionFontHeight
        else
          with TControlCanvas.Create do
          try
            Control := Self;
            Font := Self.Font;
            Result := TextWidth(Text)
          finally
            Free;
          end;
      end;
    end;
    if Band.ImageIndex >= 0 then
    begin
      if Adjust then Inc(Result, 2);
      if Images <> nil then
      begin
        Adjust := True;
        if Vertical then
          Inc(Result, Images.Height)
        else
          Inc(Result, Images.Width)
      end
      else if not Adjust then
        Inc(Result, ControlMargin);
    end;
    if Adjust then Inc(Result, ControlMargin);
    if (not FixedOrder or (Band.ID and IDMask > 0)) and not Band.FixedSize then
    begin
      Inc(Result, ControlMargin);
      if GetComCtlVersion < ComCtlVersionIE4 then
        Inc(Result, GripSizeIE3)
      else
        Inc(Result, GripSizeIE4);
    end;
  end;
end;

procedure TbsSkinCoolBar.CMBENCPAINT;
var
  C: TCanvas;
begin
  if (Message.LParam = BE_ID)
  then
    begin
      if (Message.wParam <> 0) and FSkinBevel
      then
        begin
          C := TControlCanvas.Create;
          C.Handle := Message.wParam;
          PaintNCSkin(0, False);
          C.Handle := 0;
          C.Free;
        end;
      Message.Result := BE_ID;
    end
  else
    inherited;
end;

procedure TbsSkinCoolBar.Notification;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FSD) then FSD := nil;
end;

procedure TbsSkinCoolBar.AlignControls(AControl: TControl; var Rect: TRect);
var
  i: Integer;
begin
  inherited;
  for i := 0 to ControlCount - 1 do
  begin
    Controls[i].Invalidate;
  end;
end;

procedure TbsSkinCoolBar.WMSIZE;
var
  i: Integer;
begin
  inherited;
  GetSkinData;
  if (FIndex <> -1) and FSkinBevel then PaintNCSkin(0, False);
end;

procedure TbsSkinCoolBar.SetSkinBevel;
begin
  FSkinBevel := Value;
  if FIndex <> -1 then RecreateWnd;
end;

procedure TbsSkinCoolBar.PaintNCSkin;
var
  LeftBitMap, TopBitMap, RightBitMap, BottomBitMap: TBitMap;
  DC: HDC;
  Cnvs: TControlCanvas;
  OX, OY: Integer;
begin
  if not AUseExternalDC then  DC := GetWindowDC(Handle) else DC := ADC;
  Cnvs := TControlCanvas.Create;
  Cnvs.Handle := DC;
  LeftBitMap := TBitMap.Create;
  TopBitMap := TBitMap.Create;
  RightBitMap := TBitMap.Create;
  BottomBitMap := TBitMap.Create;
  //
  OX := Width - RectWidth(SkinRect);
  OY := Height - RectHeight(SkinRect);
  NewLTPoint := LTPt;
  NewRTPoint := Point(RTPt.X + OX, RTPt.Y);
  NewLBPoint := Point(LBPt.X, LBPt.Y + OY);
  NewRBPoint := Point(RBPt.X + OX, RBPt.Y + OY);
  NewClRect := Rect(ClRect.Left, ClRect.Top,
    ClRect.Right + OX, ClRect.Bottom + OY);
  //
  CreateSkinBorderImages(LTPt, RTPt, LBPt, RBPt, ClRect,
      NewLTPoint, NewRTPoint, NewLBPoint, NewRBPoint, NewCLRect,
      LeftBitMap, TopBitMap, RightBitMap, BottomBitMap,
      FSkinPicture, SkinRect, Width, Height, LeftStretch, TopStretch, RightStretch, BottomStretch);

  if NewClRect.Bottom > NewClRect.Top
  then
    ExcludeClipRect(Cnvs.Handle,
      NewClRect.Left, NewClRect.Top, NewClRect.Right, NewClRect.Bottom);

  Cnvs.Draw(0, 0, TopBitMap);
  Cnvs.Draw(0, TopBitMap.Height, LeftBitMap);
  Cnvs.Draw(Width - RightBitMap.Width, TopBitMap.Height, RightBitMap);
  Cnvs.Draw(0, Height - BottomBitMap.Height, BottomBitMap);
  //
  TopBitMap.Free;
  LeftBitMap.Free;
  RightBitMap.Free;
  BottomBitMap.Free;
  Cnvs.Handle := 0;
  if not AUseExternalDC then ReleaseDC(Handle, DC);
  Cnvs.Free;
end;

procedure TbsSkinCoolBar.GetSkinData;
begin
  if (FSD = nil) or FSD.Empty
  then
    FIndex := -1
  else
    FIndex := FSD.GetControlIndex(FSkinDataName);
  BGPictureIndex := -1;
  FSkinPicture := nil;
  if FIndex <> -1
  then
    if TbsDataSkinControl(FSD.CtrlList.Items[FIndex]) is TbsDataSkinControlBar
    then
      with TbsDataSkinControlBar(FSD.CtrlList.Items[FIndex]) do
      begin
        LTPt := LTPoint;
        RTPt := RTPoint;
        LBPt := LBPoint;
        RBPt := RBPoint;
        Self.SkinRect := SkinRect;
        Self.ClRect := ClRect;
        if (PictureIndex <> -1) and (PictureIndex < FSD.FActivePictures.Count)
        then
          FSkinPicture := TBitMap(FSD.FActivePictures.Items[PictureIndex])
        else
          FSkinPicture := nil;
        Self.ItemRect := ItemRect;
        Self.BGPictureIndex := BGPictureIndex;
        Self.HGripRect := HGripRect;
        Self.GripOffset1 := GripOffset1;
        Self.VGripRect := VGripRect;
        Self.GripOffset2 := GripOffset2;
        Self.LeftStretch := LeftStretch;
        Self.TopStretch := TopStretch;
        Self.RightStretch := RightStretch;
        Self.BottomStretch := BottomStretch;
      end;
end;

procedure TbsSkinCoolBar.ChangeSkinData;
begin
  GetSkinData;
  ReCreateWnd;
end;

procedure TbsSkinCoolBar.SetSkinData;
begin
  FSD := Value;
  ChangeSkinData;
end;

procedure TbsSkinCoolBar.WMNCCALCSIZE;
begin
  GetSkinData;
  if FIndex <> -1
  then
    begin
      if FSkinBevel then
      with TWMNCCALCSIZE(Message).CalcSize_Params^.rgrc[0] do
      begin
        Inc(Left, ClRect.Left);
        Inc(Top,  ClRect.Top);
        Dec(Right, RectWidth(SkinRect) - ClRect.Right);
        Dec(Bottom, RectHeight(SkinRect) - ClRect.Bottom);
        if Right < Left then Right := Left;
        if Bottom < Top
        then Bottom := Top;
      end;
    end
  else
    inherited;
end;

procedure TbsSkinCoolBar.WMNCPAINT(var Message: TMessage);
begin
  GetSkinData;
  if FIndex <> -1
  then
    begin
      if FSkinBevel then PaintNCSkin(0, False);
    end
  else
    inherited;
end;

procedure TbsSkinCoolBar.CreateParams;
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style and not WS_BORDER;
    ExStyle := ExStyle and not WS_EX_CLIENTEDGE;
  end;
end;

procedure TbsSkinCoolBar.DrawGrip(C: TCanvas; R: TRect);
var
  Buffer: TBitMap;
begin
  if IsNullRect(HGripRect) or IsNullRect(VGripRect)
  then
    begin
      if Vertical
      then
        begin
          Frm3D(C, Rect(R.Left, R.Top + 1, R.Right, R.Top + 3),
                FSD.SkinColors.cBtnHighLight,
                FSD.SkinColors.cBtnShadow);
          Frm3D(C, Rect(R.Left, R.Top + 3, R.Right, R.Top + 5),
                FSD.SkinColors.cBtnHighLight,
                FSD.SkinColors.cBtnShadow);
        end
      else
        begin
          Frm3D(C, Rect(R.Left + 1, R.Top, R.Left + 3, R.Bottom),
                FSD.SkinColors.cBtnHighLight,
                FSD.SkinColors.cBtnShadow);
          Frm3D(C, Rect(R.Left + 3, R.Top, R.Left + 5, R.Bottom),
                FSD.SkinColors.cBtnHighLight,
                FSD.SkinColors.cBtnShadow);
        end;
    end
  else
    if Vertical
    then
      begin
        Buffer := TBitMap.Create;
        Buffer.Width := RectWidth(R);
        Buffer.Height := RectHeight(HGripRect);
        CreateHSkinImage(GripOffset1, GripOffset2, Buffer, FSkinPicture, HGripRect,
        Buffer.Width, Buffer.Height, False);
        C.Draw(R.Left, R.Top, Buffer);
        Buffer.Free;
      end
    else
      begin
        Buffer := TBitMap.Create;
        Buffer.Height := RectHeight(R);
        Buffer.Width := RectWidth(VGripRect);
        CreateVSkinImage(GripOffset1, GripOffset2, Buffer, FSkinPicture, VGripRect,
        Buffer.Width, Buffer.Height, False);
        C.Draw(R.Left, R.Top, Buffer);
        Buffer.Free;
      end;
end;

procedure TbsSkinCoolBar.WMEraseBkgnd;
var
  FCanvas: TControlCanvas;
  DC: HDC;
  i: Integer;
  R: TRect;
  X, Y, XCnt, YCnt, w, h,
  rw, rh, XO, YO: Integer;
  Buffer: TBitMap;
  B: TBitMap;
begin
  GetSkinData;
  if FIndex = -1
  then
    begin
      inherited;
      Exit;
    end;
  FCanvas := TControlCanvas.Create;
  FCanvas.Control := Self;
  DC := Message.DC;
  FCanvas.Handle := DC;
  if (ClientWidth > 0) and (ClientHeight > 0)
  then
    begin
      Buffer := TBitMap.Create;
      Buffer.Width := ClientWidth;
      Buffer.Height := ClientHeight;

      if BGPictureIndex = -1
      then
        begin
          w := RectWidth(ClRect);
          h := RectHeight(ClRect);
          rw := Buffer.Width;
          rh := Buffer.Height;
          with Buffer.Canvas do
          begin
            XCnt := rw div w;
            YCnt := rh div h;
            for X := 0 to XCnt do
            for Y := 0 to YCnt do
            begin
              if X * w + w > rw then XO := X * W + W - rw else XO := 0;
              if Y * h + h > rh then YO := Y * h + h - rh else YO := 0;
                CopyRect(Rect(X * w, Y * h,X * w + w - XO, Y * h + h - YO),
                   FSkinPicture.Canvas,
                   Rect(SkinRect.Left + ClRect.Left,
                        SkinRect.Top + ClRect.Top,
                        SkinRect.Left + ClRect.Right - XO,
                         SkinRect.Top + ClRect.Bottom - YO));
            end;
          end;
        end
      else
        begin
          B := TBitMap(FSD.FActivePictures.Items[BGPictureIndex]);
          XCnt := Width div B.Width;
          YCnt := Height div B.Height;
          for X := 0 to XCnt do
          for Y := 0 to YCnt do
            Buffer.Canvas.Draw(X * B.Width, Y * B.Height, B);
        end;
     FCanvas.Draw(0, 0, Buffer);
     Buffer.Free;
   end;
  FCanvas.Handle := 0;
  FCanvas.Free;
end;

procedure TbsSkinCoolBar.WMPaint(var Message: TWMPaint);
var
  FCanvas: TControlCanvas;
  DC: HDC;
  PS: TPaintStruct;
  i: Integer;
  R, R1, TR: TRect;
  X, Y: Integer;
begin
  GetSkindata;
  if FIndex = -1
  then
    begin
      inherited;
      Exit;
    end;
  FCanvas := TControlCanvas.Create;
  FCanvas.Control := Self;
  DC := Message.DC;
  if DC = 0 then DC := BeginPaint(Handle, PS);
  FCanvas.Handle := DC;
  if Vertical
  then
  for i := 0 to Self.Bands.Count - 1 do
  begin
    R.Top := Bands[i].Control.Top - GetCaptionSize(Bands[i]);
    R.Left :=  Bands[i].Control.Left;
    R.Bottom := Bands[i].Control.Top;
    R.Right := R.Left + Bands[i].Control.Width;
    //
    R1.Top := R.Top + 1;
    R1.Bottom := R1.Top + 4;
    R1.Left := R.Left;
    R1.Right := R.Right;
    DrawGrip(FCanvas, R1);
    Y := R1.Bottom + 2;
    // draw glyph
    if (Images <> nil) and (Bands[i].ImageIndex >= 0) and (Bands[i].ImageIndex < Images.Count)
    then
      begin
        X := R1.Left + RectWidth(R1) div 2 - Images.Width div 2;
        Images.Draw(FCanvas, X, Y, Bands[i].ImageIndex, True);
        Y := Y + Images.Height + 1;
      end;
    // draw text
    if (Bands[i].Text <> '') and ShowText
    then
      begin
        FCanvas.Font := Self.Font;
        FCanvas.Font.Color := FSD.SkinColors.cBtnText;
        TR := Rect(R.Left, Y, R.Right, R.Bottom);
        DrawText(FCanvas.Handle, PChar(Bands[i].Text), Length(Bands[i].Text), TR,
        DT_VCENTER or DT_SINGLELINE or DT_CENTER);
      end;
  end
  else
  for i := 0 to Self.Bands.Count - 1 do
  begin
    R.Left := Bands[i].Control.Left - GetCaptionSize(Bands[i]);
    R.Top :=  Bands[i].Control.Top;
    R.Right := Bands[i].Control.Left;
    R.Bottom := R.Top + Bands[i].Control.Height;
    //
    R1.Left := R.Left + 1;
    R1.Right := R1.Left + 4;
    R1.Top := R.Top;
    R1.Bottom := R.Bottom;
    DrawGrip(FCanvas, R1);
    X := R1.Right + 2;
    // draw glyph
    if (Images <> nil) and (Bands[i].ImageIndex >= 0) and (Bands[i].ImageIndex < Images.Count)
    then
      begin
        Y := R1.Top + RectHeight(R1) div 2 - Images.Height div 2;
        Images.Draw(FCanvas, X, Y, Bands[i].ImageIndex, True);
        X := X + Images.Width + 1;
      end;
    // draw text
    if (Bands[i].Text <> '') and ShowText
    then
      begin
        FCanvas.Font := Self.Font;
        FCanvas.Font.Color := FSD.SkinColors.cBtnText;
        TR := Rect(X, R.Top, R.Right, R.Bottom);
        DrawText(FCanvas.Handle, PChar(Bands[i].Text), Length(Bands[i].Text), TR,
        DT_VCENTER or DT_SINGLELINE or DT_LEFT);
      end;
  end;
  FCanvas.Handle := 0;
  FCanvas.Free;
  if Message.DC = 0 then EndPaint(Handle, PS);
end;

// Graphic controls

constructor TbsSkinGraphicButton.Create(AOwner: TComponent);
begin
  inherited;
  Width := 65;
  FGraphicImages := TCustomImageList.Create(Self);
  FGraphicMenu := TbsSkinImagesMenu.Create(Self);
  FGraphicMenu.Images := FGraphicImages;
  SkinImagesMenu := FGraphicMenu;
  FUseImagesMenuImage := True;
  InitImages;
  InitItems;
end;

destructor TbsSkinGraphicButton.Destroy;
begin
  FGraphicImages.Clear;
  FGraphicImages.Free;
  FGraphicMenu.Free;
  inherited;
end;

procedure TbsSkinGraphicButton.Loaded;
begin
  inherited;
  SkinImagesMenu := FGraphicMenu;
  FGraphicMenu.Skindata := Self.SkinData;
end;

function TbsSkinGraphicButton.GetItemIndex: Integer;
begin
  Result := FGraphicMenu.ItemIndex;
end;

procedure TbsSkinGraphicButton.SetItemIndex(Value: Integer);
begin
  FGraphicMenu.ItemIndex := Value;
  RePaint;
end;

function TbsSkinGraphicButton.GetSelectedItem;
begin
  Result := FGraphicMenu.SelectedItem;
end;

function TbsSkinGraphicButton.GetMenuShowHints: Boolean;
begin
  Result := FGraphicMenu.ShowHints;
end;

procedure TbsSkinGraphicButton.SetMenuShowHints(Value: Boolean);
begin
  FGraphicMenu.ShowHints := Value;
end;

function TbsSkinGraphicButton.GetMenuSkinHint: TbsSkinHint;
begin
  Result := FGraphicMenu.SkinHint;
end;

procedure TbsSkinGraphicButton.SetMenuSkinHint(Value: TbsSkinHint);
begin
  FGraphicMenu.SkinHint := Value;
end;

procedure TbsSkinGraphicButton.InitImages;
begin
end;

procedure TbsSkinGraphicButton.InitItems;
begin
end;

function TbsSkinGraphicButton.GetGraphicMenuItems: TbsImagesMenuItems;
begin
  Result := FGraphicMenu.ImagesItems;
end;

function TbsSkinGraphicButton.GetMenuDefaultFont: TFont;
begin
  Result := FGraphicMenu.DefaultFont;
end;

procedure TbsSkinGraphicButton.SetMenuDefaultFont(Value: TFont);
begin
  FGraphicMenu.DefaultFont.Assign(Value);
end;

function TbsSkinGraphicButton.GetMenuUseSkinFont: Boolean;
begin
  Result := FGraphicMenu.UseSkinFont;
end;

procedure TbsSkinGraphicButton.SetMenuUseSkinFont(Value: Boolean);
begin
  FGraphicMenu.UseSkinFont := Value;
end;

function TbsSkinGraphicButton.GetMenuAlphaBlend: Boolean;
begin
   Result := FGraphicMenu.AlphaBlend;
end;

procedure TbsSkinGraphicButton.SetMenuAlphaBlend(Value: Boolean);
begin
  FGraphicMenu.AlphaBlend := Value;
end;

function TbsSkinGraphicButton.GetMenuAlphaBlendAnimation: Boolean;
begin
  Result := FGraphicMenu.AlphaBlendAnimation;
end;

procedure TbsSkinGraphicButton.SetMenuAlphaBlendAnimation(Value: Boolean);
begin
  FGraphicMenu.AlphaBlendAnimation := Value;
end;

function TbsSkinGraphicButton.GetMenuAlphaBlendValue: Integer;
begin
  Result := FGraphicMenu.AlphaBlendValue;
end;

procedure TbsSkinGraphicButton.SetMenuAlphaBlendValue(Value: Integer);
begin
  FGraphicMenu.AlphaBlendValue := Value;
end;

procedure TbsSkinGradientStyleButton.InitImages;
var
  B: TBitMap;
begin
  B := TBitMap.Create;
  B.LoadFromResourceName(HInstance, 'BS_GRAD_HORZ_IN');
  FGraphicImages.Width := B.Width;
  FGraphicImages.Height := B.Height;
  FGraphicImages.Add(B, nil);
  B.LoadFromResourceName(HInstance, 'BS_GRAD_HORZ_OUT');
  FGraphicImages.Add(B, nil);
  B.LoadFromResourceName(HInstance, 'BS_GRAD_HORZ_INOUT');
  FGraphicImages.Add(B, nil);
  B.LoadFromResourceName(HInstance, 'BS_GRAD_VERT_IN');
  FGraphicImages.Add(B, nil);
  B.LoadFromResourceName(HInstance, 'BS_GRAD_VERT_OUT');
  FGraphicImages.Add(B, nil);
  B.LoadFromResourceName(HInstance, 'BS_GRAD_VERT_INOUT');
  FGraphicImages.Add(B, nil);
  B.Free;
end;

procedure TbsSkinGradientStyleButton.InitItems;
var
 Item: TbsImagesMenuItem;
begin
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 0;
    Hint := 'HorizotalIn';
  end;
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 1;
    Hint := 'HorizotalOut';
  end;
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 2;
    Hint := 'HorizotalInOut';
  end;
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 3;
    Hint := 'VerticalIn';
  end;
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 4;
    Hint := 'VerticalOut';
  end;
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 5;
    Hint := 'VerticalInOut';
  end;
  FGraphicMenu.ColumnsCount := 2;
  FGraphicMenu.ItemIndex := 0;
end;


procedure TbsSkinBrushStyleButton.InitImages;
var
  B: TBitMap;
begin
  B := TBitMap.Create;
  B.LoadFromResourceName(HInstance, 'BS_BRUSH_CLEAR');
  FGraphicImages.Width := B.Width;
  FGraphicImages.Height := B.Height;
  FGraphicImages.Add(B, nil);
  B.LoadFromResourceName(HInstance, 'BS_BRUSH_SOLID');
  FGraphicImages.Add(B, nil);
  B.LoadFromResourceName(HInstance, 'BS_BRUSH_CROSS');
  FGraphicImages.Add(B, nil);
  B.LoadFromResourceName(HInstance, 'BS_BRUSH_DCROSS');
  FGraphicImages.Add(B, nil);
  B.LoadFromResourceName(HInstance, 'BS_BRUSH_FD');
  FGraphicImages.Add(B, nil);
  B.LoadFromResourceName(HInstance, 'BS_BRUSH_BD');
  FGraphicImages.Add(B, nil);
  B.LoadFromResourceName(HInstance, 'BS_BRUSH_H');
  FGraphicImages.Add(B, nil);
  B.LoadFromResourceName(HInstance, 'BS_BRUSH_V');
  FGraphicImages.Add(B, nil);
  B.Free;
end;

procedure TbsSkinBrushStyleButton.InitItems;
var
 Item: TbsImagesMenuItem;
begin
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 0;
  end;
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 1;
  end;
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 2;
  end;
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 3;
  end;
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 4;
  end;
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 5;
  end;
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 6;
  end;
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 7;
  end;
  FGraphicMenu.ColumnsCount := 2;
  FGraphicMenu.ItemIndex := 0;
end;


procedure TbsSkinPenStyleButton.InitImages;
var
  B: TBitMap;
begin
  B := TBitMap.Create;
  B.LoadFromResourceName(HInstance, 'BS_PEN_SOLID');
  FGraphicImages.Width := B.Width;
  FGraphicImages.Height := B.Height;
  FGraphicImages.Add(B, nil);
  B.LoadFromResourceName(HInstance, 'BS_PEN_DASH');
  FGraphicImages.Add(B, nil);
  B.LoadFromResourceName(HInstance, 'BS_PEN_DASHDOT');
  FGraphicImages.Add(B, nil);
  B.LoadFromResourceName(HInstance, 'BS_PEN_DOT');
  FGraphicImages.Add(B, nil);
  B.LoadFromResourceName(HInstance, 'BS_PEN_DASHDOTDOT');
  FGraphicImages.Add(B, nil);
  B.Free;
end;

procedure TbsSkinPenStyleButton.InitItems;
var
 Item: TbsImagesMenuItem;
begin
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 0;
  end;
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 1;
  end;
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 2;
  end;
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 3;
  end;
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 4;
  end;
  FGraphicMenu.ColumnsCount := 1;
  FGraphicMenu.ItemIndex := 0;
end;


procedure TbsSkinPenWidthButton.InitImages;
var
  B: TBitMap;
begin
  B := TBitMap.Create;
  B.LoadFromResourceName(HInstance, 'BS_PEN1');
  FGraphicImages.Width := B.Width;
  FGraphicImages.Height := B.Height;
  FGraphicImages.Add(B, nil);
  FGraphicImages.Add(B, nil);
  B.LoadFromResourceName(HInstance, 'BS_PEN2');
  FGraphicImages.Add(B, nil);
  FGraphicImages.Add(B, nil);
  FGraphicImages.Add(B, nil);
  B.LoadFromResourceName(HInstance, 'BS_PEN3');
  FGraphicImages.Add(B, nil);
  FGraphicImages.Add(B, nil);
  FGraphicImages.Add(B, nil);
  FGraphicImages.Add(B, nil);
  B.LoadFromResourceName(HInstance, 'BS_PEN4');
  FGraphicImages.Add(B, nil);
  FGraphicImages.Add(B, nil);
  B.LoadFromResourceName(HInstance, 'BS_PEN6');
  FGraphicImages.Add(B, nil);
  B.Free;
end;

procedure TbsSkinPenWidthButton.InitItems;
var
 Item: TbsImagesMenuItem;
begin
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 0;
    Button := True;
    Caption := '1/4 pt'
  end;
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 1;
    Button := True;
    Caption := '1/2 pt'
  end;
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 2;
    Button := True;
    Caption := '3/4 pt'
  end;
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 3;
    Button := True;
    Caption := '1 pt'
  end;
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 4;
    Button := True;
    Caption := '1 1/4 pt'
  end;
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 5;
    Button := True;
    Caption := '1 1/2 pt'
  end;
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 6;
    Button := True;
    Caption := '1 3/4 pt'
  end;
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 7;
    Button := True;
    Caption := '2 pt'
  end;
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 8;
    Button := True;
    Caption := '2 1/2 pt'
  end;
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 9;
    Button := True;
    Caption := '3 pt'
  end;
    Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 10;
    Button := True;
    Caption := '4 pt'
  end;
    Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 11;
    Button := True;
    Caption := '6 pt'
  end;
  FGraphicMenu.ColumnsCount := 2;
  FGraphicMenu.ItemIndex := 0;
end;

procedure TbsSkinShadowStyleButton.InitImages;
var
  B: TBitMap;
begin
  FGraphicImages.Width := 20;
  FGraphicImages.Height := 20;
  FGraphicImages.ResInstLoad(HInstance, rtBitmap, 'BS_SHADOW1', clWhite);
  FGraphicImages.ResInstLoad(HInstance, rtBitmap, 'BS_SHADOW2', clWhite);
  FGraphicImages.ResInstLoad(HInstance, rtBitmap, 'BS_SHADOW3', clWhite);
  FGraphicImages.ResInstLoad(HInstance, rtBitmap, 'BS_SHADOW4', clWhite);
  FGraphicImages.ResInstLoad(HInstance, rtBitmap, 'BS_SHADOW5', clWhite);
  FGraphicImages.ResInstLoad(HInstance, rtBitmap, 'BS_SHADOW6', clWhite);
  FGraphicImages.ResInstLoad(HInstance, rtBitmap, 'BS_SHADOW7', clWhite);
  FGraphicImages.ResInstLoad(HInstance, rtBitmap, 'BS_SHADOW8', clWhite);
  FGraphicImages.ResInstLoad(HInstance, rtBitmap, 'BS_SHADOW9', clWhite);
  FGraphicImages.ResInstLoad(HInstance, rtBitmap, 'BS_SHADOW10', clWhite);
  FGraphicImages.ResInstLoad(HInstance, rtBitmap, 'BS_SHADOW11', clWhite);
  FGraphicImages.ResInstLoad(HInstance, rtBitmap, 'BS_SHADOW12', clWhite);
  FGraphicImages.ResInstLoad(HInstance, rtBitmap, 'BS_SHADOW13', clWhite);
  FGraphicImages.ResInstLoad(HInstance, rtBitmap, 'BS_SHADOW14', clWhite);
  FGraphicImages.ResInstLoad(HInstance, rtBitmap, 'BS_SHADOW15', clWhite);
  FGraphicImages.ResInstLoad(HInstance, rtBitmap, 'BS_SHADOW16', clWhite);
  FGraphicImages.ResInstLoad(HInstance, rtBitmap, 'BS_SHADOW17', clWhite);
  FGraphicImages.ResInstLoad(HInstance, rtBitmap, 'BS_SHADOW18', clWhite);
  FGraphicImages.ResInstLoad(HInstance, rtBitmap, 'BS_SHADOW19', clWhite);
  FGraphicImages.ResInstLoad(HInstance, rtBitmap, 'BS_SHADOW20', clWhite);
  FGraphicImages.ResInstLoad(HInstance, rtBitmap, 'BS_SHADOW21', clWhite);
end;

procedure TbsSkinShadowStyleButton.InitItems;
var
 Item: TbsImagesMenuItem;
 i: Integer;
begin
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    Button := True;
    Caption := 'No shadow';
  end;
  for i := 0 to 19 do
  begin
    Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
    Item.ImageIndex := i;
  end;
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    Button := True;
    Caption := 'More settings';
    ImageIndex := 20;
  end;
  FGraphicMenu.ColumnsCount := 4;
  FGraphicMenu.ItemIndex := 0;
end;


end.
