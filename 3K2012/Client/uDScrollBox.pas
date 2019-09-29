unit uDScrollBox;

interface
uses Types, DWinCtl, Classes, Graphics, DXDraws, uDScrollBar, Controls, Math;
type

  TDLines = class(TStringList)
  private
    FTop: Integer;
    FLeft: Integer;
    FWidth: Integer;
    FHeight: Integer;
    FItemSize: Integer;
    FData: Pointer;
    FVisible: Boolean;
    function GetText: string;

  public
    constructor Create;
    destructor Destroy; override;
    function Add(const S: string): Integer; override;
    function AddObject(const S: string; AObject: TObject): Integer; override;
    procedure Clear; override;                                             
    procedure Delete(Index: Integer); override;
    function GetHeight: Integer;
    property Left: Integer read FLeft write FLeft;
    property Top: Integer read FTop write FTop;
    property Width: Integer read FWidth {write FWidth};
    property Height: Integer read FHeight write FHeight;
    property ItemSize: Integer read FItemSize;
    property Text: string read GetText;
    property Data: Pointer read FData write FData;
    property Visible: Boolean read FVisible write FVisible;
  end;

  TDScrollBox = class(TDControl)
  private
    FLines: TList;
    FBackSurface: TDirectDrawSurface;
    FClickSound: TClickSound;
    FOnClick: TOnClickEx;
    FOnClickSound: TOnClickSound;

    FBackground: Boolean;
    FBorder: Boolean;

    //FMainMenu: TDPopupMenu;

    FCenterY: Integer;
    FItemIndex: Integer;
    FDrawItemIndex: Integer;


    //FColors: TDColors;
    FRowSelect: Boolean;

    FMaxHeight: Integer;
    FMaxWidth: Integer;
    FItemSize: Integer;
    FSpareSize: Integer;
    FDScroll: TDScrollBar;
    function GetCount: Integer;
    function GetItems(Index: Integer): TStringList;
    procedure SetItemIndex(Value: Integer);
//    procedure SetColors(Value: TDColors);

   // function GetText: string;
   // procedure SetText(Value: string);
    function GetStrings(Index: Integer): string;
    function GetMaxLineHeight: Integer;
    procedure SetMaxLineHeight(Value: Integer);
    procedure GetItemIndex(Y: Integer);
    procedure SetDScroll(Value: TDScrollBar);
//    procedure DoScroll(Value: Integer);
{    procedure RefPostion(ALeft, ATop: Integer);
    procedure RefSize(AWidth, AHeight: Integer);   }
  protected

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    //procedure DoScroll(Value: Integer); virtual;
    procedure OnScroll(Sender: TObject; Increment: Integer);

