unit GateShare;

interface
uses
  Windows, SysUtils, Classes, JSocket, WinSock, SyncObjs, IniFiles, Grobal2, Common, QQWry, Graphics;
const
  g_sProductName = '8619A7A04D9B35A00E13BBBA1BEA050E7FCD5470F6308880'; //3K科技游戏网关
  g_sProgram = 'BF329B13CBE9010C601B4C1E88011620'; //3K科技
  g_sVersion = '4D8B003419EF61192F344FC7EADF5DF9C5C3C9374D92394E';  //2.00 Build 20121212
  g_sUpDateTime = '0A19BD8D3E7F9844CF3ABB7DBC68FB4D'; //2012/12/12
  g_sWebSite = '92A51ADA62A0738AC5DB86D6E7E9CDE140574B5A981AB1753188062D144466D7'; // http://www.3KM2.com(官网站)
  g_sBbsSite = '6136601E4431B32C60BFBF8207DB95FA40574B5A981AB1753188062D144466D7'; //http://www.3KM2.net(程序站)
  GATEMAXSESSION = 1000;
  MSGMAXLENGTH = 20000;
  SENDCHECKSIZE = 512;
  SENDCHECKSIZEMAX = 2048;

  sIPFileName ='..\Mir200\IpList.db';//20080414 IP数据库路径

type

  TGList = class(TList)
  private
    GLock: TRTLCriticalSection;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Lock;
    procedure UnLock;
  end;

  TBlockIPMethod = (mDisconnect, mBlock, mBlockList);
  TSockaddr = record
    nIPaddr: Integer;
    sIPDate: string;//20080414 IP所属地址
    dwStartAttackTick: LongWord;
    nAttackCount: Integer;
  end;
  pTSockaddr = ^TSockaddr;

  TSessionInfo = record 
    Socket: TCustomWinSocket; //45AA8C
    sSocData: string; //45AA90
    sSendData: string; //45AA94
    nUserListIndex: Integer; //45AA98
    nPacketIdx: Integer; //45AA9C
    nPacketErrCount: Integer; //数据包序号重复计数（客户端用封包发送数据检测）
    boStartLogon: Boolean; //45AAA4 客户端第一次登陆
    //boSendLock: Boolean; //45AAA5
    //boOverNomSize: Boolean;
    //nOverNomSizeCount: ShortInt;
    //dwSendLatestTime: LongWord; //45AAA8
    nCheckSendLength: Integer; //45AAAC
    boSendAvailable: Boolean; //45AAB0
    boSendCheck: Boolean; //45AAB1
    dwTimeOutTime: LongWord; //0x28
    nReceiveLength: Integer; //45AAB8
    dwReceiveTick: LongWord; //45AABC Tick 发送信息间隔
    nSckHandle: Integer; //45AAC0
    sRemoteAddr: string; //IP
    dwSayMsgTick: LongWord; //发言间隔控制
    dwConnectTick: LongWord;//连接网关的时间
    nSessionID: Integer;//会话ID 20090228

    nErrorCount: Integer; //加速的累计值
    dwHitTick: LongWord; //攻击时间
    dwWalkTick: LongWord; //走路时间
    dwRunTick: LongWord; //跑步时间
    dwSpellTick: LongWord; //魔法时间
    dwPickUpTick: LongWord;//捡物品时间
    dwButchTick: LongWord;//挖肉时间
    dwTurnTick: LongWord;//转身时间
    dwEatTick: LongWord; //吃药时间
    dwOtherTick: LongWord; //其它消息时间
    nRandomKey: Word;//人物随机密钥 20091026
  end;
  pTSessionInfo = ^TSessionInfo;

  TSendUserData = record
    nSocketIdx: Integer; //0x00
    nSocketHandle: Integer; //0x04
    sMsg: string; //0x08
  end;
  pTSendUserData = ^TSendUserData;
procedure AddMainLogMsg(Msg: string; nLevel: Integer);
procedure LoadAbuseFile();
procedure LoadBlockIPFile();
procedure SaveBlockIPList();
function SearchIPLocal(sIPaddr: string): string;
function GetRGB(c256: Byte): TColor; stdcall;

