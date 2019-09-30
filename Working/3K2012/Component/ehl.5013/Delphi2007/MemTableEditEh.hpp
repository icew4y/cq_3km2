// CodeGear C++Builder
// Copyright (c) 1995, 2007 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Memtableediteh.pas' rev: 11.00

#ifndef MemtableeditehHPP
#define MemtableeditehHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Dsndbcst.hpp>	// Pascal unit
#include <Designintf.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Memtableeh.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Memtableediteh
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TMemTableDataForm;
class PASCALIMPLEMENTATION TMemTableDataForm : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
__published:
	Stdctrls::TGroupBox* GroupBox1;
	Stdctrls::TListBox* DataSetList;
	Stdctrls::TButton* OkBtn;
	Stdctrls::TButton* CancelBtn;
	Stdctrls::TButton* HelpBtn;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall OkBtnClick(System::TObject* Sender);
	void __fastcall HelpBtnClick(System::TObject* Sender);
	void __fastcall DataSetListDblClick(System::TObject* Sender);
	void __fastcall DataSetListKeyPress(System::TObject* Sender, char &Key);
	
private:
	Memtableeh::TCustomMemTableEh* FDataSet;
	Designintf::_di_IDesigner FDesigner;
	void __fastcall CheckComponent(const AnsiString Value);
	bool __fastcall Edit(void);
public:
	#pragma option push -w-inl
	/* TCustomForm.Create */ inline __fastcall virtual TMemTableDataForm(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TMemTableDataForm(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TMemTableDataForm(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TMemTableDataForm(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE bool __fastcall EditMemTable(Memtableeh::TCustomMemTableEh* ADataSet, Designintf::_di_IDesigner ADesigner);

}	/* namespace Memtableediteh */
using namespace Memtableediteh;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Memtableediteh
