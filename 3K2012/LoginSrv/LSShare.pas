unit LSShare;

interface
uses
  Windows, Messages, Classes, SysUtils, WinSock, SyncObjs, MudUtil, IniFiles, Grobal2, SDK, Common;
const
  IDMODE = 0;//0-文件数据库模式 1-SQL数据库模式
  {$IF IDMODE = 1}
  g_sProductName = '84E109FD42D09E2B4A339DCE8D5BE81CB27D4FD38C10D7C814D293CE5F761879'; //3K科技帐号服务程序[SQL版]
  {$ELSE}
  g_sProductName = 'E3A0C0E13627B3B0B27D4FD38C10D7C88BC9ED2FECE443BB'; //3K科技帐号服务程序
  {$IFEND}
  g_sVersion = '4D8B003419EF61192F344FC7EADF5DF9C5C3C9374D92394E';  //2.00 Build 20121212
  g_sUpDateTime = '0A19BD8D3E7F9844CF3ABB7DBC68FB4D'; //2012/12/12
  g_sProgram = 'BF329B13CBE9010C601B4C1E88011620'; //3K科技
  g_sWebSite = '92A51ADA62A0738AC5DB86D6E7E9CDE140574B5A981AB1753188062D144466D7'; // http://www.3KM2.com(官网站)
  g_sBbsSite = '6136601E4431B32C60BFBF8207DB95FA40574B5A981AB1753188062D144466D7'; //http://www.3KM2.net(程序站)

  tLoginSrv = 1;
  MAXGATEROUTE = 60;
type
  TSockaddr = record
    nIPaddr: Integer;
    dwStartAttackTick: LongWord;
    nAttackCount: Integer;
  end;
  pTSockaddr = ^TSockaddr;

  TAccountCostRcd = record
    sAccount: string[10];//账号
    nAccountCost: Integer;//分钟
    nCostType: byte;//充值类型
    boEnable: Boolean;//是否启用
    CreateDate: TDateTime;//创建日期
  end;
  pTAccountCostRcd = ^TAccountCostRcd;

  TGateNet = record
    sIPaddr: string;//RUN网关IP
    nPort: Integer;//端口
    boEnable: Boolean;//是否可用
  end;
  TGateRoute = record
    sServerName: string;
    boCanConnet : Boolean;//能够连接 By TasNat at: 2012-03-13 18:15:19
    sTitle: string;
    sRemoteAddr: string;//远程IP
    sPublicAddr: string;
    nSelIdx: Integer;//角色网关索引
    Gate: array[0..9] of TGateNet;//Run网关相关信息
  end;
  TConfig = record
    IniConf: TIniFile;
    boRemoteClose: Boolean;
    sDBServer: string[30]; //0x00475368
    nDBSPort: Integer; //0x00475374
    sFeeServer: string[30]; //0x0047536C
    nFeePort: Integer; //0x00475378
    sLogServer: string[30]; //0x00475370
    nLogPort: Integer; //0x0047537C
    sGateAddr: string[30];
    nGatePort: Integer;
    sServerAddr: string[30];
    nServerPort: Integer;
    sMonAddr: string[30];
    nMonPort: Integer;
    sGateIPaddr: string[30]; //当前处理的网关连接IP地址
    {$IF IDMODE = 1}
    g_sSQLDatabase:     String[50];
    g_sSQLHost:         String[30];
    g_sSQLUserName:     String[20];
    g_sSQLPassword:     String[20];
    {$ELSE}
    sIdDir: string[50];
    sWebLogDir: string[50];
    {$IFEND}
    sFeedIDList: string[50];
    sFeedIPList: string[50];
    sCountLogDir: string[50];
    sChrLogDir: string[50];
    boTestServer: Boolean;
    boEnableMakingID: Boolean;
    boCanSameAcctAndPsd:Boolean;
    boEnableGetbackPassword: Boolean;
    boEnabledTestSelGate: Boolean;
    boAutoClearID: Boolean;
    dwAutoClearTime: LongWord;
    dwClearKickSessionTime: LongWord;
    boUnLockAccount: Boolean;
    dwUnLockAccountTime: LongWord;
    boDynamicIPMode: Boolean;
    nReadyServers: Integer;

    GateCriticalSection: TRTLCriticalSection;
    GateList: TList;
    SessionList: TGList;
    ServerNameList: TStringList;
    AccountCostList: TStringList;
    IPaddrCostList: TQuickList;
    boShowDetailMsg: Boolean;
    boMinimize:Boolean;
    //boRandomCode:Boolean; //20080614 去掉验证码功能
    dwProcessGateTick: LongWord; //0x00475380
    dwProcessGateTime: LongWord; //0x00475384
    nRouteCount: Integer; //0x47328C
    GateRoute: array[0..MAXGATEROUTE - 1] of TGateRoute;

  end;
  pTConfig = ^TConfig;
