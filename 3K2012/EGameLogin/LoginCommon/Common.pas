unit Common;

interface
uses
  Windows, SysUtils, Classes, Shlobj, Activex, Registry, Forms, ZLib, uFileUnit,
  ComObj, VCLZip, VCLUnZip, Gost, iniFiles, Rc6, Mars, FileUnit, EDcodeUnit;
type
//自身信息记录    (登陆器+图片文件+套装文件+经络文件+内挂文件+结构)
  TRecinfo = record
    GameListURL: string[255];
    BakGameListURL: string[255];
    PatchListURL: string[255];
    GameMonListURL: string[255];
    GameESystemUrl: string[255];
    //boGameMon :Boolean;
    boAutoUpData    :Boolean;//使用百度更新
    lnkName: string[20];
    ClientFileName: string[20];
    //GameSdoFilter: array[0..50000] of char;
    //TzHintFile: array[0..5000] of Char;
    //PulsDesc: array[0..10000] of Char;
    GatePass: string[34];
    SourceFileSize: Int64;//登陆器原文件大小
    MainImagesFileSize: Int64;//图片文件大小
    TzHintListFileSize: Int64;//套装文件大小
    PulsDescFileSize: Int64;//经络文件大小
    GameSdoFilterFileSize: Int64;//内挂文件大小
    FDDllFileSize: Int64;//风盾文件大小
  end;

//自身信息记录
  TRecGateInfo = record
    GameSky: string[100];
    GameGhost: string[100];
    GameSdo: string[100];
    GameTwe: string[100];
    GameDraw: string[100];
    GameWT: string[100];
    GameZH: string[100];
    GameWW: string[100];
  end;

//更新记录
  TPatchInfo = record
    PatchType        : Integer;
    PatchFileDir     : string;
    PatchName        : string;
    ServerMd5         : string;
    PatchDownAddress : string;
  end;
  pTPatchInfo = ^TPatchInfo;
//列表记录
  TServerInfo = record
    ServerArray        : string;
    ServerName     : string;
    ServerIP        : string;
    ServerPort         : integer;
    CheckPort          : integer;
    CheckMode          : integer;
    ServerNoticeURL : string; //公告
    ServerHomeURL : string; //主页
    GameItemsURL: string; //装备展示
    GatePass: string; //网关密码
  end;
  pTServerInfo = ^TServerInfo;
  TRunParam = packed record
    wProt : Word;
    sLoginGatePassWord : string[34]; 
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
  TGetUrlStep = (ServerList, UpdateList, GameMonList, ReServerList, ReUpdateList);

//function RunApp(AppName: string; I: Integer; LoginPass, GatePass, ClassName, CaptionName, sIp, sPort, sServerCaption, sESystemUrl, sSky, sMylient, He, FullScreen: string): Integer; //运行程序
function RunApp(sCmd : string): Integer; //运行程序
function RunAppInMem(AppName: string; I: Integer; LoginPass, GatePass, ClassName, CaptionName, sIp, sPort, sServerCaption, sESystemUrl, sSky, sMirClient, He, Full: string): Integer; //运行程序
procedure Createlnk(LnkName: string);//快捷方式
//function DownLoadFile(sURL,sFName: string;CanBreak: Boolean;IdHTTP:TIdHTTP): boolean;  //下载文件
//procedure PatchSelf(aFileName:string);//更新自身文件
//procedure ExtractFileFromZip(const DesPathName,ZipFileName: string); //解压Zip文件
function SelectDirectory(const Caption: string; const Root: WideString;  //选择目录函数
  var Directory: string; Owner: THandle): Boolean;
procedure ExtractInfo(const FilePath: string; var MyRecInfo: TRecInfo);  //读出自身配置等信息
function WriteInfo(const FilePath: string; MyRecInfo: TRecInfo): Boolean;
function WriteGateInfo(const FilePath: string; MyRecInfo: TRecGateInfo): Boolean;
function CheckMyDir(DirName: string): Boolean; //检查是否传奇目录
function decrypt(const s:string; skey:string):string;
function encrypt(const s:string; skey:string):string;
function CertKey(key: string): string;
function GetAdoSouse(S: String): String;
//function EncodeString_Rc6(Source, Key: string): string;
function DecodeString_RC6(Source, Key: string): string;
function EnGhost(Source, Key: string): string;
procedure SeqNumEnc(var Str: String; Key: Word; Times: Integer);
procedure GetdriveName(var sList: TStringList);  //获取当前的硬盘所有的盘符
function CheckIsIpAddr(Name: string): Boolean; //检查IP地址格式
function CheckSdoClientVer(Path: string):Boolean;
function LoginMainImagesB(aStr: string; acKey: string): string;//解密1
function LoginMainImagesD(Source, Key: string): string;//解密2(gost)
function IsNum(str:string):boolean;//判断一个字符串是否为数字{填充垃圾代码}
function MyWinExec(sCmd : string): Integer; //运行程序
function ExtractFileFromZip(const DesPathName,ZipFileName: string): Boolean;
function AddFileMd5ToLocal(sMd5 : string) : Boolean;
procedure EnCompressStream(CompressedStream: TMemoryStream);
procedure DeCompressStream(CompressedStream: TMemoryStream);
const
    RecInfoSize = Sizeof(TRecinfo);  //返回被TRecinfo所占用的字节数
    RecGateInfoSize = SizeOf(TRecGateinfo);
    //UpDateFile = 'QkUpdate.lis';
    SeedString = 'jdjwicjchahpnmstardhxksjhha'; //种子字符串可以自己设定
    Byte0=Byte('0');
    CLIENT_USEPE = 1;//登陆器使用壳标识 0-VMP 1-WL
    g_SdoVer = 2013;
var
  g_boIsGamePath: Boolean;
  busy: Boolean;
  SocStr, BufferStr : string;
  UpDateFile: string = 'UpData.inf';
  MakeNewAccount: string;
  CanBreak:Boolean;
  g_RunParam : TRunParam;  
  g_PatchList: TList;
  g_ServerList: TList;
  GetUrlStep: TGetUrlStep;
  g_LocalServerList: TList;//免费版用
  g_GameMonModule : THashedStringList;//TStringList;
  g_GameMonProcess : THashedStringList;//TStringList;
  g_GameMonTitle : THashedStringList;//TStringList;
  m_boClientSocketConnect: Boolean;
  m_BoSearchFinish: Boolean;
  g_sHomeURL: string;
  code: byte = 1;
  DownCode: Byte = 1;
  g_boUsesFD: Boolean = False;
implementation
uses GameLoginShare{$Ifndef FreeVer}, uRes{$Endif};
type
  TSData = array[0..63] of byte;
  TBlock = array[0..7] of byte;
  TByte32 = array[1..32] of byte;
