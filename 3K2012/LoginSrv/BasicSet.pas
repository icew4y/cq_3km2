unit BasicSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Spin;

type
  TFrmBasicSet = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    CheckBoxTestServer: TCheckBox;
    CheckBoxEnableMakingID: TCheckBox;
    CheckBoxEnableGetbackPassword: TCheckBox;
    CheckBoxAutoClear: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    ButtonSave: TButton;
    ButtonClose: TButton;
    SpinEditAutoClearTime: TSpinEdit;
    ButtonRestoreBasic: TButton;
    ButtonRestoreNet: TButton;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    CheckBoxDynamicIPMode: TCheckBox;
    Label3: TLabel;
    Label4: TLabel;
    EditGateAddr: TEdit;
    EditGatePort: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    EditMonAddr: TEdit;
    EditMonPort: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    EditServerAddr: TEdit;
    EditServerPort: TEdit;
    GroupBox7: TGroupBox;
    CheckBoxAutoUnLockAccount: TCheckBox;
    Label10: TLabel;
    SpinEditUnLockAccountTime: TSpinEdit;
    CheckBoxMinimize: TCheckBox;
    GroupBox8: TGroupBox;
    Label12: TLabel;
    CheckBoxRandomCode: TCheckBox;
    GroupBox9: TGroupBox;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    EditSQLHost: TEdit;
    EditSQLDatabase: TEdit;
    EditSQLUsername: TEdit;
    EditSQLPassword: TEdit;
    Label11: TLabel;
    CanSameAcctAndPsd: TCheckBox;
    SpinEditClearKickSessionTime: TSpinEdit;
    Label9: TLabel;
    Label17: TLabel;
    CheckBoxEnabledTestSelGate: TCheckBox;
    procedure CheckBoxTestServerClick(Sender: TObject);
    procedure CheckBoxEnableMakingIDClick(Sender: TObject);
    procedure CheckBoxEnableGetbackPasswordClick(Sender: TObject);
    procedure CheckBoxAutoClearClick(Sender: TObject);
    procedure SpinEditAutoClearTimeChange(Sender: TObject);
    procedure CheckBoxAutoUnLockAccountClick(Sender: TObject);
    procedure SpinEditUnLockAccountTimeChange(Sender: TObject);
    procedure ButtonRestoreBasicClick(Sender: TObject);
    procedure EditGateAddrChange(Sender: TObject);
    procedure EditGatePortChange(Sender: TObject);
    procedure EditMonAddrChange(Sender: TObject);
    procedure EditMonPortChange(Sender: TObject);
    procedure EditServerAddrChange(Sender: TObject);
    procedure EditServerPortChange(Sender: TObject);
    procedure CheckBoxDynamicIPModeClick(Sender: TObject);
    procedure ButtonRestoreNetClick(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure ButtonCloseClick(Sender: TObject);
    procedure CheckBoxMinimizeClick(Sender: TObject);
    procedure CheckBoxRandomCodeClick(Sender: TObject);
    procedure EditSQLHostChange(Sender: TObject);
    procedure EditSQLDatabaseChange(Sender: TObject);
    procedure EditSQLUsernameChange(Sender: TObject);
    procedure EditSQLPasswordChange(Sender: TObject);
    procedure CanSameAcctAndPsdClick(Sender: TObject);
    procedure SpinEditClearKickSessionTimeChange(Sender: TObject);
    procedure CheckBoxEnabledTestSelGateClick(Sender: TObject);
  private
    { Private declarations }
    procedure LockSaveButtonEnabled();
    procedure UnLockSaveButtonEnabled();
  public
    { Public declarations }
    procedure OpenBasicSet();
  end;

var
  FrmBasicSet: TFrmBasicSet;

implementation
uses HUtil32, LSShare{$IF IDMODE = 1}, EDcodeUnit{$IFEND};
var
  Config: pTConfig;
{$R *.dfm}
procedure TFrmBasicSet.LockSaveButtonEnabled();
begin
  ButtonSave.Enabled := False;
end;

procedure TFrmBasicSet.UnLockSaveButtonEnabled();
begin
  ButtonSave.Enabled := True;
end;

procedure TFrmBasicSet.OpenBasicSet();
begin
  Config := @g_Config;
  CheckBoxTestServer.Checked := Config.boTestServer;
  CheckBoxEnableMakingID.Checked := Config.boEnableMakingID;
  CanSameAcctAndPsd.Checked:=Config.boCanSameAcctAndPsd;
  CheckBoxEnableGetbackPassword.Checked := Config.boEnableGetbackPassword;
  CheckBoxAutoClear.Checked := Config.boAutoClearID;
  SpinEditAutoClearTime.Value := Config.dwAutoClearTime;
  CheckBoxEnabledTestSelGate.Checked := Config.boEnabledTestSelGate;
  CheckBoxAutoUnLockAccount.Checked := Config.boUnLockAccount;
  SpinEditUnLockAccountTime.Value := Config.dwUnLockAccountTime;
  SpinEditClearKickSessionTime.Value := Config.dwClearKickSessionTime;
  EditGateAddr.Text := Config.sGateAddr;
  EditGatePort.Text := IntToStr(Config.nGatePort);

  EditServerAddr.Text := Config.sServerAddr;
  EditServerPort.Text := IntToStr(Config.nServerPort);

  EditMonAddr.Text := Config.sMonAddr;
  EditMonPort.Text := IntToStr(Config.nMonPort);
{$IF IDMODE = 1}
  TabSheet3.Caption:='数据库设置';
  EditSQLHost.Text := Config.g_sSQLHost;
  EditSQLDatabase.Text := Config.g_sSQLDatabase;
  EditSQLUsername.Text := Config.g_sSQLUserName;
  EditSQLPassword.Text := Base64DecodeStr(Config.g_sSQLPassword);
{$ELSE}
  EditSQLHost.Visible:= False;
  EditSQLDatabase.Visible:= False;
  EditSQLUsername.Visible:= False;
  EditSQLPassword.Visible:= False;
  Label11.Visible:= False;
{$IFEND}
  CheckBoxDynamicIPMode.Checked := Config.boDynamicIPMode;
  CheckBoxMinimize.Checked := Config.boMinimize;
 // CheckBoxRandomCode.Checked := Config.boRandomCode;   //20080614 去掉验证码功能
  LockSaveButtonEnabled();
  ShowModal;
end;

procedure TFrmBasicSet.CheckBoxTestServerClick(Sender: TObject);
begin
  Config := @g_Config;
  Config.boTestServer := CheckBoxTestServer.Checked;
  UnLockSaveButtonEnabled();
end;

procedure TFrmBasicSet.CheckBoxEnableMakingIDClick(Sender: TObject);
begin
  Config := @g_Config;
  Config.boEnableMakingID := CheckBoxEnableMakingID.Checked;
  UnLockSaveButtonEnabled();
end;

procedure TFrmBasicSet.CheckBoxEnabledTestSelGateClick(Sender: TObject);
begin
  Config := @g_Config;
  Config.boEnabledTestSelGate := CheckBoxEnabledTestSelGate.Checked;
  UnLockSaveButtonEnabled();
end;

procedure TFrmBasicSet.CheckBoxEnableGetbackPasswordClick(Sender: TObject);
begin
  Config := @g_Config;
  Config.boEnableGetbackPassword := CheckBoxEnableGetbackPassword.Checked;
  UnLockSaveButtonEnabled();
end;

procedure TFrmBasicSet.CanSameAcctAndPsdClick(Sender: TObject);
begin
  Config := @g_Config;
  Config.boCanSameAcctAndPsd := CanSameAcctAndPsd.Checked;
  UnLockSaveButtonEnabled();
end;

procedure TFrmBasicSet.CheckBoxAutoClearClick(Sender: TObject);
begin
  Config := @g_Config;
  Config.boAutoClearID := CheckBoxAutoClear.Checked;
  UnLockSaveButtonEnabled();
end;

procedure TFrmBasicSet.SpinEditAutoClearTimeChange(Sender: TObject);
begin
  Config := @g_Config;
  Config.dwAutoClearTime := SpinEditAutoClearTime.Value;
  UnLockSaveButtonEnabled();
end;

procedure TFrmBasicSet.SpinEditClearKickSessionTimeChange(Sender: TObject);
begin
  Config := @g_Config;
  Config.dwClearKickSessionTime := SpinEditClearKickSessionTime.Value;
  UnLockSaveButtonEnabled();
end;

procedure TFrmBasicSet.CheckBoxAutoUnLockAccountClick(Sender: TObject);
begin
  Config := @g_Config;
  Config.boUnLockAccount := CheckBoxAutoUnLockAccount.Checked;
  SpinEditUnLockAccountTime.Enabled := Config.boUnLockAccount;
  Label10.Enabled := Config.boUnLockAccount;
  UnLockSaveButtonEnabled();
end;

procedure TFrmBasicSet.SpinEditUnLockAccountTimeChange(Sender: TObject);
begin
  Config := @g_Config;
  Config.dwUnLockAccountTime := SpinEditUnLockAccountTime.Value;
  UnLockSaveButtonEnabled();
end;

procedure TFrmBasicSet.ButtonRestoreBasicClick(Sender: TObject);
begin
  Config := @g_Config;
  CheckBoxTestServer.Checked := True;
  CheckBoxEnableMakingID.Checked := True;
  CheckBoxEnableGetbackPassword.Checked := True;
  CheckBoxAutoClear.Checked := True;
  SpinEditAutoClearTime.Value := 1;
  CheckBoxAutoUnLockAccount.Checked := False;
  SpinEditUnLockAccountTime.Value := 10;
end;

procedure TFrmBasicSet.EditGateAddrChange(Sender: TObject);
begin
  Config := @g_Config;
  Config.sGateAddr := Trim(EditGateAddr.Text);
  UnLockSaveButtonEnabled();
end;

procedure TFrmBasicSet.EditGatePortChange(Sender: TObject);
begin
  Config := @g_Config;
  Config.nGatePort := Str_ToInt(Trim(EditGatePort.Text), 5500);
  UnLockSaveButtonEnabled();
end;

procedure TFrmBasicSet.EditMonAddrChange(Sender: TObject);
begin
  Config := @g_Config;
  Config.sMonAddr := Trim(EditMonAddr.Text);
  UnLockSaveButtonEnabled();
end;

procedure TFrmBasicSet.EditMonPortChange(Sender: TObject);
begin
  Config := @g_Config;
  Config.nMonPort := Str_ToInt(Trim(EditMonPort.Text), 3000);
  UnLockSaveButtonEnabled();
end;

procedure TFrmBasicSet.EditServerAddrChange(Sender: TObject);
begin
  Config := @g_Config;
  Config.sServerAddr := Trim(EditServerAddr.Text);
  UnLockSaveButtonEnabled();
end;

procedure TFrmBasicSet.EditServerPortChange(Sender: TObject);
begin
  Config := @g_Config;
  Config.nServerPort := Str_ToInt(Trim(EditServerPort.Text), 5600);
  UnLockSaveButtonEnabled();
end;

procedure TFrmBasicSet.CheckBoxDynamicIPModeClick(Sender: TObject);
begin
  Config := @g_Config;
  Config.boDynamicIPMode := CheckBoxDynamicIPMode.Checked;
  UnLockSaveButtonEnabled();
end;

procedure TFrmBasicSet.ButtonRestoreNetClick(Sender: TObject);
begin
  EditGateAddr.Text := '0.0.0.0';
  EditGatePort.Text := '5500';
  EditServerAddr.Text := '0.0.0.0';
  EditServerPort.Text := '5600';
  EditMonAddr.Text := '0.0.0.0';
  EditMonPort.Text := '3000';
  CheckBoxDynamicIPMode.Checked := False;
end;

procedure WriteConfig(Config: pTConfig);
  procedure WriteConfigString(sSection, sIdent, sDefault: string);
  begin
    Config.IniConf.WriteString(sSection, sIdent, sDefault);
  end;
  procedure WriteConfigInteger(sSection, sIdent: string; nDefault: Integer);
  begin
    Config.IniConf.WriteInteger(sSection, sIdent, nDefault);
  end;
  procedure WriteConfigBoolean(sSection, sIdent: string; boDefault: Boolean);
  begin
    Config.IniConf.WriteBool(sSection, sIdent, boDefault);
  end;

resourcestring
  sSectionServer = 'Server';
  sSectionDB = 'DB';
  sIdentDBServer = 'DBServer';
  sIdentFeeServer = 'FeeServer';
  sIdentLogServer = 'LogServer';
  sIdentGateAddr = 'GateAddr';
  sIdentGatePort = 'GatePort';
  sIdentServerAddr = 'ServerAddr';
  sIdentServerPort = 'ServerPort';
  sIdentMonAddr = 'MonAddr';
  sIdentMonPort = 'MonPort';
  sIdentDBSPort = 'DBSPort';
  sIdentFeePort = 'FeePort';
  sIdentLogPort = 'LogPort';
  sIdentReadyServers = 'ReadyServers';
  sIdentTestServer = 'TestServer';
  sIdentDynamicIPMode = 'DynamicIPMode';
  sClearKickSessionTime = 'ClearKickSessionTime';
{$IF IDMODE = 1}
  sSectionSQL = 'SQL';
  sIdentSQLHost = 'SQLHost';
  sIdentSQLDatabase = 'SQLDatabase';
  sIdentSQLUsername = 'SQLUsername';
  sIdentSQLPassword = 'SQLPassword';
{$ELSE}
  sIdentIdDir = 'IdDir';
  sIdentWebLogDir = 'WebLogDir';
{$IFEND}
  sIdentCountLogDir = 'CountLogDir';
  sIdentFeedIDList = 'FeedIDList';
  sIdentFeedIPList = 'FeedIPList';

  sIdentEnableMakingID ='EnableMakingID';
  sCanSameAcctAndPsd='CanSameAcctAndPsd';
  sIdentEnableGetbackPassword = 'GetbackPassword';
  sIdentAutoClearID = 'AutoClearID';
  sIdentAutoClearTime = 'AutoClearTime';
  sIdentUnLockAccount = 'UnLockAccount';
  sIdentUnLockAccountTime = 'UnLockAccountTime';
  sIdentMinimize = 'Minimize';
  //sIdentRandomCode = 'RandomCode';  //20080614 去掉验证码功能
begin
  WriteConfigString(sSectionServer, sIdentDBServer, Config.sDBServer);
  WriteConfigString(sSectionServer, sIdentFeeServer, Config.sFeeServer);
  WriteConfigString(sSectionServer, sIdentLogServer, Config.sLogServer);

  WriteConfigString(sSectionServer, sIdentGateAddr, Config.sGateAddr);
  WriteConfigInteger(sSectionServer, sIdentGatePort, Config.nGatePort);
  WriteConfigString(sSectionServer, sIdentServerAddr, Config.sServerAddr);
  WriteConfigInteger(sSectionServer, sIdentServerPort, Config.nServerPort);
  WriteConfigString(sSectionServer, sIdentMonAddr, Config.sMonAddr);
  WriteConfigInteger(sSectionServer, sIdentMonPort, Config.nMonPort);

  WriteConfigInteger(sSectionServer, sIdentDBSPort, Config.nDBSPort);
  WriteConfigInteger(sSectionServer, sIdentFeePort, Config.nFeePort);
  WriteConfigInteger(sSectionServer, sIdentLogPort, Config.nLogPort);
  WriteConfigInteger(sSectionServer, sIdentReadyServers, Config.nReadyServers);
  WriteConfigBoolean(sSectionServer, sIdentTestServer, Config.boTestServer);

  WriteConfigBoolean(sSectionServer, sIdentEnableMakingID, Config.boEnableMakingID); //boCanSameAcctAndPsd
  WriteConfigBoolean(sSectionServer, sCanSameAcctAndPsd, Config.boCanSameAcctAndPsd);
  WriteConfigBoolean(sSectionServer, sIdentEnableGetbackPassword, Config.boEnableGetbackPassword);
  WriteConfigBoolean(sSectionServer, sIdentAutoClearID, Config.boAutoClearID);
  WriteConfigInteger(sSectionServer, sIdentAutoClearTime, Config.dwAutoClearTime);
  WriteConfigBoolean(sSectionServer, sIdentUnLockAccount, Config.boUnLockAccount);
  WriteConfigInteger(sSectionServer, sIdentUnLockAccountTime, Config.dwUnLockAccountTime);
  WriteConfigInteger(sSectionServer, sClearKickSessionTime, Config.dwClearKickSessionTime);
  WriteConfigBoolean(sSectionServer, sIdentDynamicIPMode, Config.boDynamicIPMode);
  WriteConfigBoolean(sSectionServer, sIdentMinimize, Config.boMinimize);
 // WriteConfigBoolean(sSectionServer, sIdentRandomCode, Config.boRandomCode); //20080614 去掉验证码功能
{$IF IDMODE = 1}
  WriteConfigString(sSectionSQL,sIdentSQLHost, Config.g_sSQLHost);
  WriteConfigString(sSectionSQL,sIdentSQLDatabase, Config.g_sSQLDatabase);
  WriteConfigString(sSectionSQL,sIdentSQLUsername, Config.g_sSQLUserName);
  WriteConfigString(sSectionSQL,sIdentSQLPassword, Config.g_sSQLPassword);
{$ELSE}
  WriteConfigString(sSectionDB, sIdentIdDir, Config.sIdDir);
  WriteConfigString(sSectionDB, sIdentWebLogDir, Config.sWebLogDir);
{$IFEND}
  WriteConfigString(sSectionDB, sIdentCountLogDir, Config.sCountLogDir);
  WriteConfigString(sSectionDB, sIdentFeedIDList, Config.sFeedIDList);
  WriteConfigString(sSectionDB, sIdentFeedIPList, Config.sFeedIPList);
end;

procedure TFrmBasicSet.ButtonSaveClick(Sender: TObject);
begin
  WriteConfig(Config);
  LockSaveButtonEnabled();
end;

procedure TFrmBasicSet.ButtonCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmBasicSet.CheckBoxMinimizeClick(Sender: TObject);
begin
  Config := @g_Config;
  Config.boMinimize := CheckBoxMinimize.Checked;
  UnLockSaveButtonEnabled();
end;

procedure TFrmBasicSet.CheckBoxRandomCodeClick(Sender: TObject);
begin
  {Config := @g_Config;      //20080614 去掉验证码功能
  Config.boRandomCode := CheckBoxRandomCode.Checked;
  UnLockSaveButtonEnabled();   }
end;

procedure TFrmBasicSet.EditSQLHostChange(Sender: TObject);
begin
{$IF IDMODE = 1}
  Config := @g_Config;
  Config.g_sSQLHost := Trim(EditSQLHost.Text);
  UnLockSaveButtonEnabled();
{$IFEND}  
end;

procedure TFrmBasicSet.EditSQLDatabaseChange(Sender: TObject);
begin
{$IF IDMODE = 1}
  Config := @g_Config;
  Config.g_sSQLDatabase := Trim(EditSQLDatabase.Text);
  UnLockSaveButtonEnabled();
{$IFEND}
end;

procedure TFrmBasicSet.EditSQLUsernameChange(Sender: TObject);
begin
{$IF IDMODE = 1}
  Config := @g_Config;
  Config.g_sSQLUserName := Trim(EditSQLUsername.Text);
  UnLockSaveButtonEnabled();
{$IFEND}
end;

procedure TFrmBasicSet.EditSQLPasswordChange(Sender: TObject);
begin
{$IF IDMODE = 1}
  Config := @g_Config;
  Config.g_sSQLPassword := Base64EncodeStr(Trim(EditSQLPassword.Text));
  UnLockSaveButtonEnabled();
{$IFEND}
end;

end.

