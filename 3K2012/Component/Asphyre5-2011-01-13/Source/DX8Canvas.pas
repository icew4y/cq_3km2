unit DX8Canvas;

//---------------------------------------------------------------------------
interface

//---------------------------------------------------------------------------
uses
  Windows, Direct3D8, AbstractCanvas, Vectors2, Matrices3,
  AsphyreColors, AsphyreTypes, AsphyreUtils, AbstractTextures;

//---------------------------------------------------------------------------
const
 // The following parameters roughly affect the rendering performance. The
 // higher values means that more primitives will fit in cache, but it will
 // also occupy more bandwidth, even when few primitives are rendered.
 //
 // These parameters can be fine-tuned in a finished product to improve the
 // overall performance.
  MaxCachedPrimitives = 3072;
  MaxCachedIndices = 4096;
  MaxCachedVertices = 4096;

//---------------------------------------------------------------------------
// The following option controls the behavior of antialiased lines.
// Enable the option for compatibility with DirectX 7 wrapper.
// Also note that antialiased lines don't work on Intel GMA X3100.
//---------------------------------------------------------------------------
{$DEFINE NoAntialiasedLines}

//---------------------------------------------------------------------------
type
  TDrawingMode = (dmUnknown, dmPoints, dmLines, dmTriangles);

//---------------------------------------------------------------------------
  TDX8Canvas = class(TAsphyreCanvas)
  private
    VertexBuffer: IDirect3DVertexBuffer8;
    IndexBuffer: IDirect3DIndexBuffer8;

    VertexArray: Pointer;
    IndexArray: Pointer;

    DrawingMode: TDrawingMode;

    FVertexCache: Integer;
    FIndexCache: Integer;
    FVertexCount: Integer;
    FIndexCount: Integer;

    FPrimitives: Integer;
    FMaxPrimitives: Integer;

    ActiveTex: TAsphyreCustomTexture;
    CachedTex: TAsphyreCustomTexture;
    CachedEffect: TDrawingEffect;
    QuadMapping: TPoint4;
    procedure InitCacheSpec();
    procedure PrepareVertexArray();

    procedure CreateStaticObjects();
    procedure DestroyStaticObjects();

    function CreateDynamicBuffers(): Boolean;
    procedure DestroyDynamicBuffers();

    function UploadVertexBuffer(): Boolean;
    function UploadIndexBuffer(): Boolean;
    procedure DrawBuffers();

    function NextVertexEntry(): Pointer;
    procedure AddIndexEntry(Index: Integer);
    function RequestCache(Mode: TDrawingMode; Vertices, Indices: Integer;
      Effect: TDrawingEffect; Texture: TAsphyreCustomTexture): Boolean;

    procedure SetEffectStates(Effect: TDrawingEffect);
  protected
    function HandleDeviceCreate(): Boolean; override;
    procedure HandleDeviceDestroy(); override;
    function HandleDeviceReset(): Boolean; override;
    procedure HandleDeviceLost(); override;

    procedure HandleBeginScene(); override;
    procedure HandleEndScene(); override;

    procedure GetViewport(out x, y, Width, Height: Integer); override;
    procedure SetViewport(x, y, Width, Height: Integer); override;

    function GetAntialias(): Boolean; override;
    procedure SetAntialias(const Value: Boolean); override;
    function GetMipMapping(): Boolean; override;
    procedure SetMipMapping(const Value: Boolean); override;
  public
    procedure PutPixel(const Point: TPoint2; Color: Cardinal); override;
    procedure Line(const Src, Dest: TPoint2; Color0, Color1: Cardinal); override;

    procedure DrawIndexedTriangles(Vertices: PPoint2; Colors: PCardinal;
      Indices: PInteger; NoVertices, NoTriangles: Integer;
      Effect: TDrawingEffect = deNormal); override;

    procedure UseTexture(Texture: TAsphyreCustomTexture;
      const Mapping: TPoint4); override;

    procedure TexMap(const Points: TPoint4; const Colors: TColor4;
      Effect: TDrawingEffect = deNormal); override;

    procedure Flush(); override;

    procedure ResetDeviceStates();

    constructor Create(); override;
    destructor Destroy(); override;
  end;

//---------------------------------------------------------------------------
implementation

//--------------------------------------------------------------------------
uses
  DXTypes, DX8Types, AsphyreErrors;

//--------------------------------------------------------------------------
const
  VertexFVFType = D3DFVF_XYZRHW or D3DFVF_DIFFUSE or D3DFVF_TEX1;

