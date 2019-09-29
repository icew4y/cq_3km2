// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Imgutil.pas' rev: 10.00

#ifndef ImgutilHPP
#define ImgutilHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Imgutil
{
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall ConvertBitmapToGrayscale(const Graphics::TBitmap* Bmp);
extern PACKAGE void __fastcall ChangeTrans(Graphics::TBitmap* abmp, Graphics::TColor colorf);
extern PACKAGE void __fastcall SpiegelnHorizontal(Graphics::TBitmap* Bitmap);
extern PACKAGE void __fastcall SpiegelnVertikal(Graphics::TBitmap* Bitmap);
extern PACKAGE void __fastcall Drehen270Grad(Graphics::TBitmap* Bitmap);
extern PACKAGE void __fastcall Drehen90Grad(Graphics::TBitmap* Bitmap);
extern PACKAGE void __fastcall Drehen180Grad(Graphics::TBitmap* Bitmap);
extern PACKAGE Graphics::TBitmap* __fastcall Rotate90(Graphics::TBitmap* Bitmap);
extern PACKAGE Graphics::TColor __fastcall Blend(Graphics::TColor C1, Graphics::TColor C2, int W1);
extern PACKAGE void __fastcall GradFill(HDC DC, const Types::TRect &ARect, Graphics::TColor ClrTopLeft, Graphics::TColor ClrBottomRight, int Kind = 0x1);
extern PACKAGE int __fastcall GetHSV(Graphics::TColor c);

}	/* namespace Imgutil */
using namespace Imgutil;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Imgutil