var
  CS_MainLog: TCriticalSection;
  CS_FilterMsg: TCriticalSection;
  MainLogMsgList: TStringList;
  nShowLogLevel: Integer = 3;
  GateClass: string = 'Server';
  GateName: string = '游戏网关';
  TitleName: string = '3K科技';
  ServerAddr: string = '127.0.0.1';
  ServerPort: Integer = 5000;
  GateAddr: string = '0.0.0.0';
  GatePort: Integer = 7200;
  boStarted: Boolean = False;
  boClose: Boolean = False;
  boShowBite: Boolean = True; //显示B 或 KB
  boServiceStart: Boolean = False;
  boGateReady: Boolean = False; //0045AA74 网关是否就绪
  boCheckServerFail: Boolean = False; //网关 <->游戏服务器之间检测是否失败（超时）
  dwCheckServerTimeOutTime: LongWord = 180000; //网关 <->游戏服务器之间检测超时时间长度
  AbuseList: TStringList; //文字过滤
  SessionArray: array[0..GATEMAXSESSION - 1] of TSessionInfo;
  SessionCount: Integer; //0x32C 连接会话数

  sReplaceWord: string = '*';
  ReviceMsgList: TList; //0x45AA64
  //SendMsgList: TList; //0x45AA68
  nCurrConnCount: Integer;
  boSendHoldTimeOut: Boolean;
  dwSendHoldTick: LongWord;
  n45AA80: Integer;
  n45AA84: Integer;
  dwCheckRecviceTick: LongWord;
  dwCheckRecviceMin: LongWord;
  dwCheckRecviceMax: LongWord;

  dwCheckServerTick: LongWord;
  dwCheckServerTimeMin: LongWord;
  dwCheckServerTimeMax: LongWord;
  SocketBuffer: PChar; //45AA5C
  nBuffLen: Integer; //45AA60
  boDecodeMsgLock: Boolean;
  dwProcessReviceMsgTimeLimit: LongWord;
  dwProcessSendMsgTimeLimit: LongWord;
  m_nProcHumIDx :Integer  = 0;

  BlockIPList: TGList; //禁止连接IP列表
  TempBlockIPList: TGList; //临时禁止连接IP列表
  CurrIPaddrList: TGList;
  AttackIPaddrList: TGList; //攻击IP临时列表

  nMaxConnOfIPaddr: Integer = 50;
  nMaxClientPacketSize: Integer = 7000;
  nNomClientPacketSize: Integer = 200;
  dwClientCheckTimeOut: LongWord = 50; {3000}
  nMaxOverNomSizeCount: Integer = 2;
  nMaxClientMsgCount: Integer = 20;//数量限制
  nCheckServerFail: Integer = 0;
  dwAttackTick: LongWord = 200;//CC时间
  nAttackCount: Integer = 10;//CC攻击数量

  BlockMethod: TBlockIPMethod = mDisconnect;
  bokickOverPacketSize: Boolean = True;

  nClientSendBlockSize: Integer = 2000; //发送给客户端数据包大小限制
  dwClientTimeOutTime: LongWord = 120000; //客户端连接会话超时(指定时间内未有数据传输)
  Conf: TIniFile;
  sConfigFileName: string = '.\RunGate.ini';
  nSayMsgMaxLen: Integer = 70; //发言字符长度
  dwSayMsgTime: LongWord = 1000; //发主间隔时间
  //dwSessionTimeOutTime: LongWord = 60 * 60 * 1000;   注释掉 1个小时无动作 掉线处理  20080813

  g_boMinimize: Boolean = True;//20071121 启动后最小化程序
//文字过滤
  boStartMsgFilterCheck: Boolean = False;  //是否文字过滤
  nMsgFilterType: Byte = 0; //文字处理的类型
  sMsgFilterWarningMsg: string = '您发送的信息里包含了非法字符。';
