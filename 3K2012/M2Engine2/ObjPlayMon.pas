{人形怪物 分身}

unit ObjPlayMon;

interface
uses
  Windows, SysUtils, Classes, Grobal2, ObjBase, IniFiles, ObjHero;
type
  TPlayMonster = class(TBaseObject)
    m_dwThinkTick: LongWord;
    m_boDupMode: Boolean; //人物重叠了
    m_nTargetX: Integer;
    m_nTargetY: Integer;
    m_boRunAwayMode: Boolean;
    m_dwRunAwayStart: LongWord;
    m_dwRunAwayTime: LongWord;                     
    m_boCanPickUpItem: Boolean;
    //m_boSlavePickUpItem: Boolean;//20080428 注释
    m_dwPickUpItemTick: LongWord;
    //m_boPickUpItemOK: Boolean;//20080428 注释
    //m_nPickUpItemMakeIndex: Integer;//20080428 注释
    m_wHitMode: Word;
    m_dwAutoAvoidTick: LongWord; //自动躲避间隔
    m_boAutoAvoid: Boolean; //是否躲避
    m_boDoSpellMagic: Boolean; //是否可以使用魔法
    m_dwDoSpellMagicTick: LongWord; //使用魔法间隔
    m_boGotoTargetXY: Boolean; //是否走向目标
    m_SkillShieldTick: LongWord; //魔法盾使用间隔
    m_SkillBigHealling: LongWord; //群体治疗术使用间隔
    m_SkillDejiwonho: LongWord; //神圣战甲术使用间隔
    m_dwCheckDoSpellMagic: LongWord;
    m_nDieDropUseItemRate: Integer; //死亡掉装备几率

    m_boDropUseItem: Boolean;//是否掉装备 20080120
    //m_nButchUserItemRate: Integer;//被挖取时可以挖到身上装备的几率 20080523
    m_boButchUseItem: Boolean;//是否允许挖取身上装备 20080120
    m_nButchRate: Integer;//挖取身上装备机率 20080120
    m_nButchChargeClass: Byte;//挖取身上装备收费模式(0金币，1元宝，2金刚石，3灵符)  20080120
    m_nButchChargeCount: Integer;//挖取身上装备每次收费点数 20080120
    m_nButchItemTime: LongWord;//挖物品间隔时间 20080121
    m_ButchItemList: TList;//人形怪挖物品列表 20080523
    boIntoTrigger: Boolean;//人形怪挖是否进入触发 20080716
    boIsDieEvent: Boolean;//清理人形尸体,是否显示升天龙效果(人物升级效果) 20080914
    m_dwActionTick: LongWord;//动作间隔 20080715
    {$IF M2Version <> 2}
    m_Magic99Skill: pTUserMagic;//强身术
    m_Magic100Skill: pTUserMagic;//神秘解读
    {$IFEND}
    wSkill_01: Word; //雷电术
    wSkill_02: Word; //地狱雷光
    wSkill_03: Word; //冰咆哮
    wSkill_04: Word; //火龙焰
    wSkill_05: Word; //魔法盾
    wSkill_15: Word; //抗拒火环
    wSKILL_36: Word;//火焰冰
    wSKILL_45: Word;//灭天火
    wSKILL_58: Word;//流星火雨
    wSkill_66: Word; //四级魔法盾
    wSKILL_91: Word;//四级雷电术
    wSKILL_92: Word;//四级流星火雨
    wSkill_22: Word;//火墙
    wSkill_23: Word;//爆裂火焰
    wSkill_1: Word;//火球术
    wSkill_5: Word;//大火球
    wSkill_9: Word;//地狱火
    wSkill_10: Word;//疾光电影
    wSKILL_97: Word;//血魄一击(法)

    wSkill_06: Word; //施毒术
    wSKILL_93: Word;//四级噬血术
    wSkill_07: Word; //灵魂火符
    wSKILL_59: Word;//噬血术 20080528
    wSKILL_94: Word;//四级噬血术
    wSkill_14: Word; //幽灵盾 20080405
    wSkill_73: Word; //道力盾 20080405
    wSkill_50: Word; //无极真气 20080405
    wSkill_08: Word; //神圣战甲术
    wSkill_09: Word; //群体治疗术
    wSkill_38: Word; //群体施毒术
    wSkill_48: Word;//气功波 20090111
    wSkill_51: Word;//飓风破 20080917
    wSKILL_98: Word;//血魄一击(道)

    wSkill_11: Word;//烈火剑法
    wSkill_12: Word;//刺杀剑法
    wSKILL_89: Word;//四级刺杀剑术
    wSkill_13: Word;//半月弯刀
    wSKILL_90: Word;//圆月弯刀(四级半月弯刀)
    wSkill_27: Word;//野蛮冲撞 20081016
    wSKILL_40: Word;//抱月刀法 20080410
    wSKILL_42: Word;//开天斩 20080405
    wSKILL_43: Word;//龙影剑法 20080405
    wSKILL_74: Word;//逐日剑法 20080528
    wSKILL_96: Word;//血魄一击(战)

    wSKILL_69: Word;//倚天辟地
    m_dwLatest69Tick: LongWord; //倚天辟地间隔
    m_nSkill_5Tick: LongWord;//无极真气使用间隔 20080605
    m_nSkill_48Tick: LongWord;//气功波使用间隔 20090111
    m_nSkill_8Tick: LongWord;//抗拒火环使用间隔 20090207
    m_nSkill_22Tick: LongWord;//火墙使用间隔
    m_dwCheckItmeDayTick: LongWord;//定时检测限时物品

    dwRockAddHPTick: LongWord;//魔血石类HP 使用间隔 20080728
    dwRockAddMPTick: LongWord;//魔血石类MP 使用间隔 20080728
    m_dwDoMotaeboTick: LongWord;//野蛮冲撞间隔 20081016

    m_nSelectMagic: Integer;//魔法 20081206
    m_boProtectStatus: Boolean;//守护模式 20090103
    m_nProtectTargetX, m_nProtectTargetY: Integer;//守护坐标 20090103
    m_boProtectOK: Boolean;//到达守护坐标 20090107
    m_nGotoProtectXYCount: Integer;//是向守护坐标的累计数 20090203
    TargetList: TStringList;
  private
    function Think: Boolean;
    function GetSpellPoint(UserMagic: pTUserMagic): Integer;
    function AllowFireHitSkill(): Boolean; {烈火}
    function AllowDailySkill(): Boolean;//逐日剑法 20080511
    function DoSpellMagic(wMagIdx: Word): Boolean;
    procedure SearchPickUpItem(dwSearchTime: LongWord);
    procedure EatMedicine();

    function WarrAttackTarget(wHitMode: Word): Boolean; {物理攻击}
    function WarrorAttackTarget(): Boolean; {战士攻击}
    function WizardAttackTarget(): Boolean; {法师攻击}
    function TaoistAttackTarget(): Boolean; {道士攻击}

    function EatUseItems(btItemType: Byte): Boolean; {自动吃药}
    function AutoAvoid(): Boolean; //自动躲避

    function SearchPickUpItemOK(): Boolean;//检查是否可以检起的物品
    function IsPickUpItem(StdItem: pTStdItem): Boolean;
    //function WalkToTargetXY(nTargetX, nTargetY: Integer): Boolean;
    //function WalkToTargetXY2(nTargetX, nTargetY: Integer): Boolean; //转向

    //function CheckSlaveTarget(TargetObject: TBaseObject): Boolean; //检测是否是其他宝宝的目标 //20080522 注释
    //function CheckSlavePickUpItem(): Boolean; //检测其他宝宝是不是正在拣物品 //20080428 注释
    function StartAutoAvoid(): Boolean;//自动躲避状态

    function IsNeedGotoXY(): Boolean;//是否走向目标 20080206

    function CheckUserMagic(wMagIdx: Word): Integer;//检查使用的魔法
    function CheckTargetXYCount(nX, nY, nRange: Integer): Integer;
    function CheckTargetXYCount3(nX, nY, nRange, nCount: Integer): Integer;//气功波，抗拒火环使用 20090302
    function AllowGotoTargetXY(): Boolean;
    //procedure GotoTargetXYRange();//20080522 注释
    function GetUserItemList(nItemType: Integer; nItemShape: Integer): Integer;
    function UseItem(nItemType, nIndex: Integer; nItemShape: Integer): Boolean;
    function CheckUserItemType(nItemType: Integer; nItemShape: Integer): Boolean;
    function CheckItemType(nItemType: Integer; StdItem: pTStdItem; nItemShape: Integer): Boolean;

    function CheckDoSpellMagic(): Boolean;

    //function CheckTakeOnItems(nWhere: Integer; var StdItem: TStdItem): Boolean;//20080522 注释
    function FindMagic(sMagicName: string): pTUserMagic;//查找魔法
    function CheckTargetXYCountOfDirection(nX, nY, nDir, nRange: Integer): Integer;

    function AbilityUp(UserMagic: pTUserMagic): Boolean; //无极真气  20080405
    function MagMakeFireDay(PlayObject: TBaseObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; var TargeTBaseObject: TBaseObject): Boolean; //灭天火 20080410
    function MabMabe(BaseObject, TargeTBaseObject: TBaseObject; nPower, nLevel, nTargetX, nTargetY: Integer): Boolean;//火焰冰 20080410
    procedure LoadButchItemList();//加载人形怪挖取列表 20080523
    procedure CheckItemsDay();//定时检测物品是否过期  20110521
    {$IF M2Version <> 2}
    procedure PlaySuperRock;//气血石功能 20080729
    {$IFEND}
    function DoMotaebo(nDir: Byte; nMagicLevel: Integer): Boolean;//人形进行野蛮冲撞 20081016
  public
    constructor Create(); override;
    destructor Destroy; override;
    function Operate(ProcessMsg: pTProcessMessage): Boolean; override;
    function AttackTarget(): Boolean;
    function AddItems(UserItem: pTUserItem; btWhere: Integer): Boolean; //获取身上装备
    procedure Run; override;
    procedure Die; override;
    procedure SearchTarget();
    procedure DelTargetCreat(); override;
    procedure SetTargetXY(nX, nY: Integer); virtual;
    procedure GotoTargetXY(nTargetX, nTargetY: Integer); virtual;
    procedure Wondering(); virtual;
    procedure Attack(TargeTBaseObject: TBaseObject; nDir: Integer); virtual;
    procedure Struck(hiter: TBaseObject); virtual;
    procedure AddItemsFromConfig();
    procedure InitializeMonster;//初始化怪物
  end;

implementation
uses UsrEngn, M2Share, Envir, Magic, HUtil32, Event;


{ TPlayMonster }

constructor TPlayMonster.Create;
begin
  inherited;
  m_boDupMode := False;
  m_dwLatest69Tick:= GetTickCount();//倚天辟地间隔
  m_nSkill_5Tick:= GetTickCount();//无极真气使用间隔 20080605
  m_nSkill_48Tick:= GetTickCount();//气功波使用间隔 20090111
  m_nSkill_8Tick:= GetTickCount();//抗拒火环使用间隔 20090207
  m_nSkill_22Tick:= GetTickCount();
  m_dwCheckItmeDayTick:= GetTickCount();//定时检测限时物品
  m_dwThinkTick := GetTickCount();
  m_nViewRange := 8;//20100614 修改
  m_nRunTime := 250;
  m_dwSearchTime := 3000 + Random(2000);//20090404 还原
  m_dwSearchTick := GetTickCount();
  m_btRaceServer := RC_PLAYMOSTER;
  m_nCopyHumanLevel := 2;
  m_nTargetX := -1;
  dwTick3F4 := GetTickCount();
  m_dwHitTick := GetTickCount - LongWord(Random(3000));
  m_dwWalkTick := GetTickCount - LongWord(Random(3000));
  m_nWalkSpeed := 500;
  m_nWalkStep := 10;
  m_dwWalkWait := 0;
  m_dwSearchEnemyTick := GetTickCount();
  m_boRunAwayMode := False;
  m_dwRunAwayStart := GetTickCount();
  m_dwRunAwayTime := 0;
  m_boCanPickUpItem := True;
  //m_boSlavePickUpItem := False;//20080428 注释
  m_dwPickUpItemTick := GetTickCount();
  //m_boPickUpItemOK := True;//20080428 注释
  m_dwAutoAvoidTick := GetTickCount(); //自动躲避间隔
  m_boAutoAvoid := False; //是否躲避 20080715
  m_boDoSpellMagic := True; //是否使用魔法
  m_boGotoTargetXY := True; //是否走向目标
  m_nNextHitTime := 300;
  m_dwDoSpellMagicTick := GetTickCount(); //使用魔法间隔
  m_SkillShieldTick := GetTickCount(); //魔法盾使用魔法间隔
  m_SkillBigHealling := GetTickCount(); //群体治疗术使用间隔
  m_SkillDejiwonho := GetTickCount(); //神圣战甲术使用间隔
  m_dwCheckDoSpellMagic := GetTickCount();
  m_nDieDropUseItemRate := 100;
  m_nButchItemTime := GetTickCount();//挖物品间隔时间 20080816
  m_ButchItemList := TList.Create;//人形怪挖物品列表 20080523
  m_dwDoMotaeboTick := GetTickCount();//野蛮冲撞使用间隔 20081016
  m_boProtectStatus:= False;//守护模式 20090103
  m_boProtectOK:= True;//到达守护坐标 20090107
  m_nGotoProtectXYCount:= 0;//是向守护坐标的累计数 2009020
  TargetList:= nil;
  {$IF M2Version <> 2}
  m_Magic99Skill:= nil; //强身术 20100817
  m_Magic100Skill:= nil;//神秘解读
  {$IFEND}
end;

destructor TPlayMonster.Destroy;
var
  I: Integer;
begin
  if m_ButchItemList.Count > 0 then begin//20080630
    for I := 0 to m_ButchItemList.Count - 1 do begin//人形怪挖物品列表 20080523
      if pTMonItemInfo(m_ButchItemList.Items[I]) <> nil then
         Dispose(pTMonItemInfo(m_ButchItemList.Items[I]));
    end;
  end;
  FreeAndNil(m_ButchItemList);
  if TargetList <> nil then TargetList.Free; 
  inherited;
end;

procedure TPlayMonster.InitializeMonster;
begin
  AddItemsFromConfig();
  case m_btJob of
    0: begin
        wSkill_11 := CheckUserMagic(SKILL_FIRESWORD); //烈火剑法
        wSKILL_89 := CheckUserMagic(SKILL_89);//四级刺杀剑术
        if wSKILL_89 = 0 then wSkill_12 := CheckUserMagic(SKILL_ERGUM);//刺杀剑法
        wSKILL_90 := CheckUserMagic(SKILL_90);//圆月弯刀(四级半月弯刀)
        if wSKILL_90 = 0 then wSkill_13 := CheckUserMagic(SKILL_BANWOL);//半月弯刀
        wSkill_27 := CheckUserMagic(SKILL_MOOTEBO);//野蛮冲撞 20081016
        wSKILL_40 := CheckUserMagic(SKILL_40);//抱月刀法 20080410
        wSKILL_42 := CheckUserMagic(SKILL_42); //开天斩 20080405
        wSKILL_43 := CheckUserMagic(SKILL_43); //龙影剑法 20080405
        wSKILL_74 := CheckUserMagic(SKILL_74);//逐日剑法 20080528
        wSKILL_96 := CheckUserMagic(SKILL_96);//血魄一击(战)
      end;
    1: begin
        wSKILL_91 := CheckUserMagic(SKILL_91);//四级雷电术
        if wSKILL_91 = 0 then wSkill_01 := CheckUserMagic(SKILL_LIGHTENING); //雷电术
        wSkill_02 := CheckUserMagic(SKILL_LIGHTFLOWER); //地狱雷光
        wSkill_03 := CheckUserMagic(SKILL_SNOWWIND); //冰咆哮
        wSkill_04 := CheckUserMagic(SKILL_47); //火龙焰
        wSkill_66:= CheckUserMagic(SKILL_66); //四级魔法盾
        if wSkill_66 = 0 then wSkill_05 := CheckUserMagic(SKILL_SHIELD); //魔法盾
        wSkill_15 := CheckUserMagic(SKILL_FIREWIND);//抗拒火环
        wSKILL_92 := CheckUserMagic(SKILL_92);//四级流星火雨
        if wSKILL_92 = 0 then wSKILL_58 := CheckUserMagic(SKILL_58);//流星火雨
        wSKILL_36 := CheckUserMagic(SKILL_MABE);//火焰冰
        wSKILL_45 := CheckUserMagic(SKILL_45);//灭天火
        wSkill_22 := CheckUserMagic(SKILL_EARTHFIRE);//火墙
        wSkill_23 := CheckUserMagic(SKILL_FIREBOOM);//爆裂火焰
        wSkill_1 := CheckUserMagic(SKILL_FIREBALL);//火球术
        wSkill_5 := CheckUserMagic(SKILL_FIREBALL2);//大火球
        wSkill_9 := CheckUserMagic(SKILL_FIRE);//地狱火
        wSkill_10 := CheckUserMagic(SKILL_SHOOTLIGHTEN);//疾光电影
        wSKILL_97:= CheckUserMagic(SKILL_97);//血魄一击(法)
      end;
    2: begin
        wSKILL_93 := CheckUserMagic(SKILL_93);//四级噬血术
        if wSKILL_93 = 0 then wSkill_06 := CheckUserMagic(SKILL_AMYOUNSUL); //施毒术
        wSkill_07 := CheckUserMagic(SKILL_FIRECHARM); //灵魂火符
        wSKILL_94 := CheckUserMagic(SKILL_94);//四级噬血术
        if wSKILL_94 = 0 then wSKILL_59 := CheckUserMagic(SKILL_59);//噬血术
        wSkill_14 := CheckUserMagic(SKILL_HANGMAJINBUB); //幽灵盾 20080405
        wSkill_73 := CheckUserMagic(SKILL_73); //道力盾 20080405
        wSkill_50 := CheckUserMagic(SKILL_50); //无极真气 20080405
        wSkill_08 := CheckUserMagic(SKILL_DEJIWONHO); //神圣战甲术
        wSkill_09 := CheckUserMagic(SKILL_BIGHEALLING); //群体治疗术
        wSkill_38 := CheckUserMagic(SKILL_GROUPAMYOUNSUL); //群体施毒术
        wSkill_48 := CheckUserMagic(SKILL_48);//气功波 20090111
        wSkill_51 := CheckUserMagic(SKILL_51); //飓风破 20080917
        wSKILL_98:= CheckUserMagic(SKILL_98);//血魄一击(道)
      end;
  end;
  wSKILL_69 := CheckUserMagic(SKILL_69);//倚天辟地
end;

procedure TPlayMonster.GotoTargetXY(nTargetX, nTargetY: Integer);
var
  I: Integer;
  nDir: Integer;
  n10: Integer;
  n14: Integer;
  n20: Integer;
  nOldX: Integer;
  nOldY: Integer;
begin
  if ((m_nCurrX <> nTargetX) or (m_nCurrY <> nTargetY)) then begin
    n10 := nTargetX;
    n14 := nTargetY;
    dwTick3F4 := GetTickCount();
    nDir := DR_DOWN;
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
    end;
    nOldX := m_nCurrX;
    nOldY := m_nCurrY;
    if (abs(m_nCurrX - nTargetX) >= 3) or (abs(m_nCurrY - nTargetY) >= 3) then begin
      if not RunTo1(nDir, False, nTargetX, nTargetY) then begin//20090525 修改，RunTo1
        WalkTo(nDir, False);
        n20 := Random(3);
        for I := DR_UP to DR_UPLEFT do begin
          if (nOldX = m_nCurrX) and (nOldY = m_nCurrY) then begin
            if n20 <> 0 then Inc(nDir)
            else if nDir > 0 then Dec(nDir)
            else nDir := DR_UPLEFT;
            if (nDir > DR_UPLEFT) then nDir := DR_UP;
            WalkTo(nDir, False);
          end;
        end;
      end;
    end else begin
      WalkTo(nDir, False);
      n20 := Random(3);
      for I := DR_UP to DR_UPLEFT do begin
        if (nOldX = m_nCurrX) and (nOldY = m_nCurrY) then begin
          if n20 <> 0 then Inc(nDir)
          else if nDir > 0 then Dec(nDir)
          else nDir := DR_UPLEFT;
          if (nDir > DR_UPLEFT) then nDir := DR_UP;
          WalkTo(nDir, False);
        end;
      end;
    end;
  end;
end;
{//转向
function TPlayMonster.WalkToTargetXY2(nTargetX, nTargetY: Integer): Boolean;
var
  I: Integer;
  nDir: Integer;
  n10: Integer;
  n14: Integer;
  n20: Integer;
  nOldX: Integer;
  nOldY: Integer;
 // n16: Integer;
begin
  Result := False;
  if (nTargetX <> m_nCurrX) or (nTargetY <> m_nCurrY) then begin
    n10 := nTargetX;
    n14 := nTargetY;
    dwTick3F4 := GetTickCount();
    nDir := DR_DOWN;
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
    end;
    nOldX := m_nCurrX;
    nOldY := m_nCurrY;
    WalkTo(nDir, False);
    if (nTargetX = m_nCurrX) and (nTargetY = m_nCurrY) then Result := True;
    if not Result then begin
      n20 := Random(3);
      for I := DR_UP to DR_UPLEFT do begin
        if (nOldX = m_nCurrX) and (nOldY = m_nCurrY) then begin
          if n20 <> 0 then Inc(nDir)
          else if nDir > 0 then Dec(nDir)
          else nDir := DR_UPLEFT;
          if (nDir > DR_UPLEFT) then nDir := DR_UP;
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

function TPlayMonster.WalkToTargetXY(nTargetX, nTargetY: Integer): Boolean;
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
  if ((m_nCurrX <> nTargetX) or (m_nCurrY <> nTargetY)) then begin
    n10 := nTargetX;
    n14 := nTargetY;
    dwTick3F4 := GetTickCount();
    nDir := DR_DOWN;
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
    end;
    nOldX := m_nCurrX;
    nOldY := m_nCurrY;
    WalkTo(nDir, False);
    if (nTargetX = m_nCurrX) and (nTargetY = m_nCurrY) then Result := True;
    if not Result then begin
      n20 := Random(3);
      for I := DR_UP to DR_UPLEFT do begin
        if (nOldX = m_nCurrX) and (nOldY = m_nCurrY) then begin
          if n20 <> 0 then Inc(nDir)
          else if nDir > 0 then Dec(nDir)
          else nDir := DR_UPLEFT;
          if (nDir > DR_UPLEFT) then nDir := DR_UP;
          WalkTo(nDir, False);
          if (nTargetX = m_nCurrX) and (nTargetY = m_nCurrY) then begin
            Result := True;
            Break;
          end;
        end;
      end;
    end;
  end;
end;  }

function TPlayMonster.Operate(ProcessMsg: pTProcessMessage): Boolean;
begin
  Result:=False;//20080206 去掉注释
  try
    if ProcessMsg.wIdent = RM_STRUCK then begin
      if (ProcessMsg.BaseObject = Self) and (TBaseObject(ProcessMsg.nParam3 {AttackBaseObject}) <> nil) then begin
        if not TBaseObject(ProcessMsg.nParam3).m_boDeath then begin//20090502 增加
          SetLastHiter(TBaseObject(ProcessMsg.nParam3 {AttackBaseObject}));
          Struck(TBaseObject(ProcessMsg.nParam3 {AttackBaseObject})); {0FFEC}
          BreakHolySeizeMode();
          {if (m_Master <> nil) and//20080928 注释
            (TBaseObject(ProcessMsg.nParam3) <> m_Master) and
            (TBaseObject(ProcessMsg.nParam3).m_btRaceServer = RC_PLAYOBJECT) then begin
            m_Master.SetPKFlag(TBaseObject(ProcessMsg.nParam3));
          end; }
          //20080928 修改,主体打自己分身不变色,打英雄分身也不变色
          if (m_Master <> nil) then begin
            if (TBaseObject(ProcessMsg.nParam3) <> m_Master) and
               ((TBaseObject(ProcessMsg.nParam3).m_btRaceServer = RC_PLAYOBJECT) or
               (TBaseObject(ProcessMsg.nParam3).m_btRaceServer = RC_HEROOBJECT)) then begin
               if m_Master.m_btRaceServer = RC_PLAYOBJECT then m_Master.SetPKFlag(TBaseObject(ProcessMsg.nParam3));
               if m_Master.m_btRaceServer = RC_HEROOBJECT then begin
                 if (m_Master.m_Master <> nil) then begin
                   if TBaseObject(ProcessMsg.nParam3) <> m_Master.m_Master then m_Master.SetPKFlag(TBaseObject(ProcessMsg.nParam3));
                 end else m_Master.SetPKFlag(TBaseObject(ProcessMsg.nParam3));
               end;
            end;
          end;
          if g_Config.boMonSayMsg then MonsterSayMsg(TBaseObject(ProcessMsg.nParam3), s_UnderFire);
        end;
      end;
      Result := True;
    end else begin
      Result := inherited Operate(ProcessMsg);
    end;
  except
    MainOutMessage(Format('{%s} TPlayMonster.Operate', [g_sExceptionVer]));
  end;
end;

procedure TPlayMonster.Struck(hiter: TBaseObject);
var
  btDir: Byte;
begin
  m_dwStruckTick := GetTickCount;
  if hiter <> nil then begin
    if (m_TargetCret = nil) or GetAttackDir(m_TargetCret, btDir) or (Random(6) = 0) then begin
      if IsProperTarget(hiter) then
        SetTargetCreat(hiter);
    end;
  end;
  if m_boAnimal then begin
    m_nMeatQuality := m_nMeatQuality - Random(300);
    if m_nMeatQuality < 0 then m_nMeatQuality := 0;
  end;
  //if m_Abil.Level < 50 then
  m_dwHitTick := m_dwHitTick + LongWord(150 - _MIN(130, m_Abil.Level * 4));
  //WalkTime := WalkTime + (300 - _MIN(200, (Abil.Level div 5) * 20));
end;

procedure TPlayMonster.Attack(TargeTBaseObject: TBaseObject; nDir: Integer);
begin
  inherited AttackDir(TargeTBaseObject, m_wHitMode, nDir, 0);
end;

procedure TPlayMonster.DelTargetCreat;
begin
  inherited;
  m_nTargetX := -1;
  m_nTargetY := -1;
end;
{//检查下属目标  //20080522 注释
function TPlayMonster.CheckSlaveTarget(TargetObject: TBaseObject): Boolean;
var
  I: Integer;
begin
  Result := False;
  if m_Master <> nil then begin
    for I := 0 to m_Master.m_SlaveList.Count - 1 do begin
      if TBaseObject(m_Master.m_SlaveList.Items[I]).m_TargetCret = TargetObject then begin
        Result := True;
        Break;
      end;
    end;
  end;
end; }
{ //20080428 注释
function TPlayMonster.CheckSlavePickUpItem(): Boolean;
var
  I: Integer;
begin
  Result := False;
  if m_Master <> nil then begin
    for I := 0 to m_Master.m_SlaveList.Count - 1 do begin
      if TPlayMonster(m_Master.m_SlaveList.Items[I]).m_boSlavePickUpItem then begin
        Result := True;
        Break;
      end;
    end;
  end;
end; }

