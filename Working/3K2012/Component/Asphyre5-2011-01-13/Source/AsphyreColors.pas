unit AsphyreColors;
//---------------------------------------------------------------------------
// AsphyreColors.pas                                    Modified: 30-Oct-2007
// Fixed-point 24:8 true color implementation                    Version 1.02
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
// The Original Code is AsphyreColors.pas.
//
// The Initial Developer of the Original Code is M. Sc. Yuriy Kotsarenko.
// Portions created by M. Sc. Yuriy Kotsarenko are Copyright (C) 2007,
// M. Sc. Yuriy Kotsarenko. All Rights Reserved.
//---------------------------------------------------------------------------
interface

//---------------------------------------------------------------------------
type
  {$IFDEF VER185}
 TAsphyreColor = record
  r, g, b, a: Integer;
  end;
  {$ELSE}
 TAsphyreColor = record
  r, g, b, a: Integer;

  {$ifndef fpc}
  class operator Add(const a, b: TAsphyreColor): TAsphyreColor;
  class operator Subtract(const a, b: TAsphyreColor): TAsphyreColor;
  class operator Multiply(const a, b: TAsphyreColor): TAsphyreColor;
  class operator Divide(const a, b: TAsphyreColor): TAsphyreColor;

  class operator Multiply(const c: TAsphyreColor; k: Integer): TAsphyreColor;
  class operator Divide(const c: TAsphyreColor; k: Integer): TAsphyreColor;
  class operator Multiply(const c: TAsphyreColor; k: Single): TAsphyreColor;
  class operator Divide(const c: TAsphyreColor; k: Single): TAsphyreColor;

  class operator Implicit(const c: TAsphyreColor): Cardinal;
  class operator Implicit(c: Cardinal): TAsphyreColor;
  class operator Explicit(const c: TAsphyreColor): Cardinal;
  class operator Explicit(c: Cardinal): TAsphyreColor;
  {$endif}
 end;
{$ENDIF}
//---------------------------------------------------------------------------
 TAsphyreColor4 = array[0..3] of TAsphyreColor;

//---------------------------------------------------------------------------
function cColor(r, g, b, a: Integer): TAsphyreColor; overload;
function cColor(Gray, Alpha: Integer): TAsphyreColor; overload;
function cColor(Gray: Integer): TAsphyreColor; overload;
function cNoAlpha(const Src: TAsphyreColor): TAsphyreColor;
function cClamp(const c: TAsphyreColor): TAsphyreColor;
function cWrap(const c: TAsphyreColor): TAsphyreColor;
function cBlend(const Src, Dest: TAsphyreColor;
 Alpha: Integer): TAsphyreColor;
function cLerp(const Src, Dest: TAsphyreColor;
 Alpha: Single): TAsphyreColor;
function cCubic(const c1, c2, c3, c4: TAsphyreColor;
 Theta: Single): TAsphyreColor;
function cDarken(const c: TAsphyreColor; Light: Single): TAsphyreColor;
function cModulateAlpha(const c: TAsphyreColor; Alpha: Single): TAsphyreColor;
function cNegative(const c: TAsphyreColor): TAsphyreColor;
//---------------------------------------------------------------------------
{$IFDEF VER185}
function AspColorAdd(const a, b: TAsphyreColor): TAsphyreColor;
function AspColorSubtract(const a, b: TAsphyreColor): TAsphyreColor;
function AspColorMultiply(const a, b: TAsphyreColor): TAsphyreColor; overload;
function AspColorDivide(const a, b: TAsphyreColor): TAsphyreColor; overload;

function AspColorMultiply(const c: TAsphyreColor; k: Integer): TAsphyreColor; overload;
function AspColorDivide(const c: TAsphyreColor; k: Integer): TAsphyreColor;  overload;
function AspColorMultiply(const c: TAsphyreColor; k: Single): TAsphyreColor; overload;
function AspColorDivide(const c: TAsphyreColor; k: Single): TAsphyreColor; overload;

function AspColorToCardinal(const c: TAsphyreColor): Cardinal;
function CardinalToAspColor(c: Cardinal): TAsphyreColor;
{$else ifdef fpc}
operator + (const a, b: TAsphyreColor) c: TAsphyreColor;
operator - (const a, b: TAsphyreColor) c: TAsphyreColor;
operator * (const a, b: TAsphyreColor) c: TAsphyreColor;
operator / (const a, b: TAsphyreColor) c: TAsphyreColor;
operator * (const c: TAsphyreColor; k: Integer) d: TAsphyreColor;
operator / (const c: TAsphyreColor; k: Integer) d: TAsphyreColor;
operator * (const c: TAsphyreColor; k: Single) d: TAsphyreColor;
operator / (const c: TAsphyreColor; k: Single) d: TAsphyreColor;
operator := (c: Cardinal) d: TAsphyreColor;
operator := (const c: TAsphyreColor) d: Cardinal;
{$endif}

