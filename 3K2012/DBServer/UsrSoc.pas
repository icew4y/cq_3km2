unit UsrSoc;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, WinSock, Common, 
  Controls, Forms, Dialogs, StdCtrls, ExtCtrls, JSocket, SyncObjs, IniFiles, Grobal2, DBShare, EDcodeUnit;
type
  TFrmUserSoc = class(TForm)
    UserSocket: TServerSocket;//线路1
    UserSocket1: TServerSocket;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure UserSocketClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure UserSocketClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure UserSocketClientError(Sender: TObject;
      Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
      var ErrorCode: Integer);
    procedure UserSocketClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure UserSocket1ClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure UserSocket1ClientError(Sender: TObject;
      Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
      var ErrorCode: Integer);
  private
    CS_GateSession: TCriticalSection;
    GateList: TList;
    CurGate: pTSelGateInfo;
    MapList: TStringList;

    function LoadChrNameList(sFileName: string): Boolean;//过滤名字列表
    function LoadClearMakeIndexList(sFileName: string): Boolean;
    procedure ProcessGateMsg(var GateInfo: pTSelGateInfo);
    procedure SendKeepAlivePacket(Socket: TCustomWinSocket);
    procedure ProcessUserMsg(var UserInfo: pTUserInfo);
    procedure CloseUser(sID: string; var GateInfo: pTSelGateInfo);
    procedure OpenUser(sID, sIP: string; var GateInfo: pTSelGateInfo);
    procedure DeCodeUserMsg(sData: string; var UserInfo: pTUserInfo);
    function QueryChr(sData: string; var UserInfo: pTUserInfo): Boolean;
    function QueryDelChr(sData: string; var UserInfo: pTUserInfo): Boolean;//查询删除角色,并发消息给客户端在恢复窗口显示 20080706\
    function ResDelChr(sData: string; var UserInfo: pTUserInfo): Boolean;//恢复删除的角色人物 20080706
    procedure DelChr(sData: string; var UserInfo: pTUserInfo);
    procedure OutOfConnect(const UserInfo: pTUserInfo);
    procedure NewChr(sData: string; var UserInfo: pTUserInfo);

    function SelectChr(sChrName: string; var UserInfo: pTUserInfo): Boolean;
    procedure SendUserSocket(Socket: TCustomWinSocket; sSessionID,
      sSendMsg: string);
    function GetMapIndex(sMap: string): Integer;

    function GateRoutePort(sGateIP: string): Integer;
    procedure GetCheckCode(UserInfo: pTUserInfo); //发送到客户端验证码 20080612

    { Private declarations }
  public
    function GateRouteIP(sGateIP: string; var nPort: Integer): string;
    procedure LoadServerInfo();
    function NewHeroChrData(sAccount:string;sChrName: string; nSex, nJob, nHair,nHeroType: Integer; boIsHero :Boolean; sMasterName: string): Boolean;
    function NewChrData(sChrName, sAccount: string; nSex, nJob, nHair: Integer): Boolean;
    function GetUserCount(): Integer;
    procedure SendKickUser(Socket: TCustomWinSocket; SocketHandle: string; nKickType: Integer);
    function CheckDenyChrName(sChrName: string): Boolean;//检查过滤文字
    function UpdateHeroMir(sHeroName: string; boDel: Boolean): Boolean;//修改HeroMir.db标识 20100204
    { Public declarations }
  end;

var
  FrmUserSoc: TFrmUserSoc;

implementation

uses HumDB, HUtil32, IDSocCli, EDcode, MudUtil, DBSMain, StrUtils;

{$R *.DFM}
//角色网关连接DBS
procedure TFrmUserSoc.UserSocketClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  GateInfo: pTSelGateInfo;
  sIPaddr: string;
begin
  try
    sIPaddr := Socket.RemoteAddress;
    if not CheckServerIP(sIPaddr) then begin
      MainOutMessage('非法网关连接: ' + sIPaddr);
      Socket.Close;
      Exit;
    end;
    UserSocketClientConnected := True;
    User_sRemoteAddress := sIPaddr;
    User_nRemotePort := Socket.RemotePort;
    if not boOpenDBBusy then begin
      //MainOutMessage('连接: ' + sIPaddr+'   Socket:'+inttostr(Socket.RemotePort));
      New(GateInfo);
      GateInfo.Socket := Socket;
      GateInfo.sGateaddr := sIPaddr;
      GateInfo.sText := '';
      GateInfo.UserList := TList.Create;
      GateInfo.dwTick10 := GetTickCount();
      //GateInfo.nGateID   := GetGateID(sIPaddr);
      CS_GateSession.Enter;
      try
        GateList.Add(GateInfo);
      finally
        CS_GateSession.Leave;
      end;
    end else begin
      Socket.Close;
    end;
  except
    if boViewHackMsg then MainOutMessage('[异常] TFrmUserSoc.UserSocketClientConnect');
  end;
end;

procedure TFrmUserSoc.UserSocketClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  i, ii: Integer;
  GateInfo: pTSelGateInfo;
  UserInfo: pTUserInfo;
begin
  try
    CS_GateSession.Enter;
    try
      {User_sRemoteAddress:='';
      User_nRemotePort:=0;
      UserSocketClientConnected:=FALSE;}
      if GateList.Count > 0 then begin//20090101
        for i := 0 to GateList.Count - 1 do begin
          GateInfo := GateList.Items[i];
          if GateInfo <> nil then begin
            if GateInfo.UserList.Count > 0 then begin//20090101
              for ii := 0 to GateInfo.UserList.Count - 1 do begin
                UserInfo := GateInfo.UserList.Items[ii];
                if UserInfo <> nil then Dispose(UserInfo);//20081222
              end;
            end;
            GateInfo.UserList.Free;
          end;
          GateList.Delete(i);
          break;
        end;
      end;
    finally
      CS_GateSession.Leave;
    end;
  except
    if boViewHackMsg then MainOutMessage('[异常] TFrmUserSoc.UserSocketClientDisconnect');
  end;
end;

procedure TFrmUserSoc.UserSocketClientError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
  ErrorCode := 0;
  Socket.Close;
  User_sRemoteAddress := '';
  User_nRemotePort := 0;
  UserSocketClientConnected := False;
end;

procedure TFrmUserSoc.UserSocketClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
  i: Integer;
  sReviceMsg: string;
  GateInfo: pTSelGateInfo;
  nCode: Byte;
begin
  nCode:= 0;
  try
    CS_GateSession.Enter;
    try
      nCode:= 1;
      if GateList.Count > 0 then begin//20090101
        for i := 0 to GateList.Count - 1 do begin
          nCode:= 2;
          try//20090301 增加
            GateInfo := GateList.Items[i];
          except
          end;
          nCode:= 3;
          if GateInfo <> nil then begin//20081222 增加
            nCode:= 4;
            if GateInfo.Socket = Socket then begin
              nCode:= 5;
              CurGate := GateInfo;
              sReviceMsg := Socket.ReceiveText;
              GateInfo.sText := GateInfo.sText + sReviceMsg;
              nCode:= 6;
              if Length(GateInfo.sText) < 81920 then begin
                if Pos('$', GateInfo.sText) >= 1 then begin
                  nCode:= 7;
                  ProcessGateMsg(GateInfo);
                end;
              end else begin
                GateInfo.sText := '';
              end;
            end;
          end;
        end;
      end;
    finally
      CS_GateSession.Leave;
    end;
  except
    if boViewHackMsg then MainOutMessage('[异常] TFrmUserSoc.UserSocketClientRead Code:'+inttostr(nCode));
  end;
end;

procedure TFrmUserSoc.FormCreate(Sender: TObject);
begin
  CS_GateSession := TCriticalSection.Create;
  GateList := TList.Create;
  MapList := TStringList.Create;
  UserSocket.Port := g_nGatePort;
  UserSocket.Address := g_sGateAddr;
  UserSocket.Active := True;
  if (g_nGatePort <> g_nGatePort1) and (g_sGateAddr1 <> '') and (g_nGatePort1 > 0) then begin//两个线路的端口不同才可运行
    UserSocket1.Port := g_nGatePort1;
    UserSocket1.Address := g_sGateAddr1;
    UserSocket1.Active := True;
  end;
  LoadServerInfo();
  LoadChrNameList('DenyChrName.txt');
  LoadClearMakeIndexList('ClearMakeIndex.txt');
end;

procedure TFrmUserSoc.FormDestroy(Sender: TObject);
var
  i, ii: Integer;
  GateInfo: pTSelGateInfo;
  UserInfo: pTUserInfo;
begin
  for i := 0 to GateList.Count - 1 do begin
    GateInfo := GateList.Items[i];
    if GateInfo <> nil then begin
      for ii := 0 to GateInfo.UserList.Count - 1 do begin
        UserInfo := GateInfo.UserList.Items[ii];
        if UserInfo <> nil then Dispose(UserInfo);//20081222
      end;
      GateInfo.UserList.Free;
    end;
    GateList.Delete(i);
    break;
  end;
  GateList.Free;
  MapList.Free;
  CS_GateSession.Free;
end;

