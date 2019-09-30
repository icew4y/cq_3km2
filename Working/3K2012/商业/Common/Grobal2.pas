unit Grobal2;//全局(服务器和客户端通用)消息,数据结构,函数等

interface                                                  

uses                                 
  Windows, Classes, JSocket{, Controls};
const
  HEROVERSION = 1; //1是英雄版
  MAXPATHLEN = 255;                                                     
  DIRPATHLEN = 80;
  MAPNAMELEN = 16;
  ACTORNAMELEN = 14;
  DEFBLOCKSIZE = 16;
  BUFFERSIZE = 10000; //缓冲定义
  DATA_BUFSIZE2 = 16348; //8192;
  DATA_BUFSIZE = 8192; //8192;
  GROUPMAX = 11;
  BAGGOLD = 5000000;
  BODYLUCKUNIT = 10;
  MAX_STATUS_ATTRIBUTE = 12;//20080626 修改

//传奇中人物只有8个方向,但是打符,锲蛾飞行,神鹰都有16方向
  DR_UP = 0;//正北
  DR_UPRIGHT = 1;//东北向
  DR_RIGHT = 2; //东
  DR_DOWNRIGHT = 3;//东南向
  DR_DOWN = 4;//南
  DR_DOWNLEFT = 5;//西南向
  DR_LEFT = 6;//西
  DR_UPLEFT = 7;//西北向

//装备项目
  U_DRESS = 0; //衣服
  U_WEAPON = 1; //武器
  U_RIGHTHAND = 2; //右手
  U_NECKLACE = 3; //项链
  U_HELMET = 4; //头盔
  U_ARMRINGL = 5; //左手手镯,符
  U_ARMRINGR = 6;//右手手镯
  U_RINGL = 7;  //左戒指
  U_RINGR = 8;//右戒指
  U_BUJUK = 9; //物品
  U_BELT = 10; //腰带
  U_BOOTS = 11; //鞋
  U_CHARM = 12; //宝石
  U_ZHULI = 13;//斗笠
  X_RepairFir = 20; //修补火龙之心

  POISON_DECHEALTH = 0;//中毒类型：绿毒
  POISON_DAMAGEARMOR = 1;//中毒类型：红毒
  POISON_LOCKSPELL = 2;//不能攻击
  POISON_DONTMOVE = 4;//不能移动
  POISON_STONE = 5; //中毒类型:麻痹

  STATE_STONE_MODE = 1;//被石化
  STATE_LOCKRUN = 3;//不能跑动(中蛛网) 20080811
  STATE_ProtectionDEFENCE = 7;//护体神盾 20080107
  STATE_TRANSPARENT = 8;//隐身
  STATE_DEFENCEUP = 9;//神圣战甲术  防御力
  STATE_MAGDEFENCEUP = 10;//幽灵盾  魔御力
  STATE_BUBBLEDEFENCEUP = 11;//魔法盾

  USERMODE_PLAYGAME = 1;
  USERMODE_LOGIN = 2;
  USERMODE_LOGOFF = 3;
  USERMODE_NOTICE = 4;

  RUNGATEMAX = 20;

  RUNGATECODE = $AA55AA55;

  OS_MOVINGOBJECT = 1;
  OS_ITEMOBJECT = 2;
  OS_EVENTOBJECT = 3;
  OS_GATEOBJECT = 4;
  OS_SWITCHOBJECT = 5;
  OS_MAPEVENT = 6;
  OS_DOOR = 7;
  OS_ROON = 8;

  RC_PLAYOBJECT = 0;//人物
  RC_PLAYMOSTER = 150; //人形怪物
  RC_HEROOBJECT = 66; //英雄
  RC_GUARD = 12; //大刀守卫 20080311
  RC_PEACENPC = 15;
  RC_ANIMAL = 50;
  RC_MONSTER = 80;
  RC_NPC = 10;
  RC_ARCHERGUARD = 112;//NPC 弓箭手


  RCC_USERHUMAN = RC_PLAYOBJECT;
  RCC_GUARD = RC_GUARD;
  RCC_MERCHANT = RC_ANIMAL;

  ISM_WHISPER = 1234;

  CM_QUERYCHR = 100;  //登录成功,客户端显出左右角色的那一瞬
  CM_NEWCHR = 101;      //创建角色
  CM_DELCHR = 102;      //删除角色
  CM_SELCHR = 103;      //选择角色
  CM_SELECTSERVER = 104;//服务器,注意不是选区,盛大一区往往有(至多8个??group.dat中是这么写的)不止一个的服务器
  CM_QUERYDELCHR = 105;//查询删除过的角色信息 20080706
  CM_RESDELCHR = 106;//恢复删除的角色 20080706
  CM_HARDWARECODE = 107;//客户端发送机器码给网关

  SM_RUSH = 6; //跑动中改变方向
  SM_RUSHKUNG = 7; //野蛮冲撞
  SM_FIREHIT = 8; //烈火
  SM_4FIREHIT = 58; //4级烈火 20080112
  SM_BACKSTEP = 9; //后退,野蛮效果? //半兽统领公箭手攻击玩家的后退??axemon.pas中procedure   TDualAxeOma.Run
  SM_TURN = 10; //转向
  SM_WALK = 11; //走
  SM_SITDOWN = 12;
  SM_RUN = 13; //跑
  SM_HIT = 14; //砍
  SM_HEAVYHIT = 15; //
  SM_BIGHIT = 16; //
  SM_SPELL = 17; //使用魔法
  SM_POWERHIT = 18;//攻杀
  SM_LONGHIT = 19; //刺杀
  SM_DIGUP = 20;//挖是一"起"一"坐",这里是挖动作的"起"
  SM_DIGDOWN = 21;//挖动作的"坐"
  SM_FLYAXE = 22;//飞斧,半兽统领的攻击方式?
  SM_LIGHTING = 23;//免蜡开关
  SM_WIDEHIT = 24; //半月
  SM_CRSHIT = 25; //抱月刀
  SM_TWINHIT = 26; //开天斩重击
  SM_QTWINHIT = 59; //开天斩轻击
  SM_CIDHIT = 57; //龙影剑法


  SM_ALIVE = 27; //复活??复活戒指
  SM_MOVEFAIL = 28; //移动失败,走动或跑动
  SM_HIDE = 29; //隐身?
  SM_DISAPPEAR = 30;//地上物品消失
  SM_STRUCK = 31; //受攻击
  SM_DEATH = 32; //正常死亡
  SM_SKELETON = 33; //尸体
  SM_NOWDEATH = 34; //秒杀?

  SM_ACTION_MIN = SM_RUSH;
  SM_ACTION_MAX = SM_WIDEHIT;
  SM_ACTION2_MIN = 65072;
  SM_ACTION2_MAX = 65073;

  SM_HEAR = 40;  //有人回你的话
  SM_FEATURECHANGED = 41;
  SM_USERNAME = 42;
  SM_WINEXP = 44;//获得经验
  SM_LEVELUP = 45; //升级,左上角出现墨绿的升级字样
  SM_DAYCHANGING = 46;//传奇界面右下角的太阳星星月亮

  SM_LOGON = 50;//logon
  SM_NEWMAP = 51; //新地图??
  SM_ABILITY = 52;//打开属性对话框,F11
  SM_HEALTHSPELLCHANGED = 53;//治愈术使你的体力增加
  SM_MAPDESCRIPTION = 54;//地图描述,行会战地图?攻城区域?安全区域?
  SM_SPELL2 = 117;

//对话消息
  SM_MOVEMESSAGE = 99;
  SM_SYSMESSAGE = 100; //系统消息,盛大一般红字,私服蓝字
  SM_GROUPMESSAGE = 101;//组内聊天!!
  SM_CRY = 102; //喊话
  SM_WHISPER = 103;//私聊
  SM_GUILDMESSAGE = 104;  //行会聊天!~

  SM_ADDITEM = 200;
  SM_BAGITEMS = 201;
  SM_DELITEM = 202;
  SM_UPDATEITEM = 203;
  SM_ADDMAGIC = 210;
  SM_SENDMYMAGIC = 211;
  SM_DELMAGIC = 212;

 //服务器端发送的命令 SM:server msg,服务端向客户端发送的消息

