unit HGEGUICtrls;
(*
** Haaf's Game Engine 1.7
** Copyright (C) 2003-2007, Relish Games
** hge.relishgames.com
**
** Delphi conversion by Erik van Bilsen
**
** NOTE: The Delphi version uses public GUI interfaces instead of
** classes (more conform the main IHGE interface).
*)

interface

uses
  Classes, HGE, HGEGUI, HGEFont, HGESprite;

(****************************************************************************
 * HGEGUICtrls.h
 ****************************************************************************)

type
  IHGEGUIText = interface(IHGEGUIObject)
  ['{1A94C342-0155-4C0D-8FA9-8E6F24D42433}']
    function GetAlign: Integer;
    procedure SetAlign(const Value: Integer);
    function GetText: String;
    procedure SetText(const Value: String);

    procedure PrintF(const Format: String; const Args: array of const);

    property Align: Integer read GetAlign write SetAlign;
    property Text: String read GetText write SetText;
  end;

type
  IHGEGUIButton = interface(IHGEGUIObject)
  ['{31E10716-69EB-477F-BD9C-E5E23CEB9BB6}']
    function GetTrigger: Boolean;
    procedure SetTrigger(const Value: Boolean);
    function GetPressed: Boolean;
    procedure SetPressed(const Value: Boolean);
    
    property Trigger: Boolean read GetTrigger write SetTrigger;
    property Pressed: Boolean read GetPressed write SetPressed;
  end;

const
  HGESLIDER_BAR         = 0;
  HGESLIDER_BARRELATIVE = 1;
  HGESLIDER_SLIDER      = 2;

type
  IHGEGUISlider = interface(IHGEGUIObject)
  ['{F40F885A-8F66-435E-AB95-538163F5565A}']
    function GetValue: Single;
    procedure SetValue(const Value: Single);

    procedure SetMode(const Min, Max: Single; const Mode: Integer);

    property Value: Single read GetValue write SetValue;
  end;

type
  IHGEGUIListbox = interface(IHGEGUIObject)
  ['{36097478-7E82-4F37-B18B-248C203B9E7E}']
    function GetSelectedItem: Integer;
    procedure SetSelectedItem(const Value: Integer);
    function GetTopItem: Integer;
    procedure SetTopItem(const Value: Integer);
    function GetItemText(const N: Integer): String;
    procedure SetItemText(const N: Integer; const Value: String);
    function GetNumItems: Integer;
    function GetNumRows: Integer;

    function AddItem(const Item: String): Integer;
    procedure DeleteItem(const N: Integer);
    procedure Clear;

    property SelectedItem: Integer read GetSelectedItem write SetSelectedItem;
    property TopItem: Integer read GetTopItem write SetTopItem;
    property ItemText[const N: Integer]: String read GetItemText write SetItemText;
    property NumItems: Integer read GetNumItems;
    property NumRows: Integer read GetNumRows;
  end;

type
  THGEGUIText = class(THGEGUIObject,IHGEGUIText)
  protected
    { IHGEGUIObject }
    procedure Render; override;
  protected
    { IHGEGUIText }
    function GetAlign: Integer;
    procedure SetAlign(const Value: Integer);
    function GetText: String;
    procedure SetText(const Value: String);

    procedure PrintF(const Format: String; const Args: array of const);
  private
    FFont: IHGEFont;
    FTX, FTY: Single;
    FAlign: Integer;
    FText: String;
  public
    constructor Create(const AId: Integer; const AX, AY, AW, AH: Single;
      const AFont: IHGEFont);
  end;

type
  THGEGUIButton = class(THGEGUIObject,IHGEGUIButton)
  protected
    { IHGEGUIObject }
    procedure Render; override;
    function MouseLButton(const Down: Boolean): Boolean; override;
  protected
    { IHGEGUIButton }
    function GetTrigger: Boolean;
    procedure SetTrigger(const Value: Boolean);
    function GetPressed: Boolean;
    procedure SetPressed(const Value: Boolean);
  private
    FTrigger: Boolean;
    FPressed: Boolean;
    FOldState: Boolean;
    FSprUp, FSprDown: IHGESprite;
  public
    constructor Create(const AId: Integer; const AX, AY, AW, AH: Single;
      const ATex: ITexture; const ATX, ATY: Single);
  end;

