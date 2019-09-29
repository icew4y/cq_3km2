unit ObjMon2;

interface
uses
  Windows, Classes, Grobal2, ObjBase, ObjMon, SysUtils, PathFind, MapPoint;
type
  TStickMonster = class(TAnimalObject)//食人花
    bo550: Boolean;
    n554: Integer;
    n558: Integer;
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
    function AttackTarget(): Boolean; virtual;
    procedure sub_FFEA; virtual;
    procedure sub_FFE9; virtual;
    procedure VisbleActors; virtual; //FFE8
    function Operate(ProcessMsg: pTProcessMessage): Boolean; override; //FFFC
    procedure Run; override;
  end;
  TBeeQueen = class(TAnimalObject) //角蝇
    BBList: TList;
  private
    procedure MakeChildBee;
  public
    constructor Create(); override;
    destructor Destroy; override;
    function Operate(ProcessMsg: pTProcessMessage): Boolean; override; //FFFC
    procedure Run; override;
  end;
  TCentipedeKingMonster = class(TStickMonster) //触龙神  不能动的怪物，目标走近，从地上冒出，攻击目标，目标走后，会自己回到地下
    m_dwAttickTick: LongWord; //0x560
  private
    function sub_4A5B0C: Boolean;
  public
    constructor Create(); override;
    destructor Destroy; override;
    function AttackTarget(): Boolean; override;
    procedure sub_FFE9; override;
    procedure Run; override;
  end;
  TBigHeartMonster = class(TAnimalObject) //赤月恶魔  千年数妖  应该是 攻击的时候 从地下冒刺的  不能动的怪
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
    function AttackTarget(): Boolean; virtual;
    procedure Run; override;
  end;
  TSpiderHouseMonster = class(TAnimalObject) //属于可以 怪生怪的 怪
    BBList: TList;
  private
    procedure GenBB;
  public
    constructor Create(); override;
    destructor Destroy; override;
    function Operate(ProcessMsg: pTProcessMessage): Boolean; override; //FFFC
    procedure Run; override;
  end;
  TExplosionSpider = class(TMonster)//幻影蜘蛛
    dw558: LongWord;
  private
    procedure sub_4A65C4;
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
    function AttackTarget(): Boolean; override; //FFEB
  end;
  TGuardUnit = class(TAnimalObject)//城堡弓箭手,城堡卫士 
    dw54C: LongWord;
    m_nX550: Integer;
    m_nY554: Integer;
    m_nDirection: Integer; //方向
  public
    function IsProperTarget(BaseObject: TBaseObject): Boolean; override; //FFF4
    procedure Struck(hiter: TBaseObject); override; //FFEC
  end;
  TArcherGuard = class(TGuardUnit)//弓箭手那类的 NPC
  private
    procedure sub_4A6B30(TargeTBaseObject: TBaseObject);
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
  end;
  TArcherGuardMon = class(TGuardUnit)//类似弓箭手的怪,只攻击怪物,不打人和宝宝 20080121
  private
    procedure sub_4A6B30(TargeTBaseObject: TBaseObject);
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
  end;
  TArcherGuardMon1 = class(TAnimalObject)//136怪,不会攻击,不会移动 20080122
    m_NewCurrX: Integer;
    m_NewCurrY: Integer;
    m_boWalk: Boolean;
  private
    function WalkToTargetXY(nTargetX, nTargetY: Integer): Boolean;
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
  end;
  TArcherPolice = class(TArcherGuard) //没有此类怪
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
  end;
  TCastleDoor = class(TGuardUnit)//沙巴克的 城门
    dw55C: LongWord;
    dw560: LongWord;
    m_boOpened: Boolean;
    bo565n: Boolean;
    bo566n: Boolean;
    bo567n: Boolean;
  private
    procedure SetMapXYFlag(nFlag: Integer);
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Die; override;
    procedure Run; override;
    procedure Initialize(); override;
    procedure Close;
    procedure Open;
    procedure RefStatus;
  end;
  TWallStructure = class(TGuardUnit)//沙巴克的 左中右墙
    dw560: LongWord;
    boSetMapFlaged: Boolean;//地图标识
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Initialize; override;
    procedure Die; override;
    procedure Run; override;
    procedure RefStatus;
  end;
  TSoccerBall = class(TAnimalObject)//飞火流星(足球)
    n548: Integer;
    n550: Integer;//足球前进步数
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Struck(hiter: TBaseObject); {virtual}override; //20100629 修改为 override
    procedure Run; override;
  end;
  TFireDragon = class(TCentipedeKingMonster)//火龙(不可毒，群雷攻击，大火圈攻击，触发守护兽攻击)
    m_dwLightTick: LongWord;//守护兽发光间隔
  private
    function sub_4A5B0C(nCode: Integer): Boolean;
    function MagBigExplosion(nPower, nX, nY: Integer; nRage: Integer): Boolean;//大火圈攻击
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure RecalcAbilitys(); override; //刷新属性
    function AttackTarget(): Boolean; override;
    procedure Run; override;
  end;
  TFireDragonGuard = class(TAnimalObject)//火龙守护兽
    m_boLight: Boolean;//是否发光
    m_dwLightTick: LongWord;//发光间隔
    m_dwLightTime: LongWord;//发光时长
    m_boAttick: Boolean; //是否可以攻击，即最后一个熄灭的怪，负责攻击消息
    s_AttickXY: String;//攻击坐标
  private
    function MagBigExplosion(nPower, nX, nY: Integer; nRage: Integer): Boolean;//小火圈攻击
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure RecalcAbilitys(); override; //刷新属性
    function AttackTarget(): Boolean;
    procedure Run; override;
  end;
  TNewFireDragon = class(TFireDragon)//火龙2(岩浆攻击，大火圈攻击，触发守护兽攻击)
    m_boChangeColor: Boolean;//是否改变颜色
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure RecalcAbilitys(); override; //刷新属性
    function AttackTarget(): Boolean; override;
  end;
  TDevilBat = class(TMonster)//恶魔蝙蝠  施毒术,气功波,抗拒,野蛮对它无效，只有捆魔咒可以捆住,只有刺杀的第2格能攻击到 攻击方式靠近人物自爆攻击
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
    function AttackTarget(): Boolean; override;
    procedure Run; override;
  end;
  TSnowyFireDay = class(TMonster)//雪域灭天魔:灭天火，会施放红毒
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
    function AttackTarget(): Boolean; override;
    procedure Run; override;
  end;
  TSnowyHanbing = class(TMonster)//雪域寒冰魔:冰咆哮，会施放绿毒
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
    function AttackTarget(): Boolean; override;
    procedure Run; override;
  end;
  TSnowyWuDu = class(TMonster)//雪域五毒魔:寒冰掌，治疗术,如月灵一样,边打边躲避
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
    function AttackTarget(): Boolean; override;
    procedure Run; override;
  end;
  TSnowBodyguards = class(TMonster)//雪域待卫: 追刺,造成加倍的重伤,距离它们身前4格范围的敌人都不能幸免
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
    function AttackTarget(): Boolean; override;
    procedure Run; override;
  end;
  TSnowWarWill = class(TMonster)//雪域战将: 2格攻击范围，它们就会使出附带魔法攻击的横扫技能，攻击力爆增
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
    function AttackTarget(): Boolean; override;
    procedure Run; override;
  end;
  TSnowBeelzebub = class(TMonster)//雪域魔王
    m_dwFreezeMagicTick: LongWord;//冰冻术间隔
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
    function AttackTarget(): Boolean; override;
    procedure Run; override;
  end;
  TSnowDaysWillBe = class(TMonster)//雪域天将:可攻击周围8格目标，一定间隔使用"冰冻术"
  private
    m_dwFreezeMagicTick: LongWord;//冰冻术间隔
  public
    constructor Create(); override;
    destructor Destroy; override;
    function AttackTarget(): Boolean; override;
    procedure Run; override;
  end;
  TSnowGuardian = class(TMonster)//雪域卫士
  private
    procedure MeltStone; //
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
    function AttackTarget(): Boolean; override;
  end;

  TAutoPathFindMon = class(TAnimalObject) //寻路类怪物
    m_dwThinkTick: LongWord;
    m_dwShowHint: LongWord;//提示行进坐标间隔
    m_boDupMode: Boolean;
    m_nAutoX: Integer; //坐标X
    m_nAutoY: Integer; //坐标Y
    sOleMapName: string; //旧地图ID
    Path: TPath;
    nPathCount: Integer;
    PlayObject: TPlayObject;//触发使用
  private
    function Think: Boolean;
    procedure MonGotoQF(sStr: String);
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
    procedure Die; override;
    procedure GotoTargetXY; override;
    procedure RecalcAbilitys(); override;
    procedure ScatterBagItems(ItemOfCreat: TBaseObject); override;
  end;
  TIceEyesTroll = class(TMonster)//冰眼巨魔(不会分身)
    m_dwFreezeMagicTick: LongWord;//冰冻术间隔
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
    function AttackTarget(): Boolean; override;
    procedure RecalcAbilitys(); override; //刷新属性
    procedure Run; override;
  end;
  TIceEyesTrollAvatar = class(TMonster)//冰眼巨魔(血量低时,会分身)
    m_boAvatar: Boolean;//是否分身
    m_boIsCopyMon: Boolean;//是分身
    m_SlaveObjectList: TList;
    m_dwFreezeMagicTick: LongWord;//冰冻术间隔
  private
    procedure CallSlave;//召唤下属
  public
    constructor Create(); override;
    destructor Destroy; override;
    function AttackTarget(): Boolean; override;
    procedure Run; override;
    procedure Die; override;
  end;
  TRedFox = class(TMonster)//赤狐:红色雷电(类似雷电术)
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
    function AttackTarget(): Boolean; override;
    procedure Run; override;
  end;
  TRedFoxWang = class(TRedFox)//赤狐王:红色雷电(类似雷电术,减对方蓝)，不能毒
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
    function AttackTarget(): Boolean; override;
  end;
  TSuFox = class(TMonster)//素狐:类似诅咒术效果(群攻)
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
    function AttackTarget(): Boolean; override;
    procedure Run; override;
  end;
  TSuFoxWang = class(TSuFox)//素狐王:似诅咒术效果(群攻)，放减防技能，不能毒
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
    function AttackTarget(): Boolean; override;
  end;
  TBlackFox = class(TMonster)//黑狐:施放刺杀剑术
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
    function AttackTarget(): Boolean; override;
    procedure Run; override;
  end;
  TBlackFoxWang = class(TBlackFox)//黑狐王:施放刺杀剑术，不能毒
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
    function AttackTarget(): Boolean; override;
  end;
  TMagicEye = class(TMonster)//狐月之眼:2格攻击，会自爆攻击,死时会放出一堆2*2火墙
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
    function AttackTarget(): Boolean; override;
    procedure Run; override;
    procedure Die; override;
  end;
  TMagicEye1 = class(TMagicEye)//狐月魔眼:2格攻击，会自爆攻击,死时会放出一堆火墙
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Die; override;
  end;
  TMagicEye2 = class(TAnimalObject)//朱火弹:受到攻击后，膨胀3秒，然后爆炸，产生十字火墙 目标受到火墙伤害立即死亡
  private
    m_nFireCount: Byte;//火墙数量
    m_boFirst: Boolean;
    m_boFirstStruck: Boolean;//受攻击发送转动消息
    m_boFirstLighting: Boolean;//是否发过膨涨消息
    m_boFirstTick: Boolean;
    m_dwExplosionTick: LongWord;//爆炸计时
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
    procedure Initialize; override;
    procedure Die; override;
    function Operate(ProcessMsg: pTProcessMessage): Boolean; override;
    function IsProperTarget(BaseObject: TBaseObject): Boolean; override;
    function GetShowName(): string;override;
    procedure StruckDamage(nDamage: Integer);override;//受攻击,不掉血
    procedure Wondering(); override;//不移动
  end;
  //朱火魔:会在身后随机释放朱火弹,不受火墙伤害;受到攻击后,会尝试引爆周围2格范围的
  //       所有朱火弹;可进行3次分身,3次分身后死亡
  TZhuFireMon = class(TAnimalObject)
  private
    m_nCopySelfCount: Byte;//分身次数
    m_PointManager: TPointManager;
    m_Path: TPath;
    m_nPostion: Integer;
    m_RunPos: TRunPos;
    m_nMoveFailCount: Integer;
    BBList: TList;
    dwTick5F5: LongWord;//召唤朱火弹间隔
    dwTick5F6: LongWord;//召唤分身间隔
    dwTick5F4: LongWord;//跑步计时
    dwTick5F8: LongWord;//变向间隔
    function RunToNext(nX, nY: Integer): Boolean;
    function WalkToNext(nX, nY: Integer): Boolean;
    procedure StruckToMagicEye2();//尝试引爆周围2格范围的所有朱火弹
  protected
    function GotoNextOne(nX, nY: Integer; boRun: Boolean): Boolean;
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Initialize; override;
    function Operate(ProcessMsg: pTProcessMessage): Boolean; override;
    procedure StruckDamage(nDamage: Integer);override;//受攻击,不掉血
    procedure Run; override;
    procedure Wondering(); override;
    function AttackTarget(): Boolean;
  end;
  TSoulStone = class(TAnimalObject)//九尾魂石(不会移动,全屏攻击,毒无效,能网人,流星火雨技能,在四周放出四个超强旋涡)
    m_dwUseTick: LongWord;
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
    function AttackTarget(): Boolean;
    procedure Run; override;
  end;
  TFoxBeads = class(TAnimalObject{TMonster})//狐月天珠(HP低于66.5%时,召唤四个九尾魂石,能放冷冻术,放绿毒) 2011022
    m_nX,m_nY:integer;//出生时的坐标
    nStatus: Byte;//状态
    boCall: Boolean;//是否召唤九尾魂石
    nCallXY: array[0..3] of TCharDesc1;//记录召唤九尾魂石的坐标
    btCallRaceServer: Byte;//召唤九尾魂石的角色类型
    m_dwCallTick: LongWord;//召唤间隔,检查召唤的九尾魂石是否死了，死了则重新召唤
  private
    procedure CallSlave;//召唤九尾魂石
    function CheckCallSlaveDie(): Boolean;//检查召唤九尾魂石是否死亡
  public
    constructor Create(); override;
    destructor Destroy; override;
    function AttackTarget(): Boolean; //override;
    procedure RecalcAbilitys; override;
    procedure Run; override;
  end;
  TWhiteTigerMonster = class(TSnowBodyguards)//白虎王,近攻1格群体掉血,长攻，同方向3格掉血
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
    function AttackTarget(): Boolean; override;
  end;
implementation

uses M2Share, HUtil32, Castle, Guild, Event, ObjHero, StrUtils;


{ TStickMonster }
constructor TStickMonster.Create; //004A51C0
begin
  inherited;
  bo550 := False;
  m_nViewRange := 7;
  m_nRunTime := 250;
  m_dwSearchTime := Random(1500) + 2500;
  m_dwSearchTick := GetTickCount();
  m_btRaceServer := 85;
  n554 := 4;
  n558 := 4;
  m_boFixedHideMode := True;
  m_boStickMode := True;
  m_boAnimal := True;
end;

destructor TStickMonster.Destroy; //004A5290
begin

  inherited;
end;
function TStickMonster.AttackTarget: Boolean;
var
  btDir: Byte;
begin
  Result := False;
  if m_TargetCret = nil then Exit;
  if GetAttackDir(m_TargetCret, btDir) then begin
    if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
      m_dwHitTick := GetTickCount();
      m_dwTargetFocusTick := GetTickCount();
      Attack(m_TargetCret, btDir);
    end;
    Result := True;
    Exit;
  end;
  if m_TargetCret.m_PEnvir = m_PEnvir then begin
    if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 11) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 11) then begin //20080605 增加
      SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
    end;
  end else begin
    DelTargetCreat();
  end;
end;

procedure TStickMonster.sub_FFE9();
begin
  m_boFixedHideMode := False;
  SendRefMsg(RM_DIGUP, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
end;
procedure TStickMonster.VisbleActors(); //004A53E4
var
  I: Integer;
resourcestring
  sExceptionMsg = '{%s} TStickMonster::VisbleActors Dispose';
begin
  SendRefMsg(RM_DIGDOWN, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
  try
    if m_VisibleActors.Count > 0 then begin//20080629
      for I := 0 to m_VisibleActors.Count - 1 do begin
        Dispose({pTVisibleBaseObject}(m_VisibleActors.Items[I]));
      end;
    end;
    m_VisibleActors.Clear;
  except
    MainOutMessage(Format(sExceptionMsg,[g_sExceptionVer]));
  end;
  m_boFixedHideMode := True;
end;
procedure TStickMonster.sub_FFEA(); //004A53E4
var
  I: Integer;
  BaseObject: TBaseObject;
begin
  if m_VisibleActors.Count > 0 then begin//20080629
    for I := 0 to m_VisibleActors.Count - 1 do begin
      BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
      if BaseObject = nil then Continue;
      if BaseObject.m_boDeath then Continue;
      if IsProperTarget(BaseObject) then begin
        if not BaseObject.m_boHideMode or m_boCoolEye then begin
          if (abs(m_nCurrX - BaseObject.m_nCurrX) < n554) and (abs(m_nCurrY - BaseObject.m_nCurrY) < n554) then begin
            sub_FFE9();
            Break;
          end;
        end;
      end;
    end; // for
  end;
end;

function TStickMonster.Operate(ProcessMsg: pTProcessMessage): Boolean;
begin
  Result := inherited Operate(ProcessMsg);
end;

procedure TStickMonster.Run; //004A5614
var
  bo05: Boolean;
begin
  try
    if not m_boGhost and not m_boDeath and (m_wStatusTimeArr[POISON_STONE {5}] = 0)
      and (m_wStatusTimeArr[POISON_LOCKSPELL {2}] = 0) and
      (m_wStatusArrValue[23] = 0) then begin
      if Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed then begin
        m_dwWalkTick := GetTickCount();
        if m_boFixedHideMode then begin
          sub_FFEA();
        end else begin
          if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
            if m_boIsVisibleActive then SearchTarget();//20090503 修改
          end;
          bo05 := False;
          if m_TargetCret <> nil then begin
            if (abs(m_TargetCret.m_nCurrX - m_nCurrX) > n558) or
              (abs(m_TargetCret.m_nCurrY - m_nCurrY) > n558) then begin
              bo05 := True;
            end;
          end else bo05 := True;
          if bo05 then begin
            VisbleActors();
          end else begin
            if AttackTarget then begin
              inherited;
              Exit;
            end;
          end;
        end;
      end;
    end;
  except
    MainOutMessage(Format('{%s} TStickMonster.Run',[g_sExceptionVer]));
  end;
  inherited;
end;



{ TSoccerBall }

constructor TSoccerBall.Create; //004A764C
begin
  inherited;
  m_boAnimal := False;
  m_boSuperMan := True;
  n550 := 0;
  m_nTargetX := -1;
end;

destructor TSoccerBall.Destroy;
begin
  inherited;
end;

procedure TSoccerBall.Run;
var
  n08, n0C: Integer;
  bo0D: Boolean;
begin
  try
    if n550 > 0 then begin
      if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, 1, n08, n0C) then begin
        if m_PEnvir.CanWalk(n08, n0C, bo0D) then begin
          case m_btDirection of //
           { 0: m_btDirection := 4; //20100629 修改
            1: m_btDirection := 7;
            2: m_btDirection := 6;
            3: m_btDirection := 5;
            4: m_btDirection := 0;
            5: m_btDirection := 3;
            6: m_btDirection := 2;
            7: m_btDirection := 1; }
            0: m_btDirection := 4;
            1: m_btDirection := 5;
            2: m_btDirection := 6;
            3: m_btDirection := 7;
            4: m_btDirection := 0;
            5: m_btDirection := 1;
            6: m_btDirection := 2;
            7: m_btDirection := 3;
          end; // case
          //m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, n550, {m_nTargetX, m_nTargetY}n08, n0C);//20100629 修改
        end;
      end;
    end else begin //004A78A1
      m_nTargetX := -1;
    end;
    if m_nTargetX <> -1 then begin
      GotoTargetXY();
      if (m_nTargetX = m_nCurrX) and (m_nTargetY = m_nCurrY) then n550 := 0;
      if n550 > 0 then Dec(n550);//20100629 增加
    end;
  except
    MainOutMessage(Format('{%s} TSoccerBall.Run',[g_sExceptionVer]));
  end;
  inherited;
end;

procedure TSoccerBall.Struck(hiter: TBaseObject);
begin
  if hiter = nil then Exit;
  m_btDirection := hiter.m_btDirection;
  n550 := Random(4) + (n550 + 4);
  n550 := _MIN(20, n550);
  m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, n550, m_nTargetX, m_nTargetY);
end;

{ TBeeQueen }

constructor TBeeQueen.Create; //004A5750
begin
  inherited;
  m_nViewRange := 9;
  m_nRunTime := 250;
  m_dwSearchTime := Random(1500) + 2500;
  m_dwSearchTick := GetTickCount();
  m_boStickMode := True;
  BBList := TList.Create;
end;

destructor TBeeQueen.Destroy; //004A57F0
begin
  BBList.Free;
  inherited;
end;

procedure TBeeQueen.MakeChildBee;
begin
  if BBList.Count >= 15 then Exit;
  SendRefMsg(RM_HIT, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
  SendDelayMsg(Self, RM_ZEN_BEE, 0, 0, 0, 0, '', 500);
end;

function TBeeQueen.Operate(ProcessMsg: pTProcessMessage): Boolean;
var
  BB: TBaseObject;
begin
  try
    if ProcessMsg.wIdent = RM_ZEN_BEE then begin
      BB := UserEngine.RegenMonsterByName(m_PEnvir.sMapName, m_nCurrX, m_nCurrY, g_Config.sBee);
      if BB <> nil then begin
        BB.SetTargetCreat(m_TargetCret);
        BBList.Add(BB);
      end;
    end;
    Result := inherited Operate(ProcessMsg);
  except
    MainOutMessage(Format('{%s} TBeeQueen.Operate',[g_sExceptionVer]));
  end;
end;

procedure TBeeQueen.Run;
var
  I: Integer;
  BB: TBaseObject;
begin
  if not m_boGhost and not m_boDeath and (m_wStatusTimeArr[POISON_STONE {5}] = 0)
    and (m_wStatusTimeArr[POISON_LOCKSPELL {2}] = 0) and (m_wStatusArrValue[23] = 0) then begin
    if Integer(GetTickCount - m_dwWalkTick) >= m_nWalkSpeed then begin
      m_dwWalkTick := GetTickCount();
      if Integer(GetTickCount - m_dwHitTick) >= m_nNextHitTime then begin
        m_dwHitTick := GetTickCount();
        if m_boIsVisibleActive then SearchTarget();//20090503 修改
        if m_TargetCret <> nil then MakeChildBee();
      end;
      for I := BBList.Count - 1 downto 0 do begin
        if BBList.Count <= 0 then Break;//20080917
        BB := TBaseObject(BBList.Items[I]);
        if (BB <> nil) then begin
          if (BB.m_boDeath) or (BB.m_boGhost) then BBList.Delete(I);
        end;
      end;
    end;
  end;
  inherited;
end;

{ TCentipedeKingMonster }

constructor TCentipedeKingMonster.Create; //004A5A8C
begin
  inherited;
  m_nViewRange := 6;
  n554 := 4;
  n558 := 6;
  m_boAnimal := False;
  m_dwAttickTick := GetTickCount();
end;

destructor TCentipedeKingMonster.Destroy;
begin
  inherited;
end;

function TCentipedeKingMonster.sub_4A5B0C: Boolean;
var
  I: Integer;
  BaseObject: TBaseObject;
begin
  Result := False;
  if m_VisibleActors.Count > 0 then begin//20080629
    for I := 0 to m_VisibleActors.Count - 1 do begin
      BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
      if BaseObject = nil then Continue;
      if BaseObject.m_boDeath then Continue;
      if IsProperTarget(BaseObject) then begin
        if (abs(m_nCurrX - BaseObject.m_nCurrX) <= m_nViewRange) and (abs(m_nCurrY - BaseObject.m_nCurrY) <= m_nViewRange) then begin
          Result := True;
          Break;
        end;
      end;
    end;
  end;
end;

function TCentipedeKingMonster.AttackTarget: Boolean; //004A5BC0
var
  WAbil: pTAbility;
  nPower, I: Integer;
  BaseObject: TBaseObject;
begin
  Result := False;
  if not sub_4A5B0C then begin
    Exit;
  end;
  if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
    m_dwHitTick := GetTickCount();
    SendAttackMsg(RM_HIT, m_btDirection, 0, m_nCurrX, m_nCurrY);
    WAbil := @m_WAbil;
    nPower := (Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) + 1) + LoWord(WAbil.DC));
    if m_VisibleActors.Count > 0 then begin//20080629
      for I := 0 to m_VisibleActors.Count - 1 do begin
        BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
        if BaseObject = nil then Continue;
        if BaseObject.m_boDeath then Continue;
        if IsProperTarget(BaseObject) then begin
          if (abs(m_nCurrX - BaseObject.m_nCurrX) < m_nViewRange) and (abs(m_nCurrY - BaseObject.m_nCurrY) < m_nViewRange) then begin
            m_dwTargetFocusTick := GetTickCount();
            SendDelayMsg(Self, RM_DELAYMAGIC, nPower, MakeLong(BaseObject.m_nCurrX, BaseObject.m_nCurrY), 2, Integer(BaseObject), '', 600);
            if Random(4) = 0 then begin
              if Random(3) <> 0 then begin
                BaseObject.MakePosion(POISON_DECHEALTH, 60, 3);
              end else begin
                if (not BaseObject.m_boUnParalysis) {$IF M2Version <> 2}and (not BaseObject.m_boCanUerSkill102){$IFEND} and (Random(100) >= BaseObject.m_nUnParalysisRate) then BaseObject.MakePosion(POISON_STONE, 5, 0);//20100513 修改
              end;
              m_TargetCret := BaseObject;
            end;
          end;
        end;
      end; // for
    end;
  end;
  Result := True;
end;

procedure TCentipedeKingMonster.sub_FFE9;
begin
  inherited;
  m_WAbil.HP := m_WAbil.MaxHP;
end;

procedure TCentipedeKingMonster.Run;
var
  I: Integer;
  BaseObject: TBaseObject;
begin
  if not m_boGhost and not m_boDeath and (m_wStatusTimeArr[POISON_STONE {5}] = 0)
    and (m_wStatusTimeArr[POISON_LOCKSPELL{7}] = 0) and (m_wStatusArrValue[23] = 0) then begin
    if Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed then begin
      m_dwWalkTick := GetTickCount();
      if m_boFixedHideMode then begin
        if (GetTickCount - m_dwAttickTick) > 10000 then begin
          if m_VisibleActors.Count > 0 then begin//20080629
            for I := 0 to m_VisibleActors.Count - 1 do begin
              BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
              if BaseObject = nil then Continue;
              if BaseObject.m_boDeath then Continue;
              if IsProperTarget(BaseObject) then begin
                if not BaseObject.m_boHideMode or m_boCoolEye then begin
                  if (abs(m_nCurrX - BaseObject.m_nCurrX) < n554) and (abs(m_nCurrY - BaseObject.m_nCurrY) < n554) then begin
                    sub_FFE9();
                    m_dwAttickTick := GetTickCount();
                    Break;
                  end;
                end;
              end;
            end;
          end;
        end; //004A5F86
      end else begin
        if (GetTickCount - m_dwAttickTick) > 3000 then begin
          if AttackTarget() then begin
            inherited;
            Exit;
          end;
          if (GetTickCount - m_dwAttickTick) > 10000 then begin
            VisbleActors();
            m_dwAttickTick := GetTickCount();
          end;
        end;
      end;
    end;
  end;
  inherited;
end;


{ TBigHeartMonster }

constructor TBigHeartMonster.Create;
begin
  inherited;
  m_nViewRange := 16;
  m_boAnimal := False;
end;

destructor TBigHeartMonster.Destroy;
begin
  inherited;
end;

function TBigHeartMonster.AttackTarget(): Boolean;
var
  I: Integer;
  BaseObject: TBaseObject;
  nPower: Integer;
  WAbil: pTAbility;
