unit ImageDrawing;
//---------------------------------------------------------------------------
// ImageDrawing.pas                                     Modified: 15-Ago-2005
// Asphyre image drawing routines                                 Version 1.0
//---------------------------------------------------------------------------
// The contents of this file are subject to the Mozilla Public License
// Version 1.1 (the "License"); you may not use this file except in
// compliance with the License. You may obtain a copy of the License at
// http://www.mozilla.org/MPL/
//
// Software distributed under the License is distributed on an "AS IS"
// basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
// License for the specific language governing rights and limitations
// under the License.
//---------------------------------------------------------------------------
interface

//---------------------------------------------------------------------------
uses
 Windows, Types, Classes, SysUtils, Graphics, AsphyreTypes, ImageFx,
 CommonDef, Vectors2px;

//---------------------------------------------------------------------------
// Simplified GDI drawing functions
//---------------------------------------------------------------------------
procedure ImageDrawDC(DestDC: THandle; Source: TBitmap; x, y: Integer); overload;
procedure ImageDrawDC(DestDC: THandle; Source: TBitmap; x, y, Width,
 Height: Integer); overload;
procedure ImageDrawDC(DestDC: THandle; Source: TBitmap; const PSize: TPoint;
 x, y, Pattern: Integer); overload;
procedure ImageDrawDC(DestDC: THandle; Source: TBitmap; const PSize: TPoint;
 x, y, Width, Height, Pattern: Integer); overload;

//---------------------------------------------------------------------------
// Complex drawing routine (GDI + Alpha-channel)
//---------------------------------------------------------------------------
procedure ImageDrawDCa(DestDC: THandle; Source: TBitmap; const PSize: TPoint;
 x, y, Pattern: Integer; Color0, Color1: Cardinal); overload;

//---------------------------------------------------------------------------
// Drawing functions with alpha-channel support
//---------------------------------------------------------------------------
procedure ImageDraw(Dest, Source: TBitmap; const PSize: TPoint;
 x, y, Pattern, Alpha: Integer); overload;
procedure ImageDraw(Dest, Source: TBitmap; const PSize: TPoint;
 x, y, Pattern: Integer); overload;
procedure ImageDraw(Dest, Source: TBitmap; x, y: Integer); overload;
procedure ImageDraw(Dest, Source: TBitmap; const SrcRect: TRect;
 const DestPos: TPoint2px; Alpha: Integer); overload;

//---------------------------------------------------------------------------
procedure ImageDraw(Dest, Source: TBitmap; const PSize: TPoint;
 x, y, Pattern: Integer; Color0, Color1: Cardinal); overload;

//---------------------------------------------------------------------------
implementation

//---------------------------------------------------------------------------
procedure ImageDrawDC(DestDC: THandle; Source: TBitmap; x, y: Integer);
begin
 BitBlt(DestDC, x, y, Source.Width, Source.Height, Source.Canvas.Handle,
  0, 0, SRCCOPY);
end;

//---------------------------------------------------------------------------
procedure ImageDrawDC(DestDC: THandle; Source: TBitmap; x, y, Width,
 Height: Integer); overload;
begin
 StretchBlt(DestDC, x, y, Width, Height, Source.Canvas.Handle, 0, 0,
  Source.Width, Source.Height, SRCCOPY);
end;

//---------------------------------------------------------------------------
function PatternRect(Image: TBitmap; PSize: TPoint; Pattern: Integer): TRect;
var
 ImgInRow: Integer;
 ImgInCol: Integer;
 Patterns: Integer;
begin
 // check for validity of pattern size
 if (PSize.X < 1)or(PSize.X > Image.Width) then PSize.X:= Image.Width;
 if (PSize.Y < 1)or(PSize.Y > Image.Height) then PSize.Y:= Image.Height;

 // find number of images in rows/cols
 ImgInRow:= Image.Width div PSize.X;
 ImgInCol:= Image.Height div PSize.Y;
 Patterns:= ImgInRow * ImgInCol;

 // validate pattern number
 if (Pattern < 0) then Pattern:= 0;
 if (Pattern >= Patterns) then Pattern:= Patterns - 1;

 // select source rectangle
 Result.Left  := (Pattern mod ImgInRow) * PSize.X;
 Result.Top   := ((Pattern div ImgInRow) mod ImgInCol) * PSize.Y;
 Result.Right := Result.Left + PSize.X;
 Result.Bottom:= Result.Top + PSize.Y;
