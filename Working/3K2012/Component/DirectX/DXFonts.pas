unit DXFonts;

interface
//----------------------------------------------------------------------------
uses
  Windows, Types, Classes, SysUtils, Graphics, DXDef, DirectX, DXDraws, BitMapEx;
type
  TTextFont = packed record
    FontText: string;
    FontBitMap: TBitMapEx;
    Style: TFontStyles;
  end;
  pTTextFont = ^TTextFont;


  TDXFont = class
  private
    FFont: TFont;
    TextFontList: array of TTextFont;
    TextList: TStringList;

    FSize: TPoint;

    FScale: Real;

    FFontWidth: Integer;
    FSpacing: Integer;
    FFontName: string;

    dwFreeOldFontTick: LongWord;

    procedure Unlink(Index: Integer);
    function GetCount: Integer;
    function CreateTextFont(Text: string): TBitMapEx;
    procedure SetFont(Value: TFont);
    function GetFontBitMap(Text: string): TBitMapEx;
  protected

  public
    constructor Create();
    destructor Destroy; override;

    procedure Clear;

  // returns the width of the text as if it was drawn on the screen
    function TextWidth(Text: string): Integer; overload;

  // returns the height of the text as if it was drawn on the screen
    function TextHeight(Text: string): Integer; overload;

  // returns the width of the text as if it was drawn on the screen
    function TextWidth(Text: string; nSize: Integer): Integer; overload;

  // returns the height of the text as if it was drawn on the screen
    function TextHeight(Text: string; nSize: Integer): Integer; overload;


    function TextOut(BitMap: TBitMapEx; Text: string; X, Y: Integer; Rect: TRect; Color: Cardinal;
      Effect: Integer): Integer; overload;

    function TextOut(BitMap: TBitMapEx; Text: string; X, Y: Integer; Rect: TRect; Color: Cardinal): Integer; overload;

    function TextOut(BitMap: TBitMapEx; Text: string; X, Y: Integer; Rect: TRect; Color0, Color1: Cardinal;
      Effect: Integer): Integer; overload;
    function TextOut(BitMap: TBitMapEx; Text: string; X, Y: Integer; Color: Cardinal;
      Effect: Integer): Integer; overload;
    function TextOut(BitMap: TBitMapEx; Text: string; X, Y: Integer; Color0, Color1: Cardinal;
      Effect: Integer): Integer; overload;
    function TextOut(BitMap: TBitMapEx; Text: string; X, Y: Integer; Color: Cardinal): Integer; overload;


    property Font: TFont read FFont write SetFont;
    property Count: Integer read GetCount;

  // 倍数
    property Scale: Real read FScale write FScale;

  // 间距
    property Spacing: Integer read FSpacing;

    property Size: TPoint read FSize write FSize;
  end;


//---------------------------------------------------------------------------
  TDXFonts = class
  private
    FFonts: array of TDXFont;
    NameIndex: Integer;
    function GetItem(Index: Integer): TDXFont;
    function GetCount(): Integer;
  protected

  public
    property Count: Integer read GetCount;
    property Fonts[Index: Integer]: TDXFont read GetItem; default;

    constructor Create();
    destructor Destroy(); override;

    procedure Clear();
    function Add(Font: TFont): TDXFont;
    procedure Remove(Index: Integer);
  published

  end;

var
  DXFontManage: TDXFonts;
  //List: TStringList;
implementation

constructor TDXFont.Create();
begin
  FFont := TFont.Create;
  FSpacing := 0;
  FScale := 1.0;
  SetLength(TextFontList, 0);
  TextList := TStringList.Create;
  dwFreeOldFontTick := GetTickCount;
end;

//---------------------------------------------------------------------------
procedure TDXFont.SetFont(Value: TFont);
var
  HHDC: HDC;
  tm: TEXTMETRIC;
begin
  FFont.Color := Value.Color;
  FFont.Name := Value.Name;
  FFont.Size := Value.Size;
  FFont.Style := Value.Style;
  FFont.Charset := Value.Charset;
  FFont.Height := Value.Height;
 // 创建兼容DC并选入字体
  HHDC := CreateCompatibleDC(0);
  SelectObject(HHDC, FFont.Handle);
  GetTextMetrics(HHDC, tm);
  Size := Point(tm.tmAveCharWidth, tm.tmHeight);
  DeleteDC(HHDC);
  //List.Add('X:' + IntToStr(Size.X) + ' Y:' + IntToStr(Size.Y));
