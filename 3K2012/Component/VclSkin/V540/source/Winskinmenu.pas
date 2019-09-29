unit WinSkinMenu;

{.$define menutest}
{$WARNINGS OFF}
{$HINTS OFF}
{$RANGECHECKS OFF}

interface

uses windows, Messages, SysUtils, Classes, Graphics,
  WinSkinData, controls, Forms;

const
  c_menuprop = 'WinSkinPopMenu';

type
  TWinSkinPopMenu = class(Tobject)
  protected
    FPrevWndProc: Pointer;
    FObjectInst: Pointer;
    done: boolean;
    procedure WinWndProc(var aMsg: TMessage);
    procedure Default(var Msg: TMessage);
    procedure AddLog(Msg: TMessage);
    procedure WMPrint(var Msg: Tmessage);
    procedure WMPrintClient(var Msg: Tmessage);
    procedure UpdateMenu(var Msg: Tmessage);
    procedure NcPaint(var Msg: Tmessage);
    procedure WMERASEBKGND(var Msg: Tmessage);
  public
    hwnd: Thandle;
    fsd: TSkindata;
    SelIndex: integer;
    MenuBg: Tbitmap;
    hmenu: Hmenu;
    crop: boolean;
    clientRgn: hRgn;
    ownerdraw: boolean; //
    constructor Create;
    destructor Destroy; override;
    procedure InitSkin(ahwnd: Thandle; afsd: Tskindata; amenu: Hmenu);
    procedure UnSubClass;
  end;

var
  newskinmenu: TWinSkinPopMenu;

implementation

uses Winskinform, winskindlg;

constructor TWinSkinPopMenu.Create;
begin
  inherited;
  SelIndex := -1;
  MenuBg := Tbitmap.create;
  hmenu := 0;
  fobjectinst := nil;
end;

destructor TWinSkinPopMenu.Destroy;
begin
  inherited destroy;
  MenuBg.free;
end;

procedure TWinSkinPopMenu.InitSkin(ahwnd: Thandle; afsd: Tskindata; amenu: Hmenu);
var
  rc, r1: Trect;
  temp: Tbitmap;
begin
  hwnd := ahwnd;
  fsd := afsd;
  hmenu := amenu;
//    SetProp(ahwnd, c_menuprop, Cardinal(self));
  FObjectInst := MakeObjectInstance(WinWndProc);
  FPrevWndProc := Pointer(GetWindowLong(hwnd, GWL_WNDPROC));
  SetWindowLong(hwnd, GWL_WNDPROC, LongInt(FObjectInst));
//    SetProp(ahwnd, MakeIntAtom(ControlAtom), THandle(Self));
  ownerdraw := false;
end;

procedure TWinSkinPopMenu.UnSubClass;
begin
  if fobjectinst <> nil then begin
    if crop then begin
      DeleteObject(clientRgn);
    end;
    SetWindowLong(hwnd, GWL_WNDPROC, LongInt(FPrevWndProc));
    FreeObjectInstance(FObjectInst);
//         RemoveProp(hwnd, MakeIntAtom(ControlAtom));
//         RemoveProp(hwnd, c_menuprop);
    MenuBg.assign(nil);
    fobjectinst := nil;
  end;
end;

procedure TWinSkinPopMenu.AddLog(Msg: TMessage);
var
  s: string;
begin
  s := MsgtoStr(Msg);
  if s = '' then exit;
  if s = '' then
    s := format('%4.0x(%4.0x,%04x,%04x,%04x)', [hwnd, msg.msg, msg.wparam, msg.lparam, msg.result]);
  s := format('Menu hook:%4x %s', [hwnd, s]);
  fsd.DoDebug(s);
  //skinaddlog(s);
end;

procedure TWinSkinPopMenu.Default(var Msg: TMessage);
begin
  msg.result := CallWindowProc(FPrevWndProc, hwnd, Msg.msg, msg.WParam, msg.LParam);
end;

procedure TWinSkinPopMenu.WinWndProc(var aMsg: TMessage);
var
  Old: boolean;
  s: string;
begin
{$IFDEF menutest}
  addlog(aMsg);
{$ENDIF}
  if aMsg.Msg = CN_IsSkined then begin
    amsg.result := 1;
    exit;
  end;

  if not skinmanager.active then begin
    default(amsg);
    exit;
  end;

  done := false;
  if aMsg.Msg = WM_DESTROY then begin
    UnSubClass;
  end;
  //create bk in  WM_print, ignore WM_ERASEBKGND
  if true then begin
    case aMsg.Msg of
      WM_print: WMPrint(amsg);

