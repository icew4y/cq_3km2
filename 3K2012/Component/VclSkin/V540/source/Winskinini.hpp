// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Winskinini.pas' rev: 10.00

#ifndef WinskininiHPP
#define WinskininiHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Winconvert.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Winskinini
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TQuickIni;
class PASCALIMPLEMENTATION TQuickIni : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	bool FAuto;
	AnsiString FFileName;
	Classes::TStrings* FIniFile;
	AnsiString __fastcall GetName(const AnsiString Line);
	AnsiString __fastcall GetValue(const AnsiString Line, const AnsiString Name);
	int __fastcall GetSectionIndex(const AnsiString Section);
	bool __fastcall IsSection(const AnsiString Line);
	void __fastcall SetFileName(AnsiString Value);
	void __fastcall SetIniFile(Classes::TStrings* Value);
	
protected:
	Classes::TStrings* FSections;
	void __fastcall Compress(Classes::TStream* source, Classes::TStream* dest);
	void __fastcall Decompress(Classes::TStream* source, Classes::TStream* Dest);
	
public:
	__fastcall TQuickIni(void);
	__fastcall virtual ~TQuickIni(void);
	void __fastcall LoadFromFile(AnsiString aname);
	void __fastcall SaveToFile(AnsiString aname);
	void __fastcall LoadFromStream(Classes::TStream* Stream);
	void __fastcall SaveToStream(Classes::TStream* Stream);
	void __fastcall LoadFromZip(AnsiString aname);
	void __fastcall SavetoZip(AnsiString aname);
	void __fastcall DeleteKey(const AnsiString Section, const AnsiString Ident);
	void __fastcall EraseSection(const AnsiString Section);
	bool __fastcall ReadBool(const AnsiString Section, const AnsiString Ident, bool Default);
	int __fastcall ReadInteger(const AnsiString Section, const AnsiString Ident, int Default);
	void __fastcall ReadSection(const AnsiString Section, Classes::TStrings* Strings);
	void __fastcall ReadSections(Classes::TStrings* Strings);
	void __fastcall ReadSectionValues(const AnsiString Section, Classes::TStrings* Strings);
	AnsiString __fastcall ReadString(const AnsiString Section, const AnsiString Ident, AnsiString Default);
	void __fastcall RebuildSections(void);
	void __fastcall WriteBool(const AnsiString Section, const AnsiString Ident, bool Value);
	void __fastcall WriteInteger(const AnsiString Section, const AnsiString Ident, int Value);
	void __fastcall WriteString(const AnsiString Section, const AnsiString Ident, AnsiString Value);
	__property AnsiString FileName = {read=FFileName, write=SetFileName};
	__property bool AutoSaveLoad = {read=FAuto, write=FAuto, nodefault};
	__property Classes::TStrings* IniFile = {read=FIniFile, write=SetIniFile};
	void __fastcall Clear(void);
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Winskinini */
using namespace Winskinini;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Winskinini
