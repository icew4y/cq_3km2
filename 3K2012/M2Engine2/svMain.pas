//指针、数组等，越界后,程序会直接关闭无异常提示...(前提是没异常保护By TasNat at:2012-12-15 12:35:45)
unit svMain;

interface

uses
  Windows, Messages, SysUtils, Graphics, Controls, Forms, Dialogs, Buttons,
  StdCtrls, IniFiles, M2Share, Grobal2, SDK, HUtil32, RunSock, Envir, ItmUnit,
  Magic, Guild, Event, Castle, FrnEngn, UsrEngn, Mudutil, Menus, ComCtrls, Grids,
  RzCommon, Common,RzEdit, RzPanel, RzSplit, RzGrids, Classes, JSocket, ExtCtrls,
  IdAntiFreezeBase, IdAntiFreeze, IdBaseComponent, IdComponent, IdUDPBase, IdUDPClient;

type
  TFrmMain = class(TForm)
    Timer1: TTimer;
    RunTimer: TTimer;
    DBSocket: TClientSocket;
    ConnectTimer: TTimer;
    StartTimer: TTimer;
    SaveVariableTimer: TTimer;
    CloseTimer: TTimer;
    IdUDPClientLog: TIdUDPClient;
    RzSplitter: TRzSplitter;
    MemoLog: TRzMemo;
    RzSplitter1: TRzSplitter;
    Panel: TRzPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label5: TLabel;
    Lbcheck: TLabel;
    LbRunSocketTime: TLabel;
    LbRunTime: TLabel;
    LbTimeCount: TLabel;
    LbUserCount: TLabel;
    MemStatus: TLabel;
    GridGate: TRzStringGrid;
    LabelVersion: TLabel;
    Timer2: TTimer;
    VersionM2: TLabel;
    MainMenu: TMainMenu;
    MENU_CONTROL: TMenuItem;
    MENU_CONTROL_CLEARLOGMSG: TMenuItem;
    MENU_CONTROL_RELOAD: TMenuItem;
    MENU_CONTROL_RELOAD_ITEMDB: TMenuItem;
    MENU_CONTROL_RELOAD_MAGICDB: TMenuItem;
    MENU_CONTROL_RELOAD_MONSTERDB: TMenuItem;
    MENU_CONTROL_RELOAD_MONSTERSAY: TMenuItem;
    MENU_CONTROL_RELOAD_DISABLEMAKE: TMenuItem;
    MENU_CONTROL_RELOAD_STARTPOINT: TMenuItem;
    MENU_CONTROL_RELOAD_CONF: TMenuItem;
    QFunctionNPC: TMenuItem;
    QManageNPC: TMenuItem;
    RobotManageNPC: TMenuItem;
    MonItems: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N6: TMenuItem;
    NPC1: TMenuItem;
    NPC2: TMenuItem;
    N7: TMenuItem;
    S1: TMenuItem;
    MENU_CONTROL_GATE: TMenuItem;
    MENU_CONTROL_GATE_OPEN: TMenuItem;
    MENU_CONTROL_GATE_CLOSE: TMenuItem;
    N4: TMenuItem;
    MENU_CONTROL_EXIT: TMenuItem;
    MENU_VIEW: TMenuItem;
    MENU_VIEW_ONLINEHUMAN: TMenuItem;
    MENU_VIEW_SESSION: TMenuItem;
    MENU_VIEW_LEVEL: TMenuItem;
    MENU_VIEW_LIST: TMenuItem;
    N1: TMenuItem;
    MENU_VIEW_KERNELINFO: TMenuItem;
    MENU_OPTION: TMenuItem;
    MENU_OPTION_GENERAL: TMenuItem;
    MENU_OPTION_GAME: TMenuItem;
    MENU_OPTION_ITEMFUNC: TMenuItem;
    MENU_OPTION_FUNCTION: TMenuItem;
    G1: TMenuItem;
    MENU_OPTION_MONSTER: TMenuItem;
    MENU_OPTION_SERVERCONFIG: TMenuItem;
    MENU_OPTION_HERO: TMenuItem;
    MENU_MANAGE: TMenuItem;
    MENU_MANAGE_ONLINEMSG: TMenuItem;
    MENU_MANAGE_PLUG: TMenuItem;
    MENU_MANAGE_CASTLE: TMenuItem;
    G2: TMenuItem;
    MENU_TOOLS: TMenuItem;
    MENU_TOOLS_MERCHANT: TMenuItem;
    MENU_TOOLS_NPC: TMenuItem;
    MENU_TOOLS_MONGEN: TMenuItem;
    MENU_TOOLS_IPSEARCH: TMenuItem;
    MENU_HELP: TMenuItem;
    MENU_HELP_ABOUT: TMenuItem;
    QBatter1: TMenuItem;
    N8: TMenuItem;
    QMission1: TMenuItem;
    N9: TMenuItem;
    N5: TMenuItem;
    MENU_HELP_GETBUGINFO: TMenuItem;

    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure MemoLogChange(Sender: TObject);
    procedure MemoLogDblClick(Sender: TObject);
    procedure MENU_CONTROL_EXITClick(Sender: TObject);
    procedure MENU_CONTROL_RELOAD_CONFClick(Sender: TObject);
    procedure MENU_CONTROL_CLEARLOGMSGClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure MENU_CONTROL_RELOAD_ITEMDBClick(Sender: TObject);
    procedure MENU_CONTROL_RELOAD_MAGICDBClick(Sender: TObject);
    procedure MENU_CONTROL_RELOAD_MONSTERDBClick(Sender: TObject);
    procedure MENU_HELP_ABOUTClick(Sender: TObject);
    procedure MENU_OPTION_SERVERCONFIGClick(Sender: TObject);
    procedure MENU_OPTION_GENERALClick(Sender: TObject);
    procedure MENU_OPTION_GAMEClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MENU_OPTION_FUNCTIONClick(Sender: TObject);
    procedure MENU_CONTROL_RELOAD_MONSTERSAYClick(Sender: TObject);
    procedure MENU_CONTROL_RELOAD_DISABLEMAKEClick(Sender: TObject);
    procedure MENU_CONTROL_GATE_OPENClick(Sender: TObject);
    procedure MENU_CONTROL_GATE_CLOSEClick(Sender: TObject);
    procedure MENU_CONTROLClick(Sender: TObject);
    procedure MENU_VIEW_GATEClick(Sender: TObject);
    procedure MENU_VIEW_SESSIONClick(Sender: TObject);
    procedure MENU_VIEW_ONLINEHUMANClick(Sender: TObject);
    procedure MENU_VIEW_LEVELClick(Sender: TObject);
    procedure MENU_VIEW_LISTClick(Sender: TObject);
    procedure MENU_MANAGE_ONLINEMSGClick(Sender: TObject);
    procedure MENU_VIEW_KERNELINFOClick(Sender: TObject);
    procedure MENU_TOOLS_MERCHANTClick(Sender: TObject);
    procedure MENU_OPTION_ITEMFUNCClick(Sender: TObject);
    procedure MENU_TOOLS_MONGENClick(Sender: TObject);
    procedure MENU_CONTROL_RELOAD_STARTPOINTClick(Sender: TObject);
    procedure MENU_MANAGE_PLUGClick(Sender: TObject);
    procedure G1Click(Sender: TObject);
    procedure MENU_OPTION_MONSTERClick(Sender: TObject);
    procedure MENU_TOOLS_IPSEARCHClick(Sender: TObject);
    procedure MENU_MANAGE_CASTLEClick(Sender: TObject);
    procedure MENU_HELP_REGKEYClick(Sender: TObject);
    procedure QFunctionNPCClick(Sender: TObject);
    procedure QManageNPCClick(Sender: TObject);
    procedure RobotManageNPCClick(Sender: TObject);
    procedure MonItemsClick(Sender: TObject);
    procedure MENU_OPTION_HEROClick(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure NPC1Click(Sender: TObject);
    procedure NPC2Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure S1Click(Sender: TObject);
    procedure G2Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure QBatter1Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure QMission1Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure MENU_HELP_GETBUGINFOClick(Sender: TObject);
  private
    boServiceStarted: Boolean; //变量意思：服务开始
    procedure GateSocketClientError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);//客户边连接错误
    procedure GateSocketClientDisconnect(Sender: TObject; Socket: TCustomWinSocket); //断开客户连接
    procedure GateSocketClientConnect(Sender: TObject; Socket: TCustomWinSocket);//客户端连接
    procedure GateSocketClientRead(Sender: TObject; Socket: TCustomWinSocket);//客户端读取
    procedure DBSocketConnect(Sender: TObject; Socket: TCustomWinSocket);//数据库连接成功，显示远程IP及端口
    procedure DBSocketError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);//数据库连接错误
    procedure DBSocketRead(Sender: TObject; Socket: TCustomWinSocket); //读取数据库数据

    procedure Timer1Timer(Sender: TObject);
    procedure StartTimerTimer(Sender: TObject);
    procedure CloseTimerTimer(Sender: TObject);
    procedure SaveVariableTimerTimer(Sender: TObject);
    procedure RunTimerTimer(Sender: TObject);
    procedure ConnectTimerTimer(Sender: TObject);

    procedure StartService();//起动服务器
    procedure StopService();//停止服务器
    procedure SaveItemNumber; //保存!Setup.txt内容
    //function LoadClientFile(): Boolean;  //载入客户文件
    procedure StartEngine; //起动引擎
    //procedure MakeStoneMines;//制造石矿
    procedure ReloadConfig(Sender: TObject);//再装载配置
    procedure ClearMemoLog(); //清除日志
    procedure CloseGateSocket(); //关闭连接
    procedure SaveItemsData;//保存数据 20080408
    { Private declarations }
  public
    GateSocket: TServerSocket;
    procedure AppOnIdle(Sender: TObject; var Done: Boolean);//应用于空闲
    procedure OnProgramException(Sender: TObject; E: Exception);//在程序异常
    procedure SetMenu(); virtual;
    procedure MyMessage(var MsgData: TWmCopyData); message WM_COPYDATA;  //响应 启动器的关闭消息
    procedure CreateParams(var Params:TCreateParams);override;//设置程序的类名 20080412
    procedure SaveItemNumber1();//断开M2连接网关 20090726
    { Public declarations }
  end;
  procedure WriteConLog(MsgList: TStringList); //写入日志
  procedure ChangeCaptionText(Msg: PChar; nLen: Integer); stdcall; //生成程序标题
  procedure UserEngineThread(ThreadInfo: pTThreadInfo); stdcall; //使用引擎线程
  procedure ProcessGameRun(); //游戏运行过程
  procedure TFrmMain_ChangeGateSocket(boOpenGateSocket: Boolean; nCRCA: Integer); stdcall;
  function M2AutoAddExpPlay: Boolean;//M2自动把离线人物重新离线挂机 20090319
var
  FrmMain: TFrmMain;
  g_GateSocket: TServerSocket;

implementation
uses
  LocalDB, {InterServerMsg, InterMsgClient,} IdSrvClient, FSrvValue, PlugIn, GeneralConfig,//20101022 去掉两单元
  GameConfig, FunctionConfig, ObjRobot, ViewSession, ViewOnlineHuman, ViewLevel, ViewList,
  OnlineMsg, ViewKernelInfo, ConfigMerchant, ItemSet, ConfigMonGen, PlugInManage, EDcode,
  EDcodeUnit, GameCommand, MonsterConfig, RunDB, CastleManage, PlugOfEngine, EngineRegister{注册窗口},
  AboutUnit, HeroConfig, ViewList2, GuildManage{$IF UserMode1 = 2},WinlicenseSDK, Clipbrd{$IFEND}, PathFind, Division,
  DivisionManage;
                      
var
  sCaption: string;
  l_dwRunTimeTick: LongWord;
  g_boRemoteOpenGateSocket: Boolean = {$IF TESTMODE = 1} not {$ifend}False;
  boRemoteOpenGateSocketed: Boolean = False;
  boSaveData: Boolean = False;
  LogFile: TextFile;
  boBusy: Boolean = false;//20080715 增加判断RunTimer是否重入
  boBusy1: Boolean = false;//20080715 增加判断TTimer 是否重入
  dwSortArrayTick, dwSaveItemSortTick: LongWord;//取人物等级排行的间隔
  boRefSord: Boolean = False;//是否正在刷新排行榜
{$R *.dfm}
//断开M2连接网关 20090726
procedure TFrmMain.SaveItemNumber1();
begin
  g_boRemoteOpenGateSocket := False;
end;
//M2自动把离线人物重新离线挂机 20090319
function M2AutoAddExpPlay: Boolean;
var
  sFileName: String;
begin
  Result := False;
  sFileName := g_Config.sEnvirDir + 'AutoAddExpPlay.txt';
  if FileExists(sFileName) then begin
    UserEngine.m_M2AutoAddPlay.Clear;
    UserEngine.m_M2AutoAddPlay.LoadFromFile(sFileName);
    Result := True;
  end else MainOutMessage('挂机文件:'+sFileName + ' 没有找到，请用DBServer.exe导出挂机文件再使用此功能！');
end;

procedure ChangeCaptionText(Msg: PChar; nLen: Integer); stdcall; //生成程序标题
var
  sMsg: string;
begin
  if (nLen > 0) and (nLen < 50) then begin
    setlength(sMsg, nLen);
    Move(Msg^, sMsg[1], nLen);
    sCaptionExtText := sMsg;
  end;
end;
//判断是否加载M2注册插件(SystemModule.dll),如没有加载,则不让连接游戏网关 20071108
procedure TFrmMain_ChangeGateSocket(boOpenGateSocket: Boolean; nCRCA: Integer); stdcall;
begin
{$I Encode_Start.inc}//代码加密标识
  //MainOutMessage ('g_Config.nServerFile_CRCA:'+inttostr(g_Config.nServerFile_CRCA)+'   '+inttostr(nCRCA));
  if g_Config.nServerFile_CRCA = nCRCA then//校对M2 CRC码
    g_boRemoteOpenGateSocket := boOpenGateSocket
  else
    MainOutMessage(inttostr(nCRCA) + ' <> ' + inttostr(g_Config.nServerFile_CRCA));
  {$IF TESTMODE = 1}
  g_boRemoteOpenGateSocket := boOpenGateSocket;
  {$IFEND}  
{$I Encode_End.inc}
end;

 //写入日志
procedure WriteConLog(MsgList: TStringList);
var
  I: Integer;
  Year, Month, Day, Hour, Min, Sec, MSec: Word;
  sLogDir, sLogFileName: string;
