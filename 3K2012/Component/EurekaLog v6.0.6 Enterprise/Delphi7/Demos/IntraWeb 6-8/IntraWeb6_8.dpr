program IntraWeb6_8;

uses
  ExceptionLog,
  Forms,
  IWMain,
  ServerController in 'ServerController.pas' {IWServerController: TIWServerController},
  MainForm in 'MainForm.pas' {formMain: TIWFormModuleBase};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TformIWMain, formIWMain);
  Application.Run;
end.
