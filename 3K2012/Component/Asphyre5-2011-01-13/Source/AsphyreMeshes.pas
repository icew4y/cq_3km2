unit AsphyreMeshes;
//---------------------------------------------------------------------------
// AsphyreMeshes.pas                                    Modified: 18-May-2007
// A wrapper for Direct3D meshes                                  Version 1.0
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
// The Original Code is AsphyreMeshes.pas.
//
// The Initial Developer of the Original Code is M. Sc. Yuriy Kotsarenko.
// Portions created by M. Sc. Yuriy Kotsarenko are Copyright (C) 2007,
// M. Sc. Yuriy Kotsarenko. All Rights Reserved.
//---------------------------------------------------------------------------
interface

//--------------------------------------------------------------------------
uses
 Windows, SysUtils, Direct3D9, D3DX9;

//--------------------------------------------------------------------------
type
 TAsphyreCustomMesh = class        //网格模型对象
 protected
  FDXMesh: ID3DXMesh;
  NumMaterials: Integer;
 public
  property DXMesh: ID3DXMesh read FDXMesh;

  function ComputeTangetBinormal(): Boolean;

  function Draw(): Boolean;

  constructor Create();
  destructor Destroy(); override;
 end;

//--------------------------------------------------------------------------
 TAsphyreMeshX = class(TAsphyreCustomMesh)
 public
  function LoadFromFile(const FileName: string): Boolean;
  function LoadFromRes(hModule: Cardinal; const ResName: string): Boolean;
 end;

//--------------------------------------------------------------------------
var
 TotalVerticesNo   : Integer = 0;
 TotalFacesNo      : Integer = 0;
 DrawPrimitiveCalls: Integer = 0;

//--------------------------------------------------------------------------
procedure ResetDrawInfo();

//--------------------------------------------------------------------------
implementation

//--------------------------------------------------------------------------
uses
 AsphyreColors, DX9Types;

//---------------------------------------------------------------------------
const
 TangentBinormalElements: array[0..5] of
  TD3DVertexElement9 =
 (// Position
  (Stream: 0; Offset: 0; _Type: D3DDECLTYPE_FLOAT3;
   Method: D3DDECLMETHOD_DEFAULT; Usage: D3DDECLUSAGE_POSITION; UsageIndex: 0),
  // Tangent
  (Stream: 0; Offset: 12; _Type: D3DDECLTYPE_FLOAT3;
   Method: D3DDECLMETHOD_DEFAULT; Usage: D3DDECLUSAGE_TANGENT; UsageIndex: 0),
  // Binormal
  (Stream: 0; Offset: 24; _Type: D3DDECLTYPE_FLOAT3;
   Method: D3DDECLMETHOD_DEFAULT; Usage: D3DDECLUSAGE_BINORMAL; UsageIndex: 0),
  // Normal
  (Stream: 0; Offset: 36; _Type: D3DDECLTYPE_FLOAT3;
   Method: D3DDECLMETHOD_DEFAULT; Usage: D3DDECLUSAGE_NORMAL; UsageIndex: 0),
  // TexCoord
  (Stream: 0; Offset: 48; _Type: D3DDECLTYPE_FLOAT2;
   Method: D3DDECLMETHOD_DEFAULT; Usage: D3DDECLUSAGE_TEXCOORD; UsageIndex: 0),
  // D3DDECL_END()
  (Stream: $FF; Offset: 0; _Type: D3DDECLTYPE_UNUSED;
   Method: TD3DDeclMethod(0); Usage: TD3DDeclUsage(0); UsageIndex: 0));

//--------------------------------------------------------------------------
procedure ResetDrawInfo();
begin
 TotalVerticesNo:= 0;
 TotalFacesNo:= 0;
 DrawPrimitiveCalls:= 0;
end;

//--------------------------------------------------------------------------
constructor TAsphyreCustomMesh.Create();
begin
 inherited;

 FDXMesh:= nil;

 NumMaterials:= 1;
end;

//--------------------------------------------------------------------------
destructor TAsphyreCustomMesh.Destroy();
begin
 if (FDXMesh <> nil) then FDXMesh:= nil;

 inherited;
end;

//--------------------------------------------------------------------------
function TAsphyreCustomMesh.Draw(): Boolean;
var
 MaterialNo: Integer;
begin
 Result:= (FDXMesh <> nil);
 if (not Result) then Exit;

 Inc(TotalVerticesNo, FDXMesh.GetNumVertices);
 Inc(TotalFacesNo, FDXMesh.GetNumFaces);

 for MaterialNo:= 0 to NumMaterials - 1 do
  begin
   Inc(DrawPrimitiveCalls);
   Result:= Succeeded(FDXMesh.DrawSubset(MaterialNo));
   if (not Result) then Break;
  end;
end;

//--------------------------------------------------------------------------
function TAsphyreMeshX.LoadFromFile(const FileName: string): Boolean;
var
 Adjacency: ID3DXBuffer;
begin
 // (1) Perform validation.
 Result:= (Device9 <> nil);
 if (not Result) then Exit;

 // (2) Load mesh from external location.
 if (Failed(D3DXLoadMeshFromX(PChar(FileName), D3DXMESH_MANAGED,
  Device9, @Adjacency, nil, nil, @NumMaterials, FDXMesh))) then Exit;

 // (3) Optimize the loaded mesh.
 FDXMesh.OptimizeInplace(D3DXMESHOPT_COMPACT or D3DXMESHOPT_ATTRSORT or
  D3DXMESHOPT_VERTEXCACHE, Adjacency.GetBufferPointer(), nil, nil, nil);

 Adjacency:= nil;
end;

//--------------------------------------------------------------------------
function TAsphyreMeshX.LoadFromRes(hModule: Cardinal;
 const ResName: string): Boolean;
var
 Adjacency: ID3DXBuffer;
begin
 // (1) Perform validation.
 Result:= (Device9 <> nil);
 if (not Result) then Exit;

 // (2) Load mesh from external location.
 Result:= Succeeded(D3DXLoadMeshFromXResource(hModule, PChar(ResName),
  RT_RCDATA, D3DXMESH_MANAGED, Device9, @Adjacency, nil, nil, nil,
  FDXMesh));
 if (not Result) then Exit;

 // (3) Optimize the loaded mesh.
 FDXMesh.OptimizeInplace(D3DXMESHOPT_COMPACT or D3DXMESHOPT_ATTRSORT or
  D3DXMESHOPT_VERTEXCACHE, Adjacency.GetBufferPointer(), nil, nil, nil);

 Adjacency:= nil;
end;

//--------------------------------------------------------------------------
function TAsphyreCustomMesh.ComputeTangetBinormal(): Boolean;
var
 ClonedMesh, TangentMesh: ID3DXMesh;
begin
 ClonedMesh := nil;
 TangentMesh:= nil;

 FDXMesh.CloneMesh(D3DXMESH_MANAGED, @TangentBinormalElements[0], Device9,
  ClonedMesh);

 Result:= Succeeded(D3DXComputeTangentFrameEx(ClonedMesh,
  Cardinal(D3DDECLUSAGE_TEXCOORD), 0,
  Cardinal(D3DDECLUSAGE_TANGENT), 0,
  Cardinal(D3DDECLUSAGE_BINORMAL), 0,
  Cardinal(D3DDECLUSAGE_NORMAL), 0,
  0, nil, 0.01, 0.25, 0.01, TangentMesh, nil));

 FDXMesh:= nil;
 ClonedMesh:= nil;
 FDXMesh:= TangentMesh;
 TangentMesh:= nil;
end;

//--------------------------------------------------------------------------
end.
