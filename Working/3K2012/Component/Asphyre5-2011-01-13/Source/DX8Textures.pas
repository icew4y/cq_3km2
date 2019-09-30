unit DX8Textures;
//---------------------------------------------------------------------------
// DX8Textures.pas                                      Modified: 05-May-2008
// Texture implementation using DirectX 9.0                       Version 1.0
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
// The Original Code is DX8Textures.pas.
//
// The Initial Developer of the Original Code is Yuriy Kotsarenko.
// Portions created by M. Sc. Yuriy Kotsarenko are Copyright (C) 2007 - 2008,
// Yuriy Kotsarenko. All Rights Reserved.
//---------------------------------------------------------------------------

//---------------------------------------------------------------------------
// Use Delphi Compatibility mode in FreePascal
//---------------------------------------------------------------------------
{$IFDEF fpc}{$MODE delphi}{$ENDIF}

//---------------------------------------------------------------------------
interface

//---------------------------------------------------------------------------
uses
  Windows, Direct3D8, Types, SysUtils, AsphyreTypes, AbstractTextures, D3DX8,
  SystemSurfaces, Vectors2px;

//---------------------------------------------------------------------------
type
  TDX8LockableTexture = class(TAsphyreLockableTexture)
  private
    FTexture: IDirect3DTexture8;
    TextureUsage: Cardinal;
    TexturePool: TD3DPool;

    procedure ComputeParams();
    function CreateTextureInstance(): Boolean; overload;
    function CreateTextureInstance(SrcData: Pointer; SrcDataSize: LongWord; BitCount: Byte): Boolean; overload;
    procedure DestroyTextureInstance();
  protected
    procedure UpdateSize(); override;

    function CreateTexture(SrcData: Pointer; SrcDataSize: LongWord; BitCount: Byte): Boolean; overload; override;
    function CreateTexture(): Boolean; overload; override;
    procedure DestroyTexture(); override;
  public
    DFormat: TD3DFormat;
    property Texture: IDirect3DTexture8 read FTexture;
    function LoadFromFile(const AFileName: string; AMipMapping: Boolean = True): Boolean; override;
    //function SaveToFile(const AFileName: string): Boolean; override;
    procedure Bind(Stage: Integer); override;

    procedure HandleDeviceReset(); override;
    procedure HandleDeviceLost(); override;

    procedure UpdateMipmaps(); override;

    procedure Lock(const Rect: TRect; out Bits: Pointer;
      out Pitch: Integer); override;
    procedure Unlock(); override;
    constructor Create(); override;
  end;

//---------------------------------------------------------------------------
  TDX8RenderTargetTexture = class(TAsphyreRenderTargetTexture)
  private
    FTexture: IDirect3DTexture8;
    FDepthBuffer: IDirect3DSurface8;
    SavedSurface: IDirect3DSurface8;
    SavedDepthBuf: IDirect3DSurface8;

    function CreateTextureInstance(): Boolean;
    procedure DestroyTextureInstance();
  protected
    procedure UpdateSize(); override;

    function CreateTexture(): Boolean; override;
    procedure DestroyTexture(); override;
  public
    DFormat: TD3DFormat;
    property Texture: IDirect3DTexture8 read FTexture;
    property DepthBuffer: IDirect3DSurface8 read FDepthBuffer;

    procedure Bind(Stage: Integer); override;

    procedure HandleDeviceReset(); override;
    procedure HandleDeviceLost(); override;

    procedure UpdateMipmaps(); override;

    function BeginDrawTo(): Boolean; override;
    procedure EndDrawTo(); override;

    constructor Create(); override;
  end;

//---------------------------------------------------------------------------
implementation

//---------------------------------------------------------------------------
uses
  AsphyreErrors, DX8Types;

//---------------------------------------------------------------------------

constructor TDX8LockableTexture.Create();
begin
  inherited;
  FTexture := nil;
  TextureUsage := 0;
  TexturePool := D3DPOOL_SCRATCH;