//--------------------------------------------------------------------------
type
  PVertexRecord = ^TVertexRecord;
  TVertexRecord = record
    Vertex: TD3DVector;
    rhw: Single;
    Color: Longword;
    u, v: Single;
  end;

//--------------------------------------------------------------------------

constructor TDX8Canvas.Create();
begin
  inherited;

  VertexArray := nil;
  IndexArray := nil;
  VertexBuffer := nil;
  IndexBuffer := nil;
end;

//---------------------------------------------------------------------------

destructor TDX8Canvas.Destroy();
begin
  DestroyDynamicBuffers();
  DestroyStaticObjects();

  inherited;
end;

//---------------------------------------------------------------------------

procedure TDX8Canvas.InitCacheSpec();
begin
  with g_Caps8 do
  begin
    FMaxPrimitives := Min2(MaxPrimitiveCount, MaxCachedPrimitives);
    FVertexCache := Min2(MaxVertexIndex, MaxCachedVertices);
    FIndexCache := Min2(MaxVertexIndex, MaxCachedIndices);
  end;
end;

//---------------------------------------------------------------------------

procedure TDX8Canvas.PrepareVertexArray();
var
  Entry: PVertexRecord;
  Index: Integer;
begin
  Entry := VertexArray;
  for Index := 0 to MaxCachedVertices - 1 do
  begin
    FillChar(Entry^, SizeOf(TVertexRecord), 0);

    Entry.Vertex.z := 0.0;
    Entry.rhw := 1.0;

    Inc(Entry);
  end;
end;

//---------------------------------------------------------------------------

procedure TDX8Canvas.CreateStaticObjects();
begin
  ReallocMem(VertexArray, FVertexCache * SizeOf(TVertexRecord));
  FillChar(VertexArray^, FVertexCache * SizeOf(TVertexRecord), 0);

  ReallocMem(IndexArray, FIndexCache * SizeOf(Word));
  FillChar(IndexArray^, FIndexCache * SizeOf(Word), 0);

  PrepareVertexArray();
end;

//---------------------------------------------------------------------------

procedure TDX8Canvas.DestroyStaticObjects();
begin
  if (IndexArray <> nil) then
  begin
    FreeMem(IndexArray);
    IndexArray := nil;
  end;

  if (VertexArray <> nil) then
  begin
    FreeMem(VertexArray);
    VertexArray := nil;
  end;
end;

//--------------------------------------------------------------------------

function TDX8Canvas.CreateDynamicBuffers(): Boolean;
begin
 // -> Dynamic Vertex Buffer
 Result := Device8 <> nil;
 if not Result then Exit; 
  Result := Succeeded(Device8.CreateVertexBuffer(FVertexCache *
    SizeOf(TVertexRecord), D3DUSAGE_WRITEONLY or D3DUSAGE_DYNAMIC,
    VertexFVFType, D3DPOOL_DEFAULT, VertexBuffer));
  if (not Result) then Exit;

 // -> Dynamic Index Buffer
  Result := Succeeded(Device8.CreateIndexBuffer(FIndexCache *
    SizeOf(Word), D3DUSAGE_WRITEONLY or D3DUSAGE_DYNAMIC, D3DFMT_INDEX16,
    D3DPOOL_DEFAULT, IndexBuffer));
end;

//---------------------------------------------------------------------------

procedure TDX8Canvas.DestroyDynamicBuffers();
begin
  if (IndexBuffer <> nil) then IndexBuffer := nil;
  if (VertexBuffer <> nil) then VertexBuffer := nil;
end;

//---------------------------------------------------------------------------

procedure TDX8Canvas.ResetDeviceStates();
begin
  FVertexCount := 0;
  FIndexCount := 0;
  FPrimitives := 0;
  DrawingMode := dmUnknown;
  CachedEffect := deUnknown;
  CachedTex := nil;
  ActiveTex := nil;

  with Device8 do
  begin
   // Disable 3D fancy stuff.
    SetRenderState(D3DRS_LIGHTING, iFalse);
    SetRenderState(D3DRS_CULLMODE, D3DCULL_NONE);
    SetRenderState(D3DRS_ZENABLE, D3DZB_FALSE);
    SetRenderState(D3DRS_FOGENABLE, iFalse);

