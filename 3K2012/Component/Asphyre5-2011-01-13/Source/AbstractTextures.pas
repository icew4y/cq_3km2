unit AbstractTextures;
//---------------------------------------------------------------------------
// AbstractTextures.pas                                 Modified: 05-May-2008
// Asphyre Custom Texture implementation                          Version 1.1
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
// The Original Code is AbstractTextures.pas.
//
// The Initial Developer of the Original Code is Yuriy Kotsarenko.
// Portions created by M. Sc. Yuriy Kotsarenko are Copyright (C) 2007 - 2008,
// Yuriy Kotsarenko. All Rights Reserved.
//---------------------------------------------------------------------------
interface

//---------------------------------------------------------------------------
uses
  Windows, Graphics, SysUtils, Types, Vectors2px, Vectors2, AsphyreTypes;

//---------------------------------------------------------------------------
type
  TAsphyreCustomTexture = class
  private
    FWidth: Integer;
    FHeight: Integer;
    FMemoryWidth: Integer;
    FMemoryHeight: Integer;

    FActive: Boolean;
    FMipMapping: Boolean;

    FPaletteEntry: TPaletteEntry;
    procedure SetWidth(const Value: Integer);
    procedure SetHeight(const Value: Integer);
    function GetClientRect: TRect;

    function GetBytesPerPixel(): Integer;
    procedure SetMipmapping(const Value: Boolean);
    procedure SetFormat(const Value: TAsphyrePixelFormat);
  protected
    FFormat: TAsphyrePixelFormat;

    procedure UpdateSize(); virtual;
    function CreateTexture(SrcData: Pointer; SrcDataSize: LongWord; BitCount: Byte): Boolean; overload; virtual;
    function CreateTexture(): Boolean; overload; virtual;

  public
    procedure DestroyTexture(); virtual;
    procedure SetSize(const AWidth, AHeight: Integer; AutoInitialize: Boolean = True);
    property Format: TAsphyrePixelFormat read FFormat write SetFormat;
    property PaletteEntry: TPaletteEntry read FPaletteEntry write FPaletteEntry;

    property Width: Integer read FWidth write SetWidth;
    property Height: Integer read FHeight write SetHeight;

    property MemoryWidth: Integer read FMemoryWidth write FMemoryWidth;
    property MemoryHeight: Integer read FMemoryHeight write FMemoryHeight;

    property Active: Boolean read FActive;

    property BytesPerPixel: Integer read GetBytesPerPixel;

    property Mipmapping: Boolean read FMipMapping write SetMipmapping;
    property ClientRect: TRect read GetClientRect;

    function LoadFromData(SrcData: Pointer; SrcDataSize: LongWord; BitCount: Byte): Boolean;
    function Initialize(): Boolean;
    procedure Finalize();

    procedure Bind(Stage: Integer); virtual;

    procedure HandleDeviceReset(); virtual;
    procedure HandleDeviceLost(); virtual;

    function PixelToLogical(const Pos: TPoint2px): TPoint2; overload;
    function PixelToLogical(const Pos: TPoint2): TPoint2; overload;
    function LogicalToPixel(const Pos: TPoint2): TPoint2px;

    procedure UpdateMipmaps(); virtual;

    constructor Create(); virtual;
  end;

//---------------------------------------------------------------------------
  TAsphyreLockableTexture = class(TAsphyreCustomTexture)
  private
    FDynamicTexture: Boolean;
    function GetPixel(x, y: Integer): Cardinal;
    procedure SetPixel(x, y: Integer; const Value: Cardinal);
    procedure SetDynamicTexture(const Value: Boolean);
  public
    property Pixels[x, y: Integer]: Cardinal read GetPixel write SetPixel;

    property DynamicTexture: Boolean read FDynamicTexture write SetDynamicTexture;

    procedure Lock(const Rect: TRect; out Bits: Pointer;
      out Pitch: Integer); overload; virtual; abstract;
    procedure Lock(out Bits: Pointer;
      out Pitch: Integer); overload; virtual;

    procedure Unlock(); virtual; abstract;
    function LoadFromFile(const AFileName: string; AMipMapping: Boolean = True): Boolean; virtual;
    function SaveToFile(const AFileName: string): Boolean; virtual; //; MemorySize: Boolean = False)
    procedure Draw(X, Y: Integer; Source: TAsphyreLockableTexture; Transparent: Boolean = True); overload;
    procedure Draw(X, Y: Integer; SrcRect: TRect; Source: TAsphyreLockableTexture; Transparent: Boolean = True); overload;
    procedure Draw(DestRect, SrcRect: TRect; Source: TAsphyreLockableTexture); overload;
    procedure FillRect(DestRect: TRect; Color: TColor);
    constructor Create(); override;
    destructor Destroy; override;
  end;

