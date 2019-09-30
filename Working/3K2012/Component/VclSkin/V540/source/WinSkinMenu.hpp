// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Winskinmenu.pas' rev: 10.00

#ifndef WinskinmenuHPP
#define WinskinmenuHPP

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
#include <Winskindata.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Winskinmenu
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TWinSkinPopMenu;
class PASCALIMPLEMENTATION TWinSkinPopMenu : public System::TObject 
{
	typedef System::TObject inherited;
	
protected:
	void *FPrevWndProc;
	void *FObjectInst;
	bool done;
	void __fastcall WinWndProc(Messages::TMessage &aMsg);
	void __fastcall Default(Messages::TMessage &Msg);
	void __fastcall AddLog(const Messages::TMessage &Msg);
	void __fastcall WMPrint(Messages::TMessage &Msg);
	void __fastcall WMPrintClient(Messages::TMessage &Msg);
	void __fastcall UpdateMenu(Messages::TMessage &Msg);
	void __fastcall NcPaint(Messages::TMessage &Msg);
	void __fastcall WMERASEBKGND(Messages::TMessage &Msg);
	
public:
	unsigned hwnd;
	Winskindata::TSkinData* fsd;
	int SelIndex;
	Graphics::TBitmap* MenuBg;
	HMENU hmenu;
	bool crop;
	HRGN clientRgn;
	bool ownerdraw;
	__fastcall TWinSkinPopMenu(void);
	__fastcall virtual ~TWinSkinPopMenu(void);
	void __fastcall InitSkin(unsigned ahwnd, Winskindata::TSkinData* afsd, HMENU amenu);
	void __fastcall UnSubClass(void);
};


//-- var, const, procedure ---------------------------------------------------
#define c_menuprop "WinSkinPopMenu"
extern PACKAGE TWinSkinPopMenu* newskinmenu;

}	/* namespace Winskinmenu */
using namespace Winskinmenu;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Winskinmenu