const
  SA1: TSData =
  (1, 0, 1, 0, 0, 1, 1, 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 1, 1, 1, 0, 0, 1,
    0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0, 0, 1);
  SA2: TSData =
  (1, 0, 1, 1, 0, 1, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 1, 1, 0, 0, 1, 0, 1, 1, 0,
    0, 1, 0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 1);
  SA3: TSData =
  (1, 0, 1, 1, 0, 0, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 1, 1, 1, 0,
    1, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1);
  SA4: TSData =
  (0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1,
    1, 0, 1, 0, 1, 1, 0, 1, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 1, 1, 0, 0, 1, 1, 0, 0, 1);
  SA5: TSData =
  (0, 1, 0, 0, 0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 1, 1, 1, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1, 1, 0, 1, 1, 0,
    0, 0, 0, 1, 1, 1, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 1, 0, 1, 0, 1, 0, 1, 1, 0, 0, 0);
  SA6: TSData =
  (1, 0, 1, 1, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 1, 0, 1,
    1, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1);
  SA7: TSData =
  (0, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0,
    0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 0, 1, 0, 0, 1, 0, 0, 1, 1, 1, 0, 0, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1);
  SA8: TSData =
  (1, 0, 1, 0, 0, 1, 1, 0, 1, 1, 0, 1, 0, 0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0, 1, 0, 1, 1, 0,
    0, 1, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1);
  SB1: TSData =
  (1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0, 1, 0, 1, 1, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0,
    1, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 1, 1);
  SB2: TSData =
  (1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 0, 1, 1, 0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 1,
    0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, 1, 0, 1, 1, 0);
  SB3: TSData =
  (0, 0, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 0, 1, 0,
    1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 1, 0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 0, 1);
  SB4: TSData =
  (1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1, 0,
    0, 1, 0, 0, 1, 0, 1, 1, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 1, 0, 1, 1, 0, 1);
  SB5: TSData =
  (0, 1, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1, 0, 0, 1, 1, 1, 1, 0, 1, 0, 1, 0, 0, 0, 0, 1,
    1, 0, 0, 0, 0, 1, 1, 0, 1, 0, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 0, 1, 0, 1, 1, 1, 0, 0, 0, 1, 1, 0);
  SB6: TSData =
  (1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 1, 1, 1, 0, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 0, 0, 0,
    0, 1, 1, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0, 0, 1);
  SB7: TSData =
  (1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1, 0, 0, 1, 1, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1,
    0, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 1, 1, 0, 0, 1);
  SB8: TSData =
  (1, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0,
    1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 0);
  SC1: TSData =
  (1, 0, 0, 0, 1, 1, 1, 0, 1, 1, 1, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1, 0,
    0, 0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 1, 1, 0, 1, 0);
  SC2: TSData =
  (1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 0, 1, 0,
    0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1, 0, 0, 1, 0, 1, 1, 0, 1, 1, 1, 1, 0, 0, 0, 1, 0);
  SC3: TSData =
  (1, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 1, 1, 0, 0, 1, 0, 1, 1, 0,
    0, 1, 0, 0, 0, 1, 1, 0, 1, 0, 1, 0, 0, 1, 1, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 1, 1, 1, 0, 1, 0);
  SC4: TSData =
  (1, 0, 1, 1, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0,
    1, 1, 0, 0, 0, 1, 1, 0, 1, 0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1);
  SC5: TSData =
  (1, 0, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0, 1,
    0, 1, 0, 1, 1, 0, 1, 0, 1, 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0, 1, 1, 0, 0, 1, 0, 0, 1);
  SC6: TSData =
  (0, 0, 1, 1, 0, 1, 1, 0, 0, 0, 1, 0, 1, 1, 0, 1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 0, 0, 1, 0, 1, 1, 0,
    0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0);
  SC7: TSData =
  (0, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0, 1, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0, 1, 1, 0, 1,
    0, 0, 1, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0);
  SC8: TSData =
  (0, 1, 0, 0, 1, 1, 1, 0, 1, 0, 1, 1, 0, 0, 0, 1, 0, 1, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 0, 1, 0, 1,
    1, 1, 0, 0, 0, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1);
  SD1: TSData =
  (0, 0, 1, 1, 0, 1, 1, 0, 1, 0, 0, 0, 1, 1, 0, 1, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0,
    0, 1, 0, 0, 1, 0, 0, 1, 1, 0, 1, 1, 1, 0, 1, 0, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1);
  SD2: TSData =
  (1, 1, 0, 0, 0, 1, 1, 0, 1, 1, 0, 1, 0, 0, 1, 0, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 1,
    0, 0, 1, 1, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1);
  SD3: TSData =
  (0, 0, 1, 0, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 1,
    1, 0, 0, 1, 0, 1, 1, 0, 1, 1, 0, 0, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 1, 1, 1, 0, 0);
  SD4: TSData =
  (1, 1, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 1, 1, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1,
    0, 0, 1, 0, 0, 1, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 1, 0, 1, 1, 0, 1, 0, 0);
  SD5: TSData =
  (0, 0, 0, 1, 1, 0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 0, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, 0, 1, 1, 0, 0,
    0, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1, 1);
  SD6: TSData =
  (0, 1, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, 1, 0, 1, 0, 0, 1, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 0,
    1, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 1, 0, 1, 0, 1, 1, 0, 0, 0, 1);
  SD7: TSData =
  (0, 1, 0, 0, 1, 0, 0, 1, 1, 0, 1, 1, 1, 0, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0,
    1, 0, 1, 1, 0, 1, 1, 0, 0, 1, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1, 1, 1, 0, 1, 0, 0, 1, 0);
  SD8: TSData =
  (1, 0, 0, 0, 0, 1, 1, 1, 0, 1, 1, 0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0,
    1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 1, 0, 1, 0, 0, 0, 1, 1, 0, 1, 0, 1, 1, 0, 1);

  Sc: array[1..16, 1..48] of byte =
  ((15, 18, 12, 25, 2, 6, 4, 1, 16, 7, 22, 11, 24, 20, 13, 5, 27, 9, 17, 8, 28, 21, 14, 3,
    42, 53, 32, 38, 48, 56, 31, 41, 52, 46, 34, 49, 45, 50, 40, 29, 35, 54, 47, 43, 51, 37, 30, 33),
    (16, 19, 13, 26, 3, 7, 5, 2, 17, 8, 23, 12, 25, 21, 14, 6, 28, 10, 18, 9, 1, 22, 15, 4,
    43, 54, 33, 39, 49, 29, 32, 42, 53, 47, 35, 50, 46, 51, 41, 30, 36, 55, 48, 44, 52, 38, 31, 34),
    (18, 21, 15, 28, 5, 9, 7, 4, 19, 10, 25, 14, 27, 23, 16, 8, 2, 12, 20, 11, 3, 24, 17, 6,
    45, 56, 35, 41, 51, 31, 34, 44, 55, 49, 37, 52, 48, 53, 43, 32, 38, 29, 50, 46, 54, 40, 33, 36),
    (20, 23, 17, 2, 7, 11, 9, 6, 21, 12, 27, 16, 1, 25, 18, 10, 4, 14, 22, 13, 5, 26, 19, 8,
    47, 30, 37, 43, 53, 33, 36, 46, 29, 51, 39, 54, 50, 55, 45, 34, 40, 31, 52, 48, 56, 42, 35, 38),
    (22, 25, 19, 4, 9, 13, 11, 8, 23, 14, 1, 18, 3, 27, 20, 12, 6, 16, 24, 15, 7, 28, 21, 10,
    49, 32, 39, 45, 55, 35, 38, 48, 31, 53, 41, 56, 52, 29, 47, 36, 42, 33, 54, 50, 30, 44, 37, 40),
    (24, 27, 21, 6, 11, 15, 13, 10, 25, 16, 3, 20, 5, 1, 22, 14, 8, 18, 26, 17, 9, 2, 23, 12,
    51, 34, 41, 47, 29, 37, 40, 50, 33, 55, 43, 30, 54, 31, 49, 38, 44, 35, 56, 52, 32, 46, 39, 42),
    (26, 1, 23, 8, 13, 17, 15, 12, 27, 18, 5, 22, 7, 3, 24, 16, 10, 20, 28, 19, 11, 4, 25, 14,
    53, 36, 43, 49, 31, 39, 42, 52, 35, 29, 45, 32, 56, 33, 51, 40, 46, 37, 30, 54, 34, 48, 41, 44),
    (28, 3, 25, 10, 15, 19, 17, 14, 1, 20, 7, 24, 9, 5, 26, 18, 12, 22, 2, 21, 13, 6, 27, 16,
    55, 38, 45, 51, 33, 41, 44, 54, 37, 31, 47, 34, 30, 35, 53, 42, 48, 39, 32, 56, 36, 50, 43, 46),
    (1, 4, 26, 11, 16, 20, 18, 15, 2, 21, 8, 25, 10, 6, 27, 19, 13, 23, 3, 22, 14, 7, 28, 17,
    56, 39, 46, 52, 34, 42, 45, 55, 38, 32, 48, 35, 31, 36, 54, 43, 49, 40, 33, 29, 37, 51, 44, 47),
    (3, 6, 28, 13, 18, 22, 20, 17, 4, 23, 10, 27, 12, 8, 1, 21, 15, 25, 5, 24, 16, 9, 2, 19,
    30, 41, 48, 54, 36, 44, 47, 29, 40, 34, 50, 37, 33, 38, 56, 45, 51, 42, 35, 31, 39, 53, 46, 49),
    (5, 8, 2, 15, 20, 24, 22, 19, 6, 25, 12, 1, 14, 10, 3, 23, 17, 27, 7, 26, 18, 11, 4, 21,
    32, 43, 50, 56, 38, 46, 49, 31, 42, 36, 52, 39, 35, 40, 30, 47, 53, 44, 37, 33, 41, 55, 48, 51),
    (7, 10, 4, 17, 22, 26, 24, 21, 8, 27, 14, 3, 16, 12, 5, 25, 19, 1, 9, 28, 20, 13, 6, 23,
    34, 45, 52, 30, 40, 48, 51, 33, 44, 38, 54, 41, 37, 42, 32, 49, 55, 46, 39, 35, 43, 29, 50, 53),
    (9, 12, 6, 19, 24, 28, 26, 23, 10, 1, 16, 5, 18, 14, 7, 27, 21, 3, 11, 2, 22, 15, 8, 25,
    36, 47, 54, 32, 42, 50, 53, 35, 46, 40, 56, 43, 39, 44, 34, 51, 29, 48, 41, 37, 45, 31, 52, 55),
    (11, 14, 8, 21, 26, 2, 28, 25, 12, 3, 18, 7, 20, 16, 9, 1, 23, 5, 13, 4, 24, 17, 10, 27,
    38, 49, 56, 34, 44, 52, 55, 37, 48, 42, 30, 45, 41, 46, 36, 53, 31, 50, 43, 39, 47, 33, 54, 29),
    (13, 16, 10, 23, 28, 4, 2, 27, 14, 5, 20, 9, 22, 18, 11, 3, 25, 7, 15, 6, 26, 19, 12, 1,
    40, 51, 30, 36, 46, 54, 29, 39, 50, 44, 32, 47, 43, 48, 38, 55, 33, 52, 45, 41, 49, 35, 56, 31),
    (14, 17, 11, 24, 1, 5, 3, 28, 15, 6, 21, 10, 23, 19, 12, 4, 26, 8, 16, 7, 27, 20, 13, 2,
    41, 52, 31, 37, 47, 55, 30, 40, 51, 45, 33, 48, 44, 49, 39, 56, 34, 53, 46, 42, 50, 36, 29, 32));

