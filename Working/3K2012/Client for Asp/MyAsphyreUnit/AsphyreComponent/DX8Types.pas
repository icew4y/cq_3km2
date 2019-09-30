unit DX8Types;
//---------------------------------------------------------------------------
// DX8Types.pas                                         Modified: 16-Apr-2008
// Shared DirectX 9.0 types and variables                         Version 1.0
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
// The Original Code is DX9Types.pas.
//
// The Initial Developer of the Original Code is Yuriy Kotsarenko.
// Portions created by M. Sc. Yuriy Kotsarenko are Copyright (C) 2007,
// Yuriy Kotsarenko. All Rights Reserved.
//---------------------------------------------------------------------------
interface

//---------------------------------------------------------------------------
uses
 Direct3D8, Windows, SysUtils, AsphyreTypes;

//---------------------------------------------------------------------------
function D3DFormatToPixelFormat(Format: TD3DFormat): TAsphyrePixelFormat;
function PixelFormatToD3DFormat(Format: TAsphyrePixelFormat): TD3DFormat;

//---------------------------------------------------------------------------
function ApproximateTextureFormat(Format: TAsphyrePixelFormat;
 Usage: Cardinal): TAsphyrePixelFormat;

//---------------------------------------------------------------------------
var
 Direct3D: IDirect3D8 = nil;
 Device8 : IDirect3DDevice8 = nil;   
 g_Caps8   : TD3DCaps8;
 Params8 : TD3DPresentParameters;
 Adapter8: Cardinal = 0;
 function DXGErrorString(ErrorValue : HResult) : string;
//---------------------------------------------------------------------------
implementation

//---------------------------------------------------------------------------
uses
 AsphyreFormats;

function DXGErrorString(ErrorValue : HResult) : string;
begin
//You should better use D3DXErrorString
  case ErrorValue of
    HResult(D3D_OK)                           : Result := 'No error occurred.';
    HResult(D3DERR_CONFLICTINGRENDERSTATE)    : Result := 'The currently set render states cannot be used together.';
    HResult(D3DERR_CONFLICTINGTEXTUREFILTER)  : Result := 'The current texture filters cannot be used together.';
    HResult(D3DERR_CONFLICTINGTEXTUREPALETTE) : Result := 'The current textures cannot be used simultaneously. This generally occurs when a multitexture device requires that all palletized textures simultaneously enabled also share the same palette.';
    HResult(D3DERR_DEVICELOST)                : Result := 'The device is lost and cannot be restored at the current time, so rendering is not possible.';
    HResult(D3DERR_DEVICENOTRESET)            : Result := 'The device cannot be reset.';
    HResult(D3DERR_DRIVERINTERNALERROR)       : Result := 'Internal driver error.';
    HResult(D3DERR_INVALIDCALL)               : Result := 'The method call is invalid. For example, a method''s parameter may have an invalid value.';
    HResult(D3DERR_INVALIDDEVICE)             : Result := 'The requested device type is not valid.';
    HResult(D3DERR_MOREDATA)                  : Result := 'There is more data available than the specified buffer size can hold.';
    HResult(D3DERR_NOTAVAILABLE)              : Result := 'This device does not support the queried technique.';
    HResult(D3DERR_NOTFOUND)                  : Result := 'The requested item was not found.';
    HResult(D3DERR_OUTOFVIDEOMEMORY)          : Result := 'Direct3D does not have enough display memory to perform the operation.';
    HResult(D3DERR_TOOMANYOPERATIONS)         : Result := 'The application is requesting more texture-filtering operations than the device';
    HResult(D3DERR_UNSUPPORTEDALPHAARG)       : Result := 'The device does not support a specified texture-blending argument for the alpha channel.';
    HResult(D3DERR_UNSUPPORTEDALPHAOPERATION) : Result := 'The device does not support a specified texture-blending operation for the alpha channel.';
    HResult(D3DERR_UNSUPPORTEDCOLORARG)       : Result := 'The device does not support a specified texture-blending argument for color values.';
    HResult(D3DERR_UNSUPPORTEDCOLOROPERATION) : Result := 'The device does not support a specified texture-blending operation for color values.';
    HResult(D3DERR_UNSUPPORTEDFACTORVALUE)    : Result := 'The device does not support the specified texture factor value.';
    HResult(D3DERR_UNSUPPORTEDTEXTUREFILTER)  : Result := 'The device does not support the specified texture filter.';
    HResult(D3DERR_WRONGTEXTUREFORMAT)        : Result := 'The pixel format of the texture surface is not valid.';
    HResult(E_FAIL)                           : Result := 'An undetermined error occurred inside the Direct3D subsystem.';
    HResult(E_INVALIDARG)                     : Result := 'An invalid parameter was passed to the returning function';
