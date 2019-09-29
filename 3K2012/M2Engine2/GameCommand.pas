unit GameCommand;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms,
  Grids, ComCtrls, StdCtrls, Spin, Grobal2;

type
  TfrmGameCmd = class(TForm)
    PageControl: TPageControl;
    TabSheet1: TTabSheet;
    StringGridGameCmd: TStringGrid;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    EditUserCmdName: TEdit;
    EditUserCmdPerMission: TSpinEdit;
    Label6: TLabel;
    EditUserCmdOK: TButton;
    LabelUserCmdFunc: TLabel;
    LabelUserCmdParam: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    EditUserCmdSave: TButton;
    StringGridGameMasterCmd: TStringGrid;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    LabelGameMasterCmdFunc: TLabel;
    LabelGameMasterCmdParam: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    EditGameMasterCmdName: TEdit;
    EditGameMasterCmdPerMission: TSpinEdit;
    EditGameMasterCmdOK: TButton;
    EditGameMasterCmdSave: TButton;
    StringGridGameDebugCmd: TStringGrid;
    GroupBox3: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    LabelGameDebugCmdFunc: TLabel;
    LabelGameDebugCmdParam: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    EditGameDebugCmdName: TEdit;
    EditGameDebugCmdPerMission: TSpinEdit;
    EditGameDebugCmdOK: TButton;
    EditGameDebugCmdSave: TButton;
    procedure FormCreate(Sender: TObject);
    procedure StringGridGameCmdClick(Sender: TObject);
    procedure EditUserCmdNameChange(Sender: TObject);
    procedure EditUserCmdPerMissionChange(Sender: TObject);
    procedure EditUserCmdOKClick(Sender: TObject);
    procedure EditUserCmdSaveClick(Sender: TObject);
    procedure StringGridGameMasterCmdClick(Sender: TObject);
    procedure EditGameMasterCmdNameChange(Sender: TObject);
    procedure EditGameMasterCmdPerMissionChange(Sender: TObject);
    procedure EditGameMasterCmdOKClick(Sender: TObject);
    procedure StringGridGameDebugCmdClick(Sender: TObject);
    procedure EditGameDebugCmdNameChange(Sender: TObject);
    procedure EditGameDebugCmdPerMissionChange(Sender: TObject);
    procedure EditGameDebugCmdOKClick(Sender: TObject);
    procedure EditGameMasterCmdSaveClick(Sender: TObject);
    procedure EditGameDebugCmdSaveClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    nRefGameUserIndex: Integer;
    nRefGameMasterIndex: Integer;
    nRefGameDebugIndex: Integer;
    procedure RefUserCommand();
    procedure RefGameMasterCommand();
    procedure RefGameMasterCmd(GameCmd: pTGameCmd; sCmdParam, sDesc: string);
    procedure RefDebugCommand();
    procedure RefGameDebugCmd(GameCmd: pTGameCmd; sCmdParam,
      sDesc: string);
    procedure RefGameUserCmd(GameCmd: pTGameCmd; sCmdParam, sDesc: string);
    { Private declarations }
  public
    procedure Open();
    { Public declarations }
  end;

var
  frmGameCmd: TfrmGameCmd;

implementation

uses M2Share;

{$R *.dfm}


procedure TfrmGameCmd.FormCreate(Sender: TObject);
begin
  PageControl.ActivePageIndex := 0;
  StringGridGameCmd.RowCount := 50;
  StringGridGameCmd.Cells[0, 0] := '游戏命令';
  StringGridGameCmd.Cells[1, 0] := '所需权限';
  StringGridGameCmd.Cells[2, 0] := '命令格式';
  StringGridGameCmd.Cells[3, 0] := '命令说明';

  StringGridGameMasterCmd.RowCount := 105;
  StringGridGameMasterCmd.Cells[0, 0] := '游戏命令';
  StringGridGameMasterCmd.Cells[1, 0] := '所需权限';
  StringGridGameMasterCmd.Cells[2, 0] := '命令格式';
  StringGridGameMasterCmd.Cells[3, 0] := '命令说明';

  StringGridGameDebugCmd.RowCount := 41;
  StringGridGameDebugCmd.Cells[0, 0] := '游戏命令';
  StringGridGameDebugCmd.Cells[1, 0] := '所需权限';
  StringGridGameDebugCmd.Cells[2, 0] := '命令格式';
  StringGridGameDebugCmd.Cells[3, 0] := '命令说明';


end;

procedure TfrmGameCmd.Open;
begin
  RefUserCommand();
  RefGameMasterCommand();
  RefDebugCommand();
  ShowModal;
end;
procedure TfrmGameCmd.RefGameUserCmd(GameCmd: pTGameCmd; sCmdParam, sDesc: string);
begin
  Inc(nRefGameUserIndex);
  if StringGridGameCmd.RowCount - 1 < nRefGameUserIndex then begin
    StringGridGameCmd.RowCount := nRefGameUserIndex + 1;
  end;

  StringGridGameCmd.Cells[0, nRefGameUserIndex] := GameCmd.sCmd;
  StringGridGameCmd.Cells[1, nRefGameUserIndex] := IntToStr(GameCmd.nPermissionMin) + '/' + IntToStr(GameCmd.nPermissionMax);
  StringGridGameCmd.Cells[2, nRefGameUserIndex] := sCmdParam;
  StringGridGameCmd.Cells[3, nRefGameUserIndex] := sDesc;
  StringGridGameCmd.Objects[0, nRefGameUserIndex] := TObject(GameCmd);
end;