begin
  Result := False;
  if {Integer}(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin//20080815 修改
    m_dwHitTick := GetTickCount();
    SendRefMsg(RM_HIT, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
    WAbil := @m_WAbil;
    nPower := (Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) + 1) + LoWord(WAbil.DC));
    if m_VisibleActors.Count > 0 then begin//20080629
      for I := 0 to m_VisibleActors.Count - 1 do begin
        BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
        if BaseObject = nil then Continue;
        if BaseObject.m_boDeath then Continue;
        if IsProperTarget(BaseObject) then begin
          if (abs(m_nCurrX - BaseObject.m_nCurrX) <= m_nViewRange) and (abs(m_nCurrY - BaseObject.m_nCurrY) <= m_nViewRange) then begin
            SendDelayMsg(Self, RM_DELAYMAGIC, nPower, MakeLong(BaseObject.m_nCurrX, BaseObject.m_nCurrY), 1, Integer(BaseObject), '', 200);
            SendRefMsg(RM_10205, 1 {type}, BaseObject.m_nCurrX, BaseObject.m_nCurrY, 0, '');
          end;
        end;
      end; // for
    end;
    Result := True;
  end;
  //  inherited;
end;

procedure TBigHeartMonster.Run; //004A617C
begin
  if not m_boGhost and not m_boDeath and (m_wStatusTimeArr[POISON_STONE{5}] = 0)
    and (m_wStatusTimeArr[POISON_LOCKSPELL{7}] = 0) and (m_wStatusArrValue[23] = 0) then begin
    if m_VisibleActors <> nil then begin
      if m_VisibleActors.Count > 0 then AttackTarget();
    end;
  end;
  inherited;
end;

{ TSpiderHouseMonster }

constructor TSpiderHouseMonster.Create; //004A61D0
begin
  inherited;
  m_nViewRange := 9;
  m_nRunTime := 250;
  m_dwSearchTime := Random(1500) + 2500;
  m_dwSearchTick := 0;
  m_boStickMode := True;
  BBList := TList.Create;
end;

destructor TSpiderHouseMonster.Destroy;
begin
  BBList.Free;
  inherited;
end;

procedure TSpiderHouseMonster.GenBB;
begin
  if BBList.Count < 15 then begin
    SendRefMsg(RM_HIT, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
    SendDelayMsg(Self, RM_ZEN_BEE, 0, 0, 0, 0, '', 500);
  end;
end;

function TSpiderHouseMonster.Operate(ProcessMsg: pTProcessMessage): Boolean;
var
  BB: TBaseObject;
  n08, n0C: Integer;
begin
  if ProcessMsg.wIdent = RM_ZEN_BEE then begin
    n08 := m_nCurrX;
    n0C := m_nCurrY + 1;
    if m_PEnvir.CanWalk(n08, n0C, True) then begin
      BB := UserEngine.RegenMonsterByName(m_PEnvir.sMapName, n08, n0C, g_Config.sSpider);
      if BB <> nil then begin
        BB.SetTargetCreat(m_TargetCret);
        BBList.Add(BB);
      end;
    end;
  end;
  Result := inherited Operate(ProcessMsg);
end;

procedure TSpiderHouseMonster.Run;
var
  I: Integer;
  BB: TBaseObject;
begin
  if not m_boGhost and not m_boDeath and (m_wStatusTimeArr[POISON_STONE {5}] = 0)
    and (m_wStatusTimeArr[POISON_LOCKSPELL{7}] = 0) and (m_wStatusArrValue[23] = 0) then begin
    if Integer(GetTickCount - m_dwWalkTick) >= m_nWalkSpeed then begin
      m_dwWalkTick := GetTickCount();
      if Integer(GetTickCount - m_dwHitTick) >= m_nNextHitTime then begin
        m_dwHitTick := GetTickCount();
        if m_boIsVisibleActive then SearchTarget();//20090503 修改
        if m_TargetCret <> nil then GenBB();
      end;
      for I := BBList.Count - 1 downto 0 do begin
        if BBList.Count <= 0 then Break;
        BB := TBaseObject(BBList.Items[I]);
        if BB <> nil then begin
          if BB.m_boDeath or (BB.m_boGhost) then BBList.Delete(I);
        end;
      end; // for
    end;
  end;
  inherited;
end;

{ TExplosionSpider }

constructor TExplosionSpider.Create;
//004A6538
begin
  inherited;
  m_nViewRange := 5;
  m_nRunTime := 250;
  m_dwSearchTime := Random(1500) + 2500;
  m_dwSearchTick := 0;
  dw558 := GetTickCount();
end;

destructor TExplosionSpider.Destroy;
begin

  inherited;
end;
procedure TExplosionSpider.sub_4A65C4;
var
  WAbil: pTAbility;
  I, nPower, n10: Integer;
  BaseObject: TBaseObject;
begin
  m_WAbil.HP := 0;
  WAbil := @m_WAbil;
  nPower := (Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) + 1) + LoWord(WAbil.DC));
  if m_VisibleActors.Count > 0 then begin//20080629
    for I := 0 to m_VisibleActors.Count - 1 do begin
      BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
      if BaseObject = nil then Continue;
      if BaseObject.m_boDeath then Continue;
      if IsProperTarget(BaseObject) then begin
        if (abs(m_nCurrX - BaseObject.m_nCurrX) <= 1) and (abs(m_nCurrY - BaseObject.m_nCurrY) <= 1) then begin
          n10 := 0;
          Inc(n10, BaseObject.GetHitStruckDamage(Self, nPower div 2));
          Inc(n10, BaseObject.GetMagStruckDamage(Self, nPower div 2, 0, 0));
          if n10 > 0 then begin
            BaseObject.StruckDamage(n10);
            BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, n10, BaseObject.m_WAbil.HP, BaseObject.m_WAbil.MaxHP, Integer(Self), '', 700);
          end;
        end;
      end;
    end; // for
  end;
end;
function TExplosionSpider.AttackTarget: Boolean;
var
  btDir: Byte;
begin
  Result := False;
  if m_TargetCret = nil then Exit;
  if GetAttackDir(m_TargetCret, btDir) then begin
    if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
      m_dwHitTick := GetTickCount();
      m_dwTargetFocusTick := GetTickCount();
      sub_4A65C4();
    end;
    Result := True;
  end else begin
    if m_TargetCret.m_PEnvir = m_PEnvir then begin
      if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 11) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 11) then begin //20080605 增加
         SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      end;
    end else begin
      DelTargetCreat(); {0FFF1h}
    end;
  end;
end;

procedure TExplosionSpider.Run;
begin
  if not m_boDeath and not m_boGhost then
    if (GetTickCount - dw558) > 60000{60 * 1000} then begin
      dw558 := GetTickCount();
      sub_4A65C4();
    end;
  inherited;
end;

{ TGuardUnit }
procedure TGuardUnit.Struck(hiter: TBaseObject);
begin
  inherited;
  if m_Castle <> nil then begin
    bo2B0 := True;
    m_dw2B4Tick := GetTickCount();
  end;
end;

//是适当的目标
function TGuardUnit.IsProperTarget(BaseObject: TBaseObject): Boolean;
var nCode: Byte;
begin
  nCode:= 0;
  Result := False;
  try
    if m_Castle <> nil then begin
      nCode:= 1;
      if m_LastHiter = BaseObject then Result := True;
      if (BaseObject <> nil) then begin
        nCode:= 2;
        if (BaseObject.bo2B0) then begin
          if (GetTickCount - BaseObject.m_dw2B4Tick) < 120000{2 * 60 * 1000} then begin
            Result := True;
          end else BaseObject.bo2B0 := False;
          if BaseObject.m_Castle <> nil then begin
            BaseObject.bo2B0 := False;
            Result := False;
          end;
        end;
      end;
      nCode:= 3;
      if TUserCastle(m_Castle).m_boUnderWar then Result := True;
      if TUserCastle(m_Castle).m_MasterGuild <> nil then begin//所属行会存在
        nCode:= 4;
        if (BaseObject <> nil) then begin//20090512 增加
          if BaseObject.m_Master = nil then begin
            nCode:= 5;
            if (TUserCastle(m_Castle).m_MasterGuild = BaseObject.m_MyGuild) or 
              (TUserCastle(m_Castle).m_MasterGuild.IsAllyGuild(TGUild(BaseObject.m_MyGuild))) then begin
              if m_LastHiter <> BaseObject then Result := False;
            end;
          end else begin //004A6988
            nCode:= 6;
            if BaseObject.m_Master.m_Master <> nil then begin//英雄的宝宝或英雄的分身 20090628 增加
              nCode:= 11;
              if BaseObject.m_Master.m_Master.m_MyGuild <> nil then begin
                if (TUserCastle(m_Castle).m_MasterGuild = BaseObject.m_Master.m_Master.m_MyGuild) or
                  (TUserCastle(m_Castle).m_MasterGuild.IsAllyGuild(TGUild(BaseObject.m_Master.m_Master.m_MyGuild))) then begin
                  if (m_LastHiter <> BaseObject.m_Master.m_Master) and (m_LastHiter <> BaseObject) then Result := False;
                end;
              end;
            end else begin
              nCode:= 12;
              if (TUserCastle(m_Castle).m_MasterGuild = BaseObject.m_Master.m_MyGuild) or
                (TUserCastle(m_Castle).m_MasterGuild.IsAllyGuild(TGUild(BaseObject.m_Master.m_MyGuild))) then begin
                if (m_LastHiter <> BaseObject.m_Master) and (m_LastHiter <> BaseObject) then Result := False;
              end;
            end;
          end;
        end;
      end; //004A69EF
      nCode:= 7;
      if (BaseObject <> nil) then begin//20090512 修改
        if BaseObject.m_boAdminMode or
           BaseObject.m_boStoneMode or
           ((BaseObject.m_btRaceServer >= 10) and
           (BaseObject.m_btRaceServer < 50)) or
           (BaseObject = Self) or (BaseObject.m_Castle = Self.m_Castle) then begin
           Result := False;
        end;
      end;
      Exit;
    end; //004A6A41
    nCode:= 8;
    if (BaseObject <> nil) then begin//20090512 增加
      nCode:= 9;
      if m_LastHiter <> nil then begin//20090513 增加
        if m_LastHiter = BaseObject then Result := True;
      end;
      nCode:= 11;
      if (BaseObject.m_TargetCret <> nil) then begin
        nCode:= 13;
        if (BaseObject.m_TargetCret.m_btRaceServer = 112) then Result := True;
      end;
      nCode:= 10;
      if (BaseObject.PKLevel >= 2) then Result := True;//红名人物
      if BaseObject.m_boAdminMode or BaseObject.m_boStoneMode or (BaseObject = Self) then Result := False;
    end;
  except
    MainOutMessage(Format('{%s} TGuardUnit.IsProperTarget Code:%d',[g_sExceptionVer, nCode]));
  end;
end;

{ TArcherGuard 弓箭手}

constructor TArcherGuard.Create; //004A6AB4
begin
  inherited;
  m_nViewRange := 12; //可视范围
  m_boWantRefMsg := True;
  m_Castle := nil;//城堡
  m_nDirection := -1; //方向
  m_btRaceServer := 112;//怪类型
end;

destructor TArcherGuard.Destroy;
begin

  inherited;
end;
//弓箭手NPC
procedure TArcherGuard.sub_4A6B30(TargeTBaseObject: TBaseObject); //004A6B30
var
  nPower: Integer;
  WAbil: pTAbility;
  nCode: Byte;//20090513 增加
begin
  nCode:= 0;
  try
    if (TargeTBaseObject <> nil) and (not m_boGhost) and (not m_boDeath) then begin//20090513 修改
      if (not TargeTBaseObject.m_boGhost) and (not TargeTBaseObject.m_boDeath) then begin//20090513 修改
        nCode:= 1;
        m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, TargeTBaseObject.m_nCurrX, TargeTBaseObject.m_nCurrY);
        nCode:= 2;
        WAbil := @m_WAbil;
        nCode:= 3;
        nPower := (Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) + 1) + LoWord(WAbil.DC));
        if nPower > 0 then
          nPower := TargeTBaseObject.GetHitStruckDamage(Self, nPower);
        nCode:= 4;
        if nPower > 0 then begin
          nCode:= 5;
          TargeTBaseObject.SetLastHiter(Self);
          TargeTBaseObject.m_ExpHitter := nil;
          nCode:= 6;
          TargeTBaseObject.StruckDamage(nPower);
          nCode:= 7;
          TargeTBaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nPower, TargeTBaseObject.m_WAbil.HP, TargeTBaseObject.m_WAbil.MaxHP, Integer(Self), '',
            _MAX(abs(m_nCurrX - TargeTBaseObject.m_nCurrX), abs(m_nCurrY - TargeTBaseObject.m_nCurrY)) * 50 + 600);
        end;
        nCode:= 8;
        SendRefMsg(RM_FLYAXE, m_btDirection, m_nCurrX, m_nCurrY, Integer(TargeTBaseObject), '');
      end;
    end;
  except
    MainOutMessage(Format('{%s} TArcherGuard.sub_4A6B30 Code:%d',[g_sExceptionVer, nCode]));
  end;
end;

procedure TArcherGuard.Run;
var
  I: Integer;
  nAbs: Integer;
  nRage: Integer;
  BaseObject: TBaseObject;
  TargeTBaseObject: TBaseObject;
  nCode: Byte;//20090318
begin
  try
    nCode:= 0;
   //nRage := 9999;
    nRage := 13;//搜索怪的范围 20080623
    TargeTBaseObject := nil;
    if not m_boDeath and not m_boGhost and (m_wStatusTimeArr[POISON_STONE] = 0)
      and (m_wStatusTimeArr[POISON_LOCKSPELL{7}] = 0) and (m_wStatusArrValue[23] = 0) then begin
      nCode:= 1;
      if Integer(GetTickCount - m_dwWalkTick) >= m_nWalkSpeed then begin
        m_dwWalkTick := GetTickCount();
        nCode:= 2;
        if (m_VisibleActors.Count > 0) and m_boIsVisibleActive then begin//20090519 修改
          for I := 0 to m_VisibleActors.Count - 1 do begin
            nCode:= 14;
            BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
            nCode:= 15;
            if BaseObject = nil then Continue;
            nCode:= 16;
            if BaseObject.m_boDeath then Continue;
            nCode:= 4;
            if IsProperTarget(BaseObject) then begin
              nAbs := abs(m_nCurrX - BaseObject.m_nCurrX) + abs(m_nCurrY - BaseObject.m_nCurrY);
              if nAbs < nRage then begin
                nRage := nAbs;
                nCode:= 5;
                TargeTBaseObject := BaseObject;
              end;
            end;
          end;//for
        end;
        nCode:= 6;
        if TargeTBaseObject <> nil then begin
          nCode:= 7;
          SetTargetCreat(TargeTBaseObject);
        end else begin
          nCode:= 8;
          DelTargetCreat();
        end;
      end;
      nCode:= 9;
      if m_TargetCret <> nil then begin
        if Integer(GetTickCount - m_dwHitTick) >= m_nNextHitTime then begin
          nCode:= 10;
          m_dwHitTick := GetTickCount();
          sub_4A6B30(m_TargetCret);
        end;
      end else begin
        if (m_nDirection >= 0) and (m_btDirection <> m_nDirection) then begin
          nCode:= 11;
          TurnTo(m_nDirection);
        end;
      end;
    end;
  except
    MainOutMessage(Format('{%s} TArcherGuard.Run Code:%d',[g_sExceptionVer, nCode]));
  end;
  inherited;
end;
//------------------------------------------------------------------------------
{ TArcherGuardMon 类似弓箭手的怪,只打怪物 20080121}

constructor TArcherGuardMon.Create; //004A6AB4
begin
  inherited;
  m_boWantRefMsg := True;
  m_Castle := nil;//城堡
  m_nDirection := -1; //方向
  m_btRaceServer := 135;//怪类型
  m_dwSearchTime := Random(1500) + {1500}2500;//搜索目标的时间 20090421 调整
end;

destructor TArcherGuardMon.Destroy;
begin

  inherited;
end;

procedure TArcherGuardMon.sub_4A6B30(TargeTBaseObject: TBaseObject); //004A6B30
var
  nPower: Integer;
  WAbil: pTAbility;
  spell:Boolean;
begin
  if TargeTBaseObject <> nil then begin
    spell:=False;
    case TargeTBaseObject.m_btRaceServer of
      11..65,67..99: spell:=True;
      101..107,110..111: spell:=True;
      115..120,136,150: spell:=True;
    end;
    if spell then begin
      m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, TargeTBaseObject.m_nCurrX, TargeTBaseObject.m_nCurrY);
      WAbil := @m_WAbil;
      nPower := (Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) + 1) + LoWord(WAbil.DC));
      if nPower > 0 then nPower := TargeTBaseObject.GetHitStruckDamage(Self, nPower);
      if nPower > 0 then begin
        TargeTBaseObject.SetLastHiter(Self);
        TargeTBaseObject.m_ExpHitter := nil;
        TargeTBaseObject.StruckDamage(nPower);
        TargeTBaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nPower, TargeTBaseObject.m_WAbil.HP, TargeTBaseObject.m_WAbil.MaxHP, Integer(Self), '',
          _MAX(abs(m_nCurrX - TargeTBaseObject.m_nCurrX), abs(m_nCurrY - TargeTBaseObject.m_nCurrY)) * 50 + 600);
      end;
      SendRefMsg(RM_FLYAXE, m_btDirection, m_nCurrX, m_nCurrY, Integer(TargeTBaseObject), '');
    end;
  end;
end;

procedure TArcherGuardMon.Run;
var
  I: Integer;
  BaseObject: TBaseObject;
  TargeTBaseObject: TBaseObject;
  spell:Boolean;
begin
  spell:=False;
  TargeTBaseObject := nil;
  if (m_Master=nil) or (CompareText(m_Master.m_sMapName,m_sMapName)<>0) then m_boDeath:=True; //主人不存在或与主人不在同一地图将自动消失

  if not m_boDeath and not m_boGhost and (m_wStatusTimeArr[POISON_STONE] = 0)
    and (m_wStatusTimeArr[POISON_LOCKSPELL{7}] = 0) and (m_wStatusArrValue[23] = 0) then begin
    if Integer(GetTickCount - m_dwWalkTick) >= m_nWalkSpeed then begin
      m_dwWalkTick := GetTickCount();
      if m_TargetCret = nil then begin
        if m_VisibleActors.Count > 0 then begin//20080629
          for I := 0 to m_VisibleActors.Count - 1 do begin
            BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
            if BaseObject = nil then Continue;
            if BaseObject.m_boDeath then Continue;
              case BaseObject.m_btRaceServer of
                11..65,67..99: spell:=True;
                101..107,110..111: spell:=True;
                115..120,136,150: spell:=True;
              end;
            if spell then begin
              //在可视范围,则攻击怪物目标
              if (abs(m_nCurrX - BaseObject.m_nCurrX) <= m_btCoolEye{怪的可视范围}) and (abs(m_nCurrY - BaseObject.m_nCurrY) <= m_btCoolEye) then begin
                TargeTBaseObject := BaseObject;//设置为攻击目标
                SetTargetCreat(TargeTBaseObject);//20080623
                if m_TargetCret <> nil then Break;//20080623
              end;
            end;
          end;//for
        end;
      end;
      if TargeTBaseObject <> nil then begin
        SetTargetCreat(TargeTBaseObject);
      end else begin
        DelTargetCreat();
      end;
    end;
    if m_TargetCret <> nil then begin
      if Integer(GetTickCount - m_dwHitTick) >= m_nNextHitTime then begin
        m_dwHitTick := GetTickCount();
        sub_4A6B30(m_TargetCret);
      end;
    end else begin
      if (m_nDirection >= 0) and (m_btDirection <> m_nDirection) then begin
        TurnTo(m_nDirection);
      end;
    end;
  end;
  inherited;
end;
//------------------------------------------------------------------------------
{ TArcherGuardMon1 136怪,不会移动,不会攻击 20080122}
constructor TArcherGuardMon1.Create;
begin
  inherited;
  m_Castle := nil;//城堡
  m_btRaceServer := 136;//怪类型
  m_boWalk:=False;
end;

destructor TArcherGuardMon1.Destroy;
begin
  inherited;
end;

function TArcherGuardMon1.WalkToTargetXY(nTargetX, nTargetY: Integer): Boolean;
var
  I: Integer;
  nDir: Integer;
  n10: Integer;
  n14: Integer;
  n20: Integer;
  nOldX: Integer;
  nOldY: Integer;
begin
  Result := False;
  if (nTargetX <> m_nCurrX) or (nTargetY <> m_nCurrY) then begin
    n10 := nTargetX;
    n14 := nTargetY;
    dwTick3F4 := GetTickCount();
   { nDir := DR_DOWN; //20081018 注释
    if n10 > m_nCurrX then begin
      nDir := DR_RIGHT;
      if n14 > m_nCurrY then nDir := DR_DOWNRIGHT;
      if n14 < m_nCurrY then nDir := DR_UPRIGHT;
    end else begin
      if n10 < m_nCurrX then begin
        nDir := DR_LEFT;
        if n14 > m_nCurrY then nDir := DR_DOWNLEFT;
        if n14 < m_nCurrY then nDir := DR_UPLEFT;
      end else begin
        if n14 > m_nCurrY then nDir := DR_DOWN
        else if n14 < m_nCurrY then nDir := DR_UP;
      end;
    end;   }
    nOldX := m_nCurrX;
    nOldY := m_nCurrY;

    nDir:= GetNextDirection(m_nCurrX , m_nCurrY, n10, n14);//20081018 增加
    WalkTo(nDir, False);
    if (nTargetX = m_nCurrX) and (nTargetY = m_nCurrY) then Result := True;
    if not Result then begin
      n20 := Random(3);
      for I := DR_UP to DR_UPLEFT do begin
        if (nOldX = m_nCurrX) and (nOldY = m_nCurrY) then begin
         { if n20 <> 0 then Inc(nDir)           //20080304 修改
          else if nDir > 0 then Dec(nDir)
          else nDir := DR_UPLEFT;
          if (nDir > DR_UPLEFT) then nDir := DR_UP; }

          if n20 <> 0 then Inc(nDir);//20080304 修改
          if (nDir > DR_UPLEFT) then nDir := DR_UP;//20080304 修改

          WalkTo(nDir, False);
          if (nTargetX = m_nCurrX) and (nTargetY = m_nCurrY) then begin
            Result := True;
            Break;
          end;
        end;
      end;
    end;
  end;
end;

procedure TArcherGuardMon1.Run;
begin
  if not m_boDeath and not m_boGhost and (m_wStatusTimeArr[POISON_STONE] = 0)
    and (m_wStatusTimeArr[POISON_LOCKSPELL{7}] = 0) and (m_wStatusArrValue[23] = 0) then begin
    if (Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed) and m_boWalk then begin//走动
      m_dwWalkTick := GetTickCount();
      if WalkToTargetXY( m_NewCurrX, m_NewCurrY) then begin
        MakeGhost();//20081018 到指定XY后,直接清除怪物
      end;
    end;
    //if Random(m_btCoolEye) <> 0 then m_boNoDropItem:=False;
  end;
  inherited;
end;
//------------------------------------------------------------------------------
{ TArcherPolice }

constructor TArcherPolice.Create; //004A6E14
begin
  inherited;
  m_btRaceServer := 20;
end;

destructor TArcherPolice.Destroy;
begin
  inherited;
end;

{ TCastleDoor }
constructor TCastleDoor.Create; //004A6E60
begin
  inherited;
  m_boAnimal := False;
  m_boStickMode := True;
  m_boOpened := False;
  m_btAntiPoison := 200;
  m_dwSearchTime:= Random(1500) + 3000;//20090506
end;

destructor TCastleDoor.Destroy;
begin
  inherited;
end;
procedure TCastleDoor.SetMapXYFlag(nFlag: Integer); //004A6FB4
var
  bo06: Boolean;
begin
  m_PEnvir.SetMapXYFlag(m_nCurrX, m_nCurrY - 2, True);
  m_PEnvir.SetMapXYFlag(m_nCurrX + 1, m_nCurrY - 1, True);
  m_PEnvir.SetMapXYFlag(m_nCurrX + 1, m_nCurrY - 2, True);
  if nFlag = 1 then bo06 := False
  else bo06 := True;
  m_PEnvir.SetMapXYFlag(m_nCurrX, m_nCurrY, bo06);
  m_PEnvir.SetMapXYFlag(m_nCurrX, m_nCurrY - 1, bo06);
  m_PEnvir.SetMapXYFlag(m_nCurrX, m_nCurrY - 2, bo06);
  m_PEnvir.SetMapXYFlag(m_nCurrX + 1, m_nCurrY - 1, bo06);
  m_PEnvir.SetMapXYFlag(m_nCurrX + 1, m_nCurrY - 2, bo06);
  m_PEnvir.SetMapXYFlag(m_nCurrX - 1, m_nCurrY, bo06);
  m_PEnvir.SetMapXYFlag(m_nCurrX - 2, m_nCurrY, bo06);
  m_PEnvir.SetMapXYFlag(m_nCurrX - 1, m_nCurrY - 1, bo06);
  m_PEnvir.SetMapXYFlag(m_nCurrX - 1, m_nCurrY + 1, bo06);
  if nFlag = 0 then begin
    m_PEnvir.SetMapXYFlag(m_nCurrX, m_nCurrY - 2, False);
    m_PEnvir.SetMapXYFlag(m_nCurrX + 1, m_nCurrY - 1, False);
    m_PEnvir.SetMapXYFlag(m_nCurrX + 1, m_nCurrY - 2, False);
  end;
end;

