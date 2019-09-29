program Service;

uses
  ExceptionLog,
  SvcMgr,
  ServiceUnit in 'ServiceUnit.pas' {EurekaLogService: TService},
  MainService in 'MainService.pas' {MainForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TEurekaLogService, EurekaLogService);
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
