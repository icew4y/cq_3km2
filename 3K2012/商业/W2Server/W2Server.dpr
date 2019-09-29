program W2Server;

uses
  Forms,
  Main in 'Main.pas' {FrmMain},
  HUtil32 in '..\Common\HUtil32.pas',
  EDcodeUnit in '..\Common\EDcodeUnit.pas',
  Share in 'Share.pas',
  Grobal2 in '..\Common\Grobal2.pas',
  EDCode in '..\Common\EDCode.pas',
  Common in '..\Common\Common.pas',
  MD5EncodeStr in 'MD5EncodeStr.pas',
  DM in 'DM.pas' {FrmDm: TDataModule},
  ThreadQuery in 'ThreadQuery.pas',
  BasicSet in 'BasicSet.pas' {FrmBasicSet},
  WinlicenseSDK in 'WinlicenseSDK.pas',
  DESTR in '..\Common\DESTR.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'QK科技代理引擎';
  Application.CreateForm(TFrmDm, FrmDm);
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmBasicSet, FrmBasicSet);
  Application.Run;
end.
