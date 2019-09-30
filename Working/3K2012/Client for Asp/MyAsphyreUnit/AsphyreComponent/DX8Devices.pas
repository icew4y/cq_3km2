unit DX8Devices;

//---------------------------------------------------------------------------
interface

//---------------------------------------------------------------------------
uses
  Windows, SysUtils, Direct3D8, Classes, AbstractDevices, AbstractTextures, AsphyreTypes;

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
  TDX8Device = class(TAsphyreDevice)
  private
    UsingDepthBuf: Boolean;
    UsingStencil: Boolean;
    DBackSurface8: IDirect3DSurface8;
    IsLostState: Boolean;
    procedure FindTextureFormats;
    function FindBackFormat(HiDepth: Boolean; Adapter, Width,
      Height: Integer): TD3DFormat;
    function FindDepthFormat(Depth: TDepthStencilType; BackFormat: TD3DFormat;
      Adapter: Integer): TD3DFormat;
    function FindNearestMultisamples(MultiSamples: Integer; Adapter: Cardinal;
      SurfaceFormat, DepthFormat: TD3DFormat;
      Windowed: Boolean): TD3DMultisampleType;
    procedure DefineParams(out Params: TD3DPresentParameters);
    procedure MoveIntoLostState();
    function AttemptRecoverState(): Boolean;
    function HandleDriverError(): Boolean;
    function CheckLostScenario(): Boolean;
    procedure Clear(Color: Cardinal);
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
    function LockBackBuffer(out Bits: Pointer;
      out Pitch: Integer): Boolean; override;
    function UnLockBackBuffer(): Boolean; override;
    procedure ScreenCapture(const FileName: string; ImageFileFormat: TImageFileFormat); override; //屏幕捕捉
  end;

//---------------------------------------------------------------------------
implementation

//---------------------------------------------------------------------------
uses
  D3DX8, DX8Types, AsphyreErrors;

//---------------------------------------------------------------------------
const

  CheckTextureFormats: array[0..13] of TD3DFormat = (
  {  0 } D3DFMT_A8R8G8B8,
  {  1 } D3DFMT_X8R8G8B8,
  {  2 } D3DFMT_A1R5G5B5,
  {  3 } D3DFMT_X1R5G5B5,
  {  4 } D3DFMT_R5G6B5,
    D3DFMT_A8,
    D3DFMT_A4L4,

    D3DFMT_L8,
    D3DFMT_R3G3B2,
    // D3DFMT_DXT1                 = MAKEFOURCC('D', 'X', 'T', '1'),
    D3DFMT_DXT1,
    // D3DFMT_DXT2                 = MAKEFOURCC('D', 'X', 'T', '2'),
    D3DFMT_DXT2,
    // D3DFMT_DXT3                 = MAKEFOURCC('D', 'X', 'T', '3'),
    D3DFMT_DXT3,
    // D3DFMT_DXT4                 = MAKEFOURCC('D', 'X', 'T', '4'),
    D3DFMT_DXT4,
    // D3DFMT_DXT5                 = MAKEFOURCC('D', 'X', 'T', '5'),
    D3DFMT_DXT5);

//---------------------------------------------------------------------------
  DepthStencilFormats: array[0..5] of TD3DFormat = (
  {  0 } D3DFMT_D24S8,
  {  1 } D3DFMT_D24X4S4,
  {  2 } D3DFMT_D15S1,
  {  3 } D3DFMT_D32,
  {  4 } D3DFMT_D24X8,
  {  5 } D3DFMT_D16);

//---------------------------------------------------------------------------

constructor TDX8Device.Create();
begin
  inherited;
  Adapter := D3DADAPTER_DEFAULT;
  Direct3D := nil;
end;
//查询当前设备是否支持DXT纹理压缩

procedure TDX8Device.FindTextureFormats;
var
  FormatNo: Integer;
  AFormat: TD3DFormat;
  Mode: TD3DDisplayMode;
  I: Integer;
