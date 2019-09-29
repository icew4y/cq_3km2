// CodeGear C++ Builder
// Copyright (c) 1995, 2007 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Sqlconnedeh.pas' rev: 11.00

#ifndef SqlconnedehHPP
#define SqlconnedehHPP

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
#include <Variants.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Grids.hpp>	// Pascal unit
#include <Valedit.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <Dbctrlseh.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Sqlexpr.hpp>	// Pascal unit
#include <Dbconnadmin.hpp>	// Pascal unit
#include <Inifiles.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sqlconnedeh
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfEditDBXConn;
class PASCALIMPLEMENTATION TfEditDBXConn : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
__published:
	Sqlexpr::TSQLConnection* SQLConnection1;
	Valedit::TValueListEditor* ValueListEditor1;
	Dbctrlseh::TDBComboBoxEh* cbConnectionName;
	Stdctrls::TStaticText* StaticText1;
	Dbctrlseh::TDBComboBoxEh* cbDriverName;
	Stdctrls::TStaticText* StaticText2;
	Dbctrlseh::TDBComboBoxEh* cbLibraryName;
	Stdctrls::TStaticText* StaticText3;
	Dbctrlseh::TDBComboBoxEh* cbVendorLib;
	Stdctrls::TStaticText* StaticText4;
	Buttons::TBitBtn* bbConnect;
	Buttons::TBitBtn* bbOk;
	Buttons::TBitBtn* bbCancel;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall cbConnectionNameChange(System::TObject* Sender);
	void __fastcall cbDriverNameChange(System::TObject* Sender);
	void __fastcall bbConnectClick(System::TObject* Sender);
	void __fastcall cbLibraryNameChange(System::TObject* Sender);
	void __fastcall cbVendorLibChange(System::TObject* Sender);
	void __fastcall ValueListEditor1SetEditText(System::TObject* Sender, int ACol, int ARow, const AnsiString Value);
	
public:
	Dbconnadmin::_di_IConnectionAdmin ConnectionAdmin;
	bool Regeting;
	void __fastcall RegetProperties(void);
	void __fastcall AssignFromConnection(Sqlexpr::TSQLConnection* ASQLConnection1);
	void __fastcall AssignToConnection(Sqlexpr::TSQLConnection* ASQLConnection1);
public:
	#pragma option push -w-inl
	/* TCustomForm.Create */ inline __fastcall virtual TfEditDBXConn(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfEditDBXConn(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfEditDBXConn(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TfEditDBXConn(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TfEditDBXConn* fEditDBXConn;
extern PACKAGE bool __fastcall EditSQLConnection(Sqlexpr::TSQLConnection* ASQLConnection1);

}	/* namespace Sqlconnedeh */
using namespace Sqlconnedeh;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Sqlconnedeh
