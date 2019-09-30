unit ImageFx;
//---------------------------------------------------------------------------
// ImageFx.pas                                          Modified: 18-Ago-2005
// Image and pixel routines                                       Version 1.1
//---------------------------------------------------------------------------
//
// Changes since v1.0:
//
//   * Moved several routines from AsphyreBmp.pas for processing certain
//     bitmaps and their patterns.
//   + Added alpha-channel extraction routines
//
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
 Types, Classes, SysUtils, Graphics, Math, CommonDef;

//---------------------------------------------------------------------------
{$ifdef fpc}
{$asmmode intel}
{$endif}

//---------------------------------------------------------------------------
// RenderLineAlpha()
//
// Renders source scanline with alpha-channel onto destination address.
// The source alpha-channel is multiplied by the specified Alpha coefficient.
//   Alpha can be [0..255]
//---------------------------------------------------------------------------
procedure RenderLineAlpha(Source, Dest: Pointer; Count, Alpha: Integer); stdcall;

//---------------------------------------------------------------------------
// RenderLineAlphaAdd()
//
// Renders source scanline  onto destination address.
// The source is multiplied bu its alpha-channel and Alpha coefficient.
//   Alpha can be [0..255]
//---------------------------------------------------------------------------
procedure RenderLineAlphaAdd(Source, Dest: Pointer; Count, Alpha: Integer); stdcall;

//---------------------------------------------------------------------------
// RenderLineDiffuse()
//
// Similar in effect to RenderLineAlpha() except that source pixels are also
// multiplied by the specified color.
//---------------------------------------------------------------------------
procedure RenderLineDiffuse(Source, Dest: Pointer; Count: Integer;
 Diffuse: Longword); stdcall;

//---------------------------------------------------------------------------
// BlendPixels()
//
// This function blends two pixels together by the specified alpha value.
//---------------------------------------------------------------------------
function BlendPixels(Px0, Px1: Longword; Alpha: Integer): Longword; stdcall;

//---------------------------------------------------------------------------
// ShrinkLine2x()
//
// Resamples source scanlines into a single line of half length.
//---------------------------------------------------------------------------
procedure ShrinkLine2x(Src0, Src1, Dest: Pointer;
 PixCount: Integer); stdcall;

//---------------------------------------------------------------------------
// Pixel2Gray()
//
// Transforms the specified 32-bit RGB pixel into grayscale (approx)
//---------------------------------------------------------------------------
function Pixel2Gray(Pixel: Longword): Longword; stdcall;

//---------------------------------------------------------------------------
// Pixel2GrayEx()
//
// Transforms the specified 32-bit RGB pixel into grayscale floating point
// value. This version is more precise than Pixel2Gray but slower.
//---------------------------------------------------------------------------
function Pixel2GrayEx(Pixel: Cardinal): Real;

//---------------------------------------------------------------------------
// ExtractAlpha()
//
// This takes ttwo grayscale pixels rendered on two different backgrounds
// and attempts to extract original pixel and its alpha-channel.
//---------------------------------------------------------------------------
procedure ExtractAlpha(Src1, Src2, Bk1, Bk2: Real; out Alpha, Px: Real);

//---------------------------------------------------------------------------
// ExtractAlpha()
//
// This takes the grayscale graphics rendered on two different backgrounds
// and attempts to extract original image and its alpha-channel.
//---------------------------------------------------------------------------
procedure FindAlphaChannel(Dest, Image0, Image1: TBitmap; Bk1, Bk2: Cardinal);

//---------------------------------------------------------------------------
// ClearBitmap()
//
// This routine takes the specified image, converts its bitdepth to 32-bit
// and then fills the surface with the specified color.
//---------------------------------------------------------------------------
procedure ClearBitmap(Image: TBitmap; Color: Longword);

//---------------------------------------------------------------------------
// TileBitmap()
//
// Takes source bitmap and attempts to tile its patterns on destination
// bitmap using different pattern accomodation.
//---------------------------------------------------------------------------
procedure TileBitmap(Dest, Source: TBitmap; const TexSize, InPSize,
 OutPSize: TPoint; NeedMask: Boolean; MaskColor: Cardinal; Tolerance: Integer);

//---------------------------------------------------------------------------
implementation