//登录、新帐号、新角色、查询角色等  
  SM_CERTIFICATION_FAIL = 501;
  SM_ID_NOTFOUND = 502;
  SM_PASSWD_FAIL = 503;//验证失败,"服务器验证失败,需要重新登录"??
  SM_NEWID_SUCCESS = 504;//创建新账号成功
  SM_NEWID_FAIL = 505; //..失败
  SM_CHGPASSWD_SUCCESS = 506; //修改密码成功
  SM_CHGPASSWD_FAIL = 507;  //修改密码失败
  SM_GETBACKPASSWD_SUCCESS = 508; //密码找回成功
  SM_GETBACKPASSWD_FAIL = 509; //密码找回失败

  SM_QUERYCHR = 520; //返回角色信息到客户端
  SM_NEWCHR_SUCCESS = 521; //新建角色成功
  SM_NEWCHR_FAIL = 522; //新建角色失败
  SM_DELCHR_SUCCESS = 523; //删除角色成功
  SM_DELCHR_FAIL = 524; //删除角色失败
  SM_STARTPLAY = 525; //开始进入游戏世界(点了健康游戏忠告后进入游戏画面)
  SM_STARTFAIL = 526; ////开始失败,玩传奇深有体会,有时选择角色,点健康游戏忠告后黑屏

  SM_QUERYCHR_FAIL = 527;//返回角色信息到客户端失败
  SM_OUTOFCONNECTION = 528; //超过最大连接数,强迫用户下线
  SM_PASSOK_SELECTSERVER = 529;  //密码验证完成且密码正确,开始选服
  SM_SELECTSERVER_OK = 530;  //选服成功
  SM_NEEDUPDATE_ACCOUNT = 531;//需要更新,注册后的ID会发生什么变化?私服中的普通ID经过充值??或者由普通ID变为会员ID,GM?
  SM_UPDATEID_SUCCESS = 532; //更新成功
  SM_UPDATEID_FAIL = 533;  //更新失败

  SM_QUERYDELCHR = 534;//返回删除过的角色 20080706
  SM_QUERYDELCHR_FAIL = 535;//返回删除过的角色失败 20080706
  SM_RESDELCHR_SUCCESS = 536;//恢复删除角色成功 20080706
  SM_RESDELCHR_FAIL = 537;//恢复删除角色失败 20080706
  SM_NOCANRESDELCHR = 538;//禁止恢复删除角色,即不可查看 200800706

  SM_DROPITEM_SUCCESS = 600;
  SM_DROPITEM_FAIL = 601;

  SM_ITEMSHOW = 610;
  SM_ITEMHIDE = 611;
  //  SM_DOOROPEN           = 612;
  SM_OPENDOOR_OK = 612; //通过过门点成功
  SM_OPENDOOR_LOCK = 613;//发现过门口是封锁的,以前盛大秘密通道去赤月的门要5分钟开一次
  SM_CLOSEDOOR = 614;//用户过门,门自行关闭
  SM_TAKEON_OK = 615;
  SM_TAKEON_FAIL = 616;
  SM_TAKEOFF_OK = 619;
  SM_TAKEOFF_FAIL = 620;
  SM_SENDUSEITEMS = 621;
  SM_WEIGHTCHANGED = 622;
  SM_CLEAROBJECTS = 633;
  SM_CHANGEMAP = 634; //地图改变,进入新地图
  SM_EAT_OK = 635;
  SM_EAT_FAIL = 636;
  SM_BUTCH = 637; //野蛮?
  SM_MAGICFIRE = 638; //地狱火,火墙??
  SM_MAGICFIRE_FAIL = 639;
  SM_MAGIC_LVEXP = 640;
  SM_DURACHANGE = 642;
  SM_MERCHANTSAY = 643;
  SM_MERCHANTDLGCLOSE = 644;
  SM_SENDGOODSLIST = 645;
  SM_SENDUSERSELL = 646;
  SM_SENDBUYPRICE = 647;
  SM_USERSELLITEM_OK = 648;
  SM_USERSELLITEM_FAIL = 649;
  SM_BUYITEM_SUCCESS = 650; //?
  SM_BUYITEM_FAIL = 651; //?
  SM_SENDDETAILGOODSLIST = 652;
  SM_GOLDCHANGED = 653;
  SM_CHANGELIGHT = 654; //负重改变
  SM_LAMPCHANGEDURA = 655;//蜡烛持久改变
  SM_CHANGENAMECOLOR = 656;//名字颜色改变,白名,灰名,红名,黄名
  SM_CHARSTATUSCHANGED = 657;
  SM_SENDNOTICE = 658; //发送健康游戏忠告(公告)
  SM_GROUPMODECHANGED = 659;//组队模式改变
  SM_CREATEGROUP_OK = 660;
  SM_CREATEGROUP_FAIL = 661;
  SM_GROUPADDMEM_OK = 662;
  SM_GROUPDELMEM_OK = 663;
  SM_GROUPADDMEM_FAIL = 664;
  SM_GROUPDELMEM_FAIL = 665;
  SM_GROUPCANCEL = 666;
  SM_GROUPMEMBERS = 667;
  SM_SENDUSERREPAIR = 668;
  SM_USERREPAIRITEM_OK = 669;
  SM_USERREPAIRITEM_FAIL = 670;
  SM_SENDREPAIRCOST = 671;
  SM_DEALMENU = 673;
  SM_DEALTRY_FAIL = 674;
  SM_DEALADDITEM_OK = 675;
  SM_DEALADDITEM_FAIL = 676;
  SM_DEALDELITEM_OK = 677;
  SM_DEALDELITEM_FAIL = 678;
  SM_DEALCANCEL = 681;
  SM_DEALREMOTEADDITEM = 682;
  SM_DEALREMOTEDELITEM = 683;
  SM_DEALCHGGOLD_OK = 684;
  SM_DEALCHGGOLD_FAIL = 685;
  SM_DEALREMOTECHGGOLD = 686;
  SM_DEALSUCCESS = 687;
  SM_SENDUSERSTORAGEITEM = 700;
  SM_STORAGE_OK = 701;
  SM_STORAGE_FULL = 702;
  SM_STORAGE_FAIL = 703;
  SM_SAVEITEMLIST = 704;
  SM_TAKEBACKSTORAGEITEM_OK = 705;
  SM_TAKEBACKSTORAGEITEM_FAIL = 706;
  SM_TAKEBACKSTORAGEITEM_FULLBAG = 707;

  SM_AREASTATE = 708; //周围状态
  SM_MYSTATUS = 766;//我的状态,最近一次下线状态,如是否被毒,挂了就强制回城

  SM_DELITEMS = 709;
  SM_READMINIMAP_OK = 710;
  SM_READMINIMAP_FAIL = 711;
  SM_SENDUSERMAKEDRUGITEMLIST = 712;
  SM_MAKEDRUG_SUCCESS = 713;
  //  714
  //  716
  SM_MAKEDRUG_FAIL = 65036;

  SM_CHANGEGUILDNAME = 750;
  SM_SENDUSERSTATE = 751; //
  SM_SUBABILITY = 752; //打开输助属性对话框
  SM_OPENGUILDDLG = 753; //
  SM_OPENGUILDDLG_FAIL = 754; //
  SM_SENDGUILDMEMBERLIST = 756; //
  SM_GUILDADDMEMBER_OK = 757; //
  SM_GUILDADDMEMBER_FAIL = 758;
  SM_GUILDDELMEMBER_OK = 759;
  SM_GUILDDELMEMBER_FAIL = 760;
  SM_GUILDRANKUPDATE_FAIL = 761;
  SM_BUILDGUILD_OK = 762;
  SM_BUILDGUILD_FAIL = 763;
  SM_DONATE_OK = 764;
  SM_DONATE_FAIL = 765;

  SM_MENU_OK = 767; //?
  SM_GUILDMAKEALLY_OK = 768;
  SM_GUILDMAKEALLY_FAIL = 769;
  SM_GUILDBREAKALLY_OK = 770; //?
  SM_GUILDBREAKALLY_FAIL = 771; //?
  SM_DLGMSG = 772; //Jacky
  SM_SPACEMOVE_HIDE = 800;//道士走一下隐身
  SM_SPACEMOVE_SHOW = 801;//道士走一下由隐身变为现身
  SM_RECONNECT = 802; //与服务器重连
  SM_GHOST = 803; //尸体清除,虹魔教主死的效果?
  SM_SHOWEVENT = 804;//显示事件
  SM_HIDEEVENT = 805;//隐藏事件
  SM_SPACEMOVE_HIDE2 = 806;
  SM_SPACEMOVE_SHOW2 = 807;
  SM_TIMECHECK_MSG = 810; //时钟检测,以免客户端作弊
  SM_ADJUST_BONUS = 811; //?


  SM_OPENHEALTH = 1100;
  SM_CLOSEHEALTH = 1101;

  SM_BREAKWEAPON = 1102; //武器破碎
  SM_INSTANCEHEALGUAGE = 1103; //实时治愈
  SM_CHANGEFACE = 1104; //变脸,发型改变?
  SM_VERSION_FAIL = 1106; //客户端版本验证失败

  SM_ITEMUPDATE = 1500;
  SM_MONSTERSAY = 1501;

  SM_EXCHGTAKEON_OK = 65023;
  SM_EXCHGTAKEON_FAIL = 65024;

  SM_TEST = 65037;
  SM_TESTHERO = 65038;
  SM_THROW = 65069;

  RM_DELITEMS = 9000; //Jacky
  RM_TURN = 10001;
  RM_WALK = 10002;
  RM_RUN = 10003;
  RM_HIT = 10004;
  RM_SPELL = 10007;
  RM_SPELL2 = 10008;
  RM_POWERHIT = 10009;
  RM_LONGHIT = 10011;
  RM_WIDEHIT = 10012;
  RM_PUSH = 10013;
  RM_FIREHIT = 10014;//烈火
  RM_4FIREHIT = 10016;//4级烈火 20080112
  RM_RUSH = 10015;
  RM_STRUCK = 10020;//受物理打击
  RM_DEATH = 10021;
  RM_DISAPPEAR = 10022;
  RM_MAGSTRUCK = 10025;
  RM_MAGHEALING = 10026;
  RM_STRUCK_MAG = 10027;//受魔法打击
  RM_MAGSTRUCK_MINE = 10028;
  RM_INSTANCEHEALGUAGE = 10029; //jacky
  RM_HEAR = 10030;//公聊
  RM_WHISPER = 10031;
  RM_CRY = 10032;
  RM_RIDE = 10033;
  RM_WINEXP = 10044;
  RM_USERNAME = 10043;
  RM_LEVELUP = 10045;
  RM_CHANGENAMECOLOR = 10046;

  RM_LOGON = 10050;
  RM_ABILITY = 10051;
  RM_HEALTHSPELLCHANGED = 10052;
  RM_DAYCHANGING = 10053;

  RM_MOVEMESSAGE = 10099;  //滚动公告 2007.11.13
  RM_SYSMESSAGE = 10100;
  RM_GROUPMESSAGE = 10102;
  RM_SYSMESSAGE2 = 10103;
  RM_GUILDMESSAGE = 10104;
  RM_SYSMESSAGE3 = 10105; //Jacky
  RM_ITEMSHOW = 10110;
  RM_ITEMHIDE = 10111;
  RM_DOOROPEN = 10112;
  RM_DOORCLOSE = 10113;
  RM_SENDUSEITEMS = 10114;//发送使用的物品
  RM_WEIGHTCHANGED = 10115;

  RM_FEATURECHANGED = 10116;
  RM_CLEAROBJECTS = 10117;
  RM_CHANGEMAP = 10118;
  RM_BUTCH = 10119;//挖
  RM_MAGICFIRE = 10120;
  RM_SENDMYMAGIC = 10122;//发送使用的魔法
  RM_MAGIC_LVEXP = 10123;
  RM_SKELETON = 10024;
  RM_DURACHANGE = 10125;//持久改变
  RM_MERCHANTSAY = 10126;
  RM_GOLDCHANGED = 10136;
  RM_CHANGELIGHT = 10137;
  RM_CHARSTATUSCHANGED = 10139;
  RM_DELAYMAGIC = 10154;

  RM_DIGUP = 10200;
  RM_DIGDOWN = 10201;
  RM_FLYAXE = 10202;
  RM_LIGHTING = 10204;
  RM_SUBABILITY = 10302;
  RM_TRANSPARENT = 10308;

  RM_SPACEMOVE_SHOW = 10331;
  RM_RECONNECTION = 11332;
  RM_SPACEMOVE_SHOW2 = 10332; //?
  RM_HIDEEVENT = 10333;//隐藏烟花
  RM_SHOWEVENT = 10334;//显示烟花
  RM_ZEN_BEE = 10337;

  RM_OPENHEALTH = 10410;
  RM_CLOSEHEALTH = 10411;
  RM_DOOPENHEALTH = 10412;
  RM_CHANGEFACE = 10415;

  RM_ITEMUPDATE = 11000;
  RM_MONSTERSAY = 11001;
  RM_MAKESLAVE = 11002;

  RM_MONMOVE = 21004;
  SS_200 = 200;
  SS_201 = 201;
  SS_202 = 202;
  SS_WHISPER = 203;
  SS_204 = 204;
  SS_205 = 205;
  SS_206 = 206;
  SS_207 = 207;
  SS_208 = 208;
  SS_209 = 219;
  SS_210 = 210;
  SS_211 = 211;
  SS_212 = 212;
  SS_213 = 213;
  SS_214 = 214;

  RM_10205 = 10205;
  RM_10101 = 10101;
  RM_ALIVE = 10153;
  RM_CHANGEGUILDNAME = 10301;
  RM_10414 = 10414;
  RM_POISON = 10300;
  LA_UNDEAD = 1; //不死系

  RM_DELAYPUSHED = 10555;

  CM_GETBACKPASSWORD = 2010; //密码找回
  CM_SPELL = 3017; //施魔法
  CM_QUERYUSERNAME = 80; //进入游戏,服务器返回角色名到客户端

  CM_DROPITEM = 1000;//从包裹里扔出物品到地图,此时人物如果在安全区可能会提示安全区不允许扔东西
  CM_PICKUP = 1001;//捡东西
  CM_TAKEONITEM = 1003;//装配装备到身上的装备位置
  CM_TAKEOFFITEM = 1004; //从身上某个装备位置取下某个装备
  CM_EAT = 1006; //吃药
  CM_BUTCH = 1007;//挖
  CM_MAGICKEYCHANGE = 1008;//魔法快捷键改变
  CM_HEROMAGICKEYCHANGE = 1046;//英雄魔法开关设置 20080606
  CM_1005 = 1005;

//与商店NPC交易相关
  CM_CLICKNPC = 1010; //用户点击了某个NPC进行交互
  CM_MERCHANTDLGSELECT = 1011; //商品选择,大类
  CM_MERCHANTQUERYSELLPRICE = 1012;//返回价格,标准价格,我们知道商店用户卖入的有些东西掉持久或有特殊
  CM_USERSELLITEM = 1013; //用户卖东西
  CM_USERBUYITEM = 1014; //用户买入东西
  CM_USERGETDETAILITEM = 1015;//取得商品清单,比如点击"蛇眼戒指"大类,会出现一列蛇眼戒指供你选择
  CM_DROPGOLD = 1016; //用户放下金钱到地上
  CM_LOGINNOTICEOK = 1018; //健康游戏忠告点了确实,进入游戏
  CM_GROUPMODE = 1019;   //关组还是开组
  CM_CREATEGROUP = 1020; //新建组队
  CM_ADDGROUPMEMBER = 1021;//组内添人
  CM_DELGROUPMEMBER = 1022; //组内删人
  CM_USERREPAIRITEM = 1023; //用户修理东西
  CM_MERCHANTQUERYREPAIRCOST = 1024; //客户端向NPC取得修理费用
  CM_DEALTRY = 1025;  //开始交易,交易开始
  CM_DEALADDITEM = 1026; //加东东到交易物品栏上
  CM_DEALDELITEM = 1027;//从交易物品栏上撤回东东???好像不允许哦
  CM_DEALCANCEL = 1028;  //取消交易
  CM_DEALCHGGOLD = 1029; //本来交易栏上金钱为0,,如有金钱交易,交易双方都会有这个消息
  CM_DEALEND = 1030; //交易成功,完成交易
  CM_USERSTORAGEITEM = 1031; //用户寄存东西
  CM_USERTAKEBACKSTORAGEITEM = 1032;//用户向保管员取回东西
  CM_WANTMINIMAP = 1033;  //用户点击了"小地图"按钮
  CM_USERMAKEDRUGITEM = 1034; //用户制造毒药(其它物品)
  CM_OPENGUILDDLG = 1035; //用户点击了"行会"按钮
  CM_GUILDHOME = 1036; //点击"行会主页"
  CM_GUILDMEMBERLIST = 1037; //点击"成员列表"
  CM_GUILDADDMEMBER = 1038; //增加成员
  CM_GUILDDELMEMBER = 1039;//踢人出行会
  CM_GUILDUPDATENOTICE = 1040; //修改行会公告
  CM_GUILDUPDATERANKINFO = 1041; //更新联盟信息(取消或建立联盟)
  CM_ADJUST_BONUS = 1043;  //用户得到奖励??私服中比较明显,小号升级时会得出金钱声望等,不是很确定,//求经过测试的高手的验证
  CM_SPEEDHACKUSER = 10430; //用户加速作弊检测

  CM_PASSWORD = 1105;
  CM_CHGPASSWORD = 1221; //?
  CM_SETPASSWORD = 1222; //?

  CM_HORSERUN = 3009;

  CM_THROW = 3005;//抛符
  
