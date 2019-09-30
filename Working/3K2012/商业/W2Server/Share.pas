unit Share;

interface
uses Windows, Classes, SysUtils, JSocket, Controls, ADODB, DB, Md5, StrUtils,Messages;

type
  TConfig = record
    sGateIPaddr: string[30];
    boShowDetailMsg: Boolean;
    GateCriticalSection: TRTLCriticalSection;
    dwProcessGateTick: LongWord;
    dwProcessGateTime: LongWord;
    GateList: TList;
  end;
  pTConfig = ^TConfig;

  TLoginGateInfo = record
    Socket: TCustomWinSocket;
    sIPaddr: string;
    nPort: Integer;
    sReceiveMsg: string;
    nSuccesCount: Integer;
    nFailCount: Integer;
    UserList: TList;
    dwKeepAliveTick: LongWord;
  end;
  pTLoginGateInfo = ^TLoginGateInfo;

  TM2UserInfo = record
    Socket: TCustomWinSocket;
    sUserIPaddr: string; //用户IP
    sSockIndex: string;  //通讯标实
    sReceiveMsg: string;//接收的信息
    dwClientTick: LongWord;
    dwKickTick: LongWord;
    boKick: Boolean;
    sAccount: string;
    sPassWord: string;
    boLogined: Boolean; //是否已经登陆
  end;
  pTM2UserInfo = ^TM2UserInfo;
const
  USERMAXSESSION = 1000; //用户的最大连接
  sPrice = 200; //代理注册登陆器价格
  sM2Price = 220;//代理注册M2价格(包年)
  sM2PriceMonth = 70;//代理注册M2价格(包月) 20110712
  tW2Server= 0;
var
  g_boCanStart: Boolean;
  g_dwServerStartTick: LongWord;
  g_Config: pTConfig;
  UserSessionCount: Integer; //0x32C 用户连接会话数
  g_btMaxDayMakeNum: Integer = 10; //每日最大生成次数
  g_sGateVersionNum: string = ''; //网关版本号
  g_sLoginVersionNum: string = ''; //登陆器版本号
  g_s176GateVersionNum: string = ''; //1.76网关版本号
  g_s176LoginVersionNum: string = ''; //1.76登陆器版本号
  g_sLoginVersion: string = '';//登录器配置器版本号
  g_sM2Version: string = '';//M2配置器版本号
  g_s176LoginVersion: string = ''; //1.76登陆器配置器版本号
  g_s176M2Version: string = ''; //1.76M2配置器版本号
  g_nW2Version: integer = 20090830;//代理配置器版本号
  g_sSqlConnect: string;//数据库连接
  MakeSockeMsgList: TStringList; //生成器返回来的消息列表
  sProcMsg: string = '';
  boGateReady: Boolean = False;//是否与生成服务器连接
  boServiceStart: Boolean = False;//服务是否启动
  g_dwStartTick: LongWord; //启动间隔
  g_ServerIp: string='127.0.0.1';
  g_ServerPort: Integer=37002;

  g_dwGameCenterHandle: THandle;
function CheckUserExist (str, sAccount: string): Boolean;
function CheckUserExist1(str, sAccount: string; nM2Type: Byte): Boolean;
function MaxCurr(Val1, Val2: Currency): Currency;
function CheckMaXID(Ado: TADOQuery; str: string): Integer;
function UserLogined(sLoginID: string; GateInfo: pTLoginGateInfo): Boolean;
//procedure CheckUserTime(UserName: string);
//procedure MainOutMessage(sMsg: string);

Function RivestStr1(Str:String):String;//非正常MD5
function IsIPAddr(IP: string): Boolean;//检测IP地址是否有效

procedure AddUserTips(DLUserName,UserName,ZT: string; Yue: Currency);//增加日志

procedure SendGameCenterMsg(wIdent:Word;sSendMsg:String);
implementation
uses DM;
//检测用户是否存在
//str为表名
//返回值 True 为存在这个用户
function CheckUserExist(str, sAccount: string): Boolean;
var
  Ado: TADOQuery;
