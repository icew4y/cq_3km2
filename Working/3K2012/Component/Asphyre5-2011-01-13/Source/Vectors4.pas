unit Vectors4;
//---------------------------------------------------------------------------
// Vectors4.pas                                         Modified: 21-May-2008
// Definitions and functions working with 4D vectors             Version 1.01
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
// The Original Code is Vectors4.pas.
//
// The Initial Developer of the Original Code is Yuriy Kotsarenko.
// Portions created by Yuriy Kotsarenko are Copyright (C) 2007 - 2008,
// Yuriy Kotsarenko. All Rights Reserved.
//---------------------------------------------------------------------------
interface

//---------------------------------------------------------------------------
{.$define SupportD3DX}

//---------------------------------------------------------------------------
uses
 Math, {$ifdef SupportD3DX}D3DX9,{$endif} Vectors3, Matrices4;

//---------------------------------------------------------------------------
type
 PVector4 = ^TVector4;
{$IFDEF VER185}
 TVector4 = record
  x, y, z, w: Single;
  end;
{$ELSE}
 TVector4 = record
  x, y, z, w: Single;

  class operator Implicit(const v: TVector4): TVector3;
  class operator Implicit(const v: TVector3): TVector4;
  class operator Explicit(const v: TVector4): TVector3;
  class operator Explicit(const v: TVector3): TVector4;

  class operator Add(const a, b: TVector4): TVector4;
  class operator Subtract(const a, b: TVector4): TVector4;
  class operator Multiply(const a, b: TVector4): TVector4;
  class operator Divide(const a, b: TVector4): TVector4;

  class operator Negative(const v: TVector4): TVector4;
  class operator Multiply(const v: TVector4; const k: Single): TVector4;
  class operator Divide(const v: TVector4; const k: Single): TVector4;
  class operator Multiply(const v: TVector4; const m: TMatrix4): TVector4;
 end;
{$ENDIF}
//---------------------------------------------------------------------------
 TVectors4 = class
 private
  NativeAddr : Pointer;
  AlignedAddr: Pointer;
  Capacity   : Integer;
  DataCount  : Integer;

  procedure Request(Amount: Integer);
  procedure Reallocate(Amount: Integer);
  function GetVector(Num: Integer): PVector4;
  function GetItem(Num: Integer): TVector4;
  procedure SetItem(Num: Integer; const Value: TVector4);
 public
  property MemAddr: Pointer read AlignedAddr;
  property Count: Integer read DataCount;

  property Items[Num: Integer]: TVector4 read GetItem write SetItem; default;
  property Vector[Num: Integer]: PVector4 read GetVector;

  function Add(const Vector: TVector4): Integer; overload;
  function Add(x, y, z: Single): Integer; overload;

  procedure Remove(Index: Integer);
  procedure RemoveAll();

  procedure CopyFrom(Source: TVectors4);
  procedure AddFrom(Source: TVectors4);

  procedure AddBulk(NoVertices: Integer);
  procedure Transform(Source: TVectors4; Matrix: PMatrix4);

  constructor Create();
  destructor Destroy(); override;
 end;

//---------------------------------------------------------------------------
const
 ZeroVec4 : TVector4 = (x: 0.0; y: 0.0; z: 0.0; w: 1.0);
 UnityVec4: TVector4 = (x: 1.0; y: 1.0; z: 1.0; w: 1.0);
 AxisXVec4: TVector4 = (x: 1.0; y: 0.0; z: 0.0; w: 1.0);
 AxisYVec4: TVector4 = (x: 0.0; y: 1.0; z: 0.0; w: 1.0);
 AxisZVec4: TVector4 = (x: 0.0; y: 0.0; z: 1.0; w: 1.0);

//---------------------------------------------------------------------------
function Vector4(x, y, z: Single): TVector4;
function Length4(const v: TVector4): Single;
function Norm4(const v: TVector4): TVector4;
function Lerp4(const v0, v1: TVector4; Alpha: Single): TVector4;
function Dot4(const a, b: TVector4): Single;
function Cross4(const a, b: TVector4): TVector4;
function Angle4(const a, b: TVector4): Single;
function Parallel4(const v, n: TVector4): TVector4;
function Perp4(const v, n: TVector4): TVector4;
function ColorToVec4(Color: Cardinal): TVector4;
function Vec4ToColor(const v: TVector4): Cardinal;
{$IFDEF VER185}
function Vector4ToVector3(const v: TVector4): TVector3;
function Vector3ToVector4(const v: TVector3): TVector4;
function Vector4Implicit(const v: TVector4): TVector3;overload;
function Vector4Implicit(const v: TVector3): TVector4;overload;
function Vector4Explicit(const v: TVector4): TVector3;overload;
function Vector4Explicit(const v: TVector3): TVector4;overload;
function Vector4Add(const a, b: TVector4): TVector4;
function Vector4Subtract(const a, b: TVector4): TVector4;
function Vector4Multiply(const a, b: TVector4): TVector4;overload;
function Vector4Divide(const a, b: TVector4): TVector4;overload;

