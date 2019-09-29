program CGI;

{$APPTYPE CONSOLE}

uses
  ExceptionLog,
  WebBroker,
  CGIApp,
  MainCGI in 'MainCGI.pas' {Module: TWebModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TModule, Module);
  Application.Run;
end.
