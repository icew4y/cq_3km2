unit uDListView;

interface
uses Types, Controls, Classes, Graphics, Math, AbstractCanvas, AbstractTextures,
     AsphyreTextureFonts, DWinCtl, Wil, uDScrollBar, uDControls;

type
  TViewItem = record
    Caption: string;
    Data: Pointer;
    Style: TButtonStyle;
    Checked: Boolean;
    Color: TDCaptionColor;
    ImageIndex: TDImageIndex;
    Down, Move: Boolean;
    Transparent: Boolean;
    WLib: TWMImages;
  end;
  pTViewItem = ^TViewItem;

  TDListItem = class;
  TOnListItem = procedure(Sender: TObject; ARow, ACol: Integer; ListItem: TDListItem; ViewItem: pTViewItem) of object;

  TDListItem = class(TStringList)
  private
    FItemList: array of TViewItem;
    function GetItem(Index: Integer): pTViewItem;
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
  published
  end;

  TDListView = class(TDControl)
  private
    FLines: TList;
    ColWidths: array of Integer;
    FColCount: Integer;
    FOnListItemClick: TOnListItem;
    FHScrollBar: TDScrollBar;            //0x34
    FOnScroll: TNotifyEvent;
    function GetCount: Integer;
    function GetViewItem(Index: Integer): TDListItem;
    function GetColWidth(Index: Integer): Integer;
    procedure SetColWidth(Index: Integer; Value: Integer);
    procedure SetColCount(Value: Integer);
    procedure FillItemMouse;
    procedure SetHScrollBar(Value: TDScrollBar);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseMove(Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
    function  Click (X, Y: integer): Boolean; override;
    procedure DirectPaint (dsurface: TAsphyreCanvas); override;
    procedure DoScroll(Value: Integer); virtual;
    function Add: TDListItem;
    procedure Clear;
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TDListItem read GetViewItem;
    property ColCount: Integer read FColCount write SetColCount;
    property ColWidth[Index: Integer]: Integer read GetColWidth write SetColWidth;
  published
    property HScrollBar: TDScrollBar read FHScrollBar write SetHScrollBar;
    property OnListItemClick: TOnListItem read FOnListItemClick write FOnListItemClick;
  end;
procedure Register;
implementation

procedure Register;
begin
   RegisterComponents('MirGame', [TDListView]);
end;

{ TDListItem }

function TDListItem.AddItem(const S: string;
  AObject: TObject): pTViewItem;
begin
  AddObject(S, AObject);
  Result := @FItemList[Length(FItemList) - 1];
end;

function TDListItem.AddObject(const S: string; AObject: TObject): Integer;
var
  ViewItem: pTViewItem;
begin
  SetLength(FItemList, Length(FItemList) + 1);
  ViewItem := @FItemList[Length(FItemList) - 1];
  ViewItem.Down := False;
  ViewItem.Move := False;
  ViewItem.Caption := S;
  ViewItem.Data := nil;
  ViewItem.WLib := nil;
  ViewItem.Style := bsButton;
  ViewItem.Checked := False;
  ViewItem.Color := TDCaptionColor.Create;
  ViewItem.ImageIndex := TDImageIndex.Create;
  Result := inherited AddObject(S, AObject);
end;

procedure TDListItem.Clear;
var
  I: Integer;
begin
  for I := 0 to Length(FItemList) - 1 do begin
    FItemList[I].Color.Free;
    FItemList[I].ImageIndex.Free;
  end;
  SetLength(FItemList, 0);
  FItemList := nil;
  inherited Clear;
end;

constructor TDListItem.Create;
begin
  inherited;
  FItemList := nil;
end;

procedure TDListItem.Delete(Index: Integer);
var
  I: Integer;
begin
  FItemList[Index].Color.Free;
  FItemList[Index].ImageIndex.Free;
  for I := 0 to Length(FItemList) - 2 do begin
    FItemList[I] := FItemList[I + 1];
  end;
  SetLength(FItemList, Length(FItemList) - 1);
  inherited Delete(Index);
end;

destructor TDListItem.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FItemList) - 1 do begin
    FItemList[I].Color.Free;
    FItemList[I].ImageIndex.Free;
  end;
  SetLength(FItemList, 0);
  FItemList := nil;
  inherited;
end;

function TDListItem.GetItem(Index: Integer): pTViewItem;
begin
  Result := @FItemList[Index];
end;

procedure TDListItem.InsertObject(Index: Integer; const S: string;
  AObject: TObject);
