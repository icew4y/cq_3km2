program UpDateServer;

uses
  Forms,
  fmMain in 'fmMain.pas' {FrmMain},
  fsShare in '..\..\Common\fsShare.pas',
  WilRead in 'WilRead.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