//  StringGridGameCmd.Cells[3,12]:='未使用';
//  StringGridGameCmd.Cells[3,13]:='移动地图指定座标(需要戴传送装备)';
//  StringGridGameCmd.Cells[3,14]:='探测人物所在位置(需要戴传送装备)';
//  StringGridGameCmd.Cells[3,15]:='允许记忆传送';
//  StringGridGameCmd.Cells[3,16]:='将组队人员传送到身边(需要戴记忆全套装备)';
//  StringGridGameCmd.Cells[3,17]:='允许行会传送';
//  StringGridGameCmd.Cells[3,18]:='将行会成员传送身边(需要戴行会传送装备)';
//  StringGridGameCmd.Cells[3,19]:='开启仓库密码锁';
//  StringGridGameCmd.Cells[3,20]:='开启登录密码锁';
//  StringGridGameCmd.Cells[3,21]:='将仓库密码锁上';
//  StringGridGameCmd.Cells[3,22]:='设置仓库密码';
//  StringGridGameCmd.Cells[3,23]:='修改仓库密码';
//  StringGridGameCmd.Cells[3,24]:='清除密码(先开锁再清除密码)';
//  StringGridGameCmd.Cells[3,25]:='未使用';
//  StringGridGameCmd.Cells[3,26]:='查询夫妻位置';
//  StringGridGameCmd.Cells[3,27]:='允许夫妻传送';
//  StringGridGameCmd.Cells[3,28]:='夫妻将对方传送到身边';
//  StringGridGameCmd.Cells[3,29]:='查询师徒位置';
//  StringGridGameCmd.Cells[3,30]:='允许师徒传送';
//  StringGridGameCmd.Cells[3,31]:='师父将徒弟召唤到身边';
//  StringGridGameCmd.Cells[3,32]:='更换攻击模式(此命令不要修改)';
//  StringGridGameCmd.Cells[3,33]:='宝宝攻击状态(此命令不要修改)';
//  StringGridGameCmd.Cells[3,34]:='带马牌后骑上马';
//  StringGridGameCmd.Cells[3,35]:='从马上下来';
//  StringGridGameCmd.Cells[3,36]:='';
//  StringGridGameCmd.Cells[3,37]:='开启/关闭登录锁';
procedure TfrmGameCmd.RefUserCommand;
begin
  EditUserCmdOK.Enabled := False;
  nRefGameUserIndex := 0;

  RefGameUserCmd(@g_GameCommand.Data,'@' + g_GameCommand.Data.sCmd, '查看当前服务器日期时间');
  RefGameUserCmd(@g_GameCommand.PRVMSG, '@' + g_GameCommand.PRVMSG.sCmd, '禁止指定人物发的私聊信息');
  RefGameUserCmd(@g_GameCommand.ALLOWMSG, '@' + g_GameCommand.ALLOWMSG.sCmd, '禁止别人向自己发私聊信息');
  RefGameUserCmd(@g_GameCommand.ReadMasterMsg,'@' + g_GameCommand.ReadMasterMsg.sCmd,'禁止别人向自己发拜师信息');
  RefGameUserCmd(@g_GameCommand.MarryMsg,'@' + g_GameCommand.MarryMsg.sCmd,'禁止别人向自己发求婚信息');
  RefGameUserCmd(@g_GameCommand.LETSHOUT,'@' + g_GameCommand.LETSHOUT.sCmd,'禁止接收组队聊天信息');
{  RefGameUserCmd(@g_GameCommand.BANGMMSG, //拒绝所有喊话信息 20080211
    '@' + g_GameCommand.BANGMMSG.sCmd,
    '禁止接收所有喊话信息');  }
  RefGameUserCmd(@g_GameCommand.LETTRADE,
    '@' + g_GameCommand.LETTRADE.sCmd,
    '禁止交易交易物品');
  RefGameUserCmd(@g_GameCommand.LETGUILD,
    '@' + g_GameCommand.LETGUILD.sCmd,
    '允许加入行会');
  RefGameUserCmd(@g_GameCommand.ENDGUILD,
    '@' + g_GameCommand.ENDGUILD.sCmd,
    '退出当前所加入的行会');
  RefGameUserCmd(@g_GameCommand.BANGUILDCHAT,
    '@' + g_GameCommand.BANGUILDCHAT.sCmd,
    '禁止接收行会聊天信息');
  RefGameUserCmd(@g_GameCommand.AUTHALLY,
    '@' + g_GameCommand.AUTHALLY.sCmd,
    '许行会进入联盟');
  RefGameUserCmd(@g_GameCommand.AUTH,
    '@' + g_GameCommand.AUTH.sCmd,
    '开始进行行会联盟(命令格式需为@Alliance,否则游戏里则无法联盟)');
  RefGameUserCmd(@g_GameCommand.AUTHCANCEL,
    '@' + g_GameCommand.AUTHCANCEL.sCmd,
    '取消行会联盟关系(命令格式需为@CancelAlliance,否则游戏里则无法取消联盟)');
 // Exit;//20080823

  RefGameUserCmd(@g_GameCommand.USERMOVE,
    '@' + g_GameCommand.USERMOVE.sCmd + '  座标X  座标Y',
    '传送到指定坐标');

  RefGameUserCmd(@g_GameCommand.SEARCHING,
    '@' + g_GameCommand.SEARCHING.sCmd + ' 人物名称',
    '探测指定人物在何处');

  RefGameUserCmd(@g_GameCommand.ALLOWGROUPCALL,
    '@' + g_GameCommand.ALLOWGROUPCALL.sCmd ,
    '允许天地合一(此命令用于允许或禁止编组传送功能)');

  RefGameUserCmd(@g_GameCommand.GROUPRECALLL,
    '@' + g_GameCommand.GROUPRECALLL.sCmd,
    '天地合一');

  RefGameUserCmd(@g_GameCommand.ALLOWGUILDRECALL,
    '@' + g_GameCommand.ALLOWGUILDRECALL.sCmd,
    '允许行会合一(行会传送，行会掌门人可以将整个行会成员全部集中)');

  RefGameUserCmd(@g_GameCommand.GUILDRECALLL,
    '@' + g_GameCommand.GUILDRECALLL.sCmd,
    '行会合一');

  RefGameUserCmd(@g_GameCommand.UNLOCKSTORAGE,
    '@' + g_GameCommand.UNLOCKSTORAGE.sCmd,
    '仓库开锁');

  RefGameUserCmd(@g_GameCommand.UnLock,
    '@' + g_GameCommand.UnLock.sCmd,
    '开锁');

  RefGameUserCmd(@g_GameCommand.Lock,
    '@' + g_GameCommand.Lock.sCmd,
    '锁定仓库');

  RefGameUserCmd(@g_GameCommand.SETPASSWORD,
    '@' + g_GameCommand.SETPASSWORD.sCmd,
    '设置密码');

  RefGameUserCmd(@g_GameCommand.CHGPASSWORD,
    '@' + g_GameCommand.CHGPASSWORD.sCmd,
    '修改密码');

  RefGameUserCmd(@g_GameCommand.UNPASSWORD,
    '@' + g_GameCommand.UNPASSWORD.sCmd,
    '清除密码');

  RefGameUserCmd(@g_GameCommand.MEMBERFUNCTION,
    '@' + g_GameCommand.MEMBERFUNCTION.sCmd,
    '打开会员功能窗口(QManage-[@Member])');

  RefGameUserCmd(@g_GameCommand.DEAR,
    '@' + g_GameCommand.DEAR.sCmd+ ' 人物名称',
    '此命令用于查询配偶当前所在位置');

  RefGameUserCmd(@g_GameCommand.ALLOWDEARRCALL,
    '@' + g_GameCommand.ALLOWDEARRCALL.sCmd,
    '允许夫妻传送');

  RefGameUserCmd(@g_GameCommand.DEARRECALL,
    '@' + g_GameCommand.DEARRECALL.sCmd,
    '夫妻传送，将对方传送到自己身边，对方必须允许传送');

  RefGameUserCmd(@g_GameCommand.MASTER,
    '@' + g_GameCommand.MASTER.sCmd + ' 人物名称',
    '此命令用于查询师徒当前所在位置');

  RefGameUserCmd(@g_GameCommand.ALLOWMASTERRECALL,
    '@' + g_GameCommand.ALLOWMASTERRECALL.sCmd,
    '允许师徒传送');

  RefGameUserCmd(@g_GameCommand.MASTERECALL,
    '@' +  g_GameCommand.MASTERECALL.sCmd + ' 人物名称',
    '师徒传送');

  RefGameUserCmd(@g_GameCommand.ATTACKMODE,
    '@' +  g_GameCommand.ATTACKMODE.sCmd ,
    '改变攻击模式');

  RefGameUserCmd(@g_GameCommand.REST,
    '@' +  g_GameCommand.REST.sCmd ,
    '改变下属状态');

  RefGameUserCmd(@g_GameCommand.MEMBERFUNCTIONEX,
    '@' +  g_GameCommand.MEMBERFUNCTIONEX.sCmd ,
    '打开会员功能(QFunction-[@Member])');

  RefGameUserCmd(@g_GameCommand.LOCKLOGON,
    '@' +  g_GameCommand.LOCKLOGON.sCmd ,
    '启用登录锁功能');

{  RefGameUserCmd(@g_GameCommand.REMTEMSG,
    '@' +  g_GameCommand.REMTEMSG.sCmd ,
    '允许接受消息(点歌)');  }
end;

procedure TfrmGameCmd.StringGridGameCmdClick(Sender: TObject);
var
  nIndex: Integer;
  GameCmd: pTGameCmd;
begin
  nIndex := StringGridGameCmd.Row;
  GameCmd := pTGameCmd(StringGridGameCmd.Objects[0, nIndex]);
  if GameCmd <> nil then begin
    EditUserCmdName.Text := GameCmd.sCmd;
    EditUserCmdPerMission.Value := GameCmd.nPermissionMin;
    LabelUserCmdParam.Caption := StringGridGameCmd.Cells[2, nIndex];
    LabelUserCmdFunc.Caption := StringGridGameCmd.Cells[3, nIndex];
  end;
  EditUserCmdOK.Enabled := False;
end;

procedure TfrmGameCmd.EditUserCmdNameChange(Sender: TObject);
begin
  EditUserCmdOK.Enabled := True;
  EditUserCmdSave.Enabled := True;
end;

procedure TfrmGameCmd.EditUserCmdPerMissionChange(Sender: TObject);
begin
  EditUserCmdOK.Enabled := True;
  EditUserCmdSave.Enabled := True;
end;

procedure TfrmGameCmd.EditUserCmdOKClick(Sender: TObject);
var
  nIndex: Integer;
  GameCmd: pTGameCmd;
  sCmd: string;
  nPermission: Integer;
begin
  sCmd := Trim(EditUserCmdName.Text);
  nPermission := EditUserCmdPerMission.Value;
  if sCmd = '' then begin
    Application.MessageBox('命令名称不能为空！！！', '提示信息', MB_OK + MB_ICONERROR);
    EditUserCmdName.SetFocus;
    Exit;
  end;

  nIndex := StringGridGameCmd.Row;
  GameCmd := pTGameCmd(StringGridGameCmd.Objects[0, nIndex]);
  if GameCmd <> nil then begin
    GameCmd.sCmd := sCmd;
    GameCmd.nPermissionMin := nPermission;
  end;
  RefUserCommand();
end;

