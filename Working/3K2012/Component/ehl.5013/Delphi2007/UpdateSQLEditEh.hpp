// CodeGear C++Builder
// Copyright (c) 1995, 2007 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Updatesqlediteh.pas' rev: 11.00

#ifndef UpdatesqleditehHPP
#define UpdatesqleditehHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Datadrivereh.hpp>	// Pascal unit
#include <Memtableeh.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Ehlibvcl.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <Dbctrlseh.hpp>	// Pascal unit
#include <Memtabledataeh.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Updatesqlediteh
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TWaitMethod)(void);

class DELPHICLASS TUpdateSQLEditFormEh;
class PASCALIMPLEMENTATION TUpdateSQLEditFormEh : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
__published:
	Stdctrls::TButton* OkButton;
	Stdctrls::TButton* CancelButton;
	Stdctrls::TButton* HelpButton;
	Stdctrls::TButton* GenerateButton;
	Stdctrls::TButton* PrimaryKeyButton;
	Stdctrls::TButton* DefaultButton;
	Stdctrls::TComboBox* UpdateTableName;
	Comctrls::TTabSheet* FieldsPage;
	Comctrls::TTabSheet* SQLPage;
	Comctrls::TPageControl* PageControl;
	Stdctrls::TListBox* KeyFieldList;
	Stdctrls::TListBox* UpdateFieldList;
	Stdctrls::TGroupBox* GroupBox1;
	Stdctrls::TLabel* Label1;
	Memtableeh::TMemTableEh* FTempTable;
	Stdctrls::TCheckBox* QuoteFields;
	Stdctrls::TButton* GetTableFieldsButton;
	Menus::TPopupMenu* FieldListPopup;
	Menus::TMenuItem* miSelectAll;
	Menus::TMenuItem* miClearAll;
	Comctrls::TPageControl* PageControl1;
	Comctrls::TTabSheet* tsInsert;
	Comctrls::TTabSheet* tsModify;
	Comctrls::TTabSheet* tsDelete;
	Comctrls::TTabSheet* tsGetrec;
	Stdctrls::TMemo* MemoInsert;
	Stdctrls::TMemo* MemoModify;
	Stdctrls::TMemo* MemoDelete;
	Stdctrls::TMemo* MemoGetRec;
	Stdctrls::TCheckBox* cbUpdate;
	Stdctrls::TCheckBox* cbDelete;
	Stdctrls::TCheckBox* cbGetRec;
	Stdctrls::TCheckBox* cbInsert;
	Stdctrls::TComboBox* cbIncrementField;
	Stdctrls::TLabel* Label2;
	Stdctrls::TComboBox* cbIncrementObject;
	Stdctrls::TLabel* labelUpdateObjects;
	Comctrls::TTabSheet* tsSpecParams;
	Stdctrls::TCheckBox* cbSpecParams;
	Extctrls::TPanel* Panel11;
	Stdctrls::TLabel* Label5;
	Stdctrls::TLabel* Label6;
	Stdctrls::TCheckBox* cbUpdateFields;
	Stdctrls::TCheckBox* cbKeyFields;
	Stdctrls::TCheckBox* cbTableName;
	Stdctrls::TLabel* Label7;
	Extctrls::TPanel* Panel1;
	Extctrls::TPanel* Panel10;
	Stdctrls::TLabel* Label8;
	Extctrls::TBevel* Bevel4;
	Stdctrls::TButton* bLoadSpecString;
	Stdctrls::TMemo* mSpecParams;
	Extctrls::TBevel* Bevel1;
	Extctrls::TBevel* Bevel2;
	Extctrls::TBevel* Bevel3;
	Stdctrls::TMemo* MemoUpdateFields;
	Stdctrls::TMemo* MemoKeyFields;
	Dbctrlseh::TDBEditEh* dbeTableName;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall HelpButtonClick(System::TObject* Sender);
	void __fastcall DefaultButtonClick(System::TObject* Sender);
	void __fastcall GenerateButtonClick(System::TObject* Sender);
	void __fastcall PrimaryKeyButtonClick(System::TObject* Sender);
	void __fastcall PageControlChanging(System::TObject* Sender, bool &AllowChange);
	void __fastcall GetTableFieldsButtonClick(System::TObject* Sender);
	void __fastcall SettingsChanged(System::TObject* Sender);
	void __fastcall FormCloseQuery(System::TObject* Sender, bool &CanClose);
	void __fastcall UpdateTableNameChange(System::TObject* Sender);
	void __fastcall UpdateTableNameClick(System::TObject* Sender);
	void __fastcall SelectAllClick(System::TObject* Sender);
	void __fastcall ClearAllClick(System::TObject* Sender);
	void __fastcall cbInsertClick(System::TObject* Sender);
	void __fastcall MemoModifyKeyDown(System::TObject* Sender, Word &Key, Classes::TShiftState Shift);
	