begin
  for I := 0 to SizeOf(TAsphyrePixelFormat) - 1 do
    TextureFormats[TAsphyrePixelFormat(I)] := False;
  if (Device8 = nil) then Exit;

  if Succeeded(Device8.GetDisplayMode(Mode)) then begin
    for FormatNo := 0 to High(CheckTextureFormats) do
    begin
      AFormat := CheckTextureFormats[FormatNo];
      if (Succeeded(Direct3D.CheckDeviceFormat(g_Caps8.AdapterOrdinal, g_Caps8.DeviceType,
        Mode.Format, 0, D3DRTYPE_TEXTURE, AFormat))) then
      begin
        TextureFormats[D3DFormatToPixelFormat(AFormat)] := True;
      end;
    end;
  end;
end;

//---------------------------------------------------------------------------

function TDX8Device.FindBackFormat(HiDepth: Boolean; Adapter, Width,
  Height: Integer): TD3DFormat;
const
  BackFormats: array[0..4] of TD3DFormat = (
  {  0 } D3DFMT_A8R8G8B8,
  {  1 } D3DFMT_X8R8G8B8,
  //16
  {  2 } D3DFMT_A1R5G5B5,
  {  3 } D3DFMT_X1R5G5B5,
  {  4 } D3DFMT_R5G6B5);
  HighIndexes: array[0..4] of Integer = (0, 1, 4, 2, 3);
  LowIndexes: array[0..4] of Integer = (4, 2, 3, 0, 1);
var
  IndexPtr: PInteger;
  FormatNo: Integer;
  Format: TD3DFormat;
  ModeCount: Integer;
  ModeNo: Integer;
  Mode: TD3DDisplayMode;
begin
  Result := D3DFMT_UNKNOWN;
  if (Direct3D = nil) then Exit;

  IndexPtr := @HighIndexes[0];
  if (not HiDepth) then IndexPtr := @LowIndexes[0];

  for FormatNo := 0 to 4 do
  begin
    Format := BackFormats[IndexPtr^];

    ModeCount := Direct3D.GetAdapterModeCount(Adapter); //shj
    for ModeNo := 0 to ModeCount - 1 do
    begin
//     if (Succeeded(Direct3D.EnumAdapterModes(Adapter, Format, ModeNo, Mode)))and //shj d9
//      (Integer(Mode.Width) = Width)and(Integer(Mode.Height) = Height) then
      if (Succeeded(Direct3D.EnumAdapterModes(Adapter, ModeNo, Mode))) and
         //增加位数检测 By TasNat at: 2012-06-23 14:06:47
         (AsphyrePixelFormatBits[D3DFormatToPixelFormat(Format)] =
         AsphyrePixelFormatBits[D3DFormatToPixelFormat(Mode.Format)])and
        (Integer(Mode.Width) = Width) and (Integer(Mode.Height) = Height) then
      begin
        Result := Mode.Format;//Format;
        Exit;
      end;
    end;

    Inc(IndexPtr);
  end;
end;

//---------------------------------------------------------------------------

function TDX8Device.FindDepthFormat(Depth: TDepthStencilType;
  BackFormat: TD3DFormat; Adapter: Integer): TD3DFormat;
const
  FormatIndexes: array[TDepthStencilType, 0..5] of Integer = (
    (-1, -1, -1, -1, -1, -1), (3, 0, 1, 4, 5, 2), (0, 1, 2, 3, 4, 5));
var
  FormatNo: Integer;
  Format: TD3DFormat;
  ModeCount: Integer;
  ModeNo: Integer;
begin
  Result := D3DFMT_UNKNOWN;
  if (Direct3D = nil) or (Depth = dsNone) then Exit;

  for FormatNo := 0 to 5 do
  begin
    Format := DepthStencilFormats[FormatIndexes[Depth, FormatNo]];

    ModeCount := Direct3D.GetAdapterModeCount(Adapter); //shj
//   ModeCount:= Direct3D.GetAdapterModeCount(Adapter, BackFormat); d9
    for ModeNo := 0 to ModeCount - 1 do
      if (Succeeded(Direct3D.CheckDeviceFormat(Adapter, D3DDEVTYPE_HAL,
        BackFormat, D3DUSAGE_DEPTHSTENCIL, D3DRTYPE_SURFACE, Format))) then
      begin
        Result := Format;
        Exit;
      end;
  end;
