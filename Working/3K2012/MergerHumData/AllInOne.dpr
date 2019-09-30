program AllInOne;

uses
  Forms,
  U_FrmMain in 'U_FrmMain.pas' {FrmMain},
  Share in 'Share.pas',
  Mudutil in 'Mudutil.pas',
  MirDB in 'MirDB.pas',
  U_FrmDataEdit in 'U_FrmDataEdit.pas' {FrmDataEdit},
  U_FrmChange in 'U_FrmChange.pas' {FrmChange},
  SysUtils;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title :='3K合区工具';
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.