var
  c: array[1..56] of byte;
  G: array[1..16, 1..48] of byte;
  L, R, F: TByte32;
//---------------------------------------------------------------------------
procedure DES_Init(Key: TBlock; FCode: Boolean);
var
  n, h: byte;
begin
  c[1] := Ord(Key[7] and 128 > 0); c[29] := Ord(Key[7] and 2 > 0);
  c[2] := Ord(Key[6] and 128 > 0); c[30] := Ord(Key[6] and 2 > 0);
  c[3] := Ord(Key[5] and 128 > 0); c[31] := Ord(Key[5] and 2 > 0);
  c[4] := Ord(Key[4] and 128 > 0); c[32] := Ord(Key[4] and 2 > 0);
  c[5] := Ord(Key[3] and 128 > 0); c[33] := Ord(Key[3] and 2 > 0);
  c[6] := Ord(Key[2] and 128 > 0); c[34] := Ord(Key[2] and 2 > 0);
  c[7] := Ord(Key[1] and 128 > 0); c[35] := Ord(Key[1] and 2 > 0);
  c[8] := Ord(Key[0] and 128 > 0); c[36] := Ord(Key[0] and 2 > 0);

  c[9] := Ord(Key[7] and 64 > 0); c[37] := Ord(Key[7] and 4 > 0);
  c[10] := Ord(Key[6] and 64 > 0); c[38] := Ord(Key[6] and 4 > 0);
  c[11] := Ord(Key[5] and 64 > 0); c[39] := Ord(Key[5] and 4 > 0);
  c[12] := Ord(Key[4] and 64 > 0); c[40] := Ord(Key[4] and 4 > 0);
  c[13] := Ord(Key[3] and 64 > 0); c[41] := Ord(Key[3] and 4 > 0);
  c[14] := Ord(Key[2] and 64 > 0); c[42] := Ord(Key[2] and 4 > 0);
  c[15] := Ord(Key[1] and 64 > 0); c[43] := Ord(Key[1] and 4 > 0);
  c[16] := Ord(Key[0] and 64 > 0); c[44] := Ord(Key[0] and 4 > 0);

  c[17] := Ord(Key[7] and 32 > 0); c[45] := Ord(Key[7] and 8 > 0);
  c[18] := Ord(Key[6] and 32 > 0); c[46] := Ord(Key[6] and 8 > 0);
  c[19] := Ord(Key[5] and 32 > 0); c[47] := Ord(Key[5] and 8 > 0);
  c[20] := Ord(Key[4] and 32 > 0); c[48] := Ord(Key[4] and 8 > 0);
  c[21] := Ord(Key[3] and 32 > 0); c[49] := Ord(Key[3] and 8 > 0);
  c[22] := Ord(Key[2] and 32 > 0); c[50] := Ord(Key[2] and 8 > 0);
  c[23] := Ord(Key[1] and 32 > 0); c[51] := Ord(Key[1] and 8 > 0);
  c[24] := Ord(Key[0] and 32 > 0); c[52] := Ord(Key[0] and 8 > 0);

  c[25] := Ord(Key[7] and 16 > 0); c[53] := Ord(Key[3] and 16 > 0);
  c[26] := Ord(Key[6] and 16 > 0); c[54] := Ord(Key[2] and 16 > 0);
  c[27] := Ord(Key[5] and 16 > 0); c[55] := Ord(Key[1] and 16 > 0);
  c[28] := Ord(Key[4] and 16 > 0); c[56] := Ord(Key[0] and 16 > 0);

  if FCode then
  begin
    for n := 1 to 16 do
    begin
      for h := 1 to 48 do
      begin
        G[n, h] := c[Sc[n, h]];
      end;
    end;
  end
  else
  begin
    for n := 1 to 16 do
    begin
      for h := 1 to 48 do
      begin
        G[17 - n, h] := c[Sc[n, h]];
      end;
    end;
  end;