end;

//---------------------------------------------------------------------------

function TDX8Device.FindNearestMultisamples(MultiSamples: Integer;
  Adapter: Cardinal; SurfaceFormat, DepthFormat: TD3DFormat;
  Windowed: Boolean): TD3DMultisampleType;
var
  MType: TD3DMultisampleType;
  Allowed: Boolean;
  i: Integer;
begin
  Result := D3DMULTISAMPLE_NONE;
  if (Direct3D = nil) then Exit;

  for i := MultiSamples downto 2 do
  begin
    MType := TD3DMultisampleType(i);
    Allowed := Succeeded(Direct3D.CheckDeviceMultiSampleType(Adapter,
      D3DDEVTYPE_HAL, SurfaceFormat, Windowed, MType));
//    D3DDEVTYPE_HAL, SurfaceFormat, Windowed, MType, nil)); d9

    if (Allowed) and (DepthFormat <> D3DFMT_UNKNOWN) then
      Allowed := Succeeded(Direct3D.CheckDeviceMultiSampleType(Adapter,
        D3DDEVTYPE_HAL, DepthFormat, Windowed, MType));
//     D3DDEVTYPE_HAL, DepthFormat, Windowed, MType, nil));  //d9

    if (Allowed) then
    begin
      Result := MType;
      Break;
    end;
  end;
end;

//---------------------------------------------------------------------------

procedure TDX8Device.DefineParams(out Params: TD3DPresentParameters);
var
  Mode: TD3DDisplayMode;
begin
  FillChar(Params, SizeOf(TD3DPresentParameters), 0);

  Params.BackBufferWidth := Size.x;
  Params.BackBufferHeight := Size.y;
  Params.Windowed := Windowed or (not ExclusiveMode);
  Params.hDeviceWindow := WindowHandle;
  Params.SwapEffect := D3DSWAPEFFECT_DISCARD;

// Params.FullScreen_PresentationInterval:= D3DPRESENT_INTERVAL_IMMEDIATE;  //d9
// if (VSync) then Params.FullScreen_PresentationInterval:= D3DPRESENT_INTERVAL_ONE;

  if VSync then
    Params.FullScreen_PresentationInterval := D3DPRESENT_INTERVAL_ONE
  else
    Params.FullScreen_PresentationInterval := D3DPRESENT_INTERVAL_IMMEDIATE;
  Params.FullScreen_RefreshRateInHz := D3DPRESENT_RATE_DEFAULT;

  Params.BackBufferFormat := D3DFMT_UNKNOWN;
  if Windowed or (not ExclusiveMode) then
  begin
    if (Direct3D <> nil) and
      (Succeeded(Direct3D.GetAdapterDisplayMode(Adapter, Mode))) then
      Params.BackBufferFormat := Mode.Format

  end
  else
    Params.BackBufferFormat := FindBackFormat(HighBitDepth, Adapter, Size.x, Size.y);

  if (DepthStencil <> dsNone) then
  begin
    Params.EnableAutoDepthStencil := True;
    //Params.Flags:= D3DPRESENTFLAG_DISCARD_DEPTHSTENCIL; //d9  //此处不能打开，如果开启则d8下屏幕会花
   //Params.AutoDepthStencilFormat:= D3DFMT_D16; //如果有问题就改成这个
    Params.AutoDepthStencilFormat := FindDepthFormat(DepthStencil, Params.BackBufferFormat, Adapter); //d9
  end;

  Params.Flags := Params.Flags or D3DPRESENTFLAG_LOCKABLE_BACKBUFFER; //允许Lock

  if (DepthStencil <> dsNone) then
  begin
    Params.MultiSampleType := FindNearestMultisamples(Multisamples, Adapter, Params.BackBufferFormat, Params.AutoDepthStencilFormat, Params.Windowed);
  end
  else
  begin
    Params.MultiSampleType := FindNearestMultisamples(Multisamples, Adapter, Params.BackBufferFormat, D3DFMT_UNKNOWN, Params.Windowed);
  end;

  if Windowed or (not ExclusiveMode) then //窗口shj
  begin
    Params.FullScreen_PresentationInterval := D3DPRESENT_INTERVAL_DEFAULT;
    Params.FullScreen_RefreshRateInHz := D3DPRESENT_RATE_DEFAULT;
  end;

