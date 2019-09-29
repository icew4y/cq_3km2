unit AsphyreTextureFonts;

interface
//---------------------------------------------------------------------------
uses
  Windows, Types, Classes, SysUtils, 
  Math, AbstractTextures, 
  AsphyreTypes, AsphyreUtils, AbstractCanvas, AsphyreFactory, AbstractDevices,
  Graphics, uMyDxUnit;
type
  TAsphyreFontTexture = class
  private
    FTexture: TAsphyreLockableTexture;
    FText: string;
    FStyle: TFontStyles;
    FOutTimeTick: LongWord;
    FOutTimeTime: LongWord;
  public
    constructor Create();
    destructor Destroy; override;
    property Texture: TAsphyreLockableTexture read FTexture write FTexture;
    property Text: string read FText write FText;
    property Style: TFontStyles read FStyle write FStyle;
    property OutTimeTick: LongWord read FOutTimeTick write FOutTimeTick;
    property OutTimeTime: LongWord read FOutTimeTime write FOutTimeTime;
  end;

  TAsphyreFontTextures = class
  private
    FList: TList;
    FOutTimeTick: LongWord;
    FOutTimeTime: LongWord;
    function GetTexture(Index: Integer): TAsphyreFontTexture;
    function GetTextureCount(): Integer;
  public
    constructor Create();
    destructor Destroy; override;
    procedure FreeIdleMemory;
    procedure Clear;
    procedure Add(Texture: TAsphyreFontTexture);
    property Textures[Index: Integer]: TAsphyreFontTexture read GetTexture;
    property TextureCount: Integer read GetTextureCount;
    property OutTimeTick: LongWord read FOutTimeTick write FOutTimeTick;
    property OutTimeTime: LongWord read FOutTimeTime write FOutTimeTime;
  end;

  TFontManager = class;
  TAsphyreTextureFont = class(TFont)
  private
    FOwner: TFontManager;
    FFontWidth: Integer;
    FFontHeight: Integer;
    FFontWidthBold: Integer;

    FDoubleFontWidth: Integer;
    FDoubleFontHeight: Integer;
    FDoubleFontWidthBold: Integer;
    FTimeOutIdx: Integer;

    FFontTextures: TAsphyreFontTextures;


    procedure NewBitmapFile(const AWidth, AHeight, ABitCount: Integer; var FileData: Pointer; var FileSize: Integer);
    procedure GetFontSize;

    function GetFontTexture(
      const Text: string;
      FontStyles: TFontStyles = []): TAsphyreLockableTexture;
  public
    nIndex: Integer;
    constructor Create(AOwner: TFontManager);
    destructor Destroy; override;
    procedure FreeIdleMemory;
    procedure Initialize;
    procedure Finalize;
    function GetTextTexture(const Text: string; FontStyles: TFontStyles = []): TAsphyreLockableTexture;
    function TextHeight(const Text: string): Integer;
    function TextWidth(const Text: string): Integer;
    procedure BoldTextOut(X, Y: Integer;
      const Text: string;
      FColor: TColor; BColor: TColor = clBlack;
      FontStyles: TFontStyles = []);overload;

    procedure BoldTextOut(X, Y: Integer;
      FColor: TColor; BColor: TColor;
      const Text: string;
      FontStyles: TFontStyles = []);overload;

    procedure BoldTextOutAlpha(X, Y: Integer;
      FColor: TColor; BColor: TColor;
      const Text: string;
      btAlpha: Byte;
      FontStyles: TFontStyles = []);overload;

    procedure TextOut(X, Y: Integer;
      FColor: TColor;
      const Text: string;
      FontStyles: TFontStyles = []); overload;

    procedure TextOutAlpha(X, Y: Integer;
      const Text: string;
      FColor: TColor;
      btAlpha: Byte;
      FontStyles: TFontStyles = []); overload;

    procedure TextOut(X, Y: Integer;
      const Text: string;
      FColor: TColor = clWhite;
      FontStyles: TFontStyles = []); overload;

    procedure TextOut(X, Y: Integer;
      const Text: string;
      FColor: TColor;
      BColor: TColor;
      FontStyles: TFontStyles = []); overload;

    procedure TextRect(Dest, Rect: TRect;
      X, Y: Integer;
      const Text: string;
      FColor: TColor = clWhite;
      FontStyle: TFontStyles = []); overload;
  end;

  TFontManager = class
  private
    Fonts: array of TAsphyreTextureFont;
    FD3DFormat: Boolean;
    FFontSize: Integer;
    FFontName: TFontName;
  public
    constructor Create();
    destructor Destroy; override;
    procedure FreeIdleMemory;
    procedure Initialize;
    procedure Finalize;
    procedure RemoveAll();
    procedure Add(FontName: TFontName = '宋体'; FontSize: Integer = 9);
    procedure SetFont(FontName: TFontName; FontSize: Integer);
    //property Canvas: TAsphyreCanvas read FCanvas write FCanvas;
    property D3DFormat: Boolean read FD3DFormat write FD3DFormat;
    property FontSize: Integer read FFontSize;
    property FontName: TFontName read FFontName;

  end;