type
  THGEGUISlider = class(THGEGUIObject,IHGEGUISlider)
  protected
    { IHGEGUIObject }
    procedure Render; override;
    function MouseLButton(const Down: Boolean): Boolean; override;
    function MouseMove(const X, Y: Single): Boolean; override;
  protected
    { IHGEGUISlider }
    function GetValue: Single;
    procedure SetValue(const Value: Single);

    procedure SetMode(const Min, Max: Single; const Mode: Integer);
  private
    FPressed: Boolean;
    FVertical: Boolean;
    FMode: Integer;
    FMin, FMax, FVal: Single;
    FSlW, FSlH: Single;
    FSprSlider: IHGESprite;
  public
    constructor Create(const AId: Integer; const AX, AY, AW, AH: Single;
      const ATex: ITexture; const ATX, ATY, ASW, ASH: Single;
      const AVertical: Boolean = False);
  end;

type
  THGEGUIListBox = class(THGEGUIObject,IHGEGUIListbox)
  protected
    { IHGEGUIObject }
    procedure Render; override;
    function MouseLButton(const Down: Boolean): Boolean; override;
    function MouseMove(const X, Y: Single): Boolean; override;
    function MouseWheel(const Notches: Integer): Boolean; override;
    function KeyClick(const Key, Chr: Integer): Boolean; override;
  protected
    { IHGEGUIListbox }
    function GetSelectedItem: Integer;
    procedure SetSelectedItem(const Value: Integer);
    function GetTopItem: Integer;
    procedure SetTopItem(const Value: Integer);
    function GetItemText(const N: Integer): String;
    procedure SetItemText(const N: Integer; const Value: String);
    function GetNumItems: Integer;
    function GetNumRows: Integer;

    function AddItem(const Item: String): Integer;
    procedure DeleteItem(const N: Integer);
    procedure Clear;
  private
    FSprHighlight: IHGESprite;
    FFont: IHGEFont;
    FTextColor, FTextHilColor: Longword;
    FSelectedItem, FTopItem: Integer;
    FMX, FMY: Single;
    FItems: TStrings;
  public
    constructor Create(const AId: Integer; const AX, AY, AW, AH: Single;
      const AFont: IHGEFont; const ATColor, ATHColor, AHColor: Longword);
    destructor Destroy; override;
  end;

function hgeGetTextCtrl(const GUI: IHGEGUI; const Id: Integer): IHGEGUIText;

function hgeGetButtonCtrl(const GUI: IHGEGUI; const Id: Integer): IHGEGUIButton;
function hgeButtonGetState(const GUI: IHGEGUI; const Id: Integer): Boolean;
procedure hgeButtonSetState(const GUI: IHGEGUI; const Id: Integer;
  const Pressed: Boolean);

function hgeGetSliderCtrl(const GUI: IHGEGUI; const Id: Integer): IHGEGUISlider;
function hgeSliderGetValue(const GUI: IHGEGUI; const Id: Integer): Single;
procedure hgeSliderSetValue(const GUI: IHGEGUI; const Id: Integer;
  const Value: Single);

function hgeGetListboxCtrl(const GUI: IHGEGUI; const Id: Integer): IHGEGUIListbox;

implementation

uses
  SysUtils, HGERect;

(****************************************************************************
 * HGEGUICtrls.h, HGEGUICtrls.cpp
 ****************************************************************************)

function hgeGetTextCtrl(const GUI: IHGEGUI; const Id: Integer): IHGEGUIText;
begin
  Result := GUI.GetCtrl(Id) as IHGEGUIText;
end;

function hgeGetButtonCtrl(const GUI: IHGEGUI; const Id: Integer): IHGEGUIButton;
begin
  Result := GUI.GetCtrl(Id) as IHGEGUIButton;
end;

function hgeButtonGetState(const GUI: IHGEGUI; const Id: Integer): Boolean;
var
  Button: IHGEGUIButton;
begin
  Button := hgeGetButtonCtrl(GUI,Id);
  if Assigned(Button) then
    Result := Button.Pressed
  else
    Result := False;
end;

procedure hgeButtonSetState(const GUI: IHGEGUI; const Id: Integer;
  const Pressed: Boolean);
var
  Button: IHGEGUIButton;
