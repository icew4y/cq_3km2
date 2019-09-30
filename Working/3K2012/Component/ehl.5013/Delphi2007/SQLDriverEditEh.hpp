// CodeGear C++Builder
// Copyright (c) 1995, 2007 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Sqldriverediteh.pas' rev: 11.00

#ifndef SqldrivereditehHPP
#define SqldrivereditehHPP

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
#include <Comctrls.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Grids.hpp>	// Pascal unit
#include <Dbgrideh.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <Dbctrlseh.hpp>	// Pascal unit
#include <Datadrivereh.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Memtableeh.hpp>	// Pascal unit
#include <Memtabledataeh.hpp>	// Pascal unit
#include <Sqleditframeeh.hpp>	// Pascal unit
#include <Ehlibvcl.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Contnrs.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Stdactns.hpp>	// Pascal unit
#include <Actnlist.hpp>	// Pascal unit
#include <Toolwin.hpp>	// Pascal unit
#include <Gridseh.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sqldriverediteh
{
//-- type declarations -------------------------------------------------------
typedef TMetaClass* TCustomDBServiceClass;

class DELPHICLASS TSQLDataEditWin;
class DELPHICLASS TDesignDataBaseEh;
typedef DynamicArray<Variant >  TParamsArr;

class DELPHICLASS TCustomDBService;
class PASCALIMPLEMENTATION TDesignDataBaseEh : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
protected:
	Memtableeh::TMemTableEh* FTreeDataSet;
	void __fastcall RemoveFromDesignDataBaseList(void);
	virtual bool __fastcall GetConnected(void);
	virtual void __fastcall SetConnected(const bool Value);
	
public:
	__fastcall TDesignDataBaseEh(void);
	__fastcall virtual ~TDesignDataBaseEh(void);
	virtual bool __fastcall BuildObjectTree(Classes::TList* List);
	virtual bool __fastcall BuildUpdates(Datadrivereh::TCustomSQLDataDriverEh* DataDriver);
	virtual Datadrivereh::TCustomSQLDataDriverEh* __fastcall CreateDesignCopy(Datadrivereh::TCustomSQLDataDriverEh* RTDataDriver);
	virtual Db::TDataSet* __fastcall CreateReader(AnsiString SQL, TParamsArr FParams);
	virtual bool __fastcall DesignDataBaseConnetionEqual(Datadrivereh::TCustomSQLDataDriverEh* DataDriver);
	virtual int __fastcall Execute(Datadrivereh::TCustomSQLCommandEh* Command, Db::TDataSet* &Cursor, bool &FreeOnEof)/* overload */;
	virtual int __fastcall Execute(AnsiString SQLText, Datadrivereh::TSQLCommandTypeEh CommandType, const Variant &VarParams, Db::TDataSet* &Cursor)/* overload */;
	virtual AnsiString __fastcall GetEngineName();
	virtual AnsiString __fastcall GetServerTypeName();
	virtual bool __fastcall GetFieldList(const AnsiString TableName, Db::TDataSet* DataSet);
	virtual AnsiString __fastcall GetSpecParamsList();
	virtual bool __fastcall SupportCustomSQLDataDriver(void) = 0 ;
	virtual TCustomDBService* __fastcall GetCustomDBService(void);
	virtual Classes::TStrings* __fastcall GetIncrementObjectsList(void);
	virtual Db::TDataSet* __fastcall GetObjectTreeDataSet(void);
	virtual Memtableeh::TMemTableEh* __fastcall CreateTreeDataSet(void);
	void __fastcall mtDBTreeExpanding(System::TObject* Sender, int RecordNumber, bool &AllowExpansion);
	virtual void __fastcall BuildQueryPlan(Memtableeh::TMemTableEh* PlanTable, Datadrivereh::TCustomSQLCommandEh* Command);
	virtual void __fastcall EditDatabaseParams(void);
	virtual void __fastcall ResetDesignInfo(void);
	virtual void __fastcall AssignFromDesignDataDriver(Datadrivereh::TCustomSQLDataDriverEh* DesignDataDriver, Datadrivereh::TCustomSQLDataDriverEh* RuntimeDataDriver);
	virtual void __fastcall AssignToDesignDataDriver(Datadrivereh::TCustomSQLDataDriverEh* DesignDataDriver, Datadrivereh::TCustomSQLDataDriverEh* RuntimeDataDriver);
	__property bool Connected = {read=GetConnected, write=SetConnected, nodefault};
private:
	void *__IDesignDataBaseEh;	/* Datadrivereh::IDesignDataBaseEh */
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator Datadrivereh::_di_IDesignDataBaseEh()
	{
		Datadrivereh::_di_IDesignDataBaseEh intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IDesignDataBaseEh*(void) { return (IDesignDataBaseEh*)&__IDesignDataBaseEh; }
	#endif
	
};


class DELPHICLASS TSQLTreeNode;
class DELPHICLASS TSQLTreeNodeTemplate;
struct TColumnAtribute;
typedef DynamicArray<TColumnAtribute >  TColumnAttributes;

struct TServicePopupParam;
typedef DynamicArray<TServicePopupParam >  TServicePopupParams;

class PASCALIMPLEMENTATION TSQLTreeNodeTemplate : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	AnsiString FName;
	AnsiString FMasterTemplateName;
	AnsiString FNodesMemTableName;
	DynamicArray<Variant >  FParams;
	TCustomDBService* FNodeManager;
	AnsiString FObjIdFieldName;
	AnsiString FInTreeTextFieldName;
	AnsiString FNodesFilter;
	AnsiString FNodesSQLClassName;
	DynamicArray<TColumnAtribute >  FColumnAttributes;
	Controls::TDragDropEvent FOnNodeDragDrop;
	DynamicArray<TServicePopupParam >  FNodeDropMenuParams;
	DynamicArray<TServicePopupParam >  FTableNodeDropMenuParams;
	bool FHasNodes;
	int FSelectedIndex;
	AnsiString FAdditionalLoadSQL;
	AnsiString FColumnAttributesStr;
	AnsiString FAdditionalFielsInfo;
	void __fastcall SetColumnAttributes(const AnsiString Value);
	
public:
	__fastcall TSQLTreeNodeTemplate(TCustomDBService* ANodeManager, AnsiString AName);
	__fastcall virtual ~TSQLTreeNodeTemplate(void);
	virtual TSQLTreeNode* __fastcall CreateNode(void);
	AnsiString __fastcall DropMenuNodeText(System::TObject* Sender);
	AnsiString __fastcall DropMenuNlCommaNodeText(System::TObject* Sender);
	AnsiString __fastcall DropMenuSelectAstFromName(System::TObject* Sender);
	AnsiString __fastcall DropMenuSelectAllFieldsFromName(System::TObject* Sender);
	AnsiString __fastcall DropDataSelectAllFieldsFromName(System::TObject* Sender);
	int __fastcall ShowPopup(System::TObject* Source, const Types::TPoint &Coord, TServicePopupParams Params);
	void __fastcall TableEditorDrop(System::TObject* Sender, System::TObject* Source, int X, int Y);
	void __fastcall OnPopupClick(System::TObject* Sender);
	__property Controls::TDragDropEvent OnNodeDragDrop = {read=FOnNodeDragDrop, write=FOnNodeDragDrop};
	__property TServicePopupParams NodeDropMenuParams = {read=FNodeDropMenuParams, write=FNodeDropMenuParams};
	__property AnsiString NodesSQLClassName = {read=FNodesSQLClassName, write=FNodesSQLClassName};
	__property AnsiString MasterTemplateName = {read=FMasterTemplateName, write=FMasterTemplateName};
	__property AnsiString NodesMemTableName = {read=FNodesMemTableName, write=FNodesMemTableName};
	__property AnsiString ObjIdFieldName = {read=FObjIdFieldName, write=FObjIdFieldName};
	__property AnsiString InTreeTextFieldName = {read=FInTreeTextFieldName, write=FInTreeTextFieldName};
	__property bool HasNodes = {read=FHasNodes, write=FHasNodes, nodefault};
	__property AnsiString NodesFilter = {read=FNodesFilter, write=FNodesFilter};
	__property AnsiString ColumnAttributesStr = {read=FColumnAttributesStr, write=SetColumnAttributes};
	__property AnsiString AdditionalLoadSQL = {read=FAdditionalLoadSQL, write=FAdditionalLoadSQL};
	__property AnsiString AdditionalFielsInfo = {read=FAdditionalFielsInfo, write=FAdditionalFielsInfo};
};


