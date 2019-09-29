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

unit bsSkinData;

{$P+,S-,W-,R-}
{$WARNINGS OFF}
{$HINTS OFF}


interface

uses Windows, Messages, SysUtils, Classes, Graphics, bsUtils, Forms,
     IniFiles;

type

  TbsStdCommand = (cmClose, cmMaximize, cmMinimize, cmSysMenu, cmDefault, cmRollUp, cmMinimizeToTray);
  TbsMorphKind = (mkDefault, mkGradient, mkLeftGradient, mkRightGradient,
                  mkLeftSlide, mkRightSlide, mkPush);
  TbsInActiveEffect = (ieBrightness, ieDarkness, ieGrayScale,
                       ieNoise, ieSplitBlur, ieInvert);

  TbsDataSkinControl = class(TObject)
  public
    IDName: String;
    PictureIndex: Integer;
    MaskPictureIndex: Integer;
    SkinRect: TRect;
    constructor Create(AIDName: String);
    procedure LoadFromFile(IniFile: TCustomIniFile); virtual;
    procedure SaveToFile(IniFile: TCustomIniFile); virtual;
  end;

  TbsDataSkinBevel = class(TbsDataSkinControl)
  public
    LightColor: TColor;
    DarkColor: TColor;
    constructor Create(AIDName: String);
    procedure LoadFromFile(IniFile: TCustomIniFile); override;
    procedure SaveToFile(IniFile: TCustomIniFile); override;
  end;

  TbsDataSkinTreeView = class(TbsDataSkinControl)
  public
    FontName: String;
    FontCharset: TFontCharset;
    FontStyle: TFontStyles;
    FontHeight: Integer;
    FontColor: TColor;
    BGColor: TColor;
    constructor Create(AIDName: String);
    procedure LoadFromFile(IniFile: TCustomIniFile); override;
    procedure SaveToFile(IniFile: TCustomIniFile); override;
  end;

  TbsDataSkinSlider = class(TbsDataSkinControl)
  public
    HRulerRect: TRect;
    HThumbRect: TRect;
    VRulerRect: TRect;
    VThumbRect: TRect;
    EdgeSize: Integer;
    BGColor: TColor;
    PointsColor: TColor;
    constructor Create(AIDName: String);
    procedure LoadFromFile(IniFile: TCustomIniFile); override;
    procedure SaveToFile(IniFile: TCustomIniFile); override;
  end;

  TbsDataSkinListView = class(TbsDataSkinControl)
  public
    FontName: String;
    FontCharset: TFontCharset;
    FontStyle: TFontStyles;
    FontHeight: Integer;
    FontColor: TColor;
    BGColor: TColor;
    constructor Create(AIDName: String);
    procedure LoadFromFile(IniFile: TCustomIniFile); override;
    procedure SaveToFile(IniFile: TCustomIniFile); override;
  end;

  TbsDataSkinRichEdit = class(TbsDataSkinControl)
  public
    FontName: String;
    FontCharset: TFontCharset;
    FontStyle: TFontStyles;
    FontHeight: Integer;
    FontColor: TColor;
    BGColor: TColor;
    constructor Create(AIDName: String);
    procedure LoadFromFile(IniFile: TCustomIniFile); override;
    procedure SaveToFile(IniFile: TCustomIniFile); override;
  end;

  TbsDataSkinMainMenuBar = class(TbsDataSkinControl)
  public
    ItemsRect: TRect;
    MenuBarItem: String;
    CloseButton: String;
    MaxButton: String;
    MinButton: String;
    SysMenuButton: String;
    TrackMarkColor, TrackMarkActiveColor: Integer;
    constructor Create(AIDName: String);
    procedure LoadFromFile(IniFile: TCustomIniFile); override;
    procedure SaveToFile(IniFile: TCustomIniFile); override;
  end;

  TbsDataSkinTabControl = class(TbsDataSkinControl)
  public
    TabRect, ActiveTabRect, FocusTabRect, MouseInTabRect: TRect;
    ClRect: TRect;
    TabsBGRect: TRect;
    LTPoint, RTPoint, LBPoint, RBPoint: TPoint;
    TabLeftOffset, TabRightOffset: Integer;
    FontName: String;
    FontCharset: TFontCharset;
    FontStyle: TFontStyles;
    FontHeight: Integer;
    FontColor, ActiveFontColor, FocusFontColor, MouseInFontColor: TColor;
    UpDown: String;
    BGPictureIndex: Integer;
    TabStretchEffect: Boolean;
    ShowFocus: Boolean;
    FocusOffsetX, FocusOffsetY: Integer;
    LeftStretch, TopStretch, RightStretch, BottomStretch: Boolean;
    constructor Create(AIDName: String);
    procedure LoadFromFile(IniFile: TCustomIniFile); override;
    procedure SaveToFile(IniFile: TCustomIniFile); override;
  end;

  TbsDataSkinGridControl = class(TbsDataSkinControl)
  public
    FixedCellRect, SelectCellRect, FocusCellRect: TRect;
    //
    FixedCellLeftOffset, FixedCellRightOffset: Integer;
    FixedCellTextRect: TRect;
    //
    CellLeftOffset, CellRightOffset: Integer;
    CellTextRect: TRect;
    //
    LinesColor, BGColor: TColor;
    FontName: String;
    FontCharset: TFontCharset;
    FontStyle: TFontStyles;
    FontHeight: Integer;
    FontColor, SelectFontColor, FocusFontColor: TColor;
    FixedFontName: String;
    FixedFontCharset: TFontCharset;
    FixedFontStyle: TFontStyles;
    FixedFontHeight: Integer;
    FixedFontColor: TColor;
    FixedCellStretchEffect: Boolean;
    CellStretchEffect: Boolean;
    ShowFocus: Boolean;
    constructor Create(AIDName: String);
    procedure LoadFromFile(IniFile: TCustomIniFile); override;
    procedure SaveToFile(IniFile: TCustomIniFile); override;
  end;

  TbsDataSkinCustomControl = class(TbsDataSkinControl)
  public
    LTPoint, RTPoint, LBPoint, RBPoint: TPoint;
    ClRect: TRect;
    StretchEffect: Boolean;
    LeftStretch, TopStretch, RightStretch, BottomStretch: Boolean;
    constructor Create(AIDName: String);
    procedure LoadFromFile(IniFile: TCustomIniFile); override;
    procedure SaveToFile(IniFile: TCustomIniFile); override;
  end;

  TbsDataSkinControlBar = class(TbsDataSkinCustomControl)
  public
    ItemRect: TRect;
    BGPictureIndex: Integer;
    HGripRect, VGripRect: TRect;
    GripOffset1, GripOffset2: Integer;
    constructor Create(AIDName: String);
    procedure LoadFromFile(IniFile: TCustomIniFile); override;
    procedure SaveToFile(IniFile: TCustomIniFile); override;
  end;

  TbsDataSkinUpDownControl = class(TbsDataSkinCustomControl)
  public
    UpButtonRect, ActiveUpButtonRect, DownUpButtonRect: TRect;
    DownButtonRect, ActiveDownButtonRect, DownDownButtonRect: TRect;
    procedure LoadFromFile(IniFile: TCustomIniFile); override;
    procedure SaveToFile(IniFile: TCustomIniFile); override;
  end;
  
  TbsDataSkinComboBox = class(TbsDataSkinCustomControl)
  public
    //
    SItemRect, ActiveItemRect, FocusItemRect: TRect;
    ItemLeftOffset, ItemRightOffset: Integer;
    ItemTextRect: TRect;
    FontName: String;
    FontCharset: TFontCharset;
    FontStyle: TFontStyles;
    FontHeight: Integer;
    FontColor, FocusFontColor, ActiveFontColor: TColor;
    ButtonRect,
    ActiveButtonRect,
    DownButtonRect,
    UnEnabledButtonRect: TRect;
    ItemStretchEffect: Boolean;
    FocusItemStretchEffect: Boolean;
    //
    ActiveSkinRect: TRect;
    //
    ListBoxName: String;
    ShowFocus: Boolean;
    constructor Create(AIDName: String);
    procedure LoadFromFile(IniFile: TCustomIniFile); override;
    procedure SaveToFile(IniFile: TCustomIniFile); override;
  end;

  TbsDataSkinListBox = class(TbsDataSkinCustomControl)
  public
    //
    SItemRect, ActiveItemRect, FocusItemRect: TRect;
    ItemLeftOffset, ItemRightOffset: Integer;
    ItemTextRect: TRect;
    FontName: String;
    FontCharset: TFontCharset;
    FontStyle: TFontStyles;
    FontHeight: Integer;
    FontColor, ActiveFontColor, FocusFontColor: TColor;
    //
    CaptionRect: TRect;
    CaptionFontName: String;
    CaptionFontCharset: TFontCharset;
    CaptionFontStyle: TFontStyles;
    CaptionFontHeight: Integer;
    CaptionFontColor: TColor;
    //
    UpButtonRect, ActiveUpButtonRect, DownUpButtonRect: TRect;
    DownButtonRect, ActiveDownButtonRect, DownDownButtonRect: TRect;
    CheckButtonRect, ActiveCheckButtonRect, DownCheckButtonRect: TRect;
    //
    HScrollBarName: String;
    VScrollBarName: String;
    BothScrollBarName: String;
    ShowFocus: Boolean;
    constructor Create(AIDName: String);
    procedure LoadFromFile(IniFile: TCustomIniFile); override;
    procedure SaveToFile(IniFile: TCustomIniFile); override;
  end;

  TbsDataSkinCheckListBox = class(TbsDataSkinListBox)
  public
    UnCheckImageRect, CheckImageRect: TRect;
    ItemCheckRect: TRect;
    procedure LoadFromFile(IniFile: TCustomIniFile); override;
    procedure SaveToFile(IniFile: TCustomIniFile); override;
  end;

  TbsDataSkinScrollBarControl = class(TbsDataSkinCustomControl)
  public
    TrackArea: TRect;
    UpButtonRect, ActiveUpButtonRect, DownUpButtonRect: TRect;
    DownButtonRect, ActiveDownButtonRect, DownDownButtonRect: TRect;
    ThumbRect, ActiveThumbRect, DownThumbRect: TRect;
    ThumbOffset1, ThumbOffset2: Integer;
    GlyphRect, ActiveGlyphRect, DownGlyphRect: TRect;
    ThumbTransparent: Boolean;
    ThumbTransparentColor: TColor;
    constructor Create(AIDName: String);
    procedure LoadFromFile(IniFile: TCustomIniFile); override;
    procedure SaveToFile(IniFile: TCustomIniFile); override;
 end;

 TbsDataSkinSpinEditControl = class(TbsDataSkinCustomControl)
 public
   ActiveSkinRect: TRect;
   FontName: String;
   FontCharset: TFontCharset;
   FontStyle: TFontStyles;
   FontHeight: Integer;
   FontColor, ActiveFontColor, DisabledFontColor: TColor;
   UpButtonRect, ActiveUpButtonRect, DownUpButtonRect: TRect;
   DownButtonRect, ActiveDownButtonRect, DownDownButtonRect: TRect;
   constructor Create(AIDName: String);
   procedure LoadFromFile(IniFile: TCustomIniFile); override;
   procedure SaveToFile(IniFile: TCustomIniFile); override;
 end;

  TbsDataSkinEditControl = class(TbsDataSkinCustomControl)
  public
    ActiveSkinRect: TRect;
    FontName: String;
    FontCharset: TFontCharset;
    FontStyle: TFontStyles;
    FontHeight: Integer;
    FontColor, DisabledFontColor: TColor;
    ActiveFontColor: TColor;
    ButtonRect: TRect;
    ActiveButtonRect: TRect;
    DownButtonRect: TRect;
    UnEnabledButtonRect: TRect;
    constructor Create(AIDName: String);
    procedure LoadFromFile(IniFile: TCustomIniFile); override;
    procedure SaveToFile(IniFile: TCustomIniFile); override;
  end;

  TbsDataSkinMemoControl = class(TbsDataSkinEditControl)
  public
    BGColor: TColor;
    ActiveBGColor: TColor;
    constructor Create(AIDName: String);
    procedure LoadFromFile(IniFile: TCustomIniFile); override;
    procedure SaveToFile(IniFile: TCustomIniFile); override;
  end;

  TbsDataSkinStdLabelControl = class(TbsDataSkinControl)
  public
    FontName: String;
    FontCharset: TFontCharset;
    FontStyle: TFontStyles;
    FontHeight: Integer;
    FontColor: TColor;
    ActiveFontColor: TColor;
    constructor Create(AIDName: String);
    procedure LoadFromFile(IniFile: TCustomIniFile); override;
    procedure SaveToFile(IniFile: TCustomIniFile); override;
  end;

  TbsDataSkinLabelControl = class(TbsDataSkinCustomControl)
  public
    FontName: String;
    FontCharset: TFontCharset;
    FontStyle: TFontStyles;
    FontHeight: Integer;
    FontColor: TColor;
    constructor Create(AIDName: String);
    procedure LoadFromFile(IniFile: TCustomIniFile); override;
    procedure SaveToFile(IniFile: TCustomIniFile); override;
  end;

  TbsDataSkinSplitterControl = class(TbsDataSkinCustomControl)
  public
    GripperRect: TRect;
    GripperTransparent: Boolean;
    GripperTransparentColor: TColor;
    constructor Create(AIDName: String);
    procedure LoadFromFile(IniFile: TCustomIniFile); override;
    procedure SaveToFile(IniFile: TCustomIniFile); override;
  end;

  TbsDataSkinGaugeControl = class(TbsDataSkinCustomControl)
  public
    ProgressArea, ProgressRect: TRect;
    Vertical: Boolean;
    BeginOffset, EndOffset: Integer;
    FontName: String;
    FontCharset: TFontCharset;
    FontStyle: TFontStyles;
    FontHeight: Integer;
    FontColor: TColor;
    ProgressTransparent: Boolean;
    ProgressTransparentColor: TColor;
    ProgressStretch: Boolean;
    constructor Create(AIDName: String);
    procedure LoadFromFile(IniFile: TCustomIniFile); override;
    procedure SaveToFile(IniFile: TCustomIniFile); override;
  end;

  TbsDataSkinTrackBarControl = class(TbsDataSkinCustomControl)
  public
    TrackArea, ButtonRect, ActiveButtonRect: TRect;
    Vertical: Boolean;
    ButtonTransparent: Boolean;
    ButtonTransparentColor: TColor;
    constructor Create(AIDName: String);
    procedure LoadFromFile(IniFile: TCustomIniFile); override;
    procedure SaveToFile(IniFile: TCustomIniFile); override;
  end;

  TbsDataSkinButtonControl = class(TbsDataSkinCustomControl)
  public
    FontName: String;
    FontCharset: TFontCharset;
    FontStyle: TFontStyles;
    FontHeight: Integer;
    FontColor, ActiveFontColor, DownFontColor, DisabledFontColor: TColor;
    ActiveSkinRect, DownSkinRect, DisabledSkinRect: TRect;
    Morphing: Boolean;
    MorphKind: TbsMorphKind;
    AnimateSkinRect: TRect;
    FrameCount: Integer;
    AnimateInterval: Integer;
    ShowFocus: Boolean;
    MenuMarkerFlatRect: TRect;
    MenuMarkerRect: TRect;
    MenuMarkerActiveRect: TRect;
    MenuMarkerDownRect: TRect;
    MenuMarkerTransparentColor: TColor;
    constructor Create(AIDName: String);
    procedure LoadFromFile(IniFile: TCustomIniFile); override;
    procedure SaveToFile(IniFile: TCustomIniFile); override;
  end;

  TbsDataSkinMenuButtonControl = class(TbsDataSkinButtonControl)
  public
    TrackButtonRect: TRect;
    constructor Create(AIDName: String);
    procedure LoadFromFile(IniFile: TCustomIniFile); override;
    procedure SaveToFile(IniFile: TCustomIniFile); override;
  end;

  TbsDataSkinCheckRadioControl = class(TbsDataSkinCustomControl)
  public
    FontName: String;
    FontCharset: TFontCharset;
    FontStyle: TFontStyles;
    FontHeight: Integer;
    FontColor, ActiveFontColor, UnEnabledFontColor: TColor;
    ActiveSkinRect: TRect;
    CheckImageArea, TextArea,
    CheckImageRect, UnCheckImageRect: TRect;
    ActiveCheckImageRect, ActiveUnCheckImageRect: TRect;
    UnEnabledCheckImageRect, UnEnabledUnCheckImageRect: TRect;
    Morphing: Boolean;
    MorphKind: TbsMorphKind;
    FrameFontColor: TColor;
    constructor Create(AIDName: String);
    procedure LoadFromFile(IniFile: TCustomIniFile); override;
    procedure SaveToFile(IniFile: TCustomIniFile); override;
  end;

  TbsDataSkinScrollBoxControl = class(TbsDataSkinCustomControl)
  public
    BGPictureIndex: Integer;
    constructor Create(AIDName: String);
    procedure LoadFromFile(IniFile: TCustomIniFile); override;
    procedure SaveToFile(IniFile: TCustomIniFile); override;
  end;

  TbsDataSkinPanelControl = class(TbsDataSkinCustomControl)
  public
    CaptionRect: TRect;
    Alignment: TAlignment;
    FontName: String;
    FontCharset: TFontCharset;
    FontStyle: TFontStyles;
    FontHeight: Integer;
    FontColor: TColor;
    BGPictureIndex: Integer;
    CheckImageRect, UnCheckImageRect: TRect;
    MarkFrameRect: TRect;
    FrameRect: TRect;
    FrameLeftOffset, FrameRightOffset: Integer;
    FrameTextRect: TRect;
    GripperRect: TRect;
    GripperTransparent: Boolean;
    GripperTransparentColor: TColor;
    constructor Create(AIDName: String);
    procedure LoadFromFile(IniFile: TCustomIniFile); override;
    procedure SaveToFile(IniFile: TCustomIniFile); override;
  end;

  TbsDataSkinExPanelControl = class(TbsDataSkinCustomControl)
  public
    //
    RollHSkinRect, RollVSkinRect: TRect;
    RollLeftOffset, RollRightOffset,
    RollTopOffset, RollBottomOffset: Integer;
    RollVCaptionRect, RollHCaptionRect: TRect;
    //
    CloseButtonRect, CloseButtonActiveRect, CloseButtonDownRect: TRect;
    HRollButtonRect, HRollButtonActiveRect, HRollButtonDownRect: TRect;
    HRestoreButtonRect, HRestoreButtonActiveRect, HRestoreButtonDownRect: TRect;
    VRollButtonRect, VRollButtonActiveRect, VRollButtonDownRect: TRect;
    VRestoreButtonRect, VRestoreButtonActiveRect, VRestoreButtonDownRect: TRect;
    //
    CaptionRect: TRect;
    FontName: String;
    FontCharset: TFontCharset;
    FontStyle: TFontStyles;
    FontHeight: Integer;
    FontColor: TColor;
    constructor Create(AIDName: String);
    procedure LoadFromFile(IniFile: TCustomIniFile); override;
    procedure SaveToFile(IniFile: TCustomIniFile); override;
  end;

  TbsDataSkinObject = class(TObject)
  public
    IDName: String;
    Hint: String;
    SkinRectInAPicture: Boolean;
    SkinRect: TRect;
    ActiveSkinRect: TRect;
    ActivePictureIndex: Integer;
    InActiveSkinRect: TRect;
    Morphing: Boolean;
    MorphKind: TbsMorphKind;
    constructor Create(AIDName: String);
    procedure LoadFromFile(IniFile: TCustomIniFile); virtual;
    procedure SaveToFile(IniFile: TCustomIniFile); virtual;
  end;

  TbsDataUserObject = class(TbsDataSkinObject)
  public
    procedure LoadFromFile(IniFile: TCustomIniFile); override;
    procedure SaveToFile(IniFile: TCustomIniFile); override;
  end;

  TbsDataSkinButton = class(TbsDataSkinObject)
  public
    DownRect: TRect;
    DisableSkinRect: TRect;
    constructor Create(AIDName: String);
    procedure LoadFromFile(IniFile: TCustomIniFile); override;
    procedure SaveToFile(IniFile: TCustomIniFile); override;
  end;

  TbsDataSkinStdButton = class(TbsDataSkinButton)
  public
    Command: TbsStdCommand;
    RestoreRect: TRect;
    RestoreActiveRect: TRect;
    RestoreDownRect: TRect;
    RestoreInActiveRect: TRect;
    procedure LoadFromFile(IniFile: TCustomIniFile); override;
    procedure SaveToFile(IniFile: TCustomIniFile); override;
  end;

  TbsDataSkinAnimate = class(TbsDataSkinObject)
  public
    CountFrames: Integer;
    Cycle: Boolean;
    ButtonStyle: Boolean;
    TimerInterval: Integer;
    Command: TbsStdCommand;
    DownSkinRect: TRect;
    RestoreRect: TRect;
    RestoreActiveRect: TRect;
    RestoreDownRect: TRect;
    RestoreInActiveRect: TRect;
    procedure LoadFromFile(IniFile: TCustomIniFile); override;
    procedure SaveToFile(IniFile: TCustomIniFile); override;
  end;

  TbsDataSkinMainMenuBarButton = class(TbsDataSkinStdButton);

  TbsDataSkinPopupWindow = class(TObject)
  public
    WindowPictureIndex: Integer;
    MaskPictureIndex: Integer;
    LTPoint, RTPoint, LBPoint, RBPoint: TPoint;
    ItemsRect: TRect;
    ScrollMarkerColor, ScrollMarkerActiveColor: Integer;
    TopStretch, LeftStretch,
    RightStretch, BottomStretch: Boolean;
    constructor Create;
    procedure LoadFromFile(IniFile: TCustomIniFile);
    procedure SaveToFile(IniFile: TCustomIniFile);
  end;

  TbsDataSkinHintWindow = class(TObject)
  public
    WindowPictureIndex: Integer;
    MaskPictureIndex: Integer;
    LTPoint, RTPoint, LBPoint, RBPoint: TPoint;
    ClRect: TRect;
    FontName: String;
    FontCharset: TFontCharset;
    FontStyle: TFontStyles;
    FontHeight: Integer;
    FontColor: TColor;
    TopStretch, LeftStretch,
    RightStretch, BottomStretch: Boolean;
    constructor Create;
    procedure LoadFromFile(IniFile: TCustomIniFile);
    procedure SaveToFile(IniFile: TCustomIniFile);
  end;

  TbsDataSkinMenuItem = class(TbsDataSkinObject)
  public
    DividerRect: TRect;
    DividerLO, DividerRO: Integer;
    ItemLO, ItemRO: Integer;
    FontName: String;
    FontCharset: TFontCharset;
    FontHeight: Integer;
    FontStyle: TFontStyles;
    UnEnabledFontColor, FontColor, ActiveFontColor: TColor;
    TextRct: TRect;
    ImageRct: TRect;
    UseImageColor: Boolean;
    ImageColor, ActiveImageColor: TColor;
    StretchEffect: Boolean;
    DividerStretchEffect: Boolean;
    InActiveStretchEffect: Boolean;
    AnimateSkinRect: TRect;
    FrameCount: Integer;
    AnimateInterval: Integer;
    InActiveAnimation: Boolean;
    procedure LoadFromFile(IniFile: TCustomIniFile); override;
    procedure SaveToFile(IniFile: TCustomIniFile); override;
  end;

  TbsDataSkinMainMenuItem = class(TbsDataSkinObject)
  public
    DownRect: TRect;
    FontName: String;
    FontCharset: TFontCharset;
    FontHeight: Integer;
    FontStyle: TFontStyles;
    FontColor, ActiveFontColor, DownFontColor, UnEnabledFontColor: TColor;
    TextRct: TRect;
    ItemLO, ItemRO: Integer;
    StretchEffect: Boolean;
    AnimateSkinRect: TRect;
    FrameCount: Integer;
    AnimateInterval: Integer;
    InActiveAnimation: Boolean;
    procedure LoadFromFile(IniFile: TCustomIniFile); override;
    procedure SaveToFile(IniFile: TCustomIniFile); override;
  end;

  TbsDataSkinMainMenuBarItem = class(TbsDataSkinMainMenuItem);

  TbsDataSkinCaption = class(TbsDataSkinObject)
  public
    FontName: String;
    FontCharset: TFontCharset;
    FontHeight: Integer;
    FontStyle: TFontStyles;
    FontColor, ActiveFontColor: TColor;
    ShadowColor, ActiveShadowColor: TColor;
    Shadow: Boolean;
    Alignment: TAlignment;
    TextRct: TRect;
    FrameRect, ActiveFrameRect: TRect;
    FrameLeftOffset, FrameRightOffset: Integer;
    FrameTextRect: TRect;
    Light: Boolean;
    LightColor, ActiveLightColor: TColor;
    StretchEffect: Boolean;
    AnimateSkinRect: TRect;
    FrameCount: Integer;
    AnimateInterval: Integer;
    InActiveAnimation: Boolean;
    FullFrame: Boolean;
    procedure LoadFromFile(IniFile: TCustomIniFile); override;
    procedure SaveToFile(IniFile: TCustomIniFile); override;
  end;

  TbsSkinData = class;

  TbsCompressedStoredSkin = class(TComponent)
  private
    FFileName: String;
    FCompressedFileName: String;
    FCompressedStream: TMemoryStream;
    FDescription: String;
    procedure SetFileName(Value: String);
    procedure SetCompressedFileName(Value: String);
    function GetEmpty: Boolean;
  protected
    procedure ReadData(Reader: TStream);
    procedure WriteData(Writer: TStream);
    procedure DefineProperties(Filer: TFiler); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromIniFile(AFileName: String);
    procedure LoadFromSkinData(ASkinData: TbsSkinData);
    procedure LoadFromCompressFile(AFileName: String);
    procedure SaveToCompressFile(AFileName: String);
    procedure LoadFromCompressStream(Stream: TStream);
    procedure DeCompressToStream(var S: TMemoryStream);
    property Empty: Boolean read GetEmpty;
  published
    property Description: String read FDescription write FDescription;
    property FileName: String read FFileName write SetFileName;
    property CompressedFileName: String read FCompressedFileName write SetCompressedFileName;
  end;

  TbsResourceStrData = class(TComponent)
  private
    FResStrs: TStrings;
    FCharSet: TFontCharSet;
    procedure SetResStrs(Value: TStrings);
    procedure Init;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetResStr(const ResName: String): String;
  published
    property ResStrings: TStrings read FResStrs write SetResStrs;
    property CharSet: TFontCharSet read FCharSet write FCharSet;
  end;

  TbsSkinColors = class(TObject)
  protected
    FcBtnFace: TColor;
    FcBtnText: TColor;
    FcWindow: TColor;
    FcWindowText: TColor;
    FcHighLight: TColor;
    FcHighLightText: TColor;
    FcBtnHighLight: TColor;
    FcBtnShadow: TColor;
  public
    //
    constructor Create;
    procedure LoadFromFile(IniFile: TCustomIniFile);
    procedure SaveToFile(IniFile: TCustomIniFile);
    procedure SetColorsToDefault;
    //
    property cBtnFace: TColor read FcBtnFace write FcBtnFace; 
    property cBtnText: TColor read FcBtnText write FcBtnText;
    property cBtnHighLight: TColor read FcBtnHighLight write FcBtnHighLight;
    property cBtnShadow: TColor read FcBtnShadow write FcBtnShadow;
    property cHighLight: TColor read FcHighLight write FcHighLight;
    property cHighLightText: TColor read FcHighLightText write FcHighLightText;
    property cWindow: TColor read FcWindow write FcWindow;
    property cWindowText: TColor read FcWindowText write FcWindowText;
  end;

  TbsSkinData = class(TComponent)
  protected
    FEnableSkinEffects: Boolean;
    FCompressedStoredSkin: TbsCompressedStoredSkin;
    FResourceStrData: TbsResourceStrData;
    FSkinColors: TbsSkinColors;

    procedure Notification(AComponent: TComponent;
                           Operation: TOperation); override;
    procedure SetCompressedStoredSkin(Value: TbsCompressedStoredSkin);
    procedure SetResourceStrData(Value: TbsResourceStrData);
    procedure WriteFormInfo(F: TCustomIniFile);
    procedure ReadFormInfo(F: TCustomIniFile);
    procedure WriteObjects(F: TCustomIniFile);
    procedure ReadObjects(F: TCustomIniFile);
    procedure WriteCtrls(F: TCustomIniFile);
    procedure ReadCtrls(F: TCustomIniFile);
    procedure WriteActivePictures(F: TCustomIniFile);
    procedure ReadActivePictures(F: TCustomIniFile; Path: String);
    procedure GetObjectTypeName(S: String; var AName, AType: String);
    procedure SaveToCustomIniFile(F: TCustomIniFile);
    //
  public
    //
    ButtonsRect, CaptionRect: TRect;
    ButtonsOffset: Integer;
    CapButtonsInLeft: Boolean;
    //
    AutoRenderingInActiveImage: Boolean;
    InActiveEffect: TbsInActiveEffect;
    PopupWindow: TbsDataSkinPopupWindow;
    HintWindow: TbsDataSkinHintWindow;
    Empty: Boolean;
    FPicture, FInActivePicture, FMask: TBitMap;
    FActivePictures: TList;
    FPictureName, FInActivePictureName, FMaskName: String;
    FActivePicturesNames: TStrings;
    ObjectList: TList;
    CtrlList: TList;
    LTPoint, RTPoint, LBPoint, RBPoint: TPoint;
    BGPictureIndex: Integer;
    MDIBGPictureIndex: Integer;
    MainMenuPopupUp: Boolean;
    MaskRectArea: TRect;
    HitTestLTPoint,
    HitTestRTPoint,
    HitTestLBPoint,
    HitTestRBPoint: TPoint;
    ClRect: TRect;
    BorderW: Integer;
    FormMinWidth: Integer;

    TopStretch, LeftStretch,
    RightStretch, BottomStretch: Boolean;

    SkinName: String;
    SkinAuthor: String;
    AuthorURL: String;
    AuthorEmail: String;
    SkinComments: String;

    ChangeSkinDataProcess: Boolean;

    procedure AddBitMap(FileName: String);
    procedure DeleteBitMap(Index: Integer);

    procedure SendSkinDataMessage(M: LongInt);

    function GetIndex(AIDName: String): Integer;
    function GetControlIndex(AIDName: String): Integer;
    procedure ClearObjects;
    procedure ClearAll;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure LoadFromFile(FileName: String);
    procedure SaveToFile(FileName: String);
    procedure LoadFromCompressedFile(FileName: String);
    procedure SaveToCompressedFile(FileName: String);
    procedure StoreToDisk(AFileName: String);

    procedure LoadCompressedStoredSkin(AStoredSkin: TbsCompressedStoredSkin);

    procedure ClearSkin;
    property SkinColors: TbsSkinColors read FSkinColors;
  published
    property EnableSkinEffects: Boolean read
      FEnableSkinEffects write FEnableSkinEffects;
    property CompressedStoredSkin: TbsCompressedStoredSkin
      read FCompressedStoredSkin write SetCompressedStoredSkin;
    property ResourceStrData: TbsResourceStrData
      read FResourceStrData write SetResourceStrData;
  end;

  function ReadInActiveEffect(IniFile: TCustomIniFile;
                              Section: String; Ident: String): TbsInActiveEffect;

  procedure WriteInActiveEffect(IniFile: TCustomIniFile;
                                Section: String; Ident: String;
                                IE: TbsInActiveEffect);

  procedure WriteMorphKind(IniFile: TCustomIniFile;
                           Section: String; Ident: String; MK: TbsMorphKind);

  function ReadMorphKind(IniFile: TCustomIniFile;
                         Section: String; Ident: String): TbsMorphKind;



