// CodeGear C++Builder
// Copyright (c) 1995, 2007 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Memtableeh.pas' rev: 11.00

#ifndef MemtableehHPP
#define MemtableehHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Contnrs.hpp>	// Pascal unit
#include <Ehlibvcl.hpp>	// Pascal unit
#include <Toolctrlseh.hpp>	// Pascal unit
#include <Dbcommon.hpp>	// Pascal unit
#include <Memtabledataeh.hpp>	// Pascal unit
#include <Datadrivereh.hpp>	// Pascal unit
#include <Memtreeeh.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Memtableeh
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TLoadMode { lmCopy, lmAppend };
#pragma option pop

class DELPHICLASS TMasterDataLinkEh;
class PASCALIMPLEMENTATION TMasterDataLinkEh : public Db::TDetailDataLink 
{
	typedef Db::TDetailDataLink inherited;
	
private:
	Db::TDataSet* FDataSet;
	AnsiString FFieldNames;
	Contnrs::TObjectList* FFields;
	Classes::TNotifyEvent FOnMasterChange;
	Classes::TNotifyEvent FOnMasterDisable;
	void __fastcall SetFieldNames(const AnsiString Value);
	
protected:
	virtual Db::TDataSet* __fastcall GetDetailDataSet(void);
	virtual void __fastcall ActiveChanged(void);
	virtual void __fastcall CheckBrowseMode(void);
	virtual void __fastcall LayoutChanged(void);
	virtual void __fastcall RecordChanged(Db::TField* Field);
	
public:
	__fastcall TMasterDataLinkEh(Db::TDataSet* DataSet);
	__fastcall virtual ~TMasterDataLinkEh(void);
	__property AnsiString FieldNames = {read=FFieldNames, write=SetFieldNames};
	__property Contnrs::TObjectList* Fields = {read=FFields};
	__property Classes::TNotifyEvent OnMasterChange = {read=FOnMasterChange, write=FOnMasterChange};
	__property Classes::TNotifyEvent OnMasterDisable = {read=FOnMasterDisable, write=FOnMasterDisable};
};


class DELPHICLASS TMemTableTreeListEh;
class DELPHICLASS TCustomMemTableEh;
#pragma option push -b-
enum TMasterDetailSideEh { mdsOnSelfEh, mdsOnProviderEh, mdsOnSelfAfterProviderEh };
#pragma option pop

typedef void __fastcall (__closure *TMTTreeNodeExpandingEventEh)(System::TObject* Sender, int RecNo, bool &AllowExpansion);

typedef void __fastcall (__closure *TRecordsViewTreeNodeExpandingEventEh)(System::TObject* Sender, Memtabledataeh::TMemRecViewEh* Node, bool &AllowExpansion);

typedef void __fastcall (__closure *TRecordsViewTreeNodeExpandedEventEh)(System::TObject* Sender, Memtabledataeh::TMemRecViewEh* Node);

typedef bool __fastcall (__closure *TRecordsViewCheckMoveNodeEventEh)(System::TObject* Sender, Memtabledataeh::TMemRecViewEh* SourceNode, Memtabledataeh::TMemRecViewEh* AppointedParent, int AppointedIndex);