procedure TPlayMonster.SearchTarget;
var
  BaseObject, BaseObject18: TBaseObject;
  I, nC, n10: Integer;
  nCode: Byte;//20090510 增加
begin
  nCode:= 0;
  try
    if m_boProtectStatus then begin //守护状态 20090104
      if (abs(m_nCurrX - m_nProtectTargetX) > 12) or (abs(m_nCurrY - m_nProtectTargetY) > 12) or (not m_boProtectOK) then begin//20090107 增加，没有跑到守护点不查找目标
        Exit;
      end;
    end;
    BaseObject18 := nil;
    n10 := 12;//20090107 人形怪的探索范围
    nCode:= 1;
    if m_VisibleActors.Count > 0 then begin//20080630
      nCode:= 2;
      for I := 0 to m_VisibleActors.Count - 1 do begin
        nCode:= 3;
        BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
        if BaseObject <> nil then begin
          nCode:= 4;
          if not BaseObject.m_boDeath then begin
            //目标为英雄,且等级不超过22级,跟随状态,则不攻击英雄 20080421
            if (BaseObject.m_btRaceServer = RC_HEROOBJECT) and (BaseObject.m_Abil.Level <= 22) then begin//20090510 修改
              if (THEROOBJECT(BaseObject).m_btStatus = 1) then Continue;
            end;
            nCode:= 5;
            if IsProperTarget(BaseObject) and (not BaseObject.m_boHideMode or m_boCoolEye) then begin
              nCode:= 6;
              nC := abs(m_nCurrX - BaseObject.m_nCurrX) + abs(m_nCurrY - BaseObject.m_nCurrY);
              if nC <= n10 then begin
                n10 := nC;
                if m_boProtectStatus then begin //守护状态 20090105
                  if (abs(BaseObject.m_nCurrX - m_nProtectTargetX) <= 13) or (abs(BaseObject.m_nCurrY - m_nProtectTargetY) <= 13) then begin
                    BaseObject18 := BaseObject;
                  end;
                end else begin
                  BaseObject18 := BaseObject;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
    nCode:= 7;
    if BaseObject18 <> nil then begin
      if m_boProtectStatus then begin //守护状态 20090104
        nCode:= 8;
        if (abs(BaseObject18.m_nCurrX - m_nProtectTargetX) > 11) or (abs(BaseObject18.m_nCurrY - m_nProtectTargetY) > 11) then begin
          GotoTargetXY(m_nProtectTargetX, m_nProtectTargetY);
          Exit;
        end;
      end;
      nCode:= 9;
      SetTargetCreat(BaseObject18);
    end;
  except
    MainOutMessage(Format('{%s} TPlayMonster.SearchTarget Code:%d', [g_sExceptionVer, nCode]));
  end;
end;

procedure TPlayMonster.SetTargetXY(nX, nY: Integer);
begin
  m_nTargetX := nX;
  m_nTargetY := nY;
end;

procedure TPlayMonster.Wondering;
begin
  if (Random(20) = 0) then 
    if (Random(4) = 1) then TurnTo(Random(8))
    else WalkTo(m_btDirection, False);
end;
//检查攻击的魔法
function TPlayMonster.CheckDoSpellMagic(): Boolean;
var nCode: Byte;
begin
  Result := True;
  nCode:= 0;
  try
    if (m_btJob > 0) and (m_Master = nil) then begin//20090502 增加
      {if m_btJob = 1 then begin//20091012 注释
        if (wSkill_01 = 0) and (wSkill_02 = 0) and (wSkill_03 = 0) and (wSkill_04 = 0) then begin
          Result := False;
          Exit;
        end;
      end;
      if m_btJob = 2 then begin
        if (wSkill_06 = 0) and (wSkill_07 = 0) and (wSkill_10 = 0) then begin
          Result := False;
          Exit;
        end;
      end;}
      if m_WAbil.MP = 0 then begin
        Result := False;
        Exit;
      end;
      if m_btJob = 2 then begin
        nCode:= 1;
        if (wSkill_06 > 0) or (wSkill_93 > 0) or (wSkill_38 > 0) then begin//施毒术
          nCode:= 2;
          if ((GetUserItemList(2,1) >= 0) or CheckUserItemType(2,1)) then begin  {绿毒}
            nCode:= 3;
            Result := CheckUserItemType(2,1);
            if Result then Exit;
            nCode:= 4;
            if GetUserItemList(2,1) < 0 then Result := False else Result := True;
            if Result then Exit;
          end;
          nCode:= 5;
          if ((GetUserItemList(2,2) >= 0) or CheckUserItemType(2,2)) then begin {红毒}
            nCode:= 6;
            Result := CheckUserItemType(2,2);
            if Result then Exit;
            nCode:= 7;
            if GetUserItemList(2,2) < 0 then Result := False else Result := True;
            if Result then Exit;
          end;
        end;
        if (wSkill_07 > 0) or (wSkill_59 > 0) or (wSkill_94 > 0) then begin //灵魂火符 噬血术 四级噬血术
          nCode:= 8;
          Result := CheckUserItemType(1,0);
          if Result then Exit;
          nCode:= 9;
          if GetUserItemList(1,0) < 0 then Result := False else Result := True;
        end;
      end;
    end;
  except
    on E: Exception do begin
      MainOutMessage(Format('{%s} TPlayMonster.CheckDoSpellMagic Code:%d', [g_sExceptionVer, nCode]));
    end;
  end;
end;

function TPlayMonster.Think(): Boolean;
var
  nOldX, nOldY: Integer;
  nCode: Byte;
begin
  Result := False;
  nCode:= 0;
  try
    if (m_Master <> nil) then begin
      if (m_Master.m_nCurrX = m_nCurrX) and (m_Master.m_nCurrY = m_nCurrY) then m_boDupMode := True;
    end else
    if (GetTickCount - m_dwThinkTick) > 3000{3 * 1000} then begin
      m_dwThinkTick := GetTickCount();
      nCode:= 1;
      if m_PEnvir.GetXYObjCount(m_nCurrX, m_nCurrY) >= 2 then m_boDupMode := True;
      if m_TargetCret <> nil then begin
        if not IsProperTarget(m_TargetCret) then m_TargetCret := nil;
      end;
    end;
    nCode:= 8;
    if (m_Master <> nil) and (m_TargetCret <> nil) and (m_btJob = 1) and (wSkill_66 > 0) then begin//分身出来，直接使用魔法盾 20090512 增加
      if (m_wStatusTimeArr[STATE_BUBBLEDEFENCEUP ] = 0) and (not m_boAbilMagBubbleDefence) then begin//使用 魔法盾
        if not DoSpellMagic(wSkill_66) then SendRefMsg(RM_MAGICFIREFAIL, 0, 0, 0, 0, '');
      end;
    end;  
    nCode:= 2;
    if SearchPickUpItemOK() then SearchPickUpItem(1000); //捡物品
    nCode:= 3;
    EatMedicine(); {吃药}
    nCode:= 4;
    if (GetTickCount - m_dwCheckDoSpellMagic) > 1000 then begin //检测是否可以使用魔法
      m_dwCheckDoSpellMagic := GetTickCount;
      m_boDoSpellMagic := CheckDoSpellMagic();
    end;
    nCode:= 5;
    if StartAutoAvoid and m_boDoSpellMagic then AutoAvoid(); {自动躲避}
    nCode:= 6;
    if m_boDupMode then begin
      nOldX := m_nCurrX;
      nOldY := m_nCurrY;
      nCode:= 7;
      WalkTo(Random(8), False);
      if (nOldX <> m_nCurrX) or (nOldY <> m_nCurrY) then begin
        m_boDupMode := False;
        Result := True;
      end;
    end;
  except
    on E: Exception do begin
      MainOutMessage(Format('{%s} TPlayMonster.Think Code:%d', [g_sExceptionVer, nCode]));
    end;
  end;
end;
//是否可以捡起物品
function TPlayMonster.SearchPickUpItemOK(): Boolean;
var
  VisibleMapItem: pTVisibleMapItem;
  MapItem: PTMapItem;
  I: Integer;
  //nCode: byte;//20090830
begin
  Result := False;
  //nCode:= 0;
  try                                                           //20090830 增加
    if (m_VisibleItems.Count = 0) or (m_nCopyHumanLevel = 0) or (g_AllowPickUpItemList.Count = 0) then Exit;
    if m_Master = nil then Exit;
    //nCode:= 1;
    if (m_Master <> nil) and (m_Master.m_boDeath) then Exit;
    //nCode:= 2;
    if m_TargetCret <> nil then begin
      if m_TargetCret.m_boDeath then begin
        m_TargetCret := nil;
        Result := True;
      end;
    end;
   // nCode:= 3;
    //if (m_Master.m_WAbil.Weight >= m_Master.m_WAbil.MaxWeight) and (m_WAbil.Weight >= m_WAbil.MaxWeight) then Exit;
    if m_TargetCret = nil then begin
      if m_VisibleItems.Count > 0 then begin//20080630
        //nCode:= 4;
        for I := 0 to m_VisibleItems.Count - 1 do begin
          //nCode:= 5;
          VisibleMapItem := pTVisibleMapItem(m_VisibleItems.Items[I]);
          if (VisibleMapItem <> nil) then begin
            //nCode:= 6;
            if (VisibleMapItem.nVisibleFlag > 0) then begin
              MapItem := VisibleMapItem.MapItem;
              //nCode:= 7;
              if (MapItem <> nil) then begin
                //nCode:= 8;
                if (MapItem.DropBaseObject <> m_Master) and (MapItem.UserItem.AddValue[0]<>2) and
                  (MapItem.UserItem.AddValue[0]<>3) then begin
                  //nCode:= 9;
                  if IsAllowPickUpItem(VisibleMapItem.sName) then begin
                    //nCode:= 10;
                    if (MapItem.OfBaseObject = nil) or (MapItem.OfBaseObject = m_Master) or (MapItem.OfBaseObject = Self) then begin
                      Result := True;
                      Break;
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;//for
      end;
    end;
    //nCode:= 11;
    if Result then begin
      if (m_ItemList.Count >= g_Config.nCopyHumanBagCount) then begin
        //nCode:= 12;
        if (not m_boCanPickUpItem) then Result := False;
        //nCode:= 13;
        if m_Master <> nil then begin
          if m_boCanPickUpItem and (not TPlayObject(m_Master).IsEnoughBag) then Result := True;
        end;
      end;
    end;
  except
    //MainOutMessage('{异常} TPlayMonster.SearchPickUpItemOK Code:'+inttostr(nCode));
  end;
end;
{//20080522
procedure TPlayMonster.GotoTargetXYRange();
var
  n10: Integer;
  n14: Integer;
  nTargetX: Integer;
  nTargetY: Integer;
begin
  nTargetX:= 0;//20080522
  nTargetY:= 0;//20080522
  if CheckTargetXYCount(m_nCurrX, m_nCurrY, 10) < 1 then begin
    n10 := abs(m_TargetCret.m_nCurrX - m_nCurrX);
    n14 := abs(m_TargetCret.m_nCurrY - m_nCurrY);
    if n10 > 4 then Dec(n10, 5) else n10 := 0;
    if n14 > 4 then Dec(n14, 5) else n14 := 0;
    if m_TargetCret.m_nCurrX > m_nCurrX then nTargetX := m_nCurrX + n10;
    if m_TargetCret.m_nCurrX < m_nCurrX then nTargetX := m_nCurrX - n10;
    if m_TargetCret.m_nCurrY > m_nCurrY then nTargetY := m_nCurrY + n14;
    if m_TargetCret.m_nCurrY < m_nCurrY then nTargetY := m_nCurrY - n14;
    GotoTargetXY(nTargetX, nTargetY);
  end;
end;    }

//------------------------------------------------------------------------------
//20080205 更换原自动躲避的代码,应用英雄单元里的自动躲避代码进行修改
function TPlayMonster.AutoAvoid(): Boolean; //自动躲避
  function GetAvoidDir(): Integer;
  var
    n10: Integer;
    n14: Integer;
  begin
    n10 := m_TargetCret.m_nCurrX;
    n14 := m_TargetCret.m_nCurrY;
    Result := DR_DOWN;
    if n10 > m_nCurrX then begin
      Result := DR_LEFT;
      if n14 > m_nCurrY then Result := DR_DOWNLEFT;
      if n14 < m_nCurrY then Result := DR_UPLEFT;
    end else begin
      if n10 < m_nCurrX then begin
        Result := DR_RIGHT;
        if n14 > m_nCurrY then Result := DR_DOWNRIGHT;
        if n14 < m_nCurrY then Result := DR_UPRIGHT;
      end else begin
        if n14 > m_nCurrY then Result := DR_UP
        else if n14 < m_nCurrY then Result := DR_DOWN;
      end;
    end;
  end;
  function GetDirXY(nTargetX, nTargetY: Integer): Byte;
  var
    n10: Integer;
    n14: Integer;
  begin
    n10 := nTargetX;
    n14 := nTargetY;
    Result := DR_DOWN;
    if n10 > m_nCurrX then begin
      Result := DR_RIGHT;
      if n14 > m_nCurrY then Result := DR_DOWNRIGHT;
      if n14 < m_nCurrY then Result := DR_UPRIGHT;
    end else begin
      if n10 < m_nCurrX then begin
        Result := DR_LEFT;
        if n14 > m_nCurrY then Result := DR_DOWNLEFT;
        if n14 < m_nCurrY then Result := DR_UPLEFT;
      end else begin
        if n14 > m_nCurrY then Result := DR_DOWN
        else if n14 < m_nCurrY then Result := DR_UP;
      end;
    end;
  end;
  function GetGotoXY(nDir: Integer; var nTargetX, nTargetY: Integer): Boolean;
  var
    n01: Integer;
  begin
    Result := False;
    n01 := 0;
    while True do begin
      case nDir of
        DR_UP: begin
            if m_PEnvir.CanWalk(nTargetX, nTargetY, False) and (CheckTargetXYCountOfDirection(nTargetX, nTargetY, nDir, 3) = 0) then begin //CheckTargetXYCountOfDirection
              //Inc(nTargetY, 2);
              Dec(nTargetY, 2);//20080524
              Result := True;
              Break;
            end else begin
              if n01 >= 8 then Break;
              //Inc(nTargetY, 2);
              Dec(nTargetY, 2);//20080524
              Inc(n01, 2);
              Continue;
            end;
          end;
        DR_UPRIGHT: begin
            if m_PEnvir.CanWalk(nTargetX, nTargetY, False) and (CheckTargetXYCountOfDirection(nTargetX, nTargetY, nDir, 3) = 0) then begin
             // Inc(nTargetX, 2);
             // Inc(nTargetY, 2);
              Inc(nTargetX, 2);//20080524
              Dec(nTargetY, 2);//20080524
              Result := True;
              Break;
            end else begin
              if n01 >= 8 then Break;
             // Inc(nTargetX, 2);
             // Inc(nTargetY, 2);
              Inc(nTargetX, 2);//20080524
              Dec(nTargetY, 2);//20080524
              Inc(n01, 2);
              Continue;
            end;
          end;
        DR_RIGHT: begin
            if m_PEnvir.CanWalk(nTargetX, nTargetY, False) and (CheckTargetXYCountOfDirection(nTargetX, nTargetY, nDir, 3) = 0) then begin
              Inc(nTargetX, 2);
              Result := True;
              Break;
            end else begin
              if n01 >= 8 then Break;
              Inc(nTargetX, 2);
              Inc(n01, 2);
              Continue;
            end;
          end;
        DR_DOWNRIGHT: begin
            if m_PEnvir.CanWalk(nTargetX, nTargetY, False) and (CheckTargetXYCountOfDirection(nTargetX, nTargetY, nDir, 3) = 0) then begin
              //Inc(nTargetX, 2);
              //Dec(nTargetY, 2);
              Inc(nTargetX, 2);//20080524
              Inc(nTargetY, 2);//20080524
              Result := True;
              Break;
            end else begin
              if n01 >= 8 then Break;
              //Inc(nTargetX, 2);
              //Dec(nTargetY, 2);
              Inc(nTargetX, 2);//20080524
              Inc(nTargetY, 2);//20080524
              Inc(n01, 2);
              Continue;
            end;
          end;
        DR_DOWN: begin
            if m_PEnvir.CanWalk(nTargetX, nTargetY, False) and (CheckTargetXYCountOfDirection(nTargetX, nTargetY, nDir, 3) = 0) then begin
              //Dec(nTargetY, 2);
              Inc(nTargetY, 2);//20080524
              Result := True;
              Break;
            end else begin
              if n01 >= 8 then Break;
              //Dec(nTargetY, 2);
              Inc(nTargetY, 2);//20080524
              Inc(n01, 2);
              Continue;
            end;
          end;
        DR_DOWNLEFT: begin
            if m_PEnvir.CanWalk(nTargetX, nTargetY, False) and (CheckTargetXYCountOfDirection(nTargetX, nTargetY, nDir, 3) = 0) then begin
              //Dec(nTargetX, 2);
              //Dec(nTargetY, 2);
              Dec(nTargetX, 2);//20080524
              Inc(nTargetY, 2);//20080524
              Result := True;
              Break;
            end else begin
              if n01 >= 8 then Break;
              //Dec(nTargetX, 2);
              //Dec(nTargetY, 2);
              Dec(nTargetX, 2);//20080524
              Inc(nTargetY, 2);//20080524
              Inc(n01, 2);
              Continue;
            end;
          end;
        DR_LEFT: begin
            if m_PEnvir.CanWalk(nTargetX, nTargetY, False) and (CheckTargetXYCountOfDirection(nTargetX, nTargetY, nDir, 3) = 0) then begin
              Dec(nTargetX, 2);
              Result := True;
              Break;
            end else begin
              if n01 >= 8 then Break;
              Dec(nTargetX, 2);
              Inc(n01, 2);
              Continue;
            end;
          end;
        DR_UPLEFT: begin
            if m_PEnvir.CanWalk(nTargetX, nTargetY, False) and (CheckTargetXYCountOfDirection(nTargetX, nTargetY, nDir, 3) = 0) then begin
              //Dec(nTargetX, 2);
              //Inc(nTargetY, 2);
              Dec(nTargetX, 2);//20080524
              Dec(nTargetY, 2);//20080524
              Result := True;
              Break;
            end else begin
              if n01 >= 8 then Break;
              //Dec(nTargetX, 2);
              //Inc(nTargetY, 2);
              Dec(nTargetX, 2);//20080524
              Dec(nTargetY, 2);//20080524
              Inc(n01, 2);
              Continue;
            end;
          end;
      else begin
          Break;
        end;
      end;
    end;
  end;
  function GetAvoidXY(var nTargetX, nTargetY: Integer): Boolean;
  var
    n10, nDir: Integer;
    nX, nY: Integer;
  begin
    nX := nTargetX;
    nY := nTargetY;
    nDir:= 0;//20080522
    Result := GetGotoXY(m_btDirection, nTargetX, nTargetY);
    n10 := 0;
    while True do begin
      if n10 >= 7 then Break;
      if Result then Break;
      nTargetX := nX;
      nTargetY := nY;
      nDir := Random(7);
      Result := GetGotoXY(nDir, nTargetX, nTargetY);
      Inc(n10);
    end;
    m_btDirection := nDir; //m_btDirection;
  end;
  function GotoMasterXY(var nTargetX, nTargetY: Integer): Boolean;
  var
    nDir: Integer;
  begin
    Result := False;
    if (m_Master <> nil) and ((abs(m_Master.m_nCurrX - m_nCurrX) >= 5) or (abs(m_Master.m_nCurrY - m_nCurrY) >= 5))  then begin
      nTargetX := m_nCurrX;
      nTargetY := m_nCurrY;
      //nTargetX := m_Master.m_nCurrX;//20080215
      //nTargetY := m_Master.m_nCurrY;//20080215      
      nDir := GetDirXY(m_Master.m_nCurrX, m_Master.m_nCurrY);
      m_btDirection := nDir;
      case nDir of
        DR_UP: begin
            Result := GetGotoXY(nDir, nTargetX, nTargetY);
            if not Result then begin
              nTargetX := m_nCurrX;
              nTargetY := m_nCurrY;
              Result := GetGotoXY(DR_UPRIGHT, nTargetX, nTargetY);
              m_btDirection := DR_UPRIGHT;
            end;
            if not Result then begin
              nTargetX := m_nCurrX;
              nTargetY := m_nCurrY;
              Result := GetGotoXY(DR_UPLEFT, nTargetX, nTargetY);
              m_btDirection := DR_UPLEFT;
            end;
          end;
        DR_UPRIGHT: begin
            Result := GetGotoXY(nDir, nTargetX, nTargetY);
            if not Result then begin
              nTargetX := m_nCurrX;
              nTargetY := m_nCurrY;
              Result := GetGotoXY(DR_UP, nTargetX, nTargetY);
              m_btDirection := DR_UP;
            end;
            if not Result then begin
              nTargetX := m_nCurrX;
              nTargetY := m_nCurrY;
              Result := GetGotoXY(DR_RIGHT, nTargetX, nTargetY);
              m_btDirection := DR_RIGHT;
            end;
          end;
        DR_RIGHT: begin
            Result := GetGotoXY(nDir, nTargetX, nTargetY);
            if not Result then begin
              nTargetX := m_nCurrX;
              nTargetY := m_nCurrY;
              Result := GetGotoXY(DR_UPRIGHT, nTargetX, nTargetY);
              m_btDirection := DR_UPRIGHT;
            end;
            if not Result then begin
              nTargetX := m_nCurrX;
              nTargetY := m_nCurrY;
              Result := GetGotoXY(DR_DOWNRIGHT, nTargetX, nTargetY);
              m_btDirection := DR_DOWNRIGHT;
            end;
          end;
        DR_DOWNRIGHT: begin
            Result := GetGotoXY(nDir, nTargetX, nTargetY);
            if not Result then begin
              nTargetX := m_nCurrX;
              nTargetY := m_nCurrY;
              Result := GetGotoXY(DR_RIGHT, nTargetX, nTargetY);
              m_btDirection := DR_RIGHT;
            end;
            if not Result then begin
              nTargetX := m_nCurrX;
              nTargetY := m_nCurrY;
              Result := GetGotoXY(DR_DOWN, nTargetX, nTargetY);
              m_btDirection := DR_DOWN;
            end;
          end;
        DR_DOWN: begin
            Result := GetGotoXY(nDir, nTargetX, nTargetY);
            if not Result then begin
              nTargetX := m_nCurrX;
              nTargetY := m_nCurrY;
              Result := GetGotoXY(DR_DOWNRIGHT, nTargetX, nTargetY);
              m_btDirection := DR_DOWNRIGHT;
            end;
            if not Result then begin
              nTargetX := m_nCurrX;
              nTargetY := m_nCurrY;
              Result := GetGotoXY(DR_DOWNLEFT, nTargetX, nTargetY);
              m_btDirection := DR_DOWNLEFT;
            end;
          end;
        DR_DOWNLEFT: begin
            Result := GetGotoXY(nDir, nTargetX, nTargetY);
            if not Result then begin
              nTargetX := m_nCurrX;
              nTargetY := m_nCurrY;
              Result := GetGotoXY(DR_DOWN, nTargetX, nTargetY);
              m_btDirection := DR_DOWN;
            end;
            if not Result then begin
              nTargetX := m_nCurrX;
              nTargetY := m_nCurrY;
              Result := GetGotoXY(DR_LEFT, nTargetX, nTargetY);
              m_btDirection := DR_LEFT;
            end;
          end;
        DR_LEFT: begin
            Result := GetGotoXY(nDir, nTargetX, nTargetY);
            if not Result then begin
              nTargetX := m_nCurrX;
              nTargetY := m_nCurrY;
              Result := GetGotoXY(DR_DOWNLEFT, nTargetX, nTargetY);
              m_btDirection := DR_DOWNLEFT;
            end;
            if not Result then begin
              nTargetX := m_nCurrX;
              nTargetY := m_nCurrY;
              Result := GetGotoXY(DR_UPLEFT, nTargetX, nTargetY);
              m_btDirection := DR_UPLEFT;
            end;
          end;
        DR_UPLEFT: begin
            Result := GetGotoXY(nDir, nTargetX, nTargetY);
            if not Result then begin
              nTargetX := m_nCurrX;
              nTargetY := m_nCurrY;
              Result := GetGotoXY(DR_LEFT, nTargetX, nTargetY);
              m_btDirection := DR_LEFT;
            end;
            if not Result then begin
              nTargetX := m_nCurrX;
              nTargetY := m_nCurrY;
              Result := GetGotoXY(DR_UP, nTargetX, nTargetY);
              m_btDirection := DR_UP;
            end;
          end;
      end;
    end;
  end;
var
  nTargetX: Integer;
  nTargetY: Integer;
  nDir: Integer;
