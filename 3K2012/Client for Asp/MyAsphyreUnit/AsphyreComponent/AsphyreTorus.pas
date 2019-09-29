unit AsphyreTorus;
//---------------------------------------------------------------------------
// AsphyreTorus.pas                                    Modified: 18-Apr-2007
// Torus mesh implementation for Asphyre                         Version 1.0
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
// The Original Code is AsphyreTorus.pas.
//
// The Initial Developer of the Original Code is M. Sc. Yuriy Kotsarenko.
// Portions created by M. Sc. Yuriy Kotsarenko are Copyright (C) 2007,
// M. Sc. Yuriy Kotsarenko. All Rights Reserved.
//---------------------------------------------------------------------------
interface

//---------------------------------------------------------------------------
uses
 Windows, Math, Vectors2, Vectors3, AsphyreProceduralMeshes;

//---------------------------------------------------------------------------
type
 TAsphyreTorus = class(TAsphyreProceduralMesh)
 private
 public
  function Generate(Radius, TubeRadius: Single; Rings,
   Sides: Integer; TexTilesX, TexTilesY: Single): Boolean;
 end;

//---------------------------------------------------------------------------
implementation

//---------------------------------------------------------------------------
function TAsphyreTorus.Generate(Radius, TubeRadius: Single; Rings,
 Sides: Integer; TexTilesX, TexTilesY: Single): Boolean;
var
 SideBlock: Integer;
 i, j, ni, nj: Integer;
 Theta, ThetaInc: Single;
 Phi, PhiInc, Delta: Single;
 CosTheta, SinTheta: Single;
 CosPhi, SinPhi: Single;
begin
 SideBlock:= Sides + 1;

 Result:= CreateBuffers(Rings * Sides * 2, (Rings + 1) * SideBlock);
 if (not Result) then Exit;

 Result:= LockBuffers();
 if (not Result) then Exit;

 Theta:= 0.0;
 ThetaInc:= 2.0 * Pi / Rings;
 PhiInc:= 2.0 * Pi / Sides;

 for j:= 0 to Rings do
  begin
   CosTheta:= Cos(Theta);
   SinTheta:= Sin(Theta);

   Phi:= 0.0;
   for i:= 0 to Sides do
    begin
     CosPhi:= Cos(Phi);
     SinPhi:= Sin(Phi);
     Delta := Radius + TubeRadius * CosPhi;

     IncludeVertex(
      Vector3(CosTheta * Delta, TubeRadius * SinPhi, -SinTheta * Delta),
      Vector3(CosTheta * CosPhi, SinPhi, -SinTheta * CosPhi),
      Point2(Theta * TexTilesX / (2.0 * Pi), Phi * TexTilesY / (2.0 * Pi)));

     ni:= i + 1;
     nj:= j + 1;

     if (i < Sides)and(j < Rings) then
      begin
       IncludeIndex(i + j * SideBlock);
       IncludeIndex(i + nj * SideBlock);
       IncludeIndex(ni + nj * SideBlock);

       IncludeIndex(i + j * SideBlock);
       IncludeIndex(ni + nj * SideBlock);
       IncludeIndex(ni + j * SideBlock);
      end;

     Phi:= Phi + PhiInc;
    end;

   Theta:= Theta + ThetaInc;
  end;
  
 UnlockBuffers();
end;

//---------------------------------------------------------------------------
end.
