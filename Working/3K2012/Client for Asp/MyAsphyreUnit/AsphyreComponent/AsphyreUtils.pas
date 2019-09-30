unit AsphyreUtils;
//---------------------------------------------------------------------------
// AsphyreUtils.pas                                     Modified: 23-May-2008
// Asphyre utility routines                                      Version 1.01
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
//
// If you require any clarifications about the license, feel free to contact
// us or post your question on our forums at: http://www.afterwarp.net
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
// The Original Code is Vectors2px.pas.
//
// The Initial Developer of the Original Code is Yuriy Kotsarenko.
// Portions created by Yuriy Kotsarenko are Copyright (C) 2007 - 2008,
// Yuriy Kotsarenko. All Rights Reserved.
//---------------------------------------------------------------------------
interface

//---------------------------------------------------------------------------
uses
 Types, Vectors2px;

//---------------------------------------------------------------------------
{$ifdef fpc}
{$asmmode intel}
{$endif}

//---------------------------------------------------------------------------
// returns True if the given point is within the specified rectangle
//---------------------------------------------------------------------------
function PointInRect(const Point: TPoint2px; const Rect: TRect): Boolean; overload;

//---------------------------------------------------------------------------
// returns True if the given rectangle is within the specified rectangle
//---------------------------------------------------------------------------
function RectInRect(const Rect1, Rect2: TRect): Boolean;

//---------------------------------------------------------------------------
// returns True if the specified rectangles overlap
//---------------------------------------------------------------------------
function OverlapRect(const Rect1, Rect2: TRect): Boolean;

//---------------------------------------------------------------------------
// returns True if the specified point is inside the triangle
//---------------------------------------------------------------------------
function PointInTriangle(const Pos, v1, v2, v3: TPoint2px): Boolean;

//---------------------------------------------------------------------------
// returns the value of Catmull-Rom cubic spline
//---------------------------------------------------------------------------
function Lerp(x0, x1, Theta: Single): Single;
function CatmullRom(x0, x1, x2, x3, Theta: Single): Single;

//---------------------------------------------------------------------------
function MinMax2(Value, Min, Max: Integer): Integer;
function Min2(a, b: Integer): Integer;
function Max2(a, b: Integer): Integer;
function Min3(a, b, c: Integer): Integer;
function Max3(a, b, c: Integer): Integer;

//---------------------------------------------------------------------------
// Fixed point 24:8 math routines
//---------------------------------------------------------------------------
function iMul8(x, y: Integer): Integer;
function iCeil8(x: Integer): Integer;
function iDiv8(x, y: Integer): Integer;

//---------------------------------------------------------------------------
// Fixed point 16:16 math routines
//---------------------------------------------------------------------------
function iMul16(x, y: Integer): Integer;
function iCeil16(x: Integer): Integer;
function iDiv16(x, y: Integer): Integer;

//---------------------------------------------------------------------------
// Returns the next power of two of the specified value.
//---------------------------------------------------------------------------
function NextPowerOfTwo(Value: Integer): Integer;

//---------------------------------------------------------------------------
// The routines 'IsPowerOfTwo', 'CeilPowerOfTwo' and 'FloorPowerOfTwo' are
// converted from published code on FlipCode.com by Sebastian Schuberth.
//---------------------------------------------------------------------------

//---------------------------------------------------------------------------
// Determines whether the specified value is a power of two.
//---------------------------------------------------------------------------
function IsPowerOfTwo(Value: Integer): Boolean;

//---------------------------------------------------------------------------
// The least power of two greater than or equal to the specified value.
// Note that for Value = 0 and for Value > 2147483648 the result is 0.
//---------------------------------------------------------------------------
function CeilPowerOfTwo(Value: Integer): Integer;

//---------------------------------------------------------------------------
// The greatest power of two less than or equal to the specified value.
// Note that for Value = 0 the result is 0.
//---------------------------------------------------------------------------
function FloorPowerOfTwo(Value: Integer): Integer;
//---------------------------------------------------------------------------
function ClipRect(var DestRect: TRect; const DestRect2: TRect): Boolean;
function ClipRect2(var DestRect, SrcRect: TRect; const DestRect2, SrcRect2: TRect): Boolean;
function ShortRect(const Rect1, Rect2: TRect): TRect;
function MoveRect(const Rect: TRect; const Point: TPoint): TRect;
function PointInRect(const Point: TPoint; const Rect: TRect): Boolean; overload;
function ShrinkRect(const Rect: TRect; const hIn, vIn: Integer): TRect;

//---------------------------------------------------------------------------
implementation

//-----------------------------------------------------------------------------
function PointInRect(const Point: TPoint2px; const Rect: TRect): Boolean;
begin
 Result:= (Point.x >= Rect.Left)and(Point.x <= Rect.Right)and
  (Point.y >= Rect.Top)and(Point.y <= Rect.Bottom);
end;

//---------------------------------------------------------------------------
function RectInRect(const Rect1, Rect2: TRect): Boolean;
begin
 Result:= (Rect1.Left >= Rect2.Left)and(Rect1.Right <= Rect2.Right)and
  (Rect1.Top >= Rect2.Top)and(Rect1.Bottom <= Rect2.Bottom);
