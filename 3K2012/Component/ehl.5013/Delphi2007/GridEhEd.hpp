// CodeGear C++ Builder
// Copyright (c) 1995, 2007 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gridehed.pas' rev: 11.00

#ifndef GridehedHPP
#define GridehedHPP

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
#include <Colnedit.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Designeditors.hpp>	// Pascal unit
#include <Designintf.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Actnlist.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Dbgrideh.hpp>	// Pascal unit
#include <Dblookupeh.hpp>	// Pascal unit
#include <Ehlibvcl.hpp>	// Pascal unit
#include <Psapi.hpp>	// Pascal unit
#include <Toolsapi.hpp>	// Pascal unit
#include <Toolwin.hpp>	// Pascal unit
#include <Toolctrlseh.hpp>	// Pascal unit
#include <Gridseh.hpp>	// Pascal unit
#include <Memtableeh.hpp>	// Pascal unit
#include <Datadrivereh.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Toolwnds.hpp>	// Pascal unit
#include <Designwindows.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gridehed
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TDBGridEhColumnsEditor;
class PASCALIMPLEMENTATION TDBGridEhColumnsEditor : public Colnedit::TCollectionEditor 
{
	typedef Colnedit::TCollectionEditor inherited;
	
__published:
	Menus::TMenuItem* N1;
	Menus::TMenuItem* AddAllFields1;
	Menus::TMenuItem* RestoreDefaults1;
	Comctrls::TToolButton* ToolButton6;
	Comctrls::TToolButton* ToolButton7;
	Comctrls::TToolButton* ToolButton8;
	Actnlist::TAction* AddAllFieldsCmd;
	Actnlist::TAction* RestoreDefaultsCmd;
	void __fastcall AddAllFieldsCmdExecute(System::TObject* Sender);
	void __fastcall RestoreDefaultsCmdExecute(System::TObject* Sender);
	void __fastcall AddAllFieldsCmdUpdate(System::TObject* Sender);
	void __fastcall RestoreDefaultsCmdUpdate(System::TObject* Sender);
	
protected:
	virtual bool __fastcall CanAdd(int Index);
public:
	#pragma option push -w-inl
	/* TDesignWindow.Create */ inline __fastcall virtual TDBGridEhColumnsEditor(Classes::TComponent* AOwner) : Colnedit::TCollectionEditor(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TDesignWindow.Destroy */ inline __fastcall virtual ~TDBGridEhColumnsEditor(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TDBGridEhColumnsEditor(Classes::TComponent* AOwner, int Dummy) : Colnedit::TCollectionEditor(AOwner, Dummy) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TDBGridEhColumnsEditor(HWND ParentWindow) : Colnedit::TCollectionEditor(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TDBGridEhColumnsProperty;
class PASCALIMPLEMENTATION TDBGridEhColumnsProperty : public Designeditors::TPropertyEditor 
{
	typedef Designeditors::TPropertyEditor inherited;
	
public:
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual AnsiString __fastcall GetValue();
	virtual void __fastcall Edit(void);
public:
	#pragma option push -w-inl
	/* TPropertyEditor.Create */ inline __fastcall virtual TDBGridEhColumnsProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TPropertyEditor(ADesigner, APropCount) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TDBGridEhColumnsProperty(void) { }
	#pragma option pop
	
};


class DELPHICLASS TDBGridEhEditor;
class PASCALIMPLEMENTATION TDBGridEhEditor : public Designeditors::TComponentEditor 
{
	typedef Designeditors::TComponentEditor inherited;
	
public:
	virtual void __fastcall ExecuteVerb(int Index);
	virtual AnsiString __fastcall GetVerb(int Index);
	virtual int __fastcall GetVerbCount(void);
public:
	#pragma option push -w-inl
	/* TComponentEditor.Create */ inline __fastcall virtual TDBGridEhEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TComponentEditor(AComponent, ADesigner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TDBGridEhEditor(void) { }
	#pragma option pop
	
};


class DELPHICLASS TDBGridEhFieldProperty;
class PASCALIMPLEMENTATION TDBGridEhFieldProperty : public Designeditors::TStringProperty 
{
	typedef Designeditors::TStringProperty inherited;
	
public:
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual void __fastcall GetValueList(Classes::TStrings* List);
	virtual void __fastcall GetValues(Classes::TGetStrProc Proc);
public:
	#pragma option push -w-inl
	/* TPropertyEditor.Create */ inline __fastcall virtual TDBGridEhFieldProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TStringProperty(ADesigner, APropCount) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TDBGridEhFieldProperty(void) { }
	#pragma option pop
	
};


class DELPHICLASS TDBGridEhFieldAggProperty;
class PASCALIMPLEMENTATION TDBGridEhFieldAggProperty : public TDBGridEhFieldProperty 
{
	typedef TDBGridEhFieldProperty inherited;
	
public:
	virtual void __fastcall GetValueList(Classes::TStrings* List);
public:
	#pragma option push -w-inl
	/* TPropertyEditor.Create */ inline __fastcall virtual TDBGridEhFieldAggProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : TDBGridEhFieldProperty(ADesigner, APropCount) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TDBGridEhFieldAggProperty(void) { }
	#pragma option pop
	
};


class DELPHICLASS TDBLookupComboboxEhEditor;
class PASCALIMPLEMENTATION TDBLookupComboboxEhEditor : public Designeditors::TComponentEditor 
{
	typedef Designeditors::TComponentEditor inherited;
	
public:
	virtual void __fastcall ExecuteVerb(int Index);
	virtual AnsiString __fastcall GetVerb(int Index);
	virtual int __fastcall GetVerbCount(void);
public:
	#pragma option push -w-inl
	/* TComponentEditor.Create */ inline __fastcall virtual TDBLookupComboboxEhEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TComponentEditor(AComponent, ADesigner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TDBLookupComboboxEhEditor(void) { }
	#pragma option pop
	
};


class DELPHICLASS TDBGridEhDesignControler;
class PASCALIMPLEMENTATION TDBGridEhDesignControler : public Toolctrlseh::TDesignControlerEh 
{
	typedef Toolctrlseh::TDesignControlerEh inherited;
	
private:
	Classes::TList* FGridList;
	Graphics::TBitmap* FCornerImage;
	
protected:
	void __fastcall ItemDeleted(const Designintf::_di_IDesigner ADesigner, Classes::TPersistent* AItem);
	void __fastcall ItemInserted(const Designintf::_di_IDesigner ADesigner, Classes::TPersistent* AItem);
	void __fastcall ItemsModified(const Designintf::_di_IDesigner ADesigner);
	void __fastcall SelectionChanged(const Designintf::_di_IDesigner ADesigner, const Designintf::_di_IDesignerSelections ASelection);
	void __fastcall DesignerOpened(const Designintf::_di_IDesigner ADesigner, bool AResurrecting);
	void __fastcall DesignerClosed(const Designintf::_di_IDesigner ADesigner, bool AGoingDormant);
	void __fastcall CreateDesingPanel(Dbgrideh::TCustomDBGridEh* DBGridEh);
	
public:
	__fastcall TDBGridEhDesignControler(void);
	__fastcall virtual ~TDBGridEhDesignControler(void);
	virtual bool __fastcall IsDesignHitTest(Classes::TPersistent* Control, int X, int Y, Classes::TShiftState AShift);
	virtual bool __fastcall ControlIsObjInspSelected(Classes::TPersistent* Control);
	virtual Classes::TPersistent* __fastcall GetObjInspSelectedControl(Classes::TPersistent* BaseControl);
	virtual Graphics::TBitmap* __fastcall GetSelectComponentCornerImage(void);
	virtual TMetaClass* __fastcall GetDesignInfoItemClass(void);
	virtual void __fastcall DesignMouseDown(Classes::TPersistent* Control, int X, int Y, Classes::TShiftState AShift);
	virtual void __fastcall RegisterChangeSelectedNotification(Classes::TPersistent* Control);
	virtual void __fastcall UnregisterChangeSelectedNotification(Classes::TPersistent* Control);
	virtual void __fastcall KeyProperyModified(Controls::TControl* Control);
private:
	void *__IDesignNotification;	/* Designintf::IDesignNotification */
	
public:
	operator IDesignNotification*(void) { return (IDesignNotification*)&__IDesignNotification; }
	
};


class DELPHICLASS TGridDesignPanelEh;
class PASCALIMPLEMENTATION TGridDesignPanelEh : public Extctrls::TCustomPanel 
{
	typedef Extctrls::TCustomPanel inherited;
	
private:
	Dbgrideh::TCustomDBGridEh* Grid;
	Menus::TPopupMenu* DropdownMenu;
	
protected:
	virtual void __fastcall Paint(void);
	HIDESBASE MESSAGE void __fastcall CMDesignHitTest(Messages::TWMMouse &Msg);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	
public:
	__fastcall TGridDesignPanelEh(Dbgrideh::TCustomDBGridEh* AOwner);
	void __fastcall MenuClick(System::TObject* Sender);
	void __fastcall UpdateState(void);
public:
	#pragma option push -w-inl
	/* TCustomPanel.Create */ inline __fastcall virtual TGridDesignPanelEh(Classes::TComponent* AOwner) : Extctrls::TCustomPanel(AOwner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TGridDesignPanelEh(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TGridDesignPanelEh(HWND ParentWindow) : Extctrls::TCustomPanel(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TPanelMenuItem;
class PASCALIMPLEMENTATION TPanelMenuItem : public Menus::TMenuItem 
{
	typedef Menus::TMenuItem inherited;
	
public:
	Designintf::_di_IComponentEditor ComponentEditor;
	int VerbNo;
public:
	#pragma option push -w-inl
	/* TMenuItem.Create */ inline __fastcall virtual TPanelMenuItem(Classes::TComponent* AOwner) : Menus::TMenuItem(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TMenuItem.Destroy */ inline __fastcall virtual ~TPanelMenuItem(void) { }
	#pragma option pop
	
};


class DELPHICLASS TSaveComponentDesignInfoItemEh;
class PASCALIMPLEMENTATION TSaveComponentDesignInfoItemEh : public Classes::TCollectionItem 
{
	typedef Classes::TCollectionItem inherited;
	
private:
	int FLeft;
	int FTop;
	AnsiString FComponentName;
	
public:
	bool InGrid;
	
__published:
	__property int Left = {read=FLeft, write=FLeft, nodefault};
	__property int Top = {read=FTop, write=FTop, nodefault};
	__property AnsiString ComponentName = {read=FComponentName, write=FComponentName};
public:
	#pragma option push -w-inl
	/* TCollectionItem.Create */ inline __fastcall virtual TSaveComponentDesignInfoItemEh(Classes::TCollection* Collection) : Classes::TCollectionItem(Collection) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TSaveComponentDesignInfoItemEh(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TDBGridEhColumnsEditor* DBGridEhColumnsEditor;
extern PACKAGE Classes::TStringList* ComponentsBitmap;
extern PACKAGE bool GlobalHideConnectedComponens;
extern PACKAGE bool GlobalHideConnectedComponensLoaded;
extern PACKAGE bool __fastcall GetGlobalHideConnectedComponens(void);

}	/* namespace Gridehed */
using namespace Gridehed;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Gridehed
