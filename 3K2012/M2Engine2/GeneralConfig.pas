unit GeneralConfig;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms,
  StdCtrls, ComCtrls, ExtCtrls, Grobal2;

type
  TfrmGeneralConfig = class(TForm)
    PageControl: TPageControl;
    ServerInfoSheet: TTabSheet;
    ShareSheet: TTabSheet;
    NetWorkSheet: TTabSheet;
    GroupBoxNet: TGroupBox;
    LabelGateIPaddr: TLabel;
    LabelGatePort: TLabel;
    EditGateAddr: TEdit;
    EditGatePort: TEdit;
    ButtonNetWorkSave: TButton;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    EditDBPort: TEdit;
    EditDBAddr: TEdit;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    EditIDSPort: TEdit;
    EditIDSAddr: TEdit;
    GroupBox3: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    EditLogServerPort: TEdit;
    EditLogServerAddr: TEdit;
    GroupBox4: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    EditMsgSrvPort: TEdit;
    EditMsgSrvAddr: TEdit;
    GroupBoxInfo: TGroupBox;
    Label1: TLabel;
    EditGameName: TEdit;
    EditServerIndex: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    EditServerNumber: TEdit;
    CheckBoxServiceMode: TCheckBox;
    GroupBox5: TGroupBox;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    EditTestLevel: TEdit;
    EditTestGold: TEdit;
    EditTestUserLimit: TEdit;
    CheckBoxTestServer: TCheckBox;
    ButtonServerInfoSave: TButton;
    GroupBox6: TGroupBox;
    Label15: TLabel;
    EditUserFull: TEdit;
    GroupBox7: TGroupBox;
    Label16: TLabel;
    EditDBName: TEdit;
    EditGuildDir: TEdit;
    Label17: TLabel;
    Label18: TLabel;
    EditGuildFile: TEdit;
    EditConLogDir: TEdit;
    EditCastleDir: TEdit;
    EditEnvirDir: TEdit;
    EditMapDir: TEdit;
    EditNoticeDir: TEdit;
    EditPlugDir: TEdit;
    Label24: TLabel;
    Label23: TLabel;
    Label22: TLabel;
    Label21: TLabel;
    Label20: TLabel;
    Label19: TLabel;
    EditVentureDir: TEdit;
    Label25: TLabel;
    ButtonShareDirSave: TButton;
    Label26: TLabel;
    TabSheet1: TTabSheet;
    GroupBox8: TGroupBox;
    ColorBoxHint: TColorBox;
    CheckBoxMinimize: TCheckBox;
    EditBoxsDir: TEdit;
    Label27: TLabel;
    Label28: TLabel;
    EditSortDir: TEdit;
    GroupBox9: TGroupBox;
    Label29: TLabel;
    EditSQLDatabase: TEdit;
    Label30: TLabel;
    EditSQLHost: TEdit;
    Label31: TLabel;
    EditSQLUserName: TEdit;
    Label32: TLabel;
    EditSQLPassword: TEdit;
    Label33: TLabel;
    EditDivisionDir: TEdit;
    Label34: TLabel;
    EditDivisionFile: TEdit;
    procedure ButtonNetWorkSaveClick(Sender: TObject);
    procedure EditValueChange(Sender: TObject);
    procedure PageControlChanging(Sender: TObject;
      var AllowChange: Boolean);
    procedure CheckBoxTestServerClick(Sender: TObject);
    procedure ButtonServerInfoSaveClick(Sender: TObject);
    procedure ButtonShareDirSaveClick(Sender: TObject);
    procedure ColorBoxHintChange(Sender: TObject);
    procedure CheckBoxMinimizeClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure EditSQLHostChange(Sender: TObject);
  private
    boOpened: Boolean;
    boModValued: Boolean;
    procedure ModValue();
    procedure uModValue();
    procedure RefDlgConf();
    { Private declarations }
  public
    procedure Open();
    { Public declarations }
  end;

var
  frmGeneralConfig: TfrmGeneralConfig;

implementation

uses HUtil32, M2Share{$IF DBTYPE = ADO}, EDcodeUnit{$IFEND};

{$R *.dfm}