class DELPHICLASS TSortedVarlistEh;
class DELPHICLASS TSortedVarItemEh;
class PASCALIMPLEMENTATION TSortedVarlistEh : public Contnrs::TObjectList 
{
	typedef Contnrs::TObjectList inherited;
	
protected:
	bool __fastcall VarInList(const Variant &Value);
	bool __fastcall FindValueIndex(const Variant &Value, int &Index);
	
public:
	HIDESBASE int __fastcall Add(TSortedVarItemEh* AObject);
	HIDESBASE void __fastcall Insert(int Index, TSortedVarItemEh* AObject);
public:
	#pragma option push -w-inl
	/* TObjectList.Create */ inline __fastcall TSortedVarlistEh(void)/* overload */ : Contnrs::TObjectList() { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TList.Destroy */ inline __fastcall virtual ~TSortedVarlistEh(void) { }
	#pragma option pop
	
};


typedef void __fastcall (__closure *TMemTableChangeFieldValueEventEh)(TCustomMemTableEh* MemTable, Db::TField* Field, Variant &Value);

class DELPHICLASS TRecBuf;
class PASCALIMPLEMENTATION TCustomMemTableEh : public Db::TDataSet 
{
	typedef Db::TDataSet inherited;
	
private:
	bool FStateInsert;
	Contnrs::TObjectList* FEventReceivers;
	Contnrs::TObjectList* FRecordCache;
	bool FActive;
	int FAutoInc;
	DynamicArray<int >  FCalcFieldIndexes;
	Datadrivereh::TDataDriverEh* FDataDriver;
	Db::TDataSet* FDataSetReader;
	Contnrs::TObjectList* FDetailFieldList;
	AnsiString FDetailFields;
	bool FDetailMode;
	bool FFetchAllOnOpen;
	Memtabledataeh::TDataSetExprParserEh* FFilterExpr;
	Contnrs::TObjectList* FInstantBuffers;
	int FInstantReadCurRowNum;
	TMasterDetailSideEh FMasterDetailSide;
	Variant FMasterValues;
	TMTTreeNodeExpandingEventEh FOnTreeNodeExpanding;
	TRecordsViewTreeNodeExpandingEventEh FOnRecordsViewTreeNodeExpanding;
	TRecordsViewTreeNodeExpandedEventEh FOnRecordsViewTreeNodeExpanded;
	TRecordsViewCheckMoveNodeEventEh FOnRecordsViewCheckMoveNode;
	Db::TParams* FParams;
	bool FReadOnly;
	int FRecBufSize;
	int FRecordPos;
	Memtabledataeh::TRecordsViewEh* FRecordsView;
	TMemTableTreeListEh* FTreeList;
	Db::TIndexDefs* FIndexDefs;
	bool FStoreDefs;
	Contnrs::TObjectList* FDetailRecList;
	bool FDetailRecListActive;
	Memtabledataeh::TMemTableDataEh* FInternMemTableData;
	TCustomMemTableEh* FExternalMemData;
	int FRecordsViewUpdating;
	bool FRecordsViewUpdated;
	TSortedVarlistEh* FMasterValList;
	AnsiString FSortOrder;
	TMemTableChangeFieldValueEventEh FOnGetFieldValue;
	TMemTableChangeFieldValueEventEh FOnSetFieldValue;
	int FMTViewDataEventInactiveCount;
	int FInactiveEventRowNum;
	Toolctrlseh::TMTViewEventTypeEh FInactiveEvent;
	int FInactiveEventOldRowNum;
	bool FOldControlsDisabled;
	bool FOldActive;
	void __fastcall BeginRecordsViewUpdate(void);
	void __fastcall EndRecordsViewUpdate(bool AutoResync);
	bool __fastcall GetAggregatesActive(void);
	Memtabledataeh::TAutoIncrementEh* __fastcall GetAutoIncrement(void);
	bool __fastcall GetCachedUpdates(void);
	int __fastcall GetDataFieldsCount(void);
	int __fastcall GetInstantReadCurRowNum(void);
	AnsiString __fastcall GetMasterFields();
	Db::TDataSource* __fastcall GetMasterSource(void);
	Memtabledataeh::TMemRecViewEh* __fastcall GetTreeNode(void);
	int __fastcall GetTreeNodeChildCount(void);
	bool __fastcall GetTreeNodeExpanded(void);
	bool __fastcall GetTreeNodeHasChildren(void);
	Memtabledataeh::TUpdateErrorEh* __fastcall GetUpdateError(void);
	HIDESBASE Db::TIndexDefs* __fastcall GetIndexDefs(void);
	char * __fastcall GetInstantBuffer(void);
	bool __fastcall IsRecordInFilter(Memtabledataeh::TMemoryRecordEh* Rec);
	void __fastcall AncestorNotFound(Classes::TReader* Reader, const AnsiString ComponentName, TMetaClass* ComponentClass, Classes::TComponent* &Component);
	void __fastcall ClearRecords(void);
	void __fastcall CreateComponent(Classes::TReader* Reader, TMetaClass* ComponentClass, Classes::TComponent* &Component);
	void __fastcall InitBufferPointers(bool GetProps);
	void __fastcall RefreshParams(void);
	void __fastcall SetAggregatesActive(const bool Value);
	void __fastcall SetAutoIncrement(const Memtabledataeh::TAutoIncrementEh* Value);
	void __fastcall SetCachedUpdates(const bool Value);
	void __fastcall SetDataDriver(const Datadrivereh::TDataDriverEh* Value);
	void __fastcall SetDetailFields(const AnsiString Value);
	void __fastcall SetExternalMemData(TCustomMemTableEh* Value);
	void __fastcall SetMasterDetailSide(const TMasterDetailSideEh Value);
	void __fastcall SetMasterFields(const AnsiString Value);
	void __fastcall SetMasterSource(const Db::TDataSource* Value);
	void __fastcall SetParams(const Db::TParams* Value);
	void __fastcall SetParamsFromCursor(void);
	void __fastcall SetTreeNodeExpanded(const bool Value);
	void __fastcall SetTreeNodeHasChildren(const bool Value);
	void __fastcall SetIndexDefs(Db::TIndexDefs* Value);
	void __fastcall SortData(System::TObject* ParamSort);
	AnsiString __fastcall GetSortOrder();
	void __fastcall SetSortOrder(const AnsiString Value);
	Db::TUpdateStatusSet __fastcall GetStatusFilter(void);
	void __fastcall SetStatusFilter(const Db::TUpdateStatusSet Value);
	void __fastcall SetReadOnly(const bool Value);
	
protected:
	virtual Db::TIndexDefs* __fastcall PSGetIndexDefs(Db::TIndexOptions IndexTypes);
	bool FInstantReadMode;
	TMasterDataLinkEh* FMasterDataLink;
	AnsiString FAutoIncrementFieldName;
	virtual bool __fastcall GetActiveRecBuf(TRecBuf* &RecBuf, bool IsForWrite = false);
	bool __fastcall GetTreeNodeHasChields(void);
	int __fastcall GetTreeNodeLevel(void);
	System::TObject* __fastcall GetRecObject(void);
	int __fastcall GetPrevVisibleTreeNodeLevel(void);
	int __fastcall GetNextVisibleTreeNodeLevel(void);
	bool __fastcall MemTableIsTreeList(void);
	bool __fastcall ParentHasNextSibling(int ParenLevel);
	bool __fastcall IMemTableGetTreeNodeExpanded(int RowNum);
	int __fastcall IMemTableSetTreeNodeExpanded(int RowNum, bool Value);
	Toolctrlseh::_di_IMemTableDataFieldValueListEh __fastcall GetFieldValueList(AnsiString AFieldName);
	void __fastcall RecreateFilterExpr(void);
	void __fastcall DestroyFilterExpr(void);
	virtual char * __fastcall AllocRecordBuffer(void);
	virtual int __fastcall CompareRecords(Memtabledataeh::TMemoryRecordEh* Rec1, Memtabledataeh::TMemoryRecordEh* Rec2, System::TObject* ParamSort);
	virtual int __fastcall CompareTreeNodes(Memtreeeh::TBaseTreeNodeEh* Rec1, Memtreeeh::TBaseTreeNodeEh* Rec2, System::TObject* ParamSort);
	TCustomMemTableEh* __fastcall CreateDeltaDataSet(void);
	int __fastcall DoFetchRecords(int Count);
	Variant __fastcall FieldValueToVarValue(void * FieldBuffer, Db::TField* Field);
	Variant __fastcall GetBlobData(Db::TField* Field, TRecBuf* Buffer);
	int __fastcall BufferToIndex(char * Buf);
	TRecBuf* __fastcall BufferToRecBuf(char * Buf);
	char * __fastcall IndexToBuffer(int I);
	virtual Db::TBookmarkFlag __fastcall GetBookmarkFlag(char * Buffer);
	virtual Db::TGetResult __fastcall GetRecord(char * Buffer, Db::TGetMode GetMode, bool DoCheck);
	virtual void __fastcall ClearCalcFields(char * Buffer);
	void __fastcall CopyBuffer(char * FromBuf, char * ToBuf);
	virtual Variant __fastcall GetAggregateValue(Db::TField* Field);
	virtual Db::TDataSource* __fastcall GetDataSource(void);
	virtual AnsiString __fastcall GetBookmarkStr();
	virtual bool __fastcall GetCanModify(void);
	virtual TMetaClass* __fastcall GetFieldClass(Db::TFieldType FieldType);
	virtual int __fastcall GetRecNo(void);
	virtual int __fastcall GetRecordCount(void);
	virtual Word __fastcall GetRecordSize(void);
	Memtabledataeh::TMemoryRecordEh* __fastcall GetRec(void);
	int __fastcall IndexOfBookmark(void * Bookmark);
	virtual bool __fastcall IsCursorOpen(void);
	virtual int __fastcall InternalApplyUpdates(Memtabledataeh::TMemTableDataEh* AMemTableData, int MaxErrors);
	System::TObject* __fastcall ParseOrderByStr(AnsiString OrderByStr);
	bool __fastcall SetToRec(System::TObject* Rec);
	HIDESBASE void __fastcall BindFields(bool Binding);
	void __fastcall BindCalFields(void);
	virtual void __fastcall CloseBlob(Db::TField* Field);
	virtual void __fastcall CreateFields(void);
	virtual void __fastcall CreateIndexesFromDefs(void);
	virtual void __fastcall FreeRecordBuffer(char * &Buffer);
	virtual void __fastcall GetBookmarkData(char * Buffer, void * Data);
	virtual void __fastcall InitRecord(char * Buffer);
	virtual void __fastcall InternalGotoBookmark(void * Bookmark);
	virtual void __fastcall InternalInitRecord(char * Buffer);
	virtual void __fastcall InternalSetToRecord(char * Buffer);
	void __fastcall RecordToBuffer(Memtabledataeh::TMemoryRecordEh* MemRec, Memtabledataeh::TDataValueVersionEh DataValueVersion, char * Buffer, int RecIndex);
	virtual void __fastcall SetBookmarkData(char * Buffer, void * Data);
	virtual void __fastcall SetBookmarkFlag(char * Buffer, Db::TBookmarkFlag Value);
	virtual void __fastcall SetMemoryRecordData(char * Buffer, Memtabledataeh::TMemoryRecordEh* Rec);
	virtual void __fastcall DefChanged(System::TObject* Sender);
	virtual void __fastcall DataEvent(Db::TDataEvent Event, int Info);
	void __fastcall FetchRecord(Db::TDataSet* DataSet);
	virtual void __fastcall InternalAddRecord(void * Buffer, bool Append);
	virtual void __fastcall SetFieldData(Db::TField* Field, void * Buffer)/* overload */;
	virtual void __fastcall SetFieldData(Db::TField* Field, void * Buffer, bool NativeFormat)/* overload */;
	void __fastcall VarValueToFieldValue(const Variant &VarValue, void * FieldBuffer, Db::TField* Field);
	virtual void __fastcall DoOnNewRecord(void);
	virtual void __fastcall DoOrderBy(const AnsiString OrderByStr);
	virtual void __fastcall ReadState(Classes::TReader* Reader);
	void __fastcall SetExtraStructParams(void);
	DYNAMIC void __fastcall GetChildren(Classes::TGetChildProc Proc, Classes::TComponent* Root);
	virtual void __fastcall Loaded(void);
	HIDESBASE void __fastcall InitFieldDefsFromFields(void);
	virtual void __fastcall InternalCancel(void);
	virtual void __fastcall InternalClose(void);
	virtual void __fastcall InternalDelete(void);
	virtual void __fastcall InternalFirst(void);
	virtual void __fastcall InternalHandleException(void);
	virtual void __fastcall InternalInitFieldDefs(void);
	virtual void __fastcall InternalInsert(void);
	virtual void __fastcall InternalLast(void);
	virtual void __fastcall InternalOpen(void);
	virtual void __fastcall InternalPost(void);
	virtual void __fastcall InternalRefresh(void);
	void __fastcall MasterChange(System::TObject* Sender);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall OpenCursor(bool InfoQuery);
	virtual void __fastcall ResetAggField(Db::TField* Field);
	void __fastcall SetBlobData(Db::TField* Field, TRecBuf* Buffer, const Variant &Value);
	virtual void __fastcall SetFiltered(bool Value);
	virtual void __fastcall SetOnFilterRecord(const Db::TFilterRecordEvent Value);
	virtual void __fastcall SetRecNo(int Value);
	void __fastcall UpdateDetailMode(bool AutoRefresh);
	virtual void __fastcall UpdateIndexDefs(void);
	virtual void __fastcall UpdateSortOrder(void);
	void __fastcall RegisterEventReceiver(Classes::TComponent* AComponent);
	void __fastcall UnregisterEventReceiver(Classes::TComponent* AComponent);
	virtual void __fastcall MTViewDataEvent(int RowNum, Toolctrlseh::TMTViewEventTypeEh Event, int OldRowNum);
	int __fastcall ViewRecordIndexToViewRowNum(int ViewRecordIndex);
	Contnrs::TObjectList* __fastcall GetPrefilteredList(void);
	void __fastcall ViewDataEvent(Memtabledataeh::TMemoryRecordEh* MemRec, int Index, Memtabledataeh::TRecordsListNotification Action);
	void __fastcall ViewRecordMovedEvent(Memtabledataeh::TMemoryRecordEh* MemRec, int OldIndex, int NewIndex);
	void __fastcall MTApplyUpdates(Memtabledataeh::TMemTableDataEh* AMemTableData);
	bool __fastcall TreeViewNodeExpanding(Memtreeeh::TBaseTreeNodeEh* Sender);
	void __fastcall TreeViewNodeExpanded(Memtreeeh::TBaseTreeNodeEh* Sender);
	__property bool AggregatesActive = {read=GetAggregatesActive, write=SetAggregatesActive, default=0};
	__property int DataFieldsCount = {read=GetDataFieldsCount, nodefault};
	__property char * InstantBuffer = {read=GetInstantBuffer};
	
public:
	__fastcall virtual TCustomMemTableEh(Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomMemTableEh(void);
	virtual int __fastcall ApplyUpdates(int MaxErrors);
	virtual bool __fastcall BookmarkValid(void * Bookmark);
	int __fastcall BookmarkToRecNo(void * Bookmark);
	int __fastcall BookmarkStrToRecNo(AnsiString Bookmark);
	AnsiString __fastcall RecNoToBookmarkStr(int RecNo);
	virtual int __fastcall CompareBookmarks(void * Bookmark1, void * Bookmark2);
	virtual bool __fastcall GetCurrentRecord(char * Buffer);
	virtual void * __fastcall GetBookmark(void);
	virtual bool __fastcall GetFieldData(Db::TField* Field, void * Buffer)/* overload */;
	virtual bool __fastcall GetFieldData(Db::TField* Field, void * Buffer, bool NativeFormat)/* overload */;
	virtual bool __fastcall GetFieldData(int FieldNo, void * Buffer)/* overload */;
	virtual bool __fastcall GetFieldDataAsObject(Db::TField* Field, System::TObject* &Value);
	bool __fastcall GotoRec(Memtabledataeh::TMemoryRecordEh* Rec);
	virtual Classes::TStream* __fastcall CreateBlobStream(Db::TField* Field, Db::TBlobStreamMode Mode);
	int __fastcall FetchRecords(int Count);
	int __fastcall FindRec(const AnsiString KeyFields, const Variant &KeyValues, Db::TLocateOptions Options);
	int __fastcall InstantReadIndexOfBookmark(AnsiString Bookmark);
	int __fastcall InstantReadRowCount(void);
	virtual bool __fastcall IsSequenced(void);
	int __fastcall LoadFromDataSet(Db::TDataSet* Source, int RecordCount, TLoadMode Mode, bool UseCachedUpdates);
	virtual bool __fastcall Locate(const AnsiString KeyFields, const Variant &KeyValues, Db::TLocateOptions Options);
	virtual Variant __fastcall Lookup(const AnsiString KeyFields, const Variant &KeyValues, const AnsiString ResultFields);
	int __fastcall SaveToDataSet(Db::TDataSet* Dest, int RecordCount);
	virtual Db::TUpdateStatus __fastcall UpdateStatus(void);
	TRecBuf* __fastcall SetTempRecBufForRecord(Memtabledataeh::TMemoryRecordEh* Rec, Memtabledataeh::TMemRecViewEh* TreeNode, int RecNum);
	bool __fastcall MoveRecord(int FromIndex, int ToIndex, int TreeLevel, bool CheckOnly);
	bool __fastcall MoveRecords(Toolctrlseh::TBMListEh* BookmarkList, int ToRecNo, int TreeLevel, bool CheckOnly);
	void __fastcall CancelUpdates(void);
	void __fastcall CopyStructure(Db::TDataSet* Source);
	void __fastcall CreateDataSet(void);
	void __fastcall DriverStructChanged(void);
	void __fastcall DestroyTable(void);
	void __fastcall EmptyTable(void);
	void __fastcall FetchParams(void);
	void __fastcall InstantReadEnter(int RowNum)/* overload */;
	void __fastcall InstantReadEnter(Memtabledataeh::TMemRecViewEh* RecView, int RowNum)/* overload */;
	void __fastcall InstantReadEnter(Memtabledataeh::TMemoryRecordEh* MemRec, int RowNum)/* overload */;
	void __fastcall InstantReadLeave(void);
	void __fastcall MergeChangeLog(void);
	void __fastcall RefreshRecord(void);
	virtual void __fastcall Resync(Db::TResyncMode Mode);
	void __fastcall RevertRecord(void);
	virtual void __fastcall SetFieldDataAsObject(Db::TField* Field, System::TObject* Value);
	virtual void __fastcall SetFilterText(const AnsiString Value);
	void __fastcall SortByFields(const AnsiString SortByStr);
	__property Memtabledataeh::TAutoIncrementEh* AutoIncrement = {read=GetAutoIncrement, write=SetAutoIncrement};
	__property bool CachedUpdates = {read=GetCachedUpdates, write=SetCachedUpdates, default=0};
	__property Datadrivereh::TDataDriverEh* DataDriver = {read=FDataDriver, write=SetDataDriver};
	__property AnsiString DetailFields = {read=FDetailFields, write=SetDetailFields};
	__property TCustomMemTableEh* ExternalMemData = {read=FExternalMemData, write=SetExternalMemData};
	__property bool FetchAllOnOpen = {read=FFetchAllOnOpen, write=FFetchAllOnOpen, default=0};
	__property FieldDefs  = {stored=FStoreDefs};
	__property Db::TIndexDefs* IndexDefs = {read=GetIndexDefs, write=SetIndexDefs, stored=FStoreDefs};
	__property int InstantReadCurRow = {read=GetInstantReadCurRowNum, nodefault};
	__property TMasterDetailSideEh MasterDetailSide = {read=FMasterDetailSide, write=SetMasterDetailSide, default=0};
	__property AnsiString MasterFields = {read=GetMasterFields, write=SetMasterFields};
	__property Db::TDataSource* MasterSource = {read=GetMasterSource, write=SetMasterSource};
	__property Db::TParams* Params = {read=FParams, write=SetParams};
	__property bool ReadOnly = {read=FReadOnly, write=SetReadOnly, default=0};
	__property Memtabledataeh::TMemoryRecordEh* Rec = {read=GetRec};
	__property Memtabledataeh::TRecordsViewEh* RecordsView = {read=FRecordsView};
	__property AnsiString SortOrder = {read=GetSortOrder, write=SetSortOrder};
	__property Db::TUpdateStatusSet StatusFilter = {read=GetStatusFilter, write=SetStatusFilter, default=7};
	__property bool StoreDefs = {read=FStoreDefs, write=FStoreDefs, default=0};
	__property TMemTableTreeListEh* TreeList = {read=FTreeList, write=FTreeList};
	__property Memtabledataeh::TMemRecViewEh* TreeNode = {read=GetTreeNode};
	__property int TreeNodeChildCount = {read=GetTreeNodeChildCount, nodefault};
	__property bool TreeNodeExpanded = {read=GetTreeNodeExpanded, write=SetTreeNodeExpanded, nodefault};
	__property bool TreeNodeHasChildren = {read=GetTreeNodeHasChildren, write=SetTreeNodeHasChildren, nodefault};
	__property int TreeNodeLevel = {read=GetTreeNodeLevel, nodefault};
	__property Memtabledataeh::TUpdateErrorEh* UpdateError = {read=GetUpdateError};
	__property TMTTreeNodeExpandingEventEh OnTreeNodeExpanding = {read=FOnTreeNodeExpanding, write=FOnTreeNodeExpanding};
	__property TRecordsViewTreeNodeExpandingEventEh OnRecordsViewTreeNodeExpanding = {read=FOnRecordsViewTreeNodeExpanding, write=FOnRecordsViewTreeNodeExpanding};
	__property TRecordsViewTreeNodeExpandedEventEh OnRecordsViewTreeNodeExpanded = {read=FOnRecordsViewTreeNodeExpanded, write=FOnRecordsViewTreeNodeExpanded};
	__property TRecordsViewCheckMoveNodeEventEh OnRecordsViewCheckMoveNode = {read=FOnRecordsViewCheckMoveNode, write=FOnRecordsViewCheckMoveNode};
	__property TMemTableChangeFieldValueEventEh OnGetFieldValue = {read=FOnGetFieldValue, write=FOnGetFieldValue};
	__property TMemTableChangeFieldValueEventEh OnSetFieldValue = {read=FOnSetFieldValue, write=FOnSetFieldValue};
private:
	void *__IInterface;	/* System::IInterface */
	void *__IMemTableEh;	/* Toolctrlseh::IMemTableEh */
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator System::_di_IInterface()
	{
		System::_di_IInterface intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IInterface*(void) { return (IInterface*)&__IInterface; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator Toolctrlseh::_di_IMemTableEh()
	{
		Toolctrlseh::_di_IMemTableEh intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IMemTableEh*(void) { return (IMemTableEh*)&__IMemTableEh; }
	#endif
	
};


class PASCALIMPLEMENTATION TMemTableTreeListEh : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	TCustomMemTableEh* FMemTable;
	bool FLoadingActive;
	bool __fastcall GetActive(void);
	bool __fastcall GetDefaultNodeExpanded(void);
	bool __fastcall GetDefaultNodeHasChildren(void);
	bool __fastcall GetFilterNodeIfParentVisible(void);
	bool __fastcall GetFullBuildCheck(void);
	AnsiString __fastcall GetKeyFieldName();
	AnsiString __fastcall GetRefParentFieldName();
	void __fastcall SetActive(const bool Value);
	void __fastcall SetDefaultNodeExpanded(const bool Value);
	void __fastcall SetDefaultNodeHasChildren(const bool Value);
	void __fastcall SetFilterNodeIfParentVisible(const bool Value);
	void __fastcall SetFullBuildCheck(const bool Value);
	void __fastcall SetKeyFieldName(const AnsiString Value);
	void __fastcall SetRefParentFieldName(const AnsiString Value);
	
public:
	__fastcall TMemTableTreeListEh(TCustomMemTableEh* AMemTable);
	virtual bool __fastcall Locate(const AnsiString KeyFields, const Variant &KeyValues, Db::TLocateOptions Options);
	virtual void __fastcall FullCollapse(void);
	virtual void __fastcall FullExpand(void);
	
__published:
	__property bool Active = {read=GetActive, write=SetActive, default=0};
	__property AnsiString KeyFieldName = {read=GetKeyFieldName, write=SetKeyFieldName};
	__property AnsiString RefParentFieldName = {read=GetRefParentFieldName, write=SetRefParentFieldName};
	__property bool DefaultNodeExpanded = {read=GetDefaultNodeExpanded, write=SetDefaultNodeExpanded, default=0};
	__property bool DefaultNodeHasChildren = {read=GetDefaultNodeHasChildren, write=SetDefaultNodeHasChildren, default=0};
	__property bool FullBuildCheck = {read=GetFullBuildCheck, write=SetFullBuildCheck, default=1};
	__property bool FilterNodeIfParentVisible = {read=GetFilterNodeIfParentVisible, write=SetFilterNodeIfParentVisible, default=1};
public:
	#pragma option push -w-inl
	/* TPersistent.Destroy */ inline __fastcall virtual ~TMemTableTreeListEh(void) { }
	#pragma option pop
	
};


#pragma option push -b-
enum TMTUpdateActionEh { uaFailEh, uaAbortEh, uaSkipEh, uaRetryEh, uaApplyEh, uaAppliedEh };
#pragma option pop

typedef void __fastcall (__closure *TMTUpdateRecordEventEh)(Db::TDataSet* DeltaDataSet, Db::TUpdateKind UpdateKind, TMTUpdateActionEh &UpdateAction);

typedef void __fastcall (__closure *TMTFetchRecordEventEh)(Db::TDataSet* PacketDataSet, bool &ProviderEOF, bool &Applied);

typedef void __fastcall (__closure *TMTRefreshRecordEventEh)(Db::TDataSet* PacketDataSet, bool &Applied);

typedef DynamicArray<Variant >  TFBRecBufValues;

class PASCALIMPLEMENTATION TRecBuf : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	bool InUse;
	int Bookmark;
	Db::TBookmarkFlag BookmarkFlag;
	int RecordStatus;
	int RecordNumber;
	bool NewTreeNodeExpanded;
	bool NewTreeNodeHasChildren;
	Memtabledataeh::TMemRecViewEh* RecView;
	Memtabledataeh::TMemoryRecordEh* MemRec;
	DynamicArray<Variant >  Values;
	bool UseMemRec;
	Variant __fastcall GetValue(Db::TField* Field);
	int __fastcall ReadValueCount(void);
	void __fastcall SetValue(Db::TField* Field, const Variant &v);
	void __fastcall SetLength(int Len);
	void __fastcall Clear(void);
	__fastcall virtual ~TRecBuf(void);
	__property Variant Value[Db::TField* Field] = {read=GetValue, write=SetValue};
	__property int ValueCount = {read=ReadValueCount, nodefault};
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TRecBuf(void) : System::TObject() { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TSortedVarItemEh : public System::TObject 
{
	typedef System::TObject inherited;
	
protected:
	Variant Value;
	
public:
	__fastcall TSortedVarItemEh(const Variant &NewValue);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TSortedVarItemEh(void) { }
	#pragma option pop
	
};


typedef DynamicArray<int >  MemTableEh__7;

class DELPHICLASS TMemBlobStreamEh;
class PASCALIMPLEMENTATION TMemBlobStreamEh : public Classes::TMemoryStream 
{
	typedef Classes::TMemoryStream inherited;
	
private:
	Db::TBlobField* FField;
	TCustomMemTableEh* FDataSet;
	TRecBuf* FBuffer;
	int FFieldNo;
	bool FModified;
	Variant FData;
	Variant FFieldData;
	
protected:
	void __fastcall ReadBlobData(void);
	virtual void * __fastcall Realloc(int &NewCapacity);
	
public:
	__fastcall TMemBlobStreamEh(Db::TBlobField* Field, Db::TBlobStreamMode Mode);
	__fastcall virtual ~TMemBlobStreamEh(void);
	virtual int __fastcall Write(const void *Buffer, int Count);
	void __fastcall Truncate(void);
};


class DELPHICLASS TMemTableEh;
class PASCALIMPLEMENTATION TMemTableEh : public TCustomMemTableEh 
{
	typedef TCustomMemTableEh inherited;
	
__published:
	__property Active  = {default=0};
	__property AggregatesActive  = {default=0};
	__property AutoCalcFields  = {default=1};
	__property AutoIncrement ;
	__property CachedUpdates  = {default=0};
	__property DetailFields ;
	__property ExternalMemData ;
	__property FieldDefs ;
	__property Filter ;
	__property Filtered  = {default=0};
	__property FetchAllOnOpen  = {default=0};
	__property IndexDefs ;
	__property MasterDetailSide  = {default=0};
	__property MasterFields ;
	__property MasterSource ;
	__property Params ;
	__property DataDriver ;
	__property ReadOnly  = {default=0};
	__property SortOrder ;
	__property StoreDefs  = {default=0};
	__property TreeList ;
	__property BeforeOpen ;
	__property AfterOpen ;
	__property BeforeClose ;
	__property AfterClose ;
	__property BeforeInsert ;
	__property AfterInsert ;
	__property BeforeEdit ;
	__property AfterEdit ;
	__property BeforePost ;
	__property AfterPost ;
	__property BeforeCancel ;
	__property AfterCancel ;
	__property BeforeDelete ;
	__property AfterDelete ;
	__property BeforeScroll ;
	__property AfterScroll ;
	__property BeforeRefresh ;
	__property AfterRefresh ;
	__property OnCalcFields ;
	__property OnDeleteError ;
	__property OnEditError ;
	__property OnFilterRecord ;
	__property OnNewRecord ;
	__property OnPostError ;
	__property OnGetFieldValue ;
	__property OnSetFieldValue ;
public:
	#pragma option push -w-inl
	/* TCustomMemTableEh.Create */ inline __fastcall virtual TMemTableEh(Classes::TComponent* AOwner) : TCustomMemTableEh(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomMemTableEh.Destroy */ inline __fastcall virtual ~TMemTableEh(void) { }
	#pragma option pop
	
};


class DELPHICLASS TMemTableDataFieldValueListEh;
class PASCALIMPLEMENTATION TMemTableDataFieldValueListEh : public System::TInterfacedObject 
{
	typedef System::TInterfacedObject inherited;
	
private:
	Classes::TStringList* FValues;
	bool FDataObsoleted;
	AnsiString FFieldName;
	Memtabledataeh::TRecordsListNotificatorEh* FNotificator;
	Classes::TStrings* __fastcall GetValues(void);
	void __fastcall SetFieldName(const AnsiString Value);
	Classes::TComponent* __fastcall GetDataObject(void);
	void __fastcall SetDataObject(const Classes::TComponent* Value);
	
protected:
	void __fastcall MTDataEvent(Memtabledataeh::TMemoryRecordEh* MemRec, int Index, Memtabledataeh::TRecordsListNotification Action);
	virtual void __fastcall RecordListChanged(void);
	void __fastcall RefreshValues(void);
	
public:
	__fastcall TMemTableDataFieldValueListEh(void);
	__fastcall virtual ~TMemTableDataFieldValueListEh(void);
	__property AnsiString FieldName = {read=FFieldName, write=SetFieldName};
	__property Classes::TComponent* DataObject = {read=GetDataObject, write=SetDataObject};
	__property Classes::TStrings* Values = {read=GetValues};
private:
	void *__IMemTableDataFieldValueListEh;	/* Toolctrlseh::IMemTableDataFieldValueListEh */
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator Toolctrlseh::_di_IMemTableDataFieldValueListEh()
	{
		Toolctrlseh::_di_IMemTableDataFieldValueListEh intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IMemTableDataFieldValueListEh*(void) { return (IMemTableDataFieldValueListEh*)&__IMemTableDataFieldValueListEh; }
	#endif
	
};


class DELPHICLASS TRefObjectField;
class PASCALIMPLEMENTATION TRefObjectField : public Db::TField 
{
	typedef Db::TField inherited;
	
protected:
	/* virtual class method */ virtual void __fastcall CheckTypeSize(TMetaClass* vmt, int Value);
	virtual Variant __fastcall GetAsVariant();
	System::TObject* __fastcall GetValue(void);
	void __fastcall SetValue(const System::TObject* Value);
	virtual void __fastcall SetVarValue(const Variant &Value);
	
public:
	__fastcall virtual TRefObjectField(Classes::TComponent* AOwner);
	__property System::TObject* Value = {read=GetValue, write=SetValue};
public:
	#pragma option push -w-inl
	/* TField.Destroy */ inline __fastcall virtual ~TRefObjectField(void) { }
	#pragma option pop
	
};


class DELPHICLASS TMTOrderByList;
class PASCALIMPLEMENTATION TMTOrderByList : public Memtabledataeh::TOrderByList 
{
	typedef Memtabledataeh::TOrderByList inherited;
	
public:
	#pragma option push -w-inl
	/* TObjectList.Create */ inline __fastcall TMTOrderByList(void)/* overload */ : Memtabledataeh::TOrderByList() { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TList.Destroy */ inline __fastcall virtual ~TMTOrderByList(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall AssignRecord(Db::TDataSet* Source, Db::TDataSet* Destinate);

}	/* namespace Memtableeh */
using namespace Memtableeh;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Memtableeh
