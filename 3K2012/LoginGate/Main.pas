unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, JSocket, WinSock, ExtCtrls, ComCtrls,
  Menus, IniFiles, GateShare, Common, EDcode, Grobal2, EDcodeUnit, Md5;
type
  TNoLegalSession = record//不合法会话结构
    sIP: string;//IP地址
    nErrorCount: Integer;//不合法连接次数
  end;
  pTNoLegalSession = ^TNoLegalSession;
  
  TUserSession = record
    Socket: TCustomWinSocket;
    sRemoteIPaddr: string;
    sMsgBuf : string;//防止半个包 沾包 By TasNat at: 2012-05-05 18:00:50
    nSendMsgLen: Integer;
    nReviceMsgLen: Integer;
    bo0C: Boolean;
    dw10Tick: LongWord;
    nCheckSendLength: Integer;
    boSendAvailable: Boolean;
    boSendCheck: Boolean;
    dwSendLockTimeOut: LongWord;
    nMsgLen: Integer;
    dwUserTimeOutTick: LongWord;
    SocketHandle: Integer;
    sIP: string;
    nHCode : DWord; //机器码 By TasNat at: 2012-05-11 10:42:04
    boProcFirstPack : Boolean; //是否已经处理第一个包 By TasNat at 2012-3-25 13:23:39
    SerMsgList: TStringList;
    dwConnctCheckTick: LongWord;
    dwReceiveTick: LongWord;
    dwReceiveTimeTick: LongWord;

    nReviceMsgLength: Integer;
    dwReceiveMsgTick: LongWord;
    {$IF SPECVERSION = 1}
    boLoginPassWord: Boolean; //是否验证成功
    nRandomID: Integer; //随机ID 防止脱机外挂
    {$IFEND}
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
    dwSendKeepAliveTick: LongWord;
    boServerReady: Boolean;

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

    function AddNoLegalIPToList(UserSession: pTUserSession): Boolean;//不合法会话加入列表，当达到指定次数时，加入过滤列表 20091121
    { Private declarations }
  public
    procedure CloseConnect(sIPaddr: string);
    function AddBlockIP(sIPaddr,sIPDate: string): Integer;//20080414
    function AddTempBlockIP(sIPaddr,sIPDate: string): Integer;//20080414
    function AddBlockHC(nHC : Cardinal): Integer;
     //增加动态过滤机器码
    function AddTempBlockHC(nHC : Cardinal): Integer;
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
//登陆器、客户端连接
procedure TFrmMain.ServerSocketClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  UserSession: pTUserSession;
  sRemoteIPaddr, sLocalIPaddr: string;
  nSockIndex: Integer;
  Msg : TDefaultMessage;
begin
  Socket.nIndex := -1;
  sRemoteIPaddr := Socket.RemoteAddress;

  if IsBlockIP(sRemoteIPaddr) then begin//检查是否是攻击的IP
    Inc(m_nAttackCount);
    m_dwAttackTick := GetTickCount;
    if m_nAttackCount < 10 then MainOutMessage('过滤连接: ' + sRemoteIPaddr, 1);
    Socket.Close;
    Exit;
  end;
  LaJiDaima;
  if IsConnLimited(sRemoteIPaddr, Socket.SocketHandle) then begin//检查单个IP的连接数是否超过限制
    if g_boChgDefendLevel then begin//自动调整防御等级
      Inc(m_nAttackCount);
      m_dwAttackTick := GetTickCount;
      if m_nAttackCount >= g_nChgDefendLevel then begin
        if g_BlockMethod = mDisconnect then g_BlockMethod := mBlock;
        if nAttackLevel > 1 then nAttackLevel := 1;
      end;
    end;

    case g_BlockMethod of
      mDisconnect: begin
          LaJiDaima;
          Socket.Close;
        end;
      mBlock: begin
          AddTempBlockIP(sRemoteIPaddr,SearchIPLocal(sRemoteIPaddr));//20080414
          CloseConnect(sRemoteIPaddr);
        end;
      mBlockList: begin
          AddBlockIP(sRemoteIPaddr,SearchIPLocal(sRemoteIPaddr));//20080414
          CloseConnect(sRemoteIPaddr);
        end;
    end;
    if m_nAttackCount < 10 then begin
      MainOutMessage('端口攻击: ' + sRemoteIPaddr, 1);
    end;
    Exit;
  end;

  if g_boDynamicIPDisMode then begin//动态IP模式
    sLocalIPaddr := ClientSocket.Socket.RemoteAddress;
  end else begin
    sLocalIPaddr := Socket.LocalAddress;
  end;

  if boGateReady then begin//网关状态就绪
    for nSockIndex := 0 to GATEMAXSESSION - 1 do begin
      UserSession := @g_SessionArray[nSockIndex];
      if UserSession.Socket = nil then begin
        UserSession.Socket := Socket;
        LaJiDaima;
        UserSession.sMsgBuf := '';
        UserSession.nHCode := 0;
        UserSession.sRemoteIPaddr := sRemoteIPaddr;
        UserSession.nSendMsgLen := 0;
        UserSession.nReviceMsgLen := 0;
        UserSession.bo0C := False;
        LaJiDaima;
        UserSession.dw10Tick := GetTickCount();
        UserSession.dwConnctCheckTick := GetTickCount();
        UserSession.boSendAvailable := True;
        UserSession.boSendCheck := False;
        UserSession.nCheckSendLength := 0;
        LaJiDaima;
        UserSession.nMsgLen := 0;
        UserSession.dwUserTimeOutTick := GetTickCount();
        LaJiDaima;
        UserSession.SocketHandle := Socket.SocketHandle;
        UserSession.sIP := sRemoteIPaddr;
        UserSession.dwReceiveTick := GetTickCount();
        UserSession.nReviceMsgLength := 0;
        UserSession.dwReceiveMsgTick := GetTickCount();
        LaJiDaima;
        UserSession.SerMsgList.Clear;
        UserSession.boProcFirstPack := False;
        Randomize();  //随机种子
        {$IF SPECVERSION = 1}
        UserSession.boLoginPassWord := False;
        UserSession.nRandomID := Random(100);
        {$IFEND}
        UserSession.nTemRandomID := Random(100);
        UserSession.boLegalConnection:= False;//是否合法连接 20091121
        Socket.nIndex := nSockIndex;
        Inc(nSessionCount);
        break;
      end;
    end;
    if Socket.nIndex >= 0 then begin
      LaJiDaima;
      //UserSession.Socket.SendText('#' + EncodeMessage(MakeDefaultMsg(SM_SENDLOGINRANDOMID, UserSession.nTemRandomID , UserSession.nRandomID, 0, 0, 0)) + '!');
      Msg := MakeDefaultMsg(SM_SENDLOGINKEY, UserSession.nTemRandomID, Random(100), Random(100), Random(100), Random(100));
      {$IF SPECVERSION = 1}  //20080901
        if MyRecInfo.sGatePass <> '' then begin //向登陆器、客户端发送封包码,用于登陆器、客户端检查封包码是否正确
          Socket.SendText('#' + EncodeMessage(Msg) + EncodeString(MyRecInfo.sGatePass) + '!');
        end else{$IFEND}
        Socket.SendText('#' + EncodeMessage(Msg) + '!');//20091121 发送验证码
      
      //通知LoginSrv.exe，有IP连接
      ClientSocket.Socket.SendText('%N' + IntToStr(Socket.SocketHandle) + '/' + sRemoteIPaddr + '/' + sLocalIPaddr + '$');
      MainOutMessage('连接: ' + sRemoteIPaddr, 5);
    end else begin
      Socket.Close;
      MainOutMessage('踢除: ' + sRemoteIPaddr, 1);
    end;
  end else begin
    Socket.Close;
    MainOutMessage('踢除: ' + sRemoteIPaddr, 1);
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
      LaJiDaima;
        for II := IPList.Count - 1 downto 0 do begin
          IPaddr := IPList.Items[II];
          if (IPaddr.nIPaddr = nIPaddr) and (IPaddr.nSocketHandle = Socket.SocketHandle) then begin
            Dispose(IPaddr);
            IPList.Delete(II);
            LaJiDaima;
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
    UserSession.sMsgBuf := '';
    LaJiDaima;
    UserSession.SocketHandle := -1;
    UserSession.SerMsgList.Clear;
    LaJiDaima;
    UserSession.boProcFirstPack := False;
    Dec(nSessionCount);
    if boGateReady then begin
      ClientSocket.Socket.SendText('%C' + IntToStr(Socket.SocketHandle) + '$');
      MainOutMessage('断开: ' + sRemoteIPaddr, 5);
    end;
  end;