var
  I: Integer;
  ViewItem: pTViewItem;
begin
  SetLength(FItemList, Length(FItemList) + 1);
  for I := Length(FItemList) - 1 downto Index do begin
    FItemList[I] := FItemList[I - 1];
  end;
  ViewItem := @FItemList[Index];
  ViewItem.Down := False;
  ViewItem.Move := False;
  ViewItem.Caption := S;
  ViewItem.Data := nil;
  ViewItem.WLib := nil;
  ViewItem.Style := bsButton;
  ViewItem.Checked := False;
  ViewItem.Color := TDCaptionColor.Create;
  ViewItem.ImageIndex := TDImageIndex.Create;
  inherited InsertObject(Index, S, AObject);
end;

{ TDListView }

function TDListView.Add: TDListItem;
begin
  Result := TDListItem.Create;
  FLines.Add(Result);
end;

procedure TDListView.Clear;
var
  I: Integer;
begin
  for I := 0 to FLines.Count - 1 do
    TDListItem(FLines[I]).Free;
  FLines.Clear;
end;

function TDListView.Click(X, Y: integer): Boolean;
var
  I: Integer;
  nWidth: Integer;
  nLeft: Integer;
  nCol: Integer;
  nRow: Integer;
  ViewItem: pTViewItem;
  ListItem: TDListItem;
begin
  Result := False;
  if inherited Click(X, Y) then begin
    Result := True;
    nCol := 0;
    nLeft := 0;
    nWidth := X - GLeft;
    for I := 0 to Length(ColWidths) - 1 do begin
      nLeft := nLeft + ColWidths[I];
      if nLeft >= nWidth then begin
        nCol := I;
        break;
      end;
    end;
    nRow := (Y - GTop) div FHScrollBar.ItemHeight + FHScrollBar.Position div FHScrollBar.ItemHeight;
    if (nRow >= 0) and (nRow < FLines.Count) then begin
      ListItem := Items[nRow];
      if (nCol >= 0) and (nCol < ListItem.Count) then begin
        ViewItem := ListItem.Items[nCol];
        case ViewItem.Style of
          bsRadio: begin
              for I := 0 to ListItem.Count - 1 do begin
                ListItem.Items[I].Checked := False;
              end;
              ViewItem.Checked := True;
            end;
          bsCheckBox: begin
              ViewItem.Checked := not ViewItem.Checked;
            end;
        end;
        if Assigned(FOnListItemClick) then
          FOnListItemClick(Self, nRow, nCol, ListItem, ViewItem);
      end;
    end;
  end;
end;

constructor TDListView.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FLines := TList.Create;
  FOnScroll := nil;
  FColCount := 3;
  SetLength(ColWidths, FColCount);
  ColWidths[0] := GWidth div 3;
  ColWidths[1] := ColWidths[0];
  ColWidths[2] := ColWidths[0];
end;

destructor TDListView.Destroy;
var
  I: Integer;
begin
  for I := 0 to FLines.Count - 1 do
    TDListItem(FLines[I]).Free;
  FLines.Free;
  inherited Destroy;
end;

procedure TDListView.DirectPaint(dsurface: TAsphyreCanvas);
var
  I, II, nIndex, nCount, nLeft, nTop, n01: Integer;
  nFaceIndex: Integer;
  nMaxValue: Integer;
  D: TAsphyreLockableTexture;
  vtRect: TRect;
  vbRect: TRect;
  PaintRect: TRect;

  ListItem: TDListItem;
  ViewItem: pTViewItem;

  OldSize: Integer;
  OldFontName: TFontName;

  Font: TDFont;
