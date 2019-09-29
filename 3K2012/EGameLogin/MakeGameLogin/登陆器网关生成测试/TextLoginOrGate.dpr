program TextLoginOrGate;

uses
  Forms,
  Main in 'Main.pas' {FrmMain},
  Share in 'Share.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