end;
procedure DES_Code(Input: TBlock; var Output: TBlock);
var
  n: byte;
  z: Word;
begin
  L[1] := Ord(Input[7] and 64 > 0); R[1] := Ord(Input[7] and 128 > 0);
  L[2] := Ord(Input[6] and 64 > 0); R[2] := Ord(Input[6] and 128 > 0);
  L[3] := Ord(Input[5] and 64 > 0); R[3] := Ord(Input[5] and 128 > 0);
  L[4] := Ord(Input[4] and 64 > 0); R[4] := Ord(Input[4] and 128 > 0);
  L[5] := Ord(Input[3] and 64 > 0); R[5] := Ord(Input[3] and 128 > 0);
  L[6] := Ord(Input[2] and 64 > 0); R[6] := Ord(Input[2] and 128 > 0);
  L[7] := Ord(Input[1] and 64 > 0); R[7] := Ord(Input[1] and 128 > 0);
  L[8] := Ord(Input[0] and 64 > 0); R[8] := Ord(Input[0] and 128 > 0);
  L[9] := Ord(Input[7] and 16 > 0); R[9] := Ord(Input[7] and 32 > 0);
  L[10] := Ord(Input[6] and 16 > 0); R[10] := Ord(Input[6] and 32 > 0);
  L[11] := Ord(Input[5] and 16 > 0); R[11] := Ord(Input[5] and 32 > 0);
  L[12] := Ord(Input[4] and 16 > 0); R[12] := Ord(Input[4] and 32 > 0);
  L[13] := Ord(Input[3] and 16 > 0); R[13] := Ord(Input[3] and 32 > 0);
  L[14] := Ord(Input[2] and 16 > 0); R[14] := Ord(Input[2] and 32 > 0);
  L[15] := Ord(Input[1] and 16 > 0); R[15] := Ord(Input[1] and 32 > 0);
  L[16] := Ord(Input[0] and 16 > 0); R[16] := Ord(Input[0] and 32 > 0);
  L[17] := Ord(Input[7] and 4 > 0); R[17] := Ord(Input[7] and 8 > 0);
  L[18] := Ord(Input[6] and 4 > 0); R[18] := Ord(Input[6] and 8 > 0);
  L[19] := Ord(Input[5] and 4 > 0); R[19] := Ord(Input[5] and 8 > 0);
  L[20] := Ord(Input[4] and 4 > 0); R[20] := Ord(Input[4] and 8 > 0);
  L[21] := Ord(Input[3] and 4 > 0); R[21] := Ord(Input[3] and 8 > 0);
  L[22] := Ord(Input[2] and 4 > 0); R[22] := Ord(Input[2] and 8 > 0);
  L[23] := Ord(Input[1] and 4 > 0); R[23] := Ord(Input[1] and 8 > 0);
  L[24] := Ord(Input[0] and 4 > 0); R[24] := Ord(Input[0] and 8 > 0);
  L[25] := Input[7] and 1; R[25] := Ord(Input[7] and 2 > 0);
  L[26] := Input[6] and 1; R[26] := Ord(Input[6] and 2 > 0);
  L[27] := Input[5] and 1; R[27] := Ord(Input[5] and 2 > 0);
  L[28] := Input[4] and 1; R[28] := Ord(Input[4] and 2 > 0);
  L[29] := Input[3] and 1; R[29] := Ord(Input[3] and 2 > 0);
  L[30] := Input[2] and 1; R[30] := Ord(Input[2] and 2 > 0);
  L[31] := Input[1] and 1; R[31] := Ord(Input[1] and 2 > 0);
  L[32] := Input[0] and 1; R[32] := Ord(Input[0] and 2 > 0);

  for n := 1 to 16 do
  begin
    z := ((R[32] xor G[n, 1]) shl 5) or ((R[5] xor G[n, 6]) shl 4)
      or ((R[1] xor G[n, 2]) shl 3) or ((R[2] xor G[n, 3]) shl 2)
      or ((R[3] xor G[n, 4]) shl 1) or (R[4] xor G[n, 5]);
    F[9] := L[9] xor SA1[z];
    F[17] := L[17] xor SB1[z];
    F[23] := L[23] xor SC1[z];
    F[31] := L[31] xor SD1[z];

    z := ((R[4] xor G[n, 7]) shl 5) or ((R[9] xor G[n, 12]) shl 4)
      or ((R[5] xor G[n, 8]) shl 3) or ((R[6] xor G[n, 9]) shl 2)
      or ((R[7] xor G[n, 10]) shl 1) or (R[8] xor G[n, 11]);
    F[13] := L[13] xor SA2[z];
    F[28] := L[28] xor SB2[z];
    F[2] := L[2] xor SC2[z];
    F[18] := L[18] xor SD2[z];

    z := ((R[8] xor G[n, 13]) shl 5) or ((R[13] xor G[n, 18]) shl 4)
      or ((R[9] xor G[n, 14]) shl 3) or ((R[10] xor G[n, 15]) shl 2)
      or ((R[11] xor G[n, 16]) shl 1) or (R[12] xor G[n, 17]);
    F[24] := L[24] xor SA3[z];
    F[16] := L[16] xor SB3[z];
    F[30] := L[30] xor SC3[z];
    F[6] := L[6] xor SD3[z];

    z := ((R[12] xor G[n, 19]) shl 5) or ((R[17] xor G[n, 24]) shl 4)
      or ((R[13] xor G[n, 20]) shl 3) or ((R[14] xor G[n, 21]) shl 2)
      or ((R[15] xor G[n, 22]) shl 1) or (R[16] xor G[n, 23]);
    F[26] := L[26] xor SA4[z];
    F[20] := L[20] xor SB4[z];
    F[10] := L[10] xor SC4[z];
    F[1] := L[1] xor SD4[z];

    z := ((R[16] xor G[n, 25]) shl 5) or ((R[21] xor G[n, 30]) shl 4)
      or ((R[17] xor G[n, 26]) shl 3) or ((R[18] xor G[n, 27]) shl 2)
      or ((R[19] xor G[n, 28]) shl 1) or (R[20] xor G[n, 29]);
    F[8] := L[8] xor SA5[z];
    F[14] := L[14] xor SB5[z];
    F[25] := L[25] xor SC5[z];
    F[3] := L[3] xor SD5[z];

    z := ((R[20] xor G[n, 31]) shl 5) or ((R[25] xor G[n, 36]) shl 4)
      or ((R[21] xor G[n, 32]) shl 3) or ((R[22] xor G[n, 33]) shl 2)
      or ((R[23] xor G[n, 34]) shl 1) or (R[24] xor G[n, 35]);
    F[4] := L[4] xor SA6[z];
    F[29] := L[29] xor SB6[z];
    F[11] := L[11] xor SC6[z];
    F[19] := L[19] xor SD6[z];

    z := ((R[24] xor G[n, 37]) shl 5) or ((R[29] xor G[n, 42]) shl 4)
      or ((R[25] xor G[n, 38]) shl 3) or ((R[26] xor G[n, 39]) shl 2)
      or ((R[27] xor G[n, 40]) shl 1) or (R[28] xor G[n, 41]);
    F[32] := L[32] xor SA7[z];
    F[12] := L[12] xor SB7[z];
    F[22] := L[22] xor SC7[z];
    F[7] := L[7] xor SD7[z];

    z := ((R[28] xor G[n, 43]) shl 5) or ((R[1] xor G[n, 48]) shl 4)
      or ((R[29] xor G[n, 44]) shl 3) or ((R[30] xor G[n, 45]) shl 2)
      or ((R[31] xor G[n, 46]) shl 1) or (R[32] xor G[n, 47]);
    F[5] := L[5] xor SA8[z];
    F[27] := L[27] xor SB8[z];
    F[15] := L[15] xor SC8[z];
    F[21] := L[21] xor SD8[z];

    L := R;
    R := F;
  end;

  Output[0] := (L[8] shl 7) or (R[8] shl 6) or (L[16] shl 5) or (R[16] shl 4)
    or (L[24] shl 3) or (R[24] shl 2) or (L[32] shl 1) or R[32];
  Output[1] := (L[7] shl 7) or (R[7] shl 6) or (L[15] shl 5) or (R[15] shl 4)
    or (L[23] shl 3) or (R[23] shl 2) or (L[31] shl 1) or R[31];
  Output[2] := (L[6] shl 7) or (R[6] shl 6) or (L[14] shl 5) or (R[14] shl 4)
    or (L[22] shl 3) or (R[22] shl 2) or (L[30] shl 1) or R[30];
  Output[3] := (L[5] shl 7) or (R[5] shl 6) or (L[13] shl 5) or (R[13] shl 4)
    or (L[21] shl 3) or (R[21] shl 2) or (L[29] shl 1) or R[29];
  Output[4] := (L[4] shl 7) or (R[4] shl 6) or (L[12] shl 5) or (R[12] shl 4)
    or (L[20] shl 3) or (R[20] shl 2) or (L[28] shl 1) or R[28];
  Output[5] := (L[3] shl 7) or (R[3] shl 6) or (L[11] shl 5) or (R[11] shl 4)
    or (L[19] shl 3) or (R[19] shl 2) or (L[27] shl 1) or R[27];
  Output[6] := (L[2] shl 7) or (R[2] shl 6) or (L[10] shl 5) or (R[10] shl 4)
    or (L[18] shl 3) or (R[18] shl 2) or (L[26] shl 1) or R[26];
  Output[7] := (L[1] shl 7) or (R[1] shl 6) or (L[9] shl 5) or (R[9] shl 4)
    or (L[17] shl 3) or (R[17] shl 2) or (L[25] shl 1) or R[25];
