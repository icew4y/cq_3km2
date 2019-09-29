unit AsphyreConv;
//---------------------------------------------------------------------------
// AsphyreConv.pas                                      Modified: 23-May-2008
// Asphyre Pixel Format conversion                                Version 1.4
//---------------------------------------------------------------------------
// Important Notice:
//
// If you modify/use this code or one of its parts either in original or
// modified form, you must comply with Mozilla Public License v1.1,
// specifically section 3, "Distribution Obligations". Failure to do so will
// result in the license breach, which will be resolved in the court.
// Remember that violating author's rights is considered a serious crime in
// many countries. Thank you!
//
// !! Please *read* Mozilla Public License 1.1 document located at:
//  http://www.mozilla.org/MPL/
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
//
// The Original Code is AsphyreConv.pas.
//
// The Initial Developer of the Original Code is Yuriy Kotsarenko.
// Portions created by M. Sc. Yuriy Kotsarenko are Copyright (C) 2007 - 2008,
// Yuriy Kotsarenko. All Rights Reserved.
//---------------------------------------------------------------------------
interface

//---------------------------------------------------------------------------
uses
  Windows, AsphyreTypes, AsphyreUtils, TransformUtils;
//------------------------------------------------------------------
// PixelXto32()
//
// Converts a pixel from an arbitrary format to A8R8G8B8 (32-bit).
//---------------------------------------------------------------------------
function PixelXto32(Source: Pointer;
  SourceFormat: TAsphyrePixelFormat): Cardinal;

//---------------------------------------------------------------------------
// Pixel32toX()
//
// Converts a pixel from A8R8G8B8 (32-bit) format to an arbitrary format.
//---------------------------------------------------------------------------
procedure Pixel32toX(Source: Cardinal; Dest: Pointer;
  DestFormat: TAsphyrePixelFormat);

//---------------------------------------------------------------------------
// PixelXto32Array()
//
// Converts an array of pixels from A8R8G8B8 (32-bit) format to an arbitrary
// format.
//---------------------------------------------------------------------------
procedure PixelXto32Array(Source, Dest: Pointer;
  SourceFormat: TAsphyrePixelFormat; Elements: Integer);

//---------------------------------------------------------------------------
// Pixel32toX()
//
// Converts an array of pixels from A8R8G8B8 (32-bit) format to an
// arbitrary format.
//---------------------------------------------------------------------------
procedure Pixel32toXArray(Source, Dest: Pointer;
  DestFormat: TAsphyrePixelFormat; Elements: Integer);

//---------------------------------------------------------------------------
procedure ResetAlpha(Source: Pointer; Count: Integer); stdcall;
procedure Pixel16to32Array(Source, Dest: PByte; Count: Integer); stdcall;

implementation

//---------------------------------------------------------------------------
uses
  AsphyreFormatInfo;
var
  mask_r: Int64 = $F800F800F800F800; // 红色掩码
  mask_g: Int64 = $07E007E007E007E0; // 绿色掩码
  mask_b: Int64 = $001F001F001F001F; // 蓝色掩码
  maskh: Int64 = $7FE07FE07FE07FE0; // 高位掩码, 0111111111100000
  maskl: Int64 = $001F001F001F001F; // 低位掩码, 0000000000011111
  mask: Int64 = $FFFFFFFFFFFFFFFF;
  MaskByte1: Int64 = $FF000000FF000000;
  MaskByte2: Int64 = $00FFFFFF00FFFFFF;

//---------------------------------------------------------------------------

function PixelXto32(Source: Pointer;
 SourceFormat: TAsphyrePixelFormat): Cardinal;
const
 rPos: Integer = 16;
 rMask: Cardinal = $FF;
var
 Bits : Integer;
 Value: Cardinal;
 Info : PFormatBitInfo;
 Mask : Cardinal;
