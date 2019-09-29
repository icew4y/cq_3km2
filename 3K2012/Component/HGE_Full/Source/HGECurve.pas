unit HGECurve;
(*
** hge Curve routine
** Extension to the HGE engine
** Extension added by DraculaLin
** This extension is NOT part of the original HGE engine.
*)

interface
uses
  Types, Math, HGEDef, HGE;

type
  TBezierPoints  = Array[0..3] of TPoint;
  TBezierPoints2 = TPoint4;
  function BezierPoints(const OriginPoint, DestPoint, C1Point, C2Point: TPoint): TBezierPoints; overload;
  function BezierPoints(const OriginPoint, DestPoint, C1Point, C2Point: TPoint2): TBezierPoints2; overload;
  procedure PolyLine(const Points: Array of TPoint; const Color: Cardinal; BlendMode: Integer); overload;
  procedure PolyLine(const Points: Array of TPoint; const Color0, Color1: Cardinal; BlendMode: Integer); overload;
  procedure PolyLine(const Points: Array of TPoint2; const Color: Cardinal; BlendMode: Integer); overload;
  procedure PolyLine(const Points: Array of TPoint2; const Color1, Color2: Cardinal; Blendmode: Integer); overload;
  procedure BezierCurve(BezierPoints: TBezierPoints; Steps: Integer; const LineColor: Cardinal; BlendMode: Integer); overload;
  procedure BezierCurve(BezierPoints: TBezierPoints2; Steps: Integer; const LineColor: Cardinal; Blendmode: Integer); overload;
  procedure BezierCurve(const BezierPoints: TBezierPoints; const Steps: Integer; const LineColor1, LineColor2: Cardinal; Blendmode: Integer); overload;
  procedure BezierCurve(const BezierPoints: TBezierPoints2; const Steps: Integer; const LineColor1, LineColor2: Cardinal; Blendmode: Integer ); overload;
  procedure CubicCurve(const Points: Array of TPoint; Steps: Cardinal; const LineColor: Cardinal; Blendmode: Integer); overload;
  procedure CubicCurve(const Points: Array of TPoint2; Steps: Cardinal; const LineColor: Cardinal; Blendmode: Integer); overload;
  procedure RoundPolygon(Verts: Array of TPoint; const Dist: Integer; const LineColor: Cardinal; Blendmode: Integer; Coeff: Double = 0.5); overload;
  procedure RoundPolygon(Verts: Array of TPoint2; const Dist: Integer; const LineColor: Cardinal; Blendmode: Integer; Coeff: Double = 0.5); overload;

implementation
var
 FHGE: IHGE=nil;


function BezierPoints(const OriginPoint, DestPoint, C1Point, C2Point: TPoint): TBezierPoints;
begin
  Result[0] := OriginPoint;
  Result[1] := C1Point;
  Result[2] := C2Point;
  Result[3] := DestPoint;
end;

function BezierPoints(const OriginPoint, DestPoint, C1Point, C2Point: TPoint2): TBezierPoints2;
begin
  Result[0] := OriginPoint;
  Result[1] := C1Point;
  Result[2] := C2Point;
  Result[3] := DestPoint;
end;

function DisplaceRB(Color: Cardinal): Cardinal; register;
asm
 mov ecx, eax
 mov edx, eax
 and eax, 0FF00FF00h
 and edx, 0000000FFh
 shl edx, 16
 or eax, edx
 mov edx, ecx
 shr edx, 16
 and edx, 0000000FFh
 or eax, edx
end;

function BlendPixels(Px0, Px1: Longword; Alpha: Integer): Longword; stdcall;
asm
 pxor mm7, mm7

 mov eax, 0FFFFFFFFh
 movd mm6, eax
 punpcklbw mm6, mm7    // MM6 -> 255,255,255,255 (words)

 mov eax, 01010101h
 movd mm0, eax
 punpcklbw mm0, mm7    // MM0 -> 1, 1, 1, 1 (words)

 paddusw mm6, mm0      // MM6 -> 256,256,256,256 (words)

 mov eax, Alpha
 and eax, 0FFh
 mov ecx, eax
 shl ecx, 8
 or  eax, ecx
 shl ecx, 8
 or  eax, ecx
 shl ecx, 8
 or eax, ecx

 movd mm2, eax
 punpcklbw mm2, mm7    // MM2 -> alpha,alpha,alpha

 movd mm0, Px0
 movd mm1, Px1

 punpcklbw mm0, mm7
 punpcklbw mm1, mm7

 pmullw mm0, mm2
 psrlw mm0, 8

 psubusw mm6, mm2

 pmullw mm1, mm6
 psrlw mm1, 8

 paddusw mm0, mm1
 packuswb  mm0, mm7

 movd eax, mm0

 emms

 mov Result, eax