end;

//---------------------------------------------------------------------------
destructor TDXFont.Destroy;
begin
  Clear;
  FFont.Free;
  TextList.Free;

  inherited;
end;

//---------------------------------------------------------------------------
procedure TDXFont.Clear;
var
  I: Integer;
begin
  for I := 0 to Length(TextFontList) - 1 do begin
    TextFontList[I].FontBitMap.Free;
  end;
  SetLength(TextFontList, 0);
  for I := 0 to TextList.Count - 1 do begin
    pTTextFont(TextList.Objects[I]).FontBitMap.Free;
    Dispose(pTTextFont(TextList.Objects[I]));
  end;
  TextList.Clear;
end;

//---------------------------------------------------------------------------
function TDXFont.GetCount: Integer;
begin
  Result := Length(TextFontList);
end;

//---------------------------------------------------------------------------
function TDXFont.CreateTextFont(Text: string): TBitMapEx;
var
  tm: TEXTMETRIC;
  BitmapInfo: TBitmapInfo;
  Data: Pointer;
  HHBitmap: HBitmap;
  HHDC: HDC;
begin
  Result := TBitMapEx.Create;

 // 创建兼容DC并选入字体
  HHDC := CreateCompatibleDC(0);
  SelectObject(HHDC, FFont.Handle);
  GetTextMetrics(HHDC, tm);

  Result.Width := TextWidth(Text, tm.tmAveCharWidth);
  Result.Height := TextHeight(Text, tm.tmHeight);

    //Showmessage(IntToStr(tm.tmAveCharWidth));
  with BitmapInfo.bmiHeader do begin
  // 位图信息头
    biSize := SizeOf(BitmapInfo.bmiHeader);
    biWidth := Result.Width;
    biHeight := -Result.Height;
    biPlanes := 1;
    biBitCount := 32;
    biCompression := BI_RGB;
    biSizeImage := 0;
    biXPelsPerMeter := 0;
    biYPelsPerMeter := 0;
    biClrUsed := 0;
    biClrImportant := 0;
  end;

  // 创建字符位图
  HHBitmap := CreateDIBSection(HHDC, BitmapInfo, DIB_RGB_COLORS, Data, 0, 0);
  SelectObject(HHDC, HHBitmap); // 将字符位图选入DC
  SetTextColor(HHDC, RGB(255, 255, 255)); // 设文字颜色为白色
  SetBkColor(HHDC, RGB(0, 0, 0)); // 设背景颜色为黑色
  Windows.TextOut(HHDC, 0, 0, PChar(Text), Length(Text));
  Move(Data^, Result.PBits^, Result.Width * Result.Height * 4);
  DeleteObject(HHBitmap);
  DeleteDC(HHDC);
  Result.TransparentColor := 0; //设置黑色透明
end;

procedure TDXFont.Unlink(Index: Integer);
var
  I, II: Integer;
  BitMap: TBitMapEx;
begin
  if (Index < 0) or (Index >= Count) then Exit;
  for I := Index to Length(TextFontList) - 2 do
    TextFontList[I] := TextFontList[I + 1];

  SetLength(TextFontList, Length(TextFontList) - 1);
end;

function TDXFont.GetFontBitMap(Text: string): TBitMapEx;
var
  I, II: Integer;
  BitMap: TBitMapEx;
  TextFont: pTTextFont;
  boFind: Boolean;
  sText: WideString;
  BitMapList: array of TBitMapEx;
  X: Integer;
  sFontText: string;
begin
  Result := nil;
  if Length(Text) = 0 then Exit;
  if GetTickCount - dwFreeOldFontTick > 1000 * 60 then begin //释放不使用字体
    dwFreeOldFontTick := GetTickCount;
    for I := TextList.Count - 1 downto 0 do begin
      TextFont := pTTextFont(TextList.Objects[I]);
      sFontText := TextFont.FontText;
      if (CompareText(sFontText, Text) <> 0) and (GetTickCount - TextFont.FontBitMap.LastTimeTick > 1000 * 60 * 2) then begin
        TextFont.FontBitMap.Free;
        Dispose(TextFont);
        TextList.Delete(I);
      end;
    end;
    I := 0;
    while True do begin
      if I >= Count then Break;
      if GetTickCount - TextFontList[I].FontBitMap.LastTimeTick > 1000 * 60 * 2 then begin
        BitMap := TextFontList[I].FontBitMap;
        Unlink(I);
        BitMap.Free;
        Continue;
      end;
      Inc(I);
    end;
  end;
