program ResDemo;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  uRes in '..\..\Common\uRes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
