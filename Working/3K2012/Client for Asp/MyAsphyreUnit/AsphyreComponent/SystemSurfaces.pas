unit SystemSurfaces;

//---------------------------------------------------------------------------

{$ifdef fpc}{$asmmode intel}{$endif}

//---------------------------------------------------------------------------
interface

//----------------------------------------------------------------------------
uses
 Classes, SysUtils, Vectors2px, AsphyreDb;

//----------------------------------------------------------------------------
type
 TSystemSurface = class
 private
  FName  : string;
  
  FBits  : Pointer;
  FPitch : Integer;
  FWidth : Integer;
  FHeight: Integer;

  function GetPixel(x, y: Integer): Cardinal;
  procedure SetPixel(x, y: Integer; const Value: Cardinal);
  function GetScanline(Index: Integer): Pointer;
  procedure LoadFromStream(Stream: TStream);
 public
  property Name  : string read FName write FName;

  property Bits  : Pointer read FBits;
  property Pitch : Integer read FPitch;
  property Width : Integer read FWidth;
  property Height: Integer read FHeight;

  property Pixels[x, y: Integer]: Cardinal read GetPixel write SetPixel;
  property Scanline[Index: Integer]: Pointer read GetScanline;

  procedure SetSize(AWidth, AHeight: Integer);
  procedure CopyFrom(Source: TSystemSurface);

  procedure Clear(Color: Cardinal);
  procedure ResetAlpha();

  procedure Shrink2x(Source: TSystemSurface);
  function LoadFromASDb(const Key: string; ASDb: TASDb): Boolean;
  function LoadFromTGA(const FileName: string): Boolean;

  procedure StretchBi(Source: TSystemSurface; x, y, Width, Height, SrcX, SrcY,
   SrcWidth, SrcHeight: Integer);
  procedure DrawAdd(Source: TSystemSurface; x, y, Width, Height, SrcX, SrcY,
   SrcWidth, SrcHeight: Integer);

  function BiPixel(x, y, xDelta, yDelta: Integer): Cardinal;

  constructor Create();
  destructor Destroy(); override;
 end;

//----------------------------------------------------------------------------
 TSystemSurfaces = class
 private
  Surfaces: array of TSystemSurface;

  function GetCount(): Integer;
  function GetItem(Num: Integer): TSystemSurface;
  function Insert(Surface: TSystemSurface): Integer;
 public
  property Count: Integer read GetCount;
  property Items[Num: Integer]: TSystemSurface read GetItem; default;

  procedure Add(Amount, Width, Height: Integer); overload;
  function Add(Width, Height: Integer): Integer; overload;

  function AddFromASDb(const Key: string; ASDb: TASDb): Integer;
  function IndexOf(const ImageName: string): Integer;

  procedure RemoveAll();

  constructor Create();
  destructor Destroy(); override;
 end;

//----------------------------------------------------------------------------
implementation

//---------------------------------------------------------------------------
uses
 AsphyreTypes, AsphyreUtils, AsphyreConv, MediaUtils, NativeTGA,
 AsphyreLegacyFormats;

//---------------------------------------------------------------------------
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

//---------------------------------------------------------------------------
procedure ShrinkLine2x(Src0, Src1, Dest: Pointer;
 PixCount: Integer); stdcall;
begin
 asm
  push edi
  push esi
  push ebx
  mov ecx, PixCount
  mov esi, Src0
  mov edx, Src1
  mov edi, Dest
  pxor mm7, mm7
 @ConvLoop:
  movd mm0, [esi]
  punpcklbw mm0, mm7
  movd mm1, [esi + 4]
  punpcklbw mm1, mm7
  paddsw mm0, mm1
  movd mm2, [edx]
  punpcklbw mm2, mm7
  movd mm3, [edx + 4]
  punpcklbw mm3, mm7
  paddsw mm0, mm2
  paddsw mm0, mm3
  psrlw  mm0, 2
  packuswb  mm0, mm7
  movd [edi], mm0
  add esi, 8
  add edx, 8
  add edi, 4
  dec ecx
  jnz @ConvLoop
  emms
  pop ebx
  pop esi
  pop edi
 end;
end;

//----------------------------------------------------------------------------
constructor TSystemSurface.Create();
begin
 inherited;

 FBits:= nil;
 FPitch := 0;
 FWidth := 0;
 FHeight:= 0;
end;

//---------------------------------------------------------------------------
destructor TSystemSurface.Destroy();
begin
 if (FBits <> nil) then FreeMem(FBits);

 inherited;