// Internal messages
const
  WM_BEFORECHANGESKINDATA = WM_USER + 201;
  WM_CHANGESKINDATA = WM_USER + 202;
  WM_AFTERCHANGESKINDATA = WM_USER + 203;
  WM_CHANGERESSTRDATA = WM_USER + 250;

implementation

   Uses bsZLibCompress;
   
function CheckSkinFile(F: TCustomIniFile): Boolean;
begin
  Result := F.SectionExists('VERSION') and F.SectionExists('PICTURES') and
            F.SectionExists('FORMINFO') and F.SectionExists('SKINOBJECTS') and
            F.SectionExists('SKINCONTROLS');
end;

procedure WriteInActiveEffect;
var
  S: String;
begin
  case IE of
    ieBrightness: S := 'iebrightness';
    ieDarkness: S := 'iedarkness';
    ieGrayScale: S := 'iegrayscale';
    ieNoise: S := 'ienoise';
    ieSplitBlur: S := 'iesplitblur';
    ieInvert: S := 'ieinvert';
  end;
  IniFile.WriteString(Section, Ident, S);
end;

function ReadInActiveEffect;
var
  S: String;
begin
  S := IniFile.ReadString(Section, Ident, 'iebrightness');
  if S = 'iebrightness'
  then Result := ieBrightness
  else
  if S = 'iedarkness'
  then Result := ieDarkness
  else
  if S = 'iegrayscale'
  then Result := ieGrayScale
  else
  if S = 'ienoise'
  then Result := ieNoise
  else
  if S = 'iesplitblur'
  then Result := ieSplitBlur
  else
  if S = 'ieinvert'
  then Result := ieInvert
  else
    Result := ieGrayScale;
end;

function ReadMorphKind;
var
  S: String;
begin
  S := IniFile.ReadString(Section, Ident, 'mkdefault');
  if S = 'mkdefault'
  then Result := mkDefault
  else
  if S = 'mkgradient'
  then Result := mkGradient
  else
  if S = 'mkleftgradient'
  then Result := mkLeftGradient
  else
  if S = 'mkrightgradient'
  then Result := mkRightGradient
  else
  if S = 'mkleftslide'
  then Result := mkLeftSlide
  else
  if S = 'mkrightslide'
  then Result := mkRightSlide
  else
  if S = 'mkpush'
  then Result := mkPush
  else Result := mkDefault;
end;

procedure WriteMorphKind;
var
  S: String;
begin
  case MK of
    mkDefault: S := 'mkdefault';
    mkGradient: S := 'mkgradient';
    mkLeftGradient: S := 'mkleftgradient';
    mkRightGradient: S := 'mkrightgradient';
    mkLeftSlide: S := 'mkleftslide';
    mkRightSlide: S := 'mkrightslide';
    mkPush: S := 'mkpush';
  end;
  IniFile.WriteString(Section, Ident, S);
end;

constructor TbsDataSkinControl.Create;
begin
  IDName := AIDName;
  PictureIndex := -1;
  MaskPictureIndex := -1;
  SkinRect := Rect(0, 0, 0, 0);
end;

procedure TbsDataSkinControl.LoadFromFile;
begin
  PictureIndex := IniFile.ReadInteger(IDName, 'pictureindex', -1);
  MaskPictureIndex := IniFile.ReadInteger(IDName, 'maskpictureindex', -1);
  SkinRect := ReadRect(IniFile, IDName, 'skinrect');
end;

procedure TbsDataSkinControl.SaveToFile;
begin
  IniFile.EraseSection(IDName);
  IniFile.WriteInteger(IDName, 'pictureindex', PictureIndex);
  IniFile.WriteInteger(IDName, 'maskpictureindex', MaskPictureIndex);
  WriteRect(IniFile, IDName, 'skinrect', SkinRect);
end;

constructor TbsDataSkinMainMenuBar.Create;
begin
  inherited;
  TrackMarkColor := 0;
  TrackMarkActiveColor := 0;
end;

procedure TbsDataSkinMainMenuBar.LoadFromFile;
begin
  inherited;
  ItemsRect := ReadRect(IniFile, IDName, 'itemsrect');
  MenuBarItem := IniFile.ReadString(IDName, 'menubaritem', '');
  CloseButton := IniFile.ReadString(IDName, 'closebutton', '');
  MinButton := IniFile.ReadString(IDName, 'minbutton', '');
  MaxButton := IniFile.ReadString(IDName, 'maxbutton', '');
  SysMenuButton := IniFile.ReadString(IDName, 'sysmenubutton', '');
  TrackMarkColor := IniFile.ReadInteger(IDName, 'trackmarkcolor', 0);
  TrackMarkActiveColor := IniFile.ReadInteger(IDName, 'trackmarkactivecolor', 0);
end;

procedure TbsDataSkinMainMenuBar.SaveToFile;
begin
  inherited;
  WriteRect(IniFile, IDName, 'itemsrect', ItemsRect);
  IniFile.WriteString(IDName, 'menubaritem', MenuBarItem);
  IniFile.WriteString(IDName, 'closebutton', CloseButton);
  IniFile.WriteString(IDName, 'minbutton', MinButton);
  IniFile.WriteString(IDName, 'maxbutton', MaxButton);
  IniFile.WriteString(IDName, 'sysmenubutton', SysMenuButton);
  IniFile.WriteInteger(IDName, 'trackmarkcolor', TrackMarkColor);
  IniFile.WriteInteger(IDName, 'trackmarkactivecolor', TrackMarkActiveColor);
end;

procedure TbsDataSkinUpDownControl.LoadFromFile(IniFile: TCustomIniFile);
begin
  inherited;
  UpButtonRect := ReadRect(IniFile, IDName, 'upbuttonrect');
  ActiveUpButtonRect := ReadRect(IniFile, IDName, 'activeupbuttonrect');
  DownUpButtonRect := ReadRect(IniFile, IDName, 'downupbuttonrect');
  DownButtonRect := ReadRect(IniFile, IDName, 'downbuttonrect');
  ActiveDownButtonRect := ReadRect(IniFile, IDName, 'activedownbuttonrect');
  DownDownButtonRect := ReadRect(IniFile, IDName, 'downdownbuttonrect');
  LTPoint := Point(0, 0);
  RTPoint := Point(0, 0);
  LBPoint := Point(0, 0);
  RBPoint := Point(0, 0);
  ClRect := NullRect;
end;

procedure TbsDataSkinUpDownControl.SaveToFile(IniFile: TCustomIniFile);
begin
  LTPoint := Point(0, 0);
  RTPoint := Point(0, 0);
  LBPoint := Point(0, 0);
  RBPoint := Point(0, 0);
  ClRect := NullRect;
  inherited;
  WriteRect(IniFile, IDName, 'upbuttonrect', UpButtonRect);
  WriteRect(IniFile, IDName, 'activeupbuttonrect', ActiveUpButtonRect);
  WriteRect(IniFile, IDName, 'downupbuttonrect', DownUpButtonRect);
  WriteRect(IniFile, IDName, 'downbuttonrect', DownButtonRect);
  WriteRect(IniFile, IDName, 'activedownbuttonrect', ActiveDownButtonRect);
  WriteRect(IniFile, IDName, 'downdownbuttonrect', DownDownButtonRect);
end;

constructor TbsDataSkinListBox.Create(AIDName: String);
begin
  inherited;
  FontName := '宋体';
  FontCharset := GB2312_CHARSET;
  FontStyle := [];
  FontHeight := -12;
  FontColor := 0;
  HScrollBarName := '';
  VScrollBarName := '';
  BothScrollBarName := '';
  CaptionFontName := '宋体';
  CaptionFontCharset := GB2312_CHARSET;
  CaptionFontStyle := [];
  CaptionFontHeight := -12;
  CaptionFontColor := 0;
  ShowFocus := False;
end;

procedure TbsDataSkinListBox.LoadFromFile;
begin
  inherited;
  //
  SItemRect := ReadRect(IniFile, IDName, 'itemrect');
  ActiveItemRect := ReadRect(IniFile, IDName, 'activeitemrect');
  FocusItemRect := ReadRect(IniFile, IDName, 'focusitemrect');
  ItemLeftOffset := IniFile.ReadInteger(IDName, 'itemleftoffset', 0);
  ItemRightOffset := IniFile.ReadInteger(IDName, 'itemrightoffset', 0);
  ItemTextRect := ReadRect(IniFile, IDName, 'itemtextrect');
  FontName := IniFile.ReadString(IDName, 'fontname', '宋体');
  FontHeight := IniFile.ReadInteger(IDName, 'fontheight', 14);
  FontStyle := ReadFontStyles(IniFile, IDName, 'fontstyle');
  FontColor := IniFile.ReadInteger(IDName, 'fontcolor', 0);
  ActiveFontColor := IniFile.ReadInteger(IDName, 'activefontcolor', 0);
  FocusFontColor := IniFile.ReadInteger(IDName, 'focusfontcolor', 0);
  //
  CaptionRect := ReadRect(IniFile, IDName, 'captionrect');
  CaptionFontName := IniFile.ReadString(IDName, 'captionfontname', '宋体');
  CaptionFontHeight := IniFile.ReadInteger(IDName, 'captionfontheight', 14);
  CaptionFontStyle := ReadFontStyles(IniFile, IDName, 'captionfontstyle');
  CaptionFontColor := IniFile.ReadInteger(IDName, 'captionfontcolor', 0);
  //
  UpButtonRect := ReadRect(IniFile, IDName, 'upbuttonrect');
  ActiveUpButtonRect := ReadRect(IniFile, IDName, 'activeupbuttonrect');
  DownUpButtonRect := ReadRect(IniFile, IDName, 'downupbuttonrect');
  DownButtonRect := ReadRect(IniFile, IDName, 'downbuttonrect');
  ActiveDownButtonRect := ReadRect(IniFile, IDName, 'activedownbuttonrect');
  DownDownButtonRect := ReadRect(IniFile, IDName, 'downdownbuttonrect');
  CheckButtonRect := ReadRect(IniFile, IDName, 'checkbuttonrect');
  ActiveCheckButtonRect := ReadRect(IniFile, IDName, 'activecheckbuttonrect');
  DownCheckButtonRect := ReadRect(IniFile, IDName, 'downcheckbuttonrect');
  //
  VScrollBarName := IniFile.ReadString(IDName, 'vscrollbarname', 'vscrollbar');
  HScrollBarName := IniFile.ReadString(IDName, 'hscrollbarname', 'hscrollbar');
  BothScrollBarName := IniFile.ReadString(IDName, 'bothhscrollbarname', 'bothhscrollbar');
  //
  ShowFocus := ReadBoolean(IniFile, IDName, 'showfocus'); 
end;

procedure TbsDataSkinListBox.SaveToFile;
begin
  inherited;
  WriteRect(IniFile, IDName, 'itemrect', SItemRect);
  WriteRect(IniFile, IDName, 'activeitemrect', ActiveItemRect);
  WriteRect(IniFile, IDName, 'focusitemrect', FocusItemRect);
  IniFile.WriteInteger(IDName, 'itemleftoffset', ItemLeftOffset);
  IniFile.WriteInteger(IDName, 'itemrightoffset', ItemRightOffset);
  WriteRect(IniFile, IDName, 'itemtextrect', ItemTextRect);
  IniFile.WriteString(IDName, 'fontname', FontName);
  IniFile.WriteInteger(IDName, 'fontheight', FontHeight);
  WriteFontStyles(IniFile, IDName, 'fontstyle', FontStyle);
  IniFile.WriteInteger(IDName, 'fontcolor', FontColor);
  IniFile.WriteInteger(IDName, 'activefontcolor', ActiveFontColor);
  IniFile.WriteInteger(IDName, 'focusfontcolor', FocusFontColor);
  //
  WriteRect(IniFile, IDName, 'captionrect', CaptionRect);
  IniFile.WriteString(IDName, 'captionfontname', CaptionFontName);
  IniFile.WriteInteger(IDName, 'captionfontheight', CaptionFontHeight);
  WriteFontStyles(IniFile, IDName, 'captionfontstyle', CaptionFontStyle);
  IniFile.WriteInteger(IDName, 'captionfontcolor', CaptionFontColor);
  //
  WriteRect(IniFile, IDName, 'upbuttonrect', UpButtonRect);
  WriteRect(IniFile, IDName, 'activeupbuttonrect', ActiveUpButtonRect);
  WriteRect(IniFile, IDName, 'downupbuttonrect', DownUpButtonRect);
  WriteRect(IniFile, IDName, 'downbuttonrect', DownButtonRect);
  WriteRect(IniFile, IDName, 'activedownbuttonrect', ActiveDownButtonRect);
  WriteRect(IniFile, IDName, 'downdownbuttonrect', DownDownButtonRect);
  WriteRect(IniFile, IDName, 'checkbuttonrect', CheckButtonRect);
  WriteRect(IniFile, IDName, 'activecheckbuttonrect', ActiveCheckButtonRect);
  WriteRect(IniFile, IDName, 'downcheckbuttonrect', DownCheckButtonRect);
  //
  IniFile.WriteString(IDName, 'vscrollbarname', VScrollBarName);
  IniFile.WriteString(IDName, 'hscrollbarname', HScrollBarName);
  IniFile.WriteString(IDName, 'bothhscrollbarname', BothScrollBarName);
  //
  WriteBoolean(IniFile, IDName, 'showfocus', ShowFocus);
end;

procedure TbsDataSkinCheckListBox.LoadFromFile;
begin
  inherited;
  ItemCheckRect := ReadRect(IniFile, IDName, 'itemcheckrect');
  CheckImageRect := ReadRect(IniFile, IDName, 'checkimagerect');
  UnCheckImageRect := ReadRect(IniFile, IDName, 'uncheckimagerect');
end;

procedure TbsDataSkinCheckListBox.SaveToFile;
begin
  inherited;
  WriteRect(IniFile, IDName, 'itemcheckrect', ItemCheckRect);
  WriteRect(IniFile, IDName, 'uncheckimagerect', UnCheckImageRect);
  WriteRect(IniFile, IDName, 'checkimagerect', CheckImageRect);
end;

