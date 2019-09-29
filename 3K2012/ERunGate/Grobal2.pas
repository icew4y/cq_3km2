unit Grobal2;

interface
uses
  Windows;
const
  M2Version = 1;//0-0627版程序(非连击-内功) 1-最新版(内功+连击版) 2-1.76版(无内功,无连击)使用不同的消息解密算法 20100711
  CLIENT_VERSION_NUMBER = 920080512;//9+客户端版本号 20090208
  
  DEFBLOCKSIZE = {16}22;//20081216
  BUFFERSIZE = 10000;

  CM_DROPITEM = 1000;
  CM_PICKUP = 1001;
  CM_EAT = 1005; //使用物品,吃药
  CM_HEROEAT = 5043;       //吃东西
  SM_HEROEAT_FAIL = 5045; //吃东西失败
  SM_EAT_FAIL = 636;
  CM_BUTCH = 1007;//挖

  CM_THROW = 3005;
  CM_TURN = 3010;//转身(方向改变)
  CM_WALK = 3011;
  CM_SITDOWN = 3012;
  CM_RUN = 3013;
  CM_HIT = 3014;
  CM_HEAVYHIT = 3015;
  CM_BIGHIT = 3016;
  CM_SPELL = 3017;
  CM_POWERHIT = 3018;
  CM_LONGHIT = 3019;
  CM_LONGHIT4 = 3020;//四级刺杀
  CM_WIDEHIT4 = 3021;//圆月弯刀(四级半月)

  CM_LONGHITFORFENGHAO = 10191;//刺杀粉红效果
  CM_FIREHITFORFENGHAO = 10193;//烈火粉红效果
  CM_DAILYFORFENGHAO = 10195;//逐日粉红效果
  CM_CRSHIT = 3036; //抱月刀
  CM_4FIREHIT = 3031; //4级烈火攻击

  CM_WIDEHIT = 3024;
  CM_FIREHIT = 3025;
  CM_DAILY = 3042; //逐日剑法 20080511
  CM_CIDHIT = 3040; //龙影剑法
  CM_TWNHIT = 3037; //开天斩重击
  CM_QTWINHIT = 3041; //开天斩轻击
  CM_BLOODSOUL = 3048;//血魄一击(战)

  CM_SAY = 3030;

  //CM_USERBUYITEM = 1014; //用户买入东西
  CM_BUYSHOPITEM = 9002;
  CM_BUYSHOPITEMGIVE = 9006; //赠送
  CM_EXCHANGEGAMEGIRD = 20042; //商铺兑换灵符
  CM_MERCHANTDLGSELECT = 1011; //商品选择,大类,输入框输入信息后返回
  CM_OPENHEROPULSEPOINT = 20225;//客户端点击英雄穴位
  CM_REPAIRDRAGON = 5061;  //祝福罐.魔令包功能
  CM_REPAIRFINEITEM = 20060; //修补火云石
  CM_GETBOXS  = 20031;//客户端取得宝箱物品
  CM_QUERYBAGITEMS = 81;  //查询包裹物品
  CM_CLICKSIGHICON = 20165; //点击感叹号图标
  CM_CLICKCRYSTALEXPTOP = 20172; //点击天地结晶获得经验
  CM_CHALLENGETRY = 20115;//玩家点挑战
  CM_DEALTRY = 1025;  //开始交易,交易开始
  CM_ITEMSPLIT = 20189;//客户端拆分物品
  CM_ITEMMERGER = 20190;//客户端合并物品
  CM_EXERCISEKIMNEEDLE = 20193;//客户端开始练针
  CM_OPENPULSEPOINT = 20198;//客户端点击穴位
  CM_CLICKBATTERNPC = 20199; //连击NPC执行触发脚本段
  CM_PRACTICEPULSE = 20201;//客户端修炼经络
  CM_HEROPRACTICEPULSE = 20227;//客户端英雄修炼经络

  RUNGATECODE = $AA55AA55;

  RUNGATEMAX = 20;
  // For Game Gate
  GM_OPEN = 1;
  GM_CLOSE = 2;
  GM_CHECKSERVER = 3; // Send check signal to Server
  GM_CHECKCLIENT = 4; // Send check signal to Client
  GM_DATA = 5;
  GM_SERVERUSERINDEX = 6;
  GM_RECEIVE_OK = 7;
  GM_TEST = 20;
  //GM_KickConn = 21;//20081221 踢Rungate.exe对应的连接

  OS_MOVINGOBJECT = 1;
  OS_ITEMOBJECT = 2;
  OS_EVENTOBJECT = 3;
  OS_GATEOBJECT = 4;
  OS_SWITCHOBJECT = 5;
  OS_MAPEVENT = 6;
  OS_DOOR = 7;
  OS_ROON = 8;

  RC_PLAYOBJECT = 1;
  RC_MONSTER = 2;
  RC_ANIMAL = 6;
  RC_NPC = 8;
  RC_PEACENPC = 9; //jacky

type
  TDefaultMessage = record
    Recog: Integer;
    Ident: word;
    Param: word;
    Tag: word;
    Series: word;
    nSessionID: Integer;//20081210
  end;
  pTDefaultMessage = ^TDefaultMessage;

  TMsgHeader = record
    dwCode: LongWord;//网关标识  RUNGATECODE
    nSocket: Integer; //0x04
    wGSocketIdx: Word; //0x08
    wIdent: Word; //消息ID
    wUserListIndex: Word; //0x0C
    nLength: Integer; //0x10
  end;
  pTMsgHeader = ^TMsgHeader;
  function aa(const Value,key:Word):Word;
  function bb(const Value,key:Word):Word;  
implementation
{$IF M2Version <> 2}
//消息ID加密
function aa(const Value,key:Word):Word;
begin
  Result:=(Value+(key shl 3)) xor (key shr 1);
end;
//消息ID解密
function bb(const Value,key:Word):Word;
begin
  Result:= (Value xor (key shr 1)) - (key shl 3);
end;
{$ELSE}
//消息ID加密
function aa(const Value,key:Word):Word;
begin
  Result:=(Value+(key shl 6)) xor (key shr 2);
end;
//消息ID解密
function bb(const Value,key:Word):Word;
begin
  Result:= (Value xor (key shr 2)) - (key shl 6);
end;
{$IFEND}
end.
