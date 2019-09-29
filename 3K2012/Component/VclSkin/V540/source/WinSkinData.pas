unit WinSkinData;

interface

{$WARNINGS OFF}
{$HINTS OFF}
{$RANGECHECKS OFF}

uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  IniFiles, Dialogs, FileCtrl, SkinRead, WinSkinStore, imgutil, Winskinini,
  ImgList, typinfo;

const
  CN_SkinChanged = WM_USER + $3001;
  CN_CaptionBtnClick = WM_USER + $3114;
  CN_CaptionBtnVisible = WM_USER + $3115;
  CN_UPdateMainMenu = WM_USER + $3105;
  CN_SkinEnabled = WM_USER + $3106;
  CN_TabSheetClose = WM_USER + $3107;
  CN_SkinNotify = WM_USER + $3108;
  NM_COOLSB_CUSTOMDRAW = 0 - $AFF;
  c_version = '5.40.07.15';
  c_skintag = 33333;

 // Billenium Effects messages
  BE_ID = $41A2;
  BE_BECLOSE = $3046;
  BE_BASE = CM_BASE + $0C4A;
  CM_BEPAINT = BE_BASE + 0; // Paint client area to Billenium Effects' DC
  CM_BENCPAINT = BE_BASE + 1; // Paint non client area to Billenium Effects' DC
  CM_BEFULLRENDER = BE_BASE + 2; // Paint whole control to Billenium Effects' DC
  CM_BEWAIT = BE_BASE + 3; // Don't execute effect yet
  CM_BERUN = BE_BASE + 4; // Execute effect now!

type
  TWinContainer = (xccForm, xccFrame, xccToolbar, xccCoolbar, xccControlbar, xccPanel,
    xccScrollBox, xccGroupBox, xccTabSheet, xccPageScroller);
  TWinContainers = set of TWinContainer;

  TSkinOption = (xoMDIScrollbar, xoMenuMerge, xoTransparent, xoPreview, xoParentBackGround,
    xoNoFocusRect, xoToolbarBK, xoToolbarButton, xoMDIChildBorder, xoMenuBG, xoCaptionButtonHint,
    xoFormScrollbar);
  TSkinOptions = set of TSkinOption;

  TSkinControlType = (xcMainMenu, xcPopupMenu, xcMenuItem, xcToolbar, xcControlbar, xcCombo,
    xcCheckBox, xcRadioButton, xcProgress, xcScrollbar, xcEdit,
    xcButton, xcBitBtn, xcSpeedButton, xcSpin, xcPanel, xcGroupBox, xcStatusBar,
    xcTab, xcTrackBar, xcSystemMenu, xcFastReport);
  TSkinControlTypes = set of TSkinControlType;

  TShemeColor = (csText, csTitleTextActive, csTitleTextNoActive,
    csButtonFace, csButtonText,
    csButtonHilight, csButtonlight, csButtonShadow, csButtonDkshadow,
    csSelectText, csSelectBg, csHilightText, csHilight,
    csMenuBar, csMenuBarText, csMenuText, csMenubg, csCaption,
    csScrollbar, csTextDisable);
  TShemeColors = array[csText..csTextDisable] of Tcolor;

  TSkinFormType = (sfMainform, sfOnlyThisForm, sfDialog, sfDLL);

  TSkinData = class;
  TOnFormSkin = procedure(Sender: TObject; aName: string; var DoSkin: boolean) of object;
  TOnSkinForm = procedure(Sender: TObject; ahwnd: HWND; aName: string) of object;
  TOnSkinControl = procedure(Sender: TComponent; SkinData: TSkinData; Form, Control: TControl;
    ControlClass: string; var SkinnedControl: TComponent) of object;
  TGetScrollBarInfo = function(hwnd: HWND; idObject: Longint;
    var psbi: TScrollBarInfo): BOOL; stdcall;
  FTrackMouseEvent = function(var EventTrack: TTrackMouseEvent): BOOL; stdcall;
  TGetComboBoxInfo = function(hwndCombo: HWND; var pcbi: TComboBoxInfo): BOOL; stdcall;
  TDisableProcessWindowsGhosting = procedure(); stdcall;

  TDataSkinObject = class(TObject)
  public
    r: Trect;
    Map: TBitMap;
    trans: integer;
    Tile: integer;
    IDName: string;
    frame: integer;
    style: integer;
    Normalcolor, Overcolor, Downcolor: integer;
    Normalcolor2, Overcolor2, Downcolor2: Tcolor;
    constructor Create(AIDName: string);
    destructor Destroy; override;
  end;

  TDataSkinBorder = class(TDataSkinObject)
  public
    MaskMap: TBitMap;
    constructor Create(AIDName: string);
    destructor Destroy; override;
  end;

  TDataSkinTitle = class(TDataSkinObject)
  public
    Aligment, BackGround, FontHeight: integer;
    backleft, backright: integer;
    activetext, inactivetext: Tcolor;
  end;

  TDataSkinButton = class(TDataSkinObject)
  public
    CheckMap, RadioMap: Tbitmap;
    radioframe, checkframe: integer;
    newnormal, newover, newdown: boolean;
    constructor Create(AIDName: string);
    destructor Destroy; override;
  end;

  TDataSkinSysButton = class(TDataSkinObject)
  public
    Action: integer;
    Align: integer;
    XCoord, YCoord: integer;
    CombineOp: integer;
    Visibility, Visibility1: integer;
  end;

  TDataSkinBoxLabel = class(TDataSkinObject)
  public
    LeftShift, RightShift, Alignment: integer;
  end;

  TSkinControlList = class(TPersistent)
  private
    Fedit: TStrings;
    fCheckbox: Tstrings;
    fRadiobutton: tStrings;
    fcombobox: TStrings;
    procedure SetEdit(Value: Tstrings);
    procedure SetCheckbox(Value: Tstrings);
    procedure SetRadiobutton(Value: Tstrings);
    procedure Setcombobox(Value: Tstrings);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Edit: TStrings read Fedit write SetEdit;
    property Checkbox: TStrings read Fcheckbox write SetCheckbox;
    property Combobox: TStrings read Fcombobox write SetCombobox;
    property Radiobutton: TStrings read Fradiobutton write Setradiobutton;
  end;

  TSkinData = class(TComponent)
  private
    fskinfile: string;
    ini: TQuickIni;
    fMenuSideBar: Tcolor;
    ms: TMemorystream;
    factive: boolean;
    fdisableTag: integer;
    FContainers: TWinContainers;
    FSkinControls: TSkinControlTypes;
    fSkinOptions: TSkinOptions;
    ftype: TSkinFormType;
    fOnFormSkin: TOnFormSkin;
    fOnBeforeSkinForm: TOnSkinForm;
    fOnAfterSkinForm: TOnSkinForm;
    fOnSkinChanged: TNotifyevent;
    FOnSkinControl: TOnSkinControl;
    FInDLL: boolean;
    f3rdControls: TStrings;
    fmenuauto: boolean;
    fversion: string;
    fmenumerge: boolean;
    fhintwindow: THintWindow;
    hashint: boolean;
    procedure ReadMenuBar(var aobject: TDataSkinObject; aname: string);
    procedure ReadProgress(var aobject: TDataSkinObject; aname: string);
    procedure ReadRGB(Section, aname: string; var value: Tcolor);
    function GetColor(const s1: string; acolor: Tcolor): Tcolor;
    procedure SetFrame;
    function GetSectionNum(asection, aname: string): integer;
    procedure WriteData(Stream: TStream);
    procedure ReadData(Stream: TStream);
    function GetSkinStore: string;
    procedure SetSkinStore(const Value: string);
    procedure CreateMdibtn(n: integer);
    procedure SetActive(Value: boolean);
    procedure SetVersion(Value: string);
    procedure InitControlList;
    procedure SetControlList(Value: TStrings);
    procedure ReadTrack(var aobject: TDataSkinObject; aname: string);
    procedure CreateLogo;
    procedure CreateCaptionFont;
    procedure CreateMinCaption;
  protected
    procedure ReadObject(var aobject: TDataskinobject; aname: string);
    procedure ReadObject2(var aobject: TDataSkinborder; aname, image2: string);
    procedure ReadButton;
    procedure ReadSysButton;
    procedure LoadFromIni(filename: string);
    procedure ReadBord;
    procedure ReadColor;
    procedure ReadColor2(item: TShemeColor; key: string; cdefault: Tcolor);
    procedure ReadTitle(aobject: TDataSkinObject; aname: string);
    procedure ReadBoxLabel(var aobject: TDataSkinBoxLabel; aname: string);
    procedure DefineProperties(Filer: TFiler); override;
    procedure RebuildToolbar;
    procedure ReBuildCombobox;
    procedure ReBuildComboxArrow;
    procedure Loaded; override;
    function LoadSkin: boolean;
    procedure UpdateSkin;
  public
    reader: TSkinReader;
    data: Tmemorystream;
    Empty: boolean;
    Colors: TShemeColors;
    hasColors: array[csText..csTextDisable] of boolean;
    ColorPreset: array of Tcolor;
    SysIcon: Tbitmap;
    Title: TDataSkinTitle;
    SysBtn: array of TDataSkinSysButton;
    Button: TDataSkinButton;
    tab: Tdataskinborder;
    HSpin, VSpin: Tdataskinborder;
    Comboxborder, ExtraImages: TDataSkinObject;
    combox: Tdataskinborder;
    comboxarrow: TDataSkinObject;
    Box, Toolbar, Toolbarbtn: TDataSkinObject;
    progress, progresschunk: TdataskinObject;
    boxlabel: TDataSkinBoxLabel;
    StatusBar, TabSheet: TDataSkinObject;
    Header: TDataSkinObject;
    Menubar, MenuItem, MenuitemBG: TDataSkinObject;
    SArrow, HBar, VBar, HSlider, VSlider: TDataSkinObject;
    TrackHorz, TrackVert: TDataSkinObject;
    TrackBar, TrackBarVert: TDataSkinObject;
    TrackLeft, Trackright, Tracktop, Trackbottom: TDataSkinObject;
    MinCaption: TDataSkinObject;
    border: array[1..4] of TDataskinborder;
    sectionlist: Tstringlist;
    PresetColors: array[0..9] of integer;
    BGBrush: HBRUSH;
    MenuMsg: boolean;
    bmpmenu: Timagelist;
    SkinName: string;
    DebugList: TStrings;
    cxMax, cyMax: integer;
    logo: TBitmap;
    CaptionFont: Tfont;
    formhwnd: Thandle;
    hintcount: integer;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromFile(value: string);
    procedure LoadFromStream(Stream: TStream);
    procedure LoadFromCollection(astore: TSkinStore; aindex: integer);
    procedure Readbmp(bmp: Tbitmap; fname: string);
    function GetPrecolor(var acolor: Tcolor; n: integer): boolean;
    function GetFileName(s: string): string;
    procedure Uninstall;
    procedure Install;
    procedure DoFormSkin(ahwnd: Thandle; aname: string; var Doskin: boolean);
    procedure DoSkinChanged;
    procedure AddNestForm(fParent, fNested: TWincontrol);
    procedure UpdateSkinControl(fParent: Tform; acontrol: Twincontrol = nil);
    procedure DeleteGraphicControl(fParent: Tform; acontrol: TGraphicControl);
    procedure UpdateMenu(fParent: Tform);
    procedure UpdateMainMenu(done: boolean);
    procedure SkinForm(ahwnd: THandle);
    procedure InstallThread(aThreadID: integer);
    procedure UnInstallThread(aThreadID: integer);
    procedure ChangeProperty(control: TObject; aprop, value: string);
    procedure EnableSkin(b: boolean);
    function GetCaptionColor: Tcolor;
    function GetScrollBarInfo(hwnd: HWND; idObject: Longint;
      var psbi: TScrollBarInfo): boolean;
    procedure DoDebug(s: string);
    procedure ChangeForm(aform: Tform);
    procedure GetAppIcon;
    procedure ActivateHint(aRect: TRect; const AHint: string);
    procedure HideHint;
    function IsHint: Boolean;
  published
    property Active: boolean read factive write setactive;
    property DisableTag: integer read fdisabletag write fdisabletag;
    property SkinControls: TSkinControlTypes read fSkinControls write fSkinControls;
    property Options: TSkinOptions read fSkinOptions write fSkinOptions;
    property Skin3rd: TStrings read f3rdControls write SetControllist;
    property SkinFile: string read fskinfile write LoadFromFile;
    property SkinStore: string read GetSkinStore write SetSkinStore;
    property SkinFormtype: TSkinFormType read ftype write ftype;
    property Version: string read fversion write setversion;
    property MenuUpdate: boolean read fmenuauto write fmenuauto;
    property MenuMerge: boolean read fmenumerge write fmenumerge;
