program GUI;

uses
  ExceptionLog,
  Forms,
  MainForm in 'MainForm.pas' {GUIForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'EurekaLog - Demo';
  Application.CreateForm(TGUIForm, GUIForm);
  Application.Run;
end.