end;
{--------------------和客户端发生错误---------------------}
procedure TFrmMain.ServerSocketClientError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
  Socket.Close;
  ErrorCode := 0;
end;


function ProcHCodeMsgPack(UserSession: pTUserSession; Msg : TDefaultMessage; sBody : string) : Boolean;
var
  MachineId: array [1..40] of Byte;
  TmpMsg : TDefaultMessage;
function CalcBufCRC(Buffer: PChar; nSize: Integer): Integer;
var
  I                 : Integer;
  Len               : Integer;
  Int               : PInteger;
  nCrc              : Integer;
begin
  Int := Pointer(Buffer);
  nCrc := 0;
  Len := nSize div 4 - 1;

  for I := 0 to Len do begin
    nCrc := nCrc xor Int^;
    Inc(Int);
  end;

  Result := nCrc;
end;
begin
  Result := sBody <> '';
  try
    {$I VM_Start.inc}//虚拟机标识
    UserSession.boProcFirstPack := False;
    
    DecodeBuffer(sBody, @MachineId, SizeOf(MachineId));

    TmpMsg.Recog := MakeLong(MakeWord(MachineId[21] xor MachineId[22] or MachineId[23],MachineId[24] xor
                                      MachineId[26] or MachineId[27]), MakeWord(MachineId[28] xor MachineId[29] or
                                      MachineId[31],    MachineId[32] xor MachineId[33] or MachineId[34]));
    TmpMsg.Param := MakeWord(MachineId[36] xor MachineId[37], MachineId[38] or MachineId[39]) xor TmpMsg.Recog;


    UserSession.nHCode := MakeLong(MakeWord(((MachineId[1] xor MachineId[2]) shl (MachineId[3] mod 2)) shr (MachineId[4] mod 2),
                                             ((MachineId[6] or MachineId[7]) shl (MachineId[8] mod 2)) shr (MachineId[9] mod 2)), MakeWord(
                                             ((MachineId[11] xor MachineId[12]) shl (MachineId[13] mod 2)) shr (MachineId[14] mod 2),
                                             ((MachineId[16] or MachineId[17]) shl (MachineId[18] mod 2)) shr (MachineId[19] mod 2)));

  TmpMsg.Tag := LoWord(UserSession.nHCode) xor TmpMsg.Param;
  TmpMsg.Series := HiWord(UserSession.nHCode) xor TmpMsg.Param;
  Result := (Msg.Recog = TmpMsg.Recog) and (Msg.Param = TmpMsg.Param) and (TmpMsg.Tag = Msg.Tag) and (TmpMsg.Series = Msg.Series);
  if Result then begin
    UserSession.nHCode := UserSession.nHCode xor CalcBufCRC(@MachineId, SizeOf(MachineId));
    if UserSession.nHCode = 0  then
      UserSession.nHCode := $120;
    MainOutMessage('[机器码]: $' + IntToHex(UserSession.nHCode, 8), 1);
    Result := (BlockHCList.IndexOf(Pointer(UserSession.nHCode)) = -1);
    if not Result then
      MainOutMessage('[机器码永久]过滤连接: ' + UserSession.sRemoteIPaddr, 1)
    else  begin
      Result := (TempBlockHCList.IndexOf(Pointer(UserSession.nHCode)) = -1);
      if not Result then
        MainOutMessage('[机器码临时]过滤连接: ' + UserSession.sRemoteIPaddr, 1)
    end;
  end else begin
    MainOutMessage('[机器码非法]过滤连接: ' + UserSession.sRemoteIPaddr, 1)
  end;
  UserSession.boProcFirstPack := Result;
  {$I VM_End.inc}
  except
  end;
  try
  if not Result then
    UserSession.Socket.Close;
  except

  end;
