unit uGameTexture;

interface

uses Windows,AsphyreDIB, AspHUtil32;

procedure NewBitmapFile(const AWidth, AHeight, ABitCount: Integer; var FileData: Pointer; var FileSize: Integer; RGB565: Boolean = True);


var
  g_DefColorTable: array[0..255] of TRGBQuad;
  ColorArray: array[0..1023] of byte = (
    $00, $00, $00, $00, $00, $00, $80, $00, $00, $80, $00, $00, $00, $80, $80, $00,
    $80, $00, $00, $00, $80, $00, $80, $00, $80, $80, $00, $00, $C0, $C0, $C0, $00,
    $97, $80, $55, $00, $C8, $B9, $9D, $00, $73, $73, $7B, $00, $29, $29, $2D, $00,
    $52, $52, $5A, $00, $5A, $5A, $63, $00, $39, $39, $42, $00, $18, $18, $1D, $00,
    $10, $10, $18, $00, $18, $18, $29, $00, $08, $08, $10, $00, $71, $79, $F2, $00,
    $5F, $67, $E1, $00, $5A, $5A, $FF, $00, $31, $31, $FF, $00, $52, $5A, $D6, $00,
    $00, $10, $94, $00, $18, $29, $94, $00, $00, $08, $39, $00, $00, $10, $73, $00,
    $00, $18, $B5, $00, $52, $63, $BD, $00, $10, $18, $42, $00, $99, $AA, $FF, $00,
    $00, $10, $5A, $00, $29, $39, $73, $00, $31, $4A, $A5, $00, $73, $7B, $94, $00,
    $31, $52, $BD, $00, $10, $21, $52, $00, $18, $31, $7B, $00, $10, $18, $2D, $00,
    $31, $4A, $8C, $00, $00, $29, $94, $00, $00, $31, $BD, $00, $52, $73, $C6, $00,
    $18, $31, $6B, $00, $42, $6B, $C6, $00, $00, $4A, $CE, $00, $39, $63, $A5, $00,
    $18, $31, $5A, $00, $00, $10, $2A, $00, $00, $08, $15, $00, $00, $18, $3A, $00,
    $00, $00, $08, $00, $00, $00, $29, $00, $00, $00, $4A, $00, $00, $00, $9D, $00,
    $00, $00, $DC, $00, $00, $00, $DE, $00, $00, $00, $FB, $00, $52, $73, $9C, $00,
    $4A, $6B, $94, $00, $29, $4A, $73, $00, $18, $31, $52, $00, $18, $4A, $8C, $00,
    $11, $44, $88, $00, $00, $21, $4A, $00, $10, $18, $21, $00, $5A, $94, $D6, $00,
    $21, $6B, $C6, $00, $00, $6B, $EF, $00, $00, $77, $FF, $00, $84, $94, $A5, $00,
    $21, $31, $42, $00, $08, $10, $18, $00, $08, $18, $29, $00, $00, $10, $21, $00,
    $18, $29, $39, $00, $39, $63, $8C, $00, $10, $29, $42, $00, $18, $42, $6B, $00,
    $18, $4A, $7B, $00, $00, $4A, $94, $00, $7B, $84, $8C, $00, $5A, $63, $6B, $00,
    $39, $42, $4A, $00, $18, $21, $29, $00, $29, $39, $46, $00, $94, $A5, $B5, $00,
    $5A, $6B, $7B, $00, $94, $B1, $CE, $00, $73, $8C, $A5, $00, $5A, $73, $8C, $00,
    $73, $94, $B5, $00, $73, $A5, $D6, $00, $4A, $A5, $EF, $00, $8C, $C6, $EF, $00,
    $42, $63, $7B, $00, $39, $56, $6B, $00, $5A, $94, $BD, $00, $00, $39, $63, $00,
    $AD, $C6, $D6, $00, $29, $42, $52, $00, $18, $63, $94, $00, $AD, $D6, $EF, $00,
    $63, $8C, $A5, $00, $4A, $5A, $63, $00, $7B, $A5, $BD, $00, $18, $42, $5A, $00,
    $31, $8C, $BD, $00, $29, $31, $35, $00, $63, $84, $94, $00, $4A, $6B, $7B, $00,
    $5A, $8C, $A5, $00, $29, $4A, $5A, $00, $39, $7B, $9C, $00, $10, $31, $42, $00,
    $21, $AD, $EF, $00, $00, $10, $18, $00, $00, $21, $29, $00, $00, $6B, $9C, $00,
    $5A, $84, $94, $00, $18, $42, $52, $00, $29, $5A, $6B, $00, $21, $63, $7B, $00,
    $21, $7B, $9C, $00, $00, $A5, $DE, $00, $39, $52, $5A, $00, $10, $29, $31, $00,
    $7B, $BD, $CE, $00, $39, $5A, $63, $00, $4A, $84, $94, $00, $29, $A5, $C6, $00,
    $18, $9C, $10, $00, $4A, $8C, $42, $00, $42, $8C, $31, $00, $29, $94, $10, $00,
    $10, $18, $08, $00, $18, $18, $08, $00, $10, $29, $08, $00, $29, $42, $18, $00,
    $AD, $B5, $A5, $00, $73, $73, $6B, $00, $29, $29, $18, $00, $4A, $42, $18, $00,
    $4A, $42, $31, $00, $DE, $C6, $63, $00, $FF, $DD, $44, $00, $EF, $D6, $8C, $00,
    $39, $6B, $73, $00, $39, $DE, $F7, $00, $8C, $EF, $F7, $00, $00, $E7, $F7, $00,
    $5A, $6B, $6B, $00, $A5, $8C, $5A, $00, $EF, $B5, $39, $00, $CE, $9C, $4A, $00,
    $B5, $84, $31, $00, $6B, $52, $31, $00, $D6, $DE, $DE, $00, $B5, $BD, $BD, $00,
    $84, $8C, $8C, $00, $DE, $F7, $F7, $00, $18, $08, $00, $00, $39, $18, $08, $00,
    $29, $10, $08, $00, $00, $18, $08, $00, $00, $29, $08, $00, $A5, $52, $00, $00,
    $DE, $7B, $00, $00, $4A, $29, $10, $00, $6B, $39, $10, $00, $8C, $52, $10, $00,
    $A5, $5A, $21, $00, $5A, $31, $10, $00, $84, $42, $10, $00, $84, $52, $31, $00,
    $31, $21, $18, $00, $7B, $5A, $4A, $00, $A5, $6B, $52, $00, $63, $39, $29, $00,
    $DE, $4A, $10, $00, $21, $29, $29, $00, $39, $4A, $4A, $00, $18, $29, $29, $00,
    $29, $4A, $4A, $00, $42, $7B, $7B, $00, $4A, $9C, $9C, $00, $29, $5A, $5A, $00,
    $14, $42, $42, $00, $00, $39, $39, $00, $00, $59, $59, $00, $2C, $35, $CA, $00,
    $21, $73, $6B, $00, $00, $31, $29, $00, $10, $39, $31, $00, $18, $39, $31, $00,
    $00, $4A, $42, $00, $18, $63, $52, $00, $29, $73, $5A, $00, $18, $4A, $31, $00,
    $00, $21, $18, $00, $00, $31, $18, $00, $10, $39, $18, $00, $4A, $84, $63, $00,
    $4A, $BD, $6B, $00, $4A, $B5, $63, $00, $4A, $BD, $63, $00, $4A, $9C, $5A, $00,
    $39, $8C, $4A, $00, $4A, $C6, $63, $00, $4A, $D6, $63, $00, $4A, $84, $52, $00,
    $29, $73, $31, $00, $5A, $C6, $63, $00, $4A, $BD, $52, $00, $00, $FF, $10, $00,
    $18, $29, $18, $00, $4A, $88, $4A, $00, $4A, $E7, $4A, $00, $00, $5A, $00, $00,
    $00, $88, $00, $00, $00, $94, $00, $00, $00, $DE, $00, $00, $00, $EE, $00, $00,
    $00, $FB, $00, $00, $94, $5A, $4A, $00, $B5, $73, $63, $00, $D6, $8C, $7B, $00,
    $D6, $7B, $6B, $00, $FF, $88, $77, $00, $CE, $C6, $C6, $00, $9C, $94, $94, $00,
    $C6, $94, $9C, $00, $39, $31, $31, $00, $84, $18, $29, $00, $84, $00, $18, $00,
    $52, $42, $4A, $00, $7B, $42, $52, $00, $73, $5A, $63, $00, $F7, $B5, $CE, $00,
    $9C, $7B, $8C, $00, $CC, $22, $77, $00, $FF, $AA, $DD, $00, $2A, $B4, $F0, $00,
    $9F, $00, $DF, $00, $B3, $17, $E3, $00, $F0, $FB, $FF, $00, $A4, $A0, $A0, $00,
    $80, $80, $80, $00, $00, $00, $FF, $00, $00, $FF, $00, $00, $00, $FF, $FF, $00,
    $FF, $00, $00, $00, $FF, $00, $FF, $00, $FF, $FF, $00, $00, $FF, $FF, $FF, $00
    );
    