begin
 Result:= 0;

 if (SourceFormat = apf_A16B16G16R16) then
  begin
   Value:= PCardinal(Source)^;

   Result:=
    (((Value shl 16) shr 24) shl 16) or
    ((Value shr 24) shl 8);

   Value:= PCardinal(Integer(Source) + 4)^;

   Result:= Result or
    ((Value shl 16) shr 24) or
    ((Value shr 24) shl 24);

   Exit;
  end;

 Bits:= AsphyrePixelFormatBits[SourceFormat];
 if (Bits < 8)or(Bits > 32) then Exit;

 Value:= 0;
 Move(Source^, Value, Bits div 8);

 case SourceFormat of
  apf_R8G8B8, apf_X8R8G8B8:
   Result:= Value or $FF000000;

  apf_A8R8G8B8:
   Result:= Value;

  apf_A8:
   Result:= Value shl 24;

  apf_L8:
   Result:= Value or (Value shl 8) or (Value shl 16) or $FF000000;

  apf_A8L8:
   begin
    Result:= Value and $FF;
    Result:= Result or (Result shl 8) or (Result shl 16) or
     ((Value shr 8) shl 24)
   end;

  apf_A4L4:
   begin
    Result:= ((Value and $0F) * 255) div 15;
    Result:= Result or (Result shl 8) or (Result shl 16) or
     ((((Value shr 4) * 255) div 15) shl 24);
   end;

  apf_L16:
   begin
    Result:= Value shr 8;
    Result:= Result or (Result shl 8) or (Result shl 16) or $FF000000;
   end;

  apf_A8B8G8R8:
   Result:= (Value and $FF00FF00) or ((Value shr 16) and $FF) or
    ((Value and $FF) shl 16);

  apf_X8B8G8R8:
   Result:= (Value and $0000FF00) or ((Value shr 16) and $FF) or
    ((Value and $FF) shl 16) or ($FF000000);

  apf_A6L2:
   begin
    Result:= ((Value and 3) * 255) div 3;
    Result:= Result or (Result shl 8) or (Result shl 16) or
     ((((Value shr 2) * 255) div 63) shl 24);
   end;

  else
   begin
    Info:= @FormatInfo[SourceFormat];

    // -> Blue Component
    if (Info.bNo > 0) then
     begin
      Mask:= (1 shl Info.bNo) - 1;
      Result:= (((Value shr Info.bAt) and Mask) * 255) div Mask;
     end else Result:= 255;

    // -> Green Component
    if (Info.gNo > 0) then
     begin
      Mask:= (1 shl Info.gNo) - 1;
      Result:= Result or
       (((((Value shr Info.gAt) and Mask) * 255) div Mask) shl 8);
     end else Result:= Result or $FF00;

    // -> Red Component
    if (Info.rNo > 0) then
     begin
      Mask:= (1 shl Info.rNo) - 1;
      Result:= Result or
       (((((Value shr Info.rAt) and Mask) * 255) div Mask) shl 16);
     end else Result:= Result or $FF0000;

    // -> Alpha Component
    if (Info.aNo > 0) then
     begin
      Mask:= (1 shl Info.aNo) - 1;
      Result:= Result or
       (((((Value shr Info.aAt) and Mask) * 255) div Mask) shl 24);
     end else Result:= Result or $FF000000;
   end;
 end;
end;

//---------------------------------------------------------------------------

function ComputeLuminance(Value: Cardinal): Single;
begin
  Result := ((Value and $FF) * 0.11 + ((Value shr 8) and $FF) * 0.59 +
    ((Value shr 16) and $FF) * 0.3) / 255.0;
end;

//---------------------------------------------------------------------------

procedure Pixel32toX(Source: Cardinal; Dest: Pointer;
  DestFormat: TAsphyrePixelFormat);
var
  Bits: Integer;
  Value: Cardinal;
  Info: PFormatBitInfo;
  Mask: Cardinal;