//    property InDLL :boolean read findll write findll;
    property OnFormSkin: TOnFormSkin read fOnFormSkin write fOnFormSkin;
    property OnSkinChanged: TNotifyevent read fOnSkinChanged write fOnSkinChanged;
    property OnSkinControl: TOnSkinControl read FOnSkinControl write FOnSkinControl;
    property OnBeforeSkinForm: TOnSkinForm read fOnBeforeSkinForm write fOnBeforeSkinForm;
    property OnAfterSkinForm: TOnSkinForm read fOnAfterSkinForm write fOnAfterSkinForm;
  end;

function RGBToColor(R, G, B: Byte): TColor;
function strcolor(s: string): Tcolor;
function Tnt_DrawTextW(hDC: HDC; wString: WideString; var lpRect: TRect; uFormat: UINT): Integer;
function StrToWideStr(const S: AnsiString): WideString;
function WideStringToStringEx(const WS: WideString): AnsiString;
function _WStr(lpString: PWideChar; cchCount: Integer): WideString;
function FindControlx(Handle: HWnd): TWinControl;
procedure SkinDll(adata: Pointer);
procedure DoTrackMouse(ahwnd: THandle);
//procedure CopyBMP(sbmp,dbmp:TBitMap);

var
  GSkinData: TSkinData;
  Win32PlatformIsUnicode: boolean;
  IsVista: boolean;
  DefaultUserCodePage: Cardinal;
  pGetScrollBarInfo: TGetScrollBarInfo;
  pTrackMouseEvent: FTrackMouseEvent;
  pGetComboBoxInfo: TGetComboBoxInfo;
  pDisableProcessWindowsGhosting: TDisableProcessWindowsGhosting;
implementation

uses Winskinform, WinSkinDlg, winsubclass;

constructor TSkinControlList.Create;
begin
  inherited create;
  fedit := TStringList.create;
  fCombobox := TStringList.create;
  fcheckbox := TStringList.create;
  fradiobutton := TStringList.create;
end;

procedure TSkinData.InitControlList;
begin
  f3rdControls.add('TCategoryButtons=scrollbar');
  f3rdControls.add('TPngSpeedbutton=pngspeedbutton');
  f3rdControls.add('TPngBitBtn=pngbitbtn');
  f3rdControls.add('TVirtualStringTree=scrollbar');
  f3rdControls.add('TVirtualDrawTree=scrollbar');

  f3rdControls.add('TTBXDockablePanel=Panel');
  f3rdControls.add('TAdvPanelGroup=scrollbar');
  f3rdControls.add('TComboboxex=combobox');
  f3rdControls.add('TRxSpeedButton=speedbutton');
  f3rdControls.add('THTMLViewer=scrollbar');
  f3rdControls.add('TDBCtrlGrid=scrollbar');

  f3rdControls.add('TfrSpeedButton=speedbutton');
  f3rdControls.add('TfrTBButton=speedbutton');

  f3rdControls.add('TControlBar=Panel');
  f3rdControls.add('TTBDock=Panel');
  f3rdControls.add('TTBToolbar=Panel');
//    f3rdControls.add('TAdvPageControl=nil');

  f3rdControls.add('TImageEnMView=scrollbar');
  f3rdControls.add('TImageEnView=scrollbar');
  f3rdControls.add('TAdvMemo=scrollbar');
  f3rdControls.add('TDBAdvMemo=scrollbar');

  f3rdControls.add('TcxDBLookupComboBox=combobox');
  f3rdControls.add('TcxDBComboBox=combobox');
  f3rdControls.add('TcxDBDateEdit=combobox');
  f3rdControls.add('TcxDBImageComboBox=combobox');
  f3rdControls.add('TcxDBCalcEdit=combobox');
  f3rdControls.add('TcxDBBlobEdit=combobox');
  f3rdControls.add('TcxDBPopupEdit=combobox');
  f3rdControls.add('TcxDBFontNameComboBox=combobox');
  f3rdControls.add('TcxDBShellComboBox=combobox');

  f3rdControls.add('TRxLookupEdit=combobox');
  f3rdControls.add('TRxDBLookupCombo=combobox');

  f3rdControls.add('TRzGroup=panel');
  f3rdControls.add('TRzButton=button');
  f3rdControls.add('TRzBitbtn=bitbtn');
  f3rdControls.add('TRzMenuButton=menubtn');
  f3rdControls.add('TRzCheckGroup=CheckGroup');
  f3rdControls.add('TRzRadioGroup=Radiogroup');
//    f3rdControls.add('TRzRadioButton=Radiobutton');
//    f3rdControls.add('TRzCheckBox=Checkbox');
  f3rdControls.add('TRzButtonEdit=Edit');
  f3rdControls.add('TRzDBRadioGroup=Radiogroup');
  f3rdControls.add('TRzDBRadioButton=Radiobutton');
  f3rdControls.add('TRzDateTimeEdit=combobox');
  f3rdControls.add('TRzColorEdit=combobox');
  f3rdControls.add('TRzDateTimePicker=combobox');
  f3rdControls.add('TRzDBDateTimeEdit=combobox');
  f3rdControls.add('TRzDbColorEdit=combobox');
  f3rdControls.add('TRzDBDateTimePicker=combobox');

  f3rdControls.add('TLMDButton=bitbtn');
  f3rdControls.add('TLMDGroupBox=Groupbox');
  f3rdControls.add('TDBCheckboxEh=Checkbox');
  f3rdControls.add('TDBCheckboxEh=Checkbox');
  f3rdControls.add('TLMDCHECKBOX=Checkbox');
  f3rdControls.add('TLMDDBCHECKBOX=Checkbox');

  f3rdControls.add('TLMDRadiobutton=Radiobutton');

  f3rdControls.add('TLMDCalculator=panel');
  f3rdControls.add('TLMDGROUPBOX=Panel');
  f3rdControls.add('TLMDSIMPLEPANEL=Panel');
  f3rdControls.add('TLMDDBCalendar=Panel');
  f3rdControls.add('TLMDButtonPanel=Panel');
  f3rdControls.add('TLMDLMDCalculator=Panel');
  f3rdControls.add('TLMDHeaderPanel=Panel');
  f3rdControls.add('TLMDTechnicalLine=Panel');
  f3rdControls.add('TLMDLMDClock=Panel');

  f3rdControls.add('TLMDTrackbar=panel');

  f3rdControls.add('TLMDListCombobox=combobox');
  f3rdControls.add('TLMDCheckListCombobox=combobox');
  f3rdControls.add('TLMDHeaderListCombobox=combobox');
  f3rdControls.add('TLMDImageCombobox=combobox');
  f3rdControls.add('TLMDColorCombobox=combobox');
  f3rdControls.add('TLMDFontCombobox=combobox');
  f3rdControls.add('TLMDFontSizeCombobox=combobox');
  f3rdControls.add('TLMDFontSizeCombobox=combobox');
  f3rdControls.add('TLMDPrinterCombobox=combobox');
  f3rdControls.add('TLMDDriveCombobox=combobox');
  f3rdControls.add('TLMDCalculatorComboBox=combobox');
  f3rdControls.add('TLMDTrackBarComboBox=combobox');
  f3rdControls.add('TLMDCalendarComboBox=combobox');
  f3rdControls.add('TLMDTreeComboBox=combobox');

  f3rdControls.add('TLMDRADIOGROUP=radiogroup');
  f3rdControls.add('TLMDCheckGroup=CheckGroup');
  f3rdControls.add('TLMDDBRADIOGROUP=radiogroup');
  f3rdControls.add('TLMDDBCheckGroup=CheckGroup');

  f3rdControls.add('TLMDCalculatorEdit=edit');
  f3rdControls.add('TLMDEDIT=Edit');
  f3rdControls.add('TLMDMASKEDIT=Edit');
  f3rdControls.add('TLMDBROWSEEDIT=Edit');
  f3rdControls.add('TLMDEXTSPINEDIT=Edit');
  f3rdControls.add('TLMDCALENDAREDIT=Edit');
  f3rdControls.add('TLMDFILEOPENEDIT=Edit');
  f3rdControls.add('TLMDFILESAVEEDIT=Edit');
  f3rdControls.add('TLMDCOLOREDIT=Edit');

  f3rdControls.add('TLMDDBEDIT=Edit');
  f3rdControls.add('TLMDDBMASKEDIT=Edit');
  f3rdControls.add('TLMDDBEXTSPINEDIT=Edit');
  f3rdControls.add('TLMDDBSPINEDIT=Edit');
  f3rdControls.add('TLMDDBEDITDBLookup=Edit');
  f3rdControls.add('TLMDEDITDBLookup=Edit');

    //combobox
  f3rdControls.add('TDBLookupCombobox=Combobox');
  f3rdControls.add('TWWDBCombobox=Combobox');
  f3rdControls.add('TWWDBLookupCombo=Combobox');
  f3rdControls.add('TWWDBCombobox=Combobox');
  f3rdControls.add('TWWKeyCombo=Combobox');
  f3rdControls.add('TWWTempKeyCombo=combobox');
  f3rdControls.add('TWWDBDateTimePicker=Combobox');

  f3rdControls.add('TWWRADIOGROUP=radiogroup');
  f3rdControls.add('TWWDBEDIT=Edit');

  f3rdControls.add('TcxButton=bitbtn');
