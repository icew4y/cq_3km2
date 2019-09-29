// CodeGear C++ Builder
// Copyright (c) 1995, 2007 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Adodatadrivereh.pas' rev: 11.00

#ifndef AdodatadriverehHPP
#define AdodatadriverehHPP

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
#include <Memtabledataeh.hpp>	// Pascal unit
#include <Datadrivereh.hpp>	// Pascal unit
#include <Adodb.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Adodatadrivereh
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TADODataDriverEh;
class DELPHICLASS TADOCommandEh;
typedef void __fastcall (__closure *TAssignParameterEhEvent)(TADODataDriverEh* DataDriver, TADOCommandEh* Command, Memtabledataeh::TMemoryRecordEh* MemRecord, Memtabledataeh::TDataValueVersionEh DataValueVersion, Adodb::TParameter* Parameter);

typedef int __fastcall (__closure *TADODataDriverExecuteCommandEhEvent)(TADODataDriverEh* DataDriver, TADOCommandEh* Command, Db::TDataSet* &Cursor, bool &FreeOnEof);

typedef void __fastcall (__closure *TADODataDriverGetBackUpdatedValuesEhEvent)(TADODataDriverEh* DataDriver, Memtabledataeh::TMemoryRecordEh* MemRec, TADOCommandEh* Command, Db::TDataSet* ResDataSet);