procedure TCastleDoor.Open;
begin
  if m_boDeath then Exit;
  m_btDirection := 7;
  SendRefMsg(RM_DIGUP, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
  m_boOpened := True;
  m_boStoneMode := True;
  SetMapXYFlag(0);
  bo2B9 := False;
end;

procedure TCastleDoor.Close;
begin
  if m_boDeath then Exit;
  m_btDirection := 3 - Round(m_WAbil.HP / m_WAbil.MaxHP * 3.0);
  if (m_btDirection - 3) >= 0 then m_btDirection := 0;
  SendRefMsg(RM_DIGDOWN, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
  m_boOpened := False;
  m_boStoneMode := False;
  SetMapXYFlag(1);
  bo2B9 := True;
end;

procedure TCastleDoor.Die;
begin
  inherited;
  dw560 := GetTickCount();
  SetMapXYFlag(2);
end;

procedure TCastleDoor.Run;
var
  n08: Integer;
begin
  if m_boDeath and (m_Castle <> nil) then
    m_dwDeathTick := GetTickCount()
  else m_nHealthTick := 0;
  if not m_boOpened then begin
    n08 := 3 - Round(m_WAbil.HP / m_WAbil.MaxHP * 3.0);
    if (m_btDirection <> n08) and (n08 < 3) then begin
      m_btDirection := n08;
      SendRefMsg(RM_TURN, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
    end;
  end;
  inherited;
end;

procedure TCastleDoor.RefStatus; //004A6F24
var
  n08: Integer;
begin
  n08 := 3 - Round(m_WAbil.HP / m_WAbil.MaxHP * 3.0);
  if (n08 - 3) >= 0 then n08 := 0;
  m_btDirection := n08;
  SendRefMsg(RM_ALIVE, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
end;

procedure TCastleDoor.Initialize; //0x004A6ECC
begin
  //  m_btDirection:=0;
  inherited;
  {
  if m_WAbil.HP > 0 then begin
    if m_boOpened then begin
      SetMapXYFlag(0);
      exit;
    end;
    SetMapXYFlag(1);
    exit;
  end;
  SetMapXYFlag(2);
  }
end;

{ TWallStructure 城墙类的怪(左中右墙)}

constructor TWallStructure.Create;
begin
  inherited;
  m_boAnimal := False;
  m_boStickMode := True;//不能冲撞模式(即敌人不能使用野蛮冲撞技能攻击)
  boSetMapFlaged := False;
  m_btAntiPoison := 200;//中毒躲避
  m_dwSearchTime:= Random(1500) + 3000;//20090506
end;

destructor TWallStructure.Destroy;
begin
  inherited;
end;

procedure TWallStructure.Initialize;
begin
  m_btDirection := 0;
  inherited;
end;

procedure TWallStructure.RefStatus;
var
  n08: Integer;
begin
  if m_WAbil.HP > 0 then begin
    n08 := 3 - Round(m_WAbil.HP / m_WAbil.MaxHP * 3.0);
  end else begin
    n08 := 4;
  end;
  if n08 >= 5 then n08 := 0;
  m_btDirection := n08;
  SendRefMsg(RM_ALIVE, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
end;

procedure TWallStructure.Die;
begin
  inherited;
  dw560 := GetTickCount();
end;

procedure TWallStructure.Run;
var
  n08: Integer;
begin
  if m_boDeath then begin
    m_dwDeathTick := GetTickCount();
    if boSetMapFlaged then begin
      m_PEnvir.SetMapXYFlag(m_nCurrX, m_nCurrY, True);
      boSetMapFlaged := False;
    end;
  end else begin
    m_nHealthTick := 0;
    if not boSetMapFlaged then begin
      m_PEnvir.SetMapXYFlag(m_nCurrX, m_nCurrY, False);
      boSetMapFlaged := True;
    end;
  end;
  if m_WAbil.HP > 0 then begin
    n08 := 3 - Round(m_WAbil.HP / m_WAbil.MaxHP * 3.0);
  end else begin
    n08 := 4;
  end;
  if (m_btDirection <> n08) and (n08 < 5) then begin
    m_btDirection := n08;
    SendRefMsg(RM_DIGUP, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
  end;
  inherited;
end;
//-----------------------------------------------------------------------------
{TFireDragon 火龙}
constructor TFireDragon.Create;
begin
  inherited;
  m_boAnimal := False;//不是动物,即不能挖
  m_boStickMode := True;//不能冲撞模式(即敌人不能使用野蛮冲撞技能攻击)
  m_btAntiPoison := 200;//中毒躲避
  m_boUnParalysis := True;//防麻痹
  m_nViewRange := 13;
  m_dwAttickTick := GetTickCount();
  m_boFixedHideMode:= False;//不隐身
  m_dwLightTick:= GetTickCount();//守护兽发光间
end;

destructor TFireDragon.Destroy;
begin
  inherited;
end;

procedure TFireDragon.RecalcAbilitys();
begin
  inherited;
  m_boStickMode := True;//不能冲撞模式(即敌人不能使用野蛮冲撞技能攻击)
  m_btAntiPoison := 200;//中毒躲避
  m_boUnParalysis := True;//防麻痹
  m_boFixedHideMode:= False;//不隐身
end;

function TFireDragon.sub_4A5B0C(nCode: Integer): Boolean;
var
  I: Integer;
  BaseObject: TBaseObject;
begin
  Result := False;
  if m_VisibleActors.Count > 0 then begin
    for I := 0 to m_VisibleActors.Count - 1 do begin
      BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
      if BaseObject = nil then Continue;
      if BaseObject.m_boDeath then Continue;
      if IsProperTarget(BaseObject) then begin
        if (abs(m_nCurrX - BaseObject.m_nCurrX) <= nCode) and (abs(m_nCurrY - BaseObject.m_nCurrY) <= nCode) then begin
          Result := True;
          Break;
        end;
      end;
    end;
  end;
end;

//大火圈攻击
function TFireDragon.MagBigExplosion(nPower, nX, nY: Integer; nRage: Integer): Boolean;
var
  I: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
begin
  Result := False;
  m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);//调整火龙的方向 20090125
  BaseObjectList := TList.Create;
  try
    m_PEnvir.GetMapBaseObjects(nX, nY, nRage, BaseObjectList);
    if BaseObjectList.Count > 0 then begin
      for I := 0 to BaseObjectList.Count - 1 do begin
        TargeTBaseObject := TBaseObject(BaseObjectList.Items[I]);
        if TargeTBaseObject <> nil then begin
          if TargeTBaseObject.m_boDeath or (TargeTBaseObject.m_boGhost) then Continue;
          if IsProperTarget(TargeTBaseObject) then begin
            SetTargetCreat(TargeTBaseObject);
            TargeTBaseObject.SendMsg(self, RM_MAGSTRUCK, 0, nPower, 0, 0, '');
            if (TargeTBaseObject.m_wStatusTimeArr[POISON_DAMAGEARMOR] = 0) then
              TargeTBaseObject.SendDelayMsg(self, RM_POISON, POISON_DAMAGEARMOR{中毒类型：红毒}, nPower, Integer(self), 4, '', 150);//20091224 带红毒攻击
            if TargeTBaseObject.m_wStatusArrValue[10] = 0 then
              TargeTBaseObject.MagDownHealth(1, 1, Round(nPower * 0.1)+ 1);//掉蓝 20100118
            Result := True;
          end;
        end;
      end;
    end;
  finally
    BaseObjectList.Free;
  end;
end;                  

function TFireDragon.AttackTarget: Boolean;
var
  WAbil: pTAbility;
  nPower, I, K, J: Integer;
  BaseObject: TBaseObject;
begin
  Result := False;
  if not sub_4A5B0C(m_nViewRange) then Exit;//守护兽15格开始发亮，没有目标则退出
  if (GetTickCount - m_dwLightTick > 10000) then begin//通知守护兽发光
    m_dwLightTick:= GetTickCount();
    if UserEngine.m_MonObjectList.Count > 0 then begin//循环列表，找出同个地图的守护兽，
      Randomize;
      K:= Random(6);//随机一个守护兽攻击
      J:= 0;
      for I:= 0 to UserEngine.m_MonObjectList.Count -1 do begin
        BaseObject:= TBaseObject(UserEngine.m_MonObjectList.Items[I]);
        if BaseObject <> nil then begin
          if BaseObject.m_PEnvir = m_PEnvir then begin//同个地图内
            if TFireDragonGuard(BaseObject).m_boLight or TFireDragonGuard(BaseObject).m_boAttick then Break;//上次没有处理完就退出循环
            if J = K then begin//最后熄灭的怪，即攻击怪
              TFireDragonGuard(BaseObject).m_boAttick := True;
              TFireDragonGuard(BaseObject).m_dwLightTime:= 3800;//发光时长比其它怪多  20090518 修改
              //发送最后熄灭的特殊消息(发亮)
              BaseObject.SendRefMsg(RM_FAIRYATTACKRATE, 1, BaseObject.m_nCurrX, BaseObject.m_nCurrY, Integer(BaseObject), '');
            end else begin//同时熄灭的怪
              //发送同时熄灭的消息(发亮)
              BaseObject.SendRefMsg(RM_LIGHTING, 1, BaseObject.m_nCurrX, BaseObject.m_nCurrY, Integer(BaseObject), '');
            end;
            TFireDragonGuard(BaseObject).m_boLight:= True;
            TFireDragonGuard(BaseObject).m_dwSearchEnemyTick:= GetTickCount();
            Inc(J);
            if J >= 6 then Break;//6个怪就退出循环
          end;
        end;
      end;
    end;
  end;
  if not sub_4A5B0C(m_nViewRange - 2) then Exit;//火龙魔兽11格,没有目标则退出
  if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
    m_dwHitTick := GetTickCount();
    if Random(3) = 0 then begin
      //群雷攻击
      SendAttackMsg(RM_HIT, m_btDirection, 0, m_nCurrX, m_nCurrY);
      WAbil := @m_WAbil;
      nPower := (Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) + 1) + LoWord(WAbil.DC));
      if m_VisibleActors.Count > 0 then begin
        for I := 0 to m_VisibleActors.Count - 1 do begin
          BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
          if BaseObject = nil then Continue;
          if BaseObject.m_boDeath then Continue;
          if IsProperTarget(BaseObject) then begin
            if (abs(m_nCurrX - BaseObject.m_nCurrX) < m_nViewRange) and (abs(m_nCurrY - BaseObject.m_nCurrY) < m_nViewRange) then begin
              m_dwTargetFocusTick := GetTickCount();
              SendDelayMsg(Self, RM_DELAYMAGIC, nPower, MakeLong(BaseObject.m_nCurrX, BaseObject.m_nCurrY), 2, Integer(BaseObject), '', 600);
              if Random(4) = 0 then m_TargetCret := BaseObject;
            end;
          end;
        end; // for
      end;
    end else begin//大火圈攻击
      if m_TargetCret <> nil then begin
        WAbil := @m_WAbil;
        nPower := (Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) + 1) + LoWord(WAbil.DC));
        MagBigExplosion(nPower, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 3);
        SendRefMsg(RM_LIGHTING, 1, m_nCurrX, m_nCurrY, Integer(m_TargetCret), '');
      end;
    end;
  end;
  Result := True;
end;

procedure TFireDragon.Run;
var
  I: Integer;
begin
  if not m_boGhost and not m_boDeath and (m_wStatusTimeArr[POISON_STONE {5}] = 0)
    and (m_wStatusTimeArr[POISON_LOCKSPELL{7}] = 0) and (m_wStatusArrValue[23] = 0) then begin
    if ((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil) and m_boIsVisibleActive then begin//20090503 修改
      m_dwSearchEnemyTick := GetTickCount();
      SearchTarget();//搜索可攻击目标
    end;
    if Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed then begin
      m_dwWalkTick := GetTickCount();
      if (GetTickCount - m_dwAttickTick) > 3000 then begin
        if AttackTarget() then begin
          inherited;
          Exit;
        end;
        if (GetTickCount - m_dwAttickTick) > 10000 then begin
          if m_VisibleActors.Count > 0 then begin
            for I := 0 to m_VisibleActors.Count - 1 do begin
              Dispose({pTVisibleBaseObject}(m_VisibleActors.Items[I]));
            end;
          end;
          m_VisibleActors.Clear;
          m_dwAttickTick := GetTickCount();
        end;
      end;
    end;
  end;
  inherited;
end;
//------------------------------------------------------------------------------
{TNewFireDragon 火龙2}
constructor TNewFireDragon.Create;
begin
  inherited;
  m_boChangeColor:= False;//是否改变颜色
  m_btAntiPoison := 0;//中毒躲避
end;

destructor TNewFireDragon.Destroy;
begin
  inherited;
end;

procedure TNewFireDragon.RecalcAbilitys();
begin
  inherited;
  m_btAntiPoison := 0;//中毒躲避
end;

function TNewFireDragon.AttackTarget: Boolean;
var
  WAbil: pTAbility;
  nPower, I, K, J: Integer;
  BaseObject: TBaseObject;
begin
  Result := False;
  if not sub_4A5B0C(m_nViewRange) then Exit;//守护兽15格开始发亮，没有目标则退出
  if (GetTickCount - m_dwLightTick > 10000) then begin//通知守护兽发光
    m_dwLightTick:= GetTickCount();
    if UserEngine.m_MonObjectList.Count > 0 then begin//循环列表，找出同个地图的守护兽，
      Randomize;
      K:= Random(6);//随机一个守护兽攻击
      J:= 0;
      for I:= 0 to UserEngine.m_MonObjectList.Count -1 do begin
        BaseObject:= TBaseObject(UserEngine.m_MonObjectList.Items[I]);
        if BaseObject <> nil then begin
          if BaseObject.m_PEnvir = m_PEnvir then begin//同个地图内
            if TFireDragonGuard(BaseObject).m_boLight or TFireDragonGuard(BaseObject).m_boAttick then Break;//上次没有处理完就退出循环
            if J = K then begin//最后熄灭的怪，即攻击怪
              TFireDragonGuard(BaseObject).m_boAttick := True;
              TFireDragonGuard(BaseObject).m_dwLightTime:= 3800;//发光时长比其它怪多  20090518 修改
              //发送最后熄灭的特殊消息(发亮)
              BaseObject.SendRefMsg(RM_FAIRYATTACKRATE, 1, BaseObject.m_nCurrX, BaseObject.m_nCurrY, Integer(BaseObject), '');
            end else begin//同时熄灭的怪
              //发送同时熄灭的消息(发亮)
              BaseObject.SendRefMsg(RM_LIGHTING, 1, BaseObject.m_nCurrX, BaseObject.m_nCurrY, Integer(BaseObject), '');
            end;
            TFireDragonGuard(BaseObject).m_boLight:= True;
            TFireDragonGuard(BaseObject).m_dwSearchEnemyTick:= GetTickCount();
            Inc(J);
            if J >= 6 then Break;//6个怪就退出循环
          end;
        end;
      end;
    end;
  end;
  if not sub_4A5B0C(m_nViewRange - 2) then Exit;//火龙魔兽11格,没有目标则退出
  if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
    m_dwHitTick := GetTickCount();
    if m_boChangeColor then begin//显示过紫色，放岩浆
      m_boChangeColor:= False;
      WAbil := @m_WAbil;
      nPower := (Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) + 1) + LoWord(WAbil.DC));
      for I := 0 to 12 do begin
        case Random(4) of
          0: begin
            K := m_nCurrX - 5 + Random(5);
            J := m_nCurrY - 4 + Random(4);
          end;
          1: begin
            K := m_nCurrX;
            J := m_nCurrY - 5 + Random(5);
          end;
          2: begin
            K := m_nCurrX - 5 + Random(5);
            J := m_nCurrY + 5 - Random(5);
          end;
          3: begin
            K := m_nCurrX;
            J := m_nCurrY + 5 - Random(5);
          end;
        end;
        if GetRandXY(m_PEnvir, K, J) then begin
          SendRefMsg(RM_10205, 11, K, J, 0, '');
          BaseObject:= m_PEnvir.GetMovingObject(K, J, True);
          if BaseObject <> nil then begin
            if IsProperTarget(BaseObject) then begin
              if (abs(m_nCurrX - BaseObject.m_nCurrX) < m_nViewRange) and (abs(m_nCurrY - BaseObject.m_nCurrY) < m_nViewRange) then begin
                SendDelayMsg(Self, RM_DELAYMAGIC, nPower, MakeLong(BaseObject.m_nCurrX, BaseObject.m_nCurrY), 2, Integer(BaseObject), '', 600);
                if Random(4) = 0 then m_TargetCret := BaseObject;
              end;
            end;
          end;
        end;
      end;
      Result := True;
      Exit;
    end;
    if Random(5) = 0 then begin//岩浆攻击(自身显示紫色)
      SendAttackMsg(RM_HIT, m_btDirection, 0, m_nCurrX, m_nCurrY);
      m_boChangeColor:= True;
      m_dwHitTick := GetTickCount() - m_nNextHitTime + 600;
    end;// else begin//大火圈攻击
      if m_TargetCret <> nil then begin
        WAbil := @m_WAbil;
        nPower := (Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) + 1) + LoWord(WAbil.DC));
        MagBigExplosion(nPower, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 3);
        SendRefMsg(RM_LIGHTING, 1, m_nCurrX, m_nCurrY, Integer(m_TargetCret), '');
      end;
    //end;
  end;
  Result := True;
end;
//------------------------------------------------------------------------------
{TFireDragonGuard 火龙守护兽}
constructor TFireDragonGuard.Create;
begin
  inherited;
  m_boStoneMode := True;//人物不能攻击，石像化
  m_boAnimal := False;//不是动物,即不能挖
  m_boStickMode := True;//不能冲撞模式(即敌人不能使用野蛮冲撞技能攻击)
  m_btAntiPoison := 200;//中毒躲避
  m_boUnParalysis := True;//防麻痹
  m_boLight := False;//是否发光
  m_boAttick := False; //是否可以攻击，即最后一个熄灭的怪，负责攻击消息
  s_AttickXY:= '';//攻击坐标
  m_dwLightTime:= 2500;//发光时长
  m_nViewRange:= 0;//20090525 增加
  m_dwSearchTime:= Random(1500) + 3000;//20090505
  //防止非法引用 By TasNat at: 2012-03-07 20:03:10
  UserEngine.m_MonObjectList.Add(Self);
end;

destructor TFireDragonGuard.Destroy;
begin
  //防止非法引用 By TasNat at: 2012-03-07 20:03:10
  UserEngine.m_MonObjectList.Remove(Self);
  inherited;
end;

procedure TFireDragonGuard.RecalcAbilitys();
begin
  inherited;
  m_boStoneMode := True;//人物不能攻击，石像化
  m_boAnimal := False;//不是动物,即不能挖
  m_boStickMode := True;//不能冲撞模式(即敌人不能使用野蛮冲撞技能攻击)
  m_btAntiPoison := 200;//中毒躲避
  m_boUnParalysis := True;//防麻痹
end;

//小火圈攻击
function TFireDragonGuard.MagBigExplosion(nPower, nX, nY: Integer; nRage: Integer): Boolean;
var
  I: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
  FireBurnEvent: TFireBurnEvent;
begin
  Result := False;
  BaseObjectList := TList.Create;
  try
    FireBurnEvent := TFireBurnEvent.Create(self, nX, nY, ET_FIREDRAGON, 4000, 0);//客户端显示小火圈效果
    g_EventManager.AddEvent(FireBurnEvent);
    m_PEnvir.GetMapBaseObjects(nX, nY, nRage, BaseObjectList);
    if BaseObjectList.Count > 0 then begin
      for I := 0 to BaseObjectList.Count - 1 do begin
        TargeTBaseObject := TBaseObject(BaseObjectList.Items[I]);
        if TargeTBaseObject <> nil then begin
          if TargeTBaseObject.m_boDeath or (TargeTBaseObject.m_boGhost) then Continue;
          if IsProperTarget(TargeTBaseObject) then begin
            SetTargetCreat(TargeTBaseObject);
            TargeTBaseObject.SendMsg(self, RM_MAGSTRUCK, 0, nPower, 0, 0, '');
            Result := True;
          end;
        end;
      end;
    end;
  finally
    BaseObjectList.Free;
  end;
end;

function TFireDragonGuard.AttackTarget: Boolean;
  function IsChar(str:string):integer;//判断有几个'|'号
  var I:integer;
  begin
    Result:= 0;
    if length(str) <=0 then Exit;
      for I:=1 to length(str) do
        if (str[I] = '|') then Inc(Result);
  end;
var
  I, nX, nY, nPower: Integer;
  str, Str1, s30, s2C: string;
  WAbil: pTAbility;
begin
  Result := False;
  try
    if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
      m_dwHitTick := GetTickCount();
      if Pos('|', s_AttickXY) > 0 then begin//根据配置文件的攻击坐标，发消息显示场景
        WAbil := @m_WAbil;
        nPower := (Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) + 1) + LoWord(WAbil.DC));
        str:= s_AttickXY;
        for I:= 0 to IsChar(s_AttickXY) do begin
          str:=GetValidStr3(str , str1, ['|']);
          if Str1 <> '' then begin
            s30 := GetValidStr3(Str1, s2C, [',', #9]);//X,Y
            nX:= Str_ToInt(s2C, 0);
            nY:= Str_ToInt(s30, 0);
            MagBigExplosion(nPower, nX, nY, 1);
          end;
        end;
      end;
      Result := True;
    end;
  except
    MainOutMessage(Format('{%s} TFireDragonGuard.AttackTarget',[g_sExceptionVer]));
  end;
end;

procedure TFireDragonGuard.Run;
begin
  if not m_boGhost and not m_boDeath and (m_wStatusTimeArr[POISON_STONE{5}] = 0)
    and (m_wStatusTimeArr[POISON_LOCKSPELL{7}] = 0) and (m_wStatusArrValue[23] = 0) then begin
    if Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed then begin
      m_dwWalkTick := GetTickCount();
      if m_boLight then begin//发亮
        if (GetTickCount - m_dwSearchEnemyTick) > m_dwLightTime then begin
          m_dwSearchEnemyTick:= GetTickCount();
          m_dwLightTime:= 2500;//发光时长
          m_boLight:= False;
        end;
      end;
      if m_boAttick and (not m_boLight) and (s_AttickXY <> '') then begin//可以攻击
        if AttackTarget then m_boAttick:= False;//处理攻击代码
      end;
    end;  
  end;
  inherited;
end;
//------------------------------------------------------------------------------
{TDevilBat 恶魔蝙蝠}
constructor TDevilBat.Create;
begin
  inherited;
  m_boAnimal := False;//不是动物,即不能挖
  m_boStickMode := True;//不能冲撞,气功，抗拒
  m_btAntiPoison := 200;//中毒躲避
  m_nViewRange := 8;
end;

destructor TDevilBat.Destroy;
begin
  inherited;
end;

function TDevilBat.AttackTarget(): Boolean;
var
  bt06: Byte;
begin
  Result := False;
  if GetAttackDir(m_TargetCret, bt06) then begin
    if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
      m_TargetCret.SetLastHiter(self);//20090209 增加  修正，被恶魔蝙蝠打死的人物不能触发QF的死亡触发段
      m_dwHitTick := GetTickCount();
      m_dwTargetFocusTick := GetTickCount();
      Attack(m_TargetCret, bt06);
      m_WAbil.HP := 0;//死亡
    end;
    Result := True;
  end else begin
    if m_TargetCret.m_PEnvir = m_PEnvir then begin
      if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 11) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 11) then begin
        SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      end;
    end else begin
      DelTargetCreat();
    end;
  end;
end;

procedure TDevilBat.Run;
begin
  if not m_boGhost and not m_boDeath and (m_wStatusTimeArr[POISON_STONE{5}] = 0)
    and (m_wStatusTimeArr[POISON_LOCKSPELL{7}] = 0) and (m_wStatusArrValue[23] = 0) then begin
    if ((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil) and m_boIsVisibleActive then begin//20090503 修改
      m_dwSearchEnemyTick := GetTickCount();
      SearchTarget();//搜索可攻击目标
    end;
    if Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed then begin
      m_dwWalkTick := GetTickCount();
      if not m_boNoAttackMode then begin
        if m_TargetCret <> nil then begin
          if AttackTarget then begin
            inherited;
            Exit;
          end;
        end else begin
          m_nTargetX := -1;
          if m_boMission then begin
            m_nTargetX := m_nMissionX;
            m_nTargetY := m_nMissionY;
          end;
        end;
      end;
      if m_nTargetX <> -1 then begin
        GotoTargetXY();
      end else begin
        if m_TargetCret = nil then Wondering();
      end;
    end;
  end;
  inherited;
end;
//------------------------------------------------------------------------------
{TSnowyFireDay 雪域灭天魔:灭天火，会施放红毒}
constructor TSnowyFireDay.Create;
begin
  inherited;
  m_nViewRange:= 8;//20090114
end;

destructor TSnowyFireDay.Destroy;
begin
  inherited;
end;

//使用灭天火攻击
function TSnowyFireDay.AttackTarget(): Boolean;
var
  nPower, NGSecPwr: Integer;
begin
  Result := False;
  if (m_TargetCret = nil) then Exit;
  if GetTickCount - m_dwHitTick > m_nNextHitTime then begin
    m_dwHitTick := GetTickCount();
    if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 5) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 5) then begin
      m_dwTargetFocusTick := GetTickCount();
      if not m_TargetCret.m_boDeath then begin
        if (m_TargetCret.m_wStatusTimeArr[POISON_DAMAGEARMOR] = 0) then begin//目标红毒时间到，才重新使用施毒术
          if IsProperTarget(m_TargetCret) then begin
            if (m_TargetCret.m_btRaceServer in [79, 109, 128, 143, 145, 147, 151, 153, 156..158]) then Exit;//20090206 火龙魔兽,富贵兽,赤狐王不能毒
            if Random(m_TargetCret.m_btAntiPoison + 7) <= 6 then begin//施毒
              nPower:= GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
              m_TargetCret.SendDelayMsg(self, RM_POISON, POISON_DAMAGEARMOR{中毒类型：红毒}, nPower, Integer(self), 4, '', 150);
              //发消息给客户端，显示施毒效果
              SendRefMsg(RM_FAIRYATTACKRATE, 1, m_nCurrX, m_nCurrY, Integer(m_TargetCret), '');
              Result := True;
              Exit;
            end;
          end;
        end else begin//灭天火
          if (Random(10) >= m_TargetCret.m_nAntiMagic) then begin
            m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
            nPower:= GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
            if m_TargetCret.m_btLifeAttrib = LA_UNDEAD then nPower := Round(nPower * 1.5);//如果为不死系
            {$IF M2Version <> 2}
            if (m_TargetCret.m_btRaceServer = RC_PLAYOBJECT) or (m_TargetCret.m_btRaceServer = RC_HEROOBJECT) then begin//20090304 增加
              NGSecPwr:= 0;
              if m_TargetCret.m_btRaceServer = RC_PLAYOBJECT then begin
                NGSecPwr:= MagicManager.GetNGPow(m_TargetCret, TPlayObject(m_TargetCret).m_MagicSkill_229,nPower);//静之灭天火
              end else
              if m_TargetCret.m_btRaceServer = RC_HEROOBJECT then begin
                NGSecPwr:= MagicManager.GetNGPow(m_TargetCret, THEROOBJECT(m_TargetCret).m_MagicSkill_229,nPower);//静之灭天火
              end;
              nPower := _MAX(0, nPower - NGSecPwr);
            end;
            {$IFEND}
            SendDelayMsg(self, RM_DELAYMAGIC, nPower, MakeLong(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY), 2, Integer(m_TargetCret), '', 600);
            //发消息给客户端，显示灭天火效果
            SendRefMsg(RM_LIGHTING, 1, m_nCurrX, m_nCurrY, Integer(m_TargetCret), '');
            if g_Config.boPlayObjectReduceMP then m_TargetCret.DamageSpell(Abs(Round(nPower * 0.35)));//击中减MP值,减35%
            Result := True;
            Exit;
          end else begin//物理攻击
            if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 2) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 2) then begin
              nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
              HitMagAttackTarget(m_TargetCret, nPower div 2, nPower div 2, True);
              Result := True;
              Exit;
            end;
          end;
        end;
      end;
      if m_TargetCret.m_PEnvir = m_PEnvir then begin
        if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 11) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 11) then begin
          SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
        end;
      end else begin
        DelTargetCreat();
      end;
    end;
  end;
end;

procedure TSnowyFireDay.Run;
var
 nCode: byte;
begin
  nCode:= 0;
  Try
    if not m_boDeath and not m_boGhost and(m_wStatusTimeArr[POISON_STONE ] = 0)
      and (m_wStatusTimeArr[POISON_LOCKSPELL{7}] = 0) and (m_wStatusArrValue[23] = 0) then begin
      if ((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil) and m_boIsVisibleActive then begin//20090503 修改
        m_dwSearchEnemyTick := GetTickCount();
        nCode:= 1;
        SearchTarget();//搜索可攻击目标
      end;
      nCode:= 5;
      if Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed then begin
        if not m_boNoAttackMode then begin
          if m_TargetCret <> nil then begin
            nCode:= 2;
            if AttackTarget then begin
              inherited;
              Exit;
            end;
            nCode:= 3;
            if (m_TargetCret <> nil) then begin
              if (not m_TargetCret.m_boDeath) and (not m_TargetCret.m_boGhost) then begin//20090227
                if (abs(m_nCurrX - m_TargetCret.m_nCurrX) > 5) or (abs(m_nCurrY - m_TargetCret.m_nCurrY) > 5) then begin //目标离远了,走向目标
                  m_nTargetX := m_TargetCret.m_nCurrX;
                  m_nTargetY := m_TargetCret.m_nCurrY;
                  GotoTargetXY();
                  inherited;
                  Exit;
                end;
              end;
            end;    
          end else begin
            m_nTargetX := -1;
            if m_boMission then begin
              m_nTargetX := m_nMissionX;
              m_nTargetY := m_nMissionY;
            end;
          end;
        end;
        nCode:= 4;
        if m_nTargetX <> -1 then begin
          if (m_TargetCret <> nil) then begin
            if (abs(m_nCurrX - m_nTargetX) > 1) or (abs(m_nCurrY - m_nTargetY) > 1) then begin
              GotoTargetXY();
            end;  
          end else GotoTargetXY();
        end else begin
         if (m_TargetCret = nil) then Wondering();
        end; 
      end;
    end;
  except
    MainOutMessage(Format('{%s} TSnowyFireDay.Run Code:%d',[g_sExceptionVer, nCode]));
  end;
  inherited;
end;
//-----------------------------------------------------------------------------
{TSnowyHanbing 雪域寒冰魔:冰咆哮，会施放绿毒}
constructor TSnowyHanbing.Create;
begin
  inherited;
  m_nViewRange:= 8;//20090114
end;

destructor TSnowyHanbing.Destroy;
begin
  inherited;
end;

//使用冰咆哮攻击
function TSnowyHanbing.AttackTarget(): Boolean;
var
  nPower: Integer;
begin
  Result := False;
  if (m_TargetCret = nil) then Exit;
  if GetTickCount - m_dwHitTick > m_nNextHitTime then begin
    m_dwHitTick := GetTickCount();
    if not m_TargetCret.m_boDeath then begin
      if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 5) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 5) then begin
        m_dwTargetFocusTick := GetTickCount();
        if (m_TargetCret.m_wStatusTimeArr[POISON_DECHEALTH] = 0) then begin//目标绿毒时间到，才重新使用施毒术
          if IsProperTarget(m_TargetCret) then begin
            if (m_TargetCret.m_btRaceServer in [79, 109, 128, 143, 145, 147, 151, 153, 156..158]) then Exit;//20090206 火龙魔兽,富贵兽,赤狐王不能毒
            if Random(m_TargetCret.m_btAntiPoison + 7) <= 6 then begin//施毒
              nPower:= GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
              m_TargetCret.SendDelayMsg(self, RM_POISON, POISON_DECHEALTH{中毒类型：绿毒}, nPower, Integer(self), 4, '', 150);
              SendRefMsg(RM_FAIRYATTACKRATE, 1, m_nCurrX, m_nCurrY, Integer(m_TargetCret), ''); //发给客户端毒的消息
              Result := True;
              Exit;
            end;
          end;
        end else begin//冰咆哮
          if (Random(10) >= m_TargetCret.m_nAntiMagic) then begin//魔法躲避
            m_dwTargetFocusTick := GetTickCount();
            m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
            nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
            MagicManager.MagBigExplosion(self, nPower, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, g_Config.nSnowWindRange, SKILL_SNOWWIND);
            //发消息给客户端，显示冰咆哮效果
            SendRefMsg(RM_LIGHTING, 1, m_nCurrX, m_nCurrY, Integer(m_TargetCret), '');
            Result := True;
            Exit;
          end else begin//物理攻击
            if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 2) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 2) then begin
              nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
              HitMagAttackTarget(m_TargetCret, nPower div 2, nPower div 2, True);
              Result := True;
              Exit;
            end;
          end;
        end;
      end;
      if m_TargetCret.m_PEnvir = m_PEnvir then begin
        if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 11) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 11) then begin
          SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
        end;
      end else begin
        DelTargetCreat();
      end;
    end;
  end;
