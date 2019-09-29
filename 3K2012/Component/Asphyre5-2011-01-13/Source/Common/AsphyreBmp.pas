unit AsphyreBmp;
//---------------------------------------------------------------------------
// AsphyreBmp.pas                                       Modified: 19-Jan-2007
// Asphyre extensions to TBitmap class                            Version 3.0
//---------------------------------------------------------------------------
// The contents of this file are subject to the Mozilla Public License
// Version 1.1 (the "License"); you may not use this file except in
// compliance with the License. You may obtain a copy of the License at
// http://www.mozilla.org/MPL/
//
// Software distributed under the License is distributed on an "AS IS"
// basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
// License for the specific language governing rights and limitations
// under the License.
//---------------------------------------------------------------------------
interface

//---------------------------------------------------------------------------
uses
 Windows, Types, Classes, Graphics, CommonDef, Vectors2, AsphyreTypes,
 ImageFx;

//---------------------------------------------------------------------------
type
 TBitmapEx = class(TBitmap)
 private
  function GetPixels(x, y: Integer): Cardinal;
  procedure SetPixels(x, y: Integer; const Value: Cardinal);
  function GetGrayshade(X, Y: Integer): Real;
  function ModulateAlpha(Color: Cardinal; Beta: Real): Cardinal;
 public
  procedure SetSize(AWidth, AHeight:Integer);
  property Pixels[x, y: Integer]: Cardinal read GetPixels write SetPixels; default;
  property Grayshade[X, Y: Integer]: Real read GetGrayshade;

  procedure PutPixel(x, y: Integer; Color: Cardinal);
  function GetPixel(x, y: Integer): Cardinal;

  procedure Clear(Color: Cardinal);
  procedure Line(const Src, Dest: TPoint; Color1, Color2: Cardinal); overload;
  procedure Line(x1, y1, x2, y2: Integer; Color1, Color2: Cardinal); overload;
  procedure WuLine(Src, Dest: TPoint2; Color0, Color1: Cardinal); overload;
  procedure WuLine(x1, y1, x2, y2: Single; Color0, Color1: Cardinal); overload;
  procedure FillRect(const Rect: TRect; const Colors: TColor4); overload;
  procedure FrameRect(const Rect: TRect; Color: TColor);
  procedure Triangle(x0, y0, x1, y1, x2, y2: Integer; Color: Cardinal);
  procedure SetAlphaMask(MaskedColor: Cardinal; Tolerance: Integer);
  procedure SetAlpha(Alpha: Integer);

  procedure AssignAttrib(Source: TBitmap);

  procedure CopyFrom(Source: TBitmap);
  procedure SaveTo(Dest: TBitmap);

  procedure Shrink2x(Dest: TBitmap);

  function HasAlphaChannel(): Boolean;

  constructor Create(); override;
 end;

//---------------------------------------------------------------------------
 TBitmaps = class
 private
  Data: array of TBitmapEx;

  function GetCount(): Integer;
  procedure SetCount(const Value: Integer);
  function GetItem(Num: Integer): TBitmapEx;
  procedure SetItem(Num: Integer; const Value: TBitmapEx);
 public
  property Items[Num: Integer]: TBitmapEx read GetItem write SetItem; default;
  property Count: Integer read GetCount write SetCount;

  function Add(): Integer;
  procedure Remove(Num: Integer);
  procedure RemoveAll();
  function Find(Image: TBitmapEx): Integer;

  constructor Create();
  destructor Destroy(); override;
 end;

 //---------------------------------------------------------------------------
implementation

//---------------------------------------------------------------------------
type
 TGradientRect = record
  UpperLeft : Longword;
  LowerRight: Longword;
 end;

//---------------------------------------------------------------------------
 TGradientTriangle = record
  Vertex1: Longword;
  Vertex2: Longword;
  Vertex3: Longword;
 end;

//---------------------------------------------------------------------------
 PTriVertex = ^TTriVertex;
 TTriVertex = record
  x: Integer;
  y: Integer;
  Red  : Word;
  Green: Word;
  Blue : Word;
  Alpha: Word;
 end;

//---------------------------------------------------------------------------
 PVertex4 = ^TVertex4;
 TVertex4 = array[0..3] of TTriVertex;
 TVertex3 = array[0..2] of TTriVertex;

//---------------------------------------------------------------------------
function GradientFill(Handle: THandle; pVertex: Pointer; dwNumVertex: Longword;
 pMesh: Pointer; dwNumMesh: Longword; dwMode: Longword): Boolean;
 stdcall; external 'Msimg32.dll';

