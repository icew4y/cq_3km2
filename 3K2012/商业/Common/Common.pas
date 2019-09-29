unit Common;

interface

type
  //代理的结构
  TDLUserInfo = record  //返回给客户端的
    sAccount: string[12];//账号
    sUserQQ: string[20]; //QQ
    sName: string[20]; //真实姓名
    CurYuE: Currency; //帐户余额
    CurXiaoShouE: Currency; //帐户销售额
    SAddrs: string[50]; //上次登陆地址
    dTimer: TDateTime; //上次登陆时间
    sPrice:Currency;//登陆器代理价格
    sM2Price:Currency;//M2代理价格(包年)
    sM2PriceMonth:Currency;//M2代理价格(包月) 20110712
  end;
  pTDLUserInfo = ^TDLUserInfo;
  TUserEntry1 = record   //添加用户的机构
    sAccount: string[12];//账号
    sUserQQ: string[20]; //QQ
    sGameListUrl: string[120];
    sBakGameListUrl: string[120];
    sPatchListUrl: string[120];
    sGameMonListUrl: string[120];
    sGameESystemUrl: string[120];
    sGatePass: string[30];
  end;
  TM2UserEntry = record   //添加用户的机构
    sAccount: string[12];//账号(用户名)
    sUserQQ: string[20]; //QQ
    sGameListUrl: string[80];//公司
    sBakGameListUrl: string[16];//IP地址
    sPatchListUrl: string[42];//硬件信息
    sUserTpye: Byte;//M2注册类型 1-包年 2-包月  20110712
    {sGameMonListUrl: string[120];
    sGameESystemUrl: string[120];
    sGatePass: string[30]; }
  end;  
  //公用结构
  TUserSession = record
    sAccount: string[12];  //帐号
    sPassword: string[20]; //密码
    boLogined: Boolean;
  end;
  //登陆器资料
  TLoginData = record
    sGameListUrl: string[120];
    sBakGameListUrl: string[120];
    sPatchListUrl: string[120];
    sGameMonListUrl: string[120];
    sGameESystemUrl: string[120];
    sGatePass: string[30];
  end;
  //普通用户的结构
  TUserInfo = record
    sAccount: string[12];//账号
    sUserQQ: string[20]; //QQ
    nDayMakeNum: Byte; //今日生成次数
    nMaxDayMakeNum: Byte; //最大生成次数
    sAddrs: string[50]; //上次登陆地址
    dTimer: TDateTime; //上次登陆时间
    sGateVersionNum: string[20];
    sLoginVersionNum: string[20];
    LoginData: TLoginData; //登陆器资料
  end;
  //普通用户的结构
  TM2UserInfo = record
    sBakGameListUrl: string[16];//IP地址
    sPatchListUrl: string[42];//硬件信息
    sGameListUrl: string[80];//公司  
    sAccount: string[12];//账号
    sUserQQ: string[20]; //QQ
    nDayMakeNum: Byte; //今日生成次数
    nMaxDayMakeNum: Byte; //最大生成次数
    sAddrs: string[50]; //上次登陆地址
    dTimer: TDateTime; //上次登陆时间
    nUpType: Byte;//修改信息的类型(是修改IP，还是修改硬件) 0-两者都可修改 1-只能修改IP 2-只能修改硬件 3-包月用户不能修改
    nUpDataNum: Byte;//修改过的硬件信息次数
  end;  
const
///////////////////////////授权相关/////////////////////////////////////////////
  //代理相关
  GM_LOGIN = 118;
  SM_LOGIN_SUCCESS = 119;
  SM_LOGIN_FAIL = 120;

  GM_GETUSER = 121;          //检测用户名是否存在
  SM_GETUSER_SUCCESS = 122;
  SM_GETUSER_FAIL = 123;

  GM_ADDUSER = 124;
  SM_ADDUSER_SUCCESS = 125;
  SM_ADDUSER_FAIL = 126;

  GM_CHANGEPASS = 127;         //修改密码
  SM_CHANGEPASS_SUCCESS = 128;
  SM_CHANGEPASS_FAIL = 129;

  //用户相关
  GM_USERLOGIN = 200;          //用户登陆
  SM_USERLOGIN_SUCCESS = 201;
  SM_USERLOGIN_FAIL = 202;

  {GM_USERCHANGEPASS = 203;  //修改密码
  SM_USERCHANGEPASS_SUCCESS = 204;
  SM_USERCHANGEPASS_FAIL = 205;    }

  GM_USERCHECKMAKEKEYANDDAYMAKENUM = 206; //验证密钥匙和今日生成次数
  SM_USERCHECKMAKEKEYANDDAYMAKENUM_SUCCESS = 207;
  SM_USERCHECKMAKEKEYANDDAYMAKENUM_FAIL = 208;

  GM_USERMAKELOGIN = 209;    //生成登陆器
  SM_USERMAKELOGIN_SUCCESS = 210;
  SM_USERMAKELOGIN_FAIL = 211;

  GM_USERMAKEGATE = 212;     //生成网关
  SM_USERMAKEGATE_SUCCESS = 213;
  SM_USERMAKEGATE_FAIL = 214;

  SM_USERMAKEONETIME_FAIL = 215; //超过服务器最大用户同时生成人数
  SM_USERVERSION = 216;  //版本号发送