//    f3rdControls.add('TcxDBCheckBox=checkbox');
  f3rdControls.add('TcxDBRadioGroup=radiogroup');
  f3rdControls.add('TcxRadioGroup=radiogroup');
  f3rdControls.add('TcxGroupbox=groupbox');
//    f3rdControls.add('TcxCheckBox=checkbox');

{    f3rdControls.add('TDXDBPICKEDIT=Combobox');
    f3rdControls.add('TDXDBCALCEDIT=Combobox');
    f3rdControls.add('TDXDBIMAGEEDIT=Combobox');
    f3rdControls.add('TDXDBPOPUPEDIT=Combobox');
    f3rdControls.add('TDXDBEXTLOOKUPEDIT=Combobox');
    f3rdControls.add('TDXDBLOOKUPEDIT=Combobox');
    f3rdControls.add('TDXDBDATEEDIT=Combobox');
    f3rdControls.add('TDXDATEEDIT=Combobox');
    f3rdControls.add('TDXPICKEDIT=Combobox');
    f3rdControls.add('TDXPOPUPEDIT=Combobox');
    //edit
    f3rdControls.add('TDXDBCURRENCYEDIT=Edit');
    f3rdControls.add('TDXDBEDIT=Edit');
    f3rdControls.add('TDXDBMASKEDIT=Edit');
    f3rdControls.add('TDXDBHYPERLINKEDIT=Edit');
    f3rdControls.add('TDXEDIT=Edit');
    f3rdControls.add('TDXMASKEDIT=Edit');
    f3rdControls.add('TDXBUTTONEDIT=Edit');
    f3rdControls.add('TDXCURRENCYEDIT=Edit');
    f3rdControls.add('TDXHYPERLINKEDIT=Edit');}

  f3rdControls.add('TOVCPICTUREFIELD=Edit');
  f3rdControls.add('TOVCDBPICTUREFIELD=Edit');
  f3rdControls.add('TOVCSLIDEREDIT=Edit');
  f3rdControls.add('TOVCDBSLIDEREDIT=Edit');
  f3rdControls.add('TOVCSIMPLEFIELD=Edit');
  f3rdControls.add('TOVCDBSIMPLEFIELD=Edit');
  f3rdControls.add('TO32DBFLEXEDIT=Edit');
  f3rdControls.add('TOVCNUMERICFIELD=Edit');
  f3rdControls.add('TOVCDBNUMERICFIELD=Edit');
end;

destructor TSkinControlList.Destroy;
begin
  fedit.free;
  fcombobox.free;
  fradiobutton.free;
  fcheckbox.free;
  inherited destroy;
end;

procedure TSkinControlList.SetEdit(Value: TStrings);
begin
  FEdit.Assign(Value);
end;

procedure TSkinControlList.SetCheckbox(Value: TStrings);
begin
  Fcheckbox.Assign(Value);
end;

procedure TSkinControlList.Setradiobutton(Value: TStrings);
begin
  Fradiobutton.Assign(Value);
end;

procedure TSkinControlList.SetCombobox(Value: TStrings);
begin
  FCombobox.Assign(Value);
end;

constructor TDataSkinObject.Create(AIDName: string);
begin
  inherited create;
  Map := Tbitmap.create;
  Idname := aidname;
end;

destructor TDataSkinObject.Destroy;
begin
  try
    if not IsBadReadPtr(map, map.InstanceSize) then begin
      map.assign(nil);
      Map.free;
    end;
  except
  end;

  inherited destroy;
end;

constructor TDataSkinBorder.Create(AIDName: string);
begin
  inherited create(aidname);
  MaskMap := TBitMap.create;
  Idname := aidname;
end;

destructor TDataSkinBorder.Destroy;
begin
  MaskMap.free;
  inherited destroy;
end;

constructor TDataSkinButton.Create(AIDName: string);
begin
  inherited create(aidname);
  CheckMap := Tbitmap.create;
  RadioMap := Tbitmap.create;
end;

destructor TDataSkinButton.Destroy;
begin

  try
    if not IsBadReadPtr(checkmap, checkmap.InstanceSize) then begin
      CheckMap.free;
    end;
  except
  end;
  try
    if not IsBadReadPtr(radiomap, radiomap.InstanceSize) then begin
      RadioMap.free;
    end;
  except
  end;

  inherited destroy;
end;

constructor TSkinData.Create(AOwner: TComponent);
var
  i: integer;
begin
  inherited Create(AOwner);
  fOnBeforeSkinForm := nil;
  fOnAfterSkinForm := nil;
  ftype := sfMainform;
  data := TMemorystream.create;
  Empty := True;
  sysicon := Tbitmap.create;
  sysicon.PixelFormat := pf24bit;
  logo := Tbitmap.create;
  logo.PixelFormat := pf24bit;
  MenuMsg := true;
  findll := false;
  f3rdControls := TStringlist.create;
  initcontrollist;
  Button := TDataSkinButton.create('Buttons');
  border[1] := TDataskinborder.create('Left');
  border[2] := TDataskinborder.create('Right');
  border[3] := TDataskinborder.create('Top');
  border[4] := TDataskinborder.create('Bottom');
  Title := TDataSkinTitle.create('Title');
  fmenuauto := true;
  fmenumerge := false;
  fSkinOptions := [xoPreview, xoToolbarBK, xoCaptionButtonHint];
//  if gSkindata=nil then gskindata:=self;
  fdisabletag := 99;
  FContainers := [xccForm, xccFrame, xccToolbar, xccCoolbar, xccControlbar, xccPanel,
    xccScrollBox, xccGroupBox, xccTabSheet, xccPageScroller];
  FSkinControls := [xcMainMenu, xcPopupMenu, xcToolbar, xcControlbar, xcCombo,
    xcCheckBox, xcRadioButton, xcProgress, xcScrollbar, xcedit,
    xcButton, xcedit, xcBitBtn, xcSpeedButton, xcPanel, xcSpin, xcTrackbar, xcGroupBox,
    xcTab, xcStatusBar, xcSystemMenu];
  bmpmenu := Timagelist.create(nil);
  bmpmenu.GetResource(rtBitmap, 'VCLSKINMENU', 16, [lrTransparent], clwhite);
  fversion := c_version;
  cxMax := GetSystemMetrics(SM_CXMAXIMIZED);
  cyMax := GetSystemMetrics(SM_CYMAXIMIZED);
  mincaption := nil;
  //hint
  hintcount := 0;
  fhintwindow := THintWindow.Create(nil);
  hashint := false;

//  bmpmenu.ResInstLoad(rtBitmap,'VCLSKINMENU',16,[lrTransparent],clwhite);
end;

destructor TSkinData.Destroy;
var
  i: integer;
begin
  bmpmenu.free;
  f3rdControls.free;
  if skinmanager <> nil then
    skinmanager.Removeskindata(self);
//  skinmanager=nil;
  data.free;
  sysicon.free;
  logo.free;
  fhintwindow.Free;
  if CaptionFont <> nil then CaptionFont.free;
  for i := 1 to 4 do begin
    border[i].free;
  end;

  for i := 0 to length(SysBtn) - 1 do begin
    SysBtn[i].free;
  end;
  Button.free;
  Title.free;
  if BGBrush <> 0 then begin
    deleteobject(BgBrush);
    BGBrush := 0;
  end;

  if box <> nil then Box.free;
  if boxlabel <> nil then Boxlabel.free;
  if toolbar <> nil then toolbar.free;
  if Tab <> nil then Tab.free;
  if TabSheet <> nil then TabSheet.free;
  if MinCaption <> nil then MinCaption.free;
  if StatusBar <> nil then statusbar.free;
  if ComBox <> nil then Combox.free;
  if ComBoxborder <> nil then ComBoxborder.free;
  if ComBoxArrow <> nil then ComBoxArrow.free;
  if ExtraImages <> nil then ExtraImages.free;
  if Progress <> nil then Progress.free;
  if ProgressChunk <> nil then ProgressChunk.free;
  if Header <> nil then Header.free;
  if MenuBar <> nil then MenuBar.free;
  if MenuItem <> nil then MenuItem.free;
  if MenuItemBG <> nil then MenuItemBG.free;
  if SArrow <> nil then SArrow.free;
  if HBar <> nil then HBar.free;
  if VBar <> nil then VBar.free;
  if HSlider <> nil then HSlider.free;
  if VSlider <> nil then VSlider.free;
  if Hspin <> nil then Hspin.free;
  if Vspin <> nil then Vspin.free;
  if TrackHorz <> nil then TrackHorz.free;
  if TrackVert <> nil then TrackVert.free;
  if trackbar <> nil then trackbar.free;
  if trackbarvert <> nil then trackbarvert.free;
  if TrackLeft <> nil then TrackLeft.free;
  if TrackRight <> nil then TrackRight.free;
  if TrackTop <> nil then TrackTop.free;
  if TrackBottom <> nil then TrackBottom.free;
  if Toolbarbtn <> nil then toolbarbtn.free;

{  if skinmanager.dlist.count=0 then begin
    skinmanager.free;
    skinmanager:=nil;
  end;}
  inherited Destroy;
end;

procedure TSkinData.SetControlList(Value: TStrings);
begin
  f3rdControls.Assign(Value);
end;

procedure TSkinData.ReadBord;
var
  s: string;
  i: integer;
begin
  for i := 1 to 4 do begin
    if i < 3 then begin
      border[i].r.top := ini.Readinteger('Personality', border[i].IDName + 'TopHeight', 0);
      border[i].r.Bottom := ini.Readinteger('Personality', border[i].IDName + 'BotHeight', 0);
      border[i].r.left := 0;
      border[i].r.right := 0;
    end else begin
      border[i].r.top := 0;
      border[i].r.Bottom := 0;
      border[i].r.left := ini.Readinteger('Personality', border[i].IDName + 'TopHeight', 0);
      border[i].r.right := ini.Readinteger('Personality', border[i].IDName + 'BotHeight', 0);
    end;
    border[i].frame := ini.Readinteger('Personality', border[i].IDName + 'Frame', 1);
    border[i].Tile := ini.Readinteger('Personality', border[i].IDName + 'Stretch', 1);
    border[i].trans := ini.readinteger('Personality', border[i].IDName + 'Trans', 1);
    readbmp(border[i].map, ini.ReadString('Personality', border[i].IDName, ''));
    if border[i].Tile > 1 then border[i].Tile := 1;
//  readbmp(border[i].maskmap,ini.ReadString('Personality', border[i].IDName+'Mask', ''));
  end;

end;

procedure TSkinData.Readbmp(bmp: Tbitmap; fname: string);
var
  s, s1: ansistring;
