unit Event;

interface

uses
  Windows, Classes, ObjBase, Envir, Grobal2, SDK, SysUtils{IntToStr()需引用 20081129};
type
  TEvent = class
    nVisibleFlag: Byte;//0-隐藏(不可见) 1-不用更新 2-需发消息更新
    m_boAddToMapOK : Boolean;//是否添加到地图 By TasNat at: 2012-05-26 19:43:21
    m_Envir: TEnvirnoment;//所在地图场景
    m_nX: Integer;//X坐标
    m_nY: Integer;//Y坐标
    m_nEventType: Integer;//类型
    m_nEventParam: Integer;
    m_dwOpenStartTick: LongWord;
    m_dwContinueTime: LongWord;//显示时间长度
    m_dwCloseTick: LongWord;//关闭间隔
    m_boClosed: Boolean;//是否关闭
    m_nDamage: Integer;//火墙威力
    m_OwnBaseObject: TBaseObject;
    m_dwRunStart: LongWord;//启动时间
    m_dwRunTick: LongWord;//运行间隔
    m_boVisible: Boolean;//是否可见
    m_boActive: Boolean;
    m_boNotGoto :  Boolean;
  public
    constructor Create(tEnvir: TEnvirnoment; nTX, nTY, nType, dwETime: Integer; boVisible: Boolean);
    destructor Destroy; override;
    procedure Run(); virtual;
    procedure Close();
  end;
 { TStoneMineEvent = class(TEvent)//矿石
    m_nMineCount: Integer;
    m_nAddStoneCount: Integer;//增加矿的数量
    m_dwAddStoneMineTick: LongWord;//增加矿的间隔
  public
    constructor Create(Envir: TEnvirnoment; nX, nY: Integer; nType: Integer);
    destructor Destroy; override;
    procedure AddStoneMine();
  end;  }
  TPileStones = class(TEvent)
  public
    constructor Create(Envir: TEnvirnoment; nX, nY: Integer; nType, nTime: Integer);
    destructor Destroy; override;
    procedure AddEventParam();
  end;

  THolyCurtainEvent = class(TEvent)//困魔咒效果
  public
    constructor Create(Envir: TEnvirnoment; nX, nY: Integer; nType, nTime: Integer);
    destructor Destroy; override;
  end;

  THolyCurtainLockEvent = class(TEvent)//天雷乱舞
  public
    procedure Run(); override;
    constructor Create(OwnBaseObject: TBaseObject; nX, nY: Integer; nType, nTime: Integer);
    destructor Destroy; override;
  end;

  TFireBurnEvent = class(TEvent)//火墙
    m_dwRunTick: LongWord;
    m_dwRunTime: LongWord;//RUN处理间隔
    m_nType:Byte;
    nTwoPwr:Integer;//内功技能之前的威力值
  public
    constructor Create(Creat: TBaseObject; nX, nY: Integer; nType: Integer; nTime, nDamage: Integer);
    destructor Destroy; override;
    procedure Run(); override;
  end;
  TSafeEvent = class(TEvent) //安全区光环
  public
    constructor Create(Envir: TEnvirnoment; nX, nY: Integer; nType: Integer);
    destructor Destroy; override;
    procedure Run(); override;
  end;
  TFlowerEvent = class(TEvent) //烟花
  public
    constructor Create(Envir: TEnvirnoment; nX, nY: Integer; nType, nTime: Integer);
    destructor Destroy; override;
    procedure Run(); override;
  end;
  {TThunderAndLavaEvent = class(TEvent)//闪电  地上冒岩浆 20090505
    FreshBaseObject: TBaseObject;//攻击类
    m_dwRunTick: LongWord;
  public
    constructor Create(Envir: TEnvirnoment; nX, nY: Integer; nType: Integer; nTime, nDamage: Integer);
    destructor Destroy; override;
    procedure Run(); override;
  end;}
  //==============================================================================
  TEventManager = class
  private
    m_EventList: TGList;
    m_ClosedEventList: TGList;
  public
    constructor Create();
    destructor Destroy; override;
    function GetEvent(Envir: TEnvirnoment; nX, nY: Integer; nType: Integer): TEvent;
    function GetRangeEvent(Envir: TEnvirnoment; OwnBaseObject: TBaseObject; nX, nY, nRange: Integer; nType: Integer): Integer;
    function GetRangeEvent1(Envir: TEnvirnoment; nX, nY, nRange: Integer; nType: Integer): Integer;//查找相同类型的场景数量 20090505
    procedure AddEvent(Event: TEvent);
    //function FindEvent(Envir: TEnvirnoment; Event: TEvent): TEvent;//未使用
    procedure Run();
  end;