//---------------------------------------------------------------------------
function TriVertex(Point: TPoint; Color: Cardinal): TTriVertex;
begin
 Result.x    := Point.X;
 Result.y    := Point.Y;
 Result.Red  := (Color and $FF) shl 8;
 Result.Green:= Color and $FF00;
 Result.Blue := (Color shr 8) and $FF00;
 Result.Alpha:= (Color shr 16) and $FF00;
end;

//---------------------------------------------------------------------------
procedure Rect2Vertex(Vertex: PVertex4; Rect: TRect);
begin
 Vertex[0].x:= Rect.Left;
 Vertex[0].y:= Rect.Top;
 Vertex[1].x:= Rect.Right;
 Vertex[1].y:= Rect.Top;
 Vertex[2].x:= Rect.Right;
 Vertex[2].y:= Rect.Bottom;
 Vertex[3].x:= Rect.Left;
 Vertex[3].y:= Rect.Bottom;
end;

//---------------------------------------------------------------------------
procedure Color2Vertex(Vertex: PTriVertex; Color: Cardinal);
begin
 Vertex.Red  := (Color and $FF) shl 8;
 Vertex.Green:= Color and $FF00;
 Vertex.Blue := (Color shr 8) and $FF00;
 Vertex.Alpha:= (Color shr 16) and $FF00;
end;

//---------------------------------------------------------------------------
constructor TBitmapEx.Create();
begin
 inherited;

 PixelFormat:= pf32bit;
end;

//---------------------------------------------------------------------------
function TBitmapEx.GetPixels(x, y: Integer): Cardinal;
var
 px: PCardinal;
begin
 px:= Pointer(Integer(Scanline[y]) + (x shl 2));
 Result:= px^;
end;

//---------------------------------------------------------------------------
procedure TBitmapEx.SetPixels(X, Y: Integer; const Value: Cardinal);
var
 px: PCardinal;
begin
 px:= Pointer(Integer(Scanline[y]) + (x shl 2));
 px^:= Value;
end;

//---------------------------------------------------------------------------
procedure TBitmapEx.PutPixel(x, y: Integer; Color: Cardinal);
var
 px: PCardinal;
begin
 if (x < 0)or(y < 0)or(x >= Width)or(y >= Height) then Exit;

 px:= Pointer(Integer(Scanline[y]) + (x shl 2));
 px^:= BlendPixels(DisplaceRB(Color) or $FF000000, px^, Color shr 24);
end;

//---------------------------------------------------------------------------
function TBitmapEx.GetPixel(x, y: Integer): Cardinal;
begin
 if (x >= 0)and(y >= 0)and(x < Width)and(y < Height) then
  Result:= GetPixels(x, y) else Result:= 0;
end;

//---------------------------------------------------------------------------
function TBitmapEx.GetGrayshade(x, y: Integer): Real;
var
 Color: Cardinal;
begin
 Color:= GetPixel(x, y);

 Result:= ((Color and $FF) * 0.3 + ((Color shr 8) and $FF) * 0.59 +
  ((Color shr 16) and $FF) * 0.11) / 255.0;
end;

//---------------------------------------------------------------------------
procedure TBitmapEx.Clear(Color: Cardinal);
var
 j, i: Integer;
 px: PCardinal;
begin
 Color:= DisplaceRB(Color);

 for j:= 0 to Height - 1 do
  begin
   px:= Scanline[j];
   for i:= 0 to Width - 1 do
    begin
     px^:= Color;
     Inc(px);
    end;
  end;
end;

//---------------------------------------------------------------------------
procedure TBitmapEx.Line(const Src, Dest: TPoint; Color1, Color2: Cardinal);
var
 xDelta, yDelta, vFixed, vDelta, i, vPos, Alpha, AlphaVel: Integer;