procedure TfrmGameCmd.EditUserCmdSaveClick(Sender: TObject);
begin
  EditUserCmdSave.Enabled := False;
{$IF SoftVersion <> VERDEMO}
  CommandConf.WriteString('Command', 'Date', g_GameCommand.Data.sCmd);
  CommandConf.WriteString('Command', 'PrvMsg', g_GameCommand.PRVMSG.sCmd);
  CommandConf.WriteString('Command', 'AllowMsg', g_GameCommand.ALLOWMSG.sCmd);
  CommandConf.WriteString('Command', 'LetShout', g_GameCommand.LETSHOUT.sCmd);
{  CommandConf.WriteString('Command', 'BanGmMsg', g_GameCommand.BANGMMSG.sCmd);//拒绝所有喊话信息 20080211 }
  CommandConf.WriteString('Command', 'LetTrade', g_GameCommand.LETTRADE.sCmd);
  CommandConf.WriteString('Command', 'LetGuild', g_GameCommand.LETGUILD.sCmd);
  CommandConf.WriteString('Command', 'EndGuild', g_GameCommand.ENDGUILD.sCmd);
  CommandConf.WriteString('Command', 'BanGuildChat', g_GameCommand.BANGUILDCHAT.sCmd);
  CommandConf.WriteString('Command', 'AuthAlly', g_GameCommand.AUTHALLY.sCmd);
  CommandConf.WriteString('Command', 'Auth', g_GameCommand.AUTH.sCmd);
  CommandConf.WriteString('Command', 'AuthCancel', g_GameCommand.AUTHCANCEL.sCmd);
  //CommandConf.WriteString('Command', 'ViewDiary', g_GameCommand.DIARY.sCmd);//未使用 20080823
  CommandConf.WriteString('Command', 'UserMove', g_GameCommand.USERMOVE.sCmd);
  CommandConf.WriteString('Command', 'Searching', g_GameCommand.SEARCHING.sCmd);
  CommandConf.WriteString('Command', 'AllowGroupCall', g_GameCommand.ALLOWGROUPCALL.sCmd);
  CommandConf.WriteString('Command', 'GroupCall', g_GameCommand.GROUPRECALLL.sCmd);
  CommandConf.WriteString('Command', 'AllowGuildReCall', g_GameCommand.ALLOWGUILDRECALL.sCmd);
  CommandConf.WriteString('Command', 'GuildReCall', g_GameCommand.GUILDRECALLL.sCmd);
  CommandConf.WriteString('Command', 'StorageUnLock', g_GameCommand.UNLOCKSTORAGE.sCmd);
  CommandConf.WriteString('Command', 'PasswordUnLock', g_GameCommand.UnLock.sCmd);
  CommandConf.WriteString('Command', 'StorageLock', g_GameCommand.Lock.sCmd);
  CommandConf.WriteString('Command', 'StorageSetPassword', g_GameCommand.SETPASSWORD.sCmd);
  CommandConf.WriteString('Command', 'StorageChgPassword', g_GameCommand.CHGPASSWORD.sCmd);
  //  CommandConf.WriteString('Command','StorageClearPassword',g_GameCommand.CLRPASSWORD.sCmd)
  //  CommandConf.WriteInteger('Permission','StorageClearPassword', g_GameCommand.CLRPASSWORD.nPermissionMin)
  CommandConf.WriteString('Command', 'StorageUserClearPassword', g_GameCommand.UNPASSWORD.sCmd);
  CommandConf.WriteString('Command', 'MemberFunc', g_GameCommand.MEMBERFUNCTION.sCmd);
  CommandConf.WriteString('Command', 'Dear', g_GameCommand.DEAR.sCmd);
  CommandConf.WriteString('Command', 'Master', g_GameCommand.MASTER.sCmd);
  CommandConf.WriteString('Command', 'DearRecall', g_GameCommand.DEARRECALL.sCmd);
  CommandConf.WriteString('Command', 'MasterRecall', g_GameCommand.MASTERECALL.sCmd);
  CommandConf.WriteString('Command', 'AllowDearRecall', g_GameCommand.ALLOWDEARRCALL.sCmd);
  CommandConf.WriteString('Command', 'AllowMasterRecall', g_GameCommand.ALLOWMASTERRECALL.sCmd);
  CommandConf.WriteString('Command', 'AttackMode', g_GameCommand.ATTACKMODE.sCmd);
  CommandConf.WriteString('Command', 'Rest', g_GameCommand.REST.sCmd);
  CommandConf.WriteString('Command', 'TakeOnHorse', g_GameCommand.TAKEONHORSE.sCmd);
  CommandConf.WriteString('Command', 'TakeOffHorse', g_GameCommand.TAKEOFHORSE.sCmd);

  CommandConf.WriteInteger('Permission', 'Date', g_GameCommand.Data.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'PrvMsg', g_GameCommand.PRVMSG.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'AllowMsg', g_GameCommand.ALLOWMSG.nPermissionMin);
{$IFEND}
end;
procedure TfrmGameCmd.RefGameMasterCmd(GameCmd: pTGameCmd; sCmdParam, sDesc: string);
var nCode: Byte;//20080829
begin
  nCode:= 0;
  try
    Inc(nRefGameMasterIndex);
    nCode:= 1;
    if StringGridGameMasterCmd.RowCount - 1 < nRefGameMasterIndex then begin
      nCode:= 2;
      StringGridGameMasterCmd.RowCount := nRefGameMasterIndex + 1;
    end;
    nCode:= 3;
    StringGridGameMasterCmd.Cells[0, nRefGameMasterIndex] := GameCmd.sCmd;
    nCode:= 4;
    StringGridGameMasterCmd.Cells[1, nRefGameMasterIndex] := IntToStr(GameCmd.nPermissionMin) + '/' + IntToStr(GameCmd.nPermissionMax);
    nCode:= 5;
    StringGridGameMasterCmd.Cells[2, nRefGameMasterIndex] := sCmdParam;
    nCode:= 6;
    StringGridGameMasterCmd.Cells[3, nRefGameMasterIndex] := sDesc;
    nCode:= 7;
    StringGridGameMasterCmd.Objects[0, nRefGameMasterIndex] := TObject(GameCmd);
  except
    MainOutMessage(Format('{%s} TfrmGameCmd.RefGameMasterCmd Code:%d', [g_sExceptionVer, nCode]));
  end;
end;

//游戏命令说明
procedure TfrmGameCmd.RefGameMasterCommand;
begin
  EditGameMasterCmdOK.Enabled := False;
  nRefGameMasterIndex := 0;

  RefGameMasterCmd(@g_GameCommand.CLRPASSWORD,
    '@' + g_GameCommand.CLRPASSWORD.sCmd + ' 人物名称',
    '清除人物仓库/登录密码(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.WHO,
    '/' + g_GameCommand.WHO.sCmd,
    '查看当前服务器在线人数(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.TOTAL,
    '/' + g_GameCommand.TOTAL.sCmd,
    '查看所有服务器在线人数(支持权限分配)');


  RefGameMasterCmd(@g_GameCommand.GAMEMASTER,
    '@' + g_GameCommand.GAMEMASTER.sCmd,
    '进入/退出管理员模式(进入模式后不会受到任何角色攻击)(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.OBSERVER,
    '@' + g_GameCommand.OBSERVER.sCmd,
    '进入/退出隐身模式(进入模式后别人看不到自己)(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.SUEPRMAN,
    '@' + g_GameCommand.SUEPRMAN.sCmd,
    '进入/退出无敌模式(进入模式后人物不会死亡)(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.MAKE,
    '@' + g_GameCommand.MAKE.sCmd + ' 物品名称 数量 神技(1-7) 几鉴(0-3) 普通属性(11-160)',
    '制造指定物品(支持权限分配，小于最大权限受允许、禁止制造列表限制 不同神技、属性使用|分隔)');

  RefGameMasterCmd(@g_GameCommand.SMAKE,
    '@' + g_GameCommand.SMAKE.sCmd + ' 参数详见使用说明',
    '调整自己身上的物品属性(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.Move,
    '@' + g_GameCommand.Move.sCmd + ' 地图号',
    '移动到指定地图(支持权限分配，小于最大权限受受禁止传送地图列表限制)');

  RefGameMasterCmd(@g_GameCommand.POSITIONMOVE,
    '@' + g_GameCommand.POSITIONMOVE.sCmd + ' 地图号 X Y',
    '移动到指定地图(支持权限分配，小于最大权限受受禁止传送地图列表限制)');

  RefGameMasterCmd(@g_GameCommand.RECALL,
    '@' + g_GameCommand.RECALL.sCmd + ' 人物名称',
    '将指定人物召唤到身边(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.REGOTO,
    '@' + g_GameCommand.REGOTO.sCmd + ' 人物名称',
    '跟踪指定人物(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.TING,
    '@' + g_GameCommand.TING.sCmd + ' 人物名称',
    '将指定人物随机传送(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.SUPERTING,
    '@' + g_GameCommand.SUPERTING.sCmd + ' 人物名称 范围大小',
    '将指定人物身边指定范围内的人物随机传送(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.MAPMOVE,
    '@' + g_GameCommand.MAPMOVE.sCmd + ' 源地图号 目标地图号',
    '将整个地图中的人物移动到其它地图中(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.INFO,
    '@' + g_GameCommand.INFO.sCmd + ' 人物名称',
    '看人物信息(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.HUMANLOCAL,
    '@' + g_GameCommand.HUMANLOCAL.sCmd + ' 人物名称',
    '查询人物IP及所在地区(需加载IP地区查询插件)(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.VIEWWHISPER,
    '@' + g_GameCommand.VIEWWHISPER.sCmd + ' 人物名称',
    '查看指定人物的私聊信息(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.MOBLEVEL,
    '@' + g_GameCommand.MOBLEVEL.sCmd,
    '查看身边角色信息(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.MOBCOUNT,
    '@' + g_GameCommand.MOBCOUNT.sCmd + ' 地图号',
    '查看地图中怪物数量(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.HUMANCOUNT,
    '@' + g_GameCommand.HUMANCOUNT.sCmd,
    '查看身边人数(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.Map,
    '@' + g_GameCommand.Map.sCmd,
    '显示当前所在地图相关信息(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.Level,
    '@' + g_GameCommand.Level.sCmd,
    '调整自己的等级(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.KICK,
    '@' + g_GameCommand.KICK.sCmd + ' 人物名称',
    '将指定人物踢下线(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.ReAlive,
    '@' + g_GameCommand.ReAlive.sCmd + ' 人物名称',
    '将指定人物复活(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.KILL,
    '@' + g_GameCommand.KILL.sCmd + '人物名称',
    '将指定人物或怪物杀死(杀怪物时需面对怪物)(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.CHANGEJOB,
    '@' + g_GameCommand.CHANGEJOB.sCmd + ' 人物名称 职业类型(Warr Wizard Taos)',
    '调整人物的职业(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.FREEPENALTY,
    '@' + g_GameCommand.FREEPENALTY.sCmd + ' 人物名称',
    '清除指定人物的PK值(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.PKPOINT,
    '@' + g_GameCommand.PKPOINT.sCmd + ' 人物名称',
    '查看指定人物的PK值(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.IncPkPoint,
    '@' + g_GameCommand.IncPkPoint.sCmd + ' 人物名称 点数',
    '增加指定人物的PK值(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.CHANGEGENDER,
    '@' + g_GameCommand.CHANGEGENDER.sCmd + ' 人物名称 性别(男、女)',
    '调整人物的性别(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.HAIR,
    '@' + g_GameCommand.HAIR.sCmd + ' 类型值',
    '更改指定人物的头发类型(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.BonusPoint,
    '@' + g_GameCommand.BonusPoint.sCmd + ' 人物名称 属性点数',
    '调整人物的属性点数(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.DELBONUSPOINT,
    '@' + g_GameCommand.DELBONUSPOINT.sCmd + ' 人物名称',
    '删除人物的属性点数(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.RESTBONUSPOINT,
    '@' + g_GameCommand.RESTBONUSPOINT.sCmd + ' 人物名称',
    '将人物的属性点数重新分配(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.SETPERMISSION,
    '@' + g_GameCommand.SETPERMISSION.sCmd + ' 人物名称 权限等级(0 - 10)',
    '调整人物的权限等级，可以将普通人物升为GM权限(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.RENEWLEVEL,
    '@' + g_GameCommand.RENEWLEVEL.sCmd + ' 人物名称 点数(为空则查看)',
    '调整查看人物的转生等级(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.DELGOLD,
    '@' + g_GameCommand.DELGOLD.sCmd + ' 人物名称 数量',
    '删除人物指定数量的金币(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.ADDGOLD,
    '@' + g_GameCommand.ADDGOLD.sCmd + ' 人物名称 数量',
    '增加人物指定数量的金币(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.GAMEGOLD,
    '@' + g_GameCommand.GAMEGOLD.sCmd + ' 人物名称 控制符(+ - =) 数量',
    '调整人物的游戏币数量(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.GAMEGIRD,
    '@' + g_GameCommand.GAMEGIRD.sCmd + ' 人物名称 控制符(+ - =) 数量',
    '调整人物的灵符数量(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.GAMEDIAMOND,
    '@' + g_GameCommand.GAMEDIAMOND.sCmd + ' 人物名称 控制符(+ - =) 数量',
    '调整人物的金刚石数量(支持权限分配)');

{$IF HEROVERSION = 1}
// 调整英雄的忠诚度 20080109
  RefGameMasterCmd(@g_GameCommand.HEROLOYAL,
    '@' + '改变忠诚'{g_GameCommand.HEROLOYAL.sCmd} + ' 英雄名称  忠诚度(0-10000)',
    '调整英雄的忠诚度(支持权限分配)');
 {$IFEND}

  RefGameMasterCmd(@g_GameCommand.GAMEPOINT,
    '@' + g_GameCommand.GAMEPOINT.sCmd + ' 人物名称 控制符(+ - =) 数量',
    '调整人物的游戏点数量(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.CREDITPOINT,
    '@' + g_GameCommand.CREDITPOINT.sCmd + ' 人物名称 控制符(+ - =) 点数',
    '调整人物的声望点数(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.REFINEWEAPON,
    '@' + g_GameCommand.REFINEWEAPON.sCmd + ' 攻击力 魔法力 道术 准确度',
    '调整身上武器属性(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.SysMsg,                 //千里传音 20071228
    '@' + g_GameCommand.SysMsg.sCmd + ' 发布信息',
    '千里传音功能');

{$IF HEROVERSION = 1}
  RefGameMasterCmd(@g_GameCommand.HEROLEVEL,                 //调整英雄等级 20071227
    '@' + g_GameCommand.HEROLEVEL.sCmd + ' 英雄名称 等级',
    '调整指定英雄的等级(支持权限分配)');
{$IFEND}
  RefGameMasterCmd(@g_GameCommand.ADJUESTLEVEL,
    '@' + g_GameCommand.ADJUESTLEVEL.sCmd + ' 人物名称 等级',
    '调整指定人物的等级(支持权限分配)');
{$IF M2Version <> 2}
  RefGameMasterCmd(@g_GameCommand.NGLEVEL,//调整人物内功等级 20081221
    '@' + g_GameCommand.NGLEVEL.sCmd + ' 人物名称 内功等级',
    '调整指定人物或英雄内功等级(支持权限分配)');
{$IFEND}
  RefGameMasterCmd(@g_GameCommand.ADJUESTEXP,
    '@' + g_GameCommand.ADJUESTEXP.sCmd + ' 人物名称 经验值',
    '调整指定人物的经验值(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.CHANGEDEARNAME,
    '@' + g_GameCommand.CHANGEDEARNAME.sCmd + ' 人物名称 配偶名称(如果为 无 则清除)',
    '更改指定人物的配偶名称(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.CHANGEMASTERNAME,
    '@' + g_GameCommand.CHANGEMASTERNAME.sCmd + ' 人物名称 师徒名称(如果为 无 则清除)',
    '更改指定人物的师徒名称(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.RECALLMOB,   //
    '@' + g_GameCommand.RECALLMOB.sCmd + ' 怪物名称 数量 等级 是否变色(0/1) 名字颜色 坐标模式(0/1 1-使用人物当前坐标)',
    '召唤指定怪物为宝宝(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.RECALLMOBEX,                    //召唤宝宝
    '@' + g_GameCommand.RECALLMOBEX.sCmd + ' 怪物名称 名称颜色 坐标X 坐标Y 地图名',
    '召唤指定怪物为宝宝(支持权限分配)-魔王岭、宠物');

  RefGameMasterCmd(@g_GameCommand.GIVEMINE,                      //20080403 给指定纯度的矿石
    '@' + g_GameCommand.GIVEMINE.sCmd + ' 矿石名称 数量 纯度',
    '给指定纯度的矿石(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.MOVEMOBTO,                      //20080123 将指定坐标的怪物移动到新坐标
    '@' + g_GameCommand.MOVEMOBTO.sCmd + ' 怪物名称 原地图 原X 原Y 新地图 新X 新Y',
    '将指定坐标的怪物移动到新坐标(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.CLEARITEMMAP,                   //20080124 清除地图物品
    '@' + g_GameCommand.CLEARITEMMAP.sCmd + ' 地图 X Y 范围 物品名称',
    '清除地图物品，物品名称为ALL则清除所有(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.TRAINING,
    '@' + g_GameCommand.TRAINING.sCmd + {$IF HEROVERSION = 1}' 人物名称  技能名称 修炼等级(0-3) hero'{$ELSE}' 人物名称  技能名称 修炼等级(0-3)'{$IFEND},
    {$IF HEROVERSION = 1}'调整人物(英雄)的技能修炼等级(支持权限分配)'{$ELSE}'调整人物的技能修炼等级(支持权限分配)'{$IFEND});

  RefGameMasterCmd(@g_GameCommand.TRAININGSKILL,
    '@' + g_GameCommand.TRAININGSKILL.sCmd + {$IF HEROVERSION = 1}' 人物名称  技能名称 修炼等级(0-3) hero'{$ELSE}' 人物名称  技能名称 修炼等级(0-3)'{$IFEND},
    {$IF HEROVERSION = 1}'给指定人物(英雄)增加技能(支持权限分配)'{$ELSE}'给指定人物增加技能(支持权限分配)'{$IFEND});

  RefGameMasterCmd(@g_GameCommand.DELETESKILL,
    '@' + g_GameCommand.DELETESKILL.sCmd + {$IF HEROVERSION = 1}' 人物名称 技能名称(All) hero'{$ELSE}' 人物名称 技能名称(All)'{$IFEND},
    {$IF HEROVERSION = 1}'删除人物(英雄)的技能，All代表删除全部技能(支持权限分配)'{$ELSE}'删除人物的技能，All代表删除全部技能(支持权限分配)'{$IFEND});

  RefGameMasterCmd(@g_GameCommand.DELETEITEM,
    '@' + g_GameCommand.DELETEITEM.sCmd + ' 人物名称 物品名称 数量',
    '删除人物身上指定的物品(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.CLEARMISSION,
    '@' + g_GameCommand.CLEARMISSION.sCmd + ' 人物名称',
    '清除人物的任务标志(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.AddGuild,
    '@' + g_GameCommand.AddGuild.sCmd + ' 行会名称 掌门人',
    '新建一个行会(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.DELGUILD,
    '@' + g_GameCommand.DELGUILD.sCmd + ' 行会名称',
    '删除一个行会(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.CHANGESABUKLORD,
    '@' + g_GameCommand.CHANGESABUKLORD.sCmd + ' 行会名称',
    '更改城堡所属行会(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.FORCEDWALLCONQUESTWAR,
    '@' + g_GameCommand.FORCEDWALLCONQUESTWAR.sCmd,
    '强行开始/停止攻城战(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.CONTESTPOINT,
    '@' + g_GameCommand.CONTESTPOINT.sCmd + ' 行会名称',
    '查看行会争霸赛得分情况(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.STARTCONTEST,
    '@' + g_GameCommand.STARTCONTEST.sCmd,
    '开始行会争霸赛(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.ENDCONTEST,
    '@' + g_GameCommand.ENDCONTEST.sCmd,
    '结束行会争霸赛(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.ANNOUNCEMENT,
    '@' + g_GameCommand.ANNOUNCEMENT.sCmd + ' 行会名称',
    '查看行会争霸赛结果(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.MOB,
    '@' + g_GameCommand.MOB.sCmd + ' 怪物名称 数量 内功怪(0,1)',
    '在身边放置指定类型数量的怪物(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.Mission,
    '@' + g_GameCommand.Mission.sCmd + ' X  Y',
    '设置怪物的集中点(举行怪物攻城用)(支持权限分配');

  RefGameMasterCmd(@g_GameCommand.MobPlace,
    '@' + g_GameCommand.MobPlace.sCmd + ' X  Y 怪物名称 怪物数量 内功怪(0,1)',
    '在当前地图指定XY放置怪物(支持权限分配(先必须设置怪物的集中点)，放置的怪物大刀守卫不会攻击这些怪物');

  RefGameMasterCmd(@g_GameCommand.CLEARMON,
    '@' + g_GameCommand.CLEARMON.sCmd + ' 地图号(* 为所有) 怪物名称(* 为所有) 掉物品(0,1)',
    '清除地图中的怪物(支持权限分配'')');

  RefGameMasterCmd(@g_GameCommand.DISABLESENDMSG,
    '@' + g_GameCommand.DISABLESENDMSG.sCmd + ' 人物名称',
    '将指定人物加入发言过滤列表，加入列表后自己发的文字自己可以看到，其他人看不到(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.ENABLESENDMSG,
    '@' + g_GameCommand.ENABLESENDMSG.sCmd,
    '将指定人物从发言过滤列表中删除(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.DISABLESENDMSGLIST,
    '@' + g_GameCommand.DISABLESENDMSGLIST.sCmd,
    '查看发言过滤列表中的内容(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.SHUTUP,
    '@' + g_GameCommand.SHUTUP.sCmd + ' 人物名称',
    '将指定人物禁言(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.RELEASESHUTUP,
    '@' + g_GameCommand.RELEASESHUTUP.sCmd + ' 人物名称',
    '将指定人物从禁言列表中删除(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.SHUTUPLIST,
    '@' + g_GameCommand.SHUTUPLIST.sCmd,
    '查看禁言列表中的内容(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.SABUKWALLGOLD,
    '@' + g_GameCommand.SABUKWALLGOLD.sCmd,
    '查看城堡金币数(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.STARTQUEST,
    '@' + g_GameCommand.STARTQUEST.sCmd,
    '开始提问功能，游戏中所有人同时跳出问题窗口(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.DENYIPLOGON,
    '@' + g_GameCommand.DENYIPLOGON.sCmd + ' IP地址 是否永久封(0,1)',
    '将指定IP地址加入禁止登录列表，以这些IP登录的用户将无法进入游戏(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.DENYACCOUNTLOGON,
    '@' + g_GameCommand.DENYACCOUNTLOGON.sCmd + ' 登录帐号 是否永久封(0,1)',
    '将指定登录帐号加入禁止登录列表，以此帐号登录的用户将无法进入游戏(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.DENYCHARNAMELOGON,
    '@' + g_GameCommand.DENYCHARNAMELOGON.sCmd + ' 人物名称 是否永久封(0,1)',
    '将指定人物名称加入禁止登录列表，此人物将无法进入游戏(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.DELDENYIPLOGON,
    '@' + g_GameCommand.DELDENYIPLOGON.sCmd + ' IP地址',
    '恢复禁止登陆IP(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.DELDENYACCOUNTLOGON,
    '@' + g_GameCommand.DELDENYACCOUNTLOGON.sCmd+ ' 登录帐号',
    '恢复禁止登陆帐号(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.DELDENYCHARNAMELOGON,
    '@' + g_GameCommand.DELDENYCHARNAMELOGON.sCmd + ' 人物名称',
    '恢复禁止登陆人物(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.SHOWDENYIPLOGON,
    '@' + g_GameCommand.SHOWDENYIPLOGON.sCmd,
    '查看禁止登陆IP(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.SHOWDENYACCOUNTLOGON,
    '@' + g_GameCommand.SHOWDENYACCOUNTLOGON.sCmd,
    '查看禁止登陆帐号(支持权限分配)');


  RefGameMasterCmd(@g_GameCommand.SHOWDENYCHARNAMELOGON,
    '@' + g_GameCommand.SHOWDENYCHARNAMELOGON.sCmd,
    '查看禁止登录角色列表(支持权限分配)');

  RefGameMasterCmd(@g_GameCommand.SetMapMode,
    '@' + g_GameCommand.SetMapMode.sCmd,
    '设置地图模式');

  RefGameMasterCmd(@g_GameCommand.SHOWMAPMODE,
    '@' + g_GameCommand.SHOWMAPMODE.sCmd,
    '显示地图模式');

 { RefGameMasterCmd(@g_GameCommand.Attack,//20080812 注释
    '@' + g_GameCommand.Attack.sCmd,
    ''); }

  RefGameMasterCmd(@g_GameCommand.LUCKYPOINT,
    '@' + g_GameCommand.LUCKYPOINT.sCmd+ ' 人物名称 操作符(+,-,=) 点数',
    '调整指定人物的幸运值(支持权限分配)');

 { RefGameMasterCmd(@g_GameCommand.CHANGELUCK,//20080812 注释
    '@' + g_GameCommand.CHANGELUCK.sCmd,
    ''); }

  RefGameMasterCmd(@g_GameCommand.HUNGER,
    '@' + g_GameCommand.HUNGER.sCmd+ ' 人物名称 能量值',
    '调整指定人物的能量值(权限6以上)');

 { RefGameMasterCmd(@g_GameCommand.NAMECOLOR,//20080812 注释
    '@' + g_GameCommand.NAMECOLOR.sCmd,
    ''); 

  RefGameMasterCmd(@g_GameCommand.TRANSPARECY,
    '@' + g_GameCommand.TRANSPARECY.sCmd,
    ''); 

  RefGameMasterCmd(@g_GameCommand.LEVEL0,
    '@' + g_GameCommand.LEVEL0.sCmd,
    ''); }

  RefGameMasterCmd(@g_GameCommand.CHANGEITEMNAME,
    '@' + g_GameCommand.CHANGEITEMNAME.sCmd+ ' 物品编号 物品ID号 物品名称',
    '改变物品名称(权限6以上)');

 { RefGameMasterCmd(@g_GameCommand.ADDTOITEMEVENT,//20080812 注释
    '@' + g_GameCommand.ADDTOITEMEVENT.sCmd,
    '');

  RefGameMasterCmd(@g_GameCommand.ADDTOITEMEVENTASPIECES,
    '@' + g_GameCommand.ADDTOITEMEVENTASPIECES.sCmd,
    '');

  RefGameMasterCmd(@g_GameCommand.ItemEventList,
    '@' + g_GameCommand.ItemEventList.sCmd,
    '');

  RefGameMasterCmd(@g_GameCommand.STARTINGGIFTNO,
    '@' + g_GameCommand.STARTINGGIFTNO.sCmd,
    '');

  RefGameMasterCmd(@g_GameCommand.DELETEALLITEMEVENT,
    '@' + g_GameCommand.DELETEALLITEMEVENT.sCmd,
    '');

  RefGameMasterCmd(@g_GameCommand.STARTITEMEVENT,
    '@' + g_GameCommand.STARTITEMEVENT.sCmd,
    ''); 

  RefGameMasterCmd(@g_GameCommand.ITEMEVENTTERM,
    '@' + g_GameCommand.ITEMEVENTTERM.sCmd,
    '');

  RefGameMasterCmd(@g_GameCommand.OPDELETESKILL,
    '@' + g_GameCommand.OPDELETESKILL.sCmd,
    '');

  RefGameMasterCmd(@g_GameCommand.CHANGEWEAPONDURA,
    '@' + g_GameCommand.CHANGEWEAPONDURA.sCmd,
    '');

  RefGameMasterCmd(@g_GameCommand.SBKDOOR,
    '@' + g_GameCommand.SBKDOOR.sCmd,
    '');}

  RefGameMasterCmd(@g_GameCommand.SPIRIT,
    '@' + g_GameCommand.SPIRIT.sCmd + '  时间(秒)',
    '用于开始祈祷生效宝宝叛变(权限6以上)');

  RefGameMasterCmd(@g_GameCommand.SPIRITSTOP,
    '@' + g_GameCommand.SPIRITSTOP.sCmd,
    '用于停止祈祷生效导致宝宝叛变(权限6以上)');

  RefGameMasterCmd(@g_GameCommand.CLEARCOPYITEM,
    '@' + g_GameCommand.CLEARCOPYITEM.sCmd + ' 人物名称',
    '清除人物包裹仓库复制品(支持权限分配)');
{$IF M2Version <> 2}
  RefGameMasterCmd(@g_GameCommand.CLEARHUMTITLE,
    '@' + g_GameCommand.CLEARHUMTITLE.sCmd + ' 人物名称 称号名',
    '回收人物指定称号(支持权限分配)');
{$IFEND}
end;

procedure TfrmGameCmd.RefGameDebugCmd(GameCmd: pTGameCmd; sCmdParam, sDesc: string);
begin
  Inc(nRefGameDebugIndex);
  if StringGridGameMasterCmd.RowCount - 1 < nRefGameDebugIndex then begin
    StringGridGameDebugCmd.RowCount := nRefGameDebugIndex + 1;
  end;

  StringGridGameDebugCmd.Cells[0, nRefGameDebugIndex] := GameCmd.sCmd;
  StringGridGameDebugCmd.Cells[1, nRefGameDebugIndex] := IntToStr(GameCmd.nPermissionMin) + '/' + IntToStr(GameCmd.nPermissionMax);
  StringGridGameDebugCmd.Cells[2, nRefGameDebugIndex] := sCmdParam;
  StringGridGameDebugCmd.Cells[3, nRefGameDebugIndex] := sDesc;
  StringGridGameDebugCmd.Objects[0, nRefGameDebugIndex] := TObject(GameCmd);
end;
//调试命令
procedure TfrmGameCmd.RefDebugCommand;
var
  GameCmd: pTGameCmd;
begin
  EditGameDebugCmdOK.Enabled := False;
  //  StringGridGameDebugCmd.RowCount:=41;

  GameCmd := @g_GameCommand.SHOWFLAG;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd,
    '');

  GameCmd := @g_GameCommand.SETFLAG;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd + ' 人物名称 标志号 数字(0 - 1)',
    '');