{$IFDEF NoAntialiasedLines}
//   SetRenderState(D3DRS_ANTIALIASEDLINEENABLE, iFalse);
{$ELSE}
//   SetRenderState(D3DRS_ANTIALIASEDLINEENABLE, iTrue);
{$ENDIF}

   // Enable Alpha-testing.
    SetRenderState(D3DRS_ALPHATESTENABLE, iTrue);
    SetRenderState(D3DRS_ALPHAFUNC, D3DCMP_GREATEREQUAL);
    SetRenderState(D3DRS_ALPHAREF, $00000001);

   // Default alpha-blending behavior
    SetRenderState(D3DRS_ALPHABLENDENABLE, iTrue);

    SetTextureStageState(0, D3DTSS_COLOROP, D3DTOP_MODULATE);
    SetTextureStageState(0, D3DTSS_ALPHAOP, D3DTOP_MODULATE);

    SetTextureStageState(0, D3DTSS_MINFILTER, D3DTEXF_LINEAR); //shj
    SetTextureStageState(0, D3DTSS_MAGFILTER, D3DTEXF_LINEAR);
    SetTextureStageState(0, D3DTSS_MIPFILTER, D3DTEXF_NONE);

//   SetSamplerState(0, D3DSAMP_MAGFILTER, D3DTEXF_LINEAR);
//   SetSamplerState(0, D3DSAMP_MINFILTER, D3DTEXF_LINEAR);
//   SetSamplerState(0, D3DSAMP_MIPFILTER, D3DTEXF_NONE);

    SetRenderState(D3DRS_FILLMODE, D3DFILL_SOLID);
  end;
end;

//--------------------------------------------------------------------------

function TDX8Canvas.HandleDeviceCreate(): Boolean;
begin
  InitCacheSpec();
  CreateStaticObjects();

  Result := True;
end;

//--------------------------------------------------------------------------

procedure TDX8Canvas.HandleDeviceDestroy();
begin
  DestroyStaticObjects();
end;

//--------------------------------------------------------------------------

function TDX8Canvas.HandleDeviceReset(): Boolean;
begin
  Result := CreateDynamicBuffers();
end;

//--------------------------------------------------------------------------

procedure TDX8Canvas.HandleDeviceLost();
begin
  DestroyDynamicBuffers();
end;

//--------------------------------------------------------------------------

procedure TDX8Canvas.HandleBeginScene();
begin
  ResetDeviceStates();
end;

//--------------------------------------------------------------------------

procedure TDX8Canvas.HandleEndScene();
begin
  Flush();
end;

//---------------------------------------------------------------------------

procedure TDX8Canvas.GetViewport(out x, y, Width, Height: Integer);
var
  vp: TD3DViewport8;
begin
  if (Device8 = nil) then
  begin
    x := 0; y := 0; Width := 0; Height := 0;
    Exit;
  end;

  FillChar(vp, SizeOf(vp), 0);
  Device8.GetViewport(vp);

  x := vp.X;
  y := vp.Y;

  Width := vp.Width;
  Height := vp.Height;
end;

//---------------------------------------------------------------------------

procedure TDX8Canvas.SetViewport(x, y, Width, Height: Integer);
var
  vp: TD3DViewport8;
begin
  if (Device8 = nil) then Exit;

  Flush();

  vp.X := x;
  vp.Y := y;
  vp.Width := Width;
  vp.Height := Height;
  vp.MinZ := 0.0;
  vp.MaxZ := 1.0;

  Device8.SetViewport(vp);
end;

//---------------------------------------------------------------------------

function TDX8Canvas.GetAntialias(): Boolean;
var
  MagFlt, MinFlt: Cardinal;
begin
  if (Device8 = nil) then
  begin
    Result := False;
    Exit;
  end;

  Device8.GetTextureStageState(0, D3DTSS_MAGFILTER, MagFlt); //shj
  Device8.GetTextureStageState(0, D3DTSS_MINFILTER, MinFlt);
// Device8.GetSamplerState(0, D3DSAMP_MAGFILTER, MagFlt);
// Device8.GetSamplerState(0, D3DSAMP_MINFILTER, MinFlt);

  Result := True;

  if (MagFlt = D3DTEXF_POINT) or (MinFlt = D3DTEXF_POINT) then Result := False;
end;

//---------------------------------------------------------------------------

procedure TDX8Canvas.SetAntialias(const Value: Boolean);
begin
  if (Device8 = nil) then Exit;

  Flush();

  case Value of
    False:
      begin
        Device8.SetTextureStageState(0, D3DTSS_MAGFILTER, D3DTEXF_POINT); //shj
        Device8.SetTextureStageState(0, D3DTSS_MINFILTER, D3DTEXF_POINT);
