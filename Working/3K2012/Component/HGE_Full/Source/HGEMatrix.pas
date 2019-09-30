unit HGEMatrix;
(*
** Haaf's Game Engine 1.7
** Copyright (C) 2003-2007, Relish Games
** hge.relishgames.com
**
** Extension to the HGE engine to support 2x2 matrices for HGEPhysics.
** This extension is based on Box2D (http://www.gphysics.com/).
** Extension added by Erik van Bilsen
**
** This extension is NOT part of the original HGE engine.
*)

interface

uses
  HGE, HGEVector;

type
  PHGEMatrix = ^THGEMatrix;
  THGEMatrix = record
  public
    Col1, Col2: THGEVector;
  public
    constructor Create(const AAngle: Single); overload;
    constructor Create(const ACol1, ACol2: THGEVector); overload;

    class operator Multiply(const A: THGEMatrix; const V: THGEVector): THGEVector; inline;
    class operator Multiply(const A, B: THGEMatrix): THGEMatrix; inline;
    class operator Add(const A, B: THGEMatrix): THGEMatrix; inline;

    class function Abs(const A: THGEMatrix): THGEMatrix; overload; static; inline;

    function Transpose: THGEMatrix;
    function Invert: THGEMatrix;
    function Abs: THGEMatrix; overload; 
  end;

implementation

{ THGEMatrix }

class function THGEMatrix.Abs(const A: THGEMatrix): THGEMatrix;
begin
  Result.Col1 := A.Col1.Abs;
  Result.Col2 := A.Col2.Abs;
end;

function THGEMatrix.Abs: THGEMatrix;
begin
  Result.Col1 := Col1.Abs;
  Result.Col2 := Col2.Abs;
end;

class operator THGEMatrix.Add(const A, B: THGEMatrix): THGEMatrix;
begin
  Result.Col1 := A.Col1 + B.Col1;
  Result.Col2 := A.Col2 + B.Col2;
end;

constructor THGEMatrix.Create(const AAngle: Single);
var
  C, S: Single;
begin
  C := Cos(AAngle); S := Sin(AAngle);
  Col1.X :=  C;
  Col2.X := -S;
  Col1.Y :=  S;
  Col2.Y :=  C;
end;

constructor THGEMatrix.Create(const ACol1, ACol2: THGEVector);
begin
  Col1 := ACol1;
  Col2 := ACol2;
end;

function THGEMatrix.Invert: THGEMatrix;
var
  A, B, C, D, Det: Single;
begin
  A := Col1.X;
  B := Col2.X;
  C := Col1.Y;
  D := Col2.Y;
  Det := (A * D) - (B * C);
  Assert(Det <> 0);
  Det := 1 / Det;
  Result.Col1.X :=  Det * D;
  Result.Col2.X := -Det * B;
  Result.Col1.Y := -Det * C;
  Result.Col2.Y :=  Det * A;
end;

class operator THGEMatrix.Multiply(const A: THGEMatrix;
  const V: THGEVector): THGEVector;
begin
  Result.X := (A.Col1.X * V.X) + (A.Col2.X * V.Y);
  Result.Y := (A.Col1.Y * V.X) + (A.Col2.Y * V.Y);
end;

class operator THGEMatrix.Multiply(const A, B: THGEMatrix): THGEMatrix;
begin
  Result.Col1 := A * B.Col1;
  Result.Col2 := A * B.Col2;
end;

function THGEMatrix.Transpose: THGEMatrix;
begin
  Result.Col1.X := Col1.X;
  Result.Col1.Y := Col2.X;
  Result.Col2.X := Col1.Y;
  Result.Col2.Y := Col2.Y;
end;

end.