var
  AspTextureFont: TAsphyreTextureFont = nil;
  FontManager: TFontManager = nil;

implementation

constructor TAsphyreFontTexture.Create();
begin
  inherited;
  FTexture := nil;
  FText := '';
  FStyle := [];
  FOutTimeTick := GetTickCount;
  FOutTimeTime := 1000 * 60 * 1;
end;

destructor TAsphyreFontTexture.Destroy;
begin
  if FTexture <> nil then
    FreeAndNil(FTexture);
  inherited;
end;
{-------------------------------------------------------------------------------}

constructor TAsphyreFontTextures.Create();
begin
  inherited;
  FList := TList.Create;
  FOutTimeTick := GetTickCount;
  FOutTimeTime := 1000 * 20;
end;

destructor TAsphyreFontTextures.Destroy;
var
  I: Integer;
  Texture: TAsphyreFontTexture;
begin
  for I := 0 to FList.Count - 1 do begin
    Texture := FList.Items[I];
    FreeAndNil(Texture);
  end;
  FList.Free;
  inherited;
end;

procedure TAsphyreFontTextures.Add(Texture: TAsphyreFontTexture);
begin
  FList.Add(Texture);
end;

procedure TAsphyreFontTextures.Clear;
var
  I: Integer;
  Texture: TAsphyreFontTexture;
begin
  for I := 0 to FList.Count - 1 do begin
    Texture := FList.Items[I];
    FreeAndNil(Texture);
  end;
  FList.Clear;
end;

procedure TAsphyreFontTextures.FreeIdleMemory;
var
  I: Integer;
  Texture: TAsphyreFontTexture;
begin
  if GetTickCount - FOutTimeTick > FOutTimeTime then begin
    FOutTimeTick := GetTickCount;
    for I := FList.Count - 1 downto 0 do begin
      Texture := FList.Items[I];
      if GetTickCount - Texture.OutTimeTick > Texture.OutTimeTime then begin
        FreeAndNil(Texture);
        FList.Delete(I);
      end;
    end;
  end;
end;

function TAsphyreFontTextures.GetTexture(Index: Integer): TAsphyreFontTexture;
begin
  if (Index >= 0) and (Index < FList.Count) then
    Result := FList.Items[Index] else Result := nil;
end;

function TAsphyreFontTextures.GetTextureCount(): Integer;
begin
  Result := FList.Count;
end;


{------------------------------TAsphyreTextureFont------------------------------}

