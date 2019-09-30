unit HGEColor;
(*
** Haaf's Game Engine 1.7
** Copyright (C) 2003-2007, Relish Games
** hge.relishgames.com
**
** hgeColor*** helper classes
**
** Delphi conversion by Erik van Bilsen
*)

interface

(****************************************************************************
 * HGEColor.h
 ****************************************************************************)

procedure ColorClamp(var X: Single); inline;

type
  THGEColorRGB = record
  public
    R, G, B, A: Single;
  public
    constructor Create(const AR, AG, AB, AA: Single); overload;
    constructor Create(const Col: Longword); overload;
    class operator Subtract(const A, B: THGEColorRGB): THGEColorRGB;
    class operator Add(const A, B: THGEColorRGB): THGEColorRGB;
    class operator Multiply(const A: THGEColorRGB; const Scalar: Single): THGEColorRGB;
    class operator Multiply(const Scalar: Single; const A: THGEColorRGB): THGEColorRGB;
    class operator Multiply(const A, B: THGEColorRGB): THGEColorRGB;
    class operator Divide(const A: THGEColorRGB; const Scalar: Single): THGEColorRGB;
    class operator Equal(const A, B: THGEColorRGB): Boolean;
    class operator NotEqual(const A, B: THGEColorRGB): Boolean;
    { NOTE: This replaces the C++ '+=' operator }
    procedure Increment(const C: THGEColorRGB);
    { NOTE: This replaces the C++ '-=' operator }
    procedure Decrement(const C: THGEColorRGB);
    { NOTE: This replaces the C++ '*=' operator }
    procedure Scale(const Scalar: Single);
    procedure Clamp;
    procedure SetHWColor(const Col: Longword);
    function GetHWColor: Longword;
  end;
  THGEColor = THGEColorRGB;

type
  THGEColorHSV = record
  public
    H, S, V, A: Single;
  public
    constructor Create(const Hue, Sat, Val, Alpha: Single); overload;
    constructor Create(const Col: Longword); overload;
    class operator Subtract(const A, B: THGEColorHSV): THGEColorHSV;
    class operator Add(const A, B: THGEColorHSV): THGEColorHSV;
    class operator Multiply(const A: THGEColorHSV; const Scalar: Single): THGEColorHSV;
    class operator Multiply(const Scalar: Single; const A: THGEColorHSV): THGEColorHSV;
    class operator Multiply(const A, B: THGEColorHSV): THGEColorHSV;
    class operator Divide(const A: THGEColorHSV; const Scalar: Single): THGEColorHSV;
    class operator Equal(const A, B: THGEColorHSV): Boolean;
    class operator NotEqual(const A, B: THGEColorHSV): Boolean;
    { NOTE: This replaces the C++ '+=' operator }
    procedure Increment(const C: THGEColorHSV);
    { NOTE: This replaces the C++ '-=' operator }
    procedure Decrement(const C: THGEColorHSV);
    { NOTE: This replaces the C++ '*=' operator }
    procedure Scale(const Scalar: Single);
    procedure Clamp;
    procedure SetHWColor(const Col: Longword);
    function GetHWColor: Longword;
  end;

implementation

uses
  Math;

(****************************************************************************
 * HGEColor.h
 ****************************************************************************)

procedure ColorClamp(var X: Single); inline;
begin
  if (X < 0) then
    X := 0
  else if (X > 1) then
    X := 1;
end;

{ THGEColorRGB }

class operator THGEColorRGB.Add(const A, B: THGEColorRGB): THGEColorRGB;
begin
  Result := THGEColorRGB.Create(A.R + B.R,A.G + B.G,A.B + B.B,A.A + B.A);
end;

procedure THGEColorRGB.Clamp;
begin
  ColorClamp(R);
  ColorClamp(G);
  ColorClamp(B);
  ColorClamp(A);
end;

constructor THGEColorRGB.Create(const AR, AG, AB, AA: Single);
begin
  R := AR;
  G := AG;
  B := AB;
  A := AA;
end;

constructor THGEColorRGB.Create(const Col: Longword);
begin
  SetHWColor(Col);
end;