begin
  Button := hgeGetButtonCtrl(GUI,Id);
  if Assigned(Button) then
    Button.Pressed := Pressed;
end;

function hgeGetSliderCtrl(const GUI: IHGEGUI; const Id: Integer): IHGEGUISlider;
begin
  Result := GUI.GetCtrl(Id) as IHGEGUISlider;
end;

function hgeSliderGetValue(const GUI: IHGEGUI; const Id: Integer): Single;
var
  Slider: IHGEGUISlider;
begin
  Slider := hgeGetSliderCtrl(GUI,Id);
  if Assigned(Slider) then
    Result := Slider.Value
  else
    Result := 0;
end;

procedure hgeSliderSetValue(const GUI: IHGEGUI; const Id: Integer;
  const Value: Single);
var
  Slider: IHGEGUISlider;
begin
  Slider := hgeGetSliderCtrl(GUI,Id);
  if Assigned(Slider) then
    Slider.Value := Value;
end;

function hgeGetListboxCtrl(const GUI: IHGEGUI; const Id: Integer): IHGEGUIListbox;
begin
  Result := GUI.GetCtrl(Id) as IHGEGUIListbox;
end;

{ THGEGUIText }

constructor THGEGUIText.Create(const AId: Integer; const AX, AY, AW, AH: Single;
  const AFont: IHGEFont);
begin
  inherited Create;
  Id := AId;
  IsStatic := True;
  Visible := True;
  Enabled := True;
  Rect.SetRect(AX,AY,AX + AW,AY + AH);
  FFont := AFont;
  FTX := AX;
  FTY := AY + (AH - FFont.GetHeight) / 2;
end;

function THGEGUIText.GetAlign: Integer;
begin
  Result := FAlign;
end;

function THGEGUIText.GetText: String;
begin
  Result := FText;
end;

procedure THGEGUIText.PrintF(const Format: String; const Args: array of const);
begin
  FText := SysUtils.Format(Format,Args);
end;

procedure THGEGUIText.Render;
begin
  FFont.SetColor(Color);
  FFont.Render(FTX,FTY,FAlign,FText);
end;

procedure THGEGUIText.SetAlign(const Value: Integer);
begin
  FAlign := Value;
  if (FAlign = HGETEXT_RIGHT) then
    FTX := Rect.X2
  else if (FAlign = HGETEXT_CENTER) then
    FTX := (Rect.X1 + Rect.X2) / 2
  else
    FTX := Rect.Y1;
end;

procedure THGEGUIText.SetText(const Value: String);
begin
  FText := Value;
end;

{ THGEGUIButton }

constructor THGEGUIButton.Create(const AId: Integer; const AX, AY, AW,
  AH: Single; const ATex: ITexture; const ATX, ATY: Single);
begin
  inherited Create;
  Id := AId;
  IsStatic := False;
  Visible := True;
  Enabled := True;
  Rect.SetRect(AX,AY,AX + AW,AY + AH);
  FSprUp := THGESprite.Create(ATex,ATX,ATY,AW,AH);
  FSprDown := THGESprite.Create(ATex,ATX + AW,ATY,AW,AH);
end;

function THGEGUIButton.GetPressed: Boolean;
begin
  Result := FPressed;
end;

function THGEGUIButton.GetTrigger: Boolean;
begin
  Result := FTrigger;
end;

function THGEGUIButton.MouseLButton(const Down: Boolean): Boolean;
begin
  if (Down) then begin
    FOldState := FPressed;
    FPressed := True;
    Result := False;
  end else begin
    if (FTrigger) then
      FPressed := not FOldState
    else
      FPressed := False;
    Result := True;
  end;
end;

procedure THGEGUIButton.Render;
begin
  if (FPressed) then
    FSprDown.Render(Rect.X1,Rect.Y1)
  else
    FSprUp.Render(Rect.X1,Rect.Y1);
end;

procedure THGEGUIButton.SetPressed(const Value: Boolean);
begin
  FPressed := Value;
end;

procedure THGEGUIButton.SetTrigger(const Value: Boolean);
begin
  FTrigger := Value;
end;

{ THGEGUISlider }

constructor THGEGUISlider.Create(const AId: Integer; const AX, AY, AW,
  AH: Single; const ATex: ITexture; const ATX, ATY, ASW, ASH: Single;
  const AVertical: Boolean);