end;


{----------------读取登陆器、客户端发来的数据----'04EC80D7'--------------}
procedure TFrmMain.ServerSocketClientRead(Sender: TObject; Socket: TCustomWinSocket);
var
  UserSession: pTUserSession;
  nSockIndex: Integer;
  sRemoteAddress, sReviceMsg, s10, s1C, sSend: string;

  nPos: Integer;
  nMsgLen: Integer;
  nMsgCount: Integer;
  bo01: Boolean;
  bo02: Boolean;
  {$IF SPECVERSION = 1}  //20080831
  sRandomID: string;
  {$IFEND}
  sLoginPass: string;
  nPass, I:Integer;
  Msg : TDefaultMessage;
begin
  bo01 := False;
  bo02 := False;
  nSockIndex := Socket.nIndex;
  sRemoteAddress := Socket.RemoteAddress;
  if (nSockIndex >= 0) and (nSockIndex < GATEMAXSESSION) then begin
    UserSession := @g_SessionArray[nSockIndex];
    UserSession.sMsgBuf := UserSession.sMsgBuf + Socket.ReceiveText;
    sReviceMsg := UserSession.sMsgBuf;
    LaJiDaima;
    if (sReviceMsg <> '') and (boServerReady) then begin
{$REGION '垃圾代码'}
      nMsgLen := Length(sReviceMsg);
      if nAttackLevel > 0 then begin
      LaJiDaima;
        Inc(UserSession.nReviceMsgLen, nMsgLen);
        nMsgCount := TagCount(sReviceMsg, '!');
        LaJiDaima;
        if nMsgCount > nMaxClientMsgCount * nAttackLevel then bo02 := True;
        if nMsgLen > 358{ * nAttackLevel} then bo01 := True;//注册新用户，最大只有358
        if bo01 or bo02 then begin

          if g_boChgDefendLevel then begin
            Inc(m_nAttackCount);
            LaJiDaima;
            m_dwAttackTick := GetTickCount;
            if m_nAttackCount >= g_nChgDefendLevel then begin
              if g_BlockMethod = mDisconnect then g_BlockMethod := mBlock;
              if nAttackLevel > 1 then nAttackLevel := 1;
            end;
          end;

          case g_BlockMethod of
            mDisconnect: begin
                //Socket.Close;
              end;
            mBlock: begin
                LaJiDaima;
                if (g_BlockMethodData = bdAll) or (g_BlockMethodData = bdIP) then// 2012-3-25 16:36:13
                  AddTempBlockIP(sRemoteAddress,SearchIPLocal(sRemoteAddress));//20080414
                if (g_BlockMethodData = bdAll) or (g_BlockMethodData = bdHC) then
                  AddTempBlockHC(UserSession.nHCode);
                CloseConnect(sRemoteAddress);
              end;
            mBlockList: begin
                LaJiDaima;
                if (g_BlockMethodData = bdAll) or (g_BlockMethodData = bdIP) then // 2012-3-25 16:36:13
                  AddBlockIP(sRemoteAddress,SearchIPLocal(sRemoteAddress));//20080414
                if (g_BlockMethodData = bdAll) or (g_BlockMethodData = bdHC) then
                  AddBlockHC(UserSession.nHCode);
                CloseConnect(sRemoteAddress);
              end;
          end;
          if m_nAttackCount < 10 then begin
            LaJiDaima;
            if bo01 then
              MainOutMessage('端口攻击: ' + sRemoteAddress + ' 数据包长度: ' + IntToStr(UserSession.nReviceMsgLen), 1);
            if bo02 then
              MainOutMessage('端口攻击: ' + sRemoteAddress + ' 信息数量：' + IntToStr(nMsgCount), 1);
          end;
          Socket.Close;
          Exit;
        end;
      end;
{$EndREGION}
      nPos := Pos('*', sReviceMsg);
      if nPos > 0 then begin
        UserSession.boSendAvailable := True;
        LaJiDaima;
        UserSession.boSendCheck := False;
        UserSession.nCheckSendLength := 0;
        UserSession.dwReceiveTick := GetTickCount();
        LaJiDaima;
        s10 := Copy(sReviceMsg, 1, nPos - 1);
        LaJiDaima;
        s1C := Copy(sReviceMsg, nPos + 1, Length(sReviceMsg) - nPos);
        sReviceMsg := s10 + s1C;
      end;
      nMsgLen := Length(sReviceMsg);

      if UserSession.nReviceMsgLength <= 0 then UserSession.dwReceiveMsgTick := GetTickCount();
      Inc(UserSession.nReviceMsgLength, nMsgLen);

      if (sReviceMsg <> '') and (boGateReady) and (not boKeepAliveTimcOut) then begin
        UserSession.dwConnctCheckTick := GetTickCount();
        LaJiDaima;
        if (GetTickCount - UserSession.dwUserTimeOutTick) < 1000 then begin
          Inc(UserSession.nMsgLen, nMsgLen);
          LaJiDaima;
        end else UserSession.nMsgLen := nMsgLen;
        
        if not UserSession.boLegalConnection then begin
          nPos := Pos('<IGEM2>', sReviceMsg);
          if nPos > 0 then begin//20091121
            //取固定长度
            sLoginPass := Copy(sReviceMsg, nPos + 7, 12);
            if Length(sLoginPass) = 12 then begin
              Delete(sReviceMsg, nPos, 19);
              //长度固定了就不沾包了By TasNat at: 2012-11-14 09:51:48
              {//修复沾包导致被认定为非法连接的BUG By TasNat at: 2012-04-03 14:00:16
              I := Pos('#', sLoginPass);
              if I > 0 then
                sLoginPass := Copy(sLoginPass, 1, I -1); }

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
            if not UserSession.boLegalConnection then begin
              MainOutMessage('非法数据.断开连接.', 3);
              Socket.Close;
              Exit;
            end;
          end;           
        end else
        {$IF SPECVERSION = 1}
        // if (nMsgCount > 0) and (TagCount(sReviceMsg, '#') > 0) then//修改封包完整才提交到LoginSrv By TasNat at: 2012-04-25 10:55:38
        begin
          s1C := sReviceMsg;
          s1C := ArrestStringEx(s1C, '#', '!', sSend);
          if sSend <> '' then begin
            sReviceMsg := s1C;
              s1C := Copy(sSend, 2, DEFBLOCKSIZE);
              Msg := DecodeMessage(s1C);
              s10 := Copy(sSend, DEFBLOCKSIZE + 2, Length(sSend));//20081216
              case Msg.Ident of                   
                CM_HARDWARECODE : begin
                  if 54 = Length(s10) then begin
                    ProcHCodeMsgPack(UserSession, Msg, s10);  
                  end;
                end;
                CM_SELECTSERVER : begin
                  nPass := CalcBufferCRC(@g_sPassWord[1], Length(g_sPassWord)); 
                  UserSession.boLoginPassWord := nPass = (Msg.nSessionID xor Msg.Param mod 16);
                  nPass := CalcBufferCRC(@MyRecInfo.sGatePass[1], Length(MyRecInfo.sGatePass));  
                  UserSession.boLoginPassWord := UserSession.boLoginPassWord and (nPass = (Msg.Recog xor Msg.Param mod 16));    
                  if UserSession.boLoginPassWord then begin
                    if UserSession.boProcFirstPack then begin
                      //只屏蔽选择服务器 By TasNat at: 2012-05-06 13:15:59
                      s1C := sSend[1];
                      sSend := Copy(sSend, DEFBLOCKSIZE + 2, Length(sSend));
                      s10 := DecodeString(sSend);
                      //增加机器码
                      sSend := s1C + EncodeMessage(Msg) + EncodeString(s10 + '/$' +  IntToHex(UserSession.nHCode, 8));
                    end else begin
                      MainOutMessage('选择服务器失败1:$' + IntToHex(UserSession.nHCode, 8), 3);
                      Socket.Close;
                    end
                  end else begin
                    MainOutMessage('选择服务器失败,密码不对:' + g_sPassWord, 3);
                    Socket.Close;
                  end;
                end;
              end;
              if sSend <> '' then
                ClientSocket.Socket.SendText('%D' + IntToStr(Socket.SocketHandle) + '/#' + sSend + '!$');
          end;
        end
        {$else} begin
          s1C := sReviceMsg;
          s1C := ArrestStringEx(s1C, '#', '!', sSend);
          if sSend <> '' then begin
            sReviceMsg := s1C;
            ClientSocket.Socket.SendText('%D' + IntToStr(Socket.SocketHandle) + '/#' + sSend + '!$');
          end;          
        end{$IFEND};

      end;
    end;
    UserSession.sMsgBuf := sReviceMsg;
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
  TempLogList.Free;
  for nIndex := 0 to GATEMAXSESSION - 1 do begin
    g_SessionArray[nIndex].SerMsgList.Free;
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
{----------------------和LoginSrv连接------------------------}
procedure TFrmMain.ClientSocketConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  boGateReady := True;
  nSessionCount := 0;
  dwKeepAliveTick := GetTickCount();
  ResUserSessionArray();
  boServerReady := True;
