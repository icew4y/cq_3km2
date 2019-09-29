unit FrnEngn;

interface

uses
  Windows, Classes, SysUtils, Grobal2, SDK;
type
  TFrontEngine = class(TThread)
    m_UserCriticalSection: TRTLCriticalSection;
    m_LoadRcdList: TList;
    m_SaveRcdList: TList;
    m_ChangeGoldList: TList;
    m_dwGetGameTimeTick: LongWord;
  private
    m_LoadRcdTempList: TList;
    m_SaveRcdTempList: TList;
    procedure GetGameTime();
    procedure ProcessGameDate();
    function LoadHumFromDB(LoadUser: pTLoadDBInfo; var boReTry: Boolean): Boolean;
    function ChangeUserGoldInDB(GoldChangeInfo: pTGoldChangeInfo): Boolean;
    procedure Run();
    { Private declarations }
  protected
    procedure Execute; override;
  public
    constructor Create(CreateSuspended: Boolean);
    destructor Destroy; override;
    function SaveListCount(): Integer;
    function IsIdle(): Boolean;
    function IsFull(): Boolean;
    procedure DeleteHuman(nGateIndex, nSocket: Integer);
    function InSaveRcdList(sAccount, sChrName: string): Boolean;
    procedure AddChangeGoldList(sGameMasterName, sGetGoldUserName: string; nGold: Integer);
    procedure AddToLoadRcdList(sAccount, sChrName, sIPaddr: string; boFlag: Boolean; nSessionID: Integer; dwHCode, nPayMent, nPayMode, nSoftVersionDate, nSocket, nGSocketIdx, nGateIdx: Integer; boM2: boolean; nRandomKey: Word);
    procedure AddToLoadHeroRcdList(sCharName, sMsg: string; PlayObject: TObject; btLoadType: Byte; boIsNewHero: boolean; nJob: Byte);
    function UpDataSaveRcdList(SaveRcd: pTSaveRcd): Boolean;
    function GetSaveRcd(sAccount, sCharName: string): pTSaveRcd;
  end;

implementation
uses M2Share, RunDB, ObjBase, HUtil32;


{ TFrontEngine }

constructor TFrontEngine.Create(CreateSuspended: Boolean);
begin
  inherited;
  InitializeCriticalSection(m_UserCriticalSection);
  m_LoadRcdList := TList.Create;
  m_SaveRcdList := TList.Create;
  m_ChangeGoldList := TList.Create;
  m_LoadRcdTempList := TList.Create;
  m_SaveRcdTempList := TList.Create;
  //FreeOnTerminate:=True;
  //AddToProcTable(@TFrontEngine.ProcessGameDate, 'TFrontEngine.ProcessGameDatea');
end;

destructor TFrontEngine.Destroy;
begin
  m_LoadRcdList.Free;
  m_SaveRcdList.Free;
  m_ChangeGoldList.Free;
  m_LoadRcdTempList.Free;
  m_SaveRcdTempList.Free;
  DeleteCriticalSection(m_UserCriticalSection);
  inherited;
end;

procedure TFrontEngine.Execute;
begin
  while not Terminated do begin
    try
      Run();
    except
      MainOutMessage(format('{%s} TFrontEngine::Execute',[g_sExceptionVer]));
    end;
    Sleep(1);
  end;
end;

procedure TFrontEngine.GetGameTime;
var
  Hour, Min, Sec, MSec: Word;
begin
  DecodeTime(Time, Hour, Min, Sec, MSec);
  case Hour of
    5, 6, 7, 8, 9, 10, 16, 17, 18, 19, 20, 21, 22: g_nGameTime := 1;//白天
    11, 23: g_nGameTime := 2;//日落
    4, 15: g_nGameTime := 0;//日出
    0, 1, 2, 3, 12, 13, 14: g_nGameTime := 3;//夜晚
  end;
end;

