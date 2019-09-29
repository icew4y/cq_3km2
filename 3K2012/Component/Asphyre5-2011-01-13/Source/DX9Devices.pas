unit DX9Devices;

//---------------------------------------------------------------------------
interface

//---------------------------------------------------------------------------
uses
  Windows, Direct3D9, Classes, AbstractDevices, AbstractTextures, AsphyreTypes;

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
  TDX9Device = class(TAsphyreDevice)
  private
    UsingDepthBuf: Boolean;
    UsingStencil: Boolean;
    IsLostState: Boolean;

    procedure FindTextureFormats(Adapter: Integer; BackFormat: TD3DFormat);

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
    function InitDevice(): Boolean; override;
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
    procedure ScreenCapture(const FileName: string; ImageFileFormat: TImageFileFormat); override;
  end;

//---------------------------------------------------------------------------
implementation

//---------------------------------------------------------------------------
uses
  D3DX9, DX9Types, AsphyreErrors;

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

  BackFormats: array[0..4] of TD3DFormat = (
  {  0 } D3DFMT_A8R8G8B8,
  {  1 } D3DFMT_X8R8G8B8,
  {  2 } D3DFMT_A1R5G5B5,
  {  3 } D3DFMT_X1R5G5B5,
  {  4 } D3DFMT_R5G6B5);

//---------------------------------------------------------------------------
  DepthStencilFormats: array[0..5] of TD3DFormat = (
  {  0 } D3DFMT_D24S8,
  {  1 } D3DFMT_D24X4S4,
  {  2 } D3DFMT_D15S1,
  {  3 } D3DFMT_D32,
  {  4 } D3DFMT_D24X8,
  {  5 } D3DFMT_D16);

//---------------------------------------------------------------------------

constructor TDX9Device.Create();
begin
  inherited;

  Direct3D := nil;
end;

//查询当前设备是否支持DXT纹理压缩

procedure TDX9Device.FindTextureFormats(Adapter: Integer; BackFormat: TD3DFormat);
var
  FormatNo: Integer;
  AFormat: TD3DFormat;
  Mode: TD3DDisplayMode;
  I: Integer;
begin
  for I := 0 to SizeOf(TAsphyrePixelFormat) - 1 do
    TextureFormats[TAsphyrePixelFormat(I)] := False;
  if (Direct3D = nil) then Exit;

  if Succeeded(Direct3D.GetAdapterDisplayMode(D3DADAPTER_DEFAULT, Mode)) then begin
    for FormatNo := 0 to High(CheckTextureFormats) do
    begin
      AFormat := CheckTextureFormats[FormatNo];
      if (Succeeded(Direct3D.CheckDeviceFormat(D3DADAPTER_DEFAULT, D3DDEVTYPE_HAL,
        Mode.Format, 0, D3DRTYPE_TEXTURE, AFormat))) then
      begin
        //showmessage(IntToStr(FormatNo));
        TextureFormats[D3DFormatToPixelFormat(AFormat)] := True;
      end;
    end;
  end;
end;
//---------------------------------------------------------------------------

function TDX9Device.FindBackFormat(HiDepth: Boolean; Adapter, Width,
  Height: Integer): TD3DFormat;
const
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

    ModeCount := Direct3D.GetAdapterModeCount(Adapter, Format);
    for ModeNo := 0 to ModeCount - 1 do
    begin
      if (Succeeded(Direct3D.EnumAdapterModes(Adapter, Format, ModeNo, Mode))) and
        (Integer(Mode.Width) = Width) and (Integer(Mode.Height) = Height) then
      begin
        Result := Format;
        Exit;
      end;
    end;

    Inc(IndexPtr);
  end;
end;

//---------------------------------------------------------------------------

function TDX9Device.FindDepthFormat(Depth: TDepthStencilType;
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

    ModeCount := Direct3D.GetAdapterModeCount(Adapter, BackFormat);
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

function TDX9Device.FindNearestMultisamples(MultiSamples: Integer;
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
      D3DDEVTYPE_HAL, SurfaceFormat, Windowed, MType, nil));

    if (Allowed) and (DepthFormat <> D3DFMT_UNKNOWN) then
      Allowed := Succeeded(Direct3D.CheckDeviceMultiSampleType(Adapter,
        D3DDEVTYPE_HAL, DepthFormat, Windowed, MType, nil));

    if (Allowed) then
    begin
      Result := MType;
      Break;
    end;
  end;
