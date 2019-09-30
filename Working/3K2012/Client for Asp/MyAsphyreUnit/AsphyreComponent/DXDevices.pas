unit DXDevices;

//---------------------------------------------------------------------------
interface

//---------------------------------------------------------------------------
uses
  Windows, SysUtils, DirectX, Classes, AbstractDevices, AbstractTextures, AsphyreTypes;

//---------------------------------------------------------------------------

// Remove the dot to prevent any window changes made by Direct3D.
{.$define NoWindowChanges}

// Remove the dot to preserve FPU state.
{$DEFINE PreserveFPU}

// Remove the dot to enable multi-threading mode.
{.$define EnableMultithread}

// Remove the dot to enable back-buffer alpha hack (this will try to set the
// back buffer to A8R8G8B8, so screenshots can be taken with alpha-channel on
// some ATI video cards).
{.$define BackBufferAlphaHack}

//---------------------------------------------------------------------------
type
  TDXDevice = class(TAsphyreDevice)
  private
    IsLostState: Boolean;
  protected
    function InitDevice(): Integer; override;
    procedure DoneDevice(); override;
    procedure ResetDevice(); override;

    procedure UpdateParams(); override;
    function MayRender(): Boolean; override;
    procedure RenderWith(hWnd: THandle; Handler: TNotifyEvent;
      Background: Cardinal); override;
    procedure RenderToTarget(Handler: TNotifyEvent;
      Background: Cardinal; FillBk: Boolean); override;
  public
    constructor Create(); override;
    function LockBackBuffer(out Bits: Pointer; out Pitch: Integer): Boolean; override;
    function UnLockBackBuffer(): Boolean; override;
    procedure ScreenCapture(const FileName: string; ImageFileFormat: TImageFileFormat); override; //ÆÁÄ»²¶×½
  end;

//---------------------------------------------------------------------------
implementation

//---------------------------------------------------------------------------
uses
  AsphyreErrors;

//---------------------------------------------------------------------------

constructor TDXDevice.Create();
begin
  inherited;
  Adapter := 0;
  DirectDraw := nil;
end;


procedure TDXDevice.UpdateParams();
begin

end;

//---------------------------------------------------------------------------

function TDXDevice.InitDevice(): Integer;
var 
  DDSD: TDDSurfaceDesc2;
begin
  Result := -11;
  if (DirectDrawCreateEx(nil, DirectDraw, IID_IDirectDraw7, nil) <> DD_OK) or (DirectDraw = nil) then Exit;

  if not Windowed then
  begin 
    DirectDraw.SetCooperativeLevel(WindowHandle, DDSCL_EXCLUSIVE or DDSCL_FULLSCREEN);

    DirectDraw.SetDisplayMode(Size.x, Size.y, 16, 0, 0);
 
    FillChar(DDSD, SizeOf(DDSD), #0); 
    DDSD.dwSize := SizeOf(DDSD);
    DDSD.dwFlags := DDSD_CAPS;
    DDSD.ddsCaps.dwCaps := DDSCAPS_PRIMARYSURFACE;
    DirectDraw.CreateSurface(DDSD, PrimarySurface, nil);
    DDSD.dwFlags := DDSD_CAPS or DDSD_HEIGHT or DDSD_WIDTH;
    DDSD.ddsCaps.dwCaps := DDSCAPS_OFFSCREENPLAIN or DDSCAPS_SYSTEMMEMORY; //or DDSCAPS_3DDEVICE;
    DDSD.dwHeight := Size.x;
    DDSD.dwWidth  := Size.y;
    DirectDraw.CreateSurface(DDSD, BufferSurface, nil);
 
  end 
  // ´°¿ÚÄ£Ê½ 
  else begin
    DirectDraw.SetCooperativeLevel(WindowHandle, DDSCL_NORMAL);
 
    FillChar(DDSD, SizeOf(DDSD), #0);
    DDSD.dwSize := SizeOf(DDSD);
    DDSD.dwFlags := DDSD_CAPS; 
    DDSD.ddsCaps.dwCaps := DDSCAPS_PRIMARYSURFACE;
    DirectDraw.CreateSurface(DDSD, PrimarySurface, nil);
 
    DDSD.dwFlags := DDSD_CAPS or DDSD_HEIGHT or DDSD_WIDTH;
    DDSD.ddsCaps.dwCaps := DDSCAPS_OFFSCREENPLAIN or DDSCAPS_SYSTEMMEMORY;
    DDSD.dwHeight := Size.x;
    DDSD.dwWidth  := Size.y;
    DirectDraw.CreateSurface(DDSD, BufferSurface, nil);

    DirectDraw.CreateClipper(0, Clipper, nil);
    Clipper.SetHWnd(0, WindowHandle);
    PrimarySurface.SetClipper(Clipper);
    Clipper := nil;
  end;

  Result := 0;
  IsLostState := False;
end;

//---------------------------------------------------------------------------

procedure TDXDevice.DoneDevice();
begin
  if (DirectDraw <> nil) then DirectDraw := nil;

end;

//---------------------------------------------------------------------------

procedure TDXDevice.ResetDevice();
begin

end;

//---------------------------------------------------------------------------

function TDXDevice.MayRender(): Boolean;
begin
  Result := True;
end;

//---------------------------------------------------------------------------

procedure TDXDevice.RenderWith(hWnd: THandle; Handler: TNotifyEvent; Background: Cardinal);
var
  DF: TDDBltFX;
begin
  Handler(Self);
  FillChar(DF, SizeOf(DF), 0);
  DF.dwSize := SizeOf(DF);
  PrimarySurface.Blt(Bounds(0, 0, Size.x, Size.y), BufferSurface, Rect(0, 0, Size.x, Size.y), DDBLT_WAIT, DF);


end;

//---------------------------------------------------------------------------

procedure TDXDevice.RenderToTarget(Handler: TNotifyEvent; Background: Cardinal; FillBk: Boolean);
begin

end;

//---------------------------------------------------------------------------

//---------------------------------------------------------------------------

function TDXDevice.LockBackBuffer(out Bits: Pointer; out Pitch: Integer): Boolean;

begin

end;

function TDXDevice.UnLockBackBuffer(): Boolean;
begin
  Result := False;
end;

procedure TDXDevice.ScreenCapture(const FileName: string; ImageFileFormat: TImageFileFormat);  
begin

end;

end.