implementation
//防止多次分配内存 By TasNat at: 2012-08-03 15:30:17
var
  l_BMPMem : PChar;
  l_BMPSize : DWORD = 1024 *10;


procedure NewBitmapFile(const AWidth, AHeight, ABitCount: Integer; var FileData: Pointer; var FileSize: Integer; RGB565: Boolean);
var
  FileHeader: PBitmapFileHeader;
  InfoHeader: PBitmapInfoHeader;

  Buffer: Pointer;
begin
  FileSize := SizeOf(TBitmapFileHeader) + SizeOf(TBitmapInfoHeader) + AWidth * AHeight * (ABitCount div 8);
  if ABitCount = 8 then
    FileSize := FileSize + SizeOf(g_DefColorTable);
 // else
  //  if ABitCount = 16 then
  //  FileSize := FileSize + 12;
  //防止多次分配内存 By TasNat at: 2012-08-03 15:30:17
  l_BMPSize := _Max(FileSize, l_BMPSize);
  ReallocMem(l_BMPMem, l_BMPSize);
  FillChar(l_BMPMem^, l_BMPSize, 0);
  FileData := l_BMPMem;
  //GetMem(FileData, FileSize);
  // 位图文件头
  Buffer := FileData;
  FileHeader := PBitmapFileHeader(Buffer);
  FileHeader.bfType := 19778; //MakeWord(Ord('B'), Ord('M'));
  FileHeader.bfSize := FileSize; //SizeOf(TBitmapFileHeader) + SizeOf(TBitmapInfoHeader) + AWidth * AHeight * (ABitCount div 8);
  FileHeader.bfOffBits := FileHeader.bfSize - AWidth * AHeight * (ABitCount div 8);
  FileHeader.bfReserved1 := 0;
  FileHeader.bfReserved2 := 0;

  //if ABitCount = 8 then begin
   // FileHeader.bfSize := FileHeader.bfSize + SizeOf(g_DefColorTable);
   // FileHeader.bfOffBits := FileHeader.bfOffBits + SizeOf(g_DefColorTable);
  //end;

  Buffer := Pointer(Integer(Buffer) + SizeOf(TBitmapFileHeader));

  // 位图信息头
  InfoHeader := PBitmapInfoHeader(Buffer);
  InfoHeader.biSize := SizeOf(TBitmapInfoHeader);
  InfoHeader.biWidth := AWidth;
  InfoHeader.biHeight := -AHeight;
  InfoHeader.biPlanes := 1;
  InfoHeader.biBitCount := ABitCount;
  //if ABitCount = 16 then
   // InfoHeader.biCompression := BI_BITFIELDS
  //else
  InfoHeader.biCompression := BI_RGB; //BI_RGB;
  InfoHeader.biSizeImage := AWidth * AHeight * (ABitCount div 8);
  InfoHeader.biXPelsPerMeter := 0;
  InfoHeader.biYPelsPerMeter := 0;
  InfoHeader.biClrUsed := 0;
  InfoHeader.biClrImportant := 0;

  if ABitCount = 8 then begin
    Buffer := Pointer(Integer(Buffer) + SizeOf(TBitmapInfoHeader));
    Move(g_DefColorTable, Buffer^, SizeOf(g_DefColorTable));
  //end else
    {if ABitCount = 16 then begin
    Buffer := Pointer(Integer(Buffer) + SizeOf(TBitmapInfoHeader));
    if RGB565 then begin
      PInteger(Buffer)^ := $F800;
      Inc(PInteger(Buffer));
      PInteger(Buffer)^ := $07E0;
      Inc(PInteger(Buffer));
      PInteger(Buffer)^ := $001F;
      Inc(PInteger(Buffer));
    end else begin
      PInteger(Buffer)^ := $7C00;
      Inc(PInteger(Buffer));
      PInteger(Buffer)^ := $03E0;
      Inc(PInteger(Buffer));
      PInteger(Buffer)^ := $001F;
      Inc(PInteger(Buffer));
    end;}
  end;
end;

initialization
  Move(ColorArray, g_DefColorTable, SizeOf(ColorArray));
  GetMem(l_BMPMem, l_BMPSize);
finalization
  FreeMem(l_BMPMem);
end.