constructor TbsDataSkinComboBox.Create(AIDName: String);
begin
  inherited;
  FontName := '宋体';
  FontCharset := GB2312_CHARSET;
  FontStyle := [];
  FontHeight := -12;
  FontColor := 0;
  ActiveFontColor := 0;
  FocusFontColor := 0;
  ListBoxName := '';
  ShowFocus := False;
end;

procedure TbsDataSkinComboBox.LoadFromFile;
begin
  inherited;
  ActiveSkinRect := ReadRect(IniFile, IDName, 'activeskinrect');
  //
  SItemRect := ReadRect(IniFile, IDName, 'itemrect');
  ActiveItemRect := ReadRect(IniFile, IDName, 'activeitemrect');
  FocusItemRect := ReadRect(IniFile, IDName, 'focusitemrect');
  ItemLeftOffset := IniFile.ReadInteger(IDName, 'itemleftoffset', 0);
  ItemRightOffset := IniFile.ReadInteger(IDName, 'itemrightoffset', 0);
  ItemTextRect := ReadRect(IniFile, IDName, 'itemtextrect');
  FontName := IniFile.ReadString(IDName, 'fontname', '宋体');
  FontHeight := IniFile.ReadInteger(IDName, 'fontheight', 14);
  FontStyle := ReadFontStyles(IniFile, IDName, 'fontstyle');
  FontColor := IniFile.ReadInteger(IDName, 'fontcolor', 0);
  FocusFontColor := IniFile.ReadInteger(IDName, 'focusfontcolor', 0);
  ActiveFontColor := IniFile.ReadInteger(IDName, 'activefontcolor', 0);
  //
  ListBoxName := IniFile.ReadString(IDName, 'listboxname', '');
  //
  ButtonRect := ReadRect(IniFile, IDName, 'buttonrect');
  ActiveButtonRect := ReadRect(IniFile, IDName, 'activebuttonrect');
  DownButtonRect := ReadRect(IniFile, IDName, 'downbuttonrect');
  UnEnabledButtonRect := ReadRect(IniFile, IDName, 'unenabledbuttonrect');
  //
  ItemStretchEffect := ReadBoolean(IniFile, IDName, 'itemstretcheffect');
  FocusItemStretchEffect := ReadBoolean(IniFile, IDName, 'focusitemstretcheffect');
  //
  ShowFocus := ReadBoolean(IniFile, IDName, 'showfocus');
  //
end;

procedure TbsDataSkinComboBox.SaveToFile;
begin
  inherited;
  WriteRect(IniFile, IDName, 'activeskinrect', ActiveSkinRect);
  WriteRect(IniFile, IDName, 'itemrect', SItemRect);
  WriteRect(IniFile, IDName, 'activeitemrect', ActiveItemRect);
  WriteRect(IniFile, IDName, 'focusitemrect', FocusItemRect);
  IniFile.WriteInteger(IDName, 'itemleftoffset', ItemLeftOffset);
  IniFile.WriteInteger(IDName, 'itemrightoffset', ItemRightOffset);
  WriteRect(IniFile, IDName, 'itemtextrect', ItemTextRect);
  IniFile.WriteString(IDName, 'fontname', FontName);
  IniFile.WriteInteger(IDName, 'fontheight', FontHeight);
  WriteFontStyles(IniFile, IDName, 'fontstyle', FontStyle);
  IniFile.WriteInteger(IDName, 'fontcolor', FontColor);
  IniFile.WriteInteger(IDName, 'focusfontcolor', FocusFontColor);
  IniFile.WriteInteger(IDName, 'activefontcolor', ActiveFontColor);
  //
  WriteRect(IniFile, IDName, 'buttonrect', ButtonRect);
  WriteRect(IniFile, IDName, 'activebuttonrect', ActiveButtonRect);
  WriteRect(IniFile, IDName, 'downbuttonrect', DownButtonRect);
  WriteRect(IniFile, IDName, 'unenabledbuttonrect', UnEnabledButtonRect);
  //
  IniFile.WriteString(IDName, 'listboxname', ListBoxName);
  //
  WriteBoolean(IniFile, IDName, 'itemstretcheffect', ItemStretchEffect);
  WriteBoolean(IniFile, IDName, 'focusitemstretcheffect', FocusItemStretchEffect);
  //
  WriteBoolean(IniFile, IDName, 'showfocus', ShowFocus);
  //
end;

constructor TbsDataSkinControlBar.Create(AIDName: String);
begin
  inherited;
  BGPictureIndex := -1;
end;

procedure TbsDataSkinControlBar.LoadFromFile;
begin
  inherited;
  ItemRect := ReadRect(IniFile, IDName, 'itemrect');
  BGPictureIndex := IniFile.ReadInteger(IDName, 'bgpictureindex', -1);
  HGripRect := ReadRect(IniFile, IDName, 'hgriprect');
  VGripRect := ReadRect(IniFile, IDName, 'vgriprect');
  GripOffset1 := IniFile.ReadInteger(IDName, 'gripoffset1', 0);
  GripOffset2 := IniFile.ReadInteger(IDName, 'gripoffset2', 0);
end;

procedure TbsDataSkinControlBar.SaveToFile;
begin
  inherited;
  WriteRect(IniFile, IDName, 'itemrect', ItemRect);
  IniFile.WriteInteger(IDName, 'bgpictureindex', BGPictureIndex);
  WriteRect(IniFile, IDName, 'hgriprect', HGripRect);
  WriteRect(IniFile, IDName, 'vgriprect', VGripRect);
  IniFile.WriteInteger(IDName, 'gripoffset1', GripOffset1);
  IniFile.WriteInteger(IDName, 'gripoffset2', GripOffset2);
end;

constructor TbsDataSkinSlider.Create;
begin
  inherited;
  BGColor := 0;
end;

procedure TbsDataSkinSlider.LoadFromFile;
begin
  inherited;
  BGColor := IniFile.ReadInteger(IDName, 'bgcolor', 0);
  HRulerRect := ReadRect(IniFile, IDName, 'hrulerrect');
  HThumbRect := ReadRect(IniFile, IDName, 'hthumbrect');
  VRulerRect := ReadRect(IniFile, IDName, 'vrulerrect');
  VThumbRect := ReadRect(IniFile, IDName, 'vthumbrect');
  EdgeSize := IniFile.ReadInteger(IDName, 'edgesize', 0);
  PointsColor := IniFile.ReadInteger(IDName, 'pointscolor', 0);
end;

procedure TbsDataSkinSlider.SaveToFile;
begin
  inherited;
  IniFile.WriteInteger(IDName, 'bgcolor', BGColor);
  WriteRect(IniFile, IDName, 'hrulerrect', HRulerRect);
  WriteRect(IniFile, IDName, 'hthumbrect', HThumbRect);
  WriteRect(IniFile, IDName, 'vrulerrect', VRulerRect);
  WriteRect(IniFile, IDName, 'vthumbrect', VThumbRect);
  IniFile.WriteInteger(IDName, 'edgesize', EdgeSize);
  IniFile.WriteInteger(IDName, 'pointscolor', PointsColor);
end;


constructor TbsDataSkinBevel.Create;
begin
  inherited;
  LightColor := 0;
  DarkColor := 0;
end;

procedure TbsDataSkinBevel.LoadFromFile;
begin
  inherited;
  LightColor := IniFile.ReadInteger(IDName, 'lightcolor', 0);
  DarkColor := IniFile.ReadInteger(IDName, 'darkcolor', 0);
end;

procedure TbsDataSkinBevel.SaveToFile;
begin
  inherited;
  IniFile.WriteInteger(IDName, 'lightcolor', LightColor);
  IniFile.WriteInteger(IDName, 'darkcolor', DarkColor);
end;

constructor TbsDataSkinTreeView.Create;
begin
  inherited;
  FontName := '宋体';
  FontCharset := GB2312_CHARSET;
  FontStyle := [];
  FontHeight := -12;
  FontColor := 0;
  BGColor := clWhite;
end;

procedure TbsDataSkinTreeView.LoadFromFile;
begin
  inherited;
  FontName := IniFile.ReadString(IDName, 'fontname', '宋体');
  FontHeight := IniFile.ReadInteger(IDName, 'fontheight', 14);
  FontStyle := ReadFontStyles(IniFile, IDName, 'fontstyle');
  FontColor := IniFile.ReadInteger(IDName, 'fontcolor', 0);
  BGColor := IniFile.ReadInteger(IDName, 'bgcolor', 0);
end;

procedure TbsDataSkinTreeView.SaveToFile;
begin
  inherited;
  IniFile.WriteString(IDName, 'fontname', FontName);
  IniFile.WriteInteger(IDName, 'fontheight', FontHeight);
  WriteFontStyles(IniFile, IDName, 'fontstyle', FontStyle);
  IniFile.WriteInteger(IDName, 'fontcolor', FontColor);
  IniFile.WriteInteger(IDName, 'bgcolor', BGColor);
end;

constructor TbsDataSkinListView.Create;
begin
  inherited;
  FontName := '宋体';
  FontCharset := GB2312_CHARSET;
  FontStyle := [];
  FontHeight := -12;
  FontColor := 0;
  BGColor := clWhite;
end;

procedure TbsDataSkinListView.LoadFromFile;
begin
  inherited;
  FontName := IniFile.ReadString(IDName, 'fontname', '宋体');
  FontHeight := IniFile.ReadInteger(IDName, 'fontheight', 14);
  FontStyle := ReadFontStyles(IniFile, IDName, 'fontstyle');
  FontColor := IniFile.ReadInteger(IDName, 'fontcolor', 0);
  BGColor := IniFile.ReadInteger(IDName, 'bgcolor', 0);
end;

procedure TbsDataSkinListView.SaveToFile;
begin
  inherited;
  IniFile.WriteString(IDName, 'fontname', FontName);
  IniFile.WriteInteger(IDName, 'fontheight', FontHeight);
  WriteFontStyles(IniFile, IDName, 'fontstyle', FontStyle);
  IniFile.WriteInteger(IDName, 'fontcolor', FontColor);
  IniFile.WriteInteger(IDName, 'bgcolor', BGColor);
end;

constructor TbsDataSkinRichEdit.Create;
begin
  inherited;
  FontName := '宋体';
  FontCharset := GB2312_CHARSET;
  FontStyle := [];
  FontHeight := -12;
  FontColor := 0;
  BGColor := clWhite;
end;

procedure TbsDataSkinRichEdit.LoadFromFile;
begin
  inherited;
  FontName := IniFile.ReadString(IDName, 'fontname', '宋体');
  FontHeight := IniFile.ReadInteger(IDName, 'fontheight', 14);
  FontStyle := ReadFontStyles(IniFile, IDName, 'fontstyle');
  FontColor := IniFile.ReadInteger(IDName, 'fontcolor', 0);
  BGColor := IniFile.ReadInteger(IDName, 'bgcolor', 0);
end;

procedure TbsDataSkinRichEdit.SaveToFile;
begin
  inherited;
  IniFile.WriteString(IDName, 'fontname', FontName);
  IniFile.WriteInteger(IDName, 'fontheight', FontHeight);
  WriteFontStyles(IniFile, IDName, 'fontstyle', FontStyle);
  IniFile.WriteInteger(IDName, 'fontcolor', FontColor);
  IniFile.WriteInteger(IDName, 'bgcolor', BGColor);
end;

constructor TbsDataSkinTabControl.Create(AIDName: String);
begin
  inherited;
  FontName := '宋体';
  FontCharset := GB2312_CHARSET;
  FontStyle := [];
  FontHeight := -12;
  FontColor := 0;
  ActiveFontColor := 0;
  FocusFontColor := 0;
  UpDown := '';
  BGPictureIndex := -1;
  TabStretchEffect := False;
  ShowFocus := False;
  FocusOffsetX := 0;
  FocusOffsetY := 0;
end;

procedure TbsDataSkinTabControl.LoadFromFile;
begin
  inherited;
  TabRect := ReadRect(IniFile, IDName, 'tabrect');
  ActiveTabRect := ReadRect(IniFile, IDName, 'activetabrect');
  FocusTabRect := ReadRect(IniFile, IDName, 'focustabrect');
  MouseInTabRect := ReadRect(IniFile, IDName, 'mouseintabrect');

  ClRect := ReadRect(IniFile, IDName, 'clientrect');
  BGPictureIndex := IniFile.ReadInteger(IDName, 'bgpictureindex', -1);
  LTPoint := ReadPoint(IniFile, IDName, 'lefttoppoint');
  RTPoint := Readpoint(IniFile, IDName, 'righttoppoint');
  LBPoint := ReadPoint(IniFile, IDName, 'leftbottompoint');
  RBPoint := ReadPoint(IniFile, IDName, 'rightbottompoint');

  TabLeftOffset := IniFile.ReadInteger(IDName, 'tableftoffset', 0);
  TabRightOffset := IniFile.ReadInteger(IDName, 'tabrightoffset', 0);
  TabsBGRect := ReadRect(IniFile, IDName, 'tabsbgrect');
  TabStretchEffect := ReadBoolean(IniFile, IDName, 'tabstretcheffect');

  LeftStretch := ReadBoolean(IniFile, IDName, 'leftstretch');
  TopStretch := ReadBoolean(IniFile, IDName, 'topstretch');
  RightStretch := ReadBoolean(IniFile, IDName, 'rightstretch');
  BottomStretch := ReadBoolean(IniFile, IDName, 'bottomstretch');
  
  FontName := IniFile.ReadString(IDName, 'fontname', '宋体');
  FontHeight := IniFile.ReadInteger(IDName, 'fontheight', 14);
  FontStyle := ReadFontStyles(IniFile, IDName, 'fontstyle');
  FontColor := IniFile.ReadInteger(IDName, 'fontcolor', 0);
  ActiveFontColor := IniFile.ReadInteger(IDName, 'activefontcolor', 0);
  FocusFontColor := IniFile.ReadInteger(IDName, 'focusfontcolor', 0);
  MouseInFontColor := IniFile.ReadInteger(IDName, 'mouseinfontcolor', 0);

  UpDown := IniFile.ReadString(IDName, 'updown', '');
  ShowFocus := ReadBoolean(IniFile, IDName, 'showfocus');

  FocusOffsetX := IniFile.ReadInteger(IDName, 'focusoffsetx', 0);
  FocusOffsetY := IniFile.ReadInteger(IDName, 'focusoffsety', 0);
end;

procedure TbsDataSkinTabControl.SaveToFile;
begin
  inherited;
  WriteRect(IniFile, IDName, 'tabrect', TabRect);
  WriteRect(IniFile, IDName, 'activetabrect', ActiveTabRect);
  WriteRect(IniFile, IDName, 'focustabrect', FocusTabRect);
  WriteRect(IniFile, IDName, 'mouseintabrect',  MouseInTabRect);

  WriteRect(IniFile, IDName, 'clientrect', ClRect);
  IniFile.WriteInteger(IDName, 'bgpictureindex', BGPictureIndex);

  WritePoint(IniFile, IDName, 'lefttoppoint', LTPoint);
  writePoint(IniFile, IDName, 'righttoppoint', RTPoint);
  WritePoint(IniFile, IDName, 'leftbottompoint', LBPoint);
  WritePoint(IniFile, IDName, 'rightbottompoint', RBPoint);

  IniFile.WriteInteger(IDName, 'tableftoffset', TabLeftOffset);
  IniFile.WriteInteger(IDName, 'tabrightoffset', TabRightOffset);
  WriteRect(IniFile, IDName, 'tabsbgrect', TabsBGRect);
  WriteBoolean(IniFile, IDName, 'tabstretcheffect', TabStretchEffect);

  WriteBoolean(IniFile, IDName, 'leftstretch', LeftStretch);
  WriteBoolean(IniFile, IDName, 'topstretch', TopStretch);
  WriteBoolean(IniFile, IDName, 'rightstretch', RightStretch);
  WriteBoolean(IniFile, IDName, 'bottomstretch', BottomStretch);

  IniFile.WriteString(IDName, 'fontname', FontName);
  IniFile.WriteInteger(IDName, 'fontheight', FontHeight);
  WriteFontStyles(IniFile, IDName, 'fontstyle', FontStyle);
  IniFile.WriteInteger(IDName, 'fontcolor', FontColor);
  IniFile.WriteInteger(IDName, 'activefontcolor', ActiveFontColor);
  IniFile.WriteInteger(IDName, 'focusfontcolor', FocusFontColor);
  IniFile.WriteInteger(IDName, 'mouseinfontcolor', MouseInFontColor);

  IniFile.WriteString(IDName, 'updown', UpDown);
  WriteBoolean(IniFile, IDName, 'showfocus', ShowFocus);

  IniFile.WriteInteger(IDName, 'focusoffsetx', FocusOffsetX);
  IniFile.WriteInteger(IDName, 'focusoffsety', FocusOffsetY);
  
end;

constructor TbsDataSkinGridControl.Create;
begin
  inherited;
  FontName := '宋体';
  FontCharset := GB2312_CHARSET;
  FontStyle := [];
  FontHeight := -12;
  FontColor := 0;
  FixedFontName := '宋体';
  FixedFontCharset := GB2312_CHARSET;
  FixedFontStyle := [];
  FixedFontHeight := -12;
  FixedFontColor := 0;
  ShowFocus := False;
end;

procedure TbsDataSkinGridControl.LoadFromFile(IniFile: TCustomIniFile);
begin
  inherited;
  FixedCellRect := ReadRect(IniFile, IDName, 'fixedcellrect');
  SelectCellRect := ReadRect(IniFile, IDName, 'selectcellrect');
  FocusCellRect := ReadRect(IniFile, IDName, 'focuscellrect');
  //
  FixedCellLeftOffset := IniFile.ReadInteger(IDName, 'fixedcellleftoffset', 0);
  FixedCellRightOffset := IniFile.ReadInteger(IDName, 'fixedcellrightoffset', 0);
  FixedCellTextRect := ReadRect(IniFile, IDName, 'fixedcelltextrect');
  //
  CellLeftOffset := IniFile.ReadInteger(IDName, 'cellleftoffset', 0);
  CellRightOffset := IniFile.ReadInteger(IDName, 'cellrightoffset', 0);
  CellTextRect := ReadRect(IniFile, IDName, 'celltextrect');
  //
  LinesColor := IniFile.ReadInteger(IDName, 'linescolor', 0);
  BGColor := IniFile.ReadInteger(IDName, 'bgcolor', 0);
  FontName := IniFile.ReadString(IDName, 'fontname', '宋体');
  FontCharset := IniFile.ReadInteger(IDName, 'FontCharset', GB2312_CHARSET);
  FontHeight := IniFile.ReadInteger(IDName, 'fontheight', 14);
  FontStyle := ReadFontStyles(IniFile, IDName, 'fontstyle');
  FontColor := IniFile.ReadInteger(IDName, 'fontcolor', 0);
  SelectFontColor := IniFile.ReadInteger(IDName, 'selectfontcolor', 0);
  FocusFontColor := IniFile.ReadInteger(IDName, 'focusfontcolor', 0);
  //
  FixedFontName := IniFile.ReadString(IDName, 'fixedfontname', '宋体');
  FixedFontCharset := IniFile.ReadInteger(IDName, 'FixedFontCharset', GB2312_CHARSET);
  FixedFontHeight := IniFile.ReadInteger(IDName, 'fixedfontheight', 14);
  FixedFontStyle := ReadFontStyles(IniFile, IDName, 'fixedfontstyle');
  FixedFontColor := IniFile.ReadInteger(IDName, 'fixedfontcolor', 0);
  //
  CellStretchEffect := ReadBoolean(IniFile, IDName, 'cellstretcheffect');
  FixedCellStretchEffect := ReadBoolean(IniFile, IDName, 'fixedcellstretcheffect');
  ShowFocus := ReadBoolean(IniFile, IDName, 'showfocus');
end;

procedure TbsDataSkinGridControl.SaveToFile(IniFile: TCustomIniFile);
begin
  inherited;
  WriteRect(IniFile, IDName, 'fixedcellrect', FixedCellRect);
  WriteRect(IniFile, IDName, 'selectcellrect', SelectCellRect);
  WriteRect(IniFile, IDName, 'focuscellrect', FocusCellRect);
  //
  IniFile.WriteInteger(IDName, 'fixedcellleftoffset', FixedCellLeftOffset);
  IniFile.WriteInteger(IDName, 'fixedcellrightoffset', FixedCellRightOffset);
  WriteRect(IniFile, IDName, 'fixedcelltextrect', FixedCellTextRect);
  //
  IniFile.WriteInteger(IDName, 'cellleftoffset', CellLeftOffset);
  IniFile.WriteInteger(IDName, 'cellrightoffset', CellRightOffset);
  WriteRect(IniFile, IDName, 'celltextrect', CellTextRect);
  //
  IniFile.WriteInteger(IDName, 'linescolor', LinesColor);
  IniFile.WriteInteger(IDName, 'bgcolor', BGColor);

  IniFile.WriteString(IDName, 'fontname', FontName);
  IniFile.WriteInteger(IDName, 'FontCharset', FontCharset);
  IniFile.WriteInteger(IDName, 'fontheight', FontHeight);
  WriteFontStyles(IniFile, IDName, 'fontstyle', FontStyle);
  IniFile.WriteInteger(IDName, 'fontcolor', FontColor);
  IniFile.WriteInteger(IDName, 'selectfontcolor', SelectFontColor);
  IniFile.WriteInteger(IDName, 'focusfontcolor', FocusFontColor);
  //
  IniFile.WriteString(IDName, 'fixedfontname', FixedFontName);
  IniFile.WriteInteger(IDName, 'FixedFontCharset', FixedFontCharset);
  IniFile.WriteInteger(IDName, 'fixedfontheight', FixedFontHeight);
  WriteFontStyles(IniFile, IDName, 'fixedfontstyle', FixedFontStyle);
  IniFile.WriteInteger(IDName, 'fixedfontcolor', FixedFontColor);
  //
  WriteBoolean(IniFile, IDName, 'cellstretcheffect', CellStretchEffect);
  WriteBoolean(IniFile, IDName, 'fixedcellstretcheffect', FixedCellStretchEffect);
  WriteBoolean(IniFile, IDName, 'showfocus', ShowFocus);
end;

constructor TbsDataSkinCustomControl.Create;
begin
  inherited;
  LTPoint := Point(0, 0);
  RBPoint := Point(0, 0);
  LBPoint := Point(0, 0);
  RTPoint := Point(0, 0);
  ClRect := Rect(0, 0, 0, 0);
  MaskPictureIndex := -1;
  LeftStretch := False;
  TopStretch := False;
  RightStretch := False;
  BottomStretch := False;
  StretchEffect := False;
end;