end;

//---------------------------------------------------------------------------

procedure TDX8LockableTexture.ComputeParams();
begin
  TextureUsage := 0;
  TexturePool := D3DPOOL_MANAGED;

  if (MipMapping) then TextureUsage := 0;

  if (DynamicTexture) then
  begin
    TextureUsage := TextureUsage or D3DUSAGE_DYNAMIC;
    TexturePool := D3DPOOL_DEFAULT;
  end;

  FFormat := ApproximateTextureFormat(FFormat, TextureUsage);

  if (FFormat = apf_Unknown) then
    Errors.Insert(errUnsupportedFormat, Self, ClassName, 'ComputeParams');
end;

//---------------------------------------------------------------------------

function TDX8LockableTexture.LoadFromFile(const AFileName: string; AMipMapping: Boolean = True): Boolean;
begin
  Result := False;
  if Active then DestroyTexture;
  if (not Active) then
    //Result := Succeeded(D3DXCreateTextureFromFile(Device8, PChar(AFileName), FTexture));  用此函数会被拉伸
  if not Result then
    Result := inherited LoadFromFile(AFileName, AMipMapping);
end;
//---------------------------------------------------------------------------

{function TDX8LockableTexture.SaveToFile(const AFileName: string): Boolean;
begin
  Result := Succeeded(D3DXSaveTextureToFile(PChar(AFileName), D3DXIFF_BMP, FTexture, nil));
//  Result := inherited SaveToFile(AFileName);
end;}
//---------------------------------------------------------------------------

function TDX8LockableTexture.CreateTextureInstance(SrcData: Pointer; SrcDataSize: LongWord; BitCount: Byte): Boolean;
var
  Levels: Integer;

  ImageInfo: TD3DXImageInfo;
  Palette: TPaletteEntry;
  pDesc: TD3DSurfaceDesc;
begin
  TextureUsage := 0;
  if (MipMapping) then Levels := 0 else Levels := 1;
  DFormat := D3DFMT_A8R8G8B8;//PixelFormatToD3DFormat(FFormat);

  Result := Succeeded(D3DXCreateTextureFromFileInMemoryEx(Device8, SrcData^, SrcDataSize,
    D3DX_DEFAULT, D3DX_DEFAULT, Levels, TextureUsage, DFormat, TexturePool, D3DX_FILTER_NONE, D3DX_DEFAULT, D3DCOLOR_ARGB(255, 0, 0, 0), nil, nil, FTexture)); //D3DCOLOR_RGBA(0,0,0,255), @ImageInfo @PaletteEntry

  if (not Result) then
    Errors.Insert(errCannotCreateTexture, Self, ClassName,
      'CreateTextureInstanceFrom:' + IntToStr(GetLastError))
  else begin
    if Succeeded(FTexture.GetLevelDesc(0, pDesc)) then begin
      MemoryWidth := pDesc.Width;
      MemoryHeight := pDesc.Height;
    end;
  end;
end;

//---------------------------------------------------------------------------

function TDX8LockableTexture.CreateTextureInstance(): Boolean;
var
  Levels: Integer;
  pDesc: TD3DSurfaceDesc;
begin
  Levels := 1;
  if (MipMapping) then Levels := 0;

  DFormat := PixelFormatToD3DFormat(FFormat);
//D3DXCreateTexture(FD3DDevice,Image.X1,Image.Y1,MipmapLevels,0, D3DFMT_A8R8G8B8,D3DPOOL_MANAGED,PTex)
  Result := Succeeded(Device8.CreateTexture(Width, Height, Levels, TextureUsage,
    DFormat, TexturePool, FTexture));

  if (not Result) then
    Errors.Insert(errCannotCreateTexture, Self, ClassName,
      'CreateTextureInstance')
  else begin
    if Succeeded(FTexture.GetLevelDesc(0, pDesc)) then begin
      MemoryWidth := pDesc.Width;
      MemoryHeight := pDesc.Height;

    end;
  end;
