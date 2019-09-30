// CodeGear C++Builder
// Copyright (c) 1995, 2007 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Memtabledesigneh.pas' rev: 11.00

#ifndef MemtabledesignehHPP
#define MemtabledesignehHPP

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
#include <Dsdesign.hpp>	// Pascal unit
#include <Dsndbcst.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Designeditors.hpp>	// Pascal unit
#include <Designintf.hpp>	// Pascal unit
#include <Designwindows.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Dbctrls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Gridseh.hpp>	// Pascal unit
#include <Mtcreatedatadriver.hpp>	// Pascal unit
#include <Dbgrideh.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Actnlist.hpp>	// Pascal unit
#include <Memtableeh.hpp>	// Pascal unit
#include <Dbgridehimpexp.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Memtabledesigneh
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TMemTableFieldsEditorEh;
class PASCALIMPLEMENTATION TMemTableFieldsEditorEh : public Dsdesign::TFieldsEditor 
{
	typedef Dsdesign::TFieldsEditor inherited;
	
__published:
	Comctrls::TPageControl* PageControl1;
	Comctrls::TTabSheet* TabSheet1;
	Comctrls::TTabSheet* TabSheet2;
	Dbgrideh::TDBGridEh* DBGridEh1;
	Comctrls::TTabSheet* TabSheet3;
	Buttons::TSpeedButton* SpeedButton1;
	Buttons::TSpeedButton* SpeedButton2;
	Buttons::TSpeedButton* SpeedButton3;
	Buttons::TSpeedButton* SpeedButton4;
	Buttons::TSpeedButton* SpeedButton5;
	Buttons::TSpeedButton* SpeedButton6;
	Buttons::TSpeedButton* SpeedButton7;
	Buttons::TSpeedButton* SpeedButton8;
	Actnlist::TActionList* ActionList1;
	Actnlist::TAction* actFetchParams;
	Actnlist::TAction* actAssignLocalData;
	Actnlist::TAction* actLoadFromMyBaseTable;
	Actnlist::TAction* actCreateDataSet;
	Actnlist::TAction* actSaveToMyBaseXmlTable;
	Actnlist::TAction* actSaveToMyBaseXmlUTF8Table;
	Actnlist::TAction* actSaveToBinaryMyBaseTable;
	Actnlist::TAction* actClearData;
	Menus::TPopupMenu* GridMenu;
	Menus::TMenuItem* GridCut;
	Menus::TMenuItem* GridCopy;
	Menus::TMenuItem* GridPaste;
	Menus::TMenuItem* GridDelete;
	Menus::TMenuItem* GridSelectAll;
	Buttons::TSpeedButton* SpeedButton9;
	Actnlist::TAction* actCreateDataDriver;
	void __fastcall actFetchParamsExecute(System::TObject* Sender);
	void __fastcall actAssignLocalDataExecute(System::TObject* Sender);
	void __fastcall actLoadFromMyBaseTableExecute(System::TObject* Sender);
	void __fastcall actCreateDataSetExecute(System::TObject* Sender);
	void __fastcall actSaveToMyBaseXmlTableExecute(System::TObject* Sender);
	void __fastcall actSaveToMyBaseXmlUTF8TableExecute(System::TObject* Sender);
	void __fastcall actSaveToBinaryMyBaseTableExecute(System::TObject* Sender);
	void __fastcall actClearDataExecute(System::TObject* Sender);
	void __fastcall actCreateDataSetUpdate(System::TObject* Sender);
	HIDESBASE void __fastcall SelectTable(System::TObject* Sender);
	void __fastcall GridCutClick(System::TObject* Sender);
	void __fastcall GridCopyClick(System::TObject* Sender);
	void __fastcall GridPasteClick(System::TObject* Sender);
	void __fastcall GridDeleteClick(System::TObject* Sender);
	void __fastcall GridSelectAllClick(System::TObject* Sender);
	void __fastcall DBGridEh1ContextPopup(System::TObject* Sender, const Types::TPoint &MousePos, bool &Handled);
	void __fastcall actCreateDataDriverExecute(System::TObject* Sender);
	
public:
	__fastcall virtual TMemTableFieldsEditorEh(Classes::TComponent* AOwner);
public:
	#pragma option push -w-inl
	/* TFieldsEditor.Destroy */ inline __fastcall virtual ~TMemTableFieldsEditorEh(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TMemTableFieldsEditorEh(Classes::TComponent* AOwner, int Dummy) : Dsdesign::TFieldsEditor(AOwner, Dummy) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TMemTableFieldsEditorEh(HWND ParentWindow) : Dsdesign::TFieldsEditor(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TMemTableEditorEh;
class PASCALIMPLEMENTATION TMemTableEditorEh : public Designeditors::TComponentEditor 
{
	typedef Designeditors::TComponentEditor inherited;
	
protected:
	virtual TMetaClass* __fastcall GetDSDesignerClass(void);
	
public:
	virtual void __fastcall ExecuteVerb(int Index);
	virtual AnsiString __fastcall GetVerb(int Index);
	virtual int __fastcall GetVerbCount(void);
public:
	#pragma option push -w-inl
	/* TComponentEditor.Create */ inline __fastcall virtual TMemTableEditorEh(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TComponentEditor(AComponent, ADesigner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TMemTableEditorEh(void) { }
	#pragma option pop
	
};


class DELPHICLASS TSQLDataDriverEhEditor;
class PASCALIMPLEMENTATION TSQLDataDriverEhEditor : public Designeditors::TComponentEditor 
{
	typedef Designeditors::TComponentEditor inherited;
	
public:
	virtual void __fastcall ExecuteVerb(int Index);
	virtual AnsiString __fastcall GetVerb(int Index);
	virtual int __fastcall GetVerbCount(void);
public:
	#pragma option push -w-inl
	/* TComponentEditor.Create */ inline __fastcall virtual TSQLDataDriverEhEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TComponentEditor(AComponent, ADesigner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TSQLDataDriverEhEditor(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TMemTableFieldsEditorEh* MemTableFieldsEditor;
extern PACKAGE void __fastcall ShowFieldsEditorEh(Designintf::_di_IDesigner Designer, Db::TDataSet* ADataset, TMetaClass* DesignerClass);
extern PACKAGE Dsdesign::TFieldsEditor* __fastcall CreateFieldsEditorEh(Designintf::_di_IDesigner Designer, Db::TDataSet* ADataset, TMetaClass* DesignerClass, bool &Shared);
extern PACKAGE void __fastcall Register(void);

}	/* namespace Memtabledesigneh */
using namespace Memtabledesigneh;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Memtabledesigneh