//---------------------------------------------------------------------------
implementation

//---------------------------------------------------------------------------
uses
 AsphyreUtils, SysUtils;

//---------------------------------------------------------------------------
const
 ColorMax = 65535;
{$IFDEF VER185}
function Inc8to16(Value: Integer): Integer;
begin
 Result:= (Value * ColorMax) div 255;
end;
{$ELSE}
//---------------------------------------------------------------------------
function Inc8to16(Value: Integer): Integer; inline;
begin
 Result:= (Value * ColorMax) div 255;
end;
{$ENDIF}
//---------------------------------------------------------------------------
function cColor(r, g, b, a: Integer): TAsphyreColor;
begin
 Result.r:= Inc8to16(r);
 Result.g:= Inc8to16(g);
 Result.b:= Inc8to16(b);
 Result.a:= Inc8to16(a);
end;

//---------------------------------------------------------------------------
function cColor(Gray, Alpha: Integer): TAsphyreColor;
begin
 Result:= cColor(Gray, Gray, Gray, Alpha);
end;

//---------------------------------------------------------------------------
function cColor(Gray: Integer): TAsphyreColor;
begin
 Result:= cColor(Gray, 255);
end;

//---------------------------------------------------------------------------
function cClamp(const c: TAsphyreColor): TAsphyreColor;
begin
 Result.r:= MinMax2(c.r, 0, ColorMax);
 Result.g:= MinMax2(c.g, 0, ColorMax);
 Result.b:= MinMax2(c.b, 0, ColorMax);
 Result.a:= MinMax2(c.a, 0, ColorMax);
end;

//---------------------------------------------------------------------------
function cWrap(const c: TAsphyreColor): TAsphyreColor;
begin
 Result:= c;
 if (Result.r > ColorMax) then Result.r:= ColorMax - (Result.r - ColorMax);
 if (Result.r < 0) then Result.r:= -Result.r;

 if (Result.g > ColorMax) then Result.g:= ColorMax - (Result.g - ColorMax);
 if (Result.g < 0) then Result.g:= -Result.g;

 if (Result.b > ColorMax) then Result.b:= ColorMax - (Result.b - ColorMax);
 if (Result.b < 0) then Result.b:= -Result.b;

 if (Result.a > ColorMax) then Result.a:= ColorMax - (Result.a - ColorMax);
 if (Result.a < 0) then Result.a:= -Result.a;
end;

//---------------------------------------------------------------------------
function cBlend(const Src, Dest: TAsphyreColor;
 Alpha: Integer): TAsphyreColor;
begin
 Result.r:= Src.r + iMul8(Dest.r - Src.r, Alpha);
 Result.g:= Src.g + iMul8(Dest.g - Src.g, Alpha);
 Result.b:= Src.b + iMul8(Dest.b - Src.b, Alpha);
 Result.a:= Src.a + iMul8(Dest.a - Src.a, Alpha);
end;

//---------------------------------------------------------------------------
function cLerp(const Src, Dest: TAsphyreColor;
 Alpha: Single): TAsphyreColor;
begin
 Result.r:= Src.r + Round((Dest.r - Src.r) * Alpha);
 Result.g:= Src.g + Round((Dest.g - Src.g) * Alpha);
 Result.b:= Src.b + Round((Dest.b - Src.b) * Alpha);
 Result.a:= Src.a + Round((Dest.a - Src.a) * Alpha);
end;

//---------------------------------------------------------------------------
function cCubic(const c1, c2, c3, c4: TAsphyreColor;
 Theta: Single): TAsphyreColor;
begin
 Result.r:= Round(CatmullRom(c1.r, c2.r, c3.r, c4.r, Theta));
 Result.g:= Round(CatmullRom(c1.g, c2.g, c3.g, c4.g, Theta));
 Result.b:= Round(CatmullRom(c1.b, c2.b, c3.b, c4.b, Theta));
 Result.a:= Round(CatmullRom(c1.a, c2.a, c3.a, c4.a, Theta));
end;

//---------------------------------------------------------------------------
function cNoAlpha(const Src: TAsphyreColor): TAsphyreColor;
begin
 Result.r:= Src.r;
 Result.g:= Src.g;
 Result.b:= Src.b;
 Result.a:= 65535;
end;

//---------------------------------------------------------------------------
function cDarken(const c: TAsphyreColor; Light: Single): TAsphyreColor;
begin
 Result.r:= Round(c.r * Light);
 Result.g:= Round(c.g * Light);
 Result.b:= Round(c.b * Light);
 Result.a:= c.a;
