unit OGLProviders;
//---------------------------------------------------------------------------
// OGLProviders.pas                                     Modified: 16-Mar-2008
// OpenGL support provider                                        Version 1.0
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
// The Original Code is OGLProviders.pas.
//
// The Initial Developer of the Original Code is M. Sc. Yuriy Kotsarenko.
// Portions created by M. Sc. Yuriy Kotsarenko are Copyright (C) 2007,
// M. Sc. Yuriy Kotsarenko. All Rights Reserved.
//---------------------------------------------------------------------------
interface

//---------------------------------------------------------------------------
uses
 SysUtils, AsphyreFactory, AbstractDevices, AbstractCanvas, AbstractTextures;

//---------------------------------------------------------------------------
const
 idOpenGL = $20000000;

//---------------------------------------------------------------------------
type
 TOGLProvider = class(TAsphyreProvider)
 private
 public
  function CreateDevice(): TAsphyreDevice; override;
  function CreateCanvas(): TAsphyreCanvas; override;
  function CreateTexture(): TAsphyreTexture; override;

  constructor Create();
  destructor Destroy(); override;
 end;

//---------------------------------------------------------------------------
var
 OGLProvider: TOGLProvider = nil;

//---------------------------------------------------------------------------
implementation

//---------------------------------------------------------------------------
uses
 OGLDevices, OGLCanvas, OGLTextures;

//---------------------------------------------------------------------------
constructor TOGLProvider.Create();
begin
 inherited;

 FProviderID:= idOpenGL;

 Factory.Subscribe(Self);
end;

//---------------------------------------------------------------------------
destructor TOGLProvider.Destroy();
begin
 Factory.Unsubscribe(Self, True);

 inherited;
end;

//---------------------------------------------------------------------------
function TOGLProvider.CreateDevice(): TAsphyreDevice;
begin
 Result:= TOGLDevice.Create();
end;

//---------------------------------------------------------------------------
function TOGLProvider.CreateCanvas(): TAsphyreCanvas;
begin
 Result:= TOGLCanvas.Create();
end;

//---------------------------------------------------------------------------
function TOGLProvider.CreateTexture(): TAsphyreTexture;
begin
 Result:= TOGLTexture.Create();
end;

//---------------------------------------------------------------------------
initialization
 OGLProvider:= TOGLProvider.Create();

//---------------------------------------------------------------------------
finalization
 FreeAndNil(OGLProvider);

//---------------------------------------------------------------------------
end.