begin
  if (DestFormat = apf_A16B16G16R16) then
  begin
    PCardinal(Dest)^ :=
      (((((Source shl 16) shr 24) * $FFFF) div $FF) shl 16) or
      ((((Source shl 8) shr 24) * $FFFF) div $FF);

    PCardinal(Integer(Dest) + 4)^ :=
      ((((Source shl 24) shr 24) * $FFFF) div $FF) or
      ((((Source shr 24) * $FFFF) div $FF) shl 16);

    Exit;
  end;

  Bits := AsphyrePixelFormatBits[DestFormat];
  if (Bits < 8) or (Bits > 32) then Exit;

  Value := 0;

  case DestFormat of
    apf_R8G8B8, apf_X8R8G8B8, apf_A8R8G8B8:
      Value := Source;

    apf_A8:
      Value := Source shr 24;

    apf_A8B8G8R8:
      Value := (Source and $FF00FF00) or ((Source shr 16) and $FF) or
        ((Source and $FF) shl 16);

    apf_X8B8G8R8:
      Value := (Source and $0000FF00) or ((Source shr 16) and $FF) or
        ((Source and $FF) shl 16);

    apf_L8:
      Value := Round(ComputeLuminance(Source) * 255.0);

    apf_A8L8:
      Value := ((Source shr 24) shl 8) or Round(ComputeLuminance(Source) * 255.0);

    apf_A4L4:
      Value := ((Source shr 28) shl 4) or Round(ComputeLuminance(Source) * 15.0);

    apf_L16:
      Value := Round(ComputeLuminance(Source) * 65535.0);

    apf_A6L2:
      Value := ((Source shr 26) shl 2) or Round(ComputeLuminance(Source) * 3.0);

  else
    begin
      Info := @FormatInfo[DestFormat];

    // -> Blue Component
      if (Info.bNo > 0) then
      begin
        Mask := (1 shl Info.bNo) - 1;
        Value := (((Source and $FF) * Mask) div 255) shl Info.bAt;
      end;

    // -> Green Component
      if (Info.gNo > 0) then
      begin
        Mask := (1 shl Info.gNo) - 1;
        Value := Value or
          ((((Source shr 8) and $FF) * Mask) div 255) shl Info.gAt;
      end;

    // -> Red Component
      if (Info.rNo > 0) then
      begin
        Mask := (1 shl Info.rNo) - 1;
        Value := Value or
          ((((Source shr 16) and $FF) * Mask) div 255) shl Info.rAt;
      end;

    // -> Alpha Component
      if (Info.aNo > 0) then
      begin
        Mask := (1 shl Info.aNo) - 1;
        Value := Value or
          ((((Source shr 24) and $FF) * Mask) div 255) shl Info.aAt;
      end;
    end;
  end;

  Move(Value, Dest^, Bits div 8);
end;

//---------------------------------------------------------------------------

procedure PixelXto32Array(Source, Dest: Pointer;
  SourceFormat: TAsphyrePixelFormat; Elements: Integer);
var
  Bits: Integer;
  SourcePx: Pointer;
  DestPx: PCardinal;
  i, BytesPerPixel: Integer;
begin
  Bits := AsphyrePixelFormatBits[SourceFormat];
  if (Bits < 8) then Exit;

  BytesPerPixel := Bits div 8;

  SourcePx := Source;
  DestPx := Dest;
  for i := 0 to Elements - 1 do
  begin
    DestPx^ := PixelXto32(SourcePx, SourceFormat);

    Inc(Integer(SourcePx), BytesPerPixel);
    Inc(DestPx);
  end;
end;

//---------------------------------------------------------------------------

procedure Pixel32toXArray(Source, Dest: Pointer;
  DestFormat: TAsphyrePixelFormat; Elements: Integer);
var
  Bits: Integer;
  SourcePx: PCardinal;
  DestPx: Pointer;
  i, BytesPerPixel: Integer;