{  GameCmd := @g_GameCommand.SHOWOPEN;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd,
    ''); 

  GameCmd := @g_GameCommand.SETOPEN;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd,
    ''); 

  GameCmd := @g_GameCommand.SHOWUNIT;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd,
    ''); 

  GameCmd := @g_GameCommand.SETUNIT;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd,
    ''); }

  GameCmd := @g_GameCommand.MOBNPC;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd + ' NPC名称 脚本文件名 外形(数字) 属沙城(0,1) 地图 X Y',
    '增加NPC(如地图参数为空，则以GM所在地图为准)');

  GameCmd := @g_GameCommand.DELNPC;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd + ' NPC名称 地图 X Y',
    '删除NPC (如不带参数，则需与NPC面对面才能删除NPC)');

  GameCmd := @g_GameCommand.LOTTERYTICKET;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd,
    '查看彩票中奖数据');

  GameCmd := @g_GameCommand.RELOADADMIN;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd,
    '重新加载管理员列表');

  GameCmd := @g_GameCommand.ReLoadNpc;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd + ' NPC名称(ALL) 地图 X Y',
    '重新加载NPC脚本(ALL则重载所有NPC)');

  GameCmd := @g_GameCommand.RELOADMANAGE;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd,
    '重新加载登录脚本');

  GameCmd := @g_GameCommand.RELOADROBOTMANAGE;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd,
    '重新加载机器人配置');

  GameCmd := @g_GameCommand.RELOADROBOT;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd,
    '重新加载机器人脚本');

  GameCmd := @g_GameCommand.RELOADMONITEMS;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd,
    '重新加载怪物爆率配置');

 { GameCmd := @g_GameCommand.RELOADDIARY; //20080812 注释
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd,
    '未使用'); }

  GameCmd := @g_GameCommand.RELOADITEMDB;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd,
    '重新加载物品数据库');
  {$IF M2Version <> 2}
  GameCmd := @g_GameCommand.RELOADHUMTITLEDB;
  RefGameDebugCmd(GameCmd,'@' + GameCmd.sCmd, '重新加载称号数据库');
  {$IFEND}
  GameCmd := @g_GameCommand.RELOADMAGICDB;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd,
    '重新加载魔法数据库');

  GameCmd := @g_GameCommand.RELOADMONSTERDB;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd,
    '重新加载怪物数据库');

  GameCmd := @g_GameCommand.RELOADMINMAP;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd,
    '重新加载小地图配置');

  GameCmd := @g_GameCommand.RELOADGUILD;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd + ' 行会名称',
    '重新加载指定的行会');

 { GameCmd := @g_GameCommand.RELOADGUILDALL;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd,
    '未使用'); }

  GameCmd := @g_GameCommand.RELOADLINENOTICE;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd,
    '重新加载游戏公告信息');

  GameCmd := @g_GameCommand.RELOADABUSE;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd,
    '重新加载脏话过滤配置');

  GameCmd := @g_GameCommand.BACKSTEP;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd+' 方向(0-8) 人数',
    '推开人物');

  GameCmd := @g_GameCommand.RECONNECTION;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd,
    '将指定人物重新切换网络连接');

  GameCmd := @g_GameCommand.DISABLEFILTER;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd,
    '禁用脏话过滤功能');

  GameCmd := @g_GameCommand.CHGUSERFULL;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd + ' 人数',
    '设置服务器最高上线人数');

  GameCmd := @g_GameCommand.CHGZENFASTSTEP;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd + ' 速度',
    '设置怪物行动速度');

