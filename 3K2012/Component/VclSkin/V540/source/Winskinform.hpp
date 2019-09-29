// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Winskinform.pas' rev: 10.00

#ifndef WinskinformHPP
#define WinskinformHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Grids.hpp>	// Pascal unit
#include <Commctrl.hpp>	// Pascal unit
#include <Winskindata.hpp>	// Pascal unit
#include <Winsubclass.hpp>	// Pascal unit
#include <Consts.hpp>	// Pascal unit
#include <Typinfo.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Winskinform
{
//-- type declarations -------------------------------------------------------
struct NMCSBCUSTOMDRAW
{
	
public:
	#pragma pack(push,1)
	tagNMHDR hdr;
	#pragma pack(pop)
	unsigned dwDrawStage;
	HDC hdc;
	#pragma pack(push,1)
	Types::TRect rc;
	#pragma pack(pop)
	unsigned uItem;
	unsigned uState;
	unsigned nBar;
} ;

typedef NMCSBCUSTOMDRAW *pNMCSBCUSTOMDRAW;

class DELPHICLASS TNCObject;
class DELPHICLASS TWinSkinForm;
class DELPHICLASS TMenuBtn;
class DELPHICLASS TWinSysButton;
class DELPHICLASS TWinSkinMenu;
class PASCALIMPLEMENTATION TWinSkinMenu : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	void __fastcall Copymenu(HMENU source, HMENU dst);
	
public:
	DynamicArray<TMenuBtn* >  Buttons;
	Menus::TMainMenu* menu;
	#pragma pack(push,1)
	Types::TRect Bar;
	#pragma pack(pop)
	Winskindata::TSkinData* FSD;
	TWinSkinForm* SF;
	Graphics::TBitmap* bkmap;
	int count;
	bool topmenu;
	HMENU hmenu;
	__fastcall virtual TWinSkinMenu(Classes::TComponent* AOwner);
	__fastcall virtual ~TWinSkinMenu(void);
	void __fastcall UpdataBtn(void);
	void __fastcall UpdataBtn1(void);
	void __fastcall UpdataBtn2(unsigned newmenu);
	void __fastcall UpdataBtn3(void);
	void __fastcall DrawMenu(HDC dc, const Types::TRect &rc);
	TNCObject* __fastcall FindBtn(const Types::TPoint &p);
	void __fastcall MouseMove(const Types::TPoint &p);
	void __fastcall SetMenuRect(void);
};


#pragma option push -b-
enum TSkinFormStyle { sfsNormal, sfsMDIform, sfsMDIChild, sfsChild };
#pragma option pop

#pragma option push -b-
enum TSkinFormBorder { sbsSizeable, sbsSingle, sbsNone, sbsDialog };
#pragma option pop

#pragma option push -b-
enum TSkinFormIcon { sbiMax, sbiMin, sbiHelp, sbisystem, sbicaption };
#pragma option pop

typedef Set<TSkinFormIcon, sbiMax, sbicaption>  TSkinFormIcons;

#pragma option push -b-
enum TSkinWindowState { swsNormal, swsMax, swsMin };
#pragma option pop