//---------------------------------------------------------------------------
  TAsphyreRenderTargetTexture = class(TAsphyreCustomTexture)
  private
    FDepthStencil: Boolean;

    procedure SetDepthStencil(const Value: Boolean);
  public
    property DepthStencil: Boolean read FDepthStencil write SetDepthStencil;

    function BeginDrawTo(): Boolean; virtual; abstract;
    procedure EndDrawTo(); virtual; abstract;
  end;
var
  CreateHandleCount: Int64 = 0;
//---------------------------------------------------------------------------
implementation

//---------------------------------------------------------------------------
uses
  AsphyreConv, AsphyreBmp, AsphyreBmpLoad, CommonDef, Math, AsphyreUtils, D3DX9, AsphyreErrors;
//---------------------------------------------------------------------------

constructor TAsphyreCustomTexture.Create();
begin
  inherited;

  FWidth := 256;
  FHeight := 256;
  FMemoryWidth := 256;
  FMemoryHeight := 256;
  FActive := False;
  FFormat := apf_Unknown;
  FMipmapping := False;
end;

//---------------------------------------------------------------------------

procedure TAsphyreCustomTexture.SetFormat(const Value: TAsphyrePixelFormat);
begin
  if (not FActive) then FFormat := Value;
end;
//---------------------------------------------------------------------------

procedure TAsphyreCustomTexture.SetWidth(const Value: Integer);
begin
  if (FWidth <> Value) then begin
    FWidth := Value;
    if (FActive) then UpdateSize();
  end;
end;
    //---------------------------------------------------------------------------

procedure TAsphyreCustomTexture.SetHeight(const Value: Integer);
begin
  if (FHeight <> Value) then begin
    FHeight := Value;
    if (FActive) then UpdateSize();
  end;
end;
//---------------------------------------------------------------------------

procedure TAsphyreCustomTexture.SetSize(const AWidth, AHeight: Integer; AutoInitialize: Boolean);
begin
  if (FWidth <> AWidth) or (FHeight <> AHeight) then begin
    FWidth := AWidth;
    FHeight := AHeight;
    if (FActive) then
      UpdateSize()
    else
      if AutoInitialize then
      Initialize;
  end;
end;

//---------------------------------------------------------------------------

procedure TAsphyreCustomTexture.UpdateSize();
begin
 // no code
end;

//---------------------------------------------------------------------------

function TAsphyreCustomTexture.GetBytesPerPixel(): Integer;
begin
  Result := AsphyrePixelFormatBits[FFormat] div 8;
end;

//---------------------------------------------------------------------------

function TAsphyreCustomTexture.GetClientRect: TRect;
begin
  Result := Bounds(0, 0, FWidth, FHeight);
end;
//---------------------------------------------------------------------------

procedure TAsphyreCustomTexture.SetMipmapping(const Value: Boolean);
begin
  if (not FActive) then FMipmapping := Value;
end;

//---------------------------------------------------------------------------

function TAsphyreCustomTexture.CreateTexture(SrcData: Pointer; SrcDataSize: LongWord; BitCount: Byte): Boolean;
begin
  Result := True;
end;
//---------------------------------------------------------------------------

function TAsphyreCustomTexture.CreateTexture(): Boolean;
begin
  Result := True;
end;

//---------------------------------------------------------------------------

procedure TAsphyreCustomTexture.DestroyTexture();
begin
  FActive := False;
end;

//---------------------------------------------------------------------------

function TAsphyreCustomTexture.LoadFromData(SrcData: Pointer; SrcDataSize: LongWord; BitCount: Byte): Boolean;
begin
  Result := not FActive;
  if (not Result) then Exit;
  Result := CreateTexture(SrcData, SrcDataSize, BitCount);
  FActive := Result;
end;
//---------------------------------------------------------------------------

function TAsphyreCustomTexture.Initialize(): Boolean;
begin
  Result := not FActive;
  if (not Result) then Exit;

  Result := CreateTexture();
  FActive := Result;
end;