begin
  Bits := AsphyrePixelFormatBits[DestFormat];
  if (Bits < 8) then Exit;

  BytesPerPixel := Bits div 8;

  SourcePx := Source;
  DestPx := Dest;
  for i := 0 to Elements - 1 do
  begin
    Pixel32toX(SourcePx^, DestPx, DestFormat);

    Inc(SourcePx);
    Inc(Integer(DestPx), BytesPerPixel);
  end;
end;

//---------------------------------------------------------------------------

procedure Pixel16to32Array(Source, Dest: PByte; Count: Integer);
var
  nMMXM: Integer;
  nSSEM: Integer;
  nMMXW: Integer;
  nSSEW: Integer;
  nX: Integer;
  k: Integer;
  RGBQuad: PRGBQuad;
  pSrc, pDst: PByte;
begin
  pSrc := Source;
  pDst := Dest;
  {
  for nX := 0 to Count - 1 do begin //剩余处理
    RGBQuad := PRGBQuad(pDst);
    if PWord(pSrc)^ > 0 then begin
      RGBQuad.rgbRed := PWord(pSrc)^ and $F800 shr 8;
      RGBQuad.rgbGreen := PWord(pSrc)^ and $07E0 shr 3;
      RGBQuad.rgbBlue := PWord(pSrc)^ and $001F shl 3;
      RGBQuad.rgbReserved := 255;
    end else begin
      PCardinal(RGBQuad)^ := 0;
    end;
    Inc(pSrc, 2);
    Inc(pDst, 4);
  end;}

  if (cfSSE2 in CPUInfo.Features) then begin
    nSSEM := Count mod 8;
    nSSEW := Count div 8;
  end else begin
    nSSEM := 0;
    nSSEW := 0;
  end;

  if nSSEW > 0 then begin
    nMMXM := nSSEM mod 4;
    nMMXW := nSSEM div 4;
  end else begin
    nMMXM := Count mod 4;
    nMMXW := Count div 4;
  end;

  k := Count;
  if (cfSSE2 in CPUInfo.Features) then begin
    for nX := 0 to nSSEW - 1 do begin
      asm
         mov     edx,  pDst		// edx = 目的指针
         mov     ecx,  pSrc		// ecx = 源指针

         movlps xmm4, mask_r
         movhps xmm4, mask_r

         movlps xmm5, mask_g
         movhps xmm5, mask_g

         movlps xmm6, mask_b
         movhps xmm6, mask_b

         movdqu xmm0, [ecx]
         movdqu xmm7, xmm0				// save src 4 X 16bit color data

         pand xmm0, xmm4				// & r mask   r := pSrc^ and $F800
         psrlw xmm0, 8				// >> 8       r := r shr 8;

         movdqu xmm1, xmm7				// restore mm1 data

         pand xmm1, xmm5				// & g mask   g := pSrc^ and $07E0;
         psrlw xmm1, 3				// >> 3       g := g shr 3;
         movdqu xmm2, xmm7				// restore mm1 data

         pand xmm2, xmm6				// & b mask   b := pSrc^ and $001F;
         psllw xmm2, 3				// << 3       b := b shl 3;

         psllq xmm1, 8				// << 8       g := g shl 8;

         por xmm1, xmm2				// 4 pixel b\g  g := g or b;
         movdqu xmm7, xmm1				// save mm1

         punpcklwd xmm1, xmm0
         movdqu [edx], xmm1
         add	edx, 16					// write 4 X 32bit

         movdqu xmm1, xmm7

         punpckhwd xmm1, xmm0
         movdqu [edx], xmm1

         add	ecx, 16					// read 4 X 16bit
         add	edx, 16					// write 4 X 32bit

         sub     k,   8
         mov     Integer ptr[pSrc], ecx
         mov     Integer ptr[pDst], edx
      end;
    end;
  end;


  for nX := 0 to nMMXW - 1 do begin
    asm
       mov     edx,  pDst		// edx = 目的指针
       mov     ecx,  pSrc		// ecx = 源指针

       movq mm4, mask_r
       movq mm5, mask_g
       movq mm6, mask_b

       movq mm0, [ecx]
       movq mm7, mm0				// save src 4 X 16bit color data

       pand mm0, mm4				// & r mask   r := pSrc^ and $F800
       psrlw mm0, 8				// >> 8       r := r shr 8;

       movq mm1, mm7				// restore mm1 data

       pand mm1, mm5				// & g mask   g := pSrc^ and $07E0;
       psrlw mm1, 3				// >> 3       g := g shr 3;
       movq mm2, mm7				// restore mm1 data

       pand mm2, mm6				// & b mask   b := pSrc^ and $001F;
       psllw mm2, 3				// << 3       b := b shl 3;

       psllq mm1, 8				// << 8       g := g shl 8;

       por mm1, mm2				// 4 pixel b\g  g := g or b;
       movq mm7, mm1				// save mm1

       punpcklwd mm1, mm0
       movq [edx], mm1
       add	edx, 8					// write 4 X 32bit

       movq mm1, mm7

       punpckhwd mm1, mm0
       movq [edx], mm1

       add	ecx, 8					// read 4 X 16bit
       add	edx, 8					// write 4 X 32bit

       sub     k,   4
       mov     Integer ptr[pSrc], ecx
       mov     Integer ptr[pDst], edx
    end;
  end;

  asm
    emms
  end;

  for nX := 1 to k do begin //剩余处理
    RGBQuad := PRGBQuad(pDst);
    if PWord(pSrc)^ > 0 then begin
      RGBQuad.rgbRed := PWord(pSrc)^ and $F800 shr 8;
      RGBQuad.rgbGreen := PWord(pSrc)^ and $07E0 shr 3;
      RGBQuad.rgbBlue := PWord(pSrc)^ and $001F shl 3;
      RGBQuad.rgbReserved := 0;
    //end else begin
      //PCardinal(RGBQuad)^ := 0;
    end;
    Inc(pSrc, 2);
    Inc(pDst, 4);
  end;
  {
  pDst := Dest;
  for nX := 0 to Count - 1 do begin
    if PCardinal(pDst)^ > 0 then
      PCardinal(pDst)^ := PCardinal(pDst)^ or $FF000000;
    Inc(pDst, 4);
  end; }
