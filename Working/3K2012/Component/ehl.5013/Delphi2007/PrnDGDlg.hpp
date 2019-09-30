// CodeGear C++Builder
// Copyright (c) 1995, 2007 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Prndgdlg.pas' rev: 11.00

#ifndef PrndgdlgHPP
#define PrndgdlgHPP

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
#include <Stdctrls.hpp>	// Pascal unit
#include <Printers.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Prndgdlg
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfPrnDBGridEhSetupDialog;
class PASCALIMPLEMENTATION TfPrnDBGridEhSetupDialog : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
__published:
	Stdctrls::TGroupBox* gbPrintFields;
	Stdctrls::TLabel* Label5;
	Stdctrls::TLabel* Label6;
	Stdctrls::TLabel* Label7;
	Stdctrls::TLabel* Label8;
	Stdctrls::TEdit* seUpMargin;
	Stdctrls::TEdit* seLowMargin;
	Stdctrls::TEdit* seLeftMargin;
	Stdctrls::TEdit* seRightMargin;
	Stdctrls::TCheckBox* cbFitWidthToPage;
	Stdctrls::TEdit* ePrintFont;
	Stdctrls::TCheckBox* cbAutoStretch;
	Stdctrls::TButton* bPrinterSetupDialog;
	Stdctrls::TButton* bPrintFont;
	Stdctrls::TButton* bOk;
	Stdctrls::TButton* bCancel;
	Dialogs::TFontDialog* FontDialog1;
	Dialogs::TPrinterSetupDialog* PrinterSetupDialog1;
	Stdctrls::TCheckBox* cbColored;
	Extctrls::TRadioGroup* rgFitingType;
	Stdctrls::TCheckBox* cbOptimalColWidths;
	void __fastcall bPrintFontClick(System::TObject* Sender);
	void __fastcall bPrinterSetupDialogClick(System::TObject* Sender);
	void __fastcall seMarginExit(System::TObject* Sender);
	void __fastcall fPrnDBGridEHSetupDialogShow(System::TObject* Sender);
	void __fastcall cbFitWidthToPageClick(System::TObject* Sender);
public:
	#pragma option push -w-inl
	/* TCustomForm.Create */ inline __fastcall virtual TfPrnDBGridEhSetupDialog(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfPrnDBGridEhSetupDialog(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfPrnDBGridEhSetupDialog(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TfPrnDBGridEhSetupDialog(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TfPrnDBGridEhSetupDialog* fPrnDBGridEhSetupDialog;

}	/* namespace Prndgdlg */
using namespace Prndgdlg;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Prndgdlg