////////////////////////////////////////////////////////////////////////////////
//注册M2相关
  GM_GETM2USER = 243;          //检测用户名是否存在
  SM_GETM2USER_SUCCESS = 217;
  SM_GETM2USER_FAIL = 218;

  GM_ADDM2USER = 219;          //增加M2用户
  SM_ADDM2USER_SUCCESS = 220;
  SM_ADDM2USER_FAIL = 221;

  GM_USERCHECKMAKEUPDATADATAUNM =222; //检查用户修改的次数
  SM_USERCHECKMAKEUPDATADATAUNM_SUCCESS = 223;
  SM_USERCHECKMAKEUPDATADATAUNM_FAIL = 224;

  GM_USERUPDATAM2REGDATAIP = 225;//修改IP信息
  SM_USERUPDATAM2REGDATAIP_SUCCESS = 226;
  SM_USERUPDATAM2REGDATAIP_FAIL = 227;

  GM_USERUPDATAM2REGDATAHARD = 228;//修改硬件信息
  SM_USERUPDATAM2REGDATAHARD_SUCCESS = 229;
  SM_USERUPDATAM2REGDATAHARD_FAIL = 230;

  GM_USERMAKEM2REG = 231; //生成M2注册文件
  SM_USERMAKEM2REG_SUCCESS = 232;
  SM_USERMAKEM2REG_FAIL =233;

  GM_USERM2LOGIN = 234;          //用户登陆
  SM_USERM2LOGIN_SUCCESS = 235;
  SM_USERM2LOGIN_FAIL = 236;

{  GM_USERM2CHANGEPASS = 237;  //修改密码
  SM_USERM2CHANGEPASS_SUCCESS = 238;
  SM_USERM2CHANGEPASS_FAIL = 239;       }

  GM_USERCHECKM2DAYMAKENUM = 240; //验证今日生成次数
  SM_USERCHECKM2DAYMAKENUM_SUCCESS = 241;
  SM_USERCHECKM2DAYMAKENUM_FAIL = 242;

  SM_M2USERVERSION = 243;  //M2版本号发送
////////////////////////////////////////////////////////////////////////////////
//1.76登陆器
  GM_176USERLOGIN = 244;          //用户登陆
  GM_176USERCHECKMAKEKEYANDDAYMAKENUM = 245; //验证密钥匙和今日生成次数
  GM_176USERMAKELOGIN = 246;    //生成登陆器
  GM_176USERMAKEGATE = 247;     //生成网关
//1.76 M2
  GM_176USERM2LOGIN = 248;          //用户登陆
  GM_176USERCHECKMAKEUPDATADATAUNM =249; //1.76检查用户修改的次数
  GM_176USERUPDATAM2REGDATAHARD = 250;//1.76修改硬件信息
  GM_176USERCHECKM2DAYMAKENUM = 251; //1.76验证今日生成次数
  GM_176USERMAKEM2REG = 252; //1.76生成M2注册文件
  SM_176USERMAKELOGIN_SUCCESS = 253; //1.76生成登陆器成功
  SM_176USERMAKEGATE_SUCCESS = 254;  //1.76生成网关成功
  SM_176USERMAKEM2REG_SUCCESS = 255; //1.76生成M2成功

  SM_UPDATEM2USERREGDATE_SUCCESS = 256;//M2延期成功
  SM_UPDATEM2USERREGDATE_FAIL = 257;//M2延期失败
  GM_UPDATEM2USERREGDATE = 258; //M2延期
////////////////////////////////////////////////////////////////////////////////
  GS_QUIT = 2000; //关闭
  SG_FORMHANDLE = 1000; //服务器HANLD
  SG_STARTNOW = 1001; //正在启动服务器...
  SG_STARTOK = 1002; //服务器启动完成...
  SG_RECONMAKE = 1003;//通知网关让W2重新连接生成服务器 20100102
const
  CLIENT_USEPE = 1;//登陆器使用壳标识 0-VMP 1-WL
implementation

end.