end;

//---------------------------------------------------------------------------
function OverlapRect(const Rect1, Rect2: TRect): Boolean;
begin
 Result:= (Rect1.Left < Rect2.Right)and(Rect1.Right > Rect2.Left)and
  (Rect1.Top < Rect2.Bottom)and(Rect1.Bottom > Rect2.Top);
end;

//---------------------------------------------------------------------------
function PointInTriangle(const Pos, v1, v2, v3: TPoint2px): Boolean;
var
 Aux: Integer;
begin
 Aux:= (Pos.y - v2.y) * (v3.x - v2.x) - (Pos.x - v2.x) * (v3.y - v2.y);

 Result:= (Aux * ((Pos.y - v1.y) * (v2.x - v1.x) - (Pos.x - v1.x) *
  (v2.y - v1.y)) > 0)and(Aux * ((Pos.y - v3.y) * (v1.x - v3.x) - (Pos.x -
  v3.x) * (v1.y - v3.y)) > 0);
end;

//---------------------------------------------------------------------------
function Lerp(x0, x1, Theta: Single): Single;
begin
 Result:= x0 + (x1 - x0) * Theta;
end;

//---------------------------------------------------------------------------
function CatmullRom(x0, x1, x2, x3, Theta: Single): Single;
begin
 Result:= 0.5 * ((2.0 * x1) + Theta * (-x0 + x2 + Theta * (2.0 * x0 - 5.0 *
  x1 + 4.0 * x2 - x3 + Theta * (-x0 + 3.0 * x1 - 3.0 * x2 + x3))));
end;

//---------------------------------------------------------------------------
function MinMax2(Value, Min, Max: Integer): Integer;
{$ifdef fpc} assembler;{$endif}
asm { params: eax, edx, ecx }
 cmp eax, edx
 cmovl eax, edx
 cmp eax, ecx
 cmovg eax, ecx
end;

//---------------------------------------------------------------------------
function Min2(a, b: Integer): Integer;
{$ifdef fpc} assembler;{$endif}
asm { params: eax, edx }
 cmp   edx, eax
 cmovl eax, edx
end;

//---------------------------------------------------------------------------
function Max2(a, b: Integer): Integer;
{$ifdef fpc} assembler;{$endif}
asm { params: eax, edx }
 cmp   edx, eax
 cmovg eax, edx
end;

//---------------------------------------------------------------------------
function Min3(a, b, c: Integer): Integer;
{$ifdef fpc} assembler;{$endif}
asm { params: eax, edx, ecx }
 cmp   edx, eax
 cmovl eax, edx
 cmp   ecx, eax
 cmovl eax, ecx
end;

//---------------------------------------------------------------------------
function Max3(a, b, c: Integer): Integer;
{$ifdef fpc} assembler;{$endif}
asm { params: eax, edx, ecx }
 cmp   edx, eax
 cmovg eax, edx
 cmp   ecx, eax
 cmovg eax, ecx
end;

//---------------------------------------------------------------------------
function iMul8(x, y: Integer): Integer;
{$ifdef fpc} assembler;{$endif}
asm { params: eax, edx }
 imul edx
 shrd eax, edx, 8
end;

//---------------------------------------------------------------------------
function iCeil8(x: Integer): Integer;
{$ifdef fpc} assembler;{$endif}
asm
 add eax, $FF
 sar eax, 8
end;

//---------------------------------------------------------------------------
function iDiv8(x, y: Integer): Integer;
{$ifdef fpc} assembler;{$endif}
asm { params: eax, edx }
 mov ecx, edx
 mov edx, eax
 sar edx, 24
 shl eax, 8
 idiv ecx
end;

//---------------------------------------------------------------------------
function iMul16(x, y: Integer): Integer;
{$ifdef fpc} assembler;{$endif}
asm { params: eax, edx }
 imul edx
 shrd eax, edx, 16
end;

//---------------------------------------------------------------------------
function iCeil16(x: Integer): Integer;
{$ifdef fpc} assembler;{$endif}
asm
 add eax, $FFFF
 sar eax, 16
end;

//---------------------------------------------------------------------------
function iDiv16(x, y: Integer): Integer;
{$ifdef fpc} assembler;{$endif}
asm { params: eax, edx }
 mov ecx, edx
 mov edx, eax
 sar edx, 16
 shl eax, 16
 idiv ecx
end;

//---------------------------------------------------------------------------
function NextPowerOfTwo(Value: Integer): Integer;
begin
 Result:= 1;
 asm
  xor ecx, ecx
  bsr ecx, Value
  inc ecx
  shl Result, cl
 end;
end;

//---------------------------------------------------------------------------
function IsPowerOfTwo(Value: Integer): Boolean;
begin
 Result:= (Value >= 1)and((Value and (Value - 1)) = 0);
end;

//---------------------------------------------------------------------------
function CeilPowerOfTwo(Value: Integer): Integer;
{$ifdef fpc} assembler;{$endif}
asm
 xor eax, eax
 dec ecx
 bsr ecx, ecx
 cmovz ecx, eax
 setnz al
 inc eax
 shl eax, cl