//    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure DirectPaint(dsurface: TDirectDrawSurface); override;

    function KeyDown(var Key: Word; Shift: TShiftState): Boolean;
    function MouseMove(Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;

    function Add: TStringList;

    function AddSuItem(SubItems: TStringList; DControl: TDControl): TDControl; //overload;
    function DelSuItem(DControl: TDControl): Boolean;
    function InSuItem(DControl: TDControl): Boolean;
    procedure Delete(Index: Integer);
    procedure Clear;
//    procedure RefreshPos;
   // procedure LoadFromFile(const FileName: string);
//    procedure SaveToFile(const FileName: string);

    property Items[Index: Integer]: TStringList read GetItems;
    property Strings[Index: Integer]: string read GetStrings;


    property Count: Integer read GetCount;

  //  property Text: string read GetText write SetText;
    property MaxHeight: Integer read GetMaxLineHeight write SetMaxLineHeight;
    property MaxWidth: Integer read FMaxWidth write FMaxWidth;
    property ItemSize: Integer read FItemSize write FItemSize;
    property SpareSize: Integer read FSpareSize write FSpareSize;
  published
    property RowSelect: Boolean read FRowSelect write FRowSelect;
   // property Colors: TDColors read FColors write SetColors;
    property ItemIndex: Integer read FItemIndex write FItemIndex;

    property DrawBackground: Boolean read FBackground write FBackground;
    property Border: Boolean read FBorder write FBorder;
    property DScroll: TDScrollBar read FDScroll write SetDScroll;
    property ClickCount: TClickSound read FClickSound write FClickSound;
    property OnClick: TOnClickEx read FOnClick write FOnClick;
    property OnClickSound: TOnClickSound read FOnClickSound write FOnClickSound;
    //property MainMenu: TDPopupMenu read FMainMenu write FMainMenu;
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
  end;
procedure Register;
implementation

procedure Register;
begin
   RegisterComponents('MirGame', [TDScrollBox]);
end;
{ TDScrollBox }

function TDScrollBox.Add: TStringList;
begin
  Result := TDLines.Create;
  FLines.Add(Result);
end;

function TDScrollBox.AddSuItem(SubItems: TStringList;
  DControl: TDControl): TDControl;
begin
  SubItems.AddObject(DControl.Caption, DControl);
  if FDScroll <> nil then begin
    FDScroll.MaxValue := GetMaxLineHeight + FSpareSize;
  end;
  //DoScroll(0);
  OnScroll(Self, 0);
  Result := DControl;
end;

function TDScrollBox.DelSuItem(DControl: TDControl): Boolean;
var
  I, J: Integer;
  Item: TDLines;
begin
  Result := False;
  if FLines <> nil then begin
    for I:=0 to FLines.Count-1 do begin
      Item := TDLines(FLines.Items[I]);
      for J:=0 to Item.Count - 1 do begin
        if Item.Objects[J] = DControl then begin
          Item.Delete(J);
          Result := True;
          Break;
        end;
      end;
    end;

   { for I:=FLines.Count-1 downto 0 do begin
      if FLines.Items[I] = DControl then begin
        FLines.Delete(I);
        Result := True;
        Break;
      end;
    end;  }
  end;
end;

function TDScrollBox.InSuItem(DControl: TDControl): Boolean;
var
  I, J: Integer;
  Item: TDLines;
begin
  Result := False;
  if FLines <> nil then begin
    for I:=0 to FLines.Count-1 do begin
      Item := TDLines(FLines.Items[I]);
      for J:=0 to Item.Count - 1 do begin
        if Item.Objects[J] = DControl then begin
          Result := True;
          Break;
        end;
      end;
    end;
  end;
end;

procedure TDScrollBox.Clear;
var
  I, II: Integer;
  ItemList: TStringList;
begin
  FDrawItemIndex := -1;
  FMaxHeight := 0;
  FMaxWidth := 0;
  for I := 0 to FLines.Count - 1 do begin
    ItemList := TStringList(FLines.Items[I]);
    for II := 0 to ItemList.Count - 1 do begin
      TDControl(ItemList.Objects[II]).Free;
    end;
    ItemList.Free;
  end;
  FLines.Clear;
  if FDScroll <> nil then begin
    FDScroll.Position := 0;
    FDScroll.MaxValue := 0;
  end;
end;

constructor TDScrollBox.Create(AOwner: TComponent);
begin
 inherited Create(aowner);
  FLines := TList.Create;
  //Downed := False;
  FOnClick := nil;
  //FEnableFocus := False;
  FClickSound := csNone;
  Caption := Name;
  GWidth := 100;
  GHeight := 100;

  {FColors := TDColors.Create;
  FColors.Background := clWhite;
  FColors.Border := $00488184;
  FColors.Hot := $0078B3B6;
  //FColors.Down := $0078B3B6;
  FColors.Selected := clNavy;
  FColors.Down := clBtnFace; }

  FBackground := False;
  FBorder := False;
  //FMainMenu := nil;


  FDrawItemIndex := 0;

  FItemIndex := -1;
  FRowSelect := False;
  FMaxHeight := 0;
  FMaxWidth := 0;
  FItemSize := 16;
  FSpareSize := 0;
  {if not (csDesigning in ComponentState) then begin

  end;}
end;

procedure TDScrollBox.Delete(Index: Integer);
var
  I, II, nTop, nItemSize: Integer;
  ItemList: TDLines;
  D: TDControl;
begin
  if (Index >= 0) and (Index < Count) then begin
    ItemList := FLines.Items[Index];
    nItemSize := ItemList.ItemSize;
    FLines.Delete(Index);

    if (FDScroll <> nil) then begin
      FDScroll.Position := FDScroll.Position - nItemSize;
      FDScroll.MaxValue := FDScroll.MaxValue - nItemSize;
      //DebugOutStr('2 DScroll.Max:'+IntToStr(FDScroll.Max)+' DScroll.Position:'+IntToStr(FDScroll.Position)+' nItemSize:'+IntToStr(nItemSize));
    end;

    nTop := SurfaceY(GTop);
    FDrawItemIndex := -1;
    for I := Index to FLines.Count - 1 do begin
      ItemList := TDLines(FLines.Items[I]);
      if ItemList.Visible then begin
        ItemList.GetHeight;
        ItemList.Top := ItemList.Top - nItemSize;
        ItemList.Height := ItemList.Height - nItemSize;
        if (ItemList.Height > nTop) and (ItemList.Top < nTop + GHeight) then begin
          if FDrawItemIndex = -1 then FDrawItemIndex := I;
          for II := 0 to ItemList.Count - 1 do begin
            D := TDControl(ItemList.Objects[II]);
            D.GTop := D.GTop - nItemSize;
            D.Visible := True;
          end;
        end else begin
          for II := 0 to ItemList.Count - 1 do begin
            D := TDControl(ItemList.Objects[II]);
            D.GTop := D.GTop - nItemSize;
            D.Visible := False;
          end;
        end;
      end;
    end;
  end;
end;

destructor TDScrollBox.Destroy;
var
  I: Integer;
begin
  for I := 0 to FLines.Count - 1 do begin
    TStringList(FLines.Items[I]).Free;
  end;
  FLines.Free;
  //FColors.Free;
  //FBackSurface.Free;
  inherited;
end;

procedure TDScrollBox.DirectPaint(dsurface: TDirectDrawSurface);
var
  I: Integer;
  rc: TRect;
  nX, nY, nWidth, nHeight: Integer;
  ItemList: TDLines;
  d: TDirectDrawSurface;
  DControl: TDControl;
begin
  if Assigned(OnDirectPaint) then
    OnDirectPaint(Self, dsurface)
  else
    if WLib <> nil then begin
    d := WLib.Images[FaceIndex];
    if d <> nil then begin
      dsurface.Draw(SurfaceX(GLeft), SurfaceY(GTop), d.ClientRect, d, True);
    end;
  end;
  FBackSurface := TDirectDrawSurface.Create(MainFormDxDraw.DDraw);
  try
    FBackSurface.SystemMemory := True;
    FBackSurface.SetSize(GWidth, GHeight);
    nWidth := SurfaceX(GLeft) + GWidth;
    nHeight := SurfaceY(GTop) + GHeight;
    if (nWidth <> FBackSurface.Width) or (nHeight <> FBackSurface.Height) then begin
      FBackSurface.SetSize(nWidth, nHeight);
    end else begin
      FBackSurface.Fill(0);
    end;
    if DControls.Count > 0 then //20080629
    for i:=0 to DControls.Count-1 do
      if TDControl(DControls[i]).Visible then
        TDControl(DControls[i]).DirectPaint (FBackSurface);

  dsurface.Draw(SurfaceX(GLeft), SurfaceY(GTop), Bounds(SurfaceX(GLeft), SurfaceY(GTop) - 1, GWidth, GHeight), FBackSurface);
  finally
    FBackSurface.Free;
  end;
end;

{procedure TDScrollBox.DoScroll(Value: Integer);
begin
end;}

procedure TDScrollBox.OnScroll(Sender: TObject; Increment: Integer);
var
  I, II, nTop: Integer;
  ItemList: TDLines;
  D: TDControl;
begin
  nTop := SurfaceY(GTop);
  FDrawItemIndex := -1;
  for I := 0 to FLines.Count - 1 do begin
    ItemList := TDLines(FLines.Items[I]);
    if ItemList.Visible then begin
      ItemList.GetHeight;
      ItemList.Top := ItemList.Top + Increment;
      ItemList.Height := ItemList.Height + Increment;
      if (ItemList.Height > nTop) and (ItemList.Top < nTop + GHeight) then begin
        if FDrawItemIndex = -1 then FDrawItemIndex := I;
        for II := 0 to ItemList.Count - 1 do begin
          D := TDControl(ItemList.Objects[II]);
          D.GTop := D.GTop + Increment;
          D.Visible := True;
        end;
      end else begin
        for II := 0 to ItemList.Count - 1 do begin
          D := TDControl(ItemList.Objects[II]);
          D.GTop := D.GTop + Increment;
          D.Visible := False;
        end;
      end;
    end;
  end;
end;

function TDScrollBox.GetCount: Integer;
begin
  Result := FLines.Count;
end;

procedure TDScrollBox.GetItemIndex(Y: Integer);
var
  I, nHeight, nTop: Integer;
  ItemList: TDLines;
begin
  FItemIndex := -1;
  if FDrawItemIndex >= 0 then begin
    nTop := SurfaceY(GTop);
    for I := FDrawItemIndex to FLines.Count - 1 do begin
      ItemList := TDLines(FLines.Items[I]);
      //ItemList.GetHeight;
      if ItemList.Visible then
        if (Y >= ItemList.Top - nTop) and (Y <= (ItemList.Top - nTop) + (ItemList.Height - ItemList.Top)) then begin
          FItemIndex := I;
       { DebugOutStr(Name+' OnScroll nIndex1:'+IntToStr(nIndex)+
        ' FDScroll.Position:'+IntToStr(FDScroll.Position)+' nTop:'+IntToStr(nTop)+
        ' nBottom:'+IntToStr(nBottom)+
        ' ItemList.MinTop:'+IntToStr(ItemList.MinTop));}
          break;
        end;
    end;
  end;
end;

function TDScrollBox.GetItems(Index: Integer): TStringList;
begin
  Result := TStringList(FLines.Items[Index]);
end;

function TDScrollBox.GetMaxLineHeight: Integer;
var
  I, II, nPosition: Integer;
  nHeight: Integer;
  ItemList: TDLines;
begin
  Result := 0;
  nHeight := 0;
  nPosition := 0;

  if FDScroll <> nil then
    nPosition := FDScroll.Position;

  for I := 0 to FLines.Count - 1 do begin
    ItemList := TDLines(FLines.Items[I]);
    if ItemList.Visible then
      nHeight := Math.Max(ItemList.Height + nPosition, nHeight);
    //DebugOutStr(Name+' GetMaxHeight ItemList.Height:'+IntToStr(ItemList.Height));
  end;
  Result := Math.Max(Math.Max(nHeight - SurfaceY(GTop), 0), FMaxHeight);
end;

function TDScrollBox.GetStrings(Index: Integer): string;
var
  ItemList: TDLines;
begin
  ItemList := TDLines(Items[Index]);
  Result := ItemList.Text;
end;

{function TDScrollBox.GetText: string;
var
  I: Integer;
  ItemList: TDLines;
  SaveList: TStringList;
begin
  SaveList := TStringList.Create;
  try
    for I := 0 to Count - 1 do begin
      ItemList := TDLines(Items[I]);
      SaveList.Add(ItemList.Text);
    end;
    Result := SaveList.Text;
  finally
    SaveList.Free;
  end;
end;   }

function TDScrollBox.KeyDown(var Key: Word; Shift: TShiftState): Boolean;
begin
  Result := inherited KeyDown(Key, Shift);
end;

function TDScrollBox.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer): Boolean;
begin
  Result := False;
  if InRange(X, Y) then GetItemIndex(Y);
  if inherited MouseDown(Button, Shift, X, Y) then begin
    if (not Background) then begin
      if (MouseCaptureControl = nil) then begin
        SetDCapture(Self);
        //Showmessage('SetDCapture(Self)');
      end;
    end;
    if InRange(X, Y) and (MouseCaptureControl <> Self) then begin
      if Assigned(OnMouseDown) then
        OnMouseDown(Self, Button, Shift, X, Y);
        //if EnableFocus then SetDFocus(Self);
         //else ReleaseDFocus;
    end;
    Result := True;
  end;
