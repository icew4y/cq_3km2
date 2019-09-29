unit AsphyreShaderFX;
//---------------------------------------------------------------------------
// AsphyreShaderFX.pas                                  Modified: 21-May-2008
// A wrapper for HLSL shaders and effect framework                Version 1.0
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
// The Original Code is AsphyreShaderFX.pas.
//
// The Initial Developer of the Original Code is Yuriy Kotsarenko.
// Portions created by Yuriy Kotsarenko are Copyright (C) 2007 - 2008,
// Yuriy Kotsarenko. All Rights Reserved.
//---------------------------------------------------------------------------
interface

//---------------------------------------------------------------------------
uses
 Windows, d3dx9, AbstractDevices, AbstractTextures, AsphyreMeshes;

//---------------------------------------------------------------------------
type
 TAsphyreShaderEffect = class
 private
  FEffect: ID3DXEffect;

  FNumPasses: Integer;

  ResetHandle: Cardinal;
  LostHandle : Cardinal;

  procedure OnDeviceReset(Sender: TObject; Param: Pointer;
   var Handled: Boolean);
  procedure OnDeviceLost(Sender: TObject; Param: Pointer;
   var Handled: Boolean);

  function GetTechnique(): string;
  procedure SetTechnique(const Value: string);
 protected
  procedure DoEffectLoad(); virtual;
  procedure DrawMeshPasses(Mesh: TAsphyreCustomMesh); virtual;
 public
  property Effect: ID3DXEffect read FEffect;

  property Technique: string read GetTechnique write SetTechnique;

  property NumPasses: Integer read FNumPasses;

  function LoadFromFile(const FileName: string): Boolean;
  function LoadFromResource(hModule: Cardinal;
   const ResourceName: string): Boolean;

  procedure BeginAll();
  procedure EndAll();
  function BeginPass(PassNo: Integer): Boolean;
  procedure EndPass();

  procedure GetParameter(const Name: string; Data: Pointer; DataSize: Integer);
  procedure SetParameter(const Name: string; Data: Pointer; DataSize: Integer);
  procedure SetTexture(const Name: string; Texture: TAsphyreCustomTexture);

  constructor Create();
  destructor Destroy(); override;
 end;

//---------------------------------------------------------------------------
implementation

//---------------------------------------------------------------------------
uses
 Direct3D9, DX9Types, DX9Textures;

//---------------------------------------------------------------------------
constructor TAsphyreShaderEffect.Create();
begin
 inherited;

 LostHandle := EventDeviceLost.Subscribe(OnDeviceLost, -1);
 ResetHandle:= EventDeviceReset.Subscribe(OnDeviceReset, -1);
end;

//---------------------------------------------------------------------------
destructor TAsphyreShaderEffect.Destroy();
begin
 EventDeviceReset.Unsubscribe(ResetHandle);
 EventDeviceLost.Unsubscribe(LostHandle);

 if (FEffect <> nil) then FEffect:= nil;

 inherited;
end;

//---------------------------------------------------------------------------
function TAsphyreShaderEffect.GetTechnique(): string;
var
 Handle: TD3DXHandle;
 Desc  : TD3DXTechniqueDesc;
begin
 Result:= '';
 if (FEffect = nil) then Exit;

 Handle:= FEffect.GetCurrentTechnique();
 if (Handle = nil) then Exit;

 if (Failed(FEffect.GetTechniqueDesc(Handle, Desc))) then Exit;

 Result:= Desc.Name;
end;

//---------------------------------------------------------------------------
procedure TAsphyreShaderEffect.SetTechnique(const Value: string);
var
 Handle: TD3DXHandle;
begin
 if (FEffect <> nil) then
  begin
   Handle:= FEffect.GetTechniqueByName(PAnsiChar(Value));
   if (Handle <> nil) then FEffect.SetTechnique(Handle);
  end;
end;

//---------------------------------------------------------------------------
procedure TAsphyreShaderEffect.GetParameter(const Name: string; Data: Pointer;
 DataSize: Integer);
var
 Handle:  TD3DXHandle;
 pFailed: Boolean;
begin
 pFailed:= True;

 if (FEffect <> nil) then
  begin
   Handle:= FEffect.GetParameterByName(nil, PChar(Name));

   if (Handle <> nil) then
    pFailed:= Failed(FEffect.GetValue(Handle, Data, DataSize));
  end;

 if (pFailed) then FillChar(Data^, DataSize, 0);
