// CodeGear C++ Builder
// Copyright (c) 1995, 2007 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Ibxdatadriverdesigneh.pas' rev: 11.00

#ifndef IbxdatadriverdesignehHPP
#define IbxdatadriverdesignehHPP

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
#include <Ibdatabase.hpp>	// Pascal unit
#include <Ibquery.hpp>	// Pascal unit
#include <Ibtable.hpp>	// Pascal unit
#include <Ibstoredproc.hpp>	// Pascal unit
#include <Sqldriverediteh.hpp>	// Pascal unit
#include <Ibxdatadrivereh.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Memtableeh.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Updatesqlediteh.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Ibdatabaseedit.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Ibxdatadriverdesigneh
{
//-- type declarations -------------------------------------------------------
__interface IIBXDesignDataBaseEh;
typedef System::DelphiInterface<IIBXDesignDataBaseEh> _di_IIBXDesignDataBaseEh;
__interface  INTERFACE_UUID("{9E53BD33-4E5E-414F-9E4A-4980A8F7637A}") IIBXDesignDataBaseEh  : public IInterface 
{
	
public:
	virtual Ibdatabase::TIBDatabase* __fastcall GetDatabase(void) = 0 ;
};

class DELPHICLASS TIBXDesignDataBaseEh;
class PASCALIMPLEMENTATION TIBXDesignDataBaseEh : public Sqldriverediteh::TDesignDataBaseEh 
{
	typedef Sqldriverediteh::TDesignDataBaseEh inherited;
	
private:
	Memtableeh::TMemTableEh* FTablesMT;
	Memtableeh::TMemTableEh* FColumnsMT;
	Ibdatabase::TIBDatabase* FDatabase;
	Ibdatabase::TIBTransaction* FTransaction;
	Sqldriverediteh::TCustomDBService* FTreeNodeMan;
	Sqldriverediteh::TCustomDBService* FDBService;
	Classes::TStringList* FUpdateObjectsList;
	Ibdatabase::TIBDatabase* FApplicationDatabase;
	void __fastcall SetApplicationDatabase(const Ibdatabase::TIBDatabase* Value);
	
protected:
	virtual bool __fastcall GetConnected(void);
	virtual void __fastcall SetConnected(const bool Value);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
public:
	__fastcall TIBXDesignDataBaseEh(void);
	__fastcall virtual ~TIBXDesignDataBaseEh(void);
	virtual AnsiString __fastcall GetEngineName();
	AnsiString __fastcall ServerTypeName();
	virtual Datadrivereh::TCustomSQLDataDriverEh* __fastcall CreateDesignCopy(Datadrivereh::TCustomSQLDataDriverEh* RTDataDriver);
	virtual bool __fastcall DesignDataBaseConnetionEqual(Datadrivereh::TCustomSQLDataDriverEh* DataDriver);
	virtual int __fastcall Execute(Datadrivereh::TCustomSQLCommandEh* Command, Db::TDataSet* &Cursor, bool &FreeOnEof)/* overload */;
	Ibdatabase::TIBDatabase* __fastcall GetDatabase(void);
	virtual bool __fastcall BuildUpdates(Datadrivereh::TCustomSQLDataDriverEh* DataDriver);
	virtual Db::TDataSet* __fastcall CreateReader(AnsiString SQL, Sqldriverediteh::TParamsArr FParams);
	virtual bool __fastcall BuildObjectTree(Classes::TList* List);
	bool __fastcall BuildInterbaseObjectTree2(Classes::TList* List);
	bool __fastcall BuildOracleObjectTree(Comctrls::TTreeView* TreeView);
	virtual bool __fastcall SupportCustomSQLDataDriver(void);
	virtual bool __fastcall GetFieldList(const AnsiString TableName, Db::TDataSet* DataSet);
	virtual AnsiString __fastcall GetSpecParamsList();
	virtual Sqldriverediteh::TCustomDBService* __fastcall GetCustomDBService(void);
	virtual Classes::TStrings* __fastcall GetIncrementObjectsList(void);
	virtual void __fastcall EditDatabaseParams(void);
	__property Ibdatabase::TIBDatabase* ApplicationDatabase = {read=FApplicationDatabase, write=SetApplicationDatabase};
	
/* Hoisted overloads: */
	
public:
	inline int __fastcall  Execute(AnsiString SQLText, Datadrivereh::TSQLCommandTypeEh CommandType, const Variant &VarParams, Db::TDataSet* &Cursor){ return TDesignDataBaseEh::Execute(SQLText, CommandType, VarParams, Cursor); }
	
private:
	void *__IIBXDesignDataBaseEh;	/* Ibxdatadriverdesigneh::IIBXDesignDataBaseEh */
	
public:
	operator IIBXDesignDataBaseEh*(void) { return (IIBXDesignDataBaseEh*)&__IIBXDesignDataBaseEh; }
	
};


class DELPHICLASS TIBXAccessEngineEh;
class PASCALIMPLEMENTATION TIBXAccessEngineEh : public Sqldriverediteh::TAccessEngineEh 
{
	typedef Sqldriverediteh::TAccessEngineEh inherited;
	
public:
	virtual AnsiString __fastcall AccessEngineName();
	virtual Sqldriverediteh::TDesignDataBaseEh* __fastcall CreateDesignDataBase(Datadrivereh::TCustomSQLDataDriverEh* DataDriver, TMetaClass* DBServiceClass, AnsiString DataBaseName);
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TIBXAccessEngineEh(void) : Sqldriverediteh::TAccessEngineEh() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TIBXAccessEngineEh(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall RegisterIBXAccessEngines(void);
extern PACKAGE void __fastcall UnregisterIBXAccessEngines(void);
extern PACKAGE void __fastcall Register(void);

}	/* namespace Ibxdatadriverdesigneh */
using namespace Ibxdatadriverdesigneh;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Ibxdatadriverdesigneh