end;

//---------------------------------------------------------------------------

procedure TDX8LockableTexture.DestroyTextureInstance();
begin
  if (FTexture <> nil) then FTexture := nil;
end;

//---------------------------------------------------------------------------

function TDX8LockableTexture.CreateTexture(): Boolean;
begin
  ComputeParams();

  Result := (Device8 <> nil);
  if (not Result) then
  begin
    Errors.Insert(errInvalidCall, Self, ClassName, 'CreateTexture');
    Exit;
  end;

  Result := CreateTextureInstance();
end;
//---------------------------------------------------------------------------

function TDX8LockableTexture.CreateTexture(SrcData: Pointer; SrcDataSize: LongWord; BitCount: Byte): Boolean;
begin
  ComputeParams();

  Result := (Device8 <> nil);
  if (not Result) then
  begin
    Errors.Insert(errInvalidCall, Self, ClassName, 'CreateTexture');
    Exit;
  end;

  Result := CreateTextureInstance(SrcData, SrcDataSize, BitCount);
end;
//---------------------------------------------------------------------------

procedure TDX8LockableTexture.DestroyTexture();
begin
  DestroyTextureInstance();
  inherited DestroyTexture;//FActive := False By TasNat at: 2012-03-11 16:38:18
end;

//---------------------------------------------------------------------------

procedure TDX8LockableTexture.HandleDeviceReset();
begin
  if (FTexture = nil) and (FFormat <> apf_Unknown) and
    (TexturePool = D3DPOOL_DEFAULT) then CreateTextureInstance();
end;

//---------------------------------------------------------------------------

procedure TDX8LockableTexture.HandleDeviceLost();
begin
  if (TexturePool = D3DPOOL_DEFAULT) then DestroyTextureInstance();
end;

//---------------------------------------------------------------------------

procedure TDX8LockableTexture.Bind(Stage: Integer);
begin
  if (Device8 = nil) or (FTexture = nil) then
    Errors.Insert(errInvalidCall, Self, ClassName, 'Bind');

  if (Device8 = nil) then Exit;

  if (FTexture <> nil) then Device8.SetTexture(Stage, FTexture)
  else Device8.SetTexture(Stage, nil);
end;

//---------------------------------------------------------------------------

procedure TDX8LockableTexture.Lock(const Rect: TRect; out Bits: Pointer;
  out Pitch: Integer);
var
  LockedRect: TD3DLockedRect;
  Usage: Cardinal;
  RectPtr: Pointer;
begin
  Bits := nil;
  Pitch := 0;

  if (FTexture = nil) then
  begin
    Errors.Insert(errInvalidCall, Self, ClassName, 'Lock');
    Exit;
  end;

 // If the rectangle specified in Rect is the entire texture, then provide
 // null pointer instead.
  RectPtr := @Rect;
  if (Rect.Left = 0) and (Rect.Top = 0) and (Rect.Right = Width) and
    (Rect.Bottom = Height) then RectPtr := nil;

  Usage := 0;
  if (DynamicTexture) then
  begin
    Usage := D3DLOCK_DISCARD;

   // Only the entire texture can be locked at a time when dealing with
   // dynamic textures.
    if (RectPtr <> nil) then
    begin
      Errors.Insert(errInvalidCall, Self, ClassName, 'Lock');
      Exit;
    end;
  end;

  if (Succeeded(FTexture.LockRect(0, LockedRect, RectPtr, Usage))) then
  begin
    Bits := LockedRect.pBits;
    Pitch := LockedRect.Pitch;
  end else Errors.Insert(errAccessTexture, Self, ClassName, 'Lock');
end;

//---------------------------------------------------------------------------