function Vector4Negative(const v: TVector4): TVector4;
function Vector4Multiply(const v: TVector4; const k: Single): TVector4;overload;
function Vector4Divide(const v: TVector4; const k: Single): TVector4;overload;
function Vector4Multiply(const v: TVector4; const m: TMatrix4): TVector4; overload;
{$ENDIF}
//---------------------------------------------------------------------------
implementation

//---------------------------------------------------------------------------
uses
 SysUtils{$ifndef SupportD3DX}, TransformUtils{$endif};

//---------------------------------------------------------------------------
const
 VectorCache = 256;
{$IFDEF VER185}
//---------------------------------------------------------------------------
function Vector4ToVector3(const v: TVector4): TVector3;
begin

end;
function Vector3ToVector4(const v: TVector3): TVector4;
begin
 Result.x:= v.x;
 Result.y:= v.y;
 Result.z:= v.z;
 Result.w:= 1.0;
end;
//---------------------------------------------------------------------------
function Vector4Explicit(const v: TVector4): TVector3;
begin
 Result.x:= v.x / v.w;
 Result.y:= v.y / v.w;
 Result.z:= v.z / v.w;
end;

//---------------------------------------------------------------------------
function Vector4Explicit(const v: TVector3): TVector4;
begin
 Result.x:= v.x;
 Result.y:= v.y;
 Result.z:= v.z;
 Result.w:= 1.0;
end;

//---------------------------------------------------------------------------
function Vector4Implicit(const v: TVector4): TVector3;
begin
 Result.x:= v.x / v.w;
 Result.y:= v.y / v.w;
 Result.z:= v.z / v.w;
end;

//---------------------------------------------------------------------------
function Vector4Implicit(const v: TVector3): TVector4;
begin
 Result.x:= v.x;
 Result.y:= v.y;
 Result.z:= v.z;
 Result.w:= 1.0;
end;
function Vector4Add(const a, b: TVector4): TVector4;
begin
 Result.x:= a.x + b.x;
 Result.y:= a.y + b.y;
 Result.z:= a.z + b.z;
 Result.w:= 1.0;
end;

//---------------------------------------------------------------------------
function Vector4Subtract(const a, b: TVector4): TVector4;
begin
 Result.x:= a.x - b.x;
 Result.y:= a.y - b.y;
 Result.z:= a.z - b.z;
 Result.w:= 1.0;
end;

//---------------------------------------------------------------------------
function Vector4Multiply(const a, b: TVector4): TVector4;
begin
 Result.x:= a.x * b.x;
 Result.y:= a.y * b.y;
 Result.z:= a.z * b.z;
 Result.w:= 1.0;
end;

//---------------------------------------------------------------------------
function Vector4Divide(const a, b: TVector4): TVector4;
begin
 Result.x:= a.x / b.x;
 Result.y:= a.y / b.y;
 Result.z:= a.z / b.z;
 Result.w:= 1.0;
end;

//---------------------------------------------------------------------------
function Vector4Negative(const v: TVector4): TVector4;
begin
 Result.x:= -v.x;
 Result.y:= -v.y;
 Result.z:= -v.z;
 Result.w:= 1.0;
end;

//---------------------------------------------------------------------------
function Vector4Multiply(const v: TVector4;
 const k: Single): TVector4;
begin
 Result.x:= v.x * k;
 Result.y:= v.y * k;
 Result.z:= v.z * k;
 Result.w:= 1.0;
end;

//---------------------------------------------------------------------------
function Vector4Divide(const v: TVector4;
 const k: Single): TVector4;
begin
 Result.x:= v.x / k;
 Result.y:= v.y / k;
 Result.z:= v.z / k;
 Result.w:= 1.0;
end;

//---------------------------------------------------------------------------
function Vector4Multiply(const v: TVector4;
 const m: TMatrix4): TVector4;