//==============================================================================
//外挂控制相关变量  20081223
  SpeedCheckClass: string = 'SpeedCheck';
  boStartHookCheck: Boolean = True;  //是否启动了反外挂
  boStartWalkCheck: Boolean = False; //是否启动了走路控制
  boStartHitCheck: Boolean = False; //是否启动了攻击控制
  boStartRunCheck: Boolean = False; //是否启动了跑步控制
  boStartSpellCheck: Boolean = False; //是否启动了魔法控制
  boStartWarning: Boolean = False; //是否开启加密提示
  boStartEatCheck: Boolean = False;//是否开启吃药控制
  boStartOtherCheck: Boolean = True;//是否开启其它操作控制
  boStartPickUpCheck: Boolean = False;//是否开启捡物品控制
  boStartButchCheck: Boolean = False;//是否开启挖肉控制
  boStartTurnCheck: Boolean = False;//是否开启转身控制
  nIncErrorCount: Integer = 5; //每次加速的累加值
  nDecErrorCount: Integer = 1; //正常动作的减少值
  dwHitTime: LongWord = 600; //攻击间隔时间
  dwWalkTime: LongWord = 550; //走路间隔时间
  dwRunTime: LongWord = 600; //跑步间隔时间
  dwEatTime: LongWord = 300;//吃药间隔时间
  dwPickUpTime: LongWord = 200;//捡物品间隔时间
  dwButchTime: LongWord = 300;//是否开启挖肉控制
  dwTurnTime: LongWord = 100;//是否开启转身控制
  dwItemSpeed: LongWord = 60;//装备加速因数
  btWarningMsgFColor: Byte = 251; //外挂 文字颜色
  btWarningMsgBColor: Byte = 56; //外挂 背景颜色
  btWarningMsgType: Byte; //消息提示类型
  btPunishType: Byte; //消息处理类型
  sErrMsg: string = '[提示]: 请爱护游戏环境，关闭加速外挂重新登陆';
  {/****************************************************************/}
  //技能变量相关
  dwSKILL_1:  LongWord = 1000;//火球术
  dwSKILL_2:  LongWord = 1000;//治愈术
  dwSKILL_5:  LongWord = 1000;//大火球
  dwSKILL_6:  LongWord = 1000;//施毒术
  dwSKILL_8:  LongWord = 1000;//抗拒火环
  dwSKILL_9:  LongWord = 1000;//地狱火
  dwSKILL_10: LongWord = 1000;//疾光电影
  dwSKILL_11: LongWord = 1000;//雷电术
  dwSKILL_13: LongWord = 1000;//灵魂火符
  dwSKILL_14: LongWord = 1000;//幽灵盾
  dwSKILL_15: LongWord = 1000;//神圣战甲术
  dwSKILL_16: LongWord = 1000;//困魔咒
  dwSKILL_17: LongWord = 1000;//召唤骷髅
  dwSKILL_18: LongWord = 1000;//隐身术
  dwSKILL_19: LongWord = 1000;//集体隐身术
  dwSKILL_20: LongWord = 1000;//诱惑之光
  dwSKILL_21: LongWord = 1000;//瞬息移动
  dwSKILL_22: LongWord = 1000;//火墙
  dwSKILL_23: LongWord = 1000;//爆裂火焰
  dwSKILL_24: LongWord = 1000;//地狱雷光
  dwSKILL_27: LongWord = 1000;//野蛮冲撞
  dwSKILL_28: LongWord = 1000;//心灵启示
  dwSKILL_29: LongWord = 1000;//群体治疗术
  dwSKILL_30: LongWord = 1000;//召唤神兽
  dwSKILL_32: LongWord = 1000;//圣言术
  dwSKILL_33: LongWord = 1000;//冰咆哮
  dwSKILL_34: LongWord = 1000;//解毒术
  dwSKILL_35: LongWord = 1000;//狮吼功
  dwSKILL_36: LongWord = 1000;//火焰冰
  dwSKILL_37: LongWord = 1000;//群体雷电术
  dwSKILL_38: LongWord = 1000;//群体施毒术
  dwSKILL_39: LongWord = 1000;//彻地钉
  dwSKILL_41: LongWord = 1000;//狮子吼
  dwSKILL_44: LongWord = 1000;//寒冰掌
  dwSKILL_45: LongWord = 1000;//灭天火
  dwSKILL_46: LongWord = 1000;//分身术
  dwSKILL_47: LongWord = 1000;//火龙焰
  dwSKILL_48: LongWord = 1000;//气功波
  dwSKILL_49: LongWord = 1000;//净化术
  dwSKILL_50: LongWord = 1000;//无极真气
  dwSKILL_51: LongWord = 1000;//飓风破
  dwSKILL_52: LongWord = 1000;//诅咒术
  dwSKILL_53: LongWord = 1000;//血咒
  dwSKILL_54: LongWord = 1000;//骷髅咒
  dwSKILL_55: LongWord = 1000;//擒龙手
  dwSKILL_56: LongWord = 1000;//乾坤大挪移
  dwSKILL_57: LongWord = 1000;//复活术
  dwSKILL_58: LongWord = 1000;//流星火雨
  dwSKILL_59: LongWord = 1000;//噬血术
  dwSKILL_71: LongWord = 1000;//召唤圣兽
  dwSKILL_72: LongWord = 1000;//召唤月灵
  {/****************************************************************/}
  ColorTable: array[0..255] of TRGBQuad;
  ColorArray: array[0..1023] of Byte = (
    $00, $00, $00, $00, $00, $00, $80, $00, $00, $80, $00, $00, $00, $80, $80, $00,
    $80, $00, $00, $00, $80, $00, $80, $00, $80, $80, $00, $00, $C0, $C0, $C0, $00,
    $97, $80, $55, $00, $C8, $B9, $9D, $00, $73, $73, $7B, $00, $29, $29, $2D, $00,
    $52, $52, $5A, $00, $5A, $5A, $63, $00, $39, $39, $42, $00, $18, $18, $1D, $00,
    $10, $10, $18, $00, $18, $18, $29, $00, $08, $08, $10, $00, $71, $79, $F2, $00,
    $5F, $67, $E1, $00, $5A, $5A, $FF, $00, $31, $31, $FF, $00, $52, $5A, $D6, $00,
    $00, $10, $94, $00, $18, $29, $94, $00, $00, $08, $39, $00, $00, $10, $73, $00,
    $00, $18, $B5, $00, $52, $63, $BD, $00, $10, $18, $42, $00, $99, $AA, $FF, $00,
    $00, $10, $5A, $00, $29, $39, $73, $00, $31, $4A, $A5, $00, $73, $7B, $94, $00,
    $31, $52, $BD, $00, $10, $21, $52, $00, $18, $31, $7B, $00, $10, $18, $2D, $00,
    $31, $4A, $8C, $00, $00, $29, $94, $00, $00, $31, $BD, $00, $52, $73, $C6, $00,
    $18, $31, $6B, $00, $42, $6B, $C6, $00, $00, $4A, $CE, $00, $39, $63, $A5, $00,
    $18, $31, $5A, $00, $00, $10, $2A, $00, $00, $08, $15, $00, $00, $18, $3A, $00,
    $00, $00, $08, $00, $00, $00, $29, $00, $00, $00, $4A, $00, $00, $00, $9D, $00,
    $00, $00, $DC, $00, $00, $00, $DE, $00, $00, $00, $FB, $00, $52, $73, $9C, $00,
    $4A, $6B, $94, $00, $29, $4A, $73, $00, $18, $31, $52, $00, $18, $4A, $8C, $00,
    $11, $44, $88, $00, $00, $21, $4A, $00, $10, $18, $21, $00, $5A, $94, $D6, $00,
    $21, $6B, $C6, $00, $00, $6B, $EF, $00, $00, $77, $FF, $00, $84, $94, $A5, $00,
    $21, $31, $42, $00, $08, $10, $18, $00, $08, $18, $29, $00, $00, $10, $21, $00,
    $18, $29, $39, $00, $39, $63, $8C, $00, $10, $29, $42, $00, $18, $42, $6B, $00,
    $18, $4A, $7B, $00, $00, $4A, $94, $00, $7B, $84, $8C, $00, $5A, $63, $6B, $00,
    $39, $42, $4A, $00, $18, $21, $29, $00, $29, $39, $46, $00, $94, $A5, $B5, $00,
    $5A, $6B, $7B, $00, $94, $B1, $CE, $00, $73, $8C, $A5, $00, $5A, $73, $8C, $00,
    $73, $94, $B5, $00, $73, $A5, $D6, $00, $4A, $A5, $EF, $00, $8C, $C6, $EF, $00,
    $42, $63, $7B, $00, $39, $56, $6B, $00, $5A, $94, $BD, $00, $00, $39, $63, $00,
    $AD, $C6, $D6, $00, $29, $42, $52, $00, $18, $63, $94, $00, $AD, $D6, $EF, $00,
    $63, $8C, $A5, $00, $4A, $5A, $63, $00, $7B, $A5, $BD, $00, $18, $42, $5A, $00,
    $31, $8C, $BD, $00, $29, $31, $35, $00, $63, $84, $94, $00, $4A, $6B, $7B, $00,
    $5A, $8C, $A5, $00, $29, $4A, $5A, $00, $39, $7B, $9C, $00, $10, $31, $42, $00,
    $21, $AD, $EF, $00, $00, $10, $18, $00, $00, $21, $29, $00, $00, $6B, $9C, $00,
    $5A, $84, $94, $00, $18, $42, $52, $00, $29, $5A, $6B, $00, $21, $63, $7B, $00,
    $21, $7B, $9C, $00, $00, $A5, $DE, $00, $39, $52, $5A, $00, $10, $29, $31, $00,
    $7B, $BD, $CE, $00, $39, $5A, $63, $00, $4A, $84, $94, $00, $29, $A5, $C6, $00,
    $18, $9C, $10, $00, $4A, $8C, $42, $00, $42, $8C, $31, $00, $29, $94, $10, $00,
    $10, $18, $08, $00, $18, $18, $08, $00, $10, $29, $08, $00, $29, $42, $18, $00,
    $AD, $B5, $A5, $00, $73, $73, $6B, $00, $29, $29, $18, $00, $4A, $42, $18, $00,
    $4A, $42, $31, $00, $DE, $C6, $63, $00, $FF, $DD, $44, $00, $EF, $D6, $8C, $00,
    $39, $6B, $73, $00, $39, $DE, $F7, $00, $8C, $EF, $F7, $00, $00, $E7, $F7, $00,
    $5A, $6B, $6B, $00, $A5, $8C, $5A, $00, $EF, $B5, $39, $00, $CE, $9C, $4A, $00,
    $B5, $84, $31, $00, $6B, $52, $31, $00, $D6, $DE, $DE, $00, $B5, $BD, $BD, $00,
    $84, $8C, $8C, $00, $DE, $F7, $F7, $00, $18, $08, $00, $00, $39, $18, $08, $00,
    $29, $10, $08, $00, $00, $18, $08, $00, $00, $29, $08, $00, $A5, $52, $00, $00,
    $DE, $7B, $00, $00, $4A, $29, $10, $00, $6B, $39, $10, $00, $8C, $52, $10, $00,
    $A5, $5A, $21, $00, $5A, $31, $10, $00, $84, $42, $10, $00, $84, $52, $31, $00,
    $31, $21, $18, $00, $7B, $5A, $4A, $00, $A5, $6B, $52, $00, $63, $39, $29, $00,
    $DE, $4A, $10, $00, $21, $29, $29, $00, $39, $4A, $4A, $00, $18, $29, $29, $00,
    $29, $4A, $4A, $00, $42, $7B, $7B, $00, $4A, $9C, $9C, $00, $29, $5A, $5A, $00,
    $14, $42, $42, $00, $00, $39, $39, $00, $00, $59, $59, $00, $2C, $35, $CA, $00,
    $21, $73, $6B, $00, $00, $31, $29, $00, $10, $39, $31, $00, $18, $39, $31, $00,
    $00, $4A, $42, $00, $18, $63, $52, $00, $29, $73, $5A, $00, $18, $4A, $31, $00,
    $00, $21, $18, $00, $00, $31, $18, $00, $10, $39, $18, $00, $4A, $84, $63, $00,
    $4A, $BD, $6B, $00, $4A, $B5, $63, $00, $4A, $BD, $63, $00, $4A, $9C, $5A, $00,
    $39, $8C, $4A, $00, $4A, $C6, $63, $00, $4A, $D6, $63, $00, $4A, $84, $52, $00,
    $29, $73, $31, $00, $5A, $C6, $63, $00, $4A, $BD, $52, $00, $00, $FF, $10, $00,
    $18, $29, $18, $00, $4A, $88, $4A, $00, $4A, $E7, $4A, $00, $00, $5A, $00, $00,
    $00, $88, $00, $00, $00, $94, $00, $00, $00, $DE, $00, $00, $00, $EE, $00, $00,
    $00, $FB, $00, $00, $94, $5A, $4A, $00, $B5, $73, $63, $00, $D6, $8C, $7B, $00,
    $D6, $7B, $6B, $00, $FF, $88, $77, $00, $CE, $C6, $C6, $00, $9C, $94, $94, $00,
    $C6, $94, $9C, $00, $39, $31, $31, $00, $84, $18, $29, $00, $84, $00, $18, $00,
    $52, $42, $4A, $00, $7B, $42, $52, $00, $73, $5A, $63, $00, $F7, $B5, $CE, $00,
    $9C, $7B, $8C, $00, $CC, $22, $77, $00, $FF, $AA, $DD, $00, $2A, $B4, $F0, $00,
    $9F, $00, $DF, $00, $B3, $17, $E3, $00, $F0, $FB, $FF, $00, $A4, $A0, $A0, $00,
    $80, $80, $80, $00, $00, $00, $FF, $00, $00, $FF, $00, $00, $00, $FF, $FF, $00,
    $FF, $00, $00, $00, $FF, $00, $FF, $00, $FF, $FF, $00, $00, $FF, $FF, $FF, $00
    );  