end;

//---------------------------------------------------------------------------
function cModulateAlpha(const c: TAsphyreColor; Alpha: Single): TAsphyreColor;
begin
 Result.r:= c.r;
 Result.g:= c.g;
 Result.b:= c.b;
 Result.a:= Round(c.a * Alpha);
end;

//---------------------------------------------------------------------------
function cNegative(const c: TAsphyreColor): TAsphyreColor;
begin
 Result.r:= 65535 - c.r;
 Result.g:= 65535 - c.g;
 Result.b:= 65535 - c.b;
 Result.a:= c.a;
end;
{$IFDEF VER185}

function AspColorAdd(const a, b: TAsphyreColor): TAsphyreColor;
begin
 Result.r:= a.r + b.r;
 Result.g:= a.g + b.g;
 Result.b:= a.b + b.b;
 Result.a:= a.a + b.a;
end;

//---------------------------------------------------------------------------
function AspColorSubtract(const a, b: TAsphyreColor): TAsphyreColor;
begin
 Result.r:= a.r - b.r;
 Result.g:= a.g - b.g;
 Result.b:= a.b - b.b;
 Result.b:= a.a - b.a;
end;

//---------------------------------------------------------------------------
function AspColorMultiply(const a, b: TAsphyreColor): TAsphyreColor;
begin
 Result.r:= iMul16(a.r, b.r + 1);
 Result.g:= iMul16(a.g, b.g + 1);
 Result.b:= iMul16(a.b, b.b + 1);
 Result.a:= iMul16(a.a, b.a + 1);
end;

//---------------------------------------------------------------------------
function AspColorDivide(const a, b: TAsphyreColor): TAsphyreColor;
begin
 Result.r:= iDiv16(a.r, b.r);
 Result.g:= iDiv16(a.g, b.g);
 Result.b:= iDiv16(a.b, b.b);
 Result.a:= iDiv16(a.a, b.a);
end;

//---------------------------------------------------------------------------
function AspColorMultiply(const c: TAsphyreColor;
 k: Integer): TAsphyreColor;
begin
 Result.r:= c.r * k;
 Result.g:= c.g * k;
 Result.b:= c.b * k;
 Result.a:= c.a * k;
end;

//---------------------------------------------------------------------------
function AspColorDivide(const c: TAsphyreColor;
 k: Integer): TAsphyreColor;
begin
 Result.r:= c.r div k;
 Result.g:= c.g div k;
 Result.b:= c.b div k;
 Result.a:= c.a div k;
end;

//---------------------------------------------------------------------------
function AspColorMultiply(const c: TAsphyreColor;
 k: Single): TAsphyreColor;
begin
 Result.r:= Round(c.r * k);
 Result.g:= Round(c.g * k);
 Result.b:= Round(c.b * k);
 Result.a:= Round(c.a * k);
end;

//---------------------------------------------------------------------------
function AspColorDivide(const c: TAsphyreColor;
 k: Single): TAsphyreColor;
begin
 Result.r:= Round(c.r / k);
 Result.g:= Round(c.g / k);
 Result.b:= Round(c.b / k);
 Result.a:= Round(c.a / k);
end;

//---------------------------------------------------------------------------
function CardinalToAspColor(c: Cardinal): TAsphyreColor;
begin
 Result.r:= Inc8to16((c shr 16) and $FF);
 Result.b:= Inc8to16(c and $FF);
 Result.g:= Inc8to16((c shr 8) and $FF);
 Result.a:= Inc8to16((c shr 24) and $FF);
end;

//---------------------------------------------------------------------------
function AspColorToCardinal(const c: TAsphyreColor): Cardinal;
begin
 Result:= (c.b shr 8) or ((c.g shr 8) shl 8) or ((c.r shr 8) shl 16) or
  ((c.a shr 8) shl 24);
end;

{$ELSE}
//---------------------------------------------------------------------------
{$ifdef fpc}
operator + (const a, b: TAsphyreColor) c: TAsphyreColor;
{$else}
class operator TAsphyreColor.Add(const a, b: TAsphyreColor): TAsphyreColor;
{$endif}
begin
 Result.r:= a.r + b.r;
 Result.g:= a.g + b.g;
 Result.b:= a.b + b.b;
 Result.a:= a.a + b.a;
end;

//---------------------------------------------------------------------------
{$ifdef fpc}
operator - (const a, b: TAsphyreColor) c: TAsphyreColor;
{$else}
class operator TAsphyreColor.Subtract(const a, b: TAsphyreColor): TAsphyreColor;
{$endif}
begin
 Result.r:= a.r - b.r;
 Result.g:= a.g - b.g;
 Result.b:= a.b - b.b;
 Result.b:= a.a - b.a;