end;

procedure ResetAlpha(Source: Pointer; Count: Integer);
var
  I: Integer;
  ScrP: PCardinal;
begin
  {ScrP := Source;
  for I := 0 to Count - 1 do begin
    ScrP^ := ScrP^ or $FF000000 and $00FFFFFF;
    //ScrP^ :=   ScrP^ and $00FFFFFF;
    //ScrP^ := PixelXto32(ScrP, apf_X8B8G8R8);
    {ScrP^ := PCardinal((ScrP^ and $0000FF00) or ((ScrP^ shr 16) and $FF) or
      ((ScrP^ and $FF) shl 16) or ($FF000000))^; }
    {Inc(PByte(ScrP), 4);
  end;}
  //if (not (cfSSE2 in CPUInfo.Features)) then begin
  asm
       mov ecx, Count
       mov edx, Source
     @MMX:
       movq mm0, [edx]
       //POR mm0,MaskByte1
       PAND mm0,MaskByte2


       movq [edx], mm0
       add edx, 8
       sub ecx, 2
       jnz @MMX
      @Exit:
       emms
  end;
  {end else begin
    asm
       mov ecx, Count
       mov edx, Source
       movlps xmm1,MaskByte
       movhps xmm1,MaskByte
     @SSE:
       cmp ecx, 3
       jle @MMX
       movdqu xmm0, [edx]
       PCMPGTD xmm0, xmm1
       movdqu [edx], xmm0
       add edx, 16
       sub ecx, 4
       jnz @SSE
     @MMX:
       cmp ecx, 0
       jle @Exit
       movq mm0, [edx]
       por mm0, MaskByte
       movq [edx], mm0
       add edx, 8
       sub ecx, 2
       jnz @MMX
     @Exit:
       emms
    end;
  end;}
end;

end.