end;
{----------------------和LoginSrv没连接------------------------}
procedure TFrmMain.ClientSocketDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  UserSession: pTUserSession;
  nIndex: Integer;
begin
  for nIndex := 0 to GATEMAXSESSION - 1 do begin
    UserSession := @g_SessionArray[nIndex];
    LaJiDaima;
    if UserSession.Socket <> nil then UserSession.Socket.Close;
    UserSession.Socket := nil;
    UserSession.sRemoteIPaddr := '';
    UserSession.sMsgBuf := '';
    LaJiDaima;
    UserSession.SocketHandle := -1;
  end;
  ResUserSessionArray();
  ClientSockeMsgList.Clear;
  LaJiDaima;
  boGateReady := False;
  nSessionCount := 0;
end;
{-----------------和LoginSrv连接错误-------------------}
procedure TFrmMain.ClientSocketError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
  Socket.Close;
  ErrorCode := 0;
  LaJiDaima;
  boServerReady := False;
end;
{-----------------读取LoginSrv发来的数据-------------------}
procedure TFrmMain.ClientSocketRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
  sRecvMsg: string;
begin
  sRecvMsg := Socket.ReceiveText;
  LaJiDaima;
  ClientSockeMsgList.Add(sRecvMsg);
end;

procedure TFrmMain.SendTimerTimer(Sender: TObject);
var
  nIndex: Integer;
  UserSession: pTUserSession;
