unit uAspDPopupMenu;

interface
uses AspDWinCtl, Classes, Graphics, AbstractCanvas, AbstractTextures, AsphyreTextureFonts, Controls, Menus, SysUtils, Windows;

type
  TAspDPopupMenu = class;
  TMenuStyle = (sXP, sVista);
  TImageIndex = type Integer;
  TColors = class(TGraphicsObject)
  private
    FDisabled: TColor;
    FBkgrnd: TColor;
    FSelected: TColor;
    FBorder: TColor;
    FFont: TColor;
    FHot: TColor;
    FDown: TColor;
    FLine: TColor;
    FUp: TColor;
  public
    constructor Create();
  published
    property Disabled: TColor read FDisabled write FDisabled;
    property Background: TColor read FBkgrnd write FBkgrnd;
    property Selected: TColor read FSelected write FSelected;
    property Border: TColor read FBorder write FBorder;
    property Font: TColor read FFont write FFont;
    property Up: TColor read FUp write FUp;
    property Hot: TColor read FHot write FHot;
    property Down: TColor read FDown write FDown;
    property Line: TColor read FLine write FLine;
  end;

  TDMenuItem = class(TObject)
  private
    FVisible: Boolean;
    FEnabled: Boolean;
    FCaption: string;
    FMenu: TAspDPopupMenu;
    FChecked: Boolean;
  public
    constructor Create();
    destructor Destroy; override;
    property Visible: Boolean read FVisible write FVisible;
    property Enabled: Boolean read FEnabled write FEnabled;
    property Caption: string read FCaption write FCaption;
    property Checked: Boolean read FChecked write FChecked;
    property Menu: TAspDPopupMenu read FMenu write FMenu;
  end;

  TAspDPopupMenu = class(TAspDControl)
  private
    FItems: TStrings;
    FColors: TColors;
    FMoveItemIndex: Integer;
    FItemSize: Integer;
    FMouseMove: Boolean;