constructor TAsphyreTextureFont.Create(AOwner: TFontManager);
begin
  inherited Create;
  FOwner := AOwner;
  Name := '宋体';
  Size := 9;
  Charset := GB2312_CHARSET;
  Style := [];
  FFontWidth := 6;
  FFontHeight := 12;
  FFontWidthBold := 7;

  FDoubleFontWidth := 12;
  FDoubleFontHeight := 12;
  FDoubleFontWidthBold := 13;

  FFontTextures := TAsphyreFontTextures.Create;
  FTimeOutIdx := 0;
end;

destructor TAsphyreTextureFont.Destroy;
begin
  FFontTextures.Free;
  inherited;
end;

procedure TAsphyreTextureFont.BoldTextOut(X, Y: Integer; const Text: string;
  FColor, BColor: TColor; FontStyles: TFontStyles);
begin
  AspTextureFont.TextOut(X - 1, Y, Text, BColor, FontStyles);
  AspTextureFont.TextOut(X + 1, Y, Text, BColor, FontStyles);
  AspTextureFont.TextOut(X, Y - 1, Text, BColor, FontStyles);
  AspTextureFont.TextOut(X, Y + 1, Text, BColor, FontStyles);
  AspTextureFont.TextOut(X, Y, Text, FColor,  FontStyles);
end;

procedure TAsphyreTextureFont.BoldTextOut(X, Y: Integer; FColor, BColor: TColor;
  const Text: string; FontStyles: TFontStyles);
begin
  BoldTextOut(x, y, Text, FColor, BColor, FontStyles);
end;

procedure TAsphyreTextureFont.BoldTextOutAlpha(X, Y: Integer; FColor, BColor: TColor;
  const Text: string; btAlpha: Byte; FontStyles: TFontStyles);
begin
  AspTextureFont.TextOutAlpha(X - 1, Y, Text, BColor, btAlpha, FontStyles);
  AspTextureFont.TextOutAlpha(X + 1, Y, Text, BColor, btAlpha, FontStyles);
  AspTextureFont.TextOutAlpha(X, Y - 1, Text, BColor, btAlpha, FontStyles);
  AspTextureFont.TextOutAlpha(X, Y + 1, Text, BColor, btAlpha, FontStyles);
  AspTextureFont.TextOutAlpha(X, Y, Text, FColor, btAlpha, FontStyles);
end;

procedure TAsphyreTextureFont.GetFontSize;
var
  //TextMetric: TTextMetric;
  BitmapInfo: TBitmapInfo;
  HHBitmap: HBitmap;
  HHDC: HDC;
  TextSize: TSize;
  OldStyle: TFontStyles;
begin
  OldStyle := Style;
  Style := [];
  HHDC := CreateCompatibleDC(0);

  SelectObject(HHDC, Handle);

  Windows.GetTextExtentPoint32W(HHDC, '0', 1, TextSize);
  FFontWidth := abs(TextSize.cx);
  FFontHeight := abs(TextSize.cy);

  Windows.GetTextExtentPoint32W(HHDC, '一', 1, TextSize);
  FDoubleFontWidth := abs(TextSize.cx);
  FDoubleFontHeight := abs(TextSize.cy);

  DeleteDC(HHDC);

  Style := [fsBold];
  HHDC := CreateCompatibleDC(0);

  SelectObject(HHDC, Handle);

  Windows.GetTextExtentPoint32W(HHDC, '0', 1, TextSize);
  FFontWidthBold := abs(TextSize.cx);

  Windows.GetTextExtentPoint32W(HHDC, '一', 1, TextSize);
  FDoubleFontWidthBold := abs(TextSize.cx);
  Style := OldStyle;
end;

function TAsphyreTextureFont.GetTextTexture(const Text: string;
  FontStyles: TFontStyles): TAsphyreLockableTexture;
begin
  Result := GetFontTexture(Text, FontStyles);
end;

procedure TAsphyreTextureFont.NewBitmapFile(const AWidth, AHeight, ABitCount: Integer; var FileData: Pointer; var FileSize: Integer);
var
  FileHeader: PBitmapFileHeader;
  InfoHeader: PBitmapInfoHeader;

  Buffer: Pointer;
