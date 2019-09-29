// CodeGear C++ Builder
// Copyright (c) 1995, 2007 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Dbxdatadriverdesigneh.pas' rev: 11.00

#ifndef DbxdatadriverdesignehHPP
#define DbxdatadriverdesignehHPP

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
#include <Sqlexpr.hpp>	// Pascal unit
#include <Sqldriverediteh.hpp>	// Pascal unit
#include <Dbxdatadrivereh.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Memtableeh.hpp>	// Pascal unit
#include <Sqlconnedeh.hpp>	// Pascal unit
#include <Dbconned.hpp>	// Pascal unit
#include <Componentdesigner.hpp>	// Pascal unit
#include <Updatesqlediteh.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Dbxdatadriverdesigneh
{
//-- type declarations -------------------------------------------------------
__interface IDBXDesignDataBaseEh;
typedef System::DelphiInterface<IDBXDesignDataBaseEh> _di_IDBXDesignDataBaseEh;
__interface  INTERFACE_UUID("{9E53BD33-4E5E-414F-9E4A-4980A8F7637A}") IDBXDesignDataBaseEh  : public IInterface 
{
	
public:
	virtual Sqlexpr::TSQLConnection* __fastcall GetSQLConnection(void) = 0 ;
};

class DELPHICLASS TDBXDesignDataBaseEh;
class PASCALIMPLEMENTATION TDBXDesignDataBaseEh : public Sqldriverediteh::TDesignDataBaseEh 
{
	typedef Sqldriverediteh::TDesignDataBaseEh inherited;
	
private:
	Memtableeh::TMemTableEh* FTablesMT;
	Memtableeh::TMemTableEh* FColumnsMT;
	Sqlexpr::TSQLConnection* FSQLConnection;
	Sqldriverediteh::TCustomDBService* FTreeNodeMan;
	Sqldriverediteh::TCustomDBService* FDBService;
	Sqlexpr::TSQLConnection* FApplicationConnection;
	void __fastcall SetApplicationConnection(const Sqlexpr::TSQLConnection* Value);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual bool __fastcall GetConnected(void);
	virtual void __fastcall SetConnected(const bool Value);
	
public:
	__fastcall TDBXDesignDataBaseEh(void);
	__fastcall virtual ~TDBXDesignDataBaseEh(void);
	virtual AnsiString __fastcall GetEngineName();
	TMetaClass* __fastcall GetDBServiceClass(void);
	virtual AnsiString __fastcall GetServerTypeName();
	virtual Datadrivereh::TCustomSQLDataDriverEh* __fastcall CreateDesignCopy(Datadrivereh::TCustomSQLDataDriverEh* RTDataDriver);
	virtual bool __fastcall DesignDataBaseConnetionEqual(Datadrivereh::TCustomSQLDataDriverEh* DataDriver);
	virtual int __fastcall Execute(Datadrivereh::TCustomSQLCommandEh* Command, Db::TDataSet* &Cursor, bool &FreeOnEof)/* overload */;
	Sqlexpr::TSQLConnection* __fastcall GetSQLConnection(void);
	virtual bool __fastcall BuildUpdates(Datadrivereh::TCustomSQLDataDriverEh* DataDriver);
	virtual Db::TDataSet* __fastcall CreateReader(AnsiString SQL, Sqldriverediteh::TParamsArr FParams);
	virtual bool __fastcall BuildObjectTree(Classes::TList* List);
	bool __fastcall BuildInterbaseObjectTree2(Classes::TList* List);
	bool __fastcall BuildOracleObjectTree(Classes::TList* List);
	virtual bool __fastcall SupportCustomSQLDataDriver(void);
	virtual bool __fastcall GetFieldList(const AnsiString TableName, Db::TDataSet* DataSet);
	virtual void __fastcall EditDatabaseParams(void);
	__property Sqlexpr::TSQLConnection* ApplicationConnection = {read=FApplicationConnection, write=SetApplicationConnection};
	
/* Hoisted overloads: */
	
public:
	inline int __fastcall  Execute(AnsiString SQLText, Datadrivereh::TSQLCommandTypeEh CommandType, const Variant &VarParams, Db::TDataSet* &Cursor){ return TDesignDataBaseEh::Execute(SQLText, CommandType, VarParams, Cursor); }
	
private:
	void *__IDBXDesignDataBaseEh;	/* Dbxdatadriverdesigneh::IDBXDesignDataBaseEh */
	
public:
	operator IDBXDesignDataBaseEh*(void) { return (IDBXDesignDataBaseEh*)&__IDBXDesignDataBaseEh; }
	
};


class DELPHICLASS TDBXAccessEngineEh;
class PASCALIMPLEMENTATION TDBXAccessEngineEh : public Sqldriverediteh::TAccessEngineEh 
{
	typedef Sqldriverediteh::TAccessEngineEh inherited;
	
public:
	virtual AnsiString __fastcall AccessEngineName();
	virtual Sqldriverediteh::TDesignDataBaseEh* __fastcall CreateDesignDataBase(Datadrivereh::TCustomSQLDataDriverEh* DataDriver, TMetaClass* DBServiceClass, AnsiString DataBaseName);
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TDBXAccessEngineEh(void) : Sqldriverediteh::TAccessEngineEh() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TDBXAccessEngineEh(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall RegisterDBXAccessEngines(void);
extern PACKAGE void __fastcall Register(void);

}	/* namespace Dbxdatadriverdesigneh */
using namespace Dbxdatadriverdesigneh;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Dbxdatadriverdesigneh