procedure TbsDataSkinCustomControl.LoadFromFile;
begin
  inherited;
  LTPoint := ReadPoint(IniFile, IDName, 'lefttoppoint');
  RTPoint := ReadPoint(IniFile, IDName, 'righttoppoint');
  LBPoint := ReadPoint(IniFile, IDName, 'leftbottompoint');
  RBPoint := ReadPoint(IniFile, IDName, 'rightbottompoint');
  ClRect := ReadRect(IniFile, IDName, 'clientrect');
  LeftStretch := ReadBoolean(IniFile, IDName, 'leftstretch');
  TopStretch := ReadBoolean(IniFile, IDName, 'topstretch');
  RightStretch := ReadBoolean(IniFile, IDName, 'rightstretch');
  BottomStretch := ReadBoolean(IniFile, IDName, 'bottomstretch');
  StretchEffect := ReadBoolean(IniFile, IDName, 'stretcheffect');
end;

procedure TbsDataSkinCustomControl.SaveToFile;
begin
  inherited;
  WritePoint(IniFile, IDName, 'lefttoppoint', LTPoint);
  WritePoint(IniFile, IDName, 'righttoppoint', RTPoint);
  WritePoint(IniFile, IDName, 'leftbottompoint', LBPoint);
  WritePoint(IniFile, IDName, 'rightbottompoint', RBPoint);
  WriteRect(IniFile, IDName, 'clientrect', ClRect);
  WriteBoolean(IniFile, IDName, 'leftstretch', LeftStretch);
  WriteBoolean(IniFile, IDName, 'topstretch', TopStretch);
  WriteBoolean(IniFile, IDName, 'rightstretch', RightStretch);
  WriteBoolean(IniFile, IDName, 'bottomstretch', BottomStretch);
  WriteBoolean(IniFile, IDName, 'stretcheffect', StretchEffect);
end;

constructor TbsDataSkinSpinEditControl.Create;
begin
  inherited;
  FontName := '宋体';
  FontCharset := GB2312_CHARSET;
  FontStyle := [];
  FontHeight := 12;
  FontColor := 0;
  DisabledFontColor := 0;
  ActiveFontColor := 0;
end;

procedure TbsDataSkinSpinEditControl.LoadFromFile;
begin
  inherited;
  ActiveSkinRect := ReadRect(IniFile, IDName, 'activeskinrect');
  FontName := IniFile.ReadString(IDName, 'fontname', '宋体');
  FontCharset := IniFile.ReadInteger(IDName, 'FontCharset', 134);
  FontHeight := IniFile.ReadInteger(IDName, 'fontheight', 14);
  FontStyle := ReadFontStyles(IniFile, IDName, 'fontstyle');
  FontColor := IniFile.ReadInteger(IDName, 'fontcolor', 0);
  ActiveFontColor := IniFile.ReadInteger(IDName, 'activefontcolor', 0);
  DisabledFontColor := IniFile.ReadInteger(IDName, 'disabledfontcolor', 0);
  UpButtonRect := ReadRect(IniFile, IDName, 'upbuttonrect');
  ActiveUpButtonRect := ReadRect(IniFile, IDName, 'activeupbuttonrect');
  DownUpButtonRect := ReadRect(IniFile, IDName, 'downupbuttonrect');
  DownButtonRect := ReadRect(IniFile, IDName, 'downbuttonrect');
  ActiveDownButtonRect := ReadRect(IniFile, IDName, 'activedownbuttonrect');
  DownDownButtonRect := ReadRect(IniFile, IDName, 'downdownbuttonrect');
end;

procedure TbsDataSkinSpinEditControl.SaveToFile;
begin
  inherited;
  WriteRect(IniFile, IDName, 'activeskinrect', ActiveSkinRect);
  IniFile.WriteString(IDName, 'fontname', FontName);
  IniFile.WriteInteger(IDName, 'FontCharset', FontCharset);
  IniFile.WriteInteger(IDName, 'fontheight', FontHeight);
  WriteFontStyles(IniFile, IDName, 'fontstyle', FontStyle);
  IniFile.WriteInteger(IDName, 'fontcolor', FontColor);
  IniFile.WriteInteger(IDName, 'activefontcolor', ActiveFontColor);
  IniFile.WriteInteger(IDName, 'disabledfontcolor', DisabledFontColor);
  WriteRect(IniFile, IDName, 'upbuttonrect', UpButtonRect);
  WriteRect(IniFile, IDName, 'activeupbuttonrect', ActiveUpButtonRect);
  WriteRect(IniFile, IDName, 'downupbuttonrect', DownUpButtonRect);
  WriteRect(IniFile, IDName, 'downbuttonrect', DownButtonRect);
  WriteRect(IniFile, IDName, 'activedownbuttonrect', ActiveDownButtonRect);
  WriteRect(IniFile, IDName, 'downdownbuttonrect', DownDownButtonRect);
end;


constructor TbsDataSkinEditControl.Create;
begin
  inherited;
  FontName := '宋体';
  FontCharset := GB2312_CHARSET;
  FontStyle := [];
  FontHeight := 12;
  FontColor := 0;
  ActiveFontColor := 0;
end;

procedure TbsDataSkinEditControl.LoadFromFile;
begin
  inherited;
  ActiveSkinRect := ReadRect(IniFile, IDName, 'activeskinrect');
  FontName := IniFile.ReadString(IDName, 'fontname', '宋体');
  FontCharset := IniFile.ReadInteger(IDName, 'FontCharset', FontCharset);
  FontHeight := IniFile.ReadInteger(IDName, 'fontheight', 14);
  FontStyle := ReadFontStyles(IniFile, IDName, 'fontstyle');
  FontColor := IniFile.ReadInteger(IDName, 'fontcolor', 0);
  DisabledFontColor := IniFile.ReadInteger(IDName, 'disabledfontcolor', 0);
  ActiveFontColor := IniFile.ReadInteger(IDName, 'activefontcolor', 0);
  ButtonRect := ReadRect(IniFile, IDName, 'buttonrect');
  ActiveButtonRect := ReadRect(IniFile, IDName, 'activebuttonrect');
  DownButtonRect := ReadRect(IniFile, IDName, 'downbuttonrect');
  UnEnabledButtonRect := ReadRect(IniFile, IDName, 'unenabledbuttonrect');
end;

procedure TbsDataSkinEditControl.SaveToFile;
begin
  inherited;
  WriteRect(IniFile, IDName, 'activeskinrect', ActiveSkinRect);
  IniFile.WriteString(IDName, 'fontname', FontName);
  IniFile.WriteInteger(IDName, 'fontheight', FontHeight);
  WriteFontStyles(IniFile, IDName, 'fontstyle', FontStyle);
  IniFile.WriteInteger(IDName, 'fontcolor', FontColor);
  IniFile.WriteInteger(IDName, 'disabledfontcolor', DisabledFontColor);
  IniFile.WriteInteger(IDName, 'activefontcolor', ActiveFontColor);
  WriteRect(IniFile, IDName, 'buttonrect', ButtonRect);
  WriteRect(IniFile, IDName, 'activebuttonrect', ActiveButtonRect);
  WriteRect(IniFile, IDName, 'downbuttonrect', DownButtonRect);
  WriteRect(IniFile, IDName, 'unenabledbuttonrect', UnEnabledButtonRect);
end;

constructor TbsDataSkinMemoControl.Create(AIDName: String);
begin
  inherited;
end;

procedure TbsDataSkinMemoControl.LoadFromFile;
begin
  inherited;
  BGColor := IniFile.ReadInteger(IDName, 'bgcolor', 0);
  ActiveBGColor := IniFile.ReadInteger(IDName, 'activebgcolor', 0);
end;

procedure TbsDataSkinMemoControl.SaveToFile;
begin
  inherited;
  IniFile.WriteInteger(IDName, 'bgcolor', BGColor);
  IniFile.WriteInteger(IDName, 'activebgcolor', ActiveBGColor);
end;

constructor TbsDataSkinStdLabelControl.Create;
begin
  inherited;
  FontName := '宋体';
  FontCharset := GB2312_CHARSET;
  FontStyle := [];
  FontHeight := -12;
  FontColor := 0;
  ActiveFontColor := clBlue;
end;

procedure TbsDataSkinStdLabelControl.LoadFromFile;
begin
  inherited;
  FontName := IniFile.ReadString(IDName, 'fontname', '宋体');
  FontHeight := IniFile.ReadInteger(IDName, 'fontheight', 14);
  FontStyle := ReadFontStyles(IniFile, IDName, 'fontstyle');
  FontColor := IniFile.ReadInteger(IDName, 'fontcolor', 0);
  ActiveFontColor := IniFile.ReadInteger(IDName, 'activefontcolor', clBlue);
end;

procedure TbsDataSkinStdLabelControl.SaveToFile;
begin
  inherited;
  IniFile.WriteString(IDName, 'fontname', FontName);
  IniFile.WriteInteger(IDName, 'fontheight', FontHeight);
  WriteFontStyles(IniFile, IDName, 'fontstyle', FontStyle);
  IniFile.WriteInteger(IDName, 'fontcolor', FontColor);
  IniFile.WriteInteger(IDName, 'activefontcolor', ActiveFontColor);
end;

constructor TbsDataSkinLabelControl.Create;
begin
  inherited;
  FontName := '宋体';
  FontCharset := GB2312_CHARSET;
  FontStyle := [];
  FontHeight := 12;
  FontColor := 0;
end;

procedure TbsDataSkinLabelControl.LoadFromFile;
begin
  inherited;
  FontName := IniFile.ReadString(IDName, 'fontname', '宋体');
  FontHeight := IniFile.ReadInteger(IDName, 'fontheight', 14);
  FontStyle := ReadFontStyles(IniFile, IDName, 'fontstyle');
  FontColor := IniFile.ReadInteger(IDName, 'fontcolor', 0);
end;

procedure TbsDataSkinLabelControl.SaveToFile;
begin
  inherited;
  IniFile.WriteString(IDName, 'fontname', FontName);
  IniFile.WriteInteger(IDName, 'fontheight', FontHeight);
  WriteFontStyles(IniFile, IDName, 'fontstyle', FontStyle);
  IniFile.WriteInteger(IDName, 'fontcolor', FontColor);
end;



constructor TbsDataSkinScrollBarControl.Create;
begin
  inherited;
  ThumbOffset1 := 0;
  ThumbOffset2 := 0;
  ThumbTransparent := False;
  ThumbTransparentColor := clFuchsia;
end;

procedure TbsDataSkinScrollBarControl.LoadFromFile;
begin
  inherited;
  TrackArea := ReadRect(IniFile, IDName, 'trackarea');

  UpButtonRect := ReadRect(IniFile, IDName, 'upbuttonrect');
  ActiveUpButtonRect := ReadRect(IniFile, IDName, 'activeupbuttonrect');
  DownUpButtonRect := ReadRect(IniFile, IDName, 'downupbuttonrect');

  DownButtonRect := ReadRect(IniFile, IDName, 'downbuttonrect');
  ActiveDownButtonRect := ReadRect(IniFile, IDName, 'activedownbuttonrect');
  DownDownButtonRect := ReadRect(IniFile, IDName, 'downdownbuttonrect');

  ThumbRect := ReadRect(IniFile, IDName, 'thumbrect');
  ActiveThumbRect := ReadRect(IniFile, IDName, 'activethumbrect');
  DownThumbRect := ReadRect(IniFile, IDName, 'downthumbrect');
  ThumbOffset1 := IniFile.ReadInteger(IDName, 'thumboffset1', 0);
  ThumbOffset2 := IniFile.ReadInteger(IDName, 'thumboffset2', 0);
  ThumbTransparent := ReadBoolean(IniFile, IDName, 'thumbtransparent');
  ThumbTransparentColor := IniFile.ReadInteger(IDName, 'thumbtransparentcolor', 0);

  GlyphRect := ReadRect(IniFile, IDName, 'glyphrect');
  ActiveGlyphRect := ReadRect(IniFile, IDName, 'activeglyphrect');
  DownGlyphRect := ReadRect(IniFile, IDName, 'downglyphrect');
end;

procedure TbsDataSkinScrollBarControl.SaveToFile;
begin
  inherited;
  WriteRect(IniFile, IDName, 'trackarea', TrackArea);

  WriteRect(IniFile, IDName, 'upbuttonrect', UpButtonRect);
  WriteRect(IniFile, IDName, 'activeupbuttonrect', ActiveUpButtonRect);
  WriteRect(IniFile, IDName, 'downupbuttonrect', DownUpButtonRect);

  WriteRect(IniFile, IDName, 'downbuttonrect', DownButtonRect);
  WriteRect(IniFile, IDName, 'activedownbuttonrect', ActiveDownButtonRect);
  WriteRect(IniFile, IDName, 'downdownbuttonrect', DownDownButtonRect);

  WriteRect(IniFile, IDName, 'thumbrect', ThumbRect);
  WriteRect(IniFile, IDName, 'activethumbrect', ActiveThumbRect);
  WriteRect(IniFile, IDName, 'downthumbrect', DownThumbRect);

  IniFile.WriteInteger(IDName, 'thumboffset1', ThumbOffset1);
  IniFile.WriteInteger(IDName, 'thumboffset2', ThumbOffset2);

  WriteBoolean(IniFile, IDName, 'thumbtransparent', ThumbTransparent);
  IniFile.WriteInteger(IDName, 'thumbtransparentcolor', ThumbTransparentColor);

  WriteRect(IniFile, IDName, 'glyphrect', GlyphRect);
  WriteRect(IniFile, IDName, 'activeglyphrect', ActiveGlyphRect);
  WriteRect(IniFile, IDName, 'downglyphrect', DownGlyphRect);
end;

constructor TbsDataSkinTrackBarControl.Create;
begin
  inherited;
  TrackArea := NullRect;
  ButtonRect := NullRect;
  ActiveButtonRect := NullRect;
  Vertical := False;
  ButtonTransparent := False;
  ButtonTransparentColor := clFuchsia;
end;

procedure TbsDataSkinTrackBarControl.LoadFromFile;
begin
  inherited;
  TrackArea := ReadRect(IniFile, IDName, 'trackarea');
  ButtonRect := ReadRect(IniFile, IDName, 'buttonrect');
  ActiveButtonRect := ReadRect(IniFile, IDName, 'activebuttonrect');
  Vertical := ReadBoolean(IniFile, IDName, 'vertical');
  ButtonTransparent := ReadBoolean(IniFile, IDName, 'buttontransparent');
  ButtonTransparentColor := IniFile.ReadInteger(IDName, 'buttontransparentcolor', 0);
end;

procedure TbsDataSkinTrackBarControl.SaveToFile;
begin
  inherited;
  WriteRect(IniFile, IDName, 'trackarea', TrackArea);
  WriteRect(IniFile, IDName, 'buttonrect', ButtonRect);
  WriteRect(IniFile, IDName, 'activebuttonrect', ActiveButtonRect);
  WriteBoolean(IniFile, IDName, 'vertical', Vertical);
  WriteBoolean(IniFile, IDName, 'buttontransparent', ButtonTransparent);
  IniFile.WriteInteger(IDName, 'buttontransparentcolor', ButtonTransparentColor);
end;


constructor TbsDataSkinSplitterControl.Create(AIDName: String);
begin
  inherited;
  GripperRect := NullRect;
  GripperTransparent := False;
  GripperTransparentColor := clFuchsia;
end;

procedure TbsDataSkinSplitterControl.LoadFromFile(IniFile: TCustomIniFile);
begin
  inherited;
  GripperRect := ReadRect(IniFile, IDName, 'gripperrect');
  GripperTransparent := ReadBoolean(IniFile, IDName, 'grippertransparent');
  GripperTransparentColor := IniFile.ReadInteger(IDName, 'grippertransparentcolor', 0);
end;

procedure TbsDataSkinSplitterControl.SaveToFile(IniFile: TCustomIniFile);
begin
  inherited;
  WriteRect(IniFile, IDName, 'gripperrect', GripperRect);
  WriteBoolean(IniFile, IDName, 'grippertransparent', GripperTransparent);
  IniFile.WriteInteger(IDName, 'grippertransparentcolor', GripperTransparentColor);
end;

constructor TbsDataSkinGaugeControl.Create;
begin
  inherited;
  ProgressArea := NullRect;
  ProgressRect := NullRect;
  Vertical := False;
  BeginOffset := 0;
  EndOffset := 0;
  FontName := '宋体';
  FontCharset := GB2312_CHARSET;
  FontStyle := [];
  FontHeight := -12;
  FontColor := 0;
  ProgressTransparent := False;
  ProgressTransparentColor := clFuchsia;
  ProgressStretch := False;
end;

procedure TbsDataSkinGaugeControl.LoadFromFile;
begin
  inherited;
  ProgressArea := ReadRect(IniFile, IDName, 'progressarea');
  ProgressRect := ReadRect(IniFile, IDName, 'progressrect');
  BeginOffset := IniFile.ReadInteger(IDName, 'beginoffset', 0);
  EndOffset := IniFile.ReadInteger(IDName, 'endoffset', 0);
  Vertical := ReadBoolean(IniFile, IDName, 'vertical');
  FontName := IniFile.ReadString(IDName, 'fontname', '宋体');
  FontHeight := IniFile.ReadInteger(IDName, 'fontheight', 14);
  FontStyle := ReadFontStyles(IniFile, IDName, 'fontstyle');
  FontColor := IniFile.ReadInteger(IDName, 'fontcolor', 0);
  ProgressTransparent := ReadBoolean(IniFile, IDName, 'progresstransparent');
  ProgressTransparentColor := IniFile.ReadInteger(IDName, 'progresstransparentcolor', 0);
  ProgressStretch := ReadBoolean(IniFile, IDName, 'progressstretch');
end;

procedure TbsDataSkinGaugeControl.SaveToFile;
begin
  inherited;
  WriteRect(IniFile, IDName, 'progressarea', ProgressArea);
  WriteRect(IniFile, IDName, 'progressrect', ProgressRect);
  IniFile.WriteInteger(IDName, 'beginoffset', BeginOffset);
  IniFile.WriteInteger(IDName, 'endoffset', EndOffset);
  WriteBoolean(IniFile, IDName, 'vertical', Vertical);
  IniFile.WriteString(IDName, 'fontname', FontName);
  IniFile.WriteInteger(IDName, 'fontheight', FontHeight);
  WriteFontStyles(IniFile, IDName, 'fontstyle', FontStyle);
  IniFile.WriteInteger(IDName, 'fontcolor', FontColor);
  WriteBoolean(IniFile, IDName, 'progresstransparent', ProgressTransparent);
  IniFile.WriteInteger(IDName, 'progresstransparentcolor', ProgressTransparentColor);
  WriteBoolean(IniFile, IDName, 'progressstretch', ProgressStretch);
end;

constructor TbsDataSkinScrollBoxControl.Create(AIDName: String);
begin
  inherited;
  BGPictureIndex := -1;
end;

procedure TbsDataSkinScrollBoxControl.LoadFromFile(IniFile: TCustomIniFile);
begin
  inherited;
  BGPictureIndex := IniFile.ReadInteger(IDName, 'bgpictureindex', -1);
end;

procedure TbsDataSkinScrollBoxControl.SaveToFile(IniFile: TCustomIniFile);
begin
  inherited;
  IniFile.WriteInteger(IDName, 'bgpictureindex', BGPictureIndex);
end;

constructor TbsDataSkinExPanelControl.Create(AIDName: String);
begin
  inherited;
  FontName := '宋体';
  FontCharset := GB2312_CHARSET;
  FontStyle := [];
  FontHeight := 12;
  FontColor := 0;
end;

procedure TbsDataSkinExPanelControl.LoadFromFile(IniFile: TCustomIniFile);
begin
  inherited;
  RollHSkinRect := ReadRect(IniFile, IDName, 'rollhskinrect');
  RollVSkinRect := ReadRect(IniFile, IDName, 'rollvskinrect');
  RollLeftOffset := IniFile.ReadInteger(IDName, 'rollleftoffset', 0);
  RollRightOffset := IniFile.ReadInteger(IDName, 'rollrightoffset', 0);
  RollTopOffset := IniFile.ReadInteger(IDName, 'rolltopoffset', 0);
  RollBottomOffset := IniFile.ReadInteger(IDName, 'rollbottomoffset', 0);
  RollVCaptionRect := ReadRect(IniFile, IDName, 'rollvcaptionrect');
  RollHCaptionRect := ReadRect(IniFile, IDName, 'rollhcaptionrect');
  //
  CloseButtonRect := ReadRect(IniFile, IDName, 'closebuttonrect');
  CloseButtonActiveRect := ReadRect(IniFile, IDName, 'closebuttonactiverect');
  CloseButtonDownRect := ReadRect(IniFile, IDName, 'closebuttondownrect');
  HRollButtonRect := ReadRect(IniFile, IDName, 'hrollbuttonrect');
  HRollButtonActiveRect := ReadRect(IniFile, IDName, 'hrollbuttonactiverect');
  HRollButtonDownRect := ReadRect(IniFile, IDName, 'hrollbuttondownrect');
  HRestoreButtonRect := ReadRect(IniFile, IDName, 'hrestorebuttonrect');
  HRestoreButtonActiveRect := ReadRect(IniFile, IDName, 'hrestorebuttonactiverect');
  HRestoreButtonDownRect := ReadRect(IniFile, IDName, 'hrestorebuttondownrect');

  VRollButtonRect := ReadRect(IniFile, IDName, 'vrollbuttonrect');
  VRollButtonActiveRect := ReadRect(IniFile, IDName, 'vrollbuttonactiverect');
  VRollButtonDownRect := ReadRect(IniFile, IDName, 'vrollbuttondownrect');

  VRestoreButtonRect := ReadRect(IniFile, IDName, 'vrestorebuttonrect');
  VRestoreButtonActiveRect := ReadRect(IniFile, IDName, 'vrestorebuttonactiverect');
  VRestoreButtonDownRect := ReadRect(IniFile, IDName, 'vrestorebuttondownrect');
  //
  CaptionRect := ReadRect(IniFile, IDName, 'captionrect');
  FontName := IniFile.ReadString(IDName, 'fontname', '宋体');
  FontHeight := IniFile.ReadInteger(IDName, 'fontheight', 14);
  FontStyle := ReadFontStyles(IniFile, IDName, 'fontstyle');
  FontColor := IniFile.ReadInteger(IDName, 'fontcolor', 0);
end;