end;

//---------------------------------------------------------------------------
procedure TSystemSurface.SetSize(AWidth, AHeight: Integer);
begin
 FWidth := AWidth;
 FHeight:= AHeight;
 FPitch := FWidth * 4;

 ReallocMem(FBits, AWidth * AHeight * 4);
 Clear(0);
end;

//---------------------------------------------------------------------------
function TSystemSurface.GetPixel(x, y: Integer): Cardinal;
begin
 if (x < 0)or(y < 0)or(x >= FWidth)or(y >= FHeight) then
  begin
   Result:= 0;
   Exit;
  end;

 Result:= PCardinal(Integer(FBits) + (FPitch * y) + (x * 4))^;
end;

//---------------------------------------------------------------------------
procedure TSystemSurface.SetPixel(x, y: Integer; const Value: Cardinal);
begin
 if (x < 0)or(y < 0)or(x >= FWidth)or(y >= FHeight) then Exit;
 PCardinal(Integer(FBits) + (FPitch * y) + (x * 4))^:= Value;
end;

//---------------------------------------------------------------------------
function TSystemSurface.GetScanline(Index: Integer): Pointer;
begin
 if (Index >= 0)and(Index < FHeight) then
  Result:= Pointer(Integer(FBits) + (FPitch * Index)) else Result:= nil;
end;

//---------------------------------------------------------------------------
procedure TSystemSurface.CopyFrom(Source: TSystemSurface);
begin
 if (FWidth <> Source.Width)or(FHeight <> Source.Height) then
  SetSize(Source.Width, Source.Height);

 Move(Source.Bits^, FBits^, Width * Height * 4);
end;

//---------------------------------------------------------------------------
procedure TSystemSurface.Clear(Color: Cardinal);
var
 Pixel: PCardinal;
 i: Integer;
begin
 Pixel:= FBits;

 for i:= 0 to (Width * Height) - 1 do
  begin
   Pixel^:= Color;
   Inc(Pixel);
  end;
end;

//---------------------------------------------------------------------------
procedure TSystemSurface.ResetAlpha();
var
 SrcPx: PCardinal;
 i: Integer;
begin
 SrcPx:= FBits;
 for i:= 0 to (FWidth * FHeight) - 1 do
  begin
   SrcPx^:= SrcPx^ or $FF000000;
   Inc(SrcPx);
  end;
end;

//---------------------------------------------------------------------------
procedure TSystemSurface.Shrink2x(Source: TSystemSurface);
var
 i: Integer;
begin
 if (FWidth < Source.Width div 2)or(FHeight < Source.Height div 2) then
  SetSize(Source.Width div 2, Source.Height div 2);

 for i:= 0 to (Source.Height div 2) - 1 do
  begin
   ShrinkLine2x(Source.Scanline[i * 2], Source.Scanline[i * 2 + 1],
    Scanline[i], Source.Width div 2);
  end;
end;

//---------------------------------------------------------------------------
procedure TSystemSurface.StretchBi(Source: TSystemSurface; x, y, Width, Height,
 SrcX, SrcY, SrcWidth, SrcHeight: Integer);
var
 i, j: Integer;
 FixedPt: TPoint2px;
 DeltaPt: TPoint2px;
 DestPx: PCardinal;

 Color1, Color2: Cardinal;
begin
 FixedPt.y:= SrcY shl 16;
 DeltaPt.x:= ((SrcWidth - 1) shl 16) div Width;
 DeltaPt.y:= ((SrcHeight - 1) shl 16) div Height;

 for j:= 0 to Height - 1 do
  begin
   FixedPt.x:= SrcX shl 16;
   DestPx:= Pointer(Integer(FBits) + (FPitch * (j + y)) + (x * 4));
   for i:= 0 to Width - 1 do
    begin
     Color1:= BlendPixels(Source.Pixels[(FixedPt.x shr 16) + 1, FixedPt.y shr 16],
      Source.Pixels[FixedPt.x shr 16, FixedPt.y shr 16], (FixedPt.x and $FFFF) shr 8);

     Color2:= BlendPixels(Source.Pixels[(FixedPt.x shr 16) + 1, (FixedPt.y shr 16) + 1],
      Source.Pixels[FixedPt.x shr 16, (FixedPt.y shr 16) + 1], (FixedPt.x and $FFFF) shr 8);

     DestPx^:= BlendPixels(Color2, Color1, (FixedPt.Y and $FFFF) shr 8);

     Inc(FixedPt.x, DeltaPt.x);
     Inc(DestPx);
    end;
   Inc(FixedPt.y, DeltaPt.y);
  end;
