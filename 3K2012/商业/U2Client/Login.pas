unit Login;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, StdCtrls, RzCmboBx, Mask, RzEdit, Buttons,
  WinSkinData, RzLabel;

type
  TFrmLogin = class(TForm)
    BtnLogin: TBitBtn;
    BtnExit: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    EdtPass: TEdit;
    ComboBoxUser: TComboBox;
    RzURLLabel1: TRzURLLabel;
    RzURLLabel2: TRzURLLabel;
    procedure BtnExitClick(Sender: TObject);
    procedure BtnLoginClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;

implementation

uses Main, Share, EDcodeUnit;

{$R *.dfm}

procedure TFrmLogin.BtnExitClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFrmLogin.BtnLoginClick(Sender: TObject);
var
  sAccount: string;
  sPassword: string;
  sServerAdd: string;
begin
  sAccount := Trim(ComboBoxUser.Text);
  sPassword := Trim(EdtPass.Text);
  if sAccount = '' then begin
    Application.MessageBox('请输入登录帐号！', '提示信息', MB_OK + MB_ICONWARNING);
    ComboBoxUser.SetFocus;
    Exit;
  end;
  if sPassword = '' then begin
    Application.MessageBox('请输入密码！', '提示信息', MB_OK + MB_ICONWARNING);
    EdtPass.SetFocus;
    Exit;
  end;
  BtnLogin.Enabled := False;
  ComboBoxUser.Enabled := False;
  EdtPass.Enabled := False;
  g_sAccount := sAccount;
  g_sPassword := sPassword;
  Decode(g_sServerAdd, sServerAdd);
  FrmMain.ClientSocket.Active := False;
  FrmMain.ClientSocket.Host := sServerAdd;
  FrmMain.ClientSocket.Port := 36009;
  FrmMain.ClientSocket.Active := True;
  FrmMain.StatusPaneMsg.Panels[0].Text := '正在连接服务器...';
  
end;

end.
