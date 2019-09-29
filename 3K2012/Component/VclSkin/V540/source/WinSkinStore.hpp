// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Winskinstore.pas' rev: 10.00

#ifndef WinskinstoreHPP
#define WinskinstoreHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Winskinstore
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TSkinCollectionItem;
class PASCALIMPLEMENTATION TSkinCollectionItem : public Classes::TCollectionItem 
{
	typedef Classes::TCollectionItem inherited;
	
private:
	AnsiString FName;
	void __fastcall SetName(AnsiString AName);
	int __fastcall GetDataSize(void);
	AnsiString __fastcall GetData();
	void __fastcall SetData(const AnsiString Value);
	void __fastcall ReadData(Classes::TStream* Stream);
	void __fastcall WriteData(Classes::TStream* Stream);
	
protected:
	virtual AnsiString __fastcall GetDisplayName();
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	
public:
	Classes::TMemoryStream* FData;
	__fastcall virtual TSkinCollectionItem(Classes::TCollection* ACollection);
	__fastcall virtual ~TSkinCollectionItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* ASource);
	void __fastcall LoadFromFile(AnsiString value);
	void __fastcall CopyData(Classes::TMemoryStream* AStream);
	
__published:
	__property AnsiString Name = {read=FName, write=SetName};
	__property AnsiString SkinData = {read=GetData, write=SetData, stored=false};
	__property int DataSize = {read=GetDataSize, nodefault};
};


class DELPHICLASS TSkinCollection;
class PASCALIMPLEMENTATION TSkinCollection : public Classes::TOwnedCollection 
{
	typedef Classes::TOwnedCollection inherited;
	
public:
	__fastcall TSkinCollection(Classes::TPersistent* AOwner);
	HIDESBASE TSkinCollectionItem* __fastcall Add(void)/* overload */;
	virtual void __fastcall Assign(Classes::TPersistent* ASource);
public:
	#pragma option push -w-inl
	/* TCollection.Destroy */ inline __fastcall virtual ~TSkinCollection(void) { }
	#pragma option pop
	
};


class DELPHICLASS TSkinStore;
class PASCALIMPLEMENTATION TSkinStore : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	TSkinCollection* FStore;
	void __fastcall SetStore(TSkinCollection* AStore);
	
public:
	__fastcall virtual TSkinStore(Classes::TComponent* AOwner);
	__fastcall virtual ~TSkinStore(void);
	
__published:
	__property TSkinCollection* Store = {read=FStore, write=SetStore};
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Winskinstore */
using namespace Winskinstore;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Winskinstore
