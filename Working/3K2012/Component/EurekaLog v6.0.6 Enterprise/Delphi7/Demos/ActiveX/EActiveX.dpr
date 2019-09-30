library EActiveX;

uses
  ExceptionLog,
  ComServ,
  EActiveX_TLB in 'EActiveX_TLB.pas',
  ActiveFormImpl1 in 'ActiveFormImpl1.pas' {ActiveFormX: TActiveForm} {ActiveFormX: CoClass};

{$E ocx}

exports
  DllGetClassObject,
  DllCanUnloadNow,
  DllRegisterServer,
  DllUnregisterServer;

{$R *.TLB}

{$R *.RES}

begin
end.