function TFrontEngine.IsIdle: Boolean;
begin
  Result := False;
  EnterCriticalSection(m_UserCriticalSection);
  try
    if m_SaveRcdList.Count = 0 then Result := True;
  finally
    LeaveCriticalSection(m_UserCriticalSection);
  end;
end;

function TFrontEngine.SaveListCount: Integer;
begin
  Result := 0;
  EnterCriticalSection(m_UserCriticalSection);
  try
    Result := m_SaveRcdList.Count;
  finally
    LeaveCriticalSection(m_UserCriticalSection);
  end;
end;

procedure TFrontEngine.ProcessGameDate;
var
  I: Integer;
  II: Integer;
  TempList: TList;
  ChangeGoldList: TList;
  LoadDBInfo: pTLoadDBInfo;
  SaveRcd: pTSaveRcd;
  GoldChangeInfo: pTGoldChangeInfo;
  boReTryLoadDB: Boolean;
  boSaveRcd: Boolean;
  nCode: Byte;
resourcestring
  sExceptionMsg = '{%s} TFrontEngine::ProcessGameDate Code:%d';
  //sSaveExceptionMsg = '数据库服务器出现异常，请重新启动数据库服务器(DBServer.exe)！！！';
begin
  nCode := 0;
  try
    ChangeGoldList := nil;
    nCode := 17;
    EnterCriticalSection(m_UserCriticalSection);
    try
      nCode := 44;
      if m_SaveRcdList.Count > 0 then begin//20081008
        nCode := 45;
        for I := 0 to m_SaveRcdList.Count - 1 do begin
          nCode := 46;
          if m_SaveRcdList.Items[I] <> nil then begin//20090502
            nCode := 47;
            try//20100203 增加
              m_SaveRcdTempList.Add(m_SaveRcdList.Items[I]);//异常？
            except
            end;
          end;
        end;
      end;
      nCode := 48;
      TempList := m_LoadRcdTempList;
      nCode := 49;
      m_LoadRcdTempList := m_LoadRcdList;
      nCode := 50;
      m_LoadRcdList := TempList;
      nCode := 4;
      if m_ChangeGoldList.Count > 0 then begin
        nCode := 22;
        ChangeGoldList := TList.Create;
        nCode := 23;
        for I := 0 to m_ChangeGoldList.Count - 1 do begin
          if m_ChangeGoldList.Items[I] <> nil then//20080808 增加
            ChangeGoldList.Add(m_ChangeGoldList.Items[I]);
        end;
      end;
    finally
      LeaveCriticalSection(m_UserCriticalSection);
    end;

    nCode := 24;
    if m_SaveRcdTempList.Count > 0 then begin//20081008
      nCode := 25;
      for I := 0 to m_SaveRcdTempList.Count - 1 do begin
        SaveRcd := m_SaveRcdTempList.Items[I];
        nCode := 26;
        if SaveRcd = nil then Continue;//20090323
        nCode := 27;
        if (not DBSocketConnected) {or (g_nSaveRcdErrorCount >= 10) }then begin //DBS关闭 不保存 20090323 修改
          nCode := 28;
          if (SaveRcd.PlayObject <> nil) and (not SaveRcd.boIsHero) then begin
            TPlayObject(SaveRcd.PlayObject).m_boRcdSaved := True;
          end;
          EnterCriticalSection(m_UserCriticalSection);
          try
            nCode := 29;
            for II := m_SaveRcdList.Count - 1 downto 0 do begin
              if m_SaveRcdList.Count <= 0 then Break;//20080917
              nCode := 30;
              if m_SaveRcdList.Items[II] = SaveRcd then begin
                m_SaveRcdList.Delete(II);
                nCode := 5;
                //DisPoseAndNil(SaveRcd);
                DisPose(SaveRcd);//DisPoseAndNil是个不可能实现的函数 By TasNat at: 2012-03-17
                nCode := 6;
                SaveRcd := nil;
                Break;
              end;
            end;//for
          finally
            LeaveCriticalSection(m_UserCriticalSection);
          end;
        end else begin
          nCode := 31;
          boSaveRcd := False;
          if SaveRcd.nReTryCount = 0 then begin
            boSaveRcd := True;
          end else
            if (SaveRcd.nReTryCount < 50) and (GetTickCount - SaveRcd.dwSaveTick > 5000) then begin //保存错误等待5秒后在保存
            boSaveRcd := True;
          end else
            if SaveRcd.nReTryCount >= 50 then begin //失败50次后不在保存
            nCode := 32;
            if (SaveRcd.PlayObject <> nil) and (not SaveRcd.boIsHero) then begin
              nCode := 43;
              TPlayObject(SaveRcd.PlayObject).m_boRcdSaved := True;
            end;
            EnterCriticalSection(m_UserCriticalSection);
            try
              nCode := 33;
              for II := m_SaveRcdList.Count - 1 downto 0 do begin
                if m_SaveRcdList.Count <= 0 then Break;//20080917
                nCode := 34;
                if m_SaveRcdList.Items[II] = SaveRcd then begin
                  m_SaveRcdList.Delete(II);
                  nCode := 7;
                  //DisPoseAndNil(SaveRcd);
                  DisPose(SaveRcd);//DisPoseAndNil是个不可能实现的函数 By TasNat at: 2012-03-17
                  nCode := 8;
                  SaveRcd := nil;
                  Break;
                end;
              end;//for
            finally
              LeaveCriticalSection(m_UserCriticalSection);
            end;
          end;
          if boSaveRcd then begin
            nCode := 35;
            SaveRcd.boSaveing:= True;//20090509 增加
            if SaveHumRcdToDB(SaveRcd.sAccount, SaveRcd.sChrName, SaveRcd.nSessionID, SaveRcd.boIsHero, SaveRcd.HumanRcd, SaveRcd.NewHeroDataInfo, SaveRcd.boisNewHero) then begin
              nCode := 36;
              if (SaveRcd.PlayObject <> nil) and (not SaveRcd.boIsHero) then begin
                TPlayObject(SaveRcd.PlayObject).m_boRcdSaved := True;
              end;
              EnterCriticalSection(m_UserCriticalSection);
              try
                nCode := 37;
                for II := m_SaveRcdList.Count - 1 downto 0 do begin
                  if m_SaveRcdList.Count <= 0 then Break;//20080917
                  if m_SaveRcdList.Items[II] = SaveRcd then begin
                    m_SaveRcdList.Delete(II);
                    nCode := 9;
                    //DisPoseAndNil(SaveRcd);
                    DisPose(SaveRcd);//DisPoseAndNil是个不可能实现的函数 By TasNat at: 2012-03-17
                    nCode := 10;
                    SaveRcd := nil;
                    
                    Break;
                  end;
                end;
              finally
                LeaveCriticalSection(m_UserCriticalSection);
              end;
            end else begin //保存失败
              nCode := 38;
              SaveRcd.boSaveing:= False;//20090509 增加
              Inc(SaveRcd.nReTryCount);
              SaveRcd.dwSaveTick := GetTickCount;
            end;
          end;
        end;
      end;//for
      nCode := 11;
      m_SaveRcdTempList.Clear;//20081008 换地方
    end;
    nCode := 39;
    if m_LoadRcdTempList.Count > 0 then begin
      nCode := 17;
      for I := 0 to m_LoadRcdTempList.Count - 1 do begin
        LoadDBInfo := m_LoadRcdTempList.Items[I];
        if LoadDBInfo = nil then Continue;
        nCode := 18;
        if (not LoadHumFromDB(LoadDBInfo, boReTryLoadDB)) and (not LoadDBInfo.boIsHero) then begin
          nCode := 20;
          RunSocket.CloseUser(LoadDBInfo.nGateIdx, LoadDBInfo.nSocket);
        end;
        nCode := 40;
        if not boReTryLoadDB then begin
          //DisPoseAndNil(LoadDBInfo);
          DisPose(LoadDBInfo);//DisPoseAndNil是个不可能实现的函数 内存泄露 By TasNat at: 2012-03-17
          LoadDBInfo := nil;
        end else begin //如果读取人物数据失败(数据还没有保存),则重新加入队列
          EnterCriticalSection(m_UserCriticalSection);
          try
            nCode := 41;
            m_LoadRcdList.Add(LoadDBInfo);
          finally
            LeaveCriticalSection(m_UserCriticalSection);
          end;
        end;
      end;//for
    end;
    nCode := 42;
    m_LoadRcdTempList.Clear;
    nCode := 12;
    if ChangeGoldList <> nil then begin
      nCode := 121;
      try//20100824 修改
        if ChangeGoldList.Count > 0 then begin//20081008
          for I := 0 to ChangeGoldList.Count - 1 do begin
            GoldChangeInfo := ChangeGoldList.Items[I];
            if GoldChangeInfo <> nil then begin//20081204 增加
              ChangeUserGoldInDB(GoldChangeInfo);
              Dispose(GoldChangeInfo);
            end;
          end;
        end;
        ChangeGoldList.Free;
      except
      end;
    end;
  except
    MainOutMessage(Format(sExceptionMsg, [g_sExceptionVer, nCode]));
  end;