begin
  s := ExtractFileName(fname);
  s1 := ExtractFileExt(fname);
  if (s <> '') and (s1 = '.bmp') then begin
    reader.readfile(s, ms);
    if ms.size > 0 then
      bmp.LoadFromstream(ms)
    else bmp.Assign(nil);
  end else bmp.Assign(nil);
end;

procedure TSkinData.ReadSysButton;
var
  i, n, a, v1: integer;
  j: real;
  s: string;
  b: boolean;
  p: Tpoint;
begin
  for i := 0 to high(SysBtn) do SysBtn[i].free;
  ini.ReadSections(sectionlist);
  for i := sectionlist.count - 1 downto 0 do begin
    s := Uppercase(sectionlist.strings[i]);
    b := false;
    if (s = 'BUTTONS') or (s = 'BUTTON.RADIO')
      or (s = 'BUTTON.CHECKBOX') or (s = 'BUTTON') then b := true
    else if (pos('BUTTON', s) <> 1) then b := true
    else begin
      a := ini.readinteger(s, 'Action', 0);
      v1 := ini.readinteger(s, 'Visibility', -1);
      if a = -1 then begin
        if v1 = 0 then b := false
        else b := true;
      end;
    end;

    if b then sectionlist.delete(i);
  end;
  n := sectionlist.count;
  setlength(SysBtn, n + 3);
  for i := 0 to sectionlist.count - 1 do begin
    s := Uppercase(sectionlist.strings[i]);
    SysBtn[i] := TDataSkinSysButton.create(s);
    SysBtn[i].Action := ini.readinteger(s, 'Action', 0);
    SysBtn[i].Align := ini.readinteger(s, 'Align', 0);
    SysBtn[i].Xcoord := ini.readinteger(s, 'Xcoord', 0);
    SysBtn[i].Ycoord := ini.readinteger(s, 'Ycoord', 0);
    SysBtn[i].Visibility := ini.readinteger(s, 'Visibility', 0);
    if SysBtn[i].Action = -1 then
      SysBtn[i].Visibility1 := ini.readinteger(s, 'Visibility1', -1)
    else
      SysBtn[i].Visibility1 := ini.readinteger(s, 'Visibility1', 0);

      //save maxbtn;
    if (SysBtn[i].Action = 1) and (SysBtn[i].Visibility = 2) then
      p := Point(SysBtn[i].Xcoord, SysBtn[i].Ycoord);
      // set help btn
    if (SysBtn[i].Action = 4) then begin
      SysBtn[i].Xcoord := p.X;
      SysBtn[i].Ycoord := p.Y;
    end;

    SysBtn[i].CombineOp := ini.readinteger(s, 'CombineOp', -1);
    SysBtn[i].frame := ini.readinteger(s, 'frame', 0);
    readbmp(SysBtn[i].map, ini.ReadString(s, 'ButtonImage', ''));
    if sysbtn[i].frame = 0 then begin
      sysbtn[i].frame := 6;
      if not sysbtn[i].map.empty then begin
        j := sysbtn[i].map.width / sysbtn[i].map.height;
        if j > 3.8 then
          sysbtn[i].frame := 6
        else
          sysbtn[i].frame := 3;
        if sysbtn[i].action < 0 then
          sysbtn[i].frame := 6
      end;
      if sysbtn[i].action in [3, 11] then
        sysbtn[i].map.assign(nil);
    end;
  end;
  for i := n to n + 2 do begin
    SysBtn[i] := TDataSkinSysButton.create(s);
    SysBtn[i].Action := 7 + i - n;
    SysBtn[i].Align := 100;
    SysBtn[i].Visibility := 100;
    SysBtn[i].Visibility1 := 100;
    SysBtn[i].frame := 4;
  end;
  CreateMdibtn(n);
end;

procedure TSkinData.CreateMdibtn(n: integer);
var
  bmp: Tbitmap;
  i, w, h: integer;
  r1, r2: Trect;
begin
  bmp := Tbitmap.create;
  readbmp(bmp, ini.ReadString('MDICONTROLS', 'Image', ''));
  if bmp.empty then begin
    bmp.free;
    exit;
  end;
  w := bmp.width div 12;
  h := bmp.height;
  for i := 0 to 2 do begin
    SysBtn[n + i].map.width := w * 4;
    SysBtn[n + i].map.height := h;
    sysbtn[n + i].Xcoord := (3 - i) * (w + 4);
    r1 := rect(i * 4 * w, 0, (i + 1) * 4 * w, h);
    r2 := rect(0, 0, w * 4, h);
    SysBtn[n + i].map.canvas.copyrect(r2, bmp.canvas, r1);
  end;
  bmp.free;
end;

procedure TSkinData.CreateMinCaption;
var
  i, w, h: integer;
  bmp: Tbitmap;
  c1, c2: TColor;
  c0, gradcol1, gradcol2: Tcolor;
  r: Trect;
  s, v: integer;
begin
  if mincaption = nil then
    mincaption := TDataSkinObject.create('MinCaption');
  bmp := Tbitmap.create;
  h := 29;
  w := 80;
  bmp.Width := w;
  bmp.Height := h;

  c0 := GetCaptionColor();
  gradCol1 := Blend(clblack, c0, 50);
  r := Rect(0, 0, w, h);
  bmp.Canvas.Brush.Color := c0;
  bmp.Canvas.Pen.Color := gradCol1;
  bmp.canvas.Rectangle(r);
   //GradFill(bmp.canvas.handle,r,gradCol2,gradCol1);
  mincaption.map.assign(bmp);
  mincaption.frame := 1;
  mincaption.r := Rect(3, 3, 3, 3);
  bmp.free;
end;

procedure TSkinData.ReadObject(var aobject: TDataSkinObject; aname: string);
var
  s: string;
begin
  if aobject <> nil then begin
    aobject.free;
    aobject := nil;
  end;
  s := ini.readstring(aname, 'Image', '');
  if s = '' then exit;
  aobject := TDataSkinObject.create(aname);

  readbmp(aobject.map, s);
  aobject.style := ini.readinteger(aname, 'Style', 0);
  aobject.r.left := ini.readinteger(aname, 'LeftWidth', 0);
  aobject.r.right := ini.readinteger(aname, 'RightWidth', 0);
  aobject.r.top := ini.readinteger(aname, 'TopHeight', 0);
  aobject.r.Bottom := ini.readinteger(aname, 'BottomHeight', 0);
  aobject.frame := ini.readinteger(aname, 'Frame', 0);
  aobject.trans := ini.readinteger(aname, 'Trans', 0);
  aobject.tile := ini.readinteger(aname, 'Tile', 0);
  aobject.Normalcolor := ini.readinteger(aname, 'NormalColour', -1);
  aobject.Overcolor := ini.readinteger(aname, 'MouseOverColour', -1);
  aobject.Downcolor := ini.readinteger(aname, 'PressedColour', -1);
  aobject.Normalcolor2 := getcolor(ini.readstring(aname, 'NormalColour2', ''), colors[csButtonText]);
  aobject.Overcolor2 := getcolor(ini.readstring(aname, 'MouseOverColour2', ''), colors[csButtonText]);
  aobject.Downcolor2 := getcolor(ini.readstring(aname, 'PressedColour2', ''), colors[csButtonText]);
  if aobject.tile > 1 then aobject.tile := 0;
end;

procedure TSkinData.ReadObject2(var aobject: TDataSkinborder; aname, image2: string);
var
  s: string;
begin
  if aobject <> nil then begin
    aobject.free;
    aobject := nil;
  end;
  s := ini.readstring(aname, 'Image', '');
  if s = '' then exit;
  aobject := TDataSkinborder.create(aname);
  readbmp(aobject.map, s);
  s := ini.readstring(aname, Image2, '');
  if s <> '' then
    readbmp(aobject.maskmap, s);

  aobject.style := ini.readinteger(aname, 'Style', 0);
  aobject.r.left := ini.readinteger(aname, 'LeftWidth', 0);
  aobject.r.right := ini.readinteger(aname, 'RightWidth', 0);
  aobject.r.top := ini.readinteger(aname, 'TopHeight', 0);
  aobject.r.Bottom := ini.readinteger(aname, 'BottomHeight', 0);
  aobject.trans := ini.readinteger(aname, 'Trans', 0);
  aobject.tile := ini.readinteger(aname, 'Tile', 0);
  aobject.Normalcolor := ini.readinteger(aname, 'NormalColour', -1);
  aobject.Overcolor := ini.readinteger(aname, 'MouseOverColour', -1);
  aobject.Downcolor := ini.readinteger(aname, 'PressedColour', -1);
  aobject.Normalcolor2 := getcolor(ini.readstring(aname, 'NormalColour2', ''), colors[csButtonText]);
  aobject.Overcolor2 := getcolor(ini.readstring(aname, 'MouseOverColour2', ''), colors[csButtonText]);
  aobject.Downcolor2 := getcolor(ini.readstring(aname, 'PressedColour2', ''), colors[csButtonText]);
  if aobject.tile > 1 then aobject.tile := 0;
end;

procedure TSkinData.ReadProgress(var aobject: TDataSkinObject; aname: string);
var
  s: string;
begin
  if aobject <> nil then begin
    aobject.free;
    aobject := nil;
  end;
  s := ini.readstring(aname, 'Bitmap', '');
  if s = '' then exit;
  aobject := TDataSkinborder.create(aname);
  readbmp(aobject.map, s);

//     s:=ini.readstring(aname,'Chunk','');
//     if s<>''  then readbmp(aobject.maskmap,s);

  aobject.style := ini.readinteger(aname, 'Style', 0);
  aobject.r.left := ini.readinteger(aname, 'LeftWidth', 0);
  aobject.r.right := ini.readinteger(aname, 'RightWidth', 0);
  aobject.r.top := ini.readinteger(aname, 'TopHeight', 0);
  aobject.r.Bottom := ini.readinteger(aname, 'BottomHeight', 0);
  aobject.trans := ini.readinteger(aname, 'Trans', 0);
  aobject.tile := ini.readinteger(aname, 'Tile', 0);
  if aobject.tile > 1 then aobject.tile := 1;
end;

procedure TSkinData.ReadBoxLabel(var aobject: TDataSkinBoxLabel; aname: string);
var
  s: string;