class PASCALIMPLEMENTATION TSQLTreeNode : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	Controls::TDragDropEvent FOnDragDrop;
	TSQLTreeNode* __fastcall GetSQLTreeNode(void);
	
public:
	AnsiString FFullName;
	int FImageIndex;
	Memtabledataeh::TMemoryRecordEh* FMemRec;
	AnsiString FName;
	Contnrs::TObjectList* FNodes;
	bool FNodesLoaded;
	AnsiString FNodesSelect;
	TSQLTreeNodeTemplate* FNodesTemplate;
	AnsiString FObjId;
	TSQLTreeNode* FParent;
	Memtableeh::TMemTableEh* FTable;
	AnsiString FTableFields;
	AnsiString FTableFilter;
	AnsiString FTypeId;
	bool FParentRecordToTableMode;
	DynamicArray<TServicePopupParam >  PopupParams;
	__fastcall TSQLTreeNode(void);
	__fastcall virtual ~TSQLTreeNode(void);
	void __fastcall AddChild(TSQLTreeNode* Node);
	Memtableeh::TMemTableEh* __fastcall GetTable(void);
	__property Controls::TDragDropEvent OnDragDrop = {read=FOnDragDrop, write=FOnDragDrop};
};


class PASCALIMPLEMENTATION TSQLDataEditWin : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
__published:
	Extctrls::TPanel* Panel1;
	Dbgrideh::TDBGridEh* DBGridEh1;
	Extctrls::TPanel* Panel2;
	Comctrls::TStatusBar* StatusBar1;
	Stdctrls::TButton* Button1;
	Stdctrls::TButton* Button2;
	Extctrls::TSplitter* Splitter1;
	Extctrls::TSplitter* Splitter3;
	Extctrls::TPanel* Panel6;
	Extctrls::TPanel* Panel7;
	Dbctrlseh::TDBEditEh* DBEditEh1;
	Buttons::TSpeedButton* sbRefreshTree;
	Memtableeh::TMemTableEh* MemTableEh1;
	Db::TDataSource* DataSource1;
	Memtableeh::TMemTableEh* mtParams;
	Db::TDataSource* dsParams;
	Db::TStringField* mtParamsParName;
	Db::TStringField* mtParamsParType;
	Db::TStringField* mtParamsParValue;
	Dbgrideh::TDBGridEh* gridTreeDetail;
	Memtableeh::TMemTableEh* mtTreeDetail;
	Db::TDataSource* dsTreeDetail;
	Extctrls::TSplitter* Splitter4;
	Extctrls::TPanel* Panel3;
	Comctrls::TPageControl* PageControl1;
	Comctrls::TTabSheet* TabSheet1;
	Extctrls::TSplitter* Splitter2;
	Extctrls::TPanel* PanelParams;
	Dbgrideh::TDBGridEh* gridParams;
	Extctrls::TPanel* Panel5;
	Stdctrls::TMemo* Memo1;
	Extctrls::TPanel* Panel8;
	Stdctrls::TButton* bExecute;
	Extctrls::TPanel* Panel9;
	Buttons::TSpeedButton* SpeedButton2;
	Comctrls::TTabSheet* TabSheet2;
	Sqleditframeeh::TSQLEditFrame* FrameInsertSQL;
	Comctrls::TTabSheet* TabSheet3;
	Sqleditframeeh::TSQLEditFrame* FrameUpdateSQL;
	Comctrls::TTabSheet* TabSheet4;
	Sqleditframeeh::TSQLEditFrame* FrameDeleteSQL;
	Stdctrls::TButton* bBuildUpdates;
	Extctrls::TImage* Image1;
	Extctrls::TPanel* Panel4;
	Buttons::TSpeedButton* sbRefresh;
	Menus::TPopupMenu* PopupMenu1;
	Menus::TMenuItem* Ggg1;
	Dbgrideh::TDBGridEh* gridDBTree;
	Db::TDataSource* dsDBTree;
	Memtableeh::TMemTableEh* mtDBTree;
	Db::TStringField* mtDBTreeName;
	Db::TIntegerField* mtDBTreeChieldCount;
	Db::TStringField* mtDBTreeDescription;
	Db::TAutoIncField* mtDBTreeId;
	Db::TIntegerField* mtDBTreeRefParent;
	Stdctrls::TButton* bCheck;
	Stdctrls::TButton* bQueryPlan;
	Buttons::TSpeedButton* spCut;
	Buttons::TSpeedButton* sbCopy;
	Buttons::TSpeedButton* spPaste;
	Buttons::TSpeedButton* sbSelectAll;
	Actnlist::TActionList* ActionList1;
	Stdactns::TEditCut* EditCut1;
	Stdactns::TEditCopy* EditCopy1;
	Stdactns::TEditPaste* EditPaste1;
	Stdactns::TEditSelectAll* EditSelectAll1;
	Controls::TImageList* ImageList1;
	Controls::TImageList* ImageList2;
	Db::TIntegerField* mtDBTreeImageIndex;
	Comctrls::TTabSheet* TabSheet5;
	Sqleditframeeh::TSQLEditFrame* FrameGetRecSQL;
	Comctrls::TTabSheet* tsSpecParams;
	Extctrls::TPanel* Panel11;
	Stdctrls::TLabel* Label1;
	Stdctrls::TLabel* Label2;
	Stdctrls::TMemo* MemoUpdateFields;
	Stdctrls::TMemo* MemoKeyFields;
	Extctrls::TBevel* Bevel1;
	Extctrls::TBevel* Bevel2;
	Dbctrlseh::TDBEditEh* dbeUpdateTable;
	Stdctrls::TLabel* Label3;
	Extctrls::TBevel* Bevel3;
	Stdctrls::TGroupBox* GroupBox1;
	Stdctrls::TCheckBox* cbDinaDeleteSQL;
	Stdctrls::TCheckBox* cbDinaInsertSQL;
	Stdctrls::TCheckBox* cbDinaUpdateSQL;
	Extctrls::TPanel* Panel12;
	Stdctrls::TMemo* mSpecParams;
	Extctrls::TPanel* Panel10;
	Stdctrls::TLabel* Label4;
	Extctrls::TBevel* Bevel4;
	Stdctrls::TButton* bLoadSpecString;
	Extctrls::TBevel* Bevel5;
	Memtableeh::TRefObjectField* mtDBTreeRefData;
	void __fastcall sbRefreshTreeClick(System::TObject* Sender);
	void __fastcall bExecuteClick(System::TObject* Sender);
	void __fastcall sbHideShowClick(System::TObject* Sender);
	void __fastcall Splitter2CanResize(System::TObject* Sender, int &NewSize, bool &Accept);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall bBuildUpdatesClick(System::TObject* Sender);
	void __fastcall MemTableEh1AfterOpen(Db::TDataSet* DataSet);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall Memo1Exit(System::TObject* Sender);
	void __fastcall Memo1Enter(System::TObject* Sender);
	void __fastcall sbRefreshClick(System::TObject* Sender);
	void __fastcall DBEditEh1EditButtons0Click(System::TObject* Sender, bool &Handled);
	void __fastcall DBEditEh1EditButtons1Click(System::TObject* Sender, bool &Handled);
	void __fastcall Memo1DragOver(System::TObject* Sender, System::TObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	void __fastcall Memo1DragDrop(System::TObject* Sender, System::TObject* Source, int X, int Y);
	void __fastcall Ggg1Click(System::TObject* Sender);
	void __fastcall dsDBTreeDataChange(System::TObject* Sender, Db::TField* Field);
	void __fastcall gridDBTreeMouseDown(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall gridDBTreeStartDrag(System::TObject* Sender, Controls::TDragObject* &DragObject);
	void __fastcall bQueryPlanClick(System::TObject* Sender);
	void __fastcall gridDBTreeColumns0GetCellParams(System::TObject* Sender, bool EditMode, Dbgrideh::TColCellParamsEh* Params);
	void __fastcall bLoadSpecStringClick(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, Forms::TCloseAction &Action);
	void __fastcall gridParamsColumns0UpdateData(System::TObject* Sender, AnsiString &Text, Variant &Value, bool &UseText, bool &Handled);
	
private:
	int FCharHeight;
	Controls::TControlCanvas* FSQLCanvas;
	Datadrivereh::TCustomSQLDataDriverEh* FDesignDriver;
	Datadrivereh::TCustomSQLDataDriverEh* FDataDriver;
	TDesignDataBaseEh* FDesignDataBase;
	void __fastcall SetDesignDataBase(const TDesignDataBaseEh* Value);
	void __fastcall DrawCaretPosIndicator(void);
	__property Datadrivereh::TCustomSQLDataDriverEh* DesignDriver = {read=FDesignDriver, write=FDesignDriver};
	void __fastcall SetObjectTreeParams(void);
	void __fastcall ResetObjectTreeParams(void);
	int __fastcall ExecuteCommand(Datadrivereh::TCustomSQLDataDriverEh* DataDriver, Datadrivereh::TCustomSQLCommandEh* Command, Db::TDataSet* &Cursor, bool &FreeOnEof);
	void __fastcall DesignDatabaseChanged(void);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
public:
	int Panel3Width;
	TSQLTreeNode* DragSQLTreeNode;
	bool mtDBTreeLoading;
	__fastcall virtual ~TSQLDataEditWin(void);
	void __fastcall AssignToDesignDriver(void);
	void __fastcall AssignToDesignControls(void);
	void __fastcall mtDBTreeExpanding(System::TObject* Sender, int RecordNumber, bool &AllowExpansion);
	void __fastcall gridTreeDetailColumns0GetCellParams(System::TObject* Sender, bool EditMode, Dbgrideh::TColCellParamsEh* Params);
	__property Datadrivereh::TCustomSQLDataDriverEh* DataDriver = {read=FDataDriver, write=FDataDriver};
	__property TDesignDataBaseEh* DesignDataBase = {read=FDesignDataBase, write=SetDesignDataBase};
public:
	#pragma option push -w-inl
	/* TCustomForm.Create */ inline __fastcall virtual TSQLDataEditWin(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TSQLDataEditWin(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TSQLDataEditWin(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	#pragma option pop
	
};


typedef TMetaClass* TDesignDataBaseClassEh;

class DELPHICLASS TAccessEngineEh;
class PASCALIMPLEMENTATION TAccessEngineEh : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	virtual AnsiString __fastcall AccessEngineName(void) = 0 ;
	virtual TDesignDataBaseEh* __fastcall CreateDesignDataBase(Datadrivereh::TCustomSQLDataDriverEh* DataDriver, TMetaClass* DBServiceClass, AnsiString DataBaseName) = 0 ;
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TAccessEngineEh(void) : System::TObject() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TAccessEngineEh(void) { }
	#pragma option pop
	
};


#pragma pack(push,4)
struct TColumnAtribute
{
	
public:
	AnsiString FieldName;
	AnsiString Title;
	int Width;
} ;
#pragma pack(pop)

#pragma pack(push,4)
struct TFieldAtribute
{
	
public:
	AnsiString FieldName;
	Memtabledataeh::TMTDataFieldEh* FieldType;
	int Size;
} ;
#pragma pack(pop)

typedef AnsiString __fastcall (__closure *TGetTextEvent)(System::TObject* Sender);

struct TServicePopupParam
{
	
public:
	AnsiString Text;
	Classes::TNotifyEvent OnSelect;
	TGetTextEvent OnGetMenuText;
	TGetTextEvent OnGetDataText;
} ;

typedef DynamicArray<TFieldAtribute >  TFieldAtributesEh;

class DELPHICLASS TDesignUpdateParamsEh;
class PASCALIMPLEMENTATION TDesignUpdateParamsEh : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	AnsiString FIncremenField;
	AnsiString FIncremenObject;
	AnsiString FTableName;
	Classes::TStrings* FKeyFields;
	Classes::TStrings* FUpdateFields;
	Classes::TStrings* FSelectSQL;
	void __fastcall SetKeyFields(const Classes::TStrings* Value);
	void __fastcall SetUpdateFields(const Classes::TStrings* Value);
	void __fastcall SetSelectSQL(const Classes::TStrings* Value);
	
public:
	__fastcall TDesignUpdateParamsEh(void);
	__fastcall virtual ~TDesignUpdateParamsEh(void);
	__property AnsiString TableName = {read=FTableName, write=FTableName};
	__property AnsiString IncremenField = {read=FIncremenField, write=FIncremenField};
	__property AnsiString IncremenObject = {read=FIncremenObject, write=FIncremenObject};
	__property Classes::TStrings* KeyFields = {read=FKeyFields, write=SetKeyFields};
	__property Classes::TStrings* UpdateFields = {read=FUpdateFields, write=SetUpdateFields};
	__property Classes::TStrings* SelectSQL = {read=FSelectSQL, write=SetSelectSQL};
};


class DELPHICLASS TDesignUpdateInfoEh;
class PASCALIMPLEMENTATION TDesignUpdateInfoEh : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	AnsiString FTableName;
	Classes::TStrings* FDeleteSQL;
	Classes::TStrings* FGetRecSQL;
	Classes::TStrings* FUpdateSQL;
	Classes::TStrings* FInsertSQL;
	Classes::TStrings* FSpecParams;
	Classes::TStrings* FUpdateFields;
	Classes::TStrings* FKeyFields;
	void __fastcall SetDeleteSQL(const Classes::TStrings* Value);
	void __fastcall SetGetRecSQL(const Classes::TStrings* Value);
	void __fastcall SetUpdateSQL(const Classes::TStrings* Value);
	void __fastcall SetInsertSQL(const Classes::TStrings* Value);
	void __fastcall SetSpecParams(const Classes::TStrings* Value);
	void __fastcall SetKeyFields(const Classes::TStrings* Value);
	void __fastcall SetUpdateFields(const Classes::TStrings* Value);
	
public:
	__fastcall TDesignUpdateInfoEh(void);
	__fastcall virtual ~TDesignUpdateInfoEh(void);
	__property AnsiString TableName = {read=FTableName, write=FTableName};
	__property Classes::TStrings* DeleteSQL = {read=FDeleteSQL, write=SetDeleteSQL};
	__property Classes::TStrings* InsertSQL = {read=FInsertSQL, write=SetInsertSQL};
	__property Classes::TStrings* UpdateSQL = {read=FUpdateSQL, write=SetUpdateSQL};
	__property Classes::TStrings* GetRecSQL = {read=FGetRecSQL, write=SetGetRecSQL};
	__property Classes::TStrings* SpecParams = {read=FSpecParams, write=SetSpecParams};
	__property Classes::TStrings* UpdateFields = {read=FUpdateFields, write=SetUpdateFields};
	__property Classes::TStrings* KeyFields = {read=FKeyFields, write=SetKeyFields};
};


class PASCALIMPLEMENTATION TCustomDBService : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	Classes::TStringList* FMTList;
	Classes::TStringList* FTempateList;
	TSQLTreeNode* FSQLRoot;
	Classes::TStringList* FSQLClassListNames;
	Classes::TStringList* FSQLClassListTexts;
	Classes::TStringList* FLoadedSQLClasses;
	
protected:
	TDesignDataBaseEh* FDesignDB;
	Classes::TStrings* FIncrementObjectsList;
	int SelectedIndex;
	virtual TSQLTreeNode* __fastcall CreateNode(void);
	virtual Db::TDataSet* __fastcall CreateReader(AnsiString SQL, TParamsArr FParams);
	Memtableeh::TMemTableEh* __fastcall GetMemTable(AnsiString TableName);
	TSQLTreeNodeTemplate* __fastcall GetTemplate(AnsiString TemplateName);
	AnsiString __fastcall LoadText(AnsiString TextName);
	virtual int __fastcall LoadMemTable(Memtableeh::TMemTableEh* MemTable, Db::TDataSet* Source, Memtableeh::TLoadMode Mode, bool Fetch);
	AnsiString __fastcall SQLClassTextByName(AnsiString ClassName);
	void __fastcall AddTemplate(TSQLTreeNodeTemplate* Template);
	virtual void __fastcall AssignRecord(Db::TDataSet* Source, Db::TDataSet* Destinate);
	void __fastcall OnPopupClick(System::TObject* Sender);
	void __fastcall AddSQLClass(AnsiString Name, AnsiString SQLText);
	virtual void __fastcall MemTableBuildStruct(Memtableeh::TMemTableEh* MemTable, Db::TDataSet* Source);
	virtual void __fastcall GenWhereClause(TDesignUpdateParamsEh* DesignUpdateParams, Classes::TStrings* SQL);
	virtual void __fastcall GenInsertSQL(TDesignUpdateParamsEh* DesignUpdateParams, TDesignUpdateInfoEh* DesignUpdateInfo);
	virtual void __fastcall GenModifySQL(TDesignUpdateParamsEh* DesignUpdateParams, TDesignUpdateInfoEh* DesignUpdateInfo);
	virtual void __fastcall GenDeleteSQL(TDesignUpdateParamsEh* DesignUpdateParams, TDesignUpdateInfoEh* DesignUpdateInfo);
	virtual void __fastcall GenGetRecSQL(TDesignUpdateParamsEh* DesignUpdateParams, TDesignUpdateInfoEh* DesignUpdateInfo);
	
public:
	__fastcall virtual TCustomDBService(TDesignDataBaseEh* ADesignDB);
	__fastcall virtual ~TCustomDBService(void);
	bool __fastcall CheckSqlTextFile(void);
	virtual Classes::TList* __fastcall CreateRootNodes(void);
	virtual Classes::TList* __fastcall CreateNodes(TSQLTreeNode* Parent);
	virtual int __fastcall ShowPopup(System::TObject* Source, const Types::TPoint &Coord, TServicePopupParams Params);
	virtual AnsiString __fastcall GetSpecParamsList();
	virtual Classes::TStrings* __fastcall GetIncrementObjectsList(void);
	virtual bool __fastcall GetUpdateSQLCommand(TDesignUpdateParamsEh* DesignUpdateParams, TDesignUpdateInfoEh* DesignUpdateInfo);
	virtual void __fastcall GenGetSpecParams(TDesignUpdateParamsEh* DesignUpdateParams, TDesignUpdateInfoEh* DesignUpdateInfo);
	/* virtual class method */ virtual AnsiString __fastcall GetDBServiceName(TMetaClass* vmt);
};


