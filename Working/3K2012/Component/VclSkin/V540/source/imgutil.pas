{$R-} // Turn off Range Checking because of ARRAY[0..0] construct below

unit ImgUtil;

// The new algorithms are 5 to 8 imes faster (dirty but fast) and they
// not need so many memory (if the bitmap very large you have a problem ->
// windows must use the swapfile).
//{$WARNINGS OFF}
//{$HINTS OFF}

interface

uses Windows, Graphics, math;

procedure SpiegelnHorizontal(Bitmap: TBitmap);
procedure SpiegelnVertikal(Bitmap: TBitmap);
procedure Drehen90Grad(Bitmap: TBitmap);
procedure Drehen270Grad(Bitmap: TBitmap);
procedure Drehen180Grad(Bitmap: TBitmap);
function Rotate90(Bitmap: TBitmap): TBitmap;
procedure ConvertBitmapToGrayscale(const Bmp: TBitmap);
procedure ChangeTrans(abmp: Tbitmap; colorf: Tcolor);
function Blend(C1, C2: TColor; W1: Integer): TColor;
procedure GradFill(DC: HDC; ARect: TRect; ClrTopLeft, ClrBottomRight: TColor; Kind: integer = 1);
function GetHSV(c: Tcolor): integer;

implementation

uses dialogs,
  Classes, // Rect
  SysUtils;

type
  EBitmapError = class(Exception);
  TRGBArray = array[0..0] of TRGBTriple;
  pRGBArray = ^TRGBArray;

procedure ConvertBitmapToGrayscale(const Bmp: TBitmap);
var
  x, y, Gray: Integer;
  Row: PRGBArray;
begin
  Bmp.PixelFormat := pf24Bit;
  for y := 0 to Bmp.Height - 1 do
  begin
    Row := Bmp.ScanLine[y];
    for x := 0 to Bmp.Width - 1 do
    begin
      Gray := (Row[x].rgbtRed + Row[x].rgbtGreen + Row[x].rgbtBlue) div 3;
      Row[x].rgbtRed := Gray;
      Row[x].rgbtGreen := Gray;
      Row[x].rgbtBlue := Gray;
    end;
  end;
end;

procedure ChangeTrans(abmp: Tbitmap; colorf: Tcolor);
var
  x, y: Integer;
  Row: PRGBArray;
  r, g, b: integer;
begin
  r := GetRValue(colorf);
  g := GetGValue(colorf);
  b := GetBValue(colorf);
  if (abmp.PixelFormat <> pf24bit) then
    abmp.PixelFormat := pf24bit;

  for y := 0 to aBmp.Height - 1 do begin
    Row := aBmp.ScanLine[y];
    for x := 0 to aBmp.Width - 1 do begin
      if (Row[x].rgbtRed = 255) and
        (Row[x].rgbtGreen = 0) and
        (Row[x].rgbtBlue = 255) then begin
        Row[x].rgbtRed := r;
        Row[x].rgbtGreen := g;
        Row[x].rgbtBlue := b;
      end;
    end;
  end;
end;

procedure SpiegelnHorizontal(Bitmap: TBitmap);
var
  i, j, n: INTEGER;
  RowIn: pRGBArray;
  RowOut: pRGBArray;
  temp: Tbitmap;
begin
  temp := Tbitmap.create;

  temp.Width := Bitmap.Width;
  temp.Height := Bitmap.Height;
  temp.PixelFormat := Bitmap.PixelFormat; // only pf24bit for now
  n := bitmap.width;
  for j := 0 to Bitmap.Height - 1 do begin
    rowout := temp.Scanline[j];
    rowin := Bitmap.Scanline[j];
    for i := 0 to n - 1 do rowout[i] := rowin[n - 1 - i];
  end;
  bitmap.Assign(temp);
  temp.free;
end;

procedure SpiegelnVertikal(Bitmap: TBitmap);
var
  j, w: INTEGER;
  help: TBitmap;

begin
  help := TBitmap.Create;
  help.Width := Bitmap.Width;
  help.Height := Bitmap.Height;
  help.PixelFormat := Bitmap.PixelFormat;
  w := Bitmap.Width * sizeof(TRGBTriple);
  for j := 0 to Bitmap.Height - 1 do move(Bitmap.Scanline[j]^, Help.Scanline[Bitmap.Height - 1 - j]^, w);
  Bitmap.Assign(help);
  help.free;
end;

type
  THelpRGB = packed record
    rgb: TRGBTriple;
    dummy: byte;
  end;

procedure Drehen270Grad(Bitmap: TBitmap);
var
  aStream: TMemorystream;
  header: TBITMAPINFO;
  dc: hDC;
  P: ^THelpRGB;
  x, y, b, h: Integer;
  RowOut: pRGBArray;

