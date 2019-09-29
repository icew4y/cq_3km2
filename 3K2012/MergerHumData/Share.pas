unit Share;

interface

///////////////////////英雄版数据库结构定义////////////////////////////////////////////
resourcestring
  sDBHeaderDesc = '3K网络数据库文件 2011/03/11';

const
  g_sProductName = '868217CBFB2539C4CA02C63660C482A3221DECC20028A7E50D7F5D73905DAA27CC418BAACE95E89D'; //版权所有 (C) 2009-2010 3K科技
  g_sURL1 = 'C5DB86D6E7E9CDE140574B5A981AB175F035B21DBC70456C'; //Http://www.3KM2.com
  nDBVersion = 20110311;//DB版本号

  MAPNAMELEN = 16;//地图名长度
  ACTORNAMELEN = 14;//名字长度
  MAX_STATUS_ATTRIBUTE = 12;//状态属性个数

  SAVEITEMNAME      = 'UserData.dat';//寄售物品文件
  USERDATADIR       = 'UserData\';
type
//id.db文件头
 TIdHeader = packed record //Size 124
    sDesc: string[34]; //0x00
    n23: Integer; //0x23
    n28: Integer; //0x27
    n2C: Integer; //0x2B
    n30: Integer; //0x2F
    n34: Integer; //0x33
    n38: Integer; //0x37
    n3C: Integer; //0x3B
    n40: Integer; //0x3F
    n44: Integer; //0x43
    n48: Integer; //0x47
    n4B: Byte; //0x4B
    n4C: Integer; //0x4C
    n50: Integer; //0x50
    n54: Integer; //0x54
    n58: Integer; //0x58
    nLastIndex: Integer; //0x5C
    dLastDate: TDateTime; //0x60
    nIDCount: Integer; //0x68
    n6C: Integer; //0x6C
    nDeletedIdx: Integer; //0x70
    dUpdateDate: TDateTime; //0x74
  end;

  //ID帐号索引定义
  TIdxRecord = packed record
    sName: string[11];
    nIndex: Integer;
  end;

  //ID帐号记录头
  TIDRecordHeader = packed record
    boDeleted:boolean;
    bt1: Byte;
    bt2: Byte;
    bt3: Byte;
    CreateDate: TDateTime;
    UpdateDate: TDateTime;
    sAccount: string[11];
  end;

 //ID帐号记录用户信息
  TUserEntry = packed record
    sAccount: string[10];//账号
    sPassword: string[10];//密码
    sUserName: string[20];//用户名称
    sSSNo: string[14];//身份证
    sPhone: string[14];//电话
    sQuiz: string[20];//问题1
    sAnswer: string[12];//答案1
    sEMail: string[40];//邮箱
  end;

// ID帐号记录用户地址等
  TUserEntryAdd = packed record
    sQuiz2: string[20];//问题2
    sAnswer2: string[12];//答案2
    sBirthDay: string[10];//生日
    sMobilePhone: string[13];//移动电话
    sMemo: string[20];//备注一
    sMemo2: string[20];//备注二
  end;

 //ID帐号记录定义
  TAccountDBRecord = packed record
    Header: TIDRecordHeader;
    UserEntry: TUserEntry;
    UserEntryAdd: TUserEntryAdd;
    nErrorCount: Integer;
    dwActionTick: LongWord;
    N: array[0..38] of Byte;
  end;

/////////////////////////////////////////////////////////////////////
//人物库记录头(Hum.db Mir.db共用)
  TRecordHeader = packed record //Size 28
    boDeleted: Boolean; //是否删除
    nSelectID: Byte;   //ID
    boIsHero: Boolean; //是否英雄
    bt2: Byte;
    dCreateDate: TDateTime; //最后登录时间
    sName: string[15]; //角色名称   28
  end;
  
  ///hum.db文件记录
  THumInfo = packed record //Size 72  角色数据
    Header: TRecordHeader;
    sChrName: string[14]; //0x14  //角色名称   44
    sAccount: string[10]; //账号
    boDeleted: Boolean; //是否删除
    bt1: Byte; //未使用
    dModDate: TDateTime;//操作日期
    btCount: Byte; //操作计次
    boSelected: Boolean; //是否是选择的人物
    n6: array[0..5] of Byte;//未使用
  end;
