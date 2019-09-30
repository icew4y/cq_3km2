// CodeGear C++Builder
// Copyright (c) 1995, 2007 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Ehlibvcl.pas' rev: 11.00

#ifndef EhlibvclHPP
#define EhlibvclHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Typinfo.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Rtlconsts.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Ehlibvcl
{
//-- type declarations -------------------------------------------------------
typedef Messages::TMessage  TCMParentFontChanged;

typedef void *IntPtr;

typedef DynamicArray<Byte >  TBytes;

typedef AnsiString TUniBookmarkEh;

typedef DynamicArray<Typinfo::PPropInfo >  TPropListArray;

class DELPHICLASS TFilerAccess;
class PASCALIMPLEMENTATION TFilerAccess : public System::TInterfacedObject 
{
	typedef System::TInterfacedObject inherited;
	
private:
	Classes::TPersistent* FPersistent;
	
public:
	__fastcall TFilerAccess(Classes::TPersistent* APersistent);
	void __fastcall DefineProperties(Classes::TFiler* AFiler);
	void __fastcall GetChildren(Classes::TGetChildProc Proc, Classes::TComponent* Root);
	Classes::TComponent* __fastcall GetChildOwner(void);
	Classes::TComponent* __fastcall GetChildParent(void);
	void __fastcall SetAncestor(bool Value);
	void __fastcall SetChildOrder(Classes::TComponent* Child, int Order);
	void __fastcall Updated(void);
	void __fastcall Updating(void);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TFilerAccess(void) { }
	#pragma option pop
	
};


class DELPHICLASS TMemoryStreamEh;
class PASCALIMPLEMENTATION TMemoryStreamEh : public Classes::TMemoryStream 
{
	typedef Classes::TMemoryStream inherited;
	
private:
	int FHalfMemoryDelta;
	
protected:
	virtual void * __fastcall Realloc(int &NewCapacity);
	
public:
	__fastcall TMemoryStreamEh(void);
	__property int HalfMemoryDelta = {read=FHalfMemoryDelta, write=FHalfMemoryDelta, nodefault};
public:
	#pragma option push -w-inl
	/* TMemoryStream.Destroy */ inline __fastcall virtual ~TMemoryStreamEh(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
#define NilBookmarkEh ""
extern "C" int __stdcall LongMulDiv(int Mult1, int Mult2, int Div1);
extern PACKAGE bool __fastcall CharInSetEh(char C, const Sysutils::TSysCharSet &CharSet);
extern PACKAGE AnsiString __fastcall VarToAnsiStr(const Variant &V);
extern PACKAGE int __fastcall WideStringCompare(WideString ws1, WideString ws2, int CharCount = 0x0, bool CaseInsensitive = false);
extern PACKAGE int __fastcall AnsiStringCompare(AnsiString s1, AnsiString s2, int CharCount = 0x0, bool CaseInsensitive = false);
extern PACKAGE bool __fastcall IsObjectAndIntegerRefSame(System::TObject* AObject, int IntRef);
extern PACKAGE System::TObject* __fastcall IntPtrToObject(int AIntPtr);
extern PACKAGE int __fastcall ObjectToIntPtr(System::TObject* AObject);
extern PACKAGE AnsiString __fastcall IntPtrToString(int AIntPtr);
extern PACKAGE void __fastcall FillDWord(void *Dest, int Count, int Value);
extern PACKAGE void * __fastcall StackAlloc(int Size);
extern PACKAGE void __fastcall StackFree(void * P);
extern PACKAGE int __fastcall DataSetCompareBookmarks(Db::TDataSet* DataSet, AnsiString Bookmark1, AnsiString Bookmark2);
extern PACKAGE bool __fastcall DataSetBookmarkValid(Db::TDataSet* DataSet, AnsiString Bookmark);
extern PACKAGE Db::TDataSet* __fastcall GetMasterDataSet(Db::TDataSet* FDataSet, Typinfo::PPropInfo APropInfo);
extern PACKAGE int __fastcall DrawTextEh(HDC hDC, AnsiString Text, int nCount, Types::TRect &lpRect, unsigned uFormat);
extern PACKAGE int __fastcall WindowsDrawTextEx(HDC DC, AnsiString lpchText, int cchText, Types::TRect &p4, unsigned dwDTFormat, const tagDRAWTEXTPARAMS &DTParams)/* overload */;
extern PACKAGE int __fastcall WindowsDrawTextEx(HDC DC, AnsiString lpchText, int cchText, Types::TRect &p4, unsigned dwDTFormat)/* overload */;
extern PACKAGE BOOL __fastcall WindowsExtTextOut(HDC DC, int X, int Y, int Options, Types::TRect &Rect, AnsiString Str, int Count);
extern PACKAGE unsigned __fastcall WindowsGetOutlineTextMetrics(HDC DC, unsigned p2, _OUTLINETEXTMETRICA &OTMetricStructs);
extern PACKAGE int __fastcall SendStructMessage(HWND hWnd, unsigned Msg, int wParam, void *lParam);
extern PACKAGE int __fastcall SendTextMessage(HWND hWnd, unsigned Msg, int wParam, AnsiString lParam);
extern PACKAGE int __fastcall SendGetTextMessage(HWND hWnd, unsigned Msg, int wParam, AnsiString &lParam, int BufferSize);
extern PACKAGE BOOL __fastcall SystemParametersInfoEh(unsigned uiAction, unsigned uiParam, void *pvParam, unsigned fWinIni);
extern PACKAGE BOOL __fastcall WindowsInvalidateRect(HWND hWnd, Types::TRect &Rect, BOOL bErase);
extern PACKAGE BOOL __fastcall WindowsValidateRect(HWND hWnd, Types::TRect &Rect);
extern PACKAGE BOOL __fastcall WindowsScrollWindowEx(HWND hWnd, int dx, int dy, Types::TRect &prcScroll, Types::TRect &prcClip, HRGN hrgnUpdate, unsigned flags);
extern PACKAGE BOOL __fastcall WindowsScrollWindow(HWND hWnd, int dx, int dy, Types::TRect &prcScroll, Types::TRect &prcClip);
extern PACKAGE HWND __fastcall FindWindowEh(AnsiString lpClassName, AnsiString lpWindowName);
extern PACKAGE void __fastcall VarToMessage(void *VarMessage, Messages::TMessage &Message);
extern PACKAGE Messages::TMessage __fastcall MessageToTMessage(void *Message);
extern PACKAGE Messages::TWMMouse __fastcall MessageToTWMMouse(void *Message);
extern PACKAGE Messages::TWMKey __fastcall MessageToTWMKey(void *Message);
extern PACKAGE Messages::TMessage __fastcall UnwrapMessageEh(void *Message);
extern PACKAGE int __fastcall SmallPointToInteger(Types::TSmallPoint SmallPoint);
extern PACKAGE Types::TSmallPoint __fastcall LongintToSmallPoint(int Value);
extern PACKAGE BOOL __fastcall WindowsLPtoDP(HDC DC, Types::TRect &ARect);
extern PACKAGE HRGN __fastcall WindowsCreatePolygonRgn(Types::TPoint * Points, const int Points_Size, int Count, int FillMode);
extern PACKAGE void __fastcall MessageSendGetSel(HWND hWnd, int &SelStart, int &SelEnd);
extern PACKAGE AnsiString __fastcall NlsUpperCase(const AnsiString S);
extern PACKAGE AnsiString __fastcall NlsLowerCase(const AnsiString S);
extern PACKAGE int __fastcall NlsCompareStr(const AnsiString S1, const AnsiString S2);
extern PACKAGE int __fastcall NlsCompareText(const AnsiString S1, const AnsiString S2);
extern PACKAGE void __fastcall BitmapLoadFromResourceName(Graphics::TBitmap* Bmp, unsigned Instance, const AnsiString ResName);
extern PACKAGE HBITMAP __fastcall LoadBitmapEh(unsigned hInstance, int lpBitmapID);
extern PACKAGE TPropListArray __fastcall GetPropListAsArray(Typinfo::PTypeInfo ATypeInfo, Typinfo::TTypeKinds TypeKinds);
extern PACKAGE int __fastcall HexToBinEh(void * Text, TBytes &Buffer, int Count);
extern PACKAGE void __fastcall BinToHexEh(TBytes Buffer, AnsiString &Text, int Count);
extern PACKAGE void __fastcall StreamWriteBytes(Classes::TStream* Stream, TBytes Buffer);
extern PACKAGE void __fastcall StreamReadBytes(Classes::TStream* Stream, TBytes &Buffer, int Count);
extern PACKAGE TBytes __fastcall BytesOf(AnsiString S);
extern PACKAGE Typinfo::PTypeInfo __fastcall PropInfo_getPropType(Typinfo::PPropInfo APropInfo);
extern PACKAGE AnsiString __fastcall PropInfo_getName(Typinfo::PPropInfo APropInfo);
extern PACKAGE Typinfo::TTypeKind __fastcall PropType_getKind(Typinfo::PTypeInfo APropType);
extern PACKAGE void __fastcall VarArrayRedimEh(Variant &A, int HighBound);
extern PACKAGE Types::TRect __fastcall EmptyRect();
extern PACKAGE Classes::TPersistent* __fastcall GetUltimateOwner(Classes::TPersistent* APersistent);
extern PACKAGE System::TObject* __fastcall VariantToRefObject(const Variant &Value);
extern PACKAGE Variant __fastcall RefObjectToVariant(System::TObject* Value);
extern PACKAGE void __fastcall DataVarCastAsObject(Variant &Dest, const Variant &Source);
extern PACKAGE WideChar * __fastcall WStrCopy(WideChar * Dest, const WideChar * Source);
extern PACKAGE int __fastcall ExplicitLongwordToLongInt(unsigned v);

}	/* namespace Ehlibvcl */
using namespace Ehlibvcl;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Ehlibvcl