begin
  if Assigned (OnDirectPaint) then
    OnDirectPaint (self, dsurface)
  else begin
    if WLib <> nil then begin
      if FaceIndex >= 0 then begin
        D := WLib.Images[FaceIndex];
        if D <> nil then begin
          dsurface.StretchDraw(ClientRect, D, True);
        end;
      end;
    end;
    n01 := 0;
    nTop := GTop;
    nIndex := HScrollBar.Position div HScrollBar.ItemHeight;  //索引
    nMaxValue := GHeight div HScrollBar.ItemHeight;   //显示多少个
    for I := nIndex to FLines.Count - 1 do begin
      ListItem := FLines[I];
      nCount := Min(ListItem.Count, FColCount);
      nLeft := GLeft;
      for II := 0 to nCount - 1 do begin
        ViewItem := ListItem.Items[II];
        if II > 0 then
          nLeft := nLeft + ColWidths[II - 1];

        if ViewItem.WLib <> nil then begin
          nFaceIndex := -1;
          if ViewItem.Style = bsButton then begin
            if ViewItem.Down then begin
              nFaceIndex := ViewItem.ImageIndex.Down;
              if (nFaceIndex < 0) and (ViewItem.ImageIndex.Up >= 0) then
                nFaceIndex := ViewItem.ImageIndex.Up;
            end else
              if ViewItem.Move then begin
              nFaceIndex := ViewItem.ImageIndex.Hot;
              if (nFaceIndex < 0) and (ViewItem.ImageIndex.Up >= 0) then
                nFaceIndex := ViewItem.ImageIndex.Up;
            end else
              nFaceIndex := ViewItem.ImageIndex.Up;
          end else begin
            if ViewItem.Move then begin
              if ViewItem.Checked then
                nFaceIndex := ViewItem.ImageIndex.Down
              else
                if ViewItem.ImageIndex.Hot >= 0 then
                nFaceIndex := ViewItem.ImageIndex.Hot
              else
                nFaceIndex := ViewItem.ImageIndex.Up;
            end else begin
              if ViewItem.Checked then
                nFaceIndex := ViewItem.ImageIndex.Down
              else
                nFaceIndex := ViewItem.ImageIndex.Up;
            end;
          end;

          if nFaceIndex >= 0 then begin
            D := ViewItem.WLib.Images[nFaceIndex];
            if D <> nil then begin
              DSurface.Draw(SurfaceX(nLeft) + (ColWidths[II] - D.Width) div 2, SurfaceY(nTop) + (HScrollBar.ItemHeight - D.Height) div 2, D.ClientRect, D, True);
            end;
          end;
        end;

        if ViewItem.Caption <> '' then begin
          OldSize := AspTextureFonts.FontSize;
          OldFontName := AspTextureFonts.FontName;

          if ViewItem.Down then begin
            Font := ViewItem.Color.Down;
          end else
            if ViewItem.Move then begin
            Font := ViewItem.Color.Hot;
          end else begin
            Font := ViewItem.Color.Up;
          end;

          if Font.Name = '' then
            Font.Name := '宋体';
          AspTextureFonts.SetFont(Font.Name, Font.Size);
          if Font.Bold then
            AspTextureFont.BoldTextOut(SurfaceX(nLeft), SurfaceY(nTop) + (FHScrollBar.ItemHeight - AspTextureFont.TextHeight('0')) div 2, Font.Color, Font.BColor, ViewItem.Caption, Font.Style)
          else
            AspTextureFont.TextOut(SurfaceX(nLeft), SurfaceY(nTop) + (FHScrollBar.ItemHeight - AspTextureFont.TextHeight('0')) div 2, Font.Color, ViewItem.Caption, Font.Style);

          AspTextureFonts.SetFont(OldFontName, OldSize);
        end;
      end;
      Inc(n01);
      Inc(nTop, FHScrollBar.ItemHeight);
      if n01 >= nMaxValue then break;
    end;
  end;
  if DControls.Count > 0 then //20080629
  for i:=0 to DControls.Count-1 do
    if TDControl(DControls[i]).Visible then
      TDControl(DControls[i]).DirectPaint (dsurface);
end;

procedure TDListView.DoScroll(Value: Integer);
var
  I: Integer;
  vRect: TRect;
  ARect: TRect;
  BRect: TRect;
  D: TDControl;
begin
  if Value <> 0 then begin
    vRect := Rect(0, 0, GWidth, GHeight); //VirtualRect;
    if DControls.Count > 0 then begin//20080629
      for i:=0 to DControls.Count-1 do begin
        D := DControls[I];
        if D is TDScrollBar then continue;
        D.GTop := D.GTop + Value;
        ARect := D.ClientRect;
        D.Visible := IntersectRect(BRect, vRect, ARect);
      end;
    end;
  end;
  if (Assigned(FOnScroll)) then FOnScroll(Self);
end;

procedure TDListView.FillItemMouse;
var
  I, II: Integer;
  ListItem: TDListItem;
begin
  for I := 0 to Count - 1 do begin
    ListItem := Items[I];
    for II := 0 to ListItem.Count - 1 do begin
      ListItem.Items[II].Down := False;
      ListItem.Items[II].Move := False;
    end;
  end;
end;

function TDListView.GetColWidth(Index: Integer): Integer;
begin
  Result := ColWidths[Index];