class PASCALIMPLEMENTATION TWinSkinForm : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	bool done;
	bool done2;
	Classes::TWndMethod OldWndProc;
	void *FPrevWndProc;
	void *FObjectInst;
	void *FMDIWndProc;
	void *FMDIObjectInst;
	Graphics::TFont* CaptionFont;
	bool FActive;
	Forms::TBorderIcons BorderIcons;
	bool FOverrideOwnerDraw;
	Extctrls::TTimer* timer;
	WideString bstr;
	WideString astr;
	AnsiString classname;
	bool hassysbtn;
	bool menuauto;
	bool sMainMenu;
	#pragma pack(push,1)
	Types::TRect fClientRect;
	#pragma pack(pop)
	int msglock;
	unsigned poptime;
	int DoubleTime;
	int charwidth;
	unsigned parenthwnd;
	HICON DefIcon;
	int Iconx;
	void __fastcall GetIcon(Graphics::TBitmap* &bmp);
	void __fastcall DeleteControls(void);
	void __fastcall SetActive(const bool Value);
	void __fastcall WinWndProc(Messages::TMessage &aMsg);
	void __fastcall NewWndProc(Messages::TMessage &aMsg);
	void __fastcall Default(Messages::TMessage &Msg);
	void __fastcall WMActive(Messages::TMessage &Msg);
	void __fastcall WMNCCalcSize(Messages::TMessage &Msg);
	void __fastcall WMNCActive(Messages::TMessage &Msg);
	void __fastcall WMNCPaint(Messages::TMessage &Msg);
	void __fastcall WMNCMouseMove(Messages::TMessage &Msg);
	void __fastcall WMNCLButtonDown(Messages::TMessage &Msg);
	void __fastcall WMNCLBUTTONDBLCLK(Messages::TMessage &Msg);
	void __fastcall WMNCLButtonUp(Messages::TMessage &Msg);
	void __fastcall WMNCRButtonUp(Messages::TMessage &Msg);
	void __fastcall WMMouseMove(Messages::TMessage &Msg);
	void __fastcall WMNCHitTest(Messages::TMessage &Msg);
	void __fastcall WMSysCommand(Messages::TMessage &Msg);
	void __fastcall WMCommand(Messages::TMessage &Msg);
	void __fastcall WMINITMENU(HMENU hm);
	void __fastcall WMMEASUREITEM(Messages::TMessage &Msg);
	void __fastcall WMMEASUREITEMH(Messages::TMessage &Msg);
	void __fastcall WMDRAWITEM(Messages::TMessage &Msg);
	void __fastcall WMERASEBKGND(Messages::TMessage &Msg);
	void __fastcall WMSize(Messages::TMessage &Msg);
	void __fastcall WMGetMinMaxInfo(Messages::TMessage &Msg);
	void __fastcall CMDialogChar(Messages::TMessage &Message);
	void __fastcall WMCtlcolor(Messages::TMessage &Msg);
	void __fastcall WMWINDOWPOSCHANGED(Messages::TMessage &Msg);
	void __fastcall WMWindowPosChanging(Messages::TMessage &Msg);
	void __fastcall WMMDIACTIVATE(Messages::TMessage &aMsg);
	void __fastcall WMMDIACTIVATE2(Messages::TMessage &Msg);
	void __fastcall WMMDITile(Messages::TMessage &aMsg);
	void __fastcall WMReCreateWnd(Messages::TMessage &Msg);
	void __fastcall DrawLine(Graphics::TCanvas* acanvas, const Types::TRect &rc);
	void __fastcall CreateCaptionFont(void);
	void __fastcall Drawborder(int n, const Types::TRect &Rc, HDC dc);
	void __fastcall SetSysbtnRect(void);
	void __fastcall DrawAllSysbtn(Graphics::TCanvas* acanvas, const Types::TRect &rc);
	void __fastcall DrawMin(HDC dc);
	bool __fastcall SysBtnVisible(int i);
	TNCObject* __fastcall FindBtn(const Types::TPoint &Point);
	Types::TPoint __fastcall GetWinXY(short x, short y);
	void __fastcall SysBtnAction(short x, short y);
	void __fastcall UpdateNc(HDC adc = (HDC)(0x0));
	void __fastcall DrawFLine(HDC dc);
	void __fastcall ToolBarDrawButton(Comctrls::TToolBar* Sender, Comctrls::TToolButton* Button, Comctrls::TCustomDrawState State, bool &DefaultDraw);
	void __fastcall ToolBarDrawBackground(Comctrls::TToolBar* Sender, const Types::TRect &ARect, bool &DefaultDraw);
	void __fastcall MeasureItemPop(System::TObject* Sender, Graphics::TCanvas* ACanvas, int &Width, int &Height);
	Graphics::TBitmap* __fastcall GetMenuBG(void);
	void __fastcall DrawMenuCaption(Graphics::TCanvas* ACanvas, const Types::TRect &ARect);
	void __fastcall WMDrawMenuitem(Messages::TMessage &Msg);
	void __fastcall WMDrawMenuitemH(Messages::TMessage &Msg);
	void __fastcall DrawHMenuItem2(HMENU Amenu, System::TObject* Sender, Graphics::TCanvas* ACanvas, const Types::TRect &ARect, bool Selected);
	Menus::TMenuItem* __fastcall CreateMenuItem(HMENU amenu, int aid);
	void __fastcall DefaultMenuItem(System::TObject* Sender, Graphics::TCanvas* ACanvas, const Types::TRect &ARect, bool Selected);
	void __fastcall DrawItemText(Menus::TMenuItem* Item, Graphics::TCanvas* ACanvas, const Types::TRect &ARect, bool Selected);
	void __fastcall DoDrawText(Menus::TMenuItem* item, Graphics::TCanvas* ACanvas, const WideString ACaption, Types::TRect &Rect, bool Selected, int Flags);
	void __fastcall OnTimer(System::TObject* Sender);
	void __fastcall CancelMenu(void);
	TMenuBtn* __fastcall FindButtonFromAccel(Word Accel);
	void __fastcall CreateSysmenu(void);
	void __fastcall CreateSysmenu2(void);
	void __fastcall DoSysMenu(System::TObject* Sender);
	void __fastcall DoSysMenu2(System::TObject* Sender);
	bool __fastcall IsScrollControl(Classes::TComponent* acontrol);
	void __fastcall KeepClient(void);
	void __fastcall SelectMDIform(System::TObject* Sender);
	void __fastcall ChangeMDIStyle(void);
	Winsubclass::TSkinControl* __fastcall Lookupcontrol(unsigned ahwnd);
	void __fastcall GetWindowstate(void);
	void __fastcall GetFormstyle(void);
	void __fastcall PopSysmenu(const Types::TPoint &p);
	void __fastcall MDIChildAction(const int action);
	void __fastcall UnSubclassMDI(void);
	void __fastcall SubclassMDI(void);
	void __fastcall WinMDIProc(Messages::TMessage &aMsg);
	void __fastcall DefaultMDI(Messages::TMessage &Msg);
	void __fastcall DeleteSkinDeleted(void);
	void __fastcall InitToolbarMenu(Menus::TMenuItem* Item, bool enable);
	void __fastcall DrawIcon(HDC dc, const Types::TRect &rc);
	void __fastcall AfterSkin(void);
	void __fastcall DoSkinEdit(Controls::TWinControl* aEdit);
	void __fastcall GetBorderSize(void);
	void __fastcall UpdateStyle(bool b);
	void __fastcall DisableControl(Controls::TControl* Comp);
	bool __fastcall CheckSysmenu(void);
	void __fastcall MenuSelect(Messages::TMessage &Msg);
	void __fastcall BeginUpdate(void);
	void __fastcall StopUpdate(void);
	void __fastcall InitSkin(Winskindata::TSkinData* afsd);
	AnsiString __fastcall GetSysBtnHint(int i);
	