begin
 xDelta:= Abs(Dest.X - Src.X);
 yDelta:= Abs(Dest.Y - Src.Y);

 if (xDelta < 1)and(yDelta < 1) then
  begin
   PutPixel(Src.X, Src.Y, BlendPixels(Color2, Color1, 128));
   Exit;
  end;

 if (yDelta > xDelta) then
  begin
   vFixed:= Src.X shl 16;
   vDelta:= ((Dest.X - Src.X) shl 16) div yDelta;
   vPos:= Src.Y;
   Alpha:= 0;
   AlphaVel:= $FFFF div yDelta;
   if (Dest.Y < vPos) then
    begin
     vPos:= Dest.Y;
     vFixed:= Dest.X shl 16;
     vDelta:= -vDelta;
     Alpha:= $FFFF;
     AlphaVel:= -AlphaVel;

     Inc(vPos);
     Inc(vFixed, vDelta);
     Inc(Alpha, AlphaVel);
    end;
   Dec(yDelta);

   for i:= 0 to yDelta do
    begin
     PutPixel(vFixed shr 16, vPos + i, BlendPixels(Color2, Color1, Alpha shr 8));
     Inc(vFixed, vDelta);
     Inc(Alpha, AlphaVel);
    end;
  end else
  begin
   vFixed:= Src.Y shl 16;
   vDelta:= ((Dest.Y - Src.Y) shl 16) div xDelta;
   vPos:= Src.X;
   Alpha:= 0;
   AlphaVel:= $FFFF div xDelta;
   if (Dest.X < vPos) then
    begin
     vPos:= Dest.X;
     vFixed:= Dest.Y shl 16;
     vDelta:= -vDelta;
     Alpha:= $FFFF;
     AlphaVel:= -AlphaVel;

     Inc(vPos);
     Inc(vFixed, vDelta);
     Inc(Alpha, AlphaVel);
    end;
   Dec(xDelta);

   for i:= 0 to xDelta do
    begin
     PutPixel(vPos + i, vFixed shr 16, BlendPixels(Color2, Color1, Alpha shr 8));
     Inc(vFixed, vDelta);
     Inc(Alpha, AlphaVel);
    end;
  end;
end;

//---------------------------------------------------------------------------
procedure TBitmapEx.Line(x1, y1, x2, y2: Integer; Color1, Color2: Cardinal);
begin
 Line(Point(x1, y1), Point(x2, y2), Color1, Color2);
end;

//---------------------------------------------------------------------------
function TBitmapEx.ModulateAlpha(Color: Cardinal; Beta: Real): Cardinal;
begin
 Result:= (Color and $FFFFFF) or (Round((Color shr 24) * Beta) shl 24);
end;

//---------------------------------------------------------------------------
procedure TBitmapEx.WuLine(Src, Dest: TPoint2; Color0, Color1: Cardinal);
const
 Epsilon = 0.00001; // treshold to consider the line is straight
var
 DeltaX, DeltaY, Grad, xEnd, yEnd, xPos, yPos: Real;
 Alpha, AlphaInc: Real;
 Aux, Point0, Point1: TPoint2;
 Index: Integer;
 MyColor: Cardinal;
begin
 DeltaX:= Dest.x - Src.x;
 DeltaY:= Dest.y - Src.y;

 if (Abs(DeltaX) > Abs(DeltaY)) then
  begin // horizontal line
   if (DeltaX < 0.0) then
    begin
     Aux := Src;
     Src := Dest;
     Dest:= Aux;
     DeltaX:= -DeltaX;
     DeltaY:= -DeltaY;
    end;

   Grad:= DeltaY / DeltaX;

   // 1st point
   xEnd:= Int(Src.x + 0.5);
   yEnd:= Src.y + (xEnd - Src.x) * Grad;
   yPos:= yEnd + Grad;

   Point0:= Point2(Int(xEnd), Int(yEnd));

   // 2nd point
   xEnd:= Int(Dest.x + 0.5);
   yEnd:= Dest.y + (xEnd - Dest.x) * Grad;

   Point1:= Point2(Int(xEnd), Int(yEnd));

   Alpha:= 0.0;
   AlphaInc:= 255.0 / Abs(Int(Point1.x) - Int(Point0.x));
   for Index:= Trunc(Point0.x) to Trunc(Point1.x) do
    begin
     MyColor:= BlendPixels(Color1, Color0, Round(Alpha));
     PutPixel(Index, Trunc(yPos), ModulateAlpha(MyColor, 1.0 - Frac(yPos)));
     PutPixel(Index, Trunc(yPos) + 1, ModulateAlpha(MyColor, Frac(yPos)));

     yPos:= yPos + Grad;
     Alpha:= Alpha + AlphaInc;
    end;
  end else
  begin // vertical line
   if (DeltaY < 0.0) then
    begin
     Aux := Src;
     Src := Dest;
     Dest:= Aux;
     DeltaX:= -DeltaX;
     DeltaY:= -DeltaY;
    end;

   Grad:= DeltaX / DeltaY;

   // 1st point
   yEnd:= Int(Src.y + 0.5);
   xEnd:= Src.x + (yEnd - Src.y) * Grad;
   xPos:= xEnd + Grad;

   Point0:= Point2(Int(xEnd), Int(yEnd));

   // 2nd point
   yEnd:= Int(Dest.y + 0.5);
   xEnd:= Dest.x + (yEnd - Dest.y) * Grad;

   Point1:= Point2(Int(xEnd), Int(yEnd));

   Alpha:= 0.0;
   AlphaInc:= 255.0 / Abs(Int(Point1.y) - Int(Point0.y));
   for Index:= Trunc(Point0.y) to Trunc(Point1.y) do
    begin
     MyColor:= BlendPixels(Color1, Color0, Round(Alpha));
     PutPixel(Trunc(xPos), Index, ModulateAlpha(MyColor, 1.0 - Frac(xPos)));
     PutPixel(Trunc(xPos) + 1, Index, ModulateAlpha(MyColor, Frac(xPos)));

     xPos := xPos + Grad;
     Alpha:= Alpha + AlphaInc;
    end;
  end;