//动作命令1
  CM_TURN = 3010; //转身(方向改变)
  CM_WALK = 3011; //走
  CM_SITDOWN = 3012;//挖(蹲下)
  CM_RUN = 3013; //跑
  CM_HIT = 3014;   //普通物理近身攻击
  CM_HEAVYHIT = 3015;//跳起来打的动作
  CM_BIGHIT = 3016;

  CM_POWERHIT = 3018; //攻杀
  CM_LONGHIT = 3019;  //刺杀

  CM_WIDEHIT = 3024; //半月
  CM_FIREHIT = 3025; //烈火攻击
  CM_4FIREHIT = 3031; //4级烈火攻击
  CM_CRSHIT = 3036; //抱月刀
  CM_TWNHIT = 3037; //开天斩重击
  CM_QTWINHIT = 3041; //开天斩轻击
  CM_CIDHIT = 3040; //龙影剑法
  CM_TWINHIT = CM_TWNHIT;
  CM_PHHIT = 3038; //破魂斩
  CM_DAILY = 3042; //逐日剑法 20080511

  CM_SAY = 3030;    //角色发言
  CM_40HIT = 3026;
  CM_41HIT = 3027;
  CM_42HIT = 3029;
  CM_43HIT = 3028;
  RM_10401 = 10401;

  RM_MENU_OK = 10309; //菜单
  RM_MERCHANTDLGCLOSE = 10127;
  RM_SENDDELITEMLIST = 10148;//发送删除项目的名单
  RM_SENDUSERSREPAIR = 10141;//发送用户修理
  RM_SENDGOODSLIST = 10128;//发送商品名单
  RM_SENDUSERSELL = 10129;//发送用户出售
  RM_SENDUSERREPAIR = 11139;//发送用户修理
  RM_USERMAKEDRUGITEMLIST = 10149;//用户做药品项目的名单
  RM_USERSTORAGEITEM = 10146;//用户仓库项目
  RM_USERGETBACKITEM = 10147;//用户获得回的仓库项目

  RM_SPACEMOVE_FIRE2 = 11330;//空间移动
  RM_SPACEMOVE_FIRE = 11331;//空间移动

  RM_BUYITEM_SUCCESS = 10133;//购买项目成功
  RM_BUYITEM_FAIL = 10134;//购买项目失败
  RM_SENDDETAILGOODSLIST = 10135; //发送详细的商品名单
  RM_SENDBUYPRICE = 10130;//发送购买价格
  RM_USERSELLITEM_OK = 10131;//用户出售成功
  RM_USERSELLITEM_FAIL = 10132;//用户出售失败
  RM_MAKEDRUG_SUCCESS = 10150;//做药成功
  RM_MAKEDRUG_FAIL = 10151;//做药失败
  RM_SENDREPAIRCOST = 10142;//发送修理成本
  RM_USERREPAIRITEM_OK = 10143;//用户修理项目成功
  RM_USERREPAIRITEM_FAIL = 10144;//用户修理项目失败

  MAXBAGITEM = 46;//人物背包最大数量
  MAXHEROBAGITEM = 40; //英雄包裹最大数量
  RM_10155 = 10155;
  RM_PLAYDICE = 10500;
  RM_ADJUST_BONUS = 10400;

  RM_BUILDGUILD_OK = 10303;
  RM_BUILDGUILD_FAIL = 10304;
  RM_DONATE_OK = 10305;

  RM_GAMEGOLDCHANGED = 10666;

  STATE_OPENHEATH = 1;
  POISON_68 = 68;

  RM_MYSTATUS = 10777;

  CM_QUERYUSERSTATE = 82;//查询用户状态(用户登录进去,实际上是客户端向服务器索取查询最近一次,退出服务器前的状态的过程,
                         //服务器自动把用户最近一次下线以让游戏继续的一些信息返回到客户端)

  CM_QUERYBAGITEMS = 81;  //查询包裹物品

  CM_QUERYUSERSET = 49999;

  CM_OPENDOOR = 1002;  //开门,人物走到地图的某个过门点时
  CM_SOFTCLOSE = 1009;//退出传奇(游戏程序,可能是游戏中大退,也可能时选人时退出)
  CM_1017 = 1017;
  CM_1042 = 1042;
  CM_GUILDALLY = 1044;
  CM_GUILDBREAKALLY = 1045;

  RM_HORSERUN = 11000;
  RM_HEAVYHIT = 10005;
  RM_BIGHIT = 10006;
  RM_MOVEFAIL = 10010;
  RM_CRSHIT = 11014;
  RM_RUSHKUNG = 11015;

  RM_41 = 41;
  RM_42 = 42;
  RM_43 = 43;
  RM_44 = 56;

  RM_MAGICFIREFAIL = 10121;
  RM_LAMPCHANGEDURA = 10138;
  RM_GROUPCANCEL = 10140;

  RM_DONATE_FAIL = 10306;

  RM_BREAKWEAPON = 10413;

  RM_PASSWORD = 10416;

  RM_PASSWORDSTATUS = 10601;

  SM_40 = 35;
  SM_41 = 36;
  SM_42 = 37;
  SM_43 = 38;
  SM_44 = 39; //龙影剑法

  SM_HORSERUN = 5;
  SM_716 = 716;

  SM_PASSWORD = 3030;
  SM_PLAYDICE = 1200;

  SM_PASSWORDSTATUS = 20001;

  SM_GAMEGOLDNAME = 55; //向客户端发送游戏币,游戏点,金刚石,灵符数量

  SM_SERVERCONFIG = 20002;
  SM_GETREGINFO = 20003;


  ET_DIGOUTZOMBI = 1;
  ET_PILESTONES = 3;
  ET_HOLYCURTAIN = 4;
  ET_FIRE = 5;
  ET_SCULPEICE = 6;
{6种烟花}
  ET_FIREFLOWER_1 = 7;//一心一意
  ET_FIREFLOWER_2 = 8;//心心相印
  ET_FIREFLOWER_3 = 9;
  ET_FIREFLOWER_4 = 10;
  ET_FIREFLOWER_5 = 11;
  ET_FIREFLOWER_6 = 12;
  ET_FIREFLOWER_7 = 13;
  ET_FIREFLOWER_8 = 14;//没有图片
  ET_FOUNTAIN = 15;//喷泉效果 20080624
  ET_DIEEVENT = 16; //人型庄主死亡动画效果 20080918

  CM_PROTOCOL = 2000;
  CM_IDPASSWORD = 2001; //客户端向服务器发送ID和密码
  CM_ADDNEWUSER = 2002; //新建用户,就是注册新账号,登录时选择了"新用户"并操作成功
  CM_CHANGEPASSWORD = 2003;  //修改密码
  CM_UPDATEUSER = 2004;  //更新注册资料??
  CM_RANDOMCODE = 2006;//取验证码 20080612
  SM_RANDOMCODE = 2007;


  CLIENT_VERSION_NUMBER = 920080512;//9+客户端版本号 20080512
  CM_3037 = 3039;           //2007.10.15改了值  以前是  3037

  SM_NEEDPASSWORD = 8003;
  CM_POWERBLOCK = 0;

  //商铺相关
  CM_OPENSHOP = 9000; //打开商铺
  SM_SENGSHOPITEMS = 9001; // SERIES 7 每页的数量    wParam 总页数
  CM_BUYSHOPITEM = 9002;
  SM_BUYSHOPITEM_SUCCESS = 9003;
  SM_BUYSHOPITEM_FAIL = 9004;
  SM_SENGSHOPSPECIALLYITEMS = 9005; //奇珍类型
  CM_BUYSHOPITEMGIVE = 9006; //赠送
  SM_BUYSHOPITEMGIVE_FAIL = 9007;
  SM_BUYSHOPITEMGIVE_SUCCESS = 9008;

  RM_OPENSHOPSpecially = 30000;
  RM_OPENSHOP = 30001;
  RM_BUYSHOPITEM_FAIL = 30003;//商铺购买物品失败
  RM_BUYSHOPITEMGIVE_FAIL = 30004;
  RM_BUYSHOPITEMGIVE_SUCCESS = 30005;
  //==============================================================================
  CM_QUERYUSERLEVELSORT = 3500; //用户等级排行
  RM_QUERYUSERLEVELSORT = 35000;
  SM_QUERYUSERLEVELSORT = 2500;
  //==============================新增物品寄售系统==============================
  RM_SENDSELLOFFGOODSLIST = 21008;//拍卖
  SM_SENDSELLOFFGOODSLIST = 20008;//拍卖
  RM_SENDUSERSELLOFFITEM = 21005; //寄售物品
  SM_SENDUSERSELLOFFITEM = 20005; //寄售物品
  RM_SENDSELLOFFITEMLIST = 22009; //查询得到的寄售物品
  CM_SENDSELLOFFITEMLIST = 20009; //查询得到的寄售物品
  RM_SENDBUYSELLOFFITEM_OK = 21010; //购买寄售物品成功
  SM_SENDBUYSELLOFFITEM_OK = 20010; //购买寄售物品成功
  RM_SENDBUYSELLOFFITEM_FAIL = 21011; //购买寄售物品失败
  SM_SENDBUYSELLOFFITEM_FAIL = 20011; //购买寄售物品失败
  RM_SENDBUYSELLOFFITEM = 41005; //购买选择寄售物品
  CM_SENDBUYSELLOFFITEM = 4005; //购买选择寄售物品
  RM_SENDQUERYSELLOFFITEM = 41006; //查询选择寄售物品
  CM_SENDQUERYSELLOFFITEM = 4006; //查询选择寄售物品
  RM_SENDSELLOFFITEM = 41004; //接受寄售物品
  CM_SENDSELLOFFITEM = 4004; //接受寄售物品
  RM_SENDUSERSELLOFFITEM_FAIL = 2007; //R = -3  寄售物品失败
  RM_SENDUSERSELLOFFITEM_OK = 2006; //寄售物品成功
  SM_SENDUSERSELLOFFITEM_FAIL = 20007; //R = -3  寄售物品失败
  SM_SENDUSERSELLOFFITEM_OK = 20006; //寄售物品成功
//==============================元宝寄售系统(20080316)==========================
  RM_SENDDEALOFFFORM = 23000;//打开出售物品窗口
  SM_SENDDEALOFFFORM = 23001;//打开出售物品窗口
  CM_SELLOFFADDITEM  = 23002;//客户端往出售物品窗口里加物品
  SM_SELLOFFADDITEM_OK = 23003;//客户端往出售物品窗口里加物品 成功
  RM_SELLOFFADDITEM_OK = 23004;
  SM_SellOffADDITEM_FAIL=23005;//客户端往出售物品窗口里加物品 失败
  RM_SellOffADDITEM_FAIL=23006;
  CM_SELLOFFDELITEM = 23007;//客户端删除出售物品窗里的物品
  SM_SELLOFFDELITEM_OK = 23008;//客户端删除出售物品窗里的物品 成功
  RM_SELLOFFDELITEM_OK = 23009;
  SM_SELLOFFDELITEM_FAIL = 23010;//客户端删除出售物品窗里的物品 失败
  RM_SELLOFFDELITEM_FAIL = 23011;
  CM_SELLOFFCANCEL = 23012;//客户端取消元宝寄售
  RM_SELLOFFCANCEL = 23013; // 元宝寄售取消出售
  SM_SellOffCANCEL = 23014;//元宝寄售取消出售
  CM_SELLOFFEND    = 23015; //客户端元宝寄售结束
  SM_SELLOFFEND_OK = 23016; //客户端元宝寄售结束 成功
  RM_SELLOFFEND_OK = 23017;
  SM_SELLOFFEND_FAIL= 23018; //客户端元宝寄售结束 失败
  RM_SELLOFFEND_FAIL= 23019;
  RM_QUERYYBSELL = 23020;//查询正在出售的物品
  SM_QUERYYBSELL = 23021;//查询正在出售的物品
  RM_QUERYYBDEAL = 23022;//查询可以的购买物品
  SM_QUERYYBDEAL = 23023;//查询可以的购买物品
  CM_CANCELSELLOFFITEMING = 23024; //取消正在寄售的物品 20080318(出售人)
  //SM_CANCELSELLOFFITEMING_OK =23018;//取消正在寄售的物品 成功
  CM_SELLOFFBUYCANCEL = 23025; //取消寄售 物品购买 20080318(购买人)
  CM_SELLOFFBUY = 23026; //确定购买寄售物品 20080318
  SM_SELLOFFBUY_OK =23027;//购买成功
  RM_SELLOFFBUY_OK =23028;
  //SM_SELLOFFBUY_FAIL =23029;//购买失败
  //RM_SELLOFFBUY_FAIL =23030;
//==============================================================================
  //英雄
  ////////////////////////////////////////////////////////////////////////////////
  CM_RECALLHERO = 5000; //召唤英雄
  SM_RECALLHERO = 5001;
  CM_HEROLOGOUT = 5002; //英雄退出
  SM_HEROLOGOUT = 5003;
  SM_CREATEHERO = 5004; //创建英雄

  SM_HERODEATH = 5005;  //创建死亡
  CM_HEROCHGSTATUS = 5006; //改变英雄状态
  CM_HEROATTACKTARGET = 5007; //英雄锁定目标
  CM_HEROPROTECT = 5008; //守护目标
  CM_HEROTAKEONITEM = 5009;  //打开物品栏
  CM_HEROTAKEOFFITEM = 5010; //关闭物品栏
  CM_TAKEOFFITEMHEROBAG = 5011; //装备脱下到英雄包裹
  CM_TAKEOFFITEMTOMASTERBAG = 5012; //装备脱下到主人包裹
  CM_SENDITEMTOMASTERBAG = 5013; //主人包裹到英雄包裹
  CM_SENDITEMTOHEROBAG = 5014; //英雄包裹到主人包裹
  SM_HEROTAKEON_OK = 5015;
  SM_HEROTAKEON_FAIL = 5016;
  SM_HEROTAKEOFF_OK = 5017;
  SM_HEROTAKEOFF_FAIL = 5018;
  SM_TAKEOFFTOHEROBAG_OK = 5019;
  SM_TAKEOFFTOHEROBAG_FAIL = 5020;
  SM_TAKEOFFTOMASTERBAG_OK = 5021;
  SM_TAKEOFFTOMASTERBAG_FAIL = 5022;
  CM_HEROTAKEONITEMFORMMASTERBAG = 5023; //从主人包裹穿装备到英雄包裹
  CM_TAKEONITEMFORMHEROBAG = 5024; //从英雄包裹穿装备到主人包裹
  SM_SENDITEMTOMASTERBAG_OK = 5025; //主人包裹到英雄包裹成功
  SM_SENDITEMTOMASTERBAG_FAIL = 5026; //主人包裹到英雄包裹失败
  SM_SENDITEMTOHEROBAG_OK = 5027; //英雄包裹到主人包裹
  SM_SENDITEMTOHEROBAG_FAIL = 5028; //英雄包裹到主人包裹
  CM_QUERYHEROBAGCOUNT = 5029; //查看英雄包裹容量
  SM_QUERYHEROBAGCOUNT = 5030; //查看英雄包裹容量
  CM_QUERYHEROBAGITEMS = 5031; //查看英雄包裹
  SM_SENDHEROUSEITEMS = 5032;  //发送英雄身上装备
  SM_HEROBAGITEMS = 5033;     //接收英雄物品
  SM_HEROADDITEM = 5034;  //英雄包裹添加物品
  SM_HERODELITEM = 5035;  //英雄包裹删除物品
  SM_HEROUPDATEITEM = 5036; //英雄包裹更新物品
  SM_HEROADDMAGIC = 5037;   //添加英雄魔法
  SM_HEROSENDMYMAGIC = 5038; //发送英雄的魔法
  SM_HERODELMAGIC = 5039;   //删除英雄魔法
  SM_HEROABILITY = 5040;   //英雄属性1
  SM_HEROSUBABILITY = 5041;//英雄属性2
  SM_HEROWEIGHTCHANGED = 5042;
  CM_HEROEAT = 5043;       //吃东西
  SM_HEROEAT_OK = 5044;    //吃东西成功
  SM_HEROEAT_FAIL = 5045; //吃东西失败
  SM_HEROMAGIC_LVEXP = 5046;//魔法等级
  SM_HERODURACHANGE = 5047;  //英雄持久改变
  SM_HEROWINEXP = 5048;    //英雄增加经验
  SM_HEROLEVELUP = 5049;  //英雄升级
  SM_HEROCHANGEITEM = 5050; //好象没用上？
  SM_HERODELITEMS = 5051;   //删除英雄物品
  CM_HERODROPITEM = 5052;   //英雄往地上扔物品
  SM_HERODROPITEM_SUCCESS = 5053;//英雄扔物品成功
  SM_HERODROPITEM_FAIL = 5054;  //英雄扔物品失败
  CM_HEROGOTETHERUSESPELL = 5055; //使用合击
  SM_GOTETHERUSESPELL = 5056; //使用合击
  SM_FIRDRAGONPOINT = 5057;   //英雄怒气值
  CM_REPAIRFIRDRAGON = 5058;  //修补火龙之心
  SM_REPAIRFIRDRAGON_OK = 5059; //修补火龙之心成功
  SM_REPAIRFIRDRAGON_FAIL = 5060; //修补火龙之心失败
