unit uAspDScrollBox;

interface
uses Types, AspDWinCtl, Classes, AbstractCanvas, AbstractTextures, uAspDScrollBar, Controls, Math;
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

  TAspDScrollBox = class(TAspDControl)
  private
    FLines: TList;
    FBackSurface: TAsphyreCanvas;
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
    FDScroll: TAspDScrollBar;
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
    procedure SetDScroll(Value: TAspDScrollBar);
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
    procedure DirectPaint(dsurface: TAsphyreCanvas); override;

    function KeyDown(var Key: Word; Shift: TShiftState): Boolean;
    function MouseMove(Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;

    function Add: TStringList;

    function AddSuItem(SubItems: TStringList; DControl: TAspDControl): TAspDControl; //overload;
    function DelSuItem(DControl: TAspDControl): Boolean;
    function InSuItem(DControl: TAspDControl): Boolean;
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
    property DScroll: TAspDScrollBar read FDScroll write SetDScroll;
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
uses
  uMyDxUnit, AspHUtil32;

procedure Register;
begin
   RegisterComponents('AspMirGame', [TAspDScrollBox]);
end;
{ TAspDScrollBox }

function TAspDScrollBox.Add: TStringList;
begin
  Result := TDLines.Create;
  FLines.Add(Result);
end;

function TAspDScrollBox.AddSuItem(SubItems: TStringList;
  DControl: TAspDControl): TAspDControl;
begin
  SubItems.AddObject(DControl.Caption, DControl);
  if FDScroll <> nil then begin
    FDScroll.MaxValue := GetMaxLineHeight + FSpareSize;
  end;
  //DoScroll(0);
  OnScroll(Self, 0);
  Result := DControl;
end;

function TAspDScrollBox.DelSuItem(DControl: TAspDControl): Boolean;
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

function TAspDScrollBox.InSuItem(DControl: TAspDControl): Boolean;
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

procedure TAspDScrollBox.Clear;
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
      TAspDControl(ItemList.Objects[II]).Free;
    end;
    ItemList.Free;
  end;
  FLines.Clear;
  if FDScroll <> nil then begin
    FDScroll.Position := 0;
    FDScroll.MaxValue := 0;
  end;
end;

constructor TAspDScrollBox.Create(AOwner: TComponent);
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

procedure TAspDScrollBox.Delete(Index: Integer);
var
  I, II, nTop, nItemSize: Integer;
  ItemList: TDLines;
  D: TAspDControl;
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
            D := TAspDControl(ItemList.Objects[II]);
            D.GTop := D.GTop - nItemSize;
            D.Visible := True;
          end;
        end else begin
          for II := 0 to ItemList.Count - 1 do begin
            D := TAspDControl(ItemList.Objects[II]);
            D.GTop := D.GTop - nItemSize;
            D.Visible := False;
          end;
        end;
      end;
    end;
  end;
end;

destructor TAspDScrollBox.Destroy;
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

procedure TAspDScrollBox.DirectPaint(dsurface: TAsphyreCanvas);
var
  I: Integer;
  rc: TRect;
  nX, nY, nWidth, nHeight: Integer;
  ItemList: TDLines;
  d: TAsphyreLockableTexture;
  DControl: TAspDControl;
  OldClipRect: TRect;
  NewClipRect: TRect;
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
  OldClipRect := dsurface.ClipRect;
  //ÐÞ¸´ÏÔÊ¾·¶Î§Òì³£µ¼ÖÂµÄ¿¨ÆÁ»­ÆÁ By TasNat at: 2012-04-03 16:51:19
  NewClipRect := ClientRect;
  NewClipRect.Top := _Max(0, NewClipRect.Top);
  NewClipRect.Left := _Max(0, NewClipRect.Left);
  NewClipRect.Bottom := _Min(g_GameDevice.Size.Y, GHeight + ClientRect.Top);
  NewClipRect.Right := _Min(g_GameDevice.Size.X, GWidth + ClientRect.Left);
  //·¶Î§¼ì²â
  if (NewClipRect.Bottom <= 0) or (NewClipRect.Right <= 0) or
     ((NewClipRect.Bottom - NewClipRect.Top) <= 0) or ((NewClipRect.Right - NewClipRect.Left) <= 0) then Exit;
  
  dsurface.ClipRect := NewClipRect;
  try//Ôö¼Ótry±£»¤ By TasNat at: 2012-04-03 16:46:15
    for i:=0 to DControls.Count-1 do
      if TAspDControl(DControls[i]).Visible then
        TAspDControl(DControls[i]).DirectPaint(dsurface);

  finally
    dsurface.ClipRect := OldClipRect;
  end;
end;

{procedure TAspDScrollBox.DoScroll(Value: Integer);
begin
end;}

procedure TAspDScrollBox.OnScroll(Sender: TObject; Increment: Integer);
var
  I, II, nTop: Integer;
  ItemList: TDLines;
  D: TAspDControl;
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
          D := TAspDControl(ItemList.Objects[II]);
          D.GTop := D.GTop + Increment;
          D.Visible := True;
        end;
      end else begin
        for II := 0 to ItemList.Count - 1 do begin
          D := TAspDControl(ItemList.Objects[II]);
          D.GTop := D.GTop + Increment;
          D.Visible := False;
        end;
      end;
    end;
  end;
end;

function TAspDScrollBox.GetCount: Integer;
begin
  Result := FLines.Count;
end;

procedure TAspDScrollBox.GetItemIndex(Y: Integer);
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

function TAspDScrollBox.GetItems(Index: Integer): TStringList;
begin
  Result := TStringList(FLines.Items[Index]);
end;

function TAspDScrollBox.GetMaxLineHeight: Integer;
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

function TAspDScrollBox.GetStrings(Index: Integer): string;
var
  ItemList: TDLines;
begin
  ItemList := TDLines(Items[Index]);
  Result := ItemList.Text;
end;

{function TAspDScrollBox.GetText: string;
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

function TAspDScrollBox.KeyDown(var Key: Word; Shift: TShiftState): Boolean;
begin
  Result := inherited KeyDown(Key, Shift);
end;

function TAspDScrollBox.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
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

function TAspDScrollBox.MouseMove(Shift: TShiftState; X, Y: Integer): Boolean;
begin
  Result := inherited MouseMove(Shift, X, Y);
end;

function TAspDScrollBox.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer): Boolean;
var
  I: Integer;
  d: TAspDControl;
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



{procedure TAspDScrollBox.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited;

end; }

procedure TAspDScrollBox.SetDScroll(Value: TAspDScrollBar);
begin
  if FDScroll <> Value then FDScroll := Value;
  if FDScroll <> nil then FDScroll.OnScroll := OnScroll;
end;

procedure TAspDScrollBox.SetItemIndex(Value: Integer);
begin
  FItemIndex := Value;
end;

procedure TAspDScrollBox.SetMaxLineHeight(Value: Integer);
begin
  if FMaxHeight <> Value then begin
    FMaxHeight := Value;
    if FDScroll <> nil then
      FDScroll.MaxValue := GetMaxLineHeight + FSpareSize;
    //DoScroll(0);
    OnScroll(Self, 0);
  end;
end;

{procedure TAspDScrollBox.SetText(Value: string);
begin

end; }

{ TDLines }

function TDLines.Add(const S: string): Integer;
begin
  Result := inherited Add(S);
end;

function TDLines.AddObject(const S: string; AObject: TObject): Integer;
var
  D: TAspDControl;
begin
  Result := inherited AddObject(S, AObject);
  if Result >= 0 then begin
    if AObject <> nil then begin
      D := TAspDControl(AObject);
      FWidth := FWidth + D.GWidth;

      if FTop >= D.SurfaceY(D.GTop) then
        FTop := D.SurfaceY(D.GTop);

      if FHeight < D.SurfaceY(D.GTop) + D.GHeight then
        FHeight := D.SurfaceY(D.GTop) + D.GHeight;

      if FItemSize < D.GHeight then
        FItemSize := D.GHeight;
      {DebugOutStr(TAspDControl(AObject).Name+' D.SurfaceY(D.Top) + D.Height + D.PosY:'+IntToStr(D.SurfaceY(D.Top) + D.Height + D.PosY)
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
  D: TAspDControl;
begin
  inherited Delete(Index);
  FWidth := 0;
  FHeight := 0;
  FTop := High(Integer);
  FItemSize := 0;
  for I := 0 to Count - 1 do begin
    D := TAspDControl(Objects[I]);
    if D <> nil then begin
      FWidth := FWidth + D.GWidth;

      if FTop >= D.SurfaceY(D.GTop) then
        FTop := D.SurfaceY(D.GTop);

      if FHeight < D.SurfaceY(D.GTop) + D.GHeight then
        FHeight := D.SurfaceY(D.GTop) + D.GHeight;

      if FItemSize < D.GHeight then
        FItemSize := D.GHeight;
      {DebugOutStr(TAspDControl(AObject).Name+' TAspDControl(AObject).Height:'+IntToStr(TAspDControl(AObject).Height)
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
  D: TAspDControl;
begin
  FTop := High(Integer);
  FLeft := 0;
  FWidth := 0;
  FHeight := 0;
  FItemSize := 0;
  for I := 0 to Count - 1 do begin
    D := TAspDControl(Objects[I]);
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
      {DebugOutStr(TAspDControl(AObject).Name+' TAspDControl(AObject).Height:'+IntToStr(TAspDControl(AObject).Height)
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