begin
  if aobject <> nil then begin
    aobject.free;
    aobject := nil;
  end;
  s := ini.readstring(aname, 'Image', '');
  if s = '' then exit;
  aobject := TDataSkinBoxLabel.create(aname);

  readbmp(aobject.map, s);
  aobject.style := ini.readinteger(aname, 'Style', 0);
  aobject.r.left := ini.readinteger(aname, 'LeftWidth', 0);
  aobject.r.right := ini.readinteger(aname, 'RightWidth', 0);
  aobject.r.top := ini.readinteger(aname, 'TopHeight', 0);
  aobject.r.Bottom := ini.readinteger(aname, 'BottomHeight', 0);
  aobject.trans := ini.readinteger(aname, 'Trans', 0);
  aobject.tile := ini.readinteger(aname, 'Tile', 0);
  aobject.Normalcolor := ini.readinteger(aname, 'NormalColour', -1);
  aobject.Overcolor := ini.readinteger(aname, 'MouseOverColour', -1);
  aobject.Downcolor := ini.readinteger(aname, 'PressedColour', -1);
  aobject.Normalcolor2 := getcolor(ini.readstring(aname, 'NormalColour2', ''), colors[csButtonText]);
  aobject.Overcolor2 := getcolor(ini.readstring(aname, 'MouseOverColour2', ''), colors[csButtonText]);
  aobject.Downcolor2 := getcolor(ini.readstring(aname, 'PressedColour2', ''), colors[csButtonText]);
  if aobject.tile > 1 then aobject.tile := 0;

  aobject.Alignment := ini.readinteger(aname, 'BackgroundAlignment', 0);
  aobject.LeftShift := ini.readinteger(aname, 'BackgroundLeftShift', 0);
  aobject.RightShift := ini.readinteger(aname, 'BackgroundRightShift', 0);
end;

procedure TSkinData.ReadButton;
var
  s, s1: string;
begin
  s := 'Buttons';
  Button.r.left := ini.readinteger(s, 'LeftWidth', 0);
  Button.r.right := ini.readinteger(s, 'RightWidth', 0);
  Button.r.top := ini.readinteger(s, 'TopHeight', 0);
  Button.r.Bottom := ini.readinteger(s, 'BottomHeight', 0);
  Button.trans := ini.readinteger(s, 'Trans', 0);
  readbmp(Button.map, ini.readstring(s, 'Bitmap', ''));
  Button.tile := ini.readinteger(s, 'Tile', 0);
  readbmp(Button.checkmap, ini.readstring(s, 'CheckButton', ''));
  readbmp(Button.radiomap, ini.readstring(s, 'RadioButton', ''));
  Button.Normalcolor := ini.readinteger(s, 'NormalColour', -1);
  Button.Overcolor := ini.readinteger(s, 'MouseOverColour', -1);
  Button.Downcolor := ini.readinteger(s, 'PressedColour', -1);
  Button.RadioFrame := ini.readinteger(s, 'RadioButtonFrame', 0);
  Button.CheckFrame := ini.readinteger(s, 'CheckButtonFrame', 0);
  if button.Tile > 1 then button.Tile := 0;

  s1 := ini.readstring(s, 'NormalColour2', '');
  if s1 <> '' then Button.newnormal := true else Button.newnormal := false;
  s1 := ini.readstring(s, 'MouseOverColour2', '');
  if s1 <> '' then Button.newover := true else Button.newover := false;
  s1 := ini.readstring(s, 'PressedColour2', '');
  if s1 <> '' then Button.newdown := true else Button.newdown := false;

  Button.Normalcolor2 := getcolor(ini.readstring(s, 'NormalColour2', ''), colors[csButtonText]);
  Button.Overcolor2 := getcolor(ini.readstring(s, 'MouseOverColour2', ''), colors[csButtonText]);
  Button.Downcolor2 := getcolor(ini.readstring(s, 'PressedColour2', ''), colors[csButtonText]);
end;

procedure TSkinData.ReadMenuBar(var aobject: TDataSkinObject; aname: string);
var
  s: string;
begin
  if aobject <> nil then begin
    aobject.free;
    aobject := nil;
  end;
  s := ini.readstring(aname, 'menuBar', '');
  if s = '' then exit;
  aobject := TDataSkinObject.create(aname);

  readbmp(aobject.map, s);
  aobject.r.top := 0;
  aobject.r.bottom := 0;
  aobject.Tile := ini.readinteger(aname, 'TileMenu', 1);
  aobject.r.left := ini.readinteger(aname, 'TileLeftMenu', 1);
  aobject.r.right := ini.readinteger(aname, 'TileRightMenu', 1);
  if aobject.Tile > 1 then aobject.Tile := 1;
//     aobject.r.top:=ini.readinteger(aname,'TopHeight',0);
//     aobject.r.Bottom:=ini.readinteger(aname,'BottomHeight',0);
//     aobject.Tile:=ini.readinteger(aname,'Tile',0);
end;

procedure TSkinData.ReadTitle(aobject: TDataSkinObject; aname: string);
var
  s: string;
begin
  readbmp(aobject.map, ini.readstring(aname, 'TextBack', ''));
  aobject.r.left := ini.readinteger(aname, 'TextShift', 0);
  aobject.r.top := ini.readinteger(aname, 'TextShiftVert', 0);
  aobject.r.right := ini.readinteger(aname, 'TextRightClip', 0);
  aobject.r.bottom := 0;
  Title.aligment := ini.readinteger(aname, 'TextAlignment', 0);
  Title.Background := ini.readinteger(aname, 'Textbackground', 0);
  Title.FontHeight := ini.readinteger('Fonts', 'FontHeight', 14);
  Title.BackLeft := ini.readinteger(aname, 'TXTBackleft', 0);
  Title.BackRight := ini.readinteger(aname, 'TXTBackRight', 0);
  Title.activetext := clnone;
  Title.inactivetext := clnone;
  ReadRGB(aname, 'ActiveText', Title.activetext);
  ReadRGB(aname, 'InActiveText', Title.inactivetext);
end;

{procedure TSkinData.RebuildToolbar;
var bmp:Tbitmap;
    w,i,h : integer;
    r1,r2:Trect;
begin
   if toolbar<>nil then exit;
   if statusbar=nil then exit;
   bmp :=Tbitmap.create;
   w:=statusbar.map.width div statusbar.frame;
   bmp.Width := w - statusbar.r.Left-statusbar.r.Right;
   h:=statusbar.Map.Height;
   bmp.Height := h-statusbar.r.Top;
   r1:=Rect(statusbar.r.Left,statusbar.r.Top,w-statusbar.r.Right,bmp.Height);
   r2:=Rect(0,0,bmp.Width,bmp.Height);
   bmp.Canvas.CopyRect(r2,statusbar.Map.canvas,r1);
   toolbar:=TDataSkinObject.create('Toolbar');
   toolbar.Map.Assign(bmp);
   toolbar.r.Bottom:=statusbar.r.Bottom;
   toolbar.frame:=1;
   bmp.free;
end;}

procedure TSkinData.RebuildToolbar;
var
  bmp: Tbitmap;
  c0, gradcol1, gradcol2: Tcolor;
  r: Trect;
  s, v: integer;
begin
  bmp := Tbitmap.create;
  bmp.Width := 10;
  bmp.Height := 40;

  c0 := GetCaptionColor();
  gradCol1 := Blend(clgray, c0, 150);
  gradCol2 := Blend(colors[csButtonFace], clwhite, 150);
  s := GetHSV(c0);
  if s > 110 then begin
    v := 50 + 25 * (225 - s) div 140;
    gradCol1 := Blend(c0, clwhite, v);
  end;

  r := Rect(0, 0, bmp.Width, bmp.Height);
  GradFill(bmp.canvas.handle, r, gradCol2, gradCol1);
  if toolbar = nil then
    toolbar := TDataSkinObject.create('Toolbar');
  toolbar.Map.Assign(bmp);
  toolbar.frame := 1;
  bmp.free;
end;

procedure TSkinData.CreateCaptionFont;
var
  NonClientMetrics: TNonClientMetrics;
begin
  if Assigned(CaptionFont) then FreeAndNIL(CaptionFont);
  CaptionFont := TFont.Create;
  NonClientMetrics.cbSize := SizeOf(NonClientMetrics);
  if SystemParametersInfo(SPI_GETNONCLIENTMETRICS, 0, @NonClientMetrics, 0) then
    CaptionFont.Handle := CreateFontIndirect(NonClientMetrics.lfCaptionFont);
end;

procedure TSkinData.CreateLogo;
var
  s: string;
  r: Trect;
  font: Tfont;
begin
  s := 'VCLSkin Demo';
  font := Tfont.Create;
  font.Name := 'Tahoma MS';
  font.Size := 10;
  font.Style := [fsBold];
//   logo.Transparent:=true;
//   logo.TransparentColor:=clwhite;//clFuchsia;
  logo.Canvas.Font := font; //captionfont;
  r := Rect(0, 0, 50, 30);
  DrawTextA(logo.canvas.Handle, pchar(s), -1, r, DT_CALCRECT or DT_NOCLIP);
  if (r.Right < 150) and (r.Bottom < 20) then begin
    logo.Width := r.Right + 2;
    logo.Height := r.Bottom + 2;
    logo.canvas.Brush.color := clwhite; //clFuchsia;
    logo.Canvas.Rectangle(rect(0, 0, r.Right + 2, r.Bottom + 2));
//   logo.Canvas.FillRect(rect(0,0,logo.width,logo.Height));
    SetBkMode(logo.Canvas.Handle, TRANSPARENT);
    offsetrect(r, 1, 1);
    DrawText(logo.canvas.Handle, pchar(s), -1, r, 0);
  end;
  font.free;
end;

procedure TSkinData.ReBuildComboxArrow;
var
  bmp: Tbitmap;
  i, cw, w: integer;
  r1, r2: Trect;
begin
  if comboxarrow = nil then
    comboxarrow := TDataSkinObject.create('ComboxArrow');

  if (Comboxborder = nil) then begin
    if (combox <> nil) then begin
      comboxarrow.Map.Assign(combox.Map);
      ChangeTrans(comboxarrow.Map, colors[csButtonface]);
      comboxarrow.frame := combox.frame;
    end;
    exit;
  end;
  if (combox.style <> 2) then exit;

  cw := 17;
  bmp := Tbitmap.create;
  bmp.Height := cw;
  bmp.Width := cw * ComBoxborder.frame;
  w := combox.map.width div ComBoxborder.frame;

  for i := 1 to ComBoxborder.frame do begin
    r1 := Rect(i * w - 2 - cw, 2, i * w - 2, 19);
    r2 := rect((i - 1) * cw, 0, i * cw, cw);
    bmp.Canvas.CopyRect(r2, combox.map.Canvas, r1);
  end;

  comboxarrow.frame := ComBoxborder.frame;
  comboxarrow.Map.Assign(bmp);
  bmp.free;
end;

procedure TSkinData.ReBuildCombobox;
var
  temp, bmp: Tbitmap;
  w1, i, h: integer;
  r1, r2: Trect;
