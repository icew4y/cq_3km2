unit uMyDxUnit;
interface
uses
  Windows, SysUtils, Types,
  AsphyreFactory, AbstractDevices, AbstractCanvas, AbstractTextures,
  AsphyreTypes, Vectors2px, uGameTexture, Direct3D8;

type
  TMyTexutreType = (
    MyTexture_HP,
    MyTexture_MyHP,
    MyTexture_MP,
    MyTexture_NewMP,
    MyTexture_Kill69
  );
var
  DisplaySize: TPoint2px;
  g_GameDevice: TAsphyreDevice = nil;
  GameCanvas: TAsphyreCanvas = nil;
  g_RGBQuad : TRGBQuad;
  g_pDesc: TD3DSurfaceDesc;
  g_DFormat : TD3DFormat;
  g_Format: TAsphyrePixelFormat;
  function CheckTextureAlpha(Source: TAsphyreLockableTexture; X, Y: Integer): Boolean;
  function NewTexture(FileData: Pointer; FileSize: Integer; AWidth, AHeight: Integer; Format : TAsphyrePixelFormat = apf_Unknown): TAsphyreLockableTexture;
  function NewMyTexture(MyTextureType: TMyTexutreType): TAsphyreLockableTexture;

implementation
uses
  DX8Textures;

function CheckTextureAlpha(Source: TAsphyreLockableTexture; X, Y: Integer): Boolean;
var
  Pix: PCardinal;
  Pix2: Cardinal;
  D : TDX8LockableTexture;
  LockedRect: TD3DLockedRect;
  R : TRect;
begin
  Result := False;
  if Source <> nil then begin
    Pix2 := Source.Pixels[X, Y];
    g_RGBQuad := TRGBQuad(Pix2);
    g_Format := Source.Format;
    case g_Format of
      apf_Unknown:begin //修复全屏不能点击 By TasNat at: 2012-03-16 18:07:55
        D := TDX8LockableTexture(Source);
        if (x < 0) or (y < 0) or (x >= D.Width) or (y >= D.Height) then Exit;
        R := Bounds(0, y, D.Width, 1);
        D.Texture.GetLevelDesc(0, g_pDesc);
        D.Texture.LockRect(0, LockedRect, @R, 0);
        Pix := PCardinal(Integer(LockedRect.pBits) + (x * D.BytesPerPixel));
        g_RGBQuad := TRGBQuad(Pix^);
        D.Texture.UnlockRect(0);
        g_DFormat := g_pDesc.Format;
        case g_DFormat of
          D3DFMT_A8R8G8B8:Result := g_RGBQuad.rgbReserved <> 0;
          D3DFMT_X8R8G8B8:Result := Pix^ <> 0;
          D3DFMT_R5G6B5,
          D3DFMT_X1R5G5B5 : Result := PWord(Pix)^ <> 0;
          D3DFMT_A1R5G5B5 : Result := PWord(Pix)^  and (1 shl 15) <> 0;
        end;
      end;
      //纯色
      {apf_R8G8B8, apf_X8R8G8B8,
    apf_R5G6B5, apf_X1R5G5B5, apf_R3G3B2,
    apf_X4R4G4B4, apf_G16R16,
    apf_L8, apf_V8U8, apf_L6V5U5,
    apf_X8L8V8U8, apf_Q8W8V8U8, apf_V16U16,  apf_UYVY,
    apf_R8G8_B8G8, apf_YUY2, apf_G8R8_G8B8, apf_DXT1, apf_DXT2, apf_DXT3,
    apf_DXT4, apf_DXT5, apf_L16, apf_Q16W16V16U16, apf_R16F, apf_G16R16F,
    apf_R32F, apf_G32R32F,
    apf_CxV8U8, apf_X8B8G8R8,  apf_L8X8V8U8
    : Result := Pix2 <> 0;}


    //修复NPC 不能点.
    apf_A32B32G32R32F,
    apf_A16B16G16R16,
    apf_A16B16G16R16F,

    apf_A8R3G3B2,
    apf_A8L8,
    apf_A8,
    apf_A8X8V8U8,
    apf_A8B8G8R8,
    apf_A8R8G8B8: Result := Pix2 and $FF000000 > 0;



    apf_A4L4,
    apf_A4R4G4B4: Result := Pix2 and $F0000000 > 0;

    apf_A2W10V10U10,
    apf_A2B10G10R10,
    apf_A2R10G10B10,
    apf_A2R2G2B2: Result := Pix2 and $C0000000 > 0;

    apf_A1R5G5B5: Result := Pix2 and $80000000 > 0;

    apf_A5R9G9B9: Result := Pix2 and $F8000000 > 0;
    apf_A6L2   : Result := Pix2 and $FC000000 > 0;
    {
        apf_A32B32G32R32F,
    apf_A16B16G16R16,
    apf_A16B16G16R16F: Result := Pix2 and $FF000000 > 0;

    apf_A8R3G3B2,
    apf_A8L8  : Result := Pix2 and $FF00 > 0;
    apf_A8     : Result := Pix2 > 0;
    apf_A8X8V8U8,
    apf_A8B8G8R8,
    apf_A8R8G8B8: Result := Pix2 and $FF000000 > 0;



    apf_A4L4   : Result := Pix2 and $F0 > 0;
    apf_A4R4G4B4: Result := Pix2 and $F000 > 0;

    apf_A2W10V10U10,
    apf_A2B10G10R10,
    apf_A2R10G10B10 : Result := Pix2 and $C0000000 > 0;

    apf_A2R2G2B2: Result := Pix2 and $C000 > 0;

    apf_A1R5G5B5: Result := Pix2 and $8000 > 0;

    apf_A5R9G9B9: Result := Pix2 and $F8000000 > 0;
    apf_A6L2   : Result := Pix2 and $FC00 > 0;
    }

    else begin//纯色

        Result := {(Pix2 <> $FF000000) and }(Pix2 <> $00000000);
      end;
    end;
  end;
