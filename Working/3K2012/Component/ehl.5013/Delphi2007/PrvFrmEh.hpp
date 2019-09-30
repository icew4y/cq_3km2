// CodeGear C++Builder
// Copyright (c) 1995, 2007 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Prvfrmeh.pas' rev: 11.00

#ifndef PrvfrmehHPP
#define PrvfrmehHPP

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
#include <Dialogs.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Prvieweh.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Toolwin.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Prvfrmeh
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TPreviewFormEh;
class PASCALIMPLEMENTATION TPreviewFormEh : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
__published:
	Prvieweh::TPreviewBox* PreviewEh1;
	Comctrls::TToolBar* tbrMain;
	Comctrls::TToolButton* tbtPrint;
	Comctrls::TToolButton* tbtPrinterSetupDialog;
	Comctrls::TToolButton* tbtScale;
	Comctrls::TToolButton* tbtPrevPage;
	Comctrls::TToolButton* tbtNextPage;
	Comctrls::TToolButton* tbStop;
	Comctrls::TToolButton* tbClose;
	Extctrls::TSplitter* Splitter;
	Menus::TPopupMenu* pmnScale;
	Menus::TMenuItem* mni500;
	Menus::TMenuItem* mni200;
	Menus::TMenuItem* mni150;
	Menus::TMenuItem* mni100;
	Menus::TMenuItem* mni75;
	Menus::TMenuItem* mni50;
	Menus::TMenuItem* mni25;
	Menus::TMenuItem* mni10;
	Menus::TMenuItem* mniWidth;
	Menus::TMenuItem* mniFull;
	Controls::TImageList* imlMain;
	Comctrls::TStatusBar* stbMain;
	Extctrls::TTimer* Timer1;
	void __fastcall tbtPrintClick(System::TObject* Sender);
	void __fastcall tbtPrintDialogClick(System::TObject* Sender);
	void __fastcall tbtPrinterSetupDialogClick(System::TObject* Sender);
	void __fastcall tbtPrevPageClick(System::TObject* Sender);
	void __fastcall tbtNextPageClick(System::TObject* Sender);
	void __fastcall tbStopClick(System::TObject* Sender);
	void __fastcall tbCloseClick(System::TObject* Sender);
	void __fastcall mniScaleClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall SplitterCanResize(System::TObject* Sender, int &NewSize, bool &Accept);
	void __fastcall tbtScaleClick(System::TObject* Sender);
	void __fastcall PreviewEh1PrinterPreviewChanged(System::TObject* Sender);
	void __fastcall PreviewEh1OpenPreviewer(System::TObject* Sender);
	void __fastcall Timer1Timer(System::TObject* Sender);
	void __fastcall tbtNextPageMouseDown(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall tbtNextPageMouseUp(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall tbtPrevPageMouseDown(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall tbtPrevPageMouseUp(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall FormKeyDown(System::TObject* Sender, Word &Key, Classes::TShiftState Shift);
	void __fastcall FormClose(System::TObject* Sender, Forms::TCloseAction &Action);
	
private:
	Comctrls::TToolButton* FPressedButton;
	bool FNeedClose;
public:
	#pragma option push -w-inl
	/* TCustomForm.Create */ inline __fastcall virtual TPreviewFormEh(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TPreviewFormEh(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TPreviewFormEh(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TPreviewFormEh(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TPreviewFormEh* PreviewFormEh;

}	/* namespace Prvfrmeh */
using namespace Prvfrmeh;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Prvfrmeh
