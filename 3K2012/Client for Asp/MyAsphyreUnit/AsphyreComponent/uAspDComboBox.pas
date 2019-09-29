unit uAspDComboBox;

interface
uses AspDWinCtl, Classes, Graphics, uAspDPopupMenu, AbstractCanvas, AbstractTextures,
     AsphyreTextureFonts,Controls, Math;

type
  TAspDCombobox = class(TAspDControl)
  private
    FItems: TStrings;
    FClickSound: TClickSound;
    FOnClick: TOnClickEx;
    FOnClickSound: TOnClickSound;
    FOnChange: TNotifyEvent;
    FOnPopup: TNotifyEvent;
    FAutoSize: Boolean;

    FCurrColor: TColor;
    FUpColor: TColor;
    FHotColor: TColor;
    FDownColor: TColor;

    FButtonColor: TColor;

    FBackground: Boolean;
    FBackgroundColor: TColor;
    FBorder: Boolean;
    FBorderColor: TColor;
    FHotBorder: TColor;
    FDownBorder: TColor;
    FMainMenu: TAspDPopupMenu;

    FBorderCurrColor: TColor;

    FAlignment: TAlignment;
    function GetText(): string;
    procedure SetText(Value: string);
    procedure SetUpColor(Value: TColor);
    procedure SetItems(Value: TStrings);
    function GetItems: TStrings;

    procedure SetItemIndex(Value: Integer);
    function GetItemIndex: Integer;
    procedure MainMenuClick(Sender: TObject; X, Y: Integer);
    procedure SetAlignment(Value: TAlignment);
    procedure ItemChanged(Sender: TObject);
  protected
    procedure CaptionChaged; override;
    procedure CreateWnd; override;
  public
    Downed: Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function InRange(X, Y: Integer): Boolean; override;
    procedure DirectPaint(dsurface: TAsphyreCanvas); override;
    procedure Process; override;
    function MouseMove(Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
  published
    property Alignment: TAlignment read FAlignment write SetAlignment;
    property Items: TStrings read GetItems write SetItems;
    property ItemIndex: Integer read GetItemIndex write SetItemIndex;

    property AutoSize: Boolean read FAutoSize write FAutoSize;
    property UpColor: TColor read FUpColor write SetUpColor;
    property HotColor: TColor read FHotColor write FHotColor;
    property DownColor: TColor read FDownColor write FDownColor;
    property BackgroundColor: TColor read FBackgroundColor write FBackgroundColor;
    property BorderColor: TColor read FBorderColor write FBorderColor;

    property HotBorderColor: TColor read FHotBorder write FHotBorder;
    property DownBorderColor: TColor read FDownBorder write FDownBorder;

    property DrawBackground: Boolean read FBackground write FBackground;
    property Border: Boolean read FBorder write FBorder;
    property ButtonColor: TColor read FButtonColor write FButtonColor;

    property ClickCount: TClickSound read FClickSound write FClickSound;
    property OnClick: TOnClickEx read FOnClick write FOnClick;
    property OnClickSound: TOnClickSound read FOnClickSound write FOnClickSound;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnPopup: TNotifyEvent read FOnPopup write FOnPopup;
    property MainMenu: TAspDPopupMenu read FMainMenu write FMainMenu;
    property Text: string read GetText write SetText;
  end;
procedure Register;
implementation

procedure Register;
begin
  RegisterComponents('AspMirGame', [TAspDCombobox]);
end;

{ TAspDCombobox }

constructor TAspDCombobox.Create(AOwner: TComponent);
begin
  inherited Create(aowner);
  FItems := TStringList.Create();
  TStringList(FItems).OnChange := ItemChanged;
  MainMenu := TAspDPopupMenu.Create(Self);
  //MainMenu.DParent := Self;
  //AddChild(MainMenu);
  MainMenu.Visible := False;
  //MainMenu.OnClick := PopupMenuClick;
  //MainMenu.PopupMenu := Self;
  FAutoSize := False;
  Downed := False;
  FOnClick := nil;
  EnableFocus := True;
  FClickSound := csNone;
  Caption := Name;
  FUpColor := Canvas.Font.Color;
  FHotColor := Canvas.Font.Color;
  FDownColor := Canvas.Font.Color;
  FBackgroundColor := clWhite;

  FBorderColor := $00608490;

  FHotBorder := $005894B8;
  FDownBorder := $005894B8;
  FButtonColor := $00488184;
  FCurrColor := FUpColor;

  FBackground := False;
  FBorder := True;
  //FMainMenu := nil;
  FOnChange := nil;
  FOnPopup := nil;
  FAlignment := taCenter;
end;

procedure TAspDCombobox.SetAlignment(Value: TAlignment);
begin
  if FAlignment <> Value then begin
    FAlignment := Value;
  end;
end;

destructor TAspDCombobox.Destroy;
begin
  FItems.Free;
  MainMenu.Free;
  inherited Destroy;
end;

function TAspDCombobox.InRange(X, Y: Integer): Boolean;
var
  boInrange: Boolean;
begin
  if (X >= GLeft) and (X < GLeft + GWidth) and (Y >= GTop) and (Y < GTop + GHeight) then begin
    boInrange := True;
    if Assigned(OnInRealArea) then
      OnInRealArea(Self, X - GLeft, Y - GTop, boInrange);
    Result := boInrange;
  end else
    Result := False;
end;

procedure TAspDCombobox.SetUpColor(Value: TColor);
begin
  if FUpColor <> Value then begin
    FUpColor := Value;
    FCurrColor := Value;
  end;
end;

function TAspDCombobox.MouseMove(Shift: TShiftState; X, Y: Integer): Boolean;
begin
  Result := inherited MouseMove(Shift, X, Y);
  if (not Background) and (not Result) then begin
    Result := inherited MouseMove(Shift, X, Y);
    if MouseCaptureControl = Self then
      if InRange(X, Y) then Downed := True
      else Downed := False;
    if Result and (not Downed) then FCurrColor := FHotColor;
  end;
end;

function TAspDCombobox.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
begin
  Result := False;
  if inherited MouseDown(Button, Shift, X, Y) then begin
    if Enabled then begin
      if (not Background) and (MouseCaptureControl = nil) then begin
        Downed := True;
        SetDCapture(Self);
        if Assigned(FMainMenu) then begin

        //if Downed and (FMainMenu <> ActiveMenu) then begin

       { if SurfaceX(Left) + FMainMenu.Width > SCREENWIDTH then FMainMenu.Left := SCREENWIDTH - FMainMenu.Width
        else FMainMenu.Left := SurfaceX(Left);
        }
          FMainMenu.GLeft := SurfaceX(GLeft);
          FMainMenu.GWidth := GWidth;
          if SurfaceY(GTop + GHeight) + FMainMenu.GHeight > 600 then FMainMenu.GTop := SurfaceY(GTop - FMainMenu.GHeight)
          else FMainMenu.GTop := SurfaceY(GTop + GHeight);

          if Assigned(FOnPopup) then FOnPopup(Self);

          FMainMenu.OnClick := MainMenuClick;
          FMainMenu.MenuItems := Items;
          FMainMenu.Show(Self);
        //end;
        end;
      end;
      Result := True;
    end;
  end;
end;

function TAspDCombobox.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
begin
  Result := False;
  if inherited MouseUp(Button, Shift, X, Y) then begin
    ReleaseDCapture;
    if Enabled then begin
      if not Background then begin
        if InRange(X, Y) and Enabled then begin
          if mbLeft = Button then begin
            if Assigned(FOnClickSound) then FOnClickSound(Self, FClickSound);
            if Assigned(FOnClick) then FOnClick(Self, X, Y);
          end;
        end;
      end;
      Downed := False;
      Result := True;
      Exit;
    end;
  end else begin
    ReleaseDCapture;
    Downed := False;
  end;
end;

procedure TAspDCombobox.CreateWnd;
begin
  inherited;
  if FItems = nil then FItems := TStringList.Create();
  TStringList(FItems).OnChange := ItemChanged;
end;

function TAspDCombobox.GetItems: TStrings;
begin
  if csDesigning in ComponentState then Refresh;
  Result := FItems;
end;

function TAspDCombobox.GetText: string;
begin
  Result := Caption;
end;

procedure TAspDCombobox.SetItems(Value: TStrings);
begin
  FItems.Clear;
  FItems.Assign(Value);
end;

procedure TAspDCombobox.SetText(Value: string);
begin
  Caption := Value;
end;

procedure TAspDCombobox.SetItemIndex(Value: Integer);
begin
  if (FMainMenu <> nil) {and (Value >= 0) and (Value < FItems.Count)} then begin
    FMainMenu.MenuItems := Items;
    FMainMenu.ItemIndex := Value;
    if (FMainMenu.ItemIndex >= 0) and (FMainMenu.ItemIndex < FMainMenu.Count) and (FMainMenu.MenuItems[FMainMenu.ItemIndex] <> '-') then
      Caption := FMainMenu.MenuItems[FMainMenu.ItemIndex];
  end;
end;

function TAspDCombobox.GetItemIndex: Integer;
begin
  if (FMainMenu <> nil) then
    Result := FMainMenu.ItemIndex
  else Result := -1;
end;

procedure TAspDCombobox.MainMenuClick(Sender: TObject; X, Y: Integer);
begin
  if (FMainMenu.ItemIndex >= 0) and (FMainMenu.MenuItems[FMainMenu.ItemIndex] <> '-') then
    Caption := FMainMenu.MenuItems[FMainMenu.ItemIndex];
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TAspDCombobox.ItemChanged(Sender: TObject);
begin
  //Caption := '';
  ItemIndex := GetItemIndex;
end;

procedure TAspDCombobox.CaptionChaged;
var
  OldSize: Integer;
begin
  if Assigned(AspTextureFont) then begin
  //if not (csDesigning in ComponentState) then begin
    OldSize := FontManager.FontSize;
    FontManager.SetFont('宋体', Font.Size);
    if FAutoSize then begin
      GWidth := AspTextureFont.TextWidth(Caption);
      GHeight := AspTextureFont.TextHeight('0');
    end;
    GWidth := Max(GWidth, 6);
    GHeight := Max(GHeight, 20);
    FontManager.SetFont('宋体', OldSize);
  end;
end;

procedure TAspDCombobox.Process;
var
  I: Integer;
begin
  if Assigned(OnProcess) then OnProcess(Self);
  if Enabled then begin
    if Downed then begin
      FCurrColor := FDownColor;
    end else
      if MouseMoveing then begin
      FCurrColor := FHotColor;
    end else begin
      FCurrColor := FUpColor;
    end;
  end else FCurrColor := clGray;

  FBorderCurrColor := FBorderColor;
  if Enabled then begin
    if MouseMoveControl = Self then FBorderCurrColor := FHotBorder;
  end else FBorderCurrColor := clGray;

  for I := 0 to DControls.Count - 1 do
    if TAspDControl(DControls[I]).Visible then
      TAspDControl(DControls[I]).Process;
end;

procedure TAspDCombobox.DirectPaint(dsurface: TAsphyreCanvas);
var
  I, nX: Integer;
  d: TAsphyreLockableTexture;
begin
  if FBackground then
    dsurface.FillRect(ClientRect, FBackgroundColor);
  if FBorder then
    dsurface.FrameRect(ClientRect, FBorderCurrColor);

  if Assigned(OnDirectPaint) then
    OnDirectPaint(Self, dsurface)
  else
    if WLib <> nil then begin
    d := WLib.Images[FaceIndex];
    if d <> nil then begin
      dsurface.Draw(SurfaceX(GLeft), SurfaceY(GTop), d.ClientRect, d, True);
    end;
  end;

  if Caption <> '' then begin
    case FAlignment of
      taLeftJustify: nX := SurfaceX(GLeft)+2;
      taRightJustify: nX := Max(SurfaceX(GLeft), SurfaceX(GLeft + (GWidth - 16 - AspTextureFont.TextWidth(Caption))));
      taCenter: nX := SurfaceX(GLeft) + (GWidth - 16 - AspTextureFont.TextWidth(Caption)) div 2;
    end;
    AspTextureFont.TextOut(nX,
      SurfaceY(GTop) + (GHeight - AspTextureFont.TextHeight('0')) div 2, FCurrColor, Caption);
  end;

//画三角形
{-------------------------------------------------------------------------------}
  {X1 := SurfaceX(GLeft) + (GWidth - 16) + 5;
  Y1 := SurfaceY(GTop) + (GHeight - 5) div 2;

  if Downed then Y1 := Y1 + 1;
  X2 := X1 + 3;
  Y2 := Y1 + 4;

  for I := X1 to X1 + 6 do begin
    dsurface.Line(I, Y1, X2, Y2, FButtonColor);
  end;                 }
{-------------------------------------------------------------------------------}

  for I := 0 to DControls.Count - 1 do
    if TAspDControl(DControls[I]).Visible then
      TAspDControl(DControls[I]).DirectPaint(dsurface);
end;

end.
