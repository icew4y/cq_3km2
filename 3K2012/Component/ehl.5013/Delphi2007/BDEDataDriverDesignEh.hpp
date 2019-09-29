// CodeGear C++ Builder
// Copyright (c) 1995, 2007 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Bdedatadriverdesigneh.pas' rev: 11.00

#ifndef BdedatadriverdesignehHPP
#define BdedatadriverdesignehHPP

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
#include <Ehlibvcl.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Contnrs.hpp>	// Pascal unit
#include <Toolctrlseh.hpp>	// Pascal unit
#include <Dbcommon.hpp>	// Pascal unit
#include <Memtabledataeh.hpp>	// Pascal unit
#include <Datadrivereh.hpp>	// Pascal unit
#include <Dbtables.hpp>	// Pascal unit
#include <Sqldriverediteh.hpp>	// Pascal unit
#include <Bdedatadrivereh.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Memtableeh.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Bdedatadriverdesigneh
{
//-- type declarations -------------------------------------------------------
__interface IBDEDesignDataBaseEh;
typedef System::DelphiInterface<IBDEDesignDataBaseEh> _di_IBDEDesignDataBaseEh;
__interface  INTERFACE_UUID("{9E53BD33-4E5E-414F-9E4A-4980A8F7637A}") IBDEDesignDataBaseEh  : public IInterface 
{
	
public:
	virtual Dbtables::TDatabase* __fastcall GetDataBase(void) = 0 ;
};

class DELPHICLASS TBDEDesignDataBaseEh;
class PASCALIMPLEMENTATION TBDEDesignDataBaseEh : public Sqldriverediteh::TDesignDataBaseEh 
{
	typedef Sqldriverediteh::TDesignDataBaseEh inherited;
	
private:
	Dbtables::TDatabase* FDBEDataBase;
	Sqldriverediteh::TCustomDBService* FTreeNodeMan;
	AnsiString FRuntimeDataBaseName;
	Sqldriverediteh::TCustomDBService* FDBService;
	Classes::TStringList* FUpdateObjectsList;
	
protected:
	virtual bool __fastcall GetConnected(void);
	virtual void __fastcall SetConnected(const bool Value);
	void __fastcall DataBaseDisconnected(System::TObject* Sender);
	
public:
	__fastcall TBDEDesignDataBaseEh(void);
	__fastcall virtual ~TBDEDesignDataBaseEh(void);
	virtual AnsiString __fastcall GetEngineName();
	virtual AnsiString __fastcall GetServerTypeName();
	virtual Datadrivereh::TCustomSQLDataDriverEh* __fastcall CreateDesignCopy(Datadrivereh::TCustomSQLDataDriverEh* RTDataDriver);
	virtual bool __fastcall DesignDataBaseConnetionEqual(Datadrivereh::TCustomSQLDataDriverEh* DataDriver);
	virtual int __fastcall Execute(Datadrivereh::TCustomSQLCommandEh* Command, Db::TDataSet* &Cursor, bool &FreeOnEof)/* overload */;
	Dbtables::TDatabase* __fastcall GetDataBase(void);
	virtual bool __fastcall BuildUpdates(Datadrivereh::TCustomSQLDataDriverEh* DataDriver);
	virtual Db::TDataSet* __fastcall CreateReader(AnsiString SQL, Sqldriverediteh::TParamsArr FParams);
	int __fastcall ExecuteSQL(AnsiString SQL, Sqldriverediteh::TParamsArr FParams);
	virtual bool __fastcall BuildObjectTree(Classes::TList* List);
	bool __fastcall BuildInformixObjectTree2(Classes::TList* List);
	bool __fastcall BuildInterbaseObjectTree2(Classes::TList* List);
	bool __fastcall BuildOracleObjectTree(Classes::TList* List);
	virtual bool __fastcall GetFieldList(const AnsiString TableName, Db::TDataSet* DataSet);
	virtual bool __fastcall SupportCustomSQLDataDriver(void);
	virtual AnsiString __fastcall GetSpecParamsList();
	virtual Sqldriverediteh::TCustomDBService* __fastcall GetCustomDBService(void);
	virtual Classes::TStrings* __fastcall GetIncrementObjectsList(void);
	virtual void __fastcall BuildQueryPlan(Memtableeh::TMemTableEh* PlanTable, Datadrivereh::TCustomSQLCommandEh* Command);
	virtual void __fastcall EditDatabaseParams(void);
	virtual void __fastcall ResetDesignInfo(void);
	__property AnsiString RuntimeDataBaseName = {read=FRuntimeDataBaseName, write=FRuntimeDataBaseName};
	
/* Hoisted overloads: */
	
public:
	inline int __fastcall  Execute(AnsiString SQLText, Datadrivereh::TSQLCommandTypeEh CommandType, const Variant &VarParams, Db::TDataSet* &Cursor){ return TDesignDataBaseEh::Execute(SQLText, CommandType, VarParams, Cursor); }
	
private:
	void *__IBDEDesignDataBaseEh;	/* Bdedatadriverdesigneh::IBDEDesignDataBaseEh */
	
public:
	operator IBDEDesignDataBaseEh*(void) { return (IBDEDesignDataBaseEh*)&__IBDEDesignDataBaseEh; }
	
};


class DELPHICLASS TBDEUniService;
class PASCALIMPLEMENTATION TBDEUniService : public Sqldriverediteh::TCustomDBService 
{
	typedef Sqldriverediteh::TCustomDBService inherited;
	
private:
	Sqldriverediteh::TCustomDBService* ServerService;
	
public:
	__fastcall virtual TBDEUniService(Sqldriverediteh::TDesignDataBaseEh* ADesignDB);
	__fastcall virtual ~TBDEUniService(void);
	virtual Classes::TList* __fastcall CreateRootNodes(void);
	virtual Classes::TList* __fastcall CreateNodes(Sqldriverediteh::TSQLTreeNode* Parent);
	virtual int __fastcall ShowPopup(System::TObject* Source, const Types::TPoint &Coord, Sqldriverediteh::TServicePopupParams Params);
	/* virtual class method */ virtual AnsiString __fastcall GetDBServiceName(TMetaClass* vmt);
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall RegisterBDEAccessEngines(void);
extern PACKAGE void __fastcall UnregisterBDEAccessEngines(void);
extern PACKAGE void __fastcall Register(void);

}	/* namespace Bdedatadriverdesigneh */
using namespace Bdedatadriverdesigneh;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Bdedatadriverdesigneh