end;

function TDListView.GetCount: Integer;
begin
  Result := FLines.Count;
end;

function TDListView.GetViewItem(Index: Integer): TDListItem;
begin
  Result := FLines[Index];
end;

function TDListView.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer): Boolean;
var
  I: Integer;
  nWidth: Integer;
  nLeft: Integer;
  nCol: Integer;
  nRow: Integer;
  ListItem: TDListItem;
begin
  Result := False;
  if inherited MouseDown(Button, Shift, X, Y) then begin
    if (not Background) and (MouseCaptureControl=nil) then begin
      Result := True;
      if (Button = mbLeft) then begin
      //FillItemMouse;
        nCol := 0;
        nLeft := 0;
        nWidth := X - GLeft;
        for I := 0 to Length(ColWidths) - 1 do begin
          nLeft := nLeft + ColWidths[I];
          if nLeft >= nWidth then begin
            nCol := I;
            break;
          end;
        end;
        nRow := (Y - GTop) div FHScrollBar.ItemHeight + FHScrollBar.Position div FHScrollBar.ItemHeight;
        if (nRow >= 0) and (nRow < FLines.Count) then begin
          ListItem := Items[nRow];
          if (nCol >= 0) and (nCol < ListItem.Count) then begin
            ListItem.Items[nCol].Down := True;
            ListItem.Items[nCol].Move := False;
          end;
        end;
        SetDCapture (self);
      end;
    end;
    Result := True;
  end;
end;

function TDListView.MouseMove(Shift: TShiftState; X, Y: Integer): Boolean;
var
  I: Integer;
  nWidth: Integer;
  nLeft: Integer;
  nCol: Integer;
  nRow: Integer;
  ListItem: TDListItem;
begin
  Result := inherited MouseMove (Shift, X, Y);
  if (not Background) and (not Result) then begin
    Result := inherited MouseMove (Shift, X, Y);
  end else if InRange(x, y) then begin
    FillItemMouse;
    nCol := -1;
    nLeft := 0;
    nWidth := Min(X - GLeft, GWidth);
                               
    for I := 0 to Length(ColWidths) - 1 do begin
      nLeft := nLeft + ColWidths[I];
      if nLeft >= nWidth then begin
        nCol := I;
        break;
      end;
    end;
    nRow := (Y - GTop) div FHScrollBar.ItemHeight + FHScrollBar.Position div FHScrollBar.ItemHeight;
    if (nRow >= 0) and (nRow < FLines.Count) then begin
      ListItem := Items[nRow];
      if (nCol >= 0) and (nCol < ListItem.Count) then begin
        ListItem.Items[nCol].Move := True;
      end;
    end;
  end;
end;

function TDListView.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer): Boolean;
var
  I: Integer;
  nWidth: Integer;
  nLeft: Integer;
  nCol: Integer;
  nRow: Integer;
  ListItem: TDListItem;
begin
  Result := False;
  if inherited MouseUp(Button, Shift, X, Y) then begin
    ReleaseDCapture;
    Result := True;
    FillItemMouse;
    nCol := 0;
    nLeft := 0;
    nWidth := X - GLeft;
    for I := 0 to Length(ColWidths) - 1 do begin
      nLeft := nLeft + ColWidths[I];
      if nLeft >= nWidth then begin
        nCol := I;
        break;
      end;
    end;
    nRow := (Y - GTop) div FHScrollBar.ItemHeight + FHScrollBar.Position div FHScrollBar.ItemHeight;
    if (nRow >= 0) and (nRow < FLines.Count) then begin
      ListItem := Items[nRow];
      if (nCol >= 0) and (nCol < ListItem.Count) then begin
        ListItem.Items[nCol].Down := False;
        ListItem.Items[nCol].Move := False;
      end;
    end;
  end else begin
    ReleaseDCapture;
  end;
end;

procedure TDListView.SetColCount(Value: Integer);
var
  I: Integer;
begin
  if FColCount <> Value then begin
    FColCount := Value;
    SetLength(ColWidths, FColCount);
    for I := 0 to FColCount - 1 do
      ColWidths[I] := GWidth div FColCount;
  end;
end;

procedure TDListView.SetColWidth(Index, Value: Integer);
begin
  if ColWidths[Index] <> Value then begin
    ColWidths[Index] := Value;
  end;
end;

procedure TDListView.SetHScrollBar(Value: TDScrollBar);
begin
  FHScrollBar := Value;
end;

end.