implementation

uses M2Share, ObjHero;

(*{ TStoneMineEvent }

constructor TStoneMineEvent.Create(Envir: TEnvirnoment; nX, nY, nType: Integer);
begin
  inherited Create(Envir, nX, nY, nType, 0, False);
  m_Envir.AddToMapMineEvent(nX, nY, OS_EVENTOBJECT, Self);
  m_boVisible := False;
  m_nMineCount := Random(200);
  m_dwAddStoneMineTick := GetTickCount();
  m_boActive := False;
  m_nAddStoneCount := Random(80);
end;

destructor TStoneMineEvent.Destroy;
begin

  inherited;
end;

procedure TStoneMineEvent.AddStoneMine;
begin
  m_nMineCount := m_nAddStoneCount;
  m_dwAddStoneMineTick := GetTickCount();
end;  *)
{ TEventManager }
procedure TEventManager.Run;
var
  I: Integer;
  Event: TEvent;
  nCode: Byte;//20081129
begin
  nCode:= 0;
  Try
    m_EventList.Lock;
    try
      nCode:= 1;
      for I := m_EventList.Count - 1 downto 0 do begin
        if m_EventList.Count <= 0 then Break;//20080917
        nCode:= 2;
        Event := TEvent(m_EventList.Items[I]);
        nCode:= 3;
        if Event <> nil then begin//20081129
          if Event.m_boActive and ((GetTickCount - Event.m_dwRunStart) > Event.m_dwRunTick) then begin
            Event.m_dwRunStart := GetTickCount();
            nCode:= 4;
            Event.Run();
            nCode:= 14;
            if Event.m_boClosed then begin
              m_ClosedEventList.Lock;
              try
                nCode:= 5;
                m_ClosedEventList.Add(Event);
              finally
                m_ClosedEventList.UnLock;
              end;
              nCode:= 6;
              m_EventList.Delete(I);
            end;
          end;
        end;
      end;//for
    finally
      m_EventList.UnLock;
    end;

    nCode:= 7;
    m_ClosedEventList.Lock;
    try
      nCode:= 8;
      for I := m_ClosedEventList.Count - 1 downto 0 do begin
        if m_ClosedEventList.Count <= 0 then Break;//20080917
        nCode:= 9;
        Event := TEvent(m_ClosedEventList.Items[I]);
        nCode:= 10;
        if Event <> nil then begin//20081129
          if (GetTickCount - Event.m_dwCloseTick) > 120000{2 * 60 * 1000} then begin//20090505 修改成2分钟
            m_ClosedEventList.Delete(I);
            nCode:= 13;
            try//20090206 增加
              if Event <> nil then Event.Free;//20090129 修改
            except
            end;
          end;
        end;
      end;
    finally
      m_ClosedEventList.UnLock;
    end;
  except
    MainOutMessage(format('{%s} TEventManager.Run Code:%d',[g_sExceptionVer, nCode]));
  end;
end;

function TEventManager.GetRangeEvent(Envir: TEnvirnoment; OwnBaseObject: TBaseObject;
  nX, nY, nRange: Integer; nType: Integer): Integer;
var
  I: Integer;
  Event: TEvent;
begin
  Result := 0;
  m_EventList.Lock;
  try
    if m_EventList.Count > 0 then begin//20080630
      for I := 0 to m_EventList.Count - 1 do begin
        Event := TEvent(m_EventList.Items[I]);
        if (Event.m_OwnBaseObject = OwnBaseObject) and
          (abs(Event.m_nX - nX) <= nRange) and
          (abs(Event.m_nY - nY) <= nRange) and
          (Event.m_nEventType = nType) then begin
          Inc(Result);
        end;
      end;
    end;
  finally
    m_EventList.UnLock;
  end;