//    Device8.SetSamplerState(0, D3DSAMP_MAGFILTER, D3DTEXF_POINT);
//    Device8.SetSamplerState(0, D3DSAMP_MINFILTER, D3DTEXF_POINT);
      end;

    True:
      begin
        Device8.SetTextureStageState(0, D3DTSS_MAGFILTER, D3DTEXF_LINEAR); //shj
        Device8.SetTextureStageState(0, D3DTSS_MINFILTER, D3DTEXF_LINEAR);
//    Device8.SetSamplerState(0, D3DSAMP_MAGFILTER, D3DTEXF_LINEAR);
//    Device8.SetSamplerState(0, D3DSAMP_MINFILTER, D3DTEXF_LINEAR);
      end;
  end;
end;

//---------------------------------------------------------------------------

function TDX8Canvas.GetMipMapping(): Boolean;
var
  MipFlt: Cardinal;
begin
  if (Device8 = nil) then
  begin
    Result := False;
    Exit;
  end;

  Device8.GetTextureStageState(0, D3DTSS_MIPFILTER, MipFlt); //shj
// Device8.GetSamplerState(0, D3DSAMP_MIPFILTER, MipFlt);

  Result := True;

  if (MipFlt = D3DTEXF_NONE) or (MipFlt = D3DTEXF_POINT) then Result := False;
end;

//---------------------------------------------------------------------------

procedure TDX8Canvas.SetMipMapping(const Value: Boolean);
begin
  if (Device8 = nil) then Exit;

  Flush();

  case Value of
    False:
      Device8.SetTextureStageState(0, D3DTSS_MIPFILTER, D3DTEXF_NONE); //shj
//   Device8.SetSamplerState(0, D3DSAMP_MIPFILTER, D3DTEXF_NONE);

    True:
      Device8.SetTextureStageState(0, D3DTSS_MIPFILTER, D3DTEXF_LINEAR); //shj
//   Device8.SetSamplerState(0, D3DSAMP_MIPFILTER, D3DTEXF_LINEAR);
  end;
end;

//---------------------------------------------------------------------------

function TDX8Canvas.UploadVertexBuffer(): Boolean;
var
  MemAddr: Pointer;
  BufSize: Integer;
begin
  BufSize := FVertexCount * SizeOf(TVertexRecord);
  Result := Succeeded(VertexBuffer.Lock(0, BufSize, pbyte(MemAddr), D3DLOCK_DISCARD));

  if (Result) then
  begin
    Move(VertexArray^, MemAddr^, BufSize);
    Result := Succeeded(VertexBuffer.Unlock());
  end;
end;

//---------------------------------------------------------------------------

function TDX8Canvas.UploadIndexBuffer(): Boolean;
var
  MemAddr: Pointer;
  BufSize: Integer;
begin
  BufSize := FIndexCount * SizeOf(Word);
  Result := Succeeded(IndexBuffer.Lock(0, BufSize, pbyte(MemAddr), D3DLOCK_DISCARD)); //shj

  if (Result) then
  begin
    Move(IndexArray^, MemAddr^, BufSize);
    Result := Succeeded(IndexBuffer.Unlock());
  end;
end;

//---------------------------------------------------------------------------

procedure TDX8Canvas.DrawBuffers();
begin
  with Device8 do
  begin
    SetStreamSource(0, VertexBuffer, SizeOf(TVertexRecord));
    SetIndices(IndexBuffer, 0);
    SetVertexShader(0);
    SetVertexShader(VertexFVFType); //shj modify

    case DrawingMode of
      dmPoints:
        DrawPrimitive(D3DPT_POINTLIST, 0, FPrimitives);

      dmLines:
        DrawPrimitive(D3DPT_LINELIST, 0, FPrimitives);

      dmTriangles:
        DrawIndexedPrimitive(D3DPT_TRIANGLELIST, 0, FVertexCount, 0,
          FPrimitives);
    end;
  end;

  NextDrawCall();
end;

//---------------------------------------------------------------------------

procedure TDX8Canvas.Flush();
begin
  if (FVertexCount > 0) and (FPrimitives > 0) and (UploadVertexBuffer()) and
    (UploadIndexBuffer()) then DrawBuffers();

  FVertexCount := 0;
  FIndexCount := 0;
  FPrimitives := 0;
  DrawingMode := dmUnknown;
  CachedEffect := deUnknown;

  Device8.SetTexture(0, nil);

  CachedTex := nil;
  ActiveTex := nil;
end;

//---------------------------------------------------------------------------