{  GameCmd := @g_GameCommand.OXQUIZROOM;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd,
    '未使用');

  GameCmd := @g_GameCommand.BALL;//20080812 注释
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd,
    '未使用'); }

  GameCmd := @g_GameCommand.FIREBURN;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd + ' 类型(1-6) 时间(秒) 点数',
    '增加场景');

  GameCmd := @g_GameCommand.TESTFIRE;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd + ' 范围 类型(1-6) 时间(秒) 点数',
    '在一定范围增加场景');

  GameCmd := @g_GameCommand.TESTSTATUS;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd + ' 类型(0..11) 时长',
    '改变人物的临时属性');

{  GameCmd := @g_GameCommand.TESTGOLDCHANGE; //20080812 注释
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd,
    '未使用');

  GameCmd := @g_GameCommand.GSA;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd,
    '未使用');}

 { GameCmd := @g_GameCommand.TESTGA;//20081014 注释
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd,
    '输入TESTGA命令'); }

  GameCmd := @g_GameCommand.MAPINFO;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd + ' 地图号 X Y',
    '显示地图信息');

  GameCmd := @g_GameCommand.CLEARBAG;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd + ' 人物名称',
    '清除背包全部物品');

end;

procedure TfrmGameCmd.StringGridGameMasterCmdClick(Sender: TObject);
var
  nIndex: Integer;
  GameCmd: pTGameCmd;