//-----------------------------------------------------------------------------
  for I := 0 to TextList.Count - 1 do begin
    TextFont := pTTextFont(TextList.Objects[I]);
    sFontText := TextFont.FontText;
    if (CompareText(sFontText, Text) = 0) then begin
      TextFont.FontBitMap.LastTimeTick := GetTickCount;
      Result := TextFont.FontBitMap;
      Exit;
    end;
  end;

  sText := WideString(Text);
  SetLength(BitMapList, Length(sText));
  for I := 1 to Length(sText) do begin
    boFind := False;
    for II := 0 to Length(TextFontList) - 1 do begin
      sFontText := TextFontList[II].FontText;
      if (sFontText = sText[I]) then begin
        BitMapList[I - 1] := TextFontList[II].FontBitMap;
        BitMapList[I - 1].LastTimeTick := GetTickCount;
        boFind := True;
        Break;
      end;
    end;
    if not boFind then begin
      SetLength(TextFontList, Length(TextFontList) + 1);
      TextFontList[Length(TextFontList) - 1].FontBitMap := CreateTextFont(sText[I]);
      TextFontList[Length(TextFontList) - 1].FontText := sText[I];
      BitMapList[I - 1] := TextFontList[Length(TextFontList) - 1].FontBitMap;
      BitMapList[I - 1].LastTimeTick := GetTickCount;
    end;
  end;

  X := 0;
  New(TextFont);
  TextFont.FontText := Text;
  TextFont.FontBitMap := TBitMapEx.Create;
  TextFont.FontBitMap.Width := TextWidth(Text);
  TextFont.FontBitMap.Height := TextHeight(Text);
  TextFont.FontBitMap.LastTimeTick := GetTickCount;

  for I := 0 to Length(BitMapList) - 1 do begin
    if BitMapList[I] <> nil then begin
      TextFont.FontBitMap.Draw(BitMapList[I], X, 0, opNone);
      Inc(X, BitMapList[I].Width);
    end;
  end;
  TextList.AddObject(Text, TObject(TextFont));
  TextFont.FontBitMap.TransparentColor := 0; //设置黑色透明
  Result := TextFont.FontBitMap;
end;

//---------------------------------------------------------------------------
function TDXFont.TextOut(BitMap: TBitMapEx; Text: string; X, Y: Integer; Color: Cardinal;
  Effect: Integer): Integer;
begin
  TextOut(BitMap, Text, X, Y, Color, Color, Effect);
end;

//---------------------------------------------------------------------------
function TDXFont.TextOut(BitMap: TBitMapEx; Text: string; X, Y: Integer; Rect: TRect; Color: Cardinal;
  Effect: Integer): Integer;
begin
  TextOut(BitMap, Text, X, Y, Rect, Color, Color, Effect);
end;

//---------------------------------------------------------------------------
function TDXFont.TextOut(BitMap: TBitMapEx; Text: string; X, Y: Integer; Color0, Color1: Cardinal;
  Effect: Integer): Integer;
var
  Color: TColor4;
  FontBitMap: TBitMapEx;
begin
  if (BitMap = nil) or (Length(Text) < 1) then Exit;
  FontBitMap := GetFontBitMap(Text);
  if FontBitMap = nil then Exit;

  Effect := Effect or opSrcAlpha or opDiffuse;

  Color[0] := Color0;
  Color[1] := Color0;
  Color[3] := Color1;
  Color[2] := Color1;

  {if Scale = 1.0 then begin
    BitMap.DrawEx(FontBitMap, X, Y, Color, Effect);
  end else begin}
  BitMap.DrawEx(FontBitMap, X, Y, Scale, Color, Effect);
  //end;
end;

//---------------------------------------------------------------------------
function TDXFont.TextOut(BitMap: TBitMapEx; Text: string; X, Y: Integer; Rect: TRect; Color0, Color1: Cardinal;
  Effect: Integer): Integer;
var
  Color: TColor4;
  FontBitMap: TBitMapEx;