{$IFDEF BackBufferAlphaHack}
  Params.BackBufferFormat := D3DFMT_A8R8G8B8;
{$ENDIF}
  PixelFormat := D3DFormatToPixelFormat(Params.BackBufferFormat);
end;

//---------------------------------------------------------------------------

function TDX8Device.InitDevice(): Integer;
var
  Flags: Cardinal;
  label lSoft;
begin
  Result := -11;
  if (Direct3D <> nil) or (Device8 <> nil) then
   Exit;
  Direct3D := Direct3DCreate8(D3D_SDK_VERSION);
  if (Direct3D = nil) then
  begin
    AsphyreError := errCreateDirect3D;
    Result := -12;
    Exit;
  end;
  //if Failed(Direct3D.GetDeviceCaps(Adapter, D3DDEVTYPE_HAL, g_Caps8)) then
    //if Failed(Direct3D.GetDeviceCaps(Adapter, D3DDEVTYPE_REF, g_Caps8)) then
    //  if Failed(Direct3D.GetDeviceCaps(Adapter, D3DDEVTYPE_SW, g_Caps8)) then
   //     FillChar(g_Caps8, SizeOf(TD3DCaps8), 0);
  Result := 0;
  DefineParams(Params8);

  UsingDepthBuf := (DepthStencil <> dsNone);
  UsingStencil := (DepthStencil = dsDepthStencil);

  Flags := 0;

{$IFDEF NoWindowChanges}
  Flags := Flags or D3DCREATE_NOWINDOWCHANGES;
{$ENDIF}

{$IFDEF PreserveFPU}
  Flags := Flags or D3DCREATE_FPU_PRESERVE;
{$ENDIF}

{$IFDEF EnableMultithread}
  Flags := Flags or D3DCREATE_MULTITHREADED;
{$ENDIF}


  case VertexProcessing of //默认为 vptHardware
    vptMixed:
      if Failed(Direct3D.CreateDevice(Adapter, D3DDEVTYPE_HAL,
        WindowHandle, Flags or D3DCREATE_MIXED_VERTEXPROCESSING, Params8,
        Device8)) then
        Result := -13;

    vptHardware:
      begin
        if Failed(Direct3D.CreateDevice(Adapter, D3DDEVTYPE_HAL,
          WindowHandle, Flags or D3DCREATE_HARDWARE_VERTEXPROCESSING, Params8,
          Device8)) and
          Failed(Direct3D.CreateDevice(Adapter, D3DDEVTYPE_HAL,
          WindowHandle, D3DCREATE_HARDWARE_VERTEXPROCESSING, Params8,
          Device8)) then begin
            VertexProcessing := vptSoftware;
            goto lSoft;
          end;
      end;
    vptSoftware:
    lSoft:
      if Failed(Direct3D.CreateDevice(Adapter, D3DDEVTYPE_HAL,
        WindowHandle, Flags or D3DCREATE_SOFTWARE_VERTEXPROCESSING, Params8,Device8))and

        Failed(Direct3D.CreateDevice(Adapter, D3DDEVTYPE_HAL,
        WindowHandle, D3DCREATE_SOFTWARE_VERTEXPROCESSING, Params8, Device8))and

        Failed(Direct3D.CreateDevice(Adapter, D3DDEVTYPE_HAL,
             WindowHandle, D3DCREATE_PUREDEVICE, Params8,
             Device8)) then
             Result := -16;
  end;

  if (Result = 0) then
  begin
    if Failed(Device8.GetDeviceCaps(g_Caps8)) then begin
      AsphyreError := errRetreiveDeviceCaps;
      Result := -17;
    end else begin//在这检测支持的纹理才有意义 By TasNat at: 2012-06-17 10:00:09
      FindTextureFormats;  
    end;
  end else begin
    if (HighBitDepth) then
      AsphyreError := Byte(Params8.BackBufferFormat)
    else
      AsphyreError := 0;
  end;
  Adapter8 := Adapter;
  IsLostState := False;
