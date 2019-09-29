// CodeGear C++ Builder
// Copyright (c) 1995, 2007 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Ibxdatadrivereh.pas' rev: 11.00

#ifndef IbxdatadriverehHPP
#define IbxdatadriverehHPP

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
#include <Ibcustomdataset.hpp>	// Pascal unit
#include <Ibdatabase.hpp>	// Pascal unit
#include <Ibquery.hpp>	// Pascal unit
#include <Ibtable.hpp>	// Pascal unit
#include <Ibstoredproc.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Ibxdatadrivereh
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TIBXCommandEh;
class DELPHICLASS TIBXDataDriverEh;
class PASCALIMPLEMENTATION TIBXCommandEh : public Datadrivereh::TBaseSQLCommandEh 
{
	typedef Datadrivereh::TBaseSQLCommandEh inherited;
	
private:
	HIDESBASE TIBXDataDriverEh* __fastcall GetDataDriver(void);
	
public:
	virtual int __fastcall Execute(Db::TDataSet* &Cursor, bool &FreeOnEof);
	__property TIBXDataDriverEh* DataDriver = {read=GetDataDriver};
	
__published:
	__property Params ;
	__property ParamCheck  = {default=1};
	__property CommandText ;
	__property CommandType ;
public:
	#pragma option push -w-inl
	/* TBaseSQLCommandEh.Create */ inline __fastcall TIBXCommandEh(Datadrivereh::TBaseSQLDataDriverEh* ADataDriver) : Datadrivereh::TBaseSQLCommandEh(ADataDriver) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TBaseSQLCommandEh.Destroy */ inline __fastcall virtual ~TIBXCommandEh(void) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TIBXDataDriverEh : public Datadrivereh::TBaseSQLDataDriverEh 
{
	typedef Datadrivereh::TBaseSQLDataDriverEh inherited;
	
private:
	Ibdatabase::TIBDatabase* FDatabase;
	Datadrivereh::TInterbaseSpecOperationsEh* FIbsSpecOperations;
	void __fastcall SetDatabase(const Ibdatabase::TIBDatabase* Value);
	
protected:
	virtual Datadrivereh::TCustomSQLCommandEh* __fastcall CreateCommand(void);
	virtual Datadrivereh::TServerSpecOperationsEh* __fastcall InternalGetServerSpecOperations(void);
	virtual void __fastcall SetAutoIncFields(Db::TFields* Fields, Memtabledataeh::TMTDataStructEh* DataStruct);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
public:
	__fastcall virtual TIBXDataDriverEh(Classes::TComponent* AOwner);
	__fastcall virtual ~TIBXDataDriverEh(void);
	virtual Datadrivereh::TCustomSQLDataDriverEh* __fastcall CreateDesignCopy(void);
	virtual bool __fastcall HaveDataConnection(void);
	virtual void __fastcall GetBackUpdatedValues(Memtabledataeh::TMemoryRecordEh* MemRec, Datadrivereh::TCustomSQLCommandEh* Command, Db::TDataSet* ResDataSet);
	virtual void __fastcall DoServerSpecOperations(Memtabledataeh::TMemoryRecordEh* MemRec, Datadrivereh::TCustomSQLCommandEh* Command, Db::TDataSet* ResDataSet);
	
__published:
	__property Ibdatabase::TIBDatabase* Database = {read=FDatabase, write=SetDatabase};
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
extern PACKAGE int __fastcall DefaultExecuteIBXCommandEh(Datadrivereh::TCustomSQLDataDriverEh* SQLDataDriver, Datadrivereh::TCustomSQLCommandEh* Command, Db::TDataSet* &Cursor, bool &FreeOnEof, bool &Processed, Ibdatabase::TIBDatabase* ADatabase);
extern PACKAGE void __fastcall DefaultUpdateIBXRecordEh(Datadrivereh::TCustomSQLDataDriverEh* SQLDataDriver, Memtabledataeh::TMemTableDataEh* MemTableData, Memtabledataeh::TMemoryRecordEh* MemRec, bool &Processed, Ibdatabase::TIBDatabase* ADatabase);

}	/* namespace Ibxdatadrivereh */
using namespace Ibxdatadrivereh;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Ibxdatadrivereh