protected:
	WideString caption;
	#pragma pack(push,1)
	Types::TRect bw;
	#pragma pack(pop)
	#pragma pack(push,1)
	Types::TRect wTr;
	#pragma pack(pop)
	#pragma pack(push,1)
	Types::TRect ctr;
	#pragma pack(pop)
	#pragma pack(push,1)
	Types::TRect oldsize;
	#pragma pack(pop)
	int MenuHeight;
	int BtnCount;
	bool fInMenu;
	bool Creating;
	bool bidileft;
	bool fSizeable;
	bool fMaxable;
	bool fminable;
	bool isunicode;
	bool ismessagebox;
	bool ischildform;
	AnsiString backstr;
	Menus::TPopupMenu* sysmenu;
	unsigned ClientHwnd;
	unsigned NewChildHwnd;
	HMENU hmenu;
	HMENU hsysmenu;
	HMENU tempmenu;
	HMENU activemenu;
	Graphics::TColor formcolor;
	unsigned dwstyle;
	int RightBtn;
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	void __fastcall DrawSysbtn(TWinSysButton* btn, int i);
	void __fastcall ResizeForm(int i);
	bool __fastcall FindSkinComp(Controls::TControl* acomp);
	bool __fastcall FindSkinComp2(Controls::TWinControl* ctrl);
	void __fastcall InitControlA(Controls::TWinControl* wForm);
	void __fastcall InitChildCtrl(Controls::TWinControl* wForm);
	bool __fastcall Find3rdControl(AnsiString aname, Controls::TWinControl* comp);
	void __fastcall HintReset(void);
	