begin
  Result := True;
  if (m_TargetCret <> nil) and not m_TargetCret.m_boDeath then begin
    if GotoMasterXY(nTargetX, nTargetY) then begin
       GotoTargetXY(nTargetX, nTargetY);
    end else begin
      nDir:=GetNextDirection(m_nCurrX,m_nCurrY,m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
      nDir:= GetBackDir(nDir);
      m_PEnvir.GetNextPosition(m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY,nDir,5,m_nTargetX,m_nTargetY);
      GotoTargetXY(m_nTargetX, m_nTargetY);
    end;
  end;
end;       (*
// 20080205 替换成英雄单元里的自动躲避
function TPlayMonster.AutoAvoid(): Boolean; //自动躲避
  function GetAvoidDir(): Integer;
  var
    n10: Integer;
    n14: Integer;
  begin
    n10 := m_TargetCret.m_nCurrX;
    n14 := m_TargetCret.m_nCurrY;
    Result := DR_DOWN;
    if n10 > m_nCurrX then begin
      Result := DR_LEFT;
      if n14 > m_nCurrY then Result := DR_DOWNLEFT;
      if n14 < m_nCurrY then Result := DR_UPLEFT;
    end else begin
      if n10 < m_nCurrX then begin
        Result := DR_RIGHT;
        if n14 > m_nCurrY then Result := DR_DOWNRIGHT;
        if n14 < m_nCurrY then Result := DR_UPRIGHT;
      end else begin
        if n14 > m_nCurrY then Result := DR_UP
        else if n14 < m_nCurrY then Result := DR_DOWN;
      end;
    end;
  end;
  function SearchNextDir(var nTargetX, nTargetY: Integer): Boolean;
  var
    I: Integer;
    nDir: Integer;
    n01: Integer;
    n02: Integer;
    n03: Integer;
    n04: Integer;
    n05: Integer;
    n06: Integer;
    n07: Integer;
    n08: Integer;
    n10: Integer;
    boGotoL2: Boolean;
  label L001;
  label L002;
  label L003;
  begin
    Result := False;
    if not Result then begin
      nDir := GetAvoidDir;
      boGotoL2 := False;
      goto L001;
    end;

    L002:
    if not Result then begin
      n10 := 0;
      while True do begin
        Inc(n10);
        nDir := Random(8);
        if nDir in [0..7] then Break;
        if n10 > 8 then Break;
      end;
      goto L001;
    end;

    L001:
    n01 := 0;
    n02 := 0;
    n03 := 0;
    n04 := 0;
    n05 := 0;
    n06 := 0;
    n07 := 0;
    n08 := 0;
    while True do begin
      if nDir > DR_UPLEFT then Break;
      case nDir of
        DR_UP: begin
            if m_PEnvir.CanWalkEx(nTargetX, nTargetY, True) and (CheckTargetXYCountOfDirection(nTargetX, nTargetY, nDir, 6) = 0) then begin
              Inc(nTargetY, 10 - n01);
              Result := True;
              Break;
            end else begin
              if n01 >= 10 then begin
                nTargetX := m_nCurrX;
                nTargetY := m_nCurrY;
                Inc(nDir);
                Continue;
              end;
              Inc(nTargetY);
              Inc(n01);
              Continue;
            end;
          end;
        DR_UPRIGHT: begin
            if m_PEnvir.CanWalkEx(nTargetX, nTargetY, True) and (CheckTargetXYCountOfDirection(nTargetX, nTargetY, nDir, 6) = 0) then begin
              Inc(nTargetX, 10 - n02);
              Inc(nTargetY, 10 - n02);
              Result := True;
              Break;
            end else begin
              if n02 >= 10 then begin
                nTargetX := m_nCurrX;
                nTargetY := m_nCurrY;
                Inc(nDir);
                Continue;
              end;
              Inc(nTargetX);
              Inc(nTargetY);
              Inc(n02);
              Continue;
            end;
          end; //CheckTargetXYCountOfDirection(m_nCurrX, m_nCurrY, m_btDirection, 1)
        DR_RIGHT: begin
            if m_PEnvir.CanWalkEx(nTargetX, nTargetY, True) and (CheckTargetXYCountOfDirection(nTargetX, nTargetY, nDir, 6) = 0) then begin
              Inc(nTargetX, 10 - n03);
              Result := True;
              Break;
            end else begin
              if n03 >= 10 then begin
                nTargetX := m_nCurrX;
                nTargetY := m_nCurrY;
                Inc(nDir);
                Continue;
              end;
              Inc(nTargetX);
              Inc(n03);
              Continue;
            end;
          end;
        DR_DOWNRIGHT: begin
            if m_PEnvir.CanWalkEx(nTargetX, nTargetY, True) and (CheckTargetXYCountOfDirection(nTargetX, nTargetY, nDir, 6) = 0) then begin
              Inc(nTargetX, 10 - n04);
              Dec(nTargetY, 10 - n04);
              Result := True;
              Break;
            end else begin
              if n04 >= 10 then begin
                nTargetX := m_nCurrX;
                nTargetY := m_nCurrY;
                Inc(nDir);
                Continue;
              end;
              Inc(nTargetX);
              Dec(nTargetY);
              Inc(n04);
              Continue;
            end;
          end;
        DR_DOWN: begin
            if m_PEnvir.CanWalkEx(nTargetX, nTargetY, True) and (CheckTargetXYCountOfDirection(nTargetX, nTargetY, nDir, 6) = 0) then begin
              Dec(nTargetY, 10 - n05);
              Result := True;
              Break;
            end else begin
              if n05 >= 10 then begin
                nTargetX := m_nCurrX;
                nTargetY := m_nCurrY;
                Inc(nDir);
                Continue;
              end;
              Dec(nTargetY);
              Inc(n05);
              Continue;
            end;
          end;
        DR_DOWNLEFT: begin
            if m_PEnvir.CanWalkEx(nTargetX, nTargetY, True) and (CheckTargetXYCountOfDirection(nTargetX, nTargetY, nDir, 6) = 0) then begin
              Dec(nTargetX, 10 - n06);
              Dec(nTargetY, 10 - n06);
              Result := True;
              Break;
            end else begin
              if n06 >= 10 then begin
                nTargetX := m_nCurrX;
                nTargetY := m_nCurrY;
                Inc(nDir);
                Continue;
              end;
              Dec(nTargetX);
              Dec(nTargetY);
              Inc(n06);
              Continue;
            end;
          end;
        DR_LEFT: begin
            if m_PEnvir.CanWalkEx(nTargetX, nTargetY, True) and (CheckTargetXYCountOfDirection(nTargetX, nTargetY, nDir, 6) = 0) then begin
              Dec(nTargetX, 10 - n07);
              Result := True;
              Break;
            end else begin
              if n07 >= 10 then begin
                nTargetX := m_nCurrX;
                nTargetY := m_nCurrY;
                Inc(nDir);
                Continue;
              end;
              Dec(nTargetX);
              Inc(n07);
              Continue;
            end;
          end;
        DR_UPLEFT: begin
            if m_PEnvir.CanWalkEx(nTargetX, nTargetY, True) and (CheckTargetXYCountOfDirection(nTargetX, nTargetY, nDir, 6) = 0) then begin
              Dec(nTargetX, 10 - n08);
              Inc(nTargetY, 10 - n08);
              Result := True;
              Break;
            end else begin
              if n08 >= 10 then begin
                nTargetX := m_nCurrX;
                nTargetY := m_nCurrY;
                Inc(nDir);
                Continue;
              end;
              Dec(nTargetX);
              Inc(nTargetY);
              Inc(n08);
              Continue;
            end;
          end;
      end;
    end;
    if (not boGotoL2) and (not Result) then begin
      boGotoL2 := True;
      goto L002;
    end;
  end;
var
  n10: Integer;
//  n14: Integer;
//  n20: Integer;
//  nOldX: Integer;
//  nOldY: Integer;
//  n16: Integer;
  nTargetX: Integer;
  nTargetY: Integer;
//  nLoopCount: Integer;
begin
  if m_TargetCret <> nil then begin
    n10 := 0;
    if CheckTargetXYCount(m_nCurrX, m_nCurrY, 6) > 0 then begin
      while True do begin
        Inc(n10);
        nTargetX := m_nCurrX;
        nTargetY := m_nCurrY;
        if SearchNextDir(nTargetX, nTargetY) then
          GotoTargetXY(nTargetX, nTargetY);
        if CheckTargetXYCount(m_nCurrX, m_nCurrY, 6) = 0 then Break;
        if n10 >= 1 then Break;
      end;
    end;
    GotoTargetXYRange();
  end;
  {if m_TargetCret <> nil then begin  //原来注释的,
    nLoopCount := 1;
    if CheckTargetXYCount(m_nCurrX, m_nCurrY, 6) > 0 then begin
      nTargetX := m_nCurrX;
      nTargetY := m_nCurrY + 8;
      if m_PEnvir.CanWalkEx(nTargetX, nTargetY, True) and (CheckTargetXYCount(nTargetX, nTargetY, 6) = 0) then begin
        n20 := 0;
        while True do begin
          if n20 > nLoopCount then break;
          GotoTargetXY(nTargetX, nTargetY);
          Inc(nTargetY);
          Inc(n20);
        end;
        Exit;
      end;
      nTargetX := m_nCurrX + 10;
      nTargetY := m_nCurrY + 10;
      if m_PEnvir.CanWalkEx(nTargetX, nTargetY, True) and (CheckTargetXYCount(nTargetX, nTargetY, 6) = 0) then begin
        n20 := 0;
        while True do begin
          if n20 > nLoopCount then break;
          GotoTargetXY(nTargetX, nTargetY);
          Inc(nTargetX);
          Inc(nTargetY);
          Inc(n20);
        end;
        Exit;
      end;
      nTargetX := m_nCurrX + 8;
      nTargetY := m_nCurrY;
      if m_PEnvir.CanWalkEx(nTargetX, nTargetY, True) and (CheckTargetXYCount(nTargetX, nTargetY, 6) = 0) then begin
        n20 := 0;
        while True do begin
          if n20 > nLoopCount then break;
          GotoTargetXY(nTargetX, nTargetY);
          Inc(nTargetX);
          Inc(n20);
        end;
        Exit;
      end;
      nTargetX := m_nCurrX + 10;
      nTargetY := m_nCurrY + 10;
      if m_PEnvir.CanWalkEx(nTargetX, nTargetY, True) and (CheckTargetXYCount(nTargetX, nTargetY, 6) = 0) then begin
        n20 := 0;
        while True do begin
          if n20 > nLoopCount then break;
          GotoTargetXY(nTargetX, nTargetY);
          Inc(nTargetX);
          Inc(nTargetY);
          Inc(n20);
        end;
        Exit;
      end;
      nTargetX := m_nCurrX;
      nTargetY := m_nCurrY - 8;
      if m_PEnvir.CanWalkEx(nTargetX, nTargetY, True) and (CheckTargetXYCount(nTargetX, nTargetY, 6) = 0) then begin
        n20 := 0;
        while True do begin
          if n20 > nLoopCount then break;
          GotoTargetXY(nTargetX, nTargetY);
          Dec(nTargetY);
          Inc(n20);
        end;
        Exit;
      end;
      nTargetX := m_nCurrX - 10;
      nTargetY := m_nCurrY - 10;
      if m_PEnvir.CanWalkEx(nTargetX, nTargetY, True) and (CheckTargetXYCount(nTargetX, nTargetY, 6) = 0) then begin
        n20 := 0;
        while True do begin
          if n20 > nLoopCount then break;
          GotoTargetXY(nTargetX, nTargetY);
          Dec(nTargetX);
          Dec(nTargetY);
          Inc(n20);
        end;
        Exit;
      end;
      nTargetX := m_nCurrX - 8;
      nTargetY := m_nCurrY;
      if m_PEnvir.CanWalkEx(nTargetX, nTargetY, True) and (CheckTargetXYCount(nTargetX, nTargetY, 6) = 0) then begin
        n20 := 0;
        while True do begin
          if n20 > nLoopCount then break;
          GotoTargetXY(nTargetX, nTargetY);
          Dec(nTargetX);
          Inc(n20);
        end;
        Exit;
      end;
      nTargetX := m_nCurrX - 10;
      nTargetY := m_nCurrY + 10;
      if m_PEnvir.CanWalkEx(nTargetX, nTargetY, True) and (CheckTargetXYCount(nTargetX, nTargetY, 6) = 0) then begin
        n20 := 0;
        while True do begin
          if n20 > nLoopCount then break;
          GotoTargetXY(nTargetX, nTargetY);
          Dec(nTargetX);
          Inc(nTargetY);
          Inc(n20);
        end;
        Exit;
      end;
      if m_Master <> nil then begin
        nTargetX := m_Master.m_nCurrX;
        nTargetY := m_Master.m_nCurrY;
        GotoTargetXY(nTargetX, nTargetY);
      end else begin
        GetTargetCretXY(nTargetX, nTargetY);
        GotoTargetXY(nTargetX, nTargetY);
      end;
    end;
  end;}
end;   *)

procedure TPlayMonster.SearchPickUpItem(dwSearchTime: LongWord);
  function PickUpItem(VisibleMapItem: pTVisibleMapItem): Boolean;
  var
    UserItem: pTUserItem;
    StdItem: pTStdItem;
    MapItem: PTMapItem;
//    nDeleteCode: Integer;
  begin
    Result := False;
    MapItem := m_PEnvir.GetItem(VisibleMapItem.nX, VisibleMapItem.nY {m_nCurrX, m_nCurrY});
    if MapItem = nil then Exit;
    if CompareText(VisibleMapItem.sName, sSTRING_GOLDNAME) = 0 then begin
      if m_PEnvir.DeleteFromMap(VisibleMapItem.nX, VisibleMapItem.nY {m_nCurrX, m_nCurrY}, OS_ITEMOBJECT, TObject(MapItem)) = 1 then begin
        if (m_Master <> nil) and (not m_Master.m_boDeath) and (m_Master.m_btRaceServer = RC_PLAYOBJECT){20080208 增加} then begin //捡到的钱加给主人
          if TPlayObject(m_Master).IncGold(MapItem.Count) then begin
            SendRefMsg(RM_ITEMHIDE, 0, Integer(MapItem), VisibleMapItem.nX, VisibleMapItem.nY {m_nCurrX, m_nCurrY}, '');
            if g_boGameLogGold then
              AddGameDataLog('4' + #9 +
                m_sMapName + #9 +
                IntToStr(VisibleMapItem.nX ) + #9 +
                IntToStr(VisibleMapItem.nY ) + #9 +
                m_sCharName + #9 +
                sSTRING_GOLDNAME + #9 +
                IntToStr(MapItem.Count) + #9 +
                '1' + #9 + '0');
            Result := True;
            m_Master.GoldChanged;
            //DisPoseAndNil(MapItem); SB 局部变量NIL 个毛啊还有内存泄露 By TasNat at: 2012-03-17 17:21:56
            DisPose(MapItem);
          end else begin
            m_PEnvir.AddToMap(VisibleMapItem.nX, VisibleMapItem.nY {m_nCurrX, m_nCurrY}, OS_ITEMOBJECT, TObject(MapItem));
          end;
        end;
      end;
      Exit;
    end else begin //捡物品
      if (m_Master <> nil) and (not m_Master.m_boDeath) then begin //捡到的物品加给主人
        if m_ItemList.Count < g_Config.nCopyHumanBagCount then begin //捡到药品先给自己
          StdItem := UserEngine.GetStdItem(MapItem.UserItem.wIndex);
          if (StdItem <> nil) and IsPickUpItem(StdItem) then begin
            if m_PEnvir.DeleteFromMap(VisibleMapItem.nX, VisibleMapItem.nY {m_nCurrX, m_nCurrY}, OS_ITEMOBJECT, TObject(MapItem)) = 1 then begin
              New(UserItem);
              FillChar(UserItem^, SizeOf(TUserItem), #0);//20080820 增加
              //FillChar(UserItem^.btValue, SizeOf(UserItem^.btValue), 0);//20080820 增加
              UserItem^ := MapItem.UserItem;
              StdItem := UserEngine.GetStdItem(UserItem.wIndex);
              if (StdItem <> nil) and IsAddWeightAvailable(UserEngine.GetStdItemWeight(UserItem.wIndex)) then begin
                if GetCheckItemList(18, StdItem.Name) then begin//判断是否为绑定48时物品
                  UserItem.AddValue[0]:= 2;
                  UserItem.MaxDate:= IncDayHour(Now(), 48);//解绑时间
                end;
                SendRefMsg(RM_ITEMHIDE, 0, Integer(MapItem), VisibleMapItem.nX, VisibleMapItem.nY {m_nCurrX, m_nCurrY}, '');
                m_ItemList.Add(UserItem);
                //m_WAbil.Weight := RecalcBagWeight();
                if StdItem.NeedIdentify = 1 then
                  AddGameDataLog('4' + #9 + m_sMapName + #9 +
                    IntToStr(VisibleMapItem.nX) + #9 + IntToStr(VisibleMapItem.nY) + #9 +
                    m_sCharName + #9 + StdItem.Name + #9 +
                    IntToStr(UserItem.MakeIndex) + #9 +
                    '('+IntToStr(LoWord(StdItem.DC))+'/'+IntToStr(HiWord(StdItem.DC))+')'+
                    '('+IntToStr(LoWord(StdItem.MC))+'/'+IntToStr(HiWord(StdItem.MC))+')'+
                    '('+IntToStr(LoWord(StdItem.SC))+'/'+IntToStr(HiWord(StdItem.SC))+')'+
                    '('+IntToStr(LoWord(StdItem.AC))+'/'+IntToStr(HiWord(StdItem.AC))+')'+
                    '('+IntToStr(LoWord(StdItem.MAC))+'/'+IntToStr(HiWord(StdItem.MAC))+')'+
                    IntToStr(UserItem.btValue[0])+'/'+IntToStr(UserItem.btValue[1])+'/'+IntToStr(UserItem.btValue[2])+'/'+
                    IntToStr(UserItem.btValue[3])+'/'+IntToStr(UserItem.btValue[4])+'/'+IntToStr(UserItem.btValue[5])+'/'+
                    IntToStr(UserItem.btValue[6])+'/'+IntToStr(UserItem.btValue[7])+'/'+IntToStr(UserItem.btValue[8])+'/'+
                    IntToStr(UserItem.btValue[14])+ #9 + IntToStr(UserItem.Dura)+'/'+IntToStr(UserItem.DuraMax));
                Result := True;
                //DisPoseAndNil(MapItem); SB 局部变量NIL 个毛啊还有内存泄露 By TasNat at: 2012-03-17 17:21:56
                DisPose(MapItem);
              end;
            end else begin
              //DisPoseAndNil(MapItem); SB 局部变量NIL 个毛啊还有内存泄露 By TasNat at: 2012-03-17 17:21:56
              DisPose(MapItem);
              m_PEnvir.AddToMap(VisibleMapItem.nX, VisibleMapItem.nY {m_nCurrX, m_nCurrY}, OS_ITEMOBJECT, TObject(MapItem));
            end;
            Exit;
          end;
        end;
        if TPlayObject(m_Master).IsEnoughBag and m_boCanPickUpItem then begin
          if m_PEnvir.DeleteFromMap(VisibleMapItem.nX, VisibleMapItem.nY {m_nCurrX, m_nCurrY}, OS_ITEMOBJECT, TObject(MapItem)) = 1 then begin
            New(UserItem);
            FillChar(UserItem^, SizeOf(TUserItem), #0);//20080820 增加
            //FillChar(UserItem^.btValue, SizeOf(UserItem^.btValue), 0);//20080820 增加
            UserItem^ := MapItem.UserItem;
            StdItem := UserEngine.GetStdItem(UserItem.wIndex);
            if (StdItem <> nil) and TPlayObject(m_Master).IsAddWeightAvailable(UserEngine.GetStdItemWeight(UserItem.wIndex)) then begin
              SendRefMsg(RM_ITEMHIDE, 0, Integer(MapItem), VisibleMapItem.nX, VisibleMapItem.nY {m_nCurrX, m_nCurrY}, '');
              TPlayObject(m_Master).AddItemToBag(UserItem);
              if StdItem.NeedIdentify = 1 then
                AddGameDataLog('4' + #9 + m_sMapName + #9 +
                  IntToStr(VisibleMapItem.nX ) + #9 + IntToStr(VisibleMapItem.nY ) + #9 +
                  m_sCharName + ' - ' + m_Master.m_sCharName + #9 + StdItem.Name + #9 +
                  IntToStr(UserItem.MakeIndex) + #9 +
                  '('+IntToStr(LoWord(StdItem.DC))+'/'+IntToStr(HiWord(StdItem.DC))+')'+
                  '('+IntToStr(LoWord(StdItem.MC))+'/'+IntToStr(HiWord(StdItem.MC))+')'+
                  '('+IntToStr(LoWord(StdItem.SC))+'/'+IntToStr(HiWord(StdItem.SC))+')'+
                  '('+IntToStr(LoWord(StdItem.AC))+'/'+IntToStr(HiWord(StdItem.AC))+')'+
                  '('+IntToStr(LoWord(StdItem.MAC))+'/'+IntToStr(HiWord(StdItem.MAC))+')'+
                  IntToStr(UserItem.btValue[0])+'/'+IntToStr(UserItem.btValue[1])+'/'+IntToStr(UserItem.btValue[2])+'/'+
                  IntToStr(UserItem.btValue[3])+'/'+IntToStr(UserItem.btValue[4])+'/'+IntToStr(UserItem.btValue[5])+'/'+
                  IntToStr(UserItem.btValue[6])+'/'+IntToStr(UserItem.btValue[7])+'/'+IntToStr(UserItem.btValue[8])+'/'+
                  IntToStr(UserItem.btValue[14])+ #9 +IntToStr(UserItem.Dura)+'/'+IntToStr(UserItem.DuraMax));
              Result := True;
              //DisPoseAndNil(MapItem); SB 局部变量NIL 个毛啊还有内存泄露 By TasNat at: 2012-03-17 17:21:56
              DisPose(MapItem);
              if not m_Master.m_boDeath then begin
                if (TPlayObject(m_Master).m_btRaceServer = RC_PLAYOBJECT)  then begin
                  TPlayObject(m_Master).SendAddItem(UserItem);
                end else
                if m_Master.m_btRaceServer = RC_HEROOBJECT   then begin {20080208 增加}
                  THeroObject(m_Master).SendAddItem(UserItem);
                end;
              end;
            end else begin
              //DisPoseAndNil(MapItem); SB 局部变量NIL 个毛啊还有内存泄露 By TasNat at: 2012-03-17 17:21:56
              DisPose(MapItem);
              m_PEnvir.AddToMap(VisibleMapItem.nX, VisibleMapItem.nY {m_nCurrX, m_nCurrY}, OS_ITEMOBJECT, TObject(MapItem));
            end;
          end;
        end;
      end;
    end;
  end;

 { function IsOfGroup(BaseObject: TBaseObject): Boolean;
//  var
//    I: Integer;
//    GroupMember: TBaseObject;
  begin
    Result := False;
    if m_Master.m_GroupOwner = nil then Exit;
    for I := 0 to m_Master.m_GroupOwner.m_GroupMembers.Count - 1 do begin
      GroupMember := TBaseObject(m_Master.m_GroupOwner.m_GroupMembers.Objects[I]);
      if GroupMember = BaseObject then begin
        Result := True;
        Break;
      end;
    end;
  end;   }
var
  MapItem: PTMapItem;
  VisibleMapItem: pTVisibleMapItem;
  I: Integer;
  nCode: Byte;
//  nCheckCode: Integer;
//  boFound: Boolean;
//  sName: string;
begin
  try
    nCode:= 0;
    if GetTickCount - m_dwPickUpItemTick > dwSearchTime then begin
      m_dwPickUpItemTick := GetTickCount;
      nCode:= 1;
      if m_VisibleItems.Count > 0 then begin//20080630
        nCode:= 2;
        for I := 0 to m_VisibleItems.Count - 1 do begin
          VisibleMapItem := pTVisibleMapItem(m_VisibleItems.Items[I]);
          nCode:= 3;
          if (VisibleMapItem <> nil) then begin
            if (VisibleMapItem.nVisibleFlag > 0) then begin
              nCode:= 4;
              MapItem := VisibleMapItem.MapItem;
              if (MapItem <> nil) then begin
                if (MapItem.DropBaseObject <> m_Master) then begin
                  nCode:= 5;
                  if IsAllowPickUpItem(VisibleMapItem.sName) then begin
                    nCode:= 6;
                    //if (MapItem.DropBaseObject <> nil) and (TBaseObject(MapItem.DropBaseObject).m_btRaceServer = RC_PLAYOBJECT) then Continue;
                    if (MapItem.OfBaseObject = nil) or (MapItem.OfBaseObject = m_Master) or (MapItem.OfBaseObject = Self) {or IsOfGroup(TBaseObject(MapItem.OfBaseObject))} then begin
                      //GotoTargetXY(VisibleMapItem.nX, VisibleMapItem.nY);
                      nCode:= 7;
                      if PickUpItem(VisibleMapItem) then begin
                        //MainOutMessage('捡到物品');
                        Break;
                      end;
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;//for
      end;
    end;
  except
    MainOutMessage(Format('{%s} TPlayMonster.SearchPickUpItem Code:%d', [g_sExceptionVer, nCode]));
  end;
end;
//是不是可以捡的药品
function TPlayMonster.IsPickUpItem(StdItem: pTStdItem): Boolean;
begin
  Result := False;
  if StdItem.StdMode = 0 then begin
    if (StdItem.Shape in [0, 1, 2]) then Result := True;
  end else
    if StdItem.StdMode = 31 then begin
    if GetBindItemType(StdItem.Shape) >= 0 then Result := True;
  end else begin
    Result := False;
  end;
end;

function TPlayMonster.EatUseItems(btItemType: Byte): Boolean; {自动吃药}
  function EatItems(StdItem: pTStdItem): Boolean;
  begin
    Result := False;
    if m_PEnvir.m_boNODRUG then begin
      Exit;
    end;
    case StdItem.StdMode of
      0: begin
          case StdItem.Shape of {红药}
            0: begin
                if (StdItem.AC > 0) then begin
                  Inc(m_nIncHealth, StdItem.AC);
                  Result := True;
                end;
                if (StdItem.MAC > 0) then begin {蓝药}
                  Inc(m_nIncSpell, StdItem.MAC);
                  Result := True;
                end;
              end;
            1: begin
                if (StdItem.AC > 0) and (StdItem.MAC > 0) then begin
                  IncHealthSpell(StdItem.AC, StdItem.MAC);
                  Result := True;
                end;
              end;
          end;
        end;
    end;
  end;

  function GetUnbindItemName(nShape: Integer): string;
  var
    I: Integer;
  begin
    Result := '';
    if g_UnbindList.Count > 0 then begin//20080630
      for I := 0 to g_UnbindList.Count - 1 do begin
        if Integer(g_UnbindList.Objects[I]) = nShape then begin
          Result := g_UnbindList.Strings[I];
          Break;
        end;
      end;
    end;
  end;

  function GetUnBindItems(sItemName: string; nCount: Integer): Boolean;
  var
    I: Integer;
    UserItem: pTUserItem;
  begin
    Result := False;
    if nCount <= 0 then nCount:=1;//20080630
    for I := 0 to nCount - 1 do begin
      New(UserItem);
      if UserEngine.CopyToUserItemFromName(sItemName, UserItem) then begin
        m_ItemList.Add(UserItem);
        Result := True;
      end else begin
        Dispose(UserItem);
        Break;
      end;
    end;
  end;

  function FoundUserItem(nItemIdx: Integer): Boolean;
  var
    I: Integer;
    UserItem: pTUserItem;
  begin
    Result := False;
    if m_ItemList.Count > 0 then begin//20080628
      for I := 0 to m_ItemList.Count - 1 do begin
        UserItem := m_ItemList.Items[I];
        if UserItem = nil then Continue;
        if (UserItem <> nil) and (UserItem.MakeIndex = nItemIdx) then begin
          Result := True;
          Break;
        end;
      end;
    end;
  end;

  function FoundAddHealthItem(ItemType: Byte): Integer;
  var
    I: Integer;
    UserItem: pTUserItem;
    StdItem: pTStdItem;
  begin
    Result := -1;
    if m_ItemList.Count > 0 then begin//20080628
      for I := 0 to m_ItemList.Count - 1 do begin
        UserItem := m_ItemList.Items[I];
        if UserItem <> nil then begin
          StdItem := UserEngine.GetStdItem(UserItem.wIndex);
          if StdItem <> nil then begin
            case ItemType of
              0: begin //红药
                  if (StdItem.StdMode = 0) and (StdItem.Shape = 0) and (StdItem.AC > 0) then begin
                    Result := I;
                    Break;
                  end;
                end;
              1: begin //蓝药
                  if (StdItem.StdMode = 0) and (StdItem.Shape = 0) and (StdItem.MAC > 0) then begin
                    Result := I;
                    Break;
                  end;
                end;
              2: begin //太阳水
                  if (StdItem.StdMode = 0) and (StdItem.Shape = 1) and (StdItem.AC > 0) and (StdItem.MAC > 0) then begin
                    Result := I;
                    Break;
                  end;
                end;
              3: begin //红药包
                  if (StdItem.StdMode = 31) and (GetBindItemType(StdItem.Shape) = 0) then begin
                    Result := I;
                    Break;
                  end;
                end;
              4: begin //蓝药包
                  if (StdItem.StdMode = 31) and (GetBindItemType(StdItem.Shape) = 1) then begin
                    Result := I;
                    Break;
                  end;
                end;
              5: begin//大补药 20080506
                  if (StdItem.StdMode = 31) and (GetBindItemType(StdItem.Shape) = 2) then begin
                    Result := I;
                    Break;
                  end;
               end;
            end;
          end;
        end;
      end;
    end;
  end;

  function UseAddHealthItem(nItemIdx: Integer): Boolean;
  var
    UserItem: pTUserItem;
    StdItem: pTStdItem;
  begin
    Result := False;
    UserItem := m_ItemList.Items[nItemIdx];
    if UserItem <> nil then begin
      StdItem := UserEngine.GetStdItem(UserItem.wIndex);
      if StdItem <> nil then begin
        if not m_PEnvir.AllowStdItems(UserItem.wIndex) then begin
          Exit;
        end;
        case StdItem.StdMode of
          0 {, 1, 2, 3}: begin //药
              if EatItems(StdItem) then begin
                if UserItem <> nil then Dispose(UserItem);
                m_ItemList.Delete(nItemIdx);
                //m_WAbil.Weight := RecalcBagWeight();
                Result := True;
              end;
            end;
          31: begin //解包物品
              if (StdItem.AniCount = 0) and (GetBindItemType(StdItem.Shape) >= 0) then begin
                //if (m_ItemList.Count + 6 - 1) <= MAXBAGITEM then begin
                Dispose(UserItem);
                m_ItemList.Delete(nItemIdx);
                GetUnBindItems(GetUnbindItemName(StdItem.Shape), 6);
                Result := True;
              end;
            end;
        end;
      end;
    end;
  end;

var
  nItemIdx: Integer;
begin
  Result := False;//20080522
  if not m_boDeath then begin
    nItemIdx := FoundAddHealthItem(btItemType);
    if (nItemIdx >= 0) and (nItemIdx < m_ItemList.Count) then begin
      Result := UseAddHealthItem(nItemIdx);
    end else begin
      case btItemType of //查找解包物品
        0: begin
            nItemIdx := FoundAddHealthItem(3);
            if (nItemIdx >= 0) and (nItemIdx < m_ItemList.Count) then begin
              Result := UseAddHealthItem(nItemIdx);
            end else begin
              nItemIdx := FoundAddHealthItem(2);
              if (nItemIdx >= 0) and (nItemIdx < m_ItemList.Count) then begin
                Result := UseAddHealthItem(nItemIdx);
              end else begin
                nItemIdx := FoundAddHealthItem(5);
                if (nItemIdx >= 0) and (nItemIdx < m_ItemList.Count) then
                  Result := UseAddHealthItem(nItemIdx);
              end;
            end;
          end;
        1: begin
            nItemIdx := FoundAddHealthItem(4);
            if (nItemIdx >= 0) and (nItemIdx < m_ItemList.Count) then begin
              Result := UseAddHealthItem(nItemIdx);
            end else begin
              nItemIdx := FoundAddHealthItem(2);
              if (nItemIdx >= 0) and (nItemIdx < m_ItemList.Count) then begin
                Result := UseAddHealthItem(nItemIdx);
              end else begin
                nItemIdx := FoundAddHealthItem(5);
                if (nItemIdx >= 0) and (nItemIdx < m_ItemList.Count) then
                  Result := UseAddHealthItem(nItemIdx);
              end;
            end;
          end;
      end;
    end;
  end;
end;

function TPlayMonster.AllowGotoTargetXY(): Boolean;
begin
  Result := True;
  if (m_btJob = 0) or (not m_boDoSpellMagic) or (m_TargetCret = nil) then Exit;
  Result := False;
end;
//烈火
function TPlayMonster.AllowFireHitSkill(): Boolean;
begin
  Result := False;
  if (GetTickCount - m_dwLatestFireHitTick) > 10000{10 * 1000} then begin
    m_dwLatestFireHitTick := GetTickCount();
    m_boFireHitSkill := True;
    Result := True;
  end;
end;
//逐日剑法 20080511
function TPlayMonster.AllowDailySkill(): Boolean;
begin
  Result := False;
  if (GetTickCount - m_dwLatestDailyTick) > 10000{10 * 1000}  then begin
    m_dwLatestDailyTick := GetTickCount();
    m_boDailySkill := True;
    Result := True;
  end;
end;
//是否需要躲避,除战士外
function TPlayMonster.StartAutoAvoid(): Boolean;
begin
  Result := False;
  if ((GetTickCount - m_dwAutoAvoidTick) > 3000) and  m_boAutoAvoid then begin//是否躲避 20080715
    if ((m_btJob > 0) or (m_WAbil.HP <= Round(m_WAbil.MaxHP * 0.25))) and m_boDoSpellMagic and (m_TargetCret <> nil) and (not m_TargetCret.m_boDeath) then begin
      m_dwAutoAvoidTick := GetTickCount();
      case m_btJob of
        1:if CheckTargetXYCount(m_nCurrX, m_nCurrY, 4) > 0 then Result := True;
        2:if CheckTargetXYCount(m_nCurrX, m_nCurrY, 3) > 0 then Result := True;
      end;
    end;
  end;
end;
//是否走向目标 20080206
function TPlayMonster.IsNeedGotoXY(): Boolean;
begin
  Result := False;
  if (m_TargetCret <> nil) and ((GetTickCount - m_dwAutoAvoidTick) > 3000{3 * 1000}) and ((not m_boDoSpellMagic) or (m_btJob = 0)) then begin //战士
    if m_btJob > 0 then begin
      if (abs(m_TargetCret.m_nCurrX - m_nCurrX) > 1) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 1) then begin
        Result := True;
      end;
    end else begin//战 20081205
      case m_nSelectMagic of
        SKILL_ERGUM{12}, SKILL_89{89}:begin//刺杀,四级刺杀剑术
            m_nSelectMagic:= 0;
            if ((wSkill_12 > 0) or (wSKILL_89 > 0)) and (m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, 2, m_nTargetX, m_nTargetY)) then begin
              if ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=2)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=0)) or
                ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=0)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=2)) or
                ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=2)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=2)) then begin
                if m_Master <> nil then begin//人物分身时的攻击速度
                  if GetTickCount - m_dwHitTick > g_Config.dwWarrorAttackTime then begin
                     m_dwHitTick := GetTickCount();
                     m_wHitMode:= 4;//刺杀
                     if (wSKILL_89 > 0) then m_wHitMode:= 15;//四级刺杀
                     m_dwTargetFocusTick := GetTickCount();
                     m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
                     Attack(m_TargetCret, m_btDirection);
                     BreakHolySeizeMode();
                     Exit;
                  end;
                end else begin
                  if GetTickCount - m_dwHitTick > m_nNextHitTime then begin//为怪物时按DB设置的攻击速度
                     m_dwHitTick := GetTickCount();
                     m_wHitMode:= 4;//刺杀
                     if (wSKILL_89 > 0) then m_wHitMode:= 15;//四级刺杀
                     m_dwTargetFocusTick := GetTickCount();
                     m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
                     Attack(m_TargetCret, m_btDirection);
                     BreakHolySeizeMode();
                     Exit;
                  end;
                end;
              end else begin//new
                if ((abs(m_TargetCret.m_nCurrX - m_nCurrX) > 1) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 1)) then begin
                  Result := True;
                  Exit;
                end;
              end;
            end;

            if (wSkill_12 > 0) or (wSKILL_89 > 0) then begin
              if (abs(m_TargetCret.m_nCurrX - m_nCurrX) > 2) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 2) then begin
                Result := True;
                Exit;
              end;
            end else
            if (abs(m_TargetCret.m_nCurrX - m_nCurrX) > 1) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 1) then begin
              Result := True;
              Exit;
            end;
          end;//12
        74:begin//逐日剑法
            m_nSelectMagic:= 0;
            if (wSKILL_74 > 0) and (m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, 5, m_nTargetX, m_nTargetY)) then begin
              if ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)<=4)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=0)) or
                 ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=0)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)<=4)) or
                 (((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=2)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=2)) or
                 ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=3)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=3))  or
                 ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=4)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=4))) then begin
                if m_Master <> nil then begin//人物分身时的攻击速度
                  if GetTickCount - m_dwHitTick > g_Config.dwWarrorAttackTime then begin
                    m_dwHitTick := GetTickCount();
                    m_wHitMode:= 13;
                    m_dwTargetFocusTick := GetTickCount();
                    m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
                    Attack(m_TargetCret, m_btDirection);
                    BreakHolySeizeMode();
                    Exit;
                  end;
                end else begin
                  if GetTickCount - m_dwHitTick > m_nNextHitTime then begin//为怪物时按DB设置的攻击速度
                    m_dwHitTick := GetTickCount();
                    m_wHitMode:= 13;
                    m_dwTargetFocusTick := GetTickCount();
                    m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
                    Attack(m_TargetCret, m_btDirection);
                    BreakHolySeizeMode();
                    Exit;
                  end;
                end;
              end else begin
                if (wSkill_12 > 0) or (wSKILL_89 > 0) then begin
                  if (abs(m_TargetCret.m_nCurrX - m_nCurrX) > 2) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 2) then begin
                    Result := True;
                    Exit;
                  end;
                end else
                if (abs(m_TargetCret.m_nCurrX - m_nCurrX) > 1) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 1) then begin
                  Result := True;
                  Exit;
                end;
              end;
            end;

            if (wSkill_12 > 0) or (wSKILL_89 > 0) then begin
              if (abs(m_TargetCret.m_nCurrX - m_nCurrX) > 2) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 2) then begin
                Result := True;
                Exit;
              end;
            end else
            if (abs(m_TargetCret.m_nCurrX - m_nCurrX) > 1) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 1) then begin
              Result := True;
              Exit;
            end;
         end;//74
        43:begin//实现隔位放开天
           m_nSelectMagic:= 0;
           if (wSKILL_42 > 0) and (m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, 5, m_nTargetX, m_nTargetY)) and (m_n42kill = 2) then begin
             if ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)<={4}5)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=0)) or //20090105 修改
               ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=0)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)<={4}5)) or
               (((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=2)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=2)) or
               ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=3)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=3))  or
               ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)={4}5)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)={4}5))) then begin
                if m_Master <> nil then begin//人物分身时的攻击速度
                  if GetTickCount - m_dwHitTick > g_Config.dwWarrorAttackTime then begin
                    m_dwHitTick := GetTickCount();
                    m_wHitMode:= 9;
                    m_dwTargetFocusTick := GetTickCount();
                    m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
                    Attack(m_TargetCret, m_btDirection);
                    BreakHolySeizeMode();
                    Exit;
                  end;
                end else begin
                  if GetTickCount - m_dwHitTick > m_nNextHitTime then begin//为怪物时按DB设置的攻击速度
                    m_dwHitTick := GetTickCount();
                    m_wHitMode:= 9;
                    m_dwTargetFocusTick := GetTickCount();
                    m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
                    Attack(m_TargetCret, m_btDirection);
                    BreakHolySeizeMode();
                    Exit;
                  end;
                end;
             end else begin
               if (wSkill_12 > 0) or (wSKILL_89 > 0) then begin
                 if (abs(m_TargetCret.m_nCurrX - m_nCurrX) > 2) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 2) then begin
                   Result := True;
                   Exit;
                 end;
               end else
               if (abs(m_TargetCret.m_nCurrX - m_nCurrX) > 1) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 1) then begin
                 Result := True;
                 Exit;
               end;
             end;
           end;

           if (wSKILL_42 > 0) and (m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, 2, m_nTargetX, m_nTargetY)) and (m_n42kill in [1,2]) then begin
             if (Abs(m_nCurrX-m_TargetCret.m_nCurrX)=2)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=0) or
                (Abs(m_nCurrX-m_TargetCret.m_nCurrX)=0)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=2) or
                (Abs(m_nCurrX-m_TargetCret.m_nCurrX)=2)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=2) then begin
                if m_Master <> nil then begin//人物分身时的攻击速度
                  if GetTickCount - m_dwHitTick > g_Config.dwWarrorAttackTime then begin
                    m_dwHitTick := GetTickCount();
                    m_wHitMode:= 9;
                    m_dwTargetFocusTick := GetTickCount();
                    m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
                    Attack(m_TargetCret, m_btDirection);
                    BreakHolySeizeMode();
                    Exit;
                  end;
                end else begin
                  if GetTickCount - m_dwHitTick > m_nNextHitTime then begin//为怪物时按DB设置的攻击速度
                    m_dwHitTick := GetTickCount();
                    m_wHitMode:= 9;
                    m_dwTargetFocusTick := GetTickCount();
                    m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
                    Attack(m_TargetCret, m_btDirection);
                    BreakHolySeizeMode();
                    Exit;
                  end;
                end;
             end else begin
                if ((abs(m_TargetCret.m_nCurrX - m_nCurrX) > 1) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 1)) then begin
                  Result := True;
                  Exit;
                end;
             end;
           end;

           if (wSkill_12 > 0) or (wSKILL_89 > 0) then begin
             if (abs(m_TargetCret.m_nCurrX - m_nCurrX) > 2) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 2) then begin
               Result := True;
               Exit;
             end;
           end else
           if (abs(m_TargetCret.m_nCurrX - m_nCurrX) > 1) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 1) then begin
             Result := True;
             Exit;
           end;
        end;//43
        7, 25, 26, SKILL_90:begin
          m_nSelectMagic:= 0;
          if (abs(m_TargetCret.m_nCurrX - m_nCurrX) > 1) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 1) then begin
            Result := True;
            Exit;
          end;        
        end else begin
          if (wSkill_12 > 0) or (wSKILL_89 > 0) then begin
            if (abs(m_TargetCret.m_nCurrX - m_nCurrX) > 2) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 2) then begin
              Result := True;
              Exit;
            end;
          end else
          if (abs(m_TargetCret.m_nCurrX - m_nCurrX) > 1) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 1) then begin
            Result := True;
            Exit;
          end;
        end;        
      end;
    end;
  end;
