// CodeGear C++ Builder
// Copyright (c) 1995, 2007 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Datadrivereh.pas' rev: 11.00

#ifndef DatadriverehHPP
#define DatadriverehHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Contnrs.hpp>	// Pascal unit
#include <Ehlibvcl.hpp>	// Pascal unit
#include <Toolctrlseh.hpp>	// Pascal unit
#include <Dbcommon.hpp>	// Pascal unit
#include <Memtabledataeh.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Datadrivereh
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TUpdateErrorActionEh { ueaBreakAbortEh, ueaBreakRaiseEh, ueaCountinueEh, ueaRetryEh, ueaCountinueSkip };
#pragma option pop

class DELPHICLASS TDataDriverEh;
typedef void __fastcall (__closure *TDataDriverProduceDataReaderEhEvent)(TDataDriverEh* DataDriver, Db::TDataSet* &DataReader, bool &FreeOnEof);

typedef void __fastcall (__closure *TDataDriverBuildDataStructEhEvent)(TDataDriverEh* DataDriver, Memtabledataeh::TMTDataStructEh* DataStruct);

typedef void __fastcall (__closure *TDataDriverReadRecordEhEvent)(TDataDriverEh* DataDriver, Memtabledataeh::TMemTableDataEh* MemTableData, Memtabledataeh::TMemoryRecordEh* MemRec, bool &ProviderEOF);

typedef void __fastcall (__closure *TDataDriverUpdateErrorEhEvent)(TDataDriverEh* DataDriver, Memtabledataeh::TMemTableDataEh* MemTableData, Memtabledataeh::TMemoryRecordEh* MemRec, TUpdateErrorActionEh &Action);

typedef void __fastcall (__closure *TDataDriverRecordEhEvent)(TDataDriverEh* DataDriver, Memtabledataeh::TMemTableDataEh* MemTableData, Memtabledataeh::TMemoryRecordEh* MemRec);

typedef void __fastcall (__closure *TDataDriverAssignFieldValueEhEvent)(TDataDriverEh* DataDriver, Memtabledataeh::TMemTableDataEh* MemTableData, Memtabledataeh::TMemoryRecordEh* MemRec, int DataFieldIndex, Memtabledataeh::TDataValueVersionEh DataValueVersion, Db::TDataSet* ReaderDataSet);

__interface IDataDriverConsumerEh;
typedef System::DelphiInterface<IDataDriverConsumerEh> _di_IDataDriverConsumerEh;
__interface  INTERFACE_UUID("{E390BBF2-666F-43D7-8CC8-1FA2BA8263D1}") IDataDriverConsumerEh  : public IInterface 
{
	
public:
	virtual void __fastcall SetDataDriverConsumer(System::TObject* AObject) = 0 ;
	virtual System::TObject* __fastcall GetDataDriverConsumer(void) = 0 ;
	__property System::TObject* DataDriverConsumer = {read=GetDataDriverConsumer, write=SetDataDriverConsumer};
};

class PASCALIMPLEMENTATION TDataDriverEh : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	AnsiString FKeyFields;
	TDataDriverAssignFieldValueEhEvent FOnAssignFieldValue;
	TDataDriverBuildDataStructEhEvent FOnBuildDataStruct;
	TDataDriverProduceDataReaderEhEvent FOnProduceDataReader;
	TDataDriverReadRecordEhEvent FOnReadRecord;
	TDataDriverRecordEhEvent FOnRefreshRecord;
	TDataDriverUpdateErrorEhEvent FOnUpdateError;
	TDataDriverRecordEhEvent FOnUpdateRecord;
	Db::TDataSet* FProviderDataSet;
	bool FProviderEOF;
	Db::TDataSet* FReaderDataSet;
	bool FReaderDataSetFreeOnEof;
	bool FResolveToDataSet;
	System::TObject* FDataDriverConsumer;
	void __fastcall SetKeyFields(const AnsiString Value);
	void __fastcall SetProviderDataSet(const Db::TDataSet* Value);
	void __fastcall SetProviderEOF(const bool Value);
	