procedure TDX8Canvas.SetEffectStates(Effect: TDrawingEffect);
begin
  case Effect of
    deBlend:
      with Device8 do
      begin
        SetRenderState(D3DRS_SRCBLEND, D3DBLEND_SRCALPHA);
        SetRenderState(D3DRS_DESTBLEND, D3DBLEND_INVSRCCOLOR);
        SetTextureStageState(0, D3DTSS_COLOROP, D3DTOP_MODULATE);
        SetTextureStageState(0, D3DTSS_ALPHAOP, D3DTOP_MODULATE);
      end;
    deNormal:
      with Device8 do
      begin
        SetRenderState(D3DRS_SRCBLEND, D3DBLEND_SRCALPHA);
        SetRenderState(D3DRS_DESTBLEND, D3DBLEND_INVSRCALPHA);
        SetTextureStageState(0, D3DTSS_COLOROP, D3DTOP_MODULATE);
        SetTextureStageState(0, D3DTSS_ALPHAOP, D3DTOP_MODULATE);
      end;

    deShadow:
      with Device8 do
      begin
        SetRenderState(D3DRS_SRCBLEND, D3DBLEND_ZERO);
        SetRenderState(D3DRS_DESTBLEND, D3DBLEND_INVSRCALPHA);
        SetTextureStageState(0, D3DTSS_COLOROP, D3DTOP_MODULATE);
        SetTextureStageState(0, D3DTSS_ALPHAOP, D3DTOP_MODULATE);
      end;

    deAdd:
      with Device8 do
      begin
        SetRenderState(D3DRS_SRCBLEND, D3DBLEND_SRCALPHA);
        SetRenderState(D3DRS_DESTBLEND, D3DBLEND_ONE);
        SetTextureStageState(0, D3DTSS_COLOROP, D3DTOP_MODULATE);
        SetTextureStageState(0, D3DTSS_ALPHAOP, D3DTOP_MODULATE);
      end;

    deMultiply:
      with Device8 do
      begin
        SetRenderState(D3DRS_SRCBLEND, D3DBLEND_ZERO);
        SetRenderState(D3DRS_DESTBLEND, D3DBLEND_SRCCOLOR);
        SetTextureStageState(0, D3DTSS_COLOROP, D3DTOP_MODULATE);
        SetTextureStageState(0, D3DTSS_ALPHAOP, D3DTOP_MODULATE);
      end;

    deSrcAlphaAdd:
      with Device8 do
      begin
        SetRenderState(D3DRS_SRCBLEND, D3DBLEND_SRCALPHA);
        SetRenderState(D3DRS_DESTBLEND, D3DBLEND_ONE);
        SetTextureStageState(0, D3DTSS_COLOROP, D3DTOP_MODULATE);
        SetTextureStageState(0, D3DTSS_ALPHAOP, D3DTOP_MODULATE);
      end;

    deSrcColor:
      with Device8 do
      begin
        SetRenderState(D3DRS_SRCBLEND, D3DBLEND_SRCCOLOR);
        SetRenderState(D3DRS_DESTBLEND, D3DBLEND_INVSRCCOLOR);
        SetTextureStageState(0, D3DTSS_COLOROP, D3DTOP_MODULATE);
        SetTextureStageState(0, D3DTSS_ALPHAOP, D3DTOP_MODULATE);
      end;

    deSrcColorAdd:
      with Device8 do
      begin
        SetRenderState(D3DRS_SRCBLEND, D3DBLEND_SRCCOLOR);
        SetRenderState(D3DRS_DESTBLEND, D3DBLEND_ONE);
        SetTextureStageState(0, D3DTSS_COLOROP, D3DTOP_MODULATE);
        SetTextureStageState(0, D3DTSS_ALPHAOP, D3DTOP_MODULATE);
      end;

    deInvert:
      with Device8 do
      begin
        SetRenderState(D3DRS_SRCBLEND, D3DBLEND_INVDESTCOLOR);
        SetRenderState(D3DRS_DESTBLEND, D3DBLEND_ZERO);
        SetTextureStageState(0, D3DTSS_COLOROP, D3DTOP_MODULATE);
        SetTextureStageState(0, D3DTSS_ALPHAOP, D3DTOP_MODULATE);
      end;

    deSrcBright:
      with Device8 do
      begin
        SetRenderState(D3DRS_SRCBLEND, D3DBLEND_SRCCOLOR);
        SetRenderState(D3DRS_DESTBLEND, D3DBLEND_SRCCOLOR);
        SetTextureStageState(0, D3DTSS_COLOROP, D3DTOP_MODULATE);
        SetTextureStageState(0, D3DTSS_ALPHAOP, D3DTOP_MODULATE);
      end;

    deInvMultiply:
      with Device8 do
      begin
        SetRenderState(D3DRS_SRCBLEND, D3DBLEND_ZERO);
        SetRenderState(D3DRS_DESTBLEND, D3DBLEND_INVSRCCOLOR);
        SetTextureStageState(0, D3DTSS_COLOROP, D3DTOP_MODULATE);
        SetTextureStageState(0, D3DTSS_ALPHAOP, D3DTOP_MODULATE);
      end;

    deMultiplyAlpha:
      with Device8 do
      begin
        SetRenderState(D3DRS_SRCBLEND, D3DBLEND_ZERO);
        SetRenderState(D3DRS_DESTBLEND, D3DBLEND_SRCALPHA);
        SetTextureStageState(0, D3DTSS_COLOROP, D3DTOP_MODULATE);
        SetTextureStageState(0, D3DTSS_ALPHAOP, D3DTOP_MODULATE);
      end;

    deInvMultiplyAlpha:
      with Device8 do
      begin
        SetRenderState(D3DRS_SRCBLEND, D3DBLEND_ZERO);
        SetRenderState(D3DRS_DESTBLEND, D3DBLEND_INVSRCALPHA);
        SetTextureStageState(0, D3DTSS_COLOROP, D3DTOP_MODULATE);
        SetTextureStageState(0, D3DTSS_ALPHAOP, D3DTOP_MODULATE);
      end;

    deDestBright:
      with Device8 do
      begin
        SetRenderState(D3DRS_SRCBLEND, D3DBLEND_DESTCOLOR);
        SetRenderState(D3DRS_DESTBLEND, D3DBLEND_DESTCOLOR);
        SetTextureStageState(0, D3DTSS_COLOROP, D3DTOP_MODULATE);
        SetTextureStageState(0, D3DTSS_ALPHAOP, D3DTOP_MODULATE);
      end;

    deInvSrcBright:
      with Device8 do
      begin
        SetRenderState(D3DRS_SRCBLEND, D3DBLEND_INVSRCCOLOR);
        SetRenderState(D3DRS_DESTBLEND, D3DBLEND_INVSRCCOLOR);
        SetTextureStageState(0, D3DTSS_COLOROP, D3DTOP_MODULATE);
        SetTextureStageState(0, D3DTSS_ALPHAOP, D3DTOP_MODULATE);
      end;

    deInvDestBright:
      with Device8 do
      begin
        SetRenderState(D3DRS_SRCBLEND, D3DBLEND_INVDESTCOLOR);
        SetRenderState(D3DRS_DESTBLEND, D3DBLEND_INVDESTCOLOR);
        SetTextureStageState(0, D3DTSS_COLOROP, D3DTOP_MODULATE);
        SetTextureStageState(0, D3DTSS_ALPHAOP, D3DTOP_MODULATE);
      end;

    deBright:
      with Device8 do
      begin
        SetRenderState(D3DRS_SRCBLEND, D3DBLEND_SRCALPHA);
        SetRenderState(D3DRS_DESTBLEND, D3DBLEND_INVSRCALPHA);
        SetTextureStageState(0, D3DTSS_COLOROP, D3DTOP_MODULATE2X);
        SetTextureStageState(0, D3DTSS_ALPHAOP, D3DTOP_MODULATE);
      end;

    deBrightAdd:
      with Device8 do
      begin
        SetRenderState(D3DRS_SRCBLEND, D3DBLEND_SRCALPHA);
        SetRenderState(D3DRS_DESTBLEND, D3DBLEND_INVSRCALPHA);
        SetTextureStageState(0, D3DTSS_COLOROP, D3DTOP_MODULATE4X);
        SetTextureStageState(0, D3DTSS_ALPHAOP, D3DTOP_MODULATE);
      end;

    deGrayscale:
      with Device8 do
      begin
        SetRenderState(D3DRS_TextureFactor, D3DCOLOR_ARGB(129, 255, 48, 255));
        SetTextureStageState(0, D3DTSS_COLOROP, D3DTOP_DOTPRODUCT3);
        SetTextureStageState(0, D3DTSS_COLORARG2, D3DTA_TFACTOR);
     // Note: D3DTSS_COLORARG2 is changed after using this effect and will
     // need to be reset before rendering anything else.
      end;

    deLight:
      with Device8 do
      begin
        SetRenderState(D3DRS_SRCBLEND, Cardinal(D3DBLEND_DESTCOLOR));
        SetRenderState(D3DRS_DESTBLEND, Cardinal(D3DBLEND_ONE));
        SetTextureStageState(0, D3DTSS_COLOROP, D3DTOP_MODULATE2X);
        SetTextureStageState(0, D3DTSS_ALPHAOP, D3DTOP_MODULATE);
      end;

    deLightAdd:
      with Device8 do
      begin
        SetRenderState(D3DRS_SRCBLEND, D3DBLEND_DESTCOLOR);
        SetRenderState(D3DRS_DESTBLEND, D3DBLEND_ONE);
        SetTextureStageState(0, D3DTSS_COLOROP, D3DTOP_MODULATE4X);
        SetTextureStageState(0, D3DTSS_ALPHAOP, D3DTOP_MODULATE);
      end;

    deAdd2X:
      with Device8 do
      begin
        SetRenderState(D3DRS_SRCBLEND, D3DBLEND_SRCALPHA);
        SetRenderState(D3DRS_DESTBLEND, D3DBLEND_ONE);
        SetTextureStageState(0, D3DTSS_COLOROP, D3DTOP_MODULATE2X);
        SetTextureStageState(0, D3DTSS_ALPHAOP, D3DTOP_MODULATE);
      end;

    deOneColor:
      with Device8 do
      begin
        SetRenderState(D3DRS_SRCBLEND, D3DBLEND_SRCALPHA);
        SetRenderState(D3DRS_DESTBLEND, D3DBLEND_INVSRCALPHA);
        SetTextureStageState(0, D3DTSS_COLOROP, 25);
        SetTextureStageState(0, D3DTSS_ALPHAOP, D3DTOP_MODULATE);
     // Note: '25' is used by DraculaLin here, which is most likely incorrect
     // usage of D3DTSS_COLOROP.
      end;

    deXOR:
      with Device8 do
      begin
        SetRenderState(D3DRS_SRCBLEND, D3DBLEND_INVDESTCOLOR);
        SetRenderState(D3DRS_DESTBLEND, D3DBLEND_INVSRCCOLOR);
      end;
  end;