begin
  try
    if MsgList.Count <= 0 then Exit;
    DecodeDate(Date, Year, Month, Day);//根据日期值返回年、月、日值
    DecodeTime(Time, Hour, Min, Sec, MSec); //根据时间值返回时、分、秒、毫秒值
    if not DirectoryExists(g_Config.sConLogDir) then begin //DirectoryExists判断文件夹是否存在
      //CreateDirectory(PChar(g_Config.sConLogDir),nil);
      ForceDirectories(g_Config.sConLogDir);  //修改 By TasNat at: 2012-04-02 12:59:46
    end;
    sLogDir := g_Config.sConLogDir + IntToStr(Year) + '-' + IntToStr2(Month) + '-' + IntToStr2(Day);
    if not DirectoryExists(sLogDir) then begin
      //CreateDirectory(PChar(sLogDir), nil);
      ForceDirectories(sLogDir);//修改 By TasNat at: 2012-04-02 12:59:46
    end;
    sLogFileName := sLogDir + '\C-' + IntToStr(nServerIndex) + '-' + IntToStr2(Hour) + 'H' + IntToStr2((Min div 10 * 2) * 5) + 'M.txt';
    AssignFile(LogFile, sLogFileName);
    try//20081229
      if not FileExists(sLogFileName) then begin
        Rewrite(LogFile);
      end else begin
        Append(LogFile);
      end;
      if MsgList.Count > 0 then begin//20080629
        for I := 0 to MsgList.Count - 1 do begin
          if MsgList.Strings[I] <> '' then Writeln(LogFile, '1' + #9 + MsgList.Strings[I]);//20091113
        end; // for
      end;
    finally
      CloseFile(LogFile);//出现异常
    end;
  except
    //MainOutMessage('{异常} 写入ConLog目录日志出错 Code:'+inttostr(nCode));
  end;
end;
//保存!Setup.txt内容
procedure TFrmMain.SaveItemNumber();
var
  I: Integer;
  dwRunTick: LongWord;
  boProcessLimit: Boolean;
begin
  try
    Config.WriteInteger('Setup', 'ItemNumber', g_Config.nItemNumber);
    Config.WriteInteger('Setup', 'ItemNumberEx', g_Config.nItemNumberEx);
    Config.WriteInteger('Setup', 'FengHaoNumber', g_Config.nFengHaoNumber);
//---------------------------保存系统变量---------------------------------------
    dwRunTick := GetTickCount();
    boProcessLimit := False;
    if g_boExitServer then g_Config.nSaveGlobalValIdx := 0;
    for I := g_Config.nSaveGlobalValIdx to High(g_Config.GlobalVal) do begin
      if (I > High(g_Config.GlobalVal)) then Break;
      if g_TempGlobalVal[I] <> g_Config.GlobalVal[I] then begin//20101020 增加,使用临时变量对比值是否改变
        g_TempGlobalVal[I] := g_Config.GlobalVal[I];
        Config.WriteInteger('Setup', 'GlobalVal' + IntToStr(I), g_Config.GlobalVal[I]);
      end;
      if g_TempGlobalAVal[I] <> g_Config.GlobalAVal[I] then begin
        g_TempGlobalAVal[I] := g_Config.GlobalAVal[I];
        Config.WriteString('Setup', 'GlobalStrVal' + IntToStr(I), g_Config.GlobalAVal[I]);
      end;
      if not g_boExitServer then begin
        if ((GetTickCount - dwRunTick) > 10) and (I < High(g_Config.GlobalVal)) then begin
          g_Config.nSaveGlobalValIdx := I + 1;
          boProcessLimit := True;
          Break;
        end;
      end;
    end;
    if not boProcessLimit then g_Config.nSaveGlobalValIdx := 0;
//------------------------------------------------------------------------------
    Config.WriteInteger('Setup', 'WinLotteryCount', g_Config.nWinLotteryCount);
    Config.WriteInteger('Setup', 'NoWinLotteryCount', g_Config.nNoWinLotteryCount);
    Config.WriteInteger('Setup', 'WinLotteryLevel1', g_Config.nWinLotteryLevel1);
    Config.WriteInteger('Setup', 'WinLotteryLevel2', g_Config.nWinLotteryLevel2);
    Config.WriteInteger('Setup', 'WinLotteryLevel3', g_Config.nWinLotteryLevel3);
    Config.WriteInteger('Setup', 'WinLotteryLevel4', g_Config.nWinLotteryLevel4);
    Config.WriteInteger('Setup', 'WinLotteryLevel5', g_Config.nWinLotteryLevel5);
    Config.WriteInteger('Setup', 'WinLotteryLevel6', g_Config.nWinLotteryLevel6);
  except
  end;
end;

procedure TFrmMain.AppOnIdle(Sender: TObject; var Done: Boolean);
begin
  //MainOutMessage ('空闲');
end;

procedure TFrmMain.OnProgramException(Sender: TObject; E: Exception);
begin
  if E is EConvertError then //忽略StrToInt一类的异常 By TasNat at: 2012-03-21 16:55:52
  (*else if E is EAccessViolation then
    MainOutMessage(Format('{%s} EAV:%p',[g_sExceptionVer, EAccessViolation(E).ExceptionRecord.ExceptionAddress]))*)
  else
    MainOutMessage(Format('{%s} %s',[g_sExceptionVer, E.Message]));
end;

procedure TFrmMain.DBSocketError(Sender: TObject; Socket: TCustomWinSocket;
  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  ErrorCode := 0;
  Socket.Close;
end;
//读取数据库数据,即DBserver.exe 回传的数据  20080219
procedure TFrmMain.DBSocketRead(Sender: TObject; Socket: TCustomWinSocket);
var                   
  tStr: string;
begin
  EnterCriticalSection(UserDBSection);//进入全局变量临界区
  try
    tStr := Socket.ReceiveText;  //ReceiveText表示收到的文本内容
    g_Config.sDBSocketRecvText := g_Config.sDBSocketRecvText + tStr;
    if not g_Config.boDBSocketWorking then begin
      g_Config.sDBSocketRecvText := '';
    end;
  finally
    LeaveCriticalSection(UserDBSection); //离开临界区
  end;
end;


procedure TFrmMain.Timer1Timer(Sender: TObject);
var
  I: Integer;
  nRow: Integer;
  GateInfo: pTGateInfo;
  nCode: Byte;
begin
  if boBusy1 then Exit;
  boBusy1:= True;
  nCode:= 0;
  try
    Try
      EnterCriticalSection(LogMsgCriticalSection);
      try
        nCode:= 1;
        if MemoLog.Lines.Count > 500 then MemoLog.Clear;
        if MainLogMsgList.Count > 0 then begin
          try
            nCode:= 2;
            if not FileExists(sLogFileName) then begin
              nCode:= 3;
              AssignFile(LogFile, sLogFileName);
              Rewrite(LogFile);
            end else begin
              nCode:= 4;
              AssignFile(LogFile, sLogFileName);
              Append(LogFile);
            end;
            nCode:= 5;
            for I := 0 to MainLogMsgList.Count - 1 do begin
              MemoLog.Lines.Add(MainLogMsgList.Strings[I]);
              Writeln(LogFile, MainLogMsgList.Strings[I]);
            end;
            MainLogMsgList.Clear;
            nCode:= 8;
            CloseFile(LogFile);
          except
            MemoLog.Lines.Add('保存日志信息出错！');
          end;
        end;
        nCode:= 9;
        if LogStringList.Count > 0 then begin
          for I := 0 to LogStringList.Count - 1 do begin
            try
              sCaption := '1' + #9 + IntToStr(g_Config.nServerNumber) + #9 + IntToStr(nServerIndex) + #9 + LogStringList.Strings[I];
              IdUDPClientLog.Send(sCaption); //发送游戏日志,文本内容
            except
              Continue;
            end;
          end;
          LogStringList.Clear;
        end;
        nCode:= 13;
        if LogonCostLogList.Count > 0 then begin
          WriteConLog(LogonCostLogList); //写入日志
          LogonCostLogList.Clear;
        end;
      finally
        LeaveCriticalSection(LogMsgCriticalSection);  //离开临界区
      end;

      {$IF SoftVersion = VERDEMO}
      sCaption := '[D]';
      {$ELSEIF SoftVersion = VERFREE}
      sCaption := '[F]';
      {$ELSEIF SoftVersion = VERSTD}
      sCaption := '[S]';
      {$ELSEIF SoftVersion = VEROEM}
      sCaption := '[O]';
      {$ELSEIF SoftVersion = VERPRO}
      sCaption := '[P]';
      {$ELSEIF SoftVersion = VERENT}
      sCaption := '[E]';
      {$IFEND}
      sCaption  := '[M]'+sCaption;//20101022 替换
      {if nServerIndex = 0 then begin
        sCaption  := '[M]'+sCaption;
      end else begin
        if FrmMsgClient.MsgClient.Socket.Connected then begin
          sCaption  := '[S]'+sCaption;
        end else begin
          sCaption  := '[ ]'+sCaption;
        end;
      end;}

      nCode:= 17;
      //GetTickCount()用于获取自windows启动以来经历的时间长度（毫秒）
      nRow := (GetTickCount() - g_dwStartTick) div 1000;
      LbRunTime.Caption := IntToStr(nRow div 3600) + ':' + IntToStr((nRow div 60) mod 60) + ':' + IntToStr(nRow mod 60) + ' ' + sCaption;
      LbUserCount.Caption := Format('怪物(%d)     人物(%d/%d)(%d/%d)', [UserEngine.MonsterCount,
          UserEngine.OnlinePlayObject,
          UserEngine.PlayObjectCount,
          UserEngine.LoadPlayCount,
          UserEngine.m_PlayObjectFreeList.Count]);

      nCode:= 18;
      Label1.Caption := Format('处理(%d/%d) 传输(%d/%d) 角色(%d/%d)', [nRunTimeMin, nRunTimeMax, g_nSockCountMin, g_nSockCountMax, g_nUsrTimeMin, g_nUsrTimeMax]);

      Label2.Caption := Format('人物(%d/%d) 循环(%d/%d) 交易(%d/%d) 管理(%d/%d) (%d)', [g_nHumCountMin,
          g_nHumCountMax,
          dwUsrRotCountMin,
          dwUsrRotCountMax,
          UserEngine.dwProcessMerchantTimeMin,
          UserEngine.dwProcessMerchantTimeMax,
          UserEngine.dwProcessNpcTimeMin,
          UserEngine.dwProcessNpcTimeMax,
          g_nProcessHumanLoopTime]);
      nCode:= 19;
      Label5.Caption := g_sMonGenInfo1 + ' - ' + g_sMonGenInfo2 + '    ';

      Label20.Caption := Format('刷新怪物(%d/%d/%d) 处理怪物(%d/%d/%d) 角色处理(%d/%d)', [g_nMonGenTime, g_nMonGenTimeMin, g_nMonGenTimeMax, g_nMonProcTime, g_nMonProcTimeMin, g_nMonProcTimeMax, g_nBaseObjTimeMin, g_nBaseObjTimeMax]);

      if dwStartTimeTick = 0 then dwStartTimeTick := GetTickCount;
      dwStartTime := (GetTickCount - dwStartTimeTick) div 1000;

      if (GetTickCount() / 86400000) >= 36 then LbTimeCount.Font.Color := clRed
      else LbTimeCount.Font.Color := clBlack;
      LbTimeCount.Caption := CurrToStr((GetTickCount() / 86400000)) + '天';
      nCode:= 20;
      // GridGate
      nRow := 1;
      for I := Low(g_GateArr) to High(g_GateArr) do begin
        GridGate.Cells[0, I + 1] := '';
        GridGate.Cells[1, I + 1] := '';
        GridGate.Cells[2, I + 1] := '';
        GridGate.Cells[3, I + 1] := '';
        GridGate.Cells[4, I + 1] := '';
        GridGate.Cells[5, I + 1] := '';
        GridGate.Cells[6, I + 1] := '';
        GateInfo := @g_GateArr[I];
        nCode:= 26;
        if GateInfo.boUsed and (GateInfo.Socket <> nil) then begin
          nCode:= 24;
          GridGate.Cells[0, nRow] := IntToStr(I);
          GridGate.Cells[1, nRow] := GateInfo.sAddr + ':' + IntToStr(GateInfo.nPort);
          nCode:= 25;
          GridGate.Cells[2, nRow] := IntToStr(GateInfo.nSendMsgCount);//列队数据
          GridGate.Cells[3, nRow] := IntToStr(GateInfo.nSendedMsgCount);//发送数据
          GridGate.Cells[4, nRow] := IntToStr(GateInfo.nSendRemainCount);//剩余数据
          nCode:= 23;
          if GateInfo.nSendMsgBytes < 1024 then begin//平均流量
            GridGate.Cells[5, nRow] := IntToStr(GateInfo.nSendMsgBytes) + 'b';
          end else begin
            GridGate.Cells[5, nRow] := IntToStr(GateInfo.nSendMsgBytes div 1024) + 'kb';
          end;
          GridGate.Cells[6, nRow] := IntToStr(GateInfo.nUserCount) + '/' + IntToStr(GateInfo.UserList.Count);
          Inc(nRow);
        end;
      end;
      nCode:= 22;
      LbRunSocketTime.Caption := 'Soc' + IntToStr(g_nGateRecvMsgLenMin) + '/' + IntToStr(g_nGateRecvMsgLenMax);
      Inc(nRunTimeMax);
      if g_nSockCountMax > 0 then Dec(g_nSockCountMax);
      if g_nUsrTimeMax > 0 then Dec(g_nUsrTimeMax);
      if g_nHumCountMax > 0 then Dec(g_nHumCountMax);
      if g_nMonTimeMax > 0 then Dec(g_nMonTimeMax);
      if dwUsrRotCountMax > 0 then Dec(dwUsrRotCountMax);
      if g_nMonGenTimeMin > 1 then Dec(g_nMonGenTimeMin, 2);
      if g_nMonProcTimeMin > 1 then Dec(g_nMonProcTimeMin, 2);
      if g_nBaseObjTimeMax > 0 then Dec(g_nBaseObjTimeMax);
    except
      on E: Exception do begin
        MainOutMessage(Format('{%s} Timer1Timer Code:%d',[g_sExceptionVer, nCode]));
      end;
    end;
  finally
    boBusy1:= False;
  end;
end;

procedure TFrmMain.StartTimerTimer(Sender: TObject);
var
  nCode: Integer;
begin
  SendGameCenterMsg(SG_STARTNOW, '正在启动游戏主程序...');//发送游戏中心信息 与启动器的通信
  StartTimer.Enabled := False;
  FrmDB := TFrmDB.Create(); //生成数据库连接模块
  StartService(); //起动服务器
  try
    if SizeOf(THumDataInfo) <> SIZEOFTHUMAN then begin
      ShowMessage('sizeof(THuman) ' + IntToStr(SizeOf(THumDataInfo)) + ' <> SIZEOFTHUMAN ' + IntToStr(SIZEOFTHUMAN));
      Close;
      Exit;
    end;
    {if not LoadClientFile then begin//如果没有加载客户端信息
      Close;
      Exit;
    end; }
    {$if TESTMODE = 0}
    if (nGetSysDate >= 0) and Assigned(PlugProcArray[nGetSysDate].nProcAddr) then begin//检查系统插件是否为3K插件 20081203
      if PlugProcArray[nGetSysDate].nProcCode = 9 then begin
        {$IF M2Version = 0}
        Decode(addStringList('4?H;JH:=;8O4OI4>HJO8NIN>J;;O=5?J;?MI9;>I==?9=>N4'), sCaptionExtText);//www.IGEM2.com 系统插件标识
        {$ELSEIF M2Version = 2}
        Decode(addStringList('4?H;JH:=;8O4OI4>HJO8NIN>J;;O=5?J;?MI9;>I==?9=>N4'), sCaptionExtText);//www.IGEM2.com 系统插件标识
        {$ELSE}
        Decode(addStringList('H:8J8>NI;O>?HN;54?48H5?;44=4H;:JI5;<9::MJ;M:NO:H'), sCaptionExtText);//www.3KM2.com].net 系统插件标识 20100317
        {$IFEND}
        if not TGetSysDate(PlugProcArray[nGetSysDate].nProcAddr)(Pchar(sCaptionExtText)) then Exit;
      end else Exit;
    end else Exit;
    {$ifend}
{$IF DBTYPE = BDE}  //设置Query的数据库连接属性
    FrmDB.Query.DatabaseName := sDBName;
{$ELSE}
    FrmDB.Query.ConnectionString := Format(g_sADODBString,[Base64DecodeStr(g_sSQLPassword), g_sSQLUserName, g_sSQLDatabase, g_sSQLHost]);
{$IFEND}
    LoadGameLogItemNameList();//加载游戏日志物品名
    LoadDenyIPAddrList();  //加载IP过滤列表
    LoadDenyAccountList();   //加载登录帐号过滤列表
    LoadDenyChrNameList();//加载禁止登录人物列表
    LoadNoClearMonList();    //加载不清除怪物列表
    LoadAICharNameList();
    LoadAIHeroNameList();
    //g_Config.nServerFile_CRCB := CalcFileCRC(Application.ExeName); //未使用 20080504
    nCode := FrmDB.LoadItemsDB;
    if nCode < 0 then begin
      MemoLog.Lines.Add('物品数据库加载失败！' + '代码: ' + IntToStr(nCode));
      Exit;
    end else begin
      MemoLog.Lines.Add(Format('加载物品数据库成功(%d)...', [UserEngine.StdItemList.Count]));
    end;
    {$IF M2Version <> 2}
    nCode := FrmDB.LoadHumTitleDB;//读取称号数据
    if nCode < 0 then begin
      MemoLog.Lines.Add('称号数据库加载失败！' + '代码: ' + IntToStr(nCode));
      Exit;
    end else begin
      MemoLog.Lines.Add(Format('加载称号数据库成功(%d)...', [UserEngine.HumTitleList.Count]));
    end;
    {$IFEND}
    nCode := FrmDB.LoadMinMap;
    if nCode < 0 then begin
      MemoLog.Lines.Add('小地图数据加载失败！' + '代码: ' + IntToStr(nCode));
      Exit;
    end else begin
      MemoLog.Lines.Add('加载小地图数据成功...');
    end;

    nCode := FrmDB.LoadMapInfo;
    if nCode < 0 then begin
      MemoLog.Lines.Add('地图数据加载失败！' + '代码: ' + IntToStr(nCode));
      Exit;
    end else begin
      MemoLog.Lines.Add(Format('加载地图数据成功(%d)...', [g_MapManager.Count]));
    end;

    nCode := FrmDB.LoadMonsterDB;
    if nCode < 0 then begin
      MemoLog.Lines.Add('加载怪物数据库失败！' + '代码: ' + IntToStr(nCode));
      Exit;
    end else begin
      MemoLog.Lines.Add(Format('加载怪物数据库成功(%d)...', [UserEngine.MonsterList.Count]));
    end;

    nCode := FrmDB.LoadMagicDB;
    if nCode < 0 then begin
      MemoLog.Lines.Add('加载技能数据库失败！' + '代码: ' + IntToStr(nCode));
      Exit;
    end else begin
      MemoLog.Lines.Add(Format('加载技能数据库成功(%d)...', [UserEngine.m_MagicList.Count]));
    end;

    nCode := FrmDB.LoadMonGen;
    if nCode < 0 then begin
      MemoLog.Lines.Add('加载怪物刷新配置信息失败！' + '代码: ' + IntToStr(nCode));
      Exit;
    end else begin
      //MemoLog.Lines.Add(Format('加载怪物刷新配置信息成功(%d)...', [UserEngine.m_MonGenList.Count]));
    end;
    LoadGlobalVal(False);//读取全局变量值 20110713
    if LoadMonSayMsg() then MemoLog.Lines.Add(Format('加载怪物说话配置信息成功(%d)...', [g_MonSayMsgList.Count]));

    LoadDisableTakeOffList(); //加载禁止取下物品列表
    LoadMonDropLimitList();   //加载怪物爆物品限制列表
    LoadDisableMakeItem();    //加载禁止制造物品列表
    LoadEnableMakeItem();     //加载可制造物品列表
    LoadLimitItemList();//读取限时物品列表
    {$IF M2Version <> 2}
    LoadEnableArmsExchangeItem();//读取允许兑换卷轴碎片列表
    FrmDB.LoadDominatSendPoint();//读取主宰令传送点配置
    {$IFEND}
    LoadDisableMoveMap;       //加载禁止移动地图列表
    ItemUnit.LoadCustomItemName();
    LoadDisableSendMsgList();  //加载禁止发信息名称列表
    LoadItemBindIPaddr();      //加载捆绑IP列表
    LoadItemBindAccount();
    LoadItemBindCharName();
    LoadItemBindDieNoDropName();//读取人物装备死亡不爆列表 20081127
    LoadUnMasterList();       //加载出师记录表
    LoadUnForceMasterList();  //加载强行出师记录表
    LoadItemDblClickList();

    LoadAllowPickUpItemList(); //加载允许捡取物品
    LoadAllowAIPickUpItemList();//加载假人允许捡取物品
    LoadDisableGamePointShopItemList();//加载禁止荣耀值购买物品
    {LoadAllowSellOffItemList(); //加载允许出售列表  //20080416 去掉拍卖功能

    MemoLog.Lines.Add('正在加载寄售物品数据库...');
    g_SellOffGoldList.LoadSellOffGoldList();
    g_SellOffGoodList.LoadSellOffGoodList();
    MemoLog.Lines.Add(Format('加载寄售物品数据库成功(%d)...', [g_SellOffGoodList.RecCount])); }

    g_Storage.LoadBigStorageList(g_StorageFileName); //加载无限仓库数据
    //MemoLog.Lines.Add(Format('加载无限仓库数据库成功(%d/%d)...', [g_Storage.HumManCount, g_Storage.RecordCount]));

    nCode := FrmDB.LoadUnbindList;
    if nCode < 0 then begin
      MemoLog.Lines.Add('加载捆装物品信息失败！' + '代码: ' + IntToStr(nCode));
      Exit;
    end else begin
      MemoLog.Lines.Add('加载捆装物品信息成功...');
    end;

    LoadString();//加载String.ini 20110713
    LoadBindItemTypeFromUnbindList(); //加载捆装物品类型

    nCode := FrmDB.LoadMapQuest;
    if nCode > 0 then begin
      MemoLog.Lines.Add('加载任务地图信息成功...');
    end else begin
      MemoLog.Lines.Add('加载任务地图信息(MapQuest.txt)失败！');
      Exit;
    end;

    LoadGameCommand();//加载Command.ini 20110713

    nCode := FrmDB.LoadMapEvent;
    if nCode < 0 then begin
      MemoLog.Lines.Add('加载地图触发事件信息失败！');
      Exit;
    end else begin
      MemoLog.Lines.Add('加载地图触发事件信息成功...');
    end;

    LoadExp(False);//20110713
    
    nCode := FrmDB.LoadQuestDiary;
    if nCode < 0 then begin
      MemoLog.Lines.Add('加载任务说明信息失败！');
      Exit;
    end else begin
      MemoLog.Lines.Add('加载任务说明信息成功...');
    end;

    if LoadLineNotice(g_Config.sNoticeDir + 'LineNotice.txt') then begin
      MemoLog.Lines.Add('加载公告提示信息成功...');
    end else MemoLog.Lines.Add('加载公告提示信息失败！');
    LoadHangAutoMsg(g_Config.sNoticeDir + 'HangAutoMsg.txt');//读取挂机自动回复文件 20100908
    nCode:= 254;
    LoadUserCmdList();//加载自定义命令 20080729
    nCode:= 253;
    LoadCheckItemList();//加载禁止物品规则 20080729
    LoadEffecItemList();//加载物品特效规则
    nCode:= 252;
    LoadMsgFilterList();//加载消息过滤 20080729
    nCode:= 251;
    LoadShopItemList();//加载商铺配置 20080730
    nCode:= 250;
    FrmDB.LoadAdminList();//加载管理员列表
    FrmDB.LoadAutoFindRout();//加载寻路怪行走目标点配置
    nCode:= 249;
    g_GuildManager.LoadGuildInfo();//加载行会列表
    nCode:= 248;
    FrmDB.LoadBoxsList; //20080114
    MemoLog.Lines.Add('加载宝箱配置成功('+IntToStr(BoxsList.Count)+')...');
    nCode:= 247;
    FrmDB.LoadSuitItemList();//读取套装装备数据 20080225
    MemoLog.Lines.Add('加载套装配置成功('+IntToStr(g_SuitItemList.Count)+')...');
    nCode:= 246;
    FrmDB.LoadSellOffItemList();//读取元宝寄售列表 20080316
    MemoLog.Lines.Add('加载元宝寄售数据成功('+IntToStr(sSellOffItemList.Count)+')...');
    nCode:= 245;
    {$IF M2Version <> 2}
    g_DivisionManager.LoadDivisionInfo();//加载师门列表
    FrmDB.LoadRefineItem;//20080502
    MemoLog.Lines.Add('加载淬炼配置信息成功('+IntToStr(g_RefineItemList.Count)+')...');
    FrmDB.LoadRefineDrumItemList;  // add by liuzhigang on 20111214
    MemoLog.Lines.Add('加载其他淬炼配置信息成功('+IntToStr(g_RefineDrumItemList.Count)+')...');
    nCode:= 244;
    FrmDB.LoadItemSortListToFile();//读取物品排行数据
    nCode:= 237;
    FrmDB.LoadDigJewelItemList();//读取挖宝物品列表 20100905
    LoadHeartSkillName();
    {$IFEND}
    g_CastleManager.LoadCastleList();
    MemoLog.Lines.Add('加载城堡列表成功...');
    nCode:= 243;
    LoadNotice(g_Config.sNoticeDir + 'Notice.txt');//读取公告 Notice.txt
    nCode:= 242;
    FrmDB.LoadMonFireDragonGuard();//创建守护兽并写入列表 20090111
    nCode:= 241;
    //UserCastle.Initialize;
    g_CastleManager.Initialize;
    MemoLog.Lines.Add('城堡城初始完成...');
    {nCode:= 240;
    if (nServerIndex = 0) then FrmSrvMsg.StartMsgServer //20101022 注释
    else FrmMsgClient.ConnectMsgServer;}
    nCode:= 239;
    StartEngine();
    boStartReady := True;
    //Sleep(500);//20080520 注释

    ConnectTimer.Enabled := True;

    g_dwRunTick := GetTickCount();
    n4EBD1C := 0;
    g_dwUsrRotCountTick := GetTickCount();
    nCode:= 238;
    RunTimer.Enabled := True;
    SendGameCenterMsg(SG_STARTOK, '游戏主程序启动完成...');
    GateSocket.Address := g_Config.sGateAddr;
    GateSocket.Port := g_Config.nGatePort;
    g_GateSocket := GateSocket;
   // if g_boMinimize then Application.Minimize;//启动完成后最小化
    Timer2.Enabled:=True;
    dwSaveDataTick := GetTickCount();//20091009 换位置
    dwSortArrayTick := GetTickCount + 300000;
    dwSaveItemSortTick := GetTickCount + 1800000;
    SaveVariableTimer.Enabled:=True;//20080831 增加
    SendGameCenterMsg(SG_CHECKCODEADDR, IntToStr(Integer(@g_CheckCode)));
  except
    on E: Exception do MainOutMessage('服务器启动异常！Code:'+inttostr(nCode)+' '+ E.Message);
  end;
end;
//开始运行引擎
procedure TFrmMain.StartEngine();
var
  nCode, nX: Integer;
begin
  try
    HeroAddSkillToHum(sProductName1,sProgram1,sWebSite1,sBbsSite1,sProductInfo1,sSellInfo1);//20081018 判断是否需要显示指定的文本
{$IF IDSOCKETMODE = TIMERENGINE}
    FrmIDSoc.Initialize;
    MemoLog.Lines.Add('登录服务器连接初始化完成...');
{$IFEND}
    g_MapManager.LoadMapDoor;
    MemoLog.Lines.Add('加载地图环境成功...');

    //MakeStoneMines();//制造矿物, 初始化有点久 20080520
    //MemoLog.Lines.Add('矿物数据初始成功...');
    nCode := FrmDB.LoadMerchant;
    if nCode < 0 then begin
      MemoLog.Lines.Add('交易NPC列表加载失败 ！' + '错误码: ' + IntToStr(nCode));
      Exit;
    end else MemoLog.Lines.Add('加载交易NPC列表成功...');

    if not g_Config.boVentureServer then begin
      nCode := FrmDB.LoadGuardList;
      if nCode < 0 then begin
        MemoLog.Lines.Add('守卫列表加载失败 ！' + '错误码: ' + IntToStr(nCode));
      end else MemoLog.Lines.Add('加载守卫列表成功...');
    end;

    nCode := FrmDB.LoadNpcs;
    if nCode < 0 then begin
      MemoLog.Lines.Add('管理NPC列表加载失败 ！' + '错误码: ' + IntToStr(nCode));
      Exit;
    end else MemoLog.Lines.Add('加载管理NPC列表成功...');

    nCode := FrmDB.LoadMakeItem;
    if nCode < 0 then begin
      MemoLog.Lines.Add('炼制物品信息加载失败 ！' + '错误码: ' + IntToStr(nCode));
      Exit;
    end else MemoLog.Lines.Add('加载炼制物品信息成功...');

    nCode := FrmDB.LoadStartPoint;
    if nCode < 0 then begin
      MemoLog.Lines.Add('加载回城点配置时出现错误 ！(错误码: ' + IntToStr(nCode) + ')');
      Close;
    end else MemoLog.Lines.Add('加载回城点配置成功...');

    FrmDB.LoadSortList();//加载排行榜数据

    FrontEngine.Resume;
    MemoLog.Lines.Add('人物数据引擎启动成功...');
    UserEngine.Initialize;
    MemoLog.Lines.Add('游戏处理引擎初始化成功...');
    g_MapManager.MakeSafePkZone; //安全区光圈

    Decode(addStringList('5NIOJHH4=8?4:9H?4?48H5?;44=4H;:J>I;<9:O?NMM58H=8'), sCaptionExtText);//www.3KM2.com 20100317

    sCaption := g_Config.sServerName;//20100408 增加
    Caption := sCaption + ' [' + sCaptionExtText + ']';//设置M2标题

    if not boShowSetTxt then begin
      Decode(addStringList(g_sProductInfo), sCaptionExtText);
      MainOutMessage(sCaptionExtText);

      Decode(addStringList(g_sWebSite), sCaptionExtText);
      MainOutMessage(sCaptionExtText);

      Decode(addStringList(g_sBbsSite), sCaptionExtText);
      MainOutMessage(sCaptionExtText);

      //Decode(addStringList(g_sSellInfo1), sCaptionExtText);
      //MainOutMessage(sCaptionExtText);
      {$IF UserMode1 = 2}
      {$I VM_Start.inc}//虚拟机标识
      if not WLProtectCheckDebugger then begin//检测调试器存在内存中
        case WLRegGetStatus(nX) of
          0: begin//检查程序是否注册 没有注册则提示
            Decode('90094CCBDB69EAA48D7CC4A01BBD513AF8314D312BCB30EA', sCaptionExtText);//测试版 限制人数:10
            MainOutMessage(sCaptionExtText);
          end;
          wlIsRegistered: begin//已注册的

          end;
          else begin
            asm //关闭程序
              MOV FS:[0],0;
              MOV DS:[0],EAX;
            end;
          end;
        end;
      end;
      {$I VM_End.inc}
      {$IFEND}
    end else begin
      MainOutMessage(sProductInfo1);
      MainOutMessage(sWebSite1);
      MainOutMessage(sBbsSite1);
      MainOutMessage(sSellInfo1);
    end;
    //20071106
    if (nStartModule >= 0) and Assigned(PlugProcArray[nStartModule].nProcAddr) then begin
      if PlugProcArray[nStartModule].nProcCode = 1 then TStartProc(PlugProcArray[nStartModule].nProcAddr);
    end;

    PlugInEngine.StartPlugMoudle;
    MemoLog.Lines.Add('引擎插件初始化成功...');
(*    HeroAddSkillToHum1(sBUYHINTINF03);//取广告关键字
{$IF TESTMODE = 1}
    MemoLog.Lines.Add('[广告]'+sBUYHINTINF03);
{$IFEND} *)
    boSaveData := True;//保存数据
    RegGetStatusFailExitApp(FrmMain.Caption, 0);//20080603 //判断M2标题是否被破解修改
  except
    MainOutMessage('服务启动时出现异常错误 ！');
  end;
end;
{//制造石矿
procedure TFrmMain.MakeStoneMines();
var
  I, nW, nH: Integer;
  Envir: TEnvirnoment;
begin
  if g_MapManager.Count > 0 then begin//20091113 增加
    for I := 0 to g_MapManager.Count - 1 do begin
      Envir := TEnvirnoment(g_MapManager.Items[I]);
      if Envir.m_boMINE then begin
        for nW := 0 to Envir.m_nWidth - 1 do begin
          for nH := 0 to Envir.m_nHeight - 1 do begin
            TStoneMineEvent.Create(Envir, nW, nH, ET_STONEMINE);
          end;
        end;
      end;
    end;//for
  end;  
end;   }
(*//读取客户端版本信息
function TFrmMain.LoadClientFile(): Boolean;
begin
//  Result := True;
  if not (g_Config.sClientFile1 = '') then g_Config.nClientFile1_CRC := CalcFileCRC(g_Config.sClientFile1);
  //if not (g_Config.sClientFile2 = '') then g_Config.nClientFile2_CRC := CalcFileCRC(g_Config.sClientFile2);
  //if not (g_Config.sClientFile3 = '') then g_Config.nClientFile3_CRC := CalcFileCRC(g_Config.sClientFile3);
  if (g_Config.nClientFile1_CRC <> 0) {or (g_Config.nClientFile2_CRC <> 0) or (g_Config.nClientFile3_CRC <> 0)} then begin
    MemoLog.Lines.Add('加载客户端版本信息成功...');
    Result := True;
  end else begin
    MemoLog.Lines.Add('加载客户端版本信息失败！');
    Result := False;
  end;
end; *)

procedure TFrmMain.FormCreate(Sender: TObject);
var
  nX, nY: Integer;
{$IF UserMode1 = 2}
  ClStr, s1:string;
  MachineId: array [0..100] of AnsiChar;
  //ClStr1, ClStr2, ClStr3: array [0..255] of AnsiChar;
{$IFEND}
begin
  //ShowMessage(IntToStr(SizeOf(MachineId)));
{$IF UserMode1 = 2}
  {$I VM_Start.inc}//虚拟机标识
  if WLProtectCheckDebugger then begin//检测调试器存在内存中
    asm //关闭程序
      MOV FS:[0],0;
      MOV DS:[0],EAX;
    end;
  end;    
  case WLRegGetStatus(nX) of
    0: begin//检查程序是否注册 没有注册则提示
      pMaxPlayCount^ := 10;
      WLHardwareGetID(MachineId);//取硬件ID

      //使用普通程序加密函数
      Decode('243F2F9136D9C6465A54A4BA779F619B5EEED0F138F326D167474A5D5AC935FD77CC253F46D9021D', s1); //请不要修改计算机日期，注册软件：
      ClStr:= s1+#13+#13;
      Decode('E7FEAF3C7D9F4C29DF69FE5E0BEF3653', s1);//机器信息：
      ClStr:= ClStr+s1+MachineId;
      Decode('D4F5AD4F4E9C17BC3B84FB3B55A799D5B4EA78A6A8BAF744426266E8D06C94E31DCABCDBFBB4E610114BFF41B4EE5D1F8F5D9AC807BAFDFF9274859074DCDCD4', s1);//  (Ctrl+v粘贴到文本)  发送给客服，进行注册
      ClStr:= ClStr+s1+#13+#13;;
      Decode('83D7FD6174C8CE827F55815A1C6592A3FA458CECC1AEA7EC6CC672654BD0833913D13082E5444B33', s1);//官方网站：http://www.3Km2.com
      ClStr:= ClStr+s1;
      Decode('4F760445F72C3BF5DA894722823CFE71', s1);//3K软件
      {$if TESTMODE <> 1}

      Application.MessageBox(PChar(ClStr) ,PChar(s1),MB_IConERROR + MB_OK + MB_TOPMOST);
      Clipbrd.Clipboard.AsText := MachineId;//复制到剪切板上
      {$Ifend}
    end;
    wlIsRegistered: begin//已注册的，取IP信息
      N8.Visible := True;
      pMaxPlayCount^ := 1000000;
      //WLRegGetLicenseInfo(ClStr1, ClStr2, ClStr3);
      //PBoolean1^:= Trim(ClStr3);//将IP信息存储到指针变量中 20090324
    end;
    else begin
      asm //关闭程序
        MOV FS:[0],0;
        MOV DS:[0],EAX;
      end; 
    end;
  end;//case
  {$I VM_End.inc}
{$IFEND}     
  Randomize;
  g_dwGameCenterHandle := Str_ToInt(ParamStr(1), 0);
  nX := Str_ToInt(ParamStr(2), -1);
  nY := Str_ToInt(ParamStr(3), -1);
  if (nX >= 0) or (nY >= 0) then begin
    Left := nX;
    Top := nY;
  end;
  SendGameCenterMsg(SG_FORMHANDLE, IntToStr(Self.Handle));
  GridGate.RowCount := 21;
  GridGate.Cells[0, 0] := '网关';
  GridGate.Cells[1, 0] := '网关地址';
  GridGate.Cells[2, 0] := '队列数据';
  GridGate.Cells[3, 0] := '发送数据';
  GridGate.Cells[4, 0] := '剩余数据';
  GridGate.Cells[5, 0] := '平均流量';
  GridGate.Cells[6, 0] := '最高人数';

  GateSocket := TServerSocket.Create(Owner);
  GateSocket.OnClientConnect := GateSocketClientConnect;
  GateSocket.OnClientDisconnect := GateSocketClientDisconnect;
  GateSocket.OnClientError := GateSocketClientError;
  GateSocket.OnClientRead := GateSocketClientRead;

  DBSocket.OnConnect := DBSocketConnect;//写DBServer连接成功后,提示
  DBSocket.OnError := DBSocketError;
  DBSocket.OnRead := DBSocketRead;//接收DBserver.exe 回传的数据

  Timer1.OnTimer := Timer1Timer;
  RunTimer.OnTimer := RunTimerTimer;
  StartTimer.OnTimer := StartTimerTimer;
  SaveVariableTimer.OnTimer := SaveVariableTimerTimer;
  ConnectTimer.OnTimer := ConnectTimerTimer;
  CloseTimer.OnTimer := CloseTimerTimer;
  MemoLog.OnChange := MemoLogChange;
  StartTimer.Enabled := True;
{$IF M2Version = 1}
  QBatter1.Visible := True;
{$ELSE}
  QBatter1.Visible := False;
{$IFEND}
{$IF M2Version = 2}
  N5.Visible := False;
  N7.Visible := False;
  N9.Visible := False;
{$IFEND}
end;

procedure TFrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
resourcestring
  sCloseServerYesNo = '是否确认关闭游戏服务器？';
  sCloseServerTitle = '确认信息';
begin
  if not boServiceStarted then begin   //如果没有服务开始
    //    Application.Terminate;
    Exit;
  end;
  if g_boExitServer then begin
    boStartReady := False;
    Exit;
  end;
  CanClose := False;
  if Application.MessageBox(PChar(sCloseServerYesNo), PChar(sCloseServerTitle), MB_YESNO + MB_ICONQUESTION) = mrYes then begin
    g_boExitServer := True;
    CloseGateSocket();
    g_Config.boKickAllUser := True;
    //RunSocket.CloseAllGate;
    //GateSocket.Close;
    UserEngine.m_M2AutoAddPlay.Clear;//清空挂机列表
    CloseTimer.Enabled := True;
  end;
end;

procedure TFrmMain.CloseTimerTimer(Sender: TObject);
begin
  SaveVariableTimer.Enabled:= False;//20090817 增加
  Caption := Format('%s [正在关闭服务器(%s %d/%s %d)...]', [g_Config.sServerName, '人物', UserEngine.OnlinePlayObject, '数据', FrontEngine.SaveListCount]);
  if UserEngine.OnlinePlayObject = 0 then begin
    if FrontEngine.IsIdle then begin
      try//20100226 增加异常保护
        CloseTimer.Enabled := False;
        Caption := Format('%s [服务器已关闭]', [g_Config.sServerName]);
        boSaveData := False;
        dwSaveDataTick := GetTickCount() - 600000{1000 * 60 * 10};
        SaveItemsData;
        StopService;  
        Close;
      except
      end;
    end;
  end;
end;
//保存物品数据 20080408
procedure TFrmMain.SaveItemsData;
var nCode: Byte;
begin
  if (GetTickCount() - dwSaveDataTick > 480000{1000 * 60 * 8}) or g_boExitServer then begin//退出M2时也保存其它数据 20091009
    dwSaveDataTick := GetTickCount();
    nCode:= 0;
    try//20091125 增加
      //if g_SellOffGoodList <> nil then g_SellOffGoodList.SaveSellOffGoodList(); //20080416 去掉拍卖功能
      //if g_SellOffGoldList <> nil then g_SellOffGoldList.SaveSellOffGoldList(); //20080416 去掉拍卖功能
      if sSellOffItemList <> nil then FrmDB.SaveSellOffItemList();//保存元宝寄售数据  20090129 修改
      nCode:= 1;
      if g_Storage <> nil then g_Storage.SaveToFile(g_StorageFileName);
      {$IF M2Version <> 2}
      if (GetTickCount > dwSaveItemSortTick) or g_boExitServer then begin//每半小时保存一次
        dwSaveItemSortTick := GetTickCount + 1800000;
        FrmDB.SaveItemSortListToFile();//保存物品排行数据
      end;
      {$IFEND}
    except
      MainOutMessage(Format('{%s} SaveItemsData Code:%d',[g_sExceptionVer, nCode]));
    end;
  end;
  SaveItemNumber();//20091009 修改
end;

procedure TFrmMain.SaveVariableTimerTimer(Sender: TObject);
var
  nCode: Byte;
  Min, Hour, Sec, Ms:Word;
begin
  nCode:= 0;
  Try
    if boSaveData then SaveItemsData;
    nCode:= 1;
    DecodeTime(Time, Hour, Min, Sec, Ms);
    nCode:= 2;
    if ((GetTickCount > dwSortArrayTick) or ((Hour = 0) and (Min = 0) and (Sec = 1)))
      and (not boRefSord) and (not g_boExitServer) then begin//间隔刷新排行榜 20100615
      dwSortArrayTick := GetTickCount + 300000;
      boRefSord:= True;
      try
        FrmDB.LoadSortList();
      finally
        boRefSord:= False;
      end;
    end;     
  except
    on E: Exception do begin
      MainOutMessage(Format('{%s} SaveVariableTimerTimer Code:%d',[g_sExceptionVer, nCode]));
    end;
  end;
end;

procedure TFrmMain.GateSocketClientError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
  RunSocket.CloseErrGate(Socket, ErrorCode);
end;

procedure TFrmMain.GateSocketClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  RunSocket.CloseGate(Socket);
end;

procedure TFrmMain.GateSocketClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  RunSocket.AddGate(Socket);
end;

procedure TFrmMain.GateSocketClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  RunSocket.SocketRead(Socket);
end;

procedure TFrmMain.RunTimerTimer(Sender: TObject);
begin
  if boBusy then Exit;
  boBusy:= True;
  try
    Try
      if boStartReady then begin
          {$If RunGateUsesThread = 0}
            RunSocket.Run;//网关相关
          {$Ifend RunGateUsesThread = 0}
        
        FrmIDSoc.Run;//
        UserEngine.Execute;//定时显示在线人数，保存城堡相关配置，通知logsrv.exe在线人数
        ProcessGameRun();//游戏运行过程
        {if nServerIndex = 0 then begin//20101022 注释
          //FrmSrvMsg.Run//20080815 注释(反调试)
        end else FrmMsgClient.Run; }
      end;
      Inc(n4EBD1C);
      if (GetTickCount - g_dwRunTick) > 250 then begin
        g_dwRunTick := GetTickCount();
        nRunTimeMin := n4EBD1C;
        if nRunTimeMax > nRunTimeMin then nRunTimeMax := nRunTimeMin;
        n4EBD1C := 0;
      end;
      if g_boRemoteOpenGateSocket then begin
        if not boRemoteOpenGateSocketed then begin
          boRemoteOpenGateSocketed := True;
          try
            if Assigned(g_GateSocket) then begin
              g_GateSocket.Active := True; //打开网关端口
            end;
          except
            on E: Exception do begin
              MainOutMessage(E.Message);
            end;
          end;
        end;
      end else begin
        if Assigned(g_GateSocket) then begin
          if g_GateSocket.Socket.Connected then g_GateSocket.Active := False;
        end;
      end;
    except
      on E: Exception do begin
        MainOutMessage(Format('{%s} RunTimerTimer %s',[g_sExceptionVer, E.Message]));
      end;
    end;
  finally
    boBusy:= False;
  end;
end;
//间隔三秒，检查DBS连接是否正常
procedure TFrmMain.ConnectTimerTimer(Sender: TObject);
begin
  Try
    if DBSocket.Active then Exit;
    DBSocket.Active := True;
  except
    on E: Exception do begin
      MainOutMessage(Format('{%s} ConnectTimerTimer',[g_sExceptionVer]));
    end;
  end;
end;

procedure TFrmMain.ReloadConfig(Sender: TObject);
begin
  LoadConfig(True);
  LoadGlobalVal(True);//读取全局变量值 20110713
  LoadString();//加载String.ini 20110713
  LoadGameCommand();//加载Command.ini 20110713
  LoadExp(True);//20110713
  FrmIDSoc.Timer1Timer(Sender);
  {if not (nServerIndex = 0) then begin//20101022 注释
    if not FrmMsgClient.MsgClient.Active then begin
      FrmMsgClient.MsgClient.Active := True;
    end;
  end; }
  IdUDPClientLog.Host := g_Config.sLogServerAddr;
  IdUDPClientLog.Port := g_Config.nLogServerPort;
  //LoadClientFile();
end;

procedure TFrmMain.MemoLogChange(Sender: TObject);
begin
  if MemoLog.Lines.Count > 500 then MemoLog.Clear;
end;

procedure TFrmMain.MemoLogDblClick(Sender: TObject);
begin
  ClearMemoLog();
end;

procedure TFrmMain.MENU_CONTROL_EXITClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmMain.MENU_CONTROL_RELOAD_CONFClick(Sender: TObject);
begin
  ReloadConfig(Sender);
end;

procedure TFrmMain.MENU_CONTROL_CLEARLOGMSGClick(Sender: TObject);
begin
  ClearMemoLog();
end;

procedure TFrmMain.SpeedButton1Click(Sender: TObject);
begin
  ReloadConfig(Sender);
end;

procedure TFrmMain.MENU_CONTROL_RELOAD_ITEMDBClick(Sender: TObject);
begin
  FrmDB.LoadItemsDB();
  MainOutMessage('重新加载物品数据库完成...');
end;

procedure TFrmMain.MENU_CONTROL_RELOAD_MAGICDBClick(Sender: TObject);
begin
  FrmDB.LoadMagicDB();
  MainOutMessage('重新加载技能数据库完成...');
end;

procedure TFrmMain.MENU_CONTROL_RELOAD_MONSTERDBClick(Sender: TObject);
begin
  FrmDB.LoadMonsterDB();
  MainOutMessage('重新加载怪物数据库完成...');
end;

procedure TFrmMain.StartService;
var
  TimeNow: TDateTime;
  Year, Month, Day, Hour, Min, Sec, MSec: Word;
  Config: pTConfig;
  sStr, sTemp: string;
begin
  Config := @g_Config;
{初始化参数}
  nRunTimeMax := 99999;
  g_nSockCountMax := 0;
  g_nUsrTimeMax := 0;
  g_nHumCountMax := 0;
  g_nMonTimeMax := 0;
  g_nMonGenTimeMax := 0;
  g_nMonProcTime := 0;
  g_nMonProcTimeMin := 0;
  g_nMonProcTimeMax := 0;
  dwUsrRotCountMin := 0;
  dwUsrRotCountMax := 0;
  g_nProcessHumanLoopTime := 0;
  g_dwHumLimit := 30;
  g_dwMonLimit := 30;
  g_dwZenLimit := 5;
  g_dwNpcLimit := 5;
  g_dwSocLimit := 10;
  nDecLimit := 20;
  Config.sDBSocketRecvText := '';
  Config.boDBSocketWorking := False;
  Config.nLoadDBErrorCount := 0;
  Config.nLoadDBCount := 0;
  Config.nSaveDBCount := 0;
  Config.nDBQueryID := 0;
  Config.nItemNumber := 0;
  Config.nItemNumberEx := High(Integer) div 2;
  g_Config.nFengHaoNumber:= 0;
  boStartReady := False;
  g_boExitServer := False;
  boFilterWord := True;
  Config.nWinLotteryCount := 0;
  Config.nNoWinLotteryCount := 0;
  Config.nWinLotteryLevel1 := 0;
  Config.nWinLotteryLevel2 := 0;
  Config.nWinLotteryLevel3 := 0;
  Config.nWinLotteryLevel4 := 0;
  Config.nWinLotteryLevel5 := 0;
  Config.nWinLotteryLevel6 := 0;
  FillChar(g_Config.GlobalVal, SizeOf(g_Config.GlobalVal), #0);//FillChar()给特定的数据填入指定的字符
  FillChar(g_Config.GlobaDyMval, SizeOf(g_Config.GlobaDyMval), #0);
  FillChar(g_Config.GlobalAVal, SizeOf(g_Config.GlobalAVal), #0);

  FillChar(g_TempGlobalVal, SizeOf(g_TempGlobalVal), #0);//20101020 增加
  FillChar(g_TempGlobalAVal, SizeOf(g_TempGlobalAVal), #0);
(*{$IF USECODE = USEREMOTECODE} //如果使用代码来自远程代码  20080831 注释
  New(Config.Encode6BitBuf);
  Config.Encode6BitBuf^ := g_Encode6BitBuf;

  New(Config.Decode6BitBuf);
  Config.Decode6BitBuf^ := g_Decode6BitBuf;
{$IFEND}*)
  LoadConfig(False);
  Memo := MemoLog;
  nServerIndex := 0;
  PlugInEngine := TPlugInManage.Create;
  zPlugOfEngine := TPlugOfEngine.Create;
  RunSocket := TRunSocket.Create();
  MainLogMsgList := TStringList.Create;
  LogStringList := TStringList.Create;
  LogonCostLogList := TStringList.Create;
  g_MapManager := TMapManager.Create;
  ItemUnit := TItemUnit.Create;
  MagicManager := TMagicManager.Create;
  g_GuildManager := TGuildManager.Create;
  g_EventManager := TEventManager.Create;
  g_CastleManager := TCastleManager.Create;
  {  g_UserCastle        := TUserCastle.Create;
  CastleManager.Add(g_UserCastle); }
  FrontEngine := TFrontEngine.Create(True);
  UserEngine := TUserEngine.Create();
  RobotManage := TRobotManage.Create;
  g_MakeItemList := TStringList.Create;
  g_LimitItemList:= TGStringList.Create;//限时物品列表
{$IF M2Version <> 2}
  g_DivisionManager:= TDivisionManager.Create;//师门管理类
  g_RefineItemList := TStringList.Create;//淬炼配置列表 20080502
  g_HeartSkillNameList := TStringList.Create;
  g_DominatSendList:= TStringList.Create;//主宰令传送坐标列表
  g_EnableArmsExchangeList := TGStringList.Create;
  g_ArmsSortList := TList.Create;//武器榜
  g_RingSortList := TList.Create;//戒指榜
  g_DreSortList := TList.Create;//衣甲榜
  g_ShoesSortList := TList.Create;//靴子榜
  g_HelmeSortList := TList.Create;//头盔榜
  g_BootsSortList := TList.Create;//腰带榜
  g_NecklaceSortList := TList.Create;//项链榜
  g_MedalSortList := TList.Create;//勋章榜
  g_BraceletSortList := TList.Create;//护腕榜
  g_ZhuLiSortList := TList.Create;//斗笠面巾榜
  g_DigJewelItemList1:= TList.Create;//挖宝物品类型1 20100905
  g_DigJewelItemList2:= TList.Create;//挖宝物品类型2 20100905
  g_DigJewelItemList3:= TList.Create;//挖宝物品类型3 20100905
  g_DigJewelItemList4:= TList.Create;//挖宝物品类型4 20100905
{$IFEND}
  g_StartPointList := TGStringList.Create;
  g_AutoFindRout := TGStringList.Create;//自动寻路怪目标点列表
  //ServerTableList := TList.Create;//20090512 注释，没有地方使用ServerTableList列表
  g_DenySayMsgList := TQuickList.Create;
  MiniMapList := TStringList.Create;
  g_UnbindList := TStringList.Create;
  LineNoticeList := TStringList.Create;
  HangAutoMsgList := TStringList.Create;
  NoticeList := TStringList.Create;//公告信息列表 Notice.txt
  g_UserCmdList:= TStringList.Create;//自定义命令列表 20080729
  g_CheckItemList:= TStringList.Create;//禁止物品规则 20090704
  g_EffecItemtList:= TStringList.Create;//物品特效
  g_MsgFilterList:= TList.Create;//消息过滤规则 20080729
  g_ShopItemList:= TList.Create;//商铺物品列表 20080730
  g_QuestDiaryList := TList.Create;
  BoxsList:= TStringList.Create;//20080114 宝箱 20100511 修改
  g_SuitItemList:= TList.Create;//20080225 套装
  sSellOffItemList:= TList.Create;//元宝寄售列表 20080316
  ItemEventList := TStringList.Create;
  g_MonSayMsgList := TStringList.Create;
  g_DisableMakeItemList := TGStringList.Create;
  g_EnableMakeItemList := TGStringList.Create;
  g_DisableMoveMapList := TGStringList.Create;
  g_ItemNameList := TGList.Create;
  g_DisableSendMsgList := TGStringList.Create;
  g_MonDropLimitLIst := TGStringList.Create;
  g_DisableTakeOffList := TGStringList.Create;
  g_UnMasterList := TGStringList.Create;
  g_UnForceMasterList := TGStringList.Create;
  g_GameLogItemNameList := TGStringList.Create;
  g_DenyIPAddrList := TGStringList.Create;
  g_DenyChrNameList := TGStringList.Create;
  g_DenyAccountList := TGStringList.Create;
  g_NoClearMonList := TGStringList.Create;

  g_ItemBindIPaddr := TGList.Create;
  g_ItemBindAccount := TGList.Create;
  g_ItemBindCharName := TGList.Create;//物品人物绑定表(对应的玩家才能戴物品)
  g_ITemBindDieNoDropName := TGList.Create;//人物装备死亡不爆列表

 {g_AllowSellOffItemList := TGStringList.Create;//20080416 去掉拍卖功能
  g_SellOffGoodList := TSellOffGoodList.Create;//20080416 去掉拍卖功能
  g_SellOffGoldList := TSellOffGoldList.Create;//20080416 去掉拍卖功能 }
  g_Storage := TStorage.Create;

  g_MapEventListOfDropItem := TGList.Create;
  g_MapEventListOfPickUpItem := TGList.Create;
  g_MapEventListOfMine := TGList.Create;
  g_MapEventListOfWalk := TGList.Create;
  g_MapEventListOfRun := TGList.Create;

  g_AICharNameList := TGStringList.Create;
  g_AIHeroNameList := TGStringList.Create;

  g_FindPath := TFindPath.Create;//寻路类

  InitializeCriticalSection(LogMsgCriticalSection);
  InitializeCriticalSection(ProcessMsgCriticalSection);
  InitializeCriticalSection(ProcessHumanCriticalSection);
  InitializeCriticalSection(HumanSortCriticalSection);
  InitializeCriticalSection(Config.UserIDSection);
  InitializeCriticalSection(UserDBSection);
  g_DynamicVarList := TList.Create;

  AddToProcTable(@TPlugOfEngine_SetUserLicense, PChar(Base64DecodeStr('U2V0VXNlckxpY2Vuc2U=')),5); //  SetUserLicense
  AddToProcTable(@TFrmMain_ChangeGateSocket, PChar(Base64DecodeStr('Q2hhbmdlR2F0ZVNvY2tldA==')),6); //ChangeGateSocket

  TimeNow := Now();
  DecodeDate(TimeNow, Year, Month, Day);
  DecodeTime(TimeNow, Hour, Min, Sec, MSec);
  if not DirectoryExists(g_Config.sLogDir) then begin
    CreateDir(Config.sLogDir);
  end;

  sLogFileName := g_Config.sLogDir {'.\Log\'} + IntToStr(Year) + '-' + IntToStr2(Month) + '-' + IntToStr2(Day) + '.' + IntToStr2(Hour) + '-' + IntToStr2(Min) + '.txt';
  AssignFile(LogFile, sLogFileName);
  Rewrite(LogFile);
  CloseFile(LogFile);
  Caption := '';
  PlugInEngine.LoadPlugIn();
  nShiftUsrDataNameNo := 1;

  DBSocket.Address := g_Config.sDBAddr;
  DBSocket.Port := g_Config.nDBPort;
  Caption := g_Config.sServerName;
  sCaption := g_Config.sServerName;
{$IF HEROVERSION = 1}
  sTemp:=addStringList(sSoftVersion_HERO);
  Decode(sTemp, sSoftVersionType); //英雄版
  MENU_OPTION_HERO.Visible := True;
{$ELSE}  
  sTemp:=addStringList(sSoftVersion_VERENT);
  Decode(sTemp, sSoftVersionType); //企业版
  MENU_OPTION_HERO.Visible := False;
{$IFEND}

{$IF DBTYPE = ADO}
  LabelVersion.Caption := sSoftVersionType+'(SQL)';
{$ELSE}
  LabelVersion.Caption := sSoftVersionType;
{$IFEND}
{$IF TESTMODE = 0}
  sTemp:=addStringList(g_sVersion);
  Decode(sTemp, sSoftVersionType);
  VersionM2.Caption:= sSoftVersionType;//M2的版本日期 20090212

  if not Decode(sUserQQKey, sStr) then begin//判断是否被破解 20080603
    nCrackedLevel := Random(10000);
    nErrorLevel := Random(10000);
  end else begin
    if Str_ToInt(sStr, -1) <> nUserLicense then begin
      nCrackedLevel := Random(10000);
      nErrorLevel := Random(10000);
    end;
  end;
{$ELSE}
  MainOutMessage(Format('CrackedLevel_1:%d ErrorLevel:%d',[nCrackedLevel, nErrorLevel]));
{$IFEND}
  IdUDPClientLog.Host := g_Config.sLogServerAddr;
  IdUDPClientLog.Port := g_Config.nLogServerPort;

  Application.OnIdle := AppOnIdle;
  Application.OnException := OnProgramException;//测试注释
  //dwRunDBTimeMax := GetTickCount();//20080728 注释
  g_dwStartTick := GetTickCount();

  boServiceStarted := True;

  dwSaveDataTick := GetTickCount() + 300000{1000 * 60 * 5};
  g_StorageFileName := g_Config.sEnvirDir + '\Market_Storage\';
  ForceDirectories(g_StorageFileName);
  g_StorageFileName := g_StorageFileName + 'UserStorage.db';
  Timer1.Enabled := True;
end;

procedure TFrmMain.StopService;
var
  I, K: Integer;
  Config1: pTConfig;
begin
  try
    Config1 := @g_Config;
    Timer1.Enabled := False;
    RunTimer.Enabled := False;
    FrmIDSoc.Close;
    GateSocket.Close;
    Memo := nil;
    g_CastleManager.Free;
    FrontEngine.Terminate();
    FrontEngine.Free;
    MagicManager.Free;
    UserEngine.Free;
    RobotManage.Free;

    RunSocket.Free;

    ConnectTimer.Enabled := False;
    DBSocket.Close;
    FreeAndNil(MainLogMsgList);
    FreeAndNil(LogStringList);
    FreeAndNil(LogonCostLogList);
    ItemUnit.Free;

    g_GuildManager.Free;

    FreeAndNil(g_EventManager);//20080304
    //FreeAndNil(ServerTableList);//20090512 注释，没有地方使用ServerTableList列表
    FreeAndNil(g_DenySayMsgList);
    FreeAndNil(MiniMapList);
    FreeAndNil(g_UnbindList);
    FreeAndNil(LineNoticeList);
    FreeAndNil(HangAutoMsgList);
    FreeAndNil(NoticeList);//公告信息列表 Notice.txt
    FreeAndNil(g_UserCmdList);//自定义命令列表 20080729
    FreeAndNil(g_QuestDiaryList);

    if g_CheckItemList.Count > 0 then begin//禁止物品规则 20080729
      for I := 0 to g_CheckItemList.Count - 1 do begin
        if pTCheckItem(g_CheckItemList.Objects[I]) <> nil then Dispose(pTCheckItem(g_CheckItemList.Objects[I]));
      end;
    end;
    FreeAndNil(g_CheckItemList);

    if g_EffecItemtList.Count > 0 then begin//物品特效
      for I := 0 to g_EffecItemtList.Count - 1 do begin
        if pTEffecItem(g_EffecItemtList.Objects[I]) <> nil then Dispose(pTEffecItem(g_EffecItemtList.Objects[I]));
      end;
    end;
    FreeAndNil(g_EffecItemtList);
    if g_RefineDrumItemList <> nil then     
    if g_RefineDrumItemList.Count > 0 then begin//新合成
      for I := 0 to g_RefineDrumItemList.Count - 1 do begin
        if pTRefineDrumItemInfo(g_RefineDrumItemList.Objects[I]) <> nil then Dispose(pTRefineDrumItemInfo(g_RefineDrumItemList.Objects[I]));
      end;
    end;
    FreeAndNil(g_RefineDrumItemList);

    if g_MsgFilterList.Count > 0 then begin//消息过滤规则 20080729
      for I := 0 to g_MsgFilterList.Count - 1 do begin
        if pTFilterMsg(g_MsgFilterList.Items[I]) <> nil then Dispose(pTFilterMsg(g_MsgFilterList.Items[I]));
      end;
    end;
    FreeAndNil(g_MsgFilterList);

    if g_ShopItemList.Count > 0 then begin//商铺物品列表 20080730
      for I := 0 to g_ShopItemList.Count - 1 do begin
        if pTShopInfo(g_ShopItemList.Items[I]) <> nil then Dispose(pTShopInfo(g_ShopItemList.Items[I]));
      end;
    end;
    FreeAndNil(g_ShopItemList);

    {if BoxsList.Count > 0 then begin//20080629
      for I := 0 to BoxsList.Count - 1 do begin //20080304 释放
        if pTBoxsInfo(BoxsList.Items[I]) <> nil then Dispose(pTBoxsInfo(BoxsList.Items[I]));
      end;
    end;}
    if BoxsList.Count > 0 then begin//20100511 修改
      for I := 0 to BoxsList.Count - 1 do begin
        if TList(BoxsList.Objects[I]).Count > 0 then begin
          for K:= 0 to TList(BoxsList.Objects[I]).Count -1 do begin
            if pTBoxsInfo(TList(BoxsList.Objects[I]).Items[K]) <> nil then
              Dispose(pTBoxsInfo(TList(BoxsList.Objects[I]).Items[K]));
          end;
        end;
        TList(BoxsList.Objects[I]).Free;
      end;
    end;
    FreeAndNil(BoxsList); //20080114 宝箱

    if g_SuitItemList.Count > 0 then begin//20080629
      for I := 0 to g_SuitItemList.Count - 1 do begin //20080304 释放
        if pTSuitItem(g_SuitItemList.Items[I])<> nil then Dispose(pTSuitItem(g_SuitItemList.Items[I]));
      end;
    end;
    FreeAndNil(g_SuitItemList); //20080225 套装

    if sSellOffItemList.Count > 0 then begin//20080629
      for I := 0 to sSellOffItemList.Count - 1 do begin //元宝寄售列表 20080316
        if pTDealOffInfo(sSellOffItemList.Items[I]) <> nil then Dispose(pTDealOffInfo(sSellOffItemList.Items[I]));
      end;
    end;
    FreeAndNil(sSellOffItemList); //元宝寄售列表 20080316

    FreeAndNil(ItemEventList);
    if g_MonSayMsgList.Count > 0 then begin//20090301
      for I := 0 to g_MonSayMsgList.Count - 1 do begin
        if TList(g_MonSayMsgList.Objects[I]) <> nil then TList(g_MonSayMsgList.Objects[I]).Free;
      end;
    end;  
    FreeAndNil(g_MonSayMsgList);

    FreeAndNil(g_DisableMakeItemList);
    FreeAndNil(g_EnableMakeItemList);
    FreeAndNil(g_DisableMoveMapList);
    FreeAndNil(g_ItemNameList);
    FreeAndNil(g_DisableSendMsgList);
    FreeAndNil(g_MonDropLimitLIst);
    FreeAndNil(g_DisableTakeOffList);
    FreeAndNil(g_UnMasterList);
    FreeAndNil(g_UnForceMasterList);
    FreeAndNil(g_GameLogItemNameList);
    FreeAndNil(g_DenyIPAddrList);
    FreeAndNil(g_DenyChrNameList);
    FreeAndNil(g_DenyAccountList);
    FreeAndNil(g_NoClearMonList);
    {FreeAndNil(g_AllowSellOffItemList);//20080416 去掉拍卖功能

    g_SellOffGoodList.Free;
    g_SellOffGoldList.Free;}

    g_Storage.UnLoadBigStorageList;
    g_Storage.Free;

    if g_ItemBindIPaddr.Count > 0 then begin//20080629
      for I := 0 to g_ItemBindIPaddr.Count - 1 do begin
        if pTItemBind(g_ItemBindIPaddr.Items[I]) <> nil then Dispose(pTItemBind(g_ItemBindIPaddr.Items[I]));
      end;
    end;
    if g_ItemBindAccount.Count > 0 then begin//20080629
      for I := 0 to g_ItemBindAccount.Count - 1 do begin
        if pTItemBind(g_ItemBindAccount.Items[I])<> nil then Dispose(pTItemBind(g_ItemBindAccount.Items[I]));
      end;
    end;
    if g_ItemBindCharName.Count > 0 then begin//20080629
      for I := 0 to g_ItemBindCharName.Count - 1 do begin
        if pTItemBind(g_ItemBindCharName.Items[I]) <> nil then Dispose(pTItemBind(g_ItemBindCharName.Items[I]));
      end;
    end;
    FreeAndNil(g_ItemBindIPaddr);
    FreeAndNil(g_ItemBindAccount);
    FreeAndNil(g_ItemBindCharName);

    if g_ItemBindDieNoDropName.Count > 0 then begin//20081127
      for I := 0 to g_ItemBindDieNoDropName.Count - 1 do begin
        if pTItemBind(g_ItemBindDieNoDropName.Items[I]) <> nil then Dispose(pTItemBind(g_ItemBindDieNoDropName.Items[I]));
      end;
    end;
    FreeAndNil(g_ItemBindDieNoDropName);

    if g_MapEventListOfDropItem.Count > 0 then begin//20080629
    for I := 0 to g_MapEventListOfDropItem.Count - 1 do begin
      if pTMapEvent(g_MapEventListOfDropItem.Items[I]) <> nil then Dispose(pTMapEvent(g_MapEventListOfDropItem.Items[I]));
    end;
    end;
    FreeAndNil(g_MapEventListOfDropItem);

    if g_MapEventListOfPickUpItem.Count > 0 then begin//20080629
      for I := 0 to g_MapEventListOfPickUpItem.Count - 1 do begin
        if pTMapEvent(g_MapEventListOfPickUpItem.Items[I]) <> nil then
           Dispose(pTMapEvent(g_MapEventListOfPickUpItem.Items[I]));
      end;
    end;
    FreeAndNil(g_MapEventListOfPickUpItem);

    if g_MapEventListOfMine.Count > 0 then begin//20080629
      for I := 0 to g_MapEventListOfMine.Count - 1 do begin
        if pTMapEvent(g_MapEventListOfMine.Items[I]) <> nil then
          Dispose(pTMapEvent(g_MapEventListOfMine.Items[I]));
      end;
    end;
    FreeAndNil(g_MapEventListOfMine);

    if g_MapEventListOfWalk.Count > 0 then begin//20080629
      for I := 0 to g_MapEventListOfWalk.Count - 1 do begin
        if pTMapEvent(g_MapEventListOfWalk.Items[I]) <> nil then
          Dispose(pTMapEvent(g_MapEventListOfWalk.Items[I]));
      end;
    end;
    FreeAndNil(g_MapEventListOfWalk);

    if g_MapEventListOfRun.Count > 0 then begin//20080629
      for I := 0 to g_MapEventListOfRun.Count - 1 do begin
        if pTMapEvent(g_MapEventListOfRun.Items[I]) <> nil then
           Dispose(pTMapEvent(g_MapEventListOfRun.Items[I]));
      end;
    end;
    FreeAndNil(g_MapEventListOfRun);
    FreeAndNil(g_AICharNameList);
    FreeAndNil(g_AIHeroNameList);
    g_FindPath.Free;

    DeleteCriticalSection(LogMsgCriticalSection);
    DeleteCriticalSection(ProcessMsgCriticalSection);
    DeleteCriticalSection(ProcessHumanCriticalSection);
    DeleteCriticalSection(HumanSortCriticalSection);
    DeleteCriticalSection(Config1.UserIDSection);
    DeleteCriticalSection(UserDBSection);
    if g_DynamicVarList.Count > 0 then begin//20080629
      for I := 0 to g_DynamicVarList.Count - 1 do begin
        if pTDynamicVar(g_DynamicVarList.Items[I]) <> nil then
           Dispose(pTDynamicVar(g_DynamicVarList.Items[I]));
      end;
    end;
    FreeAndNil(g_DynamicVarList);

    if g_BindItemTypeList <> nil then begin
      if g_BindItemTypeList.Count > 0 then begin//20080629
        for I := 0 to g_BindItemTypeList.Count - 1 do begin
          if pTBindItem(g_BindItemTypeList.Items[I]) <> nil then
            Dispose(pTBindItem(g_BindItemTypeList.Items[I]));
        end;
      end;
      FreeAndNil(g_BindItemTypeList);
    end;

    FreeAndNil(g_AllowPickUpItemList);
    FreeAndNil(g_AllowAIPickUpItemList);
    FreeAndNil(g_DisableGamePointShopItemList);

    if (g_ItemDblClickList <> nil) and (g_ItemDblClickList.Count > 0) then begin//20080629
      for I := 0 to g_ItemDblClickList.Count - 1 do begin
        if pTItemEvent(g_ItemDblClickList.Items[I]) <> nil then
          Dispose(pTItemEvent(g_ItemDblClickList.Items[I]));
      end;
    end;
    FreeAndNil(g_ItemDblClickList);

    if (g_StartPointList <> nil) and (g_StartPointList.Count > 0) then begin//20080629
      for I := 0 to g_StartPointList.Count - 1 do begin
        if pTStartPoint(g_StartPointList.Objects[I]) <> nil then
           Dispose(pTStartPoint(g_StartPointList.Objects[I]));
      end;
    end;
    FreeAndNil(g_StartPointList);

    if g_AutoFindRout.Count > 0 then begin
      for I := 0 to g_AutoFindRout.Count - 1 do begin
        if pTFindRout(g_AutoFindRout.Objects[I]) <> nil then Dispose(pTFindRout(g_AutoFindRout.Objects[I]));
      end;
    end;
    FreeAndNil(g_AutoFindRout);

    if g_MakeItemList.Count > 0 then begin//20080629
      for I := 0 to g_MakeItemList.Count - 1 do begin
        TStringList(g_MakeItemList.Objects[I]).Free;
      end;
    end;
    FreeAndNil(g_MakeItemList);
    FreeAndNil(g_LimitItemList);
{$IF M2Version <> 2}
    g_DivisionManager.Free;
    if g_DominatSendList.Count > 0 then begin
      for I := 0 to g_DominatSendList.Count - 1 do begin
        if pTDominatSendPoint(g_DominatSendList.Objects[I]) <> nil then Dispose(pTDominatSendPoint(g_DominatSendList.Objects[I]));
      end;
    end;
    FreeAndNil(g_DominatSendList);
    if g_RefineItemList.Count > 0 then begin//20080629
      for I := 0 to g_RefineItemList.Count - 1 do begin //20080502
        if TList(g_RefineItemList.Objects[I]).Count > 0 then begin
          for K:=0 to TList(g_RefineItemList.Objects[I]).Count -1 do begin
            if pTRefineItemInfo(TList(g_RefineItemList.Objects[I]).Items[K]) <> nil then
              Dispose(pTRefineItemInfo(TList(g_RefineItemList.Objects[I]).Items[K]));
          end;
        end;
        TList(g_RefineItemList.Objects[I]).Free;
      end;
    end;
    FreeAndNil(g_RefineItemList);
    FreeAndNil(g_EnableArmsExchangeList);
    g_HeartSkillNameList.Free;

    if g_ArmsSortList.Count > 0 then begin//武器榜
      for I := 0 to g_ArmsSortList.Count - 1 do begin
        if pTItemLevelSort(g_ArmsSortList.Items[I]) <> nil then
          Dispose(pTItemLevelSort(g_ArmsSortList.Items[I]));
      end;
    end;
    FreeAndNil(g_ArmsSortList);

    if g_RingSortList.Count > 0 then begin//戒指榜
      for I := 0 to g_RingSortList.Count - 1 do begin
        if pTItemLevelSort(g_RingSortList.Items[I]) <> nil then
          Dispose(pTItemLevelSort(g_RingSortList.Items[I]));
      end;
    end;
    FreeAndNil(g_RingSortList);

    if g_DreSortList.Count > 0 then begin//衣甲榜
      for I := 0 to g_DreSortList.Count - 1 do begin
        if pTItemLevelSort(g_DreSortList.Items[I]) <> nil then
          Dispose(pTItemLevelSort(g_DreSortList.Items[I]));
      end;
    end;
    FreeAndNil(g_DreSortList);

    if g_ShoesSortList.Count > 0 then begin//靴子榜
      for I := 0 to g_ShoesSortList.Count - 1 do begin
        if pTItemLevelSort(g_ShoesSortList.Items[I]) <> nil then
          Dispose(pTItemLevelSort(g_ShoesSortList.Items[I]));
      end;
    end;
    FreeAndNil(g_ShoesSortList);

    if g_HelmeSortList.Count > 0 then begin//头盔榜
      for I := 0 to g_HelmeSortList.Count - 1 do begin
        if pTItemLevelSort(g_HelmeSortList.Items[I]) <> nil then
          Dispose(pTItemLevelSort(g_HelmeSortList.Items[I]));
      end;
    end;
    FreeAndNil(g_HelmeSortList);

    if g_BootsSortList.Count > 0 then begin//腰带榜
      for I := 0 to g_BootsSortList.Count - 1 do begin
        if pTItemLevelSort(g_BootsSortList.Items[I]) <> nil then
          Dispose(pTItemLevelSort(g_BootsSortList.Items[I]));
      end;
    end;
    FreeAndNil(g_BootsSortList);

    if g_NecklaceSortList.Count > 0 then begin//项链榜
      for I := 0 to g_NecklaceSortList.Count - 1 do begin
        if pTItemLevelSort(g_NecklaceSortList.Items[I]) <> nil then
          Dispose(pTItemLevelSort(g_NecklaceSortList.Items[I]));
      end;
    end;
    FreeAndNil(g_NecklaceSortList);

    if g_MedalSortList.Count > 0 then begin//勋章榜
      for I := 0 to g_MedalSortList.Count - 1 do begin
        if pTItemLevelSort(g_MedalSortList.Items[I]) <> nil then
          Dispose(pTItemLevelSort(g_MedalSortList.Items[I]));
      end;
    end;
    FreeAndNil(g_MedalSortList);

    if g_BraceletSortList.Count > 0 then begin//护腕榜
      for I := 0 to g_BraceletSortList.Count - 1 do begin
        if pTItemLevelSort(g_BraceletSortList.Items[I]) <> nil then
          Dispose(pTItemLevelSort(g_BraceletSortList.Items[I]));
      end;
    end;
    FreeAndNil(g_BraceletSortList);

    if g_ZhuLiSortList.Count > 0 then begin//斗笠面巾榜
      for I := 0 to g_ZhuLiSortList.Count - 1 do begin
        if pTItemLevelSort(g_ZhuLiSortList.Items[I]) <> nil then
          Dispose(pTItemLevelSort(g_ZhuLiSortList.Items[I]));
      end;
    end;
    FreeAndNil(g_ZhuLiSortList);

    if g_DigJewelItemList1.Count > 0 then begin
      for I := 0 to g_DigJewelItemList1.Count - 1 do begin
        if pTDigJewelItemInfo(g_DigJewelItemList1.Items[I])<> nil then Dispose(pTDigJewelItemInfo(g_DigJewelItemList1.Items[I]));
      end;
    end;
    FreeAndNil(g_DigJewelItemList1);//挖宝物品类型1 20100905

    if g_DigJewelItemList2.Count > 0 then begin
      for I := 0 to g_DigJewelItemList2.Count - 1 do begin
        if pTDigJewelItemInfo(g_DigJewelItemList2.Items[I])<> nil then Dispose(pTDigJewelItemInfo(g_DigJewelItemList2.Items[I]));
      end;
    end;
    FreeAndNil(g_DigJewelItemList2);//挖宝物品类型2 20100905

    if g_DigJewelItemList3.Count > 0 then begin
      for I := 0 to g_DigJewelItemList3.Count - 1 do begin
        if pTDigJewelItemInfo(g_DigJewelItemList3.Items[I])<> nil then Dispose(pTDigJewelItemInfo(g_DigJewelItemList3.Items[I]));
      end;
    end;
    FreeAndNil(g_DigJewelItemList3);//挖宝物品类型3 20100905

    if g_DigJewelItemList4.Count > 0 then begin
      for I := 0 to g_DigJewelItemList4.Count - 1 do begin
        if pTDigJewelItemInfo(g_DigJewelItemList4.Items[I])<> nil then Dispose(pTDigJewelItemInfo(g_DigJewelItemList4.Items[I]));
      end;
    end;
    FreeAndNil(g_DigJewelItemList4);//挖宝物品类型4 20100905
{$IFEND}
    FrmDB.Free;//20080304
    PlugInEngine.Free;//必须在zPlugOfEngine前释放,不然DLL报错. 20080303
    zPlugOfEngine.Free;// 20071106
    g_MapManager.Free;
    boServiceStarted := False;
  except
    {on E: Exception do begin  //测试时使用
      ShowMessage('错误信息:' + E.Message);
      Exit;
      raise;
    end;}
  end;
end;

procedure TFrmMain.MENU_HELP_ABOUTClick(Sender: TObject);
begin
  if not Assigned(FrmAbout) then begin//20090114
    FrmAbout := TFrmAbout.Create(Owner);
    try
      FrmAbout.Open;
    finally
      FrmAbout.Free;
    end;
  end;
end;

procedure TFrmMain.MENU_HELP_GETBUGINFOClick(Sender: TObject);
var
  MemoryStatus : TMemoryStatus;
  Tick : DWord;
  Log : TStringList;
begin
  MemoryStatus.dwLength := SizeOf(MemoryStatus);
  FillChar(MemoryStatus, SizeOf(MemoryStatus), 0);
  GlobalMemoryStatus(MemoryStatus);
  Log := TStringList.Create;
  with MemoryStatus do
  Log.Add(Format('MemoryStatus:-------------------------------------------' + sLineBreak +
                                                'dwMemoryLoad: %d;' + sLineBreak +
                                                'dwTotalPhys: %d;' + sLineBreak +
                                                'dwAvailPhys: %d;' + sLineBreak +
                                                'dwTotalPageFile: %d;' + sLineBreak +
                                                'dwAvailPageFile: %d;' + sLineBreak +
                                                'dwTotalVirtual: %d;' + sLineBreak +
                                                'dwAvailVirtual: %d;'+ sLineBreak,
                                                [dwMemoryLoad,
                                                 dwTotalPhys,
                                                 dwAvailPhys,
                                                 dwTotalPageFile,
                                                 dwAvailPageFile,
                                                 dwTotalVirtual,
                                                 dwAvailVirtual]));
  if UserEngine <> nil then with UserEngine do begin
    Log.Add(Format('UserEngine:-------------------------------------------' + sLineBreak +
                                                'AIPlayCount: %d;' + sLineBreak +
                                                'AutoAddExpPlayCount: %d;' + sLineBreak +
                                                'PlayObjectCount: %d;' + sLineBreak +
                                                'OnlinePlayObject: %d;' + sLineBreak +
                                                'MonsterCount: %d;' + sLineBreak +
                                                'TBaseObjectCount: %d;' + sLineBreak +
                                                'LoadPlayCount: %d;' + sLineBreak,
                                                [AIPlayCount,
                                                 AutoAddExpPlayCount,
                                                 PlayObjectCount,
                                                 OnlinePlayObject,
                                                 MonsterCount,
                                                 TBaseObjectCount,
                                                 LoadPlayCount]));
    if m_PlayObjectFreeList <> nil then
      Log.Add(Format('WaitFreePlayObject:%d',[m_PlayObjectFreeList.Count]));
    //CheckBlocksOnShutdown(True);
  end;
  Tick := (GetTickCount() - g_dwStartTick) div 1000;
  Log.Add('M2Run:' + IntToStr(Tick div 3600) + ':' + IntToStr((Tick div 60) mod 60) + ':' + IntToStr(Tick mod 60));
  Log.Add('SystemRun: ' + IntToStr(GetTickCount div (1000*60)) + '.分');
  Log.SaveToFile('.\Bug.txt');
  Log.Free;
  ShowMessage('获取成功.');
end;

procedure TFrmMain.DBSocketConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  MainOutMessage('数据库服务器(' + Socket.RemoteAddress + ':' + IntToStr(Socket.RemotePort) + ')连接成功...');
  //g_nSaveRcdErrorCount := 0;//20090323 注释
end;

procedure TFrmMain.MENU_OPTION_SERVERCONFIGClick(Sender: TObject);
begin
  if not Assigned(FrmServerValue) then begin//20090114
    FrmServerValue := TFrmServerValue.Create(Owner);
    try
      FrmServerValue.Top := Self.Top + 20;
      FrmServerValue.Left := Self.Left;
      FrmServerValue.AdjuestServerConfig();
    finally
      FrmServerValue.Free;
    end;
  end;
end;

procedure TFrmMain.MENU_OPTION_GENERALClick(Sender: TObject);
begin
  if not Assigned(frmGeneralConfig) then begin//20090114
    frmGeneralConfig := TfrmGeneralConfig.Create(Owner);
    try
      frmGeneralConfig.Top := Self.Top + 20;
      frmGeneralConfig.Left := Self.Left;
      frmGeneralConfig.Open();
    finally
      frmGeneralConfig.Free;
    end;
  end;
  Caption := g_Config.sServerName + ' [www.3KM2.com]';
end;

procedure TFrmMain.MENU_OPTION_GAMEClick(Sender: TObject);
begin
  if not Assigned(frmGameConfig) then begin//20090105
    frmGameConfig := TfrmGameConfig.Create(Owner);
    try
      frmGameConfig.Top := Self.Top + 20;
      frmGameConfig.Left := Self.Left;
      frmGameConfig.Open;
    finally
      frmGameConfig.Free;
    end;
  end;
end;

procedure TFrmMain.MENU_OPTION_FUNCTIONClick(Sender: TObject);
begin
  if not Assigned(frmFunctionConfig) then begin//20090114
    frmFunctionConfig := TfrmFunctionConfig.Create(Owner);
    try
      frmFunctionConfig.Top := Self.Top + 20;
      frmFunctionConfig.Left := Self.Left;
      frmFunctionConfig.Open;
    finally
      frmFunctionConfig.Free;
    end;
  end;
end;

procedure TFrmMain.G1Click(Sender: TObject);
begin
  if not Assigned(frmGameCmd) then begin//20090114
    frmGameCmd := TfrmGameCmd.Create(Owner);
    try
      frmGameCmd.Top := Self.Top + 20;
      frmGameCmd.Left := Self.Left;
      frmGameCmd.Open;
    finally
      frmGameCmd.Free;
    end;
  end;
end;

procedure TFrmMain.MENU_OPTION_MONSTERClick(Sender: TObject);
begin
  if not Assigned(frmMonsterConfig) then begin//20090114
    frmMonsterConfig := TfrmMonsterConfig.Create(Owner);
    try
      frmMonsterConfig.Top := Self.Top + 20;
      frmMonsterConfig.Left := Self.Left;
      frmMonsterConfig.Open;
    finally
      frmMonsterConfig.Free;
    end;
  end;
end;

procedure TFrmMain.MENU_CONTROL_RELOAD_MONSTERSAYClick(Sender: TObject);
begin
  UserEngine.ClearMonSayMsg();
  LoadMonSayMsg();
  MainOutMessage('重新加载怪物说话配置完成...');
end;

procedure TFrmMain.MENU_CONTROL_RELOAD_DISABLEMAKEClick(Sender: TObject);
begin
  LoadDisableTakeOffList();
  LoadDisableMakeItem();
  LoadEnableMakeItem();
  LoadLimitItemList();//读取限时物品列表
  {$IF M2Version <> 2}
  LoadEnableArmsExchangeItem();//读取允许兑换卷轴碎片列表
  {$IFEND}
  LoadDisableMoveMap();
  ItemUnit.LoadCustomItemName();
  LoadDisableSendMsgList();
  LoadGameLogItemNameList();
  LoadItemBindIPaddr();
  LoadItemBindAccount();
  LoadItemBindCharName();
  LoadItemBindDieNoDropName();//读取人物装备死亡不爆列表 20081127
  LoadUnMasterList();
  LoadUnForceMasterList();
  LoadDenyIPAddrList();
  LoadDenyAccountList();
  LoadDenyChrNameList();//加载禁止登录人物列表
  LoadNoClearMonList();
  //LoadAllowSellOffItemList();//20080416 去掉拍卖功能
  FrmDB.LoadAdminList();
  FrmDB.LoadAutoFindRout();//加载寻路怪行走目标点配置
  LoadAICharNameList();
  LoadAIHeroNameList();  
  MainOutMessage('重新加载列表配置完成...');
end;

procedure TFrmMain.MENU_CONTROL_RELOAD_STARTPOINTClick(Sender: TObject);
begin
  FrmDB.LoadStartPoint();
  MainOutMessage('重新地图安全区列表完成...');
end;

procedure TFrmMain.MENU_CONTROL_GATE_OPENClick(Sender: TObject);
resourcestring
  sGatePortOpen = '游戏网关端口(%s:%d)已打开...';
begin
  if not GateSocket.Active then begin
    GateSocket.Active := True;
    MainOutMessage(Format(sGatePortOpen, [GateSocket.Address, GateSocket.Port]));
  end;
end;

procedure TFrmMain.MENU_CONTROL_GATE_CLOSEClick(Sender: TObject);
begin
  CloseGateSocket();
end;

procedure TFrmMain.CloseGateSocket;
var
  I: Integer;
resourcestring
  sGatePortClose = '游戏网关端口(%s:%d)已关闭...';
begin
  if GateSocket.Active then begin
    if GateSocket.Socket.ActiveConnections > 0 then begin//20080629
      for I := 0 to GateSocket.Socket.ActiveConnections - 1 do begin
        GateSocket.Socket.Connections[I].Close;
      end;
    end;
    GateSocket.Active := False;
    MainOutMessage(Format(sGatePortClose, [GateSocket.Address, GateSocket.Port]));
  end;
end;

procedure TFrmMain.MENU_CONTROLClick(Sender: TObject);
begin
  if GateSocket.Active then begin
    MENU_CONTROL_GATE_OPEN.Enabled := False;
    MENU_CONTROL_GATE_CLOSE.Enabled := True;
  end else begin
    MENU_CONTROL_GATE_OPEN.Enabled := True;
    MENU_CONTROL_GATE_CLOSE.Enabled := False;
  end;
end;

procedure UserEngineProcess(Config: pTConfig; ThreadInfo: pTThreadInfo);
var
  nRunTime: Integer;
  dwRunTick: LongWord;
begin
  l_dwRunTimeTick := 0;
  dwRunTick := GetTickCount();
  ThreadInfo.dwRunTick := dwRunTick;
  while not ThreadInfo.boTerminaled do begin
    nRunTime := GetTickCount - ThreadInfo.dwRunTick;
    if ThreadInfo.nRunTime < nRunTime then ThreadInfo.nRunTime := nRunTime;
    if ThreadInfo.nMaxRunTime < nRunTime then ThreadInfo.nMaxRunTime := nRunTime;
    if GetTickCount - dwRunTick >= 1000 then begin
      dwRunTick := GetTickCount();
      if ThreadInfo.nRunTime > 0 then Dec(ThreadInfo.nRunTime);
    end;

    ThreadInfo.dwRunTick := GetTickCount();
    ThreadInfo.boActived := True;
    ThreadInfo.nRunFlag := 125;
    if Config.boThreadRun then ProcessGameRun();
    Sleep(1);
  end;
end;

procedure UserEngineThread(ThreadInfo: pTThreadInfo); stdcall;
var
  nErrorCount: Integer;
resourcestring
  sExceptionMsg = '{%s} UserEngineThread ErrorCount = %d';
begin
  nErrorCount := 0;
  while True do begin
    try
      UserEngineProcess(ThreadInfo.Config, ThreadInfo);
      Break;
    except
      Inc(nErrorCount);
      if nErrorCount > 10 then Break;
      MainOutMessage(Format(sExceptionMsg, [g_sExceptionVer,nErrorCount]));
    end;
  end;
  ExitThread(0);
end;

procedure ProcessGameRun();
var
  I: Integer;
  nCode: Byte;//20091125 增加
begin
  EnterCriticalSection(ProcessHumanCriticalSection);
  nCode:= 0;
  try
    Try
      UserEngine.PrcocessData;
      nCode:= 1;
      g_EventManager.Run;
      nCode:= 2;
      RobotManage.Run;  
      nCode:= 3;
      g_MapManager.Run;//20110327 增加
      if GetTickCount - l_dwRunTimeTick > 10000 then begin
        l_dwRunTimeTick := GetTickCount();
        nCode:= 4;
        g_GuildManager.Run;
        nCode:= 5;
        g_CastleManager.Run;
        {$IF M2Version <> 2}
        g_DivisionManager.Run;
        {$IFEND}
        nCode:= 6;
        g_DenySayMsgList.Lock;
        try
          for I := g_DenySayMsgList.Count - 1 downto 0 do begin
            if g_DenySayMsgList.Count <= 0 then Break;
            nCode:= 8;
            if GetTickCount > LongWord(g_DenySayMsgList.Objects[I]) then begin
              nCode:= 9;
              g_DenySayMsgList.Delete(I);
            end;
          end;
        finally
          g_DenySayMsgList.UnLock;
        end;
      end;
    except
      on E: Exception do begin
        MainOutMessage(Format('{%s} ProcessGameRun Code:%d',[g_sExceptionVer, nCode]));
      end;
    end;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
end;

procedure TFrmMain.MENU_VIEW_GATEClick(Sender: TObject);
begin
  {MENU_VIEW_GATE.Checked := not MENU_VIEW_GATE.Checked;
  GridGate.Visible := MENU_VIEW_GATE.Checked; }
end;

procedure TFrmMain.MENU_VIEW_SESSIONClick(Sender: TObject);
begin
  if not Assigned(frmViewSession) then begin//20090114
    frmViewSession := TfrmViewSession.Create(Owner);
    try
      frmViewSession.Top := Top + 20;
      frmViewSession.Left := Left;
      frmViewSession.Open();
    finally
      frmViewSession.Free;
    end;
  end;
end;

procedure TFrmMain.MENU_VIEW_ONLINEHUMANClick(Sender: TObject);
begin
  if not Assigned(frmViewOnlineHuman) then begin//20090114
    frmViewOnlineHuman := TfrmViewOnlineHuman.Create(Owner);
    try
      frmViewOnlineHuman.Top := Top + 20;
      frmViewOnlineHuman.Left := Left;
      frmViewOnlineHuman.Open();
    finally
      if frmViewOnlineHuman <> nil then
      frmViewOnlineHuman.Free;
    end;
  end;
end;

procedure TFrmMain.MENU_VIEW_LEVELClick(Sender: TObject);
begin
  if not Assigned(frmViewLevel) then begin//20090114
    frmViewLevel := TfrmViewLevel.Create(Owner);
    try
      frmViewLevel.Top := Top + 20;
      frmViewLevel.Left := Left;
      frmViewLevel.Open();
    finally
      frmViewLevel.Free;
    end;
  end;
end;

procedure TFrmMain.MENU_VIEW_LISTClick(Sender: TObject);
begin
  if not Assigned(frmViewList) then begin//20090114
    frmViewList := TfrmViewList.Create(Owner);
    try
      frmViewList.Top := Top + 20;
      frmViewList.Left := Left;
      frmViewList.Open();
    finally
      frmViewList.Free;
    end;
  end;
end;

procedure TFrmMain.MENU_MANAGE_ONLINEMSGClick(Sender: TObject);
begin
  if not Assigned(frmOnlineMsg) then begin//20090114
    frmOnlineMsg := TfrmOnlineMsg.Create(Owner);
    try
      frmOnlineMsg.Top := Top + 20;
      frmOnlineMsg.Left := Left;
      frmOnlineMsg.Open();
    finally
      frmOnlineMsg.Free;
    end;
  end;
end;

procedure TFrmMain.MENU_MANAGE_PLUGClick(Sender: TObject);
begin
  if not Assigned(ftmPlugInManage) then begin//20090114
    ftmPlugInManage := TftmPlugInManage.Create(Owner);
    try
      ftmPlugInManage.Top := Top + 20;
      ftmPlugInManage.Left := Left;
      ftmPlugInManage.Open();
    finally
      ftmPlugInManage.Free;
    end;
  end;
end;

procedure TFrmMain.SetMenu;
begin
  FrmMain.Menu := MainMenu;
end;

procedure TFrmMain.MENU_VIEW_KERNELINFOClick(Sender: TObject);
begin
  if not Assigned(frmViewKernelInfo) then begin//20090114
    frmViewKernelInfo := TfrmViewKernelInfo.Create(Owner);
    try
      frmViewKernelInfo.Top := Top + 20;
      frmViewKernelInfo.Left := Left;
      frmViewKernelInfo.Open();
    finally
      frmViewKernelInfo.Free;
    end;
  end;
end;

procedure TFrmMain.MENU_TOOLS_MERCHANTClick(Sender: TObject);
begin
  if not Assigned(frmConfigMerchant) then begin//20090114
    frmConfigMerchant := TfrmConfigMerchant.Create(Owner);
    try
      frmConfigMerchant.Top := Top + 20;
      frmConfigMerchant.Left := Left;
      frmConfigMerchant.Open();
    finally
      frmConfigMerchant.Free;
    end;
  end;
end;

procedure TFrmMain.MENU_OPTION_ITEMFUNCClick(Sender: TObject);
begin
  if not Assigned(frmItemSet) then begin//20090114
    frmItemSet := TfrmItemSet.Create(Owner);
    try
      frmItemSet.Top := Top + 20;
      frmItemSet.Left := Left;
      frmItemSet.Open();
    finally
      frmItemSet.Free;
    end;
  end;
end;

procedure TFrmMain.ClearMemoLog;
begin
  if Application.MessageBox('是否确定清除日志信息！', '提示信息', MB_YESNO + MB_ICONQUESTION) = mrYes then begin
    MemoLog.Clear;
  end;
end;

procedure TFrmMain.MENU_TOOLS_MONGENClick(Sender: TObject);
begin
  if not Assigned(frmConfigMonGen) then begin//20090114
    frmConfigMonGen := TfrmConfigMonGen.Create(Owner);
    try
      frmConfigMonGen.Top := Top + 20;
      frmConfigMonGen.Left := Left;
      frmConfigMonGen.Open();
    finally
      frmConfigMonGen.Free;
    end;
  end;
end;

procedure TFrmMain.MyMessage(var MsgData: TWmCopyData); //响应 启动器的关闭消息
var
  sData: string;
  wIdent: Word;
begin
  wIdent := HiWord(MsgData.From);
  sData := StrPas(MsgData.CopyDataStruct^.lpData);
  case wIdent of
    GS_QUIT: begin
        g_boExitServer := True;
        CloseGateSocket();
        g_Config.boKickAllUser := True;
        UserEngine.m_M2AutoAddPlay.Clear;//清空挂机列表 20090823
        CloseTimer.Enabled := True;
      end;
    1: ;
    2: ;
    3: ;
  end;
end;

procedure TFrmMain.MENU_TOOLS_IPSEARCHClick(Sender: TObject);
var
  sIPaddr: string;
begin
  try
    sIPaddr := '192.168.0.1';
    //sIPaddr := InputBox('IP所在地区查询', '输入IP地址:', '192.168.0.1');
    if not InputQuery('IP所在地区查询', '输入IP地址:', sIPaddr) then Exit;
    if not IsIPaddr(sIPaddr) then begin
      Application.MessageBox('输入的IP地址格式不正确！', '错误信息', MB_OK + MB_ICONERROR);
      Exit;
    end;
    MemoLog.Lines.Add(Format('%s:%s', [sIPaddr, GetIPLocal(sIPaddr)]));
  except
    MemoLog.Lines.Add(Format('%s:%s', [sIPaddr, GetIPLocal(sIPaddr)]));
  end;
end;

procedure TFrmMain.MENU_MANAGE_CASTLEClick(Sender: TObject);
begin
  if not Assigned(frmCastleManage) then begin//20090114
    frmCastleManage := TfrmCastleManage.Create(Owner);
    try
      frmCastleManage.Top := Top + 20;
      frmCastleManage.Left := Left;
      frmCastleManage.Open();
    finally
      frmCastleManage.Free;
    end;
  end;
end;

procedure TFrmMain.MENU_HELP_REGKEYClick(Sender: TObject);
begin
{  FrmRegister := TFrmRegister.Create(Owner); //20080329 去掉注册窗口
  FrmRegister.Top := Top + 30;
  FrmRegister.Left := Left;
  FrmRegister.Open();
  FrmRegister.Free; }
end;

procedure TFrmMain.QFunctionNPCClick(Sender: TObject);
begin
  if g_FunctionNPC <> nil then begin
    g_FunctionNPC.ClearScript;
    g_FunctionNPC.LoadNpcScript;
    MainOutMessage('QFunction 脚本加载完成...');
  end;
end;

procedure TFrmMain.QManageNPCClick(Sender: TObject);
begin
  if g_ManageNPC <> nil then begin
    g_ManageNPC.ClearScript();
    g_ManageNPC.LoadNpcScript();
    MainOutMessage('重新加载登陆脚本完成...');
  end;
end;

procedure TFrmMain.RobotManageNPCClick(Sender: TObject);
begin
  if g_RobotNPC <> nil then begin
    RobotManage.RELOADROBOT();
    g_RobotNPC.ClearScript();
    g_RobotNPC.LoadNpcScript();
    MainOutMessage('重新加载机器人脚本完成...');
  end;
end;

procedure TFrmMain.MonItemsClick(Sender: TObject);
var
  I: Integer;
  Monster: pTMonInfo;
begin
  try
    if UserEngine.MonsterList.Count > 0 then begin//20080629
      for I := 0 to UserEngine.MonsterList.Count - 1 do begin
        Monster := UserEngine.MonsterList.Items[I];
        if Monster <> nil then begin//20090406
          FrmDB.LoadMonitems(Monster.sName, Monster.ItemList);
        end;
      end;
    end;
    MainOutMessage('怪物爆物品列表重加载完成...');
  except
    MainOutMessage('怪物爆物品列表重加载失败！');
  end;
end;

procedure TFrmMain.MENU_OPTION_HEROClick(Sender: TObject);
begin
  if not Assigned(frmHeroConfig) then begin//20090114
    frmHeroConfig := TfrmHeroConfig.Create(Owner);
    try
      frmHeroConfig.Top := Top;
      frmHeroConfig.Left := Left;
      frmHeroConfig.Open();
    finally
      frmHeroConfig.Free;
    end;
  end;
end;

procedure TFrmMain.N3Click(Sender: TObject);
begin
  FrmDB.LoadBoxsList();//重新加载宝箱列表 20080115
  MainOutMessage('重新加载宝箱配置完成...');
end;

procedure TFrmMain.N1Click(Sender: TObject);
begin
  if not Assigned(frmViewList2) then begin//20090114
    frmViewList2 := TfrmViewList2.Create(Owner);
    try
      frmViewList2.Top := Top + 20;
      frmViewList2.Left := Left;
      frmViewList2.Open();
    finally
      frmViewList2.Free;
    end;
  end;
end;

//设置窗体类名 20080412
procedure TFrmMain.CreateParams(var Params:TCreateParams);
begin
  Inherited CreateParams(Params);
  Params.WinClassName:='www.3KM2.com';
end;

procedure TFrmMain.N6Click(Sender: TObject);
begin
  if LoadLineNotice(g_Config.sNoticeDir + 'LineNotice.txt') then begin
    LoadNotice(g_Config.sNoticeDir + 'Notice.txt');//读取公告 Notice.txt
    LoadHangAutoMsg(g_Config.sNoticeDir + 'HangAutoMsg.txt');//读取挂机自动回复文件 20100908
    MainOutMessage('重新加载公告提示信息完成...');
  end;
end;

procedure TFrmMain.N7Click(Sender: TObject);
begin
{$IF M2Version <> 2}
  FrmDB.LoadRefineItem;
  MainOutMessage('重新加载淬炼配置信息完成...');
  FrmDB.LoadRefineDrumItemList;
  MainOutMessage('重新加载军鼓淬炼配置信息完成...');
{$IFEND}
end;

procedure TFrmMain.NPC1Click(Sender: TObject);
begin
  FrmDB.ReLoadMerchants();
  //UserEngine.ReloadMerchantList();//20100408 注释, FrmDB.ReLoadMerchants实现加载脚本，此过程可不使用
  MainOutMessage('重新加载交易NPC配置信息完成...');
end;

procedure TFrmMain.NPC2Click(Sender: TObject);
begin
  FrmDB.ReLoadNpc;
  //UserEngine.ReloadNpcList();//20100408 注释, FrmDB.ReLoadNpc实现加载脚本，此过程可不使用
  MainOutMessage('重新加载管理NPC配置信息完成...');
end;

procedure TFrmMain.Timer2Timer(Sender: TObject);
begin
  Timer2.Enabled:= False;
  if g_boMinimize then Application.Minimize;//启动完成后最小化
end;

procedure TFrmMain.S1Click(Sender: TObject);
begin
  g_CastleManager.ReLoadCastle;
  MainOutMessage('重新加载城堡配置信息完成...');
end;

procedure TFrmMain.G2Click(Sender: TObject);
begin
  if not Assigned(frmGuildManage) then begin//20090115
    frmGuildManage := TfrmGuildManage.Create(Owner);
    try
      frmGuildManage.Top := Top + 20;
      frmGuildManage.Left := Left;
      frmGuildManage.Open();
    finally
      frmGuildManage.Free;
    end;
  end;
end;

procedure TFrmMain.N4Click(Sender: TObject);
begin
  if DBSocket.Active then begin
    if M2AutoAddExpPlay then //M2自动把离线人物重新离线挂机 20090319
      MainOutMessage('人物自动挂机文件加载完毕...');
  end;
end;

procedure TFrmMain.N5Click(Sender: TObject);
begin
  if not Assigned(frmDivisionManage) then begin
    frmDivisionManage := TfrmDivisionManage.Create(Owner);
    try
      frmDivisionManage.Top := Top + 20;
      frmDivisionManage.Left := Left;
      frmDivisionManage.Open();
    finally
      frmDivisionManage.Free;
    end;
  end;
end;

procedure TFrmMain.QBatter1Click(Sender: TObject);
begin
{$IF M2Version = 1}
  if g_BatterNPC <> nil then begin
    g_BatterNPC.ClearScript;
    g_BatterNPC.LoadNpcScript;
    MainOutMessage('QBatter 脚本加载完成...');
  end;
{$IFEND}
end;

procedure TFrmMain.N8Click(Sender: TObject);
var
  ExtStatus: Integer;
begin
{$IF UserMode1 = 2}
  if WLRegGetStatus(ExtStatus) = {0}wlIsRegistered then begin//检查程序是否注册 注册才可以打开窗口
    if not Assigned(FrmRegister) then begin
      FrmRegister := TFrmRegister.Create(Owner);
      try
        FrmRegister.Top := Top + 30;
        FrmRegister.Left := Left;
        FrmRegister.Open();
      finally
        FrmRegister.Free;
      end;
    end;
  end else begin
    asm //关闭程序
      MOV FS:[0],0;
      MOV DS:[0],EAX;
    end;
  end;
{$IFEND}
end;

procedure TFrmMain.N9Click(Sender: TObject);
begin
  {$IF M2Version <> 2}
  FrmDB.LoadHumTitleDB();
  MainOutMessage('重新加载称号数据库完成...');
  {$IFEND}
end;

procedure TFrmMain.QMission1Click(Sender: TObject);
begin
  {$IF M2Version <> 2}
  if g_MissionNPC <> nil then begin
    g_MissionNPC.ClearScript;
    g_MissionNPC.LoadNpcScript;
    MainOutMessage('QMission 脚本加载完成...');
  end;
  {$IFEND}
end;

initialization
  begin
    AddToProcTable(@ChangeCaptionText, Base64DecodeStr('Q2hhbmdlQ2FwdGlvblRleHQ=') {'ChangeCaptionText'},0); //加入函数列表
    nStartModule := AddToPulgProcTable(Base64DecodeStr('U3RhcnRNb2R1bGU='), 1); //StartModule  20071106
{$IF UserMode1 = 1}
    nGetRegisterName := AddToPulgProcTable(Base64DecodeStr('R2V0UmVnaXN0ZXJOYW1l'),3); //GetRegisterName 20080630(注册)
    nStartRegister := AddToPulgProcTable(Base64DecodeStr('UmVnaXN0ZXJMaWNlbnNl'),4); //StartRegister  20080630(注册)
{$IFEND}
    nGetDateIP := AddToPulgProcTable(Base64DecodeStr('R2V0RGF0ZUlQ'{'GetDateIP'}), 6); //脚本解密函数,SystemModule.dll输出 20080217
    nGetProductAddress := AddToPulgProcTable(Base64DecodeStr('R2V0UHJvZHVjdEFkZHJlc3M='{'GetProductAddress'}), 8);
    nGetSysDate := AddToPulgProcTable(Base64DecodeStr('R2V0U3lzRGF0ZQ=='{'GetSysDate'}), 9); //SystemModule.dll输出函数，检查是否为3K的插件 20081203
    nGetHintInfAddress := AddToPulgProcTable(Base64DecodeStr('R2V0SGludEluZkFkZHJlc3M='{'GetHintInfAddress'}), 10);
  end;

finalization

end.

