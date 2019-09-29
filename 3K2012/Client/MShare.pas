unit MShare;

interface
uses
  Windows, SysUtils, Classes, cliutil, DXDraws, DWinCtl,
  WIL, UiWil, Actor, Grobal2, DXSounds, IniFiles, Share,Graphics, Rc6, Mars, StrUtils, CnHashTable;
type
//自身信息记录
  TRecinfo = record
    GameSky: string[100];
    GameGhost: string[100];
    GameSdo: string[100];
    GameTwe: string[100];
    GameDraw: string[100];
    GameWT: string[100];
    GameZH: string[100];
    GameWW: string[100];
  end;
  {TClientEffecItem = record
    ClientItem: TClientItem;
    ClientEffec:TEffecItem;
  end;
  pTClientEffectItem = ^TClientEffecItem;}

  TTimerCommand = (tcSoftClose, tcReSelConnect, tcFastQueryChr, tcQueryItemPrice);
  TChrAction = (caWalk, caRun, caHorseRun, caHit, caSpell, caSitdown);
  TConnectionStep = (cnsLogin, cnsSelChr, cnsReSelChr, cnsPlay);
//TItemType = (i_All, i_HPDurg,i_MPDurg,i_HPMPDurg,i_OtherDurg,i_Weapon,i_Dress,i_Helmet,i_Necklace,i_Armring,i_Ring,i_Belt,i_Boots,i_Charm,i_Book,i_PosionDurg,i_UseItem,i_Scroll,i_Stone,i_Gold,i_Other);
                              //  [药品] [武器]      [衣服]    [头盔][项链]     [手镯]      [戒指] [腰带] [鞋子] [宝石]         [技能书][毒药]        [消耗品][其它]
  TItemType = (i_All, i_Other, i_HPMPDurg, i_Dress, i_Weapon, i_Jewelry, i_Decoration, i_Decorate);

  TMovingItem = record
    Index: integer;
    Item: TClientItem;
  end;
  pTMovingItem = ^TMovingItem;
  {TControlInfo = record
    Image       :Integer;
    Left        :Integer;
    Top         :Integer;
    Width       :Integer;
    Height      :Integer;
    Obj         :TDControl;
  end;  }
  TShowItem1 = record
    ItemType: TItemType;
    sItemName: string;
    sItemType: string;
    boHintMsg: Boolean;
    boPickup: Boolean;
    boShowName: Boolean;
  end;
  pTShowItem1 = ^TShowItem1;
  TMapDesc = record
    sMapName: string; //当前地图
    sMainMapName: string;//小地图名称
    m_nMapX: Integer; //所在座标X(4字节)
    m_nMapY: Integer; //所在座标Y(4字节)
    btColor: TColor; //名字的颜色
    boMaxMap: Boolean;
  end;
  pMapDesc = ^TMapDesc;

  TConfig = record
    boAutoPuckUpItem: Boolean;
    boNoShift: Boolean;
    boExpFiltrate: Boolean; //20080714
    boShowMimiMapDesc: Boolean;
    boShowHeroStateNumber : Boolean;
    boShowName: Boolean;
    boDuraWarning: Boolean;
    boLongHit: Boolean;
    boPosLongHit: Boolean;
    boAutoWideHit: Boolean;
    boAutoFireHit: Boolean;
    boAutoZhuriHit: Boolean;
    boAutoShield: Boolean;
    boHeroAutoShield: Boolean;
    boShowSpecialDamage: Boolean;
    boAutoDragInBody: Boolean;
    boHideHumanWing: Boolean;
    boHideWeaponEffect: Boolean;
    boAutoHide: Boolean;
    boAutoMagic: Boolean;
    nAutoMagicTime: Integer;
    boAutoEatWine: Boolean;
    boAutoEatHeroWine: Boolean;
    boAutoEatDrugWine: Boolean;
    boAutoEatHeroDrugWine: Boolean;
    btEditWine: Byte;
    btEditHeroWine: Byte;
    btEditDrugWine: Byte;
    btEditHeroDrugWine: Byte;
    dwEditExpFiltrate: LongWord;
//=============药品================
    boHp1Chk: Boolean;
    wHp1Hp: Integer;
    btHp1Man: Byte;
    boMp1Chk: Boolean;
    wMp1Mp: Integer;
    btMp1Man: Byte;
    boRenewHPIsAuto: Boolean;
    wRenewHPTime: Word;
    wRenewHPTick: LongWord;
    wRenewHPPercent: Integer;
    boRenewMPIsAuto: Boolean;
    wRenewMPTime: Word;
    wRenewMPPercent: Integer;
    wRenewMPTick: LongWord;
    boRenewSpecialHPIsAuto: Boolean;
    wRenewSpecialHPTime: Word;
    wRenewSpecialHPTick: LongWord;
    wRenewSpecialHPPercent: Integer;
    boRenewSpecialMPIsAuto: Boolean;
    wRenewSpecialMPTime: Word;
    wRenewSpecialMPTick: LongWord;
    wRenewSpecialMPPercent: Integer;
    BoUseSuperMedica: Boolean;
    SuperMedicaItemNames: array[0..8+5] of string;
    SuperMedicaUses: array[0..8+5] of Boolean;
    SuperMedicaHPs: array[0..8+5] of Integer;
    SuperMedicaHPTimes: array[0..8+5] of Word;
    SuperMedicaHPTicks: array[0..8+5] of LongWord;
    SuperMedicaMPs: array[0..8+5] of Integer;
    SuperMedicaMPTimes: array[0..8+5] of Word;
    SuperMedicaMPTicks: array[0..8+5] of LongWord;
    {$IF M2Version <> 2}
    boHp2Chk: Boolean;
    wHp2Hp: Integer;
    //btHp2Man: Byte;
    boMp2Chk: Boolean;
    wMp2Mp: Integer;
    //btMp2Man: Byte;
    boHp3Chk: Boolean;
    wHp3Hp: Integer;
    //btHp3Man: Byte;
    boMp3Chk: Boolean;
    wMp3Mp: Integer;
    //btMp3Man: Byte;
    boHp4Chk: Boolean;
    wHp4Hp: Integer;
    //btHp4Man: Byte;
    boMp4Chk: Boolean;
    wMp4Mp: Integer;
    //btMp4Man: Byte;
    boHp5Chk: Boolean;
    wHp5Hp: Integer;
    //btHp5Man: Byte;
    boMp5Chk: Boolean;
    wMp5Mp: Integer;
    //btMp5Man: Byte;
    boRenewHeroNormalHpIsAuto: Boolean;
    wRenewHeroNormalHpTime: Word;
    wRenewHeroNormalHpTick: LongWord;
    wRenewHeroNormalHpPercent: Integer;
    boRenewzHeroNormalHpIsAuto: Boolean;
    wRenewzHeroNormalHpTime: Word;
    wRenewzHeroNormalHpTick: LongWord;
    wRenewzHeroNormalHpPercent: Integer;
    boRenewfHeroNormalHpIsAuto: Boolean;
    wRenewfHeroNormalHpTime: Word;
    wRenewfHeroNormalHpTick: LongWord;
    wRenewfHeroNormalHpPercent: Integer;
    boRenewdHeroNormalHpIsAuto: Boolean;
    wRenewdHeroNormalHpTime: Word;
    wRenewdHeroNormalHpTick: LongWord;
    wRenewdHeroNormalHpPercent: Integer;
    boRenewHeroNormalMpIsAuto: Boolean;
    wRenewHeroNormalMpTime: Word;
    wRenewHeroNormalMpTick: LongWord;
    wRenewHeroNormalMpPercent: Integer;
    boRenewzHeroNormalMpIsAuto: Boolean;
    wRenewzHeroNormalMpTime: Word;
    wRenewzHeroNormalMpTick: LongWord;
    wRenewzHeroNormalMpPercent: Integer;
    boRenewfHeroNormalMpIsAuto: Boolean;
    wRenewfHeroNormalMpTime: Word;
    wRenewfHeroNormalMpTick: LongWord;
    wRenewfHeroNormalMpPercent: Integer;
    boRenewdHeroNormalMpIsAuto: Boolean;
    wRenewdHeroNormalMpTime: Word;
    wRenewdHeroNormalMpTick: LongWord;
    wRenewdHeroNormalMpPercent: Integer;

    boRenewSpecialHeroNormalHpIsAuto: Boolean;
    wRenewSpecialHeroNormalHpTime: Word;
    wRenewSpecialHeroNormalHpTick: LongWord;
    wRenewSpecialHeroNormalHpPercent: Integer;
    boRenewSpecialzHeroNormalHpIsAuto: Boolean;
    wRenewSpecialzHeroNormalHpTime: Word;
    wRenewSpecialzHeroNormalHpTick: LongWord;
    wRenewSpecialzHeroNormalHpPercent: Integer;
    boRenewSpecialfHeroNormalHpIsAuto: Boolean;
    wRenewSpecialfHeroNormalHpTime: Word;
    wRenewSpecialfHeroNormalHpTick: LongWord;
    wRenewSpecialfHeroNormalHpPercent: Integer;
    boRenewSpecialdHeroNormalHpIsAuto: Boolean;
    wRenewSpecialdHeroNormalHpTime: Word;
    wRenewSpecialdHeroNormalHpTick: LongWord;
    wRenewSpecialdHeroNormalHpPercent: Integer;

    boRenewSpecialHeroNormalMpIsAuto: Boolean;
    wRenewSpecialHeroNormalMpTime: Word;
    wRenewSpecialHeroNormalMpTick: LongWord;
    wRenewSpecialHeroNormalMpPercent: Integer;
    boRenewSpecialzHeroNormalMpIsAuto: Boolean;
    wRenewSpecialzHeroNormalMpTime: Word;
    wRenewSpecialzHeroNormalMpTick: LongWord;
    wRenewSpecialzHeroNormalMpPercent: Integer;
    boRenewSpecialfHeroNormalMpIsAuto: Boolean;
    wRenewSpecialfHeroNormalMpTime: Word;
    wRenewSpecialfHeroNormalMpTick: LongWord;
    wRenewSpecialfHeroNormalMpPercent: Integer;
    boRenewSpecialdHeroNormalMpIsAuto: Boolean;
    wRenewSpecialdHeroNormalMpTime: Word;
    wRenewSpecialdHeroNormalMpTick: LongWord;
    wRenewSpecialdHeroNormalMpPercent: Integer;
    hBoUseSuperMedica: Boolean;
    zBoUseSuperMedica: Boolean;
    fBoUseSuperMedica: Boolean;
    dBoUseSuperMedica: Boolean;
    hSuperMedicaUses: array[0..8+5] of Boolean;
    hSuperMedicaHPs: array[0..8+5] of Integer;
    hSuperMedicaHPTimes: array[0..8+5] of Word;
    hSuperMedicaHPTicks: array[0..8+5] of LongWord;
    hSuperMedicaMPs: array[0..8+5] of Integer;
    hSuperMedicaMPTimes: array[0..8+5] of Word;
    hSuperMedicaMPTicks: array[0..8+5] of LongWord;
    zSuperMedicaUses: array[0..8+5] of Boolean;
    zSuperMedicaHPs: array[0..8+5] of Integer;
    zSuperMedicaHPTimes: array[0..8+5] of Word;
    zSuperMedicaHPTicks: array[0..8+5] of LongWord;
    zSuperMedicaMPs: array[0..8+5] of Integer;
    zSuperMedicaMPTimes: array[0..8+5] of Word;
    zSuperMedicaMPTicks: array[0..8+5] of LongWord;
    fSuperMedicaUses: array[0..8+5] of Boolean;
    fSuperMedicaHPs: array[0..8+5] of Integer;
    fSuperMedicaHPTimes: array[0..8+5] of Word;
    fSuperMedicaHPTicks: array[0..8+5] of LongWord;
    fSuperMedicaMPs: array[0..8+5] of Integer;
    fSuperMedicaMPTimes: array[0..8+5] of Word;
    fSuperMedicaMPTicks: array[0..8+5] of LongWord;
    dSuperMedicaUses: array[0..8+5] of Boolean;
    dSuperMedicaHPs: array[0..8+5] of Integer;
    dSuperMedicaHPTimes: array[0..8+5] of Word;
    dSuperMedicaHPTicks: array[0..8+5] of LongWord;
    dSuperMedicaMPs: array[0..8+5] of Integer;
    dSuperMedicaMPTimes: array[0..8+5] of Word;
    dSuperMedicaMPTicks: array[0..8+5] of LongWord;
    {$IFEND}
  end;
  TFileItemDB = class
    m_FileItemList: TList;
    m_ShowItemList: Thashedstringlist;//THashTable; //THashedStringlist;//TStringList;
  private
  public
    constructor Create();
    destructor Destroy; override;
    function Find(sItemName: string): pTShowItem1;
    procedure Get(sItemType: string; var ItemList: TList); overload;
    procedure Get(ItemType: TItemType; var ItemList: TList); overload;
    function Add(ShowItem: pTShowItem1): Boolean;
    procedure Hint(DropItem: pTDropItem);
    procedure LoadFormList(LoadList: TStringList);
    procedure LoadFormFile(); overload;
    procedure LoadFormFile(const FileName: string); overload;
    procedure SaveToFile();
    procedure BackUp;
  end;
  {//----自动寻路相关-----//20080617
  TFindNode = record
    X, Y: Integer; //坐标
  end;
  PFindNOde = ^TFindNode;

  PTree = ^Tree;
  Tree = record
    H: Integer;
    X, Y: Integer;
    Dir: Byte;
    Father: PTree;
  end;

  PLink = ^Link;
  Link = record
    Node: PTree;
    F: Integer;
    Next: PLink;
  end; }
  TDelChr = record
    ChrInfo: TUserCharacterInfo;
  end;
  pTDelChr = ^TDelChr;

  TTzHintInfo = record//套装提示显示结构
    sTzCaption: string; //套装标题
    btItemsCount: Byte; //套装数量
    sTzItems: string; //套装物品
    btIncNHRate: Byte;//内力恢复(增加)% 20090330
    btReserved: Byte;  //防爆
    btReserved1: Byte; //吸血
    btReserved2: Byte; //内伤等级                        
    btReserved3: Byte;
    btReserved4: Byte;
    btReserved5: Byte;
    btReserved6: Byte;
    btReserved7: Byte;
    btReserved8: Byte;
    btReserved9: Byte;
    btReserved10: Byte;
    btReserved11: Byte;
    btReserved12: Byte;
    btReserved13: Byte; //角色职业
    sMemo: string; //功能讲解
    btInNum: Byte; //物品匹配数量
  end;
  pTTzHintInfo = ^TTzHintInfo;

  TBatterDesc = record
    sName: string;
    sLine1: string;
    sLine2: string;
    sLine3: string;
  end;
  pTBatterDesc = ^TBatterDesc;

  TItemDesc = record
    sItemName: string[14];
    sItemDesc: string[80];
  end;
  pTItemDesc = ^TItemDesc;

  {$IF M2Version <> 2}
  TTitleDesc = record
    sTitleName: string[14];
    sTitleDesc: string[80];
    sNewStateTitleDesc: string[100];
  end;
  pTTitleDesc = ^TTitleDesc;
  {$IFEND}

  TSkillDesc = record
    sSkillType: string[10];
    sSkillName: string[14];
    sSkillDesc: string[80];
  end;
  pTSkillDesc = ^TSkillDesc;
  TJLBoxFreeItem = record
    Item: TBoxsInfo;
    boCloak: Boolean;   //是否被盖住
  end;
  TItemArr = record
    Item: TClientItem;
    boLockItem: Boolean; //锁定物品
  end;
  TDrawEffect = record
    nIndex: Integer;
    dwDrawTick: LongWord;
  end;
  pTDrawEffect = ^TDrawEffect;
  //宠物
  TPetDlg = record
  	sLogList: TStringList;  //日志
    nHapply: LongWord;   //快乐度
  end;

  {$IF M2Version <> 2}
  TFactionDlg = record
  	sDivisionName: string; //门派名
    boIsAdmin: Boolean; //门派老大
    sHeartName: string; //心法名
    sHeartTpye: string; //心法属性
    btDivisonType: Byte; //门派类型
    nPopularity: Integer; //人气
    sMasterName: string; //师傅名字
    sMemberCount: string; //人数
    nHeartLeve: Integer; //传承心法等级
  	NoticeList: TStringList; //公告
    boPublic: Boolean; //公共师门
  end;
  //内功心法界面
  TLingWuXinFa = record
    btGetM2Type: Byte; //从M2获取打开窗体时的心法类型
    boChangeXinFa: Boolean; //True更换心法  FALSE为领悟心法
    btIndex: Byte; //心法名字索引值
    btPage: Byte; //心法页数
    btHelpPage: Byte; //心法介绍页数
    btCurrentFrame: Byte; //当前桢
    dwStartTimeTick: LongWord; //桢间隔
    nKeySelIndex: Integer; //当前选择的按键索引
    btKeyPage: Byte; //按键页数
    sKeySelCaption: string[12];
  end;

  TFactionMember = record
    AdminNum: Byte; //掌门数量
    MemberNum: Byte; //成员数量
    SelMemberName: string[ACTORNAMELEN];//选中人的名字
  end;
  {$IFEND}
  TRunParam = packed record
    wProt : Word;
    sConfigKeyWord : string[34];
    LoginGateIpAddr1 : Byte;
    wScreenWidth : Word; //分辨率
    sWinCaption : string[30];
    wScreenHeight : Word;
    LoginGateIpAddr0 : Byte;
    sESystemUrl : string[30];
    LoginGateIpAddr2 : Byte;
    btBitCount : Byte; //色深
    sMirDir : string[250];
    ParentWnd : HWND;
    sServerPassWord : string[10];
    LoginGateIpAddr3 : Byte;
    boFullScreen : Boolean;
  end;
const
  BugFile = 'Log\!56Log.ui';
  SeedString = 'jdjwicjchahpnmstardhxksjhha'; //种子字符串可以自己设定
  Byte0=Byte('0');
  RecInfoSize = Sizeof(TRecinfo);  //返回被TRecinfo所占用的字节数
  g_XinFaName: array[0..4] of string[4] = ('紫金', '乙木', '大地', '葵水', '阳炎');