procedure THGEColorRGB.Decrement(const C: THGEColorRGB);
begin
  R := R - C.R;
  G := G - C.G;
  B := B - C.B;
  A := A - C.A;
end;

class operator THGEColorRGB.Divide(const A: THGEColorRGB;
  const Scalar: Single): THGEColorRGB;
begin
  Result := THGEColorRGB.Create(A.R / Scalar,A.G / Scalar,A.B / Scalar,A.A / Scalar);
end;

class operator THGEColorRGB.Equal(const A, B: THGEColorRGB): Boolean;
begin
  Result := (A.R = B.R) and (A.G = B.G) and (A.B = B.B) and (A.A = B.A);
end;

function THGEColorRGB.GetHWColor: Longword;
begin
  Result :=
    Trunc(A * 255) shl 24 +
    Trunc(R * 255) shl 16 +
    Trunc(G * 255) shl 8 +
    Trunc(B * 255);
end;

procedure THGEColorRGB.Increment(const C: THGEColorRGB);
begin
  R := R + C.R;
  G := G + C.G;
  B := B + C.B;
  A := A + C.A;
end;

class operator THGEColorRGB.Multiply(const A, B: THGEColorRGB): THGEColorRGB;
begin
  Result := THGEColorRGB.Create(A.R * B.R,A.G * B.G,A.B * B.B,A.A * B.A);
end;

class operator THGEColorRGB.Multiply(const A: THGEColorRGB;
  const Scalar: Single): THGEColorRGB;
begin
  Result := THGEColorRGB.Create(A.R * Scalar,A.G * Scalar,A.B * Scalar,A.A * Scalar);
end;

class operator THGEColorRGB.Multiply(const Scalar: Single;
  const A: THGEColorRGB): THGEColorRGB;
begin
  Result := THGEColorRGB.Create(A.R * Scalar,A.G * Scalar,A.B * Scalar,A.A * Scalar);
end;

class operator THGEColorRGB.NotEqual(const A, B: THGEColorRGB): Boolean;
begin
  Result := (A.R <> B.R) or (A.G <> B.G) or (A.B <> B.B) or (A.A <> B.A);
end;

procedure THGEColorRGB.Scale(const Scalar: Single);
begin
  R := R * Scalar;
  G := G * Scalar;
  B := B * Scalar;
  A := A * Scalar;
end;

procedure THGEColorRGB.SetHWColor(const Col: Longword);
begin
  A := (Col shr 24) / 255;
  R := ((Col shr 16) and $FF) / 255;
  G := ((Col shr 8) and $FF) / 255;
  B := (Col and $FF) / 255;
end;

class operator THGEColorRGB.Subtract(const A, B: THGEColorRGB): THGEColorRGB;
begin
  Result := THGEColorRGB.Create(A.R - B.R,A.G - B.G,A.B - B.B,A.A - B.A);
end;

{ THGEColorHSV }

class operator THGEColorHSV.Add(const A, B: THGEColorHSV): THGEColorHSV;
begin
  Result := THGEColorHSV.Create(A.H + B.H,A.S + B.S,A.V + B.V,A.A + B.A);
end;

procedure THGEColorHSV.Clamp;
begin
  ColorClamp(H);
  ColorClamp(S);
  ColorClamp(V);
  ColorClamp(A);
end;

constructor THGEColorHSV.Create(const Hue, Sat, Val, Alpha: Single);
begin
  H := Hue;
  S := Sat;
  V := Val;
  A := Alpha;
end;

constructor THGEColorHSV.Create(const Col: Longword);
begin
  SetHWColor(Col);
end;

procedure THGEColorHSV.Decrement(const C: THGEColorHSV);
begin
  H := H - C.H;
  S := S - C.S;
  V := V - C.V;
  A := A - C.A;
end;

class operator THGEColorHSV.Divide(const A: THGEColorHSV;
  const Scalar: Single): THGEColorHSV;
begin
  Result := THGEColorHSV.Create(A.H / Scalar,A.S / Scalar,A.V / Scalar,A.A / Scalar);
end;

class operator THGEColorHSV.Equal(const A, B: THGEColorHSV): Boolean;
begin
  Result := (A.H = B.H) and (A.S = B.S) and (A.V = B.V) and (A.A = B.A);