end;
//查找相同类型的场景数量
function TEventManager.GetRangeEvent1(Envir: TEnvirnoment; nX, nY, nRange: Integer; nType: Integer): Integer;
var
  I: Integer;
  Event: TEvent;
begin
  Result := 0;
  m_EventList.Lock;
  try
    if m_EventList.Count > 0 then begin
      for I := 0 to m_EventList.Count - 1 do begin
        Event := TEvent(m_EventList.Items[I]);
        if (abs(Event.m_nX - nX) <= nRange) and
          (abs(Event.m_nY - nY) <= nRange) and
          (Event.m_Envir = Envir) and
          (Event.m_nEventType = nType) then begin
          Inc(Result);
          if Result > 0 then Break;
        end;
      end;
    end;
  finally
    m_EventList.UnLock;
  end;
end;

function TEventManager.GetEvent(Envir: TEnvirnoment; nX, nY,
  nType: Integer): TEvent;
var
  I: Integer;
  Event: TEvent;
begin
  Result := nil;
  m_EventList.Lock;
  try
    if m_EventList.Count > 0 then begin//20080630
      for I := 0 to m_EventList.Count - 1 do begin
        Event := TEvent(m_EventList.Items[I]);
        if (Event.m_Envir = Envir) and (Event.m_nX = nX) and
          (Event.m_nY = nY) and (Event.m_nEventType = nType) then begin
          Result := Event;
          Break;
        end;
      end;
    end;
  finally
    m_EventList.UnLock;
  end;
end;

{function TEventManager.FindEvent(Envir: TEnvirnoment; Event: TEvent): TEvent;
var
  I: Integer;
begin
  Result := nil;
  m_EventList.Lock;
  try
    if m_EventList.Count > 0 then begin//20080630
      for I := 0 to m_EventList.Count - 1 do begin
        if (TEvent(m_EventList.Items[I]).m_Envir = Envir) and (TEvent(m_EventList.Items[I]) = Event) then begin
          Result := TEvent(m_EventList.Items[I]);
          Break;
        end;
      end;
    end;
  finally
    m_EventList.UnLock;
  end;
end; }

procedure TEventManager.AddEvent(Event: TEvent);
begin
  m_EventList.Lock;
  try
    m_EventList.Add(Event);
  finally
    m_EventList.UnLock;
  end;
end;

constructor TEventManager.Create();
begin
  m_EventList := TGList.Create;
  m_ClosedEventList := TGList.Create;
end;

destructor TEventManager.Destroy;
var
  I: Integer;
  Event : TEvent;
begin
  if m_EventList.Count > 0 then begin//20080630
    for I := 0 to m_EventList.Count - 1 do begin
      try
        Event := TEvent(m_EventList.Items[I]);
        if (Event <> nil) and (not Event.m_boAddToMapOK) then//加入到地图后归地图释放内存By TasNat at: 2012-05-26 19:45:37
          TEvent(m_EventList.Items[I]).Free;
      except
      end;
    end;
  end;
  m_EventList.Free;
  if m_ClosedEventList.Count > 0 then begin//20080630
    for I := 0 to m_ClosedEventList.Count - 1 do begin
      if TEvent(m_ClosedEventList.Items[I]) <> nil then TEvent(m_ClosedEventList.Items[I]).Free;
    end;
  end;
  m_ClosedEventList.Free;
  inherited;
end;

{ THolyCurtainEvent }

constructor THolyCurtainEvent.Create(Envir: TEnvirnoment; nX, nY, nType, nTime: Integer);
begin
  inherited Create(Envir, nX, nY, nType, nTime, True);
end;

destructor THolyCurtainEvent.Destroy;
begin
  inherited;
end;

constructor THolyCurtainLockEvent.Create(OwnBaseObject: TBaseObject; nX, nY, nType, nTime: Integer);
begin
  inherited Create(OwnBaseObject.m_pEnvir, nX, nY, nType, nTime, True);
  m_OwnBaseObject := OwnBaseObject;
end;

procedure THolyCurtainLockEvent.Run();
var
  ObjList : TList;
  TargetBaseObject: TBaseObject;
  I : Integer;