begin
  FileSize := SizeOf(TBitmapFileHeader) + SizeOf(TBitmapInfoHeader) + AWidth * AHeight * (ABitCount div 8);

  FileData := AllocMem(FileSize);

  // 位图文件头
  Buffer := FileData;
  FileHeader := PBitmapFileHeader(Buffer);
  FileHeader.bfType := 19778; //MakeWord(Ord('B'), Ord('M'));
  FileHeader.bfSize := FileSize; //SizeOf(TBitmapFileHeader) + SizeOf(TBitmapInfoHeader) + AWidth * AHeight * (ABitCount div 8);
  FileHeader.bfOffBits := FileHeader.bfSize - AWidth * AHeight * (ABitCount div 8);
  FileHeader.bfReserved1 := 0;
  FileHeader.bfReserved2 := 0;

  Buffer := Pointer(Integer(Buffer) + SizeOf(TBitmapFileHeader));

  // 位图信息头
  InfoHeader := PBitmapInfoHeader(Buffer);
  InfoHeader.biSize := SizeOf(TBitmapInfoHeader);
  InfoHeader.biWidth := AWidth;
  InfoHeader.biHeight := -AHeight;
  InfoHeader.biPlanes := 1;
  InfoHeader.biBitCount := ABitCount;

  InfoHeader.biCompression := BI_RGB; //BI_RGB;
  InfoHeader.biSizeImage := AWidth * AHeight * (ABitCount div 8);
  InfoHeader.biXPelsPerMeter := 0;
  InfoHeader.biYPelsPerMeter := 0;
  InfoHeader.biClrUsed := 0;
  InfoHeader.biClrImportant := 0;
end;

function TAsphyreTextureFont.GetFontTexture(
  const Text: string;
  FontStyles: TFontStyles = []): TAsphyreLockableTexture;
var
  I, II, III, nWidth, nHeight, X, Y: Integer;
  Texture: TAsphyreFontTexture;
  PBitmapBits: PIntegerArray;
  //TextMetric: TTextMetric;
  BitmapInfo: TBitmapInfo;
  HHBitmap: HBitmap;
  HHDC: HDC;
  OldStyle: TFontStyles;
  FontTexture: TAsphyreFontTexture;

  ACol, ARow: Integer;
  P: PInteger;
  Bits: Pointer;
  Pitch: Integer;
  DesPitch: Integer;
  SrcP: Pointer;
  DesP: Pointer;
  Pix: Cardinal;
  RGBQuad: PRGBQuad;

  TextList: TStringList;

  FileHeader: PBitmapFileHeader;
  InfoHeader: PBitmapInfoHeader;

  Buffer: Pointer;

  FileData: Pointer;
  FileSize: Integer;
