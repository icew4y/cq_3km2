{******************************************************************************}
{*                                                                            *}
{*               Copyright (C) TasNat.  All Rights Reserved.                  *}
{*                                                                            *}
{******************************************************************************}

// Original source contained in "D3DX8.par"

{$I DirectX.inc}
{.$DEFINE dynamicLoad}
unit D3DX8;

interface

uses
  Windows,
  ActiveX,
  SysUtils,
  {$I UseD3D8.inc},
  DXFile;

//----------------------------------------------------------------------------
// D3DX_FILTER flags:
// ------------------
//
// A valid filter must contain one of these values:
//
//  D3DX_FILTER_NONE
//      No scaling or filtering will take place.  Pixels outside the bounds
//      of the source image are assumed to be transparent black.
//  D3DX_FILTER_POINT
//      Each destination pixel is computed by sampling the nearest pixel
//      from the source image.
//  D3DX_FILTER_LINEAR
//      Each destination pixel is computed by linearly interpolating between
//      the nearest pixels in the source image.  This filter works best
//      when the scale on each axis is less than 2.
//  D3DX_FILTER_TRIANGLE
//      Every pixel in the source image contributes equally to the
//      destination image.  This is the slowest of all the filters.
//  D3DX_FILTER_BOX
//      Each pixel is computed by averaging a 2x2(x2) box pixels from
//      the source image. Only works when the dimensions of the
//      destination are half those of the source. (as with mip maps)
//
// And can be OR'd with any of these optional flags:
//
//  D3DX_FILTER_MIRROR_U
//      Indicates that pixels off the edge of the texture on the U-axis
//      should be mirrored, not wraped.
//  D3DX_FILTER_MIRROR_V
//      Indicates that pixels off the edge of the texture on the V-axis
//      should be mirrored, not wraped.
//  D3DX_FILTER_MIRROR_W
//      Indicates that pixels off the edge of the texture on the W-axis
//      should be mirrored, not wraped.
//  D3DX_FILTER_MIRROR
//      Same as specifying D3DX_FILTER_MIRROR_U | D3DX_FILTER_MIRROR_V |
//      D3DX_FILTER_MIRROR_V
//  D3DX_FILTER_DITHER
//      Dithers the resulting image.
//
//----------------------------------------------------------------------------

const
  D3DX_FILTER_NONE      = (1 shl 0);
  D3DX_FILTER_POINT     = (2 shl 0);
  D3DX_FILTER_LINEAR    = (3 shl 0);
  D3DX_FILTER_TRIANGLE  = (4 shl 0);
  D3DX_FILTER_BOX       = (5 shl 0);

  D3DX_FILTER_MIRROR_U  = (1 shl 16);
  D3DX_FILTER_MIRROR_V  = (2 shl 16);
  D3DX_FILTER_MIRROR_W  = (4 shl 16);
  D3DX_FILTER_MIRROR    = (7 shl 16);
  D3DX_FILTER_DITHER    = (8 shl 16);
  
const
  // #define D3DX_DEFAULT ULONG_MAX
  D3DX_DEFAULT          = $FFFFFFFF;