implementation

procedure AddMainLogMsg(Msg: string; nLevel: Integer);
var
  tMsg: string;
begin
  try
    CS_MainLog.Enter;
    if nLevel <= nShowLogLevel then begin
      tMsg := '[' + TimeToStr(Now) + '] ' + Msg;
      MainLogMsgList.Add(tMsg);
    end;
  finally
    CS_MainLog.Leave;
  end;
end;
procedure LoadAbuseFile();
var
  sFileName: string;
begin
  AddMainLogMsg('正在加载文字过滤配置信息...', 4);
  sFileName := '.\WordFilter.txt';
  if FileExists(sFileName) then begin
    try
      CS_FilterMsg.Enter;
      AbuseList.LoadFromFile(sFileName);
    finally
      CS_FilterMsg.Leave;
    end;
  end;
  AddMainLogMsg('文字过滤信息加载完成...', 4);
end;

procedure LoadBlockIPFile();
var
  I, nIPaddr: Integer;
  sFileName, sIPaddr: string;
  LoadList: TStringList;
  IPaddr: pTSockaddr;
begin
  AddMainLogMsg('正在加载IP过滤配置信息...', 4);
  sFileName := '.\BlockIPList.txt';
  if FileExists(sFileName) then begin
    LoadList := TStringList.Create;
    BlockIPList.Lock;
    Try
      LoadList.LoadFromFile(sFileName);
      BlockIPList.Clear;
      for I := 0 to LoadList.Count - 1 do begin
        sIPaddr := Trim(LoadList.Strings[I]);
        if sIPaddr = '' then Continue;
        nIPaddr := inet_addr(PChar(sIPaddr));
        if nIPaddr = INADDR_NONE then Continue;
        New(IPaddr);
        FillChar(IPaddr^, SizeOf(TSockaddr), 0);
        IPaddr^.nIPaddr := nIPaddr;
        IPaddr^.sIPDate := SearchIPLocal(sIPaddr);
        BlockIPList.Add(IPaddr);
      end;
    finally
      BlockIPList.UnLock;
      LoadList.Free;
    end;
  end;
  AddMainLogMsg('IP过滤配置信息加载完成...', 4);