class DELPHICLASS TInterbaseDBService;
class PASCALIMPLEMENTATION TInterbaseDBService : public TCustomDBService 
{
	typedef TCustomDBService inherited;
	
protected:
	virtual void __fastcall AssignRecord(Db::TDataSet* Source, Db::TDataSet* Destinate);
	
public:
	__fastcall virtual TInterbaseDBService(TDesignDataBaseEh* ADesignDB);
	virtual AnsiString __fastcall GetSpecParamsList();
	virtual Classes::TStrings* __fastcall GetIncrementObjectsList(void);
	virtual void __fastcall GenInsertSQL(TDesignUpdateParamsEh* DesignUpdateParams, TDesignUpdateInfoEh* DesignUpdateInfo);
	virtual void __fastcall GenGetSpecParams(TDesignUpdateParamsEh* DesignUpdateParams, TDesignUpdateInfoEh* DesignUpdateInfo);
	/* virtual class method */ virtual AnsiString __fastcall GetDBServiceName(TMetaClass* vmt);
public:
	#pragma option push -w-inl
	/* TCustomDBService.Destroy */ inline __fastcall virtual ~TInterbaseDBService(void) { }
	#pragma option pop
	
};


class DELPHICLASS TInformixDBService;
class PASCALIMPLEMENTATION TInformixDBService : public TCustomDBService 
{
	typedef TCustomDBService inherited;
	
public:
	__fastcall virtual TInformixDBService(TDesignDataBaseEh* ADesignDB);
	virtual AnsiString __fastcall GetSpecParamsList();
	void __fastcall TableEditorDrop(System::TObject* Sender, System::TObject* Source, int X, int Y);
	virtual void __fastcall MemTableBuildStruct(Memtableeh::TMemTableEh* MemTable, Db::TDataSet* Source);
	virtual void __fastcall GenGetSpecParams(TDesignUpdateParamsEh* DesignUpdateParams, TDesignUpdateInfoEh* DesignUpdateInfo);
	/* virtual class method */ virtual AnsiString __fastcall GetDBServiceName(TMetaClass* vmt);
public:
	#pragma option push -w-inl
	/* TCustomDBService.Destroy */ inline __fastcall virtual ~TInformixDBService(void) { }
	#pragma option pop
	
};


