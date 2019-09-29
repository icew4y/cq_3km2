unit uDChatMemo;

interface
uses Controls, DWinCtl, Types, Windows, Classes, DXDraws, Graphics, uDListView, uDControls, Math;

type

  TDChatMemoLines = class(TStringList)
  private
    FItemList: array of TViewItem;
    FItemHeightList: array of Integer;
    function GetItem(Index: Integer): pTViewItem;
    function GetItemHeight(Index: Integer): Integer;
    procedure SetItemHeight(Index: Integer; Value: Integer);
  protected

  public
    constructor Create;
    destructor Destroy; override;

    function AddObject(const S: string; AObject: TObject): Integer; override;
    procedure Clear; override;
    procedure Delete(Index: Integer); override;
    procedure InsertObject(Index: Integer; const S: string;
      AObject: TObject); override;

    function AddItem(const S: string; AObject: TObject): pTViewItem;

    property Items[Index: Integer]: pTViewItem read GetItem;
    property ItemHeights[Index: Integer]: Integer read GetItemHeight write SetItemHeight;
  published

  end;

  TDChatMemo = class(TDControl) //聊天框专用
  private
    Downed: Boolean;
    FShowScroll: Boolean;
    FScrollSize: Integer;
    FItemHeight: Integer;
    FItemIndex: Integer;
    FOnChange: TNotifyEvent;
    FLines: TStrings;
    FTopLines: TStrings;
    FAutoScroll: Boolean;
    FTopIndex: Integer;
    FPosition: Integer;
    FFontBackTransparent: Boolean;
    FOffSetX, FOffSetY: Integer;
    FDrawLineCount: Integer;

    FBarTop: Integer;

    FPrevMouseDown: Boolean;
    FNextMouseDown: Boolean;
    FBarMouseDown: Boolean;
    FScrollMouseDown: Boolean;
    FPrevMouseMove: Boolean;
    FNextMouseMove: Boolean;
    FBarMouseMove: Boolean;

    FScrollImageIndex: TDImageIndex;
    FPrevImageIndex: TDImageIndex;
    FNextImageIndex: TDImageIndex;
    FBarImageIndex: TDImageIndex;
    FPrevImageSize: Integer;
    FNextImageSize: Integer;
    FBarImageSize: Integer;
    FVisibleItemCount: Integer;
    FExpandSize: Integer;
    procedure ScrollImageIndexChange(Sender: TObject);
    procedure PrevImageIndexChange(Sender: TObject);
    procedure NextImageIndexChange(Sender: TObject);
    procedure BarImageIndexChange(Sender: TObject);
    procedure SetExpandSize(Value: Integer);
    procedure SetLines(Value: TStrings);
    procedure SetTopLines(Value: TStrings);
    procedure SetScrollSize(Value: Integer);
    procedure SetItemIndex(Value: Integer);
    procedure SetItemHeight(Value: Integer);
    procedure SetPosition(Value: Integer);
    function GetVisibleHeight: Integer;
    procedure SetVisibleItemCount(Value: Integer);
    function InPrevRange(X, Y: Integer): Boolean;
    function InNextRange(X, Y: Integer): Boolean;
    function InBarRange(X, Y: Integer): Boolean;
  protected
    procedure DoScroll(Value: Integer);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function MaxValue: Integer;
    procedure Next;
    procedure Previous;
    procedure First;
    procedure Last;
    procedure DirectPaint (dsurface: TDirectDrawSurface); override;
    function  MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseMove(Shift: TShiftState; X, Y: Integer): Boolean; override;
    procedure LoadFromFile(const FileName: string);
    procedure Add(const S: string; FC, BC: TColor);
    procedure Insert(Index: Integer; const S: string; FC, BC: TColor);
    procedure Delete(Index: Integer);

    procedure AddTop(const S: string; FC, BC: TColor; TimeOut: Integer);
    procedure InsertTop(Index: Integer; const S: string; FC, BC: TColor; TimeOut: Integer);
    procedure DeleteTop(Index: Integer);
    procedure DoResize();
    function KeyDown(var Key: Word; Shift: TShiftState): Boolean; override;
    procedure Clear;
    property TopIndex: Integer read FTopIndex write FTopIndex;
    property FontBackTransparent: Boolean read FFontBackTransparent write FFontBackTransparent;
    property VisibleHeight: Integer read GetVisibleHeight;
  published
    property Position: Integer read FPosition write SetPosition;
    property OffSetX: Integer read FOffSetX write FOffSetX;
    property OffSetY: Integer read FOffSetY write FOffSetY;
    property ScrollImageIndex: TDImageIndex read FScrollImageIndex write FScrollImageIndex;
    property PrevImageIndex: TDImageIndex read FPrevImageIndex write FPrevImageIndex;
    property NextImageIndex: TDImageIndex read FNextImageIndex write FNextImageIndex;
    property BarImageIndex: TDImageIndex read FBarImageIndex write FBarImageIndex;
    property ShowScroll: Boolean read FShowScroll write FShowScroll;
    property ItemHeight: Integer read FItemHeight write SetItemHeight;
    property ItemIndex: Integer read FItemIndex write SetItemIndex;
    property ScrollSize: Integer read FScrollSize write SetScrollSize;
    property Lines: TStrings read FLines write SetTopLines;
    property TopLines: TStrings read FTopLines write SetLines;
    property AutoScroll: Boolean read FAutoScroll write FAutoScroll;
    property DrawLineCount: Integer read FDrawLineCount write FDrawLineCount; //显示列表行数
    property VisibleItemCount: Integer read FVisibleItemCount write SetVisibleItemCount;
    property ExpandSize: Integer read FExpandSize write SetExpandSize;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;
procedure Register;
implementation

procedure Register;
begin
   RegisterComponents('MirGame', [TDChatMemo]);
end;
{ TDChatMemo }

procedure TDChatMemo.Add(const S: string; FC, BC: TColor);
var
  TextWidth: Integer;

  I, Len, ALine: integer;
  sText, DLine, Temp: string;

  ViewItem: pTViewItem;
begin
  if ShowScroll then
    TextWidth := GWidth - ScrollSize - MainForm.Canvas.TextWidth('0')
  else TextWidth := GWidth - MainForm.Canvas.TextWidth('0');

  sText := S;

  if MainForm.Canvas.TextWidth(sText) > TextWidth then begin
    Len := Length(sText);
    Temp := '';
    I := 1;
    while True do begin
      if I > Len then break;
      if Byte(sText[I]) >= 128 then begin
        Temp := Temp + sText[I];
        Inc(I);
        if I <= Len then Temp := Temp + sText[I]
        else break;
      end else
        Temp := Temp + sText[I];

      ALine := MainForm.Canvas.TextWidth(Temp);
      if ALine > TextWidth then begin

        ViewItem := TDChatMemoLines(FLines).AddItem(Temp, nil);
        ViewItem.Transparent := False;
        ViewItem.Caption := Temp;
        ViewItem.Color.Up.Color := FC;
        ViewItem.Color.Up.BColor := BC;
        ViewItem.Color.Up.Bold := False;
        ViewItem.Color.Hot.Assign(ViewItem.Color.Up);
        ViewItem.Color.Down.Assign(ViewItem.Color.Up);
        ViewItem.Color.Disabled.Assign(ViewItem.Color.Up);
        TDChatMemoLines(FLines).ItemHeights[FLines.Count - 1] := Max(TDChatMemoLines(FLines).ItemHeights[FLines.Count - 1], ALine);
        sText := Copy(sText, I + 1, Len - i);
        Temp := '';

        if FAutoScroll and ((FTopLines.Count + FLines.Count) * ItemHeight > VisibleHeight) then Next;
        if (Assigned(FOnChange)) then FOnChange(Self);
        break;
      end;
      Inc(I);
    end;

    if Temp <> '' then begin
      ViewItem := TDChatMemoLines(FLines).AddItem(Temp, nil);
      ViewItem.Transparent := False;
      ViewItem.Caption := Temp;
      ViewItem.Color.Up.Color := FC;
      ViewItem.Color.Up.BColor := BC;
      ViewItem.Color.Up.Bold := False;
      ViewItem.Color.Hot.Assign(ViewItem.Color.Up);
      ViewItem.Color.Down.Assign(ViewItem.Color.Up);
      ViewItem.Color.Disabled.Assign(ViewItem.Color.Up);

      TDChatMemoLines(FLines).ItemHeights[FLines.Count - 1] := Max(TDChatMemoLines(FLines).ItemHeights[FLines.Count - 1], MainForm.Canvas.TextWidth(Temp));

      sText := '';

      if FAutoScroll and ((FTopLines.Count + FLines.Count) * ItemHeight > VisibleHeight) then Next;
      if (Assigned(FOnChange)) then FOnChange(Self);
    end;

    if sText <> '' then
      Add(' ' + sText, FC, BC);
  end else begin
    ViewItem := TDChatMemoLines(FLines).AddItem(sText, nil);
    ViewItem.Transparent := False;
    ViewItem.Caption := sText;
    ViewItem.Color.Up.Color := FC;
    ViewItem.Color.Up.BColor := BC;
    ViewItem.Color.Up.Bold := False;
    ViewItem.Color.Hot.Assign(ViewItem.Color.Up);
    ViewItem.Color.Down.Assign(ViewItem.Color.Up);
    ViewItem.Color.Disabled.Assign(ViewItem.Color.Up);

    TDChatMemoLines(FLines).ItemHeights[FLines.Count - 1] := Max(TDChatMemoLines(FLines).ItemHeights[FLines.Count - 1], MainForm.Canvas.TextWidth(sText));

    if FAutoScroll and ((FTopLines.Count + FLines.Count) * ItemHeight > VisibleHeight) then Next;
    if (Assigned(FOnChange)) then FOnChange(Self);
  end;
