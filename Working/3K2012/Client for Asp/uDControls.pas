unit uDControls;

interface
uses Classes, Graphics;

type
  TDFont = class(TPersistent)
  private
    FOnChange: TNotifyEvent;
    FColor: TColor;
    FBColor: TColor;
    FName: TFontName;
    FStyle: TFontStyles;
    FSize: Integer;
    FBold: Boolean;
    procedure SetColor(Value: TColor);
    procedure SetBColor(Value: TColor);
    procedure SetName(Value: TFontName);
    procedure SetSize(Value: Integer);
    procedure SetStyle(Value: TFontStyles);
    procedure SetBold(Value: Boolean);
  protected
    procedure Changed; //dynamic;
  public
    constructor Create;
    procedure Assign(Source: TPersistent); override;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  published
    property Color: TColor read FColor write SetColor;
    property BColor: TColor read FBColor write SetBColor;
    property Name: TFontName read FName write SetName;
    property Size: Integer read FSize write SetSize;
    property Style: TFontStyles read FStyle write SetStyle;
    property Bold: Boolean read FBold write SetBold;
  end;
  TDCaptionColor = class(TPersistent)
  private
    FOnChange: TNotifyEvent;
    FUp: TDFont;
    FHot: TDFont;
    FDown: TDFont;
    FDisabled: TDFont;
    procedure SetUp(Value: TDFont);
    procedure SetHot(Value: TDFont);
    procedure SetDown(Value: TDFont);
    procedure SetDisabled(Value: TDFont);
    procedure FontChange(Sender: TObject);
  protected

  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  published
    property Up: TDFont read FUp write SetUp;
    property Hot: TDFont read FHot write SetHot;
    property Down: TDFont read FDown write SetDown;
    property Disabled: TDFont read FDisabled write SetDisabled;
  end;
implementation
constructor TDFont.Create;
begin
  FColor := clWhite;
  FBColor := $00040404;
  FName := ''; //ËÎÌו
  FStyle := [];
  FSize := 9;
  FBold := False;
end;

procedure TDFont.Changed;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TDFont.SetColor(Value: TColor);
begin
  if FColor <> Value then begin
    FColor := Value;
    Changed;
  end;
end;

procedure TDFont.SetBColor(Value: TColor);
begin
  if FBColor <> Value then begin
    FBColor := Value;
    Changed;
  end;
end;

procedure TDFont.SetName(Value: TFontName);
begin
  if FName <> Value then begin
    FName := Value;
    Changed;
  end;
end;

procedure TDFont.SetSize(Value: Integer);
begin
  if FSize <> Value then begin
    FSize := Value;
    Changed;
  end;
end;

procedure TDFont.SetStyle(Value: TFontStyles);
begin
  if FStyle <> Value then begin
    FStyle := Value;
    Changed;
  end;
end;

procedure TDFont.SetBold(Value: Boolean);
begin
  if FBold <> Value then begin
    FBold := Value;
    Changed;
  end;
end;

procedure TDFont.Assign(Source: TPersistent);
begin
  //inherited;
  if Source is TDFont then begin
    FColor := TDFont(Source).Color;
    FBColor := TDFont(Source).BColor;
    FName := TDFont(Source).Name;
    FStyle := TDFont(Source).Style;
    FSize := TDFont(Source).Size;
    FBold := TDFont(Source).Bold;
    Changed;
  end;
end;
{ TDCaptionColor }

procedure TDCaptionColor.Assign(Source: TPersistent);
begin
  //inherited;
  if Source is TDCaptionColor then begin
    FUp.Assign(TDCaptionColor(Source).Up);
    FHot.Assign(TDCaptionColor(Source).Hot);
    FDown.Assign(TDCaptionColor(Source).Down);
    FDisabled.Assign(TDCaptionColor(Source).Disabled);
  end;
end;

constructor TDCaptionColor.Create;
begin
  inherited;
  FUp := TDFont.Create;
  FHot := TDFont.Create;
  FDown := TDFont.Create;
  FDisabled := TDFont.Create;

  FUp.Bold := True;
  FHot.Bold := True;
  FDown.Bold := True;
  FDisabled.Bold := True;

  FUp.Color := clWhite;
  FHot.Color := clWhite;
  FDown.Color := clWhite;
  FDisabled.Color := clBtnFace;

  FDisabled := TDFont.Create;
  FUp.OnChange := FontChange;
  FHot.OnChange := FontChange;
  FDown.OnChange := FontChange;
  FDisabled.OnChange := FontChange;
end;

destructor TDCaptionColor.Destroy;
begin
  FUp.Free;
  FHot.Free;
  FDown.Free;
  FDisabled.Free;
  inherited Destroy;
end;

procedure TDCaptionColor.FontChange(Sender: TObject);
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TDCaptionColor.SetDisabled(Value: TDFont);
begin
  FDisabled.Assign(Value);
end;

procedure TDCaptionColor.SetDown(Value: TDFont);
begin
  FDown.Assign(Value);
end;

procedure TDCaptionColor.SetHot(Value: TDFont);
begin
  FHot.Assign(Value);
end;

procedure TDCaptionColor.SetUp(Value: TDFont);
begin
  FUp.Assign(Value);
end;
end.