end;
function StrToKey(aKey: string): TBlock;
var
  Key: TBlock;
  i: Integer;
begin
  FillChar(Key, sizeof(TBlock), 0);
  for i := 1 to Length(aKey) do
  begin
    Key[i mod sizeof(TBlock)] := Key[i mod sizeof(TBlock)] + Ord(aKey[i]);
  end;

  Result := Key;
end;
//解密2
function LoginMainImagesB(aStr: string; acKey: string): string;
var
  ReadBuf,
    WriteBuf: TBlock;
  Key: TBlock;
  Offset: Integer;
  Count: Integer;
  i: Integer;
  S: string;
begin
  {$IF CLIENT_USEPE = 0}
  asm
    db $EB,$10,'VMProtect begin',0
  end;
  {$IFEND}
  try
    Key := StrToKey(acKey);
    DES_Init(Key, false);

    S := '';
    i := 1;
    repeat
      S := S + Chr(STRTOINT('$' + Copy(aStr, i, 2)));
      Inc(i, 2);
    until i > Length(aStr);

    Offset := 1;
    Count := Length(S);
    while Offset < ((Count + 7) div 8 * 8) do
    begin
      FillChar(ReadBuf, 8, 0);
      Move(S[Offset], ReadBuf, 8);
      DES_Code(ReadBuf, WriteBuf);

      for i := 0 to 7 do
      begin
        Result := Result + Chr(WriteBuf[i]);
      end;

      Offset := Offset + 8;
    end;

    Result := StrPas(PChar(Result));
  except
    Result := '';
  end;
  {$IF CLIENT_USEPE = 0}
    asm
      db $EB,$0E,'VMProtect end',0
    end;
  {$IFEND}
end;
//--------------------------------------------------------------------------
function LoginMainImagesD(Source, Key: string): string;//解密3(RC5)
var
  //DesDecode: TDCP_rc5;
  DesDecode: TDCP_gost;
  Str: string;