begin
  nIndex := StringGridGameMasterCmd.Row;
  GameCmd := pTGameCmd(StringGridGameMasterCmd.Objects[0, nIndex]);
  if GameCmd <> nil then begin
    EditGameMasterCmdName.Text := GameCmd.sCmd;
    EditGameMasterCmdPerMission.Value := GameCmd.nPermissionMin;
    LabelGameMasterCmdParam.Caption := StringGridGameMasterCmd.Cells[2, nIndex];
    LabelGameMasterCmdFunc.Caption := StringGridGameMasterCmd.Cells[3, nIndex];
  end;
  EditGameMasterCmdOK.Enabled := False;
end;

procedure TfrmGameCmd.EditGameMasterCmdNameChange(Sender: TObject);
begin
  EditGameMasterCmdOK.Enabled := True;
  EditGameMasterCmdSave.Enabled := True;
end;

procedure TfrmGameCmd.EditGameMasterCmdPerMissionChange(Sender: TObject);
begin
  EditGameMasterCmdOK.Enabled := True;
  EditGameMasterCmdSave.Enabled := True;
end;

procedure TfrmGameCmd.EditGameMasterCmdOKClick(Sender: TObject);
var
  nIndex: Integer;
  GameCmd: pTGameCmd;
  sCmd: string;
  nPermission: Integer;
begin

  sCmd := Trim(EditGameMasterCmdName.Text);
  nPermission := EditGameMasterCmdPerMission.Value;
  if sCmd = '' then begin
    Application.MessageBox('命令名称不能为空！！！', '提示信息', MB_OK + MB_ICONERROR);
    EditGameMasterCmdName.SetFocus;
    Exit;
  end;

  nIndex := StringGridGameMasterCmd.Row;
  GameCmd := pTGameCmd(StringGridGameMasterCmd.Objects[0, nIndex]);
  if GameCmd <> nil then begin
    GameCmd.sCmd := sCmd;
    GameCmd.nPermissionMin := nPermission;
  end;
  RefGameMasterCommand();
