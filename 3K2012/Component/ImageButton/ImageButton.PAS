unit ImageButton;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs,StdCtrls;

type
  TImageButton = class(TCustomControl)
  private
    FCaption: TCaption;
    FPicDisabled: TPicture;
    FPicMouseDown: TPicture;
    FPicMouseOn: TPicture;
    FPicNormal: TPicture;
    FPicSelect: TPicture;
    FSecected: Boolean;
    FTransparent: Boolean;
    m_Cancel: Boolean;
    m_Default: Boolean;
    m_OnMouseEnter: TNotifyEvent;
    m_OnMouseExit: TNotifyEvent;
    procedure PaintText(ACanvas: TCanvas; Text: String);
    procedure CMDialogChar(var Msg : TCMDialogChar); message CM_DIALOGCHAR;
    procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
    procedure CMFocusChanged(var Msg: TCMFocusChanged); message CM_FOCUSCHANGED;
    procedure CMFONTCHANGED(var Msg : TMessage); message CM_FONTCHANGED;
    procedure CMTextChanged(var Msg : TMessage); message CM_TEXTCHANGED;
    procedure MouseEnter(var Msg : TMessage); message CM_MOUSEENTER;
    procedure MouseLeave(var Msg : TMessage); message CM_MOUSELEAVE;
    procedure SetCaption(Value: TCaption);
    procedure SetDefault(const Value: Boolean);
    procedure SetPicDisabled(Value: TPicture);
    procedure SetPicMouseDown(Value: TPicture);
    procedure SetPicMouseOn(Value: TPicture);
    procedure SetPicNormal(Value: TPicture);
    procedure SetPicSelect(Value: TPicture);
    procedure WMERASEBKGND(var Msg : TMessage); message WM_ERASEBKGND;
    procedure WMKeyDown(var Msg : TWMKeyDown); message WM_KEYDOWN;
    procedure WMKeyUp(var Msg : TWMKeyUp); message WM_KEYUP;
    procedure WMKillFocus(var Msg : TWMKillFocus); message WM_KILLFOCUS;
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
  protected
    m_MouseDown: Boolean;
    m_MouseIn: Boolean;
    m_Select: Boolean;
    procedure CaptionChanged; virtual;
    procedure EnableChanged; virtual;
    procedure FontChanged; virtual;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y:
            Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure Paint; override;
    procedure SetEnabled(Value : Boolean); override;
  public
    constructor Create(AOwner : TComponent); override;
    procedure Click; override;
    property Default: Boolean read m_Default write SetDefault default false;
    property OnMouseEnter: TNotifyEvent read m_OnMouseEnter write
            m_OnMouseEnter;
    property OnMouseExit: TNotifyEvent read m_OnMouseExit write m_OnMouseExit;

  published
    property Caption: TCaption read FCaption write SetCaption;
    property Secected: Boolean read FSecected write FSecected;
    property Transparent:Boolean Read FTransparent Write FTransparent;
    property Font;
    property Enabled;
    property OnClick;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property PicDisabled: TPicture read FPicDisabled write SetPicDisabled;
    property PicMouseDown: TPicture read FPicMouseDown write SetPicMouseDown;
    property PicMouseOn: TPicture read FPicMouseOn write SetPicMouseOn;
    property PicNormal: TPicture read FPicNormal write SetPicNormal;
    property PicSelect: TPicture read FPicSelect write SetPicSelect;
  end;
  
procedure Register;
implementation

procedure Register;
begin
  RegisterComponents('Topdelphi', [TImageButton]);
end;
{
********************************* TImageButton *********************************
}
constructor TImageButton.Create(AOwner : TComponent);
begin
  inherited;
  ControlStyle := ControlStyle - [csDoubleClicks];
  ControlStyle := ControlStyle - [csAcceptsControls];
  
  FPicDisabled := TPicture.Create();
  FPicNormal := TPicture.Create();
  FPicMouseDown := TPicture.Create();
  FPicMouseOn := TPicture.Create();
  FPicSelect:=TPicture.Create();
  inherited OnClick := nil;
  inherited Caption := '';
  
  m_MouseIn := false;
  m_MouseDown := false;
  
  TabStop := true;
end;