end;

//取技能消耗的MP值
function TPlayMonster.GetSpellPoint(UserMagic: pTUserMagic): Integer;
begin
  Result := Round(UserMagic.MagicInfo.wSpell / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + UserMagic.MagicInfo.btDefSpell;
end;
//使用魔法
function TPlayMonster.DoSpellMagic(wMagIdx: Word): Boolean;
  function CheckActionStatus(): Boolean;//增加检查两动作的间隔 20080715
  begin
    Result := False;
    if GetTickCount - m_dwActionTick > 1000 then begin
      m_dwActionTick := GetTickCount();
      Result := True;
    end;
  end;
  function DoSpell(UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTBaseObject: TBaseObject): Boolean;
  var
    nSpellPoint, nPowerRate, nDelayTime, nDelayTimeRate, nPower, NGSecPwr, nAmuletIdx: Integer;
    boSpellFail, boSpellFire: Boolean;
    function MPow(UserMagic: pTUserMagic): Integer;
    begin
      if UserMagic.MagicInfo.wMaxPower > UserMagic.MagicInfo.wPower then//20090807
        Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower)
      else Result := UserMagic.MagicInfo.wPower;
    end;
    function GetPower(nPower: Integer): Integer;
    begin
      if UserMagic.MagicInfo.btDefMaxPower > UserMagic.MagicInfo.btDefPower then//20090807
        Result := Round(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower))
      else Result := Round(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + UserMagic.MagicInfo.btDefPower;
    end;
    function GetPower13(nInt: Integer): Integer;
    var
      d10: Double;
      d18: Double;
    begin
      d10 := nInt / 3.0;
      d18 := nInt - d10;
      if UserMagic.MagicInfo.btDefMaxPower > UserMagic.MagicInfo.btDefPower then//20090807
        Result := Round(d18 / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1) + d10 + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower)))
      else Result := Round(d18 / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1) + d10 + UserMagic.MagicInfo.btDefPower);
    end;
    procedure DelUseItem();
    begin
      if m_UseItems[U_BUJUK].Dura < 100 then begin
        m_UseItems[U_BUJUK].Dura := 0;
        m_UseItems[U_BUJUK].wIndex := 0;
      end;
    end;
  begin
    Result := False;
    if wMagIdx = SKILL_69 then begin//倚天辟地
      MagicManager.Attack_69(Self, UserMagic, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      Result := True;
      Exit;
    end;
    boSpellFail := False;
    boSpellFire := True;
    //nPower := 0; //20080415
    if (abs(m_nCurrX - nTargetX) > g_Config.nMagicAttackRage) or (abs(m_nCurrY - nTargetY) > g_Config.nMagicAttackRage) then Exit;
    if not CheckActionStatus() then Exit;//20080715
    if UserMagic.btLevel= 4 then begin//4级技能 灭天火,火符,魔法盾 20080617
      case wMagIdx of
        SKILL_45: SendRefMsg(RM_SPELL, 101, nTargetX, nTargetY, UserMagic.MagicInfo.wMagicId, '');
        SKILL_FIRECHARM: SendRefMsg(RM_SPELL, 100, nTargetX, nTargetY, UserMagic.MagicInfo.wMagicId, '');
        SKILL_66: SendRefMsg(RM_SPELL, UserMagic.MagicInfo.btEffect, nTargetX, nTargetY, UserMagic.MagicInfo.wMagicId, '');
        else SendRefMsg(RM_SPELL, UserMagic.MagicInfo.btEffect, nTargetX, nTargetY, UserMagic.MagicInfo.wMagicId, '');
      end;
    end else begin
      if wMagIdx <> SKILL_MOOTEBO then//除 野蛮冲撞 外 20081108
        SendRefMsg(RM_SPELL, UserMagic.MagicInfo.btEffect, nTargetX, nTargetY, UserMagic.MagicInfo.wMagicId, '');
    end;
    if (TargeTBaseObject <> nil) then begin
      if (TargeTBaseObject.m_boDeath) then TargeTBaseObject := nil;
    end;  
    case wMagIdx of
      {$IF M2Version <> 2}
      SKILL_97: begin//血魄一击(法)
          if MagicManager.MagBigExplosion_97(self,
                            GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.MC), SmallInt(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)) + 1),
                            nTargetX, nTargetY, g_Config.nExplosion_97Range , UserMagic, TargeTBaseObject) then Result := True;
        end;
      SKILL_98: begin//血魄一击(道)
          if MagicManager.MagMakeFireCharm_98(self, UserMagic, nTargetX, nTargetY, g_Config.nExplosion_98Range, TargeTBaseObject) then Result := True;
        end;
      {$IFEND}
      SKILL_LIGHTENING{11}, SKILL_91: begin //雷电术,四级雷电术
         nSpellPoint := GetSpellPoint(UserMagic);
          if nSpellPoint > 0 then begin
            if m_WAbil.MP < nSpellPoint then Exit;
            DamageSpell(nSpellPoint);
            //HealthSpellChanged();
          end;
          if TargeTBaseObject <> nil then begin
            if IsProperTarget(TargeTBaseObject) then begin
              if (Random(10) >= TargeTBaseObject.m_nAntiMagic) then begin
                nPower := GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.MC),
                  SmallInt(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)) + 1);
                if TargeTBaseObject.m_btLifeAttrib = LA_UNDEAD then nPower := Round(nPower * 1.5);
                {$IF M2Version <> 2}
                if (TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT) or (TargeTBaseObject.m_btRaceServer = RC_HEROOBJECT) then begin
                  NGSecPwr:= 0;
                  if TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
                    NGSecPwr:= MagicManager.GetNGPow(TargeTBaseObject, TPlayObject(TargeTBaseObject).m_MagicSkill_223,nPower);//静之雷电
                  end else
                  if TargeTBaseObject.m_btRaceServer = RC_HEROOBJECT then begin
                    NGSecPwr:= MagicManager.GetNGPow(TargeTBaseObject, THEROOBJECT(TargeTBaseObject).m_MagicSkill_223,nPower);//静之雷电
                  end;
                  nPower := _MAX(0, nPower - NGSecPwr);
                end;
                {$IFEND}
                SendDelayMsg(Self, RM_DELAYMAGIC, nPower, MakeLong(nTargetX, nTargetY), 2, Integer(TargeTBaseObject), '', 600);
                Result := True;
              end else TargeTBaseObject := nil;
            end else TargeTBaseObject := nil;
          end; 
        end;
      SKILL_SHIELD {31},SKILL_66 {66}: begin //魔法盾 四级魔法盾 20080728
          if MagBubbleDefenceUp(UserMagic.btLevel, GetPower(GetRPow(m_WAbil.MC) + 15)) then Result := True;
        end;
      SKILL_73 {73}: begin //道力盾  20080405
        if MagBubbleDefenceUp(UserMagic.btLevel, GetPower(GetRPow(m_WAbil.SC) + 15)) then Result := True;
       end;
      SKILL_SNOWWIND {33}: begin // 冰咆哮 
          if MagicManager.MagBigExplosion(Self,
            GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.MC), SmallInt(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)) + 1),
            nTargetX,
            nTargetY,
            g_Config.nSnowWindRange, SKILL_SNOWWIND) then
            Result := True;
        end;
      SKILL_LIGHTFLOWER {24}: begin //地狱雷光
          if MagicManager.MagElecBlizzard(Self, GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.MC), SmallInt(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)) + 1)) then
            Result := True;
        end;
      SKILL_MOOTEBO{27}: begin //野蛮冲撞
         Result := True;
         boSpellFire := False;//20081108
         if GetAttackDir(TargeTBaseObject,m_btDirection) then begin//野蛮冲撞的方向
           nSpellPoint := GetSpellPoint(UserMagic);
           if m_WAbil.MP >= nSpellPoint then begin
             if nSpellPoint > 0 then begin
               DamageSpell(nSpellPoint);
               HealthSpellChanged();
             end;
             if DoMotaebo(m_btDirection, UserMagic.btLevel) then begin
               if UserMagic.btLevel < 3 then begin
                 if UserMagic.MagicInfo.TrainLevel[UserMagic.btLevel] < m_Abil.Level then begin
                   TrainSkill(UserMagic, Random(3) + 1);
                   CheckMagicLevelup(UserMagic);
                 end;
               end;
             end;
           end;
         end;
      end;    
      SKILL_MABE :begin//火焰冰 20080410
          with Self do begin
            nPower := GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.MC),
              SmallInt(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)) + 1);
          end;
          if MabMabe(Self, TargeTBaseObject, nPower, UserMagic.btLevel, nTargetX, nTargetY) then Result := True;
        end;
      SKILL_45: begin //灭天火 20080410
          if MagMakeFireDay(Self, UserMagic, nTargetX, nTargetY, TargeTBaseObject) then Result := True;
        end;
      SKILL_47: begin //火龙焰
          if MagicManager.MagBigExplosion(Self,
            GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.MC), SmallInt(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)) + 1),
            nTargetX,
            nTargetY,
            g_Config.nFireBoomRage {1},SKILL_47) then
            Result := True;
        end;
      SKILL_58, SKILL_92: begin //流星火雨,四级流星火雨
          if MagicManager.MagBigExplosion1(self,
            GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.MC), SmallInt(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)) + 1),
            nTargetX, nTargetY, g_Config.nMeteorFireRainRage, TargeTBaseObject, False, UserMagic.MagicInfo.wMagicId) then Result := True;
        end;
      SKILL_EARTHFIRE {22}: begin //火墙
          nPower := GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.MC),
            SmallInt(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)) + 1);
          nDelayTime := GetPower(10) + (Word(GetRPow(m_WAbil.MC)) shr 1);
          //火墙威力和时间的倍数
          nPowerRate := Round(nPower * (g_Config.nFirePowerRate / 100));
          nDelayTimeRate := Round(nDelayTime * (g_Config.nFireDelayTimeRate / 100));
          if MagicManager.MagMakeFireCross(self, nPowerRate, nDelayTimeRate, nTargetX, nTargetY, 0) > 0 then Result := True;
        end;
      SKILL_FIREBOOM {23}: begin //爆裂火焰
          if MagicManager.MagBigExplosion(self,
            GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.MC), SmallInt(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)) + 1),
            nTargetX, nTargetY,
            g_Config.nFireBoomRage {1}, SKILL_FIREBOOM) then Result := True;
        end;
      SKILL_FIREBALL {1},//火球术
      SKILL_FIREBALL2 {5}: begin //大火球
          if MagicManager.MagMakeFireball(self, UserMagic,nTargetX, nTargetY, TargeTBaseObject) then Result := True;
        end;
      SKILL_FIRE {9}: begin //地狱火
          if MagicManager.MagMakeHellFire(self, UserMagic, nTargetX, nTargetY, TargeTBaseObject) then Result := True;
        end;
      SKILL_SHOOTLIGHTEN {10}: begin //疾光电影
          if MagicManager.MagMakeQuickLighting(self, UserMagic, nTargetX, nTargetY, TargeTBaseObject) then Result := True;
        end;
      {道士}
      SKILL_AMYOUNSUL{6}, SKILL_93{93}: begin //施毒术,四级施毒术
          if MagicManager.MagLightening(Self, UserMagic, nTargetX, nTargetY, TargeTBaseObject, boSpellFail) then Result := True;
          boSpellFire:= False;//20091218 在子过程中发消息
        end;
      SKILL_50:begin//无极真气 20080405
          if AbilityUp(UserMagic) then Result := True;
        end;
      SKILL_51: begin //飓风破 20080917
          if MagicManager.MagGroupFengPo(Self, UserMagic, nTargetX, nTargetY, TargeTBaseObject) then Result := True;
        end;
      SKILL_48: begin //气功波 20090111
          if MagicManager.MagPushArround(self, UserMagic.btLevel, True, UserMagic) > 0 then Result := True;
        end;
      SKILL_FIREWIND: begin //抗拒火环 20090207
          if MagicManager.MagPushArround(self, UserMagic.btLevel, False, UserMagic) > 0 then Result := True;
        end;
      SKILL_FIRECHARM {13},
      SKILL_HANGMAJINBUB {14},
      SKILL_DEJIWONHO {15},
      SKILL_59{59},
      SKILL_94{94}: begin
          boSpellFail := True;
          if CheckAmulet(Self, 1, 1, nAmuletIdx) then begin
            UseAmulet(Self, 1, 1, nAmuletIdx);
            case wMagIdx of
              SKILL_FIRECHARM{13}: begin //灵魂火符
                  if MagicManager.MagMakeFireCharm(Self, UserMagic, nTargetX, nTargetY, TargeTBaseObject) then Result := True;
                end;
              SKILL_HANGMAJINBUB{14}: begin //幽灵盾
                  nPower := GetAttackPower(GetPower13(60) + LoWord(m_WAbil.SC) * 10, SmallInt(HiWord(m_WAbil.SC) - LoWord(m_WAbil.SC)) + 1);
                  if MagMakeDefenceArea(nTargetX, nTargetY, 3, nPower, 1) > 0 then
                    Result := True;
                end;
              SKILL_DEJIWONHO{15}: begin //神圣战甲术
                  nPower := GetAttackPower(GetPower13(60) + LoWord(m_WAbil.SC) * 10, SmallInt(HiWord(m_WAbil.SC) - LoWord(m_WAbil.SC)) + 1);
                  if MagMakeDefenceArea(nTargetX, nTargetY, 3, nPower, 0) > 0 then Result := True;
                end;
              SKILL_59, SKILL_94: begin//噬血术,四级噬血术
                  if MagicManager.MagFireCharmTreatment(self,UserMagic, nTargetX, nTargetY, TargeTBaseObject) then Result := True;
                end;
            end;
            boSpellFail := False;
            DelUseItem();
          end;
        end;
      SKILL_GROUPAMYOUNSUL {38 群体施毒术}: begin
          boSpellFail := True;
          if CheckAmulet(Self, 1, 2, nAmuletIdx) then begin
            UseAmulet(Self, 1, 2, nAmuletIdx);
            if MagicManager.MagGroupAmyounsul(Self, UserMagic, nTargetX, nTargetY, TargeTBaseObject) then Result := True;
            boSpellFail := False;
            DelUseItem();
          end;
        end;
      SKILL_BIGHEALLING {29}: begin //群体治疗术
          nPower := GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.SC) * 2,
            SmallInt(HiWord(m_WAbil.SC) - LoWord(m_WAbil.SC)) * 2 + 1);
          if MagicManager.MagBigHealing(Self, nPower, nTargetX, nTargetY, UserMagic) then Result := True;
        end;
    end;
    m_dwActionTick := GetTickCount();//20080715
    m_dwHitTick := GetTickCount();//20080715
    m_boAutoAvoid:= True;//是否能躲避 20080715
    
    if boSpellFire then begin
      if UserMagic.btLevel= 4 then begin//4级技能 灭天火 火符 20080617
        case wMagIdx of
          SKILL_45: SendRefMsg(RM_MAGICFIRE, 0, MakeWord(UserMagic.MagicInfo.btEffectType, 101),MakeLong(nTargetX, nTargetY),Integer(TargeTBaseObject),'');
          SKILL_FIRECHARM: SendRefMsg(RM_MAGICFIRE, 0, MakeWord(UserMagic.MagicInfo.btEffectType, 100),MakeLong(nTargetX, nTargetY),Integer(TargeTBaseObject),'');
          else SendRefMsg(RM_MAGICFIRE, 0, MakeWord(UserMagic.MagicInfo.btEffectType, UserMagic.MagicInfo.btEffect), MakeLong(nTargetX, nTargetY),Integer(TargeTBaseObject),'');
        end;
      end else
      SendRefMsg(RM_MAGICFIRE, 0,
        MakeWord(UserMagic.MagicInfo.btEffectType, UserMagic.MagicInfo.btEffect),
        MakeLong(nTargetX, nTargetY),
        Integer(TargeTBaseObject),
        '');
    end;
  end;
