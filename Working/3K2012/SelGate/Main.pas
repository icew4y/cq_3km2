unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, JSocket, WinSock, ExtCtrls, ComCtrls, Menus, IniFiles, GateShare,
  Common, EDcode, Grobal2;
type
  TNoLegalSession = record//不合法会话结构
    sIP: string;//IP地址
    nErrorCount: Integer;//不合法连接次数
  end;
  pTNoLegalSession = ^TNoLegalSession;

  TUserSession = record
    Socket: TCustomWinSocket;
    sRemoteIPaddr: string;
    nSendMsgLen: Integer;
    nReviceMsgLen: Integer;
    bo0C: Boolean;
    dw10Tick: LongWord;
    nCheckSendLength: Integer;
    boSendAvailable: Boolean;
    boSendCheck: Boolean;
    dwSendLockTimeOut: LongWord;
    n20: Integer;
    dwUserTimeOutTick: LongWord;
    SocketHandle: Integer;
    sIP: string;
    MsgList: TStringList;
    dwConnctCheckTick: LongWord;
    dwReceiveTick: LongWord;
    dwReceiveTimeTick: LongWord;

    nReviceMsgLength: Integer;
    dwReceiveMsgTick: LongWord;
    nTemRandomID: Integer; //临时随机ID
    boLegalConnection: Boolean;//是否合法连接 20091121
  end;
  pTUserSession = ^TUserSession;
  TSessionArray = array[0..GATEMAXSESSION - 1] of TUserSession;
  TFrmMain = class(TForm)
    ServerSocket: TServerSocket;
    MemoLog: TMemo;
    SendTimer: TTimer;
    ClientSocket: TClientSocket;
    Panel: TPanel;
    Timer: TTimer;
    DecodeTimer: TTimer;
    LbHold: TLabel;
    LbLack: TLabel;
    Label2: TLabel;
    StatusBar: TStatusBar;
    MainMenu: TMainMenu;
    MENU_CONTROL: TMenuItem;
    StartTimer: TTimer;
    MENU_CONTROL_START: TMenuItem;
    MENU_CONTROL_STOP: TMenuItem;
    MENU_CONTROL_RECONNECT: TMenuItem;
    MENU_CONTROL_CLEAELOG: TMenuItem;
    MENU_CONTROL_EXIT: TMenuItem;
    MENU_VIEW: TMenuItem;
    MENU_VIEW_LOGMSG: TMenuItem;
    MENU_OPTION: TMenuItem;
    MENU_OPTION_GENERAL: TMenuItem;
    MENU_OPTION_IPFILTER: TMenuItem;
    H1: TMenuItem;
    S1: TMenuItem;
    N1: TMenuItem;

    procedure MemoLogChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SendTimerTimer(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure DecodeTimerTimer(Sender: TObject);
    procedure ClientSocketConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocketDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocketError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure ClientSocketRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure ServerSocketClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocketClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocketClientError(Sender: TObject;
      Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
      var ErrorCode: Integer);
    procedure ServerSocketClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure StartTimerTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MENU_CONTROL_STARTClick(Sender: TObject);
    procedure MENU_CONTROL_STOPClick(Sender: TObject);
    procedure MENU_CONTROL_RECONNECTClick(Sender: TObject);
    procedure MENU_CONTROL_CLEAELOGClick(Sender: TObject);
    procedure MENU_CONTROL_EXITClick(Sender: TObject);
    procedure MENU_VIEW_LOGMSGClick(Sender: TObject);
    procedure MENU_OPTION_GENERALClick(Sender: TObject);
    procedure MENU_OPTION_IPFILTERClick(Sender: TObject);
    procedure S1Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
  private
    dwShowMainLogTick: LongWord;
    boShowLocked: Boolean;
    TempLogList: TStringList;
    nSessionCount: Integer;
    StringList30C: TStringList;
    dwSendKeepAliveTick: LongWord;
    boServerReady: Boolean;
    StringList318: TStringList;

    dwDecodeMsgTime: LongWord;
    dwReConnectServerTick: LongWord;
    procedure ResUserSessionArray();
    procedure StartService();
    procedure StopService();
    procedure LoadConfig();
    procedure ShowLogMsg(boFlag: Boolean);
    function IsBlockIP(sIPaddr: string): Boolean;
    function IsConnLimited(sIPaddr: string; SocketHandle: Integer): Boolean;
    function AddAttackIP(sIPaddr: string): Boolean;
    procedure CloseSocket(nSocketHandle: Integer);
    function SendUserMsg(UserSession: pTUserSession; sSendMsg: string): Integer;
    procedure ShowMainLogMsg;
    procedure IniUserSessionArray;
    function CloseSocketAndGetIPAddr(nSocketHandle: Integer): string;
    function AddNoLegalIPToList(sIPaddr: string; Socket: TCustomWinSocket): Boolean;//不合法会话加入列表，当达到指定次数时，加入过滤列表 20091121
    { Private declarations }
  public
    procedure CloseConnect(sIPaddr: string);
    function AddBlockIP(sIPaddr: string): Integer;
    function AddTempBlockIP(sIPaddr: string): Integer;
    procedure MyMessage(var MsgData: TWmCopyData); message WM_COPYDATA;
    { Public declarations }
  end;
procedure MainOutMessage(sMsg: string; nMsgLevel: Integer);
var
  FrmMain: TFrmMain;
  g_SessionArray: TSessionArray;
  ClientSockeMsgList: TStringList;
  sProcMsg: string;
implementation

uses HUtil32, GeneralConfig, IPaddrFilter, AboutUnit;

{$R *.DFM}
 //判断一个字符串是否为数字{填充垃圾代码}
function IsNum(str: string):boolean;
var
  i:integer;
begin
  for i:=1 to length(str) do
    if not (str[i] in ['0'..'9']) then begin
      Result:=false;
      exit;
    end;
  Result:=true;
end;

{--------------Memo里的前面取时间------------------------}
procedure MainOutMessage(sMsg: string; nMsgLevel: Integer);
var
  tMsg: string;
begin
  try
    CS_MainLog.Enter;
    if nMsgLevel <= nShowLogLevel then begin
      tMsg := '[' + TimeToStr(Now) + '] ' + sMsg;
      MainLogMsgList.Add(tMsg);
    end;
  finally
    CS_MainLog.Leave;
  end;
end;
{---------------------和客户端连接-------------------------}
procedure TFrmMain.ServerSocketClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  UserSession: pTUserSession;
  sRemoteIPaddr, sLocalIPaddr: string;
  nSockIndex: Integer;
begin
  Socket.nIndex := -1;
  sRemoteIPaddr := Socket.RemoteAddress;

  if IsBlockIP(sRemoteIPaddr) then begin
    Inc(m_nAttackCount);
    m_dwAttackTick := GetTickCount;
    if m_nAttackCount < 10 then begin
      MainOutMessage('过滤连接: ' + sRemoteIPaddr, 1);
    end;
    Socket.Close;
    Exit;
  end;

  if IsConnLimited(sRemoteIPaddr, Socket.SocketHandle) then begin
    if g_boChgDefendLevel then begin
      Inc(m_nAttackCount);
      m_dwAttackTick := GetTickCount;
      if m_nAttackCount >= g_nChgDefendLevel then begin
        if BlockMethod = mDisconnect then BlockMethod := mBlock;
        if g_nAttackLevel > 1 then g_nAttackLevel := 1;
      end;
    end;

    case BlockMethod of
      mDisconnect: begin
          Socket.Close;
        end;
      mBlock: begin
          AddTempBlockIP(sRemoteIPaddr);
          CloseConnect(sRemoteIPaddr);
        end;
      mBlockList: begin
          AddBlockIP(sRemoteIPaddr);
          CloseConnect(sRemoteIPaddr);
        end;
    end;
    if m_nAttackCount < 10 then MainOutMessage('端口攻击: ' + sRemoteIPaddr, 1);
    Exit;
  end;

  if g_boDynamicIPDisMode then begin
    sLocalIPaddr := ClientSocket.Socket.RemoteAddress;
  end else begin
    sLocalIPaddr := Socket.LocalAddress;
  end;

  if boGateReady then begin
    for nSockIndex := 0 to GATEMAXSESSION - 1 do begin
      UserSession := @g_SessionArray[nSockIndex];
      if UserSession.Socket = nil then begin
        UserSession.Socket := Socket;
        UserSession.sRemoteIPaddr := sRemoteIPaddr;
        UserSession.nSendMsgLen := 0;
        UserSession.nReviceMsgLen := 0;
        UserSession.bo0C := False;
        UserSession.dw10Tick := GetTickCount();
        UserSession.dwConnctCheckTick := GetTickCount();
        UserSession.boSendAvailable := True;
        UserSession.boSendCheck := False;
        UserSession.nCheckSendLength := 0;
        UserSession.n20 := 0;
        UserSession.dwUserTimeOutTick := GetTickCount();
        UserSession.SocketHandle := Socket.SocketHandle;
        UserSession.sIP := sRemoteIPaddr;
        UserSession.dwReceiveTick := GetTickCount();
        UserSession.nReviceMsgLength := 0;
        UserSession.dwReceiveMsgTick := GetTickCount();
        UserSession.MsgList.Clear;
        Randomize();  //随机种子
        UserSession.nTemRandomID := Random(100);
        UserSession.boLegalConnection:= False;//是否合法连接 20091121
        Socket.nIndex := nSockIndex;
        Inc(nSessionCount);
        break;
      end;
    end;
    if Socket.nIndex >= 0 then begin//通知DBServer.exe，有IP连接
      ClientSocket.Socket.SendText('%N' + IntToStr(Socket.SocketHandle) + '/' + sRemoteIPaddr + '/' + sLocalIPaddr + '$');
      Socket.SendText('#' + EncodeMessage(MakeDefaultMsg(SM_SENDLOGINKEY, UserSession.nTemRandomID, Random(100), Random(100), Random(100), Random(100))) + '!');//发密钥给客户端进行验证
      MainOutMessage('连接: ' + sRemoteIPaddr, 5);
    end else begin
      Socket.Close;
      MainOutMessage('踢除: ' + sRemoteIPaddr, 1);
    end;
  end else begin
    Socket.Close;
    MainOutMessage('踢除(未就绪): ' + sRemoteIPaddr, 1);
  end;
end;
{-----------------和客户端非连接--------------------}
procedure TFrmMain.ServerSocketClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  I, II: Integer;
  UserSession: pTUserSession;
  nSockIndex: Integer;
  sRemoteIPaddr: string;
  IPaddr: pTSockaddr;
  nIPaddr: Integer;
  IPList: TList;
begin
  sRemoteIPaddr := Socket.RemoteAddress;
  nSockIndex := Socket.nIndex;
  nIPaddr := inet_addr(PChar(sRemoteIPaddr));
  CurrIPaddrList.Lock;
  try
    for I := CurrIPaddrList.Count - 1 downto 0 do begin
      IPList := TList(CurrIPaddrList.Items[I]);
      if IPList <> nil then begin
        for II := IPList.Count - 1 downto 0 do begin
          IPaddr := IPList.Items[II];
          if (IPaddr.nIPaddr = nIPaddr) and (IPaddr.nSocketHandle = Socket.SocketHandle) then begin
            Dispose(IPaddr);
            IPList.Delete(II);
            if IPList.Count <= 0 then begin
              IPList.Free;
              CurrIPaddrList.Delete(I);
            end;
            break;
          end;
        end;
      end;
    end;
  finally
    CurrIPaddrList.UnLock;
  end;

  if (nSockIndex >= 0) and (nSockIndex < GATEMAXSESSION) then begin
    UserSession := @g_SessionArray[nSockIndex];
    UserSession.Socket := nil;
    UserSession.sRemoteIPaddr := '';
    UserSession.SocketHandle := -1;
    UserSession.MsgList.Clear;
    Dec(nSessionCount);
    if boGateReady then begin
      ClientSocket.Socket.SendText('%C' +
        IntToStr(Socket.SocketHandle) +
        '$');
      MainOutMessage('断开: ' + sRemoteIPaddr, 5);
    end;
  end;
end;
{--------------------和客户端发生错误---------------------}
procedure TFrmMain.ServerSocketClientError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
  StringList30C.Add('错误 ' + IntToStr(ErrorCode) + ': ' + Socket.RemoteAddress);
  Socket.Close;
  ErrorCode := 0;
end;
{----------------读取客户端发来的数据------------------}
procedure TFrmMain.ServerSocketClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
  UserSession: pTUserSession;
  nSockIndex: Integer;
  sRemoteAddress, sReviceMsg, s10, s1C: string;
  nPos: Integer;
  nMsgLen: Integer;
  nIPaddr: Integer;
  nMsgCount: Integer;
  bo01: Boolean;
  bo02: Boolean;

  sLoginPass: string;
  nPass, I:Integer;
begin
  bo01 := False;
  bo02 := False;
  nSockIndex := Socket.nIndex;
  sRemoteAddress := Socket.RemoteAddress;
  //MainOutMessage('nSockIndex: ' + IntToStr(nSockIndex)+'  '+Socket.ReceiveText, 1);
  if (nSockIndex >= 0) and (nSockIndex < GATEMAXSESSION) then begin
    UserSession := @g_SessionArray[nSockIndex];
    sReviceMsg := Socket.ReceiveText;
    if (sReviceMsg <> '') and (boServerReady) then begin
      nMsgLen := Length(sReviceMsg);
      //MainOutMessage('数据包长度: ' + IntToStr(nMsgLen), 1);
      if g_nAttackLevel > 0 then begin
        Inc(UserSession.nReviceMsgLen, nMsgLen);
        nMsgCount := TagCount(sReviceMsg, '!');
        if nMsgCount > nMaxClientMsgCount * g_nAttackLevel then bo02 := True;
        if nMsgLen > 358 then bo01 := True;
        if bo01 or bo02 then begin

          if g_boChgDefendLevel then begin
            Inc(m_nAttackCount);
            m_dwAttackTick := GetTickCount;
            if m_nAttackCount >= g_nChgDefendLevel then begin
              if BlockMethod = mDisconnect then BlockMethod := mBlock;
              if g_nAttackLevel > 1 then g_nAttackLevel := 1;
            end;
          end;

          case BlockMethod of
            mDisconnect: begin
                //Socket.Close;
              end;
            mBlock: begin
                AddTempBlockIP(sRemoteAddress);
                CloseConnect(sRemoteAddress);
              end;
            mBlockList: begin
                AddBlockIP(sRemoteAddress);
                CloseConnect(sRemoteAddress);
              end;
          end;
          if m_nAttackCount < 10 then begin
            if bo01 then MainOutMessage('端口攻击: ' + sRemoteAddress + ' 数据包长度: ' + IntToStr(UserSession.nReviceMsgLen), 1);
            if bo02 then MainOutMessage('端口攻击: ' + sRemoteAddress + ' 信息数量：' + IntToStr(nMsgCount), 1);
          end;
          Socket.Close;
          Exit;
        end;
      end;

      nPos := Pos('*', sReviceMsg);
      if nPos > 0 then begin
        UserSession.boSendAvailable := True;
        UserSession.boSendCheck := False;
        UserSession.nCheckSendLength := 0;
        UserSession.dwReceiveTick := GetTickCount();
        s10 := Copy(sReviceMsg, 1, nPos - 1);
        s1C := Copy(sReviceMsg, nPos + 1, Length(sReviceMsg) - nPos);
        sReviceMsg := s10 + s1C;
      end;
      nMsgLen := Length(sReviceMsg);

      if UserSession.nReviceMsgLength <= 0 then UserSession.dwReceiveMsgTick := GetTickCount();
      Inc(UserSession.nReviceMsgLength, nMsgLen);

      if (sReviceMsg <> '') and (boGateReady) and (not boKeepAliveTimcOut) then begin
        UserSession.dwConnctCheckTick := GetTickCount();
        if (GetTickCount - UserSession.dwUserTimeOutTick) < 1000 then begin
          Inc(UserSession.n20, nMsgLen);
        end else UserSession.n20 := nMsgLen;
        if not UserSession.boLegalConnection then begin
          nPos := Pos('<IGEM2>', sReviceMsg);
          if nPos > 0 then begin//20091121
            sLoginPass := Copy(sReviceMsg, nPos + 7, 12);
            if Length(sLoginPass) = 12 then begin
              Delete(sReviceMsg, nPos, 19);
              sLoginPass := DeCodeString(sLoginPass);
              nPass:= UserSession.nTemRandomID xor 432;
              if nPass = Str_ToInt(sLoginPass, 0) then begin
                UserSession.boLegalConnection:= True;//是否合法连接 20091121
                I:= StringList456A14.IndexOf(UserSession.sIP);
                if I > - 1 then begin
                  Dispose(pTNoLegalSession(StringList456A14.Objects[I]));
                  StringList456A14.Delete(I);
                end;
              end;
            end;
          end;
        end;
        if sReviceMsg <> '' then                              
        ClientSocket.Socket.SendText('%D' + IntToStr(Socket.SocketHandle) + '/' + sReviceMsg + '$');
      end;
    end;
  end;
end;
{---------如果MEMO里记录大于200那么清除掉-----------}
procedure TFrmMain.MemoLogChange(Sender: TObject);
begin
  if MemoLog.Lines.Count > 200 then MemoLog.Clear;
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
var
  nIndex: Integer;
begin
  StringList30C.Free;
  TempLogList.Free;
  for nIndex := 0 to GATEMAXSESSION - 1 do begin
    g_SessionArray[nIndex].MsgList.Free;
  end;
end;
{--------------------------关闭的时候出现------------------------------}
procedure TFrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if boClose then Exit;
  if Application.MessageBox('是否确认退出服务器？',
    '提示信息',
    MB_YESNO + MB_ICONQUESTION) = IDYES then begin
    if boServiceStart then begin
      StartTimer.Enabled := True;
      CanClose := False;
    end;
  end else CanClose := False;
end;
{----------------------和DBServer连接------------------------}
procedure TFrmMain.ClientSocketConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  boGateReady := True;
  nSessionCount := 0;
  dwKeepAliveTick := GetTickCount();
  ResUserSessionArray();
  boServerReady := True;
end;
{----------------------和DBServer没连接------------------------}
procedure TFrmMain.ClientSocketDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  UserSession: pTUserSession;
  nIndex: Integer;
begin
  for nIndex := 0 to GATEMAXSESSION - 1 do begin
    UserSession := @g_SessionArray[nIndex];
    if UserSession.Socket <> nil then
      UserSession.Socket.Close;
    UserSession.Socket := nil;
    UserSession.sRemoteIPaddr := '';
    UserSession.SocketHandle := -1;
  end;
  ResUserSessionArray();
  ClientSockeMsgList.Clear;
  boGateReady := False;
  nSessionCount := 0;
end;
{-----------------和DBServer连接错误-------------------}
procedure TFrmMain.ClientSocketError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
  Socket.Close;
  ErrorCode := 0;
  boServerReady := False;
end;
{-----------------读取DBServer发来的数据-------------------}
procedure TFrmMain.ClientSocketRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
  sRecvMsg: string;
begin
  sRecvMsg := Socket.ReceiveText;
  ClientSockeMsgList.Add(sRecvMsg);
end;

procedure TFrmMain.SendTimerTimer(Sender: TObject);
var
  nIndex: Integer;
  UserSession: pTUserSession;
begin
  if ServerSocket.Active then begin
    n456A30 := ServerSocket.Socket.ActiveConnections;
  end;
  if boSendHoldTimeOut then begin
    LbHold.Caption := IntToStr(n456A30) + '#';
    if (GetTickCount - dwSendHoldTick) > 3 * 1000 then boSendHoldTimeOut := False;
  end else begin
    LbHold.Caption := IntToStr(n456A30);
  end;
  if boGateReady and (not boKeepAliveTimcOut) then begin
    for nIndex := 0 to GATEMAXSESSION - 1 do begin
      UserSession := @g_SessionArray[nIndex];
      if UserSession.Socket <> nil then begin
        if (GetTickCount - UserSession.dwUserTimeOutTick) > 60 * 60 * 1000 then begin
          UserSession.Socket.Close;
          UserSession.Socket := nil;
          UserSession.SocketHandle := -1;
          UserSession.MsgList.Clear;
          UserSession.sRemoteIPaddr := '';
        end;
      end;
    end;
  end;
  if not boGateReady and (boServiceStart) then begin
    if (GetTickCount - dwReConnectServerTick) > 1000 {30 * 1000} then begin
      dwReConnectServerTick := GetTickCount();
      ClientSocket.Active := False;
      ClientSocket.Port := ServerPort;
      ClientSocket.Host := ServerAddr;
      ClientSocket.Active := True;
    end;
  end;
end;

procedure TFrmMain.TimerTimer(Sender: TObject);
var
  I: Integer;
begin
  if ServerSocket.Active then begin
    if g_boClearTempList then begin
      if GetTickCount - m_dwAttackTick > 1000 * g_dwClearTempList then begin
        m_nAttackCount := 0;
        if TempBlockIPList <> nil then begin
          TempBlockIPList.Lock;
          try
            for I := 0 to TempBlockIPList.Count - 1 do begin
              Dispose(pTSockaddr(TempBlockIPList.Items[I]));
            end;
            TempBlockIPList.Clear;
          finally
            TempBlockIPList.UnLock;
          end;
        end;
      end;
    end;

    if g_boReliefDefend then begin
      if (GetTickCount - m_dwAttackTick > 1000 * g_dwClearTempList) and (m_nAttackCount = 0) then begin
        if g_nAttackLevel <> nUseAttackLevel then g_nAttackLevel := nUseAttackLevel;
        if BlockMethod <> UseBlockMethod then BlockMethod := UseBlockMethod;
      end;
    end;

    if m_nAttackCount > 0 then begin
      StatusBar.Panels[3].Text := '攻击计次:' + IntToStr(m_nAttackCount);
    end;

    StatusBar.Panels[0].Text := IntToStr(ServerSocket.Port);
    if boSendHoldTimeOut then
      StatusBar.Panels[2].Text := IntToStr(nSessionCount) + '/#' + IntToStr(ServerSocket.Socket.ActiveConnections)
    else
      StatusBar.Panels[2].Text := IntToStr(nSessionCount) + '/' + IntToStr(ServerSocket.Socket.ActiveConnections);
  end else begin
    StatusBar.Panels[0].Text := '????';
    StatusBar.Panels[2].Text := '????';
  end;
  Label2.Caption := IntToStr(dwDecodeMsgTime);
  if not boGateReady then begin
    StatusBar.Panels[1].Text := '---]    [---';
    //StatusBar.Panels[1].Text := '未连接';
  end else begin
    if boKeepAliveTimcOut then begin
      StatusBar.Panels[1].Text := '---]$$$$[---';
      //StatusBar.Panels[1].Text := '超时';
    end else begin
      StatusBar.Panels[1].Text := '-----][-----';
      //StatusBar.Panels[1].Text := '已连接';
      LbLack.Caption := IntToStr(n456A2C) + '/' + IntToStr(nSendMsgCount);
    end;
  end;
end;

procedure TFrmMain.DecodeTimerTimer(Sender: TObject);
var
  sProcessMsg: string;
  sSocketMsg: string;
  sSocketHandle: string;
  nSocketIndex: Integer;
  nMsgCount: Integer;
  nSendRetCode: Integer;
  nSocketHandle: Integer;
  dwDecodeTick: LongWord;
  dwDecodeTime: LongWord;
  sRemoteIPaddr: string;
  UserSession: pTUserSession;
begin
  ShowMainLogMsg();
  if boDecodeLock or (not boGateReady) then Exit;
  try
    dwDecodeTick := GetTickCount();
    boDecodeLock := True;
    sProcessMsg := '';
    while (True) do begin
      if ClientSockeMsgList.Count <= 0 then break;
      sProcessMsg := sProcMsg + ClientSockeMsgList.Strings[0];
      sProcMsg := '';
      ClientSockeMsgList.Delete(0);
      while (True) do begin
        if TagCount(sProcessMsg, '$') < 1 then break;
        sProcessMsg := ArrestStringEx(sProcessMsg, '%', '$', sSocketMsg);
        if sSocketMsg = '' then break;
        if sSocketMsg[1] = '+' then begin
          case sSocketMsg[2] of
            '-': begin
                CloseSocket(Str_ToInt(Copy(sSocketMsg, 3, Length(sSocketMsg) - 2), 0));
                Continue;
              end;
            'B': begin
                Inc(m_nAttackCount);
                m_dwAttackTick := GetTickCount;
                sRemoteIPaddr := CloseSocketAndGetIPAddr(Str_ToInt(Copy(sSocketMsg, 3, Length(sSocketMsg) - 2), 0));
                AddTempBlockIP(sRemoteIPaddr);
                Continue;
              end;
            'T': begin
                Inc(m_nAttackCount);
                m_dwAttackTick := GetTickCount;
                sRemoteIPaddr := CloseSocketAndGetIPAddr(Str_ToInt(Copy(sSocketMsg, 3, Length(sSocketMsg) - 2), 0));
                AddBlockIP(sRemoteIPaddr);
                Continue;
              end;
          else begin
              dwKeepAliveTick := GetTickCount();
              boKeepAliveTimcOut := False;
              Continue;
            end;
          end;
        end;
        sSocketMsg := GetValidStr3(sSocketMsg, sSocketHandle, ['/']);
        nSocketHandle := Str_ToInt(sSocketHandle, -1);
        if nSocketHandle < 0 then Continue;
        for nSocketIndex := 0 to GATEMAXSESSION - 1 do begin
          if g_SessionArray[nSocketIndex].SocketHandle = nSocketHandle then begin
            g_SessionArray[nSocketIndex].MsgList.Add(sSocketMsg);
            break;
          end;
        end;
      end;
    end;
    //if sProcessMsg <> '' then ClientSockeMsgList.Add(sProcessMsg);
    if sProcessMsg <> '' then sProcMsg := sProcessMsg;

    nSendMsgCount := 0;
    n456A2C := 0;
    StringList318.Clear;
    for nSocketIndex := 0 to GATEMAXSESSION - 1 do begin
      if g_SessionArray[nSocketIndex].SocketHandle <= -1 then Continue;

      //踢除超时无数据传输连接(端口空连接攻)
      if (g_nAttackLevel > 0) and ((GetTickCount - g_SessionArray[nSocketIndex].dwConnctCheckTick) > dwKeepConnectTimeOut * g_nAttackLevel) then begin
        sRemoteIPaddr := g_SessionArray[nSocketIndex].sRemoteIPaddr;
        MainOutMessage('踢除超时无数据传输连接:' + sRemoteIPaddr, 1);
        g_SessionArray[nSocketIndex].Socket.Close;
        Continue;
      end;
      //检查连接是否合法，不合法则加入列表并计数，断开当前连接 20091121
      if not g_SessionArray[nSocketIndex].boLegalConnection and
        ((GetTickCount - g_SessionArray[nSocketIndex].dwConnctCheckTick) > 12000) then begin
        AddNoLegalIPToList(g_SessionArray[nSocketIndex].sIP, g_SessionArray[nSocketIndex].Socket);
        Continue;
      end;

      while (True) do begin
        if g_SessionArray[nSocketIndex].MsgList.Count <= 0 then break;
        UserSession := @g_SessionArray[nSocketIndex];
        nSendRetCode := SendUserMsg(UserSession, UserSession.MsgList.Strings[0]);
        if (nSendRetCode >= 0) then begin
          if nSendRetCode = 1 then begin
            UserSession.dwConnctCheckTick := GetTickCount();
            UserSession.MsgList.Delete(0);
            Continue;
          end;
          if UserSession.MsgList.Count > 100 then begin
            nMsgCount := 0;
            while nMsgCount <> 51 do begin
              UserSession.MsgList.Delete(0);
              Inc(nMsgCount);
            end;
          end;
          Inc(n456A2C, UserSession.MsgList.Count);
          MainOutMessage(UserSession.sIP + ' : ' + IntToStr(UserSession.MsgList.Count), 5);
          Inc(nSendMsgCount);
        end else begin
          //ainOutMessage('发送数据失败!!' + UserSession.sIP + ' : ' + IntToStr(UserSession.MsgList.Count), 2);

          UserSession.SocketHandle := -1;
          UserSession.Socket := nil;
          UserSession.MsgList.Clear;
        end;
      end;
    end;
    if (GetTickCount - dwSendKeepAliveTick) > 2 * 1000 then begin
      dwSendKeepAliveTick := GetTickCount();
      if boGateReady then ClientSocket.Socket.SendText('%--$');
    end;
    if (GetTickCount - dwKeepAliveTick) > 10 * 1000 then begin
      boKeepAliveTimcOut := True;
      ClientSocket.Close;
    end;
  finally
    boDecodeLock := False;
  end;
  dwDecodeTime := GetTickCount - dwDecodeTick;
  if dwDecodeMsgTime < dwDecodeTime then dwDecodeMsgTime := dwDecodeTime;
  if dwDecodeMsgTime > 50 then Dec(dwDecodeMsgTime, 50);
end;
{--------------------关闭连接----------------------}
procedure TFrmMain.CloseSocket(nSocketHandle: Integer);
var
  nIndex: Integer;
  UserSession: pTUserSession;
begin
  for nIndex := 0 to GATEMAXSESSION - 1 do begin
    UserSession := @g_SessionArray[nIndex];
    if (UserSession.Socket <> nil) and (UserSession.SocketHandle = nSocketHandle) then begin
      UserSession.Socket.Close;
      break;
    end;
  end;
end;

function TFrmMain.CloseSocketAndGetIPAddr(nSocketHandle: Integer): string;
var
  nIndex: Integer;
  UserSession: pTUserSession;
begin
  Result := '';
  for nIndex := 0 to GATEMAXSESSION - 1 do begin
    UserSession := @g_SessionArray[nIndex];
    if (UserSession.Socket <> nil) and (UserSession.SocketHandle = nSocketHandle) then begin
      Result := UserSession.sRemoteIPaddr;
      UserSession.Socket.Close;
      break;
    end;
  end;
end;

function TFrmMain.SendUserMsg(UserSession: pTUserSession; sSendMsg: string): Integer;
begin
  Result := -1;
  if UserSession.Socket <> nil then begin
    if not UserSession.bo0C then begin
      if not UserSession.boSendAvailable and (GetTickCount > UserSession.dwSendLockTimeOut) then begin
        UserSession.boSendAvailable := True;
        UserSession.nCheckSendLength := 0;
        boSendHoldTimeOut := True;
        dwSendHoldTick := GetTickCount();
      end;
      if UserSession.boSendAvailable then begin
        if UserSession.nCheckSendLength >= 250 then begin
          if not UserSession.boSendCheck then begin
            UserSession.boSendCheck := True;
            sSendMsg := '*' + sSendMsg;
          end;
          if UserSession.nCheckSendLength >= 512 then begin
            UserSession.boSendAvailable := False;
            UserSession.dwSendLockTimeOut := GetTickCount + 3 * 1000;
          end;
        end;
        UserSession.Socket.SendText(sSendMsg);
        Inc(UserSession.nSendMsgLen, Length(sSendMsg));
        Inc(UserSession.nCheckSendLength, Length(sSendMsg));
        Result := 1;
      end else begin
        Result := 0;
      end;
    end else begin
      Result := 0;
    end;
  end;
end;
{-----------读取ini配置文件-----------}
procedure TFrmMain.LoadConfig;
var
  Conf: TIniFile;
  sConfigFileName: string;
begin
  sConfigFileName := '.\Config.ini';
  IsNum('987');
  Conf := TIniFile.Create(sConfigFileName);
  TitleName := Conf.ReadString(GateClass, 'Title', TitleName);
  ServerPort := Conf.ReadInteger(GateClass, 'ServerPort', ServerPort);
  ServerAddr := Conf.ReadString(GateClass, 'ServerAddr', ServerAddr);
  GatePort := Conf.ReadInteger(GateClass, 'GatePort', GatePort);
  GateAddr := Conf.ReadString(GateClass, 'GateAddr', GateAddr);
  nShowLogLevel := Conf.ReadInteger(GateClass, 'ShowLogLevel', nShowLogLevel);
  BlockMethod := TBlockIPMethod(Conf.ReadInteger(GateClass, 'BlockMethod', Integer(BlockMethod)));
  UseBlockMethod := BlockMethod;
  IsNum('234');
  if Conf.ReadInteger(GateClass, 'KeepConnectTimeOut', -1) <= 0 then
    Conf.WriteInteger(GateClass, 'KeepConnectTimeOut', dwKeepConnectTimeOut);

  if Conf.ReadInteger(GateClass, 'AttackLevel', -1) <= 0 then
    Conf.WriteInteger(GateClass, 'AttackLevel', g_nAttackLevel);

  g_nAttackLevel := Conf.ReadInteger(GateClass, 'AttackLevel', g_nAttackLevel);
  nUseAttackLevel := g_nAttackLevel;

  nMaxConnOfNoLegal := Conf.ReadInteger(GateClass, 'MaxConnOfNoLegal', nMaxConnOfNoLegal);//20091121
  nMaxConnOfIPaddr := Conf.ReadInteger(GateClass, 'MaxConnOfIPaddr', nMaxConnOfIPaddr);
  dwKeepConnectTimeOut := Conf.ReadInteger(GateClass, 'KeepConnectTimeOut', dwKeepConnectTimeOut);
  g_boDynamicIPDisMode := Conf.ReadBool(GateClass, 'DynamicIPDisMode', g_boDynamicIPDisMode);
  g_boMinimize := Conf.ReadBool(GateClass, 'Minimize', g_boMinimize);
  IsNum('997');
  g_boChgDefendLevel := Conf.ReadBool(GateClass, 'ChgDefendLevel', g_boChgDefendLevel);
  g_boClearTempList := Conf.ReadBool(GateClass, 'ClearTempList', g_boClearTempList);
  g_boReliefDefend := Conf.ReadBool(GateClass, 'ReliefDefend', g_boReliefDefend);
  g_nChgDefendLevel := Conf.ReadInteger(GateClass, 'ChgDefendLevelCount', g_nChgDefendLevel);
  g_dwClearTempList := Conf.ReadInteger(GateClass, 'ClearTempListTime', g_dwClearTempList);
  g_dwReliefDefend := Conf.ReadInteger(GateClass, 'ReliefDefendTime', g_dwReliefDefend);

  dwAttackTime := Conf.ReadInteger(GateClass, 'AttackTime', dwAttackTime);//20091121
  nAttackCount := Conf.ReadInteger(GateClass, 'AttackCount', nAttackCount);//20091121
    
  Conf.Free;
  IsNum('117');       
  LoadBlockIPFile();
end;
{-----------开始服务------------}
procedure TFrmMain.StartService;
begin
  try
    IsNum('987');
    MainOutMessage('正在启动服务...', 3);
    SendGameCenterMsg(SG_STARTNOW, g_sNowStartGate);
    //StatusBar.Panels[3].Text:=sVersion;
    boServiceStart := True;
    boGateReady := False;
    boServerReady := False;
    nSessionCount := 0;
    MENU_CONTROL_START.Enabled := False;
    MENU_CONTROL_STOP.Enabled := True;

    dwReConnectServerTick := GetTickCount - 25 * 1000;
    boKeepAliveTimcOut := False;
    nSendMsgCount := 0;
    n456A2C := 0;
    dwSendKeepAliveTick := GetTickCount();
    boSendHoldTimeOut := False;
    dwSendHoldTick := GetTickCount();
    IsNum('937');
    CurrIPaddrList := TGList.Create;
    BlockIPList := TGList.Create;
    TempBlockIPList := TGList.Create;
    AttackIPaddrList := TGList.Create;
    StringList456A14 := TStringList.Create;
    ClientSockeMsgList := TStringList.Create;
    IsNum('234');
    ResUserSessionArray();
    IsNum('186');
    LoadConfig();
    Caption := GateName + ' - ' + TitleName;
    ClientSocket.Active := False;
    ClientSocket.Host := ServerAddr;
    ClientSocket.Port := ServerPort;
    ClientSocket.Active := True;

    ServerSocket.Active := False;
    ServerSocket.Address := GateAddr;
    ServerSocket.Port := GatePort;
    ServerSocket.Active := True;
    IsNum('967');
    SendTimer.Enabled := True;
    MainOutMessage('启动服务完成...', 3);
    SendGameCenterMsg(SG_STARTOK, g_sNowStartOK);
    if g_boMinimize then Application.Minimize;
  except
    on E: Exception do begin
      MENU_CONTROL_START.Enabled := True;
      MENU_CONTROL_STOP.Enabled := False;
      MainOutMessage(E.Message, 0);
    end;
  end;
end;
{----------------停止服务--------------}
procedure TFrmMain.StopService;
var
  I, II: Integer;
  nSockIdx: Integer;
  IPaddr: pTSockaddr;
  IPList: TList;
begin
  IsNum('987');
  MainOutMessage('正在停止服务...', 3);
  boServiceStart := False;
  boGateReady := False;
  MENU_CONTROL_START.Enabled := True;
  MENU_CONTROL_STOP.Enabled := False;
  SendTimer.Enabled := False;
  for nSockIdx := 0 to GATEMAXSESSION - 1 do begin
    if g_SessionArray[nSockIdx].Socket <> nil then
      g_SessionArray[nSockIdx].Socket.Close;
  end;
  IsNum('124');
  SaveBlockIPList();
  ServerSocket.Close;
  ClientSocket.Close;
  ClientSockeMsgList.Free;
  IsNum('921');
  CurrIPaddrList.Lock;
  try
    for I := 0 to CurrIPaddrList.Count - 1 do begin
      IPList := TList(CurrIPaddrList.Items[I]);
      if IPList <> nil then begin
        for II := 0 to IPList.Count - 1 do begin
          if pTSockaddr(IPList.Items[II]) <> nil then
            Dispose(pTSockaddr(IPList.Items[II]));
        end;
        IPList.Free;
      end;
    end;
  finally
    CurrIPaddrList.UnLock;
    CurrIPaddrList.Free;
  end;

  BlockIPList.Lock;
  try
    for I := 0 to BlockIPList.Count - 1 do begin
      IPaddr := pTSockaddr(BlockIPList.Items[I]);
      Dispose(IPaddr);
    end;
  finally
    BlockIPList.UnLock;
    BlockIPList.Free;
  end;

  TempBlockIPList.Lock;
  try
    for I := 0 to TempBlockIPList.Count - 1 do begin
      IPaddr := pTSockaddr(TempBlockIPList.Items[I]);
      Dispose(IPaddr);
    end;
  finally
    TempBlockIPList.UnLock;
    TempBlockIPList.Free;
  end;
  IsNum('734');
  AttackIPaddrList.Lock;
  try
    for I := 0 to AttackIPaddrList.Count - 1 do begin
      IPaddr := pTSockaddr(AttackIPaddrList.Items[I]);
      Dispose(IPaddr);
    end;
  finally
    AttackIPaddrList.UnLock;
    AttackIPaddrList.Free;
  end;

  if StringList456A14.Count > 0 then begin
    for I := 0 to StringList456A14.Count - 1 do begin
      Dispose(pTNoLegalSession(StringList456A14.Objects[I]));
    end;
  end;
  StringList456A14.Free;
  IsNum('119');
  MainOutMessage('停止服务完成...', 3);
end;

procedure TFrmMain.ResUserSessionArray;
var
  UserSession: pTUserSession;
  nIndex: Integer;
begin
  for nIndex := 0 to GATEMAXSESSION - 1 do begin
    UserSession := @g_SessionArray[nIndex];
    UserSession.Socket := nil;
    UserSession.sRemoteIPaddr := '';
    UserSession.SocketHandle := -1;
    UserSession.MsgList.Clear;
  end;
end;
procedure TFrmMain.IniUserSessionArray();
var
  UserSession: pTUserSession;
  nIndex: Integer;
begin
  for nIndex := 0 to GATEMAXSESSION - 1 do begin
    UserSession := @g_SessionArray[nIndex];
    UserSession.Socket := nil;
    UserSession.sRemoteIPaddr := '';
    UserSession.nSendMsgLen := 0;
    UserSession.bo0C := False;
    UserSession.dw10Tick := GetTickCount();
    UserSession.boSendAvailable := True;
    UserSession.boSendCheck := False;
    UserSession.nCheckSendLength := 0;
    UserSession.n20 := 0;
    UserSession.dwUserTimeOutTick := GetTickCount();
    UserSession.SocketHandle := -1;
    UserSession.dwReceiveTick := GetTickCount();
    UserSession.nReviceMsgLength := 0;
    UserSession.dwReceiveMsgTick := GetTickCount();
    UserSession.MsgList := TStringList.Create;
  end;
end;

procedure TFrmMain.StartTimerTimer(Sender: TObject);
begin
  if boStarted then begin
    StartTimer.Enabled := False;
    StopService();
    boClose := True;
    Close;
  end else begin
    MENU_VIEW_LOGMSGClick(Sender);
    boStarted := True;
    StartTimer.Enabled := False;
    StartService();
  end;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
var
  nX, nY: Integer;
begin
  g_dwGameCenterHandle := Str_ToInt(ParamStr(1), 0);
  nX := Str_ToInt(ParamStr(2), -1);
  nY := Str_ToInt(ParamStr(3), -1);
  if (nX >= 0) or (nY >= 0) then begin
    Left := nX;
    Top := nY;
  end;
  TempLogList := TStringList.Create;
  StringList30C := TStringList.Create;
  StringList318 := TStringList.Create;
  dwDecodeMsgTime := 0;
  SendGameCenterMsg(SG_FORMHANDLE, IntToStr(Self.Handle));
  IniUserSessionArray();
end;

procedure TFrmMain.MENU_CONTROL_STARTClick(Sender: TObject);
begin
  StartService();
end;

procedure TFrmMain.MENU_CONTROL_STOPClick(Sender: TObject);
begin
  if Application.MessageBox('是否确认停止服务？',
    '确认信息',
    MB_YESNO + MB_ICONQUESTION) = IDYES then
    StopService();
end;

procedure TFrmMain.MENU_CONTROL_RECONNECTClick(Sender: TObject);
begin
  dwReConnectServerTick := 0;
end;

procedure TFrmMain.MENU_CONTROL_CLEAELOGClick(Sender: TObject);
begin
  if Application.MessageBox('是否确认清除显示的日志信息？',
    '确认信息',
    MB_OKCANCEL + MB_ICONQUESTION
    ) <> IDOK then Exit;
  MemoLog.Clear;
end;

procedure TFrmMain.MENU_CONTROL_EXITClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmMain.MENU_VIEW_LOGMSGClick(Sender: TObject);
begin
  MENU_VIEW_LOGMSG.Checked := not MENU_VIEW_LOGMSG.Checked;
  ShowLogMsg(MENU_VIEW_LOGMSG.Checked);
end;

procedure TFrmMain.ShowLogMsg(boFlag: Boolean);
var
  nHeight: Integer;
begin
  case boFlag of
    True: begin
        nHeight := Panel.Height;
        Panel.Height := 0;
        MemoLog.Height := nHeight;
        MemoLog.Top := Panel.Top;
      end;
    False: begin
        nHeight := MemoLog.Height;
        MemoLog.Height := 0;
        Panel.Height := nHeight;
      end;
  end;
end;

procedure TFrmMain.MENU_OPTION_GENERALClick(Sender: TObject);
begin
  frmGeneralConfig.Top := Self.Top + 20;
  frmGeneralConfig.Left := Self.Left;
  with frmGeneralConfig do begin
    EditGateIPaddr.Text := GateAddr;
    EditGatePort.Text := IntToStr(GatePort);
    EditServerIPaddr.Text := ServerAddr;
    EditServerPort.Text := IntToStr(ServerPort);
    EditTitle.Text := TitleName;
    TrackBarLogLevel.Position := nShowLogLevel;
    CheckBoxMinimize.Checked := g_boMinimize;
  end;
  frmGeneralConfig.ShowModal;
end;

procedure TFrmMain.CloseConnect(sIPaddr: string);
var
  I: Integer;
  boCheck: Boolean;
begin
  if ServerSocket.Active then
    while (True) do begin
      boCheck := False;
      for I := 0 to ServerSocket.Socket.ActiveConnections - 1 do begin
        if sIPaddr = ServerSocket.Socket.Connections[I].RemoteAddress then begin
          ServerSocket.Socket.Connections[I].Close;
          boCheck := True;
          break;
        end;
      end;
      if not boCheck then break;
    end;
end;

procedure TFrmMain.MENU_OPTION_IPFILTERClick(Sender: TObject);
var
  I: Integer;
  sIPaddr: string;
begin
  frmIPaddrFilter.Top := Self.Top + 20;
  frmIPaddrFilter.Left := Self.Left;
  frmIPaddrFilter.ListBoxActiveList.Clear;
  frmIPaddrFilter.ListBoxTempList.Clear;
  frmIPaddrFilter.ListBoxBlockList.Clear;
  if ServerSocket.Active then
    for I := 0 to ServerSocket.Socket.ActiveConnections - 1 do begin
      sIPaddr := ServerSocket.Socket.Connections[I].RemoteAddress;
      if sIPaddr <> '' then
        frmIPaddrFilter.ListBoxActiveList.Items.AddObject(sIPaddr, TObject(ServerSocket.Socket.Connections[I]));
    end;

  for I := 0 to TempBlockIPList.Count - 1 do begin
    frmIPaddrFilter.ListBoxTempList.Items.Add(StrPas(inet_ntoa(TInAddr(pTSockaddr(TempBlockIPList.Items[I]).nIPaddr))));
  end;
  for I := 0 to BlockIPList.Count - 1 do begin
    frmIPaddrFilter.ListBoxBlockList.Items.Add(StrPas(inet_ntoa(TInAddr(pTSockaddr(BlockIPList.Items[I]).nIPaddr))));
  end;
  frmIPaddrFilter.TrackBarAttack.Position := g_nAttackLevel;
  frmIPaddrFilter.EditMaxConnect.Value := nMaxConnOfIPaddr;
  frmIPaddrFilter.EditMaxConnOfNoLegal.Value := nMaxConnOfNoLegal;//20091121

  frmIPaddrFilter.CheckBoxChg.Checked := g_boChgDefendLevel;
  frmIPaddrFilter.CheckBoxAutoClearTempList.Checked := g_boClearTempList;
  frmIPaddrFilter.CheckBoxReliefDefend.Checked := g_boReliefDefend;

  frmIPaddrFilter.SpinEdit1.Value := g_nChgDefendLevel;
  frmIPaddrFilter.SpinEdit2.Value := g_dwClearTempList;
  frmIPaddrFilter.SpinEdit3.Value := g_dwReliefDefend;

  frmIPaddrFilter.SpinEdit4.Value := dwAttackTime;//20091121
  frmIPaddrFilter.SpinEdit5.Value := nAttackCount;//20091121  
  case BlockMethod of
    mDisconnect: frmIPaddrFilter.RadioDisConnect.Checked := True;
    mBlock: frmIPaddrFilter.RadioAddTempList.Checked := True;
    mBlockList: frmIPaddrFilter.RadioAddBlockList.Checked := True;
  end;
  frmIPaddrFilter.ShowModal;
end;

function TFrmMain.IsBlockIP(sIPaddr: string): Boolean;
var
  I: Integer;
  IPaddr: pTSockaddr;
  nIPaddr: Integer;
begin
  Result := False;
  TempBlockIPList.Lock;
  try
    nIPaddr := inet_addr(PChar(sIPaddr));
    for I := 0 to TempBlockIPList.Count - 1 do begin
      IPaddr := pTSockaddr(TempBlockIPList.Items[I]);
      if IPaddr.nIPaddr = nIPaddr then begin
        Result := True;
        break;
      end;
    end;
  finally
    TempBlockIPList.UnLock;
  end;
  //-------------------------------
  if not Result then begin
    BlockIPList.Lock;
    try
      for I := 0 to BlockIPList.Count - 1 do begin
        IPaddr := pTSockaddr(BlockIPList.Items[I]);
        if IPaddr.nIPaddr = nIPaddr then begin
          Result := True;
          break;
        end;
      end;
    finally
      BlockIPList.UnLock;
    end;
  end;
end;
{-------------添加限制IP函数---------------------}
function TFrmMain.AddBlockIP(sIPaddr: string): Integer;
var
  I: Integer;
  IPaddr: pTSockaddr;
  nIPaddr: Integer;
begin
  BlockIPList.Lock;
  try
    Result := 0;
    nIPaddr := inet_addr(PChar(sIPaddr));
    for I := 0 to BlockIPList.Count - 1 do begin
      IPaddr := pTSockaddr(BlockIPList.Items[I]);
      if IPaddr.nIPaddr = nIPaddr then begin
        Result := BlockIPList.Count;
        break;
      end;
    end;
    if Result <= 0 then begin
      New(IPaddr);
      IPaddr^.nIPaddr := nIPaddr;
      BlockIPList.Add(IPaddr);
      Result := BlockIPList.Count;
    end;
  finally
    BlockIPList.UnLock;
  end;
end;

function TFrmMain.AddTempBlockIP(sIPaddr: string): Integer;
var
  I: Integer;
  IPaddr: pTSockaddr;
  nIPaddr: Integer;
begin
  TempBlockIPList.Lock;
  try
    Result := 0;
    nIPaddr := inet_addr(PChar(sIPaddr));
    for I := 0 to TempBlockIPList.Count - 1 do begin
      IPaddr := pTSockaddr(TempBlockIPList.Items[I]);
      if IPaddr.nIPaddr = nIPaddr then begin
        Result := TempBlockIPList.Count;
        break;
      end;
    end;
    if Result <= 0 then begin
      New(IPaddr);
      FillChar(IPaddr^, SizeOf(TSockaddr), 0);
      IPaddr^.nIPaddr := nIPaddr;
      TempBlockIPList.Add(IPaddr);
      Result := TempBlockIPList.Count;
    end;
  finally
    TempBlockIPList.UnLock;
  end;
end;

function TFrmMain.AddAttackIP(sIPaddr: string): Boolean;
var
  I: Integer;
  IPaddr, AddIPaddr: pTSockaddr;
  nIPaddr: Integer;
  bo01: Boolean;
begin
  Result := False;
  AttackIPaddrList.Lock;
  try
    if g_nAttackLevel > 0 then begin
      bo01 := False;
      nIPaddr := inet_addr(PChar(sIPaddr));
      for I := AttackIPaddrList.Count - 1 downto 0 do begin
        IPaddr := pTSockaddr(AttackIPaddrList.Items[I]);
        if IPaddr.nIPaddr = nIPaddr then begin
          if (GetTickCount - IPaddr.dwStartAttackTick) <= dwAttackTime {div nAttackLevel} then begin//一定时间内连接 20091121 修改
            IPaddr.dwStartAttackTick := GetTickCount;
            Inc(IPaddr.nAttackCount);
            if IPaddr.nAttackCount >= nAttackCount {* nAttackLevel} then begin
              AttackIPaddrList.Delete(I);
              Dispose(IPaddr);
              Result := True;
            end;
          end else begin
            {if IPaddr.nAttackCount > nAttackCount * nAttackLevel then begin
              Inc(m_nAttackCount);
              m_dwAttackTick := GetTickCount;
              Result := True;
            end;}
            AttackIPaddrList.Delete(I);
            Dispose(IPaddr);
          end;
          bo01 := True;
          break;
        end;
      end;
      if not bo01 then begin
        New(AddIPaddr);
        FillChar(AddIPaddr^, SizeOf(TSockaddr), 0);
        AddIPaddr^.nIPaddr := nIPaddr;
        AddIPaddr^.dwStartAttackTick := GetTickCount;
        AddIPaddr^.nAttackCount := 0;
        AttackIPaddrList.Add(AddIPaddr);
      end;
    end;
  finally
    AttackIPaddrList.UnLock;
  end;
end;

function TFrmMain.IsConnLimited(sIPaddr: string; SocketHandle: Integer): Boolean;
var
  I: Integer;
  IPaddr, AttackIPaddr: pTSockaddr;
  nIPaddr: Integer;
  bo01: Boolean;
  IPList: TList;
begin
  Result := False;
  CurrIPaddrList.Lock;
  try
    if g_nAttackLevel > 0 then begin
      bo01 := False;
      nIPaddr := inet_addr(PChar(sIPaddr));
      for I := 0 to CurrIPaddrList.Count - 1 do begin
        IPList := TList(CurrIPaddrList.Items[I]);
        if (IPList <> nil) and (IPList.Count > 0) then begin
          IPaddr := pTSockaddr(IPList.Items[0]);
          if IPaddr <> nil then begin
            if IPaddr.nIPaddr = nIPaddr then begin
              bo01 := True;
              Result := AddAttackIP(sIPaddr);
              if Result then break;
              New(AttackIPaddr);
              FillChar(AttackIPaddr^, SizeOf(TSockaddr), 0);
              AttackIPaddr^.nIPaddr := nIPaddr;
              AttackIPaddr^.nSocketHandle := SocketHandle;
              IPList.Add(AttackIPaddr);
              if IPList.Count > nMaxConnOfIPaddr * g_nAttackLevel then Result := True;
              break;
            end;
          end;
        end;
      end;
      if not bo01 then begin
        IPList := nil;
        New(IPaddr);
        FillChar(IPaddr^, SizeOf(TSockaddr), 0);
        IPaddr^.nIPaddr := nIPaddr;
        IPaddr^.nSocketHandle := SocketHandle;
        IPList := TList.Create;
        IPList.Add(IPaddr);
        CurrIPaddrList.Add(IPList);
      end;
    end;
  finally
    CurrIPaddrList.UnLock;
  end;
end;

procedure TFrmMain.ShowMainLogMsg;
var
  I: Integer;
begin
  if (GetTickCount - dwShowMainLogTick) < 200 then Exit;
  dwShowMainLogTick := GetTickCount();
  try
    boShowLocked := True;
    try
      CS_MainLog.Enter;
      for I := 0 to MainLogMsgList.Count - 1 do begin
        TempLogList.Add(MainLogMsgList.Strings[I]);
      end;
      MainLogMsgList.Clear;
    finally
      CS_MainLog.Leave;
    end;
    for I := 0 to TempLogList.Count - 1 do begin
      MemoLog.Lines.Add(TempLogList.Strings[I]);
    end;
    TempLogList.Clear;
  finally
    boShowLocked := False;
  end;
end;

procedure TFrmMain.MyMessage(var MsgData: TWmCopyData);
var
  sData: string;
  wIdent: Word;
begin
  wIdent := HiWord(MsgData.From);
  sData := StrPas(MsgData.CopyDataStruct^.lpData);
  case wIdent of
    GS_QUIT: begin
        if boServiceStart then begin
          StartTimer.Enabled := True;
        end else begin
          boClose := True;
          Close();
        end;
      end;
    1: ;
    2: ;
    3: ;
  end;
end;
{-------------显示版权信息---------------}
procedure TFrmMain.S1Click(Sender: TObject);
begin
  FrmAbout := TFrmAbout.Create(Owner);
  FrmAbout.Open();
  FrmAbout.Free;
end;

//不合法会话加入列表，当达到指定次数时，加入过滤列表 20091121
function TFrmMain.AddNoLegalIPToList(sIPaddr: string; Socket: TCustomWinSocket): Boolean;
var
  I: Integer;
  NoLegalSession: pTNoLegalSession;
begin
  Result := False;
  try
    if g_nAttackLevel > 0 then begin
      MainOutMessage('踢除不合法连接:' + sIPaddr, 1);
      I:= StringList456A14.IndexOf(sIPaddr);
      if I > -1 then begin//IP存在则计数
        NoLegalSession:= pTNoLegalSession(StringList456A14.Objects[I]);
        if NoLegalSession <> nil then begin
          Inc(NoLegalSession.nErrorCount);
          if NoLegalSession.nErrorCount >= nMaxConnOfNoLegal then begin//非法连接超过指定次数，加入过滤列表
            StringList456A14.Delete(I);
            Dispose(NoLegalSession);
            case BlockMethod of
              mDisconnect: begin
                  Socket.Close;
                end;
              mBlock: begin
                  AddTempBlockIP(sIPaddr);
                  CloseConnect(sIPaddr);
                end;
              mBlockList: begin
                  AddBlockIP(sIPaddr);
                  CloseConnect(sIPaddr);
                end;
            end;
          end else begin
            Socket.Close;
          end;
        end else begin
          StringList456A14.Delete(I);
        end;
        Result := True;
      end else begin
        New(NoLegalSession);
        NoLegalSession.sIP:= sIPaddr;
        NoLegalSession.nErrorCount := 1;
        StringList456A14.AddObject( sIPaddr ,TObject(NoLegalSession));
        Socket.Close;
      end;
    end;
  except
    MainOutMessage('{异常} TFrmMain.AddNoLegalIPToList', 1);
  end;
end;

procedure TFrmMain.N1Click(Sender: TObject);
var
  I: Integer;
  NoLegalSession: pTNoLegalSession;
begin
  if StringList456A14.Count > 0 then begin
    for I := 0 to StringList456A14.Count - 1 do begin
      NoLegalSession:= pTNoLegalSession(StringList456A14.Objects[I]);
      MainOutMessage('IP:'+NoLegalSession.sIP+' Count:'+inttostr(NoLegalSession.nErrorCount), 1);
    end;
  end;
end;

end.