//    HResult(E_INVALIDCALL)                    : Result := 'The method call is invalid. For example, a method''s parameter may have an invalid value.';
    HResult(E_OUTOFMEMORY)                    : Result := 'Direct3D could not allocate sufficient memory to complete the call.';

    else Result := 'Unknown Error : ' + IntToStr(ErrorValue);
  end;
end;
//---------------------------------------------------------------------------
function D3DFormatToPixelFormat(Format: TD3DFormat): TAsphyrePixelFormat;
begin
 case Format of
  D3DFMT_R8G8B8: Result:= apf_R8G8B8;
  D3DFMT_A8R8G8B8: Result:= apf_A8R8G8B8;
  D3DFMT_X8R8G8B8: Result:= apf_X8R8G8B8;
  D3DFMT_R5G6B5: Result:= apf_R5G6B5;
  D3DFMT_X1R5G5B5: Result:= apf_X1R5G5B5;
  D3DFMT_A1R5G5B5: Result:= apf_A1R5G5B5;
  D3DFMT_A4R4G4B4: Result:= apf_A4R4G4B4;
  D3DFMT_R3G3B2: Result:= apf_R3G3B2;
  D3DFMT_A8: Result:= apf_A8;
  D3DFMT_A8R3G3B2: Result:= apf_A8R3G3B2;
  D3DFMT_X4R4G4B4: Result:= apf_X4R4G4B4;
  D3DFMT_A2B10G10R10: Result:= apf_A2B10G10R10;
//  D3DFMT_A8B8G8R8: Result:= apf_A8B8G8R8;
//  D3DFMT_X8B8G8R8: Result:= apf_X8B8G8R8;
  D3DFMT_G16R16: Result:= apf_G16R16;
//  D3DFMT_A2R10G10B10: Result:= apf_A2R10G10B10;
//  D3DFMT_A16B16G16R16: Result:= apf_A16B16G16R16;
  D3DFMT_L8: Result:= apf_L8;
  D3DFMT_A8L8: Result:= apf_A8L8;
  D3DFMT_A4L4: Result:= apf_A4L4;
  D3DFMT_V8U8: Result:= apf_V8U8;
  D3DFMT_L6V5U5: Result:= apf_L6V5U5;
  D3DFMT_X8L8V8U8: Result:= apf_X8L8V8U8;
  D3DFMT_Q8W8V8U8: Result:= apf_Q8W8V8U8;
  D3DFMT_V16U16: Result:= apf_V16U16;
  D3DFMT_A2W10V10U10: Result:= apf_A2W10V10U10;
//  D3DFMT_A8X8V8U8: Result:= apf_A8X8V8U8;
//  D3DFMT_L8X8V8U8: Result:= apf_L8X8V8U8;
  D3DFMT_UYVY: Result:= apf_UYVY;
  D3DFMT_YUY2: Result:= apf_YUY2;
  D3DFMT_DXT1: Result:= apf_DXT1;
  D3DFMT_DXT2: Result:= apf_DXT2;
  D3DFMT_DXT3: Result:= apf_DXT3;
  D3DFMT_DXT4: Result:= apf_DXT4;
  D3DFMT_DXT5: Result:= apf_DXT5;
//  D3DFMT_L16: Result:= apf_L16;
//  D3DFMT_Q16W16V16U16: Result:= apf_Q16W16V16U16;
//  D3DFMT_R16F: Result:= apf_R16F;
//  D3DFMT_G16R16F: Result:= apf_G16R16F;
//  D3DFMT_A16B16G16R16F: Result:= apf_A16B16G16R16F;
//  D3DFMT_R32F: Result:= apf_R32F;
//  D3DFMT_G32R32F: Result:= apf_G32R32F;
//  D3DFMT_A32B32G32R32F: Result:= apf_A32B32G32R32F;
//  D3DFMT_CxV8U8: Result:= apf_CxV8U8;

  else Result:= apf_Unknown;
 end;
end;

