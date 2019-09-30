unit OGLCanvas;

//---------------------------------------------------------------------------
interface

//---------------------------------------------------------------------------
uses
 AbstractCanvas, Vectors2px, Vectors2, Matrices3, AsphyreColors, AsphyreTypes,
 AbstractTextures, AsphyreImages;

//---------------------------------------------------------------------------
type
 TCanvasCacheMode = (ccmNone, ccmPoints, ccmLines, ccmTris, ccmQuads);

//---------------------------------------------------------------------------
 TOGLCanvas = class(TAsphyreCanvas)
 private
  FCacheMode : TCanvasCacheMode;
  NormWidth  : Single;
  NormHeight : Single;
  LastEffect : TDrawingEffect;
  NoEffect   : Boolean;
  LastTex    : TAsphyreTexture;
  Activetex  : TAsphyreTexture;
  QuadMapping: TPoint4;

  procedure GetGLViewport(out Pos, Size: TPoint2px);
  procedure BeginPaint();
  procedure EndPaint();
  procedure ResetCache();
  procedure RequestCache(Mode: TCanvasCacheMode);
  procedure RequestEffect(Effect: TDrawingEffect);
  procedure RequestTexture(Texture: TAsphyreTexture);
  procedure AddVertex2(x, y: Single);
  procedure AddPoint2(const Point: TPoint2; Color: Longword);
 protected
  procedure HandleBeginScene(); override;
  procedure HandleEndScene(); override;

  procedure GetViewport(out x, y, Width, Height: Integer); override;
  procedure SetViewport(x, y, Width, Height: Integer); override;

  function GetAntialias(): Boolean; override;
  procedure SetAntialias(const Value: Boolean); override;
  function GetMipMapping(): Boolean; override;
  procedure SetMipMapping(const Value: Boolean); override;
 public
  property CacheMode: TCanvasCacheMode read FCacheMode;

  procedure PutPixel(const Point: TPoint2; Color: Cardinal); override;
  procedure Line(const Src, Dest: TPoint2; Color0, Color1: Cardinal); override;

  procedure FillTri(const p1, p2, p3: TPoint2; c1, c2, c3: Cardinal;
   Effect: TDrawingEffect = deNormal); override;

  procedure FillQuad(const Points: TPoint4; const Colors: TColor4;
   Effect: TDrawingEffect = deNormal); override;

  procedure WireQuad(const Points: TPoint4; const Colors: TColor4); override;

  procedure UseImage(Image: TAsphyreImage; const Mapping: TPoint4;
   TextureNo: Integer = 0); override;

  procedure TexMap(const Points: TPoint4; const Colors: TColor4;
   Effect: TDrawingEffect = deNormal); override;

  procedure FillHexagon(const Mtx: TMatrix3; c1, c2, c3, c4, c5, c6: Cardinal;
   Effect: TDrawingEffect = deNormal); override;

  procedure FillArc(const Pos, Radius: TPoint2; InitPhi, EndPhi: Single;
   Steps: Integer; const Colors: TColor4;
   Effect: TDrawingEffect = deNormal); override;

  procedure FillRibbon(const Pos, InRadius, OutRadius: TPoint2;
   InitPhi, EndPhi: Single; Steps: Integer; const Colors: TColor4;
   Effect: TDrawingEffect = deNormal); overload; override;
  procedure FillRibbon(const Pos, InRadius, OutRadius: TPoint2;
   InitPhi, EndPhi: Single; Steps: Integer; InColor1, InColor2, InColor3,
   OutColor1, OutColor2, OutColor3: Cardinal;
   Effect: TDrawingEffect = deNormal); overload; override;

  procedure Flush(); override;

{

  procedure FillQuad(const Points: TPoint4; const Colors: TColor4; Op: Integer); override;
  procedure TexMap(Image: TAsphyreImage; const Points: TPoint4;
   const Colors: TColor4; TexCoord: TTexCoord; Op: Integer); override;}
 end;

//---------------------------------------------------------------------------
implementation

//---------------------------------------------------------------------------
uses
 GL;