begin
  if ServerSocket.Active then begin
    n456A30 := ServerSocket.Socket.ActiveConnections;//获得当前连接数
  end;
  if boSendHoldTimeOut then begin
    LbHold.Caption := IntToStr(n456A30) + '#';
    LaJiDaima;
    if (GetTickCount - dwSendHoldTick) > 3000 then boSendHoldTimeOut := False;
  end else begin
    LbHold.Caption := IntToStr(n456A30);
  end;
  if boGateReady and (not boKeepAliveTimcOut) then begin
    for nIndex := 0 to GATEMAXSESSION - 1 do begin
      UserSession := @g_SessionArray[nIndex];
      if UserSession.Socket <> nil then begin
        if (GetTickCount - UserSession.dwUserTimeOutTick) > 3600000{60 * 60 * 1000} then begin
          UserSession.Socket.Close;
          UserSession.Socket := nil;
          UserSession.sMsgBuf := '';
          UserSession.SocketHandle := -1;
          LaJiDaima;
          UserSession.SerMsgList.Clear;
          UserSession.boProcFirstPack := False;
          LaJiDaima;
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
        //m_dwAttackTick := GetTickCount;//20081030 增加
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
        if nAttackLevel <> nUseAttackLevel then nAttackLevel := nUseAttackLevel;
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
    StatusBar.Panels[1].Text := '---]    [---';//未连接
  end else begin
    if boKeepAliveTimcOut then begin
      StatusBar.Panels[1].Text := '---]$$$$[---';//超时
    end else begin
      StatusBar.Panels[1].Text := '-----][-----';//已连接
      LbLack.Caption := IntToStr(n456A2C) + '/' + IntToStr(nSendMsgCount);
    end;
  end;
  //MainOutMessage('Active: ' + BoolToStr(ClientSocket.Active) + ' Connected：' + BoolToStr(ClientSocket.Socket.Connected), 1);
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
                AddTempBlockIP(sRemoteIPaddr,SearchIPLocal(sRemoteIPaddr));//20080414
                Continue;
              end;
            'T': begin
                Inc(m_nAttackCount);
                m_dwAttackTick := GetTickCount;
                sRemoteIPaddr := CloseSocketAndGetIPAddr(Str_ToInt(Copy(sSocketMsg, 3, Length(sSocketMsg) - 2), 0));
                AddBlockIP(sRemoteIPaddr,SearchIPLocal(sRemoteIPaddr));//20080414
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
            g_SessionArray[nSocketIndex].SerMsgList.Add(sSocketMsg);
            break;
          end;
        end;
      end;
    end;
    if sProcessMsg <> '' then sProcMsg := sProcessMsg;

    nSendMsgCount := 0;
    n456A2C := 0;
    for nSocketIndex := 0 to GATEMAXSESSION - 1 do begin
      if g_SessionArray[nSocketIndex].SocketHandle <= -1 then Continue;

      //踢除超时无数据传输连接(端口空连接攻击)
      if (nAttackLevel > 0) and ((GetTickCount - g_SessionArray[nSocketIndex].dwConnctCheckTick) > dwKeepConnectTimeOut * nAttackLevel)
       then begin
        sRemoteIPaddr := g_SessionArray[nSocketIndex].sRemoteIPaddr;
        g_SessionArray[nSocketIndex].Socket.Close;
        Continue;
      end;
      //检查连接是否合法，不合法则加入列表并计数，断开当前连接 20091121                                      // 控制连接最大时间 （60秒）
      if not g_SessionArray[nSocketIndex].boLegalConnection and ((GetTickCount - g_SessionArray[nSocketIndex].dwConnctCheckTick) > 60000) then begin
        AddNoLegalIPToList(@g_SessionArray[nSocketIndex]);
        Continue;
      end;

      while (True) do begin
        if g_SessionArray[nSocketIndex].SerMsgList.Count <= 0 then break;
        UserSession := @g_SessionArray[nSocketIndex];
        nSendRetCode := SendUserMsg(UserSession, UserSession.SerMsgList.Strings[0]);
        if (nSendRetCode >= 0) then begin
          if nSendRetCode = 1 then begin
            UserSession.dwConnctCheckTick := GetTickCount();
            UserSession.SerMsgList.Delete(0);
            Continue;
          end;
          if UserSession.SerMsgList.Count > 100 then begin
            nMsgCount := 0;
            while nMsgCount <> 51 do begin
              UserSession.SerMsgList.Delete(0);
              Inc(nMsgCount);
            end;
          end;
          Inc(n456A2C, UserSession.SerMsgList.Count);
          MainOutMessage(UserSession.sIP +
            ' : ' +
            IntToStr(UserSession.SerMsgList.Count), 5);
          Inc(nSendMsgCount);
        end else begin
          UserSession.SocketHandle := -1;
          UserSession.Socket := nil;
          UserSession.sMsgBuf := '';
          UserSession.SerMsgList.Clear;
          UserSession.boProcFirstPack := False;
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
  Conf := TIniFile.Create(sConfigFileName);
  TitleName := Conf.ReadString(GateClass, 'Title', TitleName);
  ServerPort := Conf.ReadInteger(GateClass, 'ServerPort', ServerPort);
  ServerAddr := Conf.ReadString(GateClass, 'ServerAddr', ServerAddr);
  GatePort := Conf.ReadInteger(GateClass, 'GatePort', GatePort);
  GateAddr := Conf.ReadString(GateClass, 'GateAddr', GateAddr);
  nShowLogLevel := Conf.ReadInteger(GateClass, 'ShowLogLevel', nShowLogLevel);
  g_BlockMethod := TBlockIPMethod(Conf.ReadInteger(GateClass, 'BlockMethod', Integer(g_BlockMethod)));
  g_BlockMethodData := TBlockMethodData(Conf.ReadInteger(GateClass, 'BlockMethodData', Integer(g_BlockMethodData)));

  if Conf.ReadInteger(GateClass, 'KeepConnectTimeOut', -1) <= 0 then
    Conf.WriteInteger(GateClass, 'KeepConnectTimeOut', dwKeepConnectTimeOut);

  if Conf.ReadInteger(GateClass, 'AttackLevel', -1) <= 0 then
    Conf.WriteInteger(GateClass, 'AttackLevel', nAttackLevel);

  nAttackLevel := Conf.ReadInteger(GateClass, 'AttackLevel', nAttackLevel);
  nUseAttackLevel := nAttackLevel;

  nMaxConnOfNoLegal := Conf.ReadInteger(GateClass, 'MaxConnOfNoLegal', nMaxConnOfNoLegal);//20091121
  nMaxConnOfIPaddr := Conf.ReadInteger(GateClass, 'MaxConnOfIPaddr', nMaxConnOfIPaddr);
  dwKeepConnectTimeOut := Conf.ReadInteger(GateClass, 'KeepConnectTimeOut', dwKeepConnectTimeOut);
  g_boDynamicIPDisMode := Conf.ReadBool(GateClass, 'DynamicIPDisMode', g_boDynamicIPDisMode);
  g_boMinimize := Conf.ReadBool(GateClass, 'Minimize', g_boMinimize);

  g_boChgDefendLevel := Conf.ReadBool(GateClass, 'ChgDefendLevel', g_boChgDefendLevel);
  g_boClearTempList := Conf.ReadBool(GateClass, 'ClearTempList', g_boClearTempList);
  g_boReliefDefend := Conf.ReadBool(GateClass, 'ReliefDefend', g_boReliefDefend);
  g_nChgDefendLevel := Conf.ReadInteger(GateClass, 'ChgDefendLevelCount', g_nChgDefendLevel);
  g_dwClearTempList := Conf.ReadInteger(GateClass, 'ClearTempListTime', g_dwClearTempList);
  g_dwReliefDefend := Conf.ReadInteger(GateClass, 'ReliefDefendTime', g_dwReliefDefend);
  {$IF SPECVERSION = 1}
    g_boSpecLogin := Conf.ReadBool(GateClass, 'SpecLogin', g_boSpecLogin);
    g_sPassWord := Conf.ReadString(GateClass, 'PassWord', g_sPassWord);
    if FileExists('.\WarningMsg.txt') then
    frmGeneralConfig.MemoWarningMsg.Lines.LoadFromFile('.\WarningMsg.txt');
    frmGeneralConfig.MemoWarningMsgChange(nil);
  {$IFEND}
  dwAttackTime := Conf.ReadInteger(GateClass, 'AttackTime', dwAttackTime);//20091121
  nAttackCount := Conf.ReadInteger(GateClass, 'AttackCount', nAttackCount);//20091121
  Conf.Free;
  LoadBlockIPFile();
  LoadBlockHCFile();