end;


{
创建设备还需要一个 D3DPRESENT_PARAMETERS 结构，但仅有少数几个参数较为重要。选择这些参数可以最小化内存空间。

将 BackBufferHeight 和 BackBufferWidth 字段都设置为 1。如果将这两个字段设置为 0，则会使这两个字段设置为 HWND 的尺寸。

始终设置 D3DCREATE_MULTITHREADED 和 D3DCREATE_FPU_PRESERVE 标志，以防止 Direct3D9 使用损坏的内存，并防止 Direct3D9 更改 FPU 设置。

}
//---------------------------------------------------------------------------

procedure TDX9Device.DefineParams(out Params: TD3DPresentParameters);
var
  Mode: TD3DDisplayMode;
begin
  FillChar(Params, SizeOf(TD3DPresentParameters), 0);

  Params.BackBufferWidth := Size.x;
  Params.BackBufferHeight := Size.y;
  Params.Windowed := Windowed or (not ExclusiveMode);
  Params.hDeviceWindow := WindowHandle;
  Params.SwapEffect := D3DSWAPEFFECT_DISCARD;
  //Params.BackBufferCount:=1;
  Params.PresentationInterval := D3DPRESENT_INTERVAL_IMMEDIATE; //垂直同步
  if (VSync) then Params.PresentationInterval := D3DPRESENT_INTERVAL_ONE; //帧数等于显示器的刷新率

  if Windowed or (not ExclusiveMode) then
  begin
    Params.BackBufferFormat := D3DFMT_UNKNOWN;

    if (Direct3D <> nil) and
      (Succeeded(Direct3D.GetAdapterDisplayMode(Adapter, Mode))) then
      Params.BackBufferFormat := Mode.Format;
  end else Params.BackBufferFormat := FindBackFormat(HighBitDepth, Adapter,
      Size.x, Size.y);

  if (DepthStencil <> dsNone) then
  begin
    Params.EnableAutoDepthStencil := True;
    Params.Flags := D3DPRESENTFLAG_DISCARD_DEPTHSTENCIL;
    Params.AutoDepthStencilFormat := FindDepthFormat(DepthStencil,
      Params.BackBufferFormat, Adapter);
  end;
  Params.Flags := Params.Flags or D3DPRESENTFLAG_LOCKABLE_BACKBUFFER; //允许Lock
  if (DepthStencil <> dsNone) then
  begin
    Params.MultiSampleType := FindNearestMultisamples(Multisamples,
      Adapter, Params.BackBufferFormat, Params.AutoDepthStencilFormat,
      Params.Windowed);
  end else
  begin
    Params.MultiSampleType := FindNearestMultisamples(Multisamples,
      Adapter, Params.BackBufferFormat, D3DFMT_UNKNOWN, Params.Windowed);
  end;
  FindTextureFormats(Adapter, Params.BackBufferFormat);
{$IFDEF BackBufferAlphaHack}
  Params.BackBufferFormat := D3DFMT_A8R8G8B8;
{
在窗口模式下，可以指定 BackBufferFormat 的 Unknown 格式。
这样可以通知运行库使用当前显示模式格式，
并无需调用 Device 的 DisplayMode。

对于有窗口的应用程序，由于颜色转换可由硬件完成（前提是硬件支持颜色转换），
因此后台缓冲区格式不需要匹配显示模式格式。
可以使用的后台缓冲区格式组受到约束，
但运行库允许将任何有效的后台缓冲区格式呈现为任何桌面格式。
在桌面模式下，设备还必须是可操作的，
因为在每像素 8 位模式下，设备通常是不可操作的。
全屏应用程序无法执行颜色转换。
}
{$ENDIF}
  PixelFormat := D3DFormatToPixelFormat(Params.BackBufferFormat);
end;

//---------------------------------------------------------------------------

function TDX9Device.InitDevice(): Boolean;
var
  Flags: Cardinal;