end;


procedure PolyLine(const Points: Array of TPoint; const Color: Cardinal; BlendMode: Integer);
var
  I: Integer;
  PSource, PDest: TPoint2;
  Col: Cardinal;
begin
  // (1) Check condition.
  if (Length(Points) < 2) then Exit;

  // (2) Calculate displaced color value (for DX).
  Col := DisplaceRB(Color);

  // (3) Render lines.
  for I := Low(Points) to (High(Points) - 1) do
  begin
    PSource := Point2(Points[i].x, Points[i].y);
    PDest := Point2(Points[I + 1].x, Points[I + 1].y);

    FHGE.Line2Color(PSource.X,PSource.Y, PDest.X,PDest.Y, Col, Col, BlendMode);
  end;
end;

procedure PolyLine(const Points: Array of TPoint2; const Color: Cardinal; Blendmode: Integer);
var
  I: Integer;
  Col: Cardinal;
begin
  // (1) Check condition.
  if (Length(Points) < 2) then Exit;

  // (2) Calculate displaced color walue (for DX).
  Col := DisplaceRB(Color);

  // (3) Render lines.  
  for I := Low(Points) to (High(Points) - 1) do
    FHGE.Line2Color(Points[i].X,Points[i].Y, Points[I + 1].X, Points[I + 1].X, Col, Col, BlendMode);
end;

procedure PolyLine(const Points: array of TPoint; const Color0, Color1: Cardinal; BlendMode: Integer);
var
  I, Len: Integer;
  PSource, PDest: TPoint;
begin
  Len := Length(Points);

  // (1) Check conditions.
  if (Len < 2) then Exit;

  // (2) Render lines for point to point.
  for I := Low(Points) to (High(Points) - 1) do
  begin
    PSource := Points[i];
    PDest := Points[I + 1];
    FHGE.Line2Color(PSource.X, PSource.Y,PDest.X, PDest.Y,
      DisplaceRB(BlendPixels(Color0, Color1, (I * 255) div (Len - 1))),
      DisplaceRB(BlendPixels(Color0, Color1, ((I + 1) * 255) div (Len - 1))), BlendMode);
  end;
end;

procedure PolyLine(const Points: array of TPoint2; const Color1, Color2: Cardinal; BlendMode: Integer);
var
  I, Len: Integer;
begin
  Len := Length(Points);

  // (1) Check conditions.
  if (Len < 2) then Exit;

  // (2) Render lines from point to point.
  for I := Low(Points) to (High(Points) - 1) do
  begin
    FHGE.Line2Color(Points[i].X,Points[i].Y, Points[I + 1].X, Points[I + 1].Y,
      DisplaceRB(BlendPixels(Color1, Color2, (I * 255) div (Len - 1))),
      DisplaceRB(BlendPixels(Color1, Color2, ((I + 1) * 255) div (Len - 1))), BlendMode);
  end;
end;

procedure BezierCurve(BezierPoints: TBezierPoints; Steps: Integer; const LineColor: Cardinal; BlendMode: Integer);
var
  I: Integer;
  o, pos: TPoint2;
  Col: Cardinal;
begin
  // (1) Set first point to "o".
  o := Point2(BezierPoints[0].X, BezierPoints[0].Y);

  // (2) Calculate displaced color value (for DX).
  Col := DisplaceRB(LineColor);

  for I := 0 to (Steps - 1) do
  begin
    // (3) Calculate point position for "I" step.
    pos := Point2(Power(1 - I / Steps, 3) * BezierPoints[0].X + 3 * I / Steps *
      Power(1 - I / Steps, 2) * BezierPoints[1].X + 3 * Power(I / Steps, 2) *
      (1 - I / Steps) * BezierPoints[2].X + Power(I / Steps, 3) *
      BezierPoints[3].X, Power(1 - I / Steps, 3) * BezierPoints[0].Y + 3 * 
      I / Steps * Power(1 - I / Steps, 2) * BezierPoints[1].Y + 3 *
      Power(I / Steps, 2) * (1 - I / Steps) * BezierPoints[2].Y +
     Power(I / Steps, 3) * BezierPoints[3].Y);

    // (4) Render line.
    FHGE.Line2Color(o.X,o.Y, pos.X,pos.Y, Col, Col, Blendmode);

    // (5) Save "pos" in "o" for next step.
    o := pos;
  end;