//---------------------------------------------------------------------------
procedure RenderLineAlpha(Source, Dest: Pointer; Count, Alpha: Integer); stdcall;
{$ifdef fpc} assembler;{$endif}
asm
 push esi
 push edi
 push ebx

 mov esi, Source       // ESI -> source pointer
 mov edi, Dest         // EDI -> destination pointer
 mov ecx, Count        // ECX -> a number of pixels to process

 pxor mm7, mm7         // MM7 -> zero register

 mov eax, 0FFFFFFFFh
 movd mm2, eax
 punpcklbw mm2, mm7    // MM2 -> 255,255,255,255 (words)

 mov eax, 01010101h
 movd mm3, eax
 punpcklbw mm3, mm7    // MM3 -> 1, 1, 1, 1 (words)

 paddusw mm2, mm3      // MM2 -> 256,256,256,256 (words)

 mov eax, Alpha
 and eax, 0FFh
 mov ebx, eax
 shl ebx, 8
 or eax , ebx
 shl ebx, 8
 or eax , ebx

 movd mm3, eax
 punpcklbw mm3, mm7    // MM3 -> alpha,alpha,alpha


 // Pixel processing loop.
 // On entry, these registers are defined:
 //  ESI - source
 //  EDI - dest
 //  ECX - pixel count
 //   MM2 - 256,256,256,256
 //   MM3 - alpha,alpha,alpha
 //   MM7 - zero
@rLoop:
 mov eax, [esi]        // EAX -> source pixel

 movd mm0, eax
 punpcklbw mm0, mm7    // MM0 -> source pixel (words)

 shr eax, 24
 mov ebx, eax
 shl ebx, 8
 or eax, ebx
 shl ebx, 8
 or eax, ebx

 movd mm4, eax
 punpcklbw mm4, mm7    // MM4 -> srcA, srcA, srcA (words)

 pmullw mm4, mm3
 psrlw mm4, 8          // MM4 -> srcA * alpha (words)

// pmullw mm0, mm4
// psrlw mm0, 8

 movd mm5, [edi]
 punpcklbw mm5, mm7    // MM5 -> dest pixel (words)

 pmullw mm0, mm4       // MM0 -> source pixel, multiplied by alpha-channel
 psrlw mm0, 8

 movq mm6, mm2
 psubusw mm6, mm4      // MM6 -> inverse alpha channel (words)

 pmullw mm5, mm6
 psrlw mm5, 8          // MM5 -> dest pixel, multiplied by inverse alpha-channel

 paddusw mm0, mm5



 packuswb  mm0, mm7    // MM0 -> final pixel (bytes)


 movd [edi], mm0

 add esi, 4
 add edi, 4

 dec ecx
 jnz @rLoop

 emms
 pop ebx
 pop edi
 pop esi
end;

//---------------------------------------------------------------------------
procedure RenderLineAlphaAdd(Source, Dest: Pointer; Count, Alpha: Integer); stdcall;
{$ifdef fpc} assembler;{$endif}
asm
 push esi
 push edi
 push ebx

 mov esi, Source       // ESI -> source pointer
 mov edi, Dest         // EDI -> destination pointer
 mov ecx, Count        // ECX -> a number of pixels to process

 pxor mm7, mm7         // MM7 -> zero register

 mov eax, Alpha
 and eax, 0FFh
 mov ebx, eax
 shl ebx, 8
 or eax , ebx
 shl ebx, 8
 or eax , ebx

 movd mm3, eax
 punpcklbw mm3, mm7    // MM3 -> alpha,alpha,alpha

 // Pixel processing loop.
 // On entry, these registers are defined:
 //  ESI - source
 //  EDI - dest
 //  ECX - pixel count
 //   MM3 - alpha,alpha,alpha
 //   MM7 - zero
@rLoop:
 mov eax, [esi]        // EAX -> source pixel

 movd mm0, eax
 punpcklbw mm0, mm7    // MM0 -> source pixel (words)

 shr eax, 24
 mov ebx, eax
 shl ebx, 8
 or eax, ebx
 shl ebx, 8
 or eax, ebx

 movd mm4, eax
 punpcklbw mm4, mm7    // MM4 -> srcA, srcA, srcA (words)

 pmullw mm4, mm3
 psrlw mm4, 8          // MM4 -> srcA * alpha (words)

 movd mm5, [edi]
 punpcklbw mm5, mm7    // MM5 -> dest pixel (words)

 pmullw mm0, mm4       // MM0 -> source pixel, multiplied by alpha-channel
 psrlw mm0, 8

 paddusw mm0, mm5


 packuswb  mm0, mm7    // MM0 -> final pixel (bytes)


 movd [edi], mm0

 add esi, 4
 add edi, 4

 dec ecx
 jnz @rLoop

 emms
 pop ebx
 pop edi
 pop esi
