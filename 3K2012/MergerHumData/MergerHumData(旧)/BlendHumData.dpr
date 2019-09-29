program BlendHumData;

uses
  Forms,
  main in 'main.pas' {FrmMain},
  Log in 'Log.pas' {FrmLog},
  Share in 'Share.pas',
  UnitMainWork in 'UnitMainWork.pas',
  UniTypes in 'UniTypes.pas',
  HumDB in 'HumDB.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '3K科技合区工具';
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmLog, FrmLog);
  Application.Run;
end.