//---------------------------------------------------------------------------
function PixelFormatToD3DFormat(Format: TAsphyrePixelFormat): TD3DFormat;
begin
 case Format of
  apf_R8G8B8: Result:= D3DFMT_R8G8B8;
  apf_A8R8G8B8: Result:= D3DFMT_A8R8G8B8;
  apf_X8R8G8B8: Result:= D3DFMT_X8R8G8B8;
  apf_R5G6B5: Result:= D3DFMT_R5G6B5;
  apf_X1R5G5B5: Result:= D3DFMT_X1R5G5B5;
  apf_A1R5G5B5: Result:= D3DFMT_A1R5G5B5;
  apf_A4R4G4B4: Result:= D3DFMT_A4R4G4B4;
  apf_R3G3B2: Result:= D3DFMT_R3G3B2;
  apf_A8: Result:= D3DFMT_A8;
  apf_A8R3G3B2: Result:= D3DFMT_A8R3G3B2;
  apf_X4R4G4B4: Result:= D3DFMT_X4R4G4B4;
  apf_A2B10G10R10: Result:= D3DFMT_A2B10G10R10;
//  apf_A8B8G8R8: Result:= D3DFMT_A8B8G8R8;
//  apf_X8B8G8R8: Result:= D3DFMT_X8B8G8R8;
  apf_G16R16: Result:= D3DFMT_G16R16;
//  apf_A2R10G10B10: Result:= D3DFMT_A2R10G10B10;
//  apf_A16B16G16R16: Result:= D3DFMT_A16B16G16R16;
  apf_L8: Result:= D3DFMT_L8;
  apf_A8L8: Result:= D3DFMT_A8L8;
  apf_A4L4: Result:= D3DFMT_A4L4;
  apf_V8U8: Result:= D3DFMT_V8U8;
  apf_L6V5U5: Result:= D3DFMT_L6V5U5;
  apf_X8L8V8U8: Result:= D3DFMT_X8L8V8U8;
  apf_Q8W8V8U8: Result:= D3DFMT_Q8W8V8U8;
  apf_V16U16: Result:= D3DFMT_V16U16;
  apf_A2W10V10U10: Result:= D3DFMT_A2W10V10U10;
//  apf_A8X8V8U8: Result:= D3DFMT_A8X8V8U8;
//  apf_L8X8V8U8: Result:= D3DFMT_L8X8V8U8;
  apf_UYVY: Result:= D3DFMT_UYVY;
  apf_YUY2: Result:= D3DFMT_YUY2;
  apf_DXT1: Result:= D3DFMT_DXT1;
  apf_DXT2: Result:= D3DFMT_DXT2;
  apf_DXT3: Result:= D3DFMT_DXT3;
  apf_DXT4: Result:= D3DFMT_DXT4;
  apf_DXT5: Result:= D3DFMT_DXT5;
//  apf_L16: Result:= D3DFMT_L16;
//  apf_Q16W16V16U16: Result:= D3DFMT_Q16W16V16U16;
//  apf_R16F: Result:= D3DFMT_R16F;
//  apf_G16R16F: Result:= D3DFMT_G16R16F;
//  apf_A16B16G16R16F: Result:= D3DFMT_A16B16G16R16F;
//  apf_R32F: Result:= D3DFMT_R32F;
//  apf_G32R32F: Result:= D3DFMT_G32R32F;
//  apf_A32B32G32R32F: Result:= D3DFMT_A32B32G32R32F;
//  apf_CxV8U8: Result:= D3DFMT_CxV8U8;

  else Result:= D3DFMT_UNKNOWN;
 end;
end;

//---------------------------------------------------------------------------
function ApproximateTextureFormat(Format: TAsphyrePixelFormat;
 Usage: Cardinal): TAsphyrePixelFormat;
var
 Supported: TAsphyreFormatList;
 Sample   : TAsphyrePixelFormat;
 DFormat  : TD3DFormat;
begin
 Result:= apf_Unknown;
 if (Direct3D = nil) then Exit;

 Supported:= TAsphyreFormatList.Create();

 for Sample:= Low(TAsphyrePixelFormat) to High(TAsphyrePixelFormat) do
  begin
   DFormat:= PixelFormatToD3DFormat(Sample);
   if (DFormat = D3DFMT_UNKNOWN) then Continue;

   if (Succeeded(Direct3D.CheckDeviceFormat(Adapter8, D3DDEVTYPE_HAL,
    Params8.BackBufferFormat, Usage, D3DRTYPE_TEXTURE, DFormat))) then
    Supported.Insert(Sample);
  end;

 Result:= FindClosestFormat(Format, Supported);

 FreeAndNil(Supported);
end;

//---------------------------------------------------------------------------
initialization
 FillChar(g_Caps8, SizeOf(TD3DCaps8), 0);
 FillChar(Params8, SizeOf(TD3DPresentParameters), 0);

//---------------------------------------------------------------------------
finalization

//---------------------------------------------------------------------------
end.