begin
  Result := nil;
  if Text = '' then Exit;
  for I := 0 to FFontTextures.TextureCount - 1 do begin
    FontTexture := FFontTextures.Textures[I];
    if (FontTexture.Style = FontStyles) and
      (CompareStr(FontTexture.Text, Text) = 0) then begin
      FontTexture.OutTimeTick := GetTickCount;
      Result := FontTexture.Texture;
      Exit;
    end;
  end;

  OldStyle := Style;
  Style := FontStyles;

  TextList := TStringList.Create;
  TextList.Text := Text;

  nWidth := 0;
  nHeight := 0;
  for I := 0 to TextList.Count - 1 do begin
    nWidth := Max2(nWidth, TextWidth(TextList.Strings[I]));
  end;
  nHeight := TextHeight('pP') * TextList.Count;

  FillChar(BitmapInfo, SizeOf(BitmapInfo), 0);
  with BitmapInfo.bmiHeader do begin
  //位图信息头
    biSize := SizeOf(BitmapInfo.bmiHeader);
    biWidth := nWidth;
    biHeight := -nHeight;
    biPlanes := 1;
    biBitCount := 32;
    biCompression := BI_RGB;
    biSizeImage := 0;
    biXPelsPerMeter := 0;
    biYPelsPerMeter := 0;
    biClrUsed := 0;
    biClrImportant := 0;
  end;

  HHDC := CreateCompatibleDC(0);
  HHBitmap := CreateDIBSection(HHDC, BitmapInfo, DIB_RGB_COLORS, Pointer(PBitmapBits), 0, 0);

  SelectObject(HHDC, Handle);
  SelectObject(HHDC, HHBitmap);

  SetTextColor(HHDC, RGB(255, 255, 255)); //设文字颜色为白色
  SetBkColor(HHDC, RGB(0, 0, 0)); //设背景颜色为黑色

  Y := 0;
  for I := 0 to TextList.Count - 1 do begin
    Windows.TextOut(HHDC, 0, Y, PChar(TextList.Strings[I]), Length(TextList.Strings[I]));
    Inc(Y, TextHeight('pP'));
  end;
  TextList.Free;
  {//为什么是黑色??? DrawColor无效? By TasNat at: 2012-06-19 11:03:17
  Texture := TAsphyreFontTexture.Create;
  Texture.Text := Text;
  Texture.Style := FontStyles;
  Texture.Texture := Factory.CreateLockableTexture;
  if Texture.Texture <> nil then begin
    Texture.Texture.Mipmapping := False;
    //Texture.Texture.DynamicTexture := True;
    Texture.Texture.Format := apf_A1R5G5B5;
    Texture.Texture.SetSize(nWidth, nHeight, True);
    Texture.Texture.Lock(Bounds(0, 0,nWidth, nHeight), Bits, DesPitch);
    Pitch := nWidth * 4;
    for Y := 0 to nHeight - 1 do begin
      RGBQuad := Pointer(Integer(Pointer(PBitmapBits)) + Y * Pitch);
      DesP := PCardinal(Integer(Bits) + Y * DesPitch);
      for X := 0 to nWidth - 1 do begin
        if Cardinal(RGBQuad^) > 0 then
          Pix := $FFFFFFFF
        else
          Pix := 0;
        pByte(DesP)^ := Pix;
        Inc(RGBQuad);
        Inc(pByte(DesP),2);
      end;
    end;
    Texture.Texture.Unlock;
    FFontTextures.Add(Texture);
    Result := Texture.Texture;
  end else FreeAndNil(Texture);
  Exit; }

  NewBitmapFile(nWidth, nHeight, 32, FileData, FileSize);

    Bits := Pointer(Integer(FileData) + SizeOf(TBitmapFileHeader) + SizeOf(TBitmapInfoHeader));
    Pitch := nWidth * 4;

    for Y := 0 to nHeight - 1 do begin
      RGBQuad := Pointer(Integer(Pointer(PBitmapBits)) + Y * Pitch);
      DesP := PCardinal(Integer(Bits) + Y * Pitch);
      for X := 0 to nWidth - 1 do begin
        Pix := Cardinal(RGBQuad^);
        if Pix > 0 then begin
          Pix := $FFFFFFFF;
          //Pix := Pix or $FF000000;
        //end else begin
          //Pix := $000000FF;
        end;
        PCardinal(DesP)^ := Pix;
        Inc(RGBQuad);
        Inc(PCardinal(DesP));
      end;
    end;
 // end;

  Texture := TAsphyreFontTexture.Create;
  Texture.Text := Text;
  Texture.Style := FontStyles;
  Texture.Texture := Factory.CreateLockableTexture;
  if Texture.Texture <> nil then begin
    Texture.Texture.Mipmapping := False;
    Texture.Texture.SetSize(nWidth, nHeight, False);
    if not Texture.Texture.LoadFromData(FileData, FileSize, 32) then begin
      FreeAndNil(Texture);
    end else begin
      FFontTextures.Add(Texture);
      Result := Texture.Texture;
    end;
  end else begin
    FreeAndNil(Texture);
  end;
  FreeMem(FileData);

  DeleteObject(HHBitmap);
  DeleteDC(HHDC);
  Style := OldStyle;
