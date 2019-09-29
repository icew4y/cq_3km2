program RunGate;

uses
  Forms,
  Main in 'Main.pas' {FrmMain},
  GateShare in 'GateShare.pas',
  GeneralConfig in 'GeneralConfig.pas' {frmGeneralConfig},
  MessageFilterConfig in 'MessageFilterConfig.pas' {frmMessageFilterConfig},
  IPaddrFilter in 'IPaddrFilter.pas' {frmIPaddrFilter},
  HUtil32 in 'HUtil32.pas',
  PrefConfig in 'PrefConfig.pas' {frmPrefConfig},
  OnLineHum in 'OnLineHum.pas' {FrmOnLineHum},
  AboutUnit in 'AboutUnit.pas' {FrmAbout},
  QQWry in 'QQWry.pas',
  EDcode in '..\Common\EDcode.pas',
  HookToolRes in 'HookToolRes.pas' {FrmHookCheck},
  Grobal2 in 'Grobal2.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.HintHidePause:=10000;
  Application.HintPause:=100;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TfrmGeneralConfig, frmGeneralConfig);
  Application.CreateForm(TfrmMessageFilterConfig, frmMessageFilterConfig);
  Application.CreateForm(TfrmIPaddrFilter, frmIPaddrFilter);
  Application.CreateForm(TfrmPrefConfig, frmPrefConfig);
  Application.CreateForm(TFrmOnLineHum, FrmOnLineHum);
  Application.CreateForm(TFrmAbout, FrmAbout);
  Application.CreateForm(TFrmHookCheck, FrmHookCheck);
  Application.Run;
end.
