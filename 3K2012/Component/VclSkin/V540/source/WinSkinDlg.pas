unit WinSkinDlg;

{$I Compilers.Inc}

{$WARNINGS OFF}
{$HINTS OFF}
{$RANGECHECKS OFF}

interface

uses windows, Messages, SysUtils, Classes, Graphics, WinSkinMenu,
  forms, ExtCtrls;

const
  skin_Creating = 0;
  skin_Active = 1;
  skin_uninstall = 2;
  skin_change = 3;
  skin_Destory = 4;
  skin_Updating = 5;
  skin_Deleted = 6;
  skin_update = 7;

  m_popup = 0;
  m_systemmenu = 2;
  m_menuitem = 1;

type
  TSkinThread = class(TObject)
  public
    hook: HHook;
    ThreadID: integer;
  end;

  TSBAPI1 = function(ahwnd: hwnd): HResult; stdcall;
  TSBAPI2 = function(): HResult; stdcall;

  TSkinManage = class(Tobject)
  protected
    Timer: TTimer;
    SBLib: Thandle;
    pinitApp, pUninitApp: TSBAPI2;
    pinitSB, pUninitSb: TSBAPI1;
    //function  FindSkinForm(aHwnd:THandle):boolean;
    function FindSkinForm(aHwnd: THandle): dword;
    procedure DeleteAllForms;
    function AddMenu(aHwnd: THandle): boolean;
    function FindSkinMenu(aHwnd: THandle): boolean;
    function DeleteMenu(aHwnd: THandle): boolean;
    procedure DeleteAllMenus;
    function FindTForm(ahwnd: Thandle): Tform;
    procedure OnTimer(Sender: TObject);
    function NestedForm(ahwnd: Thandle): boolean;
    procedure FindSkindata(var adata: pointer; ahwnd: Thandle);
    function OnBeforeSkin(ahwnd: Thandle; aname: string): boolean;
    procedure DeleteAllThreads;
    procedure ActiveForm(aform: Tform);
    procedure DeleteDeleted;
    function IsDllForm(ahwnd: Thandle): boolean;
    procedure DeleteAllSub;
    procedure DeleteSubForm(amode: integer);
//    function AddForm(aHwnd:THandle):boolean;
    procedure WndProc(var Msg: TMessage);
  public
    Flist: Tlist;
    Mlist: Tlist;
    Dlist: Tlist;
    Threadlist: Tlist;
    sublist: Tlist;
    active: boolean;
    skinchildform: boolean;
    state: integer;
    menutype: integer;
    menuactive: boolean;
    MDIMax: boolean;
    WMSetDraw: boolean;
    clienthwnd: Thandle;
    MDIForm: Tform;
    action: integer;
    UpdateData: pointer;
    SBinstall: boolean;
    MainData: pointer;
    mode: integer;
    handle: HWND;
    lpara: integer;
    mmgr: TSkinmanage;
    constructor Create(amode: integer = 0);
    destructor Destroy; override;
    procedure InstallHook;
    function AddForm(aHwnd: THandle): boolean;
//    function AddMDIForm(atform:Tform):boolean;
    function DeleteForm(aHwnd: THandle): boolean;
    function GetMenuBg(amenu: Hmenu): Tbitmap;
    procedure UpdateSkinMenu(amenu: Hmenu);
    procedure FindPopupMenu(amenu: Hmenu);
    procedure SetMDIMax(b: boolean);
    procedure SetMDIMax2(b: boolean);
    procedure SetCaption(b: boolean);
    function GetMDIChildNum: integer;
    procedure SetAction(acode: integer; Interval: integer = 250);
    procedure AddSkinData(adata: Pointer);
    procedure RemoveSkinData(adata: Pointer);
    procedure DeleteSysbtn;
    procedure InstallThread(aThreadID: integer);
    procedure UnInstallThread(aThreadID: integer);
    function initsb(ahwnd: Thandle): boolean;
    function Uninitsb(ahwnd: Thandle): boolean;
    procedure SetPopMenu;
    procedure DeleteForm2(aHwnd: THandle);
    procedure DeleteForm3;
    procedure AssignData(adata: Pointer);
    procedure SetHMenu(hmenu: Thandle);
    procedure DeleteSub(p: Pointer);
  end;
//var HookCallback,WndCallBack,WndCallRet : HHOOK;
var
  SkinManager: TSkinManage;
  RM_GetObjectInstance: DWORD;
  ControlAtom: TAtom;
  PropName: string;
  myinstance: dword;

