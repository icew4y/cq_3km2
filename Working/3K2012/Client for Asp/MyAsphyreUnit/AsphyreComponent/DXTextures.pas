unit DXTextures;
{$IFDEF fpc}{$MODE delphi}{$ENDIF}

//---------------------------------------------------------------------------
interface

//---------------------------------------------------------------------------
uses
  Windows, DirectX, Classes, Types, SysUtils, AsphyreTypes, AbstractTextures,
  SystemSurfaces, Vectors2px, AsphyreDIB;

//---------------------------------------------------------------------------
type
  TDXLockableTexture = class(TAsphyreLockableTexture)
  private
    FTexture: IDirectDrawSurface7;
    procedure DestroyTextureInstance();
  protected
    procedure UpdateSize(); override;

    function CreateTexture(SrcData: Pointer; SrcDataSize: LongWord; BitCount: Byte): Boolean; overload; override;
    function CreateTexture(): Boolean; overload; override;
    procedure DestroyTexture(); override;
  public
    property Texture: IDirectDrawSurface7 read FTexture;
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
  TDXRenderTargetTexture = class(TAsphyreRenderTargetTexture)
  private
    FTexture: IDirectDrawSurface7;

    function CreateTextureInstance(): Boolean;
    procedure DestroyTextureInstance();
  protected
    procedure UpdateSize(); override;

    function CreateTexture(): Boolean; override;
    procedure DestroyTexture(); override;
  public
    property Texture: IDirectDrawSurface7 read FTexture;

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
  AsphyreErrors;

//---------------------------------------------------------------------------

constructor TDXLockableTexture.Create();
begin
  inherited Create;
  FTexture := nil;
end;

//---------------------------------------------------------------------------

function TDXLockableTexture.LoadFromFile(const AFileName: string; AMipMapping: Boolean = True): Boolean;
begin
  Result := False;
  if Active then DestroyTexture;
  if (not Active) then
    //Result := Succeeded(D3DXCreateTextureFromFile(Device8, PChar(AFileName), FTexture));  用此函数会被拉伸
  if not Result then
    Result := inherited LoadFromFile(AFileName, AMipMapping);
end;

//---------------------------------------------------------------------------

procedure TDXLockableTexture.DestroyTextureInstance();
begin
  if (FTexture <> nil) then FTexture := nil;
end;

function TDXLockableTexture.CreateTexture(): Boolean;
var
  Desc: TDDSurfaceDesc2;
begin
  Result := DirectDraw <> nil;
  if Result then begin
    FillChar(Desc, SizeOf(Desc), #0);
    with Desc do
    begin
      dwSize := SizeOf(Desc);
      dwFlags := DDSD_CAPS or DDSD_WIDTH or DDSD_HEIGHT;
      ddsCaps.dwCaps := DDSCAPS_OFFSCREENPLAIN;
      ddsCaps.dwCaps := ddsCaps.dwCaps or DDSCAPS_SYSTEMMEMORY;
      dwHeight := FHeight;
      dwWidth := FWidth;
    end;
    Result := DirectDraw.CreateSurface(Desc, FTexture, nil) = DD_OK;
    MemoryWidth := FWidth;
    MemoryHeight := FHeight;
  end;

end;

//---------------------------------------------------------------------------

function TDXLockableTexture.CreateTexture(SrcData: Pointer; SrcDataSize: LongWord; BitCount: Byte): Boolean;
var
  DIB : TDIB;
  M : TMemoryStream;
  DC : HDC;
begin
  Result := False;
  DIB := TDIB.Create;
  M := TMemoryStream.Create;
  try
    M.Write(SrcData^, SrcDataSize);
    M.Position := 0;
    DIB.LoadFromStream(M);
    //DIB.SaveToFile('C:\' + IntToStr(GetTickCount) + '.bmp');
    FWidth := DIB.Width;
    FHeight := DIB.Height;
    Result := CreateTexture;
    if (FTexture <> nil) and
       (FTexture.GetDC(DC) = DD_OK)then begin
       if not BitBlt(DC, 0, 0, FWidth, FHeight, DIB.Canvas.Handle, 0, 0, SRCCOPY) then
         RaiseLastOSError;
       FTexture.ReleaseDC(DC);
       Result := True;
    end;
  finally
    M.Free;
    DIB.Free;
  end;
end;
//---------------------------------------------------------------------------

procedure TDXLockableTexture.DestroyTexture();
begin
  DestroyTextureInstance();
  inherited DestroyTexture;//FActive := False By TasNat at: 2012-03-11 16:38:18
end;

//---------------------------------------------------------------------------

procedure TDXLockableTexture.HandleDeviceReset();
begin
  if (FTexture = nil) then FTexture.IsLost;
end;

//---------------------------------------------------------------------------

procedure TDXLockableTexture.HandleDeviceLost();
begin
  DestroyTextureInstance();
end;

//---------------------------------------------------------------------------

procedure TDXLockableTexture.Bind(Stage: Integer);
begin

end;

//---------------------------------------------------------------------------

procedure TDXLockableTexture.Lock(const Rect: TRect; out Bits: Pointer;
  out Pitch: Integer);
var
  Desc: TDDSurfaceDesc2;
begin
  Bits := nil;
  if (FTexture <> nil) and (FTexture.Lock(@Rect, Desc, DDLOCK_WAIT, 0) = DD_OK) then begin
    Bits := Desc.lpSurface;
    Pitch := Desc.lPitch;
  end;
end;

//---------------------------------------------------------------------------

procedure TDXLockableTexture.Unlock();
begin
  if (FTexture <> nil) then FTexture.Unlock(nil)
end;

//---------------------------------------------------------------------------

procedure TDXLockableTexture.UpdateMipmaps();
begin

end;

//---------------------------------------------------------------------------

procedure TDXLockableTexture.UpdateSize();
begin

end;

//---------------------------------------------------------------------------

constructor TDXRenderTargetTexture.Create();
begin
  inherited;

  FTexture := nil;
end;

//---------------------------------------------------------------------------

function TDXRenderTargetTexture.CreateTextureInstance(): Boolean;
begin

end;

//---------------------------------------------------------------------------

procedure TDXRenderTargetTexture.DestroyTextureInstance();
begin

end;

//---------------------------------------------------------------------------

function TDXRenderTargetTexture.CreateTexture(): Boolean;
begin
  Result := CreateTextureInstance();
end;

//---------------------------------------------------------------------------

procedure TDXRenderTargetTexture.DestroyTexture();
begin
  inherited;
  DestroyTextureInstance();
end;

//---------------------------------------------------------------------------

procedure TDXRenderTargetTexture.Bind(Stage: Integer);
begin

end;

//---------------------------------------------------------------------------

procedure TDXRenderTargetTexture.HandleDeviceReset();
begin
  CreateTextureInstance();
end;

//---------------------------------------------------------------------------

procedure TDXRenderTargetTexture.HandleDeviceLost();
begin
  DestroyTextureInstance();
end;

//---------------------------------------------------------------------------

procedure TDXRenderTargetTexture.UpdateMipmaps();
begin

end;

//---------------------------------------------------------------------------

procedure TDXRenderTargetTexture.UpdateSize();
begin
  DestroyTextureInstance();
  CreateTextureInstance();
end;

//---------------------------------------------------------------------------

function TDXRenderTargetTexture.BeginDrawTo(): Boolean;
begin

end;

//---------------------------------------------------------------------------

procedure TDXRenderTargetTexture.EndDrawTo();
begin

end;

//---------------------------------------------------------------------------
end.