end;
//0-检查是否满员 1-保存时检查是否达到指定值
function TFrontEngine.IsFull(): Boolean;
begin
  Result := False;
  EnterCriticalSection(m_UserCriticalSection);
  try
    if m_SaveRcdList.Count >= 1000 then begin//20101103 修改
      Result := True;
    end;
  finally
    LeaveCriticalSection(m_UserCriticalSection);
  end;
end;
//btLoadType 0-召唤 1-新建 2-删除 3-查询数据(取回英雄) 4-评定英雄取数据
procedure TFrontEngine.AddToLoadHeroRcdList(sCharName, sMsg: string; PlayObject: TObject; btLoadType: Byte; boIsNewHero: boolean; nJob: Byte);
var
  LoadRcdInfo: pTLoadDBInfo;
begin
  New(LoadRcdInfo);
  TPlayObject(PlayObject).m_boWaitHeroDate := True;
  LoadRcdInfo.sAccount := TPlayObject(PlayObject).m_sUserID;
  LoadRcdInfo.sCharName := sCharName;
  LoadRcdInfo.sIPaddr := TPlayObject(PlayObject).m_sIPaddr;
  LoadRcdInfo.boClinetFlag := TPlayObject(PlayObject).m_boClientFlag;
  LoadRcdInfo.nSessionID := TPlayObject(PlayObject).m_nSessionID;
  LoadRcdInfo.nSoftVersionDate := TPlayObject(PlayObject).m_nSoftVersionDate;
  LoadRcdInfo.nPayMent := TPlayObject(PlayObject).m_nPayMent;
  LoadRcdInfo.nPayMode := TPlayObject(PlayObject).m_nPayMode;
  LoadRcdInfo.dwHCode := TPlayObject(PlayObject).m_dwHCode;
  LoadRcdInfo.nSocket := TPlayObject(PlayObject).m_nSocket;
  LoadRcdInfo.nGSocketIdx := TPlayObject(PlayObject).m_nGSocketIdx;
  LoadRcdInfo.nGateIdx := TPlayObject(PlayObject).m_nGateIdx;
  LoadRcdInfo.dwNewUserTick := GetTickCount();
  LoadRcdInfo.PlayObject := PlayObject;
  LoadRcdInfo.nReLoadCount := 0;
  LoadRcdInfo.boIsHero := True;
  LoadRcdInfo.btLoadDBType := btLoadType;
  LoadRcdInfo.sMsg := sMsg;
  LoadRcdInfo.boIsNewHero:= boIsNewHero;
  LoadRcdInfo.nJob:= nJob;
  EnterCriticalSection(m_UserCriticalSection);
  try
    m_LoadRcdList.Add(LoadRcdInfo);
  finally
    LeaveCriticalSection(m_UserCriticalSection);
  end;
