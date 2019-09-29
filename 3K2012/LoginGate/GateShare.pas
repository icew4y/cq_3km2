unit GateShare;

interface
uses
  Windows, Messages, Classes, SysUtils, JSocket, WinSock, SyncObjs, QQWry, RC6, HUtil32;

const
  GATEMAXSESSION = 10000;//最大连接数
  SPECVERSION = 0; //1是商业版 20080831
  Testing = 0; //是否为测试模式
  
resourcestring
  g_sProductName = '8619A7A04D9B35A0D9EA5182C0ADA39D7FCD5470F6308880'; //3K科技登陆网关
  g_sVersion = '4D8B003419EF61192F344FC7EADF5DF9C5C3C9374D92394E';  //2.00 Build 20121212
  g_sUpDateTime = '0A19BD8D3E7F9844CF3ABB7DBC68FB4D'; //2012/12/12
  g_sProgram = 'BF329B13CBE9010C601B4C1E88011620'; //3K科技
  g_sWebSite = '92A51ADA62A0738AC5DB86D6E7E9CDE140574B5A981AB1753188062D144466D7'; // http://www.3KM2.com(官网站)
  g_sBbsSite = '6136601E4431B32C60BFBF8207DB95FA40574B5A981AB1753188062D144466D7'; //http://www.3KM2.net(程序站)
  g_sLogoStr = '74B195154C3E85FC0F4BAA0E74006F01D1208376AF71012275BCB46C94B43F11';//欢迎使用3K科技商业网关...

  sIPFileName      ='..\Mir200\IpList.db';//20080414 IP数据库路径
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
  //过滤的数据类型   IP+机器码 IP 机器码
  TBlockMethodData = (bdAll, bdIP, bdHC);
  TSockaddr = record
    nIPaddr: Integer;
    sIPaddr: string;//IP段 20081030
    sIPDate: string;//20080414 IP所属地址
    nAttackCount: Integer;
    dwStartAttackTick: LongWord;
    nSocketHandle: Integer;
  end;
  pTSockaddr = ^TSockaddr;
  
  {$IF SPECVERSION = 1}  //20080831
//自身信息记录
  TRecinfo = record
    sGatePass: string[34];
  end;
  {$IFEND}
procedure LoadBlockIPFile();
procedure LoadBlockHCFile();
procedure SaveBlockHCList();
procedure SendGameCenterMsg(wIdent: Word; sSendMsg: string);
procedure SaveBlockIPList();
function SearchIPLocal(sIPaddr: string): string;//查询IP所属地址  20080414
{$IF SPECVERSION = 1}
procedure ExtractInfo(const FilePath: string; var MyRecInfo: TRecInfo);
function ProgramPath: string;
function Encrypt(const s:string; skey:string):string;
function Decrypt(const s:string; skey:string):string;
function CertKey(key: string): string;
function GetAdoSouse(S: String): String;
function EncodeString_Rc6(Source, Key: string): string;
{$IFEND}
const
  tLoginGate = 4;
  {$IF SPECVERSION = 1}
  RecInfoSize = Sizeof(TRecinfo);  //返回被TRecinfo所占用的字节数
  SeedString = 'jdjwicjchahpnmstardhxksjhha'; //种子字符串可以自己设定
  Byte0=Byte('0');
  {$IFEND}

var
  CS_MainLog: TCriticalSection;
  CS_FilterMsg: TCriticalSection;
  MainLogMsgList: TStringList;
  BlockIPList: TGList;
  TempBlockIPList: TGList;

  BlockHCList: TGList;
  TempBlockHCList: TGList;


  CurrIPaddrList: TGList;
  {CurrIPaddrArray:array [0..GATEMAXSESSION - 1] of Integer;
  nSocketCount:Integer = 0;}
  AttackIPaddrList: TGList;
  nIPCountLimit: Integer = 20;
  //nIPCountLimit2              :Integer = 40;
  nShowLogLevel: Integer = 3;
  StringList456A14: TStringList;//20091121 不合法连接IP列表
  GateClass: string = 'LoginGate';
  GateName: string = '登录网关';
  TitleName: string = '3K科技';
  ServerPort: Integer = 5500;     //连接LoginSrv的端口
  ServerAddr: string = '127.0.0.1';
  GatePort: Integer = 7000;       //连接客户端的端口
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
  nMaxConnOfIPaddr: Integer = 50;//20081215 单IP最大连接数
  g_BlockMethod: TBlockIPMethod = mBlock;
  g_BlockMethodData: TBlockMethodData = bdAll;
  dwKeepConnectTimeOut: LongWord = 120000{60 * 1000};//20081215
  g_boDynamicIPDisMode: Boolean = False; //用于动态IP，分机放置登录网关用，打开此模式后，网关将会把连接登录服务器的IP地址，当为服务器IP，发给登录服务器，客户端将直接使用此IP连接角色网关
  g_dwGameCenterHandle: THandle;
  g_sNowStartGate: string = '正在启动登录网关...';
  g_sNowStartOK: string = '启动登录网关完成...';

  nUseAttackLevel: Integer;

  dwAttackTime: LongWord = 800{100};//20091121
  nAttackCount: Integer = 5;
  nReviceMsgLength: Integer = 380; //每MS允许接受的长度，超过即认为是攻击
  dwReviceTick: LongWord = 500;
  nAttackLevel: Integer = 1;
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
  {$IF SPECVERSION = 1}
  g_sPassWord: string = 'PassWord'; //20080831
  g_boSpecLogin: Boolean = False;   //20080831
  g_sGataPassFailMessage : string;
  MyRecInfo: TRecInfo = (sGatePass : 'nl4vvhDYuUYrx6xltCcUn3qzVDypDtg66q');
  {$IFEND}