//---------------------------------------------------------------------------

procedure TAsphyreCustomTexture.Finalize();
begin
  if (FActive) then DestroyTexture();
  FActive := False;
end;

//---------------------------------------------------------------------------

procedure TAsphyreCustomTexture.HandleDeviceReset();
begin
 // no code
end;

//---------------------------------------------------------------------------

procedure TAsphyreCustomTexture.HandleDeviceLost();
begin
 // no code
end;

//---------------------------------------------------------------------------

procedure TAsphyreCustomTexture.Bind(Stage: Integer);
begin
 // no code
end;

//---------------------------------------------------------------------------

procedure TAsphyreCustomTexture.UpdateMipmaps();
begin
 // no code
end;

//---------------------------------------------------------------------------

function TAsphyreCustomTexture.PixelToLogical(const Pos: TPoint2): TPoint2;
begin
  if (FWidth > 0) then Result.x := Pos.x / FWidth else Result.x := 0.0;
  if (FHeight > 0) then Result.y := Pos.y / FHeight else Result.y := 0.0;
end;

//---------------------------------------------------------------------------

function TAsphyreCustomTexture.PixelToLogical(const Pos: TPoint2px): TPoint2;
begin
  if (FWidth > 0) then Result.x := Pos.x / FWidth else Result.x := 0.0;
  if (FHeight > 0) then Result.y := Pos.y / FHeight else Result.y := 0.0;
end;

//---------------------------------------------------------------------------

function TAsphyreCustomTexture.LogicalToPixel(const Pos: TPoint2): TPoint2px;
begin
  Result.x := Round(Pos.x * FWidth);
  Result.y := Round(Pos.y * FHeight);
end;


//---------------------------------------------------------------------------

constructor TAsphyreLockableTexture.Create();
begin
  inherited;
  FDynamicTexture := False;
end;
//---------------------------------------------------------------------------

destructor TAsphyreLockableTexture.Destroy;
begin
  inherited;
end;
//---------------------------------------------------------------------------

procedure TAsphyreLockableTexture.SetDynamicTexture(const Value: Boolean);
begin
  if (not Active) then FDynamicTexture := Value;
end;

//---------------------------------------------------------------------------

function TAsphyreLockableTexture.GetPixel(x, y: Integer): Cardinal;
var
  Bits: Pointer;
  Pitch: Integer;
begin
  Result := 0;
  if (x < 0) or (y < 0) or (x >= FWidth) or (y >= FHeight) then Exit;
  //if (FFormat in [apf_DXT1..apf_DXT5]) then Exit;
  Lock(Bounds(0, y, FWidth, 1), Bits, Pitch);
  if (Bits = nil) then Exit;

  Result := PixelXto32(Pointer(Integer(Bits) + (x * BytesPerPixel)), FFormat);
  Unlock();
end;

//---------------------------------------------------------------------------

procedure TAsphyreLockableTexture.SetPixel(x, y: Integer;
  const Value: Cardinal);
var
  Bits: Pointer;
  Pitch: Integer;
begin
  if (x < 0) or (y < 0) or (x >= FWidth) or (y >= FHeight) then Exit;
  //if (FFormat in [apf_DXT1..apf_DXT5]) then Exit;
  Lock(Bounds(0, y, FWidth, 1), Bits, Pitch);
  if (Bits = nil) then Exit;

  Pixel32toX(Value, Pointer(Integer(Bits) + (x * BytesPerPixel)), FFormat);

  Unlock();
end;

procedure TAsphyreLockableTexture.FillRect(DestRect: TRect; Color: TColor);
var
  X, Y: Integer;
  Bits: Pointer;
  Pitch: Integer;
  DstP: PCardinal;
begin
  DestRect := Bounds(Max2(0, DestRect.Left), Max2(0, DestRect.Top), Min2(Width, DestRect.Right - DestRect.Left), Min2(Height, DestRect.Bottom - DestRect.Top));

  if (DestRect.Left >= DestRect.Right) or (DestRect.Top >= DestRect.Bottom) then Exit;

  Lock(DestRect, Bits, Pitch);
  if (Bits = nil) then Exit;
  for Y := 0 to DestRect.Bottom - DestRect.Top - 1 do begin
    for X := 0 to DestRect.Right - DestRect.Left - 1 do begin
      DstP := PCardinal(Integer(Bits) + Y * Pitch + X * BytesPerPixel);
      Pixel32toX(cColor1(Color), Pointer(DstP), FFormat);
    end;
  end;
  Unlock();
