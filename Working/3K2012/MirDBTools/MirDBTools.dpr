program MirDBTools;

uses
  Forms,
  Grobal2 in '..\Common\Grobal2.pas',
  MudUtil in '..\Common\MudUtil.pas',
  Main in 'Main.pas' {FrmMain},
  HumDB in 'HumDB.pas',
  DBToolsShare in 'DBToolsShare.pas',
  IdDB in 'IdDB.pas',
  BlurFind in 'BlurFind.pas' {FrmBlurFind},
  AddMagic in 'AddMagic.pas' {AddMagicFrm},
  Setup in 'Setup.pas' {SetupFrm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '3K科技数据通';
  Application.CreateForm(TSetupFrm, SetupFrm);
  Application.Run;
end.
