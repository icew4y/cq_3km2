program LoginSrv;

uses
  Forms,
  GateSet in 'GateSet.pas' {FrmGateSetting},
  MasSock in 'MasSock.pas' {FrmMasSoc},
  EditUserInfo in 'EditUserInfo.pas' {FrmUserInfoEdit},
  FrmFindId in 'FrmFindId.pas' {FrmFindUserId},
  FAccountView in 'FAccountView.pas' {FrmAccountView},
  LMain in 'LMain.pas' {FrmMain},
  MonSoc in 'MonSoc.pas' {FrmMonSoc},
  LSShare in 'LSShare.pas',
  Parse in 'Parse.pas',
  IDDB in 'IDDB.pas',
  GrobalSession in 'GrobalSession.pas' {frmGrobalSession},
  MudUtil in '..\Common\MudUtil.pas',
  HUtil32 in '..\Common\HUtil32.pas',
  Grobal2 in '..\Common\Grobal2.pas',
  SDK in 'SDK.pas',
  Common in '..\Common\Common.pas',
  DESTR in '..\Common\DESTR.pas',
  BasicSet in 'BasicSet.pas' {FrmBasicSet},
  EDcodeUnit in '..\Common\EDcodeUnit.pas',
  AboutUnit in 'AboutUnit.pas' {FrmAbout},
  DBTools in 'DBTools.pas' {FrmDBTools},
  EDcode in '..\Common\EDcode.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmMasSoc, FrmMasSoc);
  Application.CreateForm(TFrmUserInfoEdit, FrmUserInfoEdit);
  Application.CreateForm(TFrmFindUserId, FrmFindUserId);
  Application.CreateForm(TFrmAccountView, FrmAccountView);
  Application.CreateForm(TFrmMonSoc, FrmMonSoc);
  Application.CreateForm(TFrmBasicSet, FrmBasicSet);
  Application.CreateForm(TFrmAbout, FrmAbout);
  Application.Run;
end.