end;

procedure TSnowyHanbing.Run;
var
 nCode: byte;
begin
  nCode:= 0;
  Try
    if not m_boDeath and not m_boGhost and(m_wStatusTimeArr[POISON_STONE ] = 0)
      and (m_wStatusTimeArr[POISON_LOCKSPELL{7}] = 0) and (m_wStatusArrValue[23] = 0) then begin
      if ((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil) and m_boIsVisibleActive then begin//20090503 修改
        m_dwSearchEnemyTick := GetTickCount();
        nCode:= 1;
        SearchTarget();//搜索可攻击目标
      end;
      nCode:= 5;
      if Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed then begin
        if not m_boNoAttackMode then begin
          if m_TargetCret <> nil then begin
            nCode:= 2;
            if AttackTarget then begin
              inherited;
              Exit;
            end;
            nCode:= 8;
            if (m_TargetCret <> nil) then begin
              nCode:= 9;
              if (not m_TargetCret.m_boDeath) and (not m_TargetCret.m_boGhost) then begin//20090227
                nCode:= 10;
                if (abs(m_nCurrX - m_TargetCret.m_nCurrX) > 5) or (abs(m_nCurrY - m_TargetCret.m_nCurrY) > 5) then begin //目标离远了,走向目标
                  m_nTargetX := m_TargetCret.m_nCurrX;
                  m_nTargetY := m_TargetCret.m_nCurrY;
                  GotoTargetXY();
                  inherited;
                  Exit;
                end;
              end;
            end;
          end else begin
            m_nTargetX := -1;
            if m_boMission then begin
              m_nTargetX := m_nMissionX;
              m_nTargetY := m_nMissionY;
            end;
          end;
        end;
        nCode:= 4;
        if m_nTargetX <> -1 then begin
          if (m_TargetCret <> nil) then begin
             nCode:= 6;
            if (abs(m_nCurrX - m_nTargetX) > 1) or (abs(m_nCurrY - m_nTargetY) > 1) then begin
              GotoTargetXY();
            end;  
          end else GotoTargetXY();
        end else begin
          nCode:= 7;
          if (m_TargetCret = nil) then Wondering();
        end; 
      end;
    end;
  except
    MainOutMessage(Format('{%s} TSnowyHanbing.Run Code:%d',[g_sExceptionVer, nCode]));
  end;
  inherited;
end;
//------------------------------------------------------------------------------
{TSnowyWuDu 雪域五毒魔:寒冰掌，治疗术}
constructor TSnowyWuDu.Create;
begin
  inherited;
  m_nViewRange:= 8;//20090114
end;

destructor TSnowyWuDu.Destroy;
begin
  inherited;
end;

//寒冰掌,治疗术 攻击
function TSnowyWuDu.AttackTarget: Boolean;
var
  nPower, NGSecPwr, push: Integer;
  nDir: Byte;
begin
  Result := False;
  if m_TargetCret = nil then Exit;
  if GetTickCount - m_dwHitTick > m_nNextHitTime then begin
    m_dwHitTick := GetTickCount();
    if not m_TargetCret.m_boDeath then begin
      if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 5) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 5) then begin
        m_dwTargetFocusTick := GetTickCount();
        if (m_WAbil.HP < Round(m_WAbil.MaxHP * 0.6)) and (Random(2) = 0) then begin//使用治疗术
          SendRefMsg(RM_FAIRYATTACKRATE, 1, m_nCurrX, m_nCurrY, Integer(self), '');
          SendDelayMsg(self, RM_MAGHEALING, 0, 50, 0, 0, '', 800);//治愈术  //发消息给客户端，显示治愈术效果
          Result := True;
          Exit;
        end else begin//寒冰掌
          nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
          {$IF M2Version <> 2}
          if (m_TargetCret.m_btRaceServer = RC_PLAYOBJECT) or (m_TargetCret.m_btRaceServer = RC_HEROOBJECT) then begin//20090304 增加
            NGSecPwr:= 0;
            if m_TargetCret.m_btRaceServer = RC_PLAYOBJECT then begin
              NGSecPwr:= MagicManager.GetNGPow(m_TargetCret, TPlayObject(m_TargetCret).m_MagicSkill_227,nPower);//静之寒冰掌
            end else
            if m_TargetCret.m_btRaceServer = RC_HEROOBJECT then begin
              NGSecPwr:= MagicManager.GetNGPow(m_TargetCret, THEROOBJECT(m_TargetCret).m_MagicSkill_227,nPower);//静之寒冰掌
            end;
            nPower := _MAX(0, nPower - NGSecPwr);
          end;
          {$IFEND}
          SendDelayMsg(self, RM_DELAYMAGIC, nPower, MakeLong(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY), 2, Integer(m_TargetCret), '', 600);
          if (not m_TargetCret.m_boStickMode) and (Random(2) = 0) then begin
            push := Random(3) - 1;
            if push > 0 then begin
              nDir := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
              SendDelayMsg(self, RM_DELAYPUSHED, nDir, MakeLong(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY), push, Integer(m_TargetCret), '', 600);
            end;
          end;
          //发消息给客户端，显示寒冰掌效果
          SendRefMsg(RM_LIGHTING, 1, m_nCurrX, m_nCurrY, Integer(m_TargetCret), '');
          Result := True;
          Exit;
        end;
      end;
      if m_TargetCret.m_PEnvir = m_PEnvir then begin
        if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 11) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 11) then begin
          SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
        end;
      end else begin
        DelTargetCreat();
      end;
    end;
  end;
end;

procedure TSnowyWuDu.Run;
var
 nCode: byte;
begin
  nCode:= 0;
  Try
    if not m_boDeath and not m_boGhost and(m_wStatusTimeArr[POISON_STONE ] = 0)
      and (m_wStatusTimeArr[POISON_LOCKSPELL{7}] = 0) and (m_wStatusArrValue[23] = 0) then begin
      if ((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil) and m_boIsVisibleActive then begin//20090503 修改
        nCode:= 1;
        m_dwSearchEnemyTick := GetTickCount();
        SearchTarget();//搜索可攻击目标
      end;
      if Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed then begin
        nCode:= 2;
        if not m_boNoAttackMode then begin
          if m_TargetCret <> nil then begin
            nCode:= 3;
            if AttackTarget then begin
              inherited;
              Exit;
            end;
            nCode:= 9;
            if (m_TargetCret <> nil) then begin
              nCode:= 10;
              if (not m_TargetCret.m_boDeath) and (not m_TargetCret.m_boGhost) then begin//20090227
                nCode:= 11;
                if ((abs(m_nCurrX - m_TargetCret.m_nCurrX) > 5) or (abs(m_nCurrY - m_TargetCret.m_nCurrY) > 5)) then begin //目标离远了,走向目标
                  nCode:= 6;
                  m_nTargetX := m_TargetCret.m_nCurrX;
                  m_nTargetY := m_TargetCret.m_nCurrY;
                  nCode:= 7;
                  GotoTargetXY();
                  inherited;
                  Exit;
                end;
              end;
            end;
          end else begin
            m_nTargetX := -1;
            if m_boMission then begin
              m_nTargetX := m_nMissionX;
              m_nTargetY := m_nMissionY;
            end;
          end;
        end;

        nCode:= 8;
        if m_nTargetX <> -1 then begin
          if (m_TargetCret <> nil) then begin
            if (abs(m_nCurrX - m_nTargetX) > 1) or (abs(m_nCurrY - m_nTargetY) > 1) then begin
              GotoTargetXY();
            end;
          end else GotoTargetXY();
        end else begin
         if (m_TargetCret = nil) then Wondering();
        end;
      end;
    end;
  except
    MainOutMessage(Format('{%s} TSnowyWuDu.Run Code:%d',[g_sExceptionVer, nCode]));
  end;
  inherited;
end;
//-------------------------------------------------------------------------
{TSnowBodyguards 雪域待卫}

constructor TSnowBodyguards.Create;
begin
  inherited;
  m_nViewRange:= 7;
end;

destructor TSnowBodyguards.Destroy;
begin
  inherited;
end;

function TSnowBodyguards.AttackTarget: Boolean;
var
  nPower, I: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
begin
  Result := False;
  if m_TargetCret = nil then Exit;
  if GetTickCount - m_dwHitTick > m_nNextHitTime then begin
    m_dwHitTick := GetTickCount();
    if not m_TargetCret.m_boDeath then begin
      if ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 1) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 0)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 1) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 1)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 2) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 2)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 2) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 0)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 3) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 3)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 3) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 0)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 4) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 4)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 4) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 0)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 0) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 1)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 0) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 2)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 0) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 3)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 0) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 4)) then begin
      //if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 5) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 5) then begin
        m_dwTargetFocusTick := GetTickCount();
        nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
        if (Random(10) >= m_TargetCret.m_nAntiMagic) then begin//追刺攻击，同方向4格目标掉血
          BaseObjectList := TList.Create;
          try
            m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
            GetDirectionBaseObjects(m_btDirection, 4, BaseObjectList);//同个方向的目标 4格
            if BaseObjectList.Count > 0 then begin
              //发消息给客户端，显示追刺效果
              SendRefMsg(RM_LIGHTING, 1, m_nCurrX, m_nCurrY, Integer(m_TargetCret), '');
              for I := 0 to BaseObjectList.Count - 1 do begin
                TargeTBaseObject := TBaseObject(BaseObjectList.Items[I]);
                if TargeTBaseObject <> nil then begin
                  if IsProperTarget(TargeTBaseObject) then begin
                    if 10 >= Random(TargeTBaseObject.m_nAntiMagic + 10) then begin
                      TargeTBaseObject.SendDelayMsg(self, RM_MAGSTRUCK, 0, nPower, 0, 0, '', 300);
                    end;
                  end;
                end;
              end;//for
              Result := True;
              Exit;
            end;
          finally
            BaseObjectList.Free;
          end;
        end else begin//物理攻击
          if ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 1) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 0)) or
             ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 1) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 1)) or
             ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 2) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 2)) or
             ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 2) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 0)) or
             ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 0) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 1)) or
             ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 0) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 2)) then begin
            HitMagAttackTarget(m_TargetCret, nPower div 2, nPower div 2, True); //SM_HIT 普通攻击
            Result := True;
            Exit;
          end;  
        end;
      end;
      if m_TargetCret.m_PEnvir = m_PEnvir then begin
        if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 11) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 11) then begin
          SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
        end;
      end else begin
        DelTargetCreat();
      end;
    end;
  end;
end;

procedure TSnowBodyguards.Run;
var
 nCode: byte;
begin
  nCode:= 0;
  Try
    if not m_boDeath and not m_boGhost and(m_wStatusTimeArr[POISON_STONE ] = 0)
      and (m_wStatusTimeArr[POISON_LOCKSPELL{7}] = 0) and (m_wStatusArrValue[23] = 0) then begin
      if ((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil) and m_boIsVisibleActive then begin
        nCode:= 1;
        m_dwSearchEnemyTick := GetTickCount();
        SearchTarget();//搜索可攻击目标
      end;
      if Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed then begin
        nCode:= 2;
        if not m_boNoAttackMode then begin
          if m_TargetCret <> nil then begin
            nCode:= 3;
            if AttackTarget then begin
              inherited;
              Exit;
            end;
            nCode:= 9;
            if (m_TargetCret <> nil) then begin
              nCode:= 10;
              if (not m_TargetCret.m_boDeath) and (not m_TargetCret.m_boGhost) then begin
                nCode:= 11;
                if ((abs(m_nCurrX - m_TargetCret.m_nCurrX) > 6) or (abs(m_nCurrY - m_TargetCret.m_nCurrY) > 6)) then begin //目标离远了,走向目标
                  nCode:= 6;
                  m_nTargetX := m_TargetCret.m_nCurrX;
                  m_nTargetY := m_TargetCret.m_nCurrY;
                  nCode:= 7;
                  GotoTargetXY();
                  inherited;
                  Exit;
                end;
              end;
            end;
          end else begin
            m_nTargetX := -1;
            if m_boMission then begin
              m_nTargetX := m_nMissionX;
              m_nTargetY := m_nMissionY;
            end;
          end;
        end;
        nCode:= 8;
        if m_nTargetX <> -1 then begin
          if (m_TargetCret <> nil) then begin
            if (abs(m_nCurrX - m_nTargetX) > 1) or (abs(m_nCurrY - m_nTargetY) > 1) then begin
              GotoTargetXY();
            end;
          end else GotoTargetXY();
        end else begin
         if (m_TargetCret = nil) then Wondering();
        end;
      end;
    end;
  except
    MainOutMessage(Format('{%s} TSnowBodyguards.Run Code:%d',[g_sExceptionVer, nCode]));
  end;
  inherited;
end;
//-------------------------------------------------------------------------
{TSnowWarWill 雪域战将}
constructor TSnowWarWill.Create;
begin
  inherited;
  m_nViewRange:= 7;
end;

destructor TSnowWarWill.Destroy;
begin
  inherited;
end;

function TSnowWarWill.AttackTarget: Boolean;
var
  nPower, I: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
begin
  Result := False;
  if m_TargetCret = nil then Exit;
  if GetTickCount - m_dwHitTick > m_nNextHitTime then begin
    m_dwHitTick := GetTickCount();
    if not m_TargetCret.m_boDeath then begin
      if ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 1) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 0)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 1) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 1)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 0) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 1)) then begin
      //if (abs(m_nCurrX - m_TargetCret.m_nCurrX) < 2) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) < 2) then begin//小于2格距离使用普通攻击
        m_dwTargetFocusTick := GetTickCount();
        nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
        HitMagAttackTarget(m_TargetCret, nPower div 2, nPower div 2, True); //SM_HIT 普通攻击
        Result := True;
        Exit;
      end else begin
        if ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 2) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 2)) or
           ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 2) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 0)) or
           ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 3) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 3)) or
           ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 3) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 0)) or
           ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 0) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 3)) or
           ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 0) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 2)) then begin
        //if (abs(m_nCurrX - m_TargetCret.m_nCurrX) < 4) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) < 4) then begin//相差两格使用冰攻击
          m_dwTargetFocusTick := GetTickCount();
          BaseObjectList := TList.Create;
          try
            m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
            GetDirectionBaseObjects_42(m_btDirection, 3, BaseObjectList);//同个方向的目标 3格
            if BaseObjectList.Count > 0 then begin
              nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
              //发消息给客户端，显示追刺效果
              SendRefMsg(RM_LIGHTING, 1, m_nCurrX, m_nCurrY, Integer(m_TargetCret), '');
              for I := 0 to BaseObjectList.Count - 1 do begin
                TargeTBaseObject := TBaseObject(BaseObjectList.Items[I]);
                if TargeTBaseObject <> nil then begin
                  if IsProperTarget(TargeTBaseObject) then begin
                    if 10 >= Random(TargeTBaseObject.m_nAntiMagic + 10) then begin
                      TargeTBaseObject.SendDelayMsg(self, RM_MAGSTRUCK, 0, nPower, 0, 0, '', 300);
                    end;
                  end;
                end;
              end;//for
              Result := True;
              Exit;
            end;
          finally
            BaseObjectList.Free;
          end;
        end;
      end;
      if m_TargetCret.m_PEnvir = m_PEnvir then begin
        if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 11) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 11) then begin
          SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
        end;
      end else begin
        DelTargetCreat();
      end;
    end;
  end;
end;

procedure TSnowWarWill.Run;
var
 nCode: byte;
begin
  nCode:= 0;
  Try
    if not m_boDeath and not m_boGhost and(m_wStatusTimeArr[POISON_STONE ] = 0)
      and (m_wStatusTimeArr[POISON_LOCKSPELL{7}] = 0) and (m_wStatusArrValue[23] = 0) then begin
      if ((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil) and m_boIsVisibleActive then begin
        nCode:= 1;
        m_dwSearchEnemyTick := GetTickCount();
        SearchTarget();//搜索可攻击目标
      end;
      if Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed then begin
        nCode:= 2;
        if not m_boNoAttackMode then begin
          if m_TargetCret <> nil then begin
            nCode:= 3;
            if AttackTarget then begin
              inherited;
              Exit;
            end;
            nCode:= 9;
            if (m_TargetCret <> nil) then begin
              nCode:= 10;
              if (not m_TargetCret.m_boDeath) and (not m_TargetCret.m_boGhost) then begin
                nCode:= 11;
                if ((abs(m_nCurrX - m_TargetCret.m_nCurrX) > 5) or (abs(m_nCurrY - m_TargetCret.m_nCurrY) > 5)) then begin //目标离远了,走向目标
                  nCode:= 6;
                  m_nTargetX := m_TargetCret.m_nCurrX;
                  m_nTargetY := m_TargetCret.m_nCurrY;
                  nCode:= 7;
                  GotoTargetXY();
                  inherited;
                  Exit;
                end;
              end;
            end;
          end else begin
            m_nTargetX := -1;
            if m_boMission then begin
              m_nTargetX := m_nMissionX;
              m_nTargetY := m_nMissionY;
            end;
          end;
        end;
        nCode:= 8;
        if m_nTargetX <> -1 then begin
          if (m_TargetCret <> nil) then begin
            if (abs(m_nCurrX - m_nTargetX) > 1) or (abs(m_nCurrY - m_nTargetY) > 1) then begin
              GotoTargetXY();
            end;
          end else GotoTargetXY();
        end else begin
         if (m_TargetCret = nil) then Wondering();
        end;
      end;
    end;
  except
    MainOutMessage(Format('{%s} TSnowWarWill.Run Code:%d',[g_sExceptionVer, nCode]));
  end;
  inherited;
end;
//-------------------------------------------------------------------------
{TSnowBeelzebub 雪域魔王}
constructor TSnowBeelzebub.Create;
begin
  inherited;
  m_nViewRange:= 7;
  m_dwFreezeMagicTick:= GetTickCount();
end;

destructor TSnowBeelzebub.Destroy;
begin
  inherited;
end;

function TSnowBeelzebub.AttackTarget: Boolean;
var
  nPower, I: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
  boUserFreeze: Boolean;
begin
  Result := False;
  if m_TargetCret = nil then Exit;
  if GetTickCount - m_dwHitTick > m_nNextHitTime then begin
    m_dwHitTick := GetTickCount();
    if not m_TargetCret.m_boDeath then begin
      if ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 1) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 0)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 1) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 1)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 2) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 2)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 2) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 0)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 3) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 3)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 3) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 0)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 4) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 4)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 4) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 0)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 0) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 1)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 0) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 2)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 0) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 3)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 0) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 4)) then begin
        m_dwTargetFocusTick := GetTickCount();
        if (Random(10) >= m_TargetCret.m_nAntiMagic) then begin
          BaseObjectList := TList.Create;
          try
            m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
            //发消息给客户端，显示效果
            SendRefMsg(RM_LIGHTING, 1, m_nCurrX, m_nCurrY, Integer(m_TargetCret), '');
            GetDirectionBaseObjects_42(m_btDirection, 4, BaseObjectList);//同个方向的目标 4格
            if BaseObjectList.Count > 0 then begin
              boUserFreeze:= False;
              if (Random(8)= 0) and (GetTickCount - m_dwFreezeMagicTick > 10000) then begin
                m_dwFreezeMagicTick:= GetTickCount();
                boUserFreeze:= True;
              end;
              nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
              for I := 0 to BaseObjectList.Count - 1 do begin
                TargeTBaseObject := TBaseObject(BaseObjectList.Items[I]);
                if TargeTBaseObject <> nil then begin
                  if IsProperTarget(TargeTBaseObject) then begin
                    if 10 >= Random(TargeTBaseObject.m_nAntiMagic + 10) then begin
                      TargeTBaseObject.SendDelayMsg(self, RM_MAGSTRUCK, 0, nPower, 0, 0, '', 300);
                    end;
                    if boUserFreeze then TargeTBaseObject.MakeFreezeMag(3);//使用冰冻术
                  end;
                end;
              end;//for
              Result := True;
              Exit;
            end;
          finally
            BaseObjectList.Free;
          end;
        end else begin//物理攻击
          if ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 1) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 0)) or
             ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 1) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 1)) or
             ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 2) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 2)) or
             ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 2) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 0)) or
             ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 0) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 1)) or
             ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 0) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 2)) then begin
            nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
            HitMagAttackTarget(m_TargetCret, nPower div 2, nPower div 2, True); //SM_HIT 普通攻击
            Result := True;
            Exit;
          end;
        end;
      end;
      if m_TargetCret.m_PEnvir = m_PEnvir then begin
        if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 11) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 11) then begin
          SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
        end;
      end else begin
        DelTargetCreat();
      end;
    end;
  end;
end;

procedure TSnowBeelzebub.Run;
var
 nCode: byte;
begin
  nCode:= 0;
  Try
    if not m_boDeath and not m_boGhost and(m_wStatusTimeArr[POISON_STONE ] = 0)
      and (m_wStatusTimeArr[POISON_LOCKSPELL{7}] = 0) and (m_wStatusArrValue[23] = 0) then begin
      if ((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil) and m_boIsVisibleActive then begin
        nCode:= 1;
        m_dwSearchEnemyTick := GetTickCount();
        SearchTarget();//搜索可攻击目标
      end;
      if Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed then begin
        nCode:= 2;
        if not m_boNoAttackMode then begin
          if m_TargetCret <> nil then begin
            nCode:= 3;
            if AttackTarget then begin
              inherited;
              Exit;
            end;
            nCode:= 9;
            if (m_TargetCret <> nil) then begin
              nCode:= 10;
              if (not m_TargetCret.m_boDeath) and (not m_TargetCret.m_boGhost) then begin
                nCode:= 11;
                if ((abs(m_nCurrX - m_TargetCret.m_nCurrX) > 5) or (abs(m_nCurrY - m_TargetCret.m_nCurrY) > 5)) then begin //目标离远了,走向目标
                  nCode:= 6;
                  m_nTargetX := m_TargetCret.m_nCurrX;
                  m_nTargetY := m_TargetCret.m_nCurrY;
                  nCode:= 7;
                  GotoTargetXY();
                  inherited;
                  Exit;
                end;
              end;
            end;
          end else begin
            m_nTargetX := -1;
            if m_boMission then begin
              m_nTargetX := m_nMissionX;
              m_nTargetY := m_nMissionY;
            end;
          end;
        end;
        nCode:= 8;
        if m_nTargetX <> -1 then begin
          if (m_TargetCret <> nil) then begin
            if (abs(m_nCurrX - m_nTargetX) > 1) or (abs(m_nCurrY - m_nTargetY) > 1) then begin
              GotoTargetXY();
            end;
          end else GotoTargetXY();
        end else begin
         if (m_TargetCret = nil) then Wondering();
        end;
      end;
    end;
  except
    MainOutMessage(Format('{%s} TSnowBeelzebub.Run Code:%d',[g_sExceptionVer, nCode]));
  end;
  inherited;
end;
//-------------------------------------------------------------------------
{TSnowDaysWillBe 雪域天将}
constructor TSnowDaysWillBe.Create;
begin
  inherited;
  m_nViewRange:= 8;
end;

destructor TSnowDaysWillBe.Destroy;
begin
  inherited;
end;

function TSnowDaysWillBe.AttackTarget: Boolean;
var
  nPower, I: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
begin
  Result := False;
  if m_TargetCret = nil then Exit;
  if GetTickCount - m_dwHitTick > m_nNextHitTime then begin
    m_dwHitTick := GetTickCount();
    if not m_TargetCret.m_boDeath then begin
      if ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 1) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 0)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 1) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 1)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 2) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 2)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 2) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 0)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 3) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 3)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 3) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 0)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 4) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 4)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 4) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 0)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 0) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 1)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 0) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 2)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 0) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 3)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 0) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 4)) then begin
        m_dwTargetFocusTick := GetTickCount();
        nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
        if (GetTickCount - m_dwFreezeMagicTick > 35000) then begin
          m_dwFreezeMagicTick:= GetTickCount();
          BaseObjectList := TList.Create;
          try
            m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
            m_PEnvir.GetMapBaseObjects(m_nCurrX, m_nCurrY, 4, BaseObjectList);//周围的目标 4格
            if BaseObjectList.Count > 0 then begin
              //发消息给客户端，显示效果
              SendRefMsg(RM_LIGHTING, 1, m_nCurrX, m_nCurrY, Integer(m_TargetCret), '');
              for I := 0 to BaseObjectList.Count - 1 do begin
                TargeTBaseObject := TBaseObject(BaseObjectList.Items[I]);
                if TargeTBaseObject <> nil then begin
                  if IsProperTarget(TargeTBaseObject) then begin
                    if 10 >= Random(TargeTBaseObject.m_nAntiMagic + 10) then begin
                      TargeTBaseObject.SendDelayMsg(self, RM_MAGSTRUCK, 0, nPower, 0, 0, '', 300);
                    end;
                    TargeTBaseObject.MakeFreezeMag(10);//使用冰冻术
                  end;
                end;
              end;//for
              Result := True;
              Exit;
            end;
          finally
            BaseObjectList.Free;
          end;
        end else begin
          if ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 1) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 0)) or
             ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 1) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 1)) or
             ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 0) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 1)) then begin
            HitMagAttackTarget(m_TargetCret, nPower div 2, nPower div 2, True); //SM_HIT 普通攻击
            Result := True;
            Exit;
          end;
        end;
      end;
      if m_TargetCret.m_PEnvir = m_PEnvir then begin
        if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 11) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 11) then begin
          SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
        end;
      end else begin
        DelTargetCreat();
      end;
    end;
  end;
end;

procedure TSnowDaysWillBe.Run;
var
 nCode: byte;
begin
  nCode:= 0;
  Try
    if not m_boDeath and not m_boGhost and(m_wStatusTimeArr[POISON_STONE ] = 0)
      and (m_wStatusTimeArr[POISON_LOCKSPELL{7}] = 0) and (m_wStatusArrValue[23] = 0) then begin
      if ((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil) and m_boIsVisibleActive then begin
        nCode:= 1;
        m_dwSearchEnemyTick := GetTickCount();
        SearchTarget();//搜索可攻击目标
      end;
      if Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed then begin
        nCode:= 2;
        if not m_boNoAttackMode then begin
          if m_TargetCret <> nil then begin
            nCode:= 3;
            if AttackTarget then begin
              inherited;
              Exit;
            end;
            nCode:= 9;
            if (m_TargetCret <> nil) then begin
              nCode:= 10;
              if (not m_TargetCret.m_boDeath) and (not m_TargetCret.m_boGhost) then begin
                nCode:= 11;
                if ((abs(m_nCurrX - m_TargetCret.m_nCurrX) > 5) or (abs(m_nCurrY - m_TargetCret.m_nCurrY) > 5)) then begin //目标离远了,走向目标
                  nCode:= 6;
                  m_nTargetX := m_TargetCret.m_nCurrX;
                  m_nTargetY := m_TargetCret.m_nCurrY;
                  nCode:= 7;
                  GotoTargetXY();
                  inherited;
                  Exit;
                end;
              end;
            end;
          end else begin
            m_nTargetX := -1;
            if m_boMission then begin
              m_nTargetX := m_nMissionX;
              m_nTargetY := m_nMissionY;
            end;
          end;
        end;
        nCode:= 8;
        if m_nTargetX <> -1 then begin
          if (m_TargetCret <> nil) then begin
            if (abs(m_nCurrX - m_nTargetX) > 1) or (abs(m_nCurrY - m_nTargetY) > 1) then begin
              GotoTargetXY();
            end;
          end else GotoTargetXY();
        end else begin
         if (m_TargetCret = nil) then Wondering();
        end;
      end;
    end;
  except
    MainOutMessage(Format('{%s} TSnowDaysWillBe.Run Code:%d',[g_sExceptionVer, nCode]));
  end;
  inherited;
end;
//-------------------------------------------------------------------------
{TSnowGuardian 雪域卫士}
constructor TSnowGuardian.Create;
begin
  inherited;
  m_dwSearchTime := Random(1500) + 1500;
  m_nViewRange := 7;
  m_boStoneMode := True;
  m_nCharStatusEx := STATE_STONE_MODE;
end;

destructor TSnowGuardian.Destroy;
begin
  inherited;
end;

procedure TSnowGuardian.MeltStone;
var
  Event: TEvent;
begin
  m_nCharStatusEx := 0;
  m_nCharStatus := GetCharStatus();
  SendRefMsg(RM_DIGUP, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
  m_boStoneMode := False;
  Event := TEvent.Create(m_PEnvir, m_nCurrX, m_nCurrY, ET_SCULPEICE_1{18}, 300000{5 * 60 * 1000}, True);
  g_EventManager.AddEvent(Event);
end;

function TSnowGuardian.AttackTarget: Boolean;
var
  nPower: Integer;
begin
  Result := False;
  if m_TargetCret = nil then Exit;
  if GetTickCount - m_dwHitTick > m_nNextHitTime then begin
    m_dwHitTick := GetTickCount();
    if not m_TargetCret.m_boDeath then begin
      if ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 1) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 0)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 1) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 1)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 0) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 1)) then begin
      //if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 1) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 1) then begin//小于2格普通攻击
        m_dwTargetFocusTick := GetTickCount();
        nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
        HitMagAttackTarget(m_TargetCret, nPower div 2, nPower div 2, True); //SM_HIT 普通攻击
        Result := True;
        Exit;
      end else begin
        if ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 2) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 2)) or
           ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 2) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 0)) or
           ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 0) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 2)) then begin
        //if (abs(m_nCurrX - m_TargetCret.m_nCurrX) = 2) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) = 2) then begin
          m_dwTargetFocusTick := GetTickCount();
          nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
          if (Random(10) >= m_TargetCret.m_nAntiMagic) then begin
            m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
            SendRefMsg(RM_LIGHTING, 1, m_nCurrX, m_nCurrY, Integer(m_TargetCret), '');
            m_TargetCret.SendDelayMsg(self, RM_MAGSTRUCK, 0, nPower, 0, 0, '', 300);
            Result := True;
            Exit;
          end;
        end;
      end;
      if m_TargetCret.m_PEnvir = m_PEnvir then begin
        if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 11) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 11) then begin
          SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
        end;
      end else begin
        DelTargetCreat();
      end;
    end;
  end;