end;

procedure TFrontEngine.AddToLoadRcdList(sAccount, sChrName, sIPaddr: string;
  boFlag: Boolean; nSessionID, dwHCode,nPayMent, nPayMode, nSoftVersionDate, nSocket, nGSocketIdx, nGateIdx: Integer; boM2: boolean; nRandomKey: Word);
var
  LoadRcdInfo: pTLoadDBInfo;
begin
  New(LoadRcdInfo);
  LoadRcdInfo.sAccount := sAccount;
  LoadRcdInfo.sCharName := sChrName;
  LoadRcdInfo.sIPaddr := sIPaddr;
  LoadRcdInfo.boClinetFlag := boFlag;
  LoadRcdInfo.nSessionID := nSessionID;
  LoadRcdInfo.nSoftVersionDate := nSoftVersionDate;
  LoadRcdInfo.nPayMent := nPayMent;
  LoadRcdInfo.nPayMode := nPayMode;
  LoadRcdInfo.dwHCode := dwHCode;
  LoadRcdInfo.nSocket := nSocket;
  LoadRcdInfo.nGSocketIdx := nGSocketIdx;
  LoadRcdInfo.nGateIdx := nGateIdx;
  LoadRcdInfo.dwNewUserTick := GetTickCount();
  LoadRcdInfo.PlayObject := nil;
  LoadRcdInfo.nReLoadCount := 0;
  LoadRcdInfo.boIsHero := False;
  LoadRcdInfo.M2isCreate := boM2;//由M2直接创建人物
  LoadRcdInfo.wRandomKey := nRandomKey;//随机密钥

  EnterCriticalSection(m_UserCriticalSection);
  try
    m_LoadRcdList.Add(LoadRcdInfo);
  finally
    LeaveCriticalSection(m_UserCriticalSection);
  end;
