unit MsgBox;

interface

uses
  Windows, Messages,   Forms,
  RzBmpBtn, RzLabel, StdCtrls, ExtCtrls, Classes, Controls, Common, jpeg;

type
  TFrmMessageBox = class(TForm)
    ImageMain: TImage;
    LabelHintMsg: TRzLabel;
    RzURLLabel1: TRzURLLabel;
    btnOK: TRzBmpButton;
    btnCancel: TRzBmpButton;
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure ImageMainMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMessageBox: TFrmMessageBox;

implementation

uses Main, GameLoginShare;

{$R *.dfm}

procedure TFrmMessageBox.btnOKClick(Sender: TObject);
begin
  if g_boIsGamePath then begin
    FrmMain.TimerPatch.Enabled:=True; //有升级文件，下载按钮可操作
    FrmMain.EnabledServerList := False;
  end;
  Exit;
end;

procedure TFrmMessageBox.btnCancelClick(Sender: TObject);
begin
  if g_boIsGamePath then begin
    FrmMain.StatusString :={'请选择服务器登陆...'}SetDate('蠕蕻埝格窿渗喝筒!!!');
    g_boIsGamePath := False;
    FrmMain.EnabledServerList := True;
  end;
  Close;
end;

procedure TFrmMessageBox.ImageMainMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then ReleaseCapture;
  Perform(WM_SYSCOMMAND, $F012, 0);
end;

end.