begin
  if (BitMap = nil) or (Length(Text) < 1) then Exit;
  FontBitMap := GetFontBitMap(Text);
  if FontBitMap = nil then Exit;

  Effect := Effect or opSrcAlpha or opDiffuse;

  Color[0] := Color0;
  Color[1] := Color0;
  Color[3] := Color1;
  Color[2] := Color1;

  {if Scale = 1.0 then begin
    BitMap.DrawEx(FontBitMap, X, Y, Rect, Color, Effect);
  end else begin}
  BitMap.DrawEx(FontBitMap, X, Y, Rect, Scale, Color, Effect);
  //end;
end;

//---------------------------------------------------------------------------
function TDXFont.TextOut(BitMap: TBitMapEx; Text: string; X, Y: Integer; Color: Cardinal): Integer;
begin
  Result := TextOut(BitMap, Text, X, Y, Color, opSrcAlpha or opDiffuse);
end;

//---------------------------------------------------------------------------
function TDXFont.TextOut(BitMap: TBitMapEx; Text: string; X, Y: Integer; Rect: TRect; Color: Cardinal): Integer;
begin
  Result := TextOut(BitMap, Text, X, Y, Rect, Color, opSrcAlpha or opDiffuse);
end;

//---------------------------------------------------------------------------
  // returns the width of the text as if it was drawn on the screen
function TDXFont.TextWidth(Text: string): Integer;
begin
  Result := 0;
  if (Length(Text) < 1) then Exit;
  Result := Length(Text) * Size.X;
end;

//---------------------------------------------------------------------------
  // returns the height of the text as if it was drawn on the screen
function TDXFont.TextHeight(Text: string): Integer;
begin
  Result := 0;
  if (Length(Text) < 1) then Exit;
  Result := Size.Y;
end;

  // returns the width of the text as if it was drawn on the screen
function TDXFont.TextWidth(Text: string; nSize: Integer): Integer;
begin
  Result := 0;
  if (Length(Text) < 1) then Exit;
  Result := Round(Length(Text) * nSize * Scale);
end;

  // returns the height of the text as if it was drawn on the screen
function TDXFont.TextHeight(Text: string; nSize: Integer): Integer;
begin
  Result := 0;
  if (Length(Text) < 1) then Exit;
  Result := Round(nSize * Scale);
end;

//---------------------------------------------------------------------------
constructor TDXFonts.Create();
begin
  SetLength(FFonts, 0);
end;

//---------------------------------------------------------------------------
destructor TDXFonts.Destroy();
begin
  Clear();

  inherited;
end;
//---------------------------------------------------------------------------
function TDXFonts.GetCount(): Integer;
begin
  Result := Length(FFonts);
end;

//---------------------------------------------------------------------------
function TDXFonts.GetItem(Index: Integer): TDXFont;
begin
  Result := nil;
  if (Index >= 0) and (Index < Length(FFonts)) then Result := FFonts[Index];
end;

//---------------------------------------------------------------------------
procedure TDXFonts.Clear();
var
  I: Integer;
begin
  for I := 0 to Length(FFonts) - 1 do
    if (Assigned(FFonts[I])) then
    begin
      FFonts[I].Free();
      FFonts[I] := nil;
    end;

  SetLength(FFonts, 0);
end;

//---------------------------------------------------------------------------
function TDXFonts.Add(Font: TFont): TDXFont;
var
  Index: Integer;
begin
  Index := Length(FFonts);
  SetLength(FFonts, Index + 1);

  FFonts[Index] := TDXFont.Create();
  FFonts[Index].Font := Font;
 //Fonts[Index].FFontIndex:= Index;

  Result := FFonts[Index];
end;

//---------------------------------------------------------------------------
procedure TDXFonts.Remove(Index: Integer);
var
  I: Integer;
begin
  if (Index < 0) or (Index >= Length(FFonts)) then Exit;

 // 1. release the font
  if (Assigned(FFonts[Index])) then
  begin
    FFonts[Index].Free();
    FFonts[Index] := nil;
  end;

 // 2. remove font from the list
  for I := Index to Length(FFonts) - 2 do
  begin
    FFonts[I] := FFonts[I + 1];
   //Fonts[i].FFontIndex:= i;
  end;

 // 3. update array size
  SetLength(FFonts, Length(FFonts) - 1);
end;



initialization
  begin
    DXFontManage := TDXFonts.Create;
    //List:=TStringList.Create;
  end;

finalization
  begin
    //List.SaveToFile('XY2.TXT');
    //List.Free;
    DXFontManage.Free;
  end;

end.