begin
  Result := (Direct3D = nil) and (Device9 = nil);
  if (not Result) then Exit;

  Direct3D := Direct3DCreate9(D3D_SDK_VERSION);
  if (Direct3D = nil) then
  begin
    AsphyreError := errCreateDirect3D;
    Result := False;
    Exit;
  end;


  DefineParams(Params9);

  UsingDepthBuf := (DepthStencil <> dsNone);
  UsingStencil := (DepthStencil = dsDepthStencil);

  Flags := 0;

{$IFDEF NoWindowChanges}
  Flags := Flags or D3DCREATE_NOWINDOWCHANGES;
{$ENDIF}

{$IFDEF PreserveFPU} //浮点运算单元
  Flags := Flags or D3DCREATE_FPU_PRESERVE;
{$ENDIF}

{$IFDEF EnableMultithread} //多线程
  Flags := Flags or D3DCREATE_MULTITHREADED;
{$ENDIF}

  case VertexProcessing of
    vptMixed:
      Result := Succeeded(Direct3D.CreateDevice(Adapter, D3DDEVTYPE_HAL,
        WindowHandle, Flags or D3DCREATE_MIXED_VERTEXPROCESSING, @Params9,
        Device9));

    vptHardware:
      begin
        Result := Succeeded(Direct3D.CreateDevice(Adapter, D3DDEVTYPE_HAL,
          WindowHandle, Flags or D3DCREATE_HARDWARE_VERTEXPROCESSING, @Params9,
          Device9));

        if (not Result) then
          Result := Succeeded(Direct3D.CreateDevice(Adapter, D3DDEVTYPE_HAL,
            WindowHandle, Flags or D3DCREATE_SOFTWARE_VERTEXPROCESSING, @Params9,
            Device9));
      end;

    vptSoftware:
      Result := Succeeded(Direct3D.CreateDevice(Adapter, D3DDEVTYPE_HAL,
        WindowHandle, Flags or D3DCREATE_SOFTWARE_VERTEXPROCESSING, @Params9,
        Device9));
  end;

  if (Result) then
  begin
    //Result := Succeeded(Device9.SetDialogBoxMode(True));  //兼容GDI的绘制方式
    //if (Result) then
    Result := Succeeded(Device9.GetDeviceCaps(Caps9));
    if (not Result) then AsphyreError := errRetreiveDeviceCaps;
  end else AsphyreError := errCreateDirect3DDevice;

  Adapter9 := Adapter;
  IsLostState := False;
end;

//---------------------------------------------------------------------------

procedure TDX9Device.DoneDevice();
begin
  if (Device9 <> nil) then Device9 := nil;
  if (Direct3D <> nil) then Direct3D := nil;

  FillChar(Caps9, SizeOf(TD3DCaps9), 0);
  FillChar(Params9, SizeOf(TD3DPresentParameters), 0);
  Adapter9 := 0;
end;

//---------------------------------------------------------------------------

procedure TDX9Device.MoveIntoLostState();
begin
  if (not IsLostState) then
  begin
    EventDeviceLost.Notify(Self, nil);
    IsLostState := True;
  end;
end;

//---------------------------------------------------------------------------

function TDX9Device.AttemptRecoverState(): Boolean;
begin
  Result := Device9 <> nil;
  if (not Result) then Exit;

  if (IsLostState) then
  begin
    Result := Succeeded(Device9.Reset(Params9));
    if (Result) then
    begin
      IsLostState := False;
      EventDeviceReset.Notify(Self, nil);
    end;
  end;
end;

//---------------------------------------------------------------------------

function TDX9Device.HandleDriverError(): Boolean;
begin
  MoveIntoLostState();
  Result := AttemptRecoverState();
end;

//---------------------------------------------------------------------------

function TDX9Device.CheckLostScenario(): Boolean;
var
  Res: HResult;
begin
  Result := (Device9 <> nil);
  if (not Result) then Exit;

  Res := Device9.TestCooperativeLevel();

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

procedure TDX9Device.ResetDevice();
begin
  MoveIntoLostState();
  AttemptRecoverState();
end;

//---------------------------------------------------------------------------

function TDX9Device.MayRender(): Boolean;
begin
  Result := CheckLostScenario();
end;

//---------------------------------------------------------------------------