end;

//---------------------------------------------------------------------------
procedure TBitmapEx.WuLine(x1, y1, x2, y2: Single; Color0, Color1: Cardinal);
begin
 WuLine(Point2(x1, y1), Point2(x2, y2), Color0, Color1);
end;

//---------------------------------------------------------------------------
procedure TBitmapEx.FillRect(const Rect: TRect; const Colors: TColor4);
var
 Vertex4: TVertex4;
 Mesh: array[0..1] of TGradientTriangle;
begin
 Rect2Vertex(@Vertex4, Rect);

 Color2Vertex(@Vertex4[0], Colors[0]);
 Color2Vertex(@Vertex4[1], Colors[1]);
 Color2Vertex(@Vertex4[2], Colors[2]);
 Color2Vertex(@Vertex4[3], Colors[3]);

 Mesh[0].Vertex1:= 0;
 Mesh[0].Vertex2:= 1;
 Mesh[0].Vertex3:= 2;
 Mesh[1].Vertex1:= 0;
 Mesh[1].Vertex2:= 2;
 Mesh[1].Vertex3:= 3;

 GradientFill(Canvas.Handle, @Vertex4, 4, @Mesh, 2, GRADIENT_FILL_TRIANGLE);
end;

//---------------------------------------------------------------------------
procedure TBitmapEx.Triangle(x0, y0, x1, y1, x2, y2: Integer; Color: Cardinal);
var
 Vertex3: TVertex3;
 Mesh: TGradientTriangle;
begin
 Vertex3[0].x:= x0;
 Vertex3[0].y:= y0;
 Vertex3[1].x:= x1;
 Vertex3[1].y:= y1;
 Vertex3[2].x:= x2;
 Vertex3[2].y:= y2;

 Color2Vertex(@Vertex3[0], Color);
 Color2Vertex(@Vertex3[1], Color);
 Color2Vertex(@Vertex3[2], Color);

 Mesh.Vertex1:= 0;
 Mesh.Vertex2:= 1;
 Mesh.Vertex3:= 2;

 GradientFill(Canvas.Handle, @Vertex3, 3, @Mesh, 1, GRADIENT_FILL_TRIANGLE);
end;

//---------------------------------------------------------------------------
procedure TBitmapEx.FrameRect(const Rect: TRect; Color: TColor);
begin
 with Canvas do
  begin
   Brush.Style:= bsSolid;
   Brush.Color:= Color;
   FrameRect(Rect);
  end;
end;

//---------------------------------------------------------------------------
procedure TBitmapEx.SetAlpha(Alpha: Integer);
var
 Index   : Integer;
 AlphaCol: Longword;
 px      : PLongword;
 Count   : Integer;
begin
 AlphaCol:= (Cardinal(Alpha) and $FF) shl 24;

 for Index:= 0 to Height - 1 do
  begin
   px:= Scanline[Index];
   for Count:= 0 to Width - 1 do
    begin
     px^:= (px^ and $FFFFFF) or AlphaCol;
     Inc(px);
    end;
  end;  
end;

//---------------------------------------------------------------------------
procedure TBitmapEx.SetAlphaMask(MaskedColor: Cardinal; Tolerance: Integer);
var
 Index: Integer;
 Aux  : Pointer;
begin
 for Index:= 0 to Height - 1 do
  begin
   Aux:= Scanline[Index];
   LineConvMasked(Aux, Aux, Width, Tolerance, DisplaceRB(MaskedColor));
  end;
end;

procedure TBitmapEx.SetSize(AWidth, AHeight:Integer);
begin
  Width:=AWidth;
  Height:=AHeight;
