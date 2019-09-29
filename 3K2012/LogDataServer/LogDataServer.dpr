program LogDataServer;

uses
  //FastMM4,
  //FastMM4Messages,
  Forms,
  LogDataMain in 'LogDataMain.pas' {FrmLogData},
  LDShare in 'LDShare.pas',
  Grobal2 in 'Grobal2.pas',
  HUtil32 in '..\Common\HUtil32.pas',
  LogSelect in 'LogSelect.pas' {LogFrm},
  DM in 'DM.pas' {DMFrm: TDataModule},
  About in 'About.pas' {AboutFrm};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFrmLogData, FrmLogData);
  Application.CreateForm(TDMFrm, DMFrm);
  Application.Run;
end.
