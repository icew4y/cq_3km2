// CodeGear C++ Builder
// Copyright (c) 1995, 2007 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Adodatadriverdesigneh.pas' rev: 11.00

#ifndef AdodatadriverdesignehHPP
#define AdodatadriverdesignehHPP

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
#include <Adodb.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Sqldriverediteh.hpp>	// Pascal unit
#include <Adodatadrivereh.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Memtableeh.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Updatesqlediteh.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Adodatadriverdesigneh
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TADODesignDataBaseEh;
class PASCALIMPLEMENTATION TADODesignDataBaseEh : public Sqldriverediteh::TDesignDataBaseEh 
{
	typedef Sqldriverediteh::TDesignDataBaseEh inherited;
	
private:
	Memtableeh::TMemTableEh* FTablesMT;
	Memtableeh::TMemTableEh* FColumnsMT;
	Adodb::TADOConnection* FConnection;
	Sqldriverediteh::TCustomDBService* FTreeNodeMan;
	TMetaClass* FDBServiceClass;
	Adodb::TADOConnection* FApplicationConnection;
	void __fastcall SetApplicationConnection(const Adodb::TADOConnection* Value);
	
protected:
	virtual bool __fastcall GetConnected(void);
	virtual void __fastcall SetConnected(const bool Value);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
public:
	__fastcall TADODesignDataBaseEh(void);
	__fastcall virtual ~TADODesignDataBaseEh(void);
	virtual AnsiString __fastcall GetEngineName();
	AnsiString __fastcall ServerTypeName();
	virtual Datadrivereh::TCustomSQLDataDriverEh* __fastcall CreateDesignCopy(Datadrivereh::TCustomSQLDataDriverEh* RTDataDriver);
	virtual bool __fastcall DesignDataBaseConnetionEqual(Datadrivereh::TCustomSQLDataDriverEh* DataDriver);
	virtual int __fastcall Execute(Datadrivereh::TCustomSQLCommandEh* Command, Db::TDataSet* &Cursor, bool &FreeOnEof)/* overload */;
	Adodb::TADOConnection* __fastcall GetConnection(void);
	virtual bool __fastcall BuildUpdates(Datadrivereh::TCustomSQLDataDriverEh* DataDriver);
	virtual Db::TDataSet* __fastcall CreateReader(AnsiString SQL, Sqldriverediteh::TParamsArr FParams);
	virtual bool __fastcall BuildObjectTree(Classes::TList* List);
	bool __fastcall BuildInterbaseObjectTree2(Comctrls::TTreeView* TreeView);
	bool __fastcall BuildOracleObjectTree(Comctrls::TTreeView* TreeView);
	virtual bool __fastcall GetFieldList(const AnsiString TableName, Db::TDataSet* DataSet);
	virtual AnsiString __fastcall GetSpecParamsList();
	virtual bool __fastcall SupportCustomSQLDataDriver(void);
	virtual Sqldriverediteh::TCustomDBService* __fastcall GetCustomDBService(void);
	virtual void __fastcall EditDatabaseParams(void);
	__property TMetaClass* DBServiceClass = {read=FDBServiceClass};
	__property Adodb::TADOConnection* ApplicationConnection = {read=FApplicationConnection, write=SetApplicationConnection};
	
/* Hoisted overloads: */
	
public:
	inline int __fastcall  Execute(AnsiString SQLText, Datadrivereh::TSQLCommandTypeEh CommandType, const Variant &VarParams, Db::TDataSet* &Cursor){ return TDesignDataBaseEh::Execute(SQLText, CommandType, VarParams, Cursor); }
	
};


class DELPHICLASS TADOAccessEngineEh;
class PASCALIMPLEMENTATION TADOAccessEngineEh : public Sqldriverediteh::TAccessEngineEh 
{
	typedef Sqldriverediteh::TAccessEngineEh inherited;
	
public:
	virtual AnsiString __fastcall AccessEngineName();
	virtual Sqldriverediteh::TDesignDataBaseEh* __fastcall CreateDesignDataBase(Datadrivereh::TCustomSQLDataDriverEh* DataDriver, TMetaClass* DBServiceClass, AnsiString DataBaseName);
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TADOAccessEngineEh(void) : Sqldriverediteh::TAccessEngineEh() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TADOAccessEngineEh(void) { }
	#pragma option pop
	
};


class DELPHICLASS TADOUniService;
class PASCALIMPLEMENTATION TADOUniService : public Sqldriverediteh::TCustomDBService 
{
	typedef Sqldriverediteh::TCustomDBService inherited;
	
private:
	Sqldriverediteh::TDesignDataBaseEh* FDesignDB;
	Sqldriverediteh::TCustomDBService* FSpecPraramsService;
	bool FNoAskForSpecPraramsService;
	
protected:
	virtual Db::TDataSet* __fastcall CreateReader(AnsiString SQL, Sqldriverediteh::TParamsArr FParams);
	
public:
	__fastcall virtual TADOUniService(Sqldriverediteh::TDesignDataBaseEh* ADesignDB);
	__fastcall virtual ~TADOUniService(void);
	virtual AnsiString __fastcall GetSpecParamsList();
	virtual int __fastcall ShowPopup(System::TObject* Source, const Types::TPoint &Coord, Sqldriverediteh::TServicePopupParams Params);
	virtual void __fastcall GenGetSpecParams(Sqldriverediteh::TDesignUpdateParamsEh* DesignUpdateParams, Sqldriverediteh::TDesignUpdateInfoEh* DesignUpdateInfo);
	/* virtual class method */ virtual AnsiString __fastcall GetDBServiceName(TMetaClass* vmt);
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall RegisterADOAccessEngines(void);
extern PACKAGE void __fastcall UnregisterADOAccessEngines(void);
extern PACKAGE void __fastcall Register(void);

}	/* namespace Adodatadriverdesigneh */
using namespace Adodatadriverdesigneh;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Adodatadriverdesigneh
