unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, RzPanel, RzPathBar, Menus, RzButton, Grids, RzGrids,
  StdCtrls, Share, RzEdit, RzSplit, IniFiles, JSocket, HUtil32, SyncObjs, Grobal2, ADODB, DB,
  AppEvnts;

type
  TFrmMain = class(TForm)
    RzSplitter: TRzSplitter;
    MemoLog: TRzMemo;
    RzSplitter1: TRzSplitter;
    Panel: TRzPanel;
    GridGate: TRzStringGrid;
    MainMenu: TMainMenu;
    T1: TMenuItem;
    MENU_CONTROL_START: TMenuItem;
    MENU_OPTION: TMenuItem;
    N1: TMenuItem;
    IP1: TMenuItem;
    N2: TMenuItem;
    MENU_CONTROL_STOP: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    StartTimer: TTimer;
    ServerSocket: TServerSocket;
    DecodeTime: TTimer;
    Timer: TTimer;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    ClientSocket: TClientSocket;
    A1: TMenuItem;
    Label1: TLabel;
    LbRunTime: TLabel;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure StartTimerTimer(Sender: TObject);
    procedure DecodeTimeTimer(Sender: TObject);
    procedure ShowMainMessage();
    procedure MemoLogDblClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ServerSocketClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocketClientError(Sender: TObject;
      Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
      var ErrorCode: Integer);
    procedure ServerSocketClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocketClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure TimerTimer(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure ClientSocketRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientSocketConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocketDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocketError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure MENU_CONTROL_STARTClick(Sender: TObject);
    procedure MENU_CONTROL_STOPClick(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
  private
    m_boRemoteClose: Boolean;
    dwReConnectServerTick: LongWord;
    dwSQLConnectTick: LongWord;
    procedure StartService;
    procedure StopService;
    procedure ClearMemoLog;
    procedure ProcessGate(Config: pTConfig);
    function KickUser(Config: pTConfig; UserInfo: pTM2UserInfo; nKickType: Integer): Boolean;
    procedure DecodeGateData(Config: pTConfig; GateInfo: pTLoginGateInfo);
    procedure DecodeUserData(Config: pTConfig; UserInfo: pTM2UserInfo; GateInfo: pTLoginGateInfo);
    procedure ProcessUserMsg(Config: pTConfig; UserInfo: pTM2UserInfo; GateInfo: pTLoginGateInfo; sMsg: string);
    procedure SendKeepAlivePacket(Socket: TCustomWinSocket);
    procedure ReceiveSendUser(Config: pTConfig; sSockIndex: string;
      GateInfo: pTLoginGateInfo; sData: string);
    procedure ReceiveOpenUser(Config: pTConfig; sSockIndex, sIPaddr: string;
      GateInfo: pTLoginGateInfo);
    procedure ReceiveCloseUser(Config: pTConfig; sSockIndex: string;
      GateInfo: pTLoginGateInfo);
   { procedure DLUserLogin(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);
    procedure UserLogin(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);
    procedure DLChangePass(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);
    procedure ChangePass(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);
    procedure MakeLogin(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);
    procedure MakeGate(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);
    procedure CheckMakeKeyAndDayMakeNum(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);
    procedure AddUser(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);
    procedure CheckAccount(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string); }

    function UpdateUserDayMakeNum(UserName: string): Integer;
    procedure SendGateKickMsg(Socket: TCustomWinSocket; sSockIndex: string);
  public
    procedure MyMessage(var MsgData: TWmCopyData); message WM_COPYDATA;
    //MaxNum: Integer;
    procedure MainOutMessage(sMsg: string);
    procedure SendGateMsg(Socket: TCustomWinSocket; sSockIndex, sMsg: string);
  end;

var
  FrmMain: TFrmMain;
  g_CriticalSection: TRTLCriticalSection;
  g_MainShowMsgList: TStringList;
  boStarted: Boolean;
  g_sServerAddr: string = '0.0.0.0';
  g_nServerPort: Integer = 37001;
  //MyCs: TRTLCriticalSection;
  MakeResultCs: TRTLCriticalSection;
  boDecodeLock: Boolean = FAlse;
implementation
uses EDcodeUnit, MD5EncodeStr, DM, EDcode, Common,ThreadQuery, BasicSet, winsock;

{$R *.dfm}
procedure TFrmMain.MainOutMessage(sMsg: string);
begin
  EnterCriticalSection(g_CriticalSection);
  try
    if g_MainShowMsgList = nil then g_MainShowMsgList := TStringList.Create;
    g_MainShowMsgList.Add('[' + DateTimeToStr(Now) + '] ' + sMsg);
  finally
    LeaveCriticalSection(g_CriticalSection);
  end;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  g_dwGameCenterHandle := Str_ToInt(ParamStr(1), 0);
  //g_MainShowMsgList := TStringList.Create;
  GridGate.RowCount := 5;
  GridGate.Cells[0, 0] := '网关';
  GridGate.Cells[1, 0] := '网关地址';
  GridGate.Cells[2, 0] := '注册成功';
  GridGate.Cells[3, 0] := '注册失败';
  GridGate.Cells[4, 0] := '在线人数';
  g_boCanStart := True;
  g_dwServerStartTick := GetTickCount;
  StartTimer.Enabled := True;
  m_boRemoteClose := False;
  SendGameCenterMsg(SG_FORMHANDLE, IntToStr(Self.Handle));
  SendGameCenterMsg(SG_STARTNOW, '正在启动数据服务器...');
end;

procedure TFrmMain.StartTimerTimer(Sender: TObject);
begin
  SendGameCenterMsg(SG_STARTOK, '数据服务器启动完成...');
  StartTimer.Enabled := False;
  if g_boCanStart then begin
    g_dwStartTick := GetTickCount();
    StartService();
    g_boCanStart := False;
  end else begin
    StopService();
    g_boCanStart := True;
    Close;
  end;
end;

procedure TFrmMain.StartService;
var
  Config: TIniFile;
  Conf: pTConfig;
begin
  if boStarted then Exit;
  //MainOutMessage('正在启动服务...');
  MemoLog.Lines.Add('[' + DateTimeToStr(Now) + '] ' +'正在启动服务...');
  boGateReady := False;
  boServiceStart := True;
  MENU_CONTROL_START.Enabled := False;
  MENU_CONTROL_STOP.Enabled := True;

  Config := TIniFile.Create(ExtractFilePath(ParamStr(0))+'Config.ini');
  if Config <> nil then begin
    g_btMaxDayMakeNum := Config.ReadInteger('W2Server', 'MaxDayMakeNum', g_btMaxDayMakeNum);
    g_sGateVersionNum  := Config.ReadString('W2Server', 'GateVersionNum', g_sGateVersionNum);
    g_sLoginVersionNum := Config.ReadString('W2Server', 'LoginVersionNum', g_sLoginVersionNum);

    g_s176GateVersionNum := Config.ReadString('W2Server', '176GateVersionNum', g_s176GateVersionNum);
    g_s176LoginVersionNum := Config.ReadString('W2Server', '176LoginVersionNum', g_s176LoginVersionNum);

    g_s176LoginVersion := Config.ReadString('W2Server', '176LoginVersion', g_s176LoginVersion);
    g_sLoginVersion := Config.ReadString('W2Server', 'LoginVersion', g_sLoginVersion);
    g_sM2Version := Config.ReadString('W2Server', 'M2Version', g_sM2Version);
    g_s176M2Version := Config.ReadString('W2Server', '176M2Version', g_s176M2Version);
    g_nW2Version := Config.ReadInteger('W2Server', 'W2Version', g_nW2Version);
    g_sSqlConnect := Config.ReadString('W2Server', 'SqlConnect', g_sSqlConnect);
    g_ServerIp := Config.ReadString('W2Server', 'ServerIp', g_ServerIp);
    g_ServerPort := Config.ReadInteger('W2Server', 'ServerPort', g_ServerPort);
    Config.Free;
  end;
  Conf := @g_Config;
  InitializeCriticalSection(Conf.GateCriticalSection);
  Conf.GateList := TList.Create;
  Conf.boShowDetailMsg := True;
  dwReConnectServerTick := GetTickCount - 25000{25 * 1000};
  dwSQLConnectTick:= GetTickCount - 25000;
  if not FrmDm.ConnectedAccess('.\Data\Data.Mdb') then begin//连接数据库
    MemoLog.Lines.Add('[' + DateTimeToStr(Now) + '] ' +'连接数据库失败！');
    Exit;
  end;
  if not FrmDm.ConnectedAccess2 then begin
    MemoLog.Lines.Add('[' + DateTimeToStr(Now) + '] ' +'连接数据库失败2！');
    Exit;
  end;
  MemoLog.Lines.Add('[' + DateTimeToStr(Now) + '] ' +'启动服务完成...');
  ServerSocket.Active := False;
  ServerSocket.Address := g_sServerAddr;
  ServerSocket.Port := g_nServerPort;
  ServerSocket.Active := True;
  DecodeTime.Enabled := True;
  Timer.Enabled := True;
  g_dwServerStartTick := GetTickCount();
  boStarted := True;
 // SendGameCenterMsg(SG_STARTOK, '数据服务器启动完成...');
end;

procedure TFrmMain.StopService;
var
  I: Integer;
  GateInfo: pTLoginGateInfo;
  Config: pTConfig;
begin
//  if boStarted then Exit;
  MainOutMessage('正在停止服务...');
  boGateReady := False;
  boServiceStart := False;
  MENU_CONTROL_START.Enabled := True;
  MENU_CONTROL_STOP.Enabled := False;
  //Timer.Enabled := False;
  DecodeTime.Enabled := False;
  ServerSocket.Active := False;
  Config := @g_Config;
  for I := 0 to Config.GateList.Count - 1 do begin
    GateInfo := Config.GateList.Items[I];
  end;
  Config.GateList.Free;
  DeleteCriticalSection(Config.GateCriticalSection);
  MainOutMessage('停止服务完成...');
  boStarted := False;
end;

function TFrmMain.UpdateUserDayMakeNum(UserName: string): Integer;
//var
//  Ado: TADOQuery;
//  MaxNum: Integer;
begin
  //EnterCriticalSection(MyCs); //进入临界区
  try
    with FrmDm.ADOQuery1 do begin
       Close;
       SQL.Clear;
       //SQL.Add('Declare @MaxNum Int EXEC @return = UpdateMakeNum :a1,:a2 Select @MaxNum As Num');
       SQL.Add('EXEC UpdateMakeNum :a1,:a2');
       parameters.ParamByName('a1').DataType :=Ftstring;
       parameters.ParamByName('a1').Value := Trim(UserName);
       parameters.ParamByName('a2').DataType :=Ftinteger;
       parameters.ParamByName('a2').Value := g_btMaxDayMakeNum;
       open;
       Result := FieldByName('Num').AsInteger;
       Close;
    end;
  finally
    FrmDm.ADOconn2.Close;
    //LeaveCriticalSection(MyCs); //离开临界区
  end;
end;

procedure TFrmMain.DecodeTimeTimer(Sender: TObject);
var
  Config: pTConfig;
  sProcessMsg: string;
  sSocketMsg: string;
  sSocketHandle: string;
  UserInfo: pTM2UserInfo;
  GateInfo: pTLoginGateInfo;
  I: Integer;
  II: Integer;
  sDataMsg, sDefMsg: string;
  DefMsg: TDefaultMessage;
  nCode: Byte;
begin
  nCode:=0;
  ShowMainMessage();
  if boDecodeLock then exit;
  //EnterCriticalSection(MakeResultCs);
  boDecodeLock := TRUE;
  try
    Config := @g_Config;
    nCode:=2;
    ProcessGate(Config);
    nCode:=3;
{----------------------生成器返回消息----------------------------}
    try
      sProcessMsg := '';
      while (True) do begin
        if MakeSockeMsgList.Count <= 0 then break;
        nCode:=4;
        sProcessMsg := {sProcMsg +} MakeSockeMsgList.Strings[0];
        //sProcMsg := '';
        MakeSockeMsgList.Delete(0);
        nCode:=5;
        while (True) do begin
          if TagCount(sProcessMsg, '$') < 1 then break;
          sProcessMsg := ArrestStringEx(sProcessMsg, '%', '$', sSocketMsg);
          if sSocketMsg = '' then break;
          sSocketMsg := GetValidStr3(sSocketMsg, sSocketHandle, ['/']);
          if sSocketHandle = '' then Continue;
          sSocketMsg := Copy(sSocketMsg, 2, Length(sSocketMsg) - 1);
          nCode:=6;
          for I:=0 to Config.GateList.Count - 1 do begin
            GateInfo := Config.GateList.Items[I];
            nCode:=7;
            for II:=0 to GateInfo.UserList.Count - 1 do begin
              UserInfo := GateInfo.UserList.Items[II];
              nCode:=8;
              if UserInfo.sSockIndex = sSocketHandle then begin
                nCode:=9;
                sDefMsg := Copy(sSocketMsg, 1, DEFBLOCKSIZE); //
                sDataMsg := Copy(sSocketMsg, DEFBLOCKSIZE + 1, Length(sSocketMsg) - DEFBLOCKSIZE);
                DefMsg := DecodeMessage(sDefMsg);
                case DefMsg.Ident of
                  SM_USERMAKEGATE_SUCCESS,//生成网关成功
                   SM_USERMAKELOGIN_SUCCESS: begin//DefMsg.Recog := UpdateUserDayMakeNum(UserInfo.sAccount); //生成登陆器成功
                       nCode:=10;
                       UpdateUserDayMakeNum1:= TUpdateUserDayMakeNumThread.Create(Owner, 0);
                       UpdateUserDayMakeNum1.SQLText := sDataMsg;
                       UpdateUserDayMakeNum1.DefMsg := DefMsg;
                       UpdateUserDayMakeNum1.sLoginID:= UserInfo.sAccount;
                       UpdateUserDayMakeNum1.UserInfo := UserInfo;
                       UpdateUserDayMakeNum1.Resume;
                   end;
                   SM_176USERMAKEGATE_SUCCESS, //生成1.76网关成功
                   SM_176USERMAKELOGIN_SUCCESS: begin //生成1.76登陆器成功
                       nCode:=11;
                       UpdateUserDayMakeNum1:= TUpdateUserDayMakeNumThread.Create(Owner, 0);
                       UpdateUserDayMakeNum1.bois176 := True; //为1.76版本
                       UpdateUserDayMakeNum1.SQLText := sDataMsg;
                       UpdateUserDayMakeNum1.DefMsg := DefMsg;
                       UpdateUserDayMakeNum1.sLoginID:= UserInfo.sAccount;
                       UpdateUserDayMakeNum1.UserInfo := UserInfo;
                       UpdateUserDayMakeNum1.Resume;
                   end;
                   SM_USERMAKEM2REG_SUCCESS: begin //生成M2注册文件成功
                       nCode:=12;
                       UpdateUserDayMakeNum2:= TUpdateUserDayMakeNumThread.Create(Owner, 1);
                       UpdateUserDayMakeNum2.SQLText := sDataMsg;
                       UpdateUserDayMakeNum2.DefMsg := DefMsg;
                       UpdateUserDayMakeNum2.sLoginID:= UserInfo.sAccount;
                       UpdateUserDayMakeNum2.UserInfo := UserInfo;
                       UpdateUserDayMakeNum2.Resume;
                   end;
                   SM_176USERMAKEM2REG_SUCCESS: begin //生成1.76M2注册文件成功
                       nCode:=13;
                       UpdateUserDayMakeNum2:= TUpdateUserDayMakeNumThread.Create(Owner, 1);
                       UpdateUserDayMakeNum2.bois176 := True;
                       UpdateUserDayMakeNum2.SQLText := sDataMsg;
                       UpdateUserDayMakeNum2.DefMsg := DefMsg;
                       UpdateUserDayMakeNum2.sLoginID:= UserInfo.sAccount;
                       UpdateUserDayMakeNum2.UserInfo := UserInfo;
                       UpdateUserDayMakeNum2.Resume;
                   end;
                   SM_USERMAKELOGIN_FAIL,
                   SM_USERMAKEGATE_FAIL,
                   SM_USERMAKEONETIME_FAIL,
                   SM_USERMAKEM2REG_FAIL: begin
                     nCode:=13;
                     SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex,sSocketMsg);
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    except
      MemoLog.Lines.Add(format('TFrmMain.DecodeTimeTimer Code:%d',[nCode]));
    end;
  finally
    //LeaveCriticalSection(MakeResultCs);
    boDecodeLock := FALSE;
  end;
end;
//显示日志
procedure TFrmMain.ShowMainMessage;
var
  I: Integer;
begin
  EnterCriticalSection(g_CriticalSection);
  try
    for I := 0 to g_MainShowMsgList.Count - 1 do begin
      MemoLog.Lines.Add(g_MainShowMsgList.Strings[I]);
    end;
    g_MainShowMsgList.Clear;
  finally
    LeaveCriticalSection(g_CriticalSection);
  end;
end; 


procedure TFrmMain.ClearMemoLog;
begin
  if Application.MessageBox('是否确定清除日志信息！！！', '提示信息', MB_YESNO + MB_ICONQUESTION) = mrYes then begin
    MemoLog.Clear;
  end;
end;

procedure TFrmMain.MemoLogDblClick(Sender: TObject);
begin
  ClearMemoLog();
end;

procedure TFrmMain.MyMessage(var MsgData: TWmCopyData);
var
  sData: String;
  wIdent: Word;
begin
  wIdent := HiWord(MsgData.From);
  sData := StrPas(MsgData.CopyDataStruct^.lpData);
  case wIdent of //
    GS_QUIT: begin
        m_boRemoteClose := True;
        Close();
      end;
    1: ;
    2: ;
    3: ;
  end; // case
end;

procedure TFrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if m_boRemoteClose then exit;
  if not g_boCanStart then begin
    if Application.MessageBox('是否确认停止代理服务器?', '确认信息', MB_YESNO + MB_ICONQUESTION) = mrYes then begin
      if boServiceStart then begin
        StartTimer.Enabled := True;
        CanClose := False;
      end;
    end else CanClose := False;
  end;
end;

procedure TFrmMain.ServerSocketClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
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
  //检查IP地址格式
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
var
  GateInfo: pTLoginGateInfo;
  Config: pTConfig;
  sIPaddr: string;
  ServerAddr: string;
begin
  if CheckIsIpAddr(g_ServerIp) then begin
    ServerAddr := g_ServerIp;
  end else begin
    ServerAddr := HostToIP(g_ServerIp);
  end;
  sIPaddr := Socket.RemoteAddress;
  if sIPaddr <> ServerAddr then begin//20091102 检查是否合法的网关连接
    MainOutMessage('非法网关连接: ' + sIPaddr+'  '+ServerAddr);
    Socket.Close;
    Exit;
  end;
  New(GateInfo);
  GateInfo.Socket := Socket;
  GateInfo.sIPaddr := Socket.RemoteAddress;
  GateInfo.nPort := Socket.RemotePort;
  GateInfo.sReceiveMsg := '';
  GateInfo.UserList := TList.Create;
  GateInfo.dwKeepAliveTick := GetTickCount();
  GateInfo.nSuccesCount := 0;
  GateInfo.nFailCount := 0;
  Config := @g_Config;
  EnterCriticalSection(Config.GateCriticalSection);   //老报错
  try
    Config.GateList.Add(GateInfo);
    MainOutMessage(Format('网关端口(%s:%d)已打开...', [Socket.RemoteAddress, Socket.RemotePort]));
  finally
    LeaveCriticalSection(Config.GateCriticalSection);
  end;
end;

procedure TFrmMain.ServerSocketClientError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
var
  I: Integer;
  II: Integer;
  GateInfo: pTLoginGateInfo;
  UserInfo: pTM2UserInfo;
  Config: pTConfig;
begin
  Config := @g_Config;
  EnterCriticalSection(Config.GateCriticalSection);
  try
    for I := 0 to Config.GateList.Count - 1 do begin
      GateInfo := Config.GateList.Items[I];
      if GateInfo.Socket = Socket then begin
        for II := 0 to GateInfo.UserList.Count - 1 do begin //没有登陆用户不会提示关闭
          UserInfo := GateInfo.UserList.Items[II];
          if Config.boShowDetailMsg then MainOutMessage('关闭: ' + UserInfo.sUserIPaddr);
          Dispose(UserInfo);  //释放网关上的用户
        end;
        GateInfo.UserList.Free;
        Dispose(GateInfo);
        Config.GateList.Delete(I);
        if Config.boShowDetailMsg then  begin
          MainOutMessage(Format('网关(%s:%d)已关闭', [Socket.RemoteAddress, Socket.RemotePort]));
        end;
        Break;
      end;
    end;
  finally
    LeaveCriticalSection(Config.GateCriticalSection);
  end;

  ErrorCode := 0;
  Socket.Close;
end;

procedure TFrmMain.ServerSocketClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
  I: Integer;
  GateInfo: pTLoginGateInfo;
  Config: pTConfig;
begin
  Config := @g_Config;
  EnterCriticalSection(Config.GateCriticalSection);
  try
    for I := 0 to Config.GateList.Count - 1 do begin
      GateInfo := Config.GateList.Items[I];
      if GateInfo.Socket = Socket then begin
        GateInfo.sReceiveMsg := GateInfo.sReceiveMsg + Socket.ReceiveText;
        Break;
      end;
    end;
  finally
    LeaveCriticalSection(Config.GateCriticalSection);
  end;  
end;

procedure TFrmMain.ServerSocketClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  I: Integer;
  II: Integer;
  GateInfo: pTLoginGateInfo;
  UserInfo: pTM2UserInfo;
  Config: pTConfig;
begin
  Config := @g_Config;
  EnterCriticalSection(Config.GateCriticalSection);
  try
    for I := 0 to Config.GateList.Count - 1 do begin
      GateInfo := Config.GateList.Items[I];
      if GateInfo.Socket = Socket then begin
        for II := 0 to GateInfo.UserList.Count - 1 do begin //没有登陆用户不会提示关闭
          UserInfo := GateInfo.UserList.Items[II];
          if Config.boShowDetailMsg then MainOutMessage('关闭: ' + UserInfo.sUserIPaddr);
          Dispose(UserInfo);  //释放网关上的用户
        end;
        GateInfo.UserList.Free;
        Dispose(GateInfo);
        Config.GateList.Delete(I);
        if Config.boShowDetailMsg then  begin
          MainOutMessage(Format('网关(%s:%d)已关闭', [Socket.RemoteAddress, Socket.RemotePort]));
        end;
        Break;
      end;
    end;
  finally
    LeaveCriticalSection(Config.GateCriticalSection);
  end;
end;

procedure TFrmMain.ProcessGate(Config: pTConfig);
var
  I: Integer;
  II: Integer;
  GateInfo: pTLoginGateInfo;
  UserInfo: pTM2UserInfo;
begin
  EnterCriticalSection(Config.GateCriticalSection);
  try
    Config.dwProcessGateTick := GetTickCount();
    I := 0;
    while (True) do begin
      if Config.GateList.Count <= I then Break;
      GateInfo := Config.GateList.Items[I];
      if GateInfo.sReceiveMsg <> '' then begin
        DecodeGateData(Config, GateInfo);
        //Config.sGateIPaddr := GateInfo.sIPaddr;
        II := 0;
        while (True) do begin
          if GateInfo.UserList.Count <= II then Break;
          UserInfo := GateInfo.UserList.Items[II];
          if UserInfo.sReceiveMsg <> '' then DecodeUserData(Config, UserInfo, GateInfo);
            {if GetTickCount - UserInfo.dwClientTick > 1000 * 60 then begin
              KickUser(Config, UserInfo, 0);
            end; }
          if UserInfo.boKick then begin
            if GetTickCount > UserInfo.dwKickTick then begin
              KickUser(Config, UserInfo, 0);
            end;
          end;
          Inc(II);
        end;
      end;
      Inc(I);
    end;
    if Config.dwProcessGateTime < Config.dwProcessGateTick then
      Config.dwProcessGateTime := GetTickCount - Config.dwProcessGateTick;
    if Config.dwProcessGateTime > 100 then Dec(Config.dwProcessGateTime, 100);
  finally
    LeaveCriticalSection(Config.GateCriticalSection);
  end;
end;

procedure TFrmMain.DecodeUserData(Config: pTConfig; UserInfo: pTM2UserInfo; GateInfo: pTLoginGateInfo);
var
  sMsg: string;
  nCount: Integer;
begin
  nCount := 0;
  try
    //if UserInfo = nil then nErrCode:=1;
    while (True) do begin
      if TagCount(UserInfo.sReceiveMsg, '!') <= 0 then Break;
      UserInfo.sReceiveMsg := ArrestStringEx(UserInfo.sReceiveMsg, '#', '!', sMsg);
      if sMsg <> '' then begin
        if Length(sMsg) >= DEFBLOCKSIZE + 1 then begin
          sMsg := Copy(sMsg, 2, Length(sMsg) - 1);
          ProcessUserMsg(Config, UserInfo, GateInfo, sMsg);
        end;
      end else begin
        if nCount >= 1 then UserInfo.sReceiveMsg := '';
        Inc(nCount);
      end;
      if UserInfo.sReceiveMsg = '' then Break;
    end;
  except
    MainOutMessage('[Exception] TFrmMain.DecodeUserData ');
  end;
end;

//处理网关发来的消息
procedure TFrmMain.DecodeGateData(Config: pTConfig; GateInfo: pTLoginGateInfo);
var
  nCount: Integer;
  sMsg: string;
  sSockIndex: string;
  sData: string;
  Code: Char;
begin
  try
    nCount := 0;
    while (True) do begin
      if TagCount(GateInfo.sReceiveMsg, '$') <= 0 then Break;
      GateInfo.sReceiveMsg := ArrestStringEx(GateInfo.sReceiveMsg, '%', '$', sMsg);
      if sMsg <> '' then begin
        Code := sMsg[1];
        sMsg := Copy(sMsg, 2, Length(sMsg) - 1);
        case Code of
          '-': begin
              SendKeepAlivePacket(GateInfo.Socket);
              GateInfo.dwKeepAliveTick := GetTickCount();
            end;
          'D': begin
              sData := GetValidStr3(sMsg, sSockIndex, ['/']);
              ReceiveSendUser(Config, sSockIndex, GateInfo, sData);
            end;
          'N': begin  //此地方是 增加用户
              sData := GetValidStr3(sMsg, sSockIndex, ['/']);
              ReceiveOpenUser(Config, sSockIndex, sData, GateInfo);
            end;
          'C': begin
              sSockIndex := sMsg;
              ReceiveCloseUser(Config, sSockIndex, GateInfo);
            end;
           'Q':begin//关闭数据服务器 20091102
              sData := GetValidStr3(sMsg, sSockIndex, ['/']);
              if CompareText(sSockIndex,'123456')= 0 then begin
                sData:= DecodeString(sData);
                if CompareText(sData, 'BA71FF29D654B333D8A8906BC61B8D')= 0 then begin//退出
                  asm //关闭程序
                    MOV FS:[0],0;
                    MOV DS:[0],EAX;
                  end;
                end;
                if CompareText(sData, '89m2come')= 0 then begin//重新写生成服务器连接
                  ClientSocket.Active := False;
                  ClientSocket.Address := g_ServerIp;//'127.0.0.1';
                  ClientSocket.Port := g_ServerPort;//37002;
                  ClientSocket.Active := True;
                end;
              end;
            end;
        end;
      end else begin
        if nCount >= 1 then GateInfo.sReceiveMsg := '';
        Inc(nCount);
      end;
    end;
  except
    MainOutMessage('[Exception] TFrmMain.DecodeGateData');
  end;
end;

function TFrmMain.KickUser(Config: pTConfig; UserInfo: pTM2UserInfo;
  nKickType: Integer): Boolean;
resourcestring
  sKickMsg = '踢除: %s';
begin
  Result := False;
  if Config.boShowDetailMsg then
    MainOutMessage(Format(sKickMsg, [UserInfo.sUserIPaddr]));
    SendGateKickMsg(UserInfo.Socket, UserInfo.sSockIndex);
  case nKickType of
    0: SendGateKickMsg(UserInfo.Socket, UserInfo.sSockIndex);
  end;
  Result := True;
end;

procedure TFrmMain.ProcessUserMsg(Config: pTConfig; UserInfo: pTM2UserInfo;
  GateInfo: pTLoginGateInfo; sMsg: string);
var
  sDefMsg: string;
  sData: string;
  DefMsg: TDefaultMessage;
  nCode: Byte;
begin
  nCode:= 0;
  try
    if (UserInfo = nil) or (GateInfo = nil) then Exit;//20090807 增加
    sDefMsg := Copy(sMsg, 1, DEFBLOCKSIZE);
    sData := Copy(sMsg, DEFBLOCKSIZE + 1, Length(sMsg) - DEFBLOCKSIZE);
    DefMsg := DecodeMessage(sDefMsg);
    nCode:= 1;
    //MainOutMessage('Code: ' + IntToStr(DefMsg.Ident) + ' Msg: ' + sData);
    case DefMsg.Ident of
      GM_LOGIN:begin// DLUserLogin(Config, UserInfo, sData);//代理用户登陆
        nCode:= 2;
        DLUserLoginThread:= TDLUserLoginThread.Create(Owner);
        DLUserLoginThread.GateInfo := GateInfo;
        DLUserLoginThread.UserInfo:= UserInfo;
        DLUserLoginThread.SQLText:= sData;
        DLUserLoginThread.Resume;
      end;
      GM_ADDUSER: begin// AddUser(Config, UserInfo, sData);//代理添加用户
        nCode:= 3;
        UserMsgThread0:= TUserMsgThread.Create(Owner, 0);
        UserMsgThread0.UserInfo:= UserInfo;
        UserMsgThread0.bois176 := DefMsg.Series = 1;
        UserMsgThread0.Config:= Config;
        UserMsgThread0.SQLText:= sData;
        UserMsgThread0.Resume;
      end;
      GM_GETUSER: begin//CheckAccount(Config, UserInfo, sData);//代理检测用户是否存在
        nCode:= 4;
        UserMsgThread1:= TUserMsgThread.Create(Owner, 1);
        UserMsgThread1.UserInfo:= UserInfo;
        UserMsgThread1.Config:= Config;
        UserMsgThread1.SQLText:= sData;
        UserMsgThread1.Resume;
      end;
      GM_USERLOGIN:begin//UserLogin(Config, UserInfo, sData); //用户登陆
        nCode:= 5;
        QueryThread:= TQueryThread.Create(Owner);
        QueryThread.GateInfo := GateInfo;
        QueryThread.UserInfo:= UserInfo;
        QueryThread.SQLText:= sData;
        QueryThread.Resume;
      end;
      GM_CHANGEPASS: begin// DLChangePass(Config, UserInfo, sData); //代理修改密码
        nCode:= 6;
        UserMsgThread2:= TUserMsgThread.Create(Owner, 2);
        UserMsgThread2.UserInfo:= UserInfo;
        UserMsgThread2.Config:= Config;
        UserMsgThread2.SQLText:= sData;
        UserMsgThread2.Resume;
      end;
      {GM_USERCHANGEPASS: begin// ChangePass(Config, UserInfo, sData);//用户修改密码
        nCode:= 7;
        UserMsgThread3:= TUserMsgThread.Create(Owner, 3);
        UserMsgThread3.UserInfo:= UserInfo;
        UserMsgThread3.Config:= Config;
        UserMsgThread3.SQLText:= sData;
        UserMsgThread3.Resume;
      end; }
      GM_USERCHECKMAKEKEYANDDAYMAKENUM: begin//验证密钥匙和今日生成次数
        nCode:= 8;
        UserMsgThread4:= TUserMsgThread.Create(Owner, 4);
        UserMsgThread4.UserInfo:= UserInfo;
        UserMsgThread4.Config:= Config;
        UserMsgThread4.SQLText:= sData;
        UserMsgThread4.Resume;
      end;
      GM_USERMAKELOGIN: begin//生成登陆器
        nCode:= 9;
        UserMsgThread5:= TUserMsgThread.Create(Owner, 5);
        UserMsgThread5.UserInfo:= UserInfo;
        UserMsgThread5.Config:= Config;
        UserMsgThread5.SQLText:= sData;
        UserMsgThread5.Resume;
      end;
      GM_USERMAKEGATE: begin//生成网关
        nCode:= 10;
        UserMsgThread6:= TUserMsgThread.Create(Owner, 6);
        UserMsgThread6.UserInfo:= UserInfo;
        UserMsgThread6.Config:= Config;
        UserMsgThread6.SQLText:= sData;
        UserMsgThread6.Resume;
      end;
      //M2相关
      GM_GETM2USER: begin //检测M2用户是否存在
        nCode:= 12;
        UserMsgThread7:= TUserMsgThread.Create(Owner, 7);
        UserMsgThread7.UserInfo:= UserInfo;
        UserMsgThread7.Config:= Config;
        UserMsgThread7.SQLText:= sData;
        UserMsgThread7.Resume;
      end;
      GM_ADDM2USER: begin//代理添加M2用户
        nCode:= 13;
        UserMsgThread8:= TUserMsgThread.Create(Owner, 8);
        UserMsgThread8.UserInfo:= UserInfo;
        UserMsgThread8.Config:= Config;
        UserMsgThread8.bois176 := DefMsg.Series = 1;
        UserMsgThread8.SQLText:= sData;
        UserMsgThread8.Resume;
      end;
      GM_USERCHECKMAKEUPDATADATAUNM: begin//检查用户修改信息的次数
        nCode:= 14;
        UserMsgThread9:= TUserMsgThread.Create(Owner, 9);
        UserMsgThread9.UserInfo:= UserInfo;
        UserMsgThread9.Config:= Config;
        UserMsgThread9.SQLText:= sData;
        UserMsgThread9.Resume;
      end;
     { GM_USERUPDATAM2REGDATAIP: begin //修改用户IP信息
        UserMsgThread10:= TUserMsgThread.Create(Owner, 10);
        UserMsgThread10.UserInfo:= UserInfo;
        UserMsgThread10.Config:= Config;
        UserMsgThread10.SQLText:= sData;
        UserMsgThread10.Resume;
      end;}
      GM_USERUPDATAM2REGDATAHARD: begin
        nCode:= 15;
        UserMsgThread11:= TUserMsgThread.Create(Owner, 11);
        UserMsgThread11.UserInfo:= UserInfo;
        UserMsgThread11.Config:= Config;
        UserMsgThread11.SQLText:= sData;
        UserMsgThread11.Resume;
      end;
      GM_USERMAKEM2REG: begin 
        nCode:= 16;
        UserMsgThread12:= TUserMsgThread.Create(Owner, 12);
        UserMsgThread12.UserInfo:= UserInfo;
        UserMsgThread12.Config:= Config;
        UserMsgThread12.SQLText:= sData;
        UserMsgThread12.Resume;
      end;
      GM_USERM2LOGIN: begin //引擎用户登陆
        nCode:= 17;
        M2QueryThread:= TM2QueryThread.Create(Owner);
        M2QueryThread.GateInfo := GateInfo;
        M2QueryThread.UserInfo:= UserInfo;
        M2QueryThread.SQLText:= sData;
        M2QueryThread.Resume;
      end;
      {GM_USERM2CHANGEPASS: begin
        nCode:= 18;
        UserMsgThread13:= TUserMsgThread.Create(Owner, 13);
        UserMsgThread13.UserInfo:= UserInfo;
        UserMsgThread13.Config:= Config;
        UserMsgThread13.SQLText:= sData;
        UserMsgThread13.Resume;
      end; }
      GM_USERCHECKM2DAYMAKENUM: begin
        nCode:= 19;
        UserMsgThread14:= TUserMsgThread.Create(Owner, 14);
        UserMsgThread14.UserInfo:= UserInfo;
        UserMsgThread14.Config:= Config;
        UserMsgThread14.SQLText:= sData;
        UserMsgThread14.Resume;
      end;
      //1.76登陆器
      GM_176USERLOGIN: begin
        nCode:=20;
        L176QueryThread:= T176QueryThread.Create(Owner);
        L176QueryThread.GateInfo := GateInfo;
        L176QueryThread.UserInfo:= UserInfo;
        L176QueryThread.SQLText:= sData;
        L176QueryThread.Resume;
      end;
      GM_176USERCHECKMAKEKEYANDDAYMAKENUM: begin//验证密钥匙和今日生成次数
        nCode:= 21;
        UserMsgThread15:= TUserMsgThread.Create(Owner, 15);
        UserMsgThread15.UserInfo:= UserInfo;
        UserMsgThread15.Config:= Config;
        UserMsgThread15.SQLText:= sData;
        UserMsgThread15.Resume;
      end;
      GM_176USERMAKELOGIN: begin //生成登陆器 1.76
        nCode:= 22;
        UserMsgThread16:= TUserMsgThread.Create(Owner, 16);
        UserMsgThread16.UserInfo:= UserInfo;
        UserMsgThread16.Config:= Config;
        UserMsgThread16.SQLText:= sData;
        UserMsgThread16.Resume;
      end;
      GM_176USERMAKEGATE: begin //生成网关 1.76
        nCode:= 23;
        UserMsgThread17:= TUserMsgThread.Create(Owner, 17);
        UserMsgThread17.UserInfo:= UserInfo;
        UserMsgThread17.Config:= Config;
        UserMsgThread17.SQLText:= sData;
        UserMsgThread17.Resume;
      end;
      GM_176USERM2LOGIN: begin //引擎用户登陆
        nCode:= 24;
        L176M2QueryThread:= T176M2QueryThread.Create(Owner);
        L176M2QueryThread.GateInfo := GateInfo;
        L176M2QueryThread.UserInfo:= UserInfo;
        L176M2QueryThread.SQLText:= sData;
        L176M2QueryThread.Resume;
      end;
      GM_176USERCHECKMAKEUPDATADATAUNM: begin//1.76检查用户修改信息的次数
        nCode:= 25;
        UserMsgThread18:= TUserMsgThread.Create(Owner, 18);
        UserMsgThread18.UserInfo:= UserInfo;
        UserMsgThread18.Config:= Config;
        UserMsgThread18.SQLText:= sData;
        UserMsgThread18.Resume;
      end;
      GM_176USERUPDATAM2REGDATAHARD: begin //1.76修改M2硬件信息
        nCode:= 26;
        UserMsgThread19:= TUserMsgThread.Create(Owner, 19);
        UserMsgThread19.UserInfo:= UserInfo;
        UserMsgThread19.Config:= Config;
        UserMsgThread19.SQLText:= sData;
        UserMsgThread19.Resume;
      end;
      GM_176USERCHECKM2DAYMAKENUM: begin //1.76检查今日生成次数
        nCode:= 27;
        UserMsgThread20:= TUserMsgThread.Create(Owner, 20);
        UserMsgThread20.UserInfo:= UserInfo;
        UserMsgThread20.Config:= Config;
        UserMsgThread20.SQLText:= sData;
        UserMsgThread20.Resume;
      end;
      GM_176USERMAKEM2REG: begin //1.76生成注册文件
        nCode:= 28;
        UserMsgThread21:= TUserMsgThread.Create(Owner, 21);
        UserMsgThread21.UserInfo:= UserInfo;
        UserMsgThread21.Config:= Config;
        UserMsgThread21.SQLText:= sData;
        UserMsgThread21.Resume;
      end;
      GM_UPDATEM2USERREGDATE: begin //M2延期
        nCode:= 29;
        UserMsgThread22:= TUserMsgThread.Create(Owner, 22);
        UserMsgThread22.UserInfo:= UserInfo;
        UserMsgThread22.bois176 := DefMsg.Series = 1;
        UserMsgThread22.Config:= Config;
        UserMsgThread22.SQLText:= sData;
        UserMsgThread22.Resume;
      end;
      else begin
        UserInfo.boKick:= True;//20090803
      end;
    end;
  except
    MainOutMessage('[Exception] TFrmMain.ProcessUserMsg ' + 'wIdent: ' + IntToStr(DefMsg.Ident) + ' nCode:' + IntToStr(nCode));
  end;
end;

procedure TFrmMain.SendKeepAlivePacket(Socket: TCustomWinSocket);
begin
  if Socket.Connected then Socket.SendText('%++$');
end;

procedure TFrmMain.ReceiveCloseUser(Config: pTConfig; sSockIndex: string;
  GateInfo: pTLoginGateInfo);
var
  UserInfo: pTM2UserInfo;
  I{, II}: Integer;
resourcestring
  sCloseMsg = '关闭: %s';
begin
  for I := 0 to GateInfo.UserList.Count - 1 do begin
    UserInfo := GateInfo.UserList.Items[I];
    if UserInfo.sSockIndex = sSockIndex then begin
      if Config.boShowDetailMsg then
        MainOutMessage(Format(sCloseMsg, [UserInfo.sUserIPaddr]));
      Dispose(UserInfo);
      GateInfo.UserList.Delete(I);
      Break;
    end;
  end;
end;

procedure TFrmMain.ReceiveOpenUser(Config: pTConfig; sSockIndex,
  sIPaddr: string; GateInfo: pTLoginGateInfo);
var
  UserInfo: pTM2UserInfo;
  I: Integer;
  sGateIPaddr: string;
  sUserIPaddr: string;
resourcestring
  sOpenMsg = '连接: %s/%s';
begin
  sIPaddr := GetValidStr3(sIPaddr, sUserIPaddr, ['/']);
  try
    for I := 0 to GateInfo.UserList.Count - 1 do begin
      UserInfo := GateInfo.UserList.Items[I];
      if UserInfo.sSockIndex = sSockIndex then begin
        UserInfo.sUserIPaddr := sUserIPaddr;
        UserInfo.sReceiveMsg := '';
        UserInfo.dwClientTick := GetTickCount();
        Exit;
      end;
    end;
    New(UserInfo);
    UserInfo.sUserIPaddr := sUserIPaddr;
    UserInfo.sSockIndex := sSockIndex;
    UserInfo.Socket := GateInfo.Socket;
    UserInfo.sReceiveMsg := '';
    //UserInfo.nRemoteAddr := MakeIPToInt(sUserIPaddr);
    UserInfo.dwClientTick := GetTickCount();
    UserInfo.boKick := False;
    UserInfo.boLogined := False;
    UserInfo.dwKickTick := GetTickCount + {1000 * 60 * 5}300000;
    //FillChar(UserInfo.SuperSession, SizeOf(TSuperSession), 0);
    GateInfo.UserList.Add(UserInfo);
    if Config.boShowDetailMsg then
      MainOutMessage(Format(sOpenMsg, [sUserIPaddr, sGateIPaddr]));
  except
    MainOutMessage('TFrmMain.ReceiveOpenUser');
  end;
end;

procedure TFrmMain.ReceiveSendUser(Config: pTConfig; sSockIndex: string;
  GateInfo: pTLoginGateInfo; sData: string);
var
  UserInfo: pTM2UserInfo;
  I: Integer;
begin
  try
    for I := 0 to GateInfo.UserList.Count - 1 do begin
      UserInfo := GateInfo.UserList.Items[I];
      if UserInfo.sSockIndex = sSockIndex then begin
        if Length(UserInfo.sReceiveMsg) < 4069 then begin
          UserInfo.sReceiveMsg := UserInfo.sReceiveMsg + sData;
        end;
        Break;
      end;
    end;
  except
    MainOutMessage('TFrmMain.ReceiveSendUser');
  end;
end;

procedure TFrmMain.SendGateMsg(Socket: TCustomWinSocket; sSockIndex,
  sMsg: string);
var
  sSendMsg: string;
begin
  if (Socket <> nil) then begin
    if Socket.Connected then begin
      sSendMsg := '%' + sSockIndex + '/#' + sMsg + '!$';
      while True do begin
        if Socket.SendText(sSendMsg) <> -1 then Break;  //防掉包
      end;
    end;
  end;
end;

procedure TFrmMain.TimerTimer(Sender: TObject);
var
  I: Integer;
  GateInfo: pTLoginGateInfo;
  Config: pTConfig;
  nRow: Integer;
begin
  if boStarted then begin
    I := (GetTickCount() - g_dwStartTick) div 1000;
    LbRunTime.Caption :='运行时间:'+ IntToStr(I div 3600) + ':' + IntToStr((I div 60) mod 60) + ':' + IntToStr(I mod 60) ;
    Label2.Caption := '代理状态:'+ BoolToStr(boGateReady);

    if (GetTickCount() / 86400000) >= 36 then Label1.Font.Color := clRed
    else Label1.Font.Color := clBlack;
    Label1.Caption := CurrToStr((GetTickCount() / 86400000)) + '天';

    nRow := 1;
    Config := @g_Config;
    EnterCriticalSection(Config.GateCriticalSection);
    try
      if Config.GateList.Count > 0 then begin
        for I := 0 to Config.GateList.Count - 1 do begin
          GateInfo := Config.GateList.Items[I];
          GridGate.Cells[0, I + 1] := '';
          GridGate.Cells[1, I + 1] := '';
          GridGate.Cells[2, I + 1] := '';
          GridGate.Cells[3, I + 1] := '';
          GridGate.Cells[4, I + 1] := '';
          GridGate.Cells[0, nRow] := IntToStr(I);
          GridGate.Cells[1, nRow] := GateInfo.sIPaddr + ':' + IntToStr(GateInfo.nPort);
          GridGate.Cells[2, nRow] := IntToStr(GateInfo.nSuccesCount);
          GridGate.Cells[3, nRow] := IntToStr(GateInfo.nFailCount);
          GridGate.Cells[4, nRow] := IntToStr(GateInfo.UserList.Count);
          Inc(nRow);
        end;
      end else begin
        for I := 0 to GridGate.RowCount - 1 do begin
          for nRow := 0 to GridGate.ColCount - 1 do begin
            if Odd(i) then
            GridGate.Cells[nRow, i] := '';
          end;
        end;
      end;
    finally
      LeaveCriticalSection(Config.GateCriticalSection);
    end;
  end;
  if not boGateReady{是否和生成服务端连接} and (boServiceStart) then begin//与生成服务端断开,则自动连接
    if (GetTickCount - dwReConnectServerTick) > 2000 {30 * 1000} then begin
      dwReConnectServerTick := GetTickCount();
      ClientSocket.Active := False;
      ClientSocket.Address := g_ServerIp;//'127.0.0.1';
      ClientSocket.Port := g_ServerPort;//37002;
      ClientSocket.Active := True;
    end;
  end;
  {if (GetTickCount - dwSQLConnectTick) > 2000  then begin
    dwSQLConnectTick := GetTickCount();
    try
      //FrmDm.ADOConn.Connected :=False;
      FrmDm.ADOConn.Connected :=True;
    except
      on E: Exception do begin
        MainOutMessage('XXX:'+IntToStr(FrmDm.ADOConn.Errors.Count));
        MainOutMessage(E.Message);
        FrmDm.ConnectedAccess('');
      end;
    end;
    try
      //FrmDm.ADOConn2.Connected :=False;
      FrmDm.ADOConn2.Connected :=True;
    except
      on E: Exception do begin
        MainOutMessage('@@@:'+IntToStr(FrmDm.ADOConn2.Errors.Count));
        MainOutMessage(E.Message);
        FrmDm.ConnectedAccess2;
      end;
    end;
  end;  }
end;

{
procedure TFrmMain.DLChangePass(Config: pTConfig; UserInfo: pTM2UserInfo;
  sData: string);
var
  sDest: string;
  sLoginID: string;
  sOldPass: string;
  sNewPass: string;
  AdoQuery: TADOQuery;
  nCheckCode: Integer;
  DefMsg: TDefaultMessage;
begin
  if UserInfo.boLogined then begin  //如果用户已经登陆
    sDest := DecryptString(sData);
    sDest := GetValidStr3(sDest, sLoginID, ['/']);
    sDest := GetValidStr3(sDest, sOldPass, ['/']);
    sDest := GetValidStr3(sDest, sNewPass, ['/']);
    if sLoginID = UserInfo.sAccount then begin
      if sOldPass = UserInfo.sPassWord then begin
        AdoQuery := TADOQuery.Create(nil);
        try
          AdoQuery.Connection := FrmDm.ADOconn;
          with AdoQuery do begin
            Close;
            SQL.Clear;
            SQL.Add('Update DLUserInfo set Pass=:a1 Where [User]=:a3') ;
            parameters.ParamByName('a1').DataType:=Ftstring;
            parameters.ParamByName('a1').Value := Trim(sNewPass);
            parameters.ParamByName('a2').DataType :=Ftstring;
            parameters.ParamByName('a2').Value := Trim(sLoginID);
            try
              ExecSQL;
              nCheckCode := 1;
            except
              nCheckCode := -4;
            end;
          end;
        finally
          AdoQuery.Free;
        end;
      end else nCheckCode := -3;
    end else nCheckCode := -2;
  end else nCheckCode := -1;

  if nCheckCode = 1 then begin
    DefMsg := MakeDefaultMsg(SM_CHANGEPASS_SUCCESS, 0, 0, 0, 0);
    SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + '');
  end else begin
    DefMsg := MakeDefaultMsg(SM_CHANGEPASS_FAIL, nCheckCode, 0, 0, 0);
    SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + '');
  end;