begin
 Result.x:= (v.x * m.Data[0, 0]) + (v.y * m.Data[1, 0]) +
  (v.z * m.Data[2, 0]) + (v.w * m.Data[3, 0]);
 Result.y:= (v.x * m.Data[0, 1]) + (v.y * m.Data[1, 1]) +
  (v.z * m.Data[2, 1]) + (v.w * m.Data[3, 1]);
 Result.z:= (v.x * m.Data[0, 2]) + (v.y * m.Data[1, 2]) +
  (v.z * m.Data[2, 2]) + (v.w * m.Data[3, 2]);
 Result.w:= (v.x * m.Data[0, 3]) + (v.y * m.Data[1, 3]) +
  (v.z * m.Data[2, 3]) + (v.w * m.Data[3, 3]);
end;

{$ELSE}
//---------------------------------------------------------------------------
class operator TVector4.Explicit(const v: TVector4): TVector3;
begin
 Result.x:= v.x / v.w;
 Result.y:= v.y / v.w;
 Result.z:= v.z / v.w;
end;

//---------------------------------------------------------------------------
class operator TVector4.Explicit(const v: TVector3): TVector4;
begin
 Result.x:= v.x;
 Result.y:= v.y;
 Result.z:= v.z;
 Result.w:= 1.0;
end;

//---------------------------------------------------------------------------
class operator TVector4.Implicit(const v: TVector4): TVector3;
begin
 Result.x:= v.x / v.w;
 Result.y:= v.y / v.w;
 Result.z:= v.z / v.w;
end;

//---------------------------------------------------------------------------
class operator TVector4.Implicit(const v: TVector3): TVector4;
begin
 Result.x:= v.x;
 Result.y:= v.y;
 Result.z:= v.z;
 Result.w:= 1.0;
end;

//---------------------------------------------------------------------------
class operator TVector4.Add(const a, b: TVector4): TVector4;
begin
 Result.x:= a.x + b.x;
 Result.y:= a.y + b.y;
 Result.z:= a.z + b.z;
 Result.w:= 1.0;
end;

//---------------------------------------------------------------------------
class operator TVector4.Subtract(const a, b: TVector4): TVector4;
begin
 Result.x:= a.x - b.x;
 Result.y:= a.y - b.y;
 Result.z:= a.z - b.z;
 Result.w:= 1.0;
end;

//---------------------------------------------------------------------------
class operator TVector4.Multiply(const a, b: TVector4): TVector4;
begin
 Result.x:= a.x * b.x;
 Result.y:= a.y * b.y;
 Result.z:= a.z * b.z;
 Result.w:= 1.0;
end;

//---------------------------------------------------------------------------
class operator TVector4.Divide(const a, b: TVector4): TVector4;
begin
 Result.x:= a.x / b.x;
 Result.y:= a.y / b.y;
 Result.z:= a.z / b.z;
 Result.w:= 1.0;
end;

//---------------------------------------------------------------------------
class operator TVector4.Negative(const v: TVector4): TVector4;
begin
 Result.x:= -v.x;
 Result.y:= -v.y;
 Result.z:= -v.z;
 Result.w:= 1.0;
end;

//---------------------------------------------------------------------------
class operator TVector4.Multiply(const v: TVector4;
 const k: Single): TVector4;
begin
 Result.x:= v.x * k;
 Result.y:= v.y * k;
 Result.z:= v.z * k;
 Result.w:= 1.0;
end;

//---------------------------------------------------------------------------
class operator TVector4.Divide(const v: TVector4;
 const k: Single): TVector4;
begin
 Result.x:= v.x / k;
 Result.y:= v.y / k;
 Result.z:= v.z / k;
 Result.w:= 1.0;
end;

//---------------------------------------------------------------------------
class operator TVector4.Multiply(const v: TVector4;
 const m: TMatrix4): TVector4;
begin
 Result.x:= (v.x * m.Data[0, 0]) + (v.y * m.Data[1, 0]) +
  (v.z * m.Data[2, 0]) + (v.w * m.Data[3, 0]);
 Result.y:= (v.x * m.Data[0, 1]) + (v.y * m.Data[1, 1]) +
  (v.z * m.Data[2, 1]) + (v.w * m.Data[3, 1]);
 Result.z:= (v.x * m.Data[0, 2]) + (v.y * m.Data[1, 2]) +
  (v.z * m.Data[2, 2]) + (v.w * m.Data[3, 2]);
 Result.w:= (v.x * m.Data[0, 3]) + (v.y * m.Data[1, 3]) +
  (v.z * m.Data[2, 3]) + (v.w * m.Data[3, 3]);
