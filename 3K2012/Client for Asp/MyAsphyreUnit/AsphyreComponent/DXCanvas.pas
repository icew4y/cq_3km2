unit DXCanvas;

//---------------------------------------------------------------------------
interface

//---------------------------------------------------------------------------
uses
  Windows, DirectX, AbstractCanvas, Vectors2, Matrices3, Types,
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
  TDXCanvas = class(TAsphyreCanvas)
  private
    DrawingMode: TDrawingMode;
    FVertexCache: Integer;
    FIndexCache: Integer;
    FVertexCount: Integer;
    FIndexCount: Integer;

    FPrimitives: Integer;
    FMaxPrimitives: Integer;
    TexRect : TRect;
    ActiveTex: TAsphyreCustomTexture;
    CachedTex: TAsphyreCustomTexture;
    CachedEffect: TDrawingEffect;
    QuadMapping: TPoint4;
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
    procedure Draw(X, Y: Integer; SrcRect: TRect; Texture: TAsphyreCustomTexture; Transparent: Boolean = True); overload; override;
    procedure Draw(X, Y: Integer; Texture: TAsphyreCustomTexture; Transparent: Boolean = True); overload; override;
    procedure Draw(X, Y: Integer; SrcRect: TRect; Texture: TAsphyreCustomTexture; Effect: TDrawingEffect = deNormal); overload; override;

    constructor Create(); override;
    destructor Destroy(); override;
  end;

//---------------------------------------------------------------------------
implementation

//--------------------------------------------------------------------------
uses
  AsphyreErrors, DXTextures;

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

constructor TDXCanvas.Create();
begin
  inherited;
end;

//---------------------------------------------------------------------------

destructor TDXCanvas.Destroy();
begin
  inherited;
end;

//--------------------------------------------------------------------------

function TDXCanvas.HandleDeviceCreate(): Boolean;
begin

  Result := True;
end;

//--------------------------------------------------------------------------

procedure TDXCanvas.HandleDeviceDestroy();
begin

end;

//--------------------------------------------------------------------------

function TDXCanvas.HandleDeviceReset(): Boolean;
begin

end;

//--------------------------------------------------------------------------

procedure TDXCanvas.HandleDeviceLost();
begin

end;

//--------------------------------------------------------------------------

procedure TDXCanvas.HandleBeginScene();
begin

end;

//--------------------------------------------------------------------------

procedure TDXCanvas.HandleEndScene();
begin

end;

//---------------------------------------------------------------------------

procedure TDXCanvas.GetViewport(out x, y, Width, Height: Integer);
begin

end;

//---------------------------------------------------------------------------

procedure TDXCanvas.SetViewport(x, y, Width, Height: Integer);

begin

end;

//---------------------------------------------------------------------------

function TDXCanvas.GetAntialias(): Boolean;
begin

end;

//---------------------------------------------------------------------------

procedure TDXCanvas.SetAntialias(const Value: Boolean);
begin

end;

//---------------------------------------------------------------------------

function TDXCanvas.GetMipMapping(): Boolean;
begin

end;

//---------------------------------------------------------------------------

procedure TDXCanvas.SetMipMapping(const Value: Boolean);
begin

end;

//---------------------------------------------------------------------------

procedure TDXCanvas.Flush();
begin

end;

//---------------------------------------------------------------------------

procedure TDXCanvas.PutPixel(const Point: TPoint2; Color: Cardinal);
begin

end;

//---------------------------------------------------------------------------

procedure TDXCanvas.Line(const Src, Dest: TPoint2; Color0, Color1: Cardinal);
begin

end;

//---------------------------------------------------------------------------

procedure TDXCanvas.DrawIndexedTriangles(Vertices: PPoint2;
  Colors: PCardinal; Indices: PInteger; NoVertices, NoTriangles: Integer;
  Effect: TDrawingEffect = deNormal);
begin

end;

//---------------------------------------------------------------------------