end;

procedure SaveBlockIPList();
var
  I: Integer;
  SaveList: TStringList;
begin
  SaveList := TStringList.Create;
  try
    for I := 0 to BlockIPList.Count - 1 do begin
      SaveList.Add(StrPas(inet_ntoa(TInAddr(pTSockaddr(BlockIPList.Items[I]).nIPaddr))));
    end;
    SaveList.SaveToFile('.\BlockIPList.txt');
  finally
    SaveList.Free;
  end;
end;
//查询IP所属地址  20080414
function SearchIPLocal(sIPaddr: string): string;
var
  QQWry: TQQWry;
  IPRecordID: int64;
  IPData: TStringlist;
begin
  try
    QQWry := TQQWry.Create(sIPFileName);
    IPRecordID := QQWry.GetIPDataID(sIPaddr);
    IPData := TStringlist.Create;
    QQWry.GetIPDataByIPRecordID(IPRecordID, IPData);
    QQWry.Destroy;
    Result := Trim(IPData.Strings[2]) + Trim(IPData.Strings[3]);
    IPData.Free;
  except
    Result := '';
  end;
end;

constructor TGList.Create;
begin
  inherited Create;
  InitializeCriticalSection(GLock);
end;

destructor TGList.Destroy;
begin
  DeleteCriticalSection(GLock);
  inherited;
end;

procedure TGList.Lock;
begin
  EnterCriticalSection(GLock);
end;

procedure TGList.UnLock;
begin
  LeaveCriticalSection(GLock);
end;
function GetRGB(c256: Byte): TColor;
begin
  Result := RGB(ColorTable[c256].rgbRed, ColorTable[c256].rgbGreen, ColorTable[c256].rgbBlue);
end;

initialization
  begin
    Conf := TIniFile.Create(sConfigFileName);
    nShowLogLevel := Conf.ReadInteger(GateClass, 'ShowLogLevel', nShowLogLevel);

    MainLogMsgList := TStringList.Create;
    AbuseList := TStringList.Create;
    ReviceMsgList := TList.Create;
    //SendMsgList := TList.Create;
    CS_MainLog := TCriticalSection.Create;
    CS_FilterMsg := TCriticalSection.Create;
    Move(ColorArray, ColorTable, SizeOf(ColorArray));
  end;

finalization
  begin
    ReviceMsgList.Free;
    //SendMsgList.Free;
    MainLogMsgList.Free;
    CS_MainLog.Free;
    AbuseList.Free;
    CS_FilterMsg.Free;
    Conf.Free;
  end;

end.

