program M2U2Client;

uses
  Forms,
  Main in 'Main.pas' {FrmMain},
  Login in 'Login.pas' {FrmLogin},
  Grobal2 in '..\Common\Grobal2.pas',
  EDcode in 'EDcode.pas',
  Common in '..\Common\Common.pas',
  EDcodeUnit in '..\Common\EDcodeUnit.pas',
  HUtil32 in '..\Common\HUtil32.pas',
  Share in 'Share.pas',
  PassWord in 'PassWord.pas' {FrmPassWord},
  About in 'About.pas' {FrmAbout},
  M2regFile in 'M2regFile.pas' {M2regFileFrm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '3K科技引擎生成客户端';
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TM2regFileFrm, M2regFileFrm);
  //Application.CreateForm(TFrmPassWord, FrmPassWord);
  Application.CreateForm(TFrmAbout, FrmAbout);
  //Application.CreateForm(TFrmLogin, FrmLogin);
  Application.Run;
end.