function TPoint4ToRect(Points: TPoint4) : TRect;
begin
  Result := Rect(Round(Points[0].x), Round(Points[0].y), Round(Points[2].x - Points[0].x), Round(Points[2].y-Points[0].y));
end;

function TPoint4ToRect2(Points: TPoint4; w,h : DWord) : TRect;
begin
  Result := Rect(Round(Points[0].x * w), Round(Points[0].y * h),
  Round(Points[2].x * w), Round(Points[2].y * h));
end;


procedure TDXCanvas.UseTexture(Texture: TAsphyreCustomTexture; const Mapping: TPoint4);
begin
  ActiveTex := Texture;
  TexRect := TPoint4ToRect2(Mapping, ActiveTex.MemoryWidth, ActiveTex.MemoryHeight);
end;

//---------------------------------------------------------------------------

procedure TDXCanvas.TexMap(const Points: TPoint4; const Colors: TColor4; Effect: TDrawingEffect);
const
  BltFlags: array[Boolean] of Integer =
  (DDBLT_WAIT, DDBLT_KEYSRC or DDBLT_WAIT);
var
  DF: TDDBltFX;
begin
  if (ActiveTex <> nil) and (BufferSurface <> nil) then begin
    FillChar(DF, SizeOf(DF), 0);
    DF.dwSize := SizeOf(DF);
    BufferSurface.Blt(TPoint4ToRect(Points), TDXLockableTexture(ActiveTex).Texture, TexRect, BltFlags[deNormal = Effect], DF);
  end;
end;


procedure TDXCanvas.Draw(X, Y: Integer; SrcRect: TRect; Texture: TAsphyreCustomTexture; Transparent: Boolean = True);
const
  BltFlags: array[Boolean] of Integer =
  (DDBLT_WAIT, DDBLT_KEYSRC or DDBLT_WAIT);
var
  DF: TDDBltFX;
  DxResult : HResult;
