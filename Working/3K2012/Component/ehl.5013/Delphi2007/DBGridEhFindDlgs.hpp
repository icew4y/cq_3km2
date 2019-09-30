// CodeGear C++Builder
// Copyright (c) 1995, 2007 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Dbgridehfinddlgs.pas' rev: 11.00

#ifndef DbgridehfinddlgsHPP
#define DbgridehfinddlgsHPP

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
#include <Dbctrlseh.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <Dbgrideh.hpp>	// Pascal unit
#include <Toolctrlseh.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Dbgridehfinddlgs
{
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
struct TColumnFieldItemEh
{
	
public:
	AnsiString Caption;
	Dbgrideh::TColumnEh* Column;
} ;
#pragma pack(pop)

typedef DynamicArray<TColumnFieldItemEh >  TColumnFieldsArrEh;

class DELPHICLASS TDBGridEhFindDlg;
class PASCALIMPLEMENTATION TDBGridEhFindDlg : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
__published:
	Dbctrlseh::TDBComboBoxEh* cbText;
	Stdctrls::TButton* bFind;
	Stdctrls::TButton* bCancel;
	Stdctrls::TLabel* Label1;
	Dbctrlseh::TDBComboBoxEh* cbFindIn;
	Stdctrls::TLabel* Label2;
	Dbctrlseh::TDBComboBoxEh* cbMatchinType;
	Stdctrls::TLabel* cbMatchType;
	Dbctrlseh::TDBComboBoxEh* cbFindDirection;
	Stdctrls::TLabel* Label3;
	Dbctrlseh::TDBCheckBoxEh* cbCharCase;
	Dbctrlseh::TDBCheckBoxEh* cbUseFormat;
	Stdctrls::TLabel* Label4;
	Dbctrlseh::TDBComboBoxEh* dbcTreeFindRange;
	void __fastcall bFindClick(System::TObject* Sender);
	void __fastcall bCancelClick(System::TObject* Sender);
	void __fastcall cbFindInChange(System::TObject* Sender);
	void __fastcall cbTextChange(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, Word &Key, Classes::TShiftState Shift);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	
private:
	Dbgrideh::TCustomDBGridEh* FGrid;
	bool IsFirstTry;
	Dbgrideh::TColumnsEhList* FFindColumnsList;
	int FCurInListColIndex;
	DynamicArray<TColumnFieldItemEh >  FColumnFields;
	int FSourceHeight;
	
public:
	void __fastcall FillFindColumnsList(void);
	void __fastcall FillColumnsList(void);
	void __fastcall Execute(Dbgrideh::TCustomDBGridEh* AGrid, AnsiString Text, AnsiString ColumnFieldName, TColumnFieldsArrEh ColumnFields, bool Modal);
	__property Dbgrideh::TCustomDBGridEh* Grid = {read=FGrid};
public:
	#pragma option push -w-inl
	/* TCustomForm.Create */ inline __fastcall virtual TDBGridEhFindDlg(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TDBGridEhFindDlg(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TDBGridEhFindDlg(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TDBGridEhFindDlg(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	#pragma option pop
	
};


typedef void __fastcall (*TExecuteDBGridEhFindDialogProc)(Dbgrideh::TCustomDBGridEh* Grid, AnsiString Text, AnsiString FieldName, TColumnFieldsArrEh ColumnFields, bool Modal);

//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TDBGridEhFindDlg* DBGridEhFindDlg;
extern PACKAGE TExecuteDBGridEhFindDialogProc ExecuteDBGridEhFindDialogProc;
extern PACKAGE void __fastcall ExecuteDBGridEhFindDialog(Dbgrideh::TCustomDBGridEh* Grid, AnsiString Text, AnsiString FieldName, TColumnFieldsArrEh ColumnFields, bool Modal);

}	/* namespace Dbgridehfinddlgs */
using namespace Dbgridehfinddlgs;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Dbgridehfinddlgs