end;

//---------------------------------------------------------------------------
function FloorPowerOfTwo(Value: Integer): Integer;
{$ifdef fpc} assembler;{$endif}
asm
 xor eax, eax
 bsr ecx, ecx
 setnz al
 shl eax, cl
end;

//---------------------------------------------------------------------------

function ShortRect(const Rect1, Rect2: TRect): TRect;
begin
  Result.Left := Max2(Rect1.Left, Rect2.Left);
  Result.Top := Max2(Rect1.Top, Rect2.Top);
  Result.Right := Min2(Rect1.Right, Rect2.Right);
  Result.Bottom := Min2(Rect1.Bottom, Rect2.Bottom);
end;

//---------------------------------------------------------------------------

function MoveRect(const Rect: TRect; const Point: TPoint): TRect;
begin
  Result.Left := Rect.Left + Point.X;
  Result.Top := Rect.Top + Point.Y;
  Result.Right := Rect.Right + Point.X;
  Result.Bottom := Rect.Bottom + Point.Y;
end;
//---------------------------------------------------------------------------

function PointInRect(const Point: TPoint; const Rect: TRect): Boolean;
begin
  Result := (Point.X >= Rect.Left) and (Point.X <= Rect.Right) and
    (Point.Y >= Rect.Top) and (Point.Y <= Rect.Bottom);
end;

//---------------------------------------------------------------------------

function ShrinkRect(const Rect: TRect; const hIn, vIn: Integer): TRect;
begin
  Result.Left := Rect.Left + hIn;
  Result.Top := Rect.Top + vIn;
  Result.Right := Rect.Right - hIn;
  Result.Bottom := Rect.Bottom - vIn;
end;

//---------------------------------------------------------------------------
    {
function RectInRect(const Rect1, Rect2: TRect): Boolean;
begin
  Result := (Rect1.Left >= Rect2.Left) and (Rect1.Right <= Rect2.Right) and
    (Rect1.Top >= Rect2.Top) and (Rect1.Bottom <= Rect2.Bottom);
end; }

//---------------------------------------------------------------------------
    {
function OverlapRect(const Rect1, Rect2: TRect): Boolean;
begin
  Result := (Rect1.Left < Rect2.Right) and (Rect1.Right > Rect2.Left) and
    (Rect1.Top < Rect2.Bottom) and (Rect1.Bottom > Rect2.Top);
end;   }

function ClipRect(var DestRect: TRect; const DestRect2: TRect): Boolean;
begin
  with DestRect do begin
    Left := Max2(Left, DestRect2.Left);
    Right := Min2(Right, DestRect2.Right);
    Top := Max2(Top, DestRect2.Top);
    Bottom := Min2(Bottom, DestRect2.Bottom);

    Result := (Left < Right) and (Top < Bottom);
  end;
end;
//---------------------------------------------------------------------------

function ClipRect2(var DestRect, SrcRect: TRect; const DestRect2, SrcRect2: TRect): Boolean;
begin
  if DestRect.Left < DestRect2.Left then
  begin
    SrcRect.Left := SrcRect.Left + (DestRect2.Left - DestRect.Left);
    DestRect.Left := DestRect2.Left;
  end;

  if DestRect.Top < DestRect2.Top then
  begin
    SrcRect.Top := SrcRect.Top + (DestRect2.Top - DestRect.Top);
    DestRect.Top := DestRect2.Top;
  end;

  if SrcRect.Left < SrcRect2.Left then
  begin
    DestRect.Left := DestRect.Left + (SrcRect2.Left - SrcRect.Left);
    SrcRect.Left := SrcRect2.Left;
  end;

  if SrcRect.Top < SrcRect2.Top then
  begin
    DestRect.Top := DestRect.Top + (SrcRect2.Top - SrcRect.Top);
    SrcRect.Top := SrcRect2.Top;
  end;

  if DestRect.Right > DestRect2.Right then
  begin
    SrcRect.Right := SrcRect.Right - (DestRect.Right - DestRect2.Right);
    DestRect.Right := DestRect2.Right;
  end;

  if DestRect.Bottom > DestRect2.Bottom then
  begin
    SrcRect.Bottom := SrcRect.Bottom - (DestRect.Bottom - DestRect2.Bottom);
    DestRect.Bottom := DestRect2.Bottom;
  end;

  if SrcRect.Right > SrcRect2.Right then
  begin
    DestRect.Right := DestRect.Right - (SrcRect.Right - SrcRect2.Right);
    SrcRect.Right := SrcRect2.Right;
  end;

  if SrcRect.Bottom > SrcRect2.Bottom then
  begin
    DestRect.Bottom := DestRect.Bottom - (SrcRect.Bottom - SrcRect2.Bottom);
    SrcRect.Bottom := SrcRect2.Bottom;
  end;

  Result := (DestRect.Left < DestRect.Right) and (DestRect.Top < DestRect.Bottom) and
    (SrcRect.Left < SrcRect.Right) and (SrcRect.Top < SrcRect.Bottom);
end;
//---------------------------------------------------------------------------
end.