function GetCodeMsgSize(X: Double): Integer;
function CheckAccountName(sName: string): Boolean;
function NewIdCheckBirthDay(sBirthDay: String): Boolean;//检查新建ID的生日数据是否正确，防乱码使用 20090512
function GetSessionID(): Integer;
procedure SaveGateConfig(Config: pTConfig);
function GetGatePublicAddr(Config: pTConfig; sGateIP: string): string;
function GenSpaceString(sStr: string; nSpaceCOunt: Integer): string;
procedure MainOutMessage(sMsg: string);
procedure SendGameCenterMsg(wIdent: Word; sSendMsg: string);

function CheckIsIpAddr(Name: string): Boolean;//检查IP地址格式是否合法 20100405
function HostToIP(Name: string): String;//域名转IP 20100405

procedure LoadDBSetup;
var
  g_Config: TConfig = (boRemoteClose: False;
    sDBServer: '127.0.0.1';
    nDBSPort: 16300;
    sFeeServer: '127.0.0.1';
    nFeePort: 16301;
    sLogServer: '127.0.0.1';
    nLogPort: 16301;
    sGateAddr: '0.0.0.0';
    nGatePort: 5500;
    sServerAddr: '0.0.0.0';
    nServerPort: 5600;
    sMonAddr: '0.0.0.0';
    nMonPort: 3000;
    {$IF IDMODE = 1}
    g_sSQLDatabase:'mir2';
    g_sSQLHost:'.';
    g_sSQLUserName:'mir2';
    g_sSQLPassword:'';
    {$ELSE}
    sIdDir: '.\DB\'; //0x00470D04
    sWebLogDir: '.\Share\'; //0x00470D08
    {$IFEND}
    sFeedIDList: '.\FeedIDList.txt'; //ID充值列表
    sFeedIPList: '.\FeedIPList.txt'; //IP充值列表
    sCountLogDir: '.\CountLog\'; //0x00470D14
    sChrLogDir: '.\ChrLog\';
    boTestServer: true;
    boEnableMakingID: true;
    boCanSameAcctAndPsd:true;
    boEnableGetbackPassword: true;
    boAutoClearID: true;
    dwAutoClearTime: 1000;
    dwClearKickSessionTime: 0;
    boUnLockAccount: False;
    dwUnLockAccountTime: 10;
    boDynamicIPMode: False;
    nReadyServers: 0;
    boShowDetailMsg: False;
    boMinimize: true;
    //boRandomCode: False; //20080614 去掉验证码功能
    );
  {$IF IDMODE = 1}
  g_sSQLString :String;//SQL连接串
  {$IFEND}
  //StringList_0: TStringList; //0x0047538C
  nOnlineCountMin: Integer; //0x00475390
  nOnlineCountMax: Integer; //0x00475394
  nMemoHeigh: Integer; //0x00475398
  g_OutMessageCS: TRTLCriticalSection;
  g_MainMsgList: TStringList; //0x0047539C
  CS_DB: TCriticalSection; //0x004753A0
  n4753A4: Integer; //0x004753A4
  n4753A8: Integer; //0x004753A8
  n4753B0: Integer; //0x004753B0

  n47328C: Integer;

  g_nSessionIdx: Integer; //0x00473294

  g_n472A6C: Integer;
  g_n472A70: Integer;
  g_n472A74: Integer;
  g_boDataDBReady: Boolean; //0x00472A78
  bo470D20: Boolean;

  nVersionDate: Integer = 20011006;//版本号

  ServerAddr: array[0..MAXGATEROUTE - 1] of string[15];
  g_dwGameCenterHandle: THandle;