end;

procedure TDChatMemo.AddTop(const S: string; FC, BC: TColor; TimeOut: Integer);
var
  TextWidth: Integer;

  I, Len, ALine: integer;
  sText, DLine, Temp: string;

  ViewItem: pTViewItem;
begin
  if ShowScroll then
    TextWidth := GWidth - ScrollSize - MainForm.Canvas.TextWidth('0')
  else TextWidth := GWidth - MainForm.Canvas.TextWidth('0');

  sText := S;

  if MainForm.Canvas.TextWidth(sText) > TextWidth then begin
    Len := Length(sText);
    Temp := '';
    I := 1;
    while True do begin
      if I > Len then break;
      if Byte(sText[I]) >= 128 then begin
        Temp := Temp + sText[I];
        Inc(I);
        if I <= Len then Temp := Temp + sText[I]
        else break;
      end else
        Temp := Temp + sText[I];

      ALine := MainForm.Canvas.TextWidth(Temp);
      if ALine > TextWidth then begin
        ViewItem := TDChatMemoLines(FTopLines).AddItem(Temp, nil);
        ViewItem.TimeTick := GetTickCount + TimeOut * 1000;
        ViewItem.Transparent := False;
        ViewItem.Caption := Temp;
        ViewItem.Color.Up.Color := FC;
        ViewItem.Color.Up.BColor := BC;
        ViewItem.Color.Up.Bold := False;
        ViewItem.Color.Hot.Assign(ViewItem.Color.Up);
        ViewItem.Color.Down.Assign(ViewItem.Color.Up);
        ViewItem.Color.Disabled.Assign(ViewItem.Color.Up);

        sText := Copy(sText, I + 1, Len - i);
        Temp := '';

        if FAutoScroll and ((FTopLines.Count + FLines.Count) * ItemHeight > VisibleHeight) then Next;
        if (Assigned(FOnChange)) then FOnChange(Self);
        break;
      end;
      Inc(I);
    end;

    if Temp <> '' then begin
      ViewItem := TDChatMemoLines(FTopLines).AddItem(Temp, nil);
      ViewItem.TimeTick := GetTickCount + TimeOut * 1000;
      ViewItem.Transparent := False;
      ViewItem.Caption := Temp;
      ViewItem.Color.Up.Color := FC;
      ViewItem.Color.Up.BColor := BC;
      ViewItem.Color.Up.Bold := False;
      ViewItem.Color.Hot.Assign(ViewItem.Color.Up);
      ViewItem.Color.Down.Assign(ViewItem.Color.Up);
      ViewItem.Color.Disabled.Assign(ViewItem.Color.Up);
      sText := '';
      if FAutoScroll and ((FTopLines.Count + FLines.Count) * ItemHeight > VisibleHeight) then Next;
      if (Assigned(FOnChange)) then FOnChange(Self);
    end;

    if sText <> '' then
      AddTop(' ' + sText, FC, BC, TimeOut);
  end else begin
    ViewItem := TDChatMemoLines(FTopLines).AddItem(sText, nil);
    ViewItem.TimeTick := GetTickCount + TimeOut * 1000;
    ViewItem.Transparent := False;
    ViewItem.Caption := sText;
    ViewItem.Color.Up.Color := FC;
    ViewItem.Color.Up.BColor := BC;
    ViewItem.Color.Up.Bold := False;
    ViewItem.Color.Hot.Assign(ViewItem.Color.Up);
    ViewItem.Color.Down.Assign(ViewItem.Color.Up);
    ViewItem.Color.Disabled.Assign(ViewItem.Color.Up);

    if FAutoScroll and ((FTopLines.Count + FLines.Count) * ItemHeight > VisibleHeight) then Next;
    if (Assigned(FOnChange)) then FOnChange(Self);
  end;
end;

procedure TDChatMemo.BarImageIndexChange(Sender: TObject);
var
  d: TDirectDrawSurface;
  nIndex: Integer;
begin
  if FBarImageIndex.Up >= 0 then
    nIndex := FBarImageIndex.Up
  else
    if FBarImageIndex.Hot >= 0 then
    nIndex := FBarImageIndex.Hot
  else
    if FBarImageIndex.Down >= 0 then
    nIndex := FBarImageIndex.Down;

  if (WLib <> nil) and (nIndex >= 0) then begin
    d := WLib.Images[nIndex];
    if d <> nil then
      FBarImageSize := d.Height;
  end;
end;

procedure TDChatMemo.Clear;
begin
  FLines.Clear;
  FTopLines.Clear;
  Position := 0;
end;

constructor TDChatMemo.Create(AOwner: TComponent);
begin
  inherited Create (AOwner);
  Downed := False;
  FLines := TDChatMemoLines.Create;
  FTopLines := TDChatMemoLines.Create;
  FAutoScroll := False;
  FShowScroll := True;
  FScrollSize := 16;
  FItemHeight := 12;
  FItemIndex := -1;
  FBarTop := 0;
  FOffSetX := 0;
  FOffSetY := 0;
  FPosition := 0;
  FVisibleItemCount := 1;
  FExpandSize := 0;
  FDrawLineCount := 0;
  FScrollImageIndex := TDImageIndex.Create;
  FPrevImageIndex := TDImageIndex.Create;
  FNextImageIndex := TDImageIndex.Create;
  FBarImageIndex := TDImageIndex.Create;
  
  FScrollMouseDown := False;
  FPrevMouseDown := False;
  FNextMouseDown := False;
  FBarMouseDown := False;
  FPrevMouseMove := False;
  FNextMouseMove := False;
  FBarMouseMove := False;
  
  FScrollImageIndex.OnChange := ScrollImageIndexChange;
  FPrevImageIndex.OnChange := PrevImageIndexChange;
  FNextImageIndex.OnChange := NextImageIndexChange;
  FBarImageIndex.OnChange := BarImageIndexChange;
  FDrawLineCount := 0;
end;

procedure TDChatMemo.Delete(Index: Integer);
begin
  FLines.Delete(Index);
  if FAutoScroll then Previous;
end;

procedure TDChatMemo.DeleteTop(Index: Integer);
begin
  FTopLines.Delete(Index);
  if FAutoScroll then Previous;
end;

destructor TDChatMemo.Destroy;
begin
  FLines.Free;
  FTopLines.Free;
  FScrollImageIndex.Free;
  FPrevImageIndex.Free;
  FNextImageIndex.Free;
  FBarImageIndex.Free;
  inherited Destroy;
end;