end;

//---------------------------------------------------------------------------

procedure TDX8Device.DoneDevice();
begin
  if (Device8 <> nil) then Device8 := nil;
  if (Direct3D <> nil) then Direct3D := nil;

  FillChar(g_Caps8, SizeOf(TD3DCaps8), 0);
  FillChar(Params8, SizeOf(TD3DPresentParameters), 0);
  Adapter8 := 0;
end;

//---------------------------------------------------------------------------

procedure TDX8Device.MoveIntoLostState();
begin
  if (not IsLostState) then
  begin
    EventDeviceLost.Notify(Self, nil);
    IsLostState := True;
  end;
end;

//---------------------------------------------------------------------------

function TDX8Device.AttemptRecoverState(): Boolean;
var
  Status: HRESULT;
begin
  Result := Device8 <> nil;
  if (not Result) then Exit;

  if (IsLostState) then
  begin
    DefineParams(Params8);//修正桌面颜色深度改变黑屏 By TasNat at: 2012-03-10 23:03:13
    Status := Device8.Reset(Params8);
    Result := Succeeded(Status);
    if (Result) then
    begin
      IsLostState := False;
      EventDeviceReset.Notify(Self, nil);
    end;
  end;
end;

//---------------------------------------------------------------------------

function TDX8Device.HandleDriverError(): Boolean;
begin
  MoveIntoLostState();
  Result := AttemptRecoverState();
end;

//---------------------------------------------------------------------------

function TDX8Device.CheckLostScenario(): Boolean;
var
  Res: HResult;
begin
  Result := (Device8 <> nil);
  if (not Result) then Exit;

  Res := Device8.TestCooperativeLevel();

  case Res of
    D3DERR_DEVICELOST:
      begin
        MoveIntoLostState();
        Result := False;
      end;

    D3DERR_DEVICENOTRESET:
      Result := AttemptRecoverState();

    D3DERR_DRIVERINTERNALERROR:
      Result := HandleDriverError();

    D3D_OK:
      Result := True;

  else Result := False;
  end;
end;

//---------------------------------------------------------------------------

procedure TDX8Device.ResetDevice();
begin
  MoveIntoLostState();
  AttemptRecoverState();
end;

//---------------------------------------------------------------------------

function TDX8Device.MayRender(): Boolean;
begin
  Result := CheckLostScenario();
end;

//---------------------------------------------------------------------------

procedure TDX8Device.UpdateParams();
begin
  MoveIntoLostState();

  Params8.BackBufferWidth := Size.x;
  Params8.BackBufferHeight := Size.y;
  Params8.Windowed := Windowed or (not ExclusiveMode);
  //Params8.BackBufferFormat := D3DFMT_A8R8G8B8;
  if VSync then
    Params8.FullScreen_PresentationInterval := D3DPRESENT_INTERVAL_ONE
  else
    Params8.FullScreen_PresentationInterval := D3DPRESENT_INTERVAL_IMMEDIATE;
  Params8.FullScreen_RefreshRateInHz := D3DPRESENT_RATE_DEFAULT;
// Params8.PresentationInterval:= D3DPRESENT_INTERVAL_IMMEDIATE;         //d9
// if (VSync) then Params8.PresentationInterval:= D3DPRESENT_INTERVAL_ONE;
  AttemptRecoverState();
end;

//---------------------------------------------------------------------------

procedure TDX8Device.Clear(Color: Cardinal);
var
  ClearFlags: Cardinal;
begin
  ClearFlags := D3DCLEAR_TARGET;

  if (UsingDepthBuf) then
  begin
    ClearFlags := ClearFlags or D3DCLEAR_ZBUFFER;
    if (UsingStencil) then ClearFlags := ClearFlags or D3DCLEAR_STENCIL;
  end;

  Device8.Clear(0, nil, ClearFlags, Color, FillDepthValue, FillStencilValue);