/////////////////////////////////////////////////////////////////////
//Hum.DB, Mir.db文件头
  TDBHeader = packed record //Size 124
    sDesc: string[$23]; //0x00    36
    n24: Integer; //0x24
    n28: Integer; //0x28
    n2C: Integer; //0x2C
    n30: Integer; //0x30
    n34: Integer; //0x34
    n38: Integer; //0x38
    n3C: Integer; //0x3C
    n40: Integer; //0x40
    n44: Integer; //0x44
    n48: Integer; //0x48
    n4C: Integer; //0x4C
    n50: Integer; //0x50
    n54: Integer; //0x54
    n58: Integer; //0x58
    nLastIndex: Integer; //最后的索引
    dLastDate: TDateTime; //最后退登日期
    nHumCount: Integer; //角色数量
    n6C: Integer; //0x6C
    n70: Integer; //DB版本号
    dUpdateDate: TDateTime; //更新日期
  end;

  //人物库索引
  TdbxRecord = record
    sChrName: string[15];
    nIndex: Integer;
  end;

    //属性点分配
  TNakedAbility = packed record //Size 20 OK
    DC: Word;
    MC: Word;
    SC: Word;
    AC: Word;
    MAC: Word;
    HP: Word;
    MP: Word;
    Hit: Word;
    Speed: Word;
    X2: Word;
  end;

   //人物属性
  TOAbility = packed record//人物数据使用  size 40 OK
    Level: Word;//等级
    AC: Word;//HP 上限 20091026
    MAC: Word;//MP 上限 20091026
    DC: Word;//MaxHP 上限 20091026
    MC: Word;//MaxMP 上限 20091026
    SC: Word;//LoByte()-自动修炼修炼场所 HiByte()-自动修炼修炼强度(主体)
    HP: Word;//-AC,HP下限
    MP: Word;//-MAC,Mp下限
    MaxHP: Word;//-DC,MaxHP下限
    MaxMP: Word;//-MC,MaxMP下限
    NG: Word;//当前内力值
    MaxNG: Word;//内力值上限
    Exp: Int64;//当前经验
    MaxExp: Int64;//升级经验
    Weight: Word;
    MaxWeight: Word;//最大重量
    WearWeight: Byte;
    MaxWearWeight: Byte;//最大负重
    HandWeight: Byte;
    MaxHandWeight: Byte;//腕力
  end;

  TUserItem = packed record//物品
    MakeIndex: Integer;
    wIndex: Word; //物品id
    Dura: Word; //当前持久值
    DuraMax: Word; //最大持久值
    btValue: array[0..20] of Byte;//附加属性:8-神秘装备 9-(升级次数)装备等级 12-发光(1为发光,0不发光,2聚灵珠不能聚集 武器,衣服,头盔无效),13-自定义名称,14-禁止扔,15-禁止交易,16-禁止存,17-禁止修,18-禁止出售,19-禁止爆出 20-吸伤(聚灵珠,1-开始聚经验,2-聚结束) 11-武器类暴击等级 8-神秘物品 10-武器升级设置(1-破碎 10-12增加DC, 20-22增加MC，30-32增加SC)
    btUnKnowValue: array[0..9] of Byte;//0-是否可鉴定(1-可鉴定 2-一鉴 3-二鉴 4-三鉴) 1-存在多少神性属性(0-无 1-1个属性 2-2个属性 3-3个属性 4-4个属性) 未知属性(鉴定使用)

    AddValue: array[0..2] of Byte;//0-1限时物品 2绑定期
    MaxDate: TDateTime;//最大使用日期 当AddValue[0]＝1时，到时间删除物品即限时物品
  end ;

  THumMagic = record //人物技能(DB)
    wMagIdx: Word;//技能ID
    btLevel: Byte;//等级
    btKey: Byte;//技能快捷键  英雄:0-技能开,1--技能关
    nTranPoint: LongWord; //当前修练值
    btLevelEx: Byte;//强化等级  20110812 扩展********
  end;
  THumNGMagic = record //内功技能(DB)
    wMagIdx: Word;//技能ID
    btLevel: Byte;//等级
    btKey: Byte;//技能快捷键  英雄:0-技能开,1--技能关
    nTranPoint: LongWord; //当前修练值
  end;

  THumTitle = packed record//人物称号结构(保存数据)
    ApplyDate: TDateTime;//申请时间
    MakeIndex: Integer;//称号制造ID
    wIndex: Word; //称号索引id
    boUseTitle: Boolean;//使用此称号
    wDura: Word;//千里传音次数(水晶之星)
    wMaxDura: Word;
    sChrName: string[ACTORNAMELEN];//任命者(主宰龙卫，护花使者) 上线检查对应角色是否在线，同配偶处理
  end;

  THumTitles = array[0..7] of THumTitle;//人物称号 20110124***增加****
  TUnKnow1 = array[0..5] of Word;//预留6个Word变量 20110124***增加****
  
  TUnKnow = array[0..44] of Byte;
  TQuestFlag = array[0..127] of Byte;
  TStatusTime = array[0..MAX_STATUS_ATTRIBUTE - 1] of Word;
  THumItems = array[0..8] of TUserItem;//9格装备
  THumAddItems = array[9..14] of TUserItem;//新增4格装备 扩展支持斗笠
  TBagItems = array[0..45] of TUserItem;//包裹物品
  TStorageItems = array[0..45] of TUserItem;
  THumMagics = array[0..{29}34] of THumMagic;//人物技能 20110812 扩展********
  THumNGMagics = array[0..29] of THumNGMagic;//内功技能
  
 //人物库人记录物状态定义
  THumData = packed record {人物数据类 Size = 5757 预留N个变量 20100804}
    sChrName: string[ACTORNAMELEN];//姓名
    sCurMap: string[MAPNAMELEN];//地图
    wCurX: Word; //坐标X
    wCurY: Word; //坐标Y
    btDir: Byte; //方向
    btHair: Byte;//头发
    btSex: Byte; //性别(0-男 1-女)
    btJob: Byte;//职业 0-战 1-法 2-道 3-刺客
    nGold: Integer;//金币数(人物) 英雄怒气值(英雄)
    Abil: TOAbility;//+40 人物其它属性
    wStatusTimeArr: TStatusTime; //+24 人物状态属性值，一般是持续多少秒
    sHomeMap: string[MAPNAMELEN];//Home 家(主体),用于是否第一次召唤(英雄)
    wHomeX: Word;//Home X
    wHomeY: Word;//Home Y
    sDearName: string[ACTORNAMELEN]; //别名(配偶)
    sMasterName: string[ACTORNAMELEN];//人物-师傅名字 英雄-主体名字
    boMaster: Boolean;//是否有徒弟
    btCreditPoint: Integer;//声望点
    btDivorce: Byte; //(主体)喝酒时间,计算长时间没使用喝酒(btDivorce与UnKnow[25]组合成word)
    btMarryCount: Byte; //结婚次数
    sStoragePwd: string[7];//仓库密码
    btReLevel: Byte;//转生等级
    btUnKnow2: array[0..2] of Byte;//0-是否开通元宝寄售(1-开通) 1-是否寄存英雄(1-存有英雄) 2-饮酒时酒的品质
    BonusAbil: TNakedAbility; //+20 分配的属性值
    nBonusPoint: Integer;//奖励点
    nGameGold: Integer;//游戏币(元宝)
    nGameDiaMond: Integer;//金刚石
    nGameGird: Integer;//灵符
    nGamePoint: Integer;//游戏点
    btGameGlory: Integer; //荣誉
    nPayMentPoint: Integer; //充值点
    nLoyal: LongWord;//忠诚度(英雄) 主将累计经验(主体)
    nPKPOINT: Integer;//PK点数
    btAllowGroup: Byte;//允许组队
    btF9: Byte;
    btAttatckMode: Byte;//攻击模式
    btIncHealth: Byte;//增加健康数
    btIncSpell: Byte;//增加攻击点
    btIncHealing: Byte;//增加治愈点
    btFightZoneDieCount: Byte;//在行会占争地图中死亡次数
    sAccount: string[10];//登录帐号
    btEF: Byte;//英雄类型 0-白日门英雄 1-卧龙英雄 2-主将英雄 3-副将英雄
    boLockLogon: Boolean;//是否锁定登陆
    wContribution: Word;//贡献值(主体) 喝酒时间,计算长时间没使用喝酒(英雄)
    nHungerStatus: Integer;//饥饿状态(主体)
    boAllowGuildReCall: Boolean;//是否允许行会合一
    wGroupRcallTime: Word; //队传送时间
    dBodyLuck: Double; //幸运度  8
    boAllowGroupReCall: Boolean; //是否允许天地合一
    nEXPRATE: Integer; //经验倍数
    nExpTime: LongWord; //经验倍数时间
    btLastOutStatus: Byte; //退出状态 1为死亡退出
    wMasterCount: Word; //出师徒弟数
    boHasHero: Boolean; //是否有白日门英雄(主体使用)
    boIsHero: Boolean; //是否是英雄
    btStatus: Byte; //英雄状态(英雄) 所选副将职业(主体)
    sHeroChrName: string[ACTORNAMELEN];//英雄名称, size=15
    sHeroChrName1: string[ACTORNAMELEN];//卧龙英雄名(size=15) 20110130
    UnKnow: TUnKnow;//44: 0-3酿酒使用 4-饮酒时的度数 5-魔法盾等级 6-是否学过内功
                    //7-内功等级(1) 8-使用物品改变说话的颜色  9..16经络数据 17..20命令增加的永久属性
                    //21是否学过连击技能 22..24连击键设置(0-不处理 1-显示"?") 25-英雄开通经络(英雄) (主体)喝酒时间
                    //26-是否学过护体神盾 27-副将英雄是否自动修炼(主体) 28-第四格连击键设置(0-不处理 1-显示"?")
                    //29-第四连击是否可用 30-幸运值(制造神秘卷轴) 31-精力值 32-奇经(0-未学习 1-神冲 2-夹脊 3-二百 4-八风 5-涌泉)
                    //33-内功等级(2) 34-死亡次数(称号使用) 35-是否突破99级斗转 36-龙卫心法类型
    QuestFlag: TQuestFlag; //脚本变量
    HumItems: THumItems; //9格装备 衣服  武器  蜡烛 头盔 项链 手镯 手镯 戒指 戒指
    BagItems: TBagItems; //包裹装备
    HumMagics: THumMagics;//普通魔法
    StorageItems: TStorageItems;//仓库物品
    HumAddItems: THumAddItems;//新增4格 护身符 腰带 鞋子 宝石
    n_WinExp: LongWord;//累计经验
    n_UsesItemTick: Integer;//聚灵珠聚集时间
    nReserved: LongWord; //(人物)酿酒的时间,即还有多长时间可以取回酒 (英雄)经络修炼经验
    nReserved1: Integer; //当前药力值
    nReserved2: Integer; //药力值上限
    nReserved3: Integer; //使用药酒时间,计算长时间没使用药酒
    n_Reserved: Word;   //当前酒量值
    n_Reserved1: Word;  //酒量上限
    n_Reserved2: Word;  //当前醉酒度
    n_Reserved3: Word;  //药力值等级
    boReserved: Boolean; //是否请过酒 T-请过酒(主体)
    boReserved1: Boolean;//是否有卧龙英雄(主体)
    boReserved2: Boolean;//是否酿酒 T-正在酿酒 (主体)
    boReserved3: Boolean;//人是否喝酒醉了(主体)
    m_GiveDate: Integer;//人物领取行会酒泉日期(主体)
    MaxExp68: LongWord;//自动修炼累计时长(主体)
    nExpSkill69: Integer;//内功当前经验
    HumNGMagics: THumNGMagics;//内功技能
    HumTitles: THumTitles;//称号数据  20110130
    m_nReserved1: Word;//吸伤属性
    m_nReserved2: Word;//主将英雄等级(主体)
    m_nReserved3: Word;//副将英雄等级(主体)
    m_nReserved4: LongWord;//真视秘籍使用时间
    m_nReserved5: LongWord;//使用物品(玄绿,玄紫,玄褐)改变说话颜色的使用时间(主体)
    m_nReserved6: LongWord;//主将累计内功经验(主体)
    m_nReserved7: Word;//主将英雄内功等级(主体)
    m_nReserved8: Word;//副将英雄内功等级(主体)
    Proficiency: Word;//熟练度(制造神秘卷轴)
    Reserved2: Word;//人物排名(主体)
    Reserved3: Word;//当前精元值(主体)
    Reserved4: Word;//当前斗转值
    Exp68: LongWord;//人物初始精元值的日期
    sHeartName: String[12];//龙卫自定义心法名称 20110808
    SpiritMedia: TUserItem;//灵媒装备位
    UnKnow1: TUnKnow1;//预留6个Word变量  20110130
    Reserved5: LongWord;//游戏点清理日期
    Reserved6: LongWord;//预留变量2 20110812******
    Reserved7: LongWord;//预留变量3 20110812******
  end;