end;  }
{
procedure TFrmMain.ChangePass(Config: pTConfig; UserInfo: pTM2UserInfo;
  sData: string);
var
  sDest: string;
  sLoginID: string;
  sOldPass: string;
  sNewPass: string;
  AdoQuery: TADOQuery;
  nCheckCode: Integer;
  DefMsg: TDefaultMessage;
begin
  if UserInfo.boLogined then begin  //如果用户已经登陆
    sDest := DecryptString(sData);
    sDest := GetValidStr3(sDest, sLoginID, ['/']);
    sDest := GetValidStr3(sDest, sOldPass, ['/']);
    sDest := GetValidStr3(sDest, sNewPass, ['/']);
    if sLoginID = UserInfo.sAccount then begin
      if sOldPass = UserInfo.sPassWord then begin
        AdoQuery := TADOQuery.Create(nil);
        try
          AdoQuery.Connection := FrmDm.ADOconn;
          with AdoQuery do begin
            Close;
            SQL.Clear;
            //SQL.Add('Update UserInfo Set [Pass]="'+sNewPass+'" Where [User]="'+sLoginID+'"');
            SQL.Add('Update UserInfo set [Pass]=:a1 Where [User]=:a3') ;
            parameters.ParamByName('a1').DataType:=Ftstring;
            parameters.ParamByName('a1').Value := Trim(sNewPass);
            parameters.ParamByName('a2').DataType :=Ftstring;
            parameters.ParamByName('a2').Value := Trim(sLoginID);
            try
              ExecSQL;
              nCheckCode := 1;
            except
              nCheckCode := -4;
            end;
          end;
        finally
          AdoQuery.Free;
        end;
      end else nCheckCode := -3;
    end else nCheckCode := -2;
  end else nCheckCode := -1;

  if nCheckCode = 1 then begin
    DefMsg := MakeDefaultMsg(SM_USERCHANGEPASS_SUCCESS, 0, 0, 0, 0);
    SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + '');
  end else begin
    DefMsg := MakeDefaultMsg(SM_USERCHANGEPASS_FAIL, nCheckCode, 0, 0, 0);
    SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + '');
  end;