procedure TDChatMemo.DirectPaint(dsurface: TDirectDrawSurface);
var
  I, II, III, nIndex, nCount, nLeft, nTop, n01: Integer;
  FaceIndex: Integer;
  nHeight: Integer;
  nMaxValue: Integer;
  nBarTop: Integer;

  TextureRect: TDirectDrawSurface;
  Texture: TDirectDrawSurface;
  vtRect: TRect;
  vbRect: TRect;
  PaintRect: TRect;

  ListItem: TDListItem;
  ViewItem: pTViewItem;
  nLen: Integer;
  Font: TDFont;
begin
  //dsurface.FastFillRect(ClientRect, clRed);
  if Assigned (OnDirectPaint) then
    OnDirectPaint (self, dsurface)
  else begin
    n01 := 0;
    nTop := OffSetY;
    nLeft := OffSetX;

    nMaxValue := Min(VisibleHeight div ItemHeight, FDrawLineCount);

    for I := 0 to FTopLines.Count - 1 do begin
      ViewItem := TDChatMemoLines(FTopLines).Items[I];
      if WLib <> nil then begin
        FaceIndex := -1;
        if ViewItem.Style = bsButton then begin
          if ViewItem.Down then begin
            FaceIndex := ViewItem.ImageIndex.Down;
            if (FaceIndex < 0) and (ViewItem.ImageIndex.Up >= 0) then
              FaceIndex := ViewItem.ImageIndex.Up;
          end else
            if ViewItem.Move then begin
            FaceIndex := ViewItem.ImageIndex.Hot;
            if (FaceIndex < 0) and (ViewItem.ImageIndex.Up >= 0) then
              FaceIndex := ViewItem.ImageIndex.Up;
          end else
            FaceIndex := ViewItem.ImageIndex.Up;
        end else begin
          if ViewItem.Move then begin
            if ViewItem.Checked then
              FaceIndex := ViewItem.ImageIndex.Down
            else
              if ViewItem.ImageIndex.Hot >= 0 then
              FaceIndex := ViewItem.ImageIndex.Hot
            else
              FaceIndex := ViewItem.ImageIndex.Up;
          end else begin
            if ViewItem.Checked then
              FaceIndex := ViewItem.ImageIndex.Down
            else
              FaceIndex := ViewItem.ImageIndex.Up;
          end;
        end;

        if FaceIndex >= 0 then begin
          Texture := WLib.Images[FaceIndex];
          if Texture <> nil then begin
            {PaintRect.Left := vtRect.Left + nLeft;
            PaintRect.Right := PaintRect.Left + Texture.Width;
            PaintRect.Top := vtRect.Top + nTop + (ItemHeight - Texture.Height) div 2;
            PaintRect.Bottom := PaintRect.Top + Texture.Height; }