var
  BaseObject: TBaseObject;
  I: Integer;
  nSpellPoint: Integer;
  UserMagic: pTUserMagic;
  nNewTargetX: Integer;
  nNewTargetY: Integer;
begin
  Result := False;
  Try
    case wMagIdx of
      SKILL_ERGUM{12}: begin //刺杀剑法
          if m_MagicErgumSkill <> nil then begin
            if not m_boUseThrusting then begin
              m_boUseThrusting := True;
            end else begin
              m_boUseThrusting := False;
            end;
          end;
          Result := True;
        end;
      SKILL_89{89}: begin //四级刺杀
          if m_Magic89Skill <> nil then begin
            if not m_boUseThrusting then begin
              m_boUseThrusting := True;
            end else begin
              m_boUseThrusting := False;
            end;
          end;
          Result := True;
        end;
      SKILL_BANWOL{25}: begin //半月弯刀
          if m_MagicBanwolSkill <> nil then begin
            if not m_boUseHalfMoon then begin
              m_boUseHalfMoon := True;
            end else begin
              m_boUseHalfMoon := False;
            end;
          end;
          Result := True;
          Exit;
        end;
      SKILL_90{90}: begin //圆月弯刀(四级半月弯刀)
          if m_Magic90Skill <> nil then begin
            if not m_boUseHalfMoon then begin
              m_boUseHalfMoon := True;
            end else begin
              m_boUseHalfMoon := False;
            end;
          end;
          Result := True;
          Exit;
        end;
      SKILL_FIRESWORD {26}: begin //烈火剑法
          if m_MagicFireSwordSkill <> nil then begin
            if AllowFireHitSkill then begin
              nSpellPoint := GetSpellPoint(m_MagicFireSwordSkill);
              if m_WAbil.MP >= nSpellPoint then begin
                if nSpellPoint > 0 then begin
                  DamageSpell(nSpellPoint);
                  //HealthSpellChanged();
                end;
              end;
            end;
          end;
          Result := True;
          Exit;
        end;
      SKILL_74 :begin////逐日剑法 20080511
          if m_Magic74Skill <> nil then begin
            if AllowDailySkill then begin
              nSpellPoint := GetSpellPoint(m_Magic74Skill);
              if m_WAbil.MP >= nSpellPoint then begin
                if nSpellPoint > 0 then begin
                  DamageSpell(nSpellPoint);
                  //HealthSpellChanged();
                end;
              end;
            end;
          end;
          Result := True;
          Exit;
        end;
      SKILL_96: begin//血魄一击(战)
          if g_Config.dwNotGNDecHPRate > 0 then begin
            DamageHealth(Abs(Round(m_WAbil.HP * (g_Config.dwNotGNDecHPRate / 100))));
            HealthSpellChanged();
            m_boBloodSoulSkill := True;
          end;
          Result := True;
          Exit;
        end;
      SKILL_42: begin //开天斩
          if m_Magic42Skill <> nil then begin
            if Skill42OnOff then begin
              nSpellPoint := GetSpellPoint(m_Magic42Skill{UserMagic});//20080522
              if m_WAbil.MP >= nSpellPoint then begin
                if nSpellPoint > 0 then begin
                  DamageSpell(nSpellPoint);
                  HealthSpellChanged();
                end;
              end;
            end;
          end;
          Result := True;
          Exit;
        end;
      SKILL_43: begin //龙影剑法
          if m_Magic43Skill <> nil then begin
            if Skill43OnOff then begin//20080619
              nSpellPoint := GetSpellPoint(UserMagic);
              if m_WAbil.MP >= nSpellPoint then begin
                if nSpellPoint > 0 then begin
                  DamageSpell(nSpellPoint);
                  HealthSpellChanged();
                end;
              end;
            end;
          end;
          Result := True;
          Exit;
       end;
      SKILL_40: begin //抱月刀法
          if m_MagicCrsSkill <> nil then begin
            if not m_boCrsHitkill then begin
              SkillCrsOnOff(True);
            end else begin
              SkillCrsOnOff(False);
            end;
          end;
          Result := True;
          Exit;
        end;
      else begin {使用魔法}
        nNewTargetX := 0;//20080522
        nNewTargetY := 0;//20080522
        if m_MagicList.Count > 0 then begin//20080630
          for I := 0 to m_MagicList.Count - 1 do begin
            UserMagic := m_MagicList.Items[I];
            if (UserMagic <> nil) and (UserMagic.wMagIdx = wMagIdx) then begin
              m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
              BaseObject := nil;
                //检查目标角色，与目标座标误差范围，如果在误差范围内则修正目标座标
              if CretInNearXY(m_TargetCret, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY) then begin
                BaseObject := m_TargetCret;
                nNewTargetX := BaseObject.m_nCurrX;
                nNewTargetY := BaseObject.m_nCurrY;
              end;
              if wMagIdx in [SKILL_DEJIWONHO,SKILL_HANGMAJINBUB] then begin //如果是 神圣战甲术,幽灵盾,则把目标设置为自己  20080610 原还注释
                BaseObject := Self;
                nNewTargetX := m_nCurrX;
                nNewTargetY := m_nCurrY;
              end;
              Result := DoSpell(UserMagic, nNewTargetX, nNewTargetY, BaseObject);
              Break;
            end;
          end;//for
        end;
      end;
    end;
  except
  end;
end;

function TPlayMonster.WarrAttackTarget(wHitMode: Word): Boolean; {物理攻击}
var
  bt06: Byte;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if (m_TargetCret.m_btRaceServer = RC_HEROOBJECT) and (m_TargetCret.m_Abil.Level <= 22) and (THEROOBJECT(m_TargetCret).m_btStatus = 1) then  begin//20080510 英雄22级前,跟随时不打
       DelTargetCreat();
       Exit;
    end else
    if m_boProtectStatus then begin //守护状态 20090105
      if (abs(m_nCurrX - m_nProtectTargetX) > 13) or (abs(m_nCurrY - m_nProtectTargetY) > 13) then begin
        DelTargetCreat();
        Exit;
      end;
    end;
    if GetAttackDir(m_TargetCret, bt06) then begin
      m_dwTargetFocusTick := GetTickCount();
      Attack(m_TargetCret, bt06);
      BreakHolySeizeMode();
      Result := True;
    end else begin                              
      if (m_TargetCret.m_PEnvir = m_PEnvir) then begin
        if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 12) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 12) then begin //20080605 增加
          SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
        end;
      end else begin
        DelTargetCreat();
      end;
    end;
  end;
end;

procedure TPlayMonster.EatMedicine(); {吃药}
var
  n01: Integer;
begin
  if (m_nCopyHumanLevel > 0) and (m_ItemList.Count > 0) then begin
    if m_WAbil.HP < (m_WAbil.MaxHP * g_Config.nCopyHumAddHPRate) div 100 then begin
      n01 := 0;
      while m_WAbil.HP < m_WAbil.MaxHP do begin {增加连续吃三瓶}
        if n01 >= 2 then Break;
        EatUseItems(0);
        if m_ItemList.Count = 0 then Break;
        Inc(n01);
      end;
    end;
    if m_WAbil.MP < (m_WAbil.MaxMP * g_Config.nCopyHumAddMPRate) div 100 then begin
      n01 := 0;
      while m_WAbil.MP < m_WAbil.MaxMP do begin {增加连续吃三瓶}
        if n01 >= 2 then Break;
        EatUseItems(1);
        if m_ItemList.Count = 0 then Break;
        Inc(n01);
      end;
    end;
    {if (m_ItemList.Count = 0) or (m_WAbil.HP < (m_WAbil.MaxHP * 20) div 100) or (m_WAbil.MP < (m_WAbil.MaxMP * 20) div 100) then begin
      if m_VisibleItems.Count > 0 then begin
        //m_boPickUpItemOK := False;//20080428 注释
        SearchPickUpItem(500);
      end;
    end; } //20101027 注释
  end;
end;

{检测指定方向和范围内坐标的怪物数量}
function TPlayMonster.CheckTargetXYCountOfDirection(nX, nY, nDir, nRange: Integer): Integer;
var
  BaseObject: TBaseObject;
  I: Integer;
begin
  Result := 0;
  if m_VisibleActors.Count > 0 then begin//20080630
    for I := 0 to m_VisibleActors.Count - 1 do begin
      BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
      if BaseObject <> nil then begin
        if not BaseObject.m_boDeath then begin
          if IsProperTarget(BaseObject) and
            (not BaseObject.m_boHideMode or m_boCoolEye) then begin
            case nDir of
              DR_UP: begin
                  if (abs(nX - BaseObject.m_nCurrX) <= nRange) and ((BaseObject.m_nCurrY - nY) in [0, nRange]) then Inc(Result);
                end;
              DR_UPRIGHT: begin
                  if ((BaseObject.m_nCurrX - nX) in [0, nRange]) and ((BaseObject.m_nCurrY - nY) in [0, nRange]) then Inc(Result);
                end;
              DR_RIGHT: begin
                  if ((BaseObject.m_nCurrX - nX) in [0, nRange]) and (abs(nY - BaseObject.m_nCurrY) <= nRange) then Inc(Result);
                end;
              DR_DOWNRIGHT: begin
                  if ((BaseObject.m_nCurrX - nX) in [0, nRange]) and ((nY - BaseObject.m_nCurrY) in [0, nRange]) then Inc(Result);
                end;
              DR_DOWN: begin
                  if (abs(nX - BaseObject.m_nCurrX) <= nRange) and ((nY - BaseObject.m_nCurrY) in [0, nRange]) then Inc(Result);
                end;
              DR_DOWNLEFT: begin
                  if ((nX - BaseObject.m_nCurrX) in [0, nRange]) and ((nY - BaseObject.m_nCurrY) in [0, nRange]) then Inc(Result);
                end;
              DR_LEFT: begin
                  if ((nX - BaseObject.m_nCurrX) in [0, nRange]) and (abs(nY - BaseObject.m_nCurrY) <= nRange) then Inc(Result);
                end;
              DR_UPLEFT: begin
                  if ((nX - BaseObject.m_nCurrX) in [0, nRange]) and ((BaseObject.m_nCurrY - nY) in [0, nRange]) then Inc(Result);
                end;
            end;
            if Result > 2 then Break;
          end;
        end;
      end;
    end;
  end;
end;
//战士攻击 有待进一步优化
function TPlayMonster.WarrorAttackTarget(): Boolean;
  procedure SelectMagic();
  begin
    {$IF M2Version <> 2}
    if (wSKILL_69 > 0) and ((GetTickCount -  m_dwLatest69Tick) > g_Config.nKill69UseTime * 1000) then begin//倚天辟地
      m_dwLatest69Tick:= GetTickCount();
      DoSpellMagic(SKILL_69);
      Exit;
    end;
    if (not m_boBloodSoulSkill) and (abs(m_TargetCret.m_nCurrX - m_nCurrX) < 3) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) < 3) and //两格才放血魄一击(战)
       (wSKILL_96 > 0) and ((GetTickCount - m_dwLatestBloodSoulTick) > g_Config.dwUseBloodSoulTick) then begin//血魄一击(战)
        m_dwLatestBloodSoulTick := GetTickCount;
        DoSpellMagic(SKILL_96);
        Exit;
    end;
    {$IFEND}
    //远距离则用开天重击或是逐日剑法 20081211
    if ((abs(m_TargetCret.m_nCurrX - m_nCurrX) > 1{2}) and (abs(m_TargetCret.m_nCurrX - m_nCurrX) <= 5)) or //20090105 修改,等于或小于5
      ((abs(m_TargetCret.m_nCurrY - m_nCurrY) > 1{2}) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) <= 5)) then begin
      if (wSKILL_42 > 0) and ((GetTickCount - m_dwLatest42Tick) > g_Config.nKill43UseTime * 1000) then begin
        m_n42kill := 2;//重击
        if not m_bo42kill then DoSpellMagic(SKILL_42); //打开开天
        m_nSelectMagic:= 43;//查询魔法 20081206
        if m_bo42kill then Exit;
      end;
      if (wSKILL_74 > 0) and ((GetTickCount - m_dwLatestDailyTick) > 12000{12 * 1000}) then begin //逐日剑法
        if not m_boDailySkill then DoSpellMagic(SKILL_74);//打开逐日剑法
        m_nSelectMagic:= 74;//查询魔法 20081206
        Exit;
      end;
    end;
    //刺杀位 20081204
    if (abs(m_TargetCret.m_nCurrX - m_nCurrX) = 2) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 2) then begin
      if (wSkill_89 > 0) then begin //四级刺杀剑术
        if not m_boUseThrusting then DoSpellMagic(Skill_89);
        m_nSelectMagic:= Skill_89;
        exit;
      end;
      if (wSkill_12 > 0) then begin //刺杀剑术
        if not m_boUseThrusting then DoSpellMagic(SKILL_ERGUM);
        m_nSelectMagic:= 12;//查询魔法 20081206
        exit;
      end;
    end;
    
    if (wSKILL_42 > 0) and ((GetTickCount - m_dwLatest42Tick) > g_Config.nKill43UseTime * 1000) then begin //开天斩  20080203
       if Random(g_Config.n43KillHitRate) = 0 then begin  //增加 开天轻击 20080213
         m_n42kill := 2;
       end else begin
         m_n42kill := 1;
       end;
       if not m_bo42kill then DoSpellMagic(SKILL_42); //打开开天
       m_nSelectMagic:= 43;//查询魔法 20081206
       if m_bo42kill then Exit;
    end;
    if (SKILL_43 > 0) and ((GetTickCount - m_dwLatest43Tick) > g_Config.nKill42UseTime * 1000) then begin//20080619 龙影剑法
      if not m_bo43kill then DoSpellMagic(SKILL_43);
      if m_bo43kill then Exit;
    end;

    if m_boFireHitSkill then DoSpellMagic(SKILL_FIRESWORD );//关闭烈火
    if m_boUseThrusting then begin
      if (wSKILL_89 > 0) then DoSpellMagic(SKILL_89)//关闭刺杀
      else if (wSKILL_12 > 0) then DoSpellMagic(SKILL_ERGUM);//关闭刺杀
    end;
    if m_boUseHalfMoon then begin
      if (wSKILL_90 > 0) then DoSpellMagic(SKILL_90)
      else DoSpellMagic(SKILL_BANWOL);     //关闭半月
    end;
    if m_boCrsHitkill then DoSpellMagic(SKILL_40);          //关闭刀法
    if m_boDailySkill then DoSpellMagic(SKILL_74);          //关闭逐日剑法 20080528 20080619 注释
    if (abs(m_TargetCret.m_nCurrX - m_nCurrX) <= 2) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) <= 2) then begin//目标近身时
      case Random(5) of
        0:begin
           if (wSkill_11 > 0) then begin
             DoSpellMagic(SKILL_FIRESWORD); //使用烈火
             m_nSelectMagic:= 26;//查询魔法 20081206
           end else if (wSKILL_74 > 0) then begin
             DoSpellMagic(SKILL_74);//打开逐日剑法 20080528
             m_nSelectMagic:= 74;//查询魔法 20081206
           end else if (wSkill_89 > 0) then begin
             DoSpellMagic(Skill_89);//打开刺杀
             m_nSelectMagic:= Skill_89;
           end else if (wSkill_12 > 0) then begin
             DoSpellMagic(SKILL_ERGUM);//打开刺杀
             m_nSelectMagic:= 12;//查询魔法 20081206
           end else if (wSkill_90 > 0) then begin
             DoSpellMagic(Skill_90);//打开圆月弯刀
             m_nSelectMagic:= Skill_90;
           end else if (wSkill_13 > 0) then begin
             DoSpellMagic(SKILL_BANWOL);//打开半月
             m_nSelectMagic:= 25;//查询魔法 20081206
           end else if (wSKILL_40 > 0) then DoSpellMagic(SKILL_40);//抱月刀法
        end;
        1:begin
           if (wSKILL_74 > 0) then begin
             DoSpellMagic(SKILL_74);//打开逐日剑法 20080528
             m_nSelectMagic:= 74;//查询魔法 20081206
           end else if (wSkill_89 > 0) then begin
             DoSpellMagic(Skill_89);//打开刺杀
             m_nSelectMagic:= Skill_89;
           end else if (wSkill_12 > 0) then begin
             DoSpellMagic(SKILL_ERGUM);//打开刺杀
             m_nSelectMagic:= 12;//查询魔法 20081206
           end else if (wSkill_90 > 0) then begin
             DoSpellMagic(Skill_90);//打开圆月弯刀
             m_nSelectMagic:= Skill_90;
           end else if (wSkill_13 > 0) then begin
             DoSpellMagic(SKILL_BANWOL);//打开半月
             m_nSelectMagic:= 25;//查询魔法 20081206
           end else if (wSKILL_40 > 0) then DoSpellMagic(SKILL_40)        //抱月刀法
           else if (wSkill_11 > 0) then begin
             DoSpellMagic(SKILL_FIRESWORD);//使用烈火
             m_nSelectMagic:= 26;//查询魔法 20081206
           end;
        end;
        2:begin
           if (wSkill_89 > 0) then begin
             DoSpellMagic(Skill_89);//打开刺杀
             m_nSelectMagic:= Skill_89;
           end else if (wSkill_12 > 0) then begin
             DoSpellMagic(SKILL_ERGUM);//打开刺杀
             m_nSelectMagic:= 12;//查询魔法 20081206
           end else if (wSkill_90 > 0) then begin
             DoSpellMagic(Skill_90);//打开圆月弯刀
             m_nSelectMagic:= Skill_90;
           end else if (wSkill_13 > 0) then begin
             DoSpellMagic(SKILL_BANWOL);//打开半月
             m_nSelectMagic:= 25;//查询魔法 20081206
           end else if (wSKILL_40 > 0) then DoSpellMagic(SKILL_40)        //抱月刀法
           else if (wSkill_11 > 0) then begin
             DoSpellMagic(SKILL_FIRESWORD); //使用烈火
             m_nSelectMagic:= 26;//查询魔法 20081206
           end else if (wSKILL_74 > 0) then begin
             DoSpellMagic(SKILL_74);//打开逐日剑法 20080528
             m_nSelectMagic:= 74;//查询魔法 20081206
           end;  
        end;
        3:begin
           if (wSkill_90 > 0) then begin
             DoSpellMagic(Skill_90);//打开圆月弯刀
             m_nSelectMagic:= Skill_90;
           end else if (wSkill_13 > 0) then begin
             DoSpellMagic(SKILL_BANWOL);//打开半月
             m_nSelectMagic:= 25;//查询魔法 20081206
           end else if (wSKILL_40 > 0) then DoSpellMagic(SKILL_40)//抱月刀法
           else if (wSkill_11 > 0) then begin
             DoSpellMagic(SKILL_FIRESWORD);//使用烈火
             m_nSelectMagic:= 26;//查询魔法 20081206
           end else if (wSKILL_74 > 0) then begin
             DoSpellMagic(SKILL_74);//打开逐日剑法 20080528
             m_nSelectMagic:= 74;//查询魔法 20081206
           end else if (wSkill_89 > 0) then begin
             DoSpellMagic(Skill_89);//打开刺杀
             m_nSelectMagic:= Skill_89;
           end else if (wSkill_12 > 0) then begin
             DoSpellMagic(SKILL_ERGUM);    //打开刺杀
             m_nSelectMagic:= 12;//查询魔法 20081206
           end;
        end;
        4:begin
           if (wSKILL_40 > 0) then DoSpellMagic(SKILL_40)            //抱月刀法
           else if (wSkill_11 > 0) then begin
             DoSpellMagic(SKILL_FIRESWORD);//使用烈火
             m_nSelectMagic:= 26;//查询魔法 20081206
           end else if (wSKILL_74 > 0) then begin
             DoSpellMagic(SKILL_74);//打开逐日剑法 20080528
             m_nSelectMagic:= 74;//查询魔法 20081206
           end else if (wSkill_89 > 0) then begin
             DoSpellMagic(Skill_89);//打开刺杀
             m_nSelectMagic:= Skill_89;             
           end else if (wSkill_12 > 0) then begin
             DoSpellMagic(SKILL_ERGUM);//打开刺杀
             m_nSelectMagic:= 12;//查询魔法 20081206
           end else if (wSkill_90 > 0) then begin
             DoSpellMagic(Skill_90);//打开圆月弯刀
             m_nSelectMagic:= Skill_90;
           end else if (wSkill_13 > 0) then begin
             DoSpellMagic(SKILL_BANWOL); //打开半月
             m_nSelectMagic:= 25;//查询魔法 20081206
           end;
        end;
      end;//Case Random(4) of
    end else begin//目标不近身
      case Random({5}4) of//20080619
        0:begin
           if (wSkill_11 > 0) then begin
             DoSpellMagic(SKILL_FIRESWORD); //使用烈火
             m_nSelectMagic:= 26;//查询魔法 20081206
           //else if (wSKILL_43 > 0) then DoSpellMagic(SKILL_43)    //打开龙影   20080619 注释
           end else if (wSKILL_74 > 0) then begin
             DoSpellMagic(SKILL_74);//打开逐日剑法 20080528
             m_nSelectMagic:= 74;//查询魔法 20081206
           end else if (wSkill_90 > 0) then begin
             DoSpellMagic(Skill_90);//打开圆月弯刀
             m_nSelectMagic:= Skill_90;
           end else if (wSkill_13 > 0) then begin
             DoSpellMagic(SKILL_BANWOL);//打开半月
             m_nSelectMagic:= 25;//查询魔法 20081206
           end else if (wSKILL_40 > 0) then DoSpellMagic(SKILL_40);   //抱月刀法
        end;
        1:begin
           if (wSKILL_74 > 0) then begin
             DoSpellMagic(SKILL_74);//打开逐日剑法 20080528
             m_nSelectMagic:= 74;//查询魔法 20081206
           end else if (wSkill_90 > 0) then begin
             DoSpellMagic(Skill_90);//打开圆月弯刀
             m_nSelectMagic:= Skill_90;
           end else if (wSkill_13 > 0) then begin
             DoSpellMagic(SKILL_BANWOL);//打开半月
             m_nSelectMagic:= 25;//查询魔法 20081206
           end else if (wSKILL_40 > 0) then DoSpellMagic(SKILL_40)       //抱月刀法
           else if (wSkill_11 > 0) then begin
             DoSpellMagic(SKILL_FIRESWORD);//使用烈火
             m_nSelectMagic:= 26;//查询魔法 20081206
           end;
           //else if (wSKILL_43 > 0) then DoSpellMagic(SKILL_43);      //打开龙影  20080619 注释
        end;
        2:begin
           if (wSKILL_40 > 0) then DoSpellMagic(SKILL_40)             //抱月刀法
           else if (wSkill_11 > 0) then begin
             DoSpellMagic(SKILL_FIRESWORD); //使用烈火
             m_nSelectMagic:= 26;//查询魔法 20081206
           //else if (wSKILL_43 > 0) then DoSpellMagic(SKILL_43)        //打开龙影  20080619 注释
           end else if (wSKILL_74 > 0) then begin
             DoSpellMagic(SKILL_74);//打开逐日剑法 20080528
             m_nSelectMagic:= 74;//查询魔法 20081206
           end else if (wSkill_90 > 0) then begin
             DoSpellMagic(Skill_90);//打开圆月弯刀
             m_nSelectMagic:= Skill_90;
           end else if (wSkill_13 > 0) then begin
             DoSpellMagic(SKILL_BANWOL);   //打开半月
             m_nSelectMagic:= 25;//查询魔法 20081206
           end;
        end;
        3:begin
           if (wSkill_90 > 0) then begin
             DoSpellMagic(Skill_90);//打开圆月弯刀
             m_nSelectMagic:= Skill_90;
           end else if (wSkill_13 > 0) then begin
             DoSpellMagic(SKILL_BANWOL);//打开半月
             m_nSelectMagic:= 25;//查询魔法 20081206
           end else if (wSKILL_40 > 0) then DoSpellMagic(SKILL_40)       //抱月刀法
           else if (wSkill_11 > 0) then begin
             DoSpellMagic(SKILL_FIRESWORD);//使用烈火
             m_nSelectMagic:= 26;//查询魔法 20081206
           //else if (wSKILL_43 > 0) then DoSpellMagic(SKILL_43)      //打开龙影   20080619 注释
           end else if (wSKILL_74 > 0) then begin
             DoSpellMagic(SKILL_74);//打开逐日剑法 20080528
             m_nSelectMagic:= 74;//查询魔法 20081206
           end;  
        end;
      end;//Case Random(4) of
    end;
  end;