end;

function TDScrollBox.MouseMove(Shift: TShiftState; X, Y: Integer): Boolean;
begin
  Result := inherited MouseMove(Shift, X, Y);
end;

function TDScrollBox.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer): Boolean;
var
  I: Integer;
  d: TDControl;
  boDown: Boolean;
begin
  Result := False;
  ReleaseDCapture;
  if inherited MouseUp(Button, Shift, X, Y) then begin
    if not Background then begin
      if InRange(X, Y) then begin
        //Downed := False;
        if Assigned(FOnClickSound) then FOnClickSound(Self, FClickSound);
        if Assigned(FOnClick) then FOnClick(Self, X, Y);
      end;
    end;
    //Downed := False;
    Result := True;
    Exit;
  end else begin
    ReleaseDCapture;
    //Downed := False;
  end;
end;



{procedure TDScrollBox.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited;

end; }

procedure TDScrollBox.SetDScroll(Value: TDScrollBar);
begin
  if FDScroll <> Value then FDScroll := Value;
  if FDScroll <> nil then FDScroll.OnScroll := OnScroll;
end;

procedure TDScrollBox.SetItemIndex(Value: Integer);
begin
  FItemIndex := Value;
end;

procedure TDScrollBox.SetMaxLineHeight(Value: Integer);
begin
  if FMaxHeight <> Value then begin
    FMaxHeight := Value;
    if FDScroll <> nil then
      FDScroll.MaxValue := GetMaxLineHeight + FSpareSize;
    //DoScroll(0);
    OnScroll(Self, 0);
  end;