//            DrawRect(Canvas, PaintRect, vtRect, vbRect, Texture, False);
            dsurface.Draw(SurfaceX(GLeft)+ nLeft, SurfaceY(GTop)+nTop + (ItemHeight - Texture.Height) div 2, Texture.ClientRect, Texture, False);
          end;
        end;
      end;

      if ViewItem.Caption <> '' then begin
        if ViewItem.Down then begin
          Font := ViewItem.Color.Down;
        end else
          if ViewItem.Move then begin
          Font := ViewItem.Color.Hot;
        end else begin
          Font := ViewItem.Color.Up;
        end;

        if ViewItem.Style = bsButton then begin
          if ViewItem.Down then begin
            Font := ViewItem.Color.Down;
          end else
            if ViewItem.Move then begin
            Font := ViewItem.Color.Hot;
          end else
            Font := ViewItem.Color.Up;
        end else begin
          if ViewItem.Move then begin
            if ViewItem.Checked then
              Font := ViewItem.Color.Down
            else
              if ViewItem.ImageIndex.Hot >= 0 then
              Font := ViewItem.Color.Hot
            else
              Font := ViewItem.Color.Up;
          end else begin
            if ViewItem.Checked then
              Font := ViewItem.Color.Down
            else
              Font := ViewItem.Color.Up;
          end;
        end;

        //AspTextureFonts.SetFont(Font.Name, Font.Size);
        //TextureRect := AspTextureFont.GetTextTexture(ViewItem.Caption, Font.Style);
        {if TextureRect <> nil then begin
          PaintRect.Left := GLeft + nLeft;
          PaintRect.Right := PaintRect.Left + TextureRect.Width;
          PaintRect.Top := vtRect.Top + nTop + (ItemHeight - AspTextureFont.TextHeight('0')) div 2;
          PaintRect.Bottom := PaintRect.Top + TextureRect.Height;
          if Font.Bold then begin
            DrawRectColor(Canvas, ShrinkRect(PaintRect, -1, 0), vtRect, vbRect, TextureRect, Font.BColor);
            DrawRectColor(Canvas, ShrinkRect(PaintRect, 1, 0), vtRect, vbRect, TextureRect, Font.BColor);
            DrawRectColor(Canvas, ShrinkRect(PaintRect, 0, -1), vtRect, vbRect, TextureRect, Font.BColor);
            DrawRectColor(Canvas, ShrinkRect(PaintRect, 0, 1), vtRect, vbRect, TextureRect, Font.BColor);

            DrawRectColor(Canvas, PaintRect, vtRect, vbRect, TextureRect, Font.Color);
            dsurface.BoldTextOut(SurfaceX(GLeft), SurfaceY(GTop), Font.Color, Font.BColor, ViewItem.Caption);
          end else begin
            if not FontBackTransparent then
              //FillRect(Canvas, PaintRect, vtRect, vbRect, Font.BColor);
              dsurface.FastFillRect();
            DrawRectColor(Canvas, PaintRect, vtRect, vbRect, TextureRect, Font.Color);
          end;
        end; }
        if ViewItem.Caption <> '' then begin
          if Font.Bold then begin
            dsurface.BoldTextOut(SurfaceX(GLeft), SurfaceY(GTop), Font.Color, Font.BColor, ViewItem.Caption);
          end else begin
            PaintRect.Left := SurfaceX(GLeft) + nLeft;
            PaintRect.Right := PaintRect.Left + GWidth - ScrollSize;
            PaintRect.Top := SurfaceY(GTop) + nTop + (ItemHeight - MainForm.Canvas.TextHeight('0')) div 2;
            PaintRect.Bottom := PaintRect.Top + 12;
            if not FontBackTransparent then
              //FillRect(Canvas, PaintRect, vtRect, vbRect, Font.BColor);
            dsurface.FastFillRect(PaintRect, Font.BColor);
            dsurface.TextOut(PaintRect.Left, PaintRect.Top, Font.Color, ViewItem.Caption);
          end;  
        end;
      end;
      Inc(n01);
      Inc(nTop, ItemHeight);
      if n01 >= nMaxValue then break;
    end;

    nMaxValue := Min(VisibleHeight div ItemHeight, FDrawLineCount);
    nMaxValue := nMaxValue - n01;

    n01 := 0;
    if nMaxValue > 0 then begin
      for I := FTopIndex to FLines.Count - 1 do begin
        ViewItem := TDChatMemoLines(FLines).Items[I];
        if WLib <> nil then begin
          FaceIndex := -1;
          if ViewItem.Style = bsButton then begin
            if ViewItem.Down then begin
              FaceIndex := ViewItem.ImageIndex.Down;
              if (FaceIndex < 0) and (ViewItem.ImageIndex.Up >= 0) then
                FaceIndex := ViewItem.ImageIndex.Up;
            end else
              if ViewItem.Move then begin
              FaceIndex := ViewItem.ImageIndex.Hot;
              if (FaceIndex < 0) and (ViewItem.ImageIndex.Up >= 0) then
                FaceIndex := ViewItem.ImageIndex.Up;
            end else
              FaceIndex := ViewItem.ImageIndex.Up;
          end else begin
            if ViewItem.Move then begin
              if ViewItem.Checked then
                FaceIndex := ViewItem.ImageIndex.Down
              else
                if ViewItem.ImageIndex.Hot >= 0 then
                FaceIndex := ViewItem.ImageIndex.Hot
              else
                FaceIndex := ViewItem.ImageIndex.Up;
            end else begin
              if ViewItem.Checked then
                FaceIndex := ViewItem.ImageIndex.Down
              else
                FaceIndex := ViewItem.ImageIndex.Up;
            end;
          end;

          if FaceIndex >= 0 then begin
            Texture := WLib.Images[FaceIndex];
            if Texture <> nil then begin
              {PaintRect.Left := vtRect.Left + nLeft;
              PaintRect.Right := PaintRect.Left + Texture.Width;
              PaintRect.Top := vtRect.Top + nTop + (ItemHeight - Texture.Height) div 2;
              PaintRect.Bottom := PaintRect.Top + Texture.Height;    }
              //DrawRect(Canvas, PaintRect, vtRect, vbRect, Texture, False);
              dsurface.Draw(SurfaceX(GLeft)+ nLeft, SurfaceY(GTop)+nTop + (ItemHeight - Texture.Height) div 2, Texture.ClientRect, Texture, False);
            end;
          end;
        end;

        if ViewItem.Caption <> '' then begin

          if ViewItem.Down then begin
            Font := ViewItem.Color.Down;
          end else
            if ViewItem.Move then begin
            Font := ViewItem.Color.Hot;
          end else begin
            Font := ViewItem.Color.Up;
          end;

          if ViewItem.Style = bsButton then begin
            if ViewItem.Down then begin
              Font := ViewItem.Color.Down;
            end else
              if ViewItem.Move then begin
              Font := ViewItem.Color.Hot;
            end else
              Font := ViewItem.Color.Up;
          end else begin
            if ViewItem.Move then begin
              if ViewItem.Checked then
                Font := ViewItem.Color.Down
              else
                if ViewItem.ImageIndex.Hot >= 0 then
                Font := ViewItem.Color.Hot
              else
                Font := ViewItem.Color.Up;
            end else begin
              if ViewItem.Checked then
                Font := ViewItem.Color.Down
              else
                Font := ViewItem.Color.Up;
            end;
          end;

          {AspTextureFonts.SetFont(Font.Name, Font.Size);
          TextureRect := AspTextureFont.GetTextTexture(ViewItem.Caption, Font.Style);
          if TextureRect <> nil then begin
            PaintRect.Left := vtRect.Left + nLeft;
            PaintRect.Right := PaintRect.Left + TextureRect.Width;
            PaintRect.Top := vtRect.Top + nTop + (ItemHeight - AspTextureFont.TextHeight('0')) div 2;
            PaintRect.Bottom := PaintRect.Top + TextureRect.Height;
            if Font.Bold then begin
              DrawRectColor(Canvas, ShrinkRect(PaintRect, -1, 0), vtRect, vbRect, TextureRect, Font.BColor);
              DrawRectColor(Canvas, ShrinkRect(PaintRect, 1, 0), vtRect, vbRect, TextureRect, Font.BColor);
              DrawRectColor(Canvas, ShrinkRect(PaintRect, 0, -1), vtRect, vbRect, TextureRect, Font.BColor);
              DrawRectColor(Canvas, ShrinkRect(PaintRect, 0, 1), vtRect, vbRect, TextureRect, Font.BColor);

              DrawRectColor(Canvas, PaintRect, vtRect, vbRect, TextureRect, Font.Color);
            end else begin
              if not FontBackTransparent then
                FillRect(Canvas, PaintRect, vtRect, vbRect, Font.BColor);
              DrawRectColor(Canvas, PaintRect, vtRect, vbRect, TextureRect, Font.Color);
            end;
          end;   }
          if ViewItem.Caption <> '' then begin
            if Font.Bold then begin
              dsurface.BoldTextOut(SurfaceX(GLeft), SurfaceY(GTop), Font.Color, Font.BColor, ViewItem.Caption);
            end else begin
              PaintRect.Left := SurfaceX(GLeft) + nLeft;
              PaintRect.Right := PaintRect.Left + MainForm.Canvas.TextWidth(ViewItem.Caption);
              PaintRect.Top := SurfaceY(GTop) + nTop + (ItemHeight - MainForm.Canvas.TextHeight('0')) div 2;
              PaintRect.Bottom := PaintRect.Top + 12;
              if not FontBackTransparent then
                //FillRect(Canvas, PaintRect, vtRect, vbRect, Font.BColor);
              dsurface.FastFillRect(PaintRect, Font.BColor);
              dsurface.TextOut(PaintRect.Left, PaintRect.Top, Font.Color, ViewItem.Caption);
            end;
          end;
        end;

        Inc(n01);
        Inc(nTop, ItemHeight);
        if n01 >= nMaxValue then break;
      end;
    end;

    {if WLib <> nil then begin
      if ImageIndex.Up >= 0 then begin
        Texture := ImageIndex.Image.Images[ImageIndex.Up];
        if Texture <> nil then begin
          PaintRect.Left := vtRect.Left + (Width - Texture.Width) div 2;
          PaintRect.Right := PaintRect.Left + Texture.Width;
          PaintRect.Top := vtRect.Top;
          PaintRect.Bottom := PaintRect.Top + Texture.Height;
          DrawRect(Canvas, PaintRect, vtRect, vbRect, Texture, False);
        end;
      end;
    end;  }

    if FShowScroll then begin
      if (WLib <> nil) and (FScrollImageIndex.Up >= 0) then begin
        Texture := WLib.Images[FScrollImageIndex.Up];
        if Texture <> nil then begin
          nLen := GTop + GHeight;
          nTop := GTop;
          while nTop < nLen do begin
            if nTop + Texture.Height <= nLen then
              PaintRect := Texture.ClientRect
            else
              PaintRect := Bounds(0, 0, GWidth, nLen - nTop);

            dsurface.Draw(SurfaceX(GLeft) + (GWidth - Texture.Width), SurfaceY(nTop), PaintRect, Texture, True);
            Inc(nTop, Texture.Height);
          end;
        end;
      end;

      if WLib <> nil then begin
        nIndex := -1;
        if FPrevMouseDown and (FPrevImageIndex.Down >= 0) then nIndex := FPrevImageIndex.Down
        else if FPrevMouseMove and (FPrevImageIndex.Hot >= 0) then nIndex := FPrevImageIndex.Hot
        else if (FPrevImageIndex.Up >= 0) then nIndex := FPrevImageIndex.Up;
        if (nIndex >= 0) then begin
          Texture := WLib.Images[nIndex];
          if Texture <> nil then begin
            {PaintRect.Left := vtRect.Left + (Width - FScrollSize) + ((FScrollSize - Texture.Width) div 2) + 1;
            PaintRect.Right := PaintRect.Left + Texture.Width;
            PaintRect.Top := vtRect.Top + 1;
            PaintRect.Bottom := PaintRect.Top + Texture.Height;
            DrawRect(Canvas, PaintRect, vtRect, vbRect, Texture);   }
            dsurface.Draw(SurfaceX(GLeft) +(GWidth - FScrollSize) + ((FScrollSize - Texture.Width) div 2), SurfaceY(GTop), Texture.ClientRect, Texture, True);
          end;
        end;
      end;

      if WLib <> nil then begin
        nIndex := -1;
        if FNextMouseDown and (FNextImageIndex.Down >= 0) then nIndex := FNextImageIndex.Down
        else if FNextMouseMove and (FNextImageIndex.Hot >= 0) then nIndex := FNextImageIndex.Hot
        else if (FNextImageIndex.Up >= 0) then nIndex := FNextImageIndex.Up;

        if nIndex >= 0 then begin
          Texture := WLib.Images[nIndex];
          if Texture <> nil then begin
            {PaintRect.Left := vtRect.Left + (Width - FScrollSize) + ((FScrollSize - Texture.Width) div 2) + 1;
            PaintRect.Right := PaintRect.Left + Texture.Width;
            PaintRect.Top := vtRect.Top + (Height - Texture.Height - 1);
            PaintRect.Bottom := PaintRect.Top + Texture.Height;
            DrawRect(Canvas, PaintRect, vtRect, vbRect, Texture);  }
            dsurface.Draw(SurfaceX(GLeft) +(GWidth - FScrollSize) + ((FScrollSize - Texture.Width) div 2), SurfaceY(GTop)+ (GHeight - Texture.Height - 1), Texture.ClientRect, Texture, True);
          end;
        end;
      end;

      if WLib <> nil then begin
        nIndex := -1;
        if FBarMouseDown and (FBarImageIndex.Down >= 0) then nIndex := FBarImageIndex.Down
        else if FBarMouseMove and (FBarImageIndex.Hot >= 0) then nIndex := FBarImageIndex.Hot
        else if (FBarImageIndex.Up >= 0) then nIndex := FBarImageIndex.Up;

        if nIndex >= 0 then begin
          Texture := WLib.Images[nIndex];
          if Texture <> nil then begin
            {PaintRect.Left := vtRect.Left + (Width - FScrollSize) + (FScrollSize - Texture.Width) div 2 + 1;
            PaintRect.Right := PaintRect.Left + Texture.Width;
            PaintRect.Top := vtRect.Top + FPrevImageSize + FBarTop;
            PaintRect.Bottom := PaintRect.Top + Texture.Height;
            DrawRect(Canvas, PaintRect, vtRect, vbRect, Texture);    }
            dsurface.Draw(SurfaceX(GLeft) +(GWidth - FScrollSize) + (FScrollSize - Texture.Width) div 2, SurfaceY(GTop)+ FPrevImageSize + FBarTop, Texture.ClientRect, Texture, True);
          end;
        end;
      end;
    end;
  end;