begin
  Result := False;
  try
    m_wHitMode := 0;
    if m_WAbil.MP > 0 then begin
      if not MagCanHitTarget(m_nCurrX, m_nCurrY, m_TargetCret) or ((abs(m_TargetCret.m_nCurrX - m_nCurrX) > 2) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 2)) then begin//魔法不能打到怪 20080420
         if (m_Master <> nil) and ((abs(m_Master.m_nCurrX - m_nCurrX) >= 7) or (abs(m_Master.m_nCurrY - m_nCurrY) >= 7)) then begin
           m_TargetCret:= nil;
           Exit;
         end else GotoTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      end;

      if (wSKILL_27 > 0) and ((GetTickCount - m_dwDoMotaeboTick) > 10000) and (m_WAbil.HP <= Round(m_WAbil.MaxHP * 0.8)) then begin
         if m_TargetCret <> nil then begin
           if (m_TargetCret.m_Abil.Level < m_Abil.Level) then begin
             m_dwDoMotaeboTick := GetTickCount();
             DoSpellMagic(wSkill_27);//野蛮冲撞 20081016
             Exit;
           end;
         end;
      end;

      SelectMagic();//20080405 修改

      if m_boUseThrusting then begin
        case m_nSelectMagic of
          12: m_wHitMode := 4; //使用刺杀
          SKILL_89: m_wHitMode := 15;//四级刺杀
        end;
      end else
      if m_boUseHalfMoon then begin
        case m_nSelectMagic of
          SKILL_BANWOL: m_wHitMode := 5;//使用半月
          SKILL_90: m_wHitMode := 16;//圆月弯刀
        end;
      end
      else if m_boCrsHitkill then m_wHitMode := 8//抱月弯刀 20080410
      else if m_bo43kill then m_wHitMode := 12//使用龙影剑法 20080201
      else if m_bo42kill then m_wHitMode := 9 //使用开天斩 20080201
      else if m_boFireHitSkill then m_wHitMode := 7 //使用烈火
      else if m_boDailySkill then m_wHitMode := 13 //使用逐日剑法 20080528
      else if m_boBloodSoulSkill then m_wHitMode := 17;
    end;
    Result := WarrAttackTarget(m_wHitMode);
    if Result then m_dwHitTick := GetTickCount();//20080715 增加
  except
  end;
end;
//检查使用的魔法
function TPlayMonster.CheckUserMagic(wMagIdx: Word): Integer;
var
  UserMagic: pTUserMagic;
  I: Integer;
begin
  Result := 0;
  if m_MagicList.Count > 0 then begin//20080630
    for I := 0 to m_MagicList.Count - 1 do begin
      UserMagic := m_MagicList.Items[I];
      if UserMagic.MagicInfo.wMagicId = wMagIdx then begin
        Result := wMagIdx;
        Break;
      end;
    end;
  end;
end;
//取指定坐标范围内的目标数量
function TPlayMonster.CheckTargetXYCount(nX, nY, nRange: Integer): Integer;
var
  BaseObject: TBaseObject;
  I, nC, n10: Integer;
begin
  Result := 0;
  n10 := nRange;
  if m_VisibleActors.Count > 0 then begin//20080630
    for I := 0 to m_VisibleActors.Count - 1 do begin
      BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
      if BaseObject <> nil then begin
        if not BaseObject.m_boDeath then begin
          if IsProperTarget(BaseObject) and
            (not BaseObject.m_boHideMode or m_boCoolEye) then begin
            nC := abs(nX - BaseObject.m_nCurrX) + abs(nY - BaseObject.m_nCurrY);
            if nC <= n10 then begin
              Inc(Result);
              if Result > 2 then Break;
            end;
          end;
        end;
      end;
    end;
  end;
end;

//气功波，抗拒火环使用 20090302
function TPlayMonster.CheckTargetXYCount3(nX, nY, nRange, nCount: Integer): Integer;
var
  BaseObject: TBaseObject;
  I, n10: Integer;
begin
  Result := 0;
  n10 := nRange;
  if m_VisibleActors.Count > 0 then begin
    for I := 0 to m_VisibleActors.Count - 1 do begin
      BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
      if BaseObject <> nil then begin
        if not BaseObject.m_boDeath then begin
          if IsProperTarget(BaseObject) and (not BaseObject.m_boHideMode or m_boCoolEye) then begin
            if (abs(nX - BaseObject.m_nCurrX) <= n10) and (abs(nY - BaseObject.m_nCurrY) <= n10) then begin
              Inc(Result);
              if Result > nCount then Break;
            end;
          end;
        end;
      end;
    end;
  end;
end;

function TPlayMonster.WizardAttackTarget(): Boolean; {法师攻击}
  function SearchDoSpell: Integer;
  begin
    Result := 0;
    {$IF M2Version <> 2}
    if (wSKILL_69 > 0) and ((GetTickCount -  m_dwLatest69Tick) > g_Config.nKill69UseTime * 1000) then begin//倚天辟地
      m_dwLatest69Tick:= GetTickCount();
      Result := wSKILL_69;
      Exit;
    end;
    if (wSKILL_97 > 0) and ((GetTickCount - m_dwLatestBloodSoulTick) > g_Config.dwUseBloodSoulTick) then begin//血魄一击(法)
      m_dwLatestBloodSoulTick := GetTickCount;
      Result := wSKILL_97;
      Exit;
    end;
    {$IFEND}
    if (m_wStatusTimeArr[STATE_BUBBLEDEFENCEUP ] = 0) and (not m_boAbilMagBubbleDefence) then begin{使用 魔法盾}
      if (wSkill_66 > 0) then begin
        Result := wSkill_66;
        Exit;
      end else
      if (wSkill_05 > 0) then begin
        Result := wSkill_05;
        Exit;
      end;
    end;
    if wSkill_15 > 0 then begin
      if (CheckTargetXYCount3(m_nCurrX, m_nCurrY, 1, 0) > 0) and (m_TargetCret.m_WAbil.Level < m_WAbil.Level)//20090508 修改 抗拒火环只能对等级低于自己的目标
        and (GetTickCount - m_nSkill_8Tick > 5000) then begin//抗拒火环 20090207
        m_nSkill_8Tick:= GetTickCount();
        Result := wSkill_15;
        Exit;
      end;
    end;
    if wSkill_22 > 0 then begin
      if (GetTickCount - m_nSkill_22Tick > 10000) then begin
        if (m_TargetCret.m_btRaceServer <> 101) and (m_TargetCret.m_btRaceServer <> 102) and (m_TargetCret.m_btRaceServer <> 104) then begin//除祖玛怪,才放火墙
          m_nSkill_22Tick:= GetTickCount();
          Result := wSkill_22;
          Exit;
        end;
      end;
    end;
    if CheckTargetXYCount(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 3) > 1 then begin//取指定坐标范围内的目标数量
      if (abs(m_TargetCret.m_nCurrX - m_nCurrX) <= 1) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) <= 1) then begin
        if (m_Master <> nil) and (wSkill_02 > 0) then begin//人形怪使用地狱雷光
           if m_TargetCret.m_btRaceServer in [91,92,97,101,102,104] then begin
             Result := wSkill_02;
             Exit;
           end;
        end;
        if (wSkill_02 > 0) and (m_Master = nil) then Result := wSkill_02
        else if wSkill_03 > 0 then Result := wSkill_03
        else if wSkill_04 > 0 then Result := wSkill_04
        else if wSKILL_91 > 0 then Result := wSKILL_91
        else if wSkill_01 > 0 then Result := wSkill_01
        else if wSKILL_45 > 0 then Result := wSKILL_45
        else if wSKILL_23 > 0 then Result := wSKILL_23
        else if wSkill_5 > 0 then Result := wSkill_5
        else if wSkill_1 > 0 then Result := wSkill_1;
        if (Result < 6) and ((wSkill_9 > 0) or (wSkill_10 > 0)) then begin
          if ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)<=4) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)=0)) or
             ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=0) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)<=4)) or
             ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=1) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)=1)) or
             ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=2) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)=2)) or
             ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=3) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)=3)) or
             ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=4) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)=4)) then begin
            if wSkill_10 > 0 then Result := wSkill_10
            else if wSkill_9 > 0 then Result := wSkill_9;
          end;
        end;
        Exit;
      end else begin
        if (wSkill_03 > 0) and (wSkill_04 > 0) and (wSKILL_45 > 0) and (wSKILL_36 > 0) and ((wSKILL_58 > 0) or (wSKILL_92 > 0)) then begin
          case Random(5) of
            0: Result := wSkill_03;
            1: Result := wSkill_04;
            2: Result := wSKILL_45;
            3: Result := wSKILL_36;
            4: begin
              if wSKILL_92 > 0 then Result := wSKILL_92
              else Result := wSKILL_58;
            end;
          end;
          Exit;
        end else begin
          case Random(6) of
            0:begin
                if wSKILL_45 > 0 then Result := wSKILL_45 //20080410
                else if wSkill_03 > 0 then Result := wSkill_03
                else if wSkill_04 > 0 then Result := wSkill_04
                else if wSkill_36 > 0 then Result := wSkill_36
                else if wSKILL_92 > 0 then Result := wSKILL_92
                else if wSkill_58 > 0 then Result := wSkill_58
                else if wSKILL_91 > 0 then Result := wSKILL_91
                else if wSkill_01 > 0 then Result := wSkill_01
                else if wSKILL_23 > 0 then Result := wSKILL_23
                else if wSkill_5 > 0 then Result := wSkill_5
                else if wSkill_1 > 0 then Result := wSkill_1;
             end;
            1:begin
               if wSkill_03 > 0 then Result := wSkill_03
               else if wSkill_04 > 0 then Result := wSkill_04
               else if wSkill_36 > 0 then Result := wSkill_36
               else if wSKILL_92 > 0 then Result := wSKILL_92
               else if wSkill_58 > 0 then Result := wSkill_58
               else if wSKILL_91 > 0 then Result := wSKILL_91
               else if wSkill_01 > 0 then Result := wSkill_01
               else if wSKILL_45 > 0 then Result := wSKILL_45
               else if wSKILL_23 > 0 then Result := wSKILL_23
               else if wSkill_5 > 0 then Result := wSkill_5
               else if wSkill_1 > 0 then Result := wSkill_1;
             end;
             2:begin
               if wSkill_04 > 0 then Result := wSkill_04
               else if wSkill_36 > 0 then Result := wSkill_36
               else if wSKILL_92 > 0 then Result := wSKILL_92
               else if wSkill_58 > 0 then Result := wSkill_58
               else if wSKILL_91 > 0 then Result := wSKILL_91
               else if wSkill_01 > 0 then Result := wSkill_01
               else if wSKILL_45 > 0 then Result := wSKILL_45
               else if wSkill_03 > 0 then Result := wSkill_03
               else if wSKILL_23 > 0 then Result := wSKILL_23
               else if wSkill_5 > 0 then Result := wSkill_5
               else if wSkill_1 > 0 then Result := wSkill_1;
             end;
             3:begin
               if wSkill_36 > 0 then Result := wSkill_36
               else if wSKILL_92 > 0 then Result := wSKILL_92
               else if wSkill_58 > 0 then Result := wSkill_58
               else if wSKILL_91 > 0 then Result := wSKILL_91
               else if wSkill_01 > 0 then Result := wSkill_01
               else if wSKILL_45 > 0 then Result := wSKILL_45
               else if wSkill_03 > 0 then Result := wSkill_03
               else if wSkill_04 > 0 then Result := wSkill_04
               else if wSKILL_23 > 0 then Result := wSKILL_23
               else if wSkill_5 > 0 then Result := wSkill_5
               else if wSkill_1 > 0 then Result := wSkill_1;
             end;
             4:begin
               if wSKILL_91 > 0 then Result := wSKILL_91
               else if wSkill_01 > 0 then Result := wSkill_01
               else if wSKILL_45 > 0 then Result := wSKILL_45
               else if wSkill_03 > 0 then Result := wSkill_03
               else if wSkill_04 > 0 then Result := wSkill_04
               else if wSkill_36 > 0 then Result := wSkill_36
               else if wSKILL_92 > 0 then Result := wSKILL_92
               else if wSkill_58 > 0 then Result := wSkill_58
               else if wSKILL_23 > 0 then Result := wSKILL_23
               else if wSkill_5 > 0 then Result := wSkill_5
               else if wSkill_1 > 0 then Result := wSkill_1;
             end;
             5:begin
               if wSKILL_92 > 0 then Result := wSKILL_92
               else if wSkill_58 > 0 then Result := wSkill_58
               else if wSKILL_91 > 0 then Result := wSKILL_91
               else if wSkill_01 > 0 then Result := wSkill_01
               else if wSKILL_45 > 0 then Result := wSKILL_45
               else if wSkill_03 > 0 then Result := wSkill_03
               else if wSkill_04 > 0 then Result := wSkill_04
               else if wSkill_36 > 0 then Result := wSkill_36
               else if wSKILL_23 > 0 then Result := wSKILL_23
               else if wSkill_5 > 0 then Result := wSkill_5
               else if wSkill_1 > 0 then Result := wSkill_1;
             end;
          end;
          if (Result < 6) and ((wSkill_9 > 0) or (wSkill_10 > 0)) then begin
            if ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)<=4) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)=0)) or
               ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=0) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)<=4)) or
               ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=1) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)=1)) or
               ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=2) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)=2)) or
               ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=3) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)=3)) or
               ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=4) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)=4)) then begin
              if wSkill_10 > 0 then Result := wSkill_10
              else if wSkill_9 > 0 then Result := wSkill_9;
            end;
          end;
          Exit;
        end;
      end;
    end else begin
      case Random(6) of
        0:begin
            if wSKILL_45 > 0 then Result := wSKILL_45 //20080410
            else if wSkill_03 > 0 then Result := wSkill_03
            else if wSkill_04 > 0 then Result := wSkill_04
            else if wSkill_36 > 0 then Result := wSkill_36
            else if wSKILL_92 > 0 then Result := wSKILL_92
            else if wSkill_58 > 0 then Result := wSkill_58
            else if wSKILL_91 > 0 then Result := wSKILL_91
            else if wSkill_01 > 0 then Result := wSkill_01
            else if wSKILL_23 > 0 then Result := wSKILL_23
            else if wSkill_5 > 0 then Result := wSkill_5
            else if wSkill_1 > 0 then Result := wSkill_1;
         end;
        1:begin
           if wSkill_03 > 0 then Result := wSkill_03
           else if wSkill_04 > 0 then Result := wSkill_04
           else if wSkill_36 > 0 then Result := wSkill_36
           else if wSKILL_92 > 0 then Result := wSKILL_92
           else if wSkill_58 > 0 then Result := wSkill_58
           else if wSKILL_91 > 0 then Result := wSKILL_91
           else if wSkill_01 > 0 then Result := wSkill_01
           else if wSKILL_45 > 0 then Result := wSKILL_45
           else if wSKILL_23 > 0 then Result := wSKILL_23
           else if wSkill_5 > 0 then Result := wSkill_5
           else if wSkill_1 > 0 then Result := wSkill_1;
         end;
         2:begin
           if wSkill_04 > 0 then Result := wSkill_04
           else if wSkill_36 > 0 then Result := wSkill_36
           else if wSKILL_92 > 0 then Result := wSKILL_92
           else if wSkill_58 > 0 then Result := wSkill_58
           else if wSKILL_91 > 0 then Result := wSKILL_91
           else if wSkill_01 > 0 then Result := wSkill_01
           else if wSKILL_45 > 0 then Result := wSKILL_45
           else if wSkill_03 > 0 then Result := wSkill_03
           else if wSKILL_23 > 0 then Result := wSKILL_23
           else if wSkill_5 > 0 then Result := wSkill_5
           else if wSkill_1 > 0 then Result := wSkill_1;
         end;
         3:begin
           if wSkill_36 > 0 then Result := wSkill_36
           else if wSKILL_92 > 0 then Result := wSKILL_92
           else if wSkill_58 > 0 then Result := wSkill_58
           else if wSKILL_91 > 0 then Result := wSKILL_91
           else if wSkill_01 > 0 then Result := wSkill_01
           else if wSKILL_45 > 0 then Result := wSKILL_45
           else if wSkill_03 > 0 then Result := wSkill_03
           else if wSkill_04 > 0 then Result := wSkill_04
           else if wSKILL_23 > 0 then Result := wSKILL_23
           else if wSkill_5 > 0 then Result := wSkill_5
           else if wSkill_1 > 0 then Result := wSkill_1;
         end;
         4:begin
           if wSKILL_91 > 0 then Result := wSKILL_91
           else if wSkill_01 > 0 then Result := wSkill_01
           else if wSKILL_45 > 0 then Result := wSKILL_45
           else if wSkill_03 > 0 then Result := wSkill_03
           else if wSkill_04 > 0 then Result := wSkill_04
           else if wSkill_36 > 0 then Result := wSkill_36
           else if wSKILL_92 > 0 then Result := wSKILL_92
           else if wSkill_58 > 0 then Result := wSkill_58
           else if wSKILL_23 > 0 then Result := wSKILL_23
           else if wSkill_5 > 0 then Result := wSkill_5
           else if wSkill_1 > 0 then Result := wSkill_1;
         end;
         5:begin
           if wSKILL_92 > 0 then Result := wSKILL_92
           else if wSkill_58 > 0 then Result := wSkill_58
           else if wSKILL_45 > 0 then Result := wSKILL_45
           else if wSkill_03 > 0 then Result := wSkill_03
           else if wSkill_04 > 0 then Result := wSkill_04
           else if wSkill_36 > 0 then Result := wSkill_36
           else if wSKILL_91 > 0 then Result := wSKILL_91
           else if wSkill_01 > 0 then Result := wSkill_01
           else if wSKILL_23 > 0 then Result := wSKILL_23
           else if wSkill_5 > 0 then Result := wSkill_5
           else if wSkill_1 > 0 then Result := wSkill_1;           
         end;
      end;
      if (Result < 6) and ((wSkill_9 > 0) or (wSkill_10 > 0)) then begin
        if ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)<=4) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)=0)) or
           ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=0) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)<=4)) or
           ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=1) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)=1)) or
           ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=2) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)=2)) or
           ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=3) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)=3)) or
           ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=4) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)=4)) then begin
          if wSkill_10 > 0 then Result := wSkill_10
          else if wSkill_9 > 0 then Result := wSkill_9;
        end;
      end;
    end;
  end;
var
  nMagicID: Integer;
  nCode:Byte;
begin
  Result := False;
  nCode:= 0;
  try
    m_wHitMode := 0;
    if m_boDoSpellMagic and (m_TargetCret <> nil) then begin//20080711增加
      nCode:= 1;
      nMagicID := SearchDoSpell;
      nCode:= 5;
      if nMagicID = 0 then m_boAutoAvoid:= True;//是否能躲避 20080715
      nCode:= 6;
      if nMagicID > 0 then begin
        nCode:= 2;
        if not MagCanHitTarget(m_nCurrX, m_nCurrY, m_TargetCret) or ((abs(m_TargetCret.m_nCurrX - m_nCurrX) > 7) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 7)) then begin//魔法不能打到怪 20080420
           if (m_Master <> nil) then begin//20090512 修改
             if ((abs(m_Master.m_nCurrX - m_nCurrX) >= 7) or (abs(m_Master.m_nCurrY - m_nCurrY) >= 7)) then begin
               nCode:= 3;
               m_TargetCret:= nil;
               Exit;
             end else GotoTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
           end else GotoTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
        end;
        nCode:= 4;
        if not DoSpellMagic(nMagicID) then begin
          SendRefMsg(RM_MAGICFIREFAIL, 0, 0, 0, 0, '');
        end;
        Result := True;
      end else Result := WarrAttackTarget(m_wHitMode);
    end else Result := WarrAttackTarget(m_wHitMode);
    m_dwHitTick := GetTickCount();//20080715 增加
  except
    MainOutMessage(Format('{%s} TPlayMonster.WizardAttackTarget Code:%d', [g_sExceptionVer, nCode]));
  end;
end;

{道士--检查身上是否有符或毒}
function TPlayMonster.CheckItemType(nItemType: Integer; StdItem: pTStdItem ; nItemShape: Integer): Boolean;
begin
  Result := False;
  case nItemType of
    1: begin
        if (StdItem.StdMode = 25) and (StdItem.Shape = 5) then Result := True;
      end;
    2: begin
        case nItemShape of
          1:if (StdItem.StdMode = 25) and (StdItem.Shape = 1) then Result := True;
          2:if (StdItem.StdMode = 25) and (StdItem.Shape = 2) then Result := True;
        end;
      end;
  end;
end;
//判断装备里是否有指定的物品
function TPlayMonster.CheckUserItemType(nItemType: Integer; nItemShape: Integer): Boolean;
var
  StdItem: pTStdItem;
begin
  Result := False;
  if m_UseItems[U_BUJUK].wIndex > 0 then begin
    StdItem := UserEngine.GetStdItem(m_UseItems[U_BUJUK].wIndex);
    if StdItem <> nil then begin
      Result := CheckItemType(nItemType, StdItem, nItemShape);
    end;
  end;
end;

function TPlayMonster.UseItem(nItemType, nIndex: Integer; nItemShape: Integer): Boolean; //自动换毒符
var
  UserItem: pTUserItem;
  AddUserItem: pTUserItem;
  StdItem: pTStdItem;
begin
  Result := False;
  if (nIndex >= 0) and (nIndex < m_ItemList.Count) then begin
    UserItem := m_ItemList.Items[nIndex];
    if m_UseItems[U_BUJUK].wIndex > 0 then begin
      StdItem := UserEngine.GetStdItem(m_UseItems[U_BUJUK].wIndex);
      if StdItem <> nil then begin
        if CheckItemType(nItemType, StdItem ,nItemShape) then begin
          Result := True;
        end else begin
          m_ItemList.Delete(nIndex);
          New(AddUserItem);
          AddUserItem^ := m_UseItems[U_BUJUK];
          if AddItemToBag(AddUserItem) then begin
            m_UseItems[U_BUJUK] := UserItem^;
            Dispose(UserItem);
            Result := True;
          end else m_ItemList.Add(UserItem);
        end;
      end else begin
        m_ItemList.Delete(nIndex);
        m_UseItems[U_BUJUK] := UserItem^;
        Dispose(UserItem);
        Result := True;
      end;
    end else begin
      m_ItemList.Delete(nIndex);
      m_UseItems[U_BUJUK] := UserItem^;
      Dispose(UserItem);
      Result := True;
    end;
  end;
end;

//检测包裹中是否有符和毒
//nType 为指定类型 1 为护身符 2 为毒药
function TPlayMonster.GetUserItemList(nItemType: Integer; nItemShape: Integer): Integer;
var
  I: Integer;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
  nCode: Byte;
begin
  Result := -1;
  nCode:= 0;
  try
    for I := m_ItemList.Count - 1 downto 0 do begin//20080916 修改
      nCode:= 1;
      if m_ItemList.Count <= 0 then Break;//20080916
      nCode:= 2;
      UserItem := m_ItemList.Items[I];
      nCode:= 3;
      if UserItem <> nil then begin
        nCode:= 4;
        StdItem := UserEngine.GetStdItem(UserItem.wIndex);
        nCode:= 5;
        if StdItem <> nil then begin
          nCode:= 6;
          if CheckItemType(nItemType, StdItem, nItemShape) then begin
            nCode:= 7;
            if UserItem.Dura < 100 then begin
              nCode:= 9;
              m_ItemList.Delete(I);
              nCode:= 10;
              try
                //DisPoseAndNil(UserItem); SB 局部变量NIL 个毛啊 By TasNat at: 2012-03-17 17:21:56
                DisPose(UserItem);
              except
              end;
              Continue;
            end;
            nCode:= 8;
            Result := I;
            Break;
          end;
        end;
      end;
    end;
  except
    on E: Exception do begin
      MainOutMessage(Format('{%s} TPlayMonster.GetUserItemList Code:%d', [g_sExceptionVer, nCode]));
    end;
  end;
end;

function TPlayMonster.TaoistAttackTarget(): Boolean; {道士攻击}
  function SearchDoSpell: Integer;
    function GetMagic01: Integer;
    begin
      Result := 0;
      {if (m_TargetCret.m_wStatusTimeArr[POISON_DECHEALTH] = 0) and
        (m_TargetCret.m_wStatusTimeArr[POISON_DAMAGEARMOR] = 0) then begin
        if (CheckUserItemType(2) or (GetUserItemList(2) >= 0)) then begin
          if wSkill_10 > 0 then Result := wSkill_10 else if wSkill_06 > 0 then Result := wSkill_06;
        end;
      end;}
      if not m_TargetCret.m_boUnPosion then begin
        if (m_TargetCret.m_wStatusTimeArr[POISON_DECHEALTH] = 0)  and ((GetUserItemList(2,1) >= 0) or CheckUserItemType(2,1)) then begin  {绿毒}
          if wSkill_38 > 0 then Result := wSkill_38
          else if wSkill_93 > 0 then Result := wSkill_93
          else if wSkill_06 > 0 then Result := wSkill_06;
        end;
        if (m_TargetCret.m_wStatusTimeArr[POISON_DAMAGEARMOR] = 0)  and ((GetUserItemList(2,2) >= 0) or CheckUserItemType(2,2)) then begin {红毒}
          if wSkill_38 > 0 then Result := wSkill_38
          else if wSkill_93 > 0 then Result := wSkill_93
          else if wSkill_06 > 0 then Result := wSkill_06;
        end;
      end;
    end;
    function GetMagic02: Integer;
    begin
      Result := 0;
      {if (m_TargetCret.m_wStatusTimeArr[POISON_DECHEALTH] = 0) and
        (m_TargetCret.m_wStatusTimeArr[POISON_DAMAGEARMOR] = 0) then begin
        if (CheckUserItemType(2) or (GetUserItemList(2) >= 0)) then begin
          if wSkill_06 > 0 then Result := wSkill_06 else if wSkill_10 > 0 then Result := wSkill_10;
        end;
      end; }
      if not m_TargetCret.m_boUnPosion then begin
        if (m_TargetCret.m_wStatusTimeArr[POISON_DECHEALTH] = 0) and (m_TargetCret.m_btRaceServer <> 128) and ((GetUserItemList(2,1) >= 0) or CheckUserItemType(2,1)) then begin  {绿毒}
          if wSkill_93 > 0 then Result := wSkill_93
          else if wSkill_06 > 0 then Result := wSkill_06
          else if wSkill_38 > 0 then Result := wSkill_38;
        end;
        if (m_TargetCret.m_wStatusTimeArr[POISON_DAMAGEARMOR] = 0) and (m_TargetCret.m_btRaceServer <> 128) and ((GetUserItemList(2,2) >= 0) or CheckUserItemType(2,2)) then begin {红毒}
          if wSkill_93 > 0 then Result := wSkill_93
          else if wSkill_06 > 0 then Result := wSkill_06
          else if wSkill_38 > 0 then Result := wSkill_38;
        end;
      end;
    end;
    function GetMagic03: Integer;
    begin
      Result := 0;
      if CheckUserItemType(1,0) or (GetUserItemList(1,0) >= 0) then begin
        case Random(2) of
          0: begin
             if wSkill_07 > 0 then Result := wSkill_07//灵魂火符
             else if wSkill_94 > 0 then Result := wSkill_94//四级噬血术
             else if wSkill_59 > 0 then Result := wSkill_59;//噬血术
           end;
          1: begin
             if wSkill_94 > 0 then Result := wSkill_94//四级噬血术
             else if wSkill_59 > 0 then Result := wSkill_59//噬血术
             else if wSkill_07 > 0 then Result := wSkill_07;//灵魂火符
           end;
        end;//case Random(2) of
      end;
    end;

  begin
    Result := 0;
    try
      if m_TargetCret = nil then Exit;//20080806 增加
      if (abs(m_TargetCret.m_nCurrX - m_nCurrX) > 1) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 1) then begin
        if (wSkill_08 > 0) and (m_wStatusTimeArr[STATE_DEFENCEUP] = 0) and (CheckUserItemType(1,0) or (GetUserItemList(1,0) >= 0)) then begin
          Result := wSkill_08; {使用神圣战甲术}
          Exit;
        end;
        if (wSkill_14 > 0) and (m_wStatusTimeArr[STATE_MAGDEFENCEUP] = 0) and (CheckUserItemType(1,0) or (GetUserItemList(1,0) >= 0)) then begin
          Result := wSkill_14; {使用幽灵盾 20080405}
          Exit;
        end;
      end;

      if (wSkill_50 > 0) and (m_wStatusArrValue[2]= 0) and (GetTickCount - m_nSkill_5Tick > 15000) then begin //无极真气
        m_nSkill_5Tick:= GetTickCount();//无极真气使用间隔 20080605
        Result := wSkill_50;
        Exit;
      end;
      if (wSkill_73 > 0) and (m_wStatusTimeArr[STATE_BUBBLEDEFENCEUP ] = 0) then begin//道力盾
        Result := wSkill_73;
        Exit;
      end;
      {$IF M2Version <> 2}
      if (wSKILL_69 > 0) and ((GetTickCount -  m_dwLatest69Tick) > g_Config.nKill69UseTime * 1000) then begin//倚天辟地
        m_dwLatest69Tick:= GetTickCount();
        Result := wSKILL_69;
        Exit;
      end;
      if (wSKILL_98 > 0) and ((GetTickCount - m_dwLatestBloodSoulTick) > g_Config.dwUseBloodSoulTick) then begin//血魄一击(道)
        m_dwLatestBloodSoulTick := GetTickCount;
        Result := wSKILL_98;
        Exit;
      end;
      {$IFEND}
      if wSkill_51 > 0 then begin
        if Random(4) = 0 then begin
          Result := wSkill_51;//飓风破 20080917
          Exit;
        end;
      end;
      if wSkill_48 > 0 then begin
        if (CheckTargetXYCount3(m_nCurrX, m_nCurrY, 1, 0) > 0) and (m_TargetCret.m_WAbil.Level <= m_WAbil.Level)
          and (GetTickCount - m_nSkill_48Tick > 5000) then begin//气功波 20090111
          m_nSkill_48Tick:= GetTickCount();//气功波使用间隔 20090111
          Result := wSkill_48;
          Exit;
        end;
      end;

      if CheckTargetXYCount(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 3) > 1 then begin
        if (m_TargetCret.m_wStatusTimeArr[POISON_DECHEALTH] = 0)  and ((GetUserItemList(2,1) >= 0) or CheckUserItemType(2,1)) then begin  {绿毒}
            Result := GetMagic01;
            if Result = 0 then Result := GetMagic03;
        end else
        if (m_TargetCret.m_wStatusTimeArr[POISON_DAMAGEARMOR] = 0)  and ((GetUserItemList(2,2) >= 0) or CheckUserItemType(2,2)) then begin  {红毒}
            Result := GetMagic01;
            if Result = 0 then Result := GetMagic03;
        end else begin
          Result := GetMagic03;
          if Result = 0 then Result := GetMagic01;
        end;
      end else begin
        if (m_TargetCret.m_wStatusTimeArr[POISON_DECHEALTH] = 0)  and ((GetUserItemList(2,1) >= 0) or CheckUserItemType(2,1)) then begin  {绿毒}
          Result := GetMagic02;
          if Result = 0 then Result := GetMagic03;
        end else
        if (m_TargetCret.m_wStatusTimeArr[POISON_DAMAGEARMOR] = 0)  and ((GetUserItemList(2,2) >= 0) or CheckUserItemType(2,2)) then begin  {红毒}
          Result := GetMagic02;
          if Result = 0 then Result := GetMagic03;
        end else begin
          Result := GetMagic03;
          if Result = 0 then Result := GetMagic02;
        end;
      end;
    except
    end;
  end;