end;

//---------------------------------------------------------------------------
{$ifdef fpc}
operator * (const a, b: TAsphyreColor) c: TAsphyreColor;
{$else}
class operator TAsphyreColor.Multiply(const a, b: TAsphyreColor): TAsphyreColor;
{$endif}
begin
 Result.r:= iMul16(a.r, b.r + 1);
 Result.g:= iMul16(a.g, b.g + 1);
 Result.b:= iMul16(a.b, b.b + 1);
 Result.a:= iMul16(a.a, b.a + 1);
end;

//---------------------------------------------------------------------------
{$ifdef fpc}
operator / (const a, b: TAsphyreColor) c: TAsphyreColor;
{$else}
class operator TAsphyreColor.Divide(const a, b: TAsphyreColor): TAsphyreColor;
{$endif}
begin
 Result.r:= iDiv16(a.r, b.r);
 Result.g:= iDiv16(a.g, b.g);
 Result.b:= iDiv16(a.b, b.b);
 Result.a:= iDiv16(a.a, b.a);
end;

//---------------------------------------------------------------------------
{$ifdef fpc}
operator * (const c: TAsphyreColor; k: Integer) d: TAsphyreColor;
{$else}
class operator TAsphyreColor.Multiply(const c: TAsphyreColor;
 k: Integer): TAsphyreColor;
{$endif}
begin
 Result.r:= c.r * k;
 Result.g:= c.g * k;
 Result.b:= c.b * k;
 Result.a:= c.a * k;
end;

//---------------------------------------------------------------------------
{$ifdef fpc}
operator / (const c: TAsphyreColor; k: Integer) d: TAsphyreColor;
{$else}
class operator TAsphyreColor.Divide(const c: TAsphyreColor;
 k: Integer): TAsphyreColor;
{$endif}
begin
 Result.r:= c.r div k;
 Result.g:= c.g div k;
 Result.b:= c.b div k;
 Result.a:= c.a div k;
end;

//---------------------------------------------------------------------------
{$ifdef fpc}
operator * (const c: TAsphyreColor; k: Single) d: TAsphyreColor;
{$else}
class operator TAsphyreColor.Multiply(const c: TAsphyreColor;
 k: Single): TAsphyreColor;
{$endif}
begin
 Result.r:= Round(c.r * k);
 Result.g:= Round(c.g * k);
 Result.b:= Round(c.b * k);
 Result.a:= Round(c.a * k);
end;

//---------------------------------------------------------------------------
{$ifdef fpc}
operator / (const c: TAsphyreColor; k: Single) d: TAsphyreColor;
{$else}
class operator TAsphyreColor.Divide(const c: TAsphyreColor;
 k: Single): TAsphyreColor;
{$endif}
begin
 Result.r:= Round(c.r / k);
 Result.g:= Round(c.g / k);
 Result.b:= Round(c.b / k);
 Result.a:= Round(c.a / k);
end;

//---------------------------------------------------------------------------
{$ifdef fpc}
operator := (c: Cardinal) d: TAsphyreColor;
{$else}
class operator TAsphyreColor.Implicit(c: Cardinal): TAsphyreColor;
{$endif}
begin
 Result.r:= Inc8to16((c shr 16) and $FF);
 Result.b:= Inc8to16(c and $FF);
 Result.g:= Inc8to16((c shr 8) and $FF);
 Result.a:= Inc8to16((c shr 24) and $FF);
end;

//---------------------------------------------------------------------------
{$ifdef fpc}
operator := (const c: TAsphyreColor) d: Cardinal;
{$else}
class operator TAsphyreColor.Implicit(const c: TAsphyreColor): Cardinal;
{$endif}
begin
 Result:= (c.b shr 8) or ((c.g shr 8) shl 8) or ((c.r shr 8) shl 16) or
  ((c.a shr 8) shl 24);
end;

//---------------------------------------------------------------------------
{$ifndef fpc}
class operator TAsphyreColor.Explicit(c: Cardinal): TAsphyreColor;
begin
 Result.r:= Inc8to16((c shr 16) and $FF);
 Result.b:= Inc8to16(c and $FF);
 Result.g:= Inc8to16((c shr 8) and $FF);
 Result.a:= Inc8to16((c shr 24) and $FF);
end;
{$endif}

//---------------------------------------------------------------------------
{$ifndef fpc}
class operator TAsphyreColor.Explicit(const c: TAsphyreColor): Cardinal;
begin
 Result:= (c.b shr 8) or ((c.g shr 8) shl 8) or ((c.r shr 8) shl 16) or
  ((c.a shr 8) shl 24);
end;
{$endif}
{$ENDIF}
//---------------------------------------------------------------------------
end.