function SkinHookCallback(code: integer; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
function SkinHookCallRet(code: integer; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
function SkinHookCBT(code: integer; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
function SkinHookCBT2(code: integer; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;

implementation

uses winskinform, WinSkinData, menus, winsubclass;

var
  HookCallback, WndCallBack, WndCallRet: HHOOK;
  appDestory: boolean;

function SkinHookCallRet(code: integer; wParam: WPARAM; lParam: LPARAM): LRESULT;
var
  pwp: PCWPRETSTRUCT;
  s: string;
begin
  if code = HC_ACTION then begin
    pwp := PCWPRETSTRUCT(lparam);
    case pwp.message of
      WM_DRAWITEM: begin
//              SkinManager.WMDRAWITEM(PDrawItemStruct(pwp.lparam));
        end;
    end;
  end;
  result := CallNextHookEx(WndCallRet, Code, wParam, lParam);
end;

function SkinHookCallback(code: integer; wParam: WPARAM; lParam: LPARAM): LRESULT;
var
  pwp: PCWPSTRUCT;
  s: string;
  msg: Tmessage;
begin
  if code = HC_ACTION then begin
    pwp := PCWPSTRUCT(lparam);
{     if skincanlog then begin
        msg.msg:=pwp.message;
        msg.wparam:=pwp.wparam;
        msg.lparam:=pwp.lparam;
        skinaddlog('Hook:'+msgtostr(msg));
     end; }
    case pwp.message of
      WM_CREATE: SkinManager.AddMenu(pwp.hwnd);
      WM_DESTROY, WM_NCDESTROY: SkinManager.DeleteMenu(pwp.hwnd);
      WM_INITMENU: begin
//              skinaddlog('WH_CALLWNDPROC : WM_INITMENU');
          skinmanager.FindPopupMenu(pwp^.wparam);
        end;
{        WM_DRAWITEM: begin
              skinaddlog('WH_CALLWNDPROC : WM_DRAWITEM');
           end;}
    end;
  end;
  result := CallNextHookEx(WndCallback, Code, wParam, lParam);
end;

function SkinHookCBT(code: integer; wParam: WPARAM; lParam: LPARAM): LRESULT;
var
  s: string;
  hwnd: Thandle;
  ptr: ^CBT_CREATEWND;
  sf: dword;
  sd: Tskindata;
begin
//message box WM_ACTIVATE TMessageForm
//Dlg ****WM_ACTIVATE #32770 WA_ACTIVE
  if (appDestory) then begin
    result := CallNextHookEx(HookCallback, Code, wParam, lParam);
    exit;
  end;

  if (code >= 0) then begin
    case code of
      HCBT_ACTIVATE: begin
          if skinmanager.state = skin_creating then
            inc(skinmanager.state);
          hwnd := Thandle(wParam);
          if SkinManager.addform(hwnd) then begin
          end;
        end;
      HCBT_DESTROYWND: begin
          hwnd := Thandle(wParam);
          SkinManager.DeleteMenu(hwnd);
           //if SkinManager.deleteform(hwnd) then begin
           //end;
        end;
      HCBT_CREATEWND: begin
          hwnd := Thandle(wParam);
          ptr := pointer(lparam);
          s := getwindowclassname(hwnd);
//           skinAddlog(format('***HCBT_CREATEWND %s %1x,%1x',[s,hwnd,ptr^.lpcs^.hwndParent]));
          if (s = 'ScrollBar') and ((ptr^.lpcs^.style and sbs_sizegrip) > 0) then begin
            s := getwindowclassname(ptr^.lpcs^.hwndParent);
            sf := SkinManager.findskinform(ptr^.lpcs^.hwndParent);
            if (sf > 0) then begin //     and (s='#32770')
              Twinskinform(sf).addcontrolh(hwnd);
//                  skinAddlog(format('*****Scrollbar %s %1x,%1x',[s,hwnd,ptr^.lpcs^.hwndParent]));
//                  result:=10;
//                  exit;
            end;
          end;
          if (ptr^.lpcs^.style and ws_child) = 0 then begin
               //skinAddlog(format('***Form Creater %s %1x (%1d,%1d)',[s,hwnd,ptr^.lpcs^.cx,ptr^.lpcs^.cy]));
            s := getwindowclassname(hwnd);
            if (s = '#32768') and (skinmanager.mmgr = nil) then
              SkinManager.AddMenu(hwnd);
//               sd:=SkinManager.maindata;
//               sd.DoDebug(s);
{               if (sd<>nil) and assigned(sd.OnNewform) then
                  try
                    sd.OnNewform(sd,hwnd,s);
                  except
                  end;       }
          end;
          if (ptr^.lpcs^.dwExStyle and ws_ex_mdichild) > 0 then begin
            SkinManager.addform(hwnd);
          end;
        end;
{         HCBT_MINMAX : begin
           hwnd := Thandle(wParam);
           if lparam = SW_MAXIMIZE then
               skinAddlog(format('***Form MAXIMIZE %1x ',[hwnd]));
         end;}
    end; //endcase
  end else begin
    if (code = HCBT_ACTIVATE) and (skinmanager.state = skin_creating) then
      inc(skinmanager.state);
  end;
  result := CallNextHookEx(HookCallback, Code, wParam, lParam);
end;

function SkinHookCBT2(code: integer; wParam: WPARAM; lParam: LPARAM): LRESULT;
var
  s: string;
  hwnd: Thandle;
  ptr: ^CBT_CREATEWND;
begin
//message box WM_ACTIVATE TMessageForm
//Dlg ****WM_ACTIVATE #32770 WA_ACTIVE
  if code >= 0 then begin
    case code of
      HCBT_ACTIVATE: begin
          if skinmanager.state = skin_creating then
            inc(skinmanager.state);
          hwnd := Thandle(wParam);
          if SkinManager.addform(hwnd) then begin
//               s:='****HCBT_ACTIVATE '+s;
//               skinAddlog(s);
          end;
        end;
      HCBT_DESTROYWND: begin
          hwnd := Thandle(wParam);
          SkinManager.DeleteMenu(hwnd);
          if SkinManager.deleteform(hwnd) then begin
          end;
        end;
      HCBT_CREATEWND: begin
          hwnd := Thandle(wParam);
          ptr := pointer(lparam);
          s := getwindowclassname(hwnd);
//           skinAddlog(format('***HCBT_CREATEWND %s %1x,%1x',[s,hwnd,ptr^.lpcs^.hwndParent]));
          if (s = 'ScrollBar') and (SkinManager.findskinform(ptr^.lpcs^.hwndParent) > 0) then begin
//              skinAddlog(format('***Scrollbar %s %1x,%1x',[s,hwnd,ptr^.lpcs^.hwndParent]));
            result := 10;
            exit;
          end;
          if s = '#32768' then
            SkinManager.AddMenu(hwnd); //don't create scrollbar
        end;
    end; //endcase
  end;
  result := CallNextHookEx(HookCallback, Code, wParam, lParam);
end;

constructor TSkinManage.Create(amode: integer = 0);
begin
  inherited create();
  if amode = 0 then begin
    flist := Tlist.create;
    Mlist := Tlist.create;
    dlist := Tlist.create;
    threadlist := Tlist.create;
    sublist := Tlist.create;
    mode := 0;
  end else
    mode := HInstance;
  active := false;
  menuactive := false;
  MDIMax := false;
  menutype := 0;
  mmgr := nil;
  Timer := TTimer.create(nil);
  timer.Interval := 100;
  timer.Ontimer := Ontimer;
  timer.enabled := false;
  SBinstall := false;
  skinchildform := false;
  wmsetdraw := false; //true;
  maindata := nil;
  state := skin_creating;
//   Handle := Classes.AllocateHWnd(WndProc);
  SBLib := 0;
//   SBLib := LoadLibrary('C:\MyFile\MySkin\ARTICLE\coolsb_src\coolsb2\Release\coolsb2.dll');
//   SBLib := LoadLibrary('coolsb2.dll');
  pinitapp := nil;
  sbinstall := false;
  if SBLib <> 0 then begin
    pinitApp := GetProcAddress(SBLib, 'CoolSB_InitializeApp');
    pUninitApp := GetProcAddress(SBLib, 'CoolSB_UninitializeApp');
    pinitSB := GetProcAddress(SBLib, 'InitializeCoolSB');
    pUninitSb := GetProcAddress(SBLib, 'UninitializeCoolSB');
  end;
  if @pinitapp <> nil then
    SBinstall := boolean(pinitapp);
//   installhook;
end;

destructor TSkinManage.Destroy;
begin
  state := skin_destory;
  active := false;
  Timer.free;
  if @pUninitapp <> nil then pUninitapp;
  if (sblib <> 0) then
    FreeLibrary(sblib);
  if mode = 0 then begin
    DeleteAllThreads;
    if (sublist.Count > 0) or (flist.Count > 0) then
      deleteallforms;
    if flist <> nil then flist.free;
    deleteallmenus;
    dlist.free;
    deleteallsub;
  end else if HookCallback <> 0 then begin
    if assigned(mmgr) {and (mmgr.state <> skin_destory)} then begin
      mmgr.DeleteSub(self);
      mmgr.DeleteSubForm(mode);
    end;
      //AssignData(nil);
  end;
//   Classes.DeallocateHWnd(Handle);
  if HookCallback <> 0 then
    UnhookWindowsHookEx(HookCallback);
  appDestory := true;
  inherited destroy;
end;

procedure TSkinManage.InstallHook;
var
  dwThreadID: DWORD;
begin
  winversion := GetVersion();
//   skinaddlog(format('Windows Version %1x',[winversion]));
//   skinaddlog(format('Windows Version %1d %1d',[Win32MajorVersion,Win32MinorVersion]));
//   skinaddlog(format('winversion %1x',[winversion]));
  dwThreadID := GetCurrentThreadId;
//   WndCallback :=SetWindowsHookEx( WH_CALLWNDPROC,SkinHookCallback,0,dwThreadID);
//   WndCallRet :=SetWindowsHookEx( WH_CALLWNDPROCRET,SkinHookCallRet,0,dwThreadID);
  HookCallback := SetWindowsHookEx(WH_CBT, SkinHookCBT, 0, dwThreadID);
//   skinaddlog(format('ThreadId %1x',[dwThreadId]));
//   skinaddlog(format('HookCallback %1x',[HookCallback]));
end;

procedure TSkinManage.InstallThread(aThreadID: integer);
var
  obj: TSkinThread;
  b: boolean;
  i: integer;
begin
  b := false;
  for i := 0 to threadlist.count - 1 do begin
    obj := TSkinThread(threadlist[i]);
    if obj.threadID = aThreadID then begin
      b := true;
      break;
    end;
  end;
  if b then exit;
  obj := TSkinThread.create;
  obj.threadID := aThreadID;
  obj.hook := SetWindowsHookEx(WH_CBT, SkinHookCBT2, 0, aThreadID);
  threadlist.add(obj);
end;

procedure TSkinManage.UnInstallThread(aThreadID: integer);
var
  obj: TSkinThread;
  i: integer;
begin
  for i := 0 to threadlist.count - 1 do begin
    obj := TSkinThread(threadlist[i]);
    if obj.threadID = aThreadID then begin
      UnhookWindowsHookEx(obj.hook);
      threadlist.delete(i);
      break;
    end;
  end;
end;

procedure TSkinManage.DeleteAllThreads;
var
  obj: TSkinThread;
  i: integer;
begin
  for i := 0 to threadlist.count - 1 do begin
    obj := TSkinThread(threadlist[i]);
    UnhookWindowsHookEx(obj.Hook);
    obj.free;
  end;
  threadlist.clear;
  threadlist.free;
end;

function Tskinmanage.nestedform(ahwnd: Thandle): boolean;
var
  style: longword;
  s: string;
  phwnd: Thandle;
begin
  result := false;
  Style := GetWindowLong(ahwnd, GWL_STYLE);
  if (style and ws_child) = 0 then exit;
  Style := GetWindowLong(ahwnd, GWL_EXSTYLE);
  if (style and ws_ex_mdichild) > 0 then exit;
  phwnd := getparent(ahwnd);
  s := lowercase(getwindowclassname(phwnd));
  if s = 'mdiclient' then exit;
  result := true;
end;

procedure Tskinmanage.FindSkindata(var adata: pointer; ahwnd: Thandle);
var
  s: string;

  function FindOnlyThisForm: boolean;
  var
    i: integer;
    sd: Tskindata;
    sf: Tform;
  begin
    result := false;
    for i := 0 to dlist.count - 1 do begin
      sd := Tskindata(dlist.items[i]);
      sf := Tform(sd.owner);
      if (sd.skinformtype = sfOnlyThisForm) and (sf.handle = ahwnd) then begin
        adata := sd;
        result := true;
      end;
    end;
  end;

  function FindData(atype: TSkinFormType): boolean;
  var
    i: integer;
    sd: Tskindata;
  begin
    result := false;
    for i := 0 to dlist.count - 1 do begin
      sd := Tskindata(dlist.items[i]);
      if (sd.skinformtype = atype) then begin
        adata := sd;
        result := true;
      end;
    end;
  end;

begin
  if FindOnlyThisForm then exit;
  s := lowercase(getwindowclassname(ahwnd));
  if ((s = 'tmessageform') or (s = '#32770')) and finddata(sfDialog) then exit;
  if finddata(sfMainform) then exit;
  if dlist.count > 0 then adata := dlist.items[0]
  else adata := nil;
end;

function TSkinManage.OnBeforeSkin(ahwnd: Thandle; aname: string): boolean;
var
  b: boolean;
  i: integer;
  sd: Tskindata;
  s: string;
  dwstyle: Dword;
begin
  b := true;
  if maindata <> nil then begin
    s := lowercase(aname);
    if not (xoPreview in TSkindata(maindata).Options) then begin
      if (pos('preview', s) > 0) then b := false;
    end;
    dwstyle := GetWindowLong(ahwnd, GWL_STYLE);
     //file download dialog
    if (aname = '#32770') and ((dwstyle and DS_SETFOREGROUND) > 0) then b := false;
    if (s = 'tpopupdbtreeview') then b := false;
    TSkindata(maindata).DoFormSkin(ahwnd, aname, b);
  end;
{   for i:= 0 to dlist.count-1 do begin
       sd:=Tskindata(dlist.items[i]);
       if (sd.skinformtype=sfMainform) then begin
            sd.DoFormSkin(aname,b);
            break;
       end;
   end;}
  result := b;
end;

procedure TSkinManage.ActiveForm(aform: Tform);
var
  dwstyle: dword;
  b: boolean;
begin
  dwstyle := GetWindowLong(aform.handle, GWL_STYLE);
  b := (dwstyle and ws_child) > 0; //child
    //if aform.formstyle=fsmdichild then b:=false;//mdichild
  if not aform.Visible then b := true;
  if not b then addform(aform.handle);
end;

function TSkinManage.AddForm(aHwnd: THandle): boolean;
var
  aform: TWinskinform;
  atform: TForm;
  r: Trect;
  s: string;
  aptr: pointer;
  adata: Tskindata;
  isskin: integer;
  dw: dword;
  b: boolean;
begin
  result := false;
  if not active then exit;

  DeleteDeleted;

  isskin := sendmessage(ahwnd, CN_IsSkined, 0, 0);
// {$IFDEF demo}
//    atform:=findtform(ahwnd);
//    if atform<>nil then
//      setproperty(atform,'Caption',' ');
// {$endif}

  if isskin = 1 then exit;

  if findskinform(ahwnd) <> 0 then exit;

  atform := findtform(ahwnd);
  if (not skinchildform) and nestedform(ahwnd) then exit;

//   b:= (s='#32770') {or (s='TMessageForm')};
  s := getwindowclassname(ahwnd);
  dw := GetWindowLong(ahwnd, GWL_HINSTANCE);
  if (atform = nil) and (dw <> myinstance) and (s <> '#32770') then exit;
//   if (not b) and (atform=nil) and (not isdllform(ahwnd)) then exit;
//   if not isdllform(ahwnd) then exit;
//   TSkindata(maindata).DoDebug(s);

  getwindowrect(ahwnd, r);
  offsetrect(r, -r.left, -r.top);
  dw := GetWindowLong(ahwnd, GWL_EXSTYLE);
  if (r.right * r.bottom = 0) and ((dw and ws_ex_mdichild) = 0) then exit;
  if (atform <> nil) and (atform.tag = 99) then exit;

  if pos('TcxPopupEditPopupWindow', s) > 0 then exit;
  if pos('TTERenderWindow', s) > 0 then exit;
  if s = 'TApplication' then exit;
//   if s='TQRStandardPreview' then exit; //quickreport preview form
  if not OnBeforeSkin(ahwnd, s) then exit;

  FindSkindata(aptr, ahwnd);
  if aptr = nil then exit;

  adata := Tskindata(aptr);
  if adata.empty then exit;

  if atform <> nil then begin
    aform := Twinskinform.create(atform);
    aform.hwnd := ahwnd;
    aform.mode := mode;
    aform.formclass := s;
    aform.InitTform(adata, atform);
  end else begin
    aform := Twinskinform.create(nil);
    aform.hwnd := ahwnd;
    aform.mode := mode;
    aform.formclass := s;
    aform.initDlg(adata);
  end;

  flist.add(aform);
//   LockWindowUpdate(ahwnd);
  postMessage(ahwnd, CN_NewForm, 0, 1000);
  result := true;
end;

{function TSkinManage.AddMDIForm(atform:Tform):boolean;
var aform:TWinskinform;
    r:Trect;
    s:string;
    aptr:pointer;
    adata:Tskindata;
    isskin:integer;
    ahwnd:Thandle;
begin
   result:=false;
   if not active then exit;
   DeleteDeleted;
   ahwnd:=atform.handle;
   isskin:=sendmessage(ahwnd,CN_IsSkined,0,0);
   if isskin=1 then exit;

   if not OnBeforeSkin(s) then exit;

   FindSkindata(aptr,ahwnd);
   if aptr=nil then exit;

   adata:=Tskindata(aptr);
   if adata.empty then exit;

   if atform<>nil then begin
      aform:=Twinskinform.create(atform);
      aform.hwnd:=ahwnd;
      aform.InitTform(adata,atform);
      flist.add(aform);
      postMessage(ahwnd, CN_NewForm, 0, 1000);
      result:=true;
   end;
end;    }

function TSkinManage.DeleteForm(aHwnd: THandle): boolean;
var
  i: integer;
  sf: TWinSkinform;
begin
  if (state = skin_destory) then exit;
  result := false;
  for i := 0 to flist.count - 1 do begin
    sf := TWinSkinform(flist[i]);
    if sf.hwnd = ahwnd then begin
      if sf.FForm = nil then exit;
      sf.Skinstate := skin_Destory;
      sf.unsubclass;
      flist.delete(i);
      sf.free;
      sf := nil;
      result := true;
      break;
    end;
  end;
end;

procedure TSkinManage.DeleteForm2(aHwnd: THandle);
var
  i: integer;
  sf: TWinSkinform;
begin
  if (state = skin_destory) then exit;
  for i := 0 to flist.count - 1 do begin
    sf := TWinSkinform(flist[i]);
    if sf.hwnd = ahwnd then begin
      flist.delete(i);
      break;
    end;
  end;
end;

procedure TSkinManage.DeleteDeleted;
var
  i: integer;
  sf: TWinSkinform;
begin
  if (state = skin_destory) then exit;
  for i := flist.count - 1 downto 0 do begin
    sf := TWinSkinform(flist[i]);
    if IsBadReadPtr(sf, InstanceSize) then begin
      flist.delete(i);
    end else if (sf.skinstate = skin_Deleted) and (sf.mode = mode) then begin
         //sf.UnSubclass3;
      flist.delete(i);
      sf.free;
    end;
  end;
end;

procedure TSkinManage.DeleteAllForms;
var
  i: integer;
  sf: TWinSkinform;
begin
  active := false;
//    DeleteDeleted;
  for i := flist.count - 1 downto 0 do begin
    sf := TWinSkinform(flist[i]);
    if IsBadReadPtr(sf, InstanceSize) then continue;
//??  remove dialog
    if sf.mode <> mode then continue;
        //sf.Skinstate:=skin_Destory;
    flist.delete(i);
    sf.unsubclass3;
    sf.free;
  end;
end;

procedure TSkinManage.DeleteSubForm(amode: integer);
var
  i: integer;
  sf: TWinSkinform;
begin
  for i := flist.count - 1 downto 0 do begin
    sf := TWinSkinform(flist[i]);
    if IsBadReadPtr(sf, InstanceSize) then continue;
    if sf.mode <> amode then continue;
        //sf.Skinstate:=skin_Destory;
    flist.delete(i);
    sf.FForm.Free;
        //sf.unsubclass3;
        //sf.free;
  end;
end;

procedure TSkinManage.DeleteForm3;
var
  i: integer;
  sf: TWinSkinform;
begin
  if (state = skin_destory) then exit;
  for i := flist.count - 1 downto 0 do begin
    sf := TWinSkinform(flist[i]);
    if sf.skinstate = skin_deleted then begin
      flist.delete(i);
      sf.free;
    end;
  end;
end;

procedure TSkinManage.AddSkinData(adata: Pointer);
begin
  dlist.add(adata);
  if (maindata = nil) and (TSkindata(adata).skinformtype = sfmainform) then
    maindata := adata;
end;

procedure TSkinManage.RemoveSkinData(adata: Pointer);
var
  i: integer;
begin
  i := dlist.indexof(adata);
  if i <> -1 then begin
    dlist[i] := nil;
    dlist.delete(i);
  end;
end;

procedure TSkinManage.AssignData(adata: Pointer);
var
  d: TSkinmanage;
begin
  if adata <> nil then begin
    d := TskinManage(adata);
    flist := d.Flist;
    Mlist := d.Mlist;
    dlist := d.Dlist;
    threadlist := d.Threadlist;
    maindata := d.MainData;
    mmgr := d;
    state := 1;
    active := d.active;
      //active:=false;
    d.sublist.Add(self);
  end else begin
    flist := nil;
    Mlist := nil;
    dlist := nil;
    threadlist := nil;
    maindata := nil;
    active := false;
    state := skin_destory;
    if HookCallback <> 0 then
      UnhookWindowsHookEx(HookCallback);
    HookCallback := 0;
  end;
end;

procedure TSkinManage.DeleteAllMenus;
var
  i: integer;
  sm: TWinSkinPopMenu;
begin
  for i := 0 to mlist.count - 1 do begin
    sm := TWinSkinPopMenu(mlist[i]);
    sm.free;
  end;
  mlist.clear;
  mlist.free;
  mlist := nil;
end;

procedure TSkinManage.DeleteAllSub;
var
  i: integer;
  sm: TSkinmanage;
begin
  for i := 0 to sublist.count - 1 do begin
    sm := TSkinManage(sublist[i]);
    if not IsBadReadPtr(TSkinManage(sublist[i]), InstanceSize) then
      sm.Assigndata(nil);
//      sm.Assigndata(nil);
      //sm.Free;
  end;
  sublist.clear;
  sublist.free;
  sublist := nil;
end;

procedure TSkinManage.DeleteSub(p: Pointer);
var
  i: integer;
begin
  if sublist = nil then exit;
  if IsBadReadPtr(sublist, InstanceSize) then exit;

  for i := 0 to sublist.count - 1 do begin
    if sublist[i] = p then begin
      sublist.delete(i);
      break;
    end;
  end;
end;

procedure TSkinManage.SetPopMenu;
var
  i: integer;
  sm: TWinSkinPopMenu;
begin
//   i:= mlist.count;
//   if i=0 then exit;
  for i := 0 to mlist.count - 1 do begin
    sm := TWinSkinPopMenu(mlist[i]);
    sm.ownerdraw := true;
  end;
end;

procedure TSkinManage.SetHMenu(hmenu: Thandle);
var
  i: integer;
  sm: TWinSkinPopMenu;
begin
//   i:= mlist.count;
//   if i=0 then exit;
  for i := mlist.count - 1 downto 0 do begin
    sm := TWinSkinPopMenu(mlist[i]);
    if sm.hmenu = 0 then begin
      sm.hmenu := hmenu;
      break;
    end;
  end;
end;

function TSkinManage.FindSkinForm(aHwnd: THandle): dword;
var
  i: integer;
  sf: TWinSkinform;
begin
  result := 0;
  for i := 0 to flist.count - 1 do begin
    sf := TWinSkinform(flist[i]);
    if sf.hwnd = ahwnd then begin
      result := dword(sf);
      break;
    end;
  end;
end;

function TSkinManage.AddMenu(aHwnd: THandle): boolean;
var
  amenu: TWinSkinPopMenu;
  s: string;
  adata: Tskindata;
  aptr: pointer;
  isskin: integer;
begin
  result := false;
  if not active then exit;
  isskin := sendmessage(ahwnd, CN_IsSkined, 0, 0);
  if isskin = 1 then exit;

  if findskinMenu(ahwnd) then exit;

  FindSkindata(aptr, ahwnd);
  if aptr = nil then exit;

  adata := Tskindata(aptr);
//   if (adata.empty) or (not(xcMainmenu in adata.SkinControls)) then exit;
  if (adata.empty) then exit;
  case menutype of
    m_popup: if (not (xcPopupmenu in adata.SkinControls)) then exit;
    m_menuitem: if (not (xcMainmenu in adata.SkinControls)
        and not (xcMenuitem in adata.SkinControls)) then exit;
    m_systemmenu: if (not (xcSystemmenu in adata.SkinControls)) then exit;
  end;

  amenu := TWinSkinPopMenu.create;
  amenu.InitSkin(ahwnd, adata, 0);
  Mlist.add(amenu);
  if menuactive then amenu.ownerdraw := true;
end;

function TSkinManage.DeleteMenu(aHwnd: THandle): boolean;
var
  i: integer;
  sm: TWinSkinPopMenu;
begin
  result := false;
   //work for multilizer
   //if mlist=nil then exit;
  if IsBadReadPtr(mlist, InstanceSize) then exit;
  for i := 0 to mlist.count - 1 do begin
    sm := TWinSkinPopMenu(mlist[i]);
    if sm.hwnd = ahwnd then begin
      sm.unsubclass;
      mlist.delete(i);
      sm.free;
      result := true;
      break;
    end;
  end;
  if mlist.count = 0 then begin
    menuactive := false;
    menutype := 0;
  end;
end;

function TSkinManage.FindSkinMenu(aHwnd: THandle): boolean;
var
  i: integer;
  sm: TWinSkinPopMenu;
begin
  result := false;
  for i := 0 to mlist.count - 1 do begin
    sm := TWinSkinPopMenu(mlist[i]);
    if sm.hwnd = ahwnd then begin
      result := true;
      break;
    end;
  end;
end;

procedure TSkinManage.UpdateSkinMenu(amenu: Hmenu);
var
  i: integer;
  mh: Thandle;
begin
{   mh:=FindWindowex(0,0,'#32768',nil);
   if (mh<>0) and (mh<>smenu.hwnd) then begin
      smenu.InitSkin(mh,GSkinData,amenu);
   end;}
end;

function TSkinManage.GetMenuBg(amenu: Hmenu): Tbitmap;
var
  i: integer;
begin
  result := nil;
  for I := 0 to mlist.count - 1 do
    if TWinSkinPopMenu(mlist[i]).hmenu = amenu then begin
      result := TWinSkinPopMenu(mlist[i]).menubg;
      break;
    end;
end;

procedure TSkinManage.FindPopupMenu(amenu: Hmenu);
var
  i: integer;
begin
  for I := 0 to PopupList.count - 1 do
    if TPopupMenu(PopupList[i]).handle = amenu then begin
      menuactive := true;
      break;
    end;
end;

procedure TSkinManage.SetMDIMax(b: boolean);
var
  i: integer;
  sf: Twinskinform;
  sd: TSkinData;
begin
  if mdimax = b then exit;
  mdimax := b;
  sd := SkinManager.maindata;

  if (xoMDIChildBorder in sd.Options) then exit;

  for I := 0 to flist.count - 1 do begin
    sf := TWinSkinform(flist[i]);
    if sf.formstyle = sfsmdichild then begin
      if b then begin
        if sf.crop then sf.Uncropwindow;
        sf.EnableSysbtn(b);
      end else begin
        if sf.windowstate <> swsmin then begin
          sf.windowstate := swsnormal;
          sf.cropwindow;
          sf.EnableSysbtn(b);
          if not sf.crop then sf.refresh;
        end else sf.EnableSysbtn(true);
      end;
    end;
  end;
//   if b then skinaddlog('***** SetMdiMax True')
//   else skinaddlog('***** SetMdiMax Flase');
end;

procedure TSkinManage.SetMDIMax2(b: boolean);
var
  i: integer;
  sf: Twinskinform;
begin
  if mdimax = b then exit;
  mdimax := b;
  for I := 0 to flist.count - 1 do begin
    sf := TWinSkinform(flist[i]);
    if sf.formstyle = sfsmdichild then begin
      if b then begin
        if sf.crop then sf.Uncropwindow;
        sf.EnableSysbtn(b);
      end else begin
        if sf.windowstate <> swsmin then begin
          sf.windowstate := swsnormal;
          sf.cropwindow;
          sf.EnableSysbtn(b);
          if not sf.crop then sf.refresh;
        end else sf.EnableSysbtn(true);
      end;
    end;
  end;
  if b then skinaddlog('***** SetMdiMax True')
  else skinaddlog('***** SetMdiMax Flase');
end;

procedure TSkinManage.SetCaption(b: boolean);
var
  i: integer;
  sf: Twinskinform;
  dwstyle: Dword;
begin
  for I := 0 to flist.count - 1 do begin
    sf := TWinSkinform(flist[i]);
    if sf.formstyle = sfsmdichild then begin
      dwstyle := GetWindowLong(sf.hwnd, GWL_STYLE);
      dwstyle := dwstyle or WS_CAPTION;
      SetWindowLong(sf.hwnd, GWL_STYLE, dwstyle);
    end;
  end;
end;

function TSkinManage.GetMDIChildNum: integer;
var
  i: integer;
  sf: Twinskinform;
begin
  result := 0;
  for I := 0 to flist.count - 1 do begin
    sf := TWinSkinform(flist[i]);
    if sf.formstyle = sfsmdichild then
      inc(result);
  end;
end;

{function EnumProp(ahwnd:HWND;prop:Pchar;data:Thandle):boolean;stdcall;
var s:string;
    p:dword;
    buf: array[0..31] of Char;
begin
     //p:=GetProp(ahwnd,prop);
//     s:=format('%4x',[data]);
//     if pos('FF',s)=1 then exit;
//     StrCopy(buf,prop);
    result:=true;
    if ATOM(prop) = dword(prop) then exit;

    result:=true;
    s:=format('%s',[prop]);
    if pos('ControlOfs',s)=1 then begin
//        b:=true;
        result:=false;
    end;
end; }

function TSkinManage.IsDllForm(ahwnd: Thandle): boolean;
var
  b: boolean;
  i: integer;

  function EnumProp(ahwnd: HWND; prop: Pchar; data: Thandle): boolean; stdcall;
  var
    s: string;
    p: ^integer;
  begin
    result := true;
    if ATOM(prop) = dword(prop) then exit;
    s := strpas(prop);
    if pos('ControlOfs', s) = 1 then begin
      result := false;
    end;
  end;
begin
  b := true;
  i := 0;
  i := EnumProps(ahwnd, @enumprop);
  if i = 0 then result := false
  else result := true;
end;

function TSkinManage.FindTForm(ahwnd: Thandle): TForm;
var
  i: integer;
  aform: TForm;
begin
  aform := nil;
  for I := 0 to Screen.FormCount - 1 do begin
    if Screen.Forms[I].handle = ahwnd then begin
      aform := Screen.Forms[I];
      break;
    end;
  end;
  if aform = nil then
    aform := Tform(FindControlx(ahwnd));
  result := aform;
//  Result := TForm(SendMessage(ahwnd, RM_GetObjectInstance, 0, 0)) ;
end;

procedure TSkinManage.SetAction(acode: integer; Interval: integer = 250);
var
  i: integer;
  sm: Tskinmanage;
begin
  action := acode;
  timer.Interval := interval;
  if (state = skin_creating) then begin
    if acode = skin_Active then active := true
    else if acode = skin_uninstall then active := false;
  end else begin
    if mode = 0 then begin
         //other skinmanager
      for i := 0 to sublist.count - 1 do begin
        sm := TSkinManage(sublist[i]);
        sm.UpdateData := UpdateData;
        if acode = skin_Active then begin
          sm.active := true;
          sm.SetAction(skin_Active, 300)
        end else if acode = skin_change then begin
               //sm.SetAction(skin_change,300)
        end else if acode = skin_uninstall then
          sm.active := false;
      end;
    end;
    timer.enabled := true;
  end;
end;

function EnumWindow(ahwnd: HWND; lParam: LPARAM): boolean; stdcall;
var
  s: string;
  r: Trect;
begin
  result := false;
//   if (GetParent(ahwnd)= lparam) then begin
  s := getwindowclassname(ahwnd);
  getwindowrect(ahwnd, r);
//      skinaddlog(format('***enumWindow %1x,%s (%1d,%1d,%1d,%1d)',
//             [ahwnd,s,r.left,r.top,r.right,r.bottom]));
  result := true;
//   end;
end;

function EnumAddWindow(ahwnd: HWND; lParam: LPARAM): boolean; stdcall;
var
  s: string;
  r: Trect;
begin
  result := true;
  Skinmanager.addform(ahwnd);
end;

procedure TSkinManage.DeleteSysbtn;
var
  i: integer;
  sf: TWinSkinform;
begin
  for i := 0 to flist.count - 1 do begin
    sf := TWinSkinform(flist[i]);
    if sf.fsd = updatedata then
      sf.DeleteSysbtn;
  end;
end;

function TSkinManage.initsb(ahwnd: Thandle): boolean;
begin
  result := false;
  if SBinstall and (@pinitsb <> nil) then
    result := boolean(pinitsb(ahwnd));
end;

function TSkinManage.Uninitsb(ahwnd: Thandle): boolean;
begin
  result := false;
  if SBinstall and (@pUninitsb <> nil) then
    result := boolean(pUninitsb(ahwnd));
end;

procedure TSkinManage.WndProc(var Msg: TMessage);
var
  ahwnd: hwnd;
  sf: TWinSkinform;
begin
  if (msg.Msg = CN_SkinNotify) then begin
    ahwnd := msg.LParam;
    if (msg.WParam = skin_update) then begin
      sf := TWinSkinform(findskinform(ahwnd));
      if sf <> nil then begin
        application.ProcessMessages();
        sleep(10);
        sf.UnSubclass();
        sf.skinstate := skin_Deleted;
        deleteDeleted;
        sleep(10);
        application.ProcessMessages();
        AddForm(ahwnd);
      end;
    end;
    msg.result := 0;
  end else
    msg.Result := DefWindowProc(handle, msg.msg, msg.wParam, msg.lParam);
end;

procedure TSkinManage.OnTimer(Sender: TObject);
var
  i: integer;
  sf: TWinSkinform;
  sd: TSkindata;
  sm: Tskinmanage;
  ahwnd: Thandle;
begin
  timer.enabled := false;
  if UpdateData = nil then exit;
  sd := TSkindata(updateData);
  if sd.SkinFormtype = sfOnlyThisForm then begin
    case action of
      skin_uninstall: begin
          active := false;
          DeleteDeleted;
          for i := flist.count - 1 downto 0 do begin
            sf := TWinSkinform(flist[i]);
            if sf.fsd = sd then begin
              sf.unsubclass;
              sf.repaint(sf.hwnd);
              flist.delete(i);
              sf.free;
              break;
            end;
          end;
        end;
      skin_change: begin
          DeleteDeleted;
          for i := 0 to flist.count - 1 do begin
            sf := TWinSkinform(flist[i]);
            if (sf.fsd = sd) then begin
              sf.DeleteSysbtn;
              sf.InitSkinData;
              sf.skinchange;
              break;
            end;
          end;
        end;
      skin_Active: begin
          active := true;
          skinchildform := true;
//         EnumThreadWindows(GetCurrentThreadId,@EnumAddWindow,0);
          for I := Screen.FormCount - 1 downto 0 do begin
            if Screen.Forms[I] = sd.Owner then begin
              activeform(Screen.Forms[I]);
              break;
            end;
          end;
          skinchildform := false;
        end;
      skin_deleted: deleteform3;
    end; //endcase
    sd.doskinchanged;
    UpdateData := nil;
  end else begin
    case action of
      skin_Active: begin
          active := true;
          wmsetdraw := false;
          skinchildform := true;
//         EnumThreadWindows(GetCurrentThreadId,@EnumAddWindow,0);
          DeleteDeleted;
          for I := Screen.FormCount - 1 downto 0 do begin
            ActiveForm(Screen.Forms[I]);
          end;
          skinchildform := false;
          if mode = 0 then begin
            for i := 0 to sublist.count - 1 do begin
              sm := TSkinManage(sublist[i]);
              sm.UpdateData := UpdateData;
              sm.active := true;
              sm.SetAction(skin_Active, 300)
            end;
          end;
        end;
      skin_uninstall: begin
          active := false;
          DeleteDeleted;
{          for i:= flist.count-1 downto 0 do begin
             sf:=TWinSkinform(flist[i]);
             sf.unsubclass;
             sf.repaint(sf.hwnd);
             flist.delete(i);
             sf.free;
          end;}
          while flist.count > 0 do begin
            sf := TWinSkinform(flist[0]);
            sf.unsubclass;
            sf.repaint(sf.hwnd);
            flist.delete(0);
            sf.free;
          end;

          if mode = 0 then begin
            for i := 0 to sublist.count - 1 do begin
              sm := TSkinManage(sublist[i]);
              sm.active := false;
            end;
          end;
{          for i:= flist.count-1 downto 0 do begin
             sf:=TWinSkinform(flist[i]);
             sf.unsubclass;
             sf.repaint(sf.hwnd);
             flist.delete(i);
             sf.free;
          end;}
        end;
      skin_change: begin
          DeleteDeleted;
          for i := 0 to flist.count - 1 do begin
            sf := TWinSkinform(flist[i]);
            if (sf.fsd = sd) {and (sf.mode=mode)} then begin
              sf.DeleteSysbtn;
              sf.InitSkinData;
            end;
          end;
//          for i:= flist.count-1 downto 0 do begin
          for i := 0 to flist.count - 1 do begin
            sf := TWinSkinform(flist[i]);
            if (sf.fsd = sd) {and (sf.mode=mode)} then
              sf.skinchange;
          end;
        end;
      skin_deleted: deleteform3;
      skin_update: begin
          ahwnd := lpara;
          sf := TWinSkinform(findskinform(ahwnd));
          if sf <> nil then begin
            sf.UnSubclass();
            sf.skinstate := skin_Deleted;
            deleteDeleted;
            AddForm(ahwnd);
          end;
          exit;
        end;
    end; //endcase
    sd.doskinchanged;
    UpdateData := nil;
  end;
end;

function LCIDToCodePage(ALcid: LCID): Cardinal;
var
//  {$IFDEF VER230}
//    Buf: array[0..6] of WideChar;
//  {$else}
  Buf: array[0..6] of Char;
//  {$endif}
begin
  GetLocaleInfo(ALcid, LOCALE_IDefaultAnsiCodePage, Buf, 6);
  Result := StrToIntDef(Buf, GetACP);
end;

procedure InitMsg;
var
  AtomText: array[0..31] of Char;
begin
  PropName := Format('ControlOfs%.8X%.8X', [HInstance, GetCurrentThreadID]);
  RM_GetObjectInstance := RegisterWindowMessage(PChar(PropName));
  DefaultUserCodePage := CP_ACP;
  myinstance := HInstance;
//  DefaultUserCodePage := 3; //CP_THREAD_ACP
  ControlAtom := GlobalAddAtom(
    StrFmt(AtomText, 'ControlOfs%.8X%.8X', [HInstance, GetCurrentThreadID]));
end;

procedure Fini;
var
  i: integer;
begin
  if skinmanager <> nil then
    SkinManager.free;
  SkinManager := nil;
end;

initialization
  Win32PlatformIsUnicode := (Win32Platform = VER_PLATFORM_WIN32_NT);
  isVista := (Win32MajorVersion <> 6);
  InitMsg;
  appDestory := false;
//  Win32PlatformIsUnicode := false;
//  skinmanager := TSkinManage.create;
//  skinmanager.installhook;
finalization
  fini;
//  if skinmanager<>nil then
//      SkinManager.free;
//  SkinManager:=nil;
end.