//      WM_printclient:WMPrintclient(amsg);
//      WM_Ncpaint: if ((Win32Platform = VER_PLATFORM_WIN32_NT) and (Win32MajorVersion >= 5) and (Win32MinorVersion >= 1)) or
//      WM_Ncpaint:  Ncpaint(amsg);

      WM_Ncpaint: if (Win32Platform = VER_PLATFORM_WIN32_NT) or
        (winversion >= $80000000) then Ncpaint(amsg);
      WM_ERASEBKGND: // amsg.Result:=1;
        if (winversion < $80000000) then WMERASEBKGND(amsg);
    else default(amsg);
    end;
  end else default(amsg);
end;

procedure TWinSkinPopMenu.UpdateMenu(var Msg: Tmessage);
var
  rc: Trect;
begin
  if (SelIndex <> msg.wparam) then begin
//        skinaddlog('menu hook: $1e5');
    default(msg);
    GetClientRect(hwnd, rc);
    selindex := msg.wparam;
    InvalidateRect(hwnd, @rc, FALSE);
    done := true;
  end;
end;

procedure TWinSkinPopMenu.WMERASEBKGND(var Msg: Tmessage);
var
  rc, R1: TRect;
  DC: HDC;
  temp: Tbitmap;
begin
  if not (xoMenuBG in fsd.Options) then begin
    default(msg);
  end;
  msg.result := 1;
  exit;
{   if (fsd.empty) or(fsd.MenuItemBG=nil)
       or (fsd.MenuItemBG.map.empty)
       or (not ownerdraw) then begin
       default(msg);
       msg.result:=1;
       exit;
   end;  }

  default(msg);

  GetWindowRect(hwnd, rc);
  r1 := rc;
  OffsetRect(r1, -r1.left, -r1.top);
  DC := GetWindowDC(hwnd);
//   fsd.DoDebug('***WMERASEBKGND');

  if MenuBg.empty then begin

    temp := GetHMap(r1, fsd.MenuItemBG.map, fsd.MenuItemBG.r, 1, 1, fsd.MenuItemBG.Tile);
    MenuBg.assign(temp);
    temp.free;
  end;
  if hmenu = 0 then newskinmenu := self;

//   BitBlt(msg.wParam,rc.left ,rc.top,rc.right-rc.left,rc.bottom-rc.Top,
//                 MenuBg.Canvas.Handle ,0 ,0 ,Srccopy);

//   DrawRect2(msg.wParam,rc,fsd.MenuItemBG.map,fsd.MenuItemBG.r,1,1,
//         0,fsd.MenuItemBG.Tile);
  BitBlt(DC, rc.left, rc.top, rc.right - rc.left, rc.bottom - rc.top,
    MenuBg.Canvas.Handle, 0, 0, Srccopy);
  ReleaseDC(0, DC);
  msg.result := 1;
end;

{procedure TWinSkinPopMenu.WMPrint(var Msg: Tmessage);
var rc, R1: TRect;
    DC: HDC;
    clientRgn : hRgn;
    temp:Tbitmap;
begin
   if fsd.empty or (fsd.MenuItemBG=nil) or (fsd.MenuItemBG.map.empty) then begin
      default(msg);
      exit;
   end;
//   default(msg);
   if hmenu=0 then newskinmenu:=self;
   if GetWindowRect(hwnd, rc) then begin
     OffsetRect(rc,-rc.left,-rc.top);
     r1:=rc;
     InflateRect(r1,-3,-3);

     clientRgn :=CreateRectRgn(r1.left,r1.top,r1.right,r1.bottom);
     temp:=GetHMap(rc,fsd.MenuItemBG.map,fsd.MenuItemBG.r,1,1,fsd.MenuItemBG.Tile);
     MenuBg.assign(temp);

     SetBkMode(temp.canvas.handle,TRANSPARENT);
     SelectClipRgn(temp.canvas.handle, clientRgn);
     msg.result:=CallWindowProc(FPrevWndProc,hwnd,Msg.msg,temp.canvas.handle,msg.LParam);
     SelectClipRgn(temp.canvas.handle, 0);

     BitBlt(msg.wParam,rc.left ,rc.top,rc.right-rc.left,rc.bottom-rc.Top,
                 temp.Canvas.Handle ,0 ,0 ,Srccopy);
     DeleteObject(clientRgn);
     temp.free;
   end else  default(msg);
end;}

procedure TWinSkinPopMenu.WMPrint(var Msg: Tmessage);
var
  rc, R1: TRect;
  DC: HDC;
  clientRgn: hRgn;
  temp: Tbitmap;
  OldMode: integer;