begin
  inherited Run;
  try

    if ((not m_boClosed) and (m_OwnBaseObject <> nil) and
      //天雷乱舞
      (m_nEventType = ET_NOTGOTO)) and (m_OwnBaseObject.m_btRaceServer = RC_PLAYOBJECT)
       then with TPlayObject(m_OwnBaseObject) do begin
        if //(m_OwnBaseObject.m_PEnvir <> m_Envir) or (m_OwnBaseObject.m_PEnvir.sMapName <> m_Envir.sMapName) or
        (m_nCharStatus and $00008000 = 0) then begin //非吟唱状态
          //m_Envir.GeTBaseObjects()
          m_OwnBaseObject := nil;
          m_boClosed := True;
          ObjList := TList.Create;
          try
            m_Envir.GetMapBaseObjects(m_nHolyCurtainLockX, m_nHolyCurtainLockY, 10, ObjList);
            for I := 0 to ObjList.Count - 1 do begin
              TargetBaseObject := TBaseObject(ObjList[I]);
              if (TargetBaseObject.m_btRaceServer = RC_PLAYOBJECT) then
                TargetBaseObject.SendMsg(TargetBaseObject, RM_HIDEEVENT, 0, Integer(Self), m_nX, m_nY, '');

            end

          finally
            ObjList.Free;
          end;

          Close();
          Exit;
        end;
    end;
  except
  end;
end;

destructor THolyCurtainLockEvent.Destroy;
begin
  inherited;
end;
{ TSafeEvent 安全区光环}

constructor TSafeEvent.Create(Envir: TEnvirnoment; nX, nY: Integer; nType: Integer);
begin
  inherited Create(Envir, nX, nY, nType, GetTickCount, True);
end;

destructor TSafeEvent.Destroy;
begin
  inherited;
end;

procedure TSafeEvent.Run();
begin
  m_dwOpenStartTick := GetTickCount();
  inherited;
end;

{ TFlowerEvent 烟花}

constructor TFlowerEvent.Create(Envir: TEnvirnoment; nX, nY: Integer; nType, nTime: Integer);
begin
  inherited Create(Envir, nX, nY, nType, nTime, True);
end;

destructor TFlowerEvent.Destroy;
begin
  inherited;
end;

procedure TFlowerEvent.Run();
begin
  //m_dwOpenStartTick := GetTickCount();
  inherited;
end;

{ TFireBurnEvent }

constructor TFireBurnEvent.Create(Creat: TBaseObject; nX, nY, nType, nTime, nDamage: Integer);
begin
  inherited Create(Creat.m_PEnvir, nX, nY, nType, nTime, True);
  m_nDamage := nDamage;
  m_OwnBaseObject := Creat;
  m_dwRunTime:= 3000;//RUN处理间隔
  m_nType:= nType;//20080925
  nTwoPwr:= 0;//20081222
  if m_OwnBaseObject <> nil then begin
    if (m_OwnBaseObject.m_btRaceServer = 156) then m_dwRunTime:= 1000;
  end;
  if (m_nType = ET_VORTEX) then m_dwRunTime:= 1900;
end;

destructor TFireBurnEvent.Destroy;
begin
  inherited;
end;

procedure TFireBurnEvent.Run;
var
  I: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
  nPower, nPwrDec:Integer;
