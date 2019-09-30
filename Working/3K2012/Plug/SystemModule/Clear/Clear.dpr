program Clear;

uses
  Forms,
  Main in 'Main.pas' {FrmClean},
  EDcode in '..\UserLicense\EDcode.pas',
  DESTR in '..\UserLicense\DESTR.pas',
  HardInfo in '..\HardInfo.pas',
  MD5EncodeStr in '..\UserLicense\MD5EncodeStr.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmClean, FrmClean);
  Application.Run;
end.
