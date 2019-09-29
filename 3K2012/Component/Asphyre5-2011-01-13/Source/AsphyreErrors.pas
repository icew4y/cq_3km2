unit AsphyreErrors;

//---------------------------------------------------------------------------
interface

//---------------------------------------------------------------------------
uses
  Windows, SysUtils;

//---------------------------------------------------------------------------
{$DEFINE debug}

//---------------------------------------------------------------------------
const
  errNone = 0; // No error

  errInvalidCall = -100;

  errEnumDisplayMode = -200; // Failed enumerating available display modes.
  errChangeDisplayMode = -201; // Failed changing the current display mode.
  errRestoreDisplayMode = -202; // Failed to restore previous display mode.
  errUnsupportedDisplayMode = -203; // The specified display mode is not supported.
  errInvalidWindowHandle = -204; // The specified window handle is invalid.
  errCreateWindowPalette = -205; // Could not create a valid window palette.
  errCannotSelectTexture = -206; // Cannot select the texture for operation.
  errCannotCreateTexture = -207; // Cannot create texture compatible with specified parameters.
  errUploadTexturePixels = -208; // Failed uploading texture pixel data.
  errDownloadTexturePixels = -209; // Failed downloading texture pixel data.
  errUnsupportedOperation = -210; // The attempted operation is not supported.

  errGeometryTooComplex = -300; // The geometry is too complex to be rendered.

  errCreateDirectDraw = -400; // Cannot create DirectDraw interface.
  errCreateDirect3D = -401; // Cannot create Direct3D interface.
  errCreateDirect3DDevice = -402; // Cannot create Direct3D interface.
  errRetreiveDeviceCaps = -403; // Cannot retreive device capabilities.
  errUnsupportedFormat = -404; // The specified pixel format is not supported.
  errCreateDepthStencil = -405; // Failed to create depth-stencil buffer.
  errGetTextureSurface = -406; // Failed to retreive texture's surface.
  errGetRenderTarget = -407; // Cannot retreive current render target.
  errGetDepthStencilBuffer = -408; // Cannot retreive current depth-stencil buffer.
  errSetRenderTarget = -409; // Unable to set new render target.
  errSetDepthStencilBuffer = -410; // Unable to set new depth-stencil buffer.
  errAccessTexture = -411; // Unable to get access to texture's pixels.
  errGetSurfaceDesc = -412; // Failed to retreive surface description.
  errCooperativeLevel = -413; // Failed to set the cooperative level.
  errSetDisplayMode = -414; // Failed to set the specified display mode.
  errCreateSurface = -415; // New surface could not be created.
  errCreateClipper = -416; // New clipper object could not be created.
  errRetreiveClipper = -417; // Unable to retreive existing clipper object.

  errWindowInformation = -700; // The window information could not be retreived.
  errMonitorInformation = -701; // The monitor information could not be retreived.

  errImageNotExist = -800; // The specified image does not exist.
  errPatternNotExist = -801; // The specified pattern is not found in the image.

//---------------------------------------------------------------------------
  ErrorQueue = 100;

//---------------------------------------------------------------------------
var
  AsphyreError: Integer = 0;

//---------------------------------------------------------------------------
type
  PErrorQueueItem = ^TErrorQueueItem;
  TErrorQueueItem = record
    ErrorCode: Integer;
    OccurTime: Cardinal;
    Reference: Pointer;
    ClassName: ShortString;
    ErrMethod: ShortString;
  end;

//---------------------------------------------------------------------------
  TAsphyreErrors = class
  private
    Queue: array[0..ErrorQueue - 1] of TErrorQueueItem;
    InitTime: Cardinal;

    function GetError(Index: Integer): PErrorQueueItem;
    procedure Shift();
  public
    property Error[Index: Integer]: PErrorQueueItem read GetError;

    procedure Clear();
    procedure Insert(Code: Integer; Reference: Pointer = nil;
      const ClassName: ShortString = ''; const ErrMethod: ShortString = '');

    function InErrorState(): Boolean;

    constructor Create();
  end;

//---------------------------------------------------------------------------
var
  Errors: TAsphyreErrors = nil;

//---------------------------------------------------------------------------
implementation

//---------------------------------------------------------------------------

constructor TAsphyreErrors.Create();
begin
  inherited;

  InitTime := GetTickCount();

  Clear();
end;

//---------------------------------------------------------------------------

function TAsphyreErrors.GetError(Index: Integer): PErrorQueueItem;
begin
  if (Index >= 0) and (Index < ErrorQueue) then
    Result := @Queue[Index] else Result := nil;
end;

//---------------------------------------------------------------------------

procedure TAsphyreErrors.Clear();
begin
  FillChar(Queue, SizeOf(TErrorQueueItem) * ErrorQueue, 0);
end;

//---------------------------------------------------------------------------

procedure TAsphyreErrors.Shift();
var
  i: Integer;
begin
  for i := ErrorQueue - 1 downto 1 do
    Queue[i] := Queue[i - 1];

  FillChar(Queue[0], SizeOf(TErrorQueueItem), 0);
end;

procedure DebugOutStr(Msg: string);
var
  flname: string;
  fhandle: TextFile;
begin
//DScreen.AddChatBoardString(msg,clWhite, clBlack);
  //exit;
  flname := '.\AsphyreError.txt';
  if FileExists(flname) then begin
    AssignFile(fhandle, flname);
    Append(fhandle);
  end else begin
    AssignFile(fhandle, flname);
    Rewrite(fhandle);
  end;
  Writeln(fhandle, TimeToStr(Time) + ' ' + Msg);
  CloseFile(fhandle);
end;
//---------------------------------------------------------------------------

procedure TAsphyreErrors.Insert(Code: Integer; Reference: Pointer = nil;
  const ClassName: ShortString = ''; const ErrMethod: ShortString = '');
begin
  Shift();

  Queue[0].ErrorCode := Code;
  Queue[0].Reference := Reference;
  Queue[0].ClassName := ClassName;
  Queue[0].ErrMethod := ErrMethod;
  Queue[0].OccurTime := GetTickCount() - InitTime;

 // Time wrap fix
  if (High(Cardinal) - Queue[0].OccurTime < Queue[0].OccurTime) then
    Queue[0].OccurTime := High(Cardinal) - Queue[0].OccurTime;

{$IFDEF debug}
 OutputDebugString(PChar('[debug] 0x' + IntToHex(Integer(Reference), 8) + ': ' +
  ClassName + '.' + ErrMethod + ' - Error #' + IntToStr(Code)));
  //DebugOutStr('[debug] 0x' + IntToHex(Integer(Reference), 8) + ': ' +
    //ClassName + '.' + ErrMethod + ' - Error #' + IntToStr(Code));
{$ENDIF}
end;

//---------------------------------------------------------------------------

function TAsphyreErrors.InErrorState(): Boolean;
begin
  Result := Queue[0].ErrorCode <> errNone;
end;

//---------------------------------------------------------------------------
initialization
  Errors := TAsphyreErrors.Create();

//---------------------------------------------------------------------------
finalization
  FreeAndNil(Errors);

//---------------------------------------------------------------------------
end.