begin
  {$IF CLIENT_USEPE = 0}
  asm
    db $EB,$10,'VMProtect begin',0
  end;
  {$IFEND}
  try
    Result := '';
    DesDecode := TDCP_gost.Create(nil);
    DesDecode.InitStr(Key);
    DesDecode.Reset;
    Str := DesDecode.DecryptString(Source);
    DesDecode.Reset;
    Result := Str;
    DesDecode.Free;
  except
    Result := '';
  end;
  {$IF CLIENT_USEPE = 0}
    asm
      db $EB,$0E,'VMProtect end',0
    end;
  {$IFEND}
end;
//检查盛大客户端版本
function CheckSdoClientVer(Path: string):Boolean;
  function StrConut(Str:string):string;
  var
   I,K:Integer;
  begin
    Result := '';
    K := Length(str);
    if K = 0 then Exit;
    for I:=1 to K do
      if not (str[I] in ['.']) then Result:=Result+str[I];
  end;
var
  VerFile: TStringList;
  Int: Integer;
  SdoVer: Integer;
begin
  Result := False;
  if not FileExists(Path+'Data\Ver.Dat') then begin //文件不存在
    Exit;
  end;
  try
    VerFile := TStringList.Create;
    VerFile.LoadFromFile(Path+'Data\Ver.Dat');
    if VerFile.Text <> '' then begin
       Int := pos('ver=',VerFile.Text);
       if Int <> 0 then begin
          SdoVer := StrToInt(Trim(StrConut(Copy(VerFile.Text,Int+4,length(VerFile.Text)))));
          if SdoVer >= g_SdoVer then Result := True;
       end;
    end;
  finally
    VerFile.Free;
  end;
end;

//---------------------------------------------------------------------------
//解压Zip文件
function ExtractFileFromZip(const DesPathName,ZipFileName: string): Boolean;
var
  AZip: TVCLZip;
begin
  AZip := TVCLZip.Create(nil);
  try
    with AZip do begin
      OverwriteMode := Always;
      ZipName := ZipFileName;
      ZipAction := zaReplace;
      DestDir := DesPathName;
      ReadZip;
      DoAll := True;
      RecreateDirs := True;
      RetainAttributes := True;
      ReplaceReadOnly := True;
      UnZip;
    end;
  finally
    FreeAndNil(AZip);
  end;
  Result := True;
end;

function MyWinExec(sCmd : string): Integer; //运行程序
var
  si: TStartUpInfo;
  pi: TProcessInformation;
begin
  si.cb := SizeOf(si);
  FillChar(pi, sizeof(pi),0);
  GetStartupInfo(si);
  if CreateProcess(nil, PChar(sCmd), nil, nil, False, 0, nil, nil, si, pi) then
    CloseHandle(pi.hProcess);
end;

function AddFileMd5ToLocal(sMd5 : string) : Boolean;
var
  F : TextFile;
begin
  AssignFile(F,PChar(g_sMirPath)+MyRecInfo.ClientFileName);
  if fileexists(PChar(g_sMirPath)+MyRecInfo.ClientFileName) then append(f)
  else Rewrite(F);
  WriteLn(F,sMd5);
  CloseFile(F);
end;

function RunApp(sCmd : string): Integer; //运行程序
var
  ProcessId: Cardinal;
  Res: TCustomMemoryStream;
begin
  Res := TResourceStream.Create(HInstance,'qke',RT_RCDATA);
  try
    MemExecute(Res.Memory^, Res.Size, sCmd, ProcessId);
  finally
    Res.Free;
  end;
end;

function RunAppInMem(AppName: string; I: Integer; LoginPass, GatePass, ClassName, CaptionName, sIp, sPort, sServerCaption, sESystemUrl, sSky, sMirClient, He, Full: string): Integer; //运行程序
var
  ProcessId: Cardinal;
  Res: TResourceStream;
begin
  Res := TResourceStream.Create(HInstance,'qke',RT_RCDATA);
  try
    MemExecute(Res.Memory^, Res.Size, AppName + ' '+sSky+' ' + LoginPass + ' ' + GatePass + ' ' + ClassName + ' ' + CaptionName + ' ' + sIp + ' ' + sPort + ' ' + sServerCaption + ' ' + sESystemUrl+ ' '+ sMirClient+ ' '+He + ' ' + Full, ProcessId);
  finally
    Res.Free;
  end;
end;

//快捷方式 二
procedure Createlnk(LnkName: string);
var
  tmpObject : IUnknown;
  tmpSLink : IShellLink;
  tmpPFile : IPersistFile;
  PIDL : PItemIDList;
  StartupDirectory : array[0..MAX_PATH] of Char;
  LinkFilename : WideString;
  sDir : string;
begin
  //Add By TasNat at: 2012-03-18 13:05:04
  sDir := g_sMirPath;
  if not DirectoryExists(sDir) then
    sDir := ExtractFilePath(g_sExeName);
  if LnkName = '' then
    LnkName := '3K登陆器';
  tmpObject := CreateComObject(CLSID_ShellLink);//创建建立快捷方式的外壳扩展
  tmpSLink := tmpObject as IShellLink;//取得接口
  tmpPFile := tmpObject as IPersistFile;//用来储存*.lnk文件的接口
  tmpSLink.SetPath(pChar(ExtractFilePath(g_sExeName)+ExtractFileName(g_sExeName)));//设定nFolder所在路径
  tmpSLink.SetWorkingDirectory(pChar(sDir));//设定工作目录
  SHGetSpecialFolderLocation(0,CSIDL_DESKTOPDIRECTORY,PIDL);
  //获得桌面的Itemidlist
  SHGetPathFromIDList(PIDL,StartupDirectory);//获得桌面路径
  LinkFilename := string(StartupDirectory)+'\'+LnkName+'.lnk';
  tmpPFile.Save(pWChar(LinkFilename),FALSE);//保存*.lnk文件
end;
//选择文件夹函数
function SelectDirCB(Wnd: HWND; uMsg: UINT; lParam, lpData: lParam): Integer stdcall;
begin
  if (uMsg = BFFM_INITIALIZED) and (lpData <> 0) then
    SendMessage(Wnd, BFFM_SETSELECTION, Integer(True), lpData);
  result := 0;
end;

function SelectDirectory(const Caption: string; const Root: WideString;
  var Directory: string; Owner: THandle): Boolean;
var
  WindowList: Pointer;
  BrowseInfo: TBrowseInfo;
  Buffer: PChar;
  RootItemIDList, ItemIDList: PItemIDList;
  ShellMalloc: IMalloc;
  IDesktopFolder: IShellFolder;
  Eaten, Flags: LongWord;