end;

procedure TDChatMemo.DoResize;
var
  nMaxScrollValue: Integer;
  nMaxValue: Integer;
begin
  if FShowScroll then begin
    nMaxValue := MaxValue;
    nMaxScrollValue := GHeight - FPrevImageSize - FNextImageSize - FBarImageSize;

    if (nMaxValue > 0) and (nMaxScrollValue > 0) then
      FBarTop := Max(Round(FPosition * nMaxScrollValue / (nMaxValue - VisibleHeight)), 0)
    else
      FBarTop := 0;

    if nMaxValue > VisibleHeight then begin
      if FPosition + VisibleHeight >= nMaxValue then
        FBarTop := GHeight - FPrevImageSize - FNextImageSize - FBarImageSize
      else
        if FPosition = 0 then
        FBarTop := 0;
    end else begin
      FBarTop := 0;
      Position := 0;
    end;
  end;
end;

procedure TDChatMemo.DoScroll(Value: Integer);
begin
  FTopIndex := (Position - Value) div ItemHeight;
end;

procedure TDChatMemo.First;
var
  P: Integer;
  nMaxScrollValue: Integer;
  nMaxValue: Integer;
begin
  if FPosition > 0 then begin
    P := 0;
    DoScroll(FPosition - P);
    FPosition := P;
  end;

  if FShowScroll then begin
    nMaxValue := MaxValue;
    nMaxScrollValue := GHeight - FPrevImageSize - FNextImageSize - FBarImageSize;

    if (nMaxValue > 0) and (nMaxScrollValue > 0) then
      FBarTop := Max(Round(FPosition * nMaxScrollValue / (nMaxValue - VisibleHeight)), 0)
    else
      FBarTop := 0;

    if nMaxValue > VisibleHeight then begin
      if FPosition + VisibleHeight >= nMaxValue then
        FBarTop := nMaxScrollValue
      else
        if FPosition = 0 then
        FBarTop := 0;
    end else FBarTop := 0;
  end;
end;

function TDChatMemo.GetVisibleHeight: Integer;
begin
  Result := GHeight - OffSetY;
end;

function TDChatMemo.InBarRange(X, Y: Integer): Boolean;
var
  nHeight: Integer;
  nMaxValue: Integer;
  nBarTop: Integer;
begin
  Result := False;
  if FShowScroll then begin
    if (X >= GLeft + GWidth - FScrollSize) and (Y < {GLeft + GWidth}GTop +GHeight - FNextImageSize) and
      (Y > GTop + FPrevImageSize) then begin
      if FPosition > 0 then begin
        nMaxValue := MaxValue;
        nHeight := GHeight - FPrevImageSize - FNextImageSize - FBarImageSize;
        if (nMaxValue > 0) and (nHeight > 0) and (nMaxValue > VisibleHeight) then
          nBarTop := Round(FPosition * nHeight / (nMaxValue - VisibleHeight))
        else
          nBarTop := 0;
        Result := (Y >= GTop + FPrevImageSize + nBarTop) and (Y <= GTop + FPrevImageSize + nBarTop + FBarImageSize);
      end else begin
        Result := (Y <= GTop + FPrevImageSize + FBarImageSize);
      end;
    end;
  end;
end;

function TDChatMemo.InNextRange(X, Y: Integer): Boolean;
begin
  Result := (X >= GLeft + GWidth - FScrollSize) and (Y >= GTop + (GHeight - FNextImageSize));
end;

function TDChatMemo.InPrevRange(X, Y: Integer): Boolean;
begin
  Result := (X >= GLeft + GWidth - FScrollSize) and (Y <= GTop + FPrevImageSize);
end;

procedure TDChatMemo.Insert(Index: Integer; const S: string; FC, BC: TColor);
var
  TextWidth: Integer;

  I, Len, ALine: integer;
  sText, DLine, Temp: string;

  ViewItem: pTViewItem;
begin
  if ShowScroll then
    TextWidth := GWidth - ScrollSize - MainForm.Canvas.TextWidth('0')
  else TextWidth := GWidth - MainForm.Canvas.TextWidth('0');

  sText := S;

  if MainForm.Canvas.TextWidth(sText) > TextWidth then begin
    Len := Length(sText);
    Temp := '';
    I := 1;
    while True do begin
      if I > Len then break;
      if Byte(sText[I]) >= 128 then begin
        Temp := Temp + sText[I];
        Inc(I);
        if I <= Len then Temp := Temp + sText[I]
        else break;
      end else
        Temp := Temp + sText[I];

      ALine := MainForm.Canvas.TextWidth(Temp);
      if ALine > TextWidth then begin
        TDChatMemoLines(FLines).Insert(Index, Temp);
        ViewItem := pTViewItem(FLines.Objects[Index]);
        ViewItem.Transparent := False;
        ViewItem.Caption := Temp;
        ViewItem.Color.Up.Color := FC;
        ViewItem.Color.Up.BColor := BC;
        ViewItem.Color.Up.Bold := False;
        ViewItem.Color.Hot.Assign(ViewItem.Color.Up);
        ViewItem.Color.Down.Assign(ViewItem.Color.Up);
        ViewItem.Color.Disabled.Assign(ViewItem.Color.Up);

        sText := Copy(sText, I + 1, Len - i);
        Temp := '';

        if FAutoScroll and ((FTopLines.Count + FLines.Count) * ItemHeight > VisibleHeight) then Next;
        if (Assigned(FOnChange)) then FOnChange(Self);
        break;
      end;
      Inc(I);
    end;

    if Temp <> '' then begin
      TDChatMemoLines(FLines).Insert(Index, Temp);
      ViewItem := pTViewItem(FLines.Objects[Index]);
      ViewItem.Transparent := False;
      ViewItem.Caption := Temp;
      ViewItem.Color.Up.Color := FC;
      ViewItem.Color.Up.BColor := BC;
      ViewItem.Color.Up.Bold := False;
      ViewItem.Color.Hot.Assign(ViewItem.Color.Up);
      ViewItem.Color.Down.Assign(ViewItem.Color.Up);
      ViewItem.Color.Disabled.Assign(ViewItem.Color.Up);
      sText := '';

      if FAutoScroll and ((FTopLines.Count + FLines.Count) * ItemHeight > VisibleHeight) then Next;
      if (Assigned(FOnChange)) then FOnChange(Self);
    end;

    if sText <> '' then begin
      Inc(Index);
      Insert(Index, ' ' + sText, FC, BC);
    end;
  end else begin
    TDChatMemoLines(FLines).Insert(Index, Temp);
    ViewItem := pTViewItem(FLines.Objects[Index]);
    ViewItem.Transparent := False;
    ViewItem.Caption := sText;
    ViewItem.Color.Up.Color := FC;
    ViewItem.Color.Up.BColor := BC;
    ViewItem.Color.Up.Bold := False;
    ViewItem.Color.Hot.Assign(ViewItem.Color.Up);
    ViewItem.Color.Down.Assign(ViewItem.Color.Up);
    ViewItem.Color.Disabled.Assign(ViewItem.Color.Up);

    if FAutoScroll and ((FTopLines.Count + FLines.Count) * ItemHeight > VisibleHeight) then Next;
    if (Assigned(FOnChange)) then FOnChange(Self);
  end;
end;

procedure TDChatMemo.InsertTop(Index: Integer; const S: string; FC, BC: TColor;
  TimeOut: Integer);
