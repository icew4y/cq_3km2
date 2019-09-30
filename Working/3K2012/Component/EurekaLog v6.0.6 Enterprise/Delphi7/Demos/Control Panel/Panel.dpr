library Panel;

uses
  ExceptionLog,
  CtlPanel,
  ShowForm in 'ShowForm.pas' {Applet: TAppletModule},
  MainPanel in 'MainPanel.pas' {MainForm};

exports CPlApplet;

{$R *.RES}

{$E cpl}

begin
  Application.Initialize;
  Application.CreateForm(TApplet, Applet);
  Application.Run;
end.