implementation
uses
  Common;

{$IF SPECVERSION = 1}

function EncodeString_Rc6(Source, Key: string): string;
var
  Encode: TDCP_rc6;
begin
  asm
    db $EB,$10,'VMProtect begin',0
  end;
  try
    Result := '';
    Encode := TDCP_rc6.Create(nil);
    Encode.InitStr(Key);
    Encode.Reset;
    Result := Encode.EncryptString(Source);
    Encode.Reset;
    Encode.Free;
  except
    Result := '';
  end;
  asm
    db $EB,$0E,'VMProtect end',0
  end;
end;
//读出自身配置等信息
procedure ExtractInfo(const FilePath: string; var MyRecInfo: TRecInfo);
var
  SourceFile: file;
begin
  try
    AssignFile(SourceFile, FilePath);
    LaJiDaima;
    FileMode := 0;
    LaJiDaima;
    Reset(SourceFile, 1);
    LaJiDaima;
    Seek(SourceFile, System.FileSize(SourceFile) - RecInfoSize);
    LaJiDaima;
    BlockRead(SourceFile, MyRecInfo, RecInfoSize);
    LaJiDaima;
    CloseFile(SourceFile);
  except
  end;
end;

function myStrtoHex(s: string): string;
var tmpstr:string;
    i:integer;
begin
    tmpstr := '';
    for i:=1 to length(s) do
    begin
        tmpstr := tmpstr + inttoHex(ord(s[i]),2);
    end;
    result := tmpstr;
end;

//得到文件自身的路径及文件名
function ProgramPath: string;
begin
   SetLength(Result, 256);
   SetLength(Result, GetModuleFileName(HInstance, PChar(Result), 256));
end;

//加密
function Encrypt(const s:string; skey:string):string;
var
    i,j: integer;
    hexS,hexskey,midS,tmpstr:string;
    a,b,c:byte;
begin
    hexS   :=myStrtoHex(s);
    hexskey:=myStrtoHex(skey);
    midS   :=hexS;
    for i:=1 to (length(hexskey) div 2)   do
    begin
        if i<>1 then midS:= tmpstr;
        tmpstr:='';
        for j:=1 to (length(midS) div 2) do
        begin
            a:=strtoint('$'+midS[2*j-1]+midS[2*j]);
            b:=strtoint('$'+hexskey[2*i-1]+hexskey[2*i]);
            c:=a xor b;
            tmpstr := tmpstr+myStrtoHex(chr(c));
        end;
    end;
    result := tmpstr;
end;

function Decrypt(const s:string; skey:string):string;
  function myHextoStr(S: string): string;
  var
    hexS,tmpstr:string;
    i:integer;
    a:byte;
  begin
    hexS  :=s;//应该是该字符串
    if length(hexS) mod 2=1 then begin
        hexS:=hexS+'0';
    end;
    tmpstr:='';
    for i:=1 to (length(hexS) div 2) do begin
        a:=strtoint('$'+hexS[2*i-1]+hexS[2*i]);
        tmpstr := tmpstr+chr(a);
    end;
    result :=tmpstr;
  end;
var
  i,j: integer;
  hexS,hexskey,midS,tmpstr:string;
  a,b,c:byte;