//---------------------------------------------------------------------------
procedure TOGLCanvas.GetGLViewport(out Pos, Size: TPoint2px);
var
 Viewport: array[0..3] of GLint;
begin
 glGetIntegerv(GL_VIEWPORT, @Viewport[0]);

 Pos.x := Viewport[0];
 Pos.y := Viewport[1];
 Size.x:= Viewport[2];
 Size.y:= Viewport[3];
end;

//---------------------------------------------------------------------------
procedure TOGLCanvas.BeginPaint();
var
 Pos, Size: TPoint2px;
begin
 GetGLViewport(Pos, Size);

 NormWidth := Size.x * 0.5;
 NormHeight:= Size.y * 0.5;

 glMatrixMode(GL_MODELVIEW);
 glLoadIdentity();

 glMatrixMode(GL_PROJECTION);
 glLoadIdentity();

 glDisable(GL_DEPTH_TEST);

 glDisable(GL_TEXTURE_1D);
 glDisable(GL_TEXTURE_2D);
 glEnable(GL_LINE_SMOOTH);

 FCacheMode:= ccmNone;
 NoEffect  := True;

 LastTex  := nil;
 ActiveTex:= nil;
end;

//---------------------------------------------------------------------------
procedure TOGLCanvas.EndPaint();
begin
 if (FCacheMode <> ccmNone) then ResetCache();
end;

//---------------------------------------------------------------------------
procedure TOGLCanvas.ResetCache();
begin
 if (FCacheMode <> ccmNone) then glEnd();
 FCacheMode:= ccmNone;
end;

//---------------------------------------------------------------------------
procedure TOGLCanvas.RequestCache(Mode: TCanvasCacheMode);
begin
 if (FCacheMode <> Mode) then
  begin
   ResetCache();

   case Mode of
    ccmPoints: glBegin(GL_POINTS);
    ccmLines : glBegin(GL_LINES);
    ccmTris  : glBegin(GL_TRIANGLES);
    ccmQuads : glBegin(GL_QUADS);
   end;

   FCacheMode:= Mode;
  end;
end;

//---------------------------------------------------------------------------
procedure TOGLCanvas.RequestEffect(Effect: TDrawingEffect);
begin
 if (not NoEffect)and(LastEffect = Effect) then Exit;

 ResetCache();

 glEnable(GL_BLEND);

 case Effect of
  deNormal:
   glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

  deShadow:
   glBlendFunc(GL_ZERO, GL_ONE_MINUS_SRC_ALPHA);

  deAdd:
   glBlendFunc(GL_SRC_ALPHA, GL_ONE);

  deMultiply:
   glBlendFunc(GL_ZERO, GL_SRC_COLOR);

  deSrcAlphaAdd:
   glBlendFunc(GL_SRC_ALPHA, GL_ONE);

  deSrcColor:
   glBlendFunc(GL_SRC_COLOR, GL_ONE_MINUS_SRC_COLOR);

  deSrcColorAdd:
   glBlendFunc(GL_SRC_COLOR, GL_ONE);

  deInvert:
   glBlendFunc(GL_ONE_MINUS_DST_COLOR, GL_ZERO);

  deSrcBright:
   glBlendFunc(GL_SRC_COLOR, GL_SRC_COLOR);

  deInvMultiply:
   glBlendFunc(GL_ZERO, GL_ONE_MINUS_SRC_COLOR);

  deMultiplyAlpha:
   glBlendFunc(GL_ZERO, GL_SRC_ALPHA);

  deInvMultiplyAlpha:
   glBlendFunc(GL_ZERO, GL_ONE_MINUS_SRC_ALPHA);

  deDestBright:
   glBlendFunc(GL_DST_COLOR, GL_DST_COLOR);

  deInvSrcBright:
   glBlendFunc(GL_ONE_MINUS_SRC_COLOR, GL_ONE_MINUS_SRC_COLOR);

  deInvDestBright:
   glBlendFunc(GL_ONE_MINUS_DST_COLOR, GL_ONE_MINUS_DST_COLOR);

  deXOR:
   glBlendFunc(GL_ONE_MINUS_SRC_COLOR, GL_ONE_MINUS_DST_COLOR);
 end;

 LastEffect:= Effect;
 NoEffect  := False;