//---------------------------------------------------
//祝福罐.魔令包功能 20080102
  CM_REPAIRDRAGON = 5061;  //祝福罐.魔令包功能
  SM_REPAIRDRAGON_OK = 5062; //修补祝福罐.魔令包成功
  SM_REPAIRDRAGON_FAIL = 5063; //修补祝福罐.魔令包失败
//----------------------------------------------------

  RM_RECALLHERO = 19999;   //召唤英雄
  RM_HEROWEIGHTCHANGED = 20000;
  RM_SENDHEROUSEITEMS = 20001;
  RM_SENDHEROMYMAGIC = 20002;
  RM_HEROMAGIC_LVEXP = 20003;
  RM_QUERYHEROBAGCOUNT = 20004;
  RM_HEROABILITY = 20005;
  RM_HERODURACHANGE = 20006;
  RM_HERODEATH = 20007;
  RM_HEROLEVELUP = 20008;
  RM_HEROWINEXP = 20009;
  //RM_HEROLOGOUT = 20010;
  RM_CREATEHERO = 20011;
  RM_MAKEGHOSTHERO = 20012;
  RM_HEROSUBABILITY = 20013;


  RM_GOTETHERUSESPELL = 20014; //使用合击
  RM_FIRDRAGONPOINT = 20015;  //发送英雄怒气值
  RM_CHANGETURN = 20016;
  //-----------------------------------月灵重击
  RM_FAIRYATTACKRATE = 20017;
  SM_FAIRYATTACKRATE = 20018;
  //-----------------------------------
  SM_SERVERUNBIND = 20019;
  RM_DESTROYHERO = 20020;//英雄销毁
  SM_DESTROYHERO = 20021;//英雄销毁

  ET_PROTECTION_STRUCK = 20022; //护体受攻击  20080108
  ET_PROTECTION_PIP = 20023;  //护体被破
  
  SM_MYSHOW = 20024; //显示自身动画
  RM_MYSHOW = 20025; //

  RM_OPENBOXS = 20026;//打开宝箱 20080115
  SM_OPENBOXS = 5064;//打开宝箱 20080115
  CM_OPENBOXS = 20027;//打开宝箱 20080115 加
  CM_MOVEBOXS = 20028;//转动宝箱 20080117
  RM_MOVEBOXS = 20029;//转动宝箱 20080117
  SM_MOVEBOXS = 20030;//转动宝箱 20080117
  CM_GETBOXS  = 20031;//客户端取得宝箱物品 20080118
  SM_GETBOXS  = 20032;
  RM_GETBOXS  = 20033;
  SM_OPENBOOKS  = 20034; //打开卧龙NPC 20080119
  RM_OPENBOOKS  = 20035;
  RM_DRAGONPOINT = 20036;  //发送黄条气值 20080201
  SM_DRAGONPOINT = 20037;
  ET_OBJECTLEVELUP = 20038; //人物升级动画显示 20080222
  RM_CHANGEATTATCKMODE = 20039; //改变攻击模式 20080228
  SM_CHANGEATTATCKMODE = 20040; //改变攻击模式 20080228
  CM_EXCHANGEGAMEGIRD = 20042; //商铺兑换灵符  20080302
  SM_EXCHANGEGAMEGIRD_FAIL = 20043;//商铺购买物品失败
  SM_EXCHANGEGAMEGIRD_SUCCESS = 20044;
  RM_EXCHANGEGAMEGIRD_FAIL = 20045;
  RM_EXCHANGEGAMEGIRD_SUCCESS = 20046;
  RM_OPENDRAGONBOXS = 20047; //卧龙开宝箱 20080306
  SM_OPENDRAGONBOXS = 20048; //卧龙开宝箱 20080306
// SM_OPENBOXS_OK = 20047; //打开宝箱成功 20080306
  RM_OPENBOXS_FAIL = 20049; //打开宝箱失败 20080306
  SM_OPENBOXS_FAIL = 20050; //打开宝箱失败 20080306

  RM_EXPTIMEITEMS = 20051;  //聚灵珠 发送时间改变消息 20080306
  SM_EXPTIMEITEMS = 20052;  //聚灵珠 发送时间改变消息 20080306

  ET_OBJECTBUTCHMON = 20053; //人物挖尸体得到物品显示 20080325

  //RM_CLOSEDRAGONPOINT = 20054;  //关闭龙影黄条 20080329
  //SM_CLOSEDRAGONPOINT = 20055;  //关闭龙影黄条 20080329
//---------------------------粹练系统------------------------------------------
  RM_QUERYREFINEITEM = 20056; //打开粹练框口
  SM_QUERYREFINEITEM = 20057; //打开粹练框口
  CM_REFINEITEM = 20058;//客户端发送粹练物品 20080507

  SM_UPDATERYREFINEITEM = 20059; //更新粹练物品 20080507
  CM_REPAIRFINEITEM = 20060; //修补火云石 20080507 20080507
  SM_REPAIRFINEITEM_OK = 20061; //修补火云石成功  20080507
  SM_REPAIRFINEITEM_FAIL = 20062; //修补火云石失败  20080507
//-----------------------------------------------------------------------------
  RM_DAILY = 20063;//逐日剑法 20080511
  SM_DAILY = 20064;//逐日剑法 20080511
  RM_GLORY = 20065;//发送到客户端 荣誉值 20080511
  SM_GLORY = 20066;//发送到客户端 荣誉值 20080511

  RM_GETHEROINFO = 20067;
  SM_GETHEROINFO = 20068; //获得英雄数据
  CM_SELGETHERO  = 20069; //取出英雄
  RM_SENDUSERPLAYDRINK = 20070;//出现请酒对话框 20080515
  SM_SENDUSERPLAYDRINK = 20071;//出现请酒对话框 20080515
  CM_USERPLAYDRINKITEM = 20072;//请酒框放上物品发送到M2
  SM_USERPLAYDRINK_OK = 20073;  //请酒成功  20080515
  SM_USERPLAYDRINK_FAIL = 20074; //请酒失败 20080515
  RM_PLAYDRINKSAY = 20075;//
  SM_PLAYDRINKSAY = 20076;
  CM_PlAYDRINKDLGSELECT = 20077; //商品选择,大类
  RM_OPENPLAYDRINK = 20078;   //打开窗口
  SM_OPENPLAYDRINK = 20079;   //打开窗口
  CM_PlAYDRINKGAME = 20080;  //发送猜拳码数 20080517
  RM_PlayDrinkToDrink = 20081; //发送到客户端谁赢谁输
  SM_PlayDrinkToDrink = 20082; //
  CM_DrinkUpdateValue = 20083; //发送喝酒
  RM_DrinkUpdateValue = 20084; //返回喝酒
  SM_DrinkUpdateValue = 20085; //返回喝酒
  RM_CLOSEDRINK = 20086;//关闭斗酒，请酒窗口
  SM_CLOSEDRINK = 20087;//关闭斗酒，请酒窗口
  CM_USERPLAYDRINK = 20088; //客户端发送请酒物品
  SM_USERPLAYDRINKITEM_OK = 20089;  //请酒物品成功
  SM_USERPLAYDRINKITEM_FAIL = 20090; //请酒物品失败
  RM_Browser = 20091;//连接指定网站
  SM_Browser = 20092;

  RM_PIXINGHIT = 20093;//劈星斩效果 20080611
  SM_PIXINGHIT = 20094;

  RM_LEITINGHIT = 20095;//雷霆一击效果 20080611
  SM_LEITINGHIT = 20096;

  CM_CHECKNUM = 20097;//检测验证码 20080612
  SM_CHECKNUM_OK = 20098;
  CM_CHANGECHECKNUM = 20099;

  RM_AUTOGOTOXY = 20100;//自动寻路
  SM_AUTOGOTOXY = 20101;
//-----------------------酿酒系统---------------------------------------------
  RM_OPENMAKEWINE =20102;//打开酿酒窗口
  SM_OPENMAKEWINE =20103;//打开酿酒窗口
  CM_BEGINMAKEWINE = 20104;//开始酿酒(即把材料全放上窗口)
  RM_MAKEWINE_OK = 20105;//酿酒成功
  SM_MAKEWINE_OK = 20106;//酿酒成功
  RM_MAKEWINE_FAIL = 20107;//酿酒失败
  SM_MAKEWINE_FAIL = 20108;//酿酒失败
  RM_NPCWALK = 20109;//酿酒NPC走动
  SM_NPCWALK = 20110;//酿酒NPC走动
  RM_MAGIC68SKILLEXP = 20111;//酒气护体技能经验
  SM_MAGIC68SKILLEXP = 20112;//酒气护体技能经验
//------------------------挑战系统--------------------------------------------
  SM_CHALLENGE_FAIL = 20113;//挑战失败
  SM_CHALLENGEMENU =20114;//打开挑战抵押物品窗口
  CM_CHALLENGETRY = 20115;//玩家点挑战

  CM_CHALLENGEADDITEM = 20116;//玩家把物品放到挑战框中
  SM_CHALLENGEADDITEM_OK = 20117;//玩家增加抵押物品成功
  SM_CHALLENGEADDITEM_FAIL = 20118;//玩家增加抵押物品失败
  SM_CHALLENGEREMOTEADDITEM = 20119;//发送增加抵押的物品后,给客户端显示

  CM_CHALLENGEDELITEM = 20120;//玩家从挑战框中取回物品
  SM_CHALLENGEDELITEM_OK= 20121;//玩家删除抵押物品成功
  SM_CHALLENGEDELITEM_FAIL = 20122;//玩家删除抵押物品失败
  SM_CHALLENGEREMOTEDELITEM = 20123;//发送删除抵押的物品后,给客户端显示

  CM_CHALLENGECANCEL = 20124;//玩家取消挑战
  SM_CHALLENGECANCEL = 20125;//玩家取消挑战

  CM_CHALLENGECHGGOLD = 20126; //客户端把金币放到挑战框中
  SM_CHALLENCHGGOLD_FAIL = 20127; //客户端把金币放到挑战框中失败
  SM_CHALLENCHGGOLD_OK = 20128; //客户端把金币放到挑战框中成功
  SM_CHALLENREMOTECHGGOLD = 20129; //客户端把金币放到挑战框中,给客户端显示

  CM_CHALLENGECHGDIAMOND = 20130; //客户端把金刚石放到挑战框中
  SM_CHALLENCHGDIAMOND_FAIL = 20131; //客户端把金刚石放到挑战框中失败
  SM_CHALLENCHGDIAMOND_OK = 20132; //客户端把金刚石放到挑战框中成功
  SM_CHALLENREMOTECHGDIAMOND = 20133; //客户端把金刚石放到挑战框中,给客户端显示

  CM_CHALLENGEEND = 20134;//挑战抵押物品结束
  SM_CLOSECHALLENGE = 20135;//关闭挑战抵押物品窗口
//----------------------------------------------------------------------------
  RM_PLAYMAKEWINEABILITY = 20136;//酒2相关属性 20080804
  SM_PLAYMAKEWINEABILITY = 20137;//酒2相关属性 20080804
  RM_HEROMAKEWINEABILITY = 20138;//酒2相关属性 20080804
  SM_HEROMAKEWINEABILITY = 20139;//酒2相关属性 20080804

  RM_CANEXPLORATION = 20140;//可探索 20080810
  SM_CANEXPLORATION = 20141;//可探索 20080810
