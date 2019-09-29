unit AsphyrePlaneMesh;
//---------------------------------------------------------------------------
// AsphyrePlaneMesh.pas                                 Modified: 27-Apr-2007
// XZ plane mesh for Asphyre                                      Version 1.0
//---------------------------------------------------------------------------
// This code is based on the description at:
//  http://www.blackpawn.com/texts/pqtorus/default.html
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
// The Original Code is AsphyrePlaneMesh.pas.
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
 TAsphyrePlaneMesh = class(TAsphyreProceduralMesh)
 private
 public
  function Generate(WidthSeg, HeightSeg: Integer; Width, Height,
   TexRepX, TexRepY: Single): Boolean;
 end;

//---------------------------------------------------------------------------
implementation

//---------------------------------------------------------------------------
function TAsphyrePlaneMesh.Generate(WidthSeg, HeightSeg: Integer;
 Width, Height, TexRepX, TexRepY: Single): Boolean;
var
 i, j: Integer;
 Vtx : TVector3;
 Norm: TVector3;
 Tex : TPoint2;
 SideBlock: Integer;
begin
 Result:= CreateBuffers(WidthSeg * HeightSeg * 2, (WidthSeg + 1) * (HeightSeg + 1));
 if (not Result) then Exit;

 Result:= LockBuffers();
 if (not Result) then Exit;

 SideBlock:= WidthSeg + 1;

 for j:= 0 to HeightSeg do
  for i:= 0 to WidthSeg do
   begin
    Vtx.x:= ((i / WidthSeg) - 0.5) * Width;
    Vtx.y:= 0.0;
    Vtx.z:= -((j / HeightSeg) - 0.5) * Height;
    Tex.x:= i * TexRepX / WidthSeg;
    Tex.y:= j * TexRepY / HeightSeg;

    Norm:= Vector3(0.0, 1.0, 0.0);

{    Up:= Vector3(0.0, 1.0, 0.0);
    if (Norm.x < Norm.y) then Up:= Vector3(1.0, 0.0, 0.0);

    Tangent := Norm3(Cross3(Up, Norm));
    Binormal:= Norm3(Cross3(Tangent, Norm));}

    IncludeVertex(Vtx, Norm, Tex);

    if (i < WidthSeg)and(j < HeightSeg) then
     begin
      IncludeIndex(i + j * SideBlock);
      IncludeIndex((i + 1) + (j + 1) * SideBlock);
      IncludeIndex(i + (j + 1) * SideBlock);

      IncludeIndex(i + j * SideBlock);
      IncludeIndex((i + 1) + j * SideBlock);
      IncludeIndex((i + 1) + (j + 1) * SideBlock);
     end;
   end;

 UnlockBuffers();
end;

//---------------------------------------------------------------------------
end.