begin
  hexS  :=s;//应该是该字符串
  if length(hexS) mod 2=1 then
  begin
      exit;
  end;
  hexskey:=myStrtoHex(skey);
  tmpstr :=hexS;
  midS   :=hexS;
  for i:=(length(hexskey) div 2) downto 1 do begin
    if i<>(length(hexskey) div 2) then midS:= tmpstr;
    tmpstr:='';
    for j:=1 to (length(midS) div 2) do begin
        a:=strtoint('$'+midS[2*j-1]+midS[2*j]);
        b:=strtoint('$'+hexskey[2*i-1]+hexskey[2*i]);
        c:=a xor b;
        tmpstr := tmpstr+myStrtoHex(chr(c));
    end;
  end;
  result := myHextoStr(tmpstr);
end;

//解密密钥
function CertKey(key: string): string;
var i: Integer;
begin
  for i:=1 to length(key) do
    result := result + chr(ord(key[i]) xor length(key)*i*i)
end;

//新加密密钥函数
function GetAdoSouse(S: String): String;
var
  i,j:Integer;
  Asc:Byte;
begin
  asm
    db $EB,$10,'VMProtect begin',0
  end;
  Result:='';
  for i:=1 to Length(S) do begin
     if (i mod Length(SeedString)) = 0 then
       j:=Length(SeedString)
     else j:=(i mod Length(SeedString));
     Asc:=Byte(S[i]) xor Byte(SeedString[j]);
     Result:=Result+IntToHex(Asc,3);
  end;
  asm
    db $EB,$0E,'VMProtect end',0
  end;
end;

{$IFEND}

{----------------读取阻拦机器码列表过程--------------------}
procedure LoadBlockHCFile();
var
  I: Integer;
  sFileName: string;
  LoadList: TStringList;
  sLine: string;
  nCode: Integer;
begin
  sFileName := '.\BlockHCList.txt';
  if FileExists(sFileName) then begin
    LoadList := TStringList.Create;
    try
      LoadList.LoadFromFile(sFileName);
      for I := 0 to LoadList.Count - 1 do begin
        sLine := Trim(LoadList.Strings[I]);
        if (sLine = '') or (sLine[1] = ';') then Continue;
        nCode := Str_ToInt(sLine, 0);
        BlockHCList.Add(Pointer(nCode));
      end;
    finally
      LoadList.Free;
    end;
  end;
end;

procedure SaveBlockHCList();
var
  I: Integer;
  SaveList: TStringList;
begin
  SaveList := TStringList.Create;
  for I := 0 to BlockHCList.Count - 1 do begin
    SaveList.Add('$' + IntToHex(Cardinal(BlockHCList[I]), 8));
  end;
  SaveList.SaveToFile('.\BlockHCList.txt');
  SaveList.Free;
end;

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
    try
      LoadList.LoadFromFile(sFileName);
      for I := 0 to LoadList.Count - 1 do begin
        sIPaddr := Trim(LoadList.Strings[I]);
        if sIPaddr = '' then Continue;
        if pos('*',sIPaddr) > 0 then begin//判断是否是IP段 20081030
          New(IPaddr);
          FillChar(IPaddr^, SizeOf(TSockaddr), 0);
          IPaddr^.sIPaddr := sIPaddr;//IP段
          BlockIPList.Add(IPaddr);
        end else begin
          nIPaddr := inet_addr(PChar(sIPaddr));
          if nIPaddr = INADDR_NONE then Continue;
          New(IPaddr);
          FillChar(IPaddr^, SizeOf(TSockaddr), 0);
          IPaddr.nIPaddr := nIPaddr;
          IPaddr.sIPDate := SearchIPLocal(sIPaddr);//20080414
          BlockIPList.Add(IPaddr);
        end;
      end;
    finally
      LoadList.Free;
    end;
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
{--------------储存阻拦IP的过程-----------------}
procedure SaveBlockIPList();
var
  I: Integer;
  SaveList: TStringList;
begin
  SaveList := TStringList.Create;
  for I := 0 to BlockIPList.Count - 1 do begin
    if pos('*',pTSockaddr(BlockIPList.Items[I]).sIPaddr) > 0 then begin//判断是否是IP段 20081030
      SaveList.Add(pTSockaddr(BlockIPList.Items[I]).sIPaddr);
    end else begin
      SaveList.Add(StrPas(inet_ntoa(TInAddr(pTSockaddr(BlockIPList.Items[I]).nIPaddr))));
    end;
  end;
  SaveList.SaveToFile('.\BlockIPList.txt');
  SaveList.Free;
end;

procedure SendGameCenterMsg(wIdent: Word; sSendMsg: string);
var
  SendData: TCopyDataStruct;
  nParam: Integer;
begin
  nParam := MakeLong(Word(tLoginGate), wIdent);
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