end;

procedure BezierCurve(BezierPoints: TBezierPoints2; Steps: Integer; const LineColor: Cardinal; BlendMode: Integer);
var
  I: Integer;
  o, pos: TPoint2;
  Col: Cardinal;
begin
  // (1) Set first point to "o".
  o := BezierPoints[0];

  // (2) Calculate displaced color value (for DX).
  Col := DisplaceRB(LineColor);

  for I := 0 to (Steps - 1) do
  begin
    // (3) Calculate point position for "I" step.
    pos := Point2(Power(1 - I / Steps, 3) * BezierPoints[0].X + 3 * I / Steps *
      Power(1 - I / Steps, 2) * BezierPoints[1].X + 3 *
      Power(I / Steps, 2) * (1 - I / Steps) * BezierPoints[2].X +
      Power(I / Steps, 3) * BezierPoints[3].X, 
      Power(1 - I / Steps, 3) * BezierPoints[0].Y + 3 * I / Steps *
      Power(1 - I / Steps, 2) * BezierPoints[1].Y + 3 *
      Power(I / Steps, 2) * (1 - I / Steps) * BezierPoints[2].Y +
      Power(I / Steps, 3) * BezierPoints[3].Y);

    // (4) Render calculated line.
    FHGE.Line2Color(o.X,o.Y, pos.X,pos.Y, Col, Col, BlendMode);

    // (5) Save "pos" to "o" for next step.
    o := pos;
  end;
end;

procedure BezierCurve(const BezierPoints: TBezierPoints; const Steps: Integer; const LineColor1, LineColor2: Cardinal; BlendMode: Integer);
var
  I: Integer;
  o, pos: TPoint2;
begin
  // (1) Set default value to "o".
  o := Point2(BezierPoints[0].X, BezierPoints[0].Y);

  // (2) Iterate...
  for I := 0 to (Steps - 1) do
  begin
    // -> Calculate position for "I" step.
    pos := Point2(Power(1 - I / Steps, 3) * BezierPoints[0].X + 3 * I / Steps *
      Power(1 - I / Steps, 2) * BezierPoints[1].X + 3 * Power(I / Steps, 2) *
      (1 - I / Steps) * BezierPoints[2].X + Power(I / Steps, 3) *
      BezierPoints[3].X, Power(1 - I / Steps, 3) * BezierPoints[0].Y + 3 *
      I / Steps * Power(1 - I / Steps, 2) * BezierPoints[1].Y + 3 * 
      Power(I / Steps, 2) * (1 - I / Steps) * BezierPoints[2].Y +
      Power(I / Steps, 3) * BezierPoints[3].Y);

    // -> Render calculated line.
    FHGE.Line2Color(o.X,o.Y, pos.X,pos.Y, DisplaceRB(BlendPixels(LineColor1, LineColor2, (I * 255) div Steps)),
      DisplaceRB(BlendPixels(LineColor1, LineColor2, ((I + 1) * 255) div Steps)), BlendMode);

    // -> Save "pos" to "o" for next step.
    o := pos;
  end;
end;

procedure BezierCurve(const BezierPoints: TBezierPoints2; const Steps: Integer; const LineColor1, LineColor2: Cardinal; BlendMode: Integer);
var
  I: Integer;
  o, pos: TPoint2;
begin
  // (1) Set default value for "o".
  o := BezierPoints[0];

  // (2) Iterate...
  for I := 0 to (Steps - 1) do
  begin
    // -> Calculate position for "i" step.
    pos := Point2(Power(1 - I / Steps, 3) * BezierPoints[0].X + 3 * I / Steps *
      Power(1 - I / Steps, 2) * BezierPoints[1].X + 3 * Power(I / Steps, 2) *
      (1 - I / Steps) * BezierPoints[2].X + Power(I / Steps, 3) *
      BezierPoints[3].X,  Power(1 - I / Steps, 3) * BezierPoints[0].Y +
      3 * I / Steps * Power(1 - I / Steps, 2) * BezierPoints[1].Y + 3 *
      Power(I / Steps, 2) * (1 - I / Steps) * BezierPoints[2].Y +
      Power(I / Steps, 3) * BezierPoints[3].Y);

    // -> Render calculated line.
    FHGE.Line2Color(o.X,o.Y, pos.X,pos.Y, DisplaceRB(BlendPixels(LineColor1, LineColor2, (I * 255) div Steps)),
      DisplaceRB(BlendPixels(LineColor1, LineColor2, ((I + 1) * 255) div Steps)), BlendMode);

    // -> Save "pos" to "o", for next step.
    o := pos;
  end;