end;

function NewTexture(FileData: Pointer; FileSize: Integer; AWidth, AHeight: Integer; Format : TAsphyrePixelFormat = apf_Unknown): TAsphyreLockableTexture;
var
  Texture: TAsphyreLockableTexture;
  OldNotCanFree : Boolean;
begin
  Texture := Factory.CreateLockableTexture;
  if Texture <> nil then begin
    Texture.Mipmapping := False;
    Texture.SetSize(AWidth, AHeight, False);
    Texture.Format := Format;
    if {UseD3DFormat}False then begin
      if g_GameDevice.TextureFormats[apf_DXT1] then
        Texture.Format :=apf_DXT1 //apf_X8R8G8B8;//apf_DXT1; //apf_A8R8G8B8;
      else
        if g_GameDevice.TextureFormats[apf_DXT3] then
        Texture.Format := apf_DXT3 //apf_X8R8G8B8;//apf_DXT1; //apf_A8R8G8B8;
      else
        if g_GameDevice.TextureFormats[apf_DXT5] then
        Texture.Format := apf_DXT5 //apf_X8R8G8B8;//apf_DXT1; //apf_A8R8G8B8;
      else
        if g_GameDevice.TextureFormats[apf_DXT2] then
        Texture.Format := apf_DXT2 //apf_X8R8G8B8;//apf_DXT1; //apf_A8R8G8B8;
      else
        if g_GameDevice.TextureFormats[apf_DXT4] then
        Texture.Format := apf_DXT4 //apf_X8R8G8B8;//apf_DXT1; //apf_A8R8G8B8;
      else
        if g_GameDevice.PixelFormat = apf_A1R5G5B5 then
        Texture.Format := apf_A1R5G5B5
      else
        if g_GameDevice.PixelFormat = apf_X1R5G5B5 then
        Texture.Format := apf_A1R5G5B5
      else
        if g_GameDevice.PixelFormat = apf_R5G6B5 then
        Texture.Format := apf_A1R5G5B5 //apf_R5G6B5
      else
        if g_GameDevice.PixelFormat = apf_A8R8G8B8 then
        Texture.Format := apf_A8R8G8B8
      else
        Texture.Format := apf_Unknown; //apf_A8R8G8B8;
    end;
    if Texture.Format = apf_Unknown then begin
      if g_GameDevice.PixelFormat = apf_A1R5G5B5 then
        Texture.Format := apf_A1R5G5B5
      else
        if g_GameDevice.PixelFormat = apf_X1R5G5B5 then
        Texture.Format := apf_A1R5G5B5
      else
        if g_GameDevice.PixelFormat = apf_R5G6B5 then
        Texture.Format := apf_A1R5G5B5 //apf_R5G6B5
      else
        if g_GameDevice.PixelFormat = apf_A8R8G8B8 then
        Texture.Format := apf_A8R8G8B8
      else
        if g_GameDevice.PixelFormat = apf_X8R8G8B8 then
        Texture.Format := apf_A8R8G8B8
      else
        Texture.Format := apf_Unknown; //apf_A8R8G8B8;
    end;
    if not Texture.LoadFromData(FileData, FileSize, 32) then begin
      FreeAndNil(Texture);
    end;
  end;
  Result := Texture;