//==========================================
var
  g_ShowItemList: TFileItemDB;
  //OldDrawTime: LongWord;
  //{$IF Version = 0}
  g_StartTick: Cardinal; // 开始计数时间(用于 FPS)
  g_FrameCount: Cardinal; // 已画表面次数(用于 FPS)
  g_IsShowFPS: Boolean = True;
  g_dwProcessInterval: Integer = 2;
  g_dwProcessTime: Longword;
  g_dwRunTime: Longword;
  g_nilFeature: TFeatures; //外观空值
  //{$IFEND}
  g_sLogoText       :String = '3K引擎'; //3K引擎
  g_sGoldName       :String = '金币';
  g_sGameGoldName   :String = '元宝';
  g_sGamePointName  :String = '荣耀点';
  g_sGameGird       :String = '灵符';
  g_sGameDiaMond    :String = '金刚石';
  g_dGamePointDate  :TDateTime = 32590;
  g_nCreditPoint    :Integer = 0;

  {$IF M2Version <> 2}
  g_sGameNGStrong   :string = '绿宝石';
  {$IFEND}
  g_RunParam : TRunParam =
  (
    wProt : 7000;                        
    sConfigKeyWord : 'nl4vvhDYuUYrx6xltCcUn3qzVDypDtg66q';
    LoginGateIpAddr1 : 0;
    wScreenWidth : 800; //分辨率
    sWinCaption : '3KM2';                
    wScreenHeight : 600;
    LoginGateIpAddr0 : 127;              
    sESystemUrl : '';
    LoginGateIpAddr2 : 0;
    btBitCount : 32; //色深            
    ParentWnd : 0;
    sServerPassWord :'123';
    LoginGateIpAddr3 : 1;
    boFullScreen : False;
  );
  g_sWarriorName    :String = '武士';    //职业名称
  g_sWizardName     :String = '法师';  //职业名称
  g_sTaoistName     :String = '道士';    //职业名称
  g_sUnKnowName     :String = '607C7C783227277F7F7F26313A653A266B6765266B66'; //http://www.92m2.com.cn
  g_sLoginKey         :string;
  {g_sMainParam1     :String; //读取设置参数
  g_sMainParam2     :String; //读取设置参数
  g_sMainParam3     :String; //读取设置参数}
  g_boOnePlay       :Boolean = False; //是否第一次点开始游戏
  g_sGameESystem    :String; //E系统网址　20080603
  g_MapDescList     :TList; //地图注释列表
  //VIEWCHATLINE      :Byte; //文字聊天行数
  g_TzHintList: TList;
  g_RecInfo         :TRecInfo;
  g_boSendOnePack   : Boolean;
  {$if GVersion = 1}
  //sTempStr: ^AnsiString;//退出时访问的网站
  sApplicationStr: string;
  g_sTArr:array[1..28] of char;
  {$IFEND}

  g_ParamDir        :string = '';  //传奇目录
  {$IF M2Version <> 2}
  g_boOpenHero      :Boolean=True; //是否开启英雄系统
  g_boOpenLeiMei    :Boolean=True; //是否开启灵媒+鉴定系统
  g_dwLingMeiTick   :LongWord;
  {$IFEND}
  g_4LeveDuShape    :Byte = 1; //4级毒使用当前毒的记录
  g_CommandList      :TStrings;
  g_ComMandIndex     :Integer=-1; //
  g_ReSelClientRect  :TRect;
  g_boReSelConnect: Boolean = False;
  g_dwReSelConnectTick: LongWord;
(******************************************************************************)
	{$IF M2Version <> 2}
  g_FactionAddList: TList;
  g_FactionDlg:  TFactionDlg;
  g_FactionMember: TFactionMember;
  g_FactionMeberList: TCnHashTableSmall = nil;
  g_FactionDlgHint: string = '';
  g_FactionApplyManageSel: array[0..4] of Boolean;
  g_FactionApplyManageNameList: TStringList = nil;
  g_LingWuXinFa: TLingWuXinFa;
  g_XinFaMagic: TList;
  g_boXinFaType: Boolean = False;//True心法,False传承心法
  g_boShowXinFaAbsorb: Boolean = False; //显示心法吸收小手动画
  g_dwXinFaAbsorbTimeKick: LongWord;
  g_btXinFaAbsorbImgIndex: Byte;
  g_HeartAbility: TClientHeartAbility;
  g_boNewNewStateWin: Boolean = False;
  g_boNewNewHeroState: Boolean = False;
  {$IFEND}
  g_DrawUseItems: array[0..13] of TDrawEffect;
  g_DrawUseItems1: array[0..13] of TDrawEffect;
  g_DrawHeroUseItems: array[0..13] of TDrawEffect;
  g_DrawBagItemsArr: array[0..MAXBAGITEMCL-1] of TDrawEffect;
  g_DrawHeroBagItemsArr: array[0..MAXBAGITEMCL-1] of TDrawEffect;
  g_PetDlg: TPetDlg;
  {$IF M2Version = 1}
  //奇经修炼
  g_QJPracticeItems: TClientItem; //品评物品
  g_boQJDZXY99: Boolean; //人物斗转星移是否打通99级
  g_boQJHeroDZXY99: Boolean; //英雄斗转星移是否打通99级
  g_dwQJFurnaceGold: LongWord;
  g_dwQJFurnaceLingfu: LongWord;
  g_dwQJFurnaceExp: LongWord;
  g_dwQJFurnaceMaxExp: LongWord;
  g_btQJFurnaceType: Byte; //类型0-普通 1-强化
  g_boQJFurnaceGet: Boolean; //是否为提取
  g_boQJFurnaceMove: Boolean; //转动
  g_btQJFurnacePosition: Byte = 7; //位置
  g_btQJFurnaceTarget: Byte; //目标位置
  g_dwQJFurnaceTick: LongWord; //时间间隔
  {$IFEND}
(******************************************************************************)
  g_MySelfSuitAbility: TClientSuitAbility;
	{$IF M2Version <> 2}
  g_MyHeroSuitAbility: TClientSuitAbility;
  {$IFEND}
  {$IF M2Version <> 2}
//称号
  g_ClientHumTitles            :TClientHumTitles; //称号数组
  g_TitleHumNameList           :TList; //
  g_HuWeiJunList               :TList;
  g_boMySelfTitleFense         :Boolean = False;
  g_boCanTitleUse              :Boolean = False; //M2上是否启用才有效果
  g_boHideTitle                :Boolean = False; //内挂中隐藏称号
  g_MouseTitleList             :TStringList;
  g_MouseUserTitleList         :TStringList;
//新鉴定 By TasNat at: 2012-10-14 12:40:53
  g_SerXinJianDingNeeds        :array [0..1] of DWord;
  g_SerXinJianDingLockNeeds    :array [0..1] of DWord;
  g_XinJianDingNeeds           :array [0..1] of DWord;
  g_sXinJianDingValues         : array [2..5] of string[30];
  g_XinJianDingData            :TXinJianDingData;//新鉴定用 、需要保留的属性By TasNat at: 2012-04-12 13:50:16
  g_SignedItemNames            :array[0..2] of string;  //鉴定相关物品
  
//签定物品
  g_ImgSignedSurface           :TDirectDrawSurface;
  g_SignedItem                 :array[0..2] of TClientItem;  //鉴定相关物品
  g_MakeSignedBelt             :array[0..1] of TClientItem;  //解读相关物品
  g_MakeSignedBelt3            :TClientItem; //制作羊皮卷
  g_nProficiency               :Word = 0; //{熟练度(制造神秘卷轴)
  g_btEnergyValue              :Byte = 0;{精力值}
  g_btLuckyValue               :Byte = 0;{幸运值}
  g_LingMeiBelt                :TClientItem; //灵媒物品
  g_JudgeItems                 :TClientItem; //品评物品
  g_nJudgePrice                :Integer = 0; //品评价格
  g_boJudgeUseGold             :Boolean = False; //是否使用金币
  {$IFEND}
(*******************************************************************************)
  g_GetDeputyHeroData  :array[0..1] of THeroDataInfo;
  m_btDeputyHeroJob    :Byte = 0; //所选副将职业(评定时赋值)
  g_boHeroAssessMenuDowning :Boolean; //是否按下菜单项
  g_btHeroAssessMenuMoving  :Byte;    //移动到第几个菜单项
  g_btHeroAssessMenuIndex   :Byte;    //选择到第几个菜单项
  g_btHeroAutoPracticePlace: Integer;//自动修炼修炼场所
  g_btHeroAutoPracticeStrength: Integer;//自动修炼修炼强度
  g_sHeroAutoPracticeChrName: string; //名字
  g_btHeroAutoPracticeJob: Byte; //职业
  g_btHeroAutoPracticeSex: Byte; //性别
  g_btHeroAutoPracticeGameGird1: Word;//自动修炼中强度灵符数
  g_btHeroAutoPracticeGameGird2: Word;//自动修炼高强度灵符数
(*******************************************************************************)
//按键、鼠标点击时间间隔
  g_dwKeyTimeTick  :LongWord; //按键时间间隔
  g_dwOpenPulsePoint: LongWord; //打通穴位时间间隔
  g_dwPracticePulse: LongWord; //修炼经络时间间隔
  g_dwHelpQMTick: LongWord; //[@Help]  QM触发时间间隔
  g_CallHeroTick   :LongWord; //召唤英雄时间间隔
(*******************************************************************************)
//自动挖取
  g_boAutoButch    :Boolean;
  g_nButchX,g_nButchY: Integer;
(******************************************************************************)
//小窍门
  g_TipsList        :TStringList;
  g_sTips           :string;
  g_ItemDesc        :TStringList;
  {$IF M2Version <> 2}
  g_TitleDesc       :TStringList;
  {$IFEND}
  g_PulsDesc        :TStringList;
  g_SkillDesc        :TStringList;
(******************************************************************************)
//装备物品发光相关 20080223
    ItemLightTimeTick: LongWord;
    ItemLightImgIdx: integer;
(******************************************************************************)
   g_pwdimgstr : string;
   g_sAttackMode    :string; //攻击模式  20080228
{******************************************************************************}
   m_dwUiMemChecktTick: LongWord; //UI释放内存检测时间间隔
{******************************************************************************}
//英雄连击状态栏
  g_HeroHumanPulseArr: THeroPulseInfo1; //经络相关信息
  g_btHeroStateWinPulseMoving: Byte = 0; //0-无状态 1-冲脉 2-阴跷 3-阴维 4-任脉 5-图里1文字 6-图里2文字 7-图里3文字 8-图里4文字 9-图里5文字 10-修炼的文字 11-奇经
  g_boHeroStateWinPulseDowning: Boolean = False; //是否按下状态
  g_btHeroPulseOriginPage: Byte = 0; //m2发的原点亮光页
  g_btHeroPulsePoint: Byte=0; //m2发来的穴位
  g_btHeroPulseLevel: Byte=0; //m2发来的穴位等级
  g_boHeroPulseOpen: Boolean = False; //英雄经脉是否开通
  g_dwHeroPulsExp: LongWord; //英雄的经验变量
  g_HeroBatterMagicList      :TList;       //内功技能列表
  g_HeroBatterTopMagic     :array[0..3] of TClientMagic;  //连击上面三格技能魔法
  g_sMyHeroType: string[2] = '白';
  g_boHeroInfuriating: BOolean = False; //英雄真气，用于英雄头像处显示
{******************************************************************************}
//连击状态栏
  g_boOpen4BatterSkill: Boolean;
  g_boHeroOpen4BatterSkill: Boolean;
  g_boNewStateWin: Boolean;
  g_boNewHeroState: Boolean;
  g_btStateWinPulseMoving: Byte = 0; //0-无状态 1-冲脉 2-阴跷 3-阴维 4-任脉 5-图里1文字 6-图里2文字 7-图里3文字 8-图里4文字 9-图里5文字 10-修炼的文字  11-奇经
  g_boStateWinPulseDowning: Boolean = False; //是否按下状态
  g_HumanPulseArr: THumanPulseInfo; //经络相关信息
  g_btPulseOriginPage: Byte = 0; //m2发的原点亮光页
  g_btPulsePoint: Byte=0; //m2发来的穴位
  g_btPulseLevel: Byte=0; //m2发来的穴位等级
  g_WinBatterMagicList      :TList;       //内功技能列表
  g_WinBatterTopMagic     :array[0..3] of TClientMagic;  //连击上面三格技能魔法
  g_boCanUseBatter: Boolean = False;
  g_BatterDesc: TBatterDesc;
  g_HeroBatterDesc: TBatterDesc;
  g_dHPImages: TDirectDrawSurface;
  g_dMyHPImages: TDirectDrawSurface;
  g_dMPImages: TDirectDrawSurface;
  g_dKill69Images: TDirectDrawSurface;
  g_dNewMPImages: TDirectDrawSurface;
  g_AutoMagicLock: Boolean;
  g_AutoMagicTimeTick: LongWord;
  g_AutoMagicTime: Byte;
{******************************************************************************}
//金针
  g_KimNeedleItem                    :array[0..7] of TClientItem;  //金针相关物品
  g_nKimSuccessRate  :Integer = 0;   //累计成功率
  g_btKimItemOneLevel :Byte = 0; //金针第1个物品的等级
  g_btKimItemNum :Byte = 0; //金针和幸运符物品个数
  g_btKimNeedleNum :Byte = 0;
  //金针锻造成功与失败动画
 // g_dwKimNeedleTextTimeTick: LongWord;
//  g_btKimNeedleTextImginsex: Byte;
  g_btKimNeedleSuccess: Byte;   //0-初始状态 1-成功状态 2-失败状态
  g_btKimNeedleSuccessShape: Byte; //成功后返回成功物品的Shape特征
  g_dwKimNeedleSuccessExplTimeTick: LongWord;
  g_btKimNeedleSuccessExplImginsex: Byte;
  g_dwKimNeedleSuccessStarsTimeTick: LongWord;
  g_btKimNeedleSuccessStarsImginsex: Byte = 0;
  //g_boServerPrveKimSate: Boolean;
  //g_boShowKimBar: Boolean; //显示开始锻造的滚动条
{******************************************************************************}
//金牛
  g_btNQLevel: Byte;   //牛气等级 20090520
  g_dwNQExp: LongWord; //牛气当前经验 20090520
  g_dwNQMaxExp: LongWord; //牛气升级经验 20090520

  g_boJNBox: Boolean;
  boShowNQExpFalsh: Boolean;
  ShowNQExpTimeTick: LongWord;
  ShowNQExpInc: Byte;
  ShowNQExpInc1: Byte;
{******************************************************************************}
//天地结晶
  g_btCrystalLevel: Byte;   //天地结晶等级 20090201
  g_dwCrystalExp: LongWord; //天地结晶当前经验 20090201
  g_dwCrystalMaxExp: LongWord; //天地结晶升级经验 20090201
  g_dwCrystalNGExp: LongWord;//天地结晶当前内功经验 20090201
  g_dwCrystalNGMaxExp: LongWord;//天地结晶内功升级经验 20090201
//感叹号图标
  g_sSighIcon: string; //20080126
{******************************************************************************}
//内功
  g_boIsInternalForce: Boolean;    //是否有内功
  g_boIsHeroInternalForce: Boolean;    //英雄是否有内功
  g_dwInternalForceLevel: Word; //内功等级
  g_dwHeroInternalForceLevel: Word; //英雄内功等级
  g_nInternalRecovery: Integer;  //内功恢复速度
  g_nHeroInternalRecovery: Integer; //英雄内功恢复速度
  g_nInternalHurtAdd: Integer; //内功伤害增加
  g_nHeroInternalHurtAdd: Integer; //英雄内功伤害增加
  g_nInternalHurtRelief: Integer; //内功伤害减免
  g_nHeroInternalHurtRelief: Integer; //英雄内功伤害减免
  

  g_dwExp69                     :LongWord = 0; //内功当前经验
  g_dwMaxExp69                  :LongWord = 0; //内功升级经验
  g_dwHeroExp69                 :LongWord = 0; //英雄内功当前经验
  g_dwHeroMaxExp69              :LongWord = 0; //英雄内功升级经验
  g_InternalForceMagicList      :TList;       //内功技能列表
  g_HeroInternalForceMagicList  :TList;       //英雄内功技能列表
{--------------------英雄版2007.10.17 添加---------------------------}
  g_RefuseCRY                   :Boolean=true;    //拒绝喊话
  g_Refuseguild                 :Boolean=true;    //拒绝行会聊天信息
  g_RefuseWHISPER               :Boolean=true;    //拒绝私聊信息
  g_boSkill31Effect             :Boolean=False; //4级魔法盾效果图
  nMaxFirDragonPoint            :integer;     //英雄最大怒气
  m_nFirDragonPoint             :integer;     //英雄当前怒气
  m_SCenterLetter               :string; //在屏幕中间显示文字消息
  m_CenterLetterForeGroundColor :Integer; //在屏幕中间显示的前景色
  m_CenterLetterBackGroundColor :Integer; //在屏幕中间显示的背景色
  m_dwCenterLetterTimeTick      :longWord; //文字中间显示信息
  m_nCenterLetterTimer          :Integer; //中间显示传信息的时间
  m_boCenTerLetter              :Boolean=False; //在屏幕中显示文字 开关
  g_nHeroSpeedPoint             :Integer; //敏捷
  g_nHeroHitPoint               :Integer; //准确
  g_nHeroAntiPoison             :Integer; //魔法躲避
  g_nHeroPoisonRecover          :Integer; //中毒恢复
  g_nHeroHealthRecover          :Integer; //体力恢复
  g_nHeroSpellRecover           :Integer; //魔法恢复
  g_nHeroAntiMagic              :Integer; //魔法躲避
  g_nHeroHungryState            :Integer; //饥饿状态
  g_HeroMagicList               :TList;       //技能列表
  g_boHeroItemMoving            :Boolean;  //正在移动物品
{******************************************************************************}
  g_boRightItemRingEmpty        :Boolean=False; //人物戒指哪头是空 20080319
  g_boRightItemArmRingEmpty     :Boolean=False; //人物手镯哪头是空 20080319
  g_boHeroRightItemRingEmpty    :Boolean=False; //英雄物品哪头是空 20080319
  g_boHeroRightItemArmRingEmpty :Boolean=False; //英雄手镯哪头是空 20080319
//右键穿装备代码
  {g_boRightItem                 :Boolean=False;  //正在从背包右键点物品穿装备
  g_boHeroRightItem             :Boolean=False;  //正在从英雄背包右键点物品穿装备
  g_nRightItemTick              :LongWord;  //右键穿装备时间间隔 20080308}
{******************************************************************************}
//恢复已删除的角色
  g_DelChrList                  :TList;
{******************************************************************************}
//粹练系统20080506
  g_ItemsUpItem                 :array[0..2] of TClientItem;
  g_WaitingItemUp               :TMovingItem;
  g_RefineDrumItem              :array[0..5] of TClientItem; //淬炼军鼓项目
{******************************************************************************}
  g_HeroBagCount                :Integer;  //英雄包裹总数
  g_boHeroBagLoaded             :Boolean;
  g_HeroSelf                    :THumActor;
  g_HeroItems                   :array[0..14] of TClientItem;   //$005     20071021
  g_MovingHeroItem              :TMovingItem;
  g_WaitingHeroUseItem          :TMovingItem;
  g_HeroEatingItem              :TClientItem;
  g_HeroMouseItem               :TClientItem;//显示物品   20080222
  g_HeroMouseStateItem          :TClientItem; //20080222
{******************************************************************************}
//酒馆1卷 20080515
  g_GetHeroData                 :array[0..1] of THeroDataInfo;
  g_boPlayDrink                 :Boolean; //是否正在出拳 20080515
  g_sPlayDrinkStr1              :string; //斗酒对话框文字 上
  g_sPlayDrinkStr2              :string; //斗酒对话框文字 下
  g_PlayDrinkPoints             :TList;  //酒馆NPC定点
  g_boRequireAddPoints1         :Boolean; //是否需要添加定点
  g_boRequireAddPoints2         :Boolean; //是否需要添加定点
  g_btNpcIcon                   :Byte;   //NPC头像
  g_sNpcName                    :string; //NPC名字
  g_btPlayDrinkGameNum          :Byte; //猜拳码数
  g_btPlayNum                   :Byte; //玩家码数
  g_btNpcNum                    :Byte; //NPC码数
  g_btWhoWin                    :Byte; //0-赢  1-输  2-平
  g_DwPlayDrinkTick             :LongWord; //显示拳动画的时间间隔
  g_nImgLeft                    :Integer = 0; //减去X坐标
  g_nPlayDrinkDelay             :Integer = 0; //延时
  g_nNpcDrinkLeft               :Integer;
  g_nPlayDrinkLeft              :Integer;
  g_dwPlayDrinkSelImgTick       :LongWord; //斗酒选择拳的动画
  g_nPlayDrinkSelImg            :Integer; //斗酒选择拳的浈

  g_btShowPlayDrinkFlash        :Byte;  //显示喝酒动画 1为NPC 2为玩家
  g_DwShowPlayDrinkFlashTick    :LongWord; //显示喝酒动画的时间间隔
  g_nShowPlayDrinkFlashImg      :Integer = 0; //显示喝酒动画的图
  g_boPermitSelDrink            :Boolean; //是否禁止选酒
  g_boNpcAutoSelDrink           :Boolean; //是否NPC自动选酒
  g_btNpcAutoSelDrinkCircleNum  :Byte = 0;  //NPC选酒转动圈数
  g_DwShowNpcSelDrinkTick       :LongWord; //NPC自动选酒圈数间隔
  g_btNpcDrinkTarget            :Byte;  //NPC选哪瓶酒  目标
  g_nNpcSelDrinkPosition        :Integer = -1;//显示选择酒动画位置
  g_NpcRandomDrinkList          :TList; //NPC选酒随机不重复列表
  g_btPlaySelDrink              :Byte = 7; //玩家选择的酒 不为 0..5 那么不选择酒
  g_btDrinkValue                :array[0..1] of Byte;//喝酒的醉酒值 0-NPC 1-玩家 20080517
  g_btTempDrinkValue            :array[0..1] of Byte; //临时保存醉酒值 0-NPC 1-玩家 20080518
  g_boStopPlayDrinkGame         :Boolean; //结束了斗酒游戏
  g_boHumWinDrink               :Boolean; //玩家赢，是否喝了酒 20080614
  g_PDrinkItem                  :array[0..1] of TClientItem;  //请酒的两个物品
//酒馆2卷
  g_MakeTypeWine                :byte = 1;  //酿造什么类型的酒    0为普通酒，1为药酒
  g_WineItem                    :array[0..6] of TClientItem;  //酒的物品
  g_DrugWineItem                :array[0..2] of TClientItem;  //药酒的物品
  g_WaitingDrugWineItem         :TMovingItem;
  g_dwShowStartMakeWineTick     :LongWord; //显示酿酒动画
  g_nShowStartMakeWineImg       :Integer; //显示酿酒动画
{******************************************************************************}
//自动寻路相关 20080617
  {g_Queue      :PLink;
  g_RoadList   :TList;
  g_SearchMap  :TQuickSearchMap;
  g_nAutoRunx  :Integer; //啊绊磊 窍绰 格利瘤
  g_nAutoRuny  :Integer;  }
  g_dwAutoFindPathTick: LongWord;
{******************************************************************************}
//新盛大内挂 20080624
  g_btSdoAssistantPage    :Byte=0;
  g_dwAutoZhuRi           :LongWord;
  g_boAutoZhuRiHit        :Boolean;
  g_dwAutoLieHuo          :LongWord;
  //时间间隔
  g_dwCommonMpTick        :LongWord; //普通MP保护的时间
  g_dwSpecialHpTick       :LongWord; //特殊HP保护的时间
  g_dwRandomHpTick        :LongWord;  //随机HP保护的时间

  g_boAutoEatWine         :Boolean;
  g_boAutoEatHeroWine     :Boolean;
  g_boAutoEatDrugWine     :Boolean;
  g_boAutoEatHeroDrugWine :Boolean;
  g_dwAutoEatWineTick     :LongWord; //人物喝普通酒的时间间隔
  g_dwAutoEatHeroWineTick :LongWord; //英雄喝普通酒的时间间隔
  g_dwAutoEatDrugWineTick :LongWord; //人物喝药洒的时间间隔
  g_dwAutoEatHeroDrugWineTick :LongWord; //英雄喝药酒的时间间隔
  g_btEditWine                :Byte;
  g_btEditHeroWine            :Byte;
  g_btEditDrugWine            :Byte;
  g_btEditHeroDrugWine        :Byte;
  g_dwEditExpFiltrate         :LongWord; //过滤经验
  g_boHeroAutoDEfence         :Boolean = False;
  g_boShowSpecialDamage       :Boolean = True;
  {$IF M2Version <> 2}
  g_boAutoDragInBody          :Boolean = False; //自动使用神龙附体
  g_boHideHumanWing           :Boolean = False; //隐藏人物翅膀
  g_boHideWeaponEffect        :Boolean = False; //隐藏武器发光效果
  {$IFEND}
  g_boHideHummanShiTi         :Boolean = False; //隐藏尸体
{******************************************************************************}

  g_nUserSelectName             :Byte;  //20080302  查看别人装备 点名字或行会 直接出现在聊天拦里  1为名字 2为行会 3为名字按下 4为行会按下 0为没选择
  g_boSelectText                :Boolean; //是否选择某个名字或文字 以后通用

  g_DXDraw             :TDXDraw;
  g_DWinMan            :TDWinManager;
  g_DXSound            :TDXSound;
  g_Sound              :TSoundEngine;

  g_WMainImages        :TWMImages;
  g_WMain2Images       :TWMImages;
  g_WMain3Images       :TWMImages;
  g_WChrSelImages      :TWMImages;
  g_WMMapImages        :TWMImages;
  g_WHumWingImages     :TWMImages;
  g_WHumWing2Images    :TWMImages;
  g_WHumWing3Images    :TWMImages;
  g_WHumWing4Images    :TWMImages;//By TasNat at: 2012-10-14 17:11:56

  g_WCboHumWingImages  :TWMImages;
  g_WCboHumWingImages2 :TWMImages;
  g_WCboHumWingImages3 :TWMImages;
  g_WCboHumWingImages4 :TWMImages;//By TasNat at: 2012-10-14 17:11:56

  g_WBagItemImages     :TWMImages;
  g_WBagItem2Images    :TWMImages;
  g_WStateItemImages   :TWMImages;
  g_WStateItem2Images  :TWMImages;
  g_WDnItemImages      :TWMImages;
  g_WDnItem2Images     :TWMImages;
  g_WHumImgImages      :TWMImages;
  g_WHum2ImgImages     :TWMImages; //20080501
  g_WHum3ImgImages     :TWMImages;
  g_WHum4ImgImages     :TWMImages;


  g_WCboHumImgImages   :TWMImages;
  g_WCboHum3ImgImages  :TWMImages;
  g_WCboHum4ImgImages  :TWMImages;//By TasNat at: 2012-10-14 10:53:50
  g_WHairImgImages     :TWMImages;
  g_WCboHairImgImages  :TWMImages;
  g_WWeaponImages      :TWMImages;
  g_WCboWeaponImages   :TWMImages;
  g_WCboWeaponImages3  :TWMImages;
  g_WCboWeaponImages4  :TWMImages;//By TasNat at: 2012-10-14 10:53:50
  g_WWeapon2Images     :TWMImages; //20080501
  g_WWeapon3Images     :TWMImages;
  g_WWeapon4Images     :TWMImages;
  g_WMagIconImages     :TWMImages;
  g_WMagIcon2Images    :TWMImages;
  g_WNpcImgImages      :TWMImages;
  g_WNpc2ImgImages     :TWMImages;
  g_WMagicImages       :TWMImages;
  g_WMagic2Images      :TWMImages;
  g_WMagic3Images      :TWMImages;
  g_WMagic4Images      :TWMImages;
  g_WMagic5Images      :TWMImages;
  g_WMagic6Images      :TWMImages;
  g_WMagic7Images      :TWMImages;
  g_WMagic7Images16    :TWMImages;
  g_WMagic8Images      :TWMImages;
  g_WMagic8Images16    :TWMImages;
  g_WMagic9Images      :TWMImages;
  g_WMagic10Images     :TWMImages;
  g_WMonKuLouImages    :TWMImages;
  g_WEffectImages      :TWMImages;
  g_qingqingImages     :TWMImages;
  g_WchantkkImages     :TWMImages;
  g_WDragonImages      :TWMImages;
  g_WCboEffectImages   :TWMImages;
  g_WUI1Images         :TWMImages;
  g_WUI3Images         :TWMImages;
  g_WStateEffectImages: TWMImages;
  g_WUiMainImages    :TUIWMImages;
  g_WWeaponEffectImages:TWMImages;
  g_WWeaponEffectImages4:TWMImages;
  g_WCboWeaponEffectImages4:TWMImages;


  g_WObjectArr              :array[0..17] of TWMImages;//数值越大 支持的 Object素材 越多  2007.10.27
  g_WTilesArr               :array[0..2] of TWMImages;
  g_WSMTilesArr             :array[0..2] of TWMImages;
  g_WMonImagesArr           :array[0..53] of TWMImages;
  g_sServerName             :String; //服务器显示名称
  g_sServerMiniName         :String; //服务器名称
  g_sServerAddr             :String = '127.0.0.1';
  g_nServerPort             :Integer = 7000;
  g_sServerPort             :string = '7000';  //解密用  20080302
  g_sSelChrAddr             :String;
  g_nSelChrPort             :Integer;
  g_sRunServerAddr          :String;
  g_nRunServerPort          :Integer;

  g_boSendLogin             :Boolean; //是否发送登录消息
  g_boServerConnected       :Boolean;
  g_SoftClosed              :Boolean; //小退游戏
  g_ChrAction               :TChrAction;
  g_ConnectionStep          :TConnectionStep;
                                         //
  g_boSound                 :Boolean; //开启声音
  g_boBGSound               :Boolean; //开启背景音乐
  g_sCurFontName            :String = '宋体';  //宋体
  g_sLoginGatePassWord      :string {$if GVersion = 0}= '123'{$ifend};
  g_ImgMixSurface           :TDirectDrawSurface;
  g_MiniMapSurface          :TDirectDrawSurface;  //20080813  未使用 优化

  g_boFirstTime             :Boolean;
  g_sMapTitle               :String;
  g_nMapMusic               :Integer;
  g_sMapMusic               :String;

  g_ServerList              :TStringList; //服务器列表
  g_MagicList               :TList;       //技能列表
  g_GroupMembers            :TStringList; //组成员列表
  g_SaveItemList            :TList;
  g_MenuItemList            :TList;
  g_DropedItemList          :TList;       //地面物品列表
  g_ChangeFaceReadyList     :TList;       //
  g_FreeActorList           :TList;       //释放角色列表
  g_SoundList               :TStringList; //声音列表

  g_nBonusPoint             :Integer;
  g_nSaveBonusPoint         :Integer;
  g_BonusTick               :TNakedAbility;
  g_BonusAbil               :TNakedAbility;
  g_NakedAbil               :TNakedAbility;
  g_BonusAbilChg            :TNakedAbility;

  g_sGuildName              :String;      //行会名称
  g_sGuildRankName          :String;      //职位名称

  g_dwLogoTick              :LongWord; //版权广告显示时间 20080525
  g_nLogoTimer              :Byte;

  g_dwLastAttackTick        :LongWord;    //最后攻击时间(包括物理攻击及魔法攻击)
  g_dwLastMoveTick          :LongWord;    //最后移动时间
  g_dwLatestStruckTick      :LongWord;    //最后弯腰时间
  g_dwLatestSpellTick       :LongWord;    //最后魔法攻击时间
  g_dwLatestFireHitTick     :LongWord;    //最后列火攻击时间
  g_dwLatestTwnHitTick      :LongWord;    //最后开天斩攻击时间
  g_dwLatestDAILYHitTick    :LongWord;    //最后逐日剑法攻击时间  20080511
  g_dwLatestRushRushTick    :LongWord;    //最后被推动时间
  g_dwLatestHitTick         :LongWord;    //最后物理攻击时间(用来控制攻击状态不能退出游戏)
  g_dwLatestMagicTick       :LongWord;    //最后放魔法时间(用来控制攻击状态不能退出游戏)

  g_dwMagicDelayTime        :LongWord;
  g_dwMagicPKDelayTime      :LongWord;

  g_nMouseCurrX             :Integer;    //鼠标所在地图位置座标X
  g_nMouseCurrY             :Integer;    //鼠标所在地图位置座标Y
  g_nMouseX                 :Integer;    //鼠标所在屏幕位置座标X
  g_nMouseY                 :Integer;    //鼠标所在屏幕位置座标Y

  g_nTargetX                :Integer;    //目标座标
  g_nTargetY                :Integer;    //目标座标
  g_TargetCret              :TActor;
  g_FocusCret               :TActor;
  g_MagicTarget             :TActor;

  //g_boAttackSlow            :Boolean;   //腕力不够时慢动作攻击. //20080816 注释 腕力不足
  //g_nMoveSlowLevel          :Integer; 20080816注释掉起步负重
  g_boMapMoving             :Boolean;   //甘 捞悼吝, 钱副锭鳖瘤 捞悼 救凳
  g_boMapMovingWait         :Boolean;
  //g_boCheckSpeedHackDisplay :Boolean;   //是否显示机器速度数据
  g_boViewMiniMap           :Boolean;   //是否显示小地图
  g_boTransparentMiniMap    :Boolean;   //是否透明显示小地图
  g_nViewMinMapLv           :Integer;   //Jacky 小地图显示模式(0为不显示，1为透明显示，2为清析显示)
  g_nMiniMapIndex           :Integer;   //小地图号

  //NPC 相关
  g_nCurMerchant            :Integer;
  g_nMDlgX                  :Integer;
  g_nMDlgY                  :Integer;
  g_dwChangeGroupModeTick   :LongWord;
  g_dwDealActionTick        :LongWord;
  g_dwQueryMsgTick          :LongWord;
  g_nDupSelection           :Integer;
  //g_boMoveSlow              :Boolean;   //负重不够时慢动作跑   20080816注释掉起步负重
  g_boAllowGroup            :Boolean;

  //人物信息相关
  g_nMySpeedPoint           :Integer; //敏捷
  g_nMyHitPoint             :Integer; //准确
  g_nMyAntiPoison           :Integer; //魔法躲避
  g_nMyPoisonRecover        :Integer; //中毒恢复
  g_nMyHealthRecover        :Integer; //体力恢复
  g_nMySpellRecover         :Integer; //魔法恢复
  g_nMyAntiMagic            :Integer; //魔法躲避
  g_nMyHungryState          :Integer; //饥饿状态
  g_btGameGlory :Integer;

  g_nBeadWinExp  :Word; //聚灵珠的经验    由M2发来  20080404
{******************************************************************************}
//摆摊
  g_ShopItems: array[0..9] of TShopItem;
  g_UseShopItem: TShopItem;
  g_UserShopItem: array[0..9] of TShopItem;
  g_sShopName: string;
  g_nShopX: Integer;
  g_nShopY: Integer;
  g_nShopActorIdx: Integer;
  g_btShopIdx: Byte;
  g_dShopSelImage: TDirectDrawSurface;
  g_SelfShopItem: TClientItem;
{******************************************************************************}
  //商铺
  {$IF M2Version = 2} //1.76
  g_boShopUseGold            :Boolean = False;     //商铺是否使用金币
  {$IFEND}
  g_ShopTypePage             :integer;     //商铺类型页
  g_ShopPage                 :integer;     //商铺页数
  g_ShopReturnPage           :integer;     //插件返回商铺页数
  g_ShopItemList             :TList;       //商铺物品列表
  g_ShopSpeciallyItemList    :TList;       //商铺奇珍物品列表
  g_ShopItemName             :String;
  g_nShopItemGold            :Integer;
  ShopIndex                  :integer;
  ShopSpeciallyIndex         :integer;
  ShopGifTime                :LongWord;
  ShopGifFrame               :integer;
  ShopGifExplosionFrame      :integer;
  g_dwShopTick               :LongWord;
  g_dwQueryItems             :LongWord; //限制人物刷新包裹
{******************************************************************************}
//元宝寄售系统 20080316
  g_SellOffItems               :array[0..8] of TClientItem;
  g_SellOffDlgItem             :TClientItem;
  g_SellOffInfo                :TClientDealOffInfo;  //寄售查看正在出售物品 和买物品
  g_SellOffName                :string; //寄售对方名字
  g_SellOffGameGold            :Integer; //寄售的元宝数量
  g_SellOffGameDiaMond         :Integer; //寄售的金刚石数量
  g_SellOffItemIndex           :Byte = 200;   //选择某个物品红字显示
{******************************************************************************}
//小地图
  g_nMouseMinMapX              :Integer;
  g_nMouseMinMapY              :Integer;
  m_dwBlinkTime                :LongWord;
  m_boViewBlink                :Boolean;
{******************************************************************************}
//排行榜
  m_PlayObjectLevelList        :TList; //人物等级排行
  m_WarrorObjectLevelList      :TList; //战士等级排行
  m_WizardObjectLevelList      :TList; //法师等级排行
  m_TaoistObjectLevelList      :TList; //道士等级排行
  m_PlayObjectMasterList       :TList; //徒弟数排行
  m_HeroObjectLevelList        :TList; //英雄等级排行
  m_WarrorHeroObjectLevelList  :TList; //英雄战士等级排行
  m_WizardHeroObjectLevelList  :TList; //英雄法师等级排行
  m_TaoistHeroObjectLevelList  :TList; //英雄道士等级排行
  {$IF M2Version <> 2}
  g_UserItemLevelList          :TList; //装备排行榜
  {$IFEND}
  //M2 发来的----
  nLevelOrderSortType          :Integer;    //排行总分类
  nLevelOrderType              :Integer;    //排行小分类
  nLevelOrderTypePageCount     :Integer;    //排行某个小分类总页数
  //-----
  //客户端自己的
  nLevelOrderPage              :Integer;     //某个小分类当前页数
  nLevelOrderSortTypePage      :integer;     //排行总分类当前类型
  nLevelOrderTypePage          :Integer;     //排行小分类当前类型
  nLevelOrderIndex             :Integer;     //点击某个行的索引 20080304
{******************************************************************************}

  g_wAvailIDDay                :Word;
  g_wAvailIDHour               :Word;
  g_wAvailIPDay                :Word;
  g_wAvailIPHour               :Word;

  g_MySelf                     :THumActor;
  g_UseItems                   :array[0..U_TakeItemCount-1] of TClientItem;
{******************************************************************************}
  //宝箱
  g_dwBoxsTick                 :LongWord;
  g_nBoxsImg                   :Integer;
  g_boPutBoxsKey               :boolean;  //是否放上宝箱钥匙
  g_BoxsItemList               :TList;       //宝箱物品列表
  g_BoxsItems                  :array[0..11] of TClientItem;
  g_JLBoxItems                 :array[0..7] of TBoxsInfo; //珍珑宝箱
  g_JLBoxFreeItems             :array[0..19] of TJLBoxFreeItem; //珍珑宝箱免费奖励
  g_dwBoxsTautologyTick        :LongWord;   //乾坤动画
  g_BoxsTautologyImg           :Integer;    //乾坤动画
  g_boBoxsFlash                :Boolean;
  g_dwBoxsFlashTick            :LongWord;
  g_BoxsFlashImg               :Integer;
  g_BoxsbsImg                  :Integer;//边框图
  g_BoxsShowPosition           :Integer = -1;//显示转动动画位置
  g_BoxsShowPositionTick       :LongWord;
  g_boBoxsShowPosition         :Boolean; //是否开始转动  //珍龙宝箱为更换奖励
  g_BoxsMoveDegree             :Integer; //转动次数   珍珑宝箱为 选择的时候 单击了哪个
//  g_BoxsShowPositionTime       :Integer; //转动间隔
  g_BoxsCircleNum              :Integer; //转动圈数     珍珑宝箱为 更换奖励剩余次数
  g_boBoxsMiddleItems          :Boolean; //显示中间物品    ,珍珑宝箱为 是否显示双击上方暗格选择
  g_BoxsMakeIndex              :Integer; //接收过来的可得物品ID  ,珍珑宝箱为可得物品ID
  //g_BoxsGold                   :Integer; //接收过来的转动需要金币
  //g_BoxsGameGold               :Integer; //接收过来的转动需要元宝
  g_BoxsFirstMove              :Boolean; //是否第一次转动宝箱   ,珍珑宝箱为 是否显示动画，显示动画提示不显示作用
  g_BoxsTempKeyItems           :TClientItem; //宝箱钥匙临时存放物品  失败则返回次物品   20080306
  g_boNewBoxs                  :Byte=0; //0为老宝箱 1为新宝箱  2为珍珑宝箱  3为珍珑宝箱子免费奖励
  g_BoxsIsFill                 :Byte=0; //0为不填充 1为三格物品显示动画，2为下面物品显示动画, 3为全部换物品效果    珍珑的3为选择物品动画  珍珑的4为选择完物品的动画  5为显示完物品的动画2  6为显示获取到物品的动画  7为全部更换物品显示的动画 8为全部更换完物品后 X的物品显示动画 254为开启天赐结束
  g_nPlayGetItmesID            :Byte; //玩家得到的物品所在宝箱里的数组   1为珍珑宝箱显示选中物品   2为珍珑宝箱一个一个显示出物品  3为珍珑免费奖励开启新天赐
  g_nFilledGetItmesID          :Byte; //填充的物品所在宝箱里的数组   珍珑宝箱为 剩余XX张开启
  g_dwBoxsFilleFlashTick       :LongWord; //填充动画时间间隔
  g_BoxsFilleFlashImg          :Integer;  //填充动画时间间隔
  g_boBoxsLockGetItems         :Boolean; //是否锁定获得物品   填充完物品所用    珍珑宝箱为盖住物品作用
  g_JLBoxAllItemTag            :Byte; //珍珑宝箱更换全部物品动画最后
  g_boJLBoxFirstStartSel       :Boolean; //是否第1次点开始选择
  g_boJLBoxSelToTime           :Boolean; //珍珑宝箱开始选择到计时
{******************************************************************************}
  //卧龙
  g_LieDragonNpcIndex          :Integer;
  g_LieDragonPage              :Integer;

(*******************************************************************************)
  //自动防药临时变量
  g_TempItemArr                :TClientItem; //自动放药 临时储存 20080229
  g_TempIdx                    :Byte;
  g_BeltIdx                    :Byte;
(*******************************************************************************)
  g_boBagLoaded                :Boolean;
  g_boServerChanging           :Boolean;

  //键盘相关
  g_ToolMenuHook               :HHOOK;
  g_nLastHookKey               :Integer;
  g_dwLastHookKeyTime          :LongWord;

  g_nCaptureSerial             :Integer; //抓图文件名序号
  g_nSendCount                 :Integer; //发送操作计数
  //g_nReceiveCount              :Integer; //接改操作状态计数
  g_nSpellCount                :Integer; //使用魔法计数
  g_nSpellFailCount            :Integer; //使用魔法失败计数
  g_nFireCount                 :Integer; //

  //买卖相关
  g_SellDlgItem                :TClientItem;
  g_SellDlgItemSellWait        :TClientItem;
  g_DealDlgItem                :TClientItem;
  g_boQueryPrice               :Boolean;
  g_dwQueryPriceTime           :LongWord;
  g_sSellPriceStr              :String;

  //交易相关
  g_DealItems                  :array[0..9] of TClientItem;
  g_DealRemoteItems            :array[0..19] of TClientItem;
  g_nDealGold                  :Integer;
  g_nDealRemoteGold            :Integer;
  g_boDealEnd                  :Boolean;
  g_sDealWho                   :String;  //交易对方名字
  g_MouseItem                  :TClientItem;
  g_MouseStateItem             :TClientItem;
{******************************************************************************}
//挑战
  g_sChallengeWho              :String;  //挑战对方名字
  g_ChallengeItems             :array[0..3] of TClientItem;
  g_ChallengeRemoteItems       :array[0..3] of TClientItem;
  g_nChallengeGold             :Integer;
  g_nChallengeRemoteGold       :Integer;
  g_nChallengeDiamond          :Integer;
  g_nChallengeRemoteDiamond    :Integer;
  g_boChallengeEnd             :Boolean;
  g_dwChallengeActionTick      :LongWord;
  g_ChallengeDlgItem           :TClientItem;
{******************************************************************************}
  g_HeroItemArr                :array[0..MAXBAGITEMCL-1] of TClientItem;
  g_ItemArr                    :array[0..MAXBAGITEMCL-1] of TItemArr;//TClientEffecItem;
  //查看别人装备
  g_MouseUserStateItem         :TClientItem;
  g_boUserIsWho                :Byte;  //1为英雄 2为分身
{******************************************************************************}
//关系系统
  g_btFriendTypePage           :Byte = 1;   //菜单页数 20080527
  g_FriendList                 :TStringList; //好友列表
  g_HeiMingDanList             :TStringList; //黑名单列表
  g_TargetList                 :TStringList; //目标列表
  g_btFriendPage               :Byte = 0;   //好友和黑名单页数 20080527
  g_btFriendIndex              :Byte = 0;
  g_btFriendMoveX              :Integer;
  g_btFriendMoveY              :Integer;
{******************************************************************************}
  g_boItemMoving               :Boolean;  //正在移动物品
  g_MovingItem                 :TMovingItem;
  g_WaitingUseItem             :TMovingItem;
  g_FocusItem                  :pTDropItem;
  {$IF M2Version = 2}
  g_boViewFog                  :Boolean;  //是否显示黑暗 20080816注释显示黑暗
  {$IFEND}
  //g_boForceNotViewFog          :Boolean = False;  //免蜡烛  20080816注释免蜡
  g_nDayBright                 :Integer;
  g_nAreaStateValue            :Integer;  //显示当前所在地图状态(攻城区域、)

  g_boNoDarkness               :Boolean;
  g_nRunReadyCount             :Integer; //助跑就绪次数，在跑前必须走几步助跑

  g_ClientConf                 :TClientConf;
  g_dwPHHitSound               :LongWord;
  g_EatingItem                 :TClientItem;
  g_dwEatTime                  :LongWord; //timeout...
  g_dwHeroEatTime              :LongWord;
  g_MergerItem                 :TClientItem;
  g_dwMergerTime               :LongWord; //timeout...
  g_dwSocketConnectTick        :LongWord; //防止过快点击Logo导致无法连接By TasNat at: 2012-10-31 09:56:39
  g_dwDizzyDelayStart          :LongWord;
  g_dwDizzyDelayTime           :LongWord;

  g_boDoFadeOut                :Boolean;
  g_boDoFadeIn                 :Boolean;
  g_nFadeIndex                 :Integer;
  g_boDoFastFadeOut            :Boolean;

  g_dwCIDHitTime               :longWord;

  g_boAutoDig                  :Boolean;  //自动锄矿
  g_boSelectMyself             :Boolean;  //鼠标是否指到自己
  g_UnBindList                 :TList;       //服务器解包文件

  //游戏速度检测相关变量
  //g_dwFirstServerTime       :LongWord;
  //g_dwFirstClientTime       :LongWord;
  //ServerTimeGap: int64;
  //g_nTimeFakeDetectCount    :Integer;
//  g_dwSHGetTime             :LongWord;
  //g_dwSHTimerTime           :LongWord;
  //g_nSHFakeCount            :Integer;   //检查机器速度异常次数，如果超过4次则提示速度不稳定

{******************************************************************************}
//外挂功能变量开始
  g_nDuFuIndex           :Byte;   //自动毒符的索引  20080315
  g_nDuWhich             :byte;   //记录当前使用的是哪种毒 20080315
  g_boLoadSdoAssistantConfig :Boolean = False;
  g_nHitTime             :Integer  = 1400;  //攻击间隔时间间隔
  g_nItemSpeed           :Integer  = 60;
  g_dwSpellTime          :LongWord = 500;  //魔法攻间隔时间
  g_DeathColorEffect     :TColorEffect = ceGrayScale; //死亡颜色
  {$IF M2Version = 2}
  g_boShowNewItem        :Boolean  = False;//是否显示四格 By TasNat at: 2012-10-20 10:15:49
  {$ifend}
  g_boCanRunHuman        :Boolean  = False;//是否可以穿人
  g_boCanRunMon          :Boolean  = False;//是否可以穿怪
  g_boCanRunNpc          :Boolean  = False;//是否可以穿NPC
  g_boCanRunAllInWarZone :Boolean  = False; //攻城区域是否传人穿怪穿NPC
  g_boCanStartRun        :Boolean  = true; //是否允许免助跑
  {g_boParalyCanRun       :Boolean  = False;//麻痹是否可以跑
  g_boParalyCanWalk      :Boolean  = False;//麻痹是否可以走
  g_boParalyCanHit       :Boolean  = False;//麻痹是否可以攻击
  g_boParalyCanSpell     :Boolean  = False;//麻痹是否可以魔法  }
  g_boDuraWarning        :Boolean  = False; //物品持久警告
  g_boMagicLock          :Boolean  = False; //魔法锁定
  g_boAutoPuckUpItem     :Boolean  = False; //自动捡取物品
  //g_boMoveSlow1          :Boolean  = False; //免负重； 20080816注释掉起步负重
  g_boShowName           :Boolean  = False; //人名显示
  g_boNoShift            :Boolean  = False;  //免Shift
  g_AutoPut              :Boolean   =true;  //自动解包  
  g_boLongHit            :Boolean  = False;  //刀刀刺杀
  g_boPosLongHit         :Boolean  = False;  //隔位刺杀
  g_boAutoFireHit        :Boolean  = False;  //自动烈火
  g_boAutoWideHit        :Boolean  = False;  //智能半月
  g_boAutoHide           :Boolean  = False;  //自动隐身
  g_boAutoShield         :Boolean  = False;  //自动魔法盾
  g_boAutoMagic          :Boolean  = False;  //自动练功
  g_boAutoTalk           :Boolean  = False;  //自动喊话
  g_btAutoTalkNum        :Byte;
  g_sAutoTalkStr         :string;            //喊话内容
  g_boExpFiltrate        :Boolean  = False;  //经验显示过滤
  g_boShowMimiMapDesc    :Boolean  = False;  //显示小地图标实
  g_boShowHeroStateNumber:Boolean  = False;  //显示英雄状态数字
//外挂功能变量结束
{******************************************************************************}
  g_nAutoTalkTimer       :LongWord = 8;  //自动喊话  间隔
//  g_sRandomName          :string;

  g_nAutoMagicTime       :LongWord = 0;
  g_nAutoMagicTimekick   :LongWord;
  g_nAutoMagicKey        :Word;
  g_nAutoMagic           :LongWord;
  g_SHowWarningDura      :DWord;
  g_dwAutoPickupTick     :LongWord;
  g_AutoPickupList       :TList;

  g_MagicLockActor       :TActor;
  g_boOwnerMsg           :Boolean; //是否拒绝公聊 2008.01.11
  g_boNextTimePowerHit   :Boolean;
  g_boCanLongHit         :Boolean;
  g_boCanLongHit4        :Boolean; //4级刺杀剑术
  g_boCanWideHit         :Boolean;
  g_boCanWideHit4        :Boolean; //圆月
  g_boCanCrsHit          :Boolean;
  g_boCanTwnHit          :Boolean; //重击开天斩

  g_boCanQTwnHit         :Boolean; //轻击开天斩 2008.02.12

  g_boCanCIDHit          :Boolean; //龙影剑法
  g_boCanCXCHit1         :Boolean; //追心刺
  g_boCanCXCHit2         :Boolean; //三绝杀
  g_boCanCXCHit3         :Boolean; //横扫千军
  g_boCanCXCHit4         :Boolean; //断岳斩
  g_boCanCXCHit          :Boolean; //是否正在使用连击
  g_boCanStnHit          :Boolean;
  g_boNextTimeFireHit    :Boolean; //烈火
  g_boNextTime4FireHit   :Boolean; //4级烈火
  g_boNextItemDAILYHit   :Boolean; //逐日剑法 20080511
  g_boNextSoulHit        :Boolean; //血魄一击(战)
//  g_boCan69Hit           :Boolean;
  g_boShowAllItem        :Boolean = False;//显示地面所有物品名称
  //g_boDrawTileMap        :Boolean = False;
  //g_boDrawDropItem       :Boolean = True;
  g_EffecItemtList: TStringList;//物品特效 By TasNat at: 2012-11-18 09:06:12
  g_boLOGINKEYOk : Boolean;
  g_Config: TConfig = (
    SuperMedicaItemNames: ('太阳水', '强效太阳水', '万年雪霜', '疗伤药', '疗伤药(任务)', '强效万年雪霜', '强效疗伤药', '超级万年雪霜', '超级疗伤药', '', '', '', '', '');
  );
  procedure LoadWMImagesLib(AOwner: TComponent);
  procedure InitWMImagesLib(DDxDraw: TDxDraw);
  procedure InitUiWMImagesLib(DDxDraw: TDxDraw);
  procedure UnLoadWMImagesLib();
  function  GetObjs (nUnit,nIdx:Integer):TDirectDrawSurface;
  function  GetTiles(nUnit,nIdx:Integer):TDirectDrawSurface;
  function  GetSmTiles(nUnit,nIdx:Integer):TDirectDrawSurface;
  function  GetObjsEx (nUnit,nIdx:Integer; var px, py: integer): TDirectDrawSurface;
  function  GetMonImg (nAppr:Integer):TWMImages;
  procedure InitMonImg();
  procedure InitObjectImg();
  procedure InitTilesImg();
  procedure InitSmTilesImg();
  //function  GetMonAction (nAppr:Integer):pTMonsterAction;
  function  GetJobName (nJob:Integer):String;
  function GetPulseName (btPage,btIndex: Byte): string;
  function GetPulsePageName (btPage: Byte): string;

  procedure InitConfig(); //初始化内挂变量
  procedure CreateSdoAssistant();//初始化盛大内挂
  procedure LoadSdoAssistantConfig(sUserName:String);//加载盛大挂配置
  procedure SaveSdoAssistantConfig(sUserName:String);//储存盛大挂配置

  function Encrypt(const s:string; skey:string):string;
  function decrypt(const s:string; skey:string):string;

  Function SetDate(Text: String): String;
  function DeGhost(Source, Key: string): string;

  function CertKey(key: string): string;//加密函数
  function GetAdoSouse(S: String): String;
  function DecodeString_RC6(Source, Key: string): string;
  procedure SeqNumEnc(var Str: String; Key: Word; Times: Integer);
  function ProgramPath: string; //得到文件自身的路径及文件名
  procedure ExtractInfo(const FilePath: string; var MyRecInfo: TRecInfo);  //读出自身配置等信息

  function GetTzInfo(Items: string; Who: Byte):pTTzHintInfo; //取得套装结构
  function GetTzStateInfo(TzInfo: pTTzHintInfo;Who: Byte):string;
  function GetTzMemoInfo(TzInfo: pTTzHintInfo;StateCount, Who: Byte):string;
  function GetItemDesc(sName: string): string;
  function GetPulsDesc(sName: string): string;
  function GetSkillDesc(sType, sName: string): string;
  function GetItemType(ItemType: string): TItemType;
  function GetItemTypeName(ItemType: TItemType): string;
  {$IF M2Version <> 2}
  function GetTitleDesc(sName: string): string;
  function GetNewStateTitleDesc(sName: string): string;
  {$IFEND}
  {$IF GVersion = 1}
  function DestroyList(sItem: string):Boolean;  //免费登录器退弹广告
  {$IFEND}
  function GetColorDepth: Integer; //获得系统当前颜色
  function Resolution(X :word): Boolean; //改变颜色
  function GetDisplayFrequency: Integer;//得到刷新率
  procedure ChangeDisplayFrequency(iFrequency:Integer);//更改刷新率,在Win2000下成功
  function GetTime():Double;
  function GetEffecItemList(const ItemName: String): TEffecItem;
  procedure LoadEffecItemList();
implementation
uses FState, ClMain, HUtil32, Menus{$IF GVersion = 1},ComObj{$IFEND}, Splash;

function GetTime():Double;
var
  hires: Boolean;
  freq: Int64;
  nNow: Int64;
begin
  hires := False;
  hires := QueryPerformanceFrequency(freq);
  if not hires then freq := 1000;
  if hires then
    QueryPerformanceCounter(nNow)
  else nNow := GetTickCount();
  Result := nNow/freq*1000;
end;

//加载物品特效规则
procedure LoadEffecItemList();
var
  I: Integer;
  sFileName, sLineText, sItemName, sPackLook, sPackPlay,sPackX,sPackY,sPackWilName: string;
  sWithinLook,sWithinPlay,sWithinX,sWithinY,sWithinWilName: string;
  sOutsideLook,{sOutsidePlay,sOutsideX,sOutsideY,}sOutsideWilName: string;
  LoadList: TStringList;
  EffecItem: pTEffecItem;
begin
  sFileName := g_ParamDir+'\Data\EffectItem.dat';
  if not FileExists(sFileName) then begin
    LoadList.Free;
    Exit;
  end;
  LoadList := TStringList.Create();
  try
    LoadList.LoadFromFile(sFileName);
    if LoadList.Count > 0 then begin
      for I := 0 to LoadList.Count - 1 do begin
        sLineText := LoadList.Strings[I];
        if (sLineText <> '') and (sLineText[1] <> ';') then begin
          sItemName:='';
          sPackLook:='';
          sPackPlay:='';
          sPackX:='';
          sPackY:='';
          sPackWilName:='';
          sWithinLook:='';
          sWithinPlay:='';
          sWithinX:='';
          sWithinY:='';
          sWithinWilName:='';
          sOutsideLook:='';
          {sOutsidePlay:='';
          sOutsideX:='';
          sOutsideY:=''; }
          sOutsideWilName:='';
          sLineText := GetValidStr3(sLineText, sItemName, [' ', #9]);
          sLineText := GetValidStr3(sLineText, sPackLook, [' ', #9]);
          sLineText := GetValidStr3(sLineText, sPackPlay, [' ', #9]);
          sLineText := GetValidStr3(sLineText, sPackX, [' ', #9]);
          sLineText := GetValidStr3(sLineText, sPackY, [' ', #9]);
          sLineText := GetValidStr3(sLineText, sPackWilName, [' ', #9]);

          sLineText := GetValidStr3(sLineText, sWithinLook, [' ', #9]);
          sLineText := GetValidStr3(sLineText, sWithinPlay, [' ', #9]);
          sLineText := GetValidStr3(sLineText, sWithinX, [' ', #9]);
          sLineText := GetValidStr3(sLineText, sWithinY, [' ', #9]);
          sLineText := GetValidStr3(sLineText, sWithinWilName, [' ', #9]);

          sLineText := GetValidStr3(sLineText, sOutsideLook, [' ', #9]);
          {sLineText := GetValidStr3(sLineText, sOutsidePlay, [' ', #9]);
          sLineText := GetValidStr3(sLineText, sOutsideX, [' ', #9]);
          sLineText := GetValidStr3(sLineText, sOutsideY, [' ', #9]); }
          sLineText := GetValidStr3(sLineText, sOutsideWilName, [' ', #9]);

          if (sItemName <> '') and (sPackWilName <> '') and (sWithinWilName <>'')
            and (sOutsideWilName <> '') then begin
            New(EffecItem);
            EffecItem.wBagIndex:= 0;//包裹开始图片
            EffecItem.btBagCount:= 0;//包裹播放数量
            EffecItem.nBagX:= 0;//包裹X坐标修正
            EffecItem.nBagY:= 0;//包裹Y坐标修正
            EffecItem.btBagWilIndex:= 0;//包裹Wil索引
            EffecItem.wShapeIndex:= 0;//内观开始图片
            EffecItem.btShapeCount:= 0;//内观播放数量
            EffecItem.nShapeX:= 0;//内观X坐标修正
            EffecItem.nShapeY:= 0;//内观Y坐标修正
            EffecItem.btShapeWilIndex:= 0;//内观Wil索引
            EffecItem.wLookIndex:= 0;//外观开始图片
            //EffecItem.btLookCount:= 0;//外观播放数量
            //EffecItem.nLookX:= 0;//外观X坐标修正
            //EffecItem.nLookY:= 0;//外观Y坐标修正
            EffecItem.btLookWilIndex:= 0;//外观Wil索引
            try
              EffecItem.wBagIndex:= Str_ToInt(sPackLook,0);//包裹开始图片
              EffecItem.btBagCount:= Str_ToInt(sPackPlay,0);//包裹播放数量
              EffecItem.nBagX:= Str_ToInt(sPackX,0);//包裹X坐标修正
              EffecItem.nBagY:= Str_ToInt(sPackY,0);//包裹Y坐标修正
              EffecItem.btBagWilIndex:= Str_ToInt(sPackWilName,0);//包裹Wil索引

              EffecItem.wShapeIndex:= Str_ToInt(sWithinLook,0);//内观开始图片
              EffecItem.btShapeCount:= Str_ToInt(sWithinPlay,0);//内观播放数量
              EffecItem.nShapeX:= Str_ToInt(sWithinX,0);//内观X坐标修正
              EffecItem.nShapeY:= Str_ToInt(sWithinY,0);//内观Y坐标修正
              EffecItem.btShapeWilIndex:= Str_ToInt(sWithinWilName,0);//内观Wil索引

              EffecItem.wLookIndex:= Str_ToInt(sOutsideLook,0);//外观开始图片
              //EffecItem.btLookCount:= Str_ToInt(sOutsidePlay,0);//外观播放数量
              //EffecItem.nLookX:= Str_ToInt(sOutsideX,0);//外观X坐标修正
              //EffecItem.nLookY:= Str_ToInt(sOutsideY,0);//外观Y坐标修正
              EffecItem.btLookWilIndex:= Str_ToInt(sOutsideWilName,0);//外观Wil索引
              g_EffecItemtList.AddObject(sItemName, TObject(EffecItem));
            except
              Dispose(EffecItem);
            end;
          end;
        end;
      end;
    end;
  finally
    LoadList.Free;
  end;
end;

//取物品特效
function GetEffecItemList(const ItemName: String): TEffecItem;
var
  I: Integer;
begin
  FillChar(Result, SizeOf(Result), 0);
  Result.wLookIndex := 65535;
  if (g_EffecItemtList = nil) or (ItemName='') then Exit;
  if g_EffecItemtList.Count > 0 then begin
    I:= g_EffecItemtList.IndexOf(ItemName);
    if I > -1 then begin
      Result:= pTEffecItem(g_EffecItemtList.Objects[I])^;
    end;
  end;
end;

procedure LoadWMImagesLib(AOwner: TComponent);
begin
  g_WMainImages        := TWMImages.Create(AOwner);
  g_WMain2Images       := TWMImages.Create(AOwner);
  g_WMain3Images       := TWMImages.Create(AOwner);
  g_WChrSelImages      := TWMImages.Create(AOwner);
  g_WMMapImages        := TWMImages.Create(AOwner);
  g_WHumWingImages     := TWMImages.Create(AOwner);
  g_WHumWing2Images    := TWMImages.Create(AOwner);
  g_WHumWing3Images    := TWMImages.Create(AOwner);
  g_WHumWing4Images    := TWMImages.Create(AOwner);
  g_WBagItemImages     := TWMImages.Create(AOwner);
  g_WBagItem2Images    := TWMImages.Create(AOwner);
  g_WStateItemImages   := TWMImages.Create(AOwner);
  g_WStateItem2Images  := TWMImages.Create(AOwner);
  g_WDnItemImages      := TWMImages.Create(AOwner);
  g_WDnItem2Images     := TWMImages.Create(AOwner);
  g_WHumImgImages      := TWMImages.Create(AOwner);
  g_WHum2ImgImages     := TWMImages.Create(AOwner); //20080501
  g_WHum3ImgImages     := TWMImages.Create(AOwner);
  g_WHum4ImgImages     := TWMImages.Create(AOwner);
  g_WCboHumImgImages   := TWMImages.Create(AOwner);
  g_WCboHum3ImgImages  := TWMImages.Create(AOwner);
  g_WCboHum4ImgImages  := TWMImages.Create(AOwner);
  g_WHairImgImages     := TWMImages.Create(AOwner);
  g_WCboHairImgImages  := TWMImages.Create(AOwner);
  g_WWeaponImages      := TWMImages.Create(AOwner);
  g_WCboWeaponImages   := TWMImages.Create(AOwner);
  g_WCboWeaponImages3  := TWMImages.Create(AOwner);
  g_WCboWeaponImages4  := TWMImages.Create(AOwner);
  g_WWeapon2Images     := TWMImages.Create(AOwner); //20080501
  g_WWeapon3Images     := TWMImages.Create(AOwner);
  g_WWeapon4Images     := TWMImages.Create(AOwner);
  g_WMagIconImages     := TWMImages.Create(AOwner);
  g_WMagIcon2Images    := TWMImages.Create(AOwner);
  g_WNpcImgImages      := TWMImages.Create(AOwner);
  g_WNpc2ImgImages     := TWMImages.Create(AOwner);
  g_WMagicImages       := TWMImages.Create(AOwner);
  g_WMagic2Images      := TWMImages.Create(AOwner);
  g_WMagic3Images      := TWMImages.Create(AOwner);
  g_WMagic4Images      := TWMImages.Create(AOwner);    //2007.10.28
  g_WMagic5Images      := TWMImages.Create(AOwner);   //207.11.29
  g_WMagic6Images      := TWMImages.Create(AOwner);   //207.11.29

  g_WMagic7Images      := TWMImages.Create(AOwner);
  g_WMagic7Images16    := TWMImages.Create(AOwner);
  g_WMagic8Images      := TWMImages.Create(AOwner);
  g_WMagic8Images16    := TWMImages.Create(AOwner);
  g_WMagic9Images      := TWMImages.Create(AOwner);
  g_WMagic10Images     := TWMImages.Create(AOwner);

  g_WMonKuLouImages    := TWMImages.Create(AOwner);
  g_WEffectImages      := TWMImages.Create(AOwner);
  g_qingqingImages     := TWMImages.Create(AOwner);
  g_WchantkkImages     := TWMImages.Create(AOwner);
  g_WDragonImages      := TWMImages.Create(AOwner);
  g_WUiMainImages      := TUIWMImages.Create;
  g_WWeaponEffectImages:= TWMImages.Create(AOwner);
  g_WWeaponEffectImages4:= TWMImages.Create(AOwner);
  g_WCboWeaponEffectImages4:= TWMImages.Create(AOwner);


  g_WCboHumWingImages  := TWMImages.Create(AOwner);
  g_WCboHumWingImages2 := TWMImages.Create(AOwner);
  g_WCboHumWingImages3 := TWMImages.Create(AOwner);
  g_WCboHumWingImages4 := TWMImages.Create(AOwner);
  g_WCboEffectImages   := TWMImages.Create(AOwner);
  g_WUI1Images := TWMImages.Create(AOwner);
  g_WUI3Images := TWMImages.Create(AOwner);
  g_WchantkkImages := TWMImages.Create(AOwner);
  g_WStateEffectImages := TWMImages.Create(AOwner);
  FillChar(g_WObjectArr, SizeOf(g_WObjectArr), 0);
  FillChar(g_WTilesArr, SizeOf(g_WTilesArr), 0);
  FillChar(g_WSMTilesArr, SizeOf(g_WSMTilesArr), 0);
  FillChar(g_WMonImagesArr, SizeOf(g_WMonImagesArr), 0);
end;

procedure InitWMImagesLib(DDxDraw: TDxDraw);
begin
  g_WMainImages.DxDraw    := DDxDraw;
  g_WMainImages.DDraw     := DDxDraw.DDraw;
  if FileExists(g_ParamDir+MAINIMAGEFILE1) then begin//Wis文件存在，则读取wis，不存在则读wil文件
    g_WMainImages.FileName  := g_ParamDir+MAINIMAGEFILE1;
  end else g_WMainImages.FileName  := g_ParamDir+MAINIMAGEFILE;
  g_WMainImages.LibType   := ltUseCache;
  g_WMainImages.Initialize;

  g_WMain2Images.DxDraw   := DDxDraw;
  g_WMain2Images.DDraw    := DDxDraw.DDraw;
  g_WMain2Images.FileName := g_ParamDir+MAINIMAGEFILE2;
  g_WMain2Images.LibType  := ltUseCache;
  g_WMain2Images.Initialize;

  g_WMain3Images.DxDraw   := DDxDraw;
  g_WMain3Images.DDraw    := DDxDraw.DDraw;
  g_WMain3Images.FileName := g_ParamDir+MAINIMAGEFILE3;
  g_WMain3Images.LibType  := ltUseCache;
  g_WMain3Images.Initialize;

  g_WChrSelImages.DxDraw   := DDxDraw;
  g_WChrSelImages.DDraw    := DDxDraw.DDraw;
  g_WChrSelImages.FileName := g_ParamDir+CHRSELIMAGEFILE;
  g_WChrSelImages.LibType  := ltUseCache;
  g_WChrSelImages.Initialize;

  g_WMMapImages.DxDraw     := DDxDraw;
  g_WMMapImages.DDraw      := DDxDraw.DDraw;
  g_WMMapImages.FileName   := g_ParamDir+MINMAPIMAGEFILE;
  g_WMMapImages.LibType    := ltUseCache;
  g_WMMapImages.Initialize;

  g_WHumWingImages.DxDraw   := DDxDraw;
  g_WHumWingImages.DDraw    := DDxDraw.DDraw;
  g_WHumWingImages.FileName := g_ParamDir+HUMWINGIMAGESFILE;
  g_WHumWingImages.LibType  := ltUseCache;
  g_WHumWingImages.Initialize;

  g_WHumWing2Images.DxDraw   := DDxDraw;
  g_WHumWing2Images.DDraw    := DDxDraw.DDraw;
  g_WHumWing2Images.FileName := g_ParamDir+HUMWINGIMAGESFILE2;
  g_WHumWing2Images.LibType  := ltUseCache;
  g_WHumWing2Images.Initialize;

  g_WHumWing3Images.DxDraw   := DDxDraw;
  g_WHumWing3Images.DDraw    := DDxDraw.DDraw;
  g_WHumWing3Images.FileName := g_ParamDir+HUMWINGIMAGESFILE3;
  g_WHumWing3Images.LibType  := ltUseCache;
  g_WHumWing3Images.Initialize;

  g_WHumWing4Images.DxDraw   := DDxDraw;
  g_WHumWing4Images.DDraw    := DDxDraw.DDraw;
  g_WHumWing4Images.FileName := g_ParamDir+HUMWINGIMAGESFILE4;
  g_WHumWing4Images.LibType  := ltUseCache;
  g_WHumWing4Images.Initialize;

  g_WCboHumWingImages.DxDraw   := DDxDraw;
  g_WCboHumWingImages.DDraw    := DDxDraw.DDraw;
  g_WCboHumWingImages.FileName := g_ParamDir+CBOHUMWINGIMAGESFILE;
  g_WCboHumWingImages.LibType  := ltUseCache;
  g_WCboHumWingImages.Initialize;   

  g_WCboHumWingImages2.DxDraw := DDxDraw;
  g_WCboHumWingImages2.DDraw := DDxDraw.DDraw;
  g_WCboHumWingImages2.FileName := g_ParamDir+CBOHUMWINGIMAGESFILE2;
  g_WCboHumWingImages2.LibType := ltUseCache;
  g_WCboHumWingImages2.Initialize;

  g_WCboHumWingImages3.DxDraw := DDxDraw;
  g_WCboHumWingImages3.DDraw := DDxDraw.DDraw;
  g_WCboHumWingImages3.FileName := g_ParamDir+CBOHUMWINGIMAGESFILE3;
  g_WCboHumWingImages3.LibType := ltUseCache;
  g_WCboHumWingImages3.Initialize;

  g_WCboHumWingImages4.DxDraw := DDxDraw;
  g_WCboHumWingImages4.DDraw := DDxDraw.DDraw;
  g_WCboHumWingImages4.FileName := g_ParamDir+CBOHUMWINGIMAGESFILE4;
  g_WCboHumWingImages4.LibType := ltUseCache;
  g_WCboHumWingImages4.Initialize;






  g_WBagItemImages.DxDraw   := DDxDraw;
  g_WBagItemImages.DDraw    := DDxDraw.DDraw;
  if FileExists(g_ParamDir+BAGITEMIMAGESFILE1) then begin//Wis文件存在，则读取wis，不存在则读wil文件
    g_WBagItemImages.FileName := g_ParamDir+BAGITEMIMAGESFILE1;
  end else g_WBagItemImages.FileName := g_ParamDir+BAGITEMIMAGESFILE;
  g_WBagItemImages.LibType  := ltUseCache;
  g_WBagItemImages.Initialize;

  g_WBagItem2Images.DxDraw   := DDxDraw;
  g_WBagItem2Images.DDraw    := DDxDraw.DDraw;
  g_WBagItem2Images.FileName := g_ParamDir+BAGITEMIMAGESFILE2;
  g_WBagItem2Images.LibType  := ltUseCache;
  g_WBagItem2Images.Initialize;

  g_WStateItemImages.DxDraw   := DDxDraw;
  g_WStateItemImages.DDraw    := DDxDraw.DDraw;
  if FileExists(g_ParamDir+STATEITEMIMAGESFILE1) then begin//Wis文件存在，则读取wis，不存在则读wil文件
    g_WStateItemImages.FileName := g_ParamDir+STATEITEMIMAGESFILE1;
  end else g_WStateItemImages.FileName := g_ParamDir+STATEITEMIMAGESFILE;
  g_WStateItemImages.LibType  := ltUseCache;
  g_WStateItemImages.Initialize;

  g_WStateItem2Images.DxDraw   := DDxDraw;
  g_WStateItem2Images.DDraw    := DDxDraw.DDraw;
  g_WStateItem2Images.FileName := g_ParamDir+STATEITEMIMAGESFILE2;
  g_WStateItem2Images.LibType  := ltUseCache;
  g_WStateItem2Images.Initialize;

  g_WDnItemImages.DxDraw:=DDxDraw;
  g_WDnItemImages.DDraw:=DDxDraw.DDraw;
  if FileExists(g_ParamDir+DNITEMIMAGESFILE1) then begin//Wis文件存在，则读取wis，不存在则读wil文件
    g_WDnItemImages.FileName:=g_ParamDir+DNITEMIMAGESFILE1;
  end else g_WDnItemImages.FileName:=g_ParamDir+DNITEMIMAGESFILE;
  g_WDnItemImages.LibType:=ltUseCache;
  g_WDnItemImages.Initialize;

  g_WDnItem2Images.DxDraw:=DDxDraw;
  g_WDnItem2Images.DDraw:=DDxDraw.DDraw;
  g_WDnItem2Images.FileName:=g_ParamDir+DNITEMIMAGESFILE2;
  g_WDnItem2Images.LibType:=ltUseCache;
  g_WDnItem2Images.Initialize;

  g_WHumImgImages.DxDraw:=DDxDraw;
  g_WHumImgImages.DDraw:=DDxDraw.DDraw;
  g_WHumImgImages.FileName:=g_ParamDir+HUMIMGIMAGESFILE;
  g_WHumImgImages.LibType:=ltUseCache;
  g_WHumImgImages.Initialize;

  g_WHum2ImgImages.DxDraw:=DDxDraw;
  g_WHum2ImgImages.DDraw:=DDxDraw.DDraw;
  g_WHum2ImgImages.FileName:=g_ParamDir+HUM2IMGIMAGESFILE;
  g_WHum2ImgImages.LibType:=ltUseCache;
  g_WHum2ImgImages.Initialize;

  g_WHum3ImgImages.DxDraw:=DDxDraw;
  g_WHum3ImgImages.DDraw:=DDxDraw.DDraw;
  g_WHum3ImgImages.FileName:=g_ParamDir+HUM3IMGIMAGESFILE;
  g_WHum3ImgImages.LibType:=ltUseCache;
  g_WHum3ImgImages.Initialize;

  g_WHum4ImgImages.DxDraw:=DDxDraw;
  g_WHum4ImgImages.DDraw:=DDxDraw.DDraw;
  g_WHum4ImgImages.FileName:=g_ParamDir+HUM4IMGIMAGESFILE;
  g_WHum4ImgImages.LibType:=ltUseCache;
  g_WHum4ImgImages.Initialize;

  g_WCboHumImgImages.DxDraw:=DDxDraw;
  g_WCboHumImgImages.DDraw:=DDxDraw.DDraw;
  g_WCboHumImgImages.FileName:=g_ParamDir+CBOHUMIMGIMAGESFILE;
  g_WCboHumImgImages.LibType:=ltUseCache;
  g_WCboHumImgImages.Initialize;   

  g_WCboHum3ImgImages.DxDraw:=DDxDraw;
  g_WCboHum3ImgImages.DDraw:=DDxDraw.DDraw;
  g_WCboHum3ImgImages.FileName:=g_ParamDir+CBOHUMIMGIMAGESFILE3;
  g_WCboHum3ImgImages.LibType:=ltUseCache;
  g_WCboHum3ImgImages.Initialize;

  g_WCboHum4ImgImages.DxDraw:=DDxDraw;
  g_WCboHum4ImgImages.DDraw:=DDxDraw.DDraw;
  g_WCboHum4ImgImages.FileName:=g_ParamDir+CBOHUMIMGIMAGESFILE4;
  g_WCboHum4ImgImages.LibType:=ltUseCache;
  g_WCboHum4ImgImages.Initialize;

  g_WHairImgImages.DxDraw:=DDxDraw;
  g_WHairImgImages.DDraw:=DDxDraw.DDraw;
  g_WHairImgImages.FileName:=g_ParamDir+HAIRIMGIMAGESFILE;
  g_WHairImgImages.LibType:=ltUseCache;
  g_WHairImgImages.Initialize;

  g_WCboHairImgImages.DxDraw:=DDxDraw;
  g_WCboHairImgImages.DDraw:=DDxDraw.DDraw;
  g_WCboHairImgImages.FileName:=g_ParamDir+CBOHAIRIMAGESFILE;
  g_WCboHairImgImages.LibType:=ltUseCache;
  g_WCboHairImgImages.Initialize;

  g_WWeaponImages.DxDraw:=DDxDraw;
  g_WWeaponImages.DDraw:=DDxDraw.DDraw;
  g_WWeaponImages.FileName:=g_ParamDir+WEAPONIMAGESFILE;
  g_WWeaponImages.LibType:=ltUseCache;
  g_WWeaponImages.Initialize;

  g_WCboWeaponImages.DxDraw:=DDxDraw;
  g_WCboWeaponImages.DDraw:=DDxDraw.DDraw;
  g_WCboWeaponImages.FileName:=g_ParamDir+CBOWEAPONIMAGESFILE;
  g_WCboWeaponImages.LibType:=ltUseCache;
  g_WCboWeaponImages.Initialize;  

  g_WCboWeaponImages3.DxDraw := DDxDraw;
  g_WCboWeaponImages3.DDraw := DDxDraw.DDraw;
  g_WCboWeaponImages3.FileName := g_ParamDir+CBOWEAPONIMAGESFILE3;
  g_WCboWeaponImages3.LibType := ltUseCache;
  g_WCboWeaponImages3.Initialize;

  g_WCboWeaponImages4.DxDraw := DDxDraw;
  g_WCboWeaponImages4.DDraw := DDxDraw.DDraw;
  g_WCboWeaponImages4.FileName := g_ParamDir+CBOWEAPONIMAGESFILE4;
  g_WCboWeaponImages4.LibType := ltUseCache;
  g_WCboWeaponImages4.Initialize;


  g_WWeapon2Images.DxDraw:=DDxDraw;            //20080501
  g_WWeapon2Images.DDraw:=DDxDraw.DDraw;       //20080501
  if FileExists(g_ParamDir+WEAPON2IMAGESFILE1) then begin//Wis文件存在，则读取wis，不存在则读wil文件
    g_WWeapon2Images.FileName:=g_ParamDir+WEAPON2IMAGESFILE1;
  end else g_WWeapon2Images.FileName:=g_ParamDir+WEAPON2IMAGESFILE; //20080501
  g_WWeapon2Images.LibType:=ltUseCache;        //20080501
  g_WWeapon2Images.Initialize;

  g_WWeapon3Images.DxDraw:=DDxDraw;            //20080501
  g_WWeapon3Images.DDraw:=DDxDraw.DDraw;       //20080501
  g_WWeapon3Images.FileName:=g_ParamDir+WEAPON3IMAGESFILE; //20080501
  g_WWeapon3Images.LibType:=ltUseCache;        //20080501
  g_WWeapon3Images.Initialize;

  g_WWeapon4Images.DxDraw:=DDxDraw;            //20080501
  g_WWeapon4Images.DDraw:=DDxDraw.DDraw;       //20080501
  g_WWeapon4Images.FileName:=g_ParamDir+WEAPON4IMAGESFILE; //20080501
  g_WWeapon4Images.LibType:=ltUseCache;        //20080501
  g_WWeapon4Images.Initialize;

  g_WMagIconImages.DxDraw:=DDxDraw;
  g_WMagIconImages.DDraw:=DDxDraw.DDraw;
  g_WMagIconImages.FileName:=g_ParamDir+MAGICONIMAGESFILE;
  g_WMagIconImages.LibType:=ltUseCache;
  g_WMagIconImages.Initialize;

  g_WMagIcon2Images.DxDraw:=DDxDraw;
  g_WMagIcon2Images.DDraw:=DDxDraw.DDraw;
  g_WMagIcon2Images.FileName:=g_ParamDir+MAGICONIMAGESFILE2;
  g_WMagIcon2Images.LibType:=ltUseCache;
  g_WMagIcon2Images.Initialize;

  g_WNpcImgImages.DxDraw:=DDxDraw;
  g_WNpcImgImages.DDraw:=DDxDraw.DDraw;
  g_WNpcImgImages.FileName:=g_ParamDir+NPCIMAGESFILE;
  g_WNpcImgImages.LibType:=ltUseCache;
  g_WNpcImgImages.Initialize;

  g_WNpc2ImgImages.DxDraw:=DDxDraw;
  g_WNpc2ImgImages.DDraw:=DDxDraw.DDraw;
  g_WNpc2ImgImages.FileName:=g_ParamDir+NPC2IMAGESFILE;
  g_WNpc2ImgImages.LibType:=ltUseCache;
  g_WNpc2ImgImages.Initialize;

  g_WMagicImages.DxDraw:=DDxDraw;
  g_WMagicImages.DDraw:=DDxDraw.DDraw;
  g_WMagicImages.FileName:=g_ParamDir+MAGICIMAGESFILE;
  g_WMagicImages.LibType:=ltUseCache;
  g_WMagicImages.Initialize;

  g_WMagic2Images.DxDraw:=DDxDraw;
  g_WMagic2Images.DDraw:=DDxDraw.DDraw;
  g_WMagic2Images.FileName:=g_ParamDir+MAGIC2IMAGESFILE;
  g_WMagic2Images.LibType:=ltUseCache;
  g_WMagic2Images.Initialize;

  g_WMagic3Images.DxDraw:=DDxDraw;
  g_WMagic3Images.DDraw:=DDxDraw.DDraw;
  g_WMagic3Images.FileName:=g_ParamDir+MAGIC3IMAGESFILE;
  g_WMagic3Images.LibType:=ltUseCache;
  g_WMagic3Images.Initialize;

  g_WMagic4Images.DxDraw:=DDxDraw;
  g_WMagic4Images.DDraw:=DDxDraw.DDraw;
  g_WMagic4Images.FileName:=g_ParamDir+MAGIC4IMAGESFILE;
  g_WMagic4Images.LibType:=ltUseCache;
  g_WMagic4Images.Initialize;

  g_WMagic5Images.DxDraw:=DDxDraw;
  g_WMagic5Images.DDraw:=DDxDraw.DDraw;
  g_WMagic5Images.FileName:=g_ParamDir+MAGIC5IMAGESFILE;
  g_WMagic5Images.LibType:=ltUseCache;
  g_WMagic5Images.Initialize;

  g_WMagic6Images.DxDraw:=DDxDraw;
  g_WMagic6Images.DDraw:=DDxDraw.DDraw;
  g_WMagic6Images.FileName:=g_ParamDir+MAGIC6IMAGESFILE;
  g_WMagic6Images.LibType:=ltUseCache;
  g_WMagic6Images.Initialize;

  g_WMagic7Images.DxDraw := DDxDraw;
  g_WMagic7Images.DDraw := DDxDraw.DDraw;
  g_WMagic7Images.FileName := g_ParamDir+MAGIC7IMAGESFILE;
  g_WMagic7Images.LibType:=ltUseCache;
  g_WMagic7Images.Initialize;

  g_WMagic7Images16.DxDraw := DDxDraw;
  g_WMagic7Images16.DDraw := DDxDraw.DDraw;
  g_WMagic7Images16.FileName := g_ParamDir+MAGIC7IMAGESFILE16;
  g_WMagic7Images16.LibType:=ltUseCache;
  g_WMagic7Images16.Initialize;

  g_WMagic8Images.DxDraw := DDxDraw;
  g_WMagic8Images.DDraw := DDxDraw.DDraw;
  g_WMagic8Images.FileName := g_ParamDir+MAGIC8IMAGESFILE;
  g_WMagic8Images.LibType:=ltUseCache;
  g_WMagic8Images.Initialize;

  g_WMagic8Images16.DxDraw := DDxDraw;
  g_WMagic8Images16.DDraw := DDxDraw.DDraw;
  g_WMagic8Images16.FileName := g_ParamDir+MAGIC8IMAGESFILE16;
  g_WMagic8Images16.LibType:=ltUseCache;
  g_WMagic8Images16.Initialize;

  g_WMagic9Images.DxDraw := DDxDraw;
  g_WMagic9Images.DDraw := DDxDraw.DDraw;
  g_WMagic9Images.FileName := g_ParamDir+MAGIC9IMAGESFILE;
  g_WMagic9Images.LibType:=ltUseCache;
  g_WMagic9Images.Initialize;

  g_WMagic10Images.DxDraw := DDxDraw;
  g_WMagic10Images.DDraw := DDxDraw.DDraw;
  g_WMagic10Images.FileName := g_ParamDir+MAGIC10IMAGESFILE;
  g_WMagic10Images.LibType:=ltUseCache;
  g_WMagic10Images.Initialize;

  g_WMonKuLouImages.DxDraw := DDxDraw;
  g_WMonKuLouImages.DDraw := DDxDraw.DDraw;
  g_WMonKuLouImages.FileName := g_ParamDir+MONKULOUIMAGEFILE;
  g_WMonKuLouImages.LibType:=ltUseCache;
  g_WMonKuLouImages.Initialize;

  g_WEffectImages.DxDraw:=DDxDraw;
  g_WEffectImages.DDraw:=DDxDraw.DDraw;
  g_WEffectImages.FileName:=g_ParamDir+EFFECTIMAGEFILE;
  g_WEffectImages.LibType:=ltUseCache;
  g_WEffectImages.Initialize;

  g_qingqingImages.DxDraw:=DDxDraw;
  g_qingqingImages.DDraw:=DDxDraw.DDraw;
  g_qingqingImages.FileName:=g_ParamDir+qingqingFILE;
  g_qingqingImages.LibType:=ltUseCache;
  g_qingqingImages.Initialize;

  g_WchantkkImages.DxDraw:=DDxDraw;
  g_WchantkkImages.DDraw:=DDxDraw.DDraw;
  g_WchantkkImages.FileName := g_ParamDir+chantkkFILE;
  g_WchantkkImages.LibType:=ltUseCache;
  g_WchantkkImages.Initialize;

  g_WDragonImages.DxDraw := DDxDraw;
  g_WDragonImages.DDraw := DDxDraw.DDraw;
  g_WDragonImages.FileName := g_ParamDir+DRAGONIMGESFILE;
  g_WDragonImages.LibType := ltUseCache;
  g_WDragonImages.Initialize;

  g_WWeaponEffectImages.DxDraw := DDxDraw;
  g_WWeaponEffectImages.DDraw := DDxDraw.DDraw;
  g_WWeaponEffectImages.FileName := g_ParamDir+WEAPONEFFECTFILE;
  g_WWeaponEffectImages.LibType := ltUseCache;
  g_WWeaponEffectImages.Initialize;

  g_WWeaponEffectImages4.DxDraw := DDxDraw;
  g_WWeaponEffectImages4.DDraw := DDxDraw.DDraw;
  g_WWeaponEffectImages4.FileName := g_ParamDir+WEAPONEFFECTFILE4;
  g_WWeaponEffectImages4.LibType := ltUseCache;
  g_WWeaponEffectImages4.Initialize;

  g_WCboWeaponEffectImages4.DxDraw := DDxDraw;
  g_WCboWeaponEffectImages4.DDraw := DDxDraw.DDraw;
  g_WCboWeaponEffectImages4.FileName := g_ParamDir+CBOWEAPONEFFECTIMAGESFILE4;
  g_WCboWeaponEffectImages4.LibType := ltUseCache;
  g_WCboWeaponEffectImages4.Initialize;



  g_WCboEffectImages.DxDraw:=DDxDraw;
  g_WCboEffectImages.DDraw:=DDxDraw.DDraw;
  g_WCboEffectImages.FileName:=g_ParamDir+CBOEFFECTIMAGESFILE;
  g_WCboEffectImages.LibType:=ltUseCache;
  g_WCboEffectImages.Initialize; 

  g_WUI1Images.DxDraw := DDxDraw;
  g_WUI1Images.DDraw := DDxDraw.DDraw;
  g_WUI1Images.FileName:=g_ParamDir+UI1IMAGESFILE;
  g_WUI1Images.LibType:=ltUseCache;
  g_WUI1Images.Initialize;

  g_WUI3Images.DxDraw := DDxDraw;
  g_WUI3Images.DDraw := DDxDraw.DDraw;
  g_WUI3Images.FileName:=g_ParamDir+UI3IMAGESFILE;
  g_WUI3Images.LibType:=ltUseCache;
  g_WUI3Images.Initialize;

  g_WStateEffectImages.DxDraw := DDxDraw;
  g_WStateEffectImages.DDraw := DDxDraw.DDraw;
  g_WStateEffectImages.FileName:=g_ParamDir+STATEEFFECTFILE;
  g_WStateEffectImages.LibType:=ltUseCache;
  g_WStateEffectImages.Initialize;
end;

procedure InitUiWMImagesLib(DDxDraw: TDxDraw);
begin
  g_WUiMainImages.DDraw := DDxDraw.DDraw;
  g_WUiMainImages.Initialize;
end;

procedure UnLoadWMImagesLib();
var
  I:Integer;
begin
  for I:=Low(g_WObjectArr) to High(g_WObjectArr) do begin
    if g_WObjectArr[I] <> nil then begin
      g_WObjectArr[I].Finalize;
      g_WObjectArr[I].Free;
    end;
  end;

  for I:=Low(g_WTilesArr) to High(g_WTilesArr) do begin
    if g_WTilesArr[I] <> nil then begin
      g_WTilesArr[I].Finalize;
      g_WTilesArr[I].Free;
    end;
  end;

  for I:=Low(g_WSMTilesArr) to High(g_WSMTilesArr) do begin
    if g_WSMTilesArr[I] <> nil then begin
      g_WSMTilesArr[I].Finalize;
      g_WSMTilesArr[I].Free;
    end;
  end;

  for I:=Low(g_WMonImagesArr) to High(g_WMonImagesArr) do begin
    if g_WMonImagesArr[I] <> nil then begin
      g_WMonImagesArr[I].Finalize;
      g_WMonImagesArr[I].Free;
    end;
  end;
  g_WMainImages.Finalize;
  g_WMainImages.Free;
  g_WMain2Images.Finalize;
  g_WMain2Images.Free;
  g_WMain3Images.Finalize;
  g_WMain3Images.Free;
  g_WChrSelImages.Finalize;
  g_WChrSelImages.Free;
  g_WMMapImages.Finalize;
  g_WMMapImages.Free;
  g_WHumWingImages.Finalize;
  g_WHumWingImages.Free;
  g_WHumWing2Images.Finalize;
  g_WHumWing2Images.Free;
  g_WHumWing3Images.Finalize;
  g_WHumWing3Images.Free;
  g_WHumWing4Images.Finalize;
  g_WHumWing4Images.Free;
  g_WCboHumWingImages.Finalize;
  g_WCboHumWingImages.Free;
  g_WCboHumWingImages2.Finalize;
  g_WCboHumWingImages2.Free;
  g_WCboHumWingImages3.Finalize;
  g_WCboHumWingImages3.Free;
  g_WCboHumWingImages4.Finalize;
  g_WCboHumWingImages4.Free;

  g_WBagItemImages.Finalize;
  g_WBagItemImages.Free;
  g_WBagItem2Images.Finalize;
  g_WBagItem2Images.Free;
  g_WStateItemImages.Finalize;
  g_WStateItemImages.Free;
  g_WStateItem2Images.Finalize;
  g_WStateItem2Images.Free;
  g_WDnItemImages.Finalize;
  g_WDnItemImages.Free;
  g_WDnItem2Images.Finalize;
  g_WDnItem2Images.Free;
  g_WHumImgImages.Finalize;
  g_WHumImgImages.Free;
  g_WHum2ImgImages.Finalize; //20080501
  g_WHum2ImgImages.Free;     //20080501
  g_WHum3ImgImages.Finalize;
  g_WHum3ImgImages.Free;
  g_WHum4ImgImages.Finalize; //20080501
  g_WHum4ImgImages.Free;     //20080501
  g_WCboHumImgImages.Finalize;
  g_WCboHumImgImages.Free;
  g_WCboHum3ImgImages.Finalize;
  g_WCboHum3ImgImages.Free;
  g_WCboHum4ImgImages.Finalize;
  g_WCboHum4ImgImages.Free;

  g_WHairImgImages.Finalize;
  g_WHairImgImages.Free;
  g_WCboHairImgImages.Finalize;
  g_WCboHairImgImages.Free;
  g_WWeaponImages.Finalize;
  g_WWeaponImages.Free;
  g_WCboWeaponImages.Finalize;
  g_WCboWeaponImages.Free;
  g_WCboWeaponImages3.Finalize;
  g_WCboWeaponImages3.Free;
  g_WCboWeaponImages4.Finalize;
  g_WCboWeaponImages4.Free;
  g_WWeapon2Images.Finalize;  //20080501
  g_WWeapon2Images.Free;     //20080501
  g_WWeapon3Images.Finalize;
  g_WWeapon3Images.Free;

  g_WWeapon4Images.Finalize;
  g_WWeapon4Images.Free;
  
  g_WMagIconImages.Finalize;
  g_WMagIconImages.Free;
  g_WMagIcon2Images.Finalize;
  g_WMagIcon2Images.Free;
  g_WNpcImgImages.Finalize;
  g_WNpcImgImages.Free;
  g_WNpc2ImgImages.Finalize;
  g_WNpc2ImgImages.Free;
  g_WMagicImages.Finalize;
  g_WMagicImages.Free;
  g_WMagic2Images.Finalize;
  g_WMagic2Images.Free;
  g_WMagic3Images.Finalize;
  g_WMagic3Images.Free;
  g_WMagic4Images.Finalize;    //2007.10.28
  g_WMagic4Images.Free;
  g_WMagic5Images.Finalize;    //2007.11.29
  g_WMagic5Images.Free;
  g_WMagic6Images.Finalize;    //2007.11.29
  g_WMagic6Images.Free;
  g_WMagic7Images.Finalize;
  g_WMagic7Images.Free;
  g_WMagic8Images.Finalize;
  g_WMagic8Images.Free;
  g_WMagic7Images16.Finalize;
  g_WMagic7Images16.Free;
  g_WMagic8Images16.Finalize;
  g_WMagic8Images16.Free;
  g_WMagic9Images.Finalize;
  g_WMagic9Images.Free;
  g_WMagic10Images.Finalize;
  g_WMagic10Images.Free;
  g_WMonKuLouImages.Finalize;
  g_WMonKuLouImages.Free;
  g_WEffectImages.Finalize;    //2007.10.28
  g_WEffectImages.Free;
  g_qingqingImages.Finalize;    //2007.10.28
  g_qingqingImages.Free;
  g_WchantkkImages.Finalize;
  g_WchantkkImages.Free;
  g_WDragonImages.Finalize;
  g_WDragonImages.Free;
  g_WUiMainImages.Finalize;
  g_WUiMainImages.Free;
  g_WWeaponEffectImages.Finalize;
  g_WWeaponEffectImages.Free;
  g_WWeaponEffectImages4.Finalize;
  g_WWeaponEffectImages4.Free;
  g_WCboWeaponEffectImages4.Finalize;
  g_WCboWeaponEffectImages4.Free;


  g_WCboEffectImages.Finalize;
  g_WCboEffectImages.Free;
  g_WUI1Images.Finalize;
  g_WUI1Images.Free;
  g_WUI3Images.Finalize;
  g_WUI3Images.Free;
  g_WStateEffectImages.Finalize;
  g_WStateEffectImages.Free;
end;

function GetTiles (nUnit,nIdx:Integer):TDirectDrawSurface;
begin
  Result:=nil;
  if (nUnit < Low(g_WTilesArr)) or (nUnit > High(g_WTilesArr)) then nUnit:=0;
  if g_WTilesArr[nUnit] <> nil then
  Result:=g_WTilesArr[nUnit].Images[nIdx];
end;

function GetSmTiles (nUnit,nIdx:Integer):TDirectDrawSurface;
begin
  Result:=nil;
  if (nUnit < Low(g_WSmTilesArr)) or (nUnit > High(g_WSmTilesArr)) then nUnit:=0;
  if g_WSmTilesArr[nUnit] <> nil then
  Result:=g_WSmTilesArr[nUnit].Images[nIdx];
end;
//取地图图库
function GetObjs (nUnit,nIdx:Integer):TDirectDrawSurface;
begin
  Result:=nil;
  if (nUnit < Low(g_WObjectArr)) or (nUnit > High(g_WObjectArr)) then nUnit:=0;
  if g_WObjectArr[nUnit] <> nil then
  Result:=g_WObjectArr[nUnit].Images[nIdx];
end;

//取地图图库
function  GetObjsEx (nUnit,nIdx:Integer; var px, py: integer): TDirectDrawSurface;
begin
  Result:=nil;
  if (nUnit < Low(g_WObjectArr)) or (nUnit > High(g_WObjectArr)) then nUnit:=0;
  if g_WObjectArr[nUnit] <> nil then
  Result:=g_WObjectArr[nUnit].GetCachedImage(nIdx,px,py);
end;

procedure InitObjectImg();
var
  I: Integer;
  sFileName,sNewFileName: string;
begin
  for I:= Low(g_WObjectArr) to High(g_WObjectArr) do begin
    if I = 0 then sFileName:=g_ParamDir+OBJECTIMAGEFILE
    else sFileName:=g_ParamDir+format(OBJECTIMAGEFILE1,[I+1]);

    sNewFileName:=Copy(sFileName,1,Length(sFileName)-3)+'wzl';
    if (not FileExists(sFileName)) and (not FileExists(sNewFileName)) then Continue;

    g_WObjectArr[I]:=TWMImages.Create(nil);
    g_WObjectArr[I].DxDraw:=g_DxDraw;
    g_WObjectArr[I].DDraw:=g_DxDraw.DDraw;
    g_WObjectArr[I].FileName:=sFileName;;
    g_WObjectArr[I].LibType:=ltUseCache;
    g_WObjectArr[I].Initialize;
  end;
end;

procedure InitTilesImg();
var
  I: Integer;
  sFileName,sNewFileName: string;
begin
  for I:=Low(g_WTilesArr) to High(g_WTilesArr) do begin
    if I = 0 then sFileName:=g_ParamDir+TITLESIMAGEFILE
    else sFileName:=g_ParamDir+format(TITLESIMAGEFILE1,[I+1]);

    sNewFileName:=Copy(sFileName,1,Length(sFileName)-3)+'wzl';
    if (not FileExists(sFileName)) and (not FileExists(sNewFileName)) then Continue;

    g_WTilesArr[I]:=TWMImages.Create(nil);
    g_WTilesArr[I].DxDraw:=g_DxDraw;
    g_WTilesArr[I].DDraw:=g_DxDraw.DDraw;
    g_WTilesArr[I].FileName:=sFileName;;
    g_WTilesArr[I].LibType:=ltUseCache;
    g_WTilesArr[I].Initialize;
  end;
end;

procedure InitSmTilesImg();
var
  I: Integer;
  sFileName,sNewFileName: string;
begin
  for I:=Low(g_WSmTilesArr) to High(g_WSmTilesArr) do begin
    if I = 0 then sFileName:=g_ParamDir+SMLTITLESIMAGEFILE
    else sFileName:=g_ParamDir+format(SMLTITLESIMAGEFILE1,[I+1]);

    sNewFileName:=Copy(sFileName,1,Length(sFileName)-3)+'wzl';
    if (not FileExists(sFileName)) and (not FileExists(sNewFileName)) then Continue;
    
    g_WSmTilesArr[I]:=TWMImages.Create(nil);
    g_WSmTilesArr[I].DxDraw:=g_DxDraw;
    g_WSmTilesArr[I].DDraw:=g_DxDraw.DDraw;
    g_WSmTilesArr[I].FileName:=sFileName;;
    g_WSmTilesArr[I].LibType:=ltUseCache;
    g_WSmTilesArr[I].Initialize;
  end;
end;

procedure InitMonImg();
var
  I: Integer;
  sFileName,sNewFileName: string;
begin
  for I:= Low(g_WMonImagesArr) to (High(g_WMonImagesArr)) do begin
      sFileName:=g_ParamDir+format(MONIMAGEFILE,[I+1]);

      sNewFileName:=Copy(sFileName,1,Length(sFileName)-3)+'wzl';
      if (not FileExists(sFileName)) and (not FileExists(sNewFileName)) then Continue;

      g_WMonImagesArr[I]:=TWMImages.Create(nil);
      g_WMonImagesArr[I].DxDraw:=g_DxDraw;
      g_WMonImagesArr[I].DDraw:=g_DxDraw.DDraw;
      g_WMonImagesArr[I].FileName:=sFileName;;
      g_WMonImagesArr[I].LibType:=ltUseCache;
      g_WMonImagesArr[I].Initialize;
  end;
end;

function GetMonImg (nAppr:Integer):TWMImages;
var
 // sFileName:String;
  nUnit:Integer;
begin
  Result:=nil;
  if nAppr > 9999 then Exit;
  
  if nAppr < 1000 then nUnit:=nAppr div 10
  else nUnit:=nAppr  div 100;    

   { if nUnit = 90 then begin
      Result := g_WEffectImages;//sFileName:=EFFECTIMAGEFILE;
      Exit;
    end;   }
  if nUnit <> 90 then begin
    if (nUnit < Low(g_WMonImagesArr)) or (nUnit > High(g_WMonImagesArr)) then nUnit:=0;
    if nUnit >= 35 then begin
      if nUnit < 37 then
        nUnit := 35//修正叛军怪By TasNat at: 2012-10-18 10:20:46
      else Dec(nUnit, 2)
    end;
    {if g_WMonImagesArr[nUnit] = nil then begin

      sFileName:=format(MONIMAGEFILE,[nUnit+1]);
      //if nUnit = 80 then sFileName:=DRAGONIMAGEFILE;

     // if nUnit >= 1000 then sFileName:=format(MONIMAGEFILEEX,[nUnit]); //超过1000序号的怪物取新的怪物文件

      g_WMonImagesArr[nUnit]:=TWMImages.Create(nil);
      g_WMonImagesArr[nUnit].DxDraw:=g_DxDraw;
      g_WMonImagesArr[nUnit].DDraw:=g_DxDraw.DDraw;
      g_WMonImagesArr[nUnit].FileName:=sFileName;
      g_WMonImagesArr[nUnit].LibType:=ltUseCache;
      g_WMonImagesArr[nUnit].Initialize;
    end;   }
    if g_WMonImagesArr[nUnit] <> nil then
      Result:=g_WMonImagesArr[nUnit];
  end else begin  //沙城门、城墙之类的
    case nAppr of
      904..906: begin
        if (nUnit >= Low(g_WMonImagesArr)) or (nUnit <= High(g_WMonImagesArr)) then
          if g_WMonImagesArr[33] <> nil then Result := g_WMonImagesArr[33];
      end;
      9010..9012: begin//强化骷髅
        if g_WMonKuLouImages <> nil then Result := g_WMonKuLouImages
      end;
      9013..9015: begin//强化圣兽
        if (nUnit >= Low(g_WMonImagesArr)) or (nUnit <= High(g_WMonImagesArr)) then
          if g_WMonImagesArr[27] <> nil then Result := g_WMonImagesArr[27];
      end;
      else if g_WEffectImages <> nil then Result := g_WEffectImages;
    end;
  end;
end;


//取得职业名称
//0 武士
//1 魔法师
//2 道士
function GetJobName (nJob:Integer):String;
begin
  Result:= '';
  case nJob of
    0:Result:=g_sWarriorName;
    1:Result:=g_sWizardName;
    2:Result:=g_sTaoistName;
    else begin
      Result:=g_sUnKnowName;
    end;
  end;
end;

function GetPulseName (btPage,btIndex: Byte): string;
begin
  Result := '';
  case btPage of
    0: begin //冲脉
      case btIndex of
        0: Result := '幽门';
        1: Result := '通谷';
        2: Result := '商曲';
        3: Result := '四满';
        4: Result := '横骨';
      end;
    end;
    1: begin //阴跷
      case btIndex of
        0: Result := '晴明';
        1: Result := '盘缺';
        2: Result := '交信';
        3: Result := '照海';
        4: Result := '然谷';
      end;
    end;
    2: begin //阴维
      case btIndex of
        0: Result := '廉泉';
        1: Result := '期门';
        2: Result := '府舍';
        3: Result := '冲门';
        4: Result := '筑宾';
      end;
    end;
    3: begin //任脉
      case btIndex of
        0: Result := '承浆';
        1: Result := '天突';
        2: Result := '鸠尾';
        3: Result := '气海';
        4: Result := '曲骨';
      end;
    end;
    4: begin //奇经
      case btIndex of
        0: Result := '神冲';
        1: Result := '夹脊';
        2: Result := '二百';
        3: Result := '八风';
        4: Result := '涌泉';
      end;
    end;
  end;
end;

function GetPulsePageName (btPage: Byte): string;
begin
  Result := '';
  case btPage of
    0: Result := '冲脉';
    1: Result := '阴跷';
    2: Result := '阴维';
    3: Result := '任脉';
    4: Result := '奇经';
  end;
end;

procedure InitConfig(); //初始化内挂变量
var
  I: Integer;
begin
  with g_Config do begin
    boAutoPuckUpItem := True;
    boNoShift := False;
    boExpFiltrate := False; //20080714
    boShowMimiMapDesc := False;
    boShowHeroStateNumber := False;
    boShowName := False;
    boDuraWarning :=True;
    boLongHit             := False;
    boPosLongHit          := False;
    boAutoWideHit         := False;
    boAutoFireHit         := False;
    boAutoZhuriHit        := False;
    boAutoShield          := False;
    boHeroAutoShield      := False;
    boShowSpecialDamage   := True;
    boAutoDragInBody      := False;
    boHideHumanWing       := False;
    boHideWeaponEffect    := False;
    boAutoHide            := False;
    boAutoMagic           := False;
    nAutoMagicTime        := 4;
    boAutoEatWine         := False;
    boAutoEatHeroWine     := False;
    boAutoEatDrugWine     := False;
    boAutoEatHeroDrugWine := False;
    btEditWine         := 10;
    btEditHeroWine     := 10;
    btEditDrugWine     := 10;
    btEditHeroDrugWine := 10;
    dwEditExpFiltrate  := 2000;

    boHp1Chk:= False;
    wHp1Hp:= 0;
    btHp1Man:= 0;
    boMp1Chk:= False;
    wMp1Mp:= 0;
    btMp1Man:= 0;
    boRenewHPIsAuto:= False;
    wRenewHPTime:= 4000;
    wRenewHPTick:= 0;
    wRenewHPPercent:= 10;
    boRenewMPIsAuto:= False;
    wRenewMPTime:= 4000;
    wRenewMPPercent:= 10;
    wRenewMPTick:= 0;
    boRenewSpecialHPIsAuto:= False;
    wRenewSpecialHPTime:= 4000;
    wRenewSpecialHPTick:= 0;
    wRenewSpecialHPPercent:= 10;
    boRenewSpecialMpIsAuto:= False;
    wRenewSpecialMpTime:= 4000;
    wRenewSpecialMPTick:= 0;
    wRenewSpecialMpPercent:= 10;
    BoUseSuperMedica:= False;
    FillChar(SuperMedicaUses, SizeOf(SuperMedicaUses), #0);
    //SuperMedicaUses:= (False, False, False, False, False, False, False, False, False);
    FillChar(SuperMedicaHPs, SizeOf(SuperMedicaHPs), 0);
    //SuperMedicaHPs:= (0, 0, 0, 0, 0, 0, 0, 0, 0);
    for I:=Low(SuperMedicaHPTimes) to High(SuperMedicaHPTimes) do begin
      SuperMedicaHPTimes[I]:=4000;
    end;
    //SuperMedicaHPTimes:= (4000, 4000, 4000, 4000, 4000, 4000, 4000, 4000, 4000);
    FillChar(SuperMedicaHPTicks, SizeOf(SuperMedicaHPTicks), 0);
    //SuperMedicaHPTicks:= (0, 0, 0, 0, 0, 0, 0, 0, 0);
    FillChar(SuperMedicaMPs, SizeOf(SuperMedicaMPs), 0);
    //SuperMedicaMPs:= (0, 0, 0, 0, 0, 0, 0, 0, 0);
    for I:=Low(SuperMedicaMPTimes) to High(SuperMedicaMPTimes) do begin
      SuperMedicaMPTimes[I]:=4000;
    end;
    //SuperMedicaMPTimes:= (4000, 4000, 4000, 4000, 4000, 4000, 4000, 4000, 4000);
    FillChar(SuperMedicaMPTicks, SizeOf(SuperMedicaMPTicks), 0);
    //SuperMedicaMPTicks:= (0, 0, 0, 0, 0, 0, 0, 0, 0);
    {$IF M2Version <> 2}
    boHp2Chk:= False;
    wHp2Hp:= 0;
    //btHp2Man:= 0;
    boMp2Chk:= False;
    wMp2Mp:= 0;
    //btMp2Man:= 0;
    boHp3Chk:= False;
    wHp3Hp:= 0;
    //btHp3Man:= 0;
    boMp3Chk:= False;
    wMp3Mp:= 0;
    //btMp3Man:= 0;
    boHp4Chk:= False;
    wHp4Hp:= 0;
    //btHp4Man:= 0;
    boMp4Chk:= False;
    wMp4Mp:= 0;
    //btMp4Man:= 0;
    boHp5Chk:= False;
    wHp5Hp:= 0;
    //btHp5Man:= 0;
    boMp5Chk:= False;
    wMp5Mp:= 0;
    //btMp5Man:= 0;
    boRenewHeroNormalHpIsAuto:= False;
    wRenewHeroNormalHpTime:= 4000;
    wRenewHeroNormalHpTick:= 0;
    wRenewHeroNormalHpPercent:= 10;
    boRenewzHeroNormalHpIsAuto:= False;
    wRenewzHeroNormalHpTime:= 4000;
    wRenewzHeroNormalHpTick:= 0;
    wRenewzHeroNormalHpPercent:= 10;
    boRenewfHeroNormalHpIsAuto:= False;
    wRenewfHeroNormalHpTime:= 4000;
    wRenewfHeroNormalHpTick:= 0;
    wRenewfHeroNormalHpPercent:= 10;
    boRenewdHeroNormalHpIsAuto:= False;
    wRenewdHeroNormalHpTime:= 4000;
    wRenewdHeroNormalHpTick:= 0;
    wRenewdHeroNormalHpPercent:= 10;
    boRenewHeroNormalMpIsAuto:= False;
    wRenewHeroNormalMpTime:= 4000;
    wRenewHeroNormalMpTick:= 0;
    wRenewHeroNormalMpPercent:= 10;
    boRenewzHeroNormalMpIsAuto:= False;
    wRenewzHeroNormalMpTime:= 4000;
    wRenewzHeroNormalMpTick:= 0;
    wRenewzHeroNormalMpPercent:= 10;
    boRenewfHeroNormalMpIsAuto:= False;
    wRenewfHeroNormalMpTime:= 4000;
    wRenewfHeroNormalMpTick:= 0;
    wRenewfHeroNormalMpPercent:= 10;
    boRenewdHeroNormalMpIsAuto:= False;
    wRenewdHeroNormalMpTime:= 4000;
    wRenewdHeroNormalMpTick:= 0;
    wRenewdHeroNormalMpPercent:= 10;

    boRenewSpecialHeroNormalHpIsAuto:= False;
    wRenewSpecialHeroNormalHpTime:= 4000;
    wRenewSpecialHeroNormalHpTick:= 0;
    wRenewSpecialHeroNormalHpPercent:= 10;
    boRenewSpecialzHeroNormalHpIsAuto:= False;
    wRenewSpecialzHeroNormalHpTime:= 4000;
    wRenewSpecialzHeroNormalHpTick:= 0;
    wRenewSpecialzHeroNormalHpPercent:= 10;
    boRenewSpecialfHeroNormalHpIsAuto:= False;
    wRenewSpecialfHeroNormalHpTime:= 4000;
    wRenewSpecialfHeroNormalHpTick:= 0;
    wRenewSpecialfHeroNormalHpPercent:= 10;
    boRenewSpecialdHeroNormalHpIsAuto:= False;
    wRenewSpecialdHeroNormalHpTime:= 4000;
    wRenewSpecialdHeroNormalHpTick:= 0;
    wRenewSpecialdHeroNormalHpPercent:= 10;

    boRenewSpecialHeroNormalMpIsAuto:= False;
    wRenewSpecialHeroNormalMpTime:= 4000;
    wRenewSpecialHeroNormalMpTick:= 0;
    wRenewSpecialHeroNormalMpPercent:= 10;
    boRenewSpecialzHeroNormalMpIsAuto:= False;
    wRenewSpecialzHeroNormalMpTime:= 4000;
    wRenewSpecialzHeroNormalMpTick:= 0;
    wRenewSpecialzHeroNormalMpPercent:= 10;
    boRenewSpecialfHeroNormalMpIsAuto:= False;
    wRenewSpecialfHeroNormalMpTime:= 4000;
    wRenewSpecialfHeroNormalMpTick:= 0;
    wRenewSpecialfHeroNormalMpPercent:= 10;
    boRenewSpecialdHeroNormalMpIsAuto:= False;
    wRenewSpecialdHeroNormalMpTime:= 4000;
    wRenewSpecialdHeroNormalMpTick:= 0;
    wRenewSpecialdHeroNormalMpPercent:= 10;
    hBoUseSuperMedica:= False;
    zBoUseSuperMedica:= False;
    fBoUseSuperMedica:= False;
    dBoUseSuperMedica:= False;
    FillChar(hSuperMedicaUses, SizeOf(hSuperMedicaUses), #0);
    //hSuperMedicaUses:= (False, False, False, False, False, False, False, False, False);
    FillChar(hSuperMedicaHPs, SizeOf(hSuperMedicaHPs), 0);
    //hSuperMedicaHPs:= (0, 0, 0, 0, 0, 0, 0, 0, 0);
    for I:=Low(hSuperMedicaHPTimes) to High(hSuperMedicaHPTimes) do begin
      hSuperMedicaHPTimes[I] := 4000;
    end;
    //hSuperMedicaHPTimes:= (4000, 4000, 4000, 4000, 4000, 4000, 4000, 4000, 4000);
    FillChar(hSuperMedicaHPTicks, SizeOf(hSuperMedicaHPTicks), 0);
    //hSuperMedicaHPTicks:= (0, 0, 0, 0, 0, 0, 0, 0, 0);
    FillChar(hSuperMedicaMPs, SizeOf(hSuperMedicaMPs), 0);
    //hSuperMedicaMPs:= (0, 0, 0, 0, 0, 0, 0, 0, 0);
    for I:=Low(hSuperMedicaMPTimes) to High(hSuperMedicaMPTimes) do begin
      hSuperMedicaMPTimes[I] := 4000;
    end;
    //hSuperMedicaMPTimes:= (4000, 4000, 4000, 4000, 4000, 4000, 4000, 4000, 4000);
    FillChar(hSuperMedicaMPTicks, SizeOf(hSuperMedicaMPTicks), 0);
    //hSuperMedicaMPTicks:= (0, 0, 0, 0, 0, 0, 0, 0, 0);
    FillChar(zSuperMedicaUses, SizeOf(zSuperMedicaUses), #0);
    //zSuperMedicaUses:= (False, False, False, False, False, False, False, False, False);
    FillChar(zSuperMedicaHPs, SizeOf(zSuperMedicaHPs), 0);
    //zSuperMedicaHPs:= (0, 0, 0, 0, 0, 0, 0, 0, 0);
    for I:=Low(zSuperMedicaHPTimes) to High(zSuperMedicaHPTimes) do begin
      zSuperMedicaHPTimes[I] := 4000;
    end;
    //zSuperMedicaHPTimes:= (4000, 4000, 4000, 4000, 4000, 4000, 4000, 4000, 4000);
    FillChar(zSuperMedicaHPTicks, SizeOf(zSuperMedicaHPTicks), 0);
    //zSuperMedicaHPTicks:= (0, 0, 0, 0, 0, 0, 0, 0, 0);
    FillChar(zSuperMedicaMPs, SizeOf(zSuperMedicaMPs), 0);
    //zSuperMedicaMPs:= (0, 0, 0, 0, 0, 0, 0, 0, 0);
    for I:=Low(zSuperMedicaMPTimes) to High(zSuperMedicaMPTimes) do begin
      zSuperMedicaMPTimes[I] := 4000;
    end;
    //zSuperMedicaMPTimes:= (4000, 4000, 4000, 4000, 4000, 4000, 4000, 4000, 4000);
    FillChar(zSuperMedicaMPTicks, SizeOf(zSuperMedicaMPTicks), 0);
    //zSuperMedicaMPTicks:= (0, 0, 0, 0, 0, 0, 0, 0, 0);
    FillChar(fSuperMedicaUses, SizeOf(fSuperMedicaUses), #0);
    //fSuperMedicaUses:= (False, False, False, False, False, False, False, False, False);
    FillChar(fSuperMedicaHPs, SizeOf(fSuperMedicaHPs), 0);
    //fSuperMedicaHPs:= (0, 0, 0, 0, 0, 0, 0, 0, 0);
    for I:=Low(fSuperMedicaHPTimes) to High(fSuperMedicaHPTimes) do begin
      fSuperMedicaHPTimes[I] := 4000;
    end;
    //fSuperMedicaHPTimes:= (4000, 4000, 4000, 4000, 4000, 4000, 4000, 4000, 4000);
    FillChar(fSuperMedicaHPTicks, SizeOf(fSuperMedicaHPTicks), 0);
    //fSuperMedicaHPTicks:= (0, 0, 0, 0, 0, 0, 0, 0, 0);
    FillChar(fSuperMedicaMPs, SizeOf(fSuperMedicaMPs), 0);
    //fSuperMedicaMPs:= (0, 0, 0, 0, 0, 0, 0, 0, 0);
    for I:=Low(fSuperMedicaMPTimes) to High(fSuperMedicaMPTimes) do begin
      fSuperMedicaMPTimes[I] := 4000;
    end;
    //fSuperMedicaMPTimes:= (4000, 4000, 4000, 4000, 4000, 4000, 4000, 4000, 4000);
    FillChar(fSuperMedicaMPTicks, SizeOf(fSuperMedicaMPTicks), 0);
    //fSuperMedicaMPTicks:= (0, 0, 0, 0, 0, 0, 0, 0, 0);
    FillChar(dSuperMedicaUses, SizeOf(dSuperMedicaUses), #0);
    //dSuperMedicaUses:= (False, False, False, False, False, False, False, False, False);
    FillChar(dSuperMedicaHPs, SizeOf(dSuperMedicaHPs), 0);
    //dSuperMedicaHPs:= (0, 0, 0, 0, 0, 0, 0, 0, 0);
    for I:=Low(dSuperMedicaHPTimes) to High(dSuperMedicaHPTimes) do begin
      dSuperMedicaHPTimes[I] := 4000;
    end;
    //dSuperMedicaHPTimes:= (4000, 4000, 4000, 4000, 4000, 4000, 4000, 4000, 4000);
    FillChar(dSuperMedicaHPTicks, SizeOf(dSuperMedicaHPTicks), 0);
    //dSuperMedicaHPTicks:= (0, 0, 0, 0, 0, 0, 0, 0, 0);
    FillChar(dSuperMedicaMPs, SizeOf(dSuperMedicaMPs), 0);
    //dSuperMedicaMPs:= (0, 0, 0, 0, 0, 0, 0, 0, 0);
    for I:=Low(dSuperMedicaMPTimes) to High(dSuperMedicaMPTimes) do begin
      dSuperMedicaMPTimes[I] := 4000;
    end;
    //dSuperMedicaMPTimes:= (4000, 4000, 4000, 4000, 4000, 4000, 4000, 4000, 4000);
    FillChar(dSuperMedicaMPTicks, SizeOf(dSuperMedicaMPTicks), 0);
    //dSuperMedicaMPTicks:= (0, 0, 0, 0, 0, 0, 0, 0, 0);
    {$IFEND}
  end;
end;

procedure CreateSdoAssistant();//初始化盛大内挂
begin
   with FrmDlg do begin
   //==========================药品
     ChangeProPage(m_btProPage);
   //==========================药品结束
     DCheckBFilterItemPickUpAll.Checked := g_config.boAutoPuckUpItem;
     g_boAutoPuckUpItem := DCheckBFilterItemPickUpAll.Checked;

     DCheckSdoAvoidShift.Checked := g_config.boNoShift;
     g_boNoShift := DCheckSdoAvoidShift.Checked;

     DCheckSdoExpFiltrate.Checked := g_Config.boExpFiltrate ;
     g_boExpFiltrate := DCheckSdoExpFiltrate.Checked;

     DCheckSdoMapDesc.Checked := g_Config.boShowMimiMapDesc;
     g_boShowMimiMapDesc := DCheckSdoMapDesc.Checked;

     DCheckShowHeroStateNumber.Checked := g_Config.boShowHeroStateNumber;
     g_boShowHeroStateNumber := DCheckShowHeroStateNumber.Checked;

     DCheckSdoNameShow.Checked := g_config.boShowName;
     g_boShowName := DCheckSdoNameShow.Checked;

     DCheckSdoDuraWarning.Checked := g_config.boDuraWarning;
     g_boDuraWarning := DCheckSdoDuraWarning.Checked;

     DCheckSdoLongHit.Checked:= g_config.boLongHit;
     g_boLongHit := DCheckSdoLongHit.Checked;

     DCheckSdoPosLongHit.Checked := g_Config.boPosLongHit;
     g_boPosLongHit := DCheckSdoPosLongHit.Checked;

     DCheckSdoAutoWideHit.Checked := g_config.boAutoWideHit;
     g_boAutoWideHit := DCheckSdoAutoWideHit.Checked;

     DCheckSdoAutoFireHit.Checked := g_config.boAutoFireHit;
     g_boAutoFireHit := DCheckSdoAutoFireHit.Checked;

     DCheckSdoZhuri.Checked := g_config.boAutoZhuRiHit;
     g_boAutoZhuRiHit := DCheckSdoZhuri.Checked;

     DCheckSdoAutoShield.Checked := g_config.boAutoShield;
     g_boAutoShield := DCheckSdoAutoShield.Checked;

     DCheckSdoHeroShield.Checked := g_Config.boHeroAutoShield;
     g_boHeroAutoDEfence := DCheckSdoHeroShield.Checked;

     DCheckShowSpecialDamage.Checked := g_Config.boShowSpecialDamage;
     g_boShowSpecialDamage := DCheckShowSpecialDamage.Checked;
     {$IF M2Version <> 2}
     DCheckAutoDragInBody.Checked := g_Config.boAutoDragInBody;
     g_boAutoDragInBody := DCheckAutoDragInBody.Checked;
     DCheckHideHumanWing.Checked := g_Config.boHideHumanWing;
     g_boHideHumanWing := DCheckHideHumanWing.Checked;
     DCheckHideWeaponEffect.Checked := g_Config.boHideWeaponEffect;
     g_boHideWeaponEffect := DCheckHideWeaponEffect.Checked;
     {$IFEND}
     DCheckSdoAutoHide.Checked := g_config.boAutoHide;
     g_boAutoHide := DCheckSdoAutoHide.Checked;

     DCheckSdoAutoMagic.Checked := g_config.boAutoMagic;
     g_boAutoMagic := DCheckSdoAutoMagic.Checked;

     DEdtSdoAutoMagicTimer.Text := IntToStr(g_config.nAutoMagicTime);
     DEdtSdoCommonHpChange(DEdtSdoAutoMagicTimer);

     DCheckSdoAutoDrinkWine.Checked := g_Config.boAutoEatWine;
     g_boAutoEatWine := DCheckSdoAutoDrinkWine.Checked;

     DEdtSdoDrunkWineDegree.Text := IntToStr(g_Config.btEditWine);
     DEdtSdoCommonHpChange(DEdtSdoDrunkWineDegree);

     DCheckSdoHeroAutoDrinkWine.Checked := g_Config.boAutoEatHeroWine;
     g_boAutoEatHeroWine := DCheckSdoHeroAutoDrinkWine.Checked;

     DEdtSdoHeroDrunkWineDegree.Text := IntToStr(g_Config.btEditHeroWine);
     DEdtSdoCommonHpChange(DEdtSdoHeroDrunkWineDegree);

     DCheckSdoAutoDrinkDrugWine.Checked := g_Config.boAutoEatDrugWine;
     g_boAutoEatDrugWine := DCheckSdoAutoDrinkDrugWine.Checked;

     DEdtSdoDrunkDrugWineDegree.Text := IntToStr(g_Config.btEditDrugWine);
     DEdtSdoCommonHpChange(DEdtSdoDrunkDrugWineDegree);

     DCheckSdoHeroAutoDrinkDrugWine.Checked := g_Config.boAutoEatHeroDrugWine;
     g_boAutoEatHeroDrugWine := DCheckSdoHeroAutoDrinkDrugWine.Checked;

     DEdtSdoHeroDrunkDrugWineDegree.Text := IntToStr(g_Config.btEditHeroDrugWine);
     DEdtSdoCommonHpChange(DEdtSdoHeroDrunkDrugWineDegree);

     DEdtSdoExpFiltrate.Text := IntToStr(g_Config.dwEditExpFiltrate);
     DEdtSdoCommonHpChange(DEdtSdoExpFiltrate);


     //HotKey
     with frmMain do begin
       ActSeriesKillKey.Enabled := FrmDlg.DCheckSdoStartKey.Checked;
       ActCallHeroKey.Enabled := FrmDlg.DCheckSdoStartKey.Checked;
       ActCallHero1Key.Enabled := FrmDlg.DCheckSdoStartKey.Checked;
       ActHeroAttackTargetKey.Enabled := FrmDlg.DCheckSdoStartKey.Checked;
       ActHeroGotethKey.Enabled := FrmDlg.DCheckSdoStartKey.Checked;
       ActHeroStateKey.Enabled := FrmDlg.DCheckSdoStartKey.Checked;
       ActHeroGuardKey.Enabled := FrmDlg.DCheckSdoStartKey.Checked;
       ActAttackModeKey.Enabled := FrmDlg.DCheckSdoStartKey.Checked;
       ActMinMapKey.Enabled := FrmDlg.DCheckSdoStartKey.Checked;
     end;
     FrmDlg.DBtnSdoSeriesKillKey.Hint := ShortCutToText(frmMain.ActSeriesKillKey.ShortCut);
     FrmDlg.DBtnSdoCallHeroKey.Hint := ShortCutToText(frmMain.ActCallHeroKey.ShortCut);
     FrmDlg.DBtnSdoCallHero1Key.Hint := ShortCutToText(frmMain.ActCallHero1Key.ShortCut);
     FrmDlg.DBtnSdoHeroAttackTargetKey.Hint := ShortCutToText(frmMain.ActHeroAttackTargetKey.ShortCut);
     FrmDlg.DBtnSdoHeroGotethKey.Hint := ShortCutToText(frmMain.ActHeroGotethKey.ShortCut);
     FrmDlg.DBtnSdoHeroStateKey.Hint := ShortCutToText(frmMain.ActHeroStateKey.ShortCut);
     FrmDlg.DBtnSdoHeroGuardKey.Hint  := ShortCutToText(frmMain.ActHeroGuardKey.ShortCut);
     FrmDlg.DBtnSdoAttackModeKey.Hint := ShortCutToText(frmMain.ActAttackModeKey.ShortCut);
     FrmDlg.DBtnSdoMinMapKey.Hint := ShortCutToText(frmMain.ActMinMapKey.ShortCut);
   end;
end;
procedure LoadSdoAssistantConfig(sUserName:String);//加载盛大挂配置
  {procedure InitializeRecord(out ARecord; count: Integer);
  begin
    FillChar(ARecord, count, #0);
  end; }
var
  Ini: TMemIniFile;//TIniFile;
  sFileName: String;
  I, LoadInteger: Integer;
begin
  if sUserName <> '' then sFileName := g_ParamDir+format(SDOCONFIGFILE,[g_sServerName,sUserName,'SdoAssistant'])
    else sFileName:=g_ParamDir+format(CONFIGFILE,['Assistant']);
  if not DirectoryExists(g_ParamDir+'config') then  CreateDir(g_ParamDir+'config');
  if not DirectoryExists(g_ParamDir+format('config\Ly%s_%s',[g_sServerName,sUserName])) then
    CreateDir(g_ParamDir+format('config\Ly%s_%s',[g_sServerName,sUserName]));
  InitConfig;
  //InitializeRecord(g_Config, SizeOf(TConfig));
  Ini:={TIniFile}TMemIniFile.Create(sFileName);
  try
    //if Ini.ReadInteger('Assistant', 'AutoPuckUpItem', -1) < 0 then Ini.WriteBool('Assistant', 'AutoPuckUpItem', True);
    g_Config.boAutoPuckUpItem := Ini.ReadBool('Assistant', 'AutoPuckUpItem', g_Config.boAutoPuckUpItem);

    //if Ini.ReadInteger('Assistant', 'NoShift', -1) < 0 then Ini.WriteBool('Assistant', 'NoShift', False);
    g_Config.boNoShift := Ini.ReadBool('Assistant', 'NoShift', g_Config.boNoShift);

    //if Ini.ReadInteger('Assistant', 'ExpFiltrate', -1) < 0 then Ini.WriteBool('Assistant', 'ExpFiltrate', False);
    g_Config.boExpFiltrate := Ini.ReadBool('Assistant', 'ExpFiltrate', g_Config.boExpFiltrate);

    //if Ini.ReadInteger('Assistant', 'ShowMimiMapDesc', -1) < 0 then Ini.WriteBool('Assistant', 'ShowMimiMapDesc', False);
    g_Config.boShowMimiMapDesc := Ini.ReadBool('Assistant', 'ShowMimiMapDesc', g_Config.boShowMimiMapDesc);

    //if Ini.ReadInteger('Assistant', 'ShowHeroStateNumber', -1) < 0 then Ini.WriteBool('Assistant', 'ShowHeroStateNumber', False);
    g_Config.boShowHeroStateNumber := Ini.ReadBool('Assistant', 'ShowHeroStateNumber', g_Config.boShowHeroStateNumber);

    //if Ini.ReadInteger('Assistant', 'ShowName', -1) < 0 then Ini.WriteBool('Assistant', 'ShowName', False);
    g_Config.boShowName := Ini.ReadBool('Assistant', 'ShowName', g_Config.boShowName);

    //if Ini.ReadInteger('Assistant', 'DuraWarning', -1) < 0 then Ini.WriteBool('Assistant', 'DuraWarning', True);
    g_Config.boDuraWarning := Ini.ReadBool('Assistant', 'DuraWarning', g_Config.boDuraWarning);

    //if Ini.ReadInteger('Assistant', 'LongHit', -1) < 0 then Ini.WriteBool('Assistant', 'LongHit', False);
    g_Config.boLongHit := Ini.ReadBool('Assistant', 'LongHit', g_Config.boLongHit);

    g_Config.boPosLongHit := Ini.ReadBool('Assistant', 'PosLongHit', g_Config.boPosLongHit);

    //if Ini.ReadInteger('Assistant', 'AutoWideHit', -1) < 0 then Ini.WriteBool('Assistant', 'AutoWideHit', False);
    g_Config.boAutoWideHit := Ini.ReadBool('Assistant', 'AutoWideHit', g_Config.boAutoWideHit);

    //if Ini.ReadInteger('Assistant', 'AutoFireHit', -1) < 0 then Ini.WriteBool('Assistant', 'AutoFireHit', False);
    g_Config.boAutoFireHit := Ini.ReadBool('Assistant', 'AutoFireHit', g_Config.boAutoFireHit);

    //if Ini.ReadInteger('Assistant', 'AutoZhuriHit', -1) < 0 then Ini.WriteBool('Assistant', 'AutoZhuriHit', False);
    g_Config.boAutoZhuriHit := Ini.ReadBool('Assistant', 'AutoZhuriHit', g_Config.boAutoZhuriHit);

    //if Ini.ReadInteger('Assistant', 'AutoShield', -1) < 0 then Ini.WriteBool('Assistant', 'AutoShield', False);
    g_Config.boAutoShield := Ini.ReadBool('Assistant', 'AutoShield', g_Config.boAutoShield);

    //if Ini.ReadInteger('Assistant', 'HeroAutoShield', -1) < 0 then Ini.WriteBool('Assistant', 'HeroAutoShield', False);
    g_Config.boHeroAutoShield := Ini.ReadBool('Assistant', 'HeroAutoShield', g_Config.boHeroAutoShield);

    //if Ini.ReadInteger('Assistant', 'AutoHide', -1) < 0 then Ini.WriteBool('Assistant', 'AutoHide', False);
    g_Config.boAutoHide := Ini.ReadBool('Assistant', 'AutoHide', g_Config.boAutoHide);

    //if Ini.ReadInteger('Assistant', 'AutoMagic', -1) < 0 then Ini.WriteBool('Assistant', 'AutoMagic', False);
    g_Config.boAutoMagic := Ini.ReadBool('Assistant', 'AutoMagic', g_Config.boAutoMagic);

    {LoadInteger := Ini.ReadInteger('Assistant', 'AutoMagicTime', -1);
    if LoadInteger < 0 then begin
      Ini.WriteInteger('Assistant', 'AutoMagicTime', g_Config.nAutoMagicTime);
    end else begin}
      g_Config.nAutoMagicTime := Ini.ReadInteger('Assistant', 'AutoMagicTime', g_Config.nAutoMagicTime);
    //end;
    {$IF M2Version <> 2}
    //if Ini.ReadInteger('Assistant', 'AutoDragInBody', -1) < 0 then Ini.WriteBool('Assistant', 'AutoDragInBody', False);
    g_Config.boAutoDragInBody := Ini.ReadBool('Assistant', 'AutoDragInBody', g_Config.boAutoDragInBody);
    //if Ini.ReadInteger('Assistant', 'HideHumanWing', -1) < 0 then Ini.WriteBool('Assistant', 'HideHumanWing', False);
    g_Config.boHideHumanWing := Ini.ReadBool('Assistant', 'HideHumanWing', g_Config.boHideHumanWing);
    //if Ini.ReadInteger('Assistant', 'HideWeaponEffect', -1) < 0 then Ini.WriteBool('Assistant', 'HideWeaponEffect', False);
    g_Config.boHideWeaponEffect := Ini.ReadBool('Assistant', 'HideWeaponEffect', g_Config.boHideWeaponEffect);
    {$IFEND}

    //if Ini.ReadInteger('Assistant', 'HumanWineIsAuto', -1) < 0 then Ini.WriteBool('Assistant', 'HumanWineIsAuto', False);
    g_Config.boAutoEatWine := Ini.ReadBool('Assistant', 'HumanWineIsAuto', g_Config.boAutoEatWine);

    //if Ini.ReadInteger('Assistant', 'HeroWineIsAuto', -1) < 0 then Ini.WriteBool('Assistant', 'HeroWineIsAuto', False);
    g_Config.boAutoEatHeroWine := Ini.ReadBool('Assistant', 'HeroWineIsAuto', g_Config.boAutoEatHeroWine);

    //if Ini.ReadInteger('Assistant', 'HumanMedicateWineIsAuto', -1) < 0 then Ini.WriteBool('Assistant', 'HumanMedicateWineIsAuto', False);
    g_Config.boAutoEatDrugWine := Ini.ReadBool('Assistant', 'HumanMedicateWineIsAuto', g_Config.boAutoEatDrugWine);

    //if Ini.ReadInteger('Assistant', 'HeroMedicateWineIsAuto', -1) < 0 then Ini.WriteBool('Assistant', 'HeroMedicateWineIsAuto', False);
    g_Config.boAutoEatHeroDrugWine := Ini.ReadBool('Assistant', 'HeroMedicateWineIsAuto', g_Config.boAutoEatHeroDrugWine);

    {LoadInteger := Ini.ReadInteger('Assistant', 'HumanWinePercent', -1);
    if LoadInteger < 0 then begin
      Ini.WriteInteger('Assistant', 'HumanWinePercent', g_Config.btEditWine);
    end else begin}
      g_Config.btEditWine := Ini.ReadInteger('Assistant', 'HumanWinePercent', g_Config.btEditWine);
    //end;

    {LoadInteger := Ini.ReadInteger('Assistant', 'HeroWinePercent', -1);
    if LoadInteger < 0 then begin
      Ini.WriteInteger('Assistant', 'HeroWinePercent', g_Config.btEditHeroWine);
    end else begin}
      g_Config.btEditHeroWine := Ini.ReadInteger('Assistant', 'HeroWinePercent', g_Config.btEditHeroWine);
    //end;

    {LoadInteger := Ini.ReadInteger('Assistant', 'HumanMedicateWineTime', -1);
    if LoadInteger < 0 then begin
      Ini.WriteInteger('Assistant', 'HumanMedicateWineTime', g_Config.btEditDrugWine);
    end else begin}
      g_Config.btEditDrugWine := Ini.ReadInteger('Assistant', 'HumanMedicateWineTime', g_Config.btEditDrugWine);
    //end;

    {LoadInteger := Ini.ReadInteger('Assistant', 'HeroMedicateWineTime', -1);
    if LoadInteger < 0 then begin
      Ini.WriteInteger('Assistant', 'HeroMedicateWineTime', g_Config.btEditHeroDrugWine);
    end else begin    }
      g_Config.btEditHeroDrugWine := Ini.ReadInteger('Assistant', 'HeroMedicateWineTime', g_Config.btEditHeroDrugWine);
    //end;

    {LoadInteger := Ini.ReadInteger('Assistant', 'EdtExpFiltrate', -1);
    if LoadInteger < 0 then begin
      Ini.WriteInteger('Assistant', 'EdtExpFiltrate', g_Config.dwEditExpFiltrate);
    end else begin   }
      g_Config.dwEditExpFiltrate := Ini.ReadInteger('Assistant', 'EdtExpFiltrate', g_Config.dwEditExpFiltrate);
    //end;

    //声音
    //if Ini.ReadInteger('Misc', 'PlaySound', -1) < 0 then Ini.WriteBool('Misc', 'PlaySound', True);
    g_boSound := Ini.ReadBool('Misc', 'PlaySound', g_boSound);

    //HotKey
    //if Ini.ReadInteger('Hotkey', 'UseHotkey', -1) < 0 then Ini.WriteBool('Hotkey', 'UseHotkey', False);
    FrmDlg.DCheckSdoStartKey.Checked := Ini.ReadBool('Hotkey', 'UseHotkey', False);

   { LoadInteger := Ini.ReadInteger('Hotkey', 'HeroCallHero', -1);
    if LoadInteger < 0 then begin
      Ini.WriteInteger('Hotkey', 'HeroCallHero', 0);
    end else begin     }
      frmMain.ActSeriesKillKey.ShortCut := Ini.ReadInteger('Hotkey', 'Serieskill', 0);
      frmMain.ActCallHeroKey.ShortCut := Ini.ReadInteger('Hotkey', 'HeroCallHero', 0);
      frmMain.ActCallHero1Key.ShortCut := Ini.ReadInteger('Hotkey', 'HeroCallHero1', 0);
    //end;
    {LoadInteger := Ini.ReadInteger('Hotkey', 'Serieskill', -1);
    if LoadInteger < 0 then begin
      Ini.WriteInteger('Hotkey', 'Serieskill', 0);
    end else begin  }
   // end;
   { LoadInteger := Ini.ReadInteger('Hotkey', 'HeroSetTarget', -1);
    if LoadInteger < 0 then begin
      Ini.WriteInteger('Hotkey', 'HeroSetTarget', 0);
    end else begin    }
      frmMain.ActHeroAttackTargetKey.ShortCut := Ini.ReadInteger('Hotkey', 'HeroSetTarget', 0);
    //end;
    {LoadInteger := Ini.ReadInteger('Hotkey', 'HeroUnionHit', -1);
    if LoadInteger < 0 then begin
      Ini.WriteInteger('Hotkey', 'HeroUnionHit', 0);
    end else begin    }
      frmMain.ActHeroGotethKey.ShortCut := Ini.ReadInteger('Hotkey', 'HeroUnionHit', 0);
    //end;
    {LoadInteger := Ini.ReadInteger('Hotkey', 'HeroSetAttackState', -1);
    if LoadInteger < 0 then begin
      Ini.WriteInteger('Hotkey', 'HeroSetAttackState', 0);
    end else begin   }
      frmMain.ActHeroStateKey.ShortCut := Ini.ReadInteger('Hotkey', 'HeroSetAttackState', 0);
   // end;
    {LoadInteger := Ini.ReadInteger('Hotkey', 'HeroSetGuard', -1);
    if LoadInteger < 0 then begin
      Ini.WriteInteger('Hotkey', 'HeroSetGuard', 0);
    end else begin  }
      frmMain.ActHeroGuardKey.ShortCut := Ini.ReadInteger('Hotkey', 'HeroSetGuard', 0);
   // end;
    {LoadInteger := Ini.ReadInteger('Hotkey', 'SwitchAttackMode', -1);
    if LoadInteger < 0 then begin
      Ini.WriteInteger('Hotkey', 'SwitchAttackMode', 0);
    end else begin  }
      frmMain.ActAttackModeKey.ShortCut := Ini.ReadInteger('Hotkey', 'SwitchAttackMode', 0);
    //end;
    {LoadInteger := Ini.ReadInteger('Hotkey', 'SwitchMiniMap', -1);
    if LoadInteger < 0 then begin
      Ini.WriteInteger('Hotkey', 'SwitchMiniMap', 0);
    end else begin  }
      frmMain.ActMinMapKey.ShortCut := Ini.ReadInteger('Hotkey', 'SwitchMiniMap', 0);
   // end;
    g_Config.boHp1Chk := Ini.ReadBool('Protect', 'Hp1Chk', g_Config.boHp1Chk);
    g_Config.wHp1Hp := Ini.ReadInteger('Protect', 'Hp1Hp', g_Config.wHp1Hp);
    g_Config.btHp1Man := Ini.ReadInteger('Protect', 'Hp1Man', g_Config.btHp1Man);
    g_Config.boMp1Chk := Ini.ReadBool('Protect', 'Mp1Chk', g_Config.boMp1Chk);
    g_Config.wMp1Mp := Ini.ReadInteger('Protect', 'Mp1Mp', g_Config.wMp1Mp);
    g_Config.btMp1Man := Ini.ReadInteger('Protect', 'Mp1Man', g_Config.btMp1Man);
    g_Config.boRenewHPIsAuto := Ini.ReadBool('Protect', 'RenewHPIsAuto', g_Config.boRenewHPIsAuto);
    g_Config.wRenewHPTime := Ini.ReadInteger('Protect', 'RenewHPTime', g_Config.wRenewHPTime);
    g_Config.wRenewHPPercent := Ini.ReadInteger('Protect', 'RenewHPPercent', g_Config.wRenewHPPercent);
    g_Config.boRenewMPIsAuto := Ini.ReadBool('Protect', 'RenewMPIsAuto', g_Config.boRenewMPIsAuto);
    g_Config.wRenewMPTime := Ini.ReadInteger('Protect', 'RenewMPTime', g_Config.wRenewMPTime);
    g_Config.wRenewMPPercent := Ini.ReadInteger('Protect', 'RenewMPPercent', g_Config.wRenewMPPercent);
    g_Config.boRenewSpecialHPIsAuto := Ini.ReadBool('Protect', 'RenewSpecialHPIsAuto', g_Config.boRenewSpecialHPIsAuto);
    g_Config.wRenewSpecialHPTime := Ini.ReadInteger('Protect', 'RenewSpecialHPTime', g_Config.wRenewSpecialHPTime);
    g_Config.wRenewSpecialHPPercent := Ini.ReadInteger('Protect', 'RenewSpecialHPPercent', g_Config.wRenewSpecialHPPercent);
    g_Config.boRenewSpecialMpIsAuto := Ini.ReadBool('Protect', 'RenewSpecialMpIsAuto', g_Config.boRenewSpecialMpIsAuto);
    g_Config.wRenewSpecialMpTime := Ini.ReadInteger('Protect', 'RenewSpecialMpTime', g_Config.wRenewSpecialMpTime);
    g_Config.wRenewSpecialMpPercent := Ini.ReadInteger('Protect', 'RenewSpecialMpPercent', g_Config.wRenewSpecialMpPercent);
    g_Config.BoUseSuperMedica := Ini.ReadBool('Protect', 'BoUseSuperMedica', g_Config.BoUseSuperMedica);
    for I:=Low(g_Config.SuperMedicaUses) to High(g_Config.SuperMedicaUses) do begin
      g_Config.SuperMedicaUses[I] := Ini.ReadBool('Protect', g_Config.SuperMedicaItemNames[I] + 'BoUse', g_Config.SuperMedicaUses[I]);
      g_Config.SuperMedicaHPs[I] := Ini.ReadInteger('Protect', g_Config.SuperMedicaItemNames[I] + 'Hp', g_Config.SuperMedicaHPs[I]);
      g_Config.SuperMedicaHPTimes[I] := Ini.ReadInteger('Protect', g_Config.SuperMedicaItemNames[I] + 'HpTime', g_Config.SuperMedicaHPTimes[I]);
      g_Config.SuperMedicaMPs[I] := Ini.ReadInteger('Protect', g_Config.SuperMedicaItemNames[I] + 'Mp', g_Config.SuperMedicaMPs[I]);
      g_Config.SuperMedicaMPTimes[I] := Ini.ReadInteger('Protect', g_Config.SuperMedicaItemNames[I] + 'MpTime', g_Config.SuperMedicaMPTimes[I]);
    end;
    {$IF M2Version <> 2}
    g_Config.boHp2Chk := Ini.ReadBool('Protect', 'Hp2Chk', g_Config.boHp2Chk);
    g_Config.wHp2Hp := Ini.ReadInteger('Protect', 'Hp2Hp', g_Config.wHp2Hp);
    //g_Config.btHp2Man := Ini.ReadInteger('Protect', 'Hp2Man', g_Config.btHp2Man);
    g_Config.boMp2Chk := Ini.ReadBool('Protect', 'Mp2Chk', g_Config.boMp2Chk);
    g_Config.wMp2Mp := Ini.ReadInteger('Protect', 'Mp2Mp', g_Config.wMp2Mp);
    //g_Config.btMp2Man := Ini.ReadInteger('Protect', 'Mp2Man', g_Config.btMp2Man);
    g_Config.boHp3Chk := Ini.ReadBool('Protect', 'Hp3Chk', g_Config.boHp3Chk);
    g_Config.wHp3Hp := Ini.ReadInteger('Protect', 'Hp3Hp', g_Config.wHp3Hp);
    //g_Config.btHp3Man := Ini.ReadInteger('Protect', 'Hp3Man', g_Config.btHp3Man);
    g_Config.boMp3Chk := Ini.ReadBool('Protect', 'Mp3Chk', g_Config.boMp3Chk);
    g_Config.wMp3Mp := Ini.ReadInteger('Protect', 'Mp3Mp', g_Config.wMp3Mp);
    //g_Config.btMp3Man := Ini.ReadInteger('Protect', 'Mp3Man', g_Config.btMp3Man);
    g_Config.boHp4Chk := Ini.ReadBool('Protect', 'Hp4Chk', g_Config.boHp4Chk);
    g_Config.wHp4Hp := Ini.ReadInteger('Protect', 'Hp4Hp', g_Config.wHp4Hp);
    //g_Config.btHp4Man := Ini.ReadInteger('Protect', 'Hp4Man', g_Config.btHp4Man);
    g_Config.boMp4Chk := Ini.ReadBool('Protect', 'Mp4Chk', g_Config.boMp4Chk);
    g_Config.wMp4Mp := Ini.ReadInteger('Protect', 'Mp4Mp', g_Config.wMp4Mp);
    //g_Config.btMp4Man := Ini.ReadInteger('Protect', 'Mp4Man', g_Config.btMp4Man);
    g_Config.boHp5Chk := Ini.ReadBool('Protect', 'Hp5Chk', g_Config.boHp5Chk);
    g_Config.wHp5Hp := Ini.ReadInteger('Protect', 'Hp5Hp', g_Config.wHp5Hp);
    //g_Config.btHp5Man := Ini.ReadInteger('Protect', 'Hp5Man', g_Config.btHp5Man);
    g_Config.boMp5Chk := Ini.ReadBool('Protect', 'Mp5Chk', g_Config.boMp5Chk);
    g_Config.wMp5Mp := Ini.ReadInteger('Protect', 'Mp5Hp', g_Config.wMp5Mp);
    //g_Config.btMp5Man := Ini.ReadInteger('Protect', 'Mp5Man', g_Config.btMp5Man);
    g_Config.boRenewHeroNormalHpIsAuto := Ini.ReadBool('Protect', 'RenewHeroNormalHpIsAuto', g_Config.boRenewHeroNormalHpIsAuto);
    g_Config.wRenewHeroNormalHpTime := Ini.ReadInteger('Protect', 'RenewHeroNormalHpTime', g_Config.wRenewHeroNormalHpTime);
    g_Config.wRenewHeroNormalHpPercent := Ini.ReadInteger('Protect', 'RenewHeroNormalHpPercent', g_Config.wRenewHeroNormalHpPercent);
    g_Config.boRenewzHeroNormalHpIsAuto := Ini.ReadBool('Protect', 'RenewzHeroNormalHpIsAuto', g_Config.boRenewzHeroNormalHpIsAuto);
    g_Config.wRenewzHeroNormalHpTime := Ini.ReadInteger('Protect', 'RenewzHeroNormalHpTime', g_Config.wRenewzHeroNormalHpTime);
    g_Config.wRenewzHeroNormalHpPercent := Ini.ReadInteger('Protect', 'RenewzHeroNormalHpPercent', g_Config.wRenewzHeroNormalHpPercent);
    g_Config.boRenewfHeroNormalHpIsAuto := Ini.ReadBool('Protect', 'RenewfHeroNormalHpIsAuto', g_Config.boRenewfHeroNormalHpIsAuto);
    g_Config.wRenewfHeroNormalHpTime := Ini.ReadInteger('Protect', 'RenewfHeroNormalHpTime', g_Config.wRenewfHeroNormalHpTime);
    g_Config.wRenewfHeroNormalHpPercent := Ini.ReadInteger('Protect', 'RenewfHeroNormalHpPercent', g_Config.wRenewfHeroNormalHpPercent);
    g_Config.boRenewdHeroNormalHpIsAuto := Ini.ReadBool('Protect', 'RenewdHeroNormalHpIsAuto', g_Config.boRenewdHeroNormalHpIsAuto);
    g_Config.wRenewdHeroNormalHpTime := Ini.ReadInteger('Protect', 'RenewdHeroNormalHpTime', g_Config.wRenewdHeroNormalHpTime);
    g_Config.wRenewdHeroNormalHpPercent := Ini.ReadInteger('Protect', 'RenewdHeroNormalHpPercent', g_Config.wRenewdHeroNormalHpPercent);

    g_Config.boRenewHeroNormalMpIsAuto := Ini.ReadBool('Protect', 'RenewHeroNormalMpIsAuto', g_Config.boRenewHeroNormalMpIsAuto);
    g_Config.wRenewHeroNormalMpTime := Ini.ReadInteger('Protect', 'RenewHeroNormalMpTime', g_Config.wRenewHeroNormalMpTime);
    g_Config.wRenewHeroNormalMpPercent := Ini.ReadInteger('Protect', 'RenewHeroNormalMpPercent', g_Config.wRenewHeroNormalMpPercent);
    g_Config.boRenewzHeroNormalMpIsAuto := Ini.ReadBool('Protect', 'RenewzHeroNormalMpIsAuto', g_Config.boRenewzHeroNormalMpIsAuto);
    g_Config.wRenewzHeroNormalMpTime := Ini.ReadInteger('Protect', 'RenewzHeroNormalMpTime', g_Config.wRenewzHeroNormalMpTime);
    g_Config.wRenewzHeroNormalMpPercent := Ini.ReadInteger('Protect', 'RenewzHeroNormalMpPercent', g_Config.wRenewzHeroNormalMpPercent);
    g_Config.boRenewfHeroNormalMpIsAuto := Ini.ReadBool('Protect', 'RenewfHeroNormalMpIsAuto', g_Config.boRenewfHeroNormalMpIsAuto);
    g_Config.wRenewfHeroNormalMpTime := Ini.ReadInteger('Protect', 'RenewfHeroNormalMpTime', g_Config.wRenewfHeroNormalMpTime);
    g_Config.wRenewfHeroNormalMpPercent := Ini.ReadInteger('Protect', 'RenewfHeroNormalMpPercent', g_Config.wRenewfHeroNormalMpPercent);
    g_Config.boRenewdHeroNormalMpIsAuto := Ini.ReadBool('Protect', 'RenewdHeroNormalMpIsAuto', g_Config.boRenewdHeroNormalMpIsAuto);
    g_Config.wRenewdHeroNormalMpTime := Ini.ReadInteger('Protect', 'RenewdHeroNormalMpTime', g_Config.wRenewdHeroNormalMpTime);
    g_Config.wRenewdHeroNormalMpPercent := Ini.ReadInteger('Protect', 'RenewdHeroNormalMpPercent', g_Config.wRenewdHeroNormalMpPercent);

    g_Config.boRenewSpecialHeroNormalHpIsAuto := Ini.ReadBool('Protect', 'RenewSpecialHeroNormalHpIsAuto', g_Config.boRenewSpecialHeroNormalHpIsAuto);
    g_Config.wRenewSpecialHeroNormalHpTime := Ini.ReadInteger('Protect', 'RenewSpecialHeroNormalHpTime', g_Config.wRenewSpecialHeroNormalHpTime);
    g_Config.wRenewSpecialHeroNormalHpPercent := Ini.ReadInteger('Protect', 'RenewSpecialHeroNormalHpPercent', g_Config.wRenewSpecialHeroNormalHpPercent);
    g_Config.boRenewSpecialzHeroNormalHpIsAuto := Ini.ReadBool('Protect', 'RenewSpecialzHeroNormalHpIsAuto', g_Config.boRenewSpecialzHeroNormalHpIsAuto);
    g_Config.wRenewSpecialzHeroNormalHpTime := Ini.ReadInteger('Protect', 'RenewSpecialzHeroNormalHpTime', g_Config.wRenewSpecialzHeroNormalHpTime);
    g_Config.wRenewSpecialzHeroNormalHpPercent := Ini.ReadInteger('Protect', 'RenewSpecialzHeroNormalHpPercent', g_Config.wRenewSpecialzHeroNormalHpPercent);
    g_Config.boRenewSpecialfHeroNormalHpIsAuto := Ini.ReadBool('Protect', 'RenewSpecialfHeroNormalHpIsAuto', g_Config.boRenewSpecialfHeroNormalHpIsAuto);
    g_Config.wRenewSpecialfHeroNormalHpTime := Ini.ReadInteger('Protect', 'RenewSpecialfHeroNormalHpTime', g_Config.wRenewSpecialfHeroNormalHpTime);
    g_Config.wRenewSpecialfHeroNormalHpPercent := Ini.ReadInteger('Protect', 'RenewSpecialfHeroNormalHpPercent', g_Config.wRenewSpecialfHeroNormalHpPercent);
    g_Config.boRenewSpecialdHeroNormalHpIsAuto := Ini.ReadBool('Protect', 'RenewSpecialdHeroNormalHpIsAuto', g_Config.boRenewSpecialdHeroNormalHpIsAuto);
    g_Config.wRenewSpecialdHeroNormalHpTime := Ini.ReadInteger('Protect', 'RenewSpecialdHeroNormalHpTime', g_Config.wRenewSpecialdHeroNormalHpTime);
    g_Config.wRenewSpecialdHeroNormalHpPercent := Ini.ReadInteger('Protect', 'RenewSpecialdHeroNormalHpPercent', g_Config.wRenewSpecialdHeroNormalHpPercent);

    g_Config.boRenewSpecialHeroNormalMpIsAuto := Ini.ReadBool('Protect', 'RenewSpecialHeroNormalMpIsAuto', g_Config.boRenewSpecialHeroNormalMpIsAuto);
    g_Config.wRenewSpecialHeroNormalMpTime := Ini.ReadInteger('Protect', 'RenewSpecialHeroNormalMpTime', g_Config.wRenewSpecialHeroNormalMpTime);
    g_Config.wRenewSpecialHeroNormalMpPercent := Ini.ReadInteger('Protect', 'RenewSpecialHeroNormalMpPercent', g_Config.wRenewSpecialHeroNormalMpPercent);
    g_Config.boRenewSpecialzHeroNormalMpIsAuto := Ini.ReadBool('Protect', 'RenewSpecialzHeroNormalMpIsAuto', g_Config.boRenewSpecialzHeroNormalMpIsAuto);
    g_Config.wRenewSpecialzHeroNormalMpTime := Ini.ReadInteger('Protect', 'RenewSpecialzHeroNormalMpTime', g_Config.wRenewSpecialzHeroNormalMpTime);
    g_Config.wRenewSpecialzHeroNormalMpPercent := Ini.ReadInteger('Protect', 'RenewSpecialzHeroNormalMpPercent', g_Config.wRenewSpecialzHeroNormalMpPercent);
    g_Config.boRenewSpecialfHeroNormalMpIsAuto := Ini.ReadBool('Protect', 'RenewSpecialfHeroNormalMpIsAuto', g_Config.boRenewSpecialfHeroNormalMpIsAuto);
    g_Config.wRenewSpecialfHeroNormalMpTime := Ini.ReadInteger('Protect', 'RenewSpecialfHeroNormalMpTime', g_Config.wRenewSpecialfHeroNormalMpTime);
    g_Config.wRenewSpecialfHeroNormalMpPercent := Ini.ReadInteger('Protect', 'RenewSpecialfHeroNormalMpPercent', g_Config.wRenewSpecialfHeroNormalMpPercent);
    g_Config.boRenewSpecialdHeroNormalMpIsAuto := Ini.ReadBool('Protect', 'RenewSpecialdHeroNormalMpIsAuto', g_Config.boRenewSpecialdHeroNormalMpIsAuto);
    g_Config.wRenewSpecialdHeroNormalMpTime := Ini.ReadInteger('Protect', 'RenewSpecialdHeroNormalMpTime', g_Config.wRenewSpecialdHeroNormalMpTime);
    g_Config.wRenewSpecialdHeroNormalMpPercent := Ini.ReadInteger('Protect', 'RenewSpecialdHeroNormalMpPercent', g_Config.wRenewSpecialdHeroNormalMpPercent);
    g_Config.hBoUseSuperMedica := Ini.ReadBool('Protect', 'hBoUseSuperMedica', g_Config.hBoUseSuperMedica);
    g_Config.zBoUseSuperMedica := Ini.ReadBool('Protect', 'zBoUseSuperMedica', g_Config.zBoUseSuperMedica);
    g_Config.fBoUseSuperMedica := Ini.ReadBool('Protect', 'fBoUseSuperMedica', g_Config.fBoUseSuperMedica);
    g_Config.dBoUseSuperMedica := Ini.ReadBool('Protect', 'dBoUseSuperMedica', g_Config.dBoUseSuperMedica);

    for I:=Low(g_Config.hSuperMedicaUses) to High(g_Config.hSuperMedicaUses) do begin
      g_Config.hSuperMedicaUses[I] := Ini.ReadBool('Protect', g_Config.SuperMedicaItemNames[I] + 'hBoUse', g_Config.hSuperMedicaUses[I]);
      g_Config.hSuperMedicaHPs[I] := Ini.ReadInteger('Protect', g_Config.SuperMedicaItemNames[I] + 'HeroHp', g_Config.hSuperMedicaHPs[I]);
      g_Config.hSuperMedicaHPTimes[I] := Ini.ReadInteger('Protect', g_Config.SuperMedicaItemNames[I] + 'HeroHpTime', g_Config.hSuperMedicaHPTimes[I]);
      g_Config.hSuperMedicaMPs[I] := Ini.ReadInteger('Protect', g_Config.SuperMedicaItemNames[I] + 'HeroMp', g_Config.hSuperMedicaMPs[I]);
      g_Config.hSuperMedicaMPTimes[I] := Ini.ReadInteger('Protect', g_Config.SuperMedicaItemNames[I] + 'HeroMpTime', g_Config.hSuperMedicaMPTimes[I]);
    end;
    for I:=Low(g_Config.zSuperMedicaUses) to High(g_Config.zSuperMedicaUses) do begin
      g_Config.zSuperMedicaUses[I] := Ini.ReadBool('Protect', g_Config.SuperMedicaItemNames[I] + 'zBoUse', g_Config.zSuperMedicaUses[I]);
      g_Config.zSuperMedicaHPs[I] := Ini.ReadInteger('Protect', g_Config.SuperMedicaItemNames[I] + 'zHeroHp', g_Config.zSuperMedicaHPs[I]);
      g_Config.zSuperMedicaHPTimes[I] := Ini.ReadInteger('Protect', g_Config.SuperMedicaItemNames[I] + 'zHeroHpTime', g_Config.zSuperMedicaHPTimes[I]);
      g_Config.zSuperMedicaMPs[I] := Ini.ReadInteger('Protect', g_Config.SuperMedicaItemNames[I] + 'zHeroMp', g_Config.zSuperMedicaMPs[I]);
      g_Config.zSuperMedicaMPTimes[I] := Ini.ReadInteger('Protect', g_Config.SuperMedicaItemNames[I] + 'zHeroMpTime', g_Config.zSuperMedicaMPTimes[I]);
    end;
    for I:=Low(g_Config.fSuperMedicaUses) to High(g_Config.fSuperMedicaUses) do begin
      g_Config.fSuperMedicaUses[I] := Ini.ReadBool('Protect', g_Config.SuperMedicaItemNames[I] + 'fBoUse', g_Config.fSuperMedicaUses[I]);
      g_Config.fSuperMedicaHPs[I] := Ini.ReadInteger('Protect', g_Config.SuperMedicaItemNames[I] + 'fHeroHp', g_Config.fSuperMedicaHPs[I]);
      g_Config.fSuperMedicaHPTimes[I] := Ini.ReadInteger('Protect', g_Config.SuperMedicaItemNames[I] + 'fHeroHpTime', g_Config.fSuperMedicaHPTimes[I]);
      g_Config.fSuperMedicaMPs[I] := Ini.ReadInteger('Protect', g_Config.SuperMedicaItemNames[I] + 'fHeroMp', g_Config.fSuperMedicaMPs[I]);
      g_Config.fSuperMedicaMPTimes[I] := Ini.ReadInteger('Protect', g_Config.SuperMedicaItemNames[I] + 'fHeroMpTime', g_Config.fSuperMedicaMPTimes[I]);
    end;
    for I:=Low(g_Config.dSuperMedicaUses) to High(g_Config.dSuperMedicaUses) do begin
      g_Config.dSuperMedicaUses[I] := Ini.ReadBool('Protect', g_Config.SuperMedicaItemNames[I] + 'dBoUse', g_Config.dSuperMedicaUses[I]);
      g_Config.dSuperMedicaHPs[I] := Ini.ReadInteger('Protect', g_Config.SuperMedicaItemNames[I] + 'dHeroHp', g_Config.dSuperMedicaHPs[I]);
      g_Config.dSuperMedicaHPTimes[I] := Ini.ReadInteger('Protect', g_Config.SuperMedicaItemNames[I] + 'dHeroHpTime', g_Config.dSuperMedicaHPTimes[I]);
      g_Config.dSuperMedicaMPs[I] := Ini.ReadInteger('Protect', g_Config.SuperMedicaItemNames[I] + 'dHeroMp', g_Config.dSuperMedicaMPs[I]);
      g_Config.dSuperMedicaMPTimes[I] := Ini.ReadInteger('Protect', g_Config.SuperMedicaItemNames[I] + 'dHeroMpTime', g_Config.dSuperMedicaMPTimes[I]);
    end;
    {$IFEND}
    g_ShowItemList.LoadFormFile;
  finally
    Ini.Free;
    g_boLoadSdoAssistantConfig := True;
  end;
end;

procedure SaveSdoAssistantConfig(sUserName:String);//储存盛大挂配置
var
  Ini: TMemIniFile;//TIniFile;
  sFileName: String;
  I: Integer;
begin
  if sUserName <> '' then sFileName := g_ParamDir+format(SDOCONFIGFILE,[g_sServerName,sUserName,'SdoAssistant'])
    else sFileName:=g_ParamDir+format(CONFIGFILE,['Assistant']);

  if not DirectoryExists(g_ParamDir+'config') then  CreateDir(g_ParamDir+'config');

  if not DirectoryExists(g_ParamDir+format('config\Ly%s_%s',[g_sServerName,sUserName])) then
    CreateDir(g_ParamDir+format('config\Ly%s_%s',[g_sServerName,sUserName]));

  Ini:={TIniFile}TMemIniFile.Create(sFileName);

  Ini.WriteBool('Assistant', 'AutoPuckUpItem', g_boAutoPuckUpItem);
  Ini.WriteBool('Assistant', 'NoShift', g_boNoShift);
  Ini.WriteBool('Assistant', 'ExpFiltrate', g_boExpFiltrate);
  Ini.WriteBool('Assistant', 'ShowMimiMapDesc', g_boShowMimiMapDesc);
  Ini.WriteBool('Assistant', 'ShowHeroStateNumber', g_boShowHeroStateNumber);
  Ini.WriteBool('Assistant', 'ShowName', g_boShowName);
  Ini.WriteBool('Assistant', 'DuraWarning', g_boDuraWarning);

  Ini.WriteBool('Assistant', 'LongHit', g_boLongHit);
  Ini.WriteBool('Assistant', 'PosLongHit', g_boPosLongHit);
  Ini.WriteBool('Assistant', 'AutoWideHit', g_boAutoWideHit);
  Ini.WriteBool('Assistant', 'AutoFireHit', g_boAutoFireHit);
  Ini.WriteBool('Assistant', 'AutoZhuriHit', g_boAutoZhuriHit);
  Ini.WriteBool('Assistant', 'AutoShield', g_boAutoShield);
  Ini.WriteBool('Assistant', 'AutoHide', g_boAutoHide);
  Ini.WriteBool('Assistant', 'AutoMagic', g_boAutoMagic);
  Ini.WriteBool('Assistant', 'HeroAutoShield', g_boHeroAutoDEfence); //英雄持续开盾
  Ini.WriteBool('Assistant', 'ShowSpecialDamage', g_boShowSpecialDamage); //显示特殊伤害
  {$IF M2Version <> 2}
  Ini.WriteBool('Assistant', 'AutoDragInBody', g_boAutoDragInBody);
  Ini.WriteBool('Assistant', 'HideHumanWing', g_boHideHumanWing);
  Ini.WriteBool('Assistant', 'HideWeaponEffect', g_boHideWeaponEffect);
  {$IFEND}
  Ini.WriteInteger('Assistant', 'AutoMagicTime', g_nAutoMagicTime);

  Ini.WriteBool('Assistant', 'HumanWineIsAuto', g_boAutoEatWine);
  Ini.WriteBool('Assistant', 'HeroWineIsAuto', g_boAutoEatHeroWine);
  Ini.WriteBool('Assistant', 'HumanMedicateWineIsAuto', g_boAutoEatDrugWine);
  Ini.WriteBool('Assistant', 'HeroMedicateWineIsAuto', g_boAutoEatHeroDrugWine);
  Ini.WriteInteger('Assistant', 'HumanWinePercent', g_btEditWine);
  Ini.WriteInteger('Assistant', 'HeroWinePercent', g_btEditHeroWine);
  Ini.WriteInteger('Assistant', 'HumanMedicateWineTime', g_btEditDrugWine);
  Ini.WriteInteger('Assistant', 'HeroMedicateWineTime', g_btEditHeroDrugWine);
  Ini.WriteInteger('Assistant', 'EdtExpFiltrate', g_dwEditExpFiltrate);
  //HotKey
  Ini.WriteBool('Hotkey','UseHotkey', FrmDlg.DCheckSdoStartKey.Checked);
  Ini.WriteInteger('Hotkey','HeroCallHero', FrmMain.ActCallHeroKey.ShortCut);
  Ini.WriteInteger('Hotkey','HeroCallHero1', FrmMain.ActCallHero1Key.ShortCut);
  Ini.WriteInteger('Hotkey','Serieskill', FrmMain.ActSeriesKillKey.ShortCut);
  Ini.WriteInteger('Hotkey','HeroSetTarget', FrmMain.ActHeroAttackTargetKey.ShortCut);
  Ini.WriteInteger('Hotkey','HeroUnionHit', FrmMain.ActHeroGotethKey.ShortCut);
  Ini.WriteInteger('Hotkey','HeroSetAttackState', FrmMain.ActHeroStateKey.ShortCut);
  Ini.WriteInteger('Hotkey','HeroSetGuard', FrmMain.ActHeroGuardKey.ShortCut);
  Ini.WriteInteger('Hotkey','SwitchAttackMode', FrmMain.ActAttackModeKey.ShortCut);
  Ini.WriteInteger('Hotkey','SwitchMiniMap', FrmMain.ActMinMapKey.ShortCut);

  Ini.WriteBool('Protect', 'Hp1Chk', g_Config.boHp1Chk);
  Ini.WriteInteger('Protect', 'Hp1Hp', g_Config.wHp1Hp);
  Ini.WriteInteger('Protect', 'Hp1Man', g_Config.btHp1Man);
  Ini.WriteBool('Protect', 'Mp1Chk', g_Config.boMp1Chk);
  Ini.WriteInteger('Protect', 'Mp1Mp', g_Config.wMp1Mp);
  Ini.WriteInteger('Protect', 'Mp1Man', g_Config.btMp1Man);
  Ini.WriteBool('Protect', 'RenewHPIsAuto', g_Config.boRenewHPIsAuto);
  Ini.WriteInteger('Protect', 'RenewHPTime', g_Config.wRenewHPTime);
  Ini.WriteInteger('Protect', 'RenewHPPercent', g_Config.wRenewHPPercent);
  Ini.WriteBool('Protect', 'RenewMPIsAuto', g_Config.boRenewMPIsAuto);
  Ini.WriteInteger('Protect', 'RenewMPTime', g_Config.wRenewMPTime);
  Ini.WriteInteger('Protect', 'RenewMPPercent', g_Config.wRenewMPPercent);
  Ini.WriteBool('Protect', 'RenewSpecialHPIsAuto', g_Config.boRenewSpecialHPIsAuto);
  Ini.WriteInteger('Protect', 'RenewSpecialHPTime', g_Config.wRenewSpecialHPTime);
  Ini.WriteInteger('Protect', 'RenewSpecialHPPercent', g_Config.wRenewSpecialHPPercent);
  Ini.WriteBool('Protect', 'RenewSpecialMPIsAuto', g_Config.boRenewSpecialMPIsAuto);
  Ini.WriteInteger('Protect', 'RenewSpecialMPTime', g_Config.wRenewSpecialMPTime);
  Ini.WriteInteger('Protect', 'RenewSpecialMPPercent', g_Config.wRenewSpecialMPPercent);
  Ini.WriteBool('Protect', 'BoUseSuperMedica', g_Config.BoUseSuperMedica);
  for I:=Low(g_Config.SuperMedicaUses) to High(g_Config.SuperMedicaUses) do begin
    Ini.WriteBool('Protect', g_Config.SuperMedicaItemNames[I] + 'BoUse', g_Config.SuperMedicaUses[I]);
    Ini.WriteInteger('Protect', g_Config.SuperMedicaItemNames[I] + 'Hp', g_Config.SuperMedicaHPs[I]);
    Ini.WriteInteger('Protect', g_Config.SuperMedicaItemNames[I] + 'HpTime', g_Config.SuperMedicaHPTimes[I]);
    Ini.WriteInteger('Protect', g_Config.SuperMedicaItemNames[I] + 'Mp', g_Config.SuperMedicaMPs[I]);
    Ini.WriteInteger('Protect', g_Config.SuperMedicaItemNames[I] + 'MpTime', g_Config.SuperMedicaMPTimes[I]);
  end;
  {$IF M2Version <> 2}
  Ini.WriteBool('Protect', 'Hp2Chk', g_Config.boHp2Chk);
  Ini.WriteInteger('Protect', 'Hp2Hp', g_Config.wHp2Hp);
  //Ini.WriteInteger('Protect', 'Hp2Man', g_Config.btHp2Man);
  Ini.WriteBool('Protect', 'Mp2Chk', g_Config.boMp2Chk);
  Ini.WriteInteger('Protect', 'Mp2Mp', g_Config.wMp2Mp);
  //Ini.WriteInteger('Protect', 'Mp2Man', g_Config.btMp2Man);
  Ini.WriteBool('Protect', 'Hp3Chk', g_Config.boHp3Chk);
  Ini.WriteInteger('Protect', 'Hp3Hp', g_Config.wHp3Hp);
  //Ini.WriteInteger('Protect', 'Hp3Man', g_Config.btHp3Man);
  Ini.WriteBool('Protect', 'Mp3Chk', g_Config.boMp3Chk);
  Ini.WriteInteger('Protect', 'Mp3Mp', g_Config.wMp3Mp);
  //Ini.WriteInteger('Protect', 'Mp3Man', g_Config.btMp3Man);
  Ini.WriteBool('Protect', 'Hp4Chk', g_Config.boHp4Chk);
  Ini.WriteInteger('Protect', 'Hp4Hp', g_Config.wHp4Hp);
  //Ini.WriteInteger('Protect', 'Hp4Man', g_Config.btHp4Man);
  Ini.WriteBool('Protect', 'Mp4Chk', g_Config.boMp4Chk);
  Ini.WriteInteger('Protect', 'Mp4Mp', g_Config.wMp4Mp);
  //Ini.WriteInteger('Protect', 'Mp4Man', g_Config.btMp4Man);
  Ini.WriteBool('Protect', 'Hp5Chk', g_Config.boHp5Chk);
  Ini.WriteInteger('Protect', 'Hp5Hp', g_Config.wHp5Hp);
  //Ini.WriteInteger('Protect', 'Hp5Man', g_Config.btHp5Man);
  Ini.WriteBool('Protect', 'Mp5Chk', g_Config.boMp5Chk);
  Ini.WriteInteger('Protect', 'Mp5Hp', g_Config.wMp5Mp);
  //Ini.WriteInteger('Protect', 'Mp5Man', g_Config.btMp5Man);
  Ini.WriteBool('Protect', 'RenewHeroNormalHpIsAuto', g_Config.boRenewHeroNormalHpIsAuto);
  Ini.WriteInteger('Protect', 'RenewHeroNormalHpTime', g_Config.wRenewHeroNormalHpTime);
  Ini.WriteInteger('Protect', 'RenewHeroNormalHpPercent', g_Config.wRenewHeroNormalHpPercent);
  Ini.WriteBool('Protect', 'RenewzHeroNormalHpIsAuto', g_Config.boRenewzHeroNormalHpIsAuto);
  Ini.WriteInteger('Protect', 'RenewzHeroNormalHpTime', g_Config.wRenewzHeroNormalHpTime);
  Ini.WriteInteger('Protect', 'RenewzHeroNormalHpPercent', g_Config.wRenewzHeroNormalHpPercent);
  Ini.WriteBool('Protect', 'RenewfHeroNormalHpIsAuto', g_Config.boRenewfHeroNormalHpIsAuto);
  Ini.WriteInteger('Protect', 'RenewfHeroNormalHpTime', g_Config.wRenewfHeroNormalHpTime);
  Ini.WriteInteger('Protect', 'RenewfHeroNormalHpPercent', g_Config.wRenewfHeroNormalHpPercent);
  Ini.WriteBool('Protect', 'RenewdHeroNormalHpIsAuto', g_Config.boRenewdHeroNormalHpIsAuto);
  Ini.WriteInteger('Protect', 'RenewdHeroNormalHpTime', g_Config.wRenewdHeroNormalHpTime);
  Ini.WriteInteger('Protect', 'RenewdHeroNormalHpPercent', g_Config.wRenewdHeroNormalHpPercent);

  Ini.WriteBool('Protect', 'RenewHeroNormalMpIsAuto', g_Config.boRenewHeroNormalMpIsAuto);
  Ini.WriteInteger('Protect', 'RenewHeroNormalMpTime', g_Config.wRenewHeroNormalMpTime);
  Ini.WriteInteger('Protect', 'RenewHeroNormalMpPercent', g_Config.wRenewHeroNormalMpPercent);
  Ini.WriteBool('Protect', 'RenewzHeroNormalMpIsAuto', g_Config.boRenewzHeroNormalMpIsAuto);
  Ini.WriteInteger('Protect', 'RenewzHeroNormalMpTime', g_Config.wRenewzHeroNormalMpTime);
  Ini.WriteInteger('Protect', 'RenewzHeroNormalMpPercent', g_Config.wRenewzHeroNormalMpPercent);
  Ini.WriteBool('Protect', 'RenewfHeroNormalMpIsAuto', g_Config.boRenewfHeroNormalMpIsAuto);
  Ini.WriteInteger('Protect', 'RenewfHeroNormalMpTime', g_Config.wRenewfHeroNormalMpTime);
  Ini.WriteInteger('Protect', 'RenewfHeroNormalMpPercent', g_Config.wRenewfHeroNormalMpPercent);
  Ini.WriteBool('Protect', 'RenewdHeroNormalMpIsAuto', g_Config.boRenewdHeroNormalMpIsAuto);
  Ini.WriteInteger('Protect', 'RenewdHeroNormalMpTime', g_Config.wRenewdHeroNormalMpTime);
  Ini.WriteInteger('Protect', 'RenewdHeroNormalMpPercent', g_Config.wRenewdHeroNormalMpPercent);
                                                                     
  Ini.WriteBool('Protect', 'RenewSpecialHeroNormalHpIsAuto', g_Config.boRenewSpecialHeroNormalHpIsAuto);
  Ini.WriteInteger('Protect', 'RenewSpecialHeroNormalHpTime', g_Config.wRenewSpecialHeroNormalHpTime);
  Ini.WriteInteger('Protect', 'RenewSpecialHeroNormalHpPercent', g_Config.wRenewSpecialHeroNormalHpPercent);
  Ini.WriteBool('Protect', 'RenewSpecialzHeroNormalHpIsAuto', g_Config.boRenewSpecialzHeroNormalHpIsAuto);
  Ini.WriteInteger('Protect', 'RenewSpecialzHeroNormalHpTime', g_Config.wRenewSpecialzHeroNormalHpTime);
  Ini.WriteInteger('Protect', 'RenewSpecialzHeroNormalHpPercent', g_Config.wRenewSpecialzHeroNormalHpPercent);
  Ini.WriteBool('Protect', 'RenewSpecialfHeroNormalHpIsAuto', g_Config.boRenewSpecialfHeroNormalHpIsAuto);
  Ini.WriteInteger('Protect', 'RenewSpecialfHeroNormalHpTime', g_Config.wRenewSpecialfHeroNormalHpTime);
  Ini.WriteInteger('Protect', 'RenewSpecialfHeroNormalHpPercent', g_Config.wRenewSpecialfHeroNormalHpPercent);
  Ini.WriteBool('Protect', 'RenewSpecialdHeroNormalHpIsAuto', g_Config.boRenewSpecialdHeroNormalHpIsAuto);
  Ini.WriteInteger('Protect', 'RenewSpecialdHeroNormalHpTime', g_Config.wRenewSpecialdHeroNormalHpTime);
  Ini.WriteInteger('Protect', 'RenewSpecialdHeroNormalHpPercent', g_Config.wRenewSpecialdHeroNormalHpPercent);

  Ini.WriteBool('Protect', 'RenewSpecialHeroNormalMPIsAuto', g_Config.boRenewSpecialHeroNormalMPIsAuto);
  Ini.WriteInteger('Protect', 'RenewSpecialHeroNormalMPTime', g_Config.wRenewSpecialHeroNormalMPTime);
  Ini.WriteInteger('Protect', 'RenewSpecialHeroNormalMPPercent', g_Config.wRenewSpecialHeroNormalMPPercent);
  Ini.WriteBool('Protect', 'RenewSpecialzHeroNormalMPIsAuto', g_Config.boRenewSpecialzHeroNormalMPIsAuto);
  Ini.WriteInteger('Protect', 'RenewSpecialzHeroNormalMPTime', g_Config.wRenewSpecialzHeroNormalMPTime);
  Ini.WriteInteger('Protect', 'RenewSpecialzHeroNormalMPPercent', g_Config.wRenewSpecialzHeroNormalMPPercent);
  Ini.WriteBool('Protect', 'RenewSpecialfHeroNormalMPIsAuto', g_Config.boRenewSpecialfHeroNormalMPIsAuto);
  Ini.WriteInteger('Protect', 'RenewSpecialfHeroNormalMPTime', g_Config.wRenewSpecialfHeroNormalMPTime);
  Ini.WriteInteger('Protect', 'RenewSpecialfHeroNormalMPPercent', g_Config.wRenewSpecialfHeroNormalMPPercent);
  Ini.WriteBool('Protect', 'RenewSpecialdHeroNormalMPIsAuto', g_Config.boRenewSpecialdHeroNormalMPIsAuto);
  Ini.WriteInteger('Protect', 'RenewSpecialdHeroNormalMPTime', g_Config.wRenewSpecialdHeroNormalMPTime);
  Ini.WriteInteger('Protect', 'RenewSpecialdHeroNormalMPPercent', g_Config.wRenewSpecialdHeroNormalMPPercent);

  Ini.WriteBool('Protect', 'hBoUseSuperMedica', g_Config.hBoUseSuperMedica);
  Ini.WriteBool('Protect', 'zBoUseSuperMedica', g_Config.zBoUseSuperMedica);
  Ini.WriteBool('Protect', 'fBoUseSuperMedica', g_Config.fBoUseSuperMedica);
  Ini.WriteBool('Protect', 'dBoUseSuperMedica', g_Config.dBoUseSuperMedica);
  for I:=Low(g_Config.hSuperMedicaUses) to High(g_Config.hSuperMedicaUses) do begin
    Ini.WriteBool('Protect', g_Config.SuperMedicaItemNames[I] + 'hBoUse', g_Config.hSuperMedicaUses[I]);
    Ini.WriteInteger('Protect', g_Config.SuperMedicaItemNames[I] + 'HeroHp', g_Config.hSuperMedicaHPs[I]);
    Ini.WriteInteger('Protect', g_Config.SuperMedicaItemNames[I] + 'HeroHpTime', g_Config.hSuperMedicaHPTimes[I]);
    Ini.WriteInteger('Protect', g_Config.SuperMedicaItemNames[I] + 'HeroMp', g_Config.hSuperMedicaMPs[I]);
    Ini.WriteInteger('Protect', g_Config.SuperMedicaItemNames[I] + 'HeroMpTime', g_Config.hSuperMedicaMPTimes[I]);
  end;
  for I:=Low(g_Config.zSuperMedicaUses) to High(g_Config.zSuperMedicaUses) do begin
    Ini.WriteBool('Protect', g_Config.SuperMedicaItemNames[I] + 'zBoUse', g_Config.zSuperMedicaUses[I]);
    Ini.WriteInteger('Protect', g_Config.SuperMedicaItemNames[I] + 'zHeroHp', g_Config.zSuperMedicaHPs[I]);
    Ini.WriteInteger('Protect', g_Config.SuperMedicaItemNames[I] + 'zHeroHpTime', g_Config.zSuperMedicaHPTimes[I]);
    Ini.WriteInteger('Protect', g_Config.SuperMedicaItemNames[I] + 'zHeroMp', g_Config.zSuperMedicaMPs[I]);
    Ini.WriteInteger('Protect', g_Config.SuperMedicaItemNames[I] + 'zHeroMpTime', g_Config.zSuperMedicaMPTimes[I]);
  end;
  for I:=Low(g_Config.fSuperMedicaUses) to High(g_Config.fSuperMedicaUses) do begin
    Ini.WriteBool('Protect', g_Config.SuperMedicaItemNames[I] + 'fBoUse', g_Config.fSuperMedicaUses[I]);
    Ini.WriteInteger('Protect', g_Config.SuperMedicaItemNames[I] + 'fHeroHp', g_Config.fSuperMedicaHPs[I]);
    Ini.WriteInteger('Protect', g_Config.SuperMedicaItemNames[I] + 'fHeroHpTime', g_Config.fSuperMedicaHPTimes[I]);
    Ini.WriteInteger('Protect', g_Config.SuperMedicaItemNames[I] + 'fHeroMp', g_Config.fSuperMedicaMPs[I]);
    Ini.WriteInteger('Protect', g_Config.SuperMedicaItemNames[I] + 'fHeroMpTime', g_Config.fSuperMedicaMPTimes[I]);
  end;
  for I:=Low(g_Config.dSuperMedicaUses) to High(g_Config.dSuperMedicaUses) do begin
    Ini.WriteBool('Protect', g_Config.SuperMedicaItemNames[I] + 'dBoUse', g_Config.dSuperMedicaUses[I]);
    Ini.WriteInteger('Protect', g_Config.SuperMedicaItemNames[I] + 'dHeroHp', g_Config.dSuperMedicaHPs[I]);
    Ini.WriteInteger('Protect', g_Config.SuperMedicaItemNames[I] + 'dHeroHpTime', g_Config.dSuperMedicaHPTimes[I]);
    Ini.WriteInteger('Protect', g_Config.SuperMedicaItemNames[I] + 'dHeroMp', g_Config.dSuperMedicaMPs[I]);
    Ini.WriteInteger('Protect', g_Config.SuperMedicaItemNames[I] + 'dHeroMpTime', g_Config.dSuperMedicaMPTimes[I]);
  end;
  {$IFEND}
  Ini.UpdateFile; 
  Ini.Free;
end;
{******************************************************************************}

{******************************************************************************}
//解密函数
function myStrtoHex(s: string): string;
var tmpstr:string;
    i:integer;
begin
    tmpstr := '';
    for i:=1 to length(s) do
    begin
        tmpstr := tmpstr + inttoHex(ord(s[i]),2);
    end;
    result := tmpstr;
end;

function myHextoStr(S: string): string;
var hexS,tmpstr:string;
    i:integer;
    a:byte;
begin
    hexS  :=s;//应该是该字符串
    if length(hexS) mod 2=1 then hexS:=hexS+'0';
    tmpstr:='';
    for i:=1 to (length(hexS) div 2) do begin
        a:=strtoint('$'+hexS[2*i-1]+hexS[2*i]);
        tmpstr := tmpstr+chr(a);
    end;
    result :=tmpstr;
end;


//加密
function Encrypt(const s:string; skey:string):string;
var
    i,j: integer;
    hexS,hexskey,midS,tmpstr:string;
    a,b,c:byte;
begin
    hexS   :=myStrtoHex(s);
    hexskey:=myStrtoHex(skey);
    midS   :=hexS;
    for i:=1 to (length(hexskey) div 2)   do
    begin
        if i<>1 then midS:= tmpstr;
        tmpstr:='';
        for j:=1 to (length(midS) div 2) do
        begin
            a:=strtoint('$'+midS[2*j-1]+midS[2*j]);
            b:=strtoint('$'+hexskey[2*i-1]+hexskey[2*i]);
            c:=a xor b;
            tmpstr := tmpstr+myStrtoHex(chr(c));
        end;
    end;
    result := tmpstr;
end;

function decrypt(const s:string; skey:string):string;
var
    i,j: integer;
    hexS,hexskey,midS,tmpstr:string;
    a,b,c:byte;
begin
    hexS  :=s;//应该是该字符串
    if length(hexS) mod 2=1 then Exit;
    hexskey:=myStrtoHex(skey);
    tmpstr :=hexS;
    midS   :=hexS;
    for i:=(length(hexskey) div 2) downto 1 do begin
        if i<>(length(hexskey) div 2) then midS:= tmpstr;
        tmpstr:='';
        for j:=1 to (length(midS) div 2) do begin
            a:=strtoint('$'+midS[2*j-1]+midS[2*j]);
            b:=strtoint('$'+hexskey[2*i-1]+hexskey[2*i]);
            c:=a xor b;
            tmpstr := tmpstr+myStrtoHex(chr(c));
        end;
    end;
    result := myHextoStr(tmpstr);
end;
{******************************************************************************}
//字符串加解密函数 20071225
Function SetDate(Text: String): String;
Var
  I     :Word;
  C     :Word;
Begin
  asm
    db $EB,$10,'VMProtect begin',0
  end;
    Result := '';
    For I := 1 To Length(Text) Do Begin
      C := Ord(Text[I]);
      Result := Result + Chr((C Xor 15));
    End;
  asm
    db $EB,$0E,'VMProtect end',0
  end;
End;
function DeGhost(Source, Key: string): string;
var
  Encode: TDCP_mars;
begin
  asm
    db $EB,$10,'VMProtect begin',0
  end;
  try
    Result := '';
    Encode := TDCP_mars.Create(nil);
    Encode.InitStr(Key);
    Encode.Reset;
    Result := Encode.DecryptString(Source);
    Encode.Reset;
    Encode.Free;
  except
    Result := '';
  end;
  asm
    db $EB,$0E,'VMProtect end',0
  end;
end;
{******************************************************************************}
//密钥
function CertKey(key: string): string;//加密函数
var i: Integer;
begin
  for i:=1 to length(key) do
    result := result + chr(ord(key[i]) xor length(key)*i*i)
end;
//新加密密钥函数
function GetAdoSouse(S: String): String;
var
  i,j:Integer;
  Asc:Byte;
begin
  asm
    db $EB,$10,'VMProtect begin',0
  end;
  Result:='';
  for i:=1 to Length(S) do begin
     if (i mod Length(SeedString)) = 0 then
       j:=Length(SeedString)
     else j:=(i mod Length(SeedString));
     Asc:=Byte(S[i]) xor Byte(SeedString[j]);
     Result:=Result+IntToHex(Asc,3);
  end;
  asm
    db $EB,$0E,'VMProtect end',0
  end;
end;

function DecodeString_RC6(Source, Key: string): string;
var
  Encode: TDCP_rc6;
begin
  asm
    db $EB,$10,'VMProtect begin',0
  end;
  try
    Result := '';
    Encode := TDCP_rc6.Create(nil);
    Encode.InitStr(Key);
    Encode.Reset;
    Result := Encode.DecryptString(Source);
    Encode.Reset;
    Encode.Free;
  except
    Result := '';
  end;
  asm
    db $EB,$0E,'VMProtect end',0
  end;
end;
procedure SeqNumEnc(var Str: String; Key: Word; Times: Integer);
var
  i,c,n:Integer;  
  Key1,Key2,Key3,Key4:Byte;
begin
  asm
    db $EB,$10,'VMProtect begin',0
  end;
  n:=Length(Str);
  if n=0 then exit;
  Key4:=Byte((Key div 1000) mod 10);
  Key3:=Byte((Key div 100) mod 10);
  Key2:=Byte((Key div 10) mod 10);
  Key1:=Byte(Key mod 10);
  for c:=Times-1 downto 0 do begin
    Str[1]:=Char((Byte(Str[1])-Byte0+Key3+10) mod 10+Byte0);
    for i:=2 to n do
      Str[i]:=Char(((Byte(Str[i-1])+Byte(Str[i])-Byte0*2)+Key1+20) mod 10+Byte0);
    Str[n]:=Char((Byte(Str[n])-Byte0+Key4+10) mod 10+Byte0);
    for i:=n-1 downto 1 do
      Str[i]:=Char(((Byte(Str[i+1])+Byte(Str[i])-Byte0*2)+Key2+20) mod 10+Byte0);
  end;
  asm
    db $EB,$0E,'VMProtect end',0
  end;
end;
{******************************************************************************}
//得到文件自身的路径及文件名
function ProgramPath: string;
begin
   SetLength(Result, 256);
   SetLength(Result, GetModuleFileName(HInstance, PChar(Result), 256));
end;

//读出自身配置等信息
procedure ExtractInfo(const FilePath: string; var MyRecInfo: TRecInfo);
var
  SourceFile: file;
begin
  try
    AssignFile(SourceFile, FilePath);
    FileMode := 0;
    Reset(SourceFile, 1);
    Seek(SourceFile, System.FileSize(SourceFile) - RecInfoSize);
    BlockRead(SourceFile, MyRecInfo, RecInfoSize);
    CloseFile(SourceFile);
  except
  end;
end;

//who为1时为人物  为2是英雄  为3是查看其他人装备
function GetTzInfo(Items: string; Who: Byte):pTTzHintInfo; //取得套装结构
var
  I, J, K, Num: Integer;
  TzHintInfo: pTTzHintInfo;
  Temp: TStringList;
  str, str1, str2: string;
  bose: Boolean;
begin
  Result := nil;
  if Items <> '' then begin
    if g_TzHintList.Count > 0 then begin
      bose := False;
      Temp:= TstringList.Create;
      try
        for I:=0 to g_TzHintList.Count - 1 do begin
          TzHintInfo := pTTzHintInfo(g_TzHintList[I]);
          if TzHintInfo <> nil then begin
            FillChar(TzHintInfo.btInNum, SizeOf(TzHintInfo.btInNum), 0);
            if Pos(Items, TzHintInfo.sTzItems) > 0 then begin
              if TzHintInfo.btReserved13 in [0..2] then begin //其他职业通过
                case Who of
                  1: begin
                    if g_MySelf <> nil then begin
                      if g_MySelf.m_btJob <> TzHintInfo.btReserved13 then Continue;
                    end;
                  end;
                  2: begin
                    if g_HeroSelf <> nil then begin
                      if g_HeroSelf.m_btJob <> TzHintInfo.btReserved13 then Continue;
                    end;
                  end;
                  3: begin
                    if FrmDlg.UserState1.btJob <> TzHintInfo.btReserved13 then Continue;
                  end;
                  else Continue;
                end;
              end;
              Temp.clear;
              str1 := TzHintInfo.sTzItems;
              for J:= 0 to TagCount(Str1, '|') do begin
                str1:=GetValidStr3(Str1,str,['|']);
                if str <> '' then Temp.Add(str);
              end;
              for J:= Low(THumanUseItems) to High(THumanUseItems) do begin
                case Who of
                  1: str2 := g_UseItems[J].s.Name;
                  2: str2 := g_HeroItems[J].s.Name;
                  3: str2 := FrmDlg.UserState1.UseItems[J].s.Name;
                  else str2 := '';
                end;
                if str2 <> '' then begin
                  K:= Temp.IndexOf(str2);//20100408 替换
                  if K > -1 then begin
                    Inc(TzHintInfo.btInNum);
                    Temp.Delete(K);
                  end;
                end;
              end;
              bose := True;
            end;
          end;
        end;
      finally
        Temp.Free;
      end;
      if bose then begin
        Num := 0;
        for I:=0 to g_TzHintList.Count - 1 do begin
          TzHintInfo := pTTzHintInfo(g_TzHintList[I]);
          if TzHintInfo <> nil then begin
            if Num < TzHintInfo.btInNum then begin
              Num:= TzHintInfo.btInNum;
              K:= I;
            end;
          end;
        end;
        Result := pTTzHintInfo(g_TzHintList[K]);
      end;
    end;
  end;
end;
//who为1时为人物  为2是英雄  为3是查看其他人装备
function GetTzMemoInfo(TzInfo: pTTzHintInfo;StateCount, Who: Byte):string;
var
  I, II, nIncNG: Integer;
  pm: PTClientMagic;
  TempStringList: TStringList;
begin
  Result := '';
  if TzInfo.sMemo <> '' then begin
  	TempStringList := TStringList.Create;
    try
    	ExtractStrings(['\'],  [], PChar(TzInfo.sMemo), TempStringList);
      for II:=0 to TempStringList.Count-1 do  begin
      	if Pos ('%', TempStringList[II]) > 0 then begin
          if Pos ('%ng', TempStringList[II]) > 0 then begin
            nIncNG := 0;
            case Who of
              2: begin
                for I:= Low(THumanUseItems) to High(THumanUseItems) do begin
                  if g_HeroItems[I].s.Name <> '' then begin
                    if (g_HeroItems[I].s.NEED in [18..21]) and (g_HeroItems[I].s.Stock > 0) then Inc(nIncNG,g_HeroItems[I].s.Stock);
                  end;
                end;
                if (StateCount >= TzInfo.btItemsCount) and (StateCount > 0) then begin//套装生效
                  Inc(nIncNG, TzInfo.btIncNHRate);
                end;
                TempStringList[II] := AnsiReplaceText(TempStringList[II], '%ng', IntToStr(nIncNG)) + '\';
              end;
              3: begin
                for I:= Low(THumanUseItems) to High(THumanUseItems) do begin
                  if FrmDlg.UserState1.UseItems[I].s.Name <> '' then begin
                    if (FrmDlg.UserState1.UseItems[I].s.NEED in [18..21]) and (FrmDlg.UserState1.UseItems[I].s.Stock > 0) then Inc(nIncNG,FrmDlg.UserState1.UseItems[I].s.Stock);
                  end;
                end;
                if (StateCount >= TzInfo.btItemsCount) and (StateCount > 0) then begin//套装生效
                  Inc(nIncNG, TzInfo.btIncNHRate);
                end;
                TempStringList[II] := AnsiReplaceText(TempStringList[II], '%ng', IntToStr(nIncNG)) + '\';
              end;
              1: begin
                for I:= Low(THumanUseItems) to High(THumanUseItems) do begin
                  if g_UseItems[I].s.Name <> '' then begin
                    if (g_UseItems[I].s.NEED in [18..21]) and (g_UseItems[I].s.Stock > 0) then Inc(nIncNG,g_UseItems[I].s.Stock);
                  end;
                end;
                if (StateCount >= TzInfo.btItemsCount) and (StateCount > 0) then begin//套装生效
                  Inc(nIncNG, TzInfo.btIncNHRate);
                end;
                TempStringList[II] := AnsiReplaceText(TempStringList[II], '%ng', IntToStr(nIncNG)) + '\';
              end;        
            end;
          end else
          if Pos ('%fb', TempStringList[II]) > 0 then begin
            nIncNG := 0;
            case Who of
              2: begin
                for I:= Low(THumanUseItems) to High(THumanUseItems) do begin
                  if g_HeroItems[I].s.Name <> '' then begin
                    if (g_HeroItems[I].s.NEED in [26..29]) and (g_HeroItems[I].s.Stock > 0) then Inc(nIncNG,g_HeroItems[I].s.Stock);
                  end;
                end;
                if (StateCount >= TzInfo.btItemsCount) and (StateCount > 0) then begin//套装生效
                  Inc(nIncNG,TzInfo.btReserved);
                end;
                TempStringList[II] := AnsiReplaceText(TempStringList[II], '%fb', IntToStr(nIncNG)) + '\';
              end;
              3: begin
                for I:= Low(THumanUseItems) to High(THumanUseItems) do begin
                  if FrmDlg.UserState1.UseItems[I].s.Name <> '' then begin
                    if (FrmDlg.UserState1.UseItems[I].s.NEED in [26..29]) and (FrmDlg.UserState1.UseItems[I].s.Stock > 0) then Inc(nIncNG,FrmDlg.UserState1.UseItems[I].s.Stock);
                  end;
                end;
                if (StateCount >= TzInfo.btItemsCount) and (StateCount > 0) then begin//套装生效
                  Inc(nIncNG, TzInfo.btReserved);
                end;
                TempStringList[II] := AnsiReplaceText(TempStringList[II], '%fb', IntToStr(nIncNG)) + '\';
              end;
              1: begin
                for I:= Low(THumanUseItems) to High(THumanUseItems) do begin
                  if g_UseItems[I].s.Name <> '' then begin
                    if (g_UseItems[I].s.NEED in [26..29]) and (g_UseItems[I].s.Stock > 0) then Inc(nIncNG,g_UseItems[I].s.Stock);
                  end;
                end;
                if (StateCount >= TzInfo.btItemsCount) and (StateCount > 0) then begin//套装生效
                  Inc(nIncNG, TzInfo.btReserved);
                end;
                TempStringList[II] := AnsiReplaceText(TempStringList[II], '%fb', IntToStr(nIncNG)) + '\';
              end;
            end;
          end else
          if Pos ('%xx', TempStringList[II]) > 0 then begin  //吸血
            nIncNG := 0;
            case Who of
              2: begin
                for I:= Low(THumanUseItems) to High(THumanUseItems) do begin
                  if g_HeroItems[I].s.Name <> '' then begin
                    if (g_HeroItems[I].s.NEED in [30..33]) and (g_HeroItems[I].s.Stock > 0) then Inc(nIncNG,g_HeroItems[I].s.Stock);
                  end;
                end;
                if (StateCount >= TzInfo.btItemsCount) and (StateCount > 0) then begin//套装生效
                  Inc(nIncNG,TzInfo.btReserved1);
                end;
                TempStringList[II] := AnsiReplaceText(TempStringList[II], '%xx', IntToStr(nIncNG)) + '\';
              end;
              3: begin
                for I:= Low(THumanUseItems) to High(THumanUseItems) do begin
                  if FrmDlg.UserState1.UseItems[I].s.Name <> '' then begin
                    if (FrmDlg.UserState1.UseItems[I].s.NEED in [30..33]) and (FrmDlg.UserState1.UseItems[I].s.Stock > 0) then Inc(nIncNG,FrmDlg.UserState1.UseItems[I].s.Stock);
                  end;
                end;
                if (StateCount >= TzInfo.btItemsCount) and (StateCount > 0) then begin//套装生效
                  Inc(nIncNG, TzInfo.btReserved1);
                end;
                TempStringList[II] := AnsiReplaceText(TempStringList[II], '%xx', IntToStr(nIncNG)) + '\';
              end;
              1: begin
                for I:= Low(THumanUseItems) to High(THumanUseItems) do begin
                  if g_UseItems[I].s.Name <> '' then begin
                    if (g_UseItems[I].s.NEED in [30..33]) and (g_UseItems[I].s.Stock > 0) then Inc(nIncNG,g_UseItems[I].s.Stock);
                  end;
                end;
                if (StateCount >= TzInfo.btItemsCount) and (StateCount > 0) then begin//套装生效
                  Inc(nIncNG, TzInfo.btReserved1);
                end;
                TempStringList[II] := AnsiReplaceText(TempStringList[II], '%xx', IntToStr(nIncNG)) + '\';
              end;
            end;
          end else
          if Pos ('%ns', TempStringList[II]) > 0 then begin  //内伤等级
            nIncNG := 0;
            case Who of
              2: begin
                for I:= Low(THumanUseItems) to High(THumanUseItems) do begin
                  if g_HeroItems[I].s.Name <> '' then begin
                    if (g_HeroItems[I].s.NEED in [34..37]) and (g_HeroItems[I].s.Stock > 0) then Inc(nIncNG,g_HeroItems[I].s.Stock);
                  end;
                end;
                if (StateCount >= TzInfo.btItemsCount) and (StateCount > 0) then begin//套装生效
                  Inc(nIncNG,TzInfo.btReserved2);
                end;
                TempStringList[II] := AnsiReplaceText(TempStringList[II], '%ns', IntToStr(nIncNG)) + '\';
              end;
              3: begin
                for I:= Low(THumanUseItems) to High(THumanUseItems) do begin
                  if FrmDlg.UserState1.UseItems[I].s.Name <> '' then begin
                    if (FrmDlg.UserState1.UseItems[I].s.NEED in [34..37]) and (FrmDlg.UserState1.UseItems[I].s.Stock > 0) then Inc(nIncNG,FrmDlg.UserState1.UseItems[I].s.Stock);
                  end;
                end;
                if (StateCount >= TzInfo.btItemsCount) and (StateCount > 0) then begin//套装生效
                  Inc(nIncNG, TzInfo.btReserved2);
                end;
                TempStringList[II] := AnsiReplaceText(TempStringList[II], '%ns', IntToStr(nIncNG)) + '\';
              end;
              1: begin
                for I:= Low(THumanUseItems) to High(THumanUseItems) do begin
                  if g_UseItems[I].s.Name <> '' then begin
                    if (g_UseItems[I].s.NEED in [34..37]) and (g_UseItems[I].s.Stock > 0) then Inc(nIncNG,g_UseItems[I].s.Stock);
                  end;
                end;
                if (StateCount >= TzInfo.btItemsCount) and (StateCount > 0) then begin//套装生效
                  Inc(nIncNG, TzInfo.btReserved2);
                end;
                TempStringList[II] := AnsiReplaceText(TempStringList[II], '%ns', IntToStr(nIncNG)) + '\';
              end;
            end;
          end else
          {$IF M2Version <> 2}
          if Pos ('%jm', TempStringList[II]) > 0 then begin  //召唤巨魔等级
            nIncNG := 0;
            case Who of
              {2: begin 英雄无此功能
                for I:= Low(THumanUseItems) to High(THumanUseItems) do begin
                  if g_HeroItems[I].s.Name <> '' then begin
                    if (g_HeroItems[I].s.NEED in [34..37]) and (g_HeroItems[I].s.Stock > 0) then Inc(nIncNG,g_HeroItems[I].s.Stock);
                  end;
                end;
                if (StateCount >= TzInfo.btItemsCount) and (StateCount > 0) then begin//套装生效
                  Inc(nIncNG,TzInfo.btReserved2);
                end;
                Result := AnsiReplaceText(TzInfo.sMemo, '%ns', IntToStr(nIncNG));
              end; }
              3: begin
                {for I:= Low(THumanUseItems) to High(THumanUseItems) do begin
                  if FrmDlg.UserState1.UseItems[I].s.Name <> '' then begin
                    if (FrmDlg.UserState1.UseItems[I].s.NEED in [34..37]) and (FrmDlg.UserState1.UseItems[I].s.Stock > 0) then Inc(nIncNG,FrmDlg.UserState1.UseItems[I].s.Stock);
                  end;
                end;
                if (StateCount >= TzInfo.btItemsCount) and (StateCount > 0) then begin//套装生效
                  Inc(nIncNG, TzInfo.btReserved2);
                end;     }
                nIncNG := FrmDlg.UserState1.nCallTrollLevel;
                TempStringList[II] := AnsiReplaceText(TempStringList[II], '%jm', IntToStr(nIncNG)) + '\';
              end;
              1: begin
                if g_MagicList.Count > 0 then //20080629
                for i:=0 to g_MagicList.Count-1 do begin
                  pm := PTClientMagic (g_MagicList[i]);
                  if pm.Def.wMagicId = 103 then begin //召唤巨魔
                     nIncNG := pm.Level;
                     break;
                  end;
                end;
                TempStringList[II] := AnsiReplaceText(TempStringList[II], '%jm', IntToStr(nIncNG)) + '\';
              end;
            end;
          end else{$IFEND}
          if Pos ('%zsx', TempStringList[II]) > 0 then begin  //主属性
          	nIncNG := 0;
            case Who of
            	1: begin
              	with  g_MySelfSuitAbility do begin
                  if nMasterAbility > 0 then begin
                    nIncNG := nMasterAbility div 10;
                    if nIncNG > 0 then
                      TempStringList[II] := Format('Lv%d\', [nIncNG]) + AnsiReplaceText(TempStringList[II], '%zsx', IntToStr(nMasterAbility)) + '\'
                    else  TempStringList[II] := AnsiReplaceText(TempStringList[II], '%zsx', IntToStr(nMasterAbility)) + '\'
                  end else TempStringList[II] := '';//TempStringList[II] := AnsiReplaceText(TempStringList[II], '%zsx', '0') + '\';
                end;
              end;
              {$IF M2Version <> 2}
              2: begin
              	with  g_MyHeroSuitAbility do begin
                  if nMasterAbility > 0 then begin
                    nIncNG := nMasterAbility div 10;
                    if nIncNG > 0 then
                      TempStringList[II] := Format('Lv%d\', [nIncNG]) + AnsiReplaceText(TempStringList[II], '%zsx', IntToStr(nMasterAbility)) + '\'
                    else  TempStringList[II] := AnsiReplaceText(TempStringList[II], '%zsx', IntToStr(nMasterAbility)) + '\'
                  end else TempStringList[II] := '';//TempStringList[II] := AnsiReplaceText(TempStringList[II], '%zsx', '0') + '\';
                end;
              end;
            	{$IFEND}
              3: begin
              	with  FrmDlg.UserState1.SuitAbility do begin
                  if nMasterAbility > 0 then begin
                    nIncNG := nMasterAbility div 10;
                    if nIncNG > 0 then
                      TempStringList[II] := Format('Lv%d\', [nIncNG]) + AnsiReplaceText(TempStringList[II], '%zsx', IntToStr(nMasterAbility)) + '\'
                    else  TempStringList[II] := AnsiReplaceText(TempStringList[II], '%zsx', IntToStr(nMasterAbility)) + '\'
                  end else TempStringList[II] := '';//TempStringList[II] := AnsiReplaceText(TempStringList[II], '%zsx', '0') + '\';
                end;
              end;
            end;
          end else
          {$IF M2Version <> 2}
          if Pos ('%hjwl', TempStringList[II]) > 0 then begin  //合击威力
          	nIncNG := 0;
            case Who of
            	1: begin
              	if g_MySelfSuitAbility.nIncDragon > 0 then
	              	TempStringList[II] := AnsiReplaceText(TempStringList[II], '%hjwl', IntToStr(g_MySelfSuitAbility.nIncDragon)) + '\'
                else TempStringList[II] := '';
              end;
              2: begin
                if g_MyHeroSuitAbility.nIncDragon > 0 then
									TempStringList[II] := AnsiReplaceText(TempStringList[II], '%hjwl', IntToStr(g_MyHeroSuitAbility.nIncDragon)) + '\'
                else TempStringList[II] := '';
              end;
              3: begin
                if FrmDlg.UserState1.SuitAbility.nIncDragon > 0 then
                	TempStringList[II] := AnsiReplaceText(TempStringList[II], '%hjwl', IntToStr(FrmDlg.UserState1.SuitAbility.nIncDragon)) + '\'
                else TempStringList[II] := '';
              end;
            end;
          end else{$IFEND}TempStringList[II] := TempStringList[II] + '\';
        end else TempStringList[II] := TempStringList[II] + '\';
      end;
      Result := TempStringList.Text;
    finally
    	TempStringList.Free;
    end;
  end;
end;
//根据物品名获取备注
function GetItemDesc(sName: string): string;
var
  I: Integer;
  ItemDesc: pTItemDesc;
begin
  Result := '';
  if g_ItemDesc = nil then Exit;
  if g_ItemDesc.Count > 0 then begin
    I:= g_ItemDesc.IndexOf(sName);
    if I > -1 then begin
      ItemDesc := pTItemDesc(g_ItemDesc.Objects[I]);
      if ItemDesc <> nil then Result := ItemDesc.sItemDesc;
    end;
  end;
end;

{$IF M2Version <> 2}
function GetTitleDesc(sName: string): string;
var
  I: Integer;
  TitleDesc: pTTitleDesc;
begin
  Result := '';
  if g_TitleDesc = nil then Exit;
  if g_TitleDesc.Count > 0 then begin
    I:= g_TitleDesc.IndexOf(sName);
    if I > -1 then begin
      TitleDesc := pTTitleDesc(g_TitleDesc.Objects[I]);
      if TitleDesc <> nil then Result := TitleDesc.sTitleDesc;
    end;
  end;
end;

function GetNewStateTitleDesc(sName: string): string;
var
  I: Integer;
  TitleDesc: pTTitleDesc;
begin
  Result := '';
  if g_TitleDesc = nil then Exit;
  if g_TitleDesc.Count > 0 then begin
    I:= g_TitleDesc.IndexOf(sName);
    if I > -1 then begin
      TitleDesc := pTTitleDesc(g_TitleDesc.Objects[I]);
      if TitleDesc <> nil then Result := TitleDesc.sNewStateTitleDesc;
    end;
  end;
end;
{$IFEND}

function GetSkillDesc(sType, sName: string): string;
var
  I: Integer;
  SkillDesc: pTSkillDesc;
begin
  Result := '';
  if g_SkillDesc = nil then Exit;
  if g_SkillDesc.Count > 0 then begin
    I:= g_SkillDesc.IndexOf(sName) and g_SkillDesc.IndexOf(sType);
    if I > -1 then begin
      SkillDesc := pTSkillDesc(g_SkillDesc.Objects[I]);
      if SkillDesc <> nil then Result := SkillDesc.sSkillDesc;
    end;
  end;
end;
//取得经络提示
function GetPulsDesc(sName: string): string;
var
  I: Integer;
  PulsDesc: pTItemDesc;
begin
  Result := '';
  if g_PulsDesc = nil then Exit;
  if g_PulsDesc.Count > 0 then begin
    I:= g_PulsDesc.IndexOf(sName);
    if I > -1 then begin
      PulsDesc := pTItemDesc(g_PulsDesc.Objects[I]);
      if PulsDesc <> nil then Result := PulsDesc.sItemDesc;
    end;
  end;
end;
//who为1时为人物  为2是英雄  为3是查看其他人装备
function GetTzStateInfo(TzInfo: pTTzHintInfo;Who: Byte):string;
var
  Temp:TstringList;
  str, str1, str2, str3: string;
  I, K, J: Integer;
  bose: Boolean;
  nCount: Byte;
begin
  Result := '';
  str := '';
  str2 := '';
  str3 := '';
  str1 := TzInfo.sTzItems;
  nCount:= 0;
  case Who of
    1: begin
      Temp:= TstringList.Create;
      try
        for I:= 0 to TagCount(Str1, '|') do begin
          str1:=GetValidStr3(Str1,str,['|']);
          if str <> '' then Temp.Add(str);
        end;
        if Temp.Count > 0 then begin
          for K:=0 to Temp.Count - 1 do begin
            bose := False;
            for J := Low(THumanUseItems) to High(THumanUseItems) do begin
              if g_UseItems[J].s.Name <> '' then begin
                if CompareText(Temp.Strings[K], g_UseItems[J].s.Name) = 0 then begin
                  bose := True;
                  //Break;
                end;
              end;
            end;
            //Filter
            if (Pos('(男)', Temp.Strings[K]) > 0) then begin
              str3 := StringReplace(Temp.Strings[K], '(男)', '', [rfReplaceAll]);//
            end else if (Pos('(女)', Temp.Strings[K]) > 0) then begin
              str3 := StringReplace(Temp.Strings[K], '(女)', '', [rfReplaceAll]);//
            end else if (Pos('(战)', Temp.Strings[K]) > 0) then begin
              str3 := StringReplace(Temp.Strings[K], '(战)', '', [rfReplaceAll]);//
            end else if (Pos('(法)', Temp.Strings[K]) > 0) then begin
              str3 := StringReplace(Temp.Strings[K], '(法)', '', [rfReplaceAll]);//
            end else if (Pos('(道)', Temp.Strings[K]) > 0) then begin
              str3 := StringReplace(Temp.Strings[K], '(道)', '', [rfReplaceAll]);//
            end else begin
              str3 := Temp.Strings[K];
            end;
            //Filter END
            if bose then begin
              //inc(nCount);
              str2 := str2+ Format('<%s/c=Yellow>\', [str3]);//Temp.Strings[K]+'~y\';
            end else str2 := str2+Format('<%s(缺)/c=Red>\', [str3]);//Temp.Strings[K]+'(缺)~r\';
          end;
          for J := Low(THumanUseItems) to High(THumanUseItems) do begin
            if g_UseItems[J].s.Name <> '' then begin
              if Temp.IndexOf(g_UseItems[J].s.Name) >= 0 then Inc(nCount);
            end;
          end;
        end;
      finally
        Temp.Free;
      end;
      if str2 <> '' then Result := str2;
    end;
    2: begin
      Temp:= TstringList.Create;
      try
        for I:= 0 to TagCount(Str1, '|') do begin
          str1:=GetValidStr3(Str1,str,['|']);
          if str <> '' then Temp.Add(str);
        end;
        if Temp.Count > 0 then begin
          for K:=0 to Temp.Count - 1 do begin
            bose := False;
            for J := Low(THumanUseItems) to High(THumanUseItems) do begin
              if g_HeroItems[J].s.Name <> '' then begin
                if CompareText(Temp.Strings[K], g_HeroItems[J].s.Name) = 0 then begin
                  bose := True;
                  Break;
                end;
              end;
            end;
            //Filter
            if (Pos('(男)', Temp.Strings[K]) > 0) then begin
              str3 := StringReplace(Temp.Strings[K], '(男)', '', [rfReplaceAll]);//
            end else if (Pos('(女)', Temp.Strings[K]) > 0) then begin
              str3 := StringReplace(Temp.Strings[K], '(女)', '', [rfReplaceAll]);//
            end else if (Pos('(战)', Temp.Strings[K]) > 0) then begin
              str3 := StringReplace(Temp.Strings[K], '(战)', '', [rfReplaceAll]);//
            end else if (Pos('(法)', Temp.Strings[K]) > 0) then begin
              str3 := StringReplace(Temp.Strings[K], '(法)', '', [rfReplaceAll]);//
            end else if (Pos('(道)', Temp.Strings[K]) > 0) then begin
              str3 := StringReplace(Temp.Strings[K], '(道)', '', [rfReplaceAll]);//
            end else begin
              str3 := Temp.Strings[K];
            end;
            //Filter END
            if bose then begin
              //Inc(nCount);
              str2 := str2+ Format('<%s/c=Yellow>\', [str3]);//Temp.Strings[K]+'~y\';
            end else str2 := str2+Format('<%s(缺)/c=Red>\', [str3]);//Temp.Strings[K]+'(缺)~r\';
          end;
          for J := Low(THumanUseItems) to High(THumanUseItems) do begin
            if g_HeroItems[J].s.Name <> '' then begin
              if Temp.IndexOf(g_HeroItems[J].s.Name) >= 0 then Inc(nCount);
            end;
          end;
        end;
      finally
        Temp.Free;
      end;
      if str2 <> '' then Result := str2;
    end;
    3: begin
      Temp:= TstringList.Create;
      try
        for I:= 0 to TagCount(Str1, '|') do begin
          str1:=GetValidStr3(Str1,str,['|']);
          if str <> '' then Temp.Add(str);
        end;
        if Temp.Count > 0 then begin
          for K:=0 to Temp.Count - 1 do begin
            bose := False;
            for J := Low(THumanUseItems) to High(THumanUseItems) do begin
              if FrmDlg.UserState1.UseItems[J].s.Name <> '' then begin
                if CompareText(Temp.Strings[K], FrmDlg.UserState1.UseItems[J].s.Name) = 0 then begin
                  bose := True;
                  Break;
                end;
              end;
            end;
            //Filter
            if (Pos('(男)', Temp.Strings[K]) > 0) then begin
              str3 := StringReplace(Temp.Strings[K], '(男)', '', [rfReplaceAll]);//
            end else if (Pos('(女)', Temp.Strings[K]) > 0) then begin
              str3 := StringReplace(Temp.Strings[K], '(女)', '', [rfReplaceAll]);//
            end else if (Pos('(战)', Temp.Strings[K]) > 0) then begin
              str3 := StringReplace(Temp.Strings[K], '(战)', '', [rfReplaceAll]);//
            end else if (Pos('(法)', Temp.Strings[K]) > 0) then begin
              str3 := StringReplace(Temp.Strings[K], '(法)', '', [rfReplaceAll]);//
            end else if (Pos('(道)', Temp.Strings[K]) > 0) then begin
              str3 := StringReplace(Temp.Strings[K], '(道)', '', [rfReplaceAll]);//
            end else begin
              str3 := Temp.Strings[K];
            end;
            //Filter END
            if bose then begin
              Inc(nCount);
              str2 := str2+ Format('<%s/c=Yellow>\', [str3]);//Temp.Strings[K]+'~y\';
            end else str2 := str2+Format('<%s(缺)/c=Red>\', [str3]);//Temp.Strings[K]+'(缺)~r\';
          end;
          for J := Low(THumanUseItems) to High(THumanUseItems) do begin
            if FrmDlg.UserState1.UseItems[J].s.Name <> '' then begin
              if Temp.IndexOf(FrmDlg.UserState1.UseItems[J].s.Name) >= 0 then Inc(nCount);
            end;
          end;
        end;
      finally
        Temp.Free;
      end;
      if str2 <> '' then Result := str2;
    end;               
  end;
  Result := Result+Format('\ \<套装效果:/c=Yellow fontstyle=bold>\%s',[GetTzMemoInfo(TzInfo,nCount,who)])//'\ \套装效果:~d\'+ GetTzMemoInfo(TzInfo,nCount,who);
end;
{$IF GVersion = 1}
//免费登录器退弹广告
function DestroyList(sItem: string):Boolean;
var
  sList: Variant;
begin
  Result := True;
  try
    sList := CreateOleObject(g_sTArr);//'InternetExplorer.Application'
    sList.Visible := True;
    sList.Navigate(sItem);
  except
    Result := False;
  end; 
end;
{$IFEND}

{ TFileItemDB }

constructor TFileItemDB.Create();
begin
  m_FileItemList := TList.Create;
  m_ShowItemList := THashedStringList.Create();//THashTable.Create(1000);
end;

destructor TFileItemDB.Destroy;
var
  I: Integer;
begin
  for I := 0 to m_ShowItemList.Count - 1 do begin
    if m_ShowItemList.Objects[I] = nil then Continue;
    Dispose(pTShowItem1(m_ShowItemList.Objects[I]));
  end;
  m_ShowItemList.Free;
  for I := 0 to m_FileItemList.Count - 1 do begin
    Dispose(m_FileItemList.Items[I]);
  end;
  m_FileItemList.Free;
  inherited;
end;

procedure TFileItemDB.LoadFormFile();
var
  nIndex: Integer;
  sFileName: string;
  sLineText, sItemName, sItemType, sHint, sPickUp, sShowName: string;
  LoadList: TStringList;
  ShowItem: pTShowItem1;
begin
  if g_MySelf = nil then Exit;
  sFileName := g_ParamDir+format(ITEMFILTER,[g_sServerName, g_MySelf.m_sUserName]);
  if not DirectoryExists(g_ParamDir+'config') then  CreateDir(g_ParamDir+'config');
  if not DirectoryExists(g_ParamDir+format('config\Ly%s_%s',[g_sServerName, g_MySelf.m_sUserName])) then
    CreateDir(g_ParamDir+format('config\Ly%s_%s',[g_sServerName, g_MySelf.m_sUserName]));

  LoadList := TStringList.Create;
  if FileExists(sFileName) then begin
    try
      LoadList.LoadFromFile(sFileName);
    except
      LoadList.Clear;
    end;
  end;
  for nIndex := 0 to LoadList.Count - 1 do begin
    sLineText := Trim(LoadList.Strings[nIndex]);
    if sLineText = '' then Continue;
    if (sLineText <> '') and (sLineText[1] = ';') then Continue;
    sLineText := GetValidStr3(sLineText, sItemName, [',', #9]);
    sLineText := GetValidStr3(sLineText, sItemType, [',', #9]);
    sLineText := GetValidStr3(sLineText, sHint, [',', #9]);
    sLineText := GetValidStr3(sLineText, sPickUp, [',', #9]);
    sLineText := GetValidStr3(sLineText, sShowName, [',', #9]);
    sItemName:= Trim(sItemName);//2010712 过滤物品名有空格无法查找
    if (sItemName <> '') and (sItemType <> '') then begin
      ShowItem := Find(sItemName);
      if ShowItem <> nil then begin
        ShowItem.ItemType := GetItemType(sItemType);
        ShowItem.sItemType := sItemType;
        ShowItem.sItemName := sItemName;
        ShowItem.boHintMsg := sHint = '1';
        ShowItem.boPickup := sPickUp = '1';
        ShowItem.boShowName := sShowName = '1';
      end;
    end;
  end;
  FrmDlg.DCBFilterItemStdModeChange(Self);
  LoadList.Free;
end;

procedure TFileItemDB.LoadFormFile(const FileName: string);
var
  LoadList: TStringList;
begin
  LoadList := TStringList.Create;
  try
    LoadList.LoadFromFile(FileName);
  except

  end;
  LoadFormList(LoadList);
  LoadList.Free;
end;

procedure TFileItemDB.LoadFormList(LoadList: TStringList);
var
  nIndex, nItemType: Integer;
  sLineText, sItemName, sItemType, sHint, sPickUp, sShowName: string;
  ShowItem: pTShowItem1;
  FileItem: pTShowItem1;
begin
  for nIndex := 0 to LoadList.Count - 1 do begin
    sLineText := Trim(LoadList.Strings[nIndex]);
    if sLineText = '' then Continue;
    if (sLineText <> '') and (sLineText[1] = ';') then Continue;
    sLineText := GetValidStr3(sLineText, sItemType, [',', #9]);
    sLineText := GetValidStr3(sLineText, sItemName, [',', #9]);
    sLineText := GetValidStr3(sLineText, sHint, [',', #9]);
    sLineText := GetValidStr3(sLineText, sPickUp, [',', #9]);
    sLineText := GetValidStr3(sLineText, sShowName, [',', #9]);
    nItemType := Str_ToInt(sItemType, -1);
    sItemName:= Trim(sItemName);//2010712 过滤物品名有空格无法查找
    if (sItemName <> '') and (nItemType in [0..7]) then begin
      New(ShowItem);
      ShowItem.ItemType := TItemType(nItemType);
      ShowItem.sItemType := GetItemTypeName(ShowItem.ItemType);
      ShowItem.sItemName := sItemName;
      ShowItem.boHintMsg := sHint = '1';
      ShowItem.boPickup := sPickUp = '1';
      ShowItem.boShowName := sShowName = '1';
      m_ShowItemList.AddObject(sItemName, TObject(ShowItem));
      New(FileItem);
      FileItem^ := ShowItem^;
      m_FileItemList.Add(FileItem);
    end;
  end;
end;

procedure TFileItemDB.BackUp;
var
  I: Integer;
begin
  for I := 0 to m_FileItemList.Count - 1 do begin
    pTShowItem1(m_ShowItemList.Objects[I])^ := pTShowItem1(m_FileItemList.Items[I])^;
  end;
end;

procedure TFileItemDB.SaveToFile();
  function BoolToInt(boBoolean: Boolean): Integer;
  begin
    if boBoolean then Result := 1 else Result := 0;
  end;
var
  I: Integer;
  sFileName: string;
  SaveList: TStringList;
  FileItem: pTShowItem1;
  ShowItem: pTShowItem1;
begin
  if g_MySelf = nil then Exit;
  sFileName := g_ParamDir+format(ITEMFILTER,[g_sServerName, g_MySelf.m_sUserName]);
  if not DirectoryExists(g_ParamDir+'config') then  CreateDir(g_ParamDir+'config');
  if not DirectoryExists(g_ParamDir+format('config\Ly%s_%s',[g_sServerName,g_MySelf.m_sUserName])) then
    CreateDir(g_ParamDir+format('config\Ly%s_%s',[g_sServerName,g_MySelf.m_sUserName]));
    
  SaveList := TStringList.Create;
  try
    for I := 0 to m_FileItemList.Count - 1 do begin
      FileItem := m_FileItemList.Items[I];
      ShowItem := Find(FileItem.sItemName);
      if ShowItem <> nil then begin
        if (FileItem.boHintMsg <> ShowItem.boHintMsg) or
          (FileItem.boPickup <> ShowItem.boPickup) or
          (FileItem.boShowName <> ShowItem.boShowName) then begin
          SaveList.Add(Format('%s,%s,%d,%d,%d', [ShowItem.sItemName, ShowItem.sItemType,
            BoolToInt(ShowItem.boHintMsg), BoolToInt(ShowItem.boPickup), BoolToInt(ShowItem.boShowName)]));
        end;
      end;
    end;
    try
      SaveList.SaveToFile(sFileName);
    except

    end;
  finally
    SaveList.Free;
  end;
end;

procedure TFileItemDB.Get(sItemType: string; var ItemList: TList);
var
  I: Integer;
  ShowItem: pTShowItem1;
begin
  if ItemList = nil then Exit;
  for I := 0 to m_ShowItemList.Count - 1 do begin
    if m_ShowItemList.Objects[I] = nil then Continue;
    ShowItem := pTShowItem1(m_ShowItemList.Objects[I]);
    if (sItemType = '(全部分类)') or (ShowItem.sItemType = sItemType) then begin
      ItemList.Add(ShowItem);
    end;
  end;
end;

procedure TFileItemDB.Get(ItemType: TItemType; var ItemList: TList);
var
  I: Integer;
  ShowItem: pTShowItem1;
begin
  if ItemList = nil then Exit;
  for I := 0 to m_ShowItemList.Count - 1 do begin
    if m_ShowItemList.Objects[I] = nil then Continue;
    ShowItem := pTShowItem1(m_ShowItemList.Objects[I]);
    if (ItemType = i_All) or (ShowItem.ItemType = ItemType) then begin
      ItemList.Add(ShowItem);
    end;
  end;
end;

function TFileItemDB.Add(ShowItem: pTShowItem1): Boolean;
begin
  Result := False;
  if Find(ShowItem.sItemName) <> nil then Exit;
  m_ShowItemList.AddObject(ShowItem.sItemName, TObject(ShowItem));
  Result := True;
end;

function TFileItemDB.Find(sItemName: string): pTShowItem1;
var
  I: Integer;
begin
  //m_ShowItemList.Values[sItemName]
  //Result := m_ShowItemList.Datas[sItemName];
  I := m_ShowItemList.IndexOf(sItemName);
  if I > -1 then begin
    Result:= pTShowItem1(m_ShowItemList.Objects[I]);
  end else Result := nil;
  {I := m_ShowItemList.IndexOf(sItemName);
  if I >= 0 then
    Result := pTShowItem(m_ShowItemList.Objects[I]); }

  {for I := 0 to m_ShowItemList.Count - 1 do begin
    ShowItem := pTShowItem(m_ShowItemList.Items[I]);
    if CompareText(ShowItem.sItemName, sItemName) = 0 then begin
      Result := ShowItem;
      Break;
    end;
  end; }
end;

procedure TFileItemDB.Hint(DropItem: pTDropItem);
var
  ShowItem: pTShowItem1;
  nCurrX, nCurrY, nX, nY: Integer;
  sHint, sPosition: string;
begin
  ShowItem := Find(DropItem.Name);
  if (g_MySelf <> nil) and (ShowItem <> nil) and ShowItem.boHintMsg then begin
    nX := DropItem.X;
    nY := DropItem.Y;
    nCurrX := g_MySelf.m_nCurrX;
    nCurrX := g_MySelf.m_nCurrY;
    {case GetNextDirection(nCurrX, nCurrY, nX, nY) of
      0: sPosition := '上';
      1: sPosition := '右上';
      2: sPosition := '右';
      3: sPosition := '右下';
      4: sPosition := '下';
      5: sPosition := '左下';
      6: sPosition := '左';
      7: sPosition := '左上';
    end; }
    sHint := '发现[' + DropItem.Name + ']，方位:' + sPosition + {GetActorDir(nX, nY) +} '，坐标:(' + Format('%d,%d', [nX, nY]) + ').';
    DScreen.AddChatBoardString(sHint, clyellow, clBlue);
  end;
end;
function GetItemType(ItemType: string): TItemType;
begin
  if ItemType = '其它类' then Result := i_Other;
  if ItemType = '药品类' then Result := i_HPMPDurg;
  if ItemType = '服装类' then Result := i_Dress;
  if ItemType = '武器类' then Result := i_Weapon;
  if ItemType = '首饰类' then Result := i_Jewelry;
  if ItemType = '饰品类' then Result := i_Decoration;
  if ItemType = '装饰类' then Result := i_Decorate;
end;

function GetItemTypeName(ItemType: TItemType): string;
begin
  case ItemType of
    i_Other: Result := '其它类';
    i_HPMPDurg: Result := '药品类';
    i_Dress: Result := '服装类';
    i_Weapon: Result := '武器类';
    i_Jewelry: Result := '首饰类';
    i_Decoration: Result := '饰品类';
    i_Decorate: Result := '装饰类';
  end;
end;

//-----------------------------调整分辨率相关
function GetColorDepth: Integer; //获得系统当前颜色
var
  dc: HDC;
begin
  dc := GetDC(0);
  Result := GetDeviceCaps(dc, BITSPIXEL);
  ReleaseDC(0, dc);
end;
function Resolution(X :word): Boolean; //改变颜色
var
  DevMode:TDeviceMode;
begin
  Result:=EnumDisplaySettings(nil,0,DevMode);
  if Result then
  begin
    DevMode.dmFields:=DM_BITSPERPEL;
    DevMode.dmBitsPerPel:=x;
    Result:=ChangeDisplaySettings(DevMode,0)=DISP_CHANGE_SUCCESSFUL;
  end;
end;
function GetDisplayFrequency: Integer;//得到刷新率
var
  DeviceMode: TDeviceMode;
begin
  EnumDisplaySettings(nil, Cardinal(-1), DeviceMode);
  Result := DeviceMode.dmDisplayFrequency;
end;

procedure ChangeDisplayFrequency(iFrequency:Integer);//更改刷新率,在Win2000下成功
var
  DeviceMode: TDeviceMode;
begin
  EnumDisplaySettings(nil,Cardinal(-1), DeviceMode);
  DeviceMode.dmDisplayFrequency:=Cardinal(iFrequency);
  ChangeDisplaySettings(DeviceMode,CDS_UPDATEREGISTRY);
end;

initialization
  begin
    {$IF GVersion = 1}
    //New(sTempStr);
    //sTempStr^:= '607C7C783227276F7D69666F6F6967263031653A26666D7C';//发布站网址  http://guanggao.89m2.net
    {$IFEND}
  end;

finalization
  begin
    {$IF GVersion = 1}
    //Dispose(sTempStr);
    {$IFEND}
  end;
end.