end;

procedure TSnowGuardian.Run;
var
  I: Integer;
  BaseObject: TBaseObject;
  nCode: Byte;
begin
  nCode:= 0;
  try
    if (not m_boGhost) and (not m_boDeath) and (m_wStatusTimeArr[POISON_STONE] = 0)
      and (m_wStatusTimeArr[POISON_LOCKSPELL{7}] = 0) and (m_wStatusArrValue[23] = 0) and
      (Integer(GetTickCount - m_dwWalkTick) >= m_nWalkSpeed) then begin
      if m_boStoneMode then begin
        nCode:= 1;
        if m_VisibleActors.Count > 0 then begin
          nCode:= 2;
          for I := 0 to m_VisibleActors.Count - 1 do begin
            nCode:= 3;
            BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
            nCode:= 4;
            if BaseObject = nil then Continue;
            nCode:= 5;
            if BaseObject.m_boDeath then Continue;
            nCode:= 6;
            if IsProperTarget(BaseObject) then begin
              nCode:= 7;
              if not BaseObject.m_boHideMode or m_boCoolEye then begin
                nCode:= 8;
                if (abs(m_nCurrX - BaseObject.m_nCurrX) <= 4) and (abs(m_nCurrY - BaseObject.m_nCurrY) <= 4) then begin
                  nCode:= 9;
                  MeltStone();
                  Break;
                end;
              end;
            end;
          end; // for
        end;
      end else begin
        if (((GetTickCount - m_dwSearchEnemyTick) > 8000) or
          (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil))) and m_boIsVisibleActive then begin
          nCode:= 10;
          m_dwSearchEnemyTick := GetTickCount();
          SearchTarget();//搜索可攻击目标
        end;
      end;
      if not m_boStoneMode then begin
        if not m_boNoAttackMode then begin
          if m_TargetCret <> nil then begin
            nCode:= 11;
            if AttackTarget then begin
              inherited;
              Exit;
            end;
            nCode:= 12;
            if (m_TargetCret <> nil) then begin
              nCode:= 13;
              if (not m_TargetCret.m_boDeath) and (not m_TargetCret.m_boGhost) then begin
                nCode:= 14;
                if ((abs(m_nCurrX - m_TargetCret.m_nCurrX) > 2) or (abs(m_nCurrY - m_TargetCret.m_nCurrY) > 2)) then begin //目标离远了,走向目标
                  nCode:= 15;
                  m_nTargetX := m_TargetCret.m_nCurrX;
                  m_nTargetY := m_TargetCret.m_nCurrY;
                  nCode:= 16;
                  GotoTargetXY();
                  inherited;
                  Exit;
                end;
              end;
            end;
          end else begin
            m_nTargetX := -1;
            if m_boMission then begin
              m_nTargetX := m_nMissionX;
              m_nTargetY := m_nMissionY;
            end;
          end;
        end;
        nCode:= 17;
        if m_nTargetX <> -1 then begin
          if (m_TargetCret <> nil) then begin
            if (abs(m_nCurrX - m_nTargetX) > 1) or (abs(m_nCurrY - m_nTargetY) > 1) then begin
              GotoTargetXY();
            end;
          end else GotoTargetXY();
        end else begin
         if (m_TargetCret = nil) then Wondering();
        end;
      end;
    end;
  except
    MainOutMessage(Format('{%s} TSnowGuardian.Run Code:%d',[g_sExceptionVer, nCode]));
  end;
  inherited;
end;
//-------------------------------------------------------------------------
constructor TAutoPathFindMon.Create;
begin
  inherited;
  m_boDupMode := False;
  m_dwThinkTick := GetTickCount();
  m_nViewRange := 5;
  m_nRunTime := 250;
  m_dwSearchTime := 3000 + Random(2000);
  m_dwSearchTick := GetTickCount();
  m_btRaceServer := 109;
  m_boMission := False;
  m_nAutoX:= 0;
  m_nAutoY:= 0;
  sOleMapName:= '';
  nPathCount:= 0;
  Path:= nil;
  m_boAnimal := False;//不是动物,即不能挖
  m_boStickMode := True;//不能冲撞模式(即敌人不能使用野蛮冲撞技能攻击)
  m_btAntiPoison := 200;//中毒躲避
  m_boUnParalysis := True;//防麻痹
  m_boUnPosion := True;//防毒
  m_btAttatckMode:= HAM_GUILD;//行会攻击模式
  m_dwShowHint:= GetTickCount();//提示行进坐标间隔
  PlayObject:= nil;
end;

destructor TAutoPathFindMon.Destroy;
begin
  inherited;
end;

procedure TAutoPathFindMon.RecalcAbilitys;
begin
  inherited;
  m_boAnimal := False;//不是动物,即不能挖
  m_boStickMode := True;//不能冲撞模式(即敌人不能使用野蛮冲撞技能攻击)
  m_btAntiPoison := 200;//中毒躲避
  m_boUnParalysis := True;//防麻痹
  m_boUnPosion := True;//防毒
  m_btAttatckMode:= HAM_GUILD;//行会攻击模式
end;

procedure TAutoPathFindMon.Die;
begin
  inherited;
  MonGotoQF('@KillDartCarMob');
end;

function TAutoPathFindMon.Think(): Boolean; //检测是否重叠
var
  nOldX, nOldY: Integer;
begin
  Result := False;
  if (GetTickCount - m_dwThinkTick) > 3000 then begin
    m_dwThinkTick := GetTickCount();
    if m_PEnvir.GetXYObjCount(m_nCurrX, m_nCurrY) >= 2 then m_boDupMode := True;
    if not IsProperTarget(m_TargetCret) then m_TargetCret := nil;
  end; 
  if m_boDupMode then begin
    nOldX := m_nCurrX;
    nOldY := m_nCurrY;
    WalkTo(Random(8), False);
    if (nOldX <> m_nCurrX) or (nOldY <> m_nCurrY) then begin
      m_boDupMode := False;
      Result := True;
    end;
  end;
end;

procedure TAutoPathFindMon.GotoTargetXY;
var
  I, K, nDir, n14, n20, nOleCount, nPower: Integer;
  BaseObject: TBaseObject;
  sMsg: string;
begin
  if ((m_nCurrX <> m_nTargetX) or (m_nCurrY <> m_nTargetY)) then begin
    n14 := m_nTargetX;
    n20 := m_nTargetY;
    K:= 0;
    nOleCount:= nPathCount;
    if (Length(Path) > 0) and (Length(Path) > nPathCount) then begin
      for I := nPathCount to Length(Path) - 1 do begin
        if K > 5 then begin
          nPathCount:= I + 1;
          Break;
        end;
        if (m_nCurrX <> Path[I].X) or (m_nCurrY <> Path[I].Y) then begin
          n14 := Path[I].X;
          n20 := Path[I].Y;
          nPathCount:= I + 1;
          Break;
        end;
        Inc(K);
      end;
    end;
    nDir := GetNextDirection(m_nCurrX, m_nCurrY, n14, n20);
    if not WalkTo(nDir, False) then begin
      nPathCount:= nOleCount;//有角色挡路则不改变坐标
      BaseObject := GetPoseCreate();//取面前对像
      if (BaseObject <> nil) and (BaseObject <> Self) and (not BaseObject.m_boDeath) then begin
        if IsProperTarget(BaseObject) then begin
          if (not BaseObject.m_boHideMode or m_boCoolEye) then begin
            if GetTickCount - m_dwHitTick > m_nNextHitTime then begin
              m_dwHitTick := GetTickCount();
              SendRefMsg(RM_HIT, m_btDirection, m_nCurrX, m_nCurrY, 0, '');//攻击效果
              nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
              nPower := BaseObject.GetHitStruckDamage(Self, nPower);
              if nPower > 0 then begin
                BaseObject.StruckDamage(nPower);
                BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nPower, BaseObject.m_WAbil.HP, BaseObject.m_WAbil.MaxHP, Integer(Self), '', 300);
              end;
            end;
          end;
        end;
      end;
      if g_Config.boMon109AutoTrun and (Random(3) = 1) then begin//20110729 有目标当路，怪物转向移动
        TurnTo(Random(8));
        if WalkTo(m_btDirection, False) then begin
          Path := g_FindPath.FindPath(m_PEnvir, m_nCurrX, m_nCurrY, m_nAutoX, m_nAutoY, False);
          nPathCount:= 0;
        end;
      end;
    end;
    if (GetTickCount - m_dwShowHint > g_Config.nShowHintMon109 * 1000) and g_Config.boMon109ShowHint then begin//5分钟提示一次行进坐标
      m_dwShowHint := GetTickCount();
      if m_MyGuild <> nil then begin
        if (sAutoFindMonMsg <> '') then begin
          sMsg := AnsiReplaceText(sAutoFindMonMsg, '%GuildName', TGUild(m_MyGuild).sGuildName);
          sMsg := AnsiReplaceText(sMsg, '%map', m_PEnvir.sMapDesc);
          sMsg := AnsiReplaceText(sMsg, '%x', IntToStr(m_nCurrX));
          sMsg := AnsiReplaceText(sMsg, '%y', IntToStr(m_nCurrY));
          sMsg := AnsiReplaceText(sMsg, '%name', m_sCharName);
          UserEngine.SendBroadCastMsgExt(sMsg, t_Say);
        end;
      end else begin
        if (sAutoFindMonMsg1 <> '') then begin
          sMsg := AnsiReplaceText(sAutoFindMonMsg1, '%map', m_PEnvir.sMapDesc);
          sMsg := AnsiReplaceText(sMsg, '%x', IntToStr(m_nCurrX));
          sMsg := AnsiReplaceText(sMsg, '%y', IntToStr(m_nCurrY));
          sMsg := AnsiReplaceText(sMsg, '%name', m_sCharName);
          UserEngine.SendBroadCastMsgExt(sMsg, t_Say);
        end;
      end;
    end;
  end;
end;

procedure TAutoPathFindMon.ScatterBagItems(ItemOfCreat: TBaseObject);
var
  I, II, DropWide: Integer;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
  boCanNotDrop: Boolean;
  MonDrop: pTMonDrop;
  nCode: Byte;
resourcestring
  sExceptionMsg = '{%s} TAutoPathFindMon::ScatterBagItems Code:%d';
begin
  DropWide := 3;
  nCode:= 7;
  try
    g_MonDropLimitLIst.Lock;
    try
      nCode:= 8;
      if m_ItemList <> nil then begin
        for I := m_ItemList.Count - 1 downto 0 do begin
          if m_ItemList.Count <= 0 then Break;
          nCode:= 9;
          UserItem := m_ItemList.Items[I];
          if UserItem <> nil then begin
            if (UserItem.AddValue[0] = 1) and (GetHoursCount(UserItem.MaxDate, Now) <= 0) then begin //删除到期装备
              m_ItemList.Delete(I);
              Dispose(UserItem);
              Continue;
            end;
            nCode:= 15;
            StdItem := UserEngine.GetStdItem(UserItem.wIndex);
            boCanNotDrop := False;
            nCode:= 16;
            if (StdItem <> nil) and (g_MonDropLimitLIst.Count > 0) then begin
              nCode:= 10;
              II:= g_MonDropLimitLIst.IndexOf(StdItem.Name);//20110518注释
              if II > -1 then begin
                MonDrop := pTMonDrop(g_MonDropLimitLIst.Objects[II]);
                if MonDrop <> nil then begin
                  nCode:= 12;
                  if MonDrop.nDropCount < MonDrop.nCountLimit then begin
                    Inc(MonDrop.nDropCount);
                    g_MonDropLimitLIst.Objects[II] := TObject(MonDrop);
                  end else begin
                    Inc(MonDrop.nNoDropCount);
                    boCanNotDrop := True;
                  end;
                end;
              end;
             { for II := 0 to g_MonDropLimitLIst.Count - 1 do begin
                if CompareText(StdItem.Name, g_MonDropLimitLIst.Strings[II]) = 0 then begin
                  nCode:= 11;
                  MonDrop := pTMonDrop(g_MonDropLimitLIst.Objects[II]);
                  if MonDrop <> nil then begin
                    nCode:= 12;
                    if MonDrop.nDropCount < MonDrop.nCountLimit then begin
                      Inc(MonDrop.nDropCount);
                      g_MonDropLimitLIst.Objects[II] := TObject(MonDrop);
                    end else begin
                      Inc(MonDrop.nNoDropCount);
                      boCanNotDrop := True;
                    end;
                  end;
                  Break;
                end;
              end;//for }
            end;
            if boCanNotDrop then Continue;
            nCode:= 13;
            if DropItemDown(UserItem, DropWide, True, True, g_FunctionNPC, Self) then begin
              nCode:= 14;
              m_ItemList.Delete(I);
              nCode:= 17;
              try
                if UserItem <> nil then Dispose(UserItem);
              except
              end;
            end;
          end;
        end;//for
      end;
    finally
      g_MonDropLimitLIst.UnLock;
    end;
  except
    MainOutMessage(Format(sExceptionMsg, [g_sExceptionVer, nCode]));
  end;
end;

procedure TAutoPathFindMon.Run;
var
  I:Integer;
  FindRout: pTFindRout;
begin
  try
    if not m_boGhost and not m_boDeath and not m_boFixedHideMode and not m_boStoneMode
      and (m_wStatusTimeArr[POISON_STONE ] = 0) and
      (m_wStatusTimeArr[POISON_LOCKSPELL{7}] = 0) and (m_wStatusArrValue[23] = 0) then begin
      if sOleMapName <> m_PEnvir.sMapName then begin//与旧地图不同时，则取目标点
        if g_AutoFindRout.Count > 0 then begin
          sOleMapName:= m_PEnvir.sMapName;
          g_AutoFindRout.Lock;
          try
            I:= g_AutoFindRout.IndexOf(m_PEnvir.sMapName);
            if I > -1 then begin
              FindRout:= pTFindRout(g_AutoFindRout.Objects[I]);
              if FindRout <> nil then begin
                m_nAutoX:= FindRout.m_nCurrX;
                m_nAutoY:= FindRout.m_nCurrY;
                Path := g_FindPath.FindPath(m_PEnvir, m_nCurrX, m_nCurrY, m_nAutoX, m_nAutoY, False);
                nPathCount:= 0;
                MonGotoQF('@DartCarGoEnd');
              end;
              m_boMission:= True;
            end else begin
              m_nAutoX:= m_nCurrX;
              m_nAutoY:= m_nCurrY;
            end;
          finally
            g_AutoFindRout.UnLock;
          end;
        end;
      end;
      {if (abs(m_nAutoX - m_nCurrX) <= 1) and (abs(m_nAutoY - m_nCurrY) <= 1) then begin//到达目的地，怪物消失
        m_boNoItem := True;
        MakeGhost;
        inherited;
        Exit;
      end;}

      if m_boWalkWaitLocked then begin
        if (GetTickCount - m_dwWalkWaitTick) > m_dwWalkWait then m_boWalkWaitLocked := False;
      end;
      if not m_boWalkWaitLocked and (Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed) then begin
        m_dwWalkTick := GetTickCount();
        Inc(m_nWalkCount);
        if m_nWalkCount > m_nWalkStep then begin
          m_nWalkCount := 0;
          m_boWalkWaitLocked := True;
          m_dwWalkWaitTick := GetTickCount();
        end;
        if not m_boRunAwayMode then begin
          if not m_boNoAttackMode then begin
            m_nTargetX := -1;
            if m_boMission then begin
              m_nTargetX := m_nAutoX;
              m_nTargetY := m_nAutoY;
            end;
          end;
        end else begin
          if (m_dwRunAwayTime > 0) and ((GetTickCount - m_dwRunAwayStart) > m_dwRunAwayTime) then begin
            m_boRunAwayMode := False;
            m_dwRunAwayTime := 0;
          end;
        end;

        if m_nTargetX <> -1 then begin
          GotoTargetXY();
        end else begin
          Wondering();
        end;
      end;
    end;
  except
    MainOutMessage(Format('{%s} TAutoPathFindMon.Run',[g_sExceptionVer]));
  end;
  inherited;
end;

procedure TAutoPathFindMon.MonGotoQF(sStr: String);
begin
  PlayObject := TPlayObject.Create;
  try
    PlayObject.m_sCharName:= m_sCharName;
    PlayObject.m_sMapName:= m_sMapName;
    PlayObject.m_PEnvir:= m_PEnvir;
    PlayObject.m_nCurrX := m_nCurrX;
    PlayObject.m_nCurrY := m_nCurrY;
    if g_FunctionNPC <> nil then begin
      g_FunctionNPC.GotoLable(PlayObject, sStr, False, False);
    end;
  finally
    PlayObject.Free;
  end;
end;

//-------------------------------------------------------------------------
{TIceEyesTroll 冰眼巨魔}
constructor TIceEyesTroll.Create;
begin
  inherited;
  m_nViewRange:= 6;
  m_nNextHitTime := _MAX(650 ,m_nNextHitTime - m_btSlaveMakeLevel * 100);
  m_nWalkSpeed := _MAX(240 ,m_nWalkSpeed - m_btSlaveMakeLevel * 45);
  m_dwFreezeMagicTick:= GetTickCount();
end;

destructor TIceEyesTroll.Destroy;
begin
  inherited;
end;

procedure TIceEyesTroll.RecalcAbilitys();
begin
  inherited;
  if m_btSlaveMakeLevel in [2,4] then begin
    m_WAbil.AC := MakeLong(m_WAbil.AC + (m_btSlaveMakeLevel * 3), m_WAbil.AC + (m_btSlaveMakeLevel * 3));
    m_WAbil.DC := MakeLong(m_WAbil.DC + (m_btSlaveMakeLevel * 3), m_WAbil.DC + (m_btSlaveMakeLevel * 3));
    m_WAbil.MaxHP := Round(m_WAbil.MaxHP * 1.5);
    m_WAbil.HP := m_WAbil.MaxHP;
  end;
end;

function TIceEyesTroll.AttackTarget: Boolean;
var
  nPower, I: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
  boUserFreeze: Boolean;
begin
  Result := False;
  if m_TargetCret = nil then Exit;
  if GetTickCount - m_dwHitTick > m_nNextHitTime then begin
    m_dwHitTick := GetTickCount();
    if not m_TargetCret.m_boDeath then begin
      case m_btSlaveMakeLevel of
        0: begin
          if ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 1) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 0)) or
             ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 1) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 1)) or
             ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 0) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 1)) then begin
            m_nTargetX := -1;//四格内就不再移动走位
            m_dwTargetFocusTick := GetTickCount();
            if (Random(10) >= m_TargetCret.m_nAntiMagic) then begin
              BaseObjectList := TList.Create;
              try
                m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
                //发消息给客户端，显示效果
                SendRefMsg(RM_LIGHTING, 1, m_nCurrX, m_nCurrY, Integer(m_TargetCret), '');
                GetDirectionBaseObjects_42(m_btDirection, 1, BaseObjectList);//同个方向的目标
                if BaseObjectList.Count > 0 then begin
                  nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
                  for I := 0 to BaseObjectList.Count - 1 do begin
                    TargeTBaseObject := TBaseObject(BaseObjectList.Items[I]);
                    if TargeTBaseObject <> nil then begin
                      if IsProperTarget(TargeTBaseObject) then begin
                        if 10 >= Random(TargeTBaseObject.m_nAntiMagic + 10) then begin
                          TargeTBaseObject.SendDelayMsg(self, RM_MAGSTRUCK, 0, nPower, 0, 0, '', 300);
                        end;
                      end;
                    end;
                  end;//for
                  Result := True;
                  Exit;
                end;
              finally
                BaseObjectList.Free;
              end;
            end else begin//物理攻击
              nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
              HitMagAttackTarget(m_TargetCret, nPower div 2, nPower div 2, True); //SM_HIT 普通攻击
              Result := True;
              Exit;
            end;
          end;
        end;
        1..2: begin
          if ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 1) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 0)) or
             ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 1) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 1)) or
             ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 2) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 2)) or
             ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 2) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 0)) or
             ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 0) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 1)) or
             ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 0) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 2)) then begin
            m_nTargetX := -1;//四格内就不再移动走位
            m_dwTargetFocusTick := GetTickCount();
            if (Random(10) >= m_TargetCret.m_nAntiMagic) then begin
              BaseObjectList := TList.Create;
              try
                m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
                //发消息给客户端，显示效果
                SendRefMsg(RM_LIGHTING, 1, m_nCurrX, m_nCurrY, Integer(m_TargetCret), '');
                GetDirectionBaseObjects_42(m_btDirection, 2, BaseObjectList);//同个方向的目标
                if BaseObjectList.Count > 0 then begin
                  boUserFreeze:= False;
                  if (Random(_MAX(6, 10 - m_btSlaveMakeLevel)) = 0) and (GetTickCount - m_dwFreezeMagicTick > 10000) then begin
                    m_dwFreezeMagicTick:= GetTickCount();
                    boUserFreeze:= True;
                  end;
                  nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
                  for I := 0 to BaseObjectList.Count - 1 do begin
                    TargeTBaseObject := TBaseObject(BaseObjectList.Items[I]);
                    if TargeTBaseObject <> nil then begin
                      if IsProperTarget(TargeTBaseObject) then begin
                        if 10 >= Random(TargeTBaseObject.m_nAntiMagic + 10) then begin
                          TargeTBaseObject.SendDelayMsg(self, RM_MAGSTRUCK, 0, nPower, 0, 0, '', 300);
                        end;
                        if boUserFreeze then TargeTBaseObject.MakeFreezeMag(3);//使用冰冻术
                      end;
                    end;
                  end;//for
                  Result := True;
                  Exit;
                end;
              finally
                BaseObjectList.Free;
              end;
            end else begin//物理攻击
              nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
              HitMagAttackTarget(m_TargetCret, nPower div 2, nPower div 2, True); //SM_HIT 普通攻击
              Result := True;
              Exit;
            end;
          end;
        end;
        3..4: begin
          if ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 1) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 0)) or
             ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 1) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 1)) or
             ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 2) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 2)) or
             ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 2) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 0)) or
             ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 3) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 3)) or
             ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 3) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 0)) or
             ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 4) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 4)) or
             ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 4) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 0)) or
             ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 0) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 1)) or
             ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 0) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 2)) or
             ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 0) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 3)) or
             ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 0) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 4)) then begin
            m_nTargetX := -1;//四格内就不再移动走位
            m_dwTargetFocusTick := GetTickCount();
            if (Random(10) >= m_TargetCret.m_nAntiMagic) then begin
              BaseObjectList := TList.Create;
              try
                m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
                //发消息给客户端，显示效果
                SendRefMsg(RM_LIGHTING, 1, m_nCurrX, m_nCurrY, Integer(m_TargetCret), '');
                GetDirectionBaseObjects_42(m_btDirection, _MAX(3, m_btSlaveMakeLevel), BaseObjectList);//同个方向的目标 4格
                if BaseObjectList.Count > 0 then begin
                  boUserFreeze:= False;
                  if (Random(_MAX(6, 10 - m_btSlaveMakeLevel)) = 0) and (GetTickCount - m_dwFreezeMagicTick > 9000) then begin
                    m_dwFreezeMagicTick:= GetTickCount();
                    boUserFreeze:= True;
                  end;
                  nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
                  for I := 0 to BaseObjectList.Count - 1 do begin
                    TargeTBaseObject := TBaseObject(BaseObjectList.Items[I]);
                    if TargeTBaseObject <> nil then begin
                      if IsProperTarget(TargeTBaseObject) then begin
                        if 10 >= Random(TargeTBaseObject.m_nAntiMagic + 10) then begin
                          TargeTBaseObject.SendDelayMsg(self, RM_MAGSTRUCK, 0, nPower, 0, 0, '', 300);
                        end;
                        if boUserFreeze then TargeTBaseObject.MakeFreezeMag(4);//使用冰冻术
                      end;
                    end;
                  end;//for
                  Result := True;
                  Exit;
                end;
              finally
                BaseObjectList.Free;
              end;
            end else begin//物理攻击
              if ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 1) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 0)) or
                 ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 1) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 1)) or
                 ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 2) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 2)) or
                 ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 2) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 0)) or
                 ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 0) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 1)) or
                 ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 0) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 2)) then begin
                nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
                HitMagAttackTarget(m_TargetCret, nPower div 2, nPower div 2, True); //SM_HIT 普通攻击
                Result := True;
                Exit;
              end;
            end;
          end;
        end;
      end;//case
      if m_TargetCret.m_PEnvir = m_PEnvir then begin
        if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 11) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 11) then begin
          SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
        end;
      end else begin
        DelTargetCreat();
      end;
    end;
  end;
end;

procedure TIceEyesTroll.Run;
var
 nCode: byte;
