unit uAspDLabel;

interface
uses Classes, AspDWinCtl, Graphics, AbstractCanvas, AbstractTextures, AsphyreTextureFonts,
     AsphyreTypes, Controls, Windows, Math;

type
  //显示控件
  TAspDLabel = class(TAspDControl)
  private
    FClickSound: TClickSound;
    FOnClick: TOnClickEx;
    FOnClickSound: TOnClickSound;
    FAutoSize: Boolean;

    FCurrColor: TColor;
    FUpColor: TColor;
    FHotColor: TColor;
    FDownColor: TColor;
    FDisabledColor: TColor;

    FColor: TColor;

    FShadowSize: Integer;
    FShadowColor: Integer;
    FUseTick: longword;
    FBold: Boolean;

    FBackground: Boolean;
    FBackgroundColor: TColor;
    FBoldColor: TColor;
    FBorder: Boolean;
    FBorderColor: TColor;
    FHotBorder: TColor;
    FDownBorder: TColor;

    FButtonStyle: TButtonStyle;
    FClickTime: LongWord;

    FBorderCurrColor: TColor;

    FAlignment: TAlignment;
    FDown: Boolean;
    Downed: Boolean;
    procedure SetUpColor(Value: TColor);
    procedure SetAlignment(Value: TAlignment);
    procedure SetAutoSize(Value: Boolean);
  protected
    procedure CaptionChaged; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure DirectPaint(dsurface: TAsphyreCanvas); override;
    procedure Process; override;
    function MouseMove(Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
    //property Style: TButtonStyle read FButtonStyle write FButtonStyle;
    property ClickTime: LongWord read FClickTime write FClickTime;
    property Canvas;
  published
    property Alignment: TAlignment read FAlignment write SetAlignment;
    property Down: Boolean read FDown write FDown; //是否允许按下事件

    property AutoSize: Boolean read FAutoSize write SetAutoSize;
    property Color: TColor read FColor write FColor;
    property UpColor: TColor read FUpColor write SetUpColor;
    property HotColor: TColor read FHotColor write FHotColor;
    property DisabledColor: TColor read FDisabledColor write FDisabledColor;
    property DownColor: TColor read FDownColor write FDownColor;
    property BackgroundColor: TColor read FBackgroundColor write FBackgroundColor;
    property BorderColor: TColor read FBorderColor write FBorderColor;

    property HotBorderColor: TColor read FHotBorder write FHotBorder;
    property DownBorderColor: TColor read FDownBorder write FDownBorder;
    property BoldColor: TColor read FBoldColor write FBoldColor;

    property UseTick: longword read FUseTick write FUseTick;
    property BoldFont: Boolean read FBold write FBold;
    property DrawBackground: Boolean read FBackground write FBackground;
    property Border: Boolean read FBorder write FBorder;

    property ClickCount: TClickSound read FClickSound write FClickSound;
    property OnClick: TOnClickEx read FOnClick write FOnClick;
    property OnClickSound: TOnClickSound read FOnClickSound write FOnClickSound;
    property Style: TButtonStyle read FButtonStyle write FButtonStyle;
  end;
procedure Register;
var
  LabelClickTimeTick: LongWord;
implementation

procedure Register;
begin
  RegisterComponents('AspMirGame', [TAspDLabel]);
end;
{ TAspDLabel }

procedure TAspDLabel.CaptionChaged;
begin
  //if not (csDesigning in ComponentState) then begin
  if Assigned(AspTextureFont) then
  if FAutoSize then begin
      GWidth := AspTextureFont.TextWidth(Caption);
      GHeight := AspTextureFont.TextHeight('0');
    //DebugOutStr(Format('TAspDLabel.SetCaption Caption:%s  Width:%d  Height:%d', [Caption, Width, Height]));
  end;
end;

constructor TAspDLabel.Create(AOwner: TComponent);
begin
  inherited Create(aowner);
  FAutoSize := True;
  FOnClick := nil;
  EnableFocus := False;
  FClickSound := csNone;
  Caption := Name;

  FBackgroundColor := clWhite;
  FShadowSize := 4;
  FShadowColor := $40000000;

  FBorderColor := $00608490;

  FHotBorder := $005894B8;
  FDownBorder := $005894B8;

  FBoldColor := $00040404;
  FCurrColor := FUpColor;
  FDisabledColor := $0099A8AC;
  FBold := False;
  FBackground := False;
  FBorder := False;
  //FButtonStyle := bsBase;

  {if Assigned(MainForm) then begin
    Canvas.Font.Assign(MainForm.Canvas.Font);
    Canvas.Brush.Assign(MainForm.Canvas.Brush);
    Font.Assign(MainForm.Canvas.Font);
  end;   }
  FUpColor := Canvas.Font.Color;
  FHotColor := Canvas.Font.Color;
  FDownColor := Canvas.Font.Color;
  FClickTime := 0;
  FAlignment := taCenter;
end;

procedure TAspDLabel.DirectPaint(dsurface: TAsphyreCanvas);
var
  I, nX: Integer;
  nAlpha: Integer;
  d: TAsphyreLockableTexture;
  OldSize: Integer;
  ARect: TRect;
begin
  if Assigned (OnDirectPaint) then
    OnDirectPaint (self, dsurface)
  else if WLib <> nil then
  begin
    d := WLib.Images[FaceIndex];
    if d <> nil then begin
      if Enabled then begin
      	if Downed then
        	dsurface.Draw(SurfaceX(GLeft)+1, SurfaceY(GTop)+1, d.ClientRect, d, True)
        else dsurface.Draw(SurfaceX(GLeft), SurfaceY(GTop), d.ClientRect, d, True);
      end else begin
        dsurface.DrawAlpha(SurfaceX(GLeft), SurfaceY(GTop), d.ClientRect, d, True,124);
      	{dd := TDirectDrawSurface.Create(MainFormDxDraw.DDraw);
        try
          dd.SystemMemory := True;
          dd.SetSize(GWidth, GHeight);
          dd.Draw (0, 0, d.ClientRect, d, TRUE);
          GrayEffect(0, 0,  dd.Width, dd.Height, dd);
          dsurface.Draw (SurfaceX(GLeft), SurfaceY(GTop), dd.ClientRect, dd, True);
        finally
        	dd.Free;
        end; }
      end;
    end;
  end;

  if FBackground then
    dsurface.FillRect(Bounds(SurfaceX(GLeft), SurfaceY(GTop), GWidth, GHeight), FBackgroundColor);
  if FBorder then
    dsurface.FrameRect(Bounds(SurfaceX(GLeft), SurfaceY(GTop), GWidth, GHeight), FBorderCurrColor);

  OldSize := FontManager.FontSize;

  FontManager.SetFont('宋体', Font.Size);
  if Caption <> '' then begin
    if Caption = '-' then begin
      dsurface.FillRect(Bounds(SurfaceX(GLeft), SurfaceY(GTop) + AspTextureFont.TextHeight('0') div 2, GWidth, 1), FCurrColor);
    end else begin
      case FAlignment of
        taLeftJustify: nX := SurfaceX(GLeft);
        taRightJustify: nX := Max(SurfaceX(GLeft), SurfaceX(GLeft) + (GWidth - AspTextureFont.TextWidth(Caption)));
        taCenter: nX := SurfaceX(GLeft) + (GWidth - AspTextureFont.TextWidth(Caption)) div 2;
      end;
      if FBold then begin
        if FDown and Downed and Enabled then begin
          AspTextureFont.BoldTextOut(nX+1,
            SurfaceY(GTop)+1 + (GHeight - AspTextureFont.TextHeight('0')) div 2, FCurrColor, FBoldColor, Caption);
        end else begin
          AspTextureFont.BoldTextOut(nX,
            SurfaceY(GTop) + (GHeight - AspTextureFont.TextHeight('0')) div 2, FCurrColor, FBoldColor, Caption, Font.Style);
        end;
      end else begin
        if FDown and Downed and Enabled then begin
          AspTextureFont.TextOut(nX+1,
            SurfaceY(GTop)+1 + (GHeight - AspTextureFont.TextHeight('0')) div 2, FCurrColor, Caption, Font.Style);
        end else begin
          AspTextureFont.TextOut(nX,
            SurfaceY(GTop) + (GHeight - AspTextureFont.TextHeight('0')) div 2, FCurrColor, Caption, Font.Style);
        end;
      end;
    end;
  end;
  FontManager.SetFont('宋体', OldSize);

  for I := 0 to DControls.Count - 1 do
    if TAspDControl(DControls[I]).Visible then
      TAspDControl(DControls[I]).DirectPaint(dsurface);   
end;

function TAspDLabel.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer): Boolean;
begin
  Result := False;
  if inherited MouseDown(Button, Shift, X, Y) then begin
    if (not Background) and (MouseCaptureControl = nil) then begin
      case FButtonStyle of
        bsButton: begin
            if FDown then begin
              Downed := True;
            end;
          end;
        bsRadio: begin

          end;
        bsCheckBox: begin

          end;
      end;
      SetDCapture(Self);
    end;
    Result := True;
  end;