end;

//---------------------------------------------------------------------------
procedure TSystemSurface.DrawAdd(Source: TSystemSurface; x, y, Width, Height,
 SrcX, SrcY, SrcWidth, SrcHeight: Integer);
var
 j: Integer;
 u, v, du, dv, SrcPtr, dp, ddp: Integer;
begin
 u:= SrcX shl 16;
 v:= SrcY shl 16;

 du:= (SrcWidth * 65536) div Width;
 dv:= (SrcHeight * 65536) div Height;

 if (x < 0) then
  begin
   Inc(u, du * -x);
   Inc(Width, x);
   x:= 0;
  end;
 if (y < 0) then
  begin
   Inc(v, dv * -y);
   Inc(Height, y);
   y:= 0;
  end;

 if (x + Width >= FWidth) then Width:= FWidth - x;
 if (y + Height >= FHeight) then Height:= FHeight - y;
 if (Width < 1)or(Height < 1) then Exit;

 dp := Integer(Bits) + (y * FPitch) + (x * 4);
 ddp:= FPitch;

 for j:= 0 to Height - 1 do
  begin
   SrcPtr:= Integer(Source.Bits) + (v shr 16) * Source.Pitch;

   asm
    push edi
    push esi
    push ebx

    mov ecx, Width
    mov edi, dp
    mov esi, SrcPtr
    mov edx, u

    pxor mm7, mm7

    mov eax, $FFFFFF
    movd mm6, eax
    punpcklbw mm6, mm7

   @CopyLoop:
    mov ebx, edx
    shr ebx, 16
    shl ebx, 2
    mov eax, [esi + ebx]

    // load source color to MM0 register
    movd mm0, eax

    // load destination color to MM1 register
    mov eax, [edi]
    movd mm1, eax
    paddusb mm0, mm1

    movd eax, mm0


    and eax, $FFFFFF
    cmovz eax, [edi]

    mov [edi], eax

    add edi, 4
    add edx, du

    dec ecx
    jnz @CopyLoop

    pop ebx
    pop esi
    pop edi

    emms
   end;

   Inc(dp, ddp);
   Inc(v, dv);
  end;
end;

//---------------------------------------------------------------------------
function TSystemSurface.BiPixel(x, y, xDelta, yDelta: Integer): Cardinal;
var
 nx, ny: Integer;
begin
 nx:= Min2(x + 1, FWidth);
 ny:= Min2(y + 1, FHeight);

 Result:=
  BlendPixels(
   BlendPixels(GetPixel(nx, ny), GetPixel(x, ny), xDelta),
   BlendPixels(GetPixel(nx, y), GetPixel(x, y), xDelta),
   yDelta);
end;

//---------------------------------------------------------------------------
procedure TSystemSurface.LoadFromStream(Stream: TStream);
var
 LegacyFormat: TColorFormat;
 TextureSize : TPoint2px;
 TextureCount: Integer;
 PixelFormat : TAsphyrePixelFormat;

 AuxMem  : Pointer;
 AuxSize : Integer;
 Index   : Integer;
 DestPtr : Pointer;
begin
 // Step 1. Read Image information.
 // -> Source Pixel Format
 Stream.ReadBuffer(LegacyFormat, SizeOf(TColorFormat));
 // -> skip Pattern Size, Visible Size and Pattern Count
 Stream.Seek(SizeOf(TPoint2px) * 2 + SizeOf(Integer), soFromCurrent);
 // -> Texture Size
 Stream.ReadBuffer(TextureSize, SizeOf(TPoint2px));
 Stream.ReadBuffer(TextureCount, SizeOf(Integer));

 PixelFormat:= LegacyToPixelFormat(LegacyFormat);

 // Step 2. Allocate temporary memory, if necessary.
 AuxMem := nil;
 AuxSize:= 0;

 if (PixelFormat <> apf_A8R8G8B8)and(PixelFormat <> apf_X8R8G8B8) then
  begin
   AuxSize:= (TextureSize.X * AsphyrePixelFormatBits[PixelFormat]) div 8;
   AuxMem := AllocMem(AuxSize);
  end;

 // Step 3. Resize surface's memory.
 SetSize(TextureSize.x, TextureSize.y * TextureCount);

 // Step 4. Read pixel information.
 for Index:= 0 to FHeight - 1 do
  begin
   DestPtr:= Scanline[Index];
   if (AuxMem <> nil) then
    begin
     Stream.Read(AuxMem^, AuxSize);
     PixelXto32Array(AuxMem, DestPtr, PixelFormat, FWidth);
    end else
    begin // native format
     Stream.Read(DestPtr^, FPitch);
    end;
  end;

 // (5) Release memory.
 if (AuxMem <> nil) then FreeMem(AuxMem);

 // (6) Reset alpha, if necessary.
 if (PixelFormat = apf_X8R8G8B8) then ResetAlpha();