class DELPHICLASS TADODBCommandEh;
class PASCALIMPLEMENTATION TADODBCommandEh : public Adodb::TADOCommand 
{
	typedef Adodb::TADOCommand inherited;
	
protected:
	__property ComponentRef ;
public:
	#pragma option push -w-inl
	/* TADOCommand.Create */ inline __fastcall virtual TADODBCommandEh(Classes::TComponent* AOwner) : Adodb::TADOCommand(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TADOCommand.Destroy */ inline __fastcall virtual ~TADODBCommandEh(void) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TADOCommandEh : public Datadrivereh::TCustomSQLCommandEh 
{
	typedef Datadrivereh::TCustomSQLCommandEh inherited;
	
private:
	TAssignParameterEhEvent FOnAssignParameter;
	TADODBCommandEh* FCommand;
	Db::TParams* FParams;
	bool __fastcall GetParamCheck(void);
	Adodb::TParameters* __fastcall GetParameters(void);
	TADODataDriverEh* __fastcall GetDataDriver(void);
	
protected:
	virtual void __fastcall CommandTextChanged(System::TObject* Sender);
	virtual void __fastcall SetParamCheck(const bool Value);
	virtual void __fastcall SetParameters(const Adodb::TParameters* Value);
	
public:
	__fastcall TADOCommandEh(TADODataDriverEh* ADataDriver);
	__fastcall virtual ~TADOCommandEh(void);
	virtual int __fastcall Execute(Db::TDataSet* &Cursor, bool &FreeOnEof);
	virtual Db::TParams* __fastcall GetParams(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual void __fastcall DefaultRefreshParameter(Memtabledataeh::TMemoryRecordEh* MemRecord, Memtabledataeh::TDataValueVersionEh DataValueVersion, Adodb::TParameter* Parameter);
	virtual void __fastcall RefreshParams(Memtabledataeh::TMemoryRecordEh* MemRecord, Memtabledataeh::TDataValueVersionEh DataValueVersion);
	virtual void __fastcall SetParams(Db::TParams* AParams);
	__property TADODataDriverEh* DataDriver = {read=GetDataDriver};
	__property TAssignParameterEhEvent OnAssignParameter = {read=FOnAssignParameter, write=FOnAssignParameter};
	
__published:
	__property CommandText ;
	__property CommandType ;
	__property Adodb::TParameters* Parameters = {read=GetParameters, write=SetParameters};
	__property bool ParamCheck = {read=GetParamCheck, write=SetParamCheck, default=1};
};


class PASCALIMPLEMENTATION TADODataDriverEh : public Datadrivereh::TCustomSQLDataDriverEh 
{
	typedef Datadrivereh::TCustomSQLDataDriverEh inherited;
	
private:
	Adodb::TADOConnection* FADOConnection;
	WideString FConnectionString;
	TAssignParameterEhEvent FOnAssignCommandParameter;
	TADODataDriverExecuteCommandEhEvent FOnExecuteCommand;
	TADODataDriverGetBackUpdatedValuesEhEvent FOnGetBackUpdatedValues;
	TADOCommandEh* __fastcall GetDeleteCommand(void);
	TADOCommandEh* __fastcall GetGetrecCommand(void);
	TADOCommandEh* __fastcall GetInsertCommand(void);
	TADOCommandEh* __fastcall GetSelectCommand(void);
	TADOCommandEh* __fastcall GetUpdateCommand(void);
	void __fastcall SetConnection(const Adodb::TADOConnection* Value);
	void __fastcall SetConnectionString(const WideString Value);
	HIDESBASE void __fastcall SetDeleteCommand(const TADOCommandEh* Value);
	HIDESBASE void __fastcall SetGetrecCommand(const TADOCommandEh* Value);
	HIDESBASE void __fastcall SetInsertCommand(const TADOCommandEh* Value);
	HIDESBASE void __fastcall SetSelectCommand(const TADOCommandEh* Value);
	HIDESBASE void __fastcall SetUpdateCommand(const TADOCommandEh* Value);
	
protected:
	virtual Datadrivereh::TCustomSQLCommandEh* __fastcall CreateCommand(void);
	virtual void __fastcall AssignCommandParameter(TADOCommandEh* Command, Memtabledataeh::TMemoryRecordEh* MemRecord, Memtabledataeh::TDataValueVersionEh DataValueVersion, Adodb::TParameter* Parameter);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall SetAutoIncFields(Db::TFields* Fields, Memtabledataeh::TMTDataStructEh* DataStruct);
	
public:
	__fastcall virtual TADODataDriverEh(Classes::TComponent* AOwner);
	__fastcall virtual ~TADODataDriverEh(void);
	virtual Datadrivereh::TCustomSQLDataDriverEh* __fastcall CreateDesignCopy(void);
	virtual int __fastcall ExecuteCommand(Datadrivereh::TCustomSQLCommandEh* Command, Db::TDataSet* &Cursor, bool &FreeOnEof);
	virtual bool __fastcall HaveDataConnection(void);
	virtual void __fastcall DefaultAssignCommandParameter(TADOCommandEh* Command, Memtabledataeh::TMemoryRecordEh* MemRecord, Memtabledataeh::TDataValueVersionEh DataValueVersion, Adodb::TParameter* Parameter);
	virtual void __fastcall GetBackUpdatedValues(Memtabledataeh::TMemoryRecordEh* MemRec, Datadrivereh::TCustomSQLCommandEh* Command, Db::TDataSet* ResDataSet);
	
__published:
	__property Adodb::TADOConnection* ADOConnection = {read=FADOConnection, write=SetConnection};
	__property WideString ConnectionString = {read=FConnectionString, write=SetConnectionString};
	__property TADOCommandEh* SelectCommand = {read=GetSelectCommand, write=SetSelectCommand};
	__property SelectSQL ;
	__property TADOCommandEh* UpdateCommand = {read=GetUpdateCommand, write=SetUpdateCommand};
	__property UpdateSQL ;
	__property TADOCommandEh* InsertCommand = {read=GetInsertCommand, write=SetInsertCommand};
	__property InsertSQL ;
	__property TADOCommandEh* DeleteCommand = {read=GetDeleteCommand, write=SetDeleteCommand};
	__property DeleteSQL ;
	__property TADOCommandEh* GetrecCommand = {read=GetGetrecCommand, write=SetGetrecCommand};
	__property GetrecSQL ;
	__property DynaSQLParams ;
	__property ProviderDataSet ;
	__property KeyFields ;
	__property SpecParams ;
	__property TAssignParameterEhEvent OnAssignCommandParameter = {read=FOnAssignCommandParameter, write=FOnAssignCommandParameter};
	__property OnAssignFieldValue ;
	__property OnBuildDataStruct ;
	__property TADODataDriverExecuteCommandEhEvent OnExecuteCommand = {read=FOnExecuteCommand, write=FOnExecuteCommand};
	__property TADODataDriverGetBackUpdatedValuesEhEvent OnGetBackUpdatedValues = {read=FOnGetBackUpdatedValues, write=FOnGetBackUpdatedValues};
	__property OnProduceDataReader ;
	__property OnReadRecord ;
	__property OnRefreshRecord ;
	__property OnUpdateError ;
	__property OnUpdateRecord ;
};


typedef Datadrivereh::TServerSpecOperationsEh* __fastcall (*TGetADODataDriverServerSpecOperations)(TADODataDriverEh* DataDriver);

//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TGetADODataDriverServerSpecOperations __fastcall RegisterGetADODataDriverServerSpecOperationsPrg(TGetADODataDriverServerSpecOperations Prg);
extern PACKAGE int __fastcall DefaultExecuteADOCommandEh(Datadrivereh::TCustomSQLDataDriverEh* SQLDataDriver, Datadrivereh::TCustomSQLCommandEh* Command, Db::TDataSet* &Cursor, bool &FreeOnEof, Adodb::TADOConnection* ADOConnection, WideString ADOConnectionString);

}	/* namespace Adodatadrivereh */
using namespace Adodatadrivereh;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Adodatadrivereh