end;

{procedure TDScrollBox.SetText(Value: string);
begin

end; }

{ TDLines }

function TDLines.Add(const S: string): Integer;
begin
  Result := inherited Add(S);
end;

function TDLines.AddObject(const S: string; AObject: TObject): Integer;
var
  D: TDControl;
begin
  Result := inherited AddObject(S, AObject);
  if Result >= 0 then begin
    if AObject <> nil then begin
      D := TDControl(AObject);
      FWidth := FWidth + D.GWidth;

      if FTop >= D.SurfaceY(D.GTop) then
        FTop := D.SurfaceY(D.GTop);

      if FHeight < D.SurfaceY(D.GTop) + D.GHeight then
        FHeight := D.SurfaceY(D.GTop) + D.GHeight;

      if FItemSize < D.GHeight then
        FItemSize := D.GHeight;
      {DebugOutStr(TDControl(AObject).Name+' D.SurfaceY(D.Top) + D.Height + D.PosY:'+IntToStr(D.SurfaceY(D.Top) + D.Height + D.PosY)
      +' FHeight:'+IntToStr(FHeight));}
    end;
  end;
end;

procedure TDLines.Clear;
begin
  inherited;
  FTop := High(Integer);
  FLeft := 0;
  FWidth := 0;
  FHeight := 0;
  FItemSize := 0;