end;

//---------------------------------------------------------------------------
function TSystemSurface.LoadFromTGA(const FileName: string): Boolean;
begin
 Result:= LoadTGAtoSystem(FileName, Self);
end;

//---------------------------------------------------------------------------
function TSystemSurface.LoadFromASDb(const Key: string; ASDb: TASDb): Boolean;
var
 Stream: TMemoryStream;
begin
 Result:= ASDb.UpdateOnce();
 if (not Result) then Exit;

 Stream:= TMemoryStream.Create();
 Result:= ASDb.ReadStream(Key, Stream);

 if (Result) then
  begin
   try
    Stream.Seek(0, soFromBeginning);
    LoadFromStream(Stream);
   except
    Result:= False;
   end;
  end;

 Stream.Free();
end;

//---------------------------------------------------------------------------
constructor TSystemSurfaces.Create();
begin
 inherited;

 SetLength(Surfaces, 0);
end;

//---------------------------------------------------------------------------
destructor TSystemSurfaces.Destroy();
begin
 RemoveAll();

 inherited;
end;

//---------------------------------------------------------------------------
function TSystemSurfaces.GetCount(): Integer;
begin
 Result:= Length(Surfaces);
end;

//---------------------------------------------------------------------------
function TSystemSurfaces.GetItem(Num: Integer): TSystemSurface;
begin
 if (Num >= 0)and(Num < Length(Surfaces)) then
  Result:= Surfaces[Num] else Result:= nil;
end;

//---------------------------------------------------------------------------
function TSystemSurfaces.Insert(Surface: TSystemSurface): Integer;
begin
 Result:= Length(Surfaces);
 SetLength(Surfaces, Result + 1);

 Surfaces[Result]:= Surface
end;

//---------------------------------------------------------------------------
function TSystemSurfaces.Add(Width, Height: Integer): Integer;
var
 Index: Integer;
begin
 Index:= Length(Surfaces);
 SetLength(Surfaces, Index + 1);

 Surfaces[Index]:= TSystemSurface.Create();
 Surfaces[Index].SetSize(Width, Height);

 Result:= Index;
end;

//---------------------------------------------------------------------------
procedure TSystemSurfaces.Add(Amount, Width, Height: Integer);
var
 Index, i: Integer;
begin
 Index:= Length(Surfaces);
 SetLength(Surfaces, Index + Amount);

 for i:= 0 to Amount - 1 do
  begin
   Surfaces[Index + i]:= TSystemSurface.Create();
   Surfaces[Index + i].SetSize(Width, Height);
  end;
end;

//---------------------------------------------------------------------------
function TSystemSurfaces.AddFromASDb(const Key: string; ASDb: TASDb): Integer;
var
 Surface: TSystemSurface;
begin
 Surface:= TSystemSurface.Create();
 Surface.Name:= ExtractPureKey(Key);

 if (not Surface.LoadFromASDb(Key, ASDb)) then
  begin
   Surface.Free();
   Result:= -1;
   Exit;
  end;



 Result:= Insert(Surface);
end;

//---------------------------------------------------------------------------
procedure TSystemSurfaces.RemoveAll();
var
 i: Integer;
begin
 for i:= 0 to Length(Surfaces) - 1 do
  if (Surfaces[i] <> nil) then
   begin
    Surfaces[i].Free();
    Surfaces[i]:= nil;
   end;

 SetLength(Surfaces, 0);
end;

//---------------------------------------------------------------------------
function TSystemSurfaces.IndexOf(const ImageName: string): Integer;
var
 i: Integer;
begin
 Result:= -1;

 for i:= 0 to Length(Surfaces) - 1 do
  if (CompareText(ImageName, Surfaces[i].Name) = 0) then
   begin
    Result:= i;
    Break;
   end;
end;

//---------------------------------------------------------------------------
end.
