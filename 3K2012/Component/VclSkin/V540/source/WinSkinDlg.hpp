// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Winskindlg.pas' rev: 10.00

#ifndef WinskindlgHPP
#define WinskindlgHPP

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
#include <Winskinmenu.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Winskindlg
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TSkinThread;
class PASCALIMPLEMENTATION TSkinThread : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	HHOOK hook;
	int ThreadID;
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TSkinThread(void) : System::TObject() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TSkinThread(void) { }
	#pragma option pop
	
};


typedef HRESULT __stdcall (*TSBAPI1)(HWND ahwnd);

typedef HRESULT __stdcall (*TSBAPI2)(void);

class DELPHICLASS TSkinManage;
class PASCALIMPLEMENTATION TSkinManage : public System::TObject 
{
	typedef System::TObject inherited;
	
protected:
	Extctrls::TTimer* Timer;
	unsigned SBLib;
	TSBAPI2 pinitApp;
	TSBAPI2 pUninitApp;
	TSBAPI1 pinitSB;
	TSBAPI1 pUninitSb;
	unsigned __fastcall FindSkinForm(unsigned aHwnd);
	void __fastcall DeleteAllForms(void);
	bool __fastcall AddMenu(unsigned aHwnd);
	bool __fastcall FindSkinMenu(unsigned aHwnd);
	bool __fastcall DeleteMenu(unsigned aHwnd);
	void __fastcall DeleteAllMenus(void);
	Forms::TForm* __fastcall FindTForm(unsigned ahwnd);
	void __fastcall OnTimer(System::TObject* Sender);
	bool __fastcall NestedForm(unsigned ahwnd);
	void __fastcall FindSkindata(void * &adata, unsigned ahwnd);
	bool __fastcall OnBeforeSkin(unsigned ahwnd, AnsiString aname);
	void __fastcall DeleteAllThreads(void);
	void __fastcall ActiveForm(Forms::TForm* aform);
	void __fastcall DeleteDeleted(void);
	bool __fastcall IsDllForm(unsigned ahwnd);
	void __fastcall DeleteAllSub(void);
	void __fastcall DeleteSubForm(int amode);
	void __fastcall WndProc(Messages::TMessage &Msg);
	
public:
	Classes::TList* Flist;
	Classes::TList* Mlist;
	Classes::TList* Dlist;
	Classes::TList* Threadlist;
	Classes::TList* sublist;
	bool active;
	bool skinchildform;
	int state;
	int menutype;
	bool menuactive;
	bool MDIMax;
	bool WMSetDraw;
	unsigned clienthwnd;
	Forms::TForm* MDIForm;
	int action;
	void *UpdateData;
	bool SBinstall;
	void *MainData;
	int mode;
	HWND handle;
	int lpara;
	TSkinManage* mmgr;
	__fastcall TSkinManage(int amode);
	__fastcall virtual ~TSkinManage(void);
	void __fastcall InstallHook(void);
	bool __fastcall AddForm(unsigned aHwnd);
	bool __fastcall DeleteForm(unsigned aHwnd);
	Graphics::TBitmap* __fastcall GetMenuBg(HMENU amenu);
	void __fastcall UpdateSkinMenu(HMENU amenu);
	void __fastcall FindPopupMenu(HMENU amenu);
	void __fastcall SetMDIMax(bool b);
	void __fastcall SetMDIMax2(bool b);
	void __fastcall SetCaption(bool b);
	int __fastcall GetMDIChildNum(void);
	void __fastcall SetAction(int acode, int Interval = 0xfa);
	void __fastcall AddSkinData(void * adata);
	void __fastcall RemoveSkinData(void * adata);
	void __fastcall DeleteSysbtn(void);
	void __fastcall InstallThread(int aThreadID);
	void __fastcall UnInstallThread(int aThreadID);
	bool __fastcall initsb(unsigned ahwnd);
	bool __fastcall Uninitsb(unsigned ahwnd);
	void __fastcall SetPopMenu(void);
	void __fastcall DeleteForm2(unsigned aHwnd);
	void __fastcall DeleteForm3(void);
	void __fastcall AssignData(void * adata);
	void __fastcall SetHMenu(unsigned hmenu);
	void __fastcall DeleteSub(void * p);
};


//-- var, const, procedure ---------------------------------------------------
static const Shortint skin_Creating = 0x0;
static const Shortint skin_Active = 0x1;
static const Shortint skin_uninstall = 0x2;
static const Shortint skin_change = 0x3;
static const Shortint skin_Destory = 0x4;
static const Shortint skin_Updating = 0x5;
static const Shortint skin_Deleted = 0x6;
static const Shortint skin_update = 0x7;
static const Shortint m_popup = 0x0;
static const Shortint m_systemmenu = 0x2;
static const Shortint m_menuitem = 0x1;
extern PACKAGE TSkinManage* SkinManager;
extern PACKAGE unsigned RM_GetObjectInstance;
extern PACKAGE Word ControlAtom;
extern PACKAGE AnsiString PropName;
extern PACKAGE unsigned myinstance;
extern PACKAGE int __stdcall SkinHookCallRet(int code, int wParam, int lParam);
extern PACKAGE int __stdcall SkinHookCallback(int code, int wParam, int lParam);
extern PACKAGE int __stdcall SkinHookCBT(int code, int wParam, int lParam);
extern PACKAGE int __stdcall SkinHookCBT2(int code, int wParam, int lParam);

}	/* namespace Winskindlg */
using namespace Winskindlg;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Winskindlg