begin
  if (Texture <> nil) and (BufferSurface <> nil) then begin
    FillChar(DF, SizeOf(DF), 0);
    DF.dwSize := SizeOf(DF);
    DxResult := BufferSurface.Blt(Bounds(X, Y, Texture.Width, Texture.Height), TDXLockableTexture(Texture).Texture, Texture.ClientRect, 0, DF);
    case DxResult of
  DDERR_ALREADYINITIALIZED                :DxResult := HResult($88760000 + 5);
  DDERR_CANNOTATTACHSURFACE               :DxResult :=  HResult($88760000 + 10);
  DDERR_CANNOTDETACHSURFACE               :DxResult :=  HResult($88760000 + 20);
  DDERR_CURRENTLYNOTAVAIL                 :DxResult :=  HResult($88760000 + 40);
  DDERR_EXCEPTION                         :DxResult :=  HResult($88760000 + 55);
  DDERR_GENERIC                           :DxResult :=  HResult(E_FAIL);
  DDERR_HEIGHTALIGN                       :DxResult :=  HResult($88760000 + 90);
  DDERR_INCOMPATIBLEPRIMARY               :DxResult :=  HResult($88760000 + 95);
  DDERR_INVALIDCAPS                       :DxResult :=  HResult($88760000 + 100);
  DDERR_INVALIDCLIPLIST                   :DxResult :=  HResult($88760000 + 110);
  DDERR_INVALIDMODE                       :DxResult :=  HResult($88760000 + 120);
  DDERR_INVALIDOBJECT                     :DxResult :=  HResult($88760000 + 130);
  DDERR_INVALIDPARAMS                     :DxResult :=  HResult(E_INVALIDARG);
  DDERR_INVALIDPIXELFORMAT                :DxResult :=  HResult($88760000 + 145);
  DDERR_INVALIDRECT                       :DxResult :=  HResult($88760000 + 150);
  DDERR_LOCKEDSURFACES                    :DxResult :=  HResult($88760000 + 160);
  DDERR_NO3D                              :DxResult :=  HResult($88760000 + 170);
  DDERR_NOALPHAHW                         :DxResult :=  HResult($88760000 + 180);
  DDERR_NOSTEREOHARDWARE                  :DxResult :=  HResult($88760000 + 181);
  DDERR_NOSURFACELEFT                     :DxResult :=  HResult($88760000 + 182);
  DDERR_NOCLIPLIST                        :DxResult :=  HResult($88760000 + 205);
  DDERR_NOCOLORCONVHW                     :DxResult :=  HResult($88760000 + 210);
  DDERR_NOCOOPERATIVELEVELSET             :DxResult :=  HResult($88760000 + 212);
  DDERR_NOCOLORKEY                        :DxResult :=  HResult($88760000 + 215);
  DDERR_NOCOLORKEYHW                      :DxResult :=  HResult($88760000 + 220);
  DDERR_NODIRECTDRAWSUPPORT               :DxResult :=  HResult($88760000 + 222);
  DDERR_NOEXCLUSIVEMODE                   :DxResult :=  HResult($88760000 + 225);
  DDERR_NOFLIPHW                          :DxResult :=  HResult($88760000 + 230);
  DDERR_NOGDI                             :DxResult :=  HResult($88760000 + 240);
  DDERR_NOMIRRORHW                        :DxResult :=  HResult($88760000 + 250);
  DDERR_NOTFOUND                          :DxResult :=  HResult($88760000 + 255);
  DDERR_NOOVERLAYHW                       :DxResult :=  HResult($88760000 + 260);
  DDERR_OVERLAPPINGRECTS                  :DxResult :=  HResult($88760000 + 270);
  DDERR_NORASTEROPHW                      :DxResult :=  HResult($88760000 + 280);
  DDERR_NOROTATIONHW                      :DxResult :=  HResult($88760000 + 290);
  DDERR_NOSTRETCHHW                       :DxResult :=  HResult($88760000 + 310);
  DDERR_NOT4BITCOLOR                      :DxResult :=  HResult($88760000 + 316);
  DDERR_NOT4BITCOLORINDEX                 :DxResult :=  HResult($88760000 + 317);
  DDERR_NOT8BITCOLOR                      :DxResult :=  HResult($88760000 + 320);
  DDERR_NOTEXTUREHW                       :DxResult :=  HResult($88760000 + 330);
  DDERR_NOVSYNCHW                         :DxResult :=  HResult($88760000 + 335);
  DDERR_NOZBUFFERHW                       :DxResult :=  HResult($88760000 + 340);
  DDERR_NOZOVERLAYHW                      :DxResult :=  HResult($88760000 + 350);
  DDERR_OUTOFCAPS                         :DxResult :=  HResult($88760000 + 360);
  DDERR_OUTOFMEMORY                       :DxResult :=  HResult(E_OUTOFMEMORY);
  DDERR_OUTOFVIDEOMEMORY                  :DxResult :=  HResult($88760000 + 380);
  DDERR_OVERLAYCANTCLIP                   :DxResult :=  HResult($88760000 + 382);
  DDERR_OVERLAYCOLORKEYONLYONEACTIVE      :DxResult :=  HResult($88760000 + 384);
  DDERR_PALETTEBUSY                       :DxResult :=  HResult($88760000 + 387);
  DDERR_COLORKEYNOTSET                    :DxResult :=  HResult($88760000 + 400);
  DDERR_SURFACEALREADYATTACHED            :DxResult :=  HResult($88760000 + 410);
  DDERR_SURFACEALREADYDEPENDENT           :DxResult :=  HResult($88760000 + 420);
  DDERR_SURFACEBUSY                       :DxResult :=  HResult($88760000 + 430);
  DDERR_CANTLOCKSURFACE                   :DxResult :=  HResult($88760000 + 435);
  DDERR_SURFACEISOBSCURED                 :DxResult :=  HResult($88760000 + 440);
  DDERR_SURFACELOST                       :DxResult :=  HResult($88760000 + 450);
  DDERR_SURFACENOTATTACHED                :DxResult :=  HResult($88760000 + 460);
  DDERR_TOOBIGHEIGHT                      :DxResult :=  HResult($88760000 + 470);
  DDERR_TOOBIGSIZE                        :DxResult :=  HResult($88760000 + 480);
  DDERR_TOOBIGWIDTH                       :DxResult :=  HResult($88760000 + 490);
  DDERR_UNSUPPORTED                       :DxResult :=  HResult(E_NOTIMPL);
  DDERR_UNSUPPORTEDFORMAT                 :DxResult :=  HResult($88760000 + 510);
  DDERR_UNSUPPORTEDMASK                   :DxResult :=  HResult($88760000 + 520);
  DDERR_INVALIDSTREAM                     :DxResult :=  HResult($88760000 + 521);
  DDERR_VERTICALBLANKINPROGRESS           :DxResult :=  HResult($88760000 + 537);
  DDERR_WASSTILLDRAWING                   :DxResult :=  HResult($88760000 + 540);
  DDERR_DDSCAPSCOMPLEXREQUIRED            :DxResult :=  HResult($88760000 + 542);
  DDERR_XALIGN                            :DxResult :=  HResult($88760000 + 560);
  DDERR_INVALIDDIRECTDRAWGUID             :DxResult :=  HResult($88760000 + 561);
  DDERR_DIRECTDRAWALREADYCREATED          :DxResult :=  HResult($88760000 + 562);
  DDERR_NODIRECTDRAWHW                    :DxResult :=  HResult($88760000 + 563);
  DDERR_PRIMARYSURFACEALREADYEXISTS       :DxResult :=  HResult($88760000 + 564);
  DDERR_NOEMULATION                       :DxResult :=  HResult($88760000 + 565);
  DDERR_REGIONTOOSMALL                    :DxResult :=  HResult($88760000 + 566);
  DDERR_CLIPPERISUSINGHWND                :DxResult :=  HResult($88760000 + 567);
  DDERR_NOCLIPPERATTACHED                 :DxResult :=  HResult($88760000 + 568);
  DDERR_NOHWND                            :DxResult :=  HResult($88760000 + 569);
  DDERR_HWNDSUBCLASSED                    :DxResult :=  HResult($88760000 + 570);
  DDERR_HWNDALREADYSET                    :DxResult :=  HResult($88760000 + 571);
  DDERR_NOPALETTEATTACHED                 :DxResult :=  HResult($88760000 + 572);
  DDERR_NOPALETTEHW                       :DxResult :=  HResult($88760000 + 573);
  DDERR_BLTFASTCANTCLIP                   :DxResult :=  HResult($88760000 + 574);
  DDERR_NOBLTHW                           :DxResult :=  HResult($88760000 + 575);
  DDERR_NODDROPSHW                        :DxResult :=  HResult($88760000 + 576);
  DDERR_OVERLAYNOTVISIBLE                 :DxResult :=  HResult($88760000 + 577);
  DDERR_NOOVERLAYDEST                     :DxResult :=  HResult($88760000 + 578);
  DDERR_INVALIDPOSITION                   :DxResult :=  HResult($88760000 + 579);
  DDERR_NOTAOVERLAYSURFACE                :DxResult :=  HResult($88760000 + 580);
  DDERR_EXCLUSIVEMODEALREADYSET           :DxResult :=  HResult($88760000 + 581);
  DDERR_NOTFLIPPABLE                      :DxResult :=  HResult($88760000 + 582);
  DDERR_CANTDUPLICATE                     :DxResult :=  HResult($88760000 + 583);
  DDERR_NOTLOCKED                         :DxResult :=  HResult($88760000 + 584);
  DDERR_CANTCREATEDC                      :DxResult :=  HResult($88760000 + 585);
  DDERR_NODC                              :DxResult :=  HResult($88760000 + 586);
  DDERR_WRONGMODE                         :DxResult :=  HResult($88760000 + 587);
  DDERR_IMPLICITLYCREATED                 :DxResult :=  HResult($88760000 + 588);
  DDERR_NOTPALETTIZED                     :DxResult :=  HResult($88760000 + 589);
  DDERR_UNSUPPORTEDMODE                   :DxResult :=  HResult($88760000 + 590);
  DDERR_NOMIPMAPHW                        :DxResult :=  HResult($88760000 + 591);
  DDERR_INVALIDSURFACETYPE                :DxResult :=  HResult($88760000 + 592);
  DDERR_NOOPTIMIZEHW                      :DxResult :=  HResult($88760000 + 600);
  DDERR_NOTLOADED                         :DxResult :=  HResult($88760000 + 601);
  DDERR_NOFOCUSWINDOW                     :DxResult :=  HResult($88760000 + 602);
  DDERR_NOTONMIPMAPSUBLEVEL               :DxResult :=  HResult($88760000 + 603);
  DDERR_DCALREADYCREATED                  :DxResult :=  HResult($88760000 + 620);
  DDERR_NONONLOCALVIDMEM                  :DxResult :=  HResult($88760000 + 630);
  DDERR_CANTPAGELOCK                      :DxResult :=  HResult($88760000 + 640);
  DDERR_CANTPAGEUNLOCK                    :DxResult :=  HResult($88760000 + 660);
  DDERR_NOTPAGELOCKED                     :DxResult :=  HResult($88760000 + 680);
  DDERR_MOREDATA                          :DxResult :=  HResult($88760000 + 690);
  DDERR_EXPIRED                           :DxResult :=  HResult($88760000 + 691);
  DDERR_TESTFINISHED                      :DxResult :=  HResult($88760000 + 692);
  DDERR_NEWMODE                           :DxResult :=  HResult($88760000 + 693);
  DDERR_D3DNOTINITIALIZED                 :DxResult :=  HResult($88760000 + 694);
  DDERR_VIDEONOTACTIVE                    :DxResult :=  HResult($88760000 + 695);
  DDERR_NOMONITORINFORMATION              :DxResult :=  HResult($88760000 + 696);
  DDERR_NODRIVERSUPPORT                   :DxResult :=  HResult($88760000 + 697);
  DDERR_DEVICEDOESNTOWNSURFACE            :DxResult :=  HResult($88760000 + 699);
  DDERR_NOTINITIALIZED                    :DxResult :=  HResult(CO_E_NOTINITIALIZED);

  end;
  end;