end;

function NewMyTexture(MyTextureType: TMyTexutreType): TAsphyreLockableTexture;
var
  PBitmapBits: PIntegerArray;
  BitmapInfo: TBitmapInfo;
  HHBitmap: HBitmap;
  HHDC: HDC;
  FileData: Pointer;
  FileSize: Integer;
  Bits: Pointer;
  Pitch: Integer;
  nWidth, nHeight: Integer;
  RGBQuad: PRGBQuad;
  DesP: Pointer;
  Pix: Cardinal;
  X, Y: Integer;
  Pen, OldPen: HPEN;
  Pen1Color: COLORREF;
  Pen2Color: COLORREF;
begin
  Result := nil;
  nWidth := 32;
  nHeight := 4;
  FillChar(BitmapInfo, SizeOf(BitmapInfo), 0);
  with BitmapInfo.bmiHeader do begin
  //位图信息头
    biSize := SizeOf(BitmapInfo.bmiHeader);
    biWidth := nWidth;
    biHeight := -nHeight;
    biPlanes := 1;
    biBitCount := 32;
    biCompression := BI_RGB;
    biSizeImage := 0;
    biXPelsPerMeter := 0;
    biYPelsPerMeter := 0;
    biClrUsed := 0;
    biClrImportant := 0;
  end;
  HHDC := CreateCompatibleDC(0);
  HHBitmap := CreateDIBSection(HHDC, BitmapInfo, DIB_RGB_COLORS, Pointer(PBitmapBits), 0, 0);
  case MyTextureType of
    MyTexture_HP: begin
      Pen1Color := RGB(255, 0, 0);
      Pen2Color := RGB(132, 0, 0);
    end;
    MyTexture_MyHP: begin
      Pen1Color := RGB(0, 223, 0);
      Pen2Color := RGB(0, 150, 0);
    end;
    MyTexture_MP: begin
      Pen1Color := RGB(74, 158, 206);
      Pen2Color := RGB(49, 81, 132);
    end;
    MyTexture_NewMP: begin
      Pen1Color := RGB(0, 0, 160);
      Pen2Color := RGB(0, 0, 100);
    end;
    MyTexture_Kill69: begin
      Pen1Color := RGB(255, 255, 0);
      Pen2Color := $000E98EB; //原值 RGB(222, 166, 0)  原值达不到
    end;
  end;
  SelectObject(HHDC, HHBitmap);
  SetBkColor(HHDC, RGB(0, 0, 0)); //设背景颜色为黑色
  Pen := CreatePen(PS_SOLID, 1, Pen1Color);
  OldPen := SelectObject(HHDC, Pen);
  MoveToEx(HHDC, 1, 1, nil);
  LineTo(HHDC, 31, 1);
  DeleteObject(Pen);
  Pen := CreatePen(PS_SOLID, 1, Pen2Color);
  SelectObject(HHDC, Pen);
  MoveToEx(HHDC, 1, 2, nil);
  LineTo(HHDC, 31, 2);
  DeleteObject(Pen);
  SelectObject(HHDC, OldPen);
  
  NewBitmapFile(nWidth, nHeight, 32, FileData, FileSize);

  Bits := Pointer(Integer(FileData) + SizeOf(TBitmapFileHeader) + SizeOf(TBitmapInfoHeader));
  Pitch := nWidth * 4;

  for Y := 0 to nHeight - 1 do begin
    RGBQuad := Pointer(Integer(Pointer(PBitmapBits)) + Y * Pitch);
    DesP := PCardinal(Integer(Bits) + Y * Pitch);
    for X := 0 to nWidth - 1 do begin
      Pix := Cardinal(RGBQuad^);
      {if Pix > 0 then begin
        Pix := Pix or $FF000000;
      end else begin
        Pix := $00000000;
      end;    }
      PCardinal(DesP)^ := Pix;
      Inc(RGBQuad);
      Inc(PCardinal(DesP));
    end;
  end;
  Result := NewTexture(FileData, FileSize, nWidth, nHeight, apf_R5G6B5);
  DeleteObject(HHBitmap);
  DeleteDC(HHDC);
end;
end.
