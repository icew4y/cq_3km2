unit WinSkinForm;

{$I Compilers.Inc}

{$IFDEF demo}
{.$define test}
{$ELSE}
{.$define test}
{$ENDIF}

{$WARNINGS OFF}
{$HINTS OFF}
{$RANGECHECKS OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  ExtCtrls, StdCtrls, ComCtrls, Menus, Buttons, ImgList, grids, commctrl,
  WinSkinData, winsubclass, Consts, typinfo;

const
  CN_FormUPdate = WM_USER + $3102;
  CN_NewForm = WM_USER + $3103;
  CN_IsSkined = WM_USER + $3123;
  CN_NewMDIChild = WM_USER + $3116;
  CN_ReCreateWnd = WM_USER + $3117;
  CN_MenuSelect = WM_USER + $3118;
  cKey1 = 27969;
  cKey2 = 380323;
  MAX_CLASSNAME = 100;
  MAX_MENUITEM_TEXT = 64;
  Max_MenuitemID = $1000;
  c_demo: array[0..12] of char =
  (#$0CA, #$33, #$70, #$30, #$0F1, #$9A,
    #$01, #$65, #$0E9, #$32, #$0DC, #$82, #$4F);

type
  TWinSkinForm = class;
  TWinSkinSpy = class;
  NMCSBCUSTOMDRAW = record
    hdr: NMHDR;
    dwDrawStage: DWORD;
    hdc: HDC;
    rc: TRect;
    uItem: UINT;
    uState: UINT;
    nBar: UINT;
  end;
  pNMCSBCUSTOMDRAW = ^NMCSBCUSTOMDRAW;

  TNCObject = class(Tobject)
  private
  public
    SF: TWinSkinForm;
    fsd: TSkinData;
    bounds: Trect;
    visible: boolean;
    state: integer;
    enabled: boolean;
    procedure MouseDown; virtual;
    procedure MouseUp; virtual;
    procedure MouseEnter; virtual;
    procedure MouseLeave; virtual;
    procedure Draw; virtual;
  end;

  TMenuBtn = class(TNCObject)
  private
  public
    menuitem: Tmenuitem;
    FSD: TSkinData;
      index: integer;
    caption: widestring;
    enabled: boolean;
    hsubmenu: Hmenu;
    mid: integer;
    procedure draw; override;
  end;

  TWinSysButton = class(TNCObject)
  private
  public
    data: TDataSkinSysButton;
    procedure draw; override;
  end;

  TWinSkinMenu = class(TComponent)
  private
    procedure Copymenu(source, dst: Hmenu);
  public
    Buttons: array of TMenuBtn;
    menu: Tmainmenu;
    Bar: Trect;
    FSD: TSkinData;
    SF: TWinSkinForm;
    bkmap: Tbitmap;
    count: integer;
    topmenu: boolean;
    hmenu: HMenu;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure UpdataBtn;
    procedure UpdataBtn1;
    procedure UpdataBtn2(newmenu: Thandle);
    procedure UpdataBtn3;
    procedure DrawMenu(dc: HDC; rc: TRect);
    function FindBtn(p: Tpoint): TNcobject;
    procedure MouseMove(p: Tpoint);
    procedure SetMenuRect;
  end;

  TSkinFormStyle = (sfsNormal, sfsMDIform, sfsMDIChild, sfsChild);
  TSkinFormBorder = (sbsSizeable, sbsSingle, sbsNone, sbsDialog);
  TSkinWindowState = (swsNormal, swsMax, swsMin);
  TSkinFormIcon = (sbiMax, sbiMin, sbiHelp, sbisystem, sbicaption);
  TSkinFormIcons = set of TSkinFormIcon;

  TWinSkinForm = class(TComponent)
  private
    done, done2: boolean;
    OldWndProc: TWndMethod;
    FPrevWndProc: Pointer;
    FObjectInst: Pointer;
    FMDIWndProc: Pointer;
    FMDIObjectInst: Pointer;
    CaptionFont: Tfont;
    FActive: boolean;
    BorderIcons: TBorderIcons;

    FOverrideOwnerDraw: boolean;
    timer: TTimer;
    bstr, astr: widestring;
    classname: string;
    hassysbtn, menuauto, sMainMenu: boolean;
    fClientRect: TRect;
    msglock: integer;
    poptime: dword;
    DoubleTime: integer;
    charwidth: integer;
    parenthwnd: Thandle;
    DefIcon: HIcon;
    FTitleRect: TRect;
    Iconx: integer; //Icon宽高
    procedure GetIcon(var bmp: Tbitmap);
    procedure DeleteControls;
    procedure SetActive(const Value: boolean);
    procedure WinWndProc(var aMsg: TMessage);
    procedure NewWndProc(var aMsg: TMessage);
    procedure Default(var Msg: TMessage);
    procedure WMActive(var Msg: TMessage);
    procedure WMNCCalcSize(var Msg: TMessage);
    procedure WMNCActive(var Msg: TMessage);
    procedure WMNCPaint(var Msg: TMessage);
    procedure WMNCMouseMove(var Msg: TMessage);
    procedure WMNCLButtonDown(var Msg: TMessage);
    procedure WMNCLBUTTONDBLCLK(var Msg: TMessage);
    procedure WMNCLButtonUp(var Msg: TMessage);
    procedure WMNCRButtonUp(var Msg: TMessage);
    procedure WMMouseMove(var Msg: TMessage);
    procedure WMNCHitTest(var Msg: TMessage);
    procedure WMSysCommand(var Msg: Tmessage);
    procedure WMCommand(var Msg: Tmessage);
    procedure WMINITMENU(hm: Hmenu);
    procedure WMMEASUREITEM(var Msg: Tmessage);
    procedure WMMEASUREITEMH(var Msg: Tmessage);
    procedure WMDRAWITEM(var Msg: Tmessage);
//    procedure WMPaint(var Msg: Tmessage);
    procedure WMERASEBKGND(var Msg: TMessage);
    procedure WMSize(var Msg: TMessage);
    procedure WMGetMinMaxInfo(var Msg: TMessage);
    procedure CMDialogChar(var Message: TMessage);
    procedure WMCtlcolor(var Msg: TMessage);
    procedure WMWINDOWPOSCHANGED(var Msg: TMessage);
    procedure WMWindowPosChanging(var Msg: TMessage);
    procedure WMMDIACTIVATE(var aMsg: TMessage);
    procedure WMMDIACTIVATE2(var Msg: TMessage);
    procedure WMMDITile(var aMsg: TMessage);
    procedure WMReCreateWnd(var Msg: Tmessage);
    procedure DrawLine(acanvas: Tcanvas; rc: TRect);
    procedure CreateCaptionFont;
    procedure Drawborder(n: integer; Rc: Trect; dc: HDC);
    procedure SetSysbtnRect;
    procedure DrawAllSysbtn(acanvas: Tcanvas; rc: TRect);
    procedure DrawMin(dc: HDC);
    function SysBtnVisible(i: integer): boolean;
    function FindBtn(Point: TPoint): TNcobject;
    function GetWinXY(x, y: Smallint): Tpoint;
    procedure SysBtnAction(x, y: smallint);
//    procedure UpdateNc;
//    procedure UpdateNc(Rgn: HRgn=1);
    procedure UpdateNc(adc: HDC = 0);
    procedure DrawFLine(dc: HDC);
    procedure ToolBarDrawButton(Sender: TToolBar;
      Button: TToolButton; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure ToolBarDrawBackground(Sender: TToolBar; const ARect: TRect; var DefaultDraw: Boolean);
    procedure MeasureItemPop(Sender: TObject; ACanvas: TCanvas;
      var Width, Height: Integer);
    function GetMenuBG: Tbitmap;
    procedure DrawMenuCaption(ACanvas: TCanvas; ARect: TRect);
    procedure WMDrawMenuitem(var Msg: Tmessage);
    procedure WMDrawMenuitemH(var Msg: Tmessage);
    procedure DrawHMenuItem2(Amenu: Hmenu; Sender: TObject; ACanvas: TCanvas; ARect: TRect;
      Selected: Boolean);
    function CreateMenuItem(amenu: Hmenu; aid: integer): Tmenuitem;
    procedure DefaultMenuItem(Sender: TObject; ACanvas: TCanvas; ARect: TRect;
      Selected: Boolean);
    procedure DrawItemText(Item: TMenuitem; ACanvas: TCanvas;
      ARect: TRect; Selected: boolean);
    procedure DoDrawText(item: Tmenuitem; ACanvas: TCanvas; const ACaption: widestring;
      var Rect: TRect; Selected: Boolean; Flags: Longint);
    procedure OnTimer(Sender: TObject);
//    procedure ClearTempMenu;
    procedure CancelMenu;
    function FindButtonFromAccel(Accel: Word): TMenuBtn;
    procedure CreateSysmenu;
    procedure CreateSysmenu2;
    procedure DoSysMenu(Sender: TObject);
    procedure DoSysMenu2(Sender: TObject);
    function IsScrollControl(acontrol: TComponent): boolean;
    procedure KeepClient;
    procedure SelectMDIform(Sender: TObject);
    procedure ChangeMDIStyle;
    function Lookupcontrol(ahwnd: Thandle): Tskincontrol;
    procedure GetWindowstate;
    procedure GetFormstyle;
    procedure PopSysmenu(p: Tpoint);
    procedure MDIChildAction(const action: Integer);
    procedure UnSubclassMDI;
    procedure SubclassMDI;
    procedure WinMDIProc(var aMsg: TMessage);
    procedure DefaultMDI(var Msg: TMessage);
    procedure DeleteSkinDeleted;
    procedure InitToolbarMenu(Item: TMenuItem; enable: boolean);
    //画图标(修改)
    procedure DrawIcon(dc: HDC; rc: Trect);
    procedure AfterSkin;
    procedure DoSkinEdit(aEdit: Twincontrol);
    procedure GetBorderSize;
    procedure UpdateStyle(b: boolean);
    procedure DisableControl(Comp: TControl);
    function CheckSysmenu: boolean;
    procedure MenuSelect(var Msg: TMessage);
    procedure BeginUpdate;
    procedure StopUpdate;
    procedure InitSkin(afsd: Tskindata);
    function GetSysBtnHint(i: integer): string;
  protected
    caption: widestring;
    bw, wTr, ctr, oldsize: TRect;
    MenuHeight, BtnCount: integer;
    fInMenu, Creating, bidileft: boolean;
    fSizeable, fMaxable, fminable: boolean;
    isunicode, ismessagebox: boolean;
    ischildform: boolean;
//    FTempMenu :Tpopupmenu;
//    FButtonMenu : Tmenuitem;
    backstr: string;
    sysmenu: TPopupmenu;
    ClientHwnd, NewChildHwnd: Thandle;
    hmenu, hsysmenu, tempmenu, activemenu: hmenu;
    formcolor: Tcolor;
    dwstyle: dword;
    RightBtn: integer;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure DrawSysbtn(btn: TWinsysButton; i: integer);
    procedure ResizeForm(i: integer);
    function FindSkinComp(acomp: Tcontrol): boolean;
    function FindSkinComp2(ctrl: Twincontrol): boolean;
    procedure InitControlA(wForm: TWinControl);
    procedure InitChildCtrl(wForm: TWinControl);
    function Find3rdControl(aname: string; comp: Twincontrol): boolean;
    procedure HintReset();
  public
    ActiveBtn: TNCObject;
    crop: boolean;
    WinRgn: THandle;
    FForm: TForm;
    Hwnd: Thandle;
    fCanvas, fcanvas2: TCanvas;
    fsd: TSkinData;
    menu: TWinSkinMenu;
    SysBtn: array of TWinSysButton;
    IconBmp: Tbitmap;
    CaptionBuf: Tbitmap;
    Controllist: Tlist;
    fwidth, fheight: integer;
    crwidth, crheight: integer;
    FWindowActive: boolean;
    FormStyle: TSkinFormStyle;
    FormBorder: TSkinFormBorder;
    FormIcons: TSkinFormIcons;
    Windowstate: TSkinWindowState;
    Skinstate: integer;
    Activeskincontrol: Tskincontrol;
    mode: integer;
    formclass: string;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Refresh;
    procedure Minimize;
    procedure Maximize;
    procedure Restore;
    procedure RestoreMDI;
//    property Form: TForm read FForm write fform;
    procedure UnSubclass;
    procedure UnSubclass2;
    procedure UnSubclass3;
    function CheckMenu(Button: TMenuBtn): Boolean;
    function MDIChildMax: boolean;
    procedure ClickButton(Button: TMenuBtn);
    procedure getClipMap(fbmp: Tbitmap);
    procedure doLog(msg: string);
    procedure InitPopMenu(wForm: TWinControl; Enable, Update: boolean);
    procedure InitMainMenu(wForm: TWinControl; Enable, Update: boolean);
    property Active: boolean read FActive write setactive;
    procedure SkinChange;
    procedure AddSysMenuitem(acaption: string; action: integer);
    procedure EnableSysbtn(b: boolean);
    procedure Uncropwindow;
    procedure Cropwindow;
    procedure InitTform(afsd: Tskindata; aform: Tform);
    procedure InitControls(wForm: TWinControl);
    procedure AddComp(Comp: TControl; wForm: TWinControl);
    procedure InitNestform(wForm: Twincontrol);
    procedure RePaint(ahwnd: Thandle);
    procedure InitSkinData;
    procedure UpdateMainMenu;
    procedure DeleteSysbtn;
    function AddControlList(acontrol: TSkinControl): boolean;
    procedure AddControlh(ahwnd: HWND);
    procedure InitHwndControls(ahwnd: Thandle);
    procedure DeleteControl(c: TSkinControl);
    procedure DrawMenuItem(Sender: TObject; ACanvas: TCanvas; ARect: TRect;
      Selected: Boolean);
    procedure MeasureItem(Sender: TObject; ACanvas: TCanvas;
      var Width, Height: Integer);
    procedure InitDlg(afsd: Tskindata);
  published
  end;

  TWinSkinSpy = class(TComponent)
  protected
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
  public
    sf: TWinskinform;
    destructor Destroy; override;
  end;

procedure Bitmapdraw(DC: HDC; Dst: Trect; Bmp: TBitmap);
procedure DrawBGbmp(acanvas: Tcanvas; Dst: Trect; Bitmap: TBitmap; SrcRect: TRect);
function BitmapToRegion(bmp: TBitmap; xx, yy: integer; TransparentColor: TColor = clFuchsia;
  RedTol: Byte = 1; GreenTol: Byte = 1; BlueTol: Byte = 1): HRGN;
procedure DrawRect1(DC: HDC; Dst: Trect; Bmp: TBitmap; I, N: integer; Trans: integer = 0);
procedure DrawRect2(DC: HDC; Dst: Trect; Bmp: TBitmap; Src: TRect; I, N: integer;
  Trans: integer = 0; Tile: integer = 0; Spliter: integer = 0);
procedure DrawRect3(DC: HDC; Dst: Trect; Bmp: TBitmap; I, N: integer; Trans: integer = 0);
//procedure DrawRectTile(DC:HDC;Dst:Trect;Bmp:TBitmap;Src: TRect;I,N:integer;
//        Trans:integer=0;Spliter:integer=1);
procedure DrawRectTile(acanvas: Tcanvas; Dst: Trect; Bmp: TBitmap; Src: TRect; I, N: integer;
  Trans: integer = 0; Spliter: integer = 1);
//procedure DrawTranmap(DC:HDC;Dst:Trect;temp:TBitmap);
procedure DrawTranmap(DC: HDC; Dst: Trect; temp: TBitmap; transcolor: Tcolor = clFuchsia);
{function TransparentStretchBlt(DstDC: HDC; DstX, DstY, DstW, DstH: Integer;
  SrcDC: HDC; SrcX, SrcY, SrcW, SrcH: Integer; MaskDC: HDC; MaskX,
  MaskY: Integer): Boolean;}
function GetHMap(Dst: Trect; Bmp: TBitmap; Src: TRect; I, N: integer;
  Tile: integer = 0; Spliter: integer = 0): Tbitmap;
function GetThumbMap(Dst: Trect; Bmp: TBitmap; Src: TRect; I, N: integer;
  Tile: integer = 0; Spliter: integer = 0): Tbitmap;
procedure DrawBorder(Dc: HDC; Dst: Trect; Bmp: TBitmap; Src: TRect; I, N: integer;
  Tile: integer = 0; Spliter: integer = 0);
procedure DrawRectH(DC: HDC; Dst: Trect; Bmp: TBitmap; Src: TRect; I, N: integer;
  Tile: integer = 0; Spliter: integer = 0);
procedure DrawRectV(DC: HDC; Dst: Trect; Bmp: TBitmap; Src: TRect; I, N: integer;
  Tile: integer = 0; Spliter: integer = 0);
function Max(const A, B: Integer): Integer;
function Min(const A, B: Integer): Integer;
function MsgtoStr(aMsg: TMessage): string;
procedure SkinAddLog(msg: string);
function GetWindowClassname(ahwnd: Thandle): string;
function CopyHMenu(amenu: Hmenu): Hmenu;
procedure DeleteHMenu(amenu: Hmenu);
function EnumControl(ahwnd: HWND; lParam: LPARAM): boolean; stdcall;
procedure DrawParentImage(Control: TControl; DC: HDC; InvalidateParent: Boolean = False);
function GetFormCaptionA(ahwnd: Thandle): string;
function GetFormCaption(ahwnd: Thandle): widestring;
function GetFormText(ahwnd: Thandle): string;

//function SBCustomDraw(sb:Tskinscrollbar;PDraw:pNMCSBCUSTOMDRAW):integer;
//procedure  SetProperty(control: TObject;aprop,value:string);

var
  WinVersion: Cardinal;
  BG: TBitmap;
  Logstring: Tstringlist;
  SkinCanLog: boolean;
implementation

//uses winsubclass;
uses WinSkinDlg, winskinmenu;

{$R vclskin.res}

procedure TNCObject.MouseDown;
begin
  if (sf.activebtn <> nil) and (sf.activebtn <> self) then
    sf.activebtn.mouseleave;
  if visible then begin
    sf.activebtn := self;
    state := 2;
    draw;
  end;
end;

procedure TNCObject.MouseUp;
begin
  if visible then begin
    state := 3;
    draw;
  end;
end;

procedure TNCObject.MouseEnter;
var
  b: boolean;
begin
//   if not sf.timer.enabled then sf.timer.enabled:=true;
  b := false;
  if (sf.activebtn <> nil) then begin
    if (sf.activebtn <> self) then begin
      sf.activebtn.mouseleave;
      b := true;
    end;
  end else b := true;
  if b and visible then begin
    sf.activebtn := self;
    state := 3;
    draw;
  end;
end;

procedure TNCObject.MouseLeave;
begin
  if visible then begin
    sf.activebtn := nil;
    state := 1;
    draw;
    sf.HintReset();
  end;
end;

procedure TNCObject.Draw;
begin
end;

procedure TWinSysButton.Draw;
begin
  sf.drawsysbtn(self, state);
end;

procedure TWinSkinMenu.UpdataBtn1;
var
  i, n: integer;
  mi: TMenuItemInfo;
  Buffer: array[0..79] of Char;
  item: Tmenuitem;
  newmenu: Thandle;

begin
  newmenu := getmenu(sf.hwnd);
  if newmenu <> 0 then hmenu := newmenu;
  if hmenu = 0 then exit;

  if sf.FForm <> nil then begin
    if sf.FForm.Menu = nil then exit;
    menu := sf.FForm.Menu;
  end;
  for i := 0 to high(Buttons) do Buttons[i].free;
  setlength(buttons, menu.Items.Count);
  count := menu.Items.count;
  for i := 0 to menu.Items.Count - 1 do begin
    item := menu.Items[i];

    buttons[i] := TMenuBtn.create;
    buttons[i].fsd := fsd;
    buttons[i].sf := sf;
    buttons[i].index := i;

    buttons[i].visible := item.visible;
    buttons[i].enabled := item.Enabled;
    buttons[i].mid := item.Command;
//       buttons[i].caption:= item.Caption;
    buttons[i].caption := GetStringProp(item, 'Caption');
    buttons[i].menuitem := item;
    if item.count > 0 then
      buttons[i].hsubmenu := item.Handle
    else
      buttons[i].hsubmenu := 0;
    inc(n);
  end;
  SetMenu(sf.hwnd, 0);
end;

procedure TWinSkinMenu.UpdataBtn;
var
  i, n, j: integer;
  mi: TMenuItemInfo;
  Buffer: array[0..79] of Char;
  item: Tmenuitem;
  newmenu: Thandle;
  b: boolean;
begin
  b := (Win32Platform = VER_PLATFORM_WIN32_NT) and (Win32MajorVersion < 5);
//  b:= b or (winversion >= $80000000);
  b := b or ((Win32MajorVersion = 4) and (Win32MinorVersion = 0));

  if b then begin
    updatabtn1;
    exit;
  end;

  newmenu := getmenu(sf.hwnd);
  if newmenu <> 0 then hmenu := newmenu;
  if hmenu = 0 then exit;

  if sf.FForm <> nil then begin
    if sf.FForm.Menu = nil then exit;
    menu := sf.FForm.Menu;
  end;

//  fsd.DoDebug('UpdataBtn');

  for i := 0 to high(Buttons) do Buttons[i].free;
  count := GetMenuItemCount(hmenu);
  if count <= 0 then exit;
  setlength(buttons, count);
  for i := 0 to count - 1 do begin
    mi.cbSize := sizeof(TMENUITEMINFO);
    mi.fMask := MIIM_ID or MIIM_TYPE or MIIM_STATE or MIIM_SUBMENU;
    fillchar(buffer, sizeof(buffer), #0);
    mi.dwTypeData := Buffer;
    Mi.cch := SizeOf(Buffer);
    GetMenuItemInfo(hmenu, i, TRUE, mi);

    buttons[i] := TMenuBtn.create;
    buttons[i].fsd := fsd;
    buttons[i].sf := sf;
    buttons[i].index := i;

    buttons[i].hsubmenu := mi.hSubMenu;
    buttons[i].enabled := (mi.fState and MFS_DISABLED) = 0;
    buttons[i].visible := true;
    buttons[i].mid := mi.wid;
    buttons[i].caption := buffer;
    inc(n);
       //fsd.DoDebug(inttostr(mi.wid));
       //if (buttons[i].caption='') then begin
    Item := menu.FindItem(mi.wID, fkCommand);
    if item <> nil then begin
      if Assigned(item.Action) then item.Action.Update;
      buttons[i].caption := GetStringProp(item, 'Caption');
      buttons[i].enabled := item.Enabled;
      buttons[i].menuitem := item;
      if item.count > 0 then
        buttons[i].hsubmenu := item.Handle
      else
        buttons[i].hsubmenu := 0;
    end;
       //end;
  end;
  SetMenu(sf.hwnd, 0);
end;

{procedure TWinSkinMenu.UpdataBtn1;
var i,n:integer;
    mi:TMenuItemInfo;
    Buffer: array[0..79] of Char;
    item:Tmenuitem;
    newmenu:Thandle;
begin
  newmenu := getmenu(sf.hwnd);
  if newmenu<>0 then hmenu := newmenu;

  if hmenu = 0 then exit;
  for i:= 0 to high(Buttons) do Buttons[i].free;
  count:= GetMenuItemCount(hmenu);
  if count<=0 then exit;
  setlength(buttons,count);
  for i:= 0 to count-1 do begin
       mi.cbSize:= sizeof(TMENUITEMINFO);
       mi.fMask	:= MIIM_ID or MIIM_TYPE or MIIM_STATE or MIIM_SUBMENU;
       fillchar(buffer,sizeof(buffer),#0);
       mi.dwTypeData := Buffer;
       Mi.cch := SizeOf(Buffer);
       GetMenuItemInfo(hmenu, i, TRUE, mi);

       buttons[i]:=TMenuBtn.create;
       buttons[i].fsd:=fsd;
       buttons[i].sf:=sf;
       buttons[i].index:= i;

       buttons[i].hsubmenu:=mi.hSubMenu;
       buttons[i].enabled:= (mi.fState and MFS_DISABLED)=0;
       buttons[i].visible:= true;
       buttons[i].mid:=mi.wid;
       buttons[i].caption:= buffer;
       inc(n);
       if (buttons[i].caption='') and (menu<>nil)
           and (i<menu.items.Count) then begin
          Item := menu.items[i];
          if item<>nil then begin
            if Assigned(item.Action) then item.Action.Update;
            buttons[i].caption:= item.caption;
            buttons[i].enabled:= item.Enabled;
            buttons[i].mid:=GetMenuItemID(hmenu,i);
            if item.count>0 then
              buttons[i].hsubmenu:=item.Handle
            else
              buttons[i].hsubmenu:=0;
          end;
       end;

  end;
  SetMenu(sf.hwnd, 0);
end;}

procedure TWinSkinMenu.UpdataBtn3;
var
  i, n: integer;
  item: Tmenuitem;
  newmenu: Thandle;
begin
  newmenu := getmenu(sf.hwnd);
  if newmenu <> 0 then hmenu := newmenu;

  for i := 0 to high(Buttons) do Buttons[i].free;
  count := menu.items.Count;
  if count <= 0 then exit;
  setlength(buttons, count);
  for i := 0 to count - 1 do begin
    buttons[i] := TMenuBtn.create;
    inc(n);
    Item := menu.items[i];
    if Assigned(item.Action) then item.Action.Update;
    buttons[i].caption := item.caption;
    buttons[i].enabled := item.Enabled;
    buttons[i].visible := item.visible;
    buttons[i].mid := item.Command;
    buttons[i].fsd := fsd;
    buttons[i].sf := sf;
    buttons[i].index := i;
    if item.count > 0 then
      buttons[i].hsubmenu := item.Handle
    else
      buttons[i].hsubmenu := 0;
  end;
  SetMenu(sf.hwnd, 0);
  sf.activebtn := nil;
end;

procedure TWinSkinMenu.UpdataBtn2(newmenu: Thandle);
var
  i, n, j: integer;
  mi: TMenuItemInfo;
  Buffer: array[0..79] of Char;
  item: Tmenuitem;
begin
  newmenu := getmenu(sf.hwnd);
  if newmenu <> 0 then hmenu := newmenu;
  if hmenu = 0 then exit;

  if sf.FForm <> nil then begin
    if sf.FForm.Menu = nil then exit;
    menu := sf.FForm.Menu;
  end;
//  fsd.DoDebug('UpdataBtn2');

  for i := 0 to high(Buttons) do Buttons[i].free;
  count := GetMenuItemCount(hmenu);
  if count <= 0 then exit;

  setlength(buttons, count);
  for i := 0 to count - 1 do begin
    mi.cbSize := sizeof(TMENUITEMINFO);
    mi.fMask := MIIM_ID or MIIM_TYPE or MIIM_STATE or MIIM_SUBMENU;
    fillchar(buffer, sizeof(buffer), #0);
    mi.dwTypeData := Buffer;
    Mi.cch := SizeOf(Buffer);
    GetMenuItemInfo(hmenu, i, TRUE, mi);

    buttons[i] := TMenuBtn.create;
    buttons[i].fsd := fsd;
    buttons[i].sf := sf;
    buttons[i].index := i;

    buttons[i].hsubmenu := mi.hSubMenu;
    buttons[i].enabled := (mi.fState and MFS_DISABLED) = 0;
    buttons[i].visible := true;
    buttons[i].mid := mi.wid;
    buttons[i].caption := buffer;
    inc(n);
    if (buttons[i].caption = '') then begin
      Item := menu.FindItem(mi.wID, fkCommand);
      if item <> nil then begin
        if Assigned(item.Action) then item.Action.Update;
        buttons[i].caption := item.caption;
        buttons[i].enabled := item.Enabled;
        buttons[i].mid := item.Command;
        if item.count > 0 then
          buttons[i].hsubmenu := item.Handle
        else
          buttons[i].hsubmenu := 0;
      end;
    end;
  end;
  SetMenu(sf.hwnd, 0);
  SetMenuRect();
end;

{procedure TWinSkinMenu.UpdataBtn;
var i:integer;
    mi:TMenuItemInfo;
    Buffer: array[0..79] of Char;
begin
  hmenu:= getmenu(sf.hwnd);
  for i:= 0 to high(Buttons) do Buttons[i].free;
  count:= GetMenuItemCount(hmenu);
  if count=0 then exit;
  setlength(buttons,count);
  for i:= 0 to count-1 do begin
       buttons[i]:=TMenuBtn.create;
       buttons[i].fsd:=fsd;
       buttons[i].sf:=sf;
       buttons[i].index:= i;

       GetMenuString(hmenu,i,buffer,sizeof(buffer),MF_BYPOSITION);
       buttons[i].caption:= buffer;

       mi.cbSize:= sizeof(TMENUITEMINFO);
//       mi.fMask	:= MIIM_TYPE;
       mi.fMask	:= MIIM_TYPE or MIIM_STATE or MIIM_SUBMENU;

       mi.fType	:= MFT_STRING;
       fillchar(buffer,sizeof(buffer),#0);
       mi.dwTypeData := Buffer;
       Mi.cch := SizeOf(Buffer);
       GetMenuItemInfo(hmenu, i, TRUE, mi);
//       if mi.ftype=MFT_STRING then begin
          buttons[i].caption:= buffer;
          buttons[i].hsubmenu:=mi.hSubMenu;
          buttons[i].enabled:= (mi.fState and MFS_DISABLED)=0;
          buttons[i].visible:= true;
//       end;
  end;
  SetMenu(sf.hwnd, 0);
end;}

procedure TWinSkinMenu.Copymenu(source, dst: Hmenu);
var
  i, n, aid: integer;
begin
  n := GetMenuItemCount(source);
  for i := 0 to n - 1 do begin
    aid := GetMenuItemID(source, i);
  end;
end;

constructor TWinSkinMenu.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
  bkmap := Tbitmap.create;
end;

destructor TWinSkinMenu.Destroy;
var
  i: integer;
begin
  bkmap.free;
  for i := 0 to length(Buttons) - 1 do Buttons[i].free;
  setlength(Buttons, 0);

  inherited destroy;
end;

type
  TMenuItemAccess = class(TMenuItem);
  TACControl = class(TControl);
  TACWinControl = class(TWinControl);
  TACGrid = class(TCustomGrid);
  TACBitmap = class(TBitmap);

procedure TWinSkinMenu.DrawMenu(dc: HDC; rc: TRect);
var
  i, w, h, x: integer;
  r, r1: Trect;
  item: Tmenuitem;
  btn: Tmenubtn;
  rightmargin: integer;
begin
//   fsd.DoDebug('DrawMenu');
  r1 := rc;
  offsetrect(rc, -rc.left, -rc.top);
  bg.width := rc.right;
  bg.height := rc.bottom;
  if fsd.menubar = nil then begin
    bg.canvas.brush.color := fsd.colors[csMenuBar];
    bg.canvas.fillrect(rc);
    x := 6;
  end else begin
    if sf.FWindowActive then i := 1
    else i := 2;
//      DrawRect2(acanvas.handle,rc,fsd.menubar.map,fsd.menubar.r,1,2,0,0,1);
    if fsd.menubar.tile = 1 then
      DrawRect2(bg.canvas.handle, rc, fsd.menubar.map, fsd.menubar.r, i, 2, 0, 0, 1)
    else
      DrawRectTile(bg.canvas, rc, fsd.menubar.map, fsd.menubar.r, i, 2);
    if Menu.IsRightToLeft then
      x := 8 + fsd.menubar.r.right
    else
      x := 4 + fsd.menubar.r.left;
    if x > rc.right then x := 12;
  end;
   //save bar map;
  bar := r1;
  bkmap.assign(bg);

  bg.canvas.Font := Screen.MenuFont;
  bg.canvas.Font.color := fsd.colors[csMenuBarText];
  bg.canvas.brush.style := bsclear;
  SetBkMode(bg.Canvas.Handle, TRANSPARENT);
  topmenu := true;
  if Menu.IsRightToLeft then begin
   //bidi righttoleft
    x := rc.Right - x;

    if (sf.FormStyle = sfsMDIForm) and sf.MDIChildMax then begin
      for i := 0 to high(sf.sysbtn) do
        if (sf.sysbtn[i].data.Visibility = 100) and
          (not sf.sysbtn[i].data.map.empty) then begin
          r := sf.sysbtn[i].bounds;
          if x > (r.Left - 5) then x := (r.Left - 5);
        end;
    end;

    for i := 0 to high(buttons) do begin
      btn := buttons[i];
      if not btn.visible then begin
        btn.bounds := rect(0, 0, 0, 0);
        continue;
      end;
      r := r1;
      Tnt_DrawTextW(bg.Canvas.Handle, btn.caption, r, DT_Left or DT_CALCRECT or DT_NOCLIP);
      w := r.Right - r.left;
//     w:= bg.canvas.TextWidth(btn.caption);
      if w > 0 then w := w + 10;
      r := rect(x - w, 0, x, rc.bottom - 1);
      if btn.enabled then
        bg.canvas.Font.color := fsd.colors[csMenuBarText]
      else
        bg.canvas.Font.color := fsd.colors[csbuttonshadow];

      MyDrawCaption(bg.canvas, r, btn.caption, btn.enabled, false);
      r := rect(r1.left + x - w, r1.top, r1.left + x, r1.bottom - 1);
      btn.bounds := r;
      x := x - w;
    end;

  end else begin
   //bidi lefttoright
    for i := 0 to high(buttons) do begin
      btn := buttons[i];
      if not btn.visible then begin
        btn.bounds := rect(0, 0, 0, 0);
        continue;
      end;
      r := r1;
      Tnt_DrawTextW(bg.Canvas.Handle, btn.caption, r, DT_Left or DT_CALCRECT or DT_NOCLIP);
      w := r.Right - r.left;
     //w:= bg.canvas.TextWidth(btn.caption);
      if w > 0 then w := w + 10;
      r := rect(x, 0, x + w, rc.bottom - 1);
      if btn.enabled then
        bg.canvas.Font.color := fsd.colors[csMenuBarText]
      else
        bg.canvas.Font.color := fsd.colors[csbuttonshadow];
{     if (item.imageindex<>-1) and (menu.images<>nil) then
       MyDrawImgCaption(bg.canvas,r,menu.images,item.imageindex,
                       item.caption,item.enabled,false)
     else}
      MyDrawCaption(bg.canvas, r, btn.caption, btn.enabled, false);
      r := rect(r1.left + x, r1.top, r1.left + x + w, r1.bottom - 1);
      btn.bounds := r;
      x := x + w;
    end;
  end;

  topmenu := false;
  if (sf.FormStyle = sfsMDIForm) and sf.MDIChildMax then begin
    for i := 0 to high(sf.sysbtn) do
      if (sf.sysbtn[i].data.Visibility = 100) and
        (not sf.sysbtn[i].data.map.empty) then begin
        r := sf.sysbtn[i].bounds;
        offsetrect(r, -sf.bw.left, -sf.bw.top);
        DrawRect1(bg.canvas.handle, r,
          sf.sysbtn[i].data.map, 1, sf.sysbtn[i].data.frame, 1);
      end;
    if not skinmanager.mdimax then skinmanager.setmdimax(true);
  end;
  BitBlt(dc, r1.left, r1.top, rc.right, rc.bottom,
    bg.Canvas.Handle, 0, 0, SrcCopy);
end;

procedure TWinSkinMenu.SetMenuRect;
var
  i, w, h, x: integer;
  r, r1: Trect;
  item: Tmenuitem;
  btn: Tmenubtn;
  rc: Trect;
begin
  rc := rect(sf.bw.left, sf.bw.top,
    sf.fwidth - sf.bw.right, sf.bw.top + sf.menuheight);
  r1 := rc;
  offsetrect(rc, -rc.left, -rc.top);
  if (rc.Right <= 0) or (rc.Bottom <= 0) then exit;
  bg.width := rc.right;
  bg.height := rc.bottom;
  if fsd.menubar = nil then begin
    x := 6;
  end else begin
    if Menu.IsRightToLeft then
      x := 8 + fsd.menubar.r.right
    else
      x := 4 + fsd.menubar.r.left;
    if x > rc.right then x := 12;
  end;

  bg.canvas.Font := Screen.MenuFont;

  if Menu.IsRightToLeft then begin
   //bidi righttoleft
    x := rc.Right - x;
    for i := 0 to high(buttons) do begin
      btn := buttons[i];
      if not btn.visible then begin
        btn.bounds := rect(0, 0, 0, 0);
        continue;
      end;
      r := r1;
      Tnt_DrawTextW(bg.Canvas.Handle, btn.caption, r, DT_Left or DT_CALCRECT or DT_NOCLIP);
      w := r.Right - r.Left;
      if w > 0 then w := w + 10;
      r := rect(r1.left + x - w, r1.top, r1.left + x, r1.bottom - 1);
      btn.bounds := r;
      x := x - w;
    end;

  end else begin
   //bidi lefttoright
    for i := 0 to high(buttons) do begin
      btn := buttons[i];
      if not btn.visible then begin
        btn.bounds := rect(0, 0, 0, 0);
        continue;
      end;
      r := r1;
      Tnt_DrawTextW(bg.Canvas.Handle, btn.caption, r, DT_Left or DT_CALCRECT or DT_NOCLIP);
      w := r.Right - r.Left;
     //w:= bg.canvas.TextWidth(btn.caption);
      if w > 0 then w := w + 10;
      r := rect(r1.left + x, r1.top, r1.left + x + w, r1.bottom - 1);
      btn.bounds := r;
      x := x + w;
    end;
  end;
end;

procedure TMenuBtn.Draw;
var
  DC: HDC;
  r, r2: Trect;
begin
  DC := GetWindowDC(sf.hwnd);
  sf.fcanvas.handle := DC;
//    menuitem.OnDrawItem:=nil;
  r := rect(bounds.left, sf.menu.bar.top, bounds.right, sf.menu.bar.bottom);
  r2 := r;
  offsetrect(r2, -sf.menu.bar.left, -sf.menu.bar.top);
  sf.fcanvas.copyrect(r, sf.menu.bkmap.canvas, r2);
  if (state = 3) or (state = 2) then begin
    sf.fcanvas.brush.color := fsd.colors[csButtonHilight];
    sf.fcanvas.FrameRect(bounds);
  end;
  sf.fcanvas.Font := Screen.MenuFont;
  sf.fcanvas.Font.style := [];
  if enabled then
    sf.fcanvas.Font.color := fsd.colors[csMenuBarText]
  else
    sf.fcanvas.Font.color := fsd.colors[csbuttonshadow];
//    sf.fcanvas.brush.style:= bsclear;
//    SetBkMode(sf.fCanvas.Handle, TRANSPARENT);
  r := bounds;
{    if (menuitem.imageindex<>-1) and (sf.menu.menu.images<>nil) then
       MyDrawImgCaption(sf.fcanvas,r,sf.menu.menu.images,menuitem.imageindex,
                       menuitem.caption,menuitem.enabled,false)
    else }
  MyDrawCaption(sf.fcanvas, r, caption, enabled, false);
  sf.fCanvas.Handle := 0;
  ReleaseDC(sf.hwnd, DC);
end;

function TWinSkinMenu.FindBtn(p: Tpoint): TNcobject;
var
  i: integer;
begin
  result := nil;
  for i := 0 to high(Buttons) do begin
    if PtInRect(buttons[i].bounds, p) and (buttons[i].caption <> '') then begin
      Result := buttons[i];
      break;
    end;
  end;
end;

procedure TWinSkinMenu.MouseMove(p: Tpoint);
var
  i: integer;
begin
{  i := findbtn(p);
  if i<>-1 then begin
       buttons[i].mouseenter;
       sf.done:=true;
  end else
     if sf.activebtn<>nil then begin
       sf.activebtn.mouseleave;
     end;}
end;
//menu hook
var
  MenuHook: HHOOK;
  InitDone: Boolean = False;
  MenuBar: TWinSkinMenu;
  Skinform: TWinSkinForm;
  MenuButtonIndex: Integer;
  LastMenuItem: TMenuItem;
  LastMenuItemID: integer;
  LastMousePos: TPoint;
  StillModal: Boolean;
  lastselect: boolean = false;

function ToolMenuGetMsgHook(Code: Integer; WParam: Longint; var Msg: TMsg): Longint; stdcall;
const
  RightArrowKey: array[Boolean] of Word = (VK_LEFT, VK_RIGHT);
  LeftArrowKey: array[Boolean] of Word = (VK_RIGHT, VK_LEFT);

var
  P: TPoint;
  Target: TMenuBtn;
  Item: Integer;
  FindKind: TFindItemKind;
  ParentMenu: TMenu;

  function FindButton(Forward: Boolean): TMenuBtn;
  var
    Bar: TWinSkinMenu;
    I, J, Count: Integer;
  begin
    Bar := Skinform.menu; //MenuToolBar;
    if Bar <> nil then begin
      J := MenuButtonIndex;
      I := J;
//      Count := Bar.Count;
      Count := high(Bar.buttons) + 1;
      if Forward then begin
        if I = Count - 1 then
          I := 0
        else
          Inc(I);
        Result := Bar.Buttons[I];
      end else begin
        if I = 0 then
          I := Count - 1
        else
          Dec(I);
        Result := Bar.Buttons[I];
      end;
    end else Result := nil;
  end;

begin
  if LastMenuItem <> nil then begin
    ParentMenu := LastMenuItem.GetParentMenu;
    if ParentMenu <> nil then begin
      if ParentMenu.IsRightToLeft then
        if Msg.WParam = VK_LEFT then
          Msg.WParam := VK_RIGHT
        else if Msg.WParam = VK_RIGHT then
          Msg.WParam := VK_LEFT;
    end;
  end;
  Result := CallNextHookEx(MenuHook, Code, WParam, Longint(@Msg));
  if Result <> 0 then Exit;
  if (Code = MSGF_MENU) then begin
    Target := nil;
    if not InitDone then begin
      InitDone := True;
      PostMessage(Msg.Hwnd, WM_KEYDOWN, VK_DOWN, 0);
    end;
    case Msg.Message of
      WM_MENUSELECT:
        begin
          if (HiWord(Msg.WParam) = $FFFF) and (Msg.LParam = 0) then begin
            if not StillModal then Skinform.CancelMenu;
            Exit;
          end else StillModal := False;

          FindKind := fkCommand;
          if HiWord(Msg.WParam) and MF_POPUP <> 0 then FindKind := fkHandle;
          if FindKind = fkHandle then
            Item := GetSubMenu(Msg.LParam, LoWord(Msg.WParam))
          else
            Item := LoWord(Msg.WParam);
          if skinform.menu.menu <> nil then
            LastMenuItem := Skinform.menu.menu.FindItem(Item, FindKind);
        end;
      WM_SYSKEYDOWN:
        if Msg.WParam = VK_MENU then begin
          SkinForm.CancelMenu;
          Exit;
        end;
      WM_KEYDOWN: begin
          if Msg.WParam = VK_RETURN then
//          Skinform.FMenuResult := True
            StillModal := false
          else if Msg.WParam = VK_ESCAPE then
            StillModal := false
          else if (Msg.WParam = VK_RIGHT) then begin
            if (LastMenuItem = nil) or (LastMenuItem.Count = 0) then
              Target := FindButton(True);
          end else if (Msg.WParam = VK_LEFT) then begin
            if (LastMenuItem = nil) then
              Target := FindButton(False)
            else if ((LastMenuItem.Parent.handle = skinform.activemenu)
              or (LastMenuItem.handle = skinform.activemenu)) then
              Target := FindButton(False);
          end else Target := nil;
          if Target <> nil then
            P := Point(Target.Bounds.left + 1, Target.Bounds.top + 1);
        end;
      WM_MOUSEMOVE:
        begin
          P := Msg.pt;
          if (P.X <> LastMousePos.X) or (P.Y <> LastMousePos.Y) then begin
            p := SkinForm.GetWinxy(p.x, p.y);
            Target := Tmenubtn(SKinForm.Menu.findbtn(P));
            LastMousePos := P;
          end;
        end;
    end;
    if (Target <> nil) and (Target is TMenuBtn) and
      (Target.Index <> MenuButtonIndex) then begin
      StillModal := True;
//          SkinForm.FCaptureChangeCancels := False;
//          SkinForm.ClickButton(Target);
      SkinForm.ClickButton(Target);
      lastselect := true;
//          skinform.fsd.DoDebug('do click true '+TMenuBtn(Target).caption)
    end;
  end;
end;

procedure InitMenuHooks;
begin
  StillModal := False;
  InitDone := False;
  GetCursorPos(LastMousePos);
  if MenuHook = 0 then
    MenuHook := SetWindowsHookEx(WH_MSGFILTER, @ToolMenuGetMsgHook, 0,
      GetCurrentThreadID);
end;

procedure ReleaseMenuHooks;
begin
  if MenuHook <> 0 then UnhookWindowsHookEx(MenuHook);
  MenuHook := 0;
  LastMenuItem := nil;
  MenuBar := nil;
  MenuButtonIndex := -1;
  InitDone := False;
end;

{procedure TWinSkinForm.ClearTempMenu;
var
  I: Integer;
  Item: TMenuItem;
begin
  if (FTempMenu <> nil) and (FButtonMenu<>nil) then begin
    for I := FTempMenu.Items.Count - 1 downto 0 do
    begin
      Item := FTempMenu.Items[I];
      FTempMenu.Items.Delete(I);
      if item.tag<>c_windowid then
         FButtonMenu.Insert(0, Item);
    end;
    FTempMenu.Free;
    FTempMenu := nil;
    FButtonMenu := nil;
  end;
end;}

procedure TWinSkinForm.ClickButton(Button: TMenuBtn);
var
  P: TPoint;
begin
//  FCaptureChangeCancels := False;
  GetWindowRect(hwnd, WTR);
  P := Point(Button.bounds.left + 1 + wtr.left,
    Button.bounds.top + 1 + wtr.top);
//  timer.enabled:=true;
  PostMessage(hwnd, WM_NCLBUTTONDOWN, MK_LBUTTON, Longint(PointToSmallPoint(P)));
//  PostMessage(hwnd, CN_MenuSelect, 0, Longint(PointToSmallPoint(P)));
end;

procedure TWinSkinForm.MenuSelect(var Msg: TMessage);
var
  P: TPoint;
  btn: TNCobject;
  b: boolean;
begin
//  if not fwindowactive then exit;
  P := GetWinXY(msg.LParamLo, msg.LParamhi);

  btn := findbtn(p);
  if (btn = nil) and (menu <> nil) then btn := menu.findbtn(p);

  b := false;
  if (btn <> nil) and (btn is TMenuBtn) then begin
    CheckMenu(TMenuBtn(Btn));
  end;
  Msg.Result := 0;
  Msg.Msg := WM_NULL;
end;

function TWinSkinForm.FindButtonFromAccel(Accel: Word): TMenuBtn;
var
  I: Integer;
begin
  result := nil;
  if menu = nil then exit;
  for I := 0 to high(menu.buttons) do begin
    Result := Menu.Buttons[I];
    if Result.Enabled and Result.visible and
      IsAccel(Accel, Result.Caption) then
      Exit;
  end;
  Result := nil;
end;

procedure TWinSkinForm.CancelMenu;
begin
  if FInMenu then begin
//    ReleaseMenuKeyHooks;
//    MouseCapture := False;
  end;
  FInMenu := False;
//  FCaptureChangeCancels := False;
end;

procedure TWinSkinForm.SelectMDIform(Sender: TObject);
var
  s: string;
  j: integer;
  b: boolean;
  WS: TWindowState;
begin
  if not Assigned(Application.MainForm) then exit;
  s := Tmenuitem(sender).caption;
  s := StringReplace(s, '&', '', []);
  with Application.MainForm do
    if (FormStyle = fsMDIForm) and (MDIChildCount > 0) then begin
      for j := 0 to MDIChildCount - 1 do begin
        if MDIChildren[j].caption = s then begin
          WS := Application.MainForm.ActiveMDIChild.WindowState;
//                 b:=MDIChildren[j].windowstate=wsmaximized;
//                 MDIChildren[j].show;
          SendMessage(ClientHandle, WM_MDIACTIVATE, MDIChildren[j].handle, 0);
          MDIChildren[j].windowstate := ws;
          break;
        end;
      end;
    end;
end;

function CopyHMenu(amenu: Hmenu): Hmenu;
var
  hMenuOurs: Hmenu;
  nID: UINT; // The ID of the menu.
  uMenuState: UINT; // The menu state.
  hSubMenu: HMENU; // A submenu.
  s: string;
  nmenu: integer;
  szBuf: array[0..127] of char;
begin
  hMenuOurs := CreatePopupMenu;
  nmenu := 0;
  uMenuState := GetMenuState(aMenu, nMenu, MF_BYPOSITION);
  while uMenustate <> $FFFFFFFF do begin
    GetMenuString(aMenu, nMenu, szBuf, sizeof(szBuf), MF_BYPOSITION);
    if (LOBYTE(uMenuState) and MF_POPUP) > 0 then begin
      hSubMenu := GetSubMenu(aMenu, nMenu);
      AppendMenu(hMenuOurs, uMenuState, hSubMenu, szBuf);
    end else begin
      nID := GetMenuItemID(aMenu, nMenu);
      AppendMenu(hMenuOurs, uMenuState, nID, szBuf);
    end;
    inc(nmenu);
    uMenuState := GetMenuState(aMenu, nMenu, MF_BYPOSITION);
  end;
  result := hmenuours;
end;

procedure DeleteHMenu(amenu: Hmenu);
var
  b: boolean;
begin
  b := RemoveMenu(amenu, 0, MF_BYPOSITION);
  while b do
    b := RemoveMenu(amenu, 0, MF_BYPOSITION);
  DestroyMenu(amenu);
end;

procedure RethinkLines(aitem: Tmenuitem);
var
  I, LLastAt: Integer;
  LLastBar: TMenuItem;
begin
//    for i:= 0 to aitem.Count-1 do
//     aitem.Items[i].AutoHotkeys := maAutomatic;

  LLastAt := 0;
  LLastBar := nil;
  with aitem do begin
    for I := LLastAt to Count - 1 do
      if Items[I].Visible then
        if Items[I].IsLine then
        begin
          Items[I].Visible := False;
        end else begin
          LLastAt := I;
          System.Break;
        end;
    for I := LLastAt to Count - 1 do
      if Items[I].IsLine then
      begin
        if (LLastBar <> nil) and (LLastBar.Visible) then
        begin
          LLastBar.Visible := False;
        end;
        LLastBar := Items[I];
      end
      else if Items[I].Visible then
      begin
        if (LLastBar <> nil) and (not LLastBar.Visible) then
        begin
          LLastBar.Visible := True;
        end;
        LLastBar := nil;
        LLastAt := I;
      end;
    for I := Count - 1 downto LLastAt do
      if Items[I].Visible then
        if Items[I].IsLine then
        begin
          Items[I].Visible := False;
        end
        else
          System.Break;
  end;
end;

procedure ActionUpdate(item: Tmenuitem);
var
  i: Integer;
  a: TMenuItem;
begin
{   for i:= 0 to item.Count-1 do begin
     a:=item.Items[i];
     if a.Action<>nil then a.Action.Update;
   end;}
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

function GetFormCaptionA(ahwnd: Thandle): string;
var
  buf: array[0..1000] of char;
begin
  sendmessage(ahwnd, WM_GETTEXT, 1000, integer(@buf));
  result := strpas(buf);
end;

function GetFormText(ahwnd: Thandle): string;
var
  s: widestring;
begin
  s := GetFormCaption(ahwnd);
  result := WideStringToStringEx(s);
end;

function TWinSkinForm.CheckMenu(Button: TMenuBtn): Boolean;
var
  Hook: Boolean;
  I: Integer;
  APoint: TPoint;
  aflags: integer;
  mp: tagTPMPARAMS;
begin
  Result := False;
  lastselect := false;
  mp.cbSize := sizeof(mp);
  if (button = nil) then Exit;
  postmessage(hwnd, wm_command, button.mid, 0);
  if (Button.hsubmenu = 0) then Exit;
  if button.menuitem <> nil then begin
//    error happen 2006.5.04
//       RethinkLines(button.menuitem);
    ActionUpdate(button.menuitem);
  end;
  MenuButtonIndex := Button.Index;
  SkinForm := Self;
  GetWindowRect(hwnd, WTR);
  mp.rcExclude := rect(wtr.Right - 5, wtr.Top, GetSystemMetrics(SM_CXMAXIMIZED), wtr.Bottom);
  if not ((Win32Platform = VER_PLATFORM_WIN32_NT) and (Win32MajorVersion = 4)) then
    wminitmenu(button.hsubmenu);
//    skincanlog:=true;
  finmenu := true;
  APoint := Point(Button.bounds.left + wtr.left, Button.bounds.bottom + wtr.top);
  if bidileft then begin
    APoint := Point(Button.bounds.right + wtr.left, Button.bounds.bottom + wtr.top);
    Aflags := TPM_RightALIGN or TPM_RIGHTBUTTON or TPM_NONOTIFY;
  end else begin
    APoint := Point(Button.bounds.left + wtr.left, Button.bounds.bottom + wtr.top);
    Aflags := TPM_LEFTALIGN or TPM_RIGHTBUTTON or TPM_NONOTIFY;
  end;
//    SendMessage(hwnd,WM_INITMENUPOPUP,button.hsubmenu,0);
  skinmanager.menutype := m_menuitem;
  skinmanager.menuactive := true;
  activemenu := button.hsubmenu;
  InitMenuHooks;
  if Button.enabled then begin
//       if bidileft then
//          TrackPopupMenuex(button.hsubmenu, aflags,APoint.X, APoint.Y,hwnd,@mp)
//       else
    TrackPopupMenu(button.hsubmenu, aflags, APoint.X, APoint.Y, 0, hwnd, nil);
  end;
  ReleaseMenuHooks;
  finmenu := false;
  Result := True;
end;

//fixed by Brian Lowe

procedure TWinSkinForm.CMDialogChar(var Message: TMessage); //TCMDialogChar
var
  Button: TMenubtn;
  ShiftState: TShiftState;
  KeyState: TKeyboardState;
begin
  OldWndProc(message);
  if message.result <> 0 then exit;

  GetKeyboardState(KeyState);
  ShiftState := KeyboardStateToShiftState(KeyState);
  Button := FindButtonFromAccel(TWMKey(Message).CharCode);
  if (Button <> nil) and (ShiftState = [ssAlt]) then begin
    clickbutton(button);
    Message.Result := 1;
    done2 := true;
  end else begin
      //mdiform mainmenu shortcut
    if (formstyle = sfsmdichild) then begin
      if skinmanager.MDIForm.Perform(CM_DIALOGCHAR,
        TWMKey(Message).CharCode, TWMKey(Message).KeyData) <> 0 then exit;
    end else if (fform <> application.MainForm) and (not (fsModal in fform.FormState)) then begin //has problem
      application.MainForm.Perform(CM_DIALOGCHAR, TWMKey(Message).CharCode, TWMKey(Message).KeyData);
    end;
    message.Result := 0;
//      OldWndProc(message);
  end;
end;

procedure SetAnimation(Value: Boolean);
var
  Info: TAnimationInfo;
begin
  Info.cbSize := SizeOf(TAnimationInfo);
  BOOL(Info.iMinAnimate) := Value;
  SystemParametersInfo(SPI_SETANIMATION, SizeOf(Info), @Info, 0);
end;

constructor TWinSkinForm.Create(AOwner: TComponent);
var
  i, l: integer;
begin
  inherited create(aowner);
  bstr := '  ';
  SkinCanLog := true;
  poptime := 0;
  charwidth := 0;
  winrgn := 0;
  DoubleTime := GetDoubleClickTime;
//  SkinCanLog:=false;
  CreateCaptionFont;
  fCanvas := TCanvas.create;
  fCanvas2 := TCanvas.create;
//  bg:=Tbitmap.create;
  controllist := Tlist.create;
  IconBmp := Tbitmap.create;
  CaptionBuf := Tbitmap.create;
  MenuHeight := 0;
  msglock := 0;
  mode := 0;
  activebtn := nil;
  creating := false;
  bidileft := false;
  NewChildHwnd := 0;
  fwindowactive := true;
  ActiveBtn := nil;
  skinstate := skin_Creating;
  fform := nil;
  astr := '  ';
{$IFNDEF demo}
  astr := ' ';
{$ELSE}
  astr := ' Vclskin Demo';
{$ENDIF}
end;

destructor TWinSkinForm.Destroy;
begin
  DeleteControls;
  DeleteSysbtn;
  if not IsBadReadPtr(CaptionBuf, InstanceSize) then CaptionBuf.free;
  if timer <> nil then timer.free;
  if menu <> nil then begin
    menu.free;
    menu := nil;
  end;
  if sysmenu <> nil then begin
    sysmenu.free;
    sysmenu := nil;
  end;
  CaptionFont.free;
  controllist.free;
  controllist := nil;
  Iconbmp.free;
  if skinmanager <> nil then skinmanager.DeleteForm2(hwnd);
  fCanvas.free;
  fCanvas2.free;
//  skinaddlog('Skinform DESTROY '+caption);
  inherited destroy;
end;

  //  TabSheet := TTabSheet.Create(PageControl1);
  // this event happen when owern is form, it is problem

procedure TWinSkinForm.Notification(AComponent: TComponent; Operation: TOperation);
var
  j: integer;
  sc: Tskincontrol;
begin
  inherited Notification(AComponent, Operation);

{  if (Operation = opInsert) and (AComponent <> nil) then begin
     skinaddlog(format('Notification Insert :%s,%s',[acomponent.classname,acomponent.name]));
  end;   }

  {  if (skinstate<>Skin_Active) or (acomponent.tag=c_skintag) then exit;
  if (Operation = opRemove) and (AComponent <> nil) then begin
     skinaddlog(format('Notification Remove :%s',[acomponent.classname]));
     if (AComponent is TGraphicControl) then begin
       for j:= 0 to controllist.count-1 do begin
            sc:= Tskincontrol(controllist.items[j]);
            if sc.GControl = AComponent then begin
               controllist.Delete(j);
               sc.free;
               break;
            end;
       end;
     end;//Tgraphiccontrol
  end else if (Operation = opInsert) and (AComponent <> nil) then begin
//     skinaddlog(format('Notification Insert :%s',[acomponent.classname]));
  end;}
end;

procedure TWinSkinForm.DeleteSysbtn;
var
  i: integer;
begin
  if high(sysbtn) = 0 then exit;
  for i := 0 to high(SysBtn) do
    SysBtn[i].free;
  setlength(sysbtn, 0);
end;

procedure TWinSkinForm.DeleteControl(c: TSkinControl);
var
  i: integer;
begin
  if controllist = nil then exit;
  for i := controllist.count - 1 downto 0 do begin
    if Controllist.items[i] = c then begin
      controllist.delete(i);
      break;
    end;
  end;
end;

procedure TWinSkinForm.DeleteSkinDeleted;
var
  i: integer;
  c: TSkinControl;
begin
  for i := controllist.count - 1 downto 0 do begin
    c := TSkinControl(Controllist.items[i]);
    if c.skinstate = skin_deleted then begin
      controllist.delete(i);
      c.free;
    end;
  end;
end;

procedure TWinSkinForm.DeleteControls;
var
  i: integer;
  c: TSkinControl;
  acontrol: Tcontrol;
begin
//  for i:= controllist.count-1 to 0 do begin
//  if (Skinstate=skin_Destory) then exit;
  while controllist.count > 0 do begin
    c := TSkinControl(Controllist.items[0]);
    if (c.control <> nil) and (c.control is TToolbar) then begin
      Ttoolbar(c.control).OnCustomDrawButton := nil;
      Ttoolbar(c.control).OnCustomDraw := nil;
    end;
    if (Skinstate <> skin_Destory) and (c.skinstate <> skin_deleted) then c.unsubclass;
    controllist.delete(0);
    c.free;
  end;
  controllist.clear;
end;

function TWinSkinForm.AddControlList(acontrol: TSkinControl): boolean;
var
  i: integer;
  c: TSkinControl;
  b: boolean;
begin
  b := false;
  for i := 0 to controllist.count - 1 do begin
    c := TSkinControl(Controllist.items[i]);
    if c = acontrol then begin
      b := true;
      break;
    end;
  end;
  if not b then controllist.add(acontrol);
  result := b;
end;

procedure TWinSkinForm.CreateCaptionFont;
var
  NonClientMetrics: TNonClientMetrics;
begin
  if Assigned(CaptionFont) then FreeAndNIL(CaptionFont);
  CaptionFont := TFont.Create;
  NonClientMetrics.cbSize := SizeOf(NonClientMetrics);
  if SystemParametersInfo(SPI_GETNONCLIENTMETRICS, 0, @NonClientMetrics, 0) then
    CaptionFont.Handle := CreateFontIndirect(NonClientMetrics.lfCaptionFont);

end;

procedure TWinSkinForm.changemdistyle;
var
  Style: Longint;
begin
  if fform.clienthandle <> 0 then begin
    Style := GetWindowLong(fform.ClientHandle, GWL_STYLE);
    Style := Style and not WS_VSCROLL and not WS_HSCROLL;
    SetWindowLong(fform.ClientHandle, GWL_STYLE, Style);

    Style := GetWindowLong(fform.ClientHandle, GWL_EXSTYLE);
    Style := Style and not WS_EX_CLIENTEDGE;
    SetWindowLong(fform.ClientHandle, GWL_EXSTYLE, Style);
    SetWindowPos(fform.ClientHandle, 0, 0, 0, 0, 0, SWP_FRAMECHANGED or SWP_NOACTIVATE or
      SWP_NOMOVE or SWP_NOSIZE or SWP_NOZORDER);
  end;
end;

procedure TWinSkinForm.SetActive(const Value: boolean);
begin
end;

procedure TWinSkinForm.InitTform(afsd: Tskindata; aform: Tform);
begin
  fform := aform;

  if assigned(afsd.OnBeforeSkinForm) then
    afsd.OnBeforeSkinForm(fform, hwnd, formclass);

//   fform.autoscroll:=false;
  if (xcMenuitem in afsd.SkinControls) then
    setproperty(fform, 'AutoScroll', 'False');
  InitSkin(afsd);
//   if (xcMainMenu in afsd.SkinControls) then begin
  if sMainMenu then begin //for midchild border
    OldWndProc := fform.WindowProc;
    fform.WindowProc := NewWndProc;
  end;
  formcolor := aform.color;
  aform.color := afsd.colors[csButtonFace];
//   if (xcPopupMenu in afsd.SkinControls) then
//     InitPopMenu(aForm,true,false);
  if (xcMenuitem in afsd.SkinControls) then begin
    InitMainMenu(aForm, true, false);
  end;
end;

procedure TWinSkinForm.GetBorderSize;
var
  r1, r2: Trect;
begin
  GetClientRect(hwnd, fClientRect);
  getwindowrect(hwnd, r1);
  GetClientRect(hwnd, r2);
  oldsize := rect(0, 0, r1.right - r1.left - (r2.right - r2.left),
    r1.bottom - r1.top - (r2.bottom - r2.top));
end;

procedure TWinSkinForm.InitSkin(afsd: Tskindata);
var
  Exdwstyle: Dword;
  r1, r2: Trect;
  cw: integer;
begin
  if (FObjectInst = nil) then begin
    skinmanager.state := skin_Active;
    fsd := afsd;
    timer := TTimer.create(self);
    timer.Interval := 250;
    timer.Ontimer := Ontimer;
    timer.enabled := false;
//    CreateCaptionFont;
    sMainMenu := xcMainMenu in fsd.SkinControls;
    dwstyle := GetWindowLong(hwnd, GWL_STYLE);
    ExdwStyle := GetWindowLong(hwnd, GWL_EXSTYLE);
    bidileft := (exdwstyle and WS_EX_LEFTSCROLLBAR) > 0;
    ischildform := (dwstyle and ws_child) > 0;
//    hsysmenu:=GetSystemMenu(hWnd, FALSE);
//    geticon(iconbmp);
    classname := getwindowclassname(hwnd);
    parenthwnd := GetWindow(hWnd, GW_OWNER);

//    GetBorderSize;
{    GetClientRect(hwnd,fClientRect);
    getwindowrect(hwnd,r1);
    GetClientRect(hwnd,r2);
    oldsize:=rect(0,0,r1.right-r1.left-(r2.right-r2.left),
                     r1.bottom-r1.top-(r2.bottom-r2.top));}

    formicons := [];
    if ((dwstyle and WS_SYSMENU) > 0) or (hsysmenu > 0) then
      formicons := formicons + [sbisystem];
    if (dwstyle and WS_MINIMIZEBOX) > 0 then
      formicons := formicons + [sbimin];
    if (dwstyle and WS_MAXIMIZEBOX) > 0 then
      formicons := formicons + [sbimax];
    if (ExdwStyle and WS_EX_CONTEXTHELP) > 0 then
      formicons := formicons + [sbihelp];

//    createsysmenu2;
    getwindowstate;
    fsizeable := (dwstyle and WS_SIZEBOX) > 0;
    GetFormstyle;
    if (Exdwstyle and ws_ex_mdichild) > 0 then begin
      formstyle := sfsMDIChild;
      if (xoMDIChildBorder in fsd.Options) then
        sMainMenu := false;
    end; //{ else ShowWindow(hwnd,SW_HIDE)};
//MDIchild window menu has problem

    formborder := sbsSingle;
    if {((dwstyle and WS_popup)>0) and}
      ((dwstyle and WS_Caption) <> WS_Caption) then
      formborder := sbsnone
    else if ((dwstyle and WS_THICKFRAME) > 0) or
//       ((ExdwStyle and WS_EX_WINDOWEDGE)>0) or
       //( formstyle=sfsMDIChild ) or
    ((dwstyle and WS_SIZEBOX) > 0) then
      formborder := sbsSizeable
    else if ((dwstyle and DS_MODALFRAME) > 0) then
      formborder := sbsDialog;

    if (ExdwStyle and ws_EX_dlgmodalframe) > 0 then
      formborder := sbsDialog;

    if ((ExdwStyle and WS_EX_APPWINDOW) > 0)
      and (Win32Platform = VER_PLATFORM_WIN32_NT)
      and (Win32MajorVersion >= 5) and (Win32MinorVersion = 0) then
      formicons := formicons + [sbicaption];
    if ((parenthwnd = 0) and (formstyle <> sfsmdichild))
      and (Win32MajorVersion >= 5) and (Win32MinorVersion = 0) then
      formicons := formicons + [sbicaption];

    isunicode := IsWindowUnicode(hwnd);

    ismessagebox := false;
    if (classname = '#32770') or (classname = 'TMessageForm') then begin
      formborder := sbsDialog;
      ismessagebox := true;
    end;

    //    lockwindowupdate(hwnd);
    StopUpdate;

{$IFDEF demo}
//    setproperty(fform,'Caption',' ');
{$ENDIF}

    if (winversion >= $80000000) then
      fsd.skincontrols := fsd.skincontrols - [xcSystemMenu];

    if formstyle = sfsmdiform then begin
      menuauto := fsd.menuUpdate;
      subclassMDI;
    end;

    FObjectInst := MakeObjectInstance(WinWndProc);
    if isunicode then begin
      FPrevWndProc := Pointer(GetWindowLongw(hwnd, GWL_WNDPROC));
      SetWindowLongw(hwnd, GWL_WNDPROC, LongInt(FObjectInst));
    end else begin
      FPrevWndProc := Pointer(GetWindowLong(hwnd, GWL_WNDPROC));
      SetWindowLong(hwnd, GWL_WNDPROC, LongInt(FObjectInst));
    end;

    if sMainMenu then begin
      hmenu := GetMenu(hWnd);
      if (hmenu <> 0) and (formstyle <> sfsMDIChild) then begin
        menu := TWinSkinMenu.create(self);
        menu.fsd := fsd;
        Menu.sf := self;
        MenuHeight := GetSystemMetrics(SM_CYMENU);
//***************
        if fform <> nil then menu.menu := fform.menu;
        menu.UpdataBtn;
      end;
      if ((formstyle <> sfsmdichild) or (not skinmanager.mdimax)) and (windowstate <> swsmin) then
        EnableSysbtn(false);
      InitSkinData;
    end else skinstate := skin_active;

    cw := GetSystemMetrics(SM_CYCAPTION) + GetSystemMetrics(SM_CXFRAME);
//   if (menuheight=0) and (cw>bw.top) then
    if (formstyle = sfsMDIChild) and (cw > bw.top) then
      menuheight := cw - bw.Top;

//  setmdimax if mainmenu is nil
    if (formstyle = sfsmdichild) and (windowstate = swsmax) and (not skinmanager.mdimax) then
      skinmanager.setmdimax(true);

{    if fform<>nil then
       InitControls(fform)
    else InitHwndControls(hwnd);}

{$IFDEF test}
    SkinAddLog(format('%s skin active %1x', [caption, hwnd]));
{$ENDIF}
//   InvalidateRect(hwnd, 0,true);
  end;
end;

{procedure TWinSkinForm.EnableSysbtn(b:boolean);
var exstyle:Dword;
    b2:boolean;
begin
    if sbicaption in formicons then begin
          dwstyle := GetWindowLong( hwnd, GWL_STYLE );
          if b then dwstyle := dwstyle or WS_CAPTION
          else dwstyle := dwstyle and (not WS_CAPTION);
          SetWindowLong( hwnd, GWL_STYLE, dwstyle );
    end;
    exit;
    //mdichildmax has all sysbtn
    if (formstyle=sfsmdichild) and (skinmanager.mdimax)
       and (not b) then exit;

    //embed form unskin, exit
    if b and (formstyle<>sfsmdichild) and (ischildform) then exit;

    hassysbtn:=b;
    dwstyle := GetWindowLong( hwnd, GWL_STYLE );
    ExStyle := GetWindowLong(hwnd, GWL_EXSTYLE);
    if b then begin
      if sbisystem in formicons then
       dwstyle := dwstyle or WS_SYSMENU;
      if sbimin in formicons then
       dwstyle := dwstyle or WS_MINIMIZEBOX;
      if sbimax in formicons then
       dwstyle := dwstyle or WS_MAXIMIZEBOX;
      if sbicaption in formicons then
          dwstyle := dwstyle or WS_CAPTION;
    end else begin
      if (parenthwnd=0) or (formstyle=sfsmdiform) then begin
          formicons := formicons + [sbicaption];
          dwstyle := dwstyle and ( not WS_CAPTION);
      end else begin
          dwstyle := dwstyle and (not WS_MINIMIZEBOX);
          dwstyle := dwstyle and (not WS_MAXIMIZEBOX);
          dwstyle := dwstyle and ( not WS_SYSMENU);
      end;

      b2:=false;
      if ((parenthwnd=0) and (formstyle<>sfsmdichild)) then b2:=true
      else if (exstyle and WS_EX_APPWINDOW>0) then b2:=true;

      if b2 and (Win32Platform = VER_PLATFORM_WIN32_NT)
         and (Win32MajorVersion>=5) and (Win32MinorVersion >= 1) then b2:=false;

      if b2 then begin
          formicons := formicons + [sbicaption];
          dwstyle := dwstyle and ( not WS_CAPTION);
      end else begin
          dwstyle := dwstyle and (not WS_MINIMIZEBOX);
          dwstyle := dwstyle and (not WS_MAXIMIZEBOX);
          dwstyle := dwstyle and ( not WS_SYSMENU);
      end;
    end;
    SetWindowLong( hwnd, GWL_STYLE, dwstyle );
end;}

procedure TWinSkinForm.EnableSysbtn(b: boolean);
var
  exstyle: Dword;
  b2: boolean;
begin
  exit;
  if (formstyle <> sfsmdichild) then exit;
    //mdichildmax has all sysbtn
  if (skinmanager.mdimax) and (not b) then exit;

  hassysbtn := b;
  dwstyle := GetWindowLong(hwnd, GWL_STYLE);
  ExStyle := GetWindowLong(hwnd, GWL_EXSTYLE);
  if b then begin
    if sbisystem in formicons then
      dwstyle := dwstyle or WS_SYSMENU;
    if sbimin in formicons then
      dwstyle := dwstyle or WS_MINIMIZEBOX;
    if sbimax in formicons then
      dwstyle := dwstyle or WS_MAXIMIZEBOX;
  end else begin
    dwstyle := dwstyle and (not WS_MINIMIZEBOX);
    dwstyle := dwstyle and (not WS_MAXIMIZEBOX);
    dwstyle := dwstyle and (not WS_SYSMENU);
  end;
  SetWindowLong(hwnd, GWL_STYLE, dwstyle);
end;

procedure TWinSkinForm.SubclassMDI;
var
  MDIunicode: boolean;
begin
  MDIunicode := false;
  FMDIObjectInst := MakeObjectInstance(WinMDIProc);
  if MDIunicode then begin
    FMDIWndProc := Pointer(GetWindowLongw(Clienthwnd, GWL_WNDPROC));
    SetWindowLongw(Clienthwnd, GWL_WNDPROC, LongInt(FMDIObjectInst));
  end else begin
    FMDIWndProc := Pointer(GetWindowLong(Clienthwnd, GWL_WNDPROC));
    SetWindowLong(Clienthwnd, GWL_WNDPROC, LongInt(FMDIObjectInst));
  end;
end;

procedure TWinSkinForm.UnSubclassMDI;
var
  MDIunicode: boolean;
begin
  if FMDIObjectInst <> nil then begin
    MDIunicode := false;
    if MDIunicode then begin
      SetWindowLongw(Clienthwnd, GWL_WNDPROC, LongInt(FMDIWndProc));
    end else begin
      SetWindowLong(Clienthwnd, GWL_WNDPROC, LongInt(FMDIWndProc));
    end;
    FreeObjectInstance(FMDIObjectInst);
    FMDIObjectInst := nil;
  end;
end;

procedure TWinSkinForm.DefaultMDI(var Msg: TMessage);
begin
  msg.result := CallWindowProc(FMDIWndProc, Clienthwnd, Msg.msg, msg.WParam, msg.LParam);
end;

procedure TWinSkinForm.AddSysMenuitem(acaption: string; action: integer);
var
  item: Tmenuitem;
begin
  Item := TMenuItem.Create(sysmenu);
  item.Caption := acaption;
  item.Tag := action;
  item.onclick := dosysmenu;
  item.OnDrawItem := DrawMenuItem;
  item.OnMeasureItem := MeasureItempop;
  item.ImageIndex := action;
  if action = 3 then
    item.ShortCut := TextToShortCut('ALT+F4');
  Sysmenu.Items.Add(item);
end;

procedure TWinSkinForm.CreateSysmenu2;
var
  i, n, j: integer;
  mi: TMenuItemInfo;
  Buffer: array[0..79] of Char;
  item: Tmenuitem;
  s: string;
begin
  if sysmenu <> nil then begin
    sysmenu.free;
    sysmenu := nil;
  end;

  if (Win32Platform = VER_PLATFORM_WIN32_NT) and (Win32MajorVersion < 5) then begin
    CreateSysmenu;
    exit;
  end;

  if hsysmenu = 0 then exit;

  n := GetMenuItemCount(hsysmenu);
  sysmenu := Tpopupmenu.create(self);
  sysmenu.Tag := c_skintag;
  sysmenu.OwnerDraw := true;
  sysmenu.Images := fsd.bmpmenu;

  for i := 0 to n - 1 do begin
    fillchar(mi, sizeof(mi), #0);
    mi.cbSize := sizeof(TMENUITEMINFO);
    mi.fMask := MIIM_ID or MIIM_STATE or MIIM_STRING;
    mi.fType := 0;
    mi.dwTypeData := Buffer;
    Mi.cch := SizeOf(Buffer);
    GetMenuItemInfo(hsysmenu, i, TRUE, mi);
    s := buffer;

    Item := TMenuItem.Create(sysmenu);
    if s = '' then item.Caption := '-'
    else item.Caption := s;
    item.Tag := mi.wID;
    case mi.wID of
      SC_MAXIMIZE: begin
          item.ImageIndex := 1;
          item.enabled := (windowstate <> swsmax) and (sbimax in formicons);
        end;
      SC_MINIMIZE: begin
          item.ImageIndex := 2;
          item.enabled := (windowstate <> swsmin) and (sbimin in formicons);
        end;
      Sc_Restore: begin
          item.ImageIndex := 0;
          item.enabled := (windowstate <> swsnormal);
        end;
      SC_MOVE, SC_SIZE: begin
          item.enabled := (windowstate <> swsmax);
        end;
      SC_CLOSE: item.ImageIndex := 3;
    else item.ImageIndex := -1;
    end;
    item.onclick := dosysmenu2;

    if mi.fState = 3 then item.Enabled := false;
    if (mi.fState and MFS_CHECKED) > 0 then item.Checked := true;
      //item.Enabled :=  not ((mi.fState and $0ff) = MFS_DISABLED);
    item.OnDrawItem := DrawMenuItem;
    item.OnMeasureItem := MeasureItempop;
    Sysmenu.Items.Add(item);
  end;
end;

function TWinSkinForm.CheckSysmenu: boolean;
var
  i, n, j: integer;
  mi: TMenuItemInfo;
  Buffer: array[0..79] of Char;
begin
  result := true;
  if (Win32Platform = VER_PLATFORM_WIN32_NT) and (Win32MajorVersion < 5) then begin
    exit;
  end;

  if winversion >= $80000000 then
    exit;

  fillchar(mi, sizeof(mi), #0);
  mi.cbSize := sizeof(TMENUITEMINFO);
  mi.fMask := MIIM_STATE;
  mi.fType := 0;
  mi.dwTypeData := Buffer;
  Mi.cch := SizeOf(Buffer);
  result := GetMenuItemInfo(hsysmenu, SC_CLOSE, false, mi);
end;

procedure TWinSkinForm.CreateSysmenu;
begin
  if sysmenu <> nil then begin
    sysmenu.free;
    sysmenu := nil;
  end;
  sysmenu := Tpopupmenu.create(self);
  sysmenu.Tag := c_skintag;
  sysmenu.OwnerDraw := true;
  sysmenu.Images := fsd.bmpmenu;
  AddSysMenuitem(' Restore ', 0);
  if sbimax in formicons then AddSysMenuitem(' Maximize ', 1);
  if sbimin in formicons then AddSysMenuitem(' Minimize ', 2);
  AddSysMenuitem('-', 100);
  AddSysMenuitem(' Close ', 3);
end;

procedure TWinSkinForm.ResizeForm(i: integer);
var
  w, h, minwidth, w2: integer;
  r1, r2, r3: Trect;
  fdc: HDC;
  acanvas: TCanvas;
  hctrl, temp: Thandle;
  p: Tpoint;
  dw: dword;
begin
  dw := SWP_NOMOVE or SWP_DRAWFRAME or SWP_NOZORDER;
   {if SkinState=skin_change then} dw := dw or SWP_NOACTIVATE;

  if windowstate <> swsmax then begin
    GetWindowRect(hwnd, r2);
    if (ismessagebox) or (SkinState = skin_change) then GetClientRect(hwnd, fClientRect);

    w := fClientRect.right + bw.left + bw.right;
    if i = 0 then begin
      if fform <> nil then begin
           //fClientRect.bottom:=r2.bottom-r2.top-menuheight-GetSystemMetrics(SM_CYFRAME)*2-GetSystemMetrics(SM_CYCAPTION);
        W := fform.clientWidth + Bw.Left + bw.right;
        fclientrect.Bottom := fform.ClientHeight - menuheight;
           //GetClientRect(hwnd,fClientRect);
           //fClientRect.bottom:=fform.ClientHeight;
           //fClientRect.right:=fform.ClientWidth;
        if formstyle = sfsMDIChild then fclientrect.Bottom := fclientrect.Bottom + menuheight
      end;
      h := fClientRect.bottom + bw.top + bw.bottom + menuheight;
    end else begin
      GetClientRect(hwnd, fClientRect);
      h := fClientRect.bottom + bw.top + bw.bottom + menuheight;
    end;

{$IFDEF VER170} // Delphi 9
     //GetClientRect(hwnd,fClientRect);
     //h:=fClientRect.bottom+bw.top+bw.bottom+menuheight;
     //w:=fClientRect.right+bw.left+bw.right;
{$ENDIF}

    if (ismessagebox) and (i = 0) then begin
      caption := getformcaption(hwnd);
      FDC := GetWindowDC(hwnd);
      acanvas := Tcanvas.create;
      ;
      acanvas.Handle := fdc;
      acanvas.font := CaptionFont;
      charwidth := acanvas.Textwidth(caption);
      acanvas.free;
      ReleaseDc(hwnd, fdc);

//        minwidth := (length(caption))*charwidth+bw.Left+bw.Right+
//                    fsd.title.r.left+fsd.title.r.right;
//                    +fsd.title.backleft+fsd.title.backright;
      minwidth := charwidth + fsd.title.r.left + fsd.title.r.right;

      if w < minwidth then begin
        w2 := (minwidth - w) div 2;
        hCtrl := GetTopWindow(hWnd);
        while (hCtrl <> 0) do begin
          temp := GetNextWindow(hCtrl, GW_HWNDNEXT);
          GetWindowRect(hCtrl, r3);
          p := point(r3.Left, r3.Top);
          screentoclient(hwnd, p);
          SetWindowPos(hCtrl, 0, p.X + w2, p.y,
            r3.right - r3.Left, r3.Bottom - r3.Top,
            SWP_NOSENDCHANGING or SWP_NOOWNERZORDER);
          hCtrl := temp;
        end;
        w := minwidth;
      end;
    end;

    SetWindowPos(hwnd, 0, r2.left, r2.top, w, h, dw);
  end else begin
    SetWindowPos(hwnd, 0, 0, 0, 0, 0, dw or SWP_NOSIZE);
     //Refresh;
  end;
end;

procedure TWinSkinForm.RePaint(ahwnd: Thandle);
var
  w, h: integer;
  r, r2: Trect;
begin
//   GetWindowRect(ahwnd,r2);
//   SetWindowPos(ahwnd, 0, r2.left, r2.top, r2.right-r2.left, r2.bottom-r2.top,
//       SWP_DRAWFRAME or SWP_NOZORDER or SWP_NOACTIVATE);

//  getwindowrect(ahwnd,r);
//  offsetrect(r,-r.left,-r.top);
//  if phwnd<>0 then begin

  InvalidateRect(ahwnd, 0, true);
  UpdateWindow(ahwnd);
end;

function TWinSkinForm.IsScrollControl(acontrol: TComponent): boolean;
var
  hwnd: Thandle;
  Style: longword;
begin
  result := false;
  if not (acontrol is Twincontrol) then exit;
  hwnd := Twincontrol(acontrol).handle;
  Style := GetWindowLong(hWnd, GWL_STYLE);
  if ((Style and WS_HSCROLL) = 0) and
    ((Style and WS_VSCROLL) = 0) then begin
    if (acontrol is Tlistbox)
      or (acontrol is Tmemo)
//          or (acontrol.tag = 55)
//          or (acontrol is Tlistview)
    or (acontrol is TCustomListBox)
      or (acontrol is TCustomTreeView)
//          or (acontrol is TCustomGrid)
    or (acontrol is Tscrollbox) then
      result := true;
  end else result := true;
end;

procedure TWinSkinForm.InitToolbarMenu(Item: TMenuItem; enable: boolean);
var
  a: integer;

  procedure Activate(MenuItem: TMenuItem);
  begin
    if Enable then begin
      MenuItem.OnDrawItem := DrawMenuItem;
      MenuItem.OnMeasureItem := MeasureItem;
    end else MenuItem.OnDrawItem := nil;
  end;

begin
  Activate(Item);
  for a := 0 to Item.Count - 1 do
    InitToolbarMenu(Item.Items[a], enable);
end;

procedure TWinSkinForm.InitPopMenu(wForm: TWinControl; Enable, Update: boolean);
var
  i, x: integer;
  Comp: TComponent;
  s: string;

  procedure Activate(MenuItem: TMenuItem);
  begin
    if Enable then begin
      if (not assigned(MenuItem.OnDrawItem)) or (FOverrideOwnerDraw) then begin
        if sMainMenu then
          MenuItem.OnDrawItem := DrawMenuItem;
      end;
      if not assigned(MenuItem.OnMeasureItem) then
        MenuItem.OnMeasureItem := MeasureItem;
    end else MenuItem.OnDrawItem := nil;
  end;

  procedure Activatepop(MenuItem: TMenuItem);
  begin
    if Enable then begin
//        if (not assigned(MenuItem.OnDrawItem)) then begin//or (FOverrideOwnerDraw) then begin
      MenuItem.OnDrawItem := DrawMenuItem;
      if not assigned(MenuItem.OnMeasureItem) then
        MenuItem.OnMeasureItem := MeasureItempop;
//        end ;
    end else begin
      MenuItem.OnDrawItem := nil;
//       if MenuItem.OnMeasureItem = MeasureItempop then
      MenuItem.OnMeasureItem := nil;
    end;
  end;

  procedure ItrateMenu(MenuItem: TMenuItem);
  var
    a: integer;
  begin
    Activate(MenuItem);
    for a := 0 to MenuItem.Count - 1 do
      ItrateMenu(MenuItem.Items[a]);
  end;

  procedure ItrateMenupop(MenuItem: TMenuItem);
  var
    a: integer;
  begin
    Activatepop(MenuItem);
    for a := 0 to MenuItem.Count - 1 do
      ItrateMenupop(MenuItem.Items[a]);
  end;

begin
  s := fform.ClassName;
  if s = 'TwwRichEditForm' then exit;

  for i := 0 to wForm.ComponentCount - 1 do begin
    Comp := wForm.Components[i];

    if (Comp is TCustomFrame) then InitPopMenu(Twincontrol(comp), Enable, Update);
    if (Comp is TCustomForm) then InitPopMenu(Twincontrol(comp), Enable, Update);

    if (Comp is TPopupMenu) and
      (xcPopupmenu in fsd.SkinControls) and (comp.Tag <> fsd.disabletag) then
    begin
      TPopupMenu(Comp).OwnerDraw := Enable;
      for x := 0 to TPopupMenu(Comp).Items.Count - 1 do
      begin
        Activatepop(TPopupMenu(Comp).Items[x]);
        ItrateMenupop(TPopupMenu(Comp).Items[x]);
      end;
    end;
  end;
end;

procedure TWinSkinForm.InitMainMenu(wForm: TWinControl; Enable, Update: boolean);
var
  i, x, j: integer;
  Comp: TComponent;

  procedure Activate(MenuItem: TMenuItem);
  begin
    if Enable then begin
      if (j > 1) and (not assigned(MenuItem.OnDrawItem)) then begin
        MenuItem.OnDrawItem := DrawMenuItem;
        MenuItem.OnMeasureItem := MeasureItem;
      end;
    end else begin
      MenuItem.OnDrawItem := nil;
      MenuItem.OnMeasureItem := nil;
    end;
  end;

  procedure ItrateMenu(MenuItem: TMenuItem);
  var
    a: integer;
  begin
    inc(j);
    Activate(MenuItem);
    for a := 0 to MenuItem.Count - 1 do
      ItrateMenu(MenuItem.Items[a]);
    dec(j);
  end;

begin
  for i := 0 to wForm.ComponentCount - 1 do begin
    Comp := wForm.Components[i];

    if (Comp is TMainMenu) then //and (xcmainmenu in FSkinControls)
//       and ((Comp.Tag mod 100)<> fdisabletag)then
    begin
      TMainMenu(Comp).OwnerDraw := Enable;
      for x := 0 to TMainMenu(Comp).Items.Count - 1 do begin
        j := 0;
//        Activate(TMainMenu(Comp).Items[x]);
        ItrateMenu(TMainMenu(Comp).Items[x]);
      end;
    end;
  end;
end;

function TWinSkinForm.FindSkinComp(acomp: Tcontrol): boolean;
var
  isskin: integer;
  aname, name2: string;
  i: integer;
  sc: Tskincontrol;
begin
  if acomp = nil then exit;
  result := true;
{   if acomp is Twincontrol then
     isskin:=sendmessage(Twincontrol(acomp).Handle,CN_IsSkined,0,0)
   else    }
  isskin := acomp.Perform(CN_IsSkined, 0, 0);
  if isskin = 1 then exit;
  for i := 0 to controllist.count - 1 do begin
    sc := Tskincontrol(controllist.items[i]);
    if sc.control = acomp then begin
      exit;
    end;
  end;
  result := false;
end;

{function TWinSkinForm.FindSkinComp(acomp:Tcomponent):boolean;
var i:integer;
    sc:Tskincontrol;
    aname,name2:string;
begin
   result:=false;
   aname := fform.Name;
   name2 := lowercase(aname);
   for i:= 0 to controllist.count-1 do begin
      sc:= Tskincontrol(controllist.items[i]);
      if sc.GControl <> nil then begin
        if sc.gcontrol=acomp then begin
          result:=true;
          break;
        end;
      end else if acomp is Twincontrol then begin
          if Twincontrol(acomp).HandleAllocated then begin
             if sc.hwnd=Twincontrol(acomp).handle then begin
                result:=true;
                break;
             end;
          end else begin
            if (pos('preview',name2)>0) or
               (aname='TQRStandardPreview') or
               (aname='TppPrintPreview') or
               (aname='TdxfmStdPreview') then begin
               result:=true;
            end;
            break;
          end;
      end;
   end;
end;}

procedure TWinSkinForm.DisableControl(Comp: TControl);
var
  s: string;
  ctrl: Twincontrol;
  i: integer;
begin
  if not (comp is Twincontrol) then exit;
  ctrl := Twincontrol(comp);
  if ctrl.ControlCount = 0 then exit;
  s := lowercase(comp.ClassName);
  if (pos('radiogroup', s) = 0) and (pos('checkgroup', s) = 0) then exit;
  for i := 0 to ctrl.controlcount - 1 do
    ctrl.Controls[i].Tag := fsd.DisableTag;
end;

procedure TWinSkinForm.AddComp(Comp: TControl; wForm: TWinControl);
var
  i, x, j, tag: integer;
  subcomp: Twincontrol;
  subcontrol: Tcontrol;
  skin: TSkinControl;
  buf: array[0..100] of char;
  s, cname: string;
  b: boolean;
  chwnd: Thandle;
  skincomp: TComponent;
  tag2: integer;
//  spy:TWinSkinspy;
begin
     //tag2:= comp.tag mod 100;
  if comp.tag = fsd.disabletag then begin
    DisableControl(comp);
    exit;
  end;
  if comp.Parent = nil then exit;

  if FindSkinComp(comp) then exit;

  cname := Uppercase(comp.ClassName);
//     skinaddlog(format('Add control %s:%s:%1x',[comp.ClassName,comp.name,integer(comp)]));

  if (comp is Twincontrol) then begin
    chwnd := TACWinControl(comp).WindowHandle;
    if chwnd = 0 then
    try
      chwnd := TACWinControl(comp).handle;
    except
      exit;
    end;
  end;

  if Assigned(fsd.OnSkinControl) then begin
    skincomp := nil;
    fsd.OnSkinControl(self, fsd, wForm, comp, cname, skincomp);
    if Assigned(skincomp) then begin
      if (skincomp is TSkinControl) then begin
        skin := skincomp as TSkinControl;
        if skin.newcolor then b := true
        else b := false;
        if not addcontrollist(skin) then begin
          skin.init(self, self.fsd, self.fcanvas2, b);
          if (Comp is TCustomPanel) then
            InitChildCtrl(Comp as TWinControl);
                //self.InitControlA(Comp as TWinControl);
        end;
             ///skin.Inithwnd(TWinControl(Comp).Handle, Self.fsd, self.fcanvas2);
      end;
      exit;
    end;
  end;

  if (Find3rdControl(cname, TWinControl(comp))) then exit;

  if (cname = 'TDBCOMBOBOXEH') then exit;
//     if (cname='TQRPREVIEW') then exit;
  if (cname = 'TFRDESIGNERPAGE') then exit;
  if (cname = 'TFRPBOX') then exit;

     // not success
  if (Comp is TCustomTabControl) and (xcTab in Fsd.SkinControls)
    and (fsd.tab <> nil) then begin

    if (Comp is TPageControl) then begin
//           s:=GetStringProp(comp,'Style');
      if Tpagecontrol(comp).style = tsTabs then begin
        skin := TSkinTab.create(comp);
        skin.Init(self, self.fsd, self.fcanvas2, false);
      end else begin
        skin := TSkinTabBtn.create(comp);
        skin.Init(self, self.fsd, self.fcanvas2, false);
      end;
    end else begin
      skin := TSkinTab.create(comp);
      skin.kind := 2;
      skin.Init(self, self.fsd, self.fcanvas2, false);
    end;
  end

  else if (Comp is TToolbutton) and sMainMenu then begin
    if TToolbutton(comp).MenuItem <> nil then
      inittoolbarmenu(TToolbutton(comp).MenuItem, true);
  end

  else if (Comp is TCoolBar) and (xcToolbar in Fsd.SkinControls) then begin
    for i := 0 to Tcoolbar(comp).Bands.Count - 1 do begin
      Tcoolbar(comp).Bands[i].Color := fsd.colors[csButtonFace];
    end;
  end

  else if (cname = 'TTABSET') and (xcTab in Fsd.SkinControls)
    and (fsd.tab <> nil) then begin
//        with TSkinTab31.create(comp) do
//        init(self,self.fsd,self.fcanvas2);
    skin := TSkinTab31.create(comp);
    skin.init(self, self.fsd, self.fcanvas2);
  end

  else if (Comp is TTabSheet) and (xcTab in Fsd.SkinControls)
    and (fsd.tab <> nil) then begin
      //    with TSkinBox.create(comp) do
      //      init(self,self.fsd,self.fcanvas2,true);
    skin := TSkinTabSheet.create(comp);
    skin.init(self, self.fsd, self.fcanvas2, false);
  end

  else if (cname = 'TTABBEDNOTEBOOK') and (xcTab in Fsd.SkinControls)
    and (fsd.tab <> nil) then begin
    skin := TSkinTab.create(comp);
    skin.Init(self, self.fsd, self.fcanvas2, false);
//          TSkinTab(skin).inithwnd(TWinControl(Comp).handle,self.fsd,self.fcanvas2,self);
  end

  else if (cname = 'TMVCPANEL') then
    InitChildCtrl(Comp as TWinControl)

  else if ((Comp is TPageControl) and (xcTab in Fsd.SkinControls))
    and (fsd.tab <> nil) then begin
    s := GetStringProp(comp, 'Style');
    if s = 'tsTabs' then begin
      skin := TSkinTab.create(self);
      skin.Init(self, self.fsd, self.fcanvas2, false);
//          TSkinTab(skin).inithwnd(TWinControl(Comp).handle,self.fsd,self.fcanvas2,self);
    end else begin
      skin := TSkinTabBtn.create(self);
      skin.Init(self, self.fsd, self.fcanvas2, false);
    end;
  end

  else if (comp is THeaderControl) and (xcPanel in Fsd.SkinControls) then begin
    with TSkinHeader.create(comp) do
      init(self, self.fsd, self.fcanvas2, false);
  end

  else if ((Comp is TCustomCheckBox) and
    (xcCheckBox in Fsd.SkinControls)) then begin
    with TSkinCheckBox.create(comp) do
      init(self, self.fsd, self.fcanvas2, false);
  end

  else if ((comp is Ttrackbar) and
    (xctrackbar in Fsd.SkinControls)) then begin
    with TSkinTrackBar.create(comp) do
      init(self, self.fsd, self.fcanvas2);
  end

  else if (((cname = 'TUPDOWN') or (cname = 'TSPINBUTTON')) and
    (xcSpin in Fsd.SkinControls)) then begin
    with TSkinUpDown.create(comp) do
      init(self, self.fsd, self.fcanvas2);
  end

  else if ((cname = 'TMEDIAPLAYER') and (xcButton in Fsd.SkinControls)) then begin
    with TSkinMP.create(comp) do begin
      init(self, self.fsd, self.fcanvas2);
    end;
  end

  else if ((Comp is TCustomRadiogroup))
    and (xcRadioButton in Fsd.SkinControls) then begin
    for j := 0 to TWincontrol(comp).ControlCount - 1 do begin
      subcomp := Twincontrol(Twincontrol(comp).Controls[j]);
         //TAccontrol(subcomp).ParentColor := false;
      with TSkinRadioButton.create(subcomp) do
        init(self, self.fsd, self.fcanvas2, false);
    end;
    with TSkinGroupBox.create(comp) do
//       with TSkinBox.create(comp) do
      init(self, self.fsd, self.fcanvas2, true);
  end

  else if (cname = 'TDBNAVIGATOR') and (xcPanel in Fsd.SkinControls) then begin
         //setproperty(Comp,'Flat','True');
    with TSkinBox.create(comp) do
      init(self, self.fsd, self.fcanvas2, true);
    for i := 0 to Twincontrol(comp).ControlCount - 1 do begin
      subcontrol := Twincontrol(comp).Controls[i];
      if subcontrol is Tcontrol then
        addcomp(subcontrol, nil);
    end;
  end

  else if ((cname = 'TRZDBCHECKBOX') or (cname = 'TRZCHECKBOX')) and
    (xccheckbox in Fsd.SkinControls) then begin
    with TSkinObjimage.create(comp) do begin
      kind := 1;
      init(self, self.fsd, self.fcanvas2, true);
    end;
  end

  else if ((cname = 'TRZRADIOBUTTON') or (cname = 'TRZDBRADIOBUTTON')) and
    (xcradiobutton in Fsd.SkinControls) then begin
    with TSkinObjimage.create(comp) do begin
      kind := 2;
      init(self, self.fsd, self.fcanvas2, true);
    end;
  end

  else if ((cname = 'TCXDBCHECKBOX') or (cname = 'TCXCHECKBOX')) and
    (xccheckbox in Fsd.SkinControls) then begin
    with TSkinObjimage.create(comp) do begin
      kind := 3;
      init(self, self.fsd, self.fcanvas2, true);
    end;
  end

  else if ((Comp is TcustomGroupbox))
    and (xcPanel in Fsd.SkinControls) then begin
    self.InitChildCtrl(Comp as TWinControl);
    with TSkinGroupbox.create(comp) do
//       with TSkinbox.create(comp) do
      init(self, self.fsd, self.fcanvas2, false);
  end

  else if ((Comp is TRadioButton))
    and (xcRadioButton in Fsd.SkinControls) then begin
    with TSkinRadioButton.create(comp) do begin
      init(self, self.fsd, self.fcanvas2, false);
    end;
  end

     {else if (comp is TLabel) then begin
         setproperty(Comp,'Transparent','True');
     end}

  else if (Comp is TToolbar) and (xcToolbar in Fsd.SkinControls) then begin
    setproperty(Comp, 'Flat', 'True');
//         setproperty(Comp,'Transparent','True');
    if (xcToolbar in Fsd.SkinControls) then begin
      if not assigned(Ttoolbar(comp).OnCustomDrawButton) then
        Ttoolbar(comp).OnCustomDrawButton := ToolBarDrawButton;
      if not assigned(Ttoolbar(comp).OnCustomDraw) then
        Ttoolbar(comp).OnCustomDraw := ToolBarDrawBackground;
      with TSkinbox.create(comp) do
//            with TSkinToolbar.create(comp) do
        init(self, self.fsd, self.fcanvas2, false);
{$IFNDEF COMPILER_5}
      if Ttoolbar(comp).Menu <> nil then
        for j := 0 to Ttoolbar(comp).Menu.Items.count - 1 do
          inittoolbarmenu(TToolbar(comp).Menu.items[j], true);
{$ENDIF}
    end;
  end

{$IFNDEF COMPILER_5}
  else if ((Comp is TCustomStatusBar) and
    (xcStatusBar in Fsd.SkinControls)) then begin
{$ELSE}
  else if ((Comp is TStatusBar) and
    (xcStatusBar in Fsd.SkinControls)) then begin
{$ENDIF}
       //Tstatusbar(comp).sizegrip:=false;
    with TSkinStatusBar.create(comp) do begin
      init(self, self.fsd, self.fcanvas2, false);
    end;
  end

  else if ((Comp is TProgressBar) and
    (xcProgress in Fsd.SkinControls)) then begin
    with TSkinProgress.create(comp) do
      init(self, self.fsd, self.fcanvas2);
  end

  else if ((Comp is TScrollbar) and (xcScrollbar in Fsd.SkinControls)) then begin
    with TSkinScControl.create(comp) do
      initScrollbar(TWinControl(Comp), self.fsd, self.fcanvas2, self);
  end

  else if (cname = 'TTNTCOMBOBOX') and (xcCombo in Fsd.SkinControls) then begin
    with TSkinCombox.create(comp) do
      init(self, self.fsd, self.fcanvas2);
//        skin:=TSkinCombox.create(comp);
//        skin.inithwnd(TWinControl(Comp).handle,self.fsd,fcanvas2,self);
  end

  else if (comp is TCustomComboBox) and (xcCombo in Fsd.SkinControls) then begin
    with TSkinCombox.create(comp) do
      init(self, self.fsd, self.fcanvas2);
  end

  else if (comp is TDateTimePicker) and
    (xcedit in Fsd.SkinControls) then begin
    if (TDateTimePicker(comp).DateMode = dmUpDown) or
      (TDateTimePicker(comp).kind = dtkTime) then begin
      with TSkinEdit.create(comp) do
        init(self, self.fsd, self.fcanvas2);
    end else begin
//            with TSkinCombox.create(comp) do
      with TSkinDateTime.create(comp) do
        init(self, self.fsd, self.fcanvas2);
    end;
  end

  else if (xcScrollBar in Fsd.SkinControls) and
    ((cname = 'TRICHEDIT')) then begin
    with TSkinScrollBar.create(comp) do
      initScrollbar(TWinControl(Comp), self.fsd, self.fcanvas2, self);
  end

  else if (xcScrollBar in Fsd.SkinControls) and
    ((cname = 'TWWDBRICHEDIT') or (cname = 'TDXDBMEMO')) then begin
    with TSkinScrollBar.create(comp) do
      initScrollbar(TWinControl(Comp), self.fsd, self.fcanvas2, self);
  end

  else if (Comp is Tbitbtn) then begin
    if (xcbitbtn in Fsd.SkinControls) then begin
      with TSkinBitButton.create(comp) do
        init(self, self.fsd, self.fcanvas2);
    end else exit;
  end

  else if ((Comp is Tspeedbutton) and
    (xcSpeedButton in Fsd.SkinControls)) then begin
    with TSkinSpeedButton.create(comp) do
      InitGraphicControl(self, self.fsd, self.fcanvas2);
  end

  else if ((Comp is TCustomPanel))
    and (xcPanel in Fsd.SkinControls) then begin
    InitChildCtrl(Comp as TWinControl);
    with TSkinBox.create(comp) do
      init(self, self.fsd, self.fcanvas2, true);
  end

  else if ((cname = 'TDXTREELIST') or (cname = 'TDXDBTREELIST') or
    (cname = 'TDXDBGRID')) and (xcScrollBar in Fsd.SkinControls) then begin
    with TSkinScrollBar.create(comp) do
      initScrollbar(TWinControl(Comp), self.fsd, self.fcanvas2, self);
  end

  else if (Comp is TCustomListView)
    and (xcScrollBar in Fsd.SkinControls) then begin
    with TSkinlistview.create(comp) do
      initScrollbar(TWinControl(Comp), self.fsd, self.fcanvas2, self);
  end

  else if (xcScrollBar in Fsd.SkinControls)
    and (Comp is TCustomMemo) then begin
    with TSkinScrollBar.create(comp) do
      initScrollbar(TWinControl(Comp), self.fsd, self.fcanvas2, self);
  end

  else if (xcScrollBar in Fsd.SkinControls)
    and (Comp is TCustomgrid) then begin
    with TSkinScrollBar.create(comp) do
      initScrollbar(TWinControl(Comp), self.fsd, self.fcanvas2, self);
  end

  else if (xcScrollBar in Fsd.SkinControls)
    and (isscrollcontrol(Comp)) then begin
    with TSkinScrollBar.create(comp) do
      initScrollbar(TWinControl(Comp), self.fsd, self.fcanvas2, self);
  end

  else if ((Comp is TButton) and (xcButton in Fsd.SkinControls)) then begin
    with TSkinButton.create(comp) do
      init(self, self.fsd, self.fcanvas2);
  end

  else if ((Comp is TCustomEdit)) and
    (xcedit in Fsd.SkinControls) then begin
    skin := TSkinEdit.create(comp);
    skin.init(self, self.fsd, self.fcanvas2, false);
  end

  else if (cname = 'TDCEDIT') or (cname = 'TDCDBEDIT') then begin
    i := GetIntProperty(comp, 'NumButtons');
    if i = 1 then begin
      if (xcCombo in Fsd.SkinControls) then begin
        with TSkinCombox.create(comp) do
          init(self, self.fsd, self.fcanvas2);
      end
    end else if i = 0 then begin
      if (xcedit in Fsd.SkinControls) then begin
        skin := TSkinEdit.create(comp);
        skin.inithwnd(TWinControl(Comp).handle, self.fsd, fcanvas2, self);
      end;
    end;
  end

  else if (Comp is TCustomFrame) then
    self.InitControlA(Comp as TWinControl)
//       InitChildCtrl(Comp as TWinControl)

  else if (Comp is TCustomform) then begin
    with TSkinBox.create(comp) do
      init(self, self.fsd, self.fcanvas2, true);
    self.InitControlA(Comp as TWinControl);
  end;
end;

{procedure TWinSkinForm.InitControls(wForm: TWinControl);
var
  i, x,j,tag: integer;
  Comp: TComponent;
begin
  DeleteSkinDeleted;
  for i := 0 to wForm.ComponentCount - 1 do begin
     Comp := wForm.Components[i];
     if comp is Tcontrol then
         addcomp(Tcontrol(comp),wform);
  end;
end;}

procedure TWinSkinForm.InitControlA(wForm: TWinControl);
var
  i: integer;
  Comp: TComponent;
begin
  for i := 0 to wForm.ComponentCount - 1 do begin
    Comp := wForm.Components[i];
    if comp is Tcontrol then
      addcomp(Tcontrol(comp), wform);
  end;
  if (xcPopupmenu in fsd.SkinControls) then
    InitPopMenu(wform, true, true);
end;

procedure TWinSkinForm.InitChildCtrl(wForm: TWinControl);
var
  i: integer;
  Ctrl: TControl;
begin
  for i := 0 to wForm.controlCount - 1 do begin
    Ctrl := wForm.controls[i];
    addcomp(ctrl, wform);
  end;
end;

procedure TWinSkinForm.InitControls(wForm: TWinControl);
var
  i, n: integer;
  Ctrl: TWinControl;
  Comp: TComponent;
  list: Tlist;
  s: string;
begin
  DeleteSkinDeleted;
{  if xoNoPreview in fsd.Options then begin
      s := lowercase(fform.Name);
      if (pos('preview',s)>0) then exit;
  end;  }
  InitControlA(wform);
  list := Tlist.create;
  wform.GetTabOrderList(list);
  for i := 0 to list.Count - 1 do begin
    ctrl := list[i];
    if not FindSkinComp2(ctrl) then
      addcomp(ctrl, wform);
  end;
  list.Free;
end;

function TWinSkinForm.FindSkinComp2(ctrl: Twincontrol): boolean;
var
  isskin: integer;
  i: integer;
  sc: Tskincontrol;
begin
  result := true;

{$IFDEF CPPB_5}
  exit;
{$ENDIF}
{$IFDEF CPPB_6}
  exit;
{$ENDIF}

//   if ctrl=nil then exit;
//   ctrl.HandleNeeded;
  if not ctrl.HandleAllocated then exit;
  if ctrl.Tag = fsd.DisableTag then exit;
  isskin := sendmessage(ctrl.Handle, CN_IsSkined, 0, 0);
  if isskin = 1 then exit;
  for i := 0 to controllist.count - 1 do begin
    sc := Tskincontrol(controllist.items[i]);
    if sc.hwnd = ctrl.handle then begin
      result := true;
      break;
    end;
  end;
  result := false;
end;

procedure TWinSkinForm.InitNestform(wForm: Twincontrol);
var
  i, x, j, tag: integer;
  Comp: TComponent;
begin
  DeleteSkinDeleted;
  with TSkinBox.create(wform) do
    init(self, self.fsd, self.fcanvas2, true);
  for i := 0 to wForm.ComponentCount - 1 do begin
    Comp := wForm.Components[i];
    if comp is Tcontrol then
      addcomp(Tcontrol(comp), wform);
  end;
  InitPopMenu(wForm, true, true);
end;

procedure TWinSkinForm.DoSkinEdit(aEdit: Twincontrol);
var
  r1, r2: Trect;
  skin: TSkinControl;
begin
  getwindowrect(aedit.handle, r1);
  offsetrect(r1, -r1.left, -r1.Top);
  getClientrect(aedit.handle, r2);
  offsetrect(r2, -r2.left, -r2.Top);
  if (r1.Right = r2.Right) and (r1.bottom = r2.Bottom) then exit;
  skin := TSkinEdit.create(aEdit);
  skin.init(self, self.fsd, self.fcanvas2);
end;

function TWinSkinForm.Find3rdControl(aname: string; comp: Twincontrol): boolean;
var
  i, p: integer;
  s, s1, s2, s3: string;
  subcomp: Twincontrol;
  subcontrol: Tcontrol;
  skin: TSkinControl;
begin
  s1 := lowercase(aname) + '=';
  s2 := '';
  for i := 0 to fsd.skin3rd.count - 1 do begin
    s := lowercase(fsd.Skin3rd[i]);
    if (pos(s1, s) = 1) then begin
      p := pos('=', s);
      s2 := copy(s, p + 1, 50);
      break;
    end;
  end;

  result := false;
  if s2 = '' then exit;

  result := true;

  if (s2 = 'nil') then begin
    result := true;
  end
  else if (s2 = 'combobox') and (xcCombo in Fsd.SkinControls) then begin
    with TSkinCombox.create(comp) do
      init(self, self.fsd, self.fcanvas2);
  end
  else if (s2 = 'comboboxex') and (xcCombo in Fsd.SkinControls) then begin
    with TSkinCombox.create(comp) do begin
      init(self, self.fsd, self.fcanvas2);
      hasbutton := true;
    end;
  end
  else if (s2 = 'edit') and (xcedit in Fsd.SkinControls) then begin
    DoSkinEdit(comp);
//        skin:=TSkinEdit.create(comp);
//        skin.init(self,self.fsd,self.fcanvas2);
//        skin.inithwnd(TWinControl(Comp).handle,self.fsd,fcanvas2,self);
  end
  else if (s2 = 'radiobutton') and (xcRadioButton in Fsd.SkinControls) then begin
    with TSkinRadioButton.create(comp) do begin
      init(self, self.fsd, self.fcanvas2, false);
    end;
  end
  else if (s2 = 'panel') and (xcpanel in Fsd.SkinControls) then begin
    setproperty(Comp, 'Transparent', 'True');
    with TSkinBox.create(comp) do
      init(self, self.fsd, self.fcanvas2, true);
  end
  else if ((s2 = 'trackbar') and (xcbutton in Fsd.SkinControls)) then begin
    setproperty(Comp, 'Transparent', 'True');
    with TSkinTrackBar.create(comp) do
      init(self, self.fsd, self.fcanvas2);
  end
  else if ((s2 = 'button') and (xcButton in Fsd.SkinControls)) then begin
    with TSkinButton.create(comp) do begin
      init(self, self.fsd, self.fcanvas2);
    end;
  end
  else if ((s2 = 'datetimepicker') and (xcCombo in Fsd.SkinControls)) then begin
    with TSkinDateTime.create(comp) do begin
      init(self, self.fsd, self.fcanvas2);
    end;
  end
  else if ((s2 = 'mediaplayer') and (xcButton in Fsd.SkinControls)) then begin
    with TSkinMP.create(comp) do begin
      init(self, self.fsd, self.fcanvas2);
    end;
  end
  else if ((s2 = 'bitbtn') and (xcButton in Fsd.SkinControls)) then begin
    if s1 = 'tcxbutton=' then begin
      s3 := GetEnumProperty(comp, 'Kind');
      if s3 = 'cxbkDropDownButton' then begin
        with TSkinMenuButton.create(comp) do begin
          init(self, self.fsd, self.fcanvas2);
        end;
        result := true;
        exit;
      end;
    end;
    with TSkinbitButton.create(comp) do begin
      init(self, self.fsd, self.fcanvas2);
    end;
  end
  else if ((s2 = 'pngbitbtn') and (xcButton in Fsd.SkinControls)) then begin
    with TSkinbitButton.create(comp) do begin
      PicField := 'PngImage';
      init(self, self.fsd, self.fcanvas2);
    end;
  end
  else if ((s2 = 'pngspeedbutton') and (xcButton in Fsd.SkinControls)) then begin
    with TSkinSpeedButton.create(comp) do begin
      PicField := 'PngImage';
      InitGraphicControl(self, self.fsd, self.fcanvas2);
    end;
  end
  else if ((s2 = 'menubtn') and (xcButton in Fsd.SkinControls)) then begin
    with TSkinMenuButton.create(comp) do begin
      init(self, self.fsd, self.fcanvas2);
    end;
  end
  else if ((s2 = 'speedbutton') and (xcSpeedButton in Fsd.SkinControls)) then begin
    with TSkinSpeedButton.create(comp) do
      InitGraphicControl(self, self.fsd, self.fcanvas2);
  end
  else if (s2 = 'tab') and (xcTab in Fsd.SkinControls)
    and (fsd.tab <> nil) then begin
    skin := TSkinTab.create(comp);
    skin.init(self, self.fsd, self.fcanvas2, false);
//          TSkinTab(skin).inithwnd(TWinControl(Comp).handle,self.fsd,self.fcanvas2,self);
  end
  else if (s2 = 'progress') and (xcprogress in Fsd.SkinControls) then begin
    with TSkinProgress.create(comp) do
      init(self, self.fsd, self.fcanvas2);
  end
  else if (s2 = 'scrollbar') and (xcScrollBar in Fsd.SkinControls) then begin
    with TSkinScrollBar.create(comp) do
      initScrollbar(TWinControl(Comp), self.fsd, self.fcanvas2, self);
    InitChildCtrl(Comp as TWinControl);
      //InitControlA(Comp as TWinControl);
  end
  else if (s2 = 'singlescrollbar') and (xcScrollBar in Fsd.SkinControls) then begin
    with TSkinScrollBar.create(comp) do begin
      kind := 1;
      initScrollbar(TWinControl(Comp), self.fsd, self.fcanvas2, self);
    end;
  end
  else if (s2 = 'embedscrollbar') and (xcScrollBar in Fsd.SkinControls) then begin
    for i := 0 to TWincontrol(comp).ControlCount - 1 do begin
      subcomp := Twincontrol(Twincontrol(comp).Controls[i]);
      if subcomp is TScrollbar then begin
        with TSkinScControl.create(subcomp) do
          initScrollbar(TWinControl(subComp), self.fsd, self.fcanvas2, self);
      end else if isscrollcontrol(subComp) then begin
        with TSkinScrollBar.create(subcomp) do
          initScrollbar(TWinControl(subComp), self.fsd, self.fcanvas2, self);
      end;
    end;
  end
  else if (s2 = 'container') then begin
    InitChildCtrl(Comp as TWinControl);
{        for i := 0 to TWincontrol(comp).ControlCount-1 do begin
          subcontrol:=Twincontrol(comp).Controls[i];
          if subcontrol is Tcontrol then
            addcomp(subcontrol,nil);
          //if subcomp is Twincontrol then
          //  Find3rdControl(subcomp.classname,subcomp);
        end; }
  end
  else if (s2 = 'groupbox') and (xcgroupbox in Fsd.SkinControls) then begin
    with TSkinGroupBox.create(comp) do
      init(self, self.fsd, self.fcanvas2, true);
  end
  else if ((s2 = 'advpagecontrol')) and (xctab in Fsd.SkinControls) then begin
    with TSkinAdvPage.create(comp) do begin
      kind := 4;
      init(self, self.fsd, self.fcanvas2, true);
    end;
  end

  else if (s2 = 'radiogroup') and (xcgroupbox in Fsd.SkinControls) then begin
    if (xcradiobutton in Fsd.SkinControls) then begin
      for i := 0 to TWincontrol(comp).ControlCount - 1 do begin
        subcomp := Twincontrol(Twincontrol(comp).Controls[i]);
        if pos('TRZ', aname) = 0 then begin
          with TSkinRadioButton.create(subcomp) do
            init(self, self.fsd, self.fcanvas2, false);
        end else begin
          with TSkinObjimage.create(subcomp) do begin
            kind := 2;
            init(self, self.fsd, self.fcanvas2, true);
          end;
        end;
      end;
    end;
    if (xcgroupbox in Fsd.SkinControls) then
      with TSkinGroupBox.create(comp) do
        init(self, self.fsd, self.fcanvas2, true);
  end
  else if (s2 = 'checkgroup') and (xcpanel in Fsd.SkinControls) then begin
    if (xcradiobutton in Fsd.SkinControls) then begin
      for i := 0 to TWincontrol(comp).ControlCount - 1 do begin
        subcomp := Twincontrol(Twincontrol(comp).Controls[i]);
//            addcomp(subcomp,fform);
            //TAccontrol(subcomp).ParentColor := false;
        if pos('TRZ', aname) = 0 then begin
          with TSkinCheckbox.create(subcomp) do
            init(self, self.fsd, self.fcanvas2, false);
        end else begin
          with TSkinObjimage.create(subcomp) do begin
            kind := 1;
            init(self, self.fsd, self.fcanvas2, true);
          end;
        end;
      end;
    end;
    if (xcgroupbox in Fsd.SkinControls) then
      with TSkinGroupBox.create(comp) do
//       with TSkinBox.create(comp) do
        init(self, self.fsd, self.fcanvas2, true);
  end
  else if (s2 = 'checkbox') and (xcCheckBox in Fsd.SkinControls) then begin
    with TSkinCheckBox.create(comp) do
      init(self, self.fsd, self.fcanvas2, false);
  end
  else exit;
  result := true;
end;

procedure TWinSkinForm.InitHwndControls(ahwnd: Thandle);
var
  hctrl: Thandle;
begin
  hCtrl := GetTopWindow(ahWnd);

  while (hCtrl <> 0) do begin
    if (GetWindowLong(hCtrl, GWL_STYLE) and WS_CHILD) > 0 then begin
      AddControlh(hCtrl);
            //if (aname='#32770') then InitHwndControls(hctrl);
    end;
    hCtrl := GetNextWindow(hCtrl, GW_HWNDNEXT);
  end;
//   EnumChildWindows(hwnd, @enumcontrol, integer(self));
end;

function TWinSkinForm.Lookupcontrol(ahwnd: Thandle): Tskincontrol;
var
  c: Tskincontrol;
  i: integer;
begin
  result := nil;
  for i := 0 to controllist.count - 1 do begin
    c := Tskincontrol(controllist[i]);
    if c.hwnd = ahwnd then begin
      result := c;
      break;
    end;
  end;
end;

function EnumControl(ahwnd: HWND; lParam: LPARAM): boolean; stdcall;
var
  s: string;
  sf: Twinskinform;
begin
  result := false;
  sf := TWinskinform(lparam);
//   if (GetParent(ahwnd)= lparam) then begin
  sf.AddControlh(ahwnd);
  s := getwindowclassname(ahwnd);
//   skinaddlog(format('***enumchild %1x,%s',[ahwnd,s]));
  result := true;
//   end;
end;

procedure TWinSkinForm.AddControlh(ahwnd: HWND);
var
  Style, dwExStyle: dword;
  c: Tskincontrol;
  szBuf: array[0..MAX_CLASSNAME] of char;
  aname: string;
  control: TACwincontrol;
begin
  c := Lookupcontrol(ahWnd);
  if (ahWnd = 0) or (c <> nil) then exit;

  GetClassName(ahwnd, szBuf, MAX_CLASSNAME);
  aname := szbuf;
//   skinaddlog(aname);
  aname := lowercase(aname);
  Style := GetWindowLong(ahWnd, GWL_STYLE);
  dwExStyle := GetWindowLong(ahWnd, GWL_EXSTYLE);
  if (aname = 'button') and ((style and bs_ownerdraw) <> bs_ownerdraw) then begin
    if ((style and bs_groupbox) = bs_groupbox)
      or ((style and bs_bitmap) = bs_bitmap) then
      c := nil
    else
      if ((Style and BS_AUTOCHECKBOX) = BS_AUTOCHECKBOX)
        or ((Style and BS_CHECKBOX) = BS_CHECKBOX)
        or ((Style and BS_3STATE) = BS_3STATE) then begin
//               c:=nil
        if (xcCheckbox in Fsd.SkinControls) then
          c := Tskincheckbox.create(Self)
      end else if ((Style and BS_AUTORADIOBUTTON) = BS_AUTORADIOBUTTON)
        or ((Style and BS_RADIOBUTTON) = BS_RADIOBUTTON) then begin
        if (xcRadioButton in Fsd.SkinControls) then
          c := Tskinradiobutton.create(Self);
      end else if (xcButton in Fsd.SkinControls) then
        c := Tskinbutton.create(Self);
  end
  else if (aname = 'combobox') and (xcCombo in Fsd.SkinControls) then begin
    if ((Style and $03) <> CBS_SIMPLE) then
      c := TSkinCombox.create(Self);
  end
  else if (aname = 'comboboxex32') and (xcCombo in Fsd.SkinControls) then begin
    ahwnd := GetTopWindow(ahWnd);
    if ahwnd <> 0 then
      c := TSkinCombox.create(Self);
  end
  else if (aname = 'scrollbar') and ((Style and WS_TabStop) = 0) then begin
//        c := TSkinboxh.create(Self) ;
    c := TSkinSizer.create(Self);
  end
  else if (aname = 'systreeview32') then begin
        //syslistview32
//        c := TSkinScrollbarH.create(Self) ;
  end
  else if (aname = '#32770') and ((Style and WS_TabStop) = 0) then begin
    inithwndcontrols(ahwnd);
    c := TSkinboxh.create(Self);
  end

  else if (aname = 'tpanel') or (aname = 'ttntpanel.unicodeclass')
    or (aname = 'ttntsilentpaintpanel.unicodeclass') then begin
    inithwndcontrols(ahwnd);
    control := TACWincontrol(FindControlx(ahwnd));
    if control <> nil then
      control.color := fsd.colors[csButtonFace];
  end
  else if (aname = 'tcheckbox') and (xcCheckbox in Fsd.SkinControls) then begin
    c := Tskincheckbox.create(Self);
  end
  else if (aname = 'tcombobox') and (xcCombo in Fsd.SkinControls) then begin
    c := TSkinCombox.create(Self);
  end
  else if (aname = 'tbutton') and (xcButton in Fsd.SkinControls) then begin
    c := Tskinbutton.create(Self);
  end
  else if (aname = 'tprogressbar') then begin
    c := TSkinProgress.create(Self);
  end
  else if (aname = 'tsilentpaintpanel') then begin
    control := TACWincontrol(FindControlx(ahwnd));
    if control <> nil then
      control.color := fsd.colors[csButtonFace];
  end
  else if (aname = 'systabcontrol32') and (xcTab in Fsd.SkinControls)
    and ((Style and TCS_OWNERDRAWFIXED) <> TCS_OWNERDRAWFIXED) then begin
    c := TSkinTab.create(Self);
  end
  else if (aname = 'toolbarwindow32') then begin
    c := TSkinboxh.create(Self);
  end
  else if (aname = 'edit') and (xcEdit in Fsd.SkinControls) then begin
    c := TSkinedit.create(Self);
  end;

  if c <> nil then begin
    c.inithwnd(ahwnd, fsd, fcanvas2, self);
//     controllist.add(c);
//     skinaddlog(format('***add control %1x,%s',[ahwnd,aname]));
  end;
end;

procedure TWinSkinForm.Refresh;
begin
  SetWindowPos(hwnd, 0, 0, 0, 0, 0,
    SWP_DRAWFRAME or SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE or SWP_NOZORDER);
end;

procedure TWinSkinForm.InitSkinData;
var
  i, cw: integer;
begin
  if fsd.empty then exit;
//   GetClientRect(hwnd,fClientRect);
  if (formborder <> sbsnone) then begin
    bw.top := fsd.border[3].map.height div fsd.border[3].frame;
    bw.left := fsd.border[1].map.width div fsd.border[1].frame;
    bw.right := fsd.border[2].map.width div fsd.border[2].frame;
    bw.bottom := fsd.border[4].map.height div fsd.border[4].frame;
  end else begin
    bw := rect(0, 0, 0, 0);
//      bw:= rect(2,2,2,2);
    MenuHeight := 0;
  end;

{   if (menu=nil) then begin
     cw:= GetSystemMetrics(SM_CYCAPTION)+GetSystemMetrics(SM_CXFRAME);
     if (cw>bw.top) then
        menuheight := cw-bw.Top
     else menuheight:=0;
   end ;   }

  deletesysbtn;
  BtnCount := length(fsd.sysbtn);
  setlength(sysbtn, BtnCount);
  for i := 0 to BtnCount - 1 do begin
    sysbtn[i] := TWinsysbutton.create;
    sysbtn[i].data := fsd.sysbtn[i];
    sysbtn[i].sf := self;
    sysbtn[i].enabled := true;
    if fsd.sysbtn[i].action in [3, 11] then begin
      GetIcon(iconbmp);
          //copybmp(iconbmp,fsd.sysbtn[i].map);//fsd.sysicon);
      if sysbtn[i].data.map.empty then
        copybmp(iconbmp, fsd.sysbtn[i].map); //fsd.sysicon);
//             copybmp(fsd.sysicon,fsd.sysbtn[i].map);
//             copybmp(Iconbmp,fsd.sysbtn[i].map);
//             fsd.sysbtn[i].map.assign(Iconbmp);
      if fsd.sysicon.empty then
        copybmp(Iconbmp, fsd.sysicon);
      fsd.sysbtn[i].frame := 1;
    end;
  end;
end;

procedure TWinSkinForm.KeepClient;
var
  r1: Trect;
begin
  r1 := fform.ClientRect;
// Form Change Height
  fform.height := r1.bottom + bw.top + bw.bottom + menuheight;
// Form Change Width
  fform.width := r1.right + bw.left + bw.right;
end;

{ TODO : 修改Icon位置 }

procedure TWinSkinForm.DrawIcon(dc: HDC; rc: TRect);
var
  SmallIcon: HIcon;
  rc1: TRect;
  MidLine: Integer;
begin
  DefIcon := SendMessage(application.handle, WM_GETICON, ICON_SMALL, 0);
  if DefIcon = 0 then
    DefIcon := SendMessage(application.handle, WM_GETICON, ICON_BIG, 0);

  if deficon <> 0 then begin
    rc1.Left := 8;
      //rc1.Top:=8;
      //rc1.Top:= ((FTopBorderRect.Bottom- FTopBorderRect.Top)- Iconx) div 2;
    MidLine := FTitleRect.Top + (FTitleRect.Bottom - FTitleRect.Top) div 2; //与文字对称
    rc1.Top := MidLine - Iconx div 2;
    rc1.Right := Iconx;
    rc1.Bottom := Iconx;

    SmallIcon := CopyImage(DefIcon, IMAGE_ICON, iconx, iconx, LR_COPYFROMRESOURCE); //LR_CREATEDIBSECTION);// LR_COPYFROMRESOURCE);
    //DrawIconEx(dc,rc.Left,rc.Top, SmallIcon,iconx, iconx, 0, 0,DI_NORMAL);
    DrawIconEx(dc, rc1.Left, rc1.Top, SmallIcon, iconx, iconx, 0, 0, DI_NORMAL);
    DestroyIcon(SmallIcon);
  end else begin
    DrawTranmap(DC, rc, iconbmp);
//        DrawRect1(dc,rc,iconbmp,1,1,1) ;
  end;
end;

{procedure TWinSkinForm.DrawIcon(dc:HDC;rc:TRect);
var SmallIcon: HIcon;
begin
    if deficon<>0 then begin
       SmallIcon := CopyImage(DefIcon, IMAGE_ICON, iconx, iconx,LR_CREATEDIBSECTION);// LR_COPYFROMRESOURCE);
       DrawIconEx(dc,rc.Left,rc.Top, defIcon ,iconx, iconx, 0, 0,DI_NORMAL);
       DestroyIcon(SmallIcon);
    end;
end;}

procedure TWinSkinForm.GetIcon(var bmp: Tbitmap);
var
  SmallIcon: HIcon;
  cx, cy, i: Integer;
  sd: Tskindata;
begin
  cx := GetSystemMetrics(SM_CXSMICON);
  cy := GetSystemMetrics(SM_CYSMICON);
//      bmp.Assign(nil);
//      bmp.canvas.brush.color:=clFuchsia;
  bmp.width := cx;
  bmp.height := cy;
  bmp.PixelFormat := pf16bit;
  bmp.Canvas.Brush.color := clFuchsia;
  bmp.canvas.fillrect(rect(0, 0, cx, cy));
  iconx := cx;
      // First try a small icon, then a big icon
  DefIcon := SendMessage(hwnd, WM_GETICON, ICON_SMALL, 0);
  if DefIcon = 0 then
    DefIcon := SendMessage(hwnd, WM_GETICON, ICON_BIG, 0);

  if DefIcon <> 0 then begin
    SmallIcon := CopyImage(DefIcon, IMAGE_ICON, cx, cy, LR_COPYFROMRESOURCE);
    DrawIconEx(bmp.Canvas.Handle, 0, 0, SmallIcon,
      cx, cy, 0, 0, DI_MASK or DI_IMAGE); //DI_NORMAL);
    DestroyIcon(SmallIcon);
  end else if not fsd.sysicon.empty then begin //otherwise no icon found
         //cause DLL exception
         //bmp.assign(fsd.sysicon) ;
         //bmp.PixelFormat := pf24bit;
         //copybmp(sd.SysIcon,bmp);
  end else begin
    for i := 0 to skinmanager.dlist.count - 1 do begin
      sd := Tskindata(skinmanager.dlist.items[i]);
      if sd.skinformtype = sfMainform then begin
        if not sd.sysicon.empty then
                   //copybmp(sd.SysIcon,bmp);
                   //bmp.assign(sd.sysicon) ;
      end;
    end;
  end;
end;

function GetWindowClassname(ahwnd: Thandle): string;
var
  buf: array[0..MAX_CLASSNAME] of char;
begin
  GetClassName(ahwnd, buf, MAX_CLASSNAME);
  result := strpas(buf);
end;

procedure TWinSkinForm.doLog(msg: string);
var
  r: Trect;
begin
{$IFDEF test}
  exit;
  if msg = '' then exit;
//  if not skinmanager.menuactive then exit;
  if formstyle = sfsmdichild then exit;
//  if fform<>nil then
//  exit;

  msg := format('%s-%4x :%s WS:%1d', [caption, hwnd, msg, Ord(windowstate)]);
//  getwindowrect(hwnd,r);
//  msg:=msg+format(' W(W:%1d H:%1d)',[r.right-r.left,r.bottom-r.top]);
//  getclientrect(hwnd,r);
//  msg:=msg+format(' C(w:%1d h:%1d)',[r.right-r.left,r.bottom-r.top]);

//  msg:=msg+format(' (l:%1d r:%1d w:%1d h:%1d)',[r.left,r.top,r.right,r.bottom]);
//  if crop then msg:=msg+' Crop:True'
//  else msg:=msg+' Crop:False';
//  if hassysbtn then msg:=msg+' SysBtn:True'
//  else msg:=msg+' SysBtn:False';

  if SkinCanLog then Logstring.add(msg);
{$ENDIF}
end;

procedure TWinSkinForm.NewWndProc(var aMsg: TMessage);
const
  s = '    ';
var
  b: boolean;
begin
{$IFDEF test}
//     dolog(MsgtoStr(aMsg));
{$ENDIF}
  done2 := false;
  with aMsg do begin
    case Msg of
      CM_BEWAIT: begin
        // If message comes from Billenium Effects
          if aMsg.LParam = BE_ID then aMsg.Result := BE_ID
          else aMsg.Result := 1;
        end;
      CM_BENCPAINT: begin
          if amsg.LParam = BE_ID then begin
        // If a device context is provided then render the non client area in it
            if amsg.WParam <> 0 then
              updatenc(amsg.WParam);
            amsg.Result := BE_ID;
          end
        end;
      CM_DialogChar:
        CMDialogChar(amsg);
//      CM_RELEASE: postmessage(hwnd,wm_close,0,0);
     {CM_MENUCHANGED: begin
          OldWndProc(amsg);
          refresh;
          done2:=true;
        end;}
      CN_SkinChanged: begin
          SkinChange;
          done := true;
        end;
      WM_SETTEXT: begin
          if IsWindowVisible(hwnd) then begin
            // mdiform has problem, change caption when created
            {if isunicode or (formstyle=sfsmdichild)  then
               OldWndProc(amsg)
            else begin
              sendmessage(hwnd,WM_SETREDRAW,0,0);
              OldWndProc(amsg);
              sendmessage(hwnd,WM_SETREDRAW,1,0);
              Application.ProcessMessages;
            end;  }
            OldWndProc(amsg);
            if (windowstate = swsmax) then
              postmessage(skinmanager.clienthwnd, CN_NewMDIChild, hwnd, 0);
            if windowstate = swsmin then
              updatenc(0)
            else refresh;
          end else begin //visible=false
            OldWndProc(amsg);
          end;
          done2 := true;
        end;
    else OldWndProc(amsg);
    end;
  end;
//  if not Done2 then OldWndProc(amsg);
end;
//          RedrawWindow(hwnd,0,0,RDW_FRAME or RDW_INVALIDATE or RDW_UPDATENOW);

procedure TWinSkinForm.SkinChange;
var
  i: integer;
  c, fc: Twincontrol;
  sc: Tskincontrol;
  b: boolean;
begin
  fc := nil;
  b := false;
  if fform <> nil then begin
    fform.color := fsd.colors[csButtonFace];
    for i := 0 to fForm.ComponentCount - 1 do begin
      if fForm.Components[i] is Tcustomform then
        Tcustomform(fForm.Components[i]).color := fsd.colors[csButtonFace]
      else if fForm.Components[i] is TCustomGrid then
        TacGrid(fForm.Components[i]).fixedcolor := fsd.colors[csButtonFace];
    end;
//       fc:=fform.ActiveControl;
//       if fc<>nil then b:=fc.Focused;
  end;
  for i := 0 to controllist.count - 1 do begin
    sc := Tskincontrol(controllist.items[i]);
    sc.skinchange;
  end;
  SkinState := skin_change;
  if (sMainMenu) and (fform <> nil) then begin
    if fform <> nil then
      InitPopmenu(fform, true, true);
    ResizeForm(1);
//       SkinState:=skin_Active;
//       cropwindow;}
    fform.Height := fform.height + 1;
    fform.Height := fform.height - 1;
  end;
  AfterSkin;
//    if b and (fc<>Nil) then fc.SetFocus;
  SkinState := skin_Active;
//    skinaddlog('**********************skin change************');
end;

procedure TWinSkinForm.UnSubclass;
var
  w, h: integer;
  p: Tpoint;
  r2: Trect;
  style: dword;
begin
  if not sMainMenu then begin
    Unsubclass2;
    exit;
  end;

  if sysmenu <> nil then begin
    sysmenu.free;
    sysmenu := nil;
  end;
  timer.enabled := false;
  if fobjectinst = nil then exit;
  if (fform <> nil) and assigned(oldwndproc) then begin
    fform.WindowProc := OldWndProc;
    oldwndproc := nil;
  end;

  if isunicode then
    SetWindowLongW(hwnd, GWL_WNDPROC, LongInt(FPrevWndProc))
  else
    SetWindowLong(hwnd, GWL_WNDPROC, LongInt(FPrevWndProc));

  FreeObjectInstance(FObjectInst);
  fobjectinst := nil;
  DeleteControls;
  if fform <> nil then begin
    InitPopMenu(fform, false, false);
    if (xcMenuitem in fsd.SkinControls) then
      InitMainMenu(fForm, false, false);
    if Skinstate <> skin_Destory then
      fform.color := formcolor;
  end;
  UpdateStyle(false);
  EnableSysbtn(true);
  if menu <> nil then begin
    if hmenu <> menu.hmenu then
      SetMenu(Hwnd, menu.hmenu)
    else
      SetMenu(Hwnd, hmenu);
    menu.free;
    menu := nil;
  end;
  if FMDIObjectInst <> nil then begin
    unsubclassMDI;
  end;
     //captionbuf.assign(nil);

  GetWindowRect(hwnd, r2);
  p := point(r2.left, r2.top);
  if formstyle = sfsmdichild then
    screentoclient(skinmanager.clienthwnd, p);
  w := (r2.right - r2.left) - (bw.left + bw.right - oldsize.right);
  h := (r2.bottom - r2.top) - (bw.top + {menuheight+} bw.bottom - oldsize.bottom);
  if (Skinstate <> skin_Destory) and ((formstyle = sfsmdichild) or ((dwstyle and ws_child) = 0)) then
    SetWindowPos(hwnd, 0, p.x, p.y, w, h,
      SWP_DRAWFRAME or SWP_NOZORDER or SWP_NOACTIVATE);

  SetWindowRgn(hwnd, 0, true);
  if crop then begin //uncropwindow;
    deleteobject(winrgn);
    crop := false;
  end;
end;

procedure TWinSkinForm.UnSubclass3;
var
  w, h: integer;
  p: Tpoint;
  r2: Trect;
  style: dword;
begin
  if not sMainMenu then begin
    Unsubclass2;
    exit;
  end;

//  if fform<>nil then InitPopmenu(fform,false,false);
  if sysmenu <> nil then begin
    sysmenu.free;
    sysmenu := nil;
  end;
  timer.enabled := false;
  if fobjectinst = nil then exit;
  if (fform <> nil) and assigned(oldwndproc) then begin
    fform.WindowProc := OldWndProc;
    oldwndproc := nil;
  end;
  if fobjectinst <> nil then begin
    if isunicode then
      SetWindowLongW(hwnd, GWL_WNDPROC, LongInt(FPrevWndProc))
    else
      SetWindowLong(hwnd, GWL_WNDPROC, LongInt(FPrevWndProc));
    FreeObjectInstance(FObjectInst);
    fobjectinst := nil;
  end;
     //if mode=0 then
  DeleteControls;
  if menu <> nil then begin
    menu.free;
    menu := nil;
  end;
     //captionbuf.assign(nil);
end;

procedure TWinSkinForm.UnSubclass2;
var
  i: integer;
begin
  timer.enabled := false;
  DeleteControls;
  if fform <> nil then begin
    InitPopMenu(fform, false, false);
    if (xcMenuitem in fsd.SkinControls) then
      InitMainMenu(fForm, false, false);
    if Skinstate <> skin_Destory then fform.color := formcolor;
  end;
  if fobjectinst <> nil then begin
    if isunicode then
      SetWindowLongW(hwnd, GWL_WNDPROC, LongInt(FPrevWndProc))
    else
      SetWindowLong(hwnd, GWL_WNDPROC, LongInt(FPrevWndProc));
    FreeObjectInstance(FObjectInst);
    fobjectinst := nil;
  end;
  if FMDIObjectInst <> nil then begin
    unsubclassMDI;
  end;
  if fform = nil then exit;
  if Skinstate <> skin_Destory then
    for i := 0 to fForm.ComponentCount - 1 do begin
      if fForm.Components[i] is Tcontrol then
        Tcontrol(fForm.Components[i]).invalidate;
    end;
end;

procedure TWinSkinForm.AfterSkin;
var
  i: integer;
  sc: Tskincontrol;
begin
  SendMessage(Hwnd, CM_BERUN, 0, BE_ID);

  if assigned(fsd.OnAfterSkinForm) then
    fsd.OnAfterSkinForm(fform, hwnd, formclass);

  exit;

  if fform = nil then exit;
{$IFNDEF COMPILER_6_UP}
{   for i:= 0 to controllist.count-1 do begin
       sc:=Tskincontrol(controllist.items[i]);
       if assigned(sc.control) and (sc.control is Tscrollbox) then begin
          TSkinScrollbar(sc).vb.visible:=true;
          TSkinScrollbar(sc).hb.visible:=true;
          //control.invalidate;
       end;
   end; }
{$ENDIF}
end;

procedure TWinSkinForm.StopUpdate;
var
  dw: dword;
begin
  if not skinmanager.wmsetdraw then exit;
  if not ischildform and sMainMenu and (formborder <> sbsnone) then begin
    dw := GetWindowLong(hwnd, GWL_STYLE);
    dw := dw and not WS_VISIBLE;
    SetWindowLong(hwnd, GWL_STYLE, dw);
//       sendmessage(hwnd,WM_SETREDRAW,0,0);
  end;
end;

procedure TWinSkinForm.BeginUpdate;
var
  dw: dword;
begin
//    exit;
// has problem in virtual treeview demo, so give up
  if not skinmanager.wmsetdraw then exit;
    // only work for first form
  skinmanager.wmsetdraw := false;
  dw := GetWindowLong(hwnd, GWL_STYLE);
  if (dw and WS_VISIBLE) = 0 then begin
    dw := dw or WS_VISIBLE;
    SetWindowLong(hwnd, GWL_STYLE, dw);
  end;
{    if not ischildform  and  sMainMenu then begin
       sendmessage(hwnd,WM_SETREDRAW,1,0);
       Application.ProcessMessages;
       if IsWindowVisible(hwnd) then
          RedrawWindow(hwnd,0,0,RDW_INVALIDATE+RDW_INTERNALPAINT+RDW_ERASE);
    end;}
end;

procedure TWinSkinForm.WinWndProc(var aMsg: TMessage);
var
  b1, b2, b3, b4, b5: boolean;
  s: string;
begin
{$IFDEF test}
  s := MsgtoStr(aMsg);
  dolog(s);
{$ENDIF}

  if (skinstate = skin_Creating) then begin
    if (amsg.Msg = WM_NCPAINT) then begin
      amsg.Result := 0;
      exit;
    end;
  end;

  b3 := false;
  b4 := false;
  case amsg.Msg of
{      WM_STYLECHANGED : begin
          if amsg.wParam=GWL_STYLE then
            dwstyle:= PSTYLESTRUCT(amsg.lParam)^.styleNew;
          default(amsg);
          end;  }
//      WM_GETICON:   default(amsg);
    CN_IsSkined: begin
        amsg.result := 1;
//          fsd.DoDebug('CN_IsSkined');
        PostMessage(Hwnd, CM_BERUN, 0, BE_ID);
      end;
    174: amsg.Result := 0;
    WM_NCDESTROY: begin
//          skinaddlog('WM_NCDESTROY '+caption);
//          fsd.DoDebug('***WM_NCDESTROY '+caption);
        Skinstate := skin_Destory;
          //if ischildform then
        unsubclass3;
        default(amsg);
        Skinstate := skin_Deleted;
      end;
    WM_ERASEBKGND: WMERASEBKGND(aMsg);
    WM_CTLCOLORSTATIC: WMCtlcolor(amsg);
    WM_CTLCOLORBTN: begin
        default(amsg);
        if fform = nil then
          SetBkMode(amsg.wparam, TRANSPARENT);
      end;
    WM_INITMENUPOPUP: begin
        if amsg.WParam = hsysmenu then
          skinmanager.menutype := m_systemmenu
        else
          skinmanager.menutype := m_menuitem;
        default(amsg);
      end;
    WM_NCACTIVATE: begin
        if (skinstate = skin_Creating) and (formstyle <> sfsMDIChild) then
          amsg.Result := 0
        else if not sMainMenu then
          default(amsg)
        else b3 := true;
      end;
    CN_ReCreateWnd: begin
        WMReCreateWnd(amsg);
      end;
    CN_NewForm: begin
        factive := true;
//          GetClientRect(hwnd,fClientRect);
        hsysmenu := GetSystemMenu(hWnd, FALSE);
        geticon(iconbmp);
//          createsysmenu2;
        GetBorderSize;
        BeginUpdate();
        if fform <> nil then
          InitControls(fform)
        else InitHwndControls(hwnd);

        if (skinstate = skin_Creating) then begin
          if (formstyle = sfsmdichild) then begin
            if (windowstate = swsmax) then begin
//                  if not skinmanager.MDIMax then
//                     skinmanager.setmdimax(true);
              postmessage(skinmanager.clienthwnd, CN_NewMDIChild, hwnd, 0);
                 //postMessage(skinmanager.MDIForm.Handle, CN_FormUPdate, 0,0);
            end else if (windowstate = swsnormal) then begin
              skinstate := skin_Updating;
              resizeform(0);
              skinstate := Skin_Active;
                 //LockWindowUpdate(0);
              cropwindow;
            end else Enablesysbtn(true);
          end else begin
            if not (ischildform or (formborder = sbsnone))
              and (windowstate <> swsmin) then begin
              skinstate := skin_Updating;
              resizeform(0);
              skinstate := Skin_Active;
                 //LockWindowUpdate(0);
              if (windowstate = swsnormal) then cropwindow
              else refresh;
            end;
          end;
        end;
        AfterSkin;
        skinstate := Skin_Active;
        dolog('*****Skin Active finish');
          //if (fform<>nil) then fform.Perform(CM_ACTIVATE,0,0);
        timer.enabled := true;
      end;
  else begin
      if not sMainMenu then
        default(amsg)
      else b3 := true;
    end;
  end;
//  if not (xcMainMenu in fsd.SkinControls) then exit;
  //go, two message has handle
  if not b3 then exit;

  //embeded form
  if (not (formstyle = sfsmdichild)) and ((dwstyle and ws_child) > 0) and b3 then begin
    default(amsg);
    exit;
  end;

  b3 := false;
  b4 := false;
  case amsg.Msg of
    WM_SysCommand: WMSysCommand(amsg);
    WM_Command: WMCommand(amsg);
    WM_WINDOWPOSCHANGED: WMWINDOWPOSCHANGED(amsg);
    WM_NCACTIVATE: begin;
        fwindowactive := BOOLean(amsg.wParam);
        b3 := true;
      end;
    WM_ACTIVATE: begin;
        fwindowactive := BOOLean(amsg.wParam);
        b3 := true;
      end;
//      CN_UPdateMainMenu:updatemainmenu;
    WM_CTLCOLORSTATIC: WMCtlcolor(amsg);
    WM_CTLCOLORBTN: begin
        default(amsg);
        if fform = nil then
          SetBkMode(amsg.wparam, TRANSPARENT);
      end;
    WM_GETMINMAXINFO: WMGETMINMAXINFO(amsg);
    CM_MENUCHANGED: begin
        b5 := fsd.menumsg;
        fsd.menumsg := false;
        default(amsg);
        fsd.menumsg := b5;
        if (getmenu(hwnd) <> 0) then begin
          if (menu <> nil) and fsd.menuupdate then begin
            menu.hmenu := getmenu(hwnd);
                 //SetMenu(hwnd, 0);
            if fsd.MenuMerge then menu.updatabtn
            else menu.updatabtn;
          end;
          setmenu(hwnd, 0)
        end;
{           if (menu<>nil) and fsd.menuupdate
             and (getmenu(hwnd)<>0) then  begin
                 menu.hmenu := getmenu(hwnd);
                 //SetMenu(hwnd, 0);
                 if fsd.MenuMerge then  menu.updatabtn
                 else menu.updatabtn;
           end ;
           if (getmenu(hwnd)<>0) then setmenu(hwnd,0);  //remove menu}
      end;
    CN_MenuSelect: MenuSelect(amsg);
    WM_SIZE: WMSize(amsg);
    WM_SetICON: begin
        default(amsg);
        geticon(iconbmp);
      end;
//      WM_NCPAINT: WMNCPaint(amsg) ;
  else b3 := true;
  end;

  b1 := (formstyle = sfsmdichild) and (windowstate = swsmax); //<>swsnormal);
  b2 := false;
//  b2:=(windowstate=swsmin);

  if b1 or b2 or (skinstate = Skin_Creating) then begin
    if b3 then default(amsg);
    exit;
  end;

  case amsg.Msg of
    WM_NCPAINT: WMNCPaint(amsg);
    WM_NCACTIVATE: WMNcactive(amsg);
    WM_NCCALCSIZE: WMNCCalcSize(amsg);
    WM_SIZE: WMSize(amsg);
    WM_NCMouseMove: WMNCMouseMove(amsg);
    WM_NCLButtonDown: WMNCLButtonDown(amsg);
    WM_NCLBUTTONDBLCLK: WMNCLBUTTONDBLCLK(amsg);
    WM_NCLButtonUp: WMNCLButtonUp(amsg);
    WM_NCRBUTTONDOWN: WMNCRButtonUp(amsg);
//      WM_SysCommand: WMSysCommand(amsg);
//      WM_Command: WMCommand(amsg);
    WM_NCHitTest: WMNCHitTest(amsg);
    WM_MEASUREITEM: WMMEASUREITEM(amsg);
    WM_DRAWITEM: WMDRAWITEM(amsg);
    WM_WINDOWPOSCHANGING: WMWindowPosChanging(amsg);
//      WM_Paint:WMPaint(amsg);
//      WM_CTLCOLORSTATIC:WMCtlcolor(amsg);
    CN_FormUPdate: updatenc;
  else b4 := true;
  end;
  if b3 and b4 then default(amsg);
//    doLog('error');
end;

procedure TWinSkinForm.WMMDIACTIVATE(var aMsg: TMessage);
begin
  exit;
  if not skinmanager.mdimax then exit;
    //MDIChild DeActive
  if (formstyle = sfsmdichild) and (hwnd = amsg.wparam) then
    enablesysbtn(false);
  if (formstyle = sfsmdichild) and (hwnd = amsg.Lparam) then
    enablesysbtn(true);
end;
{procedure TWinSkinForm.WinWndProc(var aMsg: TMessage);
var
  Old: boolean;
begin
  Done := false;
  with aMsg do begin
    case Msg of
//      WM_ACTIVATE:WMactive(amsg) ;
      WM_NCPAINT: WMactive(amsg) ;
      WM_NCACTIVATE:WMNcactive(amsg) ;
      WM_NCCALCSIZE: WMNCCalcSize(amsg);
      WM_SIZE: WMSize(amsg);
      WM_NCMouseMove:WMNCMouseMove(amsg);
      WM_NCLButtonDown:WMNCLButtonDown(amsg);
      WM_NCLBUTTONDBLCLK :WMNCLBUTTONDBLCLK(amsg);
      WM_NCLButtonUp : WMNCLButtonUp(amsg);
      WM_NCRBUTTONDOWN : WMNCRButtonUp(amsg);
      WM_SysCommand: WMSysCommand(amsg);
      WM_Command: WMCommand(amsg);
      WM_NCHitTest:WMNCHitTest(amsg);
//      WM_INITMENU:WMINITMENU(amsg.wparam);
//      WM_INITMENUPopup:WMINITMENU(amsg.wparam);
//      WM_MEASUREITEM:WMMEASUREITEM(amsg);
      WM_DRAWITEM:WMDRAWITEM(amsg);
//      WM_Paint:WMPaint(amsg);
//      WM_WINDOWPOSCHANGED:WMWINDOWPOSCHANGED(amsg);
      WM_ERASEBKGND:WMERASEBKGND(aMsg);
      WM_CTLCOLORSTATIC:WMCtlcolor(amsg);
      WM_SETTEXT : begin
            dolog('WM_SETTEXT');
          end;
      CN_SkinChanged:begin
         resizeform(1);
         cropwindow;
         done:=true;
       end;
      WM_DESTROY: begin
        if FMDIObjectInst<>nil then unsubclassMDI;
        if fobjectinst<>nil then begin
           SetWindowLong(hwnd, GWL_WNDPROC,LongInt(FPrevWndProc));
           FreeObjectInstance(FObjectInst);
           fobjectinst:=nil;
           if crop then deleteobject(winrgn);
        end;
      end;
    end;
  end;
  if not Done then default(amsg);
//    doLog('error');
end;}

procedure TWinSkinForm.WMMDITile(var aMsg: TMessage);
  procedure setcaption(b: boolean);
  var
    i: integer;
    fm: Tform;
    dw: dword;
  begin
    for i := 0 to fform.MDIChildCount - 1 do begin
      fm := fform.MDIChildren[i];
      dw := GetWindowLong(fm.Handle, GWL_STYLE);
      if b then dw := dw or WS_CAPTION
      else dw := dwstyle and (not WS_CAPTION);
      SetWindowLong(fm.Handle, GWL_STYLE, dw);
    end;
  end;
begin
  setcaption(true);
  defaultMDI(amsg);
  setcaption(false);
end;

procedure TWinSkinForm.WinMDIProc(var aMsg: TMessage);
var
  s: string;
  mdidone, bmax: boolean;
  style, isskin: longint;
  b, b1: boolean;
  ahwnd: THandle;
begin
  s := '';
  mdidone := true;
  b := sMainmenu;
  case amsg.Msg of
    CN_NewMDIChild: begin
        RedrawWindow(hwnd, 0, 0,
          RDW_UPDATENOW or RDW_ALLCHILDREN or RDW_ERASE or RDW_FRAME or RDW_INVALIDATE);
      end;
    WM_NCDESTROY: begin
        defaultMDI(amsg);
        unsubclassMDI;
      end;
    WM_NCCALCSIZE: begin
        if b then begin
          Style := GetWindowLong(clienthwnd, GWL_STYLE);
          Style := style and (not WS_HSCROLL);
          Style := style and (not WS_VSCROLL);
          if not (xoMDIScrollbar in fsd.Options) then
            SetWindowLong(clienthwnd, GWL_STYLE, Style);
        end;
        defaultMDI(amsg);
      end;
    WM_MDIACTIVATE: begin
        defaultMDI(amsg);
      end;
    WM_MDICREATE: begin
           //mdi do not handle CM_MenuChange
        fsd.menuUpdate := false;
        defaultMDI(amsg);
           //newchildhwnd:=amsg.result;
      end;
    WM_MDIDESTROY: begin
           //s:='WM_MDIDESTROY '+format('%4x',[amsg.wparam]);
           //skinmanager.deleteform(amsg.wparam);
        defaultMDI(amsg);
        if b then begin
          skinmanager.setmdimax(MDIChildMax);
          ahwnd := sendmessage(clienthwnd, WM_MDIGETACTIVE, 0, longint(@b1));
          if (menu <> nil) and (ahwnd = 0) then begin
            fsd.menuUpdate := menuauto;
            menu.UpdataBtn;
          end;
        end;
      end;
    WM_MDICASCADE, WM_MDITILE: begin
        if b and (skinmanager.mdimax) then
          skinmanager.setmdimax(false);
        defaultMDI(amsg);
      end;
    WM_MDIREFRESHMENU: begin
        defaultMDI(amsg);
{            if (newchildhwnd<>0) then begin
              skinmanager.addform(newchildhwnd);
              postMessage(hwnd, CN_FormUPdate, 0,0);
              newchildhwnd:=0;
            end else begin
               ahwnd:=sendmessage(clienthwnd,WM_MDIGETACTIVE,0,longint(@b));
               if ahwnd<>0 then begin
                  isskin :=sendmessage(ahwnd,CN_IsSkined,0,0);
                  if isskin=0 then begin
                       skinmanager.addform(ahwnd);
                       postMessage(hwnd, CN_FormUPdate, 0,0);
                  end;
               end;
            end; }
      end;
         //older code , menu merger work.
{       WM_MDISETMENU : begin
           defaultMDI(amsg);
           if (menu<>nil) and (amsg.WParam<>0) then
                 menu.updatabtn2(amsg.WParam)
           else if (menu<>nil) then menu.updatabtn;
         end;}
    WM_MDISETMENU: begin
        defaultMDI(amsg);
           //DrawMenuBar(hwnd);
        if b then begin
          if (amsg.WParam <> 0) and (menu <> nil) then begin
                  //skinaddlog('WM_MDISETMENU*************');
                 //when child menu merge main menu, it do not call

                 //when active update,menu do not paint, menubutton.bounds=0,
                 //so call setmenurect;
            menu.updatabtn2(amsg.WParam); //getmenu(hwnd));
                  //bcb6 has bug
                  //menu.SetMenuRect;
          end;
          SetMenu(hwnd, 0);
        end;
      end;
  else defaultMDI(amsg);
  end;
//   if mdidone then defaultMDI(amsg);
//    if s<>'' then skinaddlog('**MDI: '+s);
end;

procedure TWinSkinForm.WMNCLBUTTONDBLCLK(var Msg: TMessage);
var
  P: TPoint;
  btn: TNCobject;
  b: boolean;
  i: integer;
begin
//  if not fwindowactive then exit;
  P := GetWinXY(msg.LParamLo, msg.LParamhi);

  btn := findbtn(p);

  b := false;
  if (btn <> nil) then begin
    i := TWinsysbutton(btn).data.Action;
    if (i = 3) or (i = 11) then begin
      timer.enabled := false;
      postmessage(hwnd, WM_SYSCOMMAND, SC_CLOSE, 0);
    end;
  end else begin
    if (windowstate <> swsnormal) then
      restore
    else if (sbiMax in formIcons) then
      maximize
    else default(msg);
  end;
  done := true;
end;

procedure TWinSkinForm.WMCtlcolor(var Msg: TMessage);
begin
  default(msg);
  if fform = nil then begin
    SetBkMode(msg.wparam, TRANSPARENT);
    msg.Result := fsd.BGBrush;
  end;
//   msg.Result:=fsd.BGBrush;
end;

procedure TWinSkinForm.Default(var Msg: TMessage);
begin
  msg.result := CallWindowProc(FPrevWndProc, hwnd, Msg.msg, msg.WParam, msg.LParam);
end;

procedure TWinSkinForm.WMNCActive(var Msg: TMessage);
var
  b, b1: boolean;
begin
{$IFDEF ver130}
  if Msg.WParamLo <> WA_INACTIVE then begin
//       ShowWindow(Application.Handle, SW_SHOWNORMAL);
  end;
{$ENDIF ver130}
  fwindowactive := BOOLean(msg.wParam);
  timer.enabled := fwindowactive;
  if (not timer.enabled) and (activeskincontrol <> nil) then begin
    activeskincontrol.mouseleave;
    activeskincontrol := nil;
  end;
  b := (formstyle = sfsmdichild) and (windowstate = swsmax); //<>swsnormal);
  if formstyle = sfsMDIform then begin
    sendmessage(Clienthwnd, WM_NCACTIVATE, msg.wparam, 0);
       //default(msg);
  end else if (formstyle = sfsMDIChild) then begin
    default(msg);
  end;
  if not b then updatenc;
  msg.result := 1;
end;

procedure TWinSkinForm.WMSize(var Msg: TMessage);
begin
  default(msg);
  case msg.wparam of
    SIZE_RESTORED: windowstate := swsnormal;
    SIZE_MINIMIZED: windowstate := swsmin;
    SIZE_MAXIMIZED: windowstate := swsmax;
  end;

  if windowstate = swsmin then exit;

  if (formstyle = sfsmdichild) and
    ((skinmanager.mdimax) or (windowstate <> swsnormal)) then exit;

  if (skinstate = skin_active) or (skinstate = skin_change) then
    cropwindow;
end;

procedure TWinSkinForm.WMGetMinMaxInfo(var Msg: TMessage);
var
  phwnd: Thandle;
  r: Trect;
  w: integer;
begin
//   enablesysbtn(true);
  default(msg);
  GetWindowstate;
  if windowstate = swsmin then
    enablesysbtn(true)
  else if (formstyle = sfsmdichild) then begin
        //restore from max
    if (windowstate = swsnormal) then begin
//           if (skinmanager.mdimax) then skinmanager.setmdimax(false);
      EnableSysbtn(false);
    end else if (windowstate = swsmax) then begin
          //cause MDIChild max-close problem
          //if not skinmanager.mdimax then  skinmanager.setmdimax(true);
      enablesysbtn(true);
    end;
  end else EnableSysbtn(false);

  //single no limit
//  if formborder=sbsSizeable then
{  with PMINMAXINFO(msg.lParam)^ do begin
     ptMaxTrackSize.x:=GetSystemMetrics(SM_CXMAXIMIZED);
     ptMaxTrackSize.y:=GetSystemMetrics(SM_CYMAXIMIZED);
  end;}
//  msg.result:=0;

{  if formborder = sbsSingle then
  with PMINMAXINFO(msg.lParam)^ do begin
     ptMaxTrackSize.y:=ptMaxTrackSize.y-8;
  end;}

//  skinaddlog(format('MINMAXINFO (%1d,%1d)',[PMINMAXINFO(msg.lParam)^.ptMaxTrackSize.x,
//                        PMINMAXINFO(msg.lParam)^.ptMaxTrackSize.y ]));
end;

function TWinSkinForm.FindBtn(Point: TPoint): TNcobject;
var
  i: integer;
begin
  Result := nil;
  for i := 0 to high(sysbtn) do begin
    if sysbtn[i].visible and (sysbtn[i].data.action >= 0) and
      PtInRect(sysbtn[i].bounds, Point) then begin
      Result := sysbtn[i];
      break;
    end;
  end;
end;

procedure TWinSkinForm.WMMouseMove(var Msg: TMessage);
begin
  if not fwindowactive then exit;
//   if activebtn<>-1 then begin
//       drawsysbtn(ActiveBtn,1);
//       ActiveBtn:=-1;
//   end;
end;

procedure TWinSkinForm.WMNCHitTest(var Msg: TMessage);
var
  p: Tpoint;
begin
  default(msg);

  if (Msg.Result = 0) or (Msg.Result = HTCAPTION) then begin
    P := getwinxy(msg.LParamLo, msg.LParamhi);
    if p.y > 3 then Msg.Result := HTCAPTION;
    if (p.y > bw.top) and (menuheight > 0) then
      Msg.Result := HTMENU;
//    fsd.DoDebug('hittest caption');
  end;
end;

function TWinSkinForm.GetWinXY(x, y: Smallint): Tpoint;
var
  WindowPos, ClientPos, p: TPoint;
begin
  p := point(x, y);
  screentoclient(hwnd, p);
  if (windowstate <> swsmin) or (formstyle <> sfsmdichild) then begin
    inc(p.x, bw.left);
    inc(p.y, bw.top + menuheight);
  end;
  result := p;
end;

procedure TWinSkinForm.HintReset();
begin
  fsd.hintcount := 0;
  fsd.HideHint();
end;

function TWinSkinForm.GetSysBtnHint(i: integer): string;
begin
  result := '';
  case i of
    1, 22: result := 'Maximize';
    2, 23: result := 'Minimize';
    7, 60: result := 'Minimize';
    8, 61: result := 'Restore';
    9, 0, 62: result := 'Close';
  else result := '';
  end;
end;

procedure TWinSkinForm.OnTimer(Sender: TObject);
var
  p, p1, p2: Tpoint;
  t: integer;
  s: string;
begin
  if finmenu then exit;
  if activebtn <> nil then begin
    GetCursorPos(p);
    P1 := GetWinXY(p.x, p.y);
    if not PtInRect(activebtn.bounds, p1) then begin
      if not IsBadReadPtr(activebtn, InstanceSize) then begin
        activebtn.mouseleave;
      end;
      activebtn := nil;
      hintreset();
    end else if not (ActiveBtn is TMenuBtn) then begin
      fsd.hintcount := fsd.hintcount + timer.Interval;
      t := Application.HintPause * 2;
      if (fsd.hintcount < t) then begin
      end else if (fsd.hintcount < (t + Application.HintHidePause)) then begin
        GetWindowRect(hwnd, wtr);
        p2 := Point(activebtn.bounds.Left + wtr.left, p.Y + 24);
        s := GetSysBtnHint(TWinsysbutton(activebtn).data.action);
        if (Length(s) > 0) then
          fsd.ActivateHint(Rect(p2.x, p2.y, 0, 0), s);
      end else begin
        fsd.HideHint();
      end;
    end;
  end;
  if (fform = nil) and (activeskincontrol <> nil) then begin
    GetCursorPos(p);
    if not ptinrect(activeskincontrol.boundsrect, p) then begin
      activeskincontrol.mouseleave;
      activeskincontrol := nil;
    end;
  end;
end;

procedure TWinSkinForm.WMNCMouseMove(var Msg: TMessage);
var
  P: TPoint;
  btn: TNCObject;
  b: boolean;
begin
  if not fwindowactive then exit;

  P := GetWinXY(msg.LParamLo, msg.LParamhi);

  btn := findbtn(p);
  if (btn = nil) and (menu <> nil) then btn := menu.findbtn(p);

  b := false;
  if btn <> nil then begin
    btn.mouseenter;
    b := true;
  end else begin
    if activebtn <> nil then begin
       //drawsysbtn(ActiveBtn,1);
      activebtn.mouseleave;
      activebtn := nil;
    end;
  end;

  if b then begin
    Msg.Result := 0;
    Msg.Msg := WM_NULL;
  end else default(msg);
end;

procedure TWinSkinForm.WMNCLButtonDown(var Msg: TMessage);
var
  P: TPoint;
  btn: TNCobject;
  b: boolean;
begin
//  if not fwindowactive then exit;
  P := GetWinXY(msg.LParamLo, msg.LParamhi);
  fsd.HideHint();

  btn := findbtn(p);
  if (btn = nil) and (menu <> nil) then btn := menu.findbtn(p);

  b := false;
  if (btn <> nil) then begin
    if not fwindowactive then
      SetForegroundWindow(hwnd);
    btn.mousedown;

    if btn is TMenuBtn then begin
      if lastselect then //mousemove select menu
        CheckMenu(TMenuBtn(Btn))
      else begin // click directly
             // (TMenuBtn(Btn).hsubmenu=0) then
             //stmessage(hwnd,wm_command,TMenuBtn(Btn).mid,0);
        CheckMenu(TMenuBtn(Btn));
      end;
      activebtn := btn;
    end;
    b := true;
  end;
  if b then begin
    Msg.Result := 0;
    Msg.Msg := WM_NULL;
  end else begin
    if (windowstate = swsmax) and (msg.wparam = HTCAPTION) and fwindowactive then
      msg.wparam := HTMENU;
    default(msg);
  end;
end;

procedure TWinSkinForm.WMNCLButtonUp(var Msg: TMessage);
var
  P: TPoint;
  btn: TNcobject;
  b: boolean;
begin
  P := GetWinXY(msg.LParamLo, msg.LParamhi);
  fsd.HideHint();

//  if msg.wparam=HTMENU	then btn := menu.findbtn(p)
//  else btn := findbtn(p);
  btn := findbtn(p);
  if (btn = nil) and (menu <> nil) then btn := menu.findbtn(p);

  b := false;
  if (Btn <> nil) then begin
    if btn is TWinSysbutton then begin
      if btn = activebtn then begin
        btn.mouseup;
        SysBtnAction(msg.LParamLo, msg.LParamhi);
      end;
    end else if btn is Tmenubtn then begin
//       postmessage(hwnd,wm_command,tmenubtn(btn).mid,0);
    end;
    b := true;
  end;

  if b then begin
    Msg.Result := 0;
    Msg.Msg := WM_NULL;
  end else default(msg);
end;

procedure TWinSkinForm.WMNCRButtonUp(var Msg: TMessage);
var
  b: boolean;
begin
  b := false;
  fsd.HideHint();

  if (msg.wparam = HTCAPTION) and (formstyle <> sfsMdichild) then begin
//  if (msg.wparam=HTCAPTION) then begin
//    sysmenu.popup(msg.LParamLo,msg.LParamhi);
    popsysmenu(point(msg.LParamLo, msg.LParamhi));
    b := true;
  end;

  if b then begin
    Msg.Result := 0;
    Msg.Msg := WM_NULL;
  end else default(msg);
end;

procedure TWinSkinForm.PopSysmenu(p: Tpoint);
var
  AFlags: Integer;
  i: integer;
begin
{    if sysmenu=nil then exit;
    for i:= 0 to sysmenu.items.count-1 do begin
       case sysmenu.Items.items[i].Tag of
         Sc_Restore:sysmenu.Items.items[i].enabled:= (windowstate<>swsnormal) ;
         SC_MAXIMIZE:sysmenu.Items.items[i].enabled:= (windowstate<>swsmax) and (sbimax in formicons);
         SC_MINIMIZE:sysmenu.Items.items[i].enabled:= (windowstate<>swsmin) and (sbimin in formicons);
       end;
    end;}
    //dll form right click problem.
  if skinmanager.mode <> 0 then exit;
  if (gettickcount - poptime) > DoubleTime then begin
    skinmanager.menutype := m_systemmenu;
    Aflags := TPM_LEFTALIGN or TPM_RIGHTBUTTON;
    poptime := gettickcount;
    createsysmenu2;
    if sysmenu <> nil then sysmenu.popup(p.x, p.y)
{       if (xcSystemMenu in fsd.SkinControls) and (formstyle<>sfsmdichild) then begin
             createsysmenu2;
             if sysmenu<>nil then sysmenu.popup(p.x,p.y)
       end else if hsysmenu<>0 then
        TrackPopupMenu(hsysmenu, aflags, p.x, p.y,0,hwnd,nil );}
  end else if (activebtn <> nil) then begin
    timer.enabled := false;
    postmessage(hwnd, wm_close, 0, 0);
  end;
end;

{procedure TWinSkinForm.WMPaint(var Msg: TMessage);
var  OldMode: integer;
     dc:HDC;
     PS: TPaintStruct;
begin
    dc:=msg.wparam;
    if dc=0 then
      msg.wparam:=BeginPaint(hwnd, PS);
    OldMode := SetBkMode(msg.wparam, TRANSPARENT);
    SetBkColor(msg.wparam,fsd.colors[csButtonFace]);
    default(msg);
    SetBkMode(msg.wparam, OldMode);
    if dc=0 then EndPaint(hwnd, PS);
    done:=true;
end;}

procedure TWinSkinForm.WMERASEBKGND(var Msg: TMessage);
var
  r: Trect;
begin
  default(msg);
  if (fform = nil) then begin
    GetClientRect(hwnd, r);
    FillRect(msg.wparam, r, fsd.BGbrush);
    Msg.Result := 1;
  end;
end;

procedure TWinSkinForm.WMMEASUREITEM(var Msg: Tmessage);
var
  ItemID: integer;
  b: boolean;
  mis: PMEASUREITEMSTRUCT;
  item: Tmenuitem;
  Canvas: TControlCanvas;
  dc: HDC;
  s: string;
  Buffer: array[0..79] of Char;
begin
//   default(msg);
  mis := PMEASUREITEMSTRUCT(msg.lparam);
  if (mis^.CtlType = ODT_MENU) and (hmenu <> 0) then begin
//      default(msg);
//      skinaddlog('MENU WMMEASUREITEM');
    if fform = nil then begin
      WMMEASUREITEMH(msg);
      exit;
    end;
    skinmanager.setpopmenu;
    if menu.menu <> nil then
      Item := Menu.Menu.FindItem(mis^.itemID, fkCommand)
    else item := nil;
    if Item <> nil then begin
      DC := GetWindowDC(hwnd);
      Canvas := TControlCanvas.Create;
      Canvas.Handle := DC;
      Canvas.Font := Screen.MenuFont;
      MeasureItem(item, Canvas, Integer(mis^.itemWidth), Integer(mis^.itemHeight));
      Canvas.Handle := 0;
      Canvas.Free;
      ReleaseDC(hwnd, DC);
      done := true;
    end else begin
           //only draw MDI windows menu.
      if (mis^.itemID < Max_MenuitemID) and (mis^.itemID > 0) then begin
        default(msg);
        exit;
      end;
      GetMenuString(activemenu, mis^.itemID, buffer, sizeof(buffer), MF_BYCOMMAND);
      s := buffer;
      DC := GetWindowDC(hwnd);
      Canvas := TControlCanvas.Create;
      Canvas.Handle := DC;
      Canvas.Font := Screen.MenuFont;
      mis^.itemWidth := canvas.TextWidth(s) + 26;
      if fsd.MenuItem <> nil then mis^.itemWidth := mis^.itemWidth + fsd.MenuItem.r.Left;
      Canvas.Handle := 0;
      Canvas.Free;
      ReleaseDC(hwnd, DC);
      if s = '' then
        mis^.itemHeight := 8
      else inc(mis^.itemHeight, 4);
      if (winversion >= $80000000) then
        inc(mis^.itemHeight, 4);
    end; //if
  end else default(msg);
end;

procedure TWinSkinForm.WMMEASUREITEMH(var Msg: Tmessage);
var
  ItemID: integer;
  b: boolean;
  mis: PMEASUREITEMSTRUCT;
  item: Tmenuitem;
  Canvas: TControlCanvas;
  dc: HDC;
  s: string;
  Buffer: array[0..79] of Char;
begin
//   default(msg);
  mis := PMEASUREITEMSTRUCT(msg.lparam);
  GetMenuString(activemenu, mis^.itemID, buffer, sizeof(buffer), MF_BYCOMMAND);
  s := buffer;
  DC := GetWindowDC(hwnd);
  Canvas := TControlCanvas.Create;
  Canvas.Handle := DC;
  Canvas.Font := Screen.MenuFont;
  mis^.itemWidth := canvas.TextWidth(s) + 26;
  if fsd.MenuItem <> nil then mis^.itemWidth := mis^.itemWidth + fsd.MenuItem.r.Left;
  Canvas.Handle := 0;
  Canvas.Free;
  ReleaseDC(hwnd, DC);
  if s = '' then
    mis^.itemHeight := 8
  else inc(mis^.itemHeight, 4);
  if (winversion >= $80000000) then
    inc(mis^.itemHeight, 4);
end;

procedure TWinSkinForm.WMDRAWITEM(var Msg: Tmessage);
var
  ItemID: integer;
  b: boolean;
  mis: PDrawItemStruct;
//    ahwnd:Thandle;
//    ptr:integer;
begin
  mis := PDrawItemStruct(msg.lparam);
  if (mis^.CtlType = ODT_MENU) and (hmenu <> 0) then begin
    if (formstyle = sfsmdiform) and (Win32Platform = VER_PLATFORM_WIN32_NT)
      and (Win32MajorVersion = 4) then begin
      default(msg);
      exit;
    end;

{      if newskinmenu<>nil then begin
         newskinmenu.hmenu:=mis^.hwndItem;
         newskinmenu:=nil
      end;}
    skinmanager.sethmenu(mis^.hwndItem);

    skinmanager.setPopmenu;
      //skinmanager.UpdateSkinMenu(mis^.hwndItem);
//      DrawHmenuItem(mis^.hDC,mis^.rcItem,mis^.itemid,mis^.hwndItem,(mis^.itemState and ODS_SELECTED)>0);
    if fform <> nil then
      WMDrawMenuitem(Msg)
    else
      WMDrawMenuitemH(Msg);
//      done:=true;
  end else default(msg);
end;

procedure TWinSkinForm.WMDrawMenuitem(var Msg: Tmessage);
var
  item, pitem: Tmenuitem;
  Canvas: TControlCanvas;
begin
  with PDrawItemStruct(Msg.LParam)^ do begin

    Item := Menu.Menu.FindItem(itemID, fkCommand);
    if (Item = nil) then begin
          //only draw MDI windows menuite
      if (itemid < Max_MenuitemID) and (itemid > 0) then begin
        default(msg);
        exit;
      end;
      Item := CreateMenuItem(hwndItem, itemid);
      Canvas := TControlCanvas.Create;
      Canvas.Handle := hDC;
      Canvas.Font := Screen.MenuFont;
      DrawHMenuItem2(hwndItem, item, canvas, rcitem, (itemState and ODS_SELECTED) > 0);
      Canvas.Handle := 0;
      Canvas.Free;
      item.free;
    end else begin;
      Canvas := TControlCanvas.Create;
      Canvas.Handle := hDC;
      Canvas.Font := Screen.MenuFont;
      if fsd.menuitem = nil then begin
        DefaultMenuItem(item, canvas, rcitem, (itemState and ODS_SELECTED) > 0);
      end else
        DrawMenuItem(item, canvas, rcitem, (itemState and ODS_SELECTED) > 0);
      Canvas.Handle := 0;
      Canvas.Free;
    end;
  end; //with
end;

procedure TWinSkinForm.WMDrawMenuitemH(var Msg: Tmessage);
var
  item, pitem: Tmenuitem;
  Canvas: TControlCanvas;
begin
  with PDrawItemStruct(Msg.LParam)^ do begin
    Item := CreateMenuItem(hwndItem, itemid);
    Canvas := TControlCanvas.Create;
    Canvas.Handle := hDC;
    Canvas.Font := Screen.MenuFont;
    DrawHMenuItem2(hwndItem, item, canvas, rcitem, (itemState and ODS_SELECTED) > 0);
    Canvas.Handle := 0;
    Canvas.Free;
    item.free;
  end;
end;

function TWinSkinForm.CreateMenuItem(amenu: Hmenu; aid: integer): Tmenuitem;
var
  item: Tmenuitem;
  mi: TMenuItemInfo;
  Buffer: array[0..79] of Char;
begin
  mi.cbSize := sizeof(TMENUITEMINFO);
  mi.fMask := MIIM_TYPE or MIIM_STATE;
  mi.dwTypeData := Buffer;
  Mi.cch := SizeOf(Buffer);
  GetMenuItemInfo(amenu, aid, false, mi);
  Item := Tmenuitem.create(nil);
  GetMenuString(amenu, aid, buffer, sizeof(buffer), MF_BYCOMMAND);
  item.caption := buffer;
  if item.caption = '' then item.caption := '-';
  item.enabled := (mi.fState and MFS_DISABLED) = 0;
  item.checked := (mi.fState and MFS_CHECKED) > 0;
  result := item;
end;

procedure TWinSkinForm.WMCommand(var Msg: Tmessage);
var
  ItemID: integer;
  b: boolean;
begin
  itemid := TWMCommand(msg).ItemID;
  case itemid of
    SC_CLOSE, SC_MAXIMIZE, SC_MINIMIZE, SC_RESTORE: b := true;
    SC_MOVE, SC_SIZE: b := true;
    SC_NEXTWINDOW, SC_PREVWINDOW: b := true;
  else b := false;
  end;
//   skinaddlog(format('__________WMCommand %1d %1d',[msg.wparam,msg.lparam]));
  if itemid >= $FF00 then begin
//      setmenu(hwnd,0);
    default(msg);
  end else if b then begin
    postmessage(hwnd, wm_syscommand, itemid, 0);
    exit;
  end else default(msg);
end;

procedure TWinSkinForm.WMINITMENU(hm: Hmenu);
var
  i, n, v: integer;
  mi: TMenuItemInfo;
  Buffer: array[0..79] of Char;
begin
  n := GetMenuItemCount(hm);
  for i := 0 to n - 1 do begin
    mi.cbSize := sizeof(TMENUITEMINFO);
    mi.fMask := MIIM_TYPE or MIIM_STATE or MIIM_SUBMENU;
//       mi.fType	:= MFT_STRING ;
    FillChar(buffer, SizeOf(buffer), 0);
    mi.dwTypeData := Buffer;
    Mi.cch := SizeOf(Buffer);
    GetMenuItemInfo(hm, i, TRUE, mi);

    mi.fMask := MIIM_TYPE;
    mi.fType := mi.fType or MFT_OWNERDRAW;
    SetMenuItemInfo(hm, i, TRUE, mi);
    if mi.hSubMenu <> 0 then WMINITMENU(mi.hSubMenu);
  end;
end;

procedure TWinSkinForm.WMReCreateWnd(var Msg: Tmessage);
var
  i: integer;
  hctrl: Thandle;
  sc: Tskincontrol;
  ss: Tskinscrollbar;
  sv: TSkinListView;
  comp: TWincontrol;
begin
  hctrl := msg.WParam;
  if controllist = nil then exit;
  for i := controllist.count - 1 downto 0 do begin
    sc := TSkinControl(Controllist.items[i]);
    if sc.hwnd = hctrl then begin
      comp := sc.control;
      if sc is TSkinListView then begin
        Controllist.Delete(i);
        sc.Free;
        sv := TSkinListView.create(comp);
        sv.initScrollbar(comp, self.fsd, self.fcanvas2, self);
      end else begin
        Controllist.Delete(i);
        sc.Free;
        ss := TSkinScrollBar.create(comp);
        ss.initScrollbar(comp, self.fsd, self.fcanvas2, self);
      end;
           //fsd.DoDebug('Received RecreateWnd');
      break;
    end;
  end;
end;

procedure TWinSkinForm.WMSysCommand(var Msg: Tmessage);
var
  Button: TMenuBtn;
  p: Tpoint;
begin
  if not FInMenu then begin
    with TWMSysCommand(msg) do begin
      if (CmdType and $FFF0 = SC_KEYMENU) and (Key <> VK_SPACE) and
        (Key <> Word('-')) and (GetCapture = 0) then begin
        if (Key = 0) and (menu <> nil) then
          Button := Menu.Buttons[0]
        else
          Button := FindButtonFromAccel(Key);
        if (Key = 0) or (Button <> nil) then
        begin
          CheckMenu(button);
//          TrackMenu(Button);
          Result := 1;
          exit;
        end;
      end else if (CmdType and $FFF0 = SC_KEYMENU) and (Key = VK_SPACE) then begin
        p := point(0, 0);
        clienttoscreen(hwnd, p);
        PopSysmenu(p);
      end;
    end; //end with
  end;

  case msg.wparam of
    SC_MAXIMIZE: begin
        windowstate := swsmax;
         {if formstyle=sfsmdichild then begin
            enablesysbtn(true);
            if not (skinmanager.mdimax) then
                skinmanager.setmdimax(true);
         end;  }
      end;
    SC_MINIMIZE: begin
        windowstate := swsmin;
        if formstyle = sfsmdichild then enablesysbtn(true);
      end;
    SC_RESTORE: begin
        windowstate := swsnormal;
        if formstyle = sfsmdichild then begin
          enablesysbtn(false);
          if (skinmanager.mdimax) then
            skinmanager.setmdimax(false);
        end;
      end;
  end;
  default(msg);
end;

procedure TWinSkinForm.Maximize;
begin
  if windowstate <> swsmax then begin
    if formstyle = sfsmdichild then
      SkinManager.SetMDIMax(true);
//      SetAnimation(false);
    windowstate := swsmax;
    postmessage(hwnd, wm_syscommand, SC_MAXIMIZE, 0);
    activebtn := nil;
  end else restore;
end;

procedure TWinSkinForm.Restore;
begin
  windowstate := swsnormal;
  postmessage(hwnd, wm_syscommand, SC_Restore, 0);
end;

procedure TWinSkinForm.RestoreMDI;
begin
  if fform.ActiveMDIChild <> nil then
    fform.ActiveMDIChild.windowstate := wsnormal;
end;

procedure TWinSkinForm.Minimize;
begin
  if windowstate = swsmin then
    restore
  else begin
//      SetAnimation(false);
    windowstate := swsmin;
    UpdateStyle(false);
//      ShowWindow(hwnd, SW_MINIMIZE);
    postmessage(hwnd, wm_syscommand, SC_MINIMIZE, 0);
//      postmessage(hwnd,WM_SHOWWINDOW,0,SW_PARENTCLOSING);
  end;
end;

procedure TWinSkinForm.SysBtnAction(x, y: smallint);
var
  i: integer;
begin
  i := TWinsysbutton(activebtn).data.action;
  case i of
    1, 22: if TWinsysbutton(activebtn).enabled then Maximize;
    2, 23: if TWinsysbutton(activebtn).enabled then Minimize;
    0: begin
        if checksysmenu then begin
          timer.enabled := false;
          postmessage(hwnd, WM_SYSCOMMAND, SC_CLOSE, 0);
              //postmessage(hwnd,wm_close,0,0);
        end;
      end;
    3, 11, 12: popsysmenu(point(x + 1, y + 1));
    4: postmessage(hwnd, WM_SYSCOMMAND, SC_CONTEXTHELP, 0);
    7, 60: MDIchildaction(61472); //SC_MINIMIZE);
    8, 61: MDIchildaction(SC_RESTORE);
    9, 62: MDIchildaction(SC_Close);
  else postmessage(hwnd, cn_captionBtnClick, i, 0);
  end;
end;

procedure TWinSkinForm.MDIChildAction(const action: Integer);
var
  b: boolean;
  ahwnd: Thandle;
  acomm: integer;
begin
//  SetAnimation(false);
  if (formstyle <> sfsMDIform) or (ClientHwnd = 0) then exit;
  acomm := action;
  //close last child,no action
//  if (action<>SC_Close) then
//          skinmanager.setmdimax(false);
  ahwnd := sendmessage(clienthwnd, WM_MDIGETACTIVE, 0, longint(@b));
  if (ahwnd = 0) then exit;
  sendmessage(ahwnd, wm_syscommand, acomm, 0);
{  if skinmanager.mdimax then begin
    if not MDIChildMax then skinmanager.setmdimax(false)
  end;}
end;

procedure TWinSkinForm.DoSysMenu(Sender: TObject);
begin
  case TMenuitem(Sender).tag of
    3: begin
        timer.enabled := false;
        postmessage(hwnd, wm_close, 0, 0);
      end;
    1: Maximize;
    2: Minimize;
    0: Restore;
  else begin
    end;
  end;
end;

procedure TWinSkinForm.DoSysMenu2(Sender: TObject);
begin
  postmessage(hwnd, wm_syscommand, TMenuitem(Sender).tag, 0);
end;

procedure TWinSkinForm.DrawSysbtn(btn: TWinSysButton; I: integer);
var
  w: integer;
  r: Trect;
  FWorkDC: HDC;
begin
  FWorkDC := GetWindowDC(hwnd);
  w := btn.data.map.width div btn.data.frame;
  if not btn.enabled then begin
    i := 4;
    if i > btn.data.frame then i := 1;
  end;
  r := rect((i - 1) * w, 0, i * w, btn.data.map.height);
  if btn.data.Visibility = 100 then begin
    if i = 3 then i := 4
  end;
  if btn.data.action in [3, 11] then
    DrawIcon(fworkdc, btn.bounds)
  else
    DrawRect1(FWorkDC, btn.bounds, btn.data.map, i, btn.data.frame, 1);
  ReleaseDC(hwnd, FWorkDC);
end;

procedure TWinSkinForm.WMWINDOWPOSCHANGED(var Msg: TMessage);
begin
  GetWindowstate;
  default(msg);
end;

procedure TWinSkinForm.WMWindowPosChanging(var Msg: TMessage);
begin
  default(msg);
end;

procedure TWinSkinForm.WMactive(var Msg: TMessage);
begin
  fwindowactive := BOOLean(msg.wParam);
  default(msg);
end;

procedure TWinSkinForm.WMMDIACTIVATE2(var Msg: TMessage);
var
  dwstyle: Dword;
begin
  dwstyle := GetWindowLong(hwnd, GWL_STYLE);
  SetWindowLong(hwnd, GWL_STYLE, dwstyle and (not WS_CAPTION));
  default(msg);
  SetWindowLong(hwnd, GWL_STYLE, dwstyle);
end;

procedure TWinSkinForm.WMNCPaint(var Msg: TMessage);
var
  dc: HDC;
begin
  UpdateStyle(true);
  if (fsd.menumsg) then begin
    if ((formstyle = sfsmdichild) and (windowstate = swsmax))
      or (formborder = sbsnone) then begin
      default(msg);
      exit;
    end;

    {dc := GetDCEx(hwnd, msg.wParam, DCX_WINDOW or DCX_INTERSECTRGN);
    updatenc(dc);
    ReleaseDC(hwnd, dc); }

    updatenc(0);
  end;
  msg.result := 0;
end;

procedure TWinSkinForm.UpdateNc(adc: HDC = 0);
var
  WR, R1: TRect;
  FWorkDC: HDC;
  b: boolean;
begin
  if bg = nil then exit;
  if (skinstate <> skin_active) and (skinstate <> skin_change) then exit;
  if (formborder = sbsnone) then exit;

  if (formstyle = sfsmdichild) and (windowstate = swsmax) then exit;
//    dolog(format('************Do UPdate NC %1d',[Ord(skinstate)]));
  if adc = 0 then
    FWorkDC := GetWindowDC(hwnd)
  else
    FWorkDC := adc;

  try
//       UpdateStyle(true);
    if GetWindowRect(hwnd, WR) then begin;
      wtr := wr;
      OffsetRect(wr, -wr.left, -wr.top);
      fwidth := wr.right;
      fheight := wr.bottom;
      if (windowstate <> swsmin) then begin
        drawborder(1, rect(0, 0, bw.left, wr.bottom), fworkdc);
        drawborder(2, rect(wr.right - bw.right, 0, wr.right, wr.bottom), fworkdc);
        drawborder(4, rect(bw.left, wr.bottom - bw.bottom, wr.right - bw.right, wr.bottom), fworkdc);
        DrawFLine(fworkdc);
        b := true;
        if (menu <> nil) and b then
          menu.drawmenu(fworkdc, rect(bw.left, bw.top,
            wr.right - bw.right, bw.top + menuheight))
        else if (menuheight > 0) then begin
          r1 := rect(bw.Left, bw.Top, wr.Right - bw.Right, bw.Top + menuheight);
          fillrect(fworkdc, r1, fsd.BGbrush);
        end;
      end else begin
        DrawFLine(fworkdc);
//             DrawMin(fworkdc);
      end;
    end;
  except
  end;
  activebtn := nil;
  if adc = 0 then
    ReleaseDC(hwnd, FWorkDC);
end;

procedure TWinSkinForm.UpdateStyle(b: boolean);
var
  exstyle: Dword;
  b2: boolean;
begin
  if sbicaption in formicons then exit;
  dwstyle := GetWindowLong(hwnd, GWL_STYLE);
  if false {(windowstate=swsmin)} then begin
    if (hsysmenu > 0) then
      dwstyle := dwstyle or WS_SYSMENU;
  end else begin;
    if b then
      dwstyle := dwstyle and (not WS_SYSMENU)
    else if (hsysmenu > 0) then
      dwstyle := dwstyle or WS_SYSMENU;
  end;
  SetWindowLong(hwnd, GWL_STYLE, dwstyle);
end;

procedure TWinSkinForm.UpdateMainMenu;
var
  WR, R1: TRect;
  FWorkDC: HDC;
  b: boolean;
begin
  if (menu = nil) then exit;
  FWorkDC := GetWindowDC(hwnd);
  GetWindowRect(hwnd, WR);
  wtr := wr;
  OffsetRect(wr, -wr.left, -wr.top);
  fwidth := wr.right;
  fheight := wr.bottom;
  menu.updataBtn;
  menu.drawmenu(fworkdc, rect(bw.left, bw.top,
    wr.right - bw.right, bw.top + menuheight));
  ReleaseDC(hwnd, FWorkDC);
end;

procedure TWinSkinForm.DrawFLine(dc: HDC);
var
  rc, r1, r2: Trect;
  h, x, y: integer;
begin
  rc := rect(0, 0, fwidth, bw.top);
  if windowstate = swsmin then begin
    CaptionBuf.height := fheight;
    CaptionBuf.width := fwidth;
    captionbuf.Canvas.Brush.color := fsd.colors[csbuttonface];
    captionbuf.canvas.fillrect(rect(0, 0, fwidth, fheight));
    //top border
    r1 := rect(0, 0, fwidth, bw.Top);
  end else begin
    CaptionBuf.height := rc.bottom;
    CaptionBuf.width := rc.right;
    BitBlt(CaptionBuf.canvas.handle, rc.left, rc.top, rc.right, rc.bottom,
      dc, 0, 0, Srccopy);
    r1 := rect(bw.left, 0, rc.right - bw.right, rc.bottom);
  end;
    //top border
  drawborder(3, r1, CaptionBuf.canvas.handle);
    //caption
  DrawLine(CaptionBuf.canvas, r1);

{$IFDEF demo}
  x := fsd.title.r.left + +15; //+fsd.title.backleft;
  y := ((r1.Bottom - r1.Top) - (fsd.logo.height)) div 2 +
    fsd.title.r.top div 2;
  CaptionBuf.canvas.draw(x, y, fsd.logo);
{$ENDIF}

    //sysbtn
  SetSysbtnRect;
  drawallsysbtn(CaptionBuf.canvas, rc);
  BitBlt(dc, rc.left, rc.top, CaptionBuf.Width, CaptionBuf.Height,
    CaptionBuf.canvas.handle, 0, 0, Srccopy);

//    H := GetSystemMetrics(SM_CYCAPTION)+GetSystemMetrics(SM_CXSIZEFRAME);
  SetBkMode(dc, OPAQUE);
end;

procedure TWinSkinForm.DrawMin(dc: HDC);
var
  rc, r1, r2: Trect;
  h, y: integer;
begin
  rc := rect(0, 0, fwidth, fheight);
  CaptionBuf.height := rc.bottom;
  CaptionBuf.width := rc.right;
  DrawRect2(CaptionBuf.canvas.handle, rc, fsd.MinCaption.Map,
    fsd.MinCaption.r, 1, 1);
    //caption
  r1 := rect(bw.left, 0, rc.right - bw.right, rc.bottom);
  DrawLine(CaptionBuf.canvas, r1);
    //sysbtn
  SetSysbtnRect;
  drawallsysbtn(CaptionBuf.canvas, rc);
  BitBlt(dc, rc.left, rc.top, rc.right, rc.bottom,
    CaptionBuf.canvas.handle, 0, 0, Srccopy);
  SetBkMode(dc, OPAQUE);
end;

procedure TWinSkinForm.DrawLine(acanvas: Tcanvas; rc: TRect);
var
  ws: widestring;
  r1, r2: Trect;
  OldMode, x, y, i: integer;
  OldFont: HFont;
  DrawStyle: Longint;
  BtnCounter, mleft: Integer;
begin
{$IFNDEF demo}
  if bidileft then
    DrawStyle := DT_NOPREFIX or DT_END_ELLIPSIS or DT_SINGLELINE or DT_Right or DT_RTLREADING
  else
    DrawStyle := DT_NOPREFIX or DT_END_ELLIPSIS or DT_SINGLELINE or DT_LEFT;
  ws := ' ';

  astr := ' ';
  if isunicode then
    ws := bstr + getformcaption(hwnd) + astr
  else
    ws := StrToWideStr(bstr + getformcaptionA(hwnd) + astr);

       // By Shraga Milon because there was a problem in
//    if bidileft then begin
  rightbtn := 0;
  for BtnCounter := 0 to high(sysbtn) do
    if (sysBtn[BtnCounter].data.Align = 1) and (not sysbtn[BtnCounter].data.map.empty) then begin
      if SysBtnVisible(BtnCounter) then begin
        if SysBtn[BtnCounter].data.XCoord > rightbtn then
          rightbtn := SysBtn[BtnCounter].data.XCoord;
      end;
    end;
//    end;

  acanvas.font := captionfont;
  OldMode := SetBkMode(aCanvas.Handle, TRANSPARENT);
  with acanvas do
  try
    if (fwindowactive) then begin
      font.color := fsd.colors[csTitleTextActive];
    end else begin
      font.color := fsd.colors[csTitleTextNoActive];
    end;
    r1 := rc;
//       DrawText(acanvas.Handle,PChar(bstr+Text+astr),length(bstr+Text+astr)
//                ,r1, DT_CALCRECT or DT_NOCLIP);
    TNT_DrawTextw(acanvas.Handle, ws, r1, DT_CALCRECT or DT_NOCLIP or DT_NOPREFIX);
    inc(r1.right, fsd.title.backleft + fsd.title.backright);
    x := 0;
    case fsd.title.Aligment of
      0: x := fsd.title.r.left;
      1: x := ((rc.right - rc.left) - (r1.right - r1.left)) div 2;
      2: x := (rc.right - rc.left - fsd.title.r.right - (r1.right - r1.left));
    end;

       // right button, caption button
    if bidileft then begin
      mleft := fsd.title.r.right;
          //some skin may have problem
          //if mleft<rightbtn+2 then
      mleft := rightbtn;
      case fsd.title.Aligment of
        2: x := fsd.title.r.left;
        1: x := ((rc.right - rc.left) - (r1.right - r1.left) - mLeft) div 2;
        0: x := (rc.right - rc.left - mLeft - (r1.right - r1.left));
      end;
    end;

    y := ((rc.Bottom - rc.Top) - (r1.Bottom - r1.Top)) div 2 +
      fsd.title.r.top div 2;
    offsetrect(r1, x, y);

    if bidileft and (x <= 0) then
      r1.left := fsd.title.r.left;

    if (dwstyle and ws_popup) = 0 then begin
          // Fix by Shraga Milon to bring closer the caption to the button
      if bidileft then
        OffsetRect(r1, 10, 0) // i add this to bring closer the caption to the button
      else if r1.right > rc.right - fsd.title.r.right then
        r1.right := rc.right - fsd.title.r.right;
    end else begin
      if bidileft then
        OffsetRect(r1, 10, 0) // i add this to bring closer the caption to the button
      else if (r1.right > rc.right - rightbtn - 5) and (rightbtn > 5) then
        r1.right := rc.right - rightbtn - 5;
    end;
    if (formborder = sbsDialog) and (fsd.title.Aligment = 0) then dec(r1.left, 16);
    ctr := r1;
    if not fsd.title.map.empty then begin
      if (not fwindowactive) then i := 2 else i := 1;
      DrawRectTile(acanvas, rect(r1.left, rc.top, r1.right, rc.bottom), fsd.title.map,
        rect(fsd.title.backleft, 0, fsd.title.backright, 0), i, 2, 1);
    end;

    inc(r1.left, fsd.title.backleft);
    dec(r1.right, fsd.title.backright);
    Tnt_DrawTextW(acanvas.Handle, ws, r1, DrawStyle);
    FTitleRect := r1;
  finally
    SetBkMode(aCanvas.Handle, OldMode);
  end;
{$ELSE}
  x := fsd.title.r.left + +15; //+fsd.title.backleft;
  y := ((rc.Bottom - rc.Top) - (fsd.logo.height)) div 2 +
    fsd.title.r.top div 2;
  acanvas.draw(x, y, fsd.logo);
{$ENDIF}
end;

procedure TWinSkinForm.SetSysbtnRect;
var
  i, j, w, y, minleft: integer;
  r1: Trect;
begin
  minleft := 0;
  for i := 0 to high(sysbtn) do
    if SysBtnVisible(i) and
      (not sysbtn[i].data.map.empty) then begin

      w := sysbtn[i].data.map.width div sysbtn[i].data.frame;
      r1 := rect(0, 0, w, sysbtn[i].data.map.height);
      with sysbtn[i].data do
        case Align of
          0: offsetrect(r1, XCoord, ycoord);
          1: begin
              offsetrect(r1, fwidth - XCoord, ycoord);
              if minleft < r1.Left then minleft := r1.left;
            end;
//         2: offsetrect(r1,xcoord,fheight-Ycoord);
//         3: offsetrect(r1,fwidth-xcoord,fheight-Ycoord);
          2, 8: offsetrect(r1, ctr.left - w - sysbtn[i].data.xcoord, ycoord);
          3, 9: offsetrect(r1, ctr.right + xcoord, ycoord);
          100: begin
              y := bw.top + (menuheight - r1.bottom) div 2;
              if fsd.menubar <> nil then
                offsetrect(r1, fwidth - xcoord - bw.right - fsd.menubar.r.left, y)
              else
                offsetrect(r1, fwidth - xcoord - bw.right, y);
{             if bidileft then begin
                if fsd.menubar<>nil then
                   offsetrect(r1,xcoord+bw.left+fsd.menubar.r.left,y)
                else
                   offsetrect(r1,xcoord+bw.left,y);
             end else begin
                if fsd.menubar<>nil then
                   offsetrect(r1,fwidth-xcoord-bw.right-fsd.menubar.r.left,y)
                else
                   offsetrect(r1,fwidth-xcoord-bw.right,y);
             end;}
            end;
        end;
      sysbtn[i].bounds := r1;
    end;
  if minleft > 0 then rightbtn := minleft;
end;

procedure TWinSkinForm.DrawAllSysbtn(acanvas: Tcanvas; rc: TRect);
var
  i, j: integer;
begin
  for i := 0 to High(sysbtn) do
    if SysBtnVisible(i) and (not sysbtn[i].data.map.empty)
      and (sysbtn[i].data.Visibility <> 100) then begin
//      and (sysbtn[i].data.CombineOp=-1) then begin
      if (fwindowactive) then j := 1 else j := 4;
      if (not sysbtn[i].enabled) then j := 4;
      if sysbtn[i].data.frame < 4 then j := 1;
      if sysbtn[i].data.action in [3, 11] then begin
        DrawIcon(aCanvas.Handle, sysbtn[i].bounds);
      end else
        DrawRect1(acanvas.handle, sysbtn[i].bounds, sysbtn[i].data.map, j, sysbtn[i].data.frame, 1);
    end;
end;

function TWinSkinForm.MDIChildMax: boolean;
var
  b: boolean;
  ahwnd: Thandle;
begin
  result := false;
  if (formstyle <> sfsMDIform) or (ClientHwnd = 0) then exit;
  ahwnd := sendmessage(clienthwnd, WM_MDIGETACTIVE, 0, longint(@b));
  if (ahwnd <> 0) and b then result := true;
end;

function TWinSkinForm.SysBtnVisible(i: integer): boolean;
var
  b: boolean;
begin
  case sysbtn[i].data.Visibility of
    -1: b := false;
    0: begin
        result := true; //always show
          //if (formborder = sbsDialog) then  result:=false;
//          if (sysbtn[i].data.action=0) and (not(sbisystem in formicons)) then
//               result:=false;
      end;
    1: result := WindowState = swsMax;
    2: result := WindowState <> swsMax;
    3: result := fwindowactive;
    4: result := not fwindowactive;

    6: begin
        result := ((sbiMin in formIcons) or (sbiMax in formIcons)) and (sbisystem in formicons);
//        sysbtn[i].enabled:= (sbiMax in formIcons) and (sbisystem in formicons);
      end;
    7: result := not (sbiMax in formIcons);
    8: result := ((sbiMin in formIcons) or (sbiMax in formIcons)) and (sbisystem in formicons);
    9: result := not (sbiMin in formIcons);
    100: result := MDIChildMax and (menu <> nil);
    10: result := (sbiHelp in formIcons)
      and (not ((sbiMin in formIcons) or (sbiMax in formIcons)));
//     11:result:= not(biHelp in BorderIcons);
{     100 :
       if (fform.FormStyle=fsMDIForm) and
          (fform.ActiveMDIChild<>nil) and
          (fform.ActiveMDIChild.windowstate=wsmaximized) then
             result:=true}
    200: result := (not ismessagebox) and (formborder = sbsDialog);
    201..999: result := true;
    1000..2000: begin
        result := sendmessage(hwnd, CN_CaptionBtnVisible,
          sysbtn[i].data.Visibility, sysbtn[i].data.action) > 0;
      end;
  else result := false;
  end;
  b := false;
  case sysbtn[i].data.Visibility1 of
    -1: b := false;
    0: b := true; //always show
    1: b := WindowState = swsMax;
    2: b := WindowState <> swsMax;
    3: b := fwindowactive;
    4: b := not fwindowactive;

    6: b := ((sbiMin in formIcons) or (sbiMax in formIcons)); //show with minbutton
    7: b := not (sbiMax in formIcons);
    8: b := ((sbiMin in formIcons) or (sbiMax in formIcons));
    9: b := not (sbiMin in formIcons);

    10: b := sbiHelp in formIcons;
//     11:b:= not(sbiHelp in formIcons);
    100: b := result;
    200: result := (not ismessagebox) and (formborder = sbsDialog);
    201..2000: result := true;
  end;
  result := result and b;

  case sysbtn[i].data.action of
    0: if not (sbisystem in formIcons) then
        result := false;
    1: sysbtn[i].enabled := (sbiMax in formIcons) and (sbisystem in formicons);
    2: sysbtn[i].enabled := (sbiMin in formIcons) and (sbisystem in formicons);
{     1: if not (sbiMax in formIcons) then
           result:= false;
     2: if not (sbiMin in formIcons) then
           result:=false;  }
    3, 11, 12: if (formborder = sbsDialog) then
        result := false;
  end;
  sysbtn[i].Visible := result;
end;

procedure TWinSkinForm.Drawborder(n: integer; Rc: Trect; dc: HDC);
var
  r: Trect;
  temp: Tbitmap;
  i, tile, sp: integer;
begin
  r := rc;
  offsetrect(r, -rc.left, -rc.top);
  if (r.right < 0) or (r.bottom < 0) then exit;

  if (not fwindowactive) then
    i := 2 else i := 1;
  if (fsd.border[n].frame = 1) then i := 1;

  if fsd.border[n].tile = 1 then tile := 0 else tile := 1;
  if n < 3 then sp := 0 else sp := 1;

{   if n<3 then begin
      DrawRectV(dc,rc,fsd.border[n].map,fsd.border[n].r,i,fsd.border[n].frame,tile,sp);
   end else
      DrawRectH(dc,rc,fsd.border[n].map,fsd.border[n].r,i,fsd.border[n].frame,tile,sp);}

  temp := GetHMap(r, fsd.border[n].map, fsd.border[n].r, I, fsd.border[n].frame,
    Tile, sp);

  BitBlt(dc, rc.left, rc.top, r.right, r.bottom,
    temp.Canvas.Handle, 0, 0, Srccopy);
  temp.free;
end;

procedure TWinSkinForm.Uncropwindow;
begin
  if crop then begin
       //captionbuf.assign(nil);
    deleteobject(winrgn);
//       skinstate:=skin_Creating;
    if formstyle = sfsmdichild then
      SetWindowRgn(hwnd, 0, true)
    else
      SetWindowRgn(hwnd, 0, false);
//       skinstate:=skin_Active;
    crop := false;
  end;
end;

procedure TWinSkinForm.cropwindow;
var
  rgn1, rgn2, rgn3, rgn4: HRGN;
  WR, r1: TRect;
  fbmp: Tbitmap;
  t1: dword;
begin
//   dolog(format('****%s Crop Window Start',[caption]));
//   if formstyle=sfsMDIchild then exit;

  if (skinstate = skin_Deleted) or (not sMainMenu) then exit;

  GetWindowRect(hwnd, WR);
  OffsetRect(wr, -wr.left, -wr.top);
  if wr.bottom * wr.right = 0 then exit;

  if (formstyle = sfsmdichild) and (windowstate <> swsnormal) then exit;
//   if (windowstate<>swsnormal) then exit;

  if (crwidth = wr.right) and (crheight = wr.bottom) then begin
    if (formstyle <> sfsmdichild) and (SkinState <> skin_change) then exit;
  end;

  if crop then deleteobject(winrgn);
  crop := false;

  if (fsd.border[1].trans + fsd.border[2].trans +
    fsd.border[3].trans + fsd.border[1].trans) = 0 then begin
    winrgn := CreateRectRgn(0, 0, wr.right, wr.bottom);
    SetWindowRgn(hwnd, WinRgn, true);
    crop := true;
    exit;
  end;
  t1 := gettickcount;
  crwidth := wr.right;
  crheight := wr.bottom;

  winrgn := CreateRectRgn(bw.left, bw.top,
    wr.right - bw.right, wr.bottom - bw.bottom);

  if formborder <> sbsnone then begin
    fbmp := Tbitmap.create;
    if (fsd.border[1].trans = 1) and (wr.bottom > 1) then begin
      r1 := rect(0, 0, bw.left, wr.bottom);
      fbmp.width := r1.right;
      fbmp.height := r1.bottom;
      drawborder(1, r1, fbmp.canvas.handle);
      rgn1 := BitmapToRegion(fbmp, 0, 0, clFuchsia);
    end else
      rgn1 := CreateRectRgn(0, 0, bw.left, wr.bottom);

    if (fsd.border[2].trans = 1) and (wr.bottom > 1) then begin
      r1 := rect(0, 0, bw.right, wr.bottom);
      fbmp.width := r1.right;
      fbmp.height := r1.bottom;
      drawborder(2, r1, fbmp.canvas.handle);
      rgn2 := BitmapToRegion(fbmp, wr.right - bw.right, 0, clFuchsia);
    end else
      rgn2 := CreateRectRgn(wr.right - bw.right, 0, wr.right, wr.bottom);

    if fsd.border[4].trans = 1 then begin
      r1 := rect(0, 0, wr.right - bw.left - bw.right, bw.bottom);
      fbmp.width := r1.right;
      fbmp.height := r1.bottom;
      drawborder(4, r1, fbmp.canvas.handle);
      if bw.bottom > 1 then
        rgn4 := BitmapToRegion(fbmp, bw.left, wr.bottom - bw.bottom, clFuchsia)
      else rgn4 := CreateRectRgn(bw.left, wr.bottom - bw.bottom,
          wr.right - bw.right, wr.bottom);
    end else
      rgn4 := CreateRectRgn(bw.left, wr.bottom - bw.bottom,
        wr.right - bw.right, wr.bottom);

    if (fsd.border[3].trans = 1) and (bw.top > 1) then begin
      r1 := rect(0, 0, wr.right - bw.left - bw.right, bw.top);
      if (r1.right > 0) and (r1.bottom > 0) then begin
        fbmp.width := r1.right;
        fbmp.height := r1.bottom;
        drawborder(3, r1, fbmp.canvas.handle);
        rgn3 := BitmapToRegion(fbmp, bw.left, 0, clFuchsia);
      end else
        rgn3 := CreateRectRgn(bw.left, 0, wr.right - bw.right, bw.top);
    end else
      rgn3 := CreateRectRgn(bw.left, 0, wr.right - bw.right, bw.top);

{      if (fsd.border[3].trans=1) and (bw.top>1) then begin
         r1:=rect(0,0,wr.right-bw.left-bw.right,bw.top);
         if (r1.right>0) and (r1.bottom>0) then begin
            fbmp.width:=r1.right;
            fbmp.height:=r1.bottom;
            if not captionbuf.empty then
              fbmp.canvas.copyrect(r1,captionbuf.canvas,rect(bw.left,0,r1.right+bw.left,r1.bottom))
            else   drawborder(3,r1,fbmp.canvas.handle);
            rgn3:=BitmapToRegion(fbmp,bw.left,0,clFuchsia);
         end else
         rgn3:= CreateRectRgn(bw.left,0,wr.right-bw.right,bw.top);
      end else
         rgn3:= CreateRectRgn(bw.left,0,wr.right-bw.right,bw.top);}

    CombineRgn(Rgn1, Rgn1, Rgn2, RGN_OR);
    CombineRgn(Rgn3, Rgn3, Rgn4, RGN_OR);
    CombineRgn(Rgn3, Rgn3, Rgn1, RGN_OR);
    CombineRgn(WinRgn, WinRgn, Rgn3, RGN_OR);
    DeleteObject(Rgn1);
    DeleteObject(Rgn2);
    DeleteObject(Rgn3);
    DeleteObject(Rgn4);
    fbmp.free;
  end;
  SetWindowRgn(hwnd, WinRgn, true);
//   SetWindowRgn(hwnd,WinRgn,false);

  crop := true;
{$IFDEF test}
  t1 := gettickcount - t1;
  doLog('crop window :' + inttostr(t1));
{$ENDIF}
end;

{procedure TWinSkinForm.cropwindow;
var  borderRgn : Thandle;
     WR: TRect;
     fbmp:Tbitmap;
     t1 : dword;
begin
   t1:=gettickcount;
   if crop then deleteobject(winrgn);

   fbmp:=Tbitmap.create;
   GetWindowRect(fform.Handle, WR);
   OffsetRect(wr,-wr.left,-wr.top);
   fwidth :=wr.right;
   fheight:=wr.bottom;

   fbmp.width:=wr.right;
   fbmp.height:=wr.bottom;
   fbmp.canvas.Brush.color := clBtnFace;
   fbmp.canvas.FillRect(wr);
//   fbmp.canvas.copyrect(wr,fform.canvas,wr);
   drawborder(1,rect(0,0,bw.left,wr.bottom),fbmp.canvas.handle);
   drawborder(2,rect(wr.right-bw.right,0,wr.right,wr.bottom),fbmp.canvas.handle);
   DrawFLine(fbmp.canvas.handle);
   //   drawborder(3,rect(bw.left,0,wr.right-bw.right,bw.top),fbmp.canvas);
   drawborder(4,rect(bw.left,wr.bottom-bw.bottom,wr.right-bw.right,wr.bottom),fbmp.canvas.handle);

   winrgn := BitmapToRegion(fbmp,0,0,clFuchsia);
   fbmp.free;
   SetWindowRgn(fform.Handle,WinRgn,True);
   crop:=true;
   t1:=gettickcount-t1;
   doLog('crop window :'+inttostr(t1));
end;}

procedure TWinSkinForm.getClipMap(fbmp: Tbitmap);
var
  WR: TRect;
begin
  GetWindowRect(fform.Handle, WR);
  OffsetRect(wr, -wr.left, -wr.top);
  fbmp.width := wr.right;
  fbmp.height := wr.bottom;
//   fillrect(fbmp.canvas.handle,wr,fsd
  fbmp.canvas.Brush.color := clBtnFace;
  fbmp.canvas.FillRect(wr);
  drawborder(1, rect(0, 0, bw.left, wr.bottom), fbmp.canvas.handle);
  drawborder(2, rect(wr.right - bw.right, 0, wr.right, wr.bottom), fbmp.canvas.handle);
  DrawFLine(fbmp.canvas.handle);
   //   drawborder(3,rect(bw.left,0,wr.right-bw.right,bw.top),fbmp.canvas);
  drawborder(4, rect(bw.left, wr.bottom - bw.bottom, wr.right - bw.right, wr.bottom), fbmp.canvas.handle);
end;

procedure TWinSkinForm.GetWindowstate;
var
  wp: WINDOWPLACEMENT;
begin
  wp.length := sizeof(WINDOWPLACEMENT);
  GetWindowPlacement(hWnd, @wp);
  case wp.showCmd of
    SW_MINIMIZE, SW_SHOWMINIMIZED, SW_SHOWMINNOACTIVE: windowstate := swsmin;
    SW_SHOWMAXIMIZED: windowstate := swsmax;
  else windowstate := swsnormal;
  end;
end;

procedure TWinSkinForm.GetFormstyle;
var
  hctrl: Thandle;
  aname: string;
  style: longint;
begin
  formstyle := sfsnormal;
  hCtrl := GetTopWindow(hWnd);
  while (hCtrl <> 0) do begin
    aname := getwindowclassName(hCtrl);
    if aname = 'MDIClient' then begin
      formstyle := sfsMDIform;
      clienthwnd := hctrl;
      skinmanager.clienthwnd := hctrl;
      skinmanager.MDIForm := fform;
      break;
    end;
    hCtrl := GetNextWindow(hCtrl, GW_HWNDNEXT);
  end;
end;

procedure TWinSkinForm.WMNCCalcSize(var Msg: TMessage);
var
  rgrc: PNCCalcSizeParams;
  WP: PWindowPos;
  wr, sr: Trect;
  s: string;
  style: uint;
  m_lLeft, m_lRight, m_lTop, m_lBottom: integer;
begin
  default(msg);
  if boolean(Msg.wParam) then begin
    rgrc := PNCCalcSizeParams(Msg.lParam);
    WP := rgrc^.lppos;
//    with rgrc^.rgrc[0] do
//      s:=format('%1d,%1d,%1d,%1d',[left,top,right,bottom]);
    if ((formstyle = sfsmdichild) and (windowstate <> swsnormal))
      or (formborder = sbsnone) then begin
      rgrc^.rgrc[1] := rgrc^.rgrc[0];
      Msg.lParam := longint(rgrc);
      Msg.Result := WVR_VALIDRECTS;
//       skinaddlog('Default WMNCCalcSize '+s);
      exit;
    end;

    with rgrc^.rgrc[0] do begin
      right := wp^.x + wp^.cx - bw.right;
      left := wp^.x + bw.left;
      top := wp^.y + bw.top + menuheight;
      bottom := wp^.y + wp^.cy - bw.bottom;
//      s:=format('%1d,%1d,%1d,%1d',[left,top,right,bottom]);
    end;
//    skinaddlog('*******Do WMNCCalcSize '+s);
    rgrc^.rgrc[1] := rgrc^.rgrc[0];
    Msg.lParam := longint(rgrc);
    Msg.Result := WVR_VALIDRECTS;
    Done := true;
  end else begin
    Msg.Result := 0;
  end;
end;

function msgtostr(aMsg: Tmessage): string;
var
  s, s1: string;
  i: integer;
begin
  s := '';
  with amsg do
    case Msg of
//      WM_STYLECHANGED:s:='WM_STYLECHANGED';
      WM_DESTROY: s := 'WM_DESTROY';
      WM_NCDESTROY: s := 'WM_NCDESTROY';
//      WM_NCHITTEST: ok:=false;//dolog('WM_NCHITTEST');
      WM_NCPAINT: s := 'WM_NCPAINT';
      WM_Paint: s := format('WM_Paint %1x', [amsg.wparam]);
      WM_NCACTIVATE: begin
          s := 'WM_NCACTIVATE';
          if BOOLean(wParam) then s := s + '  avtive'
          else s := s + ' Deavtive';
        end;
      WM_NCCALCSIZE: s := 'WM_NCCALCSIZE';
      WM_SIZE: begin
          s := 'WM_SIZE ';
          i := WParam;
          case i of
            SIZE_RESTORED: s := s + 'SIZE_RESTORED';
            SIZE_MINIMIZED: s := s + 'SIZE_MINIMIZED';
            SIZE_MAXIMIZED: s := s + 'SIZE_MAXIMIZED';
          end;
          s := s + format(' (%1d,%1d)', [LParamLo, LParamhi]);
        end;
      WM_MENUCHAR: s := 'WM_MENUCHAR';
      WM_WINDOWPOSCHANGED: begin
          s := 'WM_WINDOWPOSCHANGED';
        end;
      WM_ACTIVATE: begin
          s := 'WM_ACTIVATE';
          if LOWORD(amsg.wParam) = WA_INACTIVE then s := s + '  Deavtive'
          else s := s + ' avtive';
        end;
      WM_LBUTTONUP: s := 'WM_LBUTTONUP';
      WM_LBUTTONDOWN: s := 'WM_LBUTTONDOWN';
      WM_NCLButtonDown: s := 'WM_NCLButtonDown';
      WM_NCLButtonUp: s := 'WM_NCLButtonUp';
      WM_NCRButtonDown: s := 'WM_NCRButtonDown';
      WM_NCRButtonUp: s := 'WM_NCRButtonUp';
//      WM_NCMOUSEMOVE:s:='WM_NCMOUSEMOVE';
      WM_ERASEBKGND: s := 'WM_ERASEBKGND';
      WM_INITMENU: s := 'WM_INITMENU';
      WM_INITMENUPOPUP: s := 'WM_INITMENUPOPUP';
      WM_MENUSELECT: s := 'WM_MENUSELECT';
      WM_PRINTCLIENT: s := 'WM_PRINTCLIENT';
      WM_PRINT: s := 'WM_PRINT';
      WM_MEASUREITEM: s := 'WM_MEASUREITEM';
      WM_DRAWITEM: s := 'WM_DRAWITEM';
      WM_CTLCOLORSTATIC: s := format('WM_CTLCOLORSTATIC %1x', [amsg.wparam]);
//      WM_CTLCOLOREDIT :s:='WM_CTLCOLOREDIT';
      WM_CTLCOLOR: s := format('WM_CTLCOLOR %1x', [amsg.wparam]);
      WM_CTLCOLORBTN: s := format('WM_CTLCOLORBTN %1x', [amsg.wparam]);
      WM_HSCROLL: begin
          s := 'WM_HSCROLL';
        end;
      WM_VSCROLL: begin
          s := 'WM_VSCROLL';
          case amsg.WParamLo of
            SB_LINEUp: s := s + ' SB_LINEUp';
            SB_LINEDown: s := s + ' SB_LINEDown';
            SB_THUMBPOSITION: s := s + ' SB_THUMBPOSITION';
            SB_THUMBTRACK: s := s + ' SB_THUMBTRACK';
            SB_PAGEUp: s := s + ' SB_PAGEUp';
            SB_PAGEDown: s := s + ' SB_PAGEDown';
            SB_ENDSCROLL: s := s + ' SB_ENDSCROLL';
          end;
          s := s + format(' Pos:%1d', [amsg.WParamhi]);
        end;
      WM_INITDIALOG: s := 'WM_INITDIALOG';
      WM_SETTEXT: s := 'WM_SETTEXT';
      WM_COMMAND: s := 'WM_COMMAND';
      WM_MDIREFRESHMENU: s := 'WM_MDIREFRESHMENU';
      WM_GETMINMAXINFO: s := 'WM_GETMINMAXINFO';
      WM_CHILDACTIVATE: s := 'WM_CHILDACTIVATE';
      CN_NewForm: s := 'CN_SkinActive';
      CN_HSCROLL: s := 'CN_HSCROLL';
      WM_MOVE: s := 'WM_MOVE';
      WM_SETREDRAW: s := 'WM_SETREDRAW';
      CM_MENUCHANGED: s := 'CM_MENUCHANGED';
      WM_WINDOWPOSCHANGING: s := 'WM_WINDOWPOSCHANGING';
      WM_MDIACTIVATE: s := format('WM_MDIACTIVATE deactive:%1x, active:%1x', [amsg.wparam, amsg.lparam]);
      WM_PARENTNOTIFY: begin
          if WParamLo = WM_CREATE then s := s + format('WM_PARENTNOTIFY WM_CREATE %1x', [amsg.lparam]);
          if WParamLo = WM_DESTROY then s := s + format('WM_PARENTNOTIFY WM_DESTROY %1x', [amsg.lparam]);
        end;
      CBN_DROPDOWN: s := 'CBN_DROPDOWN';
    end;
//  if s='' then
//     s:=format('%4.0x,%04x,%04x',[amsg.msg,amsg.wparam,amsg.lparam]);
  if s <> '' then
    s := format('%s,%04x,%04x', [s, amsg.wparam, amsg.lparam]);
  result := s;
end;

procedure DrawBGbmp(acanvas: Tcanvas; Dst: Trect; Bitmap: TBitmap; SrcRect: TRect);
var
  i, j: integer;
  W, H: integer;
  b: Tbitmap;
begin
  W := SrcRect.right - srcrect.left;
  H := srcrect.bottom - srcrect.top;
  if (w < 0) or (h < 0) or (W * H = 0) then Exit;

  b := Tbitmap.create;
  b.width := w;
  b.height := h;
  b.canvas.copyrect(rect(0, 0, w, h), bitmap.canvas, srcrect);

  i := dst.left;
  while i < (dst.right) do
  begin
    j := dst.top;
    while j < (dst.Bottom) do
    begin
      aCanvas.Draw(i, j, b);
      Inc(j, h);
    end;
    Inc(i, w);
  end;

  b.free;
end;

procedure TWinSkinForm.ToolBarDrawBackground(Sender: TToolBar; const ARect: TRect; var DefaultDraw: Boolean);
var
  t: Ttoolbar;
  old: integer;
begin
  t := TToolbar(sender);
  if (fsd.Toolbar <> nil) and (not (xoToolbarBK in fsd.Options)) then begin
    old := SetStretchBltMode(t.Canvas.Handle, STRETCH_DELETESCANS);
    StretchBlt(t.Canvas.Handle,
      arect.left, arect.top, arect.right - arect.left, arect.bottom - arect.top,
      fsd.Toolbar.map.canvas.handle, 0, 0, fsd.Toolbar.map.Width, fsd.Toolbar.map.Height, SRCCOPY);
    SetStretchBltMode(t.Canvas.Handle, old);
  end;
//    DefaultDraw:=true;
end;

procedure TWinSkinForm.MeasureItem(Sender: TObject; ACanvas: TCanvas;
  var Width, Height: Integer);
var
  item: TMenuItemAccess;
  me: TMenuMeasureItemEvent;
  ImageList: TCustomImageList;
begin
  item := TMenuItemAccess(sender);
  ImageList := item.GetImageList;
  me := item.OnMeasureItem;
  item.OnMeasureItem := nil;
  item.MeasureItem(acanvas, width, height);
  if fsd.MenuItem <> nil then inc(width, fsd.MenuItem.r.Left);
  if Assigned(ImageList) then inc(width, 10)
  else inc(width, 35);
  item.OnMeasureItem := me;
end;
{
var item:Tmenuitem;
    s:string;
begin
   item:=TMenuItem(sender);
  if item.ShortCut <> 0 then
    s := Concat(item.Caption, ShortCutToText(item.ShortCut))
  else s := item.Caption;
   width:= acanvas.TextWidth(s)+26;

  if (item.Caption <> cLineCaption) then inc(height,4)
  else height:=8;
  if (winversion >= $80000000) then
       inc(height,4);
end;}

procedure TWinSkinForm.MeasureItemPop(Sender: TObject; ACanvas: TCanvas;
  var Width, Height: Integer);
var
  item: TMenuItemAccess;
  ImageList: TCustomImageList;
begin
  if fsd = nil then exit;
  item := TMenuItemAccess(sender);
  ImageList := item.GetImageList;
//    item.OnMeasureItem := nil;
//    item.MeasureItem(acanvas,width,height);
  try
    if (not IsBadReadPtr(fsd, fsd.InstanceSize)) and (fsd.MenuItem <> nil) then
      inc(width, fsd.MenuItem.r.Left);
  except
  end;
  if Assigned(ImageList) then inc(width, 12)
  else inc(width, 35);
//    item.OnMeasureItem := MeasureItempop;
{     inc(width,28);
     if (winversion >= $80000000) and
        (Tmenuitem(sender).Caption <> cLineCaption) then
      inc(height,4);}
end;

function TWinSkinForm.GetMenuBG: Tbitmap;
var
  ahwnd: Thandle;
  pmenu: Twinskinpopmenu;
begin
  result := nil;
  ahwnd := GetTopWindow(0);
  pmenu := Twinskinpopmenu(GetProp(ahwnd, c_menuprop));
  if pmenu <> nil then
    result := pmenu.menubg;
end;

procedure TWinSkinForm.DrawMenuItem(Sender: TObject; ACanvas: TCanvas; ARect: TRect;
  Selected: Boolean);
var
  i: integer;
  b, b1, temp: Tbitmap;
  rc, r1, r2: Trect;
  item: Tmenuitem;
begin
  skinmanager.setpopmenu;
  if fsd.menuitem = nil then begin
    DefaultMenuItem(sender, acanvas, arect, selected);
    exit;
  end;
  rc := arect;
  r1 := arect;
  offsetrect(r1, 3, 3);
  item := Tmenuitem(Sender);

{    if (newskinmenu<>nil) and assigned(item.parent) then begin
       newskinmenu.hmenu:=item.parent.handle;
       newskinmenu:=nil;
    end;}
  if assigned(item.parent) then begin
    skinmanager.sethmenu(item.parent.handle);
  end;
  offsetrect(rc, -rc.left, -rc.top);
  b := Tbitmap.create;
  b.width := rc.right;
  b.height := rc.bottom;
  b.Canvas.Font := Screen.MenuFont;

  temp := SkinManager.getmenubg(item.parent.handle);
//    temp:=getmenubg();
  if (temp <> nil) and (not temp.empty) then begin
    b.canvas.copyrect(rc, temp.canvas, r1);
//      fsd.DoDebug('DrawMenuItem');
  end else begin
    b.canvas.brush.color := fsd.colors[csMenubg];
    b.canvas.fillrect(rc);
  end;
  i := 1;
  if selected then i := 4;
  if item.caption <> cLineCaption then begin
    DrawRect2(b.canvas.handle, rc, fsd.menuitem.map,
      fsd.menuitem.r, i, 5, fsd.menuitem.trans, fsd.menuitem.tile);
    DrawItemText(Item, b.Canvas, rc, Selected);
    acanvas.draw(arect.left, arect.top, b);
  end else begin
    i := 2;
    acanvas.draw(arect.left, arect.top, b);
    DrawMenuCaption(ACanvas, arect);
  end;
  b.free;
end;

procedure TWinSkinForm.DrawMenuCaption(ACanvas: TCanvas; ARect: TRect);
var
  temp: Tbitmap;
  rc, r1, r2: Trect;
  w, h, x, y: integer;
begin
  temp := Tbitmap.create;
  rc := arect;
  offsetrect(rc, -rc.left, -rc.top);
  temp.width := rc.right;
  temp.height := rc.bottom;
  w := fsd.menuitem.map.width div 5;
  h := fsd.menuitem.map.height;
  if h > rc.bottom then y := h - rc.bottom
  else y := 0;
  x := w;
   //left
  r1 := rect(0, 0, fsd.menuitem.r.left, rc.bottom);
  r2 := rect(x, y, x + fsd.menuitem.r.left, h);
  temp.canvas.copyrect(r1, fsd.menuitem.map.canvas, r2);
   //right
  r1 := rect(rc.right - fsd.menuitem.r.right, 0, rc.right, rc.bottom);
  r2 := rect(w + x - fsd.menuitem.r.right, y, w + x, h);
  temp.canvas.copyrect(r1, fsd.menuitem.map.canvas, r2);
   //center
  r1 := rect(fsd.menuitem.r.left, 0, rc.right - fsd.menuitem.r.right, rc.bottom);
  r2 := rect(x + fsd.menuitem.r.left, y, w + x - fsd.menuitem.r.right, h);
  temp.canvas.copyrect(r1, fsd.menuitem.map.canvas, r2);
  temp.Transparent := true;
  temp.Transparentcolor := clFuchsia;
  acanvas.draw(arect.left, arect.top, temp);
  temp.free;
end;

procedure TWinSkinForm.DrawHMenuItem2(Amenu: Hmenu; Sender: TObject; ACanvas: TCanvas; ARect: TRect;
  Selected: Boolean);
var
  i: integer;
  b, b1, temp: Tbitmap;
  rc, r1, r2: Trect;
  item: Tmenuitem;
begin
  if fsd.menuitem = nil then begin
//       Drawmymenuitem(sender,acanvas,arect,selected);
    DefaultMenuItem(sender, acanvas, arect, selected);
    exit;
  end;
  rc := arect;
  r1 := arect;
  offsetrect(r1, 3, 3);
  item := Tmenuitem(Sender);

  offsetrect(rc, -rc.left, -rc.top);
  b := Tbitmap.create;
  b.width := rc.right;
  b.height := rc.bottom;
  b.Canvas.Font := Screen.MenuFont;

  temp := SkinManager.getmenubg(amenu);
    //temp:=getmenubg();
  if temp <> nil then
    b.canvas.copyrect(rc, temp.canvas, r1)
  else begin
    b.canvas.brush.color := fsd.colors[csMenubg];
    b.canvas.fillrect(rc);
  end;
  i := 1;
  if selected then i := 4;

  DrawRect2(b.canvas.handle, rc, fsd.menuitem.map,
    fsd.menuitem.r, i, 5, fsd.menuitem.trans, fsd.menuitem.tile);

  DrawItemText(Item, b.Canvas, rc, Selected);
  acanvas.draw(arect.left, arect.top, b);
  b.free;
end;

procedure TWinSkinForm.DefaultMenuItem(Sender: TObject; ACanvas: TCanvas; ARect: TRect;
  Selected: Boolean);
var
  i: integer;
  b, b1, temp: Tbitmap;
  rc, r1, r2: Trect;
  item: Tmenuitem;
begin
  rc := arect;
  item := Tmenuitem(Sender);
  offsetrect(rc, -rc.left, -rc.top);
  b := Tbitmap.create;
  b.width := rc.right;
  b.height := rc.bottom;
  b.Canvas.Font := Screen.MenuFont;

  if selected then
    b.canvas.brush.color := fsd.colors[csHilight]
  else b.canvas.brush.color := fsd.colors[csMenuBG]; //[csbuttonface];
  b.canvas.fillrect(rc);

  DrawItemText(Item, b.Canvas, rc, Selected);
  acanvas.draw(arect.left, arect.top, b);

  b.free;
end;

procedure TWinSkinForm.DoDrawText(item: Tmenuitem; ACanvas: TCanvas; const ACaption: widestring;
  var Rect: TRect; Selected: Boolean; Flags: Longint);
var
  Text: widestring;
  R: TRect;
  ParentMenu: TMenu;
  acolor: Tcolor;
  b: boolean;
begin
{  ParentMenu := Item.GetParentMenu;
  if (ParentMenu <> nil) and (ParentMenu.IsRightToLeft) then begin
    if Flags and DT_RIGHT = DT_RIGHT then
      Flags := Flags and (not DT_RIGHT) or DT_LEFT
    else if Flags and DT_LEFT = DT_LEFT then
      Flags := Flags and (not DT_LEFT) or DT_RIGHT;
    Flags := Flags or DT_RTLREADING;
  end;}
  Text := ACaption;
  if (Flags and DT_CALCRECT <> 0) and ((Text = '') or
    (Text[1] = cHotkeyPrefix) and (Text[2] = #0)) then Text := Text + ' ';
  with ACanvas do begin
    if Text = cLineCaption then begin
      if Flags and DT_CALCRECT = 0 then begin
        R := Rect;
        Inc(R.Top, 4);
        inc(r.left, 0);
        DrawEdge(Handle, R, EDGE_ETCHED, BF_TOP);
      end;
    end else begin
      Brush.Style := bsClear;
      if item.Default then
        Font.Style := Font.Style + [fsBold];
//      b:=item.Enabled;
//      if item.Action.
      if not item.Enabled then begin
        if fsd.colors[csbuttonshadow] <> fsd.colors[csMenuText] then
          Font.Color := fsd.colors[csbuttonshadow]
        else
          Font.Color := clBtnShadow;
      end else begin
        if Selected then begin
          Font.Color := fsd.colors[csHilightText];
        end else begin
          Font.Color := fsd.colors[csMenuText];
        end;
      end;
//      DrawText(Handle, PChar(Text), Length(Text), Rect, Flags);
      Tnt_DrawTextW(Handle, Text, Rect, Flags);
    end;
  end;
end;

procedure TWinSkinForm.DrawItemText(Item: TMenuitem; ACanvas: TCanvas;
  ARect: TRect; Selected: boolean);
const
  Alignments: array[TPopupAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
  EdgeStyle: array[Boolean] of Longint = (BDR_RAISEDINNER, BDR_SUNKENOUTER);
var
  ImageList: TCustomImageList;
  ParentMenu: TMenu;
  Alignment: TPopupAlignment;
  DrawImage, DrawGlyph: Boolean;
  GlyphRect, SaveRect: TRect;
  DrawStyle, DrawStyle2: Longint;
  Glyph: TBitmap;
  OldBrushColor: TColor;
  w: integer;
  text: widestring;

  procedure DrawItemRight;
  begin
    GlyphRect.right := ARect.right - 1;
    GlyphRect.Top := ARect.Top + 1;
    if fsd.MenuItem <> nil then glyphrect.right := glyphrect.right - fsd.MenuItem.r.Left;
    if item.Caption = cLineCaption then begin
      GlyphRect.Left := ARect.right;
      GlyphRect.Right := ARect.right; //-2;
      DrawGlyph := False;
    end else begin
      GlyphRect.left := GlyphRect.right - w;
      GlyphRect.Bottom := GlyphRect.Top + w;

      if (ImageList <> nil) and (item.ImageIndex > -1) and (item.ImageIndex < ImageList.Count) then begin
        if item.checked then begin
          OldBrushColor := Acanvas.Brush.Color;
          Acanvas.Brush.Bitmap := AllocPatternBitmap(clBtnFace, clBtnHighlight);
          acanvas.FillRect(GlyphRect);
              //acanvas.FrameRect(GlyphRect);
          Acanvas.Brush.Color := OldBrushColor;
          DrawEdge(acanvas.Handle, GlyphRect, BDR_SUNKENOUTER, BF_RECT);
        end;
        ImageList.Draw(ACanvas, GlyphRect.Left, GlyphRect.Top, item.ImageIndex,
          item.Enabled);
      end else if item.checked then begin
//              { Draw a menu check
        Glyph := TBitmap.Create;
        try
          Glyph.Transparent := True;
          Glyph.Handle := LoadBitmap(0, PChar(OBM_CHECK));
          OldBrushColor := acanvas.Font.Color;
          acanvas.Font.Color := clBtnText;
          acanvas.Draw(GlyphRect.Left + (GlyphRect.Right - GlyphRect.Left - Glyph.Width) div 2 + 1,
            GlyphRect.Top + (GlyphRect.Bottom - GlyphRect.Top - Glyph.Height) div 2 + 1, Glyph);
          acanvas.Font.Color := OldBrushColor;
        finally
          Glyph.Free;
        end;
      end;
    end;

    ARect.right := GlyphRect.left - 1;
    Inc(ARect.Left, 1);
    Dec(ARect.Right, 2);

//   DrawStyle := DT_EXPANDTABS or DT_SINGLELINE or Alignments[Alignment];
    DrawStyle := DT_EXPANDTABS or DT_SINGLELINE or DT_RIGHT or DT_RTLREADING;
    DrawStyle2 := DT_Left;
//       Calculate vertical layout

    SaveRect := ARect;
    DoDrawText(item, ACanvas, text, ARect, Selected, DrawStyle or DT_CALCRECT or DT_NOCLIP);
    OffsetRect(ARect, 0, ((SaveRect.Bottom - SaveRect.Top) - (ARect.Bottom - ARect.Top)) div 2);
    arect.Left := saverect.left;
    arect.right := saverect.Right;
    DoDrawText(item, ACanvas, text, ARect, Selected, DrawStyle);
    if (item.ShortCut <> 0) then begin
        //ARect.Right := ARect.left-2;
      ARect.Left := Saverect.left + 10;
        //ARect.Right := SaveRect.Right - 2;
      DoDrawText(item, ACanvas, ShortCutToText(item.ShortCut), ARect, Selected, DrawStyle2);
    end;
  end;
begin
//    if Assigned(item.Action) then item.Action.Update;

  text := GetStringProp(item, 'Caption');

  ParentMenu := item.GetParentMenu;
  ImageList := item.GetImageList;
  if (parentmenu = nil) and (menu <> nil) then
    parentmenu := menu.menu;

  Alignment := paLeft;
  if ParentMenu is TMenu then
    Alignment := paLeft
  else if ParentMenu is TPopupMenu then
    Alignment := TPopupMenu(ParentMenu).Alignment
  else Alignment := paLeft;

  w := 16;
  if (ImageList <> nil) then w := ImageList.Width;
    //else w:=2;
  if item.checked and (w < 16) then w := 16;
  if ParentMenu.IsRightToLeft then begin
    DrawitemRight;
    exit;
  end;

  GlyphRect.Left := ARect.Left + 1;
  GlyphRect.Top := ARect.Top + 1;
  if fsd.MenuItem <> nil then glyphrect.Left := glyphrect.Left + fsd.MenuItem.r.Left;
  if item.Caption = cLineCaption then begin
    GlyphRect.Left := 0;
    GlyphRect.Right := 0; //-2;
    DrawGlyph := False;
  end else begin
    GlyphRect.Right := GlyphRect.Left + w;
    GlyphRect.Bottom := GlyphRect.Top + w;

    if (ImageList <> nil) and (item.ImageIndex > -1) and (item.ImageIndex < ImageList.Count) then begin
      if item.checked then begin
        OldBrushColor := Acanvas.Brush.Color;
        Acanvas.Brush.Bitmap := AllocPatternBitmap(clBtnFace, clBtnHighlight);
        acanvas.FillRect(GlyphRect);
              //acanvas.FrameRect(GlyphRect);
        Acanvas.Brush.Color := OldBrushColor;
        GlyphRect.Top := arect.Top + ((Arect.Bottom - arect.Top) - 16) div 2;
        DrawEdge(acanvas.Handle, GlyphRect, BDR_SUNKENOUTER, BF_RECT);
      end else
        GlyphRect.Top := arect.Top + ((Arect.Bottom - arect.Top) - imagelist.Height) div 2;
      ImageList.Draw(ACanvas, GlyphRect.Left, GlyphRect.Top, item.ImageIndex,
        item.Enabled);
    end else if item.checked then begin
//              { Draw a menu check
      Glyph := TBitmap.Create;
      try
        Glyph.Transparent := True;
        Glyph.Handle := LoadBitmap(0, PChar(OBM_CHECK));
        GlyphRect.Top := arect.Top + ((Arect.Bottom - arect.Top) - glyph.Height) div 2;
        OldBrushColor := acanvas.Font.Color;
        acanvas.Font.Color := clBtnText;
        acanvas.Draw(GlyphRect.Left + (GlyphRect.Right - GlyphRect.Left - Glyph.Width) div 2 + 1,
          GlyphRect.Top + 1, Glyph);
        acanvas.Font.Color := OldBrushColor;
      finally
        Glyph.Free;
      end;
    end;
  end;

  ARect.Left := GlyphRect.Right + 1;
  Inc(ARect.Left, 2);
  Dec(ARect.Right, 1);

//   DrawStyle := DT_EXPANDTABS or DT_SINGLELINE or Alignments[Alignment];
  DrawStyle := DT_EXPANDTABS or DT_SINGLELINE or DT_Left;
  DrawStyle2 := DT_Right;
//       Calculate vertical layout

  SaveRect := ARect;
  DoDrawText(item, ACanvas, text, ARect, Selected, DrawStyle or DT_CALCRECT or DT_NOCLIP);
  OffsetRect(ARect, 0, ((SaveRect.Bottom - SaveRect.Top) - (ARect.Bottom - ARect.Top)) div 2);
//   arect.Left := saverect.left;arect.right:=saverect.Right;
  DoDrawText(item, ACanvas, text, ARect, Selected, DrawStyle);
  if (item.ShortCut <> 0) then begin
    ARect.Left := ARect.Right;
    ARect.Right := SaveRect.Right - 10;
    DoDrawText(item, ACanvas, ShortCutToText(item.ShortCut), ARect, Selected, DrawStyle2);
  end;
end;

procedure TWinSkinForm.ToolBarDrawButton(Sender: TToolBar;
  Button: TToolButton; State: TCustomDrawState; var DefaultDraw: Boolean);
var
  i: integer;
  r1: Trect;
begin
  if (fsd.button = nil) or (skinstate <> Skin_Active) or
    (xoToolbarButton in fsd.Options) then exit;

  i := 0;
  if cdsSelected in state then i := 2
  else if cdsFocused in state then i := 4
  else if cdsHot in State then i := 4
  else if cdsGrayed in state then i := 0
  else if cdsDisabled in state then i := 0
  else if cdsDefault in state then i := 1;

  if i = 0 then exit;

  if (i = 1) and (fsd.button.newnormal) then
    sender.canvas.Font.Color := fsd.button.normalcolor2;
  if (i = 4) and (fsd.button.newover) then
    sender.canvas.Font.Color := fsd.button.overcolor2;
  if (i = 2) and (fsd.Button.newdown) then
    sender.canvas.Font.Color := fsd.button.downcolor2;

  r1 := Button.BoundsRect;
  InflateRect(r1, -1, -1);
//    clientRgn :=CreateRectRgn(r1.left,r1.top,r1.right,r1.bottom);
//    SelectClipRgn(sender.canvas.HANDLE, clientRgn);

  if fsd.button <> nil then
    DrawRect2(sender.canvas.handle, r1, fsd.button.map,
      fsd.button.r, i, 5, fsd.button.trans);

{    if cdsSelected in state then i:=2
    else if cdsFocused in state then i:=4
    else if cdsHot in State  then i:=4
    else if cdsGrayed in state then i:=3
    else if cdsDisabled in state then i:=3
    else if cdsDefault in state then i:=5;

    r1:=Button.BoundsRect;

    if fsd.toolbar<>nil then
    DrawRect2(sender.canvas.handle,r1,fsd.toolbar.map,
       fsd.toolbar.r,i,5,fsd.toolbar.trans);}

//    DefaultDraw:=false;
end;

procedure TWinSkinForm.InitDlg(afsd: Tskindata);
begin
  InitSkin(afsd);
end;

destructor TWinSkinSpy.Destroy;
begin
//  skinaddlog('TWinSkinSpy Destory');
  inherited destroy;
end;

procedure TWinSkinSpy.Notification(AComponent: TComponent;
  Operation: TOperation);
var
  j: integer;
  sc: Tskincontrol;
begin
  inherited Notification(AComponent, Operation);
  //do nothing
//  if (Operation = opRemove) and (AComponent <> nil) and
//     (AComponent is TGraphicControl) then begin
//  end;
end;

function BitmapToRegion(bmp: TBitmap; xx, yy: integer; TransparentColor: TColor = clFuchsia;
  RedTol: Byte = 1; GreenTol: Byte = 1; BlueTol: Byte = 1): HRGN;
const
  AllocUnit = 500;
type
  PRectArray = ^TRectArray;
  TRectArray = array[0..(MaxInt div SizeOf(TRect)) - 1] of TRect;
var
  pr: PRectArray; // used to access the rects array of RgnData by index
  h: HRGN; // Handles to regions
  RgnData: PRgnData; // Pointer to structure RGNDATA used to create regions
  lr, lg, lb, hr, hg, hb: Byte; // values for lowest and hightest trans. colors
  x, y, x0: Integer; // coordinates of current rect of visible pixels
  b: PByteArray; // used to easy the task of testing the byte pixels (R,G,B)
  ScanLinePtr: Pointer; // Pointer to current ScanLine being scanned
  ScanLineInc: Integer; // Offset to next bitmap scanline (can be negative)
  maxRects: Cardinal; // Number of rects to realloc memory by chunks of AllocUnit
begin
  Result := 0;
  { Keep on hand lowest and highest values for the "transparent" pixels }
  lr := GetRValue(TransparentColor);
  lg := GetGValue(TransparentColor);
  lb := GetBValue(TransparentColor);
  hr := Min($FF, lr + RedTol);
  hg := Min($FF, lg + GreenTol);
  hb := Min($FF, lb + BlueTol);
  { ensures that the pixel format is 32-bits per pixel }
  bmp.PixelFormat := pf32bit;
  { alloc initial region data }
  maxRects := AllocUnit;
  GetMem(RgnData, SizeOf(RGNDATAHEADER) + (SizeOf(TRect) * maxRects));
  try
    with RgnData^.rdh do
    begin
      dwSize := SizeOf(RGNDATAHEADER);
      iType := RDH_RECTANGLES;
      nCount := 0;
      nRgnSize := 0;
      SetRect(rcBound, MAXLONG, MAXLONG, 0, 0);
    end;
    { scan each bitmap row - the orientation doesn't matter (Bottom-up or not) }
    ScanLinePtr := bmp.ScanLine[0];
    ScanLineInc := Integer(bmp.ScanLine[1]) - Integer(ScanLinePtr);
    for y := 0 to bmp.Height - 1 do begin
      x := 0;
      while x < bmp.Width do begin
        x0 := x;
        while x < bmp.Width do begin
          b := @PByteArray(ScanLinePtr)[x * SizeOf(TRGBQuad)];
          // BGR-RGB: Windows 32bpp BMPs are made of BGRa quads (not RGBa)
          if (b[2] >= lr) and (b[2] <= hr) and
            (b[1] >= lg) and (b[1] <= hg) and
            (b[0] >= lb) and (b[0] <= hb) then
            Break; // pixel is transparent
          Inc(x);
        end;
        { test to see if we have a non-transparent area in the image }
        if x > x0 then begin
          { increase RgnData by AllocUnit rects if we exceeds maxRects }
          if RgnData^.rdh.nCount >= maxRects then begin
            Inc(maxRects, AllocUnit);
            ReallocMem(RgnData, SizeOf(RGNDATAHEADER) + (SizeOf(TRect) * MaxRects));
          end;
          { Add the rect (x0, y)-(x, y+1) as a new visible area in the region }
          pr := @RgnData^.Buffer; // Buffer is an array of rects
          with RgnData^.rdh do begin
            SetRect(pr[nCount], x0 + xx, y + yy, x + xx, y + 1 + yy);
            { adjust the bound rectangle of the region if we are "out-of-bounds" }
            if x0 < rcBound.Left then rcBound.Left := x0;
            if y < rcBound.Top then rcBound.Top := y;
            if x > rcBound.Right then rcBound.Right := x;
            if y + 1 > rcBound.Bottom then rcBound.Bottom := y + 1;
            Inc(nCount);
          end;
        end; // if x > x0
        { Need to create the region by muliple calls to ExtCreateRegion, 'cause }
        { it will fail on Windows 98 if the number of rectangles is too large   }
        if RgnData^.rdh.nCount = 2000 then
        begin
          h := ExtCreateRegion(nil, SizeOf(RGNDATAHEADER) + (SizeOf(TRect) * maxRects), RgnData^);
          if Result > 0 then
          begin // Expand the current region
            CombineRgn(Result, Result, h, RGN_OR);
            DeleteObject(h);
          end
          else // First region, assign it to Result
            Result := h;
          RgnData^.rdh.nCount := 0;
          SetRect(RgnData^.rdh.rcBound, MAXLONG, MAXLONG, 0, 0);
        end;
        Inc(x);
      end; // scan every sample byte of the image
      Inc(Integer(ScanLinePtr), ScanLineInc);
    end;
    { need to call ExCreateRegion one more time because we could have left    }
    { a RgnData with less than 2000 rects, so it wasn't yet created/combined  }
    h := ExtCreateRegion(nil, SizeOf(RGNDATAHEADER) + (SizeOf(TRect) * MaxRects), RgnData^);
    if Result > 0 then
    begin
      CombineRgn(Result, Result, h, RGN_OR);
      DeleteObject(h);
    end
    else
      Result := h;
  finally
    FreeMem(RgnData, SizeOf(RGNDATAHEADER) + (SizeOf(TRect) * MaxRects));
  end;
end;

procedure DrawRect2(DC: HDC; Dst: Trect; Bmp: TBitmap; Src: TRect; I, N: integer;
  Trans: integer = 0; Tile: integer = 0; Spliter: integer = 0);
var
  temp: Tbitmap;
begin
  if (dst.right < dst.left) or (dst.bottom < dst.top) then exit;
  temp := GetHMap(Dst, Bmp, Src, I, N, tile, spliter);
  if trans = 0 then
    BitBlt(dc, dst.left, dst.top, dst.right - dst.left, dst.bottom - dst.top,
      temp.Canvas.Handle, 0, 0, SrcCopy)
  else DrawTranmap(DC, Dst, temp);
  temp.free;
end;

procedure DrawRectTile(acanvas: Tcanvas; Dst: Trect; Bmp: TBitmap; Src: TRect; I, N: integer;
  Trans: integer = 0; Spliter: integer = 1);
var
  temp: Tbitmap;
  x0, y0, x, y, w, h, w1, h1, m: integer;
begin
  if (dst.right < dst.left) or (dst.bottom < dst.top) then exit;
  temp := Tbitmap.create;
  w := dst.right - dst.left;
  h := dst.bottom - dst.top;
  temp.width := w;
  temp.height := h;
  if Spliter = 0 then begin
    w1 := bmp.width div n;
    h1 := bmp.height;
    x0 := (i - 1) * w1;
    y0 := 0;
  end else begin
    w1 := bmp.width;
    h1 := bmp.height div N;
    y0 := (i - 1) * h1;
    x0 := 0;
  end;

  SetStretchBltMode(temp.canvas.handle, STRETCH_DELETESCANS);
  temp.canvas.copyrect(rect(0, 0, src.left, h), bmp.canvas,
    rect(x0, y0, x0 + src.left, y0 + h1));
  x := src.left;
  m := w1 - src.left - src.right;
  while x < (w - src.right) do begin
    temp.canvas.copyrect(rect(x, 0, x + m, h), bmp.canvas,
      rect(x0 + src.left, y0, x0 + src.left + m, y0 + h1));
    inc(x, m);
  end;

  temp.canvas.copyrect(rect(w - src.right, 0, w, h), bmp.canvas,
    rect(x0 + w1 - src.right, y0, x0 + w1, y0 + h1));

  if trans = 0 then
    BitBlt(acanvas.handle, dst.left, dst.top, dst.right - dst.left, dst.bottom - dst.top,
      temp.Canvas.Handle, 0, 0, SrcCopy)
  else begin
//      DrawTranmap(DC,Dst,temp);
    temp.transparent := true;
    temp.transparentcolor := clFuchsia;
    acanvas.draw(dst.left, dst.top, temp)
  end;
  temp.free;
end;

function GetHMap(Dst: Trect; Bmp: TBitmap; Src: TRect; I, N: integer;
  Tile: integer = 0; Spliter: integer = 0): Tbitmap;
var
  r1, r2: Trect;
  x, y, w, h, w2, h2: integer;
  color, c1, c2: Tcolor;
  temp: Tbitmap;
  b1, b2: boolean;
begin
  if Spliter = 0 then begin
    w := bmp.width div n;
    h := bmp.height;
    x := (i - 1) * w;
    y := 0;
  end else begin
    w := bmp.width;
    h := bmp.height div N;
    y := (i - 1) * h;
    x := 0;
  end;

  temp := Tbitmap.create;
  w2 := dst.right - dst.left;
  h2 := dst.bottom - dst.top;
  temp.width := w2;
  temp.height := h2;
  b1 := w2 < (src.left + src.right);
  b2 := h2 < (src.top + src.bottom);
  if b1 then begin
    src.left := 0;
    src.right := 0;
  end;
  if b2 then begin
    src.top := 0;
    src.bottom := 0;
  end;
    //left-top-corner
  SetStretchBltMode(temp.canvas.handle, STRETCH_DELETESCANS);
  if (src.left * src.top > 0) then begin
    r1 := rect(0, 0, src.left, src.top);
    r2 := rect(x, y, x + src.left, y + src.top);
    temp.canvas.copyrect(r1, bmp.canvas, r2);
  end;
    //left-bottom-corner
  if (src.left * src.bottom > 0) then begin
    r1 := rect(0, h2 - src.bottom, src.left, h2);
    r2 := rect(x, y + h - src.bottom, x + src.left, y + h);
    temp.canvas.copyrect(r1, bmp.canvas, r2);
  end;
    //right-top-corner
  if src.right * src.top > 0 then begin
    r1 := rect(w2 - src.right, 0, w2, src.top);
    r2 := rect(x + w - src.right, y, x + w, src.top + y);
    temp.canvas.copyrect(r1, bmp.canvas, r2);
  end;
    //left
  if src.left > 0 then begin
    r1 := rect(0, src.top, src.left, h2 - src.bottom);
    r2 := rect(x, y + src.top, x + src.left, y + h - src.bottom);
    temp.canvas.copyrect(r1, bmp.canvas, r2);
  end;
    //top
  if src.top > 0 then begin
    r1 := rect(src.left, 0, w2 - src.right, src.top);
    r2 := rect(x + src.left, y, x + w - src.right, y + src.top);
    temp.canvas.copyrect(r1, bmp.canvas, r2);
  end;
    //center
  r1 := rect(src.left, src.top, w2 - src.right, h2 - src.bottom);
  r2 := rect(x + src.left, y + src.top, x + w - src.right, y + h - src.bottom);
//    temp.canvas.copyrect(r1,bmp.canvas,r2);
  if tile = 0 then begin
//       temp.canvas.copyrect(r1,bmp.canvas,r2)
    StretchBlt(temp.canvas.handle, r1.left, r1.top, r1.right - r1.left, r1.bottom - r1.top,
      bmp.canvas.handle, r2.left, r2.top, r2.right - r2.left, r2.bottom - r2.top, SRCCOPY);
  end else
    DrawBGbmp(temp.canvas, r1, bmp, r2);
    //right-bottom-corner
  if src.right * src.bottom > 0 then begin
    r1 := rect(w2 - src.right, h2 - src.bottom, w2, h2);
    r2 := rect(x + w - src.right, y + h - src.bottom, x + w, y + h);
    temp.canvas.copyrect(r1, bmp.canvas, r2);
  end;
    //right
  if src.right > 0 then begin
    r1 := rect(w2 - src.right, src.top, w2, h2 - src.bottom);
    r2 := rect(x + w - src.right, y + src.top, x + w, y + h - src.bottom);
    temp.canvas.copyrect(r1, bmp.canvas, r2);
  end;
    //bottom
  if src.bottom > 0 then begin
    r1 := rect(src.left, h2 - src.bottom, w2 - src.right, h2);
    r2 := rect(x + src.left, y + h - src.bottom, x + w - src.right, y + h);
    temp.canvas.copyrect(r1, bmp.canvas, r2);
  end;
  result := temp;
end;

procedure DrawBorder(Dc: HDC; Dst: Trect; Bmp: TBitmap; Src: TRect; I, N: integer;
  Tile: integer = 0; Spliter: integer = 0);
var
  r1, r2: Trect;
  x, y, w, h, w2, h2: integer;
  b1, b2: boolean;
begin
  if Spliter = 0 then begin
    w := bmp.width div n;
    h := bmp.height;
    x := (i - 1) * w;
    y := 0;
  end else begin
    w := bmp.width;
    h := bmp.height div N;
    y := (i - 1) * h;
    x := 0;
  end;

  w2 := dst.right - dst.left;
  h2 := dst.bottom - dst.top;
  b1 := w2 < (src.left + src.right);
  b2 := h2 < (src.top + src.bottom);
  if b1 then begin
    src.left := 0;
    src.right := 0;
  end;
  if b2 then begin
    src.top := 0;
    src.bottom := 0;
  end;
    //left-top-corner
  SetStretchBltMode(dc, STRETCH_DELETESCANS);
  if (src.left * src.top > 0) then begin
    r1 := rect(0, 0, src.left, src.top);
    offsetrect(r1, dst.left, dst.top);
    r2 := rect(x, y, x + src.left, y + src.top);
    StretchBlt(dc, r1.left, r1.top, r1.right - r1.left, r1.bottom - r1.top,
      bmp.Canvas.Handle, r2.left, r2.top, r2.right - r2.left, r2.bottom - r2.top, SrcCopy);
  end;
    //left-bottom-corner
  if (src.left * src.bottom > 0) then begin
    r1 := rect(0, h2 - src.bottom, src.left, h2);
    OffsetRect(r1, dst.left, dst.top);
    r2 := rect(x, y + h - src.bottom, x + src.left, y + h);
    StretchBlt(dc, r1.left, r1.top, r1.right - r1.left, r1.bottom - r1.top,
      bmp.Canvas.Handle, r2.left, r2.top, r2.right - r2.left, r2.bottom - r2.top, SrcCopy);
  end;
    //right-top-corner
  if src.right * src.top > 0 then begin
    r1 := rect(w2 - src.right, 0, w2, src.top);
    OffsetRect(r1, dst.left, dst.top);
    r2 := rect(x + w - src.right, y, x + w, src.top + y);
    StretchBlt(dc, r1.left, r1.top, r1.right - r1.left, r1.bottom - r1.top,
      bmp.Canvas.Handle, r2.left, r2.top, r2.right - r2.left, r2.bottom - r2.top, SrcCopy);
  end;
    //left
  if src.left > 0 then begin
    r1 := rect(0, src.top, src.left, h2 - src.bottom);
    OffsetRect(r1, dst.left, dst.top);
    r2 := rect(x, y + src.top, x + src.left, y + h - src.bottom);
    StretchBlt(dc, r1.left, r1.top, r1.right - r1.left, r1.bottom - r1.top,
      bmp.Canvas.Handle, r2.left, r2.top, r2.right - r2.left, r2.bottom - r2.top, SrcCopy);
  end;
    //top
  if src.top > 0 then begin
    r1 := rect(src.left, 0, w2 - src.right, src.top);
    OffsetRect(r1, dst.left, dst.top);
    r2 := rect(x + src.left, y, x + w - src.right, y + src.top);
    StretchBlt(dc, r1.left, r1.top, r1.right - r1.left, r1.bottom - r1.top,
      bmp.Canvas.Handle, r2.left, r2.top, r2.right - r2.left, r2.bottom - r2.top, SrcCopy);
  end;
    //right-bottom-corner
  if src.right * src.bottom > 0 then begin
    r1 := rect(w2 - src.right, h2 - src.bottom, w2, h2);
    OffsetRect(r1, dst.left, dst.top);
    r2 := rect(x + w - src.right, y + h - src.bottom, x + w, y + h);
    StretchBlt(dc, r1.left, r1.top, r1.right - r1.left, r1.bottom - r1.top,
      bmp.Canvas.Handle, r2.left, r2.top, r2.right - r2.left, r2.bottom - r2.top, SrcCopy);
  end;
    //right
  if src.right > 0 then begin
    r1 := rect(w2 - src.right, src.top, w2, h2 - src.bottom);
    OffsetRect(r1, dst.left, dst.top);
    r2 := rect(x + w - src.right, y + src.top, x + w, y + h - src.bottom);
    StretchBlt(dc, r1.left, r1.top, r1.right - r1.left, r1.bottom - r1.top,
      bmp.Canvas.Handle, r2.left, r2.top, r2.right - r2.left, r2.bottom - r2.top, SrcCopy);
  end;
    //bottom
  if src.bottom > 0 then begin
    r1 := rect(src.left, h2 - src.bottom, w2 - src.right, h2);
    OffsetRect(r1, dst.left, dst.top);
    r2 := rect(x + src.left, y + h - src.bottom, x + w - src.right, y + h);
    StretchBlt(dc, r1.left, r1.top, r1.right - r1.left, r1.bottom - r1.top,
      bmp.Canvas.Handle, r2.left, r2.top, r2.right - r2.left, r2.bottom - r2.top, SrcCopy);
  end;
end;

function GetThumbMap(Dst: Trect; Bmp: TBitmap; Src: TRect; I, N: integer;
  Tile: integer = 0; Spliter: integer = 0): Tbitmap;
var
  r1, r2: Trect;
  x, y, w, h, w2, h2: integer;
  color, c1, c2: Tcolor;
  temp: Tbitmap;
  b1, b2: boolean;
begin
  w := bmp.width div n;
  h := bmp.height;
  x := (i - 1) * w;
  y := 0;

  temp := Tbitmap.create;
  w2 := dst.right - dst.left;
  h2 := dst.bottom - dst.top;
  temp.width := w2;
  temp.height := h2;

  SetStretchBltMode(temp.canvas.handle, STRETCH_DELETESCANS);
{    b1:= w2<(src.left+src.right);
    b2:= h2<(src.top+src.bottom);
    if b1 then begin
       src.left:=0; src.right:=0;
    end;
    if b2 then begin
       src.top:=0; src.bottom:=0;
    end;}

  if Spliter = 0 then begin //vscrollbar
    //top
    if src.top > 0 then begin
      r1 := rect(0, 0, w2, src.top);
      r2 := rect(x, y, x + w, y + src.top);
      temp.canvas.copyrect(r1, bmp.canvas, r2);
    end;
    //Center
    r1 := rect(0, src.top, w2, h2 - src.bottom);
    r2 := rect(x, y + src.top, x + w, y + h - src.bottom);
    temp.canvas.copyrect(r1, bmp.canvas, r2);
    //bottom
    if src.bottom > 0 then begin
      r1 := rect(0, h2 - src.bottom, w2, h2);
      r2 := rect(x, y + h - src.bottom, x + w, y + h);
      temp.canvas.copyrect(r1, bmp.canvas, r2);
    end;
  end;
  result := temp;
end;

{function SBCustomDraw(SB:Tskinscrollbar;PDraw:pNMCSBCUSTOMDRAW):integer;
var  rc,r1:Trect;
     OldBrush,Brush: HBrush;
     i:integer;

   procedure DrawArrow(bmp:Tbitmap;j,N:integer);
   var temp:Tbitmap;
    w,h,x:integer;
   begin
    w:=bmp.width div n;
    h:=bmp.height;
    x:=(j-1)*w;
    r1:= rect(x,0,x+w,h);
    StretchBlt(pDraw^.hdc,rc.left,rc.top,rc.right-rc.left,rc.bottom-rc.top,
  bmp.canvas.handle, r1.left, r1.top, w,h, SRCCOPY);
  end;

  procedure DrawBar(bmp:Tbitmap;rt:Trect;j,N:integer);
   var temp:Tbitmap;
    w,h,x:integer;
  begin
    w:=bmp.width div n;
    h:=bmp.height;
    x:=(j-1)*w;
    if(pDraw^.nBar = SB_HORZ) then begin
       if (rc.right-rc.left)<(rt.left+rt.right+2) then  begin
          r1:= rect(x,0,x+w,h);
          StretchBlt(pDraw^.hdc,rc.left,rc.top,rc.right-rc.left, rc.bottom-rc.top,
   bmp.canvas.handle, r1.left, r1.top, w,h, SRCCOPY);
       end else begin
          StretchBlt(pDraw^.hdc,rc.left,rc.top,rt.left, rc.bottom-rc.top,
   bmp.canvas.handle, x, 0,rt.left,h, SRCCOPY);
          StretchBlt(pDraw^.hdc,rc.left+rt.left,rc.top,rc.right-rc.left-rt.right-rt.left, rc.bottom-rc.top,
   bmp.canvas.handle, x+rt.left, 0,w-rt.left-rt.right,h, SRCCOPY);
          StretchBlt(pDraw^.hdc,rc.right-rt.right,rc.top,rt.right, rc.bottom-rc.top,
   bmp.canvas.handle, w+x-rt.right, 0,rt.right,h, SRCCOPY);
       end;
    end else begin
       if (rc.bottom-rc.top)<(rt.top+rt.bottom+2) then  begin
          r1:= rect(x,0,x+w,h);
          StretchBlt(pDraw^.hdc,rc.left,rc.top,rc.right-rc.left, rc.bottom-rc.top,
   bmp.canvas.handle, r1.left, r1.top, w,h, SRCCOPY);
       end else begin
          StretchBlt(pDraw^.hdc,rc.left,rc.top,rc.right-rc.left, rt.top,
   bmp.canvas.handle, x, 0,w,rt.top, SRCCOPY);
          StretchBlt(pDraw^.hdc,rc.left,rc.top+rt.top,rc.right-rc.left, rc.bottom-rc.top-rt.top-rt.bottom,
   bmp.canvas.handle, x, rt.top,w,h-rt.top-rt.bottom, SRCCOPY);
          StretchBlt(pDraw^.hdc,rc.left,rc.bottom-rt.bottom,rc.right-rc.left, rt.bottom,
   bmp.canvas.handle, x, h-rt.bottom,w,rt.bottom, SRCCOPY);
       end;
    end;
  end;

begin
    if(pDraw^.dwDrawStage = CDDS_PREPAINT) then begin
      result := CDRF_SKIPDEFAULT;
      exit;
    end;
    //the sizing gripper in the bottom-right corner
    if(pDraw^.nBar = SB_BOTH) then begin
        Brush := CreateSolidBrush(sb.fsd.colors[csButtonFace]);
        fillrect(pdraw^.hdc,pDraw^.rc,brush);
        DeleteObject(Brush);
        result:= CDRF_SKIPDEFAULT;
    end else if(pDraw^.nBar = SB_HORZ) then begin

 if(pDraw^.uState=CDIS_HOT) then  i:=2
 else if(pDraw^.uState=CDIS_SELECTED) then i:=1
 else i:=0;
        rc:=pDraw^.rc;
        rc.Bottom:=rc.top+16;
        case pdraw^.uItem of
          SB_LINELEFT:begin
                inc(i,1);
                Drawarrow(sb.fsd.SArrow.map,i,23);
             end;
          SB_LINERIGHT:begin
                inc(i,5);
                Drawarrow(sb.fsd.SArrow.map,i,23);
             end;
          SB_PAGELEFT: begin
//               DrawRect2(pDraw^.hdc,pDraw^.rc,sb.fsd.HBar.map,
//                   sb.fsd.HBar.r,1,4,sb.fsd.Hbar.trans,sb.fsd.Hbar.tile);
//               DrawBar(sb.fsd.HBar.map,sb.fsd.HBar.r,1,4);
//               skinaddlog(format('PAGELEFT %1d %1d',[rc.right,rc.left]));
             end;
          SB_PAGERIGHT:begin
               DrawBar(sb.fsd.HBar.map,sb.fsd.HBar.r,1,4);
//               DrawRect2(pDraw^.hdc,pDraw^.rc,sb.fsd.HBar.map,
//                   sb.fsd.HBar.r,1,4,sb.fsd.Hbar.trans,sb.fsd.Hbar.tile);
//               skinaddlog(format('PAGERight %1d %1d',[rc.right,rc.left]));
             end;
          SB_THUMBTRACK:begin
               rc.Bottom:=rc.top+16;
               inc(i,1);
               DrawRect2(pDraw^.hdc,rc,sb.fsd.hSlider.map,
                   sb.fsd.hslider.r,i,sb.fsd.hslider.frame,sb.fsd.hslider.trans);
//               DrawBar(sb.fsd.hslider.map,sb.fsd.hslider.r,i,sb.fsd.hslider.frame);
             end;
        end;

 result:=CDRF_SKIPDEFAULT;
    end else if(pDraw^.nBar=SB_VERT) then begin

 if(pDraw^.uState=CDIS_HOT) then  i:=2
 else if(pDraw^.uState=CDIS_SELECTED) then i:=1
 else i:=0;
        rc:=pDraw^.rc;
        rc.right:=rc.left+16;

        case pdraw^.uItem of
          SB_LINEUP:begin
                inc(i,9);
                Drawarrow(sb.fsd.SArrow.map,i,23);
            end;
          SB_LINEDOWN:begin
                inc(i,13);
                Drawarrow(sb.fsd.SArrow.map,i,23);
            end;
          SB_PAGEUP:begin
//               DrawRect2(pDraw^.hdc,pDraw^.rc,sb.fsd.VBar.map,
//                   sb.fsd.VBar.r,1,4,sb.fsd.Vbar.trans,sb.fsd.Vbar.tile);
//               DrawBar(sb.fsd.VBar.map,sb.fsd.VBar.r,1,4);
             end;
          SB_PAGEDOWN:begin
               DrawBar(sb.fsd.VBar.map,sb.fsd.VBar.r,1,4);
             end;
          SB_THUMBTRACK:begin
               inc(i,1);
               rc.right:=rc.left+16;
               DrawRect2(pDraw^.hdc,rc,sb.fsd.VSlider.map,
                   sb.fsd.Vslider.r,i,sb.fsd.vslider.frame,sb.fsd.vslider.trans);
//               DrawBar(sb.fsd.vslider.map,sb.fsd.vslider.r,i,sb.fsd.vslider.frame);
             end;
        end;
 result:= CDRF_SKIPDEFAULT;
    end else begin
 result:= CDRF_DODEFAULT;
    end;
end;}

function Max(const A, B: Integer): Integer;
begin
  if A > B then
    Result := A
  else
    Result := B;
end;

function Min(const A, B: Integer): Integer;
begin
  if A < B then
    Result := A
  else
    Result := B;
end;

procedure Bitmapdraw(DC: HDC; Dst: Trect; Bmp: TBitmap);
var
  OldPalette: HPalette;
  RestorePalette: Boolean;
begin
  OldPalette := 0;
  RestorePalette := False;
  TACBitmap(bmp).PaletteNeeded;

  if bmp.Palette <> 0 then
  begin
    OldPalette := SelectPalette(dc, bmp.Palette, True);
    RealizePalette(dc);
    RestorePalette := True;
  end;
  BitBlt(dc, dst.left, dst.top, dst.right - dst.left, dst.bottom - dst.top,
    bmp.Canvas.Handle, 0, 0, SrcCopy);
  if RestorePalette then
    SelectPalette(Dc, OldPalette, True);
end;

procedure DrawRect1(DC: HDC; Dst: Trect; Bmp: TBitmap; I, N: integer; Trans: integer = 0);
var
  r1, r2: Trect;
  x, w, h, w1: integer;
  color, c1, c2: Tcolor;
  temp: Tbitmap;
begin
  if (dst.right < dst.left) or (dst.bottom < dst.top) then exit;
  temp := Tbitmap.create;
  w := dst.right - dst.left;
  h := dst.bottom - dst.top;
  temp.width := w;
  temp.height := h;
  w1 := bmp.width div n;
  x := (i - 1) * w1;
  temp.canvas.copyrect(rect(0, 0, w, h), bmp.canvas, rect(x, 0, x + w1, bmp.height));
  if trans = 0 then
    BitBlt(dc, dst.left, dst.top, dst.right - dst.left, dst.bottom - dst.top,
      temp.Canvas.Handle, 0, 0, SrcCopy)
  else DrawTranmap(DC, dst, temp);
  temp.free;
end;

procedure DrawRect3(DC: HDC; Dst: Trect; Bmp: TBitmap; I, N: integer; Trans: integer = 0);
var
  r1, r2: Trect;
  x, y, w, h, w1: integer;
  color, c1, c2: Tcolor;
  temp: Tbitmap;
begin
  if (dst.right < dst.left) or (dst.bottom < dst.top) then exit;
  temp := Tbitmap.create;
  w := bmp.width div n;
  h := bmp.Height;
  temp.width := w;
  temp.height := h;
  x := (i - 1) * w;
  BitBlt(temp.Canvas.handle, 0, 0, w, h,
    bmp.Canvas.Handle, x, 0, SrcCopy);
  x := dst.Left + (dst.right - dst.Left - w) div 2;
  y := dst.top + (dst.bottom - dst.top - h) div 2;
  if trans = 0 then
    BitBlt(dc, x, y, w, h,
      temp.Canvas.Handle, 0, 0, SrcCopy)
  else DrawTranmap(DC, rect(x, y, x + w, y + h), temp);
  temp.free;
end;

procedure DrawRectH(DC: HDC; Dst: Trect; Bmp: TBitmap; Src: TRect; I, N: integer;
  Tile: integer = 0; Spliter: integer = 0);
var
  x, y, w, h, x1, y1: integer;
begin
  if Spliter = 0 then begin
    w := bmp.width div n;
    h := bmp.height;
    x := (i - 1) * w;
    y := 0;
  end else begin
    w := bmp.width;
    h := bmp.height div N;
    y := (i - 1) * h;
    x := 0;
  end;
//    if (dst.Bottom-dst.Top)>h then
//      dst.Top:=dst.Top+(dst.Bottom-dst.Top-h) div 2;

  if (dst.Right - dst.Left) < w then begin
    StretchBlt(dc, dst.left, dst.top, dst.right - dst.left, dst.Bottom - dst.Top,
      bmp.canvas.handle, x, y, x + w, y + h, SRCCOPY);
  end else begin
    StretchBlt(dc, dst.Left, dst.Top, src.Left, dst.Bottom - dst.Top,
      bmp.canvas.handle, x, y, src.Left, h, SRCCOPY);
    StretchBlt(dc, dst.Left + src.Left, dst.Top, dst.Right - dst.Left - src.Left - src.Right, dst.Bottom - dst.Top,
      bmp.canvas.handle, x + src.Left, y, w - src.Left - src.Right, h, SRCCOPY);
    StretchBlt(dc, dst.Right - src.Right, dst.Top, src.Right, dst.Bottom - dst.Top,
      bmp.canvas.handle, x + w - src.Right, y, src.Right, h, SRCCOPY);
  end;
end;

procedure DrawRectV(DC: HDC; Dst: Trect; Bmp: TBitmap; Src: TRect; I, N: integer;
  Tile: integer = 0; Spliter: integer = 0);
var
  x, y, w, h: integer;
begin
  if Spliter = 0 then begin
    w := bmp.width div n;
    h := bmp.height;
    x := (i - 1) * w;
    y := 0;
  end else begin
    w := bmp.width;
    h := bmp.height div N;
    y := (i - 1) * h;
    x := 0;
  end;
//    if (dst.Right-dst.left)>w then
//      dst.Left:=dst.Left+(dst.Right-dst.Left-w) div 2;

  if (dst.Bottom - dst.Top) < h then begin
    StretchBlt(dc, dst.left, dst.top, dst.Right - dst.Left, dst.Bottom - dst.Top,
      bmp.canvas.handle, x, y, x + w, y + h, SRCCOPY);
  end else begin
    StretchBlt(dc, dst.Left, dst.Top, dst.Right - dst.Left, src.Top,
      bmp.canvas.handle, x, y, w, src.Top, SRCCOPY);
    StretchBlt(dc, dst.Left, dst.Top + src.Top, dst.Right - dst.Left, dst.Bottom - dst.Top - src.Top - src.Bottom,
      bmp.canvas.handle, x, y + src.Top, w, h - src.Top - src.Bottom, SRCCOPY);
    StretchBlt(dc, dst.Left, dst.Bottom - src.Bottom, dst.Right - dst.Left, src.Bottom,
      bmp.canvas.handle, x, y + h - src.Bottom, w, src.Bottom, SRCCOPY);
  end;
end;

procedure DrawParentImage(Control: TControl; DC: HDC; InvalidateParent: Boolean = False);
var
  SaveIndex: Integer;
  P: TPoint;
  r: Trect;
begin
  if Control.Parent = nil then
    Exit;
  r := control.ClientRect;
  SaveIndex := SaveDC(DC);

  GetViewportOrgEx(DC, P);
  SetViewportOrgEx(DC, P.X - Control.Left, P.Y - Control.Top, nil);

  offsetrect(r, control.Left, control.Top);
  IntersectClipRect(DC, r.Left, r.Top, r.Right, r.Bottom);

//  IntersectClipRect( DC, 0, 0, Control.Parent.ClientWidth, Control.Parent.ClientHeight );

  if not (csDesigning in Control.ComponentState) then
  begin
    Control.Parent.Perform(wm_EraseBkgnd, DC, 0);
    Control.Parent.Perform(wm_Paint, DC, 0);
  end else begin
    try
      Control.Parent.Perform(wm_EraseBkgnd, DC, 0);
      Control.Parent.Perform(wm_Paint, DC, 0);
    except
    end;
  end;
  RestoreDC(DC, SaveIndex);

{  if InvalidateParent then  begin
    if not ( Control.Parent is TCustomControl ) and
       not ( Control.Parent is TCustomForm ) and
       not ( csDesigning in Control.ComponentState ) then
    begin
      Control.Parent.Invalidate;
    end;
  end; }
end;

{procedure DrawTranmap(DC:HDC;Dst:Trect;temp:TBitmap;transcolor:Tcolor=clFuchsia);
var color,c1,c2 :Tcolor;
    mask : Tbitmap;
    w,h:integer;
begin
    if  (dst.right<dst.left) or (dst.bottom<dst.top) then exit;
    c1:=SetBkColor(dc,clwhite);
    c2:=SetTextColor(dc,clblack);
    mask:=Tbitmap.create;
    mask.assign(temp);
    mask.mask(transcolor);
//    mask.mask(temp.Canvas.Pixels[0, 0]);
    w:=dst.right-dst.left;
    h:=dst.bottom-dst.top;
    BitBlt(dc,dst.left ,dst.top,w,h,
                 temp.Canvas.Handle ,0 ,0 ,SrcInvert);
    BitBlt(dc,dst.left ,dst.top,w,h,
                 mask.Canvas.Handle ,0 ,0 ,SrcAnd);
    BitBlt(dc,dst.left ,dst.top,w,h,
                 temp.Canvas.Handle ,0 ,0 ,SrcInvert);
    SetBkColor(dc,c1);
    SetTextColor(dc,c2);
    mask.free;
end;}

procedure DrawTranmap(DC: HDC; Dst: Trect; temp: TBitmap; transcolor: Tcolor = clFuchsia);
var
  color, c1, c2: Tcolor;
  mask: Tbitmap;
  w, h: integer;
begin
  if (dst.right < dst.left) or (dst.bottom < dst.top) then exit;
  mask := Tbitmap.create;
  mask.assign(temp);
  mask.mask(transcolor);
  try
    if (Win32Platform = VER_PLATFORM_WIN32_NT) then begin
      MaskBlt(DC, Dst.left, Dst.top, Dst.Right - dst.left, Dst.Bottom - dst.top,
        temp.Canvas.handle, 0, 0, mask.handle, 0, 0, MakeRop4($00AA0029, SrcCopy));
    end else begin
      c1 := SetBkColor(dc, clwhite);
      c2 := SetTextColor(dc, clblack);
      w := dst.right - dst.left;
      h := dst.bottom - dst.top;
      BitBlt(dc, dst.left, dst.top, w, h,
        temp.Canvas.Handle, 0, 0, SrcInvert);
      BitBlt(dc, dst.left, dst.top, w, h,
        mask.Canvas.Handle, 0, 0, SrcAnd);
      BitBlt(dc, dst.left, dst.top, w, h,
        temp.Canvas.Handle, 0, 0, SrcInvert);
      SetBkColor(dc, c1);
      SetTextColor(dc, c2);
    end;
  finally
    mask.Free;
  end;
end;

procedure SkinAddLog(msg: string);
begin
{$IFDEF test}
  if msg = '' then exit;
  if logstring <> nil then Logstring.add(msg);
{$ENDIF}
end;

{procedure  SetProperty(control: TObject;aprop,value:string);
var PropInfo:PPropInfo;
begin
   if  control<>nil then begin
      PropInfo:=GetPropInfo(control,aprop);
      if PropInfo<>nil then  begin
         if propinfo^.PropType^.Kind= tkEnumeration then
          SetEnumProp(control,PropInfo,value);
      end;
   end;
end;}

initialization
  bg := Tbitmap.create;
  SetStretchBltMode(bg.canvas.handle, STRETCH_DELETESCANS);
  Logstring := Tstringlist.create;

finalization
{$IFDEF test}
  logstring.savetofile(ExtractFilePath(ParamStr(0)) +
    ExtractFileName(ParamStr(0)) + '.txt');
{$ENDIF}
  Logstring.free;
  bg.free;
  bg := nil;
end.