end;
//---------------------------------------------------------------------------
procedure TBitmapEx.AssignAttrib(Source: TBitmap);
begin
 SetSize(Source.Width, Source.Height);
end;

//---------------------------------------------------------------------------
procedure TBitmapEx.CopyFrom(Source: TBitmap);
var
 i, MyPitch: Integer;
begin
 AssignAttrib(Source);
 MyPitch:= Width * 4;

 for i:= 0 to Height - 1 do
  Move(Source.Scanline[i]^, Scanline[i]^, MyPitch);
end;

//---------------------------------------------------------------------------
procedure TBitmapEx.SaveTo(Dest: TBitmap);
var
 i, MyPitch: Integer;
begin
 Dest.Width := Width;
 Dest.Height:= Height;
 Dest.PixelFormat:= PixelFormat;
 MyPitch:= Width * 4;

 for i:= 0 to Height - 1 do
  Move(Scanline[i]^, Dest.Scanline[i]^, MyPitch);
end;

//---------------------------------------------------------------------------
procedure TBitmapEx.Shrink2x(Dest: TBitmap);
var
 j: Integer;
begin
 if (Dest.PixelFormat <> pf32bit) then Dest.PixelFormat:= pf32bit;
 if (Dest.Width <> Width div 2)or(Dest.Height <> Height div 2) then
  begin
   Dest.Width := Width div 2;
   Dest.Height:= Height div 2;
  end;

 for j:= 0 to Dest.Height - 1 do
  ShrinkLine2x(ScanLine[j * 2], ScanLine[(j * 2) + 1], Dest.ScanLine[j], Dest.Width);
end;

//---------------------------------------------------------------------------
function TBitmapEx.HasAlphaChannel(): Boolean;
var
 i, j: Integer;
 Px  : PCardinal;
begin
 for j:= 0 to Height - 1 do
  begin
   Px:= ScanLine[j];
   for i:= 0 to Width - 1 do
    begin
     if (Px^ and $FF000000 > 0) then
      begin
       Result:= True;
       Exit;
      end;

     Inc(Px);
    end;
  end;

 Result:= False;
end;

//---------------------------------------------------------------------------
constructor TBitmaps.Create();
begin
 inherited;

 SetLength(Data, 0);
end;

//---------------------------------------------------------------------------
destructor TBitmaps.Destroy;
begin
 RemoveAll();

 inherited;
end;

//---------------------------------------------------------------------------
function TBitmaps.GetCount(): Integer;
begin
 Result:= Length(Data);
end;

//---------------------------------------------------------------------------
procedure TBitmaps.SetCount(const Value: Integer);
begin
 while (Length(Data) < Value) do Add();
 while (Length(Data) > Value)and(Length(Data) > 1) do Remove(0);
end;

//---------------------------------------------------------------------------
function TBitmaps.GetItem(Num: Integer): TBitmapEx;
begin
 if (Num >= 0)and(Num < Length(Data)) then
  Result:= Data[Num] else Result:= nil;
end;

//---------------------------------------------------------------------------
procedure TBitmaps.SetItem(Num: Integer; const Value: TBitmapEx);
begin
 if (Num >= 0)and(Num < Length(Data)) then
  Data[Num].CopyFrom(Value);
end;

//---------------------------------------------------------------------------
function TBitmaps.Add(): Integer;
var
 Index: Integer;
begin
 Index:= Length(Data);
 SetLength(Data, Index + 1);

 Data[Index]:= TBitmapEx.Create();
 Result:= Index;
end;

//---------------------------------------------------------------------------
function TBitmaps.Find(Image: TBitmapEx): Integer;
var
 i: Integer;
begin
 Result:= -1;

 for i:= 0 to Length(Data) - 1 do
  if (Data[i] = Image) then
   begin
    Result:= i;
    Break;
   end; 
end;

//---------------------------------------------------------------------------
procedure TBitmaps.Remove(Num: Integer);
var
 i: Integer;
begin
 if (Num < 0)or(Num >= Length(Data)) then Exit;

 Data[Num].Free();
 for i:= Num to Length(Data) - 2 do
  Data[i]:= Data[i + 1];

 SetLength(Data, Length(Data) - 1); 
end;

//---------------------------------------------------------------------------
procedure TBitmaps.RemoveAll();
var
 i: Integer;
begin
 for i:= 0 to Length(Data) - 1 do
  if (Data[i] <> nil) then
   begin
    Data[i].Free();
    Data[i]:= nil;
   end;

 SetLength(Data, 0);
end;

//---------------------------------------------------------------------------
end.