begin
  if fsd.empty or (fsd.MenuItemBG = nil) or (fsd.MenuItemBG.map.empty) then begin
    default(msg);
    exit;
  end;
//   default(msg);
  if hmenu = 0 then newskinmenu := self;
  if GetWindowRect(hwnd, rc) then begin
    OffsetRect(rc, -rc.left, -rc.top);
    r1 := rc;
    InflateRect(r1, -3, -3);

    clientRgn := CreateRectRgn(r1.left, r1.top, r1.right, r1.bottom);
    temp := GetHMap(rc, fsd.MenuItemBG.map, fsd.MenuItemBG.r, 1, 1, fsd.MenuItemBG.Tile);
    MenuBg.assign(temp);
    temp.free;
    BitBlt(msg.wParam, rc.left, rc.top, rc.right - rc.left, rc.bottom - rc.Top,
      MenuBg.Canvas.Handle, 0, 0, Srccopy);

    OldMode := SetBkMode(msg.wparam, TRANSPARENT);
    SelectClipRgn(msg.wParam, clientRgn);
    msg.result := CallWindowProc(FPrevWndProc, hwnd, Msg.msg, msg.wparam, msg.LParam);
    SelectClipRgn(msg.wParam, 0);
    DeleteObject(clientRgn);
    SetBkMode(msg.wparam, OldMode);
  end else default(msg);
end;

{procedure TWinSkinPopMenu.WMPrint(var Msg: Tmessage);
var rc, R1: TRect;
    DC: HDC;
    clientRgn : hRgn;
    temp:Tbitmap;
    OldMode: integer;
begin
   if fsd.empty or (fsd.MenuItemBG=nil) or (fsd.MenuItemBG.map.empty) then begin
      default(msg);
      exit;
   end;
   if hmenu=0 then newskinmenu:=self;
   if GetWindowRect(hwnd, rc) then begin

     OffsetRect(rc,-rc.left,-rc.top);
     r1:=rc;
     InflateRect(r1,-3,-3);

     temp:=GetHMap(rc,fsd.MenuItemBG.map,fsd.MenuItemBG.r,1,1,fsd.MenuItemBG.Tile);
     MenuBg.assign(temp);
     temp.free;

     default(msg);
     if ownerdraw then begin
        ExcludeClipRect(msg.wParam,rc.left+3,rc.top+3,rc.right-3,rc.bottom-3);
        BitBlt(msg.wParam,rc.left ,rc.top,rc.right-rc.left,rc.bottom-rc.Top,
                 MenuBg.Canvas.Handle ,0 ,0 ,Srccopy);
        SelectClipRgn(msg.wParam, 0);
     end;
   end else  default(msg);
end;}

{procedure TWinSkinPopMenu.WMPrint(var Msg: Tmessage);
var rc, R1: TRect;
    DC: HDC;
    clientRgn : hRgn;
    temp:Tbitmap;
begin
   if fsd.empty then exit;
   if (fsd.MenuItemBG=nil) or (fsd.MenuItemBG.map.empty) then exit;

//   default(msg);
   GetWindowRect(hwnd, rc);
   OffsetRect(rc,-rc.left,-rc.top);

   r1:=rc;
   InflateRect(r1,-3,-3);
   clientRgn :=CreateRectRgn(r1.left,r1.top,r1.right,r1.bottom);

   temp:=GetHMap(rc,fsd.MenuItemBG.map,fsd.MenuItemBG.r,1,1,fsd.MenuItemBG.Tile);
   MenuBg.assign(temp);
   temp.free;
   if hmenu=0 then newskinmenu:=self;
   temp:=Tbitmap.create;
   temp.width:=rc.right;
   temp.height:=rc.bottom;
   temp.canvas.brush.color:=clFuchsia;
   temp.canvas.fillrect(rc);
//   BitBlt(msg.wParam,rc.left ,rc.top,rc.right-rc.left,rc.bottom-rc.Top,
//                 MenuBg.Canvas.Handle ,0 ,0 ,Srccopy);

   SelectClipRgn(temp.canvas.handle, clientRgn);

//   msg.result:=CallWindowProc(FPrevWndProc,hwnd,Msg.msg,msg.wparam,msg.LParam);
   msg.result:=CallWindowProc(FPrevWndProc,hwnd,Msg.msg,temp.canvas.handle,msg.LParam);
   BitBlt(msg.wParam,rc.left ,rc.top,rc.right-rc.left,rc.bottom-rc.Top,
                 temp.Canvas.Handle ,0 ,0 ,Srccopy);

   SelectClipRgn(temp.canvas.handle, 0);
   DeleteObject(clientRgn);
   temp.free;
   done:=true;
end;}