begin
  inherited Create;
  Id := AId;
  IsStatic := False;
  Visible := True;
  Enabled := True;
  FVertical := AVertical;
  Rect.SetRect(AX,AY,AX + AW,AY + AH);
  FMode := HGESLIDER_BAR;
  FMin := 0;
  FMax := 100;
  FVal := 50;
  FSlW := ASW;
  FSlH := ASH;
  FSprSlider := THGESprite.Create(ATex,ATX,ATY,ASW,ASH);
end;

function THGEGUISlider.GetValue: Single;
begin
  Result := FVal;
end;

function THGEGUISlider.MouseLButton(const Down: Boolean): Boolean;
begin
  FPressed := Down;
  Result := False;
end;

function THGEGUISlider.MouseMove(const X, Y: Single): Boolean;
var
  R: PHGERect;
  XX, YY: Single;
begin
  if (FPressed) then begin
    R := PRect;
    XX := X;
    YY := Y;
    if (FVertical) then begin
      if (Y > R.Y2 - R.Y1) then
        YY := R.Y2 - R.Y1
      else if (Y < 0) then
        YY := 0;
      FVal := FMin + (FMax - FMin) * YY / (R.Y2 - R.Y1);
    end else begin
      if (X > R.X2 - R.X1) then
        XX := R.X2 - R.X1
      else if (X < 0) then
        XX := 0;
      FVal := FMin + (FMax - FMin) * XX / (R.X2 - R.X1);
    end;
    Result := True;
  end else
    Result := False;
end;

procedure THGEGUISlider.Render;
var
  XX, YY, X1, Y1, X2, Y2: Single;
  R: PHGERect;
begin
  R := PRect;
  XX := R.X1 + (R.X2 - R.X1) * (FVal - FMin) / (FMax - FMin);
  YY := R.Y1 + (R.Y2 - R.Y1) * (FVal - FMin) / (FMax - FMin);
  if (FVertical) then begin
    case FMode of
      HGESLIDER_BAR:
        begin
          X1 := R.X1; Y1 := R.Y1;
          X2 := R.X2; Y2 := YY;
        end;
      HGESLIDER_BARRELATIVE:
        begin
          X1 := R.X1; Y1 := (R.Y1 + R.Y2) / 2;
          X2 := R.X2; Y2 := YY;
        end;
    else // HGESLIDER_SLIDER:
        begin
          X1 := (R.X1 + R.X2 - FSlW) / 2; Y1 := YY - FSlH / 2;
          X2 := (R.X1 + R.X2 + FSlW) / 2; Y2 := YY + FSlH / 2;
        end;
    end;
  end else begin
    case FMode of
      HGESLIDER_BAR:
        begin
          X1 := R.X1; Y1 := R.Y1;
          X2 := XX; Y2 := R.Y2;
        end;
      HGESLIDER_BARRELATIVE:
        begin
          X1 := (R.X1 + R.X2) / 2; Y1 := R.Y1;
          X2 := XX; Y2 := R.Y2;
        end;
    else // HGESLIDER_SLIDER:
        begin
          X1 := XX - FSlW / 2; Y1 := (R.Y1 + R.Y2 - FSlH) / 2;
          X2 := XX + FSlW / 2; Y2 := (R.Y1 + R.Y2 + FSlH) / 2;
        end;
    end;
  end;
  FSprSlider.RenderStretch(X1,Y1,X2,Y2);
end;

procedure THGEGUISlider.SetMode(const Min, Max: Single; const Mode: Integer);
begin
  FMin := Min;
  FMax := Max;
  FMode := Mode;
end;

procedure THGEGUISlider.SetValue(const Value: Single);
begin
  if (Value < FMin) then
    FVal := FMin
  else if (Value > FMax) then
    FVal := FMax
  else
    FVal := Value;
end;

{ THGEGUIListBox }

function THGEGUIListBox.AddItem(const Item: String): Integer;
begin
  Result := FItems.Add(Item)
end;

procedure THGEGUIListBox.Clear;
begin
  FItems.Clear;
end;

constructor THGEGUIListBox.Create(const AId: Integer; const AX, AY, AW,
  AH: Single; const AFont: IHGEFont; const ATColor, ATHColor,
  AHColor: Longword);