procedure TDX8LockableTexture.Unlock();
begin
  if (FTexture = nil) then
  begin
    Errors.Insert(errInvalidCall, Self, ClassName, 'Unlock');
    Exit;
  end;

  FTexture.UnlockRect(0);
end;

//---------------------------------------------------------------------------

procedure TDX8LockableTexture.UpdateMipmaps();
begin
  if (FTexture = nil) then
  begin
    Errors.Insert(errInvalidCall, Self, ClassName, 'UpdateMipmaps');
    Exit;
  end;

// if (MipMapping) then
//     D3DXFilterTexture(FTexture,nil,0,D3DX_DEFAULT);
//可能会有问题 shj
// FTexture.GenerateMipSubLevels();
end;

//---------------------------------------------------------------------------

procedure TDX8LockableTexture.UpdateSize();
begin
  DestroyTextureInstance();
  CreateTextureInstance();
end;

//---------------------------------------------------------------------------

constructor TDX8RenderTargetTexture.Create();
begin
  inherited;

  FTexture := nil;
  FDepthBuffer := nil;
  SavedSurface := nil;
  SavedDepthBuf := nil;
end;

//---------------------------------------------------------------------------

function TDX8RenderTargetTexture.CreateTextureInstance(): Boolean;
var
  Levels: Integer;
  Usage: Cardinal;
begin
  Result := (Device8 <> nil);
  if (not Result) then
  begin
    Errors.Insert(errInvalidCall, Self, ClassName, 'CreateTextureInstance');
    Exit;
  end;

  Levels := 1;
  if (MipMapping) then Levels := 0;

  Usage := D3DUSAGE_RENDERTARGET;
  if (MipMapping) then Usage := 0;

  FFormat := ApproximateTextureFormat(FFormat, Usage);
  if (FFormat = apf_Unknown) then
  begin
    Errors.Insert(errUnsupportedFormat, Self, ClassName, 'ComputeParams');
    Result := False;
    Exit;
  end;

  DFormat := PixelFormatToD3DFormat(FFormat);

  Result := Succeeded(Device8.CreateTexture(Width, Height, Levels, Usage,
    DFormat, D3DPOOL_DEFAULT, FTexture));

  if (not Result) then
  begin
    Errors.Insert(errCannotCreateTexture, Self, ClassName,
      'CreateTextureInstance');
    Exit;
  end;

  if (DepthStencil) then
  begin
    Result := Succeeded(Device8.CreateDepthStencilSurface(Width, Height,
      Params8.AutoDepthStencilFormat, D3DMULTISAMPLE_NONE, FDepthBuffer));
//   Result:= Succeeded(Device8.CreateDepthStencilSurface(Width, Height,
//    Params8.AutoDepthStencilFormat, D3DMULTISAMPLE_NONE, 0, True,
//    FDepthBuffer, nil));
    if (not Result) then
    begin
      Errors.Insert(errCreateDepthStencil, Self, ClassName,
        'CreateTextureInstance');

      FTexture := nil;
      Exit;
    end;
  end;
end;

//---------------------------------------------------------------------------

procedure TDX8RenderTargetTexture.DestroyTextureInstance();
begin
  if (FDepthBuffer <> nil) then FDepthBuffer := nil;
  if (FTexture <> nil) then FTexture := nil;
end;

//---------------------------------------------------------------------------

function TDX8RenderTargetTexture.CreateTexture(): Boolean;
begin
  Result := CreateTextureInstance();
end;

//---------------------------------------------------------------------------

procedure TDX8RenderTargetTexture.DestroyTexture();
begin
  inherited;
  DestroyTextureInstance();
end;

//---------------------------------------------------------------------------

procedure TDX8RenderTargetTexture.Bind(Stage: Integer);
begin
  if (Device8 = nil) or (FTexture = nil) then
    Errors.Insert(errInvalidCall, Self, ClassName, 'Bind');

  if (Device8 = nil) then Exit;

  if (FTexture <> nil) then Device8.SetTexture(Stage, FTexture)
  else Device8.SetTexture(Stage, nil);