//----------------------------------------------------------------------------
  SM_SENDLOGINKEY = 20142; //网关给客户端或登陆器发送登陆器封包码 20080901
  SM_GATEPASS_FAIL = 20143; //和网关的密码错误

  RM_HEROMAGIC68SKILLEXP = 20144;//英雄酒气护体技能经验  20080925
  SM_HEROMAGIC68SKILLEXP = 20145;//英雄酒气护体技能经验  20080925

  RM_USERBIGSTORAGEITEM = 20146;//用户无限仓库项目
  RM_USERBIGGETBACKITEM = 20147;//用户获得回的无限仓库项目
  RM_USERLEVELORDER = 20148;//用户等级命令

  RM_HEROAUTOOPENDEFENCE = 20149;//英雄内挂自动持续开盾 20080930
  SM_HEROAUTOOPENDEFENCE = 20150;//英雄内挂自动持续开盾 20080930
  CM_HEROAUTOOPENDEFENCE = 20151;//英雄内挂自动持续开盾 20080930

  RM_MAGIC69SKILLEXP = 20152;//内功心法经验
  SM_MAGIC69SKILLEXP = 20153;//内功心法经验
  RM_HEROMAGIC69SKILLEXP = 20154;//英雄内功心法经验  20080930
  SM_HEROMAGIC69SKILLEXP = 20155;//英雄内功心法经验  20080930

  RM_MAGIC69SKILLNH = 20156;//内力值(黄条) 20081002
  SM_MAGIC69SKILLNH = 20157;//内力值(黄条) 20081002
  {RM_HEROMAGIC69SKILLNH = 20158;//英雄内力值(黄条) 20081002
  SM_HEROMAGIC69SKILLNH = 20159;//英雄内力值(黄条) 20081002  }
  RM_WINNHEXP = 20158;//取得内功经验 20081007
  SM_WINNHEXP = 20159;//取得内功经验 20081007
  RM_HEROWINNHEXP = 20160;//英雄取得内功经验 20081007
  SM_HEROWINNHEXP = 20161;//英雄取得内功经验 20081007
  ////////////////////////////////////////////////////////////////////////////////
  UNITX = 48;
  UNITY = 32;
  HALFX = 24;
  HALFY = 16;
  //MAXBAGITEM = 46; //用户背包最大数量
  MAXMAGIC = 20; //原来54;
  MAXSTORAGEITEM = 50;
  LOGICALMAPUNIT = 40;
type
  TMonStatus = (s_KillHuman, s_UnderFire, s_Die, s_MonGen);
  TMsgColor = (c_Red, c_Green, c_Blue, c_White, c_Fuchsia{千里传音颜色},BB_Fuchsia{宝宝相关提示},C_HeroHint{英雄状态});
  TMsgType = (t_Notice{公告}, t_Hint{暗示}, t_System{系统}, t_Say, t_Mon, t_GM, t_Cust, t_Castle{城堡});
  //  TSayMsgType = (s_NoneMsg,s_GroupMsg,s_GuildMsg,s_SystemMsg,s_NoticeMsg); clWindowText
  TDefaultMessage = record
    Recog: Integer;//识别码
    Ident: Word;
    Param: Word;
    Tag: Word;
    Series: Word;
  end;
  pTDefaultMessage = ^TDefaultMessage;

  TItemType = (i_HPDurg,i_MPDurg,i_HPMPDurg,i_OtherDurg,i_Weapon,i_Dress,i_Helmet,i_Necklace,i_Armring,i_Ring,i_Belt,i_Boots,i_Charm,i_Book,i_PosionDurg,i_UseItem,i_Scroll,i_Stone,i_Gold,i_Other);
                              //  [药品] [武器]      [衣服]    [头盔][项链]     [手镯]      [戒指] [腰带] [鞋子] [宝石]         [技能书][毒药]        [消耗品][其它]
  TShowItem = record
    sItemName    :String;
   // ItemType     :TItemType;
    boAutoPickup :Boolean;
    boShowName   :Boolean;
    //nFColor      :Integer;
    //nBColor      :Integer;
  end;
  pTShowItem = ^TShowItem;


  TOSObject = record
    btType: Byte;
    CellObj: TObject;
    dwAddTime: LongWord;
    boObjectDisPose: Boolean;
  end;
  pTOSObject = ^TOSObject;

  TSendMessage = record
    wIdent: Word;
    wParam: Word;
    nParam1: Integer;
    nParam2: Integer;
    nParam3: Integer;
    BaseObject: TObject;
    dwAddTime: LongWord;
    dwDeliveryTime: LongWord;
    boLateDelivery: Boolean;
    Buff: PChar;
  end;
  pTSendMessage = ^TSendMessage;

  TProcessMessage = record
    wIdent: Word;
    wParam: Word;
    nParam1: Integer;
    nParam2: Integer;
    nParam3: Integer;
    BaseObject: TObject;
    boLateDelivery: Boolean;
    dwDeliveryTime: LongWord;
    sMsg: string;
  end;
  pTProcessMessage = ^TProcessMessage;

  TLoadHuman = record
    sAccount: string[12];
    sChrName: string[ACTORNAMELEN]; //14
    sUserAddr: string[15];
    nSessionID: Integer;
  end;

  TShortMessage = record
    Ident: Word;
    wMsg: Word;
  end;

  TMessageBodyW = record
    Param1: Word;
    Param2: Word;
    Tag1: Word;
    Tag2: Word;
  end;

  TMessageBodyWL = record
    lParam1: Integer;
    lParam2: Integer;
    lTag1: Integer;
    lTag2: Integer;
  end;

  TCharDesc = record
    feature: Integer;
    Status: Integer;
  end;

  TSessInfo = record //全局会话
    sAccount: string[12];
    sIPaddr: string[15];
    nSessionID: Integer;
    nPayMent: Integer;
    nPayMode: Integer;
    nSessionStatus: Integer;
    dwStartTick: LongWord;
    dwActiveTick: LongWord;
    nRefCount: Integer;
  end;
  pTSessInfo = ^TSessInfo;

  TQuestInfo = record
    wFlag: Word;
    btValue: Byte;
    nRandRage: Integer;
  end;
  pTQuestInfo = ^TQuestInfo;

  TScript = record
    boQuest: Boolean;
    QuestInfo: array[0..9] of TQuestInfo;
    nQuest: Integer;
    RecordList: TList;
  end;
  pTScript = ^TScript;

  TMonItem = record
    n00: Integer;
    n04: Integer;
    sMonName: string;
    n18: Integer;
  end;
  pTMonItem = ^TMonItem;

  TItemName = record
    nItemIndex: Integer;
    nMakeIndex: Integer;
    sItemName: string;
  end;
  pTItemName = ^TItemName;

  TVarType = (vNone, vInteger, vString);

  TDynamicVar = record
    sName: string;
    VarType: TVarType;
    nInternet: Integer;
    sString: string;
  end;
  pTDynamicVar = ^TDynamicVar;

  TRecallMigic = record
    nHumLevel: Integer;
    sMonName: string;
    nCount: Integer;
    nLevel: Integer;
  end;

  TMonSayMsg = record
    nRate: Integer;
    sSayMsg: string;
    State: TMonStatus;
    Color: TMsgColor;
  end;
  pTMonSayMsg = ^TMonSayMsg;

  TMonDrop = record
    sItemName: string;
    nDropCount: Integer;
    nNoDropCount: Integer;
    nCountLimit: Integer;
  end;
  pTMonDrop = ^TMonDrop;

  TGameCmd = record
    sCmd: string[25];
    nPermissionMin: Integer;
    nPermissionMax: Integer;
  end;
  pTGameCmd = ^TGameCmd;

  TIPAddr = record
    dIPaddr: string[15];
    sIPaddr: string[15];
  end;
  pTIPAddr = ^TIPAddr;

  TSrvNetInfo = record
    sIPaddr: string[15];
    nPort: Integer;
  end;
  pTSrvNetInfo = ^TSrvNetInfo;

  TCheckCode = record
  end;

  TStdItem = packed record
    Name: string[14];//物品名称
    StdMode: Byte; //物品分类 0/1/2/3：药， 5/6:武器，10/11：盔甲，15：头盔，22/23：戒指，24/26：手镯，19/20/21：项链
    Shape: Byte;//装配外观
    Weight: Byte;//重量
    AniCount: Byte;
    Source: ShortInt;//源动力
    Reserved: Byte; //保留
    NeedIdentify: Byte; //需要记录日志
    Looks: Word; //外观，即Items.WIL中的图片索引
    DuraMax: Word; //最大持久
    Reserved1: Word;//发光属性
    AC: Integer; //0x1A
    MAC: Integer; //0x1C
    DC: Integer; //0x1E
    MC: Integer; //0x20
    SC: Integer; //0x22
    Need: Integer; //0x24
    NeedLevel: Integer; //0x25
    Price: Integer; //价格
    //Stock: Integer;//库存 20080610
    //sDesc:string[80];//物品说明 20080619
  end;
  pTStdItem = ^TStdItem;

  TOStdItem = packed record //OK
    Name: string[14];
    StdMode: Byte;
    Shape: Byte;
    Weight: Byte;
    AniCount: Byte;
    Source: ShortInt;
    Reserved: Byte;
    NeedIdentify: Byte;
    Looks: Word;
    DuraMax: Word;
    AC: Word;
    MAC: Word;
    DC: Word;
    MC: Word;
    SC: Word;
    Need: Byte;
    NeedLevel: Byte;
    w26: Word;
    Price: Integer;
  end;
  pTOStdItem = ^TOStdItem;

  TOClientItem = record //OK
    s: TOStdItem;
    MakeIndex: Integer;
    Dura: Word;
    DuraMax: Word;
  end;
  pTOClientItem = ^TOClientItem;

  TClientItem = record //OK
    s: TStdItem;
    MakeIndex: Integer;
    Dura: Word;
    DuraMax: Word;
  end;
  PTClientItem = ^TClientItem;

  TMonInfo = record
    sName: string[14];//怪物名
    btRace: Byte;//种族
    btRaceImg: Byte;//种族图像
    wAppr: Word;//形像代码
    wLevel: Word;
    btLifeAttrib: Byte;//不死系
    boUndead: Boolean;
    wCoolEye: Word;//视线范围
    dwExp: LongWord;
    wMP: Word;
    wHP: Word;
    wAC: Word;
    wMAC: Word;
    wDC: Word;
    wMaxDC: Word;
    wMC: Word;
    wSC: Word;
    wSpeed: Word;
    wHitPoint: Word;//命中率
    wWalkSpeed: Word;//行走速度
    wWalkStep: Word;//行走步伐
    wWalkWait: Word;//行走等待
    wAttackSpeed: Word;//攻击速度
    ItemList: TList;
  end;
  pTMonInfo = ^TMonInfo;

  TMagic = record //技能类
    wMagicId: Word;//技能ID
    sMagicName: string[12];//技能名称
    btEffectType: Byte;//动作效果
    btEffect: Byte;//魔法效果
    bt11: Byte;//未使用 20080531
    wSpell: Word;//魔法消耗
    wPower: Word;//基本威力
    TrainLevel: array[0..3] of Byte;//技能等级
    w02: Word;//未使用 20080531
    MaxTrain: array[0..3] of Integer;//各技能等级最高修炼点
    btTrainLv: Byte;//修炼等级
    btJob: Byte;//职业 0-战 1-法 2-道 3-刺客
    wMagicIdx: Word;//未使用 20080531
    dwDelayTime: LongWord;//技能延时
    btDefSpell: Byte;//升级魔法
    btDefPower: Byte;//升级威力
    wMaxPower: Word;//最大威力
    btDefMaxPower: Byte;//升级最大威力
    sDescr: string[18];//备注说明
  end;
  pTMagic = ^TMagic;

  TClientMagic = record //84
    Key: Char;
    Level: Byte;
    CurTrain: Integer;
    Def: TMagic;
  end;
  PTClientMagic = ^TClientMagic;

  TShopInfo = record//商铺物品
    StdItem: TSTDITEM;
    sIntroduce:array [0..200] of Char;
    Idx: string[1];
    ImgBegin: string[5];
    Imgend: string[5];
    Introduce1:string[20];
  end;
  pTShopInfo = ^TShopInfo;

  TUserMagic = record
    MagicInfo: pTMagic;
    wMagIdx: Word;//技能ID
    btLevel: Byte;//等级
    btKey: Byte;//技能快捷键
    nTranPoint: Integer;//当前修练值
  end;
  pTUserMagic = ^TUserMagic;

  TMinMap = record
    sName: string;
    nID: Integer;
  end;
  pTMinMap = ^TMinMap;

  TMapRoute = record
    sSMapNO: string;
    nDMapX: Integer;
    nSMapY: Integer;
    sDMapNO: string;
    nSMapX: Integer;
    nDMapY: Integer;
  end;
  pTMapRoute = ^TMapRoute;

  TMapInfo = record
    sName: string;
    sMapNO: string;
    nL: Integer; //0x10
    nServerIndex: Integer; //0x24
    nNEEDONOFFFlag: Integer; //0x28
    boNEEDONOFFFlag: Boolean; //0x2C
    sShowName: string; //0x4C
    sReConnectMap: string; //0x50
    boSAFE: Boolean; //0x51
    boDARK: Boolean; //0x52
    boFIGHT: Boolean; //0x53
    boFIGHT3: Boolean; //0x54
    boDAY: Boolean; //0x55
    boQUIZ: Boolean; //0x56
    boNORECONNECT: Boolean; //0x57
    boNEEDHOLE: Boolean; //0x58
    boNORECALL: Boolean; //0x59
    boNORANDOMMOVE: Boolean; //0x5A
    boNODRUG: Boolean; //0x5B
    boMINE: Boolean; //0x5C
    boNOPOSITIONMOVE: Boolean; //0x5D
  end;
  pTMapInfo = ^TMapInfo;

  TUnbindInfo = record
    nUnbindCode: Integer;
    sItemName: string[14];
  end;
  pTUnbindInfo = ^TUnbindInfo;

  TQuestDiaryInfo = record
    QDDinfoList: TList;
  end;
  pTQuestDiaryInfo = ^TQuestDiaryInfo;

  TAdminInfo = record //管理员表
    nLv: Integer;
    sChrName: string[ACTORNAMELEN];
    sIPaddr: string[15];
  end;
  pTAdminInfo = ^TAdminInfo;

  TMasterList = record //徒弟数量排行  20080530
    ID:integer;//排名
    sChrName: string[ACTORNAMELEN];//徒弟名
  end;
  pTMasterList = ^TMasterList;

  THumMagic = record //人物技能  20080106
    wMagIdx: Word;//技能ID
    btLevel: Byte;//等级
    btKey: Byte;//技能快捷键
    nTranPoint: Integer; //当前修练值
  end;
  pTHumMagic = ^THumMagic;

  TNakedAbility = packed record //Size 20
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
  pTNakedAbility = ^TNakedAbility;

  TAbility = packed record//Size 40
    Level: Word; //
    AC: Integer; //防御
    MAC: Integer; //魔防
    DC: Integer; //攻击力
    MC: Integer; //魔法
    SC: Integer; //道术
    HP: Word; //
    MP: Word; //
    MaxHP: Word; //
    MaxMP: Word; //
    Exp: LongWord; //
    MaxExp: LongWord; //
    Weight: Word; //
    MaxWeight: Word; // 背包
    WearWeight: Word; //
    MaxWearWeight: Word; //负重
    HandWeight: Word; //
    MaxHandWeight: Word; //腕力
    Alcohol:Word;//酒量 20080622
    MaxAlcohol:Word;//酒量上限 20080622
    WineDrinkValue: Word;//醉酒度 20080623
    MedicineValue: Word;//当前药力值 20080623
    MaxMedicineValue: Word;//药力值上限 20080623
  end;
  pTAbility = ^TAbility;

  TOAbility = packed record
    Level: Word; //等级
    AC: Word;
    MAC: Word;
    DC: Word;
    MC: Word;
    SC: Word;
    HP: Word;
    MP: Word;
    MaxHP: Word;
    MaxMP: Word;
    {btReserved1: Byte;//20081001 注释
    btReserved2: Byte;
    btReserved3: Byte;
    btReserved4: Byte;}
    NG: Word;//20081001 当前内力值
    MaxNG: Word;//20081001 内力值上限
    Exp: LongWord;//当前经验
    MaxExp: LongWord;//升级经验
    Weight: Word;
    MaxWeight: Word; //最大重量
    WearWeight: Byte;
    MaxWearWeight: Byte; //最大负重
    HandWeight: Byte;
    MaxHandWeight: Byte; //腕力
  end;
  pTOAbility = ^TOAbility;

  TAddAbility = record //OK    //Size 40
    wHP: Word;
    wMP: Word;
    wHitPoint: Word;
    wSpeedPoint: Word;
    wAC: Integer;//防御
    wMAC: Integer;//魔御
    wDC: Integer;
    wMC: Integer;
    wSC: Integer;
    bt1DF: Byte; //神圣
    bt035: Byte;
    wAntiPoison: Word;
    wPoisonRecover: Word;
    wHealthRecover: Word;
    wSpellRecover: Word;
    wAntiMagic: Word;
    btLuck: Byte;//幸运
    btUnLuck: Byte;//诅咒
    nHitSpeed: Integer;
    btWeaponStrong: Byte;//强度
    wWearWeight: Word;//负重 20080325
  end;
  pTAddAbility = ^TAddAbility;

  TWAbility = record
    dwExp: LongWord; //怪物经验值(Dword)
    wHP: Word;
    wMP: Word;
    wMaxHP: Word;
    wMaxMP: Word
  end;

  TMerchantInfo = record
    sScript: string[14];
    sMapName: string[14];
    nX: Integer;
    nY: Integer;
    sNPCName: string[40];
    nFace: Integer;
    nBody: Integer;
    boCastle: Boolean;
  end;
  pTMerchantInfo = ^TMerchantInfo;

  TSocketBuff = record
    Buffer: PChar; //0x24
    nLen: Integer; //0x28
  end;
  pTSocketBuff = ^TSocketBuff;

  TSendBuff = record
    nLen: Integer;
    Buffer: array[0..DATA_BUFSIZE - 1] of Char;
  end;
  pTSendBuff = ^TSendBuff;

  TUserItem = record // 20080313 修改
    MakeIndex: Integer;
    wIndex: Word; //物品id
    Dura: Word; //当前持久值
    DuraMax: Word; //最大持久值
    btValue: array[0..20] of Byte;//附加属性:9-(升级次数)装备等级 12-发光(1为发光,0不发光,2聚灵珠不能聚集),13-自定义名称,14-禁止扔,15-禁止交易,16-禁止存,17-禁止修,18-禁止出售,19-禁止爆出 20-吸伤(聚灵珠,1-开始聚经验,2-聚结束)
  end ;                           //11-未使用 8-神秘物品 10-武器升级设置(1-破碎 10-12增加DC, 20-22增加MC，30-32增加SC)
  pTUserItem = ^TUserItem;
 //(戒指)          0 AC2 防御  1 MAC2 魔御 2 DC2 攻击 3 MC2 魔法 4 SC2 道术 6 佩带需求 7 佩带级别 8 Reserved 9-13 暂不知道 14 持久
 //(武器)          0 DC2 1 MC2 2 SC2 3 幸运 4 诅咒 5 准确 6 攻击速度 7 强度 8-9 暂不知道 10 需开封 11-13 暂不知道 14 持久
 //(衣服,靴子,腰带)0 防御 1 魔御 2 攻击 3 魔法 4 道术 5-13 无效果 14 持久
 //(头盔)          0 防御 1 魔御 2 攻击 3 魔法 4 道术 5 佩带需求 6 佩带级别 7-13 无效果 14 持久
 //(项链,手镯)     0 AC2 1 MAC2 2 DC2 3 MC2 4 SC2 6 佩带需求 7 佩带级别 8 Reserved 9-13 暂不知道 14 持久
 //酒              0 品质 1 酒精度 2 药力值
 //酿酒材料        0 品质
  TMonItemInfo = record //怪物爆物品类(MonItems目录下,怪名.txt)
    SelPoint: Integer;//出现点数
    MaxPoint: Integer;//总点数
    ItemName: string;//物品名称
    Count: Integer;//物品数量
  end;
  pTMonItemInfo = ^TMonItemInfo;

  TMonsterInfo = record
    Name: string;
    ItemList: TList;
  end;
  PTMonsterInfo = ^TMonsterInfo;

  TMapItem = record //地图物品
    Name: string;//名称
    Looks: Word; //外观
    AniCount: Byte;
    Reserved: Byte;
    Count: Integer;//数量
    OfBaseObject: TObject;//物品谁可以捡起
    DropBaseObject: TObject;//谁掉落的
    dwCanPickUpTick: LongWord;
    UserItem: TUserItem;
  end;
  PTMapItem = ^TMapItem;

  TVisibleMapItem = record //可见的地图物品
    {wIdent: Word;
    nParam1: Integer;
    Buff: PChar;}
    MapItem: PTMapItem;
    nVisibleFlag: Integer;
    nX: Integer;
    nY: Integer;
    sName: string;
    wLooks: Word;
  end;
  pTVisibleMapItem = ^TVisibleMapItem;

  TVisibleMapEvent = record
    MapEvent: TObject;
    nVisibleFlag: Integer;
    nX: Integer;
    nY: Integer;
  end;
  pTVisibleMapEvent = ^TVisibleMapEvent;

  TVisibleBaseObject = record
    BaseObject: TObject;
    nVisibleFlag: Integer;
  end;
  pTVisibleBaseObject = ^TVisibleBaseObject;

  THumanRcd = record
    sUserID: string[10];
    sCharName: string[14];
    btJob: Byte;
    btGender: Byte;
    btLevel: Byte;
    btHair: Byte;
    sMapName: string[16];
    btAttackMode: Byte;
    btIsAdmin: Byte;
    nX: Integer;
    nY: Integer;
    nGold: Integer;
    dwExp: LongWord;
  end;
  pTHumanRcd = ^THumanRcd;

  TObjectFeature = record
    btGender: Byte;
    btWear: Byte;
    btHair: Byte;
    btWeapon: Byte;
  end;
  pTObjectFeature = ^TObjectFeature;

  TStatusInfo = record
    nStatus: Integer;
    dwStatusTime: LongWord;
    sm218: SmallInt;
    dwTime220: LongWord;
  end;

  TMsgHeader = record
    dwCode: LongWord;
    nSocket: Integer;
    wGSocketIdx: Word;
    wIdent: Word;
    wUserListIndex: Integer;
    nLength: Integer;
  end;
  pTMsgHeader = ^TMsgHeader;

  TUserInfo = record
    bo00: Boolean; //0x00
    bo01: Boolean; //0x01 ?
    bo02: Boolean; //0x02 ?
    bo03: Boolean; //0x03 ?
    n04: Integer; //0x0A ?
    n08: Integer; //0x0B ?
    bo0C: Boolean; //0x0C ?
    bo0D: Boolean; //0x0D
    bo0E: Boolean; //0x0E ?
    bo0F: Boolean; //0x0F ?
    n10: Integer; //0x10 ?
    n14: Integer; //0x14 ?
    n18: Integer; //0x18 ?
    sStr: string[20]; //0x1C
    nSocket: Integer; //0x34
    nGateIndex: Integer; //0x38
    n3C: Integer; //0x3C
    n40: Integer; //0x40 ?
    n44: Integer; //0x44
    List48: TList; //0x48
    Cert: TObject; //0x4C
    dwTime50: LongWord; //0x50
    bo54: Boolean; //0x54
  end;
  pTUserInfo = ^TUserInfo;

  TGlobaSessionInfo = record
    sAccount: string;
    sIPaddr: string;
    nSessionID: Integer;
    n24: Integer;
    bo28: Boolean;
    boLoadRcd: Boolean;
    boStartPlay: Boolean;
    dwAddTick: LongWord;
    dAddDate: TDateTime;
  end;
  pTGlobaSessionInfo = ^TGlobaSessionInfo;

  TUserStateInfo = record
    feature: Integer;
    UserName: string[ACTORNAMELEN];
    NAMECOLOR: Integer;
    GuildName: string[ACTORNAMELEN];
    GuildRankName: string[16];
    UseItems: array[0..13] of TClientItem;//20080417 支持斗笠,0..12改0..13
  end;
  pTUserStateInfo = ^TUserStateInfo;

  TSellOffHeader = record
    nItemCount: Integer;
  end;
//------------------------------------------------------------------------------
  TBoxsInfo = record //宝箱数据结构
    SBoxsID:Integer;//箱子文件
    nItemNum: Integer;//物品数量
    nItemType: Integer;//物品类型
    OpenBox: Boolean;//是否开启多次(1为开启)
    nGold: Integer;//起始金币
    nGameGold: Integer;//起始元宝(游戏币)
    nIncGold: Integer;//累增金币
    nIncGameGold: Integer;//累增元宝(游戏币)
    nEffectiveGold: Integer;//有效金币数
    nEffectiveGameGold: Integer;//有效元宝(游戏币)数
    nUses: Integer;//最多允许使用转盘次数
    StdItem: TClientItem;
  end;
  pTBoxsInfo = ^TBoxsInfo;
//------------------------------------------------------------------------------
  TSuitItem = packed record //套装数据结构  20080225
    ItemCount: Byte; //套装物品数量
    Note: String[30];//说明
    Name: String;//物品名称
    MaxHP: Word;//HP上限
    MaxMP: Word;//MP上限
    DC: Word;//攻击力
    MaxDC: Word;
    MC: Word;//魔法
    MaxMC: Word;
    SC: Word;//道术
    MaxSC: Word;
    AC: Integer; //防御
    MaxAC: Integer;
    MAC: Word; //魔防
    MaxMAC: Word;
    HitPoint: Byte;//准确度
    SpeedPoint: Byte;//敏捷度
    HealthRecover: ShortInt; //体力恢复
    SpellRecover: ShortInt; //魔法恢复
    RiskRate: Integer; //爆率机率
    btReserved: Byte; //吸血(虹吸)
    btReserved1: Byte; //保留
    btReserved2: Byte; //保留
    btReserved3: Byte; //保留
    nEXPRATE: Integer;//经验倍数
    nPowerRate: Byte;//攻击倍数
    nMagicRate: Byte;//魔法倍数
    nSCRate: Byte;//道术倍数
    nACRate: Byte;//防御倍数
    nMACRate: Byte;//魔御倍数
    nAntiMagic: ShortInt; //魔法躲避
    nAntiPoison: Byte; //毒物躲避
    nPoisonRecover: ShortInt; //中毒恢复

    boTeleport : Boolean;//传送  20080824
    boParalysis : Boolean;//麻痹
    boRevival : Boolean;//复活
    boMagicShield : Boolean;//护身
    boUnParalysis : Boolean;//防麻痹
  end;
  pTSuitItem = ^TSuitItem;
//------------------------------------------------------------------------------
  TDealOffInfo = packed record //   元宝寄售数据结构  20080316
    sDealCharName: string[ACTORNAMELEN];//寄售人
    sBuyCharName: string[ACTORNAMELEN];//购买人
    dSellDateTime: TDateTime;//寄售时间
    nSellGold: Integer;//交易的元宝数
    UseItems: array[0..9] of TUserItem;//物品
    N: Byte;//交易识标 0-正常 1-购买,但寄售人未得到元宝 2-购买人取消 3-交易结束(得到元宝) 4-正在操作中
  end;
  pTDealOffInfo = ^TDealOffInfo;

  TClientDealOffInfo = packed record //   客户端元宝寄售数据结构  20080317
    sDealCharName: string[ACTORNAMELEN];//寄售人
    sBuyCharName: string[ACTORNAMELEN];//购买人
    dSellDateTime: TDateTime;//寄售时间
    nSellGold: Integer;//交易的元宝数
    UseItems: array[0..9] of TClientItem;//物品
    N: Byte;//交易识标
  end;
  pTClientDealOffInfo = ^TClientDealOffInfo;
//------------------------------------------------------------------------------
  TAttribute = record //淬炼极品属性
    nPoints: Byte;//最高限制升点数
    nDifficult: Byte;//淬炼难度
  end;

  TRefineItemInfo = packed record //Size 36 淬炼数据结构  20080502
    sItemName: string;//物品名称
    nRefineRate: Byte;//淬炼成功率
    nReductionRate: Byte;//失败还原率
    boDisappear: Boolean;//火云石是否消失 0-减少1持久,1-消失
    nNeedRate: Byte;//极品机率
    nAttribute: array[0..13] of TAttribute;//淬炼极品属性
  end;
  pTRefineItemInfo = ^TRefineItemInfo;
//------------------------------------------------------------------------------
  TSellOffInfo = packed record //Size 59    拍卖数据结构
    sCharName: string[ACTORNAMELEN];//拍卖人
    dSellDateTime: TDateTime;//时间
    nSellGold: Integer;
    N: Integer;
    UseItems: TUserItem;
    n1: Integer;
  end;
  pTSellOffInfo = ^TSellOffInfo;

  TItemCount = Integer;

  TBigStorage = packed record //无限仓库数据结构
    boDelete: Boolean;
    sCharName: string[ACTORNAMELEN];
    SaveDateTime: TDateTime;
    UseItems: TUserItem;
    nCount: Integer;
  end;
  pTBigStorage = ^TBigStorage;

  TBindItem = record //解包物品类
    sUnbindItemName: string[ACTORNAMELEN];//解包物品名称
    nStdMode: Integer;//物品分类
    nShape: Integer;//装配外观
    btItemType: Byte;//分类
  end;
  pTBindItem = ^TBindItem;

  TOUserStateInfo = packed record //OK
    feature: Integer;
    UserName: string[15]; // 15
    GuildName: string[14]; //14
    GuildRankName: string[16]; //15
    NAMECOLOR: Word;
    UseItems: array[0..8] of TOClientItem;
  end;

  TIDRecordHeader = packed record
    boDeleted: Boolean;
    bt1: Byte;
    bt2: Byte;
    bt3: Byte;
    CreateDate: TDateTime;
    UpdateDate: TDateTime;
    sAccount: string[11];
  end;

  TRecordHeader = packed record //Size 12
    boDeleted: Boolean; //是否删除
    nSelectID: Byte;   //ID
    boIsHero: Boolean; //是否英雄
    bt2: Byte;
    dCreateDate: TDateTime; //最后登录时间
    sName: string[15]; //角色名称   28
  end;
  pTRecordHeader = ^TRecordHeader;

  TUnKnow = array[0..39] of Byte;
  //TQuestUnit = array[0..127] of Byte; //未使用 20080329
  TQuestFlag = array[0..127] of Byte;
  TStatusTime = array[0..MAX_STATUS_ATTRIBUTE - 1] of Word;

  THumItems = array[0..8] of TUserItem;//9格装备 
  THumAddItems = array[9..13] of TUserItem;//新增4格装备 扩展支持斗笠 20080416
  TBagItems = array[0..45] of TUserItem;//包裹物品
  TStorageItems = array[0..45] of TUserItem;
  THumMagics = array[0..19] of THumMagic;//人物技能
  THumNGMagics = array[0..19] of THumMagic;//内功技能 20081001
  THumanUseItems = array[0..13] of TUserItem;//扩展支持斗笠 20080416
  //THeroItems = array[0..12] of TUserItem;//未使用 20080416
  //THeroBagItems = array[0..40 - 1] of TUserItem;//20081001 注释
  PTPLAYUSEITEMS = ^THumanUseItems;

  //pTHeroItems = ^THeroItems;//未使用 20080416
  pTHumItems = ^THumItems;
  pTBagItems = ^TBagItems;
  pTStorageItems = ^TStorageItems;
  pTHumAddItems = ^THumAddItems;
  pTHumMagics = ^THumMagics;
  pTHumNGMagics = ^THumNGMagics;//内功技能 20081001
  //pTHeroBagItems = ^THeroBagItems; //20081001 注释

{  pTHeroData = ^THeroData; //20081001 注释
  THeroData = packed record //Size = 1514-40  英雄数据
    sChrName: string[ACTORNAMELEN];//英雄名字
    btHair: Byte;//头发
    btSex: Byte;//性别
    btJob: Byte;//职业 0-战 1-法 2-道 3-刺客
    Abil: TOAbility; //+40
    //wStatusTimeArr: TStatusTime; //+24
    btReLevel: Byte; //转生等级
    btCreditPoint: Byte;//声望点
    nBagItemCount: Integer;//包裹物品数量
    nPKPOINT: Integer;//PK点数

    btStatus: Byte; //状态
    boProtectStatus: Boolean; //是否是守护状态
    nProtectTargetX: Integer; //守护坐标
    nProtectTargetY: Integer; //守护坐标

    UnKnow: array[0..9] of Byte;
    HumItems: THumanUseItems; //12格装备 衣服  武器  蜡烛 头盔 项链 手镯 手镯 戒指 戒指
    BagItems: THeroBagItems; //包裹装备
    HumMagics: THumMagics; //魔法
  end; }

  pTHumData = ^THumData;
  THumData = packed record {人物数据类 Size = 4286 预留N个变量}
    sChrName: string[ACTORNAMELEN];//姓名
    sCurMap: string[MAPNAMELEN];//地图
    wCurX: Word; //坐标X
    wCurY: Word; //坐标Y
    btDir: Byte; //方向
    btHair: Byte;//头发
    btSex: Byte; //性别
    btJob: Byte;//职业 0-战 1-法 2-道 3-刺客
    nGold: Integer;//金币数
    Abil: TOAbility;//+40 人物其它属性
    wStatusTimeArr: TStatusTime; //+24 人物状态属性值，一般是持续多少秒
    sHomeMap: string[MAPNAMELEN];//Home 家
    btUnKnow1: Byte;//(20080404 未使用)
    wHomeX: Word;//Home X
    wHomeY: Word;//Home Y
    sDearName: string[ACTORNAMELEN]; //别名(配偶)
    sMasterName: string[ACTORNAMELEN];//师傅名字
    boMaster: Boolean;//是否有徒弟
    btCreditPoint: Integer;//声望点 20080118
    btDivorce: Byte; //是否结婚
    btMarryCount: Byte; //结婚次数
    sStoragePwd: string[7];//仓库密码
    btReLevel: Byte;//转生等级
    btUnKnow2: array[0..2] of Byte;//0-是否开通元宝寄售(1-开通) 1-是否寄存英雄(1-存有英雄) 2-饮酒时酒的品质
    BonusAbil: TNakedAbility; //+20 奖金
    nBonusPoint: Integer;//奖励点
    nGameGold: Integer;//游戏币
    nGameDiaMond: Integer;//金刚石 20071226
    nGameGird:Integer;//灵符 20071226
    nGamePoint: Integer;//声望
    btGameGlory: Byte; //荣誉 20080511
    nPayMentPoint: Integer; //充值点
    nLoyal: Integer;//英雄的忠诚度(20080109)
    nPKPOINT: Integer;//PK点数
    btAllowGroup: Byte;//允许组队
    btF9: Byte;
    btAttatckMode: Byte;//攻击模式
    btIncHealth: Byte;//增加健康数
    btIncSpell: Byte;//增加攻击点
    btIncHealing: Byte;//增加治愈点
    btFightZoneDieCount: Byte;//在行会占争地图中死亡次数
    sAccount: string[10];//登录帐号
    btEE: Byte;//未使用
    btEF: Byte;//英雄类型 0-白日门英雄 1-卧龙英雄 20080514
    boLockLogon: Boolean;//是否锁定登陆
    wContribution: Word;//贡献值
    nHungerStatus: Integer;//饥饿状态
    boAllowGuildReCall: Boolean; //  是否允许行会合一
    wGroupRcallTime: Word; //队传送时间
    dBodyLuck: Double; //幸运度  8
    boAllowGroupReCall: Boolean; // 是否允许天地合一
    nEXPRATE: Integer; //经验倍数
    nExpTime: Integer; //经验倍数时间
    btLastOutStatus: Byte; //退出状态 1为死亡退出
    wMasterCount: Word; //出师徒弟数
    boHasHero: Boolean; //是否有白日门英雄
    boIsHero: Boolean; //是否是英雄
    btStatus: Byte; //状态
    sHeroChrName: string[ACTORNAMELEN];//英雄名称
    UnKnow: TUnKnow;//预留 array[0..39] of Byte; 0-3酿酒使用 20080620 4-饮酒时的度数 5-魔法盾等级 6-是否学过内功 7-内功等级
    QuestFlag: TQuestFlag; //脚本变量
    HumItems: THumItems; //9格装备 衣服  武器  蜡烛 头盔 项链 手镯 手镯 戒指 戒指
    BagItems: TBagItems; //包裹装备
    HumMagics: THumMagics; //魔法
    StorageItems: TStorageItems; //仓库物品
    HumAddItems: THumAddItems; //新增4格 护身符 腰带 鞋子 宝石
    n_WinExp: longWord;//累计经验 20081001
    n_UsesItemTick: Integer;//聚灵珠聚集时间 20080221
    nReserved: Integer; //酿酒的时间,即还有多长时间可以取回酒 20080620
    nReserved1: Integer; //当前药力值 20080623
    nReserved2: Integer; //药力值上限 20080623
    nReserved3: Integer; //使用药酒时间,计算长时间没使用药酒 20080623
    n_Reserved: Word;   //当前酒量值 20080622
    n_Reserved1: Word;  //酒量上限 20080622
    n_Reserved2: Word;  //当前醉酒度 20080623
    n_Reserved3: Word;  //药力值等级 20080623
    boReserved: Boolean; //是否请过酒 T-请过酒
    boReserved1: Boolean;//是否有卧龙英雄 20080519
    boReserved2: Boolean;//是否酿酒 T-正在酿酒 20080620

    boReserved3: Boolean;//人是否喝酒醉了 20080627
    m_GiveDate:Integer;//人物领取行会酒泉日期 20080625
    Exp68: LongWord;//酒气护体当前经验 20080625
    MaxExp68: LongWord;//酒气护体升级经验 20080625
    nExpSkill69: Integer;//内功当前经验 20080930
    HumNGMagics: THumNGMagics;//内功技能 20081001
    m_nReserved1: Word;//保留
    m_nReserved2: Word;//保留
    m_nReserved3: Word;//保留
    m_nReserved4: LongWord;//保留
    m_nReserved5: LongWord;//保留
    m_nReserved6: Integer;//保留
    m_nReserved7: Integer;//保留
  end;

  THumDataInfo = packed record //Size 4126
    Header: TRecordHeader;
    Data: THumData;
  end;
  pTHumDataInfo = ^THumDataInfo;

  THeroDataInfo = packed record //20080514 查询英雄数据
    sChrName: string[ACTORNAMELEN];//姓名
    Level: Word; //等级
    btSex: Byte; //性别
    btJob: Byte;//职业 0-战 1-法 2-道 3-刺客
    btType: Byte;//英雄类型 0-白日门英雄 1-卧龙英雄
  end;
  pTHeroDataInfo = ^THeroDataInfo;

  TSaveRcd = record
    sAccount: string[12];
    sChrName: string[ACTORNAMELEN];
    nSessionID: Integer;
    nReTryCount: Integer;
    dwSaveTick: LongWord; //2006-11-12 增加 保存错误下次保存TICK
    PlayObject: TObject;
    HumanRcd: THumDataInfo;
    boIsHero: Boolean;
  end;
  pTSaveRcd = ^TSaveRcd;

  TLoadDBInfo = record
    sAccount: string[12];//账号
    sCharName: string[ACTORNAMELEN];//角色名称
    sIPaddr: string[15];//IP地址
    sMsg: string;
    nSessionID: Integer;
    nSoftVersionDate: Integer;//客户端版本号
    nPayMent: Integer;
    nPayMode: Integer;//玩家模式
    nSocket: Integer;//端口
    nGSocketIdx: Integer;
    nGateIdx: Integer;
    boClinetFlag: Boolean;
    dwNewUserTick: LongWord;
    PlayObject: TObject;
    nReLoadCount: Integer;
    boIsHero: Boolean;//是否英雄
    btLoadDBType: Byte;
  end;
  pTLoadDBInfo = ^TLoadDBInfo;

  TUserOpenInfo = record
    sAccount: string[12];
    sChrName: string[ACTORNAMELEN];
    LoadUser: TLoadDBInfo;
    HumanRcd: THumDataInfo;
    nOpenStatus: Integer;
  end;
  pTUserOpenInfo = ^TUserOpenInfo;

  TLoadUser = record
    sAccount: string[12];
    sChrName: string[ACTORNAMELEN];
    sIPaddr: string[15];
    nSessionID: Integer;
    nSocket: Integer;
    nGateIdx: Integer;
    nGSocketIdx: Integer;
    nPayMent: Integer;
    nPayMode: Integer;
    dwNewUserTick: LongWord;
    nSoftVersionDate: Integer;
  end;
  pTLoadUser = ^TLoadUser;

  TDoorStatus = record
    bo01: Boolean;
    boOpened: Boolean;
    dwOpenTick: LongWord;
    nRefCount: Integer;
    n04: Integer;
  end;
  pTDoorStatus = ^TDoorStatus;

  TDoorInfo = record
    nX: Integer;
    nY: Integer;
    n08: Integer;
    Status: pTDoorStatus;
  end;
  pTDoorInfo = ^TDoorInfo;

  TSlaveInfo = record
    sSalveName: string;
    btSalveLevel: Byte;
    btSlaveExpLevel: Byte;
    dwRoyaltySec: LongWord;
    nKillCount: Integer;
    nHP: Integer;
    nMP: Integer;
  end;
  pTSlaveInfo = ^TSlaveInfo;

  TSwitchDataInfo = record
    sChrName: string[ACTORNAMELEN];
    sMAP: string[MAPNAMELEN];
    wX: Word;
    wY: Word;
    Abil: TAbility;
    nCode: Integer;
    boC70: Boolean;
    boBanShout: Boolean;
    boHearWhisper: Boolean;
    boBanGuildChat: Boolean;
    boAdminMode: Boolean;
    boObMode: Boolean;
    BlockWhisperArr: array[0..5] of string;
    SlaveArr: array[0..10] of TSlaveInfo;
    StatusValue: array[0..5] of Word;
    StatusTimeOut: array[0..5] of LongWord;
  end;
  pTSwitchDataInfo = ^TSwitchDataInfo;

  TGoldChangeInfo = record
    sGameMasterName: string;
    sGetGoldUser: string;
    nGold: Integer;
  end;
  pTGoldChangeInfo = ^TGoldChangeInfo;

  TGateInfo = record
    Socket: TCustomWinSocket;
    boUsed: Boolean;
    sAddr: string[15];
    nPort: Integer;
    n520: Integer;
    UserList: TList;
    nUserCount: Integer; //连接人数
    Buffer: PChar;
    nBuffLen: Integer;
    BufferList: TList;
    boSendKeepAlive: Boolean;
    nSendChecked: Integer;
    nSendBlockCount: Integer;
    dwTime544: LongWord;
    nSendMsgCount: Integer;
    nSendRemainCount: Integer;
    dwSendTick: LongWord;
    nSendMsgBytes: Integer;
    nSendBytesCount: Integer;
    nSendedMsgCount: Integer;
    nSendCount: Integer;
    dwSendCheckTick: LongWord;
  end;
  pTGateInfo = ^TGateInfo;

  TStartPoint = record //安全区回城点 增加光环效果
    m_sMapName: string[MAPNAMELEN];
    m_nCurrX: Integer; //座标X(4字节)
    m_nCurrY: Integer; //座标Y(4字节)
    m_boNotAllowSay: Boolean;
    m_nRange: Integer;
    m_nType: Integer;//类型
    m_nPkZone: Integer;
    m_nPkFire: Integer;
    m_btShape: Byte;
  end;
  pTStartPoint = ^TStartPoint;

  //地图事件数据配置详解
  TQuestUnitStatus = record
    nQuestUnit: Integer;
    boOpen: Boolean;
  end;
  pTQuestUnitStatus = ^TQuestUnitStatus;

  TMapCondition = record
    nHumStatus: Integer;//人的状态
    sItemName: string[14];//物品
    boNeedGroup: Boolean;//是否需要组队
  end;
  pTMapCondition = ^TMapCondition;

  TStartScript = record
    nLable: Integer;
    sLable: string[100];
  end;

  TMapEvent = record
    m_sMapName: string[MAPNAMELEN];//地图
    m_nCurrX: Integer;//X
    m_nCurrY: Integer;//Y
    m_nRange: Integer;//范围
    m_MapFlag: TQuestUnitStatus;
    m_nRandomCount: Integer; //机率(0 - 999999) 0 的机率为100% ; 数字越大，机率越低
    m_Condition: TMapCondition; //触发条件
    m_StartScript: TStartScript;
  end;
  pTMapEvent = ^TMapEvent;

  TItemEvent = record
    m_sItemName: string[ACTORNAMELEN];
    m_nMakeIndex: Integer;
    m_sMapName: string[MAPNAMELEN];
    m_nCurrX: Integer;
    m_nCurrY: Integer;
  end;
  pTItemEvent = ^TItemEvent;

  TSendUserData = record
    nSocketIndx: Integer;
    nSocketHandle: Integer;
    sMsg: string;
  end;
  pTSendUserData = ^TSendUserData;

  TCheckVersion = record
  end;
  pTCheckVersion = ^TCheckVersion;

  TRecordDeletedHeader = packed record
    boDeleted: Boolean;
    bt1: Byte;
    bt2: Byte;
    bt3: Byte;
    CreateDate: TDateTime;
    LastLoginDate: TDateTime;
    n14: Integer;
    nNextDeletedIdx: Integer;
    //    sAccount   :String[11];//0x14
  end;

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
  TUserEntryAdd = packed record
    sQuiz2: string[20];//问题2
    sAnswer2: string[12];//答案2
    sBirthDay: string[10];//生日
    sMobilePhone: string[13];//移动电话
    sMemo: string[20];//备注一
    sMemo2: string[20];//备注二
  end;

  TAccountDBRecord = packed record
    Header: TIDRecordHeader;
    UserEntry: TUserEntry;
    UserEntryAdd: TUserEntryAdd;
    nErrorCount: Integer;
    dwActionTick: LongWord;
    N: array[0..38] of Byte;
  end;

  TMapFlag = record //地图参数
    boSAFE: Boolean;
    boDARK: Boolean;
    boFIGHT: Boolean;
    boFIGHT2: Boolean;//新PK地图，可以pk，但掉装备 20080525
    boFIGHT3: Boolean;
    boFIGHT4: Boolean;//挑战地图 20080706
    boDAY: Boolean;
    boQUIZ: Boolean;
    boNORECONNECT: Boolean;
    boMUSIC: Boolean;
    boEXPRATE: Boolean;
    boPKWINLEVEL: Boolean;
    boPKWINEXP: Boolean;
    boPKLOSTLEVEL: Boolean;
    boPKLOSTEXP: Boolean;
    boDECHP: Boolean;
    boINCHP: Boolean;
    boDECGAMEGOLD: Boolean;
    boDECGAMEPOINT: Boolean;//自动减游戏点
    boINCGAMEGOLD: Boolean;
    boINCGAMEPOINT: Boolean;//自动加游戏点
    boNoCALLHERO: Boolean;//禁止召唤英雄 20080124
    boNOHEROPROTECT: Boolean;//禁止英雄守护 20080629
    boNODROPITEM: Boolean;//禁止死亡掉物品 20080503
    boMISSION: Boolean;//不允许使用任何物品和技能 20080124
    boRUNHUMAN: Boolean;
    boRUNMON: Boolean;
    boNEEDHOLE: Boolean;
    boNORECALL: Boolean;
    boNOGUILDRECALL: Boolean;
    boNODEARRECALL: Boolean;
    boNOMASTERRECALL: Boolean;
    boNORANDOMMOVE: Boolean;
    boNODRUG: Boolean;
    boMINE: Boolean;
    boNOPOSITIONMOVE: Boolean;
    boNoManNoMon: Boolean;//智能刷怪,有人才重新刷怪 20080525
    boKILLFUNC: Boolean;//地图杀人触发 20080415
    nKILLFUNC: Integer;//地图杀人触发 20080415 

   //nL: Integer;//20080815 注释
    nNEEDSETONFlag: Integer;
    nNeedONOFF: Integer;
    nMUSICID: Integer;

    nPKWINLEVEL: Integer;
    nEXPRATE: Integer;
    nPKWINEXP: Integer;
    nPKLOSTLEVEL: Integer;
    nPKLOSTEXP: Integer;
    nDECHPPOINT: Integer;
    nDECHPTIME: Integer;
    nINCHPPOINT: Integer;
    nINCHPTIME: Integer;
    nDECGAMEGOLD: Integer;
    nDECGAMEGOLDTIME: Integer;
    nDECGAMEPOINT: Integer;
    nDECGAMEPOINTTIME: Integer;
    nINCGAMEGOLD: Integer;
    nINCGAMEGOLDTIME: Integer;
    nINCGAMEPOINT: Integer;
    nINCGAMEPOINTTIME: Integer;
    sReConnectMap: string;
    sMUSICName: string;
    boUnAllowStdItems: Boolean;
    sUnAllowStdItemsText: string;//地图禁用物品
    sUnAllowMagicText: string; //不允许魔法
    boNOTALLOWUSEMAGIC: Boolean; //不允许魔法
    boAutoMakeMonster: Boolean;
    boFIGHTPK: Boolean; //PK可以爆装备不红名
    nThunder:Integer;//闪电 20080327
    nLava:Integer;//地上冒岩浆 20080327
  end;
  pTMapFlag = ^TMapFlag;


  TUserLevelSort = record //人物等级排行
    nIndex: Integer;
    wLevel: Word;
    sChrName: string[ACTORNAMELEN];
  end;
  pTUserLevelSort = ^TUserLevelSort;

  THeroLevelSort = record //英雄等级排行
    nIndex: Integer;
    wLevel: Word;
    sChrName: string[ACTORNAMELEN];
    sHeroName: string[ACTORNAMELEN];
  end;
  pTHeroLevelSort = ^THeroLevelSort;

  TUserMasterSort = record //徒弟数量排行
    nIndex: Integer;
    nMasterCount: Integer;
    sChrName: string[ACTORNAMELEN];
  end;
  pTUserMasterSort = ^TUserMasterSort;

  TCharName = string[ACTORNAMELEN + 1];
  pTCharName = ^TCharName;

  THeroName = string[ACTORNAMELEN * 2 + 2];
  pTHeroName = ^THeroName;

  TChrMsg = record
    Ident: Integer;
    x: Integer;
    y: Integer;
    dir: Integer;
    State: Integer;
    feature: Integer;
    saying: string;
    sound: Integer;
  end;
  pTChrMsg = ^TChrMsg;

  TRegInfo = record
    sKey: string;
    sServerName: string;
    sRegSrvIP: string[15];
    nRegPort: Integer;
  end;

  TDropItem = record
    x: Integer;
    y: Integer;
    id: Integer;
    Looks: Integer;
    Name: string;
    FlashTime: DWord;
    FlashStepTime: DWord;
    FlashStep: Integer;
    BoFlash: Boolean;
  end;
  pTDropItem = ^TDropItem;

  TUserCharacterInfo = record
    Name: string[19];
    Job: Byte;
    HAIR: Byte;
    Level: Word;
    sex: Byte;
  end;

  TClientGoods = record
    Name: string;
    SubMenu: Integer;
    Price: Integer;
    Stock: Integer;
    Grade: Integer;
  end;
  PTClientGoods = ^TClientGoods;

  TClientConf = record
    //boClientCanSet: Boolean;//20080413 未使用
    boRUNHUMAN: Boolean;
    boRUNMON: Boolean;
    boRunNpc: Boolean;
    boWarRunAll: Boolean;
    btDieColor: Byte;
    wSpellTime: Word;
    wHitIime: Word;
    wItemFlashTime: Word;
    btItemSpeed: Byte;
    boParalyCanRun: Boolean;
    boParalyCanWalk: Boolean;
    boParalyCanHit: Boolean;//麻痹能攻击
    boParalyCanSpell: Boolean;
    boShowJobLevel: Boolean;
    boDuraAlert: Boolean;
    boSkill31Effect: Boolean;//魔法盾效果 T-特色效果 F-盛大效果 20080808
    //boMagicLock: Boolean;

    //内挂
    {boShowRedHPLable: Boolean;
    boShowGroupMember: Boolean;
    boShowAllItem: Boolean;
    boShowBlueMpLable: Boolean;
    boShowName: Boolean;
    boAutoPuckUpItem: Boolean;
    boShowHPNumber: Boolean;
    boShowAllName: Boolean;
    boForceNotViewFog: Boolean;

    boParalyCan: Boolean;
    boMoveSlow: Boolean;
    boCanStartRun: Boolean;
    boAutoMagic: Boolean;
    boMoveRedShow: Boolean;
    boMagicLock: Boolean;
    nMoveTime: Integer;
    nHitTime: Integer;
    nSpellTime: Integer;
    nClientWgInfo: Integer; }
    //内挂结束
  end;

  pTPowerBlock = ^TPowerBlock;
  TPowerBlock = array[0..100 - 1] of Word;

  TShowRemoteMessage = record
    btMessageType: Byte;
    boShow: Boolean;
    BeginDateTime: TDateTime;
    EndDateTime: TDateTime;
    dwShowTime: LongWord;
    dwShowTick: LongWord;
    boSuperUserShow: Boolean;
    sMsg: string;
  end;
  pTShowRemoteMessage = ^TShowRemoteMessage;

  TDisallowInfo = record //禁止物品规则 20080418
    boDrop: Boolean; //丢弃
    boDeal: Boolean; //交易
    boStorage: Boolean; //存仓
    boRepair: Boolean;  //修理
    boDropHint: Boolean; //掉落提示
    boOpenBoxsHint: Boolean; //宝箱提示
    boNoDropItem: Boolean; //永不爆出
    boButchHint: Boolean; //挖取提示
    boHeroUse: Boolean; //禁止英雄使用
    boPickUpItem: Boolean;//禁止捡起(除GM外) 20080611
    boDieDropItems: Boolean;//死亡掉落 20080614
  end;
  pTDisallowInfo = ^TDisallowInfo;

  TCheckItem = record
    szItemName: string[14];
    boCanDrop: Boolean;
    boCanDeal: Boolean;
    boCanStorage: Boolean;
    boCanRepair: Boolean;
    boCanDropHint: Boolean;
    boCanOpenBoxsHint: Boolean;
    boCanNoDropItem: Boolean;
    boCanButchHint: Boolean;
    boCanHeroUse: Boolean; //禁止英雄使用
    boPickUpItem: Boolean;//禁止捡起(除GM外) 20080611
    boDieDropItems: Boolean;//死亡掉落 20080614
  end;
  pTCheckItem = ^TCheckItem;  

  TFilterMsg = record//消息过滤 
    sFilterMsg: string[100];
    sNewMsg: string[100];
  end;
  pTFilterMsg = ^TFilterMsg;

  TagMapInfo = record //记路标石 20081019
    TagMapName: String[MAPNAMELEN];
    TagX: Integer;
    TagY: Integer;
  end;
  TagMapInfos = array[1..6] of TagMapInfo;//记路标石 20081019

function APPRfeature(cfeature: Integer): Word;
function RACEfeature(cfeature: Integer): Byte;
function HAIRfeature(cfeature: Integer): Byte;
function DRESSfeature(cfeature: Integer): Byte;
function WEAPONfeature(cfeature: Integer): Byte;
function Horsefeature(cfeature: Integer): Byte;
function Effectfeature(cfeature: Integer): Byte;
function MakeHumanFeature(btRaceImg, btDress, btWeapon, btHair: Byte): Integer;
function MakeMonsterFeature(btRaceImg, btWeapon: Byte; wAppr: Word): Integer;
implementation

function WEAPONfeature(cfeature: Integer): Byte;
begin
  Result := HiByte(cfeature);
end;
function DRESSfeature(cfeature: Integer): Byte;
begin
  Result := HiByte(HiWord(cfeature));
end;
function APPRfeature(cfeature: Integer): Word;
begin
  Result := HiWord(cfeature);
end;
function HAIRfeature(cfeature: Integer): Byte;
begin
  Result := HiWord(cfeature);
end;

function RACEfeature(cfeature: Integer): Byte;
begin
  Result := cfeature;
end;

function Horsefeature(cfeature: Integer): Byte;
begin
  Result := LoByte(LoWord(cfeature));
end;
function Effectfeature(cfeature: Integer): Byte;
begin
  Result := HiByte(LoWord(cfeature));
end;

function MakeHumanFeature(btRaceImg, btDress, btWeapon, btHair: Byte): Integer;
begin
  Result := MakeLong(MakeWord(btRaceImg, btWeapon), MakeWord(btHair, btDress));
end;
function MakeMonsterFeature(btRaceImg, btWeapon: Byte; wAppr: Word): Integer;
begin
  Result := MakeLong(MakeWord(btRaceImg, btWeapon), wAppr);
end;
end.
