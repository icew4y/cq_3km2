unit ObjAIPlayObject;

interface
uses
  Windows, Classes, ObjBase, SysUtils, Envir, MapPoint, PathFind, Grobal2;
type
  TAIPlayObject = class(TPlayObject)//假人
    m_dwSearchTargetTick: LongWord;
    m_boAIStart: Boolean;//假人启动
    m_ManagedEnvir: TEnvirnoment; //挂机地图
    m_PointManager: TPointManager;
    m_Path: TPath;
    m_nPostion: Integer;
    m_nMoveFailCount: Integer;
    m_sConfigListFileName: string;
    m_sHeroConfigListFileName: string;
    m_sFilePath: string;
    m_sConfigFileName: string;
    m_sHeroConfigFileName: string;
    m_BagItemNames: TStringList;
    m_UseItemNames: TUseItemNames;
    m_RunPos: TRunPos;
    m_SkillUseTick: array[0..{79}58] of LongWord; //魔法使用间隔
    m_nSelItemType: Integer;
    m_nIncSelfHealthCount: Integer;
    m_nIncMasterHealthCount: Integer;
    m_wHitMode: Word;//攻击方式
    m_boSelSelf: Boolean;
    m_btTaoistUseItemType: Byte;
    m_dwAutoRepairItemTick: LongWord;
    m_dwAutoAddHealthTick: LongWord;
    m_dwThinkTick: LongWord;
    m_boDupMode: Boolean;
    m_dwSearchMagic: LongWord;
    m_dwHPToMapHomeTick: LongWord;//低血回城间隔
    m_boProtectStatus: Boolean;//守护模式
    m_nProtectTargetX, m_nProtectTargetY: Integer;//守护坐标
    m_boProtectOK: Boolean;//到达守护坐标
    m_nGotoProtectXYCount: Integer;//是向守护坐标的累计数
    m_dwPickUpItemTick: LongWord;
    m_SelMapItem: PTMapItem;
    m_dwHeroUseSpellTick: LongWord;//使用合击间隔
    dwTick5F4: LongWord;//跑步计时
    {$IF M2Version = 1}
    m_BatterMagicList: TList;//连击技能列表
    {$IFEND}
    m_AISayMsgList: TStringList;//受攻击说话列表
    m_boAutoRecallHero: Boolean;//自动召唤英雄
    n_AmuletIndx: Byte;//绿红毒标识
    m_boCanPickIng: Boolean;
    m_nSelectMagic: Integer;//查询魔法
    m_boIsUseMagic: Boolean;//是否可以使用的魔法(True才可能躲避)
    m_boIsUseAttackMagic: Boolean;//是否可以使用的攻击魔法
    m_btLastDirection: Byte;//最后的方向
    m_dwAutoAvoidTick: LongWord;//自动躲避间隔
    m_boIsNeedAvoid: Boolean;//是否需要躲避
  private
    function RunToNext(nX, nY: Integer): Boolean;
    function WalkToNext(nX, nY: Integer): Boolean;
    function WalkToTargetXY2(nTargetX, nTargetY: Integer): Boolean;

    function AllowUseMagic(wMagIdx: Word): Boolean;
    function CanLineAttack(nStep: Integer): Boolean; overload;
    function CanLineAttack(nCurrX, nCurrY: Integer): Boolean; overload;
    function GetUserItemList(nItemType, nCount: Integer): Integer;
    function UseItem(nItemType, nIndex: Integer): Boolean;//自动换毒符
    function CheckUserItemType(nItemType, nCount: Integer): Boolean;
    function CheckUserItem(nItemType, nCount: Integer): Boolean;
    function CheckItemType(nItemType: Integer; StdItem: pTStdItem): Boolean;
    function GetNearTargetCount(): Integer; overload;
    function GetNearTargetCount(nCurrX, nCurrY: Integer): Integer; overload;
    function GetRangeTargetCountByDir(nDir, nX, nY, nRange: Integer): Integer;
    function GetRangeTargetCount(nX, nY, nRange: Integer): Integer;
    function FindVisibleActors(ActorObject: TBaseObject): Boolean;
    function FollowMaster: Boolean;
    function GetMasterRange(nTargetX, nTargetY: Integer): Integer;
    function CanWalk(nCurrX, nCurrY, nTargetX, nTargetY: Integer; nDir: Integer; var nStep: Integer; boFlag: Boolean): Boolean;
    function IsGotoXY(X1, Y1, X2, Y2: Integer): Boolean;
    function GotoNext(nX, nY: Integer; boRun: Boolean): Boolean;
    function IsUseAttackMagic(): Boolean; //检测是否可以使用攻击魔法

    (*function SelectMagic(): Integer;
    function WarrAttackTarget(wMagIdx, wHitMode: Word): Boolean;{物理攻击}
    function WarrorAttackTarget(wMagIdx: Word): Boolean;{战士攻击}
    function WizardAttackTarget(wMagIdx: Word): Boolean;{法师攻击}
    function TaoistAttackTarget(wMagIdx: Word): Boolean;{道士攻击}*)

    function UseSpell(UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTBaseObject: TBaseObject): Boolean;
    function AutoSpell(UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; BaseObject: TBaseObject): Boolean;
    //function StartAttack(wMagIdx: Word): Boolean;
    function DoThink(wMagicID: Word): Integer;
    function ActThink(wMagicID: Word): Boolean;
    function CanAttack(BaseObject: TBaseObject; nRange: Integer; var btDir: Byte): Boolean; overload;
    function CanAttack(nCurrX, nCurrY: Integer; BaseObject: TBaseObject; nRange: Integer; var btDir: Byte): Boolean; overload;
    procedure GotoProtect();
    function SearchPickUpItem(nPickUpTime: Integer): Boolean;
    {$IF M2Version = 1}
    function GetBatterMagic(): Boolean;//取连击技能ID
    function HeroBatterAttackTarget(): Boolean;//连击处理过程
    procedure HeroBatterStop();//连击停止
    procedure UseBatterSpell(nMagicID{技能ID},StormsHit{暴击率}: Byte);//放连击
    procedure BatterAttackDir(TargeTBaseObject: TBaseObject; wHitMode: Word; StormsHit{暴击率}: Byte);//战连击处理
    {$IFEND}
    {procedure NewGotoTargetXY;
    procedure HeroTail();}    
    function WarrAttackTarget1(wHitMode: Word): Boolean; {物理攻击}
    function WarrorAttackTarget1(): Boolean; {战士攻击}
    function WizardAttackTarget1(): Boolean; {法师攻击}
    function TaoistAttackTarget1(): Boolean; {道士攻击}
    function AttackTarget(): Boolean;
    function IsNeedAvoid(): Boolean;//是否需要躲避
    function AutoAvoid(): Boolean; //自动躲避
    function IsNeedGotoXY(): Boolean; //是否走向目标
    function GetGotoXY(BaseObject: TBaseObject; nCode:Byte): Boolean;//取刺杀位 20080604
    function GotoTargetXY(nTargetX, nTargetY, nCode: Integer): Boolean;
    procedure SearchMagic();
    function SelectMagic1(): Integer;
    function CheckTargetXYCount(nX, nY, nRange: Integer): Integer;
    function CheckTargetXYCount1(nX, nY, nRange: Integer): Integer;//战士判断使用
    function CheckTargetXYCount2(nMode: Word): Integer;//半月弯刀判断目标函数
    function CheckTargetXYCount3(nX, nY, nRange, nCount: Integer): Integer;//气功波，抗拒火环使用
    function CheckTargetXYCountOfDirection(nX, nY, nDir, nRange: Integer): Integer;{检测指定方向和范围内坐标的怪物数量}
    function RunToTargetXY(nTargetX, nTargetY: Integer): Boolean;//跑到目标坐标
    function WalkToTargetXY(nTargetX, nTargetY: Integer): Boolean;//走向目标
    Function CheckHeroAmulet(nType: Integer; nCount: Integer):Boolean;
  protected
    function GotoNextOne(nX, nY: Integer; boRun: Boolean): Boolean;
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Initialize; override;
    procedure Run; override;
    procedure SearchViewRange(); override;
    function Thinking: Boolean;
    function Operate(ProcessMsg: pTProcessMessage): Boolean; override;
    procedure Wondering(); override;
    procedure SearchTarget(); override;
    procedure Start(PathType: TPathType);
    procedure Stop;
    procedure MakeGhost; override;
    procedure ProcessSayMsg(sData: string); override;
    procedure Whisper(whostr, saystr: string); override;
    procedure Hear(nIndex: Integer; sMsg: string); override;
    procedure Die; override;
    procedure Struck(hiter: TBaseObject); override;
    function IsProtectTarget(BaseObject: TBaseObject): Boolean; override;
    function IsAttackTarget(BaseObject: TBaseObject): Boolean; override;
    function IsProperTarget(BaseObject: TBaseObject): Boolean; override;
    function IsProperFriend(BaseObject: TBaseObject): Boolean; override;
    function FindMagic(wMagIdx: Word): pTUserMagic; overload;
    function FindMagic(sMagicName: string): pTUserMagic; overload;
    function GetRandomConfigFileName(sName: String; nType: Byte): string;
  end;

implementation
uses M2Share, HUtil32, Guild, IniFiles, ObjHero, Event;
{TAIPlayObject}

constructor TAIPlayObject.Create();
begin
  inherited;
  m_nSoftVersionDate := CLIENT_VERSION_NUMBER;
  m_nSoftVersionDateEx := GetExVersionNO(CLIENT_VERSION_NUMBER, m_nSoftVersionDate);

  AbilCopyToWAbil();
  m_btAttatckMode:= 0;
  m_boAI := True;
  m_boLoginNoticeOK := True;
  m_boAIStart := False; //开始挂机
  m_ManagedEnvir := nil; //挂机地图
  m_Path := nil;
  m_nPostion := -1;
  m_sFilePath := '';
  m_sConfigFileName := '';
  m_sHeroConfigFileName := '';
  m_sConfigListFileName := '';
  m_sHeroConfigListFileName:='';
  FillChar(m_UseItemNames, SizeOf(TUseItemNames), #0);
  FillChar(m_RunPos, SizeOf(TRunPos), #0);
  m_BagItemNames := TStringList.Create;
  m_PointManager := TPointManager.Create(Self);
  FillChar(m_SkillUseTick, SizeOf(m_SkillUseTick), 0); //魔法使用间隔
  m_nSelItemType := 1;
  m_nIncSelfHealthCount := 0;
  m_nIncMasterHealthCount:= 0;
  m_boSelSelf:= False;
  m_btTaoistUseItemType:= 0;
  m_dwAutoAddHealthTick:= GetTickCount;
  m_dwAutoRepairItemTick:= GetTickCount;
  m_dwThinkTick:= GetTickCount;
  m_boDupMode:= False;
  m_boProtectStatus:= False;//守护模式
  m_boProtectOK:= True;//到达守护坐标
  m_nGotoProtectXYCount:= 0;//是向守护坐标的累计数
  m_SelMapItem := nil;
  m_dwPickUpItemTick:= GetTickCount;
  m_dwHeroUseSpellTick:= GetTickCount;//使用合击间隔
  {$IF M2Version = 1}
  m_BatterMagicList:= TList.Create;//连击技能列表
  {$IFEND}
  m_AISayMsgList:= TStringList.Create;//受攻击说话列表
  m_boAutoRecallHero:= False;//自动召唤英雄
  n_AmuletIndx:= 0;
  m_boCanPickIng:= False;
  m_nSelectMagic:= 0;
  m_boIsUseMagic := False;//是否能躲避
  m_boIsUseAttackMagic := False;
  m_btLastDirection := m_btDirection;
  m_dwAutoAvoidTick:= GetTickCount;//自动躲避间隔
  m_boIsNeedAvoid := False;//是否需要躲避
  m_dwWalkTick:= GetTickCount;
  m_nWalkSpeed := 300;
end;

destructor TAIPlayObject.Destroy;
begin
{$IF M2Version = 1}
  try
    if m_BatterMagicList <> nil then begin
      FreeAndNil(m_BatterMagicList);
    end;
  except
  end;
{$IFEND}
  m_AISayMsgList.Free;
  m_Path := nil;
  m_BagItemNames.Free;
  m_PointManager.Free;
  inherited;
end;
{$IF M2Version = 1}
//取连击技能ID
function TAIPlayObject.GetBatterMagic(): Boolean;
var
  LoadList: TStringList;
  I, K: Integer;
  nCode: Byte;
begin
  Result:= False;
  nCode:= 0;
  try
    if m_boDeath or m_boGhost or ((m_wStatusTimeArr[POISON_STONE {5}] <> 0) and
      not g_ClientConf.boParalyCanHit) or (m_Skill69NH < 11) or
      (m_wStatusTimeArr[POISON_LOCKSPELL{7}] <> 0) or (m_wStatusArrValue[23] <> 0) then begin //防麻
      Exit;
    end;
    nCode:= 1;
    if m_boTrainingNG and m_boTrainBatterSkill and (not m_boUseBatter) and (m_TargetCret <> nil) and
      (GetTickCount()- m_nUseBatterTick > g_Config.dwUseBatterTick) and (m_BatterMagicList.Count > 0) then begin//学过连击，并且时间达到
      m_nUseBatterTick:= GetTickCount();
      m_nBatterMagIdx1:= 0;//连击技能ID1
      m_nBatterMagIdx2:= 0;//连击技能ID2
      m_nBatterMagIdx3:= 0;//连击技能ID3
      m_nBatterMagIdx4:= 0;//连击技能ID4
      LoadList:= TStringList.Create;
      try
        nCode:= 3;
        for I:= 0 to m_BatterMagicList.Count -1  do begin
          nCode:= 4;
          if pTUserMagic(m_BatterMagicList[i]) <> nil then begin//20091124 增加
            nCode:= 52;
            case pTUserMagic(m_BatterMagicList[i]).btKey of
              0: begin
                nCode:= 53;
                if pTUserMagic(m_BatterMagicList[i]).MagicInfo <> nil then begin//20100428 增加
                  nCode:= 57;
                  try
                    LoadList.Add(IntToStr(pTUserMagic(m_BatterMagicList[i]).MagicInfo.wMagicId));//取出没有设置快捷键的技能ID
                  except
                  end;
                end;
              end;
              1: begin
                if pTUserMagic(m_BatterMagicList[i]).MagicInfo <> nil then begin//20100914 增加
                  nCode:= 54;
                  m_nBatterMagIdx1:= pTUserMagic(m_BatterMagicList[i]).MagicInfo.wMagicId;
                end;
              end;
              2: begin
                if pTUserMagic(m_BatterMagicList[i]).MagicInfo <> nil then begin//20100914 增加
                  nCode:= 55;
                  m_nBatterMagIdx2:= pTUserMagic(m_BatterMagicList[i]).MagicInfo.wMagicId;
                end;
              end;
              3: begin
                if pTUserMagic(m_BatterMagicList[i]).MagicInfo <> nil then begin//20100914 增加
                  nCode:= 56;
                  m_nBatterMagIdx3:= pTUserMagic(m_BatterMagicList[i]).MagicInfo.wMagicId;
                end;
              end;
              4: begin
                nCode:= 56;
                if m_boUser4BatterSkill and (pTUserMagic(m_BatterMagicList[i]).MagicInfo <> nil) then//开启第四格连击 20100720
                  m_nBatterMagIdx4:= pTUserMagic(m_BatterMagicList[i]).MagicInfo.wMagicId;
              end;
            end;
          end;
        end;
        nCode:= 51;
        if (m_SetBatterKey = 1) and (LoadList.Count > 0) then begin//第一格随机选择技能ID
          K := Random(LoadList.Count);
          m_nBatterMagIdx1 := Str_ToInt(LoadList.Strings[K], 0);
          LoadList.Delete(K);
        end;
        nCode:= 6;
        if m_nBatterMagIdx1 > 0 then begin
          if (m_SetBatterKey1 = 1) and (LoadList.Count > 0) then begin//第二格随机选择技能ID
            nCode:= 7;
            K := Random(LoadList.Count);
            m_nBatterMagIdx2 := Str_ToInt(LoadList.Strings[K], 0);
            LoadList.Delete(K);
          end;
          nCode:= 8;
          if m_nBatterMagIdx2 > 0 then begin
            if (m_SetBatterKey2 = 1) and (LoadList.Count > 0) then begin//第三格随机选择技能ID
              nCode:= 9;
              K := Random(LoadList.Count);
              m_nBatterMagIdx3 := Str_ToInt(LoadList.Strings[K], 0);
              LoadList.Delete(K);
            end;
          end;
          if m_nBatterMagIdx3 > 0 then begin
            if (m_SetBatterKey3 = 1) and (LoadList.Count > 0) and m_boUser4BatterSkill then begin//第四格随机选择技能ID
              nCode:= 9;
              K := Random(LoadList.Count);
              m_nBatterMagIdx4 := Str_ToInt(LoadList.Strings[K], 0);
              LoadList.Delete(K);
            end;
          end;
          m_boUseBatter:= True;//使用连击
          Result:= True;
          nCode:= 11;
          if m_btJob = 0 then begin//战
            m_boWarUseBatter:= False;
            m_dwLatestWarUseBatterTick:= GetTickCount();
          end else begin//道法
            m_nDecDamageRate:= Random(g_Config.dwBatterRandDecDamageRate) + g_Config.dwBatterDecDamageRate;//吸伤比率
          end;
        end else begin
          m_nBatterMagIdx2 := 0;
          m_nBatterMagIdx3 := 0;
          m_nBatterMagIdx4 := 0;
        end;
        nCode:= 10;
        if (m_nBatterMagIdx4 = m_nBatterMagIdx1) or (m_nBatterMagIdx4 = m_nBatterMagIdx2) or (m_nBatterMagIdx4 = m_nBatterMagIdx3) or (m_nBatterMagIdx2 = 0) or (m_nBatterMagIdx3 = 0) or (m_nBatterMagIdx2 = m_nBatterMagIdx3) then begin
          m_nBatterMagIdx4 := 0;
        end;
        if (m_nBatterMagIdx3 = m_nBatterMagIdx1) or (m_nBatterMagIdx3 = m_nBatterMagIdx2) or (m_nBatterMagIdx2 = 0) or (m_nBatterMagIdx3 = 0) then begin
          m_nBatterMagIdx3 := 0;
          m_nBatterMagIdx4 := 0;
        end;
        if (m_nBatterMagIdx2 = m_nBatterMagIdx1) or (m_nBatterMagIdx2 = m_nBatterMagIdx3) or (m_nBatterMagIdx2 = 0) then begin
          m_nBatterMagIdx2 := 0;
          m_nBatterMagIdx3 := 0;
          m_nBatterMagIdx4 := 0;
        end;
      finally
        LoadList.Free;
      end;
    end;
  except
    MainOutMessage(Format('{%s} TAIPlayObject.GetBatterMagic Code:%d',[g_sExceptionVer, nCode]));
  end;
end;

//连击处理过程
function TAIPlayObject.HeroBatterAttackTarget(): Boolean;
var
  BoWarrorAttack: Boolean;
  nCode: Byte;
begin
  Result := False;
  nCode:= 0;
  try
    if m_boDeath or m_boGhost then Exit;//20091124 增加
    nCode:= 1;
    if (not m_boUseBatter) and (m_TargetCret <> nil) then GetBatterMagic;//取连击技能ID
    if m_boUseBatter then begin
      nCode:= 2;
      if m_btJob > 0 then begin//道法职业
        if GetTickCount - m_nUseBatterTime > 850 then begin//连击处理
          m_nUseBatterTime := GetTickCount();
          nCode:= 3;
          if (m_wStatusTimeArr[POISON_STONE] = 0) then m_boCanWalk:= False;//不能走
          if m_wStatusTimeArr[STATE_LOCKRUN] = 0 then m_boCanRun:= False;//不能跑
          m_boCanHit:= False;//不能打击
          m_boCanSpell:= False;//不能魔法
          nCode:= 4;
          if (m_nBatterMagIdx1 <= 0) and (m_nBatterMagIdx2 <= 0) and (m_nBatterMagIdx3 <= 0) and (m_nBatterMagIdx4 <= 0) then begin
            m_boUseBatter:= False;
            m_nDecDamageRate:= 0;//吸伤比率
            m_nUseBatterTick:= GetTickCount();//使用连击的计时
            if (m_wStatusTimeArr[POISON_STONE] = 0) then m_boCanWalk:= True;//不能走
            if m_wStatusTimeArr[STATE_LOCKRUN] = 0 then m_boCanRun:= True;//不能跑
            m_boCanHit:= True;//不能打击
            m_boCanSpell:= True;//不能魔法
          end;
          nCode:= 5;
          if m_nBatterMagIdx1 <> 0 then begin
            UseBatterSpell(m_nBatterMagIdx1, 10);//发第一个连击技能消息
            m_nBatterMagIdx1:= 0;
          end else if m_nBatterMagIdx2 <> 0 then begin
            UseBatterSpell(m_nBatterMagIdx2, 15);//发第二个连击技能消息
            m_nBatterMagIdx2:= 0;
          end else if m_nBatterMagIdx3 <> 0 then begin
            UseBatterSpell(m_nBatterMagIdx3, 25);//发第三个连击技能消息
            m_nBatterMagIdx3:= 0;
          end else if m_nBatterMagIdx4 <> 0 then begin
            UseBatterSpell(m_nBatterMagIdx4, 30);//发第三个连击技能消息
            m_nBatterMagIdx4:= 0;
          end;
        end;
      end else begin//战
        nCode:= 6;
        BoWarrorAttack:= False;
        if m_TargetCret <> nil then begin
          nCode:= 7;
          if ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 1) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 0)) or
             ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 1) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 1)) or
             ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 2) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 2)) or
             ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 2) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 0)) or
             ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 0) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 1)) or
             ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 0) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 2)) then BoWarrorAttack:= True
          else GotoNextOne(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, True);{GotoTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 0)};
        end;
        nCode:= 8;
        if (GetTickCount - m_nUseBatterTime > 100) and BoWarrorAttack then begin//连击处理
          m_nUseBatterTime := GetTickCount();
          if (not m_boWarUseBatter) then begin
            nCode:= 9;
            if (m_nBatterMagIdx1 > 0) then begin
              m_boWarUseBatter:= True;
              UseBatterSpell(m_nBatterMagIdx1, 10);
              m_dwLatestWarUseBatterTick:= GetTickCount();
              m_boWarUseBatter:= False;
              m_nBatterMagIdx1:= 0;
            end else
            if (m_nBatterMagIdx2 > 0) then begin
              m_boWarUseBatter:= True;
              UseBatterSpell(m_nBatterMagIdx2, 15);
              m_dwLatestWarUseBatterTick:= GetTickCount();
              m_boWarUseBatter:= False;
              m_nBatterMagIdx2:= 0;
            end else
            if (m_nBatterMagIdx3 > 0) then begin
              m_boWarUseBatter:= True;
              UseBatterSpell(m_nBatterMagIdx3, 25);
              m_dwLatestWarUseBatterTick:= GetTickCount();
              m_boWarUseBatter:= False;
              m_nBatterMagIdx3:= 0;
            end else
            if (m_nBatterMagIdx4 > 0) then begin
              m_boWarUseBatter:= True;
              UseBatterSpell(m_nBatterMagIdx4, 30);
              m_dwLatestWarUseBatterTick:= GetTickCount();
              m_boWarUseBatter:= False;
              m_nBatterMagIdx4:= 0;
            end;
          end;
        end;
        nCode:= 10;
        if (m_nBatterMagIdx1 <= 0) and (m_nBatterMagIdx2 <= 0) and (m_nBatterMagIdx3 <= 0) and (m_nBatterMagIdx4 <= 0) then begin
          m_nUseBatterTick:= GetTickCount();//使用连击的计时
          m_dwLatestWarUseBatterTick:= GetTickCount();
          m_boUseBatter:= False;
          m_boWarUseBatter:= False;
          Result := True;
        end;
        if m_boUseBatter then begin//战使用连击后，10秒未使用，则自动关闭 20100628
          if m_boWarUseBatter and ((GetTickCount - m_dwLatestWarUseBatterTick) > 10000) then begin
            m_boWarUseBatter:= False;
            m_boUseBatter:= False;
            m_nUseBatterTick:= GetTickCount();//使用连击的计时
            m_dwLatestWarUseBatterTick:= GetTickCount();
            m_nBatterMagIdx1:= 0;//连击技能ID1
            m_nBatterMagIdx2:= 0;//连击技能ID2
            m_nBatterMagIdx3:= 0;//连击技能ID3
            m_nBatterMagIdx4:= 0;//连击技能ID4
          end;
        end;
      end;//战
      if m_boUseBatter then begin
        Result := True;
        m_dwHitTick := GetTickCount();
      end;
    end;
  except
    MainOutMessage(Format('{%s} TAIPlayObject.BatterAttackTarget Code:%d',[g_sExceptionVer, nCode]));
  end;
end;

//连击停止
procedure TAIPlayObject.HeroBatterStop();
begin
  if m_boDeath or m_boGhost then Exit;
  m_nBatterMagIdx1:= 0;//连击技能ID1
  m_nBatterMagIdx2:= 0;//连击技能ID2
  m_nBatterMagIdx3:= 0;//连击技能ID3
  m_nBatterMagIdx4:= 0;//连击技能ID4
  if (m_btJob = 0) then begin
    m_boUseBatter:= False;
    m_boWarUseBatter:= False;
    m_dwLatestWarUseBatterTick:= GetTickCount();
  end else begin
    m_boUseBatter:= False;
    m_nDecDamageRate:= 0;//吸伤比率
    if (m_wStatusTimeArr[POISON_STONE] = 0) then m_boCanWalk:= True;//不能走
    if m_wStatusTimeArr[STATE_LOCKRUN] = 0 then m_boCanRun:= True;//不能跑
    m_boCanHit:= True;//不能打击
    m_boCanSpell:= True;//不能魔法
  end;
end;
//放连击
procedure TAIPlayObject.UseBatterSpell(nMagicID{技能ID},StormsHit{暴击率}: Byte);
var
  UserMagic: pTUserMagic;
  nSpellPoint: Integer;
  nCode: Byte;
begin
  nCode:= 0;
  try
    if m_boDeath or m_boGhost then Exit;//20091124 增加
    m_nUseBatterTick:= GetTickCount();//使用连击的计时
    UserMagic := FindMagic(nMagicID);
    nCode:= 1;
    if (m_PEnvir <> nil) then begin//地图是否禁止使用魔法
      nCode:= 2;
      if (UserMagic <> nil) then begin//20091018
        nCode:= 21;
        if not m_PEnvir.AllowMagics(UserMagic.MagicInfo.sMagicName) then begin
          nCode:= 3;
          m_nUseBatterTick:= GetTickCount();//使用连击的计时
          m_nBatterMagIdx1:= 0;//连击技能ID1 20090701
          m_nBatterMagIdx2:= 0;//连击技能ID2 20090701
          m_nBatterMagIdx3:= 0;//连击技能ID3 20090701
          m_nBatterMagIdx4:= 0;//连击技能ID4 20090701
          if (m_btJob = 0) then begin
            m_boUseBatter:= False;
            m_boWarUseBatter:= False;
            m_dwLatestWarUseBatterTick:= GetTickCount();
          end;
          Exit;
        end;
      end;
      nCode:= 4;
      if m_PEnvir.m_boMISSION then begin
        m_nUseBatterTick:= GetTickCount();//使用连击的计时
        m_nBatterMagIdx1:= 0;//连击技能ID1 20090701
        m_nBatterMagIdx2:= 0;//连击技能ID2 20090701
        m_nBatterMagIdx3:= 0;//连击技能ID3 20090701
        m_nBatterMagIdx4:= 0;//连击技能ID4
        if (m_btJob = 0) then begin
          m_boUseBatter:= False;
          m_boWarUseBatter:= False;
          m_dwLatestWarUseBatterTick:= GetTickCount();
        end;
        Exit;
      end;
    end;
    nCode:= 5;
    if (UserMagic = nil) or m_boDeath or ((m_wStatusTimeArr[POISON_STONE{5}] <> 0) and not g_ClientConf.boParalyCanHit)
      or (m_wStatusTimeArr[POISON_LOCKSPELL{7}] <> 0) or (m_wStatusArrValue[23] <> 0) then begin
      m_nUseBatterTick:= GetTickCount();//使用连击的计时
      m_nBatterMagIdx1:= 0;//连击技能ID1 20090701
      m_nBatterMagIdx2:= 0;//连击技能ID2 20090701
      m_nBatterMagIdx3:= 0;//连击技能ID3 20090701
      m_nBatterMagIdx4:= 0;//连击技能ID4
      if (m_btJob = 0) then begin
        m_boUseBatter:= False;
        m_boWarUseBatter:= False;
        m_dwLatestWarUseBatterTick:= GetTickCount();
      end;
      Exit;
    end;
    nCode:= 6;
    nSpellPoint := GetSpellPoint(UserMagic);//取放技能所需要的内力值
    if (nSpellPoint > 0) and m_boTrainingNG then begin
      nCode:= 7;
      if (m_Skill69NH < nSpellPoint) then begin
        m_nUseBatterTick:= GetTickCount();//使用连击的计时
        m_nBatterMagIdx1:= 0;//连击技能ID1 20090701
        m_nBatterMagIdx2:= 0;//连击技能ID2 20090701
        m_nBatterMagIdx3:= 0;//连击技能ID3 20090701
        m_nBatterMagIdx4:= 0;//连击技能ID4
        if (m_btJob = 0) then begin
          m_boUseBatter:= False;
          m_boWarUseBatter:= False;
          m_dwLatestWarUseBatterTick:= GetTickCount();
        end;
        Exit;
      end;
      m_Skill69NH := _MAX(0, m_Skill69NH - nSpellPoint);
      nCode:= 8;
      SendRefMsg(RM_MAGIC69SKILLNH, 0, m_Skill69NH, m_Skill69MaxNH, 0, '');
      {$IF M2Version <> 2}
      m_dwIncNHTick := GetTickCount();
      {$IFEND}
      if m_btJob > 0 then begin//道法职业
        SendRefMsg(RM_10205, 15, 0, 0, 0, '');////保护盾特效 20090628
        nCode:= 9;
        if m_TargetCret <> nil then begin
          m_nTargetX:= m_TargetCret.m_nCurrX;
          m_nTargetY:= m_TargetCret.m_nCurrY;
        end;
        nCode:= 10;
        m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_nTargetX, m_nTargetY);
        nCode:= 11;
        SendRefMsg(RM_SPELL, UserMagic.MagicInfo.btEffect, m_nTargetX, m_nTargetY, UserMagic.MagicInfo.wMagicId, '');
        case UserMagic.MagicInfo.wMagicId of
          SKILL_77: begin //双龙破{法}
              MagicManager.MagMakeSkillFire_77(self, UserMagic, m_nTargetX, m_nTargetY, m_TargetCret,StormsHit);
            end;
          SKILL_80: begin //凤舞祭{法}
              MagicManager.MagMakeSkillFire_80(self, UserMagic, m_nTargetX, m_nTargetY, m_TargetCret,StormsHit);
            end;
          SKILL_83: begin //惊雷爆{法}
              MagicManager.MagMakeSkillFire_83(self, UserMagic, m_nTargetX, m_nTargetY, m_TargetCret,StormsHit);
            end;
          SKILL_86: begin //冰天雪地{法}
              MagicManager.MagMakeSkillFire_86(self, UserMagic, m_nTargetX, m_nTargetY,StormsHit);
            end;
          SKILL_78: begin //虎啸诀{道}
              MagicManager.MagMakeSkillFire_78(self, UserMagic, m_nTargetX, m_nTargetY, m_TargetCret,StormsHit);
            end;
          SKILL_81: begin //八卦掌{道}
              MagicManager.MagMakeSkillFire_81(self, UserMagic, m_nTargetX, m_nTargetY, m_TargetCret,StormsHit);
            end;
          SKILL_84: begin //三焰咒{道}
              MagicManager.MagMakeSkillFire_84(self, UserMagic, m_nTargetX, m_nTargetY, m_TargetCret,StormsHit);
            end;
          SKILL_87: begin //万剑归宗{道}
              MagicManager.MagMakeSkillFire_87(self, UserMagic, m_nTargetX, m_nTargetY,StormsHit);
            end;
        end;//Case
        nCode:= 12;
        SendRefMsg(RM_MAGICFIRE, 0,MakeWord(UserMagic.MagicInfo.btEffectType, UserMagic.MagicInfo.btEffect),
                                MakeLong(m_nTargetX, m_nTargetY),Integer(m_TargetCret),'');
      end else begin//战
        nCode:= 18;
        case UserMagic.MagicInfo.wMagicId of
          SKILL_79: BatterAttackDir(m_TargetCret{nil}, 14, StormsHit);//追心刺 20091029
          SKILL_76: BatterAttackDir(m_TargetCret{nil}, 15, StormsHit);//三绝杀 20091029
          SKILL_82: BatterAttackDir(m_TargetCret{nil}, 17, StormsHit);//断岳斩 20091029
          SKILL_85: BatterAttackDir(m_TargetCret{nil}, 16, StormsHit);//横扫千军 20091029
        end;
      end;
    end else begin
      nCode:= 19;
      m_nUseBatterTick:= GetTickCount();//使用连击的计时
      m_nBatterMagIdx1:= 0;//连击技能ID1 20090701
      m_nBatterMagIdx2:= 0;//连击技能ID2 20090701
      m_nBatterMagIdx3:= 0;//连击技能ID3 20090701
      m_nBatterMagIdx4:= 0;//连击技能ID4
      if (m_btJob = 0) then begin
        m_boUseBatter:= False;
        m_boWarUseBatter:= False;
        m_dwLatestWarUseBatterTick:= GetTickCount();
      end;
    end;
  except
    MainOutMessage(Format('{%s} TAIPlayObject.UseBatterSpell Code:%d',[g_sExceptionVer, nCode]));
  end;
end;

//战连击处理
procedure TAIPlayObject.BatterAttackDir(TargeTBaseObject: TBaseObject; wHitMode: Word; StormsHit{暴击率}: Byte);
  function MPow(UserMagic: pTUserMagic): Integer;//计算技能威力
  var nPower:Integer;
  begin
    if UserMagic.MagicInfo.wMaxPower > UserMagic.MagicInfo.wPower then
      nPower := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower)
    else nPower := UserMagic.MagicInfo.wPower;
    if UserMagic.MagicInfo.btDefMaxPower > UserMagic.MagicInfo.btDefPower then
      Result :=Round(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower))
    else Result :=Round(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + UserMagic.MagicInfo.btDefPower;
  end;
  function DirectAttack(BaseObject: TBaseObject; nSecPwr: Integer; boStorm: Boolean): Boolean;//攻击角色
  begin
    Result := False;
    if BaseObject <> nil then begin
      if (Random(BaseObject.m_btSpeedPoint) <= (m_btHitPoint + 10)) or boStorm then begin
        BaseObject.StruckDamage(nSecPwr);
        BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10102, nSecPwr, BaseObject.m_WAbil.HP, BaseObject.m_WAbil.MaxHP, Integer(Self), '', 500);
        if (BaseObject.m_btRaceServer <> RC_PLAYOBJECT) and (BaseObject.m_btRaceServer <> RC_HEROOBJECT) then begin
          BaseObject.SendMsg(BaseObject, RM_STRUCK, nSecPwr, BaseObject.m_WAbil.HP, BaseObject.m_WAbil.MaxHP, Integer(Self), '');
        end;
        Result := True;
      end;
    end;
  end;
  function Attack_79(nSecPwr, nMagicLevel: Integer; nDir: Byte): Boolean;//追心刺
    function CanMotaebo1(BaseObject: TBaseObject; nMagicLevel: Integer): Boolean;
    var
      nC: Integer;
    begin
      Result := False;
      if (m_Abil.Level > BaseObject.m_Abil.Level) and (not BaseObject.m_boStickMode) then begin
        nC := m_Abil.Level - BaseObject.m_Abil.Level;
        if Random(20) < ((nMagicLevel * 4) + 6 + nC) then begin
          Result := True;
        end;
      end;
    end;
    function CharPushed_79(Target: TBaseObject; nDir, nPushCount: Integer): Integer;
    var
      I, nX, nY, olddir, nBackDir: Integer;
    begin
      Result := 0;
      olddir := Target.m_btDirection;
      Target.m_btDirection := nDir;
      nBackDir := GetBackDir(nDir);
      if nPushCount > 0 then begin
        for I := 0 to nPushCount - 1 do begin
          Target.GetFrontPosition(nX, nY);
          if Target.m_PEnvir.CanWalk(nX, nY, False) then begin
            if Target.m_PEnvir.MoveToMovingObject(Target.m_nCurrX, Target.m_nCurrY, Target, nX, nY, False) > 0 then begin
              Target.m_nCurrX := nX;
              Target.m_nCurrY := nY;
              Inc(Result);
            end else Break;
          end else Break;
        end;//for
        if Result > 0 then begin
          Target.SendRefMsg(RM_PUSH, nBackDir, Target.m_nCurrX, Target.m_nCurrY, 0, '');
          if Target.m_btRaceServer >= RC_ANIMAL then Target.m_dwWalkTick := Target.m_dwWalkTick + 800;
        end;
      end;
      Target.m_btDirection := nBackDir;
      if Result = 0 then Target.m_btDirection := olddir;
    end;
  var
    bo34: Boolean;
    I, n20, n24, K, nX, nY: Integer;
    PoseCreate, BaseObject_30, BaseObject_34: TBaseObject;
  begin
    Result := False;
    try
      SendRefMsg(RM_BATTERHIT1,  m_btDirection, m_nCurrX, m_nCurrY, 0, ''); //追心刺
      bo34 := True;
      m_btDirection := nDir;
      BaseObject_34 := nil;
      n24 := 0;
      PoseCreate := GetPoseCreate();//取对面的角色
      if PoseCreate = nil then begin//对面没有对像，则取两格位置的对像
        if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, 2, nX, nY) then begin
          PoseCreate := m_PEnvir.GetMovingObject(nX, nY, True);
        end;
      end;
      if PoseCreate <> nil then begin
        if IsProperTarget(PoseCreate) then begin
          BaseObject_34 := PoseCreate;
          if CanMotaebo1(PoseCreate, nMagicLevel) then begin
            if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, 2, nX, nY) then begin
              BaseObject_30 := m_PEnvir.GetMovingObject(nX, nY, True);
              if (BaseObject_30 <> nil) then bo34:= False;//后面有人则不能撞
            end;
            if bo34 then begin
              K:= CharPushed_79(PoseCreate, m_btDirection, _MAX(3, nMagicLevel + 2));
              for I := 0 to K - 1 do begin
                if PoseCreate <> nil then begin
                  GetFrontPosition(nX, nY);
                  if m_PEnvir.MoveToMovingObject(m_nCurrX, m_nCurrY, Self, nX, nY, False) > 0 then begin
                    m_nCurrX := nX;
                    m_nCurrY := nY;
                    SendRefMsg(RM_RUSH79, nDir, m_nCurrX, m_nCurrY, 0, '');
                  end else Break;
                  Inc(n24);
                end else Break; //if PoseCreate <> nil  then begin
              end; //for i:=0 to K do begin
            end;
          end;
        end;
      end;
      if (BaseObject_34 <> nil) then begin//目标掉血
        if n24 < 0 then n24 := 0;
        if n24 > 3 then n24 := 3;
        n20 := Random((n24 + 1) * 5) + nSecPwr;
        n20 := BaseObject_34.GetHitStruckDamage(Self, n20);
        BaseObject_34.StruckDamage(n20);
        BaseObject_34.SendRefMsg(RM_STRUCK, n20, BaseObject_34.m_WAbil.HP, BaseObject_34.m_WAbil.MaxHP, Integer(Self), '');
        if BaseObject_34.m_btRaceServer <> RC_PLAYOBJECT then begin
          BaseObject_34.SendMsg(BaseObject_34, RM_STRUCK, n20, BaseObject_34.m_WAbil.HP, BaseObject_34.m_WAbil.MaxHP, Integer(Self), '');
        end;
        BaseObject_34.m_wStatusTimeArr[POISON_DONTMOVE] := 1;//被打中,不可移动
        BaseObject_34.m_dwStatusArrTick[POISON_DONTMOVE] := GetTickCount();
        Result := True;
      end;
    except
    end;
  end;
  function Attack_85(nSecPwr: Integer; boStorm: Boolean): Boolean;//横扫千军
  var
    BaseObjectList: TList;
    TargeTBaseObject: TBaseObject;
    I,nPower: Integer;
  begin
    Result := False;
    BaseObjectList := TList.Create;
    try
      m_PEnvir.GetMapBaseObjects(m_nCurrX, m_nCurrY, g_Config.nBatterSkillFireRange_85, BaseObjectList);
      if BaseObjectList.Count > 0 then begin
        for I := 0 to BaseObjectList.Count - 1 do begin
          TargeTBaseObject := TBaseObject(BaseObjectList.Items[I]);
          if TargeTBaseObject <> nil then begin
            if IsProperTarget(TargeTBaseObject) and (TargeTBaseObject.m_btRaceServer <> 79) then begin //是否是适当的目标
              nPower := TargeTBaseObject.GetHitStruckDamage(Self, nSecPwr);
              Result := DirectAttack(TargeTBaseObject, nPower, boStorm);
              if (TargeTBaseObject <> nil) and Result then begin
                TargeTBaseObject.m_wStatusTimeArr[POISON_DONTMOVE] := 1;//被打中,不可移动
                TargeTBaseObject.m_dwStatusArrTick[POISON_DONTMOVE] := GetTickCount();
              end;
            end;
          end;
        end;//for
      end;
    finally
      BaseObjectList.Free;
    end;
  end;
  function Attack_82(nSecPwr: Integer; boStorm: Boolean): Boolean;//断岳斩
  var
    I, nPower: Integer;
    BaseObjectList: TList;
    TargeTBaseObject: TBaseObject;
  begin
    Result := False;
    BaseObjectList := TList.Create;
    try
      GetDirectionBaseObjects(m_btDirection, g_Config.nBatterSkillFireRange_82{3}, BaseObjectList);//同个方向的怪 3格
      if BaseObjectList.Count > 0 then begin
        for I := 0 to BaseObjectList.Count - 1 do begin
          TargeTBaseObject := TBaseObject(BaseObjectList.Items[I]);
          if TargeTBaseObject <> nil then begin
            if IsProperTarget(TargeTBaseObject) and (TargeTBaseObject.m_btRaceServer <> 79) then begin
              nPower := TargeTBaseObject.GetHitStruckDamage(Self, nSecPwr);
              Result := DirectAttack(TargeTBaseObject, nPower, boStorm);
              if (TargeTBaseObject <> nil) and Result then begin
                TargeTBaseObject.m_wStatusTimeArr[POISON_DONTMOVE] := 1;//被打中,不可移动
                TargeTBaseObject.m_dwStatusArrTick[POISON_DONTMOVE] := GetTickCount();
              end;
            end;
          end;
        end;
      end;
    finally
      BaseObjectList.Free;
    end;
  end;  
  function _BatterAttack(var wHitMode: Word; AttackTarget: TBaseObject; StormsHitRate: Byte): Boolean;
  var
    nPower, nWeaponDamage, n20: Integer;
    nCode: Byte;
    boBatterStorm: Boolean;//是否暴击 20090903
  begin
    Result := False;
    boBatterStorm := False;//是否暴击 20090903
    nWeaponDamage := 0;
    nPower :=0;
    nCode :=0;
    try
      Case wHitMode of //计算技能威力
        14: begin//追心刺
          if m_Magic79Skill <> nil then nPower := GetAttackPower(MPow(m_Magic79Skill) + LoWord(m_WAbil.DC), SmallInt((HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))));//追心刺
          if (m_Magic79Skill <> nil) and (m_Magic79Skill.btLevel > 0) and (m_Magic79Skill.btLevel < 6) then begin
            Randomize(); //随机种子
            if Random(100) <= (m_wHumanPulseArr[1].nStormsHit + StormsHitRate) then begin
              nPower:= nPower + Round(nPower * (g_Config.nStormsHitRate[m_Magic79Skill.btLevel] / 100));
              SendRefMsg(RM_10205, 14, 0, 0, 0, '');//暴击特效
              boBatterStorm := True;//是否暴击
            end;
          end;
          nPower:= nPower + m_wStatusArrValue[15];//连击伤害增加
          nCode :=2;
          if IsProperTarget(AttackTarget) and (AttackTarget.m_btRaceServer <> 79) then begin
            if (Random(AttackTarget.m_btSpeedPoint) >= m_btHitPoint) and (not boBatterStorm) then nPower := 0;
          end else nPower := 0;
          nCode :=3;
          if nPower > 0 then begin
            nCode :=4;
            nPower := AttackTarget.GetHitStruckDamage(Self, nPower);
            if m_nHongMoSuite > 0 then begin//虹魔，吸血
              m_db3B0 := nPower / 1.E2 * m_nHongMoSuite;
              if m_db3B0 >= 2.0 then begin
                n20 := Trunc(m_db3B0);
                m_db3B0 := n20;
                DamageHealth(-n20);
              end;
            end;
            {$IF M2Version = 1}
            if (nPower > 0) then begin//虎威装备吸血
              if (m_nVampirePoint > 0) and ((m_btRaceServer = RC_PLAYOBJECT) or (m_btRaceServer = RC_HEROOBJECT)) then begin
                if Random(100) <= m_nVampireRate then begin
                  n20:= 0;
                  n20 := Random(m_nVampirePoint);
                  if n20 > 0 then DamageHealth(-n20);
                end;
              end;
            end;
            {$IFEND}
          end;
          if (m_Magic79Skill <> nil) then begin //追心刺
            Attack_79(nPower, m_Magic79Skill.btLevel, m_btDirection);
          end;
          Result := True;
        end;//14
        15: begin//三绝杀
          if m_Magic76Skill <> nil then nPower := GetAttackPower(MPow(m_Magic76Skill) + LoWord(m_WAbil.DC), SmallInt((HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))));//三绝杀
          if (m_Magic76Skill <> nil) and (m_Magic76Skill.btLevel > 0) and (m_Magic76Skill.btLevel < 6) then begin
            Randomize(); //随机种子
            if Random(100) <= (m_wHumanPulseArr[0].nStormsHit + StormsHitRate) then begin
              nPower:= nPower + Round(nPower * (g_Config.nStormsHitRate[m_Magic76Skill.btLevel] / 100));
              SendRefMsg(RM_10205, 14, 0, 0, 0, '');////暴击特效
              boBatterStorm := True;//是否暴击
            end;
          end;
          nPower:= nPower + m_wStatusArrValue[15];//连击伤害增加
          nCode :=8;
          if IsProperTarget(AttackTarget) and (AttackTarget.m_btRaceServer <> 79) then begin
            if (Random(AttackTarget.m_btSpeedPoint) >= m_btHitPoint) and (not boBatterStorm) then nPower := 0;
          end else nPower := 0;
          nCode :=9;
          if (nPower > 0) and (AttackTarget <> nil) then begin
            nPower := AttackTarget.GetHitStruckDamage(Self, nPower);
            if m_nHongMoSuite > 0 then begin//虹魔，吸血
              m_db3B0 := nPower / 1.E2 * m_nHongMoSuite;
              if m_db3B0 >= 2.0 then begin
                n20 := Trunc(m_db3B0);
                m_db3B0 := n20;
                DamageHealth(-n20);
              end;
            end;
            {$IF M2Version = 1}
            if (nPower > 0) then begin//虎威装备吸血
              if (m_nVampirePoint > 0) and ((m_btRaceServer = RC_PLAYOBJECT) or (m_btRaceServer = RC_HEROOBJECT)) then begin
                if Random(100) <= m_nVampireRate then begin
                  n20:= 0;
                  n20 := Random(m_nVampirePoint);
                  if n20 > 0 then DamageHealth(-n20);
                end;
              end;
            end;
            {$IFEND}
            nCode :=10;
            DirectAttack(AttackTarget, nPower, boBatterStorm);
            if AttackTarget <> nil then begin
              AttackTarget.m_wStatusTimeArr[POISON_DONTMOVE] := 1;//被打中,不可移动
              AttackTarget.m_dwStatusArrTick[POISON_DONTMOVE] := GetTickCount();
            end;
          end;
          Result := True;
        end;//15
        16: begin//横扫千军
          if m_Magic85Skill <> nil then nPower := GetAttackPower(MPow(m_Magic85Skill) + LoWord(m_WAbil.DC), SmallInt((HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))));//横扫千军
          if (m_Magic85Skill <> nil) and (m_Magic85Skill.btLevel > 0) and (m_Magic85Skill.btLevel < 6) then begin
            Randomize(); //随机种子
            if Random(100) <= (m_wHumanPulseArr[3].nStormsHit + StormsHitRate) then begin
              nPower:= nPower + Round(nPower * (g_Config.nStormsHitRate[m_Magic85Skill.btLevel] / 100));
              SendRefMsg(RM_10205, 14, 0, 0, 0, '');////暴击特效
              boBatterStorm := True;//是否暴击
            end;
          end;
          nPower:= nPower + m_wStatusArrValue[15];//连击伤害增加
          nCode :=13;
          if Attack_85(nPower, boBatterStorm) then begin
            if m_nHongMoSuite > 0 then begin//虹魔，吸血
              m_db3B0 := nPower / 1.E2 * m_nHongMoSuite;
              if m_db3B0 >= 2.0 then begin
                n20 := Trunc(m_db3B0);
                m_db3B0 := n20;
                DamageHealth(-n20);
              end;
            end;
            {$IF M2Version = 1}
            if (nPower > 0) then begin//虎威装备吸血
              if (m_nVampirePoint > 0) and ((m_btRaceServer = RC_PLAYOBJECT) or (m_btRaceServer = RC_HEROOBJECT)) then begin
                if Random(100) <= m_nVampireRate then begin
                  n20:= 0;
                  n20 := Random(m_nVampirePoint);
                  if n20 > 0 then DamageHealth(-n20);
                end;
              end;
            end;
            {$IFEND}
          end;
          Result := True;
        end;//16
        17: begin//断岳斩
          if m_Magic82Skill <> nil then nPower := GetAttackPower(MPow(m_Magic82Skill) + LoWord(m_WAbil.DC), SmallInt((HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))));//断岳斩
          if (m_Magic82Skill <> nil) and (m_Magic82Skill.btLevel > 0) and (m_Magic82Skill.btLevel < 6) then begin
            Randomize(); //随机种子
            if Random(100) <= (m_wHumanPulseArr[2].nStormsHit + StormsHitRate) then begin
              nPower:= nPower + Round(nPower * (g_Config.nStormsHitRate[m_Magic82Skill.btLevel] / 100));
              SendRefMsg(RM_10205, 14, 0, 0, 0, '');////暴击特效
              boBatterStorm := True;//是否暴击
            end;
          end;
          nPower:= nPower + m_wStatusArrValue[15];//连击伤害增加
          nCode :=16;
          if Attack_82(nPower, boBatterStorm) then begin
            if m_nHongMoSuite > 0 then begin//虹魔，吸血
              m_db3B0 := nPower / 1.E2 * m_nHongMoSuite;
              if m_db3B0 >= 2.0 then begin
                n20 := Trunc(m_db3B0);
                m_db3B0 := n20;
                DamageHealth(-n20);
              end;
            end;
            {$IF M2Version = 1}
            if (nPower > 0) then begin//虎威装备吸血
              if (m_nVampirePoint > 0) and ((m_btRaceServer = RC_PLAYOBJECT) or (m_btRaceServer = RC_HEROOBJECT)) then begin
                if Random(100) <= m_nVampireRate then begin
                  n20:= 0;
                  n20 := Random(m_nVampirePoint);
                  if n20 > 0 then DamageHealth(-n20);
                end;
              end;
            end;
            {$IFEND}
          end;
          Result := True;
        end;//17
      end;
    except
      on E: Exception do begin
        MainOutMessage(Format('{%s} TAIPlayObject._BatterAttack Code:%d',[g_sExceptionVer, nCode]));
      end;  
    end;
  end;
var
  AttackTarget: TBaseObject;
  nX, nY: integer;
  nCode: Byte;
begin
  nCode:= 0;
  if m_boDeath or m_boGhost then Exit;
  try
    if TargeTBaseObject = nil then begin
      nCode:= 1;
      AttackTarget := GetPoseCreate();
      nCode:= 2;
      if (AttackTarget = nil) and ((wHitMode = 15) or (wHitMode =16) or (wHitMode =17)) then begin//取两格位置的目标
        nCode:= 3;
        if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, 2, nX, nY) then begin
          nCode:= 4;
          AttackTarget := m_PEnvir.GetMovingObject(nX, nY, True);
        end;
      end;
    end else AttackTarget := TargeTBaseObject;
    nCode:= 5;
    if AttackTarget <> nil then GetAttackDir(AttackTarget, m_btDirection);//取攻击的方向 20091029
    nCode:= 6;
    if _BatterAttack(wHitMode, AttackTarget, StormsHit) then begin//处理目标掉血以级技能升级点数
      nCode:= 7;
      if AttackTarget <> nil then SetTargetCreat(AttackTarget);
    end;
    nCode:= 8;
    case wHitMode of                               
      15: SendAttackMsg(RM_BATTERHIT2, m_btDirection, 0, m_nCurrX, m_nCurrY);//三绝杀
      16: SendAttackMsg(RM_BATTERHIT3, m_btDirection, 0, m_nCurrX, m_nCurrY);//横扫千军
      17: SendAttackMsg(RM_BATTERHIT4, m_btDirection, 0, m_nCurrX, m_nCurrY);//断岳斩
    end;
  except
    on E: Exception do begin
      MainOutMessage(Format('{%s} TAIPlayObject.BatterAttackDir Code:%d',[g_sExceptionVer, nCode]));
    end;
  end;
end;
{$IFEND}
procedure TAIPlayObject.Start(PathType: TPathType);
begin
  if (not m_boGhost) and (not m_boDeath) and (not m_boAIStart) then begin
    m_ManagedEnvir := m_PEnvir;
    m_nProtectTargetX:= m_nCurrX;//守护坐标
    m_nProtectTargetY:= m_nCurrY;//守护坐标
    m_boProtectOK:= False;
    m_nGotoProtectXYCount:= 0;//是向守护坐标的累计数
    m_PointManager.PathType := PathType;
    m_PointManager.Initialize(m_PEnvir);
    m_boAIStart := True;
    m_nMoveFailCount := 0;
    if g_FunctionNPC <> nil then begin
      m_nScriptGotoCount := 0;
      g_FunctionNPC.GotoLable(Self, '@AIStart', False, False);
    end;
  end;
end;

procedure TAIPlayObject.Stop;
begin
  if m_boAIStart then begin
    m_boAIStart := False;
    m_nMoveFailCount := 0;
    m_Path := nil;
    m_nPostion := -1;
    if g_FunctionNPC <> nil then begin
      m_nScriptGotoCount := 0;
      g_FunctionNPC.GotoLable(Self, '@AIStop', False, False);
    end;
  end;
end;

procedure TAIPlayObject.MakeGhost;
begin
  if m_boAIStart then begin
    m_boAIStart := False;
  end;
  inherited;
end;

procedure TAIPlayObject.Whisper(whostr, saystr: string);
var
  PlayObject: TPlayObject;
begin
  PlayObject := UserEngine.GetPlayObject(whostr);
  if PlayObject <> nil then begin
    if not PlayObject.m_boReadyRun then Exit;
    if not PlayObject.m_boHearWhisper or PlayObject.IsBlockWhisper(m_sCharName) then Exit;
    if m_btPermission > 0 then begin
      PlayObject.SendMsg(PlayObject, RM_WHISPER, 0, g_Config.btGMWhisperMsgFColor, g_Config.btGMWhisperMsgBColor, 0, Format('%s[%d级]=> %s', [m_sCharName, m_Abil.Level ,saystr]));
      //取得私聊信息
      //m_GetWhisperHuman 侦听私聊对象
      if (m_GetWhisperHuman <> nil) and (not m_GetWhisperHuman.m_boGhost) then
        m_GetWhisperHuman.SendMsg(m_GetWhisperHuman, RM_WHISPER, 0, g_Config.btGMWhisperMsgFColor, g_Config.btGMWhisperMsgBColor, 0, Format('%s[%d级]=> %s %s', [m_sCharName, m_Abil.Level, PlayObject.m_sCharName, saystr]));
      if (PlayObject.m_GetWhisperHuman <> nil) and (not PlayObject.m_GetWhisperHuman.m_boGhost) then
        PlayObject.m_GetWhisperHuman.SendMsg(PlayObject.m_GetWhisperHuman, RM_WHISPER, 0, g_Config.btGMWhisperMsgFColor, g_Config.btGMWhisperMsgBColor, 0, Format('%s[%d级]=> %s %s', [m_sCharName, m_Abil.Level, PlayObject.m_sCharName, saystr]));
    end else begin
      PlayObject.SendMsg(PlayObject, RM_WHISPER, 0, {g_Config.btWhisperMsgFColor} m_btWhisperMsgFColor, g_Config.btWhisperMsgBColor, 0, Format('%s[%d级]=> %s', [m_sCharName, m_Abil.Level, saystr]));
      if (m_GetWhisperHuman <> nil) and (not m_GetWhisperHuman.m_boGhost) then
        m_GetWhisperHuman.SendMsg(m_GetWhisperHuman, RM_WHISPER, 0, {g_Config.btWhisperMsgFColor} m_btWhisperMsgFColor, g_Config.btWhisperMsgBColor, 0, Format('%s[%d级]=> %s %s', [m_sCharName, m_Abil.Level, PlayObject.m_sCharName, saystr]));

      if (PlayObject.m_GetWhisperHuman <> nil) and (not PlayObject.m_GetWhisperHuman.m_boGhost) then
        PlayObject.m_GetWhisperHuman.SendMsg(PlayObject.m_GetWhisperHuman, RM_WHISPER, 0, {g_Config.btWhisperMsgFColor} m_btWhisperMsgFColor, g_Config.btWhisperMsgBColor, 0, Format('%s[%d级]=> %s %s', [m_sCharName, m_Abil.Level, PlayObject.m_sCharName, saystr]));
    end;
  end;
end;

procedure TAIPlayObject.ProcessSayMsg(sData: string);
var
  boDisableSayMsg: Boolean;
  SC, sCryCryMsg, sParam1: string;
const
  s01 = '%d %d';
  s02 = '%s %d/%d';
resourcestring
  sExceptionMsg = '{%s} TAIPlayObject.ProcessSayMsg Msg:%s';
begin
  if sData = '' then Exit;
  try
    if Length(sData) > g_Config.nSayMsgMaxLen then begin
      sData := Copy(sData, 1, g_Config.nSayMsgMaxLen);
    end;

    if GetTickCount >= m_dwDisableSayMsgTick then m_boDisableSayMsg := False;
    boDisableSayMsg := m_boDisableSayMsg;
    g_DenySayMsgList.Lock;
    try
      if g_DenySayMsgList.GetIndex(m_sCharName) >= 0 then boDisableSayMsg := True;
    finally
      g_DenySayMsgList.UnLock;
    end;

    if not boDisableSayMsg then begin
      if sData[1] = '/' then begin
        SC := Copy(sData, 2, Length(sData) - 1);
        SC := GetValidStr3(SC, sParam1, [' ']);
        if not m_boFilterSendMsg then Whisper(sParam1, SC);
        Exit;
      end;

      if sData[1] = '!' then begin
        if Length(sData) >= 2 then begin
          if sData[2] = '!' then begin
            SC := Copy(sData, 3, Length(sData) - 2);
            SendGroupText(m_sCharName + ': ' + SC);
            Exit;
          end;
          if sData[2] = '~' then begin
            if m_MyGuild <> nil then begin
              SC := Copy(sData, 3, Length(sData) - 2);
              TGUild(m_MyGuild).SendGuildMsg(m_sCharName + ': ' + SC);
            end;
            Exit;
          end;
        end;

        if not m_PEnvir.m_boQUIZ then begin
          if (GetTickCount - m_dwShoutMsgTick) > 10 * 1000 then begin
            if m_Abil.Level <= g_Config.nCanShoutMsgLevel then begin
              SysMsg(Format(g_sYouNeedLevelMsg, [g_Config.nCanShoutMsgLevel + 1]), c_Red, t_Hint);
              Exit;
            end;
            m_dwShoutMsgTick := GetTickCount();
            SC := Copy(sData, 2, Length(sData) - 1);
            sCryCryMsg := '(!)' + m_sCharName + ': ' + SC;
            if m_boFilterSendMsg then begin
              SendMsg(nil, RM_CRY, 0, 0, $FFFF, 0, sCryCryMsg);
            end else begin
              UserEngine.CryCry(RM_CRY, m_PEnvir, m_nCurrX, m_nCurrY, 50, g_Config.btCryMsgFColor, g_Config.btCryMsgBColor, sCryCryMsg);
            end;
            Exit;
          end;
          SysMsg(Format(g_sYouCanSendCyCyLaterMsg, [10 - (GetTickCount - m_dwShoutMsgTick) div 1000]), c_Red, t_Hint);
          Exit;
        end;
        SysMsg(g_sThisMapDisableSendCyCyMsg {'本地图不允许喊话！！！'}, c_Red, t_Hint);
        Exit;
      end;

      if not m_boFilterSendMsg then begin //如果禁止发信息，则只向自己发信息
        SendRefMsg(RM_HEAR, 0, m_btHearMsgFColor, g_Config.btHearMsgBColor, 0, m_sCharName + ':' + sData);
      end;
    end;
  except
    on E: Exception do begin
      MainOutMessage(Format(sExceptionMsg, [g_sExceptionVer, sData]));
    end;
  end;
end;

function TAIPlayObject.FindMagic(wMagIdx: Word): pTUserMagic;
var
  UserMagic: pTUserMagic;
  I: Integer;
begin
  Result := nil;
  for I := 0 to m_MagicList.Count - 1 do begin
    UserMagic := m_MagicList.Items[I];
    if UserMagic.MagicInfo.wMagicId = wMagIdx then begin
      Result := UserMagic;
      Break;
    end;
  end;
end;

function TAIPlayObject.FindMagic(sMagicName: string): pTUserMagic;
var
  UserMagic: pTUserMagic;
  I: Integer;
begin
  Result := nil;
  for I := 0 to m_MagicList.Count - 1 do begin
    UserMagic := m_MagicList.Items[I];
    if CompareText(UserMagic.MagicInfo.sMagicName, sMagicName) = 0 then begin
      Result := UserMagic;
      Break;
    end;
  end;
end;

function TAIPlayObject.RunToNext(nX, nY: Integer): Boolean;
begin
  if GetTickCount()- dwTick5F4 > g_Config.nAIRunIntervalTime then begin
    Result := RunTo1(GetNextDirection(m_nCurrX, m_nCurrY, nX, nY), False, nX, nY);
    {if Result then }dwTick5F4 := GetTickCount();//20110625 注释
    m_dwStationTick := GetTickCount; //增加检测人物站立时间
  end;
end;

function TAIPlayObject.WalkToNext(nX, nY: Integer): Boolean;
begin
  if GetTickCount()- dwTick3F4 > g_Config.nAIWalkIntervalTime then begin
    Result := WalkTo(GetNextDirection(m_nCurrX, m_nCurrY, nX, nY), False);
    if Result then dwTick3F4 := GetTickCount();
    m_dwStationTick := GetTickCount; //增加检测人物站立时间
  end;
end;

function TAIPlayObject.GotoNextOne(nX, nY: Integer; boRun: Boolean): Boolean;
var
  I: Integer;
  //Path: TPath;
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
  end;   }
  m_RunPos.nAttackCount := 0;
end;

procedure TAIPlayObject.Hear(nIndex: Integer; sMsg: string);
var
  nPos: Integer;
  boDisableSayMsg: Boolean;
  sChrName, sSendMsg: string;
begin
  case nIndex of
    RM_HEAR:;
    RM_WHISPER: begin
        if GetTickCount >= m_dwDisableSayMsgTick then m_boDisableSayMsg := False;
        boDisableSayMsg := m_boDisableSayMsg;
        g_DenySayMsgList.Lock;
        try
          if g_DenySayMsgList.GetIndex(m_sCharName) >= 0 then boDisableSayMsg := True;
        finally
          g_DenySayMsgList.UnLock;
        end;
        if not boDisableSayMsg then begin
          nPos := Pos('=>', sMsg);
          if (nPos > 0) and (m_AISayMsgList.Count > 0) then begin
            sChrName := Copy(sMsg, 1, nPos - 1);
            sSendMsg := Copy(sMsg, nPos + 3, Length(sMsg) - nPos - 2);
            Whisper(sChrName, m_AISayMsgList.Strings[Random(m_AISayMsgList.Count)]);
          end;
        end;
      end;
    RM_CRY: ;
    RM_SYSMESSAGE: ;
    RM_MOVEMESSAGE: ;
    RM_GROUPMESSAGE: ;
    RM_GUILDMESSAGE: ;
    RM_DIVISIONMESSAGE:;
    RM_MERCHANTSAY: ;
    RM_PLAYDRINKSAY: ;
    RM_MOVEMESSAGE1: ;
  end;
end;
//取随机配置
function TAIPlayObject.GetRandomConfigFileName(sName: String;nType: Byte): string;
var
  nIndex: Integer;
  sFileName, Str: string;
  LoadList: TStringList;
begin
  Result := '';
  if not DirectoryExists(m_sFilePath+'RobotIni') then CreateDir(m_sFilePath+'RobotIni');
  sFileName:= m_sFilePath+'RobotIni\'+sName+'.txt';
  if FileExists(sFileName) then begin
    Result := sFileName;
    Exit;
  end;
  case nType of
    0: begin
      if (m_sConfigListFileName <> '') and FileExists(m_sConfigListFileName) then begin
        LoadList := TStringList.Create;
        try
          try
            LoadList.LoadFromFile(m_sConfigListFileName);
          except
          end;
          nIndex := Random(LoadList.Count);
          if (nIndex >= 0) and (nIndex < LoadList.Count) then begin
            Str:= LoadList.Strings[nIndex];
            if Str <> '' then begin
              if Str[1] = '\' then Str := Copy(Str, 2, Length(Str) - 1);
              if Str[2] = '\' then Str := Copy(Str, 3, Length(Str) - 2);
              if Str[3] = '\' then Str := Copy(Str, 4, Length(Str) - 3);
            end;
            Result := m_sFilePath + Str;
          end;
        finally
          LoadList.Free;
        end;
      end;
    end;
    1: begin
      if (m_sHeroConfigListFileName <> '') and FileExists(m_sHeroConfigListFileName) then begin
        LoadList := TStringList.Create;
        try
          try
            LoadList.LoadFromFile(m_sHeroConfigListFileName);
          except
          end;
          nIndex := Random(LoadList.Count);
          if (nIndex >= 0) and (nIndex < LoadList.Count) then begin
            Str:= LoadList.Strings[nIndex];
            if Str <> '' then begin
              if Str[1] = '\' then Str := Copy(Str, 2, Length(Str) - 1);
              if Str[2] = '\' then Str := Copy(Str, 3, Length(Str) - 2);
              if Str[3] = '\' then Str := Copy(Str, 4, Length(Str) - 3);
            end;
            Result := m_sFilePath + Str;
          end;
        finally
          LoadList.Free;
        end;
      end;
    end;
  end;
end;

procedure TAIPlayObject.Initialize;
var
  I, nAttatckMode: Integer;
  sFileName, sLineText, sMagicName, sItemName, sSayMsg: string;
  ItemIni: TIniFile;
  TempList: TStringList;
  UserItem: pTUserItem;
  Magic: pTMagic;
  UserMagic: pTUserMagic;
  StdItem: pTStdItem;
begin
  m_sHeroCharName := GetAIHeroName(m_sCharName);
  m_boHasHero := m_sHeroCharName <> '';

  sFileName := GetRandomConfigFileName(m_sCharName, 0);
  if (sFileName = '') or (not FileExists(sFileName)) then begin
    if (m_sConfigFileName <> '') and FileExists(m_sConfigFileName) then begin
      sFileName := m_sConfigFileName;
    end;
  end;

  if (sFileName <> '') and FileExists(sFileName) then begin
    ItemIni := TIniFile.Create(sFileName);
    if ItemIni <> nil then begin
      m_boNoDropItem := ItemIni.ReadBool('Info', 'NoDropItem', True);//是否掉包裹物品
      m_boNoDropUseItem := ItemIni.ReadBool('Info', 'DropUseItem', True);//是否掉装备
      m_nDropUseItemRate := ItemIni.ReadInteger('Info', 'DropUseItemRate', 100);//掉装备机率
      m_btJob := ItemIni.ReadInteger('Info', 'Job', 0);
      m_btGender := ItemIni.ReadInteger('Info', 'Gender', 0);
      m_btHair := ItemIni.ReadInteger('Info', 'Hair', 0);
      m_Abil.Level := ItemIni.ReadInteger('Info', 'Level', 1);
      m_Abil.nMaxExp := GetLevelExp(m_Abil.Level);
      m_boTrainingNG:= ItemIni.ReadBool('Info', 'NG', False);//是否学习过内功
      if m_boTrainingNG then begin
        m_NGLevel:= ItemIni.ReadInteger('Info', 'NGLevel', 1);//内功等级
        GetSkill69Exp(m_NGLevel, m_Skill69MaxNH);//计算内力值上限
        m_Skill69NH:= m_Skill69MaxNH;
      end;
      m_boProtectStatus:= ItemIni.ReadBool('Info','ProtectStatus',False);//是否守护模式
      nAttatckMode:= ItemIni.ReadInteger('Info','AttatckMode', 6);//攻击模式
      if nAttatckMode in [0..6] then m_btAttatckMode:= nAttatckMode;

      sLineText := ItemIni.ReadString('Info', 'UseSkill', '');
      if sLineText <> '' then begin
        TempList := TStringList.Create;
        try
          ExtractStrings(['|', '\', '/', ','], [], PChar(sLineText), TempList);
          for I := 0 to TempList.Count - 1 do begin
            sMagicName := Trim(TempList.Strings[I]);
            if FindMagic(sMagicName) = nil then begin
              Magic := UserEngine.FindMagic(sMagicName);
              if Magic <> nil then begin
                if (Magic.btJob = 99) or (Magic.btJob = m_btJob) then begin
                  if Magic.wMagicId = SKILL_75 then begin//护体神盾
                    m_boProtectionDefence:= True;
                    Continue;//继续
                  end;
                  New(UserMagic);
                  UserMagic.MagicInfo := Magic;
                  UserMagic.wMagIdx := Magic.wMagicId;
                  UserMagic.btLevel := 3;
                  UserMagic.btKey := 0;
                  UserMagic.nTranPoint := Magic.MaxTrain[3];
                  m_MagicList.Add(UserMagic);
                  {$IF M2Version = 1}
                  if m_boTrainingNG then begin
                    if (UserMagic.MagicInfo.wMagicId > SKILL_75) and (UserMagic.MagicInfo.wMagicId < SKILL_88) then begin//连击技能才处理
                      m_BatterMagicList.Add(UserMagic);
                    end;
                  end;
                  {$IFEND}
                end;
              end;
            end;
          end;
        finally
          TempList.Free;
        end;
        {$IF M2Version = 1}
        if m_BatterMagicList.Count > 0 then begin
          m_boTrainBatterSkill:= True;
          m_SetBatterKey:= 1;
          m_SetBatterKey1:= 1;
          m_SetBatterKey2:= 1;
        end;
        {$IFEND}
      end;
      sLineText := ItemIni.ReadString('Info', 'InitItems', '');
      if sLineText <> '' then begin
        TempList := TStringList.Create;
        try
          ExtractStrings(['|', '\', '/', ','], [], PChar(sLineText), TempList);
          for I := 0 to TempList.Count - 1 do begin
            sItemName := Trim(TempList.Strings[I]);
            StdItem := UserEngine.GetStdItem(sItemName);
            if StdItem <> nil then begin
              New(UserItem);
              if UserEngine.CopyToUserItemFromName(sItemName, UserItem) then begin
                if StdItem.StdMode in [15, 19, 20, 21, 22, 23, 24, 26] then begin
                  if (StdItem.Shape = 130) or (StdItem.Shape = 131) or (StdItem.Shape = 132) then begin
                    UserEngine.GetUnknowItemValue(UserItem);
                  end;
                end;
                if not AddItemToBag(UserItem) then begin
                  Dispose(UserItem);
                  break;
                end;
                m_BagItemNames.Add(StdItem.Name);
              end else Dispose(UserItem);
            end;
          end;
        finally
          TempList.Free;
        end;
      end;
      for I := 0 to 9 do begin
        sSayMsg:= ItemIni.ReadString('MonSay', IntToStr(I), '');
        if sSayMsg <> '' then m_AISayMsgList.Add(sSayMsg)
        else Break;
      end;
      m_UseItemNames[U_DRESS] := ItemIni.ReadString('UseItems', 'UseItems0'{'DRESSNAME'}, ''); // '衣服';
      m_UseItemNames[U_WEAPON] := ItemIni.ReadString('UseItems', 'UseItems1'{'WEAPONNAME'}, ''); // '武器';
      m_UseItemNames[U_RIGHTHAND] := ItemIni.ReadString('UseItems', 'UseItems2'{'RIGHTHANDNAME'}, ''); // '照明物';
      m_UseItemNames[U_NECKLACE] := ItemIni.ReadString('UseItems', 'UseItems3'{'NECKLACENAME'}, ''); // '项链';
      m_UseItemNames[U_HELMET] := ItemIni.ReadString('UseItems', 'UseItems4'{'HELMETNAME'}, ''); // '头盔';
      m_UseItemNames[U_ARMRINGL] := ItemIni.ReadString('UseItems', 'UseItems5'{'ARMRINGLNAME'}, ''); // '左手镯';
      m_UseItemNames[U_ARMRINGR] := ItemIni.ReadString('UseItems', 'UseItems6'{'ARMRINGRNAME'}, ''); // '右手镯';
      m_UseItemNames[U_RINGL] := ItemIni.ReadString('UseItems', 'UseItems7'{'RINGLNAME'}, ''); // '左戒指';
      m_UseItemNames[U_RINGR] := ItemIni.ReadString('UseItems', 'UseItems8'{'RINGRNAME'}, ''); // '右戒指';
      {$IF M2Version <> 2}
      m_UseItemNames[U_BUJUK] := ItemIni.ReadString('UseItems', 'UseItems9'{'BUJUKNAME'}, ''); // '物品';
      m_UseItemNames[U_BELT] := ItemIni.ReadString('UseItems', 'UseItems10'{'BELTNAME'}, ''); // '腰带';
      m_UseItemNames[U_BOOTS] := ItemIni.ReadString('UseItems', 'UseItems11'{'BOOTSNAME'}, ''); // '鞋子';
      m_UseItemNames[U_CHARM] := ItemIni.ReadString('UseItems', 'UseItems12'{'CHARMNAME'}, ''); // '宝石';
      m_UseItemNames[U_ZHULI] := ItemIni.ReadString('UseItems','UseItems13'{'CHARMNAME'}, ''); // '斗笠';
      m_UseItemNames[U_DRUM] := ItemIni.ReadString('UseItems','UseItems14'{'CHARMNAME'}, ''); // '斗笠';
      {$IFEND}
      for I := {$IF M2Version <> 2}U_DRESS to U_ZHULI{$ELSE}U_DRESS to U_RINGR{$IFEND} do begin
        if m_UseItemNames[I] <> '' then begin
          StdItem := UserEngine.GetStdItem(m_UseItemNames[I]);
          if StdItem <> nil then begin
            New(UserItem);
            if UserEngine.CopyToUserItemFromName(m_UseItemNames[I], UserItem) then begin
              if StdItem.StdMode in [15, 19, 20, 21, 22, 23, 24, 26] then begin
                if (StdItem.Shape = 130) or (StdItem.Shape = 131) or (StdItem.Shape = 132) then begin
                  UserEngine.GetUnknowItemValue(UserItem);
                end;
              end;
            end;
            m_UseItems[I] := UserItem^;
            Dispose(UserItem);
          end;
        end;
      end;
      ItemIni.Free;
    end;
  end;
  inherited;
end;

function TAIPlayObject.SearchPickUpItem(nPickUpTime: Integer): Boolean;
  procedure SetHideItem(MapItem: PTMapItem);
  var
    VisibleMapItem: pTVisibleMapItem;
    I: Integer;
  begin
    for I := 0 to m_VisibleItems.Count - 1 do begin
      VisibleMapItem := pTVisibleMapItem(m_VisibleItems.Items[I]);
      if (VisibleMapItem <> nil) and (VisibleMapItem.nVisibleFlag > 0) then begin
        if VisibleMapItem.MapItem = MapItem then begin
          VisibleMapItem.nVisibleFlag := 0;
          Break;
        end;
      end;
    end;
  end;
  function PickUpItem(nX, nY: Integer): Boolean;
  var
    UserItem: pTUserItem;
    StdItem: pTStdItem;
    MapItem: PTMapItem;
  begin
    Result := False;
    MapItem := m_PEnvir.GetItem(nX, nY);
    if MapItem = nil then Exit;
    if CompareText(MapItem.Name, sSTRING_GOLDNAME) = 0 then begin
      if m_PEnvir.DeleteFromMap(nX, nY, OS_ITEMOBJECT, TObject(MapItem)) = 1 then begin
        if TPlayObject(self).IncGold(MapItem.Count) then begin
          SendRefMsg(RM_ITEMHIDE, 0, Integer(MapItem), nX, nY, '');
          Result := True;
          GoldChanged;
          SetHideItem(MapItem);
          Dispose(MapItem);
        end else begin
          m_PEnvir.AddToMap(nX, nY, OS_ITEMOBJECT, TObject(MapItem));
        end;
      end else begin
        m_PEnvir.AddToMap(nX, nY, OS_ITEMOBJECT, TObject(MapItem));
      end;
    end else begin //捡物品
      if MapItem.UserItem.AddValue[0] in [2,3] then Exit;//绑定物品不能捡 20110528
      StdItem := UserEngine.GetStdItem(MapItem.UserItem.wIndex);
      if StdItem <> nil then begin
        if m_PEnvir.DeleteFromMap(nX, nY, OS_ITEMOBJECT, TObject(MapItem)) = 1 then begin
          New(UserItem);
          FillChar(UserItem^, SizeOf(TUserItem), #0);
          UserItem^ := MapItem.UserItem;
          StdItem := UserEngine.GetStdItem(UserItem.wIndex);
          if (StdItem <> nil) and IsAddWeightAvailable(UserEngine.GetStdItemWeight(UserItem.wIndex)) then begin
            if GetCheckItemList(18, StdItem.Name) then begin//判断是否为绑定48时物品
              UserItem.AddValue[0]:= 2;
              UserItem.MaxDate:= IncDayHour(Now(), 48);//解绑时间
            end;
            if AddItemToBag(UserItem) then begin
              SendRefMsg(RM_ITEMHIDE, 0, Integer(MapItem), nX, nY, '');
              SendAddItem(UserItem);
              m_WAbil.Weight := RecalcBagWeight();
              Result := True;
              SetHideItem(MapItem);
              Dispose(MapItem);
            end else begin
              Dispose(UserItem);
              m_PEnvir.AddToMap(nX, nY, OS_ITEMOBJECT, TObject(MapItem));
            end;
          end else begin
            Dispose(UserItem);
            m_PEnvir.AddToMap(nX, nY, OS_ITEMOBJECT, TObject(MapItem));
          end;
        end else begin
          Dispose(UserItem);
          m_PEnvir.AddToMap(nX, nY, OS_ITEMOBJECT, TObject(MapItem));
        end;
      end;
    end;
  end;
var
  MapItem: PTMapItem;
  VisibleMapItem: pTVisibleMapItem;
  SelVisibleMapItem: pTVisibleMapItem;
  I: Integer;
  boFound: Boolean;
  n01, n02: Integer;
  nCode: Byte;
begin
  Result := False;
  nCode:= 0;
  try
    if GetTickCount() - m_dwPickUpItemTick < nPickUpTime then Exit;
    m_dwPickUpItemTick := GetTickCount();
    if IsEnoughBag and (m_TargetCret = nil) then begin
      boFound := False;
      nCode:= 1;
      if m_SelMapItem <> nil then begin
        m_boCanPickIng:= True;
        nCode:= 2;
        for I := 0 to m_VisibleItems.Count - 1 do begin
          nCode:= 3;
          VisibleMapItem := pTVisibleMapItem(m_VisibleItems.Items[I]);
          nCode:= 4;
          if (VisibleMapItem <> nil) and (VisibleMapItem.nVisibleFlag > 0) then begin
            if VisibleMapItem.MapItem = m_SelMapItem then begin
              nCode:= 5;
              boFound := True;
              Break;
            end;
          end;
        end;
      end;
      if not boFound then m_SelMapItem := nil;
      nCode:= 6;
      if m_SelMapItem <> nil then begin
        if PickUpItem(m_nCurrX, m_nCurrY) then begin
          m_boCanPickIng:= False;
          Result := True;
          Exit;
        end;
      end;
      n01 := 999;
      nCode:= 7;
      SelVisibleMapItem := nil;
      boFound := False;
      if m_SelMapItem <> nil then begin
       nCode:= 8;
        for I := 0 to m_VisibleItems.Count - 1 do begin
         nCode:= 9;
          VisibleMapItem := pTVisibleMapItem(m_VisibleItems.Items[I]);
          nCode:= 10;
          if (VisibleMapItem <> nil) and (VisibleMapItem.nVisibleFlag > 0) then begin
            nCode:= 11;
            if VisibleMapItem.MapItem = m_SelMapItem then begin
              SelVisibleMapItem := VisibleMapItem;
              boFound := True;
              Break;
            end;
          end;
        end;
      end;
      if not boFound then begin
        nCode:= 12;
        for I := 0 to m_VisibleItems.Count - 1 do begin
          nCode:= 13;
          VisibleMapItem := pTVisibleMapItem(m_VisibleItems.Items[I]);
          nCode:= 14;
          try
            if (VisibleMapItem <> nil) then begin
              if (VisibleMapItem.nVisibleFlag > 0) then begin
                MapItem := VisibleMapItem.MapItem;
                if MapItem <> nil then begin
                  //nCode:= 15;
                  if IsAllowAIPickUpItem(VisibleMapItem.sName) and
                    IsAddWeightAvailable(UserEngine.GetStdItemWeight(MapItem.UserItem.wIndex)) and
                    (MapItem.UserItem.AddValue[0]<>2) and (MapItem.UserItem.AddValue[0]<>3) then begin
                    //nCode:= 16;
                    if (MapItem.OfBaseObject = nil) or (MapItem.OfBaseObject = m_MyHero)
                      or (MapItem.OfBaseObject = Self) or (TBaseObject(MapItem.OfBaseObject).m_Master = Self) then begin
                      //nCode:= 17;
                      if (abs(VisibleMapItem.nX - m_nCurrX) <= 5) and (abs(VisibleMapItem.nY - m_nCurrY) <= 5) then begin
                        n02 := abs(VisibleMapItem.nX - m_nCurrX) + abs(VisibleMapItem.nY - m_nCurrY);
                        //nCode:= 18;
                        if n02 < n01 then begin
                          n01 := n02;
                          SelVisibleMapItem := VisibleMapItem;
                        end;
                      end;
                    end;
                  end;
                end;
              end;
            end;
          except
          end;
        end;//for
      end;
      nCode:= 20;
      if SelVisibleMapItem <> nil then begin
        nCode:= 21;
        m_SelMapItem := SelVisibleMapItem.MapItem;
        if m_SelMapItem <> nil then m_boCanPickIng:= True else m_boCanPickIng:= False;
        if (m_nCurrX <> SelVisibleMapItem.nX) or (m_nCurrY <> SelVisibleMapItem.nY) then begin
          nCode:= 22;
          WalkToTargetXY2(SelVisibleMapItem.nX, VisibleMapItem.nY);
          Result := True;
        end;
      end else m_boCanPickIng:= False;
    end else begin
      m_SelMapItem:= nil;
      m_boCanPickIng:= False;
    end;
  except
    MainOutMessage(Format('{%s} TAIPlayObject.SearchPickUpItem Code:%d',[g_sExceptionVer, nCode]));
  end;
end;

function TAIPlayObject.WalkToTargetXY2(nTargetX, nTargetY: Integer): Boolean;
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
  if m_boTransparent and (m_boHideMode) then m_wStatusTimeArr[STATE_TRANSPARENT ] := 1;//隐身,一动就显身
  if ((m_wStatusTimeArr[POISON_STONE] <> 0) and (not g_ClientConf.boParalyCanSpell))
    or (m_wStatusTimeArr[POISON_DONTMOVE] <> 0) or (m_wStatusTimeArr[POISON_LOCKSPELL{7}] <> 0)
    or (m_wStatusArrValue[23] <> 0) then Exit;//麻痹不能跑动 20080915
  if (nTargetX <> m_nCurrX) or (nTargetY <> m_nCurrY) then begin
    if GetTickCount()- dwTick3F4 > m_dwTurnIntervalTime then begin //转向间隔
      n10 := nTargetX;
      n14 := nTargetY;
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
      if (nTargetX = m_nCurrX) and (nTargetY = m_nCurrY) then begin
        Result := True;
        dwTick3F4 := GetTickCount();
      end;
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
              dwTick3F4 := GetTickCount();
              Break;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TAIPlayObject.GotoProtect();
var
  I, nDir, n10, n14, n20, nOldX, nOldY: Integer;
begin
  if ((m_nCurrX <> m_nProtectTargetX) or (m_nCurrY <> m_nProtectTargetY)) then begin
    n10 := m_nProtectTargetX;
    n14 := m_nProtectTargetY;
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
    if (abs(m_nCurrX - m_nProtectTargetX) >= 3) or (abs(m_nCurrY - m_nProtectTargetY) >= 3) then begin
      m_dwStationTick := GetTickCount; //增加检测人物站立时间
      if not RunTo1(nDir, False, m_nProtectTargetX, m_nProtectTargetY) then begin
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
      m_dwStationTick := GetTickCount; //增加检测人物站立时间
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

procedure TAIPlayObject.Wondering();
var
  nX, nY: Integer;
begin
  if m_boAIStart and (m_TargetCret = nil) and (not m_boCanPickIng) and
    (not m_boGhost) and (not m_boDeath) and (not m_boFixedHideMode) and
    (not m_boStoneMode) and (m_wStatusTimeArr[POISON_STONE] = 0) then begin
    nX := m_nCurrX;
    nY := m_nCurrY;
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
     { else Stop};//20110319 注释，不用自动停止
    end;        
  end;
  if m_nMoveFailCount >= 3 then begin
    if (Random(2) = 1) then TurnTo(Random(8))
    else WalkTo(m_btDirection, False);
    m_Path := nil;
    m_nPostion := -1;
    m_nMoveFailCount := 0;
    //Stop;//20110319 注释，不用自动停止
  end;
end;

procedure TAIPlayObject.Struck(hiter: TBaseObject);
  function MINXY(AObject, BObject: TBaseObject): TBaseObject;
  var
    nA, nB: Integer;
  begin
    nA := abs(m_nCurrX - AObject.m_nCurrX) + abs(m_nCurrY - AObject.m_nCurrY);
    nB := abs(m_nCurrX - BObject.m_nCurrX) + abs(m_nCurrY - BObject.m_nCurrY);
    if nA > nB then Result := BObject else Result := AObject;
  end;
var
  boDisableSayMsg: Boolean;
begin
  m_dwStruckTick := GetTickCount;
  if hiter <> nil then begin
    if (m_TargetCret = nil) and IsProperTarget(hiter) then begin
      SetTargetCreat(hiter);
    end else begin
      if (hiter.m_btRaceServer = RC_PLAYOBJECT) or ((hiter.m_Master <> nil) and (hiter.Master.m_btRaceServer = RC_PLAYOBJECT)) then begin
        if (m_TargetCret <> nil) and ((m_TargetCret.m_btRaceServer = RC_PLAYOBJECT) or ((m_TargetCret.m_Master <> nil) and (m_TargetCret.Master.m_btRaceServer = RC_PLAYOBJECT))) then begin
          if (MINXY(m_TargetCret, hiter) = hiter) or (Random(6) = 0) then begin
            SetTargetCreat(hiter);
          end;
        end else begin
          SetTargetCreat(hiter);
        end;
      end else begin
        if ((m_TargetCret <> nil) and (MINXY(m_TargetCret, hiter) = hiter)) or (Random(6) = 0) then begin
          if (m_btJob > 0) or ((m_TargetCret <> nil) and (GetTickCount() - m_dwTargetFocusTick > 1000 * 3)) then
            if IsProperTarget(hiter) then SetTargetCreat(hiter);
        end;
      end;
    end;

    if (hiter.m_btRaceServer = RC_PLAYOBJECT) and (not hiter.m_boAI) and (m_TargetCret = hiter) then begin
      if (Random(8) = 0) and (m_AISayMsgList.Count > 0) then begin
        if GetTickCount >= m_dwDisableSayMsgTick then m_boDisableSayMsg := False;
        boDisableSayMsg := m_boDisableSayMsg;
        g_DenySayMsgList.Lock;
        try
          if g_DenySayMsgList.GetIndex(m_sCharName) >= 0 then boDisableSayMsg := True;
        finally
          g_DenySayMsgList.UnLock;
        end;
        if not boDisableSayMsg then begin
          SendRefMsg(RM_HEAR, 0, m_btHearMsgFColor, g_Config.btHearMsgBColor, 0, m_sCharName + ':' + m_AISayMsgList.Strings[Random(m_AISayMsgList.Count)]);
        end;
      end;
    end;
  end;

  if m_boAnimal then begin
    m_nMeatQuality := m_nMeatQuality - Random(300);
    if m_nMeatQuality < 0 then m_nMeatQuality := 0;
  end;
  m_dwHitTick := m_dwHitTick + LongWord(150 - _MIN(130, m_Abil.Level * 4));
end;

procedure TAIPlayObject.SearchTarget();
begin
  if ((m_TargetCret = nil) or (GetTickCount - m_dwSearchTargetTick > 1000)) and (m_boAIStart) then begin
    m_dwSearchTargetTick := GetTickCount();
    if (m_TargetCret = nil) or
      (not ((m_TargetCret <> nil) and (m_TargetCret.m_btRaceServer = RC_PLAYOBJECT)) or ((m_TargetCret.m_Master <> nil) and (m_TargetCret.Master.m_btRaceServer = RC_PLAYOBJECT)) or (GetTickCount - m_dwStruckTick > 15000)) then begin
      inherited;
    end;
  end;
end;

procedure TAIPlayObject.Die;
begin
  if m_boAIStart then begin
    m_boAIStart := False;
  end;
  inherited;
end;

function TAIPlayObject.CanWalk(nCurrX, nCurrY, nTargetX, nTargetY: Integer; nDir: Integer; var nStep: Integer; boFlag: Boolean): Boolean;
var
  btDir: Byte;
  nX, nY, nCount: Integer;
begin
  Result := False;
  nStep := 0;
  nCount := 0;
  if (nDir >= 0) and (nDir <= 7) then btDir := nDir
  else btDir := GetNextDirection(nCurrX, nCurrY, nTargetX, nTargetY);
  if boFlag then begin
    if (abs(nCurrX - nTargetX) <= 1) and (abs(nCurrY - nTargetY) <= 1) then begin
      if m_PEnvir.GetNextPosition(nCurrX, nCurrY, btDir, 1, nX, nY) and (nX = nTargetX) and (nY = nTargetY) then begin
        nStep := 1;
        Result := True;
      end;
    end else begin
      if m_PEnvir.GetNextPosition(nCurrX, nCurrY, btDir, 2, nX, nY) and (nX = nTargetX) and (nY = nTargetY) then begin
        nStep := 1;
        Result := True;
      end;
    end;
  end else begin
    if m_PEnvir.GetNextPosition(nCurrX, nCurrY, btDir, 1, nX, nY) and (nX = nTargetX) and (nY = nTargetY) then begin
      nStep := nStep + 1;
      Result := True;
      Exit;
    end else Exit;
    if m_PEnvir.GetNextPosition(nX, nY, btDir, 1, nX, nY) and (nX = nTargetX) and (nY = nTargetY) then begin
      nStep := nStep + 1;
      Result := True;
      Exit;
    end;
  end;
end;

function TAIPlayObject.IsGotoXY(X1, Y1, X2, Y2: Integer): Boolean;
var
  nStep: Integer;
  Path: TPath;
begin
  Result := False;
  if (not CanWalk(X1, Y1, X2, Y2, -1, nStep, m_btRaceServer <> 108)) then begin
    Path := g_FindPath.FindPath(m_PEnvir, X1, Y1, X2, Y2, False);
    if Length(Path) <= 0 then Exit;
    Path := nil;
    Result := True;
  end else Result := True;
end;

function TAIPlayObject.GotoNext(nX, nY: Integer; boRun: Boolean): Boolean;
var
  I, nStep: Integer;
  Path: TPath;
begin
  Result := False;
  nStep := 0;
  if (abs(nX - m_nCurrX) <= 2) and (abs(nY - m_nCurrY) <= 2) then begin
    if (abs(nX - m_nCurrX) <= 1) and (abs(nY - m_nCurrY) <= 1) then begin
      Result := WalkToNext(nX, nY);
    end else begin
      Result := RunToNext(nX, nY);
    end;
    nStep := 1;
  end;

  if not Result then begin
    Path := g_FindPath.FindPath(m_PEnvir, m_nCurrX, m_nCurrY, nX, nY, boRun);
    if Length(Path) > 0 then begin
      for I := 0 to Length(Path) - 1 do begin
        if (Path[I].X <> m_nCurrX) or (Path[I].Y <> m_nCurrY) then begin
          if (abs(Path[I].X - m_nCurrX) >= 2) or (abs(Path[I].Y - m_nCurrY) >= 2) then begin
            Result := RunToNext(Path[I].X, Path[I].Y);
          end else begin
            Result := WalkToNext(Path[I].X, Path[I].Y);
          end;
          if Result then Inc(nStep) else break;
          if nStep >= 3 then break;
        end;
      end;
      Path := nil;
    end;
  end;
  m_RunPos.nAttackCount := 0;
end;

function TAIPlayObject.Operate(ProcessMsg: pTProcessMessage): Boolean;
var
  nError: Integer;
  AttackBaseObject: TBaseObject;
const
  sExceptionMsg0 = '{%s} TAIPlayObject::Operate %s Ident:%d Sender:%d wP:%d nP1:%d nP2:%d np3:%d Msg:%s Code:%s';
begin
  try
    if ProcessMsg.wIdent = RM_STRUCK then begin
      nError := 0;
      if TBaseObject(ProcessMsg.BaseObject) = Self then begin
        nError := 1;
        AttackBaseObject := TBaseObject(ProcessMsg.nParam3);
        if AttackBaseObject <> nil then begin
          nError := 2;
          if AttackBaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
            nError := 3;
            SetPKFlag(AttackBaseObject);
            nError := 4;
          end;
          nError := 5;
          SetLastHiter(AttackBaseObject);
          nError := 6;

          Struck(AttackBaseObject);
          nError := 7;
          BreakHolySeizeMode();
          nError := 8;
        end;
        nError := 9;
        if (g_CastleManager.IsCastleMember(Self) <> nil) and (AttackBaseObject <> nil) then begin
          nError := 10;
          AttackBaseObject.bo2B0 := True;
          nError := 11;
          AttackBaseObject.m_dw2B4Tick := GetTickCount();
          nError := 12;
        end;
        nError := 13;
        m_nHealthTick := 0;
        m_nSpellTick := 0;
        Dec(m_nPerHealth);
        Dec(m_nPerSpell);
        m_dwStruckTick := GetTickCount();
        nError := 14;
      end; 
      Result := True;
    end else begin
      Result := inherited Operate(ProcessMsg);
    end;
  except
    MainOutMessage(Format(sExceptionMsg0, [g_sExceptionVer, m_sCharName,
      ProcessMsg.wIdent,Integer(ProcessMsg.BaseObject), ProcessMsg.wParam, ProcessMsg.nParam1,
      ProcessMsg.nParam2, ProcessMsg.nParam3, ProcessMsg.sMsg, nError]));
  end;
end;

function TAIPlayObject.GetRangeTargetCountByDir(nDir, nX, nY, nRange: Integer): Integer;
var
  I: Integer;
  BaseObject: TBaseObject;
  nCurrX, nCurrY: Integer;
begin
  Result := 0;
  nCurrX := nX;
  nCurrY := nY;
  for I := 1 to nRange do begin
    if m_PEnvir.GetNextPosition(nCurrX, nCurrY, nDir, 1, nCurrX, nCurrY) then begin
      BaseObject := TBaseObject(m_PEnvir.GetMovingObject(nCurrX, nCurrY, True));
      if (BaseObject <> nil) and (not BaseObject.m_boDeath) and (not BaseObject.m_boGhost) and (not BaseObject.m_boHideMode or m_boCoolEye) and IsProperTarget(BaseObject) then begin
        Inc(Result);
      end;
    end;
  end;
end;

function TAIPlayObject.GetNearTargetCount(): Integer;
var
  n10: Integer;
  nX, nY: Integer;
  BaseObject: TBaseObject;
begin
  Result := 0;
  for n10 := 0 to 7 do begin
    if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, n10, 1, nX, nY) then begin
      BaseObject := TBaseObject(m_PEnvir.GetMovingObject(nX, nY, True));
      if (BaseObject <> nil) and (not BaseObject.m_boDeath) and (not BaseObject.m_boGhost) and IsProperTarget(BaseObject) then begin
        Inc(Result);
      end;
    end;
  end;
end;
function TAIPlayObject.GetNearTargetCount(nCurrX, nCurrY: Integer): Integer;
var
  n10: Integer;
  nX, nY: Integer;
  BaseObject: TBaseObject;
begin
  Result := 0;
  BaseObject := TBaseObject(m_PEnvir.GetMovingObject(nCurrX, nCurrY, True));
  if (BaseObject <> nil) and (not BaseObject.m_boDeath) and (not BaseObject.m_boGhost) and IsProperTarget(BaseObject) then
    Inc(Result);

  for n10 := 0 to 7 do begin
    if m_PEnvir.GetNextPosition(nCurrX, nCurrY, n10, 1, nX, nY) then begin
      BaseObject := TBaseObject(m_PEnvir.GetMovingObject(nX, nY, True));
      if (BaseObject <> nil) and (not BaseObject.m_boDeath) and (not BaseObject.m_boGhost) and IsProperTarget(BaseObject) then
        Inc(Result);
    end;
  end;
end;

function TAIPlayObject.GetMasterRange(nTargetX, nTargetY: Integer): Integer;
var
  nCurrX, nCurrY: Integer;
begin
  Result := 0;
  if (m_Master <> nil) then begin
    if (m_btRaceServer = RC_HEROOBJECT) and (THeroObject(Self).m_boProtectStatus) then begin
      nCurrX := THeroObject(Self).m_nProtectTargetX;
      nCurrY := THeroObject(Self).m_nProtectTargetY;
    end else begin
      nCurrX := m_Master.m_nCurrX;
      nCurrY := m_Master.m_nCurrY;
    end;
    Result := abs(nCurrX - nTargetX) + abs(nCurrY - nTargetY);
  end;
end;

function TAIPlayObject.FollowMaster: Boolean;
var
  I, II, III, nX, nY, nCurrX, nCurrY, nStep: Integer;
  boNeed: Boolean;
begin
  Result := False;
  boNeed := False;
  if (not m_Master.m_boSlaveRelax) then begin
    if (m_PEnvir <> m_Master.m_PEnvir) or (abs(m_nCurrX - m_Master.m_nCurrX) > 20) or (abs(m_nCurrY - m_Master.m_nCurrY) > 20) then begin
      boNeed := True;
    end;
  end;

  if boNeed then begin
    {if m_boProtectStatus then begin
      nX := m_nProtectTargetX;
      nY := m_nProtectTargetY;
    end else begin }
      m_Master.GetBackPosition(nX, nY);
      if not m_Master.m_PEnvir.CanWalk(nX, nY, True) then begin
        for I := 0 to 7 do begin
          if m_Master.m_PEnvir.GetNextPosition(m_Master.m_nCurrX, m_Master.m_nCurrY, I, 1, nX, nY) then begin
            if m_Master.m_PEnvir.CanWalk(nX, nY, True) then begin
              break;
            end;
          end;
        end;
      end;
    //end;

    DelTargetCreat;
    m_nTargetX := nX;
    m_nTargetY := nY;

    //if not m_boProtectStatus then begin
      SpaceMove(m_Master.m_PEnvir.sMapName, m_nTargetX, m_nTargetY, 1);
    {end else begin
      SpaceMove(m_PEnvir.sMapName, m_nTargetX, m_nTargetY, 1);
    end;}
    Result := True;
    Exit;
  end;

  {if m_boProtectStatus then begin
    nCurrX := m_nProtectTargetX;
    nCurrY := m_nProtectTargetY;
  end else begin}
    m_Master.GetBackPosition(nCurrX, nCurrY);
  //end;

  if (m_TargetCret = nil) and (not m_Master.m_boSlaveRelax) then begin
    //if not m_boProtectStatus then begin
      for I := 1 to 2 do begin //判断主人是否在英雄对面
        if m_Master.m_PEnvir.GetNextPosition(m_Master.m_nCurrX, m_Master.m_nCurrY, m_Master.m_btDirection, I, nX, nY) then begin
          if (m_nCurrX = nX) and (m_nCurrY = nY) then begin
            if m_Master.GetBackPosition(nX, nY) and
              GotoNext(nX, nY, True) then begin
              Result := True;
              Exit;
            end;

            for III := 1 to 2 do begin
              for II := 0 to 7 do begin
                if II <> m_Master.m_btDirection then begin
                  if m_Master.m_PEnvir.GetNextPosition(m_Master.m_nCurrX, m_Master.m_nCurrY, II, III, nX, nY) and
                  GotoNext(nX, nY, True) then begin
                    Result := True;
                    Exit;
                  end;
                end;
              end;
            end;
            Break;
          end;
        end;
      end;

      if m_btRaceServer = 108 then nStep := 0 else nStep := 1;//是否为月灵
      if (abs(m_nCurrX - nCurrX) > nStep) or (abs(m_nCurrY - nCurrY) > nStep) then begin
        if GotoNextOne(nCurrX, nCurrY, True) then Exit;
        if GotoNextOne(nX, nY, True) then Exit;
        for III := 1 to 2 do begin
          for II := 0 to 7 do begin
            if II <> m_Master.m_btDirection then begin
              if m_Master.m_PEnvir.GetNextPosition(m_Master.m_nCurrX, m_Master.m_nCurrY, II, III, nX, nY) and
              GotoNextOne(nX, nY, True) then begin
                Result := True;
                Exit;
              end;
            end;
          end;
        end;
      end;
   {end else begin
      if GotoNextOne(nCurrX, nCurrY, True) then Exit;
      for III := 1 to 2 do begin
        for II := 0 to 7 do begin
          if m_Master.m_PEnvir.GetNextPosition(nCurrX, nCurrY, II, III, nX, nY) and
          GotoNextOne(nX, nY, True) then begin
            Result := True;
            Exit;
          end;
        end;
      end;
    end; }
  end;
end;

function TAIPlayObject.FindVisibleActors(ActorObject: TBaseObject): Boolean;
var
  I: Integer;
begin
  for I := 0 to m_VisibleActors.Count - 1 do begin
    if (pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject = ActorObject) then begin
      Result := True;
      Break;
    end;
  end;
end;
function TAIPlayObject.AllowUseMagic(wMagIdx: Word): Boolean;
var
  UserMagic: pTUserMagic;
begin
  Result := False;
  UserMagic := FindMagic(wMagIdx);
  if UserMagic <> nil then begin
    if not MagicManager.IsWarrSkill(UserMagic.wMagIdx) then begin
      Result := (UserMagic.btKey = 0) or m_boAI;
    end else begin
      Result := (UserMagic.btKey = 0) or m_boAI or (m_btRaceServer = RC_PLAYMOSTER);
    end;
  end;
end;

function TAIPlayObject.CheckUserItem(nItemType, nCount: Integer): Boolean;
begin
  Result := CheckUserItemType(nItemType, nCount) or (GetUserItemList(nItemType, nCount) >= 0);
end;

function TAIPlayObject.CheckItemType(nItemType: Integer; StdItem: pTStdItem): Boolean;
begin
  Result := False;
  case nItemType of
    1: begin
        if (StdItem.StdMode = 25) and (StdItem.Shape = 1) then Result := True;
      end;
    2: begin
        if (StdItem.StdMode = 25) and (StdItem.Shape = 2) then Result := True;
      end;
    3: begin
        if (StdItem.StdMode = 25) and (StdItem.Shape = 3) then Result := True;
      end;
    5: begin
        if (StdItem.StdMode = 25) and (StdItem.Shape = 5) then Result := True;
      end;
  end;
end;

function TAIPlayObject.CheckUserItemType(nItemType, nCount: Integer): Boolean;
var
  StdItem: pTStdItem;
begin
  Result := False;
  if (m_UseItems[U_ARMRINGL].wIndex > 0) and (Round(m_UseItems[U_ARMRINGL].Dura / 100) >= nCount) then begin
    StdItem := UserEngine.GetStdItem(m_UseItems[U_ARMRINGL].wIndex);
    if StdItem <> nil then begin
      Result := CheckItemType(nItemType, StdItem);
    end;
  end;
end;
//检测包裹中是否有符和毒
//nType 为指定类型 5 为护身符 1,2 为毒药   3,诅咒术专用
function TAIPlayObject.GetUserItemList(nItemType, nCount: Integer): Integer;
var
  I: Integer;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
begin
  Result := -1;
  for I := 0 to m_ItemList.Count - 1 do begin
    UserItem := m_ItemList.Items[I];
    StdItem := UserEngine.GetStdItem(UserItem.wIndex);
    if StdItem <> nil then begin
      if CheckItemType(nItemType, StdItem) and (Round(UserItem.Dura / 100) >= nCount) then begin
        Result := I;
        Break;
      end;
    end;
  end;
end;
//自动换毒符
function TAIPlayObject.UseItem(nItemType, nIndex: Integer): Boolean;
var
  UserItem: pTUserItem;
  AddUserItem: pTUserItem;
  StdItem: pTStdItem;
begin
  Result := False;
  if (nIndex >= 0) and (nIndex < m_ItemList.Count) then begin
    UserItem := m_ItemList.Items[nIndex];
    if m_UseItems[U_ARMRINGL {U_BUJUK}].wIndex > 0 then begin
      StdItem := UserEngine.GetStdItem(m_UseItems[U_ARMRINGL {U_BUJUK}].wIndex);
      if StdItem <> nil then begin
        if CheckItemType(nItemType, StdItem) then begin
          Result := True;
        end else begin
          m_ItemList.Delete(nIndex);
          New(AddUserItem);
          AddUserItem^ := m_UseItems[U_ARMRINGL {U_BUJUK}];
          if AddItemToBag(AddUserItem) then begin
            m_UseItems[U_ARMRINGL {U_BUJUK}] := UserItem^;
            Dispose(UserItem);
            Result := True;
          end else begin
            m_ItemList.Add(UserItem);
            Dispose(AddUserItem);
          end;
        end;
      end else begin
        m_ItemList.Delete(nIndex);
        m_UseItems[U_ARMRINGL {U_BUJUK}] := UserItem^;
        Dispose(UserItem);
        Result := True;
      end;
    end else begin
      m_ItemList.Delete(nIndex);
      m_UseItems[U_ARMRINGL {U_BUJUK}] := UserItem^;
      Dispose(UserItem);
      Result := True;
    end;
  end;
end;

function TAIPlayObject.GetRangeTargetCount(nX, nY, nRange: Integer): Integer;
var
  BaseObjectList: TList;
  BaseObject: TBaseObject;
  I: Integer;
begin
  Result := 0;
  BaseObjectList := TList.Create;
  try
    if m_PEnvir.GetMapBaseObjects(nX, nY, nRange, BaseObjectList) then begin
      for I := BaseObjectList.Count - 1 downto 0 do begin
        BaseObject := TBaseObject(BaseObjectList.Items[I]);
        if (BaseObject.m_boHideMode and not m_boCoolEye) or (not IsProperTarget(BaseObject)) then begin
          BaseObjectList.Delete(I);
        end;
      end;
      Result := BaseObjectList.Count;
    end;
  finally
    BaseObjectList.Free;
  end;
end;
//目标是否和自己在一条线上，用来检测直线攻击的魔法是否可以攻击到目标
function TAIPlayObject.CanLineAttack(nCurrX, nCurrY: Integer): Boolean;
var
  btDir: Byte;
  nX, nY: Integer;
begin
  Result := False;
  nX := nCurrX;
  nY := nCurrY;
  btDir := GetNextDirection(nCurrX, nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
  while True do begin
    if (m_TargetCret.m_nCurrX = nX) and (m_TargetCret.m_nCurrY = nY) then begin
      Result := True;
      Break;
    end;
    btDir := GetNextDirection(nX, nY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
    if not m_PEnvir.GetNextPosition(nX, nY, btDir, 1, nX, nY) then Break;
    if not m_PEnvir.CanWalkEx(nX, nY, True) then Break;
  end;
end;
//是否是能直线攻击
function TAIPlayObject.CanLineAttack(nStep: Integer): Boolean;
var
  I: Integer;
  btDir: Byte;
  nX, nY: Integer;
begin
  Result := False;
  nX := m_nCurrX;
  nY := m_nCurrY;
  btDir := GetNextDirection(nX, nY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
  for I := 1 to nStep do begin
    if (m_TargetCret.m_nCurrX = nX) and (m_TargetCret.m_nCurrY = nY) then begin
      Result := True;
      Break;
    end;
    btDir := GetNextDirection(nX, nY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
    if not m_PEnvir.GetNextPosition(nX, nY, btDir, 1, nX, nY) then Break;
    if not m_PEnvir.CanWalkEx(nX, nY, True) then Break;
  end;
end;
(*
function TAIPlayObject.SelectMagic(): Integer;
  function SelKTZandCID(var nSelectMagic: Integer): Boolean;
  var
    boKTZHitSkill, boCIDHitSkill: Boolean;
  begin
    nSelectMagic:= 0;
    Result := False;
    boKTZHitSkill := False;
    boCIDHitSkill := False;
    if m_bo43kill then begin
      nSelectMagic := 42;
      Result := True;
      Exit;
    end;
    if m_bo42kill then begin
      nSelectMagic := 43;
      if (Random(g_Config.n43KillHitRate) = 0) then begin
        m_n42kill := 2;//重击
      end else begin
        m_n42kill := 1;//轻击
      end;
      m_n42kill := 1;//轻击
      Result := True;
      Exit;
    end;
    if AllowUseMagic(42) and (not m_bo43kill) and ((GetTickCount - m_dwLatest42Tick) > g_Config.nKill43UseTime * 1000) then begin
      boCIDHitSkill := True;
    end;
    if AllowUseMagic(43) and (not m_bo42kill) and ((GetTickCount - m_dwLatest43Tick) > g_Config.nKill42UseTime * 1000) then begin
      boKTZHitSkill := True;
    end;

    if boKTZHitSkill and boCIDHitSkill then begin
      case Random(2) of
        1: begin
            Skill43OnOff;
            nSelectMagic := 42;
            Result := True;
          end;
        2: begin
            Skill42OnOff;
            if (Random(g_Config.n43KillHitRate) = 0) then begin
              m_n42kill := 2;//重击
            end else begin
              m_n42kill := 1;//轻击
            end;
            nSelectMagic := 43;
            Result := True;
          end;
      else begin
          Skill43OnOff;
          nSelectMagic := 42;
          Result := True;
        end;
      end;
      Exit;
    end;
    if boCIDHitSkill then begin
      Skill43OnOff;
      nSelectMagic := 42;
      Result := True;
    end;
    if boKTZHitSkill then begin
      Skill42OnOff;
      if (Random(g_Config.n43KillHitRate) = 0) then begin
        m_n42kill := 2;//重击
      end else begin
        m_n42kill := 1;//轻击
      end;
      nSelectMagic := 43;
      Result := True;
    end;
  end;
  function GetMoonSlaveCount: Integer;//检查月灵数量
  var
    I: Integer;
    BaseObject: TBaseObject;
  begin
    Result := 0;
    if m_SlaveList.Count <= 0 then Exit;
    for I := 0 to m_SlaveList.Count - 1 do begin
      BaseObject := m_SlaveList.Items[I];
      if (not BaseObject.m_boDeath) and (not BaseObject.m_boGhost) and (BaseObject.m_btRaceServer = 108) then Inc(Result);
    end;
  end;
  function GetMoonSlaveDeath: Boolean;//检查召唤的月灵是否死亡
  var
    I: Integer;
    BaseObject: TBaseObject;
  begin
    Result := False;
    if m_SlaveList.Count <= 0 then Exit;
    for I := 0 to m_SlaveList.Count - 1 do begin
      BaseObject := m_SlaveList.Items[I];
      if (BaseObject.m_btRaceServer = 108) and ((BaseObject.m_boDeath) or (BaseObject.m_boGhost)) then begin
        Result := True;
        Break;
      end;
    end;
  end;
  function GetCopySlaveCount: Integer;//取分身数量
  var
    I: Integer;
    BaseObject: TBaseObject;
  begin
    Result := 0;
    if m_SlaveList.Count <= 0 then Exit;
    for I := 0 to m_SlaveList.Count - 1 do begin
      BaseObject := m_SlaveList.Items[I];
      if (not BaseObject.m_boDeath) and (not BaseObject.m_boGhost) and (BaseObject.m_nCopyHumanLevel = 2) then Inc(Result);
    end;
  end;
  function GetCopySlaveDeath: Boolean;//判断分身是否死亡
  var
    I: Integer;
    BaseObject: TBaseObject;
  begin
    Result := False;
    if m_SlaveList.Count <= 0 then Exit;
    for I := 0 to m_SlaveList.Count - 1 do begin
      BaseObject := m_SlaveList.Items[I];
      if (BaseObject.m_nCopyHumanLevel = 2) and ((BaseObject.m_boDeath) or (BaseObject.m_boGhost)) then begin
        Result := True;
        Break;
      end;
    end;
  end;
  function GetSlaveCount: Integer;
  var
    I: Integer;
    BaseObject: TBaseObject;
  begin
    Result := 0;
    if m_SlaveList.Count <= 0 then Exit;
    for I := 0 to m_SlaveList.Count - 1 do begin
      BaseObject := m_SlaveList.Items[I];
      if (not BaseObject.m_boDeath) and (not BaseObject.m_boGhost) then Inc(Result);
    end;
  end;
  function GetSlaveDeath: Boolean;
  var
    I: Integer;
    BaseObject: TBaseObject;
  begin
    Result := False;
    if m_SlaveList.Count <= 0 then Exit;
    for I := 0 to m_SlaveList.Count - 1 do begin
      BaseObject := m_SlaveList.Items[I];
      if (BaseObject.m_nCopyHumanLevel = 0) and ((BaseObject.m_boDeath) or (BaseObject.m_boGhost)) then begin
        Result := True;
        Break;
      end;
    end;
  end;
  function IsUseCopySelf: Boolean;//分身术
  begin
    Result := False;
    if m_Master = nil then begin
      if AllowUseMagic(46) and ((GetCopySlaveCount <= 0) or GetCopySlaveDeath) then begin
        Result := True;
      end;
    end;
  end;
  function IsUseSkill8(): Boolean; //抗拒火环
  var
    BaseObjectList: TList;
    BaseObject: TBaseObject;
    btNewDir: Byte;
    nTargetX, nTargetY: Integer;
    I: Integer;
  begin
    Result := False;
    if AllowUseMagic(8) and (GetTickCount - m_SkillUseTick[8] > 5000) then begin
      if (m_TargetCret <> nil) and (m_Abil.Level > m_TargetCret.m_Abil.Level) and
        (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 1) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 1) then begin
        btNewDir := GetNextDirection(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, m_nCurrX, m_nCurrY);
        if m_PEnvir.GetNextPosition(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, GetBackDir(btNewDir), 1, nTargetX, nTargetY) then begin
          Result := m_PEnvir.CanWalk(nTargetX, nTargetY, True);
        end;
        if Result then Exit;
      end;
      BaseObjectList := TList.Create;
      try
        if m_PEnvir.GetMapBaseObjects(m_nCurrX, m_nCurrY, 1, BaseObjectList) then begin
          for I := 0 to BaseObjectList.Count - 1 do begin
            BaseObject := TBaseObject(BaseObjectList.Items[I]);
            if (m_TargetCret = BaseObject) and (BaseObject.m_boHideMode and not m_boCoolEye) or BaseObject.m_boDeath or BaseObject.m_boGhost or (not IsProperTarget(BaseObject)) then Continue;
            if BaseObject.m_Abil.Level < m_Abil.Level then begin
              btNewDir := GetNextDirection(BaseObject.m_nCurrX, BaseObject.m_nCurrY, m_nCurrX, m_nCurrY);
              if m_PEnvir.GetNextPosition(BaseObject.m_nCurrX, BaseObject.m_nCurrY, GetBackDir(btNewDir), 1, nTargetX, nTargetY) then begin
                if m_PEnvir.CanWalk(nTargetX, nTargetY, True) then begin
                  Result := True;
                  Break;
                end;
              end;
            end;
          end;
        end;
      finally
        BaseObjectList.Free;
      end;
    end;
  end;
  function IsUseSkill48: Boolean; //气功波
  var
    BaseObjectList: TList;
    BaseObject: TBaseObject;
    btNewDir: Byte;
    nTargetX, nTargetY: Integer;
    I: Integer;
  begin
    Result := False;
    if AllowUseMagic(48) and (GetTickCount - m_SkillUseTick[48] > 1000 * 5) then begin
      if (m_TargetCret <> nil) and (m_Abil.Level > m_TargetCret.m_Abil.Level) and
        (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 1) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 1) then begin
        btNewDir := GetNextDirection(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, m_nCurrX, m_nCurrY);
        if m_PEnvir.GetNextPosition(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, GetBackDir(btNewDir), 1, nTargetX, nTargetY) then begin
          Result := m_PEnvir.CanWalk(nTargetX, nTargetY, True);
        end;
        if Result then Exit;
      end;
      BaseObjectList := TList.Create;
      try
        if m_PEnvir.GetMapBaseObjects(m_nCurrX, m_nCurrY, 1, BaseObjectList) then begin
          for I := 0 to BaseObjectList.Count - 1 do begin
            BaseObject := TBaseObject(BaseObjectList.Items[I]);
            if (m_TargetCret = BaseObject) and (BaseObject.m_boHideMode and not m_boCoolEye) or BaseObject.m_boDeath or BaseObject.m_boGhost or (not IsProperTarget(BaseObject)) then Continue;
            if BaseObject.m_Abil.Level < m_Abil.Level then begin
              btNewDir := GetNextDirection(BaseObject.m_nCurrX, BaseObject.m_nCurrY, m_nCurrX, m_nCurrY);
              if m_PEnvir.GetNextPosition(BaseObject.m_nCurrX, BaseObject.m_nCurrY, GetBackDir(btNewDir), 1, nTargetX, nTargetY) then begin
                if m_PEnvir.CanWalk(nTargetX, nTargetY, True) then begin
                  Result := True;
                  Break;
                end;
              end;

            end;
          end;
        end;
      finally
        BaseObjectList.Free;
      end;
    end;
  end;
  function IsUseSkill27: Boolean; //野蛮冲撞
    function CanMotaebo(BaseObject: TBaseObject; nMagicLevel: Integer): Boolean;
    var
      nC: Integer;
    begin
      Result := False;
      if (m_Abil.Level > BaseObject.m_Abil.Level) and (not BaseObject.m_boStickMode) then begin
        nC := m_Abil.Level - BaseObject.m_Abil.Level;
        if Random(20) < ((nMagicLevel * 4) + 6 + nC) then Result := True;
      end;
    end;
  var
    nX, nY: Integer;
    nDir: Integer;
    UserMagic: pTUserMagic;
  begin
    Result := False;
    if AllowUseMagic(27) and (m_TargetCret.m_Abil.Level < m_Abil.Level) and ((GetPoseCreate = m_TargetCret) or (m_TargetCret.GetPoseCreate = Self)) and (GetTickCount - m_SkillUseTick[27] > 1000 * 10) then begin
      UserMagic := FindMagic(27);
      if CanMotaebo(m_TargetCret, UserMagic.btLevel) then begin
        nDir := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
        if m_PEnvir.GetNextPosition(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, nDir, 1, nX, nY) then begin
          Result := m_TargetCret.m_PEnvir.CanWalk(nX, nY, False);
        end;
      end;
    end;
  end;
  function UseFireCross: Boolean;//火墙
  begin
    if (m_TargetCret <> nil) and AllowUseMagic(22) and (GetTickCount - m_SkillUseTick[22] > 1000 * 5) then begin
      Result := True;
      if (not m_PEnvir.CanWalk(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY - 1, False)) or (m_PEnvir.GetEvent(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY - 1) <> nil) then
        if (not m_PEnvir.CanWalk(m_TargetCret.m_nCurrX - 1, m_TargetCret.m_nCurrY, False)) or (m_PEnvir.GetEvent(m_TargetCret.m_nCurrX - 1, m_TargetCret.m_nCurrY) <> nil) then
          if (not m_PEnvir.CanWalk(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, False)) or (m_PEnvir.GetEvent(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY) <> nil) then
            if (not m_PEnvir.CanWalk(m_TargetCret.m_nCurrX + 1, m_TargetCret.m_nCurrY, False)) or (m_PEnvir.GetEvent(m_TargetCret.m_nCurrX + 1, m_TargetCret.m_nCurrY) <> nil) then
              if (not m_PEnvir.CanWalk(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY + 1, False)) or (m_PEnvir.GetEvent(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY + 1) <> nil) then
                Result := False;
    end else Result := False;
  end;
  function QuickLighting: Boolean;//疾光电影
  begin
    Result := False;
    if AllowUseMagic(10) and CanLineAttack(6) then begin
      if (((Abs(m_nCurrX-m_TargetCret.m_nCurrX)<=4) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)=0)) or
          ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=0) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)<=4)) or
          (((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=2) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)=2)) or
          ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=3) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)=3))  or
          ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=4) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)=4)))) then begin
        Result := True;
      end;
    end;
  end;
  function IsUseSkill41: Boolean; //狮子吼
  var
    BaseObjectList: TList;
    BaseObject: TBaseObject;
    I, nCount: Integer;
  begin
    Result := False;
    if (m_TargetCret <> nil) and (not (m_TargetCret.m_btRaceServer in [RC_PLAYOBJECT, RC_HEROOBJECT, RC_PLAYMOSTER])) and AllowUseMagic(41) and (GetTickCount - m_SkillUseTick[41] > 1000 * 10) then begin
      nCount := 0;
      BaseObjectList := TList.Create;
      try
        if m_PEnvir.GetMapBaseObjects(m_nCurrX, m_nCurrY, 3, BaseObjectList) then begin
          for I := 0 to BaseObjectList.Count - 1 do begin
            BaseObject := TBaseObject(BaseObjectList.Items[I]);
            if (BaseObject.m_boHideMode and not m_boCoolEye) or BaseObject.m_boDeath
               or BaseObject.m_boGhost or (not IsProperTarget(BaseObject)) then Continue;
            if BaseObject.m_Abil.Level < m_Abil.Level then Inc(nCount);
            if nCount >= 3 then begin
              Result := True;
              Break;
            end;
          end;
        end;
      finally
        BaseObjectList.Free;
      end;
    end;
  end;
  function IsUseSkill38: Boolean; //群毒术
  var
    BaseObjectList: TList;
    BaseObject: TBaseObject;
    I, n01, n02: Integer;
  begin
    Result := False;
    if AllowUseMagic(38) then begin
      n01 := 0;
      n02 := 0;
      BaseObjectList := TList.Create;
      try
        if m_PEnvir.GetMapBaseObjects(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 3, BaseObjectList) then begin
          for I := 0 to BaseObjectList.Count - 1 do begin
            BaseObject := TBaseObject(BaseObjectList.Items[I]);
            if (BaseObject.m_boHideMode and not m_boCoolEye) or BaseObject.m_boDeath
              or BaseObject.m_boGhost or (not IsProperTarget(BaseObject)) then Continue;
            if (BaseObject.m_wStatusTimeArr[POISON_DECHEALTH] = 0) then Inc(n01);
            if (BaseObject.m_wStatusTimeArr[POISON_DAMAGEARMOR] = 0) then Inc(n02);
          end;
        end;
      finally
        BaseObjectList.Free;
      end;
      if (n01 > 1) and (n02 = 0) then begin
        if CheckUserItem(1, 2) then begin
          m_nSelItemType := 1;
          Result := True;
        end;
      end else
        if (n01 = 0) and (n02 > 1) then begin
        if CheckUserItem(2, 2) then begin
          m_nSelItemType := 2;
          Result := True;
        end;
      end else
        if (n01 > 1) and (n02 > 1) then begin
        if n01 > n02 then begin
          if CheckUserItem(1, 2) then begin
            m_nSelItemType := 1;
            Result := True;
          end else
            if CheckUserItem(2, 2) then begin
            m_nSelItemType := 2;
            Result := True;
          end;
        end else begin
          if CheckUserItem(2, 2) then begin
            m_nSelItemType := 2;
            Result := True;
          end else
            if CheckUserItem(1, 2) then begin
            m_nSelItemType := 1;
            Result := True;
          end;
        end;
      end;
    end;
  end;
var
  btDir: Byte;
  nSelectMagic, nRangeTargetCount, nSelfRangeTargetCount, nRangeTargetCountByDir, nCode: Integer;
  boVisibleActors: Boolean;
begin
  Result := 0;
  if m_boAI and (m_TargetCret <> nil) and (m_MyHero <> nil) and
    (GetTickCount - m_dwHeroUseSpellTick > 12000) and
    (THeroObject(m_MyHero).m_nFirDragonPoint >= g_Config.nMaxFirDragonPoint) then begin//气槽满,自动使用合击
    {$IF M2Version = 1}
    if not THeroObject(m_MyHero).m_boUseBatter then begin//英雄连击停止后才使用合击
      m_dwHeroUseSpellTick:= GetTickCount();//自动使用合击间隔
      ClientHeroUseSpell;
      Exit;
    end;
    {$IFEND}
  end;
  case m_btJob of
    0: begin //战士
        if IsUseSkill27 then begin//野蛮冲撞
          Result := 27;
          Exit;
        end;
        if m_boFireHitSkill then begin//烈火
          Result := 26;
          Exit;
        end;
        if m_boDailySkill then begin//逐日
          Result := SKILL_74;
          Exit;
        end;
        if AllowUseMagic(26) and (not m_boFireHitSkill) and ((GetTickCount - m_dwLatestFireHitTick) > 10000) then begin//烈火
          AllowFireHitSkill;
          Result := 26;
          Exit;
        end;
        if SelKTZandCID(nSelectMagic) then begin
          Result := nSelectMagic;
          Exit;
        end;
        if AllowUseMagic(SKILL_74) and (not m_boDailySkill) and ((GetTickCount - m_dwLatestDailyTick) > 12000) then begin//逐日
          AllowDailySkill;
          Result := SKILL_74;
          Exit;
        end;
        if GetAttackDir(m_TargetCret, 2, btDir) then begin //隔位刺杀剑术
          if AllowUseMagic(12) then begin
            if not m_boUseThrusting then begin
              ThrustingOnOff(True);
            end;
            Result := 12;
            Exit;
          end;
        end;
        if (Random(20) = 0) and AllowUseMagic(7) then begin //攻杀剑术
          m_boPowerHit := True;
          Result := 7;
          Exit;
        end;
        if IsUseSkill41 then begin//狮子吼
          Result := 41;
          Exit;
        end;

        nRangeTargetCount := GetNearTargetCount;

        nRangeTargetCountByDir := GetRangeTargetCountByDir(GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY), m_nCurrX, m_nCurrY, 4);
        if (nRangeTargetCountByDir > 1) and (nRangeTargetCount < 3) then begin //多个怪物
          if AllowUseMagic(12) then begin
            if not m_boUseThrusting then begin
              ThrustingOnOff(True);
            end;
            Result := 12;
            Exit;
          end;

          if SelKTZandCID(nSelectMagic) then begin
            Result := nSelectMagic;
            Exit;
          end;
          if AllowUseMagic(39) and (GetTickCount - m_SkillUseTick[39] > 10000) then begin
            m_SkillUseTick[39] := GetTickCount; //彻地钉
            Result := 39;
            Exit;
          end;
        end;

        if (nRangeTargetCount >= 5) then begin //被怪物包围 >=5
          if AllowUseMagic(40) then begin //抱月刀法
            if not m_boCrsHitkill then begin
              SkillCrsOnOff(True);
            end;
            Result := 40;
            Exit;
          end;
          if AllowUseMagic(39) and (GetTickCount - m_SkillUseTick[39] > 10000) then begin
            m_SkillUseTick[39] := GetTickCount; //彻地钉
            Result := 39;
            Exit;
          end;
        end;
        if (nRangeTargetCount >= 2) then begin //被怪物包围 >=2
          if AllowUseMagic(25) then begin //半月
            if not m_boUseHalfMoon then begin
              HalfMoonOnOff(True, 0);
            end;
            Result := 25;
            Exit;
          end;
          if AllowUseMagic(39) and (GetTickCount - m_SkillUseTick[39] > 10000) then begin
            m_SkillUseTick[39] := GetTickCount; //彻地钉
            Result := 39;
            Exit;
          end;
        end;
        if (Random(10) = 0) and AllowUseMagic(7) then begin //攻杀剑术
          m_boPowerHit := True;
          Result := 7;
          Exit;
        end;
        if AllowUseMagic(12) then begin //刺杀剑术
          if not m_boUseThrusting then begin
            ThrustingOnOff(True);
          end;
          Result := 12;
          Exit;
        end;
        if AllowUseMagic(25) then begin //半月
          if not m_boUseHalfMoon then begin
            HalfMoonOnOff(True, 0);
          end;
          Result := 25;
          Exit;
        end;
        if AllowUseMagic(40) then begin //抱月刀法
          if not m_boCrsHitkill then begin
            SkillCrsOnOff(True);
          end;
          Result := 40;
          Exit;
        end;
        if AllowUseMagic(39) and (GetTickCount - m_SkillUseTick[39] > 10000) then begin //彻地钉
          Result := 39;
          Exit;
        end;
        if (m_TargetCret <> nil) and (not m_TargetCret.m_boDeath) and AllowUseMagic(7) then begin //攻杀剑术
          Result := 7;
          Exit;
        end;
        if SelKTZandCID(nSelectMagic) then begin
          Result := nSelectMagic;
          Exit;
        end;
      end;
    1: begin //法师
        if (AllowUseMagic(31)) and (m_wStatusTimeArr[STATE_BUBBLEDEFENCEUP] = 0) then begin {使用 魔法盾}
          Result := 31;
          Exit;
        end;
        nRangeTargetCount := GetRangeTargetCount(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 3);
        nSelfRangeTargetCount := GetNearTargetCount;
        nRangeTargetCountByDir := GetRangeTargetCountByDir(GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY), m_nCurrX, m_nCurrY, 6);
        if IsUseCopySelf { and ((nSelfRangeTargetCount > 1) or (nRangeTargetCount > 1))} then begin
          //m_TargetCret := nil;
          Result := 46; //分身术
          Exit;
        end;

        if nRangeTargetCountByDir > 5 then begin
          if (AllowUseMagic(58)) and (GetTickCount - m_SkillUseTick[58] > 5000) then begin//流星火雨
            Result := 58;
            Exit;
          end;
        end;
        if ((m_TargetCret.m_btRaceServer = RC_PLAYOBJECT) or (m_TargetCret.m_btRaceServer = RC_HEROOBJECT) or (m_TargetCret.m_btRaceServer = RC_PLAYMOSTER)) then begin
          if UseFireCross then begin
            Result := 22; //火墙
            Exit;
          end;
        end else begin
          if nRangeTargetCountByDir > 1 then begin
            if UseFireCross then begin
              Result := 22; //火墙
              Exit;
            end;
          end;
        end;

        if (nSelfRangeTargetCount > 0) then begin
          if IsUseSkill8 then begin
            Result := 8; //抗拒火环
            Exit;
          end;
        end;
        if (nSelfRangeTargetCount < 10) then begin
          if (nRangeTargetCountByDir >= 4) then begin
            if QuickLighting then begin
              Result := 10; //疾光电影
              Exit;
            end;
          end;
        end else begin
          if ((m_TargetCret.m_btRaceServer = RC_PLAYOBJECT) or (m_TargetCret.m_btRaceServer = RC_HEROOBJECT) or (m_TargetCret.m_btRaceServer = RC_PLAYMOSTER)) then begin
            if UseFireCross then begin
              Result := 22; //火墙
              Exit;
            end;
          end else begin
            if nRangeTargetCountByDir > 1 then begin
              if UseFireCross then begin
                Result := 22; //火墙
                Exit;
              end;
            end;
          end;

          case Random(7) of
            0, 1: begin
                if ((m_TargetCret.m_btRaceServer = RC_PLAYOBJECT) or (m_TargetCret.m_btRaceServer = RC_HEROOBJECT) or (m_TargetCret.m_btRaceServer = RC_PLAYMOSTER)) then begin
                  if AllowUseMagic(33) then begin
                    Result := 33; //冰咆哮
                    Exit;
                  end;
                end else begin
                  if AllowUseMagic(33) and (nRangeTargetCount >= 4) then begin
                    Result := 33; //冰咆哮
                    Exit;
                  end;
                end;
                if QuickLighting and (nRangeTargetCountByDir >= 3) then begin
                  Result := 10; //疾光电影
                  Exit;
                end;
                if AllowUseMagic(23) then begin
                  Result := 23; //爆裂火焰
                  Exit;
                end;
                if AllowUseMagic(37) then begin
                  Result := 37; //群体雷电术
                  Exit;
                end;
                if AllowUseMagic(45) then begin
                  Result := 45; //灭天火
                  Exit;
                end;
                if AllowUseMagic(47) then begin
                  Result := 47; //火龙焰
                  Exit;
                end;
                if (m_TargetCret <> nil) and (not m_TargetCret.m_boDeath) and AllowUseMagic(11) then begin
                  Result := 11; //雷电术
                  Exit;
                end;
                if (m_TargetCret <> nil) and (not m_TargetCret.m_boDeath) and AllowUseMagic(5) then begin
                  Result := 5; //大火球
                  Exit;
                end;
                if (m_TargetCret <> nil) and (not m_TargetCret.m_boDeath) and AllowUseMagic(1) then begin
                  Result := 1; //火球术
                  Exit;
                end;
              end;
            2, 3: begin
                if AllowUseMagic(23) then begin
                  Result := 23; //爆裂火焰
                  Exit;
                end;
                if ((m_TargetCret.m_btRaceServer = RC_PLAYOBJECT) or (m_TargetCret.m_btRaceServer = RC_HEROOBJECT) or (m_TargetCret.m_btRaceServer = RC_PLAYMOSTER)) then begin
                  if AllowUseMagic(33) then begin
                    Result := 33; //冰咆哮
                    Exit;
                  end;
                end else begin
                  if AllowUseMagic(33) and (nRangeTargetCount >= 5) then begin
                    Result := 33; //冰咆哮
                    Exit;
                  end;
                end;
                if AllowUseMagic(37) then begin
                  Result := 37; //群体雷电术
                  Exit;
                end;
                if AllowUseMagic(45) then begin
                  Result := 45; //灭天火
                  Exit;
                end;
                if AllowUseMagic(47) then begin
                  Result := 47; //火龙焰
                  Exit;
                end;
                if (m_TargetCret <> nil) and (not m_TargetCret.m_boDeath) and AllowUseMagic(11) then begin
                  Result := 11; //雷电术
                  Exit;
                end;
                if (m_TargetCret <> nil) and (not m_TargetCret.m_boDeath) and AllowUseMagic(5) then begin
                  Result := 5; //大火球
                  Exit;
                end;
                if (m_TargetCret <> nil) and (not m_TargetCret.m_boDeath) and AllowUseMagic(1) then begin
                  Result := 1; //火球术
                  Exit;
                end;
              end;
            4, 5: begin
                if AllowUseMagic(37) then begin
                  Result := 37; //群体雷电术
                  Exit;
                end;
                if AllowUseMagic(23) then begin
                  Result := 23; //爆裂火焰
                  Exit;
                end;
                if ((m_TargetCret.m_btRaceServer = RC_PLAYOBJECT) or (m_TargetCret.m_btRaceServer = RC_HEROOBJECT) or (m_TargetCret.m_btRaceServer = RC_PLAYMOSTER)) then begin
                  if AllowUseMagic(33) then begin
                    Result := 33; //冰咆哮
                    Exit;
                  end;
                end else begin
                  if AllowUseMagic(33) and (nRangeTargetCount >= 5) then begin
                    Result := 33; //冰咆哮
                    Exit;
                  end;
                end;
                if AllowUseMagic(45) then begin
                  Result := 45; //灭天火
                  Exit;
                end;
                if AllowUseMagic(47) then begin
                  Result := 47; //火龙焰
                  Exit;
                end;
                if (m_TargetCret <> nil) and (not m_TargetCret.m_boDeath) and AllowUseMagic(11) then begin
                  Result := 11; //雷电术
                  Exit;
                end;
                if (m_TargetCret <> nil) and (not m_TargetCret.m_boDeath) and AllowUseMagic(5) then begin
                  Result := 5; //大火球
                  Exit;
                end;
                if (m_TargetCret <> nil) and (not m_TargetCret.m_boDeath) and AllowUseMagic(1) then begin
                  Result := 1; //火球术
                  Exit;
                end;
              end;
            6, 7: begin
                if QuickLighting and (nRangeTargetCountByDir >= 3) then begin
                  Result := 10; //疾光电影
                  Exit;
                end;
                if AllowUseMagic(37) then begin
                  Result := 37; //群体雷电术
                  Exit;
                end;
                if AllowUseMagic(23) then begin
                  Result := 23; //爆裂火焰
                  Exit;
                end;
                if ((m_TargetCret.m_btRaceServer = RC_PLAYOBJECT) or (m_TargetCret.m_btRaceServer = RC_HEROOBJECT) or (m_TargetCret.m_btRaceServer = RC_PLAYMOSTER)) then begin
                  if AllowUseMagic(33) then begin
                    Result := 33; //冰咆哮
                    Exit;
                  end;
                end else begin
                  if AllowUseMagic(33) and (nRangeTargetCount >= 5) then begin
                    Result := 33; //冰咆哮
                    Exit;
                  end;
                end;
                if AllowUseMagic(45) then begin
                  Result := 45; //灭天火
                  Exit;
                end;
                if AllowUseMagic(47) then begin
                  Result := 47; //火龙焰
                  Exit;
                end;
                if (m_TargetCret <> nil) and (not m_TargetCret.m_boDeath) and AllowUseMagic(11) then begin
                  Result := 11; //雷电术
                  Exit;
                end;
                if (m_TargetCret <> nil) and (not m_TargetCret.m_boDeath) and AllowUseMagic(5) then begin
                  Result := 5; //大火球
                  Exit;
                end;
                if (m_TargetCret <> nil) and (not m_TargetCret.m_boDeath) and AllowUseMagic(1) then begin
                  Result := 1; //火球术
                  Exit;
                end;
              end;
          end;
        end;

        if (nSelfRangeTargetCount >= 1) then begin //被怪物包围
          if AllowUseMagic(24) and ((m_TargetCret.m_btRaceServer = 101) or (m_TargetCret.m_btRaceServer = 102) or (m_TargetCret.m_btRaceServer = 104)) then begin //祖玛系怪物
            Result := 24; //地狱雷光
            Exit;
          end;

          if QuickLighting and (nRangeTargetCountByDir >= 3) then begin
            Result := 10; //疾光电影
            Exit;
          end;

          if ((m_TargetCret.m_btRaceServer = RC_PLAYOBJECT) or (m_TargetCret.m_btRaceServer = RC_HEROOBJECT) or (m_TargetCret.m_btRaceServer = RC_PLAYMOSTER)) then begin
            if AllowUseMagic(33) and (nSelfRangeTargetCount >= 2) then begin
              Result := 33; //冰咆哮
              Exit;
            end;
          end else begin
            if AllowUseMagic(33) and (nSelfRangeTargetCount >= 5) then begin
              Result := 33; //冰咆哮
              Exit;
            end;
          end;

          if AllowUseMagic(37) then begin
            Result := 37; //群体雷电术
            Exit;
          end;

          if AllowUseMagic(45) then begin
            Result := 45; //灭天火
            Exit;
          end;

          if AllowUseMagic(23) then begin
            Result := 23; //爆裂火焰
            Exit;
          end;

          if AllowUseMagic(47) then begin
            Result := 47; //火龙焰
            Exit;
          end;

          if AllowUseMagic(24) then begin
            Result := 24; //地狱雷光
            Exit;
          end;
        end;

        if nRangeTargetCount > 1 then begin
          if ((m_TargetCret.m_btRaceServer = RC_PLAYOBJECT) or (m_TargetCret.m_btRaceServer = RC_HEROOBJECT) or (m_TargetCret.m_btRaceServer = RC_PLAYMOSTER)) then begin
            if UseFireCross then begin
              Result := 22; //火墙
              Exit;
            end;
          end else begin
            if nRangeTargetCountByDir > 1 then begin
              if UseFireCross then begin
                Result := 22; //火墙
                Exit;
              end;
            end;
          end;
          case Random(7) of
            0, 1: begin
                if ((m_TargetCret.m_btRaceServer = RC_PLAYOBJECT) or (m_TargetCret.m_btRaceServer = RC_HEROOBJECT) or (m_TargetCret.m_btRaceServer = RC_PLAYMOSTER)) then begin
                  if AllowUseMagic(33) then begin
                    Result := 33; //冰咆哮
                    Exit;
                  end;
                end else begin
                  if AllowUseMagic(33) and (nRangeTargetCount >= 5) then begin
                    Result := 33; //冰咆哮
                    Exit;
                  end;
                end;
                if QuickLighting and (nRangeTargetCountByDir >= 3) then begin
                  Result := 10; //疾光电影
                  Exit;
                end;
                if AllowUseMagic(23) then begin
                  Result := 23; //爆裂火焰
                  Exit;
                end;
                if AllowUseMagic(37) then begin
                  Result := 37; //群体雷电术
                  Exit;
                end;
                if AllowUseMagic(45) then begin
                  Result := 45; //灭天火
                  Exit;
                end;
                if AllowUseMagic(47) then begin
                  Result := 47; //火龙焰
                  Exit;
                end;
                if (m_TargetCret <> nil) and (not m_TargetCret.m_boDeath) and AllowUseMagic(11) then begin
                  Result := 11; //雷电术
                  Exit;
                end;
                if (m_TargetCret <> nil) and (not m_TargetCret.m_boDeath) and AllowUseMagic(5) then begin
                  Result := 5; //大火球
                  Exit;
                end;
                if (m_TargetCret <> nil) and (not m_TargetCret.m_boDeath) and AllowUseMagic(1) then begin
                  Result := 1; //火球术
                  Exit;
                end;
              end;
            2, 3: begin
                if AllowUseMagic(23) then begin
                  Result := 23; //爆裂火焰
                  Exit;
                end;
                if ((m_TargetCret.m_btRaceServer = RC_PLAYOBJECT) or (m_TargetCret.m_btRaceServer = RC_HEROOBJECT) or (m_TargetCret.m_btRaceServer = RC_PLAYMOSTER)) then begin
                  if AllowUseMagic(33) then begin
                    Result := 33; //冰咆哮
                    Exit;
                  end;
                end else begin
                  if AllowUseMagic(33) and (nRangeTargetCount >= 5) then begin
                    Result := 33; //冰咆哮
                    Exit;
                  end;
                end;
                if AllowUseMagic(37) then begin
                  Result := 37; //群体雷电术
                  Exit;
                end;
                if AllowUseMagic(45) then begin
                  Result := 45; //灭天火
                  Exit;
                end;
                if AllowUseMagic(47) then begin
                  Result := 47; //火龙焰
                  Exit;
                end;
                if (m_TargetCret <> nil) and (not m_TargetCret.m_boDeath) and AllowUseMagic(11) then begin
                  Result := 11; //雷电术
                  Exit;
                end;
                if (m_TargetCret <> nil) and (not m_TargetCret.m_boDeath) and AllowUseMagic(5) then begin
                  Result := 5; //大火球
                  Exit;
                end;
                if (m_TargetCret <> nil) and (not m_TargetCret.m_boDeath) and AllowUseMagic(1) then begin
                  Result := 1; //火球术
                  Exit;
                end;
              end;
            4, 5: begin
                if AllowUseMagic(37) then begin
                  Result := 37; //群体雷电术
                  Exit;
                end;
                if AllowUseMagic(23) then begin
                  Result := 23; //爆裂火焰
                  Exit;
                end;
                if ((m_TargetCret.m_btRaceServer = RC_PLAYOBJECT) or (m_TargetCret.m_btRaceServer = RC_HEROOBJECT) or (m_TargetCret.m_btRaceServer = RC_PLAYMOSTER)) then begin
                  if AllowUseMagic(33) then begin
                    Result := 33; //冰咆哮
                    Exit;
                  end;
                end else begin
                  if AllowUseMagic(33) and (nRangeTargetCount >= 5) then begin
                    Result := 33; //冰咆哮
                    Exit;
                  end;
                end;
                if AllowUseMagic(45) then begin
                  Result := 45; //灭天火
                  Exit;
                end;
                if AllowUseMagic(47) then begin
                  Result := 47; //火龙焰
                  Exit;
                end;
                if (m_TargetCret <> nil) and (not m_TargetCret.m_boDeath) and AllowUseMagic(11) then begin
                  Result := 11; //雷电术
                  Exit;
                end;
                if (m_TargetCret <> nil) and (not m_TargetCret.m_boDeath) and AllowUseMagic(5) then begin
                  Result := 5; //大火球
                  Exit;
                end;
                if (m_TargetCret <> nil) and (not m_TargetCret.m_boDeath) and AllowUseMagic(1) then begin
                  Result := 1; //火球术
                  Exit;
                end;
              end;
            6, 7: begin
                if QuickLighting and (nRangeTargetCountByDir >= 3) then begin
                  Result := 10; //疾光电影
                  Exit;
                end;
                if AllowUseMagic(37) then begin
                  Result := 37; //群体雷电术
                  Exit;
                end;
                if AllowUseMagic(23) then begin
                  Result := 23; //爆裂火焰
                  Exit;
                end;
                if ((m_TargetCret.m_btRaceServer = RC_PLAYOBJECT) or (m_TargetCret.m_btRaceServer = RC_HEROOBJECT) or (m_TargetCret.m_btRaceServer = RC_PLAYMOSTER)) then begin
                  if AllowUseMagic(33) then begin
                    Result := 33; //冰咆哮
                    Exit;
                  end;
                end else begin
                  if AllowUseMagic(33) and (nRangeTargetCount >= 5) then begin
                    Result := 33; //冰咆哮
                    Exit;
                  end;
                end;
                if AllowUseMagic(45) then begin
                  Result := 45; //灭天火
                  Exit;
                end;
                if AllowUseMagic(47) then begin
                  Result := 47; //火龙焰
                  Exit;
                end;
                if (m_TargetCret <> nil) and (not m_TargetCret.m_boDeath) and AllowUseMagic(11) then begin
                  Result := 11; //雷电术
                  Exit;
                end;
                if (m_TargetCret <> nil) and (not m_TargetCret.m_boDeath) and AllowUseMagic(5) then begin
                  Result := 5; //大火球
                  Exit;
                end;
                if (m_TargetCret <> nil) and (not m_TargetCret.m_boDeath) and AllowUseMagic(1) then begin
                  Result := 1; //火球术
                  Exit;
                end;
              end;
          end;
        end;

        case Random(7) of
          0, 1: begin
              if (m_TargetCret <> nil) and (not m_TargetCret.m_boDeath) and AllowUseMagic(11) then begin
                Result := 11; //雷电术
                Exit;
              end;
              if QuickLighting then begin
                Result := 10; //疾光电影
                Exit;
              end;
              if (m_TargetCret <> nil) and (not m_TargetCret.m_boDeath) and AllowUseMagic(5) then begin
                Result := 5; //大火球
                Exit;
              end;
              if (m_TargetCret <> nil) and (not m_TargetCret.m_boDeath) and AllowUseMagic(1) then begin
                Result := 1; //火球术
                Exit;
              end;
              if AllowUseMagic(37) then begin
                Result := 37; //群体雷电术
                Exit;
              end;
              if AllowUseMagic(23) then begin
                Result := 23; //爆裂火焰
                Exit;
              end;
              if AllowUseMagic(33) then begin
                Result := 33; //冰咆哮
                Exit;
              end;
              if AllowUseMagic(45) then begin
                Result := 45; //灭天火
                Exit;
              end;
              if AllowUseMagic(47) then begin
                Result := 47; //火龙焰
                Exit;
              end;
              if ((m_TargetCret.m_btRaceServer = RC_PLAYOBJECT) or (m_TargetCret.m_btRaceServer = RC_HEROOBJECT) or (m_TargetCret.m_btRaceServer = RC_PLAYMOSTER)) then begin
                if UseFireCross then begin
                  Result := 22; //火墙
                  Exit;
                end;
              end else begin
                if nRangeTargetCountByDir > 1 then begin
                  if UseFireCross then begin
                    Result := 22; //火墙
                    Exit;
                  end;
                end;
              end;
            end;
          2, 3: begin
              if AllowUseMagic(45) then begin
                Result := 45; //灭天火
                Exit;
              end;
              if ((m_TargetCret.m_btRaceServer = RC_PLAYOBJECT) or (m_TargetCret.m_btRaceServer = RC_HEROOBJECT) or (m_TargetCret.m_btRaceServer = RC_PLAYMOSTER)) then begin
                if UseFireCross then begin
                  Result := 22; //火墙
                  Exit;
                end;
              end else begin
                if nRangeTargetCountByDir > 1 then begin
                  if UseFireCross then begin
                    Result := 22; //火墙
                    Exit;
                  end;
                end;
              end;
              if (m_TargetCret <> nil) and (not m_TargetCret.m_boDeath) and AllowUseMagic(5) then begin
                Result := 5; //大火球
                Exit;
              end;

              if (m_TargetCret <> nil) and (not m_TargetCret.m_boDeath) and AllowUseMagic(11) then begin
                Result := 11; //雷电术
                Exit;
              end;
              if (m_TargetCret <> nil) and (not m_TargetCret.m_boDeath) and AllowUseMagic(1) then begin
                Result := 1; //火球术
                Exit;
              end;
              if AllowUseMagic(37) then begin
                Result := 37; //群体雷电术
                Exit;
              end;
              if AllowUseMagic(23) then begin
                Result := 23; //爆裂火焰
                Exit;
              end;
              if AllowUseMagic(33) then begin
                Result := 33; //冰咆哮
                Exit;
              end;

              if AllowUseMagic(47) then begin
                Result := 47; //火龙焰
                Exit;
              end;
            end;

          4, 5: begin
              if ((m_TargetCret.m_btRaceServer = RC_PLAYOBJECT) or (m_TargetCret.m_btRaceServer = RC_HEROOBJECT) or (m_TargetCret.m_btRaceServer = RC_PLAYMOSTER)) then begin
                if UseFireCross then begin
                  Result := 22; //火墙
                  Exit;
                end;
              end else begin
                if nRangeTargetCountByDir > 1 then begin
                  if UseFireCross then begin
                    Result := 22; //火墙
                    Exit;
                  end;
                end;
              end;

              if (m_TargetCret <> nil) and (not m_TargetCret.m_boDeath) and AllowUseMagic(11) then begin
                Result := 11; //雷电术
                Exit;
              end;

              if AllowUseMagic(45) then begin
                Result := 45; //灭天火
                Exit;
              end;

              if (m_TargetCret <> nil) and (not m_TargetCret.m_boDeath) and AllowUseMagic(5) then begin
                Result := 5; //大火球
                Exit;
              end;

              if (m_TargetCret <> nil) and (not m_TargetCret.m_boDeath) and AllowUseMagic(1) then begin
                Result := 1; //火球术
                Exit;
              end;

              if AllowUseMagic(37) then begin
                Result := 37; //群体雷电术
                Exit;
              end;

              if AllowUseMagic(23) then begin
                Result := 23; //爆裂火焰
                Exit;
              end;

              if AllowUseMagic(33) then begin
                Result := 33; //冰咆哮
                Exit;
              end;

              if AllowUseMagic(47) then begin
                Result := 47; //火龙焰
                Exit;
              end;
            end;
          6, 7: begin
              if QuickLighting then begin
                Result := 10; //疾光电影
                Exit;
              end;
              if (m_TargetCret <> nil) and (not m_TargetCret.m_boDeath) and AllowUseMagic(11) then begin
                Result := 11; //雷电术
                Exit;
              end;
              if (m_TargetCret <> nil) and (not m_TargetCret.m_boDeath) and AllowUseMagic(5) then begin
                Result := 5; //大火球
                Exit;
              end;
              if (m_TargetCret <> nil) and (not m_TargetCret.m_boDeath) and AllowUseMagic(1) then begin
                Result := 1; //火球术
                Exit;
              end;
              if AllowUseMagic(37) then begin
                Result := 37; //群体雷电术
                Exit;
              end;
              if AllowUseMagic(23) then begin
                Result := 23; //爆裂火焰
                Exit;
              end;
              if AllowUseMagic(33) then begin
                Result := 33; //冰咆哮
                Exit;
              end;
              if AllowUseMagic(45) then begin
                Result := 45; //灭天火
                Exit;
              end;
              if AllowUseMagic(47) then begin
                Result := 47; //火龙焰
                Exit;
              end;
              if ((m_TargetCret.m_btRaceServer = RC_PLAYOBJECT) or (m_TargetCret.m_btRaceServer = RC_HEROOBJECT) or (m_TargetCret.m_btRaceServer = RC_PLAYMOSTER)) then begin
                if UseFireCross then begin
                  Result := 22; //火墙
                  Exit;
                end;
              end else begin
                if nRangeTargetCountByDir > 1 then begin
                  if UseFireCross then begin
                    Result := 22; //火墙
                    Exit;
                  end;
                end;
              end;
            end;
        end;

        if (m_TargetCret <> nil) and (not m_TargetCret.m_boDeath) and AllowUseMagic(11) then begin
          Result := 11; //雷电术
          Exit;
        end;
        if (m_TargetCret <> nil) and (not m_TargetCret.m_boDeath) and AllowUseMagic(5) then begin
          Result := 5; //大火球
          Exit;
        end;
        if (m_TargetCret <> nil) and (not m_TargetCret.m_boDeath) and AllowUseMagic(1) then begin
          Result := 1; //火球术
          Exit;
        end;
        if QuickLighting then begin
          Result := 10; //疾光电影
          Exit;
        end;
        if AllowUseMagic(37) then begin
          Result := 37; //群体雷电术
          Exit;
        end;
        if AllowUseMagic(23) then begin
          Result := 23; //爆裂火焰
          Exit;
        end;
        if AllowUseMagic(33) then begin
          Result := 33; //冰咆哮
          Exit;
        end;
        if AllowUseMagic(45) then begin
          Result := 45; //灭天火
          Exit;
        end;
        if AllowUseMagic(47) then begin
          Result := 47; //火龙焰
          Exit;
        end;
        if UseFireCross then begin
          Result := 22; //火墙
          Exit;
        end;
      end;
    2: begin //道士
        nCode := 0;
        if m_WAbil.HP <= Round(m_WAbil.MaxHP * 0.8) then begin
          if GetTickCount - m_SkillUseTick[29] > 5000 then begin
            if m_nIncSelfHealthCount <= 3 then begin
              if AllowUseMagic(2) and AllowUseMagic(29) then begin
                nCode := 9;
                if GetRangeTargetCount(m_nCurrX, m_nCurrY, 3) > 1 then begin//群体治疗术
                  m_boSelSelf := True;
                  Inc(m_nIncSelfHealthCount);
                  Result := 29;
                  m_SkillUseTick[29]:= GetTickCount();
                end else begin
                  m_boSelSelf := True;
                  Inc(m_nIncSelfHealthCount);
                  Result := 2;
                  m_SkillUseTick[29]:= GetTickCount();
                end;
                Exit;
              end;
              nCode := 10;
              if AllowUseMagic(29) then begin //使用群体治愈术
                m_boSelSelf := True;
                Inc(m_nIncSelfHealthCount);
                Result := 29;
                m_SkillUseTick[29]:= GetTickCount();
                Exit;
              end;
              nCode := 11;
              if AllowUseMagic(2) then begin //使用治愈术
                m_boSelSelf := True;
                Inc(m_nIncSelfHealthCount);
                Result := 2;
                m_SkillUseTick[29]:= GetTickCount();
                Exit;
              end;
            end else begin
              m_SkillUseTick[29] := GetTickCount;
              m_nIncSelfHealthCount := 0;
            end;
          end;
        end;
        nCode := 12;
        if m_Master <> nil then
          boVisibleActors := FindVisibleActors(m_Master);
        nCode := 13;
        if (m_Master <> nil) and boVisibleActors then begin
          if m_Master.m_WAbil.HP <= Round(m_Master.m_WAbil.MaxHP * 0.8) then begin //使用治愈术
            if GetTickCount - m_SkillUseTick[2] > 5000 then begin
              if m_nIncMasterHealthCount <= 3 then begin
                if AllowUseMagic(2) and AllowUseMagic(29) then begin
                  nCode := 14;
                  if GetRangeTargetCount(m_Master.m_nCurrX, m_Master.m_nCurrY, 3) > 1 then begin
                    m_boSelSelf := False;
                    Inc(m_nIncMasterHealthCount);
                    Result := 29;
                    m_SkillUseTick[2]:= GetTickCount();
                  end else begin
                    m_boSelSelf := False;
                    Inc(m_nIncMasterHealthCount);
                    Result := 2;
                    m_SkillUseTick[2]:= GetTickCount();
                  end;
                  Exit;
                end;
                nCode := 15;
                if AllowUseMagic(29) then begin {使用群体治愈术}
                  m_boSelSelf := False;
                  Inc(m_nIncMasterHealthCount);
                  Result := 29;
                  m_SkillUseTick[2]:= GetTickCount();
                  Exit;
                end;
                nCode := 16;
                if AllowUseMagic(2) then begin {使用治愈术}
                  m_boSelSelf := False;
                  Inc(m_nIncMasterHealthCount);
                  Result := 2;
                  m_SkillUseTick[2]:= GetTickCount();
                  Exit;
                end;
              end else begin
                m_nIncMasterHealthCount := 0;
                m_SkillUseTick[2] := GetTickCount;
              end;
            end;
          end;
        end;

        nCode := 1;
        //IF m_TargetCret <> nil then
        nRangeTargetCount := GetRangeTargetCount(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 3);
        nCode := 2;
        nSelfRangeTargetCount := GetNearTargetCount;
        nCode := 3;

        if (FindMagic(30) = nil) and AllowUseMagic(72) and ((GetMoonSlaveCount <= 0) or GetMoonSlaveDeath) then begin
          m_boSelSelf := True;
          Result := 72; //召唤月灵
          Exit;
        end;
        if (FindMagic(72) = nil) and AllowUseMagic(30) and CheckUserItem(5, 5) and ((GetSlaveCount <= 0) or GetSlaveDeath) and (GetTickCount - m_SkillUseTick[30] > 5000) then begin
          m_boSelSelf := True;
          Result := 30; //召唤神兽
          Exit;
        end;
        nCode := 7;

        if AllowUseMagic(15) and (m_wStatusTimeArr[STATE_DEFENCEUP] = 0) and CheckUserItem(5, 1) then begin // {使用神圣战甲术}
          m_boSelSelf := True;
          Result := 15;
          Exit;
        end;
        nCode := 18;
        if AllowUseMagic(14) and (m_wStatusTimeArr[STATE_MAGDEFENCEUP] = 0) and CheckUserItem(5, 1) then begin // {幽灵盾}
          m_boSelSelf := True;
          Result := 14;
          Exit;
        end;

        nCode := 19;
        if (m_Master <> nil) and boVisibleActors then begin
          if AllowUseMagic(15) and (m_Master.m_wStatusTimeArr[STATE_DEFENCEUP] = 0) and CheckUserItem(5, 1) then begin // {使用神圣战甲术}
            m_boSelSelf := False;
            Result := 15;
            Exit;
          end;
          if AllowUseMagic(14) and (m_Master.m_wStatusTimeArr[STATE_MAGDEFENCEUP] = 0) and CheckUserItem(5, 1) then begin // {幽灵盾}
            m_boSelSelf := False;
            Result := 14;
            Exit;
          end;
        end;

        if (m_dwStatusArrTimeOutTick[2] <= 0) and AllowUseMagic(50) and (GetTickCount - m_SkillUseTick[50] >= g_Config.nAbilityUpTick * 1000) then begin {无极真气}
          m_boSelSelf := True;
          m_SkillUseTick[50] := GetTickCount;
          Result := 50;
          Exit;
        end;

        nCode := 8;
        if (nSelfRangeTargetCount >= 1) and IsUseSkill48 then begin
          Result := 48; //气功波
          Exit;
        end;

        if (GetTickCount - m_SkillUseTick[34] > 5000) and AllowUseMagic(34) and ((m_wStatusTimeArr[POISON_DECHEALTH] > 0) or (m_wStatusTimeArr[POISON_DAMAGEARMOR] > 0)) then begin // {使用解毒术}
          m_boSelSelf := True;
          Result := 34; // 使用解毒术
          Exit;
        end;

        if (GetTickCount - m_SkillUseTick[34] > 5000) and (m_Master <> nil) and boVisibleActors then begin
          if AllowUseMagic(34) and ((m_Master.m_wStatusTimeArr[POISON_DECHEALTH] > 0) or (m_Master.m_wStatusTimeArr[POISON_DAMAGEARMOR] > 0)) then begin // {使用解毒术}
            m_boSelSelf := False;
            Result := 34; //使用解毒术
            Exit;
          end;
        end;

        nCode := 20;
        if (m_TargetCret <> nil) and (not m_TargetCret.m_boDeath) and
          (m_TargetCret.m_btRaceServer in [RC_PLAYOBJECT, RC_HEROOBJECT, RC_PLAYMOSTER])
          and AllowUseMagic(52) and (m_TargetCret.m_wStatusArrValue[m_TargetCret.m_btJob + 6] = 0)
          and CheckUserItem(3, 3) then begin {诅咒术}
          Result := 52;
          Exit;
        end;
        nCode := 21;

        if IsUseSkill38 then begin
          Result := 38;
          Exit;
        end;

        if AllowUseMagic(6) and CheckUserItem(1, 1) and (m_TargetCret <> nil) and
          (not m_TargetCret.m_boDeath) and (m_TargetCret.m_wStatusTimeArr[POISON_DECHEALTH] = 0) and
          (not (m_TargetCret.m_btRaceServer in [55,79,109,110,111,128,143, 145, 147, 151, 153])) then begin
          m_nSelItemType := 1;
          Result := 6;//施毒术
          Exit;
        end;
        if AllowUseMagic(6) and CheckUserItem(2, 1) and (m_TargetCret <> nil) and
          (not m_TargetCret.m_boDeath) and (m_TargetCret.m_wStatusTimeArr[POISON_DAMAGEARMOR] = 0) and
          (not (m_TargetCret.m_btRaceServer in [55,79,109,110,111,128,143, 145, 147, 151, 153])) then begin
          m_nSelItemType := 2;
          Result := 6;//施毒术
          Exit;
        end;

        if (GetTickCount - m_SkillUseTick[59] > 5000) and (m_TargetCret <> nil) and
          (not m_TargetCret.m_boDeath) then begin
          if AllowUseMagic(59) and CheckUserItem(5, 1) then begin //噬血术
            m_boSelSelf := False;
            Result := 59;
            Exit;
          end;
        end;
        if (m_TargetCret <> nil) and (not m_TargetCret.m_boDeath) then begin
          if AllowUseMagic(13) and CheckUserItem(5, 1) then begin //灵魂火符
            m_boSelSelf := False;
            Result := 13;
            Exit;
          end;
        end;
      end;
  end;
end;    *)

function TAIPlayObject.CanAttack(nCurrX, nCurrY: Integer; BaseObject: TBaseObject; nRange: Integer; var btDir: Byte): Boolean;
var
  I: Integer;
  nX, nY: Integer;
begin
  Result := False;
  btDir := GetNextDirection(nCurrX, nCurrY, BaseObject.m_nCurrX, BaseObject.m_nCurrY);
  for I := 1 to nRange do begin
    if not m_PEnvir.GetNextPosition(nCurrX, nCurrY, btDir, I, nX, nY) then Break;
    if (BaseObject.m_nCurrX = nX) and (BaseObject.m_nCurrY = nY) then begin
      Result := True;
      Break;
    end;
  end;
end;

function TAIPlayObject.CanAttack(BaseObject: TBaseObject; nRange: Integer; var btDir: Byte): Boolean;
var
  I: Integer;
  nX, nY: Integer;
begin
  Result := False;
  btDir := GetNextDirection(m_nCurrX, m_nCurrY, BaseObject.m_nCurrX, BaseObject.m_nCurrY);
  for I := 1 to nRange do begin
    if not m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, btDir, I, nX, nY) then Break;
    if (BaseObject.m_nCurrX = nX) and (BaseObject.m_nCurrY = nY) then begin
      Result := True;
      Break;
    end;
  end;
end;
//1 为护身符 2 为毒药
function TAIPlayObject.IsUseAttackMagic(): Boolean; //检测是否可以使用攻击魔法
var
  UserMagic: pTUserMagic;
  I: Integer;
begin
  Result := False;
  case m_btJob of
    0: Result := True;
    1: begin
        for I := 0 to m_MagicList.Count - 1 do begin
          UserMagic := m_MagicList.Items[I];
          case UserMagic.wMagIdx of
            SKILL_FIREBALL {1},
              SKILL_FIREBALL2,
              SKILL_FIRE,
              SKILL_SHOOTLIGHTEN,
              SKILL_LIGHTENING,
              SKILL_EARTHFIRE,
              SKILL_FIREBOOM,
              SKILL_LIGHTFLOWER,
              SKILL_SNOWWIND,
              SKILL_GROUPLIGHTENING,
              SKILL_47,
              SKILL_58: begin
                if GetSpellPoint(UserMagic) <= m_WAbil.MP then begin
                  Result := True;
                  Break;
                end;
              end;
          end;
        end;
      end;
    2: begin
        for I := 0 to m_MagicList.Count - 1 do begin
          UserMagic := m_MagicList.Items[I];
          if UserMagic.MagicInfo.btJob in [2, 99] then begin
            case UserMagic.wMagIdx of
              SKILL_AMYOUNSUL {6 施毒术}, SKILL_GROUPAMYOUNSUL {38 群体施毒术}: begin //需要毒药
                  Result := CheckUserItem(1, 2) or CheckUserItem(2, 2);
                  if Result then begin
                    Result := AllowUseMagic(SKILL_AMYOUNSUL) or AllowUseMagic(SKILL_GROUPAMYOUNSUL);
                  end;
                  if Result then Break;
                end;
              SKILL_FIRECHARM: begin //需要符
                  Result := CheckUserItem(5, 1);
                  if Result then begin
                    Result := AllowUseMagic(SKILL_FIRECHARM);
                  end;
                  if Result then Break;
                end;
              SKILL_59: begin //需要符
                  Result := CheckUserItem(5, 5);
                  if Result then begin
                    Result := AllowUseMagic(SKILL_59);
                  end;
                  if Result then Break;
                end;
            end;
          end;
        end;
      end;
  end;
end;

function TAIPlayObject.UseSpell(UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  TargeTBaseObject: TBaseObject): Boolean;
var
  nSpellPoint: Integer;
  n14: Integer;
  BaseObject: TBaseObject;
  boIsWarrSkill: Boolean;
begin
  Result := False;
  if not m_boCanSpell then Exit;

  if m_boDeath or (m_wStatusTimeArr[POISON_LOCKSPELL{7}] <> 0) or (m_wStatusArrValue[23] <> 0) then Exit;//防麻
  if UserMagic.wMagIdx <> SKILL_102 then
     if (m_wStatusTimeArr[POISON_STONE] <> 0) and not g_ClientConf.boParalyCanSpell then Exit;//防麻
  if m_PEnvir <> nil then begin
    if m_PEnvir.m_boNOSKILL then Exit;
    if not m_PEnvir.AllowMagics(UserMagic.MagicInfo.sMagicName) then Exit;
  end;
  boIsWarrSkill := MagicManager.IsWarrSkill(UserMagic.wMagIdx); //是否是战士技能

  Dec(m_nSpellTick, 450);
  m_nSpellTick := _MAX(0, m_nSpellTick);

  case UserMagic.wMagIdx of //
    SKILL_ERGUM{12}: begin //刺杀剑法
        if m_MagicErgumSkill <> nil then begin
          if not m_boUseThrusting then begin
            ThrustingOnOff(True);
          end else begin
            ThrustingOnOff(False);
          end;
        end;
        Result := True;
      end;
    SKILL_89{89}: begin //四级刺杀
        if m_Magic89Skill <> nil then begin
          if not m_boUseThrusting then begin
            ThrustingOnOff(True);
          end else begin
            ThrustingOnOff(False);
          end;
        end;
        Result := True;
      end;
    SKILL_BANWOL{25}: begin //半月弯刀
        if m_MagicBanwolSkill <> nil then begin
          if not m_boUseHalfMoon then begin
            HalfMoonOnOff(True, 0);
          end else begin
            HalfMoonOnOff(False, 0);
          end;
        end;
        Result := True;
      end;
    SKILL_90{90}: begin//圆月弯刀(四级半月弯刀)
      if m_Magic90Skill <> nil then begin
        if not m_boUseHalfMoon then begin
          HalfMoonOnOff(True, 1);
        end else begin
          HalfMoonOnOff(False, 1);
        end;
      end;
      Result := True;
    end;
    SKILL_FIRESWORD {26}: begin //烈火剑法
        if m_MagicFireSwordSkill <> nil then begin
          if AllowFireHitSkill then begin
            {nSpellPoint := GetSpellPoint(UserMagic);
            if m_WAbil.MP >= nSpellPoint then begin
              if nSpellPoint > 0 then begin
                DamageSpell(nSpellPoint);
                HealthSpellChanged();
              end;
            end; }
          end;
          Result := True;
        end;
      end;
    SKILL_74 :begin////逐日剑法 20080511
        if m_Magic74Skill <> nil then begin
          if AllowDailySkill then begin
            {nSpellPoint := GetSpellPoint(m_Magic74Skill);
            if m_WAbil.MP >= nSpellPoint then begin
              if nSpellPoint > 0 then begin
                DamageSpell(nSpellPoint);
              end;
            end;}
          end;
          Result := True;
        end;
      end;
    SKILL_MOOTEBO {27}: begin //野蛮冲撞
        Result := True;
        if (GetTickCount - m_dwDoMotaeboTick) > 3000 then begin
          m_dwDoMotaeboTick := GetTickCount();
          if GetAttackDir(TargeTBaseObject,m_btDirection) then begin//修改野蛮冲撞的方向
            {nSpellPoint := GetSpellPoint(UserMagic);
            if m_WAbil.MP >= nSpellPoint then begin
              if nSpellPoint > 0 then begin
                DamageSpell(nSpellPoint);
                HealthSpellChanged();
              end;
              DoMotaebo(m_btDirection, UserMagic.btLevel);
            end;}
            DoMotaebo(m_btDirection, UserMagic.btLevel);
          end;
        end;
      end;
    SKILL_40: begin //双龙斩 抱月刀法
        if m_MagicCrsSkill <> nil then begin
          if not m_boCrsHitkill then begin
            SkillCrsOnOff(True);
          end else begin
            SkillCrsOnOff(False);
          end;
        end;
        Result := True;
      end;
    SKILL_42: begin //开天斩
        if m_Magic42Skill <> nil then begin
          if Skill42OnOff then begin
            {nSpellPoint := GetSpellPoint(UserMagic);
            if m_WAbil.MP >= nSpellPoint then begin
              if nSpellPoint > 0 then begin
                DamageSpell(nSpellPoint);
                HealthSpellChanged();
              end;
            end;}
          end;
        end;
        Result := True;
      end;
    SKILL_43: begin //龙影剑法
        if m_Magic43Skill <> nil then begin
          if Skill43OnOff then begin//20080619
            {nSpellPoint := GetSpellPoint(UserMagic);
            if m_WAbil.MP >= nSpellPoint then begin
              if nSpellPoint > 0 then begin
                DamageSpell(nSpellPoint);
                HealthSpellChanged();
              end;
            end;}
          end;
        end;
        Result := True;
     end;
  else begin
      n14 := GetNextDirection(m_nCurrX, m_nCurrY, nTargetX, nTargetY);
      m_btDirection := n14;
      BaseObject := nil;
      //检查目标角色，与目标座标误差范围，如果在误差范围内则修正目标座标
      if UserMagic.wMagIdx in [60..65] then begin //如果是合击锁定目标
        if CretInNearXY(TargeTBaseObject, nTargetX, nTargetY, 6) then begin
          BaseObject := TargeTBaseObject;
          nTargetX := BaseObject.m_nCurrX;
          nTargetY := BaseObject.m_nCurrY;
        end;
      end else begin
        case UserMagic.wMagIdx of
          SKILL_HEALLING {2}, SKILL_HANGMAJINBUB {14}, SKILL_DEJIWONHO {15},
          SKILL_BIGHEALLING {29}, SKILL_SINSU, {30} SKILL_UNAMYOUNSUL,
          SKILL_46: begin
              if m_boSelSelf then begin
                BaseObject := Self;
                nTargetX := m_nCurrX;
                nTargetY := m_nCurrY;
              end else begin
                if m_Master <> nil then begin
                  BaseObject := m_Master;
                  nTargetX := m_Master.m_nCurrX;
                  nTargetY := m_Master.m_nCurrY;
                end else begin
                  BaseObject := Self;
                  nTargetX := m_nCurrX;
                  nTargetY := m_nCurrY;
                end;
              end;
            end;
        else begin
            if CretInNearXY(TargeTBaseObject, nTargetX, nTargetY) then begin
              BaseObject := TargeTBaseObject;
              nTargetX := BaseObject.m_nCurrX;
              nTargetY := BaseObject.m_nCurrY;
            end;
          end;
        end;
      end;

      if not AutoSpell(UserMagic, nTargetX, nTargetY, BaseObject) then begin
        SendRefMsg(RM_MAGICFIREFAIL, 0, 0, 0, 0, '');
      end;
      Result := True;
    end;
  end;
end;

function TAIPlayObject.AutoSpell(UserMagic: pTUserMagic; nTargetX,
  nTargetY: Integer; BaseObject: TBaseObject): Boolean;
var
  nSpellPoint: Integer;
begin
  Result := False;
  try
    if BaseObject <> nil then
      if (BaseObject.m_boGhost) or (BaseObject.m_boDeath) or (BaseObject.m_WAbil.HP <=0) then Exit;
    if not MagicManager.IsWarrSkill(UserMagic.wMagIdx) then begin
      Result := MagicManager.DoSpell(Self, UserMagic, nTargetX, nTargetY, BaseObject);
      m_dwHitTick := GetTickCount();
    end;
  except
    on E: Exception do begin             
      MainOutMessage(Format('{%s} TAIPlayObject.AutoSpell MagID:%d X:%d Y:%d', [g_sExceptionVer, UserMagic.wMagIdx, nTargetX, nTargetY]));
    end;
  end;
end;

(*
function TAIPlayObject.WarrAttackTarget(wMagIdx, wHitMode: Word): Boolean; {物理攻击}
var
  bt06: Byte;
  nRange: Integer;
  UserMagic: pTUserMagic;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    nRange := 1;
    if (wMagIdx = 43) or (wMagIdx = SKILL_74) then nRange := 4;
    if (wMagIdx = 12) then nRange := 2;
    if (wMagIdx in [60, 61, 62]) then nRange := 12;

    if CanAttack(m_TargetCret, nRange, bt06) then begin
      m_dwTargetFocusTick := GetTickCount();
      if m_btRaceServer = RC_HEROOBJECT then begin //合击
        case wMagIdx of
          60: begin
              m_Master.m_btDirection := GetNextDirection(m_Master.m_nCurrX, m_Master.m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
              m_Master.AttackDir(m_TargetCret, wHitMode, m_Master.m_btDirection);
            end;
          61: begin
              if m_btJob = 0 then begin
                UserMagic := THeroObject(Self).FindGroupMagic;
                if UserMagic = nil then Exit;
                MagicManager.DoSpell(m_Master, UserMagic, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, m_TargetCret);
              end;
            end;
          62: begin
              if m_btJob = 0 then begin
                UserMagic := THeroObject(Self).FindGroupMagic;
                if UserMagic = nil then Exit;
                MagicManager.DoSpell(m_Master, UserMagic, m_nCurrX, m_nCurrY, m_TargetCret);
              end;
            end;
        end;
      end; 
      AttackDir(m_TargetCret, wHitMode, bt06);
      BreakHolySeizeMode();
      Result := True;
    end else begin
      if m_TargetCret.m_PEnvir = m_PEnvir then begin
        SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      end else begin
        DelTargetCreat();
      end;
    end;
  end;
end;

function TAIPlayObject.WarrorAttackTarget(wMagIdx: Word): Boolean; {战士攻击}
var
  UserMagic: pTUserMagic;
begin
  Result := False;
  m_wHitMode := 0;
  if wMagIdx > 0 then begin
    UserMagic := FindMagic(wMagIdx);
    if UserMagic <> nil then begin
      case wMagIdx of
        27, 39, 41: begin
            Result := UseSpell(UserMagic, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, m_TargetCret); //战士魔法
            Exit;
          end;
        61..65: begin //合击
            if m_btJob <> 0 then begin
              Result := UseSpell(UserMagic, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, m_TargetCret);
              Exit;
            end;
          end;
      end;
      case wMagIdx of
         7: m_wHitMode := 3; //攻杀
        12: m_wHitMode := 4; //使用刺杀
        SKILL_89: m_wHitMode := 15;//四级刺杀
        25: m_wHitMode := 5; //使用半月
        SKILL_90: m_wHitMode := 16;//圆月弯刀(四级半月弯刀)
        26: if UseSpell(UserMagic, m_nCurrX, m_nCurrY, m_TargetCret) then m_wHitMode := 7; //使用烈火
        40: m_wHitMode := 8; //抱月刀法
        43: if UseSpell(UserMagic, m_nCurrX, m_nCurrY, m_TargetCret) then m_wHitMode := 9; //开天斩  20100910 修改
        42: if UseSpell(UserMagic, m_nCurrX, m_nCurrY, m_TargetCret) then m_wHitMode := 12;//龙影剑法 20100910 修改
        SKILL_74: if UseSpell(UserMagic, m_nCurrX, m_nCurrY, m_TargetCret) then m_wHitMode := 13;//逐日剑法 20100910 修改
        SKILL_96: if UseSpell(UserMagic, m_nCurrX, m_nCurrY, m_TargetCret) then m_wHitMode := 17;//血魄一击(战)
      end;
    end;
  end;
  Result := WarrAttackTarget(wMagIdx, m_wHitMode);
end;

function TAIPlayObject.WizardAttackTarget(wMagIdx: Word): Boolean; {法师攻击}
var
  UserMagic: pTUserMagic;
begin
  Result := False;
  m_wHitMode := 0;
  if wMagIdx > 0 then begin
    UserMagic := FindMagic(wMagIdx);
    if UserMagic <> nil then begin
      Result := UseSpell(UserMagic, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, m_TargetCret); //使用魔法
      m_dwHitTick := GetTickCount();
      Exit;
    end;
  end else Result := WarrAttackTarget(wMagIdx, m_wHitMode);
end;

function TAIPlayObject.TaoistAttackTarget(wMagIdx: Word): Boolean; {道士攻击}
var
  UserMagic: pTUserMagic;
  nIndex, nCount: Integer;
begin
  Result := False;
  m_wHitMode := 0;
  if wMagIdx > 0 then begin
    case wMagIdx of
      SKILL_AMYOUNSUL{6},SKILL_93, SKILL_GROUPAMYOUNSUL{38}: begin //换毒
          if (m_TargetCret.m_wStatusTimeArr[POISON_DECHEALTH] = 0) and (GetUserItemList(1,1)>= 0) then begin//绿毒
            n_AmuletIndx:= 1;//绿毒标识
          end else
          if (m_TargetCret.m_wStatusTimeArr[POISON_DAMAGEARMOR] = 0) and (GetUserItemList(2,1)>= 0)  then  begin//红毒
            n_AmuletIndx:= 2;//红毒标识
          end else n_AmuletIndx:= 0;
        end;
    end;
    UserMagic := FindMagic(wMagIdx);
    if UserMagic <> nil then begin
      Result := UseSpell(UserMagic, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, m_TargetCret); //使用魔法
      Exit;
    end;
  end else Result := WarrAttackTarget(wMagIdx, m_wHitMode);
end;          *)
(*
function TAIPlayObject.StartAttack(wMagIdx: Word): Boolean;
resourcestring
  sExceptionMsg = '{%s} TAIPlayObject::StartAttack Race=%d MagIdx=%d';
begin
  Result := False;
  try
    m_dwTargetFocusTick := GetTickCount();
    if (m_TargetCret <> nil) then begin
      if InSafeZone then begin//进入安全区内就不打PK目标
        if (m_TargetCret.m_btRaceServer = RC_PLAYOBJECT) or (m_TargetCret.m_btRaceServer = RC_HEROOBJECT) then begin
          m_TargetCret:= nil;
          {$IF M2Version = 1}
          HeroBatterStop;//英雄连击停止
          {$IFEND}
          Exit;
        end;
      end;
      if (m_TargetCret = self) or (m_TargetCret = m_MyHero) or (m_TargetCret.m_boDeath)
        or (m_TargetCret.m_boGhost) then begin
        m_TargetCret:= nil;
        Exit;
      end;
    end;
    {$IF M2Version = 1}
    if HeroBatterAttackTarget then begin
      m_dwHitTick := GetTickCount();
      Result := True;
      Exit;
    end;
    {$IFEND}
    case m_btJob of
      0: begin
          Result := WarrorAttackTarget(wMagIdx);
        end;
      1: begin
          Result := WizardAttackTarget(wMagIdx);
        end;
      2: begin
          Result := TaoistAttackTarget(wMagIdx);
        end;
    end;
    if Result then Inc(m_RunPos.nAttackCount);
  except
    MainOutMessage(Format(sExceptionMsg, [g_sExceptionVer, m_btRaceServer, wMagIdx]));
  end;
end;     *)

function TAIPlayObject.DoThink(wMagicID: Word): Integer;
  function CheckTargetXYCount(nX, nY, nRange: Integer): Integer;
  var
    BaseObject: TBaseObject;
    I, nC, n10: Integer;
  begin
    Result := 0;
    try
      n10 := nRange;
      if m_VisibleActors.Count > 0 then begin
        for I := 0 to m_VisibleActors.Count - 1 do begin
          BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
          if BaseObject <> nil then begin
            if not BaseObject.m_boDeath then begin
              if IsProperTarget(BaseObject) and (not BaseObject.m_boHideMode or m_boCoolEye) then begin
                nC := abs(nX - BaseObject.m_nCurrX) + abs(nY - BaseObject.m_nCurrY);
                if nC <= n10 then begin
                  Inc(Result);
                end;
              end;
            end;
          end;
        end;
      end;
    except
    end;
  end;
  function TargetNeedRunPos(): Boolean;
  begin
    Result := (m_TargetCret.m_btRaceServer = RC_PLAYOBJECT) or (m_TargetCret.m_btRaceServer = 108)
      or (m_TargetCret.m_btRaceServer = RC_HEROOBJECT) or (m_TargetCret.m_btRaceServer = RC_PLAYMOSTER);
  end;
  function CanRunPos(nAttackCount: Integer): Boolean;
  begin
    Result := (m_RunPos.nAttackCount >= nAttackCount);
  end;
  function MotaeboPos(): Boolean; //获取野蛮冲撞
  var
    nTargetX, nTargetY: Integer;
    btNewDir: Byte;
  begin
    Result := False;
    if (wMagicID = 27) and (m_Master <> nil) and (m_TargetCret <> nil) and AllowUseMagic(27) and (m_TargetCret.m_Abil.Level < m_Abil.Level) and (GetTickCount - m_SkillUseTick[27] > 1000 * 10) then begin
      btNewDir := GetNextDirection(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, m_Master.m_nCurrX, m_Master.m_nCurrY);
      if m_PEnvir.GetNextPosition(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, GetBackDir(btNewDir), 1, nTargetX, nTargetY) then begin
        Result := m_PEnvir.CanWalk(nTargetX, nTargetY, True);
      end;
    end;
  end;
  function MagPushArround(MagicID: Integer): Boolean;
  var
    I: Integer;
    ActorObject: TBaseObject;
    btNewDir: Byte;
    nTargetX, nTargetY: Integer;
  begin
    Result := False;
    if (m_TargetCret <> nil) and (m_Abil.Level > m_TargetCret.m_Abil.Level) and
      (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 1) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 1) then begin
      btNewDir := GetNextDirection(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, m_nCurrX, m_nCurrY);
      if m_PEnvir.GetNextPosition(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, GetBackDir(btNewDir), 1, nTargetX, nTargetY) then begin
        Result := m_PEnvir.CanWalk(nTargetX, nTargetY, True);
      end;
      if Result then Exit;
    end;
    if wMagicID = MagicID then begin
      for I := 0 to m_VisibleActors.Count - 1 do begin
        ActorObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
        if (abs(m_nCurrX - ActorObject.m_nCurrX) <= 1) and (abs(m_nCurrY - ActorObject.m_nCurrY) <= 1) then begin
          if (not ActorObject.m_boDeath) and (ActorObject <> Self) and IsProperTarget(ActorObject) then begin
            if (m_Abil.Level > ActorObject.m_Abil.Level) and (not ActorObject.m_boStickMode) then begin
              btNewDir := GetNextDirection(ActorObject.m_nCurrX, ActorObject.m_nCurrY, m_nCurrX, m_nCurrY);
              if m_PEnvir.GetNextPosition(ActorObject.m_nCurrX, ActorObject.m_nCurrY, GetBackDir(btNewDir), 1, nTargetX, nTargetY) then begin
                if m_PEnvir.CanWalk(nTargetX, nTargetY, True) then begin
                  Result := True;
                  Break;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
var
  btDir: Byte;
  nRange: Integer;
begin
  Result := -1;
  case m_btJob of
    0: begin
         //1=野蛮冲撞 2=无法攻击到目标需要移动 3=走位
        if MotaeboPos then begin
          Result := 1;
        end else begin
          nRange := 1;
          if ((wMagicID = 43) and (m_n42kill= 2)) or (wMagicID = SKILL_74) then nRange := 4;
          if (wMagicID = 12) {$IF M2Version = 1}or m_boUseBatter{$IFEND} then nRange := 2;//连击技能
          if (wMagicID in [60]) then nRange := 6;
          Result := 2;
          if (wMagicID in [61, 62]) or CanAttack(m_TargetCret, nRange, btDir) then begin
            Result := 0;
          end;
          if ((abs(m_TargetCret.m_nCurrX - m_nCurrX) > 2) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 2)) then begin
            if (Result = 0) and (not (wMagicID in [60, 61, 62])) then begin
              if TargetNeedRunPos then begin
                if CanRunPos(5) then Result := 5;
              end else begin
                if CanRunPos(20) then Result := 5;
              end;
            end;
            if ((abs(m_TargetCret.m_nCurrX - m_nCurrX) > 6) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 6)) then begin
              Result := 2;
            end;
          end;
        end;
      end;
    1: begin
        if (wMagicID = 8) and MagPushArround(wMagicID) then Exit;
        //1=躲避 2=追击 3=魔法直线攻击不到目标 4=无法攻击到目标需要移动 5=走位
        if IsUseAttackMagic then begin
          if {GetNearTargetCount}CheckTargetXYCount(m_nCurrX, m_nCurrY, 2) > 0 then begin
            Result := 1;
          end else
            if ((abs(m_TargetCret.m_nCurrX - m_nCurrX) > 6) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 6)) then begin
            Result := 2;
          end else
            if (wMagicID in [SKILL_FIREBALL, SKILL_FIREBALL2]) and (not CanAttack(m_TargetCret, 10, btDir)) then begin
            Result := 3;
          end else
            if TargetNeedRunPos and CanRunPos(5) and ({GetNearTargetCount}CheckTargetXYCount(m_nCurrX, m_nCurrY, 2) > 0) then begin
            Result := 5;
          end;
        end else begin
          if (not GetAttackDir(m_TargetCret, 1, btDir)) then begin
            Result := 4;
          end;
        end;
      end;
    2: begin
        if (wMagicID = 48) and MagPushArround(wMagicID) then Exit;
        //1=躲避 2=追击 3=魔法直线攻击不到目标 4=无法攻击到目标需要移动 5=走位
        if IsUseAttackMagic then begin
          if {GetNearTargetCount}CheckTargetXYCount(m_nCurrX, m_nCurrY, 2) > 0 then begin
            Result := 1;
          end else
            if ((abs(m_TargetCret.m_nCurrX - m_nCurrX) > 6) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 6)) then begin
            Result := 2;
          end else
            if (wMagicID = SKILL_FIRECHARM) and (not CanAttack(m_TargetCret, 10, btDir)) then begin
            Result := 3;
          end else
            if TargetNeedRunPos and CanRunPos(5) and ({GetNearTargetCount}CheckTargetXYCount(m_nCurrX, m_nCurrY, 2) > 0) then begin
            Result := 5;
          end;
        end else begin
          if (not GetAttackDir(m_TargetCret, 1, btDir)) then begin
            Result := 4;
          end;
        end;
      end;
  end;
end;

function TAIPlayObject.ActThink(wMagicID: Word): Boolean;
  function FindGoodPathA(WalkStep: TWalkStep; nRange, nType: Integer): TMapWalkXY;
  var
    I: Integer;
    n10: Integer;
    nMastrRange: Integer;
    nMonCount: Integer;
    MapWalkXY, MapWalkXYA: pTMapWalkXY;
  begin
    n10 := High(Integer);
    MapWalkXY := nil;
    FillChar(Result, SizeOf(TMapWalkXY), 0);

    for I := DR_UP to DR_UPLEFT do begin
      if (WalkStep[I].nWalkStep > 0) and
        (abs(WalkStep[I].nX - m_TargetCret.m_nCurrX) >= nRange) and (abs(WalkStep[I].nY - m_TargetCret.m_nCurrY) >= nRange) then begin
        if (WalkStep[I].nMonCount < n10) then begin
          n10 := WalkStep[I].nMonCount;
          MapWalkXY := @WalkStep[I];
        end;
      end;
    end;

    if (MapWalkXY <> nil) and (m_Master <> nil) then begin
      nMonCount := MapWalkXY.nMonCount;
      nMastrRange := MapWalkXY.nMastrRange;
      n10 := High(Integer);
      MapWalkXYA := MapWalkXY;
      MapWalkXY := nil;
      for I := DR_UP to DR_UPLEFT do begin
        if (WalkStep[I].nWalkStep > 0) and (WalkStep[I].nMonCount <= nMonCount) and (abs(WalkStep[I].nX - m_TargetCret.m_nCurrX) >= nRange) and (abs(WalkStep[I].nY - m_TargetCret.m_nCurrY) >= nRange) then begin
          if (WalkStep[I].nMastrRange < n10) and (WalkStep[I].nMastrRange < nMastrRange) then begin
            n10 := WalkStep[I].nMastrRange;
            MapWalkXY := @WalkStep[I];
          end;
        end;
      end;
      if MapWalkXY = nil then MapWalkXY := MapWalkXYA;
    end;
    if MapWalkXY <> nil then Result := MapWalkXY^;
  end;
  function FindGoodPathB(WalkStep: TWalkStep; nType: Integer): TMapWalkXY;
  var
    I: Integer;
    n10: Integer;
    nMastrRange: Integer;
    nMonCount: Integer;
    MapWalkXY, MapWalkXYA: pTMapWalkXY;
  begin
    n10 := High(Integer);
    MapWalkXY := nil;
    FillChar(Result, SizeOf(TMapWalkXY), 0);

    for I := DR_UP to DR_UPLEFT do begin
      if (WalkStep[I].nWalkStep > 0) then begin
        if (WalkStep[I].nMonCount < n10) then begin
          n10 := WalkStep[I].nMonCount;
          MapWalkXY := @WalkStep[I];
        end;
      end;
    end;

    if (MapWalkXY <> nil) and (m_Master <> nil) then begin
      nMonCount := MapWalkXY.nMonCount;
      nMastrRange := MapWalkXY.nMastrRange;
      n10 := High(Integer);
      MapWalkXYA := MapWalkXY;
      MapWalkXY := nil;
      for I := DR_UP to DR_UPLEFT do begin
        if (WalkStep[I].nWalkStep > 0) and (WalkStep[I].nMonCount <= nMonCount) then begin
          if (WalkStep[I].nMastrRange < n10) and (WalkStep[I].nMastrRange < nMastrRange) then begin
            n10 := WalkStep[I].nMastrRange;
            MapWalkXY := @WalkStep[I];
          end;
        end;
      end;
      if MapWalkXY = nil then MapWalkXY := MapWalkXYA;
    end;
    if MapWalkXY <> nil then Result := MapWalkXY^;
  end;
  function FindMinRange(WalkStep: TWalkStep): TMapWalkXY;
  var
    I: Integer;
    n10: Integer;
    n1C: Integer;
    nMonCount: Integer;
    MapWalkXY, MapWalkXYA: pTMapWalkXY;
  begin
    n10 := High(Integer);
    n1C := 0;
    MapWalkXY := nil;
    FillChar(Result, SizeOf(TMapWalkXY), 0);

    for I := DR_UP to DR_UPLEFT do begin
      if (WalkStep[I].nWalkStep > 0) then begin
        n1C := abs(WalkStep[I].nX - m_TargetCret.m_nCurrX) + abs(WalkStep[I].nY - m_TargetCret.m_nCurrY);
        if (n1C < n10) then begin
          n10 := n1C;
          MapWalkXY := @WalkStep[I];
        end;
      end;
    end;

    if MapWalkXY <> nil then begin
      nMonCount := MapWalkXY.nMonCount;
      MapWalkXYA := MapWalkXY;
      MapWalkXY := nil;
      for I := DR_UP to DR_UPLEFT do begin
        if (WalkStep[I].nWalkStep > 0) and (WalkStep[I].nMonCount <= nMonCount) then begin
          n1C := abs(WalkStep[I].nX - m_TargetCret.m_nCurrX) + abs(WalkStep[I].nY - m_TargetCret.m_nCurrY);
          if (n1C <= n10) then begin
            n10 := n1C;
            MapWalkXY := @WalkStep[I];
          end;
        end;
      end;
      if MapWalkXY = nil then MapWalkXY := MapWalkXYA;
    end;

    if MapWalkXY <> nil then Result := MapWalkXY^;
  end;
  function CanWalkNextPosition(nX, nY, nRange: Integer; btDir: Byte; boFlag: Boolean): Boolean; //检测下一步在不在攻击位
  var
    nCurrX: Integer;
    nCurrY: Integer;
  begin
    Result := False;
    if m_PEnvir.GetNextPosition(nX, nY, btDir, 1, nCurrX, nCurrY) and
      CanMove(nX, nY, nCurrX, nCurrY, False) and
      (not boFlag) or CanAttack(nCurrX, nCurrY, m_TargetCret, nRange, btDir) then begin
      Result := True;
      Exit;
    end;

    if m_PEnvir.GetNextPosition(nX, nY, btDir, 2, nCurrX, nCurrY) and
      CanMove(nX, nY, nCurrX, nCurrY, False) and
      (not boFlag) or CanAttack(nCurrX, nCurrY, m_TargetCret, nRange, btDir) then begin
      Result := True;
      Exit;
    end;
  end;
  function FindPosOfSelf(WalkStep: pTWalkStep; nRange: Integer; boFlag: Boolean): Boolean;
  var
    I: Integer;
    btDir: Byte;

    nCurrX: Integer;
    nCurrY: Integer;
  begin
    Result := False;

    FillChar(WalkStep^, SizeOf(TMapWalkXY) * 8, 0);
    for I := DR_UP to DR_UPLEFT do begin
      if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, I, nRange, nCurrX, nCurrY) and CanMove(nCurrX, nCurrY, False) then begin
        if (not boFlag) or CanAttack(nCurrX, nCurrY, m_TargetCret, nRange, btDir) then begin
          WalkStep[I].nWalkStep := nRange;
          WalkStep[I].nX := nCurrX;
          WalkStep[I].nY := nCurrY;
          WalkStep[I].nMonRange := abs(nCurrX - m_TargetCret.m_nCurrX) + abs(nCurrY - m_TargetCret.m_nCurrY);
          WalkStep[I].nMonCount := GetNearTargetCount(nCurrX, nCurrY);
          WalkStep[I].nMastrRange := GetMasterRange(nCurrX, nCurrY);
          Result := True;
        end;
      end;
    end;
  end;
  function _FindPosOfSelf(WalkStep: pTWalkStep; nRange: Integer; boFlag: Boolean): Boolean;
  var
    I: Integer;
    btDir: Byte;

    nCurrX: Integer;
    nCurrY: Integer;
  begin
    Result := False;

    FillChar(WalkStep^, SizeOf(TMapWalkXY) * 8, 0);
    for I := DR_UP to DR_UPLEFT do begin
      if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, I, nRange, nCurrX, nCurrY) and CanMove(nCurrX, nCurrY, False) then begin
        if (not boFlag) or CanAttack(nCurrX, nCurrY, m_TargetCret, nRange, btDir) or CanWalkNextPosition(nCurrX, nCurrY, nRange, I, boFlag) then begin
          WalkStep[I].nWalkStep := nRange;
          WalkStep[I].nX := nCurrX;
          WalkStep[I].nY := nCurrY;
          WalkStep[I].nMonRange := abs(nCurrX - m_TargetCret.m_nCurrX) + abs(nCurrY - m_TargetCret.m_nCurrY);
          WalkStep[I].nMonCount := GetNearTargetCount(nCurrX, nCurrY);
          WalkStep[I].nMastrRange := GetMasterRange(nCurrX, nCurrY);
          Result := True;
        end;
      end;
    end;
  end;
  function FindPosOfTarget(WalkStep: pTWalkStep; nTargetX, nTargetY, nRange: Integer; boFlag: Boolean): Boolean;
  var
    I: Integer;
    btDir: Byte;
    nCurrX: Integer;
    nCurrY: Integer;
  begin
    Result := False;
    FillChar(WalkStep^, SizeOf(TMapWalkXY) * 8, 0);
    for I := DR_UP to DR_UPLEFT do begin
      if m_PEnvir.GetNextPosition(nTargetX, nTargetY, I, nRange, nCurrX, nCurrY) and
        m_PEnvir.CanWalkEx(nCurrX, nCurrY, False) then begin
        if ((not boFlag) or CanAttack(nCurrX, nCurrY, m_TargetCret, nRange, btDir)) and IsGotoXY(m_nCurrX, m_nCurrY, nCurrX, nCurrY) then begin
          WalkStep[I].nWalkStep := nRange;
          WalkStep[I].nX := nCurrX;
          WalkStep[I].nY := nCurrY;
          WalkStep[I].nMonRange := abs(nCurrX - nTargetX) + abs(nCurrY - nTargetY);
          WalkStep[I].nMastrRange := GetMasterRange(nCurrX, nCurrY);
          WalkStep[I].nMonCount := GetRangeTargetCount(nCurrX, nCurrY, 2);
          Result := True;
        end;
      end;
    end;
  end;
  function FindPos(WalkStep: pTWalkStep; nRange: Integer; boFlag: Boolean): Boolean;
  var
    I: Integer;
    btDir: Byte;

    nCurrX: Integer;
    nCurrY: Integer;
  begin
    Result := False;

    FillChar(WalkStep^, SizeOf(TMapWalkXY) * 8, 0);
    for I := DR_UP to DR_UPLEFT do begin
      if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, I, 2, nCurrX, nCurrY) and CanMove(nCurrX, nCurrY, False) then begin
        if (not boFlag) or CanAttack(nCurrX, nCurrY, m_TargetCret, nRange, btDir) then begin
          WalkStep[I].nWalkStep := nRange;
          WalkStep[I].nX := nCurrX;
          WalkStep[I].nY := nCurrY;
          WalkStep[I].nMonRange := abs(nCurrX - m_TargetCret.m_nCurrX) + abs(nCurrY - m_TargetCret.m_nCurrY);
          WalkStep[I].nMonCount := GetNearTargetCount(nCurrX, nCurrY);
          WalkStep[I].nMastrRange := GetMasterRange(nCurrX, nCurrY);
          Result := True;
        end;
      end;
    end;
    if Result then Exit;

    FillChar(WalkStep^, SizeOf(TMapWalkXY) * 8, 0);
    for I := DR_UP to DR_UPLEFT do begin
      if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, I, 1, nCurrX, nCurrY) and CanMove(nCurrX, nCurrY, False) then begin
        if (not boFlag) or CanAttack(nCurrX, nCurrY, m_TargetCret, nRange, btDir) then begin
          WalkStep[I].nWalkStep := nRange;
          WalkStep[I].nX := nCurrX;
          WalkStep[I].nY := nCurrY;
          WalkStep[I].nMonRange := abs(nCurrX - m_TargetCret.m_nCurrX) + abs(nCurrY - m_TargetCret.m_nCurrY);
          WalkStep[I].nMonCount := GetNearTargetCount(nCurrX, nCurrY);
          WalkStep[I].nMastrRange := GetMasterRange(nCurrX, nCurrY);
          Result := True;
        end;
      end;
    end;
  end;
  function _FindPos(WalkStep: pTWalkStep; nRange: Integer; boFlag: Boolean): Boolean;
  var
    I: Integer;
    btDir: Byte;

    nCurrX: Integer;
    nCurrY: Integer;
  begin
    Result := False;

    FillChar(WalkStep^, SizeOf(TMapWalkXY) * 8, 0);
    for I := DR_UP to DR_UPLEFT do begin
      if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, I, 1, nCurrX, nCurrY) and CanMove(nCurrX, nCurrY, False) then begin
        if (not boFlag) or CanAttack(nCurrX, nCurrY, m_TargetCret, nRange, btDir) or CanWalkNextPosition(nCurrX, nCurrY, nRange, I, boFlag) then begin
          WalkStep[I].nWalkStep := nRange;
          WalkStep[I].nX := nCurrX;
          WalkStep[I].nY := nCurrY;
          WalkStep[I].nMonRange := abs(nCurrX - m_TargetCret.m_nCurrX) + abs(nCurrY - m_TargetCret.m_nCurrY);
          WalkStep[I].nMonCount := GetNearTargetCount(nCurrX, nCurrY);
          WalkStep[I].nMastrRange := GetMasterRange(nCurrX, nCurrY);
          Result := True;
        end;
      end;
    end;
    if Result then Exit;

    FillChar(WalkStep^, SizeOf(TMapWalkXY) * 8, 0);
    for I := DR_UP to DR_UPLEFT do begin
      if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, I, 2, nCurrX, nCurrY) and
        CanMove(nCurrX, nCurrY, False) then begin
        if (not boFlag) or CanAttack(nCurrX, nCurrY, m_TargetCret, nRange, btDir) or CanWalkNextPosition(nCurrX, nCurrY, nRange, I, boFlag) then begin
          WalkStep[I].nWalkStep := nRange;
          WalkStep[I].nX := nCurrX;
          WalkStep[I].nY := nCurrY;
          WalkStep[I].nMonRange := abs(nCurrX - m_TargetCret.m_nCurrX) + abs(nCurrY - m_TargetCret.m_nCurrY);
          WalkStep[I].nMonCount := GetNearTargetCount(nCurrX, nCurrY);
          WalkStep[I].nMastrRange := GetMasterRange(nCurrX, nCurrY);
          Result := True;
        end;
      end;
    end;
  end;
 (* function WalkToTargetXY(nTargetX, nTargetY: Integer): Boolean;//走向目标
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
    if (abs(nTargetX - m_nCurrX) > 1) or (abs(nTargetY - m_nCurrY) > 1) then begin
      n10 := nTargetX;
      n14 := nTargetY;
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
      if (abs(nTargetX - m_nCurrX) <= 1) and (abs(nTargetY - m_nCurrY) <= 1) then begin
        Result := True;
        dwTick3F4 := GetTickCount();
      end;
      if not Result then begin
        n20 := Random(3);
        for I := DR_UP to DR_UPLEFT do begin
          if (nOldX = m_nCurrX) and (nOldY = m_nCurrY) then begin
            if n20 <> 0 then Inc(nDir)
            else if nDir > 0 then Dec(nDir)
            else nDir := DR_UPLEFT;
            if (nDir > DR_UPLEFT) then nDir := DR_UP;
            WalkTo(nDir, False);
            if (abs(nTargetX - m_nCurrX) <= 1) and (abs(nTargetY - m_nCurrY) <= 1) then begin
              Result := True;
              dwTick3F4 := GetTickCount();
              Break;
            end;
          end;
        end;
      end;
    end;
  end;
  function RunToTargetXY(nTargetX, nTargetY: Integer): Boolean;//跑到目标坐标
  var
    nDir, n10, n14: Integer;
  begin
    Result := False;
    if not m_boCanRun then Exit;//禁止跑,则退出
      n10 := nTargetX;
      n14 := nTargetY;
      nDir:= GetNextDirection(m_nCurrX , m_nCurrY, n10, n14);
      if not RunTo1(nDir, False, nTargetX, nTargetY) then begin
        Result := WalkToTargetXY(nTargetX, nTargetY);
      end else begin
        if (abs(nTargetX - m_nCurrX) <= 1) and (abs(nTargetY - m_nCurrY) <= 1) then begin
          Result := True;
        end;
      end;
  end;     *)
  function WalkToRightPos(): Boolean;
  var
    I: Integer;
    boFlag: Boolean;
    nRange: Integer;
    WalkStep: TWalkStep;
    MapWalkXY: TMapWalkXY;
    nError: Integer;
  begin
    Result := False;
    try
      nError := 0;
      boFlag := (m_btRaceServer = 108) or (wMagicID in [SKILL_FIREBALL, SKILL_FIREBALL2, SKILL_FIRECHARM]) or (m_btJob = 0);
      if (m_btJob = 0) or (wMagicID <= 0) then begin
        nRange := 1;
        if ((wMagicID = 43) and (m_n42kill= 2)) or (wMagicID = SKILL_74) then nRange := 4;
        if (wMagicID = 12) then nRange := 2;
        if (wMagicID in [60, 61, 62]) then nRange := 6;
        nError := 1;
        for I := nRange downto 1 do begin
          nError := 25;
          if FindPosOfTarget(@WalkStep, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, I, boFlag) then begin
            nError := 26;
            MapWalkXY := FindGoodPathB(WalkStep, 0);
            nError := 27;
            if (MapWalkXY.nWalkStep > 0) then begin
              nError := 28;
              //if RunToTargetXY(MapWalkXY.nX, MapWalkXY.nY) then begin
              if GotoNext(MapWalkXY.nX, MapWalkXY.nY, m_btRaceServer <> 108) then begin
                nError := 29;
                m_RunPos.btDirection := 0;
                Result := True;
                Exit;
              end;
            end;
          end;
        end;

        nError := 12;
        for I := 2 downto 1 do begin
          nError := 13;
          if FindPosOfSelf(@WalkStep, I, boFlag) then begin
            nError := 14;
            if m_Master <> nil then begin
              MapWalkXY := FindGoodPathB(WalkStep, 1);
            end else begin
              MapWalkXY := FindGoodPathB(WalkStep, 0);
            end;
            nError := 15;
            if (MapWalkXY.nWalkStep > 0) then begin
              nError := 16;
              //if RunToTargetXY(MapWalkXY.nX, MapWalkXY.nY) then begin
              if GotoNext(MapWalkXY.nX, MapWalkXY.nY, m_btRaceServer <> 108) then begin
                nError := 17;
                m_RunPos.btDirection := 0;
                Result := True;
                Exit;
              end;
            end;
          end;
        end;
      end else begin
        if wMagicID > 0 then
          nRange := _MAX(Random(3), 2)
        else nRange := 1;
        boFlag := (m_btRaceServer = 108) or (wMagicID in [SKILL_FIREBALL, SKILL_FIREBALL2, SKILL_FIRECHARM]) or (nRange = 1);

        for I := 2 downto 1 do begin
          if FindPosOfSelf(@WalkStep, I, boFlag) then begin
            MapWalkXY := FindGoodPathA(WalkStep, nRange, 0);
            if (MapWalkXY.nWalkStep > 0) then begin
              if GotoNextOne(MapWalkXY.nX, MapWalkXY.nY, m_btRaceServer <> 108) then begin
                m_RunPos.btDirection := 0;
                Result := True;
                Exit;
              end;
            end;
          end;
        end;

        for I := 2 downto 1 do begin
          if _FindPosOfSelf(@WalkStep, I, boFlag) then begin
            MapWalkXY := FindMinRange(WalkStep);
            if (MapWalkXY.nWalkStep > 0) then begin
              if GotoNextOne(MapWalkXY.nX, MapWalkXY.nY, m_btRaceServer <> 108) then begin
                m_RunPos.btDirection := 0;
                Result := True;
                Exit;
              end;
            end;
          end;
        end;

        for I := nRange downto 1 do begin
          if FindPosOfTarget(@WalkStep, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, I, boFlag) then begin
            MapWalkXY := FindGoodPathB(WalkStep, 0);
            if (MapWalkXY.nWalkStep > 0) then begin
              if GotoNextOne(MapWalkXY.nX, MapWalkXY.nY, m_btRaceServer <> 108) then begin
                m_RunPos.btDirection := 0;
                Result := True;
                Exit;
              end;
            end;
          end;
        end;
      end;
    except
      MainOutMessage('WalkToRightPos:' + m_sCharName + ' ' + IntToStr(nError));
    end;
  end;
  function AvoidTarget: Boolean;
  var
    I, II: Integer;
    nRange: Integer;
    btDir: Byte;
    nX, nY: Integer;
    boFlag: Boolean;
    WalkStep: TWalkStep;
    MapWalkXY: TMapWalkXY;
  begin
    Result := False;
    nRange := _MAX(Random(3), 2);

    boFlag := (m_btRaceServer = 108) or (wMagicID in [SKILL_FIREBALL, SKILL_FIREBALL2, SKILL_FIRECHARM]);
    for I := nRange downto 1 do begin
      if FindPosOfSelf(@WalkStep, I, boFlag) then begin
        MapWalkXY := FindGoodPathB(WalkStep, 0);
        if (MapWalkXY.nWalkStep > 0) then begin
          btDir := GetNextDirection(m_nCurrX, m_nCurrY, MapWalkXY.nX, MapWalkXY.nY);
          if GotoNextOne(MapWalkXY.nX, MapWalkXY.nY, m_btRaceServer <> 108) then begin
            if (m_btRaceServer <> 108) then begin
              for II := nRange downto 1 do begin //再跑1次
                if m_PEnvir.GetNextPosition(MapWalkXY.nX, MapWalkXY.nY, btDir, II, nX, nY) and m_PEnvir.CanWalkEx(nX, nY, True) and
                  (GetNearTargetCount(nX, nY) <= MapWalkXY.nMonCount) then begin
                  GotoNextOne(nX, nY, m_btRaceServer <> 108);
                  break;
                end;
              end;
            end;
            m_RunPos.btDirection := 0;
            Result := True;
            Exit;
          end;
        end;
      end;
    end;

    for I := nRange downto 1 do begin
      if _FindPosOfSelf(@WalkStep, I, boFlag) then begin
        MapWalkXY := FindGoodPathB(WalkStep, 0);
        if (MapWalkXY.nWalkStep > 0) then begin
          btDir := GetNextDirection(m_nCurrX, m_nCurrY, MapWalkXY.nX, MapWalkXY.nY);
          if GotoNextOne(MapWalkXY.nX, MapWalkXY.nY, m_btRaceServer <> 108) then begin
            for II := nRange downto 1 do begin //再跑1次
              if m_PEnvir.GetNextPosition(MapWalkXY.nX, MapWalkXY.nY, btDir, II, nX, nY) and m_PEnvir.CanWalkEx(nX, nY, True) and
                (GetNearTargetCount(nX, nY) <= MapWalkXY.nMonCount) then begin
                MapWalkXY.nX := nX;
                MapWalkXY.nY := nY;
                GotoNextOne(MapWalkXY.nX, MapWalkXY.nY, m_btRaceServer <> 108);
                break;
              end;
            end;
            m_RunPos.btDirection := 0;
            Result := True;
            Exit;
          end;
        end;
      end;
    end;
  end;
  function FollowTarget: Boolean;
  var
    I: Integer;
    nRange: Integer;
    boFlag: Boolean;
    WalkStep: TWalkStep;
    MapWalkXY: TMapWalkXY;
  begin
    Result := False;
    nRange := 2;
    boFlag := (m_btRaceServer = 108) or (wMagicID in [SKILL_FIREBALL, SKILL_FIREBALL2, SKILL_FIRECHARM]);
    for I := nRange downto 1 do begin
      if FindPosOfSelf(@WalkStep, I, boFlag) then begin
        MapWalkXY := FindMinRange(WalkStep);
        if (MapWalkXY.nWalkStep > 0) then begin
          if GotoNextOne(MapWalkXY.nX, MapWalkXY.nY, m_btRaceServer <> 108) then begin
            m_RunPos.btDirection := 0;
            Result := True;
            Exit;
          end;
        end;
      end;
    end;

    for I := nRange downto 1 do begin
      if _FindPosOfSelf(@WalkStep, I, boFlag) then begin
        MapWalkXY := FindMinRange(WalkStep);
        if (MapWalkXY.nWalkStep > 0) then begin
          if GotoNextOne(MapWalkXY.nX, MapWalkXY.nY, m_btRaceServer <> 108) then begin
            m_RunPos.btDirection := 0;
            Result := True;
            Exit;
          end;
        end;
      end;
    end;
  end;
  function MotaeboPos(): Boolean; //获取野蛮冲撞
  var
    nTargetX, nTargetY: Integer;
    btNewDir: Byte;
  begin
    Result := False;
    if (m_TargetCret = nil) or (m_Master = nil) then Exit;

    if (GetPoseCreate = m_TargetCret) or (m_TargetCret.GetPoseCreate = Self) then begin
      btNewDir := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      if m_PEnvir.GetNextPosition(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, btNewDir, 1, nTargetX, nTargetY) then begin
        if m_PEnvir.CanWalk(nTargetX, nTargetY, True) then begin
          Result := True;
          Exit;
        end;
      end;
    end;
    Result := WalkToRightPos;
  end;
  function FindPosOfDir(nDir, nRange: Integer; boFlag: Boolean): TMapWalkXY;
  var
    nCurrX: Integer;
    nCurrY: Integer;
  begin
    FillChar(Result, SizeOf(TMapWalkXY), 0);
    if m_PEnvir.GetNextPosition(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, nDir, nRange, nCurrX, nCurrY) and
      CanMove(nCurrX, nCurrY, False) and ((boFlag and CanLineAttack(nCurrX, nCurrY)) or (not boFlag)) and IsGotoXY(m_nCurrX, m_nCurrY, nCurrX, nCurrY) then begin
      Result.nWalkStep := nRange;
      Result.nX := nCurrX;
      Result.nY := nCurrY;
      Result.nMonRange := abs(nCurrX - m_TargetCret.m_nCurrX) + abs(nCurrY - m_TargetCret.m_nCurrY);
      Result.nMonCount := GetNearTargetCount(nCurrX, nCurrY);
      Result.nMastrRange := GetMasterRange(nCurrX, nCurrY);
    end;
  end;
  function RunPosAttack(): Boolean;
    function GetNextRunPos(btDir: Byte; boTurn: Boolean): Byte;
    begin
      if boTurn then begin
        case btDir of
          DR_UP: Result := DR_RIGHT;
          DR_UPRIGHT: Result := DR_DOWNRIGHT;
          DR_RIGHT: Result := DR_DOWN;
          DR_DOWNRIGHT: Result := DR_DOWNLEFT;
          DR_DOWN: Result := DR_LEFT;
          DR_DOWNLEFT: Result := DR_UPLEFT;
          DR_LEFT: Result := DR_UP;
          DR_UPLEFT: Result := DR_UPRIGHT;
        end;
      end else begin
        case btDir of
          DR_UP: Result := DR_LEFT;
          DR_UPRIGHT: Result := DR_UPLEFT;
          DR_RIGHT: Result := DR_UP;
          DR_DOWNRIGHT: Result := DR_UPRIGHT;
          DR_DOWN: Result := DR_RIGHT;
          DR_DOWNLEFT: Result := DR_DOWNRIGHT;
          DR_LEFT: Result := DR_DOWN;
          DR_UPLEFT: Result := DR_DOWNLEFT;
        end;
      end;
    end;
  var
    WalkStep: array[0..1] of TMapWalkXY;
    MapWalkXY: pTMapWalkXY;
    btNewDir1: Byte;
    btNewDir2: Byte;
    nRange: Integer;
    boFlag: Boolean;
    btDir: Byte;
    nNearTargetCount: Integer;
  begin
    Result := False;

    btDir := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);

    btNewDir1 := GetNextRunPos(btDir, True);
    btNewDir2 := GetNextRunPos(btDir, False);
    FillChar(WalkStep, SizeOf(TMapWalkXY) * 2, 0);

    if m_btJob = 0 then begin
      nRange := 1;
      if (wMagicID = 43) or (wMagicID = SKILL_74) then nRange := 2;
      if (wMagicID = 12) then nRange := 2;
      if (wMagicID in [60, 61, 62]) then nRange := 6;
      WalkStep[0] := FindPosOfDir(btNewDir1, nRange, True);
      WalkStep[1] := FindPosOfDir(btNewDir2, nRange, True);
    end else begin
      nRange := 2;
      boFlag := False;
      WalkStep[0] := FindPosOfDir(btNewDir1, nRange, boFlag);
      WalkStep[1] := FindPosOfDir(btNewDir2, nRange, boFlag);
    end;

    nNearTargetCount := GetNearTargetCount(m_nCurrX, m_nCurrY);
    MapWalkXY := nil;
    if (WalkStep[0].nWalkStep > 0) and (WalkStep[1].nWalkStep > 0) then begin
      if m_RunPos.btDirection > 0 then begin
        MapWalkXY := @WalkStep[1];
      end else begin
        MapWalkXY := @WalkStep[0];
      end;
      if (nNearTargetCount < WalkStep[0].nMonCount) and (nNearTargetCount < WalkStep[1].nMonCount) then
        MapWalkXY := nil
      else
        if (m_RunPos.btDirection > 0) and (nNearTargetCount < WalkStep[1].nMonCount) then
        MapWalkXY := nil
      else
        if (m_RunPos.btDirection <= 0) and (nNearTargetCount < WalkStep[0].nMonCount) then
        MapWalkXY := nil;

      if (nNearTargetCount > 0) and (MapWalkXY <> nil) and (MapWalkXY.nMonCount > nNearTargetCount) then
        MapWalkXY := nil;
    end else
      if (WalkStep[0].nWalkStep > 0) then begin
      MapWalkXY := @WalkStep[0];
      if (nNearTargetCount < WalkStep[0].nMonCount) then
        MapWalkXY := nil;
      m_RunPos.btDirection := 0;
    end else
      if (WalkStep[1].nWalkStep > 0) then begin
      MapWalkXY := @WalkStep[1];
      if (nNearTargetCount < WalkStep[1].nMonCount) then
        MapWalkXY := nil;
      m_RunPos.btDirection := 1;
    end;
    if (MapWalkXY <> nil) then begin
      if GotoNextOne(MapWalkXY.nX, MapWalkXY.nY, m_btRaceServer <> 108) then begin
        Result := True;
      end;
    end;
    if not Result then begin
      m_RunPos.nAttackCount := 0;
    end;
  end;
var
  nCode, nError, nThinkCount: Integer;
begin
  Result := False;
  nError := 0;
  nThinkCount := 0;
  {$IF M2Version = 1}
  if (m_TargetCret = nil) and m_boUseBatter then HeroBatterStop();//连击中途无目标处理
  if m_boUseBatter and (m_btJob <> 0) then Exit;//连击则不处理以下动作
  {$IFEND}
  try
    while True do begin
      if (m_TargetCret = nil) or (wMagicID > 255) then break;
      nThinkCount := nThinkCount + 1;
      nCode := DoThink(wMagicID);
      nError := 1;
      case m_btJob of
        0: begin
            case nCode of
              2: begin
                  nError := 2;
                  if WalkToRightPos then begin
                    Result := True;
                  end else begin //无法走到正确的攻击坐标
                    nError := 3;
                    DelTargetCreat;
                    if nThinkCount < 2 then begin
                      nError := 4;
                      SearchTarget;
                      nError := 5;
                      Continue;
                    end;
                  end;
                end;
              5: begin
                  nError := 6;
                  if RunPosAttack then begin
                    Result := True;
                  end;
                  nError := 7;
                end;
            end;
          end;
        1, 2: begin
            case nCode of
              1: begin
                  nError := 8;
                  Result := AvoidTarget;
                  nError := 9;
                end;
              2: begin
                  nError := 10;
                  if FollowTarget then begin
                    nError := 11;
                    Result := True;
                  end else begin //无法走到正确的攻击坐标
                    nError := 12;
                    DelTargetCreat;
                    nError := 13;
                    if nThinkCount < 2 then begin
                      nError := 14;
                      SearchTarget;
                      nError := 15;
                      Continue;
                    end;
                  end;
                end;
              3, 4: begin
                  nError := 16;
                  if WalkToRightPos then begin
                    Result := True;
                  end else begin //无法走到正确的攻击坐标
                    nError := 3;
                    DelTargetCreat;
                    if nThinkCount < 2 then begin
                      nError := 4;
                      SearchTarget;
                      nError := 5;
                      Continue;
                    end;
                  end;
                  nError := 17;
                end;
              5: begin
                  nError := 24;
                  Result := RunPosAttack;
                  nError := 25;
                end;
            end;
          end;
      end;
      break;
    end;
  except
    MainOutMessage(format('{%s} TAIPlayObject::ActThink Name:%s Code:%d Error:%d',[g_sExceptionVer, m_sCharName, nCode, nError]));
  end;
end;

function TAIPlayObject.Thinking: Boolean;
var
  nOldX, nOldY: Integer;
  nCode: Byte;
begin
  Result := False;
  try
    if g_Config.boAutoPickUpItem and (g_AllowAIPickUpItemList.Count > 0) then begin
      if SearchPickUpItem(500) then Result := True;
    end;  
    nCode:= 1;
    if (m_Master <> nil) and (m_Master.m_boGhost) then Exit;
    nCode:= 2;
    if (m_btRaceServer = RC_HEROOBJECT) and m_Master.InSafeZone and InSafeZone then begin
      if (abs(m_nCurrX - m_Master.m_nCurrX) <= 3) and (abs(m_nCurrY - m_Master.m_nCurrY) <= 3) then begin
        Result := True;
        Exit;
      end;
    end;
    nCode:= 3;
    if (GetTickCount - m_dwThinkTick) > 3000 then begin
      m_dwThinkTick := GetTickCount();
      if m_PEnvir.GetXYObjCount(m_nCurrX, m_nCurrY) >= 2 then m_boDupMode := True;
      if (m_TargetCret <> nil) then begin
        if not IsProperTarget(m_TargetCret) then DelTargetCreat();
      end;
    end;
    nCode:= 4;
    {$IF M2Version = 1}
    if (not m_boUseBatter) and (m_TargetCret <> nil) then GetBatterMagic;//取连击技能ID 20091103
    if (m_TargetCret = nil) and m_boUseBatter then HeroBatterStop();//连击中途无目标处理
    if m_boUseBatter then Exit;//连击则不处理以下动作
    {$IFEND}
    nCode:= 5;
    if m_boDupMode then begin
      nOldX := m_nCurrX;
      nOldY := m_nCurrY;
      WalkTo(Random(8), False);
      m_dwStationTick := GetTickCount; //增加检测人物站立时间
      if (nOldX <> m_nCurrX) or (nOldY <> m_nCurrY) then begin
        m_boDupMode := False;
        Result := True;
      end;
    end;
    {$IF HEROVERSION = 1}
    if m_boAutoRecallHero and ((GetTickCount() - m_nRecallHeroTime) >= g_Config.nRecallHeroTime) then begin
      m_boAutoRecallHero:= False;
      ClientRecallHero();//召唤英雄
    end;
    {$IFEND}
  except
    MainOutMessage(Format('{%s} TAIPlayObject.Thinking Code:%d',[g_sExceptionVer, nCode]));
  end;
end;

procedure TAIPlayObject.Run;
var
  nSelectMagic, I, II, nWhere, nPercent, nValue: Integer;
  StdItem: pTStdItem;
  UserItem: pTUserItem;
  boRecalcAbilitys, boFind: Boolean;
  nCode: Byte;
begin
  try
    if (not m_boGhost) and (not m_boDeath) and (not m_boFixedHideMode) and
      (not m_boStoneMode) and (m_wStatusTimeArr[POISON_STONE] = 0) then begin
      if GetTickCount - m_dwWalkTick > m_nWalkSpeed then begin
        m_dwWalkTick := GetTickCount;
        nCode:= 1;
        if (m_TargetCret <> nil) then begin
          if (m_TargetCret.m_boDeath or m_TargetCret.m_boGhost) or m_TargetCret.InSafeZone or
            (m_TargetCret.m_PEnvir <> m_PEnvir) or (abs(m_nCurrX - m_TargetCret.m_nCurrX) > 11) or
            (abs(m_nCurrY - m_TargetCret.m_nCurrY) > 11) then
            DelTargetCreat;
        end;
        if (not m_boAIStart) then begin
          DelTargetCreat();
        end;
        nCode:= 2;
        SearchTarget();
        nCode:= 3;
        if m_ManagedEnvir <> m_PEnvir then begin//所在地图不是挂机地图则清空目标
          DelTargetCreat();
        end;
        nCode:= 4;
        if Thinking then begin
          inherited;
          Exit;
        end;
        nCode:= 5;
        if m_boProtectStatus then begin//守护状态
          if (m_nProtectTargetX = 0) or (m_nProtectTargetY = 0) then begin//取守护坐标
            m_nProtectTargetX:= m_nCurrX;//守护坐标
            m_nProtectTargetY:= m_nCurrY;//守护坐标
          end;
          nCode:= 51;
          if (not m_boProtectOK) and (m_ManagedEnvir <> nil) and (m_TargetCret = nil) then begin//没走到守护坐标
            nCode:= 52;
            GotoProtect();
            Inc(m_nGotoProtectXYCount);
            if (abs(m_nCurrX - m_nProtectTargetX) <= 3) and (abs(m_nCurrY - m_nProtectTargetY) <= 3) then begin
              m_btDirection:= Random(8);
              m_boProtectOK:= True;
              m_nGotoProtectXYCount:= 0;//是向守护坐标的累计数
            end;
            nCode:= 53;
            if (m_nGotoProtectXYCount > 20) and (not m_boProtectOK) then begin//20次还没有走到守护坐标，则飞回坐标上
              if (abs(m_nCurrX - m_nProtectTargetX) > 13) or (abs(m_nCurrY - m_nProtectTargetY) > 13) and (not InMag113LockRect(m_nCurrX, m_nCurrY)) then  begin
                nCode:= 54;
                SpaceMove(m_ManagedEnvir.sMapName, m_nProtectTargetX, m_nProtectTargetY, 1);//地图移动
                nCode:= 55;
                m_btDirection:= Random(8);
                m_boProtectOK:= True;
                m_nGotoProtectXYCount:= 0;//是向守护坐标的累计数 20090203
              end;
            end;
            inherited;
            Exit;
          end;
        end;
        nCode:= 6;
        if (m_TargetCret <> nil) then begin
          if AttackTarget then begin//攻击
            inherited;
            Exit;
          end else
          if IsNeedAvoid then begin //自动躲避
            m_dwActionTick := GetTickCount()- 10;
            AutoAvoid();
            inherited;
            Exit;
          end else begin
            if IsNeedGotoXY then begin//是否走向目标
              m_dwActionTick := GetTickCount();
              m_nTargetX:= m_TargetCret.m_nCurrX;
              m_nTargetY:= m_TargetCret.m_nCurrY;
              if (AllowUseMagic(12) or AllowUseMagic(SKILL_89)) and (m_btJob = 0) then GetGotoXY(m_TargetCret, 2);//20080617 修改
              if (m_btJob > 0) then begin
                if (g_Config.boHeroAttackTarget and (m_Abil.Level < 22)) or
                 (g_Config.boHeroAttackTao and (m_TargetCret.m_WAbil.MaxHP < 700) and (m_btJob = 2) and (m_TargetCret.m_btRaceServer <> RC_PLAYOBJECT) and (m_TargetCret.m_btRaceServer <> RC_HEROOBJECT)) then begin//20081218 道法22前是否物理攻击
                  if m_Master <> nil then begin
                    if (abs(m_Master.m_nCurrX - m_nCurrX) > 6) or (abs(m_Master.m_nCurrY - m_nCurrY) > 6) then begin
                      inherited;
                      Exit;
                    end;
                  end;
                end else GetGotoXY(m_TargetCret, 3);//道法只走向目标3格范围
              end;
              GotoTargetXY( m_nTargetX, m_nTargetY, 0);
              inherited;
              Exit;
            end;
          end;
          (*case m_btJob of
            0: begin
                if (m_TargetCret <> nil) and (Integer(GetTickCount - m_dwHitTick) > g_Config.dwHeroWarrorAttackTime) then begin
                  m_dwHitTick := GetTickCount();
                  if (GetTickCount()- m_dwSearchMagic > 1200) and (not m_boUseBatter) then begin
                    m_dwSearchMagic:= GetTickCount();
                    nSelectMagic := SelectMagic;
                  end;
                  m_dwHitTick := GetTickCount();
                  if ActThink(nSelectMagic) then begin
                    //inherited;
                    //Exit;
                  end;
                  m_dwHitTick := GetTickCount();
                  if (m_TargetCret <> nil) and StartAttack(nSelectMagic) then begin
                    if (nSelectMagic > 0) and (nSelectMagic <= High(m_SkillUseTick)) then begin
                      m_SkillUseTick[nSelectMagic] := GetTickCount;
                    end;
                  end;
                end;
              end;
            1: begin
                if (m_TargetCret <> nil) and (Integer(GetTickCount - m_dwHitTick) > g_Config.dwHeroWizardAttackTime) then begin
                  m_dwHitTick := GetTickCount();
                  if (not m_boUseBatter) then begin
                    if (GetTickCount()- m_dwSearchMagic > 1200) then begin
                      m_dwSearchMagic:= GetTickCount();
                      nSelectMagic := SelectMagic;
                    end;
                    m_dwHitTick := GetTickCount();
                    if ActThink(nSelectMagic) then begin
                      //inherited;
                      //Exit;
                    end;
                    m_dwHitTick := GetTickCount();
                  end;
                  if (m_TargetCret <> nil) and StartAttack(nSelectMagic) then begin
                    if (nSelectMagic >= 0) and (nSelectMagic <= High(m_SkillUseTick)) then begin
                      m_SkillUseTick[nSelectMagic] := GetTickCount;
                    end;
                  end;
                end;
              end;
            2: begin
                if (m_TargetCret <> nil) and (Integer(GetTickCount - m_dwHitTick) > g_Config.dwHeroTaoistAttackTime) then begin
                  m_dwHitTick := GetTickCount();
                  if (not m_boUseBatter) then begin
                    if (GetTickCount()- m_dwSearchMagic > 1200) then begin
                      m_dwSearchMagic:= GetTickCount();
                      nSelectMagic := SelectMagic;
                    end;
                    m_dwHitTick := GetTickCount();
                    if ActThink(nSelectMagic) then begin
                      //inherited;
                      //Exit;
                    end;
                    m_dwHitTick := GetTickCount();
                  end;
                  if (m_TargetCret <> nil) and StartAttack(nSelectMagic) then begin
                    if (nSelectMagic >= 0) and (nSelectMagic <= High(m_SkillUseTick)) then begin
                      m_boSelSelf:= False;
                      m_SkillUseTick[nSelectMagic] := GetTickCount;
                    end;
                  end;
                end;
              end;
          end;   *)
        end;
        nCode:= 7;
        if m_boAI and (not m_boGhost) and (not m_boDeath) then begin
          if g_Config.boHPAutoMoveMap then begin
            if (m_WAbil.HP <= Round(m_WAbil.MaxHP * 0.3)) and (GetTickCount - m_dwHPToMapHomeTick > 15000) then begin //低血时回城或回守护点 20110512
              m_dwHPToMapHomeTick:= GetTickCount;
              DelTargetCreat();
              if m_boProtectStatus and (not InMag113LockRect(m_nCurrX, m_nCurrY)) then begin//守护状态
                SpaceMove(m_ManagedEnvir.sMapName, m_nProtectTargetX, m_nProtectTargetY, 1);//地图移动
                m_btDirection:= Random(8);
                m_boProtectOK:= True;
                m_nGotoProtectXYCount:= 0;//是向守护坐标的累计数 20090203
              end else begin//不是守护状态，直接回城
                MoveToHome();//移动到回城点
              end;
            end;
          end;
          if g_Config.boAutoRepairItem then begin//是否允许自动修理
            nCode:= 71;
            if GetTickCount - m_dwAutoRepairItemTick > 15000 then begin
              m_dwAutoRepairItemTick := GetTickCount;
              boRecalcAbilitys := False;
              nCode:= 72;
              for nWhere := Low(THumanUseItems) to High(THumanUseItems) do begin
                if (m_UseItemNames[nWhere] <> '') and (m_UseItems[nWhere].wIndex <= 0) then begin
                  nCode:= 73;
                  StdItem := UserEngine.GetStdItem(m_UseItemNames[nWhere]);
                  if StdItem <> nil then begin
                    nCode:= 74;
                    New(UserItem);
                    if UserEngine.CopyToUserItemFromName(m_UseItemNames[nWhere], UserItem) then begin
                      boRecalcAbilitys := True;
                      if StdItem.StdMode in [15, 19, 20, 21, 22, 23, 24, 26] then begin
                        if (StdItem.Shape = 130) or (StdItem.Shape = 131) or (StdItem.Shape = 132) then begin
                          UserEngine.GetUnknowItemValue(UserItem);
                        end;
                      end;
                    end;
                    nCode:= 75;
                    m_UseItems[nWhere] := UserItem^;
                    Dispose(UserItem);
                  end;
                end;
              end;
              nCode:= 76;
              if m_BagItemNames.Count > 0 then begin
                for I:= 0 to m_BagItemNames.Count -1 do begin
                  for II := 0 to m_ItemList.Count - 1 do begin
                    UserItem := m_ItemList.Items[II];
                    if UserItem <> nil then begin
                      StdItem := UserEngine.GetStdItem(UserItem.wIndex);
                      if StdItem <> nil then begin
                        boFind := False;
                        if CompareText(StdItem.Name, m_BagItemNames.Strings[I]) = 0 then begin
                          boFind := True;
                          break;
                        end;
                      end;
                    end;
                  end;
                  nCode:= 77;
                  if not boFind then begin
                    New(UserItem);
                    if UserEngine.CopyToUserItemFromName(m_BagItemNames.Strings[I], UserItem) then begin
                      nCode:= 82;
                      if not AddItemToBag(UserItem) then begin
                        Dispose(UserItem);
                        break;
                      end;
                    end else Dispose(UserItem);
                  end;
                end;
              end;
              nCode:= 78;
              for nWhere := Low(THumanUseItems) to High(THumanUseItems) do begin
                if m_UseItems[nWhere].wIndex > 0 then begin
                  StdItem := UserEngine.GetStdItem(m_UseItems[nWhere].wIndex);
                  if StdItem <> nil then begin
                    if (m_UseItems[nWhere].DuraMax > m_UseItems[nWhere].Dura) and (StdItem.StdMode <> 43) then begin
                      if PlugOfCheckCanItem(3, StdItem.Name, False, 0, 0) then Continue;
                      m_UseItems[nWhere].Dura := m_UseItems[nWhere].DuraMax;
                    end;
                  end;
                end;
              end;
              nCode:= 79;
              if boRecalcAbilitys then RecalcAbilitys;
            end;
          end;
          nCode:= 80;
          if g_Config.boRenewHealth then begin//自动增加HP MP
            if GetTickCount - m_dwAutoAddHealthTick > 5000 then begin
              m_dwAutoAddHealthTick := GetTickCount;
              nPercent := m_WAbil.HP * 100 div m_WAbil.MaxHP;
              nValue := m_WAbil.MaxHP div 10;
              if nPercent < g_Config.nRenewPercent then begin
                if m_WAbil.HP + nValue >= m_WAbil.MaxHP then begin
                  m_WAbil.HP := m_WAbil.MaxHP;
                end else begin
                  Inc(m_WAbil.HP, nValue);
                end;
              end;
              nCode:= 81;
              nValue := m_WAbil.MaxMP div 10;
              nPercent := m_WAbil.MP * 100 div m_WAbil.MaxMP;
              if nPercent < g_Config.nRenewPercent then begin
                if m_WAbil.MP + nValue >= m_WAbil.MaxMP then begin
                  m_WAbil.MP := m_WAbil.MaxMP;
                end else begin
                  Inc(m_WAbil.MP, nValue);
                end;
              end;
            end;
          end;
        end;
      end;
      nCode:= 8;
      if (not m_boGhost) and (not m_boDeath) and (not m_boFixedHideMode) and
        (not m_boStoneMode) and (m_wStatusTimeArr[POISON_STONE] = 0) then begin
        if m_boProtectStatus and (m_TargetCret = nil) then begin //守护状态
          if (abs(m_nCurrX - m_nProtectTargetX) > 50) or (abs(m_nCurrY - m_nProtectTargetY) > 50) then begin
            m_boProtectOK:= False;
          end;
        end;
        nCode:= 9;
        if (m_TargetCret = nil) then begin
          if (m_Master <> nil) then FollowMaster
          else Wondering();
        end;
      end;
    end;
  except
    MainOutMessage(Format('{%s} TAIPlayObject.Run Code:%d',[g_sExceptionVer, nCode]));
  end;
  inherited;
end;

function TAIPlayObject.IsProtectTarget(BaseObject: TBaseObject): Boolean;
begin
  Result := inherited IsProtectTarget(BaseObject);
end;

function TAIPlayObject.IsAttackTarget(BaseObject: TBaseObject): Boolean;
begin
  Result := inherited IsAttackTarget(BaseObject);
end;

function TAIPlayObject.IsProperTarget(BaseObject: TBaseObject): Boolean;
begin
  Result := False;
  if BaseObject <> nil then begin
    if inherited IsProperTarget(BaseObject) then begin
      Result := True;
      if m_MyHero <> nil then begin
        if (BaseObject = m_MyHero) or (BaseObject.m_Master = m_MyHero) then Result := False;//不主动攻击英雄和英雄的宝宝
      end;
      if BaseObject.m_Master <> nil then begin
        if (BaseObject.m_Master = self) or ((BaseObject.m_Master.m_boAI)and (not m_boInFreePKArea)) then Result := False;
      end;
      if BaseObject.m_boAI and (not m_boInFreePKArea) then Result := False;//假人不攻击假人,行会战除外
      case BaseObject.m_btRaceServer of
        RC_ARCHERGUARD, 55: begin//不主动攻击练功师 弓箭手
          if BaseObject.m_TargetCret <> Self then Result := False;
        end;
        10, 11, 12: Result := False;//不攻击大刀卫士
        110, 111, 158: Result := False;//沙巴克城门,沙巴克左城墙,宠物类
      end;
    end else begin
      if m_btAttatckMode = HAM_PKATTACK then begin//红名模式，除红名目标外，受人攻击时才还击
        if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
          if PKLevel >= 2 then begin
            if BaseObject.PKLevel < 2 then
              Result := True
            else Result := False;
          end else begin
            if BaseObject.PKLevel >= 2 then
              Result := True
            else Result := False;
          end;
        end;
        if m_boAI and (not Result) then begin
          if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) or
             (BaseObject.m_btRaceServer = RC_HEROOBJECT) or (BaseObject.m_Master <> nil) then begin
            if BaseObject.m_TargetCret <> nil then begin
              if (BaseObject.m_TargetCret = self) or (BaseObject.m_TargetCret = m_MyHero) then Result := True;
            end;
            if BaseObject.m_LastHiter <> nil then begin
              if (BaseObject.m_LastHiter = self) or (BaseObject.m_LastHiter = m_MyHero) then Result := True;
            end;
            if BaseObject.m_ExpHitter <> nil then begin
              if (BaseObject.m_LastHiter = self) or (BaseObject.m_ExpHitter = m_MyHero) then Result := True;
            end;
          end;
        end;
        if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) or (BaseObject.m_btRaceServer = RC_HEROOBJECT)
          or (BaseObject.m_Master <> nil) then begin//安全区不能打人物和英雄
          if BaseObject.InSafeZone or InSafeZone then Result := False;
        end;
        if m_MyHero <> nil then begin
          if (BaseObject = m_MyHero) or (BaseObject.m_Master = m_MyHero) then Result := False;//不主动攻击英雄和英雄的宝宝
        end;
        if (BaseObject.m_Master = self) then Result := False;
        if BaseObject.m_boAI and ((not m_boInFreePKArea) or (BaseObject.PKLevel < 2)) then Result := False;//假人不攻击假人,行会战除外
        case BaseObject.m_btRaceServer of
          RC_ARCHERGUARD,55: begin//不主动攻击练功师 弓箭手
            if BaseObject.m_TargetCret <> Self then Result := False;
          end;
          10, 11, 12: Result := False;//不攻击大刀卫士
          110, 111, 158: Result := False;//沙巴克城门,沙巴克左城墙,宠物类
        end;
      end;
    end;
  end;
end;

function TAIPlayObject.IsProperFriend(BaseObject: TBaseObject): Boolean;
begin
  Result := inherited IsProperFriend(BaseObject);
end;

procedure TAIPlayObject.SearchViewRange;
var
  I, nStartX, nEndX, nStartY, nEndY, n18, n1C, nIdx, n24, n25: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
  MapItem: PTMapItem;
  MapEvent: TEvent;
  VisibleBaseObject: pTVisibleBaseObject;
  VisibleMapItem: pTVisibleMapItem;
  nCheckCode: Byte;
  //btType: Byte;//20090510 注释
  nVisibleFlag: {Integer}Byte;//20090823 修改为 Byte
  dwRunTick: LongWord;//20091103 测试用
resourcestring
  sExceptionMsg1 = '{%s} TAIPlayObject::SearchViewRange Code:%d';
  sExceptionMsg2 = '{%s} TAIPlayObject::SearchViewRange 1-%d %s %s %d %d %d';
begin
  nCheckCode := 1;
  n24 := 0;
  try
    if m_boNotOnlineAddExp or m_boGhost then Exit; //2006-10-22 叶随风飘 修改 离线挂机不搜索
    nCheckCode := 2;
    if m_VisibleItems.Count > 0 then begin
      for I := 0 to m_VisibleItems.Count - 1 do begin
        pTVisibleMapItem(m_VisibleItems.Items[I]).nVisibleFlag := 0;
      end;
    end;
    {nCheckCode := 3;
    if m_VisibleEvents.Count > 0 then begin//20080629 20090823 注释，第三步处理完后直接初始为0
      for I := 0 to m_VisibleEvents.Count - 1 do begin
        if TEvent(m_VisibleEvents.Items[I]) <> nil then begin
          TEvent(m_VisibleEvents.Items[I]).nVisibleFlag := 0;
        end;
      end;
    end;
    nCheckCode := 4;
    if m_VisibleActors.Count > 0 then begin//20080629  20090822 注释，第三步处理完后直接初始为0
      for I := 0 to m_VisibleActors.Count - 1 do begin
        pTVisibleBaseObject(m_VisibleActors.Items[I]).nVisibleFlag := 0;
      end;
    end;}
  except                      
    MainOutMessage(Format(sExceptionMsg1, [g_sExceptionVer, nCheckCode]));
    KickException();
  end;
  nCheckCode := 6;

  try
    nStartX := m_nCurrX - m_nViewRange;
    nEndX := m_nCurrX + m_nViewRange;
    nStartY := m_nCurrY - m_nViewRange;
    nEndY := m_nCurrY + m_nViewRange;

    dwRunTick:= GetTickCount();//20091103 测试
    nCheckCode := 7;
    for n18 := nStartX to nEndX do begin
      for n1C := nStartY to nEndY do begin
        nCheckCode := 8;
        if m_PEnvir.GetMapCellInfo(n18, n1C, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
          nCheckCode := 9;
          n24 := 1;
          nIdx := 0;
          while (True) do begin
            if ((GetTickCount - dwRunTick) > 500) then Break;//超时则退出循环(测试) 20091103
            if MapCellInfo <> nil then begin//20080910 增加  20090316 注释  20100614 还原
              if (MapCellInfo.ObjList <> nil) and (MapCellInfo.ObjList.Count <= 0) then begin //200-11-1 增加
                nCheckCode := 10;
                FreeAndNil(MapCellInfo.ObjList);
                nCheckCode := 101;
                Break;
              end;
            end;
            nCheckCode := 11;
            try//20091102 增加
              if MapCellInfo.ObjList.Count <= nIdx then Break;
            except
              Break;
            end;
            nCheckCode := 121;
            try //20091101 增加
              OSObject := MapCellInfo.ObjList.Items[nIdx];
            except
              //OSObject:= nil;
              MapCellInfo.ObjList.Delete(nIdx);//20101103 修改
              Continue;
            end;
            nCheckCode := 131;
            if OSObject <> nil then begin
              if (not OSObject.boObjectDisPose) then begin
                case OSObject.btType of
                  OS_MOVINGOBJECT: begin
                      if (GetTickCount - OSObject.dwAddTime) >= 60000 then begin
                        OSObject.boObjectDisPose:= True;//20090510 增加
                        Dispose(OSObject);
                        MapCellInfo.ObjList.Delete(nIdx);
                        if MapCellInfo.ObjList.Count <= 0 then begin
                          FreeAndNil(MapCellInfo.ObjList);
                          Break;
                        end;
                        Continue;
                      end;
                      BaseObject := TBaseObject(OSObject.CellObj);
                      if BaseObject <> nil then begin
                        if not BaseObject.m_boGhost and not BaseObject.m_boFixedHideMode and not BaseObject.m_boObMode then begin
                          if (m_btRaceServer < RC_ANIMAL) or (m_Master <> nil) or m_boCrazyMode or m_boWantRefMsg or
                            ((BaseObject.m_Master <> nil) and (abs(BaseObject.m_nCurrX - m_nCurrX) <= 3) and (abs(BaseObject.m_nCurrY - m_nCurrY) <= 3)) or
                            (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then begin
                            UpdateVisibleGay(BaseObject, 0);
                          end;
                        end;
                      end; //if BaseObject <> nil then begin
                    end;//OS_MOVINGOBJECT
                  OS_ITEMOBJECT: begin
                      if m_btRaceServer = RC_PLAYOBJECT then begin
                        if ((GetTickCount - OSObject.dwAddTime) > g_Config.dwClearDropOnFloorItemTime) or
                          ((PTMapItem(OSObject.CellObj).UserItem.AddValue[0] = 1) and
                          (GetHoursCount(PTMapItem(OSObject.CellObj).UserItem.MaxDate, Now) <= 0)) then begin
                          if PTMapItem(OSObject.CellObj) <> nil then
                            Dispose(PTMapItem(OSObject.CellObj)); //防止占用内存不释放现象 20080702
                          try//20090504 增加
                            if OSObject <> nil then begin
                              OSObject.boObjectDisPose:= True;//20090510 增加
                              Dispose(OSObject);//20090107 增加<>nil
                            end;
                          except
                          end;
                          MapCellInfo.ObjList.Delete(nIdx);
                          if MapCellInfo.ObjList.Count <= 0 then begin
                            FreeAndNil(MapCellInfo.ObjList);
                            Break;
                          end;
                          Continue;
                        end;
                        MapItem := PTMapItem(OSObject.CellObj);
                        UpdateVisibleItem(n18, n1C, MapItem);
                        if (MapItem.OfBaseObject <> nil) or (MapItem.DropBaseObject <> nil) then begin
                          if (GetTickCount - MapItem.dwCanPickUpTick) > g_Config.dwFloorItemCanPickUpTime {2 * 60 * 1000} then begin
                            MapItem.OfBaseObject := nil;
                            MapItem.DropBaseObject := nil;
                          end else begin
                            if TBaseObject(MapItem.OfBaseObject) <> nil then begin
                              if TBaseObject(MapItem.OfBaseObject).m_boGhost then MapItem.OfBaseObject := nil;
                            end;
                            if TBaseObject(MapItem.DropBaseObject) <> nil then begin
                              if TBaseObject(MapItem.DropBaseObject).m_boGhost then MapItem.DropBaseObject := nil;
                            end;
                          end;
                        end;                        
                      end;
                    end;//OS_ITEMOBJECT
                  OS_EVENTOBJECT: begin
                      if m_btRaceServer = RC_PLAYOBJECT then begin
                        if OSObject.CellObj <> nil then begin//20080913
                          MapEvent := TEvent(OSObject.CellObj);
                          //if MapEvent.m_boVisible then
                          begin
                            UpdateVisibleEvent(n18, n1C, MapEvent);
                          end;
                        end;                        
                      end;                    
                    end;//OS_EVENTOBJECT
                end;//Case
              end;
            end; //if OSObject <> nil then begin
            Inc(nIdx);
          end; //while
        end;
      end; //for n1C:= n10 to n14  do begin
    end; //for n18:= n8 to nC do begin
  except
    on E: Exception do begin
      MainOutMessage(Format(sExceptionMsg2, [g_sExceptionVer, n24, m_sCharName, m_sMapName, m_nCurrX, m_nCurrY, nCheckCode]));//20100125 注释
      KickException();
    end;
  end;
  nCheckCode := 26;
  n24 := 2;
  try
    n18 := 0;
    while (True) do begin
      try//20101126 防止死循环
        if m_VisibleActors.Count <= n18 then Break;
        nCheckCode := 27;
        try//20081017 去注释
          VisibleBaseObject := m_VisibleActors.Items[n18];
          nCheckCode := 28;
          nVisibleFlag := VisibleBaseObject.nVisibleFlag; //2006-10-14 防止内存出错
        except
          m_VisibleActors.Delete(n18);
          if m_VisibleActors.Count > 0 then Continue;//20090430 修改
          Break;//20090430 增加
        end;
        case VisibleBaseObject.nVisibleFlag of//20090822 修改
          0: begin
             if m_btRaceServer = RC_PLAYOBJECT then begin
               nCheckCode := 29;
               BaseObject := TBaseObject(VisibleBaseObject.BaseObject);
               nCheckCode := 30;
               if BaseObject <> nil then begin
                 nCheckCode := 51;
                 if (not BaseObject.m_boFixedHideMode) and (not BaseObject.m_boGhost) then begin //01/21 修改防止人物退出时发送重复的消息占用带宽，人物进入隐身模式时人物不消失问题
                   nCheckCode := 31;
                   SendMsg(BaseObject, RM_DISAPPEAR, 0, 0, 0, 0, '');
                 end;
               end;
             end;
             nCheckCode := 52;
             m_VisibleActors.Delete(n18);
             nCheckCode := 32;
             try
               if VisibleBaseObject <> nil then Dispose(VisibleBaseObject);//20091017 修改
             except
             end;
             Continue;
           end;//0
          2: begin
              if (m_btRaceServer = RC_PLAYOBJECT) then begin
                nCheckCode := 34;
                BaseObject := TBaseObject(VisibleBaseObject.BaseObject);
                if (BaseObject <> nil) then begin
                  if (BaseObject <> Self) and (not BaseObject.m_boGhost) and (not m_boGhost) then begin
                    if BaseObject.m_boDeath then begin
                      if BaseObject.m_boSkeleton then begin
                        nCheckCode := 35;
                        SendMsg(BaseObject, RM_SKELETON, BaseObject.m_btDirection, BaseObject.m_nCurrX, BaseObject.m_nCurrY, 0, '');
                      end else begin
                        nCheckCode := 36;
                        SendMsg(BaseObject, RM_DEATH, BaseObject.m_btDirection, BaseObject.m_nCurrX, BaseObject.m_nCurrY, 0, '');
                      end;
                    end else begin
                      try//20090721 增加
                        if (BaseObject <> nil) then begin//20090721 增加
                          {$IF M2Version <> 2}
                          n25:= 0;
                          case BaseObject.m_btRaceServer of//20090818 修改
                            RC_PLAYOBJECT: begin
                               if (not TPlayObject(BaseObject).m_boShowFengHao) and (TPlayObject(BaseObject).m_boUseTitle) then n25:= TPlayObject(BaseObject).m_boUseIitleIdx;
                               SendMsg(BaseObject, RM_TURN, BaseObject.m_btDirection, BaseObject.m_nCurrX, BaseObject.m_nCurrY, n25, BaseObject.GetShowName);
                               if TPlayObject(BaseObject).m_boTrainingNG then
                                 SendMsg(BaseObject, RM_MAGIC69SKILLNH, 0, TPlayObject(BaseObject).m_Skill69NH, TPlayObject(BaseObject).m_Skill69MaxNH, 0, '');
                             end;
                            RC_HEROOBJECT: begin
                               SendMsg(BaseObject, RM_TURN, BaseObject.m_btDirection, BaseObject.m_nCurrX, BaseObject.m_nCurrY, 0, BaseObject.GetShowName);
                               if THeroObject(BaseObject).m_boTrainingNG then
                                 SendMsg(BaseObject, RM_MAGIC69SKILLNH, 0, THeroObject(BaseObject).m_Skill69NH, THeroObject(BaseObject).m_Skill69MaxNH, 0, '');
                             end;
                            RC_PLAYMOSTER: begin
                               if (BaseObject.m_Master <> nil) and (BaseObject.m_Master.m_btRaceServer = RC_PLAYOBJECT) then begin
                                 if (not TPlayObject(BaseObject.m_Master).m_boShowFengHao) and (TPlayObject(BaseObject.m_Master).m_boUseTitle) then n25:= TPlayObject(BaseObject.m_Master).m_boUseIitleIdx;
                               end;
                               SendMsg(BaseObject, RM_TURN, BaseObject.m_btDirection, BaseObject.m_nCurrX, BaseObject.m_nCurrY, n25, BaseObject.GetShowName);
                               if (BaseObject.m_Master <> nil) then begin//学过内功人物的分身也显示黄条值
                                 if (BaseObject.m_Master.m_btRaceServer = RC_PLAYOBJECT) then begin
                                   if TPlayObject(BaseObject.m_Master).m_boTrainingNG then begin
                                     SendMsg(BaseObject, RM_MAGIC69SKILLNH, 0, TPlayObject(BaseObject.m_Master).m_Skill69NH, TPlayObject(BaseObject.m_Master).m_Skill69MaxNH, 0, '');
                                   end;
                                 end else
                                 if (BaseObject.m_Master.m_btRaceServer = RC_HEROOBJECT) then begin
                                   if THeroObject(BaseObject.m_Master).m_boTrainingNG then begin
                                     SendMsg(BaseObject, RM_MAGIC69SKILLNH, 0, THeroObject(BaseObject.m_Master).m_Skill69NH, THeroObject(BaseObject.m_Master).m_Skill69MaxNH, 0, '');
                                   end;
                                 end;
                               end;
                             end;
                             else SendMsg(BaseObject, RM_TURN, BaseObject.m_btDirection, BaseObject.m_nCurrX, BaseObject.m_nCurrY, 0, BaseObject.GetShowName);
                          end;//case
                          {$ELSE}
                          SendMsg(BaseObject, RM_TURN, BaseObject.m_btDirection, BaseObject.m_nCurrX, BaseObject.m_nCurrY, 0, BaseObject.GetShowName);
                          {$IFEND}
                        end;
                      except
                      end;
                    end;
                  end;
                end;
              end;
              VisibleBaseObject.nVisibleFlag:= 0;//处理完初始变量 20090822
           end;//2
           1: VisibleBaseObject.nVisibleFlag:= 0;//处理完初始变量 20090822
        end;//case
      except
        Break;
      end;
      Inc(n18);
    end;
  except
    on E: Exception do begin
      MainOutMessage(Format(sExceptionMsg2, [g_sExceptionVer, n24, m_sCharName, m_sMapName, m_nCurrX, m_nCurrY, nCheckCode]));
      KickException();
    end;
  end;
  try
    I := 0;
    while (True) do begin
      try//20101126 防止死循环
        if m_VisibleItems.Count <= I then Break;
        nCheckCode := 49;
        try //20081017 去注释
          VisibleMapItem := m_VisibleItems.Items[I];
          nCheckCode := 50;
          nVisibleFlag := VisibleMapItem.nVisibleFlag; //2006-10-14 防止内存出错
        except
          m_VisibleItems.Delete(I);
          if m_VisibleItems.Count > 0 then Continue;//20090430 修改
          Break;//20090430 增加
        end;
        nCheckCode := 38;
        if VisibleMapItem.nVisibleFlag = 0 then begin
          m_VisibleItems.Delete(I);
          try
            //DisPoseAndNil(VisibleMapItem);
            DisPose(VisibleMapItem);//DisPoseAndNil是个不可能实现的函数 By TasNat at: 2012-03-17
            VisibleMapItem := nil;
          except
            VisibleMapItem := nil;
          end;
          if m_VisibleItems.Count > 0 then Continue;//20090511 修改
          Break;//20090511 增加
        end;
      except
        Break;
      end;
      Inc(I);
    end;
    I := 0;
    while (True) do begin //2006-01-20 修改
      try//20101126 防止死循环
        if m_VisibleEvents.Count <= I then Break;
        nCheckCode := 43;
        try //20081017 去注释
          MapEvent := m_VisibleEvents.Items[I];
          nVisibleFlag := MapEvent.nVisibleFlag;//20090322 修改
        except
          m_VisibleEvents.Delete(I);
          if m_VisibleEvents.Count > 0 then Continue;//20090511 修改
          Break;//20090511 增加
        end;
        if MapEvent <> nil then begin
          nCheckCode := 44;
          Case MapEvent.nVisibleFlag of//20090822 修改
            0: begin
                nCheckCode := 45;
                SendMsg(Self, RM_HIDEEVENT, 0, Integer(MapEvent), MapEvent.m_nX, MapEvent.m_nY, '');
                nCheckCode := 46;
                m_VisibleEvents.Delete(I);
                nCheckCode := 47;
                if m_VisibleEvents.Count > 0 then Continue;//20090511 修改
                Break;//20090511 增加
             end;//0
            1: MapEvent.nVisibleFlag:= 0;//处理完初始变量 20090823
            2: begin
               SendMsg(Self, RM_SHOWEVENT, MapEvent.m_nEventType, Integer(MapEvent), MakeLong(MapEvent.m_nX, MapEvent.m_nEventParam), MapEvent.m_nY, '');
               MapEvent.nVisibleFlag:= 0;//处理完初始变量 20090823
             end;
          end;//case
        end;
      except
        Break;
      end;
      Inc(I);
    end;
  except
    MainOutMessage(m_sCharName + ',' + m_sMapName + ',' +IntToStr(m_nCurrX) + ',' +
      IntToStr(m_nCurrY) + ',' +' SearchViewRange 3 CheckCode:' + IntToStr(nCheckCode));
    KickException();
  end;
end;

//-------------------------------------------------------------------------------
(*procedure TAIPlayObject.NewGotoTargetXY;
var
  I, nDir, n10, n14, n20, nOldX, nOldY: Integer;
begin
  try
    if ((m_nCurrX <> m_nTargetX) or (m_nCurrY <> m_nTargetY)) then begin
      n10 := m_nTargetX;
      n14 := m_nTargetY;
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
  except
    MainOutMessage(Format('{%s} TAIPlayObject.NewGotoTargetXY', [g_sExceptionVer]));
  end;
end;

procedure TAIPlayObject.HeroTail();
var
  nX, nY, nDir: Integer;
begin
  try
    if (GetTickCount - dwTick5F4) > m_dwRunIntervalTime then begin
      dwTick5F4 := GetTickCount;
      if m_nTargetX <> -1 then begin
        if (abs(m_nCurrX - m_nTargetX) > 2) or (abs(m_nCurrY - m_nTargetY) > 2) then begin
          if abs(m_nTargetX - m_nCurrX) > 1 then begin
            if (m_nTargetX > m_nCurrX) then nX := m_nCurrX + 2
            else nX := m_nCurrX - 2;
          end else nX := m_nTargetX;
          if abs(m_nTargetY - m_nCurrY) > 1 then begin
            if (m_nTargetY > m_nCurrY) then nY := m_nCurrY + 2
            else nY := m_nCurrY - 2;
          end else nY := m_nTargetY;
          nDir := GetNextDirection(m_nCurrX, m_nCurrY, nX, nY);
          if RunTo(nDir, False, nX, nY) then begin
            if m_boTransparent and (m_boHideMode) then m_wStatusTimeArr[STATE_TRANSPARENT] := 1;
            Dec(m_nHealthTick, 60);
            Dec(m_nSpellTick, 10);
            m_nSpellTick := _MAX(0, m_nSpellTick);
            Dec(m_nPerHealth);
            Dec(m_nPerSpell);
          end else NewGotoTargetXY();
        end else NewGotoTargetXY();
      end;
    end;
  except
    MainOutMessage(Format('{%s} TAIPlayObject.HeroTail', [g_sExceptionVer]));
  end;
end; *)

function TAIPlayObject.WarrAttackTarget1(wHitMode: Word): Boolean; {物理攻击}
var
  bt06, nCode: Byte;
  boHit: Boolean;
begin
  Result := False;
  try
    if m_TargetCret <> nil then begin
      boHit:= GetAttackDir(m_TargetCret, bt06);
      if (not boHit) and ((wHitMode = 4) or (wHitMode = 15)) then
        boHit:= GetAttackDir(m_TargetCret, 2, bt06);//防止隔位刺杀无效果 20110521
      if boHit then begin
        m_dwTargetFocusTick := GetTickCount();
        AttackDir(m_TargetCret, wHitMode, bt06, 0);
        m_dwActionTick := GetTickCount();
        BreakHolySeizeMode();
        Result := True;
      end else begin
        if m_TargetCret.m_PEnvir = m_PEnvir then begin
          SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
        end else begin
          DelTargetCreat();
        end;
      end;
    end;
  except
    on E: Exception do begin
      MainOutMessage(Format('{%s} TAIPlayObject.WarrAttackTarget',[g_sExceptionVer]));
    end;
  end;
end;

function TAIPlayObject.WarrorAttackTarget1(): Boolean; {战士攻击}
var
  UserMagic: pTUserMagic;
  nCode: Byte;
begin
  Result := False;
  nCode:= 0;
  try
    m_wHitMode := 0;
    if m_WAbil.MP > 0 then begin
      if m_TargetCret <> nil then begin
        nCode:= 2;
        if ((m_WAbil.HP <= Round(m_WAbil.MaxHP * 0.25)) or m_TargetCret.m_boCrazyMode) then begin //20080718 注释,战不躲避
          if AllowUseMagic(12) or AllowUseMagic(SKILL_89) then begin//血少时或目标疯狂模式时，做隔位刺杀 20080827
            if not (((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 2) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 0)) or
              ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 1) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 0)) or
              ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 1) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 1)) or
              ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 2) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 2)) or
              ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 0) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 1)) or
              ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 0) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 2))) then begin//20090213 增加条件
              nCode:= 3;
              GetGotoXY(m_TargetCret, 2);
              GotoTargetXY( m_nTargetX, m_nTargetY, 0);
            end;
          end;
        end;
      end;
      nCode:= 4;
      SearchMagic();//查询魔法
      nCode:= 5;
      if m_nSelectMagic > 0 then begin
        nCode:= 7;
        UserMagic := FindMagic(m_nSelectMagic);
        if (UserMagic <> nil) then begin
          if (UserMagic.btKey = 0) then begin//技能打开状态才能使用
            case m_nSelectMagic of
              27, 39, 41, 60..65, 68, 75, SKILL_101, SKILL_102: begin
                  if m_TargetCret <> nil then begin
                    nCode:= 8;
                    Result := UseSpell(UserMagic, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, m_TargetCret); //战士魔法
                    m_dwHitTick := GetTickCount();
                    Exit;
                  end;
                end;
               7: m_wHitMode := 3; //攻杀
              12: m_wHitMode := 4; //使用刺杀
              SKILL_89: m_wHitMode := 15;//四级刺杀
              25: m_wHitMode := 5; //使用半月
              SKILL_90: m_wHitMode := 16;//圆月弯刀(四级半月弯刀)
              26: if UseSpell(UserMagic, m_nCurrX, m_nCurrY, m_TargetCret) then m_wHitMode := 7; //使用烈火
              40: m_wHitMode := 8; //抱月刀法
              43: if UseSpell(UserMagic, m_nCurrX, m_nCurrY, m_TargetCret) then m_wHitMode := 9; //开天斩  20100910 修改
              42: if UseSpell(UserMagic, m_nCurrX, m_nCurrY, m_TargetCret) then m_wHitMode := 12;//龙影剑法 20100910 修改
              SKILL_74: if UseSpell(UserMagic, m_nCurrX, m_nCurrY, m_TargetCret) then m_wHitMode := 13;//逐日剑法 20100910 修改
              SKILL_96: if UseSpell(UserMagic, m_nCurrX, m_nCurrY, m_TargetCret) then m_wHitMode := 17;//血魄一击(战)
            end;
          end;
        end;
      end;
    end;
    nCode:= 9;
    Result := WarrAttackTarget1(m_wHitMode);
    nCode:= 10;
    if Result then m_dwHitTick := GetTickCount();
  except
    MainOutMessage(Format('{%s} TAIPlayObject.WarrorAttackTarget Code:%d',[g_sExceptionVer, nCode]));
  end;
end;

function TAIPlayObject.WizardAttackTarget1(): Boolean; {法师攻击}
var
  UserMagic: pTUserMagic;
  n14: Integer;
  nCode: Byte;
begin
  Result := False;
  nCode:= 0;
  try
    m_wHitMode := 0;
    SearchMagic(); //查询魔法
    if m_nSelectMagic = 0 then m_boIsUseMagic := True;//是否能躲避
    if m_nSelectMagic > 0 then begin
      if (m_TargetCret <> nil) then begin
        nCode:= 4;
        if not MagCanHitTarget(m_nCurrX, m_nCurrY, m_TargetCret) or
          ((abs(m_TargetCret.m_nCurrX - m_nCurrX) > 7) or
          (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 7)) then begin//魔法不能打到怪
          if (m_nSelectMagic <> 10) then begin//除疾光电影外
            GetGotoXY(m_TargetCret,3);//法只走向目标3格范围
            GotoTargetXY( m_nTargetX, m_nTargetY, 0);
          end;
        end;
        {//参考JS代码修改 20110703
        if ((GetTickCount - m_dwRunMagicIntervalTime) > g_Config.dwRunMagicIntervalTime) then begin
          m_dwRunMagicIntervalTime := GetTickCount;
          if ((abs(m_nCurrX - m_TargetCret.m_nCurrX) < 3) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) < 3)) or//目标近身
             ((abs(m_nCurrX - m_TargetCret.m_nCurrX) > 7) or (abs(m_nCurrY - m_TargetCret.m_nCurrY) > 7)) then begin
            n14 := GetNextDirection(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, m_nCurrX, m_nCurrY);
            m_PEnvir.GetNextPosition(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, n14, 5, m_nTargetX, m_nTargetY);
            if (m_nTargetX > 0) and (m_nTargetY > 0) then HeroTail;
            SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
          end;
        end;}
      end;
      nCode:= 5;
      UserMagic := FindMagic(m_nSelectMagic);
      if (UserMagic <> nil) then begin
        if (UserMagic.btKey = 0) then begin//技能打开状态才能使用
          m_dwHitTick := GetTickCount();
          Result := UseSpell(UserMagic, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, m_TargetCret); //使用魔法
          Exit;
        end;
      end;
    end;
    nCode:= 6;
    m_dwHitTick := GetTickCount();
    if g_Config.boHeroAttackTarget and (m_Abil.Level < 22) then begin//法师22级前是否物理攻击
      m_boIsUseMagic := False;//是否能躲避
      nCode:= 7;
      Result := WarrAttackTarget1(m_wHitMode);
    end;
  except
    MainOutMessage(Format('{%s} TAIPlayObject.WizardAttackTarget Code:%d',[g_sExceptionVer, nCode]));
  end;
end;

function TAIPlayObject.TaoistAttackTarget1(): Boolean; {道士攻击 20071218}
var
  UserMagic: pTUserMagic;
  n14: integer;
begin
  Result := False;
  try
    m_wHitMode := 0;
     if m_TargetCret <> nil then begin//20090507 增加
       if g_Config.boHeroAttackTao and (m_TargetCret.m_btRaceServer <> RC_PLAYOBJECT)
         and (m_TargetCret.m_btRaceServer <> RC_HEROOBJECT) then begin//22级砍血量的怪 20090108
         if (m_TargetCret.m_WAbil.MaxHP >= 700) then begin
           SearchMagic(); //查询魔法
         end else begin
           if (GetTickCount()- m_dwSearchMagic > 1300) then begin//20090108 增加查询魔法的间隔
             SearchMagic(); //查询魔法
             m_dwSearchMagic := GetTickCount();
           end else m_boIsUseAttackMagic := False;//可以走向目标
         end;
       end else SearchMagic(); //查询魔法
     end;
    if m_nSelectMagic = 0 then m_boIsUseMagic := True;//是否能躲避 20080715
    if m_nSelectMagic > 0 then begin
      if (m_TargetCret <> nil) then begin
        if (not MagCanHitTarget(m_nCurrX, m_nCurrY, m_TargetCret)) or ((abs(m_TargetCret.m_nCurrX - m_nCurrX) > 7) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 7)) then begin//魔法不能打到怪 20080420                //20090112
          if g_Config.boHeroAttackTao and (m_TargetCret.m_btRaceServer <> RC_PLAYOBJECT)
            and (m_TargetCret.m_btRaceServer <> RC_HEROOBJECT) then begin//22级砍血量的怪 20090108
            if (m_TargetCret.m_WAbil.MaxHP >= 700) then begin//20090106
              GetGotoXY(m_TargetCret, 3);//20080712 道只走向目标3格范围
              GotoTargetXY( m_nTargetX, m_nTargetY,0);
            end;
          end else begin
            GetGotoXY(m_TargetCret, 3);//道只走向目标3格范围
            GotoTargetXY( m_nTargetX, m_nTargetY,0);
          end;
        end;
        {//参考JS代码修改 20110703
        if ((GetTickCount - m_dwRunMagicIntervalTime) > g_Config.dwRunMagicIntervalTime) then begin
          m_dwRunMagicIntervalTime := GetTickCount;
          if ((abs(m_nCurrX - m_TargetCret.m_nCurrX) < 3) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) < 3)) or//目标近身
             ((abs(m_nCurrX - m_TargetCret.m_nCurrX) > 7) or (abs(m_nCurrY - m_TargetCret.m_nCurrY) > 7)) then begin
            n14 := GetNextDirection(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, m_nCurrX, m_nCurrY);
            m_PEnvir.GetNextPosition(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, n14, 5, m_nTargetX, m_nTargetY);
            if (m_nTargetX > 0) and (m_nTargetY > 0) then HeroTail;
            SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
          end;
        end;}
      end;

      case m_nSelectMagic of
         SKILL_HEALLING: begin //治愈术 20080426
            if (m_WAbil.HP <= Round(m_WAbil.MaxHP * 0.7)) then begin
               UserMagic := FindMagic(m_nSelectMagic);
               if (UserMagic <> nil) and (UserMagic.btKey = 0) then begin//技能打开状态才能使用
                 {Result :=}UseSpell(UserMagic, m_nCurrX, m_nCurrY, nil);
                 m_dwHitTick := GetTickCount();
                 if g_Config.boHeroAttackTao and (m_TargetCret.m_btRaceServer <> RC_PLAYOBJECT) and (m_TargetCret.m_btRaceServer <> RC_HEROOBJECT) then begin//22级砍血量的怪 20090108
                   if (m_TargetCret.m_WAbil.MaxHP >= 700) then begin//20090106
                     m_boIsUseMagic := True;//能躲避 20080916
                     Exit;
                   end else m_nSelectMagic:= 0;
                 end else begin
                   m_boIsUseMagic := True;//能躲避 20080916
                   Exit;
                 end;
               end;
            end;
          end;
        SKILL_BIGHEALLING: begin //群体治疗术  20080713
            if (m_WAbil.HP <= Round(m_WAbil.MaxHP * 0.7)) then begin
               UserMagic := FindMagic(m_nSelectMagic);
               if (UserMagic <> nil) and (UserMagic.btKey = 0) then begin//技能打开状态才能使用
                 {Result :=}UseSpell(UserMagic, m_nCurrX, m_nCurrY, self);
                 m_dwHitTick := GetTickCount();
                 if g_Config.boHeroAttackTao and (m_TargetCret.m_btRaceServer <> RC_PLAYOBJECT) and (m_TargetCret.m_btRaceServer <> RC_HEROOBJECT) then begin//22级砍血量的怪 20090108
                   if (m_TargetCret.m_WAbil.MaxHP >= 700) then begin//20090106
                     m_boIsUseMagic := True;//能躲避 20080916
                     Exit;
                   end else m_nSelectMagic:= 0;
                 end else begin
                   m_boIsUseMagic := True;//能躲避 20080916
                   Exit;
                 end;
               end;
            end;
          end;
        SKILL_FIRECHARM: begin//灵符火符,打不到目标时,移动 20080711
           if not MagCanHitTarget(m_nCurrX, m_nCurrY, m_TargetCret) then begin
              GetGotoXY(m_TargetCret,3);
              GotoTargetXY(m_nTargetX, m_nTargetY,1);
           end;
         end;
        SKILL_AMYOUNSUL{6},SKILL_93, SKILL_GROUPAMYOUNSUL{38}: begin //换毒
            if (m_TargetCret.m_wStatusTimeArr[POISON_DECHEALTH] = 0) and (GetUserItemList(2,1)>= 0) then begin//绿毒
              n_AmuletIndx:= 1;//20080412  绿毒标识
            end else
            if (m_TargetCret.m_wStatusTimeArr[POISON_DAMAGEARMOR] = 0) and (GetUserItemList(2,2)>= 0)  then  begin//红毒
              n_AmuletIndx:= 2;//20080412 红毒标识
            end;
          end;
        SKILL_CLOAK{18}, SKILL_BIGCLOAK {19}: begin //集体隐身术  隐身术
             UserMagic := FindMagic(m_nSelectMagic);
             if (UserMagic <> nil) and (UserMagic.btKey = 0) then begin//技能打开状态才能使用
               UseSpell(UserMagic, m_nCurrX, m_nCurrY, self);
               m_dwHitTick := GetTickCount();
               if g_Config.boHeroAttackTao and (m_TargetCret.m_btRaceServer <> RC_PLAYOBJECT) and (m_TargetCret.m_btRaceServer <> RC_HEROOBJECT) then begin//22级砍血量的怪 20090108
                 if (m_TargetCret.m_WAbil.MaxHP >= 700) then begin//20090106
                   m_boIsUseMagic := False;//能躲避 20080916
                   Exit;
                 end else m_nSelectMagic:= 0;
               end else begin
                 m_boIsUseMagic := False;//能躲避 20080916
                 Exit;
               end;
             end;
          end;
        SKILL_48,//气功波时，并进行躲避 20080828
        SKILL_SKELLETON,
        SKILL_SINSU,
        SKILL_50,
        SKILL_71,//召唤圣兽
        SKILL_72, SKILL_104,
        SKILL_73,
        SKILL_101,
        SKILL_102: begin
            UserMagic := FindMagic(m_nSelectMagic);
            if (UserMagic <> nil) and (UserMagic.btKey = 0) then begin
              {Result := }UseSpell(UserMagic, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, m_TargetCret); //使用魔法
              m_dwHitTick := GetTickCount();
              if g_Config.boHeroAttackTao and (m_TargetCret.m_btRaceServer <> RC_PLAYOBJECT) and (m_TargetCret.m_btRaceServer <> RC_HEROOBJECT) then begin//22级砍血量的怪 20090108
                if (m_TargetCret.m_WAbil.MaxHP >= 700) then begin//20090106
                  m_boIsUseMagic := True;//能躲避
                  Exit;
                end else m_nSelectMagic:= 0;
              end else begin
                m_boIsUseMagic := True;//能躲避
                Exit;
              end;
            end;
          end;
      end;
      UserMagic := FindMagic(m_nSelectMagic);
      if (UserMagic <> nil) then begin
        if (UserMagic.btKey = 0) then begin//技能打开状态才能使用 20080606
          m_dwHitTick := GetTickCount();//20080530
          Result := UseSpell(UserMagic, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, m_TargetCret); //使用魔法
          if (m_TargetCret.m_WAbil.MaxHP >= 700) or (not g_Config.boHeroAttackTao) then begin//20090106
            Exit;
          end;
        end;
      end;
    end;
    m_dwHitTick := GetTickCount();

    if (m_WAbil.HP <= Round(m_WAbil.MaxHP * 0.15)) then m_boIsUseMagic := True;//是否能躲避 20080715
    if (g_Config.boHeroAttackTarget and (m_Abil.Level < 22)) or                                                                                                                   //20090529 增加人形条件
      ((m_TargetCret.m_WAbil.MaxHP < 700) and g_Config.boHeroAttackTao and (m_TargetCret.m_btRaceServer <> RC_PLAYOBJECT) and (m_TargetCret.m_btRaceServer <> RC_HEROOBJECT) and (m_TargetCret.m_btRaceServer <> RC_PLAYMOSTER)) then begin//20090106 道士22级前是否物理攻击  怪等级小于英雄时
      if (abs(m_TargetCret.m_nCurrX - m_nCurrX) > 1) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 1) then begin//道走近目标砍 20090212
        GotoTargetXY( m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 0);
      end;
      m_boIsUseMagic := False;//是否能躲避
      Result := WarrAttackTarget1(m_wHitMode);
    end;
  except
    //MainOutMessage('{异常} TAIPlayObject.TaoistAttackTarget');
  end;
end;

function TAIPlayObject.AttackTarget(): Boolean;
var
  dwAttackTime: LongWord;
  nCode: byte;
begin
  Result := False;
  nCode:= 0;
  try
    if (m_TargetCret <> nil) then begin
      if InSafeZone then begin//英雄进入安全区内就不打PK目标
        if (m_TargetCret.m_btRaceServer = RC_PLAYOBJECT) or (m_TargetCret.m_btRaceServer = RC_HEROOBJECT) then begin
          m_TargetCret:= nil;
          {$IF M2Version = 1}
          HeroBatterStop;//英雄连击停止
          {$IFEND}
          Exit;
        end;
      end;
      if m_TargetCret = self then begin//防止英雄自己打自己
        m_TargetCret:= nil;
        Exit;
      end;
    end;
    nCode:= 2;
    m_dwTargetFocusTick := GetTickCount();
    if m_boDeath or m_boGhost then Exit;
    {$IF HEROVERSION = 1}
    if m_boAI and (m_TargetCret <> nil) and (m_MyHero <> nil) and
      (GetTickCount - m_dwHeroUseSpellTick > 12000) and
      (THeroObject(m_MyHero).m_nFirDragonPoint >= g_Config.nMaxFirDragonPoint) then begin//气槽满,自动使用合击
      {$IF M2Version = 1}if not THeroObject(m_MyHero).m_boUseBatter then begin{$IFEND}//英雄连击停止后才使用合击
        m_dwHeroUseSpellTick:= GetTickCount();//自动使用合击间隔
        ClientHeroUseSpell;
        m_boIsUseMagic := False;//是否能躲避
        Result := True;
        Exit;
      {$IF M2Version = 1}end;{$IFEND}
    end;
    {$IFEND}
    case m_btJob of
      0: begin
          if (GetTickCount - m_dwHitTick > g_Config.nAIWarrorAttackTime)then begin//20110418
            {$IF M2Version = 1}
            nCode:= 9;
            if HeroBatterAttackTarget then begin
              m_dwHitTick := GetTickCount();
              m_boIsUseMagic := False;//是否能躲避
              Result := True;
              Exit;
            end;
            {$IFEND}
            m_boIsUseMagic := False;//是否能躲避 20080714
            nCode:= 8;
            Result := WarrorAttackTarget1;
          end;
        end;
      1: begin
          nCode:= 4;
          if (GetTickCount - m_dwHitTick > g_Config.nAIWizardAttackTime){$IF M2Version = 1}or m_boUseBatter{$IFEND} then begin//连击也不受间隔控制 20100408
            nCode:= 41;
            m_dwHitTick := GetTickCount();
            m_boIsUseMagic := False;//是否能躲避
            {$IF M2Version = 1}
            nCode:= 10;
            if HeroBatterAttackTarget then begin
              Result := True;
              Exit;
            end;
            {$IFEND}
            nCode:= 7;
            Result := WizardAttackTarget1;
            m_nSelectMagic := 0;
            Exit;
          end;
          m_nSelectMagic := 0;
        end;
      2: begin
          if (GetTickCount - m_dwHitTick > g_Config.nAITaoistAttackTime){$IF M2Version = 1}or m_boUseBatter{$IFEND} then begin//连击也不受间隔控制 20100408
            m_dwHitTick := GetTickCount();
            m_boIsUseMagic := False;//是否能躲避
            {$IF M2Version = 1}
            nCode:= 11;
            if HeroBatterAttackTarget then begin
              Result := True;
              Exit;
            end;
            {$IFEND}
            nCode:= 6;
            Result := TaoistAttackTarget1;
            m_nSelectMagic := 0;
            Exit;
          end;
          m_nSelectMagic := 0;
        end;
    end;
  except
    MainOutMessage(Format('{%s} TAIPlayObject.AttackTarget Code:%d',[g_sExceptionVer, nCode]));
  end;
end;

function TAIPlayObject.CheckTargetXYCount(nX, nY, nRange: Integer): Integer;
var
  BaseObject: TBaseObject;
  I, nC, n10: Integer;
begin
  Result := 0;
  try
    n10 := nRange;
    if m_VisibleActors.Count > 0 then begin//20080630
      for I := 0 to m_VisibleActors.Count - 1 do begin
        BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
        if BaseObject <> nil then begin
          if not BaseObject.m_boDeath then begin
            if IsProperTarget(BaseObject) and (not BaseObject.m_boHideMode or m_boCoolEye) then begin
              nC := abs(nX - BaseObject.m_nCurrX) + abs(nY - BaseObject.m_nCurrY);
              if nC <= n10 then begin
                Inc(Result);
                //if Result > 2 then break;
              end;
            end;
          end;
        end;
      end;
    end;
  except
  end;
end;

//是否需要躲避
function TAIPlayObject.IsNeedAvoid(): Boolean;
var
  nCode: byte;
begin
  Result := False;
  nCode:= 0;
  try
    if ((GetTickCount - m_dwAutoAvoidTick) > 1100) and m_boIsUseMagic and (not m_boDeath) then begin   //血低于15%时,必定要躲 20080711
      if (m_btJob > 0) and ((m_nSelectMagic = 0) or (m_WAbil.HP <= Round(m_WAbil.MaxHP * 0.15))) then begin
        m_dwAutoAvoidTick := GetTickCount();
        nCode:= 1;
        if g_Config.boHeroAttackTarget and (m_Abil.Level < 22) then begin//22级前道法不躲避
          if (m_btJob = 1) then begin//法放魔法后要躲
            nCode:= 2;
            if CheckTargetXYCount(m_nCurrX, m_nCurrY, 4) > 0 then begin
              Result := True;
              Exit;
            end;
          end;
        end else begin
          nCode:= 3;
          case m_btJob of
            1:begin
               nCode:= 4;
               if CheckTargetXYCount(m_nCurrX, m_nCurrY, 4) > 0 then begin
                Result := True;
                Exit;
               end;
            end;
            2: begin
              nCode:= 5;
              if m_TargetCret <> nil then begin
                nCode:= 6;
                if g_Config.boHeroAttackTao and (m_TargetCret.m_btRaceServer <> RC_PLAYOBJECT) and (m_TargetCret.m_btRaceServer <> RC_HEROOBJECT) then begin//22级砍血量的怪 20090108
                  if (m_TargetCret.m_WAbil.MaxHP >= 700) then begin
                    if (CheckTargetXYCount(m_nCurrX, m_nCurrY, 4{3}) > 0) then begin
                      Result := True;
                      Exit;
                    end;
                  end;
                end else begin
                  nCode:= 7;
                  if (CheckTargetXYCount(m_nCurrX, m_nCurrY, 4{3}) > 0) then begin
                    Result := True;
                    Exit;
                  end;
                end;
              end else begin
                nCode:= 8;
                if (CheckTargetXYCount(m_nCurrX, m_nCurrY, 4{3}) > 0) then begin
                  Result := True;
                  Exit;
                end;
              end;
            end;
          end;//case
        end;
      end;
    end;
  except
    MainOutMessage(Format('{%s} TAIPlayObject.IsNeedAvoid Code:%d',[g_sExceptionVer, nCode]));
  end;
end;
{检测指定方向和范围内坐标的怪物数量}
function TAIPlayObject.CheckTargetXYCountOfDirection(nX, nY, nDir, nRange: Integer): Integer;
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
                  if (abs(nX - BaseObject.m_nCurrX) <= nRange) and ((BaseObject.m_nCurrY - nY) in [0..nRange]) then Inc(Result);
                end;
              DR_UPRIGHT: begin
                  if ((BaseObject.m_nCurrX - nX) in [0..nRange]) and ((BaseObject.m_nCurrY - nY) in [0..nRange]) then Inc(Result);
                end;
              DR_RIGHT: begin
                  if ((BaseObject.m_nCurrX - nX) in [0..nRange]) and (abs(nY - BaseObject.m_nCurrY) <= nRange) then Inc(Result);
                end;
              DR_DOWNRIGHT: begin
                  if ((BaseObject.m_nCurrX - nX) in [0..nRange]) and ((nY - BaseObject.m_nCurrY) in [0..nRange]) then Inc(Result);
                end;
              DR_DOWN: begin
                  if (abs(nX - BaseObject.m_nCurrX) <= nRange) and ((nY - BaseObject.m_nCurrY) in [0..nRange]) then Inc(Result);
                end;
              DR_DOWNLEFT: begin
                  if ((nX - BaseObject.m_nCurrX) in [0..nRange]) and ((nY - BaseObject.m_nCurrY) in [0..nRange]) then Inc(Result);
                end;
              DR_LEFT: begin
                  if ((nX - BaseObject.m_nCurrX) in [0..nRange]) and (abs(nY - BaseObject.m_nCurrY) <= nRange) then Inc(Result);
                end;
              DR_UPLEFT: begin
                  if ((nX - BaseObject.m_nCurrX) in [0..nRange]) and ((BaseObject.m_nCurrY - nY) in [0..nRange]) then Inc(Result);
                end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

function TAIPlayObject.AutoAvoid(): Boolean;
 //自动躲避
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
    Result := DR_DOWN;//南
    if n10 > m_nCurrX then begin
      Result := DR_RIGHT;//东
      if n14 > m_nCurrY then Result := DR_DOWNRIGHT;//东南向
      if n14 < m_nCurrY then Result := DR_UPRIGHT;//东北向
    end else begin
      if n10 < m_nCurrX then begin
        Result := DR_LEFT;//西
        if n14 > m_nCurrY then Result := DR_DOWNLEFT;//西南向
        if n14 < m_nCurrY then Result := DR_UPLEFT;//西北向
      end else begin
        if n14 > m_nCurrY then Result := DR_DOWN//南
        else if n14 < m_nCurrY then Result := DR_UP;//正北
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
        DR_UP: begin//北
            if m_PEnvir.CanWalk(nTargetX, nTargetY, False) and (CheckTargetXYCountOfDirection(nTargetX, nTargetY, nDir, 3) = 0) then begin
              Dec(nTargetY, 2);
              Result := True;
              Break;
            end else begin
              if n01 >= 8 then Break;
              Dec(nTargetY, 2);
              Inc(n01, 2);
              Continue;
            end;
          end;
        DR_UPRIGHT: begin//东北
            if m_PEnvir.CanWalk(nTargetX, nTargetY, False) and (CheckTargetXYCountOfDirection(nTargetX, nTargetY, nDir, 3) = 0) then begin
              Inc(nTargetX, 2);
              Dec(nTargetY, 2);
              Result := True;
              Break;
            end else begin
              if n01 >= 8 then Break;
              Inc(nTargetX, 2);
              Dec(nTargetY, 2);
              Inc(n01, 2);
              Continue;
            end;
          end; 
        DR_RIGHT: begin//东
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
        DR_DOWNRIGHT: begin//东南
            if m_PEnvir.CanWalk(nTargetX, nTargetY, False) and (CheckTargetXYCountOfDirection(nTargetX, nTargetY, nDir, 3) = 0) then begin
              Inc(nTargetX, 2);
              Inc(nTargetY, 2);
              Result := True;
              Break;
            end else begin
              if n01 >= 8 then Break;
              Inc(nTargetX, 2);
              Inc(nTargetY, 2);
              Inc(n01, 2);
              Continue;
            end;
          end;
        DR_DOWN: begin//南
            if m_PEnvir.CanWalk(nTargetX, nTargetY, False) and (CheckTargetXYCountOfDirection(nTargetX, nTargetY, nDir, 3) = 0) then begin
              Inc(nTargetY, 2);
              Result := True;
              Break;
            end else begin
              if n01 >= 8 then Break;
              Inc(nTargetY, 2);
              Inc(n01, 2);
              Continue;
            end;
          end;
        DR_DOWNLEFT: begin//西南
            if m_PEnvir.CanWalk(nTargetX, nTargetY,False) and (CheckTargetXYCountOfDirection(nTargetX, nTargetY, nDir, 3) = 0) then begin
              Dec(nTargetX, 2);
              Inc(nTargetY, 2);
              Result := True;
              Break;
            end else begin
              if n01 >= 8 then Break;
              Dec(nTargetX, 2);
              Inc(nTargetY, 2);
              Inc(n01, 2);
              Continue;
            end;
          end;
        DR_LEFT: begin//西
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
        DR_UPLEFT: begin//西北向
            if m_PEnvir.CanWalk(nTargetX, nTargetY, False) and (CheckTargetXYCountOfDirection(nTargetX, nTargetY, nDir, 3) = 0) then begin
              Dec(nTargetX, 2);
              Dec(nTargetY, 2);
              Result := True;
              Break;
            end else begin
              if n01 >= 8 then Break;
              Dec(nTargetX, 2);
              Dec(nTargetY, 2);
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
    Result := GetGotoXY(m_btLastDirection, nTargetX, nTargetY);
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
    m_btLastDirection := nDir; //m_btDirection;
  end;
var
  nTargetX: Integer;
  nTargetY: Integer;
  nDir: Integer;
begin
  Result := True;
  if (m_TargetCret <> nil) and not m_TargetCret.m_boDeath then begin
    nTargetX := m_nCurrX ;
    nTargetY := m_nCurrY ;
    nDir:= GetNextDirection(m_nCurrX,m_nCurrY,m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
    nDir:= GetBackDir(nDir);
    m_PEnvir.GetNextPosition(m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY,nDir,5,m_nTargetX,m_nTargetY);
    Result :=GotoTargetXY(m_nTargetX, m_nTargetY, 1);
  end;
end;
function TAIPlayObject.IsNeedGotoXY(): Boolean; //是否走向目标
var
  dwAttackTime: LongWord;
begin
  Result := False;
  if (m_TargetCret <> nil) and (GetTickCount - m_dwAutoAvoidTick > 1100) and
    ((not m_boIsUseAttackMagic) or (m_btJob = 0)) then begin
    if m_btJob > 0 then begin
        if (not m_boIsUseMagic) and ((abs(m_TargetCret.m_nCurrX - m_nCurrX) > {2}3)
          or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 3{2})) then begin//20081214修改
          Result := True;
          Exit;
        end;
        if ((g_Config.boHeroAttackTarget and (m_Abil.Level < 22)) or 
           (g_Config.boHeroAttackTao and (m_TargetCret.m_WAbil.MaxHP < 700) and
           (m_TargetCret.m_btRaceServer <> RC_PLAYOBJECT) and (m_TargetCret.m_btRaceServer <> RC_HEROOBJECT) and //20090112
           (m_btJob = 2))) and ((abs(m_TargetCret.m_nCurrX - m_nCurrX) > 1) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 1)) then begin//20081218 道法22前是否物理攻击 20090210 大于1格时才走向目标
          Result := True;
          Exit;
        end;
    end else begin
      case m_nSelectMagic of //20080501  增加
        SKILL_ERGUM, SKILL_89:begin//刺杀, 四级刺杀剑术
            if (AllowUseMagic(12) or AllowUseMagic(SKILL_89)) and (m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, 2, m_nTargetX, m_nTargetY)) then begin
              if ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=2)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=0)) or
                 ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=0)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=2)) or
                 ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=2)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=2)) then begin
                dwAttackTime := _MAX(0, Integer(g_Config.dwHeroWarrorAttackTime) - m_nHitSpeed * g_ClientConf.btItemSpeed); //防止负数出错
                if (GetTickCount - m_dwHitTick > dwAttackTime) then begin
                  m_wHitMode:= 4;//刺杀
                  if AllowUseMagic(SKILL_89) then m_wHitMode:= 15;//四级刺杀
                  m_dwTargetFocusTick := GetTickCount();
                  m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
                  Attack(m_TargetCret, m_btDirection);
                  BreakHolySeizeMode();
                  m_dwHitTick := GetTickCount();
                  Exit;
                end;
              end else begin//new
                if ((abs(m_TargetCret.m_nCurrX - m_nCurrX) > 1) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 1)) then begin
                  Result := True;
                  Exit;
                end;
              end;
            end;
            m_nSelectMagic:= 0;
            if AllowUseMagic(12) or AllowUseMagic(SKILL_89) then begin
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
        Skill_96: begin//血魄一击(战)
            if AllowUseMagic(Skill_96) and (m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, 2, m_nTargetX, m_nTargetY)) then begin
              if ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=2)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=0)) or
                 ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=0)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=2)) or
                 ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=2)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=2)) then begin
                dwAttackTime := _MAX(0, Integer(g_Config.dwHeroWarrorAttackTime) - m_nHitSpeed * g_ClientConf.btItemSpeed); //防止负数出错
                if (GetTickCount - m_dwHitTick > dwAttackTime) then begin
                  m_wHitMode:= 17;//刺杀
                  m_dwTargetFocusTick := GetTickCount();
                  m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
                  Attack(m_TargetCret, m_btDirection);
                  BreakHolySeizeMode();
                  m_dwHitTick := GetTickCount();
                  Exit;
                end;
              end else begin//new
                if ((abs(m_TargetCret.m_nCurrX - m_nCurrX) > 1) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 1)) then begin
                  Result := True;
                  Exit;
                end;
              end;
            end;
            m_nSelectMagic:= 0;
            if AllowUseMagic(12) or AllowUseMagic(Skill_96) then begin
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
        SKILL_74:begin//逐日剑法
            if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, 5, m_nTargetX, m_nTargetY) then begin
              if ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)<=4)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=0)) or
                 ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=0)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)<=4)) or
                 (((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=2)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=2)) or
                 ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=3)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=3))  or
                 ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=4)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=4))) then begin
                dwAttackTime := _MAX(0, Integer(g_Config.dwHeroWarrorAttackTime) - m_nHitSpeed * g_ClientConf.btItemSpeed); //防止负数出错
                if (GetTickCount - m_dwHitTick > dwAttackTime) then begin
                  m_wHitMode:= 13;
                  m_dwTargetFocusTick := GetTickCount();
                  m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
                  Attack(m_TargetCret, m_btDirection);
                  BreakHolySeizeMode();
                  m_dwHitTick := GetTickCount();
                  Exit;
                end;
              end else begin
                if AllowUseMagic(12) or AllowUseMagic(SKILL_89) then begin
                  if not (((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 2) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 0)) or
                      ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 1) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 0)) or
                      ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 1) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 1)) or
                      ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 2) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 2)) or
                      ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 0) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 1)) or
                      ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 0) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 2))) then begin
                    Result := True;
                    Exit;
                  end;
                  if ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 1) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 2)) or//20090303
                     ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 2) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 1)) then begin
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
            m_nSelectMagic:= 0;
            if AllowUseMagic(12) or AllowUseMagic(SKILL_89) then begin
              if not (((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 2) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 0)) or
                  ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 1) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 0)) or
                  ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 1) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 1)) or
                  ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 2) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 2)) or
                  ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 0) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 1)) or
                  ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 0) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 2))) then begin
                Result := True;
                Exit;
              end;
              if ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 1) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 2)) or//20090303
                 ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 2) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 1)) then begin
                Result := True;
                Exit;
              end;
            end else
            if (abs(m_TargetCret.m_nCurrX - m_nCurrX) > 1) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 1) then begin
              Result := True;
              Exit;
            end;
          end;
        43:begin//20080604 实现隔位放开天
          if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, 5, m_nTargetX, m_nTargetY) and (m_n42kill = 2) then begin
             if ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)<=4)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=0)) or
                ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=0)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)<=4)) or
                (((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=2)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=2)) or
                ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=3)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=3))  or
                ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=4)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=4))) then begin
                dwAttackTime := _MAX(0, Integer(g_Config.dwHeroWarrorAttackTime) - m_nHitSpeed * g_ClientConf.btItemSpeed); //防止负数出错
                if (GetTickCount - m_dwHitTick > dwAttackTime) then begin
                  m_wHitMode:= 9;
                  m_dwTargetFocusTick := GetTickCount();
                  m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
                  Attack(m_TargetCret, m_btDirection);
                  BreakHolySeizeMode();
                  m_dwHitTick := GetTickCount();
                  Exit;
                end;
             end else begin
               if AllowUseMagic(12) or AllowUseMagic(SKILL_89) then begin
                 if ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)<>2)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)<>0)) or
                    ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)<>0)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)<>2)) or
                    ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)<>2)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)<>2)) then begin
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
           m_nSelectMagic:= 0;
          if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, 2, m_nTargetX, m_nTargetY) and (m_n42kill in [1,2]) then begin
            if (Abs(m_nCurrX-m_TargetCret.m_nCurrX)=2)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=0) or
               (Abs(m_nCurrX-m_TargetCret.m_nCurrX)=0)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=2) or
               (Abs(m_nCurrX-m_TargetCret.m_nCurrX)=2)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=2) then begin
              dwAttackTime := _MAX(0, Integer(g_Config.dwHeroWarrorAttackTime) - m_nHitSpeed * g_ClientConf.btItemSpeed); //防止负数出错
              if (GetTickCount - m_dwHitTick > dwAttackTime) then begin
                m_wHitMode:= 9;
                m_dwTargetFocusTick := GetTickCount();
                m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
                Attack(m_TargetCret, m_btDirection);
                BreakHolySeizeMode();
                m_dwHitTick := GetTickCount();
                Exit;
              end
            end else begin
              if ((abs(m_TargetCret.m_nCurrX - m_nCurrX) > 1) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 1)) then begin
                Result := True;
                Exit;
              end;
            end;
          end;
          m_nSelectMagic:= 0;
          if AllowUseMagic(12) or AllowUseMagic(SKILL_89) then begin
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
        7, 25, 26, SKILL_90:begin
          if (abs(m_TargetCret.m_nCurrX - m_nCurrX) > 1) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 1) then begin
            Result := True;
            m_nSelectMagic:= 0;
            Exit;
          end;        
        end;
        else begin
          if AllowUseMagic(12) or AllowUseMagic(SKILL_89) then begin
            if not (((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 2) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 0)) or
                ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 1) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 0)) or
                ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 1) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 1)) or
                ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 2) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 2)) or
                ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 0) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 1)) or
                ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 0) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 2))) then begin 
              Result := True;
              Exit;
            end;
            if ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 1) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 2)) or//20090303 增加
               ((abs(m_TargetCret.m_nCurrX - m_nCurrX) = 2) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 1)) then begin
              Result := True;
              Exit;
            end;
          end else
          if (abs(m_TargetCret.m_nCurrX - m_nCurrX) > 1) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 1) then begin
            Result := True;
            Exit;
          end;
        end;
      end;//case m_nSelectMagic of
    end;
  end;
end;
//取刺杀位
function TAIPlayObject.GetGotoXY(BaseObject: TBaseObject; nCode:Byte): Boolean;
begin
  Result := False;
  Case nCode of
    2:begin//刺杀位
      if (m_nCurrX - 2 <= BaseObject.m_nCurrX) and
        (m_nCurrX + 2 >= BaseObject.m_nCurrX) and
        (m_nCurrY - 2 <= BaseObject.m_nCurrY) and
        (m_nCurrY + 2 >= BaseObject.m_nCurrY) and
        ((m_nCurrX <> BaseObject.m_nCurrX) or
        (m_nCurrY <> BaseObject.m_nCurrY)) then begin
        Result := True;
        if ((m_nCurrX - 2) = BaseObject.m_nCurrX) and (m_nCurrY = BaseObject.m_nCurrY) then begin
          m_nTargetX:= m_nCurrX - 2;
          m_nTargetY:= m_nCurrY;
          Exit;
        end;
        if ((m_nCurrX + 2) = BaseObject.m_nCurrX) and (m_nCurrY = BaseObject.m_nCurrY) then begin
          m_nTargetX:= m_nCurrX + 2;
          m_nTargetY:= m_nCurrY;
          Exit;
        end;
        if (m_nCurrX = BaseObject.m_nCurrX) and ((m_nCurrY - 2) = BaseObject.m_nCurrY) then begin
          m_nTargetX:= m_nCurrX ;
          m_nTargetY:= m_nCurrY - 2;
          Exit;
        end;
        if (m_nCurrX = BaseObject.m_nCurrX) and ((m_nCurrY + 2) = BaseObject.m_nCurrY) then begin
          m_nTargetX:= m_nCurrX ;
          m_nTargetY:= m_nCurrY + 2;
          Exit;
        end;
        if ((m_nCurrX - 2) = BaseObject.m_nCurrX) and ((m_nCurrY -2) = BaseObject.m_nCurrY) then begin
          m_nTargetX:= m_nCurrX - 2;
          m_nTargetY:= m_nCurrY - 2;
          Exit;
        end;
        if ((m_nCurrX + 2) = BaseObject.m_nCurrX) and ((m_nCurrY - 2) = BaseObject.m_nCurrY) then begin
          m_nTargetX:= m_nCurrX + 2;
          m_nTargetY:= m_nCurrY - 2;
          Exit;
        end;
        if ((m_nCurrX - 2) = BaseObject.m_nCurrX) and ((m_nCurrY + 2) = BaseObject.m_nCurrY) then begin
          m_nTargetX:= m_nCurrX - 2;
          m_nTargetY:= m_nCurrY + 2;
          Exit;
        end;
        if ((m_nCurrX + 2) = BaseObject.m_nCurrX) and ((m_nCurrY + 2) = BaseObject.m_nCurrY) then begin
          m_nTargetX:= m_nCurrX + 2;
          m_nTargetY:= m_nCurrY + 2;
          Exit;
        end;
      end;
    end;//2
    3:begin//3格
      if (m_nCurrX - 3 <= BaseObject.m_nCurrX) and
        (m_nCurrX + 3 >= BaseObject.m_nCurrX) and
        (m_nCurrY - 3 <= BaseObject.m_nCurrY) and
        (m_nCurrY + 3 >= BaseObject.m_nCurrY) and
        ((m_nCurrX <> BaseObject.m_nCurrX) or
        (m_nCurrY <> BaseObject.m_nCurrY)) then begin
        Result := True;
        if ((m_nCurrX - 3) = BaseObject.m_nCurrX) and (m_nCurrY = BaseObject.m_nCurrY) then begin
          m_nTargetX:= m_nCurrX - 3;
          m_nTargetY:= m_nCurrY;
          Exit;
        end;
        if ((m_nCurrX + 3) = BaseObject.m_nCurrX) and (m_nCurrY = BaseObject.m_nCurrY) then begin
          m_nTargetX:= m_nCurrX + 3;
          m_nTargetY:= m_nCurrY;
          Exit;
        end;
        if (m_nCurrX = BaseObject.m_nCurrX) and ((m_nCurrY - 3) = BaseObject.m_nCurrY) then begin
          m_nTargetX:= m_nCurrX ;
          m_nTargetY:= m_nCurrY - 3;
          Exit;
        end;
        if (m_nCurrX = BaseObject.m_nCurrX) and ((m_nCurrY + 3) = BaseObject.m_nCurrY) then begin
          m_nTargetX:= m_nCurrX ;
          m_nTargetY:= m_nCurrY + 3;
          Exit;
        end;
        if ((m_nCurrX - 3) = BaseObject.m_nCurrX) and ((m_nCurrY - 3) = BaseObject.m_nCurrY) then begin
          m_nTargetX:= m_nCurrX - 3;
          m_nTargetY:= m_nCurrY - 3;
          Exit;
        end;
        if ((m_nCurrX + 3) = BaseObject.m_nCurrX) and ((m_nCurrY - 3) = BaseObject.m_nCurrY) then begin
          m_nTargetX:= m_nCurrX + 3;
          m_nTargetY:= m_nCurrY - 3;
          Exit;
        end;
        if ((m_nCurrX - 3) = BaseObject.m_nCurrX) and ((m_nCurrY + 3) = BaseObject.m_nCurrY) then begin
          m_nTargetX:= m_nCurrX - 3;
          m_nTargetY:= m_nCurrY + 3;
          Exit;
        end;
        if ((m_nCurrX + 3) = BaseObject.m_nCurrX) and ((m_nCurrY + 3) = BaseObject.m_nCurrY) then begin
          m_nTargetX:= m_nCurrX + 3;
          m_nTargetY:= m_nCurrY + 3;
          Exit;
        end;
      end;
    end;//3
  end;//Case
end;
//跑到目标坐标
function TAIPlayObject.RunToTargetXY(nTargetX, nTargetY: Integer): Boolean;
var
  nDir, n10, n14: Integer;
begin
  Result := False;
  if m_boTransparent and (m_boHideMode) then m_wStatusTimeArr[STATE_TRANSPARENT ] := 1;//隐身,一动就显身
  if ((m_wStatusTimeArr[POISON_STONE] > 0) and (not g_ClientConf.boParalyCanSpell)) or
    (m_wStatusTimeArr[POISON_DONTMOVE] <> 0) or (m_wStatusTimeArr[POISON_LOCKSPELL{7}] <> 0)
    or (m_wStatusArrValue[23] <> 0) then Exit;//麻痹不能跑动 20090526
  if not m_boCanRun then Exit;//禁止跑,则退出
  if GetTickCount()- dwTick5F4 > m_dwRunIntervalTime then begin //跑步使用单独的变量计数
    n10 := nTargetX;
    n14 := nTargetY;
    nDir:= GetNextDirection(m_nCurrX , m_nCurrY, n10, n14);
    if not RunTo1(nDir, False, nTargetX, nTargetY) then begin
      Result := WalkToTargetXY(nTargetX, nTargetY);
      if Result then dwTick5F4 := GetTickCount();
    end else begin
      if (abs(nTargetX - m_nCurrX) <= 1) and (abs(nTargetY - m_nCurrY) <= 1) then begin
        Result := True;
        dwTick5F4 := GetTickCount();
      end;
    end;
  end;
end;
//走向目标
function TAIPlayObject.WalkToTargetXY(nTargetX, nTargetY: Integer): Boolean;
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
  if m_boTransparent and (m_boHideMode) then m_wStatusTimeArr[STATE_TRANSPARENT ] := 1;//隐身,一动就显身
  if ((m_wStatusTimeArr[POISON_STONE] <> 0) and (not g_ClientConf.boParalyCanSpell))
    or (m_wStatusTimeArr[POISON_DONTMOVE] <> 0) or (m_wStatusTimeArr[POISON_LOCKSPELL{7}] <> 0)
    or (m_wStatusArrValue[23] <> 0) then Exit;//麻痹不能跑动 20080915
  if (abs(nTargetX - m_nCurrX) > 1) or (abs(nTargetY - m_nCurrY) > 1) then begin
    if GetTickCount()- dwTick3F4 > m_dwWalkIntervalTime then begin //增加走间隔
      n10 := nTargetX;
      n14 := nTargetY;
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
      if (abs(nTargetX - m_nCurrX) <= 1) and (abs(nTargetY - m_nCurrY) <= 1) then begin
        Result := True;
        dwTick3F4 := GetTickCount();
      end;
      if not Result then begin
        n20 := Random(3);
        for I := DR_UP to DR_UPLEFT do begin
          if (nOldX = m_nCurrX) and (nOldY = m_nCurrY) then begin
            if n20 <> 0 then Inc(nDir)
            else if nDir > 0 then Dec(nDir)
            else nDir := DR_UPLEFT;
            if (nDir > DR_UPLEFT) then nDir := DR_UP;
            WalkTo(nDir, False);
            if (abs(nTargetX - m_nCurrX) <= 1) and (abs(nTargetY - m_nCurrY) <= 1) then begin
              Result := True;
              dwTick3F4 := GetTickCount();
              Break;
            end;
          end;
        end;
      end;
    end;
  end;
end;
function TAIPlayObject.GotoTargetXY(nTargetX, nTargetY, nCode: Integer): Boolean;
begin
  case nCode of
    0:begin//正常模式
      if (abs(m_nCurrX - nTargetX) > 2{1}) or (abs(m_nCurrY - nTargetY) > 2{1}) then begin
        if m_wStatusTimeArr[STATE_LOCKRUN] = 0 then begin
          Result := RunToTargetXY(nTargetX, nTargetY);
        end else begin
          Result := WalkToTargetXY2(nTargetX, nTargetY); //转向
        end;
      end else begin
        Result := WalkToTargetXY2(nTargetX, nTargetY); //转向
      end;
    end;//0
    1:begin//躲避模式
      if (abs(m_nCurrX - nTargetX) > 1) or (abs(m_nCurrY - nTargetY) > 1) then begin
        if m_wStatusTimeArr[STATE_LOCKRUN] = 0 then begin
          Result := RunToTargetXY(nTargetX, nTargetY);
        end else begin
          Result := WalkToTargetXY2(nTargetX, nTargetY); //转向
        end;
      end else begin
        Result := WalkToTargetXY2(nTargetX, nTargetY); //转向
      end;
    end;//1
  end;
end;
procedure TAIPlayObject.SearchMagic();
var
  UserMagic: pTUserMagic;
  nCode: Byte;
begin
  m_nSelectMagic:= 0;
  nCode:= 0;
  try
    m_nSelectMagic := SelectMagic1;
    nCode:= 1;
    if m_nSelectMagic > 0 then begin
      nCode:= 2;
      UserMagic := FindMagic(m_nSelectMagic);
      if UserMagic <> nil then begin
        nCode:= 3;
        m_boIsUseAttackMagic := IsUseAttackMagic{需要毒符的魔法};
      end else begin
        nCode:= 5;
        m_boIsUseAttackMagic := False;
      end;
    end else begin
      nCode:= 4;
      m_boIsUseAttackMagic := False;
    end;
  except
    MainOutMessage(Format('{%s} TAIPlayObject.SearchMagic Code:%d',[g_sExceptionVer, nCode]));
  end;
end;

function TAIPlayObject.SelectMagic1(): Integer;
begin
  Result := 0;
  case m_btJob of
    0: begin //战士
        if AllowUseMagic(68) and (GetTickCount - m_dwStatusArrTimeOutTick[4] > g_Config.nHPUpTick * 1000) and (m_wStatusArrValue[4] = 0) then begin//酒气护体 20080925
          if (m_Abil.WineDrinkValue >= Round(m_Abil.MaxAlcohol * g_Config.nMinDrinkValue68 / 100)) then begin//20090108 div改/
            Result := 68;
            Exit;
          end;
        end;
        {$IF M2Version <> 2}
        if (not m_boCanUerSkill101) and ((GetTickCount -  m_dwLatest101Tick) >= g_Config.nKill101UseTime * 1000) then begin//神龙附体
          if AllowUseMagic(SKILL_101) then begin
            m_dwLatest101Tick := GetTickCount();
            Result := SKILL_101;
            Exit;
          end;
        end;
        {if (not m_boCanUerSkill102) and ((GetTickCount -  m_dwLatest102Tick) >= g_Config.nKill102UseTime * 1000)
          and ((m_wStatusTimeArr[POISON_STONE] > 0) or UseMagicToSkill102Level3) then begin//唯我独尊
          if AllowUseMagic(SKILL_102) then begin
            m_dwLatest102Tick := GetTickCount();
            Result := SKILL_102;
            Exit;
          end;
        end; }
        {$IFEND}
        if (abs(m_TargetCret.m_nCurrX - m_nCurrX) < 3) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) < 3) and //20100927 增加两格才放血魄一击(战)
           ((GetTickCount - m_dwLatestBloodSoulTick) > g_Config.dwUseBloodSoulTick) then begin//血魄一击(战)
          if AllowUseMagic(SKILL_96) and ((GetTickCount - m_SkillUseTick[0]) > 3000) then begin
            m_SkillUseTick[0] := GetTickCount;
            Result := SKILL_96;
            Exit;
          end
        end;
        //远距离则用开天重击或是逐日剑法 20080603   20090115 加入
        if ((abs(m_TargetCret.m_nCurrX - m_nCurrX) >= 2) and (abs(m_TargetCret.m_nCurrX - m_nCurrX) < 5)) or
          ((abs(m_TargetCret.m_nCurrY - m_nCurrY) >= 2) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) < 5)) then begin
          if AllowUseMagic(SKILL_74) and ((GetTickCount - m_dwLatestDailyTick) > 12000{12 * 1000}) then begin //逐日剑法
            m_boDailySkill := True;
            Result := SKILL_74;
            Exit;
          end;
        end;

        if AllowUseMagic(43) and ((GetTickCount - m_dwLatest42Tick) > g_Config.nKill43UseTime * 1000) and (m_WAbil.HP <= Round(m_WAbil.MaxHP * (g_Config.nHeroSkill43HPRate /100))) then begin //开天斩  20090213
          m_bo42kill := True;
          Result := 43;
          if (Random(g_Config.n43KillHitRate) = 0) and (g_Config.btHeroSkillMode43 or (m_TargetCret.m_Abil.Level <= m_Abil.Level)) then begin//目标等级不高于自己,才使用重击 20080826
            m_n42kill := 2;//重击
          end else begin
            m_n42kill := 1;//轻击
          end;
          Exit;
        end;

        //刺杀位 20080603
        if (abs(m_TargetCret.m_nCurrX - m_nCurrX) = 2) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 2) then begin
          if AllowUseMagic(SKILL_89) then begin //四级刺杀剑术
            if not m_boUseThrusting then ThrustingOnOff(True);
            Result := SKILL_89;
            exit;
          end;
          if AllowUseMagic(12) then begin //英雄刺杀剑术
            if not m_boUseThrusting then ThrustingOnOff(True);
            Result := 12;
            exit;
          end;
        end;
        if AllowUseMagic(SKILL_74) and ((GetTickCount - m_dwLatestDailyTick) > 12000{12 * 1000}) then begin //逐日剑法 20080528
          m_boDailySkill := True;
          Result := SKILL_74;
          Exit;
        end;
        if AllowUseMagic(26) and ((GetTickCount - m_dwLatestFireHitTick) > 9000{9 * 1000}) then begin //烈火  20080112 修正
          m_boFireHitSkill := True;
          Result := 26;
          Exit;
        end;
        if AllowUseMagic(42) and (GetTickCount - m_dwLatest43Tick > g_Config.nKill42UseTime * 1000) then begin //龙影剑法 20080619
          m_bo43kill := True;
          Result := 42;
          Exit;
        end;

        if ((m_TargetCret.m_btRaceServer = RC_PLAYOBJECT) or (m_TargetCret.m_btRaceServer = RC_HEROOBJECT) or (m_TargetCret.m_Master <> nil))
         and (m_TargetCret.m_Abil.Level < m_Abil.Level) then begin //PK时,使用野蛮冲撞  20080826 血低于800时使用
          if AllowUseMagic(27) and ((GetTickCount - m_SkillUseTick[27]) >  10000{10 * 1000}) then begin //pk时如果对方等级比自己低就每隔一段时间用一次野蛮  20080203
            m_SkillUseTick[27] := GetTickCount;
            Result := 27;
            Exit;
          end
        end else begin //打怪使用 20080323
          if AllowUseMagic(27) and ((GetTickCount - m_SkillUseTick[27]) > 10000{10 * 1000})
           and (m_TargetCret.m_Abil.Level < m_Abil.Level) and (m_WAbil.HP <= Round(m_WAbil.MaxHP * 0.85)) then begin
             m_SkillUseTick[27] := GetTickCount;
             Result := 27;
             Exit;
          end;
        end;

        if (m_TargetCret.m_Master <> nil) then m_ExpHitter := m_TargetCret.m_Master;//20080924

        if CheckTargetXYCount1(m_nCurrX, m_nCurrY, 1) > 1 then begin //被怪物包围   //20080924
          case Random(3) of
            0:begin                                                                                                                                         //20080710 PK时不用狮子吼
                if AllowUseMagic(41) and (GetTickCount - m_SkillUseTick[41] >  10000{10 * 1000})
                  and (m_TargetCret.m_Abil.Level < m_Abil.Level) and
                  (((m_TargetCret.m_btRaceServer <> RC_PLAYOBJECT) and (m_TargetCret.m_btRaceServer <> RC_HEROOBJECT)) or g_Config.boGroupMbAttackPlayObject) and
                  (abs(m_TargetCret.m_nCurrX - m_nCurrX) <= 3) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) <= 3) then begin
                  m_SkillUseTick[41] := GetTickCount; //狮子吼
                  Result := 41;
                  Exit;
                end;
                if AllowUseMagic(7)  and ((GetTickCount - m_SkillUseTick[7]) >  10000{10 * 1000}) then begin //攻杀剑术 20071213
                  m_SkillUseTick[7]:= GetTickCount;
                  m_boPowerHit := True;//20080401 开启攻杀
                  Result := 7;
                  Exit;
                end;
                if AllowUseMagic(39) and (GetTickCount - m_SkillUseTick[39] >  10000{10 * 1000}) then begin
                   m_SkillUseTick[39] := GetTickCount; //英雄彻地钉
                   Result := 39;
                   Exit;
                end;
                if AllowUseMagic(SKILL_90) then begin//圆月弯刀(四级半月弯刀)
                  if CheckTargetXYCount2(SKILL_90) > 0 then begin
                    if not m_boUseHalfMoon then  HalfMoonOnOff(True, 1);
                    Result := SKILL_90;
                    exit;
                  end;
                end;
                if AllowUseMagic(SKILL_BANWOL) then begin //英雄半月弯刀
                  if CheckTargetXYCount2(SKILL_BANWOL) > 0 then begin
                    if not m_boUseHalfMoon then  HalfMoonOnOff(True, 0);
                    Result := SKILL_BANWOL;
                    exit;
                  end;
                end;
                if AllowUseMagic(40) then begin //英雄抱月刀法
                  if not m_boCrsHitkill then SkillCrsOnOff(True);
                  Result := 40;
                  exit;
                end;
                if AllowUseMagic(SKILL_89) then begin //四级刺杀剑术
                  if not m_boUseThrusting then ThrustingOnOff(True);
                  Result := SKILL_89;
                  exit;
                end;
                if AllowUseMagic(12) then begin //英雄刺杀剑术
                  if not m_boUseThrusting then ThrustingOnOff(True);
                  Result := 12;
                  exit;
                end;
              end;
            1:begin
                if AllowUseMagic(41) and (GetTickCount - m_SkillUseTick[41] >  10000{10 * 1000})
                  and (m_TargetCret.m_Abil.Level < m_Abil.Level) and
                  (((m_TargetCret.m_btRaceServer <> RC_PLAYOBJECT) and (m_TargetCret.m_btRaceServer <> RC_HEROOBJECT)) or g_Config.boGroupMbAttackPlayObject) and
                  (abs(m_TargetCret.m_nCurrX - m_nCurrX) <= 3) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) <= 3) then begin
                  m_SkillUseTick[41] := GetTickCount; //狮子吼
                  Result := 41;
                  Exit;
                end;
                if AllowUseMagic(7)  and ((GetTickCount - m_SkillUseTick[7]) >  10000{10 * 1000}) then begin //攻杀剑术 20071213
                  m_SkillUseTick[7]:= GetTickCount;
                  m_boPowerHit := True;//20080401 开启攻杀
                  Result := 7;
                  Exit;
                end;
                if AllowUseMagic(39) and (GetTickCount - m_SkillUseTick[39] >  10000{10 * 1000}) then begin
                   m_SkillUseTick[39] := GetTickCount; //英雄彻地钉
                   Result := 39;
                   Exit;
                end;
                if AllowUseMagic(40) then begin //英雄抱月刀法
                  if not m_boCrsHitkill then SkillCrsOnOff(True);
                  Result := 40;
                  exit;
                end;
                if AllowUseMagic(SKILL_90) then begin//圆月弯刀(四级半月弯刀)
                  if CheckTargetXYCount2(SKILL_90) > 0 then begin
                    if not m_boUseHalfMoon then  HalfMoonOnOff(True, 1);
                    Result := SKILL_90;
                    exit;
                  end;
                end;
                if AllowUseMagic(SKILL_BANWOL) then begin //英雄半月弯刀
                  if CheckTargetXYCount2(SKILL_BANWOL) > 0 then begin
                    if not m_boUseHalfMoon then HalfMoonOnOff(True, 0);
                    Result := SKILL_BANWOL;
                    exit;
                  end;
                end;
                if AllowUseMagic(SKILL_89) then begin //四级刺杀剑术
                  if not m_boUseThrusting then ThrustingOnOff(True);
                  Result := SKILL_89;
                  exit;
                end;
                if AllowUseMagic(12) then begin //英雄刺杀剑术
                  if not m_boUseThrusting then ThrustingOnOff(True);
                  Result := 12;
                  exit;
                end;
              end;
            2:begin
                if AllowUseMagic(41) and (GetTickCount - m_SkillUseTick[41] >  10000{10 * 1000})
                  and (m_TargetCret.m_Abil.Level < m_Abil.Level) and
                  (((m_TargetCret.m_btRaceServer <> RC_PLAYOBJECT) and (m_TargetCret.m_btRaceServer <> RC_HEROOBJECT)) or g_Config.boGroupMbAttackPlayObject) and
                  (abs(m_TargetCret.m_nCurrX - m_nCurrX) <= 3) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) <= 3) then begin
                  m_SkillUseTick[41] := GetTickCount; //狮子吼
                  Result := 41;
                  Exit;
                end;
                if AllowUseMagic(39) and (GetTickCount - m_SkillUseTick[39] > 10000{10 * 1000}) then begin
                   m_SkillUseTick[39] := GetTickCount; //英雄彻地钉
                   Result := 39;
                   Exit;
                end;
                if AllowUseMagic(7)  and ((GetTickCount - m_SkillUseTick[7]) > 10000{10 * 1000}) then begin //攻杀剑术 20071213
                  m_SkillUseTick[7] := GetTickCount;
                  m_boPowerHit := True;//20080401 开启攻杀
                  Result := 7;
                  Exit;
                end;
                if AllowUseMagic(40) then begin //英雄抱月刀法
                  if not m_boCrsHitkill then  SkillCrsOnOff(True);
                  Result := 40;
                  exit;
                end;
                if AllowUseMagic(SKILL_90) then begin//圆月弯刀(四级半月弯刀)
                  if CheckTargetXYCount2(SKILL_90) > 0 then begin
                    if not m_boUseHalfMoon then  HalfMoonOnOff(True, 1);
                    Result := SKILL_90;
                    exit;
                  end;
                end;
                if AllowUseMagic(SKILL_BANWOL) then begin //英雄半月弯刀
                  if CheckTargetXYCount2(SKILL_BANWOL) > 0 then begin
                    if not m_boUseHalfMoon then  HalfMoonOnOff(True, 0);
                    Result := SKILL_BANWOL;
                    exit;
                  end;
                end;
                if AllowUseMagic(SKILL_89) then begin //四级刺杀剑术
                  if not m_boUseThrusting then ThrustingOnOff(True);
                  Result := SKILL_89;
                  exit;
                end;
                if AllowUseMagic(12) then begin //英雄刺杀剑术
                  if not m_boUseThrusting then ThrustingOnOff(True);
                  Result := 12;
                  exit;
                end;
              end;
          end;
        end else begin
          if ((m_TargetCret.m_btRaceServer = RC_PLAYOBJECT) or (m_TargetCret.m_btRaceServer = RC_HEROOBJECT) or (m_TargetCret.m_Master <> nil)) and
           (CheckTargetXYCount1(m_nCurrX, m_nCurrY, 1) > 1) then begin//PK 20080915 身边超过2个目标才使用
            if AllowUseMagic(40) and (GetTickCount - m_SkillUseTick[40] > 3000) then begin //英雄抱月刀法
              m_SkillUseTick[40] := GetTickCount;
              if not m_boCrsHitkill then  SkillCrsOnOff(True);
              Result := 40;
              exit;
            end;
            if (GetTickCount - m_SkillUseTick[25] > 1500) then begin //英雄半月弯刀
              if AllowUseMagic(SKILL_90) then begin //圆月弯刀(四级半月弯刀)
                if CheckTargetXYCount2(SKILL_90) > 0 then begin
                  if not m_boUseHalfMoon then HalfMoonOnOff(True, 1);
                  m_SkillUseTick[25]:= GetTickCount;
                  Result := SKILL_90;
                  exit;
                end;
              end;
              if AllowUseMagic(SKILL_BANWOL) then begin //英雄半月弯刀
                if CheckTargetXYCount2(SKILL_BANWOL) > 0 then begin
                  m_SkillUseTick[25] := GetTickCount;
                  if not m_boUseHalfMoon then HalfMoonOnOff(True, 0);
                  Result := SKILL_BANWOL;
                  exit;
                end;
              end;
            end;
          end;
         //20071213增加 少于三个怪用 刺杀剑术
          if AllowUseMagic(7)  and ((GetTickCount - m_SkillUseTick[7]) >  10000{10 * 1000}) then begin //攻杀剑术
            m_SkillUseTick[7]:= GetTickCount;
            m_boPowerHit := True;//20080401 开启攻杀
            Result := 7;
            Exit;
          end;
          if (GetTickCount - m_SkillUseTick[12] > 1000) then begin
            if AllowUseMagic(SKILL_89) then begin //四级刺杀剑术
              if not m_boUseThrusting then ThrustingOnOff(True);
              m_SkillUseTick[12]:= GetTickCount;
              Result := SKILL_89;
              exit;
            end;
            if AllowUseMagic(12) then begin //英雄刺杀剑术
              if not m_boUseThrusting then ThrustingOnOff(True);
              m_SkillUseTick[12]:= GetTickCount;
              Result := 12;
              Exit;
            end;
          end;
        end;
         //从高到低使用魔法,20080710
        if AllowUseMagic(43) and (GetTickCount - m_dwLatest42Tick > g_Config.nKill43UseTime * 1000) and (m_WAbil.HP <= Round(m_WAbil.MaxHP * (g_Config.nHeroSkill43HPRate /100))) then begin //开天斩 20090213
          m_bo42kill := True;
          Result := 43;
          if (Random(g_Config.n43KillHitRate) = 0) and (g_Config.btHeroSkillMode43 or (m_TargetCret.m_Abil.Level <= m_Abil.Level)) then begin
           m_n42kill := 2;//重击
          end else begin
           m_n42kill := 1;//轻击
          end;
          Exit;
        end else
        if AllowUseMagic(42) and (GetTickCount - m_dwLatest43Tick > g_Config.nKill42UseTime * 1000) then begin //龙影剑法
          m_bo43kill := True;
          Result := 42;
          Exit;
        end else
        if AllowUseMagic(74) and (GetTickCount - m_dwLatestDailyTick > 12000) then begin //逐日剑法
          m_boDailySkill := True;
          Result := 74;
          Exit;
        end else
        if AllowUseMagic(26) and (GetTickCount - m_dwLatestFireHitTick > 9000) then begin //烈火
          m_boFireHitSkill := True;
          Result := 26;
          Exit;
        end;
        if AllowUseMagic(40) and (GetTickCount - m_SkillUseTick[40] > 3000) and (CheckTargetXYCount1(m_nCurrX, m_nCurrY, 1) > 1) then begin //英雄抱月刀法
          if not m_boCrsHitkill then SkillCrsOnOff(True);
          m_SkillUseTick[40]:= GetTickCount();
          Result := 40;
          exit;
        end;
        if AllowUseMagic(39) and (GetTickCount - m_SkillUseTick[39] > 3000) then begin//英雄彻地钉
           m_SkillUseTick[39]:= GetTickCount;
           Result := 39;
           Exit;
        end;
        if (GetTickCount - m_SkillUseTick[25] > 3000) then begin
          if AllowUseMagic(SKILL_90) then begin //圆月弯刀(四级半月弯刀)
            if not m_boUseHalfMoon then HalfMoonOnOff(True, 1);
            m_SkillUseTick[25]:= GetTickCount;
            Result := SKILL_90;
            exit;
          end;
          if AllowUseMagic(SKILL_BANWOL) then begin //英雄半月弯刀
            if not m_boUseHalfMoon then HalfMoonOnOff(True, 0);
            m_SkillUseTick[25]:= GetTickCount;
            Result := SKILL_BANWOL;
            exit;
          end;
        end;
        if (GetTickCount - m_SkillUseTick[12] > 3000) then begin
          if AllowUseMagic(SKILL_89) then begin //四级刺杀剑术
            if not m_boUseThrusting then ThrustingOnOff(True);
            m_SkillUseTick[12]:= GetTickCount;
            Result := SKILL_89;
            exit;
          end;
          if AllowUseMagic(12) then begin //英雄刺杀剑术
            if not m_boUseThrusting then ThrustingOnOff(True);
            m_SkillUseTick[12]:= GetTickCount;
            Result := 12;
            exit;
          end;
        end;
        if AllowUseMagic(7) and (GetTickCount - m_SkillUseTick[7] > 3000) then begin //攻杀剑术
          m_boPowerHit := True;
          m_SkillUseTick[7]:= GetTickCount;
          Result := 7;
          Exit;
        end;
        if ((m_TargetCret.m_btRaceServer = RC_PLAYOBJECT) or (m_TargetCret.m_btRaceServer = RC_HEROOBJECT) or (m_TargetCret.m_Master <> nil))
         and (m_TargetCret.m_Abil.Level < m_Abil.Level) and (m_WAbil.HP <= Round(m_WAbil.MaxHP * 0.6)) then begin //PK时,使用野蛮冲撞
          if AllowUseMagic(27) and (GetTickCount - m_SkillUseTick[27] > 3000) then begin
            m_SkillUseTick[27]:= GetTickCount;
            Result := 27;
            Exit;
          end
        end else begin //打怪使用 20080323
          if AllowUseMagic(27) and (m_TargetCret.m_Abil.Level < m_Abil.Level) and (m_WAbil.HP <= Round(m_WAbil.MaxHP * 0.6))
           and (GetTickCount - m_SkillUseTick[27] > 3000) then begin
             m_SkillUseTick[27]:= GetTickCount;
             Result := 27;
             Exit;
          end;
        end;
        if AllowUseMagic(41) and (GetTickCount - m_SkillUseTick[41] >  10000{10 * 1000})
          and (m_TargetCret.m_Abil.Level < m_Abil.Level) and
          (((m_TargetCret.m_btRaceServer <> RC_PLAYOBJECT) and (m_TargetCret.m_btRaceServer <> RC_HEROOBJECT)) or g_Config.boGroupMbAttackPlayObject) and
          (abs(m_TargetCret.m_nCurrX - m_nCurrX) <= 3) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) <= 3) then begin
          m_SkillUseTick[41] := GetTickCount; //狮子吼
          Result := 41;
          Exit;
        end;
      end;
    1: begin //法师
        //使用 魔法盾
        if (m_wStatusTimeArr[STATE_BUBBLEDEFENCEUP] = 0) and (not m_boAbilMagBubbleDefence) then begin
          if AllowUseMagic(66) then begin//4级魔法盾
            Result := 66;
            Exit;
          end;
          if AllowUseMagic(31) then begin
            Result := 31;
            Exit;
          end;
        end;
        //酒气护体 20080925
        if AllowUseMagic(68) and (GetTickCount - m_dwStatusArrTimeOutTick[4] > g_Config.nHPUpTick * 1000) and (m_wStatusArrValue[4] = 0) then begin//酒气护体 20080925
          if (m_Abil.WineDrinkValue >= Round(m_Abil.MaxAlcohol * g_Config.nMinDrinkValue68 / 100)) then begin//20090108 div改/
            Result := 68;
            Exit;
          end;
        end;
        //分身不存在,则使用分身术 20080206
        if (m_SlaveList.Count = 0) and AllowUseMagic(46) and ((GetTickCount - m_dwLatest46Tick) > g_Config.nCopyHumanTick * 1000)//召唤分身间隔
         and ((g_Config.btHeroSkillMode46) or (m_LastHiter<> nil) or (m_ExpHitter<> nil)) then begin
          if (m_WAbil.HP <= Round(m_WAbil.MaxHP * (g_Config.nHeroSkill46MaxHP_3 /100))) then begin
            Result := 46;
            Exit;
          end;
        end;
        {$IF M2Version <> 2}
        if (not m_boCanUerSkill101) and ((GetTickCount -  m_dwLatest101Tick) >= g_Config.nKill101UseTime * 1000) then begin//神龙附体
          if AllowUseMagic(SKILL_101) then begin
            m_dwLatest101Tick := GetTickCount();
            Result := SKILL_101;
            Exit;
          end;
        end;
        {if (not m_boCanUerSkill102) and ((GetTickCount -  m_dwLatest102Tick) >= g_Config.nKill102UseTime * 1000)
          and ((m_wStatusTimeArr[POISON_STONE] > 0) or UseMagicToSkill102Level3) then begin//唯我独尊
          if AllowUseMagic(SKILL_102) then begin
            m_dwLatest102Tick := GetTickCount();
            Result := SKILL_102;
            Exit;
          end;
        end;}
        {$IFEND}
        if (GetTickCount - m_dwLatestBloodSoulTick) > g_Config.dwUseBloodSoulTick then begin//血魄一击(法)
          if AllowUseMagic(SKILL_97) and ((GetTickCount - m_SkillUseTick[0]) > 3000) then begin
            m_SkillUseTick[0] := GetTickCount;
            Result := SKILL_97;
            Exit;
          end
        end;
        if ((m_TargetCret.m_btRaceServer = RC_PLAYOBJECT) or (m_TargetCret.m_btRaceServer = RC_HEROOBJECT) or (m_TargetCret.m_Master <> nil))
          and (CheckTargetXYCount3(m_nCurrX, m_nCurrY, 1, 0) > 0) and (m_TargetCret.m_WAbil.Level < m_WAbil.Level) then begin //PK时,旁边有人贴身,使用抗拒火环
          if AllowUseMagic(8) and ((GetTickCount - m_SkillUseTick[8]) > 3000{3 * 1000}) then begin
            m_SkillUseTick[8] := GetTickCount;
            Result := 8;
            Exit;
          end
        end else begin //打怪,怪级低于自己,并且有怪包围自己就用 抗拒火环
          if AllowUseMagic(8) and ((GetTickCount - m_SkillUseTick[8]) > 3000)
            and (CheckTargetXYCount3(m_nCurrX, m_nCurrY, 1, 0) > 0)
            and (m_TargetCret.m_WAbil.Level < m_WAbil.Level) then begin
             m_SkillUseTick[8] := GetTickCount;
             Result := 8;
             Exit;
          end;
        end;

        if AllowUseMagic(45) and (GetTickCount - m_SkillUseTick[45] > 3000) then begin
          m_SkillUseTick[45] := GetTickCount;
          Result := 45;//英雄灭天火
          Exit;
        end;

        if (GetTickCount - m_SkillUseTick[10] > 5000) and m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, 5, m_nTargetX, m_nTargetY) then begin
          if ((m_TargetCret.m_btRaceServer = RC_PLAYOBJECT) or (m_TargetCret.m_btRaceServer = RC_HEROOBJECT) or (m_TargetCret.m_Master <> nil))
           and (GetDirBaseObjectsCount(m_btDirection,5)> 0) and
          (((Abs(m_nCurrX-m_TargetCret.m_nCurrX)<=4) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)=0)) or
          ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=0) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)<=4)) or
          (((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=2) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)=2)) or
          ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=3) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)=3))  or
          ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=4) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)=4)))) then begin
            if AllowUseMagic(10) then begin
              m_SkillUseTick[10] := GetTickCount;
              Result := 10;//英雄疾光电影  20080421
              Exit;
            end else
            if AllowUseMagic(9) then begin
              m_SkillUseTick[10] := GetTickCount;
              Result := 9;//地狱火
              Exit;
            end;
          end else
          if (GetDirBaseObjectsCount(m_btDirection,5)> 1) and
          (((Abs(m_nCurrX-m_TargetCret.m_nCurrX)<=4) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)=0)) or
          ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=0) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)<=4)) or
          (((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=2) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)=2)) or
          ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=3) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)=3))  or
          ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=4) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)=4)))) then begin
            if AllowUseMagic(10) then begin
              m_SkillUseTick[10] := GetTickCount;
              Result := 10;//英雄疾光电影  20080421
              Exit;
            end else
            if AllowUseMagic(9) then begin
              m_SkillUseTick[10] := GetTickCount;
              Result := 9;//地狱火
              Exit;
            end;
          end;
        end;

        if AllowUseMagic(32) and (GetTickCount - m_SkillUseTick[32] > 10000) and
          (m_TargetCret.m_Abil.Level < g_Config.nMagTurnUndeadLevel) and
          (m_TargetCret.m_btLifeAttrib = LA_UNDEAD) and (m_TargetCret.m_WAbil.Level < m_WAbil.Level -1) then begin //目标为不死系
          m_SkillUseTick[32] := GetTickCount;
          Result := 32; //圣言术
          Exit;
        end;

        if CheckTargetXYCount(m_nCurrX, m_nCurrY, 2) > 1 then begin //被怪物包围    
          if AllowUseMagic(22) and (GetTickCount - m_SkillUseTick[22] > 10000) then begin
            if (m_TargetCret.m_btRaceServer <> 101) and (m_TargetCret.m_btRaceServer <> 102)
              and (m_TargetCret.m_btRaceServer <> 104) then begin//除祖玛怪,才放火墙 20081217
              m_SkillUseTick[22] := GetTickCount;
              Result := 22; //火墙
              Exit;
            end;
          end;
          //地狱雷光,只对祖玛(101,102,104)，沃玛(91,92,97)，野猪(81)系列的用   20080217
          //遇到祖玛的怪应该多用地狱雷光，夹杂雷电术，少用冰咆哮 20080228
          if m_TargetCret.m_btRaceServer in [91,92,97,101,102,104] then begin
            if AllowUseMagic(24) and (GetTickCount - m_SkillUseTick[24] > 4000{1000 * 4}) and (CheckTargetXYCount(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 3) > 2) then begin
              m_SkillUseTick[24] := GetTickCount;
              Result := 24; //地狱雷光
              Exit;
            end else
            if AllowUseMagic(91) then begin
              Result := 91; //四级雷电术
              Exit;
            end else
            if AllowUseMagic(11) then begin
              Result := 11; //英雄雷电术
              Exit;
            end else
            if AllowUseMagic(33) and (CheckTargetXYCount(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 2) > 2) then begin
              Result := 33; //英雄冰咆哮
              Exit;
            end else
            if (GetTickCount - m_SkillUseTick[58] > 1500) and (CheckTargetXYCount(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 3) > 2) then begin
              if AllowUseMagic(92) then begin
                m_SkillUseTick[58] := GetTickCount;
                Result := 92; //四级流星火雨
                Exit;
              end;
              if AllowUseMagic(58) then begin
                m_SkillUseTick[58] := GetTickCount;
                Result := 58; //流星火雨 20080528
                Exit;
              end;
            end;
          end;

          case Random(4) of //随机选择魔法
            0: begin
                //火球术,大火球,雷电术,爆裂火焰,英雄冰咆哮,流星火雨 从高到低选择
                if AllowUseMagic(92) and (GetTickCount - m_SkillUseTick[58] > 1500) and (CheckTargetXYCount(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 3) > 2) then begin
                  m_SkillUseTick[58] := GetTickCount;
                  Result := 92; //四级流星火雨
                  Exit;
                end else
                if AllowUseMagic(58) and (GetTickCount - m_SkillUseTick[58] > 1500) and (CheckTargetXYCount(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 3) > 2) then begin
                  m_SkillUseTick[58] := GetTickCount;
                  Result := 58; //流星火雨
                  Exit;
                end else
                if AllowUseMagic(33) and (CheckTargetXYCount(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 3) > 1) then begin
                  Result := 33; //英雄冰咆哮
                  Exit;
                end else
                if AllowUseMagic(23) and (CheckTargetXYCount(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 3) > 1) then begin
                  Result := 23; //爆裂火焰
                  Exit;
                end else
                if AllowUseMagic(91) then begin
                  Result := 91; //四级雷电术
                  Exit;
                end else
                if AllowUseMagic(11) then begin
                  Result := 11; //英雄雷电术
                  Exit;
                end else
                if AllowUseMagic(5) then begin
                  Result := 5;//大火球
                  Exit;
                end else
                if AllowUseMagic(1) then begin
                  Result := 1;//火球术
                  Exit;
                end;

                if AllowUseMagic(37) then begin
                  Result := 37; //英雄群体雷电
                  Exit;
                end;
                if AllowUseMagic(47) then begin
                  Result := 47;//火龙焰
                  Exit;
                end;
                if AllowUseMagic(44) then begin
                  Result := 44;//寒冰掌
                  Exit;
                end;
              end;
            1: begin
                if AllowUseMagic(37) then begin
                  Result := 37;
                  Exit;
                end;
                if AllowUseMagic(47) then begin
                  Result := 47;
                  Exit;
                end;
                if AllowUseMagic(44) then begin
                  Result := 44;//寒冰掌
                  Exit;
                end;

                if AllowUseMagic(92) and (GetTickCount - m_SkillUseTick[58] > 1500) and (CheckTargetXYCount(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 3) > 2) then begin
                  m_SkillUseTick[58] := GetTickCount;
                  Result := 92; //四级流星火雨
                  Exit;
                end else
                if AllowUseMagic(58) and (GetTickCount - m_SkillUseTick[58] > 1500) and (CheckTargetXYCount(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 3) > 2) then begin
                  m_SkillUseTick[58] := GetTickCount;
                  Result := 58; //流星火雨
                  Exit;
                end else
                if AllowUseMagic(33) and (CheckTargetXYCount(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 3) > 1) then begin//火球术,大火球,地狱火,爆裂火焰,冰咆哮  从高到低选择
                  Result := 33;//冰咆哮 
                  Exit;
                end else
                if AllowUseMagic(23) and (CheckTargetXYCount(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 3) > 1)  then begin
                  Result := 23; //爆裂火焰
                  Exit;
                end else
                if AllowUseMagic(91) then begin
                  Result := 91; //四级雷电术
                  Exit;
                end else
                if AllowUseMagic(11) then begin
                  Result := 11; //英雄雷电术
                  Exit;
                end else
                if AllowUseMagic(5) then begin
                  Result := 5;//大火球
                  Exit;
                end else
                if AllowUseMagic(1) then begin
                  Result := 1;//火球术
                  Exit;
                end;
              end;
            2:begin
                if AllowUseMagic(47) then begin
                  Result := 47;
                  Exit;
                end;
                if AllowUseMagic(44) then begin
                  Result := 44;//寒冰掌
                  Exit;
                end;

                if AllowUseMagic(92) and (GetTickCount - m_SkillUseTick[58] > 1500) and (CheckTargetXYCount(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 3) > 2) then begin
                  m_SkillUseTick[58]:= GetTickCount();
                  Result := 92; //四级流星火雨
                  Exit;
                end else
                if AllowUseMagic(58) and (GetTickCount - m_SkillUseTick[58] > 1500) and (CheckTargetXYCount(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 3) > 2) then begin
                  m_SkillUseTick[58]:= GetTickCount();
                  Result := 58; //流星火雨
                  Exit;
                end else
                if AllowUseMagic(33) and (CheckTargetXYCount(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 3) > 1) then begin  //火球术,大火球,地狱火,爆裂火焰 从高到低选择
                  Result := 33;
                  Exit;
                end else
                if AllowUseMagic(23) and (CheckTargetXYCount(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 3) > 1) then begin
                  Result := 23; //爆裂火焰
                  Exit;
                end else
                if AllowUseMagic(91) then begin
                  Result := 91; //四级雷电术
                  Exit;
                end else
                if AllowUseMagic(11) then begin
                  Result := 11; //英雄雷电术
                  Exit;
                end else
                if AllowUseMagic(5) then begin
                  Result := 5;//大火球
                  Exit;
                end else
                if AllowUseMagic(1) then begin
                  Result := 1;//火球术
                  Exit;
                end;

                if AllowUseMagic(37) then begin
                  Result := 37;
                  Exit;
                end;
              end;
            3: begin
                if AllowUseMagic(44) then begin
                  Result := 44;//寒冰掌
                  Exit;
                end;

                if AllowUseMagic(92) and (GetTickCount - m_SkillUseTick[58] > 1500) and (CheckTargetXYCount(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 3) > 2) then begin
                  m_SkillUseTick[58]:= GetTickCount();
                  Result := 92; //四级流星火雨
                  Exit;
                end else
                if AllowUseMagic(58) and (GetTickCount - m_SkillUseTick[58] > 1500) and (CheckTargetXYCount(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 3) > 2) then begin
                  m_SkillUseTick[58]:= GetTickCount();
                  Result := 58; //流星火雨
                  Exit;
                end else
                if AllowUseMagic(33) and (CheckTargetXYCount(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 3) > 1) then begin  //火球术,大火球,地狱火,爆裂火焰 从高到低选择
                  Result := 33;
                  Exit;
                end else
                if AllowUseMagic(23) and (CheckTargetXYCount(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 3) > 1) then begin
                  Result := 23; //爆裂火焰
                  Exit;
                end else
                if AllowUseMagic(91) then begin
                  Result := 91; //四级雷电术
                  Exit;
                end else
                if AllowUseMagic(11) then begin
                  Result := 11; //英雄雷电术
                  Exit;
                end else
                if AllowUseMagic(5) then begin
                  Result := 5;//大火球
                  Exit;
                end else
                if AllowUseMagic(1) then begin
                  Result := 1;//火球术
                  Exit;
                end;

                if AllowUseMagic(37) then begin
                  Result := 37;
                  Exit;
                end;
                if AllowUseMagic(47) then begin
                  Result := 47;
                  Exit;
                end;
              end;
          end;
        end else begin
         //只有一个怪时所用的魔法
           if AllowUseMagic(22) and (GetTickCount - m_SkillUseTick[22] > 10000) then begin
             if (m_TargetCret.m_btRaceServer <> 101) and (m_TargetCret.m_btRaceServer <> 102)
               and (m_TargetCret.m_btRaceServer <> 104) then begin//除祖玛怪,才放火墙
               m_SkillUseTick[22] := GetTickCount;
               Result := 22;
               Exit;
             end;
           end;
           case Random(4) of //随机选择魔法
             0:begin
                if AllowUseMagic(91) then begin
                  Result := 91; //四级雷电术
                  Exit;
                end else
                if AllowUseMagic(11) then begin
                  Result := 11;//雷电术
                  Exit;
                end else
                if AllowUseMagic(33) then begin
                  Result := 33;
                  Exit;
                end else
                if AllowUseMagic(23) then begin //火球术,大火球,地狱火,爆裂火焰 从高到低选择
                  Result := 23; //爆裂火焰
                  Exit;
                end else
                if AllowUseMagic(5) then begin
                  Result := 5;//大火球
                  Exit;
                end else
                if AllowUseMagic(1) then begin
                  Result := 1;//火球术
                  Exit;
                end;
                if AllowUseMagic(37) then begin
                  Result := 37;
                  Exit;
                end;
                if AllowUseMagic(47) then begin
                  Result := 47;
                  Exit;
                end;
                if AllowUseMagic(44) then begin
                  Result := 44;
                  Exit;
                end;
             end;
             1:begin
                if AllowUseMagic(37) then begin
                  Result := 37;
                  Exit;
                end;
                if AllowUseMagic(47) then begin
                  Result := 47;
                  Exit;
                end;
                if AllowUseMagic(44) then begin
                  Result := 44;
                  Exit;
                end;
                if AllowUseMagic(91) then begin
                  Result := 91; //四级雷电术
                  Exit;
                end else
                if AllowUseMagic(11) then begin
                  Result := 11;//雷电术
                  Exit;
                end else
                if AllowUseMagic(33) then begin
                  Result := 33;
                  Exit;
                end else
                if AllowUseMagic(23) then begin
                  Result := 23; //爆裂火焰
                  Exit;
                end else
                if AllowUseMagic(5) then begin
                  Result := 5;//大火球
                  Exit;
                end else
                if AllowUseMagic(1) then begin
                  Result := 1;//火球术
                  Exit;
                end;
             end;
             2:begin
                if AllowUseMagic(47) then begin
                  Result := 47;
                  Exit;
                end;
                if AllowUseMagic(44) then begin
                  Result := 44;
                  Exit;
                end;
                if AllowUseMagic(91) then begin
                  Result := 91; //四级雷电术
                  Exit;
                end else
                if AllowUseMagic(11) then begin
                  Result := 11;//雷电术
                  Exit;
                end else
                if AllowUseMagic(33) then begin
                  Result := 33;
                  Exit;
                end else
                if AllowUseMagic(23) then begin
                  Result := 23; //爆裂火焰
                  Exit;
                end else
                if AllowUseMagic(5) then begin
                  Result := 5;//大火球
                  Exit;
                end else
                if AllowUseMagic(1) then begin
                  Result := 1;//火球术
                  Exit;
                end;
                if AllowUseMagic(37) then begin
                  Result := 37;
                  Exit;
                end;
             end;
             3: begin
                if AllowUseMagic(44) then begin
                  Result := 44;
                  Exit;
                end;
                if AllowUseMagic(91) then begin
                  Result := 91; //四级雷电术
                  Exit;
                end else
                if AllowUseMagic(11) then begin
                  Result := 11;//雷电术
                  Exit;
                end else
                if AllowUseMagic(33) then begin
                  Result := 33;
                  Exit;
                end else
                if AllowUseMagic(23) then begin
                  Result := 23; //爆裂火焰
                  Exit;
                end else
                if AllowUseMagic(5) then begin
                  Result := 5;//大火球
                  Exit;
                end else
                if AllowUseMagic(1) then begin
                  Result := 1;//火球术
                  Exit;
                end;

                if AllowUseMagic(37) then begin
                  Result := 37;
                  Exit;
                end;
                if AllowUseMagic(47) then begin
                  Result := 47;
                  Exit;
                end;
             end;
           end;
        end;
      //从高到低使用魔法 20080710
        if (GetTickCount - m_SkillUseTick[58] > 1500) then begin
          if AllowUseMagic(92) then begin //四级流星火雨
            m_SkillUseTick[58]:= GetTickCount;
            Result := 92;
            Exit;
          end;
          if AllowUseMagic(58) then begin //流星火雨
            m_SkillUseTick[58]:= GetTickCount;
            Result := 58;
            Exit;
          end;
        end;
        if AllowUseMagic(47) then begin//火龙焰
          Result := 47;
          Exit;
        end;
        if AllowUseMagic(45) then begin//英雄灭天火
          Result := 45;
          Exit;
        end;
        if AllowUseMagic(44) then begin
          Result := 44;
          Exit;
        end;
        if AllowUseMagic(37) then begin//英雄群体雷电
          Result := 37;
          Exit;
        end;
        if AllowUseMagic(33) then begin//英雄冰咆哮
          Result := 33;
          Exit;
        end;
        if AllowUseMagic(32) and (m_TargetCret.m_Abil.Level < g_Config.nMagTurnUndeadLevel) and
          (m_TargetCret.m_btLifeAttrib = LA_UNDEAD) and (m_TargetCret.m_WAbil.Level < m_WAbil.Level -1) then begin //目标为不死系
          Result := 32; //圣言术
          Exit;
        end;
        if AllowUseMagic(24) and (CheckTargetXYCount(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 3) > 2) then begin//地狱雷光
          Result := 24;
          Exit;
        end;
        if AllowUseMagic(23) then begin//爆裂火焰
          Result := 23;
          Exit;
        end;
        if AllowUseMagic(91) then begin
          Result := 91; //四级雷电术
          Exit;
        end;
        if AllowUseMagic(11) then begin//英雄雷电术
          Result := 11;
          Exit;
        end;
        if AllowUseMagic(10) and m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, 5, m_nTargetX, m_nTargetY) and
          (((Abs(m_nCurrX-m_TargetCret.m_nCurrX)<=4) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)=0)) or
          ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=0) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)<=4)) or
          (((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=2) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)=2)) or
          ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=3) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)=3))  or
          ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=4) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)=4)))) then begin
          Result := 10;//英雄疾光电影
          Exit;
        end;
        if AllowUseMagic(9) and m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, 5, m_nTargetX, m_nTargetY) and
          (((Abs(m_nCurrX-m_TargetCret.m_nCurrX)<=4) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)=0)) or
          ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=0) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)<=4)) or
          (((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=2) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)=2)) or
          ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=3) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)=3))  or
          ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=4) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)=4)))) then begin
          Result := 9;//地狱火
          Exit;
        end;
        if AllowUseMagic(5) then begin
          Result := 5;//大火球
          Exit;
        end;
        if AllowUseMagic(1) then begin
          Result := 1;//火球术
          Exit;
        end;
        if AllowUseMagic(22) then begin
          if (m_TargetCret.m_btRaceServer <> 101) and (m_TargetCret.m_btRaceServer <> 102) and (m_TargetCret.m_btRaceServer <> 104) then begin//除祖玛怪,才放火墙 20081217
            Result := 22; //火墙
            Exit;
          end;
        end;
      end;
    2: begin //道士
        if (m_SlaveList.Count = 0) and CheckHeroAmulet(1,5) and (GetTickCount - m_SkillUseTick[17] > 3000) and
        (AllowUseMagic(72) or AllowUseMagic(30) or AllowUseMagic(17)) and (m_WAbil.MP > 20) then begin
          m_SkillUseTick[17]:= GetTickCount;
          //默认,从高到低
          if AllowUseMagic(104) then Result := 104//召唤火灵
          else if AllowUseMagic(72) then Result := 72//召唤月灵
          else if AllowUseMagic(30) then Result := 30//召唤神兽
          else if AllowUseMagic(17) then Result := 17;//召唤骷髅
          Exit;
        end;

        if (m_wStatusTimeArr[STATE_BUBBLEDEFENCEUP] = 0) and (not m_boAbilMagBubbleDefence) then begin
          if AllowUseMagic(73) then begin//道力盾 20080909
            Result := 73;
            Exit;
          end;
        end;

        //酒气护体 20080925
        if AllowUseMagic(68) and (GetTickCount - m_dwStatusArrTimeOutTick[4] > g_Config.nHPUpTick * 1000) and (m_wStatusArrValue[4] = 0) then begin//酒气护体 20080925
          if (m_Abil.WineDrinkValue >= Round(m_Abil.MaxAlcohol * g_Config.nMinDrinkValue68 / 100)) then begin//20090108 div改/
            Result := 68;
            Exit;
          end;
        end;
     {$IF M2Version <> 2}
      if (not m_boCanUerSkill101) and ((GetTickCount -  m_dwLatest101Tick) >= g_Config.nKill101UseTime * 1000) then begin//神龙附体
        if AllowUseMagic(SKILL_101) then begin
          m_dwLatest101Tick := GetTickCount();
          Result := SKILL_101;
          Exit;
        end;
      end;
      {if (not m_boCanUerSkill102) and ((GetTickCount -  m_dwLatest102Tick) >= g_Config.nKill102UseTime * 1000)
        and ((m_wStatusTimeArr[POISON_STONE] > 0) or UseMagicToSkill102Level3) then begin//唯我独尊
        if AllowUseMagic(SKILL_102) then begin
          m_dwLatest102Tick := GetTickCount();
          Result := SKILL_102;
          Exit;
        end;
      end; }
      {$IFEND}
      if (GetTickCount - m_dwLatestBloodSoulTick) > g_Config.dwUseBloodSoulTick then begin//血魄一击(道)
        if AllowUseMagic(SKILL_98) and ((GetTickCount - m_SkillUseTick[0]) > 3000) then begin
          m_SkillUseTick[0] := GetTickCount;
          Result := SKILL_98;
          Exit;
        end
      end;

      if ((m_TargetCret.m_btRaceServer = RC_PLAYOBJECT) or (m_TargetCret.m_btRaceServer = RC_HEROOBJECT) or (m_TargetCret.m_Master <> nil))
       and (CheckTargetXYCount3(m_nCurrX, m_nCurrY, 1, 0) > 0) and (m_TargetCret.m_WAbil.Level <= m_WAbil.Level) then begin //PK时,旁边有人贴身,使用气功波
        if AllowUseMagic(48) and ((GetTickCount - m_SkillUseTick[48]) > 3000{3 * 1000}) then begin
          m_SkillUseTick[48] := GetTickCount;
          Result := 48;
          Exit;
        end;
      end else begin //打怪,怪级低于自己,并且有怪包围自己就用 气功波
        if AllowUseMagic(48) and ((GetTickCount - m_SkillUseTick[48]) > 5000)//20090108 由3秒改到5秒
          and (CheckTargetXYCount3(m_nCurrX, m_nCurrY, 1, 0) > 0)
          and (m_TargetCret.m_WAbil.Level <= m_WAbil.Level)  then begin
           m_SkillUseTick[48] := GetTickCount;
           Result := 48;
           Exit;
        end;
      end;
      //无极真气 20091204 移动位置
      if AllowUseMagic(50) and (GetTickCount - m_SkillUseTick[50] > g_Config.nAbilityUpTick * 1000) and (m_wStatusArrValue[2]=0)
        and ((g_Config.btHeroSkillMode50) or (not g_Config.btHeroSkillMode50 and (m_TargetCret.m_Abil.HP >=700)) or ((m_TargetCret.m_btRaceServer = RC_PLAYOBJECT) or (m_TargetCret.m_btRaceServer = RC_HEROOBJECT) or (m_TargetCret.m_btRaceServer = RC_PLAYMOSTER))) then begin//20080827
        m_SkillUseTick[50] := GetTickCount;
        Result := 50;
        Exit;
      end;

      if (m_TargetCret.m_wStatusTimeArr[POISON_DECHEALTH] = 0) and (not m_TargetCret.m_boUnPosion) and (GetUserItemList(2,1)>= 0) //绿毒
        and ((g_Config.btHeroSkillMode) or (not g_Config.btHeroSkillMode and (m_TargetCret.m_Abil.HP >=700)) or ((m_TargetCret.m_btRaceServer = RC_PLAYOBJECT) or (m_TargetCret.m_btRaceServer = RC_HEROOBJECT) or (m_TargetCret.m_btRaceServer = RC_PLAYMOSTER)))
        and ((abs(m_TargetCret.m_nCurrX - m_nCurrX) < 7{4}) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) < 7{4}))
        and (not (m_TargetCret.m_btRaceServer in [55,79,109,110,111,128,143, 145, 147, 151, 153, 156..158])) then begin //对于血量超过800的怪用  修改距离 20080704 不毒城墙
        n_AmuletIndx:= 0;//20080413
        case Random(2) of
         0: begin
              if AllowUseMagic(38) and (GetTickCount - m_SkillUseTick[38] > 1000) then  begin
                if m_PEnvir <> nil then begin//判断地图是否禁用
                  if m_PEnvir.AllowMagics(SKILL_GROUPAMYOUNSUL, 1) then begin
                    m_SkillUseTick[38] := GetTickCount;
                    Result := SKILL_GROUPAMYOUNSUL;//英雄群体施毒
                    exit;
                  end;
                end;
              end else
              if (GetTickCount - m_SkillUseTick[6] > 1000) then begin
                if AllowUseMagic(SKILL_93) then begin
                  if m_PEnvir <> nil then begin//判断地图是否禁用
                    if m_PEnvir.AllowMagics(SKILL_93, 1) then begin
                      m_SkillUseTick[6] := GetTickCount;
                      Result := SKILL_93;//英雄四级施毒术
                      Exit;
                    end;
                  end;
                end else
                if AllowUseMagic(SKILL_AMYOUNSUL) then begin
                  if m_PEnvir <> nil then begin//判断地图是否禁用
                    if m_PEnvir.AllowMagics(SKILL_AMYOUNSUL, 1) then begin
                      m_SkillUseTick[6] := GetTickCount;
                      Result := SKILL_AMYOUNSUL;//英雄施毒术
                      Exit;
                    end;
                  end;
                end;
              end;
            end;
         1: begin
              if (GetTickCount - m_SkillUseTick[6] > 1000) then begin
                if AllowUseMagic(SKILL_93) then begin
                  if m_PEnvir <> nil then begin//判断地图是否禁用
                    if m_PEnvir.AllowMagics(SKILL_93, 1) then begin
                      m_SkillUseTick[6] := GetTickCount;
                      Result := SKILL_93;//英雄四级施毒术
                      Exit;
                    end;
                  end;
                end else
                if AllowUseMagic(SKILL_AMYOUNSUL) then begin
                  if m_PEnvir <> nil then begin//判断地图是否禁用
                    if m_PEnvir.AllowMagics(SKILL_AMYOUNSUL, 1) then begin
                      m_SkillUseTick[6] := GetTickCount;
                      Result := SKILL_AMYOUNSUL;//英雄施毒术
                      Exit;
                    end;
                  end;
                end;
              end;
            end;
        end;
      end;
      if (m_TargetCret.m_wStatusTimeArr[POISON_DAMAGEARMOR] = 0) and (not m_TargetCret.m_boUnPosion) and (GetUserItemList(2,2)>= 0) //红毒
        and ((g_Config.btHeroSkillMode) or (not g_Config.btHeroSkillMode and (m_TargetCret.m_Abil.HP >= 700)) or ((m_TargetCret.m_btRaceServer = RC_PLAYOBJECT) or (m_TargetCret.m_btRaceServer = RC_HEROOBJECT) or (m_TargetCret.m_btRaceServer = RC_PLAYMOSTER)))
        and ((abs(m_TargetCret.m_nCurrX - m_nCurrX) < 7{4}) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) < 7{4}))
        and (not (m_TargetCret.m_btRaceServer in [55,79,109,110,111,128,143, 145, 147, 151, 153, 156..158])) then begin //对于血量超过100的怪用 不毒城墙
        n_AmuletIndx:= 0;//20080413
        case Random(2) of
         0: begin
              if AllowUseMagic(38) and (GetTickCount - m_SkillUseTick[38] > 1000) then  begin
                if m_PEnvir <> nil then begin//判断地图是否禁用
                  if m_PEnvir.AllowMagics(SKILL_GROUPAMYOUNSUL, 1) then begin
                    m_SkillUseTick[38] := GetTickCount;
                    Result := SKILL_GROUPAMYOUNSUL;//英雄群体施毒
                    exit;
                  end;
                end;
              end else
              if (GetTickCount - m_SkillUseTick[6] > 1000) then begin
                if AllowUseMagic(SKILL_93) then begin
                  if m_PEnvir <> nil then begin//判断地图是否禁用
                    if m_PEnvir.AllowMagics(SKILL_93, 1) then begin
                      m_SkillUseTick[6] := GetTickCount;
                      Result := SKILL_93;//英雄四级施毒术
                      Exit;
                    end;
                  end;
                end else
                if AllowUseMagic(SKILL_AMYOUNSUL) then begin
                  if m_PEnvir <> nil then begin//判断地图是否禁用
                    if m_PEnvir.AllowMagics(SKILL_AMYOUNSUL, 1) then begin
                      m_SkillUseTick[6] := GetTickCount;
                      Result := SKILL_AMYOUNSUL;//英雄施毒术
                      Exit;
                    end;
                  end;
                end;
              end;
            end;
         1: begin
              if (GetTickCount - m_SkillUseTick[6] > 1000) then begin
                if AllowUseMagic(SKILL_93) then begin
                  if m_PEnvir <> nil then begin//判断地图是否禁用
                    if m_PEnvir.AllowMagics(SKILL_93, 1) then begin
                      m_SkillUseTick[6] := GetTickCount;
                      Result := SKILL_93;//英雄四级施毒术
                      Exit;
                    end;
                  end;
                end else
                if AllowUseMagic(SKILL_AMYOUNSUL) then begin
                  if m_PEnvir <> nil then begin//判断地图是否禁用
                    if m_PEnvir.AllowMagics(SKILL_AMYOUNSUL, 1) then begin
                      m_SkillUseTick[6] := GetTickCount;
                      Result := SKILL_AMYOUNSUL;//英雄施毒术
                      Exit;
                    end;
                  end;
                end;
              end;
            end;
        end;
      end;
    //end;
      if AllowUseMagic(51) and (GetTickCount - m_SkillUseTick[51] > 5000) then begin//英雄飓风破 20080917
        m_SkillUseTick[51] := GetTickCount;
        Result := 51;
        exit;
      end;
      if CheckHeroAmulet(1,1) then begin//使用符的魔法
        case Random(3) of
          0:begin
            if AllowUseMagic(94) then begin
              Result := 94; //英雄四级噬血术
              exit;
            end;
            if AllowUseMagic(59) then begin
              Result := 59; //英雄噬血术
              exit;
            end;
            if AllowUseMagic(13) and (GetTickCount - m_SkillUseTick[13] > 3000{1000}) then begin//20090106
              Result := 13; //英雄灵魂火符
              m_SkillUseTick[13]:= GetTickCount;//20080714
              exit;
            end;
            if AllowUseMagic(52) and (m_TargetCret.m_wStatusArrValue[m_TargetCret.m_btJob + 6] = 0) then begin //诅咒术 20090403 +6
              Result := 52; //英雄诅咒术
              Exit;
            end;
          end;
          1:begin
            if AllowUseMagic(52) and (m_TargetCret.m_wStatusArrValue[m_TargetCret.m_btJob + 6] = 0) then begin//诅咒术 20090403 +6
              Result := 52;
              Exit;
            end;
            if AllowUseMagic(94) then begin
              Result := 94; //英雄四级噬血术
              exit;
            end;            
            if AllowUseMagic(59) then begin
              Result := 59; //英雄噬血术
              exit;
            end;
            if AllowUseMagic(13) and (GetTickCount - m_SkillUseTick[13] > 3000{1000}) then begin //20080401修改判断符的方法 //20090106
              Result := 13; //英雄灵魂火符
              m_SkillUseTick[13]:= GetTickCount;//20080714
              exit;
            end;
          end;//1
          2:begin
            if AllowUseMagic(13) and (GetTickCount - m_SkillUseTick[13] > 3000{1000}) then begin//20090106
              Result := 13; //英雄灵魂火符
              m_SkillUseTick[13]:= GetTickCount;//20080714
              exit;
            end;
            if AllowUseMagic(94) then begin
              Result := 94; //英雄四级噬血术
              exit;
            end;
            if AllowUseMagic(59) then begin
              Result := 59; //英雄噬血术
              exit;
            end;
            if AllowUseMagic(52) and (m_TargetCret.m_wStatusArrValue[m_TargetCret.m_btJob + 6] = 0) then begin //诅咒术  20090403 +6
              Result := 52;
              Exit;
            end;
          end;//2
        end;//case Random(3) of 道
        //技能从高到低选择 20080710
        if AllowUseMagic(94) then begin
          Result := 94; //英雄四级噬血术
          exit;
        end;
        if AllowUseMagic(59) then begin//英雄噬血术
          Result := 59;
          exit;
        end;
        if AllowUseMagic(54) then begin//英雄骷髅咒 20080917
          Result := 54;
          exit;
        end;
        if AllowUseMagic(53) then begin//英雄血咒 20080917
          Result := 53;
          exit;
        end;
        if AllowUseMagic(51) then begin//英雄飓风破 20080917
          Result := 51;
          exit;
        end;
        if AllowUseMagic(13) then begin//英雄灵魂火符
          Result := 13;
          exit;
        end;
        if AllowUseMagic(52) and (m_TargetCret.m_wStatusArrValue[m_TargetCret.m_btJob + 6] = 0) then begin //诅咒术 20090403 +6
          Result := 52;
          Exit;
        end;
      end;
    end;//道士
  end;//case 职业
end;
//战士判断使用
function TAIPlayObject.CheckTargetXYCount1(nX, nY, nRange: Integer): Integer;
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
          if IsProperTarget(BaseObject) and
            (not BaseObject.m_boHideMode or m_boCoolEye) then begin
            if (abs(nX - BaseObject.m_nCurrX) <= n10) and (abs(nY - BaseObject.m_nCurrY) <= n10) then begin
              Inc(Result);
            end;
          end;
        end;
      end;
    end;
  end;
end;
//半月弯刀判断目标函数
function TAIPlayObject.CheckTargetXYCount2(nMode: Word): Integer;
var
  nC, n10, I: Integer;
  nX, nY: Integer;
  BaseObject: TBaseObject;
begin
  Result := 0;
  nC := 0;
  if m_VisibleActors.Count > 0 then begin
    for I := 0 to m_VisibleActors.Count - 1 do begin
      case nMode of
        SKILL_BANWOL: n10 := (m_btDirection + g_Config.WideAttack[nC]) mod 8;
        SKILL_90: n10 := (m_btDirection + g_Config.CrsAttack[nC]) mod 8;
      end;
      if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, n10, 1, nX, nY) then begin
        BaseObject := m_PEnvir.GetMovingObject(nX, nY, True);
        if BaseObject <> nil then begin
          if not BaseObject.m_boDeath then begin
            if IsProperTarget(BaseObject) and (not BaseObject.m_boHideMode or m_boCoolEye) then begin
              Inc(Result);
            end;
          end;
        end;
      end;
      Inc(nC);
      case nMode of
        SKILL_BANWOL: if nC >= 3 then Break;
        SKILL_90: if nC >= 7 then Break;
      end;
    end;
  end;
end;
//气功波，抗拒火环使用
function TAIPlayObject.CheckTargetXYCount3(nX, nY, nRange, nCount: Integer): Integer;
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
//参数 nType 为指定类型 1 为护身符 2 为毒药    nCount 为持久,即数量
Function TAIPlayObject.CheckHeroAmulet(nType: Integer; nCount: Integer):Boolean;
var
  I: Integer;
  UserItem: pTUserItem;
  AmuletStdItem: pTStdItem;
begin
  try
    Result:= False;
    if m_UseItems[U_ARMRINGL].wIndex > 0 then begin
      AmuletStdItem := UserEngine.GetStdItem(m_UseItems[U_ARMRINGL].wIndex);
      if (AmuletStdItem <> nil) then begin
        if (AmuletStdItem.StdMode = 25) then begin
          case nType of
            1: begin
                if (AmuletStdItem.Shape = 5) and (Round(m_UseItems[U_ARMRINGL].Dura / 100) >= nCount) then begin
                  Result:= True;
                  Exit;
                end;
              end;
            2: begin
                if (AmuletStdItem.Shape <= 2) and (Round(m_UseItems[U_ARMRINGL].Dura / 100) >= nCount) then begin
                  Result:= True;
                  Exit;
                end;
              end;
          end;
        end;
      end;
    end;

    if m_UseItems[U_BUJUK].wIndex > 0 then begin
      AmuletStdItem := UserEngine.GetStdItem(m_UseItems[U_BUJUK].wIndex);
      if (AmuletStdItem <> nil) then begin
        if (AmuletStdItem.StdMode = 25) then begin
          case nType of //
            1: begin//符
                if (AmuletStdItem.Shape = 5) and (Round(m_UseItems[U_BUJUK].Dura / 100) >= nCount) then begin
                  Result:= True;
                  Exit;
                end;
              end;
            2: begin//毒
                if (AmuletStdItem.Shape <= 2) and (Round(m_UseItems[U_BUJUK].Dura / 100) >= nCount) then begin
                  Result:= True;
                  Exit;
                end;
              end;
          end;
        end;
      end;
    end;

    //检测人物包裹是否存在毒,护身符
    if m_ItemList.Count > 0 then begin//20080628
      for I := 0 to m_ItemList.Count - 1 do begin //人物包裹不为空
        UserItem := m_ItemList.Items[I];
        if UserItem <> nil then begin
          AmuletStdItem := UserEngine.GetStdItem(UserItem.wIndex);
          if (AmuletStdItem <> nil) then begin
            if (AmuletStdItem.StdMode = 25) then begin
              case nType of
                1: begin
                    if (AmuletStdItem.Shape = 5) and (Round(UserItem.Dura / 100) >= nCount) then begin  //20071227
                      Result:= True;
                      Exit;
                    end;
                  end;
                2: begin
                    if (AmuletStdItem.Shape <= 2) and (Round(UserItem.Dura / 100) >= nCount) then begin
                      Result:= True;
                      Exit;
                    end;
                  end;
              end;//case
            end;
          end;
        end;
      end;
    end;
  except
    on E: Exception do begin
      MainOutMessage(Format('{%s} TAIPlayObject.CheckHeroAmulet',[g_sExceptionVer]));
    end;
  end;
end;
end.