end;

function TAspDLabel.MouseMove(Shift: TShiftState; X, Y: Integer): Boolean;
begin
  Result := inherited MouseMove(Shift, X, Y);
  if (not Background) and (not Result) and Enabled then
  begin
    Result := inherited MouseMove(Shift, X, Y);
    case FButtonStyle of
      bsButton: begin
          if MouseCaptureControl = Self then begin
            if InRange(X, Y) then Downed := True
            else Downed := False;
          end;
        end;
      bsRadio: begin

        end;
      bsCheckBox: begin

        end;
    end;

  end;
end;

function TAspDLabel.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer): Boolean;
var
  I: Integer;
  d: TAspDControl;
  boDown: Boolean;
begin
  Result := False;
  if inherited MouseUp(Button, Shift, X, Y) then begin
    ReleaseDCapture;
    if not Background then begin
      if InRange(X, Y) then begin
        case FButtonStyle of
          bsButton: begin
              if FDown then Downed := False;
              if GetTickCount - LabelClickTimeTick > FClickTime then begin
                LabelClickTimeTick := GetTickCount;
                if Assigned(FOnClickSound) then FOnClickSound(Self, FClickSound);
                if Assigned(FOnClick) then FOnClick(Self, X, Y);
              end;
            end;
          bsRadio: begin
              if GetTickCount - LabelClickTimeTick > FClickTime then begin
                LabelClickTimeTick := GetTickCount;
                //showmessage(IntToStr(FClickTime));
                //boDown := Downed;  注释
                if (DParent <> nil) then begin
                  for I := 0 to DParent.DControls.Count - 1 do begin
                    d := TAspDControl(DParent.DControls[I]);
                    if (d <> Self) and (d is TAspDLabel) and (TAspDLabel(d).Style = bsRadio) then begin
                      //TAspDLabel(d).Downed := False;  注释
                    end;
                  end;
                end;
                //Downed := True; //注释
                if (not boDown) then begin
                  if Assigned(FOnClickSound) then FOnClickSound(Self, FClickSound);
                  if Assigned(FOnClick) then FOnClick(Self, X, Y);
                end;
              end;
            end;
          bsCheckBox: begin
              if GetTickCount - LabelClickTimeTick > FClickTime then begin
                LabelClickTimeTick := GetTickCount;
                //Downed := not Downed;  注释
                if Assigned(FOnClickSound) then FOnClickSound(Self, FClickSound);
                if Assigned(FOnClick) then FOnClick(Self, X, Y);
              end;
            end;
        end;
      end;
    end;
    case FButtonStyle of
      bsButton: begin
          if FDown then Downed := False;
        end;
      bsRadio: begin

        end;
      bsCheckBox: begin

        end;
    end;
    Result := True;
    Exit;
  end else begin
    ReleaseDCapture;
    case FButtonStyle of
      bsButton: begin
          if FDown then Downed := False;
        end;
      bsRadio: begin

        end;
      bsCheckBox: begin

        end;
    end;
  end;