begin
  if ((GetTickCount - m_dwRunTick) > m_dwRunTime) then begin
    m_dwRunTick := GetTickCount();
    BaseObjectList := TList.Create;
    Try
      if m_Envir <> nil then begin
        if (m_nType = ET_VORTEX) then begin//旋涡(中蛛网) 20110121
          m_Envir.GetRangeBaseObject(m_nX, m_nY, 1, True, BaseObjectList);
        end else m_Envir.GeTBaseObjects(m_nX, m_nY, True, BaseObjectList);
        if BaseObjectList.Count > 0 then begin
          for I := 0 to BaseObjectList.Count - 1 do begin
            TargeTBaseObject := TBaseObject(BaseObjectList.Items[I]);
            nPower:= m_nDamage;
            if (TargeTBaseObject <> nil) then begin
              if (m_OwnBaseObject <> nil) then begin
                if (not m_OwnBaseObject.m_boRobotObject) then begin
                  if (m_OwnBaseObject.IsProperTarget(TargeTBaseObject)) then begin
                    {$IF M2Version <> 2}
                    if (m_nType = ET_FIRE) or (m_nType = ET_FIRE_FENGHAO) or
                      (m_nType = ET_FIRE_1) or (m_nType = ET_FIRE_2) or (m_nType = ET_FIRE_3) then begin//火墙
                      if (m_OwnBaseObject.m_btRaceServer = RC_HEROOBJECT) then
                        m_OwnBaseObject.m_ExpHitter:= TargeTBaseObject;
                      if ((m_OwnBaseObject.m_btRaceServer = RC_PLAYOBJECT) or
                          (m_OwnBaseObject.m_btRaceServer = RC_HEROOBJECT)) {and boReadSkill} then begin//20081223 20090304修改
                        nPwrDec:= 0;
                        if TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
                          nPwrDec:= MagicManager.GetNGPow(TargeTBaseObject, TPlayObject(TargeTBaseObject).m_MagicSkill_213,nTwoPwr);//静之火墙
                        end else
                        if TargeTBaseObject.m_btRaceServer = RC_HEROOBJECT then begin
                          nPwrDec:= MagicManager.GetNGPow(TargeTBaseObject, THEROOBJECT(TargeTBaseObject).m_MagicSkill_213,nTwoPwr);//静之火墙
                        end;
                        nPower := nPower - nPwrDec;
                        if nPower < 0 then nPower:= 0;
                      end;
                      if (m_OwnBaseObject.m_btRaceServer = 156) and (TargeTBaseObject.m_btRaceServer <> 156)
                        and (TargeTBaseObject.m_btRaceServer <> 157)  then begin//朱火弹则目标直接死亡
                        TargeTBaseObject.SetLastHiter(m_OwnBaseObject);
                        TargeTBaseObject.m_WAbil.HP:= 0;
                      end else begin
                      //SendMsg(BaseObject: TBaseObject; wIdent, wParam: Word; nParam1, nParam2, nParam3: Integer; sMsg: string);
                        TargeTBaseObject.SendMsg(m_OwnBaseObject, RM_MAGSTRUCK_MINE, 0, nPower, 1{0}, 0, '');//20100926
                      end;
                    end else
                    if (m_nType = ET_VORTEX) then begin//旋涡(中蛛网) 20110121
                      if TargeTBaseObject.m_wStatusTimeArr[STATE_LOCKRUN] = 0 then begin
                        TargeTBaseObject.MakeSpiderMag(7);//中蛛网，不能跑动
                      end;
                      TargeTBaseObject.SendMsg(m_OwnBaseObject, RM_MAGSTRUCK_MINE, 0, nPower, 1{0}, 0, '');
                    end else
                    {$IFEND}
                    TargeTBaseObject.SendMsg(m_OwnBaseObject, RM_MAGSTRUCK_MINE, 0, nPower, 0, 0, '');
                  end;
                end;
              end;
            end;
          end;//for
        end;
      end;
    finally
      BaseObjectList.Free;
    end;
  end;
  inherited Run;
end;

{ TThunderAndLavaEvent 闪电  地上冒岩浆 20090505 }
(*
constructor TThunderAndLavaEvent.Create(Envir: TEnvirnoment; nX, nY, nType, nTime, nDamage: Integer);
begin
  inherited Create(Envir, nX, nY, nType, nTime, True);
  m_nDamage := nDamage;//伤害值
  FreshBaseObject:= TBaseObject.Create();
  m_OwnBaseObject := FreshBaseObject;
end;

destructor TThunderAndLavaEvent.Destroy;
begin
  if FreshBaseObject <> nil then FreshBaseObject.Destroy;//20090527 修改
  inherited;
end;

procedure TThunderAndLavaEvent.Run;
var
  I: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
begin
  if (GetTickCount - m_dwRunTick) > 3000 then begin
    m_dwRunTick := GetTickCount();
    BaseObjectList := TList.Create;
    Try
      if m_Envir <> nil then begin
        m_Envir.GeTBaseObjects(m_nX, m_nY, True, BaseObjectList);
        if BaseObjectList.Count > 0 then begin
          for I := 0 to BaseObjectList.Count - 1 do begin
            TargeTBaseObject := TBaseObject(BaseObjectList.Items[I]);
            if (TargeTBaseObject <> nil) and (m_OwnBaseObject <> nil) then begin
              if not TargeTBaseObject.m_boDeath then begin
                if (not m_OwnBaseObject.m_boRobotObject) and ((TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT) or (TargeTBaseObject.m_Master <> nil)) then begin
                  if (m_OwnBaseObject.IsProperTarget(TargeTBaseObject)) then begin
                    TargeTBaseObject.SendDelayMsg(m_OwnBaseObject, RM_MAGSTRUCK, 0, m_nDamage, 1, 0, '', 600);
                  end;
                end;
              end;
            end;
          end;//for
        end;
      end;
    finally
      BaseObjectList.Free;
    end;
  end;
  inherited;
end; *)

