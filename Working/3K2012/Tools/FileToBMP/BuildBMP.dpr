program BuildBMP;

uses
  Forms,
  fmMain in 'fmMain.pas' {FrmMain},
  Md5 in '..\..\EGameLogin\LoginCommon\Md5.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