end;

//---------------------------------------------------------------------------
function ClipCoords(var x, y: Integer; var Rect: TRect; Limit: TPoint): Boolean;
var
 SrcWidth : Integer;
 SrcHeight: Integer;
begin
 Result:= False;

 // top-left clip
 if (x < 0) then
  begin
   Rect.Left:= Rect.Left - x;
   x:= 0;
  end;
 if (y < 0) then
  begin
   Rect.Top:= Rect.Top - y;
   y:= 0;
  end;

 // verify whether our image is still visible
 if (Rect.Right <= Rect.Left)or(Rect.Bottom <= Rect.Top) then Exit;

 // extract visible size
 SrcWidth := Rect.Right - Rect.Left;
 SrcHeight:= Rect.Bottom - Rect.Top;

 // bottom-right clip
 if (x + SrcWidth > Limit.X) then SrcWidth:= Limit.X - x;
 if (y + SrcHeight > Limit.Y) then SrcHeight:= Limit.Y - y;

 // reconstruct visible rectangle
 Rect.Right := Rect.Left + SrcWidth;
 Rect.Bottom:= Rect.Top + SrcHeight;

 // verify if the image is visible
 Result:= (Rect.Right > Rect.Left)and(Rect.Bottom > Rect.Top);
end;

//---------------------------------------------------------------------------
procedure ImageDrawDC(DestDC: THandle; Source: TBitmap; const PSize: TPoint;
 x, y, Pattern: Integer); overload;
var
 Rect: TRect;
begin
 Rect:= PatternRect(Source, PSize, Pattern);
 BitBlt(DestDC, x, y, Rect.Right - Rect.Left, Rect.Bottom - Rect.Top,
  Source.Canvas.Handle, Rect.Left, Rect.Top, SRCCOPY);
end;

//---------------------------------------------------------------------------
procedure ImageDrawDC(DestDC: THandle; Source: TBitmap; const PSize: TPoint;
 x, y, Width, Height, Pattern: Integer);
var
 Rect: TRect;
begin
 Rect:= PatternRect(Source, PSize, Pattern);
 StretchBlt(DestDC, x, y, Width, Height, Source.Canvas.Handle, Rect.Left,
  Rect.Top, Rect.Right - Rect.Left, Rect.Bottom - Rect.Top, SRCCOPY);
end;

//---------------------------------------------------------------------------
procedure DrawBitmap1(Dest, Source: TBitmap; const DestPos: TPoint;
 const SrcRect: TRect; Alpha: Integer);
var
 vWidth : Integer;
 vHeight: Integer;
 Index  : Integer;
 DestPtr: Pointer;
 SrcPtr : Pointer;
begin
 // verify pixel format
 if (Source.PixelFormat <> pf32bit) then Source.PixelFormat:= pf32bit;
 if (Dest.PixelFormat <> pf32bit) then Dest.PixelFormat:= pf32bit;

 // extract visible size
 vWidth := SrcRect.Right - SrcRect.Left;
 vHeight:= SrcRect.Bottom - SrcRect.Top;

 // process scanlines
 for Index:= 0 to vHeight - 1 do
  begin
   SrcPtr := Pointer(Integer(Source.Scanline[SrcRect.Top + Index]) + (SrcRect.Left shl 2));
   DestPtr:= Pointer(Integer(Dest.ScanLine[Index + DestPos.Y]) + (DestPos.X * 4));
   RenderLineAlpha(SrcPtr, DestPtr, vWidth, Alpha);
  end;
end;