end;


procedure TAsphyreTextureFont.TextOut(X, Y: Integer;
  const Text: string;
  FColor: TColor; // Cardinal;
  FontStyles: TFontStyles);
var
  Texture: TAsphyreLockableTexture;
begin
  if Text = '' then Exit;
  Texture := GetFontTexture(Text, FontStyles);
  if Texture = nil then Exit;
  GameCanvas.DrawColor(X, Y, Texture.ClientRect, Texture, FColor); //DisplaceRB(FColor)  ,deSrcAlphaAdd deSrcAlphaAdd or $FF000000
end;

procedure TAsphyreTextureFont.TextOut(X, Y: Integer;
  const Text: string;
  FColor: TColor; // Cardinal;
  BColor: TColor; // Cardinal;
  FontStyles: TFontStyles);
var
  Texture: TAsphyreLockableTexture;
begin
  if Text = '' then Exit;
  Texture := GetFontTexture(Text, FontStyles);
  if Texture = nil then Exit;
  GameCanvas.FillRect(Bounds(X, Y, Texture.Width, Texture.Height), cColor4(cColor1(BColor))); //Color4(DisplaceRB(BColor))
  GameCanvas.DrawColor(X, Y, Texture.ClientRect, Texture, FColor); //DisplaceRB(FColor)  ,deSrcAlphaAdd deSrcAlphaAdd or $FF000000
end;

procedure TAsphyreTextureFont.TextOutAlpha(X, Y: Integer; const Text: string;
  FColor: TColor; btAlpha: Byte; FontStyles: TFontStyles);
var
  Texture: TAsphyreLockableTexture;
begin
  if Text = '' then Exit;
  Texture := GetFontTexture(Text, FontStyles);
  if Texture = nil then Exit;
  GameCanvas.DrawColorAlpha(X, Y, Texture.ClientRect, Texture, FColor, True, btAlpha);
end;

procedure TAsphyreTextureFont.TextOut(X, Y: Integer; FColor: TColor;
  const Text: string; FontStyles: TFontStyles);
begin
  TextOut(x, y, Text, FColor, FontStyles);
end;


procedure TAsphyreTextureFont.TextRect(Dest, Rect: TRect;
  X, Y: Integer;
  const Text: string;
  FColor: TColor = clWhite;
  FontStyle: TFontStyles = []);
var
  SourceRect: TRect;
  Texture: TAsphyreLockableTexture;
begin
  if Text = '' then Exit;
  Texture := GetFontTexture(Text, FontStyle);
  if Texture = nil then Exit;
  SourceRect := GameCanvas.ClientRect;

  GameCanvas.ClientRect := Dest;
  GameCanvas.DrawColor(X, Y, Rect, Texture, FColor);
  GameCanvas.ClientRect := SourceRect;
  {
  SourceRect := Bounds(Rect.Left - X, Rect.Top - Y, Rect.Right - Rect.Left, Rect.Bottom - Rect.Top);
  if ClipRect(SourceRect, Texture.ClientRect) then begin
    Canvas.DrawColor(X, Y, SourceRect, Texture, FColor);
  end;}
end;

procedure TAsphyreTextureFont.FreeIdleMemory;
begin
  FFontTextures.FreeIdleMemory;
end;

procedure TAsphyreTextureFont.Initialize;
begin
  GetFontSize;
end;

procedure TAsphyreTextureFont.Finalize;
begin
  FFontTextures.Clear;
end;

function TAsphyreTextureFont.TextHeight(const Text: string): Integer;
var
  sText: WideString;
