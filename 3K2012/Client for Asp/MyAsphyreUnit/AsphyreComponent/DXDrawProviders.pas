unit DXDrawProviders;
//---------------------------------------------------------------------------
// DX8Providers.pas                                     Modified: 05-May-2008
// DirectX 9.0 provider for Asphyre                               Version 1.0
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
// The Original Code is DX8Providers.pas.
//
// The Initial Developer of the Original Code is Yuriy Kotsarenko.
// Portions created by M. Sc. Yuriy Kotsarenko are Copyright (C) 2007 - 2008,
// Yuriy Kotsarenko. All Rights Reserved.
//---------------------------------------------------------------------------
interface

//---------------------------------------------------------------------------
uses
 SysUtils, AsphyreFactory, AbstractDevices, AbstractCanvas, AbstractTextures;

const
  idDraw = 13;
//---------------------------------------------------------------------------
type
 TDXDrawProvider = class(TAsphyreProvider)
 private
 public
  function CreateDevice(): TAsphyreDevice; override;
  function CreateCanvas(): TAsphyreCanvas; override;
  function CreateLockableTexture(): TAsphyreLockableTexture; override;
  function CreateRenderTargetTexture(): TAsphyreRenderTargetTexture; override;

  constructor Create();
  destructor Destroy(); override;
 end;

//---------------------------------------------------------------------------
var
 DXDrawProvider: TDXDrawProvider = nil;

//---------------------------------------------------------------------------
implementation

//---------------------------------------------------------------------------
uses
 DXDevices, DXCanvas, DXTextures;

//---------------------------------------------------------------------------
constructor TDXDrawProvider.Create();
begin
 inherited;

 FProviderID:= idDraw;

 Factory.Subscribe(Self);
end;

//---------------------------------------------------------------------------
destructor TDXDrawProvider.Destroy();
begin
 Factory.Unsubscribe(Self, True);

 inherited;
end;

//---------------------------------------------------------------------------
function TDXDrawProvider.CreateDevice(): TAsphyreDevice;
begin
 Result:= TDXDevice.Create();
end;

//---------------------------------------------------------------------------
function TDXDrawProvider.CreateCanvas(): TAsphyreCanvas;
begin
 Result:= TDXCanvas.Create();
end;

//---------------------------------------------------------------------------
function TDXDrawProvider.CreateLockableTexture(): TAsphyreLockableTexture;
begin
 Result:= TDXLockableTexture.Create();
end;

//---------------------------------------------------------------------------
function TDXDrawProvider.CreateRenderTargetTexture(): TAsphyreRenderTargetTexture;
begin
 Result:= TDXRenderTargetTexture.Create();
end;

//---------------------------------------------------------------------------
initialization
 DXDrawProvider:= TDXDrawProvider.Create();

//---------------------------------------------------------------------------
finalization
 FreeAndNil(DXDrawProvider);

//---------------------------------------------------------------------------
end.