begin
  aStream := TMemoryStream.Create;
  aStream.SetSize(Bitmap.Height * Bitmap.Width * 4);
  with header.bmiHeader do begin
    biSize := SizeOf(TBITMAPINFOHEADER);
    biWidth := Bitmap.Width;
    biHeight := Bitmap.Height;
    biPlanes := 1;
    biBitCount := 32;
    biCompression := 0;
    biSizeimage := aStream.Size;
    biXPelsPerMeter := 1;
    biYPelsPerMeter := 1;
    biClrUsed := 0;
    biClrImportant := 0;
  end;
  dc := GetDC(0);
  P := aStream.Memory;
  GetDIBits(dc, Bitmap.Handle, 0, Bitmap.Height, P, header, dib_RGB_Colors);
  ReleaseDC(0, dc);
  b := bitmap.Height; // rotate
  h := bitmap.Width; // rotate
  bitmap.Width := b;
  bitmap.height := h;
  for y := 0 to (h - 1) do begin
    rowOut := Bitmap.ScanLine[(h - 1) - y];
    P := aStream.Memory; // reset pointer
    inc(p, y);
    for x := (b - 1) downto 0 do begin
      rowout[x] := p^.rgb;
      inc(p, h);
    end;
  end;
  aStream.Free;
end;

procedure Drehen90Grad(Bitmap: TBitmap);
var
  aStream: TMemorystream;
  header: TBITMAPINFO;
  dc: hDC;
  P: ^THelpRGB;
  x, y, b, h: Integer;
  RowOut: pRGBArray;

begin
  aStream := TMemoryStream.Create;
  aStream.SetSize(Bitmap.Height * Bitmap.Width * 4);
  with header.bmiHeader do begin
    biSize := SizeOf(TBITMAPINFOHEADER);
    biWidth := Bitmap.Width;
    biHeight := Bitmap.Height;
    biPlanes := 1;
    biBitCount := 32;
    biCompression := 0;
    biSizeimage := aStream.Size;
    biXPelsPerMeter := 1;
    biYPelsPerMeter := 1;
    biClrUsed := 0;
    biClrImportant := 0;
  end;
  dc := GetDC(0);
  P := aStream.Memory;
  GetDIBits(dc, Bitmap.Handle, 0, Bitmap.Height, P, header, dib_RGB_Colors);
  ReleaseDC(0, dc);
  b := bitmap.Height; // rotate
  h := bitmap.Width; // rotate
  bitmap.Width := b;
  bitmap.height := h;
  for y := 0 to (h - 1) do begin
    rowOut := Bitmap.ScanLine[y];
    P := aStream.Memory; // reset pointer
    inc(p, y);
    for x := 0 to (b - 1) do begin
      rowout[x] := p^.rgb;
      inc(p, h);
    end;
  end;
  aStream.Free;
end;

procedure Drehen180Grad(Bitmap: TBitmap);
var
  i, j: INTEGER;
  rowIn: pRGBArray;
  rowOut: pRGBArray;
  help: TBitmap;

begin
  help := TBitmap.Create;
  help.Width := Bitmap.Width;
  help.Height := Bitmap.Height;
  help.PixelFormat := Bitmap.PixelFormat; // only pf24bit for now
  for j := 0 to Bitmap.Height - 1 do begin
    rowIn := Bitmap.ScanLine[j];
    rowOut := help.ScanLine[Bitmap.Height - j - 1];
    for i := 0 to Bitmap.Width - 1 do rowOut[Bitmap.Width - i - 1] := rowIn[i]
  end;
  bitmap.assign(help);
  help.free;
end;

function Rotate90(Bitmap: TBitmap): TBitmap;
var
  i, j: INTEGER;
  rowIn: pRGBArray;
begin
  Result := nil;
  if Bitmap.PixelFormat <> pf24bit then
    exit;

  RESULT := TBitmap.Create;
  RESULT.Width := Bitmap.Height;
  RESULT.Height := Bitmap.Width;
  RESULT.PixelFormat := Bitmap.PixelFormat; // only pf24bit for now

   // Out[j, Right - i - 1] = In[i, j]
  for j := 0 to Bitmap.Height - 1 do begin
    rowIn := Bitmap.ScanLine[j];
    for i := 0 to Bitmap.Width - 1 do
      pRGBArray(RESULT.ScanLine[Bitmap.Width - i - 1])[j] := rowIn[i]
  end;
end;

function Blend(C1, C2: TColor; W1: Integer): TColor;
var
  W2, A1, A2, D, F, G: Integer;
begin
  if C1 < 0 then C1 := GetSysColor(C1 and $FF);
  if C2 < 0 then C2 := GetSysColor(C2 and $FF);

  if W1 >= 100 then D := 1000
  else D := 100;

  W2 := D - W1;
  F := D div 2;

  A2 := C2 shr 16 * W2;
  A1 := C1 shr 16 * W1;
  G := (A1 + A2 + F) div D and $FF;
  Result := G shl 16;

  A2 := (C2 shr 8 and $FF) * W2;
  A1 := (C1 shr 8 and $FF) * W1;
  G := (A1 + A2 + F) div D and $FF;
  Result := Result or G shl 8;

  A2 := (C2 and $FF) * W2;
  A1 := (C1 and $FF) * W1;
  G := (A1 + A2 + F) div D and $FF;
  Result := Result or G;
end;

const
  GRADIENT_CACHE_SIZE = 16;