end;

//---------------------------------------------------------------------------

procedure TDX8RenderTargetTexture.HandleDeviceReset();
begin
  CreateTextureInstance();
end;

//---------------------------------------------------------------------------

procedure TDX8RenderTargetTexture.HandleDeviceLost();
begin
  DestroyTextureInstance();
end;

//---------------------------------------------------------------------------

procedure TDX8RenderTargetTexture.UpdateMipmaps();
begin
  if (FTexture = nil) then
  begin
    Errors.Insert(errInvalidCall, Self, ClassName, 'UpdateMipmaps');
    Exit;
  end;

// FTexture.GenerateMipSubLevels(); //有问题
end;

//---------------------------------------------------------------------------

procedure TDX8RenderTargetTexture.UpdateSize();
begin
  DestroyTextureInstance();
  CreateTextureInstance();
end;

//---------------------------------------------------------------------------

function TDX8RenderTargetTexture.BeginDrawTo(): Boolean;
const
  MethodName = 'BeginDrawTo';
var
  Surface: IDirect3DSurface8;
begin
 // (1) Make sure the device is initialized and texture is created properly.
  Result := (Device8 <> nil) and (FTexture <> nil);
  if (not Result) then
  begin
    Errors.Insert(errInvalidCall, Self, ClassName, MethodName);
    Exit;
  end;

 // (2) Retreive texture's drawing surface to use as render target.
  Result := Succeeded(FTexture.GetSurfaceLevel(0, Surface));
  if (not Result) then
  begin
    Errors.Insert(errGetTextureSurface, Self, ClassName, MethodName);
    Exit;
  end;

 // (3) Save previously used render target's surface.
  Result := Succeeded(Device8.GetRenderTarget(SavedSurface));
  if (not Result) then
  begin
    Surface := nil;
    Errors.Insert(errGetRenderTarget, Self, ClassName, MethodName);
    Exit;
  end;

 // (4) Save previously used depth-stencil buffer.
  if (FDepthBuffer <> nil) then
  begin
    Result := Succeeded(Device8.GetDepthStencilSurface(SavedDepthBuf));
    if (not Result) then
    begin
      SavedSurface := nil;
      Surface := nil;
      Errors.Insert(errGetDepthStencilBuffer, Self, ClassName, MethodName);
      Exit;
    end;
  end;

 // (5) Set new render target.
  Result := Succeeded(Device8.SetRenderTarget(Surface, FDepthBuffer));
  Surface := nil;

  if (not Result) then
  begin
    SavedDepthBuf := nil;
    SavedSurface := nil;
    Errors.Insert(errSetRenderTarget, Self, ClassName, MethodName);
    Exit;
  end;

 // (6) Set new depth-stencil buffer.
  if (FDepthBuffer <> nil) then
  begin
//   Result:= Succeeded(Device8.SetDepthStencilSurface(FDepthBuffer));
    if (not Result) then
    begin
      SavedDepthBuf := nil;
      SavedSurface := nil;
      Errors.Insert(errSetDepthStencilBuffer, Self, ClassName, MethodName);
      Exit;
    end;
  end;
end;

//---------------------------------------------------------------------------

procedure TDX8RenderTargetTexture.EndDrawTo();
begin
  if (Device8 = nil) then
  begin
    Errors.Insert(errInvalidCall, Self, ClassName, 'EndDrawTo');
    Exit;
  end;

  if (SavedDepthBuf <> nil) then
  begin
//   Device8.SetDepthStencilSurface(SavedDepthBuf);
    SavedDepthBuf := nil;
  end;

  if (SavedSurface <> nil) then
  begin
    Device8.SetRenderTarget(SavedSurface, SavedDepthBuf);
//   Device8.SetRenderTarget(0, SavedSurface);
    SavedSurface := nil;
  end;
end;

//---------------------------------------------------------------------------
end.