end;

//---------------------------------------------------------------------------

function TDX8Canvas.RequestCache(Mode: TDrawingMode; Vertices,
  Indices: Integer; Effect: TDrawingEffect; Texture: TAsphyreCustomTexture): Boolean;
var
  NeedReset: Boolean;
begin
  Result := (Vertices <= MaxCachedVertices) and (Indices <= MaxCachedIndices);
  if (not Result) then
  begin
    AsphyreError := errGeometryTooComplex;
    Exit;
  end;

  NeedReset := (FVertexCount + Vertices > FVertexCache);
  NeedReset := (NeedReset) or (FIndexCount + Indices > FIndexCache);
  NeedReset := (NeedReset) or (DrawingMode = dmUnknown) or (DrawingMode <> Mode);
  NeedReset := (NeedReset) or (CachedEffect = deUnknown) or (CachedEffect <> Effect);
  NeedReset := (NeedReset) or (CachedTex <> Texture);

  if (NeedReset) then
  begin
    Flush();

    if (CachedEffect = deUnknown) or (CachedEffect <> Effect) then
      SetEffectStates(Effect);

    if (CachedEffect = deUnknown) or (CachedTex <> Texture) then
    begin
      if (Texture <> nil) then Texture.Bind(0)
      else Device8.SetTexture(0, nil);
    end;

    DrawingMode := Mode;
    CachedEffect := Effect;
    CachedTex := Texture;
  end;
