// CodeGear C++ Builder
// Copyright (c) 1995, 2007 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Bdedatadrivereh.pas' rev: 11.00

#ifndef BdedatadriverehHPP
#define BdedatadriverehHPP

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
#include <Variants.hpp>	// Pascal unit
#include <Contnrs.hpp>	// Pascal unit
#include <Toolctrlseh.hpp>	// Pascal unit
#include <Dbcommon.hpp>	// Pascal unit
#include <Memtabledataeh.hpp>	// Pascal unit
#include <Datadrivereh.hpp>	// Pascal unit
#include <Dbtables.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Bdedatadrivereh
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TBDECommandEh;
class DELPHICLASS TBDEDataDriverEh;
class PASCALIMPLEMENTATION TBDECommandEh : public Datadrivereh::TBaseSQLCommandEh 
{
	typedef Datadrivereh::TBaseSQLCommandEh inherited;
	
private:
	HIDESBASE TBDEDataDriverEh* __fastcall GetDataDriver(void);
	
public:
	virtual int __fastcall Execute(Db::TDataSet* &Cursor, bool &FreeOnEof);
	__property TBDEDataDriverEh* DataDriver = {read=GetDataDriver};
	
__published:
	__property Params ;
	__property ParamCheck  = {default=1};
	__property CommandText ;
	__property CommandType ;
public:
	#pragma option push -w-inl
	/* TBaseSQLCommandEh.Create */ inline __fastcall TBDECommandEh(Datadrivereh::TBaseSQLDataDriverEh* ADataDriver) : Datadrivereh::TBaseSQLCommandEh(ADataDriver) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TBaseSQLCommandEh.Destroy */ inline __fastcall virtual ~TBDECommandEh(void) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TBDEDataDriverEh : public Datadrivereh::TBaseSQLDataDriverEh 
{
	typedef Datadrivereh::TBaseSQLDataDriverEh inherited;
	
private:
	AnsiString FDatabaseName;
	AnsiString FSessionName;
	Datadrivereh::TServerSpecOperationsEh* FServerSpecOperations;
	Dbtables::TSession* __fastcall GetDBSession(void);
	void __fastcall SetDatabaseName(const AnsiString Value);
	void __fastcall SetSessionName(const AnsiString Value);
	
protected:
	virtual Datadrivereh::TCustomSQLCommandEh* __fastcall CreateCommand(void);
	virtual void __fastcall SetAutoIncFields(Db::TFields* Fields, Memtabledataeh::TMTDataStructEh* DataStruct);
	virtual Datadrivereh::TServerSpecOperationsEh* __fastcall InternalGetServerSpecOperations(void);
	
public:
	__fastcall virtual TBDEDataDriverEh(Classes::TComponent* AOwner);
	__fastcall virtual ~TBDEDataDriverEh(void);
	virtual Datadrivereh::TCustomSQLDataDriverEh* __fastcall CreateDesignCopy(void);
	virtual bool __fastcall HaveDataConnection(void);
	virtual void __fastcall DefaultGetUpdatedServerValues(Memtabledataeh::TMemoryRecordEh* MemRec, Datadrivereh::TCustomSQLCommandEh* Command, Db::TDataSet* ResDataSet);
	virtual void __fastcall DoServerSpecOperations(Memtabledataeh::TMemoryRecordEh* MemRec, Datadrivereh::TCustomSQLCommandEh* Command, Db::TDataSet* ResDataSet);
	__property Dbtables::TSession* DBSession = {read=GetDBSession};
	__property AnsiString SessionName = {read=FSessionName, write=SetSessionName};
	
__published:
	__property AnsiString DatabaseName = {read=FDatabaseName, write=SetDatabaseName};
	__property SelectCommand ;
	__property SelectSQL ;
	__property UpdateCommand ;
	__property UpdateSQL ;
	__property InsertCommand ;
	__property InsertSQL ;
	__property DeleteCommand ;
	__property DeleteSQL ;
	__property GetrecCommand ;
	__property GetrecSQL ;
	__property DynaSQLParams ;
	__property ProviderDataSet ;
	__property KeyFields ;
	__property SpecParams ;
	__property OnExecuteCommand ;
	__property OnBuildDataStruct ;
	__property OnGetBackUpdatedValues ;
	__property OnProduceDataReader ;
	__property OnAssignFieldValue ;
	__property OnReadRecord ;
	__property OnRefreshRecord ;
	__property OnUpdateRecord ;
	__property OnAssignCommandParam ;
	__property OnUpdateError ;
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE int __fastcall DefaultExecuteBDECommandEh(Datadrivereh::TCustomSQLDataDriverEh* SQLDataDriver, Datadrivereh::TCustomSQLCommandEh* Command, Db::TDataSet* &Cursor, bool &FreeOnEof, bool &Processed, AnsiString ADatabaseName);

}	/* namespace Bdedatadrivereh */
using namespace Bdedatadrivereh;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Bdedatadrivereh