end;

//---------------------------------------------------------------------------
procedure TAsphyreShaderEffect.SetParameter(const Name: string; Data: Pointer;
 DataSize: Integer);
var
 Handle: TD3DXHandle;
begin
 if (FEffect <> nil) then
  begin
   Handle:= FEffect.GetParameterByName(nil, PChar(Name));
   if (Handle <> nil) then
    FEffect.SetValue(Handle, Data, DataSize);
  end;
end;

//---------------------------------------------------------------------------
procedure TAsphyreShaderEffect.SetTexture(const Name: string;
 Texture: TAsphyreCustomTexture);
var
 Handle: TD3DXHandle;
 TexPtr: IDirect3DTexture9;
begin
 TexPtr:= nil;

 if (Texture is TDX9LockableTexture) then
  TexPtr:= TDX9LockableTexture(Texture).Texture;

 if (Texture is TDX9RenderTargetTexture) then
  TexPtr:= TDX9RenderTargetTexture(Texture).Texture;

 if (FEffect <> nil)and(TexPtr <> nil) then
  begin
   Handle:= FEffect.GetParameterByName(nil, PChar(Name));
   if (Handle <> nil) then FEffect.SetTexture(Handle, TexPtr);

   TexPtr:= nil;
  end;
end;

//---------------------------------------------------------------------------
procedure TAsphyreShaderEffect.OnDeviceLost(Sender: TObject; Param: Pointer;
 var Handled: Boolean);
begin
 if (FEffect <> nil) then FEffect.OnLostDevice();
end;

//---------------------------------------------------------------------------
procedure TAsphyreShaderEffect.OnDeviceReset(Sender: TObject; Param: Pointer;
 var Handled: Boolean);
begin
 if (FEffect <> nil) then FEffect.OnResetDevice();
end;

//---------------------------------------------------------------------------
function TAsphyreShaderEffect.LoadFromFile(const FileName: string): Boolean;
var
 Errors: ID3DXBuffer;
begin
 if (FEffect <> nil) then FEffect:= nil;

 Result:= Succeeded(D3DXCreateEffectFromFile(Device9, PAnsiChar(FileName),
  nil, nil, 0, nil, FEffect, @Errors));

 if (Errors <> nil) then
  OutputDebugString(Errors.GetBufferPointer());

 if (Result) then DoEffectLoad();
end;

//---------------------------------------------------------------------------
function TAsphyreShaderEffect.LoadFromResource(hModule: Cardinal;
 const ResourceName: string): Boolean;
var
 Errors: ID3DXBuffer;
begin
 if (FEffect <> nil) then FEffect:= nil;

 Result:= Succeeded(D3DXCreateEffectFromResource(Device9, hModule,
  pChar(ResourceName), nil, nil, 0, nil, FEffect, @Errors));

 if (Errors <> nil) then
  OutputDebugString(Errors.GetBufferPointer());

 if (Result) then DoEffectLoad();
end;

//---------------------------------------------------------------------------
procedure TAsphyreShaderEffect.BeginAll();
begin
 if (FEffect <> nil) then FEffect._Begin(@FNumPasses, 0);
end;

//---------------------------------------------------------------------------
procedure TAsphyreShaderEffect.EndAll();
begin
 if (FEffect <> nil) then FEffect._End();
end;

//---------------------------------------------------------------------------
function TAsphyreShaderEffect.BeginPass(PassNo: Integer): Boolean;
begin
 if (FEffect = nil) then
  begin
   Result:= False;
   Exit;
  end;

 Result:= Succeeded(FEffect.BeginPass(PassNo));
end;

//---------------------------------------------------------------------------
procedure TAsphyreShaderEffect.EndPass();
begin
 if (FEffect <> nil) then FEffect.EndPass();
end;

//---------------------------------------------------------------------------
procedure TAsphyreShaderEffect.DoEffectLoad();
begin
 // no code
end;

//---------------------------------------------------------------------------
procedure TAsphyreShaderEffect.DrawMeshPasses(Mesh: TAsphyreCustomMesh);
var
 PassNo: Integer;
begin
 for PassNo:= 0 to NumPasses - 1 do
  begin
   if (not BeginPass(PassNo)) then Break;

   Mesh.Draw();

   EndPass();
  end;
end;

//---------------------------------------------------------------------------
end.