end;


procedure TDXCanvas.Draw(X, Y: Integer; Texture: TAsphyreCustomTexture; Transparent: Boolean = True);
const
  BltFlags: array[Boolean] of Integer =
  (DDBLT_WAIT, DDBLT_KEYSRC or DDBLT_WAIT);
var
  DF: TDDBltFX;
begin
  if (Texture <> nil) and (BufferSurface <> nil) then begin
    FillChar(DF, SizeOf(DF), 0);
    DF.dwSize := SizeOf(DF);
    BufferSurface.Blt(Bounds(X, Y, Texture.Width, Texture.Height), TDXLockableTexture(Texture).Texture, Texture.ClientRect, BltFlags[Transparent], DF);
  end;
end;

procedure TDXCanvas.Draw(X, Y: Integer; SrcRect: TRect; Texture: TAsphyreCustomTexture; Effect: TDrawingEffect = deNormal);
const
  BltFlags: array[Boolean] of Integer =
  (DDBLT_WAIT, DDBLT_KEYSRC or DDBLT_WAIT);
var
  DF: TDDBltFX;
begin
  if (Texture <> nil) and (BufferSurface <> nil) then begin
    FillChar(DF, SizeOf(DF), 0);
    DF.dwSize := SizeOf(DF);
    BufferSurface.Blt(Bounds(X, Y, SrcRect.Right - SrcRect.Left, SrcRect.Bottom - SrcRect.Top), TDXLockableTexture(Texture).Texture, SrcRect, BltFlags[deNormal = Effect], DF);
  end;
end;

//---------------------------------------------------------------------------
end.