class DELPHICLASS TMSAccessDBService;
class PASCALIMPLEMENTATION TMSAccessDBService : public TCustomDBService 
{
	typedef TCustomDBService inherited;
	
public:
	__fastcall virtual TMSAccessDBService(TDesignDataBaseEh* ADesignDB);
	virtual AnsiString __fastcall GetSpecParamsList();
	virtual void __fastcall GenGetSpecParams(TDesignUpdateParamsEh* DesignUpdateParams, TDesignUpdateInfoEh* DesignUpdateInfo);
	/* virtual class method */ virtual AnsiString __fastcall GetDBServiceName(TMetaClass* vmt);
public:
	#pragma option push -w-inl
	/* TCustomDBService.Destroy */ inline __fastcall virtual ~TMSAccessDBService(void) { }
	#pragma option pop
	
};


class DELPHICLASS TOracleDBService;
class PASCALIMPLEMENTATION TOracleDBService : public TCustomDBService 
{
	typedef TCustomDBService inherited;
	
public:
	__fastcall virtual TOracleDBService(TDesignDataBaseEh* ADesignDB);
	virtual AnsiString __fastcall GetSpecParamsList();
	virtual void __fastcall GenGetSpecParams(TDesignUpdateParamsEh* DesignUpdateParams, TDesignUpdateInfoEh* DesignUpdateInfo);
	/* virtual class method */ virtual AnsiString __fastcall GetDBServiceName(TMetaClass* vmt);
public:
	#pragma option push -w-inl
	/* TCustomDBService.Destroy */ inline __fastcall virtual ~TOracleDBService(void) { }
	#pragma option pop
	
};