///人物库人物记录定义
  THumDataInfo = packed record //Size 5785 OK
    Header: TRecordHeader;
    Data: THumData;
  end;
//-------------------副将英雄数据结构HeroMir.db---------------------------------
  TNewHeroData = packed record {副将数据类 Size = 2425}
    sHeroChrName: string[ACTORNAMELEN];//英雄名称
    btJob: Byte;//职业 0-战 1-法 2-道 3-刺客
    nHP: Integer;//当前HP值
    nMP: Integer;//当前MP值
    HumItems: THumItems; //9格装备 衣服  武器  蜡烛 头盔 项链 手镯 手镯 戒指 戒指
    HumAddItems: THumAddItems;//新增4格 护身符 腰带 鞋子 宝石
    BagItems: TBagItems; //包裹装备
    HumMagics: THumMagics;//普通魔法
    HumNGMagics: THumNGMagics;//内功技能
  end;

  TNewHeroDataHeader = packed record
    boDeleted: Boolean; //是否删除
    dCreateDate: TDateTime; //最后登录时间
  end;

  TNewHeroDataInfo = packed record
    Header: TNewHeroDataHeader;
    Data: TNewHeroData;
  end;
//------------------------------------------------------------------------------
  TDealOffInfo = packed record //元宝寄售数据结构
    sDealCharName: string[ACTORNAMELEN];//寄售人 *
    sBuyCharName: string[ACTORNAMELEN];//购买人
    dSellDateTime: TDateTime;//寄售时间
    nSellGold: Integer;//交易的元宝数
    UseItems: array[0..9] of TUserItem;//物品
    N: Byte;//交易识标 0-正常 1-购买,但寄售人未得到元宝 2-交易结束(得到元宝) 3-购买人取消 4-正在操作中
  end;
  pTDealOffInfo = ^TDealOffInfo;

  TBigStorage = packed record //无限仓库数据结构
    boDelete: Boolean;
    sCharName: string[14];
    SaveDateTime: TDateTime;
    UseItems: TUserItem;
    nCount: Integer;
  end;
  pTBigStorage = ^TBigStorage;  

  TItemCount = Integer;

//寄售数据定义
 TPlacingHead=packed record
    dwDateTime:TDateTime;
    nCount:integer;    //20
    n1:integer;        //24
    n2:integer;        //28
    n3:integer;        //32
    n4:integer;        //36
    n5:integer;        //40
  end;

  TUserPlacing =packed  record
    Item      :TUserItem;
    nPrice    :Integer;
    nPicCls   :Boolean;
    nTime     :TDateTime;
    sName     :String[ActorNameLen];
    sItemName :String[ActorNameLen];
    boSell    :Boolean;
    nIdx      :Byte;
  end;
  pTUserPlacing = ^TUserPlacing;   

implementation

end.