procedure TImageButton.CaptionChanged;
begin
  
end;

procedure TImageButton.Click;
begin
 inherited;
 if m_MouseDown then
  begin
      m_MouseDown := false;
      Repaint();
  end;
  
  if TabStop and CanFocus() and Enabled then
      SetFocus();
  

  
end;

procedure TImageButton.CMDialogChar(var Msg : TCMDialogChar);
begin
  inherited;
  
  if IsAccel(Msg.CharCode, FCaption) and Enabled then
  begin
      Click();
      Msg.Result := 1;
  end
  else
      Msg.Result := 0;
end;

procedure TImageButton.CMDialogKey(var Message: TCMDialogKey);
begin
  with Message do
  if  (((CharCode = VK_RETURN) and m_Default) or
    ((CharCode = VK_ESCAPE) and m_Cancel)) and
    (KeyDataToShiftState(Message.KeyData) = []) and CanFocus then
  begin
    Click;
    Result := 1;
  end else
    inherited;
end;

procedure TImageButton.CMFocusChanged(var Msg: TCMFocusChanged);
begin
  Inherited;
  
  Repaint();
end;

procedure TImageButton.CMFONTCHANGED(var Msg : TMessage);
begin
  FontChanged();
end;

procedure TImageButton.CMTextChanged(var Msg : TMessage);
begin
  Caption := inherited Caption;
end;

procedure TImageButton.EnableChanged;
begin
  
end;

procedure TImageButton.FontChanged;
begin
    Canvas.Font := Font;
  Repaint();
end;

procedure TImageButton.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
        Y: Integer);
begin
  if Button = mbLeft then
  begin
      m_MouseDown := true;
  
      Repaint();
  end;
  
  inherited;
end;

procedure TImageButton.MouseEnter(var Msg : TMessage);
begin
    inherited;
  
  if csDesigning in ComponentState then
      Exit;
  
  m_MouseIn := true;
  Repaint();
  
  if Assigned(m_OnMouseEnter) then
      m_OnMouseEnter(self);
end;

procedure TImageButton.MouseLeave(var Msg : TMessage);
begin
    inherited;
  
  m_MouseIn := false;
  m_MouseDown := false;
  
  Repaint();
  
  if Assigned(m_OnMouseExit) then
      m_OnMouseExit(self);
end;

procedure TImageButton.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  
  if (
      (X < 0) or
      (Y < 0) or
      (X > Width) or
      (Y > Height)
  ) then
  begin
      m_MouseIn := false;
      m_MouseDown := false;
      Repaint();
  end;
  
end;
procedure DoTrans(Canvas : TCanvas; Control : TWinControl);
var
    DC : HDC;
    SaveIndex : HDC;
    Position: TPoint;
begin
    if Control.Parent <> nil then
    begin
{$R-}
        DC := Canvas.Handle;
        SaveIndex := SaveDC(DC);
        GetViewportOrgEx(DC, Position);
        SetViewportOrgEx(DC, Position.X - Control.Left, Position.Y - Control.Top, nil);
        IntersectClipRect(DC, 0, 0, Control.Parent.ClientWidth, Control.Parent.ClientHeight);
        Control.Parent.Perform(WM_ERASEBKGND, DC, 0);
        Control.Parent.Perform(WM_PAINT, DC, 0);
        RestoreDC(DC, SaveIndex);
{$R+}
    end;
end;
procedure TImageButton.PaintText(ACanvas: TCanvas; Text: String);
var
    R : TRect;
begin
    ACanvas.Brush.Style := bsClear;
    R := ClientRect;
    ACanvas.Font := Font;

    if not Enabled then
    begin
        R := Rect(R.Left + 1, R.Top + 1, R.Right + 1, R.Bottom + 1);
        ACanvas.Font.Color := clWhite;
        DrawText(ACanvas.Handle, PChar(Caption), -1, R, DT_CENTER or DT_SINGLELINE or DT_VCENTER);
        R := ClientRect;
        ACanvas.Font.Color := clGray;
    end
    else
    begin
        if m_MouseDown then
            R := Rect(R.Left + 1, R.Top + 1, R.Right + 1, R.Bottom + 1);
    end;
    DrawText(ACanvas.Handle, PChar(Caption), -1, R, DT_CENTER or DT_SINGLELINE or DT_VCENTER);