public:
	TNCObject* ActiveBtn;
	bool crop;
	unsigned WinRgn;
	Forms::TForm* FForm;
	unsigned Hwnd;
	Graphics::TCanvas* fCanvas;
	Graphics::TCanvas* fcanvas2;
	Winskindata::TSkinData* fsd;
	TWinSkinMenu* menu;
	DynamicArray<TWinSysButton* >  SysBtn;
	Graphics::TBitmap* IconBmp;
	Graphics::TBitmap* CaptionBuf;
	Classes::TList* Controllist;
	int fwidth;
	int fheight;
	int crwidth;
	int crheight;
	bool FWindowActive;
	TSkinFormStyle FormStyle;
	TSkinFormBorder FormBorder;
	TSkinFormIcons FormIcons;
	TSkinWindowState Windowstate;
	int Skinstate;
	Winsubclass::TSkinControl* Activeskincontrol;
	int mode;
	AnsiString formclass;
	__fastcall virtual TWinSkinForm(Classes::TComponent* AOwner);
	__fastcall virtual ~TWinSkinForm(void);
	void __fastcall Refresh(void);
	void __fastcall Minimize(void);
	void __fastcall Maximize(void);
	void __fastcall Restore(void);
	void __fastcall RestoreMDI(void);
	void __fastcall UnSubclass(void);
	void __fastcall UnSubclass2(void);
	void __fastcall UnSubclass3(void);
	bool __fastcall CheckMenu(TMenuBtn* Button);
	bool __fastcall MDIChildMax(void);
	void __fastcall ClickButton(TMenuBtn* Button);
	void __fastcall getClipMap(Graphics::TBitmap* fbmp);
	void __fastcall doLog(AnsiString msg);
	void __fastcall InitPopMenu(Controls::TWinControl* wForm, bool Enable, bool Update);
	void __fastcall InitMainMenu(Controls::TWinControl* wForm, bool Enable, bool Update);
	__property bool Active = {read=FActive, write=SetActive, nodefault};
	void __fastcall SkinChange(void);
	void __fastcall AddSysMenuitem(AnsiString acaption, int action);
	void __fastcall EnableSysbtn(bool b);
	void __fastcall Uncropwindow(void);
	void __fastcall Cropwindow(void);
	void __fastcall InitTform(Winskindata::TSkinData* afsd, Forms::TForm* aform);
	void __fastcall InitControls(Controls::TWinControl* wForm);
	void __fastcall AddComp(Controls::TControl* Comp, Controls::TWinControl* wForm);
	void __fastcall InitNestform(Controls::TWinControl* wForm);
	void __fastcall RePaint(unsigned ahwnd);
	void __fastcall InitSkinData(void);
	void __fastcall UpdateMainMenu(void);
	void __fastcall DeleteSysbtn(void);
	bool __fastcall AddControlList(Winsubclass::TSkinControl* acontrol);
	void __fastcall AddControlh(HWND ahwnd);
	void __fastcall InitHwndControls(unsigned ahwnd);
	void __fastcall DeleteControl(Winsubclass::TSkinControl* c);
	void __fastcall DrawMenuItem(System::TObject* Sender, Graphics::TCanvas* ACanvas, const Types::TRect &ARect, bool Selected);
	void __fastcall MeasureItem(System::TObject* Sender, Graphics::TCanvas* ACanvas, int &Width, int &Height);
	void __fastcall InitDlg(Winskindata::TSkinData* afsd);
};


