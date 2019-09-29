program GetMD5;

uses
  Forms,
  fmMain in 'fmMain.pas' {Form1},
  Md5 in '..\LoginCommon\Md5.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