implementation
uses HUtil32{$IF IDMODE = 1}, EDcodeUnit{$IFEND};

function GetCodeMsgSize(X: Double): Integer;
begin
  if INT(X) < X then Result := TRUNC(X) + 1
  else Result := TRUNC(X)
end;
//检查账号名是否合法(新建账号时使用)
function CheckAccountName(sName: string): Boolean;
var
  I: Integer;
  nLen: Integer;
begin
  Result := False;
  if sName = '' then Exit;
  Result := true;
  nLen := length(sName);
  I := 1;
  while (true) do begin
    if I > nLen then break;
    if (sName[I] < '0') or (sName[I] > 'z') then begin
      Result := False;
      if (sName[I] >= #$B0) and (sName[I] <= #$C8) then begin //#表示转换成字符 $B0-16进制编码
        Inc(I);
        if I <= nLen then
          if (sName[I] >= #$A1) and (sName[I] <= #$FE) then Result := true;
      end;
      if not Result then break;
    end;
    Inc(I);
  end;
end;

//检查新建ID的生日数据是否正确，防乱码使用 20090512
function NewIdCheckBirthDay(sBirthDay: String): Boolean;
var
   str, syear, smon, sday: string;
   ayear, amon, aday: integer;
   flag: Boolean;
begin
   Result := TRUE;
   flag := TRUE;
   str := sBirthDay;
   str := GetValidStr3 (str, syear, ['/']);
   str := GetValidStr3 (str, smon, ['/']);
   str := GetValidStr3 (str, sday, ['/']);
   ayear := Str_ToInt(syear, 0);
   amon := Str_ToInt(smon, 0);
   aday := Str_ToInt(sday, 0);
   if (ayear <= 1890) or (ayear > 2101) then flag := FALSE;
   if (amon <= 0) or (amon > 12) then flag := FALSE;
   if (aday <= 0) or (aday > 31) then flag := FALSE;
   if not flag then Result := FALSE;
end;

//制造会话ID
function GetSessionID(): Integer;
begin
  Inc(g_nSessionIdx);
  if g_nSessionIdx >= High(Integer) then begin
    g_nSessionIdx := 2;
  end;
  Result := g_nSessionIdx;
end;

//0046D4F4
procedure SaveGateConfig(Config: pTConfig);
var
  SaveList: TStringList;
  I, n8: Integer;
  s10, sC: string;
begin
  SaveList := TStringList.Create;
  try
    SaveList.Add(';No space allowed');
    SaveList.Add(GenSpaceString(';Server', 15) + GenSpaceString('Title', 15) + GenSpaceString('Remote', 17) + GenSpaceString('Public', 17) + 'Gate...');
    for I := 0 to Config.nRouteCount - 1 do begin
      sC := GenSpaceString(Config.GateRoute[I].sServerName, 15) + GenSpaceString(Config.GateRoute[I].sTitle, 15) + GenSpaceString(Config.GateRoute[I].sRemoteAddr, 17) + GenSpaceString(Config.GateRoute[I].sPublicAddr, 17);
      n8 := 0;
      while (true) do begin
        s10 := Config.GateRoute[I].Gate[n8].sIPaddr;
        if s10 = '' then break;
        if not Config.GateRoute[I].Gate[n8].boEnable then
          s10 := '*' + s10;
        s10 := s10 + ':' + IntToStr(Config.GateRoute[I].Gate[n8].nPort);
        sC := sC + GenSpaceString(s10, 17);
        Inc(n8);
        if n8 >= 10 then break;
      end;
      SaveList.Add(sC);
    end;
    SaveList.SaveToFile('.\!addrtable.txt');
  finally
    SaveList.Free;
  end;  
end;

function GetGatePublicAddr(Config: pTConfig; sGateIP: string): string;
var
  I: Integer;
  sGate: string;
begin
  Result := ''{sGateIP};
  for I := 0 to Config.nRouteCount - 1 do begin
    {if Config.GateRoute[I].sRemoteAddr = sGateIP then begin
      Result := Config.GateRoute[I].sPublicAddr;
      break;
    end; }
    if CheckIsIpAddr(Config.GateRoute[I].sRemoteAddr) then begin//检查IP是否合法，如为域名则转换为IP 20100408
      sGate:= Config.GateRoute[I].sRemoteAddr;
    end else begin
      sGate:= HostToIP(Config.GateRoute[I].sRemoteAddr);
    end;
    if sGate = sGateIP then begin
      if CheckIsIpAddr(Config.GateRoute[I].sPublicAddr) then begin//检查IP是否合法，如为域名则转换为IP 20100408
        Result := Config.GateRoute[I].sPublicAddr;
      end else begin
        Result := HostToIP(Config.GateRoute[I].sPublicAddr);
      end;
      break;
    end;
  end;
end;

function GenSpaceString(sStr: string; nSpaceCOunt: Integer): string;
var
  I: Integer;
begin
  Result := sStr + ' ';
  for I := 1 to nSpaceCOunt - length(sStr) do begin
    Result := Result + ' ';
  end;
end;

procedure MainOutMessage(sMsg: string);
begin
  EnterCriticalSection(g_OutMessageCS);
  try
    g_MainMsgList.Add(sMsg)
  finally
    LeaveCriticalSection(g_OutMessageCS);
  end;
end;

procedure SendGameCenterMsg(wIdent: Word; sSendMsg: string);
var
  SendData: TCopyDataStruct;
  nParam: Integer;
begin
  nParam := MakeLong(Word(tLoginSrv), wIdent);
  SendData.cbData := length(sSendMsg) + 1;
  GetMem(SendData.lpData, SendData.cbData);
  StrCopy(SendData.lpData, PChar(sSendMsg));
  SendMessage(g_dwGameCenterHandle, WM_COPYDATA, nParam, Cardinal(@SendData));
  FreeMem(SendData.lpData);
end;

//检查IP地址格式是否合法 20100405
function CheckIsIpAddr(Name: string): Boolean;
var
  PStr: char;
  Temp: PChar;
  I: integer;
begin
  Result := True;
  if Length(Name) <= 15 then begin
    for I := 0 to Length(Name) do begin
      Temp := PChar(copy(Name, I, 1));
      PStr := Temp^;
      if not (PStr in ['0'..'9', '.']) then begin
        Result := False;
        break
      end;
    end;
  end else Result := False;
end;

//域名转IP 20100405
function HostToIP(Name: string): String;
var
  wsdata : TWSAData;
  hostName : array [0..255] of char;
  hostEnt : PHostEnt;
  addr : PChar;
begin
  Result := '';
  WSAStartup ($0101, wsdata);
  try
    gethostname (hostName, sizeof (hostName));
    StrPCopy(hostName, Name);
    hostEnt := gethostbyname (hostName);
    if Assigned (hostEnt) then
      if Assigned (hostEnt^.h_addr_list) then begin
        addr := hostEnt^.h_addr_list^;
        if Assigned (addr) then begin
          Result := Format ('%d.%d.%d.%d', [byte(addr [0]),byte(addr [1]), byte(addr [2]),byte(addr [3])]);
        end;
    end;
  finally
    WSACleanup;
  end
end;

procedure LoadDBSetup;
begin
  {$IF IDMODE = 1}
  g_sSQLString := format('Provider=SQLOLEDB.1;Password=%s;Persist Security Info=True;'
                        +'User ID=%s;Initial Catalog=%s;Data Source=%s',[Base64DecodeStr(g_Config.g_sSQLPassword), g_Config.g_sSQLUserName, g_Config.g_sSQLDatabase, g_Config.g_sSQLHost]);
  {$IFEND}
end;

initialization
  begin
    InitializeCriticalSection(g_OutMessageCS);
    //InitializeCriticalSection(g_Config.GateCriticalSection);
    g_MainMsgList := TStringList.Create;
  end;
finalization
  begin
    g_MainMsgList.Free;
    //DeleteCriticalSection(g_Config.GateCriticalSection);
    DeleteCriticalSection(g_OutMessageCS);
  end;
end.