end;
{-----------开始服务------------}
procedure TFrmMain.StartService;
{$IF SPECVERSION = 1}
var
  sLogoStr:String;
{$IFEND}  
begin
  try
    MainOutMessage('正在启动服务...', 3);
    SendGameCenterMsg(SG_STARTNOW, g_sNowStartGate);
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

    CurrIPaddrList := TGList.Create;
    BlockIPList := TGList.Create;
    TempBlockIPList := TGList.Create;

    BlockHCList := TGList.Create;
    TempBlockHCList := TGList.Create;

    AttackIPaddrList := TGList.Create;
    StringList456A14 := TStringList.Create;//20091121
    ClientSockeMsgList := TStringList.Create;

    ResUserSessionArray();
    LoadConfig();
    Caption := GateName + ' - ' + TitleName;
    ClientSocket.Active := False;
    ClientSocket.Host := ServerAddr;//连接LoginSrv
    ClientSocket.Port := ServerPort;
    ClientSocket.Active := True;

    ServerSocket.Active := False;
    ServerSocket.Address := GateAddr;
    ServerSocket.Port := GatePort;
    ServerSocket.Active := True;

    SendTimer.Enabled := True;
    MainOutMessage('启动服务完成...', 3);
    SendGameCenterMsg(SG_STARTOK, g_sNowStartOK);
    {$IF SPECVERSION = 1}
    Decode(g_sLogoStr, sLogoStr);
    MainOutMessage(sLogoStr, 3);
    {$IFEND}
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
  SaveBlockIPList();
  SaveBlockHCList();
  ServerSocket.Close;
  ClientSocket.Close;
  ClientSockeMsgList.Free;

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
  BlockHCList.Free;
  TempBlockHCList.Free;
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
    UserSession.sMsgBuf := '';
    UserSession.SocketHandle := -1;
    UserSession.SerMsgList.Clear;
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
    UserSession.sMsgBuf := '';
    UserSession.nHCode := 0;
    UserSession.nSendMsgLen := 0;
    UserSession.bo0C := False;
    UserSession.dw10Tick := GetTickCount();
    UserSession.boSendAvailable := True;
    UserSession.boSendCheck := False;
    UserSession.nCheckSendLength := 0;
    UserSession.nMsgLen := 0;
    UserSession.dwUserTimeOutTick := GetTickCount();
    UserSession.SocketHandle := -1;
    UserSession.dwReceiveTick := GetTickCount();
    UserSession.nReviceMsgLength := 0;
    UserSession.dwReceiveMsgTick := GetTickCount();
    UserSession.boProcFirstPack := False;
    UserSession.SerMsgList := TStringList.Create;
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
  dwDecodeMsgTime := 0;
  SendGameCenterMsg(SG_FORMHANDLE, IntToStr(Self.Handle));
  IniUserSessionArray();
  {$IF SPECVERSION = 1}  //20080831
  ExtractInfo(ProgramPath, MyRecInfo);//读出自身的信息
  {$IF Testing = 1}
  MyRecInfo.sGatePass := 'nl4vvhDYuUYrx6xltCcUn3qzVDypDtg66q';
  MemoLog.Lines.Add('封包码：'+ MyRecInfo.sGatePass);
  {$IFEND}
  if MyRecInfo.sGatePass = '' then
    Application.Terminate;
  {$IFEND}

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
  {$IF SPECVERSION = 1}
    TabSheet2.TabVisible := True;
    CheckBoxSpecLogin.Checked := g_boSpecLogin;
    EdtPassword.Text := g_sPassWord;
    if FileExists('.\WarningMsg.txt') then
      MemoWarningMsg.Lines.LoadFromFile('.\WarningMsg.txt');
  {$ELSE}
    TabSheet2.TabVisible := False;
  {$IFEND}
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
  frmIPaddrFilter.ListViewActiveList.Clear;
  frmIPaddrFilter.ListBoxTempList.Clear;
  frmIPaddrFilter.ListBoxBlockList.Clear;
  frmIPaddrFilter.ListBoxTempHCList.Clear;
  frmIPaddrFilter.ListBoxBlockHCList.Clear;
  frmIPaddrFilter.APOPMENU_REFLISTClick(nil);

  for I := 0 to TempBlockIPList.Count - 1 do begin
    if pos('*',pTSockaddr(TempBlockIPList.Items[I]).sIPaddr) > 0 then begin//判断是否是IP段 20081030
      frmIPaddrFilter.ListBoxTempList.Items.Add(pTSockaddr(TempBlockIPList.Items[I]).sIPaddr+'->');
    end else begin
      frmIPaddrFilter.ListBoxTempList.Items.Add(StrPas(inet_ntoa(TInAddr(pTSockaddr(TempBlockIPList.Items[I]).nIPaddr)))+'->'+pTSockaddr(TempBlockIPList.Items[i]).sIPDate);//20080414
    end;
  end;

  for I := 0 to BlockIPList.Count - 1 do begin
    if pos('*',pTSockaddr(BlockIPList.Items[I]).sIPaddr) > 0 then begin//判断是否是IP段 20081030
      frmIPaddrFilter.ListBoxBlockList.Items.Add(pTSockaddr(BlockIPList.Items[I]).sIPaddr+'->');
    end else begin
      frmIPaddrFilter.ListBoxBlockList.Items.Add(StrPas(inet_ntoa(TInAddr(pTSockaddr(BlockIPList.Items[I]).nIPaddr)))+'->'+pTSockaddr(BlockIPList.Items[i]).sIPDate);//20080414
    end;
  end;


  for I := 0 to TempBlockHCList.Count - 1 do begin
    frmIPaddrFilter.ListBoxTempHCList.Items.Add('$' + IntToHex(Cardinal(TempBlockHCList.Items[I]), 8));
  end;

  for I := 0 to BlockHCList.Count - 1 do begin
    frmIPaddrFilter.ListBoxBlockHCList.Items.Add('$' + IntToHex(Cardinal(BlockHCList.Items[I]), 8));
  end;


  frmIPaddrFilter.TrackBarAttack.Position := nAttackLevel;
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
  case g_BlockMethod of
    mDisconnect: frmIPaddrFilter.RadioDisConnect.Checked := True;
    mBlock: frmIPaddrFilter.RadioAddTempList.Checked := True;
    mBlockList: frmIPaddrFilter.RadioAddBlockList.Checked := True;
  end;
  case g_BlockMethodData of
    bdAll: frmIPaddrFilter.RadioButton3.Checked := True;
    bdIP: frmIPaddrFilter.RadioButton2.Checked := True;
    bdHC: frmIPaddrFilter.RadioButton1.Checked := True;
  end;
  frmIPaddrFilter.ShowModal;
