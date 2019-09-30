unit GateShare;

interface
uses
  Windows, Messages, Classes, SysUtils, JSocket, WinSock, SyncObjs;
const
  GATEMAXSESSION = 10000;
  g_sProductName = '8619A7A04D9B35A0D2485D9782594BED7FCD5470F6308880'; //3K科技角色网关
  g_sVersion = '4D8B003419EF61192F344FC7EADF5DF9C5C3C9374D92394E';  //2.00 Build 20121212
  g_sUpDateTime = '0A19BD8D3E7F9844CF3ABB7DBC68FB4D'; //2012/12/12
  g_sProgram = 'BF329B13CBE9010C601B4C1E88011620'; //3K科技
  g_sWebSite = '92A51ADA62A0738AC5DB86D6E7E9CDE140574B5A981AB1753188062D144466D7'; // http://www.3KM2.com(官网站)
  g_sBbsSite = '6136601E4431B32C60BFBF8207DB95FA40574B5A981AB1753188062D144466D7'; //http://www.3KM2.net(程序站)

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
    nAttackCount: Integer;
    dwStartAttackTick: LongWord;
    nSocketHandle: Integer;
  end;
  pTSockaddr = ^TSockaddr;

procedure LoadBlockIPFile();
procedure SendGameCenterMsg(wIdent: Word; sSendMsg: string);
procedure SaveBlockIPList();
var
  CS_MainLog: TCriticalSection;
  CS_FilterMsg: TCriticalSection;
  MainLogMsgList: TStringList;
  BlockIPList: TGList;
  TempBlockIPList: TGList;
  CurrIPaddrList: TGList;
  {CurrIPaddrArray:array [0..GATEMAXSESSION - 1] of Integer;
  nSocketCount:Integer = 0;}
  AttackIPaddrList: TGList;
  nIPCountLimit: Integer = 20;
  //nIPCountLimit2              :Integer = 40;
  nShowLogLevel: Integer = 3;
  StringList456A14: TStringList;
  GateClass: string = 'SelGate';
  GateName: string = '角色网关';
  TitleName: string = '3K科技';
  ServerPort: Integer = 5100;     //连接DBSERVER的端口
  ServerAddr: string = '127.0.0.1';
  GatePort: Integer = 7100;       //连接客户端的端口
  GateAddr: string = '0.0.0.0';

  boGateReady: Boolean = False;
  boShowMessage: Boolean;
  boStarted: Boolean = False;
  boClose: Boolean = False;
  boServiceStart: Boolean = False;
  dwKeepAliveTick: LongWord;
  boKeepAliveTimcOut: Boolean = False;
  nSendMsgCount: Integer;
  n456A2C: Integer;
  n456A30: Integer;
  boSendHoldTimeOut: Boolean;
  dwSendHoldTick: LongWord;
  boDecodeLock: Boolean;
  nMaxConnOfNoLegal: Integer = 5;//单IP最大非法连接次数 20091121
  nMaxConnOfIPaddr: Integer = 10;//20081215 单IP最大连接数
  BlockMethod: TBlockIPMethod = mBlock;
  dwKeepConnectTimeOut: LongWord = 120000{60 * 1000};//20081215
  g_boDynamicIPDisMode: Boolean = False; //用于动态IP，分机放置登录网关用，打开此模式后，网关将会把连接登录服务器的IP地址，当为服务器IP，发给登录服务器，客户端将直接使用此IP连接角色网关
  g_dwGameCenterHandle: THandle;
  g_sNowStartGate: string = '正在启动角色网关...';
  g_sNowStartOK: string = '启动角色网关完成...';

  UseBlockMethod: TBlockIPMethod;
  nUseAttackLevel: Integer;

  dwAttackTime: LongWord = 800{100};//20091121
  nAttackCount: Integer = 5;
  nReviceMsgLength: Integer = 380; //每MS允许接受的长度，超过即认为是攻击
  dwReviceTick: LongWord = 500;
  g_nAttackLevel: Integer = 1;
  nMaxClientMsgCount: Integer = 1;
  m_nAttackCount: Integer = 0;
  m_dwAttackTick: LongWord = 0;

  g_boMinimize: Boolean = True;
  g_boChgDefendLevel: Boolean = True;//自动调整防御等级
  g_nChgDefendLevel:Integer = 3; //被攻击的次数
  g_boClearTempList: Boolean = True;
  g_dwClearTempList: LongWord = 120;
  g_boReliefDefend: Boolean = True;//还原防御
  g_dwReliefDefend: LongWord = 120;//还原防御 等待时间
const
  tSelGate = 6;//20071222 修正,可以由启动器关闭,要和启动器的同名常量值一致
implementation

{----------------读取阻拦IP列表过程--------------------}
procedure LoadBlockIPFile();
var
  I: Integer;
  sFileName: string;
  LoadList: TStringList;
  sIPaddr: string;
  nIPaddr: Integer;
  IPaddr: pTSockaddr;
begin
  sFileName := '.\BlockIPList.txt';
  if FileExists(sFileName) then begin
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(sFileName);
    for I := 0 to LoadList.Count - 1 do begin
      sIPaddr := Trim(LoadList.Strings[0]);
      if sIPaddr = '' then Continue;
      nIPaddr := inet_addr(PChar(sIPaddr));
      if nIPaddr = INADDR_NONE then Continue;
      New(IPaddr);
      FillChar(IPaddr^, SizeOf(TSockaddr), 0);
      IPaddr.nIPaddr := nIPaddr;
      BlockIPList.Add(IPaddr);
    end;
    LoadList.Free;
  end;
end;
{--------------储存阻拦IP的过程-----------------}
procedure SaveBlockIPList();
var
  I: Integer;
  SaveList: TStringList;
begin
  SaveList := TStringList.Create;
  for I := 0 to BlockIPList.Count - 1 do begin
    SaveList.Add(StrPas(inet_ntoa(TInAddr(pTSockaddr(BlockIPList.Items[I]).nIPaddr))));
  end;
  SaveList.SaveToFile('.\BlockIPList.txt');
  SaveList.Free;
end;

procedure SendGameCenterMsg(wIdent: Word; sSendMsg: string);
var
  SendData: TCopyDataStruct;
  nParam: Integer;
begin
  nParam := MakeLong(Word(tSelGate), wIdent);
  SendData.cbData := Length(sSendMsg) + 1;
  GetMem(SendData.lpData, SendData.cbData);
  StrCopy(SendData.lpData, PChar(sSendMsg));
  SendMessage(g_dwGameCenterHandle, WM_COPYDATA, nParam, Cardinal(@SendData));
  FreeMem(SendData.lpData);
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

initialization
  begin
    CS_MainLog := TCriticalSection.Create;
    CS_FilterMsg := TCriticalSection.Create;
    MainLogMsgList := TStringList.Create;
  end;

finalization
  begin
    MainLogMsgList.Free;
    CS_MainLog.Free;
    CS_FilterMsg.Free;
  end;

end.

