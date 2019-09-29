program FreeGameLogin;

uses
  Forms,
  Classes,
  MainZt in 'MainZt.pas' {FrmMainZt},
  GameLoginShare in '..\LoginCommon\GameLoginShare.pas',
  Md5 in '..\LoginCommon\Md5.pas',
  Reg in '..\LoginCommon\Reg.pas',
  Grobal2 in '..\..\Common\Grobal2.pas',
  HUtil32 in '..\..\Common\HUtil32.pas',
  EDcodeUnit in '..\..\Common\EDcodeUnit.pas',
  EDcode in '..\..\Common\EDcode.pas',
  Main in '..\Common\Main.pas',
  GameMon in 'GameMon.pas',
  Common in '..\LoginCommon\Common.pas',
  FileUnit in '..\LoginCommon\FileUnit.pas',
  Image2 in 'Image2.pas' {Form1},
  DataUnit in 'DataUnit.pas',
  NewAccount in '..\LoginCommon\NewAccount.pas' {FrmNewAccount},
  GetBackPassword in '..\LoginCommon\GetBackPassword.pas' {FrmGetBackPassword},
  MsgBox in '..\LoginCommon\MsgBox.pas',
  ChangePassword in '..\LoginCommon\ChangePassword.pas' {FrmChangePassword},
  uFileUnit in '..\LoginCommon\uFileUnit.pas',
  Secrch in '..\LoginCommon\Secrch.pas',
  EditGame in '..\LoginCommon\EditGame.pas' {FrmEditGame},
  MainMini in 'MainMini.pas' {FrmMainMini};

{$R *.res}
{$R ..\资源文件\Mir2.Res}
var
 info : TRecinfo;
begin
  Application.Initialize;
  asm db $EB,$10,'VMProtect begin',0 end;
  {$IF  Testing = 0}
  ExtractInfo(Application.ExeName, info);
  if info.FDDllFileSize = 0 then
    Application.CreateForm(TFrmMainZt, FrmMainZt)
  else
  {$ifend}
    Application.CreateForm(TFrmMainMini, FrmMainMini);
  asm db $EB,$0E,'VMProtect end',0; end;  
  Application.CreateForm(TFrmNewAccount, FrmNewAccount);
  Application.CreateForm(TFrmChangePassword, FrmChangePassword);
  Application.CreateForm(TFrmGetBackPassword, FrmGetBackPassword);
  Application.CreateForm(TFrmMessageBox, FrmMessageBox);
  Application.CreateForm(TFrmNewAccount, FrmNewAccount);
  Application.CreateForm(TFrmChangePassword, FrmChangePassword);
  Application.CreateForm(TFrmGetBackPassword, FrmGetBackPassword);
  Application.CreateForm(TFrmChangePassword, FrmChangePassword);
  Application.CreateForm(TFrmEditGame, FrmEditGame);

  Application.Run;
end.
