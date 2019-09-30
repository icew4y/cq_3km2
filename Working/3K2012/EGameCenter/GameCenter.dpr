program GameCenter;

uses
  Forms,
  GMain in 'GMain.pas' {frmMain},
  GShare in 'GShare.pas',
  HUtil32 in 'HUtil32.pas',
  Grobal2 in 'Grobal2.pas',
  GClearServer in 'GClearServer.pas',
  EDcode in '..\Common\EDcode.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.HintPause:=100;
  Application.HintShortPause:=100;
  Application.HintHidePause:=15000;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