begin
  inherited Create;
  FItems := TStringList.Create;
  Id := AId;
  IsStatic := False;
  Visible := True;
  Enabled := True;
  Rect.SetRect(AX,AY,AX + AW,AY + AH);
  FFont := AFont;
  FSprHighlight := THGESprite.Create(nil,0,0,AW,FFont.GetHeight);
  FSprHighlight.SetColor(AHColor);
  FTextColor := ATColor;
  FTextHilColor := ATHColor;
end;

procedure THGEGUIListBox.DeleteItem(const N: Integer);
begin
  FItems.Delete(N);
end;

destructor THGEGUIListBox.Destroy;
begin
  FItems.Free;
  inherited;
end;

function THGEGUIListBox.GetItemText(const N: Integer): String;
begin
  if (N < 0) or (N >= FItems.Count) then
    Result := ''
  else
    Result := FItems[N];
end;

function THGEGUIListBox.GetNumItems: Integer;
begin
  Result := FItems.Count;
end;

function THGEGUIListBox.GetNumRows: Integer;
var
  R: PHGERect;
begin
  R := PRect;
  Result := Trunc((R.Y2 - R.Y1) / FFont.GetHeight);
end;

function THGEGUIListBox.GetSelectedItem: Integer;
begin
  Result := FSelectedItem;
end;

function THGEGUIListBox.GetTopItem: Integer;
begin
  Result := FTopItem;
end;

function THGEGUIListBox.KeyClick(const Key, Chr: Integer): Boolean;
begin
  case Key of
    HGEK_DOWN:
      begin
        if (FSelectedItem < FItems.Count - 1) then begin
          Inc(FSelectedItem);
          if (FSelectedItem > FTopItem + GetNumRows - 1) then
            FTopItem := FSelectedItem - GetNumRows + 1;
          Result := True;
          Exit;
        end;
      end;
    HGEK_UP:
      begin
        if (FSelectedItem > 0) then begin
          Dec(FSelectedItem);
          if (FSelectedItem < FTopItem) then
            FTopItem := FSelectedItem;
          Result := True;
          Exit;
        end;
      end;
  end;
  Result := False;
end;

function THGEGUIListBox.MouseLButton(const Down: Boolean): Boolean;
var
  NItem: Integer;
begin
  if (Down) then begin
    NItem := FTopItem + (Trunc(FMY) div Trunc(FFont.GetHeight));
    if (NItem < FItems.Count) then begin
      FSelectedItem := NItem;
      Result := True;
      Exit;
    end;
  end;
  Result := False;
end;

function THGEGUIListBox.MouseMove(const X, Y: Single): Boolean;
begin
  FMX := X;
  FMY := Y;
  Result := False;
end;

function THGEGUIListBox.MouseWheel(const Notches: Integer): Boolean;
begin
  Dec(FTopItem,Notches);
  if (FTopItem < 0) then
    FTopItem := 0
  else if (FTopItem > FItems.Count - GetNumRows) then
    FTopItem := FItems.Count - GetNumRows;
  Result := True;
end;

procedure THGEGUIListBox.Render;
var
  I, J: Integer;
  R: PHGERect;
begin
  J := FTopItem;
  R := PRect;
  for I := 0 to GetNumRows - 1 do begin
    if (J >= FItems.Count) then
      Break;
    if (J = FSelectedItem) then begin
      FSprHighlight.Render(R.X1,R.Y1 + I * FFont.GetHeight);
      FFont.SetColor(FTextHilColor);
    end else
      FFont.SetColor(FTextColor);
    FFont.Render(R.X1 + 3,R.Y1 + I * FFont.GetHeight,HGETEXT_LEFT,FItems[J]);
    Inc(J);
  end;
end;

procedure THGEGUIListBox.SetItemText(const N: Integer; const Value: String);
begin
  if (N >= 0) and (N < FItems.Count) then
    FItems[N] := Value;
end;

procedure THGEGUIListBox.SetSelectedItem(const Value: Integer);
begin
  if (Value >= 0) and (Value < FItems.Count) then
    FSelectedItem := Value;
end;

procedure THGEGUIListBox.SetTopItem(const Value: Integer);
begin
  if (Value >= 0) and (Value <= FItems.Count - GetNumRows) then
    FTopItem := Value;
end;

end.
