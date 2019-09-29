program MakeGameLogin;


uses
  Forms,
  Main in 'Main.pas' {MainFrm},
  Md5 in '..\LoginCommon\Md5.pas',
  AddGameList in 'AddGameList.pas' {AddGameListFrm},
  HUtil32 in '..\..\Common\HUtil32.pas',
  //MakeGameLoginShare in 'MakeGameLoginShare.pas',
  uTzHelp in 'uTzHelp.pas' {FrmTzHelp},
  uSelectDB in 'uSelectDB.pas' {FrmSelectDB},
  Common in '..\LoginCommon\Common.pas',
  uFileUnit in '..\LoginCommon\uFileUnit.pas',
  GameLoginShare in '..\LoginCommon\GameLoginShare.pas',
  FileUnit in '..\LoginCommon\FileUnit.pas';

{$R *.res}
{$R .\资源文件\GameLogin.res}
begin
  Application.Initialize;
  Application.Title := '3K引擎登陆器配置器';
  Application.CreateForm(TMainFrm, MainFrm);
  Application.CreateForm(TAddGameListFrm, AddGameListFrm);
  Application.CreateForm(TFrmTzHelp, FrmTzHelp);
  Application.CreateForm(TFrmSelectDB, FrmSelectDB);
  Application.Run;
end.