end;

function cubic(v1, v2, v3, v4, t: single): single;
begin
  Result := v2 + t * ((-v1 + v3) + t * ((2 * v1 - 2 * v2 + v3 - v4) + t * ( -v1 + v2 - v3 + v4)));
end;

function Interpolate(const p1, p2, p3, p4: TPoint; t: single): TPoint2; overload;
begin
  Result.X := cubic(p1.X, p2.X, p3.X, p4.X, t);
  Result.Y := cubic(p1.Y, p2.Y, p3.Y, p4.Y, t);
end;

function Interpolate(const p1, p2, p3, p4: TPoint2; t: single): TPoint2; overload;
begin
  Result.X := cubic(p1.X, p2.X, p3.X, p4.X, t);
  Result.Y := cubic(p1.Y, p2.Y, p3.Y, p4.Y, t);
end;

procedure CubicCurve(const Points: Array of TPoint; Steps: Cardinal; const LineColor: Cardinal; BlendMode: Integer);
var
  Len, LoP, HiP, i, s: Integer;
  p, o: TPoint2;
  p1, p2, p3, p4: TPoint;
  Col: Cardinal;
begin
  Len := Length(Points);

  // (1) Check condition.
  if (Len < 2) then exit;

  // (2) Set default values for "LoP", "HiP" and "o".
  LoP := Low(Points);
  HiP := High(Points);
  o := Point2(Points[LoP].X, Points[LoP].Y);

  // (4) Set default value for p2,p3, p4 and calculate displaced color value.
  p2 := Points[LoP];
  p3 := Points[LoP];
  p4 := Points[LoP + 1];
  Col := DisplaceRB(LineColor);

  // (5) Iterate...
  for i := LoP to (HiP - 1) do
  begin
    p1 := p2;
    p2 := p3;
    p3 := p4;
    if (i + 2 < LoP + Len) then p4 := Points[i + 2];

    for s := 1 to Steps do
    begin
      p := Interpolate(p1, p2, p3, p4, s / Steps);

      // -> Render calculated line.
      FHGE.Line2Color(o.X,o.Y, p.X,p.Y, Col, Col, BlendMode);
      o := p;
    end;
  end;
end;

procedure CubicCurve(const Points: Array of TPoint2; Steps: Cardinal; const LineColor: Cardinal; Blendmode: Integer);
var
  Len, LoP, HiP, i, s: Integer;
  p, o, p1, p2, p3, p4: TPoint2;
  Col: Cardinal;
begin
  Len := Length(Points);

  // (1) Check condition.
  if (Len < 2) then exit;

  // (2) Set default value for "o", "LoP" and "HiP".
  LoP := Low(Points);
  HiP := High(Points);
  o := Points[LoP];

  // (3) Set p2, p3, p4 and calculate displaced color value for DX.
  p2 := Points[LoP];
  p3 := Points[LoP];
  p4 := Points[LoP + 1];
  Col := DisplaceRB(LineColor);

  // (4) Iterate...
  for i := LoP to (HiP - 1) do
  begin
    p1 := p2;
    p2 := p3;
    p3 := p4;
    if (i + 2 < LoP + Len) then p4 := Points[i + 2];

    for s := 1 to Steps do
    begin
      p := Interpolate(p1, p2, p3, p4, s / Steps);

      // -> Draw line.
      FHGE.Line2Color(o.X,o.Y, p.X,p.Y, Col, Col, Blendmode);
      o := p;
    end;
  end;
end;

procedure RoundPolygon(Verts: Array of TPoint; const Dist: Integer; const LineColor: Cardinal; Blendmode: Integer; Coeff: Double = 0.5);
var
  Pts: Array[0..3] of TPoint;
  len, TmpD: Double;
  i, dx, dy, np, next, nextnext: Integer;
  o: TPoint2;
  Col: Cardinal;