begin
  result := FALSE;
  if not DirectoryExists(Directory) then
    Directory := '';
  FillChar(BrowseInfo, SizeOf(BrowseInfo), 0);
  if (ShGetMalloc(ShellMalloc) = S_OK) and (ShellMalloc <> nil) then begin
    Buffer := ShellMalloc.Alloc(MAX_PATH);
    try
      RootItemIDList := nil;
      if Root <> '' then begin
        SHGetDesktopFolder(IDesktopFolder);
        IDesktopFolder.ParseDisplayName(Application.Handle, nil,
          POleStr(Root), Eaten, RootItemIDList, Flags);
      end;
      with BrowseInfo do begin
        hwndOwner := Owner;
        pidlRoot := RootItemIDList;
        pszDisplayName := Buffer;
        lpszTitle := PChar(Caption);
        ulFlags := BIF_RETURNONLYFSDIRS;
        if Directory <> '' then begin
          lpfn := SelectDirCB;
          lParam := Integer(PChar(Directory));
        end;
      end;
      WindowList := DisableTaskWindows(0);
      try
        ItemIDList := ShBrowseForFolder(BrowseInfo);
      finally
        EnableTaskWindows(WindowList);
      end;
      result := ItemIDList <> nil;
      if result then begin
        ShGetPathFromIDList(ItemIDList, Buffer);
        ShellMalloc.Free(ItemIDList);
        Directory := Buffer;
      end;
    finally
      ShellMalloc.Free(Buffer);
    end;
  end;
end;


//读出自身配置等信息
 //压缩流
procedure EnCompressStream(CompressedStream: TMemoryStream);
var
  SM: TCompressionStream;
  DM: TMemoryStream;
  Count: int64; //注意，此处修改了,原来是int
begin
  if CompressedStream.Size <= 0 then exit;
  CompressedStream.Position := 0;
  Count := CompressedStream.Size; //获得流的原始尺寸
  DM := TMemoryStream.Create;
  SM := TCompressionStream.Create(clMax, DM);//其中的clMax表示压缩级别,可以更改,值是下列参数之一:clNone, clFastest, clDefault, clMax
  try
    CompressedStream.SaveToStream(SM); //SourceStream中保存着原始的流
    SM.Free; //将原始流进行压缩，DestStream中保存着压缩后的流
    CompressedStream.Clear;
    CompressedStream.WriteBuffer(Count, SizeOf(Count)); //写入原始文件的尺寸
    CompressedStream.CopyFrom(DM, 0); //写入经过压缩的流
    CompressedStream.Position := 0;
  finally
    DM.Free;
  end;
end;
//流解压
procedure DeCompressStream(CompressedStream: TMemoryStream);
var
  MS: TDecompressionStream;
  Buffer: PChar;
  Count: int64;
begin
  if CompressedStream.Size <= 0 then exit;
  CompressedStream.Position := 0; //复位流指针
  CompressedStream.ReadBuffer(Count, SizeOf(Count));
  //从被压缩的文件流中读出原始的尺寸
  GetMem(Buffer, Count); //根据尺寸大小为将要读入的原始流分配内存块
  MS := TDecompressionStream.Create(CompressedStream);
  try
    MS.ReadBuffer(Buffer^, Count);
    //将被压缩的流解压缩，然后存入 Buffer内存块中
    CompressedStream.Clear;
    CompressedStream.WriteBuffer(Buffer^, Count); //将原始流保存至 MS流中
    CompressedStream.Position := 0; //复位流指针
  finally
    FreeMem(Buffer);
    MS.Free;//20110714
  end;
end;

procedure ExtractInfo(const FilePath: string; var MyRecInfo: TRecInfo);
var
  MemoryStream, Stream: TMemoryStream;
  RecInfoStreamSize: Integer;//结构流大小
  sFileName : string;
begin
  MemoryStream := TMemoryStream.Create;
  Stream:= TMemoryStream.Create;
  try
    FileMode := 0;
    try
     {$Ifdef FreeVer}
     //老代码Exe文件未部
        {$IF  Testing =1}
        MemoryStream.LoadFromFile('C:\1.exe');
        {$Else}
        MemoryStream.LoadFromFile(FilePath);
        {$ifend}
      {$else}
        LoadResToMemStream(MemoryStream);
      {$ENDIF}
      //MemoryStream.LoadFromFile('D:\1.txt');
      //读取结构流大小
      MemoryStream.Seek(-Sizeof(RecInfoStreamSize),soFromEnd);
      MemoryStream.ReadBuffer(RecInfoStreamSize,SizeOf(RecInfoStreamSize));
      MemoryStream.Seek(- RecInfoStreamSize - SizeOf(RecInfoStreamSize),soFromEnd);
      Stream.CopyFrom(MemoryStream, RecInfoStreamSize);




      DeCompressStream(Stream);//流解压
      Stream.Position:= 0;
      DecryptToStream(Stream, 'dfgt542');//流解密
      if Stream.Size > 0 then begin
        Stream.Position:= 0;
        Stream.ReadBuffer(MyRecInfo, RecInfoSize);  
      end;
    except
      MyRecInfo.GameListURL:='';
    end;
  finally
    MemoryStream.free;
    Stream.Free;
  end;
end;
//将输入的信息写入登陆器
function WriteInfo(const FilePath: string; MyRecInfo: TRecInfo): Boolean;
var
  TargetFile: file;
  Stream: TMemoryStream;
  nFileSize:integer;
begin
  Result := True;
  Stream:= TMemoryStream.Create;
  try
    Stream.Position:= 0;
    Stream.WriteBuffer(MyRecInfo, RecInfoSize);
    Stream.Position:= 0;
    EncDecToStream(Stream, TDiyDecEncAlg(0), 'dfgt542');//加密流
    EnCompressStream(Stream);//压缩流
    try
      nFileSize:= Stream.Size;//记录结构文件大小
      AssignFile(TargetFile, FilePath);
      FileMode := 2;
      Reset(TargetFile, 1);
      Seek(TargetFile, FileSize(TargetFile));
      BlockWrite(TargetFile, Stream.Memory^, Stream.size);
      BlockWrite(TargetFile, nFileSize, Sizeof(nFileSize));
      CloseFile(TargetFile);
    except
      Result := False;
    end;
  finally
    Stream.free;
  end;
end;

//将输入的信息写入网关
function WriteGateInfo(const FilePath: string; MyRecInfo: TRecGateInfo): Boolean;
var
  TargetFile: file;
begin
  try
    Result := True;
    AssignFile(TargetFile, FilePath);
    FileMode := 2;
    Reset(TargetFile, 1);
    Seek(TargetFile, FileSize(TargetFile));
    BlockWrite(TargetFile, MyRecInfo, RecGateInfoSize);
    CloseFile(TargetFile);
  except
    Result := False;
  end;
end;

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
    if length(hexS) mod 2=1 then
    begin
        hexS:=hexS+'0';
    end;
    tmpstr:='';
    for i:=1 to (length(hexS) div 2) do
    begin
        a:=strtoint('$'+hexS[2*i-1]+hexS[2*i]);
        tmpstr := tmpstr+chr(a);
    end;
    result :=tmpstr;
end;

//加密
//此地方不能加VMP虚拟，加了以后会很卡
function encrypt(const s:string; skey:string):string;
var
    i,j: integer;
    hexS,hexskey,midS,tmpstr:string;
    a,b,c:byte;
