// CodeGear C++Builder
// Copyright (c) 1995, 2007 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Formselectfromlist.pas' rev: 11.00

#ifndef FormselectfromlistHPP
#define FormselectfromlistHPP

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
#include <Buttons.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Dbctrlseh.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <Contnrs.hpp>	// Pascal unit
#include <Sqldriverediteh.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Formselectfromlist
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfSelectFromList;
class PASCALIMPLEMENTATION TfSelectFromList : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
__published:
	Extctrls::TBevel* Bevel1;
	Buttons::TBitBtn* bbOk;
	Buttons::TBitBtn* bbCancel;
	Dbctrlseh::TDBComboBoxEh* cbEngine;
	Dbctrlseh::TDBComboBoxEh* cbDBService;
	Dbctrlseh::TDBEditEh* eDataBaseName;
	Stdctrls::TLabel* Label1;
	Stdctrls::TLabel* Label2;
	Stdctrls::TLabel* Label3;
	void __fastcall ListBox1DblClick(System::TObject* Sender);
	void __fastcall cbEngineChange(System::TObject* Sender);
	
private:
	Contnrs::TObjectList* FDBServiceEngineList;
	void __fastcall SetDBServiceEngineList(const Contnrs::TObjectList* Value);
	
public:
	void __fastcall UpdateComboboxes(void);
	__property Contnrs::TObjectList* DBServiceEngineList = {read=FDBServiceEngineList, write=SetDBServiceEngineList};
public:
	#pragma option push -w-inl
	/* TCustomForm.Create */ inline __fastcall virtual TfSelectFromList(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfSelectFromList(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfSelectFromList(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TfSelectFromList(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TfSelectFromList* fSelectFromList;
extern PACKAGE int __fastcall SelectFromList(Classes::TStrings* Items);

}	/* namespace Formselectfromlist */
using namespace Formselectfromlist;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Formselectfromlist