end;

procedure TfrmGameCmd.EditGameMasterCmdSaveClick(Sender: TObject);
begin
  EditGameMasterCmdSave.Enabled := False;
{$IF SoftVersion <> VERDEMO}
  CommandConf.WriteString('Command', 'ObServer', g_GameCommand.OBSERVER.sCmd);
  CommandConf.WriteString('Command', 'GameMaster', g_GameCommand.GAMEMASTER.sCmd);
  CommandConf.WriteString('Command', 'SuperMan', g_GameCommand.SUEPRMAN.sCmd);
  CommandConf.WriteString('Command', 'StorageClearPassword', g_GameCommand.CLRPASSWORD.sCmd);
  CommandConf.WriteString('Command', 'ClearCopyItem', g_GameCommand.CLEARCOPYITEM.sCmd);//20080816 清理玩家复制品
  {$IF M2Version <> 2}
  CommandConf.WriteString('Command', 'ClearHumTitle', g_GameCommand.CLEARHUMTITLE.sCmd);
  {$IFEND}
  CommandConf.WriteString('Command', 'Who', g_GameCommand.WHO.sCmd);
  CommandConf.WriteString('Command', 'Total', g_GameCommand.TOTAL.sCmd);
  CommandConf.WriteString('Command', 'Make', g_GameCommand.MAKE.sCmd);
  CommandConf.WriteString('Command', 'PositionMove', g_GameCommand.POSITIONMOVE.sCmd);
  CommandConf.WriteString('Command', 'Move', g_GameCommand.Move.sCmd);
  CommandConf.WriteString('Command', 'Recall', g_GameCommand.RECALL.sCmd);
  CommandConf.WriteString('Command', 'ReGoto', g_GameCommand.REGOTO.sCmd);
  CommandConf.WriteString('Command', 'Ting', g_GameCommand.TING.sCmd);
  CommandConf.WriteString('Command', 'SuperTing', g_GameCommand.SUPERTING.sCmd);
  CommandConf.WriteString('Command', 'MapMove', g_GameCommand.MAPMOVE.sCmd);
  CommandConf.WriteString('Command', 'Info', g_GameCommand.INFO.sCmd);
  CommandConf.WriteString('Command', 'HumanLocal', g_GameCommand.HUMANLOCAL.sCmd);
  CommandConf.WriteString('Command', 'ViewWhisper', g_GameCommand.VIEWWHISPER.sCmd);
  CommandConf.WriteString('Command', 'MobLevel', g_GameCommand.MOBLEVEL.sCmd);
  CommandConf.WriteString('Command', 'MobCount', g_GameCommand.MOBCOUNT.sCmd);
  CommandConf.WriteString('Command', 'HumanCount', g_GameCommand.HUMANCOUNT.sCmd);
  CommandConf.WriteString('Command', 'Map', g_GameCommand.Map.sCmd);
  CommandConf.WriteString('Command', 'Level', g_GameCommand.Level.sCmd);
  CommandConf.WriteString('Command', 'Kick', g_GameCommand.KICK.sCmd);
  CommandConf.WriteString('Command', 'ReAlive', g_GameCommand.ReAlive.sCmd);
  CommandConf.WriteString('Command', 'Kill', g_GameCommand.KILL.sCmd);
  CommandConf.WriteString('Command', 'ChangeJob', g_GameCommand.CHANGEJOB.sCmd);
  CommandConf.WriteString('Command', 'FreePenalty', g_GameCommand.FREEPENALTY.sCmd);
  CommandConf.WriteString('Command', 'PkPoint', g_GameCommand.PKPOINT.sCmd);
  CommandConf.WriteString('Command', 'IncPkPoint', g_GameCommand.IncPkPoint.sCmd);
  CommandConf.WriteString('Command', 'ChangeGender', g_GameCommand.CHANGEGENDER.sCmd);
  CommandConf.WriteString('Command', 'Hair', g_GameCommand.HAIR.sCmd);
  CommandConf.WriteString('Command', 'BonusPoint', g_GameCommand.BonusPoint.sCmd);
  CommandConf.WriteString('Command', 'DelBonuPoint', g_GameCommand.DELBONUSPOINT.sCmd);
  CommandConf.WriteString('Command', 'RestBonuPoint', g_GameCommand.RESTBONUSPOINT.sCmd);
  CommandConf.WriteString('Command', 'SetPermission', g_GameCommand.SETPERMISSION.sCmd);
  CommandConf.WriteString('Command', 'ReNewLevel', g_GameCommand.RENEWLEVEL.sCmd);
  CommandConf.WriteString('Command', 'DelGold', g_GameCommand.DELGOLD.sCmd);
  CommandConf.WriteString('Command', 'AddGold', g_GameCommand.ADDGOLD.sCmd);
  CommandConf.WriteString('Command', 'GameGold', g_GameCommand.GAMEGOLD.sCmd);

  CommandConf.WriteString('Command', 'GameDiaMond', g_GameCommand.GameDiaMond.sCmd); //20071226 金刚石
  CommandConf.WriteString('Command', 'GameGird', g_GameCommand.GameGird.sCmd); //20071226 灵符
  CommandConf.WriteString('Command', 'HEROLOYAL', g_GameCommand.HEROLOYAL.sCmd); //20080109 英雄的忠诚度

  CommandConf.WriteString('Command', 'GamePoint', g_GameCommand.GAMEPOINT.sCmd);
  CommandConf.WriteString('Command', 'CreditPoint', g_GameCommand.CREDITPOINT.sCmd);
  CommandConf.WriteString('Command', 'RefineWeapon', g_GameCommand.REFINEWEAPON.sCmd);

  CommandConf.WriteString('Command', 'SysMsg','传' {g_GameCommand.SysMsg.sCmd});//千里传音 20071228

  CommandConf.WriteString('Command', 'HEROLEVEL', g_GameCommand.HEROLEVEL.sCmd);//调整英雄等级 20071227
  CommandConf.WriteString('Command', 'AdjuestTLevel', g_GameCommand.ADJUESTLEVEL.sCmd);//调整人物等级
  CommandConf.WriteString('Command', 'NGLevel', g_GameCommand.NGLEVEL.sCmd);//调整人物内功等级 20081221
  CommandConf.WriteString('Command', 'AdjuestExp', g_GameCommand.ADJUESTEXP.sCmd);
  CommandConf.WriteString('Command', 'ChangeDearName', g_GameCommand.CHANGEDEARNAME.sCmd);
  CommandConf.WriteString('Command', 'ChangeMasterrName', g_GameCommand.CHANGEMASTERNAME.sCmd);
  CommandConf.WriteString('Command', 'RecallMob', g_GameCommand.RECALLMOB.sCmd);
  CommandConf.WriteString('Command', 'RECALLMOBEX', g_GameCommand.RECALLMOBEX.sCmd);//20080122 召唤宝宝
  CommandConf.WriteString('Command', 'GIVEMINE', g_GameCommand.GIVEMINE.sCmd);//20080403 给指定纯度的矿石
  CommandConf.WriteString('Command', 'MOVEMOBTO', g_GameCommand.MOVEMOBTO.sCmd);//20080123 将指定坐标的怪物移动到新坐标
  CommandConf.WriteString('Command', 'CLEARITEMMAP', g_GameCommand.CLEARITEMMAP.sCmd);//20080124 清除地图物品
  CommandConf.WriteString('Command', 'Training', g_GameCommand.TRAINING.sCmd);
  CommandConf.WriteString('Command', 'OpTraining', g_GameCommand.TRAININGSKILL.sCmd);
  CommandConf.WriteString('Command', 'DeleteSkill', g_GameCommand.DELETESKILL.sCmd);
  CommandConf.WriteString('Command', 'DeleteItem', g_GameCommand.DELETEITEM.sCmd);
  CommandConf.WriteString('Command', 'ClearMission', g_GameCommand.CLEARMISSION.sCmd);
  CommandConf.WriteString('Command', 'AddGuild', g_GameCommand.AddGuild.sCmd);
  CommandConf.WriteString('Command', 'DelGuild', g_GameCommand.DELGUILD.sCmd);
  CommandConf.WriteString('Command', 'ChangeSabukLord', g_GameCommand.CHANGESABUKLORD.sCmd);
  CommandConf.WriteString('Command', 'ForcedWallConQuestWar', g_GameCommand.FORCEDWALLCONQUESTWAR.sCmd);
  CommandConf.WriteString('Command', 'ContestPoint', g_GameCommand.CONTESTPOINT.sCmd);
  CommandConf.WriteString('Command', 'StartContest', g_GameCommand.STARTCONTEST.sCmd);
  CommandConf.WriteString('Command', 'EndContest', g_GameCommand.ENDCONTEST.sCmd);
  CommandConf.WriteString('Command', 'Announcement', g_GameCommand.ANNOUNCEMENT.sCmd);
  CommandConf.WriteString('Command', 'MobLevel', g_GameCommand.MOBLEVEL.sCmd);
  CommandConf.WriteString('Command', 'Mission', g_GameCommand.Mission.sCmd);
  CommandConf.WriteString('Command', 'MobPlace', g_GameCommand.MobPlace.sCmd);

  CommandConf.WriteInteger('Permission', 'GameMaster', g_GameCommand.GAMEMASTER.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'ObServer', g_GameCommand.OBSERVER.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'SuperMan', g_GameCommand.SUEPRMAN.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'StorageClearPassword', g_GameCommand.CLRPASSWORD.nPermissionMin);

  CommandConf.WriteInteger('Permission', 'ClearCopyItem', g_GameCommand.CLEARCOPYITEM.nPermissionMin);//20080816 清理玩家复制品
  {$IF M2Version <> 2}
  CommandConf.WriteInteger('Permission', 'ClearHumTitle', g_GameCommand.CLEARHUMTITLE.nPermissionMin);
  {$IFEND}
  CommandConf.WriteInteger('Permission', 'Who', g_GameCommand.WHO.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'Total', g_GameCommand.TOTAL.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'MakeMin', g_GameCommand.MAKE.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'MakeMax', g_GameCommand.MAKE.nPermissionMax);
  CommandConf.WriteInteger('Permission', 'PositionMoveMin', g_GameCommand.POSITIONMOVE.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'PositionMoveMax', g_GameCommand.POSITIONMOVE.nPermissionMax);
  CommandConf.WriteInteger('Permission', 'MoveMin', g_GameCommand.Move.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'MoveMax', g_GameCommand.Move.nPermissionMax);
  CommandConf.WriteInteger('Permission', 'Recall', g_GameCommand.RECALL.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'ReGoto', g_GameCommand.REGOTO.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'Ting', g_GameCommand.TING.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'SuperTing', g_GameCommand.SUPERTING.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'MapMove', g_GameCommand.MAPMOVE.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'Info', g_GameCommand.INFO.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'HumanLocal', g_GameCommand.HUMANLOCAL.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'ViewWhisper', g_GameCommand.VIEWWHISPER.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'MobLevel', g_GameCommand.MOBLEVEL.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'MobCount', g_GameCommand.MOBCOUNT.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'HumanCount', g_GameCommand.HUMANCOUNT.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'Map', g_GameCommand.Map.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'Level', g_GameCommand.Level.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'Kick', g_GameCommand.KICK.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'ReAlive', g_GameCommand.ReAlive.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'Kill', g_GameCommand.KILL.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'ChangeJob', g_GameCommand.CHANGEJOB.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'FreePenalty', g_GameCommand.FREEPENALTY.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'PkPoint', g_GameCommand.PKPOINT.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'IncPkPoint', g_GameCommand.IncPkPoint.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'ChangeGender', g_GameCommand.CHANGEGENDER.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'Hair', g_GameCommand.HAIR.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'BonusPoint', g_GameCommand.BonusPoint.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'DelBonuPoint', g_GameCommand.DELBONUSPOINT.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'RestBonuPoint', g_GameCommand.RESTBONUSPOINT.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'SetPermission', g_GameCommand.SETPERMISSION.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'ReNewLevel', g_GameCommand.RENEWLEVEL.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'DelGold', g_GameCommand.DELGOLD.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'AddGold', g_GameCommand.ADDGOLD.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'GameGold', g_GameCommand.GAMEGOLD.nPermissionMin);

  CommandConf.WriteInteger('Permission', 'GameDiaMond', g_GameCommand.GameDiaMond.nPermissionMin); //20071226 金刚石
  CommandConf.WriteInteger('Permission','GameGird', g_GameCommand.GameGird.nPermissionMin); //20071226 灵符
  CommandConf.WriteInteger('Permission','HEROLOYAL', g_GameCommand.HEROLOYAL.nPermissionMin); //20080109 英雄的忠诚度

  CommandConf.WriteInteger('Permission', 'GamePoint', g_GameCommand.GAMEPOINT.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'CreditPoint', g_GameCommand.CREDITPOINT.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'RefineWeapon', g_GameCommand.REFINEWEAPON.nPermissionMin);

  CommandConf.WriteInteger('Permission', 'SysMsg', g_GameCommand.SysMsg.nPermissionMin);//千里传音 20071228

  CommandConf.WriteInteger('Permission', 'HEROLEVEL', g_GameCommand.HEROLEVEL.nPermissionMin);//调整英雄等级 20071227
  CommandConf.WriteInteger('Permission', 'AdjuestTLevel', g_GameCommand.ADJUESTLEVEL.nPermissionMin);//调整人物等级
  CommandConf.WriteInteger('Permission', 'NGLevel', g_GameCommand.NGLEVEL.nPermissionMin);//调整人物内功等级 20081221
  CommandConf.WriteInteger('Permission', 'AdjuestExp', g_GameCommand.ADJUESTEXP.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'ChangeDearName', g_GameCommand.CHANGEDEARNAME.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'ChangeMasterName', g_GameCommand.CHANGEMASTERNAME.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'RecallMob', g_GameCommand.RECALLMOB.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'RECALLMOBEX', g_GameCommand.RECALLMOBEX.nPermissionMin);//20080122 召唤宝宝
  CommandConf.WriteInteger('Permission', 'GIVEMINE', g_GameCommand.GIVEMINE.nPermissionMin);//20080403 给指定纯度的矿石
  CommandConf.WriteInteger('Permission', 'MOVEMOBTO', g_GameCommand.MOVEMOBTO.nPermissionMin);//20080123 将指定坐标的怪物移动到新坐标
  CommandConf.WriteInteger('Permission', 'CLEARITEMMAP', g_GameCommand.CLEARITEMMAP.nPermissionMin);//20080124 清除地图物品
  CommandConf.WriteInteger('Permission', 'Training', g_GameCommand.TRAINING.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'OpTraining', g_GameCommand.TRAININGSKILL.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'DeleteSkill', g_GameCommand.DELETESKILL.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'DeleteItem', g_GameCommand.DELETEITEM.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'ClearMission', g_GameCommand.CLEARMISSION.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'AddGuild', g_GameCommand.AddGuild.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'DelGuild', g_GameCommand.DELGUILD.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'ChangeSabukLord', g_GameCommand.CHANGESABUKLORD.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'ForcedWallConQuestWar', g_GameCommand.FORCEDWALLCONQUESTWAR.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'ContestPoint', g_GameCommand.CONTESTPOINT.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'StartContest', g_GameCommand.STARTCONTEST.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'EndContest', g_GameCommand.ENDCONTEST.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'Announcement', g_GameCommand.ANNOUNCEMENT.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'MobLevel', g_GameCommand.MOBLEVEL.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'Mission', g_GameCommand.Mission.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'MobPlace', g_GameCommand.MobPlace.nPermissionMin);
{$IFEND}
end;