begin
  sText := Text;
  if Length(Text) = Length(sText) then begin
    Result := FFontHeight;
  end else begin
    Result := Max(FFontHeight, FDoubleFontHeight);
  end;
end;

function TAsphyreTextureFont.TextWidth(const Text: string): Integer;
var
  nCount, nsCount, nwCount: Integer;
  sText: WideString;
begin
  sText := Text;
  nsCount := Length(Text);
  nwCount := Length(sText);
  if nsCount = nwCount then begin
    if fsBold in Style then
      Result := FFontWidthBold * Length(Text)
    else
      Result := FFontWidth * Length(Text);
  end else begin
    nCount := nsCount - nwCount; //双字节字符数
    if fsBold in Style then
      Result := FDoubleFontWidthBold * nCount + (nwCount - nCount) * FFontWidthBold
    else
      Result := FDoubleFontWidth * nCount + (nwCount - nCount) * FFontWidth;
  end;
end;
//---------------------------------------------------------------------------

constructor TFontManager.Create();
begin
  inherited;
  FD3DFormat := False;
  FFontSize := 9;
  FFontName := '宋体';
  Add();
end;

//---------------------------------------------------------------------------

destructor TFontManager.Destroy();
begin
  RemoveAll();

  inherited;
end;

//---------------------------------------------------------------------------

procedure TFontManager.RemoveAll();
var
  I: Integer;
begin
  for I := 0 to Length(Fonts) - 1 do
    if (Fonts[i] <> nil) then
      FreeAndNil(Fonts[I]);

  SetLength(Fonts, 0);
end;

//---------------------------------------------------------------------------

procedure TFontManager.Add(FontName: TFontName; FontSize: Integer);
var
  nIndex: Integer;
begin
  for nIndex := 0 to Length(Fonts) - 1 do begin
    if (Fonts[nIndex].Size = FontSize) and
      (CompareText(Fonts[nIndex].Name, FontName) = 0) then Exit;
  end;
  nIndex := Length(Fonts);
  SetLength(Fonts, nIndex + 1);
  Fonts[nIndex] := TAsphyreTextureFont.Create(Self);
  Fonts[nIndex].nIndex := nIndex;
  Fonts[nIndex].Name := FontName;
  Fonts[nIndex].Size := FontSize;
  Fonts[nIndex].Initialize;
  if AspTextureFont = nil then
    AspTextureFont := Fonts[nIndex];
end;


procedure TFontManager.FreeIdleMemory;
var
  I: Integer;
begin
  for I := 0 to Length(Fonts) - 1 do
    Fonts[I].FreeIdleMemory;
end;

procedure TFontManager.Initialize;
var
  I: Integer;
begin
  for I := 0 to Length(Fonts) - 1 do
    Fonts[I].Initialize;
end;

procedure TFontManager.Finalize;
var
  I: Integer;
begin
  AspTextureFont := nil;
  for I := 0 to Length(Fonts) - 1 do
    Fonts[I].Finalize;
end;

procedure TFontManager.SetFont(FontName: TFontName; FontSize: Integer);
var
  nIndex: Integer;
begin
  if (AspTextureFont <> nil) and (AspTextureFont.Size = FontSize) and
    ((CompareText(AspTextureFont.Name, FontName) = 0) or (FontName = '')) then begin
    FFontSize := FontSize;
    FFontName := FontName;
    Exit;
  end;

  for nIndex := 0 to Length(Fonts) - 1 do begin
    if (Fonts[nIndex].Size = FontSize) and
      ((CompareText(Fonts[nIndex].Name, FontName) = 0) or (FontName = '')) then begin
      AspTextureFont := Fonts[nIndex];
      FFontSize := FontSize;
      FFontName := FontName;
      Exit;
    end;
  end;
  AspTextureFont := nil;
  if FontName = '' then FontName := '宋体';
  Add(FontName, FontSize);
  FFontSize := FontSize;
  FFontName := FontName;
end;


end.

