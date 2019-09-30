unit uDLabel;

interface
uses Classes, DWinCtl, Graphics, DXDraws, Controls, Windows, Math, DirectX, HUtil32;

type
  //显示控件
  TDLabel = class(TDControl)
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
    procedure DirectPaint(dsurface: TDirectDrawSurface); override;
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
  RegisterComponents('MirGame', [TDLabel]);
end;
{ TDLabel }

procedure TDLabel.CaptionChaged;
begin
  if Assigned(MainForm) then begin
  //if not (csDesigning in ComponentState) then begin
    if FAutoSize then begin
        GWidth := MainForm.Canvas.TextWidth(Caption);
        GHeight := MainForm.Canvas.TextHeight('0');
      //DebugOutStr(Format('TDLabel.SetCaption Caption:%s  Width:%d  Height:%d', [Caption, Width, Height]));
    end;
  end;
end;

constructor TDLabel.Create(AOwner: TComponent);
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
  if Assigned(MainForm) then begin
    Canvas.Font.Assign(MainForm.Canvas.Font);
    Canvas.Brush.Assign(MainForm.Canvas.Brush);
    Font.Assign(MainForm.Canvas.Font);
  end;
  FUpColor := Canvas.Font.Color;
  FHotColor := Canvas.Font.Color;
  FDownColor := Canvas.Font.Color;
  FClickTime := 0;
  FAlignment := taLeftJustify;
end;

procedure TDLabel.DirectPaint(dsurface: TDirectDrawSurface);
//iamwgh黑白效果，灰度

  procedure GrayEffect(X, Y, Width, Height: Integer; ssuf: TDirectDrawSurface);
  var
    I, j: Integer;
    sptr: PWord;
    tmp: Word;
    r, G, b: byte;
    sddsd: TDDSURFACEDESC2;
  begin
    try
      sddsd.dwSize := SizeOf(sddsd);
      ssuf.Lock (TRect(nil^), sddsd);
      for I := 0 to Height - 1 do begin
        sptr := PWord(Integer(sddsd.lpSurface) + (Y + I) * sddsd.lPitch + X * 2);
        for j := 0 to Width - 1 do begin
          if not ((sptr^) = 0) then
          begin
            tmp := sptr^;
            r := Word(Round(((tmp and $F800 shr 8) + (tmp and $07E0 shr 3) + (tmp and $001F shl 3)) / 3));
            G := r;
            b := r;
            sptr^ := _MAX(Word((r and $F8 shl 8) or (G and $FC shl 3) or (b and $F8 shr 3)), $0821);
                                                  {if  ((tmp and $F800 shr 8) = 160)  or ((r>200) and (g>200) and (b>200)) then
                                                  begin
                                                          sptr^ := $0821;
                                                  end;     }
          end;
          Inc(sptr);
        end;
      end;
    finally
      ssuf.UnLock;
    end;
  end;
  
var
  I, nX: Integer;
  nAlpha: Integer;
  d: TDirectDrawSurface;
  OldSize: Integer;
  OldFontStyle: TFontStyles;
  ARect: TRect;
  dd: TDirectDrawSurface;