var
  TextWidth: Integer;

  I, Len, ALine: integer;
  sText, DLine, Temp: string;

  ViewItem: pTViewItem;
begin
  if ShowScroll then
    TextWidth := GWidth - ScrollSize - MainForm.Canvas.TextWidth('0')
  else TextWidth := GWidth - MainForm.Canvas.TextWidth('0');

  sText := S;

  if MainForm.Canvas.TextWidth(sText) > TextWidth then begin
    Len := Length(sText);
    Temp := '';
    I := 1;
    while True do begin
      if I > Len then break;
      if Byte(sText[I]) >= 128 then begin
        Temp := Temp + sText[I];
        Inc(I);
        if I <= Len then Temp := Temp + sText[I]
        else break;
      end else
        Temp := Temp + sText[I];

      ALine := MainForm.Canvas.TextWidth(Temp);
      if ALine > TextWidth then begin
        TDChatMemoLines(FTopLines).Insert(Index, Temp);
        ViewItem := pTViewItem(FTopLines.Objects[Index]);
        ViewItem.TimeTick := GetTickCount + TimeOut * 1000;
        ViewItem.Transparent := False;
        ViewItem.Caption := Temp;
        ViewItem.Color.Up.Color := FC;
        ViewItem.Color.Up.BColor := BC;
        ViewItem.Color.Up.Bold := False;
        ViewItem.Color.Hot.Assign(ViewItem.Color.Up);
        ViewItem.Color.Down.Assign(ViewItem.Color.Up);
        ViewItem.Color.Disabled.Assign(ViewItem.Color.Up);

        sText := Copy(sText, I + 1, Len - i);
        Temp := '';

        if FAutoScroll and ((FTopLines.Count + FLines.Count) * ItemHeight > VisibleHeight) then Next;
        if (Assigned(FOnChange)) then FOnChange(Self);
        break;
      end;
      Inc(I);
    end;

    if Temp <> '' then begin
      TDChatMemoLines(FTopLines).Insert(Index, Temp);
      ViewItem := pTViewItem(FTopLines.Objects[Index]);
      //ViewItem.TimeTick := GetTickCount + TimeOut * 1000;
      ViewItem.Transparent := False;
      ViewItem.Caption := Temp;
      ViewItem.Color.Up.Color := FC;
      ViewItem.Color.Up.BColor := BC;
      ViewItem.Color.Up.Bold := False;
      ViewItem.Color.Hot.Assign(ViewItem.Color.Up);
      ViewItem.Color.Down.Assign(ViewItem.Color.Up);
      ViewItem.Color.Disabled.Assign(ViewItem.Color.Up);
      sText := '';
      if FAutoScroll and ((FTopLines.Count + FLines.Count) * ItemHeight > VisibleHeight) then Next;
      if (Assigned(FOnChange)) then FOnChange(Self);
    end;

    if sText <> '' then begin
      Inc(Index);
      InsertTop(Index, ' ' + sText, FC, BC, TimeOut);
    end;
  end else begin
    TDChatMemoLines(FTopLines).Insert(Index, Temp);
    ViewItem := pTViewItem(FTopLines.Objects[Index]);
    //ViewItem.TimeTick := GetTickCount + TimeOut * 1000;
    ViewItem.Transparent := False;
    ViewItem.Caption := sText;
    ViewItem.Color.Up.Color := FC;
    ViewItem.Color.Up.BColor := BC;
    ViewItem.Color.Up.Bold := False;
    ViewItem.Color.Hot.Assign(ViewItem.Color.Up);
    ViewItem.Color.Down.Assign(ViewItem.Color.Up);
    ViewItem.Color.Disabled.Assign(ViewItem.Color.Up);

    if FAutoScroll and ((FTopLines.Count + FLines.Count) * ItemHeight > VisibleHeight) then Next;
    if (Assigned(FOnChange)) then FOnChange(Self);
  end;
end;

function TDChatMemo.KeyDown(var Key: Word; Shift: TShiftState): Boolean;
begin
  Result := False;
  if inherited KeyDown(Key, Shift) then begin
    Result := True;
    case Key of
      VK_UP: Previous;
      VK_DOWN: Next;
      VK_PRIOR: if Position >= GHeight then Position := Position - GHeight else Position := 0;
      VK_NEXT: if Position + GHeight < MaxValue then Position := Position + GHeight else Position := MaxValue;
    end;
  end;
end;

procedure TDChatMemo.Last;
var
  P: Integer;
  nMaxScrollValue: Integer;
  nMaxValue: Integer;
  nPosition: Integer;
begin
  nMaxValue := MaxValue;
  if (nMaxValue > 0) and (nMaxValue > VisibleHeight) then begin
    if FPosition + VisibleHeight < nMaxValue then begin
      P := nMaxValue - VisibleHeight;
      DoScroll(FPosition - P);
      FPosition := P;
    end;
  end else begin
    if FPosition > 0 then begin
      P := 0;
      DoScroll(FPosition - P);
      FPosition := P;
    end;
  end;

  if FShowScroll then begin
    nMaxScrollValue := GHeight - FPrevImageSize - FNextImageSize - FBarImageSize;

    if (nMaxValue > 0) and (nMaxScrollValue > 0) then
      FBarTop := Max(Round(FPosition * nMaxScrollValue / (nMaxValue - VisibleHeight)), 0)
    else
      FBarTop := 0;

    if nMaxValue > VisibleHeight then begin
      if FPosition + VisibleHeight >= nMaxValue then
        FBarTop := nMaxScrollValue
      else
        if FPosition = 0 then
        FBarTop := 0;
    end else FBarTop := 0;
  end;
end;

procedure TDChatMemo.LoadFromFile(const FileName: string);
begin
  FLines.LoadFromFile(FileName);
  FTopLines.Clear;
end;

function TDChatMemo.MaxValue: Integer;
begin
  Result := (FTopLines.Count + FLines.Count) * ItemHeight;
  if VisibleItemCount > 0 then begin
      Result := Result + (VisibleHeight - VisibleItemCount * ItemHeight);
  end;
  Result := Result + ExpandSize;
end;

function TDChatMemo.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer): Boolean;
  function PointInRect(const Point: TPoint; const Rect: TRect): Boolean;
  begin
    Result := (Point.X >= Rect.Left) and (Point.X <= Rect.Right) and
      (Point.Y >= Rect.Top) and (Point.Y <= Rect.Bottom);
  end;
var
  I, P: Integer;
  nHeight: Integer;
  nMaxValue: Integer;
  nBarTop: Integer;
  vRect: TRect;
begin
  Result := FALSE;
  if (inherited MouseDown(Button, Shift, X, Y)) then begin
    Result := True;
    if (not Background) and (MouseCaptureControl=nil) then begin
      SetDCapture(Self);
      Downed := TRUE;
    {FPrevMouseMove := False;
    FNextMouseMove := False;
    FBarMouseMove := False; }
    //FMouseMoveTick := GetTickCount + 600;

      if (Button = mbLeft) and FShowScroll then begin
        FScrollMouseDown := (X >= GLeft + GWidth - FScrollSize);
        if not (FPrevMouseDown or FNextMouseDown or FBarMouseDown) then begin
          FPrevMouseDown := InPrevRange(X, Y);
          FNextMouseDown := InNextRange(X, Y);
          FBarMouseDown := InBarRange(X, Y);
        end;

        if (not FPrevMouseDown) and (not FNextMouseDown) and (not FBarMouseDown) then begin
          vRect.Left := GLeft + GWidth - FScrollSize;
          vRect.Top := GTop;
          vRect.Bottom := vRect.Top + GHeight;
          vRect.Right := vRect.Left + FScrollSize;
          if PointInRect(Point(X, Y), vRect) then begin
            nMaxValue := MaxValue;
            nHeight := GHeight - FPrevImageSize - FNextImageSize - FBarImageSize;
            if ((nMaxValue > 0) and (nMaxValue > VisibleHeight) and (nHeight > 0)) or (Position > 0) then begin
              nBarTop := Max(Y - vRect.Top - FPrevImageSize - FBarImageSize div 2, 0);
              Position := Round(nBarTop * (nMaxValue - VisibleHeight) / nHeight);
            end else begin
              Position := 0;
            end;

            Exit;
          end;
        end else begin
          if FPrevMouseDown and InPrevRange(X, Y) then begin
            Previous;
          end else
            if FNextMouseDown and InNextRange(X, Y) then begin
            Next;
          end;
        end;
      end;
      FItemIndex := (Y - GTop - OffSetY) div FItemHeight + FPosition div FItemHeight;
      if FItemIndex >= (MaxValue - VisibleItemCount * ItemHeight) div FItemHeight then
        FItemIndex := -1;
    end;
  end;