begin
  nCode:= 0;
  Try
    if not m_boDeath and not m_boGhost and(m_wStatusTimeArr[POISON_STONE ] = 0)
      and (m_wStatusTimeArr[POISON_LOCKSPELL{7}] = 0) and (m_wStatusArrValue[23] = 0) then begin
      if ((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil) and m_boIsVisibleActive then begin
        nCode:= 1;
        m_dwSearchEnemyTick := GetTickCount();
        SearchTarget();//搜索可攻击目标
      end;
      if Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed then begin
        nCode:= 2;
        if not m_boNoAttackMode then begin
          if m_TargetCret <> nil then begin
            nCode:= 3;
            if AttackTarget then begin
              inherited;
              Exit;
            end;
            nCode:= 9;
            if (m_TargetCret <> nil) then begin
              nCode:= 10;
              if (not m_TargetCret.m_boDeath) and (not m_TargetCret.m_boGhost) then begin
                nCode:= 11;
                if ((abs(m_nCurrX - m_TargetCret.m_nCurrX) > 5) or (abs(m_nCurrY - m_TargetCret.m_nCurrY) > 5)) then begin //目标离远了,走向目标
                  nCode:= 6;
                  m_nTargetX := m_TargetCret.m_nCurrX;
                  m_nTargetY := m_TargetCret.m_nCurrY;
                  nCode:= 7;
                  GotoTargetXY();
                  inherited;
                  Exit;
                end;
              end;
            end;
          {end else begin
            m_nTargetX := -1;
            if m_boMission then begin
              m_nTargetX := m_nMissionX;
              m_nTargetY := m_nMissionY;
            end; }
          end;
        end;
        {nCode:= 8;
        if m_nTargetX <> -1 then begin
          if (m_TargetCret <> nil) then begin
            if (abs(m_nCurrX - m_nTargetX) > 1) or (abs(m_nCurrY - m_nTargetY) > 1) then begin
              GotoTargetXY();
            end;
          end else GotoTargetXY();
        end else begin
         if (m_TargetCret = nil) then Wondering();
        end;}
      end;
    end;
  except
    MainOutMessage(Format('{%s} TIceEyesTroll.Run Code:%d',[g_sExceptionVer, nCode]));
  end;
  inherited;
end;

{TIceEyesTrollAvatar 冰眼巨魔(血量低时,会分身)}
constructor TIceEyesTrollAvatar.Create;
begin
  inherited;
  m_nViewRange:= 6;
  m_boAvatar:= False;//是否分身
  m_boIsCopyMon:= False;//是分身
  m_SlaveObjectList := TList.Create;
  m_dwFreezeMagicTick:= GetTickCount();//冰冻术间隔
end;

destructor TIceEyesTrollAvatar.Destroy;
begin
  m_SlaveObjectList.Free;
  inherited;
end;

procedure TIceEyesTrollAvatar.Die;
var
  I: Integer;
  BaseObject: TBaseObject;
begin
  for I := m_SlaveObjectList.Count - 1 downto 0 do begin
    if m_SlaveObjectList.Count <= 0 then Break;
    BaseObject := TBaseObject(m_SlaveObjectList.Items[I]);
    if BaseObject <> nil then BaseObject.m_WAbil.HP:= 0;//分身当主体死亡时,也一起死亡
  end; // for
  inherited;
end;

//召唤下属
procedure TIceEyesTrollAvatar.CallSlave;
var
  I: Integer;
  n10, n14: Integer;
  BaseObject: TBaseObject;
begin
  m_boAvatar:= True;//是否分身
  GetFrontPosition(n10, n14);
  m_wStatusTimeArr[POISON_DECHEALTH] := 0;
  m_wStatusTimeArr[POISON_DAMAGEARMOR]:= 0;
  for I := 1 to 4 do begin
    if m_SlaveObjectList.Count >= 4 then Break;
    BaseObject := UserEngine.RegenMonsterByName(m_sMapName, n10 + Random(5), n14 + Random(5), m_sCharName);
    if BaseObject <> nil then begin
      TIceEyesTrollAvatar(BaseObject).m_boAvatar:= True;//是否分身
      TIceEyesTrollAvatar(BaseObject).m_boIsCopyMon:= True;//是分身
      BaseObject.m_nChangeColorType := m_nChangeColorType; //是否变色
      BaseObject.m_btNameColor:= m_btNameColor;//自定义名字的颜色
      BaseObject.m_boSetNameColor:= m_boSetNameColor;//自定义名字颜色
      BaseObject.m_boIsNGMonster:= m_boIsNGMonster;//内功怪,打死可以增加内力值
      BaseObject.m_boIsHeroPulsExpMon:= m_boIsHeroPulsExpMon;//英雄经络经验怪
      BaseObject.m_nGold:= 0;
      BaseObject.m_WAbil.HP:= m_WAbil.HP;
      m_SlaveObjectList.Add(BaseObject);
    end;
  end; // for
end;

function TIceEyesTrollAvatar.AttackTarget: Boolean;
var
  nPower, I: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
  boUserFreeze: Boolean;
begin
  Result := False;
  if m_TargetCret = nil then Exit;
  if GetTickCount - m_dwHitTick > m_nNextHitTime then begin
    m_dwHitTick := GetTickCount();
    if not m_TargetCret.m_boDeath then begin
      if (m_WAbil.HP < Round(m_WAbil.MaxHP * 0.5)) and (not m_boAvatar) and (m_Master = nil) then begin
        CallSlave;//召唤下属
        Result := True;
        Exit;
      end;
      if ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 1) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 0)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 1) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 1)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 2) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 2)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 2) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 0)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 3) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 3)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 3) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 0)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 4) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 4)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 4) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 0)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 0) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 1)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 0) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 2)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 0) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 3)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 0) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 4)) then begin
        m_nTargetX := -1;//四格内就不再移动走位
        m_dwTargetFocusTick := GetTickCount();
        if (Random(10) >= m_TargetCret.m_nAntiMagic) then begin
          BaseObjectList := TList.Create;
          try
            m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
            //发消息给客户端，显示效果
            SendRefMsg(RM_LIGHTING, 1, m_nCurrX, m_nCurrY, Integer(m_TargetCret), '');
            GetDirectionBaseObjects_42(m_btDirection, _MAX(3, m_btSlaveMakeLevel), BaseObjectList);//同个方向的目标 4格
            if BaseObjectList.Count > 0 then begin
              boUserFreeze:= False;
              if (Random(6) = 0) and (GetTickCount - m_dwFreezeMagicTick > 12000) then begin
                m_dwFreezeMagicTick:= GetTickCount();
                boUserFreeze:= True;
              end;
              nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
              for I := 0 to BaseObjectList.Count - 1 do begin
                TargeTBaseObject := TBaseObject(BaseObjectList.Items[I]);
                if TargeTBaseObject <> nil then begin
                  if IsProperTarget(TargeTBaseObject) then begin
                    if 10 >= Random(TargeTBaseObject.m_nAntiMagic + 10) then begin
                      TargeTBaseObject.SendDelayMsg(self, RM_MAGSTRUCK, 0, nPower, 0, 0, '', 300);
                    end;
                    if boUserFreeze then TargeTBaseObject.MakeFreezeMag(3);//使用冰冻术
                  end;
                end;
              end;//for
              Result := True;
              Exit;
            end;
          finally
            BaseObjectList.Free;
          end;
        end else begin//物理攻击
          if ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 1) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 0)) or
             ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 1) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 1)) or
             ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 2) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 2)) or
             ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 2) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 0)) or
             ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 0) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 1)) or
             ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 0) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 2)) then begin
            nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
            HitMagAttackTarget(m_TargetCret, nPower div 2, nPower div 2, True); //SM_HIT 普通攻击
            Result := True;
            Exit;
          end;
        end;
      end;

      if m_TargetCret.m_PEnvir = m_PEnvir then begin
        if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 11) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 11) then begin
          SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
        end;
      end else begin
        DelTargetCreat();
      end;
    end;
  end;
end;

procedure TIceEyesTrollAvatar.Run;
var
 nCode: byte;
begin
  nCode:= 0;
  Try
    if not m_boDeath and not m_boGhost and(m_wStatusTimeArr[POISON_STONE ] = 0) and
      (m_wStatusTimeArr[POISON_LOCKSPELL{7}] = 0) and (m_wStatusArrValue[23] = 0) then begin
      if ((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil) and m_boIsVisibleActive then begin
        nCode:= 1;
        m_dwSearchEnemyTick := GetTickCount();
        SearchTarget();//搜索可攻击目标
      end;
      if Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed then begin
        nCode:= 2;
        if not m_boNoAttackMode then begin
          if m_TargetCret <> nil then begin
            nCode:= 3;
            if AttackTarget then begin
              inherited;
              Exit;
            end;
            nCode:= 9;
            if (m_TargetCret <> nil) then begin
              nCode:= 10;
              if (not m_TargetCret.m_boDeath) and (not m_TargetCret.m_boGhost) then begin
                nCode:= 11;
                if ((abs(m_nCurrX - m_TargetCret.m_nCurrX) > 5) or (abs(m_nCurrY - m_TargetCret.m_nCurrY) > 5)) then begin //目标离远了,走向目标
                  nCode:= 6;
                  m_nTargetX := m_TargetCret.m_nCurrX;
                  m_nTargetY := m_TargetCret.m_nCurrY;
                  nCode:= 7;
                  GotoTargetXY();
                  inherited;
                  Exit;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  except
    MainOutMessage(Format('{%s} TIceEyesTrollAvatar.Run Code:%d',[g_sExceptionVer, nCode]));
  end;
  inherited;
end;
//------------------------------------------------------------------------------
{TRedFox 赤狐:红色雷术}
constructor TRedFox.Create;
begin
  inherited;
  m_nViewRange:= 8;
end;

destructor TRedFox.Destroy;
begin
  inherited;
end;

//使用雷电术攻击
function TRedFox.AttackTarget(): Boolean;
var
  nPower, NGSecPwr: Integer;
begin
  Result := False;
  if (m_TargetCret = nil) then Exit;
  if GetTickCount - m_dwHitTick > m_nNextHitTime then begin
    m_dwHitTick := GetTickCount();
    if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 5) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 5) then begin
      m_dwTargetFocusTick := GetTickCount();
      m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      nPower:= GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))+1);
      if not m_TargetCret.m_boDeath then begin
        if (Random(10) >= m_TargetCret.m_nAntiMagic) then begin
          if m_TargetCret.m_btLifeAttrib = LA_UNDEAD then nPower := Round(nPower * 1.5);//如果为不死系
          SendDelayMsg(self, RM_DELAYMAGIC, nPower, MakeLong(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY), 2, Integer(m_TargetCret), '', 600);
          //发消息给客户端，显示效果
          SendRefMsg(RM_LIGHTING, 1, m_nCurrX, m_nCurrY, Integer(m_TargetCret), '');
          m_nTargetX := -1;
          Result := True;
          Exit;
        end;
      end;
      if (m_TargetCret.m_PEnvir <> m_PEnvir) or (abs(m_nCurrX - m_TargetCret.m_nCurrX) > 11) or
        (abs(m_nCurrX - m_TargetCret.m_nCurrX) > 11) then begin
        DelTargetCreat();
      end;
    end;
  end;
end;

procedure TRedFox.Run;
var
 nCode: byte;
begin
  nCode:= 0;
  Try
    if not m_boDeath and not m_boGhost and(m_wStatusTimeArr[POISON_STONE ] = 0)
      and (m_wStatusTimeArr[POISON_LOCKSPELL{7}] = 0) and (m_wStatusArrValue[23] = 0) then begin
      if ((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil) and m_boIsVisibleActive then begin//20090503 修改
        m_dwSearchEnemyTick := GetTickCount();
        nCode:= 1;
        SearchTarget();//搜索可攻击目标
      end;
      nCode:= 5;
      if Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed then begin
        if not m_boNoAttackMode then begin
          if m_TargetCret <> nil then begin
            nCode:= 2;
            if AttackTarget then begin
              inherited;
              Exit;
            end;
            nCode:= 3;
            if (m_TargetCret <> nil) then begin
              if (not m_TargetCret.m_boDeath) and (not m_TargetCret.m_boGhost) then begin//20090227
                if (abs(m_nCurrX - m_TargetCret.m_nCurrX) > 5) or (abs(m_nCurrY - m_TargetCret.m_nCurrY) > 5) then begin //目标离远了,走向目标
                  m_nTargetX := m_TargetCret.m_nCurrX;
                  m_nTargetY := m_TargetCret.m_nCurrY;
                end;
              end;
            end;    
          end else begin
            m_nTargetX := -1;
            if m_boMission then begin
              m_nTargetX := m_nMissionX;
              m_nTargetY := m_nMissionY;
            end;
          end;
        end;
      end;
    end;
  except
    MainOutMessage(Format('{%s} TRedFox.Run Code:%d',[g_sExceptionVer, nCode]));
  end;
  inherited;
end;
//-----------------------------------------------------------------------------
{TRedFoxWang 赤狐王:红色雷电(类似雷电术)，不能毒}
constructor TRedFoxWang.Create;
begin
  inherited;
  m_btAntiPoison := 200;//中毒躲避
end;

destructor TRedFoxWang.Destroy;
begin
  inherited;
end;

//使用雷电术攻击
function TRedFoxWang.AttackTarget(): Boolean;
var
  nPower, NGSecPwr: Integer;
begin
  Result := False;
  if (m_TargetCret = nil) then Exit;
  if GetTickCount - m_dwHitTick > m_nNextHitTime then begin
    m_dwHitTick := GetTickCount();
    if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 5) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 5) then begin
      m_dwTargetFocusTick := GetTickCount();

      nPower:= GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))+1);
      if not m_TargetCret.m_boDeath then begin
        if (Random(8) = 0) and (m_TargetCret.m_WAbil.MP > 0) and
          ((m_TargetCret.m_btRaceServer = RC_PLAYOBJECT) or
          (m_TargetCret.m_btRaceServer = RC_HEROOBJECT)) then begin//减目标蓝
          m_TargetCret.DamageSpell(nPower);
          m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
          SendRefMsg(RM_FAIRYATTACKRATE, 1, m_nCurrX, m_nCurrY, Integer(m_TargetCret), '');
          m_nTargetX := -1;
          Result := True;
          Exit;
        end;
        if (Random(10) >= m_TargetCret.m_nAntiMagic) then begin
          if m_TargetCret.m_btLifeAttrib = LA_UNDEAD then nPower := Round(nPower * 1.5);//如果为不死系
          m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
          SendDelayMsg(self, RM_DELAYMAGIC, nPower, MakeLong(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY), 2, Integer(m_TargetCret), '', 600);
          //发消息给客户端，显示效果
          SendRefMsg(RM_LIGHTING, 1, m_nCurrX, m_nCurrY, Integer(m_TargetCret), '');
          m_nTargetX := -1;
          Result := True;
          Exit;
        end;
      end;
      if (m_TargetCret.m_PEnvir <> m_PEnvir) or (abs(m_nCurrX - m_TargetCret.m_nCurrX) > 11) or
        (abs(m_nCurrX - m_TargetCret.m_nCurrX) > 11) then begin
        DelTargetCreat();
      end;  
    end;
  end;
end;
//-----------------------------------------------------------------------------
{TSuFox 素狐:类似诅咒术效果(群攻)}
constructor TSuFox.Create;
begin
  inherited;
  m_nViewRange:= 8;
end;

destructor TSuFox.Destroy;
begin
  inherited;
end;

//使用类似诅咒术攻击
function TSuFox.AttackTarget(): Boolean;
var
  nPower, I: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
begin
  Result := False;
  if (m_TargetCret = nil) then Exit;
  if GetTickCount - m_dwHitTick > m_nNextHitTime then begin
    m_dwHitTick := GetTickCount();
    if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 5) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 5) then begin
      m_dwTargetFocusTick := GetTickCount();
      BaseObjectList := TList.Create;
      try
        m_PEnvir.GetMapBaseObjects(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 2, BaseObjectList);
        if BaseObjectList.Count > 0 then begin
          m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
          nPower:= GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))+1);
          //发消息给客户端，显示效果
          SendRefMsg(RM_LIGHTING, 1, m_nCurrX, m_nCurrY, Integer(m_TargetCret), '');
          m_nTargetX := -1;
          Result := True;
          for I := 0 to BaseObjectList.Count - 1 do begin
            TargeTBaseObject := TBaseObject(BaseObjectList.Items[I]);
            if TargeTBaseObject <> nil then begin
              if IsProperTarget(TargeTBaseObject) then begin
                if (Random(10) >= TargeTBaseObject.m_nAntiMagic) then begin
                  TargeTBaseObject.SendMsg(Self, RM_MAGSTRUCK, 0, nPower, 0, 0, '');
                end;
              end;
            end;
          end;
        end;
      finally
        BaseObjectList.Free;
      end;
      if (m_TargetCret.m_PEnvir <> m_PEnvir) or (abs(m_nCurrX - m_TargetCret.m_nCurrX) > 11) or
        (abs(m_nCurrX - m_TargetCret.m_nCurrX) > 11) then begin
        DelTargetCreat();
      end;
    end;
  end;
end;

procedure TSuFox.Run;
var
 nCode: byte;
begin
  nCode:= 0;
  Try
    if not m_boDeath and not m_boGhost and(m_wStatusTimeArr[POISON_STONE ] = 0)
      and (m_wStatusTimeArr[POISON_LOCKSPELL{7}] = 0) and (m_wStatusArrValue[23] = 0) then begin
      if ((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil) and m_boIsVisibleActive then begin//20090503 修改
        m_dwSearchEnemyTick := GetTickCount();
        nCode:= 1;
        SearchTarget();//搜索可攻击目标
      end;
      nCode:= 5;
      if Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed then begin
        if not m_boNoAttackMode then begin
          if m_TargetCret <> nil then begin
            nCode:= 2;
            if AttackTarget then begin
              inherited;
              Exit;
            end;
            nCode:= 3;
            if (m_TargetCret <> nil) then begin
              if (not m_TargetCret.m_boDeath) and (not m_TargetCret.m_boGhost) then begin//20090227
                if (abs(m_nCurrX - m_TargetCret.m_nCurrX) > 5) or (abs(m_nCurrY - m_TargetCret.m_nCurrY) > 5) then begin //目标离远了,走向目标
                  m_nTargetX := m_TargetCret.m_nCurrX;
                  m_nTargetY := m_TargetCret.m_nCurrY;
                end;
              end;
            end;    
          end else begin
            m_nTargetX := -1;
            if m_boMission then begin
              m_nTargetX := m_nMissionX;
              m_nTargetY := m_nMissionY;
            end;
          end;
        end;
      end;
    end;
  except
    MainOutMessage(Format('{%s} TSuFox.Run Code:%d',[g_sExceptionVer, nCode]));
  end;
  inherited;
end;
//-----------------------------------------------------------------------------
{TSuFoxWang 素狐:似诅咒术效果(群攻)，不能毒}
constructor TSuFoxWang.Create;
begin
  inherited;
  m_nViewRange:= 8;
  m_btAntiPoison := 200;//中毒躲避
end;

destructor TSuFoxWang.Destroy;
begin
  inherited;
end;

//使用类似诅咒术，及减防术攻击
function TSuFoxWang.AttackTarget(): Boolean;
var
  nPower, I: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
begin
  Result := False;
  if (m_TargetCret = nil) then Exit;
  if GetTickCount - m_dwHitTick > m_nNextHitTime then begin
    m_dwHitTick := GetTickCount();
    if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 5) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 5) then begin
      m_dwTargetFocusTick := GetTickCount();
      if (Random(8) = 0) and (m_TargetCret.m_wStatusTimeArr[POISON_LOCK1] = 0) and
        ((m_TargetCret.m_btRaceServer = RC_PLAYOBJECT) or
        (m_TargetCret.m_btRaceServer = RC_HEROOBJECT)) then begin//目标减防状态
        m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
        SendRefMsg(RM_FAIRYATTACKRATE, 1, m_nCurrX, m_nCurrY, Integer(m_TargetCret), '');
        if m_TargetCret.MakeSkill102Mag(3) then begin
          m_nTargetX := -1;
          Result := True;
          Exit;
        end;
      end;
      BaseObjectList := TList.Create;
      try
        m_PEnvir.GetMapBaseObjects(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 2, BaseObjectList);
        if BaseObjectList.Count > 0 then begin
          m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
          nPower:= GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))+1);
          //发消息给客户端，显示效果
          SendRefMsg(RM_LIGHTING, 1, m_nCurrX, m_nCurrY, Integer(m_TargetCret), '');
          m_nTargetX := -1;
          Result := True;
          for I := 0 to BaseObjectList.Count - 1 do begin
            TargeTBaseObject := TBaseObject(BaseObjectList.Items[I]);
            if TargeTBaseObject <> nil then begin
              if IsProperTarget(TargeTBaseObject) then begin
                if (Random(10) >= TargeTBaseObject.m_nAntiMagic) then begin
                  TargeTBaseObject.SendMsg(Self, RM_MAGSTRUCK, 0, nPower, 0, 0, '');
                end;
              end;
            end;
          end;
        end;
      finally
        BaseObjectList.Free;
      end;
      if (m_TargetCret.m_PEnvir <> m_PEnvir) or (abs(m_nCurrX - m_TargetCret.m_nCurrX) > 11) or
        (abs(m_nCurrX - m_TargetCret.m_nCurrX) > 11) then begin
        DelTargetCreat();
      end;
    end;
  end;
end;
//---------------------------------------------------------------------------
{TBlackFox 黑狐:施放刺杀剑术}
constructor TBlackFox.Create;
begin
  inherited;
  m_nViewRange:= 8;
end;

destructor TBlackFox.Destroy;
begin
  inherited;
end;

//使用刺杀剑术攻击
function TBlackFox.AttackTarget(): Boolean;
  //刺杀前面一个位置的攻击  
  function SwordLongAttack(nSecPwr: Integer; Target: TBaseObject): Boolean;
  var
    nX, nY: Integer;
    BaseObject: TBaseObject;
  begin
    Result := False;
    try
      nSecPwr := Round(nSecPwr * g_Config.nSwordLongPowerRate / 100);
      if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, 2, nX, nY) then begin
        BaseObject := m_PEnvir.GetMovingObject(nX, nY, True);
        if BaseObject <> nil then begin
          if (nSecPwr > 0) and IsProperTarget(BaseObject) then begin
            if Target <> nil then begin//判断刀尖位置与目标是不是同个对像
              if BaseObject = Target then Exit;
            end;
            {$IF M2Version <> 2}
            case BaseObject.m_btRaceServer of
              RC_PLAYOBJECT: begin//内功护体,增加防御
                if TPlayObject(BaseObject).m_boTrainingNG and (TPlayObject(BaseObject).m_Skill69NH > 0) then begin
                  case m_btJob of//按职业来计算内功防御力
                    0: nSecPwr := _MAX(0, nSecPwr - ((TPlayObject(BaseObject).m_NGLevel div g_Config.nWarrNGLevelIncAC) + 12));
                    1: nSecPwr := _MAX(0, nSecPwr - ((TPlayObject(BaseObject).m_NGLevel div g_Config.nWizardNGLevelIncAC) + 15));
                    2: nSecPwr := _MAX(0, nSecPwr - ((TPlayObject(BaseObject).m_NGLevel div g_Config.nTaosNGLevelIncAC) + 13));
                  end;
                  TPlayObject(BaseObject).m_Skill69NH:= _MAX(0, TPlayObject(BaseObject).m_Skill69NH - g_Config.nHitStruckDecNH);
                  TPlayObject(BaseObject).SendRefMsg( RM_MAGIC69SKILLNH, 0, TPlayObject(BaseObject).m_Skill69NH, TPlayObject(BaseObject).m_Skill69MaxNH, 0, '');
                end;
              end;
              RC_HEROOBJECT: begin
                if THeroObject(BaseObject).m_boTrainingNG and (THeroObject(BaseObject).m_Skill69NH > 0) then begin
                  case m_btJob of//按职业来计算内功防御力
                    0: nSecPwr := _MAX(0, nSecPwr - ((THeroObject(Self).m_NGLevel div g_Config.nWarrNGLevelIncAC) + 12));
                    1: nSecPwr := _MAX(0, nSecPwr - ((THeroObject(Self).m_NGLevel div g_Config.nWizardNGLevelIncAC) + 15));
                    2: nSecPwr := _MAX(0, nSecPwr - ((THeroObject(Self).m_NGLevel div g_Config.nTaosNGLevelIncAC) + 13));
                  end;
                  THeroObject(BaseObject).m_Skill69NH:= _MAX(0, THeroObject(BaseObject).m_Skill69NH - g_Config.nHitStruckDecNH);
                  THeroObject(BaseObject).SendRefMsg( RM_MAGIC69SKILLNH, 0, THeroObject(BaseObject).m_Skill69NH, THeroObject(BaseObject).m_Skill69MaxNH, 0, '');
                end;
              end;
            end;
            {$IFEND}
            if BaseObject.m_boAbilMagBubbleDefence then begin//四级盾可防隔位刺杀 20081217
              if BaseObject.m_btMagBubbleDefenceLevel = 4 then begin
                nSecPwr := Round(nSecPwr * 0.86);//四级盾可以减少隔位刺杀14%的攻击力
              end;
            end;
            if Random(BaseObject.m_btSpeedPoint) < m_btHitPoint then begin
              BaseObject.StruckDamage(nSecPwr);
              BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK),
                RM_10101,
                nSecPwr,
                BaseObject.m_WAbil.HP,
                BaseObject.m_WAbil.MaxHP,
                Integer(Self), '', 500);
              Result := True;
            end;
          end;
        end;
      end;
    except
    end;
  end;
var
  nPower, I: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
begin
  Result := False;
  if (m_TargetCret = nil) then Exit;
  if GetTickCount - m_dwHitTick > m_nNextHitTime then begin
    m_dwHitTick := GetTickCount();
    if not m_TargetCret.m_boDeath then begin
      if (abs(m_TargetCret.m_nCurrX - m_nCurrX) <= 2) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) <= 2) then begin
        m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
        nPower:= GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))+1);
        if Random(m_TargetCret.m_btSpeedPoint) < m_btHitPoint then begin
          SwordLongAttack(nPower, m_TargetCret);//刺杀前一个位置
          HitMagAttackTarget(m_TargetCret, nPower div 2, nPower div 2, True); //SM_HIT 普通攻击
          m_nTargetX := -1;
          Result := True;
        end;
      end;
      if m_TargetCret.m_PEnvir = m_PEnvir then begin
        if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 11) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 11) then begin
          SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
        end;
      end else begin
        DelTargetCreat();
      end;
    end;
  end;
end;

procedure TBlackFox.Run;
var
 nCode: byte;
begin
  nCode:= 0;
  Try
    if not m_boDeath and not m_boGhost and(m_wStatusTimeArr[POISON_STONE ] = 0)
      and (m_wStatusTimeArr[POISON_LOCKSPELL{7}] = 0) and (m_wStatusArrValue[23] = 0) then begin
      if ((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil) and m_boIsVisibleActive then begin//20090503 修改
        m_dwSearchEnemyTick := GetTickCount();
        nCode:= 1;
        SearchTarget();//搜索可攻击目标
      end;
      nCode:= 5;
      if Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed then begin
        if not m_boNoAttackMode then begin
          if m_TargetCret <> nil then begin
            nCode:= 2;
            if AttackTarget then begin
              inherited;
              Exit;
            end;
            nCode:= 3;
            if (m_TargetCret <> nil) then begin
              if (not m_TargetCret.m_boDeath) and (not m_TargetCret.m_boGhost) then begin
                if (abs(m_nCurrX - m_TargetCret.m_nCurrX) > 2) or (abs(m_nCurrY - m_TargetCret.m_nCurrY) > 2) then begin //目标离远了,走向目标
                  m_nTargetX := m_TargetCret.m_nCurrX;
                  m_nTargetY := m_TargetCret.m_nCurrY;
                end;
              end;
            end;    
          end else begin
            m_nTargetX := -1;
            if m_boMission then begin
              m_nTargetX := m_nMissionX;
              m_nTargetY := m_nMissionY;
            end;
          end;
        end;
      end;
    end;
  except
    MainOutMessage(Format('{%s} TBlackFox.Run Code:%d',[g_sExceptionVer, nCode]));
  end;
  inherited;
end;
//----------------------------------------------------------------------------
{TBlackFoxWang 黑狐王:施放刺杀剑术，不能毒}
constructor TBlackFoxWang.Create;
begin
  inherited;
  m_btAntiPoison := 200;//中毒躲避
end;

destructor TBlackFoxWang.Destroy;
begin
  inherited;
end;

//使用刺杀剑术攻击
function TBlackFoxWang.AttackTarget(): Boolean;
  //刺杀前面一个位置的攻击  
  function SwordLongAttack(nSecPwr: Integer; Target: TBaseObject): Boolean;
  var
    nX, nY: Integer;
    BaseObject: TBaseObject;
  begin
    Result := False;
    try
      nSecPwr := Round(nSecPwr * g_Config.nSwordLongPowerRate / 100);
      if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, 2, nX, nY) then begin
        BaseObject := m_PEnvir.GetMovingObject(nX, nY, True);
        if BaseObject <> nil then begin
          if (nSecPwr > 0) and IsProperTarget(BaseObject) then begin
            if Target <> nil then begin//判断刀尖位置与目标是不是同个对像
              if BaseObject = Target then Exit;
            end;
            {$IF M2Version <> 2}
            case BaseObject.m_btRaceServer of
              RC_PLAYOBJECT: begin//内功护体,增加防御
                if TPlayObject(BaseObject).m_boTrainingNG and (TPlayObject(BaseObject).m_Skill69NH > 0) then begin
                  case m_btJob of//按职业来计算内功防御力
                    0: nSecPwr := _MAX(0, nSecPwr - ((TPlayObject(BaseObject).m_NGLevel div g_Config.nWarrNGLevelIncAC) + 12));
                    1: nSecPwr := _MAX(0, nSecPwr - ((TPlayObject(BaseObject).m_NGLevel div g_Config.nWizardNGLevelIncAC) + 15));
                    2: nSecPwr := _MAX(0, nSecPwr - ((TPlayObject(BaseObject).m_NGLevel div g_Config.nTaosNGLevelIncAC) + 13));
                  end;
                  TPlayObject(BaseObject).m_Skill69NH:= _MAX(0, TPlayObject(BaseObject).m_Skill69NH - g_Config.nHitStruckDecNH);
                  TPlayObject(BaseObject).SendRefMsg( RM_MAGIC69SKILLNH, 0, TPlayObject(BaseObject).m_Skill69NH, TPlayObject(BaseObject).m_Skill69MaxNH, 0, '');
                end;
              end;
              RC_HEROOBJECT: begin
                if THeroObject(BaseObject).m_boTrainingNG and (THeroObject(BaseObject).m_Skill69NH > 0) then begin
                  case m_btJob of//按职业来计算内功防御力
                    0: nSecPwr := _MAX(0, nSecPwr - ((THeroObject(Self).m_NGLevel div g_Config.nWarrNGLevelIncAC) + 12));
                    1: nSecPwr := _MAX(0, nSecPwr - ((THeroObject(Self).m_NGLevel div g_Config.nWizardNGLevelIncAC) + 15));
                    2: nSecPwr := _MAX(0, nSecPwr - ((THeroObject(Self).m_NGLevel div g_Config.nTaosNGLevelIncAC) + 13));
                  end;
                  THeroObject(BaseObject).m_Skill69NH:= _MAX(0, THeroObject(BaseObject).m_Skill69NH - g_Config.nHitStruckDecNH);
                  THeroObject(BaseObject).SendRefMsg( RM_MAGIC69SKILLNH, 0, THeroObject(BaseObject).m_Skill69NH, THeroObject(BaseObject).m_Skill69MaxNH, 0, '');
                end;
              end;
            end;
            {$IFEND}
            if BaseObject.m_boAbilMagBubbleDefence then begin//四级盾可防隔位刺杀 20081217
              if BaseObject.m_btMagBubbleDefenceLevel = 4 then begin
                nSecPwr := Round(nSecPwr * 0.86);//四级盾可以减少隔位刺杀14%的攻击力
              end;
            end;
            if Random(BaseObject.m_btSpeedPoint) < m_btHitPoint then begin
              BaseObject.StruckDamage(nSecPwr);
              BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK),
                RM_10101,
                nSecPwr,
                BaseObject.m_WAbil.HP,
                BaseObject.m_WAbil.MaxHP,
                Integer(Self), '', 500);
              Result := True;
            end;
          end;
        end;
      end;
    except
    end;
  end;