private:
	Datadrivereh::TCustomSQLDataDriverEh* DataDriver;
	bool FSettingsChanged;
	bool FDatasetDefaults;
	AnsiString __fastcall GetTableRef(const AnsiString TabName, const AnsiString QuoteChar);
	bool __fastcall Edit(void);
	void __fastcall GenWhereClause(const AnsiString TabAlias, const AnsiString QuoteChar, Classes::TStrings* KeyFields, Classes::TStrings* SQL);
	void __fastcall GenDeleteSQL(const AnsiString TableName, const AnsiString QuoteChar, Classes::TStrings* KeyFields, Classes::TStrings* SQL);
	void __fastcall GenInsertSQL(const AnsiString TableName, const AnsiString QuoteChar, Classes::TStrings* UpdateFields, Classes::TStrings* SQL);
	void __fastcall GenModifySQL(const AnsiString TableName, const AnsiString QuoteChar, Classes::TStrings* KeyFields, Classes::TStrings* UpdateFields, Classes::TStrings* SQL);
	void __fastcall GenGetRecSQL(Classes::TStrings* SelectSQL, Classes::TStrings* KeyFields, Classes::TStrings* SQL);
	void __fastcall GenerateSQL(void);
	void __fastcall FillMemoFromList(Stdctrls::TMemo* Memo, Stdctrls::TListBox* List);
	void __fastcall GenerateSQLViaDBService(void);
	void __fastcall GetDataSetFieldNames(void);
	void __fastcall GetTableFieldNames(void);
	void __fastcall InitGenerateOptions(void);
	void __fastcall InitUpdateTableNames(void);
	void __fastcall SetButtonStates(void);
	void __fastcall SelectPrimaryKeyFields(void);
	void __fastcall SetDefaultSelections(void);
	void __fastcall ShowWait(TWaitMethod WaitMethod);
public:
	#pragma option push -w-inl
	/* TCustomForm.Create */ inline __fastcall virtual TUpdateSQLEditFormEh(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TUpdateSQLEditFormEh(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TUpdateSQLEditFormEh(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TUpdateSQLEditFormEh(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	#pragma option pop
	
};


#pragma option push -b-
enum TSQLToken { stSymbol, stAlias, stNumber, stComma, stEQ, stOther, stLParen, stRParen, stEnd };
#pragma option pop

class DELPHICLASS TSQLParser;
class PASCALIMPLEMENTATION TSQLParser : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	AnsiString FText;
	int FSourcePtr;
	int FTokenPtr;
	AnsiString FTokenString;
	TSQLToken FToken;
	bool FSymbolQuoted;
	TSQLToken __fastcall NextToken(void);
	bool __fastcall TokenSymbolIs(const AnsiString S);
	void __fastcall Reset(void);
	
public:
	__fastcall TSQLParser(const AnsiString Text);
	void __fastcall GetSelectTableNames(Classes::TStrings* List);
	void __fastcall GetUpdateTableName(AnsiString &TableName);
	void __fastcall GetUpdateFields(Classes::TStrings* List);
	void __fastcall GetWhereFields(Classes::TStrings* List);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TSQLParser(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE bool __fastcall EditDataDriverUpdateSQL(Datadrivereh::TCustomSQLDataDriverEh* ADataDriver);

}	/* namespace Updatesqlediteh */
using namespace Updatesqlediteh;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Updatesqlediteh