type
  PRGBQuad = ^TRGBQuad;
  TRGBQuad = Integer;
  PRGBQuadArray = ^TRGBQuadArray;
  TRGBQuadArray = array[0..0] of TRGBQuad;

var
  GradientCache: array[0..GRADIENT_CACHE_SIZE] of array of TRGBQuad;
  NextCacheIndex: Integer = 0;

function FindGradient(Size: Integer; CL, CR: TRGBQuad): Integer;
begin
  Assert(Size > 0);
  Result := GRADIENT_CACHE_SIZE - 1;
  while Result >= 0 do
  begin
    if (Length(GradientCache[Result]) = Size) and
      (GradientCache[Result][0] = CL) and
      (GradientCache[Result][Length(GradientCache[Result]) - 1] = CR) then Exit;
    Dec(Result);
  end;
end;

function MakeGradient(Size: Integer; CL, CR: TRGBQuad): Integer;
var
  R1, G1, B1: Integer;
  R2, G2, B2: Integer;
  R, G, B: Integer;
  I: Integer;
  Bias: Integer;
begin
  Assert(Size > 0);
  Result := NextCacheIndex;
  Inc(NextCacheIndex);
  if NextCacheIndex >= GRADIENT_CACHE_SIZE then NextCacheIndex := 0;
  R1 := CL and $FF;
  G1 := CL shr 8 and $FF;
  B1 := CL shr 16 and $FF;
  R2 := CR and $FF - R1;
  G2 := CR shr 8 and $FF - G1;
  B2 := CR shr 16 and $FF - B1;
  SetLength(GradientCache[Result], Size);
  Dec(Size);
  Bias := Size div 2;
  if Size > 0 then
    for I := 0 to Size do
    begin
      R := R1 + (R2 * I + Bias) div Size;
      G := G1 + (G2 * I + Bias) div Size;
      B := B1 + (B2 * I + Bias) div Size;
      GradientCache[Result][I] := R + G shl 8 + B shl 16;
    end
  else
  begin
    R := R1 + R2 div 2;
    G := G1 + G2 div 2;
    B := B1 + B2 div 2;
    GradientCache[Result][0] := R + G shl 8 + B shl 16;
  end;
end;

function GetGradient(Size: Integer; CL, CR: TRGBQuad): Integer;
begin
  Result := FindGradient(Size, CL, CR);
  if Result < 0 then Result := MakeGradient(Size, CL, CR);
end;

procedure GradFill(DC: HDC; ARect: TRect; ClrTopLeft, ClrBottomRight: TColor; Kind: integer = 1);
const
//  GRAD_MODE: array [0..1] of DWORD = (GRADIENT_FILL_RECT_H, GRADIENT_FILL_RECT_V);
  W: array[0..1] of Integer = (2, 1);
  H: array[0..1] of Integer = (1, 2);
type
  TriVertex = packed record
    X, Y: Longint;
    R, G, B, A: Word;
  end;
var
  Size, I, Start, Finish: Integer;
  GradIndex: Integer;
  R, CR: TRect;
  Brush: HBRUSH;
begin
  if not RectVisible(DC, ARect) then Exit;

  ClrTopLeft := ColorToRGB(ClrTopLeft);
  ClrBottomRight := ColorToRGB(ClrBottomRight);
    { Have to do it manually if msimg32.dll is not available }
  GetClipBox(DC, CR);

  if Kind = 0 then begin
    Size := ARect.Right - ARect.Left;
    if Size <= 0 then Exit;
    Start := 0;
    Finish := Size - 1;
    if CR.Left > ARect.Left then Inc(Start, CR.Left - ARect.Left);
    if CR.Right < ARect.Right then Dec(Finish, ARect.Right - CR.Right);
    R := ARect;
    Inc(R.Left, Start);
    R.Right := R.Left + 1;
  end else begin
    Size := ARect.Bottom - ARect.Top;
    if Size <= 0 then Exit;
    Start := 0;
    Finish := Size - 1;
    if CR.Top > ARect.Top then Inc(Start, CR.Top - ARect.Top);
    if CR.Bottom < ARect.Bottom then Dec(Finish, ARect.Bottom - CR.Bottom);
    R := ARect;
    Inc(R.Top, Start);
    R.Bottom := R.Top + 1;
  end;

  GradIndex := GetGradient(Size, ClrTopLeft, ClrBottomRight);
  for I := Start to Finish do begin
    Brush := CreateSolidBrush(GradientCache[GradIndex][I]);
    Windows.FillRect(DC, R, Brush);
    OffsetRect(R, Integer(Kind = 0), Integer(Kind = 1));
    DeleteObject(Brush);
  end;
end;

function GetHSV(c: Tcolor): integer;
var
  Delta: double;
  Min: double;
  R, G, B: integer;
  ss: double;
  S, V: Integer;
begin
  R := C and $FF;
  G := C shr 8 and $FF;
  B := C shr 16 and $FF;

  Min := MinIntValue([R, G, B]);
  V := MaxIntValue([R, G, B]);
  Delta := V - Min;
  if V = 0 then ss := 0
  else ss := Delta / V;

  S := round(ss * 255);

  if (r < 160) and (g < 160) and (b < 160) then s := 200;
  result := s;
end;

end.