procedure TWinSkinPopMenu.NcPaint(var Msg: Tmessage);
var
  rc, R1: TRect;
  DC: HDC;
  clientRgn: hRgn;
  temp: Tbitmap;
begin
  if fsd.empty or (fsd.MenuItemBG = nil) or (fsd.MenuItemBG.map.empty) or (msg.WParam <> 1) then begin
    default(msg);
    exit;
  end;

  if (Win32Platform = VER_PLATFORM_WIN32_NT) and (Win32MajorVersion >= 5) and (Win32MinorVersion > 1) then
    Dc := GetWindowDC(hwnd)
  else
    Dc := GetDCEx(hwnd, msg.WParam, DCX_WINDOW or DCX_INTERSECTRGN or $10000);
//   Dc := GetDCEx(hwnd, msg.WParam, DCX_WINDOW or DCX_INTERSECTRGN or  $10000 );
  GetWindowRect(hwnd, rc);
  r1 := rc;
  InflateRect(r1, -3, -3);
  OffsetRect(rc, -rc.left, -rc.top);

  temp := GetHMap(rc, fsd.MenuItemBG.map, fsd.MenuItemBG.r, 1, 1, fsd.MenuItemBG.Tile);
  MenuBg.assign(temp);
  temp.free;
  if hmenu = 0 then newskinmenu := self;

  BitBlt(dc, rc.left, rc.top, rc.right - rc.left, rc.top + 3,
    MenuBg.Canvas.Handle, 0, 0, Srccopy);
  StretchBlt(dc, rc.left, rc.bottom - 3, rc.right - rc.left, rc.bottom,
    MenuBg.Canvas.Handle, rc.left, rc.bottom - 3, rc.right - rc.left, rc.bottom, Srccopy);
  StretchBlt(dc, rc.left, rc.top + 3, rc.left + 3, rc.bottom - 3,
    MenuBg.Canvas.Handle, rc.left, rc.top + 3, rc.left + 3, rc.bottom - 3, Srccopy);
  StretchBlt(dc, rc.right - 3, rc.top + 3, rc.right, rc.bottom,
    MenuBg.Canvas.Handle, rc.right - 3, rc.top + 3, rc.right, rc.bottom, Srccopy);

  BitBlt(dc, rc.left, rc.top, rc.right - rc.left, rc.bottom - rc.top,
    MenuBg.Canvas.Handle, 0, 0, Srccopy);
//   fsd.DoDebug(format('NCPaint %1d %1d',[rc.right,rc.bottom]));
  ReleaseDC(hwnd, DC);
end;

{procedure TWinSkinPopMenu.WMPrintClient(var Msg: Tmessage);
var rc, R1: TRect;
    DC: HDC;
    temp:Tbitmap;
    c:Tcolor;
begin
   if fsd.empty then exit;
   if (fsd.MenuItemBG=nil) or (fsd.MenuItemBG.map.empty) then exit;

   GetWindowRect(hwnd, rc);
   InflateRect(rc,-3,-3);
   OffsetRect(rc,-rc.left,-rc.top);

   temp:=Tbitmap.create;
   temp.width:=rc.right;
   temp.height:=rc.bottom;
   c:=GetSysColor(COLOR_MENU);
   temp.canvas.brush.color:=c;
   SetBkMode(temp.canvas.handle,TRANSPARENT);
   temp.canvas.fillrect(rc);
   msg.result:=CallWindowProc(FPrevWndProc,hwnd,Msg.msg,temp.canvas.handle,msg.LParam);
   DrawTranmap(msg.wParam,rc,temp,c);
   temp.free;
   done:=true;
end;}

procedure TWinSkinPopMenu.WMPrintClient(var Msg: Tmessage);
var
  rc, R1: TRect;
  DC: HDC;
  c: Tcolor;
begin
  default(msg);
  if fsd.empty then exit;
  if (fsd.MenuItemBG = nil) or (fsd.MenuItemBG.map.empty) then exit;

  if GetWindowRect(hwnd, rc) then begin
    ExcludeClipRect(msg.wParam, rc.left + 3, rc.top + 3, rc.right - 3, rc.bottom - 3);
    BitBlt(msg.wParam, rc.left, rc.top, rc.right - rc.left, rc.bottom - rc.Top,
      MenuBg.Canvas.Handle, 0, 0, Srccopy);
    SelectClipRgn(msg.wParam, 0);
  end;
end;

end.