end;

//---------------------------------------------------------------------------

function TDX8Canvas.NextVertexEntry(): Pointer;
begin
  Result := Pointer(Integer(VertexArray) +
    (FVertexCount * SizeOf(TVertexRecord)));
  //PVertexRecord(Result).Vertex.z := 1.0;
end;

//---------------------------------------------------------------------------

procedure TDX8Canvas.AddIndexEntry(Index: Integer);
var
  Entry: PWord;
begin
  Entry := Pointer(Integer(IndexArray) + (FIndexCount * SizeOf(Word)));
  Entry^ := Index;

  Inc(FIndexCount);
end;

//---------------------------------------------------------------------------

procedure TDX8Canvas.PutPixel(const Point: TPoint2; Color: Cardinal);
var
  Entry: PVertexRecord;
begin
  if (not RequestCache(dmPoints, 1, 0, deNormal, nil)) then Exit;

  Entry := NextVertexEntry();
  Entry.Vertex.x := Point.x;
  Entry.Vertex.y := Point.y;
  Entry.Color := Color;

  Inc(FVertexCount);
  Inc(FPrimitives);
end;

//---------------------------------------------------------------------------

procedure TDX8Canvas.Line(const Src, Dest: TPoint2; Color0, Color1: Cardinal);
var
  Entry: PVertexRecord;