end;

procedure TAspDLabel.Process;
var
  OldSize: Integer;
  OldFontStyle: TFontStyles;
begin
  if Assigned(OnProcess) then OnProcess(Self);
  if not Enabled then begin
  	FCurrColor := FDisabledColor;
  end else
  if Downed then begin
    FCurrColor := FDownColor;
  end else
  if MouseMoveing then begin
    FCurrColor := FHotColor;
  end else begin
    FCurrColor := FUpColor;
  end;

  FBorderCurrColor := FBorderColor;
  if Enabled then begin
    if MouseMoveControl = Self then FBorderCurrColor := FHotBorder;
  end;
end;

procedure TAspDLabel.SetAlignment(Value: TAlignment);
begin
  if FAlignment <> Value then begin
    FAlignment := Value;
  end;
end;

procedure TAspDLabel.SetAutoSize(Value: Boolean);
var
  Texture: TAsphyreLockableTexture;
begin
  FAutoSize := Value;
  if not (csDesigning in ComponentState) then begin
    if Assigned(AspTextureFont) then begin
      if FAutoSize then begin
        GWidth := AspTextureFont.TextWidth(Caption);
        GHeight := AspTextureFont.TextHeight('0');
      //DebugOutStr(Format('TAspDLabel.SetCaption Caption:%s  Width:%d  Height:%d', [Caption, Width, Height]));
      end;
    end; 
  end;
end;

procedure TAspDLabel.SetUpColor(Value: TColor);
begin
  if FUpColor <> Value then begin
    FUpColor := Value;
    FCurrColor := Value;
  end;
end;

end.