procedure TfrmGameCmd.StringGridGameDebugCmdClick(Sender: TObject);
var
  nIndex: Integer;
  GameCmd: pTGameCmd;
begin
  nIndex := StringGridGameDebugCmd.Row;
  GameCmd := pTGameCmd(StringGridGameDebugCmd.Objects[0, nIndex]);
  if GameCmd <> nil then begin
    EditGameDebugCmdName.Text := GameCmd.sCmd;
    EditGameDebugCmdPerMission.Value := GameCmd.nPermissionMin;
    LabelGameDebugCmdParam.Caption := StringGridGameDebugCmd.Cells[2, nIndex];
    LabelGameDebugCmdFunc.Caption := StringGridGameDebugCmd.Cells[3, nIndex];
  end;
  EditGameDebugCmdOK.Enabled := False;
end;

procedure TfrmGameCmd.EditGameDebugCmdNameChange(Sender: TObject);
begin
  EditGameDebugCmdOK.Enabled := True;
  EditGameDebugCmdSave.Enabled := True;
end;

procedure TfrmGameCmd.EditGameDebugCmdPerMissionChange(Sender: TObject);
begin
  EditGameDebugCmdOK.Enabled := True;
  EditGameDebugCmdSave.Enabled := True;
end;

procedure TfrmGameCmd.EditGameDebugCmdOKClick(Sender: TObject);
var
  nIndex: Integer;
  GameCmd: pTGameCmd;
  sCmd: string;
  nPermission: Integer;
begin
  sCmd := Trim(EditGameDebugCmdName.Text);
  nPermission := EditGameDebugCmdPerMission.Value;
  if sCmd = '' then begin
    Application.MessageBox('命令名称不能为空！！！', '提示信息', MB_OK + MB_ICONERROR);
    EditGameDebugCmdName.SetFocus;
    Exit;
  end;

  nIndex := StringGridGameDebugCmd.Row;
  GameCmd := pTGameCmd(StringGridGameDebugCmd.Objects[0, nIndex]);
  if GameCmd <> nil then begin
    GameCmd.sCmd := sCmd;
    GameCmd.nPermissionMin := nPermission;
  end;
  RefDebugCommand();
end;


procedure TfrmGameCmd.EditGameDebugCmdSaveClick(Sender: TObject);
begin
  EditGameDebugCmdSave.Enabled := False;
end;

procedure TfrmGameCmd.FormDestroy(Sender: TObject);
begin
  frmGameCmd:= nil;
end;

procedure TfrmGameCmd.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