var
  nMagicID: Integer;
  nIndex: Integer;
  nCode:Byte;
begin
  Result := False;
  nCode:= 0;
  try
    if m_TargetCret.m_boDeath then Exit;//20080120 防止人物死后,人形怪还在使用魔法,导致M2出错
    m_wHitMode := 0;
    nCode:= 1;
    if m_boDoSpellMagic and (m_TargetCret <> nil) then begin//20080711 增加
      nCode:= 12;
      nMagicID := SearchDoSpell;
      nCode:= 13;
      if nMagicID = 0 then m_boAutoAvoid:= True;//是否能躲避 20080715
      nCode:= 2;
      if nMagicID > 0 then begin
        //20080420 增加
        if not MagCanHitTarget(m_nCurrX, m_nCurrY, m_TargetCret) or ((abs(m_TargetCret.m_nCurrX - m_nCurrX) > 7) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 7)) then begin//魔法不能打到怪 20080420
           if (m_Master <> nil) and ((abs(m_Master.m_nCurrX - m_nCurrX) >= 7) or (abs(m_Master.m_nCurrY - m_nCurrY) >= 7)) then begin
             nCode:= 3;
             m_TargetCret:= nil;
             Exit;
           end else GotoTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
        end;
        nCode:= 4;
        case nMagicID of
         { SKILL_FIRECHARM, SKILL_DEJIWONHO: begin //道用符的技能,装备里没有,直接用包裹里的物品,不用自动换物品 20080415
              if not CheckUserItemType(1,0) then begin
                nIndex := GetUserItemList(1,0);
                if nIndex >= 0 then begin
                  UseItem(1, nIndex, 0);
                end;
              end;
            end; }
          SKILL_AMYOUNSUL, SKILL_93, SKILL_GROUPAMYOUNSUL: begin //施毒术
              {if not CheckUserItemType(2) then begin
                nIndex := GetUserItemList(2);
                if nIndex >= 0 then begin
                  UseItem(2, nIndex);
                end;
              end; }
             if (m_TargetCret.m_wStatusTimeArr[POISON_DECHEALTH] = 0) and ((GetUserItemList(2,1) >= 0) or CheckUserItemType(2,1)) then begin//绿毒
               nCode:= 5;
               if not CheckUserItemType(2,1) then begin //检查装备栏的物品类型
                 nCode:= 6;
                 nIndex := GetUserItemList(2,1);//取包裹里的物品ID
                 if nIndex >= 0 then begin
                   nCode:= 7;
                   UseItem(2, nIndex,1);//自动换毒
                 end;
               end;
             end else
              if (m_TargetCret.m_wStatusTimeArr[POISON_DAMAGEARMOR] = 0) and ((GetUserItemList(2,2) >= 0) or CheckUserItemType(2,2)) then  begin//红毒
                nCode:= 8;
                if not CheckUserItemType(2,2) then begin //检查装备栏的物品类型
                  nCode:= 9;
                  nIndex := GetUserItemList(2,2);//取包裹里的物品ID
                  if nIndex >= 0 then begin
                    nCode:= 10;
                    UseItem(2, nIndex,2);//自动换毒
                  end;
                end;
              end;
            end;
        end;
        nCode:= 11;
        if not DoSpellMagic(nMagicID) then begin
          SendRefMsg(RM_MAGICFIREFAIL, 0, 0, 0, 0, '');
        end;
        Result := True;
      end else  Result := WarrAttackTarget(m_wHitMode);
    end else  Result := WarrAttackTarget(m_wHitMode);
    m_dwHitTick := GetTickCount();//20080715 增加
  except
    MainOutMessage(Format('{%s} TPlayMonster.TaoistAttackTarget Code:%d', [g_sExceptionVer, nCode]));
  end;
end;

function TPlayMonster.AttackTarget(): Boolean;
begin
  Result := False;
  if m_WAbil.MP < 100 then m_WAbil.MP:= 100;//20080917 当MP少于100时,初始为100
  case m_btJob of
    0: begin
        if m_Master <> nil then begin//20081103 人物分身时的攻击速度
          if GetTickCount - m_dwHitTick > g_Config.dwWarrorAttackTime then begin//20080522
            m_nSelectMagic:= 0;//查询魔法 20081206
            //m_dwHitTick := GetTickCount(); 20081206
            m_boAutoAvoid:= False;//是否能躲避 20080715
            Result := WarrorAttackTarget;
          end;
        end else begin
          if GetTickCount - m_dwHitTick > m_nNextHitTime then begin//为怪物时按DB设置的攻击速度
            m_nSelectMagic:= 0;//查询魔法 20081206
            //m_dwHitTick := GetTickCount(); 20081206
            m_boAutoAvoid:= False;//是否能躲避 20080715
            Result := WarrorAttackTarget;
          end;
        end;
      end;
    1: begin
        if m_Master <> nil then begin//20081103
          if GetTickCount - m_dwHitTick > g_Config.dwWizardAttackTime then begin//20080522
            m_dwHitTick := GetTickCount();
            m_boAutoAvoid:= False;//是否能躲避 20080715
            Result := WizardAttackTarget;
          end;
        end else begin
          if GetTickCount - m_dwHitTick > m_nNextHitTime then begin
            m_dwHitTick := GetTickCount();
            m_boAutoAvoid:= False;//是否能躲避 20080715
            Result := WizardAttackTarget;
          end;
        end;
      end;
    2: begin
        if m_Master <> nil then begin//20081103
          if GetTickCount - m_dwHitTick > g_Config.dwTaoistAttackTime then begin //20080522
            m_dwHitTick := GetTickCount();
            m_boAutoAvoid:= False;//是否能躲避 20080715
            Result := TaoistAttackTarget;
          end;
        end else begin
          if GetTickCount - m_dwHitTick > m_nNextHitTime then begin
            m_dwHitTick := GetTickCount();
            m_boAutoAvoid:= False;//是否能躲避 20080715
            Result := TaoistAttackTarget;
          end;
        end;
      end;
  end;
end;

procedure TPlayMonster.Run;
var
  nX, nY: Integer;
  nCheckCode: Integer;
resourcestring
  sExceptionMsg = '{%s} TPlayMonster.Run Code:%d';
begin
  nCheckCode:= 0;
  try
    if (not m_boGhost) and (not m_boDeath) and (not m_boFixedHideMode) and (not m_boStoneMode) and
      (m_wStatusTimeArr[POISON_STONE] = 0) and (m_wStatusTimeArr[POISON_LOCKSPELL{7}] = 0)
      and (m_wStatusArrValue[23] = 0) then begin
      nCheckCode:= 12;
      if Think then begin
        inherited;
        Exit;
      end;
      {$IF M2Version <> 2}
      PlaySuperRock;//气血石功能 20080729
      {$IFEND}
      if (GetTickCount - m_dwCheckItmeDayTick > 3600000) then begin//1小时执行
        m_dwCheckItmeDayTick := GetTickCount();
        CheckItemsDay();//定时检测物品是否过期
      end;
      nCheckCode:= 1;
      if m_boFireHitSkill and ((GetTickCount - m_dwLatestFireHitTick) > 20000{20 * 1000}) then begin
        m_boFireHitSkill := False; //关闭烈火
      end;
      if m_boDailySkill and ((GetTickCount - m_dwLatestDailyTick) > 20000{20 * 1000}) then begin
        m_boDailySkill := False; //关闭逐日剑法 20080511
      end;
      nCheckCode:= 2;                                                               //20090516 增加
      if ((GetTickCount - m_dwSearchEnemyTick) > 1100) and m_boIsVisibleActive and (not m_boNoAttackMode) then begin//20090104 1000改成1100 20090503 修改
        m_dwSearchEnemyTick := GetTickCount();
        if (m_Master <> nil) and g_Config.boAttackMasterTarget then begin//20100408 与主人打同一目标
          if (not m_Master.m_boGhost) then begin
            nCheckCode:= 20;
            if (m_Master.m_TargetCret <> nil) then begin
              nCheckCode:= 21;
              if not m_Master.m_TargetCret.m_boDeath then begin
                nCheckCode:= 22;
                if m_Master.m_TargetCret <> m_TargetCret then begin
                  nCheckCode:= 23;
                  if IsProperTarget(m_Master.m_TargetCret) and (not m_Master.m_TargetCret.m_boHideMode or m_boCoolEye) then begin
                    nCheckCode:= 24;
                    SetTargetCreat(m_Master.m_TargetCret);
                  end;
                end;
              end;
            end;
          end;
        end;
        if (m_TargetCret = nil) then SearchTarget();//搜索可攻击目标
      end;
      nCheckCode:= 3;
      if m_boWalkWaitLocked then begin
        if (GetTickCount - m_dwWalkWaitTick) > m_dwWalkWait then m_boWalkWaitLocked := False;
      end;
      nCheckCode:= 4;
      if not m_boWalkWaitLocked and ({Integer}(GetTickCount - m_dwWalkTick) > m_nWalkSpeed) then begin//20080715
        m_dwWalkTick := GetTickCount();
        Inc(m_nWalkCount);
        if m_nWalkCount > m_nWalkStep then begin
          m_nWalkCount := 0;
          m_boWalkWaitLocked := True;
          m_dwWalkWaitTick := GetTickCount();
        end;
        nCheckCode:= 5;
        if (m_Master <> nil) then begin//20090705 移动位置
          if m_Master.m_boSlaveRelax then begin
            inherited;
            Exit;
          end;
        end;
        if not m_boRunAwayMode then begin
          if not m_boNoAttackMode then begin
            if m_boProtectStatus then begin//守护状态,距离太远  20090107
              if not m_boProtectOK then begin//没走到守护坐标  20090107
                if (m_TargetCret <> nil) then m_TargetCret:= nil;
                GotoTargetXY(m_nProtectTargetX, m_nProtectTargetY);
                Inc(m_nGotoProtectXYCount);
                if (abs(m_nCurrX - m_nProtectTargetX) <= 2 ) and (abs(m_nCurrY - m_nProtectTargetY) <= 2) then  begin
                  m_boProtectOK:= True;
                  m_nGotoProtectXYCount:= 0;//是向守护坐标的累计数 20090203
                end;
                if (m_nGotoProtectXYCount > 20) and (not m_boProtectOK) then begin//20次还没有走到守护坐标，则飞回坐标上 20090203
                  if (abs(m_nCurrX - m_nProtectTargetX) > 13 ) or (abs(m_nCurrY - m_nProtectTargetY) > 13) then  begin
                    SpaceMove(m_PEnvir.sMapName, m_nProtectTargetX, m_nProtectTargetY, 1);//地图移动
                    m_boProtectOK:= True;
                    m_nGotoProtectXYCount:= 0;//是向守护坐标的累计数 20090203
                  end;
                end;
                inherited;//20090315 增加
                Exit;//20090315 增加
              end;
            end;
            if (m_TargetCret <> nil) then begin//20090103
              if (not m_TargetCret.m_boDeath) {and (m_TargetCret.m_WAbil.HP > 0)} then begin  //20090318
                nCheckCode:= 51;
                if AttackTarget then begin
                  inherited;
                  Exit;
                end;
                nCheckCode:= 6;
                if StartAutoAvoid and m_boDoSpellMagic then begin //20080305 增加
                  AutoAvoid();  //自动躲避
                  inherited;
                  Exit;
                end else begin
                  nCheckCode:= 61;
                  if IsNeedGotoXY then begin
                    nCheckCode:= 62;
                    GotoTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
                    inherited;
                    Exit;
                  end;
                end;
              end;
            end else begin
              {if not m_boProtectStatus then }m_nTargetX := -1;//20090103
              nCheckCode:= 7;
              if m_boMission then begin //如果设置了怪物结集点,则向结集点移动
                m_nTargetX := m_nMissionX;
                m_nTargetY := m_nMissionY;
              end;
            end;
          end;
          nCheckCode:= 8;
          if m_Master <> nil then begin
            if m_TargetCret = nil then begin
              nCheckCode:= 81;
              m_Master.GetBackPosition(nX, nY);
              if (abs(m_nTargetX - nX) > {1}2) or (abs(m_nTargetY - nY) > {1}2) then begin//20090512 修改
                m_nTargetX := nX;
                m_nTargetY := nY;
                if (abs(m_nCurrX - nX) <= {2}3) and (abs(m_nCurrY - nY) <= {2}3) then begin//20090512 修改
                  if m_PEnvir.GetMovingObject(nX, nY, True) <> nil then begin
                    m_nTargetX := m_nCurrX;
                    m_nTargetY := m_nCurrY;
                  end;
                end;
              end;
            end; //if m_TargetCret = nil then begin
            if (not m_Master.m_boSlaveRelax) and
              ((m_PEnvir <> m_Master.m_PEnvir) or
              (abs(m_nCurrX - m_Master.m_nCurrX) > 20) or
              (abs(m_nCurrY - m_Master.m_nCurrY) > 20)) then begin
               nCheckCode:= 82;
               SpaceMove(m_Master.m_PEnvir.sMapName, m_nTargetX, m_nTargetY, 1);//地图移动
            end;
          end else begin //if m_Master <> nil then begin
            nCheckCode:= 83;
            if m_boProtectStatus then begin //守护状态 20090105
              if (abs(m_nCurrX - m_nProtectTargetX) > 13) or (abs(m_nCurrY - m_nProtectTargetY) > 13) then begin
                m_nTargetX := m_nProtectTargetX;
                m_nTargetY := m_nProtectTargetY;
                m_TargetCret := nil;
                m_boProtectOK:= False;//20090107
                GotoTargetXY(m_nTargetX, m_nTargetY);
                if (abs(m_nCurrX - m_nProtectTargetX) <= 1 ) and (abs(m_nCurrY - m_nProtectTargetY) <= 1) then m_boProtectOK:= True;//20090107
              end else begin
                m_nTargetX := -1;
              end;
            end;
          end;
        end else begin
          nCheckCode:= 9;
          if (m_dwRunAwayTime > 0) and ((GetTickCount - m_dwRunAwayStart) > m_dwRunAwayTime) then begin
            m_boRunAwayMode := False;
            m_dwRunAwayTime := 0;
          end;
        end;
        if (m_TargetCret = nil) then begin//20081204 修正:怪围的人转圈圈,转个两三圈再砍一刀
          if (m_nTargetX <> -1) and AllowGotoTargetXY then begin
            nCheckCode:= 10;
            GotoTargetXY(m_nTargetX, m_nTargetY);
          end else begin
            nCheckCode:= 11;
            Wondering();
          end;
        end;
      end;
    end;
  except
    on E: Exception do begin
      MainOutMessage(Format(sExceptionMsg, [g_sExceptionVer, nCheckCode]));
    end;
  end;
  inherited;
end;
//穿上装备
function TPlayMonster.AddItems(UserItem: pTUserItem; btWhere: Integer): Boolean;
begin
  Result := False;
  if btWhere in [Low(THumanUseItems)..High(THumanUseItems)] then begin
    m_UseItems[btWhere] := UserItem^;
    Result := True;
  end;
end;
//加载人形怪挖取列表 20080523
procedure TPlayMonster.LoadButchItemList();
var
  I: Integer;
  s24: string;
  LoadList: TStringList;
  MonItem: pTMonItemInfo;
  s28, s2C, s30: string;
  n18, n1C, n20: Integer;