end;
//检查是否是攻击的IP
function TFrmMain.IsBlockIP(sIPaddr: string): Boolean;
var
  I: Integer;
  IPaddr: pTSockaddr;
  nIPaddr: Integer;
  function IsRightBlockIP(sIPaddr, sSetIP: string): Boolean;
  var
    K: integer;
    sTemp,sTemp1: string;
  begin
    Result := False;
    K:= pos('*', sSetIP);
    if K > 0 then begin//判断是否是IP段 20081030
      sTemp:= Copy(sSetIP, 0, K - 1);
      sTemp1:= Copy(sIPaddr, 0, length(sTemp));
      if sTemp = sTemp1 then Result := True;
    end;
  end;
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
      if IsRightBlockIP(sIPaddr, IPaddr.sIPaddr) then begin
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
        if IsRightBlockIP(sIPaddr, IPaddr.sIPaddr) then begin
          Result := True;
          break;
        end;
      end;
    finally
      BlockIPList.UnLock;
    end;
  end;
end;
{-------------添加限制机器码函数---------------------}
function TFrmMain.AddBlockHC(nHC : Cardinal): Integer;
begin
  BlockHCList.Lock;
  try
    Result := BlockHCList.IndexOf(Pointer(nHC));
    if Result < 0 then
      Result := BlockHCList.Add(Pointer(nHC));
  finally
    BlockHCList.UnLock;
  end;
end;
//增加动态过滤机器码
function TFrmMain.AddTempBlockHC(nHC : Cardinal): Integer;
begin
  TempBlockHCList.Lock;
  try
    Result := TempBlockHCList.IndexOf(Pointer(nHC));
    if Result < 0 then
      Result := TempBlockHCList.Add(Pointer(nHC));
  finally
    TempBlockHCList.UnLock;
  end;
end;

{-------------添加限制IP函数---------------------}
function TFrmMain.AddBlockIP(sIPaddr, sIPDate: string): Integer;
var
  I: Integer;
  IPaddr: pTSockaddr;
  nIPaddr: Integer;