procedure TbsDataSkinExPanelControl.SaveToFile(IniFile: TCustomIniFile);
begin
  inherited;
  WriteRect(IniFile, IDName, 'rollhskinrect', RollHSkinRect);
  WriteRect(IniFile, IDName, 'rollvskinrect', RollVSkinRect);
  IniFile.WriteInteger(IDName, 'rollleftoffset', RollLeftOffset);
  IniFile.WriteInteger(IDName, 'rollrightoffset', RollRightOffset);
  IniFile.WriteInteger(IDName, 'rolltopoffset', RollTopOffset);
  IniFile.WriteInteger(IDName, 'rollbottomoffset', RollBottomOffset);
  WriteRect(IniFile, IDName, 'rollvcaptionrect', RollVCaptionRect);
  WriteRect(IniFile, IDName, 'rollhcaptionrect', RollHCaptionRect);
  //
  WriteRect(IniFile, IDName, 'closebuttonrect', CloseButtonRect);
  WriteRect(IniFile, IDName, 'closebuttonactiverect', CloseButtonActiveRect);
  WriteRect(IniFile, IDName, 'closebuttondownrect', CloseButtonDownRect);
  WriteRect(IniFile, IDName, 'hrollbuttonrect', HRollButtonRect);
  WriteRect(IniFile, IDName, 'hrollbuttonactiverect', HRollButtonActiveRect);
  WriteRect(IniFile, IDName, 'hrollbuttondownrect', HRollButtonDownRect);
  WriteRect(IniFile, IDName, 'hrestorebuttonrect', HRestoreButtonRect);
  WriteRect(IniFile, IDName, 'hrestorebuttonactiverect', HRestoreButtonActiveRect);
  WriteRect(IniFile, IDName, 'hrestorebuttondownrect', HRestoreButtonDownRect);
  WriteRect(IniFile, IDName, 'vrollbuttonrect', VRollButtonRect);
  WriteRect(IniFile, IDName, 'vrollbuttonactiverect', VRollButtonActiveRect);
  WriteRect(IniFile, IDName, 'vrollbuttondownrect', VRollButtonDownRect);
  WriteRect(IniFile, IDName, 'vrestorebuttonrect', VRestoreButtonRect);
  WriteRect(IniFile, IDName, 'vrestorebuttonactiverect', VRestoreButtonActiveRect);
  WriteRect(IniFile, IDName, 'vrestorebuttondownrect', VRestoreButtonDownRect);
  //
  WriteRect(IniFile, IDName, 'captionrect', CaptionRect);
  IniFile.WriteString(IDName, 'fontname', FontName);
  IniFile.WriteInteger(IDName, 'fontheight', FontHeight);
  WriteFontStyles(IniFile, IDName, 'fontstyle', FontStyle);
  IniFile.WriteInteger(IDName, 'fontcolor', FontColor);
end;

constructor TbsDataSkinPanelControl.Create;
begin
  inherited;
  CaptionRect := NullRect;
  FontName := '宋体';
  FontCharset := GB2312_CHARSET;
  FontStyle := [];
  FontHeight := 12;
  FontColor := 0;
  Alignment := taCenter;
  BGPictureIndex := -1;
  GripperRect := NullRect;
  GripperTransparent := False;
  GripperTransparentColor := clFuchsia;
end;

procedure TbsDataSkinPanelControl.LoadFromFile;
begin
  inherited;
  BGPictureIndex := IniFile.ReadInteger(IDName, 'bgpictureindex', -1);
  CaptionRect := ReadRect(IniFile, IDName, 'captionrect');
  Alignment := ReadAlignment(IniFile, IDName, 'alignment');
  FontName := IniFile.ReadString(IDName, 'fontname', '宋体');
  FontHeight := IniFile.ReadInteger(IDName, 'fontheight', 14);
  FontStyle := ReadFontStyles(IniFile, IDName, 'fontstyle');
  FontColor := IniFile.ReadInteger(IDName, 'fontcolor', 0);
  CheckImageRect := ReadRect(IniFile, IDName, 'checkimagerect');
  UnCheckImageRect := ReadRect(IniFile, IDName, 'uncheckimagerect');
  //
  MarkFrameRect := ReadRect(IniFile, IDName, 'markframerect');
  FrameRect := ReadRect(IniFile, IDName, 'framerect');
  FrameTextRect := ReadRect(IniFile, IDName, 'frametextrect');
  FrameLeftOffset := IniFile.ReadInteger(IDName, 'frameleftoffset', 0);
  FrameRightOffset := IniFile.ReadInteger(IDName, 'framerightoffset', 0);
  //
  GripperRect := ReadRect(IniFile, IDName, 'gripperrect');
  GripperTransparent := ReadBoolean(IniFile, IDName, 'grippertransparent');
  GripperTransparentColor := IniFile.ReadInteger(IDName, 'grippertransparentcolor', 0);
end;

procedure TbsDataSkinPanelControl.SaveToFile;
begin
  inherited;
  IniFile.WriteInteger(IDName, 'bgpictureindex', BGPictureIndex);
  WriteRect(IniFile, IDName, 'captionrect', CaptionRect);
  WriteAlignment(IniFile, IDName, 'alignment', Alignment);
  IniFile.WriteString(IDName, 'fontname', FontName);
  IniFile.WriteInteger(IDName, 'fontheight', FontHeight);
  WriteFontStyles(IniFile, IDName, 'fontstyle', FontStyle);
  IniFile.WriteInteger(IDName, 'fontcolor', FontColor);
  WriteRect(IniFile, IDName, 'checkimagerect', CheckImageRect);
  WriteRect(IniFile, IDName, 'uncheckimagerect', UnCheckImageRect);
  //
  WriteRect(IniFile, IDName, 'markframerect', MarkFrameRect);
  WriteRect(IniFile, IDName, 'framerect', FrameRect);
  WriteRect(IniFile, IDName, 'frametextrect', FrameTextRect);
  IniFile.WriteInteger(IDName, 'frameleftoffset', FrameLeftOffset);
  IniFile.WriteInteger(IDName, 'framerightoffset', FrameRightOffset);
  //
  WriteRect(IniFile, IDName, 'gripperrect', GripperRect);
  WriteBoolean(IniFile, IDName, 'grippertransparent', GripperTransparent);
  IniFile.WriteInteger(IDName, 'grippertransparentcolor', GripperTransparentColor);
end;

constructor TbsDataSkinCheckRadioControl.Create;
begin
  inherited;
  Morphing := False;
  FontName := '宋体';
  FontCharset := GB2312_CHARSET;
  FontStyle := [];
  FontHeight := 12;
  FontColor := 0;
  ActiveFontColor := 0;
  UnEnabledFontColor := 0;
  FontColor := 0;
  CheckImageArea := NullRect;
  TextArea := NullRect;
  ActiveSkinRect := NullRect;
  CheckImageRect := NullRect;
  UnCheckImageRect := NullRect;
end;

procedure TbsDataSkinCheckRadioControl.LoadFromFile;
begin
  inherited;
  FontName := IniFile.ReadString(IDName, 'fontname', '宋体');
  FontHeight := IniFile.ReadInteger(IDName, 'fontheight', 14);
  FontStyle := ReadFontStyles(IniFile, IDName, 'fontstyle');
  FontColor := IniFile.ReadInteger(IDName, 'fontcolor', 0);
  ActiveFontColor := IniFile.ReadInteger(IDName, 'activefontcolor', 0);
  UnEnabledFontColor := IniFile.ReadInteger(IDName, 'unenabledfontcolor', 0);
  FrameFontColor := IniFile.ReadInteger(IDName, 'framefontcolor', 0);
  ActiveSkinRect := ReadRect(IniFile, IDName, 'activeskinrect');
  CheckImageArea := ReadRect(IniFile, IDName, 'checkimagearea');
  TextArea := ReadRect(IniFile, IDName, 'textarea');
  CheckImageRect := ReadRect(IniFile, IDName, 'checkimagerect');
  UnCheckImageRect := ReadRect(IniFile, IDName, 'uncheckimagerect');
  ActiveCheckImageRect := ReadRect(IniFile, IDName, 'activecheckimagerect');
  ActiveUnCheckImageRect := ReadRect(IniFile, IDName, 'activeuncheckimagerect');
  UnEnabledCheckImageRect := ReadRect(IniFile, IDName, 'unenabledcheckimagerect');
  UnEnabledUnCheckImageRect := ReadRect(IniFile, IDName, 'unenableduncheckimagerect');
  Morphing := ReadBoolean(IniFile, IDName, 'morphing');
  MorphKind := ReadMorphKind(IniFile, IDName, 'morphkind');
end;

procedure TbsDataSkinCheckRadioControl.SaveToFile;
begin
  inherited;
  IniFile.WriteString(IDName, 'fontname', FontName);
  IniFile.WriteInteger(IDName, 'fontheight', FontHeight);
  WriteFontStyles(IniFile, IDName, 'fontstyle', FontStyle);
  IniFile.WriteInteger(IDName, 'fontcolor', FontColor);
  IniFile.WriteInteger(IDName, 'framefontcolor', FrameFontColor);
  IniFile.WriteInteger(IDName, 'activefontcolor', ActiveFontColor);
  IniFile.WriteInteger(IDName, 'unenabledfontcolor', UnEnabledFontColor);
  WriteRect(IniFile, IDName, 'activeskinrect', ActiveSkinRect);
  WriteRect(IniFile, IDName, 'checkimagearea', CheckImageArea);
  WriteRect(IniFile, IDName, 'textarea', TextArea);
  WriteRect(IniFile, IDName, 'checkimagerect', CheckImageRect);
  WriteRect(IniFile, IDName, 'uncheckimagerect', UnCheckImageRect);
  WriteRect(IniFile, IDName, 'activecheckimagerect', ActiveCheckImageRect);
  WriteRect(IniFile, IDName, 'activeuncheckimagerect', ActiveUnCheckImageRect);
  WriteRect(IniFile, IDName, 'unenabledcheckimagerect', UnEnabledCheckImageRect);
  WriteRect(IniFile, IDName, 'unenableduncheckimagerect', UnEnabledUnCheckImageRect);
  WriteBoolean(IniFile, IDName, 'morphing', Morphing);
  WriteMorphKind(IniFile, IDName, 'morphkind', MorphKind);
end;

constructor TbsDataSkinMenuButtonControl.Create;
begin
  inherited;
end;

procedure TbsDataSkinMenuButtonControl.LoadFromFile;
begin
  inherited;
  TrackButtonRect := ReadRect(IniFile, IDName, 'trackbuttonrect');
end;

procedure TbsDataSkinMenuButtonControl.SaveToFile;
begin
  inherited;
  WriteRect(IniFile, IDName, 'trackbuttonrect', TrackButtonRect);
end;

constructor TbsDataSkinButtonControl.Create;
begin
  inherited;
  Morphing := False;
  FontName := '宋体';
  FontCharset := GB2312_CHARSET;
  FontStyle := [];
  FontHeight := 12;
  FontColor := 0;
  ActiveFontColor := 0;
  DownFontColor := 0;
  FontColor := 0;
  ActiveSkinRect := NullRect;
  DownSkinRect := NullRect;
  DisabledSkinRect := NullRect;
  ShowFocus := False;
end;

procedure TbsDataSkinButtonControl.LoadFromFile;
begin
  inherited;
  FontName := IniFile.ReadString(IDName, 'fontname', '宋体');
  FontHeight := IniFile.ReadInteger(IDName, 'fontheight', 14);
  FontStyle := ReadFontStyles(IniFile, IDName, 'fontstyle');
  FontColor := IniFile.ReadInteger(IDName, 'fontcolor', 0);
  ActiveFontColor := IniFile.ReadInteger(IDName, 'activefontcolor', 0);
  DownFontColor := IniFile.ReadInteger(IDName, 'downfontcolor', 0);
  DisabledFontColor := IniFile.ReadInteger(IDName, 'disabledfontcolor', 0);
  ActiveSkinRect := ReadRect(IniFile, IDName, 'activeskinrect');
  DownSkinRect := ReadRect(IniFile, IDName, 'downskinrect');
  DisabledSkinRect := ReadRect(IniFile, IDName, 'disabledskinrect');
  Morphing := ReadBoolean(IniFile, IDName, 'morphing');
  MorphKind := ReadMorphKind(IniFile, IDName, 'morphkind');
  AnimateSkinRect := ReadRect(IniFile, IDName, 'animateskinrect');
  FrameCount := IniFile.ReadInteger(IDName, 'framecount', 0);
  AnimateInterval := IniFile.ReadInteger(IDName, 'animateinterval', 25);
  ShowFocus := ReadBoolean(IniFile, IDName, 'showfocus');
  //
  MenuMarkerFlatRect := ReadRect(IniFile, IDName, 'menumarkerflatrect');
  MenuMarkerRect := ReadRect(IniFile, IDName, 'menumarkerrect');
  MenuMarkerActiveRect := ReadRect(IniFile, IDName, 'menumarkeractiverect');
  MenuMarkerDownRect := ReadRect(IniFile, IDName, 'menumarkerdownrect');
  MenuMarkerTransparentColor := IniFile.ReadInteger(IDName, 'menumarkertransparentcolor', 0);
  //
end;

procedure TbsDataSkinButtonControl.SaveToFile;
begin
  inherited;
  IniFile.WriteString(IDName, 'fontname', FontName);
  IniFile.WriteInteger(IDName, 'fontheight', FontHeight);
  WriteFontStyles(IniFile, IDName, 'fontstyle', FontStyle);
  IniFile.WriteInteger(IDName, 'fontcolor', FontColor);
  IniFile.WriteInteger(IDName, 'activefontcolor', ActiveFontColor);
  IniFile.WriteInteger(IDName, 'downfontcolor', DownFontColor);
  IniFile.WriteInteger(IDName, 'disabledfontcolor',   DisabledFontColor);
  WriteRect(IniFile, IDName, 'activeskinrect', ActiveSkinRect);
  WriteRect(IniFile, IDName, 'downskinrect', DownSkinRect);
  WriteRect(IniFile, IDName, 'disabledskinrect', DisabledSkinRect);
  WriteBoolean(IniFile, IDName, 'morphing', Morphing);
  WriteMorphKind(IniFile, IDName, 'morphkind', MorphKind);
  WriteRect(IniFile, IDName, 'animateskinrect', AnimateSkinRect);
  IniFile.WriteInteger(IDName, 'framecount',   FrameCount);
  IniFile.WriteInteger(IDName, 'animateinterval',   AnimateInterval);
  WriteBoolean(IniFile, IDName, 'showfocus', ShowFocus);
  //
  WriteRect(IniFile, IDName, 'menumarkerflatrect', MenuMarkerFlatRect);
  WriteRect(IniFile, IDName, 'menumarkerrect', MenuMarkerRect);
  WriteRect(IniFile, IDName, 'menumarkeractiverect', MenuMarkerActiveRect);
  WriteRect(IniFile, IDName, 'menumarkerdownrect', MenuMarkerDownRect);
  IniFile.WriteInteger(IDName, 'menumarkertransparentcolor',   MenuMarkerTransparentColor);
  //
end;

constructor TbsDataSkinObject.Create;
begin
  IDName := AIDName;
  ActivePictureIndex := -1;
  SkinRect := NullRect;
  ActiveSkinRect := SkinRect;
  InActiveSkinRect := SkinRect;
  Morphing := False;
  Hint := '';
end;

procedure TbsDataSkinObject.LoadFromFile;
begin
  Hint := IniFile.ReadString(IDName, 'hint', '');
  ActivePictureIndex := IniFile.ReadInteger(IDName, 'activepictureindex', -1);
  SkinRectInAPicture := ReadBoolean(IniFile, IDName, 'skinrectinapicture');
  SkinRect := ReadRect(IniFile, IDName, 'skinrect');
  ActiveSkinRect := ReadRect(IniFile, IDName, 'activeskinrect');
  InActiveSkinRect := ReadRect(IniFile, IDName, 'inactiveskinrect');
  Morphing := ReadBoolean(IniFile, IDName, 'morphing');
  MorphKind := ReadMorphKind(IniFile, IDName, 'morphkind');
end;

procedure TbsDataSkinObject.SaveToFile;
begin
  IniFile.EraseSection(IDName);
  IniFile.WriteString(IDName, 'hint', Hint);
  IniFile.WriteInteger(IDName, 'activepictureindex', ActivePictureIndex);
  WriteBoolean(IniFile, IDName, 'skinrectinapicture', SkinRectInAPicture);
  WriteRect(IniFile, IDName, 'skinrect', SkinRect);
  WriteRect(IniFile, IDName, 'activeskinrect', ActiveSkinRect);
  WriteRect(IniFile, IDName, 'inactiveskinrect', InActiveSkinRect);
  WriteBoolean(IniFile, IDName, 'morphing', Morphing);
  WriteMorphKind(IniFile, IDName, 'morphkind', MorphKind);
end;

procedure TbsDataUserObject.LoadFromFile;
begin
  SkinRect := ReadRect(IniFile, IDName, 'skinrect');
end;

procedure TbsDataUserObject.SaveToFile;
begin
  IniFile.EraseSection(IDName);
  WriteRect(IniFile, IDName, 'skinrect', SkinRect);
end;

constructor TbsSkinColors.Create;
begin
  inherited;
  FcBtnFace := 0;
  FcBtnText := 0;
  FcWindow := 0;
  FcWindowText := 0;
  FcHighLight := 0;
  FcHighLightText := 0;
  FcBtnHighLight := 0;
  FcBtnShadow := 0;
end;

procedure TbsSkinColors.SetColorsToDefault;
begin
  FcBtnFace := clBtnFace;
  FcBtnText := clBtnText;
  FcWindow := clWindow;
  FcWindowText := clWindowText;
  FcHighLight := clHighLight;
  FcHighLightText := clHighLightText;
  FcBtnHighLight := clBtnHighLight;
  FcBtnShadow := clBtnShadow;
end;

procedure TbsSkinColors.LoadFromFile;
begin
  FcBtnFace := IniFile.ReadInteger('SKINCOLORS', 'cbtnface', clBtnFace);
  FcBtnText := IniFile.ReadInteger('SKINCOLORS', 'cbtntext', clBtnText);
  FcWindow := IniFile.ReadInteger('SKINCOLORS', 'cwindow', clWindow);
  FcWindowText := IniFile.ReadInteger('SKINCOLORS', 'cwindowtext', clWindowText);
  FcHighLight := IniFile.ReadInteger('SKINCOLORS', 'chighlight', clHighLight);
  FcHighLightText := IniFile.ReadInteger('SKINCOLORS', 'chighlighttext', clHighLightText);
  FcBtnHighLight := IniFile.ReadInteger('SKINCOLORS', 'cbtnhighlight', clBtnHighLight);
  FcBtnShadow := IniFile.ReadInteger('SKINCOLORS', 'cbtnshadow', clBtnShadow);
end;

procedure TbsSkinColors.SaveToFile;
begin
  IniFile.WriteInteger('SKINCOLORS', 'cbtnface', FcBtnFace);
  IniFile.WriteInteger('SKINCOLORS', 'cbtntext', FcBtnText);
  IniFile.WriteInteger('SKINCOLORS', 'cwindow', FcWindow);
  IniFile.WriteInteger('SKINCOLORS', 'cwindowtext', FcWindowText);
  IniFile.WriteInteger('SKINCOLORS', 'chighlight', FcHighLight);
  IniFile.WriteInteger('SKINCOLORS', 'chighlighttext', FcHighLightText);
  IniFile.WriteInteger('SKINCOLORS', 'cbtnhighlight', FcBtnHighLight);
  IniFile.WriteInteger('SKINCOLORS', 'cbtnshadow', FcBtnShadow);
end;

constructor TbsDataSkinPopupWindow.Create;
begin
  inherited;
  WindowPictureIndex := -1;
  MaskPictureIndex := -1;
  LTPoint := Point(0, 0);
  LBPoint := Point(0, 0);
  RTPoint := Point(0, 0);
  RBPoint := Point(0, 0);
  ScrollMarkerColor := 0;
  ScrollMarkerActiveColor := 0;
  TopStretch := False;
  LeftStretch := False;
  RightStretch := False;
  BottomStretch := False;
end;

procedure TbsDataSkinPopupWindow.LoadFromFile;
begin
  WindowPictureIndex := IniFile.ReadInteger(
    'POPUPWINDOW', 'windowpictureindex', -1);
  MaskPictureIndex := IniFile.ReadInteger(
    'POPUPWINDOW', 'maskpictureindex', -1);
  LTPoint := ReadPoint(IniFile, 'POPUPWINDOW', 'lefttoppoint');
  RTPoint := Readpoint(IniFile, 'POPUPWINDOW', 'righttoppoint');
  LBPoint := ReadPoint(IniFile, 'POPUPWINDOW', 'leftbottompoint');
  RBPoint := ReadPoint(IniFile, 'POPUPWINDOW', 'rightbottompoint');
  ItemsRect := ReadRect(IniFile, 'POPUPWINDOW', 'itemsrect');
  ScrollMarkerColor := IniFile.ReadInteger('POPUPWINDOW', 'scrollmarkercolor', 0);
  ScrollMarkerActiveColor := IniFile.ReadInteger('POPUPWINDOW', 'scrollmarkeractivecolor', 0);
  LeftStretch := ReadBoolean(IniFile, 'POPUPWINDOW', 'leftstretch');
  RightStretch := ReadBoolean(IniFile, 'POPUPWINDOW', 'rightstretch');
  TopStretch := ReadBoolean(IniFile, 'POPUPWINDOW', 'topstretch');
  BottomStretch := ReadBoolean(IniFile, 'POPUPWINDOW', 'bottomstretch');
end;

procedure TbsDataSkinPopupWindow.SaveToFile;
begin
  IniFile.EraseSection('POPUPWINDOW');
  IniFile.WriteInteger('POPUPWINDOW', 'windowpictureindex',
    WindowPictureIndex);
  IniFile.WriteInteger( 'POPUPWINDOW', 'maskpictureindex',
    MaskPictureIndex);
  WritePoint(IniFile, 'POPUPWINDOW', 'lefttoppoint', LTPoint);
  WritePoint(IniFile, 'POPUPWINDOW', 'righttoppoint', RTPoint);
  WritePoint(IniFile, 'POPUPWINDOW', 'leftbottompoint', LBPoint);
  WritePoint(IniFile, 'POPUPWINDOW', 'rightbottompoint', RBPoint);
  WriteRect(IniFile, 'POPUPWINDOW', 'itemsrect', ItemsRect);
  IniFile.WriteInteger('POPUPWINDOW', 'scrollmarkercolor', ScrollMarkerColor);
  IniFile.WriteInteger('POPUPWINDOW', 'scrollmarkeractivecolor', ScrollMarkerActiveColor);
  WriteBoolean(IniFile, 'POPUPWINDOW', 'leftstretch', LeftStretch);
  WriteBoolean(IniFile, 'POPUPWINDOW', 'rightstretch', RightStretch);
  WriteBoolean(IniFile, 'POPUPWINDOW', 'topstretch', TopStretch);
  WriteBoolean(IniFile, 'POPUPWINDOW', 'bottomstretch', BottomStretch);
end;

constructor TbsDataSkinHintWindow.Create;
begin
  inherited;
  WindowPictureIndex := -1;
  MaskPictureIndex := -1;
  LTPoint := Point(0, 0);
  LBPoint := Point(0, 0);
  RTPoint := Point(0, 0);
  RBPoint := Point(0, 0);
  ClRect := NullRect;
  FontName := '宋体';
  FontCharset := GB2312_CHARSET;
  FontStyle := [];
  FontHeight := 12;
  FontColor := 0;
  TopStretch := False;
  LeftStretch := False;
  RightStretch := False;
  BottomStretch := False;
end;