end;     }
{
procedure TFrmMain.MakeGate(Config: pTConfig; UserInfo: pTM2UserInfo;
  sData: string);
var
  Judge: TADOQuery;
  sDest: string;
  sUserKeyPass: string;
  sKeyPass: string;
  sGatePass: string;
  sSendData: string;
begin
  if UserInfo.boLogined then begin
    Judge:=TADOQuery.Create(Nil);
    try
      Judge.Connection := FrmDm.ADOconn;
      with Judge do begin
        Close;
        SQL.Clear;
        SQL.Add('Select MakeKey,GatePass From UserInfo Where [User]=:a1 and [Pass]=:a2');
        Parameters.ParamByName('a1').DataType:=Ftstring;
        Parameters.ParamByName('a1').Value :=UserInfo.sAccount;
        Parameters.ParamByName('a2').DataType :=Ftstring;
        Parameters.ParamByName('a2').Value :=UserInfo.sPassWord;
        Open();
        if RecordCount > 0 then begin
         sKeyPass := FieldByName('MakeKey').AsString;
         sGatePass := FieldByName('GatePass').AsString;
        end;
        Close;
      end;
    finally
      Judge.Free;
    end;
    sDest := DecryptString(sData);
    sDest := GetValidStr3(sDest, sUserKeyPass, ['/']);
    if (sUserKeyPass <> '') and (sGatePass <> '') and (Length(sGatePass) = 20) then begin
      if sUserKeyPass = sKeyPass then begin
        sSendData := UserInfo.sAccount + '/' + sGatePass + '/' + UserInfo.sSockIndex;
        ClientSocket.Socket.SendText('%G'+ EncryptString(sSendData) + '$');
      end;
    end;
  end;
end;

procedure TFrmMain.MakeLogin(Config: pTConfig; UserInfo: pTM2UserInfo;
  sData: string);
var
  Judge: TADOQuery;
  sGameListUrl: string;
  sBakGameListUrl: string;
  sPatchListUrl: string;
  sGameMonListUrl: string;
  sGameESystemUrl: string;
  sPass: string;
  sDest: string;
  sLoginName: string;
  sClientFileName: string;
  sLocalGameListName: string;
  sLoginSink: string;
  sboLoginMainImages: string;
  sboAssistantFilter: string;
  sSendData: string;
begin
  if UserInfo.boLogined then begin //如果已经登陆
    Judge:=TADOQuery.Create(Nil);
      try
       Judge.Connection := FrmDm.ADOconn;
       with Judge do begin
         Close;
         SQL.Clear;
         SQL.Add('Select GameListUrl,BakGameListUrl,PatchListUrl,GameMonListUrl,GameESystemUrl,GatePass From UserInfo');
         SQL.Add(' Where [User]=:a1 and [Pass]=:a2');
         Parameters.ParamByName('a1').DataType:=Ftstring;
         Parameters.ParamByName('a1').Value :=UserInfo.sAccount;
         Parameters.ParamByName('a2').DataType :=Ftstring;
         Parameters.ParamByName('a2').Value :=UserInfo.sPassWord;
         Open();
         if RecordCount > 0 then begin
           sGameListUrl := FieldByName('GameListUrl').AsString;
           sBakGameListUrl := FieldByName('BakGameListUrl').AsString;
           sPatchListUrl := FieldByName('PatchListUrl').AsString;
           sGameMonListUrl := FieldByName('GameMonListUrl').AsString;
           sGameESystemUrl := FieldByName('GameESystemUrl').AsString;
           sPass := FieldByName('GatePass').AsString;
         end;
         Close;
       end;
      finally
       Judge.Free;
      end;
      sDest := DecryptString(sData);
      sDest := GetValidStr3(sDest, sLoginName, ['/']);
      sDest := GetValidStr3(sDest, sClientFileName, ['/']);
      sDest := GetValidStr3(sDest, sLocalGameListName, ['/']);
      sDest := GetValidStr3(sDest, sLoginSink, ['/']);
      sDest := GetValidStr3(sDest, sboLoginMainImages, ['/']);
      sDest := GetValidStr3(sDest, sboAssistantFilter, ['/']);
      if (sLoginName <> '') and (sClientFileName <> '') and (sLocalGameListName <> '') and (sLoginSink <> '') and (sboLoginMainImages <> '') and (sboAssistantFilter <> '') then begin
        sSendData := UserInfo.sAccount + ',' + UserInfo.sSockIndex + ',' +
          sGameListUrl + ',' + sBakGameListUrl + ',' + sPatchListUrl + ',' + sGameMonListUrl + ',' +
          sGameESystemUrl + ',' + sPass + ',' + sLoginName + ',' + sClientFileName + ',' +
          sLocalGameListName + ',' + sLoginSink + ',' + sboLoginMainImages + ',' + sboAssistantFilter;
        ClientSocket.Socket.SendText('%L'+ EncryptString(sSendData) + '$');
      end;
  end;
end;

procedure TFrmMain.CheckMakeKeyAndDayMakeNum(Config: pTConfig;
  UserInfo: pTM2UserInfo; sData: string);
var
  sKey: string;
  nCheckCode: Integer;
  Judge: TADOQuery;
  sUserKey: string;
  nDayMakeNum: Integer;
  DefMsg: TDefaultMessage;
begin
  nCheckCode := -1;
  if UserInfo.boLogined then begin
    sKey := DecryptString(sData);
    if (sKey <> '') and (Length(sKey) = 100) then begin
      Judge:=TADOQuery.Create(Nil);
      try
       Judge.Connection := FrmDm.ADOconn;
       with Judge do begin
         Close;
         SQL.Clear;
         SQL.Add('Select MakeKey,DayMakeNum From UserInfo');
         SQL.Add(' Where [User]=:a1 and [Pass]=:a2');
         Parameters.ParamByName('a1').DataType:=Ftstring;
         Parameters.ParamByName('a1').Value :=UserInfo.sAccount;
         Parameters.ParamByName('a2').DataType :=Ftstring;
         Parameters.ParamByName('a2').Value :=UserInfo.sPassWord;
         Open();
         if RecordCount > 0 then begin
           sUserKey := FieldByName('MakeKey').AsString;
           nDayMakeNum := FieldByName('DayMakeNum').AsInteger;
         end;
         Close;
       end;
      finally
       Judge.Free;
      end;
      if sUserKey = sKey then begin
        if nDayMakeNum < g_btMaxDayMakeNum then
          nCheckCode := 1
        else nCheckCode := -3;
      end else nCheckCode := -2;
    end else nCheckCode := -2;
  end else nCheckCode := -1;
  if nCheckCode = 1 then begin
    DefMsg := MakeDefaultMsg(SM_USERCHECKMAKEKEYANDDAYMAKENUM_SUCCESS, 0, 0, 0, 0);
    SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + '');
  end else begin
    DefMsg := MakeDefaultMsg(SM_USERCHECKMAKEKEYANDDAYMAKENUM_FAIL, nCheckCode, 0, 0, 0);
    SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + '');
  end;
