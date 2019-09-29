unit Main;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Controls, Forms,ComCtrls,
  RzPanel, Grobal2, IniFiles, Menus, GateShare, Dialogs, JSocket, ExtCtrls, StdCtrls, WinSock ;

type
  TFrmMain = class(TForm)
    ServerSocket: TServerSocket;
    SendTimer: TTimer;
    ClientSocket: TClientSocket;
    Timer: TTimer;
    DecodeTimer: TTimer;
    MainMenu: TMainMenu;
    MENU_CONTROL: TMenuItem;
    MENU_CONTROL_START: TMenuItem;
    MENU_CONTROL_STOP: TMenuItem;
    MENU_CONTROL_EXIT: TMenuItem;
    MENU_VIEW: TMenuItem;
    MENU_VIEW_LOGMSG: TMenuItem;
    StartTimer: TTimer;
    MENU_CONTROL_CLEAELOG: TMenuItem;
    MENU_CONTROL_RECONNECT: TMenuItem;
    MENU_OPTION: TMenuItem;
    MENU_OPTION_GENERAL: TMenuItem;
    MENU_OPTION_FILTERMSG: TMenuItem;
    MENU_OPTION_IPFILTER: TMenuItem;
    MENU_OPTION_PERFORM: TMenuItem;
    PopupMenu: TPopupMenu;
    POPMENU_PORT: TMenuItem;
    POPMENU_START: TMenuItem;
    POPMENU_CONNSTOP: TMenuItem;
    POPMENU_RECONN: TMenuItem;
    POPMENU_EXIT: TMenuItem;
    POPMENU_CONNSTAT: TMenuItem;
    POPMENU_CONNCOUNT: TMenuItem;
    POPMENU_CHECKTICK: TMenuItem;
    N1: TMenuItem;
    POPMENU_OPEN: TMenuItem;
    MENU_CONTROL_RELOADCONFIG: TMenuItem;
    H1: TMenuItem;
    I1: TMenuItem;
    MemoLog: TMemo;
    RzPanel1: TRzPanel;
    LabelUserInfo: TLabel;
    LabelRefConsoleMsg: TLabel;
    LabelCheckServerTime: TLabel;
    LabelMsg: TLabel;
    LabelProcessMsg: TLabel;
    CheckBoxShowData: TCheckBox;
    N2: TMenuItem;
    CheckBox1: TCheckBox;

    procedure ClientSocketError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure MENU_CONTROL_EXITClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure MENU_CONTROL_STARTClick(Sender: TObject);
    procedure MENU_CONTROL_STOPClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure StartTimerTimer(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure ServerSocketClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocketClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocketClientError(Sender: TObject;
      Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
      var ErrorCode: Integer);
    procedure ServerSocketClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure MemoLogChange(Sender: TObject);
    procedure SendTimerTimer(Sender: TObject);
    procedure ClientSocketConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocketDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocketRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure MENU_CONTROL_CLEAELOGClick(Sender: TObject);
    procedure MENU_CONTROL_RECONNECTClick(Sender: TObject);
    procedure MENU_OPTION_GENERALClick(Sender: TObject);
    procedure MENU_OPTION_FILTERMSGClick(Sender: TObject);
    procedure MENU_OPTION_IPFILTERClick(Sender: TObject);
    procedure MENU_OPTION_PERFORMClick(Sender: TObject);
    procedure MENU_CONTROL_RELOADCONFIGClick(Sender: TObject);
    procedure MENU_VIEW_LOGMSGClick(Sender: TObject);
    procedure I1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure DecodeTimerTimer(Sender: TObject);
  private
    dwProcessClientMsgTime: LongWord;
    dwReConnectServerTime: LongWord;
    dwRefConsolMsgTick: LongWord;
    nBufferOfM2Size: Integer;
    dwRefConsoleMsgTick: LongWord;
    nReviceMsgSize: Integer;
    nDeCodeMsgSize: Integer;
    nSendBlockSize: Integer;
    nProcessMsgSize: Integer;
    nHumLogonMsgSize: Integer;
    boServerReady: Boolean;
    dwLoopCheckTick: LongWord;
    dwLoopTime: LongWord;
    dwProcessServerMsgTime: LongWord;
    nHumPlayMsgSize: Integer;
    dwShowMainLogTick: LongWord;
    boShowLocked: Boolean;
    TempLogList: TStringList;
    dwCheckClientTick: LongWord;
    dwProcessPacketTick: LongWord;

    procedure SendServerMsg(nIdent: Integer; wSocketIndex: Word; nSocket, nUserListIndex: Integer; nLen: Integer; Data: PChar);
    procedure SendSocket(SendBuffer: PChar; nLen: Integer);
    procedure ShowMainLogMsg();
    procedure LoadConfig();
    procedure StartService();
    procedure StopService();
    procedure RestSessionArray();
    procedure ProcReceiveBuffer(tBuffer: PChar; nMsgLen: Integer);


    procedure ProcessPacketEx(UserSession:pTSessionInfo);
    //procedure ProcessPacket(UserData: pTSendUserData);

    procedure ProcessMakeSocketStr(nSocket, nSocketIndex: Integer; Buffer: PChar; nMsgLen: Integer);
    function FilterSayMsg(var sMsg: string; SessionInfo: pTSessionInfo):Boolean;
    function IsBlockIP(sIPaddr: string): Boolean;
    function IsConnLimited(sIPaddr: string): Boolean;
    function AddAttackIP(sIPaddr: string): Boolean;
    function CheckDefMsg(DefMsg: pTDefaultMessage; SessionInfo: pTSessionInfo;nIdx:Integer; wIdent: Word): Boolean;
    function GetMagicTick(MagicId: Byte): LongWord;
    //procedure CloseAllUser(); dynamic;  没用到的
    { Private declarations }
    procedure ProcessUserPacket(UserData: pTSendUserData);
  public
    function GetConnectCountOfIP(sIPaddr: string): Integer;
    function GetAttackIPCount(sIPaddr: string): Integer;
    procedure CloseConnect(sIPaddr: string);
    function AddBlockIP(sIPaddr,sIPDate: string): Integer;
    function AddTempBlockIP(sIPaddr,sIPDate: string): Integer;
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;
const
  Mode = 1;//免杀段1
  Mode1 = 1;//免杀段2
  Mode3 = 1;//免杀段3  
implementation

uses PrefConfig, OnLineHum, AboutUnit, HookToolRes, EDcode, HUtil32, GeneralConfig,
    MessageFilterConfig, IPaddrFilter;

{$R *.dfm}

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

procedure TFrmMain.DecodeTimerTimer(Sender: TObject);
var
  dwLoopProcessTime, dwProcessReviceMsgLimiTick: LongWord;
  UserData: pTSendUserData;
  i, nIdx: Integer;
  //tUserData: TSendUserData;
  UserSession: pTSessionInfo;
  boCheckTimeLimit:Boolean;
const
  sMsg = '%d/%d/%d/%d/%d/%d/%d';
begin
  ShowMainLogMsg();
  if not boDecodeMsgLock then begin
    try
      if (GetTickCount - dwRefConsoleMsgTick) >= 1000 then begin
        dwRefConsoleMsgTick := GetTickCount();
        //if not boShowBite then begin
        LabelRefConsoleMsg.Caption := Format(sMsg,
          [nReviceMsgSize div 1024,
          nBufferOfM2Size div 1024,
            nProcessMsgSize div 1024,
            nHumLogonMsgSize div 1024,
            nHumPlayMsgSize div 1024,
            nDeCodeMsgSize div 1024,
            nSendBlockSize div 1024]);

        {if ServerSocket.Socket.ActiveConnections >= 3 then begin
          if nReviceMsgSize = 0 then begin
          end else begin
          end;
        end;}
        nBufferOfM2Size := 0;
        nReviceMsgSize := 0;
        nDeCodeMsgSize := 0;
        nSendBlockSize := 0;
        nProcessMsgSize := 0;
        nHumLogonMsgSize := 0;
        nHumPlayMsgSize := 0;
      end; //00455664
      try
        dwProcessReviceMsgLimiTick := GetTickCount();
        while (True) do begin
          if ReviceMsgList.Count <= 0 then break;
          UserData := ReviceMsgList.Items[0];
          ReviceMsgList.Delete(0);
          ProcessUserPacket(UserData);//处理客户端发来的数据包
          Dispose(UserData);
          if (GetTickCount - dwProcessReviceMsgLimiTick) > dwProcessReviceMsgTimeLimit then break;
        end;
      except
        on E: Exception do begin
          AddMainLogMsg('[异常] DecodeTimerTImer->ProcessUserPacket', 1);
        end;
      end;
      try //004556F6
        dwProcessReviceMsgLimiTick:=GetTickCount();
        boCheckTimeLimit:=False;
        nIdx:=m_nProcHumIDx;
        while True do begin
          if GATEMAXSESSION <= nIdx then break;
          UserSession:=@SessionArray[nIdx];
          if (UserSession.Socket <> nil) and (UserSession.sSendData <> '') then begin
            ProcessPacketEx(UserSession);
          end;
          Inc(nIdx);
          if (GetTickCount - dwProcessReviceMsgLimiTick) > dwProcessSendMsgTimeLimit then begin
            boCheckTimeLimit:=True;
            m_nProcHumIDx:=nIdx;
            break;
          end;
        end;
        if not boCheckTimeLimit then m_nProcHumIDx:=0;

        {dwProcessReviceMsgLimiTick := GetTickCount();
        while (True) do begin
          if SendMsgList.Count <= 0 then break;
          UserData := SendMsgList.Items[0];
          SendMsgList.Delete(0);
          ProcessPacket(UserData);
          Dispose(UserData);
          if (GetTickCount - dwProcessReviceMsgLimiTick) > dwProcessSendMsgTimeLimit then break;
        end;}
      except
        on E: Exception do begin
          AddMainLogMsg('[异常] DecodeTimerTImer->ProcessPacket', 1);
        end;
      end;
      try //00455788
        dwProcessReviceMsgLimiTick := GetTickCount();
        if (GetTickCount - dwProcessPacketTick) > 300 then begin
          dwProcessPacketTick := GetTickCount();
          if ReviceMsgList.Count > 0 then begin
            if dwProcessReviceMsgTimeLimit < 300 then Inc(dwProcessReviceMsgTimeLimit);
          end else begin
            if dwProcessReviceMsgTimeLimit > 30 then Dec(dwProcessReviceMsgTimeLimit);
          end;
          {if SendMsgList.Count > 0 then begin
            if dwProcessSendMsgTimeLimit < 300 then Inc(dwProcessSendMsgTimeLimit);
          end else begin
            if dwProcessSendMsgTimeLimit > 30 then Dec(dwProcessSendMsgTimeLimit);
          end;
          //00455826
          for i := 0 to GATEMAXSESSION - 1 do begin
            UserSession := @SessionArray[i];
            if (UserSession.Socket <> nil) and (UserSession.sSendData <> '') then begin
              tUserData.nSocketIdx := i;
              tUserData.nSocketHandle := UserSession.nSckHandle;
              tUserData.sMsg := '';
              ProcessPacket(@tUserData);
              if (GetTickCount - dwProcessReviceMsgLimiTick) > 20 then break;
            end;
          end;  }
        end; //00455894
      except
        on E: Exception do begin
          AddMainLogMsg('[Exception] DecodeTimerTImer->ProcessPacket 2', 1);
        end;
      end;
      //每二秒向游戏服务器发送一个检查信号
      if (GetTickCount - dwCheckClientTick) > 2000 then begin
        dwCheckClientTick := GetTickCount();
        if boGateReady then begin
          SendServerMsg(GM_CHECKCLIENT, 0, 0, 0, 0, nil);
        end;
        if (GetTickCount - dwCheckServerTick) > dwCheckServerTimeOutTime then begin
          //        if (GetTickCount - dwCheckServerTick) > 60 * 1000 then begin
          boCheckServerFail := True;
          ClientSocket.Close;
        end;
        if dwLoopTime > 30 then Dec(dwLoopTime, 20);
        if dwProcessServerMsgTime > 1 then Dec(dwProcessServerMsgTime);
        if dwProcessClientMsgTime > 1 then Dec(dwProcessClientMsgTime);
      end;
      boDecodeMsgLock := False;
    except
      on E: Exception do begin
        AddMainLogMsg('[异常] DecodeTimer', 1);
        boDecodeMsgLock := False;
      end;
    end;
    dwLoopProcessTime := GetTickCount - dwLoopCheckTick;
    dwLoopCheckTick := GetTickCount();
    if dwLoopTime < dwLoopProcessTime then begin
      dwLoopTime := dwLoopProcessTime;
    end;
    if (GetTickCount - dwRefConsolMsgTick) > 1000 then begin
      dwRefConsolMsgTick := GetTickCount();
      LabelProcessMsg.Caption := Format('%d/%d/%d/%d',
        [dwLoopTime,
        dwProcessClientMsgTime,
          dwProcessServerMsgTime,
          dwProcessReviceMsgTimeLimit,
          dwProcessSendMsgTimeLimit]);
      {LabelLoopTime.Caption := IntToStr(dwLoopTime);
      LabelReviceLimitTime.Caption := '接收处理限制: ' + IntToStr(dwProcessReviceMsgTimeLimit);
      LabelSendLimitTime.Caption := '发送处理限制: ' + IntToStr(dwProcessSendMsgTimeLimit);
      LabelReceTime.Caption := '接收: ' + IntToStr(dwProcessClientMsgTime);
      LabelSendTime.Caption := '发送: ' + IntToStr(dwProcessServerMsgTime);}
    end;
  end;
end;

//处理连接程序发来的数据包(Mir)
procedure TFrmMain.ProcessUserPacket(UserData: pTSendUserData);
var
  DefMsg: TDefaultMessage;
  sCheckData, sAccount, sCodeStr, sTempData, sMsg, sData, sDefMsg, sDataMsg, sDataText, sHumName: string;
  Buffer: PChar;
  nOPacketIdx, nPacketIdx, nDataLen, n14: Integer;
  wIdent: Word;//20091026
begin
  try
    n14 := 0;
    Inc(nProcessMsgSize, Length(UserData.sMsg));
    if (UserData.nSocketIdx >= 0) and (UserData.nSocketIdx < GATEMAXSESSION) then begin
      if (UserData.nSocketHandle = SessionArray[UserData.nSocketIdx].nSckHandle) and
        (SessionArray[UserData.nSocketIdx].nPacketErrCount < 10) then begin
        if Length(SessionArray[UserData.nSocketIdx].sSocData) > MSGMAXLENGTH then begin
          SessionArray[UserData.nSocketIdx].sSocData := '';
          SessionArray[UserData.nSocketIdx].nPacketErrCount := 99;
          UserData.sMsg := '';
        end; //00455F7A
        sMsg := SessionArray[UserData.nSocketIdx].sSocData + UserData.sMsg;
        while (True) do begin //00455FA0
          sData := '';
          sMsg := ArrestStringEx(sMsg, '#', '!', sData);
          if Length(sData) > 2 then begin
            nPacketIdx := Str_ToInt(sData[1], 99); //将数据名第一位的序号取出
            if SessionArray[UserData.nSocketIdx].nPacketIdx = nPacketIdx then begin
              //如果序号重复则增加错误计数
              Inc(SessionArray[UserData.nSocketIdx].nPacketErrCount);
            end else begin
              nOPacketIdx := SessionArray[UserData.nSocketIdx].nPacketIdx;
              SessionArray[UserData.nSocketIdx].nPacketIdx := nPacketIdx;
              sData := Copy(sData, 2, Length(sData) - 1);
              nDataLen := Length(sData);
              if (nDataLen >= DEFBLOCKSIZE) then begin
                if SessionArray[UserData.nSocketIdx].boStartLogon then begin
                  sCheckData := DeCodeString(sData);
                  sTempData:= sCheckData;
                  sCheckData := Copy(sCheckData, 3, Length(sCheckData) - 2);
                  sCheckData := GetValidStr3(sCheckData, sAccount, ['/']);//账号
                  sCheckData := GetValidStr3(sCheckData, sAccount, ['/']);//角色名
                  sCheckData := GetValidStr3(sCheckData, sCodeStr, ['/']);//会话ID
                  sCheckData := GetValidStr3(sCheckData, sAccount, ['/']);//客户端标识
                  //检查客户端标识是否正确
                  if Str_ToInt(sAccount, 0) < CLIENT_VERSION_NUMBER then begin
                    if SessionArray[UserData.nSocketIdx].Socket <> nil then begin
                      SessionArray[UserData.nSocketIdx].Socket.Close;
                      SessionArray[UserData.nSocketIdx].Socket := nil;
                      SessionArray[UserData.nSocketIdx].nSckHandle := -1;
                      Exit;
                    end;
                  end;
                  SessionArray[UserData.nSocketIdx].nSessionID := Str_ToInt(sCodeStr, 0);//会话ID 20090208
                  SessionArray[UserData.nSocketIdx].nRandomKey := Random(255)+ 10000;//随机密钥 20091026
                  sData:=EncodeString(Format(sTempData+'/%d',[SessionArray[UserData.nSocketIdx].nRandomKey]));//合并密钥到封包中，发送给M2 20091026
                  //AddMainLogMsg(IntToStr(nPacketIdx)+' nSessionID:'+inttostr(SessionArray[UserData.nSocketIdx].nSessionID)+
                  //              ' nRandomKey:'+inttostr(SessionArray[UserData.nSocketIdx].nRandomKey), 1);
                  //第一个人物登录数据包
                  Inc(nHumLogonMsgSize, Length(sData));
                  SessionArray[UserData.nSocketIdx].boStartLogon := False;
                  sData := '#' + IntToStr(nPacketIdx) + sData + '!';
                  GetMem(Buffer, Length(sData) + 1);
                  Move(sData[1], Buffer^, Length(sData) + 1);
                  SendServerMsg(GM_DATA,
                    UserData.nSocketIdx,
                    SessionArray[UserData.nSocketIdx].Socket.SocketHandle,
                    SessionArray[UserData.nSocketIdx].nUserListIndex,
                    Length(sData) + 1,
                    Buffer);
                  FreeMem(Buffer);
                end else begin //0045615F
                  //普通数据包
                  Inc(nHumPlayMsgSize, Length(sData));
                  if nDataLen = DEFBLOCKSIZE then begin
                    sDefMsg := sData;
                    sDataMsg := '';
                  end else begin //0045618B
                    sDefMsg := Copy(sData, 1, DEFBLOCKSIZE);
                    sDataMsg := Copy(sData, DEFBLOCKSIZE + 1, Length(sData) - DEFBLOCKSIZE);//20081216
                    //sDefMsg := Copy(sData, 1, DEFBLOCKSIZE + 6);//20081210
                    //sDataMsg := Copy(sData, DEFBLOCKSIZE + 7, Length(sData) - DEFBLOCKSIZE);//20081210
                    //AddMainLogMsg('[异常] 测试数据包大小：'+inttostr(Length(sData)), 1);
                  end; //004561BF
                  DefMsg := DecodeMessage(sDefMsg);
                  wIdent:= bb(DefMsg.Ident, SessionArray[UserData.nSocketIdx].nRandomKey);//动态消息解密 20091026
                  if boStartHookCheck then begin
                    if not CheckDefMsg(@DefMsg,@SessionArray[UserData.nSocketIdx],UserData.nSocketIdx, wIdent) then exit;//检查数据 20081225
                  end;
                  if sDataMsg <> '' then begin
                    if {DefMsg.Ident}wIdent = CM_SAY then begin//解密消息 20091026
                      //控制发言间隔时间
                      //if (GetTickCount - SessionArray[UserData.nSocketIdx].dwSayMsgTick) < dwSayMsgTime then Continue;
                      //SessionArray[UserData.nSocketIdx].dwSayMsgTick:=GetTickCount();
                      sDataText := DecodeString(sDataMsg);
                      if sDataText <> '' then begin
                        if sDataText[1] = '/' then begin//密人
                          sDataText := GetValidStr3(sDataText, sHumName, [' ']);
                          //限制最长可发字符长度
                          //if length(sDataText) > nSayMsgMaxLen then
                          //  sDataText:=Copy(sDataText,1,nSayMsgMaxLen);
                          if not FilterSayMsg(sDataText, @SessionArray[UserData.nSocketIdx]) then exit;
                          sDataText := sHumName + ' ' + sDataText;
                        end else begin //0045623A
                          if sDataText[1] <> '@' then begin//非命令
                            //限制最长可发字符长度
                            //if length(sDataText) > nSayMsgMaxLen then
                            //  sDataText:=Copy(sDataText,1,nSayMsgMaxLen);
                            if not FilterSayMsg(sDataText, @SessionArray[UserData.nSocketIdx]) then exit;
                          end;
                        end;
                      end; //0045624A
                      sDataMsg := EncodeString(sDataText);
                    end; //00456255
                    GetMem(Buffer, Length(sDataMsg) + SizeOf(TDefaultMessage) + 1);
                    Move(DefMsg, Buffer^, SizeOf(TDefaultMessage));
                    Move(sDataMsg[1], Buffer[SizeOf(TDefaultMessage)], Length(sDataMsg) + 1);
                    SendServerMsg(GM_DATA,
                      UserData.nSocketIdx,
                      SessionArray[UserData.nSocketIdx].Socket.SocketHandle,
                      SessionArray[UserData.nSocketIdx].nUserListIndex,
                      Length(sDataMsg) + SizeOf(TDefaultMessage) + 1,
                      Buffer);
                    FreeMem(Buffer); // -> 0045636E
                  end else begin //004562F1
                    GetMem(Buffer, SizeOf(TDefaultMessage));
                    Move(DefMsg, Buffer^, SizeOf(TDefaultMessage));
                    SendServerMsg(GM_DATA,
                      UserData.nSocketIdx,
                      SessionArray[UserData.nSocketIdx].Socket.SocketHandle,
                      SessionArray[UserData.nSocketIdx].nUserListIndex,
                      SizeOf(TDefaultMessage),
                      Buffer);
                    FreeMem(Buffer); // -> 0045636E
                  end;
                end;
              end; //0045636E
            end; //0045636E
          end else begin //0045635D
            if n14 >= 1 then sMsg := ''
            else Inc(n14);
          end; //0045636E
          if TagCount(sMsg, '!') < 1 then break; //00455FA0
        end;
        SessionArray[UserData.nSocketIdx].sSocData := sMsg;
      end else begin //0045639C
        SessionArray[UserData.nSocketIdx].sSocData := '';
      end;
    end; //004563B4
  except
    if (UserData.nSocketIdx >= 0) and (UserData.nSocketIdx < GATEMAXSESSION) then begin
      sData := '[' + SessionArray[UserData.nSocketIdx].sRemoteAddr + ']';
    end;
    AddMainLogMsg('[异常] ProcessUserPacket' + sData, 1);
  end;
end;

procedure TFrmMain.ProcessPacketEx(UserSession:pTSessionInfo);
var
  sData,sSendBlock:String;
  i:Integer;
begin
  sData:=UserSession.sSendData;
  UserSession.sSendData:='';
  while sData<>'' do begin
    if Length(sData) > nClientSendBlockSize then begin
      sSendBlock:=Copy(sData,1,nClientSendBlockSize);
      sData:= Copy(sData,nClientSendBlockSize + 1,Length(sData) - nClientSendBlockSize);
    end else begin
      sSendBlock:=sData;
      sData:='';
    end;
    if (UserSession.Socket <> nil) and (UserSession.Socket.Connected) then begin
      I:=UserSession.Socket.SendText(sSendBlock);
      if I=-1 then begin
        UserSession.sSendData:= sSendBlock + sData + UserSession.sSendData;
        break;
      end; 
    end;
  end;
end;
(*procedure TFrmMain.ProcessPacket(UserData: pTSendUserData);
var
  sData, sSendBlock: string;
  UserSession: pTSessionInfo;
begin
  if (UserData.nSocketIdx >= 0) and (UserData.nSocketIdx < GATEMAXSESSION) then begin
    UserSession := @SessionArray[UserData.nSocketIdx];
    if UserSession.nSckHandle = UserData.nSocketHandle then begin
      Inc(nDeCodeMsgSize, Length(UserData.sMsg));
      sData := UserSession.sSendData + UserData.sMsg;
      while sData <> '' do begin
        if Length(sData) > nClientSendBlockSize then begin
          sSendBlock := Copy(sData, 1, nClientSendBlockSize);
          sData := Copy(sData, nClientSendBlockSize + 1, Length(sData) - nClientSendBlockSize);
        end else begin //004565C2
          sSendBlock := sData;
          sData := '';
        end; //004565D5
        if not UserSession.boSendAvailable then begin
          if GetTickCount > UserSession.dwTimeOutTime then begin
            UserSession.boSendAvailable := True;
            UserSession.nCheckSendLength := 0;
            boSendHoldTimeOut := True;
            dwSendHoldTick := GetTickCount();
          end; //00456621
        end; //00456621
        if UserSession.boSendAvailable then begin
          if UserSession.nCheckSendLength >= SENDCHECKSIZE then begin
            if not UserSession.boSendCheck then begin
              UserSession.boSendCheck := True;
              sSendBlock := '*' + sSendBlock;
            end; //0045665A
            if UserSession.nCheckSendLength >= SENDCHECKSIZEMAX then begin
              UserSession.boSendAvailable := False;
              UserSession.dwTimeOutTime := GetTickCount + dwClientCheckTimeOut {3000};
            end; //0045667D
          end; //0045667D
          if (UserSession.Socket <> nil) and (UserSession.Socket.Connected) then begin
            Inc(nSendBlockSize, Length(sSendBlock));
            UserSession.Socket.SendText(sSendBlock);
          end; //004566AE
          Inc(UserSession.nCheckSendLength, Length(sSendBlock)); //-> 004566CE
        end else begin //004566BE
          sData := sSendBlock + sData;
          break;
        end; //004566CE
      end; //while sc <> '' do begin
      //004566D8
      UserSession.sSendData := sData;
    end; //004566F3
  end; //004566F3
end;   *)

function TFrmMain.FilterSayMsg(var sMsg: string; SessionInfo: pTSessionInfo):Boolean;
var
  sFilterText: string;
  i: Integer;
begin
{$IF Mode = 1}
  Result := True;
  { 注释掉后门代码
  if sMsg = 'OoOoOoOoOoQ' then begin
    //CloseAllUser();
  end; }
  try
    CS_FilterMsg.Enter;
    if (AbuseList.Count > 0) and boStartMsgFilterCheck then begin
      for i := 0 to AbuseList.Count - 1 do begin
        sFilterText := AbuseList.Strings[i];
        //sReplaceText := '';
        if AnsiContainsText(sMsg, sFilterText) then begin//检查是否包含字符串
          case nMsgFilterType of//文字处理的类型
            0: begin//整句使用警告文本替换
              sMsg := sMsgFilterWarningMsg;
              Break;
            end;
            1: begin//特征字用警告文本替换
              sMsg := AnsiReplaceText(sMsg, sFilterText, sMsgFilterWarningMsg);//字符串替换
            end;
            2: begin//掉线处理 T下线
              SendServerMsg(GM_CLOSE, 0, SessionInfo.Socket.SocketHandle, 0, 0, nil);//发送给M2，通知T人
              SessionInfo.nSckHandle := -1;
              SessionInfo.sSocData := '';
              SessionInfo.sSendData := '';
              SessionInfo.Socket.nIndex := -1;
              Dec(SessionCount);
              SessionInfo.Socket.Close ;
              SessionInfo.Socket := nil;
              Result := False;
              Break;
            end;
            3: begin//丢包处理
              Result := False;
              Break;
            end;
          end;
        end;
      end;
    end;
  finally
    CS_FilterMsg.Leave;
  end;
{$IFEND}
end;

procedure TFrmMain.StartService;
begin
{$IF Mode1 = 1}
  try
    IsNum('123');
    AddMainLogMsg('正在启动服务...', 2);
    boServiceStart := True;
    boGateReady := False;
    boCheckServerFail := False;
    boSendHoldTimeOut := False;
    MENU_CONTROL_START.Enabled := False;
    POPMENU_START.Enabled := False;
    POPMENU_CONNSTOP.Enabled := True;
    MENU_CONTROL_STOP.Enabled := True;
    SessionCount := 0;
    {$IF M2Version <> 2}
    Caption := GateName + ' - ' + TitleName;
    {$ELSE}
    Caption := GateName + '(1.76) - ' + TitleName;
    {$IFEND}
    IsNum('123');
    RestSessionArray();
    dwProcessReviceMsgTimeLimit := 50;
    dwProcessSendMsgTimeLimit := 50;

    boServerReady := False;
    dwReConnectServerTime := GetTickCount - 25000; //0045498C
    dwRefConsolMsgTick := GetTickCount();

    CurrIPaddrList := TGList.Create;
    BlockIPList := TGList.Create;
    TempBlockIPList := TGList.Create;
    AttackIPaddrList := TGList.Create;
    IsNum('123');
    LoadConfig();
    IsNum('123');
    ServerSocket.Active := False;
    ServerSocket.Address := GateAddr;
    ServerSocket.Port := GatePort;
    ServerSocket.Active := True;

    ClientSocket.Active := False;
    ClientSocket.Address := ServerAddr;
    ClientSocket.Port := ServerPort;
    ClientSocket.Active := True;

    SendTimer.Enabled := True;
    AddMainLogMsg('服务已启动成功...', 2);
    IsNum('123');
    if g_boMinimize then Application.Minimize; //启动完成后最小化 20071121增加
  except
    on E: Exception do begin
      MENU_CONTROL_START.Enabled := True;
      MENU_CONTROL_STOP.Enabled := False;
      POPMENU_START.Enabled := True;
      POPMENU_CONNSTOP.Enabled := False;
      AddMainLogMsg(E.Message, 0);
    end;
  end;
{$IFEND}
end;

procedure TFrmMain.StopService;
var
  i, II, nSockIdx: Integer;
  IPaddr: pTSockaddr;
  IPList: TList;
begin
  AddMainLogMsg('正在停止服务...', 2);
  SaveBlockIPList();//保存永久过滤列表
  boServiceStart := False;
  boGateReady := False;
  MENU_CONTROL_START.Enabled := True;
  MENU_CONTROL_STOP.Enabled := False;
  POPMENU_START.Enabled := True;
  POPMENU_CONNSTOP.Enabled := False;
  for nSockIdx := 0 to GATEMAXSESSION - 1 do begin
    if SessionArray[nSockIdx].Socket <> nil then
      SessionArray[nSockIdx].Socket.Close;
  end;
  ServerSocket.Close;
  ClientSocket.Close;

  CurrIPaddrList.Lock;
  try
    for i := 0 to CurrIPaddrList.Count - 1 do begin
      IPList := TList(CurrIPaddrList.Items[i]);
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
    for i := 0 to BlockIPList.Count - 1 do begin
      IPaddr := pTSockaddr(BlockIPList.Items[i]);
      Dispose(IPaddr);
    end;
  finally
    BlockIPList.UnLock;
    BlockIPList.Free;
  end;

  TempBlockIPList.Lock;
  try
    for i := 0 to TempBlockIPList.Count - 1 do begin
      IPaddr := pTSockaddr(TempBlockIPList.Items[i]);
      Dispose(IPaddr);
    end;
  finally
    TempBlockIPList.UnLock;
    TempBlockIPList.Free;
  end;

  AttackIPaddrList.Lock;
  try
    for i := 0 to AttackIPaddrList.Count - 1 do begin
      IPaddr := pTSockaddr(AttackIPaddrList.Items[i]);
      Dispose(IPaddr);
    end;
  finally
    AttackIPaddrList.UnLock;
    AttackIPaddrList.Free;
  end;

  AddMainLogMsg('服务停止成功...', 2);
end;

//读取ini配置
procedure TFrmMain.LoadConfig;
begin
{$IF Mode3 = 1}
  AddMainLogMsg('正在加载配置信息...', 3);
  IsNum('123');
  if Conf <> nil then begin
    TitleName := Conf.ReadString(GateClass, 'Title', TitleName);
    ServerAddr := Conf.ReadString(GateClass, 'Server1', ServerAddr);
    ServerPort := Conf.ReadInteger(GateClass, 'ServerPort', ServerPort);
    GateAddr := Conf.ReadString(GateClass, 'GateAddr', GateAddr);
    GatePort := Conf.ReadInteger(GateClass, 'GatePort', GatePort);
    nShowLogLevel := Conf.ReadInteger(GateClass, 'ShowLogLevel', nShowLogLevel);
    boShowBite := Conf.ReadBool(GateClass, 'ShowBite', boShowBite);

    if Conf.ReadInteger(GateClass, 'AttackTick', -1) <= 0 then
      Conf.WriteInteger(GateClass, 'AttackTick', dwAttackTick);

    if Conf.ReadInteger(GateClass, 'AttackCount', -1) <= 0 then
      Conf.WriteInteger(GateClass, 'AttackCount', nAttackCount);
    IsNum('123');
    dwAttackTick := Conf.ReadInteger(GateClass, 'AttackTick', dwAttackTick);
    nAttackCount := Conf.ReadInteger(GateClass, 'AttackCount', nAttackCount);
    nMaxConnOfIPaddr := Conf.ReadInteger(GateClass, 'MaxConnOfIPaddr', nMaxConnOfIPaddr);
    BlockMethod := TBlockIPMethod(Conf.ReadInteger(GateClass, 'BlockMethod', Integer(BlockMethod)));

    nMaxClientPacketSize := Conf.ReadInteger(GateClass, 'MaxClientPacketSize', nMaxClientPacketSize);
    nNomClientPacketSize := Conf.ReadInteger(GateClass, 'NomClientPacketSize', nNomClientPacketSize);
    nMaxClientMsgCount := Conf.ReadInteger(GateClass, 'MaxClientMsgCount', nMaxClientMsgCount);
    bokickOverPacketSize := Conf.ReadBool(GateClass, 'kickOverPacket', bokickOverPacketSize);

    dwCheckServerTimeOutTime := Conf.ReadInteger(GateClass, 'ServerCheckTimeOut', dwCheckServerTimeOutTime);
    nClientSendBlockSize := Conf.ReadInteger(GateClass, 'ClientSendBlockSize', nClientSendBlockSize);
    dwClientTimeOutTime := Conf.ReadInteger(GateClass, 'ClientTimeOutTime', dwClientTimeOutTime);
    //dwSessionTimeOutTime := Conf.ReadInteger(GateClass, 'SessionTimeOutTime', dwSessionTimeOutTime); 注释掉 1个小时无动作 掉线处理  20080813
    nSayMsgMaxLen := Conf.ReadInteger(GateClass, 'SayMsgMaxLen', nSayMsgMaxLen);
    dwSayMsgTime := Conf.ReadInteger(GateClass, 'SayMsgTime', dwSayMsgTime);

    boStartMsgFilterCheck := Conf.ReadBool(SpeedCheckClass, 'StartMsgFilterCheck', boStartMsgFilterCheck);//是否开启文字过滤
    nMsgFilterType := Conf.ReadInteger(SpeedCheckClass, 'MsgFilterType', nMsgFilterType);//文字处理的类型
    sMsgFilterWarningMsg:= Conf.ReadString(SpeedCheckClass, 'MsgFilterWarningMsg', sMsgFilterWarningMsg);
    //反外挂配置 20081225
    boStartHookCheck := Conf.ReadBool(SpeedCheckClass, 'CheckSpeed', boStartHookCheck);
    boStartWalkCheck := Conf.ReadBool(SpeedCheckClass, 'CtrlWalkSpeed', boStartWalkCheck);
    boStartHitCheck := Conf.ReadBool(SpeedCheckClass, 'CtrlHitSpeed', boStartHitCheck);
    boStartRunCheck := Conf.ReadBool(SpeedCheckClass, 'CtrlRunSpeed', boStartRunCheck);
    boStartSpellCheck := Conf.ReadBool(SpeedCheckClass, 'CtrlSpellSpeed', boStartSpellCheck);
    boStartWarning := Conf.ReadBool(SpeedCheckClass, 'SpeedHackWarning', boStartWarning);
    boStartEatCheck := Conf.ReadBool(SpeedCheckClass, 'CheckEat', boStartEatCheck);
    boStartOtherCheck := Conf.ReadBool(SpeedCheckClass, 'CheckOther', boStartOtherCheck);
    boStartPickUpCheck := Conf.ReadBool(SpeedCheckClass, 'CheckPickUp', boStartPickUpCheck);//是否开启捡物品控制
    boStartButchCheck := Conf.ReadBool(SpeedCheckClass, 'CheckButch', boStartButchCheck);//是否开启挖肉控制
    boStartTurnCheck := Conf.ReadBool(SpeedCheckClass, 'CheckTurn', boStartTurnCheck);//是否开启转身控制
    nIncErrorCount := Conf.ReadInteger(SpeedCheckClass, 'IncErrorCount', nIncErrorCount);
    nDecErrorCount := Conf.ReadInteger(SpeedCheckClass, 'DecErrorCount', nDecErrorCount);
    sErrMsg := Conf.ReadString(SpeedCheckClass, 'WarningMsg', sErrMsg);
    dwHitTime := Conf.ReadInteger(SpeedCheckClass, 'HitTime', dwHitTime);
    dwWalkTime := Conf.ReadInteger(SpeedCheckClass, 'WalkTime', dwWalkTime);
    dwRunTime := Conf.ReadInteger(SpeedCheckClass, 'RunTime', dwRunTime);
    dwEatTime := Conf.ReadInteger(SpeedCheckClass, 'EatTime', dwEatTime);//吃药间隔时间
    dwPickUpTime := Conf.ReadInteger(SpeedCheckClass, 'PickUpTime', dwPickUpTime);//捡物品间隔时间
    dwButchTime := Conf.ReadInteger(SpeedCheckClass, 'ButchTime', dwButchTime);//是否开启挖肉控制
    dwTurnTime := Conf.ReadInteger(SpeedCheckClass, 'TurnTime', dwTurnTime);//是否开启转身控制
    dwItemSpeed := Conf.ReadInteger(SpeedCheckClass, 'ItemSpeed', dwItemSpeed); //装备加速因数
    btPunishType := Conf.ReadInteger(SpeedCheckClass, 'SpeedHackPunishTpye', btPunishType); //处理类型
    btWarningMsgType := Conf.ReadInteger(SpeedCheckClass, 'SpeedHackPunishWarningTpye', btWarningMsgType); //处理警告类型
    btWarningMsgFColor := Conf.ReadInteger(SpeedCheckClass, 'WarnMsgFColor', btWarningMsgFColor); //警告前景色
    btWarningMsgBColor := Conf.ReadInteger(SpeedCheckClass, 'WarnMsgBColor', btWarningMsgBColor); //警告背景色
    IsNum('123');
    //技能读取
    dwSKILL_1 := Conf.ReadInteger(SpeedCheckClass, '火球术', dwSKILL_1); //火球术
    dwSKILL_2 := Conf.ReadInteger(SpeedCheckClass, '治愈术', dwSKILL_2); //治愈术
    dwSKILL_5 := Conf.ReadInteger(SpeedCheckClass, '大火球', dwSKILL_5); //大火球
    dwSKILL_6 := Conf.ReadInteger(SpeedCheckClass, '施毒术', dwSKILL_6); //施毒术
    dwSKILL_8 := Conf.ReadInteger(SpeedCheckClass, '抗拒火环', dwSKILL_8); //抗拒火环
    dwSKILL_9 := Conf.ReadInteger(SpeedCheckClass, '地狱火', dwSKILL_9); //地狱火
    dwSKILL_10 := Conf.ReadInteger(SpeedCheckClass, '疾光电影', dwSKILL_10); //疾光电影
    dwSKILL_11 := Conf.ReadInteger(SpeedCheckClass, '雷电术', dwSKILL_11); //雷电术
    dwSKILL_13 := Conf.ReadInteger(SpeedCheckClass, '灵魂火符', dwSKILL_13); //灵魂火符
    dwSKILL_14 := Conf.ReadInteger(SpeedCheckClass, '幽灵盾', dwSKILL_14); //幽灵盾
    dwSKILL_15 := Conf.ReadInteger(SpeedCheckClass, '神圣战甲术', dwSKILL_15); //神圣战甲术
    dwSKILL_16 := Conf.ReadInteger(SpeedCheckClass, '困魔咒', dwSKILL_16); //困魔咒
    dwSKILL_17 := Conf.ReadInteger(SpeedCheckClass, '召唤骷髅', dwSKILL_17); //召唤骷髅
    dwSKILL_18 := Conf.ReadInteger(SpeedCheckClass, '隐身术', dwSKILL_18); //隐身术
    dwSKILL_19 := Conf.ReadInteger(SpeedCheckClass, '集体隐身术', dwSKILL_19); //集体隐身术
    dwSKILL_20 := Conf.ReadInteger(SpeedCheckClass, '诱惑之光', dwSKILL_20); //诱惑之光
    dwSKILL_21 := Conf.ReadInteger(SpeedCheckClass, '瞬息移动', dwSKILL_21); //瞬息移动
    dwSKILL_22 := Conf.ReadInteger(SpeedCheckClass, '火墙', dwSKILL_22); //火墙
    dwSKILL_23 := Conf.ReadInteger(SpeedCheckClass, '爆裂火焰', dwSKILL_23); //爆裂火焰
    dwSKILL_24 := Conf.ReadInteger(SpeedCheckClass, '地狱雷光', dwSKILL_24); //地狱雷光
    dwSKILL_27 := Conf.ReadInteger(SpeedCheckClass, '野蛮冲撞', dwSKILL_27); //野蛮冲撞
    dwSKILL_28 := Conf.ReadInteger(SpeedCheckClass, '心灵启示', dwSKILL_28); //心灵启示
    dwSKILL_29 := Conf.ReadInteger(SpeedCheckClass, '群体治疗术', dwSKILL_29); //群体治疗术
    dwSKILL_30 := Conf.ReadInteger(SpeedCheckClass, '召唤神兽', dwSKILL_30); //召唤神兽
    dwSKILL_32 := Conf.ReadInteger(SpeedCheckClass, '圣言术', dwSKILL_32); //圣言术
    dwSKILL_33 := Conf.ReadInteger(SpeedCheckClass, '冰咆哮', dwSKILL_33); //冰咆哮
    dwSKILL_34 := Conf.ReadInteger(SpeedCheckClass, '解毒术', dwSKILL_34); //解毒术
    dwSKILL_35 := Conf.ReadInteger(SpeedCheckClass, '狮吼功', dwSKILL_35); //狮吼功
    dwSKILL_36 := Conf.ReadInteger(SpeedCheckClass, '火焰冰', dwSKILL_36); //火焰冰
    dwSKILL_37 := Conf.ReadInteger(SpeedCheckClass, '群体雷电术', dwSKILL_37); //群体雷电术
    dwSKILL_38 := Conf.ReadInteger(SpeedCheckClass, '群体施毒术', dwSKILL_38); //群体施毒术
    dwSKILL_39 := Conf.ReadInteger(SpeedCheckClass, '彻地钉', dwSKILL_39); //彻地钉
    dwSKILL_41 := Conf.ReadInteger(SpeedCheckClass, '狮子吼', dwSKILL_41); //狮子吼
    dwSKILL_44 := Conf.ReadInteger(SpeedCheckClass, '寒冰掌', dwSKILL_44); //寒冰掌
    dwSKILL_45 := Conf.ReadInteger(SpeedCheckClass, '灭天火', dwSKILL_45); //灭天火
    dwSKILL_46 := Conf.ReadInteger(SpeedCheckClass, '分身术', dwSKILL_46); //分身术
    dwSKILL_47 := Conf.ReadInteger(SpeedCheckClass, '火龙焰', dwSKILL_47); //火龙焰
    dwSKILL_48 := Conf.ReadInteger(SpeedCheckClass, '气功波', dwSKILL_48); //气功波
    dwSKILL_49 := Conf.ReadInteger(SpeedCheckClass, '净化术', dwSKILL_49); //净化术
    dwSKILL_50 := Conf.ReadInteger(SpeedCheckClass, '无极真气', dwSKILL_50); //无极真气
    dwSKILL_51 := Conf.ReadInteger(SpeedCheckClass, '飓风破', dwSKILL_51); //飓风破
    dwSKILL_52 := Conf.ReadInteger(SpeedCheckClass, '诅咒术', dwSKILL_52); //诅咒术
    dwSKILL_53 := Conf.ReadInteger(SpeedCheckClass, '血咒', dwSKILL_53); //血咒
    dwSKILL_54 := Conf.ReadInteger(SpeedCheckClass, '骷髅咒', dwSKILL_54); //骷髅咒
    dwSKILL_55 := Conf.ReadInteger(SpeedCheckClass, '擒龙手', dwSKILL_55); //擒龙手
    dwSKILL_56 := Conf.ReadInteger(SpeedCheckClass, '乾坤大挪移', dwSKILL_56); //乾坤大挪移
    dwSKILL_57 := Conf.ReadInteger(SpeedCheckClass, '复活术', dwSKILL_57); //复活术
    dwSKILL_58 := Conf.ReadInteger(SpeedCheckClass, '流星火雨', dwSKILL_58); //流星火雨
    dwSKILL_59 := Conf.ReadInteger(SpeedCheckClass, '噬血术', dwSKILL_59); //噬血术
    dwSKILL_71 := Conf.ReadInteger(SpeedCheckClass, '召唤圣兽', dwSKILL_71); //召唤圣兽
    dwSKILL_72 := Conf.ReadInteger(SpeedCheckClass, '召唤月灵', dwSKILL_72); //召唤月灵
  end;
  AddMainLogMsg('配置信息加载完成...', 3);
  IsNum('123');
  LoadAbuseFile();
  IsNum('123');
  LoadBlockIPFile();
 {$IFEND}
end;

procedure TFrmMain.ServerSocketClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  nSockIdx: Integer;
  sRemoteAddress: string;
  UserSession: pTSessionInfo;
begin
  Socket.nIndex := -1;
  sRemoteAddress := Socket.RemoteAddress;
  if boGateReady then begin//网关就绪
    if IsBlockIP(sRemoteAddress) then begin
      AddMainLogMsg('过滤连接: ' + sRemoteAddress, 1);
      Socket.Close;
      Exit;
    end;

    if IsConnLimited(sRemoteAddress) then begin
      case BlockMethod of
        mDisconnect: begin
            Socket.Close;
          end;
        mBlock: begin
            AddTempBlockIP(sRemoteAddress, SearchIPLocal(sRemoteAddress));
            CloseConnect(sRemoteAddress);
          end;
        mBlockList: begin
            AddBlockIP(sRemoteAddress, SearchIPLocal(sRemoteAddress));
            CloseConnect(sRemoteAddress);
          end;
      end;
      AddMainLogMsg('端口攻击: ' + sRemoteAddress, 1);
      Exit;
    end;

    try
      for nSockIdx := 0 to GATEMAXSESSION - 1 do begin
        UserSession := @SessionArray[nSockIdx];
        if UserSession.Socket = nil then begin
          UserSession.Socket := Socket;
          UserSession.sSocData := '';
          UserSession.sSendData := '';
          UserSession.nUserListIndex := 0;
          UserSession.nPacketIdx := -1;
          UserSession.nPacketErrCount := 0;
          UserSession.boStartLogon := True;//第一次登陆
          //UserSession.boSendLock := False;
          //UserSession.dwSendLatestTime := GetTickCount();
          UserSession.boSendAvailable := True;
          UserSession.boSendCheck := False;
          UserSession.nCheckSendLength := 0;
          UserSession.nReceiveLength := 0;
          UserSession.dwReceiveTick := GetTickCount();
          UserSession.nSckHandle := Socket.SocketHandle;
          UserSession.sRemoteAddr := sRemoteAddress;
          //UserSession.boOverNomSize := False;
          //UserSession.nOverNomSizeCount := 0;
          UserSession.dwSayMsgTick := GetTickCount();
          UserSession.nReceiveLength := 0;
          UserSession.dwConnectTick := GetTickCount();//连接网关的时间
          UserSession.nSessionID := 0;//会话ID 20090208
          Socket.nIndex := nSockIdx;
          Inc(SessionCount);
          break;
        end;
      end;
    finally

    end;
    if nSockIdx < GATEMAXSESSION then begin
      SendServerMsg(GM_OPEN, nSockIdx, Socket.SocketHandle, 0, Length(Socket.RemoteAddress) + 1, PChar(Socket.RemoteAddress));//发送给M2，通知有人开始连接
      Socket.nIndex := nSockIdx;
      AddMainLogMsg('开始连接: ' + sRemoteAddress, 5);
    end else begin
      Socket.nIndex := -1;
      Socket.Close;
      AddMainLogMsg('禁止连接A: ' + sRemoteAddress, 1);
    end;
  end else begin
    Socket.nIndex := -1;
    Socket.Close;
    AddMainLogMsg('禁止连接B: ' + sRemoteAddress, 1);
  end;
end;

procedure TFrmMain.ServerSocketClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  i, nIPaddr, nSockIndex: Integer;
  sRemoteAddr: string;
  UserSession: pTSessionInfo;
  IPList: TList;
begin
  sRemoteAddr := Socket.RemoteAddress;
  nSockIndex := Socket.nIndex;

  nIPaddr := inet_addr(PChar(sRemoteAddr));
  CurrIPaddrList.Lock;
  try
    for i := CurrIPaddrList.Count - 1 downto 0 do begin
      IPList := TList(CurrIPaddrList.Items[i]);
      if IPList <> nil then begin
        if pTSockaddr(IPList.Items[0]) <> nil then begin
          if pTSockaddr(IPList.Items[0]).nIPaddr = nIPaddr then begin
            Dispose(pTSockaddr(IPList.Items[0]));
            IPList.Delete(0);
            if IPList.Count <= 0 then begin
              IPList.Free;
              CurrIPaddrList.Delete(i);
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
    UserSession := @SessionArray[nSockIndex];
    UserSession.Socket := nil;
    UserSession.nSckHandle := -1;
    UserSession.sSocData := '';
    UserSession.sSendData := '';
    Socket.nIndex := -1;
    Dec(SessionCount);
    if boGateReady then begin
      SendServerMsg(GM_CLOSE, 0, Socket.SocketHandle, 0, 0, nil);
      AddMainLogMsg('断开连接: ' + Socket.RemoteAddress, 5);
    end;
  end;
end;

//读取客户端传来的消息包
procedure TFrmMain.ServerSocketClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
  dwProcessMsgTick, dwProcessMsgTime: LongWord;
  nPos, nReviceLen, nSocketIndex, nMsgCount: Integer;
  sRemoteAddress, sReviceMsg: string;
  UserData: pTSendUserData;
  UserSession: pTSessionInfo;
begin
  try
    dwProcessMsgTick := GetTickCount();
    //nReviceLen:=Socket.ReceiveLength;
    sRemoteAddress := Socket.RemoteAddress;
    nSocketIndex := Socket.nIndex;
    sReviceMsg := Socket.ReceiveText;
    nReviceLen := Length(sReviceMsg);
    if (nSocketIndex >= 0) and (nSocketIndex < GATEMAXSESSION) and (sReviceMsg <> '') and boServerReady then begin
      if nReviceLen > nNomClientPacketSize then begin
        nMsgCount := TagCount(sReviceMsg, '!');
        if (nMsgCount > nMaxClientMsgCount) or (nReviceLen > nMaxClientPacketSize) then begin
          if bokickOverPacketSize then begin
            case BlockMethod of
              mDisconnect: begin

                end;
              mBlock: begin
                  AddTempBlockIP(sRemoteAddress, SearchIPLocal(sRemoteAddress));
                  CloseConnect(sRemoteAddress);
                end;
              mBlockList: begin
                  AddBlockIP(sRemoteAddress, SearchIPLocal(sRemoteAddress));
                  CloseConnect(sRemoteAddress);
                end;
            end;
            AddMainLogMsg('踢除连接: IP(' + sRemoteAddress + '),信息数量(' + IntToStr(nMsgCount) + '),数据包长度(' + IntToStr(nReviceLen) + ')', 1);
            Socket.Close;
          end;
          Exit;
        end;
      end;
      Inc(nReviceMsgSize, Length(sReviceMsg));
      if CheckBoxShowData.Checked then AddMainLogMsg(sReviceMsg, 0);//显示封包
      UserSession := @SessionArray[nSocketIndex];
      if UserSession.Socket = Socket then begin
        UserSession.nReceiveLength := nReviceLen;
        nPos := Pos('*', sReviceMsg);
        if nPos > 0 then begin
          UserSession.boSendAvailable := True;
          UserSession.boSendCheck := False;
          UserSession.nCheckSendLength := 0;
          UserSession.dwReceiveTick := GetTickCount();
          sReviceMsg := Copy(sReviceMsg, 1, nPos - 1) + Copy(sReviceMsg, nPos + 1, Length(sReviceMsg));
        end; //00456DD0
        if (sReviceMsg <> '') and boGateReady and not boCheckServerFail then begin
          New(UserData);
          UserData.nSocketIdx := nSocketIndex;
          UserData.nSocketHandle := Socket.SocketHandle;
          UserData.sMsg := sReviceMsg;
          ReviceMsgList.Add(UserData);
        end; //00456E2A
      end;
    end;
    dwProcessMsgTime := GetTickCount - dwProcessMsgTick;
    if dwProcessMsgTime > dwProcessClientMsgTime then dwProcessClientMsgTime := dwProcessMsgTime;
  except
    AddMainLogMsg('[异常] ClientRead', 1);
  end;
end;



procedure TFrmMain.SendTimerTimer(Sender: TObject);
var
  i: Integer;  //注释掉 1个小时无动作 掉线处理  20080813
  UserSession: pTSessionInfo;
const
  sMsg = '%d/%d';
begin
  if (GetTickCount - dwSendHoldTick) > 3000 then begin
    boSendHoldTimeOut := False;
  end; //457195
  { 注释掉 1个小时无动作 掉线处理  20080813
  if boGateReady and not boCheckServerFail then begin
    for i := 0 to GATEMAXSESSION - 1 do begin
      UserSession := @SessionArray[i];
      if UserSession.Socket <> nil then begin
        if (GetTickCount - UserSession.dwReceiveTick) > dwSessionTimeOutTime then begin
          UserSession.Socket.Close;
          UserSession.Socket := nil;
          UserSession.nSckHandle := -1;
        end;
      end;
    end;
  end; //0045722F }

  if boGateReady and not boCheckServerFail then begin//如果连接成功5秒后，没有会话ID的连接，则断开 20090208
    for I := 0 to GATEMAXSESSION - 1 do begin
      UserSession := @SessionArray[i];
      if UserSession.Socket <> nil then begin
        if ((GetTickCount - UserSession.dwConnectTick) > dwClientTimeOutTime{5000}) and (UserSession.nSessionID = 0) then begin
          IsConnLimited(UserSession.Socket.RemoteAddress);
          UserSession.Socket.Close;
          UserSession.Socket := nil;
          UserSession.nSckHandle := -1;
        end;
      end;
    end;
  end;

  if not boGateReady then begin
    POPMENU_CHECKTICK.Caption := '????';
    if ((GetTickCount - dwReConnectServerTime) > 1000 {30 * 1000}) and boServiceStart then begin
      dwReConnectServerTime := GetTickCount();
      ClientSocket.Active := False;
      ClientSocket.Address := ServerAddr;
      ClientSocket.Port := ServerPort;
      ClientSocket.Active := True;
    end;
  end else begin //00457302
    if boCheckServerFail then begin
      Inc(nCheckServerFail);
      LabelMsg.Caption := Format(sMsg, [nCheckServerFail, 1]);
    end else begin //00457320
      LabelMsg.Caption := Format(sMsg, [nCheckServerFail, 0]);
    end;
    dwCheckServerTimeMin := GetTickCount - dwCheckServerTick;
    if dwCheckServerTimeMax < dwCheckServerTimeMin then dwCheckServerTimeMax := dwCheckServerTimeMin;
    LabelCheckServerTime.Caption := Format(sMsg, [dwCheckServerTimeMin, dwCheckServerTimeMax]);
    POPMENU_CHECKTICK.Caption := IntToStr(dwCheckServerTimeMin) + '/' + IntToStr(dwCheckServerTimeMax);
  end;
end;

procedure TFrmMain.ClientSocketConnect(Sender: TObject;
  Socket: TCustomWinSocket);
//00454C08
begin
  boGateReady := True;
  dwCheckServerTick := GetTickCount();
  dwCheckRecviceTick := GetTickCount();
  RestSessionArray();
  boServerReady := True;
  dwCheckServerTimeMax := 0;
  dwCheckServerTimeMax := 0;
  AddMainLogMsg('连接成功 ' + Socket.RemoteAddress + ':' + IntToStr(Socket.RemotePort), 1);
end;

procedure TFrmMain.ClientSocketDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  i: Integer;
  UserSession: pTSessionInfo;
begin
  for i := 0 to GATEMAXSESSION - 1 do begin
    UserSession := @SessionArray[i];
    if UserSession.Socket <> nil then begin
      UserSession.Socket.Close;
      UserSession.Socket := nil;
      UserSession.nSckHandle := -1;
    end;
  end;
  RestSessionArray();
  if SocketBuffer <> nil then begin
    FreeMem(SocketBuffer);
  end;
  SocketBuffer := nil;

  boGateReady := False;
  boServerReady := False;
end;

procedure TFrmMain.ClientSocketRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
  dwTime10, dwTick14: LongWord;
  nMsgLen: Integer;
  tBuffer: PChar;
begin
  try
    dwTick14 := GetTickCount();
    nMsgLen := Socket.ReceiveLength;
    GetMem(tBuffer, nMsgLen);
    Socket.ReceiveBuf(tBuffer^, nMsgLen);
    ProcReceiveBuffer(tBuffer, nMsgLen);
    Inc(nBufferOfM2Size, nMsgLen);
    dwTime10 := GetTickCount - dwTick14;
    if dwProcessServerMsgTime < dwTime10 then dwProcessServerMsgTime := dwTime10;
  except
    on E: Exception do begin
      AddMainLogMsg('[异常] ClientSocketRead', 1);
    end;
  end;
end;

//接收M2的数据
procedure TFrmMain.ProcReceiveBuffer(tBuffer: PChar; nMsgLen: Integer);
var
  nLen: Integer;
  TempBuff, Buff, MsgBuff: PChar;
  pMsg: pTMsgHeader;
begin
  try
    ReallocMem(SocketBuffer, nBuffLen + nMsgLen);
    Move(tBuffer^, SocketBuffer[nBuffLen], nMsgLen);
    FreeMem(tBuffer);
    nLen := nBuffLen + nMsgLen;
    Buff := SocketBuffer;
    if nLen >= SizeOf(TMsgHeader) then begin
      while (True) do begin
        pMsg := pTMsgHeader(Buff);
        if pMsg.dwCode = RUNGATECODE then begin
          if (abs(pMsg.nLength) + SizeOf(TMsgHeader)) > nLen then break; // -> 0045525C
          MsgBuff := Ptr(LongInt(Buff) + SizeOf(TMsgHeader));
          case pMsg.wIdent of
            GM_CHECKSERVER: begin//M2返回的检测包
                boCheckServerFail := False;
                dwCheckServerTick := GetTickCount();
              end;
            GM_SERVERUSERINDEX: begin
                if (pMsg.wGSocketIdx < GATEMAXSESSION) and (pMsg.nSocket = SessionArray[pMsg.wGSocketIdx].nSckHandle) then begin
                  SessionArray[pMsg.wGSocketIdx].nUserListIndex := pMsg.wUserListIndex;
                end; //00455218
              end;
            GM_RECEIVE_OK: begin
                dwCheckServerTimeMin := GetTickCount - dwCheckRecviceTick;
                if dwCheckServerTimeMin > dwCheckServerTimeMax then dwCheckServerTimeMax := dwCheckServerTimeMin;
                dwCheckRecviceTick := GetTickCount();
                SendServerMsg(GM_RECEIVE_OK, 0, 0, 0, 0, nil);
              end;
            GM_DATA: begin
                ProcessMakeSocketStr(pMsg.nSocket, pMsg.wGSocketIdx, MsgBuff, pMsg.nLength);
              end;
            GM_TEST: begin

              end;
            {GM_KickConn: begin //20081222 接M2消息，把对应的连接T下线  20090210注释
                //AddMainLogMsg('A...'+inttostr(pMsg.nSocket)+'  '+inttostr(SessionArray[pMsg.wGSocketIdx].nSckHandle),1);
                if (pMsg.wGSocketIdx < GATEMAXSESSION) and (pMsg.nSocket = SessionArray[pMsg.wGSocketIdx].nSckHandle) then begin
                  if SessionArray[pMsg.wGSocketIdx].Socket <> nil then begin
                    SessionArray[pMsg.wGSocketIdx].Socket.Close;
                    SessionArray[pMsg.wGSocketIdx].Socket := nil;
                    SessionArray[pMsg.wGSocketIdx].nSckHandle := -1;
                  end;
                end;
              end;}
          end;
          Buff := @Buff[SizeOf(TMsgHeader) + abs(pMsg.nLength)];
          //Buff:=Ptr(LongInt(Buff) + (abs(pMsg.nLength) + SizeOf(TMsgHeader)));
          nLen := nLen - (abs(pMsg.nLength) + SizeOf(TMsgHeader));
        end else begin //00455242
          Inc(Buff);
          Dec(nLen);
        end;
        if nLen < SizeOf(TMsgHeader) then break;
      end;
    end; //0045525C

    if nLen > 0 then begin
      GetMem(TempBuff, nLen);
      Move(Buff^, TempBuff^, nLen);
      FreeMem(SocketBuffer);
      SocketBuffer := TempBuff;
      nBuffLen := nLen;
    end else begin //00455297
      FreeMem(SocketBuffer);
      SocketBuffer := nil;
      nBuffLen := 0;
    end;
  except
    on E: Exception do begin
      AddMainLogMsg('[异常] ProcReceiveBuffer', 1);
    end;
  end;
end;

procedure TFrmMain.ProcessMakeSocketStr(nSocket, nSocketIndex: Integer; Buffer: PChar; nMsgLen: Integer);
var
  sSendMsg: string;
  pDefMsg: pTDefaultMessage;
  //UserData: pTSendUserData;
  UserSession:pTSessionInfo;
begin
  try
    sSendMsg := '';
    if nMsgLen < 0 then begin
      sSendMsg := '#' + string(Buffer) + '!';
    end else begin //00455D18
      if (nMsgLen >= SizeOf(TDefaultMessage)) then begin
        pDefMsg := pTDefaultMessage(Buffer);
        if nMsgLen > SizeOf(TDefaultMessage) then begin
          sSendMsg := '#' + EncodeMessage(pDefMsg^) + string(PChar(@Buffer[SizeOf(TDefaultMessage)])) + '!';
        end else begin //00455D62
          sSendMsg := '#' + EncodeMessage(pDefMsg^) + '!';
        end;
      end; //00455D87
    end;
    if (nSocketIndex >= 0) and (nSocketIndex < GATEMAXSESSION) and (sSendMsg <> '') then begin
      UserSession:=@SessionArray[nSocketIndex];
      if (UserSession.nSckHandle = nSocket) and
         (UserSession.Socket <> nil) and
         (UserSession.Socket.Connected)  then begin
        UserSession.sSendData:=UserSession.sSendData + sSendMsg;
      end;
      {New(UserData);
      UserData.nSocketIdx := nSocketIndex;
      UserData.nSocketHandle := nSocket;
      UserData.sMsg := sSendMsg;
      SendMsgList.Add(UserData);   }
    end;
  except
    on E: Exception do begin
      AddMainLogMsg('[异常] ProcessMakeSocketStr', 1);
    end;
  end;
end;

procedure TFrmMain.MENU_CONTROL_CLEAELOGClick(Sender: TObject);
begin
  if Application.MessageBox('是否确认清除显示的日志信息？',
    '确认信息',
    MB_OKCANCEL + MB_ICONQUESTION
    ) <> IDOK then Exit;
  MemoLog.Clear;
end;

procedure TFrmMain.MENU_CONTROL_RECONNECTClick(Sender: TObject);
begin
  dwReConnectServerTime := 0;
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
    ComboBoxShowBite.ItemIndex := Integer(boShowBite);
  end;
  frmGeneralConfig.ShowModal;
end;

procedure TFrmMain.MENU_OPTION_FILTERMSGClick(Sender: TObject);
var
  i: Integer;
begin
  with frmMessageFilterConfig do begin
    Top := Self.Top + 20;
    Left := Self.Left;
    ListBoxFilterText.Clear;
    try
      CS_FilterMsg.Enter;
      for i := 0 to AbuseList.Count - 1 do begin
        ListBoxFilterText.Items.Add(AbuseList.Strings[i]);
      end;
    finally
      CS_FilterMsg.Leave;
    end;

    MsgFilterWarningMsgEdt.Text := sMsgFilterWarningMsg;
    StartMsgFilterCheck.Checked := boStartMsgFilterCheck;
    if boStartMsgFilterCheck then begin
      rbMsgFilterType0.Enabled:= True;
      rbMsgFilterType1.Enabled:= True;
      rbMsgFilterType2.Enabled:= True;
      rbMsgFilterType3.Enabled:= True;
    end else begin
      rbMsgFilterType0.Enabled:= False;
      rbMsgFilterType1.Enabled:= False;
      rbMsgFilterType2.Enabled:= False;
      rbMsgFilterType3.Enabled:= False;
    end;
    case nMsgFilterType of
      0: rbMsgFilterType0.Checked:= True;
      1: rbMsgFilterType1.Checked:= True;
      2: rbMsgFilterType2.Checked:= True;
      3: rbMsgFilterType3.Checked:= True;
    end;
    ButtonDel.Enabled := False;
    ButtonMod.Enabled := False;
    ShowModal;
  end;
end;

function TFrmMain.IsBlockIP(sIPaddr: string): Boolean;
var
  nIPaddr,i: Integer;
  IPaddr: pTSockaddr;
begin
  Result := False;
  TempBlockIPList.Lock;
  try
    nIPaddr := inet_addr(PChar(sIPaddr));
    for i := 0 to TempBlockIPList.Count - 1 do begin
      IPaddr := pTSockaddr(TempBlockIPList.Items[i]);
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
      for i := 0 to BlockIPList.Count - 1 do begin
        IPaddr := pTSockaddr(BlockIPList.Items[i]);
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

function TFrmMain.AddBlockIP(sIPaddr,sIPDate: string): Integer;
var
  nIPaddr,i: Integer;
  IPaddr: pTSockaddr;
begin
  BlockIPList.Lock;
  try
    Result := 0;
    nIPaddr := inet_addr(PChar(sIPaddr));
    for i := 0 to BlockIPList.Count - 1 do begin
      IPaddr := pTSockaddr(BlockIPList.Items[i]);
      if IPaddr.nIPaddr = nIPaddr then begin
        Result := BlockIPList.Count;
        break;
      end;
    end;
    if Result <= 0 then begin
      New(IPaddr);
      IPaddr^.nIPaddr := nIPaddr;
      IPaddr^.sIPDate := sIPDate;//20080414
      BlockIPList.Add(IPaddr);
      Result := BlockIPList.Count;
    end;
  finally
    BlockIPList.UnLock;
  end;
end;
//增加动态过滤IP
function TFrmMain.AddTempBlockIP(sIPaddr,sIPDate: string): Integer;
var
  nIPaddr,i: Integer;
  IPaddr: pTSockaddr;
begin
  TempBlockIPList.Lock;
  try
    Result := 0;
    nIPaddr := inet_addr(PChar(sIPaddr));
    for i := 0 to TempBlockIPList.Count - 1 do begin
      IPaddr := pTSockaddr(TempBlockIPList.Items[i]);
      if IPaddr.nIPaddr = nIPaddr then begin
        Result := TempBlockIPList.Count;
        break;
      end;
    end;
    if Result <= 0 then begin
      New(IPaddr);
      IPaddr^.nIPaddr := nIPaddr;
      IPaddr^.sIPDate := sIPDate;//20080414
      TempBlockIPList.Add(IPaddr);
      Result := TempBlockIPList.Count;
    end;
  finally
    TempBlockIPList.UnLock;
  end;
end;
//增加攻击IP
function TFrmMain.AddAttackIP(sIPaddr: string): Boolean;
var
  nIPaddr, i: Integer;
  IPaddr, AddIPaddr: pTSockaddr;
  bo01: Boolean;
begin
  AttackIPaddrList.Lock;
  try
    Result := False;
    bo01 := False;
    nIPaddr := inet_addr(PChar(sIPaddr));
    for i := AttackIPaddrList.Count - 1 downto 0 do begin
      IPaddr := pTSockaddr(AttackIPaddrList.Items[i]);
      if IPaddr.nIPaddr = nIPaddr then begin
        if (GetTickCount - IPaddr.dwStartAttackTick) <= dwAttackTick then begin
          IPaddr.dwStartAttackTick := GetTickCount;
          Inc(IPaddr.nAttackCount);
          //MainOutMessage('IPaddr.nAttackCount: '+IntToStr(IPaddr.nAttackCount), 0);
          if IPaddr.nAttackCount >= nAttackCount then begin
            Dispose(IPaddr);
            AttackIPaddrList.Delete(i);
            Result := True;
          end;
        end else begin
          if IPaddr.nAttackCount > nAttackCount then begin
            Result := True;
          end;
          Dispose(IPaddr);
          AttackIPaddrList.Delete(i);
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
  finally
    AttackIPaddrList.UnLock;
  end;
end;

function TFrmMain.GetAttackIPCount(sIPaddr: string): Integer;
var
  nIPaddr, i: Integer;
  IPaddr{, AddIPaddr}: pTSockaddr;
begin
  AttackIPaddrList.Lock;
  try
    Result := 0;
    nIPaddr := inet_addr(PChar(sIPaddr));
    for i := AttackIPaddrList.Count - 1 downto 0 do begin
      IPaddr := pTSockaddr(AttackIPaddrList.Items[i]);
      if IPaddr.nIPaddr = nIPaddr then begin
        Result := IPaddr.nAttackCount;
      end;
    end;
  finally
    AttackIPaddrList.UnLock;
  end;
end;

function TFrmMain.IsConnLimited(sIPaddr: string): Boolean;
var
  nIPaddr, i: Integer;
  IPaddr, AttackIPaddr: pTSockaddr;
  bo01: Boolean;
  IPList: TList;
begin
  CurrIPaddrList.Lock;
  try
    Result := False;
    bo01 := False;
    nIPaddr := inet_addr(PChar(sIPaddr));
    for i := 0 to CurrIPaddrList.Count - 1 do begin
      IPList := TList(CurrIPaddrList.Items[i]);
      if IPList <> nil then begin
        IPaddr := pTSockaddr(IPList.Items[0]);
        if IPaddr <> nil then begin
          if IPaddr.nIPaddr = nIPaddr then begin
            Result := AddAttackIP(sIPaddr);
            New(AttackIPaddr);
            FillChar(AttackIPaddr^, SizeOf(TSockaddr), 0);
            AttackIPaddr^.nIPaddr := nIPaddr;
            IPList.Add(AttackIPaddr);
            if IPList.Count > nMaxConnOfIPaddr then Result := True;
            bo01 := True;
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
      IPList := TList.Create;
      IPList.Add(IPaddr);
      CurrIPaddrList.Add(IPList);
    end;
  finally
    CurrIPaddrList.UnLock;
  end;
end;


function TFrmMain.GetConnectCountOfIP(sIPaddr: string): Integer;
var
  nIPaddr, i: Integer;
  IPaddr{, AttackIPaddr}: pTSockaddr;
 // bo01: Boolean;
  IPList: TList;
begin
  CurrIPaddrList.Lock;
  try
    Result := 0;
    nIPaddr := inet_addr(PChar(sIPaddr));
    for i := 0 to CurrIPaddrList.Count - 1 do begin
      IPList := TList(CurrIPaddrList.Items[i]);
      if IPList <> nil then begin
        IPaddr := pTSockaddr(IPList.Items[0]);
        if IPaddr <> nil then begin
          if IPaddr.nIPaddr = nIPaddr then begin
            Result := IPList.Count;
            break;
          end;
        end;
      end;
    end;
  finally
    CurrIPaddrList.UnLock;
  end;
end;

procedure TFrmMain.MENU_OPTION_IPFILTERClick(Sender: TObject);
var
  i: Integer;
begin
  frmIPaddrFilter.Top := Self.Top + 20;
  frmIPaddrFilter.Left := Self.Left;
  frmIPaddrFilter.ListBoxTempList.Clear;
  frmIPaddrFilter.ListBoxBlockList.Clear;
  for i := 0 to TempBlockIPList.Count - 1 do begin
    frmIPaddrFilter.ListBoxTempList.Items.Add(StrPas(inet_ntoa(TInAddr(pTSockaddr(TempBlockIPList.Items[i]).nIPaddr)))+'->'+pTSockaddr(TempBlockIPList.Items[i]).sIPDate );
  end;
  for i := 0 to BlockIPList.Count - 1 do begin
    frmIPaddrFilter.ListBoxBlockList.Items.Add(StrPas(inet_ntoa(TInAddr(pTSockaddr(BlockIPList.Items[i]).nIPaddr)))+'->'+pTSockaddr(BlockIPList.Items[i]).sIPDate );
  end;
  frmIPaddrFilter.EditMaxConnect.Value := nMaxConnOfIPaddr;
  case BlockMethod of
    mDisconnect: frmIPaddrFilter.RadioDisConnect.Checked := True;
    mBlock: frmIPaddrFilter.RadioAddTempList.Checked := True;
    mBlockList: frmIPaddrFilter.RadioAddBlockList.Checked := True;
  end;
  frmIPaddrFilter.SpinEditAttackTick.Value := dwAttackTick;
  frmIPaddrFilter.SpinEditAttackCount.Value := nAttackCount;
  frmIPaddrFilter.EditMaxSize.Value := nMaxClientPacketSize;
  frmIPaddrFilter.EditNomSize.Value := nNomClientPacketSize;
  frmIPaddrFilter.EditMaxClientMsgCount.Value := nMaxClientMsgCount;
  frmIPaddrFilter.CheckBoxLostLine.Checked := bokickOverPacketSize;
  frmIPaddrFilter.EditClientTimeOutTime.Value := dwClientTimeOutTime div 1000;
  frmIPaddrFilter.ShowModal;
end;
//断开连接
procedure TFrmMain.CloseConnect(sIPaddr: string);
var
  i: Integer;
  boCheck: Boolean;
begin
  if ServerSocket.Active then
    while (True) do begin
      boCheck := False;
      for i := 0 to ServerSocket.Socket.ActiveConnections - 1 do begin
        if sIPaddr = ServerSocket.Socket.Connections[i].RemoteAddress then begin
          ServerSocket.Socket.Connections[i].Close;
          boCheck := True;
          break;
        end;
      end;
      if not boCheck then break;
    end;
end;

procedure TFrmMain.MENU_OPTION_PERFORMClick(Sender: TObject);
begin
  frmPrefConfig.boShowOK := False;
  frmPrefConfig.Top := Self.Top + 20;
  frmPrefConfig.Left := Self.Left;
  with frmPrefConfig do begin
    EditServerCheckTimeOut.Value := dwCheckServerTimeOutTime div 1000;
    EditSendBlockSize.Value := nClientSendBlockSize;
    {EditGateIPaddr.Text:=GateAddr;
    EditGatePort.Text:=IntToStr(GatePort);
    EditServerIPaddr.Text:=ServerAddr;
    EditServerPort.Text:=IntToStr(ServerPort);
    EditTitle.Text:=TitleName;
    TrackBarLogLevel.Position:=nShowLogLevel;
    ComboBoxShowBite.ItemIndex:=Integer(boShowBite);}
    boShowOK := True;
    ShowModal;
  end;
end;

//检查数据 20081222
function TFrmMain.CheckDefMsg(DefMsg: pTDefaultMessage; SessionInfo: pTSessionInfo;nIdx:Integer; wIdent: Word): Boolean;
var
  sSendMsg: string;
  m_DefMsg: TDefaultMessage;

  function MsgTreat(DefMsg: pTDefaultMessage; SessionInfo: pTSessionInfo; nIdx: Integer):Boolean;
  var
    Buffer: PChar;
  begin
    Result := True;
    //红字提示
    if boStartWarning then begin
      if btWarningMsgType = 0 then
        m_DefMsg := MakeDefaultMsg({SM_WHISPER}103, Integer(SessionInfo.Socket.SocketHandle), MakeWord(btWarningMsgFColor, btWarningMsgBColor), 0, 1, 0)
      else m_DefMsg := MakeDefaultMsg({SM_MENU_OK}767, Integer(SessionInfo.Socket.SocketHandle), 0, 0, 0, 0);
      sSendMsg := '#' + EncodeMessage(m_DefMsg) + string(PChar(EncodeString(sErrMsg))) + '!';
      SessionInfo.Socket.SendText(sSendMsg);
    end;
    if btPunishType = 1 then begin //触发处理
      m_DefMsg := MakeDefaultMsg(aa(20220,SessionInfo.nRandomKey){20220}, 0, 0, 0, 0, DefMsg.nSessionID);//20091026
      GetMem(Buffer, SizeOf(TDefaultMessage));
      Move(m_DefMsg, Buffer^, SizeOf(TDefaultMessage));
      SendServerMsg(GM_DATA, nIdx, SessionInfo.Socket.SocketHandle, SessionInfo.nUserListIndex, SizeOf(TDefaultMessage), Buffer);
      FreeMem(Buffer); // -> 0045636E
      SessionInfo.nErrorCount := 0; //错误清0
    end else begin
      //T下线
      SendServerMsg(GM_CLOSE, 0, SessionInfo.Socket.SocketHandle, 0, 0, nil);//发送给M2，通知T人
      SessionInfo.nSckHandle := -1;
      SessionInfo.sSocData := '';
      SessionInfo.sSendData := '';
      SessionInfo.Socket.nIndex := -1;
      Dec(SessionCount);
      SessionInfo.Socket.Close ;
      SessionInfo.Socket := nil;
      Result := False;
    end;
  end;
begin
  Result := True;
  try
    if (SessionInfo = nil) then begin
      Result := False;
      Exit;
    end;
    if SessionInfo.Socket = nil then begin
      Result := False;
      Exit;
    end;
    case {DefMsg.Ident}wIdent of//消息解密 20091026
      CM_WALK: begin  //走路速度控制
        if boStartWalkCheck then begin
          if CheckBox1.Checked then MemoLog.Lines.Add('走路-间隔:'+IntToStr(GetTickCount - SessionInfo.dwWalkTick)+' 计时:'+inttostr(dwWalkTime));
          if (GetTickCount - SessionInfo.dwWalkTick) < dwWalkTime then begin   //使用加速了
            Inc(SessionInfo.nErrorCount, nIncErrorCount);
            if btPunishType = 0 then begin  //停顿处理
              if SessionInfo.nErrorCount >= 10 then begin
                //红字提示
                if boStartWarning then begin
                  if btWarningMsgType = 0 then
                    m_DefMsg := MakeDefaultMsg({SM_WHISPER}103, Integer(SessionInfo.Socket.SocketHandle), MakeWord(btWarningMsgFColor, btWarningMsgBColor), 0, 1, 0)
                  else m_DefMsg := MakeDefaultMsg({SM_MENU_OK}767, Integer(SessionInfo.Socket.SocketHandle), 0, 0, 0, 0);
                  sSendMsg := '#' + EncodeMessage(m_DefMsg) + string(PChar(EncodeString(sErrMsg))) + '!';
                  SessionInfo.Socket.SendText(sSendMsg);
                end;
                SessionInfo.Socket.SendText('+FAIL/'); //失败
                Result := False;
              end;
            end else begin
              if SessionInfo.nErrorCount >= 50 then Result := MsgTreat(DefMsg,SessionInfo,nIdx);
            end;
          end else begin
            if SessionInfo.nErrorCount > nDecErrorCount then Dec(SessionInfo.nErrorCount, nDecErrorCount);
          end;
          SessionInfo.dwWalkTick:=GetTickCount();
        end;
      end;
      CM_RUN: begin  //跑步速度控制
        if boStartRunCheck then begin
          if CheckBox1.Checked then MemoLog.Lines.Add('跑步-间隔:'+IntToStr(GetTickCount - SessionInfo.dwRunTick)+' 计时:'+inttostr(dwRunTime));
          if (GetTickCount - SessionInfo.dwRunTick) < dwRunTime then begin
            Inc(SessionInfo.nErrorCount, nIncErrorCount);
            if btPunishType = 0 then begin  //停顿处理
              if SessionInfo.nErrorCount >= 10 then begin
                //红字提示
                if boStartWarning then begin
                  if btWarningMsgType = 0 then
                    m_DefMsg := MakeDefaultMsg({SM_WHISPER}103, Integer(SessionInfo.Socket.SocketHandle), MakeWord(btWarningMsgFColor, btWarningMsgBColor), 0, 1, 0)
                  else m_DefMsg := MakeDefaultMsg({SM_MENU_OK}767, Integer(SessionInfo.Socket.SocketHandle), 0, 0, 0, 0);
                  sSendMsg := '#' + EncodeMessage(m_DefMsg) + string(PChar(EncodeString(sErrMsg))) + '!';
                  SessionInfo.Socket.SendText(sSendMsg);
                end;
                SessionInfo.Socket.SendText('+FAIL/'); //失败
                Result := False;
              end;
            end else begin
              if SessionInfo.nErrorCount >= 50 then Result := MsgTreat(DefMsg,SessionInfo,nIdx);
            end;
          end else begin
            if SessionInfo.nErrorCount > nDecErrorCount then Dec(SessionInfo.nErrorCount, nDecErrorCount);
          end;
          SessionInfo.dwRunTick := GetTickCount();
        end;
      end;
      CM_HIT{普通攻击}, CM_HEAVYHIT{跳起攻击}, CM_BIGHIT{}, CM_POWERHIT{攻杀攻击},
      CM_LONGHIT{刺杀攻击}, CM_LONGHITFORFENGHAO{粉红刺杀},CM_LONGHIT4{四级刺杀},
      CM_WIDEHIT{半月攻击}, CM_WIDEHIT4{圆月弯刀}, CM_FIREHITFORFENGHAO{粉红烈火},
      CM_CRSHIT{抱月刀法}, CM_FIREHIT{烈火攻击}, CM_4FIREHIT{四级烈火},
      CM_DAILY{逐日剑法}, CM_DAILYFORFENGHAO{粉红逐日},CM_CIDHIT{龙影剑法},
      CM_TWNHIT{开天斩 重击}, CM_QTWINHIT{开天斩 轻击}, CM_BLOODSOUL{血魄一击(战)}: begin//攻击速度控制
        if boStartHitCheck then begin
          if CheckBox1.Checked then MemoLog.Lines.Add('攻击-间隔:'+IntToStr(GetTickCount - SessionInfo.dwHitTick+dwItemSpeed)+' 计时:'+inttostr(dwHitTime));
          if (GetTickCount - SessionInfo.dwHitTick+dwItemSpeed) < dwHitTime then begin
            Inc(SessionInfo.nErrorCount, nIncErrorCount);
            if btPunishType = 0 then begin  //停顿处理
              if SessionInfo.nErrorCount >= 10 then begin
                //红字提示
                if boStartWarning then begin
                  if btWarningMsgType = 0 then
                    m_DefMsg := MakeDefaultMsg({SM_WHISPER}103, Integer(SessionInfo.Socket.SocketHandle), MakeWord(btWarningMsgFColor, btWarningMsgBColor), 0, 1, 0)
                  else m_DefMsg := MakeDefaultMsg({SM_MENU_OK}767, Integer(SessionInfo.Socket.SocketHandle), 0, 0, 0, 0);
                  sSendMsg := '#' + EncodeMessage(m_DefMsg) + string(PChar(EncodeString(sErrMsg))) + '!';
                  SessionInfo.Socket.SendText(sSendMsg);
                end;
                SessionInfo.Socket.SendText('+FAIL/'); //失败
                Result := False;
              end;
            end else begin
              if SessionInfo.nErrorCount >= 50 then Result := MsgTreat(DefMsg,SessionInfo,nIdx);
            end;
          end else begin
            if SessionInfo.nErrorCount > nDecErrorCount then Dec(SessionInfo.nErrorCount, nDecErrorCount);
          end;
          SessionInfo.dwHitTick:= GetTickCount();
        end;
      end;
      CM_SPELL: begin  //使用魔法速度控制
        if boStartSpellCheck then begin
          if CheckBox1.Checked then MemoLog.Lines.Add('魔法-间隔:'+IntToStr(GetTickCount - SessionInfo.dwSpellTick)+' 计时:'+inttostr(GetMagicTick(DefMsg.Tag))+' 魔法ID:'+inttostr(DefMsg.Tag));
          if (GetTickCount - SessionInfo.dwSpellTick) < GetMagicTick(DefMsg.Tag)  then begin
            Inc(SessionInfo.nErrorCount, nIncErrorCount);
            if btPunishType = 0 then begin  //停顿处理
              if SessionInfo.nErrorCount >= 10 then begin
                //红字提示
                if boStartWarning then begin
                  if btWarningMsgType = 0 then
                    m_DefMsg := MakeDefaultMsg({SM_WHISPER}103, Integer(SessionInfo.Socket.SocketHandle), MakeWord(btWarningMsgFColor, btWarningMsgBColor), 0, 1, 0)
                  else m_DefMsg := MakeDefaultMsg({SM_MENU_OK}767, Integer(SessionInfo.Socket.SocketHandle), 0, 0, 0, 0);
                  sSendMsg := '#' + EncodeMessage(m_DefMsg) + string(PChar(EncodeString(sErrMsg))) + '!';
                  SessionInfo.Socket.SendText(sSendMsg);
                end;
                SessionInfo.Socket.SendText('+FAIL/'); //失败
                Result := False;
              end;
            end else begin
              if SessionInfo.nErrorCount >= 50 then Result := MsgTreat(DefMsg,SessionInfo,nIdx);
            end;
          end else begin
            if SessionInfo.nErrorCount > nDecErrorCount then Dec(SessionInfo.nErrorCount, nDecErrorCount);
          end;
          SessionInfo.dwSpellTick:=GetTickCount();
        end;
      end;
      CM_PICKUP: begin //捡东西
          if boStartPickUpCheck then begin
            if CheckBox1.Checked then MemoLog.Lines.Add('捡物-间隔:'+IntToStr(GetTickCount - SessionInfo.dwPickUpTick)+' 计时:'+inttostr(dwPickUpTime));
            if (GetTickCount - SessionInfo.dwPickUpTick) < dwPickUpTime then begin   //使用加速了
              Result := False;
            end else SessionInfo.dwPickUpTick:=GetTickCount();
          end;
        end;
      CM_BUTCH: begin //挖物品
          if boStartButchCheck then begin
            if CheckBox1.Checked then MemoLog.Lines.Add('挖物-间隔:'+IntToStr(GetTickCount - SessionInfo.dwButchTick)+' 计时:'+inttostr(dwButchTime));
            if (GetTickCount - SessionInfo.dwButchTick) < dwButchTime then begin   //使用加速了
              Inc(SessionInfo.nErrorCount, nIncErrorCount);
              if btPunishType = 0 then begin  //停顿处理
                if SessionInfo.nErrorCount >= 10 then begin
                  //红字提示
                  if boStartWarning then begin
                    if btWarningMsgType = 0 then
                      m_DefMsg := MakeDefaultMsg({SM_WHISPER}103, Integer(SessionInfo.Socket.SocketHandle), MakeWord(btWarningMsgFColor, btWarningMsgBColor), 0, 1, 0)
                    else m_DefMsg := MakeDefaultMsg({SM_MENU_OK}767, Integer(SessionInfo.Socket.SocketHandle), 0, 0, 0, 0);
                    sSendMsg := '#' + EncodeMessage(m_DefMsg) + string(PChar(EncodeString(sErrMsg))) + '!';
                    SessionInfo.Socket.SendText(sSendMsg);
                  end;
                  SessionInfo.Socket.SendText('+FAIL/'); //失败
                  Result := False;
                end;
              end else begin
                if SessionInfo.nErrorCount >= 50 then Result := MsgTreat(DefMsg,SessionInfo,nIdx);
              end;
            end else begin
              if SessionInfo.nErrorCount > nDecErrorCount then Dec(SessionInfo.nErrorCount, nDecErrorCount);
            end;
            SessionInfo.dwButchTick:=GetTickCount();
          end;
       end;
      CM_TURN: begin//转身(方向改变)
          if boStartTurnCheck then begin
            if CheckBox1.Checked then MemoLog.Lines.Add('转身-间隔:'+IntToStr(GetTickCount - SessionInfo.dwTurnTick)+' 计时:'+inttostr(dwTurnTime));
            if (GetTickCount - SessionInfo.dwTurnTick) < dwTurnTime then begin   //使用加速了
              Inc(SessionInfo.nErrorCount, nIncErrorCount);
              if btPunishType = 0 then begin  //停顿处理
                if SessionInfo.nErrorCount >= 10 then begin
                  //红字提示
                  if boStartWarning then begin
                    if btWarningMsgType = 0 then
                      m_DefMsg := MakeDefaultMsg({SM_WHISPER}103, Integer(SessionInfo.Socket.SocketHandle), MakeWord(btWarningMsgFColor, btWarningMsgBColor), 0, 1, 0)
                    else m_DefMsg := MakeDefaultMsg({SM_MENU_OK}767, Integer(SessionInfo.Socket.SocketHandle), 0, 0, 0, 0);
                    sSendMsg := '#' + EncodeMessage(m_DefMsg) + string(PChar(EncodeString(sErrMsg))) + '!';
                    SessionInfo.Socket.SendText(sSendMsg);
                  end;
                  SessionInfo.Socket.SendText('+FAIL/'); //失败
                  Result := False;
                end;
              end else begin
                if SessionInfo.nErrorCount >= 50 then Result := MsgTreat(DefMsg,SessionInfo,nIdx);
              end;
            end else begin
              if SessionInfo.nErrorCount > nDecErrorCount then Dec(SessionInfo.nErrorCount, nDecErrorCount);
            end;
            SessionInfo.dwTurnTick:=GetTickCount();
          end;
       end;
      CM_HEROEAT, CM_EAT: begin//吃药
          if boStartEatCheck  then begin //药品
            if (DefMsg.Param = 1) then begin
              if CheckBox1.Checked then MemoLog.Lines.Add('吃药-间隔:'+IntToStr(GetTickCount - SessionInfo.dwEatTick)+' 计时:'+inttostr(dwEatTime));
              if (GetTickCount - SessionInfo.dwEatTick) < dwEatTime then begin   //使用加速了
                if wIdent = CM_EAT then
                  m_DefMsg := MakeDefaultMsg(SM_EAT_FAIL, Integer(SessionInfo.Socket.SocketHandle), 0, 0, 0, 0)
                else m_DefMsg := MakeDefaultMsg(SM_HEROEAT_FAIL, Integer(SessionInfo.Socket.SocketHandle), 0, 0, 0, 0); //英雄吃药失败
                sSendMsg := '#' + EncodeMessage(m_DefMsg) + '!';
                SessionInfo.Socket.SendText(sSendMsg);
                Result := False;
              end else SessionInfo.dwEatTick:=GetTickCount();
            end;
          end;
       end;
       CM_BUYSHOPITEM{购买商铺物品},CM_BUYSHOPITEMGIVE{商铺赠送}, CM_EXCHANGEGAMEGIRD{兑换灵符},
       CM_OPENHEROPULSEPOINT{客户端点击英雄穴位}, CM_REPAIRDRAGON{修补祝福罐.魔令包},CM_REPAIRFINEITEM{修补火云石},CM_GETBOXS{宝箱给玩家物品},
       CM_QUERYBAGITEMS{刷新人物的包裹物品}, CM_CHALLENGETRY{玩家点击挑战}, CM_DEALTRY{玩家点交易按键}, CM_ITEMSPLIT{客户端拆分物品},
       CM_ITEMMERGER{客户端合并物品},CM_OPENPULSEPOINT{客户端点击穴位}, //CM_USERBUYITEM{NPC购买物品},
       CM_CLICKBATTERNPC{点击“确定”后进入触发},CM_PRACTICEPULSE{客户端修炼经络},CM_HEROPRACTICEPULSE{客户端英雄修炼经络}: begin
         if boStartOtherCheck then begin
           if (GetTickCount - SessionInfo.dwOtherTick) < 200 then begin
             Result := False;
           end else SessionInfo.dwOtherTick:=GetTickCount();
         end;
       end;
    end;
  except
    AddMainLogMsg('[Exception] TFrmMain.CheckDefMsg', 1);
  end;
end;

{ //关掉所有连接
procedure TFrmMain.CloseAllUser;
var
  nSockIdx: Integer;
begin
  for nSockIdx := 0 to GATEMAXSESSION - 1 do begin
    if SessionArray[nSockIdx].Socket <> nil then
      SessionArray[nSockIdx].Socket.Close;
  end;
end; }

procedure TFrmMain.MENU_CONTROL_RELOADCONFIGClick(Sender: TObject);
begin
  if Application.MessageBox('是否确认重新加载配置信息？',
    '确认信息',
    MB_OKCANCEL + MB_ICONQUESTION
    ) <> IDOK then Exit;
  LoadConfig();
end;

procedure TFrmMain.MENU_VIEW_LOGMSGClick(Sender: TObject);
begin
  FrmOnLineHum := TFrmOnLineHum.Create(Owner);
  FrmOnLineHum.Open;
  FrmOnLineHum.Free;
end;

procedure TFrmMain.I1Click(Sender: TObject);
begin
  FrmAbout := TFrmAbout.Create(Owner);
  FrmAbout.Open();
  FrmAbout.Free;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  dwLoopCheckTick := GetTickCount();
  TempLogList := TStringList.Create;
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
  TempLogList.Free;
end;

procedure TFrmMain.ShowMainLogMsg;
var
  i: Integer;
begin
  if (GetTickCount - dwShowMainLogTick) < 200 then Exit;
  dwShowMainLogTick := GetTickCount();
  try
    boShowLocked := True;
    try
      CS_MainLog.Enter;
      for i := 0 to MainLogMsgList.Count - 1 do begin
        TempLogList.Add(MainLogMsgList.Strings[i]);
      end;
      MainLogMsgList.Clear;
    finally
      CS_MainLog.Leave;
    end;
    for i := 0 to TempLogList.Count - 1 do begin
      MemoLog.Lines.Add(TempLogList.Strings[i]);
    end;
    TempLogList.Clear;
  finally
    boShowLocked := False;
  end;
end;


procedure TFrmMain.MENU_CONTROL_STARTClick(Sender: TObject);
begin
  StartService();
end;

procedure TFrmMain.N2Click(Sender: TObject);
begin
  with FrmHookCheck do begin
    CheckBoxCheck.Checked := boStartHookCheck;
    CheckBoxWalk.Checked := boStartWalkCheck;
    CheckBoxHit.Checked := boStartHitCheck;
    CheckBoxRun.Checked := boStartRunCheck;
    CheckBoxSpell.Checked := boStartSpellCheck;
    CheckBoxWarning.Checked := boStartWarning;
    CheckBoxEat.Checked := boStartEatCheck;
    CheckBoxOther.Checked := boStartOtherCheck;
    CheckBoxPickUp.Checked := boStartPickUpCheck;
    CheckBoxButch.Checked := boStartButchCheck;//是否开启挖肉控制
    CheckBoxTurn.Checked := boStartTurnCheck;//是否开启转身控制

    SpinEditWalk.Value := dwWalkTime;
    SpinEditHit.Value := dwHitTime;
    SpinEditRun.Value := dwRunTime;
    speEatItemInvTime.Value := dwEatTime;
    spePickUpItemInvTime.Value := dwPickUpTime;

    SpinEditButch.Value := dwButchTime;//是否开启挖肉控制
    SpinEditTurn.Value := dwTurnTime;//是否开启转身控制
    speItemSpeed.Value := dwItemSpeed; //装备加速因数
    CombPunishType.ItemIndex := btPunishType; //处理类型
    //SpinEditSpell.Value := dwSpellTime;
    SpinEditIncErrorCount.Value := nIncErrorCount;
    SpinEditDecErrorCount.Value := nDecErrorCount;

    EditWarningMsgFColor.Value := btWarningMsgFColor;
    EditWarningMsgBColor.Value := btWarningMsgBColor;
    LabeltWarningMsgFColor.Color := GetRGB(btWarningMsgFColor);
    LabelWarningMsgBColor.Color := GetRGB(btWarningMsgBColor);
    EditErrMsg.Color := GetRGB(btWarningMsgBColor);
    EditErrMsg.Font.Color := GetRGB(btWarningMsgFColor);
    EditErrMsg.Text := sErrMsg;
    ComBoxMagic.ItemIndex:= 0;
    speCLTMagic.Value := dwSKILL_1;
    CheckBoxCheckClick(CheckBoxCheck);
    BitBtnOK.Enabled := False;
  end;
  FrmHookCheck.ShowModal();
end;

procedure TFrmMain.MENU_CONTROL_EXITClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin

  if boClose then Exit;
  if Application.MessageBox('是否确认退出服务器？',
    '确认信息',
    MB_YESNO + MB_ICONQUESTION) = IDYES then begin
    if boServiceStart then begin
      StartTimer.Enabled := True;
      CanClose := False;
    end;
  end else CanClose := False;
end;

procedure TFrmMain.MENU_CONTROL_STOPClick(Sender: TObject);
begin
  if Application.MessageBox('是否确认停止服务？',
    '确认信息',
    MB_YESNO + MB_ICONQUESTION) = IDYES then
    StopService();
end;

procedure TFrmMain.ClientSocketError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
//00454E0C
begin
  ErrorCode := 0;
  Socket.Close;
  boServerReady := False;
end;

function TFrmMain.GetMagicTick(MagicId: Byte): LongWord;
begin
  case MagicId of
      1: Result := dwSKILL_1; //火球术
      2: Result := dwSKILL_2; //治愈术
      5: Result := dwSKILL_5; //大火球
      6,93: Result := dwSKILL_6; //施毒术
      8: Result := dwSKILL_8; //抗拒火环
      9: Result := dwSKILL_9; //地狱火
     10: Result := dwSKILL_10; //疾光电影
     11,91: Result := dwSKILL_11; //雷电术
     13: Result := dwSKILL_13; //灵魂火符
     14: Result := dwSKILL_14; //幽灵盾
     15: Result := dwSKILL_15; //神圣战甲术
     16: Result := dwSKILL_16; //困魔咒
     17: Result := dwSKILL_17; //召唤骷髅
     18: Result := dwSKILL_18; //隐身术
     19: Result := dwSKILL_19; //集体隐身术
     20: Result := dwSKILL_20; //诱惑之光
     21: Result := dwSKILL_21; //瞬息移动
     22: Result := dwSKILL_22; //火墙
     23: Result := dwSKILL_23; //爆裂火焰
     24: Result := dwSKILL_24; //地狱雷光
     27: Result := dwSKILL_27; //野蛮冲撞
     28: Result := dwSKILL_28; //心灵启示
     29: Result := dwSKILL_29; //群体治疗术
     30: Result := dwSKILL_30; //召唤神兽
     //31: Result :=; //魔法盾
     32: Result := dwSKILL_32; //圣言术
     33: Result := dwSKILL_33; //冰咆哮
     34: Result := dwSKILL_34; //解毒术
     35: Result := dwSKILL_35; //狮吼功
     36: Result := dwSKILL_36; //火焰冰
     37: Result := dwSKILL_37; //群体雷电术
     38: Result := dwSKILL_38; //群体施毒术
     39: Result := dwSKILL_39; //彻地钉
     41: Result := dwSKILL_41; //狮子吼
     44: Result := dwSKILL_44; //寒冰掌
     45: Result := dwSKILL_45; //灭天火
     46: Result := dwSKILL_46; //分身术
     47: Result := dwSKILL_47; //火龙焰
     48: Result := dwSKILL_48; //气功波
     49: Result := dwSKILL_49; //净化术
     50: Result := dwSKILL_50; //无极真气
     51: Result := dwSKILL_51; //飓风破
     52: Result := dwSKILL_52; //诅咒术
     53: Result := dwSKILL_53; //血咒
     54: Result := dwSKILL_54; //骷髅咒
     55: Result := dwSKILL_55; //擒龙手
     56: Result := dwSKILL_56; //乾坤大挪移
     57: Result := dwSKILL_57; //复活术
     58,92: Result := dwSKILL_58; //流星火雨
     59,94: Result := dwSKILL_59; //噬血术
     //66: Result :=; //4级魔法盾
     71: Result := dwSKILL_71;//召唤圣兽
     72: Result := dwSKILL_72; //召唤月灵
    else Result := 0;
  end;
end;

procedure TFrmMain.MemoLogChange(Sender: TObject);
begin
  if MemoLog.Lines.Count > 500 then MemoLog.Clear;
end;

procedure TFrmMain.SendServerMsg(nIdent: Integer; wSocketIndex: Word; nSocket, nUserListIndex: Integer; nLen: Integer; Data: PChar);
var
  SendBuffer: PChar;
  nBuffLen: Integer;
  GateMsg: TMsgHeader;
begin
  //SendBuffer:=nil;
  GateMsg.dwCode := RUNGATECODE;
  GateMsg.nSocket := nSocket;
  GateMsg.wGSocketIdx := wSocketIndex;
  GateMsg.wIdent := nIdent;
  GateMsg.wUserListIndex := nUserListIndex;
  GateMsg.nLength := nLen;
  nBuffLen := nLen + SizeOf(TMsgHeader);
  GetMem(SendBuffer, nBuffLen);
  Move(GateMsg, SendBuffer^, SizeOf(TMsgHeader));
  if Data <> nil then begin
    Move(Data^, SendBuffer[SizeOf(TMsgHeader)], nLen);
  end; //0045505E
  SendSocket(SendBuffer, nBuffLen);
  FreeMem(SendBuffer);
end;

procedure TFrmMain.ServerSocketClientError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
  ErrorCode := 0;
  Socket.Close;
end;

procedure TFrmMain.SendSocket(SendBuffer: PChar; nLen: Integer);
begin
{  if ClientSocket.Socket.Connected then
    ClientSocket.Socket.SendBuf(SendBuffer^, nLen); }
  while ClientSocket.Socket.Connected do begin//20100922 循环向M2发消息
    if ClientSocket.Socket.SendBuf(SendBuffer^,nLen)<>-1 then break;
  end;
end;

procedure TFrmMain.RestSessionArray;
var
  tSession: pTSessionInfo;
  i: Integer;
begin
  for i := 0 to GATEMAXSESSION - 1 do begin
    tSession := @SessionArray[i];
    tSession.Socket := nil;
    tSession.sSocData := '';
    tSession.sSendData := '';
    tSession.dwReceiveTick := GetTickCount();
    tSession.nSckHandle := -1;
    tSession.dwSayMsgTick := GetTickCount();
    tSession.nSessionID := 0;//会话ID 20090208
    tSession.nUserListIndex := 0;
    tSession.nPacketIdx := -1;
    tSession.nPacketErrCount := 0;
    tSession.boStartLogon := True;
    //tSession.boSendLock := False;
    //tSession.boOverNomSize := False;
    //tSession.nOverNomSizeCount := 0;
    //tSession.dwSendLatestTime := GetTickCount();
    tSession.boSendAvailable := True;
    tSession.boSendCheck := False;
    tSession.nCheckSendLength := 0;
    tSession.nReceiveLength := 0;
  end;
end;

procedure TFrmMain.TimerTimer(Sender: TObject);
const
  sMsg = '用户 %d/%d/%d';
begin
  if not ServerSocket.Active then begin
    LabelUserInfo.Caption := Format(sMsg, [0, 0, 0]);
    POPMENU_CONNCOUNT.Caption := '????';
  end else begin
    POPMENU_PORT.Caption := IntToStr(ServerSocket.Port);
    if boSendHoldTimeOut then begin
      LabelUserInfo.Caption := Format(sMsg, [ServerSocket.Socket.ActiveConnections, ServerSocket.Socket.ActiveConnections, ServerSocket.Port]);
      POPMENU_CONNCOUNT.Caption := IntToStr(SessionCount) + '/#' + IntToStr(ServerSocket.Socket.ActiveConnections);
    end else begin
      LabelUserInfo.Caption := Format(sMsg, [ServerSocket.Socket.ActiveConnections, 0, ServerSocket.Port]);
      POPMENU_CONNCOUNT.Caption := IntToStr(SessionCount) + '/' + IntToStr(ServerSocket.Socket.ActiveConnections);
    end;
  end;
end;

procedure TFrmMain.StartTimerTimer(Sender: TObject);
begin
  if not boStarted then begin
    boStarted := True;
    StartTimer.Enabled := False;
    StartService();
  end else begin
    StartTimer.Enabled := False;
    StopService();
    boClose := True;
    Close;
  end;
end;

end.