end;

function TFrontEngine.LoadHumFromDB(LoadUser: pTLoadDBInfo; var boReTry: Boolean): Boolean; //004B4B10
var
  HumanRcd: THumDataInfo;
  UserOpenInfo: pTUserOpenInfo;
  nOpenStatus: Integer;
  NewHeroDataInfo: TNewHeroDataInfo;
  nCode: byte;
begin
  Result := False;
  nCode:= 0;
  try
    boReTry := False;
    if LoadUser <> nil then begin//20110329
      nCode:= 1;
      if (not LoadUser.boIsHero) or ((LoadUser.boIsHero) and (LoadUser.btLoadDBType = 0)) then begin
        nCode:= 11;
        if InSaveRcdList(LoadUser.sAccount, LoadUser.sCharName) then begin
          boReTry := True; //反回TRUE,则重新加入队列
          Exit;
        end;
      end;
      nCode:= 2;
      if not LoadUser.boIsHero then begin
        nCode:= 21;
        if (UserEngine.GetPlayObjectEx(LoadUser.sAccount, LoadUser.sCharName) <> nil) then begin
          nCode:= 22;
          UserEngine.KickPlayObjectEx(LoadUser.sAccount, LoadUser.sCharName);
          boReTry := True; //反回TRUE,则重新加入队列
          Exit;
        end;
      end;
      nCode:= 3;
      if not LoadUser.boIsHero then begin//人物
        nCode:= 4;
        if not LoadHumRcdFromDB(LoadUser.sAccount, LoadUser.sCharName, LoadUser.sIPaddr, HumanRcd, LoadUser.nSessionID) then begin
          nCode:= 5;
          RunSocket.SendOutConnectMsg(LoadUser.nGateIdx, LoadUser.nSocket, LoadUser.nGSocketIdx);//强迫用户下线
        end else begin
          nCode:= 6;
          New(UserOpenInfo);
          UserOpenInfo.sAccount := LoadUser.sAccount;
          UserOpenInfo.sChrName := LoadUser.sCharName;
          UserOpenInfo.LoadUser := LoadUser^;
          UserOpenInfo.HumanRcd := HumanRcd;
          nCode:= 7;
          UserEngine.AddUserOpenInfo(UserOpenInfo);
          Result := True;
        end;
      end else begin//英雄
        nCode:= 8;
        nOpenStatus := -1;
        case LoadUser.btLoadDBType of
          0: if LoadHeroRcdFromDB(LoadUser.sAccount, LoadUser.sCharName, LoadUser.sIPaddr, HumanRcd, LoadUser.nSessionID, LoadUser.boIsNewHero, LoadUser.nJob, NewHeroDataInfo) then nOpenStatus := 1;
          1: nOpenStatus := NewHeroRcd(LoadUser.sCharName, LoadUser.sMsg);
          2: if DelHeroRcd(LoadUser.sAccount, LoadUser.sCharName, LoadUser.sIPaddr, LoadUser.nSessionID) then nOpenStatus := 1;
          3, 4: LoadUser.sMsg:= QueryHeroRcdFromDB(LoadUser.sAccount, LoadUser.sCharName, LoadUser.sIPaddr, LoadUser.sMsg, LoadUser.nSessionID);//取回寄存英雄取数据,评定英雄取数据
          else nOpenStatus := 0;
        end;
        nCode:= 9;
        New(UserOpenInfo);
        UserOpenInfo.sAccount := LoadUser.sAccount;
        UserOpenInfo.sChrName := LoadUser.sCharName;
        UserOpenInfo.LoadUser := LoadUser^;
        UserOpenInfo.HumanRcd := HumanRcd;
        UserOpenInfo.nOpenStatus := nOpenStatus;
        UserOpenInfo.NewHeroDataInfo := NewHeroDataInfo;
        nCode:= 10;
        UserEngine.AddUserOpenInfo(UserOpenInfo);
        Result := True;
      end;
    end;
  except
    boReTry := False;
    MainOutMessage(Format('{%s} TFrontEngine::LoadHumFromDB Code:%d', [g_sExceptionVer, nCode]));
  end;