end;

function THGEColorHSV.GetHWColor: Longword;
var
  R, G, B, XH, P1, P2, P3: Single;
  I: Integer;
begin
  if (S = 0) then begin
    R := V;
    G := V;
    B := V;
  end else begin
    XH := H * 6;
    if (XH = 6) then
      XH := 0;
    I := Floor(XH);
    P1 := V * (1 - S);
    P2 := V * (1 - S * (XH - I));
    P3 := V * (1 - S * (1 - (XH - I)));

    case I of
      0: begin
           R := V;
           G := P3;
           B := P1;
         end;
      1: begin
           R := P2;
           G := V;
           B := P1;
         end;
      2: begin
           R := P1;
           G := V;
           B := P3;
         end;
      3: begin
           R := P1;
           G := P2;
           B := V;
         end;
      4: begin
           R := P3;
           G := P1;
           B := V;
         end;
    else begin
           R := V;
           G := P1;
           B := P2;
         end;
    end;
  end;
  Result :=
    Trunc(A * 255) shl 24 +
    Trunc(R * 255) shl 16 +
    Trunc(G * 255) shl 8 +
    Trunc(B * 255);
end;

procedure THGEColorHSV.Increment(const C: THGEColorHSV);
begin
  H := H + C.H;
  S := S + C.S;
  V := V + C.V;
  A := A + C.A;
end;

class operator THGEColorHSV.Multiply(const Scalar: Single;
  const A: THGEColorHSV): THGEColorHSV;
begin
  Result := THGEColorHSV.Create(A.H * Scalar,A.S * Scalar,A.V * Scalar,A.A * Scalar);
end;

class operator THGEColorHSV.Multiply(const A: THGEColorHSV;
  const Scalar: Single): THGEColorHSV;
begin
  Result := THGEColorHSV.Create(A.H * Scalar,A.S * Scalar,A.V * Scalar,A.A * Scalar);
end;

class operator THGEColorHSV.Multiply(const A, B: THGEColorHSV): THGEColorHSV;
begin
  Result := THGEColorHSV.Create(A.H * B.H,A.S * B.S,A.V * B.V,A.A * B.A);
end;

class operator THGEColorHSV.NotEqual(const A, B: THGEColorHSV): Boolean;
begin
  Result := (A.H <> B.H) or (A.S <> B.S) or (A.V <> B.V) or (A.A <> B.A);
end;

procedure THGEColorHSV.Scale(const Scalar: Single);
begin
  H := H * Scalar;
  S := S * Scalar;
  V := V * Scalar;
  A := A * Scalar;
end;

procedure THGEColorHSV.SetHWColor(const Col: Longword);
var
  R, G, B, MinV, MaxV, Delta, DelR, DelG, DelB: Single;
begin
  A :=  (Col shr 24         ) / 255;
  R := ((Col shr 16) and $FF) / 255;
  G := ((Col shr  8) and $FF) / 255;
  B :=  (Col         and $FF) / 255;

  MinV := Min(Min(R,G),B);
  MaxV := Max(Max(R,G),B);
  Delta := MaxV - MinV;
  V := MaxV;

  if (Delta = 0) then begin
    H := 0;
    S := 0;
  end else begin
    S := Delta / MaxV;
    DelR := (((MaxV - R) / 6) + (Delta / 2)) / Delta;
    DelG := (((MaxV - G) / 6) + (Delta / 2)) / Delta;
    DelB := (((MaxV - B) / 6) + (Delta / 2)) / Delta;

    if (R = MaxV) then
      H := DelB - DelG
    else if (G = MaxV) then
      H := (1 / 3) + DelR - DelB
    else
      H := (2 / 3) + DelG - DelR;

    if (H < 0) then
      H := H + 1
    else if (H > 1) then
      H := H - 1;
  end;
end;

class operator THGEColorHSV.Subtract(const A, B: THGEColorHSV): THGEColorHSV;
begin
  Result := THGEColorHSV.Create(A.H - B.H,A.S - B.S,A.V - B.V,A.A - B.A);
end;

end.