class DELPHICLASS TMSSQLDBService;
class PASCALIMPLEMENTATION TMSSQLDBService : public TCustomDBService 
{
	typedef TCustomDBService inherited;
	
public:
	__fastcall virtual TMSSQLDBService(TDesignDataBaseEh* ADesignDB);
	virtual AnsiString __fastcall GetSpecParamsList();
	virtual void __fastcall GenGetSpecParams(TDesignUpdateParamsEh* DesignUpdateParams, TDesignUpdateInfoEh* DesignUpdateInfo);
	/* virtual class method */ virtual AnsiString __fastcall GetDBServiceName(TMetaClass* vmt);
public:
	#pragma option push -w-inl
	/* TCustomDBService.Destroy */ inline __fastcall virtual ~TMSSQLDBService(void) { }
	#pragma option pop
	
};


class DELPHICLASS TSelectDBService;
class PASCALIMPLEMENTATION TSelectDBService : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	TMetaClass* DBServiceClass;
	TAccessEngineEh* AccessEngine;
	AnsiString DBName;
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TSelectDBService(void) : System::TObject() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TSelectDBService(void) { }
	#pragma option pop
	
};


class DELPHICLASS TDBServiceItem;
class PASCALIMPLEMENTATION TDBServiceItem : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	TAccessEngineEh* AccessEngine;
	TMetaClass* DBService;
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TDBServiceItem(void) : System::TObject() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TDBServiceItem(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE Classes::TStringList* AccessEngineList;
extern PACKAGE Contnrs::TObjectList* DesignDataBaseList;
#define SSelect "select"
#define SFrom "from"
extern PACKAGE TSQLDataEditWin* SQLDataEditWin;
extern PACKAGE AnsiString SqlTextPathFileName;
extern PACKAGE Classes::TStringList* __fastcall GetDBServiceList(void);
extern PACKAGE void __fastcall RegisterDBService(AnsiString ServerName, TMetaClass* DBService);
extern PACKAGE void __fastcall UnregisterDBService(AnsiString ServerName);
extern PACKAGE TMetaClass* __fastcall GetDBServiceByName(AnsiString ServerName);
extern PACKAGE bool __fastcall GUISelectDBService(TSelectDBService* SelectDBService);
extern PACKAGE void __fastcall RegisterDefaultDBService(void);
extern PACKAGE void __fastcall RegisterAccessEngine(AnsiString EngineName, TAccessEngineEh* Engine);
extern PACKAGE void __fastcall UnregisterAccessEngine(AnsiString EngineName);
extern PACKAGE TAccessEngineEh* __fastcall GetAccessEngineByName(AnsiString EngineName);
extern PACKAGE bool __fastcall GUISelectAccessEngine(TSelectDBService* SelectDBService);
extern PACKAGE Contnrs::TObjectList* __fastcall GetDBServiceEngineList(void);
extern PACKAGE void __fastcall RegisterDBServiceEngine(TAccessEngineEh* AccessEngine, TMetaClass* DBService);
extern PACKAGE void __fastcall UnregisterDBServiceEngine(TMetaClass* DBService);
extern PACKAGE Contnrs::TObjectList* __fastcall GetDesignDataBaseList(void);
extern PACKAGE void __fastcall ReleaseDesignDataBaseList(void);
extern PACKAGE void __fastcall RegisterDesignDataBaseClass(AnsiString EngineName, TMetaClass* DesignDBClass);
extern PACKAGE void __fastcall UnregisterDesignDataBaseClass(AnsiString EngineName);
extern PACKAGE TMetaClass* __fastcall GetDesignDataBaseClassByName(AnsiString EngineName);
extern PACKAGE TMetaClass* __fastcall GUISelectDesignDataBaseClass(void);
extern PACKAGE int __fastcall EditSQLDataDriverEh(Datadrivereh::TCustomSQLDataDriverEh* DataDriver);

}	/* namespace Sqldriverediteh */
using namespace Sqldriverediteh;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Sqldriverediteh