end;
procedure TImageButton.Paint;
var
  Buf: TBitmap;
begin
   Buf:=TBitMap.Create;
   Buf.Width:=Width;
   Buf.Height:=Height;
   Buf.Transparent:=FTransparent;
  try
   if not Enabled then
   Begin
     if FPicDisabled<>nil then
        Buf.Assign(FPicDisabled.Graphic)
   End
   else
   Begin
     if  FSecected then
     Begin
       if FPicSelect<>nil then
       Begin
         Buf.Assign(FPicSelect.Graphic);
       End;
     End
     else
     Begin
        if m_MouseDown then
        Begin
         if FPicMouseDown<>nil then
            Buf.Assign(FPicMouseDown.Graphic);
        End
        else
          if m_MouseIn then
          Begin
            if FPicMouseOn<>nil then
                Buf.Assign(FPicMouseOn.Graphic);
          End
          else
            if FPicNorMal<>nil then
               Buf.Assign(FPicNormal.Graphic)
     End;
   End;
   except

   End;
   if FTransparent then
       DoTrans(Canvas,self);

  Buf.Transparent:=FTransparent;
 Buf.TransparentColor:=BUf.Canvas.Pixels[0,0];
 // if FTransparent then
 //  SetBkMode(Canvas.handle, OPAQUE);

   Canvas.Font := Font;
    if Trim(FCaption) <> '' then
        PaintText(Buf.Canvas, FCaption);


   Canvas.Draw(0,0,Buf);
  
  
end;

procedure TImageButton.SetCaption(Value: TCaption);
begin
  FCaption := Value;
  inherited Caption := Value;
  
  CaptionChanged();
  Repaint();
end;

procedure TImageButton.SetDefault(const Value: Boolean);
var
  Form: TCustomForm;
begin
    m_Default := Value;
    if HandleAllocated then
    begin
        Form := GetParentForm(Self);
        if Form <> nil then
            Form.Perform(CM_FOCUSCHANGED, 0, Longint(Form.ActiveControl));
  end;
end;

procedure TImageButton.SetEnabled(Value : Boolean);
begin
  inherited;
  
  EnableChanged();
  Repaint();
  
end;

procedure TImageButton.SetPicDisabled(Value: TPicture);
begin
  FPicDisabled.Assign(Value);
  Repaint();
end;

procedure TImageButton.SetPicMouseDown(Value: TPicture);
begin
  FPicMouseDown.Assign(Value);
  Repaint();
end;

procedure TImageButton.SetPicMouseOn(Value: TPicture);
begin
  FPicMouseOn.Assign(Value);
  Repaint();
end;

procedure TImageButton.SetPicNormal(Value: TPicture);
begin
  if Value=nil then exit;

  FPicNormal.Assign(Value);
  Width:=Value.Width;
  Height:=Value.Height;
  Repaint();
end;

procedure TImageButton.SetPicSelect(Value: TPicture);
begin
  FPicSelect.Assign(Value);
  Repaint();
  
end;

procedure TImageButton.WMERASEBKGND(var Msg : TMessage);
begin
  
end;

procedure TImageButton.WMKeyDown(var Msg : TWMKeyDown);
begin
  inherited;
  
  if (
      ((Msg.CharCode = VK_SPACE) or (Msg.CharCode = VK_RETURN)) and
      Focused
  ) then
  begin
      if Enabled then
      begin
          m_MouseDown := true;
          Repaint();
      end;
  end;
end;

procedure TImageButton.WMKeyUp(var Msg : TWMKeyUp);
begin
  inherited;
  
  if (
      ((Msg.CharCode = VK_SPACE) or (Msg.CharCode = VK_RETURN)) and
      Focused and
      (m_MouseDown)
  ) then
  begin
      if Enabled then
      begin
          m_MouseDown := false;
          Repaint();
          Click();
      end;
  end;
end;

procedure TImageButton.WMKillFocus(var Msg : TWMKillFocus);
begin
  inherited;
  
  Repaint();
end;

procedure TImageButton.WMSetFocus(var Msg: TWMSetFocus);
begin
   inherited;
  
  Repaint();
end;









end.