end;

function TFrontEngine.InSaveRcdList(sAccount, sChrName: string): Boolean;
var
  I: Integer;
begin
  Result := False;
  EnterCriticalSection(m_UserCriticalSection);
  try
    if m_SaveRcdList.Count > 0 then begin//20081008
      for I := 0 to m_SaveRcdList.Count - 1 do begin
        if (pTSaveRcd(m_SaveRcdList.Items[I]).sAccount = sAccount) and
          (pTSaveRcd(m_SaveRcdList.Items[I]).sChrName = sChrName) then begin
          Result := True;
          Break;
        end;
      end;
    end;
  finally
    LeaveCriticalSection(m_UserCriticalSection);
  end;
end;

procedure TFrontEngine.AddChangeGoldList(sGameMasterName, sGetGoldUserName: string;
  nGold: Integer);
var
  GoldInfo: pTGoldChangeInfo;
begin
  New(GoldInfo);
  GoldInfo.sGameMasterName := sGameMasterName;
  GoldInfo.sGetGoldUser := sGetGoldUserName;
  GoldInfo.nGold := nGold;
  m_ChangeGoldList.Add(GoldInfo);
end;

function TFrontEngine.GetSaveRcd(sAccount, sCharName: string): pTSaveRcd;
var
  I: Integer;
  SaveRcd: pTSaveRcd;
begin
  Result := nil;
  EnterCriticalSection(m_UserCriticalSection);
  try
    if m_SaveRcdList.Count > 0 then begin
      for I := 0 to m_SaveRcdList.Count - 1 do begin
        SaveRcd := pTSaveRcd(m_SaveRcdList.Items[I]);
        if SaveRcd <> nil then begin//20090305
          if (SaveRcd.sAccount = sAccount) and (SaveRcd.sChrName = sCharName) then begin
            Result := SaveRcd;
            Break;
          end;
        end;
      end;
    end;
  finally
    LeaveCriticalSection(m_UserCriticalSection);
  end;