begin
  if Assigned (OnDirectPaint) then
    OnDirectPaint (self, dsurface)
  else
  if WLib <> nil then begin
    d := WLib.Images[FaceIndex];
    if d <> nil then begin
      if Enabled then begin
      	if Downed then
        	dsurface.Draw(SurfaceX(GLeft)+1, SurfaceY(GTop)+1, d.ClientRect, d, True)
        else dsurface.Draw(SurfaceX(GLeft), SurfaceY(GTop), d.ClientRect, d, True);
      end else begin
      	dd := TDirectDrawSurface.Create(MainFormDxDraw.DDraw);
        try
          dd.SystemMemory := True;
          dd.SetSize(GWidth, GHeight);
          dd.Draw (0, 0, d.ClientRect, d, TRUE);
          GrayEffect(0, 0,  dd.Width, dd.Height, dd);
          dsurface.Draw (SurfaceX(GLeft), SurfaceY(GTop), dd.ClientRect, dd, True);
        finally
        	dd.Free;
        end;
      end;
    end;
  end;

  if FBackground then
    dsurface.FastFillRect(Bounds(SurfaceX(GLeft), SurfaceY(GTop), GWidth, GHeight), FBackgroundColor);
  if FBorder then
    dsurface.FastFrameRect(Bounds(SurfaceX(GLeft), SurfaceY(GTop), GWidth, GHeight), FBorderCurrColor);

  OldSize := MainForm.Canvas.Font.Size;
  OldFontStyle := MainForm.Canvas.Font.Style;

  MainForm.Canvas.Font.Size := Font.Size;
  MainForm.Canvas.Font.Style := Font.Style;
  if Caption <> '' then begin
    if Caption = '-' then begin
      dsurface.FastFillRect(Bounds(SurfaceX(GLeft), SurfaceY(GTop) + MainForm.Canvas.TextHeight('0') div 2, GWidth, 1), FCurrColor);
    end else begin
      case FAlignment of
        taLeftJustify: nX := SurfaceX(GLeft);
        taRightJustify: nX := Max(SurfaceX(GLeft), SurfaceX(GLeft) + (GWidth - MainForm.Canvas.TextWidth(Caption)));
        taCenter: nX := SurfaceX(GLeft) + (GWidth - MainForm.Canvas.TextWidth(Caption)) div 2;
      end;
      if FBold then begin
        if FDown and Downed and Enabled then begin
          dsurface.BoldTextOut(nX+1,
            SurfaceY(GTop)+1 + (GHeight - MainForm.Canvas.TextHeight('0')) div 2, FCurrColor, FBoldColor, Caption);
        end else begin
          dsurface.BoldTextOut(nX,
            SurfaceY(GTop) + (GHeight - MainForm.Canvas.TextHeight('0')) div 2, FCurrColor, FBoldColor, Caption);
        end;
      end else begin
        if FDown and Downed and Enabled then begin
          dsurface.TextOut(nX+1,
            SurfaceY(GTop)+1 + (GHeight - MainForm.Canvas.TextHeight('0')) div 2, FCurrColor, Caption);
        end else begin
          dsurface.TextOut(nX,
            SurfaceY(GTop) + (GHeight - MainForm.Canvas.TextHeight('0')) div 2, FCurrColor, Caption);
        end;
      end;
    end;
  end;

  MainForm.Canvas.Font.Style := OldFontStyle;
  MainForm.Canvas.Font.Size := OldSize;

  for I := 0 to DControls.Count - 1 do
    if TDControl(DControls[I]).Visible then
      TDControl(DControls[I]).DirectPaint(dsurface);
end;

function TDLabel.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer): Boolean;
begin
  Result := False;
  if inherited MouseDown(Button, Shift, X, Y) then begin
    if (not Background) and (MouseCaptureControl = nil) then begin
      case FButtonStyle of
        bsButton: begin
            Downed := True;
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

function TDLabel.MouseMove(Shift: TShiftState; X, Y: Integer): Boolean;
begin
  Result := inherited MouseMove(Shift, X, Y);
  if (not Background) and (not Result) and Enabled then begin
    Result := inherited MouseMove(Shift, X, Y);
    case FButtonStyle of
      bsButton: begin
          //if FDown then begin
            if MouseCaptureControl = Self then begin
              if InRange(X, Y) then
                Downed := True
              else
                Downed := False;
            end;
          //end;
        end;
      bsRadio: begin

        end;
      bsCheckBox: begin

        end;
    end;

  end;
end;

function TDLabel.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer): Boolean;
var
  I: Integer;
  d: TDControl;
  boDown: Boolean;
begin
  Result := False;
  if inherited MouseUp(Button, Shift, X, Y) then begin
    ReleaseDCapture;
    if not Background then begin
      if InRange(X, Y) then begin
        case FButtonStyle of
          bsButton: begin
              Downed := False;
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
                    d := TDControl(DParent.DControls[I]);
                    if (d <> Self) and (d is TDLabel) and (TDLabel(d).Style = bsRadio) then begin
                      //TDLabel(d).Downed := False;  注释
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
          Downed := False;
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
          Downed := False;
        end;
      bsRadio: begin

        end;
      bsCheckBox: begin

        end;
    end;
  end;
end;

procedure TDLabel.Process;
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

procedure TDLabel.SetAlignment(Value: TAlignment);
begin
  if FAlignment <> Value then begin
    FAlignment := Value;
  end;
end;

procedure TDLabel.SetAutoSize(Value: Boolean);
begin
  FAutoSize := Value;
  if not (csDesigning in ComponentState) then begin
    if Assigned(MainForm) then begin

      if FAutoSize then begin
        GWidth := MainForm.Canvas.TextWidth(Caption);
        GHeight := MainForm.Canvas.TextHeight('0');
      //DebugOutStr(Format('TDLabel.SetCaption Caption:%s  Width:%d  Height:%d', [Caption, Width, Height]));
      end;
    end;
  end;
end;

procedure TDLabel.SetUpColor(Value: TColor);
begin
  if FUpColor <> Value then begin
    FUpColor := Value;
    FCurrColor := Value;
  end;
end;

end.