end;

function TDChatMemo.MouseMove(Shift: TShiftState; X, Y: Integer): Boolean;
var
  P: Integer;
  nHeight: Integer;
  nMaxValue: Integer;
  nBarTop: Integer;
begin
  Result := inherited MouseMove (Shift, X, Y);
  if (not Background) and (Result) then begin
    Result := inherited MouseMove (Shift, X, Y);
    //if InRange (X, Y) then begin
      if MouseCaptureControl = self then Downed := TRUE;
      if FShowScroll then begin
        if not (FPrevMouseDown or FNextMouseDown or FBarMouseDown or Downed or FScrollMouseDown) then begin
          FPrevMouseMove := InPrevRange(X, Y);
          FNextMouseMove := InNextRange(X, Y);
          FBarMouseMove := InBarRange(X, Y);
        end;
      end;
      if FBarMouseDown and FShowScroll then begin
        FPrevMouseMove := False;
        FNextMouseMove := False;

        FNextMouseDown := False;
        FPrevMouseDown := False;

        nMaxValue := MaxValue;
        nHeight := GHeight - FPrevImageSize - FNextImageSize - FBarImageSize;
        if ((nMaxValue > 0) and (nMaxValue > VisibleHeight) and (nHeight > 0)) or (Position > 0) then begin
          nBarTop := Max(Y - GTop - FPrevImageSize - FBarImageSize div 2, 0);
          Position := Round(nBarTop * (nMaxValue - VisibleHeight) / nHeight);
        end else begin
          Position := 0;
        end;
      end else begin
        if FPrevMouseDown then begin
          //if Longint(GetTickCount - FMouseMoveTick) > 100 then begin
          //  FMouseMoveTick := GetTickCount;
            Previous;
          //end;
        end else if FNextMouseDown then begin
          //if Longint(GetTickCount - FMouseMoveTick) > 100 then begin
          //  FMouseMoveTick := GetTickCount;
            Next;
          //end;
        end;
        //vRect := VirtualRect;
        FItemIndex := (Y - GTop - OffSetY) div FItemHeight + FPosition div FItemHeight;
        if FItemIndex >= (MaxValue - VisibleItemCount * ItemHeight) div FItemHeight then
          FItemIndex := -1;
      end;
   { end else begin
      if not (FPrevMouseDown or FNextMouseDown or FBarMouseDown or Downed) then begin
        FPrevMouseMove := False;
        FNextMouseMove := False;
        FBarMouseMove := False;
      end;
      Downed := FALSE;
    end;  }
  end else
      if not (FPrevMouseDown or FNextMouseDown or FBarMouseDown or Downed) then begin
        FPrevMouseMove := False;
        FNextMouseMove := False;
        FBarMouseMove := False;
      end;
end;

function TDChatMemo.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer): Boolean;
begin
  Result := FALSE;
  if inherited MouseUp (Button, Shift, X, Y) then begin
    ReleaseDCapture;
    Downed := FALSE;
    Result := TRUE;
    //Exit;
  end else begin
    ReleaseDCapture;
    Downed := FALSE;
  end;
  FBarMouseDown := False;
  FPrevMouseDown := False;
  FNextMouseDown := False;
  FPrevMouseMove := False;
  FNextMouseMove := False;
  FBarMouseMove := False;
  FScrollMouseDown := False;
end;

procedure TDChatMemo.Next;
var
  P: Integer;
  nMaxScrollValue: Integer;
  nMaxValue: Integer;
  nPosition: Integer;
begin
  nMaxValue := MaxValue;
  if (nMaxValue > 0) and (nMaxValue > VisibleHeight) then begin
    if (FPosition + VisibleHeight < nMaxValue) then begin
      if FPosition + VisibleHeight + FItemHeight <= nMaxValue then begin
        P := FPosition + FItemHeight;
        DoScroll(FPosition - P);
        FPosition := P;
      end else begin
        P := nMaxValue - VisibleHeight;
        DoScroll(FPosition - P);
        FPosition := P;
      end;
    end;
  end else begin
    if FPosition > 0 then begin
      P := 0;
      DoScroll(FPosition - P);
      FPosition := P;
    end;
  end;

  if FShowScroll then begin
    nMaxScrollValue := GHeight - FPrevImageSize - FNextImageSize - FBarImageSize;

    if (nMaxValue > 0) and (nMaxScrollValue > 0) then
      FBarTop := Max(Round(FPosition * nMaxScrollValue / (nMaxValue - VisibleHeight)), 0)
    else
      FBarTop := 0;

    if nMaxValue > (GHeight) then begin
      if FPosition + VisibleHeight >= nMaxValue then
        FBarTop := nMaxScrollValue
      else
        if FPosition = 0 then
        FBarTop := 0;
    end else FBarTop := 0;
  end;
end;

procedure TDChatMemo.NextImageIndexChange(Sender: TObject);
var
  d: TDirectDrawSurface;
  nIndex: Integer;
begin
  if FNextImageIndex.Up >= 0 then
    nIndex := FNextImageIndex.Up
  else
    if FNextImageIndex.Hot >= 0 then
    nIndex := FNextImageIndex.Hot
  else
    if FNextImageIndex.Down >= 0 then
    nIndex := FNextImageIndex.Down;

  if (WLib <> nil) and (nIndex >= 0) then begin
    d := WLib.Images[nIndex];
    if d <> nil then
      FNextImageSize := d.Height;
  end;
end;

procedure TDChatMemo.PrevImageIndexChange(Sender: TObject);
var
  d: TDirectDrawSurface;
  nIndex: Integer;
begin
  if (WLib <> nil) then begin
    if FPrevImageIndex.Up >= 0 then
      nIndex := FPrevImageIndex.Up
    else
      if FPrevImageIndex.Hot >= 0 then
      nIndex := FPrevImageIndex.Hot
    else
      if FPrevImageIndex.Down >= 0 then
      nIndex := FPrevImageIndex.Down;

    if (nIndex >= 0) then begin
      d := WLib.Images[nIndex];
      if d <> nil then
        FPrevImageSize := d.Height;
    end;
  end;
end;

procedure TDChatMemo.Previous;
var
  P: Integer;
  nMaxScrollValue: Integer;
  nMaxValue: Integer;
  nPosition: Integer;
begin
  nMaxValue := MaxValue;
  if FPosition > 0 then begin
    if (nMaxValue > 0) and (nMaxValue > VisibleHeight) then begin
      if FPosition - FItemHeight >= 0 then begin
        P := FPosition - FItemHeight;
        DoScroll(FPosition - P);
        FPosition := P;
      end else begin
        P := 0;
        DoScroll(FPosition - P);
        FPosition := P;
      end;
    end else begin
      P := 0;
      DoScroll(FPosition - P);
      FPosition := P;
    end;
  end;

  if FShowScroll then begin
    nMaxScrollValue := GHeight - FPrevImageSize - FNextImageSize - FBarImageSize;

    if (nMaxValue > 0) and (nMaxScrollValue > 0) then
      FBarTop := Max(Round(FPosition * nMaxScrollValue / (nMaxValue - VisibleHeight)), 0)
    else
      FBarTop := 0;

    if nMaxValue > VisibleHeight then begin
      if FPosition + VisibleHeight >= nMaxValue then
        FBarTop := nMaxScrollValue
      else
        if FPosition = 0 then
        FBarTop := 0;
    end else FBarTop := 0;
  end;
end;

procedure TDChatMemo.ScrollImageIndexChange(Sender: TObject);
var
  d: TDirectDrawSurface;
  nIndex: Integer;