procedure TfrmGeneralConfig.ModValue;
begin
  boModValued := True;
  ButtonNetWorkSave.Enabled := True;
  ButtonServerInfoSave.Enabled := True;
  ButtonShareDirSave.Enabled := True;
end;

procedure TfrmGeneralConfig.uModValue;
begin
  boModValued := False;
  ButtonNetWorkSave.Enabled := False;
  ButtonServerInfoSave.Enabled := False;
  ButtonShareDirSave.Enabled := False;
end;

procedure TfrmGeneralConfig.ButtonNetWorkSaveClick(Sender: TObject);
var
  Gateaddr, IDSAddr, DBAddr, LogServerAddr, MsgSrvAddr: string;
  GatePort, IDSPort, DBPort, LogServerPort, MsgSrvPort: Integer;
begin

  Gateaddr := Trim(EditGateAddr.Text);
  GatePort := Str_ToInt(Trim(EditGatePort.Text), -1);
  IDSAddr := Trim(EditIDSAddr.Text);
  IDSPort := Str_ToInt(Trim(EditIDSPort.Text), -1);
  DBAddr := Trim(EditDBAddr.Text);
  DBPort := Str_ToInt(Trim(EditDBPort.Text), -1);
  LogServerAddr := Trim(EditLogServerAddr.Text);
  LogServerPort := Str_ToInt(Trim(EditLogServerPort.Text), -1);

  MsgSrvAddr := Trim(EditMsgSrvAddr.Text);
  MsgSrvPort := Str_ToInt(Trim(EditMsgSrvPort.Text), -1);

  if not IsIPaddr(Gateaddr) then begin
    Application.MessageBox('网关地址设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditGateAddr.SetFocus;
    Exit;
  end;

  if (GatePort < 0) or (GatePort > 65535) then begin
    Application.MessageBox('网关端口设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditGatePort.SetFocus;
    Exit;
  end;

  if not IsIPaddr(IDSAddr) then begin
    Application.MessageBox('管理服务器地址设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditIDSAddr.SetFocus;
    Exit;
  end;

  if (IDSPort < 0) or (IDSPort > 65535) then begin
    Application.MessageBox('管理服务器端口设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditIDSPort.SetFocus;
    Exit;
  end;

  if not IsIPaddr(DBAddr) then begin
    Application.MessageBox('数据库服务器地址设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditDBAddr.SetFocus;
    Exit;
  end;

  if (DBPort < 0) or (DBPort > 65535) then begin
    Application.MessageBox('数据库服务器端口设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditDBPort.SetFocus;
    Exit;
  end;

  if not IsIPaddr(LogServerAddr) then begin
    Application.MessageBox('日志服务器地址设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditLogServerAddr.SetFocus;
    Exit;
  end;

  if (LogServerPort < 0) or (LogServerPort > 65535) then begin
    Application.MessageBox('日志服务器端口设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditLogServerPort.SetFocus;
    Exit;
  end;

  if not IsIPaddr(MsgSrvAddr) then begin
    Application.MessageBox('游戏主服务器地址设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditMsgSrvAddr.SetFocus;
    Exit;
  end;

  if (MsgSrvPort < 0) or (MsgSrvPort > 65535) then begin
    Application.MessageBox('游戏主服务器端口设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditMsgSrvPort.SetFocus;
    Exit;
  end;

  g_Config.sGateAddr := Gateaddr;
  g_Config.nGatePort := GatePort;
  g_Config.sIDSAddr := IDSAddr;
  g_Config.nIDSPort := IDSPort;
  g_Config.sDBAddr := DBAddr;
  g_Config.nDBPort := DBPort;
  g_Config.sLogServerAddr := LogServerAddr;
  g_Config.nLogServerPort := LogServerPort;
  g_Config.sMsgSrvAddr := MsgSrvAddr;
  g_Config.nMsgSrvPort := MsgSrvPort;

  Config.WriteString('Server', 'GateAddr', g_Config.sGateAddr);
  Config.WriteInteger('Server', 'GatePort', g_Config.nGatePort);
  Config.WriteString('Server', 'IDSAddr', g_Config.sIDSAddr);
  Config.WriteInteger('Server', 'IDSPort', g_Config.nIDSPort);
  Config.WriteString('Server', 'DBAddr', g_Config.sDBAddr);
  Config.WriteInteger('Server', 'DBPort', g_Config.nDBPort);
  Config.WriteString('Server', 'LogServerAddr', g_Config.sLogServerAddr);
  Config.WriteInteger('Server', 'LogServerPort', g_Config.nLogServerPort);
  Config.WriteString('Server', 'MsgSrvAddr', g_Config.sMsgSrvAddr);
  Config.WriteInteger('Server', 'MsgSrvPort', g_Config.nMsgSrvPort);
  uModValue();
end;

procedure TfrmGeneralConfig.Open;
begin
  boOpened := False;
  uModValue();
  EditGateAddr.Text := g_Config.sGateAddr;
  EditGatePort.Text := IntToStr(g_Config.nGatePort);
  EditIDSAddr.Text := g_Config.sIDSAddr;
  EditIDSPort.Text := IntToStr(g_Config.nIDSPort);
  EditDBAddr.Text := g_Config.sDBAddr;
  EditDBPort.Text := IntToStr(g_Config.nDBPort);
  EditLogServerAddr.Text := g_Config.sLogServerAddr;
  EditLogServerPort.Text := IntToStr(g_Config.nLogServerPort);
  EditMsgSrvAddr.Text:=  g_Config.sMsgSrvAddr;//20080331
  EditMsgSrvPort.Text:= IntToStr(g_Config.nMsgSrvPort);//20080331

  EditGameName.Text := g_Config.sServerName;
  EditServerIndex.Text := IntToStr(nServerIndex);
  EditServerNumber.Text := IntToStr(g_Config.nServerNumber);
  CheckBoxServiceMode.Checked := g_Config.boServiceMode;
  CheckBoxTestServer.Checked := g_Config.boTestServer;
  EditTestLevel.Text := IntToStr(g_Config.nTestLevel);
  EditTestGold.Text := IntToStr(g_Config.nTestGold);
  EditTestUserLimit.Text := IntToStr(g_Config.nTestUserLimit);
  EditUserFull.Text := IntToStr(g_Config.nUserFull);
  CheckBoxTestServerClick(Self);

{$IF DBTYPE = BDE}
  GroupBox9.Visible:= False;
  EditDBName.Text := sDBName;
{$ELSE}
  GroupBox7.Visible:= False;
  EditSQLDatabase.Text := g_sSQLDatabase;
  EditSQLHost.Text := g_sSQLHost;
  EditSQLUserName.Text := g_sSQLUserName;
  EditSQLPassword.Text := Base64DecodeStr(g_sSQLPassword);
{$IFEND}
{$IF M2Version <> 2}
  EditDivisionDir.Visible:= True;
  EditDivisionFile.Visible:= True;
  Label33.Visible:= True;
  Label34.Visible:= True;
  EditDivisionDir.Text := g_Config.sDivisionDir;
  EditDivisionFile.Text := g_Config.sDivisionFile;
{$IFEND}
  EditGuildDir.Text := g_Config.sGuildDir;
  EditGuildFile.Text := g_Config.sGuildFile;
  EditConLogDir.Text := g_Config.sConLogDir;
  EditCastleDir.Text := g_Config.sCastleDir;
  EditBoxsDir.Text := g_Config.sBoxsDir;//宝箱目录 20080114
  EditSortDir.Text := g_Config.sSortDir;//排行文件目录 20080531
  EditEnvirDir.Text := g_Config.sEnvirDir;
  EditMapDir.Text := g_Config.sMapDir;
  EditNoticeDir.Text := g_Config.sNoticeDir;
  EditPlugDir.Text := g_Config.sPlugDir;
  EditVentureDir.Text := g_Config.sVentureDir;
  CheckBoxMinimize.Checked := g_boMinimize;

  RefDlgConf();

  boOpened := True;
  PageControl.ActivePageIndex := 0;
  ShowModal;
end;

procedure TfrmGeneralConfig.EditSQLHostChange(Sender: TObject);
begin
  if not boOpened then Exit;
  ModValue();
end;

procedure TfrmGeneralConfig.EditValueChange(Sender: TObject);
begin
  if not boOpened then Exit;
  ModValue();
end;

procedure TfrmGeneralConfig.PageControlChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  if boModValued then begin
    if Application.MessageBox('参数设置已经被修改，是否确认不保存修改的设置？', '确认信息', MB_YESNO + MB_ICONQUESTION) = IDYES then begin
      uModValue
    end else AllowChange := False;
  end;
end;

procedure TfrmGeneralConfig.CheckBoxTestServerClick(Sender: TObject);
var
  boStatue: Boolean;
begin
  boStatue := CheckBoxTestServer.Checked;
  EditTestLevel.Enabled := boStatue;
  EditTestGold.Enabled := boStatue;
  EditTestUserLimit.Enabled := boStatue;
  EditValueChange(Sender);
end;

procedure TfrmGeneralConfig.ButtonServerInfoSaveClick(Sender: TObject);
var
  GameName{$IF DBTYPE = BDE}, DBName{$ELSE}, SQLDatabase, SQLHost, SQLUserName, SQLPassword{$IFEND}: string;
  ServerIndex, ServerNumber, TestLevel, TestGold, TestUserLimit, UserFull: Integer;
  TestServer, ServiceMode: Boolean;
begin
  GameName := Trim(EditGameName.Text);
  ServerIndex := Str_ToInt(Trim(EditServerIndex.Text), -1);
  ServerNumber := Str_ToInt(Trim(EditServerNumber.Text), -1);
  ServiceMode := CheckBoxServiceMode.Checked;
  TestServer := CheckBoxTestServer.Checked;
  TestLevel := Str_ToInt(Trim(EditTestLevel.Text), -1);
  TestGold := Str_ToInt(Trim(EditTestGold.Text), -1);
  TestUserLimit := Str_ToInt(Trim(EditTestUserLimit.Text), -1);
  UserFull := Str_ToInt(Trim(EditUserFull.Text), -1);
{$IF DBTYPE = BDE}
  DBName := Trim(EditDBName.Text);
{$ELSE}
  SQLHost := Trim(EditSQLHost.Text);
  SQLDatabase := Trim(EditSQLDatabase.Text);
  SQLUserName := Trim(EditSQLUserName.Text);
  SQLPassword := Base64EncodeStr(Trim(EditSQLPassword.Text));
{$IFEND}
  if GameName = '' then begin
    Application.MessageBox('游戏名称设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditGameName.SetFocus;
    Exit;
  end;

  if (ServerIndex < 0) or (ServerIndex > 255) then begin
    Application.MessageBox('服务器号设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditServerIndex.SetFocus;
    Exit;
  end;

  if (ServerNumber < 0) or (ServerNumber > 255) then begin
    Application.MessageBox('服务器数设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditServerNumber.SetFocus;
    Exit;
  end;
  if (TestLevel < 0) or (TestLevel > 65535) then begin
    Application.MessageBox('开始等级设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditTestLevel.SetFocus;
    Exit;
  end;
  if (TestGold < 0) or (TestGold > High(Integer) div 2) then begin
    Application.MessageBox('开始金币设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditTestGold.SetFocus;
    Exit;
  end;

  if (TestUserLimit < 0) or (TestUserLimit > 10000) then begin
    Application.MessageBox('测试人数设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditTestUserLimit.SetFocus;
    Exit;
  end;

  if (UserFull < 0) or (UserFull > 10000) then begin
    Application.MessageBox('上限人数设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditUserFull.SetFocus;
    Exit;
  end;
{$IF DBTYPE = BDE}
  if DBName = '' then begin
    Application.MessageBox('数据库名称设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditDBName.SetFocus;
    Exit;
  end;
{$ELSE}
  if SQLHost = '' then begin
    Application.MessageBox('服务器名设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditSQLHost.SetFocus;
    Exit;
  end;

  if SQLDatabase = '' then begin
    Application.MessageBox('数据库名设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditSQLDatabase.SetFocus;
    Exit;
  end;

  if SQLUserName = '' then begin
    Application.MessageBox('用户名设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditSQLUserName.SetFocus;
    Exit;
  end;
{$IFEND}
  g_Config.sServerName := GameName;
  //nServerIndex:=ServerIndex;
  g_Config.nServerNumber := ServerNumber;
  g_Config.boServiceMode := ServiceMode;
  g_Config.boTestServer := TestServer;
  g_Config.nTestLevel := TestLevel;
  g_Config.nTestGold := TestGold;
  g_Config.nTestUserLimit := TestUserLimit;
  g_Config.nUserFull := UserFull;
{$IF DBTYPE = BDE}
  sDBName := DBName;
{$ELSE}
  g_sSQLDatabase:= SQLDatabase;
  g_sSQLHost:= SQLHost;
  g_sSQLUserName:= SQLUserName;
  g_sSQLPassword:= SQLPassword;
{$IFEND}
  Config.WriteString('Server', 'ServerName', g_Config.sServerName);
  Config.WriteInteger('Server', 'ServerIndex', nServerIndex);
  Config.WriteInteger('Server', 'ServerNumber', g_Config.nServerNumber);
  Config.WriteString('Server', 'TestServer', BoolToStr(g_Config.boTestServer));
  Config.WriteInteger('Server', 'TestLevel', g_Config.nTestLevel);
  Config.WriteInteger('Server', 'TestGold', g_Config.nTestGold);
  Config.WriteInteger('Server', 'TestServerUserLimit', g_Config.nTestUserLimit);
  Config.WriteInteger('Server', 'UserFull', g_Config.nUserFull);
{$IF DBTYPE = ADO}
  Config.WriteString('Server', 'SQLDatabase', g_sSQLDatabase);
  Config.WriteString('Server', 'SQLHost', g_sSQLHost);
  Config.WriteString('Server', 'SQLUserName', g_sSQLUserName);
  Config.WriteString('Server', 'SQLPassword', g_sSQLPassword);
{$ELSE}
  Config.WriteString('Server', 'DBName', sDBName);
{$IFEND}
  Config.WriteBool('Server', 'Minimize', g_boMinimize);
  uModValue();
end;

procedure TfrmGeneralConfig.ButtonShareDirSaveClick(Sender: TObject);
var
  GuildDir, GuildFile, VentureDir, ConLogDir, CastleDir,BoxsDir, EnvirDir, MapDir,
  NoticeDir, PlugDir, SortDir, DivisionDir, DivisionFile: string;
begin
  {$IF M2Version <> 2}
  DivisionDir := Trim(EditDivisionDir.Text);
  DivisionFile := Trim(EditDivisionFile.Text);
  if not DirectoryExists(DivisionDir) or (DivisionDir[Length(DivisionDir)] <> '\') then begin
    Application.MessageBox('师门目录设置错误，目录不存在！', '错误信息', MB_OK + MB_ICONERROR);
    EditDivisionDir.SetFocus;
    Exit;
  end;
  if not FileExists(DivisionFile) then begin
    Application.MessageBox('师门文件设置错误,文件不存在！', '错误信息', MB_OK + MB_ICONERROR);
    EditDivisionFile.SetFocus;
    Exit;
  end;
  {$IFEND}
  GuildDir := Trim(EditGuildDir.Text);
  GuildFile := Trim(EditGuildFile.Text);
  VentureDir := Trim(EditVentureDir.Text);
  ConLogDir := Trim(EditConLogDir.Text);
  CastleDir := Trim(EditCastleDir.Text);
  BoxsDir:= Trim(EditBoxsDir.Text);//宝箱目录 20080114
  SortDir:= Trim(EditSortDir.Text);//排行榜文件目录 20080531
  EnvirDir := Trim(EditEnvirDir.Text);
  MapDir := Trim(EditMapDir.Text);
  NoticeDir := Trim(EditNoticeDir.Text);
  PlugDir := Trim(EditPlugDir.Text);

  if not DirectoryExists(GuildDir) or (GuildDir[Length(GuildDir)] <> '\') then begin
    Application.MessageBox('行会目录设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditGuildDir.SetFocus;
    Exit;
  end;
  if not FileExists(GuildFile) then begin
    Application.MessageBox('行会文件设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditGuildFile.SetFocus;
    Exit;
  end;
  if not DirectoryExists(VentureDir) or (VentureDir[Length(VentureDir)] <> '\') then begin
    Application.MessageBox('Venture目录设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditVentureDir.SetFocus;
    Exit;
  end;
  if not DirectoryExists(ConLogDir) or (ConLogDir[Length(ConLogDir)] <> '\') then begin
    Application.MessageBox('登录日志目录设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditConLogDir.SetFocus;
    Exit;
  end;
  if not DirectoryExists(CastleDir) or (CastleDir[Length(CastleDir)] <> '\') then begin
    Application.MessageBox('城堡目录设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditCastleDir.SetFocus;
    Exit;
  end;
  if not DirectoryExists(EnvirDir) or (EnvirDir[Length(EnvirDir)] <> '\') then begin
    Application.MessageBox('配置目录设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditEnvirDir.SetFocus;
    Exit;
  end;
  if not DirectoryExists(MapDir) or (MapDir[Length(MapDir)] <> '\') then begin
    Application.MessageBox('地图目录设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditMapDir.SetFocus;
    Exit;
  end;
  if not DirectoryExists(NoticeDir) or (NoticeDir[Length(NoticeDir)] <> '\') then begin
    Application.MessageBox('公告目录设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditNoticeDir.SetFocus;
    Exit;
  end;
  if not DirectoryExists(PlugDir) or (PlugDir[Length(PlugDir)] <> '\') then begin
    Application.MessageBox('插件目录设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditPlugDir.SetFocus;
    Exit;
  end;
  if not DirectoryExists(BoxsDir) or (BoxsDir[Length(BoxsDir)] <> '\') then begin
    Application.MessageBox('宝箱目录设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditBoxsDir.SetFocus;
    Exit;
  end;
  if not DirectoryExists(SortDir) or (SortDir[Length(SortDir)] <> '\') then begin
    Application.MessageBox('排行榜目录设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditSortDir.SetFocus;
    Exit;
  end;

  g_Config.sGuildDir := GuildDir;
  g_Config.sGuildFile := GuildFile;
  g_Config.sVentureDir := VentureDir;
  g_Config.sConLogDir := ConLogDir;
  g_Config.sCastleDir := CastleDir;
  g_Config.sBoxsDir := BoxsDir;//宝箱目录 20080114
  g_Config.sSortDir := SortDir;//排行文件目录 20080531
  g_Config.sEnvirDir := EnvirDir;
  g_Config.sMapDir := MapDir;
  g_Config.sNoticeDir := NoticeDir;
  g_Config.sPlugDir := PlugDir;
  {$IF M2Version <> 2}
  g_Config.sDivisionDir := DivisionDir;
  g_Config.sDivisionFile := DivisionFile;
  Config.WriteString('Share', 'DivisionDir', g_Config.sDivisionDir);
  Config.WriteString('Share', 'DivisionFile', g_Config.sDivisionFile);
  {$IFEND}
  Config.WriteString('Share', 'GuildDir', g_Config.sGuildDir);
  Config.WriteString('Share', 'GuildFile', g_Config.sGuildFile);
  Config.WriteString('Share', 'VentureDir', g_Config.sVentureDir);
  Config.WriteString('Share', 'ConLogDir', g_Config.sConLogDir);
  Config.WriteString('Share', 'CastleDir', g_Config.sCastleDir);
  Config.WriteString('Share', 'BoxsDir', g_Config.sBoxsDir);//宝箱目录 20080114
  Config.WriteString('Share', 'SortDir', g_Config.sSortDir);//排行榜文件目录 20080114
  Config.WriteString('Share', 'EnvirDir', g_Config.sEnvirDir);
  Config.WriteString('Share', 'MapDir', g_Config.sMapDir);
  Config.WriteString('Share', 'NoticeDir', g_Config.sNoticeDir);
  Config.WriteString('Share', 'PlugDir', g_Config.sPlugDir);
  uModValue();
end;


procedure TfrmGeneralConfig.RefDlgConf;
begin
  ColorBoxHint.Selected := Application.HintColor;
end;
procedure TfrmGeneralConfig.ColorBoxHintChange(Sender: TObject);
begin
  Application.HintColor := ColorBoxHint.Selected;
end;

procedure TfrmGeneralConfig.CheckBoxMinimizeClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_boMinimize := CheckBoxMinimize.Checked;//20080702
  ModValue();
end;

procedure TfrmGeneralConfig.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmGeneralConfig.FormDestroy(Sender: TObject);
begin
  frmGeneralConfig:= nil;
end;

end.