begin
  if (Comboxborder = nil) or (combox = nil) then exit;

  bmp := Tbitmap.create;
  temp := Tbitmap.create;
  temp.Height := 21;
  temp.Width := 50;
  bmp.height := temp.Height;
  bmp.Width := temp.Width * ComBoxborder.frame;
  bmp.PixelFormat := pf24Bit;
  temp.Canvas.Brush.color := clFuchsia;
  bmp.Canvas.Brush.color := clFuchsia;
  bmp.canvas.FillRect(rect(0, 0, bmp.width, bmp.height));

  w1 := GetSystemMetrics(SM_CXHSCROLL) + 2;

  h := 21;
  r1 := rect(0, 0, 50, h);
  r2 := r1;
  r2.left := r1.right - w1;

  for i := 1 to ComBoxborder.frame do begin
    DrawRect2(temp.canvas.Handle, r1, ComBoxborder.map, ComBoxborder.r,
      i, ComBoxborder.frame, ComBoxborder.trans);

    DrawRect2(temp.canvas.Handle, r2, ComBox.map, ComBox.r,
      i, ComBox.frame, 1);
    if ExtraImages <> nil then
      DrawRect3(temp.canvas.Handle, r2, ExtraImages.map,
        i, ExtraImages.frame, 1);
    temp.canvas.FillRect(rect(2, 2, 50 - w1 - 1, h - 3));
    bmp.canvas.draw((i - 1) * 50, 0, temp);
  end;
  combox.style := 2;
  combox.r := comboxborder.r;
  combox.r.right := w1 + 2;
  combox.r.left := 2;
  combox.Map.Assign(bmp);
//  copybmp(bmp,combox.Map);//combox.Map.Assign(bmp);

  SpiegelnHorizontal(bmp);
  //copybmp(bmp,comboxborder.Map);
  ComBoxborder.Map.Assign(bmp);
  ComBoxborder.r.left := w1 + 2;
  ComBoxborder.r.right := 2;

  bmp.free;
  temp.free;
end;

procedure TSkinData.ReadTrack(var aobject: TDataSkinObject; aname: string);
begin
  if aobject <> nil then begin
    aobject.free;
    aobject := nil;
  end;
  aobject := TDataSkinObject.create(aname);
  aobject.Map.LoadFromResourceName(hinstance, aname);
  aobject.r := Rect(3, 3, 3, 3);
  aobject.Tile := 0;
  aobject.frame := 1;
end;

function StrToWideStr(const S: AnsiString): WideString;
var
  InputLength,
    OutputLength: Integer;
begin
  InputLength := Length(S);
  OutputLength := MultiByteToWideChar(DefaultUserCodePage, 0, PAnsiChar(S), InputLength, nil, 0);
  SetLength(Result, OutputLength);
  MultiByteToWideChar(DefaultUserCodePage, 0, PAnsiChar(S), InputLength, PWideChar(Result), OutputLength);
end;

function WideStringToStringEx(const WS: WideString): AnsiString;
var
  InputLength,
    OutputLength: Integer;
begin
  InputLength := Length(WS);
  OutputLength := WideCharToMultiByte(DefaultUserCodePage, 0, PWideChar(WS), InputLength, nil, 0, nil, nil);
  SetLength(Result, OutputLength);
  WideCharToMultiByte(DefaultUserCodePage, 0, PWideChar(WS), InputLength, PAnsiChar(Result), OutputLength, nil, nil);
end;

function _WStr(lpString: PWideChar; cchCount: Integer): WideString;
begin
  if cchCount = -1 then
    Result := lpString
  else
    Result := Copy(WideString(lpString), 1, cchCount);
end;

function Tnt_DrawTextW(hDC: HDC; wString: WideString; var lpRect: TRect; uFormat: UINT): Integer;

var
  lpString: PWideChar;
  ncount: integer;
begin
  lpstring := PWideChar(wstring);
  ncount := length(wstring);
  if Win32PlatformIsUnicode then
    Result := DrawTextW(hDC, lpString, nCount, lpRect, uFormat)
  else
    Result := DrawTextA(hDC,
      PAnsiChar(AnsiString(_WStr(lpString, nCount))), -1, lpRect, uFormat);
end;

function RGBToColor(R, G, B: Byte): TColor;
begin
  Result := B shl 16 or
    G shl 8 or
    R;
end;

{procedure CopyBMP(sbmp,dbmp:TBitMap);
begin
    dbmp.Width:=sbmp.Width;
    dbmp.Height:=sbmp.Height;
    dbmp.PixelFormat:=sbmp.PixelFormat;
    dbmp.Canvas.Draw(0,0,sbmp);
end;}

function strcolor(s: string): Tcolor;
var
  i, j, l, n: integer;
  a: array[1..3] of integer;
  s2: string;
begin
  result := 0;
  if s = '' then exit;
  s := trim(s);
  l := length(s);
  for i := 1 to 3 do a[i] := 0;
  j := 1;
  i := 1;
  s2 := '';
  while (i <= l) do begin
    if s[i] in ['0'..'9'] then s2 := s2 + s[i]
    else begin
      try
        if s2 <> '' then begin
          a[j] := strtoint(s2);
          inc(j);
          s2 := '';
        end;
      except
      end;
        //inc(j);s2:='';
    end;
    inc(i);
  end;
  try
    if j = 3 then a[3] := strtoint(s2);
  except
  end;
  result := rgb(a[1], a[2], a[3]);
end;

function FindControlx(Handle: HWnd): TWinControl;
begin
  Result := nil;
  if Handle <> 0 then begin
{$IFDEF COMPILER_6_UP}
    result := pointer(SendMessage(handle, RM_GetObjectInstance, 0, 0));
{$ELSE}
    Result := Pointer(GetProp(Handle, MakeIntAtom(ControlAtom)));
{$ENDIF}
  end;
end;

function TSkinData.GetColor(const s1: string; acolor: Tcolor): Tcolor;
begin
  result := acolor;
  if s1 <> '' then result := strcolor(s1);
end;

procedure TSkinData.ReadColor2(item: TShemeColor; key: string; cdefault: Tcolor);
var
  s: string;
begin
  s := ini.readstring('Colours', key, '');
  if (s = '') then begin
    hasColors[item] := false;
    Colors[item] := cdefault;
  end else begin
    hasColors[item] := true;
    Colors[item] := strcolor(s);
  end;
end;

procedure TSkinData.ReadColor;
var
  s, s1: string;
  n, i: integer;
  b, r, g: byte;
begin
//  TShemeColor=(csText,csTitleTextActive,csTitleTextNoActive,
//         csButtonFace,csSelectText,csSelectBg,csTextDisable);
  s := 'Colours';
  s1 := ini.readstring(s, 'ButtonFace', '');

  readcolor2(csText, 'WindowText', clWindowText);
  readcolor2(csButtonFace, 'ButtonFace', clBtnFace);
  readcolor2(csScrollbar, 'Scrollbar', clscrollbar);
  readcolor2(csHilightText, 'HilightText', clHighlightText);
  readcolor2(csHilight, 'Hilight', clHighlight);
  readcolor2(csMenuBar, 'Menubar', colors[csButtonFace]);
  readcolor2(csMenuBG, 'Menu', clMenu);
  readcolor2(csMenuText, 'MenuText', clMenuText);
  readcolor2(csButtonText, 'ButtonText', clBtnText);
  readcolor2(csButtonHilight, 'ButtonHilight', clBtnHighlight);
  readcolor2(csButtonlight, 'Buttonlight', clBtnHighlight);
  readcolor2(csButtonShadow, 'ButtonShadow', clBtnShadow);
  readcolor2(csButtonDkShadow, 'ButtonDkShadow', cl3DDkShadow);
  readcolor2(csMenuBarText, 'MenuBarText', clMenuText);
  readcolor2(csTitleTextActive, 'TitleTextActive', clcaptionText);
  readcolor2(csTitleTextNoActive, 'TitleTextNoActive', clinactivecaptionText);

{   colors[csText]:=getcolor(ini.readstring(s,'WindowText',''),clWindowText);
   colors[csButtonFace]:=getcolor(ini.readstring(s,'ButtonFace',''),clBtnFace);
   colors[csScrollbar]:=getcolor(ini.readstring(s,'Scrollbar',''),clscrollbar);
   colors[csHilightText]:=getcolor(ini.readstring(s,'HilightText',''),clHighlightText);
   colors[csHilight]:=getcolor(ini.readstring(s,'Hilight',''),clHighlight);
   colors[csMenuBar]:=getcolor(ini.readstring(s,'Menubar',''),colors[csButtonFace]);
   colors[csMenuBG]:=getcolor(ini.readstring(s,'Menu',''),clMenu);
   colors[csMenuText]:=getcolor(ini.readstring(s,'MenuText',''),clMenuText);
   colors[csButtonText]:=getcolor(ini.readstring(s,'ButtonText',''),clBtnText);
   colors[csButtonHilight]:=getcolor(ini.readstring(s,'ButtonHilight',''),clBtnHighlight);
   colors[csButtonlight]:=getcolor(ini.readstring(s,'Buttonlight',''),clBtnHighlight);
   colors[csButtonShadow]:=getcolor(ini.readstring(s,'ButtonShadow',''),clBtnShadow);
   colors[csButtonDkShadow]:=getcolor(ini.readstring(s,'ButtonDkShadow',''),cl3DDkShadow);
   colors[csMenuBarText]:=getcolor(ini.readstring(s,'MenuBarText',''),clMenuText);
   colors[csTitleTextActive]:=getcolor(ini.readstring(s,'TitleTextActive',''),clcaptionText);
   colors[csTitleTextNoActive]:=getcolor(ini.readstring(s,'TitleTextNoActive',''),clinactivecaptionText);}

  ini.ReadSections(sectionlist);
  for i := sectionlist.count - 1 downto 0 do begin
    s := Uppercase(sectionlist.strings[i]);
    if (s = 'COLOURS') or (pos('COLOUR', s) <> 1) then
      sectionlist.delete(i);
  end;
  n := sectionlist.count;
  setlength(colorPreset, n);
  for i := 0 to n - 1 do begin
    s := Uppercase(sectionlist.strings[i]);
    colorPreset[i] := getcolor(ini.readstring(s, 'color', ''), clWindowText);
  end;

//   setlength(colorPreset,10);
  for i := 0 to high(PresetColors) do begin
    PresetColors[i] := getcolor(ini.readstring('Customcolors', 'Color' + inttostr(i), ''), clwhite);
  end;
{//  TShemeColor=(csText,csTitleTextActive,csTitleTextNoActive,
//   ReadRGB('Personality','MenuText',colors[csMenuBarText]);
//   ReadRGB('Personality','ActiveText',colors[csTitleTextActive]);
//   ReadRGB('Personality','InactiveText',colors[csTitleTextNoActive]);

   n:=getsectionnum('Colour','B');
   setlength(colorPreset,n);
   for i:=0 to n-1 do begin
     r:=ini.readinteger(format('Colour%1d',[i]),'R',0);
     g:=ini.readinteger(format('Colour%1d',[i]),'G',0);
     b:=ini.readinteger(format('Colour%1d',[i]),'B',0);
     colorPreset[i]:=rgbtocolor(r,g,b);
   end;}
end;