end;

constructor TDLines.Create;
begin
  inherited;
  FTop := High(Integer);
  FLeft := 0;
  FWidth := 0;
  FHeight := 0;
  FItemSize := 0;
  FData := nil;
  FVisible := True;
end;

procedure TDLines.Delete(Index: Integer);
var
  I: Integer;
  D: TDControl;
begin
  inherited Delete(Index);
  FWidth := 0;
  FHeight := 0;
  FTop := High(Integer);
  FItemSize := 0;
  for I := 0 to Count - 1 do begin
    D := TDControl(Objects[I]);
    if D <> nil then begin
      FWidth := FWidth + D.GWidth;

      if FTop >= D.SurfaceY(D.GTop) then
        FTop := D.SurfaceY(D.GTop);

      if FHeight < D.SurfaceY(D.GTop) + D.GHeight then
        FHeight := D.SurfaceY(D.GTop) + D.GHeight;

      if FItemSize < D.GHeight then
        FItemSize := D.GHeight;
      {DebugOutStr(TDControl(AObject).Name+' TDControl(AObject).Height:'+IntToStr(TDControl(AObject).Height)
      +' FHeight:'+IntToStr(FHeight));}
    end;
  end;
end;

destructor TDLines.Destroy;
begin

  inherited;
end;

function TDLines.GetHeight: Integer;
var
  I: Integer;
  D: TDControl;
begin
  FTop := High(Integer);
  FLeft := 0;
  FWidth := 0;
  FHeight := 0;
  FItemSize := 0;
  for I := 0 to Count - 1 do begin
    D := TDControl(Objects[I]);
    if D <> nil then begin
      with d do begin
        FWidth := FWidth + GWidth;

        if FTop >= SurfaceY(GTop) then
          FTop := SurfaceY(GTop);

        if FHeight < SurfaceY(GTop) + GHeight then
          FHeight := SurfaceY(GTop) + GHeight;

        if FItemSize < GHeight then
          FItemSize := GHeight;
      end;
      {DebugOutStr(TDControl(AObject).Name+' TDControl(AObject).Height:'+IntToStr(TDControl(AObject).Height)
      +' FHeight:'+IntToStr(FHeight));}
    end;
  end;
  Result := FHeight;
end;

function TDLines.GetText: string;
var
  I: Integer;
begin
  Result := '';
  for I := 0 to Count - 1 do
    Result := Result + Strings[I];
end;

end.