procedure TbsDataSkinHintWindow.LoadFromFile;
begin
  WindowPictureIndex := IniFile.ReadInteger(
    'HINTWINDOW', 'windowpictureindex', -1);
  MaskPictureIndex := IniFile.ReadInteger(
    'HINTWINDOW', 'maskpictureindex', -1);
  LTPoint := ReadPoint(IniFile, 'HINTWINDOW', 'lefttoppoint');
  RTPoint := Readpoint(IniFile, 'HINTWINDOW', 'righttoppoint');
  LBPoint := ReadPoint(IniFile, 'HINTWINDOW', 'leftbottompoint');
  RBPoint := ReadPoint(IniFile, 'HINTWINDOW', 'rightbottompoint');
  ClRect := ReadRect(IniFile, 'HINTWINDOW', 'clientrect');
  FontName := IniFile.ReadString('HINTWINDOW', 'fontname', '宋体');
  FontHeight := IniFile.ReadInteger('HINTWINDOW', 'fontheight', 14);
  FontStyle := ReadFontStyles(IniFile, 'HINTWINDOW', 'fontstyle');
  FontColor := IniFile.ReadInteger('HINTWINDOW', 'fontcolor', 0);
  LeftStretch := ReadBoolean(IniFile, 'HINTWINDOW', 'leftstretch');
  RightStretch := ReadBoolean(IniFile, 'HINTWINDOW', 'rightstretch');
  TopStretch := ReadBoolean(IniFile, 'HINTWINDOW', 'topstretch');
  BottomStretch := ReadBoolean(IniFile, 'HINTWINDOW', 'bottomstretch');
end;

procedure TbsDataSkinHintWindow.SaveToFile;
begin
  IniFile.EraseSection('HINTWINDOW');
  IniFile.WriteInteger('HINTWINDOW', 'windowpictureindex',
    WindowPictureIndex);
  IniFile.WriteInteger( 'HINTWINDOW', 'maskpictureindex',
    MaskPictureIndex);
  WritePoint(IniFile, 'HINTWINDOW', 'lefttoppoint', LTPoint);
  WritePoint(IniFile, 'HINTWINDOW', 'righttoppoint', RTPoint);
  WritePoint(IniFile, 'HINTWINDOW', 'leftbottompoint', LBPoint);
  WritePoint(IniFile, 'HINTWINDOW', 'rightbottompoint', RBPoint);
  WriteRect(IniFile, 'HINTWINDOW', 'clientrect', ClRect);
  IniFile.WriteString('HINTWINDOW', 'fontname', FontName);
  IniFile.WriteInteger('HINTWINDOW', 'fontheight', FontHeight);
  WriteFontStyles(IniFile, 'HINTWINDOW', 'fontstyle', FontStyle);
  IniFile.WriteInteger('HINTWINDOW', 'fontcolor', FontColor);
  WriteBoolean(IniFile, 'HINTWINDOW', 'leftstretch', LeftStretch);
  WriteBoolean(IniFile, 'HINTWINDOW', 'rightstretch', RightStretch);
  WriteBoolean(IniFile, 'HINTWINDOW', 'topstretch', TopStretch);
  WriteBoolean(IniFile, 'HINTWINDOW', 'bottomstretch', BottomStretch);
end;

procedure TbsDataSkinMenuItem.LoadFromFile;
begin
  inherited;
  ItemLO := IniFile.ReadInteger(IDName, 'itemleftoffset', 0);
  ItemRO := IniFile.ReadInteger(IDName, 'itemrightoffset', 0);
  DividerRect := ReadRect(IniFile, IDName, 'dividerrect');
  DividerLO := IniFile.ReadInteger(IDName, 'dividerleftoffset', 0);
  DividerRO := IniFile.ReadInteger(IDName, 'dividerrightoffset', 0);
  TextRct := ReadRect(IniFile, IDName, 'textrect');
  ImageRct := ReadRect(IniFile, IDName, 'imagerect');
  FontName := IniFile.ReadString(IDName, 'fontname', '宋体');
  FontHeight := IniFile.ReadInteger(IDName, 'fontheight', 14);
  FontStyle := ReadFontStyles(IniFile, IDName, 'fontstyle');
  FontColor := IniFile.ReadInteger(IDName, 'fontcolor', 0);
  ActiveFontColor := IniFile.ReadInteger(IDName, 'activefontcolor', 0);
  UnEnabledFontColor := IniFile.ReadInteger(IDName, 'unenabledfontcolor', 0);
  StretchEffect := ReadBoolean(IniFile, IDName, 'stretcheffect');
  InActiveStretchEffect := ReadBoolean(IniFile, IDName, 'inactivestretcheffect');
  DividerStretchEffect := ReadBoolean(IniFile, IDName, 'dividerstretcheffect');
  AnimateSkinRect := ReadRect(IniFile, IDName, 'animateskinrect');
  FrameCount := IniFile.ReadInteger(IDName, 'framecount', 0);
  AnimateInterval := IniFile.ReadInteger(IDName, 'animateinterval', 25);
  InActiveAnimation := ReadBoolean(IniFile, IDName, 'inactiveanimation');
  UseImageColor := ReadBoolean(IniFile, IDName, 'useimagecolor');
  ImageColor := IniFile.ReadInteger(IDName, 'imagecolor', 0);
  ActiveImageColor := IniFile.ReadInteger(IDName, 'activeimagecolor', 0);
end;

procedure TbsDataSkinMenuItem.SaveToFile;
begin
  inherited;
  IniFile.WriteInteger(IDName, 'itemleftoffset', ItemLO);
  IniFile.WriteInteger(IDName, 'itemrightoffset', ItemRO);
  WriteRect(IniFile, IDName, 'dividerrect', DividerRect);
  IniFile.WriteInteger(IDName, 'dividerleftoffset', DividerLO);
  IniFile.WriteInteger(IDName, 'dividerrightoffset', DividerRO);
  WriteRect(IniFile, IDName, 'textrect', TextRct);
  WriteRect(IniFile, IDName, 'imagerect', ImageRct);
  IniFile.WriteString(IDName, 'fontname', FontName);
  IniFile.WriteInteger(IDName, 'fontheight', FontHeight);
  WriteFontStyles(IniFile, IDName, 'fontstyle', FontStyle);
  IniFile.WriteInteger(IDName, 'fontcolor', FontColor);
  IniFile.WriteInteger(IDName, 'activefontcolor', ActiveFontColor);
  IniFile.WriteInteger(IDName, 'unenabledfontcolor', UnEnabledFontColor);
  WriteBoolean(IniFile, IDName, 'stretcheffect', Stretcheffect);
  WriteBoolean(IniFile, IDName, 'inactivestretcheffect', InActiveStretcheffect);
  WriteBoolean(IniFile, IDName, 'dividerstretcheffect', DividerStretcheffect);
  WriteRect(IniFile, IDName, 'animateskinrect', AnimateSkinRect);
  IniFile.WriteInteger(IDName, 'framecount',   FrameCount);
  IniFile.WriteInteger(IDName, 'animateinterval',   AnimateInterval);
  WriteBoolean(IniFile, IDName, 'inactiveanimation', InActiveAnimation);
  WriteBoolean(IniFile, IDName, 'useimagecolor', UseImageColor);
  IniFile.WriteInteger(IDName, 'imagecolor', ImageColor);
  IniFile.WriteInteger(IDName, 'activeimagecolor', ActiveImageColor);
end;

procedure TbsDataSkinMainMenuItem.LoadFromFile;
begin
  inherited;
  ItemLO := IniFile.ReadInteger(IDName, 'itemleftoffset', 0);
  ItemRO := IniFile.ReadInteger(IDName, 'itemrightoffset', 0);
  DownRect := ReadRect(IniFile, IDName, 'downrect');
  TextRct := ReadRect(IniFile, IDName, 'textrect');
  FontName := IniFile.ReadString(IDName, 'fontname', '宋体');
  FontHeight := IniFile.ReadInteger(IDName, 'fontheight', 14);
  FontStyle := ReadFontStyles(IniFile, IDName, 'fontstyle');
  FontColor := IniFile.ReadInteger(IDName, 'fontcolor', 0);
  ActiveFontColor := IniFile.ReadInteger(IDName, 'activefontcolor', 0);
  DownFontColor := IniFile.ReadInteger(IDName, 'downfontcolor', 0);
  UnEnabledFontColor := IniFile.ReadInteger(IDName, 'unenabledfontColor', 0);
  StretchEffect := ReadBoolean(IniFile, IDName, 'stretcheffect');
  AnimateSkinRect := ReadRect(IniFile, IDName, 'animateskinrect');
  FrameCount := IniFile.ReadInteger(IDName, 'framecount', 0);
  AnimateInterval := IniFile.ReadInteger(IDName, 'animateinterval', 25);
  InActiveAnimation := ReadBoolean(IniFile, IDName, 'inactiveanimation');
end;

procedure TbsDataSkinMainMenuItem.SaveToFile;
begin
  inherited;
  IniFile.WriteInteger(IDName, 'itemleftoffset', ItemLO);
  IniFile.WriteInteger(IDName, 'itemrightoffset', ItemRO);
  WriteRect(IniFile, IDName, 'downrect', DownRect);
  WriteRect(IniFile, IDName, 'textrect', TextRct);
  IniFile.WriteString(IDName, 'fontname', FontName);
  IniFile.WriteInteger(IDName, 'fontheight', FontHeight);
  WriteFontStyles(IniFile, IDName, 'fontstyle', FontStyle);
  IniFile.WriteInteger(IDName, 'fontcolor', FontColor);
  IniFile.WriteInteger(IDName, 'activefontcolor', ActiveFontColor);
  IniFile.WriteInteger(IDName, 'downfontcolor', DownFontColor);
  IniFile.WriteInteger(IDName, 'unenabledfontColor', UnEnabledFontColor);
  WriteBoolean(IniFile, IDName, 'stretcheffect', StretchEffect);
  WriteRect(IniFile, IDName, 'animateskinrect', AnimateSkinRect);
  IniFile.WriteInteger(IDName, 'framecount',   FrameCount);
  IniFile.WriteInteger(IDName, 'animateinterval',   AnimateInterval);
  WriteBoolean(IniFile, IDName, 'inactiveanimation', InActiveAnimation);
end;

constructor TbsDataSkinButton.Create(AIDName: String);
begin
  inherited;
  DownRect := NullRect;
end;

procedure TbsDataSkinButton.SaveToFile;
begin
  inherited;
  WriteRect(IniFile, IDName, 'downrect', DownRect);
  WriteRect(IniFile, IDName, 'disableskinrsect', DisableSkinRect);
end;

procedure TbsDataSkinButton.LoadFromFile;
begin
  inherited;
  DownRect := ReadRect(IniFile, IDName, 'downrect');
  DisableSkinRect := ReadRect(IniFile, IDName, 'disableskinrsect');
end;

procedure TbsDataSkinStdButton.LoadFromFile;
var
  S: String;
begin
  inherited;
  S := IniFile.ReadString(IDName, 'command', 'cmdefault');
  if S = 'cmclose' then Command := cmClose else
  if S = 'cmmaximize' then Command := cmMaximize else
  if S = 'cmminimize' then Command := cmMinimize else
  if S = 'cmsysmenu' then Command := cmSysMenu else
  if S = 'cmdefault' then Command := cmDefault else
  if S = 'cmrollup' then Command := cmRollUp else
  Command := cmMinimizeToTray;
  RestoreRect := ReadRect(IniFile, IDName, 'restorerect');
  RestoreActiveRect := ReadRect(IniFile, IDName, 'restoreactiverect');
  RestoreDownRect := ReadRect(IniFile, IDName, 'restoredownrect');
  RestoreInActiveRect := ReadRect(IniFile, IDName, 'restoreinactiverect');
end;

procedure TbsDataSkinStdButton.SaveToFile;
var
  S: String;
begin
  inherited;
  if Command = cmClose then S := 'cmclose' else
  if Command = cmMaximize then S := 'cmmaximize' else
  if Command = cmMinimize then S := 'cmminimize' else
  if Command = cmSysMenu then S := 'cmsysmenu' else
  if Command = cmDefault then S := 'cmdefault' else
  if Command = cmRollUp then S := 'cmrollup' else
  S := 'cmminimizetotray';
  IniFile.WriteString(IDName, 'command', S);
  WriteRect(IniFile, IDName, 'restorerect', RestoreRect);
  WriteRect(IniFile, IDName, 'restoreactiverect', RestoreActiveRect);
  WriteRect(IniFile, IDName, 'restoredownrect', RestoreDownRect);
  WriteRect(IniFile, IDName, 'restoreinactiverect', RestoreInActiveRect);
end;

procedure TbsDataSkinAnimate.LoadFromFile;
var
  S: String;
begin
  inherited;
  Morphing := False;
  CountFrames := IniFile.ReadInteger(IDName, 'countframes', 1);
  Cycle := ReadBoolean(IniFile, IDName, 'cycle');
  ButtonStyle := ReadBoolean(IniFile, IDName, 'buttonstyle');
  TimerInterval := IniFile.ReadInteger(IDName, 'timerinterval', 50);
  S := IniFile.ReadString(IDName, 'command', 'cmdefault');
  if S = 'cmclose' then Command := cmClose else
  if S = 'cmmaximize' then Command := cmMaximize else
  if S = 'cmminimize' then Command := cmMinimize else
  if S = 'cmsysmenu' then Command := cmSysMenu else
  if S = 'cmdefault' then Command := cmDefault else
  if S = 'cmrollup' then Command := cmRollUp else
  Command := cmMinimizeToTray;
  DownSkinRect := ReadRect(IniFile, IDName, 'downskinrect');
  RestoreRect := ReadRect(IniFile, IDName, 'restorerect');
  RestoreActiveRect := ReadRect(IniFile, IDName, 'restoreactiverect');
  RestoreDownRect := ReadRect(IniFile, IDName, 'restoredownrect');
  RestoreInActiveRect := ReadRect(IniFile, IDName, 'restoreinactiverect');
end;

procedure TbsDataSkinAnimate.SaveToFile;
var
  S: String;
begin
  inherited;
  IniFile.WriteInteger(IDName, 'countframes', CountFrames);
  WriteBoolean(IniFile, IDName, 'cycle', Cycle);
  WriteBoolean(IniFile, IDName, 'buttonstyle', ButtonStyle);
  IniFile.WriteInteger(IDName, 'timerinterval', TimerInterval);
  if Command = cmClose then S := 'cmclose' else
  if Command = cmMaximize then S := 'cmmaximize' else
  if Command = cmMinimize then S := 'cmminimize' else
  if Command = cmSysMenu then S := 'cmsysmenu' else
  if Command = cmDefault then S := 'cmdefault' else
  if Command = cmRollUp then S := 'cmrollup' else
  S := 'cmminimizetotray';
  IniFile.WriteString(IDName, 'command', S);
  WriteRect(IniFile, IDName, 'downskinrect', DownSkinRect);
  WriteRect(IniFile, IDName, 'restorerect', RestoreRect);
  WriteRect(IniFile, IDName, 'restoreactiverect', RestoreActiveRect);
  WriteRect(IniFile, IDName, 'restoredownrect', RestoreDownRect);
  WriteRect(IniFile, IDName, 'restoreinactiverect', RestoreInActiveRect);
end;

procedure TbsDataSkinCaption.SaveToFile;
begin
  inherited;
  WriteRect(IniFile, IDName, 'textrect', TextRct);
  IniFile.WriteString(IDName, 'fontname', FontName);
  IniFile.WriteInteger(IDName, 'fontheight', FontHeight);
  WriteFontStyles(IniFile, IDName, 'fontstyle', FontStyle);
  IniFile.WriteInteger(IDName, 'fontcolor', FontColor);
  IniFile.WriteInteger(IDName, 'activefontcolor', ActiveFontColor);
  WriteAlignment(IniFile, IDName, 'alignment', Alignment);
  WriteBoolean(IniFile, IDName, 'light', Light);
  IniFile.WriteInteger(IDName, 'lightcolor', LightColor);
  IniFile.WriteInteger(IDName, 'activelightcolor', ActiveLightColor);
  WriteBoolean(IniFile, IDName, 'shadow', Shadow);
  IniFile.WriteInteger(IDName, 'shadowcolor', ShadowColor);
  IniFile.WriteInteger(IDName, 'activeshadowcolor', ActiveShadowColor);
  WriteRect(IniFile, IDName, 'framerect', FrameRect);
  WriteRect(IniFile, IDName, 'activeframerect', ActiveFrameRect);
  WriteRect(IniFile, IDName, 'frametextrect', FrameTextRect);
  IniFile.WriteInteger(IDName, 'frameleftoffset', FrameLeftOffset);
  IniFile.WriteInteger(IDName, 'framerightoffset', FrameRightOffset);
  WriteBoolean(IniFile, IDName, 'stretcheffect', StretchEffect);
  WriteRect(IniFile, IDName, 'animateskinrect', AnimateSkinRect);
  IniFile.WriteInteger(IDName, 'framecount',   FrameCount);
  IniFile.WriteInteger(IDName, 'animateinterval',   AnimateInterval);
  WriteBoolean(IniFile, IDName, 'inactiveanimation', InActiveAnimation);
  WriteBoolean(IniFile, IDName, 'fullframe', FullFrame);
end;

procedure TbsDataSkinCaption.LoadFromFile;
begin
  inherited;
  TextRct := ReadRect(IniFile, IDName, 'textrect');
  FontName := IniFile.ReadString(IDName, 'fontname', '宋体');
  FontHeight := IniFile.ReadInteger(IDName, 'fontheight', 14);
  FontStyle := ReadFontStyles(IniFile, IDName, 'fontstyle');
  FontColor := IniFile.ReadInteger(IDName, 'fontcolor', 0);
  ActiveFontColor := IniFile.ReadInteger(IDName, 'activefontcolor', 0);
  Alignment := ReadAlignment(IniFile, IDName, 'alignment');
  Light := ReadBoolean(IniFile, IDName, 'light');
  LightColor := IniFile.ReadInteger(IDName, 'lightcolor', 0);
  ActiveLightColor := IniFile.ReadInteger(IDName, 'activelightcolor', 0);
  Shadow := ReadBoolean(IniFile, IDName, 'shadow');
  ShadowColor := IniFile.ReadInteger(IDName, 'shadowcolor', 0);
  ActiveShadowColor := IniFile.ReadInteger(IDName, 'activeshadowcolor', 0);
  FrameRect := ReadRect(IniFile, IDName, 'framerect');
  ActiveFrameRect := ReadRect(IniFile, IDName, 'activeframerect');
  FrameTextRect := ReadRect(IniFile, IDName, 'frametextrect');
  FrameLeftOffset := IniFile.ReadInteger(IDName, 'frameleftoffset', 0);
  FrameRightOffset := IniFile.ReadInteger(IDName, 'framerightoffset', 0);
  StretchEffect := ReadBoolean(IniFile, IDName, 'stretcheffect');
  AnimateSkinRect := ReadRect(IniFile, IDName, 'animateskinrect');
  FrameCount := IniFile.ReadInteger(IDName, 'framecount', 0);
  AnimateInterval := IniFile.ReadInteger(IDName, 'animateinterval', 25);
  InActiveAnimation := ReadBoolean(IniFile, IDName, 'inactiveanimation');
  FullFrame := ReadBoolean(IniFile, IDName, 'fullframe');
end;

constructor TbsSkinData.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ChangeSkinDataProcess := False;
  FEnableSkinEffects := True;
  ObjectList := TList.Create;
  CtrlList := TList.Create;
  FActivePictures := TList.Create;
  FPicture := TBitMap.Create;
  FInActivePicture := TBitMap.Create;
  FMask := TBitMap.Create;
  FPictureName := '';
  FInActivePictureName := '';
  FMaskName := '';
  FActivePicturesNames := TStringList.Create;
  SkinName := '';
  Empty := True;
  PopupWindow := TbsDataSkinPopupWindow.Create;
  FSkinColors := TbsSkinColors.Create;
  HintWindow := TbsDataSkinHintWindow.Create;
  MainMenuPopupUp := False;
  BGPictureIndex := -1;
  MDIBGPictureIndex := -1;
  FormMinWidth := 0;
end;

destructor TbsSkinData.Destroy;
begin
  Empty := True;
  ClearObjects;
  ObjectList.Free;
  CtrlList.Free;
  FActivePictures.Free;
  FPicture.Free;
  FMask.Free;
  FInActivePicture.Free;
  FActivePicturesNames.Free;
  PopupWindow.Free;
  FSkinColors.Free;
  HintWindow.Free;
  inherited Destroy;
end;


procedure TbsSkinData.StoreToDisk;
var
  I: Integer;
  Path: String;
begin
  Path := ExtractFilePath(AFileName);
  SaveToFile(AFileName);
  if not FPicture.Empty
  then
    FPicture.SaveToFile(Path + Self.FPictureName);
  if not FInActivePicture.Empty
  then
    FInActivePicture.SaveToFile(Path + Self.FInActivePictureName);
  if not FMask.Empty
  then
    FMask.SaveToFile(Path + Self.FMaskName);
  if FActivePicturesNames.Count > 0
  then
    for I := 0 to FActivePictures.Count - 1 do
    begin
      TBitMap(FActivePictures.Items[I]).SaveToFile(Path + FActivePicturesNames[I]);
    end;
end;

procedure TbsSkinData.SaveToCompressedFile(FileName: String);
var
  CSS: TbsCompressedStoredSkin;
begin
  CSS := TbsCompressedStoredSkin.Create(Self);
  CSS.LoadFromSkinData(Self);
  CSS.SaveToCompressFile(FileName);
  CSS.Free;
end;

procedure TbsSkinData.LoadFromCompressedFile(FileName: String);
var
  CSS: TbsCompressedStoredSkin;
begin
  CSS := TbsCompressedStoredSkin.Create(Self);
  CSS.LoadFromCompressFile(FileName);
  if not CSS.Empty
  then
    Self.LoadCompressedStoredSkin(CSS);
  CSS.Free;
end;

procedure TbsSkinData.Notification;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FCompressedStoredSkin)
  then FCompressedStoredSkin := nil;
  if (Operation = opRemove) and (AComponent = FResourceStrData)
  then FResourceStrData := nil;
end;

procedure TbsSkinData.SetCompressedStoredSkin;
begin
  FCompressedStoredSkin := Value;
  if not (csDesigning in ComponentState) and (FCompressedStoredSkin <> nil)
  then
    LoadCompressedStoredSkin(FCompressedStoredSkin);
end;

procedure TbsSkinData.SetResourceStrData;
begin
  FResourceStrData := Value;
  if not (csDesigning in ComponentState)
  then
    begin
      SendSkinDataMessage(WM_CHANGERESSTRDATA);
    end;
end;

procedure TbsSkinData.SendSkinDataMessage;
var
  i: Integer;
  F: TForm;