procedure TSkinData.ReadRGB(Section, aname: string; var value: Tcolor);
var
  a: array[1..3] of integer;
  R: array[1..3] of string;
  i: integer;
begin
  R[1] := 'R';
  R[2] := 'G';
  R[3] := 'B';
  for i := 1 to 3 do begin
    a[i] := ini.readinteger(section, aname + r[i], -1);
  end;
  if (a[1] >= 0) and (a[2] >= 0) and (a[3] >= 0) then
    value := rgb(a[1], a[2], a[3]);
//    value:=RGBToColor(a[1],a[2],a[3]);
end;

function TSkinData.GetSectionNum(asection, aname: string): integer;
var
  i: integer;
  s: string;
begin
  i := 0;
  s := ini.readstring(format('%s%1d', [asection, i]), aname, '');
  while s <> '' do begin
    inc(i);
    s := ini.readstring(format('%s%1d', [asection, i]), aname, '');
  end;
  result := i;
end;

procedure TSkinData.Uninstall;
begin
  SkinManager.setaction(skin_Uninstall);
end;

procedure TSkinData.Install;
begin
  SkinManager.setaction(skin_Active);
end;

procedure TSkinData.DoFormSkin(ahwnd: Thandle; aname: string; var Doskin: boolean);
begin
  formhwnd := ahwnd;
  if assigned(fOnformskin) then fOnformskin(self, aname, doskin)
//    else if aname='TQRStandardPreview' then doskin:=false
  else if aname = 'SysMonthCal32' then doskin := false
//    else if aname='TppPrintPreview' then doskin:=false
//    else if aname='TdxfmStdPreview' then doskin:=false
  else if (xcFastReport in SkinControls) and (pos('Tfr', aname) = 1) then doskin := false;
end;

procedure TSkinData.DoSkinChanged;
begin
  if assigned(fOnSkinChanged) then
    fOnSkinChanged(self);
end;

procedure TSkinData.AddNestForm(fParent, fNested: TWincontrol);
var
  i: integer;
  sf: TWinSkinform;
  spy: TWinSkinspy;
begin
  if fNested = nil then exit;
  for i := 0 to SkinManager.flist.count - 1 do begin
    sf := TWinSkinform(SkinManager.flist[i]);
    if sf.hwnd = fParent.handle then begin
      spy := TWinSkinspy.Create(fNested);
      spy.sf := sf;
//         sf.InitControls(fparent);
      sf.InitNestform(Tform(fNested));
      break;
    end;
  end;
end;

procedure TSkinData.UpdateSkinControl(fParent: Tform; acontrol: Twincontrol = nil);
var
  i: integer;
  sf: TWinSkinform;
begin
  for i := 0 to SkinManager.flist.count - 1 do begin
    sf := TWinSkinform(SkinManager.flist[i]);
    if sf.hwnd = fParent.handle then begin
      if acontrol = nil then sf.InitControls(fparent)
      else sf.InitControls(acontrol);
      break;
    end;
  end;
end;

procedure TSkinData.ChangeForm(aform: Tform);
begin
//   postmessage(skinmanager.handle,CN_SkinNotify,skin_update,aform.handle);
  skinmanager.lpara := aform.handle;
  skinmanager.UpdateData := self;
  skinmanager.setaction(skin_update);
end;

procedure TSkinData.DoDebug(s: string);
begin
  if debuglist <> nil then
    debuglist.Add(s);
end;

procedure TSkinData.ActivateHint(aRect: TRect; const AHint: string);
var
  r: Trect;
begin
  if not (xoCaptionButtonHint in fskinoptions) then exit;
  if hashint then Exit;
  r := fhintwindow.CalcHintRect(500, AHint, nil);
  OffsetRect(r, aRect.Left, aRect.Top);
  fhintwindow.ActivateHint(r, AHint);
  hashint := true;
//  DoDebug('hint show :'+inttostr(hintcount ));
end;

function TSkinData.IsHint: Boolean;
begin
  result := hashint;
end;

procedure TSkinData.HideHint;
begin
  if hashint then begin
    ShowWindow(fhintwindow.Handle, SW_HIDE);
    hashint := false;
//    DoDebug('hint hide :'+inttostr(hintcount ));
  end;
end;

procedure TSkinData.EnableSkin(b: boolean);
begin
  skinmanager.active := b;
end;

procedure TSkinData.DeleteGraphicControl(fParent: Tform; acontrol: TGraphicControl);
var
  i, j: integer;
  sf: TWinSkinform;
  sc: Tskincontrol;
begin
  for i := 0 to SkinManager.flist.count - 1 do begin
    sf := TWinSkinform(SkinManager.flist[i]);
    if sf.hwnd = fParent.handle then begin
      for j := 0 to sf.controllist.count - 1 do begin
        sc := Tskincontrol(sf.controllist.items[j]);
        if sc.GControl = acontrol then begin
          sf.controllist.Delete(j);
          sc.free;
          break;
        end;
      end;
    end;
  end;
end;

procedure TSkinData.SkinForm(ahwnd: THandle);
begin
  SkinManager.skinchildform := true;
  SkinManager.addform(ahwnd);
  SkinManager.skinchildform := false;
end;

procedure TSkinData.UpdateMenu(fParent: Tform);
var
  i: integer;
  sf: TWinSkinform;
begin
  for i := 0 to SkinManager.flist.count - 1 do begin
    sf := TWinSkinform(SkinManager.flist[i]);
    if sf.hwnd = fParent.handle then begin
      sf.InitPopMenu(fParent, true, true);
      break;
    end;
  end;
end;

procedure TSkinData.UpdateMainMenu(done: boolean);
var
  i: integer;
  sf: TWinSkinform;
begin
  menumsg := done;
  if not menumsg then exit;
  for i := 0 to SkinManager.flist.count - 1 do begin
    sf := TWinSkinform(SkinManager.flist[i]);
    if (sf.menu <> nil) then begin
      sf.menu.updatabtn;
         //break;
    end;
  end;
end;

procedure TSkinData.InstallThread(aThreadID: integer);
begin
  skinmanager.installthread(athreadid);
end;

procedure TSkinData.UnInstallThread(aThreadID: integer);
begin
  SkinManager.UnInstallThread(aThreadID);
end;

procedure TSkinData.LoadFromFile(value: string);
begin
  empty := true;
  fskinfile := value;
  if (csDesigning in ComponentState) then begin
    if (value <> '') and (data.size > 0) then data.clear;
    Exit;
  end;

  if not fileexists(value) then exit;
  data.clear;
  data.loadfromfile(value);
  LoadSkin;
//   skinmanager.setaction(skin_change);
//   if ftype=sfMainform then
  UpdateSkin;
//   else showmessage('Skin file format error !');
end;

procedure TSkinData.LoadFromStream(Stream: TStream);
begin
  empty := true;
  data.clear;
  data.LoadFromStream(stream);
  LoadSkin;
  if ftype = sfMainform then
    UpdateSkin;
//   skinmanager.setaction(skin_change);
end;

procedure TSkinData.LoadFromCollection(astore: TSkinStore; aindex: integer);
var
  aitem: TSkinCollectionItem;
begin
  if astore.Store.count <= aindex then exit;
  empty := true;
  data.clear;
  aitem := TSkinCollectionItem(astore.Store.items[aindex]);
  aitem.fdata.Position := 0;
  data.LoadFromStream(aitem.fdata);
  LoadSkin;
//   if ftype=sfMainform then
  UpdateSkin;
end;

function TSkinData.LoadSkin: boolean;
var
  fpath, fini: string;
  PathBuffer: array[0..255] of char;
  b: boolean;
begin
  empty := true;
  if csDesigning in ComponentState then exit;
  GetTempPath(256, PathBuffer);
  fpath := StrPas(PathBuffer);
  reader := TSkinReader.create;
  ms := TMemorystream.create;
  b := reader.loadfromstream(data);
  if b then begin
    ini := TQuickIni.Create;
    reader.readini('.ini', ms, fini);
    fini := fpath + fini;
    try
      ms.Seek(0, soFromBeginning);
      ini.LoadFromStream(ms);
//        ms.savetofile(fini);
      loadfromini(fini);
//        deletefile(fini);
    finally
      reader.free;
      ms.free;
      ini.free;
    end;
  end;
  result := b;
end;

procedure TSkinData.LoadFromIni(filename: string);
begin

//  ini := TIniFile.Create(FileName);
  sectionlist := Tstringlist.create;

  ini.ReadSections(sectionlist);
  //
  SkinName := ini.ReadString('TitlebarSkin', 'SkinName', '');
  //
  Readbord;
  readcolor;
  ReadSysbutton;
  Readbutton;
  readtitle(Title, 'Personality');
  readProgress(Progress, 'Progress');
  readobject(ProgressChunk, 'Progress.Chunk');
  readMenuBar(MenuBar, 'Personality');
  readobject(Box, 'GroupBoxEdge');
  ReadBoxLabel(boxlabel, 'GroupBox');
  readobject2(Tab, 'Tabs', 'Border');
  readobject(StatusBar, 'StatusBarEdges');
  readobject(TabSheet, 'Tab.Pane');
  if (tabsheet <> nil) then begin
    if (tabsheet.r.top > 4) then tabsheet.r.top := 4;
    if (tabsheet.r.left > 4) then tabsheet.r.left := 4;
    if (tabsheet.r.right > 4) then tabsheet.r.right := 4;
    if (tabsheet.r.bottom > 4) then tabsheet.r.bottom := 4;
  end;
  //Readobject(toolbar,'ToolBarBackground');
  Readobject(toolbarbtn, 'ToolBars');
//  ReadToolbar(Toolbar,'Toolbars');
//  readobject(ComBox,'ComboButton');
  readobject2(ComBox, 'ComboButton', '****');
  readobject(ComBoxborder, 'SunkEdge');
  if (combox <> nil) and (not combox.Map.empty) then begin
    combox.MaskMap.assign(combox.Map);
    combox.MaskMap.PixelFormat := pf24bit;
    SpiegelnHorizontal(combox.MaskMap);
  end;
  readobject(ExtraImages, 'ExtraImages');
  readobject(header, 'Headerbar');

  readObject(MenuItem, 'MenuItem');
  readObject(MenuItemBG, 'MenuBackground');
  readobject(SArrow, 'Scrollbar');
  readobject(HBar, 'HorzScroll');
  readobject(VBar, 'VertScroll');
  readobject(HSlider, 'HorzScrollThumb');
  readobject(VSlider, 'VertScrollThumb');

  readobject(TrackHorz, 'Trackbar.ThumbHorz');
  readobject(TrackVert, 'Trackbar.ThumbVert');
  readobject(TrackLeft, 'Trackbar.ThumbLeft');
  readobject(TrackRight, 'Trackbar.ThumbRight');
  readobject(TrackTop, 'Trackbar.ThumbUp');
  readobject(TrackBottom, 'Trackbar.ThumbDown');

  readobject2(HSpin, 'UpDown.Horz', 'GlyphImage');
  readobject2(VSpin, 'UpDown.Vert', 'GlyphImage');

  readobject(TrackBar, 'Track');
  readobject(Trackbarvert, 'TRACKVERT');

  if trackbar = nil then
    ReadTrack(Trackbar, 'TRACK');
  if trackbarvert = nil then
    ReadTrack(Trackbarvert, 'TRACKVERT');

  SetFrame;
  ReBuildCombobox;
  ReBuildComboxArrow;
  RebuildToolbar;
  colors[csCaption] := GetCaptionColor;
  if BGBrush <> 0 then begin
    deleteobject(BgBrush);
    BGBrush := 0;
  end;
  BGBrush := CreateSolidBrush(colors[csButtonFace]);

  sectionlist.free;
  Empty := False;