begin
  s24 := g_Config.sEnvirDir + 'MonUseItems\' + m_sCharName + '-Item.txt';
  if FileExists(s24) then begin
    if m_ButchItemList <> nil then begin
      if m_ButchItemList.Count > 0 then begin//20080630
        for I := 0 to m_ButchItemList.Count - 1 do begin
          if pTMonItemInfo(m_ButchItemList.Items[I]) <> nil then
             Dispose(pTMonItemInfo(m_ButchItemList.Items[I]));
        end;
      end;
      m_ButchItemList.Clear;
    end;
    LoadList := TStringList.Create;
    try
      LoadList.LoadFromFile(s24);
      //FrmDB.DeCodeStringList(LoadList);//挖取列表支持脚本加密 20090305
      if LoadList.Count > 0 then begin//20080630
        for I := 0 to LoadList.Count - 1 do begin
          s28 := LoadList.Strings[I];
          if (s28 <> '') and (s28[1] <> ';') then begin
            s28 := GetValidStr3(s28, s30, [' ', '/', #9]);
            n18 := Str_ToInt(s30, -1);
            s28 := GetValidStr3(s28, s30, [' ', '/', #9]);
            n1C := Str_ToInt(s30, -1);
            s28 := GetValidStr3(s28, s30, [' ', #9]);
            if s30 <> '' then begin
              if s30[1] = '"' then
                ArrestStringEx(s30, '"', '"', s30);
            end;
            s2C := s30;
            s28 := GetValidStr3(s28, s30, [' ', #9]);
            n20 := Str_ToInt(s30, 1);
            if (n18 > 0) and (n1C > 0) and (s2C <> '') then begin
              New(MonItem);
              MonItem.SelPoint := n18 - 1;
              MonItem.MaxPoint := n1C;
              MonItem.ItemName := s2C;
              MonItem.Count := n20;
              Randomize;//播下随机种子 20080729
              if Random(MonItem.MaxPoint) <= MonItem.SelPoint then begin//、计算机率 1/10 随机10<=1 即为所得的物品
                m_ButchItemList.Add(MonItem);
              end else Dispose(MonItem);//修复内存泄露By TasNat at: 2012-05-27 10:11:56
            end;
          end;
        end;
      end;
    finally
      LoadList.Free;
    end;
  end;
{  for i:=0 to  m_ButchItemList.Count-1 do
    MainOutMessage(pTMonItemInfo( m_ButchItemList.Items[i]).ItemName);}
end;

procedure TPlayMonster.AddItemsFromConfig();
var
  TempList: TStringList;
  sCopyHumBagItems: string;
  UserItem: pTUserItem;
  I: Integer;
  sFileName: string;
  ItemIni: TIniFile;
  sMagic: string;
  sMagicName: string;
  Magic: pTMagic;
  UserMagic: pTUserMagic;
  StdItem: pTStdItem;
  StdItemNameArray: array[0..14] of string[16];//20080416 扩展到13 支持斗笠
  sAttackTargets: string;
begin
  if m_nCopyHumanLevel > 0 then begin
    case m_btJob of
      0: sCopyHumBagItems := Trim(g_Config.sCopyHumBagItems1);
      1: sCopyHumBagItems := Trim(g_Config.sCopyHumBagItems2);
      2: sCopyHumBagItems := Trim(g_Config.sCopyHumBagItems3);
    end;
    if sCopyHumBagItems <> '' then begin
      TempList := TStringList.Create;
      try
        ExtractStrings(['|', '\', '/', ','], [], PChar(sCopyHumBagItems), TempList);
        if TempList.Count > 0 then begin
          for I := 0 to TempList.Count - 1 do begin
            New(UserItem);
            if UserEngine.CopyToUserItemFromName(TempList.Strings[I], UserItem) then begin
              m_ItemList.Add(UserItem);
              //m_WAbil.Weight := RecalcBagWeight();
            end else Dispose(UserItem);
          end;
        end;
      finally
        TempList.Free;
      end;
    end;
  end else begin
    sFileName := g_Config.sEnvirDir + 'MonUseItems\' + m_sCharName + '.txt';
    if FileExists(sFileName) then begin
      ItemIni := TIniFile.Create(sFileName);
      if ItemIni <> nil then begin
        m_boDropUseItem := ItemIni.ReadBool('Info','DropUseItem',False);//是否掉装备 20080120
        m_nDieDropUseItemRate := ItemIni.ReadInteger('Info', 'DropUseItemRate', 100); //死亡掉装备几率
        //m_nButchUserItemRate:= ItemIni.ReadInteger('Info','ButchUserItemRate',10);//被挖取时可以挖到身上装备的几率 20080523
        m_boButchUseItem:= ItemIni.ReadBool('Info','ButchUseItem',False);//是否允许挖取身上装备
        m_nButchRate:= ItemIni.ReadInteger('Info','ButchRate',10);//挖取身上装备机率 20080120
        m_nButchChargeClass:= ItemIni.ReadInteger('Info','ButchChargeClass',3);//挖取身上装备收费模式(0金币，1元宝，2金刚石，3灵符)  20080120
        m_nButchChargeCount:= ItemIni.ReadInteger('Info','ButchChargeCount',1);//挖取身上装备每次收费点数 20080120
        sCopyHumBagItems:= ItemIni.ReadString('UseItems', 'InitItems', '');//附加物品 如毒等物品 20080603
        boIntoTrigger:= ItemIni.ReadBool('Info','ButchCloneItem',False);//人形怪挖是否进入触发 20080716
        boIsDieEvent:= ItemIni.ReadBool('Info','IsDieEvent',False);//清理人形尸体,是否显示升天龙效果(人物升级效果) 20080914
        m_boProtectStatus:= ItemIni.ReadBool('Info','ProtectStatus',False);//是否守护模式 20090103
        m_boNoAttackMode:= ItemIni.ReadBool('Info','NoAttackMode',False);//非攻击模式 20090516
        sAttackTargets:= ItemIni.ReadString('Info', 'AttackTargets', '');//指定攻击目标的类型
        if sAttackTargets <> '' then begin
          TargetList := TStringList.Create;
          ExtractStrings(['|', '\', '/', ','], [], PChar(sAttackTargets), TargetList);
        end;
        if sCopyHumBagItems <> '' then begin
          TempList := TStringList.Create;
          try
            ExtractStrings(['|', '\', '/', ','], [], PChar(sCopyHumBagItems), TempList);
            if TempList.Count > 0 then begin//20080630
              for I := 0 to TempList.Count - 1 do begin
                New(UserItem);
                if UserEngine.CopyToUserItemFromName(TempList.Strings[I], UserItem) then begin
                  m_ItemList.Add(UserItem);
                end else Dispose(UserItem);
              end;
            end;
          finally
            TempList.Free;
          end;
        end;

        m_btJob := ItemIni.ReadInteger('Info', 'Job', 0);//职业
        m_btGender := ItemIni.ReadInteger('Info', 'Gender', 0);//性别
        m_btHair := ItemIni.ReadInteger('Info', 'Hair', 0);//头发
        sMagic := ItemIni.ReadString('Info', 'UseSkill', '');//使用魔法
        if sMagic <> '' then begin
          TempList := TStringList.Create;
          ExtractStrings(['|', '\', '/', ','], [], PChar(sMagic), TempList);
          if TempList.Count > 0 then begin//20080630
            for I := 0 to TempList.Count - 1 do begin
              sMagicName := Trim(TempList.Strings[I]);
              if FindMagic(sMagicName) = nil then begin
                Magic := UserEngine.FindMagic(sMagicName);
                if Magic <> nil then begin
                  if Magic.wMagicId <> 75 then begin//护体神盾 20091126
                    if (Magic.btJob = 99) or (Magic.btJob = m_btJob) then begin
                      New(UserMagic);
                      UserMagic.MagicInfo := Magic;
                      UserMagic.wMagIdx := Magic.wMagicId;
                      if Magic.wMagicId = 66 then UserMagic.btLevel := 4//四级魔法盾 20080728
                      else UserMagic.btLevel := 3;
                      UserMagic.btKey := 0;
                      UserMagic.nTranPoint := Magic.MaxTrain[3];
                      m_MagicList.Add(UserMagic);
                    end;
                  end else m_boProtectionDefence:= True; //是否学过护体神盾
                end;
              end;
            end;//for
          end;
          TempList.Free;
        end;

        FillChar(StdItemNameArray, SizeOf(StdItemNameArray), #0);
        StdItemNameArray[U_DRESS] := ItemIni.ReadString('UseItems', 'UseItems0'{'DRESSNAME'}, ''); // '衣服';
        StdItemNameArray[U_WEAPON] := ItemIni.ReadString('UseItems', 'UseItems1'{'WEAPONNAME'}, ''); // '武器';
        StdItemNameArray[U_RIGHTHAND] := ItemIni.ReadString('UseItems', 'UseItems2'{'RIGHTHANDNAME'}, ''); // '照明物';
        StdItemNameArray[U_NECKLACE] := ItemIni.ReadString('UseItems', 'UseItems3'{'NECKLACENAME'}, ''); // '项链';
        StdItemNameArray[U_HELMET] := ItemIni.ReadString('UseItems', 'UseItems4'{'HELMETNAME'}, ''); // '头盔';
        StdItemNameArray[U_ARMRINGL] := ItemIni.ReadString('UseItems', 'UseItems5'{'ARMRINGLNAME'}, ''); // '左手镯';
        StdItemNameArray[U_ARMRINGR] := ItemIni.ReadString('UseItems', 'UseItems6'{'ARMRINGRNAME'}, ''); // '右手镯';
        StdItemNameArray[U_RINGL] := ItemIni.ReadString('UseItems','UseItems7' {'RINGLNAME'}, ''); // '左戒指';
        StdItemNameArray[U_RINGR] := ItemIni.ReadString('UseItems','UseItems8' {'RINGRNAME'}, ''); // '右戒指';
        {$IF M2Version <> 2}
        StdItemNameArray[U_BUJUK] := ItemIni.ReadString('UseItems', 'UseItems9'{'BUJUKNAME'}, ''); // '物品';
        StdItemNameArray[U_BELT] := ItemIni.ReadString('UseItems', 'UseItems10'{'BELTNAME'}, ''); // '腰带';
        StdItemNameArray[U_BOOTS] := ItemIni.ReadString('UseItems', 'UseItems11'{'BOOTSNAME'}, ''); // '鞋子';
        StdItemNameArray[U_CHARM] := ItemIni.ReadString('UseItems','UseItems12' {'CHARMNAME'}, ''); // '宝石';
        StdItemNameArray[U_ZHULI] := ItemIni.ReadString('UseItems','UseItems13' {'CHARMNAME'}, ''); // '斗笠';
        StdItemNameArray[U_DRUM] := ItemIni.ReadString('UseItems', 'UseItems14'{'DRUMNAME'}, ''); // '鞋子';
        {$IFEND}
        for {$IF M2Version <> 2}I := U_DRESS to U_DRUM{$ELSE}I := U_DRESS to U_RINGR{$IFEND} do begin //20080416 斗笠
          if StdItemNameArray[I] <> '' then begin
            StdItem := UserEngine.GetStdItem(StdItemNameArray[I]);
            if StdItem <> nil then begin
              //if CheckTakeOnItems(i, StdItem^) then begin
              New(UserItem);
              if UserEngine.CopyToUserItemFromName(StdItemNameArray[I], UserItem) then begin
                if Random(g_Config.nPlayMonRandomAddValue) = 0 then UserEngine.RandomUpgradeItem(UserItem);//人形支持极品装备 20080716
                AddItems(UserItem, I);
              end;
              Dispose(UserItem);
              //end;
            end;
          end;
        end;
        LoadButchItemList();//加载人形怪挖取列表 20080523
        ItemIni.Free;
      end;
    end;
  end;
end;
//查找魔法
function TPlayMonster.FindMagic(sMagicName: string): pTUserMagic;
var
  UserMagic: pTUserMagic;
  I: Integer;
begin
  Result := nil;
  if m_MagicList.Count > 0 then begin//20080630
    for I := 0 to m_MagicList.Count - 1 do begin
      UserMagic := m_MagicList.Items[I];
      if UserMagic <> nil then begin
        if CompareText(UserMagic.MagicInfo.sMagicName, sMagicName) = 0 then begin
          Result := UserMagic;
          Break;
        end;
      end;
    end;
  end;
end;
{//检查拿物品   20080522 注释
function TPlayMonster.CheckTakeOnItems(nWhere: Integer; var StdItem: TStdItem): Boolean;
  function GetUserItemWeitht(nWhere: Integer): Integer;
  var
    I: Integer;
    n14: Integer;
    StdItem: pTStdItem;
  begin
    n14 := 0;
    for I := Low(THumanUseItems) to High(THumanUseItems) do begin
      if (nWhere = -1) or (not (I = nWhere) and not (I = 1) and not (I = 2)) then begin
        StdItem := UserEngine.GetStdItem(m_UseItems[I].wIndex);
        if StdItem <> nil then Inc(n14, StdItem.Weight);
      end;
    end;
    Result := n14;
  end;
begin
  Result := False;
  if (StdItem.StdMode = 10) and (m_btGender <> 0) then begin
    Exit;
  end;
  if (StdItem.StdMode = 11) and (m_btGender <> 1) then begin
    Exit;
  end;
  if (nWhere = 1) or (nWhere = 2) then begin
    if StdItem.Weight > m_WAbil.MaxHandWeight then Exit;
  end else begin
    if (StdItem.Weight + GetUserItemWeitht(nWhere)) > m_WAbil.MaxWearWeight then Exit;
  end;
  case StdItem.Need of
    0: begin
        if m_Abil.Level >= StdItem.NeedLevel then Result := True;
      end;
    1: begin
        if HiWord(m_WAbil.DC) >= StdItem.NeedLevel then Result := True;
      end;
    10: begin
        if (m_btJob = LoWord(StdItem.NeedLevel)) and (m_Abil.Level >= HiWord(StdItem.NeedLevel)) then Result := True;
      end;
    11: begin
        if (m_btJob = LoWord(StdItem.NeedLevel)) and (HiWord(m_WAbil.DC) >= HiWord(StdItem.NeedLevel)) then Result := True;
      end;
    12: begin
        if (m_btJob = LoWord(StdItem.NeedLevel)) and (HiWord(m_WAbil.MC) >= HiWord(StdItem.NeedLevel)) then Result := True;
      end;
    13: begin
        if (m_btJob = LoWord(StdItem.NeedLevel)) and (HiWord(m_WAbil.SC) >= HiWord(StdItem.NeedLevel)) then Result := True;
      end;
    2: begin
        if HiWord(m_WAbil.MC) >= StdItem.NeedLevel then Result := True;
      end;
    3: begin
        if HiWord(m_WAbil.SC) >= StdItem.NeedLevel then Result := True;
      end;
  else begin
      Result := True;
    end;
  end;
end; }

//无极真气  20080323 修改
//0级提升道术40%   1级提升60%   2级提升80%  3级提升100%  时间都是6秒
function TPlayMonster.AbilityUp(UserMagic: pTUserMagic): Boolean;
var
  nSpellPoint, n14: Integer;
begin
  Result := False;
  nSpellPoint := GetSpellPoint(UserMagic);
  if nSpellPoint > 0 then begin
    if (m_WAbil.MP < nSpellPoint) or (m_wStatusArrValue[2] <> 0) then Exit;//20091018 增加
    if UserMagic.btLevel > 3 then UserMagic.btLevel:= 3;
    n14 := (Random(10 + UserMagic.btLevel) + UserMagic.btLevel) * UserMagic.btLevel;
    m_dwStatusArrTimeOutTick[2] := GetTickCount + n14 * 1000;
    //m_wStatusArrValue[2] := HiWord(m_WAbil.SC)* 2*(UserMagic.btLevel + 2) div 10 ;//提升值 20080323 (2+等级)*0.2*道术=提升值 替换
    m_wStatusArrValue[2] := _MIN(HiWord(m_WAbil.SC),Round(MakeLong(LoWord(m_WAbil.SC), HiWord(m_WAbil.SC))*(UserMagic.btLevel * 0.2 + 0.4)));//提升值 20080826
    RecalcAbilitys();
    Result := True;
  end;
end;

//灭天火 20080410
function TPlayMonster.MagMakeFireDay(PlayObject: TBaseObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  var TargeTBaseObject: TBaseObject): Boolean;
var
  nPower, NGSecPwr: Integer;
  function MPow(UserMagic: pTUserMagic): Integer;
  begin
    if UserMagic.MagicInfo.wMaxPower > UserMagic.MagicInfo.wPower then//20090807
      Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower)
    else Result := UserMagic.MagicInfo.wPower;
  end;
  function GetPower(nPower: Integer): Integer;
  begin
    if UserMagic.MagicInfo.btDefMaxPower > UserMagic.MagicInfo.btDefPower then//20090807
      Result := Round(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower))
    else Result := Round(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + UserMagic.MagicInfo.btDefPower;
  end;
begin
  Result := False;
  if PlayObject.IsProperTarget(TargeTBaseObject) then begin
    if (Random(10) >= TargeTBaseObject.m_nAntiMagic) then begin
      nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC),
        SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1);
      if UserMagic.btLevel = 4 then nPower := nPower + g_Config.nPowerLV4;//4 级威力 20080417
      if TargeTBaseObject.m_btLifeAttrib = LA_UNDEAD then nPower := Round(nPower * 1.5);
      {$IF M2Version <> 2}
      if (TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT) or (TargeTBaseObject.m_btRaceServer = RC_HEROOBJECT) then begin
        NGSecPwr:= 0;
        if TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
          NGSecPwr:= MagicManager.GetNGPow(TargeTBaseObject, TPlayObject(TargeTBaseObject).m_MagicSkill_229,nPower);//静之灭天火
        end else
        if TargeTBaseObject.m_btRaceServer = RC_HEROOBJECT then begin
          NGSecPwr:= MagicManager.GetNGPow(TargeTBaseObject, THEROOBJECT(TargeTBaseObject).m_MagicSkill_229,nPower);//静之灭天火
        end;
        nPower := _MAX(0, nPower - NGSecPwr);
      end;
      {$IFEND}
      PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(nTargetX, nTargetY), 2, Integer(TargeTBaseObject), '', 600);
      if g_Config.boPlayObjectReduceMP then begin//击中减MP值,减35% 20090107
        TargeTBaseObject.DamageSpell(Abs(Round(nPower * 0.35)));
      end;
      if (PlayObject.m_btRaceServer = RC_PLAYMOSTER) or (PlayObject.m_btRaceServer = RC_HEROOBJECT) then Result := True
      else if TargeTBaseObject.m_btRaceServer >= RC_ANIMAL then Result := True;
    end else TargeTBaseObject := nil
  end else TargeTBaseObject := nil;
end;

//火焰冰 20080410
function TPlayMonster.MabMabe(BaseObject, TargeTBaseObject: TBaseObject; nPower, nLevel,
  nTargetX, nTargetY: Integer): Boolean;
var
  nLv: Integer;
begin
  Result := False;
  if BaseObject.MagCanHitTarget(BaseObject.m_nCurrX, BaseObject.m_nCurrY, TargeTBaseObject) then begin
    if BaseObject.IsProperTarget(TargeTBaseObject) and (BaseObject <> TargeTBaseObject) then begin
      if (TargeTBaseObject.m_nAntiMagic <= Random(10)) and (abs(TargeTBaseObject.m_nCurrX - nTargetX) <= 1) and (abs(TargeTBaseObject.m_nCurrY - nTargetY) <= 1) then begin
        BaseObject.SendDelayMsg(BaseObject, RM_DELAYMAGIC, nPower div 3, MakeLong(nTargetX, nTargetY), 2, Integer(TargeTBaseObject), '', 600);
        if (Random(2) + (BaseObject.m_Abil.Level - 1)) > TargeTBaseObject.m_Abil.Level then begin
          nLv := BaseObject.m_Abil.Level - TargeTBaseObject.m_Abil.Level;
          if (Random(g_Config.nMabMabeHitRandRate {100}) < _MAX(g_Config.nMabMabeHitMinLvLimit, (nLevel * 8) - nLevel + 15 + nLv)) {or (Random(abs(nLv))} then begin
            if (Random(g_Config.nMabMabeHitSucessRate {21}) < nLevel * 2 + 4) then begin
              if TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
                BaseObject.SetPKFlag(BaseObject);
                BaseObject.SetTargetCreat(TargeTBaseObject);
              end;
              TargeTBaseObject.SetLastHiter(BaseObject);
              nPower := TargeTBaseObject.GetMagStruckDamage(BaseObject, nPower, 0, 1);
              BaseObject.SendDelayMsg(BaseObject, RM_DELAYMAGIC, nPower, MakeLong(nTargetX, nTargetY), 2, Integer(TargeTBaseObject), '', 600);
              if (not TargeTBaseObject.m_boUnParalysis){$IF M2Version <> 2} and (not TargeTBaseObject.m_boCanUerSkill102){$IFEND} then
                TargeTBaseObject.SendDelayMsg(BaseObject, RM_POISON, POISON_STONE {中毒类型 - 麻痹}, nPower div g_Config.nMabMabeHitMabeTimeRate {20} + Random(nLevel), Integer(BaseObject), nLevel, '', 650);
              Result := True;
            end;
          end;
        end;
      end;
    end;
  end;
end;
//定时检测物品是否过期  20110521
procedure TPlayMonster.CheckItemsDay();
var
  I: Integer;
  UserItem: pTUserItem;
  boSendFeat: Boolean;
begin
  if (not m_boDeath) and (not m_boGhost) then begin
    boSendFeat:= False;
    for I := Low(THumanUseItems) to High(THumanUseItems) do begin
      if m_UseItems[I].wIndex > 0 then begin
        if (m_UseItems[I].AddValue[0] = 1) and (GetHoursCount(m_UseItems[I].MaxDate, Now) <= 0) then begin //删除到期装备
          m_UseItems[I].wIndex := 0;
          m_UseItems[I].MakeIndex := 0;
          boSendFeat:= True;
        end;
      end;
    end;
    if boSendFeat then FeatureChanged;
  end;
end;
{$IF M2Version <> 2}
//气血石功能 20080729
procedure TPlayMonster.PlaySuperRock;
var
  StdItem: pTStdItem;
  nTempDura: Integer;
begin
  Try
    //气血石 魔血石                                                                                                  //20080611
    if (not m_boDeath) and (not m_boGhost) and (m_WAbil.HP > 0) then begin
      if (m_UseItems[U_CHARM].wIndex > 0) and (m_UseItems[U_CHARM].Dura > 0) then begin
        StdItem := UserEngine.GetStdItem(m_UseItems[U_CHARM].wIndex);
        if (StdItem <> nil) then begin//20090128
          if (StdItem.Shape > 0) and m_PEnvir.AllowStdItems(StdItem.Name) then begin
            case StdItem.Shape of
              1: begin //气血石
                  if (m_WAbil.MaxHP - m_WAbil.HP) >= g_Config.nStartHPRock then begin//200081215 改成掉点数启用
                    if GetTickCount - dwRockAddHPTick > g_Config.nHPRockSpell then begin
                      dwRockAddHPTick:= GetTickCount();//气石加HP间隔
                      if m_UseItems[U_CHARM].Dura * 10 > g_Config.nHPRockDecDura then begin
                        Inc(m_WAbil.HP, g_Config.nRockAddHP);
                        nTempDura := m_UseItems[U_CHARM].Dura * 10;
                        Dec(nTempDura, g_Config.nHPRockDecDura);
                        m_UseItems[U_CHARM].Dura := Round(nTempDura / 10);
                        if m_UseItems[U_CHARM].Dura <= 0 then m_UseItems[U_CHARM].wIndex:= 0;
                      end else begin
                        Inc(m_WAbil.HP, g_Config.nRockAddHP);
                        m_UseItems[U_CHARM].Dura := 0;
                        m_UseItems[U_CHARM].wIndex:= 0;
                      end;
                      if m_WAbil.HP > m_WAbil.MaxHP then m_WAbil.HP := m_WAbil.MaxHP;
                      PlugHealthSpellChanged();
                    end;
                  end;
                end;
              2: begin
                  if (m_WAbil.MaxMP - m_WAbil.MP) >= g_Config.nStartMPRock then begin//200081215 改成掉点数启用
                    if GetTickCount - dwRockAddMPTick > g_Config.nMPRockSpell then begin
                      dwRockAddMPTick:= GetTickCount;//气石加MP间隔
                      if m_UseItems[U_CHARM].Dura * 10 > g_Config.nMPRockDecDura then begin
                        Inc(m_WAbil.MP, g_Config.nRockAddMP);
                        nTempDura := m_UseItems[U_CHARM].Dura * 10;
                        Dec(nTempDura, g_Config.nMPRockDecDura);
                        m_UseItems[U_CHARM].Dura := Round(nTempDura / 10);
                        if m_UseItems[U_CHARM].Dura <= 0 then m_UseItems[U_CHARM].wIndex:= 0;
                      end else begin
                        Inc(m_WAbil.MP, g_Config.nRockAddMP);
                        m_UseItems[U_CHARM].Dura := 0;
                        m_UseItems[U_CHARM].wIndex:= 0;
                      end;
                      if m_WAbil.MP > m_WAbil.MaxMP then  m_WAbil.MP:= m_WAbil.MaxMP ;
                      PlugHealthSpellChanged();
                    end;
                  end;
                end;
              3: begin
                if (m_WAbil.MaxHP - m_WAbil.HP ) >= g_Config.nStartHPMPRock then begin//200081215 改成掉点数启用
                    if GetTickCount - dwRockAddHPTick > g_Config.nHPMPRockSpell then begin
                      dwRockAddHPTick:= GetTickCount;//气石加HP间隔
                      if m_UseItems[U_CHARM].Dura * 10 > g_Config.nHPMPRockDecDura then begin
                        Inc(m_WAbil.HP, g_Config.nRockAddHPMP);
                        nTempDura := m_UseItems[U_CHARM].Dura * 10;
                        Dec(nTempDura, g_Config.nHPMPRockDecDura);
                        m_UseItems[U_CHARM].Dura := Round(nTempDura / 10);
                        if m_UseItems[U_CHARM].Dura <= 0 then m_UseItems[U_CHARM].wIndex:= 0;
                      end else begin
                        Inc(m_WAbil.HP, g_Config.nRockAddHPMP);
                        m_UseItems[U_CHARM].Dura := 0;
                        m_UseItems[U_CHARM].wIndex:= 0;
                      end;
                      if m_WAbil.HP > m_WAbil.MaxHP then m_WAbil.HP := m_WAbil.MaxHP;
                      PlugHealthSpellChanged();
                    end;
                  end;
                //======================================================================
                 if (m_WAbil.MaxMP - m_WAbil.MP ) >= g_Config.nStartHPMPRock then begin//200081215 改成掉点数启用
                    if GetTickCount - dwRockAddMPTick > g_Config.nHPMPRockSpell then begin
                      dwRockAddMPTick:= GetTickCount;//气石加MP间隔
                      if m_UseItems[U_CHARM].Dura * 10 > g_Config.nHPMPRockDecDura then begin
                        Inc(m_WAbil.MP, g_Config.nRockAddHPMP);
                        nTempDura := m_UseItems[U_CHARM].Dura * 10;
                        Dec(nTempDura, g_Config.nHPMPRockDecDura);
                        m_UseItems[U_CHARM].Dura := Round(nTempDura / 10);
                        if m_UseItems[U_CHARM].Dura <= 0 then m_UseItems[U_CHARM].wIndex:= 0;
                      end else begin
                        Inc(m_WAbil.MP, g_Config.nRockAddHPMP);
                        m_UseItems[U_CHARM].Dura := 0;
                        m_UseItems[U_CHARM].wIndex:= 0;
                      end;
                      if m_WAbil.MP > m_WAbil.MaxMP then m_WAbil.MP := m_WAbil.MaxMP;
                      PlugHealthSpellChanged();
                    end;
                  end;
              end;//3 begin
              5: begin//天龙印
                 if (m_WAbil.MaxHP - m_WAbil.HP ) >= g_Config.nStartHPMPRock1 then begin//200081215 改成掉点数启用
                    if GetTickCount - dwRockAddHPTick > g_Config.nHPMPRockSpell1 then begin
                      dwRockAddHPTick:= GetTickCount;//气石加HP间隔
                      if m_UseItems[U_CHARM].Dura * 10 > g_Config.nHPMPRockDecDura1 then begin
                        Inc(m_WAbil.HP, g_Config.nRockAddHPMP1);
                        nTempDura := m_UseItems[U_CHARM].Dura * 10;
                        Dec(nTempDura, g_Config.nHPMPRockDecDura1);
                        m_UseItems[U_CHARM].Dura := Round(nTempDura / 10);
                      end else begin
                        Inc(m_WAbil.HP, g_Config.nRockAddHPMP1);
                        m_UseItems[U_CHARM].Dura := 0;
                        RecalcAbilitys();
                      end;
                      if m_WAbil.HP > m_WAbil.MaxHP then m_WAbil.HP := m_WAbil.MaxHP;
                      PlugHealthSpellChanged();
                    end;
                 end;
                //======================================================================
                 if (m_WAbil.MaxMP - m_WAbil.MP ) >= g_Config.nStartHPMPRock1 then begin//200081215 改成掉点数启用
                    if GetTickCount - dwRockAddMPTick > g_Config.nHPMPRockSpell1 then begin
                      dwRockAddMPTick:= GetTickCount;//气石加MP间隔
                      if m_UseItems[U_CHARM].Dura * 10 > g_Config.nHPMPRockDecDura1 then begin
                        Inc(m_WAbil.MP, g_Config.nRockAddHPMP1);
                        nTempDura := m_UseItems[U_CHARM].Dura * 10;
                        Dec(nTempDura, g_Config.nHPMPRockDecDura1);
                        m_UseItems[U_CHARM].Dura := Round(nTempDura / 10);
                      end else begin
                        Inc(m_WAbil.MP, g_Config.nRockAddHPMP1);
                        m_UseItems[U_CHARM].Dura := 0;
                        RecalcAbilitys();
                      end;
                      if m_WAbil.MP > m_WAbil.MaxMP then m_WAbil.MP := m_WAbil.MaxMP;
                      PlugHealthSpellChanged();
                    end;
                 end;
              end;//5 begin
            end;
          end;
        end;
      end;
    end;
  except
    MainOutMessage(Format('{%s} TPlayMonster.PlaySuperRock', [g_sExceptionVer]));
  end;
end;
{$IFEND}
//人形进行野蛮冲撞 20081016
function TPlayMonster.DoMotaebo(nDir: Byte; nMagicLevel: Integer): Boolean;
  function CanMotaebo(BaseObject: TBaseObject): Boolean;
  var
    nC: Integer;
  begin
    Result := False;
    if (m_Abil.Level > BaseObject.m_Abil.Level) and (not BaseObject.m_boStickMode) then begin
      nC := m_Abil.Level - BaseObject.m_Abil.Level;
      if Random(20) < ((nMagicLevel * 4) + 6 + nC) then begin
        if IsProperTarget(BaseObject) then Result := True;
      end;
    end;
  end;
var
  bo35: Boolean;
  I, n20, n24, n28: Integer;
  PoseCreate: TBaseObject;
  BaseObject_30: TBaseObject;
  BaseObject_34: TBaseObject;
  nX, nY: Integer;
begin
  Result := False;
  bo35 := True;
  m_btDirection := nDir;
  BaseObject_34 := nil;
  n24 := nMagicLevel + 1;
  n28 := n24;
  PoseCreate := GetPoseCreate();
  if PoseCreate <> nil then begin
    for I := 0 to _MAX(2, nMagicLevel + 1) do begin
      PoseCreate := GetPoseCreate();
      if PoseCreate <> nil then begin
        n28 := 0;
        if not CanMotaebo(PoseCreate) then Break;
        if nMagicLevel >= 3 then begin
          if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, 2, nX, nY) then begin
            BaseObject_30 := m_PEnvir.GetMovingObject(nX, nY, True);
            if (BaseObject_30 <> nil) and CanMotaebo(BaseObject_30) then
              BaseObject_30.CharPushed(m_btDirection, 1);
          end;
        end;
        BaseObject_34 := PoseCreate;
        if PoseCreate.CharPushed(m_btDirection, 1) <> 1 then Break;
        GetFrontPosition(nX, nY);
        if m_PEnvir.MoveToMovingObject(m_nCurrX, m_nCurrY, Self, nX, nY, False) > 0 then begin
          m_nCurrX := nX;
          m_nCurrY := nY;
          SendRefMsg(RM_RUSH, nDir, m_nCurrX, m_nCurrY, 0, '');
          bo35 := False;
          Result := True;
        end;
        Dec(n24);
      end; //if PoseCreate <> nil  then begin
    end; //for i:=0 to _MAX(2,nMagicLevel + 1) do begin
  end else begin //if PoseCreate <> nil  then begin
    bo35 := False;
    for I := 0 to _MAX(2, nMagicLevel + 1) do begin
      GetFrontPosition(nX, nY); //sub_004B2790
      if m_PEnvir.MoveToMovingObject(m_nCurrX, m_nCurrY, Self, nX, nY, False) > 0 then begin
        m_nCurrX := nX;
        m_nCurrY := nY;
        SendRefMsg(RM_RUSH, nDir, m_nCurrX, m_nCurrY, 0, '');
        Dec(n28);
      end else begin
        if m_PEnvir.CanWalk(nX, nY, True) then n28 := 0
        else begin
          bo35 := True;
          Break;
        end;
      end;
    end;
  end;
  if (BaseObject_34 <> nil) then begin
    if n24 < 0 then n24 := 0;
    //n20 := Random((n24 + 1) * 10) + ((n24 + 1) * 10);
    if n24 > 3 then n24 := 3; //20090302 更换算法
    n20 := Random((n24 + 1) * 5) + ((n24 + 1) * 5);    
    n20 := BaseObject_34.GetHitStruckDamage(Self, n20);
    BaseObject_34.StruckDamage(n20);
    BaseObject_34.SendRefMsg(RM_STRUCK, n20, BaseObject_34.m_WAbil.HP, BaseObject_34.m_WAbil.MaxHP, Integer(Self), '');
    if BaseObject_34.m_btRaceServer <> RC_PLAYOBJECT then begin
      BaseObject_34.SendMsg(BaseObject_34, RM_STRUCK, n20, BaseObject_34.m_WAbil.HP, BaseObject_34.m_WAbil.MaxHP, Integer(Self), '');
    end;
  end;
  if bo35 then begin
    GetFrontPosition(nX, nY);
    SendRefMsg(RM_RUSHKUNG, m_btDirection, nX, nY, 0, '');
  end;
  if n28 > 0 then begin
    if n24 < 0 then n24 := 0;
    n20 := Random(n24 * 10) + ((n24 + 1) * 3);
    n20 := GetHitStruckDamage(Self, n20);
    StruckDamage(n20);
    SendRefMsg(RM_STRUCK, n20, m_WAbil.HP, m_WAbil.MaxHP, 0, '');
  end;
end;

procedure TPlayMonster.Die;
var
  FlowerEvent: TFlowerEvent;
begin
  if (m_Master <> nil) then begin
    FlowerEvent := TFlowerEvent.Create(m_PEnvir, m_nCurrX, m_nCurrY, SM_HEROLOGOUT, 4000); //人物的分身死了，直接消失(与收英雄一样效果) 20100408
    g_EventManager.AddEvent(FlowerEvent);
    MakeGhost;
  end else inherited;
end;

end.