end;

//---------------------------------------------------------------------------
procedure TOGLCanvas.RequestTexture(Texture: TAsphyreTexture);
begin
 if (LastTex = Texture) then Exit;

 ResetCache();

 if (Texture <> nil) then
  begin
   Texture.AssignToStage(0);

   glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
   glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
   glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);
   glEnable(GL_TEXTURE_2D);
  end else glDisable(GL_TEXTURE_2D);

 LastTex:= Texture;
end;

//---------------------------------------------------------------------------
procedure TOGLCanvas.AddVertex2(x, y: Single);
var
 xNorm, yNorm: Single;
begin
 xNorm:= (x - NormWidth) / NormWidth;
 yNorm:= (y - NormHeight) / NormHeight;
 glVertex2f(xNorm, -yNorm);
end;

//---------------------------------------------------------------------------
procedure TOGLCanvas.AddPoint2(const Point: TPoint2; Color: Longword);
var
 Colors: array[0..3] of Single;
begin
 Colors[0]:= ((Color shr 16) and $FF) / 255.0;
 Colors[1]:= ((Color shr 8) and $FF) / 255.0;
 Colors[2]:= (Color and $FF) / 255.0;
 Colors[3]:= ((Color shr 24) and $FF) / 255.0;

 glColor4fv(@Colors[0]);
 AddVertex2(Point.x, Point.y);
end;

//---------------------------------------------------------------------------
procedure TOGLCanvas.PutPixel(const Point: TPoint2; Color: Cardinal);
begin
 RequestTexture(nil);
 RequestEffect(deNormal);
 RequestCache(ccmPoints);

 AddPoint2(Point, Color);
end;

//---------------------------------------------------------------------------
procedure TOGLCanvas.Line(const Src, Dest: TPoint2; Color0, Color1: Cardinal);
begin
 RequestTexture(nil);
 RequestEffect(deNormal);
 RequestCache(ccmLines);

 AddPoint2(Src, Color0);
 AddPoint2(Dest, Color1);
end;

//---------------------------------------------------------------------------
procedure TOGLCanvas.FillTri(const p1, p2, p3: TPoint2; c1, c2, c3: Cardinal;
 Effect: TDrawingEffect);
begin
 RequestTexture(nil);
 RequestEffect(Effect);
 RequestCache(ccmTris);

 AddPoint2(p1, c1);
 AddPoint2(p2, c2);
 AddPoint2(p3, c3);
end;

//---------------------------------------------------------------------------
procedure TOGLCanvas.FillQuad(const Points: TPoint4; const Colors: TColor4;
 Effect: TDrawingEffect);
begin
 RequestTexture(nil);
 RequestEffect(Effect);
 RequestCache(ccmQuads);

 AddPoint2(Points[0], Colors[0]);
 AddPoint2(Points[1], Colors[1]);
 AddPoint2(Points[2], Colors[2]);
 AddPoint2(Points[3], Colors[3]);
end;

//---------------------------------------------------------------------------
procedure TOGLCanvas.WireQuad(const Points: TPoint4; const Colors: TColor4);
var
 MyPts: TPoint4;
begin
 MyPts:= Points;

 // last pixel fix -> not very good implementation :(
 if (MyPts[0].y = MyPts[1].y)and(MyPts[2].y = MyPts[3].y)and
  (MyPts[0].x = MyPts[3].x)and(MyPts[1].x = MyPts[2].x) then
  begin
   MyPts[1].x:= MyPts[1].x - 1.0;
   MyPts[2].x:= MyPts[2].x - 1.0;
   MyPts[2].y:= MyPts[2].y - 1.0;
   MyPts[3].y:= MyPts[3].y - 1.0;
  end;

 Line(MyPts[0], MyPts[1], Colors[0], Colors[1]);
 Line(MyPts[1], MyPts[2], Colors[1], Colors[2]);
 Line(MyPts[2], MyPts[3], Colors[2], Colors[3]);
 Line(MyPts[3], MyPts[0], Colors[3], Colors[0]);