//    FMouseDown: Boolean;

    FOwnerMenu: TAspDPopupMenu;
    FItemIndex: Integer;
    FOwnerItemIndex: TImageIndex;
    FActiveMenu: TAspDPopupMenu;
    FDControl: TAspDControl;

    FStyle: TMenuStyle;

    function GetMenu(Index: Integer): TAspDPopupMenu;
    procedure SetMenu(Index: Integer; Value: TAspDPopupMenu);
    function GetItem(Index: Integer): TDMenuItem;
    function GetCount: Integer;
    procedure SetOwnerItemIndex(Value: TImageIndex);
    procedure SetOwnerMenu(Value: TAspDPopupMenu);
    procedure SetItems(Value: TStrings);
    function GetItems: TStrings;
    procedure SetColors(Value: TColors);

    procedure SetItemIndex(Value: Integer);
  protected
    procedure CreateWnd; override;
  public
    Downed: Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
    procedure Process; override;
    function InRange(X, Y: Integer): Boolean; override;
    procedure DirectPaint(dsurface: TAsphyreCanvas); override;
    function KeyPress(var Key: Char): Boolean; override;
    function KeyDown(var Key: Word; Shift: TShiftState): Boolean; override;
    function MouseMove(Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
    function Click(X, Y: Integer): Boolean; override;
    procedure Show; overload;
    procedure Show(d: TAspDControl); overload;
    procedure Hide;
    procedure Insert(Index: Integer; ACaption: string; Item: TAspDPopupMenu);
    procedure Delete(Index: Integer);
    procedure Clear;
    function Find(ACaption: string): TAspDPopupMenu;
    function IndexOf(Item: TAspDPopupMenu): Integer;
    procedure Add(ACaption: string; Item: TAspDPopupMenu);
    procedure Remove(Item: TAspDPopupMenu);
    property Count: Integer read GetCount;
    property Menus[Index: Integer]: TAspDPopupMenu read GetMenu write SetMenu;
    property Items[Index: Integer]: TDMenuItem read GetItem;
    property DControl: TAspDControl read FDControl write FDControl;
  published
    property OwnerMenu: TAspDPopupMenu read FOwnerMenu write SetOwnerMenu;
    property OwnerItemIndex: TImageIndex read FOwnerItemIndex write SetOwnerItemIndex default -1;
    property MenuItems: TStrings read GetItems write SetItems;
    property Colors: TColors read FColors write SetColors;
    property ItemIndex: Integer read FItemIndex write SetItemIndex default -1;
    property Style: TMenuStyle read FStyle write FStyle;
  end;



var
  ActiveMenu: TAspDPopupMenu;
  DefaultCurFontName:string='ËÎÌו';

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('AspMirGame', [TAspDPopupMenu]);
end;

{ TColors }

constructor TColors.Create;
begin
  inherited Create;
  FDisabled := clBtnFace;
  FSelected := clWhite;
  FBkgrnd := clWhite;
  FBorder := $007F7F7F;
  FFont := clBlack;
  FUp := $00F1EFAB;
  FHot := clNavy;
  FDown := $00F1EFAB;
  FLine := clBtnFace;
end;
{ TDMenuItem }

constructor TDMenuItem.Create();
begin
  inherited;
  FVisible := True;
  FEnabled := True;
  FChecked := False;
  FCaption := '';
  FMenu := nil;
end;

destructor TDMenuItem.Destroy;
begin
  //if FMenu <> nil then FMenu.Free;
  inherited;
end;
{ TAspDPopupMenu }

constructor TAspDPopupMenu.Create(AOwner: TComponent);
begin
  inherited Create(aowner);
  FItems := TStringList.Create();
  FColors := TColors.Create;
  FActiveMenu := nil;
  FOwnerMenu := nil;
  FOwnerItemIndex := 0;
  FMoveItemIndex := -1;
  FItemIndex := -1;
  GWidth := 150;
  GHeight := 100;
  FStyle := sXP;
  Add('Item1', nil);
  Add('Item2', nil);
  Add('Item3', nil);
  Add('Item4', nil);
end;

destructor TAspDPopupMenu.Destroy;
begin
  while Count > 0 do begin
    Items[0].Free;
    Delete(0);
  end;
  FItems.Free;
  FColors.Free;
  inherited Destroy;
end;

procedure TAspDPopupMenu.Paint;
var
  I: Integer;
begin
  if csDesigning in ComponentState then begin
    with Canvas do begin
      Brush.Color := clMenu;
      FillRect(ClipRect);
      Pen.Color := clInactiveBorder;

      for I := 0 to Count - 1 do begin
        MoveTo(5, Height div Count * I);
        LineTo(Width - 5, Height div Count * I);
        TextOut((Width - TextWidth(FItems[I])) div 2, Height div Count * I + (Height div Count - TextHeight(FItems[I])) div 2, FItems[I]);
      end;

      MoveTo(0, 0);
      LineTo(Width - 1, 0);
      LineTo(Width - 1, Height - 1);
      LineTo(0, Height - 1);
      LineTo(0, 0);
    end;
  end;
end;

procedure TAspDPopupMenu.CreateWnd;
begin
  inherited;
  if FItems = nil then FItems := TStringList.Create();
end;

procedure TAspDPopupMenu.SetOwnerMenu(Value: TAspDPopupMenu);
var
  Index: Integer;
begin
  if FOwnerMenu <> Value then begin
    if (FOwnerMenu <> nil) then begin
      Index := FOwnerMenu.IndexOf(Self);
      if Index >= 0 then begin
        FOwnerMenu.Menus[Index] := nil;
      end;
    end;
    FOwnerMenu := Value;
  end;
end;

procedure TAspDPopupMenu.SetOwnerItemIndex(Value: TImageIndex);
var
  Index: Integer;
begin
  if FOwnerMenu <> nil then begin
    if (FOwnerItemIndex >= 0) and (FOwnerItemIndex < FOwnerMenu.Count) then FOwnerMenu.Menus[FOwnerItemIndex] := nil;
    if (Value >= 0) and (Value < FOwnerMenu.Count) then begin
      for Index := Value to FOwnerMenu.Count - 1 do begin
        if FOwnerMenu.Menus[Index] = nil then begin
          FOwnerMenu.Menus[Index] := Self;
          FOwnerItemIndex := Index;
          Break;
        end;
      end;
    end else FOwnerItemIndex := -1;
  end else FOwnerItemIndex := -1;
end;

function TAspDPopupMenu.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TAspDPopupMenu.GetItems: TStrings;
begin
  if csDesigning in ComponentState then Refresh;
  Result := FItems;
end;

procedure TAspDPopupMenu.SetColors(Value: TColors);
begin
  FColors.Assign(Value);
end;

procedure TAspDPopupMenu.SetItems(Value: TStrings);
var
  I: Integer;
begin
  Clear;
  FItems.Assign(Value);
  for I := 0 to FItems.Count - 1 do begin
    FItems.Objects[I] := nil;
    FItems.Objects[I] := TDMenuItem.Create;
  end;
end;

procedure TAspDPopupMenu.SetItemIndex(Value: Integer);
begin
  FItemIndex := Value;
  if FItemIndex >= FItems.Count then FItemIndex := -1;
  {if FItemIndex <> Value then begin

  end;}
end;

function TAspDPopupMenu.GetItem(Index: Integer): TDMenuItem;
begin
  if (Index >= 0) and (Index < FItems.Count) then begin
    if FItems.Objects[Index] = nil then begin
      FItems.Objects[Index] := TDMenuItem.Create;
    end;
    Result := TDMenuItem(FItems.Objects[Index]);
  end else Result := nil;
end;

function TAspDPopupMenu.GetMenu(Index: Integer): TAspDPopupMenu;
begin
  if (Index >= 0) and (Index < FItems.Count) then begin
    if FItems.Objects[Index] = nil then begin
      FItems.Objects[Index] := TDMenuItem.Create;
    end;
    Result := TAspDPopupMenu(TDMenuItem(FItems.Objects[Index]).Menu);
  end else Result := nil;
end;

procedure TAspDPopupMenu.SetMenu(Index: Integer; Value: TAspDPopupMenu);
begin
  if FItems.Objects[Index] = nil then begin
    FItems.Objects[Index] := TDMenuItem.Create;
  end;
  TDMenuItem(FItems.Objects[Index]).Menu := Value;
end;

procedure TAspDPopupMenu.Insert(Index: Integer; ACaption: string; Item: TAspDPopupMenu);
var
  MenuItem: TDMenuItem;
begin
  MenuItem := TDMenuItem.Create();
  MenuItem.Menu := Item;
  FItems.InsertObject(Index, ACaption, MenuItem);
  //if csDesigning in ComponentState then Refresh;
end;

function TAspDPopupMenu.IndexOf(Item: TAspDPopupMenu): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to FItems.Count - 1 do begin
    if FItems.Objects[I] = nil then begin
      FItems.Objects[I] := TDMenuItem.Create();
    end;
    if TDMenuItem(FItems.Objects[I]).Menu = Item then begin
      Result := I;
      Exit;
    end;
  end;
end;

procedure TAspDPopupMenu.Add(ACaption: string; Item: TAspDPopupMenu);
begin
  Insert(GetCount, ACaption, Item);
end;

procedure TAspDPopupMenu.Remove(Item: TAspDPopupMenu);
var
  I: Integer;
begin
  I := IndexOf(Item); if I >= 0 then Delete(I);
end;

procedure TAspDPopupMenu.Delete(Index: Integer);
begin
  FItems.Delete(Index);
end;

procedure TAspDPopupMenu.Clear;
begin
  FItemIndex := -1;
  while Count > 0 do begin
    Items[0].Free;
    Delete(0);
  end;
end;

function TAspDPopupMenu.Find(ACaption: string): TAspDPopupMenu;
var
  I: Integer;
begin
  Result := nil;
  ACaption := StripHotkey(ACaption);
  for I := 0 to Count - 1 do
    if AnsiSameText(ACaption, StripHotkey(Items[I].Caption)) then
    begin
      Result := Menus[I];
      System.Break;
    end;
end;

procedure TAspDPopupMenu.Show;
begin
  FMoveItemIndex := -1;
  Visible := True;
  {if Floating then begin
    if DParent <> nil then
      DParent.ChangeChildOrder(Self);
  end;
  if EnableFocus then SetDFocus(Self); }
  ActiveMenu := Self;
end;

procedure TAspDPopupMenu.Show(d: TAspDControl);
begin
  //if Count = 0 then Exit;
  FMoveItemIndex := -1;
  Visible := True;
  DControl := d;
 { if Floating then begin
    if DParent <> nil then
      DParent.ChangeChildOrder(Self);
  end;  }
  //if EnableFocus then SetDFocus(Self);
  ActiveMenu := Self;
end;

procedure TAspDPopupMenu.Hide;
var
  I: Integer;
begin
  //inherited;
  Visible := False;

  if ActiveMenu = Self then ActiveMenu := nil;
  if OwnerMenu <> nil then ActiveMenu := OwnerMenu;
  for I := 0 to Count - 1 do begin
    if (Menus[I] <> nil) { and (not Items[I].Visible)} then begin
      Menus[I].Hide;
    end;
  end;
end;

function TAspDPopupMenu.InRange(X, Y: Integer): Boolean;
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

procedure TAspDPopupMenu.Process;
var
  I, n1C, n2C: Integer;
  OldSize: Integer;
begin
  if Assigned(OnProcess) then OnProcess(Self);
  //if not Assigned(MainForm) then Exit;

  OldSize := FontManager.FontSize;

  FontManager.SetFont(DefaultCurFontName, 9);

  FItemSize := Round(AspTextureFont.TextHeight('0') * 1.5);

  n1C := 0;

  if FStyle = sVista then begin
    for I := 0 to FItems.Count - 1 do begin
      if n1C < AspTextureFont.TextWidth(FItems.Strings[I]) then
        n1C := AspTextureFont.TextWidth(FItems.Strings[I]);
    end;

    n1C := n1C + AspTextureFont.TextHeight('0') * 4;
    if n1C <> GWidth then GWidth := n1C;
  end;

  if FStyle = sVista then begin
    n2C := FItemSize * FItems.Count + AspTextureFont.TextHeight('0') * 2;
    if n2C <> GHeight then GHeight := n2C;
  end else begin
    n2C := FItemSize * FItems.Count + AspTextureFont.TextHeight('0') div 2;
    if n2C <> GHeight then GHeight := n2C;
  end;

  FontManager.SetFont(DefaultCurFontName, OldSize);

  for I := 0 to DControls.Count - 1 do
    if TAspDControl(DControls[I]).Visible then
      TAspDControl(DControls[I]).Process;  
end;

procedure TAspDPopupMenu.DirectPaint(dsurface: TAsphyreCanvas);
var
  d: TAsphyreLockableTexture;
  I, nIndex: Integer;
  rc: TRect;
  nX, nY: Integer;
  OldSize: Integer;
  CColor: TColor;
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

  OldSize := FontManager.FontSize;
  FontManager.SetFont(DefaultCurFontName, 9);

{------------------------------------------------------------------------------}
  dsurface.FillRect(ClientRect, FColors.Background);
  dsurface.FrameRect(ClientRect, FColors.Border);
{------------------------------------------------------------------------------}
  if FItems.Count > 0 then begin
{------------------------------------------------------------------------------}
    nIndex := 0;
    nX := 3;
    nY := 3;
{------------------------------------------------------------------------------}
    for I := 0 to FItems.Count - 1 do begin
      if FMoveItemIndex = I then begin
        if Items[I].Enabled then CColor := FColors.Selected
        else CColor := FColors.Disabled;
      end else begin
        if Items[I].Enabled then CColor := FColors.Font
        else CColor := FColors.Disabled;
      end;
      if Items[I].Visible then begin

        rc := ClientRect;
        rc.Left := rc.Left + nX;
        rc.Top := rc.Top + nY + nIndex * FItemSize;
        rc.Right := rc.Left + GWidth - nX * 2;
        rc.Bottom := rc.Top + FItemSize;

        if FItems[I] = '-' then begin
          nY := (I * FItemSize) + FItemSize div 2;
          rc.Top := SurfaceY(GTop) + nY;
          rc.Bottom := rc.Top + 1;
          dsurface.FrameRect(rc, FColors.Line);
        end else begin
          if FMoveItemIndex = nIndex then begin
            dsurface.FillRect(rc, FColors.Hot);
            AspTextureFont.TextOut(rc.Left, rc.Top + (FItemSize - AspTextureFont.TextHeight('Pp')) div 2, CColor, FItems[I]);
          end else begin
            AspTextureFont.TextOut(rc.Left, rc.Top + (FItemSize - AspTextureFont.TextHeight('Pp')) div 2, CColor, FItems[I]);
          end;
        end;
        Inc(nIndex);
      end;
    end;
  end;
  FontManager.SetFont(DefaultCurFontName, OldSize);

  for I := 0 to DControls.Count - 1 do
    if TAspDControl(DControls[I]).Visible then
      TAspDControl(DControls[I]).DirectPaint(dsurface); 
end;

function TAspDPopupMenu.KeyPress(var Key: Char): Boolean;
begin

end;

function TAspDPopupMenu.KeyDown(var Key: Word; Shift: TShiftState): Boolean;
begin

end;

function TAspDPopupMenu.MouseMove(Shift: TShiftState; X, Y: Integer): Boolean;
begin
  Result := inherited MouseMove(Shift, X, Y);
  if (not Background) and (not Result) then begin
    Result := inherited MouseMove(Shift, X, Y);
    if MouseCaptureControl = Self then
      if InRange(X, Y) then Downed := True
      else Downed := False;   
  end;
  FMouseMove := Result;                       
  if (FItemSize <> 0) and FMouseMove and (Count > 0) then begin
    FMoveItemIndex := (Y - GTop - 3) div FItemSize;
    if (FMoveItemIndex >= 0) and (FMoveItemIndex < FItems.Count) then begin
      if Menus[FMoveItemIndex] <> FActiveMenu then begin
        if FActiveMenu <> nil then FActiveMenu.Hide;
        FActiveMenu := nil;
        if Items[FMoveItemIndex].Enabled then begin
          FActiveMenu := Menus[FMoveItemIndex];
          if (FActiveMenu <> nil) and (not FActiveMenu.Visible) then FActiveMenu.Show(Self);
        end;
      end;
    end else begin
      if FActiveMenu <> nil then FActiveMenu.Hide;
      FActiveMenu := nil;
      FMoveItemIndex := -1;
    end;
  end else FMoveItemIndex := -1;
end;

function TAspDPopupMenu.Click(X, Y: Integer): Boolean;
var
  I: Integer;
begin
  Result := False;
 { if (ActiveMenu <> nil) then begin
    if (ActiveMenu = Self) then begin

      if Assigned(FOnClick) then
        FOnClick(Self, X, Y);

      Result := True;
    end;
    Exit;
  end; }
  for I := DControls.Count - 1 downto 0 do
    if TAspDControl(DControls[I]).Visible then
      if TAspDControl(DControls[I]).Click(X - GLeft, Y - GTop) then begin
        Result := True;
        Exit;
      end;
  if InRange(X, Y) then begin
    if Assigned(OnClick) then
      OnClick(Self, X, Y);
    Result := True;
  end;
end;

function TAspDPopupMenu.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
begin
  Result := False;
  if inherited MouseDown(Button, Shift, X, Y) then begin
    //if (not Background) and (MouseCaptureControl = nil) then begin
    //Downed := True;
      //SetDCapture(Self);
   // end;
    Result := True;
  end;
  //FMouseDown := Result;
  if (FItemSize <> 0) {and FMouseDown} and (Count > 0) then begin
    FItemIndex := (Y {- MainForm.Canvas.TextHeight('0')} - GTop - 3) div FItemSize;
  end;
end;

function TAspDPopupMenu.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
begin
  Result := False;
  if inherited MouseUp(Button, Shift, X, Y) then begin
    Result := True;
    Downed := False;
    //FMouseDown := not Result;
    if InRange(X, Y) then begin
      if Button = mbLeft then begin
        FMouseMove := Result;
        if (FItemIndex >= 0) and (FItemIndex < Count) and Items[FItemIndex].Enabled then begin
          if (FActiveMenu <> nil) then begin
            if (not FActiveMenu.Visible) then FActiveMenu.Show(Self);
          end else Hide;
        end else if (Count <= 0) then Hide;
      end;
    end;
  end else begin
    ReleaseCapture;
    Downed := False;
  end;
end;

end.