end;

//---------------------------------------------------------------------------
procedure RenderLineDiffuse(Source, Dest: Pointer; Count: Integer;
 Diffuse: Longword); stdcall;
{$ifdef fpc} assembler;{$endif}
asm
 push esi
 push edi
 push ebx

 mov esi, Source       // ESI -> source pointer
 mov edi, Dest         // EDI -> destination pointer
 mov ecx, Count        // ECX -> a number of pixels to process

 pxor mm7, mm7         // MM7 -> zero register

 mov eax, 0FFFFFFFFh
 movd mm6, eax
 punpcklbw mm6, mm7    // MM6 -> 255,255,255,255 (words)

 mov eax, 01010101h
 movd mm0, eax
 punpcklbw mm0, mm7    // MM0 -> 1, 1, 1, 1 (words)

 paddusw mm6, mm0      // MM6 -> 256,256,256,256 (words)

 mov eax, Diffuse
 movd mm5, eax
 punpcklbw mm5, mm7    // MM5 -> diffuse color (words)

 // Pixel processing loop.
 // On entry, these registers are defined:
 //  ESI - source
 //  EDI - dest
 //  ECX - pixel count
 //   MM5 - diffuse color
 //   MM6 - 256,256,256,256
 //   MM7 - zero
@rLoop:
 mov eax, [esi]        // EAX -> source pixel

 movd mm0, eax
 punpcklbw mm0, mm7    // MM0 -> source pixel (words)

 pmullw mm0, mm5
 psrlw mm0, 8          // MM0 -> "diffused" pixel (words)

 movq mm1, mm0
 packuswb mm1, mm7
 movd eax, mm1         // eax -> diffused pixel

 // extract alpha-channel from diffused pixel
 shr eax, 24
 mov ebx, eax
 shl ebx, 8
 or eax, ebx
 shl ebx, 8
 or eax, ebx

 movd mm4, eax
 punpcklbw mm4, mm7    // MM4 -> alpha, alpha, alpha (words)

 movd mm3, [edi]
 punpcklbw mm3, mm7    // MM3 -> dest pixel (words)

 pmullw mm0, mm4       // MM0 -> source pixel, multiplied by alpha-channel
 psrlw mm0, 8

 movq mm1, mm6
 psubusw mm1, mm4      // MM1 -> inverse alpha channel (words)

 pmullw mm3, mm1
 psrlw mm3, 8          // MM3 -> dest pixel, multiplied by inverse alpha-channel

 paddusw mm0, mm3


 packuswb  mm0, mm7    // MM0 -> final pixel (bytes)


 movd [edi], mm0

 add esi, 4
 add edi, 4

 dec ecx
 jnz @rLoop

 emms
 pop ebx
 pop edi
 pop esi
end;

//---------------------------------------------------------------------------
function BlendPixels(Px0, Px1: Longword; Alpha: Integer): Longword; stdcall;
{$ifdef fpc} assembler;{$endif}
asm
 pxor mm7, mm7

 mov eax, 0FFFFFFFFh
 movd mm6, eax
 punpcklbw mm6, mm7    // MM6 -> 255,255,255,255 (words)

 mov eax, 01010101h
 movd mm0, eax
 punpcklbw mm0, mm7    // MM0 -> 1, 1, 1, 1 (words)

 paddusw mm6, mm0      // MM6 -> 256,256,256,256 (words)

 mov eax, Alpha
 and eax, 0FFh
 mov ecx, eax
 shl ecx, 8
 or  eax, ecx
 shl ecx, 8
 or  eax, ecx
 shl ecx, 8
 or eax, ecx

 movd mm2, eax
 punpcklbw mm2, mm7    // MM2 -> alpha,alpha,alpha

 movd mm0, Px0
 movd mm1, Px1

 punpcklbw mm0, mm7
 punpcklbw mm1, mm7

 pmullw mm0, mm2
 psrlw mm0, 8

 psubusw mm6, mm2

 pmullw mm1, mm6
 psrlw mm1, 8

 paddusw mm0, mm1
 packuswb  mm0, mm7

 movd eax, mm0

 emms

 mov Result, eax
end;