end;
//检查是否存在列表里，如不存在，则增加，存在则退出
function TFrontEngine.UpDataSaveRcdList(SaveRcd: pTSaveRcd): Boolean; //2005-11-12 增加
var
  I: Integer;
  HumanRcd: pTSaveRcd;
begin
  Result := False;
  EnterCriticalSection(m_UserCriticalSection);
  try
    for I := m_SaveRcdList.Count - 1 downto 0 do begin
      if m_SaveRcdList.Count <= 0 then Break;//20080917
      HumanRcd := pTSaveRcd(m_SaveRcdList.Items[I]);
      if HumanRcd <> nil then begin//20090106 增加
        if (HumanRcd.sAccount = SaveRcd.sAccount) and (HumanRcd.sChrName = SaveRcd.sChrName) then begin
          if not HumanRcd.boSaveing then begin//20090509 没有正在保存的，则修改
            HumanRcd.HumanRcd := SaveRcd.HumanRcd;
            Result := True; 
            Exit;
          end else Break;
        end;
      end;
    end;
    m_SaveRcdList.Add(SaveRcd);
  finally
    LeaveCriticalSection(m_UserCriticalSection);
  end;
end;

procedure TFrontEngine.DeleteHuman(nGateIndex, nSocket: Integer);
var
  I: Integer;
  LoadRcdInfo: pTLoadDBInfo;
begin
  EnterCriticalSection(m_UserCriticalSection);
  try
    for I := m_LoadRcdList.Count - 1 downto 0 do begin
      if m_LoadRcdList.Count <= 0 then Break;
      LoadRcdInfo := m_LoadRcdList.Items[I];
      if (LoadRcdInfo.nGateIdx = nGateIndex) and (LoadRcdInfo.nSocket = nSocket) then begin
        m_LoadRcdList.Delete(I);
        Dispose(LoadRcdInfo);
        Break;
      end;
    end;
  finally
    LeaveCriticalSection(m_UserCriticalSection);
  end;
end;

function TFrontEngine.ChangeUserGoldInDB(GoldChangeInfo: pTGoldChangeInfo): Boolean;
var
  HumanRcd: THumDataInfo;
  NewHeroDataInfo: TNewHeroDataInfo;
  nCode: Byte;//20090202
begin
  Result := False;
  nCode:= 0;
  try
    if GoldChangeInfo <> nil then begin//20090203
      nCode:= 4;
      if LoadHumRcdFromDB('1', GoldChangeInfo.sGetGoldUser, '1', HumanRcd, 1) then begin
        nCode:= 1;
        if ((HumanRcd.Data.nGold + GoldChangeInfo.nGold) > 0) and ((HumanRcd.Data.nGold + GoldChangeInfo.nGold) < 2000000000) then begin
          Inc(HumanRcd.Data.nGold, GoldChangeInfo.nGold);
          nCode:= 2;
          if SaveHumRcdToDB('1', GoldChangeInfo.sGetGoldUser, 1, False, HumanRcd, NewHeroDataInfo, False) then begin
            nCode:= 3;
            UserEngine.sub_4AE514(GoldChangeInfo);
            Result := True;
          end;
        end;
      end;
    end;
  except
    MainOutMessage(format('{%s} TFrontEngine.ChangeUserGoldInDB Code:%d',[g_sExceptionVer, nCode]));
  end;
end;

procedure TFrontEngine.Run;
begin
  Try
    ProcessGameDate();
    if GetTickCount() - m_dwGetGameTimeTick > {120000}1800000 then begin//20110301 修改，每隔三十分钟检查游戏时间
      m_dwGetGameTimeTick:= GetTickCount();
      GetGameTime();
    end;
  except
    on E: Exception do begin
      MainOutMessage(format('{%s} TFrontEngine.Run',[g_sExceptionVer]));
    end;
  end;
end;

end.