begin
  BlockIPList.Lock;
  try
    Result := 0;
    if pos('*',sIPaddr) > 0 then begin//判断是否是IP段 20081030
      for I := 0 to BlockIPList.Count - 1 do begin
        IPaddr := pTSockaddr(BlockIPList.Items[I]);
        if IPaddr.sIPaddr = sIPaddr then begin
          Result := BlockIPList.Count;
          break;
        end;
      end;
      if Result <= 0 then begin
        New(IPaddr);
        FillChar(IPaddr^, SizeOf(TSockaddr), 0);
        IPaddr^.sIPaddr := sIPaddr;//IP段
        IPaddr^.sIPDate := sIPDate;//20080414
        BlockIPList.Add(IPaddr);
        Result := BlockIPList.Count;
      end;
    end else begin
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
        FillChar(IPaddr^, SizeOf(TSockaddr), 0);
        IPaddr^.nIPaddr := nIPaddr;
        IPaddr^.sIPDate := sIPDate;//20080414
        BlockIPList.Add(IPaddr);
        Result := BlockIPList.Count;
      end;
    end;
  finally
    BlockIPList.UnLock;
  end;
end;
//增加动态过滤IP
function TFrmMain.AddTempBlockIP(sIPaddr,sIPDate: string): Integer;
var
  I: Integer;
  IPaddr: pTSockaddr;
  nIPaddr: Integer;
begin
  TempBlockIPList.Lock;
  try
    Result := 0;
    if pos('*',sIPaddr) > 0 then begin//判断是否是IP段 20081030
      for I := 0 to TempBlockIPList.Count - 1 do begin
        IPaddr := pTSockaddr(TempBlockIPList.Items[I]);
        if IPaddr.sIPaddr = sIPaddr then begin
          Result := TempBlockIPList.Count;
          break;
        end;
      end;
      if Result <= 0 then begin
        New(IPaddr);
        FillChar(IPaddr^, SizeOf(TSockaddr), 0);
        IPaddr^.sIPaddr := sIPaddr;//IP段
        IPaddr^.sIPDate := sIPDate;//20080414
        TempBlockIPList.Add(IPaddr);
        Result := TempBlockIPList.Count;
      end;
    end else begin
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
        IPaddr^.sIPDate := sIPDate;//20080414
        TempBlockIPList.Add(IPaddr);
        Result := TempBlockIPList.Count;
      end;
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
    if nAttackLevel > 0 then begin
      bo01 := False;
      nIPaddr := inet_addr(PChar(sIPaddr));
      for I := AttackIPaddrList.Count - 1 downto 0 do begin
        IPaddr := pTSockaddr(AttackIPaddrList.Items[I]);
        if IPaddr.nIPaddr = nIPaddr then begin
          if (GetTickCount - IPaddr.dwStartAttackTick) <= dwAttackTime {div nAttackLevel} then begin//一定时间内连接 20091121 修改
            //IPaddr.dwStartAttackTick := GetTickCount;
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
    if nAttackLevel > 0 then begin
      bo01 := False;
      nIPaddr := inet_addr(PChar(sIPaddr));
      for I := 0 to CurrIPaddrList.Count - 1 do begin
        IPList := TList(CurrIPaddrList.Items[I]);
        if (IPList <> nil) and (IPList.Count > 0) then begin
          IPaddr := pTSockaddr(IPList.Items[0]);
          if IPaddr <> nil then begin
            if IPaddr.nIPaddr = nIPaddr then begin
              bo01 := True;
              Result := AddAttackIP(sIPaddr);//检查是否攻击IP
              if Result then break;
              New(AttackIPaddr);
              FillChar(AttackIPaddr^, SizeOf(TSockaddr), 0);
              AttackIPaddr^.nIPaddr := nIPaddr;
              AttackIPaddr^.nSocketHandle := SocketHandle;
              IPList.Add(AttackIPaddr);
              if IPList.Count > nMaxConnOfIPaddr * nAttackLevel then Result := True;
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
function TFrmMain.AddNoLegalIPToList(UserSession: pTUserSession): Boolean;
var
  I: Integer;
  NoLegalSession: pTNoLegalSession;
  sIPaddr : string;
begin
  Result := False;
  try
    sIPaddr := UserSession.sIP;
    if nAttackLevel > 0 then begin
      I:= StringList456A14.IndexOf(sIPaddr);
      if I > -1 then begin//IP存在则计数
        NoLegalSession:= pTNoLegalSession(StringList456A14.Objects[I]);
        if NoLegalSession <> nil then begin
          Inc(NoLegalSession.nErrorCount);
          if NoLegalSession.nErrorCount >= nMaxConnOfNoLegal then begin//非法连接超过指定次数，加入过滤列表
            StringList456A14.Delete(I);
            Dispose(NoLegalSession);
            case g_BlockMethod of
              mDisconnect: begin
                  UserSession.Socket.Close;
                end;
              mBlock: begin
                  if (g_BlockMethodData = bdAll) or (g_BlockMethodData = bdIP) then
                    AddTempBlockIP(sIPaddr,SearchIPLocal(sIPaddr));
                  if (g_BlockMethodData = bdAll) or (g_BlockMethodData = bdHC) then
                    AddTempBlockHC(UserSession.nHCode);
                  CloseConnect(sIPaddr);
                end;
              mBlockList: begin
                  if (g_BlockMethodData = bdAll) or (g_BlockMethodData = bdIP) then
                    AddBlockIP(sIPaddr,SearchIPLocal(sIPaddr));
                  if (g_BlockMethodData = bdAll) or (g_BlockMethodData = bdHC) then
                    AddBlockHC(UserSession.nHCode);
                  CloseConnect(sIPaddr);
                end;
            end;
          end else begin
            UserSession.Socket.Close;
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
        UserSession.Socket.Close;
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
      MainOutMessage('IP:'+NoLegalSession.sIP+'  Count:'+inttostr(NoLegalSession.nErrorCount), 1);
    end;
  end;
end;

end.

