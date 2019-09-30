unit HGEVector;
(*
** Haaf's Game Engine 1.7
** Copyright (C) 2003-2007, Relish Games
** hge.relishgames.com
**
** hgeVector helper class
**
** Delphi conversion by Erik van Bilsen
*)

interface

(****************************************************************************
 * HGEVector.h
 ****************************************************************************)

(*
** Fast 1.0/sqrtf(float) routine
*)
function InvSqrt(const X: Single): Single;

type
  PHGEVector = ^THGEVector;
  THGEVector = record
  public
    X, Y: Single;
  public
    constructor Create(const AX, AY: Single);
    class operator Subtract(const A, B: THGEVector): THGEVector;
    class operator Add(const A, B: THGEVector): THGEVector;
    class operator Multiply(const V: THGEVector; const Scalar: Single): THGEVector;
    class operator Multiply(const Scalar: Single; const V: THGEVector): THGEVector;
    class operator Negative(const V: THGEVector): THGEVector;
    class operator Equal(const A, B: THGEVector): Boolean;
    class operator NotEqual(const A, B: THGEVector): Boolean;
    class operator BitwiseXor(const A, B: THGEVector): Single;
    class operator Modulus(const A, B: THGEVector): Single;
    { NOTE: This replaces the C++ '+=' operator }
    procedure Increment(const V: THGEVector);
    { NOTE: This replaces the C++ '-=' operator }
    procedure Decrement(const V: THGEVector);
    { NOTE: This replaces the C++ '*=' operator }
    procedure Scale(const Scalar: Single);

    function Dot(const V: THGEVector): Single;
    procedure Clamp(const Max: Single);
    function Normalize: PHGEVector;
    function Length: Single;
    function Angle(const V: PHGEVector = nil): Single;
    function Rotate(const A: Single): PHGEVector;

    { Extensions by Erik van Bilsen }
    function Abs: THGEVector;
  end;

{ Extensions by Erik van Bilsen }
function Cross(const A, B: THGEVector): Single; overload; inline;
function Cross(const A: THGEVector; const S: Single): THGEVector; overload; inline;
function Cross(const S: Single; const A: THGEVector): THGEVector; overload; inline;

implementation

uses
  Math;

(****************************************************************************
 * HGEVector.h, HGEVector.cpp
 ****************************************************************************)

function InvSqrt(const X: Single): Single;
var
  I: Integer;
  F: Single absolute I;
begin
  F := X;
  I := $5f3759df - (I div 2);
  Result := F * (1.5 - 0.4999  * X * F * F);
end;

{ THGEVector }

function THGEVector.Abs: THGEVector;
begin
  Result.X := System.Abs(X);
  Result.Y := System.Abs(Y);
end;

class operator THGEVector.Add(const A, B: THGEVector): THGEVector;
begin
  Result := THGEVector.Create(A.X + B.X,A.Y + B.Y);
end;

function THGEVector.Angle(const V: PHGEVector): Single;
var
  S, T: THGEVector;
begin
  if Assigned(V) then begin
    S := Self;
    T := V^;
    S.Normalize;
    T.Normalize;
    Result := ArcCos(S.Dot(T));
  end else
    Result := ArcTan2(Y,X);
end;

class operator THGEVector.BitwiseXor(const A, B: THGEVector): Single;
begin
  Result := A.Angle(@B);
end;

procedure THGEVector.Clamp(const Max: Single);
begin
  if (Length > Max) then begin
    Normalize;
    X := X * Max;
    Y := Y * Max;
  end;
end;

constructor THGEVector.Create(const AX, AY: Single);
begin
  X := AX;
  Y := AY;
end;

procedure THGEVector.Decrement(const V: THGEVector);
begin
  X := X - V.X;
  Y := Y - V.Y;
end;

function THGEVector.Dot(const V: THGEVector): Single;
begin
  Result := (X * V.X) + (Y * V.Y);
end;

class operator THGEVector.Equal(const A, B: THGEVector): Boolean;
begin
  Result := (A.X = B.X) and (A.Y = B.Y);
end;

procedure THGEVector.Increment(const V: THGEVector);
begin
  X := X + V.X;
  Y := Y + V.Y;
end;

function THGEVector.Length: Single;
begin
  Result := Sqrt(Dot(Self));
end;

class operator THGEVector.Modulus(const A, B: THGEVector): Single;
begin
  Result := A.Dot(B);
end;

class operator THGEVector.Multiply(const V: THGEVector;
  const Scalar: Single): THGEVector;
begin
  Result := THGEVector.Create(V.X * Scalar,V.Y * Scalar);
end;

class operator THGEVector.Multiply(const Scalar: Single;
  const V: THGEVector): THGEVector;
begin
  Result := THGEVector.Create(V.X * Scalar,V.Y * Scalar);
end;

class operator THGEVector.Negative(const V: THGEVector): THGEVector;
begin
  Result := THGEVector.Create(-V.X,-V.Y);
end;

function THGEVector.Normalize: PHGEVector;
var
  RC: Single;
begin
  RC := InvSqrt(Dot(Self));
  X := X * RC;
  Y := Y * RC;
  Result := @Self;
end;

class operator THGEVector.NotEqual(const A, B: THGEVector): Boolean;
begin
  Result := (A.X <> B.X) or (A.Y <> B.Y);
end;

function THGEVector.Rotate(const A: Single): PHGEVector;
var
  V: THGEVector;
begin
  V.X := X * Cos(A) - Y * Sin(A);
  V.Y := X * Sin(A) + Y * Cos(A);
  X := V.X;
  Y := V.Y;
  Result := @Self;
end;

procedure THGEVector.Scale(const Scalar: Single);
begin
  X := X * Scalar;
  Y := Y * Scalar;
end;

class operator THGEVector.Subtract(const A, B: THGEVector): THGEVector;
begin
  Result := THGEVector.Create(A.X - B.X,A.Y - B.Y);
end;

{ Extensions }

function Cross(const A, B: THGEVector): Single; overload; inline;
begin
  Result := (A.X * B.Y) - (A.Y * B.X);
end;

function Cross(const A: THGEVector; const S: Single): THGEVector; overload; inline;
begin
  Result.X :=  S * A.Y;
  Result.Y := -S * A.X;
end;

function Cross(const S: Single; const A: THGEVector): THGEVector; overload; inline;
begin
  Result.X := -S * A.Y;
  Result.Y :=  S * A.X;
end;

end.