end;

procedure TSkinData.SetFrame;
var
  i: integer;
  w: integer;
begin
//  ReadSysbutton;
//  Readbutton;
  button.frame := 5;
  if button.radioframe = 0 then begin
    if button.radiomap.height >= 16 then w := 16
    else w := 13;
    button.radioframe := button.radiomap.width div w;
    if button.radioframe < 4 then button.radioframe := 4;
  end;

  if button.checkframe = 0 then begin
    if button.checkmap.height >= 16 then w := 16
    else w := 13;
    button.checkframe := button.checkmap.width div w;
    if button.checkframe < 4 then button.checkframe := 4;
  end;
//  for i:= 0 to length(sysbtn)-1 do
//      sysbtn[i].frame:=5;
  if title <> nil then Title.frame := 2;
  if Progress <> nil then begin
    if progress.style = 0 then
      Progress.frame := 2
    else
      Progress.frame := 1;
  end;
  if MenuBar <> nil then MenuBar.frame := 2;
  if Box <> nil then Box.frame := 2;
  if Toolbar <> nil then Toolbar.frame := 1;
  if Toolbarbtn <> nil then toolbarbtn.frame := 5;
  if Tab <> nil then Tab.frame := 5;
  if TabSheet <> nil then TabSheet.frame := 1;
//  if MinCaption<>nil then MinCaption.frame:=1;
  if StatusBar <> nil then StatusBar.frame := 3;
  if BoxLabel <> nil then BoxLabel.frame := 1;
  if ComBox <> nil then ComBox.frame := 4;
  if ComBoxborder <> nil then ComBoxborder.frame := 4;
  if ExtraImages <> nil then ExtraImages.frame := 5;
  if (header <> nil) and (header.frame = 0) then header.frame := 5;

  if MenuItem <> nil then MenuItem.frame := 5;
  if MenuItemBG <> nil then MenuItemBG.frame := 1;
  if SArrow <> nil then SArrow.frame := 23;
  if HBar <> nil then Hbar.frame := 4;
  if VBar <> nil then Vbar.frame := 4;
  if VSpin <> nil then VSpin.frame := 8;
  if HSpin <> nil then HSpin.frame := 8;
  if TrackHorz <> nil then TrackHorz.frame := 5;
  if TrackVert <> nil then TrackVert.frame := 5;
  if TrackLeft <> nil then TrackLeft.frame := 5;
  if TrackRight <> nil then TrackRight.frame := 5;
  if TrackTop <> nil then TrackTop.frame := 5;
  if TrackBottom <> nil then TrackBottom.frame := 5;
  if hslider <> nil then
    HSlider.frame := ini.readinteger('HorzScrollThumb', 'FrameCount', 3);
  if vslider <> nil then
    VSlider.frame := ini.readinteger('VertScrollThumb', 'FrameCount', 3);
end;

function TSkinData.GetPrecolor(var acolor: Tcolor; n: integer): boolean;
begin
  result := false;
  if (n > -1) and (n < length(colorpreset)) then begin
    acolor := colorpreset[n];
    result := true;
  end;
end;

function TSkinData.getfilename(s: string): string;
var
  i: integer;
begin
  i := pos('.', s);
  if i > 0 then result := copy(s, 1, i - 1)
  else result := '';
end;

procedure TSkinData.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineBinaryProperty('SkinStream', ReadData, WriteData, True);
end;

procedure TSkinData.ReadData(Stream: TStream);
var
  ASize: longint;
begin
  Stream.Read(ASize, sizeof(ASize));
  if ASize > 0 then begin
    data.SetSize(ASize);
    Stream.Read(data.Memory^, ASize);
    if not (csDesigning in ComponentState) then begin
      LoadSkin;
    end;
  end;
end;

procedure TSkinData.WriteData(Stream: TStream);
var
  ASize: longint;
begin
  ASize := data.Size;
  Stream.Write(ASize, sizeof(ASize));
  if ASize > 0 then
    Stream.Write(data.Memory^, ASize);
end;

function TSkinData.GetSkinStore: string;
begin
  Result := '(none)';

  if csDesigning in ComponentState then
  begin
    if (data.size > 0) then
      Result := '(Good)';
  end;
end;

procedure TSkinData.SetSkinStore(const Value: string);
begin
end;

procedure TSkinData.SetVersion(Value: string);
begin
end;

procedure TSkinData.Loaded;
begin
  inherited;
  if (csDesigning in ComponentState) then exit;

  if (@pGetScrollBarInfo = nil) then
    skincontrols := skincontrols - [xcScrollbar];

  if skinmanager = nil then
    SkinManager := TSkinManage.create(0);
//   skinmanager.addskindata(self);

  skinmanager.addskindata(self);
  CreateCaptionFont;
  CreateLogo;

  if ftype = sfMainform then begin
    skinmanager.installhook;
    if factive then begin
      if not empty then begin
        skinmanager.setaction(skin_Active);
      end else
        factive := false;
    end;
    if not (xcMainmenu in SkinControls) then
      skincontrols := skincontrols - [xcSystemMenu]
    else
      skincontrols := skincontrols - [xcMenuitem];
    GetAppIcon();
  end
  else begin
    skinmanager.active := true;
    inc(skinmanager.state);
    if (owner is Tform) and factive then
      skinmanager.addform(tform(owner).handle);
  end;
end;

procedure TSkinData.SetActive(Value: boolean);
begin
  if factive <> value then begin
    factive := value;
    if (csDesigning in ComponentState) then exit;
    if (csReading in ComponentState) then exit;
//     if (skinformtype=sfMainform) or (skinformtype=sfDllForm) then begin
    if (skinformtype = sfMainform) then begin
      if value then begin
        if not empty then begin
          skinmanager.updatedata := self;
          skinmanager.setaction(skin_Active);
          skinmanager.state := skin_Active;
//             skinmanager.updatedata:=self;
        end;
      end else begin
        skinmanager.updatedata := self;
        skinmanager.setaction(skin_uninstall);
//        skinmanager.updatedata:=self;
      end;
    end else if (skinformtype = sfOnlyThisForm) then begin
      skinmanager.updatedata := self;
      if value then begin
        if not empty then
          skinmanager.setaction(skin_Active);
      end else begin
        skinmanager.setaction(skin_uninstall);
      end;
    end;
  end;
end;

procedure TSkinData.UpdateSkin;
begin
  if (csDesigning in ComponentState) then exit;
  if (csReading in ComponentState) then exit;
  if skinmanager = nil then loaded;
//    if skinformtype<>sfMainform then  exit;
//    if SkinFormtype = sfOnlyThisForm then begin
//        exit;
//    end;
  skinmanager.updatedata := self;
  skinmanager.DeleteSysbtn;
  if skinmanager.state = skin_Active then
    skinmanager.setaction(skin_change);
end;

procedure TSkinData.ChangeProperty(control: TObject; aprop, value: string);
var
  PropInfo: PPropInfo;
begin
  if control <> nil then begin
    PropInfo := GetPropInfo(control, aprop);
    if PropInfo <> nil then begin
      if propinfo^.PropType^.Kind = tkEnumeration then
        SetEnumProp(control, PropInfo, value);
    end;
  end;
end;

procedure TSkinData.GetAppIcon;
var
  deficon, SmallIcon: HIcon;
  cx, cy, i: Integer;
  Temp: Tbitmap;
begin
  Temp := Tbitmap.create;
  cx := GetSystemMetrics(SM_CXSMICON);
  cy := GetSystemMetrics(SM_CYSMICON);
  temp.canvas.brush.color := clFuchsia;
  temp.width := cx;
  temp.height := cy;
  DefIcon := SendMessage(application.Handle, WM_GETICON, ICON_SMALL, 0);
  if DefIcon = 0 then
    DefIcon := SendMessage(application.Handle, WM_GETICON, ICON_BIG, 0);

  if DefIcon <> 0 then begin
    SmallIcon := CopyImage(DefIcon, IMAGE_ICON, cx, cy, LR_COPYFROMRESOURCE);
    DrawIconEx(temp.Canvas.Handle, 0, 0, SmallIcon,
      cx, cy, 0, 0, DI_NORMAL);
    DestroyIcon(SmallIcon);
    sysicon.assign(temp);
    sysicon.TransparentColor := clFuchsia;
    sysicon.Transparent := true;
  end;
  temp.free;
end;

function TSkinData.GetCaptionColor: Tcolor;
var
  h, w: integer;
begin
  result := colors[csButtonFace];
  if border[3] = nil then exit;
  if border[3].map.empty then exit;
  w := border[3].map.width;
  h := border[3].map.height div border[3].frame;
  result := border[3].map.Canvas.Pixels[w div 3, h div 3];
end;

function TSkinData.GetScrollBarInfo(hwnd: HWND; idObject: Longint;
  var psbi: TScrollBarInfo): boolean;
begin
  result := false;
  if (@pGetScrollBarInfo <> nil) then
    result := pGetScrollBarInfo(hwnd, idObject, psbi);
end;

procedure SkinDll(adata: pointer);
begin
  if skinmanager = nil then
    SkinManager := TSkinManage.create(1);
  skinmanager.assigndata(adata);
  skinmanager.installhook;
  inc(skinmanager.state);
end;

procedure DoTrackMouse(ahwnd: THandle);
var
  trackinfo: TTrackMouseEvent;
begin
  trackinfo.cbSize := 16;
  trackinfo.hwndTrack := ahwnd;
  trackinfo.dwFlags := 2;
  if @pTrackMouseEvent <> nil then
    pTrackMouseEvent(trackinfo);
end;

var
  hUser: HModule;

initialization

  hUser := LoadLibrary('user32.dll');
  @pGetScrollBarInfo := GetProcAddress(hUser, 'GetScrollBarInfo');
  @pTrackMouseEvent := GetProcAddress(hUser, 'TrackMouseEvent');
  @pGetComboBoxInfo := GetProcAddress(hUser, 'GetComboBoxInfo');
  @pDisableProcessWindowsGhosting := GetProcAddress(hUser, 'DisableProcessWindowsGhosting');
finalization
  FreeLibrary(hUser);

end.