begin
  if (Owner is TForm)
  then
    begin
      F := TForm(Owner);
      SendMessage(F.Handle, M, Integer(Self), 1000);
    end
  else
    F := nil;  

  with Screen do
   for i := 0 to FormCount - 1 do
     if (Forms[i] <> F) or (F = nil)
     then
       SendMessage(Forms[i].Handle, M, Integer(Self), 1000);
end;

function TbsSkinData.GetIndex;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to ObjectList.Count - 1 do
  begin
    if AIDName = TbsDataSkinObject(ObjectList.Items[i]).IDName
    then
      begin
        Result := i;
        Break;
      end;
  end;
end;

function TbsSkinData.GetControlIndex;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to CtrlList.Count - 1 do
  begin
    if AIDName = TbsDataSkinControl(CtrlList.Items[i]).IDName
    then
      begin
        Result := i;
        Break;
      end;
  end;
end;

procedure TbsSkinData.ClearObjects;
var
  i: Integer;
begin
  for i := 0 to ObjectList.Count - 1 do
    TbsDataSkinObject(ObjectList.Items[i]).Free;
  ObjectList.Clear;
  for i := 0 to CtrlList.Count - 1 do
    TbsDataSkinControl(CtrlList.Items[i]).Free;
  CtrlList.Clear;
  for i := 0 to FActivePictures.Count - 1 do
    TBitMap(FActivePictures.Items[i]).Free;
  PopupWindow.WindowPictureIndex := -1;
  HintWindow.WindowPictureIndex := -1;
  FActivePictures.Clear;
  FActivePicturesNames.Clear;
  FSkinColors.SetColorsToDefault;
end;

procedure TbsSkinData.ClearAll;
begin
  ClearObjects;
  FPicture.Assign(nil);
  FMask.Assign(nil);
  FInActivePicture.Assign(nil);
  FPictureName := '';
  FMaskName := '';
  Empty := True;
end;

const
  symbols = ',: ';

procedure TbsSkinData.GetObjectTypeName(S: String; var AName, AType: String);
var
  i, j: Integer;
begin
  AName := '';
  AType := '';
  j := 0;
  for i := 1 to Length(S) do
    if S[i] = ':'
    then
      begin
        j := i;
        Break;
      end;
  if j <> 0
  then
    begin
      AName := Copy(S, 1, j - 1);
      AType := Copy(S, j + 1, Length(S) - j);
    end;
end;

procedure TbsSkinData.WriteObjects;
var
  i: Integer;
  S: String;
begin
  F.EraseSection('SKINOBJECTS');
  F.WriteInteger('SKINOBJECTS', 'count', ObjectList.Count);
  for i := 0 to ObjectList.Count - 1 do
  begin
    S := TbsDataSkinObject(ObjectList.Items[i]).IDName + ':';
    if TbsDataSkinObject(ObjectList.Items[i]) is TbsDataSkinMenuItem
    then S := S + 'menuitem' else
    if TbsDataSkinObject(ObjectList.Items[i]) is TbsDataSkinMainMenuBarItem
    then S := S + 'mainmenubaritem' else
    if TbsDataSkinObject(ObjectList.Items[i]) is TbsDataSkinMainMenuBarButton
    then S := S + 'mainmenubarbutton' else
    if TbsDataSkinObject(ObjectList.Items[i]) is TbsDataSkinStdButton
    then S := S + 'stdbutton' else
    if TbsDataSkinObject(ObjectList.Items[i]) is TbsDataSkinButton
    then S := S + 'button' else
    if TbsDataSkinObject(ObjectList.Items[i]) is TbsDataSkinCaption
    then S := S + 'caption' else
    if TbsDataSkinObject(ObjectList.Items[i]) is TbsDataUserObject
    then S := S + 'userobject' else
    if TbsDataSkinObject(ObjectList.Items[i]) is TbsDataSkinAnimate
    then S := S + 'animate';
    F.WriteString('SKINOBJECTS', IntToStr(i), S);
    TbsDataSkinObject(ObjectList.Items[i]).SaveToFile(F);
  end;
end;

procedure TbsSkinData.WriteCtrls(F: TCustomIniFile);
var
  i: Integer;
  S: String;
begin
  F.EraseSection('SKINCONTROLS');
  F.WriteInteger('SKINCONTROLS', 'count', CtrlList.Count);
  for i := 0 to CtrlList.Count - 1 do
  begin
    S := TbsDataSkinControl(CtrlList.Items[i]).IDName + ':';
    if TbsDataSkinControl(CtrlList.Items[i]) is TbsDataSkinPanelControl
    then S := S + 'panel'
    else
    if TbsDataSkinControl(CtrlList.Items[i]) is TbsDataSkinExPanelControl
    then S := S + 'expanel'
    else
    if TbsDataSkinControl(CtrlList.Items[i]) is TbsDataSkinMenuButtonControl
    then S := S + 'menubutton'
    else
    if TbsDataSkinControl(CtrlList.Items[i]) is TbsDataSkinButtonControl
    then S := S + 'button'
    else
    if TbsDataSkinControl(CtrlList.Items[i]) is TbsDataSkinCheckRadioControl
    then S := S + 'checkradio'
    else
    if TbsDataSkinControl(CtrlList.Items[i]) is TbsDataSkinGaugeControl
    then S := S + 'gauge'
    else
    if TbsDataSkinControl(CtrlList.Items[i]) is TbsDataSkinSplitterControl
    then S := S + 'splitter'
    else
    if TbsDataSkinControl(CtrlList.Items[i]) is TbsDataSkinTrackBarControl
    then S := S + 'trackbar'
    else
    if TbsDataSkinControl(CtrlList.Items[i]) is TbsDataSkinLabelControl
    then S := S + 'label'
    else
    if TbsDataSkinControl(CtrlList.Items[i]) is TbsDataSkinStdLabelControl
    then S := S + 'stdlabel'
    else
    if TbsDataSkinControl(CtrlList.Items[i]) is TbsDataSkinUpDownControl
    then S := S + 'updown'
    else
    if TbsDataSkinControl(CtrlList.Items[i]) is TbsDataSkinGridControl
    then S := S + 'grid'
    else
    if TbsDataSkinControl(CtrlList.Items[i]) is TbsDataSkinTabControl
    then S := S + 'tab'
    else
    if TbsDataSkinControl(CtrlList.Items[i]) is TbsDataSkinMainMenuBar
    then S := S + 'mainmenubar'
    else
    if TbsDataSkinControl(CtrlList.Items[i]) is TbsDataSkinControlBar
    then S := S + 'controlbar'
    else
    if TbsDataSkinControl(CtrlList.Items[i]) is TbsDataSkinMemoControl
    then S := S + 'memo'
    else
    if TbsDataSkinControl(CtrlList.Items[i]) is TbsDataSkinEditControl
    then S := S + 'edit'
    else
    if TbsDataSkinControl(CtrlList.Items[i]) is TbsDataSkinCheckListBox
    then S := S + 'checklistbox'
    else
    if TbsDataSkinControl(CtrlList.Items[i]) is TbsDataSkinListBox
    then S := S + 'listbox'
    else
    if TbsDataSkinControl(CtrlList.Items[i]) is TbsDataSkinComboBox
    then S := S + 'combobox'
    else
    if TbsDataSkinControl(CtrlList.Items[i]) is TbsDataSkinScrollBarControl
    then S := S + 'scrollbar'
    else
    if TbsDataSkinControl(CtrlList.Items[i]) is TbsDataSkinSpinEditControl
    then S := S + 'spinedit'
    else
    if TbsDataSkinControl(CtrlList.Items[i]) is TbsDataSkinScrollBoxControl
    then S := S + 'scrollbox'
    else
    if TbsDataSkinControl(CtrlList.Items[i]) is TbsDataSkinTreeView
    then S := S + 'treeview'
    else
    if TbsDataSkinControl(CtrlList.Items[i]) is TbsDataSkinBevel
    then S := S + 'bevel'
    else
    if TbsDataSkinControl(CtrlList.Items[i]) is TbsDataSkinSlider
    then S := S + 'slider'
    else
    if TbsDataSkinControl(CtrlList.Items[i]) is TbsDataSkinListView
    then S := S + 'listview'
    else
    if TbsDataSkinControl(CtrlList.Items[i]) is TbsDataSkinRichEdit
    then S := S + 'richedit';
    F.WriteString('SKINCONTROLS', IntToStr(i), S);
    TbsDataSkinControl(CtrlList.Items[i]).SaveToFile(F);
  end;
end;

procedure TbsSkinData.ReadCtrls(F: TCustomIniFile);
var
  i, Count: Integer;
  S, FName, FType: String;
begin
  Count := F.ReadInteger('SKINCONTROLS', 'count', 0);
  for i := 0 to Count - 1 do
  begin
    S := F.ReadString('SKINCONTROLS', IntToStr(i), '');
    GetObjectTypeName(S, FName, FType);
    if FType = 'panel'
    then CtrlList.Add(TbsDataSkinPanelControl.Create(FName))
    else
    if FType = 'expanel'
    then CtrlList.Add(TbsDataSkinExPanelControl.Create(FName))
    else
    if FType = 'menubutton'
    then CtrlList.Add(TbsDataSkinMenuButtonControl.Create(FName))
    else
    if FType = 'button'
    then CtrlList.Add(TbsDataSkinButtonControl.Create(FName))
    else
    if FType = 'checkradio'
    then CtrlList.Add(TbsDataSkinCheckRadioControl.Create(FName))
    else
    if FType = 'gauge'
    then CtrlList.Add(TbsDataSkinGaugeControl.Create(FName))
    else
    if FType = 'splitter'
    then CtrlList.Add(TbsDataSkinSplitterControl.Create(FName))
    else
    if FType = 'trackbar'
    then CtrlList.Add(TbsDataSkinTrackBarControl.Create(FName))
    else
    if FType = 'label'
    then CtrlList.Add(TbsDataSkinLabelControl.Create(FName))
    else
    if FType = 'stdlabel'
    then CtrlList.Add(TbsDataSkinStdLabelControl.Create(FName))
    else
    if FType = 'updown'
    then CtrlList.Add(TbsDataSkinUpDownControl.Create(FName))
    else
    if FType = 'grid'
    then CtrlList.Add(TbsDataSkinGridControl.Create(FName))
    else
    if FType = 'tab'
    then CtrlList.Add(TbsDataSkinTabControl.Create(FName))
    else
    if FType = 'mainmenubar'
    then CtrlList.Add(TbsDataSkinMainMenuBar.Create(FName))
    else
    if FType = 'controlbar'
    then CtrlList.Add(TbsDataSkinControlBar.Create(FName))
    else
    if FType = 'memo'
    then CtrlList.Add(TbsDataSkinMemoControl.Create(FName))
    else
    if FType = 'edit'
    then CtrlList.Add(TbsDataSkinEditControl.Create(FName))
    else
    if FType = 'checklistbox'
    then CtrlList.Add(TbsDataSkinCheckListBox.Create(FName))
    else
    if FType = 'listbox'
    then CtrlList.Add(TbsDataSkinListBox.Create(FName))
    else
    if FType = 'combobox'
    then CtrlList.Add(TbsDataSkinComboBox.Create(FName))
    else
    if FType = 'scrollbar'
    then CtrlList.Add(TbsDataSkinScrollBarControl.Create(FName))
    else
    if FType = 'spinedit'
    then CtrlList.Add(TbsDataSkinSpinEditControl.Create(FName))
    else
    if FType = 'scrollbox'
    then CtrlList.Add(TbsDataSkinScrollBoxControl.Create(FName))
    else
    if FType = 'treeview'
    then CtrlList.Add(TbsDataSkinTreeView.Create(FName))
    else
    if FType = 'bevel'
    then CtrlList.Add(TbsDataSkinBevel.Create(FName))
    else
    if FType = 'slider'
    then CtrlList.Add(TbsDataSkinSlider.Create(FName))
    else
    if FType = 'listview'
    then CtrlList.Add(TbsDataSkinListView.Create(FName))
    else
    if FType = 'richedit'
    then CtrlList.Add(TbsDataSkinRichEdit.Create(FName));
    TbsDataSkinControl(CtrlList[CtrlList.Count - 1]).LoadFromFile(F);
  end;
end;

procedure TbsSkinData.WriteActivePictures;
begin
  WriteStrings1(F, 'PICTURES', 'activepictures', FActivePicturesNames);
end;

procedure TbsSkinData.ReadActivePictures;
var
  i: Integer;
begin
  ReadStrings1(F, 'PICTURES', 'activepictures', FActivePicturesNames);
  for i := 0 to FActivePicturesNames.Count - 1 do
  begin
    FActivePictures.Add(TBitMap.Create);
    TBitMap(FActivePictures.Items[i]).LoadFromFile(Path + FActivePicturesNames[i]);
  end;
end;
procedure TbsSkinData.ReadObjects;
var
  i, Count: Integer;
  S, FName, FType: String;
begin
  Count := F.ReadInteger('SKINOBJECTS', 'count', 0);
  for i := 0 to Count - 1 do
  begin
    S := F.ReadString('SKINOBJECTS', IntToStr(i), '');
    GetObjectTypeName(S, FName, FType);
    if FType = 'menuitem'
    then ObjectList.Add(TbsDataSkinMenuItem.Create(FName)) else
    if FType = 'mainmenubaritem'
    then ObjectList.Add(TbsDataSkinMainMenuBarItem.Create(FName)) else
    if FType = 'stdbutton'
    then ObjectList.Add(TbsDataSkinStdButton.Create(FName)) else
    if FType = 'mainmenubarbutton'
    then ObjectList.Add(TbsDataSkinMainMenuBarButton.Create(FName)) else
    if FType = 'button'
    then ObjectList.Add(TbsDataSkinButton.Create(FName)) else
    if FType = 'caption'
    then ObjectList.Add(TbsDataSkinCaption.Create(FName)) else
    if FType = 'animate'
    then ObjectList.Add(TbsDataSkinAnimate.Create(FName)) else
    if FType = 'userobject'
    then ObjectList.Add(TbsDataUserObject.Create(FName));
    TbsDataSkinObject(ObjectList[ObjectList.Count - 1]).LoadFromFile(F);
  end;
end;

procedure TbsSkinData.AddBitMap(FileName: String);
begin
  FActivePicturesNames.Add(ExtractFileName(FileName));
  FActivePictures.Add(TBitMap.Create);
  TBitMap(FActivePictures.Items[FActivePictures.Count - 1]).LoadFromFile(FileName);
end;

procedure TbsSkinData.DeleteBitMap(Index: Integer);
begin
  FActivePicturesNames.Delete(Index);
  TBitMap(FActivePictures.Items[Index]).Free;
  FActivePictures.Delete(Index);
end;

procedure TbsSkinData.WriteFormInfo;
begin
  WritePoint(F, 'FORMINFO', 'lefttoppoint', LTPoint);
  Writepoint(F, 'FORMINFO', 'righttoppoint', RTPoint);
  WritePoint(F, 'FORMINFO', 'leftbottompoint', LBPoint);
  WritePoint(F, 'FORMINFO', 'rightbottompoint', RBPoint);
  WriteRect(F, 'FORMINFO', 'clientrect', ClRect);
  F.WriteInteger('FORMINFO', 'bgpictureindex', BGPictureIndex);
  F.WriteInteger('FORMINFO', 'mdibgpictureindex', MDIBGPictureIndex);
  //
  WriteBoolean(F, 'FORMINFO', 'leftstretch', LeftStretch);
  WriteBoolean(F, 'FORMINFO', 'rightstretch', RightStretch);
  WriteBoolean(F, 'FORMINFO', 'topstretch', TopStretch);
  WriteBoolean(F, 'FORMINFO', 'bottomstretch', BottomStretch);
  //
  WriteRect(F, 'FORMINFO', 'maskrectarea', MaskRectArea);
  //
  WritePoint(F, 'FORMINFO', 'hittestlefttoppoint', HitTestLTPoint);
  WritePoint(F, 'FORMINFO', 'hittestrighttoppoint', HitTestRTPoint);
  WritePoint(F, 'FORMINFO', 'hittestleftbottompoint', HitTestLBPoint);
  WritePoint(F, 'FORMINFO', 'hittestrightbottompoint', HitTestRBPoint);
  //
  WriteRect(F, 'FORMINFO', 'buttonsrect', ButtonsRect);
  WriteRect(F, 'FORMINFO', 'captionrect', CaptionRect);
  F.WriteInteger('FORMINFO', 'buttonsoffset', ButtonsOffset);
  WriteBoolean(F, 'FORMINFO', 'buttonsinleft', CapButtonsInLeft);
  WriteBoolean(F, 'FORMINFO', 'mainmenupopupup', MainMenuPopupUp);
  F.WriteInteger('FORMINFO', 'borderwidth', BorderW);
  WriteBoolean(F, 'FORMINFO', 'autorenderinginactiveimage', AutoRenderingInActiveImage);
  WriteInActiveEffect(F, 'FORMINFO', 'inactiveeffect', InActiveEffect);
  F.WriteInteger('FORMINFO', 'formminwidth', FormMinWidth);
end;

procedure TbsSkinData.ReadFormInfo;
begin
  LTPoint := ReadPoint(F, 'FORMINFO', 'lefttoppoint');
  RTPoint := Readpoint(F, 'FORMINFO', 'righttoppoint');
  LBPoint := ReadPoint(F, 'FORMINFO', 'leftbottompoint');
  RBPoint := ReadPoint(F, 'FORMINFO', 'rightbottompoint');
  ClRect := ReadRect(F, 'FORMINFO', 'clientrect');
  BGPictureIndex := F.ReadInteger('FORMINFO', 'bgpictureindex', -1);
  MDIBGPictureIndex := F.ReadInteger('FORMINFO', 'mdibgpictureindex', -1);
  //
  LeftStretch := ReadBoolean(F, 'FORMINFO', 'leftstretch');
  RightStretch := ReadBoolean(F, 'FORMINFO', 'rightstretch');
  TopStretch := ReadBoolean(F, 'FORMINFO', 'topstretch');
  BottomStretch := ReadBoolean(F, 'FORMINFO', 'bottomstretch');
  //
  MaskRectArea := ReadRect(F, 'FORMINFO', 'maskrectarea');
  HitTestLTPoint := ReadPoint(F, 'FORMINFO', 'hittestlefttoppoint');
  HitTestRTPoint := ReadPoint(F, 'FORMINFO', 'hittestrighttoppoint');
  HitTestLBPoint := ReadPoint(F, 'FORMINFO', 'hittestleftbottompoint');
  HitTestRBPoint := ReadPoint(F, 'FORMINFO', 'hittestrightbottompoint');
  //
  if FMaskName <> ''
  then
    begin
      if isNullRect(MaskRectArea)
      then
        MaskRectArea := ClRect
      else
        begin
          if MaskRectArea.Left > ClRect.Left
          then MaskRectArea.Left := ClRect.Left;
          if MaskRectArea.Top > ClRect.Top
          then MaskRectArea.Top := ClRect.Top;
          if MaskRectArea.Right < ClRect.Right
          then MaskRectArea.Right := ClRect.Right;
          if MaskRectArea.Bottom < ClRect.Bottom
          then MaskRectArea.Bottom := ClRect.Bottom;
        end;
      if isNullPoint(HitTestLTPoint) then  HitTestLTPoint := LTPoint;
      if isNullPoint(HitTestRTPoint) then  HitTestRTPoint := RTPoint;
      if isNullPoint(HitTestLBPoint) then  HitTestLBPoint := LBPoint;
      if isNullPoint(HitTestRBPoint) then  HitTestRBPoint := RBPoint;
    end;
  //
  ButtonsRect := ReadRect(F, 'FORMINFO', 'buttonsrect');
  CaptionRect := ReadRect(F, 'FORMINFO', 'captionrect');
  ButtonsOffset := F.ReadInteger('FORMINFO', 'buttonsoffset', 0);
  CapButtonsInLeft := ReadBoolean(F, 'FORMINFO', 'buttonsinleft');
  //
  MainMenuPopupUp := ReadBoolean(F, 'FORMINFO', 'mainmenupopupup');
  BorderW := F.ReadInteger('FORMINFO', 'borderwidth', 0);
  FormMinWidth := F.ReadInteger('FORMINFO', 'formminwidth', 0);
  AutoRenderingInActiveImage := ReadBoolean(F, 'FORMINFO', 'autorenderinginactiveimage');
  InActiveEffect := ReadInActiveEffect(F, 'FORMINFO', 'inactiveeffect');
  //
  if (RBPoint.X - LTPoint.X  <> 0) and
     (RBPoint.Y - LTPoint.Y <> 0)
  then
    begin
      if LTPoint.X < CLRect.Left then LTPoint.X := CLRect.Left;
      if LTPoint.Y < CLRect.Top then LTPoint.Y := CLRect.Top;
      if RTPoint.X > CLRect.Right then RTPoint.X := CLRect.Right;
      if RTPoint.Y < CLRect.Top then RTPoint.Y := CLRect.Top;
      if LBPoint.X < CLRect.Left then LBPoint.X := CLRect.Left;
      if LBPoint.Y > CLRect.Bottom then LBPoint.Y := CLRect.Bottom;
      if RBPoint.X > CLRect.Right then RBPoint.X := CLRect.Right;
      if RBPoint.Y > CLRect.Bottom then RBPoint.Y := CLRect.Bottom;
    end;
end;

const
  SkinDataFileFormat = 1;

procedure TbsSkinData.SaveToCustomIniFile;
var
  Version: Integer;
begin
  F.EraseSection('VERSION');
  Version := SkinDataFileFormat;
  F.WriteInteger('VERSION', 'ver', Version);
  F.WriteString('VERSION', 'skinname', SkinName);
  F.WriteString('VERSION', 'skinauthor', SkinAuthor);
  F.WriteString('VERSION', 'authoremail', AuthorEmail);
  F.WriteString('VERSION', 'authorurl', AuthorURL);
  F.WriteString('VERSION', 'skincomments', SkinComments);
  //
  F.EraseSection('PICTURES');
  F.WriteString('PICTURES', 'picture', FPictureName);
  F.WriteString('PICTURES', 'inactivepicture', FInActivePictureName);
  F.WriteString('PICTURES', 'mask', FMaskName);
  WriteActivePictures(F);
  //
  F.EraseSection('FORMINFO');
  WriteFormInfo(F);
  //
  F.EraseSection('POPUPWINDOW');
  PopupWindow.SaveToFile(F);
  //
  F.EraseSection('HINTWINDOW');
  HintWindow.SaveToFile(F);
  //
  F.EraseSection('SKINCOLORS');
  FSkinColors.SaveToFile(F);
  //
  WriteObjects(F);
  //
  WriteCtrls(F);
end;

procedure TbsSkinData.SaveToFile;
var
  F: TIniFile;
  Version: Integer;
  F1: TFileStream;
begin
  F1 := TFileStream.Create(FileName, fmCreate);
  F1.Free;
  F := TIniFile.Create(FileName);
  SaveToCustomIniFile(F);
  F.Free;
end;

procedure TbsSkinData.LoadFromFile;
var
  F: TIniFile;
  FilePath: String;
