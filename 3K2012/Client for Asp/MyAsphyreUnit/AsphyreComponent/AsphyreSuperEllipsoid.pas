unit AsphyreSuperEllipsoid;
//---------------------------------------------------------------------------
// AsphyreSuperEllipsoid.pas                            Modified: 02-Apr-2007
// Superellipsoid implementation for Asphyre                      Version 1.0
//---------------------------------------------------------------------------
// This code generates superellipsoid documented by Paul Bourke at:
//  http://local.wasp.uwa.edu.au/~pbourke/surfaces_curves/superellipse/
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
// The Original Code is AsphyreSuperEllipsoid.pas.
//
// The Initial Developer of the Original Code is Yuriy Kotsarenko.
// Portions created by Yuriy Kotsarenko are Copyright (C) 2007 - 2008,
// Yuriy Kotsarenko. All Rights Reserved.
//---------------------------------------------------------------------------
interface

//---------------------------------------------------------------------------
uses
 Windows, Math, Vectors2, Vectors3, AsphyreProceduralMeshes;

//---------------------------------------------------------------------------
type
 TAsphyreSuperEllipsoid = class(TAsphyreProceduralMesh)
 private
 public
  function Generate(Divisions: Integer; n1, n2: Single): Boolean;
 end;

//---------------------------------------------------------------------------
implementation

//---------------------------------------------------------------------------
function SampleSuperEllipsoid(Phi, Beta, n1, n2: Single): TVector3;
var
 CosPhi, SinPhi, CosBeta, SinBeta, Temp: Single;
begin
 CosPhi := Cos(Phi);
 SinPhi := Sin(Phi);
 CosBeta:= Cos(Beta);
 SinBeta:= Sin(Beta);

 Temp:= Sign(CosPhi) * Power(Abs(CosPhi), n1);

 Result.x:= Temp * Sign(CosBeta) * Power(Abs(CosBeta), n2);
 Result.y:= Sign(SinPhi) * Power(Abs(SinPhi), n1);
 Result.z:= Temp * Sign(SinBeta) * Power(Abs(SinBeta), n2);
end;

//---------------------------------------------------------------------------
function CalculateNormal(Phi, Beta, n1, n2: Single): TVector3;
var
 CosPhi, SinPhi, CosBeta, SinBeta: Single;
begin
 CosPhi := Cos(Phi);
 SinPhi := Sin(Phi);
 CosBeta:= Cos(Beta);
 SinBeta:= Sin(Beta);

 Result.x:= Sign(CosPhi) * Power(Abs(CosPhi), 2.0 - n1) * Sign(CosBeta) *
  Power(Abs(CosBeta), 2.0 - n2);
 Result.z:= Sign(CosPhi) * Power(Abs(CosPhi), 2.0 - n1) * Sign(SinBeta) *
  Power(Abs(SinBeta), 2.0 - n2);
 Result.y:= Sign(SinPhi) * Power(Abs(SinPhi), 2.0 - n1);
end;

//---------------------------------------------------------------------------
function TAsphyreSuperEllipsoid.Generate(Divisions: Integer; n1,
 n2: Single): Boolean;
var
 Phi, Beta, PhiInc, BetaInc: Single;
 i, j, ni, nj: Integer;
 Tris, Rows, Cols: Integer;
begin
 Rows:= Divisions + 1;
 Cols:= (Divisions div 2) + 2;
 Tris:= Rows * (Cols - 1) * 2;

 Result:= CreateBuffers(Tris, Rows * Cols);
 if (not Result) then Exit;

 Result:= LockBuffers();
 if (not Result) then Exit;

 PhiInc := Pi / (Cols - 2);
 BetaInc:= 2.0 * Pi / (Rows - 1);

 Phi:= -Pi * 0.5;
 for j:= 0 to Cols - 1 do
  begin
   Beta:= -Pi;

   for i:= 0 to Rows - 1 do
    begin
{$IFDEF VER185}
     IncludeVertex(Vectors3Multiply(SampleSuperEllipsoid(Phi, Beta, n1, n2), 0.5),
      CalculateNormal(Phi, Beta, n1, n2),
      Point2(i / Rows, j / Cols));
{$ELSE}
     IncludeVertex(SampleSuperEllipsoid(Phi, Beta, n1, n2) * 0.5,
      CalculateNormal(Phi, Beta, n1, n2),
      Point2(i / Rows, j / Cols));
{$ENDIF}
     ni:= (i + 1) mod Rows;
     nj:= j + 1;

     if (j < Cols - 1) then
      begin
       IncludeIndex(i + j * Rows);
       IncludeIndex(i + nj * Rows);
       IncludeIndex(ni + nj * Rows);

       IncludeIndex(i + j * Rows);
       IncludeIndex(ni + nj * Rows);
       IncludeIndex(ni + j * Rows);
      end;

     Beta:= Beta + BetaInc;
    end;

   Phi:= Phi + PhiInc;
  end;

 UnlockBuffers();
end;

//---------------------------------------------------------------------------
end.