//---------------------------------------------------------------------------
procedure ShrinkLine2x(Src0, Src1, Dest: Pointer;
 PixCount: Integer); stdcall;
begin
 asm
  push edi
  push esi
  push ebx
  mov ecx, PixCount
  mov esi, Src0
  mov edx, Src1
  mov edi, Dest
  pxor mm7, mm7
 @ConvLoop:
  movd mm0, [esi]
  punpcklbw mm0, mm7
  movd mm1, [esi + 4]
  punpcklbw mm1, mm7
  paddsw mm0, mm1
  movd mm2, [edx]
  punpcklbw mm2, mm7
  movd mm3, [edx + 4]
  punpcklbw mm3, mm7
  paddsw mm0, mm2
  paddsw mm0, mm3
  psrlw  mm0, 2
  packuswb  mm0, mm7
  movd [edi], mm0
  add esi, 8
  add edx, 8
  add edi, 4
  dec ecx
  jnz @ConvLoop
  emms
  pop ebx
  pop esi
  pop edi
 end;
end;

//---------------------------------------------------------------------------
function Pixel2Gray(Pixel: Longword): Longword; stdcall;
{$ifdef fpc} assembler;{$endif}
const
 rConst = 5;
 gConst = 8;
 bConst = 3;
asm
 push ebx

 mov eax, Pixel
 mov ecx, eax

 and eax, 0FFh
 imul eax, rConst
 mov ebx, eax

 mov eax, ecx
 shl eax, 16
 shr eax, 24
 imul eax, gConst
 add ebx, eax

 mov eax, ecx
 shl eax, 8
 shr eax, 24
 imul eax, bConst
 add ebx, eax

 shr ebx, 4

 mov Result, ebx

 pop ebx
end;

//---------------------------------------------------------------------------
function Pixel2GrayEx(Pixel: Cardinal): Real;
begin
 Result:= ((Pixel and $FF) * 0.3 + ((Pixel shr 8) and $FF) * 0.59 +
  ((Pixel shr 16) and $FF) * 0.11) / 255.0;
end;

//---------------------------------------------------------------------------
procedure ExtractAlpha(Src1, Src2, Bk1, Bk2: Real; out Alpha, Px: Real);
begin
 Alpha:= (1.0 - (Src2 - Src1)) / (Bk2 - Bk1);

 Px:= Src1;
 if (Alpha > 0.0) then
  Px:= (Src1 - (1.0 - Alpha) * Bk1) / Alpha;
end;

//---------------------------------------------------------------------------
procedure FindAlphaChannel(Dest, Image0, Image1: TBitmap; Bk1, Bk2: Cardinal);
var
 Index   : Integer;
 ScanIndx: Integer;

 BackValue1: Real;
 BackValue2: Real;

 Pixel1: Real;
 Pixel2: Real;

 Pixel : Real;
 Alpha : Real;

 Read0: PCardinal;
 Read1: PCardinal;
 Write: PCardinal;

 Color: Cardinal;
begin
 BackValue1:= Pixel2GrayEx(Bk1);
 BackValue2:= Pixel2GrayEx(Bk2);

 if (Image0.PixelFormat <> pf32bit) then Image0.PixelFormat:= pf32bit;
 if (Image1.PixelFormat <> pf32bit) then Image1.PixelFormat:= pf32bit;

 Dest.Width := Image0.Width;
 Dest.Height:= Image0.Height;
 if (Dest.PixelFormat <> pf32bit) then Dest.PixelFormat:= pf32bit;

 for ScanIndx:= 0 to Dest.Height - 1 do
  begin
   Read0:= Image0.Scanline[ScanIndx];
   Read1:= Image1.Scanline[ScanIndx];
   Write:= Dest.Scanline[ScanIndx];

   for Index:= 0 to Dest.Width - 1 do
    begin
     // retreive source grayscale pixels
     Pixel1:= Pixel2GrayEx(Read0^);
     Pixel2:= Pixel2GrayEx(Read1^);

     // calculate alpha-value and original pixel
     ExtractAlpha(Pixel1, Pixel2, BackValue1, BackValue2, Alpha, Pixel);

     // convert normalized pixel to color index
     Color:= Round(Pixel * 255.0);
     // prepare a 24-bit RGB color
     Color:= Color or (Color shl 8) or (Color shl 16);
     // add alpha-channel to 24-bit RGB color and write it to destination
     Write^:= Color or (Round(Alpha * 255.0) shl 24);

     // move through pixels
     Inc(Read0);
     Inc(Read1);
     Inc(Write);
    end;
  end;