end;
{$ENDIF}
//---------------------------------------------------------------------------
function Vector4(x, y, z: Single): TVector4;
begin
 Result.x:= x;
 Result.y:= y;
 Result.z:= z;
 Result.w:= 1.0;
end;

//---------------------------------------------------------------------------
function Length4(const v: TVector4): Single;
begin
 Result:= Sqrt(v.x * v.x + v.y * v.y + v.z * v.z);
end;

//---------------------------------------------------------------------------
function Norm4(const v: TVector4): TVector4;
var
 Amp: Single;
begin
 Amp:= Length4(v);

 if (Amp <> 0.0) then
  begin
   Result.x:= v.x / Amp;
   Result.y:= v.y / Amp;
   Result.z:= v.z / Amp;
   Result.w:= 1.0;
  end else Result:= ZeroVec4;
end;

//---------------------------------------------------------------------------
function Lerp4(const v0, v1: TVector4; Alpha: Single): TVector4;
begin
 Result.x:= v0.x + (v1.x - v0.x) * Alpha;
 Result.y:= v0.y + (v1.y - v0.y) * Alpha;
 Result.z:= v0.z + (v1.z - v0.z) * Alpha;
 Result.w:= 1.0;
end;

//---------------------------------------------------------------------------
function Dot4(const a, b: TVector4): Single;
begin
 Result:= (a.x * b.x) + (a.y * b.y) + (a.z * b.z);
end;

//---------------------------------------------------------------------------
function Cross4(const a, b: TVector4): TVector4;
begin
 Result.x:= (a.y * b.z) - (a.z * b.y);
 Result.y:= (a.z * b.x) - (a.x * b.z);
 Result.z:= (a.x * b.y) - (a.y * b.x);
 Result.w:= 1.0;
end;

//---------------------------------------------------------------------------
function Angle4(const a, b: TVector4): Single;
var
 v: Single;
begin
 v:= Dot4(a, b) / (Length4(a) * Length4(b));

 if (v < -1.0) then v:= -1.0
  else if (v > 1.0) then v:= 1.0;

 Result:= ArcCos(v);
end;

//---------------------------------------------------------------------------
function Parallel4(const v, n: TVector4): TVector4;
begin
{$IFDEF VER185}
   Result:= Vector4Multiply(n, (Dot4(v, n) / Sqr(Length4(n))));
{$ELSE}
   Result:= n * (Dot4(v, n) / Sqr(Length4(n)));
{$ENDIF}
end;

//--------------------------------------------------------------------------
function Perp4(const v, n: TVector4): TVector4;
begin
{$IFDEF VER185}
   Result:= Vector4Subtract(v, Parallel4(v, n));
{$ELSE}
   Result:= v - Parallel4(v, n);
{$ENDIF}
end;

//---------------------------------------------------------------------------
function ColorToVec4(Color: Cardinal): TVector4;
begin
 Result.x:= ((Color shl 8) shr 24) / 255.0;
 Result.y:= ((Color shl 16) shr 24) / 255.0;
 Result.z:= ((Color shl 24) shr 24) / 255.0;
 Result.w:= (Color shr 24) / 255.0;
end;

//---------------------------------------------------------------------------
function Vec4ToColor(const v: TVector4): Cardinal;
begin
 Result:= (Round(v.x * 255.0) shl 16) or (Round(v.y * 255.0) shl 8) or
  Round(v.z * 255.0) or (Round(v.w * 255.0) shl 24);
end;

//---------------------------------------------------------------------------
constructor TVectors4.Create();
begin
 inherited;

 NativeAddr := nil;
 AlignedAddr:= nil;
 Capacity   := 0;
 DataCount  := 0;
 end;

//---------------------------------------------------------------------------
destructor TVectors4.Destroy();
begin
 if (NativeAddr <> nil) then
  begin
   FreeMem(NativeAddr);
   NativeAddr := nil;
   AlignedAddr:= nil;
   Capacity   := 0;
   DataCount  := 0;
  end;

 inherited;
end;

//---------------------------------------------------------------------------
procedure TVectors4.Request(Amount: Integer);
var
 Required: Integer;
begin
 Required:= ((Amount + VectorCache - 1) div VectorCache) * VectorCache;
 if (Capacity < Required) then Reallocate(Required);