end;

//---------------------------------------------------------------------------

procedure TDX8Device.RenderWith(hWnd: THandle; Handler: TNotifyEvent;
  Background: Cardinal);
begin
  if (Device8 = nil) then Exit;

  Clear(Background);

  if (Succeeded(Device8.BeginScene())) then
  begin
    EventBeginScene.Notify(Self, nil);
    try
      Handler(Self);
    except
      //修复绘图出错导致黑屏 By TasNat at: 2012-07-03 13:03:24
    end;
    EventEndScene.Notify(Self, nil);
    Device8.EndScene();
  end;

  Device8.Present(nil, nil, hWnd, nil);
end;

//---------------------------------------------------------------------------

procedure TDX8Device.RenderToTarget(Handler: TNotifyEvent; Background: Cardinal;
  FillBk: Boolean);
var
  Result :HResult;
begin
  if (FillBk) then
    Clear(Background);
  Result := Device8.BeginScene;
  if Succeeded(Result) then
  begin
    EventBeginScene.Notify(Self, nil);

    Handler(Self);

    EventEndScene.Notify(Self, nil);
    Device8.EndScene();
  end;
end;

//---------------------------------------------------------------------------

//---------------------------------------------------------------------------

function TDX8Device.LockBackBuffer(out Bits: Pointer;
  out Pitch: Integer): Boolean;
var
  pLockedRect: TD3DLockedRect; Rect: TRect;
begin
  Bits := nil;
  Pitch := 0;
  Result := False;

  if Succeeded(Device8.CreateImageSurface(Size.x, Size.y, PixelFormatToD3DFormat(PixelFormat), DBackSurface8)) then begin //
    if (Windowed or (not ExclusiveMode)) and Succeeded(Device8.GetBackBuffer(0, D3DBACKBUFFER_TYPE_MONO, DBackSurface8)) then begin
      if Succeeded(DBackSurface8.LockRect(pLockedRect, nil, D3DLOCK_READONLY)) then begin
        Pitch := pLockedRect.Pitch;
        Bits := pLockedRect.pBits;
        Result := (Bits <> nil) and (Pitch > 0);
      end;
    end else
      if (not Windowed) and ExclusiveMode and Succeeded(Device8.GetFrontBuffer(DBackSurface8)) then begin
      if Succeeded(DBackSurface8.LockRect(pLockedRect, nil, D3DLOCK_READONLY)) then begin
        Pitch := pLockedRect.Pitch;
        Bits := pLockedRect.pBits;
        Result := (Bits <> nil) and (Pitch > 0);
      end;
    end;
  end;
end;

function TDX8Device.UnLockBackBuffer(): Boolean;
begin
  Result := False;
  if DBackSurface8 <> nil then begin
    Result := Succeeded(DBackSurface8.UnlockRect);
    DBackSurface8 := nil;
  end;
end;

procedure TDX8Device.ScreenCapture(const FileName: string; ImageFileFormat: TImageFileFormat);
var
  Surface: IDirect3DSurface8;
begin
  //if Succeeded(Device8.CreateImageSurface(Size.x, Size.y, PixelFormatToD3DFormat(PixelFormat), Surface)) then begin //
    if (Windowed or (not ExclusiveMode)) and Succeeded(Device8.GetBackBuffer(0, D3DBACKBUFFER_TYPE_MONO, Surface)) then begin
      try
        D3DXSaveSurfaceToFile(PChar(FileName), TD3DXImageFileFormat(ImageFileFormat), Surface, nil, nil);
      except

      end;
    end else
      if (not Windowed) and ExclusiveMode and Succeeded(Device8.GetFrontBuffer(Surface)) then begin
      try
        D3DXSaveSurfaceToFile(PChar(FileName), TD3DXImageFileFormat(ImageFileFormat), Surface, nil, nil);
      except

      end;
    end;
    Surface := nil;
  //end;
end;

end.