var
  nPower, I: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
begin
  Result := False;
  if (m_TargetCret = nil) then Exit;
  if GetTickCount - m_dwHitTick > m_nNextHitTime then begin
    m_dwHitTick := GetTickCount();
    if not m_TargetCret.m_boDeath then begin
      m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      nPower:= GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))+1);
      if (abs(m_TargetCret.m_nCurrX - m_nCurrX) <= 2) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) <= 2) then begin
        if Random(m_TargetCret.m_btSpeedPoint) < m_btHitPoint then begin
          SwordLongAttack(nPower, m_TargetCret);
          HitMagAttackTarget(m_TargetCret, nPower div 2, nPower div 2, True); //SM_HIT 普通攻击
          if m_TargetCret <> nil then begin
            if (m_TargetCret.m_btRaceServer = RC_PLAYOBJECT) or
               (m_TargetCret.m_btRaceServer = RC_HEROOBJECT) then begin
              if (not m_TargetCret.m_boUnParalysis) {$IF M2Version <> 2}and (not m_TargetCret.m_boCanUerSkill102){$IFEND} then begin//对方没有防麻
                if (Random(8) = 0) and (Random(100) >= m_TargetCret.m_nUnParalysisRate) then begin//防麻机率
                  m_TargetCret.MakePosion(POISON_STONE, 3, 0);//麻痹
                end;
              end;
            end;
          end;
          m_nTargetX := -1;
          Result := True;
        end;
      end;
      if m_TargetCret.m_PEnvir = m_PEnvir then begin
        if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 11) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 11) then begin
          SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
        end;
      end else begin
        DelTargetCreat();
      end;
    end;
  end;
end;
//-----------------------------------------------------------------------------
{TMagicEye 狐月之眼:会自爆攻击,死时会放出一堆火墙}
constructor TMagicEye.Create;
begin
  inherited;
  m_nViewRange:= 5;
end;

destructor TMagicEye.Destroy;
begin
  inherited;
end;

function TMagicEye.AttackTarget(): Boolean;
var
  nPower: Integer;
begin
  Result := False;
  if (m_TargetCret = nil) then Exit;
  if GetTickCount - m_dwHitTick > m_nNextHitTime then begin
    m_dwHitTick := GetTickCount();
    if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 2) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 2) then begin
      m_dwTargetFocusTick := GetTickCount();
      if Random(m_TargetCret.m_btSpeedPoint) < m_btHitPoint then begin
        nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
        HitMagAttackTarget(m_TargetCret, nPower div 2, nPower div 2, True); //SM_HIT 普通攻击
        m_nTargetX := -1;
        Result := True;
      end;
      if (m_TargetCret.m_PEnvir <> m_PEnvir) or (abs(m_nCurrX - m_TargetCret.m_nCurrX) > 11) or
        (abs(m_nCurrX - m_TargetCret.m_nCurrX) > 11) then begin
        DelTargetCreat();
      end;
    end;
  end;
end;
//死亡放火墙
procedure TMagicEye.Die;
var
  nPower: Integer;
begin
  nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
  MagicManager.MagMakeFireCross(Self, Round(nPower * 5), 6, m_nCurrX, m_nCurrY, 0);
  inherited;
end;

procedure TMagicEye.Run;
var
 nCode: byte;
begin
  nCode:= 0;
  Try
    if not m_boDeath and not m_boGhost and(m_wStatusTimeArr[POISON_STONE ] = 0)
      and (m_wStatusTimeArr[POISON_LOCKSPELL{7}] = 0) and (m_wStatusArrValue[23] = 0) then begin
      if ((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil) and m_boIsVisibleActive then begin//20090503 修改
        m_dwSearchEnemyTick := GetTickCount();
        nCode:= 1;
        SearchTarget();//搜索可攻击目标
      end;
      nCode:= 5;
      if Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed then begin
        if not m_boNoAttackMode then begin
          if m_TargetCret <> nil then begin
            nCode:= 2;
            if AttackTarget then begin
              inherited;
              Exit;
            end;
            nCode:= 3;
            if (m_TargetCret <> nil) then begin
              if (not m_TargetCret.m_boDeath) and (not m_TargetCret.m_boGhost) then begin
                if (abs(m_nCurrX - m_TargetCret.m_nCurrX) > 2) or (abs(m_nCurrY - m_TargetCret.m_nCurrY) > 2) then begin //目标离远了,走向目标
                  m_nTargetX := m_TargetCret.m_nCurrX;
                  m_nTargetY := m_TargetCret.m_nCurrY;
                end;
              end;
            end;    
          end else begin
            m_nTargetX := -1;
            if m_boMission then begin
              m_nTargetX := m_nMissionX;
              m_nTargetY := m_nMissionY;
            end;
          end;
        end;
      end;
    end;
  except
    MainOutMessage(Format('{%s} TMagicEye.Run Code:%d',[g_sExceptionVer, nCode]));
  end;
  inherited;
end;
//-----------------------------------------------------------------------------
{TMagicEye1 狐月魔眼:会自爆攻击,死时会放出一堆火墙  }
constructor TMagicEye1.Create;
begin
  inherited;
  m_nViewRange:= 5;
end;

destructor TMagicEye1.Destroy;
begin
  inherited;
end;

//死亡放火墙
procedure TMagicEye1.Die;
  function MagMakeFireCross(nDamage, nHTime, nX, nY: Integer): Integer;
  var
    FireBurnEvent: TFireBurnEvent;
    nScePwr: Integer;
  begin
    Result := 0;
    nScePwr:= nDamage;
    if m_PEnvir.GetEvent(nX, nY - 2) = nil then begin
      FireBurnEvent := TFireBurnEvent.Create(Self, nX, nY - 2, ET_FIRE, nHTime * 1000, nDamage);
      FireBurnEvent.nTwoPwr:= nScePwr;
      g_EventManager.AddEvent(FireBurnEvent);
    end;
    if m_PEnvir.GetEvent(nX - 2, nY) = nil then begin
      FireBurnEvent := TFireBurnEvent.Create(Self, nX - 2, nY, ET_FIRE, nHTime * 1000, nDamage);
      FireBurnEvent.nTwoPwr:= nScePwr;
      g_EventManager.AddEvent(FireBurnEvent);
    end;
    if m_PEnvir.GetEvent(nX, nY - 1) = nil then begin
      FireBurnEvent := TFireBurnEvent.Create(Self, nX, nY - 1, ET_FIRE, nHTime * 1000, nDamage);
      FireBurnEvent.nTwoPwr:= nScePwr;
      g_EventManager.AddEvent(FireBurnEvent);
    end;
    if m_PEnvir.GetEvent(nX - 1, nY) = nil then begin
      FireBurnEvent := TFireBurnEvent.Create(Self, nX - 1, nY, ET_FIRE, nHTime * 1000, nDamage);
      FireBurnEvent.nTwoPwr:= nScePwr;
      g_EventManager.AddEvent(FireBurnEvent);
    end;
    if m_PEnvir.GetEvent(nX, nY) = nil then begin
      FireBurnEvent := TFireBurnEvent.Create(Self, nX, nY, ET_FIRE, nHTime * 1000, nDamage);
      FireBurnEvent.nTwoPwr:= nScePwr;
      g_EventManager.AddEvent(FireBurnEvent);
    end;
    if m_PEnvir.GetEvent(nX + 1, nY) = nil then begin
      FireBurnEvent := TFireBurnEvent.Create(Self, nX + 1, nY, ET_FIRE, nHTime * 1000, nDamage);
      FireBurnEvent.nTwoPwr:= nScePwr;
      g_EventManager.AddEvent(FireBurnEvent);
    end;
    if m_PEnvir.GetEvent(nX, nY + 1) = nil then begin
      FireBurnEvent := TFireBurnEvent.Create(Self, nX, nY + 1, ET_FIRE, nHTime * 1000, nDamage);
      FireBurnEvent.nTwoPwr:= nScePwr;
      g_EventManager.AddEvent(FireBurnEvent);
    end;
    if m_PEnvir.GetEvent(nX + 2, nY) = nil then begin
      FireBurnEvent := TFireBurnEvent.Create(Self, nX + 2, nY, ET_FIRE, nHTime * 1000, nDamage);
      FireBurnEvent.nTwoPwr:= nScePwr;
      g_EventManager.AddEvent(FireBurnEvent);
    end;
    if m_PEnvir.GetEvent(nX, nY + 2) = nil then begin
      FireBurnEvent := TFireBurnEvent.Create(Self, nX, nY + 2, ET_FIRE, nHTime * 1000, nDamage);
      FireBurnEvent.nTwoPwr:= nScePwr;
      g_EventManager.AddEvent(FireBurnEvent);
    end;
    Result := 1;
  end;
var
  nPower: Integer;
begin
  nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
  MagMakeFireCross(Round(nPower * 6), 6, m_nCurrX, m_nCurrY);
  inherited;
end;
//----------------------------------------------------------------------------
{TMagicEye2 朱火弹}
constructor TMagicEye2.Create;
begin
  inherited;
  m_nViewRange:= 5;
  m_dwExplosionTick:= GetTickCount() + 80000;//爆炸计时,80秒自爆
  m_boFirst:= False;
  m_boFirstStruck:= False;//受攻击发送转动消息
  m_boFirstLighting:= False;//是否发过膨涨消息
  m_boFirstTick:= False;
  m_boStickMode := True;//不能冲撞模式(即敌人不能使用野蛮冲撞技能攻击)
  m_btAntiPoison := 200;//中毒躲避
  m_boUnParalysis := True;//防麻痹
  m_nFireCount:= 4;
end;

destructor TMagicEye2.Destroy;
begin
  inherited;
end;

//死亡放火墙
procedure TMagicEye2.Die;
  function MagMakeFireCross(nDamage, nHTime, nX, nY: Integer): Integer;
  var
    FireBurnEvent: TFireBurnEvent;
    nScePwr, I: Integer;
  begin
    Result := 0;
    nScePwr:= nDamage;

    FireBurnEvent := TFireBurnEvent.Create(Self, nX, nY, ET_FIRE, nHTime * 1000, nDamage);
    FireBurnEvent.nTwoPwr:= nScePwr;
    g_EventManager.AddEvent(FireBurnEvent);

    for I := m_nFireCount downto 1 do begin
      if m_nFireCount <= 0 then Break;
      FireBurnEvent := TFireBurnEvent.Create(Self, nX, nY - I, ET_FIRE, nHTime * 1000, nDamage);
      FireBurnEvent.nTwoPwr:= nScePwr;
      g_EventManager.AddEvent(FireBurnEvent);

      FireBurnEvent := TFireBurnEvent.Create(Self, nX - I, nY, ET_FIRE, nHTime * 1000, nDamage);
      FireBurnEvent.nTwoPwr:= nScePwr;
      g_EventManager.AddEvent(FireBurnEvent);

      FireBurnEvent := TFireBurnEvent.Create(Self, nX + I, nY, ET_FIRE, nHTime * 1000, nDamage);
      FireBurnEvent.nTwoPwr:= nScePwr;
      g_EventManager.AddEvent(FireBurnEvent);

      FireBurnEvent := TFireBurnEvent.Create(Self, nX, nY + I, ET_FIRE, nHTime * 1000, nDamage);
      FireBurnEvent.nTwoPwr:= nScePwr;
      g_EventManager.AddEvent(FireBurnEvent);
    end;
    Result := 1;
  end;
begin
  MagMakeFireCross(High(Integer), 4, m_nCurrX, m_nCurrY);//中则直接死亡
  inherited Die;
  m_dwDeathTick:= GetTickCount() - g_Config.dwMakeGhostTime + 2000;//5秒清理尸体
end;

procedure TMagicEye2.Run;
begin
  Try
    if not m_boDeath and not m_boGhost then begin
      m_nTargetX := -1;
      if (not m_boFirstLighting) and (m_dwExplosionTick - GetTickCount <= 4000) then begin//是否发过膨涨消息
        m_boFirstLighting:= True;
        SendRefMsg(RM_LIGHTING, 1, m_nCurrX, m_nCurrY, Integer(self), '');//膨胀
      end;
      if GetTickCount > m_dwExplosionTick then begin//时间到自爆(死亡)
        m_dwExplosionTick:= GetTickCount() + 80000;
        Die;
      end;
    end;
  except
    MainOutMessage(Format('{%s} TMagicEye2.Run',[g_sExceptionVer]));
  end;
  inherited;
end;

function TMagicEye2.Operate(ProcessMsg: pTProcessMessage): Boolean;
var
  BaseObject: TBaseObject;
begin
  try
    case ProcessMsg.wIdent of
      RM_STRUCK: begin//受物理打击
        if not m_boFirstStruck then begin
          m_boFirstStruck:= True;
          SendRefMsg(RM_FAIRYATTACKRATE, 1, m_nCurrX, m_nCurrY, Integer(Self), '');
        end;
        if (not m_boFirstLighting) then begin
          Dec(m_dwExplosionTick, 3000);//每受攻击一次缩短时间3秒
          if (m_dwExplosionTick - GetTickCount <= 4000) then begin//是否发过膨涨消息
            m_dwExplosionTick:= GetTickCount() + 3000;
            m_boFirstLighting:= True;
            SendRefMsg(RM_LIGHTING, 1, m_nCurrX, m_nCurrY, Integer(self), '');//膨胀
          end;
        end;
        if TBaseObject(ProcessMsg.BaseObject) <> nil then begin
          if TBaseObject(ProcessMsg.BaseObject) = Self then begin
            if TBaseObject(ProcessMsg.nParam3) <> nil then begin
              if not TBaseObject(ProcessMsg.nParam3).m_boDeath then begin
                SetLastHiter(TBaseObject(ProcessMsg.nParam3));
              end;
            end;
          end;
        end;
        Result := True;
      end;
      RM_MAGSTRUCK: begin//受魔法攻击
        if not m_boFirstStruck then begin
          m_boFirstStruck:= True;
          SendRefMsg(RM_FAIRYATTACKRATE, 1, m_nCurrX, m_nCurrY, Integer(Self), '');
        end;
        if (not m_boFirstLighting) then begin
          Dec(m_dwExplosionTick, 3000);//每受攻击一次缩短时间3秒
          if (m_dwExplosionTick - GetTickCount <= 4000) then begin//是否发过膨涨消息
            m_dwExplosionTick:= GetTickCount() + 3000;
            m_boFirstLighting:= True;
            SendRefMsg(RM_LIGHTING, 1, m_nCurrX, m_nCurrY, Integer(self), '');//膨胀
          end;
        end;
        if TBaseObject(ProcessMsg.BaseObject) <> nil then begin
          if not TBaseObject(ProcessMsg.BaseObject).m_boDeath then begin
            SetLastHiter(TBaseObject(ProcessMsg.nParam3));
          end;
        end;
        Result := True;
      end;
      RM_MAGSTRUCK_MINE: begin//中火墙攻击后3秒爆炸
        if not m_boFirst then begin
          m_boFirst:= True;
          m_dwExplosionTick:= GetTickCount() + 3000;
          if (not m_boFirstLighting) and (m_dwExplosionTick - GetTickCount <= 4000) then begin//是否发过膨涨消息
            m_boFirstLighting:= True;
            SendRefMsg(RM_LIGHTING, 1, m_nCurrX, m_nCurrY, Integer(self), '');//膨胀
          end;
        end;
        BaseObject:= TBaseObject(ProcessMsg.BaseObject);
        if BaseObject <> nil then begin
          if BaseObject.m_Master <> nil then SetLastHiter(BaseObject.m_Master);
        end;
        Result := True;
      end;
      else begin
        Result := inherited Operate(ProcessMsg);
      end;
    end;
  except
    MainOutMessage(Format('{%s} TMagicEye2.Operate',[g_sExceptionVer]));
  end;
end;

function TMagicEye2.GetShowName(): string;
begin
  Result := FilterShowName(m_sCharName);//过滤有数字的名称
end;

function TMagicEye2.IsProperTarget(BaseObject: TBaseObject): Boolean;
begin
  Result := False;
  if (m_btSlaveMakeLevel > 0) then begin
    if (BaseObject <> nil) then begin
      if (BaseObject.m_btRaceServer < RC_NPC{10}) or (BaseObject.m_btRaceServer > RC_PEACENPC{15}) then Result := True;
    end;
  end else Result := inherited IsProperTarget(BaseObject);
end;

procedure TMagicEye2.Initialize;
begin
  inherited;
  if not m_boFirstTick then begin
    m_boFirstTick:= True;
    if LoWord(m_WAbil.DC) > 0 then m_dwExplosionTick:= GetTickCount() + LoWord(m_WAbil.DC) * 1000;
    m_nFireCount:= _MIN(10, HiWord(m_WAbil.DC));
  end;
end;

//受攻击不掉血
procedure TMagicEye2.StruckDamage(nDamage: Integer);
begin
end;
//不移动
procedure TMagicEye2.Wondering();
begin
end;
//----------------------------------------------------------------------------
{TZhuFireMon 朱火魔}
constructor TZhuFireMon.Create;
begin
  inherited;
  m_nViewRange:= 8;
  m_Path := nil;
  m_nPostion := -1;
  m_nMoveFailCount := 0;
  FillChar(m_RunPos, SizeOf(TRunPos), #0);
  m_PointManager := TPointManager.Create(Self);
  m_nCopySelfCount:= 0;//分身次数
  BBList := TList.Create;
  dwTick5F5:= GetTickCount();
  dwTick5F6:= GetTickCount();
  dwTick5F8:= GetTickCount();
  m_boStickMode := True;//不能冲撞模式(即敌人不能使用野蛮冲撞技能攻击)
  m_btAntiPoison := 200;//中毒躲避
  m_boUnParalysis := True;//防麻痹
end;

destructor TZhuFireMon.Destroy;
begin
  BBList.Free;
  m_Path := nil;
  m_PointManager.Free;
  inherited;
end;

procedure TZhuFireMon.Initialize;
begin
  m_PointManager.PathType := TPathType(0);
  m_PointManager.Initialize(m_PEnvir);
end;
//受攻击不掉血
procedure TZhuFireMon.StruckDamage(nDamage: Integer);
begin
end;
//尝试引爆周围2格范围的所有朱火弹
procedure TZhuFireMon.StruckToMagicEye2();
var
  I: Integer;
  BaseObjectList: TList;
  BaseObject: TBaseObject;
begin
  if Random(2) = 0 then begin
    BaseObjectList := TList.Create;
    Try
      m_PEnvir.GetMapBaseObjects(m_nCurrX, m_nCurrY, 2, BaseObjectList);
      if BaseObjectList.Count > 0 then begin
        for I := 0 to BaseObjectList.Count - 1 do begin
          BaseObject := TBaseObject(BaseObjectList.Items[I]);
          if BaseObject <> nil then begin
            if (BaseObject.m_btRaceServer = 156) and (BaseObject.m_Master = nil) and (Random(2) = 0) then
              BaseObject.SendMsg(Self, RM_MAGSTRUCK_MINE, 0, 100, 1{0}, 0, '');
          end;
        end;
      end;
    Finally
      BaseObjectList.Free;
    End;
  end;
end;

function TZhuFireMon.Operate(ProcessMsg: pTProcessMessage): Boolean;
begin
  try
    case ProcessMsg.wIdent of
      RM_STRUCK: begin//受物理打击(尝试引爆周围2格范围的所有朱火弹)
        StruckToMagicEye2();
        Result := True;
      end;
      RM_MAGSTRUCK: begin//受魔法攻击
        Result := True;
      end;
      RM_MAGSTRUCK_MINE: begin//中火墙攻击后3秒爆炸
        Result := True;
      end;
      else begin
        Result := inherited Operate(ProcessMsg);
      end;
    end;
  except
    MainOutMessage(Format('{%s} TZhuFireMon.Operate',[g_sExceptionVer]));
  end;
end;

function TZhuFireMon.RunToNext(nX, nY: Integer): Boolean;
begin
  if GetTickCount()- dwTick5F4 > 800 then begin
    Result := RunTo(GetNextDirection(m_nCurrX, m_nCurrY, nX, nY), False, nX, nY);
    dwTick5F4 := GetTickCount();
  end else Result := WalkToNext(nX, nY);
end;

function TZhuFireMon.WalkToNext(nX, nY: Integer): Boolean;
begin
  if GetTickCount()- dwTick3F4 > 350 then begin
    Result := WalkTo(GetNextDirection(m_nCurrX, m_nCurrY, nX, nY), False);
    if Result then dwTick3F4 := GetTickCount();
  end;
end;

function TZhuFireMon.GotoNextOne(nX, nY: Integer; boRun: Boolean): Boolean;
var
  I: Integer;
  Path: TPath;
begin
  Result := False;
  if (abs(nX - m_nCurrX) <= 2) and (abs(nY - m_nCurrY) <= 2) then begin
    if (abs(nX - m_nCurrX) <= 1) and (abs(nY - m_nCurrY) <= 1) then begin
      Result := WalkToNext(nX, nY);
    end else begin
      Result := RunToNext(nX, nY);
    end;
  end;
  {if not Result then begin//20110529 注释，占大量CPU
    Path := g_FindPath.FindPath(m_PEnvir, m_nCurrX, m_nCurrY, nX, nY, boRun);
    if Length(Path) > 0 then begin
      for I := 0 to Length(Path) - 1 do begin
        if (Path[I].X <> m_nCurrX) or (Path[I].Y <> m_nCurrY) then begin
          if (abs(Path[I].X - m_nCurrX) >= 2) or (abs(Path[I].Y - m_nCurrY) >= 2) then begin
            Result := RunToNext(Path[I].X, Path[I].Y);
          end else begin
            Result := WalkToNext(Path[I].X, Path[I].Y);
          end;
          break;
        end;
      end;
      Path := nil;
    end;
  end;  }
  m_RunPos.nAttackCount := 0;
end;

procedure TZhuFireMon.Wondering();
var
  nX, nY: Integer;
begin
  if (m_TargetCret <> nil) and (not m_boGhost) and (not m_boDeath) and
    (not m_boFixedHideMode) and (not m_boStoneMode) and (m_wStatusTimeArr[POISON_STONE] = 0) then begin
    nX := m_nCurrX;
    nY := m_nCurrY;
    if (GetTickCount - dwTick5F8 > 10000) then begin//定时改变路线
      dwTick5F8:= GetTickCount();
      if m_PointManager.GetPoint1(nX, nY) then begin
        if (abs(nX - m_nCurrX) > 2) or (abs(nY - m_nCurrY) > 2) then begin
          m_Path := g_FindPath.FindPath(m_PEnvir, m_nCurrX, m_nCurrY, nX, nY, True);
          if (Length(m_Path) > 0) then m_nPostion := 0;
        end else begin
          m_Path := nil;
          m_nPostion := -1;
          TurnTo(GetNextDirection(m_nCurrX, m_nCurrY, nX, nY));
          if GotoNextOne(nX, nY, True) then begin
            m_nMoveFailCount := 0;
          end else begin
            Inc(m_nMoveFailCount);
          end;
        end;
        Exit;
      end;  
    end;
    if (Length(m_Path) > 0) and (m_nPostion < Length(m_Path)) then begin
      if not GotoNextOne(m_Path[m_nPostion].X, m_Path[m_nPostion].Y, True) then begin
        m_Path := nil;
        m_nPostion := -1;
        Inc(m_nMoveFailCount);
        Inc(m_nPostion);
      end else begin
        m_nMoveFailCount := 0;
        Exit;
      end;
    end else begin
      m_Path := nil;
      m_nPostion := -1;
    end;

    if m_PointManager.GetPoint(nX, nY) then begin
      if (abs(nX - m_nCurrX) > 2) or (abs(nY - m_nCurrY) > 2) then begin
        m_Path := g_FindPath.FindPath(m_PEnvir, m_nCurrX, m_nCurrY, nX, nY, True);
        m_nPostion := 0;
        if (Length(m_Path) > 0) and (m_nPostion < Length(m_Path)) then begin
          if not GotoNextOne(m_Path[m_nPostion].X, m_Path[m_nPostion].Y, True) then begin
            m_Path := nil;
            m_nPostion := -1;
            Inc(m_nMoveFailCount);
          end else begin
            m_nMoveFailCount := 0;
            Inc(m_nPostion);
            Exit;
          end;
        end else begin
          m_Path := nil;
          m_nPostion := -1;
          Inc(m_nMoveFailCount);
        end;
      end else begin
        if GotoNextOne(nX, nY, True) then begin
          m_nMoveFailCount := 0;
        end else begin
          Inc(m_nMoveFailCount);
        end;
      end;
    end else begin
      if (Random(2) = 1) then TurnTo(Random(8))
      else WalkTo(m_btDirection, False);
      m_Path := nil;
      m_nPostion := -1;
      Inc(m_nMoveFailCount);
    end;
  end;
  if m_nMoveFailCount >= 3 then begin
    if (Random(2) = 1) then TurnTo(Random(8))
    else WalkTo(m_btDirection, False);
    m_Path := nil;
    m_nPostion := -1;
    Inc(m_nMoveFailCount);
  end;
end;

function TZhuFireMon.AttackTarget(): Boolean;
var
  BB: TBaseObject;
  nX, nY: Integer;
begin
  Result:= False;
  if (m_TargetCret = nil) then Exit;
  if GetTickCount - m_dwHitTick > m_nNextHitTime then begin
    m_dwHitTick := GetTickCount();
    m_dwTargetFocusTick := GetTickCount();
    if Random(3) = 0 then begin
      case Random(10) of
        0..7: begin//放朱火弹
          if BBList.Count >= 15 then Exit;//控制朱火弹的数量
          if GetTickCount - dwTick5F5 > 3000 then begin
            dwTick5F5:= GetTickCount();
            GetBackPosition(nX, nY);
            if m_PEnvir.CanWalk(nX, nY, False) then begin
              BB:= UserEngine.RegenMonsterByName(m_PEnvir.sMapName, nX, nY, g_Config.sZhuFire);
              if BB <> nil then begin
                BBList.Add(BB);
                m_nTargetX := -1;
                Result := True;
              end;
            end;
          end;
        end;
        8..9: begin//分身
          if (GetTickCount - dwTick5F6 > 10000) and (Random(3) = 0) then begin
            dwTick5F6:= GetTickCount();
            GetBackPosition(nX, nY);
            if m_PEnvir.CanWalk(nX, nY, False) then begin
              BB := UserEngine.RegenMonsterByName(m_PEnvir.sMapName, nX, nY, m_sCharName);
              if BB <> nil then begin
                Inc(m_nCopySelfCount);
                m_nTargetX := -1;
                Result := True;
              end;
            end;
          end;
        end;
      end;
    end;
    if (m_TargetCret.m_PEnvir <> m_PEnvir) or (abs(m_nCurrX - m_TargetCret.m_nCurrX) > 20) or
      (abs(m_nCurrX - m_TargetCret.m_nCurrX) > 20) then begin
      DelTargetCreat();
    end;
  end;
end;

procedure TZhuFireMon.Run;
var
  nCode: byte;
  I: Integer;
  BB: TBaseObject;
begin
  nCode:= 0;
  Try
    if not m_boDeath and not m_boGhost and(m_wStatusTimeArr[POISON_STONE ] = 0)
      and (m_wStatusTimeArr[POISON_LOCKSPELL{7}] = 0) and (m_wStatusArrValue[23] = 0) then begin
      if ((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil) and m_boIsVisibleActive then begin//20090503 修改
        m_dwSearchEnemyTick := GetTickCount();
        nCode:= 1;
        SearchTarget();//搜索可攻击目标
      end;
      nCode:= 5;
      if Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed then begin
        m_dwWalkTick:= GetTickCount();
        if m_nCopySelfCount >= 3 then begin//分身三次死亡
          m_nCopySelfCount:= 0;
          DelTargetCreat();
          m_WAbil.HP:= 0;
          inherited;
          Exit;
        end;
        for I := BBList.Count - 1 downto 0 do begin
          if BBList.Count <= 0 then Break;
          BB := TBaseObject(BBList.Items[I]);
          if (BB <> nil) then begin
            if (BB.m_boDeath) or (BB.m_boGhost) then BBList.Delete(I);
          end else BBList.Delete(I);
        end;
        if not m_boNoAttackMode then begin
          if m_TargetCret <> nil then begin
            nCode:= 2;
            if AttackTarget then begin
              inherited;
              Exit;
            end;  
            nCode:= 3;
            Wondering();//自动走动
          end else begin
            m_nTargetX := -1;
            if m_boMission then begin
              m_nTargetX := m_nMissionX;
              m_nTargetY := m_nMissionY;
            end;
          end;
        end;
      end;
    end;
  except
    MainOutMessage(Format('{%s} TZhuFireMon.Run Code:%d',[g_sExceptionVer, nCode]));
  end;
  inherited;
end;
//-----------------------------------------------------------------------------
{TSoulStone  九尾魂石(不会移动,全屏攻击,毒无效,能网人,流星火雨技能,在四周放出四个超强旋涡)}
constructor TSoulStone.Create;
begin
  inherited;
  m_nViewRange := 8;
  m_btAntiPoison := 200;//中毒躲避
  m_boAnimal := False;//不是动物,即不能挖
  m_boStickMode := True;//不能冲撞模式(即敌人不能使用野蛮冲撞技能攻击)
  m_boUnParalysis := True;//防麻痹
  m_boFixedHideMode:= False;//不隐身
end;

destructor TSoulStone.Destroy;
begin
  inherited;
end;

procedure TSoulStone.Run;
var
  I: Integer;
  nAbs: Integer;
  nRage: Integer;
  BaseObject: TBaseObject;
  TargeTBaseObject: TBaseObject;
begin
  nRage := 9999;
  TargeTBaseObject := nil;
  if not m_boDeath and not m_boGhost and (m_wStatusTimeArr[POISON_STONE ] = 0)
    and (m_wStatusTimeArr[POISON_LOCKSPELL{7}] = 0) and (m_wStatusArrValue[23] = 0) then begin
    if (GetTickCount - m_dwSearchEnemyTick) >= 5000 then begin
      m_dwSearchEnemyTick := GetTickCount();
      if m_VisibleActors.Count > 0 then begin
        for I := 0 to m_VisibleActors.Count - 1 do begin
          BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
          if BaseObject.m_boDeath then Continue;
          if IsProperTarget(BaseObject) then begin
            if not BaseObject.m_boHideMode or m_boCoolEye then begin
              nAbs := abs(m_nCurrX - BaseObject.m_nCurrX) + abs(m_nCurrY - BaseObject.m_nCurrY);
              if nAbs < nRage then begin
                nRage := nAbs;
                TargeTBaseObject := BaseObject;
              end;
            end;
          end;
        end;//for
      end;
      if TargeTBaseObject <> nil then begin
        SetTargetCreat(TargeTBaseObject);
      end;
    end;
    if Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed then begin
      if not m_boNoAttackMode then begin
        if m_TargetCret <> nil then AttackTarget;
      end;
    end;
  end;
  inherited;
end;

function TSoulStone.AttackTarget(): Boolean;
  function MagMakeFireCross(nDamage, nHTime, nX, nY: Integer): Integer;
  var
    FireBurnEvent: TFireBurnEvent;
    nScePwr: Integer;
  begin
    Result := 0;
    if Random(3) = 0 then begin
      if m_PEnvir.GetEvent(nX, nY) = nil then begin
        FireBurnEvent := TFireBurnEvent.Create(Self, nX, nY, ET_VORTEX, nHTime, nDamage);
        g_EventManager.AddEvent(FireBurnEvent);
      end;
    end;
    case Random(2) of
      0: begin
        if m_PEnvir.GetEvent(nX, nY - 3) = nil then begin
          FireBurnEvent := TFireBurnEvent.Create(Self, nX, nY - 3, ET_VORTEX, nHTime, nDamage);
          g_EventManager.AddEvent(FireBurnEvent);
        end;
        if m_PEnvir.GetEvent(nX, nY + 3) = nil then begin
          FireBurnEvent := TFireBurnEvent.Create(Self, nX, nY + 3, ET_VORTEX, nHTime, nDamage);
          g_EventManager.AddEvent(FireBurnEvent);
        end;
        if m_PEnvir.GetEvent(nX - 3, nY) = nil then begin
          FireBurnEvent := TFireBurnEvent.Create(Self, nX - 3, nY, ET_VORTEX, nHTime, nDamage);
          g_EventManager.AddEvent(FireBurnEvent);
        end;
        if m_PEnvir.GetEvent(nX + 3, nY) = nil then begin
          FireBurnEvent := TFireBurnEvent.Create(Self, nX + 3, nY, ET_VORTEX, nHTime, nDamage);
          g_EventManager.AddEvent(FireBurnEvent);
        end;
      end;
      1: begin
        if m_PEnvir.GetEvent(nX + 3, nY + 3) = nil then begin
          FireBurnEvent := TFireBurnEvent.Create(Self, nX + 3, nY + 3, ET_VORTEX, nHTime, nDamage);
          g_EventManager.AddEvent(FireBurnEvent);
        end;
        if m_PEnvir.GetEvent(nX + 3, nY - 3) = nil then begin
          FireBurnEvent := TFireBurnEvent.Create(Self, nX + 3, nY - 3, ET_VORTEX, nHTime, nDamage);
          g_EventManager.AddEvent(FireBurnEvent);
        end;
        if m_PEnvir.GetEvent(nX - 3, nY - 3) = nil then begin
          FireBurnEvent := TFireBurnEvent.Create(Self, nX - 3, nY - 3, ET_VORTEX, nHTime, nDamage);
          g_EventManager.AddEvent(FireBurnEvent);
        end;
        if m_PEnvir.GetEvent(nX - 3, nY + 3) = nil then begin
          FireBurnEvent := TFireBurnEvent.Create(Self, nX - 3, nY + 3, ET_VORTEX, nHTime, nDamage);
          g_EventManager.AddEvent(FireBurnEvent);
        end;
      end;
    end;
    Result := 1;
  end;
var
  I: Integer;
  BaseObject: TBaseObject;
  nPower: Integer;
  WAbil: pTAbility;
  BaseObjectList: TList;
begin
  Result := False;
  if (GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
    m_dwHitTick := GetTickCount();
    WAbil := @m_WAbil;
    nPower := (Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) + 1) + LoWord(WAbil.DC));
    if (Random(6) = 0) and (GetTickCount - m_dwUseTick > 9000) then begin//施放旋涡,网人,威力强
      m_dwUseTick:= GetTickCount();
      MagMakeFireCross(Round(nPower * 6), 6000, m_nCurrX, m_nCurrY);
    end else begin//流星火雨技能攻击(群攻)
      SendRefMsg(RM_LIGHTING, 1, m_nCurrX, m_nCurrY, Integer(m_TargetCret), '');
      if m_TargetCret <> nil then begin
        BaseObjectList := TList.Create;
        try
          m_PEnvir.GetMapBaseObjects(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 2, BaseObjectList);
          if BaseObjectList.Count > 0 then begin
            for I := 0 to BaseObjectList.Count - 1 do begin
              BaseObject := TBaseObject(BaseObjectList.Items[I]);
              if BaseObject = nil then Continue;
              if BaseObject.m_boDeath then Continue;
              if IsProperTarget(BaseObject) then begin
                SendDelayMsg(Self, RM_DELAYMAGIC, nPower, MakeLong(BaseObject.m_nCurrX, BaseObject.m_nCurrY), 2, Integer(BaseObject), '', 200);
              end;
            end; // for
          end;
        finally
          BaseObjectList.Free;
        end;
      end;
    end;
    Result := True;
  end;
end;
//---------------------------------------------------------------------------
{TFoxBeads 狐月天珠(HP低于66.5%时,召唤四个九尾魂石,能放冷冻术,放绿毒}
constructor TFoxBeads.Create;
begin
  inherited;
  m_nViewRange := 10;
  m_btAntiPoison := 200;//中毒躲避
  m_boAnimal := False;//不是动物,即不能挖 2011022
  m_boStickMode := True;//不能冲撞模式(即敌人不能使用野蛮冲撞技能攻击)
  m_boUnParalysis := True;//防麻痹
  m_boFixedHideMode:= False;//不隐身
  boCall:= False;//是否召唤九尾魂石
  nStatus:= 0;//状态
  m_nX:= -1;
  m_nY:= -1;
end;

destructor TFoxBeads.Destroy;
begin
  inherited;
end;

procedure TFoxBeads.RecalcAbilitys;
begin
  if (m_nX < 0) and (m_nX < 0) then begin
    m_nX:= m_nCurrX;
    m_nY:= m_nCurrY;
  end;
  inherited;
end;

//召唤九尾魂石
procedure TFoxBeads.CallSlave;
var
  I: Integer;
  n10, n14: Integer;
  BaseObject: TBaseObject;
begin
  for I := 0 to 3 do begin
    case I of//取坐标
      0: begin
        n10:= m_nX + 6; n14:= m_nY;
      end;
      1: begin
        n10:= m_nX - 6; n14:= m_nY;
      end;
      2: begin
        n10:= m_nX; n14:= m_nY - 6;
      end;
      3: begin
        n10:= m_nX; n14:= m_nY + 6;
      end;
    end;
    BaseObject := UserEngine.RegenMonsterByName(m_PEnvir.sMapName, n10, n14, g_Config.sFoxBeads);
    if BaseObject <> nil then begin
      nCallXY[I].feature:= BaseObject.m_nCurrX;
      nCallXY[I].Status:= BaseObject.m_nCurrY;
      BaseObject.m_boNoItem := True;//死亡不掉物品
      btCallRaceServer:= BaseObject.m_btRaceServer;
      BaseObject.m_nChangeColorType := m_nChangeColorType; //是否变色
      BaseObject.m_btNameColor:= m_btNameColor;//自定义名字的颜色
      BaseObject.m_boSetNameColor:= m_boSetNameColor;//自定义名字颜色
      BaseObject.m_boIsNGMonster:= m_boIsNGMonster;//内功怪,打死可以增加内力值
      BaseObject.m_boIsHeroPulsExpMon:= m_boIsHeroPulsExpMon;//英雄经络经验怪
    end;
  end; // for
end;
//检查召唤九尾魂石是否死亡
function TFoxBeads.CheckCallSlaveDie(): Boolean;
var
  I, K: Integer;
  ObjectList: TList;
  BaseObject: TBaseObject;
  boCall: Boolean;
begin
  Result := False;
  ObjectList:= TList.Create;
  try
    for I := 0 to 3 do begin
      boCall:= False;
      if (nCallXY[I].feature > 0) and (nCallXY[I].Status > 0) then begin
        ObjectList.Clear;
        m_PEnvir.GeTBaseObjects(nCallXY[I].feature, nCallXY[I].Status, False, ObjectList);
        if ObjectList.Count > 0 then begin
          for K := 0 to ObjectList.Count - 1 do begin
            BaseObject := TBaseObject(ObjectList.Items[K]);
            if BaseObject.m_btRaceServer <> btCallRaceServer then Continue;//继续
            if {(not BaseObject.m_boDeath) and} (not BaseObject.m_boGhost) then Break;//没死则退出
            boCall:= True;
            Break;
          end;//for
          if boCall then begin
            BaseObject := UserEngine.RegenMonsterByName(m_PEnvir.sMapName, nCallXY[I].feature, nCallXY[I].Status, g_Config.sFoxBeads);
            if BaseObject <> nil then begin
              nCallXY[I].feature:= BaseObject.m_nCurrX;
              nCallXY[I].Status:= BaseObject.m_nCurrY;
              BaseObject.m_boNoItem := True;//死亡不掉物品
              BaseObject.m_nChangeColorType := m_nChangeColorType; //是否变色
              BaseObject.m_btNameColor:= m_btNameColor;//自定义名字的颜色
              BaseObject.m_boSetNameColor:= m_boSetNameColor;//自定义名字颜色
              BaseObject.m_boIsNGMonster:= m_boIsNGMonster;//内功怪,打死可以增加内力值
              BaseObject.m_boIsHeroPulsExpMon:= m_boIsHeroPulsExpMon;//英雄经络经验怪
            end;
            Result := True;
          end;
        end else begin//没有九尾魂石则创建
          BaseObject := UserEngine.RegenMonsterByName(m_PEnvir.sMapName, nCallXY[I].feature, nCallXY[I].Status, g_Config.sFoxBeads);
          if BaseObject <> nil then begin
            nCallXY[I].feature:= BaseObject.m_nCurrX;
            nCallXY[I].Status:= BaseObject.m_nCurrY;
            BaseObject.m_boNoItem := True;//死亡不掉物品
            BaseObject.m_nChangeColorType := m_nChangeColorType; //是否变色
            BaseObject.m_btNameColor:= m_btNameColor;//自定义名字的颜色
            BaseObject.m_boSetNameColor:= m_boSetNameColor;//自定义名字颜色
            BaseObject.m_boIsNGMonster:= m_boIsNGMonster;//内功怪,打死可以增加内力值
            BaseObject.m_boIsHeroPulsExpMon:= m_boIsHeroPulsExpMon;//英雄经络经验怪
          end;
          Result := True;
        end;
      end;
    end;
  finally
    ObjectList.Free;
  end;
end;

function TFoxBeads.AttackTarget(): Boolean;
var
  nPower: Integer;
begin
  Result := False;
  if (m_TargetCret = nil) then Exit;
  if GetTickCount - m_dwHitTick > m_nNextHitTime then begin
    m_dwHitTick := GetTickCount();
    if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 6) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 6) then begin
      m_dwTargetFocusTick := GetTickCount();
      if not m_TargetCret.m_boDeath then begin
        nStatus:= 0;//根据血量改变状态
        if (m_WAbil.HP < Round(m_WAbil.MaxHP * 0.2)) then nStatus:= 4
        else  if (m_WAbil.HP < Round(m_WAbil.MaxHP * 0.4)) then nStatus:= 3
        else  if (m_WAbil.HP < Round(m_WAbil.MaxHP * 0.6)) then nStatus:= 2
        else  if (m_WAbil.HP < Round(m_WAbil.MaxHP * 0.8)) then nStatus:= 1;
        if (nStatus = 1) and (not boCall) and (m_Master = nil) then begin//召唤四个九尾魂石
          boCall:= True;
          CallSlave;//召唤下属
          m_dwCallTick:= GetTickCount();//检查召唤九尾魂石是否死亡
          Result := True;
          Exit;
        end;
        if boCall and (GetTickCount - m_dwCallTick > 60000) then begin//检查召唤九尾魂石是否死亡
          m_dwCallTick:= GetTickCount();
          if CheckCallSlaveDie() then begin
            Result := True;
            Exit;
          end;
        end;
        if (Random(10) >= m_TargetCret.m_nAntiMagic) then begin//普通雷电攻击
          if (Random(5) = 0) then begin
            case nStatus of//各种状态处理
              0, 1: begin
                if m_TargetCret.MakeFreezeMag(4) then begin//使用冰冻术
                  SendRefMsg(RM_FAIRYATTACKRATE, 1, m_nCurrX, m_nCurrY, Integer(m_TargetCret), '');
                  m_nTargetX := -1;
                  Result := True;
                end else begin
                  nPower:= GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))+1);
                  if m_TargetCret.m_btLifeAttrib = LA_UNDEAD then nPower := Round(nPower * 1.5);//如果为不死系
                  SendDelayMsg(self, RM_DELAYMAGIC, nPower, MakeLong(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY), 2, Integer(m_TargetCret), '', 600);
                  //发消息给客户端，显示效果
                  SendRefMsg(RM_LIGHTING, 1, m_nCurrX, m_nCurrY, Integer(m_TargetCret), '');
                  m_nTargetX := -1;
                  Result := True;
                end;
              end;
              2: begin
                if m_TargetCret.m_wStatusTimeArr[POISON_DECHEALTH] = 0 then begin//放绿毒
                  m_TargetCret.MakePosion(POISON_DECHEALTH, 60, 3);
                  SendAttackMsg(RM_HIT, m_btDirection, 0, m_nCurrX, m_nCurrY);
                  m_nTargetX := -1;
                  Result := True;
                end else begin
                  nPower:= GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))+1);
                  if m_TargetCret.m_btLifeAttrib = LA_UNDEAD then nPower := Round(nPower * 1.5);//如果为不死系
                  SendDelayMsg(self, RM_DELAYMAGIC, nPower, MakeLong(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY), 2, Integer(m_TargetCret), '', 600);
                  //发消息给客户端，显示效果
                  SendRefMsg(RM_LIGHTING, 1, m_nCurrX, m_nCurrY, Integer(m_TargetCret), '');
                  m_nTargetX := -1;
                  Result := True;
                end;
              end;
              3: begin
                if Random(5) <> 0 then begin
                  if m_TargetCret.m_wStatusTimeArr[POISON_DECHEALTH] = 0 then begin//放绿毒
                    m_TargetCret.MakePosion(POISON_DECHEALTH, 60, 3);
                    SendAttackMsg(RM_HIT, m_btDirection, 0, m_nCurrX, m_nCurrY);
                    m_nTargetX := -1;
                    Result := True;
                  end else begin
                    nPower:= GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))+1);
                    if m_TargetCret.m_btLifeAttrib = LA_UNDEAD then nPower := Round(nPower * 1.5);//如果为不死系
                    SendDelayMsg(self, RM_DELAYMAGIC, nPower, MakeLong(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY), 2, Integer(m_TargetCret), '', 600);
                    //发消息给客户端，显示效果
                    SendRefMsg(RM_LIGHTING, 1, m_nCurrX, m_nCurrY, Integer(m_TargetCret), '');
                    m_nTargetX := -1;
                    Result := True;
                  end;
                end else begin
                  if (not m_TargetCret.m_boUnParalysis) {$IF M2Version <> 2}and (not m_TargetCret.m_boCanUerSkill102){$IFEND}
                    and (Random(100) >= m_TargetCret.m_nUnParalysisRate) then begin
                    if m_TargetCret.m_wStatusTimeArr[POISON_STONE] = 0 then begin
                      m_TargetCret.MakePosion(POISON_STONE, 5, 0);
                      SendAttackMsg(RM_HIT, m_btDirection, 0, m_nCurrX, m_nCurrY);
                      m_nTargetX := -1;
                      Result := True;
                    end else begin
                      nPower:= GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))+1);
                      if m_TargetCret.m_btLifeAttrib = LA_UNDEAD then nPower := Round(nPower * 1.5);//如果为不死系
                      SendDelayMsg(self, RM_DELAYMAGIC, nPower, MakeLong(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY), 2, Integer(m_TargetCret), '', 600);
                      //发消息给客户端，显示效果
                      SendRefMsg(RM_LIGHTING, 1, m_nCurrX, m_nCurrY, Integer(m_TargetCret), '');
                      m_nTargetX := -1;
                      Result := True;
                    end;
                  end else begin
                     nPower:= GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))+1);
                    if m_TargetCret.m_btLifeAttrib = LA_UNDEAD then nPower := Round(nPower * 1.5);//如果为不死系
                    SendDelayMsg(self, RM_DELAYMAGIC, nPower, MakeLong(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY), 2, Integer(m_TargetCret), '', 600);
                    //发消息给客户端，显示效果
                    SendRefMsg(RM_LIGHTING, 1, m_nCurrX, m_nCurrY, Integer(m_TargetCret), '');
                    m_nTargetX := -1;
                    Result := True;
                  end;
                end;
              end;
              4: begin
                if Random(3) <> 0 then begin
                  if m_TargetCret.m_wStatusTimeArr[POISON_DECHEALTH] = 0 then begin//放绿毒
                    m_TargetCret.MakePosion(POISON_DECHEALTH, 60, 3);
                    SendAttackMsg(RM_HIT, m_btDirection, 0, m_nCurrX, m_nCurrY);
                    m_nTargetX := -1;
                    Result := True;
                  end else begin
                    nPower:= GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))+1);
                    if m_TargetCret.m_btLifeAttrib = LA_UNDEAD then nPower := Round(nPower * 1.5);//如果为不死系
                    SendDelayMsg(self, RM_DELAYMAGIC, nPower, MakeLong(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY), 2, Integer(m_TargetCret), '', 600);
                    //发消息给客户端，显示效果
                    SendRefMsg(RM_LIGHTING, 1, m_nCurrX, m_nCurrY, Integer(m_TargetCret), '');
                    m_nTargetX := -1;
                    Result := True;
                  end;
                end else begin
                  if (not m_TargetCret.m_boUnParalysis) {$IF M2Version <> 2}and (not m_TargetCret.m_boCanUerSkill102){$IFEND}
                    and (Random(100) >= m_TargetCret.m_nUnParalysisRate) then begin
                    if m_TargetCret.m_wStatusTimeArr[POISON_STONE] = 0 then begin
                      m_TargetCret.MakePosion(POISON_STONE, 5, 0);
                      SendAttackMsg(RM_HIT, m_btDirection, 0, m_nCurrX, m_nCurrY);
                      m_nTargetX := -1;
                      Result := True;
                    end else begin
                      nPower:= GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))+1);
                      if m_TargetCret.m_btLifeAttrib = LA_UNDEAD then nPower := Round(nPower * 1.5);//如果为不死系
                      SendDelayMsg(self, RM_DELAYMAGIC, nPower, MakeLong(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY), 2, Integer(m_TargetCret), '', 600);
                      //发消息给客户端，显示效果
                      SendRefMsg(RM_LIGHTING, 1, m_nCurrX, m_nCurrY, Integer(m_TargetCret), '');
                      m_nTargetX := -1;
                      Result := True;
                    end;
                  end else begin
                     nPower:= GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))+1);
                    if m_TargetCret.m_btLifeAttrib = LA_UNDEAD then nPower := Round(nPower * 1.5);//如果为不死系
                    SendDelayMsg(self, RM_DELAYMAGIC, nPower, MakeLong(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY), 2, Integer(m_TargetCret), '', 600);
                    //发消息给客户端，显示效果
                    SendRefMsg(RM_LIGHTING, 1, m_nCurrX, m_nCurrY, Integer(m_TargetCret), '');
                    m_nTargetX := -1;
                    Result := True;
                  end;
                end;
              end;
            end;//case
          end else begin
            nPower:= GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))+1);
            if m_TargetCret.m_btLifeAttrib = LA_UNDEAD then nPower := Round(nPower * 1.5);//如果为不死系
            SendDelayMsg(self, RM_DELAYMAGIC, nPower, MakeLong(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY), 2, Integer(m_TargetCret), '', 600);
            //发消息给客户端，显示效果
            SendRefMsg(RM_LIGHTING, 1, m_nCurrX, m_nCurrY, Integer(m_TargetCret), '');
            m_nTargetX := -1;
            Result := True;
          end;
        end;
      end;
      if (m_TargetCret.m_PEnvir <> m_PEnvir) or (abs(m_nCurrX - m_TargetCret.m_nCurrX) > 11) or
        (abs(m_nCurrX - m_TargetCret.m_nCurrX) > 11) then begin
        DelTargetCreat();
      end;
    end;
  end;