{ TEvent }

constructor TEvent.Create(tEnvir: TEnvirnoment; nTX, nTY, nType, dwETime: Integer; boVisible: Boolean);
begin
  m_dwOpenStartTick := GetTickCount();
  m_nEventType := nType;
  m_nEventParam := 0;
  m_dwContinueTime := dwETime;
  m_boVisible := boVisible;
  m_boClosed := False;
  m_Envir := tEnvir;
  m_nX := nTX;
  m_nY := nTY;
  m_boActive := True;
  m_nDamage := 0;
  m_OwnBaseObject := nil;
  m_dwRunStart := GetTickCount();
  m_dwRunTick := 500;
  if (m_Envir <> nil) and (m_boVisible) and (m_Envir.AddToMap(m_nX, m_nY, OS_EVENTOBJECT, Self) = Self) then begin
    m_boAddToMapOK := True;
  end else m_boVisible := False;
end;

destructor TEvent.Destroy;
begin
  m_boClosed := True;//20080903 增加
  inherited;
end;

procedure TEvent.Run;
begin
  try
    if (GetTickCount - m_dwOpenStartTick) > m_dwContinueTime then begin
      Close();
    end;
    if ((not m_boClosed) and (m_OwnBaseObject <> nil) and
      ((m_nEventType = ET_FIRE) or (m_nEventType = ET_FIRE_FENGHAO) or (m_nEventType = ET_FIRE_1) or (m_nEventType = ET_FIRE_2)or (m_nEventType = ET_FIRE_3))
      and g_Config.boChangeMapFireExtinguish) then begin
      if ((m_OwnBaseObject.m_btRaceServer = RC_PLAYOBJECT) or (m_OwnBaseObject.m_btRaceServer = RC_HEROOBJECT))
        and not m_OwnBaseObject.m_boSuperMan {机器人除外} then begin
        if (m_OwnBaseObject.m_PEnvir <> m_Envir) or (m_OwnBaseObject.m_PEnvir.sMapName <> m_Envir.sMapName) then begin //2006-11-12 火墙换地图消失
          m_OwnBaseObject := nil;
          Close();
          Exit;
        end;
      end;
    end;
    if (m_OwnBaseObject <> nil) then begin
      if m_OwnBaseObject.m_boGhost or (m_OwnBaseObject.m_boDeath)
        then m_OwnBaseObject := nil;
    end;
  except
  end;
end;

procedure TEvent.Close;
begin
  m_dwCloseTick := GetTickCount();
  m_boClosed := True;
  if m_boVisible then begin
    m_boVisible := False;
    if m_boAddToMapOK and (m_Envir <> nil) and (m_Envir.DeleteFromMap(m_nX, m_nY, OS_EVENTOBJECT, Self) = 1) then begin
      m_boAddToMapOK := False;
    end;
    m_Envir := nil;
    m_OwnBaseObject := nil;
  end;
end;

{ TPileStones }

constructor TPileStones.Create(Envir: TEnvirnoment; nX, nY, nType,
  nTime: Integer);
begin
  inherited Create(Envir, nX, nY, nType, nTime, True);
  m_nEventParam := 1;
end;

destructor TPileStones.Destroy;
begin
  inherited;
end;

procedure TPileStones.AddEventParam;
begin
  if m_nEventParam < 5 then Inc(m_nEventParam);
end;

end.