end;

//---------------------------------------------------------------------------
procedure TOGLCanvas.UseImage(Image: TAsphyreImage; const Mapping: TPoint4;
 TextureNo: Integer);
begin
 if (Image <> nil) then ActiveTex:= Image.Texture[TextureNo]
  else ActiveTex:= nil;

 QuadMapping:= Mapping;
end;

//---------------------------------------------------------------------------
procedure TOGLCanvas.TexMap(const Points: TPoint4; const Colors: TColor4;
 Effect: TDrawingEffect);
begin
 RequestTexture(ActiveTex);
 RequestEffect(Effect);
 RequestCache(ccmQuads);

 glTexCoord2f(QuadMapping[0].x, QuadMapping[0].y);
 AddPoint2(Points[0], Colors[0]);

 glTexCoord2f(QuadMapping[1].x, QuadMapping[1].y);
 AddPoint2(Points[1], Colors[1]);

 glTexCoord2f(QuadMapping[2].x, QuadMapping[2].y);
 AddPoint2(Points[2], Colors[2]);

 glTexCoord2f(QuadMapping[3].x, QuadMapping[3].y);
 AddPoint2(Points[3], Colors[3]);
end;

//---------------------------------------------------------------------------
procedure TOGLCanvas.HandleBeginScene();
begin
 BeginPaint();
end;

//---------------------------------------------------------------------------
procedure TOGLCanvas.HandleEndScene();
begin
 EndPaint();
end;

//---------------------------------------------------------------------------
function TOGLCanvas.GetAntialias(): Boolean;
begin
 Result:= True;
end;

//---------------------------------------------------------------------------
procedure TOGLCanvas.SetAntialias(const Value: Boolean);
begin

end;

//---------------------------------------------------------------------------
function TOGLCanvas.GetMipMapping(): Boolean;
begin
 Result:= True;
end;

//---------------------------------------------------------------------------
procedure TOGLCanvas.SetMipMapping(const Value: Boolean);
begin

end;

//---------------------------------------------------------------------------
procedure TOGLCanvas.GetViewport(out x, y, Width, Height: Integer);
var
 Pos, Size: TPoint2px;
begin
 GetGLViewport(Pos, Size);

 x:= Pos.x;
 y:= Pos.y;
 Width := Size.x;
 Height:= Size.y;
end;

//---------------------------------------------------------------------------
procedure TOGLCanvas.SetViewport(x, y, Width, Height: Integer);
begin
 glViewport(x, y, Width, Height);
end;

//---------------------------------------------------------------------------
procedure TOGLCanvas.Flush();
begin
 ResetCache();
end;

//---------------------------------------------------------------------------
procedure TOGLCanvas.FillArc(const Pos, Radius: TPoint2; InitPhi,
 EndPhi: Single; Steps: Integer; const Colors: TColor4;
 Effect: TDrawingEffect);
begin

end;

//---------------------------------------------------------------------------
procedure TOGLCanvas.FillHexagon(const Mtx: TMatrix3; c1, c2, c3, c4, c5,
 c6: Cardinal; Effect: TDrawingEffect);
begin

end;

//---------------------------------------------------------------------------
procedure TOGLCanvas.FillRibbon(const Pos, InRadius, OutRadius: TPoint2;
 InitPhi, EndPhi: Single; Steps: Integer; const Colors: TColor4;
 Effect: TDrawingEffect);
begin

end;

//---------------------------------------------------------------------------
procedure TOGLCanvas.FillRibbon(const Pos, InRadius, OutRadius: TPoint2;
 InitPhi, EndPhi: Single; Steps: Integer; InColor1, InColor2, InColor3,
 OutColor1, OutColor2, OutColor3: Cardinal; Effect: TDrawingEffect);
begin

end;

//---------------------------------------------------------------------------
end.
