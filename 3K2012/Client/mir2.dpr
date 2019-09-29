program mir2;

uses
  Forms,
  Windows,
  sysutils,
  ClMain in 'ClMain.pas' {frmMain},
  DrawScrn in 'DrawScrn.pas',
  IntroScn in 'IntroScn.pas',
  PlayScn in 'PlayScn.pas',
  MapUnit in 'MapUnit.pas',
  FState in 'FState.pas' {FrmDlg},
  ClFunc in 'ClFunc.pas',
  cliUtil in 'cliUtil.pas',
  DWinCtl in 'DWinCtl.pas',
  WIL in 'WIL.pas',
  magiceff in 'magiceff.pas',
  SoundUtil in 'SoundUtil.pas',
  Actor in 'Actor.pas',
  HerbActor in 'HerbActor.pas',
  AxeMon in 'AxeMon.pas',
  clEvent in 'clEvent.pas',
  HUtil32 in 'HUtil32.pas',
  MShare in 'MShare.pas',
  Share in 'Share.pas',
  SDK in 'SDK.pas',
  Mpeg in 'Mpeg.pas',
  wmUtil in 'wmUtil.pas',
  MapFiles in 'MapFiles.pas',
  EDcode in '..\Common\EDcode.pas',
  EDcodeUnit in '..\Common\EDcodeUnit.pas',
  Splash in 'Splash.pas' {SplashForm},
  Browser in 'Browser.pas' {frmBrowser},
  PathFind in 'PathFind.pas',
  DataUnit in 'DataUnit.pas',
  Md5 in 'Md5.pas',
  Hashtable in 'Hashtable.pas',
  UiWil in 'UiWil.pas',
  uDScrollBox in 'uDScrollBox.pas',
  uDScrollBar in 'uDScrollBar.pas',
  uDListView in 'uDListView.pas',
  AxeMon2 in 'AxeMon2.pas',
  uDTreeView in 'uDTreeView.pas',
  uDControls in 'uDControls.pas',
  uDCheckBox in 'uDCheckBox.pas',
  uDLabel in 'uDLabel.pas',
  uDPopupMenu in 'uDPopupMenu.pas',
  uDComboBox in 'uDComboBox.pas',
  FState1 in 'FState1.pas' {FrmDlg1},
  uDChatMemo in 'uDChatMemo.pas',
  Grobal2 in '..\Common\Grobal2.pas',
  Monpj in 'Monpj.pas';

{$R *.RES}

{var
   dwExStyle : DWORD;    }
begin
 // {$define EnableMemoryLeakReporting}
{******************************************************************************}
//Òþ²ØÈÎÎñÀ¸Í¼±ê 20080527
   {dwExStyle := GetWindowLong(Application.Handle, GWL_EXSTYLE);
   dwExStyle := dwExStyle + WS_EX_TOOLWINDOW;
   SetWindowLong(Application.Handle, GWL_EXSTYLE, dwExStyle);    }
{******************************************************************************}
  Application.Initialize;
  Application.MainFormOnTaskbar := False;
  Application.CreateForm(TSplashForm, SplashForm);
  Application.Run;
end.