begin
  // (1) Check conditions.
  if (Length(Verts) < 3) then Exit;

  np := High(Verts) + 1;
  Col := DisplaceRB(LineColor);

  for i := 0 to (np - 1) do
  begin
    // (2) Calculate polygon-line position.
    next := (i + 1) mod np;
    nextnext := (i + 2) mod np;
    dx := Verts[next].x - Verts[i].x;
    dy := Verts[next].y - Verts[i].y;
    len := Sqrt(Sqr(dx) + Sqr(dy));
    TmpD := MinValue([len / 3, Dist]);

    Pts[0] := Point(Verts[next].x - Round(TmpD * dx / len), Verts[next].y - Round(TmpD * dy / len));
    Pts[1] := Point(Verts[next].x - Round(Coeff * TmpD * dx / len),
      Verts[next].y - Round(Coeff * TmpD * dy / len));

    // (3) Save "o".
    o := Point2(Verts[i].x + Round(TmpD * dx / len), Verts[i].y + Round(TmpD * dy / len));

    // (4) Calculate data for rounded curve.
    dx := Verts[nextnext].x - Verts[next].x;
    dy := Verts[nextnext].y - Verts[next].y;
    len := Sqrt(Sqr(dx) + Sqr(dy));
    TmpD := MinValue([len / 3, Dist]);

    Pts[3] := Point(Verts[next].x + Round(TmpD * dx / len), Verts[next].y + Round(TmpD * dy / len));
    Pts[2] := Point(Verts[next].x + Round(Coeff * TmpD * dx / len),
      Verts[next].y + Round(Coeff * TmpD * dy / len));

    // (5) Render calculated line and rounded curve.
    FHGE.Line2Color(o.X,o.Y, Pts[0].X, Pts[0].Y, Col, Col, BlendMode);
   // BezierCurve(BezierPoints(Pts[0], Pts[3], Pts[1], Pts[2]), Dist * 3, LineColor, BlendMode);
  end;
end;

procedure RoundPolygon(Verts: Array of TPoint2; const Dist: Integer; const LineColor: Cardinal; BlendMode: Integer; Coeff: Double = 0.5);
var
  Pts: array[0..3] of TPoint2;
  o: TPoint2;
  len, TmpD, dx, dy: Double;
  i, np, next, nextnext: Integer;
  Col: Cardinal;
begin
  // (1) Check conditions.
  if (Length(Verts) < 3) then Exit;

  np := High(Verts) + 1;
  Col := DisplaceRB(LineColor);

  for i := 0 to (np - 1) do
  begin
    // (2) Calculate polygon-line position.
    next := (i + 1) mod np;
    nextnext := (i + 2) mod np;
    dx := Verts[next].x - Verts[i].x;
    dy := Verts[next].y - Verts[i].y;
    len := Sqrt(Sqr(dx) + Sqr(dy));
    TmpD := MinValue([len / 3, Dist]);

    Pts[0] := Point2(Verts[next].x - (TmpD * dx / len), Verts[next].y - (TmpD * dy / len));
    Pts[1] := Point2(Verts[next].x - (Coeff * TmpD * dx / len), Verts[next].y - (Coeff * TmpD * dy / len));

    // (3) Save "o".
    o := Point2(Verts[i].x + (TmpD * dx / len), Verts[i].y + (TmpD * dy / len));

    // (4) Calculate data for rounded curve.
    dx := Verts[nextnext].x - Verts[next].x;
    dy := Verts[nextnext].y - Verts[next].y;
    len := Sqrt(Sqr(dx) + Sqr(dy));
    TmpD := MinValue([len / 3, Dist]);

    Pts[3] := Point2(Verts[next].x + (TmpD * dx / len), Verts[next].y + (TmpD * dy / len));
    Pts[2] := Point2(Verts[next].x + (Coeff * TmpD * dx / len), Verts[next].y + (Coeff * TmpD * dy / len));

    // (5) Render calculated line and rounded curve.
    FHGE.Line2Color(o.X,o.Y, Pts[0].X,Pts[0].Y, Col, Col, BlendMode);
   // BezierCurve(BezierPoints2(Pts[0], Pts[3], Pts[1], Pts[2]), Dist * 3, LineColor, DrawFx);
  end;
end;
initialization
  FHGE := HGECreate(HGE_VERSION);

end.
 