class PASCALIMPLEMENTATION TNCObject : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	TWinSkinForm* SF;
	Winskindata::TSkinData* fsd;
	#pragma pack(push,1)
	Types::TRect bounds;
	#pragma pack(pop)
	bool visible;
	int state;
	bool enabled;
	virtual void __fastcall MouseDown(void);
	virtual void __fastcall MouseUp(void);
	virtual void __fastcall MouseEnter(void);
	virtual void __fastcall MouseLeave(void);
	virtual void __fastcall Draw(void);
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TNCObject(void) : System::TObject() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TNCObject(void) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TMenuBtn : public TNCObject 
{
	typedef TNCObject inherited;
	
public:
	Menus::TMenuItem* menuitem;
	Winskindata::TSkinData* FSD;
	int index;
	WideString caption;
	bool enabled;
	HMENU hsubmenu;
	int mid;
	virtual void __fastcall Draw(void);
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TMenuBtn(void) : TNCObject() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TMenuBtn(void) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TWinSysButton : public TNCObject 
{
	typedef TNCObject inherited;
	
public:
	Winskindata::TDataSkinSysButton* data;
	virtual void __fastcall Draw(void);
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TWinSysButton(void) : TNCObject() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TWinSysButton(void) { }
	#pragma option pop
	
};


typedef DynamicArray<TMenuBtn* >  WinSkinForm__5;

typedef DynamicArray<TWinSysButton* >  WinSkinForm__7;

class DELPHICLASS TWinSkinSpy;
class PASCALIMPLEMENTATION TWinSkinSpy : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
public:
	TWinSkinForm* sf;
	__fastcall virtual ~TWinSkinSpy(void);
public:
	#pragma option push -w-inl
	/* TComponent.Create */ inline __fastcall virtual TWinSkinSpy(Classes::TComponent* AOwner) : Classes::TComponent(AOwner) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
static const Word CN_FormUPdate = 0x3502;
static const Word CN_NewForm = 0x3503;
static const Word CN_IsSkined = 0x3523;
static const Word CN_NewMDIChild = 0x3516;
static const Word CN_ReCreateWnd = 0x3517;
static const Word CN_MenuSelect = 0x3518;
static const Word cKey1 = 0x6d41;
static const int cKey2 = 0x5cda3;
static const Shortint MAX_CLASSNAME = 0x64;
static const Shortint MAX_MENUITEM_TEXT = 0x40;
static const Word Max_MenuitemID = 0x1000;
extern PACKAGE char c_demo[13];
extern PACKAGE unsigned WinVersion;
extern PACKAGE Graphics::TBitmap* BG;
extern PACKAGE Classes::TStringList* Logstring;
extern PACKAGE bool SkinCanLog;
extern PACKAGE HMENU __fastcall CopyHMenu(HMENU amenu);
extern PACKAGE void __fastcall DeleteHMenu(HMENU amenu);
extern PACKAGE WideString __fastcall GetFormCaption(unsigned ahwnd);
extern PACKAGE AnsiString __fastcall GetFormCaptionA(unsigned ahwnd);
extern PACKAGE AnsiString __fastcall GetFormText(unsigned ahwnd);
extern PACKAGE bool __stdcall EnumControl(HWND ahwnd, int lParam);
extern PACKAGE AnsiString __fastcall GetWindowClassname(unsigned ahwnd);
extern PACKAGE AnsiString __fastcall MsgtoStr(const Messages::TMessage &aMsg);
extern PACKAGE void __fastcall DrawBGbmp(Graphics::TCanvas* acanvas, const Types::TRect &Dst, Graphics::TBitmap* Bitmap, const Types::TRect &SrcRect);
extern PACKAGE HRGN __fastcall BitmapToRegion(Graphics::TBitmap* bmp, int xx, int yy, Graphics::TColor TransparentColor = (Graphics::TColor)(0xff00ff), Byte RedTol = (Byte)(0x1), Byte GreenTol = (Byte)(0x1), Byte BlueTol = (Byte)(0x1));
extern PACKAGE void __fastcall DrawRect2(HDC DC, const Types::TRect &Dst, Graphics::TBitmap* Bmp, const Types::TRect &Src, int I, int N, int Trans = 0x0, int Tile = 0x0, int Spliter = 0x0);
extern PACKAGE void __fastcall DrawRectTile(Graphics::TCanvas* acanvas, const Types::TRect &Dst, Graphics::TBitmap* Bmp, const Types::TRect &Src, int I, int N, int Trans = 0x0, int Spliter = 0x1);
extern PACKAGE Graphics::TBitmap* __fastcall GetHMap(const Types::TRect &Dst, Graphics::TBitmap* Bmp, const Types::TRect &Src, int I, int N, int Tile = 0x0, int Spliter = 0x0);
extern PACKAGE void __fastcall DrawBorder(HDC Dc, const Types::TRect &Dst, Graphics::TBitmap* Bmp, const Types::TRect &Src, int I, int N, int Tile = 0x0, int Spliter = 0x0);
extern PACKAGE Graphics::TBitmap* __fastcall GetThumbMap(const Types::TRect &Dst, Graphics::TBitmap* Bmp, const Types::TRect &Src, int I, int N, int Tile = 0x0, int Spliter = 0x0);
extern PACKAGE int __fastcall Max(const int A, const int B);
extern PACKAGE int __fastcall Min(const int A, const int B);
extern PACKAGE void __fastcall Bitmapdraw(HDC DC, const Types::TRect &Dst, Graphics::TBitmap* Bmp);
extern PACKAGE void __fastcall DrawRect1(HDC DC, const Types::TRect &Dst, Graphics::TBitmap* Bmp, int I, int N, int Trans = 0x0);
extern PACKAGE void __fastcall DrawRect3(HDC DC, const Types::TRect &Dst, Graphics::TBitmap* Bmp, int I, int N, int Trans = 0x0);
extern PACKAGE void __fastcall DrawRectH(HDC DC, const Types::TRect &Dst, Graphics::TBitmap* Bmp, const Types::TRect &Src, int I, int N, int Tile = 0x0, int Spliter = 0x0);
extern PACKAGE void __fastcall DrawRectV(HDC DC, const Types::TRect &Dst, Graphics::TBitmap* Bmp, const Types::TRect &Src, int I, int N, int Tile = 0x0, int Spliter = 0x0);
extern PACKAGE void __fastcall DrawParentImage(Controls::TControl* Control, HDC DC, bool InvalidateParent = false);
extern PACKAGE void __fastcall DrawTranmap(HDC DC, const Types::TRect &Dst, Graphics::TBitmap* temp, Graphics::TColor transcolor = (Graphics::TColor)(0xff00ff));
extern PACKAGE void __fastcall SkinAddLog(AnsiString msg);

}	/* namespace Winskinform */
using namespace Winskinform;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Winskinform
