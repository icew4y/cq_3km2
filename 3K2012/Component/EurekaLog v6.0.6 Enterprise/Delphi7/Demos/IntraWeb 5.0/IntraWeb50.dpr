program IntraWeb50;

uses
  ExceptionLog,
  IWInitStandAlone,
  ServerController in 'ServerController.pas' {IWServerController: TDataModule},
  MainForm in 'MainForm.pas' {formMain: TIWForm1};

{$R *.res}

begin
  IWRun(TFormMain, TIWServerController);
end.
