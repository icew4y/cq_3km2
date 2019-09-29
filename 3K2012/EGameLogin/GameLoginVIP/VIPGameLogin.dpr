program VIPGameLogin;

uses
  Forms,
  fmMain in 'fmMain.pas' {FrmMain2},
  Md5 in '..\LoginCommon\Md5.pas',
  Reg in '..\LoginCommon\Reg.pas',
  EDcodeUnit in '..\..\Common\EDcodeUnit.pas',
  GameMon in '..\LoginCommon\GameMon.pas',
  FileUnit in '..\LoginCommon\FileUnit.pas',
  Common in 'Common\Common.pas',
  uTasBMPFIle in '..\Common\uTasBMPFIle.pas',
  MsgBox in '..\LoginCommon\MsgBox.pas' {FrmMessageBox},
  NewAccount in '..\LoginCommon\NewAccount.pas' {FrmNewAccount},
  Secrch in '..\LoginCommon\Secrch.pas',
  ChangePassword in '..\LoginCommon\ChangePassword.pas' {FrmChangePassword},
  GameLoginShare in '..\LoginCommon\GameLoginShare.pas',
  GetBackPassword in '..\LoginCommon\GetBackPassword.pas' {FrmGetBackPassword};

{$R *.res}
{$R ..\资源文件\Mir2.Res}
begin
  Application.Initialize;
  Application.CreateForm(TFrmMain2, FrmMain2);
  Application.CreateForm(TFrmNewAccount, FrmNewAccount);
  Application.CreateForm(TFrmChangePassword, FrmChangePassword);
  Application.CreateForm(TFrmGetBackPassword, FrmGetBackPassword);
  Application.CreateForm(TFrmMessageBox, FrmMessageBox);
  Application.CreateForm(TFrmChangePassword, FrmChangePassword);
  Application.CreateForm(TFrmGetBackPassword, FrmGetBackPassword);
  Application.CreateForm(TFrmNewAccount, FrmNewAccount);
  Application.CreateForm(TFrmMessageBox, FrmMessageBox);
  Application.CreateForm(TFrmNewAccount, FrmNewAccount);
  Application.CreateForm(TFrmChangePassword, FrmChangePassword);
  Application.CreateForm(TFrmGetBackPassword, FrmGetBackPassword);
  Application.Run;
end.
