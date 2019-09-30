unit ImageProgressbar;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs,StdCtrls;

type
  TImageProgressbar = class(TCustomControl)
  private
    FbarNum: Integer;
    FBarWidth: Word;
    FMax: LongWord;
    FMin: Integer;
    FPicBar: TPicture;
    FPicMain: TPicture;
    Fposition: LongWord;
    FStep: Word;
    m_Cancel: Boolean;
    m_Default: Boolean;
    procedure SetDefault(const Value: Boolean);
    procedure SetPicBar(Value: TPicture);
    procedure SetPicMain(Value: TPicture);
    procedure Setposition(Value: LongWord);
    procedure WMERASEBKGND(var Msg : TMessage); message WM_ERASEBKGND;
    procedure WMKeyDown(var Msg : TWMKeyDown); message WM_KEYDOWN;
    procedure WMKeyUp(var Msg : TWMKeyUp); message WM_KEYUP;
    procedure WMKillFocus(var Msg : TWMKillFocus); message WM_KILLFOCUS;
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
  protected
    procedure CaptionChanged; virtual;
    procedure EnableChanged; virtual;
    procedure FontChanged; virtual;
    procedure Paint; override;
    procedure SetEnabled(Value : Boolean); override;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure StepIt;
    property Default: Boolean read m_Default write SetDefault default false;
  published
    property Enabled;
    property Max: LongWord read FMax write FMax;
    property Min: Integer read FMin write FMin;
    property PicBar: TPicture read FPicBar write SetPicBar;
    property PicMain: TPicture read FPicMain write SetPicMain;
    property position: LongWord read Fposition write Setposition;
    property Step: Word read FStep write FStep;
    property PopupMenu;
    property ShowHint;
  end;
  
procedure Register;
implementation

procedure Register;
begin
  RegisterComponents('Topdelphi', [TImageProgressbar]);
end;
{
****************************** TImageProgressbar *******************************
}
constructor TImageProgressbar.Create(AOwner : TComponent);
begin
  inherited;
  ControlStyle := ControlStyle - [csDoubleClicks];
  ControlStyle := ControlStyle - [csAcceptsControls];
  
  FPicBar := TPicture.Create();
  FPicMain := TPicture.Create();
  
  TabStop := true;
end;

procedure TImageProgressbar.CaptionChanged;
begin
  
end;

procedure TImageProgressbar.EnableChanged;
begin
  
end;

procedure TImageProgressbar.FontChanged;
begin
    Canvas.Font := Font;
  Repaint();
end;

procedure TImageProgressbar.Paint;
var
  Buf: TBitmap;
  i, Num, x: Integer;
begin
   Buf:=TBitMap.Create;
   Buf.Width:=Width;
   Buf.Height:=Height;
  try
    Buf.Assign(FpicMain.Graphic);
    if FPicBar<>nil then
    Begin
      FBarNum:=Width div FPicBar.Width;
      Num:=FBarNum*Fposition div FMax+1;
      For i:=0 to Num-1 do
        Buf.Canvas.Draw(i*FPicBar.Width,2,FPicBar.Graphic);
    End;
  Except
  End;
  Canvas.Draw(0,0,Buf);
end;

procedure TImageProgressbar.SetDefault(const Value: Boolean);
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

procedure TImageProgressbar.SetEnabled(Value : Boolean);
begin
  inherited;
  
  EnableChanged();
  Repaint();
  
end;

procedure TImageProgressbar.SetPicBar(Value: TPicture);
begin
  if Value=nil then exit;
  
  FPicBar.Assign(Value);
  FBarWidth:=FPicBar.Width;
  
  Repaint();
end;

procedure TImageProgressbar.SetPicMain(Value: TPicture);
begin
  FPicMain.Assign(Value);
  Width:=Value.Width;
  Height:=Value.Height;
  Repaint();
end;

procedure TImageProgressbar.Setposition(Value: LongWord);
begin
  Fposition:=Value;
  Repaint();
end;

procedure TImageProgressbar.StepIt;
begin
  Inc(Fposition,FStep);
  if Fposition>FMax then
       Fposition:=FMax;
   Repaint();
end;

procedure TImageProgressbar.WMERASEBKGND(var Msg : TMessage);
begin
  
end;

procedure TImageProgressbar.WMKeyDown(var Msg : TWMKeyDown);
begin
  inherited;
  
end;

procedure TImageProgressbar.WMKeyUp(var Msg : TWMKeyUp);
begin
  inherited;
end;

procedure TImageProgressbar.WMKillFocus(var Msg : TWMKillFocus);
begin
  inherited;
  
  Repaint();
end;

procedure TImageProgressbar.WMSetFocus(var Msg: TWMSetFocus);
begin
   inherited;
  
  Repaint();
end;











destructor TImageProgressbar.Destroy;
begin
  inherited;
  FPicBar.Free;
  FPicMain.Free;
end;

end.