type


  PD3DXImageFileFormat = ^TD3DXImageFileFormat;
  _D3DXIMAGE_FILEFORMAT = (
  {$IFNDEF COMPILER6_UP}
    D3DXIFF_BMP        {= 0},
    D3DXIFF_JPG        {= 1},
    D3DXIFF_TGA        {= 2},
    D3DXIFF_PNG        {= 3},
    D3DXIFF_DDS        {= 4},
    D3DXIFF_PPM        {= 5},
    D3DXIFF_DIB        {= 6}
  {$ELSE}
    D3DXIFF_BMP         = 0,
    D3DXIFF_JPG         = 1,
    D3DXIFF_TGA         = 2,
    D3DXIFF_PNG         = 3,
    D3DXIFF_DDS         = 4,
    D3DXIFF_PPM         = 5,
    D3DXIFF_DIB         = 6,
    D3DXIFF_FORCE_DWORD = $fffffff
  {$ENDIF}
  );
  {$EXTERNALSYM _D3DXIMAGE_FILEFORMAT}
  D3DXIMAGE_FILEFORMAT = _D3DXIMAGE_FILEFORMAT;
  {$EXTERNALSYM D3DXIMAGE_FILEFORMAT}
  TD3DXImageFileFormat = _D3DXIMAGE_FILEFORMAT;


  PD3DXImageInfo = ^TD3DXImageInfo;
  _D3DXIMAGE_INFO = packed record
    Width:      LongWord;
    Height:     LongWord;
    Depth:      LongWord;
    MipLevels:  LongWord;
    Format:     TD3DFormat;
    ResourceType: TD3DResourceType;
    ImageFileFormat: TD3DXImageFileFormat;
  end;
  {$EXTERNALSYM _D3DXIMAGE_INFO}
  D3DXIMAGE_INFO = _D3DXIMAGE_INFO;
  {$EXTERNALSYM D3DXIMAGE_INFO}
  TD3DXImageInfo = _D3DXIMAGE_INFO;



{$IFDEF dynamicLoad}
var
D3DXSaveSurfaceToFile : function (
  pDestFile: PChar;
  DestFormat: TD3DXImageFileFormat;
  pSrcSurface: IDirect3DSurface8;
  pSrcPalette: PPaletteEntry;
  pSrcRect: PRect): HResult; stdcall;

D3DXCreateTextureFromFileInMemoryEx : function (
  Device: IDirect3DDevice8;
  const pSrcData;
  SrcDataSize: LongWord;
  Width: LongWord;
  Height: LongWord;
  MipLevels: LongWord;
  Usage: DWord;
  Format: TD3DFormat;
  Pool: TD3DPool;
  Filter: DWord;
  MipFilter: DWord;
  ColorKey: TD3DColor;
  pSrcInfo: PD3DXImageInfo;
  pPalette: PPaletteEntry;
  out ppTexture: IDirect3DTexture8): HResult; stdcall;

implementation
{$ifndef ProjectIsBpl}
{$R ..\d3ddll.Res}
uses
  Classes, DLLLoader;
var
  M : TResourceStream;
initialization
  M := TResourceStream.Create(HInstance,'qke','D3D');
  with TDLLLoader.Create do begin
    if Load(M) then begin
      @D3DXSaveSurfaceToFile := FindExport('D3DXSaveSurfaceToFileA');
      @D3DXCreateTextureFromFileInMemoryEx := FindExport('D3DXCreateTextureFromFileInMemoryEx');
    end;
  end;
  M.Free;
{$ENDIF}
{$ELSE}
function D3DXSaveSurfaceToFile(
  pDestFile: PChar;
  DestFormat: TD3DXImageFileFormat;
  pSrcSurface: IDirect3DSurface8;
  pSrcPalette: PPaletteEntry;
  pSrcRect: PRect): HResult; stdcall;

function D3DXCreateTextureFromFileInMemoryEx(
  Device: IDirect3DDevice8;
  const pSrcData;
  SrcDataSize: LongWord;
  Width: LongWord;
  Height: LongWord;
  MipLevels: LongWord;
  Usage: DWord;
  Format: TD3DFormat;
  Pool: TD3DPool;
  Filter: DWord;
  MipFilter: DWord;
  ColorKey: TD3DColor;
  pSrcInfo: PD3DXImageInfo;
  pPalette: PPaletteEntry;
  out ppTexture: IDirect3DTexture8): HResult; stdcall;
implementation
const
  d3dx8dll ='D3DX81ab.dll';
function D3DXSaveSurfaceToFile; external d3dx8dll name 'D3DXSaveSurfaceToFileA';
function D3DXCreateTextureFromFileInMemoryEx; external d3dx8dll;

{$ENDIF}
end.
