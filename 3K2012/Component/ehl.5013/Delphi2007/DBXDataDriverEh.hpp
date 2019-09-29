// CodeGear C++ Builder
// Copyright (c) 1995, 2007 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Dbxdatadrivereh.pas' rev: 11.00

#ifndef DbxdatadriverehHPP
#define DbxdatadriverehHPP

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
#include <Sqlexpr.hpp>	// Pascal unit
#include <Contnrs.hpp>	// Pascal unit
#include <Toolctrlseh.hpp>	// Pascal unit
#include <Dbcommon.hpp>	// Pascal unit
#include <Memtabledataeh.hpp>	// Pascal unit
#include <Datadrivereh.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Dbxdatadrivereh
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TDBXCommandEh;
class DELPHICLASS TDBXDataDriverEh;
class PASCALIMPLEMENTATION TDBXCommandEh : public Datadrivereh::TBaseSQLCommandEh 
{
	typedef Datadrivereh::TBaseSQLCommandEh inherited;
	
private:
	HIDESBASE TDBXDataDriverEh* __fastcall GetDataDriver(void);
	
public:
	virtual int __fastcall Execute(Db::TDataSet* &Cursor, bool &FreeOnEof);
	__property TDBXDataDriverEh* DataDriver = {read=GetDataDriver};
	
__published:
	__property Params ;
	__property ParamCheck  = {default=1};
	__property CommandText ;
	__property CommandType ;
public:
	#pragma option push -w-inl
	/* TBaseSQLCommandEh.Create */ inline __fastcall TDBXCommandEh(Datadrivereh::TBaseSQLDataDriverEh* ADataDriver) : Datadrivereh::TBaseSQLCommandEh(ADataDriver) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TBaseSQLCommandEh.Destroy */ inline __fastcall virtual ~TDBXCommandEh(void) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TDBXDataDriverEh : public Datadrivereh::TBaseSQLDataDriverEh 
{
	typedef Datadrivereh::TBaseSQLDataDriverEh inherited;
	
private:
	Datadrivereh::TServerSpecOperationsEh* FServerSpecOperations;
	Sqlexpr::TSQLConnection* FSQLConnection;
	void __fastcall SetConnection(const Sqlexpr::TSQLConnection* Value);
	
protected:
	virtual Datadrivereh::TCustomSQLCommandEh* __fastcall CreateCommand(void);
	virtual Datadrivereh::TServerSpecOperationsEh* __fastcall InternalGetServerSpecOperations(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall SetAutoIncFields(Db::TFields* Fields, Memtabledataeh::TMTDataStructEh* DataStruct);
	
public:
	__fastcall virtual TDBXDataDriverEh(Classes::TComponent* AOwner);
	__fastcall virtual ~TDBXDataDriverEh(void);
	virtual Datadrivereh::TCustomSQLDataDriverEh* __fastcall CreateDesignCopy(void);
	virtual bool __fastcall HaveDataConnection(void);
	virtual void __fastcall GetBackUpdatedValues(Memtabledataeh::TMemoryRecordEh* MemRec, Datadrivereh::TCustomSQLCommandEh* Command, Db::TDataSet* ResDataSet);
	virtual void __fastcall DoServerSpecOperations(Memtabledataeh::TMemoryRecordEh* MemRec, Datadrivereh::TCustomSQLCommandEh* Command, Db::TDataSet* ResDataSet);
	
__published:
	__property Sqlexpr::TSQLConnection* SQLConnection = {read=FSQLConnection, write=SetConnection};
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
extern PACKAGE int __fastcall DefaultExecuteDBXCommandEh(Datadrivereh::TCustomSQLDataDriverEh* SQLDataDriver, Datadrivereh::TCustomSQLCommandEh* Command, Db::TDataSet* &Cursor, bool &FreeOnEof, bool &Processed, Sqlexpr::TSQLConnection* ASQLConnection);

}	/* namespace Dbxdatadrivereh */
using namespace Dbxdatadrivereh;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Dbxdatadrivereh