protected:
	System::TObject* __fastcall GetDataDriverConsumer(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall SetAutoIncFields(Db::TFields* Fields, Memtabledataeh::TMTDataStructEh* DataStruct);
	void __fastcall SetDataDriverConsumer(System::TObject* ADataDriverConsumer);
	__property AnsiString KeyFields = {read=FKeyFields, write=SetKeyFields};
	__property Db::TDataSet* ProviderDataSet = {read=FProviderDataSet, write=SetProviderDataSet};
	__property Db::TDataSet* ReaderDataSet = {read=FReaderDataSet};
	
public:
	__fastcall virtual TDataDriverEh(Classes::TComponent* AOwner);
	__fastcall virtual ~TDataDriverEh(void);
	virtual int __fastcall ApplyUpdates(Memtabledataeh::TMemTableDataEh* MemTableData);
	virtual int __fastcall DefaultUpdateRecord(Memtabledataeh::TMemTableDataEh* MemTableData, Memtabledataeh::TMemoryRecordEh* MemRec);
	virtual Db::TDataSet* __fastcall GetDataReader(void);
	virtual int __fastcall ReadData(Memtabledataeh::TMemTableDataEh* MemTableData, int Count);
	virtual bool __fastcall RefreshReaderParamsFromCursor(Db::TDataSet* DataSet);
	virtual void __fastcall AssignFieldValue(Memtabledataeh::TMemTableDataEh* MemTableData, Memtabledataeh::TMemoryRecordEh* MemRec, int DataFieldIndex, Memtabledataeh::TDataValueVersionEh DataValueVersion, Db::TDataSet* ReaderDataSet);
	virtual void __fastcall UpdateRecord(Memtabledataeh::TMemTableDataEh* MemTableData, Memtabledataeh::TMemoryRecordEh* MemRec);
	virtual void __fastcall ConsumerClosed(Db::TDataSet* ConsumerDataSet);
	virtual void __fastcall DefaultAssignFieldValue(Memtabledataeh::TMemTableDataEh* MemTableData, Memtabledataeh::TMemoryRecordEh* MemRec, int DataFieldIndex, Memtabledataeh::TDataValueVersionEh DataValueVersion, Db::TDataSet* ReaderDataSet);
	virtual void __fastcall DefaultBuildDataStruct(Memtabledataeh::TMTDataStructEh* DataStruct);
	virtual void __fastcall DefaultProduceDataReader(Db::TDataSet* &DataSet, bool &FreeOnEof);
	virtual void __fastcall DefaultReadRecord(Memtabledataeh::TMemTableDataEh* MemTableData, Memtabledataeh::TMemoryRecordEh* Rec, bool &ProviderEOF);
	virtual void __fastcall DefaultUpdateError(Memtabledataeh::TMemTableDataEh* MemTableData, Memtabledataeh::TMemoryRecordEh* MemRec, TUpdateErrorActionEh &Action);
	virtual void __fastcall DefaultRefreshRecord(Memtabledataeh::TMemoryRecordEh* MemRecord);
	virtual void __fastcall BuildDataStruct(Memtabledataeh::TMTDataStructEh* DataStruct);
	virtual void __fastcall RefreshRecord(Memtabledataeh::TMemoryRecordEh* MemRecord);
	virtual void __fastcall SetReaderParamsFromCursor(Db::TDataSet* DataSet);
	__property bool ProviderEOF = {read=FProviderEOF, write=SetProviderEOF, nodefault};
	__property bool ResolveToDataSet = {read=FResolveToDataSet, write=FResolveToDataSet, default=1};
	__property TDataDriverBuildDataStructEhEvent OnBuildDataStruct = {read=FOnBuildDataStruct, write=FOnBuildDataStruct};
	__property TDataDriverProduceDataReaderEhEvent OnProduceDataReader = {read=FOnProduceDataReader, write=FOnProduceDataReader};
	__property TDataDriverAssignFieldValueEhEvent OnAssignFieldValue = {read=FOnAssignFieldValue, write=FOnAssignFieldValue};
	__property TDataDriverReadRecordEhEvent OnReadRecord = {read=FOnReadRecord, write=FOnReadRecord};
	__property TDataDriverRecordEhEvent OnRefreshRecord = {read=FOnRefreshRecord, write=FOnRefreshRecord};
	__property TDataDriverRecordEhEvent OnUpdateRecord = {read=FOnUpdateRecord, write=FOnUpdateRecord};
	__property TDataDriverUpdateErrorEhEvent OnUpdateError = {read=FOnUpdateError, write=FOnUpdateError};
private:
	void *__IDataDriverConsumerEh;	/* Datadrivereh::IDataDriverConsumerEh */
	
public:
	operator IInterface*(void) { return (IInterface*)&__IDataDriverConsumerEh; }
	operator IDataDriverConsumerEh*(void) { return (IDataDriverConsumerEh*)&__IDataDriverConsumerEh; }
	
};