function TFrmUserSoc.GetUserCount(): Integer;
var
  i: Integer;
  GateInfo: pTSelGateInfo;
  nUserCount: Integer;
begin
  try
    nUserCount := 0;
    CS_GateSession.Enter;
    try
      for i := 0 to GateList.Count - 1 do begin
        GateInfo := GateList.Items[i];
        if GateInfo <> nil then begin//20081222
          Inc(nUserCount, GateInfo.UserList.Count);
        end;
      end;
    finally
      CS_GateSession.Leave;
    end;
    Result := nUserCount;
  except
    if boViewHackMsg then MainOutMessage('[异常] TFrmUserSoc.GetUserCount');
  end;
end;
//新建角色
function TFrmUserSoc.NewChrData(sChrName, sAccount: string; nSex, nJob, nHair: Integer): Boolean;
var
  ChrRecord: THumDataInfo;
begin
  Result := False;
  try
    if (nJob > 2) or (nSex > 1) then Exit;//防止玩家修改职业 20100126
    if HumDataDB.Open and (HumDataDB.Index(sChrName) = -1) then begin
      FillChar(ChrRecord, SizeOf(THumDataInfo), #0);
      ChrRecord.Header.sName := Trim(sChrName);//名称 20090305 Trim
      ChrRecord.Data.sChrName := Trim(sChrName);//名称 20090305 Trim
      ChrRecord.Data.boIsHero := False;//是否是英雄
      ChrRecord.Header.boIsHero := False;//是否是英雄
      ChrRecord.Data.btSex := nSex;//性别 1-女
      ChrRecord.Data.btJob := nJob; //职业 0-战士 1-法 2-道
      ChrRecord.Data.btHair := nHair;//发型
      ChrRecord.Data.nEXPRATE:=100;//杀怪倍数 20071230
      ChrRecord.Data.sAccount:= sAccount;//账号 20090305
      {$IF DBSMode = 1}
      HumDataDB.Add(@ChrRecord);
      {$ELSE}
      HumDataDB.Add(ChrRecord);
      {$IFEND}
      Result := True;
    end;
  finally
    HumDataDB.Close;
  end;
end;
//新建英雄
function TFrmUserSoc.NewHeroChrData(sAccount:string;sChrName: string; nSex, nJob, nHair, nHeroType: Integer; boIsHero :Boolean; sMasterName: string): Boolean;
var
  ChrRecord: THumDataInfo;
begin
  Result := False;
  try
    if (nJob > 2) or (nSex > 1) then Exit;//防止玩家修改职业 20100126
    if HumDataDB.Open and (HumDataDB.Index(sChrName) = -1) then begin
      FillChar(ChrRecord, SizeOf(THumDataInfo), #0);
      ChrRecord.Data.sAccount:= sAccount;//账号 20080902
      ChrRecord.Header.sName := Trim(sChrName);//名称  20090305 Trim
      ChrRecord.Data.sChrName := Trim(sChrName);//名称  20090305 Trim
      ChrRecord.Data.btSex := nSex;//性别 1-女
      ChrRecord.Data.btJob := nJob; //职业 0-战士 0-战士 1-法 2-道
      ChrRecord.Data.btHair := nHair;//发型
      ChrRecord.Data.boIsHero := True;//是否是英雄 20080118
      ChrRecord.Header.boIsHero := True;//是否是英雄  20080118
      ChrRecord.Data.sMasterName:= sMasterName;//主人名字 20080408
      ChrRecord.Data.btHeroType := nHeroType;//英雄类型 0-白日门英雄 1-卧龙英雄 20080514
      ChrRecord.Data.nEXPRATE:=100;//杀怪倍数 20071230
      {$IF DBSMode = 1}
      HumDataDB.Add(@ChrRecord);
      {$ELSE}
      HumDataDB.Add(ChrRecord);
      {$IFEND}
      Result := True;
    end;
  finally
    HumDataDB.Close;
  end;
end;
//读取服务器配置
procedure TFrmUserSoc.LoadServerInfo;
var
  i: Integer;
  LoadList: TStringList;
  nRouteIdx, nGateIdx, nServerIndex: Integer;
  sLineText, sSelGateIPaddr, sGameGateIPaddr, sGameGate, sGameGatePort, sMapName, sMapInfo, sServerIndex: string;
  Conf: TIniFile;
begin
  LoadList := TStringList.Create;
  try
    FillChar(g_RouteInfo, SizeOf(g_RouteInfo), #0);
    if FileExists(sGateConfFileName) then begin
      LoadList.LoadFromFile(sGateConfFileName);
      nRouteIdx := 0;
      nGateIdx := 0;
      for i := 0 to LoadList.Count - 1 do begin
        sLineText := Trim(LoadList.Strings[i]);
        if (sLineText <> '') and (sLineText[1] <> ';') then begin
          sGameGate := GetValidStr3(sLineText, sSelGateIPaddr, [' ', #9]);
          if (sGameGate = '') or (sSelGateIPaddr = '') then Continue;
          g_RouteInfo[nRouteIdx].sSelGateIP := Trim(sSelGateIPaddr);
          g_RouteInfo[nRouteIdx].nGateCount := 0;
          nGateIdx := 0;
          while (sGameGate <> '') do begin
            sGameGate := GetValidStr3(sGameGate, sGameGateIPaddr, [' ', #9]);
            sGameGate := GetValidStr3(sGameGate, sGameGatePort, [' ', #9]);
            g_RouteInfo[nRouteIdx].sGameGateIP[nGateIdx] := Trim(sGameGateIPaddr);
            g_RouteInfo[nRouteIdx].nGameGatePort[nGateIdx] := Str_ToInt(sGameGatePort, 0);
            Inc(nGateIdx);
          end;
          g_RouteInfo[nRouteIdx].nGateCount := nGateIdx;
          Inc(nRouteIdx);
        end;
      end;
    end else begin
       LoadList.SaveToFile(sGateConfFileName);
    end;
    Conf := TIniFile.Create(sConfFileName);
    sMapFile := Conf.ReadString('Setup', 'MapFile', sMapFile);
    Conf.Free;
    MapList.Clear;
    if FileExists(sMapFile) then begin
      LoadList.Clear;
      LoadList.LoadFromFile(sMapFile);
      for i := 0 to LoadList.Count - 1 do begin
        sLineText := LoadList.Strings[i];
        if (sLineText <> '') and (sLineText[1] = '[') then begin
          sLineText := ArrestStringEx(sLineText, '[', ']', sMapName);
          sMapInfo := GetValidStr3(sMapName, sMapName, [#32, #9]);
          sServerIndex := Trim(GetValidStr3(sMapInfo, sMapInfo, [#32, #9]));
          nServerIndex := Str_ToInt(sServerIndex, 0);
          MapList.AddObject(sMapName, TObject(nServerIndex));
        end;
      end;
    end;
  finally
    LoadList.Free;
  end;
end;
//读取名字过滤列表
function TFrmUserSoc.LoadChrNameList(sFileName: string): Boolean;
var
  i: Integer;
begin
  Result := False;
  if FileExists(sFileName) then begin
    DenyChrNameList.LoadFromFile(sFileName);
    i := 0;
    while (True) do begin
      if DenyChrNameList.Count <= i then break;
      if Trim(DenyChrNameList.Strings[i]) = '' then begin
        DenyChrNameList.Delete(i);
        Continue;
      end;
      Inc(i);
    end;
    Result := True;
  end else DenyChrNameList.SaveToFile(sFileName);
end;

function TFrmUserSoc.LoadClearMakeIndexList(sFileName: string): Boolean;
var
  i: Integer;
  nIndex: Integer;
  sLineText: string;
begin
  Result := False;
  if FileExists(sFileName) then begin
    g_ClearMakeIndex.LoadFromFile(sFileName);
    i := 0;
    while (True) do begin
      if g_ClearMakeIndex.Count <= i then break;
      sLineText := g_ClearMakeIndex.Strings[i];
      nIndex := Str_ToInt(sLineText, -1);
      if nIndex < 0 then begin
        g_ClearMakeIndex.Delete(i);
        Continue;
      end;
      g_ClearMakeIndex.Objects[i] := TObject(nIndex);
      Inc(i);
    end;
    Result := True;
  end;
end;

procedure TFrmUserSoc.ProcessGateMsg(var GateInfo: pTSelGateInfo);
var
  s0C: string;
  s10: string;
  s19: Char;
  i: Integer;
  UserInfo: pTUserInfo;
  nCount: Integer;
begin
  try
    nCount := 0;
    while True do begin
      if Pos('$', GateInfo.sText) <= 0 then break;
      GateInfo.sText := ArrestStringEx(GateInfo.sText, '%', '$', s10);
      //if Pos('$', GateInfo.sText) > 0 then showmessage(GateInfo.sText);
      //%O308/127.0.0.1/127.0.0.1$
      //%A308/#2<<<<<BL<<<<<<<<<H?<lH>xq!$
      if s10 <> '' then begin
        s19 := s10[1];
        s10 := Copy(s10, 2, Length(s10) - 1);
        //s19:=UpperCase(s19);
        case s19 of
          '-': begin
              SendKeepAlivePacket(GateInfo.Socket);
              dwKeepAliveTick := GetTickCount();
            end;
          'D': begin
              s10 := GetValidStr3(s10, s0C, ['/']);
              for i := 0 to GateInfo.UserList.Count - 1 do begin
                UserInfo := GateInfo.UserList.Items[i];
                if UserInfo <> nil then begin
                  if UserInfo.sConnID = s0C then begin
                    UserInfo.s2C := UserInfo.s2C + s10;
                    if Pos('!', s10) < 1 then Continue;
                    ProcessUserMsg(UserInfo);
                    break;
                  end;
                end;
              end;
            end;
          'N': begin
              s10 := GetValidStr3(s10, s0C, ['/']);
              OpenUser(s0C, s10, GateInfo);
            end;
          'C': begin
              CloseUser(s10, GateInfo);
            end;
        else begin
            if nCount >= 1 then begin //2006-10-12 防止DBS溢出攻击
              GateInfo.sText := '';
              break;
            end;
            Inc(nCount);
          end;
        end;
      end else begin       //2007-01-16 防止DBS溢出攻击
        GateInfo.sText := '';
        break;
      end;
    end;
  except
    if boViewHackMsg then MainOutMessage('[异常] TFrmUserSoc.ProcessGateMsg');
  end;
end;

procedure TFrmUserSoc.SendKeepAlivePacket(Socket: TCustomWinSocket);
begin
  if Socket.Connected then
    Socket.SendText('%++$');
end;

procedure TFrmUserSoc.SendKickUser(Socket: TCustomWinSocket; SocketHandle: string; nKickType: Integer);
begin
  if (Socket <> nil) then begin
    if Socket.Connected then begin
      case nKickType of
        0: Socket.SendText('%+-' + SocketHandle + '$');
        1: Socket.SendText('%+T' + SocketHandle + '$');
        2: Socket.SendText('%+B' + SocketHandle + '$');
      end;
    end;
  end;
end;

procedure TFrmUserSoc.ProcessUserMsg(var UserInfo: pTUserInfo);
var
  s10: string;
  nC: Integer;
  nLoopCount: Integer;
begin
  nC := 0;
  nLoopCount := 0;
  if UserInfo <> nil then begin//20081222
    while nLoopCount < 11 do begin
      if TagCount(UserInfo.s2C, '!') <= 0 then break;
      UserInfo.s2C := ArrestStringEx(UserInfo.s2C, '#', '!', s10);
      if s10 <> '' then begin
        s10 := Copy(s10, 2, Length(s10) - 1);
        if Length(s10) >= DEFBLOCKSIZE then begin
          DeCodeUserMsg(s10, UserInfo);
        end else Inc(n4ADC20);
      end else begin
        Inc(n4ADC1C);
        if nC >= 1 then begin
          UserInfo.s2C := '';
        end;
        Inc(nC);
      end;
      Inc(nLoopCount);
    end;
  end;
end;

procedure TFrmUserSoc.OpenUser(sID, sIP: string; var GateInfo: pTSelGateInfo);
var
  i: Integer;
  UserInfo: pTUserInfo;
  sUserIPaddr: string;
  sGateIPaddr: string;
  nCode: Byte;
begin
  nCode:= 0;
  try
    if GateInfo <> nil then begin//20081222
      sGateIPaddr := GetValidStr3(sIP, sUserIPaddr, ['/']);
      nCode:= 1;
      for i := 0 to GateInfo.UserList.Count - 1 do begin
        nCode:= 2;
        UserInfo := GateInfo.UserList.Items[i];
        nCode:= 3;
        if (UserInfo <> nil) then begin
          if (UserInfo.sConnID = sID) then begin
            Exit;
          end;
        end;
      end;
      nCode:= 4;
      New(UserInfo);
      UserInfo.sAccount := '';
      UserInfo.sUserIPaddr := sUserIPaddr;
      UserInfo.sGateIPaddr := sGateIPaddr;
      UserInfo.sConnID := sID;
      UserInfo.nSessionID := 0;
      nCode:= 5;
      UserInfo.Socket := GateInfo.Socket;
      nCode:= 6;
      UserInfo.s2C := '';
      UserInfo.dwTick34 := GetTickCount();
      UserInfo.dwChrTick := GetTickCount();
      UserInfo.boChrSelected := False;
      UserInfo.boChrQueryed := False;
      nCode:= 7;
      UserInfo.nSelGateID := GateInfo.nGateID;
      UserInfo.nDataCount := 0;
      UserInfo.boRandomCode := False;//验证码验证状态
      nCode:= 8;
      if GateInfo.UserList <> nil then begin//20081224
        nCode:= 9;
        GateInfo.UserList.Add(UserInfo);
        nCode:= 10;
      end;
    end;
  except
    if boViewHackMsg then MainOutMessage('[异常] TFrmUserSoc.OpenUser Code:'+inttostr(nCode));
  end;
end;
//当人物进游戏成功，则把UserInfo删除
procedure TFrmUserSoc.CloseUser(sID: string; var GateInfo: pTSelGateInfo);
var
  i: Integer;
  UserInfo: pTUserInfo;
  nCode: Byte;
begin
  nCode:= 0;
  try
    if GateInfo <> nil then begin//20081222
      nCode:= 1;
      for i := GateInfo.UserList.Count - 1 downto 0 do begin
        nCode:= 8;
        if GateInfo.UserList.Count <= 0 then Break;//20081227
        nCode:= 2;
        UserInfo := GateInfo.UserList.Items[i];
        if (UserInfo <> nil) then begin
          nCode:= 3;
          if (UserInfo.sConnID = sID) then begin
            nCode:= 4;
            if not FrmIDSoc.GetGlobaSessionStatus(UserInfo.nSessionID) then begin
              nCode:= 5;
              FrmIDSoc.SendSocketMsg(SS_SOFTOUTSESSION, UserInfo.sAccount + '/' + IntToStr(UserInfo.nSessionID));//发送给LoginSrv.exe,踢出人物
              nCode:= 9;
              FrmIDSoc.CloseSession(UserInfo.sAccount, UserInfo.nSessionID);
            end;
            nCode:= 6;
            GateInfo.UserList.Delete(i);
            nCode:= 7;
            Dispose(UserInfo);
            break;
          end;
        end;
      end;
    end;
  except
    if boViewHackMsg then MainOutMessage('[异常] TFrmUserSoc.CloseUser Code:'+inttostr(nCode));
  end;
end;

procedure TFrmUserSoc.GetCheckCode(UserInfo: pTUserInfo); //发送到客户端验证码 20080612
var
  I,k: Integer;
  arrStr: array [1..32]of string ;
  pwdimgstr: string;
begin
  try
    pwdimgstr:='';
    arrStr[1]:='2';  arrStr[2]:='3';  arrStr[3]:='4';  arrStr[4]:='5';
    arrStr[5]:='6';  arrStr[6]:='7';  arrStr[7]:='8';  arrStr[8]:='9';
    arrStr[9]:='A';  arrStr[10]:='B'; arrStr[11]:='C'; arrStr[12]:='D';
    arrStr[13]:='E'; arrStr[14]:='F'; arrStr[15]:='G'; arrStr[16]:='H';
    arrStr[17]:='J'; arrStr[18]:='K'; arrStr[19]:='L'; arrStr[20]:='M';
    arrStr[21]:='N'; arrStr[22]:='P'; arrStr[23]:='Q'; arrStr[24]:='R';
    arrStr[25]:='S'; arrStr[26]:='T'; arrStr[27]:='U'; arrStr[28]:='V';
    arrStr[29]:='W'; arrStr[30]:='X'; arrStr[31]:='Y'; arrStr[32]:='Z';
    for I:=1 to 4  do begin
      Randomize;
      k:=strtoint(Format('%.1d',[Random(31) + 1]));//20081207
      pwdimgstr:=pwdimgstr+trim(arrStr[k])
    end;

    UserInfo.sRandomCode:= pwdimgstr;
    if UserInfo.sRandomCode <> '' then
    SendUserSocket(UserInfo.Socket, UserInfo.sConnID,
                   EncodeMessage(MakeDefaultMsg(SM_RANDOMCODE, 0, 0, 0, 0, 0)) + EncodeString(EncodeString_3des(UserInfo.sRandomCode, CertKey('mbhVaswrXSAL'))));
  except
    if boViewHackMsg then MainOutMessage('[异常] TFrmUserSoc.GetCheckCode');
  end;
end;
//接收客户端消息
procedure TFrmUserSoc.DeCodeUserMsg(sData: string; var UserInfo: pTUserInfo);
var
  sDefMsg, s18, sAccount: string;
  Msg: TDefaultMessage;
begin
  try
    sDefMsg := Copy(sData, 1, DEFBLOCKSIZE);
    s18 := Copy(sData, DEFBLOCKSIZE + 1, Length(sData) - DEFBLOCKSIZE);//20081216
    //s18 := Copy(sData, DEFBLOCKSIZE + 7, Length(sData) - DEFBLOCKSIZE);//20081210
    Msg := DecodeMessage(sDefMsg);
    case Msg.Ident of
      CM_CHECKNUM: begin//确认验证码 20080612
        s18 := DeCodeString(s18);
        s18 := Decrypt(s18, GetAdoSouse(UserInfo.sRandomCode));
        if CompareText(Trim(s18), Trim(UserInfo.sRandomCode)) = 0 then begin
          SendUserSocket(UserInfo.Socket, UserInfo.sConnID,
                           EncodeMessage(MakeDefaultMsg(SM_CHECKNUM_OK, 0, 0, 0, 0, 0)));
          UserInfo.boRandomCode := True;
          if g_boRandomCode then begin//把SessionID写入列表 20081207
            if (g_CheckCodePassList.IndexOf(Pointer(UserInfo.nSessionID)) < 0) and (UserInfo.nSessionID > 0) then
              g_CheckCodePassList.Add(Pointer(UserInfo.nSessionID));//20081205
          end;
        end else begin
          SendUserSocket(UserInfo.Socket, UserInfo.sConnID,
                           EncodeMessage(MakeDefaultMsg(SM_QUERYCHR_FAIL, 0, 0, 0, 1{此1为验证码特征}, 0)));
        end;
      end;
      CM_CHANGECHECKNUM: begin //改变验证码 20080612
        GetCheckCode(UserInfo);
      end;
      CM_RESDELCHR: begin//恢复删除的角色 20080706
          if not UserInfo.boChrQueryed then begin
            if (UserInfo.sAccount <> '') and FrmIDSoc.CheckSession(UserInfo.sAccount, UserInfo.sUserIPaddr, UserInfo.nSessionID) then begin
              if ResDelChr(s18, UserInfo) then  UserInfo.boChrSelected := True;
            end else begin
              OutOfConnect(UserInfo);//断开客户端连接
            end;
          end else begin
            if boAttack and AddAttackIP(UserInfo.sUserIPaddr) then SendKickUser(UserInfo.Socket, UserInfo.sConnID, 1);
            Inc(nHackerSelChrCount);
            MainOutMessage('[端口攻击]' + UserInfo.sAccount + '/' + UserInfo.sUserIPaddr);
          end;
      end;
      CM_QUERYDELCHR: begin//查询删除过的角色信息 20080706
          if (msg.Series = 1) and (g_boRandomCode) then GetCheckCode(UserInfo);
          if not UserInfo.boChrQueryed or ((GetTickCount - UserInfo.dwChrTick) > 200) then begin
            UserInfo.dwChrTick := GetTickCount();
            if QueryDelChr(s18, UserInfo) then UserInfo.boChrQueryed := True;
          end else begin
            if boAttack and AddAttackIP(UserInfo.sUserIPaddr) then SendKickUser(UserInfo.Socket, UserInfo.sConnID, 0);
            Inc(g_nQueryChrCount);
            MainOutMessage('[超速操作] 查询删除的人物 ' + UserInfo.sUserIPaddr);
          end;
      end;
      CM_QUERYCHR: begin  //查询人物 msg.Series 1取验证码，0不取
          if (msg.Series = 1) and (g_boRandomCode) then GetCheckCode(UserInfo);
          if not UserInfo.boChrQueryed or ((GetTickCount - UserInfo.dwChrTick) > 200) then begin
            UserInfo.dwChrTick := GetTickCount();
            if QueryChr(s18, UserInfo) then begin//在此写入nSessionID
              UserInfo.boChrQueryed := True;
            end;
          end else begin
            if boAttack and AddAttackIP(UserInfo.sUserIPaddr) then SendKickUser(UserInfo.Socket, UserInfo.sConnID, 0);
            Inc(g_nQueryChrCount);
            MainOutMessage('[超速操作] 查询人物 ' + UserInfo.sUserIPaddr);
          end;
        end;
      CM_NEWCHR: begin//创建角色
          if (GetTickCount - UserInfo.dwChrTick) > 1000 then begin
            UserInfo.dwChrTick := GetTickCount();
            if (UserInfo.sAccount <> '') and FrmIDSoc.CheckSession(UserInfo.sAccount, UserInfo.sUserIPaddr, UserInfo.nSessionID) then
            begin
              NewChr(s18, UserInfo);
              UserInfo.boChrQueryed := False;
            end else begin
              OutOfConnect(UserInfo);
            end;
          end else begin
            if boAttack and AddAttackIP(UserInfo.sUserIPaddr) then SendKickUser(UserInfo.Socket, UserInfo.sConnID, 1);
            Inc(nHackerNewChrCount);
            MainOutMessage('[超速操作] 创建人物 ' + UserInfo.sAccount + '/' + UserInfo.sUserIPaddr);
          end;
        end;
      CM_DELCHR: begin//删除角色
          if (GetTickCount - UserInfo.dwChrTick) > 1000 then begin
            UserInfo.dwChrTick := GetTickCount();
            if (UserInfo.sAccount <> '')
              and FrmIDSoc.CheckSession(UserInfo.sAccount, UserInfo.sUserIPaddr, UserInfo.nSessionID) then begin
              DelChr(s18, UserInfo);
              UserInfo.boChrQueryed := False;
            end else begin
              OutOfConnect(UserInfo);
            end;
          end else begin
            if boAttack and AddAttackIP(UserInfo.sUserIPaddr) then SendKickUser(UserInfo.Socket, UserInfo.sConnID, 0);
            Inc(nHackerDelChrCount);
            MainOutMessage('[超速操作] 删除人物' + UserInfo.sAccount + '/' + UserInfo.sUserIPaddr);
          end;
        end;
      CM_SELCHR: begin  //选择角色
          if not UserInfo.boChrQueryed then begin
            if (msg.Series = 0) and (g_boRandomCode) then begin//在此检查列表，是否存在于列表中
              if (g_CheckCodePassList.IndexOf(Pointer(UserInfo.nSessionID)) >= 0) then
                UserInfo.boRandomCode:= True;//20081205
            end;
            s18 := GetValidStr3(DecodeString(s18), sAccount, ['/']);
            if (UserInfo.sAccount <> '') and (sAccount = UserInfo.sAccount) and (s18 <> '')
              and FrmIDSoc.CheckSessionSelChr(s18, UserInfo.sAccount, UserInfo.sUserIPaddr, UserInfo.nSessionID) then begin
              if ((not g_boRandomCode) or UserInfo.boRandomCode) and SelectChr(s18, UserInfo) then begin
                UserInfo.boChrSelected := True;
              end else OutOfConnect(UserInfo);
            end else begin
              OutOfConnect(UserInfo);
            end;
          end else begin
            if boAttack and AddAttackIP(UserInfo.sUserIPaddr) then SendKickUser(UserInfo.Socket, UserInfo.sConnID, 1);
            Inc(nHackerSelChrCount);
            MainOutMessage('[端口攻击]' + UserInfo.sAccount + '/' + UserInfo.sUserIPaddr);
          end;
        end;
    else begin
        Inc(n4ADC24);
      end;
    end;
  except
    if boViewHackMsg then MainOutMessage('[异常] TFrmUserSoc.DeCodeUserMsg');
  end;
end;
//查询角色,即选择人物框
function TFrmUserSoc.QueryChr(sData: string; var UserInfo: pTUserInfo): Boolean;
var
  sAccount: string;
  sSessionID: string;
  nSessionID: Integer;
  nChrCount: Integer;
  ChrList: TStringList;
  i: Integer;
  nIndex: Integer;
  ChrRecord: THumDataInfo;
  HumRecord: THumInfo;
  QuickID: pTQuickID;
  btSex: Byte;
  sChrName: string;
  sJob: string;
  sHair: string;
  sLevel: string;
  s40: string;
begin
  try
    Result := False;
    sSessionID := GetValidStr3(DecodeString(sData), sAccount, ['/']);
    nSessionID := Str_ToInt(sSessionID, -2);
    UserInfo.nSessionID := nSessionID;
    nChrCount := 0;
    if FrmIDSoc.CheckSession(sAccount, UserInfo.sUserIPaddr, nSessionID) then begin
      FrmIDSoc.SetGlobaSessionNoPlay(nSessionID);
      UserInfo.sAccount := sAccount;
      ChrList := TStringList.Create;
      try
        if HumChrDB.Open and (HumChrDB.FindByAccount(sAccount, ChrList) >= 0) then begin
          try
            if {$IF DBSMode = 1}HumDataDB.Open{$ELSE}HumDataDB.OpenEx{$IFEND} then begin
              for i := 0 to ChrList.Count - 1 do begin
                QuickID := pTQuickID(ChrList.Objects[i]);
                //FrmDBSrv.MemoLog.Lines.Add('UserInfo.nSelGateID: '+IntToStr(UserInfo.nSelGateID)+' QuickID.nIndex: '+IntToStr(QuickID.nIndex));
                //如果选择ID不对,则跳过
                //if QuickID.nIndex <> UserInfo.nSelGateID then Continue;
                if {$IF DBSMode = 1}HumChrDB.GetBy(QuickID.sChrName, HumRecord){$ELSE}HumChrDB.GetBy(QuickID.nIndex, HumRecord){$IFEND} then begin
                  if (not HumRecord.boDeleted) and (not HumRecord.Header.boIsHero) then begin//加不是英雄的条件 20080515
                    sChrName := QuickID.sChrName;
                    nIndex := HumDataDB.Index(sChrName);
                    if (nIndex < 0) then Continue;
                    if (nChrCount >= 2) then Break;//20101011 修改
                    if {$IF DBSMode = 1}HumDataDB.Get(nIndex, @ChrRecord) >= 0{$ELSE}HumDataDB.Get(nIndex, ChrRecord) >= 0{$IFEND} then begin
                      btSex := ChrRecord.Data.btSex;
                      sJob := IntToStr(ChrRecord.Data.btJob);
                      sHair := IntToStr(ChrRecord.Data.btHair);
                      sLevel := IntToStr(ChrRecord.Data.Abil.Level);
                      if HumRecord.boSelected then s40 := s40 + '*';
                      if not ChrRecord.Header.boIsHero then begin
                        s40 := s40 + sChrName + '/' + sJob + '/' + sHair + '/' + sLevel + '/' + IntToStr(btSex) + '/';
                        Inc(nChrCount);
                      end;  
                    end;   
                  end;
                end;
              end;    
            end;
          finally
            HumDataDB.Close;
          end;
        end;
      finally
        HumChrDB.Close;
        ChrList.Free;
      end;
      SendUserSocket(UserInfo.Socket, UserInfo.sConnID,
        EncodeMessage(MakeDefaultMsg(SM_QUERYCHR, nChrCount, 0, 1, 0, 0)) + EncodeString(s40));
      //*ChrName/sJob/sHair/sLevel/sSex/
    end else begin
      SendUserSocket(UserInfo.Socket, UserInfo.sConnID,
        EncodeMessage(MakeDefaultMsg(SM_QUERYCHR_FAIL, nChrCount, 0, 1, 0, 0)));
      CloseUser(UserInfo.sConnID, CurGate);
    end;
  except
    if boViewHackMsg then MainOutMessage('[异常] TFrmUserSoc.QueryChr');
  end;
end;

//查询删除角色,并发消息给客户端在恢复窗口显示 20080706
function TFrmUserSoc.QueryDelChr(sData: string; var UserInfo: pTUserInfo): Boolean;
var
  sAccount: string;
  sSessionID: string;
  nSessionID: Integer;
  nChrCount: Integer;
  ChrList: TStringList;
  i: Integer;
  nIndex: Integer;
  ChrRecord: THumDataInfo;
  HumRecord: THumInfo;
  QuickID: pTQuickID;
  btSex: Byte;
  sChrName: string;
  sJob: string;
  sHair: string;
  sLevel: string;
  s40: string;
begin
  try
    Result := False;
    if not g_boNoCanResDelChr then begin//没有禁止恢复删除的角色 20080706
      sSessionID := GetValidStr3(DecodeString(sData), sAccount, ['/']);
      nSessionID := Str_ToInt(sSessionID, -2);
      UserInfo.nSessionID := nSessionID;
      nChrCount := 0;
      if FrmIDSoc.CheckSession(sAccount, UserInfo.sUserIPaddr, nSessionID) then begin
        FrmIDSoc.SetGlobaSessionNoPlay(nSessionID);
        UserInfo.sAccount := sAccount;
        ChrList := TStringList.Create;
        try
          if HumChrDB.Open and (HumChrDB.FindByAccount(sAccount, ChrList) >= 0) then begin
            try
              if {$IF DBSMode = 1}HumDataDB.Open{$ELSE}HumDataDB.OpenEx{$IFEND} then begin
                for i := 0 to ChrList.Count - 1 do begin
                  QuickID := pTQuickID(ChrList.Objects[i]);
                  //FrmDBSrv.MemoLog.Lines.Add('UserInfo.nSelGateID: '+IntToStr(UserInfo.nSelGateID)+' QuickID.nIndex: '+IntToStr(QuickID.nIndex));
                  //如果选择ID不对,则跳过
                  //if QuickID.nIndex <> UserInfo.nSelGateID then Continue;
                  if {$IF DBSMode = 1}HumChrDB.GetBy(QuickID.sChrName, HumRecord){$ELSE}HumChrDB.GetBy(QuickID.nIndex, HumRecord){$IFEND} and HumRecord.boDeleted and (not HumRecord.Header.boIsHero) then begin//加不是英雄的条件,并且是删除过的角色
                    sChrName := QuickID.sChrName;
                    nIndex := HumDataDB.Index(sChrName);
                    if (nIndex < 0) then Continue;
                    if (nChrCount >= 10) then Break;//20101011 修改
                    if {$IF DBSMode = 1}HumDataDB.Get(nIndex, @ChrRecord) >= 0{$ELSE}HumDataDB.Get(nIndex, ChrRecord) >= 0{$IFEND} then begin
                      btSex := ChrRecord.Data.btSex;
                      sJob := IntToStr(ChrRecord.Data.btJob);
                      sHair := IntToStr(ChrRecord.Data.btHair);
                      sLevel := IntToStr(ChrRecord.Data.Abil.Level);
                      if not ChrRecord.Header.boIsHero then begin
                        s40 := s40 + sChrName + '/' + sJob + '/' + sHair + '/' + sLevel + '/' + IntToStr(btSex) + '/';
                        Inc(nChrCount);
                      end;
                    end;
                  end;
                end;
              end;
            finally
              HumDataDB.Close;
            end;
          end;
        finally
          HumChrDB.Close;
        end;
        ChrList.Free;
        SendUserSocket(UserInfo.Socket,UserInfo.sConnID,EncodeMessage(MakeDefaultMsg(SM_QUERYDELCHR, nChrCount, 0, 1, 0, 0)) + EncodeString(s40));
        //*ChrName/sJob/sHair/sLevel/sSex/
      end else begin
        SendUserSocket(UserInfo.Socket,UserInfo.sConnID,EncodeMessage(MakeDefaultMsg(SM_QUERYDELCHR_FAIL, nChrCount, 0, 1, 0, 0)));
        CloseUser(UserInfo.sConnID, CurGate);
      end;
    end else begin//禁止恢复删除的角色
      SendUserSocket(UserInfo.Socket,UserInfo.sConnID,EncodeMessage(MakeDefaultMsg(SM_NOCANRESDELCHR, nChrCount, 0, 1, 0, 0)));
      //CloseUser(UserInfo.sConnID, CurGate); //20090507 修改
    end;
  except
    if boViewHackMsg then MainOutMessage('[异常] TFrmUserSoc.QueryDelChr');
  end;
end;
//修改HeroMir.db标识 20100204
function TFrmUserSoc.UpdateHeroMir(sHeroName{英雄名}: string; boDel{是否删除}: Boolean): Boolean;
var
  ChrList: TStringList;
  nIndex, I: Integer;
  HumanRCD: TNewHeroDataInfo;
begin
  Result := False;
  try
    if HeroDataDB.Open then begin
      ChrList := TStringList.Create;
      try
        if HeroDataDB.Find(sHeroName, ChrList) >= 0 then begin
          for I := 0 to ChrList.Count - 1 do begin
            nIndex := Integer(ChrList.Objects[i]);
            if {$IF DBSMode = 1}HeroDataDB.Get(nIndex, @HumanRCD) <> -1{$ELSE}HeroDataDB.Get(nIndex, HumanRCD) <> -1{$IFEND} then begin
              HumanRCD.Header.boDeleted:= boDel;
              {$IF DBSMode = 1}
              HeroDataDB.Update(nIndex, @HumanRCD);
              {$ELSE}
              HeroDataDB.Update(nIndex, HumanRCD);
              {$IFEND}
              Result := True;
            end;
          end;
        end;
      finally
        ChrList.Free;
      end;
    end;
  finally
    HeroDataDB.Close;
  end;
end;

//恢复删除的角色人物 20080706
function TFrmUserSoc.ResDelChr(sData: string; var UserInfo: pTUserInfo): Boolean;
var
  sAccount: string;
  sChrName, sHeroName: string;
  ChrList: TStringList;
  HumRecord: THumInfo;
  I, K: Integer;
  nIndex: Integer;
  QuickID: pTQuickID;
  ChrRecord,HeroChrRecord: THumDataInfo;
  boDataOK: Boolean;
  Msg: TDefaultMessage;
  sMsg: string;
//  HeroNameInfo: THeroNameInfo;
begin
  try
    Result := False;
    sChrName := GetValidStr3(DecodeString(sData), sAccount, ['/']);
    boDataOK := False;
    if UserInfo.sAccount = sAccount then begin
      try
        if HumChrDB.Open then begin
          ChrList := TStringList.Create;
          try
            if HumChrDB.ChrCountOfAccount(sAccount) < 2 then begin//不能越过2个角色
              if HumChrDB.FindByAccount(sAccount, ChrList) >= 0 then begin
                for i := 0 to ChrList.Count - 1 do begin
                  QuickID := pTQuickID(ChrList.Objects[i]);
                  nIndex := QuickID.nIndex;
                  if {$IF DBSMode = 1}HumChrDB.GetBy(QuickID.sChrName, HumRecord){$ELSE}HumChrDB.GetBy(nIndex, HumRecord){$IFEND} then begin
                    if (HumRecord.sChrName = sChrName) and (not HumRecord.Header.boIsHero) then begin
                      HumRecord.boSelected:= True;
                      HumRecord.boDeleted:= False;
                      {$IF DBSMode = 1}
                      HumChrDB.Update(sChrName, HumRecord);
                      {$ELSE}
                      HumChrDB.UpdateBy(nIndex, HumRecord);
                      {$IFEND}
                      boDataOK := True;
                    end;
                  end;
                end;//for
              end;
            end;
          finally
            ChrList.Free;
          end;
        end;
      finally
        HumChrDB.Close;
      end;
      if boDataOK then begin
        try
          if {$IF DBSMode = 1}HumDataDB.Open{$ELSE}HumDataDB.OpenEx{$IFEND} then begin
            nIndex := HumDataDB.Index(sChrName);
            if nIndex >= 0 then begin
              {$IF DBSMode = 1}
              HumDataDB.Get(nIndex, @ChrRecord);
              {$ELSE}
              HumDataDB.Get(nIndex, ChrRecord);
              {$IFEND}
              if not ChrRecord.Header.boIsHero then begin //不是英雄
                ChrRecord.Header.boDeleted:= False;
                {$IF DBSMode = 1}
                HumDataDB.Update(nIndex, @ChrRecord, 2);
                {$ELSE}
                HumDataDB.Update(nIndex, ChrRecord);
                {$IFEND}
                if ChrRecord.Data.boHasHero or ChrRecord.Data.boIsHero then begin//有英雄,则把英雄也恢复 20080923
                  if HumDataDB.count > 0 then begin//20101012 修改
                    ChrList := TStringList.Create;
                    try
                      if HumChrDB.Open then begin
                        if HumChrDB.FindByAccount(UserInfo.sAccount, ChrList) > 0 then begin
                          try
                            if {$IF DBSMode = 1}HumDataDB.Open{$ELSE}HumDataDB.OpenEx{$IFEND} then begin
                              K:=0;
                              for i := 0 to ChrList.Count - 1 do begin
                                QuickID := pTQuickID(ChrList.Objects[i]);
                                nIndex := HumDataDB.Index(QuickID.sChrName);
                                if (nIndex < 0) then Continue;
                                if {$IF DBSMode = 1}HumDataDB.Get(nIndex, @HeroChrRecord) >= 0{$ELSE}HumDataDB.Get(nIndex, HeroChrRecord) >= 0{$IFEND} then begin
                                  if (not HeroChrRecord.Data.boIsHero) then Continue;//继续
                                  if CompareText(HeroChrRecord.Data.sMasterName, sChrName) = 0 then begin
                                    HeroChrRecord.Header.boDeleted:= False;
                                    {$IF DBSMode = 1}
                                    HumDataDB.Update(I, @HeroChrRecord, 2);
                                    nIndex := HumChrDB.Get(HeroChrRecord.Data.sChrName, HumRecord);
                                    if nIndex >= 0 then begin//20100228 增加
                                      HumRecord.boDeleted := False;
                                      HumChrDB.Update(nIndex, HumRecord);
                                    end;
                                    {$ELSE}
                                    HumDataDB.Update(nIndex, HeroChrRecord);
                                    nIndex := HumChrDB.Index(HeroChrRecord.Data.sChrName);
                                    if nIndex >= 0 then begin//20100228 增加
                                      HumChrDB.Get(nIndex, HumRecord);
                                      HumRecord.boDeleted := False;
                                      HumChrDB.Update(nIndex, HumRecord);
                                    end;
                                    {$IFEND}
                                    Inc(K);
                                    if K >= 2 then Break;
                                  end;
                                end;
                              end;
                            end;
                          finally
                            HumDataDB.Close;
                          end;
                        end;
                      end;
                    finally
                      ChrList.Free;
                    end;
                    (*for I:= 0 to HumDataDB.count -1 do begin
                      if {$IF DBSMode = 1}HumDataDB.Get(I, @HeroChrRecord) >= 0{$ELSE}HumDataDB.Get(I, HeroChrRecord) >= 0{$IFEND} then begin
                        if (not HeroChrRecord.Data.boIsHero) then Continue;//继续
                        if CompareText(HeroChrRecord.Data.sMasterName, sChrName) = 0 then begin
                          HeroChrRecord.Header.boDeleted:= False;
                          {$IF DBSMode = 1}
                          HumDataDB.Update(I, @HeroChrRecord, 5);
                          {$ELSE}
                          HumDataDB.Update(I, HeroChrRecord);
                          {$IFEND}
                          if HumChrDB.Open then begin
                            {$IF DBSMode = 1}
                            nIndex := HumChrDB.Get(HeroChrRecord.Data.sChrName, HumRecord);
                            {$ELSE}
                            nIndex := HumChrDB.Index(HeroChrRecord.Data.sChrName);
                            HumChrDB.Get(nIndex, HumRecord);
                            {$IFEND}
                            if nIndex >= 0 then begin//20100228 增加
                              HumRecord.boDeleted := False;
                              HumChrDB.Update(nIndex, HumRecord);
                            end;
                          end;
                        end;
                      end;
                    end; *)
                  end;
                end;
              end;
            end;
          end;
        finally
          HumDataDB.Close;
        end;
       (* {$IF DBSMode = 0}
        try//恢复主体英雄名数据 20100204
          sHeroName:= '';
          if HumHeroDB.Open then begin
            nIndex := HumHeroDB.Index(sChrName);
            if nIndex >= 0 then begin
              if HumHeroDB.Get(nIndex, HeroNameInfo) >= 0 then begin
                HeroNameInfo.Header.boDeleted:= False;
                HumHeroDB.Update(nIndex, HeroNameInfo);
                sHeroName:= HeroNameInfo.Data.sNewHeroName;
              end;
            end;
          end;
          if sHeroName <> '' then UpdateHeroMir(sHeroName, False);
        finally
          HumHeroDB.Close;
        end;
        {$IFEND}   *)
      end;
    end;

    if boDataOK then
      Msg := MakeDefaultMsg(SM_RESDELCHR_SUCCESS, 0, 0, 0, 0, 0)
    else Msg := MakeDefaultMsg(SM_RESDELCHR_FAIL, 0, 0, 0, 0, 0);

    sMsg := EncodeMessage(Msg);
    SendUserSocket(UserInfo.Socket, UserInfo.sConnID, sMsg);
  except
    if boViewHackMsg then MainOutMessage('[异常] TFrmUserSoc.ResDelChr');
  end;
end;
//断开客户端连接
procedure TFrmUserSoc.OutOfConnect(const UserInfo: pTUserInfo);
var
  Msg: TDefaultMessage;
  sMsg: string;
begin
  Msg := MakeDefaultMsg(SM_OUTOFCONNECTION, 0, 0, 0, 0, 0);
  sMsg := EncodeMessage(Msg);
  SendUserSocket(UserInfo.Socket, sMsg, UserInfo.sConnID);
end;
//删除角色数据
procedure TFrmUserSoc.DelChr(sData: string; var UserInfo: pTUserInfo);
var
  sChrName, sHeroName: string;
  boCheck, boCheck1: Boolean;
  Msg: TDefaultMessage;
  sMsg: string;
  n10, I, K: Integer;
  HumRecord: THumInfo;
  HumanRCD: THumDataInfo;
  //HeroNameInfo: THeroNameInfo;
  nIndex: Integer;
  ChrList: TStringList;
  QuickID: pTQuickID;
begin
  try
    g_CheckCode.dwThread0 := 1000300;
    sChrName := DecodeString(sData);
    boCheck := False;
    boCheck1:= False;
    g_CheckCode.dwThread0 := 1000301;
    try
  //--------------------------20080220--------------------------------------------
      if HumDataDB.Open then begin
        n10 := HumDataDB.Index(sChrName);
        if n10 >= 0 then begin
          {$IF DBSMode = 1}
          HumDataDB.Get(n10, @HumanRCD);
          {$ELSE}
          HumDataDB.Get(n10, HumanRCD);
          {$IFEND}
          if HumanRCD.Data.sAccount = UserInfo.sAccount then begin
            if g_boNoCanDelChr then begin
              if HumanRCD.Data.Abil.Level >= dwCanDelChrLevel then begin
                HumanRCD.Header.boDeleted := True;
                {$IF DBSMode = 1}
                HumDataDB.Update(n10, @HumanRCD, 2);
                {$ELSE}
                HumDataDB.Update(n10, HumanRCD);
                {$IFEND}
                boCheck1:= True;
              end;
            end else begin
              HumanRCD.Header.boDeleted := True;
              {$IF DBSMode = 1}
              HumDataDB.Update(n10, @HumanRCD, 2);
              {$ELSE}
              HumDataDB.Update(n10, HumanRCD);
              {$IFEND}
              boCheck1:= True;
            end;
          end;
        end;
      end;
    finally
      HumDataDB.Close;//20080220
    end;
    try
      if HumChrDB.Open and boCheck1 then begin
        {$IF DBSMode = 1}
        n10 := HumChrDB.Get(sChrName, HumRecord);
        if n10 >= 0 then begin
          if HumRecord.sAccount = UserInfo.sAccount then begin
            HumRecord.boDeleted := True;
            HumRecord.dModDate := Now();
            HumChrDB.Update(n10, HumRecord);
            boCheck := True;
          end;
        end;
        {$ELSE}
        n10 := HumChrDB.Index(sChrName);
        if n10 >= 0 then begin
          HumChrDB.Get(n10, HumRecord);
          if HumRecord.sAccount = UserInfo.sAccount then begin
            HumRecord.boDeleted := True;
            HumRecord.dModDate := Now();
            HumChrDB.Update(n10, HumRecord);
            boCheck := True;
          end;
        end;
        {$IFEND}
      end;
    finally
      HumChrDB.Close;
    end;
    //修正删除人物报错 TasNat 2012-03-03 23:36:15 
    try
  //------------------------------------------------------------------------------
      if HumChrDB.Open and boCheck then begin//20101011 修改
        ChrList := TStringList.Create;
        try
          if HumChrDB.FindByAccount(UserInfo.sAccount, ChrList) > 0 then begin
            try
              if {$IF DBSMode = 1}HumDataDB.Open{$ELSE}HumDataDB.OpenEx{$IFEND} then begin
                K:=0;
                for i := 0 to ChrList.Count - 1 do begin
                  QuickID := pTQuickID(ChrList.Objects[i]);
                  nIndex := HumDataDB.Index(QuickID.sChrName);
                  if (nIndex < 0) then Continue;
                  if {$IF DBSMode = 1}HumDataDB.Get(nIndex, @HumanRCD) >= 0{$ELSE}HumDataDB.Get(nIndex, HumanRCD) >= 0{$IFEND} then begin
                    if (CompareStr(sChrName, HumanRCD.Data.sMasterName) = 0) and (HumanRCD.Data.boIsHero) and
                      (not HumanRCD.Header.boDeleted) and (HumanRCD.Data.sAccount= UserInfo.sAccount) then begin
                      HumanRCD.Header.boDeleted := True;
                      {$IF DBSMode = 1}
                      HumDataDB.Update(nIndex, @HumanRCD, 2);
                      n10 := HumChrDB.Get(QuickID.sChrName, HumRecord);
                      if n10 >= 0 then begin
                        if HumRecord.sAccount = UserInfo.sAccount then begin
                          HumRecord.boDeleted := True;
                          HumRecord.dModDate := Now();
                          HumChrDB.Update(n10, HumRecord);
                        end;
                      end;
                      {$ELSE}
                      HumDataDB.Update(nIndex, HumanRCD);
                      n10 := HumChrDB.Index(QuickID.sChrName);
                      if n10 >= 0 then begin
                        HumChrDB.Get(n10, HumRecord);
                        if HumRecord.sAccount = UserInfo.sAccount then begin
                          HumRecord.boDeleted := True;
                          HumRecord.dModDate := Now();
                          HumChrDB.Update(n10, HumRecord);
                        end;
                      end;
                      {$IFEND}
                      Inc(K);
                      if K >= 2 then Break;
                    end;
                  end;
                end;
              end;
            finally
              HumDataDB.Close;
            end;
          end;
        finally
          ChrList.Free;
        end;
      end;
    finally
      HumChrDB.Close;
    end;
    g_CheckCode.dwThread0 := 1000302;
    if boCheck then
      Msg := MakeDefaultMsg(SM_DELCHR_SUCCESS, 0, 0, 0, 0, 0)
    else
      Msg := MakeDefaultMsg(SM_DELCHR_FAIL, 0, 0, 0, 0, 0);

    sMsg := EncodeMessage(Msg);
    SendUserSocket(UserInfo.Socket, UserInfo.sConnID, sMsg);
    g_CheckCode.dwThread0 := 1000303;
  except
    if boViewHackMsg then MainOutMessage('[异常] TFrmUserSoc.DelChr');
  end;
end;

//客户端创建人物
procedure TFrmUserSoc.NewChr(sData: string; var UserInfo: pTUserInfo);
var
  Data, sAccount, sChrName, sHair, sJob, sSex: string;
  nCode: Integer;
  Msg: TDefaultMessage;
  sMsg: string;
  HumRecord: THumInfo;
  I: Integer;
begin
  try
    nCode := -1;
    Data := DecodeString(sData);
    Data := GetValidStr3(Data, sAccount, ['/']);
    Data := GetValidStr3(Data, sChrName, ['/']);
    Data := GetValidStr3(Data, sHair, ['/']);
    Data := GetValidStr3(Data, sJob, ['/']);
    Data := GetValidStr3(Data, sSex, ['/']);
    if Trim(Data) <> '' then nCode := 0;
    sChrName := Trim(sChrName);
    if Length(sChrName) < 3 then nCode := 0;
    if not CheckDenyChrName(sChrName) then nCode := 2;
    if not CheckChrName(sChrName) then nCode := 0;
    if not boDenyChrName then begin
      for i := 1 to Length(sChrName) do begin  // 测试发现小字不能通过
        if
          //修复小 啊 等字不能注册的BUG By TasNat at: 2012-04-07 14:52:40
        ((i > 1 ) and (sChrName[i - 1] <#127) and (sChrName[i] = #$A1))
          or (sChrName[i] = ' ') or (sChrName[i] = '/') or
          (sChrName[i] = '@') or (sChrName[i] = '?') or (sChrName[i] = '''') or
          (sChrName[i] = '"') or (sChrName[i] = '\') or (sChrName[i] = '.') or
          (sChrName[i] = ',') or (sChrName[i] = ':') or (sChrName[i] = ';') or
          (sChrName[i] = '`') or (sChrName[i] = '~') or (sChrName[i] = '!') or
          (sChrName[i] = '#') or (sChrName[i] = '$') or (sChrName[i] = '%') or
          (sChrName[i] = '^') or (sChrName[i] = '&') or (sChrName[i] = '*') or
          (sChrName[i] = '(') or (sChrName[i] = ')') or (sChrName[i] = '-') or
          (sChrName[i] = '_') or (sChrName[i] = '+') or (sChrName[i] = '=') or
          (sChrName[i] = '|') or (sChrName[i] = '[') or (sChrName[i] = '{') or
          (sChrName[i] = ']') or (sChrName[i] = '}') then nCode := 0;
      end;
    end;
    if nCode = -1 then begin
      try
        HumDataDB.Lock;
        if HumDataDB.Index(sChrName) >= 0 then nCode := 2;
      finally
        HumDataDB.UnLock;
      end;
    end;
    if nCode = -1 then begin
      try
        if HumChrDB.Open then begin
          if HumChrDB.ChrCountOfAccount(sAccount) < 2 then begin//不能越过2个角色
            FillChar(HumRecord, SizeOf(THumInfo), #0);
            HumRecord.sChrName := sChrName;
            HumRecord.sAccount := sAccount;
            HumRecord.boDeleted := False;
            HumRecord.btCount := 0;
            HumRecord.Header.sName := sChrName;
            HumRecord.Header.boIsHero:= False;//20080515
            HumRecord.Header.nSelectID := UserInfo.nSelGateID;
            if (HumRecord.Header.sName <> '') and (HumChrDB.Index(sChrName) = -1) then begin
              if not HumChrDB.Add(HumRecord) then nCode := 2;
            end else nCode := 2;
          end else nCode:= 3;
          //MainOutMessage('角色数量: '+inttostr(HumChrDB.ChrCountOfAccount(sAccount))+'  nCode:'+inttostr(UserInfo.nSelGateID{nCode}));
        end;
      finally
        HumChrDB.Close;
      end;
      if nCode = -1 then begin
        if NewChrData(sChrName, sAccount, Str_ToInt(sSex, 0), Str_ToInt(sJob, 0), Str_ToInt(sHair, 0)) then nCode := 1;
      end else begin
        FrmDBSrv.DelHum(sChrName);
        nCode := 4;
      end;
    end;
    if nCode = 1 then begin
      Msg := MakeDefaultMsg(SM_NEWCHR_SUCCESS, 0, 0, 0, 0, 0);
    end else begin
      Msg := MakeDefaultMsg(SM_NEWCHR_FAIL, nCode, 0, 0, 0, 0);
    end;
    sMsg := EncodeMessage(Msg);
    SendUserSocket(UserInfo.Socket, UserInfo.sConnID, sMsg);
  except
    if boViewHackMsg then MainOutMessage('[异常] TFrmUserSoc.NewChr');
  end;
end;
//选择人物
function TFrmUserSoc.SelectChr(sChrName: string; var UserInfo: pTUserInfo): Boolean;
var
  sAccount: string;
  ChrList: TStringList;
  HumRecord: THumInfo;
  i: Integer;
  nIndex: Integer;
  nMapIndex: Integer;
  QuickID: pTQuickID;
  ChrRecord: THumDataInfo;
  sCurMap: string;
  boDataOK: Boolean;
  sDefMsg: string;
  sRouteMsg: string;
  sRouteIP: string;
  nRoutePort: Integer;
  sIsOK: Boolean;
begin
  try
    Result := False;
    sAccount := UserInfo.sAccount;
    boDataOK := False;
    sIsOK:= False;//20090826
    //if UserInfo.sAccount = sAccount then
    begin
      try
        if HumChrDB.Open then begin
          ChrList := TStringList.Create;
          if HumChrDB.FindByAccount(sAccount, ChrList) >= 0 then begin
            for i := 0 to ChrList.Count - 1 do begin
              QuickID := pTQuickID(ChrList.Objects[i]);
              nIndex := QuickID.nIndex;
              {$IF DBSMode = 1}
              if HumChrDB.GetBy(pTQuickID(ChrList.Objects[i]).sChrName, HumRecord) then begin
                if HumRecord.sChrName = sChrName then begin
                  if (not HumRecord.boDeleted) and (not HumRecord.Header.boIsHero) then sIsOK:= True;//是否删除过的角色 20090826
                  HumRecord.boSelected := True;
                  HumChrDB.Update(HumRecord.sChrName, HumRecord);
                end else begin
                  if HumRecord.boSelected then begin
                    HumRecord.boSelected := False;
                    HumChrDB.Update(HumRecord.sChrName, HumRecord);
                  end;
                end;
              end;
              {$ELSE}
              if HumChrDB.GetBy(nIndex, HumRecord) then begin
                if HumRecord.sChrName = sChrName then begin
                  if (not HumRecord.boDeleted) and (not HumRecord.Header.boIsHero) then sIsOK:= True;//是否删除过的角色 20090826
                  HumRecord.boSelected := True;
                  HumChrDB.UpdateBy(nIndex, HumRecord);
                end else begin
                  if HumRecord.boSelected then begin
                    HumRecord.boSelected := False;
                    HumChrDB.UpdateBy(nIndex, HumRecord);
                  end;
                end;
              end;
              {$IFEND}
            end;
          end;
          ChrList.Free;
        end;
      finally
        HumChrDB.Close;
      end;
      try
        if {$IF DBSMode = 1}HumDataDB.Open{$ELSE}HumDataDB.OpenEx{$IFEND} and sIsOK then begin
          nIndex := HumDataDB.Index(sChrName);
          if nIndex >= 0 then begin
            {$IF DBSMode = 1}
            HumDataDB.Get(nIndex, @ChrRecord);
            {$ELSE}
            HumDataDB.Get(nIndex, ChrRecord);
            {$IFEND}
            sCurMap := ChrRecord.Data.sCurMap;
            //20080822 增加判断,非英雄,非删除角色才能进游戏
            if (not ChrRecord.Header.boIsHero) and (not ChrRecord.Header.boDeleted) then boDataOK := True;
          end;
        end;
      finally
        HumDataDB.Close;
      end;
    end;
    if boDataOK then begin
      nMapIndex := GetMapIndex(sCurMap);
      sDefMsg := EncodeMessage(MakeDefaultMsg(SM_STARTPLAY, 0, 0, 0, 0, 0));
      sRouteIP := GateRouteIP(CurGate.sGateaddr, nRoutePort);//取网关IP及端口,双线时，这就成了问题所在 20090417
      if g_boDynamicIPMode then sRouteIP := UserInfo.sGateIPaddr; //使用动态IP
      PBoolean^:= sRouteIP;//将IP信息存储到指针变量中 20090708
      //MainOutMessage('sRouteIP+nMapIndex+UserInfo.nSessionID:'+sRouteIP+IntToStr(nMapIndex)+IntToStr(UserInfo.nSessionID));
      sRouteMsg := sRouteIP + '/' + IntToStr(nRoutePort{ + nMapIndex});
      sRouteMsg := EncodeString(sRouteMsg);
      SendUserSocket(UserInfo.Socket, UserInfo.sConnID, sDefMsg + sRouteMsg);
      FrmIDSoc.SetGlobaSessionPlay(UserInfo.nSessionID);
      Result := True;
      Inc(g_nSelChrPassCount);
    end else begin
      Inc(g_nSelChrFailCount);
      SendUserSocket(UserInfo.Socket, UserInfo.sConnID, EncodeMessage(MakeDefaultMsg(SM_STARTFAIL, 0, 0, 0, 0, 0)));
    end;
  except
    if boViewHackMsg then MainOutMessage('[异常] TFrmUserSoc.SelectChr');
  end;
end;

function TFrmUserSoc.GateRoutePort(sGateIP: string): Integer;
begin
  Result := 7200;
end;

function TFrmUserSoc.GateRouteIP(sGateIP: string; var nPort: Integer): string;
  function GetRoute(RouteInfo: pTRouteInfo; var nGatePort: Integer): string;//随机选择RUN游戏网关
  var
    nGateIndex: Integer;
    sIP:string;
  begin
    nGateIndex := Random(RouteInfo.nGateCount);
    if CheckIsIpAddr(RouteInfo.sGameGateIP[nGateIndex]) then begin
      sIP:= RouteInfo.sGameGateIP[nGateIndex];
    end else begin
      sIP:= HostToIP(RouteInfo.sGameGateIP[nGateIndex]);
    end;
    Result := sIP;
    //Result := RouteInfo.sGameGateIP[nGateIndex];
    nGatePort := RouteInfo.nGameGatePort[nGateIndex];
  end;
var
  i: Integer;
  RouteInfo: pTRouteInfo;
  sSelGateIP: String;
begin
  try
    nPort := 0;
    Result := '';
    for i := Low(g_RouteInfo) to High(g_RouteInfo) do begin
      RouteInfo := @g_RouteInfo[i];
      if RouteInfo <> nil then begin
        if CheckIsIpAddr(RouteInfo.sSelGateIP) then begin
          sSelGateIP:= RouteInfo.sSelGateIP;
        end else begin
          sSelGateIP:= HostToIP(RouteInfo.sSelGateIP);
        end;
        if {RouteInfo.sSelGateIP}sSelGateIP = sGateIP then begin
          Result := GetRoute(RouteInfo, nPort);
          break;
        end;
      end;
    end;
  except
    if boViewHackMsg then MainOutMessage('[异常] TFrmUserSoc.GateRouteIP');
  end;
end;

function TFrmUserSoc.GetMapIndex(sMap: string): Integer;
var
  i: Integer;
begin
  try
    Result := 0;
    if MapList.Count > 0 then begin//20090101
      for i := 0 to MapList.Count - 1 do begin
        if MapList.Strings[i] = sMap then begin
          Result := Integer(MapList.Objects[i]);
          break;
        end;
      end;
    end;
  except
    if boViewHackMsg then MainOutMessage('[异常] TFrmUserSoc.GetMapIndex');
  end;
end;

procedure TFrmUserSoc.SendUserSocket(Socket: TCustomWinSocket; sSessionID,
  sSendMsg: string);
begin
  Socket.SendText('%' + sSessionID + '/#' + sSendMsg + '!$');
end;
//检查过滤的字符
function TFrmUserSoc.CheckDenyChrName(sChrName: string): Boolean;
var
  i: Integer;
begin
  try
    Result := True;
    g_CheckCode.dwThread0 := 1000700;
    if DenyChrNameList.Count > 0 then begin//20090101
      for i := 0 to DenyChrNameList.Count - 1 do begin
        g_CheckCode.dwThread0 := 1000701;
        //if CompareText(sChrName, DenyChrNameList.Strings[i]) = 0 then begin
        if AnsiContainsText(sChrName, DenyChrNameList.Strings[i]) then begin//uses StrUtils; 20081221 过滤字符
          g_CheckCode.dwThread0 := 1000702;
          Result := False;
          break;
        end else
        if pos(DenyChrNameList.Strings[i],sChrName) > 0 then begin//检查特殊字符,ńAnsiContainsText检查不出来
          g_CheckCode.dwThread0 := 1000702;
          Result := False;
          break;
        end;
      end;
    end;
    g_CheckCode.dwThread0 := 1000703;
  except
    if boViewHackMsg then MainOutMessage('[异常] TFrmUserSoc.CheckDenyChrName');
  end;
end;
//---------------------------------线路二--------------------------------------
procedure TFrmUserSoc.UserSocket1ClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  GateInfo: pTSelGateInfo;
  sIPaddr: string;
begin
  try
    sIPaddr := Socket.RemoteAddress;
    if not CheckServerIP(sIPaddr) then begin
      MainOutMessage('非法网关连接: ' + sIPaddr);
      Socket.Close;
      Exit;
    end;
    UserSocketClientConnected1 := True;
    User_sRemoteAddress1 := sIPaddr;
    User_nRemotePort1 := Socket.RemotePort;
    if not boOpenDBBusy then begin
      //MainOutMessage('连接: ' + sIPaddr+'   Socket:'+inttostr(Socket.RemotePort));
      New(GateInfo);
      GateInfo.Socket := Socket;
      GateInfo.sGateaddr := sIPaddr;
      GateInfo.sText := '';
      GateInfo.UserList := TList.Create;
      GateInfo.dwTick10 := GetTickCount();
      //GateInfo.nGateID   := GetGateID(sIPaddr);
      CS_GateSession.Enter;
      try
        GateList.Add(GateInfo);
      finally
        CS_GateSession.Leave;
      end;
    end else begin
      Socket.Close;
    end;
  except
    if boViewHackMsg then MainOutMessage('[异常] TFrmUserSoc.UserSocket1ClientConnect');
  end;
end;

procedure TFrmUserSoc.UserSocket1ClientError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
  ErrorCode := 0;
  Socket.Close;
  User_sRemoteAddress1 := '';
  User_nRemotePort1 := 0;
  UserSocketClientConnected1 := False;
end;

end.