begin

  F := TIniFile.Create(FileName);

  if not CheckSkinFile(F)
  then
    begin
      F.Free;
      Exit;
    end;

  Empty := True;

  ChangeSkinDataProcess := True;

  SendSkinDataMessage(WM_BEFORECHANGESKINDATA);

  ClearAll;

  FilePath := ExtractFilePath(FileName);
  //
  SkinName := F.ReadString('VERSION', 'skinname', '');
  SkinAuthor := F.ReadString('VERSION', 'skinauthor', '');
  AuthorEmail := F.ReadString('VERSION', 'authoremail', '');
  AuthorURL := F.ReadString('VERSION', 'authorurl', '');
  SkinComments := F.ReadString('VERSION', 'skincomments', '');
  //
  FPictureName := F.ReadString('PICTURES', 'picture', '');
  FInActivePictureName := F.ReadString('PICTURES', 'inactivepicture', '');
  FMaskName := F.ReadString('PICTURES', 'mask', '');

  if FPictureName <> ''
  then
    FPicture.LoadFromFile(FilePath + FPictureName)
  else
    FPicture.Assign(nil);

  if FInActivePictureName <> ''
  then
    FInActivePicture.LoadFromFile(FilePath + FInActivePictureName)
  else
    FInActivePicture.Assign(nil);


  if FMaskName <> ''
  then
    FMask.LoadFromFile(FilePath + FMaskName)
  else
    FMask.Assign(nil);

  ReadActivePictures(F, FilePath);
  //
  ReadFormInfo(F);
  //
  PopupWindow.LoadFromFile(F);
  //
  HintWindow.LoadFromFile(F);
  //
  FSkinColors.LoadFromFile(F);
  //
  ReadObjects(F);
  //
  ReadCtrls(F);
  //
  F.UpdateFile;

  F.Free;

  Empty := False;

  SendSkinDataMessage(WM_CHANGESKINDATA);

  ChangeSkinDataProcess := False;

  SendSkinDataMessage(WM_AFTERCHANGESKINDATA);
end;

procedure TbsSkinData.LoadCompressedStoredSkin(AStoredSkin: TbsCompressedStoredSkin);
var
  TmpStream: TMemoryStream;
  CV: Integer;
  FIniStrings: TStrings;
  F: TMemIniFile;
  IsEmpty: Boolean;
  i, Count: Integer;
  B: TBitMap;
begin
  if AStoredSkin.Empty then Exit;
  Empty := True;
  ChangeSkinDataProcess := True;

  SendSkinDataMessage(WM_BEFORECHANGESKINDATA);
  ClearAll;
  TmpStream := TMemoryStream.Create;
  AStoredSkin.DeCompressToStream(TmpStream);
  TmpStream.Seek(0, 0);
  TmpStream.Read(CV, SizeOf(CV));
  if CV > 3
  then
    begin
      TmpStream.Free;
      Exit;
    end;
  //
  TmpStream.Read(IsEmpty, SizeOf(IsEmpty));
  if IsEmpty
  then FPicture.Assign(nil)
  else FPicture.LoadFromStream(TmpStream);

  TmpStream.Read(IsEmpty, SizeOf(IsEmpty));
  if IsEmpty
  then FInActivePicture.Assign(nil)
  else FInActivePicture.LoadFromStream(TmpStream);

  TmpStream.Read(IsEmpty, SizeOf(IsEmpty));
  if IsEmpty
  then FMask.Assign(nil)
  else FMask.LoadFromStream(TmpStream);

  // DSF compatibility
  if CV = 2
  then
    begin
      B := TBitMap.Create;
      TmpStream.Read(IsEmpty, SizeOf(IsEmpty));
      if IsEmpty
      then B.Assign(nil)
      else B.LoadFromStream(TmpStream);

      TmpStream.Read(IsEmpty, SizeOf(IsEmpty));
      if IsEmpty
      then B.Assign(nil)
      else B.LoadFromStream(TmpStream);
      B.Free;
    end;
  //
    TmpStream.Read(Count, SizeOf(Count));
  if Count > 0
  then
    for i := 0 to Count - 1 do
    begin
      FActivePictures.Add(TBitMap.Create);
      TBitMap(FActivePictures.Items[i]).LoadFromStream(TmpStream);
    end;
  //
  FIniStrings := TStringList.Create;
  FIniStrings.LoadFromStream(TmpStream);
  F := TMemIniFile.Create('');
  F.SetStrings(FIniStrings);
  //
  SkinName := F.ReadString('VERSION', 'skinname', '');
  SkinAuthor := F.ReadString('VERSION', 'skinauthor', '');
  AuthorEmail := F.ReadString('VERSION', 'authoremail', '');
  AuthorURL := F.ReadString('VERSION', 'authorurl', '');
  SkinComments := F.ReadString('VERSION', 'skincomments', '');

  FPictureName := F.ReadString('PICTURES', 'picture', '');
  FInActivePictureName := F.ReadString('PICTURES', 'inactivepicture', '');
  FMaskName := F.ReadString('PICTURES', 'mask', '');
  ReadStrings1(F, 'PICTURES', 'activepictures', FActivePicturesNames);

  ReadFormInfo(F);
  PopupWindow.LoadFromFile(F);
  HintWindow.LoadFromFile(F);
  FSkinColors.LoadFromFile(F);
  ReadObjects(F);
  ReadCtrls(F);
  //
  FIniStrings.Free;
  F.Free;
  TmpStream.Free;
  //
  Empty := False;
  SendSkinDataMessage(WM_CHANGESKINDATA);
  ChangeSkinDataProcess := False;
  SendSkinDataMessage(WM_AFTERCHANGESKINDATA);
end;

procedure TbsSkinData.ClearSkin;
begin
  ClearAll;
  SendSkinDataMessage(WM_BEFORECHANGESKINDATA);
  SendSkinDataMessage(WM_CHANGESKINDATA);
  SendSkinDataMessage(WM_AFTERCHANGESKINDATA);
end;

constructor TbsCompressedStoredSkin.Create(AOwner: TComponent);
begin
  inherited;
  FDescription := '';
  FCompressedStream := TMemoryStream.Create;
  FFileName := '';
  FCompressedFileName := '';
end;

destructor TbsCompressedStoredSkin.Destroy;
begin
  FCompressedStream.Free;
  inherited;
end;

function TbsCompressedStoredSkin.GetEmpty: Boolean;
begin
  Result := FCompressedStream.Size = 0;
end;

procedure TbsCompressedStoredSkin.SetFileName;
begin
  if (csDesigning in ComponentState) and not
     (csLoading in ComponentState)
  then
    begin
      FFileName := ExtractFileName(Value);
      LoadFromIniFile(Value);
    end
  else
    FFileName := Value;
end;

procedure TbsCompressedStoredSkin.SetCompressedFileName;
begin
  if (csDesigning in ComponentState) and not
     (csLoading in ComponentState)
  then
    begin
      FCompressedFileName := ExtractFileName(Value);
      LoadFromCompressFile(Value);
    end
  else
    FCompressedFileName := Value;
end;

procedure TbsCompressedStoredSkin.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineBinaryProperty('CompressedData', ReadData, WriteData, True);
end;

const
  CompressVersion = 3;

procedure TbsCompressedStoredSkin.ReadData;
begin
  FCompressedStream.LoadFromStream(Reader);
end;

procedure TbsCompressedStoredSkin.WriteData;
begin
  FCompressedStream.SaveToStream(Writer);
end;

procedure TbsCompressedStoredSkin.DeCompressToStream;
begin
  DecompressStream(S, FCompressedStream);
end;


procedure TbsCompressedStoredSkin.LoadFromSkinData(ASkinData: TbsSkinData);
var
  TmpStream: TMemoryStream;
  BitMap: TBitMap;
  IsEmpty: Boolean;
  i, Count, CV: Integer;
  F: TMemIniFile;
  FIniStrings: TStrings;
begin
  FCompressedStream.Clear;

  TmpStream := TMemoryStream.Create;
  //
  CV := CompressVersion;
  TmpStream.Write(CV, SizeOf(CV));
  // load bitmaps to stream
  IsEmpty := ASkinData.FPicture.Empty;
  TmpStream.Write(IsEmpty, SizeOf(IsEmpty));
  if not IsEmpty
  then
    ASkinData.FPicture.SaveToStream(TmpStream);
  //
  IsEmpty := ASkinData.FInActivePicture.Empty;
  TmpStream.Write(IsEmpty, SizeOf(IsEmpty));
  if not IsEmpty
  then
    ASkinData.FInActivePicture.SaveToStream(TmpStream);
  //
  IsEmpty := ASkinData.FMask.Empty;
  TmpStream.Write(IsEmpty, SizeOf(IsEmpty));
  if not IsEmpty
  then
    ASkinData.FMask.SaveToStream(TmpStream);
  //
  Count := ASkinData.FActivePictures.Count;
  TmpStream.Write(Count, SizeOf(Count));
  if Count <> 0
  then
    for i := 0 to Count - 1 do
    begin
      BitMap := TBitMap(ASkinData.FActivePictures[I]);
      BitMap.SaveToStream(TmpStream);
    end;
  //
  F := TMemIniFile.Create('');
  ASkinData.SaveToCustomIniFile(F);
  FIniStrings := TStringList.Create;
  F.GetStrings(FIniStrings);
  FIniStrings.SaveToStream(TmpStream);
  FIniStrings.Free;
  F.Free;
  //
  CompressStream(TmpStream, FCompressedStream);
  TmpStream.Free;
end;

procedure TbsCompressedStoredSkin.LoadFromIniFile(AFileName: String);
var
  TmpStream: TMemoryStream;
  F: TMemIniFile;
  Path: String;
  FIniStrings: TStrings;
  BitMapName: String;
  BitMap: TBitMap;
  IsEmpty: Boolean;
  i, Count, CV: Integer;
  PNames: TStrings;
begin
  FIniStrings := TStringList.Create;
  FIniStrings.LoadFromFile(AFileName);

  F := TMemIniFile.Create(AFileName);

  if not CheckSkinFile(F)
  then
    begin
      F.Free;
      FIniStrings.Free;
      Exit;
    end;

  Path := ExtractFilePath(AFileName);

  FCompressedStream.Clear;

  TmpStream := TMemoryStream.Create;
  //
  CV := CompressVersion;
  TmpStream.Write(CV, SizeOf(CV));
  // load bitmaps to stream
  BitMap := TBitMap.Create;
  //
  BitMapName := F.ReadString('PICTURES', 'picture', '');
  if BitMapName <> ''
  then BitMap.LoadFromFile(Path + BitMapName)
  else BitMap.Assign(nil);
  IsEmpty := BitMap.Empty;
  TmpStream.Write(IsEmpty, SizeOf(IsEmpty));
  if not IsEmpty
  then BitMap.SaveToStream(TmpStream);
  //
  BitMapName := F.ReadString('PICTURES', 'inactivepicture', '');
  if BitMapName <> ''
  then BitMap.LoadFromFile(Path + BitMapName)
  else BitMap.Assign(nil);
  IsEmpty := BitMap.Empty;
  TmpStream.Write(IsEmpty, SizeOf(IsEmpty));
  if not IsEmpty then BitMap.SaveToStream(TmpStream);
  //
  BitMapName := F.ReadString('PICTURES', 'mask', '');
  if BitMapName <> ''
  then BitMap.LoadFromFile(Path + BitMapName)
  else BitMap.Assign(nil);
  IsEmpty := BitMap.Empty;
  TmpStream.Write(IsEmpty, SizeOf(IsEmpty));
  if not IsEmpty then BitMap.SaveToStream(TmpStream);
  //
  PNames := TStringList.Create;
  ReadStrings1(F, 'PICTURES', 'activepictures', PNames);
  Count := PNames.Count;
  TmpStream.Write(Count, SizeOf(Count));
  if Count > 0
  then
    for i := 0 to Count - 1 do
    begin
      BitMapName := Path + PNames[i];
      BitMap.LoadFromFile(BitMapName);
      BitMap.SaveToStream(TmpStream);
    end;
  PNames.Free;
  //
  FIniStrings.SaveToStream(TmpStream);
  //
  CompressStream(TmpStream, FCompressedStream);
  BitMap.Free;
  FIniStrings.Free;
  TmpStream.Free;
  F.Free;
end;

procedure TbsCompressedStoredSkin.LoadFromCompressFile(AFileName: String);
var
  F: TFileStream;
  CV, Size: LongInt;
begin
  FCompressedStream.Clear;
  F := TFileStream.Create(AFileName, fmOpenRead);
  F.Read(CV, SizeOf(CV));
  if CV <= 3
  then
    begin
      F.Read(Size, SizeOf(Size));
      FCompressedStream.CopyFrom(F, Size);
    end;
  F.Free;
end;


procedure TbsCompressedStoredSkin.LoadFromCompressStream(Stream: TStream);
var
  CV, Size: LongInt;
begin
  FCompressedStream.Clear;
  Stream.Position := 0;
  Stream.Read(CV, SizeOf(CV));
  if CV <= 3
  then
     begin
       Stream.Read(Size, SizeOf(Size));
       FCompressedStream.CopyFrom(Stream, Size);
     end;
end; 

procedure TbsCompressedStoredSkin.SaveToCompressFile(AFileName: String);
var
  F: TFileStream;
  CV, Size: LongInt;
begin
  if Empty then Exit;
  F := TFileStream.Create(AFileName, fmCreate);
  CV := CompressVersion;
  F.Write(CV, SizeOf(CV));
  Size := FCompressedStream.Size;
  F.Write(Size, SizeOf(Size));
  FCompressedStream.SaveToStream(F);
  F.Free;
end;

constructor TbsResourceStrData.Create(AOwner: TComponent); 
begin
  inherited;
  FResStrs := TStringList.Create;
  Init;
  FCharSet := GB2312_CHARSET;//DEFAULT_CHARSET;
end;

destructor TbsResourceStrData.Destroy;
begin
  FResStrs.Free;
  inherited;
end;

procedure TbsResourceStrData.SetResStrs(Value: TStrings);
begin
  FResStrs.Assign(Value);
end;

function TbsResourceStrData.GetResStr(const ResName: String): String;
var
  I: Integer;
begin
  I := FResStrs.IndexOfName(ResName);
  if I <> -1
  then
    Result := Copy(FResStrs[I], Pos('=', FResStrs[I]) + 1,
     Length(FResStrs[I]) - Pos('=', FResStrs[I]) + 1)
  else
    Result := '';
end;

procedure TbsResourceStrData.Init;
begin
  FResStrs.Add('MI_MINCAPTION=Mi&nimize');
  FResStrs.Add('MI_MAXCAPTION=Ma&ximize');
  FResStrs.Add('MI_CLOSECAPTION=&Close');
  FResStrs.Add('MI_RESTORECAPTION=&Restore');
  FResStrs.Add('MI_MINTOTRAYCAPTION=Minimize to &Tray');
  FResStrs.Add('MI_ROLLUPCAPTION=Ro&llUp');

  FResStrs.Add('MINBUTTON_HINT=Minimize');
  FResStrs.Add('MAXBUTTON_HINT=Maximize');
  FResStrs.Add('CLOSEBUTTON_HINT=Close');
  FResStrs.Add('TRAYBUTTON_HINT=Minimize to Tray');
  FResStrs.Add('ROLLUPBUTTON_HINT=Roll Up');
  FResStrs.Add('MENUBUTTON_HINT=System menu');

  FResStrs.Add('EDIT_UNDO=Undo');
  FResStrs.Add('EDIT_COPY=Copy');
  FResStrs.Add('EDIT_CUT=Cut');
  FResStrs.Add('EDIT_PASTE=Paste');
  FResStrs.Add('EDIT_DELETE=Delete');
  FResStrs.Add('EDIT_SELECTALL=Select All');

  FResStrs.Add('MSG_BTN_YES=&Yes');
  FResStrs.Add('MSG_BTN_NO=&No');
  FResStrs.Add('MSG_BTN_OK=OK');
  FResStrs.Add('MSG_BTN_CANCEL=Cancel');
  FResStrs.Add('MSG_BTN_ABORT=&Abort');
  FResStrs.Add('MSG_BTN_RETRY=&Retry');
  FResStrs.Add('MSG_BTN_IGNORE=&Ignore');
  FResStrs.Add('MSG_BTN_ALL=&All');
  FResStrs.Add('MSG_BTN_NOTOALL=N&oToAll');
  FResStrs.Add('MSG_BTN_YESTOALL=&YesToAll');
  FResStrs.Add('MSG_BTN_HELP=&Help');
  FResStrs.Add('MSG_BTN_OPEN=&Open');
  FResStrs.Add('MSG_BTN_SAVE=&Save');
  FResStrs.Add('MSG_BTN_CLOSE=Close');

  FResStrs.Add('MSG_BTN_BACK_HINT=Go To Last Folder Visited');
  FResStrs.Add('MSG_BTN_UP_HINT=Up One Level');
  FResStrs.Add('MSG_BTN_NEWFOLDER_HINT=Create New Folder');
  FResStrs.Add('MSG_BTN_VIEWMENU_HINT=View Menu');
  FResStrs.Add('MSG_BTN_STRETCH_HINT=Stretch Picture');

  FResStrs.Add('MSG_FILENAME=File name:');
  FResStrs.Add('MSG_FILETYPE=File type:');
  FResStrs.Add('MSG_NEWFOLDER=New Folder');
  FResStrs.Add('MSG_LV_DETAILS=Details');
  FResStrs.Add('MSG_LV_ICON=Large icons');
  FResStrs.Add('MSG_LV_SMALLICON=Small icons');
  FResStrs.Add('MSG_LV_LIST=List');
  FResStrs.Add('MSG_PREVIEWSKIN=Preview');
  FResStrs.Add('MSG_PREVIEWBUTTON=Button');
  FResStrs.Add('MSG_OVERWRITE=Are you want to overwrite old file?');

  FResStrs.Add('MSG_CAP_WARNING=Warning');
  FResStrs.Add('MSG_CAP_ERROR=Error');
  FResStrs.Add('MSG_CAP_INFORMATION=Information');
  FResStrs.Add('MSG_CAP_CONFIRM=Confirm');
  FResStrs.Add('MSG_CAP_SHOWFLAG=Do not display this message again');

  FResStrs.Add('CALC_CAP=Calculator');
  FResStrs.Add('ERROR=Error');
  FResStrs.Add('COLORGRID_CAP=Basic colors');
  FResStrs.Add('CUSTOMCOLORGRID_CAP=Custom colors');
  FResStrs.Add('ADDCUSTOMCOLORBUTTON_CAP=Add to Custom Colors');

  FResStrs.Add('FONTDLG_COLOR=Color:');
  FResStrs.Add('FONTDLG_NAME=Name:');
  FResStrs.Add('FONTDLG_SIZE=Size:');
  FResStrs.Add('FONTDLG_HEIGHT=Height:');
  FResStrs.Add('FONTDLG_EXAMPLE=Example:');
  FResStrs.Add('FONTDLG_STYLE=Style:');
  FResStrs.Add('FONTDLG_SCRIPT=Script:');

  FResStrs.Add('DB_DELETE_QUESTION=Delete record?');
  FResStrs.Add('DB_MULTIPLEDELETE_QUESTION=Delete all selected records?');

  FResStrs.Add('NODISKINDRIVE=There is no disk in Drive or Drive is not ready');
  FResStrs.Add('NOVALIDDRIVEID=Not a valid Drive ID');

  FResStrs.Add('FLV_NAME=Name');
  FResStrs.Add('FLV_SIZE=Size');
  FResStrs.Add('FLV_TYPE=Type');
  FResStrs.Add('FLV_LOOKIN=Look in: ');
  FResStrs.Add('FLV_MODIFIED=Modified');
  FResStrs.Add('FLV_ATTRIBUTES=Attributes');
  FResStrs.Add('FLV_DISKSIZE=Disk Size');
  FResStrs.Add('FLV_FREESPACE=Free Space');

  FResStrs.Add('PRNDLG_NAME=Name:');
  FResStrs.Add('PRNDLG_PRINTER=Printer');
  FResStrs.Add('PRNDLG_PROPERTIES=Properties...');
  FResStrs.Add('PRNDLG_TYPE=Type:');
  FResStrs.Add('PRNDLG_STATUS=Status:');
  FResStrs.Add('PRNDLG_WHERE=Where:');
  FResStrs.Add('PRNDLG_COMMENT=Comment:');
  FResStrs.Add('PRNDLG_PRINTRANGE=Print range');
  FResStrs.Add('PRNDLG_COPIES=Copies');
  FResStrs.Add('PRNDLG_NUMCOPIES=Number of copies:');
  FResStrs.Add('PRNDLG_COLLATE=Collate');
  FResStrs.Add('PRNDLG_ALL=All');
  FResStrs.Add('PRNDLG_PAGES=Pages');
  FResStrs.Add('PRNDLG_SELECTION=Selection');
  FResStrs.Add('PRNDLG_PRINTTOFILE=Print to file');
  FResStrs.Add('PRNDLG_FROM=from:');
  FResStrs.Add('PRNDLG_TO=to:');
  FResStrs.Add('PRNDLG_ORIENTATION=Orientation');
  FResStrs.Add('PRNDLG_PAPER=Paper');
  FResStrs.Add('PRNDLG_PORTRAIT=Portrait');
  FResStrs.Add('PRNDLG_LANDSCAPE=Landscape');
  FResStrs.Add('PRNDLG_SOURCE=Source:');
  FResStrs.Add('PRNDLG_SIZE=Size:');
  FResStrs.Add('PRNDLG_MARGINS=Margins (millimeters)');
  FResStrs.Add('PRNDLG_MARGINS_INCHES=Margins (inches)');
  FResStrs.Add('PRNDLG_LEFT=Left:');
  FResStrs.Add('PRNDLG_RIGHT=Right:');
  FResStrs.Add('PRNDLG_TOP=Top:');
  FResStrs.Add('PRNDLG_BOTTOM=Bottom:');
  FResStrs.Add('PRNDLG_WARNING=There are no printers in your system!');
  FResStrs.Add('FIND_NEXT=Find next');
  FResStrs.Add('FIND_WHAT=Find what:');
  FResStrs.Add('FIND_DIRECTION=Direction');
  FResStrs.Add('FIND_DIRECTIONUP=Up');
  FResStrs.Add('FIND_DIRECTIONDOWN=Down');
  FResStrs.Add('FIND_MATCH_CASE=Match case');
  FResStrs.Add('FIND_MATCH_WHOLE_WORD_ONLY=Match whole word only');
  FResStrs.Add('FIND_REPLACE_WITH=Replace with:');
  FResStrs.Add('FIND_REPLACE=Replace');
  FResStrs.Add('FIND_REPLACE_All=Replace All');
  FResStrs.Add('FIND_REPLACE_CLOSE=Close');

  FResStrs.Add('MORECOLORS=More colors...');
  FResStrs.Add('AUTOCOLOR=Automatic');

end;

end.