class DELPHICLASS TDataSetDriverEh;
class PASCALIMPLEMENTATION TDataSetDriverEh : public TDataDriverEh 
{
	typedef TDataDriverEh inherited;
	
__published:
	__property KeyFields ;
	__property ProviderDataSet ;
	__property OnBuildDataStruct ;
	__property OnProduceDataReader ;
	__property OnAssignFieldValue ;
	__property OnReadRecord ;
	__property OnRefreshRecord ;
	__property OnUpdateRecord ;
	__property OnUpdateError ;
	__property ResolveToDataSet  = {default=1};
public:
	#pragma option push -w-inl
	/* TDataDriverEh.Create */ inline __fastcall virtual TDataSetDriverEh(Classes::TComponent* AOwner) : TDataDriverEh(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TDataDriverEh.Destroy */ inline __fastcall virtual ~TDataSetDriverEh(void) { }
	#pragma option pop
	
};


#pragma option push -b-
enum TDynaSQLOptionEh { dsoDynamicSQLInsertEh, dsoDynamicSQLUpdateEh, dsoDynamicSQLDeleteEh };
#pragma option pop

typedef Set<TDynaSQLOptionEh, dsoDynamicSQLInsertEh, dsoDynamicSQLDeleteEh>  TDynaSQLOptionsEh;

class DELPHICLASS TDynaSQLParamsEh;
class DELPHICLASS TCustomSQLDataDriverEh;
class DELPHICLASS TCustomSQLCommandEh;
#pragma option push -b-
enum TSQLCommandTypeEh { cthSelectQuery, cthUpdateQuery, cthTable, cthStoredProc };
#pragma option pop

class PASCALIMPLEMENTATION TCustomSQLCommandEh : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	Classes::TStrings* FCommandText;
	TSQLCommandTypeEh FCommandType;
	TCustomSQLDataDriverEh* FDataDriver;
	bool __fastcall IsCommandTypeStored(void);
	
protected:
	virtual TSQLCommandTypeEh __fastcall DefaultCommandType(void);
	virtual Classes::TStrings* __fastcall GetCommandText(void);
	virtual TSQLCommandTypeEh __fastcall GetCommandType(void);
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	virtual void __fastcall CommandTextChanged(System::TObject* Sender);
	virtual void __fastcall CommandTypeChanged(void);
	virtual void __fastcall SetCommandText(const Classes::TStrings* Value);
	virtual void __fastcall SetCommandType(const TSQLCommandTypeEh Value);
	
public:
	__fastcall TCustomSQLCommandEh(TCustomSQLDataDriverEh* ADataDriver);
	__fastcall virtual ~TCustomSQLCommandEh(void);
	virtual int __fastcall Execute(Db::TDataSet* &Cursor, bool &FreeOnEof);
	DYNAMIC AnsiString __fastcall GetNamePath();
	virtual Db::TParams* __fastcall GetParams(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual void __fastcall RefreshParams(Memtabledataeh::TMemoryRecordEh* MemRecord, Memtabledataeh::TDataValueVersionEh DataValueVersion);
	virtual void __fastcall SetParams(Db::TParams* AParams);
	__property Classes::TStrings* CommandText = {read=GetCommandText, write=SetCommandText};
	__property TSQLCommandTypeEh CommandType = {read=GetCommandType, write=SetCommandType, stored=IsCommandTypeStored, nodefault};
	__property TCustomSQLDataDriverEh* DataDriver = {read=FDataDriver};
};


typedef int __fastcall (__closure *TDataDriverExecuteCommandEhEvent)(TCustomSQLDataDriverEh* DataDriver, TCustomSQLCommandEh* Command, Db::TDataSet* &Cursor, bool &FreeOnEof);

typedef void __fastcall (__closure *TDataDriverGetBackUpdatedValuesEhEvent)(TCustomSQLDataDriverEh* DataDriver, Memtabledataeh::TMemoryRecordEh* MemRec, TCustomSQLCommandEh* Command, Db::TDataSet* ResDataSet);

class DELPHICLASS TServerSpecOperationsEh;
class PASCALIMPLEMENTATION TServerSpecOperationsEh : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	bool FIncludeInsertFieldsInUpdateCommand;
	
protected:
	virtual void __fastcall GenWhereClause(AnsiString KeyFields, Classes::TStrings* SQL);
	virtual void __fastcall BuildChangedFieldList(Memtabledataeh::TMemoryRecordEh* MemRec, Classes::TStringList* UpdateFieldList, Classes::TStringList* ChangedFieldList);
	
public:
	__fastcall virtual TServerSpecOperationsEh(void);
	virtual int __fastcall UpdateRecord(TCustomSQLDataDriverEh* SQLDataDriver, Memtabledataeh::TMemTableDataEh* MemTableData, Memtabledataeh::TMemoryRecordEh* MemRec);
	virtual void __fastcall GetBackUpdatedValues(Memtabledataeh::TMemoryRecordEh* MemRec, TCustomSQLCommandEh* Command, Db::TDataSet* ResDataSet);
	virtual void __fastcall GenerateDynaSQLCommand(Memtabledataeh::TMemoryRecordEh* MemRec, TCustomSQLCommandEh* Command);
	virtual void __fastcall GenerateDeleteCommand(Memtabledataeh::TMemoryRecordEh* MemRec, TCustomSQLCommandEh* Command);
	virtual void __fastcall GenerateUpdateCommand(Memtabledataeh::TMemoryRecordEh* MemRec, TCustomSQLCommandEh* Command);
	virtual void __fastcall GenerateInsertCommand(Memtabledataeh::TMemoryRecordEh* MemRec, TCustomSQLCommandEh* Command);
	__property bool IncludeInsertFieldsInUpdateCommand = {read=FIncludeInsertFieldsInUpdateCommand, write=FIncludeInsertFieldsInUpdateCommand, nodefault};
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TServerSpecOperationsEh(void) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TCustomSQLDataDriverEh : public TDataDriverEh 
{
	typedef TDataDriverEh inherited;
	
private:
	TCustomSQLCommandEh* FDeleteCommand;
	Classes::TComponent* FDesignDataBase;
	TCustomSQLCommandEh* FGetrecCommand;
	TCustomSQLCommandEh* FInsertCommand;
	TDataDriverExecuteCommandEhEvent FOnExecuteCommand;
	TDataDriverGetBackUpdatedValuesEhEvent FOnGetBackUpdatedValues;
	TCustomSQLCommandEh* FSelectCommand;
	Classes::TStrings* FSpecParams;
	TCustomSQLCommandEh* FUpdateCommand;
	TCustomSQLCommandEh* FServiceCommand;
	TServerSpecOperationsEh* FServerSpecOperations;
	TDynaSQLParamsEh* FDynaSQLParams;
	Classes::TStrings* __fastcall GetDeleteSQL(void);
	Classes::TStrings* __fastcall GetGetrecSQL(void);
	Classes::TStrings* __fastcall GetInsertSQL(void);
	Classes::TStrings* __fastcall GetSelectSQL(void);
	Classes::TStrings* __fastcall GetUpdateSQL(void);
	void __fastcall SetDeleteCommand(const TCustomSQLCommandEh* Value);
	void __fastcall SetDeleteSQL(const Classes::TStrings* Value);
	void __fastcall SetGetrecCommand(const TCustomSQLCommandEh* Value);
	void __fastcall SetGetrecSQL(const Classes::TStrings* Value);
	void __fastcall SetInsertCommand(const TCustomSQLCommandEh* Value);
	void __fastcall SetInsertSQL(const Classes::TStrings* Value);
	void __fastcall SetSelectCommand(const TCustomSQLCommandEh* Value);
	void __fastcall SetSelectSQL(const Classes::TStrings* Value);
	void __fastcall SetSpecParams(const Classes::TStrings* Value);
	void __fastcall SetUpdateCommand(const TCustomSQLCommandEh* Value);
	void __fastcall SetUpdateSQL(const Classes::TStrings* Value);
	void __fastcall SetServiceCommand(const TCustomSQLCommandEh* Value);
	void __fastcall SetDynaSQLParams(const TDynaSQLParamsEh* Value);
	void __fastcall SetServerSpecOperations(const TServerSpecOperationsEh* Value);
	
protected:
	virtual void __fastcall SetAutoIncFields(Db::TFields* Fields, Memtabledataeh::TMTDataStructEh* DataStruct);
	virtual void __fastcall SetDesignDataBase(const Classes::TComponent* Value);
	
public:
	virtual TCustomSQLDataDriverEh* __fastcall CreateDesignCopy(void);
	virtual Classes::TComponent* __fastcall CreateDesignDataBase(void);
	virtual Classes::TComponent* __fastcall GetDesignDataBase(void);
	virtual void __fastcall AssignFromDesignDriver(TCustomSQLDataDriverEh* DesignDataDriver);
	__property Classes::TComponent* DesignDataBase = {read=FDesignDataBase, write=SetDesignDataBase};
	
protected:
	virtual TCustomSQLCommandEh* __fastcall CreateCommand(void);
	virtual TCustomSQLCommandEh* __fastcall CreateDeleteCommand(void);
	virtual TCustomSQLCommandEh* __fastcall CreateInsertCommand(void);
	virtual TCustomSQLCommandEh* __fastcall CreateSelectCommand(void);
	virtual TCustomSQLCommandEh* __fastcall CreateGetrecCommand(void);
	virtual TCustomSQLCommandEh* __fastcall CreateUpdateCommand(void);
	virtual TSQLCommandTypeEh __fastcall GetDefaultCommandTypeFor(TCustomSQLCommandEh* Command);
	virtual TServerSpecOperationsEh* __fastcall InternalGetServerSpecOperations(void);
	virtual void __fastcall CommandTextChanged(TCustomSQLCommandEh* Sender);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall UpdateServerService(void);
	__property TCustomSQLCommandEh* ServiceCommand = {read=FServiceCommand, write=SetServiceCommand};
	
public:
	__fastcall virtual TCustomSQLDataDriverEh(Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomSQLDataDriverEh(void);
	virtual int __fastcall DefaultUpdateRecord(Memtabledataeh::TMemTableDataEh* MemTableData, Memtabledataeh::TMemoryRecordEh* MemRec);
	virtual int __fastcall DoUpdateRecord(Memtabledataeh::TMemTableDataEh* MemTableData, Memtabledataeh::TMemoryRecordEh* MemRec);
	virtual int __fastcall ExecuteCommand(TCustomSQLCommandEh* Command, Db::TDataSet* &Cursor, bool &FreeOnEof);
	virtual int __fastcall DefaultExecuteCommand(TCustomSQLCommandEh* Command, Db::TDataSet* &Cursor, bool &FreeOnEof);
	virtual bool __fastcall RefreshReaderParamsFromCursor(Db::TDataSet* DataSet);
	virtual bool __fastcall HaveDataConnection(void);
	virtual void __fastcall GetBackUpdatedValues(Memtabledataeh::TMemoryRecordEh* MemRec, TCustomSQLCommandEh* Command, Db::TDataSet* ResDataSet);
	virtual void __fastcall DefaultBuildDataStruct(Memtabledataeh::TMTDataStructEh* DataStruct);
	virtual void __fastcall DefaultGetUpdatedServerValues(Memtabledataeh::TMemoryRecordEh* MemRec, TCustomSQLCommandEh* Command, Db::TDataSet* ResDataSet);
	virtual void __fastcall DefaultProduceDataReader(Db::TDataSet* &DataSet, bool &FreeOnEof);
	virtual void __fastcall DefaultRefreshRecord(Memtabledataeh::TMemoryRecordEh* MemRecord);
	virtual void __fastcall GenerateDynamicSQLCommand(Memtabledataeh::TMemoryRecordEh* MemRecord, TCustomSQLCommandEh* Command);
	virtual void __fastcall SetReaderParamsFromCursor(Db::TDataSet* DataSet);
	__property TDynaSQLParamsEh* DynaSQLParams = {read=FDynaSQLParams, write=SetDynaSQLParams};
	__property ResolveToDataSet  = {default=0};
	__property TCustomSQLCommandEh* DeleteCommand = {read=FDeleteCommand, write=SetDeleteCommand};
	__property Classes::TStrings* DeleteSQL = {read=GetDeleteSQL, write=SetDeleteSQL, stored=false};
	__property TCustomSQLCommandEh* GetrecCommand = {read=FGetrecCommand, write=SetGetrecCommand};
	__property Classes::TStrings* GetrecSQL = {read=GetGetrecSQL, write=SetGetrecSQL, stored=false};
	__property TCustomSQLCommandEh* InsertCommand = {read=FInsertCommand, write=SetInsertCommand};
	__property Classes::TStrings* InsertSQL = {read=GetInsertSQL, write=SetInsertSQL, stored=false};
	__property TCustomSQLCommandEh* SelectCommand = {read=FSelectCommand, write=SetSelectCommand};
	__property Classes::TStrings* SelectSQL = {read=GetSelectSQL, write=SetSelectSQL, stored=false};
	__property TServerSpecOperationsEh* ServerSpecOperations = {read=FServerSpecOperations, write=SetServerSpecOperations};
	__property Classes::TStrings* SpecParams = {read=FSpecParams, write=SetSpecParams};
	__property TCustomSQLCommandEh* UpdateCommand = {read=FUpdateCommand, write=SetUpdateCommand};
	__property Classes::TStrings* UpdateSQL = {read=GetUpdateSQL, write=SetUpdateSQL, stored=false};
	__property TDataDriverExecuteCommandEhEvent OnExecuteCommand = {read=FOnExecuteCommand, write=FOnExecuteCommand};
	__property TDataDriverGetBackUpdatedValuesEhEvent OnGetBackUpdatedValues = {read=FOnGetBackUpdatedValues, write=FOnGetBackUpdatedValues};
};


class PASCALIMPLEMENTATION TDynaSQLParamsEh : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	TCustomSQLDataDriverEh* FDataDriver;
	AnsiString FUpdateTable;
	AnsiString FUpdateFields;
	AnsiString FKeyFields;
	bool FSkipUnchangedFields;
	TDynaSQLOptionsEh FOptions;
	void __fastcall SetKeyFields(const AnsiString Value);
	void __fastcall SetUpdateFields(const AnsiString Value);
	void __fastcall SetUpdateTable(const AnsiString Value);
	
public:
	__fastcall TDynaSQLParamsEh(TCustomSQLDataDriverEh* ADataDriver);
	__fastcall virtual ~TDynaSQLParamsEh(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property TCustomSQLDataDriverEh* DataDriver = {read=FDataDriver};
	
__published:
	__property AnsiString KeyFields = {read=FKeyFields, write=SetKeyFields};
	__property AnsiString UpdateFields = {read=FUpdateFields, write=SetUpdateFields};
	__property AnsiString UpdateTable = {read=FUpdateTable, write=SetUpdateTable};
	__property bool SkipUnchangedFields = {read=FSkipUnchangedFields, write=FSkipUnchangedFields, default=0};
	__property TDynaSQLOptionsEh Options = {read=FOptions, write=FOptions, nodefault};
};


typedef int __fastcall (__closure *TSQLExecuteEhEvent)(Db::TDataSet* &Cursor, bool &FreeOnEof);

typedef void __fastcall (__closure *TAssignParamEhEvent)(TCustomSQLCommandEh* Command, Memtabledataeh::TMemoryRecordEh* MemRecord, Memtabledataeh::TDataValueVersionEh DataValueVersion, Db::TParam* Param);

typedef int __fastcall (__closure *TResolverExecuteCommandEhEvent)(TCustomSQLDataDriverEh* SQLDataDriver, TCustomSQLCommandEh* Command, Db::TDataSet* &Cursor, bool &FreeOnEof, bool &Processed);

typedef void __fastcall (__closure *TResolverGetBackUpdatedValuesEhEvent)(TCustomSQLDataDriverEh* SQLDataDriver, Memtabledataeh::TMemoryRecordEh* MemRec, TCustomSQLCommandEh* Command, Db::TDataSet* ResDataSet, bool &Processed);

typedef TServerSpecOperationsEh* __fastcall (__closure *TResolverGetServerSpecOperationsEh)(bool &Processed);

typedef void __fastcall (*TResolverUpdateRecordEhEvent)(TCustomSQLDataDriverEh* SQLDataDriver, Memtabledataeh::TMemTableDataEh* MemTableData, Memtabledataeh::TMemoryRecordEh* MemRec, bool &Processed);

class DELPHICLASS TSQLDataDriverResolver;
class PASCALIMPLEMENTATION TSQLDataDriverResolver : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	TServerSpecOperationsEh* FServerSpecOperations;
	TResolverExecuteCommandEhEvent FOnExecuteCommand;
	TResolverGetBackUpdatedValuesEhEvent FOnGetBackUpdatedValues;
	TResolverGetServerSpecOperationsEh FOnGetServerSpecOperations;
	TResolverUpdateRecordEhEvent FOnUpdateRecord;
	
public:
	virtual int __fastcall ExecuteCommand(TCustomSQLDataDriverEh* SQLDataDriver, TCustomSQLCommandEh* Command, Db::TDataSet* &Cursor, bool &FreeOnEof, bool &Processed);
	virtual TServerSpecOperationsEh* __fastcall GetServerSpecOperations(bool &Processed);
	virtual void __fastcall UpdateRecord(TCustomSQLDataDriverEh* SQLDataDriver, Memtabledataeh::TMemTableDataEh* MemTableData, Memtabledataeh::TMemoryRecordEh* MemRec, bool &Processed);
	virtual void __fastcall DefaultUpdateRecord(TCustomSQLDataDriverEh* SQLDataDriver, Memtabledataeh::TMemTableDataEh* MemTableData, Memtabledataeh::TMemoryRecordEh* MemRec, bool &Processed);
	virtual void __fastcall GetBackUpdatedValues(TCustomSQLDataDriverEh* SQLDataDriver, Memtabledataeh::TMemoryRecordEh* MemRec, TCustomSQLCommandEh* Command, Db::TDataSet* ResDataSet, bool &Processed);
	virtual void __fastcall DefaultGetUpdatedServerValues(TCustomSQLDataDriverEh* SQLDataDriver, Memtabledataeh::TMemoryRecordEh* MemRec, TCustomSQLCommandEh* Command, Db::TDataSet* ResDataSet, bool &Processed);
	__property TServerSpecOperationsEh* ServerSpecOperations = {read=FServerSpecOperations, write=FServerSpecOperations};
	__property TResolverExecuteCommandEhEvent OnExecuteCommand = {read=FOnExecuteCommand, write=FOnExecuteCommand};
	__property TResolverGetBackUpdatedValuesEhEvent OnGetBackUpdatedValues = {read=FOnGetBackUpdatedValues, write=FOnGetBackUpdatedValues};
	__property TResolverGetServerSpecOperationsEh OnGetServerSpecOperations = {read=FOnGetServerSpecOperations, write=FOnGetServerSpecOperations};
	__property TResolverUpdateRecordEhEvent OnUpdateRecord = {read=FOnUpdateRecord, write=FOnUpdateRecord};
public:
	#pragma option push -w-inl
	/* TPersistent.Destroy */ inline __fastcall virtual ~TSQLDataDriverResolver(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TSQLDataDriverResolver(void) : Classes::TPersistent() { }
	#pragma option pop
	
};


class DELPHICLASS TBaseSQLDataDriverEh;
class DELPHICLASS TBaseSQLCommandEh;
typedef int __fastcall (__closure *TSQLDataDriverExecuteCommandEhEvent)(TBaseSQLDataDriverEh* DataDriver, TBaseSQLCommandEh* Command, Db::TDataSet* &Cursor, bool &FreeOnEof);

typedef void __fastcall (__closure *TSQLDataDriverAssignParamEhEvent)(TBaseSQLDataDriverEh* DataDriver, TBaseSQLCommandEh* Command, Memtabledataeh::TMemoryRecordEh* MemRecord, Memtabledataeh::TDataValueVersionEh DataValueVersion, Db::TParam* Param);

typedef void __fastcall (__closure *TSQLDataDriverGetBackUpdatedValuesEhEvent)(TBaseSQLDataDriverEh* DataDriver, Memtabledataeh::TMemoryRecordEh* MemRec, TBaseSQLCommandEh* Command, Db::TDataSet* ResDataSet);

class PASCALIMPLEMENTATION TBaseSQLDataDriverEh : public TCustomSQLDataDriverEh 
{
	typedef TCustomSQLDataDriverEh inherited;
	
private:
	TSQLDataDriverAssignParamEhEvent FOnAssignCommandParam;
	TSQLDataDriverExecuteCommandEhEvent FOnExecuteCommand;
	TSQLDataDriverGetBackUpdatedValuesEhEvent FOnGetBackUpdatedValues;
	TBaseSQLCommandEh* __fastcall GetDeleteCommand(void);
	TBaseSQLCommandEh* __fastcall GetInsertCommand(void);
	TBaseSQLCommandEh* __fastcall GetSelectCommand(void);
	TBaseSQLCommandEh* __fastcall GetGetrecCommand(void);
	TBaseSQLCommandEh* __fastcall GetUpdateCommand(void);
	HIDESBASE void __fastcall SetDeleteCommand(const TBaseSQLCommandEh* Value);
	HIDESBASE void __fastcall SetInsertCommand(const TBaseSQLCommandEh* Value);
	HIDESBASE void __fastcall SetSelectCommand(const TBaseSQLCommandEh* Value);
	HIDESBASE void __fastcall SetGetrecCommand(const TBaseSQLCommandEh* Value);
	HIDESBASE void __fastcall SetUpdateCommand(const TBaseSQLCommandEh* Value);
	
protected:
	virtual TCustomSQLCommandEh* __fastcall CreateCommand(void);
	virtual void __fastcall AssignCommandParam(TBaseSQLCommandEh* Command, Memtabledataeh::TMemoryRecordEh* MemRecord, Memtabledataeh::TDataValueVersionEh DataValueVersion, Db::TParam* Param);
	
public:
	virtual int __fastcall ExecuteCommand(TCustomSQLCommandEh* Command, Db::TDataSet* &Cursor, bool &FreeOnEof);
	virtual void __fastcall DefaultGetUpdatedServerValues(Memtabledataeh::TMemoryRecordEh* MemRec, TCustomSQLCommandEh* Command, Db::TDataSet* ResDataSet);
	virtual void __fastcall DefaultAssignCommandParam(TBaseSQLCommandEh* Command, Memtabledataeh::TMemoryRecordEh* MemRecord, Memtabledataeh::TDataValueVersionEh DataValueVersion, Db::TParam* Param);
	virtual void __fastcall GetBackUpdatedValues(Memtabledataeh::TMemoryRecordEh* MemRec, TCustomSQLCommandEh* Command, Db::TDataSet* ResDataSet);
	__property DynaSQLParams ;
	__property TBaseSQLCommandEh* DeleteCommand = {read=GetDeleteCommand, write=SetDeleteCommand};
	__property TBaseSQLCommandEh* GetrecCommand = {read=GetGetrecCommand, write=SetGetrecCommand};
	__property TBaseSQLCommandEh* InsertCommand = {read=GetInsertCommand, write=SetInsertCommand};
	__property TBaseSQLCommandEh* SelectCommand = {read=GetSelectCommand, write=SetSelectCommand};
	__property TBaseSQLCommandEh* UpdateCommand = {read=GetUpdateCommand, write=SetUpdateCommand};
	__property SpecParams ;
	__property TSQLDataDriverAssignParamEhEvent OnAssignCommandParam = {read=FOnAssignCommandParam, write=FOnAssignCommandParam};
	__property TSQLDataDriverExecuteCommandEhEvent OnExecuteCommand = {read=FOnExecuteCommand, write=FOnExecuteCommand};
	__property TSQLDataDriverGetBackUpdatedValuesEhEvent OnGetBackUpdatedValues = {read=FOnGetBackUpdatedValues, write=FOnGetBackUpdatedValues};
public:
	#pragma option push -w-inl
	/* TCustomSQLDataDriverEh.Create */ inline __fastcall virtual TBaseSQLDataDriverEh(Classes::TComponent* AOwner) : TCustomSQLDataDriverEh(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomSQLDataDriverEh.Destroy */ inline __fastcall virtual ~TBaseSQLDataDriverEh(void) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TBaseSQLCommandEh : public TCustomSQLCommandEh 
{
	typedef TCustomSQLCommandEh inherited;
	
private:
	bool FParamCheck;
	Db::TParams* FParams;
	TAssignParamEhEvent FOnAssignParam;
	bool __fastcall GetParamCheck(void);
	TBaseSQLDataDriverEh* __fastcall GetDataDriver(void);
	
protected:
	virtual void __fastcall CommandTextChanged(System::TObject* Sender);
	virtual void __fastcall SetParamCheck(const bool Value);
	
public:
	__fastcall TBaseSQLCommandEh(TBaseSQLDataDriverEh* ADataDriver);
	__fastcall virtual ~TBaseSQLCommandEh(void);
	virtual Db::TParams* __fastcall GetParams(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual void __fastcall SetParams(Db::TParams* AParams);
	virtual void __fastcall DefaultRefreshParam(Memtabledataeh::TMemoryRecordEh* MemRecord, Memtabledataeh::TDataValueVersionEh DataValueVersion, Db::TParam* Param);
	virtual void __fastcall RefreshParams(Memtabledataeh::TMemoryRecordEh* MemRecord, Memtabledataeh::TDataValueVersionEh DataValueVersion);
	__property TBaseSQLDataDriverEh* DataDriver = {read=GetDataDriver};
	__property TAssignParamEhEvent OnAssignParam = {read=FOnAssignParam, write=FOnAssignParam};
	__property Db::TParams* Params = {read=GetParams, write=SetParams};
	__property bool ParamCheck = {read=GetParamCheck, write=SetParamCheck, default=1};
};


class DELPHICLASS TSQLCommandEh;
class PASCALIMPLEMENTATION TSQLCommandEh : public TBaseSQLCommandEh 
{
	typedef TBaseSQLCommandEh inherited;
	
__published:
	__property Params ;
	__property ParamCheck  = {default=1};
	__property CommandText ;
	__property CommandType ;
public:
	#pragma option push -w-inl
	/* TBaseSQLCommandEh.Create */ inline __fastcall TSQLCommandEh(TBaseSQLDataDriverEh* ADataDriver) : TBaseSQLCommandEh(ADataDriver) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TBaseSQLCommandEh.Destroy */ inline __fastcall virtual ~TSQLCommandEh(void) { }
	#pragma option pop
	
};


class DELPHICLASS TSQLDataDriverEh;
class PASCALIMPLEMENTATION TSQLDataDriverEh : public TBaseSQLDataDriverEh 
{
	typedef TBaseSQLDataDriverEh inherited;
	
protected:
	virtual TCustomSQLCommandEh* __fastcall CreateSelectCommand(void);
	virtual TCustomSQLCommandEh* __fastcall CreateUpdateCommand(void);
	virtual TCustomSQLCommandEh* __fastcall CreateInsertCommand(void);
	virtual TCustomSQLCommandEh* __fastcall CreateDeleteCommand(void);
	virtual TCustomSQLCommandEh* __fastcall CreateGetrecCommand(void);
	
__published:
	__property DeleteCommand ;
	__property DeleteSQL ;
	__property DynaSQLParams ;
	__property GetrecCommand ;
	__property GetrecSQL ;
	__property InsertCommand ;
	__property InsertSQL ;
	__property SelectCommand ;
	__property SelectSQL ;
	__property UpdateCommand ;
	__property UpdateSQL ;
	__property KeyFields ;
	__property ProviderDataSet ;
	__property SpecParams ;
	__property OnAssignCommandParam ;
	__property OnAssignFieldValue ;
	__property OnBuildDataStruct ;
	__property OnExecuteCommand ;
	__property OnGetBackUpdatedValues ;
	__property OnProduceDataReader ;
	__property OnReadRecord ;
	__property OnRefreshRecord ;
	__property OnUpdateError ;
	__property OnUpdateRecord ;
public:
	#pragma option push -w-inl
	/* TCustomSQLDataDriverEh.Create */ inline __fastcall virtual TSQLDataDriverEh(Classes::TComponent* AOwner) : TBaseSQLDataDriverEh(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomSQLDataDriverEh.Destroy */ inline __fastcall virtual ~TSQLDataDriverEh(void) { }
	#pragma option pop
	
};


typedef TMetaClass* TSQLDataDriverEhClass;

__interface IDesignDataBaseEh;
typedef System::DelphiInterface<IDesignDataBaseEh> _di_IDesignDataBaseEh;
__interface  INTERFACE_UUID("{01F477A4-8417-4DC9-B93A-1F95D2FF2EB8}") IDesignDataBaseEh  : public IInterface 
{
	
public:
	virtual TCustomSQLDataDriverEh* __fastcall CreateDesignCopy(TCustomSQLDataDriverEh* RTDataDriver) = 0 ;
	virtual int __fastcall Execute(TCustomSQLCommandEh* Command, Db::TDataSet* &Cursor, bool &FreeOnEof) = 0 ;
	virtual bool __fastcall BuildUpdates(TCustomSQLDataDriverEh* DataDriver) = 0 ;
	virtual bool __fastcall BuildObjectTree(Classes::TList* List) = 0 ;
	virtual bool __fastcall GetFieldList(const AnsiString TableName, Db::TDataSet* DataSet) = 0 ;
	virtual void __fastcall EditDatabaseParams(void) = 0 ;
	virtual bool __fastcall GetConnected(void) = 0 ;
	virtual void __fastcall SetConnected(const bool Value) = 0 ;
};

class DELPHICLASS TOracleSpecOperationsEh;
class PASCALIMPLEMENTATION TOracleSpecOperationsEh : public TServerSpecOperationsEh 
{
	typedef TServerSpecOperationsEh inherited;
	
public:
	virtual int __fastcall UpdateRecord(TCustomSQLDataDriverEh* SQLDataDriver, Memtabledataeh::TMemTableDataEh* MemTableData, Memtabledataeh::TMemoryRecordEh* MemRec);
	virtual void __fastcall GetBackUpdatedValues(Memtabledataeh::TMemoryRecordEh* MemRec, TCustomSQLCommandEh* Command, Db::TDataSet* ResDataSet);
public:
	#pragma option push -w-inl
	/* TServerSpecOperationsEh.Create */ inline __fastcall virtual TOracleSpecOperationsEh(void) : TServerSpecOperationsEh() { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TOracleSpecOperationsEh(void) { }
	#pragma option pop
	
};


class DELPHICLASS TMSSQLSpecOperationsEh;
class PASCALIMPLEMENTATION TMSSQLSpecOperationsEh : public TServerSpecOperationsEh 
{
	typedef TServerSpecOperationsEh inherited;
	
public:
	virtual void __fastcall GetBackUpdatedValues(Memtabledataeh::TMemoryRecordEh* MemRec, TCustomSQLCommandEh* Command, Db::TDataSet* ResDataSet);
	__fastcall virtual TMSSQLSpecOperationsEh(void);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TMSSQLSpecOperationsEh(void) { }
	#pragma option pop
	
};


class DELPHICLASS TInterbaseSpecOperationsEh;
class PASCALIMPLEMENTATION TInterbaseSpecOperationsEh : public TServerSpecOperationsEh 
{
	typedef TServerSpecOperationsEh inherited;
	
public:
	virtual int __fastcall UpdateRecord(TCustomSQLDataDriverEh* SQLDataDriver, Memtabledataeh::TMemTableDataEh* MemTableData, Memtabledataeh::TMemoryRecordEh* MemRec);
	virtual void __fastcall GetBackUpdatedValues(Memtabledataeh::TMemoryRecordEh* MemRec, TCustomSQLCommandEh* Command, Db::TDataSet* ResDataSet);
public:
	#pragma option push -w-inl
	/* TServerSpecOperationsEh.Create */ inline __fastcall virtual TInterbaseSpecOperationsEh(void) : TServerSpecOperationsEh() { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TInterbaseSpecOperationsEh(void) { }
	#pragma option pop
	
};


class DELPHICLASS TInfromixSpecOperationsEh;
class PASCALIMPLEMENTATION TInfromixSpecOperationsEh : public TServerSpecOperationsEh 
{
	typedef TServerSpecOperationsEh inherited;
	
public:
	virtual void __fastcall GetBackUpdatedValues(Memtabledataeh::TMemoryRecordEh* MemRec, TCustomSQLCommandEh* Command, Db::TDataSet* ResDataSet);
	__fastcall virtual TInfromixSpecOperationsEh(void);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TInfromixSpecOperationsEh(void) { }
	#pragma option pop
	
};


class DELPHICLASS TDB2SpecOperationsEh;
class PASCALIMPLEMENTATION TDB2SpecOperationsEh : public TServerSpecOperationsEh 
{
	typedef TServerSpecOperationsEh inherited;
	
public:
	virtual void __fastcall GetBackUpdatedValues(Memtabledataeh::TMemoryRecordEh* MemRec, TCustomSQLCommandEh* Command, Db::TDataSet* ResDataSet);
public:
	#pragma option push -w-inl
	/* TServerSpecOperationsEh.Create */ inline __fastcall virtual TDB2SpecOperationsEh(void) : TServerSpecOperationsEh() { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TDB2SpecOperationsEh(void) { }
	#pragma option pop
	
};


class DELPHICLASS TSybaseSpecOperationsEh;
class PASCALIMPLEMENTATION TSybaseSpecOperationsEh : public TServerSpecOperationsEh 
{
	typedef TServerSpecOperationsEh inherited;
	
public:
	virtual void __fastcall GetBackUpdatedValues(Memtabledataeh::TMemoryRecordEh* MemRec, TCustomSQLCommandEh* Command, Db::TDataSet* ResDataSet);
public:
	#pragma option push -w-inl
	/* TServerSpecOperationsEh.Create */ inline __fastcall virtual TSybaseSpecOperationsEh(void) : TServerSpecOperationsEh() { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TSybaseSpecOperationsEh(void) { }
	#pragma option pop
	
};


class DELPHICLASS TMSAccessSpecOperationsEh;
class PASCALIMPLEMENTATION TMSAccessSpecOperationsEh : public TServerSpecOperationsEh 
{
	typedef TServerSpecOperationsEh inherited;
	
public:
	virtual void __fastcall GetBackUpdatedValues(Memtabledataeh::TMemoryRecordEh* MemRec, TCustomSQLCommandEh* Command, Db::TDataSet* ResDataSet);
	__fastcall virtual TMSAccessSpecOperationsEh(void);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TMSAccessSpecOperationsEh(void) { }
	#pragma option pop
	
};


typedef void __fastcall (*TSetDesignDataBaseProcEh)(TCustomSQLDataDriverEh* DataDriver);

//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TSQLDataDriverResolver* __fastcall DefaultSQLDataDriverResolver(void);
extern PACKAGE TSQLDataDriverResolver* __fastcall RegisterDefaultSQLDataDriverResolver(TSQLDataDriverResolver* ASQLDataDriverResolver);
extern PACKAGE void __fastcall VarParamsToParams(const Variant &VarParams, Db::TParams* Params);
extern PACKAGE void __fastcall RegisterDesignDataBuilderProcEh(TMetaClass* DataDriverClass, TSetDesignDataBaseProcEh DesignDataBaseProc);
extern PACKAGE void __fastcall UnregisterDesignDataBuilderProcEh(TMetaClass* DataDriverClass);
extern PACKAGE TSetDesignDataBaseProcEh __fastcall GetDesignDataBuilderProcEh(TMetaClass* DataDriverClass);

}	/* namespace Datadrivereh */
using namespace Datadrivereh;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Datadrivereh
