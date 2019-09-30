library ISAPI;

uses
  ExceptionLog,
  WebBroker,
  SysUtils,
  ISAPIApp,
  MainISAPI in 'MainISAPI.pas' {Module: TWebModule};

{$R *.RES}

exports
  GetExtensionVersion,
  HttpExtensionProc,
  TerminateExtension;

{ TEurekaApp }

begin
  Application.Initialize;
  Application.CreateForm(TModule, Module);
  Application.Run;
end.