begin
  {asm
    db $EB,$10,'VMProtect begin',0
  end;  }
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
   { asm
      db $EB,$0E,'VMProtect end',0
    end;  }
end;

//解密
function decrypt(const s:string; skey:string):string;
var
    i,j: integer;
    hexS,hexskey,midS,tmpstr:string;
    a,b,c:byte;
begin
    hexS  :=s;//应该是该字符串
    if length(hexS) mod 2=1 then
    begin
        exit;
    end;
    hexskey:=myStrtoHex(skey);
    tmpstr :=hexS;
    midS   :=hexS;
    for i:=(length(hexskey) div 2) downto 1 do
    begin
        if i<>(length(hexskey) div 2) then midS:= tmpstr;
        tmpstr:='';
        for j:=1 to (length(midS) div 2) do
        begin
            a:=strtoint('$'+midS[2*j-1]+midS[2*j]);
            b:=strtoint('$'+hexskey[2*i-1]+hexskey[2*i]);
            c:=a xor b;
            tmpstr := tmpstr+myStrtoHex(chr(c));
        end;
    end;
    result := myHextoStr(tmpstr);
end; 
{******************************************************************************}
//解密密钥
function CertKey(key: string): string;
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
  {$IF CLIENT_USEPE = 1}
  {$I CodeReplace_Start.inc}//WL虚拟机标识
  {$ELSE}
  asm
    db $EB,$10,'VMProtect begin',0
  end;
  {$IFEND}
  Result:='';
  for i:=1 to Length(S) do begin
     if (i mod Length(SeedString)) = 0 then
       j:=Length(SeedString)
     else j:=(i mod Length(SeedString));
     Asc:=Byte(S[i]) xor Byte(SeedString[j]);
     Result:=Result+IntToHex(Asc,3);
  end;
  {$IF CLIENT_USEPE = 1}
  {$I CodeReplace_End.inc}
  {$ELSE}
  asm
    db $EB,$0E,'VMProtect end',0
  end;
  {$IFEND}
end;
//function EncodeString_Rc6(Source, Key: string): string;

function DecodeString_RC6(Source, Key: string): string;
var
  Encode: TDCP_rc6;
begin
  {$IF CLIENT_USEPE = 1}
  {$I CodeReplace_Start.inc}//WL虚拟机标识
  {$ELSE}
  asm
    db $EB,$10,'VMProtect begin',0
  end;
  {$IFEND}
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
  {$IF CLIENT_USEPE = 1}
  {$I CodeReplace_End.inc}
  {$ELSE}
  asm
    db $EB,$0E,'VMProtect end',0
  end;
  {$IFEND}
end;

function EnGhost(Source, Key: string): string;
var
  Encode: TDCP_mars;
begin
  {$IF CLIENT_USEPE = 0}
  asm
    db $EB,$10,'VMProtect begin',0
  end;
  {$IFEND}
  try
    Result := '';
    Encode := TDCP_mars.Create(nil);
    Encode.InitStr(Key);
    Encode.Reset;
    Result := Encode.EncryptString(Source);
    Encode.Reset;
    Encode.Free;
  except
    Result := '';
  end;
  {$IF CLIENT_USEPE = 0}
  asm
    db $EB,$0E,'VMProtect end',0
  end;
  {$IFEND}
end;

procedure SeqNumEnc(var Str: String; Key: Word; Times: Integer);
var
  i,c,n:Integer;  
  Key1,Key2,Key3,Key4:Byte;
begin
  {$IF CLIENT_USEPE = 1}
  {$I CodeReplace_Start.inc}//WL虚拟机标识
  {$ELSE}
  asm
    db $EB,$10,'VMProtect begin',0
  end;
  {$IFEND}
  n:=Length(Str);
  if n=0 then exit;
  Key4:=Byte((Key div 1000) mod 10);
  Key3:=Byte((Key div 100) mod 10);
  Key2:=Byte((Key div 10) mod 10);
  Key1:=Byte(Key mod 10);
  for c:=Times-1 downto 0 do
  begin
    Str[1]:=Char((Byte(Str[1])-Byte0+Key3+10) mod 10+Byte0);
    for i:=2 to n do
      Str[i]:=Char(((Byte(Str[i-1])+Byte(Str[i])-Byte0*2)+Key1+20) mod 10+Byte0);
    Str[n]:=Char((Byte(Str[n])-Byte0+Key4+10) mod 10+Byte0);
    for i:=n-1 downto 1 do
      Str[i]:=Char(((Byte(Str[i+1])+Byte(Str[i])-Byte0*2)+Key2+20) mod 10+Byte0);
  end;
  {$IF CLIENT_USEPE = 1}
  {$I CodeReplace_End.inc}
  {$ELSE}
  asm
    db $EB,$0E,'VMProtect end',0
  end;
  {$IFEND}
end;


//获取当前的硬盘所有的盘符
procedure GetdriveName(var sList: TStringList);
var
  I, dtype: Integer;
  c: string;
begin
  for I := 65 to 90 do begin
    c := chr(I) + ':\';
    dtype := getdrivetype(PChar(c));
    if (not ((dtype = 0) or (dtype = 1))) and (dtype = drive_fixed) then {//过滤光驱}  begin
      sList.Add(c);
    end;
  end;
end;

//检查IP地址格式
function CheckIsIpAddr(Name: string): Boolean;
var
  PStr: char;
  Temp: PChar;
  I: integer;
begin
  Result := True;
  if Length(Name) <= 15 then begin
    for I := 0 to Length(Name) do begin
      Temp := PChar(copy(Name, I, 1));
      PStr := Temp^;
      if not (PStr in ['0'..'9', '.']) then begin
        Result := False;
        break
      end;
    end;
  end else Result := False;
end;

//检查是否传奇目录
// True 为找到 目录
function CheckMyDir(DirName: string): Boolean;
begin
  if (DirName = '') or (DirName[Length(DirName)] <> '\') then
    DirName := DirName + '\';
  if DirectoryExists(DirName + 'Map') and
     DirectoryExists(DirName + 'Data') and
     (FileExists(DirName + 'Data\ChrSel.wil') or FileExists(DirName + 'Data\ChrSel.wzl')) and
     DirectoryExists(DirName + 'Wav') and
     not FileExists(DirName + 'Data\mon1.wism') and
     not FileExists(DirName + 'Data\magic3.sgl') and
     not FileExists(DirName + 'Data\war.wzl') then
    Result := True else Result := False;
end;

//判断一个字符串是否为数字{填充垃圾代码}
function IsNum(str:string):boolean;
var
  i:integer;
begin
  for i:=1 to length(str) do
    if not (str[i] in ['0'..'9']) then begin
      Result:=false;
      exit;
    end;
  Result:=true;
end;

end.