begin
  if (not RequestCache(dmLines, 2, 0, deNormal, nil)) then Exit;

  Entry := NextVertexEntry();
  Entry.Vertex.x := Src.x;
  Entry.Vertex.y := Src.y;
  Entry.Color := Color0;
  Inc(FVertexCount);

  Entry := NextVertexEntry();
  Entry.Vertex.x := Dest.x;
  Entry.Vertex.y := Dest.y;
  Entry.Color := Color1;
  Inc(FVertexCount);

  Inc(FPrimitives);
end;

//---------------------------------------------------------------------------

procedure TDX8Canvas.DrawIndexedTriangles(Vertices: PPoint2;
  Colors: PCardinal; Indices: PInteger; NoVertices, NoTriangles: Integer;
  Effect: TDrawingEffect = deNormal);
var
  Entry: PVertexRecord;
  Index: PInteger;
  Vertex: PPoint2;
  Color: PCardinal;
  i: Integer;
begin
  if (not RequestCache(dmTriangles, NoVertices, NoTriangles * 3, Effect,
    nil)) then Exit;

  Index := Indices;

  for i := 0 to (NoTriangles * 3) - 1 do
  begin
    AddIndexEntry(FVertexCount + Index^);

    Inc(Index);
  end;

  Vertex := Vertices;
  Color := Colors;

  for i := 0 to NoVertices - 1 do
  begin
    Entry := NextVertexEntry();
    Entry.Vertex.x := Vertex.x - 0.5;
    Entry.Vertex.y := Vertex.y - 0.5;
    Entry.Color := Color^;
    Inc(FVertexCount);

    Inc(Vertex);
    Inc(Color);
  end;

  Inc(FPrimitives, NoTriangles);
end;

//---------------------------------------------------------------------------

procedure TDX8Canvas.UseTexture(Texture: TAsphyreCustomTexture;
  const Mapping: TPoint4);
begin
  ActiveTex := Texture;
  QuadMapping := Mapping;
end;

//---------------------------------------------------------------------------

procedure TDX8Canvas.TexMap(const Points: TPoint4; const Colors: TColor4;
  Effect: TDrawingEffect);
var
  Entry: PVertexRecord;
begin
  RequestCache(dmTriangles, 4, 6, Effect, ActiveTex);

  AddIndexEntry(FVertexCount + 2);
  AddIndexEntry(FVertexCount);
  AddIndexEntry(FVertexCount + 1);

  AddIndexEntry(FVertexCount + 3);
  AddIndexEntry(FVertexCount + 2);
  AddIndexEntry(FVertexCount + 1);

  Entry := NextVertexEntry();
  Entry.Vertex.x := Points[0].x + 0.5;
  Entry.Vertex.y := Points[0].y + 0.5;
  Entry.Color := Colors[0];
  Entry.u := QuadMapping[0].x;
  Entry.v := QuadMapping[0].y;
  Inc(FVertexCount);

  Entry := NextVertexEntry();
  Entry.Vertex.x := Points[1].x + 0.5;
  Entry.Vertex.y := Points[1].y + 0.5;
  Entry.Color := Colors[1];
  Entry.u := QuadMapping[1].x;
  Entry.v := QuadMapping[1].y;
  Inc(FVertexCount);

  Entry := NextVertexEntry();
  Entry.Vertex.x := Points[3].x + 0.5;
  Entry.Vertex.y := Points[3].y + 0.5;
  Entry.Color := Colors[3];
  Entry.u := QuadMapping[3].x;
  Entry.v := QuadMapping[3].y;
  Inc(FVertexCount);

  Entry := NextVertexEntry();
  Entry.Vertex.x := Points[2].x + 0.5;
  Entry.Vertex.y := Points[2].y + 0.5;
  Entry.Color := Colors[2];
  Entry.u := QuadMapping[2].x;
  Entry.v := QuadMapping[2].y;
  Inc(FVertexCount);

  Inc(FPrimitives, 2);
end;

//---------------------------------------------------------------------------
end.