end;

procedure TAsphyreLockableTexture.Draw(X, Y: Integer;
  Source: TAsphyreLockableTexture; Transparent: Boolean);
var
  Bits: Pointer;
  Pitch: Integer;
  nY, nX: Integer;
  nWidth, nHeight: Integer;
  SrcRect: TRect;
  DestRect: TRect;
  SrcP, DstP: Pointer;
  Image: TBitmapEx;
  WritePx: Pointer;
begin
  DestRect := Bounds(X, Y, Source.Width, Source.Height);
  SrcRect := Source.ClientRect;
  if ClipRect2(DestRect, SrcRect, ClientRect, Source.ClientRect) then begin
    nWidth := SrcRect.Right - SrcRect.Left;
    nHeight := SrcRect.Bottom - SrcRect.Top;
    Image := nil;
    Source.Lock(SrcRect, Bits, Pitch);
    if (Bits <> nil) then begin
      WritePx := Bits;
      Image := TBitmapEx.Create;
      Image.Width := nWidth;
      Image.Height := nHeight;

      for nY := 0 to Image.Height - 1 do begin
        Move(WritePx^, Image.ScanLine[nY]^, Image.Width * BytesPerPixel);
        Inc(Integer(WritePx), Pitch);
      end;
    end;
    Source.Unlock();

    if Image <> nil then begin
      Lock(DestRect, Bits, Pitch);

      if (Bits <> nil) then begin
        WritePx := Bits;

        if Transparent then begin
          for nY := 0 to Image.Height - 1 do begin
            DstP := WritePx;
            SrcP := Image.ScanLine[nY];
            for nX := 0 to Image.Width - 1 do begin
              if PCardinal(SrcP)^ > 0 then
                PCardinal(DstP)^ := PCardinal(SrcP)^;
              Inc(PCardinal(SrcP));
              Inc(PCardinal(DstP));
            end;
            Inc(Integer(WritePx), Pitch);
          end;
        end else begin
          for nY := 0 to Image.Height - 1 do begin
            Move(Image.ScanLine[nY]^, WritePx^, Image.Width * BytesPerPixel);
            Inc(Integer(WritePx), Pitch);
          end;
        end;
      end;
      Unlock();
      Image.Free;
    end;
  end;
end;

procedure TAsphyreLockableTexture.Draw(X, Y: Integer;
  SrcRect: TRect; Source: TAsphyreLockableTexture; Transparent: Boolean);
var
  Bits: Pointer;
  Pitch: Integer;
  nY, nX: Integer;
  nWidth, nHeight: Integer;
  //SrcRect: TRect;
  DestRect: TRect;
  SrcP, DstP: Pointer;
  Image: TBitmapEx;
  WritePx: Pointer;
begin
  DestRect := Bounds(X, Y, SrcRect.Right - SrcRect.Left, SrcRect.Bottom - SrcRect.Top);
  //SrcRect := Source.ClientRect;
  if ClipRect2(DestRect, SrcRect, ClientRect, Source.ClientRect) then begin
    nWidth := SrcRect.Right - SrcRect.Left;
    nHeight := SrcRect.Bottom - SrcRect.Top;
    Image := nil;
    Source.Lock(SrcRect, Bits, Pitch);
    if (Bits <> nil) then begin
      WritePx := Bits;
      Image := TBitmapEx.Create;
      Image.Width := nWidth;
      Image.Height := nHeight;

      for nY := 0 to Image.Height - 1 do begin
        Move(WritePx^, Image.ScanLine[nY]^, Image.Width * BytesPerPixel);
        Inc(Integer(WritePx), Pitch);
      end;
    end;
    Source.Unlock();

    if Image <> nil then begin
      Lock(DestRect, Bits, Pitch);

      if (Bits <> nil) then begin
        WritePx := Bits;

        if Transparent then begin
          for nY := 0 to Image.Height - 1 do begin
            DstP := WritePx;
            SrcP := Image.ScanLine[nY];
            for nX := 0 to Image.Width - 1 do begin
              if PCardinal(SrcP)^ > 0 then
                PCardinal(DstP)^ := PCardinal(SrcP)^;
              Inc(PCardinal(SrcP));
              Inc(PCardinal(DstP));
            end;
            Inc(Integer(WritePx), Pitch);
          end;
        end else begin
          for nY := 0 to Image.Height - 1 do begin
            Move(Image.ScanLine[nY]^, WritePx^, Image.Width * BytesPerPixel);
            Inc(Integer(WritePx), Pitch);
          end;
        end;
      end;
      Unlock();
      Image.Free;
    end;
  end;
