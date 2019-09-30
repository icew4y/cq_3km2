unit AsphyreProceduralMeshes;
//---------------------------------------------------------------------------
// AsphyreProceduralMeshes.pas                          Modified: 20-May-2008
// The base framework for Asphyre procedural meshes              Version 1.01
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
// The Original Code is AsphyreProceduralMeshes.pas.
//
// The Initial Developer of the Original Code is Yuriy Kotsarenko.
// Portions created by Yuriy Kotsarenko are Copyright (C) 2007 - 2008,
// Yuriy Kotsarenko. All Rights Reserved.
//---------------------------------------------------------------------------
interface

//---------------------------------------------------------------------------
uses
 Windows, Direct3D9, D3DX9, SysUtils, Vectors2, Vectors3, AsphyreMeshes;

//---------------------------------------------------------------------------
type
 PProceduralVertex = ^TProceduralVertex;
 TProceduralVertex = record
  Position: TVector3;
  Normal  : TVector3;
  TexCoord: TPoint2;
 end;

//---------------------------------------------------------------------------
 TAsphyreProceduralMesh = class(TAsphyreCustomMesh)
 private
  CurVertex : PProceduralVertex;
  CurIndex  : PWord;
  FTexCoords: Boolean;
 protected
  function CreateBuffers(Faces, Vertices: Integer): Boolean;

  function LockBuffers(): Boolean;
  procedure UnlockBuffers();
  procedure IncludeVertex(const Position, Normal: TVector3;
   const TexCoord: TPoint2); overload;
  procedure IncludeIndex(Index: Integer);
 public
  property TexCoords: Boolean read FTexCoords write FTexCoords;

  constructor Create();
 end;

//---------------------------------------------------------------------------
implementation

//---------------------------------------------------------------------------
uses
 DX9Types;

//---------------------------------------------------------------------------
const
 VertexElementNo = 3;

//---------------------------------------------------------------------------
 VertexElementsT: array[0..3] of TD3DVertexElement9 =
 (// Position
  (Stream: 0; Offset: 0; _Type: D3DDECLTYPE_FLOAT3;
   Method: D3DDECLMETHOD_DEFAULT; Usage: D3DDECLUSAGE_POSITION; UsageIndex: 0),
  // Normal
  (Stream: 0; Offset: 12; _Type: D3DDECLTYPE_FLOAT3;
   Method: D3DDECLMETHOD_DEFAULT; Usage: D3DDECLUSAGE_NORMAL; UsageIndex: 0),
  // TexCoord
  (Stream: 0; Offset: 24; _Type: D3DDECLTYPE_FLOAT2;
   Method: D3DDECLMETHOD_DEFAULT; Usage: D3DDECLUSAGE_TEXCOORD; UsageIndex: 0),
  // D3DDECL_END()
  (Stream: $FF; Offset: 0; _Type: D3DDECLTYPE_UNUSED;
   Method: TD3DDeclMethod(0); Usage: TD3DDeclUsage(0); UsageIndex: 0));

//---------------------------------------------------------------------------
 VertexElements: array[0..2] of TD3DVertexElement9 =
 (// Position
  (Stream: 0; Offset: 0; _Type: D3DDECLTYPE_FLOAT3;
   Method: D3DDECLMETHOD_DEFAULT; Usage: D3DDECLUSAGE_POSITION; UsageIndex: 0),
  // Normal
  (Stream: 0; Offset: 12; _Type: D3DDECLTYPE_FLOAT3;
   Method: D3DDECLMETHOD_DEFAULT; Usage: D3DDECLUSAGE_NORMAL; UsageIndex: 0),
  // D3DDECL_END()
  (Stream: $FF; Offset: 0; _Type: D3DDECLTYPE_UNUSED;
   Method: TD3DDeclMethod(0); Usage: TD3DDeclUsage(0); UsageIndex: 0));

//---------------------------------------------------------------------------
constructor TAsphyreProceduralMesh.Create();
begin
 inherited;

 FTexCoords:= False;
end;

//---------------------------------------------------------------------------
function TAsphyreProceduralMesh.CreateBuffers(Faces, Vertices: Integer): Boolean;
var
 Elem: Pointer;
begin
 if (FDXMesh <> nil) then FDXMesh:= nil;

 Elem:= @VertexElements[0];
 if (FTexCoords) then Elem:= @VertexElementsT[0];

 Result:= Succeeded(D3DXCreateMesh(Faces, Vertices, D3DXMESH_MANAGED, Elem,
  Device9, FDXMesh));
end;

//---------------------------------------------------------------------------
function TAsphyreProceduralMesh.LockBuffers(): Boolean;
begin
 if (FDXMesh = nil) then
  begin
   Result:= False;
   Exit;
  end;

 Result:= Succeeded(FDXMesh.LockVertexBuffer(0, Pointer(CurVertex)));
 if (not Result) then Exit;

 Result:= Succeeded(FDXMesh.LockIndexBuffer(0, Pointer(CurIndex)));
 if (not Result) then Exit;
end;

//---------------------------------------------------------------------------
procedure TAsphyreProceduralMesh.UnlockBuffers();
begin
 if (FDXMesh <> nil) then
  begin
   FDXMesh.UnlockIndexBuffer();
   FDXMesh.UnlockVertexBuffer();
  end;
end;

//---------------------------------------------------------------------------
procedure TAsphyreProceduralMesh.IncludeVertex(const Position, Normal: TVector3;
 const TexCoord: TPoint2);
begin
 CurVertex.Position:= Position;
 CurVertex.Normal  := Normal;

 if (FTexCoords) then
  begin
   CurVertex.TexCoord:= TexCoord;
   Inc(CurVertex);
  end else
  begin
   Inc(Integer(CurVertex), SizeOf(TVector3) * 2);
  end;
end;

//---------------------------------------------------------------------------
procedure TAsphyreProceduralMesh.IncludeIndex(Index: Integer);
begin
 CurIndex^:= Index;
 Inc(CurIndex);
end;

//---------------------------------------------------------------------------
(*procedure TAsphyreProceduralMesh.OptimizeMesh();
var
 Adjacency: ID3DXBuffer;
begin
 D3DXCreateBuffer(3 * FMesh.GetNumFaces * SizeOf(Longword), Adjacency);
 FMesh.GenerateAdjacency(0.01, Adjacency.GetBufferPointer());

 FMesh.OptimizeInplace({D3DXMESHOPT_COMPACT or D3DXMESHOPT_ATTRSORT or
  D3DXMESHOPT_VERTEXCACHE or }D3DXMESHOPT_STRIPREORDER,
  Adjacency.GetBufferPointer(), nil, nil, nil);

 Adjacency:= nil;
end;*)

//---------------------------------------------------------------------------
end.
