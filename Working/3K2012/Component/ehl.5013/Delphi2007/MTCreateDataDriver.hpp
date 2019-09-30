// CodeGear C++Builder
// Copyright (c) 1995, 2007 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Mtcreatedatadriver.pas' rev: 11.00

#ifndef MtcreatedatadriverHPP
#define MtcreatedatadriverHPP

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
#include <Memtableeh.hpp>	// Pascal unit
#include <Datadrivereh.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Typinfo.hpp>	// Pascal unit
#include <Dbutilseh.hpp>	// Pascal unit
#include <Designintf.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Mtcreatedatadriver
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfMTCreateDataDriver;
class PASCALIMPLEMENTATION TfMTCreateDataDriver : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
__published:
	Stdctrls::TListBox* DataSetList;
	Stdctrls::TListBox* DataDriversList;
	Stdctrls::TButton* OkBtn;
	Stdctrls::TButton* CancelBtn;
	Stdctrls::TLabel* Label1;
	Stdctrls::TLabel* Label2;
	Extctrls::TBevel* Bevel1;
	Stdctrls::TLabel* Label3;
	void __fastcall OkBtnClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	
public:
	Memtableeh::TCustomMemTableEh* FDataSet;
	Designintf::_di_IDesigner FDesigner;
	bool __fastcall Edit(void);
	void __fastcall CheckComponent(const AnsiString Value);
public:
	#pragma option push -w-inl
	/* TCustomForm.Create */ inline __fastcall virtual TfMTCreateDataDriver(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfMTCreateDataDriver(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfMTCreateDataDriver(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TfMTCreateDataDriver(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	#pragma option pop
	
};


typedef void __fastcall (*TAssingDataDriverFuncPtrEh)(Datadrivereh::TDataDriverEh* DataDriver, Db::TDataSet* DataSet);

//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TfMTCreateDataDriver* fMTCreateDataDriver;
extern PACKAGE Classes::TStrings* DataDriversListItems;
extern PACKAGE TAssingDataDriverFuncPtrEh AssingDataDriverFuncPtrEh;
extern PACKAGE bool __fastcall EditMTCreateDataDriver(Memtableeh::TCustomMemTableEh* ADataSet, Designintf::_di_IDesigner ADesigner);

}	/* namespace Mtcreatedatadriver */
using namespace Mtcreatedatadriver;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Mtcreatedatadriver