end;

//---------------------------------------------------------------------------
procedure TVectors4.Reallocate(Amount: Integer);
var
 NewAddr   : Pointer;
 NewAligned: Pointer;
begin
 // allocate the requested amount of memory
 GetMem(NewAddr, (Amount * SizeOf(TVector4)) + 16);

 // align the memory address to 16-byte
 NewAligned:= Pointer(Integer(NewAddr) + ($10 - (Integer(NewAddr) and $0F)));

 // copy the contents of old buffer to the new one
 if (DataCount > 0) then
  Move(AlignedAddr^, NewAligned^, DataCount * SizeOf(TVector4));

 // release the previously allocated memory
 if (NativeAddr <> nil) then FreeMem(NativeAddr);

 // update memory pointers
 NativeAddr := NewAddr;
 AlignedAddr:= NewAligned;

 // update the capacity
 Capacity:= Amount;
end;

//---------------------------------------------------------------------------
function TVectors4.GetVector(Num: Integer): PVector4;
begin
 if (Num >= 0)and(Num < DataCount) then
  Result:= Pointer(Integer(AlignedAddr) + (Num * SizeOf(TVector4)))
   else Result:= nil;
end;

//---------------------------------------------------------------------------
function TVectors4.GetItem(Num: Integer): TVector4;
var
 pVec: PVector4;
begin
 pVec:= GetVector(Num);
 if (pVec <> nil) then Result:= pVec^
  else Result:= ZeroVec4;
end;

//---------------------------------------------------------------------------
procedure TVectors4.SetItem(Num: Integer; const Value: TVector4);
var
 pVec: PVector4;
begin
 pVec:= GetVector(Num);
 if (pVec <> nil) then pVec^:= Value;
end;

//---------------------------------------------------------------------------
function TVectors4.Add(const Vector: TVector4): Integer;
var
 Index: Integer;
 pVec : PVector4;
begin
 Index:= DataCount;
 Request(DataCount + 1);
 Inc(DataCount);

 pVec:= GetVector(Index);
 pVec^:= Vector;

 Result:= Index;
end;

//---------------------------------------------------------------------------
procedure TVectors4.AddBulk(NoVertices: Integer);
begin
 Request(DataCount + NoVertices);
 Inc(DataCount, NoVertices);
end;

//---------------------------------------------------------------------------
function TVectors4.Add(x, y, z: Single): Integer;
begin
 Result:= Add(Vector4(x, y, z));
end;

//---------------------------------------------------------------------------
procedure TVectors4.Remove(Index: Integer);
var
 Source: Pointer;
 Dest  : Pointer;
 Amount: Integer;
begin
 if (Index < 0)or(Index >= DataCount) then Exit;

 Amount:= (DataCount - Index) - 1;
 if (Amount > 0) then
  begin
   Source:= GetVector(Index + 1);
   Dest  := GetVector(Index);

   Move(Source^, Dest^, Amount * SizeOf(TVector4));
  end;

 Dec(DataCount);
end;

//---------------------------------------------------------------------------
procedure TVectors4.RemoveAll();
begin
 DataCount:= 0;
end;

//---------------------------------------------------------------------------
procedure TVectors4.CopyFrom(Source: TVectors4);
begin
 Request(Source.Count);

 if (Source.Count > 0) then
  Move(Source.MemAddr^, AlignedAddr^, Source.Count * SizeOf(TVector4));

 DataCount:= Source.Count;
end;

//---------------------------------------------------------------------------
procedure TVectors4.AddFrom(Source: TVectors4);
var
 DestAddr: Pointer;
begin
 Request(DataCount + Source.Count);

 DestAddr:= GetVector(DataCount);
 Move(Source.MemAddr^, DestAddr^, Source.Count * SizeOf(TVector4));

 Inc(DataCount, Source.Count);
end;

//---------------------------------------------------------------------------
procedure TVectors4.Transform(Source: TVectors4; Matrix: PMatrix4);
begin
 Request(Source.Count);

 {$ifdef SupportD3DX}
 D3DXVec4TransformArray(AlignedAddr, SizeOf(TVector4),  Source.MemAddr,
  SizeOf(TVector4), PD3DXMatrix(Matrix)^, Source.Count);
 {$else}
 BatchMultiply5(Source.MemAddr, AlignedAddr, Source.Count div 2, Matrix);
 {$endif}

 DataCount:= Source.Count;
end;

//---------------------------------------------------------------------------
end.