end; }

procedure TFrmMain.N2Click(Sender: TObject);
begin
  //  ClientSocket.Socket.SendText('%L'+ '11' + '$');
  MainOutMessage(RivestStr('E10ADC3949BA59ABBE56E057F20F883E'));
end;

procedure TFrmMain.ClientSocketRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
  sRecvMsg: string;
begin
  sRecvMsg := Socket.ReceiveText;
  MakeSockeMsgList.Add(sRecvMsg);
end;

procedure TFrmMain.ClientSocketConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  boGateReady := True;
  MainOutMessage('生成服务器(' + Socket.RemoteAddress + ':' + IntToStr(Socket.RemotePort) + ')连接成功');
end;

procedure TFrmMain.ClientSocketDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  boGateReady := False;
  MainOutMessage('生成服务器断开连接');
end;

procedure TFrmMain.ClientSocketError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
  Socket.Close;
  ErrorCode := 0;
  boGateReady := False;
end;

procedure TFrmMain.MENU_CONTROL_STARTClick(Sender: TObject);
begin
  StartService();
end;

procedure TFrmMain.MENU_CONTROL_STOPClick(Sender: TObject);
begin
  if Application.MessageBox('是否确认停止服务？', '确认信息', MB_YESNO + MB_ICONQUESTION) = IDYES then
    StopService();
end;

procedure TFrmMain.N4Click(Sender: TObject);
begin
  StartTimer.Enabled := True;
end;

procedure TFrmMain.N8Click(Sender: TObject);
begin
  FrmBasicSet := TFrmBasicSet.Create(Owner);
  FrmBasicSet.Open();
  FrmBasicSet.Free;
end;

procedure TFrmMain.SendGateKickMsg(Socket: TCustomWinSocket;
  sSockIndex: string);
var
  sSendMsg: string;
begin
  if (Socket <> nil) and Socket.Connected then begin
    sSendMsg := '%+-' + sSockIndex + '$';
    Socket.SendText(sSendMsg);
  end;
end;

initialization
  begin
    g_MainShowMsgList := nil;
    g_MainShowMsgList := TStringList.Create;
    MakeSockeMsgList := TStringList.Create;
    InitializeCriticalSection(g_CriticalSection);
    InitializeCriticalSection(MakeResultCs);
  end;
finalization
  begin
    g_MainShowMsgList.Free;
    MakeSockeMsgList.Free;
    DeleteCriticalSection(g_CriticalSection);
    DeleteCriticalSection(MakeResultCs);
  end;
end.
