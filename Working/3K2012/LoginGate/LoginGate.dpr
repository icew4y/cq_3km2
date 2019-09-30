program LoginGate;

uses
  Forms,
  Main in 'Main.pas' {FrmMain},
  GateShare in 'GateShare.pas',
  GeneralConfig in 'GeneralConfig.pas' {frmGeneralConfig},
  IPaddrFilter in 'IPaddrFilter.pas' {frmIPaddrFilter},
  HUtil32 in '..\Common\HUtil32.pas',
  Common in '..\Common\Common.pas',
  EDcode in '..\Common\EDCode.pas', //20080901
  EDcodeUnit in '..\Common\EDcodeUnit.pas', //20080901
  Grobal2 in '..\Common\Grobal2.pas', //20080901
  Md5 in 'Md5.pas',
  AboutUnit in 'AboutUnit.pas' {FrmAbout},
  QQWry in 'QQWry.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TfrmGeneralConfig, frmGeneralConfig);
  Application.CreateForm(TfrmIPaddrFilter, frmIPaddrFilter);
  Application.CreateForm(TFrmAbout, FrmAbout);
  Application.Run;
end.