end;

//---------------------------------------------------------------------------
procedure ClearBitmap(Image: TBitmap; Color: Longword);
var
 j, i: Integer;
 px: PCardinal;
begin
 if (Image.PixelFormat <> pf32bit) then Image.PixelFormat:= pf32bit;

 Color:= DisplaceRB(Color);

 for j:= 0 to Image.Height - 1 do
  begin
   px:= Image.Scanline[j];
   for i:= 0 to Image.Width - 1 do
    begin
     px^:= Color;
     Inc(px);
    end;
  end;
end;

//---------------------------------------------------------------------------
procedure UnmaskAlpha(Dest: TBitmap);
var
 i, j: Integer;
 pl: PLongword;
begin
 Dest.PixelFormat:= pf32bit;
 for j:= 0 to Dest.Height - 1 do
  begin
   pl:= Dest.Scanline[j];
   for i:= 0 to Dest.Width - 1 do
    begin
     pl^:= pl^ or $FF000000;
     Inc(pl);
    end;
  end;
end;

//---------------------------------------------------------------------------
procedure TileBitmap(Dest, Source: TBitmap; const TexSize, InPSize,
 OutPSize: TPoint; NeedMask: Boolean; MaskColor: Cardinal; Tolerance: Integer);
var
 SrcInRow: Integer;
 SrcInCol: Integer;
 SrcCount: Integer;
 DstInRow: Integer;
 DstInCol: Integer;
 ImgInTex: Integer;
 TexCount: Integer;
 AuxMem  : Pointer;
 AuxPitch: Integer;
 SrcIndex: Integer;
 TexIndex: Integer;
 PatIndex: Integer;
 DestPt  : TPoint;
 SrcPt   : TPoint;
 Index   : Integer;
 MemAddr : Pointer;
 DestIndx: Integer;
begin
 // Step 1. Determine source attributes
 SrcInRow:= Source.Width div InPSize.X;
 SrcInCol:= Source.Height div InPSize.Y;
 SrcCount:= SrcInRow * SrcInCol;

 // Step 2. Determine destination attributes
 DstInRow:= TexSize.X div OutPSize.X;
 DstInCol:= TexSize.Y div OutPSize.Y;
 ImgInTex:= DstInRow * DstInCol;
 TexCount:= Ceil(SrcCount / ImgInTex);

 // Step 3. Allocate auxiliary memory
 AuxPitch:= InPSize.X * 4;
 AuxMem  := AllocMem(AuxPitch);

 // Step 4. Prepare source and destination images
 if (Source.PixelFormat <> pf32bit) then UnmaskAlpha(Source);

 Dest.Width := TexSize.X;
 Dest.Height:= TexSize.Y * TexCount;
 ClearBitmap(Dest, $00000000);

 // Step 5. Place individual patterns
 SrcIndex:= 0;
 for TexIndex:= 0 to TexCount - 1 do
  for PatIndex:= 0 to ImgInTex - 1 do
   begin
    DestPt.X:= (PatIndex mod DstInRow) * OutPSize.X;
    DestPt.Y:= ((PatIndex div DstInRow) mod DstInCol) * OutPSize.Y;
    SrcPt.X := (SrcIndex mod SrcInRow) * InPSize.X;
    SrcPt.Y := ((SrcIndex div SrcInRow) mod SrcInCol) * InPSize.Y;

    // render scanlines
    for Index:= 0 to InPSize.Y - 1 do
     begin
      // prepare source pointer
      MemAddr:= Pointer(Integer(Source.Scanline[(Index + SrcPt.Y)]) + (SrcPt.X * 4));

      if (NeedMask) then
       begin
        LineConvMasked(MemAddr, AuxMem, InPSize.X, Tolerance,
         DisplaceRB(MaskColor));
       end else Move(MemAddr^, AuxMem^, InPSize.X * 4);

      DestIndx:= DestPt.Y + (TexSize.Y * TexIndex) + Index;
      MemAddr:= Pointer(Integer(Dest.Scanline[DestIndx]) + (DestPt.X * 4));
      Move(AuxMem^, MemAddr^, AuxPitch);
     end;

    Inc(SrcIndex);
    if (SrcIndex >= SrcCount) then Break;
   end;

 // Step 6. Release auxiliary memory
 FreeMem(AuxMem);
end;

//---------------------------------------------------------------------------
end.