end;

procedure TFoxBeads.Run;
var
  I: Integer;
  nAbs: Integer;
  nRage: Integer;
  BaseObject: TBaseObject;
  TargeTBaseObject: TBaseObject;
begin
  nRage := 9999;
  TargeTBaseObject := nil;
  if not m_boDeath and not m_boGhost and (m_wStatusTimeArr[POISON_STONE ] = 0)
    and (m_wStatusTimeArr[POISON_LOCKSPELL{7}] = 0) and (m_wStatusArrValue[23] = 0) then begin
    if (GetTickCount - m_dwSearchEnemyTick) >= 5000 then begin//5秒取最近的攻击目标
      m_dwSearchEnemyTick := GetTickCount();
      if m_VisibleActors.Count > 0 then begin
        for I := 0 to m_VisibleActors.Count - 1 do begin
          BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
          if BaseObject.m_boDeath then Continue;
          if IsProperTarget(BaseObject) then begin
            if not BaseObject.m_boHideMode or m_boCoolEye then begin
              nAbs := abs(m_nCurrX - BaseObject.m_nCurrX) + abs(m_nCurrY - BaseObject.m_nCurrY);
              if nAbs < nRage then begin
                nRage := nAbs;
                TargeTBaseObject := BaseObject;
              end;
            end;
          end;
        end;//for
      end;
      if TargeTBaseObject <> nil then SetTargetCreat(TargeTBaseObject);
    end;
    if Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed then begin
      if not m_boNoAttackMode then begin
        if m_TargetCret <> nil then AttackTarget;
      end;
    end;
  end;
  inherited;
end;

{ TWhiteTigerMonster 白虎王,近攻1格群体掉血,长攻，同方向3格掉血}

constructor TWhiteTigerMonster.Create;
begin
  inherited;
end;

destructor TWhiteTigerMonster.Destroy;
begin
  inherited;
end;

function TWhiteTigerMonster.AttackTarget(): Boolean;
  function SwordWideAttack(TargetCret: TBaseObject;nSecPwr: Integer): Boolean;
  var
    n10: Integer;
    BaseObject: TBaseObject;
    BaseObjectList: TList;    
  begin
    Result := False;
    BaseObjectList := TList.Create;
    Try
      m_PEnvir.GetMapBaseObjects(TargetCret.m_nCurrX, TargetCret.m_nCurrY, 1, BaseObjectList);
      if BaseObjectList.Count > 0 then begin
        for n10 := 0 to BaseObjectList.Count - 1 do begin
          BaseObject := TBaseObject(BaseObjectList.Items[n10]);
          if BaseObject <> nil then begin
            if IsProperTarget(BaseObject) then begin
              HitMagAttackTarget(BaseObject, nSecPwr, nSecPwr, True); //SM_HIT 普通攻击
              Result := True;
            end;          
          end;
        end;
      end;
    Finally
      BaseObjectList.Free;
    end;
  end;
var
  nPower, I: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
begin
  Result := False;
  if m_TargetCret = nil then Exit;
  if GetTickCount - m_dwHitTick > m_nNextHitTime then begin
    m_dwHitTick := GetTickCount();
    if not m_TargetCret.m_boDeath then begin
      if ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 1) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 0)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 1) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 1)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 2) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 2)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 2) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 0)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 3) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 3)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 3) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 0)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 0) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 1)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 0) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 2)) or
         ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 0) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 3)) then begin
        m_dwTargetFocusTick := GetTickCount();
        nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
        //物理攻击 近身1格
        if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 1) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 1) then begin
          if SwordWideAttack(m_TargetCret, nPower div 2) then begin//SM_HIT 普通攻击
            Result := True;
            Exit;
          end;
        end;
        if (Random(10) >= m_TargetCret.m_nAntiMagic) then begin//同方向3格目标掉血
          BaseObjectList := TList.Create;
          try
            m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
            GetDirectionBaseObjects(m_btDirection, 3, BaseObjectList);//同个方向的目标3格
            if BaseObjectList.Count > 0 then begin
              //发消息给客户端，显示效果
              SendRefMsg(RM_LIGHTING, 1, m_nCurrX, m_nCurrY, Integer(m_TargetCret), '');
              for I := 0 to BaseObjectList.Count - 1 do begin
                TargeTBaseObject := TBaseObject(BaseObjectList.Items[I]);
                if TargeTBaseObject <> nil then begin
                  if IsProperTarget(TargeTBaseObject) then begin
                    if 10 >= Random(TargeTBaseObject.m_nAntiMagic + 10) then begin
                      TargeTBaseObject.SendDelayMsg(self, RM_MAGSTRUCK, 0, nPower, 0, 0, '', 300);
                    end;
                  end;
                end;
              end;//for
              Result := True;
              Exit;
            end;
          finally
            BaseObjectList.Free;
          end; 
        end;
      end;
      if m_TargetCret.m_PEnvir = m_PEnvir then begin
        if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 11) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 11) then begin
          SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
        end;
      end else begin
        DelTargetCreat();
      end;
    end;
  end;
end;

end.