begin
  if (WLib <> nil) then begin
    if FScrollImageIndex.Up >= 0 then
      nIndex := FScrollImageIndex.Up
    else
      if FScrollImageIndex.Hot >= 0 then
      nIndex := FScrollImageIndex.Hot
    else
      if FScrollImageIndex.Down >= 0 then
      nIndex := FScrollImageIndex.Down;

    if (nIndex >= 0) then begin
      d := WLib.Images[nIndex];
      if d <> nil then
        FScrollSize := d.Width;
    end;
  end;
end;

procedure TDChatMemo.SetExpandSize(Value: Integer);
var
  nMaxValue, nMaxScrollValue: Integer;
begin
  if FExpandSize <> Value then begin
    FExpandSize := Value;
    if FShowScroll then begin
      nMaxValue := MaxValue;
      nMaxScrollValue := GHeight - FPrevImageSize - FNextImageSize - FBarImageSize;

      if (nMaxValue > 0) and (nMaxScrollValue > 0) then
        FBarTop := Max(Round(FPosition * nMaxScrollValue / (nMaxValue - VisibleHeight)), 0)
      else
        FBarTop := 0;

      if nMaxValue > (GHeight) then begin
        if FPosition + VisibleHeight >= nMaxValue then
          FBarTop := nMaxScrollValue
        else
          if FPosition = 0 then
          FBarTop := 0;
      end else FBarTop := 0;
    end;
  end;
end;

procedure TDChatMemo.SetItemHeight(Value: Integer);
begin
  FItemHeight := Max(Value, 1);
end;

procedure TDChatMemo.SetItemIndex(Value: Integer);
var
  nItemCount: Integer;
begin
  if FItemIndex <> Value then begin
    FItemIndex := Value;
    nItemCount := (MaxValue - VisibleItemCount * ItemHeight) div FItemHeight;
    if FItemIndex >= nItemCount then FItemIndex := -1;
    if FItemIndex >= 0 then begin
      Position := FItemIndex * FItemHeight;
    end;
  end;
end;

procedure TDChatMemo.SetLines(Value: TStrings);
begin
  FLines.Clear;
  FLines.AddStrings(Value);
end;

procedure TDChatMemo.SetPosition(Value: Integer); //设置滚动指针
var
  P, nMaxValue, nMaxScrollValue: Integer;
begin
  nMaxValue := MaxValue;
  if FPosition <> Value then begin
    P := Value;
    if P < 0 then P := 0;

    if VisibleHeight > nMaxValue then begin
      P := 0;
    end else begin
      if P + VisibleHeight > nMaxValue then
        P := nMaxValue - VisibleHeight;
    end;

    DoScroll(FPosition - P);
    FPosition := P;
  end;

  if FShowScroll then begin
    nMaxScrollValue := GHeight - FPrevImageSize - FNextImageSize - FBarImageSize;

    if (nMaxValue > 0) and (nMaxScrollValue > 0) then
      FBarTop := Max(Round(FPosition * nMaxScrollValue / (nMaxValue - VisibleHeight)), 0)
    else
      FBarTop := 0;

    if nMaxValue > VisibleHeight then begin
      if FPosition + VisibleHeight >= nMaxValue then
        FBarTop := GHeight - FPrevImageSize - FNextImageSize - FBarImageSize
      else
        if FPosition = 0 then
        FBarTop := 0;
    end else FBarTop := 0;
  end;
end;

procedure TDChatMemo.SetScrollSize(Value: Integer);
begin
  if FScrollSize <> Value then begin
    FScrollSize := Value;
  end;
end;

procedure TDChatMemo.SetTopLines(Value: TStrings);
begin
  FTopLines.Clear;
  FTopLines.AddStrings(Value);
end;
procedure TDChatMemo.SetVisibleItemCount(Value: Integer);
var
  nMaxValue, nMaxScrollValue: Integer;
begin
  if VisibleHeight div ItemHeight < Value then
    FVisibleItemCount := 0
  else
    FVisibleItemCount := Value;

  if FShowScroll then begin
    nMaxValue := MaxValue;
    nMaxScrollValue := GHeight - FPrevImageSize - FNextImageSize - FBarImageSize;

    if (nMaxValue > 0) and (nMaxScrollValue > 0) then
      FBarTop := Max(Round(FPosition * nMaxScrollValue / (nMaxValue - VisibleHeight)), 0)
    else
      FBarTop := 0;

    if nMaxValue > (GHeight) then begin
      if FPosition + VisibleHeight >= nMaxValue then
        FBarTop := nMaxScrollValue
      else
        if FPosition = 0 then
        FBarTop := 0;
    end else FBarTop := 0;
  end;
end;

{ TDChatMemoLines }

function TDChatMemoLines.AddItem(const S: string; AObject: TObject): pTViewItem;
begin
  AddObject(S, AObject);
  Result := @FItemList[Length(FItemList) - 1];
end;

function TDChatMemoLines.AddObject(const S: string; AObject: TObject): Integer;
var
  ViewItem: pTViewItem;
begin
  SetLength(FItemList, Length(FItemList) + 1);
  SetLength(FItemHeightList, Length(FItemHeightList) + 1);
  FItemHeightList[Length(FItemHeightList) - 1] := 0;
  ViewItem := @FItemList[Length(FItemList) - 1];
  ViewItem.Down := False;
  ViewItem.Move := False;
  ViewItem.Caption := S;
  ViewItem.Data := nil;
  ViewItem.Style := bsButton;
  ViewItem.Checked := False;
  ViewItem.Color := TDCaptionColor.Create;
  ViewItem.ImageIndex := TDImageIndex.Create;
  ViewItem.TimeTick := GetTickCount;
  Result := inherited AddObject(S, AObject);
end;

procedure TDChatMemoLines.Clear;
var
  I: Integer;
begin
  for I := 0 to Length(FItemList) - 1 do begin
    FItemList[I].Color.Free;
    FItemList[I].ImageIndex.Free;
  end;
  SetLength(FItemList, 0);
  SetLength(FItemHeightList, 0);
  FItemList := nil;
  FItemHeightList := nil;
  inherited Clear;
end;

constructor TDChatMemoLines.Create;
begin
  inherited;
  FItemList := nil;
  FItemHeightList := nil;
end;

procedure TDChatMemoLines.Delete(Index: Integer);
var
  I: Integer;
begin
  FItemList[Index].Color.Free;
  FItemList[Index].ImageIndex.Free;
  for I := Index to Length(FItemList) - 2 do begin
    FItemList[I] := FItemList[I + 1];
    FItemHeightList[I] := FItemHeightList[I + 1];
  end;
  SetLength(FItemList, Length(FItemList) - 1);
  SetLength(FItemHeightList, Length(FItemHeightList) - 1);
  inherited Delete(Index);
end;

destructor TDChatMemoLines.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FItemList) - 1 do begin
    FItemList[I].Color.Free;
    FItemList[I].ImageIndex.Free;
  end;
  SetLength(FItemList, 0);
  SetLength(FItemHeightList, 0);
  FItemList := nil;
  FItemHeightList := nil;
  inherited;
end;

function TDChatMemoLines.GetItem(Index: Integer): pTViewItem;
begin
  Result := @FItemList[Index];
end;

function TDChatMemoLines.GetItemHeight(Index: Integer): Integer;
begin
  Result := FItemHeightList[Index];
end;

procedure TDChatMemoLines.InsertObject(Index: Integer; const S: string;
  AObject: TObject);
var
  I: Integer;
  ViewItem: pTViewItem;
begin
  SetLength(FItemList, Length(FItemList) + 1);
  SetLength(FItemHeightList, Length(FItemHeightList) + 1);
  for I := Length(FItemList) - 1 downto Index do begin
    FItemList[I] := FItemList[I - 1];
    FItemHeightList[I] := FItemHeightList[I - 1];
  end;
  FItemHeightList[Index] := 0;
  ViewItem := @FItemList[Index];
  ViewItem.Down := False;
  ViewItem.Move := False;
  ViewItem.Caption := S;
  ViewItem.Data := nil;
  ViewItem.Style := bsButton;
  ViewItem.Checked := False;
  ViewItem.Color := TDCaptionColor.Create;
  ViewItem.ImageIndex := TDImageIndex.Create;
  ViewItem.TimeTick := GetTickCount;
  inherited InsertObject(Index, S, AObject);
end;

procedure TDChatMemoLines.SetItemHeight(Index, Value: Integer);
begin
  FItemHeightList[Index] := Value;
end;

end.
