// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Winconvert.pas' rev: 10.00

#ifndef WinconvertHPP
#define WinconvertHPP

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

namespace Winconvert
{
//-- type declarations -------------------------------------------------------
typedef short Int16;

class DELPHICLASS ElzhException;
class PASCALIMPLEMENTATION ElzhException : public Sysutils::Exception 
{
	typedef Sysutils::Exception inherited;
	
public:
	#pragma option push -w-inl
	/* Exception.Create */ inline __fastcall ElzhException(const AnsiString Msg) : Sysutils::Exception(Msg) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmt */ inline __fastcall ElzhException(const AnsiString Msg, System::TVarRec const * Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateRes */ inline __fastcall ElzhException(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmt */ inline __fastcall ElzhException(int Ident, System::TVarRec const * Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateHelp */ inline __fastcall ElzhException(const AnsiString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmtHelp */ inline __fastcall ElzhException(const AnsiString Msg, System::TVarRec const * Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResHelp */ inline __fastcall ElzhException(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmtHelp */ inline __fastcall ElzhException(System::PResStringRec ResStringRec, System::TVarRec const * Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~ElzhException(void) { }
	#pragma option pop
	
};


typedef void __fastcall (__closure *TWriteProc)(void *DTA, Word NBytes, Word &Bytes_Put);

typedef void __fastcall (__closure *PutBytesProc)(void *DTA, Word NBytes, Word &Bytes_Put);

typedef void __fastcall (__closure *TReadProc)(void *DTA, Word NBytes, Word &Bytes_Got);

typedef void __fastcall (__closure *GetBytesProc)(void *DTA, Word NBytes, Word &Bytes_Got);

typedef Word Freqtype[628];

typedef Word *FreqPtr;

typedef short PntrType[941];

typedef short *pntrPtr;

typedef short SonType[627];

typedef short *SonPtr;

typedef Byte TextBufType[4155];

typedef Byte *TBufPtr;

typedef short WordRay[4097];

typedef short *WordRayPtr;

typedef short BWordRay[4353];

typedef short *BWordRayPtr;

class DELPHICLASS TLZH;
class PASCALIMPLEMENTATION TLZH : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	Word code;
	Word len;
	void __fastcall InitTree(void);
	void __fastcall InsertNode(short r);
	void __fastcall DeleteNode(short p);
	short __fastcall GetBit(TReadProc GetBytes);
	short __fastcall GetByte(TReadProc GetBytes);
	void __fastcall update(short c);
	void __fastcall StartHuff(void);
	void __fastcall Putcode(short l, Word c, TWriteProc PutBytes);
	void __fastcall reconst(void);
	void __fastcall EncodeChar(Word c, TWriteProc PutBytes);
	void __fastcall EncodePosition(Word c, TWriteProc PutBytes);
	void __fastcall EncodeEnd(TWriteProc PutBytes);
	short __fastcall DecodeChar(TReadProc GetBytes);
	Word __fastcall DecodePosition(TReadProc GetBytes);
	void __fastcall InitLZH(void);
	void __fastcall EndLZH(void);
	
public:
	Classes::TStream* StreamIn;
	Classes::TStream* StreamOut;
	Word getbuf;
	Byte getlen;
	Byte putlen;
	Word putbuf;
	int textsize;
	int codesize;
	int printcount;
	short match_position;
	short match_length;
	Byte *text_buf;
	short *lson;
	short *dad;
	short *rson;
	Word *freq;
	short *prnt;
	short *son;
	void __fastcall LZHPack(int &Bytes_Written, TReadProc GetBytes, TWriteProc PutBytes);
	void __fastcall LZHUnpack(int TextSize, TReadProc GetBytes, TWriteProc PutBytes);
	void __fastcall GetBlockStream(void *DTA, Word NBytes, Word &Bytes_Got);
	void __fastcall PutBlockStream(void *DTA, Word NBytes, Word &Bytes_Got);
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TLZH(void) : System::TObject() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TLZH(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
static const Shortint EXIT_OK = 0x0;
static const Shortint EXIT_FAILED = 0x1;
static const Word N = 0x1000;
static const Shortint F = 0x3c;
static const Shortint THRESHOLD = 0x2;
static const Word NUL = 0x1000;
static const Word N_CHAR = 0x13a;
static const Word T = 0x273;
static const Word R = 0x272;
static const Word MAX_FREQ = 0x8000;
extern PACKAGE Byte p_len[64];
extern PACKAGE Byte p_code[64];
extern PACKAGE Byte d_code[256];
extern PACKAGE Byte d_len[256];

}	/* namespace Winconvert */
using namespace Winconvert;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Winconvert