//---------------------------------------------------------------------------
procedure DrawBitmap2(Dest, Source: TBitmap; const DestPos: TPoint;
 const SrcRect: TRect; Color0, Color1: Cardinal);
var
 vWidth : Integer;
 vHeight: Integer;
 Index  : Integer;
 DestPtr: Pointer;
 SrcPtr : Pointer;
 Color  : Cardinal;
begin
 // verify pixel format
 if (Source.PixelFormat <> pf32bit) then Source.PixelFormat:= pf32bit;
 if (Dest.PixelFormat <> pf32bit) then Dest.PixelFormat:= pf32bit;

 // extract visible size
 vWidth := SrcRect.Right - SrcRect.Left;
 vHeight:= SrcRect.Bottom - SrcRect.Top;

 // prepare diffuse colors
 Color0:= DisplaceRB(Color0);
 Color1:= DisplaceRB(Color1);

 // process scanlines
 for Index:= 0 to vHeight - 1 do
  begin
   SrcPtr := Pointer(Integer(Source.Scanline[SrcRect.Top + Index]) + (SrcRect.Left shl 2));
   DestPtr:= Pointer(Integer(Dest.ScanLine[Index + DestPos.Y]) + (DestPos.X * 4));
   Color  := BlendPixels(Color1, Color0, (Index * 255) div vHeight);
   RenderLineDiffuse(SrcPtr, DestPtr, vWidth, Color);
  end;
end;

//--------------------------------------------------------------------------
procedure ImageDraw(Dest, Source: TBitmap; const PSize: TPoint;
 x, y, Pattern, Alpha: Integer); overload;
var
 Rect: TRect;
begin
 Rect:= PatternRect(Source, PSize, Pattern);
 if (ClipCoords(x, y, Rect, Point(Dest.Width, Dest.Height))) then
  DrawBitmap1(Dest, Source, Point(x, y), Rect, Alpha);
end;

//---------------------------------------------------------------------------
procedure ImageDraw(Dest, Source: TBitmap; const PSize: TPoint;
 x, y, Pattern: Integer); overload;
begin
 ImageDraw(Dest, Source, PSize, x, y, Pattern, 255);
end;

//---------------------------------------------------------------------------
procedure ImageDraw(Dest, Source: TBitmap; x, y: Integer); overload;
begin
 ImageDraw(Dest, Source, Point(Source.Width, Source.Height), x, y, 0, 255);
end;

//---------------------------------------------------------------------------
procedure ImageDraw(Dest, Source: TBitmap; const PSize: TPoint;
 x, y, Pattern: Integer; Color0, Color1: Cardinal); overload;
var
 Rect: TRect;
begin
 Rect:= PatternRect(Source, PSize, Pattern);
 if (ClipCoords(x, y, Rect, Point(Dest.Width, Dest.Height))) then
  DrawBitmap2(Dest, Source, Point(x, y), Rect, Color0, Color1);
end;

//---------------------------------------------------------------------------
procedure ImageDrawDCa(DestDC: THandle; Source: TBitmap; const PSize: TPoint;
 x, y, Pattern: Integer; Color0, Color1: Cardinal); overload;
var
 Rect: TRect;
 Canv: TBitmap;
begin
 Rect:= PatternRect(Source, PSize, Pattern);

 Canv:= TBitmap.Create();
 Canv.Width := Rect.Right - Rect.Left;
 Canv.Height:= Rect.Bottom - Rect.Top;
 BitBlt(Canv.Canvas.Handle, 0, 0, Canv.Width, Canv.Height, DestDC, x, y,
  SRCCOPY);

 DrawBitmap2(Canv, Source, Point(0, 0), Rect, Color0, Color1);
 ImageDrawDC(DestDC, Canv, x, y);
 Canv.Free();
end;

//---------------------------------------------------------------------------
procedure ImageDraw(Dest, Source: TBitmap; const SrcRect: TRect;
 const DestPos: TPoint2px; Alpha: Integer); overload;
begin
 DrawBitmap1(Dest, Source, DestPos, SrcRect, Alpha);
end;

//---------------------------------------------------------------------------
end.