begin
  Ado := TADOQuery.Create(nil);
  Ado.Connection := FrmDm.ADOconn;
  try
    with Ado do begin
       Close;
       SQL.Clear;
       SQL.Add('Select User from '+str+' where [User] =:a0');
       Parameters.ParamByName('a0').DataType:=Ftstring;
       Parameters.ParamByName('a0').Value :=Trim(sAccount);
       Open;
       if RecordCount <> 0 then Result := True
       else Result := False;
    end;
  finally
    Ado.Free;
    FrmDm.ADOconn.Close;
  end;
end;

function CheckUserExist1(str, sAccount: string; nM2Type: Byte): Boolean;
var
  Ado: TADOQuery;
begin
  Ado := TADOQuery.Create(nil);
  Ado.Connection := FrmDm.ADOconn;
  try
    with Ado do begin
       Close;
       SQL.Clear;
       SQL.Add('Select User from '+str+' where [User] =:a0 and M2Type=:a1');
       Parameters.ParamByName('a0').DataType:=Ftstring;
       Parameters.ParamByName('a0').Value :=Trim(sAccount);
       Parameters.ParamByName('a1').DataType:= FtInteger;
       Parameters.ParamByName('a1').Value := nM2Type;
       Open;
       if RecordCount <> 0 then Result := True
       else Result := False;
    end;
  finally
    Ado.Free;
    FrmDm.ADOconn.Close;
  end;
end;

//取表中ID号,
function CheckMaXID(Ado: TADOQuery; str: string): Integer;
begin
  try
    with Ado do begin
       Close;
       SQL.Clear;
       SQL.Add('Select Max(ID) as a from '+str);
       Open;
       IF Ado.Fields[0].AsInteger=0 then Result := 1
       Else Result:=Ado.Fields[0].AsInteger+1;
    end;
  finally
  end;
end;
{//比较登陆时间,不为当前日期,则把每天生成次数初始
procedure CheckUserTime(UserName: string);
var
  Ado: TADOQuery;
begin
  Ado := TADOQuery.Create(nil);
  Ado.Connection := FrmDm.ADOconn;
  try
    with Ado do begin
       Close;
       SQL.Clear;
       SQL.Add('SELECT * FROM UserInfo where (datediff(dd,Timer,:a1) = 0) and [User]=:a2 ');
       parameters.ParamByName('a1').DataType:=Ftstring;
       parameters.ParamByName('a1').Value := DateToStr(now);
       parameters.ParamByName('a2').DataType :=Ftstring;
       parameters.ParamByName('a2').Value := Trim(UserName);
       Open;
       IF Ado.RecordCount = 0 then begin
          Close;
          SQL.Clear;
          SQL.Add('Update UserInfo set dayMakeNum=:a1 Where [User]=:a2') ;
          parameters.ParamByName('a1').DataType:=FtInteger;
          parameters.ParamByName('a1').Value := 0;
          parameters.ParamByName('a2').DataType :=Ftstring;
          parameters.ParamByName('a2').Value := Trim(UserName);
          ExecSQL;
       end;
    end;
  finally
    Ado.Free;
  end;
end;  }

//增加日志
//ZT 1-修改代理人余额  2-注册1.76登陆器用户 3-注册用户(登陆器) 4-注册代理 5-用户修改密码 6-代理修改密码
//   7-M2注册用户,用户延期(年版) 8-1.76M2注册,用户延期(年版)  9-M2用户修改密码 10-1.76M2修改硬件信息 12-用户修改硬件信息  13-找回密码
//   14-VIP插件 15-M2注册用户,用户延期(月版)  16-1.76M2注册,用户延期(月版)
procedure AddUserTips(DLUserName,UserName,ZT: string; Yue: Currency);
var
  Ado: TADOQuery;