end;

procedure TAsphyreLockableTexture.Draw(DestRect, SrcRect: TRect;
  Source: TAsphyreLockableTexture);
begin

end;

//---------------------------------------------------------------------------

procedure TAsphyreRenderTargetTexture.SetDepthStencil(const Value: Boolean);
begin
  if (not Active) then FDepthStencil := Value;
end;

//---------------------------------------------------------------------------

function TAsphyreLockableTexture.SaveToFile(const AFileName: string): Boolean;
var
  Image: TBitmapEx;
  Bits: Pointer;
  Pitch: Integer;
  Index: Integer;
  WritePx: Pointer;
  Y: Integer;
begin
  Result := False;
  if (Active) then begin
    ////if MemorySize then
    ///  Lock(Bounds(0, 0, MemoryWidth, MemoryHeight), Bits, Pitch)
    //else
    Lock(Bounds(0, 0, Width, Height), Bits, Pitch);
    if (Bits <> nil) and (Pitch > 0) then begin
      Image := TBitmapEx.Create();
      //if MemorySize then
      //  Image.SetSize(MemoryWidth, MemoryHeight)
      //else
      Image.SetSize(Width, Height);
      Image.PixelFormat := pf32bit;
      WritePx := Bits;
      for Y := 0 to Image.Height - 1 do begin
        Move(WritePx^, Image.ScanLine[Y]^, Image.Width * 4);
        Inc(Integer(WritePx), Pitch);
      end;
      Unlock();
      //try
      Image.SaveToFile(AFileName);
      //except

      //end;
      Image.Free();
    end;

  end;
end;

function TAsphyreLockableTexture.LoadFromFile(const AFileName: string; AMipMapping: Boolean): Boolean;
var
  Image: TBitmapEx;
  Bits: Pointer;
  Pitch: Integer;
  Index: Integer;
  WritePx: Pointer;
  X, Y: Integer;
  Pix: Cardinal;
  RGBQuad: TRGBQuad;
  ScrP: PCardinal;
begin
  Result := False;
  if Active then DestroyTexture;
  if (not Active) then begin
    Image := TBitmapEx.Create();

    if (not LoadBitmap(AFileName, Image)) then
    begin
      Image.Free();
      
      Exit;
    end;

    if (FFormat = apf_Unknown) then
    begin
      FFormat := apf_A8R8G8B8;
      if (Image.PixelFormat <> pf32bit) then
      begin
        FFormat := apf_R8G8B8;
        Image.PixelFormat := pf32bit;
      end else
      begin
        if (not Image.HasAlphaChannel()) then
          FFormat := apf_X8R8G8B8;
      end;
    end else
      if (Image.PixelFormat <> pf32bit) then Image.PixelFormat := pf32bit;

    MipMapping := AMipMapping;
    SetSize(Image.Width, Image.Height, False);

    FFormat := apf_A8R8G8B8;

    if not Initialize then begin
      Image.Free();
      Exit;
    end;

    Lock(Bits, Pitch);
    if (Bits = nil) or (Pitch < 1) then
    begin
      Image.Free();
      Exit;
    end;

    WritePx := Bits;

    for Y := 0 to Image.Height - 1 do begin
      ScrP := Image.ScanLine[Y];
      for X := 0 to Image.Width - 1 do begin
        Pix := PCardinal(Integer(ScrP) + X * 4)^;
        if Pix > 0 then
          Pix := Pix or $FF000000;
        PCardinal(Integer(WritePx) + Y * Pitch + X * 4)^ := Pix;
      end;
    end;

    Unlock();
    Image.Free();

    if (MipMapping) then UpdateMipmaps();
    Result := True;
  end;
end;

procedure TAsphyreLockableTexture.Lock(out Bits: Pointer;
  out Pitch: Integer);
begin
  //if ChangeSize2n then begin
   // Lock(Bounds((MemoryWidth - Width) div 2, (MemoryHeight - Height) div 2, Width, Height), Bits, Pitch);
  //end else begin
  Lock(ClientRect, Bits, Pitch);
  //end;
end;

end.