procedure TDX9Device.UpdateParams();
begin
  MoveIntoLostState();

  Params9.BackBufferWidth := Size.x;
  Params9.BackBufferHeight := Size.y;
  Params9.Windowed := Windowed or (not ExclusiveMode);

  Params9.PresentationInterval := D3DPRESENT_INTERVAL_IMMEDIATE;
  if (VSync) then Params9.PresentationInterval := D3DPRESENT_INTERVAL_ONE;

  AttemptRecoverState();
end;

//---------------------------------------------------------------------------

procedure TDX9Device.Clear(Color: Cardinal);
var
  ClearFlags: Cardinal;
begin
  ClearFlags := D3DCLEAR_TARGET;

  if (UsingDepthBuf) then
  begin
    ClearFlags := ClearFlags or D3DCLEAR_ZBUFFER;
    if (UsingStencil) then ClearFlags := ClearFlags or D3DCLEAR_STENCIL;
  end;

  Device9.Clear(0, nil, ClearFlags, Color, FillDepthValue, FillStencilValue);
end;

//---------------------------------------------------------------------------

procedure TDX9Device.RenderWith(hWnd: THandle; Handler: TNotifyEvent;
  Background: Cardinal);
begin
  if (Device9 = nil) then Exit;

  Clear(Background);

  if (Succeeded(Device9.BeginScene())) then
  begin
    EventBeginScene.Notify(Self, nil);

    Handler(Self);

    EventEndScene.Notify(Self, nil);
    Device9.EndScene();
  end;
  Device9.Present(nil, nil, hWnd, nil);
end;

//---------------------------------------------------------------------------

procedure TDX9Device.RenderToTarget(Handler: TNotifyEvent; Background: Cardinal;
  FillBk: Boolean);
begin
  if (FillBk) then
    Clear(Background);

  if (Succeeded(Device9.BeginScene())) then
  begin
    EventBeginScene.Notify(Self, nil);

    Handler(Self);

    EventEndScene.Notify(Self, nil);
    Device9.EndScene();
  end;
end;

//---------------------------------------------------------------------------

function TDX9Device.LockBackBuffer(out Bits: Pointer;
  out Pitch: Integer): Boolean;
var
  pLockedRect: TD3DLockedRect; Rect: TRect;
begin
  Bits := nil;
  Pitch := 0;
  Result := False;
  if Succeeded(Device9.GetBackBuffer(0, 0, D3DBACKBUFFER_TYPE_MONO, DBackSurface9)) then begin
    if Succeeded(DBackSurface9.LockRect(pLockedRect, nil, D3DLOCK_NO_DIRTY_UPDATE or D3DLOCK_NOSYSLOCK or D3DLOCK_READONLY)) then begin //D3DLOCK_NO_DIRTY_UPDATE or D3DLOCK_NOSYSLOCK or D3DLOCK_READONLY
      Bits := pLockedRect.pBits;
      Pitch := pLockedRect.Pitch;
      Result := (Bits <> nil) and (Pitch > 0);
    end;
  end;
end;

function TDX9Device.UnLockBackBuffer(): Boolean;
begin
  Result := False;
  if DBackSurface9 <> nil then begin
    Result := Succeeded(DBackSurface9.UnlockRect);
    DBackSurface9 := nil;
  end;
end;

procedure TDX9Device.ScreenCapture(const FileName: string; ImageFileFormat: TImageFileFormat);
var
  Surface: IDirect3DSurface9;
begin
  if Succeeded(Device9.CreateOffscreenPlainSurface(Size.x, Size.y, PixelFormatToD3DFormat(PixelFormat), D3DPOOL_SCRATCH, Surface, nil)) then begin
    if (Windowed or (not ExclusiveMode)) and Succeeded(Device9.GetBackBuffer(0, 0, D3DBACKBUFFER_TYPE_MONO, Surface)) then begin
      try
        D3DXSaveSurfaceToFile(PChar(FileName), TD3DXImageFileFormat(ImageFileFormat), Surface, nil, nil);
      except

      end;
    end else
      if (not Windowed or ExclusiveMode) and Succeeded(Device9.GetFrontBufferData(0, Surface)) then begin
      try
        D3DXSaveSurfaceToFile(PChar(FileName), TD3DXImageFileFormat(ImageFileFormat), Surface, nil, nil);
      except

      end;
    end;
    Surface := nil; //; ImageFileFormat: TD3DXImageFileFormat
  end;
end;

end.