begin
  Ado := TADOQuery.Create(nil);
  Ado.Connection := FrmDm.ADOconn;
  try
    with Ado do begin
      Close;
      SQL.Clear;
      SQL.Add('EXEC ADDTips :a1,:a2,:a3,:a4') ;
      parameters.ParamByName('a1').DataType:=Ftstring;
      parameters.ParamByName('a1').Value := Trim(DLUserName);
      parameters.ParamByName('a2').DataType :=Ftstring;
      parameters.ParamByName('a2').Value := Trim(UserName);
      parameters.ParamByName('a3').DataType :=FtCurrency;
      parameters.ParamByName('a3').Value := Yue;
      parameters.ParamByName('a4').DataType :=Ftstring;
      parameters.ParamByName('a4').Value := ZT;
      ExecSQL;
    end;
  finally
    Ado.Free;
    FrmDm.ADOconn.Close;
  end;
end;

function MaxCurr(Val1, Val2: Currency): Currency;
begin
  if Val1>=Val2 then Result := Val1 else Result := Val2;
end;

function UserLogined(sLoginID: string; GateInfo: pTLoginGateInfo): Boolean;
var
  UserInfo: pTM2UserInfo;
  I: Integer;
begin
  Result := False;
  for I := 0 to GateInfo.UserList.Count - 1 do begin
    UserInfo := GateInfo.UserList.Items[I];
    if (UserInfo.sAccount = sLoginID) then begin
      UserInfo.boKick := True;          //T掉用户
      UserInfo.dwKickTick := GetTickCount + 5000; //T掉用户
      Result := True;
    end;
  end;
end;

//-------------------------------------------------------------------------
Function RivestStr1(Str:String):String;
var
  dcpMD5: TDCP_md5;
  Len,i:integer;
  HashDigest:array[0..31]of   byte;
  MiWen:String;
begin
  dcpMD5:=TDCP_md5.Create(nil);
  try
    dcpMD5.Init;
    dcpMD5.UpdateStr(Str);
    dcpMD5.Final(HashDigest);
    Len:=dcpMD5.HashSize;
    MiWen:='';
    //For i:=0  to ((Len div 8)-1) do//正常MD5
    For i:=((Len div 8)-1) downto 0 do//非正常MD5
        MiWen:=MiWen+IntToHex(HashDigest[i],2);
    Result:=MiWen;
  Finally
    dcpMD5.Free;
  end;
end;

{/////////////////////////////////////////////////////////
  功  能:  检测IP地址是否有效
  参  数:  字符串
  返回值:  成功:  True  失败: False;
  备 注:   uses StrUtils
////////////////////////////////////////////////////////}
function IsIPAddr(IP: string): Boolean;
var
  Node: array[0..3] of Integer;
  tIP: string;
  tNode: string;
  tPos: Integer;
  tLen: Integer;
begin
  Result := False;
  tIP := IP;
  tLen := Length(tIP);
  tPos := Pos('.', tIP);
  tNode := MidStr(tIP, 1, tPos - 1);
  tIP := MidStr(tIP, tPos + 1, tLen - tPos);
  if not TryStrToInt(tNode, Node[0]) then Exit;

  tLen := Length(tIP);
  tPos := Pos('.', tIP);
  tNode := MidStr(tIP, 1, tPos - 1);
  tIP := MidStr(tIP, tPos + 1, tLen - tPos);
  if not TryStrToInt(tNode, Node[1]) then Exit;

  tLen := Length(tIP);
  tPos := Pos('.', tIP);
  tNode := MidStr(tIP, 1, tPos - 1);
  tIP := MidStr(tIP, tPos + 1, tLen - tPos);
  if not TryStrToInt(tNode, Node[2]) then Exit;

  if not TryStrToInt(tIP, Node[3]) then Exit;
  for tLen := Low(Node) to High(Node) do begin
    if (Node[tLen] < 0) or (Node[tLen] > 255) then Exit;
  end;
  Result := True;
end;

procedure SendGameCenterMsg(wIdent:Word;sSendMsg:String);
var
  SendData:TCopyDataStruct;
  nParam:Integer;
begin
  nParam:=MakeLong(Word(tW2Server),wIdent);
  SendData.cbData:=Length (sSendMsg) + 1;
  GetMem(SendData.lpData,SendData.cbData);
  StrCopy (SendData.lpData, PChar(sSendMsg));
  SendMessage(g_dwGameCenterHandle,WM_COPYDATA,nParam,Cardinal(@SendData));
  FreeMem(SendData.lpData);
end;
end.
