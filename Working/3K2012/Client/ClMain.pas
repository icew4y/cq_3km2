unit ClMain;

interface

uses                  
  Windows, Messages, SysUtils, Graphics, Controls, Forms, Dialogs,
  JSocket, DxDraws, DirectX, DXClass, DrawScrn,
  IntroScn, PlayScn, MapUnit, WIL, Grobal2, DShow,
  Actor, DIB, StdCtrls, CliUtil, HUtil32, EdCode,
  DWinCtl, ClFunc, magiceff, SoundUtil, DXSounds, clEvent, 
  Mpeg, MShare, Share, ExtCtrls,PathFind, ActnList, Classes, EDcodeUnit, Md5, uDTreeView,CnHashTable;

const
   NEARESTPALETTEINDEXFILE = 'Data\npal.idx';
   UiImageDir     = '\Data\Ui\';
   BookImageDir   = '\Data\Books\';
   MinimapImageDir= '\Data\Minimap\';
type
  //·´HOOK
  THelperHu = function(lpLibFileName: PAnsiChar): HMODULE; stdcall;
  THelperHu1 = function(dwDesiredAccess: DWORD; bInheritHandle: BOOL; lpName: PAnsiChar): THandle; stdcall; //·´Íâ¹ÒÄÚ´æ¹²Ïí

  //Ô¶³Ì×¢Èë
  //THelperHu2 = function (hProcess: THandle; lpThreadAttributes: Pointer; dwStackSize: DWORD; lpStartAddress: TFNThreadStartRoutine; lpParameter: Pointer; dwCreationFlags: DWORD; var lpThreadId: DWORD): THandle; stdcall; //TCreateRemoteThread
  ThelperHu3 = function (dwDesiredAccess: DWORD; bInheritHandle: BOOL; dwProcessId: DWORD): THandle; stdcall; //TOpenProcess

  //TReadProcessMemory = function (hProcess: THandle; const lpBaseAddress: Pointer; lpBuffer: Pointer;
  //  nSize: DWORD; var lpNumberOfBytesRead: DWORD): BOOL; stdcall;
  TWriteProcessMemory = function (hProcess: THandle; const lpBaseAddress: Pointer; lpBuffer: Pointer;
    nSize: DWORD; var lpNumberOfBytesWritten: DWORD): BOOL; stdcall;

  TOneClickMode = (toNone, toKornetWorld);

  TfrmMain = class(TDxForm)
    CSocket: TClientSocket;
    Timer1: TTimer;
    MouseTimer: TTimer;
    WaitMsgTimer: TTimer;
    SelChrWaitTimer: TTimer;
    CmdTimer: TTimer;
    MinTimer: TTimer;
    DXDraw: TDXDraw;
    UiDXImageList: TDXImageList;
    CloseTimer: TTimer;
    TimerBrowserUpdate: TTimer;
    AutoFindPathTimer: TTimer;
    ActionList: TActionList;
    ActCallHeroKey: TAction;
    ActHeroAttackTargetKey: TAction;
    ActHeroGotethKey: TAction;
    ActHeroStateKey: TAction;
    ActHeroGuardKey: TAction;
    ActAttackModeKey: TAction;
    ActMinMapKey: TAction;
    CountDownTimer: TTimer;
    ActSeriesKillKey: TAction;
    ActCallHero1Key: TAction;
    
    procedure DXDrawInitialize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DXDrawMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DXDrawMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure CSocketConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure CSocketDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure CSocketError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure CSocketRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure Timer1Timer(Sender: TObject);
    procedure DXDrawMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MouseTimerTimer(Sender: TObject);
    procedure DXDrawDblClick(Sender: TObject);
    procedure WaitMsgTimerTimer(Sender: TObject);
    procedure SelChrWaitTimerTimer(Sender: TObject);
    procedure DXDrawClick(Sender: TObject);
    procedure CmdTimerTimer(Sender: TObject);
    procedure MinTimerTimer(Sender: TObject);
//    procedure SpeedHackTimerTimer(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    //procedure LoadUib; //20080104  Ó¢ÐÛ´øÖÒ×ÖÍ¼±ê(¼ÓÔØuibºó×ºÎÄ¼þ)
    procedure CloseTimerTimer(Sender: TObject);
    procedure TimerBrowserUpdateTimer(Sender: TObject);
    procedure SendHeroMagicKeyChange (magid: integer; keych: char; str: string);
    procedure GetCheckNum();
    procedure SendCheckNum (num: string);
    procedure SendChangeCheckNum();
    procedure AutoFindPathTimerTimer(Sender: TObject);
{    procedure Autorun;
    function FindPath(Startx, Starty, end_x, end_y: Integer;boHint: Boolean):Boolean;
    procedure ClearRoad; }
    function  GetMagicByID (Id: Byte): Boolean;
    procedure SendMakeWineItems();
    procedure ActCallHeroKeyExecute(Sender: TObject);
    procedure OpenSdoAssistant();
    procedure SendChallenge;
    procedure SendAddChallengeItem (ci: TClientItem);
    procedure SendCancelChallenge;
    procedure SendDelChallengeItem (ci: TClientItem);
    procedure ClientGetChallengeRemoteAddItem (body: string);
    procedure ClientGetChallengeRemoteDelItem (body: string);
    procedure SendChallengeEnd;
    procedure SendChangeChallengeGold (gold: integer);
    procedure SendChangeChallengeDiamond (Diamond: integer);
    procedure SendHeroAutoOpenDefence (Mode: integer);
    procedure SendHeroUseBatterToMon (Mode: integer);
    procedure ClientGetReceiveDelChrs (body: string;DelChrCount: Integer);
    procedure SendQueryDelChr();
    procedure SendResDelChr(Name: string);
    procedure CountDownTimerTimer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TimerGateCheckTimer(Sender: TObject);
  private
    SocStr, BufferStr: string;
    TimerCmd: TTimerCommand;
    MakeNewId: string;
    m_Point: TPoint;
    ActionLockTime: LongWord;
    LastHitTick: LongWord;
    ActionFailLock: Boolean;
    ActionFailLockTime:LongWord;
    FailAction, FailDir: integer;
    ActionKey: word;

    MouseDownTime: longword;
    WaitingMsg: TDefaultMessage;
    WaitingStr: string;
    WhisperName: string;
    procedure AutoPickUpItem();
    procedure ProcessKeyMessages;
    procedure ProcessActionMessages; //ÄÚ²¿ÏûÏ¢
    //procedure CheckSpeedHack (rtime: Longword);
    procedure DecodeMessagePacket (datablock: string);
    procedure ActionFailed;
    function  GetMagicByKey (Key: char): PTClientMagic;
    procedure UseMagic (tx, ty: integer; pcm: PTClientMagic);
    procedure UseJNMagic(tx,ty:integer; itemindex: integer);
    {$IF M2Version = 1}
    function UseBatterSpell(tx, ty: integer): Boolean;//Ê¹ÓÃÁ¬»÷ 20090703
    {$IFEND}
    procedure UseMagicSpell (who, effnum, targetx, targety, magic_id, effectLevelEx: integer);
    procedure UseMagicFire (who, efftype, effnum, targetx, targety, target, MagDu: integer);
    procedure UseMagicFireFail (who: integer);
    procedure CloseAllWindows;
    procedure ClearDropItems;
    procedure ResetGameVariables;
    procedure ChangeServerClearGameVariables;
    procedure _DXDrawMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure AttackTarget (target: TActor);
    function AutoLieHuo: Boolean; //×Ô¶¯ÁÒ»ð
    function AutoZhuri: Boolean;
    function NearActor : Boolean; //×Ô¶¯ÒþÉí£¬×Ô¶¯Ä§·¨¶Ü    //×Ô¶¯¿¹¾Ü
    procedure AutoEatItem;//±£»¤
    procedure AutoHeroEatItem; //±£»¤
    procedure AutoButch;//×Ô¶¯ÍÚÈ¡
    function  CheckDoorAction (dx, dy: integer): Boolean;
    procedure ClientGetNeedUpdateAccount (body: string);
    procedure ClientGetSelectServer;
    procedure ClientGetPasswordOK(Msg:TDefaultMessage; sBody:String);
    procedure ClientGetReceiveChrs (body: string);
    procedure ClientGetStartPlay (body: string);
    procedure ClientGetReconnect (body: string);
    procedure ClientGetServerConfig(Msg:TDefaultMessage;sBody:String);
    procedure ClientGetServerUnBind(Body:String);
    procedure ClientGetMapDescription (Msg:TDefaultMessage;sBody:String);
    procedure ClientGetGameGoldName (Msg:TDefaultMessage;sBody:String);
    procedure ClientGetAdjustBonus (bonus: integer; body: string);
    procedure ClientGetAddItem (body: string);
    procedure ClientGetUpdateItem (body: string);
    procedure ClientGetDelItem (body: string); 
    procedure ClientGetDelItems (body: string);
    procedure ClientGetBagItmes (body: string);
    procedure ClientGetDropItemFail (iname: string; sindex: integer);
    procedure ClientGetShowItem (itemid, x, y, looks: integer; itmname: string);
    procedure ClientGetHideItem (itemid, x, y: integer);
    procedure ClientGetSenduseItems (body: string);
    procedure ClientGetHeroDelItem (body: string);
    procedure ClientGetUserOrder (body: string);
    procedure ClientGetHeroDelItems (body: string);
    procedure ClientGetHeroAddMagic (body: string);
    procedure ClientGetHeroDelMagic (magid: integer);
    procedure ClientGetHeroMagicLvExp (magid, maglv, magtrain, magExp: integer);
    procedure ClientGetHeroDropItemFail (iname: string; sindex: integer);
    procedure ClientHeroGetBagItmes (body: string);
    procedure ClientGetSendHeroItems (body: string); //´Ó·þÎñ¶Ë»ñÈ¡Ó¢ÐÛÎïÆ·ID
    procedure ClientGetHeroMagics (body: string);
    procedure ClientGetHeroUpdateItem (body: string);
    procedure ClientGetHeroAddItem (body: string);
    procedure ClientGetHeroDuraChange (uidx, newdura, newduramax: integer);  //Ó¢ÐÛ³Ö¾Ã
    procedure ClientGetExpTimeItemChange (uidx, NewTime: integer);  //¾ÛÁéÖéÊ±¼ä¸Ä±ä 20080307
    procedure ClientGetAddMagic (body: string);
    procedure ClientGetDelMagic (magid: integer);
    procedure ClientGetMyShopSpecially (body: string); //ÉÌÆÌÆæÕä 2007.11.14
    procedure ClientGetMyShop (body: string); //ÉÌÆÌ  2007.11.14
    procedure ClientGetMyBoxsItem (body: string); //½ÓÊÕ±¦ÏäÎïÆ· 2008.01.16
    procedure ClientGetJLBoxItems (body: string); //½ÓÊÕÕäçç±¦ÏäÎïÆ·
    procedure ClientGetJLBoxFreeItems (body: string); //½ÓÊÕÕäçç±¦Ïä×ÓÃâ·Ñ½±Àø
    procedure ClientGetJLBoxItemOK();//»ñÈ¡Õäçç±¦ÏäÎïÆ·³É¹¦
    procedure ClientGetBoxsItemFilled(playGetItmesID,FilledGetItmesID:Integer); //playGetItmesIDÍæ¼ÒµÃµ½µÄÎïÆ·,playGetItmeIDÌî³äµÄÎïÆ·

    procedure ClientGetMyMagics (body: string);
    procedure ClientGetMagicLvExp (magid, maglv, magtrain, magExp: integer);
    procedure ClientGetMagicLvExExp (magid, magExp: integer);

    procedure ClientGetDuraChange (uidx, newdura, newduramax: integer);
    procedure ClientGetMerchantSay (merchant, face, WinType: integer; saying: string);
    procedure ClientGetSendGoodsList (merchant, count: integer; body: string);
    procedure ClientGetSendMakeDrugList (merchant: integer; body: string);
    procedure ClientGetSendUserSell (merchant: integer);
    procedure ClientGetSendUserSellOff (merchant: integer); //Ôª±¦¼ÄÊÛÏÔÊ¾´°¿Ú 20080316
    procedure ClientGetSellOffMyItem (body: string); //¿Í»§¶Ë¼ÄÊÛ²éÑ¯¹ºÂòÎïÆ· 20080317
    procedure ClientGetSellOffSellItem (body: string); //¿Í»§¶Ë¼ÄÊÛ²éÑ¯³öÊÛÎïÆ· 20080317
    procedure ClientGetSendUserRepair (merchant: integer);
    procedure ClientGetPasswdSuccess (Msg:TDefaultMessage;body: string);
    procedure ClientGetSendUserStorage (merchant: integer);
    procedure ClientGetSendUserPlayDrink(merchant: integer);
    procedure ClientGetSaveItemList (merchant: integer; bodystr: string);
    procedure ClientGetSendDetailGoodsList (merchant, count, topline: integer; bodystr: string);
    procedure ClientGetSendNotice (body: string);
    procedure ClientGetGroupMembers (bodystr: string);
    procedure ClientGetOpenGuildDlg (bodystr: string);
    procedure ClientGetSendGuildMemberList (body: string);
    procedure ClientGetDealRemoteAddItem (body: string);
    procedure ClientGetDealRemoteDelItem (body: string);
    procedure ClientGetReadMiniMap (mapindex: integer);
    procedure ClientGetChangeGuildName (body: string);
    procedure ClientGetSendUserState (body: string);
//    procedure ClientGetNeedPassword(Body:String);
    procedure SetInputStatus();
{    procedure CmdShowHumanMsg(sParam1, sParam2, sParam3, sParam4,    20080723×¢ÊÍ
      sParam5: String);  }
   // procedure ShowHumanMsg(Msg: pTDefaultMessage);  20080723×¢ÊÍ
    procedure LoadFriendList();
    procedure SaveFriendList();
    procedure SaveTargetList();
    procedure LoadTargetList();
    procedure SaveHeiMingDanList();
    procedure LoadHeiMingDanList();
    function InHeiMingDanListOfName(sUserName: string): Boolean;
    function InFriendListOfName(sUserName: string):Boolean;
//    procedure FreeTree();  //×Ô¶¯Ñ°Â·ÊÍ·ÅÄÚ´æ
    procedure LoadMapDesc(); //¼ÓÔØÐ¡µØÍ¼ÎÄ±¾×¢ÊÍ 20090213
    procedure LoadTzHint();
    procedure LoadItemDesc();
    {$IF M2Version <> 2}
    procedure LoadTitleDesc();
    {$IFEND}
    procedure LoadSkillDesc();
    procedure LoadPulsDesc();
    procedure ClientAutoGotoXY(nX, nY: Integer);
    procedure ClientJLBoxKey();
    procedure OPENSHINY(body: string);
    //procedure CheckHanld();
    procedure NeiGuaConfig(body: string);  //Ò©Æ·×Ô¶¨ÒåÃû×Ö

    {$IF M2Version <> 2}
    procedure ClientGetSendUserArmsExchange(merchant: integer);
    procedure ClientGetSendUserArmsTear (merchant: integer);//ÎäÆ÷²ðÐ¶³àÑ×Ê¯ 20100708
    procedure ClientGetMoveHMShow(ActorId: Integer; SessionID: Integer);
    procedure ClientGetSigned();
    procedure ClientGetSignedItem (body: string);
    procedure ClientGetNGUpLevel(msg: TDefaultMessage; boIsHero: Boolean);

    procedure ClientGetFactionList (const body: string);
    procedure ClientGetOpenFactionDlg (bodystr: string);
    procedure ClientGetFactionMemberList (body: string);
    procedure ClientGetFactionApplyManageList(body: string);
    procedure ClientOpenLingWuXinFa(msg: TDefaultMessage);
    procedure ClientGetHeartInfo (body: string);
    {$IFEND}
{******************************************************************************}
//À¹½ØTAB¼ü ÏûÏ¢  20080314
    procedure CMDialogKey(var msg: TCMDialogKey); message CM_DIALOGKEY;
{******************************************************************************}
  public
    LoginId, LoginPasswd, CharName: string;
    Certification: integer;
    TempCertification: Word;//20091026 ¶¯Ì¬ÃÜÔ¿
    ActionLock: Boolean;
    m_nSendMsgCount: Word;//½ÓÊÕÏûÏ¢µÄ´ÎÊý£¬ÓëM2¶ÔÓ¦£¬²»È»ÎÞ·¨·¢ËÍCM_ÏûÏ¢ 20100109
    function UiImages(Index: Integer): TDirectDrawSurface;
    procedure ShowMyShow(Actor: TActor; TypeShow:Integer);  //ÏÔÊ¾×ÔÉí¶¯»­
    procedure WMSysCommand(var Message: TWMSysCommand); message WM_SYSCOMMAND;
    procedure ProcOnIdle;
    procedure DrawEffectHum(ActorId, nType,nX,nY, TargetID:Integer);
    procedure AppOnIdle (Sender: TObject; var Done: Boolean);
    procedure AppLogout(flag: Boolean);
    procedure AppExit;
    procedure PrintScreenNow;
    procedure EatItem (idx: integer);
    function EatAutoOpenItem (idx: Integer): Boolean;
    {$IF M2Version <> 2}
    function EatAutoHeroOpenItem (idx: Integer): Boolean;
    {$IFEND}
    procedure HeroEatItem (idx: integer);  //Ó¢ÐÛÔÚ°ü¹üË«»÷ÎïÆ·
    procedure SendClientMessage (msg, Recog, param, tag, series: integer);
    procedure SendLogin (uid, passwd: string);
    procedure SendNewAccount (ue: TUserEntry; ua: TUserEntryAdd);
    procedure SendUpdateAccount (ue: TUserEntry; ua: TUserEntryAdd);
    procedure SendSelectServer (svname: string);
    procedure SendChgPw (id, passwd, newpasswd: string);
    procedure SendNewChr (uid, uname, shair, sjob, ssex: string);
    procedure SendQueryChr(Code:Byte); //CodeÎª1Ôò²éÑ¯ÑéÖ¤Âë  Îª0Ôò²»²éÑ¯
    procedure SendDelChr (chrname: string);
    procedure SendSelChr (chrname: string);
    procedure SendRunLogin;
    procedure SendSay (str: string);
    procedure SendActMsg (ident, x, y, dir: integer);
    procedure SendSpellMsg (ident, x, y, dir, target: integer; itemindex: string);
    procedure SendQueryUserName (targetid, x, y: integer);
    procedure SendDropItem (name: string; itemserverindex: integer);
    procedure SendPickup;
    procedure SendTakeOnItem (where: byte; itmindex: integer; itmname: string);
    procedure SendTakeOffItem (where: byte; itmindex: integer; itmname: string);
    procedure SendItemUpOK(); //´ãÁ¶µãÈ·¶¨·¢ÏûÏ¢ 20080507
    procedure ClientGetUpDateUpItem (body: string); //¸üÐÂ´âÁ·ÎïÆ·! 20080507
    procedure ClientGetHeroInfo (body: string);
    procedure ClientGetDeputyHeroInfo (body: string);
    //·¢ËÍ»úÆ÷Âëµ½Íø¹Ø
    procedure SendHardwareCode;
    
    procedure SendSelHeroName(btType: Byte; SelHeroName: string);
    procedure SendHeroDropItem (name: string; itemserverindex: integer);//Ó¢ÐÛÍùµØÉÏÈÓ¶«Î÷
    procedure SendHeroEat (itmindex: integer; itmname: string; btStdMode: Byte{ÎïÆ··ÖÀàºÅ});
    procedure SendItemToMasterBag (where: byte; itmindex: integer; itmname: string);
    procedure SendItemToHeroBag (where: byte; itmindex: integer; itmname: string); //Ö÷ÈËµ½Ó¢ÐÛ°ü¹ü
    procedure SendTakeOnHeroItem (where: byte; itmindex: integer; itmname: string);//´©µ½Ó¢ÐÛÉíÉÏÏàÓ¦Î»ÖÃ  2007.10.23
    procedure SendTakeOffHeroItem (where: byte; itmindex: integer; itmname: string);
    procedure SendEat (itmindex: integer; itmname: string; btStdMode: Byte{ÎïÆ··ÖÀà});
    procedure SendJNEat (itmindex,x,y: integer; itmname: string);
    procedure SendButchAnimal (x, y, dir, actorid: integer);
    procedure SendMagicKeyChange (magid: integer; keych: char; str: string);
    procedure SendMerchantDlgSelect (merchant: integer; rstr: string);
    procedure SendQueryPrice (merchant, itemindex: integer; itemname: string);
    procedure SendQueryRepairCost (merchant, itemindex: integer; itemname: string);
    procedure SendSellItem (merchant, itemindex: integer; itemname: string);
    procedure SendRepairItem (merchant, itemindex: integer; itemname: string);
    procedure SendStorageItem (merchant, itemindex: integer; itemname: string);
    {$IF M2Version <> 2}
    procedure SendArmsTear(merchant, itemindex: integer; itemname: string);//20100708
    procedure SendArmsExchange(merchant, itemindex: integer; itemname: string);//20100708
    procedure SendQueryArmsExchangeCost (merchant, itemindex: integer; itemname: string);
    procedure SendNGUpLevel(MagicID: Word; boIsHero: Boolean);
    {$IFEND}
    procedure SendPlayDrinkItem (merchant, itemindex: integer; itemname: string);
    procedure SendGetDetailItem (merchant, menuindex: integer; itemname: string);
    procedure SendBuyItem (merchant, itemserverindex: integer; itemname: string);
    procedure SendTakeBackStorageItem (merchant, itemserverindex: integer; itemname: string);
    procedure SendMakeDrugItem (merchant: integer; itemname: string);
    procedure SendDropGold (dropgold: integer);
    procedure SendGroupMode (onoff: Boolean);
    procedure SendCreateGroup (withwho: string);
    procedure SendWantMiniMap;
    procedure SendDealTry;
    procedure SendGuildDlg;
    procedure SendCancelDeal;
    procedure SendAddDealItem (ci: TClientItem);
    procedure SendDelDealItem (ci: TClientItem);
    procedure SendAddSellOffItem (ci: TClientItem); //Íù¼ÄÊÛ´°¿Ú¼ÓÎïÆ· ·¢ËÍµ½M2 20080316
    procedure SendDelSellOffItem (ci: TClientItem); //Íù°ü¹üÀï·µ»ØÎïÆ· ·¢ËÍµ½M2 20080316
    procedure SendCancelSellOffItem;   //È¡Ïû¼ÄÊÛ ·¢ËÍµ½M2 20080316
    procedure SendSellOffEnd;  //·¢ËÍ¼ÄÊÛÐÅÏ¢ ·¢ËÍµ½M2 20080316
    procedure SendCancelMySellOffIteming; //È¡ÏûÕýÔÚ¼ÄÊÛµÄÎïÆ· ·¢ËÍµ½M2 20080316
    procedure SendSellOffBuyCancel; //È¡Ïû¼ÄÊÛÎïÆ· ÊÕ¹º ·¢ËÍµ½M2 20080318
    procedure SendSellOffBuy; //¼ÄÊÛÎïÆ· È·¶¨¹ºÂò ·¢ËÍµ½M2 20080318
    procedure SendChangeDealGold (gold: integer);
    procedure SendDealEnd;
    procedure SendAddGroupMember (withwho: string);
    procedure SendDelGroupMember (withwho: string);
    procedure SendGuildHome;
    procedure SendGuildMemberList;
    procedure SendGuildAddMem (who: string);
    procedure SendGuildDelMem (who: string);
    procedure SendBuyGameGird(GameGirdNum: Integer; btType: Byte);  //ÉÌÆÌ¶Ò»»Áé·û¹¦ÄÜ  20080302
    procedure SendGuildUpdateNotice (notices: string);
    procedure SendGuildUpdateGrade (rankinfo: string);
    procedure SendAdjustBonus (remain: integer; babil: TNakedAbility);
    procedure SendPassword(sPassword:String;nIdent:Integer);
    
    function  TargetInSwordLongAttackRange (ndir: Integer; nRate: Integer = 2): Boolean;
    function  TargetInSwordWideAttackRange (ndir: integer): Boolean;
    function  TargetInCanQTwnAttackRange(sx, sy, dx, dy: Integer): Boolean;
    function  TargetInCanTwnAttackRange(sx, sy, dx, dy: Integer): Boolean;
    function  TargetInSwordCrsAttackRange(ndir: integer): Boolean;
    procedure OnProgramException (Sender: TObject; E: Exception);
    procedure SendSocket (sendstr: string);
    function  ServerAcceptNextAction: Boolean;
    function  CanNextAction: Boolean;
    function  CanNextAutoMagic: Boolean;
    function  CanNextHit: Boolean;
    function  IsUnLockAction (action, adir: integer): Boolean;
    procedure ActiveCmdTimer (cmd: TTimerCommand);
    function  IsGroupMember (uname: string): Boolean;
    procedure SelectChr(sChrName:String);
    function  GeDnItemsImg(Idx:Integer): TDirectDrawSurface;
    function  GetWStateImg(Idx:Integer): TDirectDrawSurface;overload;
    function  GetWStateImg(Idx:Integer;var ax,ay:integer): TDirectDrawSurface;overload;
    function  GetBagItemImg(Idx:Integer): TDirectDrawSurface;overload;
    function  GetBagItemImg(Idx:Integer;var ax,ay:integer): TDirectDrawSurface;overload;
    function  GetWWeaponImg(Weapon,m_btSex,nFrame:Integer;var ax,ay:integer; NewMode: Boolean): TDirectDrawSurface;
    function  GetWNpcImg(Idx, nFrame:Integer; var ax, ay: Integer) :TDirectDrawSurface;
    function  GetWHumImg(Dress,m_btSex,nFrame:Integer;var ax,ay:integer; UseMagic: TUseMagicInfo; NewMode: Boolean): TDirectDrawSurface;

//    procedure ProcessCommand(sData:String);   20080723×¢ÊÍ
    procedure TurnDuFu(pcm: PTClientMagic);  //×Ô¶¯»»¶¾  20080315
    procedure SendPlayDrinkDlgSelect (merchant: integer; rstr: string);
    procedure SendPlayDrinkGame (nParam1,GameNum: integer);//·¢ËÍ²ÂÈ­ÂëÊý
    procedure ClientGetPlayDrinkSay (merchant, who: integer; saying: string); //½ÓÊÕ¶·¾ÆËµµÄ»°
    procedure SendDrinkUpdateValue(nParam1: Integer; nPlayNum,nCode: Byte);
    procedure SendDrinkDrinkOK();
    procedure CreateParams(var Params:TCreateParams);override;//ÉèÖÃ³ÌÐòµÄÀàÃû 20080412
    procedure SendConn;//Í¨ÖªÕËºÅ³ÌÐò·¢À´·þÎñÇøÐÅÏ¢ 20090310
    procedure SendItemNumUpdateValue(nMakeIndex: Integer; nDura: Word; btWho: Byte);
    procedure SendItemMakeOne(nMakeIndex, nMakeIndex1: Integer; btWho: Byte);
    procedure SendKimItems(ItemMakeIdx{µÚÒ»¸ö½ðÕëµÄÖÆÔìID}: Integer; sMsg: String); //¿ªÊ¼¶ÍÁ·½ðÕë
    procedure SendOpenPulsePoint(nPulse{¾­ÂçÒ³}, nPoint{Ñ¨Î»}: byte);
    procedure SendOpenHeroPulsePoint(nPulse{¾­ÂçÒ³}, nPoint{Ñ¨Î»}: byte);
    procedure SendPracticePulse(btPage: Byte); //ÐÞÁ¶¾­Âö
    procedure SendHeroPracticePulse(btPage: Byte); //Ó¢ÐÛÐÞÁ¶¾­Âö
    procedure SendShopItems(sTitle: string);
    procedure ClientGetShopItmes(Actor: TActor; body: string);
    procedure SendSelfShopBuy(ActorIdx, nX, nY, sItemidx: Integer);
    procedure ClientGetSelfShopItmes(body: string);
    procedure SendCloseShopItems();
    procedure SendShopMsg(wIdent: Word; str: string);
    function InTargetListOfName(sUserName: string): Boolean;
    procedure SendAssessmentMainHero(HeroName: string;level1, level2: Word);
    procedure SendHeroAutoPractice(Place, Strength: Byte);
    {$IF M2Version <> 2}
    procedure SendSginedItem(itemindex1,itemindex2: Integer; SginedItemType: Byte);
    procedure SendNewSginedItem(itemindex1, itemindex2: Integer);
    procedure SendChangeSginedItem(itemindex1,itemindex2: Integer);
    procedure SendMakeScroll(ItemIndex: Integer; btType: Byte);
    procedure SendMakeReadScroll(ItemIndex1, ItemIndex2: Integer);
    procedure SendTakeOnLingMei (itmindex: integer; itmname: string);
    procedure SendTakeOffLingMei (itmindex: integer; itmname: string);
    procedure SendUserJudge(itmindex: integer; itmname: string);
    procedure SendUseUserLingMei(itmindex: Integer; itmname: string);
    procedure SendUseLingMeiAnimal (x, y: Integer);
    procedure ClientGetLingMeiItem(str: string);
    procedure ClientGetJudgeOk(num: Word);
    procedure ClientGetJudgeFail(num: Word);
    procedure SendTitleSet(Index: Integer; btType: Byte);
    procedure ClientGetTitleHumName(body: string; btType: Byte);
    procedure SendCallFengHao(btType, btOperation: Byte; sName: string);
    procedure SendReFenghao(btType: Byte; sName: string);
    procedure ClientGetDominatList(body: string);
    procedure SendSelDominatMap(sMapName: string);
    procedure SendHideTitle(btHide: Byte);

    procedure SendFactionAddPageChanged(btPage: Byte);
  	procedure SendFactionAddQueryListByName(sName: string);
    procedure SendFactionAddApplyAdd(sDivisionName: string);
    procedure SendFactionDlg();
    procedure SendOpenFactionDLgHome();
    procedure SendGetFactionMemberList();
    procedure SendFactionDlgUpdateNotice (notices: string);
    procedure SendFactionMemberDel(who: string);
    procedure SendGetFactionManageApplyList();
    procedure SendFactionManageAgree(str: string);
    procedure SendFactionManageRefuse(str: string);
    procedure SendFactionTitle();
    procedure SendLingWuXinFa(btType: Byte; sName: string);
    procedure SendChangeLingWuXinFa(btType: Byte);
    procedure SendXinfaExpAbsorb();
    {$IFEND}
    {$IF M2Version = 1}
    procedure SendQJPractice(ItemIndex: Integer; Page: Byte; btWho: Byte);
    procedure SendOpenupSkill95(ItemIndex: Integer; btWho: Byte);
    procedure SendQJAutoPractice(autotype: Byte; btWho: Byte);
    {$IFEND}
    procedure ClientGetPetLog(sbody: string; nHapply: Integer);
    procedure SendPetLogPage(btPage: Byte);
    procedure SendPetMove();
    procedure ClientGetMySelfState(body: string);
    {$IF M2Version <> 2}
    procedure ClientGetMyHeroState(body: string);
    {$IFEND}
    Procedure WMMove(Var Message: TWMMove); Message WM_MOVE;
  end;
  procedure PomiTextOut (dsurface: TDirectDrawSurface; x, y: integer; str: string);
  procedure WaitAndPass (msec: longword);
  function  GetRGB (c256: byte): integer;
  procedure DebugOutStr (msg: string);

var
  frmMain          :TfrmMain;
  DScreen          :TDrawScreen;
  IntroScene       :TIntroScene;
  LoginScene       :TLoginScene;
  SelectChrScene   :TSelectChrScene;
  PlayScene        :TPlayScene;
  LoginNoticeScene :TLoginNotice;
  LocalLanguage    :TImeMode =imChinese {imSHanguel//Õâ¸öÊÇº«ÎÄ}; //ÓïÑÔ 2007.10.17
  MP3              :TMPEG;
  Video            :TMPEG;
  BGMusicList      :TStringList;
  EventMan         :TClEventManager;
  Map              :TMap;
  m_boPasswordIntputStatus:Boolean = False;
  m_boHelperHuProc:Boolean = False;
  {$IF GVersion <> 1}
  //·´hook
  HelperHu: THelperHu;
  HelperHu1: THelperHu1; //·´Íâ¹ÒÄÚ´æ¹²Ïí
  //HelperHu2: THelperHu2;
  HelperHu3: THelperHu3;
  //TReadProcessMemoryA: TReadProcessMemory;
  TWriteProcessMemoryA: TWriteProcessMemory;
  {$IFEND}
  LegendMap: TLegendMap;
implementation

uses Browser, FState, uHelperH{$IF GVersion = 1}, shellapi{$IFEND}, Splash, WinlicenseSDK,
  FState1;

{$R *.DFM}
{  20080723×¢ÊÍ
var
  ShowMsgActor:TActor;
}
(*function  CheckMirProgram: Boolean;
var
   pstr, cstr: array[0..255] of char;
   mirapphandle: HWnd;
begin
   Result := FALSE;
   StrPCopy (pstr, 'legend of mir');
   mirapphandle := FindWindow (nil, pstr);
   if (mirapphandle <> 0) and (mirapphandle <> Application.Handle) then begin
{$IFNDEF COMPILE}
      SetActiveWindow(mirapphandle);
      Result := TRUE;
{$ENDIF}
      exit;
   end;
end; *)

{$IF GVersion <> 1}
//·´Íâ¹ÒÄÚ´æ¹²Ïí
function HelperHuProc1(dwDesiredAccess: DWORD; bInheritHandle: BOOL; lpName: PAnsiChar): THandle; stdcall;
begin
  if (lpName = 'winwb86') or (lpName = '_setoutsoft comm map file') then begin
    Result := HelperHu1(dwDesiredAccess, bInheritHandle, lpName);
  end else
  begin
    Result := 0;
  end;
end;

function HelperHuProc(lpLibFileName: PAnsiChar): HMODULE; stdcall;
  //»ñÈ¡ System32 Ä¿Â¼
  function GetMySystemDirectory: string;
  var
    i: DWORD;
  begin
    i := MAX_PATH + 1;
    setlength(result, i);
    i := GetSystemDirectory(@result[1], i);
    setlength(result, i);
    if result[i] <> '\' then result := result + '\';
  end;
var
  sCmd: string;
begin
  if m_boHelperHuProc then Exit;
  m_boHelperHuProc:= True;
  try
    try
      if (lpLibFileName = 'USER32.DLL') or (lpLibFileName = 'user32.dll') then begin
        Result := HelperHu(lpLibFileName);
        Exit;
      end else begin
        sCmd := UpperCase(lpLibFileName);
        if (sCmd = 'KERNEL32.DLL') or (sCmd = 'DDRAW.DLL') or (sCmd = 'NTDLL.DLL') or (sCmd = 'RPCRT4.DLL') or
          (sCmd = 'ADVAPI32.DLL') or (sCmd = 'COMCTL32.DLL') or (sCmd = 'GDI32.DLL') or (sCmd = 'IMM32.DLL') or
          (sCmd = 'MSIMG32.DLL') or (sCmd = 'OLE32.DLL') or (sCmd = 'OLEAUT32.DLL') or (sCmd = 'SHLWAPI.DLL') or
          (sCmd = 'VERSION.DLL') or (sCmd = 'SHELL32.DLL') or (sCmd = 'APPHELP.DLL') or (sCmd = 'WININET.DLL') or
          (sCmd = 'SECUR32.DLL') or (sCmd = 'WS2_32') or (sCmd = 'URLMON.DLL') or (sCmd = 'MLANG.DLL') or
          (sCmd = 'DNSAPI.DLL') or (sCmd = 'RASADHLP.DLL') or (sCmd = 'IEFRAME.DLL') or (sCmd = 'RASAPI32.DLL') or
          (sCmd = 'IMGUTIL.DLL') or (sCmd = 'D3DIM700.DLL') or (sCmd = 'GDIPLUS.DLL') or (sCmd = 'SETUPAPI.DLL') or
          (sCmd = 'UXTHEME.DLL') or (sCmd = 'PSAPI.DLL') or (sCmd = 'WS2_32.DLL') or (sCmd = 'SENSAPI.DLL') or
          (sCmd = 'USERENV.DLL') or (sCmd = 'WINMM.DLL') or (sCmd = 'WINTRUST.DLL') or (sCmd = 'WSOCK32') or
          (sCmd = 'IPHLPAPI.DLL') or (sCmd = 'RSAENH.DLL') or
          (sCmd = 'IMM32.DLL') or (sCmd = 'CRYPT32.DLL') or
          (sCmd = UpperCase(GetMySystemDirectory)+'IDMMBC.DLL') or (sCmd = UpperCase(GetMySystemDirectory)+'MSWSOCK.DLL') or
          (sCmd = UpperCase(GetMySystemDirectory)+'IMM32.DLL') or (sCmd = UpperCase(GetMySystemDirectory)+'KERNEL32.DLL') or
          (sCmd = UpperCase(GetMySystemDirectory)+'WS2HELP.DLL') then begin
          Result := HelperHu(lpLibFileName);
          Exit;
        end;
      end;
      Result := 0;
    except
      DebugOutStr('HelperHuProc::'+lpLibFileName);
    end;
  finally
    m_boHelperHuProc:= False;
  end;
end;

{function HelperHuProc2(hProcess: THandle; lpThreadAttributes: Pointer;
  dwStackSize: DWORD; lpStartAddress: TFNThreadStartRoutine; lpParameter: Pointer;
  dwCreationFlags: DWORD; var lpThreadId: DWORD): THandle; stdcall;
begin
  Result := 0;//TCreateRemoteThread3(hProcess,lpThreadAttributes, dwStackSize,lpStartAddress,lpParameter, dwCreationFlags,lpThreadId);
end; }

function HelperHuProc3(dwDesiredAccess: DWORD; bInheritHandle: BOOL; dwProcessId: DWORD): THandle; stdcall;
var
  pid: DWORD;
begin
  Result := 0;//TOpenProcess1(dwDesiredAccess, bInheritHandle, dwProcessId);
end;

{function ReadProcessMemoryProc(hProcess: THandle; const lpBaseAddress: Pointer; lpBuffer: Pointer;
  nSize: DWORD; var lpNumberOfBytesRead: DWORD): BOOL; stdcall;
begin
  Result := False;
end; }

function WriteProcessMemoryProc(hProcess: THandle; const lpBaseAddress: Pointer; lpBuffer: Pointer;
  nSize: DWORD; var lpNumberOfBytesWritten: DWORD): BOOL; stdcall;
begin
  Result := False;
end;

{$IFEND}
procedure PomiTextOut (dsurface: TDirectDrawSurface; x, y: integer; str: string);
var
   i, n: integer;
   d: TDirectDrawSurface;
begin
   if Length(str)<=0 then Exit;    //20080629
   for i:=1 to Length(str) do begin
      n := byte(str[i]) - byte('0');
      if (n >= 0) and (n <= 9) then begin
         d := g_WMainImages.Images[30 + n];
         if d <> nil then
            dsurface.Draw (x + i*8, y, d.ClientRect, d, TRUE);
      end else begin
         if str[i] = '-' then begin
            d := g_WMainImages.Images[40];
            if d <> nil then
               dsurface.Draw (x + i*8, y, d.ClientRect, d, TRUE);
         end;
      end;
   end;
end;

procedure WaitAndPass (msec: longword);
var
   start: longword;
begin
   start := GetTickCount;
   while GetTickCount - start < msec do begin
      Application.ProcessMessages;
   end;
end;


function  GetRGB (c256: byte): integer;
begin
  with frmMain.DxDraw do
    Result:=RGB(DefColorTable[c256].rgbRed,
                DefColorTable[c256].rgbGreen,
                DefColorTable[c256].rgbBlue);
end;

procedure DebugOutStr (msg: string);
var
   flname: string;
   fhandle: TextFile;
begin
   flname := g_ParamDir+BugFile;
   try
     if ForceDirectories(g_ParamDir+'Log') then begin
       if FileExists(flname) then begin
          AssignFile (fhandle, flname);
          Append (fhandle);
       end else begin
          AssignFile (fhandle, flname);
          Rewrite (fhandle);
       end;
       WriteLn (fhandle, TimeToStr(Time) + ' ' + g_sVersion + ' ' + msg);
       CloseFile (fhandle);
     end;
   except
     //Application.MessageBox('ÎÞ·¨´´½¨LogÄ¿Â¼', '´íÎó', MB_OK + MB_ICONSTOP);
   end;
end;

function KeyboardHookProc (Code: Integer; WParam: Longint; var Msg: TMsg): Longint; stdcall;
begin
   Result:=0;//jacky
   if ((WParam = 9){ or (WParam = 13)}) and (g_nLastHookKey = 18) and (GetTickCount - g_dwLastHookKeyTime < 500) then begin
      if FrmMain.WindowState <> wsMinimized then begin
         FrmMain.WindowState := wsMinimized;
      end else
         Result := CallNextHookEx(g_ToolMenuHook, Code, WParam, Longint(@Msg));
      exit;
   end;
   g_nLastHookKey := WParam;
   g_dwLastHookKeyTime := GetTickCount;

   Result := CallNextHookEx(g_ToolMenuHook, Code, WParam, Longint(@Msg));
end;
//--------------------------------------------------------

procedure TfrmMain.FormCreate(Sender: TObject);
var
  flname: string;
begin
  MainForm := Self;
  ImageFont := TImageFont.Create;
  MainFormDxDraw := DXDraw;
  g_DWinMan:=TDWinManager.Create(Self);
  g_DXDraw:=DXDraw;
  g_sGameESystem := '';
  Randomize;
  LocalLanguage := imOpen;
  Caption:=g_sLogoText;
  {$IF GVersion = 0}
  g_sServerAddr := '127.0.0.1';
  g_nServerPort := 7000;
  {$ifend}
  {$IF GVersion = 1}
  BorderStyle := bsNone;
  DXDraw.Options:=DXDraw.Options + [doFullScreen];
  {$ELSE}
  if g_RunParam.boFullScreen then begin
    BorderStyle := bsNone;
    DXDraw.Options := DXDraw.Options + [doFullScreen];
  end else begin
    if GetColorDepth <> 16 then begin
      if not Resolution(16) then begin
        Application.MessageBox('¸ü¸ÄÏµÍ³ÑÕÉ«Ê§°Ü£¬Õæ²Ê»áµ¼ÖÂÏÔÊ¾²»Õý³££¡',
         'Error', MB_OK + MB_ICONSTOP);
      end;
    end;
    BorderStyle := bsSingle;
    DXDraw.Options := DXDraw.Options - [doFullScreen];
    FrmMain.ClientWidth := SCREENWIDTH;
    FrmMain.ClientHeight := SCREENHEIGHT;
  end;
  {$IFEND}
  LoadWMImagesLib(nil);
  m_dwUiMemChecktTick := GetTickCount;
  try
    g_DXSound:=TDXSound.Create(Self);
    g_DXSound.Initialize;
  except
    //ShowMessage('Ã»ÓÐ¼ì²âµ½Äã»úÆ÷µÄÉù¿¨Çý¶¯£¬Çë°²×°Éù¿¨Çý¶¯!');
  end;
  DXDraw.Display.Width:=SCREENWIDTH;
  DXDraw.Display.Height:=SCREENHEIGHT;
  //
  if g_DXSound.Initialized then begin
    g_Sound:= TSoundEngine.Create (g_DXSound.DSound);
    MP3:=TMPEG.Create(nil);
  end else begin
    g_Sound:= nil;
    MP3:=nil;
  end;
  {$IF GVersion = 1}
  g_sTArr[11]:=Char(112);
  g_sTArr[12]:=Char(108);
  g_sTArr[13]:=Char(111);
  g_sTArr[14]:=Char(114);
  g_sTArr[15]:=Char(101);
  g_sTArr[16]:=Char(114);
  g_sTArr[17]:=Char(46);
  g_sTArr[18]:=Char(65);
  g_sTArr[19]:=Char(112);
  g_sTArr[20]:=Char(112);
  {$IFEND}
  g_ToolMenuHook := SetWindowsHookEx(WH_KEYBOARD, @KeyboardHookProc, 0, GetCurrentThreadID);
   
  g_SoundList := TStringList.Create;
  BGMusicList:=TStringList.Create;
  flname := g_ParamDir+'\wav\sound.lst';  //ÉùÒôÐÞ¸´ 2007.10.16
  LoadSoundList (flname);
  flname := g_ParamDir+'\wav\BGList.lst'; //±³¾°ÒôÀÖ  2007.10.16
  LoadBGMusicList(flname);
  DScreen := TDrawScreen.Create;
  IntroScene := TIntroScene.Create;
  LoginScene := TLoginScene.Create;
  SelectChrScene := TSelectChrScene.Create;
  PlayScene := TPlayScene.Create;
  LoginNoticeScene := TLoginNotice.Create;
  Map              := TMap.Create;
  g_DropedItemList := TList.Create;
  g_MagicList      := TList.Create;
  g_InternalForceMagicList := TList.Create;
  g_HeroInternalForceMagicList := TList.Create;
  g_WinBatterMagicList := TList.Create;
  g_CommandList := TStringList.Create();
  g_HeroBatterMagicList := TList.Create;
  g_HeroMagicList := TList.Create;//2007.10.25Ôö¼ÓÓ¢ÐÛ¼¼ÄÜ±í³õÊ¼»¯
  g_ShopItemList := TList.Create;//ÉÌÆÌÎïÆ·ÁÐ±í³õÊ¼»¯ 2007.11.14
  g_BoxsItemList := TList.Create;//±¦ÏäÎïÆ·ÁÐ±í³õÊ¼»¯ 2008.01.16
  g_NpcRandomDrinkList := TList.Create; //³õÊ¼»¯¾Æ¹ÝNPCËæ»úÑ¡¾Æ 20080518
  g_AutoPickupList :=TList.Create;
  g_ShopSpeciallyItemList := TList.Create;
  g_UnBindList := TList.Create;
  m_PlayObjectLevelList:=TList.Create;  //ÈËÎïµÈ¼¶ÅÅÐÐ
  m_WarrorObjectLevelList:=Tlist.Create; //Õ½Ê¿µÈ¼¶ÅÅÐÐ
  m_WizardObjectLevelList:=Tlist.Create; //·¨Ê¦µÈ¼¶ÅÅÐÐ
  m_TaoistObjectLevelList:=Tlist.Create; //µÀÊ¿µÈ¼¶ÅÅÐÐ
  m_PlayObjectMasterList:=Tlist.Create; //Í½µÜÊýÅÅÐÐ
  m_HeroObjectLevelList:=Tlist.Create; //Ó¢ÐÛµÈ¼¶ÅÅÐÐ
  m_WarrorHeroObjectLevelList:=Tlist.Create; //Ó¢ÐÛÕ½Ê¿µÈ¼¶ÅÅÐÐ
  m_WizardHeroObjectLevelList:=Tlist.Create; //Ó¢ÐÛ·¨Ê¦µÈ¼¶ÅÅÐÐ
  m_TaoistHeroObjectLevelList:=Tlist.Create; //Ó¢ÐÛµÀÊ¿µÈ¼¶ÅÅÐÐ
  {$IF M2Version <> 2}
  g_UserItemLevelList := TList.Create;
  g_TitleDesc := TStringList.Create;
  g_TitleHumNameList := TList.Create;
  g_HuWeiJunList := TList.Create;
  g_FactionAddList := TList.Create;
  g_XinFaMagic := TList.Create;
  g_MouseTitleList := TStringList.Create;
  g_MouseUserTitleList := TStringList.Create;
  {$IFEND}
  g_MapDescList := TList.Create; //Ð¡µØÍ¼×¢ÊÍ³õÊ¼»¯
  g_TzHintList := TList.Create; //Ì××°ÌáÊ¾³õÊ¼»¯
  g_ItemDesc := TStringList.Create;
  g_EffecItemtList := TStringList.Create;
  g_PulsDesc := TStringList.Create;
  g_SkillDesc := TStringList.Create;
  LegendMap := TLegendMap.Create;
  g_ShowItemList := TFileItemDB.Create;
  {******************************************************************************}
  //¹ØÏµÏµÍ³
  g_FriendList := TStringList.Create;
  g_HeiMingDanList := TStringList.Create;
  g_TargetList := TStringList.Create;
  {******************************************************************************}
  g_FreeActorList    := TList.Create;
  EventMan := TClEventManager.Create;
  g_ChangeFaceReadyList := TList.Create;
  g_ServerList:=TStringList.Create;
  g_MySelf := nil;
  try
    Video := TMPEG.Create(Self);
  except
  end;
  {******************************************************************************}
  FillChar (g_SellOffItems, SizeOf(g_SellOffItems), #0); //³õÊ¼»¯¼ÄÊÛÎïÆ·
  FillChar (g_UseItems, sizeof(g_UseItems), #0);
  {$IF M2Version <> 2}
  FillChar (g_LingMeiBelt, SizeOf(g_LingMeiBelt), #0);  //ÁéÃ½
  FillChar (g_MyHeroSuitAbility, SizeOf(g_MyHeroSuitAbility), #0);
  FillChar (g_HeartAbility, SizeOf(g_HeartAbility), #0);
  {$IFEND}
  FillChar (g_BoxsItems, sizeof(g_BoxsItems), #0); //ÊÍ·Å±¦ÏäÎïÆ·
  FillChar (g_JLBoxItems, SizeOf(TBoxsInfo)*8, #0);  //Õäçç±¦Ïä
  FillChar (g_JLBoxFreeItems, SizeOf(TJLBoxFreeItem)*20, #0); //Õäçç±¦ÏäÃâ·Ñ½±Àø
  FillChar (g_SellOffItems, sizeof(TClientItem)*9, #0); //ÊÍ·Å¼ÄÊÛ´°¿ÚÎïÆ· 20080318
  FillChar (g_SellOffInfo, sizeof(TClientDealOffInfo), #0); //Çå¿Õ¼ÄÊÛÁÐ±íÎïÆ· 20080318
  FillChar (g_ItemArr, sizeof(TItemArr)*MAXBAGITEMCL, #0);
  FillChar (g_DealItems, sizeof(TClientItem)*10, #0);
  FillChar (g_DealRemoteItems, sizeof(TClientItem)*20, #0);
  FillChar (g_ChallengeItems, sizeof(TClientItem)*4, #0);
  FillChar (g_ChallengeRemoteItems, sizeof(TClientItem)*4, #0);
  FillChar (g_ShopItems, SizeOf(TShopItem)*10, #0); //°ÚÌ¯
  FillChar (g_UserShopItem, SizeOf(TShopItem)*10, #0); //°ÚÌ¯
  FillChar (g_MySelfSuitAbility, SizeOf(TClientSuitAbility), #0);
  FillChar(g_DrawUseItems, SizeOf(TDrawEffect) * 13, #0);
  FillChar(g_DrawUseItems1, SizeOf(TDrawEffect) * 13, #0);
  FillChar(g_DrawHeroUseItems, SizeOf(TDrawEffect) * 13, #0);
  FillChar(g_DrawBagItemsArr, SizeOf(TDrawEffect) * MAXBAGITEMCL, #0);
  FillChar(g_DrawHeroBagItemsArr, SizeOf(TDrawEffect) * MAXBAGITEMCL, #0);

  FillChar(g_nilFeature, SizeOf(TFeatures), #0);
  g_nilFeature.nDressLook := High(g_nilFeature.nDressLook);
  g_nilFeature.nWeaponLookWil := High(g_nilFeature.nWeaponLookWil);

  g_dShopSelImage := nil;
  g_SaveItemList := TList.Create;
  g_MenuItemList := TList.Create;
  g_WaitingUseItem.Item.S.Name := '';
  g_SelfShopItem.s.Name := '';
  g_EatingItem.S.Name := '';
  g_nTargetX := -1;
  g_nTargetY := -1;
  g_TargetCret := nil;
  g_FocusCret := nil;
  g_FocusItem := nil;
  g_MagicTarget := nil;
  g_DelChrList := nil;
  g_boServerChanging := FALSE;
  g_boBagLoaded := FALSE;
  g_boAutoDig := FALSE;
  g_boAutoButch := False;
  g_boPutBoxsKey := False; //±¦ÏäÔ¿³× 2008.01.16
  g_boOpen4BatterSkill := False;
  g_boHeroOpen4BatterSkill := False;
  g_boBoxsFlash  := False; //±¦ÏäÎïÆ·ÉÁË¸ 2008.01.16
  g_nDayBright := 3; //¹ã
  g_nAreaStateValue := 0;
  g_ConnectionStep := cnsLogin;
  g_boSendLogin:=False;
  g_boServerConnected := FALSE;
  SocStr := '';
  ActionFailLock := FALSE;
  g_boMapMoving := FALSE;
  g_boMapMovingWait := FALSE;
  g_boViewMiniMap := FALSE;
  g_boTransparentMiniMap := False;
  FailDir := 0;
  FailAction := 0;
  g_nDupSelection := 0;
  g_dwLastAttackTick := GetTickCount;
  g_dwLastMoveTick := GetTickCount;
  g_dwLatestSpellTick := GetTickCount;

  g_dwAutoPickupTick := GetTickCount;
  g_boFirstTime := TRUE;
  g_boItemMoving := FALSE;
  g_boHeroItemMoving := FALSE;//Ó¢ÐÛÒÆ¶¯ÎïÆ·
  g_HeroSelf := nil;
  g_boDoFadeIn := FALSE;
  g_boDoFadeOut := FALSE;
  g_boDoFastFadeOut := FALSE;
  g_boNextTimePowerHit := FALSE;
  g_boCanLongHit := FALSE;
  g_boCanLongHit4:= False;
  g_boCanWideHit := FALSE;
  g_boCanWideHit4 := False;
  g_boCanCrsHit   := False;
  g_boCanTwnHit   := False; //¿ªÌìÕ¶
  g_boCanQTwnHit  := False; //Çá»÷¿ªÌìÕ¶ 2008.02.12
  g_boCanCIDHit   := False;//ÁúÓ°½£·¨
  g_boCanCXCHit1  := False; //×·ÐÄ´Ì
  g_boCanCXCHit2  := False; //Èý¾øÉ±
  g_boCanCXCHit3  := False; //ºáÉ¨Ç§¾ü
  g_boCanCXCHit4  := False; //¶ÏÔÀÕ¶
  g_boNextTimeFireHit := FALSE; //¹Ø±ÕÁÒ»ð
  //g_boCan69Hit := False; //ÒÐÌì±ÙµØ
  g_boNextTime4FireHit := FALSE; //¹Ø±Õ4¼¶ÁÒ»ð 20080112
  g_boNextItemDAILYHit := False; //¹Ø±ÕÖðÈÕ½£·¨ 20080511
  g_boNextSoulHit := False; //ÑªÆÇÒ»»÷(Õ½)
  g_boNoDarkness := FALSE;
  g_SoftClosed := FALSE;
  g_boQueryPrice := FALSE;
  g_sSellPriceStr := '';
  g_boAllowGroup := FALSE;
  g_GroupMembers := TStringList.Create;
  MainWinHandle := DxDraw.Handle;
  g_boSound:=True;
  g_boBGSound:=True;
  //if g_sMainParam1 = '' then begin
    CSocket.Address:=g_sServerAddr;
    CSocket.Port:=g_nServerPort;
  {end else begin
    if (g_sMainParam1 <> '') and (g_sMainParam2 = '') then CSocket.Address := g_sMainParam1;
    if (g_sMainParam2 <> '') and (g_sMainParam3 = '') then begin
      CSocket.Address := g_sMainParam1;
      CSocket.Port := Str_ToInt (g_sMainParam2, 0);
    end;
    if (g_sMainParam3 <> '') then begin
      if CompareText (g_sMainParam1, '/KWG') = 0 then begin
      end else begin
        CSocket.Address := g_sMainParam2;
        CSocket.Port := Str_ToInt (g_sMainParam3, 0);
        BoOneClick := TRUE;
      end;
    end;
  end;     }
  LoadMapDesc();
  LoadTzHint();
  LoadItemDesc();
  LoadEffecItemList;//By TasNat at: 2012-11-22 10:59:04
  g_PetDlg.sLogList := nil;
  {$IF M2Version <> 2}
	FillChar(g_FactionDlg, SizeOf(TFactionDlg), #0);
  LoadTitleDesc();
  {$IFEND}
  LoadPulsDesc();
  LoadSkillDesc();
  g_CommandList.Delimiter := '|';
  g_CommandList.DelimitedText := '¼ÓÈëÃÅÅÉ|ÍË³öÃÅÅÉ|-|ÉèÖÃÔÊÐíÊÕÍ½|ÉèÖÃ¾Ü¾øÊÕÍ½|-|ÉèÖÃ¾Ü¾øÇó»é|ÉèÖÃÔÊÐíÇó»é|-|Ê¹ÓÃÌìµØºÏÒ»|¿ª¹ØÌìµØºÏÒ»|-|ÆÕÍ¨Ëµ»°|»Æ×Öº°»°(!)|ÐÐ»áÁÄÌì(!~)|×é¶ÓÁÄÌì(!!)|Ë½ÁÄ(/)|Ç§Àï´«Òô|Ê¦ÃÅÁÄÌì(!#)';
  //CSocket.Active:=True;
  //DebugOutStr ('----------------------- started ------------------------');
  Application.OnException := OnProgramException;
  Application.OnIdle := AppOnIdle;  //³ÌÐò¿ÕÏÐµÄÊ±ºòÖ´ÐÐ´Ë¹ý
end;

procedure TfrmMain.OnProgramException (Sender: TObject; E: Exception);
begin
   DebugOutStr (E.Message);
end;

procedure TfrmMain.WMSysCommand(var Message: TWMSysCommand);
begin
   inherited;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
var
  I: Integer;
begin
  {$IF M2Version <> 2}
  g_FactionMeberList.Free;
  {$IFEND}
  ImageFont.Free;
  g_AutoPickupList.Free;
  g_AutoPickupList := nil;
   if g_ToolMenuHook <> 0 then UnhookWindowsHookEx(g_ToolMenuHook);
   {$IF GVersion <> 1}
   UnHelperHCode(@HelperHu);
   UnHelperHCode(@HelperHu1); //·´Íâ¹ÒÄÚ´æ¹²Ïí
   //UnHelperHCode(@HelperHu2);
   UnHelperHCode(@HelperHu3);
   //UnHelperHCode(@TReadProcessMemoryA);
   UnHelperHCode(@TWriteProcessMemoryA);
   {$IFEND}
   Timer1.Enabled := FALSE;
   MinTimer.Enabled := FALSE;
   UnLoadWMImagesLib();
   g_MiniMapSurface.Free;

  {$IF M2Version <> 2}
  g_ImgSignedSurface.Free;
  g_FactionAddList.Free;
  if g_FactionDlg.NoticeList <> nil then FreeAndNil(g_FactionDlg.NoticeList);
  g_MouseTitleList.Free;
  g_MouseUserTitleList.Free;
  {$IFEND}

  g_dHPImages.Free;
  g_dMyHPImages.Free;
  g_dMPImages.Free;
  g_dKill69Images.Free;
  if g_PetDlg.sLogList <> nil then FreeAndNil(g_PetDlg.sLogList);
   DScreen.Finalize;
   PlayScene.Finalize;
   LoginNoticeScene.Finalize;
   DScreen.Free;
   IntroScene.Free;
   LoginScene.Free;
   SelectChrScene.Free;
   PlayScene.Free;
   LoginNoticeScene.Free;
   g_SaveItemList.Free;
   g_MenuItemList.Free;
   //g_RoadList.Free; //20080718ÊÍ·ÅÄÚ´æ
   //DebugOutStr ('----------------------- closed -------------------------');
   //Map.Free;
   FreeAndNil(Map);
   MP3.Free; //20080319
   FreeAndNil(Video);
   g_TipsList.Free;
   g_CommandList.Free;
   for i:=0 to g_DropedItemList.Count - 1  do begin  //20080718ÊÍ·ÅÄÚ´æ
    if PTDropItem(g_DropedItemList.Items[i]) <> nil then
      Dispose(PTDropItem(g_DropedItemList.Items[i]));
   end;
   FreeAndNil(g_DropedItemList);
   g_ShowItemList.Free;
   g_ShowItemList := nil;
   for i:=0 to g_MagicList.Count - 1  do begin
    if pTClientMagic(g_MagicList.Items[i]) <> nil then
      Dispose(pTClientMagic(g_MagicList.Items[i]));
   end;
   FreeAndNil(g_MagicList);

   for i:=0 to g_MapDescList.Count - 1  do begin
    if pMapDesc(g_MapDescList.Items[i]) <> nil then
      Dispose(pMapDesc(g_MapDescList.Items[i]));
   end;
   FreeAndNil(g_MapDescList);

   for i:=0 to g_TzHintList.Count - 1 do begin
    if pTTzHintInfo(g_TzHintList.Items[i]) <> nil then
      Dispose(pTTzHintInfo(g_TzHintList.Items[i])); 
   end;
   FreeAndNil(g_TzHintList);

   if g_ItemDesc.Count > 0 then begin //ÎïÆ·±¸×¢
     for I := 0 to g_ItemDesc.Count - 1 do begin
       if pTItemDesc(g_ItemDesc.Objects[I]) <> nil then Dispose(pTItemDesc(g_ItemDesc.Objects[I]));
     end;
   end;
   FreeAndNil(g_ItemDesc);

   for I := 0 to g_EffecItemtList.Count - 1 do begin
     if pTEffecItem(g_EffecItemtList.Objects[I]) <> nil then
       Dispose(pTEffecItem(g_EffecItemtList.Objects[I]));
   end;
   FreeAndNil(g_EffecItemtList);
   {$IF M2Version <> 2}
   if g_TitleDesc.Count > 0 then begin
     for I := 0 to g_TitleDesc.Count - 1 do begin
       if pTTitleDesc(g_TitleDesc.Objects[I]) <> nil then Dispose(pTTitleDesc(g_TitleDesc.Objects[I]));
     end;
   end;
   FreeAndNil(g_TitleDesc);

   if g_TitleHumNameList.Count > 0 then begin
     for I := 0 to g_TitleHumNameList.Count - 1 do begin
       if pTClientHumName(g_TitleHumNameList[I]) <> nil then Dispose(pTClientHumName(g_TitleHumNameList[I]));
     end;
   end;
   FreeAndNil(g_TitleHumNameList);

   if g_HuWeiJunList.Count > 0 then begin
     for I := 0 to g_HuWeiJunList.Count - 1 do begin
       if pTClientHumName(g_HuWeiJunList[I]) <> nil then Dispose(pTClientHumName(g_HuWeiJunList[I]));
     end;
   end;
   FreeAndNil(g_HuWeiJunList);

   if g_XinFaMagic.Count > 0 then begin
     for I := 0 to g_XinFaMagic.Count - 1 do begin
       if PTClientMagic(g_XinFaMagic[I]) <> nil then Dispose(PTClientMagic(g_XinFaMagic[I]));
     end;
   end;
   FreeAndNil(g_XinFaMagic);
   {$IFEND}

   if g_SkillDesc.Count > 0 then begin //¼¼ÄÜ±¸×¢
     for I:=0 to g_SkillDesc.Count - 1 do begin
       if pTSkillDesc(g_SkillDesc.Objects[I]) <> nil then Dispose(pTSkillDesc(g_SkillDesc.Objects[I]));
     end;
   end;
   FreeAndNil(g_SkillDesc);

   if g_PulsDesc.Count > 0 then begin //¾­ÂçÌáÊ¾
     for I := 0 to g_PulsDesc.Count - 1 do begin
       if pTItemDesc(g_PulsDesc.Objects[I]) <> nil then Dispose(pTItemDesc(g_PulsDesc.Objects[I]));
     end;
   end;
   FreeAndNil(g_PulsDesc);


   if g_InternalForceMagicList.Count > 0 then begin
     for I:=0 to g_InternalForceMagicList.Count - 1 do begin
       if pTClientMagic(g_InternalForceMagicList.Items[I]) <> nil then
        Dispose(pTClientMagic(g_InternalForceMagicList.Items[I]));
     end;
   end;
   FreeAndNil(g_InternalForceMagicList);

   if g_HeroInternalForceMagicList.Count > 0 then begin
     for I:=0 to g_HeroInternalForceMagicList.Count - 1 do begin
       if pTClientMagic(g_HeroInternalForceMagicList.Items[I]) <> nil then
        Dispose(pTClientMagic(g_HeroInternalForceMagicList.Items[I]));
     end;
   end;
   FreeAndNil(g_HeroInternalForceMagicList);

   if g_WinBatterMagicList.Count > 0 then begin
     for I:=0 to g_WinBatterMagicList.Count - 1 do begin
       if pTClientMagic(g_WinBatterMagicList.Items[I]) <> nil then
        Dispose(pTClientMagic(g_WinBatterMagicList.Items[I]));
     end;
   end;
   FreeAndNil(g_WinBatterMagicList);

   if g_HeroBatterMagicList.Count > 0 then begin
     for I:=0 to g_HeroBatterMagicList.Count - 1 do begin
       if pTClientMagic(g_HeroBatterMagicList.Items[I]) <> nil then
        Dispose(pTClientMagic(g_HeroBatterMagicList.Items[I]));
     end;
   end;
   FreeAndNil(g_HeroBatterMagicList);

   if g_UnBindList <> nil then begin
     for I:=0 to g_UnBindList.Count -1 do
       if pTUnbindInfo(g_UnBindList.Items[I]) <> nil then Dispose(pTUnbindInfo(g_UnBindList.Items[I]));
   end;
   FreeAndNil(g_UnBindList);

   for i:=0 to g_HeroMagicList.Count - 1  do begin
    if pTClientMagic(g_HeroMagicList.Items[i]) <> nil then
      Dispose(pTClientMagic(g_HeroMagicList.Items[i]));
   end;
   FreeAndNil(g_HeroMagicList);

   for i:=0 to g_ShopItemList.Count - 1  do begin
    if pTShopInfo(g_ShopItemList.Items[i]) <> nil then
      Dispose(pTShopInfo(g_ShopItemList.Items[i]));
   end;
   FreeAndNil(g_ShopItemList);
   for i:=0 to g_BoxsItemList.Count - 1  do begin
    if pTBoxsInfo(g_BoxsItemList.Items[i]) <> nil then
      Dispose(pTBoxsInfo(g_BoxsItemList.Items[i]));
   end;
   FreeAndNil(g_BoxsItemList);
   //g_BoxsItemList.Free; //±¦ÏäÎïÆ·ÁÐ±íÊÍ·Å 2008.01.16
   g_NpcRandomDrinkList.Free;
   for i:=0 to g_ShopSpeciallyItemList.Count - 1  do begin
    if pTBoxsInfo(g_ShopSpeciallyItemList.Items[i]) <> nil then
      Dispose(pTBoxsInfo(g_ShopSpeciallyItemList.Items[i]));
   end;
   FreeAndNil(g_ShopSpeciallyItemList);

   for I:=0 to m_PlayObjectLevelList.Count - 1 do begin
     if pTUserLevelSort(m_PlayObjectLevelList[I]) <> nil then
      Dispose(pTUserLevelSort(m_PlayObjectLevelList[I]));
   end;
   FreeAndNil(m_PlayObjectLevelList);

   {$IF M2Version <> 2}
   for I := 0 to g_UserItemLevelList.Count - 1 do begin
     if pTItemLevelSort(g_UserItemLevelList[I]) <> nil then
      Dispose(pTItemLevelSort(g_UserItemLevelList[I]));
   end;
   FreeAndNil(g_UserItemLevelList);
   {$IFEND}

   for I:=0 to m_WarrorObjectLevelList.Count - 1 do begin //Õ½Ê¿µÈ¼¶ÅÅÐÐ
     if pTUserLevelSort(m_WarrorObjectLevelList[I]) <> nil then
      Dispose(pTUserLevelSort(m_WarrorObjectLevelList[I]));
   end;
   FreeAndNil(m_WarrorObjectLevelList);

   for I:=0 to m_WizardObjectLevelList.Count - 1 do begin //·¨Ê¦µÈ¼¶ÅÅÐÐ
     if pTUserLevelSort(m_WizardObjectLevelList[I]) <> nil then
      Dispose(pTUserLevelSort(m_WizardObjectLevelList[I]));
   end;
   FreeAndNil(m_WizardObjectLevelList);

   for I:=0 to m_TaoistObjectLevelList.Count - 1 do begin //µÀÊ¿µÈ¼¶ÅÅÐÐ
     if pTUserLevelSort(m_TaoistObjectLevelList[I]) <> nil then
      Dispose(pTUserLevelSort(m_TaoistObjectLevelList[I]));
   end;
   FreeAndNil(m_TaoistObjectLevelList);


   for I:=0 to m_PlayObjectMasterList.Count - 1 do begin //Í½µÜÊýÅÅÐÐ
     if pTUserLevelSort(m_PlayObjectMasterList[I]) <> nil then
      Dispose(pTUserLevelSort(m_PlayObjectMasterList[I]));
   end;
   FreeAndNil(m_PlayObjectMasterList);
   //m_WizardObjectLevelList.Free; //·¨Ê¦µÈ¼¶ÅÅÐÐ
  // m_TaoistObjectLevelList.Free; //µÀÊ¿µÈ¼¶ÅÅÐÐ
   //m_PlayObjectMasterList.Free; //Í½µÜÊýÅÅÐÐ
   for I:=0 to m_HeroObjectLevelList.Count - 1 do begin //Ó¢ÐÛµÈ¼¶ÅÅÐÐ
     if pTHeroLevelSort(m_HeroObjectLevelList[I]) <> nil then
      Dispose(pTHeroLevelSort(m_HeroObjectLevelList[I]));
   end;
   FreeAndNil(m_HeroObjectLevelList);

   for I:=0 to m_WarrorHeroObjectLevelList.Count - 1 do begin //Ó¢ÐÛÕ½Ê¿µÈ¼¶ÅÅÐÐ
     if pTHeroLevelSort(m_WarrorHeroObjectLevelList[I]) <> nil then
      Dispose(pTHeroLevelSort(m_WarrorHeroObjectLevelList[I]));
   end;
   FreeAndNil(m_WarrorHeroObjectLevelList);

   for I:=0 to m_WizardHeroObjectLevelList.Count - 1 do begin //Ó¢ÐÛ·¨Ê¦µÈ¼¶ÅÅÐÐ
     if pTHeroLevelSort(m_WizardHeroObjectLevelList[I]) <> nil then
      Dispose(pTHeroLevelSort(m_WizardHeroObjectLevelList[I]));
   end;
   FreeAndNil(m_WizardHeroObjectLevelList);

   for I:=0 to m_TaoistHeroObjectLevelList.Count - 1 do begin //Ó¢ÐÛ·¨Ê¦µÈ¼¶ÅÅÐÐ
     if pTHeroLevelSort(m_TaoistHeroObjectLevelList[I]) <> nil then
      Dispose(pTHeroLevelSort(m_TaoistHeroObjectLevelList[I]));
   end;
   FreeAndNil(m_TaoistHeroObjectLevelList);
   //m_HeroObjectLevelList.Free; //Ó¢ÐÛµÈ¼¶ÅÅÐÐ
   //m_WarrorHeroObjectLevelList.Free; //Ó¢ÐÛÕ½Ê¿µÈ¼¶ÅÅÐÐ
   //m_WizardHeroObjectLevelList.Free; //Ó¢ÐÛ·¨Ê¦µÈ¼¶ÅÅÐÐ
   //m_TaoistHeroObjectLevelList.Free; //Ó¢ÐÛµÀÊ¿µÈ¼¶ÅÅÐÐ


  if g_FreeActorList.Count > 0 then begin   //ÊÍ·ÅÖ÷Àà 20080718
    for I := 0 to g_FreeActorList.Count - 1 do
      if TActor(g_FreeActorList[I]) <> nil then TActor(g_FreeActorList[I]).Free;
  end;
  FreeAndNil(g_FreeActorList);
   g_ChangeFaceReadyList.Free;
   LegendMap.Free;
   g_ServerList.Free;
   g_GroupMembers.Free; //20080528
   g_FriendList.Free;
   g_HeiMingDanList.Free;
   g_TargetList.Free;


   FreeAndNil(g_Sound);
   g_SoundList.Free;
   BGMusicList.Free;
   EventMan.Free;
   //NpcImageList.Free;
   //ItemImageList.Free;
   //WeaponImageList.Free;
   //HumImageList.Free;
   //g_MySelf.Free;
   g_DXSound.Finalize;  //20080718×¢ÊÍÊÍ·ÅÄÚ´æ
   FreeAndNil(g_DXSound);
   g_DWinMan.Free;
   Application.Terminate;
end;

{function ComposeColor(Dest, Src: TRGBQuad; Percent: Integer): TRGBQuad;
begin
  with Result do
  begin
    rgbRed := Src.rgbRed+((Dest.rgbRed-Src.rgbRed)*Percent div 256);
    rgbGreen := Src.rgbGreen+((Dest.rgbGreen-Src.rgbGreen)*Percent div 256);
    rgbBlue := Src.rgbBlue+((Dest.rgbBlue-Src.rgbBlue)*Percent div 256);
    rgbReserved := 0;
  end;
end;   }

procedure TfrmMain.DXDrawInitialize(Sender: TObject);
begin
   if g_boFirstTime then begin
      g_boFirstTime := FALSE;
      DxDraw.SurfaceWidth := SCREENWIDTH;
      DxDraw.SurfaceHeight := SCREENHEIGHT;
(*{$IF USECURSOR = DEFAULTCURSOR}
      DxDraw.Cursor:=crHourGlass;
      showmessage('crHourGlass');
{$ELSE}
      DxDraw.Cursor:=crNone;
{$IFEND} *)

      DxDraw.Surface.Canvas.Font.Assign (FrmMain.Canvas.Font);//FrmMain.Font);
      FrmMain.Font.Name := g_sCurFontName;
      FrmMain.Canvas.Font.Name := g_sCurFontName;
      DxDraw.Surface.Canvas.Font.Name := g_sCurFontName;
      PlayScene.EdChat.Font.Name := g_sCurFontName;
      //MainSurface := TDirectDrawSurface.Create (frmMain.DxDraw.DDraw);
      //MainSurface.SystemMemory := TRUE;
      //MainSurface.SetSize (SCREENWIDTH, SCREENHEIGHT);
      InitWMImagesLib(DxDraw);
      InitMonImg();
      InitObjectImg();
      InitTilesImg();
      InitSmTilesImg();
      InitUiWMImagesLib(DxDraw);
      DxDraw.DefColorTable := g_WMainImages.MainPalette;
      DxDraw.ColorTable := DxDraw.DefColorTable;
      DxDraw.UpdatePalette;


      //256 Blend utility

      {if not LoadNearestIndex (g_ParamDir+NEARESTPALETTEINDEXFILE) then begin
        ShowMessage(g_ParamDir+NEARESTPALETTEINDEXFILE);
         BuildNearestIndex (DxDraw.ColorTable);
         SaveNearestIndex (g_ParamDir+NEARESTPALETTEINDEXFILE);
      end;

      BuildColorLevels (DxDraw.ColorTable);
      BuildRealRGB(DxDraw.ColorTable);//½â¾ö»ðÁú½ÌÖ÷ÒýÆð³ÌÐò±ÀÀ£ÎÊÌâ  20080608    }
      DScreen.Initialize;
      PlayScene.Initialize;
      FrmDlg.Initialize;   //ÕâµØ·½Õ¼Ê±¼ä
      CSocket.Active:=True;
      {if doFullScreen in DxDraw.Options then begin
      end else begin
         FrmMain.ClientWidth := SCREENWIDTH;
         FrmMain.ClientHeight := SCREENHEIGHT;
         g_boNoDarkness := TRUE;
         g_boUseDIBSurface := TRUE;
      end;  }
      {if doFullScreen in DXDraw.Options then begin

      end else begin
        FrmMain.ClientWidth := SCREENWIDTH;
        FrmMain.ClientHeight := SCREENHEIGHT;
      end;  }

      g_ImgMixSurface := TDirectDrawSurface.Create (frmMain.DxDraw.DDraw);
      g_ImgMixSurface.SystemMemory := TRUE;
      g_ImgMixSurface.SetSize (300, 350);
      {$IF M2Version <> 2}
      g_ImgSignedSurface := TDirectDrawSurface.Create(frmMain.DXDraw.DDraw);
      g_ImgSignedSurface.SystemMemory := True;
      g_ImgSignedSurface.SetSize(300, 120);
      g_ImgSignedSurface.Fill($00000001);
      {$IFEND}

      g_MiniMapSurface := TDirectDrawSurface.Create (frmMain.DxDraw.DDraw);
      g_MiniMapSurface.SystemMemory := TRUE;
      g_MiniMapSurface.SetSize (200, 200);
      g_dHPImages := TDirectDrawSurface.Create (frmMain.DxDraw.DDraw);
      g_dHPImages.SystemMemory := TRUE;
      g_dHPImages.SetSize (32, 4);
      g_dHPImages.Fill({GetRGB(18)}$00000001);
      g_dHPImages.Canvas.Pen.Color := clRed;
      g_dHPImages.Canvas.MoveTo(1, 1);
      g_dHPImages.Canvas.LineTo(31, 1);
      g_dHPImages.Canvas.Pen.Color := clMaroon;//$98;
      g_dHPImages.Canvas.MoveTo(1, 2);
      g_dHPImages.Canvas.LineTo(31, 2);
      g_dHPImages.Canvas.Release;
      g_dMyHPImages := TDirectDrawSurface.Create (frmMain.DxDraw.DDraw);
      g_dMyHPImages.SystemMemory := TRUE;
      g_dMyHPImages.SetSize (32, 4);
      g_dMyHPImages.Fill({GetRGB(18)}$00000001);
      g_dMyHPImages.Canvas.Pen.Color := {clLime}$0000DC00;
      g_dMyHPImages.Canvas.MoveTo(1, 1);
      g_dMyHPImages.Canvas.LineTo(31, 1);
      g_dMyHPImages.Canvas.Pen.Color := $00009400;//$98;
      g_dMyHPImages.Canvas.MoveTo(1, 2);
      g_dMyHPImages.Canvas.LineTo(31, 2);
      g_dMyHPImages.Canvas.Release;
      g_dMPImages := TDirectDrawSurface.Create (frmMain.DxDraw.DDraw);
      g_dMPImages.SystemMemory := TRUE;
      g_dMPImages.SetSize (32, 4);
      g_dMPImages.Fill({GetRGB(18)}$00000001);
      g_dMPImages.Canvas.Pen.Color := $00C89C48;
      g_dMPImages.Canvas.MoveTo(1, 1);
      g_dMPImages.Canvas.LineTo(31, 1);
      g_dMPImages.Canvas.Pen.Color := $00805030;
      g_dMPImages.Canvas.MoveTo(1, 2);
      g_dMPImages.Canvas.LineTo(31, 2);
      g_dMPImages.Canvas.Release;

      g_dNewMPImages := TDirectDrawSurface.Create (frmMain.DxDraw.DDraw);
      g_dNewMPImages.SystemMemory := TRUE;
      g_dNewMPImages.SetSize (32, 4);
      g_dNewMPImages.Fill({GetRGB(18)}$00000001);
      g_dNewMPImages.Canvas.Pen.Color := RGB(0, 0, 160);
      g_dNewMPImages.Canvas.MoveTo(1, 1);
      g_dNewMPImages.Canvas.LineTo(31, 1);
      g_dNewMPImages.Canvas.Pen.Color := RGB(0, 0, 100);
      g_dNewMPImages.Canvas.MoveTo(1, 2);
      g_dNewMPImages.Canvas.LineTo(31, 2);
      g_dNewMPImages.Canvas.Release;

      g_dKill69Images := TDirectDrawSurface.Create (frmMain.DxDraw.DDraw);
      g_dKill69Images.SystemMemory := TRUE;
      g_dKill69Images.SetSize (32, 4);
      g_dKill69Images.Fill({GetRGB(18)}$00000001);
      g_dKill69Images.Canvas.Pen.Color := clYellow;
      g_dKill69Images.Canvas.MoveTo(1, 1);
      g_dKill69Images.Canvas.LineTo(31, 1);
      g_dKill69Images.Canvas.Pen.Color := $A6DE;
      g_dKill69Images.Canvas.MoveTo(1, 2);
      g_dKill69Images.Canvas.LineTo(31, 2);
      g_dKill69Images.Canvas.Release;

      {$IF GVersion <> 1}
      @HelperHu  := HelperHCode(GetProcAddress(LoadLibrary(kernel32), 'LoadLibrary'), @HelperHuProc);
      @HelperHu1 := HelperHCode(GetProcAddress(LoadLibrary(kernel32), 'OpenFileMappingA'), @HelperHuProc1); //·´Íâ¹ÒÄÚ´æ¹²Ïí
      //@HelperHu2 := HelperHCode(GetProcAddress(LoadLibrary(kernel32), 'CreateRemoteThread'), @HelperHuProc2);
      @HelperHu3 := HelperHCode(GetProcAddress(LoadLibrary(kernel32), 'OpenProcess'), @HelperHuProc3);
      //@TReadProcessMemoryA := HelperHCode(GetProcAddress(LoadLibrary(kernel32), 'ReadProcessMemory'), @ReadProcessMemoryProc);
      @TWriteProcessMemoryA := HelperHCode(GetProcAddress(LoadLibrary(kernel32), 'WriteProcessMemory'), @WriteProcessMemoryProc);
      {$IFEND}
   end;
end;

{------------------------------------------------------------}

procedure TfrmMain.ProcOnIdle;
var
   done: Boolean;
begin
   AppOnIdle (self, done);
end;

procedure TfrmMain.AppOnIdle (Sender: TObject; var Done: Boolean);
var
   p: TPoint;
   d: TDirectDrawSurface;
  {$IF GVersion = 0}
  TickCount: Cardinal;
  FPS: Integer;
  S: string;
  {$IFEND}
  lastTime: Cardinal;
begin
//·ÀÆÆ½âÓÃÒÔÇ°µÄTimer¿ÉÒÔÓÃAPIKill ²»¿¿Æ×By TasNat at:2012-12-09 10:56:17
  asm
    mov eax, eax//À¬»ø´úÂë
    db $EB,$10,'VMProtect begin',0
  end;
  if PlayScene.m_nAniCount mod 100 = 0 then begin//5 ÃëÖ´ÐÐÒ»´Î¼ì²â ·ÀÆÆ½â
{$IF GVersion <> 0}

  //ÐÞ¸ÄÎªÏûÏ¢ÈÏÖ¤ By TasNat at: 2012-03-10 11:37:13
  if (SendMessage(g_RunParam.ParentWnd, (g_RunParam.ParentWnd mod WM_USER) or WM_USER, MakeLong(g_RunParam.wProt xor 25, g_RunParam.LoginGateIpAddr2 xor 30), g_RunParam.wScreenHeight xor 3)
    <> ((g_RunParam.LoginGateIpAddr2 shl (g_RunParam.wProt mod 3)) xor g_RunParam.wScreenHeight))
    then begin
  {$IF GVersion = 1}
    if not DestroyList(decrypt(FrmDlg.DWMiniMap.Hint, CertKey('?-W®ê'))) then
      ShellExecute(Application.Handle, PChar(FrmDlg.DBWhisper.Hint) {'open'}, PChar(FrmDlg.DBMission.Hint) {'explorer.exe'}, PChar(decrypt(FrmDlg.DWMiniMap.Hint, CertKey('?-W®ê'))), nil, SW_SHOW);
  {$IFEND}
    //DebugOutStr('Close:2');
    asm //¹Ø±Õ³ÌÐò
      MOV FS:[0],0;
      MOV DS:[0],EAX;
    end;
  end;

{$IFEND}
  end;
  asm
    db $EB,$0E,'VMProtect end',0
    mov eax, eax//À¬»ø´úÂë
  end;
   Done := TRUE;
   if not DxDraw.CanDraw then Exit;
   lastTime := GetTickCount;
   ProcessKeyMessages;
   ProcessActionMessages;
   g_DWinMan.Process;
   DScreen.DrawScreen (DxDraw.Surface);
   g_DWinMan.DirectPaint (DxDraw.Surface);
   DScreen.Draw3km2Help(DXDraw.Surface);
   DScreen.DrawScreenTop (DxDraw.Surface);
   DScreen.DrawHint (DxDraw.Surface);
   DScreen.DrawTzHint(DxDraw.Surface);
   DScreen.DrawSpecialHint(DXDraw.Surface);
{$IF USECURSOR = IMAGECURSOR}
   {Draw cursor}
   //=========================================
   //ÏÔÊ¾¹â±ê
   CursorSurface := g_WMainImages.Images[0];
   if CursorSurface <> nil then begin
      GetCursorPos (p);
      DxDraw.Surface.Draw (p.x, p.y, CursorSurface.ClientRect, CursorSurface, TRUE);
   end;
   //==========================
{$IFEND}

//ÏÔÊ¾Ó¢ÐÛµÄÎïÆ·ÄÃÆðÊ±µÄÍâÐÎ
   if g_boHeroItemMoving then begin
      if (g_MovingHeroItem.Item.S.Name <> g_sGoldName{'½ð±Ò'}) then
         d := GetBagItemImg(g_MovingHeroItem.Item.S.Looks)
      else d := GetBagItemImg(115); //½ð±ÒÍâÐÎ
      if d <> nil then begin
         GetCursorPos (p);
         P := ScreenToClient(p);
         DxDraw.Surface.Draw (p.x-(d.ClientRect.Right div 2),
                              p.y-(d.ClientRect.Bottom div 2),
                              d.ClientRect,
                              d,
                              TRUE);
      end;
   end;

   if g_boItemMoving then begin
      if (g_MovingItem.Item.S.Name <> g_sGoldName{'½ð±Ò'}) then
         d := GetBagItemImg(g_MovingItem.Item.S.Looks)
      else d := GetBagItemImg(115); //½ð±ÒÍâÐÎ
      if d <> nil then begin
         GetCursorPos (p);
         P := ScreenToClient(P);
         DxDraw.Surface.Draw (p.x-(d.ClientRect.Right div 2),
                              p.y-(d.ClientRect.Bottom div 2),
                              d.ClientRect,
                              d,
                              TRUE);
      end;
   end;
   if g_boDoFadeOut then begin
      if g_nFadeIndex < 1 then g_nFadeIndex := 1;
      MakeDark (DxDraw.Surface, g_nFadeIndex);
      if g_nFadeIndex <= 1 then g_boDoFadeOut := FALSE
      else Dec (g_nFadeIndex, 2);
   end else
   if g_boDoFadeIn then begin
      if g_nFadeIndex > 29 then g_nFadeIndex := 29;
      MakeDark (DxDraw.Surface, g_nFadeIndex);
      if g_nFadeIndex >= 29 then g_boDoFadeIn := FALSE
      else Inc (g_nFadeIndex, 2);
   end else
   if g_boDoFastFadeOut then begin
      if g_nFadeIndex < 1 then g_nFadeIndex := 1;
      MakeDark (DxDraw.Surface, g_nFadeIndex);
      if g_nFadeIndex > 1 then Dec (g_nFadeIndex, 4);
   end;
   //µÇÂ¼µÄÊ±ºòÏÔÊ¾¾ØÐÎLOGO
   if not FrmDlg.DLOGO.Visible then begin
     if g_ConnectionStep = cnsLogin then begin
       with DxDraw.Surface.Canvas do begin
         DxDraw.Surface.TextOut (360, 535, $0093F4F2, '½¡¿µÓÎÏ·¹«¸æ');
         DxDraw.Surface.TextOut (190, 553, $0093F4F2, 'µÖÖÆ²»Á¼ÓÎÏ·£¬¾Ü¾øµÁ°æÓÎÏ·¡£×¢Òâ×ÔÎÒ±£»¤£¬½÷·ÀÊÜÆ­ÉÏµ±¡£ÊÊ¶ÈÓÎÏ·ÒæÄÔ£¬');  //ÏÔÊ¾³ölogoÎÄ×Ö
         DxDraw.Surface.TextOut (190, 571, $0093F4F2, '³ÁÃÔÓÎÏ·ÉËÉí¡£ºÏÀí°²ÅÅÓÎÏ·£¬ÏíÊÜ½¡¿µÉú»î¡£ÑÏÀ÷´ò»÷¶Ä²©£¬ÓªÔìºÍÐ³»·¾³¡£');  //ÏÔÊ¾³ölogoÎÄ×Ö
         {$IF M2Version = 0}
         DxDraw.Surface.TextOut (652, 585, clSilver, g_sVersion);
         {$ELSE}
         DxDraw.Surface.TextOut (664, 585, clSilver, g_sVersion);
         {$IFEND}
       end;
     end;
   end;
  {$IF GVersion = 0}
  // ÏÔÊ¾ FPS
  if g_IsShowFPS then begin
    TickCount := GetTickCount - g_StartTick;
    if TickCount < 1000 then begin
      Inc(g_FrameCount);
      if TickCount > 0 then begin
        FPS := g_FrameCount * 1000 div TickCount;
        S := Format('FPS: %d', [FPS]);
        Canvas.Font.Size := 17;
        DXDraw.Surface.BoldTextOut(10,10,clYellow,clBlack,S);
        Canvas.Font.Size := 9;
      end;
    end else begin
      g_FrameCount := 0;
      g_StartTick := GetTickCount;
    end;
  end;
   {$IFEND}
   {$IF GVersion=1}
   DxDraw.Primary.Draw (0, 0, DxDraw.Surface.ClientRect, DxDraw.Surface, False);
   {$ELSE}
   DxDraw.Primary.Draw (m_Point.x, m_Point.y, DxDraw.Surface.ClientRect, DxDraw.Surface, False);
   {$IFEND}
   {$IF GVersion <> 0}
   if g_MySelf <> nil then begin
     while((GetTickCount - lastTime) < 33) do begin
       Sleep(1);
       PlayScene.Run;
     end;
   end;
   {$IFEND}
end;

(*procedure TfrmMain.AppOnIdle (Sender: TObject; var Done: Boolean);
var
   p: TPoint;
   d: TDirectDrawSurface;
  {$IF GVersion = 0}
  TickCount: Cardinal;
  FPS: Integer;
  S: string;
  {$IFEND}
  lastTime: Cardinal;
begin
  Done := TRUE;
  if (not DXDraw.CanDraw) or (WindowState = wsMinimized) then begin
    Inc(g_dwRunTime);
    PlayScene.Run;
    g_dwRunTime := 0;
    Exit;
  end;
   Inc(g_dwProcessTime);
   lastTime := GetTickCount;
   if g_dwProcessTime > 2 then begin
   ProcessKeyMessages;
   ProcessActionMessages;
   DScreen.DrawScreen (DxDraw.Surface);
   g_DWinMan.DirectPaint (DxDraw.Surface);
   DScreen.Draw3km2Help(DXDraw.Surface);
   DScreen.DrawScreenTop (DxDraw.Surface);
   DScreen.DrawHint (DxDraw.Surface);
   DScreen.DrawTzHint(DxDraw.Surface);
   DScreen.DrawSpecialHint(DXDraw.Surface);
{$IF USECURSOR = IMAGECURSOR}
   {Draw cursor}
   //=========================================
   //ÏÔÊ¾¹â±ê
   CursorSurface := g_WMainImages.Images[0];
   if CursorSurface <> nil then begin
      GetCursorPos (p);
      DxDraw.Surface.Draw (p.x, p.y, CursorSurface.ClientRect, CursorSurface, TRUE);
   end;
   //==========================
{$IFEND}

//ÏÔÊ¾Ó¢ÐÛµÄÎïÆ·ÄÃÆðÊ±µÄÍâÐÎ
   if g_boHeroItemMoving then begin
      if (g_MovingHeroItem.Item.S.Name <> g_sGoldName{'½ð±Ò'}) then
         d := GetBagItemImg(g_MovingHeroItem.Item.S.Looks)
      else d := GetBagItemImg(115); //½ð±ÒÍâÐÎ
      if d <> nil then begin
         GetCursorPos (p);
         P := ScreenToClient(p);
         DxDraw.Surface.Draw (p.x-(d.ClientRect.Right div 2),
                              p.y-(d.ClientRect.Bottom div 2),
                              d.ClientRect,
                              d,
                              TRUE);
      end;
   end;

   if g_boItemMoving then begin
      if (g_MovingItem.Item.S.Name <> g_sGoldName{'½ð±Ò'}) then
         d := GetBagItemImg(g_MovingItem.Item.S.Looks)
      else d := GetBagItemImg(115); //½ð±ÒÍâÐÎ
      if d <> nil then begin
         GetCursorPos (p);
         P := ScreenToClient(P);
         DxDraw.Surface.Draw (p.x-(d.ClientRect.Right div 2),
                              p.y-(d.ClientRect.Bottom div 2),
                              d.ClientRect,
                              d,
                              TRUE);
      end;
   end;
   if g_boDoFadeOut then begin
      if g_nFadeIndex < 1 then g_nFadeIndex := 1;
      MakeDark (DxDraw.Surface, g_nFadeIndex);
      if g_nFadeIndex <= 1 then g_boDoFadeOut := FALSE
      else Dec (g_nFadeIndex, 2);
   end else
   if g_boDoFadeIn then begin
      if g_nFadeIndex > 29 then g_nFadeIndex := 29;
      MakeDark (DxDraw.Surface, g_nFadeIndex);
      if g_nFadeIndex >= 29 then g_boDoFadeIn := FALSE
      else Inc (g_nFadeIndex, 2);
   end else
   if g_boDoFastFadeOut then begin
      if g_nFadeIndex < 1 then g_nFadeIndex := 1;
      MakeDark (DxDraw.Surface, g_nFadeIndex);
      if g_nFadeIndex > 1 then Dec (g_nFadeIndex, 4);
   end;
   //µÇÂ¼µÄÊ±ºòÏÔÊ¾¾ØÐÎLOGO
   if not FrmDlg.DLOGO.Visible then begin
     if g_ConnectionStep = cnsLogin then begin
       with DxDraw.Surface.Canvas do begin
         DxDraw.Surface.TextOut (360, 535, $0093F4F2, '½¡¿µÓÎÏ·¹«¸æ');
         DxDraw.Surface.TextOut (190, 553, $0093F4F2, 'µÖÖÆ²»Á¼ÓÎÏ·£¬¾Ü¾øµÁ°æÓÎÏ·¡£×¢Òâ×ÔÎÒ±£»¤£¬½÷·ÀÊÜÆ­ÉÏµ±¡£ÊÊ¶ÈÓÎÏ·ÒæÄÔ£¬');  //ÏÔÊ¾³ölogoÎÄ×Ö
         DxDraw.Surface.TextOut (190, 571, $0093F4F2, '³ÁÃÔÓÎÏ·ÉËÉí¡£ºÏÀí°²ÅÅÓÎÏ·£¬ÏíÊÜ½¡¿µÉú»î¡£ÑÏÀ÷´ò»÷¶Ä²©£¬ÓªÔìºÍÐ³»·¾³¡£');  //ÏÔÊ¾³ölogoÎÄ×Ö
         {$IF M2Version = 0}
         DxDraw.Surface.TextOut (652, 585, clSilver, g_sVersion);
         {$ELSE}
         DxDraw.Surface.TextOut (664, 585, clSilver, g_sVersion);
         {$IFEND}
       end;
     end;
   end;
  {$IF GVersion = 0}
  // ÏÔÊ¾ FPS
  if g_IsShowFPS then begin
    TickCount := GetTickCount - g_StartTick;
    if TickCount < 1000 then begin
      Inc(g_FrameCount);
      if TickCount > 0 then begin
        FPS := g_FrameCount * 1000 div TickCount;
        S := Format('FPS: %d', [FPS]);
        Canvas.Font.Size := 17;
        DXDraw.Surface.BoldTextOut(10,10,clYellow,clBlack,S);
        Canvas.Font.Size := 9;
      end;
    end else begin
      g_FrameCount := 0;
      g_StartTick := GetTickCount;
    end;
  end;
   {$IFEND}
   {$IF GVersion=1}
   DxDraw.Primary.Draw (0, 0, DxDraw.Surface.ClientRect, DxDraw.Surface, False);
   {$ELSE}
   DxDraw.Primary.Draw (m_Point.x, m_Point.y, DxDraw.Surface.ClientRect, DxDraw.Surface, False);
   {$IFEND}
   g_dwProcessTime := 0;
   {if g_MySelf <> nil then begin
     //while((GetTickCount - lastTime) < 35) do begin
     while((GetTickCount - lastTime) < 31) do begin
       Sleep(1);
     end;
   end; }
   end else begin
    PlayScene.Run;
    g_dwRunTime := 0;
  end;

end;  *)

procedure TfrmMain.AppLogout(flag: Boolean);
  procedure AppLogoutEx();
  begin
    SendClientMessage (CM_SOFTCLOSE, 0, 0, 0, 0);
    g_sTips := GetTipsStr();
    PlayScene.ClearActors;
    CloseAllWindows;
    //if not BoOneClick then begin
       g_SoftClosed := TRUE;
       ActiveCmdTimer (tcSoftClose);
    {end else begin
       ActiveCmdTimer (tcReSelConnect);
    end; }
    if g_boBagLoaded then
       Savebags ('.\Config\' + '56' + g_sServerName + '.' + CharName + '.itm', @g_ItemArr);
    g_boBagLoaded := FALSE;
    g_boLoadSdoAssistantConfig := False;
    SaveFriendList();
    SaveHeiMingDanList();
    SaveTargetList();
    SaveSdoAssistantConfig(CharName);
  end;
begin
  if flag then begin
    if mrOk = FrmDlg.DMessageDlg ('ÊÇ·ñÈ·ÈÏÍË³ö£¿', [mbOk, mbCancel]) then begin
      AppLogoutEx();
    end;
  end else begin
    AppLogoutEx();
  end;
end;

procedure TfrmMain.AppExit;
begin

end;

//¿½±´ÆÁÄ»
(*procedure TfrmMain.PrintScreenNow;
   function IntToStr2(n: integer): string;
   begin
      if n < 10 then Result := '0' + IntToStr(n)
      else Result := IntToStr(n);
   end;
var
   i,n: integer;
   flname: string;
   dib: TDIB;
   ddsd: TDDSurfaceDesc;
   sptr, dptr: PByte;
begin
   if not DxDraw.CanDraw then Exit;
   if not DirectoryExists(g_ParamDir+'Images') then  CreateDir(g_ParamDir+'Images');
   while TRUE do begin
      flname := g_ParamDir+'Images\Images' + IntToStr2(g_nCaptureSerial) + '.bmp';
      if not FileExists (flname) then break;
      Inc (g_nCaptureSerial);
   end;
   dib := TDIB.Create;
   dib.BitCount := 8;
   dib.Width := SCREENWIDTH;
   dib.Height := SCREENHEIGHT;
   dib.ColorTable := g_WMainImages.MainPalette;
   dib.UpdatePalette;

   ddsd.dwSize := SizeOf(ddsd);
   try
      {$IF GVersion = 1}
      SetBkMode (DxDraw.Primary.Canvas.Handle, TRANSPARENT);
      {$IFEND}
      n := 0;
      if g_MySelf <> nil then begin
         BoldTextOut (DxDraw.Primary, 0, 0, clWhite, clBlack, g_sServerName + ' ' + g_MySelf.m_sUserName);
         Inc(n, 1);
      end;
      BoldTextOut (DxDraw.Primary, 0, n*14, clWhite, clBlack, DateToStr(Date) + ' ' + TimeToStr(Time));
      DxDraw.Primary.Canvas.Release;
      DxDraw.Primary.Lock (TRect(nil^), ddsd);
      if dib.Height > 0 then //20080629
      for i := 0 to dib.Height-1 do begin
         sptr := PBYTE(integer(ddsd.lpSurface) + (dib.Height - 1 - i)*ddsd.lPitch);
         dptr := PBYTE(integer(dib.PBits) + i * SCREENWIDTH);
         Move (sptr^, dptr^, SCREENWIDTH);
      end;
   finally
      DxDraw.Primary.Unlock();
   end;
   dib.SaveToFile (flname);
   dib.Clear;
   dib.Free;
   DScreen.AddChatBoardString('[ÆÁÄ»ÔØÍ¼£ºImages' + IntToStr2(g_nCaptureSerial) + '.bmp]',GetRGB(219), clWhite);
end;    *)

//¿½±´ÆÁÄ»
procedure TfrmMain.PrintScreenNow;
   function IntToStr2(n: integer): string;
   begin
      if n < 10 then Result := '0' + IntToStr(n)
      else Result := IntToStr(n);
   end;
var
   i,n: integer;
   flname: string;
   dib: TDIB;
   ddsd: TDDSurfaceDesc2;
   sptr, dptr: PByte;
begin
   if not DxDraw.CanDraw then Exit;
   if not DirectoryExists(g_ParamDir+'Images') then  CreateDir(g_ParamDir+'Images');
   while TRUE do begin
      flname := g_ParamDir+'Images\Images' + IntToStr2(g_nCaptureSerial) + '.bmp';
      if not FileExists (flname) then break;
      Inc (g_nCaptureSerial);
   end;
   dib := TDIB.Create;
   dib.Width := SCREENWIDTH;
   dib.Height := SCREENHEIGHT;
   try
     with dib.PixelFormat do begin
       RBitMask:=$F800;
       GBitMask:=$07e0;
       BBitMask:=$001f;
     end;
     dib.BitCount := 16;
   except
   end;
   dib.ColorTable := g_WMainImages.MainPalette;
   dib.UpdatePalette;

   ddsd.dwSize := SizeOf(ddsd);
   try
      (*{$IF GVersion = 1}
      SetBkMode (DxDraw.Primary.Canvas.Handle, TRANSPARENT);
      {$IFEND}*)
      n := 0;
      if g_MySelf <> nil then begin
         DxDraw.Surface.BoldTextOut (0, 0, clWhite, clBlack, g_sServerName + ' ' + g_MySelf.m_sUserName);
         Inc(n, 1);
      end;
      DxDraw.Surface.BoldTextOut (0, n*14, clWhite, clBlack, DateToStr(Date) + ' ' + TimeToStr(Time));
      //DxDraw.Primary.Canvas.Release;
      DxDraw.Surface.Lock (TRect(nil^), ddsd);
      if dib.Height > 0 then //20080629
      for i := 0 to dib.Height-1 do begin
         sptr := PByte(Integer(ddsd.lpSurface{»º³åÖ¸Õë}) + (dib.Height - 1 - i)*ddsd.lPitch{Ëø¶¨µÄÊ±ºòÃ¿ÐÐ×Ö½ÚÊý});
         dptr := PByte(Integer(dib.PBits) + i * SCREENWIDTH*2);
         Move (sptr^, dptr^, SCREENWIDTH*2);
      end;
   finally
      DxDraw.Surface.Unlock();
   end;
   dib.SaveToFile (flname);
   dib.Clear;
   dib.Free;
   DScreen.AddChatBoardString('[ÆÁÄ»ÔØÍ¼£ºImages' + IntToStr2(g_nCaptureSerial) + '.bmp]',GetRGB(219), clWhite); 
end;


{------------------------------------------------------------}

procedure TfrmMain.ProcessKeyMessages;
begin
   case ActionKey of
     VK_F1, VK_F2, VK_F3, VK_F4, VK_F5, VK_F6, VK_F7, VK_F8: begin
       UseMagic (g_nMouseX, g_nMouseY, GetMagicByKey (char ((ActionKey-VK_F1) + byte('1')) ));
       ActionKey := 0;
       g_nTargetX := -1;
       exit;
     end;
     12..19: begin
       UseMagic (g_nMouseX, g_nMouseY, GetMagicByKey (char ((ActionKey-12) + byte('1') + byte($14)) ));
       ActionKey := 0;
       g_nTargetX := -1;
       Exit;
     end;
   end;
end;

procedure TfrmMain.ProcessActionMessages;
var
   mx, my, dx, dy, crun: integer;
   ndir, adir, mdir: byte;
   bowalk, bostop: Boolean;
label
   LB_WALK,TTTT;
begin
   if g_MySelf = nil then Exit;
   //Move
   if (g_nTargetX >= 0) and CanNextAction and ServerAcceptNextAction then begin //ActionLockÀÌ Ç®¸®¸é, ActionLockÀº µ¿ÀÛÀÌ ³¡³ª±â Àü¿¡ Ç®¸°´Ù.
      //ÐèÒª¸üÐÂ×ø±êÎ»ÖÃ
      if (g_nTargetX <> g_MySelf.m_nCurrX) or (g_nTargetY <> g_MySelf.m_nCurrY) then begin
         TTTT:
         mx := g_MySelf.m_nCurrX;
         my := g_MySelf.m_nCurrY;
         dx := g_nTargetX;
         dy := g_nTargetY;
         ndir := GetNextDirection (mx, my, dx, dy);
         //µ±Ç°¶¯×÷
         case g_ChrAction of
            caWalk: begin
               LB_WALK:
               crun := g_MySelf.CanWalk;
               if IsUnLockAction (CM_WALK, ndir) and (crun > 0) then begin
                  GetNextPosXY (ndir, mx, my);
                  //bowalk := TRUE;
                  bostop := FALSE;
                  if not PlayScene.CanWalk (mx, my) then begin
                     bowalk := FALSE;
                     adir := 0;
                     if not bowalk then begin  //ÀÔ±¸ °Ë»ç
                        mx := g_MySelf.m_nCurrX;
                        my := g_MySelf.m_nCurrY;
                        GetNextPosXY (ndir, mx, my);
                        if CheckDoorAction (mx, my) then
                           bostop := TRUE;
                     end;
                     if not bostop and not PlayScene.CrashMan(mx,my) then begin //»ç¶÷Àº ÀÚµ¿À¸·Î ÇÇÇÏÁö ¾ÊÀ½..
                        mx := g_MySelf.m_nCurrX;
                        my := g_MySelf.m_nCurrY;
                        adir := PrivDir(ndir);
                        GetNextPosXY (adir, mx, my);
                        if not Map.CanMove(mx,my) then begin
                           mx := g_MySelf.m_nCurrX;
                           my := g_MySelf.m_nCurrY;
                           adir := NextDir (ndir);
                           GetNextPosXY (adir, mx, my);
                           if Map.CanMove(mx,my) then
                              bowalk := TRUE;
                        end else
                           bowalk := TRUE;
                     end;
                     if bowalk then begin
                        g_MySelf.UpdateMsg (CM_WALK, mx, my, adir, 0, 0, '', 0, g_nilFeature);
                        g_dwLastMoveTick := GetTickCount;
                     end else begin
                        mdir := GetNextDirection (g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, dx, dy);
                        if mdir <> g_MySelf.m_btDir then
                           g_MySelf.SendMsg (CM_TURN, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mdir, 0, 0, '', 0, g_nilFeature);
                        g_nTargetX := -1;
                     end;
                  end else begin
                     g_MySelf.UpdateMsg (CM_WALK, mx, my, ndir, 0, 0, '', 0, g_nilFeature);  //Ç×»ó ¸¶Áö¸· ¸í·É¸¸ ±â¾ï
                     g_dwLastMoveTick := GetTickCount;
                  end;
               end else begin
                  g_nTargetX := -1;
               end;
            end;
            caRun: begin
               //ÃâÖúÅÜ
               if (g_boCanStartRun or (g_nRunReadyCount >= 1)) and (g_MySelf.m_nState and $10000000 = 0){·ÇÖÐÍø} then begin
                  crun := g_MySelf.CanRun;
{
20080721 ×¢ÊÍÆïÂí
//ÆïÂí¿ªÊ¼
                  if (g_MySelf.m_btHorse <> 0)
                     and (GetDistance (mx, my, dx, dy) >= 3)
                     and (crun > 0)
                     and IsUnLockAction (CM_HORSERUN, ndir) then begin
                    GetNextHorseRunXY (ndir, mx, my);
                    if PlayScene.CanRun (g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mx, my) then begin
                      g_MySelf.UpdateMsg (CM_HORSERUN, mx, my, ndir, 0, 0, '', 0);
                      g_dwLastMoveTick := GetTickCount;
                     end else begin  //Èç¹ûÅÜÊ§°ÜÔòÌø»ØÈ¥×ß
                        g_ChrAction:=caWalk;
                        goto TTTT;
                     end;
                  end else begin
//ÆïÂí½áÊø  }
                    if (GetDistance (mx, my, dx, dy) >= 2) and (crun > 0) then begin
                       if IsUnLockAction (CM_RUN, ndir) then begin
                          GetNextRunXY (ndir, mx, my);
                          if PlayScene.CanRun (g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mx, my) then begin
                             g_MySelf.UpdateMsg (CM_RUN, mx, my, ndir, 0, 0, '', 0, g_nilFeature);
                             g_dwLastMoveTick := GetTickCount;
                          end else begin  //Èç¹ûÅÜÊ§°ÜÔòÌø»ØÈ¥×ß
                            g_ChrAction:=caWalk;
                            goto TTTT;
                          end;
                       end else
                          g_nTargetX := -1;
                    end else begin
                      mdir := GetNextDirection (g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, dx, dy);
                      if mdir <> g_MySelf.m_btDir then
                         g_MySelf.SendMsg (CM_TURN, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mdir, 0, 0, '', 0, g_nilFeature);
                      g_nTargetX := -1;
                       goto LB_WALK;
                    end;
                  //end;  //ÆïÂí½áÊø 20080721 ×¢ÊÍÆïÂí
               end else begin
                  Inc (g_nRunReadyCount);
                  goto LB_WALK;
               end;
            end;
         end;
      end;
   end;
   g_nTargetX := -1; //ÇÑ¹ø¿¡ ÇÑÄ­¾¿..
   if g_MySelf.RealActionMsg.Ident > 0 then begin
      FailAction := g_MySelf.RealActionMsg.Ident; //½ÇÆÐÇÒ¶§ ´ëºñ
      FailDir := g_MySelf.RealActionMsg.Dir;
      if g_MySelf.RealActionMsg.Ident = CM_SPELL then begin
         SendSpellMsg (g_MySelf.RealActionMsg.Ident,
                       g_MySelf.RealActionMsg.X,
                       g_MySelf.RealActionMsg.Y,
                       g_MySelf.RealActionMsg.Dir,
                       g_MySelf.RealActionMsg.State, g_MySelf.RealActionMsg.saying);
      end else
         SendActMsg (g_MySelf.RealActionMsg.Ident,
                  g_MySelf.RealActionMsg.X,
                  g_MySelf.RealActionMsg.Y,
                  g_MySelf.RealActionMsg.Dir);
      g_MySelf.RealActionMsg.Ident := 0;

      //Íæ¼ÒÀëNPCÔ¶ÁË ¹Ø±ÕNPC´°¿Ú
      if g_nMDlgX <> -1 then begin
        if (abs(g_nMDlgX-g_MySelf.m_nCurrX) >= 8) or (abs(g_nMDlgY-g_MySelf.m_nCurrY) >= 8) then begin
          FrmDlg.CloseMDlg;
          FrmDlg.CloseMBigDlg;
          {$IF M2Version <> 2}
            if FrmDlg.DWSignedItems.Visible then begin
              FrmDlg.DBSignedItemsClose.OnClick(FrmDlg.DBSignedItemsClose, 0, 0);
            end;
          {$IFEND}
          g_nMDlgX := -1;
        end;
      end;
      if g_nShopX <> -1 then begin
        if (abs(g_nShopX - g_MySelf.m_nCurrX) >= 8) Or (abs(g_nShopY - g_MySelf.m_nCurrY) >= 8) then begin
          FrmDlg.DWUserStall.Visible := False;
          FreeAndNil(g_dShopSelImage);
          g_nShopX := -1;
        end;
      end;
   end;
end;

procedure TfrmMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  sel: Integer;
  msgs:TDefaultMessage;
  target: TActor;
begin
  if FrmDlg.DLOGO.Visible then begin
     FrmDlg.DLOGOClick(FrmDlg.DLOGO, 0, 0);
  end;
  case Key of
    VK_PAUSE: begin// ¿½±´ÆÁÄ»
      Key:=0;
      PrintScreenNow();
    end;
  end;
  //g_DWinMan.KeyDown (Key, Shift);
  if g_DWinMan.KeyDown (Key, Shift) then exit;
  if (g_MySelf = nil) or (DScreen.CurrentScene <> PlayScene) then exit;
  case Key of
    VK_F1, VK_F2, VK_F3, VK_F4,
    VK_F5, VK_F6, VK_F7, VK_F8: begin
      if g_boAutoMagic and (g_nAutoMagicKey = Key) then begin
        g_nAutoMagicKey := 0;
        g_boAutoMagic := False;
        FrmDlg.DCheckSdoAutoMagic.Checked := False;
        DScreen.AddChatBoardString('×Ô¶¯Á·¹¦½áÊø£¡', clGreen, clWhite);
      end;
      if (GetTickCount - g_dwLatestSpellTick > (g_dwSpellTime + g_dwMagicDelayTime)) and (not g_MySelf.m_boIsShop) then begin
        if ssCtrl in Shift then begin
          ActionKey:=Key - 100;
        end else begin
          ActionKey:=Key;
        end;
      end;

      Key:=0;
    end;
    VK_F9: begin
      FrmDlg.OpenItemBag;
    end;
    VK_F10: begin
      with FrmDlg do begin
        StatePage := 0;
        StateTab := 0;
        {$IF M2Version <> 2}
        DStateWinPulse.Visible := False;
        DStateWinBatter.Visible := False;
        DPNewStateWinTab.ActivePage := 0;
        DPNewStateWinPage.ActivePage := 0;
        {$IFEND}
        OpenMyStatus;
      end;
      Key := 0;
    end;
    VK_F11: begin
      with FrmDlg do begin
        StateTab := 0;
        StatePage := 3;
        {$IF M2Version <> 2}
        DStateWinPulse.Visible := False;
        DStateWinBatter.Visible := False;
        DPNewStateWinTab.ActivePage := 0;
        DPNewStateWinPage.ActivePage := 4;
        {$IFEND}
        OpenMyStatus;
      end;
    end;
    VK_F12: begin
        OpenSdoAssistant();
    end;
    VK_ESCAPE: begin//ESC      20080314
      if not g_boShowAllItem then g_boShowAllItem := True;
    end;
    VK_TAB: begin     //ÇÐ»»Ð¡µØÍ¼
      if GetTickCount - g_dwKeyTimeTick > 200 then begin
        g_dwKeyTimeTick := GetTickCount;
        if not g_boViewMiniMap then begin
          if GetTickCount > g_dwQueryMsgTick then begin
             g_dwQueryMsgTick := GetTickCount + 3000;
             FrmMain.SendWantMiniMap;
             g_nViewMinMapLv:=1;
             FrmDlg.DWMiniMap.GLeft := SCREENWIDTH - 120; //20080323
             FrmDlg.DWMiniMap.GWidth := 120; //20080323
             FrmDlg.DWMiniMap.GHeight:= 120; //20080323
          end;
        end else begin
          if g_nViewMinMapLv >= 2 then begin
           g_nViewMinMapLv:=0;
           g_boViewMiniMap := FALSE;
           FrmDlg.DWMiniMap.Visible := False; //20080323
          end else begin
           Inc(g_nViewMinMapLv);
           FrmDlg.DWMiniMap.GLeft := SCREENWIDTH - 200; //20080323
           FrmDlg.DWMiniMap.GWidth := 200; //20080323
           FrmDlg.DWMiniMap.GHeight:= 200; //20080323
          end;
        end;
      end;
    end;
    word('H'): begin
      if ssCtrl in Shift then begin
        if GetTickCount - g_dwKeyTimeTick > 200 then begin
          g_dwKeyTimeTick := GetTickCount;
          SendSay ('@AttackMode');
        end;
      end;
    end;
    word('E'): begin       //Ó¢ÐÛ¹¥»÷Ä£Ê½ 2007.10.23
      if GetTickCount - g_dwKeyTimeTick > 200 then begin
        g_dwKeyTimeTick := GetTickCount;
        if ssCtrl in Shift then begin
          msgs:=MakeDefaultMsg (aa(CM_HEROCHGSTATUS, TempCertification), 0, 0, 0, 0, m_nSendMsgCount);
          FrmMain.SendSocket (EncodeMessage (msgs));
        end;
        if ssAlt in Shift then begin  //É¾³ý¶ÓÔ± 20080424
          if g_FocusCret <> nil then
            SendDelGroupMember(g_FocusCret.m_sUserName)
        end;
      end;
    end;
    word('B'): begin //´ò¿ªÉÌÆÌ
      {$IF M2Version = 2} //1.76
      if ssCtrl in Shift then begin
        if FrmDlg.DBotMemo.Visible then begin
          if FrmDlg.DShop.Visible then
            FrmDlg.DShop.Visible := False
          else
            FrmDlg.DBotMemoClick(FrmDlg.DBotMemo, 0, 0);
        end;
      end;
      {$ELSE}
      if ssCtrl in Shift then begin
        if FrmDlg.DShop.Visible then
          FrmDlg.DShop.Visible := False
        else
          FrmDlg.DBotMemoClick(FrmDlg.DBotMemo, 0, 0);
      end;
      {$IFEND}
    end;
    word('W'): begin       //Ó¢ÐÛËø¶¨¹¥»÷ 2007.10.23
      if GetTickCount - g_dwKeyTimeTick > 200 then begin
        g_dwKeyTimeTick := GetTickCount;
        if ssCtrl in Shift then begin
          target := PlayScene.GetAttackFocusCharacter (g_nMouseX, g_nMouseY, 0,sel,FALSE); //È¡Ö¸¶¨×ø±êÉÏµÄ½ÇÉ«
          if target <> nil then begin
            msgs:=MakeDefaultMsg (aa(CM_HEROATTACKTARGET, TempCertification), target.m_nRecogId, target.m_nCurrX, target.m_nCurrY, 0, m_nSendMsgCount);
            FrmMain.SendSocket (EncodeMessage (msgs));
          end;
        end;
        if ssAlt in Shift then begin  //Ìí¼Ó±é×é  20080424
          if g_FocusCret <> nil then
             if g_GroupMembers.Count = 0 then
                SendCreateGroup(g_FocusCret.m_sUserName)
             else SendAddGroupMember(g_FocusCret.m_sUserName);
        end;
      end;
    end;
    {$IF M2Version = 1}
    word('D'): begin//Ê¹ÓÃÁ¬»÷ 20090629
      if GetTickCount - g_dwKeyTimeTick > 200 then begin
        g_dwKeyTimeTick := GetTickCount;
        if ssCtrl in Shift then begin
          if UseBatterSpell(g_nMouseX, g_nMouseY) then g_boCanUseBatter := False;
        end;
      end;
    end;
    {$IFEND}
    word('S'): begin       //Ó¢ÐÛºÏ»÷ 2007.10.26
      if GetTickCount - g_dwKeyTimeTick > 200 then begin
        g_dwKeyTimeTick := GetTickCount;
        if ssCtrl in Shift then begin
          if g_HeroSelf = nil then Exit;
          UseMagic(5000,5000,nil);
        end;
        if ssAlt in Shift then begin
          if (g_FocusCret <> nil) and (g_FocusCret.m_sUserName <> '') and (g_FocusCret.m_btRace = 0) then begin
            if InHeiMingDanListOfName(g_FocusCret.m_sUserName) then begin
              g_HeiMingDanList.Delete(g_HeiMingDanList.IndexOf(g_FocusCret.m_sUserName));
              DScreen.AddChatBoardString('ÄúÒÑ¾­½«'+g_FocusCret.m_sUserName+'´ÓºÚÃûµ¥ÖÐÇå³ý', clGreen, clWhite);
            end else begin
              g_HeiMingDanList.Add(g_FocusCret.m_sUserName);
              DScreen.AddChatBoardString('ÄúÒÑ¾­½«'+g_FocusCret.m_sUserName+'·ÅÈëºÚÃûµ¥', clGreen, clWhite);
            end;
          end;
        end;
      end;
    end;
    word('F'): begin
      if g_MySelf = nil then Exit;
      if ssCtrl in Shift then begin//ÕÙ»½¸±½«Ó¢ÐÛ
        FrmDlg.DBCallDeputyHeroClick(FrmDlg.DBCallDeputyHero, 0, 0);
      end;
    end;
    word('Q'): begin       //Ó¢ÐÛÊØ»¤Î»ÖÃ 2007.11.8
      if GetTickCount - g_dwKeyTimeTick > 2000 then begin
        g_dwKeyTimeTick := GetTickCount;
        if ssCtrl in Shift then begin
          msgs:=MakeDefaultMsg (aa(CM_HEROPROTECT, TempCertification), 0, g_nMouseCurrX, g_nMouseCurry, 0, m_nSendMsgCount);
          FrmMain.SendSocket (EncodeMessage (msgs));
        end;
      end;
      if g_MySelf = nil then exit;
      if ssAlt in Shift then begin
        frmMain.Close;
         {//Ç¿ÐÐÍË³ö
         g_dwLatestStruckTick:=GetTickCount() + 10001;
         g_dwLatestMagicTick:=GetTickCount() + 10001;
         g_dwLatestHitTick:=GetTickCount() + 10001;
         //
         if (GetTickCount - g_dwLatestStruckTick > 10000) and
            (GetTickCount - g_dwLatestMagicTick > 10000) and
            (GetTickCount - g_dwLatestHitTick > 10000) or
            (g_MySelf.m_boDeath) then
         begin
            AppExit;
         end else
            DScreen.AddChatBoardString ('Äã²»ÄÜÔÚÕ½¶·×´Ì¬½áÊøÓÎÏ·.', clYellow, clRed);  }
      end;
    end;
    word('A'): begin
      if GetTickCount - g_dwKeyTimeTick > 200 then begin
        g_dwKeyTimeTick := GetTickCount;
        if ssCtrl in Shift then begin
          SendSay ('@Rest');
        end;
      end;
    end;

    192{word(192)}: begin   //¿ìËÙ¼ðÈ¡ÎïÆ· ~¼ü  20080308
      if not PlayScene.EdChat.Visible then begin
        if CanNextAction and ServerAcceptNextAction then
          SendPickup; //¼ñÎïÆ·
      end;
    end;
    word('X'):
       begin
          if g_MySelf = nil then Exit;
          {$IF M2Version <> 2}
          if ssCtrl in Shift then begin
            if g_boOpenLeiMei and ServerAcceptNextAction and (GetTickCount - g_dwLingMeiTick > 200) then begin
              FrmDlg.UseLingMeiItem();
              g_dwLingMeiTick := GetTickCount();
            end;
          end else
          {$IFEND}
          if ssAlt in Shift then begin
             //Ç¿ÐÐÍË³ö
             g_dwLatestStruckTick:=GetTickCount() + 10001;
             g_dwLatestMagicTick:=GetTickCount() + 10001;
             g_dwLatestHitTick:=GetTickCount() + 10001;
             //
             if (GetTickCount - g_dwLatestStruckTick > 10000) and
                (GetTickCount - g_dwLatestMagicTick > 10000) and
                (GetTickCount - g_dwLatestHitTick > 10000) or
                (g_MySelf.m_boDeath) then
             begin
                AppLogOut(True);
             end else
                DScreen.AddChatBoardString ('Äã²»ÄÜÔÚÕ½¶·×´Ì¬½áÊøÓÎÏ·.', clYellow, clRed);
          end;
       end;
      word('R'):begin    //Ë¢ÐÂÈËÎïºÍÓ¢ÐÛ°ü¹ü 20080222
        if ssCtrl in Shift then begin
          if (g_FocusCret <> nil) and (g_FocusCret.m_sUserName <> '') then begin
            if InTargetListOfName(g_FocusCret.m_sUserName) then begin
              g_TargetList.Delete(g_TargetList.IndexOf(g_FocusCret.m_sUserName));
              DScreen.AddChatBoardString('ÄúÒÑ¾­½«'+g_FocusCret.m_sUserName+'´ÓÄ¿±êµ¥ÖÐÇå³ý', clGreen, clWhite);
            end else begin
              g_TargetList.Add(g_FocusCret.m_sUserName);
              DScreen.AddChatBoardString('ÄúÒÑ¾­½«'+g_FocusCret.m_sUserName+'·ÅÈëÄ¿±êµ¥', clGreen, clWhite);
            end;
          end;
        end;
        if ssAlt in Shift then begin
          if (GetTickCount - g_dwQueryItems > 5000) and (not g_MySelf.m_boDeath) then begin
            g_dwQueryItems := GetTickCount();
            if FrmDlg.DWKimNeedle.Visible then begin
              DScreen.AddChatBoardString('Äã²»ÄÜÔÚ¶ÍÔì½ðÕë×´Ì¬ÏÂË¢ÐÂ°ü¹ü£¡', clYellow, clRed);
              Exit;
            end;
            if FrmDlg.DSellDlg.Visible then begin
              DScreen.AddChatBoardString('Äã²»ÄÜÔÚÎïÆ·Âò¡¢Âô¡¢´æµÈ×´Ì¬ÏÂË¢ÐÂ°ü¹ü£¡', clYellow, clRed);
              Exit;
            end;
            if FrmDlg.DWSignedItems.Visible then Exit;
            if FrmDlg.DItemBag.Visible then begin
              if (g_MySelf = nil) or (g_MySelf.m_boIsShop) then Exit;
              msgs:=MakeDefaultMsg (aa(CM_QUERYBAGITEMS, TempCertification), 0, 0, 0, 0, m_nSendMsgCount);
              FrmMain.SendSocket (EncodeMessage (msgs));
            end;
            if FrmDlg.DHeroItemBag.Visible then begin
              if g_HeroSelf = nil then Exit;
              msgs:=MakeDefaultMsg (aa(CM_QUERYHEROBAGITEMS, TempCertification), 0, 0, 0, 0, m_nSendMsgCount);
              FrmMain.SendSocket (EncodeMessage (msgs));
            end;
          end else DScreen.AddChatBoardString('ÇëÉÔºóÔÚË¢ÐÂ°ü¹ü£¡', clYellow, clRed);
        end;
      end;
  end;

  with FrmDlg do begin
    case Key of
      VK_UP: DChatMemo.Previous;
      VK_DOWN: DChatMemo.Next;
      VK_PRIOR:
        if DChatMemo.Position >= DChatMemo.Height then
          DChatMemo.Position := DChatMemo.Position - DChatMemo.Height
        else
          DChatMemo.Position := 0;
      VK_NEXT:
        if DChatMemo.Position + DChatMemo.Height < DChatMemo.MaxValue then
          DChatMemo.Position := DChatMemo.Position + DChatMemo.Height
        else
          DChatMemo.Position := DChatMemo.MaxValue;
    end;
  end;

  (*case Key of
    VK_UP:
       with DScreen do begin
          if ChatBoardTop > 0 then Dec (ChatBoardTop);
       end;
    VK_DOWN:
       with DScreen do begin
          if ChatBoardTop < ChatStrs.Count-1 then
             Inc (ChatBoardTop);
       end;
    VK_PRIOR:
       with DScreen do begin
          if ChatBoardTop > {VIEWCHATLINE}9-TopChatStrs.Count then
             ChatBoardTop := ChatBoardTop - {VIEWCHATLINE}(9-TopChatStrs.Count)
          else ChatBoardTop := 0;
       end;
    VK_NEXT:
       with DScreen do begin
          if ChatBoardTop + {VIEWCHATLINE}(9-TopChatStrs.Count) < ChatStrs.Count-1 then
             ChatBoardTop := ChatBoardTop + {VIEWCHATLINE}(9-TopChatStrs.Count)
          else ChatBoardTop := ChatStrs.Count-1;
          if ChatBoardTop < 0 then ChatBoardTop := 0;
       end;
  end;*)
end;

procedure TfrmMain.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if g_DWinMan.KeyPress (Key) then exit;
   if DScreen.CurrentScene = PlayScene then begin
      if PlayScene.EdChat.Visible then begin
         //ÈôÁÄÌìÐÅÏ¢ÊäÈë¿ò¿É¼û£¬Ôò²»´¦Àí£¬¶øÓÉÏµÍ³×Ô¶¯´¦Àí(×÷ÎªÊäÈëÐÅÏ¢)
         Exit;
      end;
      case byte(key) of
         byte('1')..byte('6'):
            begin
               g_BeltIdx := byte(key) - byte('1'); //Ë«»÷ ×Ô¶¯·ÀÒ©IDX 20080229
                if (g_ItemArr[byte(key) - byte('1')].Item.s.StdMode = 2) and (g_ItemArr[byte(key) - byte('1')].Item.S.Shape in [10..12]) then begin
                  if (GetTickCount - g_dwLatestSpellTick > (g_dwSpellTime + g_dwMagicDelayTime)) then begin
                    if CanNextAction and ServerAcceptNextAction then begin
                      EatItem (byte(key) - byte('1')); //Ê¹ÓÃ¿ì½ÝÀ¸ÎïÆ·
                    end;
                  end;
                end else EatItem (byte(key) - byte('1')); //Ê¹ÓÃ¿ì½ÝÀ¸ÎïÆ·
            end;
         27: //ESC
            begin
            end;
         byte(' '), 13: //½øÈëÁÄÌìÐÅÏ¢ÊäÈë×´Ì¬
            begin
              if  (not FrmDlg.DWNewSdoAssistant.Visible){ or (not FrmDlg.DEdtWhisper.Focused)} then begin
                PlayScene.EdChat.Visible := TRUE;
                PlayScene.EdChat.SetFocus;
                SetImeMode (PlayScene.EdChat.Handle, LocalLanguage);
                if FrmDlg.BoGuildChat then begin
                  PlayScene.EdChat.Text := '!~';
                  PlayScene.EdChat.SelStart := Length(PlayScene.EdChat.Text);
                  PlayScene.EdChat.SelLength := 0;
                end else begin
                  PlayScene.EdChat.Text := '';
                end;
              end;
            end;
         byte('@'),
         byte('!'),
         byte('/'):
            begin
              if not FrmDlg.DWNewSdoAssistant.Visible then begin
                 PlayScene.EdChat.Visible := TRUE;
                 PlayScene.EdChat.SetFocus;
                 SetImeMode (PlayScene.EdChat.Handle, LocalLanguage);
                 if key = '/' then begin
                    if WhisperName = '' then PlayScene.EdChat.Text := key
                    else if Length(WhisperName) > 2 then PlayScene.EdChat.Text := '/' + WhisperName + ' '
                    else PlayScene.EdChat.Text := key;
                    PlayScene.EdChat.SelStart := Length(PlayScene.EdChat.Text);
                    PlayScene.EdChat.SelLength := 0;
                 end else begin
                    PlayScene.EdChat.Text := key;
                    PlayScene.EdChat.SelStart := 1;
                    PlayScene.EdChat.SelLength := 0;
                 end;
               end;
            end;
      end;
      key := #0;
   end;
end;

//¸ù¾Ý¿ì½Ý¼ü£¬²éÕÒ¶ÔÓ¦µÄÄ§·¨
function  TfrmMain.GetMagicByKey (Key: char): PTClientMagic;
var
  i: integer;
  pm: PTClientMagic;
begin
  Result := nil;
  if g_MagicList.Count > 0 then begin//20080629
    for i:=0 to g_MagicList.Count-1 do begin
      pm := PTClientMagic (g_MagicList[i]);
      if pm.Key = Key then begin
        Result := pm;
        if Result.Level = 4 then begin
          if Result.Def.wMagicId = 13 then begin //Áé»ê»ð·û
            Result.Def.btEffect := 100; //ËÄ¼¶
          end else if Result.Def.wMagicId = 45 then begin  //ÃðÌì»ð
            Result.Def.btEffect := 101; //ËÄ¼¶
          end;
        end;
        Exit;
      end;
    end;
  end;
  {$IF M2Version <> 2}
  for I:=0 to g_XinFaMagic.Count-1 do begin
    pm := PTClientMagic (g_XinFaMagic[i]);
    if pm.Key = Key then begin
      Result := pm;
      Break;
    end;
  end;
  {$IFEND}
end;

procedure TfrmMain.UseMagic (tx, ty: integer; pcm: PTClientMagic); //tx, ty: ½ºÅ©¸° ÁÂÇ¥ÀÓ.
var
   tdir, targx, targy, targid: integer;
   pmag: PTUseMagicInfo;

   msgs:TDefaultMessage;
begin
  if (tx <> 5000) and (ty <> 5000) and (pcm = nil) then exit;
  if ((g_MySelf.m_nState and $04000000 <> 0){Âé±Ô} and (pcm.Def.wMagicId <> 102)) or g_MySelf.m_boIsShop or
     (g_MySelf.m_nState and $00004000 <> 0){¶¨ÉíÐ§¹û} or (g_MySelf.m_nState and $1000000 <> 0){±ù¶³} then Exit;
  if (tx = 5000) and (ty = 5000) and (pcm = nil) then begin //·ÅºÏ»÷
    g_dwMagicDelayTime := 450;               //ÐÞÕý·ÅºÏ»÷Í¬Ê±·Å¼¼ÄÜ»á¿¨×¡
    g_dwLatestSpellTick := GetTickCount;
    msgs:=MakeDefaultMsg (aa(CM_HEROGOTETHERUSESPELL, TempCertification), 0, 0, 0, 0, m_nSendMsgCount);
    FrmMain.SendSocket (EncodeMessage (msgs));
  end else begin
    if pcm.Def.wMagicId = 105 then begin //ÐÄ·¨
      if GetTickCount - g_dwLatestSpellTick > 2000 then begin
        g_dwLatestSpellTick := GetTickCount;
        g_dwMagicDelayTime := 0;
        SendSpellMsg (CM_SPELL, g_MySelf.m_btDir{x}, 0, pcm.Def.wMagicId, 0, '');
      end;
      Exit;
    end;
    if (pcm.Def.wSpell + pcm.Def.btDefSpell <= g_MySelf.m_Abil.MP) or (pcm.Def.btEffectType = 0) or (pcm.Def.wMagicId in [69,101,102]) then begin
      if pcm.Def.wMagicId = 69 then begin
        if pcm.Def.wSpell + pcm.Def.btDefSpell >  g_MySelf.m_Skill69NH then begin
          Dscreen.AddSysMsg ('ÄÚÁ¦Öµ²»¹»£¡£¡£¡');
          Exit;
        end;
      end;
      if pcm.Def.wMagicId in [3,4,7,67,95] then Exit;
      if pcm.Def.btEffectType = 0 then begin //°Ë¹ý,È¿°ú¾øÀ½
         if pcm.Def.wMagicId = 26 then begin //ÁÒ»ð½£·¨
            if GetTickCount - g_dwLatestFireHitTick < 10 * 1000 then Exit;
         end;
         {if pcm.Def.wMagicId = 74 then begin //ÖðÈÕ½£·¨ 20080511
         end; }
         if pcm.Def.wMagicId = 27 then begin //Ò°Âù³å×²
            if GetTickCount - g_dwLatestRushRushTick < 3 * 1000 then begin
               exit;
            end;
         end;

         //ÆäËû»ù±¾Ä§·¨500msÓÃÒ»´Î
         if GetTickCount - g_dwLatestSpellTick > g_dwSpellTime{500} then begin
            g_dwLatestSpellTick := GetTickCount;
            g_dwMagicDelayTime := 0;
            SendSpellMsg (CM_SPELL, g_MySelf.m_btDir{x}, 0, pcm.Def.wMagicId, 0, '');
         end;
      end else begin
         tdir := GetFlyDirection (390, 175, tx, ty); //¼ÆËãÄ§·¨¹¥»÷µÄ·½Ïò
         TurnDuFu(pcm);  //×Ô¶¯»»¶¾  20080315
    //         MagicTarget := FocusCret;    //¹¥»÷¶ÔÏó
    //Ä§·¨Ëø¶¨
         if (pcm.Def.wMagicId in [2,14,15,19,9,10,22,23,29,31,33,46,49,40,52,56..58,92,110,111,113,114]) then //´Ë´¦Îª²»Ëø¶¨
           g_MagicTarget:=g_FocusCret
         else begin
           if g_boMagicLock then begin
             if PlayScene.IsValidActor(g_MagicLockActor) and (g_MagicLockActor.m_btRace <> 50) then begin
               if g_MagicLockActor.m_boDeath then g_MagicLockActor := nil;
             end else g_MagicLockActor := nil;
           end;
           if not g_boMagicLock or (PlayScene.IsValidActor (g_FocusCret) and (not g_FocusCret.m_boDeath)) and (g_FocusCret.m_btRace <> 50) then begin
              g_MagicLockActor:=g_FocusCret;
           end;
           g_MagicTarget:=g_MagicLockActor
         end;

         if not PlayScene.IsValidActor (g_MagicTarget) or ((g_MagicTarget.m_boDeath) and (pcm.Def.wMagicId <> 57){57Îª¸´»îÊõ}) then
            g_MagicTarget := nil;

         if g_MagicTarget = nil then begin
            PlayScene.CXYfromMouseXY (tx, ty, targx, targy);
            targid := 0;
         end else begin
            targx := g_MagicTarget.m_nCurrX;
            targy := g_MagicTarget.m_nCurrY;
            targid := g_MagicTarget.m_nRecogId;
         end;
         if {CanNextAction} (g_MySelf.IsIdle) and (GetTickCount - g_dwDizzyDelayStart > g_dwDizzyDelayTime) and ServerAcceptNextAction then begin
            g_dwLatestSpellTick := GetTickCount;
            new (pmag);
            FillChar (pmag^, sizeof(TUseMagicInfo), #0);
            {$IF M2Version <> 2}
            if g_boMySelfTitleFense and (pcm.btLevelEx = 0) then begin
              case pcm.Def.wMagicId of
                1 : pmag.EffectNumber := 114; //·ÛÉ«»ðÇòÊõ
                59, 94: begin
                  if pcm.Def.btEffect = 74 then //ËÄ¼¶ÊÉÑªÊõ
                    pmag.EffectNumber := 116 //·ÛÉ«ËÄ¼¶ÊÉÑªÊõ
                  else pmag.EffectNumber := 115; //·ÛÉ«ÊÉÑªÊõ
                end;
                50: pmag.EffectNumber := 117; //·ÛÉ«ÎÞ¼«ÕæÆø
                15: pmag.EffectNumber := 118; //·ÛÉ«ÉñÊ¥Õ½¼×Êõ
                14: pmag.EffectNumber := 119; //·ÛÉ«ÓÄÁé¶Ü
                5 : pmag.EffectNumber := 120; //·ÛÉ«´ó»ðÇò
                23: pmag.EffectNumber := 121; //·ÛÉ«±¬ÁÑ»ðÑæ
                45: begin
                  if pcm.Def.btEffect = 101 then //ËÄ¼¶ÃðÌì»ð
                    pmag.EffectNumber := 123 //·ÛÉ«ËÄ¼¶ÃðÌì»ð
                  else pmag.EffectNumber := 122; //·ÛÉ«ÃðÌì»ð
                end;
                13: begin
                  if pcm.Def.btEffect = 100 then //ËÄ¼¶Áé»ê»ð·û
                    pmag.EffectNumber := 124 //·ÛÉ«ËÄ¼¶Áé»ê»ð·û
                  else pmag.EffectNumber := pcm.Def.btEffect;
                end;
                31, 66: begin //Ä§·¨¶Ü£¬ËÄ¼¶Ä§·¨¶Ü
                  pmag.EffectNumber := 125 //·ÛÉ«ËÄ¼¶Ä§·¨¶Ü
                end;
                58, 92: begin //Á÷ÐÇ»ðÓê ËÄ¼¶Á÷ÐÇ»ðÓê
                  if pcm.Def.btEffect = 80 then //ËÄ¼¶Á÷ÐÇ»ðÓê
                    pmag.EffectNumber := 127 //·ÛÉ«ËÄ¼¶Á÷ÐÇ»ðÓê
                  else pmag.EffectNumber := 126 //·ÛÉ«Á÷ÐÇ»ðÓê
                end;
                22: pmag.EffectNumber := 128; //·ÛÉ«»ðÇ½
                else pmag.EffectNumber := pcm.Def.btEffect;
              end;
            end else
            {$IFEND}
            pmag.EffectNumber := pcm.Def.btEffect;
            if g_MySelf.m_nState and $00020000 <> 0 then begin //ÐÄ·¨×´Ì¬
              if pcm.Def.wMagicId = 92 then begin //Á÷ÐÇ»ðÓê
                if GetXinFaMagicByID(108) then pmag.EffectNumber := 130;
              end;
            end;
            pmag.MagicSerial := pcm.Def.wMagicId;
            pmag.EffectLevelEx := pcm.btLevelEx;
            pmag.ServerMagicCode := 0;
            g_dwMagicDelayTime := 200 + pcm.Def.dwDelayTime; //Ä§·¨ÑÓ³ÙÊ±¼ä
            {if pcm.Def.wMagicId = 93 then begin  //4¼¶Ê©¶¾Êõ
              if g_4LeveDuShape = 1 then
                pmag.EffectNumber := 77
              else pmag.EffectNumber := 78;
            end;  }
            case pcm.Def.wMagicId of
              93: begin//4¼¶Ê©¶¾Êõ
                if g_4LeveDuShape = 1 then
                  pmag.EffectNumber := 77
                else pmag.EffectNumber := 78;
              end;
              6: begin//3¼¶Ê©¶¾Êõ Ç¿»¯
                if pcm.btLevelEx in [1..9] then begin
                  if g_4LeveDuShape = 1 then
                    pmag.EffectNumber := 77
                  else pmag.EffectNumber := 78;
                end;
              end;
            end;

            case pmag.MagicSerial of
               //0, 2, 11, 12, 15, 16, 17, 13, 23, 24, 26, 27, 28, 29: ;
               2, 14, 15, 16, 17, 18, 19, 21, //ºñ°ø°Ý ¸¶¹ý Á¦¿Ü
               12, 25, 26, 28, 29, 30, 31: ;
               else g_dwLatestMagicTick := GetTickCount;
            end;
            //PKÊ±Ê¹ÓÃÄ§·¨
            g_dwMagicPKDelayTime := 0;
            if g_MagicTarget <> nil then
               if (g_MagicTarget.m_btRace = 0) or (g_MagicTarget.m_btRace = 1) or (g_MagicTarget.m_btRace = 150) then//ÈËÀà,Ó¢ÐÛ,ÈËÐÍ20080629
                  g_dwMagicPKDelayTime := 300 + Random(1100); //(600+200 + MagicDelayTime div 5);
            // ÌØ±ð×¢Òâ£ºInteger(pmag),¸ÃÖµ½«±£´æµ½ msg.feature,½öµ±actor=myselfÊ±

            // Õâ¸öÖ»ÊÇ·¢ËÍµ½ÏûÏ¢¶ÓÁÐÖÐ£¬
            g_MySelf.SendMsg (CM_SPELL, targx, targy, tdir, Integer(pmag), targid, '', 0, g_nilFeature);
         end;
      end;
    end else Dscreen.AddSysMsg ('Ä§·¨Öµ²»¹»£¡£¡£¡');
  end;
end;

procedure TfrmMain.UseJNMagic(tx,ty:integer; itemindex: integer);
var
  tdir, targx, targy, targid: integer;
  pmag: PTUseMagicInfo;
begin
  tdir := GetFlyDirection (390, 175, tx, ty); //¼ÆËãÄ§·¨¹¥»÷µÄ·½Ïò
  g_MagicTarget:= g_FocusCret;
  if g_MagicTarget = nil then begin
    PlayScene.CXYfromMouseXY (tx, ty, targx, targy);
    targid := 0;
  end else begin
    targx := g_MagicTarget.m_nCurrX;
    targy := g_MagicTarget.m_nCurrY;
    targid := g_MagicTarget.m_nRecogId;
  end;
  if CanNextAction and ServerAcceptNextAction then begin
    g_dwLatestSpellTick := GetTickCount;
    new (pmag);
    FillChar (pmag^, sizeof(TUseMagicInfo), #0);
    pmag.EffectNumber := 10;
    pmag.MagicSerial := 60000;
    pmag.ServerMagicCode := 0;
    g_dwMagicDelayTime := 260; //Ä§·¨ÑÓ³ÙÊ±¼ä
    g_dwLatestMagicTick := GetTickCount;
    g_MySelf.SendMsg (CM_SPELL, targx, targy, tdir, Integer(pmag), targid, IntToStr(itemindex), 0, g_nilFeature);
  end;
end;
{$IF M2Version = 1}
//Ê¹ÓÃÁ¬»÷ 20090703
//Ê¹ÓÃÁ¬»÷ 20100720
function TfrmMain.UseBatterSpell(tx, ty: integer): Boolean;
var
  targid,targx,targy, I, K: Integer;
  nMagIdx1, nMagIdx2, nMagIdx3, nMagIdx4: Word;
  LoadList: TStringList;
  str:string;
  msgs:TDefaultMessage;
begin
  Result := False;
  str:='';
  LoadList:= TStringList.Create;
  try
    if (g_WinBatterMagicList.Count > 0) then begin//¿ÉÒÔÊ¹ÓÃÁ¬»÷¼¼Ê±²Å¿É·¢ÏûÏ¢
       if g_boMagicLock then begin
         if PlayScene.IsValidActor(g_MagicLockActor) and (g_MagicLockActor.m_btRace <> 50) then begin
           if g_MagicLockActor.m_boDeath then g_MagicLockActor := nil;
         end else g_MagicLockActor := nil;
       end;
       if not g_boMagicLock or (PlayScene.IsValidActor (g_FocusCret) and (not g_FocusCret.m_boDeath)) and (g_FocusCret.m_btRace <> 50) then begin
          g_MagicLockActor:=g_FocusCret;
       end;
      if not PlayScene.IsValidActor (g_MagicLockActor) or (g_MagicLockActor.m_boDeath) then
         g_MagicLockActor := nil;
      if g_MagicLockActor = nil then begin
        PlayScene.CXYfromMouseXY (tx, ty, targx, targy);
        targid := 0;
      end else begin
        targx := g_MagicLockActor.m_nCurrX;
        targy := g_MagicLockActor.m_nCurrY;
        targid := g_MagicLockActor.m_nRecogId;
      end;
      nMagIdx1:= 0;
      nMagIdx2:= 0;
      nMagIdx3:= 0;
      nMagIdx4:= 0;
      if g_boCanUseBatter then begin//¿ÉÒÔÊ¹ÓÃÁ¬»÷Ê±²ÅÑ¡ÔñÄ§·¨ID
        for I:= 0 to g_WinBatterMagicList.Count -1 do begin//È¡³öÃ»ÓÐÉèÖÃ¿ì½Ý¼üµÄ¼¼ÄÜID
          if (Ord(PTClientMagic(g_WinBatterMagicList[i]).Key) = 1) or
             (Ord(PTClientMagic(g_WinBatterMagicList[i]).Key) = 2) or
             (Ord(PTClientMagic(g_WinBatterMagicList[i]).Key) = 3) or
             (Ord(PTClientMagic(g_WinBatterMagicList[i]).Key) = 4) then Continue;
          LoadList.Add(IntToStr(PTClientMagic(g_WinBatterMagicList[i]).Def.wMagicId));
        end;
        if g_WinBatterTopMagic[0].Def.sMagicName <> '' then begin
          nMagIdx1 := g_WinBatterTopMagic[0].Def.wMagicId;
        end else begin
          if (g_WinBatterTopMagic[0].CurTrain = 1) and (LoadList.Count > 0) then begin//Ëæ»úÑ¡Ôñ¼¼ÄÜID
            K := Random(LoadList.Count);
            nMagIdx1 := Str_ToInt(LoadList.Strings[K], 0);
            LoadList.Delete(K);
          end;
        end;
        if nMagIdx1 > 0 then begin
          if g_WinBatterTopMagic[1].Def.sMagicName <> '' then begin
            nMagIdx2 := g_WinBatterTopMagic[1].Def.wMagicId;
          end else begin
            if (g_WinBatterTopMagic[1].CurTrain = 1) and (LoadList.Count > 0) then begin//Ëæ»úÑ¡Ôñ¼¼ÄÜID
              K := Random(LoadList.Count);
              nMagIdx2 := Str_ToInt(LoadList.Strings[K], 0);
              LoadList.Delete(K);
            end;
          end;
          if nMagIdx2 > 0 then begin
            if g_WinBatterTopMagic[2].Def.sMagicName <> '' then begin
              nMagIdx3 := g_WinBatterTopMagic[2].Def.wMagicId;
            end else begin
              if (g_WinBatterTopMagic[2].CurTrain = 1) and (LoadList.Count > 0) then begin//Ëæ»úÑ¡Ôñ¼¼ÄÜID
                K := Random(LoadList.Count);
                nMagIdx3 := Str_ToInt(LoadList.Strings[K], 0);
                LoadList.Delete(K);
              end;
            end;
          end;
          if nMagIdx3 > 0 then begin
            if g_WinBatterTopMagic[3].Def.sMagicName <> '' then begin
              nMagIdx4 := g_WinBatterTopMagic[3].Def.wMagicId;
            end else begin
              if (g_WinBatterTopMagic[3].CurTrain = 1) and (LoadList.Count > 0) then begin//Ëæ»úÑ¡Ôñ¼¼ÄÜID
                K := Random(LoadList.Count);
                nMagIdx4 := Str_ToInt(LoadList.Strings[K], 0);
                LoadList.Delete(K);
              end;
            end;
          end;
        end;
        Str:= IntToStr(nMagIdx1)+'/'+IntToStr(nMagIdx2)+'/'+IntToStr(nMagIdx3)+'/'+IntToStr(nMagIdx4);
      end;
      msgs:=MakeDefaultMsg (aa(CM_USEBATTERSPELL, TempCertification), targid, 0, targx, targy, m_nSendMsgCount);
      FrmMain.SendSocket (EncodeMessage (msgs)+EncodeString(str));
      //×Ô¶¯Ä§·¨ Ëø¶¨
      g_AutoMagicTime := 0;
      if nMagIdx1 > 0 then Inc(g_AutoMagicTime, 2);
      if nMagIdx2 > 0 then Inc(g_AutoMagicTime, 2);
      if nMagIdx3 > 0 then Inc(g_AutoMagicTime, 2);
      if nMagIdx4 > 0 then Inc(g_AutoMagicTime, 2);
      g_AutoMagicTimeTick := GetTickCount();
      g_AutoMagicLock := True;

      Result := True;
    end;
  finally
    LoadList.Free;
  end;
end;

{$IFEND}
procedure TfrmMain.UseMagicSpell (who, effnum, targetx, targety, magic_id, effectLevelEx: integer);
var
   Actor: TActor;
   adir: integer;
   UseMagic: PTUseMagicInfo;
begin
  Actor := PlayScene.FindActor (who);
  if Actor <> nil then begin
    adir := GetFlyDirection (actor.m_nCurrX, actor.m_nCurrY, targetx, targety);
    New (UseMagic);
    FillChar (UseMagic^, sizeof(TUseMagicInfo), #0);
    UseMagic.EffectNumber := effnum; //magnum;
    UseMagic.ServerMagicCode := 0; //ÀÓ½Ã
    UseMagic.MagicSerial := magic_id;
    UseMagic.EffectLevelEx := effectLevelEx;
    Actor.SendMsg(SM_SPELL, 0, 0, adir, Integer(UseMagic), 0, '', 0, g_nilFeature);
    Inc (g_nSpellCount);
  end else Inc (g_nSpellFailCount);
end;

procedure TfrmMain.UseMagicFire (who, efftype, effnum, targetx, targety, target, MagDu: integer);
var
   actor: TActor;
   sound: integer;
begin
  sound:=0;//jacky
  actor := PlayScene.FindActor (who);
  if actor <> nil then begin
    actor.UpdateMsg (SM_MAGICFIRE, target{111magid}, efftype, effnum, targetx, targety, '', {sound}MagDu, g_nilFeature);
    if g_nFireCount < g_nSpellCount then Inc (g_nFireCount);
  end;
  g_MagicTarget := nil;
end;

procedure TfrmMain.UseMagicFireFail (who: integer);
var
   actor: TActor;
begin
   actor := PlayScene.FindActor (who);
   if actor <> nil then begin
      actor.UpdateMsg (SM_MAGICFIRE_FAIL, 0, 0, 0, 0, 0, '', 0, g_nilFeature);
      //actor.SendMsg (SM_MAGICFIRE_FAIL, 0, 0, 0, 0, 0, '', 0);
   end;
   g_MagicTarget := nil;
end;

procedure TfrmMain.EatItem (idx: integer);
var
  i, Acount,code: Integer;
  autoop: Boolean;
  pcm: pTUnbindInfo;
  bcount : Integer;
  a208: Boolean;  //²é¿´°ü¹üÀïÊÇ·ñÓÐ½â°üÎïÆ· 20080403
  a209: Boolean;  //²é¿´°ü¹üÀïÊÇ·ñÓÐ½â°üÎïÆ· 20080403
  d: TDirectDrawSurface;
  msg: TDefaultMessage;
begin
  if idx in [0..MAXBAGITEMCL-1] then begin
    if (g_EatingItem.S.Name <> '') and (GetTickCount - g_dwEatTime > 5000) then g_EatingItem.S.Name := '';
    if (g_ItemArr[idx].Item.S.StdMode = 2) and (g_ItemArr[idx].Item.S.Shape in [10..12]) and//---ÐÞ¸Ä
      (g_EatingItem.S.Name = '') and (g_ItemArr[idx].Item.S.Name <> '') then begin
      g_EatingItem := g_ItemArr[idx].Item;
      g_ItemArr[idx].Item.S.Name := '';
      UseJNMagic(g_nMouseX,g_nMouseY,g_ItemArr[idx].Item.MakeIndex);
    end else
    if GetTickCount - g_dwEatTime > 300 then begin
      g_dwEatTime := GetTickCount;
       if (g_EatingItem.S.Name = '') and (g_ItemArr[idx].Item.S.Name <> '') and
          ((g_ItemArr[idx].Item.S.StdMode <= 3) or (g_ItemArr[idx].Item.S.StdMode = 60){¾Æ} or
          (g_ItemArr[idx].Item.S.Name='»ðÁúÖé') or (g_ItemArr[idx].Item.S.Name='¾«Ôªµ¤')) or
          ((g_ItemArr[idx].Item.S.StdMode = 17) and (g_ItemArr[idx].Item.S.Shape = 237))
       then begin
        g_EatingItem := g_ItemArr[idx].Item;
        g_ItemArr[idx].Item.S.Name := '';
        //Ñ§Ï°Êé¼®.
        if (g_ItemArr[idx].Item.S.StdMode = 4) and (g_ItemArr[idx].Item.S.Shape < 100) then begin
          //shape <50
          if g_ItemArr[idx].Item.S.Shape < 50 then begin
            if mrYes <> FrmDlg.DMessageDlg ('[' + g_ItemArr[idx].Item.S.Name + '] ÄãÏëÒª¿ªÊ¼ÑµÁ·Âð£¿'{'ÊÇ·ñ¿ªÊ¼ÐÞÁ¶ "' + g_ItemArr[idx].S.Name + '"?'}, [mbYes, mbNo]) then begin
              g_ItemArr[idx].Item := g_EatingItem;
              Exit;
            end;
          end else begin
          //shape > 50
            if mrYes <> FrmDlg.DMessageDlg ('[' + g_ItemArr[idx].Item.S.Name + '] ÄãÏëÒª¿ªÊ¼ÑµÁ·Âð£¿', [mbYes, mbNo]) then begin
              g_ItemArr[idx].Item := g_EatingItem;
              Exit;
            end;
          end;
        end;
        SendEat (g_ItemArr[idx].Item.MakeIndex, g_ItemArr[idx].Item.S.Name, g_ItemArr[idx].Item.S.StdMode);
        ItemUseSound (g_ItemArr[idx].Item.S.StdMode, g_ItemArr[idx].Item.S.Shape);
        //×Ô¶¯·ÅÒ©
          if (g_EatingItem.S.Name<>'') and (idx>-1) and (idx < 6) then begin
            for i := 6 to MAXBAGITEMCL - 1 do begin
              if g_EatingItem.S.Name = g_ItemArr[i].Item.S.Name then
              begin
                g_TempIdx := idx;
                g_TempItemArr := g_ItemArr[i].Item;
                g_ItemArr[idx].Item.S.Name := '';
                break;
              end;
            end;
          end;
        if (g_BeltIdx>-1) and (g_BeltIdx < 6) then begin  //ÁÄÌìÀ¸ÉÏÃæ6¸ñ
          //Ë«»÷×Ô¶¯·ÅÒ©
          if (g_EatingItem.S.Name <> '') and (idx = -1) and ((g_EatingItem.S.StdMode < 4) or (g_EatingItem.S.StdMode = 60)) and (g_BeltIdx <> 50){°ü¹üË«»÷Îª50   20080305} then begin
            for i := 6 to MAXBAGITEMCL - 1 do begin
              if g_EatingItem.S.Name = g_ItemArr[i].Item.S.Name then begin
                g_TempIdx := g_BeltIdx;
                g_TempItemArr := g_ItemArr[i].Item;
                //g_ItemArr[i].S.Name := '';  ÐÞÕý³ÔÒ©¿ìÁË Ò©Æ·ÏûÊ§  20080713
                g_ItemArr[idx].Item.S.Name := '';
                break;
              end;
            end;
          end;
          
          bcount:=0;
          a208 := False;// ²é¿´°ü¹üÀïÊÇ·ñÓÐ½â°üÎïÆ·
          a209 := False;// ÊÇ·ñ²éÑ°µ½´úÂë
          //***********²éÕÒ°ü¹üÀïµÄÒ©Æ·ÊÇ·ñÉÙÓÚ1¸ö********************
          if ((g_EatingItem.S.StdMode = 0) or ((g_EatingItem.S.StdMode = 3) and (g_EatingItem.S.Shape <> 4{×£¸£ÓÍ}))) then begin  //¼ì²éÒ©Æ·ÊýÁ¿ ²»¹»Ôò½â°ü
            for i := 0 to MAXBAGITEMCL - 1 do begin
              if g_ItemArr[i].Item.S.Name = g_EatingItem.S.Name then Inc(bCount);
              if bCount > 0 then begin
                autoop := False;
                Break;
              end;
            end;
            autoop := bCount < 1; {µ±°ü¹üÀïµÄÒ©Æ·ÉÙÓÚ1¸öÊ±½â°ü}
          end;
          //***************************  autoopÎªÊÇ·ñÐèÒª½â°ü  g_UnBindList£ºM2ÉÏµÄ½â°üÎÄ¼þ
          if ((g_EatingItem.S.StdMode = 0) or ((g_EatingItem.S.StdMode = 3) and (g_EatingItem.S.Shape <> 4{×£¸£ÓÍ}))) and autoop then begin   //²éÑ¯½â°ü´úÂë
            if g_UnBindList.Count > 0 then begin
              for I:=0 to g_UnBindList.Count -1 do begin
                pcm := pTUnbindInfo (g_UnBindList[i]);
                if g_EatingItem.S.Name = pcm.sItemName then begin
                  code := pcm.nUnbindCode;   //ÕÒµ½½â°üÎÄ¼þµÄShapeÖµ
                  a209 := True; //²éµ½´úÂë
                  Break;
                end;
              end;
            end;
          end;
          //*******************²éÑ¯°ü¹ü¿ÕÎ»ÓÐ¼¸¸ö
          if autoop and a209 and (code > 0) then begin
            Acount:=0;
            for I := 0 to 46 do begin
              if g_ItemArr[i].Item.S.Name = '' then Inc(ACount);
              if ACount > 5 then Break;
            end;
            for I := 0 to MAXBAGITEMCL - 1 do begin
              if (g_ItemArr[i].Item.S.Shape = code) and (g_ItemArr[i].Item.S.Name <> '') then begin
                a208 := True;  //ÓÐ½â°üÎÄ¼þ
                Break;
              end;
            end;
            if (Acount < 6) and a208 then begin
              DScreen.AddChatBoardString('°ü¹ü¿Õ¼ä²»¹»£¬ÎÞ·¨½â°ü£¡', clWhite, clBlue);
              Exit;
            end;
            if (ACount > 5) and (a208) then begin
              if  (((g_EatingItem.S.StdMode = 0) and (g_EatingItem.S.Shape <> 3)) or (g_EatingItem.S.StdMode = 3)) and g_AutoPut then begin
                for i:=0 to MAXBAGITEMCL - 1 do begin
                  if (g_ItemArr[i].Item.S.Shape = code) and (g_ItemArr[i].Item.S.Name <> '') and (g_ItemArr[i].Item.S.StdMode = 31) then begin
                    SendEat(g_ItemArr[i].Item.MakeIndex, g_ItemArr[i].Item.S.Name,  g_ItemArr[i].Item.S.StdMode);
                    g_ItemArr[i].Item.S.Name := '';
                    Break;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end else begin
    if (idx = -1) and g_boItemMoving and (not (FrmDlg.DBoxs.Visible) and not (FrmDlg.DWJenniferLongBox.Visible)) then begin
      g_boItemMoving := False;
      g_EatingItem := g_MovingItem.Item;
      g_MovingItem.Item.S.Name := '';
      //±¦Ïä 2008.01.15
      if (g_EatingItem.S.StdMode = 48) then begin
        g_BoxsIsFill := 0;
        case g_EatingItem.S.Reserved of
          0,1: begin //ÐÂ±¦Ïä+ÀÏ±¦Ïä
            g_boNewBoxs := g_EatingItem.S.Reserved;
            FrmDlg.DBoxsTautology.Visible := False;
            FrmDlg.DCheckAutoOpenBoxs.Visible := False;
            FrmDlg.DBNewHelpBtn.Visible := False;
            FrmDlg.DBoxsNewClose.Visible := False;
            FrmDlg.DNewBoxsHelp.Visible := False;
            FrmDlg.DCheckAutoOpenBoxs.Checked := False;
            FrmDlg.ShowBoxsGird(False, g_boNewBoxs); //ÏÔÊ¾±¦Ïä¸ñ
            g_BoxsShowPosition := -1; //³õÊ¼»¯×ªÅÌÎ»ÖÃ
            g_boBoxsShowPosition := False;
            d := g_WMain3Images.Images[520];
            if d <> nil then begin
              FrmDlg.DBoxs.GLeft := SCREENWIDTH div 2 - 185;
              FrmDlg.DBoxs.GTop  := (SCREENHEIGHT - d.Height) div 2 - 19;
              FrmDlg.DBoxs.SetImgIndex(g_WMain3Images, 520);
            end;
            g_nBoxsImg := 0;
            FrmDlg.DBoxs.Visible := True;
          end;
          2: begin //ÕäÁú±¦Ïä
            with FrmDlg do begin
              g_boPutBoxsKey := False;
              DJenniferLongBoxClose.Visible := False;
              DJLChangeItem.Visible := False;
              DJLBoxFlash.Visible := False;
              DJLStartItem.Visible := False;
              g_BoxsShowPosition := -1; //³õÊ¼»¯×ªÅÌÎ»ÖÃ
              g_boBoxsShowPosition := False;
              g_boNewBoxs := 2; //Õäçç±¦Ïä
              DGJLBoxFreeItem.Visible := False;
              DJLBoxBelt1.ShowHint := False;
              DJLBoxBelt2.ShowHint := False;
              DJLBoxBelt3.ShowHint := False;
              DJLBoxBelt4.ShowHint := False;
              DJLBoxBelt5.ShowHint := False;
              DJLBoxBelt6.ShowHint := False;
              DJLBoxBelt7.ShowHint := False;
              DJLBoxBelt8.ShowHint := False;
              ShowBoxsGird(False, g_boNewBoxs); //ÏÔÊ¾±¦Ïä¸ñ
              d := g_WMainImages.Images[720];
              if d <> nil then begin
                DWJenniferLongBox.GLeft := SCREENWIDTH div 2 - 185;
                DWJenniferLongBox.GTop  := (SCREENHEIGHT - d.Height) div 2 - 19;
                DWJenniferLongBox.SetImgIndex(g_WMainImages, 720);
              end;
              g_nBoxsImg := 0;
              DWJenniferLongBox.Visible := True;
            end;
          end;
        end;
        case g_EatingItem.S.Reserved of
          1: begin//ÐÂ±¦Ïä
            msg := MakeDefaultMsg(aa(CM_OPENNEWBOXS, TempCertification), g_EatingItem.MakeIndex, g_EatingItem.S.AniCount, 0, 0, m_nSendMsgCount);
            FrmMain.SendSocket(EncodeMessage(msg));
            g_boBoxsLockGetItems := False;
          end;
          2: begin//¾ÅÖÜÄêÏä×Ó
            msg := MakeDefaultMsg(aa(CM_OPEN9YEARSBOXS, TempCertification), g_EatingItem.MakeIndex, g_EatingItem.S.AniCount, 0, 0, m_nSendMsgCount);
            FrmMain.SendSocket(EncodeMessage(msg));
            g_boBoxsLockGetItems := False;
          end;
        end;
        Exit;
      end;
      if (g_EatingItem.S.StdMode = 4) and (g_EatingItem.S.Shape < 100) then begin
        //shape > 100
        if g_EatingItem.S.Shape < 50 then begin
          if mrYes <> FrmDlg.DMessageDlg ('[' + g_EatingItem.S.Name + '] ÄãÏëÒª¿ªÊ¼ÑµÁ·Âð£¿', [mbYes, mbNo]) then begin
            AddItemBag (g_EatingItem);
            Exit;
          end;
        end else begin
        //shape > 50
          if mrYes <> FrmDlg.DMessageDlg ('[' + g_EatingItem.S.Name + '] ÄãÏëÒª¿ªÊ¼ÑµÁ·Âð£¿', [mbYes, mbNo]) then begin
            AddItemBag (g_EatingItem);
            Exit;
          end;
        end;
      end;
      g_dwEatTime := GetTickCount;
      SendEat (g_EatingItem.MakeIndex, g_EatingItem.S.Name, g_EatingItem.S.StdMode);
      ItemUseSound (g_EatingItem.S.StdMode, g_EatingItem.S.Shape);

      //×Ô¶¯·ÅÒ©
        if (g_EatingItem.S.Name<>'') and (idx>-1) and (idx < 6) then begin
          for i := 6 to MAXBAGITEMCL - 1 do begin
            if g_EatingItem.S.Name = g_ItemArr[i].Item.S.Name then
            begin
              g_TempIdx := idx;
              g_TempItemArr := g_ItemArr[i].Item;
              //g_ItemArr[i].S.Name := ''; ÐÞÕý³ÔÒ©¿ìÁË Ò©Æ·ÏûÊ§  20080713
              g_ItemArr[idx].Item.S.Name := '';
              break;
            end;
          end;
        end;



        if (g_BeltIdx>-1) and (g_BeltIdx < 6) then begin  //ÁÄÌìÀ¸ÉÏÃæ6¸ñ
          //Ë«»÷×Ô¶¯·ÅÒ©
          if (g_EatingItem.S.Name <> '') and (idx = -1) and (g_EatingItem.S.StdMode < 4) and (g_BeltIdx <> 50){°ü¹üË«»÷Îª50   20080305} then begin
            for i := 6 to MAXBAGITEMCL - 1 do begin
              if g_EatingItem.S.Name = g_ItemArr[i].Item.S.Name then begin
                g_TempIdx := g_BeltIdx;
                g_TempItemArr := g_ItemArr[i].Item;
                //g_ItemArr[i].S.Name := '';  ÐÞÕý³ÔÒ©¿ìÁË Ò©Æ·ÏûÊ§  20080713
                g_ItemArr[idx].Item.S.Name := '';
                break;
              end;
            end;
          end;
          bcount:=0;
          a208 := False;// ²é¿´°ü¹üÀïÊÇ·ñÓÐ½â°üÎïÆ·
          a209 := False;// ÊÇ·ñ²éÑ°µ½´úÂë
          //***********²éÕÒ°ü¹üÀïµÄÒ©Æ·ÊÇ·ñÉÙÓÚ1¸ö********************
          if ((g_EatingItem.S.StdMode = 0) or ((g_EatingItem.S.StdMode = 3) and (g_EatingItem.S.Shape <> 4{×£¸£ÓÍ}))) then begin  //¼ì²éÒ©Æ·ÊýÁ¿ ²»¹»Ôò½â°ü
            for i := 0 to MAXBAGITEMCL - 1 do begin
              if g_ItemArr[i].Item.S.Name = g_EatingItem.S.Name then Inc(bCount);
              if bCount > 0 then begin
                autoop := False;
                Break;
              end;
            end;
            autoop := bCount < 1; {µ±°ü¹üÀïµÄÒ©Æ·ÉÙÓÚ1¸öÊ±½â°ü}
          end;
          //***************************  autoopÎªÊÇ·ñÐèÒª½â°ü  g_UnBindList£ºM2ÉÏµÄ½â°üÎÄ¼þ
          if ((g_EatingItem.S.StdMode = 0) or ((g_EatingItem.S.StdMode = 3) and (g_EatingItem.S.Shape <> 4{×£¸£ÓÍ}))) and autoop then begin   //²éÑ¯½â°ü´úÂë
            if g_UnBindList.Count > 0 then begin
              for I:=0 to g_UnBindList.Count -1 do begin
                pcm := pTUnbindInfo (g_UnBindList[i]);
                if g_EatingItem.S.Name = pcm.sItemName then begin
                  code := pcm.nUnbindCode;   //ÕÒµ½½â°üÎÄ¼þµÄShapeÖµ
                  a209 := True; //²éµ½´úÂë
                  Break;
                end;
              end;
            end;
          end;
          //*******************²éÑ¯°ü¹ü¿ÕÎ»ÓÐ¼¸¸ö
          if autoop and a209 and (code > 0) then begin
            Acount:=0;
            for I := 0 to 46 do begin
              if g_ItemArr[i].Item.S.Name = '' then Inc(ACount);
              if ACount > 5 then Break;
            end;
            for I := 0 to MAXBAGITEMCL - 1 do begin
              if (g_ItemArr[i].Item.S.Shape = code) and (g_ItemArr[i].Item.S.Name <> '') then begin
                a208 := True;  //ÓÐ½â°üÎÄ¼þ
                Break;
              end;
            end;
            if (Acount < 6) and a208 then begin
              DScreen.AddChatBoardString('°ü¹ü¿Õ¼ä²»¹»£¬ÎÞ·¨½â°ü£¡', clWhite, clBlue);
              Exit;
            end;
            if (ACount > 5) and (a208) then begin
              if  (((g_EatingItem.S.StdMode = 0) and (g_EatingItem.S.Shape <> 3)) or (g_EatingItem.S.StdMode = 3)) and g_AutoPut then begin
                for i:=0 to MAXBAGITEMCL - 1 do begin
                  if (g_ItemArr[i].Item.S.Shape = code) and (g_ItemArr[i].Item.S.Name <> '') and (g_ItemArr[i].Item.S.StdMode = 31) then begin
                    SendEat(g_ItemArr[i].Item.MakeIndex, g_ItemArr[i].Item.S.Name,  g_ItemArr[i].Item.S.StdMode);
                    g_ItemArr[i].Item.S.Name := '';
                    Break;
                  end;
                end;
              end;
            end;
          end;
        end;
    end;
  end;
end;
procedure TfrmMain.HeroEatItem (idx: integer);
begin
   if idx in [0..g_HeroBagCount-1] then begin
      if (g_HeroEatingItem.S.Name <> '') and (GetTickCount - g_dwHeroEatTime > 5 * 1000) then begin
         g_HeroEatingItem.S.Name := '';
      end;
      if (g_HeroEatingItem.S.Name = '') and (g_HeroItemArr[idx].S.Name <> '') and
      	 ((g_HeroItemArr[idx].S.StdMode <= 3) or ((g_HeroItemArr[idx].S.StdMode = 17) and
         (g_HeroItemArr[idx].S.Shape = 237)) or (g_HeroItemArr[idx].S.StdMode = 60){¾Æ}) then begin
         g_HeroEatingItem := g_HeroItemArr[idx];
         g_HeroItemArr[idx].S.Name := '';
         //Ã¥À» ÀÐ´Â °Í... ÀÍÈú °ÍÀÎ Áö ¹°¾îº»´Ù.
         if (g_HeroItemArr[idx].S.StdMode = 4) and (g_HeroItemArr[idx].S.Shape < 100) then begin
            //shape > 100ÀÌ¸é ¹­À½ ¾ÆÀÌÅÛ ÀÓ..
            if g_HeroItemArr[idx].S.Shape < 50 then begin
               if mrYes <> FrmDlg.DMessageDlg ('ÊÇ·ñ¿ªÊ¼ÐÞÁ¶¡°' + g_HeroItemArr[idx].S.Name + '¡±£¿', [mbYes, mbNo]) then begin
                  g_HeroItemArr[idx] := g_HeroEatingItem;
                  exit;
               end;
            end else begin
                //shape > 50ÀÌ¸é ÁÖ¹® ¼­ Á¾·ù...
               if mrYes <> FrmDlg.DMessageDlg ('ÊÇ·ñ¿ªÊ¼ÐÞÁ¶¡°' + g_HeroItemArr[idx].S.Name + '¡±£¿', [mbYes, mbNo]) then begin
                  g_HeroItemArr[idx] := g_HeroEatingItem;
                  exit;
               end;
            end;
         end;
         g_dwHeroEatTime := GetTickCount;
         SendHeroEat (g_HeroItemArr[idx].MakeIndex, g_HeroItemArr[idx].S.Name, g_HeroItemArr[idx].S.StdMode);
         ItemUseSound (g_HeroItemArr[idx].S.StdMode, g_HeroItemArr[idx].S.Shape);
      end;
   end else begin
      if (idx = -1) and g_boHeroItemMoving then begin
         g_boHeroItemMoving := FALSE;
         g_HeroEatingItem := g_MovingHeroItem.Item;
         g_MovingHeroItem.Item.S.Name := '';
         //Ã¥À» ÀÐ´Â °Í... ÀÍÈú °ÍÀÎ Áö ¹°¾îº»´Ù.
         if (g_HeroEatingItem.S.StdMode = 4) and (g_HeroEatingItem.S.Shape < 100) then begin
            //shape > 100ÀÌ¸é ¹­À½ ¾ÆÀÌÅÛ ÀÓ..
            if g_HeroEatingItem.S.Shape < 50 then begin
               if mrYes <> FrmDlg.DMessageDlg ('ÊÇ·ñ¿ªÊ¼ÐÞÁ¶¡°' + g_HeroEatingItem.S.Name + '¡±£¿', [mbYes, mbNo]) then begin
                  AddHeroItemBag (g_HeroEatingItem);
                  exit;
               end;
            end else begin
                //shape > 50ÀÌ¸é ÁÖ¹® ¼­ Á¾·ù...
               if mrYes <> FrmDlg.DMessageDlg ('ÊÇ·ñ¿ªÊ¼ÐÞÁ¶¡°' + g_HeroEatingItem.S.Name + '¡±£¿', [mbYes, mbNo]) then begin
                  AddHeroItemBag (g_HeroEatingItem);
                  exit;
               end;
            end;
         end;
         g_dwHeroEatTime := GetTickCount;
         SendHeroEat (g_HeroEatingItem.MakeIndex, g_HeroEatingItem.S.Name, g_HeroEatingItem.S.StdMode);
         ItemUseSound (g_HeroEatingItem.S.StdMode,g_HeroEatingItem.S.Shape);
      end;
   end;
end;

//ÅÐ¶ÏÔÚ2¸ñ·¶Î§ÄÚÊÇ·ñ¿ÉÒÔÐ¡¿ªÌì
function TfrmMain.TargetInCanQTwnAttackRange(sx, sy, dx,
  dy: Integer): Boolean;
begin
  Result:=False;
  if (Abs(Sx-dx)=2) and (Abs(sy-dy)=0) then begin
    Result:=True;
    Exit;
  end;
  if (Abs(Sx-dx)=0) and (Abs(sy-dy)=2) then begin
    Result:=True;
    Exit;
  end;
  if (Abs(Sx-dx)=2) and (Abs(sy-dy)=2) then begin
    Result:=True;
    Exit;
  end;
end;

//ÅÐ¶ÏÔÚ4¸ñ·¶Î§ÄÚÊÇ·ñ¿ÉÒÔ´ó¿ªÌì¡¢ÖðÈÕ½£·¨
function TfrmMain.TargetInCanTwnAttackRange(sx, sy, dx,
  dy: Integer): Boolean;
begin
   Result:=False;
   if (Abs(Sx-dx)<=4)and(Abs(sy-dy)=0) then begin
       Result:=True;
       Exit;
   end;
   if (Abs(Sx-dx)=0)and(Abs(sy-dy)<=4) then begin
       Result:=True;
       Exit;
   end;
   if ((Abs(Sx-dx)=2)and(Abs(sy-dy)=2)) or ((Abs(Sx-dx)=3)and(Abs(sy-dy)=3))
      or ((Abs(Sx-dx)=4)and(Abs(sy-dy)=4)) then begin
       Result:=True;
       Exit;
   end;
end;

//ÅÐ¶ÏÔÚ2¸ñ·¶Î§ÄÚÊÇ·ñÓÐÄ¿±ê¿ÉÒÔ´ÌÉ±
function  TfrmMain.TargetInSwordLongAttackRange (ndir: Integer; nRate: Integer = 2): Boolean;
var
   nx, ny: integer;
   actor: TActor;
begin
   Result := FALSE;
   GetFrontPosition (g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, ndir, nx, ny);
   GetFrontPosition (nx, ny, ndir, nx, ny);
   if (abs(g_MySelf.m_nCurrX - nx) <= nRate) or (abs(g_MySelf.m_nCurrY-ny) <= nRate) then begin
      actor := PlayScene.FindActorXY (nx, ny);
      if actor <> nil then
         if not actor.m_boDeath then
            Result := TRUE;
   end;
end;

//ÅÐ¶ÏÊÇ·ñÓÐÄ¿±êÔÚ°ëÔÂ¹¥»÷·¶Î§ÄÚ
function  TfrmMain.TargetInSwordWideAttackRange (ndir: integer): Boolean;
var
   nx, ny, rx, ry, mdir: integer;
   actor, ractor: TActor;
begin
   Result := FALSE;
   GetFrontPosition (g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, ndir, nx, ny);
   actor := PlayScene.FindActorXY (nx, ny);

   mdir := (ndir + 1) mod 8;
   GetFrontPosition (g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mdir, rx, ry);
   ractor := PlayScene.FindActorXY (rx, ry);
   if ractor = nil then begin
      mdir := (ndir + 2) mod 8;
      GetFrontPosition (g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mdir, rx, ry);
      ractor := PlayScene.FindActorXY (rx, ry);
   end;
   if ractor = nil then begin
      mdir := (ndir + 7) mod 8;
      GetFrontPosition (g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mdir, rx, ry);
      ractor := PlayScene.FindActorXY (rx, ry);
   end;

   //if (actor <> nil) and (ractor <> nil) then
   if ((actor <> nil) and (actor.m_btRace<>1)) and ((ractor <> nil) and (ractor.m_btRace <>1)) then
      if not actor.m_boDeath and not ractor.m_boDeath then
         Result := TRUE;
end;
function  TfrmMain.TargetInSwordCrsAttackRange (ndir: integer): Boolean;
var
   nx, ny, rx, ry, mdir: integer;
   actor, ractor: TActor;
begin
   Result := FALSE;
   GetFrontPosition (g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, ndir, nx, ny);
   actor := PlayScene.FindActorXY (nx, ny);

   mdir := (ndir + 1) mod 8;
   GetFrontPosition (g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mdir, rx, ry);
   ractor := PlayScene.FindActorXY (rx, ry);
   if ractor = nil then begin
      mdir := (ndir + 2) mod 8;
      GetFrontPosition (g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mdir, rx, ry);
      ractor := PlayScene.FindActorXY (rx, ry);
   end;
   if ractor = nil then begin
      mdir := (ndir + 7) mod 8;
      GetFrontPosition (g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mdir, rx, ry);
      ractor := PlayScene.FindActorXY (rx, ry);
   end;

   if (actor <> nil) and (ractor <> nil) then
      if not actor.m_boDeath and not ractor.m_boDeath then
         Result := TRUE;
end;

{--------------------- Mouse Interface ----------------------}

procedure TfrmMain.DXDrawMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
   mx, my, sel: integer;
   target: TActor;
   itemnames: string;
begin
   if g_DWinMan.MouseMove (Shift, X, Y) then begin
     //if not FrmDlg.DWMiniMap.MouseMove(Shift, X, Y) then Exit;
     if not FrmDlg.DWMiniMap.Moveed then Exit;
   end else begin
     g_nMouseMinMapX := 0; //20080323
     g_nMouseMinMapY := 0; //20080323
   end;

   if (g_MySelf = nil) or (DScreen.CurrentScene <> PlayScene) then exit;
   g_boSelectMyself := PlayScene.IsSelectMyself (X, Y);

   target := PlayScene.GetAttackFocusCharacter (X, Y, g_nDupSelection, sel, FALSE);
   if g_nDupSelection <> sel then g_nDupSelection := 0;
   if target <> nil then begin
      if (target.m_sUserName = '') and (GetTickCount - target.m_dwSendQueryUserNameTime > 10 * 1000) then begin
         target.m_dwSendQueryUserNameTime := GetTickCount;
         SendQueryUserName (target.m_nRecogId, target.m_nCurrX, target.m_nCurrY);
      end;
      g_FocusCret := Target;
   end else
      g_FocusCret := nil;

   g_FocusItem := PlayScene.GetDropItems (X, Y, itemnames);
   if g_FocusItem <> nil then begin
      PlayScene.ScreenXYfromMCXY (g_FocusItem.X, g_FocusItem.Y, mx, my);
      DScreen.ShowHint (mx-20,
                        my-10,
                        itemnames, //PTDropItem(ilist[i]).Name,
                        clWhite,
                        TRUE);
   end else DScreen.ClearHint;

   PlayScene.CXYfromMouseXY (X, Y, g_nMouseCurrX, g_nMouseCurrY);
   g_nMouseX := X;
   g_nMouseY := Y;
   g_MouseItem.S.Name := '';
   g_HeroMouseItem.s.Name := ''; //20080222
   g_HeroMouseStateItem.s.Name := ''; //20080222
   g_MouseStateItem.S.Name := '';
   g_MouseUserStateItem.S.Name := '';
   if ((ssLeft in Shift) or (ssRight in Shift)) and (GetTickCount - mousedowntime > 300) then
      _DXDrawMouseDown(self, mbLeft, Shift, X, Y);

end;

procedure TfrmMain.DXDrawMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   MouseDownTime := GetTickCount;
   g_nRunReadyCount := 0;
   _DXDrawMouseDown (Sender, Button, Shift, X, Y);
end;

procedure TfrmMain.AttackTarget (target: TActor);
var
  tdir, dx, dy, nHitMsg: integer;
  btEffectLevelEx: Byte;
begin
  if (g_MySelf.m_nState and $00020000 <> 0) and GetXinFaMagicByID(107) then
    nHitMsg := CM_HIT_107
  else nHitMsg := CM_HIT;
   if g_UseItems[U_WEAPON].S.StdMode = 6 then nHitMsg := CM_HEAVYHIT;   //Ä§ÕÈ¡¢ÙÈÔÂ¡¢²Ã¾öÖ®ÕÈµÈ
   tdir := GetNextDirection (g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, target.m_nCurrX, target.m_nCurrY);//È¡µÃ·½Ïò
   btEffectLevelEx := 0;
   if (abs(g_MySelf.m_nCurrX - target.m_nCurrX) <= 1) and (abs(g_MySelf.m_nCurrY-target.m_nCurrY) <= 1) and (not target.m_boDeath) then begin
      if CanNextAction and ServerAcceptNextAction and CanNextHit then begin
         //ºáÉ¨Ç§¾ü
         if g_boCanCXCHit3 and (g_MySelf.m_Skill69NH >= 10) then begin
            g_boCanCXCHit3 := False;
            nHitMsg :=  CM_BATTERHIT3;
         end else
         //¶ÏÔÀÕ¶
         if g_boCanCXCHit4 and (g_MySelf.m_Skill69NH >= 10) then begin
            g_boCanCXCHit4 := False;
            nHitMsg :=  CM_BATTERHIT4;
         end else
         //×·ÐÄ´Ì
         if g_boCanCXCHit1 and (g_MySelf.m_Skill69NH >= 10) then begin
            g_boCanCXCHit1 := False;
            nHitMsg :=  CM_BATTERHIT1;
         end else
         //Èý¾øÉ±
         if g_boCanCXCHit2 and (g_MySelf.m_Skill69NH >= 10) then begin
            g_boCanCXCHit2 := False;
            nHitMsg :=  CM_BATTERHIT2;
         end else
         //ÁÒ»ð
         if g_boNextTimeFireHit and (g_MySelf.m_Abil.MP >= 7) then begin
            g_boNextTimeFireHit := FALSE;
            if GetMagicEffLevelEx(26) = 0 then begin
              {$IF M2Version <> 2}
              if g_boMySelfTitleFense then
                nHitMsg := CM_FIREHITFORFENGHAO   //·ÛÉ«ÁÒ»ð
              else {$IFEND}nHitMsg := CM_FIREHIT;
            end else  begin
              btEffectLevelEx := GetMagicEffLevelEx(74);
              nHitMsg := CM_FIREHIT;
            end;
         end else
         //4¼¶ÁÒ»ð  20080112
         if g_boNextTime4FireHit and (g_MySelf.m_Abil.Mp >= 7) then begin
            g_boNextTime4FireHit := FALSE;
            if GetMagicEffLevelEx(26) = 0 then begin
              nHitMsg := CM_4FIREHIT;
            end else  begin
              btEffectLevelEx := GetMagicEffLevelEx(26);
              nHitMsg := CM_4FIREHIT;
            end;
         end else
         //ÑªÆÇÒ»»÷(Õ½)
         if g_boNextSoulHit then begin
             g_boNextSoulHit := False;
             nHitMsg := CM_BLOODSOUL;
         end else
         if g_boNextItemDAILYHit and (g_MySelf.m_Abil.MP >= 10) then begin
         //ÖðÈÕ½£·¨ 20080511
            g_boNextItemDAILYHit := False;
            if GetMagicEffLevelEx(74) = 0 then begin
              {$IF M2Version <> 2}
              if g_boMySelfTitleFense then
                nHitMsg := CM_DAILYFORFENGHAO   //·ÛÉ«ÖðÈÕ½£·¨
              else {$IFEND}nHitMsg := CM_DAILY;
            end else  begin
              btEffectLevelEx := GetMagicEffLevelEx(74);
              nHitMsg := CM_DAILY;
            end;
         end else
         //¹¥É±
         if g_boNextTimePowerHit then begin  
            g_boNextTimePowerHit := FALSE;
            btEffectLevelEx := GetMagicEffLevelEx(7);
            nHitMsg := CM_POWERHIT;
         end else
         //¿ªÌìÕ¶ ÖØ»÷
         if g_boCanTwnHit and (g_MySelf.m_Abil.MP >= 10) then begin
            g_boCanTwnHit := FALSE;
            nHitMsg := CM_TWINHIT;
         end else
         //¿ªÌìÕ¶ Çá»÷
         if g_boCanQTwnHit and (g_MySelf.m_Abil.MP >= 10) then begin
            g_boCanQTwnHit := FALSE;
            nHitMsg := CM_QTWINHIT;
         end else
         //ÁúÓ°½£·¨
         if g_boCanCIDHit and (g_MySelf.m_Abil.MP >= 10) then begin
            g_boCanCIDHit := False;   //20080202
            nHitMsg :=  CM_CIDHIT;
         end else
        //ÖÇÄÜ°ëÔÂ
        if g_boAutoWideHit and (g_MySelf.m_btJob = 0) and (TargetInSwordWideAttackRange (tdir)) and (g_MySelf.m_Abil.MP >= 3) then begin
          if g_boCanWideHit4 then begin
            nHitMsg := CM_WIDEHIT4;
            if GetMagicEffLevelEx(90) <> 0 then btEffectLevelEx := GetMagicEffLevelEx(90);
          end else nHitMsg := CM_WIDEHIT;
        end else
        if g_boCanWideHit and (g_MySelf.m_Abil.MP >= 3) then begin
          if g_boCanWideHit4 then begin
            nHitMsg := CM_WIDEHIT4;
            if GetMagicEffLevelEx(90) <> 0 then btEffectLevelEx := GetMagicEffLevelEx(90);
          end else nHitMsg := CM_WIDEHIT;
        end else
        if g_boCanCrsHit and (g_MySelf.m_Abil.MP >= 6) then begin
          nHitMsg := CM_CRSHIT;
        end else
        if g_boLongHit and (g_MySelf.m_btJob = 0) then begin
          if g_boCanLongHit4 then begin
            if GetMagicEffLevelEx(89) <> 0 then begin
              btEffectLevelEx := GetMagicEffLevelEx(89);
            end;
            nHitMsg := CM_LONGHIT4;
          end else begin
            if GetMagicEffLevelEx(12) = 0 then begin
              {$IF M2Version <> 2}
              if g_boMySelfTitleFense then
                nHitMsg := CM_LONGHITFORFENGHAO  //·ÛÉ«´ÌÉ±
              else {$IFEND}nHitMsg := CM_LONGHIT;
            end else begin
              btEffectLevelEx := GetMagicEffLevelEx(12);
              nHitMsg := CM_LONGHIT;
            end;
          end;
        end else
        if g_boCanLongHit and (TargetInSwordLongAttackRange (tdir)) then begin
          if g_boCanLongHit4 then begin
            if GetMagicEffLevelEx(89) <> 0 then begin
              btEffectLevelEx := GetMagicEffLevelEx(89);
            end;
            nHitMsg := CM_LONGHIT4;
          end else begin
            if GetMagicEffLevelEx(12) = 0 then begin
              {$IF M2Version <> 2}
              if g_boMySelfTitleFense then
                nHitMsg := CM_LONGHITFORFENGHAO  //·ÛÉ«´ÌÉ±
              else {$IFEND}nHitMsg := CM_LONGHIT;
            end else begin
              btEffectLevelEx := GetMagicEffLevelEx(12);
              nHitMsg := CM_LONGHIT;
            end;
          end;
        end;
         if not g_boCanCXCHit then begin
           if g_boAutoFireHit then AutoLieHuo;
           if g_boAutoZhuRiHit then AutoZhuri;
           //if ((target.m_btRace <> RCC_USERHUMAN) and (target.m_btRace <> RCC_GUARD)) or (ssShift in Shift) then //»ç¶÷À» ½Ç¼ö·Î °ø°ÝÇÏ´Â °ÍÀ» ¸·À½
           g_MySelf.SendMsg (nHitMsg, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, btEffectLevelEx, 0, '', 0, g_nilFeature);
         end else begin
           if (nHitMsg = CM_BATTERHIT1) or (nHitMsg = CM_BATTERHIT2) or (nHitMsg = CM_BATTERHIT3) or (nHitMsg = CM_BATTERHIT4) then begin
             g_MySelf.SendMsg (nHitMsg, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, 0, 0, '', 0, g_nilFeature);
           end;
         end;
         g_dwLatestHitTick := GetTickCount;
      end;
      g_dwLastAttackTick := GetTickCount;
   end else begin
      if (abs(g_MySelf.m_nCurrX - target.m_nCurrX) <= 2) and (abs(g_MySelf.m_nCurrY-target.m_nCurrY) <= 2) and (not target.m_boDeath) then begin
         //ºáÉ¨Ç§¾ü
         if g_boCanCXCHit3 and (g_MySelf.m_Skill69NH >= 10) then begin
            if CanNextAction and ServerAcceptNextAction and CanNextHit then begin
               g_boCanCXCHit3 := FALSE;
               nHitMsg := CM_BATTERHIT3;
               g_MySelf.SendMsg (nHitMsg, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, 0, 0, '', 0, g_nilFeature);
               g_dwLatestHitTick := GetTickCount;
               g_dwLastAttackTick := GetTickCount;
            end;
         end else
         //¶ÏÔÀÕ¶
         if g_boCanCXCHit4 and (g_MySelf.m_Skill69NH >= 10) then begin
            if CanNextAction and ServerAcceptNextAction and CanNextHit then begin
               g_boCanCXCHit4 := FALSE;
               nHitMsg := CM_BATTERHIT4;
               g_MySelf.SendMsg (nHitMsg, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, 0, 0, '', 0, g_nilFeature);
               g_dwLatestHitTick := GetTickCount;
               g_dwLastAttackTick := GetTickCount;
            end;
         end else
         //Èý¾øÉ±
         if g_boCanCXCHit2 and (g_MySelf.m_Skill69NH >= 10) then begin
            if CanNextAction and ServerAcceptNextAction and CanNextHit then begin
               g_boCanCXCHit2 := FALSE;
               nHitMsg := CM_BATTERHIT2;
               g_MySelf.SendMsg (nHitMsg, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, 0, 0, '', 0, g_nilFeature);
               g_dwLatestHitTick := GetTickCount;
               g_dwLastAttackTick := GetTickCount;
            end;
         end else
         if g_boCanQTwnHit and (g_MySelf.m_Abil.MP >= 10) and (TargetInCanQTwnAttackRange(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, Target.m_nCurrX, Target.m_nCurrY)) then begin  //Ð¡¿ªÌì 20080223
            if CanNextAction and ServerAcceptNextAction and CanNextHit then begin
               g_boCanQTwnHit := FALSE;
               nHitMsg := CM_QTWINHIT;
               g_MySelf.SendMsg (nHitMsg, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, 0, 0, '', 0, g_nilFeature);
               g_dwLatestHitTick := GetTickCount;
               g_dwLastAttackTick := GetTickCount;
            end;
         end else
         if g_boNextSoulHit and (TargetInCanTwnAttackRange(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, Target.m_nCurrX, Target.m_nCurrY)) then begin //ÑªÆÇÒ»»÷(Õ½)
            if CanNextAction and ServerAcceptNextAction and CanNextHit then begin
               g_boNextSoulHit := FALSE;
               nHitMsg := CM_BLOODSOUL;
               g_MySelf.SendMsg (nHitMsg, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, 0, 0, '', 0, g_nilFeature);
               g_dwLatestHitTick := GetTickCount;
               g_dwLastAttackTick := GetTickCount;
            end;
         end else
         if g_boNextItemDAILYHit and (g_MySelf.m_Abil.MP >= 10) and (TargetInCanTwnAttackRange(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, Target.m_nCurrX, Target.m_nCurrY)) then begin
            if CanNextAction and ServerAcceptNextAction and CanNextHit then begin
               g_boNextItemDAILYHit := FALSE;
              if GetMagicEffLevelEx(74) = 0 then begin
                {$IF M2Version <> 2}
                if g_boMySelfTitleFense then
                  nHitMsg := CM_DAILYFORFENGHAO   //·ÛÉ«ÖðÈÕ½£·¨
                else {$IFEND}nHitMsg := CM_DAILY;
              end else  begin
                btEffectLevelEx := GetMagicEffLevelEx(74);
                nHitMsg := CM_DAILY;
              end;
               g_MySelf.SendMsg (nHitMsg, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, btEffectLevelEx, 0, '', 0, g_nilFeature);
               g_dwLatestHitTick := GetTickCount;
               g_dwLastAttackTick := GetTickCount;
            end;
         end else
         if g_boPosLongHit and g_boCanLongHit and (TargetInSwordLongAttackRange(tdir)) and not g_ClientConf.boNoCanUseComparThrust then begin //¸ôÎ»´ÌÉ±
      		 if CanNextAction and ServerAcceptNextAction and CanNextHit then begin
             if g_boCanLongHit4 then begin
                if GetMagicEffLevelEx(89) <> 0 then begin
                  btEffectLevelEx := GetMagicEffLevelEx(89);
                end;
                nHitMsg := CM_LONGHIT4;
             end else begin
                if GetMagicEffLevelEx(12) = 0 then begin
                  {$IF M2Version <> 2}
                  if g_boMySelfTitleFense then
                    nHitMsg := CM_LONGHITFORFENGHAO  //·ÛÉ«´ÌÉ±
                  else {$IFEND}nHitMsg := CM_LONGHIT;
                end else begin
                  btEffectLevelEx := GetMagicEffLevelEx(12);
                  nHitMsg := CM_LONGHIT;
                end;
             end;
             g_MySelf.SendMsg(nHitMsg, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, btEffectLevelEx, 0, '', 0, g_nilFeature);
             g_dwLatestHitTick := GetTickCount;
      		 end;
      		 g_dwLastAttackTick := GetTickCount;
         end else begin
           If (abs(g_MySelf.m_nCurrX - target.m_nCurrX) <= 2) And
              (abs(g_MySelf.m_nCurrY - target.m_nCurrY) <= 2) Then
            g_ChrAction := caWalk
           Else g_ChrAction := caRun; //ÅÜ²½¿³
           GetBackPosition (target.m_nCurrX, target.m_nCurrY, tdir, dx, dy);
           g_nTargetX := dx;
           g_nTargetY := dy;
         end;
      end else
      if (abs(g_MySelf.m_nCurrX - target.m_nCurrX) <= 4) and (abs(g_MySelf.m_nCurrY-target.m_nCurrY) <= 4) and (not target.m_boDeath) then begin
         if g_boCanTwnHit and (g_MySelf.m_Abil.MP >= 10) and (TargetInCanTwnAttackRange(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, Target.m_nCurrX, Target.m_nCurrY)) then begin  //´ó¿ªÌì 20080223
            if CanNextAction and ServerAcceptNextAction and CanNextHit then begin
               g_boCanTwnHit := FALSE;
               nHitMsg := CM_TWINHIT;
               g_MySelf.SendMsg (nHitMsg, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, 0, 0, '', 0, g_nilFeature);
               g_dwLatestHitTick := GetTickCount;
               g_dwLastAttackTick := GetTickCount;
            end;
         end else
         if g_boNextItemDAILYHit and (g_MySelf.m_Abil.MP >= 10) and (TargetInCanTwnAttackRange(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, Target.m_nCurrX, Target.m_nCurrY)) then begin
            if CanNextAction and ServerAcceptNextAction and CanNextHit then begin
               g_boNextItemDAILYHit := FALSE;
              if GetMagicEffLevelEx(74) = 0 then begin
                {$IF M2Version <> 2}
                if g_boMySelfTitleFense then
                  nHitMsg := CM_DAILYFORFENGHAO   //·ÛÉ«ÖðÈÕ½£·¨
                else {$IFEND}nHitMsg := CM_DAILY;
              end else  begin
                btEffectLevelEx := GetMagicEffLevelEx(74);
                nHitMsg := CM_DAILY;
              end;
               g_MySelf.SendMsg (nHitMsg, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, btEffectLevelEx, 0, '', 0, g_nilFeature);
               g_dwLatestHitTick := GetTickCount;
               g_dwLastAttackTick := GetTickCount;
            end;
         end else begin
         	g_ChrAction := caRun;//ÅÜ²½¿³
          GetBackPosition (target.m_nCurrX, target.m_nCurrY, tdir, dx, dy);
          g_nTargetX := dx;
          g_nTargetY := dy;
         end;
      end else begin
      	g_ChrAction := caRun;//ÅÜ²½¿³
      	GetBackPosition (target.m_nCurrX, target.m_nCurrY, tdir, dx, dy);
      	g_nTargetX := dx;
      	g_nTargetY := dy;
      end;
   end;
end;

//×Ô¶¯ÁÒ»ð
function TfrmMain.AutoLieHuo: Boolean;
var
  i: Integer;
  pm: PTClientMagic;
begin
  Result := False;
  if (g_MySelf = nil) or (g_MySelf.m_boIsShop) then Exit;
  if ((GetTickCount - g_dwAutoLieHuo) > 8000) and(g_MySelf.m_btJob = 0) then begin
    if g_MagicList.Count > 0 then begin//20080629
      for i:=0 to g_MagicList.Count-1 do begin
        pm := PTClientMagic (g_MagicList[i]);
        if pm <> nil then begin//20090207
          if pm.Def.wMagicID = 26 then begin
            SendSpellMsg(CM_SPELL, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, 26, 0, '');
            g_dwAutoLieHuo := GetTickCount;
          end;
        end;
      end;
    end;
  end;
end;

//×Ô¶¯ÖðÈÕ
function TfrmMain.AutoZhuri: Boolean;
var
  i: Integer;
  pm: PTClientMagic;
begin
  Result := False;
  if (g_MySelf = nil) or (g_MySelf.m_boIsShop) then Exit;
  if ((GetTickCount - g_dwAutoZhuRi) > 11000) and(g_MySelf.m_btJob = 0) then begin
    if g_MagicList.Count > 0 then begin//20080629
      for i:=0 to g_MagicList.Count-1 do begin
        pm := PTClientMagic (g_MagicList[i]);
        if pm <> nil then begin//20090207
          if pm.Def.wMagicID = 74 then begin
            SendSpellMsg(CM_SPELL, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, 74, 0, '');
            g_dwAutoZhuRi := GetTickCount;
          end;
        end;
      end;
    end;
  end;
end;

//×Ô¶¯Ä§·¨¶Ü£¬×Ô¶¯¿¹¾Ü£¬×Ô¶¯ÒþÉí¹ý³Ì
function TfrmMain.NearActor: Boolean;
var
  boIs66: Boolean;
  i: Integer;
  pm: PTClientMagic;
begin
  Result := False;
  if (g_MySelf = nil) or (g_MySelf.m_boIsShop) or (g_MySelf.m_nState and $04000000 <> 0{Âé±Ô}) or
     (g_MySelf.m_nState and $00004000 <> 0{¶¨ÉíÐ§¹û}) or (g_MySelf.m_nState and $1000000 <> 0{±ù¶³}) then Exit;
  if g_MySelf.m_boDeath then Exit;
    // ×Ô¶¯Ä§¶Ü
  if (g_MySelf.m_btJob=1) and  ((GetTickCount-g_nAutoMagic) > 500) and g_boAutoShield and CanNextAutoMagic then begin
    if (g_MySelf.m_nState and $00100000 <> 0) or (g_MySelf.m_nState and $00040000 <> 0) then Exit;
    boIs66 := False;
    g_nAutoMagic:=GetTickCount;
    if g_MagicList.Count > 0 then //20080629
    for i:=0 to g_MagicList.Count-1 do begin
      pm := PTClientMagic (g_MagicList[i]);
      if pm <> nil then begin
        if Pm.Def.wMagicId = 66 then begin //ËÄ¼¶Ä§·¨¶Ü
          UseMagic(g_nMouseX, g_nMouseY,Pm);
          g_nAutoMagic:=GetTickCount;
          boIs66 := True;
          Break;
        end;
      end;
    end;
    if not boIs66 then begin
      if g_MagicList.Count > 0 then //20080629
      for i:=0 to g_MagicList.Count-1 do begin
        pm := PTClientMagic (g_MagicList[i]);
        if pm <> nil then begin
          if Pm.Def.wMagicId = 31 then begin //Ä§·¨¶Ü
            UseMagic(g_nMouseX, g_nMouseY,Pm);
            g_nAutoMagic:=GetTickCount;
            Break;
          end;
        end;
      end;
    end;
  end;
  //×Ô¶¯ÒþÉí
  if (g_MySelf.m_btJob = 2) and ((GetTickCount - g_nAutoMAgic) > 500)  and g_boAutoHide then begin
    if (g_MySelf.m_nState and $00800000 <> 0) then Exit;
    g_nAutoMAgic := GetTickCount;
    if g_MagicList.Count > 0 then //20080629
    for i := 0 to g_MagicList.Count - 1 do begin
      pm := PTClientMagic(g_MagicList[i]);
      if pm <> nil then begin
        if pm.Def.wMagicId = 18 then begin
          UseMagic(g_nMouseX, g_nMouseY,Pm);
          g_nAutoMAgic := GetTickCount;
          Break;
        end;
      end;
    end;
  end;
  {$IF M2Version <> 2}
  //×Ô¶¯Ê¹ÓÃÉñÁú¸½Ìå
  if ((GetTickCount - g_nAutoMAgic) > 47000) and g_boAutoDragInBody then begin
    if g_MagicList.Count > 0 then //20080629
    for i := 0 to g_MagicList.Count - 1 do begin
      pm := PTClientMagic(g_MagicList[i]);
      if pm <> nil then begin
        if pm.Def.wMagicId = 101 then begin
          UseMagic(g_nMouseX, g_nMouseY,Pm);
          g_nAutoMAgic := GetTickCount;
          Break;
        end;
      end;
    end;
  end;
  {$IFEND}
end;

procedure TfrmMain.NeiGuaConfig(body: string);
var
  sData, Lines: string;
  I{, Size}: Integer;
  Temp: TStringList;
begin
  sData := DecodeString(body);
  if sData <> '' then begin
    Temp:= TstringList.Create;
    try
      for I:= 0 to TagCount(sData, '|') do begin
        sData:=GetValidStr3(sData,Lines,['|']);
        if Lines <> '' then Temp.Add(Lines);
      end;
      //Size := 0;
      with FrmDlg do begin
        if Temp.Count > 0 then begin
          DCheckBoxUseSuperMedicaItemName10.Caption := Temp.Strings[0];
          g_Config.SuperMedicaItemNames[9] := Temp.Strings[0];
          with DScrollBoxPro do begin
            if not InSuItem(DCheckBoxUseSuperMedicaItemName10) then begin
              AddSuItem(Add, DCheckBoxUseSuperMedicaItemName10);
              AddSuItem(Add, DEditSuperMedicaHP10);
              AddSuItem(Add, DEditSuperMedicaHPTime10);
              AddSuItem(Add, DEditSuperMedicaMP10);
              AddSuItem(Add, DEditSuperMedicaMPTime10);
              DCheckBoxUseSuperMedicaItemName10.Visible := True;
              DEditSuperMedicaHP10.Visible := True;
              DEditSuperMedicaHPTime10.Visible := True;
              DEditSuperMedicaMP10.Visible := True;
              DEditSuperMedicaMPTime10.Visible := True;
              //Size := 25;
            end;
          end;
        end;
        if Temp.Count > 1 then begin
          DCheckBoxUseSuperMedicaItemName11.Caption := Temp.Strings[1];
          g_Config.SuperMedicaItemNames[10] := Temp.Strings[1];
          with DScrollBoxPro do begin
            if not InSuItem(DCheckBoxUseSuperMedicaItemName11) then begin
              AddSuItem(Add, DCheckBoxUseSuperMedicaItemName11);
              AddSuItem(Add, DEditSuperMedicaHP11);
              AddSuItem(Add, DEditSuperMedicaHPTime11);
              AddSuItem(Add, DEditSuperMedicaMP11);
              AddSuItem(Add, DEditSuperMedicaMPTime11);
              DCheckBoxUseSuperMedicaItemName11.Visible := True;
              DEditSuperMedicaHP11.Visible := True;
              DEditSuperMedicaHPTime11.Visible := True;
              DEditSuperMedicaMP11.Visible := True;
              DEditSuperMedicaMPTime11.Visible := True;
              //Size := 50;
            end;
          end;
        end;
        if Temp.Count > 2 then begin
          DCheckBoxUseSuperMedicaItemName12.Caption := Temp.Strings[2];
          g_Config.SuperMedicaItemNames[11] := Temp.Strings[2];
          with DScrollBoxPro do begin
            if not InSuItem(DCheckBoxUseSuperMedicaItemName12) then begin
              AddSuItem(Add, DCheckBoxUseSuperMedicaItemName12);
              AddSuItem(Add, DEditSuperMedicaHP12);
              AddSuItem(Add, DEditSuperMedicaHPTime12);
              AddSuItem(Add, DEditSuperMedicaMP12);
              AddSuItem(Add, DEditSuperMedicaMPTime12);
              DCheckBoxUseSuperMedicaItemName12.Visible := True;
              DEditSuperMedicaHP12.Visible := True;
              DEditSuperMedicaHPTime12.Visible := True;
              DEditSuperMedicaMP12.Visible := True;
              DEditSuperMedicaMPTime12.Visible := True;
              //Size := 75;
            end;
          end;
        end;
        if Temp.Count > 3 then begin
          DCheckBoxUseSuperMedicaItemName13.Caption := Temp.Strings[3];
          g_Config.SuperMedicaItemNames[12] := Temp.Strings[3];
          with DScrollBoxPro do begin
            if not InSuItem(DCheckBoxUseSuperMedicaItemName13) then begin
              AddSuItem(Add, DCheckBoxUseSuperMedicaItemName13);
              AddSuItem(Add, DEditSuperMedicaHP13);
              AddSuItem(Add, DEditSuperMedicaHPTime13);
              AddSuItem(Add, DEditSuperMedicaMP13);
              AddSuItem(Add, DEditSuperMedicaMPTime13);
              DCheckBoxUseSuperMedicaItemName13.Visible := True;
              DEditSuperMedicaHP13.Visible := True;
              DEditSuperMedicaHPTime13.Visible := True;
              DEditSuperMedicaMP13.Visible := True;
              DEditSuperMedicaMPTime13.Visible := True;
              //Size := 100;
            end;
          end;
        end;
        if Temp.Count > 4 then begin
          DCheckBoxUseSuperMedicaItemName14.Caption := Temp.Strings[4];
          g_Config.SuperMedicaItemNames[13] := Temp.Strings[4];
          with DScrollBoxPro do begin
            if not InSuItem(DCheckBoxUseSuperMedicaItemName14) then begin
              AddSuItem(Add, DCheckBoxUseSuperMedicaItemName14);
              AddSuItem(Add, DEditSuperMedicaHP14);
              AddSuItem(Add, DEditSuperMedicaHPTime14);
              AddSuItem(Add, DEditSuperMedicaMP14);
              AddSuItem(Add, DEditSuperMedicaMPTime14);
              DCheckBoxUseSuperMedicaItemName14.Visible := True;
              DEditSuperMedicaHP14.Visible := True;
              DEditSuperMedicaHPTime14.Visible := True;
              DEditSuperMedicaMP14.Visible := True;
              DEditSuperMedicaMPTime14.Visible := True;
              //Size := 125;
            end;
          end;
        end;
        {if Size > 0 then begin
          DScrollBarPro.MaxValue := DScrollBarPro.MaxValue + Size;
        end;  }
      end;
    finally
      Temp.Free;
    end;
  end;

end;

function TfrmMain.EatAutoOpenItem(idx: Integer): Boolean;
begin
  Result := False;
  if (idx in [0..MAXBAGITEMCL-1]) and (g_WaitingUseItem.Item.S.Name = '') then begin
    if (g_EatingItem.S.Name <> '') and (GetTickCount - g_dwEatTime > 5 * 1000) then begin
      g_EatingItem.S.Name := '';
    end;
    if (g_EatingItem.S.Name = '') then begin
      if (g_ItemArr[idx].Item.S.Name <> '') and (g_ItemArr[idx].Item.S.StdMode = 31) then begin
        g_dwEatTime := GetTickCount;
        g_EatingItem := g_ItemArr[idx].Item;
        g_ItemArr[idx].Item.S.Name := '';
        SendEat(g_EatingItem.MakeIndex, g_EatingItem.S.Name, g_EatingItem.S.StdMode);
        Result := True;
      end;
    end;
  end;
end;

{$IF M2Version <> 2}
function TfrmMain.EatAutoHeroOpenItem(idx: Integer): Boolean;
begin
  Result := False;
  if (idx in [0..g_HeroBagCount-1]) and (g_WaitingHeroUseItem.Item.S.Name = '') then begin
    if (g_HeroEatingItem.S.Name <> '') and (GetTickCount - g_dwHeroEatTime > 5 * 1000) then begin
      g_HeroEatingItem.S.Name := '';
    end;
    if (g_HeroEatingItem.S.Name = '') then begin
      if (g_HeroItemArr[idx].S.Name <> '') and (g_HeroItemArr[idx].S.StdMode = 31) then begin
        g_dwHeroEatTime := GetTickCount;
        g_HeroEatingItem := g_HeroItemArr[idx];
        g_HeroItemArr[idx].S.Name := '';
        SendHeroEat(g_HeroEatingItem.MakeIndex, g_HeroEatingItem.S.Name, g_HeroEatingItem.S.StdMode);
        Result := True;
      end;
    end;
  end;
end;
{$IFEND}

procedure TfrmMain.AutoEatItem;
var
  I, nIndex: Integer;
  bo, bo1: boolean;
  sItemName: string;
begin
  if g_MySelf = nil then Exit;
  if g_MySelf.m_boDeath then Exit;
  //×Ô¶¯Ê¹ÓÃÎïÆ·
  if g_Config.boUseSuperMedica then begin
    //HP
    for I:=High(g_Config.SuperMedicaItemNames) downto Low(g_Config.SuperMedicaItemNames) do begin
      sItemName := '';
      if g_Config.SuperMedicaUses[I] and (g_Config.SuperMedicaHps[I] > 0)  and ((g_MySelf.m_Abil.MaxHP - g_MySelf.m_Abil.HP) >= g_Config.SuperMedicaHps[I]) and (GetTickCount - g_Config.SuperMedicaHpTicks[I] > Max(g_Config.SuperMedicaHpTimes[I], 1000)) then begin
        sItemName := g_Config.SuperMedicaItemNames[I];
        if sItemName <> '' then begin
          nIndex := FindItemArrItemName(sItemName);
          if nIndex >= 0 then begin
            g_BeltIdx := 0;
            EatItem(nIndex);
            g_Config.SuperMedicaHpTicks[I] := GetTickCount;
            Break;
          end else begin
            nIndex := FindItemArrBindItemName(sItemName);
            if nIndex >= 0 then begin
              if EatAutoOpenItem(nIndex) then begin
                g_Config.SuperMedicaHpTicks[I] := GetTickCount;
                Break;
              end;
            end;
          end;
        end;
      end;
    end;
    //MP
    for I:=High(g_Config.SuperMedicaItemNames) downto Low(g_Config.SuperMedicaItemNames) do begin
      sItemName := '';
      if g_Config.SuperMedicaUses[I] and (g_Config.SuperMedicaMPs[I] > 0) and ((g_MySelf.m_Abil.MaxMP - g_MySelf.m_Abil.MP) >= g_Config.SuperMedicaMPs[I]) and (GetTickCount - g_Config.SuperMedicaMPTicks[I] > Max(g_Config.SuperMedicaMPTimes[I], 1000)) then begin
        sItemName := g_Config.SuperMedicaItemNames[I];
        if sItemName <> '' then begin
          nIndex := FindItemArrItemName(sItemName);
          if nIndex >= 0 then begin
            g_BeltIdx := 0;
            EatItem(nIndex);
            g_Config.SuperMedicaMPTicks[I] := GetTickCount;
            Break;
          end else begin
            nIndex := FindItemArrBindItemName(sItemName);
            if nIndex >= 0 then begin
              if EatAutoOpenItem(nIndex) then begin
                g_Config.SuperMedicaMPTicks[I] := GetTickCount;
                Break;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
  //±£»¤
  if g_Config.boHp1Chk and not g_ClientConf.boNoUseProtection and (g_Config.wHp1Hp > 0) and (g_MySelf.m_Abil.HP < g_Config.wHp1Hp) then begin
    if FrmDlg.DCBBookHPMan.Items[g_Config.btHp1Man] = 'Ð¡ÍË' then begin
      g_Config.boHp1Chk := False;
      frmDlg.DCheckBoxBookHPPro.Checked := False;
      AppLogOut(False);
      Exit;
    end else begin
      nIndex := FindItemArrItemName(FrmDlg.DCBBookHPMan.Items[g_Config.btHp1Man]);
      if nIndex >= 0 then begin
        g_BeltIdx := 0;
        EatItem(nIndex);
        g_Config.boHp1Chk := False;
        frmDlg.DCheckBoxBookHPPro.Checked := False;
      end else begin
        g_Config.boHp1Chk := False;
        frmDlg.DCheckBoxBookHPPro.Checked := False;
        DScreen.AddChatBoardString('ÄúµÄ'+FrmDlg.DCBBookHPMan.Items[g_Config.btHp1Man]+'ÒÑ¾­ÓÃ¾¡¡£',ClWhite, clBlue);
      end;
    end;
  end;
  if g_Config.boMP1Chk and not g_ClientConf.boNoUseProtection and (g_Config.wMP1MP > 0) and (g_MySelf.m_Abil.MP < g_Config.wMP1MP) then begin
    if FrmDlg.DCBBookMPMan.Items[g_Config.btMP1Man] = 'Ð¡ÍË' then begin
      g_Config.boMP1Chk := False;
      frmDlg.DCheckBoxBookMPPro.Checked := False;
      AppLogOut(False);
      Exit;
    end else begin
      nIndex := FindItemArrItemName(FrmDlg.DCBBookMPMan.Items[g_Config.btMP1Man]);
      if nIndex >= 0 then begin
        g_BeltIdx := 0;
        EatItem(nIndex);
        g_Config.boMP1Chk := False;
        frmDlg.DCheckBoxBookMPPro.Checked := False;
      end else begin
        g_Config.boMP1Chk := False;
        frmDlg.DCheckBoxBookMPPro.Checked := False;
        DScreen.AddChatBoardString('ÄúµÄ'+FrmDlg.DCBBookMPMan.Items[g_Config.btMP1Man]+'ÒÑ¾­ÓÃ¾¡¡£',ClWhite, clBlue);
      end;
    end;
  end;
  //ÆÕÍ¨HP±£»¤
  if g_Config.boRenewHPIsAuto and (g_Config.wRenewHPPercent > 0) and (g_MySelf.m_Abil.HP < g_Config.wRenewHPPercent) and ((GetTickCount - g_Config.wRenewHPTick) > Max(g_Config.wRenewHPTime, 1000)) then begin
    nIndex := FindItemArrItemName(1, False);
    if nIndex >= 0 then begin
      g_BeltIdx := 0;
      EatItem (nIndex);
      g_Config.wRenewHPTick := GetTickCount();
    end else begin
      nIndex := FindItemArrBindItemName(1, False);
      if nIndex >= 0 then begin
        if BagItemCount <= 41 then begin
          EatAutoOpenItem (nIndex);
          g_Config.wRenewHPTick := GetTickCount();
        {end else begin
          g_Config.wRenewHPTick := GetTickCount();
          DScreen.AddChatBoardString('°ü¹üÒÑÂú£¬ÎÞ·¨²ð°ü¡£',ClWhite, clBlue);
          DScreen.AddChatBoardString('ÄúµÄ½ð´´Ò©ÒÑÊ¹ÓÃÍê',ClWhite, clBlue);  }
        end;
      {end else begin
        g_Config.wRenewHPTick := GetTickCount();
        DScreen.AddChatBoardString('ÄúµÄ½ð´´Ò©ÒÑ¾­ÓÃ¾¡¡£',ClWhite, clBlue);   }
      end;
    end;
  end;
  //ÆÕÍ¨MP±£»¤
  if g_Config.boRenewMPIsAuto and (g_Config.wRenewMPPercent > 0) and (g_MySelf.m_Abil.MP < g_Config.wRenewMPPercent) and ((GetTickCount - g_Config.wRenewMPTick) > Max(g_Config.wRenewMPTime, 1000)) then begin
    nIndex := FindItemArrItemName(2, False);
    if nIndex >= 0 then begin
      g_BeltIdx := 0;
      EatItem (nIndex);
      g_Config.wRenewMPTick := GetTickCount();
    end else begin
      nIndex := FindItemArrBindItemName(2, False);
      if nIndex >= 0 then begin
        if BagItemCount <= 41 then begin
          EatAutoOpenItem (nIndex);
          g_Config.wRenewMPTick := GetTickCount();
        {end else begin
          g_Config.wRenewMPTick := GetTickCount();
          DScreen.AddChatBoardString('°ü¹üÒÑÂú£¬ÎÞ·¨²ð°ü¡£',ClWhite, clBlue);
          DScreen.AddChatBoardString('ÄúµÄÄ§·¨Ò©ÒÑÊ¹ÓÃÍê',ClWhite, clBlue);    }
        end;
      {end else begin
        g_Config.wRenewMPTick := GetTickCount();
        DScreen.AddChatBoardString('ÄúµÄÄ§·¨Ò©ÒÑ¾­ÓÃ¾¡¡£',ClWhite, clBlue);  }
      end;
    end;
  end;
  //ÌØÐ§HP±£»¤
  if g_Config.boRenewSpecialHPIsAuto and (g_Config.wRenewSpecialHPPercent > 0) and (g_MySelf.m_Abil.HP < g_Config.wRenewSpecialHPPercent) and ((GetTickCount - g_Config.wRenewSpecialHPTick) > Max(g_Config.wRenewSpecialHPTime, 1000)) then begin
    nIndex := FindItemArrItemName(1, True);
    if nIndex >= 0 then begin
      g_BeltIdx := 0;
      EatItem (nIndex);
      g_Config.wRenewSpecialHPTick := GetTickCount();
    end else begin
      nIndex := FindItemArrBindItemName(1, True);
      if nIndex >= 0 then begin
        if BagItemCount <= 41 then begin
          EatAutoOpenItem (nIndex);
          g_Config.wRenewSpecialHPTick := GetTickCount();
        {end else begin
          g_Config.wRenewSpecialHPTick := GetTickCount();
          DScreen.AddChatBoardString('°ü¹üÒÑÂú£¬ÎÞ·¨²ð°ü¡£',ClWhite, clBlue);
          DScreen.AddChatBoardString('ÄúµÄÌØÐ§½ð´´Ò©ÒÑÊ¹ÓÃÍê',ClWhite, clBlue);   }
        end;
      {end else begin
        g_Config.wRenewSpecialHPTick := GetTickCount();
        DScreen.AddChatBoardString('ÄúµÄÌØÐ§½ð´´Ò©ÒÑ¾­ÓÃ¾¡¡£',ClWhite, clBlue);    }
      end;
    end;
  end;
  //ÌØÐ§MP±£»¤
  if g_Config.boRenewSpecialMPIsAuto and (g_Config.wRenewSpecialMPPercent > 0) and (g_MySelf.m_Abil.MP < g_Config.wRenewSpecialMPPercent) and ((GetTickCount - g_Config.wRenewSpecialMPTick) > Max(g_Config.wRenewSpecialMPTime, 1000)) then begin
    nIndex := FindItemArrItemName(2, True);
    if nIndex >= 0 then begin
      g_BeltIdx := 0;
      EatItem (nIndex);
      g_Config.wRenewSpecialMPTick := GetTickCount();
    end else begin
      nIndex := FindItemArrBindItemName(2, True);
      if nIndex >= 0 then begin
        if BagItemCount <= 41 then begin
          EatAutoOpenItem (nIndex);
          g_Config.wRenewSpecialMPTick := GetTickCount();
        {end else begin
          g_Config.wRenewSpecialMPTick := GetTickCount();
          DScreen.AddChatBoardString('°ü¹üÒÑÂú£¬ÎÞ·¨²ð°ü¡£',ClWhite, clBlue);
          DScreen.AddChatBoardString('ÄúµÄÌØÐ§Ä§·¨Ò©ÒÑÊ¹ÓÃÍê',ClWhite, clBlue);  }
        end;
      {end else begin
        g_Config.wRenewSpecialMPTick := GetTickCount();
        DScreen.AddChatBoardString('ÄúµÄÌØÐ§Ä§·¨Ò©ÒÑ¾­ÓÃ¾¡¡£',ClWhite, clBlue); }
      end;
    end;
  end;


  
  {//ÆÕÍ¨hp±£»¤
  if g_boCommonHp and (g_MySelf.m_Abil.HP < g_nEditCommonHp) and ((GetTickCount - g_dwCommonHpTick) > g_nEditCommonHpTimer * 1000) then begin
    g_dwCommonHpTick := GetTickCount;
    bo:=False;
    for i := 0 to MAXBAGITEMCL - 1 do begin
      if (g_ItemArr[i].Item.s.StdMode = 0) and (g_ItemArr[i].Item.s.Shape = 0) and (g_ItemArr[i].Item.s.AC <> 0) and (g_ItemArr[i].Item.s.Name <> '') then begin
        g_BeltIdx := 0;
        EatItem (i);
        bo:=True;
        Break;
      end;
    end;

    if not bo then begin
      bo1 := False;
      for i := 0 to MAXBAGITEMCL - 1 do begin
        if (g_ItemArr[i].Item.s.StdMode = 0) and (g_ItemArr[i].Item.s.Shape = 0) and (g_ItemArr[i].Item.s.AC <> 0) and (g_ItemArr[i].Item.s.Name <> '') then begin
          g_boItemMoving := TRUE;
          g_MovingItem.Index := I;
          g_MovingItem.Item := g_ItemArr[I].Item;
          g_ItemArr[I].Item.S.Name := '';
          ItemClickSound (g_ItemArr[I].Item.S);
          g_BeltIdx := 0;
          EatItem (-1);
          bo1:=True;
          break;
        end;
      end;
      if not bo1 then
      DScreen.AddChatBoardString('ÌáÊ¾:ÄúµÄ['+'½ð´´Ò©'+']Ã»ÁË,Çë¼°Ê±²¹³ä!',ClRed, ClWhite);
    end;
  end;
  //ÆÕÍ¨MP±£»¤
  if g_boCommonMp and (g_MySelf.m_Abil.MP < g_nEditCommonMp) and ((GetTickCount - g_dwCommonMpTick) > g_nEditCommonMpTimer * 1000) then begin
    g_dwCommonMpTick := GetTickCount;
    bo:=False;
    for i := 0 to MAXBAGITEMCL - 1 do begin
      if (g_ItemArr[i].Item.s.StdMode = 0) and (g_ItemArr[i].Item.s.Shape = 0) and (g_ItemArr[i].Item.s.MAC <> 0) and (g_ItemArr[i].Item.s.Name <> '') then begin
        g_BeltIdx := 0;
        EatItem (i);
        bo:=True;
        Break;
      end;
    end;
    if not bo then begin
      bo1 := False;
      for i := 0 to MAXBAGITEMCL - 1 do begin
        if (g_ItemArr[i].Item.s.StdMode = 0) and (g_ItemArr[i].Item.s.Shape = 0) and (g_ItemArr[i].Item.s.MAC <> 0) and (g_ItemArr[i].Item.s.Name <> '') then begin
          g_boItemMoving := TRUE;
          g_MovingItem.Index := I;
          g_MovingItem.Item := g_ItemArr[I].Item;
          g_ItemArr[I].Item.S.Name := '';
          ItemClickSound (g_ItemArr[I].Item.S);
          g_BeltIdx := 0;
          EatItem (-1);
          bo1:=True;
          break;
        end;
      end;
      if not bo1 then
      DScreen.AddChatBoardString('ÌáÊ¾:ÄúµÄ['+'Ä§·¨Ò©'+']Ã»ÁË,Çë¼°Ê±²¹³ä!',ClRed, ClWhite);
    end;
  end;
  //ÌØÊâHP±£»¤
  if g_boSpecialHp and (g_MySelf.m_Abil.HP < g_nEditSpecialHp) and ((GetTickCount - g_dwSpecialHpTick) > g_nEditSpecialHpTimer * 1000) then begin
    g_dwSpecialHpTick := GetTickCount;
    bo:=False;
    for i := 0 to MAXBAGITEMCL - 1 do begin
      if (g_ItemArr[i].Item.s.StdMode = 0) and (g_ItemArr[i].Item.s.Shape = 1) and (g_ItemArr[i].Item.s.Name <> '') then begin
        g_BeltIdx := 0;
        EatItem (i);
        bo:=True;
        Break;
      end;
    end;
    if not bo then begin
      bo1 := False;
      for i := 0 to MAXBAGITEMCL - 1 do begin
        if (g_ItemArr[i].Item.s.StdMode = 0) and (g_ItemArr[i].Item.s.Shape = 1) and (g_ItemArr[i].Item.s.Name <> '') then begin
          g_boItemMoving := TRUE;
          g_MovingItem.Index := I;
          g_MovingItem.Item := g_ItemArr[I].Item;
          g_ItemArr[I].Item.S.Name := '';
          ItemClickSound (g_ItemArr[I].Item.S);
          g_BeltIdx := 0;
          EatItem (-1);
          bo1:=True;
          break;
        end;
      end;
      if not bo1 then
      DScreen.AddChatBoardString('ÌáÊ¾:ÄúµÄ['+'ÌØÊâÒ©Æ·'+']Ã»ÁË,Çë¼°Ê±²¹³ä!',ClRed, ClWhite);
    end;
  end;
  //Ëæ»úHP±£»¤
  if g_boRandomHp and (g_MySelf.m_Abil.HP < g_nEditRandomHp) and ((GetTickCount - g_dwRandomHpTick) > g_nEditRandomHpTimer * 1000) then begin
    g_dwRandomHpTick := GetTickCount;
    bo:=False;
    for i := 0 to MAXBAGITEMCL - 1 do begin
      if g_ItemArr[i].Item.s.Name = FrmDlg.DComSdoRandomName.Text then begin
        EatItem (i);
        bo:=True;
        break;
      end;
    end;
    if not bo then DScreen.AddChatBoardString('ÌáÊ¾:ÄúµÄ['+FrmDlg.DComSdoRandomName.Text+']Ã»ÁË,Çë¼°Ê±²¹³ä!',ClRed, ClWhite);
  end;    }
  //ÈËÎï×Ô¶¯ºÈÆÕÍ¨¾Æ
  if g_boAutoEatWine and ((100 * g_MySelf.m_Abil.WineDrinkValue div g_MySelf.m_Abil.MaxAlcohol) <= g_btEditWine) and ((GetTickCount - g_dwAutoEatWineTick) > 5000) then begin
    g_dwAutoEatWineTick := GetTickCount;
    bo:=False;
    for i := 0 to MAXBAGITEMCL - 1 do begin
      if (g_ItemArr[i].Item.s.StdMode = 60) and (g_ItemArr[i].Item.s.AniCount = 1) and (g_ItemArr[I].Item.s.Name <> '') then begin
        EatItem (i);
        bo:=True;
        break;
      end;
    end;
    if not bo then DScreen.AddChatBoardString('ÌáÊ¾:ÄúµÄ[ÆÕÍ¨¾Æ]Ã»ÁË,Çë¼°Ê±²¹³ä!',ClRed, ClWhite);
  end;
  //Ó¢ÐÛ×Ô¶¯ºÈÆÕÍ¨¾Æ
  if g_HeroSelf <> nil then begin
    if (g_HeroSelf.m_Abil.MaxAlcohol > 0) and (g_HeroSelf.m_Abil.WineDrinkValue >= 0) then begin
      if g_boAutoEatHeroWine and ((100 * g_HeroSelf.m_Abil.WineDrinkValue div g_HeroSelf.m_Abil.MaxAlcohol) <= g_btEditHeroWine) and ((GetTickCount - g_dwAutoEatHeroWineTick) > 5000) then begin
        g_dwAutoEatHeroWineTick := GetTickCount;
        bo:=False;
        for i:=0 to g_HeroBagCount - 1 do begin
          if (g_HeroItemArr[I].s.StdMode = 60) and (g_HeroItemArr[I].s.AniCount = 1) and (g_HeroItemArr[I].s.Name <> '') then begin
            HeroEatItem(I);
            bo:=True;
            Break;
          end;
        end;
        if not bo then DScreen.AddChatBoardString('ÌáÊ¾:ÄãÓ¢ÐÛµÄ[ÆÕÍ¨¾Æ]Ã»ÁË,Çë¼°Ê±²¹³ä!',clRed, clWhite);
      end;
    end;
  end;
  //ÈËÎï×Ô¶¯ºÈÒ©¾Æ
  if g_boAutoEatDrugWine and ((GetTickCount - g_dwAutoEatDrugWineTick) >= g_btEditDrugWine * 1000 * 60) then begin
    g_dwAutoEatDrugWineTick := GetTickCount;
    bo := False;
    for i := 0 to MAXBAGITEMCL - 1 do begin
      if (g_ItemArr[i].Item.s.StdMode = 60) and (g_ItemArr[i].Item.s.AniCount = 2) and (g_ItemArr[I].Item.s.Name <> '') then begin
        EatItem (i);
        bo:=True;
        break;
      end;
    end;
    if not bo then DScreen.AddChatBoardString('ÌáÊ¾:ÄúµÄ[Ò©¾Æ]Ã»ÁË,Çë¼°Ê±²¹³ä!',ClRed, ClWhite);
  end;
  //Ó¢ÐÛ×Ô¶¯ºÈÒ©¾Æ
  if g_HeroSelf <> nil then begin
    if g_boAutoEatHeroDrugWine and ((GetTickCount - g_dwAutoEatHeroDrugWineTick) >= g_btEditHeroDrugWine * 1000 * 60) then begin
      g_dwAutoEatHeroDrugWineTick := GetTickCount;
      bo:=False;
      for i:=0 to g_HeroBagCount - 1 do begin
        if (g_HeroItemArr[I].s.StdMode = 60) and (g_HeroItemArr[I].s.AniCount = 2)  and (g_HeroItemArr[I].s.Name <> '') then begin
          HeroEatItem(I);
          bo:=True;
          Break;
        end;
      end;
      if not bo then DScreen.AddChatBoardString('ÌáÊ¾:ÄãÓ¢ÐÛµÄ[ÆÕÍ¨¾Æ]Ã»ÁË,Çë¼°Ê±²¹³ä!',clRed, clWhite);
    end;
  end;
  //×Ô¶¯³Ô»ðÁúÖé
  if FrmDlg.DCheckAutoUseHuolongzhu.Checked then begin
    for I:=0 to MAXBAGITEMCL - 1 do begin
      if g_ItemArr[i].Item.s.Name = '»ðÁúÖé' then begin
        EatItem (i);
        Break;
      end;
    end;
  end;
  //×Ô¶¯³Ô¾«Ôªµ¤
  if FrmDlg.DCheckAutoUseJingyuandan.Checked then begin
    for I:=0 to MAXBAGITEMCL - 1 do begin
      if g_ItemArr[i].Item.s.Name = '¾«Ôªµ¤' then begin
        EatItem (i);
        Break;
      end;
    end;
  end;
end;

procedure TfrmMain.AutoHeroEatItem;
var
  I, nIndex: Integer;
  sItemName: string;
  msg: TDefaultMessage;
begin
  {$IF M2Version <> 2}
  if g_HeroSelf = nil then Exit;
  if g_HeroSelf.m_boDeath then Exit;
  if (g_sMyHeroType = '°×') or (g_sMyHeroType = 'ÎÔ') or (g_sMyHeroType = 'Ö÷') then begin
    //×Ô¶¯Ê¹ÓÃÎïÆ·
    if g_Config.hBoUseSuperMedica then begin
      //HP
      for I:=High(g_Config.SuperMedicaItemNames) downto Low(g_Config.SuperMedicaItemNames) do begin
        sItemName := '';
        if g_Config.hSuperMedicaUses[I] and (g_Config.hSuperMedicaHps[I] > 0) and ((g_HeroSelf.m_Abil.MaxHP - g_HeroSelf.m_Abil.HP) >= g_Config.hSuperMedicaHps[I]) and (GetTickCount - g_Config.hSuperMedicaHpTicks[I] > Max(g_Config.hSuperMedicaHpTimes[I], 1000)) then begin
          sItemName := g_Config.SuperMedicaItemNames[I];
          if sItemName <> '' then begin
            nIndex := FindHeroItemArrItemName(sItemName);
            if nIndex >= 0 then begin
              HeroEatItem(nIndex);
              g_Config.hSuperMedicaHpTicks[I] := GetTickCount;
              Break;
            end else begin
              nIndex := FindHeroItemArrBindItemName(sItemName);
              if nIndex >= 0 then begin
                if EatAutoHeroOpenItem(nIndex) then begin
                  g_Config.hSuperMedicaHpTicks[I] := GetTickCount;
                  Break;
                end;
              end;
            end;
          end;
        end;
      end;
      //MP
      for I:=High(g_Config.SuperMedicaItemNames) downto Low(g_Config.SuperMedicaItemNames) do begin
        sItemName := '';
        if g_Config.hSuperMedicaUses[I] and (g_Config.hSuperMedicaMPs[I] > 0) and ((g_HeroSelf.m_Abil.MaxMP - g_HeroSelf.m_Abil.MP) >= g_Config.hSuperMedicaMPs[I]) and (GetTickCount - g_Config.hSuperMedicaMPTicks[I] > Max(g_Config.hSuperMedicaMPTimes[I], 1000)) then begin
          sItemName := g_Config.SuperMedicaItemNames[I];
          if sItemName <> '' then begin
            nIndex := FindHeroItemArrItemName(sItemName);
            if nIndex >= 0 then begin
              HeroEatItem(nIndex);
              g_Config.hSuperMedicaMPTicks[I] := GetTickCount;
              Break;
            end else begin
              nIndex := FindHeroItemArrBindItemName(sItemName);
              if nIndex >= 0 then begin
                if EatAutoHeroOpenItem(nIndex) then begin
                  g_Config.hSuperMedicaMPTicks[I] := GetTickCount;
                  Break;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
    //±£»¤
    if g_Config.boHp2Chk and not g_ClientConf.boNoUseHeroProtection and (g_Config.wHp2Hp > 0) and (g_HeroSelf.m_Abil.HP < g_Config.wHp2Hp) then begin
      if GetTickCount - g_CallHeroTick > 5000 then begin
        g_CallHeroTick := GetTickCount();
        msg := MakeDefaultMsg (aa(CM_HEROLOGOUT, frmMain.TempCertification), 0, 0, 0, 0, frmMain.m_nSendMsgCount); //Ó¢ÐÛÍË³ö
        FrmMain.SendSocket (EncodeMessage (msg));
      end;
    end;
    if g_Config.boMP2Chk and not g_ClientConf.boNoUseHeroProtection and (g_Config.wMP2MP > 0) and (g_HeroSelf.m_Abil.MP < g_Config.wMP2MP) then begin
      if GetTickCount - g_CallHeroTick > 5000 then begin
        g_CallHeroTick := GetTickCount();
        msg := MakeDefaultMsg (aa(CM_HEROLOGOUT, frmMain.TempCertification), 0, 0, 0, 0, frmMain.m_nSendMsgCount); //Ó¢ÐÛÍË³ö
        FrmMain.SendSocket (EncodeMessage (msg));
      end;
    end;
    //ÆÕÍ¨HP±£»¤
    if g_Config.boRenewHeroNormalHpIsAuto and (g_Config.wRenewHeroNormalHpPercent > 0) and (g_HeroSelf.m_Abil.HP < g_Config.wRenewHeroNormalHpPercent) and ((GetTickCount - g_Config.wRenewHeroNormalHpTick) > Max(g_Config.wRenewHeroNormalHpTime, 1000)) then begin
      nIndex := FindHeroItemArrItemName(1, False);
      if nIndex >= 0 then begin
        HeroEatItem (nIndex);
        g_Config.wRenewHeroNormalHpTick := GetTickCount();
      end else begin
        nIndex := FindHeroItemArrBindItemName(1, False);
        if nIndex >= 0 then begin
          if HeroBagItemCount <= g_HeroBagCount-5 then begin
            EatAutoHeroOpenItem (nIndex);
            g_Config.wRenewHeroNormalHpTick := GetTickCount();
          {end else begin
            g_Config.wRenewHeroNormalHpTick := GetTickCount();
            DScreen.AddChatBoardString('(Ó¢ÐÛ)°ü¹üÒÑÂú£¬ÎÞ·¨²ð°ü¡£',ClWhite, clBlue);
            DScreen.AddChatBoardString('(Ó¢ÐÛ)µÄ½ð´´Ò©ÒÑÊ¹ÓÃÍê',ClWhite, clBlue); }
          end;  
        {end else begin
          g_Config.wRenewHeroNormalHpTick := GetTickCount();
          DScreen.AddChatBoardString('(Ó¢ÐÛ)µÄ½ð´´Ò©ÒÑ¾­ÓÃ¾¡¡£',ClWhite, clBlue);   }
        end;
      end;
    end;
    //ÆÕÍ¨MP±£»¤
    if g_Config.boRenewHeroNormalMpIsAuto and (g_Config.wRenewHeroNormalMpPercent > 0) and (g_HeroSelf.m_Abil.MP < g_Config.wRenewHeroNormalMpPercent) and ((GetTickCount - g_Config.wRenewHeroNormalMpTick) > Max(g_Config.wRenewHeroNormalMpTime, 1000)) then begin
      nIndex := FindHeroItemArrItemName(2, False);
      if nIndex >= 0 then begin
        HeroEatItem (nIndex);
        g_Config.wRenewHeroNormalMpTick := GetTickCount();
      end else begin
        nIndex := FindHeroItemArrBindItemName(2, False);
        if nIndex >= 0 then begin
          if HeroBagItemCount <= g_HeroBagCount-5 then begin
            EatAutoHeroOpenItem (nIndex);
            g_Config.wRenewHeroNormalMpTick := GetTickCount();
          {end else begin
            g_Config.wRenewHeroNormalMpTick := GetTickCount();
            DScreen.AddChatBoardString('(Ó¢ÐÛ)°ü¹üÒÑÂú£¬ÎÞ·¨²ð°ü¡£',ClWhite, clBlue);
            DScreen.AddChatBoardString('(Ó¢ÐÛ)µÄÄ§·¨Ò©ÒÑÊ¹ÓÃÍê',ClWhite, clBlue);  }
          end;
        {end else begin
          g_Config.wRenewHeroNormalMpTick := GetTickCount();
          DScreen.AddChatBoardString('(Ó¢ÐÛ)µÄÄ§·¨Ò©ÒÑ¾­ÓÃ¾¡¡£',ClWhite, clBlue);   }
        end;
      end;
    end;
    //ÌØÐ§HP±£»¤
    if g_Config.boRenewSpecialHeroNormalHpIsAuto and (g_Config.wRenewSpecialHeroNormalHpPercent > 0) and (g_HeroSelf.m_Abil.HP < g_Config.wRenewSpecialHeroNormalHpPercent) and ((GetTickCount - g_Config.wRenewSpecialHeroNormalHpTick) > Max(g_Config.wRenewSpecialHeroNormalHpTime, 1000)) then begin
      nIndex := FindHeroItemArrItemName(1, True);
      if nIndex >= 0 then begin
        HeroEatItem (nIndex);
        g_Config.wRenewSpecialHeroNormalHpTick := GetTickCount();
      end else begin
        nIndex := FindHeroItemArrBindItemName(1, True);
        if nIndex >= 0 then begin
          if HeroBagItemCount <= g_HeroBagCount-5 then begin
            EatAutoHeroOpenItem (nIndex);
            g_Config.wRenewSpecialHeroNormalHpTick := GetTickCount();
          {end else begin
            g_Config.wRenewSpecialHeroNormalHpTick := GetTickCount();
            DScreen.AddChatBoardString('°ü(Ó¢ÐÛ)¹üÒÑÂú£¬ÎÞ·¨²ð°ü¡£',ClWhite, clBlue);
            DScreen.AddChatBoardString('(Ó¢ÐÛ)µÄÌØÐ§½ð´´Ò©ÒÑÊ¹ÓÃÍê',ClWhite, clBlue);}
          end;
        {end else begin
          g_Config.wRenewSpecialHeroNormalHpTick := GetTickCount();
          DScreen.AddChatBoardString('(Ó¢ÐÛ)µÄÌØÐ§½ð´´Ò©ÒÑ¾­ÓÃ¾¡¡£',ClWhite, clBlue);  }
        end;
      end;
    end;
    //ÌØÐ§MP±£»¤
    if g_Config.boRenewSpecialHeroNormalMpIsAuto and (g_Config.wRenewSpecialHeroNormalMpPercent > 0) and (g_HeroSelf.m_Abil.MP < g_Config.wRenewSpecialHeroNormalMpPercent) and ((GetTickCount - g_Config.wRenewSpecialHeroNormalMpTick) > Max(g_Config.wRenewSpecialHeroNormalMpTime, 1000)) then begin
      nIndex := FindHeroItemArrItemName(2, True);
      if nIndex >= 0 then begin
        HeroEatItem (nIndex);
        g_Config.wRenewSpecialHeroNormalMpTick := GetTickCount();
      end else begin
        nIndex := FindHeroItemArrBindItemName(2, True);
        if nIndex >= 0 then begin
          if HeroBagItemCount <= g_HeroBagCount-5 then begin
            EatAutoHeroOpenItem (nIndex);
            g_Config.wRenewSpecialHeroNormalMpTick := GetTickCount();
          {end else begin
            g_Config.wRenewSpecialHeroNormalMpTick := GetTickCount();
            DScreen.AddChatBoardString('(Ó¢ÐÛ)°ü¹üÒÑÂú£¬ÎÞ·¨²ð°ü¡£',ClWhite, clBlue);
            DScreen.AddChatBoardString('(Ó¢ÐÛ)µÄÌØÐ§Ä§·¨Ò©ÒÑÊ¹ÓÃÍê',ClWhite, clBlue);  }
          end;
        {end else begin
          g_Config.wRenewSpecialHeroNormalMpTick := GetTickCount();
          DScreen.AddChatBoardString('(Ó¢ÐÛ)µÄÌØÐ§Ä§·¨Ò©ÒÑ¾­ÓÃ¾¡¡£',ClWhite, clBlue);   }
        end;
      end;
    end;
  end else begin //¸±½«
    case g_HeroSelf.m_btJob of
      0: begin
        //×Ô¶¯Ê¹ÓÃÎïÆ·
        if g_Config.zBoUseSuperMedica then begin
          //HP
          for I:=High(g_Config.SuperMedicaItemNames) downto Low(g_Config.SuperMedicaItemNames) do begin
            sItemName := '';
            if g_Config.zSuperMedicaUses[I] and (g_Config.zSuperMedicaHps[I] > 0) and ((g_HeroSelf.m_Abil.MaxHP - g_HeroSelf.m_Abil.HP) >= g_Config.zSuperMedicaHps[I]) and (GetTickCount - g_Config.zSuperMedicaHpTicks[I] > Max(g_Config.zSuperMedicaHpTimes[I], 1000)) then begin
              sItemName := g_Config.SuperMedicaItemNames[I];
              if sItemName <> '' then begin
                nIndex := FindHeroItemArrItemName(sItemName);
                if nIndex >= 0 then begin
                  HeroEatItem(nIndex);
                  g_Config.zSuperMedicaHpTicks[I] := GetTickCount;
                  Break;
                end else begin
                  nIndex := FindHeroItemArrBindItemName(sItemName);
                  if nIndex >= 0 then begin
                    if EatAutoHeroOpenItem(nIndex) then begin
                      g_Config.zSuperMedicaHpTicks[I] := GetTickCount;
                      Break;
                    end;
                  end;
                end;
              end;
            end;
          end;
          //MP
          for I:=High(g_Config.SuperMedicaItemNames) downto Low(g_Config.SuperMedicaItemNames) do begin
            sItemName := '';
            if g_Config.zSuperMedicaUses[I] and (g_Config.zSuperMedicaMPs[I] > 0) and ((g_HeroSelf.m_Abil.MaxMP - g_HeroSelf.m_Abil.MP) >= g_Config.zSuperMedicaMPs[I]) and (GetTickCount - g_Config.zSuperMedicaMPTicks[I] > Max(g_Config.zSuperMedicaMPTimes[I], 1000)) then begin
              sItemName := g_Config.SuperMedicaItemNames[I];
              if sItemName <> '' then begin
                nIndex := FindHeroItemArrItemName(sItemName);
                if nIndex >= 0 then begin
                  HeroEatItem(nIndex);
                  g_Config.zSuperMedicaMPTicks[I] := GetTickCount;
                  Break;
                end else begin
                  nIndex := FindHeroItemArrBindItemName(sItemName);
                  if nIndex >= 0 then begin
                    if EatAutoHeroOpenItem(nIndex) then begin
                      g_Config.zSuperMedicaMPTicks[I] := GetTickCount;
                      Break;
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;
        //±£»¤
        if g_Config.boHp3Chk and not g_ClientConf.boNoUseHeroProtection and (g_Config.wHp3Hp > 0) and (g_HeroSelf.m_Abil.HP < g_Config.wHp3Hp) then begin
          if GetTickCount - g_CallHeroTick > 5000 then begin
            g_CallHeroTick := GetTickCount();
            msg := MakeDefaultMsg (aa(CM_HEROLOGOUT, frmMain.TempCertification), 0, 0, 0, 0, frmMain.m_nSendMsgCount); //Ó¢ÐÛÍË³ö
            FrmMain.SendSocket (EncodeMessage (msg));
          end;
        end;
        if g_Config.boMP3Chk and not g_ClientConf.boNoUseHeroProtection and (g_Config.wMP3MP > 0) and (g_HeroSelf.m_Abil.MP < g_Config.wMP3MP) then begin
          if GetTickCount - g_CallHeroTick > 5000 then begin
            g_CallHeroTick := GetTickCount();
            msg := MakeDefaultMsg (aa(CM_HEROLOGOUT, frmMain.TempCertification), 0, 0, 0, 0, frmMain.m_nSendMsgCount); //Ó¢ÐÛÍË³ö
            FrmMain.SendSocket (EncodeMessage (msg));
          end;
        end;
        //ÆÕÍ¨HP±£»¤
        if g_Config.boRenewzHeroNormalHpIsAuto and (g_Config.wRenewzHeroNormalHpPercent > 0) and (g_HeroSelf.m_Abil.HP < g_Config.wRenewzHeroNormalHpPercent) and ((GetTickCount - g_Config.wRenewzHeroNormalHpTick) > Max(g_Config.wRenewzHeroNormalHpTime, 1000)) then begin
          nIndex := FindHeroItemArrItemName(1, False);
          if nIndex >= 0 then begin
            HeroEatItem (nIndex);
            g_Config.wRenewzHeroNormalHpTick := GetTickCount();
          end else begin
            nIndex := FindHeroItemArrBindItemName(1, False);
            if nIndex >= 0 then begin
              if HeroBagItemCount <= g_HeroBagCount-5 then begin
                EatAutoHeroOpenItem (nIndex);
                g_Config.wRenewzHeroNormalHpTick := GetTickCount();
              {end else begin
                g_Config.wRenewzHeroNormalHpTick := GetTickCount();
                DScreen.AddChatBoardString('(Ó¢ÐÛ)°ü¹üÒÑÂú£¬ÎÞ·¨²ð°ü¡£',ClWhite, clBlue);
                DScreen.AddChatBoardString('(Ó¢ÐÛ)µÄ½ð´´Ò©ÒÑÊ¹ÓÃÍê',ClWhite, clBlue);  }
              end;   
            {end else begin
              g_Config.wRenewzHeroNormalHpTick := GetTickCount();
              DScreen.AddChatBoardString('(Ó¢ÐÛ)µÄ½ð´´Ò©ÒÑ¾­ÓÃ¾¡¡£',ClWhite, clBlue);  }
            end;
          end;
        end;
        //ÆÕÍ¨MP±£»¤
        if g_Config.boRenewzHeroNormalMpIsAuto and (g_Config.wRenewzHeroNormalMpPercent > 0) and (g_HeroSelf.m_Abil.MP < g_Config.wRenewzHeroNormalMpPercent) and ((GetTickCount - g_Config.wRenewzHeroNormalMpTick) > Max(g_Config.wRenewzHeroNormalMpTime, 1000)) then begin
          nIndex := FindHeroItemArrItemName(2, False);
          if nIndex >= 0 then begin
            HeroEatItem (nIndex);
            g_Config.wRenewzHeroNormalMpTick := GetTickCount();
          end else begin
            nIndex := FindHeroItemArrBindItemName(2, False);
            if nIndex >= 0 then begin
              if HeroBagItemCount <= g_HeroBagCount-5 then begin
                EatAutoHeroOpenItem (nIndex);
                g_Config.wRenewzHeroNormalMpTick := GetTickCount();
              {end else begin
                g_Config.wRenewzHeroNormalMpTick := GetTickCount();
                DScreen.AddChatBoardString('(Ó¢ÐÛ)°ü¹üÒÑÂú£¬ÎÞ·¨²ð°ü¡£',ClWhite, clBlue);
                DScreen.AddChatBoardString('(Ó¢ÐÛ)µÄÄ§·¨Ò©ÒÑÊ¹ÓÃÍê',ClWhite, clBlue);}
              end;
            {end else begin
              g_Config.wRenewzHeroNormalMpTick := GetTickCount();
              DScreen.AddChatBoardString('(Ó¢ÐÛ)µÄÄ§·¨Ò©ÒÑ¾­ÓÃ¾¡¡£',ClWhite, clBlue); }
            end;
          end;
        end;
        //ÌØÐ§HP±£»¤
        if g_Config.boRenewSpecialzHeroNormalHpIsAuto and (g_Config.wRenewSpecialzHeroNormalHpPercent > 0) and (g_HeroSelf.m_Abil.HP < g_Config.wRenewSpecialzHeroNormalHpPercent) and ((GetTickCount - g_Config.wRenewSpecialzHeroNormalHpTick) > Max(g_Config.wRenewSpecialzHeroNormalHpTime, 1000)) then begin
          nIndex := FindHeroItemArrItemName(1, True);
          if nIndex >= 0 then begin
            HeroEatItem (nIndex);
            g_Config.wRenewSpecialzHeroNormalHpTick := GetTickCount();
          end else begin
            nIndex := FindHeroItemArrBindItemName(1, True);
            if nIndex >= 0 then begin
              if HeroBagItemCount <= g_HeroBagCount-5 then begin
                EatAutoHeroOpenItem (nIndex);
                g_Config.wRenewSpecialzHeroNormalHpTick := GetTickCount();
              {end else begin
                g_Config.wRenewSpecialzHeroNormalHpTick := GetTickCount();
                DScreen.AddChatBoardString('°ü(Ó¢ÐÛ)¹üÒÑÂú£¬ÎÞ·¨²ð°ü¡£',ClWhite, clBlue);
                DScreen.AddChatBoardString('(Ó¢ÐÛ)µÄÌØÐ§½ð´´Ò©ÒÑÊ¹ÓÃÍê',ClWhite, clBlue); }
              end;
            {end else begin
              g_Config.wRenewSpecialzHeroNormalHpTick := GetTickCount();
              DScreen.AddChatBoardString('(Ó¢ÐÛ)µÄÌØÐ§½ð´´Ò©ÒÑ¾­ÓÃ¾¡¡£',ClWhite, clBlue); }
            end;
          end;
        end;
        //ÌØÐ§MP±£»¤
        if g_Config.boRenewSpecialzHeroNormalMpIsAuto and (g_Config.wRenewSpecialzHeroNormalMpPercent > 0) and (g_HeroSelf.m_Abil.MP < g_Config.wRenewSpecialzHeroNormalMpPercent) and ((GetTickCount - g_Config.wRenewSpecialzHeroNormalMpTick) > Max(g_Config.wRenewSpecialzHeroNormalMpTime, 1000)) then begin
          nIndex := FindHeroItemArrItemName(2, True);
          if nIndex >= 0 then begin
            HeroEatItem (nIndex);
            g_Config.wRenewSpecialzHeroNormalMpTick := GetTickCount();
          end else begin
            nIndex := FindHeroItemArrBindItemName(2, True);
            if nIndex >= 0 then begin
              if HeroBagItemCount <= g_HeroBagCount-5 then begin
                EatAutoHeroOpenItem (nIndex);
                g_Config.wRenewSpecialzHeroNormalMpTick := GetTickCount();
              {end else begin
                g_Config.wRenewSpecialzHeroNormalMpTick := GetTickCount();
                DScreen.AddChatBoardString('(Ó¢ÐÛ)°ü¹üÒÑÂú£¬ÎÞ·¨²ð°ü¡£',ClWhite, clBlue);
                DScreen.AddChatBoardString('(Ó¢ÐÛ)µÄÌØÐ§Ä§·¨Ò©ÒÑÊ¹ÓÃÍê',ClWhite, clBlue);  }
              end;
            {end else begin
              g_Config.wRenewSpecialzHeroNormalMpTick := GetTickCount();
              DScreen.AddChatBoardString('(Ó¢ÐÛ)µÄÌØÐ§Ä§·¨Ò©ÒÑ¾­ÓÃ¾¡¡£',ClWhite, clBlue);   }
            end;
          end;
        end;
      end;
      1: begin
        //×Ô¶¯Ê¹ÓÃÎïÆ·
        if g_Config.fBoUseSuperMedica then begin
          //HP
          for I:=High(g_Config.SuperMedicaItemNames) downto Low(g_Config.SuperMedicaItemNames) do begin
            sItemName := '';
            if g_Config.fSuperMedicaUses[I] and (g_Config.fSuperMedicaHps[I] > 0) and ((g_HeroSelf.m_Abil.MaxHP - g_HeroSelf.m_Abil.HP) >= g_Config.fSuperMedicaHps[I]) and (GetTickCount - g_Config.fSuperMedicaHpTicks[I] > Max(g_Config.fSuperMedicaHpTimes[I], 1000)) then begin
              sItemName := g_Config.SuperMedicaItemNames[I];
              if sItemName <> '' then begin
                nIndex := FindHeroItemArrItemName(sItemName);
                if nIndex >= 0 then begin
                  HeroEatItem(nIndex);
                  g_Config.fSuperMedicaHpTicks[I] := GetTickCount;
                  Break;
                end else begin
                  nIndex := FindHeroItemArrBindItemName(sItemName);
                  if nIndex >= 0 then begin
                    if EatAutoHeroOpenItem(nIndex) then begin
                      g_Config.fSuperMedicaHpTicks[I] := GetTickCount;
                      Break;
                    end;
                  end;
                end;
              end;
            end;
          end;
          //MP
          for I:=High(g_Config.SuperMedicaItemNames) downto Low(g_Config.SuperMedicaItemNames) do begin
            sItemName := '';
            if g_Config.fSuperMedicaUses[I] and (g_Config.fSuperMedicaMPs[I] > 0) and ((g_HeroSelf.m_Abil.MaxMP - g_HeroSelf.m_Abil.MP) >= g_Config.fSuperMedicaMPs[I]) and (GetTickCount - g_Config.fSuperMedicaMPTicks[I] > Max(g_Config.fSuperMedicaMPTimes[I], 1000)) then begin
              sItemName := g_Config.SuperMedicaItemNames[I];
              if sItemName <> '' then begin
                nIndex := FindHeroItemArrItemName(sItemName);
                if nIndex >= 0 then begin
                  HeroEatItem(nIndex);
                  g_Config.fSuperMedicaMPTicks[I] := GetTickCount;
                  Break;
                end else begin
                  nIndex := FindHeroItemArrBindItemName(sItemName);
                  if nIndex >= 0 then begin
                    if EatAutoHeroOpenItem(nIndex) then begin
                      g_Config.fSuperMedicaMPTicks[I] := GetTickCount;
                      Break;
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;
        //±£»¤
        if g_Config.boHp4Chk and not g_ClientConf.boNoUseHeroProtection and (g_Config.wHp4Hp > 0) and (g_HeroSelf.m_Abil.HP < g_Config.wHp4Hp) then begin
          if GetTickCount - g_CallHeroTick > 5000 then begin
            g_CallHeroTick := GetTickCount();
            msg := MakeDefaultMsg (aa(CM_HEROLOGOUT, frmMain.TempCertification), 0, 0, 0, 0, frmMain.m_nSendMsgCount); //Ó¢ÐÛÍË³ö
            FrmMain.SendSocket (EncodeMessage (msg));
          end;
        end;
        if g_Config.boMP4Chk and not g_ClientConf.boNoUseHeroProtection and (g_Config.wMP4MP > 0) and (g_HeroSelf.m_Abil.MP < g_Config.wMP4MP) then begin
          if GetTickCount - g_CallHeroTick > 5000 then begin
            g_CallHeroTick := GetTickCount();
            msg := MakeDefaultMsg (aa(CM_HEROLOGOUT, frmMain.TempCertification), 0, 0, 0, 0, frmMain.m_nSendMsgCount); //Ó¢ÐÛÍË³ö
            FrmMain.SendSocket (EncodeMessage (msg));
          end;
        end;
        //ÆÕÍ¨HP±£»¤
        if g_Config.boRenewfHeroNormalHpIsAuto and (g_Config.wRenewfHeroNormalHpPercent > 0) and (g_HeroSelf.m_Abil.HP < g_Config.wRenewfHeroNormalHpPercent) and ((GetTickCount - g_Config.wRenewfHeroNormalHpTick) > Max(g_Config.wRenewfHeroNormalHpTime, 1000)) then begin
          nIndex := FindHeroItemArrItemName(1, False);
          if nIndex >= 0 then begin
            HeroEatItem (nIndex);
            g_Config.wRenewfHeroNormalHpTick := GetTickCount();
          end else begin
            nIndex := FindHeroItemArrBindItemName(1, False);
            if nIndex >= 0 then begin
              if HeroBagItemCount <= g_HeroBagCount-5 then begin
                EatAutoHeroOpenItem (nIndex);
                g_Config.wRenewfHeroNormalHpTick := GetTickCount();
              {end else begin
                g_Config.wRenewfHeroNormalHpTick := GetTickCount();
                DScreen.AddChatBoardString('(Ó¢ÐÛ)°ü¹üÒÑÂú£¬ÎÞ·¨²ð°ü¡£',ClWhite, clBlue);
                DScreen.AddChatBoardString('(Ó¢ÐÛ)µÄ½ð´´Ò©ÒÑÊ¹ÓÃÍê',ClWhite, clBlue);   }
              end;
            {end else begin
              g_Config.wRenewfHeroNormalHpTick := GetTickCount();
              DScreen.AddChatBoardString('(Ó¢ÐÛ)µÄ½ð´´Ò©ÒÑ¾­ÓÃ¾¡¡£',ClWhite, clBlue);  }
            end;
          end;
        end;
        //ÆÕÍ¨MP±£»¤
        if g_Config.boRenewfHeroNormalMpIsAuto and (g_Config.wRenewfHeroNormalMpPercent > 0) and (g_HeroSelf.m_Abil.MP < g_Config.wRenewfHeroNormalMpPercent) and ((GetTickCount - g_Config.wRenewfHeroNormalMpTick) > Max(g_Config.wRenewfHeroNormalMpTime, 1000)) then begin
          nIndex := FindHeroItemArrItemName(2, False);
          if nIndex >= 0 then begin
            HeroEatItem (nIndex);
            g_Config.wRenewfHeroNormalMpTick := GetTickCount();
          end else begin
            nIndex := FindHeroItemArrBindItemName(2, False);
            if nIndex >= 0 then begin
              if HeroBagItemCount <= g_HeroBagCount-5 then begin
                EatAutoHeroOpenItem (nIndex);
                g_Config.wRenewfHeroNormalMpTick := GetTickCount();
              {end else begin
                g_Config.wRenewfHeroNormalMpTick := GetTickCount();
                DScreen.AddChatBoardString('(Ó¢ÐÛ)°ü¹üÒÑÂú£¬ÎÞ·¨²ð°ü¡£',ClWhite, clBlue);
                DScreen.AddChatBoardString('(Ó¢ÐÛ)µÄÄ§·¨Ò©ÒÑÊ¹ÓÃÍê',ClWhite, clBlue);      }
              end;
            {end else begin
              g_Config.wRenewfHeroNormalMpTick := GetTickCount();
              DScreen.AddChatBoardString('(Ó¢ÐÛ)µÄÄ§·¨Ò©ÒÑ¾­ÓÃ¾¡¡£',ClWhite, clBlue);}
            end;
          end;
        end;
        //ÌØÐ§HP±£»¤
        if g_Config.boRenewSpecialfHeroNormalHpIsAuto and (g_Config.wRenewSpecialfHeroNormalHpPercent > 0) and (g_HeroSelf.m_Abil.HP < g_Config.wRenewSpecialfHeroNormalHpPercent) and ((GetTickCount - g_Config.wRenewSpecialfHeroNormalHpTick) > Max(g_Config.wRenewSpecialfHeroNormalHpTime, 1000)) then begin
          nIndex := FindHeroItemArrItemName(1, True);
          if nIndex >= 0 then begin
            HeroEatItem (nIndex);
            g_Config.wRenewSpecialfHeroNormalHpTick := GetTickCount();
          end else begin
            nIndex := FindHeroItemArrBindItemName(1, True);
            if nIndex >= 0 then begin
              if HeroBagItemCount <= g_HeroBagCount-5 then begin
                EatAutoHeroOpenItem (nIndex);
                g_Config.wRenewSpecialfHeroNormalHpTick := GetTickCount();
              {end else begin
                g_Config.wRenewSpecialfHeroNormalHpTick := GetTickCount();
                DScreen.AddChatBoardString('°ü(Ó¢ÐÛ)¹üÒÑÂú£¬ÎÞ·¨²ð°ü¡£',ClWhite, clBlue);
                DScreen.AddChatBoardString('(Ó¢ÐÛ)µÄÌØÐ§½ð´´Ò©ÒÑÊ¹ÓÃÍê',ClWhite, clBlue);   }
              end;
            {end else begin
              g_Config.wRenewSpecialfHeroNormalHpTick := GetTickCount();
              DScreen.AddChatBoardString('(Ó¢ÐÛ)µÄÌØÐ§½ð´´Ò©ÒÑ¾­ÓÃ¾¡¡£',ClWhite, clBlue);  }
            end;
          end;
        end;
        //ÌØÐ§MP±£»¤
        if g_Config.boRenewSpecialfHeroNormalMpIsAuto and (g_Config.wRenewSpecialfHeroNormalMpPercent > 0) and (g_HeroSelf.m_Abil.MP < g_Config.wRenewSpecialfHeroNormalMpPercent) and ((GetTickCount - g_Config.wRenewSpecialfHeroNormalMpTick) > Max(g_Config.wRenewSpecialfHeroNormalMpTime, 1000)) then begin
          nIndex := FindHeroItemArrItemName(2, True);
          if nIndex >= 0 then begin
            HeroEatItem (nIndex);
            g_Config.wRenewSpecialfHeroNormalMpTick := GetTickCount();
          end else begin
            nIndex := FindHeroItemArrBindItemName(2, True);
            if nIndex >= 0 then begin
              if HeroBagItemCount <= g_HeroBagCount-5 then begin
                EatAutoHeroOpenItem (nIndex);
                g_Config.wRenewSpecialfHeroNormalMpTick := GetTickCount();
              {end else begin
                g_Config.wRenewSpecialfHeroNormalMpTick := GetTickCount();
                DScreen.AddChatBoardString('(Ó¢ÐÛ)°ü¹üÒÑÂú£¬ÎÞ·¨²ð°ü¡£',ClWhite, clBlue);
                DScreen.AddChatBoardString('(Ó¢ÐÛ)µÄÌØÐ§Ä§·¨Ò©ÒÑÊ¹ÓÃÍê',ClWhite, clBlue); }
              end;
            {end else begin
              g_Config.wRenewSpecialfHeroNormalMpTick := GetTickCount();
              DScreen.AddChatBoardString('(Ó¢ÐÛ)µÄÌØÐ§Ä§·¨Ò©ÒÑ¾­ÓÃ¾¡¡£',ClWhite, clBlue); }
            end;
          end;
        end;
      end;
      2: begin
        //×Ô¶¯Ê¹ÓÃÎïÆ·
        if g_Config.dBoUseSuperMedica then begin
          //HP
          for I:=High(g_Config.SuperMedicaItemNames) downto Low(g_Config.SuperMedicaItemNames) do begin
            sItemName := '';
            if g_Config.dSuperMedicaUses[I] and (g_Config.dSuperMedicaHps[I] > 0) and ((g_HeroSelf.m_Abil.MaxHP - g_HeroSelf.m_Abil.HP) >= g_Config.dSuperMedicaHps[I]) and (GetTickCount - g_Config.dSuperMedicaHpTicks[I] > Max(g_Config.dSuperMedicaHpTimes[I], 1000)) then begin
              sItemName := g_Config.SuperMedicaItemNames[I];
              if sItemName <> '' then begin
                nIndex := FindHeroItemArrItemName(sItemName);
                if nIndex >= 0 then begin
                  HeroEatItem(nIndex);
                  g_Config.dSuperMedicaHpTicks[I] := GetTickCount;
                  Break;
                end else begin
                  nIndex := FindHeroItemArrBindItemName(sItemName);
                  if nIndex >= 0 then begin
                    if EatAutoHeroOpenItem(nIndex) then begin
                      g_Config.dSuperMedicaHpTicks[I] := GetTickCount;
                      Break;
                    end;
                  end;
                end;
              end;
            end;
          end;
          //MP
          for I:=High(g_Config.SuperMedicaItemNames) downto Low(g_Config.SuperMedicaItemNames) do begin
            sItemName := '';
            if g_Config.dSuperMedicaUses[I] and (g_Config.dSuperMedicaMPs[I] > 0) and ((g_HeroSelf.m_Abil.MaxMP - g_HeroSelf.m_Abil.MP) >= g_Config.dSuperMedicaMPs[I]) and (GetTickCount - g_Config.dSuperMedicaMPTicks[I] > Max(g_Config.dSuperMedicaMPTimes[I], 1000)) then begin
              sItemName := g_Config.SuperMedicaItemNames[I];
              if sItemName <> '' then begin
                nIndex := FindHeroItemArrItemName(sItemName);
                if nIndex >= 0 then begin
                  HeroEatItem(nIndex);
                  g_Config.dSuperMedicaMPTicks[I] := GetTickCount;
                  Break;
                end else begin
                  nIndex := FindHeroItemArrBindItemName(sItemName);
                  if nIndex >= 0 then begin
                    if EatAutoHeroOpenItem(nIndex) then begin
                      g_Config.dSuperMedicaMPTicks[I] := GetTickCount;
                      Break;
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;
        //±£»¤
        if g_Config.boHp5Chk and not g_ClientConf.boNoUseHeroProtection and (g_Config.wHp5Hp > 0) and (g_HeroSelf.m_Abil.HP < g_Config.wHp5Hp) then begin
          if GetTickCount - g_CallHeroTick > 5000 then begin
            g_CallHeroTick := GetTickCount();
            msg := MakeDefaultMsg (aa(CM_HEROLOGOUT, frmMain.TempCertification), 0, 0, 0, 0, frmMain.m_nSendMsgCount); //Ó¢ÐÛÍË³ö
            FrmMain.SendSocket (EncodeMessage (msg));
          end;
        end;
        if g_Config.boMP5Chk and not g_ClientConf.boNoUseHeroProtection and (g_Config.wMP5MP > 0) and (g_HeroSelf.m_Abil.MP < g_Config.wMP5MP) then begin
          if GetTickCount - g_CallHeroTick > 5000 then begin
            g_CallHeroTick := GetTickCount();
            msg := MakeDefaultMsg (aa(CM_HEROLOGOUT, frmMain.TempCertification), 0, 0, 0, 0, frmMain.m_nSendMsgCount); //Ó¢ÐÛÍË³ö
            FrmMain.SendSocket (EncodeMessage (msg));
          end;
        end;
        //ÆÕÍ¨HP±£»¤
        if g_Config.boRenewfHeroNormalHpIsAuto and (g_Config.wRenewdHeroNormalHpPercent > 0) and (g_HeroSelf.m_Abil.HP < g_Config.wRenewdHeroNormalHpPercent) and ((GetTickCount - g_Config.wRenewdHeroNormalHpTick) > Max(g_Config.wRenewdHeroNormalHpTime, 1000)) then begin
          nIndex := FindHeroItemArrItemName(1, False);
          if nIndex >= 0 then begin
            HeroEatItem (nIndex);
            g_Config.wRenewdHeroNormalHpTick := GetTickCount();
          end else begin
            nIndex := FindHeroItemArrBindItemName(1, False);
            if nIndex >= 0 then begin
              if HeroBagItemCount <= g_HeroBagCount-5 then begin
                EatAutoHeroOpenItem (nIndex);
                g_Config.wRenewdHeroNormalHpTick := GetTickCount();
              {end else begin
                g_Config.wRenewdHeroNormalHpTick := GetTickCount();
                DScreen.AddChatBoardString('(Ó¢ÐÛ)°ü¹üÒÑÂú£¬ÎÞ·¨²ð°ü¡£',ClWhite, clBlue);
                DScreen.AddChatBoardString('(Ó¢ÐÛ)µÄ½ð´´Ò©ÒÑÊ¹ÓÃÍê',ClWhite, clBlue); }
              end;
            {end else begin
              g_Config.wRenewdHeroNormalHpTick := GetTickCount();
              DScreen.AddChatBoardString('(Ó¢ÐÛ)µÄ½ð´´Ò©ÒÑ¾­ÓÃ¾¡¡£',ClWhite, clBlue); }
            end;
          end;
        end;
        //ÆÕÍ¨MP±£»¤
        if g_Config.boRenewdHeroNormalMpIsAuto and (g_Config.wRenewdHeroNormalMpPercent > 0) and (g_HeroSelf.m_Abil.MP < g_Config.wRenewdHeroNormalMpPercent) and ((GetTickCount - g_Config.wRenewdHeroNormalMpTick) > Max(g_Config.wRenewdHeroNormalMpTime, 1000)) then begin
          nIndex := FindHeroItemArrItemName(2, False);
          if nIndex >= 0 then begin
            HeroEatItem (nIndex);
            g_Config.wRenewdHeroNormalMpTick := GetTickCount();
          end else begin
            nIndex := FindHeroItemArrBindItemName(2, False);
            if nIndex >= 0 then begin
              if HeroBagItemCount <= g_HeroBagCount-5 then begin
                EatAutoHeroOpenItem (nIndex);
                g_Config.wRenewdHeroNormalMpTick := GetTickCount();
              {end else begin
                g_Config.wRenewdHeroNormalMpTick := GetTickCount();
                DScreen.AddChatBoardString('(Ó¢ÐÛ)°ü¹üÒÑÂú£¬ÎÞ·¨²ð°ü¡£',ClWhite, clBlue);
                DScreen.AddChatBoardString('(Ó¢ÐÛ)µÄÄ§·¨Ò©ÒÑÊ¹ÓÃÍê',ClWhite, clBlue);  }
              end;
            {end else begin
              g_Config.wRenewdHeroNormalMpTick := GetTickCount();
              DScreen.AddChatBoardString('(Ó¢ÐÛ)µÄÄ§·¨Ò©ÒÑ¾­ÓÃ¾¡¡£',ClWhite, clBlue); }
            end;
          end;
        end;
        //ÌØÐ§HP±£»¤
        if g_Config.boRenewSpecialdHeroNormalHpIsAuto and (g_Config.wRenewSpecialdHeroNormalHpPercent > 0) and (g_HeroSelf.m_Abil.HP < g_Config.wRenewSpecialdHeroNormalHpPercent) and ((GetTickCount - g_Config.wRenewSpecialdHeroNormalHpTick) > Max(g_Config.wRenewSpecialdHeroNormalHpTime, 1000)) then begin
          nIndex := FindHeroItemArrItemName(1, True);
          if nIndex >= 0 then begin
            HeroEatItem (nIndex);
            g_Config.wRenewSpecialdHeroNormalHpTick := GetTickCount();
          end else begin
            nIndex := FindHeroItemArrBindItemName(1, True);
            if nIndex >= 0 then begin
              if HeroBagItemCount <= g_HeroBagCount-5 then begin
                EatAutoHeroOpenItem (nIndex);
                g_Config.wRenewSpecialdHeroNormalHpTick := GetTickCount();
              {end else begin
                g_Config.wRenewSpecialdHeroNormalHpTick := GetTickCount();
                DScreen.AddChatBoardString('°ü(Ó¢ÐÛ)¹üÒÑÂú£¬ÎÞ·¨²ð°ü¡£',ClWhite, clBlue);
                DScreen.AddChatBoardString('(Ó¢ÐÛ)µÄÌØÐ§½ð´´Ò©ÒÑÊ¹ÓÃÍê',ClWhite, clBlue);   }
              end;
            {end else begin
              g_Config.wRenewSpecialdHeroNormalHpTick := GetTickCount();
              DScreen.AddChatBoardString('(Ó¢ÐÛ)µÄÌØÐ§½ð´´Ò©ÒÑ¾­ÓÃ¾¡¡£',ClWhite, clBlue);   }
            end;
          end;
        end;
        //ÌØÐ§MP±£»¤
        if g_Config.boRenewSpecialdHeroNormalMpIsAuto and (g_Config.wRenewSpecialdHeroNormalMpPercent > 0) and (g_HeroSelf.m_Abil.MP < g_Config.wRenewSpecialdHeroNormalMpPercent) and ((GetTickCount - g_Config.wRenewSpecialdHeroNormalMpTick) > Max(g_Config.wRenewSpecialdHeroNormalMpTime, 1000)) then begin
          nIndex := FindHeroItemArrItemName(2, True);
          if nIndex >= 0 then begin
            HeroEatItem (nIndex);
            g_Config.wRenewSpecialdHeroNormalMpTick := GetTickCount();
          end else begin
            nIndex := FindHeroItemArrBindItemName(2, True);
            if nIndex >= 0 then begin
              if HeroBagItemCount <= g_HeroBagCount-5 then begin
                EatAutoHeroOpenItem (nIndex);
                g_Config.wRenewSpecialdHeroNormalMpTick := GetTickCount();
              {end else begin
                g_Config.wRenewSpecialdHeroNormalMpTick := GetTickCount();
                DScreen.AddChatBoardString('(Ó¢ÐÛ)°ü¹üÒÑÂú£¬ÎÞ·¨²ð°ü¡£',ClWhite, clBlue);
                DScreen.AddChatBoardString('(Ó¢ÐÛ)µÄÌØÐ§Ä§·¨Ò©ÒÑÊ¹ÓÃÍê',ClWhite, clBlue); }
              end;
            {end else begin
              g_Config.wRenewSpecialdHeroNormalMpTick := GetTickCount();
              DScreen.AddChatBoardString('(Ó¢ÐÛ)µÄÌØÐ§Ä§·¨Ò©ÒÑ¾­ÓÃ¾¡¡£',ClWhite, clBlue); }
            end;
          end;
        end;
      end;
    end;
  end;
  {$IFEND}
end;

//ÏÔÊ¾×ÔÉí¶¯»­  Í¨ÓÃÀà
procedure TfrmMain.ShowMyShow(Actor: TActor; TypeShow:Integer);
                      {ÓÃ»§}        {¿ªÊ¼èå}  {Íùºó²¥·ÅèåÊý}   {²¥·Å¼ä¸ôÊ±¼ä}         {Í¼Ïó¿â}
  procedure MyShow(Actor: TActor; StartFrame, ExplosionFrame, NextFrameTime: Integer; wimg: TWMImages);
  begin
    actor.g_boIsMyShow := True;
    actor.m_nMyShowStartFrame := StartFrame; //¿ªÊ¼
    actor.m_nMyShowExplosionFrame := ExplosionFrame; //Íùºó²¥·Å
    actor.m_nMyShowNextFrameTime := NextFrameTime;
    actor.m_nMyShowTime := GetTickCount;
    actor.m_nMyShowFrame := 0;
    actor.g_MagicBase := wimg;
  end;
begin
  actor.m_boNoChangeIsMyShow := False; //³õÊ¼»¯ ×ÔÉíÐ§¹û ÊÇ±ä»¯µÄ 20080306
  case TypeShow of
    ET_PROTECTION_PIP: begin
      MyShow(actor, 470, 5, 140, g_WMagic6Images);  //ÆÆ¶ÜÐ§¹û
      MyPlaySound (heroshield_ground); //»¤ÌåÉñ¶ÜÉùÒô
    end;
    ET_PROTECTION_STRUCK: begin
      MyShow(actor, 790, 10, 140, g_WMagic5Images);  //ÊÜ¹¥»÷Ð§¹û
      MyPlaySound (heroshield_ground); //»¤ÌåÉñ¶ÜÉùÒô
    end;
    ET_OBJECTLEVELUP: begin
      MyShow(actor, 110, 14, 80, g_WMain2Images);  //Éý¼¶Ð§¹û 20080222
      MyPlaySound(powerup_ground);
    end;
    ET_OBJECTBUTCHMON: begin
      MyShow(actor, 30, 24, 140, g_WMain2Images); //ÎÔÁúÍÚµ½¶«Î÷Ð§¹ûÍ¼ 20080326
      MyPlaySound(darewin_ground);
    end;
    ET_DRINKDECDRAGON: begin
      MyShow(actor, 710, 18, 80, g_WMain2Images); //ºÈ¾ÆµÖÓùºÏ»÷£¬ÏÔÊ¾×ÔÉíÐ§¹û 20090105
    end;
    1: begin //ÁúÓ°½£·¨  ºó9¸ö¶¯»­Ð§¹û 20080202
      actor.m_boWarMode := TRUE;
      MyShow(actor, actor.m_btDir * 20 + 746, 9, 50, g_WMagic2Images);
      actor.m_boNoChangeIsMyShow := True; //ÁúÓ°µÄ¶¯»­²»Ëæ×ÅÈËÎï±ä»¯¶ø¶¯ ÉèÎªÕæ 20080306
      actor.m_nNoChangeX := actor.m_nCurrX;  //20080306
      actor.m_nNoChangeY := actor.m_nCurrY;  //20080306
    end;
    {2: begin //¿ªÌìÕ¶ÖØ»÷Ëé±ùÐ§¹û
      MyShow(actor, actor.m_btDir * 10 + 555, 5, 150, g_WMagic5Images);
      actor.m_boWarMode := TRUE;
      actor.m_boNoChangeIsMyShow := True; //¿ªÌìÕ¶ÖØ»÷Ëé±ùµÄ¶¯»­²»Ëæ×ÅÈËÎï±ä»¯¶ø¶¯ ÉèÎªÕæ 20080306
      actor.m_nNoChangeX := actor.m_nCurrX;  //20080306
      actor.m_nNoChangeY := actor.m_nCurrY;  //20080306
    end;
    3: begin //¿ªÌìÕ¶Çá»÷Ëé±ùÐ§¹û
      MyShow(actor, actor.m_btDir * 10 + 715, 5, 150, g_WMagic5Images);
      actor.m_boWarMode := TRUE;
      actor.m_boNoChangeIsMyShow := True; //¿ªÌìÕ¶Çá»÷Ëé±ùµÄ¶¯»­²»Ëæ×ÅÈËÎï±ä»¯¶ø¶¯ ÉèÎªÕæ 20080306
      actor.m_nNoChangeX := actor.m_nCurrX;  //20080306
      actor.m_nNoChangeY := actor.m_nCurrY;  //20080306
    end; }
    4: MyShow(actor, 170, 4, 150, g_WMagic4Images);//ÆÆ»êÕ¶  ¹¥»÷Ç° ¹ÖÎï×ÔÉí¶¯»­
    5: MyShow(actor, 460, 10, 80, g_WMagic4Images); //ÅüÐÇÕ½Ê¿Ð§¹û 20080611  //Õ½Ê¿¹¥»÷×ÔÉíÐ§¹û
    6: MyShow(actor, 420, 16, 120, g_WMagic4Images); //À×öªÒ»»÷Õ½Ê¿Ð§¹û 20080611
    7: MyShow(actor, 630, 5, 80, g_WMain2Images); //ÈËÎïºÈ¾Æ¶¯»­ 20080623
    8: MyShow(actor, 640, 9, 80, g_WMain2Images); //ÈËÎï¾ÆÁ¿ÌáÉý½ø¶ÈÊÍ·Å¶¯»­ 20080623
    9: MyShow(actor, 650, 14, 80, g_WMain2Images); //ÈËÎï×í¾Æ¶¯»­ 20080623
   10: begin
      MyShow(actor, 670, 17, 80, g_WMain2Images); //²É¼¯µ½ÈªË®¶¯»­  20080624
      PlaySound (s_click_drug);
   end;
   11: begin //ÊÉÑªÊõ ÈËÎï×ÔÉí¶¯»­ÏÔÊ¾
      MyShow(actor, 1090, 9, 50, g_WMagic2Images);
      PlaySound(10485);
   end;
   12: begin //4¼¶ÊÉÑªÊõ ÈËÎï×ÔÉí¶¯»­ÏÔÊ¾
      MyShow(actor, 1180, 9, 50, g_WMagic2Images); 
      PlaySound(10485);
   end;
  end;
end;

procedure TfrmMain._DXDrawMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
   tdir, nx, ny, nHitMsg, sel: integer;
   target: TActor;
   btEffectLevelEx: Byte;
begin
   ActionKey := 0;
   g_nMouseX := X;
   g_nMouseY := Y;
   g_boAutoDig := FALSE; //È¡ÏûÍÚ¿ó
   if g_boAutoButch then begin
     g_boAutoButch := False; //È¡Ïû×Ô¶¯ÍÚÈ¡
     DScreen.AddChatBoardString('×Ô¶¯³ÖÐøÌ½Ë÷Í£Ö¹',GetRGB(178), ClWhite);
   end;
   //ÓÒ¼üÈ¡ÏûÎïÆ·µÄÒÆ¶¯
   if (Button = mbRight) and (g_boItemMoving) then begin
      FrmDlg.CancelItemMoving;
      Exit;
   end;
   //ÓÒ¼üÈ¡ÏûÓ¢ÐÛÎïÆ·µÄÒÆ¶¯
   if (Button = mbRight) and (g_boHeroItemMoving{20080320}) then begin
      FrmDlg.CancelHeroItemMoving;
      Exit;
   end;


   if g_DWinMan.MouseDown (Button, Shift, X, Y) then begin //Êó±êÒÆµ½´°¿ÚÉÏÁËÔòÌø¹ý
     with FrmDlg do begin
       {$IF M2Version = 1}
       if DBNewWinBatterCom.Visible then DBNewWinBatterCom.Visible := False;
       if DBNewHeroBatterCom.Visible then DBNewHeroBatterCom.Visible := False;
       if DWinBatterCom.Visible then DWinBatterCom.Visible := False;
       if DHeroBatterCom.Visible then DHeroBatterCom.Visible := False;
       {$IFEND}
       if DBCommandFrame.Visible then DBCommandFrame.Visible := False;
     end;

     if ssRight in Shift then begin
       if not (MouseCaptureControl = FrmDlg.DWMiniMap) then Exit;
     end else Exit;
   end;
   
   with FrmDlg do begin
     {$IF M2Version = 1}
     if DBNewWinBatterCom.Visible then DBNewWinBatterCom.Visible := False;
     if DBNewHeroBatterCom.Visible then DBNewHeroBatterCom.Visible := False;
     if DWinBatterCom.Visible then DWinBatterCom.Visible := False;
     if DHeroBatterCom.Visible then DHeroBatterCom.Visible := False;
     {$IFEND}
     if DBCommandFrame.Visible then DBCommandFrame.Visible := False;
   end;
   if (g_MySelf = nil) or (DScreen.CurrentScene <> PlayScene) then Exit;  //Èç¹ûÈËÎïÍË³öÔòÌø¹ý

   if AutoFindPathTimer.Enabled then begin     //Í£Ö¹×ÔÓÉÒÆ¶¯
      AutoFindPathTimer.Enabled := False;
      LegendMap.Stop;
      DScreen.AddChatBoardString('Í£Ö¹×ÔÓÉÒÆ¶¯',GetRGB(178), ClWhite);
   end;
   if ssRight in Shift then begin//Êó±êÓÒ¼ü
      if Shift = [ssRight] then Inc (g_nDupSelection);  //¶àÑ¡
      target := PlayScene.GetAttackFocusCharacter (X, Y, g_nDupSelection, sel, FALSE); //È¡Ö¸¶¨×ø±êÉÏµÄ½ÇÉ«
      if g_nDupSelection <> sel then g_nDupSelection := 0;

      if target <> nil then begin
         if ssCtrl in Shift then begin  //Ctrl+Êó±êÓÒ¼ü = ÏÔÊ¾½ÇÉ«µÄÐÅÏ¢
            if GetTickCount - g_dwLastMoveTick > 1000 then begin   //Ö¸ÏòÒ»¸öÍæ¼Ò£¬Ò»Ãëºó²Å¿ÉÒÔ²é¿´Æä×°±¸
               if (target.m_btRace in [0,1,150]{ÈËÀà,Ó¢ÐÛ,ÈËÐÍ20080629}) {and (not target.m_boDeath)} then begin
                  //È¡µÃÈËÎïÐÅÏ¢
                  SendClientMessage (CM_QUERYUSERSTATE, target.m_nRecogId, target.m_nCurrX, target.m_nCurrY, 0);
                  Exit;
               end;
            end;
         end;
         if ssAlt in Shift then begin //Alt+Êó±êÓÒ¼ü = ÃÜÈË  20080701
           if (target.m_btRace in [0,1,150]) {and (not target.m_boDeath)} then begin
              PlayScene.EdChat.Visible := TRUE;
              PlayScene.EdChat.Text := '/'+ target.m_sUserName+' ';
              PlayScene.EdChat.SetFocus;
              SetImeMode (PlayScene.EdChat.Handle, LocalLanguage);
              PlayScene.EdChat.SelStart := Length(PlayScene.EdChat.Text);
              Exit;
           end;
         end;
      end else begin
         g_nDupSelection := 0;
        {$IF M2Version <> 2}
        //ÍÚ±¦
        if (ssAlt in Shift) and (not g_MySelf.m_boIsShop{¿ªµê²»ÔÊÐí²Ù×÷}) then begin
          if g_boOpenLeiMei then begin
            tdir := GetNextDirection (g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nMouseCurrX, g_nMouseCurrY);
            if CanNextAction and ServerAcceptNextAction then begin
              with g_UseItems[U_WEAPON] do begin
                if (s.StdMode = 5) and (Dura > 0) and ((s.Shape = 75) or (s.Shape = 76) or (s.Shape = 77)) then begin
                  SendUseLingMeiAnimal (g_nMouseCurrX, g_nMouseCurrY);
                  g_MySelf.SendMsg (CM_SITDOWN, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, 0, 0, '', 0, g_nilFeature);
                end else begin
                  DScreen.AddChatBoardString('ÄúÃ»ÓÐÅå´ø²ù×Ó', GetRGB(219), clWhite);
                  g_MySelf.SendMsg (CM_SITDOWN, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, 0, 0, '', 0, g_nilFeature);
                end;
              end;
            end;
          end;
        end;
        {$IFEND}
      end;
      if not g_MySelf.m_boIsShop {¿ªµê²»ÔÊÐí²Ù×÷} then begin
        //°´Êó±êÓÒ¼ü£¬²¢ÇÒÊó±êÖ¸Ïò¿ÕÎ»ÖÃ
        PlayScene.CXYfromMouseXY (X, Y, g_nMouseCurrX, g_nMouseCurrY);
        if (abs(g_MySelf.m_nCurrX - g_nMouseCurrX) <= 1) and (abs(g_MySelf.m_nCurrY - g_nMouseCurrY) <= 1) then begin //Ä¿±ê×ù±ê  //Á½¸ñ·¶Î§ÄÚ
          tdir := GetNextDirection (g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nMouseCurrX, g_nMouseCurrY);
          if CanNextAction and ServerAcceptNextAction then begin
            g_MySelf.SendMsg (CM_TURN, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, 0, 0, '', 0, g_nilFeature);
          end;
        end else begin //ÅÜ
          g_ChrAction := caRun;
          g_nTargetX := g_nMouseCurrX;
          g_nTargetY := g_nMouseCurrY;
          Exit;
        end;
      end;
   end;

   if ssLeft in Shift {Button = mbLeft} then begin  //Êó±ê×ó¼ü
      //°ø°Ý... ³ÐÀº ¹üÀ§·Î ¼±ÅÃµÊ
      target := PlayScene.GetAttackFocusCharacter (X, Y, g_nDupSelection, sel, TRUE); //»ì¾ÆÀÖ´Â ³ð¸¸..
      PlayScene.CXYfromMouseXY (X, Y, g_nMouseCurrX, g_nMouseCurrY);
      g_TargetCret := nil;
      if (g_UseItems[U_WEAPON].S.Name <> '') and (target = nil) and (not g_MySelf.m_boIsShop {¿ªµê²»ÔÊÐí²Ù×÷})
{//ÆïÂí×´Ì¬²»¿ÉÒÔ²Ù×÷    20080721 ×¢ÊÍÆïÂí
        and (g_MySelf.m_btHorse = 0)} then begin
         //ÍÚ¿ó
         if g_UseItems[U_WEAPON].S.Shape = 19 then begin //º××ì³ú
            tdir := GetNextDirection (g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nMouseCurrX, g_nMouseCurrY);
            //¸ù¾Ýµ±Ç°Î»ÖÃºÍ·½Ïò»ñµÃÇ°½øÒ»²½µÄ×ø±ê
            GetFrontPosition (g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, nx, ny);
            if not Map.CanMove(nx, ny) or (ssShift in Shift) then begin  //²»ÄÜÒÆ¶¯»òÇ¿ÐÐÍÚ¿ó
               if CanNextAction and ServerAcceptNextAction and CanNextHit then begin
                  g_MySelf.SendMsg (CM_HIT+1, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, 0, 0, '', 0, g_nilFeature);
               end;
               g_boAutoDig := TRUE;  //×Ô¶¯³ú¿ó
               Exit;
            end;
         end;
      end;

      if (ssAlt in Shift) and (not g_MySelf.m_boIsShop{¿ªµê²»ÔÊÐí²Ù×÷})
{//ÆïÂí×´Ì¬²»¿ÉÒÔ²Ù×÷
        and (g_MySelf.m_btHorse = 0)20080721 ×¢ÊÍÆïÂí} then begin
         //ÍÚÎïÆ·
         if not g_boAutoButch then begin
           tdir := GetNextDirection (g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nMouseCurrX, g_nMouseCurrY);
           if CanNextAction and ServerAcceptNextAction then begin
              target := PlayScene.ButchAnimal (g_nMouseCurrX, g_nMouseCurrY);
              if target <> nil then begin
                 if FrmDlg.DCheckAutoButch.Checked then begin
                   g_nButchX := g_nMouseCurrX;
                   g_nButchY := g_nMouseCurrY;
                   DScreen.AddChatBoardString('×Ô¶¯³ÖÐøÌ½Ë÷¿ªÆô',GetRGB(178), ClWhite);
                   g_boAutoButch := True;
                 end else begin
                   SendButchAnimal (g_nMouseCurrX, g_nMouseCurrY, tdir, target.m_nRecogId);
                   g_MySelf.SendMsg (CM_SITDOWN, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, 0, 0, '', 0, g_nilFeature); //ÀÚ¼¼´Â °°À½
                 end;
                 Exit;
              end;
              g_MySelf.SendMsg (CM_SITDOWN, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, 0, 0, '', 0, g_nilFeature);//¶×ÏÂ
           end;
           g_nTargetX := -1;
         end;
      end else begin
         if (target <> nil) or (ssShift in Shift) then begin  //¶ÔÏó²»Îªnil »ò Shift+×ó¼ü
            g_nTargetX := -1;
            if target <> nil then begin
               //if GetTickCount - g_dwLastMoveTick > 1500 then begin  //20080229  ÐÞÕýNPC»¹ÊÇ²»ÔõÃ´µãµÄ¶¯
                  if target.m_btRace = RCC_MERCHANT then begin //µãµÄÄ¿±êÉÌÈË
                     SendClientMessage (CM_CLICKNPC, target.m_nRecogId, 0, 0, 0);
                     Exit;
                  end;
               //end;
              //µã»÷¸öÈËÉÌµê
              if (target.m_btRace = RC_PLAYOBJECT) and (target.m_boIsShop) then begin
                //g_dwLastMoveTick := GetTickCount;
                SendClientMessage(CM_CLICKSHOP, target.m_nRecogId, target.m_nCurrX, target.m_nCurrY, 0);
                Exit;
              end;
               if (g_MySelf.m_nState and $04000000 = 0){·ÇÂé±Ô}and (g_MySelf.m_nState and $1000000 = 0){±ù¶³} and (g_MySelf.m_nState and $00004000= 0) then begin
                 if (not target.m_boDeath) and (not g_MySelf.m_boIsShop{¿ªµê²»ÔÊÐí²Ù×÷})
              (* and (g_MySelf.m_btHorse = 0{ÆïÂí²»ÔÊÐí²Ù×÷})20080721 ×¢ÊÍÆïÂí*) then begin
                    g_TargetCret := target;
                    if ((target.m_btRace <> RCC_USERHUMAN) and
                        (target.m_btRace <> 1) and //Ó¢ÐÛ 20080629
                        (target.m_btRace <> 150) and //ÈËÐÍ 20080629
                        (target.m_btRace <> RCC_GUARD) and
                        (target.m_btRace <> RCC_MERCHANT) and
                        (pos('(', target.m_sUserName) = 0) //°üÀ¨'('µÄ½ÇÉ«Ãû³ÆÎªÕÙ»½µÄ±¦±¦
                       )
                       or (ssShift in Shift) //SHIFT + Êó±ê×ó¼ü
                       or (target.m_nNameColor = ENEMYCOLOR)
                    then begin
                       AttackTarget (target);
                       g_dwLatestHitTick := GetTickCount;
                    end;
                 end;
               end;
            end else begin
{//ÆïÂí²»ÔÊÐí²Ù×÷  20080721 ×¢ÊÍÆïÂí
               if (g_MySelf.m_btHorse = 0) then begin  }
               if (not g_MySelf.m_boIsShop{¿ªµê²»ÔÊÐí²Ù×÷}) then begin
                 tdir := GetNextDirection (g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nMouseCurrX, g_nMouseCurrY);
                 if (g_MySelf.m_nState and $04000000 = 0){·ÇÂé±Ô} and (g_MySelf.m_nState and $1000000 = 0){±ù¶³} and (g_MySelf.m_nState and $00004000 = 0){¶¨Éí}  then begin
                   if CanNextAction and ServerAcceptNextAction and CanNextHit then begin
                      nHitMsg := CM_HIT+Random(3);
                      if (nHitMsg = CM_HIT) and (g_MySelf.m_nState and $00020000 <> 0) and GetXinFaMagicByID(107) then nHitMsg := CM_HIT_107;
                      btEffectLevelEx := 0;
                      if g_boCanLongHit  and {(TargetInSwordLongAttackRange (tdir)) or} g_boLongHit then begin  //ÊÇ·ñ¿ÉÒÔÊ¹ÓÃ´ÌÉ±
                        if g_boCanLongHit4 then begin
                          if GetMagicEffLevelEx(89) <> 0 then begin
                            btEffectLevelEx := GetMagicEffLevelEx(89);
                          end;
                          nHitMsg := CM_LONGHIT4;
                        end else begin
                          if GetMagicEffLevelEx(12) = 0 then begin
                            {$IF M2Version <> 2}
                            if g_boMySelfTitleFense then
                              nHitMsg := CM_LONGHITFORFENGHAO  //·ÛÉ«´ÌÉ±
                            else {$IFEND}nHitMsg := CM_LONGHIT;
                          end else begin
                            btEffectLevelEx := GetMagicEffLevelEx(12);
                            nHitMsg := CM_LONGHIT;
                          end;
                        end;
                      end;
                      if g_boCanWideHit and (g_MySelf.m_Abil.MP >= 3) and (TargetInSwordWideAttackRange (tdir)) then begin  //ÊÇ·ñ¿ÉÒÔÊ¹ÓÃ°ëÔÂ
                        if g_boCanWideHit4 then begin
                          nHitMsg := CM_WIDEHIT4;
                          if GetMagicEffLevelEx(90) <> 0 then btEffectLevelEx := GetMagicEffLevelEx(90);
                        end else nHitMsg := CM_WIDEHIT;
                      end;
                      if g_boCanCrsHit and (g_MySelf.m_Abil.MP >= 6) and (TargetInSwordCrsAttackRange (tdir)) then begin  //ÊÇ·ñ¿ÉÒÔÊ¹ÓÃ°ëÔÂ
                         nHitMsg := CM_CRSHIT;
                      end;
                      g_MySelf.SendMsg (nHitMsg, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, btEffectLevelEx, 0, '', 0, g_nilFeature);
                   end;
                 end;
                 g_dwLastAttackTick := GetTickCount;
               end;
            end;
         end else begin
//            if (MCX = Myself.XX) and (MCY = Myself.m_nCurrY) then begin
           if not g_MySelf.m_boIsShop {¿ªµê²»ÔÊÐí²Ù×÷} then begin
             if (g_nMouseCurrX = (g_MySelf.m_nCurrX)) and (g_nMouseCurrY = (g_MySelf.m_nCurrY)) then begin
               //tdir := GetNextDirection (g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nMouseCurrX, g_nMouseCurrY);
               if CanNextAction and ServerAcceptNextAction then begin
                  SendPickup; //¼ñÎïÆ·
               end;
             end else
             if GetTickCount - g_dwLastAttackTick > 1000 then begin //×îºó¹¥»÷²Ù×÷Í£ÁôÖ¸¶¨Ê±¼ä²ÅÄÜÒÆ¶¯
                if ssCtrl in Shift then begin
                   g_ChrAction := caRun;
                end else begin
                   g_ChrAction := caWalk;
                end;
                g_nTargetX := g_nMouseCurrX;
                g_nTargetY := g_nMouseCurrY;
             end;
           end;
         end;
      end;
   end;
end;

procedure TfrmMain.DXDrawDblClick(Sender: TObject);
var
   pt: TPoint;
begin
   GetCursorPos (pt);
   pt:= ScreenToClient(pt);
   if g_DWinMan.DblClick (pt.X, pt.Y) then exit;
end;

function  TfrmMain.CheckDoorAction (dx, dy: integer): Boolean;
var
   door: integer;
begin
   Result := FALSE;
   door := Map.GetDoor (dx, dy);
   if door > 0 then begin
      if not Map.IsDoorOpen (dx, dy) then begin
         SendClientMessage (CM_OPENDOOR, door, dx, dy, 0);
         Result := TRUE;
      end;
   end;
end;
{$REGION '¼ì²â×ÔÉí×Ó´°Ìå'}
{
procedure TfrmMain.CheckHanld;
var
  ACaption: array[0..254] of Char;
  AHandle : THandle;
  Buf, Buf1: array[0..254] of Char;
begin
  AHandle := GetActiveWindow;
  GetWindowText(AHandle, ACaption, 255);
  if AHandle <> 0 then begin
    if ACaption <> '' then begin
      GetClassName(AHandle, Buf, 255); // µÃµ½ÀàÃû
      GetClassName(frmMain.Handle, Buf1, 255);//Ö÷´°¿ÚÀàÃû
      if (StrPas(Buf) <> sBrowser) and (StrPas(Buf) <> StrPas(Buf1)) then begin
        //PlayScene.MemoLog.Lines.Add('¾ä±ú:'+IntToStr(AHandle)+'/' + ACaption+'/'+ Buf+'/'+Buf1);
        asm //¹Ø±Õ³ÌÐò
          MOV FS:[0],0;
          MOV DS:[0],EAX;
        end;
      end;
    end else begin
      asm //¹Ø±Õ³ÌÐò
        MOV FS:[0],0;
        MOV DS:[0],EAX;
      end;
    end;
  end;
end;
}
{$ENDREGION}

procedure TfrmMain.DXDrawMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   if g_DWinMan.MouseUp (Button, Shift, X, Y) then exit;
   g_nTargetX := -1;
end;

procedure TfrmMain.DXDrawClick(Sender: TObject);
var
   pt: TPoint;
begin
   GetCursorPos (pt);
   pt:= ScreenToClient(pt);
   if g_DWinMan.Click (pt.X, pt.Y) then Exit;
end;

//Êó±êÊÂ¼þ:µ±Ñ¡ÔñÁËÄ§·¨µÈ¹¥»÷Ç°£¬ÏÔÊ¾Ò»¸öÑ¡Ôñ±»¹¥»÷¶ÔÏóµÄÊó±ê
procedure TfrmMain.MouseTimerTimer(Sender: TObject);
var
   I: Integer;
   pt: TPoint;
   keyvalue: TKeyBoardState;
   shift: TShiftState;
begin
   if GetCursorPos (pt) then
     SetCursorPos (pt.X, pt.Y);
   if g_TargetCret <> nil then begin
      if ActionKey > 0 then begin
         ProcessKeyMessages;
      end else begin
         if not g_TargetCret.m_boDeath and PlayScene.IsValidActor(g_TargetCret) then begin
            FillChar(keyvalue, sizeof(TKeyboardState), #0);
            if GetKeyboardState (keyvalue) then begin
               shift := [];
               if ((keyvalue[VK_SHIFT] and $80) <> 0) then shift := shift + [ssShift];
               if ((g_TargetCret.m_btRace <> RCC_USERHUMAN) and
                   (g_TargetCret.m_btRace <> 1) and //Ó¢ÐÛ 20080629
                   (g_TargetCret.m_btRace <> 150) and //ÈËÐÍ 20080629
                   (g_TargetCret.m_btRace <> RCC_GUARD) and
                   (g_TargetCret.m_btRace <> RCC_MERCHANT) and
                   (pos('(', g_TargetCret.m_sUserName) = 0) //±¦±¦
                  )
                  or (g_TargetCret.m_nNameColor = ENEMYCOLOR)   //ÀûÀº ÀÚµ¿ °ø°ÝÀÌ µÊ
                  or ((ssShift in Shift) and (not PlayScene.EdChat.Visible))
                  or g_boNoShift  //ÃâShift
                  then begin //»ç¶÷À» ½Ç¼ö·Î °ø°ÝÇÏ´Â °ÍÀ» ¸·À½
                  AttackTarget (g_TargetCret);
               end; //else begin
                  //TargetCret := nil;
               //end
            end;
         end else
            g_TargetCret := nil;
      end;
   end;
   if g_boAutoDig then begin  //×Ô¶¯ÍÚ¿ó
      if CanNextAction and ServerAcceptNextAction and CanNextHit then begin
         g_MySelf.SendMsg (CM_HIT+1, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_MySelf.m_btDir, 0, 0, '', 0, g_nilFeature);
      end;
   end;
   //×Ô¶¯¼ñÈ¡
   if {g_boAutoPuckUpItem and }(g_MySelf <> nil) and ((GetTickCount() - g_dwAutoPickupTick) > 200) then begin
     g_dwAutoPickupTick:=GetTickCount();
     AutoPickUpItem();
   end;
   NearActor;
   AutoEatItem;
   AutoHeroEatItem;
   AutoButch();
   //³Ö¾ÃÁ¦¾¯¸æ
  if ((GetTickCount - g_SHowWarningDura) > 180000{3·ÖÖÓ}) and g_boDuraWarning then begin
    for i := 14 downto 0 do begin
      if (g_UseItems[i].s.Name <> '') then begin
        if (i = 5) and (g_UseItems[5].s.StdMode = 25) then continue;
        if i = U_BUJUK then continue;
        if g_UseItems[i].DuraMax > 0 then
        if Round((g_UseItems[i].Dura / g_UseItems[i].DuraMax) * 100) < 30 then begin
          if (I = U_CHARM) and (g_UseItems[I].s.Shape in [1..3]) then  //ÆøÑªÊ¯
            DScreen.AddChatBoardString('ÌáÊ¾:ÄúµÄ['+g_UseItems[i].s.Name +']³Ö¾ÃÁ¦µÍÓÚ30%,½¨ÒéÖØÐÂÔÚÉÌÆÌ¹ºÂò!',ClRed, ClWhite)
          else
            DScreen.AddChatBoardString('ÌáÊ¾:ÄúµÄ['+g_UseItems[i].s.Name +']³Ö¾ÃÁ¦µÍÓÚ30%,Çë¼°Ê±½øÐÐÐÞÀí!',ClRed, ClWhite);
        end;
      end;
    end;
    for i := 14 downto 0 do begin
      if (g_HeroItems[i].s.Name <> '') then begin
        if i = U_BUJUK then continue;
        if Round((g_HeroItems[i].Dura / g_HeroItems[i].DuraMax) * 100) < 30 then begin
          if (I = U_CHARM) and (g_HeroItems[I].s.Shape in [1..3]) then  //ÆøÑªÊ¯
            DScreen.AddChatBoardString('ÌáÊ¾:Ó¢ÐÛµÄ['+g_HeroItems[i].s.Name +']³Ö¾ÃÁ¦µÍÓÚ30%,½¨ÒéÖØÐÂÔÚÉÌÆÌ¹ºÂò!',ClRed, ClWhite)
          else
            DScreen.AddChatBoardString('ÌáÊ¾:Ó¢ÐÛµÄ['+g_HeroItems[i].s.Name +']³Ö¾ÃÁ¦µÍÓÚ30%,Çë¼°Ê±½øÐÐÐÞÀí!',ClRed, ClWhite);
        end;
      end;
    end;
    g_SHowWarningDura:= GetTickCount;
  end;

  if g_boAutoMagic and (g_nAutoMagicKey >= 112) then begin
    if g_MySelf.m_boDeath then Exit;
    if g_nAutoMagicTime < 2 then g_nAutoMagicTime := 2;
    if (GetTickCount - g_nAutoMagicTimeKick > (g_nAutoMagicTime * 1000)) then begin
      ActionKey := g_nAutoMAgicKey;
      g_nAutoMagicTimeKick := GetTickCount;
    end;
  end; 
end;

procedure TfrmMain.AutoPickUpItem;
var
  I: Integer;
  DropItem:pTDropItem;
  ShowItem:pTShowItem1;
begin
  if CanNextAction and ServerAcceptNextAction then begin
    if g_AutoPickupList = nil then Exit;
    g_AutoPickupList.Clear;
    PlayScene.GetXYDropItemsList(g_MySelf.m_nCurrX,g_MySelf.m_nCurrY,g_AutoPickupList);

    if g_AutoPickupList.Count > 0 then begin//20080629
      for I := 0 to g_AutoPickupList.Count - 1 do begin
        DropItem := g_AutoPickupList.Items[I];
        if DropItem <> nil then begin
          if g_boAutoPuckUpItem then begin
            SendPickup;
            Break;
          end else begin
            ShowItem := g_ShowItemList.Find(DropItem.Name);
            if (ShowItem <> nil) and ShowItem.boPickup then begin
              SendPickup;
              break;
            end else if ShowItem = nil then begin
              SendPickup;
              Break;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TfrmMain.WaitMsgTimerTimer(Sender: TObject);
begin
   if g_MySelf = nil then exit;
   if g_MySelf.ActionFinished then begin
      WaitMsgTimer.Enabled := FALSE;
      if WaitingMsg.Ident = SM_CHANGEMAP then begin
            LegendMap.StartFind := False; //Í£Ö¹Ñ°Â·
            AutoFindPathTimer.Enabled := False;
            
             g_boMapMovingWait := FALSE;
             g_boMapMoving := FALSE;
             if g_nMDlgX <> -1 then begin
                FrmDlg.CloseMDlg;
                FrmDlg.CloseMBigDlg;
                g_nMDlgX := -1;
             end;
             ClearDropItems;
             //PlayScene.CleanObjects; ÏûÏ¢ÖØ¸´ 20080820
             g_sMapTitle := '';
             FrmDlg.DSighIcon.Visible := False; //»»µØÍ¼Çå³ý¸ÐÌ¾ºÅÍ¼±ê
             g_MySelf.CleanCharMapSetting (WaitingMsg.Param, WaitingMsg.Tag);
             PlayScene.SendMsg (SM_CHANGEMAP, 0,
                                  WaitingMsg.Param{x},
                                  WaitingMsg.tag{y},
                                  WaitingMsg.Series{darkness},
                                  0, 0, 0, g_nilFeature, 
                                  WaitingStr{mapname});
             g_nTargetX := -1;
             //g_TargetCret := nil;  ÏûÏ¢ÖØ¸´ 20080820
             //g_FocusCret := nil;
      end;
   end;
end;



{----------------------- Socket -----------------------}
//ÔÚÑ¡Ôñ·þÎñÆ÷ºó¿ªÆô£¬µÈ´ýÒ»¶ÎÊ±¼äºó½øÈëÑ¡Ôñ½ÇÉ«×´Ì¬£¨µÈ´ý¡°¿ªÃÅ¡±µÄ¶¯»­Íê³É£©
procedure TfrmMain.SelChrWaitTimerTimer(Sender: TObject);
begin
   SelChrWaitTimer.Enabled := FALSE;
   SendQueryChr(1);
end;

procedure TfrmMain.ActiveCmdTimer (cmd: TTimerCommand);
begin
   CmdTimer.Enabled := TRUE;
   TimerCmd := cmd;
end;
//´¦Àí¸úÍøÂçÁ¬½ÓÓÐ¹ØµÄ¼¸¸öÊÂ¼þ
procedure TfrmMain.CmdTimerTimer(Sender: TObject);
begin
  CmdTimer.Enabled := FALSE;
  //CmdTimer.Interval := 2000;
  CmdTimer.Interval := 500; //20080331
  case TimerCmd of
    tcSoftClose: begin //¶Ï¿ªÁ¬½Ó
        CmdTimer.Enabled := FALSE;
        //DebugOutStr('ConnectClose: A');
        CSocket.Socket.Close;
    end;
    tcReSelConnect: begin
      ResetGameVariables;  //Çå³ýËùÓÐ¶ÔÏó
      DScreen.ChangeScene (stSelectChr); //·µ»Øµ½Ñ¡Ôñ½ÇÉ«×´Ì¬
      g_ConnectionStep := cnsReSelChr;   //ÖØÐÂÁ¬½Ó·þÎñÆ÷
      //if not BoOneClick then begin
        with CSocket do begin
          Active := FALSE;
          Address := g_sSelChrAddr;
          Port := g_nSelChrPort;
          Active := TRUE;
        end;
      {end else begin
        if CSocket.Socket.Connected then
          CSocket.Socket.SendText ('$S' + g_sSelChrAddr + '/' + IntToStr(g_nSelChrPort) + '%');
        CmdTimer.Interval := 1;
        ActiveCmdTimer (tcFastQueryChr);
      end;  }
    end;
    tcFastQueryChr: begin//²éÑ¯½ÇÉ«
      SendQueryChr(0);
    end;
  end;
end;

procedure TfrmMain.CloseAllWindows;
var
  i: Integer;
begin
  DScreen.m_boCountDown := False;
  DScreen.m_boHeroCountDown := False;
  with FrmDlg do begin
    DItemBag.Visible := FALSE;
    DMsgDlg.Visible := FALSE;
    DStateWin.Visible := FALSE;  //ÈËÎïÐÅÏ¢À¸
    DMerchantDlg.Visible := FALSE;
    DSellDlg.Visible := FALSE;
    DMenuDlg.Visible := FALSE;
    DKeySelDlg.Visible := FALSE;
    DGroupDlg.Visible := FALSE;
    DBigMerchantDlg.Visible := FALSE;
    DDealDlg.Visible := FALSE;
    DWChallenge.Visible := False;
    DDealRemoteDlg.Visible := FALSE;
    DGuildDlg.Visible := FALSE;
    DGuildEditNotice.Visible := FALSE;
    DUserState1.Visible := FALSE;
    DAdjustAbility.Visible := FALSE;
    DBoxs.Visible := FALSE;
    DWJenniferLongBox.Visible := False;
    DLieDragon.Visible := FALSE;
    DWinBatterRandom.Visible := False;
    DLieDragonNpc.Visible := FALSE;
    DWMiniMap.Visible := False;
    DWStall.Visible := False;
    FrmDlg1.DWRefineDrum.Visible := False;
    FrmDlg1.DWSignedItemNew.Visible := False;
    DWWStallPrice.Visible := False;
    DWUserStall.Visible := False;
    DWMission.Visible := False;
    {$IF M2Version <> 2}
    DBNewWinBatterRandom.Visible := False;
    DBNewHeroBatterRandom.Visible := False;
    g_nProficiency := 0;
    g_btEnergyValue := 0;
    g_btLuckyValue := 0;
    DWSignedItems.Visible := False;
    DWMakeSigned.Visible := False;
    g_nJudgePrice := 0;
    g_boJudgeUseGold := False;
    DWJudgeItems.Visible := False;
    g_boMySelfTitleFense := False;
    DWPFLingPai.Visible := False;
    DWZZLingPai.Visible := False;
    DWFactionAddDlg.visible := False;
    DWFactionDlg.Visible := False;
    if g_FactionDlg.NoticeList <> nil then FreeAndNil(g_FactionDlg.NoticeList);
    FactionMemberListFree();
    DWFactionDlgEditNotice.Visible := False;
    DWLingWUXinFa.Visible := False;
    DWLingWuXinFaKey.Visible := False;

    DWNewStateWin.Visible := False;
    DPNewStateWinTab.ActivePage := 0;
    DPNewStateWinPage.ActivePage := 0;
    DPNewStateWinNGPage.ActivePage := 0;
    DPNewStateWinXFPage.ActivePage := 0;
    DBNewStateTab1.Visible := False;
    DBNewStateTab2.Visible := False;
    DBNewStateTab3.Visible := False;
    DWNewStateUser.Visible := False;


    DWNewStateHero.Visible := False;
    DPNewStateHeroTab.ActivePage := 0;
    DPNewStateHeroPage.ActivePage := 0;
    DPNewStateHeroNGPage.ActivePage := 0;
    DBNewStateHeroTab1.Visible := False;
    DBNewStateHeroTab2.Visible := False;
    {$IFEND}
    FillChar (g_BoxsItems, sizeof(TClientItem)*12, #0); //Çå¿Õ±¦Ïä¸ñÀïµÄÎïÆ·
    FillChar (g_JLBoxItems, SizeOf(TBoxsInfo)*8, #0); //Õäçç±¦Ïä
    FillChar (g_JLBoxFreeItems, SizeOf(TJLBoxFreeItem)*20, #0); //Õäçç±¦ÏäÃâ·Ñ½±Àø
    FillChar (g_SellOffItems, sizeof(TClientItem)*9, #0); //ÊÍ·Å¼ÄÊÛ´°¿ÚÎïÆ· 20080318
    FillChar (g_ShopItems, SizeOf(TShopItem)*10, #0); //°ÚÌ¯
    FillChar (g_UserShopItem, SizeOf(TShopItem)*10, #0); //°ÚÌ¯
    FillChar (g_GetHeroData, sizeof(THeroDataInfo) *2,#0);  //20080514
    FillChar (g_GetDeputyHeroData, sizeof(THeroDataInfo) *2,#0); 
    FillChar (g_HumanPulseArr, SizeOf(THumanPulseInfo), #0);//³õÊ¼ÈËÎïÂöÑ¨
    DWiGetHero.Visible := False;
    DPlayDrink.Visible := False;
    DWPleaseDrink.Visible := False;
    DStateTab.Visible := False;
    DHeroStateTab.Visible := False;
    DWSellOff.Visible := False;
    //DBotMemo.Visible := False;
    DWNewSdoAssistant.Visible := False;
    DShop.Visible := False;
    DItemsUp.Visible := False;
    DFriendDlg.Visible := False;
    DWMakeWineDesk.Visible := False;
    DDrunkScale.Visible := False;
    DWLevelOrder.Visible := False;
    DSighIcon.Visible := False; //Òþ²Ø¸ÐÌ¾ºÅÍ¼±ê
    DWExpCrystal.Visible := False;
    DWNQState.Visible := False;
    DWKimNeedle.Visible := False;//½ðÕë¶ÍÔì
    DWWhisper.Visible := False;
    DWSkillMemo.Visible := False;
    DWHeroSkillMemo.Visible := False;
    FillChar (g_ItemsUpItem, sizeof(TClientItem)*3, #0); //Çå¿Õ´ãÁ¶¸ñÀïµÄÎïÆ·
    FillChar (g_PDrinkItem, sizeof(TClientItem)*2, #0);
    FillChar (g_WineItem, sizeof(TClientItem)*7, #0);
    FillChar (g_KimNeedleItem, sizeof(TClientItem)*8, #0);

    {$IF M2Version <> 2}
    FillChar (g_SignedItem, SizeOf(TClientItem)*2, #0);
    FillChar (g_MakeSignedBelt, SizeOf(TClientItem)*2, #0);
    FillChar (g_MakeSignedBelt3, SizeOf(TClientItem), #0);
    FillChar (g_JudgeItems, Sizeof(TClientItem), #0);
    FillChar (g_ClientHumTitles, SizeOf(TClientHumTitles), #0);//³õÊ¼³ÆºÅ
    if g_XinFaMagic.Count > 0 then begin
      for I:=0 to g_XinFaMagic.Count-1 do
      Dispose (PTClientMagic (g_XinFaMagic[i]));
      g_XinFaMagic.Clear;
    end;
    g_boXinFaType := False;
    g_boShowXinFaAbsorb := False;
    g_MouseTitleList.Clear;
    g_MouseUserTitleList.Clear;
    DMemoXinFaHint.Lines.Clear;
    {$IFEND}

    {$IF M2Version = 1}
    FillChar (g_QJPracticeItems, SizeOf(TClientItem), #0);
    DWQJPractice.Visible := False;
    DWQJFurnace.Visible := False;
    g_boQJDZXY99 := False;
    g_boQJHeroDZXY99 := False;
    {$IFEND}
    FillChar (g_WinBatterTopMagic, sizeof(TClientMagic)*4, #0);
    FillChar (g_DrugWineItem, sizeof(TClientItem)*3, #0);
    FillChar (g_HeroBatterTopMagic, sizeof(TClientMagic)*4, #0);
    ShowBoxsGird(False,g_boNewBoxs); //Òþ²Ø±¦Ïä¸ñ
    g_BoxsShowPosition := -1;
    g_boIsInternalForce := False;
    g_boIsHeroInternalForce := False;
    g_dwInternalForceLevel := 0;
    g_dwHeroInternalForceLevel := 0;
    g_nInternalRecovery := 0; //ÄÚ¹¦»Ö¸´ËÙ¶È
    g_nHeroInternalRecovery := 0; //Ó¢ÐÛÄÚ¹¦»Ö¸´ËÙ¶È
    g_nInternalHurtAdd := 0; //ÄÚ¹¦ÉËº¦Ôö¼Ó
    g_nHeroInternalHurtAdd := 0; //Ó¢ÐÛÄÚ¹¦ÉËº¦Ôö¼Ó
    g_nInternalHurtRelief := 0; //ÄÚ¹¦»Ö¸´¼õÃâ
    g_nHeroInternalHurtRelief := 0; //Ó¢ÐÛÄÚ¹¦»Ö¸´¼õÃâ

    StatePulsePage := 0;
    FrmDlg.StateTab := 0;
    g_btPulseOriginPage := 0; //m2·¢µÄÔ­µãÁÁ¹âÒ³
    g_btPulsePoint := 0; //m2·¢À´µÄÑ¨Î»
    g_btPulseLevel := 0; //m2·¢À´µÄÑ¨Î»µÈ¼¶
    FrmDlg.DStateWinPulse.Visible := False;
    FrmDlg.DHeroStateWinPulse.Visible := False;
    FrmDlg.DStateWinBatter.Visible := False;
    g_boBoxsShowPosition:= False;//³õÊ¼×ª¶¯±äÁ¿ 20090531
    FrmDlg.DWPetLog.Visible := False;
    if g_InternalForceMagicList.Count > 0 then begin
      for I:=0 to g_InternalForceMagicList.Count-1 do
      Dispose (PTClientMagic (g_InternalForceMagicList[i]));
      g_InternalForceMagicList.Clear;
    end;
    if g_HeroInternalForceMagicList.Count > 0 then begin
      for I:=0 to g_HeroInternalForceMagicList.Count-1 do
      Dispose (PTClientMagic (g_HeroInternalForceMagicList[i]));
      g_HeroInternalForceMagicList.Clear;
    end;
    if g_WinBatterMagicList.Count > 0 then begin
      for I:=0 to g_WinBatterMagicList.Count-1 do
      Dispose (PTClientMagic (g_WinBatterMagicList[i]));
      g_WinBatterMagicList.Clear;
    end;

    if g_HeroBatterMagicList.Count > 0 then begin
      for I:=0 to g_HeroBatterMagicList.Count -1 do
      Dispose (PTClientMagic(g_HeroBatterMagicList[I]));
      g_HeroBatterMagicList.Clear;
    end;
    g_RefuseCRY := True;
    DBRefuseCRY.SetImgIndex(g_WMain3Images,282);
    if g_PetDlg.sLogList <> nil then FreeAndNil(g_PetDlg.sLogList);
    {d := g_WMain3Images.Images[207];
    if d <> nil then
    DStateWin.SetImgIndex (g_WMain3Images, 207); //ÈËÎï×´Ì¬  4¸ñÍ¼
    d := g_WMain3Images.Images[384];
    if d <> nil then
    DStateHero.SetImgIndex (g_WMain3Images, 384); //ÈËÎï×´Ì¬  4¸ñÍ¼ }

    g_HeroSelf           :=nil;
    if g_HeroSelf = nil then begin
      DStateHero.Visible := FALSE; //Ó¢ÐÛÐÅÏ¢À¸
      DBHeroSpleenImg.Visible := FALSE; //Ó¢ÐÛÅ­Æø
      DHeroItemBag.Visible := FALSE; //Ó¢ÐÛ°ü¹ü
      DHeroIcon.Visible := FALSE; //Ó¢ÐÛÍ¼±ê
      DHeroStateWinPulse.Visible := False;
      DHeroStateWinBatter.Visible := False;
      HeroStateTab := 0;
      HeroStatePage := 0;
      HeroPageChanged;
      HeroInternalForcePage := 0;
      FrmDlg.HeroInternalForcePageChanged;
      g_HeroBatterDesc.sName := '';
      FillChar (g_HeroItems, sizeof(TClientItem)*U_TakeItemCount, #0);
      FillChar (g_HeroItemArr, sizeof(TClientItem)*MAXBAGITEMCL, #0);
      //Çå¿ÕÓ¢ÐÛÄ§·¨
      if g_HeroMagicList.Count > 0 then //20080629
      for i:=0 to g_HeroMagicList.Count-1 do
      Dispose (PTClientMagic (g_HeroMagicList[i]));
      g_HeroMagicList.Clear;
      FillChar (g_HeroHumanPulseArr, SizeOf(THeroPulseInfo1), #0);//³õÊ¼Ó¢ÐÛÂöÑ¨
      g_btHeroStateWinPulseMoving := 0;
      g_boHeroStateWinPulseDowning := False;
      g_btHeroPulseOriginPage:= 0; //m2·¢µÄÔ­µãÁÁ¹âÒ³
      g_btHeroPulsePoint:=0; //m2·¢À´µÄÑ¨Î»
      g_btHeroPulseLevel:=0; //m2·¢À´µÄÑ¨Î»µÈ¼¶
      g_boHeroPulseOpen:= False; //Ó¢ÐÛ¾­ÂöÊÇ·ñ¿ªÍ¨
      g_dwHeroPulsExp:=0; //Ó¢ÐÛµÄ¾­Ñé±äÁ¿
      if g_HeroBatterMagicList.Count > 0 then begin
        for I:=0 to g_HeroBatterMagicList.Count - 1 do begin
          if pTClientMagic(g_HeroBatterMagicList.Items[I]) <> nil then
            Dispose(pTClientMagic(g_HeroBatterMagicList.Items[I]));
        end;
      end;
      g_HeroBatterMagicList.Clear;
      FillChar (g_HeroBatterTopMagic, sizeof(TClientMagic)*4, #0);
      FrmDlg.DBCallHero.ShowHint := True; //Ä£Ê½±äÎªÓ¢ÐÛÍË³ö
    end;
    DCheckHeroBatterNotMob.Checked := False;
  end;
  if g_nMDlgX <> -1 then begin
    FrmDlg.CloseMDlg;
    FrmDlg.CloseMBigDlg;
    g_nMDlgX := -1;
  end;
  g_boItemMoving := FALSE;  //
  g_boHeroItemMoving :=FALSE;
end;

procedure TfrmMain.ClearDropItems;
var
  I:Integer;
begin
  if g_DropedItemList.Count > 0 then begin//20080629
    for I:=0 to g_DropedItemList.Count - 1 do begin
      Dispose (PTDropItem(g_DropedItemList[I]));
    end;
    g_DropedItemList.Clear;
  end;
end;

procedure TfrmMain.ResetGameVariables;
var
   i: integer;
begin
  try
    CloseAllWindows;
    ClearDropItems;
    if g_MagicList.Count > 0 then begin//20080629
      for i:=0 to g_MagicList.Count - 1  do begin
      if pTClientMagic(g_MagicList[i]) <> nil then
        Dispose(pTClientMagic(g_MagicList[i]));
      end;
      g_MagicList.Clear;
    end;
    g_boItemMoving := FALSE;
    g_WaitingUseItem.Item.S.Name := '';
    g_EatingItem.S.name := '';
    g_SelfShopItem.s.Name := '';
    g_nTargetX := -1;
    g_nCreditPoint := 0;
    g_TargetCret := nil;
    g_FocusCret := nil;
    g_MagicTarget := nil;
    ActionLock := FALSE;
    g_AutoMagicTime := 0;
    g_AutoMagicLock := False;
    g_GroupMembers.Clear;
    g_sGuildRankName := '';
    g_sGuildName := '';
    g_FriendList.Clear;
    g_HeiMingDanList.Clear;
    g_TargetList.Clear;
    g_boMapMoving := FALSE;
    WaitMsgTimer.Enabled := FALSE;
    g_boMapMovingWait := FALSE;
    DScreen.ChatBoardTop := 0;
    g_boNextTimePowerHit := FALSE;
    g_boCanUseBatter := False;
    g_boCanLongHit := FALSE;
    g_boCanLongHit4 := FALSE;
    g_boCanWideHit := FALSE;
    g_boCanWideHit4 := False;
    g_boCanCrsHit   := False;
    g_boCanTwnHit   := False; //¹Ø±Õ¿ªÌìÕ¶ÖØ»÷
    g_boCanQTwnHit  := False; //¹Ø±Õ¿ªÌìÕ¶Çá»÷
    g_boCanCIDHit   := False; //¹Ø±ÕÁúÓ°½£·¨
    g_boCanCXCHit1   := False; //¹Ø±Õ×·ÐÄ´Ì
    g_boCanCXCHit2   := False; //¹Ø±ÕÈý¾øÉ±
    g_boCanCXCHit3   := False; //¹Ø±ÕºáÉ¨Ç§¾ü
    g_boCanCXCHit4   := False; //¹Ø±Õ¶ÏÔÀÕ¶
    g_boNextTimeFireHit := FALSE; //¹Ø±ÕÁÒ»ð
    g_boOpen4BatterSkill := False;
    //g_boCan69Hit := False;
    g_boNextTime4FireHit := FALSE; //¹Ø±Õ4¼¶ÁÒ»ð
    FillChar (g_UseItems, sizeof(TClientItem)*U_TakeItemCount, #0);  //2008.01.16 ÐÞÕý  Ô­Îª9
    {$IF M2Version <> 2}
    g_btNQLevel:= 1;   //Å£ÆøµÈ¼¶ 20090520
    g_dwNQExp:= 0; //Å£Æøµ±Ç°¾­Ñé 20090520
    g_dwNQMaxExp:= 0; //Å£ÆøÉý¼¶¾­Ñé 20090520
    FillChar (g_LingMeiBelt, SizeOf(TClientItem), #0); //ÁéÃ½
    FillChar (g_MyHeroSuitAbility, SizeOf(TClientSuitAbility), #0);
    FillChar (g_HeartAbility, SizeOf(TClientHeartAbility), #0);
    {$IFEND}
    FillChar (g_BoxsItems, sizeof(TClientItem)*12, #0);  //±¦ÏäÎïÆ·ÊÍ·Å 2008.01.16
    FillChar (g_JLBoxItems, SizeOf(TBoxsInfo)*8, #0); //Õäçç±¦Ïä
    FillChar (g_JLBoxFreeItems, SizeOf(TJLBoxFreeItem)*20, #0); //Õäçç±¦ÏäÃâ·Ñ½±Àø
    FillChar (g_SellOffItems, sizeof(TClientItem)*9, #0); //ÊÍ·Å¼ÄÊÛ´°¿ÚÎïÆ· 20080318
    FillChar (g_ShopItems, SizeOf(TShopItem)*10, #0); //°ÚÌ¯
    FillChar (g_UserShopItem, SizeOf(TShopItem)*10, #0); //°ÚÌ¯
    FillChar (g_MySelfSuitAbility, SizeOf(TClientSuitAbility), #0);
    FillChar (g_ItemArr, sizeof(TItemArr)*MAXBAGITEMCL, #0);
    with SelectChrScene do begin
      FillChar (ChrArr, sizeof(TSelChar)*2, #0);
      ChrArr[0].FreezeState := TRUE; //±âº»ÀÌ ¾ó¾î ÀÖ´Â »óÅÂ
      ChrArr[1].FreezeState := TRUE;
    end;
    PlayScene.ClearActors;
    ClearDropItems;
    EventMan.ClearEvents;
    PlayScene.CleanObjects;
    //DxDrawRestoreSurface (self);
    g_MySelf := nil;
    g_HeroSelf := nil;
  except
  end;
end;

procedure TfrmMain.ChangeServerClearGameVariables;
var
   i: integer;
begin
   CloseAllWindows;
   ClearDropItems;
   if g_MagicList.Count > 0 then //20080629
   for i:=0 to g_MagicList.Count-1 do
      Dispose (PTClientMagic (g_MagicList[i]));
   g_MagicList.Clear;
   g_boItemMoving := FALSE;
   g_WaitingUseItem.Item.S.Name := '';
   g_EatingItem.S.name := '';
   g_nTargetX := -1;
   g_TargetCret := nil;
   g_FocusCret := nil;
   g_MagicTarget := nil;
   ActionLock := FALSE;
   g_AutoMagicTime := 0;
   g_AutoMagicLock := False;
   g_GroupMembers.Clear;
   g_sGuildRankName := '';
   g_sGuildName := '';
   g_FriendList.Clear;
   g_HeiMingDanList.Clear;
   g_TargetList.Clear;
   g_boMapMoving := FALSE;
   WaitMsgTimer.Enabled := FALSE;
   g_boMapMovingWait := FALSE;
   g_boNextTimePowerHit := FALSE;
   g_boCanLongHit := FALSE;
   g_boCanLongHit4 := FALSE;
   g_boCanWideHit := FALSE;
   g_boCanWideHit4 := False;
   g_boCanCrsHit   := False;
   g_boCanTwnHit   := False; //¹Ø±Õ¿ªÌìÕ¶ ÖØ»÷
   g_boCanQTwnHit  := False; //¹Ø±Õ¿ªÌìÕ¶ Çá»÷  2008.02.12
   g_boCanCIDHit   := False;
   g_boCanCXCHit1   := False; //¹Ø±Õ×·ÐÄ´Ì
   g_boCanCXCHit2   := False; //¹Ø±ÕÈý¾øÉ±
   g_boCanCXCHit3   := False; //¹Ø±ÕºáÉ¨Ç§¾ü
   g_boCanCXCHit4   := False; //¹Ø±Õ¶ÏÔÀÕ¶
   g_boOpen4BatterSkill := False;
   ClearDropItems;
   EventMan.ClearEvents;
   PlayScene.CleanObjects;
end;

procedure TfrmMain.SendHardwareCode;
var
  MachineId: array[1..40] of Byte;
  msg: TDefaultMessage;
  nCode: DWord;
begin
{$I VM_Start.inc} //ÐéÄâ»ú±êÊ¶
  {if WLProtectCheckDebugger then begin //¼ì²âµ÷ÊÔÆ÷´æÔÚÄÚ´æÖÐ
    asm //¹Ø±Õ³ÌÐò
      MOV FS:[0],0;
      MOV DS:[0],EAX;
    end;
  end; }
  WLHardwareGetID(PChar(@MachineId)); //È¡Ó²¼þID

  msg := MakeDefaultMsg(CM_HARDWARECODE, 0, 0, 0, 0, m_nSendMsgCount);
  msg.Recog := MakeLong(MakeWord(MachineId[21] xor MachineId[22] or MachineId[23], MachineId[24] xor
    MachineId[26] or MachineId[27]), MakeWord(MachineId[28] xor MachineId[29] or
    MachineId[31], MachineId[32] xor MachineId[33] or MachineId[34]));

  nCode := MakeLong(MakeWord(((MachineId[1] xor MachineId[2]) shl (MachineId[3] mod 2)) shr (MachineId[4] mod 2),
    ((MachineId[6] or MachineId[7]) shl (MachineId[8] mod 2)) shr (MachineId[9] mod 2)), MakeWord(
    ((MachineId[11] xor MachineId[12]) shl (MachineId[13] mod 2)) shr (MachineId[14] mod 2),
    ((MachineId[16] or MachineId[17]) shl (MachineId[18] mod 2)) shr (MachineId[19] mod 2)));
  msg.Param := MakeWord(MachineId[36] xor MachineId[37], MachineId[38] or MachineId[39]) xor Msg.Recog;
  msg.Tag := LoWord(nCode) xor msg.Param;
  msg.Series := HiWord(nCode) xor msg.Param;

{$I VM_End.inc}

  SendSocket(EncodeMessage(msg) + EncodeBuffer(@MachineId, SizeOf(MachineId)));
end;

procedure TfrmMain.CSocketConnect(Sender: TObject;
  Socket: TCustomWinSocket);
  //Ëæ»úÈ¡Ãû
  function RandomGetName():string;
  var
    s,s1:string;
    I,i0:integer;
  begin
      s:='123456789ABCDEFGHIJKLMNPQRSTUVWXYZ';
      s1:='';
      Randomize(); //Ëæ»úÖÖ×Ó
      for i:=0 to 10 do begin
        i0:=random(35);
        s1:=s1+copy(s,i0,1);
      end;
      Result := s1;
  end;
var
   packet: array[0..255] of char;
   strbuf: array[0..255] of char;
   str: string;
begin
  g_dwSocketConnectTick := GetTickCount;
  g_boServerConnected := TRUE;
  if g_ConnectionStep = cnsLogin then begin
     DScreen.ChangeScene (stIntro);
  {$IF USECURSOR = DEFAULTCURSOR}
    DxDraw.Cursor:=crDefault;
  {$IFEND}
  end;
  if g_ConnectionStep = cnsSelChr then begin
    LoginScene.OpenLoginDoor;
    SelChrWaitTimer.Enabled := TRUE;
  end;
  if g_ConnectionStep = cnsReSelChr then begin
    CmdTimer.Interval := 1;
    ActiveCmdTimer (tcFastQueryChr);
    //-------
    with FrmDlg.DscStart do begin
      Enabled := False;
      g_ReSelClientRect := FrmDlg.DscStart.ClientRect;
    end;
    g_dwReSelConnectTick := GetTickCount + 500;
    g_boReSelConnect := True;
    //------
  end;
  if g_ConnectionStep = cnsPlay then begin
    if not g_boServerChanging then begin
       ClearBag;  //ÇåÀí°ü¹ü
       DScreen.ClearChatBoard; //ÇåÀíÁÄÌìÐÅÏ¢
       DScreen.ChangeScene (stLoginNotice);
    end else begin
       ChangeServerClearGameVariables;        
    end;
    SendRunLogin;
  end;
  SocStr := '';
  BufferStr := '';
end;

procedure TfrmMain.CSocketDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  g_boServerConnected := FALSE;
  if FrmDlg.DLOGO <> nil then FrmDlg.DLOGO.Visible := False;
  CloseTimer.Enabled := True;
  if g_SoftClosed then begin
    g_SoftClosed := FALSE;
    ActiveCmdTimer (tcReSelConnect);
  end;
end;

procedure TfrmMain.CSocketError(Sender: TObject; Socket: TCustomWinSocket;
  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  ErrorCode := 0;
  //DebugOutStr('ConnectClose: B');
  Socket.Close;
end;

procedure TfrmMain.CSocketRead(Sender: TObject; Socket: TCustomWinSocket);
var
  n: integer;
  data, data2: string;
begin
  data := Socket.ReceiveText;
  n := pos('*', data);
  if n > 0 then begin //È¥µô*ºÅ
    data2 := Copy (data, 1, n-1);
    data := data2 + Copy (data, n+1, Length(data));
    CSocket.Socket.SendText ('*');
  end;
  SocStr := SocStr + data;
end;

{-------------------------------------------------------------}

procedure TfrmMain.SendSocket (sendstr: string);
const
  code: byte = 1;
var
  sSendText: String;
begin
  if CSocket.Socket.Connected then begin
    sSendText := '#' + IntToStr(code) + sendstr + '!';
    Inc (code);
    if code >= 10 then code := 1;
    while True do begin //½â¾öµô°ü
      if CSocket.Socket.SendText(sSendText) <> -1 then break;
    end;
  end;
end;


procedure TfrmMain.SendClientMessage (msg, Recog, param, tag, series: integer);
var
   dmsg: TDefaultMessage;
begin
   dmsg := MakeDefaultMsg (aa(msg, TempCertification), Recog, param, tag, series, m_nSendMsgCount);
   SendSocket (EncodeMessage (dmsg));
end;
//·¢ËÍÕËºÅÓëÃÜÂë
procedure TfrmMain.SendLogin (uid, passwd: string);
var
   msg: TDefaultMessage;
begin
   LoginId := uid;
   LoginPasswd := passwd;
   msg := MakeDefaultMsg (CM_IDPASSWORD, 0, 0, 0, 0, m_nSendMsgCount);
   SendSocket (EncodeMessage (msg) + EncodeString(uid + '/' + passwd +'/'+ g_sServerMiniName));//20090309 Ôö¼Ó·þÎñÃû
   g_boSendLogin:=True;
end;

procedure TfrmMain.SendNewAccount (ue: TUserEntry; ua: TUserEntryAdd);
var
   msg: TDefaultMessage;
begin
   MakeNewId := ue.sAccount;
   msg := MakeDefaultMsg (CM_ADDNEWUSER, 0, 0, 0, 0, m_nSendMsgCount);
   SendSocket (EncodeMessage (msg) + EncodeBuffer(@ue, sizeof(TUserEntry)) + EncodeBuffer(@ua, sizeof(TUserEntryAdd)));
end;

procedure TfrmMain.SendUpdateAccount (ue: TUserEntry; ua: TUserEntryAdd);
var
   msg: TDefaultMessage;
begin
   MakeNewId := ue.sAccount;
   msg := MakeDefaultMsg (CM_UPDATEUSER, 0, 0, 0, 0, m_nSendMsgCount);
   SendSocket (EncodeMessage (msg) + EncodeBuffer(@ue, sizeof(TUserEntry)) + EncodeBuffer(@ua, sizeof(TUserEntryAdd)));
end;

procedure TfrmMain.SendSelectServer (svname: string);
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (CM_SELECTSERVER, 0, 0, 0, 0, 0);
   {$IF GVersion <> 1}
   msg.Param := Random(1024);
   msg.nSessionID := CalcBufferCRC(@g_RunParam.sServerPassWord[1], Length(g_RunParam.sServerPassWord)) xor (msg.Param mod 16);
   msg.Recog := CalcBufferCRC(@g_RunParam.sConfigKeyWord[1], Length(g_RunParam.sConfigKeyWord)) xor (msg.Param mod 16);
   {$ifend}
   SendSocket (EncodeMessage (msg) + EncodeString(svname));
end;

procedure TfrmMain.SendChgPw (id, passwd, newpasswd: string);
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (CM_CHANGEPASSWORD, 0, 0, 0, 0, m_nSendMsgCount);
   SendSocket (EncodeMessage (msg) + EncodeString (id + #9 + passwd + #9 + newpasswd));
end;

procedure TfrmMain.SendNewChr (uid, uname, shair, sjob, ssex: string);
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (CM_NEWCHR, 0, 0, 0, 0, m_nSendMsgCount);
   SendSocket (EncodeMessage (msg) + EncodeString (uid + '/' + uname + '/' + shair + '/' + sjob + '/' + ssex));
end;

procedure TfrmMain.SendQueryChr(Code:Byte); //CodeÎª1Ôò²éÑ¯ÑéÖ¤Âë  Îª0Ôò²»²éÑ¯
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (CM_QUERYCHR, 0, 0, 0, Code, m_nSendMsgCount);
   SendSocket (EncodeMessage (msg) + EncodeString(LoginId + '/' + IntToStr(Certification)));
end;

procedure TfrmMain.SendDelChr (chrname: string);
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (CM_DELCHR, 0, 0, 0, 0, m_nSendMsgCount);
   SendSocket (EncodeMessage (msg) + EncodeString(chrname));
end;

procedure TfrmMain.SendSelChr (chrname: string);
var
   msg: TDefaultMessage;
begin
   CharName := chrname;
   msg := MakeDefaultMsg (CM_SELCHR, 0, 0, 0, 0, m_nSendMsgCount);
   SendSocket (EncodeMessage (msg) + EncodeString(LoginId + '/' + chrname));
   PlayScene.EdAccountt.Visible:=False;//2004/05/17
   PlayScene.EdChrNamet.Visible:=False;//2004/05/17
   FrmDlg.btnRecvChrCloseClick (self, 0, 0);
end;
//·¢ÏûÏ¢¸øRunGate.exe,µÇÂ½ÓÎÏ·
procedure TfrmMain.SendRunLogin;
var
  sSendMsg:String;
begin
  (*{$IF GVersion = 1}
  if g_sTArr <> sApplicationStr then begin//±»ÐÞ¸ÄÔòÍË³ö³ÌÐò
    //DebugOutStr(Format('Close:A Arr:%s  str:%s', [StrPas(@g_sTArr), sApplicationStr]));
    asm //¹Ø±Õ³ÌÐò
      MOV FS:[0],0;
      MOV DS:[0],EAX;
    end;
  end;
  {$IFEND}*)
  sSendMsg:=format('**%s/%s/%d/%d/%d',[LoginId,CharName,Certification,CLIENT_VERSION_NUMBER,RUNLOGINCODE]);
  SendSocket(EncodeString(sSendMsg));
end;

procedure TfrmMain.SendSay (str: string);
var
   msg: TDefaultMessage;
begin
  if str <> '' then begin
    if m_boPasswordIntputStatus then begin
      m_boPasswordIntputStatus      := False;
      PlayScene.EdChat.PasswordChar := #0;
      PlayScene.EdChat.Visible      := False;
      SendPassword(str,1);
      Exit;
    end;
    {$IF GVersion = 0}
    if str = ' ' then begin
      //g_boShowMemoLog:=not g_boShowMemoLog;
      PlayScene.MemoLog.Clear;
      PlayScene.MemoLog.Visible:=not PlayScene.MemoLog.Visible;
      Exit;
    end;
    if str = '@p' then begin
       //DScreen.AddCenterLetter(1,0,3000, '¹þ¹þ¹þ¹þ¹þ¹þ¹þ¹þ¹þ¹þ¹þ¹þ¹þ¹þ¹þ¹þ');
       //DScreen.AddChatBoardString ('ÓÉÓÚÄãµÄ¿Í»§¶Ë×ÊÔ´¹ý¾É£¬Ç¿»¯¼¼ÄÜ¡¢ÐÄ·¨½«ÎÞ·¨Ê¹ÓÃ£¬Çë¸üÐÂ×îÐÂ×ÊÔ´£¡',clLime, clBlack);
       FrmDlg.DStateWin.Visible := not FrmDlg.DStateWin.Visible;
      Exit;
    end;
    {$IFEND}
    if str = '@password' then begin
      if PlayScene.EdChat.PasswordChar = #0 then
         PlayScene.EdChat.PasswordChar := '*'
      else PlayScene.EdChat.PasswordChar := #0;
      Exit;
    end;
    if PlayScene.EdChat.PasswordChar = '*' then PlayScene.EdChat.PasswordChar:= #0;
    msg := MakeDefaultMsg (aa(CM_SAY, TempCertification), 0, 0, 0, 0, m_nSendMsgCount);
    SendSocket (EncodeMessage (msg) + EncodeString(str));
    if str[1] = '/' then begin
      DScreen.AddChatBoardString (str, GetRGB(180), clWhite);
      FrmDlg.AddWhisper(FormatDateTime('hh:mm:ss',Now)+ ' ' +str);
      GetValidStr3 (Copy(str,2,Length(str)-1), WhisperName, [' ']);
    end;
  end;
end;

procedure TfrmMain.SendActMsg (ident, x, y, dir: integer);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(ident, TempCertification), MakeLong(x,y), 0, dir, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg));
  ActionLock := TRUE; //¼­¹ö¿¡¼­ #+FAIL! ÀÌ³ª #+GOOD!ÀÌ ¿Ã¶§±îÁö ±â´Ù¸²
  ActionLockTime := GetTickCount;
  Inc (g_nSendCount);
end;

procedure TfrmMain.SendSpellMsg (ident, x, y, dir, target: integer; itemindex: string);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(ident, TempCertification), MakeLong(x,y), Loword(target), dir, Hiword(target), m_nSendMsgCount);
  if itemindex <> '' then
    SendSocket (EncodeMessage (msg)+ itemindex)
  else SendSocket (EncodeMessage (msg));
  ActionLock := TRUE; //¼­¹ö¿¡¼­ #+FAIL! ÀÌ³ª #+GOOD!ÀÌ ¿Ã¶§±îÁö ±â´Ù¸²
  ActionLockTime := GetTickCount;
  Inc (g_nSendCount);
end;

procedure TfrmMain.SendQueryUserName (targetid, x, y: integer);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_QUERYUSERNAME, TempCertification), targetid, x, y, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg));
end;

procedure TfrmMain.SendHeroDropItem (name: string; itemserverindex: integer);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_HERODROPITEM, TempCertification), itemserverindex, 0, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg) + EncodeString (name));
end;

procedure TfrmMain.SendDropItem (name: string; itemserverindex: integer);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_DROPITEM, TempCertification), itemserverindex, 0, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg) + EncodeString (name));
end;

procedure TfrmMain.SendPickup;
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_PICKUP, TempCertification), 0, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg));
end;

procedure TfrmMain.SendTakeOnHeroItem (where: byte; itmindex: integer; itmname: string);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_HEROTAKEONITEM, TempCertification), itmindex, where, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg) + EncodeString (itmname));
end;

procedure TfrmMain.SendTakeOnItem (where: byte; itmindex: integer; itmname: string);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_TAKEONITEM, TempCertification), itmindex, where, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg) + EncodeString (itmname));
end;

procedure TfrmMain.SendItemToMasterBag (where: byte; itmindex: integer; itmname: string);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_SENDITEMTOMASTERBAG, TempCertification), itmindex, where, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg) + EncodeString (itmname));
end;

procedure TfrmMain.SendItemToHeroBag (where: byte; itmindex: integer; itmname: string);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_SENDITEMTOHEROBAG, TempCertification), itmindex, where, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg) + EncodeString (itmname));
end;

procedure TfrmMain.SendTakeOffHeroItem (where: byte; itmindex: integer; itmname: string);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_HEROTAKEOFFITEM, TempCertification), itmindex, where, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg) + EncodeString (itmname));
end;

procedure TfrmMain.SendTakeOffItem (where: byte; itmindex: integer; itmname: string);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_TAKEOFFITEM, TempCertification), itmindex, where, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg) + EncodeString (itmname));
end;

procedure TfrmMain.SendHeroEat (itmindex: integer; itmname: string; btStdMode: Byte{ÎïÆ··ÖÀàºÅ});
var
  msg: TDefaultMessage;
begin
  if btStdMode = 0 then
    msg := MakeDefaultMsg (aa(CM_HEROEAT, TempCertification), itmindex, 1, 0, 0, m_nSendMsgCount)
  else msg := MakeDefaultMsg (aa(CM_HEROEAT, TempCertification), itmindex, 0, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg) + EncodeString (itmname));
end;

procedure TfrmMain.SendEat (itmindex: integer; itmname: string; btStdMode: Byte{ÎïÆ··ÖÀà});
var
  msg: TDefaultMessage;
begin
  if btStdMode = 0 then
    msg := MakeDefaultMsg (aa(CM_EAT, TempCertification), itmindex, 1, 0, 0, m_nSendMsgCount)
  else msg := MakeDefaultMsg (aa(CM_EAT, TempCertification), itmindex, 0, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg) + EncodeString (itmname));
end;

procedure TfrmMain.SendJNEat(itmindex, x, y: integer; itmname: string);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_EAT, TempCertification), itmindex, x, y, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg) + EncodeString (itmname));
end;


//ÍÚ¶¯ÎïÊ¬Ìå
procedure TfrmMain.SendButchAnimal (x, y, dir, actorid: integer);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_BUTCH, TempCertification), actorid, x, y, dir, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg));
end;

procedure TfrmMain.SendMagicKeyChange (magid: integer; keych: char; str: string);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_MAGICKEYCHANGE, TempCertification), magid, byte(keych), 0, 0, m_nSendMsgCount);
  if str <> '' then SendSocket (EncodeMessage (msg)+str)
  else SendSocket (EncodeMessage (msg));
end;

procedure TfrmMain.SendMerchantDlgSelect (merchant: integer; rstr: string);
var
  msg: TDefaultMessage;
  sCmd: string;
  I, II: Integer;
  Buf: array[1..1024] of Char;
begin
{$I VM_Start.inc} //ÐéÄâ»ú±êÊ¶
  rstr := GetValidStr3(rstr, sCmd, [#$D]);
  //·ÀÖ¹·Ç·¨µ÷ÓÃ´Ëº¯ÊýBy TasNat at: 2012-05-17 18:11:49
  II := -1;
  if (FrmDlg.DMerchantDlg.Visible or FrmDlg.DBigMerchantDlg.Visible) then begin

    for I := 0 to FrmDlg.MDlgPoints.Count - 1 do
      if (CompareText(PTClickPoint(FrmDlg.MDlgPoints[i]).RStr, sCmd) = 0) then begin
        II := I;
        Break;
      end;


  end else if ((FrmDlg.DLieDragon.Visible) and (sCmd = '@goHero1')) then
    II := 1;
  if II < 0 then Exit;

  msg := MakeDefaultMsg(aa(CM_MERCHANTDLGSELECT, TempCertification), merchant, 0, 0, 0, m_nSendMsgCount);
  if rstr <> '' then
    rstr := sCmd + #$D + rstr
  else
    rstr := sCmd;
  msg.Series := Length(rstr);
  for II := 1 to msg.Series do
    rstr[II] := Char(Byte(rstr[II]) xor (merchant mod II + 2));
  Move(rstr[1], Buf[1], msg.Series);
  SendSocket(EncodeMessage(msg) + EncodeBuffer(@Buf, msg.Series));
{$I VM_End.inc} //ÐéÄâ»ú±êÊ¶
end;
//Ñ¯ÎÊÎïÆ·¼Û¸ñ
procedure TfrmMain.SendQueryPrice (merchant, itemindex: integer; itemname: string);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_MERCHANTQUERYSELLPRICE, TempCertification), merchant, Loword(itemindex), Hiword(itemindex), 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg) + EncodeString (itemname));
end;
//Ñ¯ÎÊÐÞÀí¼Û¸ñ
procedure TfrmMain.SendQueryRepairCost (merchant, itemindex: integer; itemname: string);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_MERCHANTQUERYREPAIRCOST, TempCertification), merchant, Loword(itemindex), Hiword(itemindex), 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg) + EncodeString (itemname));
end;
//·¢ËÍÒª³öÊÛµÄÎïÆ·
procedure TfrmMain.SendSellItem (merchant, itemindex: integer; itemname: string);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_USERSELLITEM, TempCertification), merchant, Loword(itemindex), Hiword(itemindex), 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg) + EncodeString (itemname));
end;
//·¢ËÍÒªÐÞÀíµÄÎïÆ·
procedure TfrmMain.SendRepairItem (merchant, itemindex: integer; itemname: string);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_USERREPAIRITEM, TempCertification), merchant, Loword(itemindex), Hiword(itemindex), 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg) + EncodeString (itemname));
end;
//·¢ËÍÒª´æ·ÅµÄÎïÆ·
procedure TfrmMain.SendStorageItem (merchant, itemindex: integer; itemname: string);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_USERSTORAGEITEM, TempCertification), merchant, Loword(itemindex), Hiword(itemindex), 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg) + EncodeString (itemname));
end;

procedure TfrmMain.SendGetDetailItem (merchant, menuindex: integer; itemname: string);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_USERGETDETAILITEM, TempCertification), merchant, menuindex, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg) + EncodeString (itemname));
end;

procedure TfrmMain.SendBuyItem (merchant, itemserverindex: integer; itemname: string);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_USERBUYITEM, TempCertification), merchant, Loword(itemserverindex), Hiword(itemserverindex), 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg) + EncodeString (itemname));
end;

procedure TfrmMain.SendTakeBackStorageItem (merchant, itemserverindex: integer; itemname: string);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_USERTAKEBACKSTORAGEITEM, TempCertification), merchant, Loword(itemserverindex), Hiword(itemserverindex), 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg) + EncodeString (itemname));
end;

procedure TfrmMain.SendMakeDrugItem (merchant: integer; itemname: string);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_USERMAKEDRUGITEM, TempCertification), merchant, 0, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg) + EncodeString (itemname));
end;

procedure TfrmMain.SendDropGold (dropgold: integer);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_DROPGOLD, TempCertification), dropgold, 0, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg));
end;

procedure TfrmMain.SendGroupMode (onoff: Boolean);
var
  msg: TDefaultMessage;
begin
  if onoff then
    msg := MakeDefaultMsg (aa(CM_GROUPMODE, TempCertification), 0, 1, 0, 0, m_nSendMsgCount)   //on
  else msg := MakeDefaultMsg (aa(CM_GROUPMODE, TempCertification), 0, 0, 0, 0, m_nSendMsgCount);  //off
  SendSocket (EncodeMessage (msg));
end;

procedure TfrmMain.SendCreateGroup (withwho: string);
var
  msg: TDefaultMessage;
begin
  if withwho <> '' then begin
    msg := MakeDefaultMsg (aa(CM_CREATEGROUP, TempCertification), 0, 0, 0, 0, m_nSendMsgCount);
    SendSocket (EncodeMessage (msg) + EncodeString (withwho));
  end;
end;

procedure TfrmMain.SendWantMiniMap;
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_WANTMINIMAP, TempCertification), 0, 0, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg));
end;

procedure TfrmMain.SendDealTry;
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_DEALTRY, TempCertification), 0, 0, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg) + EncodeString (''));
end;

procedure TfrmMain.SendGuildDlg;
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_OPENGUILDDLG, TempCertification), 0, 0, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg));
end;

procedure TfrmMain.SendCancelDeal;
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_DEALCANCEL, TempCertification), 0, 0, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg));
end;

procedure TfrmMain.SendAddDealItem (ci: TClientItem);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_DEALADDITEM, TempCertification), ci.MakeIndex, 0, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg) + EncodeString (ci.S.Name));
end;

procedure TfrmMain.SendDelDealItem (ci: TClientItem);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_DEALDELITEM, TempCertification), ci.MakeIndex, 0, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg) + EncodeString (ci.S.Name));
end;
{******************************************************************************}
//Íù¼ÄÊÛ´°¿Ú¼ÓÎïÆ· ·¢ËÍµ½M2 20080316
procedure TfrmMain.SendAddSellOffItem (ci: TClientItem);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_SELLOFFADDITEM, TempCertification), ci.MakeIndex, 0, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg) + EncodeString (ci.S.Name));
end;
//Íù°ü¹üÀï·µ»ØÎïÆ· ·¢ËÍµ½M2 20080316
procedure TfrmMain.SendDelSellOffItem (ci: TClientItem);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_SELLOFFDELITEM, TempCertification), ci.MakeIndex, 0, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg) + EncodeString (ci.S.Name));
end;
//È¡Ïû¼ÄÊÛ ·¢ËÍµ½M2 20080316
procedure TfrmMain.SendCancelSellOffItem;
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_SELLOFFCANCEL, TempCertification), 0, 0, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg));
end;
//·¢ËÍ¼ÄÊÛÐÅÏ¢ ·¢ËÍµ½M2 20080316
procedure TfrmMain.SendSellOffEnd;
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_SELLOFFEND, TempCertification), g_SellOffGameGold, g_SellOffGameDiaMond, High(Word), 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg) + EncodeString(g_SellOffName));
end;
//È¡ÏûÕýÔÚ¼ÄÊÛµÄÎïÆ· ·¢ËÍµ½M2 20080316
procedure TfrmMain.SendCancelMySellOffIteming;
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_CANCELSELLOFFITEMING, TempCertification), 0, 0, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg));
end;
//È¡Ïû¼ÄÊÛÎïÆ· ÊÕ¹º ·¢ËÍµ½M2 20080318
procedure TfrmMain.SendSellOffBuyCancel;
var
  msg: TdefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_SELLOFFBUYCANCEL, TempCertification), 0, 0, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg) + EncodeString(g_SellOffInfo.sDealCharName));
end;
//¼ÄÊÛÎïÆ· È·¶¨¹ºÂò ·¢ËÍµ½M2 20080318
procedure TfrmMain.SendSellOffBuy;
var
  msg: TdefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_SELLOFFBUY, TempCertification), 0, 0, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg) + EncodeString(g_SellOffInfo.sDealCharName));
end;
{******************************************************************************}
procedure TfrmMain.SendChangeDealGold (gold: integer);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_DEALCHGGOLD, TempCertification), gold, 0, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg));
end;

procedure TfrmMain.SendDealEnd;
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_DEALEND, TempCertification), 0, 0, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg));
end;

procedure TfrmMain.SendAddGroupMember (withwho: string);
var
  msg: TDefaultMessage;
begin
  if withwho <> '' then begin
    msg := MakeDefaultMsg (aa(CM_ADDGROUPMEMBER, TempCertification), 0, 0, 0, 0, m_nSendMsgCount);
    SendSocket (EncodeMessage (msg) + EncodeString (withwho));
  end;
end;

procedure TfrmMain.SendDelGroupMember (withwho: string);
var
  msg: TDefaultMessage;
begin
  if withwho <> '' then begin
    msg := MakeDefaultMsg (aa(CM_DELGROUPMEMBER, TempCertification), 0, 0, 0, 0, m_nSendMsgCount);
    SendSocket (EncodeMessage (msg) + EncodeString (withwho));
  end;
end;

procedure TfrmMain.SendGuildHome;
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_GUILDHOME, TempCertification), 0, 0, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg));
end;

procedure TfrmMain.SendGuildMemberList;
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_GUILDMEMBERLIST, TempCertification), 0, 0, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg));
end;

procedure TfrmMain.SendGuildAddMem (who: string);
var
  msg: TDefaultMessage;
begin
  if Trim(who) <> '' then begin
    msg := MakeDefaultMsg (aa(CM_GUILDADDMEMBER, TempCertification), 0, 0, 0, 0, m_nSendMsgCount);
    SendSocket (EncodeMessage (msg) + EncodeString (who));
  end;
end;

procedure TfrmMain.SendGuildDelMem (who: string);
var
  msg: TDefaultMessage;
begin
  if Trim(who) <> '' then begin
    msg := MakeDefaultMsg (aa(CM_GUILDDELMEMBER, TempCertification), 0, 0, 0, 0, m_nSendMsgCount);
    SendSocket (EncodeMessage (msg) + EncodeString (who));
  end;
end;
//ÉÌÆÌ¶Ò»»Áé·û¹¦ÄÜ  20080302
procedure TfrmMain.SendBuyGameGird(GameGirdNum: Integer; btType: Byte);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_EXCHANGEGAMEGIRD, TempCertification), btType, GameGirdNum, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg));
end;
//·¢ËÍÐÐ»á¹«¸æÐÅÏ¢¸üÐÂ
procedure TfrmMain.SendGuildUpdateNotice (notices: string);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_GUILDUPDATENOTICE, TempCertification), 0, 0, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg) + EncodeString (notices));
end;

procedure TfrmMain.SendGuildUpdateGrade (rankinfo: string);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_GUILDUPDATERANKINFO, TempCertification), 0, 0, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg) + EncodeString (rankinfo));
end;

{procedure TfrmMain.SendSpeedHackUser;
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (CM_SPEEDHACKUSER, 0, 0, 0, 0);
   SendSocket (EncodeMessage (msg));
end;  }

procedure TfrmMain.SendAdjustBonus (remain: integer; babil: TNakedAbility);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_ADJUST_BONUS, TempCertification), remain, 0, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg) + EncodeBuffer (@babil, sizeof(TNakedAbility)));
end;

{---------------------------------------------------------------}

                                       
function  TfrmMain.ServerAcceptNextAction: Boolean;
begin
  Result := TRUE;
  //Èô·þÎñÆ÷Î´ÏìÓ¦¶¯×÷ÃüÁî£¬Ôò10Ãëºó×Ô¶¯½âËø
  if ActionLock then begin
    if GetTickCount - ActionLockTime > 10 * 1000 then begin
      ActionLock := FALSE;
    end;
    Result := FALSE;
  end;
end;

function  TfrmMain.CanNextAction: Boolean;
begin
  if (g_MySelf.IsIdle) and
     ((g_MySelf.m_nState and $04000000 = 0){·ÇÂé±Ô}) and (g_MySelf.m_nState and $1000000 = 0){·Ç±ù¶³}  and (g_MySelf.m_nState and $00004000 = 0){·Ç¶¨Éí} and
     (GetTickCount - g_dwDizzyDelayStart > g_dwDizzyDelayTime)
  then begin
    Result := TRUE;
  end else Result := FALSE;
end;

function TfrmMain.CanNextAutoMagic: Boolean;
begin
   Result := TRUE;
  //Èô·þÎñÆ÷Î´ÏìÓ¦¶¯×÷ÃüÁî£¬Ôò10Ãëºó×Ô¶¯½âËø
  if g_AutoMagicLock then begin
    if GetTickCount - g_AutoMagicTimeTick > g_AutoMagicTime * 1000 then begin
      g_AutoMagicLock := FALSE;
    end;
    Result := FALSE;
  end;
end;
//ÊÇ·ñ¿ÉÒÔ¹¥»÷£¬¿ØÖÆ¹¥»÷ËÙ¶È
function  TfrmMain.CanNextHit: Boolean;
var
   NextHitTime, LevelFastTime:Integer;
begin
   LevelFastTime:= _MIN (370, (g_MySelf.m_Abil.Level * 14));
   LevelFastTime:= _MIN (800, LevelFastTime + g_MySelf.m_nHitSpeed * g_nItemSpeed{60});
   (* //20080816 ×¢ÊÍ ÍóÁ¦²»×ã
   if g_boAttackSlow then
      NextHitTime:= g_nHitTime{1400} - LevelFastTime + 1500 //ÍóÁ¦³¬¹ýÊ±£¬¼õÂý¹¥»÷ËÙ¶È
   else*) NextHitTime:= g_nHitTime{1400} - LevelFastTime;
   if NextHitTime < 0 then NextHitTime:= 0;
   if GetTickCount - LastHitTick > LongWord(NextHitTime) then begin
     LastHitTick:=GetTickCount;
     Result:=True;
   end else Result:=False;
end;

procedure TfrmMain.ActionFailed;
begin
  g_nTargetX := -1;
  g_nTargetY := -1;
  ActionFailLock := TRUE; //°°Àº ¹æÇâÀ¸·Î ¿¬¼ÓÀÌµ¿½ÇÆÐ¸¦ ¸·±âÀ§ÇØ¼­, FailDir°ú ÇÔ²² »ç¿ë
  ActionFailLockTime :=GetTickCount();//Jacky
  g_MySelf.MoveFail;
end;

function  TfrmMain.IsUnLockAction (action, adir: integer): Boolean;
begin
  if ActionFailLock then begin //Èç¹û²Ù×÷±»Ëø¶¨£¬ÔòÔÚÖ¸¶¨Ê±¼äºó½âËø
    if GetTickCount() - ActionFailLockTime > 1000 then ActionFailLock:=False;
  end;
  if (ActionFailLock) or (g_boMapMoving) or (g_boServerChanging) then begin
    Result := FALSE;
  end else Result := TRUE;
end;

function TfrmMain.IsGroupMember (uname: string): Boolean;
var
  I: integer;
begin
  Result := FALSE;
  if g_GroupMembers.Count > 0 then //20080629
  for i:=0 to g_GroupMembers.Count-1 do
  if g_GroupMembers[i] = uname then begin
    Result := TRUE;
    break;
  end;
end;

{-------------------------------------------------------------}

procedure TfrmMain.Timer1Timer(Sender: TObject);
var
   data: string;
const
   busy: Boolean = FALSE;
begin
   if busy then exit;
   busy := TRUE;
   try
      BufferStr := BufferStr + SocStr;
      SocStr := '';
      if BufferStr <> '' then begin
         while Length(BufferStr) >= 2 do begin
            if g_boMapMovingWait then break; // ´ë±â..
            if Pos('!', BufferStr) <= 0 then break;
            BufferStr := ArrestStringEx (BufferStr, '#', '!', data);
            if data = '' then break;
            DecodeMessagePacket (data);
            if Pos('!', BufferStr) <= 0 then break;
         end;
      end;
   finally
      busy := FALSE;
   end;
   if g_boQueryPrice then begin
      if GetTickCount - g_dwQueryPriceTime > 500 then begin
         g_boQueryPrice := FALSE;
         case FrmDlg.SpotDlgMode of
            dmSell: SendQueryPrice (g_nCurMerchant, g_SellDlgItem.MakeIndex, g_SellDlgItem.S.Name);
            dmRepair: SendQueryRepairCost (g_nCurMerchant, g_SellDlgItem.MakeIndex, g_SellDlgItem.S.Name);
            {$IF M2Version <> 2}
            dmArmsExchange: SendQueryArmsExchangeCost(g_nCurMerchant, g_SellDlgItem.MakeIndex, g_SellDlgItem.S.Name);
            {$IFEND}
         end;
      end;
   end;
   if FrmDlg <> nil then begin
     if FrmDlg.DBotPlusAbil <> nil then begin
       if g_nBonusPoint > 0 then begin
          FrmDlg.DBotPlusAbil.Visible := TRUE;
       end else begin
          FrmDlg.DBotPlusAbil.Visible := FALSE;
       end;
     end;
   end;
end;



(*//ËÙ¶È×÷±×¼ì²âÊ±ÖÓÊÂ¼þ(Ã¿Ãë4´Î£©
//Ö÷ÒªÊÇ¼ì²éÏµÍ³Ê±ÖÓºÍCPUÖ®¼äÖ®¼äµÄ²î±ð
//ÈôÔÚÒ»ÃëÄÚÁ¬ÐøËÄ´ÎÐÞ¸ÄÏµÍ³ÖÐ¼ä£¬½«¿ÉÄÜ³öÏÖËÙ¶È×÷±×ÏÓÒÉ
procedure TfrmMain.SpeedHackTimerTimer(Sender: TObject);
{var
   gcount, timer: longword;
   ahour, amin, asec, amsec: word;  }
begin
   //DecodeTime (Time, ahour, amin, asec, amsec);
   //timer := ahour * 1000 * 60 * 60 + amin * 1000 * 60 + asec * 1000 + amsec;
   //gcount := GetTickCount;
   {if g_dwSHGetTime > 0 then begin
      if abs((gcount - g_dwSHGetTime) - (timer - g_dwSHTimerTime)) > 70 then begin
         Inc (g_nSHFakeCount);
      end else
         g_nSHFakeCount := 0;
      if g_nSHFakeCount > 4 then begin
         FrmDlg.DMessageDlg ('ÍøÂç³öÏÖ²»ÎÈ¶¨Çé¿ö£¬ÓÎÏ·ÖÐ¶Ï\' +
                             'ÈçÓÐÎÊÌâÇë×ÉÑ¯ÓÎÏ·µÄ¹Ù·½ÍøÕ¾.',
                             [mbOk]);
         FrmMain.Close;
      end;
      {if g_boCheckSpeedHackDisplay then begin
         DScreen.AddSysMsg ('->' + IntToStr(gcount - g_dwSHGetTime) + ' - ' +
                                   IntToStr(timer - g_dwSHTimerTime) + ' = ' +
                                   IntToStr(abs((gcount - g_dwSHGetTime) - (timer - g_dwSHTimerTime))) + ' (' +
                                   IntToStr(g_nSHFakeCount) + ')');
      end; 
   end; }
  // g_dwSHGetTime := gcount;
  // g_dwSHTimerTime := timer;
end;  *)

(*
20080719×¢ÊÍ    
procedure TfrmMain.CheckSpeedHack (rtime: Longword);
var
   cltime, svtime: integer;
   str: string;
begin
   if g_dwFirstServerTime > 0 then begin
      if (GetTickCount - g_dwFirstClientTime) > 1 * 60 * 60 * 1000 then begin  //1½Ã°£ ¸¶´Ù ÃÊ±âÈ­
         g_dwFirstServerTime := rtime; //ÃÊ±âÈ­
         g_dwFirstClientTime := GetTickCount;
         //ServerTimeGap := rtime - int64(GetTickCount);
      end;
      cltime := GetTickCount - g_dwFirstClientTime;
      svtime := rtime - g_dwFirstServerTime + 3000;

      if cltime > svtime then begin
        { Inc (g_nTimeFakeDetectCount);
         if g_nTimeFakeDetectCount > 6 then begin
            //½Ã°£Á¶ÀÛ...
            str := 'Bad';
            //SendSpeedHackUser;
            FrmDlg.DMessageDlg ('ÍøÂçËÙ¶È¼«²î»òÏµÍ³²»ÎÈ¶¨£¬ÓÎÏ·ÖÐ¶Ï\' +
                                'ÈçÓÐÎÊÌâÇë×ÉÑ¯ÓÎÏ·µÄ¹Ù·½ÍøÕ¾\' ,
                                [mbOk]);
            FrmMain.Close;
         end;    }
      end else begin
         str := 'Good';
         //g_nTimeFakeDetectCount := 0;
      end;
      {if g_boCheckSpeedHackDisplay then begin
         DScreen.AddSysMsg (IntToStr(svtime) + ' - ' +
                            IntToStr(cltime) + ' = ' +
                            IntToStr(svtime-cltime) +
                            ' ' + str);
      end;   }
   end else begin
      g_dwFirstServerTime := rtime;
      g_dwFirstClientTime := GetTickCount;
      //ServerTimeGap := int64(GetTickCount) - longword(msg.Recog);
   end;
end; *)

{********************¼àÌý·þÎñ¶Ë·¢À´µÄÏûÏ¢ 2007.10.21**********************}
procedure TfrmMain.DecodeMessagePacket (datablock: string);
  function AnsiContainsText(const AText, ASubText: string): Boolean;
  begin
    Result := AnsiPos(AnsiUppercase(ASubText), AnsiUppercase(AText)) > 0;
  end;
  //Ëæ»úÈ¡ÃÜÂë
  function GetPass():string;
  var
    s,s1:string;
    I,i0:Byte;
  begin
    s:='123456789abcdefghijklmnopqrstuvwxyz';
    s1:='';
    Randomize(); //Ëæ»úÖÖ×Ó
    for i:=0 to 8 do begin
      i0:=random(35);
      s1:=s1+copy(s,i0,1);
    end;
    Result := s1;
  end;
var
   head, body, body2, tagstr, data, str: String;
   ExpData: TExpData; // By TasNat at: 2012-04-24 19:10:05
   msg : TDefaultMessage;
   smsg: TShortMessage;
   mbw: TMessageBodyW;
   wl2: TMessageBodyWL2;
   desc, CharDesc{Ó¢ÐÛ}: TCharDesc;
   Afeature: TFeatures;
   msgWl: TMessageBodyWL;
   I, n, param: integer;
   actor: TActor;
   EffecItem: pTEffecItem;
   Event: TClEvent;
   str2,str3:string; //½ÓÊÕ¾ÆÆø»¤ÌåÓÃµÄ±äÁ¿
   //str4,str5: string; //ÈËÎï,Ó¢ÐÛ£º¾Æ2Ïà¹ØÊôÐÔ½ÓÊÕÓÃµÄ±äÁ¿
   d: TDirectDrawSurface;
   str6: String;//(M2)MESSAGEBOXÃüÁî·¢À´µÄ´¥·¢²ÎÊý
begin
  FillChar(desc, SizeOf(desc), 0);
  FillChar(CharDesc, SizeOf(CharDesc), 0);
  FillChar(Afeature, SizeOf(Afeature), 0);
  FillChar(msgWl, SizeOf(msgWl), 0);
  msgWl.feature.nDressLook := 65535; //ÒÂ·þÍâ¹ÛÌØÐ§
  msgWl.feature.nWeaponLook := 65535; //ÎäÆ÷Íâ¹ÛÌØÐ§

  CharDesc.feature.nDressLook := 65535; //ÒÂ·þÍâ¹ÛÌØÐ§
  CharDesc.feature.nWeaponLook := 65535; //ÎäÆ÷Íâ¹ÛÌØÐ§

  Afeature.nDressLook := 65535; //ÒÂ·þÍâ¹ÛÌØÐ§
  Afeature.nWeaponLook := 65535; //ÎäÆ÷Íâ¹ÛÌØÐ§

  desc.feature.nDressLook := 65535; //ÒÂ·þÍâ¹ÛÌØÐ§
  desc.feature .nWeaponLook := 65535; //ÎäÆ÷Íâ¹ÛÌØÐ§

   if datablock[1] = '+' then begin  //checkcode
      data := Copy (datablock, 2, Length(datablock)-1);
      data := GetValidStr3 (data, tagstr, ['/']);
      if tagstr = 'PWR'  then g_boNextTimePowerHit := True;  //´ò¿ª¹¥É±
      if tagstr = 'LNG'  then g_boCanLongHit := True;        //´ò¿ª´ÌÉ±
      if tagstr = 'ULNG' then g_boCanLongHit := False;       //¹Ø±Õ´ÌÉ±
      if tagstr = 'LNG4' then g_boCanLongHit := True;       //´ò¿ª4¼¶´ÌÉ±
      if tagstr = 'ULNG4' then g_boCanLongHit := False;       //¹Ø±Õ4¼¶´ÌÉ±
      if tagstr = 'WID'  then g_boCanWideHit := True;        //´ò¿ª°ëÔÂ
      if tagstr = 'UWID' then g_boCanWideHit := False;       //¹Ø±Õ°ëÔÂ
      if tagstr = 'WID4'  then g_boCanWideHit := True;        //´ò¿ªÔ²ÔÂ
      if tagstr = 'UWID4' then g_boCanWideHit := False;       //¹Ø±ÕÔ²ÔÂ
      if tagstr = 'CRS'  then g_boCanCrsHit := True;    //´ò¿ª±§ÔÂ
      if tagstr = 'UCRS' then g_boCanCrsHit := False;   //¹Ø±Õ±§ÔÂ
      if tagstr = 'CID'  then g_boCanCIDHit := True;   //´ò¿ªÁúÓ°½£·¨
      if tagstr = 'UCID' then g_boCanCIDHit := False;  //¹Ø±ÕÁúÓ°½£·¨
      if tagstr = 'STN'  then g_boCanStnHit := True;
      if tagstr = 'USTN' then g_boCanStnHit := False;
      {$IF M2Version = 1}
      if tagstr = 'BAT1' then begin
        g_boCanCXCHit1 := True;    //´ò¿ª ×·ÐÄ´Ì
        g_boCanCXCHit := True; //ÕýÔÚÁ¬»÷
      end;
      if tagstr = 'BAT2' then begin
        g_boCanCXCHit2 := True;    //´ò¿ª Èý¾øÉ±
        g_boCanCXCHit := True; //ÕýÔÚÁ¬»÷
      end;
      if tagstr = 'BAT3' then begin
        g_boCanCXCHit3 := True;    //´ò¿ª ºáÉ¨Ç§¾ü
        g_boCanCXCHit := True; //ÕýÔÚÁ¬»÷
      end;
      if tagstr = 'BAT4' then begin
        g_boCanCXCHit4 := True;    //´ò¿ª ¶ÏÔÀÕ¶
        g_boCanCXCHit := True; //ÕýÔÚÁ¬»÷
      end;
      if tagstr = 'UBAT' then  begin
        g_boCanCXCHit := False;    //¹Ø±ÕÕýÔÚÁ¬»÷
        g_boCanCXCHit1 := False;    //¹Ø±Õ ×·ÐÄ´Ì
        g_boCanCXCHit2 := False;    //¹Ø±Õ Èý¾øÉ±
        g_boCanCXCHit3 := False;    //¹Ø±ÕºáÉ¨Ç§¾ü
        g_boCanCXCHit4 := False;    //¹Ø±Õ ¶ÏÔÀÕ¶
      end;
      {$IFEND}      
      if tagstr = 'TWN' then begin
        g_boCanTwnHit := True;    //´ò¿ª ÖØ»÷¿ªÌìÕ¶
        g_dwLatestTwnHitTick := GetTickCount;
      end;
      if tagstr = 'UTWN' then g_boCanTwnHit := False;   //¹Ø±Õ ÖØ»÷¿ªÌìÕ¶
      if tagstr = 'QTWN' then begin  //´ò¿ª Çá»÷¿ªÌìÕ¶    2008.02.12
        g_boCanQTwnHit := True;
        g_dwLatestTwnHitTick := GetTickCount;
      end;
      if tagstr = 'UQTWN' then g_boCanQTwnHit := False;   //¹Ø±Õ Çá»÷¿ªÌìÕ¶ 2008.02.12
      if tagstr = 'FIR'  then begin
         g_boNextTimeFireHit := TRUE;  //´ò¿ªÁÒ»ð
         g_dwLatestFireHitTick := GetTickCount;
      end;
      if tagstr = 'UFIR' then g_boNextTimeFireHit := False; //¹Ø±ÕÁÒ»ð
      {if tagstr = 'HEA' then begin
        g_boCan69Hit := True; //´ò¿ªÒÐÌì±ÙµØ
      end; }
      {if tagstr = 'UHEA' then g_boCan69Hit := False; //¹Ø±ÕÒÐÌì±ÙµØ}
      if tagstr = 'DAILY' then begin   //ÖðÈÕ½£·¨ 20080511
         g_boNextItemDAILYHit := True;
         g_dwLatestDAILYHitTick := GetTickCount;
      end;
      if tagstr ='BLO' then begin  //´ò¿ªÑªÆÇÒ»»÷(Õ½)
        g_boNextSoulHit := True;
      end;
      if tagstr = 'UBLO' then begin //¹Ø±ÕÑªÆÇÒ»»÷(Õ½)
        g_boNextSoulHit := False;
      end;
      if tagstr = 'UDAILY' then g_boNextItemDAILYHit := False;
      if tagstr = '4FIR' then begin
         g_boNextTime4FireHit := TRUE;  //´ò¿ª4¼¶ÁÒ»ð 20080112
         g_dwLatestFireHitTick := GetTickCount;
      end;
      if tagstr = 'U4FIR' then g_boNextTime4FireHit := FALSE; //¹Ø±Õ4¼¶ÁÒ»ð
      if tagstr = 'GOOD' then begin    //ÐÐ¶¯ÃüÁî±»½ÓÊÜ£¨×ß¡¢¹¥»÷µÈ£©
         ActionLock := FALSE;
         //Inc(g_nReceiveCount);
      end;
      if tagstr = 'FAIL' then begin   //ÐÐ¶¯Ê§°Ü
         ActionFailed;
         ActionLock := FALSE;
         //Inc(g_nReceiveCount);
      end;
      {if data <> '' then begin
        n := Str_ToInt(data, 0);
        if n <> 0 then begin
          if g_boSafe <> (n = 2) then begin
            if n = 2 then
              DScreen.AddTopLetter(255, 0, 'ÄãÒÑ¾­½øÈë°²È«ÇøÓò')
            else DScreen.AddTopLetter(255, 0, 'ÄãÒÑ¾­Àë¿ª°²È«ÇøÓò');
          end;
          g_boSafe := n = 2;
        end;
      end; }

     { if data <> '' then begin
         CheckSpeedHack (Str_ToInt(data, 0));
      end; }
      exit;
   end;
   if Length(datablock) < DEFBLOCKSIZE then begin
      if datablock[1] = '=' then begin
         data := Copy (datablock, 2, Length(datablock)-1);
         if data = 'DIG' then begin   //ÍÚ¿óÐ§¹û
            g_MySelf.m_boDigFragment := TRUE;
         end;
      end;
      exit;
   end;
   head := Copy (datablock, 1, DEFBLOCKSIZE);
   body := Copy (datablock, DEFBLOCKSIZE+1, Length(datablock)-DEFBLOCKSIZE);
  // body := Copy (datablock, DEFBLOCKSIZE+7, Length(datablock)-DEFBLOCKSIZE);//20081210 ÐÞ¸ÄÊÍÍ¨Ñ¶·½Ê½
   msg  := DecodeMessage (head);
   {if (msg.Ident <> SM_HEALTHSPELLCHANGED) and
      (msg.Ident <> SM_HEALTHSPELLCHANGED)
      then begin

     if g_boShowMemoLog then begin
       ShowHumanMsg(@Msg);
     end;
   end;}
   if g_MySelf = nil then begin
      case msg.Ident of
         SM_GATEPASS_FAIL: begin
           FrmDlg.DMessageDlg (Body, [mbOk]);
           LoginScene.PassWdFail;
         end;
         SM_SENDLOGINKEY: begin
           if body <> '' then begin
             g_sLoginKey := DecodeString(body);
           end;
           body := EncodeString(Format('$%.8x', [Msg.Recog xor 432]));
           CSocket.Socket.SendText('<IGEM2>' + body);//½ÓÊÕÍø¹Ø(LoginGate,SelGate)·¢ËÍµÄËæ»úÃÜÔ¿,´¦ÀíºóÖ±½Ó·µ»ØÏûÏ¢ 20091121
           //WaitAndPass(500); //ÑÓ³Ù·¢ËÍ  ·ÀÖ¹·âÄÚÈÝÁ¬µ½Ò»Æð (SB ²»»áµ½ Íø¹ØÀï´¦Àí°¡)
           g_boLOGINKEYOk := True;
         end;
         SM_NEWID_SUCCESS:
            begin
               FrmDlg.DMessageDlg ('ÕÊºÅÒÑ´´½¨³É¹¦£¬Çë±£¹ÜºÃÄúµÄÕÊºÅºÍÃÜÂë¡£\' +
                                   'ÈçÓÐÎÊÌâÇë×ÉÑ¯ÓÎÏ·µÄ¹Ù·½ÍøÕ¾£¡\',
                                   [mbOk]);
               FrmDlg.m_EdId.SetFocus;
            end;
         SM_NEWID_FAIL:
            begin
               case msg.Recog of
                  0: begin
                        FrmDlg.DMessageDlg ('"' + MakeNewId + '"Õâ¸öÕÊºÅÒÑ×¢²á.\',
                                            [mbOk]);
                        LoginScene.NewIdRetry (FALSE);
                     end;
                  -2: FrmDlg.DMessageDlg ('´ËÕÊºÅÃû±»½ûÖ¹Ê¹ÓÃ£¡', [mbOk]);
                  else FrmDlg.DMessageDlg ('ÕÊºÅÎÞ·¨´´½¨£¬Çë²»ÒªÓÃ¿Õ¸ñ¼°·Ç·¨×Ö·û×¢²á :  ' + IntToStr(msg.Recog), [mbOk]);
               end;
            end;
         SM_PASSWD_FAIL:
            begin
               case msg.Recog of
                  -1: FrmDlg.DMessageDlg ('ÃÜÂëÊäÈë´íÎó¡£', [mbOk]);
                  -2: FrmDlg.DMessageDlg ('ÃÜÂëÊäÈë´íÎó³¬¹ý3´Î£¬´ËÕÊºÅ±»ÔÝÊ±Ëø¶¨£¬ÇëÉÔºòÔÙµÇÂ¼¡£', [mbOk]);
                  -3: FrmDlg.DMessageDlg ('´ËÕÊºÅÒÑ¾­µÇÂ¼»ò±»Òì³£Ëø¶¨£¬ÇëÉÔºòÔÙµÇÂ¼£¡', [mbOk]);
                  -4: FrmDlg.DMessageDlg ('Õâ¸öÕÊºÅ·ÃÎÊÊ§°Ü¡£', [mbOk]);
                  -5: FrmDlg.DMessageDlg ('Õâ¸öÕÊºÅ±»Ëø¶¨¡£', [mbOk]);
                  else  FrmDlg.DMessageDlg ('ÕÊºÅ²»´æÔÚ£¬Çë¼ì²éÄãµÄÕÊºÅ¡£', [mbOk]);
               end;
               LoginScene.PassWdFail;
            end;
         SM_NEEDUPDATE_ACCOUNT:
            begin
               ClientGetNeedUpdateAccount (body);
            end;
         SM_UPDATEID_SUCCESS:
            begin
               FrmDlg.DMessageDlg ('ÕÊºÅÐÅÏ¢¸üÐÂ³É¹¦¡£\', [mbOk]);
               ClientGetSelectServer;
            end;
         SM_UPDATEID_FAIL:
            begin
               FrmDlg.DMessageDlg ('¸üÐÂÕÊºÅÊ§°Ü¡£', [mbOk]);
               ClientGetSelectServer;
            end;
        // SM_PASSOK_SELECTSERVER: begin
         SM_SELECTSERVER: begin
           ClientGetPasswordOK(msg, body);
           g_boSendOnePack := True;
         end;
         SM_SELECTSERVER_OK: begin
            DScreen.ChangeScene (stLogin);
           //ClientGetPasswdSuccess (body);
         end;
         SM_PASSOK: begin
           ClientGetPasswdSuccess (msg,body);
         end;
         SM_QUERYCHR: begin
           ClientGetReceiveChrs (body);
         end;
         SM_QUERYDELCHR: begin //·µ»ØÒÑÉ¾³ýµÄ½ÇÉ« 20080706
            ClientGetReceiveDelChrs(body,msg.Recog);
         end;
         SM_QUERYDELCHR_FAIL: begin //·µ»ØÒÑÉ¾³ýµÄ½ÇÉ«Ê§°Ü 20080706
            FrmDlg.DMessageDlg ('[Ê§°Ü] Ã»ÓÐÕÒµ½±»É¾³ýµÄ½ÇÉ«', [mbOk]);
         end;
         SM_RESDELCHR_SUCCESS: begin
            SendQueryChr(0);
         end;
         SM_RESDELCHR_FAIL: begin
            FrmDlg.DMessageDlg ('[Ê§°Ü] Äã×î¶àÖ»ÄÜÎªÒ»¸öÕÊºÅÉèÖÃÁ½¸ö½ÇÉ«¡£', [mbOk]);
         end;
         SM_NOCANRESDELCHR: begin
            FrmDlg.DMessageDlg ('[Ê§°Ü] ·þÎñÆ÷ÉÏÉèÖÃ½ûÖ¹»Ö¸´ÈËÎï¡£', [mbOk]);
         end;
//============================================================
//»ñÈ¡ÑéÖ¤Âë
        SM_RANDOMCODE: begin//20080612
          body := DecodeString (body);
             if body <> '' then begin
                g_pwdimgstr := body;
                g_pwdimgstr := DecodeString_3des(g_pwdimgstr, CertKey('mbhVaswrXSAL'));
                GetCheckNum();
                if not FrmDlg.DWCheckNum.Visible then begin
                    FrmDlg.DWCheckNum.ShowModal;
                    FrmDlg.DEditCheckNum.SetFocus;
                end;
             end;
        end;
        SM_CHECKNUM_OK: begin
           FrmDlg.DWCheckNum.Visible := False;
           UiDXImageList.Items[35].Picture.Assign(nil);
        end;
         SM_QUERYCHR_FAIL: begin
           if msg.Series = 1 then //ÑéÖ¤Âë 20080612
            FrmDlg.DWCheckNum.Visible := False;
           g_boDoFastFadeOut := FALSE;
           g_boDoFadeIn := FALSE;
           g_boDoFadeOut := FALSE;
           FrmDlg.DMessageDlg ('·þÎñÆ÷ÑéÖ¤Ê§°Ü¡£', [mbOk]);
           Close;
         end;

         SM_NEWCHR_SUCCESS: begin
           SendQueryChr(0);
         end;
         SM_NEWCHR_FAIL: begin
           case msg.Recog of
             0: FrmDlg.DMessageDlg ('[´íÎó] ÊäÈëµÄÃû³Æ°üº¬·Ç·¨×Ö·û£¡', [mbOk]);
             2: FrmDlg.DMessageDlg ('[´íÎó] ´´½¨µÄÃû³Æ·þÎñÆ÷ÒÑÓÐ', [mbOk]);
             3: FrmDlg.DMessageDlg ('[´íÎó] ·þÎñÆ÷Ö»ÄÜ´´½¨Á½¸öÓÎÏ·ÈËÎï', [mbOk]);
             4: FrmDlg.DMessageDlg ('[´íÎó] ´´½¨ÓÎÏ·ÈËÎïÊ±³öÏÖ´íÎó¡£', [mbOk]);
             else FrmDlg.DMessageDlg ('[´íÎó] ´´½¨ÓÎÏ·ÈËÎïÊ±³öÏÖÎ´Öª´íÎó', [mbOk]);
           end;
         end;
         SM_CHGPASSWD_SUCCESS: begin
           FrmDlg.DMessageDlg ('ÃÜÂëÒÑÐÞ¸Ä³É¹¦¡£', [mbOk]);
           FrmDlg.m_EdId.SetFocus;
         end;
         SM_CHGPASSWD_FAIL: begin
           case msg.Recog of
             -1: FrmDlg.DMessageDlg ('ÊäÈëµÄÔ­Ê¼ÃÜÂë²»ÕýÈ·¡£', [mbOk]);
             -2: FrmDlg.DMessageDlg ('´ËÕÊºÅ±»·þÎñÆ÷Ëø¶¨¡£', [mbOk]);
             else FrmDlg.DMessageDlg ('ÊäÈëµÄÐÂÃÜÂë³¤¶ÈÐ¡ÓÚËÄÎ»¡£', [mbOk]);
           end;
           FrmDlg.m_EdId.SetFocus;
         end;
         SM_DELCHR_SUCCESS: begin
           SendQueryChr(0);
         end;
         SM_DELCHR_FAIL: begin
           FrmDlg.DMessageDlg ('[´íÎó] É¾³ýÓÎÏ·ÈËÎïÊ±³öÏÖ´íÎó', [mbOk]);
         end;
         SM_STARTPLAY: begin
           ClientGetStartPlay (body);
           exit;
         end;
         SM_STARTFAIL: begin
           FrmDlg.DMessageDlg ('´Ë·þÎñÆ÷ÂúÔ±£¡', [mbOk]);
           ClientGetSelectServer();
           exit;
         end;
         (*SM_VERSION_FAIL: begin
           FrmDlg.DMessageDlg ('ÓÎÏ·³ÌÐò°æ±¾²»ÕýÈ·£¬ÇëÏÂÔØ×îÐÂ°æ±¾ÓÎÏ·³ÌÐò.'{ ('+ decrypt(g_sUnKnowName,CertKey('?-W®ê')) +')'}, [mbOk]);
           exit;
         end;  *)
         SM_OUTOFCONNECTION,
         SM_NEWMAP,
         SM_LOGON,
         SM_RECONNECT,
         SM_SENDNOTICE: ;
         else
            Exit; //µ±ÈËÎï»¹Ã»ÓÐ´´½¨Ê±£¬Ö»ÔÊÐíÉÏÃæÕâÐ©ÏûÏ¢¡£
      end;
   end;
   if g_boMapMoving then begin
      if msg.Ident = SM_CHANGEMAP then begin
         WaitingMsg := msg;
         WaitingStr := DecodeString (body);
         g_boMapMovingWait := TRUE;
         WaitMsgTimer.Enabled := TRUE;
      end;
      Exit;
   end;

  if g_MySelf<>nil then  g_MySelf.m_nCurrX:=g_MySelf.m_nCurrX-1+1;
//ÅÐ¶ÏÏûÏ¢
{$I VM_Start.inc} // Ôö¼ÓµãÄÑ¶È Ö÷ÒªÊÇ·ÀÍÑ»ú¹Ò By TasNat at: 2012-03-08 20:07:27
  if msg.Ident = SM_SENDNOTICE then begin
    with msg do
      nSessionID := nSessionID xor ((Param shl (Tag mod 8 + 1)) and (Series shl (Tag mod 6 + 1)));
    m_nSendMsgCount := msg.nSessionID;
    TempCertification := m_nSendMsgCount;
    //TempCertification := msg.nSessionID xor msg.Param xor msg.Tag xor msg.Recog;//20091026 ½ÓÊÕ¶¯Ì¬ÃÜÔ¿
    //m_nSendMsgCount:= TempCertification;
    ClientGetSendNotice(body);
  end else
    if msg.Ident = SM_UPSENDMSGCOUNT then begin
      with msg do
        nSessionID := (Param shr (Tag mod 7)) or (Param shl (Series mod 6));
      m_nSendMsgCount := msg.nSessionID mod 10000;
    end
    else
{$I VM_End.inc} //ÐéÄâ»ú±êÊ¶
//ÅÐ¶ÏÏûÏ¢
  case msg.Ident of
    	{$IF M2Version <> 2}
      SM_MAGIC_UPLVEXPEXP: begin
        ClientGetMagicLvExExp(msg.Recog, msg.Param);
      end;
      SM_SENDHEARTINFO: begin//½ÓÐÄ·¨ÊôÐÔ
        ClientGetHeartInfo(Body);
      end;
      SM_QUERYDIVISIONLIST: begin //´ò¿ªÉêÇëÈëÃÅÅÉ´°¿Ú
      	ClientGetFactionList(Body);
      end;
      SM_OPENDIVISIONDLG_FAIL: begin//´ò¿ªÃÅÅÉ¶Ô»°¿òÊ§°Ü
        g_dwQueryMsgTick := GetTickCount;
        FrmDlg.DMessageDlg ('Äã»¹Ã»ÓÐ¼ÓÈëÊ¦ÃÅ¡£', [mbOk]);
      end;
      SM_OPENDIVISIONDLG: begin //´ò¿ªÃÅÅÉ¶Ô»°¿ò³É¹¦
      	g_dwQueryMsgTick := GetTickCount;
        ClientGetOpenFactionDlg(body);
      end;
      SM_SENDDIVISIONMEMBERLIST: begin
        g_dwQueryMsgTick := GetTickCount;
        ClientGetFactionMemberList (body);
      end;
      SM_BUILDDIVISION_OK: begin
        FrmDlg.LastestClickTime := GetTickCount;
        FrmDlg.DMessageDlg ('Ê¦ÃÅ½¨Á¢³É¹¦¡£', [mbOk]);
      end;
      SM_BUILDDIVISION_FAIL: begin
        FrmDlg.LastestClickTime := GetTickCount;
        case msg.Recog of
          -1: FrmDlg.DMessageDlg('ÄãÒÑ¾­¼ÓÈëÆäËüÊ¦ÃÅ¡£', [mbOk]);
          -2: FrmDlg.DMessageDlg('ÄãµÄµÈ¼¶²»×ã¡£', [mbOk]);
          -3: FrmDlg.DMessageDlg('Ê¦ÃÅÃû×Ö¹ý³¤¡£', [mbOk]);
          //-4: FrmDlg.DMessageDlg('Ê¦ÃÅÃû×ÖÎª¿Õ¡£', [mbOk]);
          -5: FrmDlg.DMessageDlg('Î´Ñ§ÓÐÁúÎÀÐÄ·¨£¬²»ÄÜ´´½¨ÃÅÅÉ¡£', [mbOk]);
          -6: FrmDlg.DMessageDlg('Ãû×ÖÓÐ·Ç·¨×Ö·û»ò´ËÃû×ÖµÄÃÅÅÉÒÑ´æÔÚ¡£', [mbOk]);
          else FrmDlg.DMessageDlg('´´½¨Ê¦ÃÅÊ§°Ü£¡£¡£¡', [mbOk]);
        end;
      end;
      SM_DIVISIONDDELMEMBER_OK: begin//ÃÅÅÉÀÏ´óÉ¾³ýµÜ×Ó³É¹¦
        FrmDlg.DMessageDlg('Öð³öÊ¦ÃÅ³É¹¦¡£', [mbOk]);
        g_FactionMember.SelMemberName := '';
      end;
      SM_DIVISIONDDELMEMBER_OK1: begin //×ÔÒÑÍË³öÃÅÅÉ³É¹¦
        FrmDlg.DMessageDlg('ÍË³öÊ¦ÃÅ³É¹¦¡£', [mbOk]);
        if FrmDlg.DWFactionDlg.Visible then begin
          FrmDlg.DBFactionDlgCloseClick(self, 0, 0);
        end;
      end;
      SM_DIVISIONDELMEMBER_FAIL: begin;//ÃÅÅÉÉ¾³ýµÜ×Ó³É¹¦
        case msg.Recog of
          1: FrmDlg.DMessageDlg('Äã²»ÊÇÊ¦ÃÅÕÆÃÅ£¡', [mbOk]);
          2: FrmDlg.DMessageDlg('´ËÈË·Ç±¾Ê¦ÃÅ³ÉÔ±£¡', [mbOk]);
          3: FrmDlg.DMessageDlg('Ê¦ÃÅ»¹ÓÐÆäËüÈËÔ±£¬²»ÄÜ½âÉ¢£¡', [mbOk]);
          4: FrmDlg.DMessageDlg('ÍË³öÊ¦ÃÅÊ§°Ü£¡', [mbOk])
        end;
      end;
      SM_SENDDIVISIONAPPLYLIST: begin
        ClientGetFactionApplyManageList(body);
      end;
      SM_OPENSAVVYHEART: begin
        ClientOpenLingWuXinFa(msg);
      end;
      {$IFEND}
      
    	SM_UPPETSMONHAPP: begin
        g_PetDlg.nHapply := msg.nSessionID;
      end;
    	SM_PETSMONHAPPLOG: begin
      	ClientGetPetLog(body, msg.nSessionID);
      end;
      SM_MOVETOPETSMON: begin
        FrmDlg.DWPetLog.Visible := False;
      end;
      {$IF M2Version <> 2}
      SM_UPDIVISIONPONT: begin
        if FrmDlg.DWFactionDlg.Visible and (FrmDlg.m_btFactionPage = 0) then
          g_FactionDlg.nPopularity := msg.Recog;
      end;
      {$IFEND}
      {$IF M2Version <> 2}
      SM_NGMAGIC_LVEXP: begin
      	ClientGetNGUpLevel(msg, False);
      end;
      SM_HERONGMAGIC_LVEXP: begin
      	ClientGetNGUpLevel(msg, True);
      end;
      SM_SENDHUMTITLES: begin
        if body <> '' then begin
          FillChar (g_ClientHumTitles, SizeOf(TClientHumTitles), #0);//³õÊ¼³ÆºÅ
          DecodeBuffer (body, @g_ClientHumTitles, SizeOf(TClientHumTitles));
          g_boMySelfTitleFense := False;
          for I:=Low(g_ClientHumTitles.ClientHumTitles) to High(g_ClientHumTitles.ClientHumTitles) do begin
            if g_ClientHumTitles.ClientHumTitles[I].sTitleName <> '' then
              if g_ClientHumTitles.ClientHumTitles[I].AniCount = 7 then begin
              	if g_boCanTitleUse then
                	g_boMySelfTitleFense := (g_ClientHumTitles.nUseTitleIndex > 0) and ((g_ClientHumTitles.nUseTitleIndex-1) = I)
                else g_boMySelfTitleFense := True;
                Break;
              end;
          end;
        end;
      end;
      SM_SETUSERTITLES: begin
        g_ClientHumTitles.nUseTitleIndex := msg.Param;
        g_boMySelfTitleFense := False;
        for I:=Low(g_ClientHumTitles.ClientHumTitles) to High(g_ClientHumTitles.ClientHumTitles) do begin
          if g_ClientHumTitles.ClientHumTitles[I].sTitleName <> '' then
            if g_ClientHumTitles.ClientHumTitles[I].AniCount = 7 then begin
            	if g_boCanTitleUse then
               	g_boMySelfTitleFense := (g_ClientHumTitles.nUseTitleIndex > 0) and ((g_ClientHumTitles.nUseTitleIndex-1) = I)
              else g_boMySelfTitleFense := True;
              Break;
            end;
        end;
      end;
      SM_SENDFENGHAOLIST: begin //»¤»¨ÁîÅÆ     wParam £½ 0ÊÇ»¤»¨ÁÐ±í 1£½ÁúÎÀÁÐ±í
         ClientGetTitleHumName (body, msg.Param);
      end;
      SM_SENDDOMINATLIST: begin
        ClientGetDominatList(body);
      end;
      SM_WORLDFLY: begin
        case msg.Param of
          //0: DScreen.AddChatBoardString('Ã»ÓÐÕÒ¶ÔÓ¦µÄµØÍ¼Ãû',ClRed, ClWhite);
          1: DScreen.AddChatBoardString('Ã»ÓÐÕÒ¶ÔÓ¦µÄµØÍ¼Ãû',ClRed, ClWhite);
          2: DScreen.AddChatBoardString('Ã»ÓÐÕÒµ½¶ÔÓ¦µÄÅäÖÃ',ClRed, ClWhite);
          3: FrmDlg.DWZZLingPai.Visible := False;
        end;
      end;
      {$IFEND}
      {$IF M2Version = 1}
      //Ææ¾­
      SM_SKILLTOJINGQING_OK: begin
        FillChar(g_QJPracticeItems, SizeOf(TClientItem), #0);
      end;
      SM_SKILLTOJINGQING_FAIL: begin
        FrmDlg.DMessageDlg('ÐÞÁ¶Ê§°Ü£¡', [mbOK]);
      end;
      SM_OPENUPSKILL95_FAIL: begin
        FrmDlg.DMessageDlg('´òÍ¨Ê§°Ü£¡', [mbOK]);
        if g_QJPracticeItems.s.Name <> '' then begin
          if msg.Recog = 0 then begin //Ö÷Ìå
            if g_MySelf <> nil then
              AddItemBag(g_QJPracticeItems);
            g_QJPracticeItems.s.Name := '';
          end else begin
            if g_HeroSelf <> nil then
              AddHeroItemBag(g_QJPracticeItems);
            g_QJPracticeItems.s.Name := '';
          end;
        end;
      end;
      SM_OPENLIANQI: begin //´ò¿ªÁ·Æø´°¿Ú
        g_dwQJFurnaceGold := msg.nSessionID;
        g_dwQJFurnaceLingfu := msg.Recog;
        g_dwQJFurnaceExp := msg.Param;
        g_dwQJFurnaceMaxExp := msg.Tag;
        g_btQJFurnaceType := msg.Series;
        if g_btQJFurnaceType = 1 then begin //Ç¿»¯Á·Æø
          with FrmDlg do begin
            DBQJFurnaceStart.SetImgIndex(g_WMainImages, 1312);
            DBQJFurnaceStart.GLeft := 210;
            DBQJFurnaceStart.GTop := 100;
            DBQJFurnaceStart.Visible := True;
          end;
        end else begin
          with FrmDlg do begin
            DBQJFurnaceStart.SetImgIndex(g_WMainImages, 1292);
            DBQJFurnaceStart.GLeft := 220;
            DBQJFurnaceStart.GTop := 100;
            DBQJFurnaceStart.Visible := True;
          end;
        end;
        g_boQJFurnaceGet := False;
        g_boQJFurnaceMove := False;
        g_btQJFurnacePosition := 0;
        FrmDlg.DWQJFurnace.Visible := True;  
      end;
      //1-ÄÚ¹¦¾«Ôª²»×ã 2-ÄúµÄ½ð±Ò²»×ã 3-ÄúµÄÁé·û²»×ã
      SM_LIANQIPRACTICE: begin //Á·Æø·µ»Ø
        case msg.Recog of
          1: FrmDlg.DMessageDlg('ÄÚ¹¦¾«Ôª²»×ã', [mbOK]);
          2: FrmDlg.DMessageDlg('ÄúµÄ½ð±Ò²»×ã', [mbOK]);
          3: FrmDlg.DMessageDlg('ÄúµÄÁé·û²»×ã', [mbOK]);
          else begin//×ª¶¯  ÏÔÊ¾ÌáÈ¡
            with FrmDlg do begin
              DBQJFurnaceStart.SetImgIndex(g_WMainImages, 1295);
              DBQJFurnaceStart.GLeft := 220;
              DBQJFurnaceStart.GTop := 100;
              DBQJFurnaceStart.Visible := False;
            end;
            g_boQJFurnaceMove := True;
            g_btQJFurnacePosition := 0;
            Randomize;
            g_btQJFurnaceTarget := Random(9)+5;
            g_boQJFurnaceGet := True;
          end;
        end;
      end;
      SM_SENDJINGYUANVALUE: begin //¸üÐÂ¾«ÔªÖµÊý¾Ý
        g_dwQJFurnaceExp := msg.Recog;
        g_dwQJFurnaceMaxExp := msg.Param;
      end;
      {$IFEND}
      //ÈÎÎñ
      {$IF M2Version <> 2}
      SM_OPENSHINY: begin
        OPENSHINY(DecodeString (body));
        FrmDlg.m_btMissionPage := msg.Recog;
      end;
      SM_SHOWSHINY: begin
        FrmDlg.m_boMissionEff := True;
      end;
      SM_CLICKMMISSION: begin
        FrmDlg.ClientGetMissionSay(msg.Param, DecodeString(Body));
      end;
      SM_OPENSCROLLFRM: begin
        g_btEnergyValue := msg.Recog;
        g_btLuckyValue := msg.Param;
      end;
      SM_OPENDJUDGE: begin  //´ò¿ªÆ·ÆÀ´°¿Ú
        FrmDlg.DWJudgeItems.Visible := True;
        g_nJudgePrice := msg.Recog;
        g_boJudgeUseGold := msg.Param = 1;
      end;
      SM_USERJUDGE_OK: begin //Æ·ÆÀ³É¹¦
        ClientGetJudgeOk(msg.Param);
      end;
      SM_USERJUDGE_FAIL: begin //Æ·ÆÀÊ§°Ü
        if msg.Tag = 1 then begin
          FrmDlg.DMessageDlg('Ê§°Ü£¬½ð±Ò»òÔª±¦²»×ã', [mbOK]);
        end else ClientGetJudgeFail(msg.Param);
      end;
      SM_SENDUSESPIRITITEMS: begin //ÁéÃ½
        ClientGetLingMeiItem(body);
      end;
      SM_TAKEONSPIRITITEM_OK: begin //ÁéÃ½
        if g_WaitingUseItem.Index = -255 then
           g_LingMeiBelt := g_WaitingUseItem.Item;
        g_WaitingUseItem.Item.S.Name := '';
      end;
      SM_TAKEONSPIRITITEM_FAIL: begin //ÁéÃ½
        AddItemBag (g_WaitingUseItem.Item);
        g_WaitingUseItem.Item.S.Name := '';
      end;
      SM_TAKEOFFSPIRITITEM_OK: begin //ÁéÃ½
        g_WaitingUseItem.Item.S.Name := '';
      end;
      SM_TAKEOFFSPIRITITEM_FAIL: begin  //ÁéÃ½
        if g_WaitingUseItem.Index = -255 then begin
           g_LingMeiBelt := g_WaitingUseItem.Item;
        end;
        g_WaitingUseItem.Item.S.Name := '';
      end;
      SM_USERFINDJEWEL_OK: begin //Ê¹ÓÃÁéÃ½³É¹¦
        if msg.Tag = 4 then begin//Îª¼ýÍ·
          case msg.Param of
            0: DScreen.AddChatBoardString('[Ñ°±¦ÁéÃ½¸ÐÓ¦µ½ÁË±¦ÎïµÄ´æÔÚ£¬ÇëÏòÉÏ·½Ñ°ÕÒ]', clWhite, clBlue);
            1: DScreen.AddChatBoardString('[Ñ°±¦ÁéÃ½¸ÐÓ¦µ½ÁË±¦ÎïµÄ´æÔÚ£¬ÇëÏòÓÒÉÏ·½Ñ°ÕÒ]', clWhite, clBlue);
            2: DScreen.AddChatBoardString('[Ñ°±¦ÁéÃ½¸ÐÓ¦µ½ÁË±¦ÎïµÄ´æÔÚ£¬ÇëÏòÓÒ·½Ñ°ÕÒ]', clWhite, clBlue);
            3: DScreen.AddChatBoardString('[Ñ°±¦ÁéÃ½¸ÐÓ¦µ½ÁË±¦ÎïµÄ´æÔÚ£¬ÇëÏòÓÒÏÂ·½Ñ°ÕÒ]', clWhite, clBlue);
            4: DScreen.AddChatBoardString('[Ñ°±¦ÁéÃ½¸ÐÓ¦µ½ÁË±¦ÎïµÄ´æÔÚ£¬ÇëÏòÏÂ·½Ñ°ÕÒ]', clWhite, clBlue);
            5: DScreen.AddChatBoardString('[Ñ°±¦ÁéÃ½¸ÐÓ¦µ½ÁË±¦ÎïµÄ´æÔÚ£¬ÇëÏò×óÏÂ·½Ñ°ÕÒ]', clWhite, clBlue);
            6: DScreen.AddChatBoardString('[Ñ°±¦ÁéÃ½¸ÐÓ¦µ½ÁË±¦ÎïµÄ´æÔÚ£¬ÇëÏò×ó·½Ñ°ÕÒ]', clWhite, clBlue);
            7: DScreen.AddChatBoardString('[Ñ°±¦ÁéÃ½¸ÐÓ¦µ½ÁË±¦ÎïµÄ´æÔÚ£¬ÇëÏò×óÉÏ·½Ñ°ÕÒ]', clWhite, clBlue);
          end;
        end else begin
          DScreen.AddChatBoardString('[±¦Îï¾ÍÔÚÄúÖÜÎ§£¬°´ÏÂAlt+Êó±êÓÒ¼ü¾Í¿ÉÒÔÍÚ±¦ÁË]', clWhite, clBlue);
        end;
        PlayScene.ShowMySelfEff(msg.Tag ,msg.Param);
      end;
      SM_USERFINDJEWEL_FAIL: begin //Ê¹ÓÃÁéÃ½Ê§°Ü
        DScreen.AddChatBoardString('[Õâ´ÎÄãµÄ±¦ÎïÁéÃ½Ã»ÓÐ¸ÐÓ¦µ½±¦ÎïµÄ´æÔÚ]', clWhite, clBlue);
        DScreen.AddChatBoardString('Õâ´ÎÁéÃ½Ã»ÓÐ¸ÐÓ¦µ½±¦ÎïµÄ´æÔÚ', GetRGB(219), clWhite);
      end;
      SM_OPENQUERYPROFICIENCY: begin //²éÑ¯ÉñÃØ½â¶ÁµÄÊìÁ·¶È
        g_nProficiency := msg.Recog;
      end;
      SM_UPDATEKAMPOITME: begin //¸ß¼¶¼ø¶¨»»ÎïÆ·
        ClientGetSignedItem(body);
      end;
      SM_USERSCROLLCHANGEITME_OK: begin //½â¶Á³É¹¦
        g_MakeSignedBelt[1].s.Name := '';
        FrmDlg.m_btMakeSignedSuccess := 3; //³É¹¦¶¯»­ÏÔÊ¾
        FrmDlg.m_btMakeSignedHint := 3; //³É¹¦ÌáÊ¾
      end;
      SM_USERSCROLLCHANGEITME_FAIL: begin //½â¶ÁÊ§°Ü
        g_MakeSignedBelt[1].s.Name := '';
        FrmDlg.m_btMakeSignedSuccess := 4; //Ê§°Ü¶¯»­ÏÔÊ¾
        FrmDlg.m_btMakeSignedHint := 4; //Ê§°ÜÌáÊ¾
      end;
      SM_USERMAKESCROLL_OK: begin //ÖÆ×÷¾íÖá³É¹¦
        g_MakeSignedBelt3.s.Name := '';
        FrmDlg.m_btMakeSignedSuccess := 1; //³É¹¦¶¯»­ÏÔÊ¾
        FrmDlg.m_btMakeSignedHint := 1; //³É¹¦ÌáÊ¾
      end;
      SM_USERMAKESCROLL_FAIL: begin //ÖÆ×÷¾íÖáÊ§°Ü
        g_MakeSignedBelt3.s.Name := '';
        FrmDlg.m_btMakeSignedSuccess := 2; //Ê§°Ü¶¯»­ÏÔÊ¾
        FrmDlg.m_btMakeSignedHint := 2; //Ê§°ÜÌáÊ¾
      end;
      SM_OpenKampoDlgNew: begin
            if g_boOpenLeiMei then with FrmDlg1 do begin
                g_SerXinJianDingLockNeeds[0] := msg.Recog;
                g_SerXinJianDingLockNeeds[1] := msg.Param;
                g_SerXinJianDingNeeds[0] := msg.Tag;
                g_SerXinJianDingNeeds[1] := msg.Series;
                g_XinJianDingNeeds[0] := g_SerXinJianDingNeeds[0];
                g_XinJianDingNeeds[1] := g_SerXinJianDingNeeds[1];

                FillChar(g_XinJianDingData, SizeOf(g_XinJianDingData), 0);
                g_SignedItemNames[0] := 'ÐèÒª¼ø¶¨ÎïÆ·';
                g_SignedItemNames[1] := '¾íÖáËéÆ¬';
                g_SignedItemNames[2] := '²Ð¾í';

                DWSignedItemNew.Visible := True;
                FrmDlg.DWSignedItems.Visible := False;
                DCHSignedItemValue1.Checked := False;
                DCHSignedItemValue2.Checked := False;
                DCHSignedItemValue3.Checked := False;
                DCHSignedItemValue4.Checked := False;
                DCHSignedItemValue1.Caption := '';
                DCHSignedItemValue2.Caption := '';
                DCHSignedItemValue3.Caption := '';
                DCHSignedItemValue4.Caption := '';
                DWSignedItemPage1Click(DWSignedItemPage0, 0, 0);
              end;
          end;
        SM_NewUSERKAMPO_OK: with g_SignedItem[0], FrmDlg1 do begin //¼ø¶¨ÎïÆ·³É¹¦
            btAppraisalValue[2] := msg.Recog;
            btAppraisalValue[3] := msg.Param;
            btAppraisalValue[4] := msg.Tag;
            btAppraisalValue[5] := msg.Series;


            if (g_SignedItem[1].s.StdMode = 17) and (g_SignedItem[1].Dura > 0) then begin
              if g_SignedItem[1].Dura > g_XinJianDingNeeds[0] then begin
                Dec(g_SignedItem[1].Dura, g_XinJianDingNeeds[0]);
                //AddItemBag(g_SignedItem[1]);
              end else g_SignedItem[1].s.Name := '';
            end;
            if (g_SignedItem[2].s.StdMode = 17) and (g_SignedItem[2].Dura > 0) then begin
              if g_SignedItem[2].Dura > g_XinJianDingNeeds[1] then begin
                Dec(g_SignedItem[2].Dura, g_XinJianDingNeeds[1]);
                //AddItemBag(g_SignedItem[2]);
              end else g_SignedItem[2].s.Name := '';
            end;
            FrmDlg.m_boSignedLock := False;
            FillChar(g_sXinJianDingValues, SizeOf(g_sXinJianDingValues), 0);
            if g_SignedItem[0].s.Name <> '' then
              for I := 2 to 5 do begin
                g_sXinJianDingValues[I] := GetAAppendItemValue(g_SignedItem[0].btAppraisalValue[I]);
              end;
            DCHSignedItemValue1.Caption := g_sXinJianDingValues[2];
            DCHSignedItemValue2.Caption := g_sXinJianDingValues[3];
            DCHSignedItemValue3.Caption := g_sXinJianDingValues[4];
            DCHSignedItemValue4.Caption := g_sXinJianDingValues[5];
            DCHSignedItemValue1.Visible := DCHSignedItemValue1.Caption <> '';
            DCHSignedItemValue2.Visible := DCHSignedItemValue2.Caption <> '';
            DCHSignedItemValue3.Visible := DCHSignedItemValue3.Caption <> '';
            DCHSignedItemValue4.Visible := DCHSignedItemValue4.Caption <> '';
            if not DCHSignedItemAutoLockValue.Checked then begin
              DCHSignedItemValue1.Checked := False;
              DCHSignedItemValue2.Checked := False;
              DCHSignedItemValue3.Checked := False;
              DCHSignedItemValue4.Checked := False;
            end;
          end;
        SM_NewUSERKAMPO_FAIL: with FrmDlg1 do begin //¼ø¶¨ÎïÆ·Ê§°Ü
            FrmDlg.m_boSignedLock := False;
            FrmDlg.DMessageDlg('¼ø¶¨ÎïÆ·Ê§°Ü.', [mbOK]);
            if not DCHSignedItemAutoLockValue.Checked then begin
              DCHSignedItemValue1.Checked := False;
              DCHSignedItemValue2.Checked := False;
              DCHSignedItemValue3.Checked := False;
              DCHSignedItemValue4.Checked := False;
            end;

          end;
      SM_USERKAMPO_OK: begin //¼ø¶¨ÎïÆ·³É¹¦
        if (g_SignedItem[1].s.StdMode = 17) and (g_SignedItem[1].Dura > 0) then begin
          AddItemBag(g_SignedItem[1]);
        end;
        g_SignedItem[1].s.Name := '';
        FrmDlg.m_btSignedSuccess := 1; //³É¹¦¶¯»­ÏÔÊ¾
        FrmDlg.m_btSignedHint := 1; //³É¹¦ÌáÊ¾
        ClientGetSigned();
      end;
      SM_USERKAMPO_FAIL: begin //¼ø¶¨ÎïÆ·Ê§°Ü
        if (g_SignedItem[1].s.StdMode = 17) and (g_SignedItem[1].Dura > 0) then begin
          AddItemBag(g_SignedItem[1]);
        end;
        g_SignedItem[1].s.Name := '';
        FrmDlg.m_btSignedSuccess := 2; //Ê§°Ü¶¯»­ÏÔÊ¾
        FrmDlg.m_btSignedHint := 2; //Ê§°ÜÌáÊ¾
        ClientGetSigned();
      end;
      SM_USERCHANGEKAMPO_OK: begin //¸ü»»ÎïÆ·³É¹¦
        g_SignedItem[1].s.Name := '';
        FrmDlg.m_btSignedSuccess := 3; //³É¹¦¶¯»­ÏÔÊ¾
        FrmDlg.m_btSignedHint := 3; //³É¹¦ÌáÊ¾
        Frmdlg.DBSignedChange.Enabled := True;
      end;
      SM_USERCHANGEKAMPO_FAIL: begin //¸ü»»ÎïÆ·Ê§°Ü
        g_SignedItem[1].s.Name := '';
        FrmDlg.m_btSignedSuccess := 4; //Ê§°Ü¶¯»­ÏÔÊ¾
        FrmDlg.m_btSignedHint := 4; //Ê§°ÜÌáÊ¾
        Frmdlg.DBSignedChange.Enabled := True;
      end;
      {$IFEND}
      {$IF M2Version <> 2}
      SM_ARMSCRIT: begin
        if g_boShowSpecialDamage then
        ClientGetMoveHMShow(msg.Recog, msg.nSessionID);
      end;
      {$IFEND}
      SM_PLAYSHOP_OK: begin
        AddItemBag(g_SelfShopItem);
        ItemClickSound(g_SelfShopItem.s);
        DelUserShopItem(g_SelfShopItem.MakeIndex, g_SelfShopItem.s.Name);
        g_SelfShopItem.s.Name := '';
        ArrangeItemBag;
      end;
      SM_PLAYSHOP_FALL: begin
        g_SelfShopItem.s.Name := '';
        case msg.Recog of
          0: FrmDlg.DMessageDlg('[Ê§°Ü]£º¶Ô·½ÒÑ¾­ÊÕÌ¯ÁË£¡', [mbOk]);
          1: FrmDlg.DMessageDlg('[Ê§°Ü]£ºÄãËù¹ºÂòµÄÎïÆ·ÒÑ¾­±»Âô³öÈ¥£¡', [mbOk]);
          2: FrmDlg.DMessageDlg('[Ê§°Ü]£ºÄãµÄ'+g_sGoldName+'»ò' +
              g_sGameGoldName + '²»¹»£¬»òÕßÂô¼Ò²»ÄÜÐ¯´ø¸ü¶àµÄ'+g_sGoldName+'»ò' + g_sGameGoldName + '£¡', [mbOk]);
          3: FrmDlg.DMessageDlg('[Ê§°Ü]£ºÄãÎÞ·¨Ð¯´ø¸ü¶àµÄÎïÆ·£¡', [mbOk]);
        else
          FrmDlg.DMessageDlg('[Ê§°Ü]£ºÎ´ÖªµÄ´íÎó£¡', [mbOk]);
        end;
      end;
      SM_DELSHOPITEM: DelShopItemEx(msg.Recog);
      SM_SELLSHOPLIST: ClientGetSelfShopItmes(body);
      SM_SELLSHOPTITLE: g_MySelf.m_sShopMsg := DecodeString(body);
//===================================Á¬»÷Ïà¹Ø===================================
//Á¬»÷²¿·Ö
      SM_OPEN4BATTERSKILL: begin //4Á¬»÷
        if msg.Recog = 0 then g_boOpen4BatterSkill := True
        else if msg.Recog = 1 then g_boHeroOpen4BatterSkill := True;
      end;
      SM_SENDNGRESUME: begin //ÈËÎïÊý¾Ý
        g_nInternalRecovery := Msg.nSessionID;  //ÄÚ¹¦»Ö¸´ËÙ¶È
        g_nInternalHurtAdd := Msg.Recog;  //ÄÚ¹¦»Ö¸´ÉËº¦
        g_nInternalHurtRelief := MakeLong(msg.Param,msg.Tag);  //ÄÚ¹¦»Ö¸´¼õÃâ
      end;
      SM_SENDHERONGRESUME: begin //Ó¢ÐÛÊý¾Ý
        g_nHeroInternalRecovery := Msg.nSessionID;  //ÄÚ¹¦»Ö¸´ËÙ¶È
        g_nHeroInternalHurtAdd := Msg.Recog; //ÄÚ¹¦»Ö¸´ÉËº¦
        g_nHeroInternalHurtRelief := MakeLong(msg.Param,msg.Tag);  //ÄÚ¹¦»Ö¸´¼õÃâ
      end;
      SM_BATTEROVER: begin  //Á¬»÷½áÊø
        g_AutoMagicLock := False;
      end;
      SM_SENDCANUSEBATTER: begin//¿ÉÊ¹ÓÃÁ¬»÷µÄÍ¨Öª£¨À¶É«£© 20090702
        if g_WinBatterMagicList.Count > 0 then g_boCanUseBatter := True;
      end;
//Ó¢ÐÛ¾­ÂçÏà¹Ø
      SM_SENDHEROPULSESHINY: begin//Ó¢ÐÛ´ý´òÍ¨µÄÑ¨Î»·¢ÁÁ
        g_btHeroPulseOriginPage := msg.Tag; //m2·¢µÄÔ­µãÁÁ¹âÒ³
        g_btHeroPulsePoint := msg.Recog; //m2·¢À´µÄÑ¨Î»
        g_btHeroPulseLevel := msg.Param; //m2·¢À´µÄÑ¨Î»µÈ¼¶
        g_boHeroPulseOpen := True;  //Ó¢ÐÛ¾­ÂöÊÇ·ñ¿ªÍ¨
      end;
      SM_SENDHEROGETPULSEEXP: begin   //È¡µÃ¾­Âç¾­Ñé
        DScreen.AddBottomSysMsg ('(Ó¢ÐÛ)'+IntToStr(Msg.Recog)+' µãÓ¢ÐÛ¾­Âç¾­ÑéÔö¼Ó',0);
        g_dwHeroPulsExp := msg.nSessionID;
      end;
      SM_SENDHEROPULSEARR: begin//µÇÂ½Ê±·¢ËÍ¸÷¾­ÂçµÄÊý¾Ý
        if body <> '' then begin
          FillChar (g_HeroHumanPulseArr, SizeOf(THeroPulseInfo1), #0);//³õÊ¼Ó¢ÐÛÂöÑ¨
          DecodeBuffer (body, @g_HeroHumanPulseArr, sizeof(THeroPulseInfo1));
          g_boHeroPulseOpen := True; //Ó¢ÐÛ¾­ÂöÊÇ·ñ¿ªÍ¨
          g_dwHeroPulsExp := msg.nSessionID;
        end;
      end;
      SM_SENDHEROUPDATAPULSEARR: begin//¸üÐÂÓ¢ÐÛ¾­ÂçÊý¾Ý
        if (body <> '') and (msg.Recog < 5) and (msg.Recog > -1) then begin
          DecodeBuffer (body, @g_HeroHumanPulseArr[msg.Recog], sizeof(THeroPulseInfo));
          FrmDlg.DBNewHeroPointPage2.Visible := g_HeroHumanPulseArr[0].boOpenPulse;
          FrmDlg.DBNewHeroPointPage3.Visible := g_HeroHumanPulseArr[1].boOpenPulse;
          FrmDlg.DBNewHeroPointPage4.Visible := g_HeroHumanPulseArr[2].boOpenPulse;
          if g_HeroHumanPulseArr[3].boOpenPulse then g_btHeroPulseOriginPage := 6;  //×îºóÒ»¸öÑ¨Î»´òÍ¨ ²»ÏÔÊ¾Ñ¨Î»·¢ÁÁ
          g_dwHeroPulsExp := msg.nSessionID;//20090915
        end;
      end;
//¾­ÂçÏà¹Ø
      SM_SENDUSERPULSESHINY: begin//´ý´òÍ¨µÄÑ¨Î»·¢ÁÁÊý¾Ý
        g_btPulseOriginPage := msg.Tag; //m2·¢µÄÔ­µãÁÁ¹âÒ³
        g_btPulsePoint := msg.Recog; //m2·¢À´µÄÑ¨Î»
        g_btPulseLevel := msg.Param; //m2·¢À´µÄÑ¨Î»µÈ¼¶
      end;
      SM_SENDUSERPULSEARR: begin //½ÓÊÕ¾­ÂçÊý×é
        if body <> '' then begin
          FillChar (g_HumanPulseArr, SizeOf(THumanPulseInfo), #0);//³õÊ¼ÈËÎïÂöÑ¨
          DecodeBuffer (body, @g_HumanPulseArr, sizeof(THumanPulseInfo));
        end;
      end;
      SM_SENDUPDATAPULSEARR: begin//¸üÐÂ¾­ÂçÊý¾Ý 20090623
        if (body <> '') and (msg.Recog < 5) and (msg.Recog > -1) then begin
          DecodeBuffer (body, @g_HumanPulseArr[msg.Recog], sizeof(TPulseInfo));
          FrmDlg.DBNewWinPointPage2.Visible := g_HumanPulseArr[0].boOpenPulse;
          FrmDlg.DBNewWinPointPage3.Visible := g_HumanPulseArr[1].boOpenPulse;
          FrmDlg.DBNewWinPointPage4.Visible := g_HumanPulseArr[2].boOpenPulse;
          if g_HumanPulseArr[3].boOpenPulse then g_btPulseOriginPage := 6;  //×îºóÒ»¸öÑ¨Î»´òÍ¨ ²»ÏÔÊ¾Ñ¨Î»·¢ÁÁ
        end;
      end;
//½ðÕëÏà¹Ø
      SM_EXERCISEKIMNEEDLE_OK: begin
        //g_btKimNeedleTextImginsex := 0;
        g_btKimNeedleSuccess := 1;
        FillChar (g_KimNeedleItem, sizeof(TClientItem)*8, #0);
        FrmDlg.DStartKimNeedle.ShowHint := False;
        g_btKimItemNum := 0;
        g_btKimNeedleNum := 0;
        //g_nKimSuccessRate := 0;
        g_btKimItemOneLevel := 0;
        g_btKimNeedleSuccessShape := msg.Param;
        g_btKimNeedleSuccessExplImginsex := 0;
      end;
      SM_EXERCISEKIMNEEDLE_FAIL: begin
        //g_btKimNeedleTextImginsex := 0;
        g_btKimNeedleSuccess := 2;
        FillChar (g_KimNeedleItem, sizeof(TClientItem)*8, #0);
        FrmDlg.DStartKimNeedle.ShowHint := False;
        g_btKimItemNum := 0;
        g_btKimNeedleNum := 0;
        //g_nKimSuccessRate := 0;
        g_btKimItemOneLevel := 0;
        g_btKimNeedleSuccessShape := 0;
      end;
      SM_OPENMAKEKIMNEEDLE: begin//ÏÔÊ¾¶ÍÁ·½ðÕë´°¿Ú
        with FrmDlg do begin
          ShowKimNeedle(True);
          FillChar (g_KimNeedleItem, sizeof(TClientItem)*8, #0);
          g_btKimItemNum := 0;
          g_btKimNeedleNum := 0;
          g_btKimItemOneLevel := 0;
          g_nKimSuccessRate := 0;
          g_btKimNeedleSuccess := 0;
          g_btKimNeedleSuccessShape := 0;
          FrmDlg.DKimNeedleHelp.ShowHint := False;
          FrmDlg.DKimNeedleMemo.ShowHint := False;
          FrmDlg.DStartKimNeedle.ShowHint := False;
          FrmDlg.DKimNeedleBar.ShowHint := False;
          //g_boShowKimBar := False;
          DKimNeedleBar.Visible := True;
          DWKimNeedle.Visible := True;
          DItemBag.GLeft := 26;
          DItemBag.GTop := 52;
          DItemBag.Visible := True;
          //DMerchantDlg.Visible := False;
          CloseMDlg;//¹Ø±ÕNPC½çÃæ
          CloseMBigDlg;
        end;
      end;
//µþ¼ÓÎïÆ·
      SM_MERGER_OK: g_MergerItem.S.Name := '';
      SM_MERGER_FAIL: begin
        if msg.Param = 1 then
          AddHeroItemBag(g_MergerItem)
        else AddItemBag (g_MergerItem);
        g_MergerItem.S.Name := '';
      end;
//============================================================
      SM_WINCATTLEGASEXP: begin
        if msg.Series = 1 then
          DScreen.AddBottomSysMsg (IntToStr(LongWord(MakeLong(msg.Param,msg.Tag)))+' µãÐÄ·¨¾­ÑéÔö¼Ó',1)
        else DScreen.AddBottomSysMsg (IntToStr(LongWord(MakeLong(msg.Param,msg.Tag)))+' µãÅ£ÆøÖµÔö¼Ó',1);
      end;
      SM_SENDCATTLEGASEXP: begin //Å£ÆøÖµ¾­ÑéÓëÉÏÏÞÖµ 20090520
        boShowNQExpFalsh := True;
        ShowNQExpInc1 := 0;
        g_dwNQExp := LongWord(MakeLong(msg.Recog,msg.Param));
        g_dwNQMaxExp := LongWord(MakeLong(msg.Tag,msg.Series));
      end;
      SM_SENDCATTLEGASLEVEL: begin
        g_btNQLevel := msg.Recog;
        if g_btNQLevel <= 5 then begin
          with FrmDlg do begin
            d := g_WMainImages.Images[560+g_btNQLevel-1];
            if d <> nil then begin
              DWNQState.SetImgIndex(g_WMainImages, 560+g_btNQLevel-1);
              case g_btNQLevel-1 of
                0: begin
                  DNQExp.SetImgIndex(g_WMainImages, 564);
                  DNQBoxs.GLeft := 54;
                end;
                1: begin
                  DNQExp.SetImgIndex(g_WMainImages, 569);
                  DNQBoxs.GLeft := 94;
                end;
                2: begin
                  DNQExp.SetImgIndex(g_WMainImages, 574);
                  DNQBoxs.GLeft := 154;
                end;
                3: begin
                  DNQExp.SetImgIndex(g_WMainImages, 579);
                  DNQBoxs.GLeft := 230;
                end;
              end;
            end;
          end;
        end;
      end;
      SM_OPENCATTLEGAS: begin //Recog²ÎÊýÎª1Ê±Îª¹Ø±Õ¡¢2Îª¿ªÆô
        with FrmDlg do begin
          case msg.Recog of
            1: DWNQState.Visible := False;
            2:begin
              if msg.Param = 0 then begin //ÇåÀí±äÁ¿
                g_btNQLevel:= 1;   //Å£ÆøµÈ¼¶ 20090520
                g_dwNQExp:= 0; //Å£Æøµ±Ç°¾­Ñé 20090520
                g_dwNQMaxExp:= 0; //Å£ÆøÉý¼¶¾­Ñé 20090520

                d := g_WMainImages.Images[560];
                if d <> nil then begin
                  DWNQState.SetImgIndex(g_WMainImages, 560);
                  DWNQState.GLeft := 300;
                  DWNQState.GTop := 22;
                  DNQExp.SetImgIndex(g_WMainImages, 564);
                  DNQBoxs.GLeft := 54;
                end;
              end else g_btNQLevel := msg.Tag;
              { }
              DWNQState.Visible := True;
            end;
          end;
        end;
      end;
//============================================================
      SM_OPENEXPCRYSTAL: begin   //Recog²ÎÊýÎª1Ê±Îª¹Ø±Õ¡¢2Îª¿ªÆô
        with FrmDlg do begin
          case msg.Recog of
            1: DWExpCrystal.Visible := False;
            2:begin
              if msg.Param = 0 then begin
                //Çå¿Õ¾­ÑéºÍÄÚ¹¦¾­Ñé£¬Çå¿ÕµÈ¼¶¡¢ÉÏÏÞ
                g_btCrystalLevel:= 1;   //ÌìµØ½á¾§µÈ¼¶ 20090201
                g_dwCrystalExp:= 0; //ÌìµØ½á¾§µ±Ç°¾­Ñé 20090201
                g_dwCrystalMaxExp:= 0; //ÌìµØ½á¾§Éý¼¶¾­Ñé 20090201
                g_dwCrystalNGExp:= 0;//ÌìµØ½á¾§µ±Ç°ÄÚ¹¦¾­Ñé 20090201
                g_dwCrystalNGMaxExp:=0;//ÌìµØ½á¾§ÄÚ¹¦Éý¼¶¾­Ñé 20090201
              end;
              //ÌìµØ½á¾§
              d := g_WMainImages.Images[464];
              if d <> nil then begin
                DWExpCrystal.SetImgIndex(g_WMainImages, 464);
                DWExpCrystal.GLeft := 0;
                DWExpCrystal.GTop := 95;
                DCrystalExp.SetImgIndex(g_WMainImages, 484);
                DCrystalNGExp.SetImgIndex(g_WMainImages, 485);
              end;
              DWExpCrystal.Visible := True;
            end;
          end;
        end;
      end;
      SM_SENDCRYSTALNGEXP: begin //½ÓÊÕÌìµØ½á¾§ÄÚ¹¦¾­Ñé
        str2 := DecodeString (body);
        if str2 <> '' then begin
          str2 := GetValidStr3(str2, str3,  ['/']);
          str2 := GetValidStr3(str2, tagstr,  ['/']);
          if str3 <> '' then g_dwCrystalNGExp := StrToInt64(Str3);//ÌìµØ½á¾§µ±Ç°ÄÚ¹¦¾­Ñé 20090201
          if tagstr <> '' then g_dwCrystalMaxExp := StrToInt64(tagstr);//ÌìµØ½á¾§Éý¼¶¾­Ñé 20090201
          if str2 <> '' then g_dwCrystalNGMaxExp := StrToInt64(Str2);//ÌìµØ½á¾§ÄÚ¹¦Éý¼¶¾­Ñé 20090201
        end;
      end;
      SM_SENDCRYSTALEXP: begin //½ÓÊÕÌìµØ½á¾§¾­Ñé
        str2 := DecodeString (body);
        if str2 <> '' then begin
          str2 := GetValidStr3(str2, str3,  ['/']);
          str2 := GetValidStr3(str2, tagstr,  ['/']);
          if str3 <> '' then g_dwCrystalExp := StrToInt64(Str3);//ÌìµØ½á¾§µ±Ç°¾­Ñé 20090201
          if tagstr <> '' then g_dwCrystalMaxExp := StrToInt64(tagstr);//ÌìµØ½á¾§Éý¼¶¾­Ñé 20090201
          if str2 <> '' then g_dwCrystalNGMaxExp := StrToInt64(Str2);//ÌìµØ½á¾§ÄÚ¹¦Éý¼¶¾­Ñé 20090201
        end;
      end;
      SM_SENDCRYSTALLEVEL: begin//½ÓÊÕÌìµØ½á¾§µÈ¼¶
        g_btCrystalLevel := msg.Recog;
        if g_btCrystalLevel <= 5 then begin
          with FrmDlg do begin
            d := g_WMainImages.Images[464+g_btCrystalLevel-1];
            if d <> nil then begin
              DWExpCrystal.SetImgIndex(g_WMainImages, 464+g_btCrystalLevel-1);
              case g_btCrystalLevel-1 of
                0: begin
                  DCrystalExp.SetImgIndex(g_WMainImages, 484);
                  DCrystalNGExp.SetImgIndex(g_WMainImages, 485);
                end;
                1: begin
                  DCrystalExp.SetImgIndex(g_WMainImages, 486);
                  DCrystalNGExp.SetImgIndex(g_WMainImages, 487);
                  DExpCrystalTop.SetImgIndex(g_WMainImages, 468);
                end;
                2: begin
                  DCrystalExp.SetImgIndex(g_WMainImages, 488);
                  DCrystalNGExp.SetImgIndex(g_WMainImages, 489);
                  DExpCrystalTop.SetImgIndex(g_WMainImages, 470);
                end;
                3: begin
                  DCrystalExp.SetImgIndex(g_WMainImages, 490);
                  DCrystalNGExp.SetImgIndex(g_WMainImages, 491);
                  DExpCrystalTop.SetImgIndex(g_WMainImages, 472);
                end;
                4: begin
                  DCrystalExp.SetImgIndex(g_WMainImages, 490);
                  DCrystalNGExp.SetImgIndex(g_WMainImages, 491);
                  DExpCrystalTop.SetImgIndex(g_WMainImages, 474);
                  d := g_WMainImages.Images[464+g_btCrystalLevel-2];
                  if d <> nil then
                    DWExpCrystal.SetImgIndex(g_WMainImages, 464+g_btCrystalLevel-2);
                end;
              end;
            end;
          end;
        end;
      end;
//ÌìµØ½á¾§
//============================================================
//¸ÐÌ¾ºÅ 20090126
      SM_SHOWSIGHICON: begin
        g_sSighIcon := '';
        if body <> '' then begin
          FrmDlg.DSighIcon.Visible := True;
          g_sSighIcon := DecodeString(body);
        end;
      end;
      SM_HIDESIGHICON: begin
        FrmDlg.DSighIcon.Visible := False;
      end;
      SM_UPDATETIME: begin//Í³Ò»ÓëM2µÄÊ±¼ä 20090129
        if (msg.Recog > 0) and (Dscreen.m_boCountDown) then begin
          Dscreen.m_dwCountDownTimer := msg.Recog;
          Dscreen.m_dwCountDownTimeTick := GetTickCount;
          Dscreen.m_dwCountDownTimeTick1 := GetTickCount;
        end;
      end;
//============================================================
//ÄÚ¹¦
      SM_MAGIC69SKILLEXP: begin   //ÈËÎïµÄÄÚ¹¦
        g_dwInternalForceLevel := msg.Series; //ÄÚ¹¦µÈ¼¶
        body := DecodeString (body);
        if body <> '' then begin  //ÄÚ¹¦µ±Ç°¾­Ñé/ÄÚ¹¦Éý¼¶¾­Ñé
          str2 := GetValidStr3(body, str3,  ['/']);
          if str3 <> '' then g_dwExp69 := StrToInt64(Str3);
          if str2 <> '' then g_dwMaxExp69 := StrToInt64(Str2);
        end;
        {$IF M2Version <> 2} //not 1.76
        if not g_boNewStateWin then begin
          d := g_WMain2Images.Images[740];
          if d <> nil then
            FrmDlg.DStateWin.SetImgIndex (g_WMain2Images, 740); //ÈËÎï×´Ì¬  4¸ñÍ¼
        end;
        g_boIsInternalForce := True;
        FrmDlg.DStateTab.Visible := True;
        FrmDlg.SetNewWinStateTabVisible(True, False);
        {$IFEND}
      end;
      {$IF M2Version <> 2}
      SM_HEROMAGIC69SKILLEXP: begin  //Ó¢ÐÛµÄÄÚ¹¦
        g_dwHeroInternalForceLevel := msg.Series; //ÄÚ¹¦µÈ¼¶
        body := DecodeString (body);
        if body <> '' then begin  //ÄÚ¹¦µ±Ç°¾­Ñé/ÄÚ¹¦Éý¼¶¾­Ñé
          str2 := GetValidStr3(body, str3,  ['/']);
          if str3 <> '' then g_dwHeroExp69 := StrToInt64(Str3);
          if str2 <> '' then g_dwHeroMaxExp69 := StrToInt64(Str2);
        end;
        if not g_boNewHeroState then begin
          d := g_WMain2Images.Images[748];
          if d <> nil then
            FrmDlg.DStateHero.SetImgIndex (g_WMain2Images, 748); //ÈËÎï×´Ì¬  4¸ñÍ¼
        end;
        g_boIsHeroInternalForce := True;
        FrmDlg.DHeroStateTab.Visible := True;
        FrmDlg.SetNewHeroStateTabVisible(True);
      end;
      {$IFEND}
      SM_MAGIC69SKILLNH: begin//20110226
        PlayScene.SendMsg (SM_MAGIC69SKILLNH, msg.Recog,
                   MakeLong(msg.Param, msg.Tag),
                   msg.nSessionID,
                   0{darkness},
                   0, 0, 0, g_nilFeature,  
                   '');
      end;
      SM_WINNHEXP: begin
        DScreen.AddBottomSysMsg (IntToStr(LongWord(MakeLong(msg.Param,msg.Tag)))+' µãÄÚ¹¦¾­ÑéÔö¼Ó',0);
      end;
      SM_HEROWINNHEXP: begin
        DScreen.AddBottomSysMsg ('(Ó¢ÐÛ)'+IntToStr(LongWord(MakeLong(msg.Param,msg.Tag)))+' µãÄÚ¹¦¾­ÑéÔö¼Ó',0);
      end;
//============================================================
//¿ÉÌ½Ë÷
      SM_CANEXPLORATION: begin
        Actor := PlayScene.FindActor (msg.Recog);
        if actor <> nil then begin
          actor.m_sUserName := '(¿ÉÌ½Ë÷)\'+actor.m_sUserName;
        end;
      end;
//============================================================
//ÌôÕ½
      SM_CHALLENGE_FAIL: begin 
        g_dwQueryMsgTick := GetTickCount;
        FrmDlg.DMessageDlg ('ÌôÕ½±»È¡Ïû£¬Äã±ØÐëºÍÌôÕ½µÄ¶ÔÏóÃæ¶ÔÃæ', [mbOk]);
      end;
      SM_CHALLENGEMENU: begin //´ò¿ªÌôÕ½´°¿Ú
        g_dwQueryMsgTick := GetTickCount;
        g_sChallengeWho := DecodeString (body);
        FrmDlg.OpenChallengeDlg;
      end;
      SM_CLOSECHALLENGE: begin
        FrmDlg.DWChallenge.Visible := False;
      end;
      SM_CHALLENGECANCEL: begin  //È¡ÏûÌôÕ½
        MoveChallengeItemToBag;
        if g_ChallengeDlgItem.S.Name <> '' then begin
          AddItemBag (g_ChallengeDlgItem);  //°¡¹æ¿¡ Ãß°¡
          g_ChallengeDlgItem.S.Name := '';
        end;
        if g_nDealGold > 0 then begin
          g_MySelf.m_nGold := g_MySelf.m_nGold + g_nChallengeGold;
          g_nChallengeGold := 0;
        end;
        FrmDlg.CloseChallengeDlg;
      end;
      SM_CHALLENGEADDITEM_OK: begin
        g_dwChallengeActionTick := GetTickCount;
        if g_ChallengeDlgItem.S.Name <> '' then begin
           AddChallengeItem (g_ChallengeDlgItem);
           g_ChallengeDlgItem.S.Name := '';
        end;
      end;
      SM_CHALLENGEADDITEM_FAIL: begin
        g_dwChallengeActionTick:=GetTickCount;
        if g_ChallengeDlgItem.S.Name <> '' then begin
          AddItemBag(g_ChallengeDlgItem);  
          g_ChallengeDlgItem.S.Name:= '';
        end;
      end;
      SM_CHALLENGEDELITEM_OK: begin
        g_dwChallengeActionTick := GetTickCount;
        if g_ChallengeDlgItem.S.Name <> '' then begin
          g_ChallengeDlgItem.S.Name := '';
        end;
      end;
      SM_CHALLENGEDELITEM_FAIL: begin
        g_dwChallengeActionTick := GetTickCount;
        if g_ChallengeDlgItem.S.Name <> '' then begin
          DelItemBag (g_ChallengeDlgItem.S.Name, g_ChallengeDlgItem.MakeIndex);
          AddChallengeItem (g_ChallengeDlgItem);
          g_ChallengeDlgItem.S.Name := '';
        end;
      end;
      SM_CHALLENGEREMOTEADDITEM: ClientGetChallengeRemoteAddItem (body);
      SM_CHALLENGEREMOTEDELITEM: ClientGetChallengeRemoteDelItem (body);
      //½ð±Ò
      SM_CHALLENCHGGOLD_OK: begin
        g_nChallengeGold:=msg.Recog;
        g_MySelf.m_nGold:=MakeLong(msg.param, msg.tag);
        g_dwChallengeActionTick:=GetTickCount;
      end;
      SM_CHALLENCHGGOLD_FAIL: begin
        g_nChallengeGold:=msg.Recog;
        g_MySelf.m_nGold:=MakeLong(msg.param, msg.tag);
        g_dwChallengeActionTick:=GetTickCount;
      end;
      SM_CHALLENREMOTECHGGOLD: begin
        g_nChallengeRemoteGold:=msg.Recog;
        SoundUtil.PlaySound(s_money); 
      end;
      //½ð¸ÕÊ¯
      SM_CHALLENCHGDIAMOND_OK: begin
        g_nChallengeDiamond:=msg.Recog;
        g_MySelf.m_nGameDiaMond:=MakeLong(msg.param, msg.tag);
        g_dwChallengeActionTick:=GetTickCount;
      end;
      SM_CHALLENCHGDIAMOND_FAIL: begin
        g_nChallengeDiamond:=msg.Recog;
        g_MySelf.m_nGameDiaMond:=MakeLong(msg.param, msg.tag);
        g_dwChallengeActionTick:=GetTickCount;
      end;
      SM_CHALLENREMOTECHGDIAMOND: begin
        g_nChallengeRemoteDiamond:=msg.Recog;
        SoundUtil.PlaySound(s_money); 
      end;
//============================================================
//×Ô¶¯Ñ°Â·
     SM_AUTOGOTOXY: begin
       { if g_SearchMap = nil then begin
           g_SearchMap := TQuickSearchMap.Create;
           g_SearchMap.CurrentMap := Map.m_sCurrentMap;
           g_SearchMap.MapBase := Map.m_sMapBase;
           g_SearchMap.UpdateMapPos(0,0);
        end else begin
          if Map.m_sCurrentMap <> g_SearchMap.CurrentMap then begin
           g_SearchMap.CurrentMap := Map.m_sCurrentMap;
           g_SearchMap.MapBase := Map.m_sMapBase;
           g_SearchMap.UpdateMapPos(0,0);
          end;
        end; }
        //Findpath(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, msg.Param, msg.Tag,True);
        //Timer2.Enabled := True;
        ClientAutoGotoXY(Msg.param {x}, Msg.tag {y});
        if not g_boViewMiniMap then begin   //ÏÔÊ¾Ð¡µØÍ¼
          if GetTickCount > g_dwQueryMsgTick then begin
             g_dwQueryMsgTick := GetTickCount + 3000;
             FrmMain.SendWantMiniMap;
             g_nViewMinMapLv:=1;
             FrmDlg.DWMiniMap.GLeft := SCREENWIDTH - 120; //20080323
             FrmDlg.DWMiniMap.GWidth := 120; //20080323
             FrmDlg.DWMiniMap.GHeight:= 120; //20080323
          end;
        end;
     end;
//============================================================
//EÏµÍ³
      SM_Browser: begin
        if body <> '' then frmBrowser.Open(body);
      end;
//ÊÓÆµ²¥·Å
      SM_PALYVIDEO: begin
        body := DecodeString(body);
        if body <> '' then begin
          if Video <> nil then begin
            if (video.GetState = 1) or (video.GetState = 2) then Video.Stop;
            if Video.Play(g_ParamDir+'\'+ body) then TimerBrowserUpdate.Enabled := True;
          end;
        end;
      end;
{******************************************************************************}
//Ë«Ó¢ÐÛ
      SM_MOVEMESSAGE1: begin //¸´³ð±ê¼Æµ¹¼ÆÊ±
        str := DecodeString (body);
        if str <> '' then begin
          Dscreen.AddHeroCountDown(Lobyte(Msg.Param),msg.Tag,str); //ÁÄÌìÀ¸ÉÏÃæÓ¢ÐÛ¸´³ðµ¹¼ÇÊ±
        end else Dscreen.m_boHeroCountDown:= False;
      end;
      SM_GOLDGAMEGIRDCHANGED: begin ;//¸üÐÂ½ð±Ò¼°Áé·û
        if msg.Recog > g_MySelf.m_nGold then begin
          DScreen.AddSysMsg (IntToStr(msg.Recog-g_MySelf.m_nGold) +' '+ g_sGoldName{'½ð±Ò¡£'}+'Ôö¼Ó.');
        end;
        g_MySelf.m_nGold := msg.Recog;
        g_MySelf.m_nGameGird:=MakeLong(msg.Param,msg.Tag);
      end;
      SM_ASSESSMENTHEROINFO: begin //»ñµÃÆÀ¶¨Ó¢ÐÛÊý¾Ý
        ClientGetDeputyHeroInfo (body);
        with FrmDlg do begin
          DHeroAssessSign.ShowHint := False;
          DWHeroAssess.SetImgIndex(g_WMainImages, 1540);
          DWHeroAssess.GLeft := 400-DWHeroAssess.GWidth div 2;
          DWHeroAssess.GTop := 300-DWHeroAssess.GHeight div 2;
          DHeroAssessSign.Visible := True;
          DHeroAssessSign1.SetImgIndex(g_WMainImages, 1546);
          DHeroAssessSign1.Hint := 'Ó¢ÐÛÆÀ¶¨';
          DHeroAssessSign1.GLeft := 16;
          DHeroAssessSign1.GTop := 158;
          DHeroAssessSign1.ShowHint := False;
          DHeroAssessClose1.SetImgIndex(g_WMainImages, 1546);
          DHeroAssessClose1.Hint := 'Àë  ¿ª';
          DHeroAssessClose1.GLeft := 16;
          DHeroAssessClose1.GTop := 194;
          DHeroAssessClose1.ShowHint := False;
          DHeroAssessMenu.Visible := False;
          g_btHeroAssessMenuIndex := 0;
          DWHeroAssess.Visible := True;
        end;
      end;
      SM_ASSESSMENTHERO_OK: begin //ÆÀ¶¨³É¹¦
        Inc(m_nSendMsgCount, 3);
        m_btDeputyHeroJob := msg.Series;
        FrmDlg.DMessageDlg ('ÆÀ¶¨³É¹¦£¬Ö÷½«Ó¢ÐÛºÍ¸±½«Ó¢ÐÛ³ö½«£¡ÇëÓÚÃËÖØ¾Æ¹ÝÍâÏèÌìµÈÈË´¦²ÎÓë¸±\½«Ó¢ÐÛ³õ´ÎÑµÁ·¡£', [mbOk]);
        FrmDlg.DWHeroAssess.Visible := False;
      end;
      SM_ASSESSMENTHERO_FAIL: begin //ÆÀ¶¨Ê§°Ü
        FrmDlg.DMessageDlg ('ÄúµÄÓ¢ÐÛÏÖÔÚ²»Âú×ã³ÉÎª¸±½«Ó¢ÐÛµÄÌõ¼þ£¡\¿ÉÄÜÔ­Òò£ºÁ½Î»Ó¢ÐÛµÈ¼¶ÏàÍ¬ÎÞ·¨½øÐÐÆÀ¶¨', [mbOk]);
        FrmDlg.DWHeroAssess.Visible := False;
      end;
      SM_OPENHEROAUTOPRA: begin //´ò¿ªÓ¢ÐÛ×ÔÎÒÐÞÁ¶´°¿Ú
        g_sHeroAutoPracticeChrName := body;
        g_btHeroAutoPracticeJob := msg.Series;
        g_btHeroAutoPracticeSex := msg.Recog;
        g_btHeroAutoPracticeGameGird1:= msg.Param;//×Ô¶¯ÐÞÁ¶ÖÐÇ¿¶ÈÁé·ûÊý
        g_btHeroAutoPracticeGameGird2:= msg.Tag;//×Ô¶¯ÐÞÁ¶¸ßÇ¿¶ÈÁé·ûÊý
        with FrmDlg do begin
          DWHeroAutoPractice.GLeft := 400 - DWHeroAutoPractice.GWidth div 2;
          DWHeroAutoPractice.GTop := 300 - DWHeroAutoPractice.GHeight div 2;
          DStartHeroAutoPra.ShowHint := False;
          DWHeroAutoPractice.Visible := True;
        end;
      end;
      SM_HEROAUTOPRACTICE_OK: begin
        FrmDlg.DMessageDlg ('¸±½«Ó¢ÐÛ¿ªÊ¼×Ô¶¯ÐÞÁ¶£¬µ±½ð±ÒÁé·û²»×ãÊ±£¬½«×Ô¶¯Í£Ö¹ÐÞÁ¶¡£\¸±½«Ó¢ÐÛ±»ÕÙ³ö£¬Ò²½«Í£Ö¹ÐÞÁ¶¡£\µ±ÇÒ½öµ±¸±½«Ó¢ÐÛÐÞÁ¶ Âú2Ð¡Ê±£¬ÇÒÔÚ¾Æ¹ÝÏèÌìµÈÈË´¦ÖÕÖ¹ÑµÁ·Ê±£¬½«ÓÐ\¼¸ÂÊ´ø»ØÐÞÁ¶¹ý³ÌÖÐÊ°È¡µÄÎïÆ·¡£\Ð¡ÍËÏÂÏßºó¸±½«Ó¢ÐÛµÄ×ÔÎÒÐÞÁ¶ÔÝÍ£ ¡£', [mbOk]);
        FrmDlg.DWHeroAutoPractice.Visible := False;
      end;
{******************************************************************************}
//¾Æ¹Ý 20080514
      SM_GETHEROINFO: begin //»ñµÃ²Ö¿âÓ¢ÐÛ
        ClientGetHeroInfo (body);
        FrmDlg.DWiGetHero.Visible := True;
      end;
      SM_SENDUSERPLAYDRINK: begin //Çë¾Æ
        ClientGetSendUserPlayDrink (msg.Recog);
      end;
      SM_USERPLAYDRINK_OK:
         begin
            FrmDlg.LastestClickTime := GetTickCount;
            FrmDlg.CloseMDlg;//¹Ø±ÕNPC½çÃæ
            FrmDlg.CloseMBigDlg;
            FrmDlg.DItemBag.Visible := False;
            //FrmDlg.DPlayDrink.Visible := True; //¶·¾Æ½çÃæ³öÏÖ
         end;
      SM_USERPLAYDRINK_FAIL:
         begin
            FrmDlg.LastestClickTime := GetTickCount;
            AddItemBag (g_SellDlgItemSellWait);
            g_SellDlgItemSellWait.S.Name := '';
            FrmDlg.DMessageDlg ('Äã¸øÎÒµÄ¾ÆÔÚÄÄÄØ£¿', [mbOk]);
         end;
      SM_PLAYDRINKSAY: begin
         ClientGetPlayDrinkSay(msg.Recog,msg.Param, DecodeString(body));
      end;
      SM_OPENPLAYDRINK: begin
         FrmDlg.CloseMDlg;//¹Ø±ÕNPC½çÃæ
         FrmDlg.CloseMBigDlg;
         g_btShowPlayDrinkFlash := 0; //²»ÏÔÊ¾¶¯»­
         if msg.Tag = 1 then begin
            FrmDlg.DPlayDrink.Visible := True;//´ò¿ª¶·¾Æ½çÃæ
            FrmDlg.DDrink1.Visible := True;
            FrmDlg.DDrink2.Visible := True;
            FrmDlg.DDrink3.Visible := True;
            FrmDlg.DDrink4.Visible := True;
            FrmDlg.DDrink5.Visible := True;
            FrmDlg.DDrink6.Visible := True;
            FrmDlg.DPlayDrinkFist.Visible := True;
            FrmDlg.DPlayDrinkScissors.Visible := True;
            FrmDlg.DPlayDrinkCloth.Visible := True;
            FrmDlg.DPlayDrinkWhoWin.Visible := False;
            FrmDlg.DPlayDrinkNpcNum.Visible := False;
            FrmDlg.DPlayDrinkPlayNum.Visible := False;
            g_boStopPlayDrinkGame := False;
            g_boPlayDrink := False;
            g_boPermitSelDrink := False;
            g_btDrinkValue[0] := 0;
            g_btDrinkValue[1] := 0;
            g_btTempDrinkValue[0] := 0;
            g_btTempDrinkValue[1] := 0;
            g_btWhoWin := 3; //20080614
            FrmDlg.DPlayFist.Visible := False;
            g_btPlayDrinkGameNum := 4;
            //---ÒÔÏÂ¸úNPCËæ»úÑ¡¾ÆÓÐ¹Ø
            g_NpcRandomDrinkList.Clear;
            for I:=0 to 5 do g_NpcRandomDrinkList.Add(Pointer(I));//µÃµ½Ë³ÐòÅÅÁÐµÄ¾Æ
            //---
         end;
         if msg.Tag = 2 then begin
            FrmDlg.DWPleaseDrink.Visible := True; //´ò¿ªÇë¾Æ½çÃæ
            FrmDlg.DWPleaseDrink.GLeft := 0;
            FrmDlg.DWPleaseDrink.GTop  := 0;
            FrmDlg.DItemBag.GLeft := 425;
            FrmDlg.DItemBag.GTop  := 20;
            FrmDlg.DItemBag.Visible := True;
         end;

         g_btNpcIcon := msg.Series;
         g_nShowPlayDrinkFlashImg := 0;
         g_sNpcName := '';
         if Body <> '' then g_sNpcName := Body;
      end;
      SM_PlayDrinkToDrink: begin //ÒýÇæ·¢À´²ÂÈ­Âë Ë­ÊäË­Ó®
         g_btPlayNum := msg.Recog; //Íæ¼ÒµÄÂë
         g_btNpcNum  := msg.Tag;   //NPCµÄÂë
         g_btWhoWin := msg.Series; //0-Ó®  1-Êä  2-Æ½
         if g_btWhoWin = 2 then g_boPermitSelDrink := False;
         if g_btWhoWin = 0 then g_boHumWinDrink := False; //20080614 Íæ¼ÒÓ®£¬ÊÇ·ñºÈÁË¾Æ
         g_nImgLeft := 0;
         g_nPlayDrinkDelay := 0;
         g_boPlayDrink := True;
         FrmDlg.ShowPlayDrinkImg(True);
      end;
      SM_DrinkUpdateValue: begin
         if g_btWhoWin = 0 then g_boHumWinDrink := True; //20080614 Íæ¼ÒÓ®£¬ÊÇ·ñºÈÁË¾Æ
         if msg.Param = 1 then begin  //²ÎÊý0-¿ÉÒÔ¼ÌÐøºÈ 1-¶·¾Æ½áÊø
           g_boStopPlayDrinkGame := True;
         end;
         g_btTempDrinkValue[0] := msg.Tag;
         g_btTempDrinkValue[1] := msg.Series;
         if msg.Recog = 0 then //Íæ¼ÒºÈ¾Æ
          g_btShowPlayDrinkFlash := 2
         else g_btShowPlayDrinkFlash := 1;
         g_nShowPlayDrinkFlashImg := 0;
         g_boPermitSelDrink := False;
      end;
      SM_CLOSEDRINK: begin
         FrmDlg.DPlayDrink.Visible := False;
         FrmDlg.DWPleaseDrink.Visible := False;
      end;
      SM_USERPLAYDRINKITEM_OK: begin
         FillChar (g_PDrinkItem, sizeof(TClientItem)*2, #0);
         g_btShowPlayDrinkFlash := 1;
      end;
      SM_USERPLAYDRINKITEM_FAIL: begin
         AddItemBag (g_PDrinkItem[0]);
         AddItemBag (g_PDrinkItem[1]);
      end;
//¾Æ¹Ý2¾í
      SM_OPENMAKEWINE: begin
        if (msg.Param in [0,1]) and (body <> '') then begin
          g_MakeTypeWine := msg.Param;
          g_sNpcName := body;
          if g_MakeTypeWine = 0 then begin //ÆÕÍ¨¾Æ
            with FrmDlg do begin
              DMakeWineHelp.Hint := 'ÈçºÎÄð¾Æ';
              DMaterialMemo.Hint := '²ÄÁÏËµÃ÷';
            end;
          end else begin  //Ò©¾Æ
            with FrmDlg do begin
              DMakeWineHelp.Hint := 'ÈçºÎÅäÖÃ';
              DMaterialMemo.Hint := 'Ò©Ð§ËµÃ÷';
            end;
          end;
          with FrmDlg do begin
            DMakeWineHelp.ShowHint := False;
            DMaterialMemo.ShowHint := False;
            ShowMakeWine(True);
            DWMakeWineDesk.GLeft := 380;
            DWMakeWineDesk.GTop  := 50;
            DWMakeWineDesk.Visible := True;
            CloseMDlg;//¹Ø±ÕNPC½çÃæ
            CloseMBigDlg;
            DItemBag.GLeft := 20;
            DItemBag.GTop  := 34;
            DItemBag.Visible := True;
          end;
        end;
      end;
      SM_MAKEWINE_OK: begin //Äð¾Æ³É¹¦
        if (msg.Param in [0,1]) then begin
          if msg.Param = 1 then //Ò©¾Æ
            FillChar (g_DrugWineItem, sizeof(TClientItem)*3, #0)
          else  //ÆÕÍ¨¾Æ
            FillChar (g_WineItem, sizeof(TClientItem)*7, #0);
          FrmDlg.DWMakeWineDesk.Visible := False;
          FrmDlg.DItemBag.Visible := False;
        end;
      end;
      SM_MAKEWINE_FAIL: begin//Äð¾ÆÊ§°Ü
        if (msg.Param in [0,1]) then begin
          if msg.Param = 1 then begin//Ò©¾Æ
            for I:=Low(g_DrugWineItem) to High(g_DrugWineItem) do begin
              if g_DrugWineItem[I].s.Name <> '' then begin  //Ò©¾Æ
                AddItemBag(g_DrugWineItem[I]);
                g_DrugWineItem[I].s.Name := '';
              end;
            end;
          end else begin  //ÆÕÍ¨¾Æ
            for I:=Low(g_WineItem) to High(g_WineItem) do begin
              if g_WineItem[I].s.Name <> '' then begin
                AddItemBag(g_WineItem[I]);
                g_WineItem[I].s.Name := '';
              end;
            end;
          end;
          FrmDlg.DWMakeWineDesk.Visible := False;
          FrmDlg.DItemBag.Visible := False;
        end;
      end;
      SM_PLAYMAKEWINEABILITY: begin //ÈËÎï¾Æ2Ïà¹ØÊôÐÔ 20080804
        //str4 := '';
        if msg.Recog >= 0 then
          g_MySelf.m_Abil.Alcohol := msg.Recog;
        g_MySelf.m_Abil.MaxAlcohol := msg.Param;
        g_MySelf.m_Abil.WineDrinkValue := msg.Tag;
        g_MySelf.m_Abil.MedicineValue := msg.Series;
        g_MySelf.m_Abil.MaxMedicineValue := msg.nSessionID;//20090302 ÐÞ¸Ä
        {str4 := DecodeString (body);
        if str4 <> '' then begin
          if StrToInt(str4) >= 0 then begin
            g_MySelf.m_Abil.MaxMedicineValue := StrToInt(str4);
          end;
        end;}
      end;
      SM_HEROMAKEWINEABILITY: begin //Ó¢ÐÛ¾Æ2Ïà¹ØÊôÐÔ 20080804
        //str5 := '';
        if msg.Recog >= 0 then
          g_HeroSelf.m_Abil.Alcohol := msg.Recog;
        g_HeroSelf.m_Abil.MaxAlcohol := msg.Param;
        g_HeroSelf.m_Abil.WineDrinkValue := msg.Tag;
        g_HeroSelf.m_Abil.MedicineValue := msg.Series;
        g_HeroSelf.m_Abil.MaxMedicineValue := msg.nSessionID;//20090302 ÐÞ¸Ä
        {str5 := DecodeString (body);
        if str5 <> '' then begin     
          if StrToInt(str5) >= 0 then begin
            g_HeroSelf.m_Abil.MaxMedicineValue := StrToInt(str5);
          end;
        end;}
      end;
{******************************************************************************}
      SM_GLORY: begin  //ÈÙÓþ
        g_btGameGlory := Max(0,msg.Recog);
      end;
{******************************************************************************}
//´âÁ·
      SM_QUERYREFINEITEM: begin//NPC´ò¿ª´âÁ·´°¿Ú 20080506
        if not FrmDlg.DItemsUp.Visible then begin
           FrmDlg.DItemsUp.Visible := True;
        end;
      end;
      SM_UPDATERYREFINEITEM: begin //¸üÐÂ´ãÁ¶ÎïÆ· 20080507
         ClientGetUpDateUpItem (body);
      end;
      SM_REPAIRFINEITEM_OK:begin //ÐÞ²¹»ðÔÆÊ¯³É¹¦  20080507
         g_boItemMoving := false;
         g_MovingItem.Item.S.Name := '';
         g_WaitingUseItem.Item.S.Name := '';
      end;
      SM_REPAIRFINEITEM_FAIL:begin //ÐÞ²¹»ðÔÆÊ¯Ê§°Ü  20080507
        AddItemBag (g_WaitingUseItem.Item);
        g_WaitingUseItem.Item.S.Name := '';
      end;
      SM_OPENREFINEARMYDRUM: begin
            Body := DecodeString(Body);
            case Msg.Recog of
              1: begin // ´ò¿ª´ãÁ¶´°¿Ú        g_RefineDrumCount

                  FillChar(g_RefineDrumItem, SizeOf(g_RefineDrumItem), 0);
                  FrmDlg1.DWRefineDrum.Visible := True;
                end;
              2: begin
                  FillChar(g_RefineDrumItem, SizeOf(g_RefineDrumItem), 0);
                  FrmDlg1.DWRefineDrum.Visible := False;
                  FrmDlg.DMessageDlg('ºÏ³ÉÎïÆ·: ' + Body + ' ³É¹¦!', [mbOK]);
                end

            else begin
                //if Body = '' then
                  Body := 'ºÏ³ÉÎïÆ·Ê§°Ü!';
                //ÐÞ¸´ºÏ³ÉÊ§°Ü²»·µ»¹ÎïÆ· By TasNat at: 2012-08-05 17:17:51
                if Msg.Recog <> 3 then //ÐÞ¸´RandomÊ§°Ü»¹·µ»¹ÎïÆ·By TasNat at: 2012-10-31 12:38:16
                for I := Low(g_RefineDrumItem) to high(g_RefineDrumItem) do
                  if g_RefineDrumItem[I].s.Name <> '' then AddItemBag(g_RefineDrumItem[I]);
                FillChar(g_RefineDrumItem, SizeOf(g_RefineDrumItem), 0);

                FrmDlg.DMessageDlg(Body, [mbOK]);
                FrmDlg1.DBRefineDrumCloseBtnClick(nil, 0, 0);
              end;
            end;
          end;
{******************************************************************************}

      SM_SELLOFFBUY_OK: begin  //¼ÄÊÛÂò·½ÊÕ¹º³É¹¦ 20080318
        ArrangeItembag;   //ÕûÀí°ü¹ü
        FrmDlg.DWSellOffList.Visible := False; //ÁÐ±íÐÅÏ¢À¸²»¿É¼û
        FillChar (g_SellOffInfo, sizeof(TClientDealOffInfo), #0); //Çå¿Õ¼ÄÊÛÁÐ±íÎïÆ· 20080318
      end;
      SM_SELLOFFEND_OK: begin   //¼ÄÊÛ³É¹¦
        FrmDlg.DWSellOff.Visible := False;
        FillChar (g_SellOffItems, sizeof(TClientItem)*9, #0); //ÊÍ·Å¼ÄÊÛ´°¿ÚÎïÆ· 20080318
      end;
      SM_SELLOFFEND_FAIL: begin
        MoveSellOffItemToBag;
        if g_SellOffDlgItem.S.Name <> '' then begin
          AddItemBag (g_SellOffDlgItem);
          g_SellOffDlgItem.S.Name := '';
        end;
        FillChar (g_SellOffItems, sizeof(TClientItem)*9, #0); //ÊÍ·Å¼ÄÊÛ´°¿ÚÎïÆ· 20080318
        g_SellOffName := '';
        g_SellOffGameGold := 0;
        g_SellOffGameDiaMond := 0;
      end;
      SM_QUERYYBSELL: begin  //²éÑ¯Ôª±¦¼ÄÊÛÕýÔÚ³öÊÛµÄÎïÆ·  20080317
        ClientGetSellOffSellItem (body);
      end;
      SM_QUERYYBDEAL: begin  //²éÑ¯Ôª±¦¼ÄÊÛ¿ÉÒÔ¹ºÂòµÄÎïÆ· 20080317
        ClientGetSellOffMyItem (body);
      end;
      SM_SENDDEALOFFFORM: begin //´ò¿ª¼ÄÊÛ³öÊÛÎïÆ·´°¿Ú 20080316
        ClientGetSendUserSellOff(msg.Recog);
      end;
      SM_SELLOFFADDITEM_OK: begin //Íù³öÔª±¦¼ÄÊÛÊÛÎïÆ·´°¿ÚÀï¼ÓÎïÆ· ³É¹¦ 20080316
        if g_SellOffDlgItem.S.Name <> '' then begin
           AddSellOffItem (g_SellOffDlgItem);
           g_SellOffDlgItem.S.Name := '';
        end;
      end;
      SM_SellOffADDITEM_FAIL: begin  //ÍùÔª±¦¼ÄÊÛ³öÊÛÎïÆ·´°¿ÚÀï¼ÓÎïÆ· Ê§°Ü  20080316
        if g_SellOffDlgItem.S.Name <> '' then begin
          AddItemBag(g_SellOffDlgItem);
          g_SellOffDlgItem.S.Name:= '';
        end;
      end;
      SM_SELLOFFDELITEM_OK: begin    //¼ÄÊÛÎïÆ··µ»Ø°ü¹ü³É¹¦
        //g_dwDealActionTick:=GetTickCount;
        if g_SellOffDlgItem.S.Name <> '' then begin
          g_SellOffDlgItem.S.Name := '';
        end;
      end;
      SM_SELLOFFDELITEM_FAIL: begin  //¼ÄÊÛÎïÆ··µ»Ø°ü¹üÊ§°Ü
        //g_dwDealActionTick := GetTickCount;
        if g_SellOffDlgItem.S.Name <> '' then begin
          DelItemBag (g_SellOffDlgItem.S.Name, g_SellOffDlgItem.MakeIndex);
          AddSellOffItem (g_SellOffDlgItem);
          g_SellOffDlgItem.S.Name := '';
        end;
      end;
      SM_SellOffCANCEL: begin   //È¡Ïû¼ÄÊÛ´°¿Ú
        MoveSellOffItemToBag;
        if g_SellOffDlgItem.S.Name <> '' then begin
          AddItemBag (g_SellOffDlgItem);
          g_SellOffDlgItem.S.Name := '';
        end;
      end;
      SM_CHANGEATTATCKMODE: begin  //¸Ä±ä¹¥»÷Ä£Ê½
        g_sAttackMode := DecodeString (body);
      end;
      SM_OPENBOOKS: begin //´ò¿ªÎÔÁú
      g_nCurMerchant := msg.Recog;
         if msg.Param = 0 then begin
            g_LieDragonPage := 0; //³õÊ¼»¯ ÎÔÁú±Ê¼ÇÒ³Êý
            FrmDlg.DLieDragonPrevPage.Visible := False;
            FrmDlg.DLieDragonNextPage.Visible := True;
            FrmDlg.DGoToLieDragon.Visible := False;
            FrmDlg.DLieDragon.Visible := True;
         end;
         if msg.Param in [1..5] then begin
            g_LieDragonNpcIndex := msg.Param;
            FrmDlg.DLieDragonNpc.Visible := True;
         end;
      end;
      SM_BOXITMEFILLED: begin //½ÓÊÕ±¦ÏäÌî³äÎïÆ·µÄÖÆÔìIDºÅ
        ClientGetBoxsItemFilled(msg.Recog,LongWord(MakeLong(msg.Param,msg.Tag)));
      end;
      SM_GET9YEARSBOXSITEM_OK: begin //¾ÅÖÜÄê±¦ÏäÈ¡ÎïÆ·³É¹¦
        ClientGetJLBoxItemOK();
      end;
      //½ÓÊÕ±¦ÏäÎïÆ·
      //Recog²ÎÊýÎª1Ê± ¸ü»»È«²¿ÎïÆ·ÏÔÊ¾ÌØÊâÐ§¹û  2Ã»ÓÐÍ¬Àà±¦Ïä
      //ParamµÄÒâÒåÎªg_boNewBoxsµÄÒâÒå
      //Tag²ÎÊýÎª1Ê± ¡°¿ªÆôÐÂÌì´Í¡±±êÊ¶
      SM_OPENBOXS: begin
        if msg.Param = 2 then begin //Õäçç±¦Ïä
          ClientGetJLBoxItems (body);
          if msg.Recog = 1 then begin  //¸üÐÂÎïÆ·
            Dec(g_BoxsCircleNum);
            with FrmDlg do begin
              DJLChangeItem.Hint := Format('¸ü»»½±Àø(%d)',[g_BoxsCircleNum]);
              if g_BoxsCircleNum > 0 then DJLChangeItem.ShowHint := False;
              g_BoxsFirstMove := False;   //ÏÔÊ¾ÌáÊ¾
              DJLStartItem.ShowHint := False;
              DJLBoxBelt1.ShowHint := False;
              DJLBoxBelt2.ShowHint := False;
              DJLBoxBelt3.ShowHint := False;
              DJLBoxBelt4.ShowHint := False;
              DJLBoxBelt5.ShowHint := False;
              DJLBoxBelt6.ShowHint := False;
              DJLBoxBelt7.ShowHint := False;
              DJLBoxBelt8.ShowHint := False;
              g_nBoxsImg := 21;
              g_boJLBoxSelToTime := True;
            end;
            g_BoxsIsFill := 2;
          end else begin
            FrmDlg.DJenniferLongBoxClose.GLeft := 461;
            FrmDlg.DJenniferLongBoxClose.GTop :=  12;
            FrmDlg.DJLChangeItem.GLeft := 207;
            FrmDlg.DJLChangeItem.GTop := 105;
            FrmDlg.DJLStartItem.GLeft := 207;
            FrmDlg.DJLStartItem.GTop :=  127;
            g_BoxsCircleNum := 3;
            FrmDlg.DJLChangeItem.Hint := Format('¸ü»»½±Àø(%d)',[g_BoxsCircleNum]);
            FrmDlg.DJLStartItem.Hint := '¿ªÊ¼Ñ¡Ôñ(20)';
            g_BoxsFirstMove := False;   //ÏÔÊ¾ÌáÊ¾
            FrmDlg.DJLChangeItem.ShowHint := False;
            FrmDlg.DJLStartItem.ShowHint := False;
            FrmDLg.DWJenniferLongBox.Visible := True;
            FrmDlg.DGJLBoxFreeItem.Visible := False;
            g_nBoxsImg := 0;
            if msg.Tag <> 1 then begin
              g_boPutBoxsKey := True;
              MyPlaySound(Openbox_ground);
            end;
            g_BoxsMoveDegree := 9;
            g_boBoxsMiddleItems := False;
            g_boBoxsLockGetItems := False;
            g_BoxsMakeIndex := 0;
            g_BoxsIsFill := 0;
            g_nPlayGetItmesID := 0;
            g_nFilledGetItmesID := 3;
            g_boJLBoxFirstStartSel := True;
            FrmDLg.DJLBoxFlash.Visible := True;
            g_boJLBoxSelToTime := False;
            if msg.Tag = 1 then begin
              with FrmDlg do begin
                with DWJenniferLongBox do begin
                  g_boNewBoxs := 2;
                  SetImgIndex(g_WMainImages, 660);
                  GLeft := 148;
                  GTop  := 250;
                  ShowBoxsGird(True, g_boNewBoxs); //ÏÔÊ¾±¦Ïä¸ñ
                  DJenniferLongBoxClose.Visible := True;
                  DJLChangeItem.Visible := True;
                  DJLBoxFlash.Visible := True;
                  DJLStartItem.Visible := True;
                  Visible := True;
                  g_BoxsIsFill := 2;
                  g_boJLBoxSelToTime := True;
                  g_nBoxsImg := 20;
                  g_BoxsFilleFlashImg := 0;
                  MyPlaySound(BoxonCeagain_ground);
                end;
              end;
            end;

          end;
        end else if msg.Param = 3 then begin //Ãâ·Ñ½±ÀøÎïÆ·
          ClientGetJLBoxFreeItems(body);
          if g_nFilledGetItmesID = 0 then begin //Ãâ·Ñ½±Àø
            with FrmDlg do begin
              ShowBoxsGird(False,g_boNewBoxs); //ÏÔÊ¾±¦Ïä¸ñ
              g_boNewBoxs := 3;
              DWJenniferLongBox.SetImgIndex(g_WMainImages, 665);
              DWJenniferLongBox.GLeft := 200;
              DWJenniferLongBox.GTop := 80;
              DJenniferLongBoxClose.GLeft := 314;
              DJLChangeItem.Visible := False;
              DJLStartItem.Visible := False;
              DGJLBoxFreeItem.GLeft := 46;
              DGJLBoxFreeItem.GTop := 40;
              DGJLBoxFreeItem.GWidth := 260;
              DGJLBoxFreeItem.GHeight := 196;
              DGJLBoxFreeItem.Visible := True;
              DJLBoxFlash.Visible := False;
              g_BoxsFilleFlashImg := 0;
              MyPlaySound(BoxonCeagain_ground);
            end;
          end;
          g_BoxsIsFill := 3;
        end else begin
          if msg.Recog <> 2 then begin //Ã»ÓÐÍ¬Àà±¦Ïä
            ClientGetMyBoxsItem (body);
            g_nBoxsImg := 0;
            g_boPutBoxsKey := True;
            g_BoxsCircleNum := 0;  //³õÊ¼»¯×ª¶¯È¦Êý
            g_BoxsShowPosition := 8;
            g_BoxsFirstMove := False; //³õÊ¼»¯µÚ1´Î×ª¶¯
            g_BoxsMoveDegree := 0;  //³õÊ¼»¯ ×ªÅÌ´ÎÊý
            Frmdlg.BoxsRandomImg;
            if msg.Recog <> 1 then //²»ÊÇ¸üÐÂÎïÆ·
            MyPlaySound(Openbox_ground);
          end;
          if msg.Recog = 1 then begin  //¸üÐÂÎïÆ·
            g_BoxsIsFill := 3; //È«²¿»»ÎïÆ·
            MyPlaySound(BoxonCeagain_ground);
            FrmDlg.DBoxsNewClose.Visible := False;
          end;
          if msg.Recog = 2 then begin
            FrmDlg.DBoxsNewClose.Visible := True;
            FrmDlg.DCheckAutoOpenBoxs.Checked := False;
            FrmDlg.DBoxsTautology.Visible := True;
          end;
        end;
      end;
      SM_SEND9YEARSITEMID: begin //Õäçç±¦Ïä½ÓÊÕ¿ÉµÃID
        g_BoxsMakeIndex := msg.Recog;
        if msg.Series <> 1 then ClientJLBoxKey();
      end;
      SM_OPENBOXS_FAIL: begin //·µ»Ø´ò¿ª±¦ÏäÊ§°Ü  20080306
       g_boPutBoxsKey := False;  //20080616
       FrmDlg.DBoxs.Visible := False;
       FrmDlg.ShowBoxsGird(False,g_boNewBoxs); //ÏÔÊ¾±¦Ïä¸ñ
       g_nBoxsImg := 0; //20080616
       g_BoxsShowPosition := -1;
       AddItemBag(g_BoxsTempKeyItems); //·µ»Ø°ü¹ü Ô¿³×
       AddItemBag(g_EatingItem); //·µ»Ø°ü¹ü ±¦Ïä
       g_EatingItem.S.Name := '';
      end;
      SM_OPENDRAGONBOXS: begin //ÎÔÁú¿ª±¦Ïä 20080306
        g_boNewBoxs := 0;//ÀÏ±¦ÏäÄ£Ê½
        g_boPutBoxsKey := False;
        with FrmDlg do begin
          DBoxsTautology.Visible := False;
          DCheckAutoOpenBoxs.Visible := False;
          DBNewHelpBtn.Visible := False;
          DBoxsNewClose.Visible := False;
          DNewBoxsHelp.Visible := False;
          DCheckAutoOpenBoxs.Checked := False;
          if msg.Series <> 1 then begin //½ðÅ£
            g_boJNBox := False;
            DBoxsTautology.SetImgIndex(g_WMain3Images, 511);
            DBoxsTautology.GTop := 175;
            DBoxsTautology.GLeft := 77;
            DBoxsTautology.Visible := True;  //µã»÷¶à´Î×ª¶¯°´Å¥ÏÔÊ¾
          end else g_boJNBox := True;
          DBoxs.SetImgIndex(g_WMain3Images, 510);
          DBoxs.GLeft := 332;
          DBoxs.GTop := 192;
          DBoxs.Visible := True;  //±¦ÏäÏÔÊ¾½çÃæ
          g_BoxsCircleNum := 0;  //³õÊ¼»¯×ª¶¯È¦Êý
          g_BoxsIsFill := 0;
          g_boBoxsMiddleItems := True; //³õÊ¼»¯ÎïÆ·ÎªÖÐ¼ä
          g_BoxsShowPosition := 8;
          g_BoxsFirstMove := False; //³õÊ¼»¯µÚ1´Î×ª¶¯
          g_BoxsMoveDegree := 0;  //³õÊ¼»¯ ×ªÅÌ´ÎÊý
          ShowBoxsGird(True, g_boNewBoxs); //ÏÔÊ¾±¦Ïä¸ñ
          BoxsRandomImg;
          if msg.Series = 1 then begin //½ðÅ£±¦Ïä ×Ô¶¯×ª
            DWJenniferLongBox.Visible := False;
            msg := MakeDefaultMsg (aa(CM_MOVEBOXS, TempCertification), 1, 0, 0, 0, m_nSendMsgCount);
            FrmMain.SendSocket(EncodeMessage(msg));
            if g_BoxsMoveDegree < 1 then begin
              if g_boNewBoxs = 0 then begin
                g_boBoxsShowPosition := True;
                g_BoxsCircleNum := 0; //È¦ÊýÉèÎª0
                g_boBoxsMiddleItems := False; //ÏÔÊ¾ÖÐ¼äÎïÆ·
                g_BoxsFirstMove := True;
                Inc(g_BoxsMoveDegree);
              end;
            end;
          end;
        end;
      end;

      SM_MOVEBOXS: begin
        g_BoxsMakeIndex := msg.Recog;
        g_boBoxsLockGetItems := False;
        FrmDlg.DBoxsNewClose.Visible := False;
        if g_boNewBoxs = 1 then begin
          g_boBoxsShowPosition := True; //×ª¶¯
          g_BoxsCircleNum := 0; //È¦ÊýÉèÎª0
          g_boBoxsMiddleItems := False; //ÏÔÊ¾ÖÐ¼äÎïÆ·
          g_BoxsFirstMove := True;
          Inc(g_BoxsMoveDegree);
          FrmDlg.DBoxsTautology.Visible := False;
        end;
      end;
      SM_SENGSHOPITEMS: begin      //´ò¿ªÉÌÆÌµÄ½çÃæ
        g_ShopReturnPage := msg.Param;
        ClientGetMyShop (body);
      end;
      SM_BUYSHOPITEM_SUCCESS: begin
        if body <> '' then
        FrmDlg.DMessageDlg (DeCodeString(body), [mbOk]);
      end;
      SM_BUYSHOPITEMGIVE_SUCCESS: begin
        if body <> '' then
        FrmDlg.DMessageDlg (DeCodeString(body), [mbOk]);
      end;
      SM_BUYSHOPITEMGIVE_FAIL: begin
        if body <> '' then
        FrmDlg.DMessageDlg (DeCodeString(body), [mbOk]);
      end;
      SM_EXCHANGEGAMEGIRD_SUCCESS: begin //¶Ò»»Áé·û³É¹¦ 20080302
        if body <> '' then
        FrmDlg.DMessageDlg (DeCodeString(body), [mbOk]);
      end;
      SM_EXCHANGEGAMEGIRD_FAIL: begin //¶Ò»»Áé·ûÊ§°Ü 20080302
        if body <> '' then
        FrmDlg.DMessageDlg (DeCodeString(body), [mbOk]);
      end;
      SM_BUYSHOPITEM_FAIL: begin
        if body <> '' then
        FrmDlg.DMessageDlg (DeCodeString(body), [mbOk]);
      end;
      SM_SENGSHOPSPECIALLYITEMS: begin
        ClientGetMyShopSpecially (body);   //ÆæÕäÀàÐÍ
      end;
      //20080102
      SM_REPAIRDRAGON_OK:begin //×£¸£¹Þ.Ä§Áî°ü¹¦ÄÜ
          g_WaitingUseItem.Item.S.Name := '';
      end;
      SM_REPAIRDRAGON_FAIL:begin //×£¸£¹Þ.Ä§Áî°ü¹¦ÄÜ
        AddItemBag (g_WaitingUseItem.Item);
        g_WaitingUseItem.Item.S.Name := '';
      end;
      
      SM_MYSHOW: begin    //msg.Param Îª ÀàÐÍ
          Actor := PlayScene.FindActor (msg.Recog);
          if Actor <> nil then begin
            ShowMyShow(actor, msg.Param);
          end;
      end;
      SM_AddEffecItemList:begin
        New(EffecItem);
        EdCode.DecodeBuffer(body, PChar(EffecItem), SizeOf(TEffecItem));
        g_EffecItemtList.AddObject(EffecItem.sName, TObject(EffecItem));
      end;
//-----------------------------------------------------------
      SM_QUERYUSERLEVELSORT: begin  //ÅÅÐÐ°ñ
        nLevelOrderSortType := msg.Recog;
        nLevelOrderType := msg.Tag;
        nLevelOrderTypePageCount := msg.Series;
        if msg.Param = 65535 then //Èç¹ûµãÎÒµÄÅÅÐÐ ÄÇÃ´ pageÊÇ65535
        nLevelOrderPage := 0
        else nLevelOrderPage := msg.Param;

        if body <> '' then
        ClientGetUserOrder (body);
      end;
      SM_RECALLHERO: begin    //ÕÙ»½Ó¢ÐÛ×ÊÁÏ£¬ÊÇË½ÓÐµÄ  ±ðÈË²»¿ÉÒÔ
          PlayScene.SendMsg (SM_RECALLHERO, msg.Recog,
                             msg.Param{x},
                             msg.tag{y},
                             msg.Series{dir},
                             0, //desc.Feature,
                             0, //desc.Status,
                             0, g_nilFeature,
                             '');
        body := DecodeString(body);
        if body <> '' then g_sMyHeroType := body;
        FrmDlg.DBCallHero.ShowHint := False;
        g_boHeroOpen4BatterSkill := False;
        if g_HeroSelf <> nil then begin
          FrmDlg.DHeroIcon.Visible:=TRUE;
          SendClientMessage (CM_QUERYHEROBAGITEMS, 0, 0, 0, 0);
          if g_boHeroAutoDEfence then SendHeroAutoOpenDefence(1);
        end;
      end;
      SM_CREATEHERO: begin  //´´½¨Ó¢ÐÛµ½¿Í»§¶Ë¡¢ ÊÇ¹²ÓÐ  ±ðÈË¿ÉÒÔ¿´µÃµ½  ±ÈÈç ÕÙ»½¶¯»­
          DecodeBuffer (body, @CharDesc, sizeof(TCharDesc) - SizeOf(TFeatures) + msg.nSessionID);
          PlayScene.SendMsg (SM_CREATEHERO, msg.Recog,
                             msg.Param{x},
                             msg.tag{y},
                             msg.Series{dir},
                             0, //desc.Feature,
                             CharDesc.Status, //desc.Status,
                             CharDesc.MonShowName, CharDesc.feature,
                             '');
          if FrmDlg.DCheckHeroBatterNotMob.Checked then FrmMain.SendHeroUseBatterToMon(1);
          DrawEffectHum(msg.Recog,19,0,0,0);
      end;
      SM_DESTROYHERO: begin
        Actor := PlayScene.FindActor (msg.Recog);
        if (Actor <> nil) and (Actor = g_HeroSelf) then begin
          PlayScene.DeleteActor(msg.Recog);
          g_HeroSelf           :=nil;
          if g_HeroSelf = nil then begin
            with FrmDlg do begin
              DHeroIcon.Visible    := FALSE;
              DStateHero.Visible   := FALSE;
              {$IF M2Version <> 2}
              DWNewStateHero.Visible := False;
              DPNewStateHeroTab.ActivePage := 0;
              DPNewStateHeroPage.ActivePage := 0;
              DPNewStateHeroNGPage.ActivePage := 0;
              {$IFEND}
              DHeroItemBag.Visible := FALSE;
              DBHeroSpleenImg.Visible  := FALSE;
              DBCallHero.ShowHint := True;
              //ÄÚ¹¦--------------------------------
              g_dwHeroInternalForceLevel := 0;
              {$IF M2Version = 1}
              g_boQJHeroDZXY99 := False;
              {$IFEND}
              HeroStateTab := 0;
              g_dwHeroExp69 := 0;
              g_dwHeroMaxExp69 := 0;
              g_boIsHeroInternalForce := FALSE;
              DHeroStateTab.Visible := FALSE;
              HeroStateTab := 0;
              HeroPageChanged;
              DHeroStateWinPulse.Visible := False;
              DHeroStateWinBatter.Visible := False;
            end;
            FrmDlg.DHeroIcon.Visible:=False;
            FillChar (g_HeroItems, sizeof(TClientItem)*U_TakeItemCount, #0);
            FillChar (g_HeroItemArr, sizeof(TClientItem)*MAXBAGITEMCL, #0);
            FillChar (g_HeroHumanPulseArr, SizeOf(THeroPulseInfo1), #0);//³õÊ¼Ó¢ÐÛÂöÑ¨
            g_btHeroStateWinPulseMoving := 0;
            g_boHeroStateWinPulseDowning := False;
            g_btHeroPulseOriginPage:= 0; //m2·¢µÄÔ­µãÁÁ¹âÒ³
            g_btHeroPulsePoint:=0; //m2·¢À´µÄÑ¨Î»
            g_btHeroPulseLevel:=0; //m2·¢À´µÄÑ¨Î»µÈ¼¶
            g_boHeroPulseOpen:= False; //Ó¢ÐÛ¾­ÂöÊÇ·ñ¿ªÍ¨
            g_dwHeroPulsExp:=0; //Ó¢ÐÛµÄ¾­Ñé±äÁ¿
            if g_HeroBatterMagicList.Count > 0 then begin
              for I:=0 to g_HeroBatterMagicList.Count - 1 do begin
                if pTClientMagic(g_HeroBatterMagicList.Items[I]) <> nil then
                 Dispose(pTClientMagic(g_HeroBatterMagicList.Items[I]));
              end;
            end;
            g_HeroBatterMagicList.Clear;
            FillChar (g_HeroBatterTopMagic, sizeof(TClientMagic)*4, #0);
            //Çå¿ÕÓ¢ÐÛÄ§·¨
            if g_HeroMagicList.Count > 0 then //20080629
            for i:=0 to g_HeroMagicList.Count-1 do
            Dispose (PTClientMagic (g_HeroMagicList[i]));
            g_HeroMagicList.Clear;
          end;
        end;
      end;
      SM_HERODEATH: begin  //Ó¢ÐÛËÀÍö
        with FrmDlg do begin
          {$IF M2Version <> 2}
          DWNewStateHero.Visible := False; // DWNewStateHero.Visible
          DPNewStateHeroTab.ActivePage := 0;
          DPNewStateHeroPage.ActivePage := 0;
          DPNewStateHeroNGPage.ActivePage := 0;
          {$IFEND}
          DHeroIcon.Visible    := FALSE;
          DStateHero.Visible   := FALSE;
          DHeroItemBag.Visible := FALSE;
          DBHeroSpleenImg.Visible  := FALSE;
          g_HeroSelf           :=nil;
          FrmDlg.DBCallHero.ShowHint := True;
          //MyPlaySound (HeroHeroLogout_ground);
          if g_HeroSelf = nil then begin
            FrmDlg.DHeroIcon.Visible:=False;
          end;
        end;
      end;
      SM_REPAIRFIRDRAGON_OK:begin //20071231 ÐÞ²¹»ðÁúÖ®ÐÄ³É¹¦
        if msg.Recog = 4 then begin  //Ó¢ÐÛ
          g_boHeroItemMoving := False;
          g_MovingHeroItem.Item.S.Name := '';
        end else begin //ÈËÎï
          g_boItemMoving := False;
          g_MovingItem.Item.S.Name := '';
        end;
      end;
      SM_REPAIRFIRDRAGON_FAIL:begin //20071231 ÐÞ²¹»ðÁúÖ®ÐÄÊ§°Ü
        if msg.Recog = 4 then begin //Ó¢ÐÛ
          AddHeroItemBag (g_MovingHeroItem.Item);
          g_MovingHeroItem.Item.S.Name := '';
          g_boHeroItemMoving := False;
        end else begin //ÈËÎï
          AddItemBag (g_MovingItem.Item);
          g_MovingItem.Item.S.Name := '';
          g_boItemMoving := False;
        end;
      end;
      SM_REPAIRDRAGONINDIA_OK: begin //ÐÞ²¹ÌìÁúÓ¡³É¹¦
        if msg.Recog = 1 then begin
          g_boHeroItemMoving := false;
          g_MovingHeroItem.Item.S.Name := '';
        end else begin
          g_boItemMoving := false;
          g_MovingItem.Item.S.Name := '';
        end;
      end;
      SM_REPAIRDRAGONINDIA_FAIL: begin //ÐÞ²¹ÌìÁúÓ¡Ê§°Ü
        if msg.Recog = 1 then begin
          AddHeroItemBag (g_MovingHeroItem.Item);
          g_MovingHeroItem.Item.S.Name := '';
          g_boHeroItemMoving := false;
        end else begin
          AddItemBag (g_MovingItem.Item);
          g_MovingItem.Item.S.Name := '';
          g_boItemMoving := false;
        end;
      end;
      SM_QUERYHEROBAGCOUNT: begin     //´ÓM2·µ»ØÓ¢ÐÛ°ü¹ü×ÜÊý    2007.11.5
        g_HeroBagCount:=msg.Recog;
      end;
      SM_GOTETHERUSESPELL: begin  //´ÓM2·´»ØÀ´µÄÓ¢ÐÛºÏ»÷  2007.11.1
        Actor := PlayScene.FindActor (msg.Recog);
        FrmMain.ShowMyShow(Actor,4);
      end;
      {SM_DRAGONPOINT: begin //ÁúÓ°Å­ÆøÖµ   20080619
        nMaxDragonPoint := msg.Param;
        m_nDragonPoint  :=msg.Recog;
        FrmDlg.DCIDSpleen.Visible:=True;
      end;}
      {SM_CLOSEDRAGONPOINT: begin
        FrmDlg.DCIDSpleen.Visible := False;
      end;  }
      SM_FIRDRAGONPOINT: begin     //Ó¢ÐÛÅ­ÆøÖµ
        nMaxFirDragonPoint:= msg.Param;
        m_nFirDragonPoint:=msg.Recog;
        {if (g_HeroItems[U_BUJUK].s.Shape=9) and (g_HeroItems[U_BUJUK].s.StdMode=25) then
          FrmDlg.DHeroSpleen.Visible := True
        else FrmDlg.DHeroSpleen.Visible := False; }
        FrmDlg.DBHeroSpleenImg.Visible := (g_HeroItems[U_BUJUK].s.Shape=9) and (g_HeroItems[U_BUJUK].s.StdMode=25);
      end;
      SM_HEROBAGITEMS: begin      //½ÓÊÕÓ¢ÐÛ°ü¹üÎïÆ·
        if g_boHeroItemMoving then FrmDlg.CancelHeroItemMoving;
        ClientHeroGetBagItmes (body);
      end;
      SM_HEROSENDMYMAGIC: begin               //20071025
        if body <> '' then begin
          ClientGetHeroMagics(body);
          if msg.Recog = 1 then g_HeroBatterTopMagic[0].CurTrain := 1;
          if msg.Param = 1 then g_HeroBatterTopMagic[1].CurTrain := 1;
          if msg.Tag = 1 then g_HeroBatterTopMagic[2].CurTrain := 1;
          if msg.nSessionID = 1 then g_HeroBatterTopMagic[3].CurTrain := 1;
        end;
      end;
      SM_SENDHEROUSEITEMS: begin //½ÓÊÕÓ¢ÐÛÉíÉÏ×°±¸
        ClientGetSendHeroItems (body);
      end;
      SM_HEROABILITY: begin//½ÓÊÕ Ó¢ÐÛÊôÐÔ1
        g_boHeroInfuriating := msg.nSessionID > 0;
        g_HeroSelf.m_btSex:=msg.Recog;
        g_HeroSelf.m_btJob := msg.Tag;
        g_HeroSelf.m_nLoyal := msg.Series;
        {$IF M2Version = 1}
        g_boQJHeroDZXY99 := msg.Param = 1;
        {$IFEND}
        DecodeBuffer (body, @g_HeroSelf.m_Abil, sizeof(TAbility));;
      end;
      SM_HEROSUBABILITY: begin  //½ÓÊÕ Ó¢ÐÛÊôÐÔ2
        g_nHeroHitPoint      := Lobyte(Msg.Param);
        g_nHeroSpeedPoint    := Hibyte(Msg.Param);
        g_nHeroAntiPoison    := Lobyte(Msg.Tag);
        g_nHeroPoisonRecover := Hibyte(Msg.Tag);
        g_nHeroHealthRecover := Lobyte(Msg.Series);
        g_nHeroSpellRecover  := Hibyte(Msg.Series);
        g_nHeroAntiMagic     := LoByte(LongWord(Msg.Recog));
      	{$IF M2Version <> 2}
        if body <> '' then
	        ClientGetMyHeroState(body);
        {$IFEND}
      end;
      SM_SENDITEMTOHEROBAG_OK: begin    //·µ»Ø´ÓÖ÷ÈË°ü¹üµ½Ó¢ÐÛ°ü¹ü³É¹¦ 2007.10.24
            //if g_WaitingHeroUseItem.Index in [0..12] then
            AddHeroItemBag (g_WaitingUseItem.Item);
            g_WaitingUseItem.Item.S.Name := '';
      end;
      SM_SENDITEMTOHEROBAG_FAIL: begin  //·µ»Ø´ÓÖ÷ÈË°ü¹üµ½Ó¢ÐÛ°ü¹üÊ§°Ü 2007.10.24
            AddItemBag (g_WaitingUseItem.Item);
            g_WaitingUseItem.Item.S.Name := '';
      end;
      SM_SENDITEMTOMASTERBAG_OK: begin  //·µ»Ø´ÓÓ¢ÐÛ°ü¹üµ½Ö÷ÈË°ü¹ü³É¹¦ 2007.10.24
        AddItemBag (g_WaitingHeroUseItem.Item);
        g_WaitingHeroUseItem.Item.S.Name := '';
      end;
      SM_SENDITEMTOMASTERBAG_FAIL: begin //·µ»ØÓ¢ÐÛ´Ó°ü¹üµ½×°±¸Ê§°Ü  2007.10.24
        AddHeroItemBag (g_WaitingHeroUseItem.Item);
        g_WaitingHeroUseItem.Item.S.Name := '';
      end;
      SM_HEROTAKEON_OK: begin    //·µ»ØÓ¢ÐÛ´Ó°ü¹üµ½×°±¸³É¹¦  2007.10.24
        if g_HeroSelf <> nil then begin
          body := DecodeString(body);
          DecodeBuffer (body, @Afeature, sizeof(Tfeatures));
          g_HeroSelf.m_nFeature := Afeature;//msg.Recog;
          g_HeroSelf.FeatureChanged;
          if g_WaitingHeroUseItem.Index in [0..14] then
             g_HeroItems[g_WaitingHeroUseItem.Index] := g_WaitingHeroUseItem.Item;
          g_WaitingHeroUseItem.Item.S.Name := '';
        end;
      end;
      SM_HEROTAKEON_FAIL: begin  //·µ»ØÓ¢ÐÛ´Ó°ü¹üµ½×°±¸Ê§°Ü  2007.10.24
        AddHeroItemBag (g_WaitingHeroUseItem.Item);
        g_WaitingHeroUseItem.Item.S.Name := '';
        {g_boHeroRightItem := FALSE;{ÓÒ¼ü´©´÷×°±¸}
      end;
      SM_HEROTAKEOFF_OK: begin   //·µ»ØÓ¢ÐÛ´Ó×°±¸µ½°ü¹ü³É¹¦   2007.10.24
        body := DecodeString(body);
        DecodeBuffer (body, @Afeature, sizeof(Tfeatures));
        g_HeroSelf.m_nFeature := Afeature;//msg.Recog;
        g_HeroSelf.FeatureChanged;
        g_WaitingHeroUseItem.Item.S.Name := '';
      end;
      SM_HEROTAKEOFF_FAIL: begin  //·µ»ØÓ¢ÐÛ´Ó×°±¸µ½°ü¹üÊ§°Ü   2007.10.24
        if g_WaitingHeroUseItem.Index < 0 then begin
           n := -(g_WaitingHeroUseItem.Index+1);
           g_HeroItems[n] := g_WaitingHeroUseItem.Item;
        end;
        g_WaitingHeroUseItem.Item.S.Name := '';
      end;
      SM_HEROEAT_OK: begin    //Ö÷ÈËË«»÷Ó¢ÐÛ°ü¹ü³Ô¶«Î÷³É¹¦    2007.10.24
        g_HeroEatingItem.S.Name := '';
        ArrangeHeroItembag;
      end;
      SM_HEROEAT_FAIL: begin //Ö÷ÈËË«»÷Ó¢ÐÛ°ü¹ü³Ô¶«Î÷Ê§°Ü    2007.10.24
        AddHeroItemBag (g_HeroEatingItem);
        g_HeroEatingItem.S.Name := '';
      end;
      SM_HEROUPDATEITEM: begin//¸üÐÂÓ¢ÐÛ°ü¹ü
        ClientGetHeroUpdateItem (body);
      end;
      SM_HEROADDITEM: begin   //Ó¢ÐÛ¼ÓÎïÆ·µ½°ü¹üÀï
        ClientGetHeroAddItem (body);
      end;
      SM_HERODROPITEM_SUCCESS: begin //Ó¢ÐÛ³É¹¦µÄ°ÑÎïÆ·ÈÓÔÚµØÉÏÁË
        DelDropItem (DecodeString(body), msg.Recog);
      end;
      SM_HERODROPITEM_FAIL: begin    //Ó¢ÐÛÃ»°ÑÎïÆ·ÈÓÔÚµØÉÏÃ»³É¹¦
        ClientGetHeroDropItemFail (DecodeString(body), msg.Recog);
      end;
      SM_HEROADDMAGIC: begin
        if body <> '' then ClientGetHeroAddMagic (body);
      end;
      SM_HERODELMAGIC:begin
        ClientGetHeroDelMagic (msg.Recog);
      end;
      SM_HEROWEIGHTCHANGED: begin
        if g_HeroSelf <> nil then begin
          g_HeroSelf.m_Abil.Weight := msg.Recog;
          g_HeroSelf.m_Abil.WearWeight := msg.Param;
          g_HeroSelf.m_Abil.HandWeight := msg.Tag;
        end;
      end;
      SM_HEROMAGIC_LVEXP: begin
        ClientGetHeroMagicLvExp (msg.Recog{magid}, msg.Param{lv}, MakeLong(msg.Tag, msg.Series), msg.nSessionID);
      end;
      SM_HERODURACHANGE: begin  //Ó¢ÐÛ³Ö¾Ã¸Ä±ä
        ClientGetHeroDuraChange (msg.Param{useitem index}, msg.Recog, MakeLong(msg.Tag, msg.Series));
      end;
      SM_EXPTIMEITEMS: begin //¾ÛÁéÖéÊ±¼ä¸Ä±ä 20080307
        ClientGetExpTimeItemChange (msg.Recog{ÎïÆ·MakeIndex},msg.Tag );
      end;
      SM_HERODELITEMS: begin
        if body <> '' then ClientGetHeroDelItems (body);
      end;
      SM_HERODELITEM: begin
        ClientGetHeroDelItem (body);
      end;
    //SM_VERSION_FAIL: begin
//      i := MakeLong(msg.Param,msg.Tag);
   //   DecodeBuffer (body, @j, sizeof(Integer));
      {--------------------¿Í»§¶Ë°æ±¾´íÎó2007.10.16--------------------------}
     (* if (msg.Recog <> g_nThisCRC) and
         (i <> g_nThisCRC) and
         (j <> g_nThisCRC) then begin

        FrmDlg.DMessageDlg ('°æ±¾´íÎó.ÇëÏÂÔØ×îÐÂµÄ°æ±¾.', [mbOk]);
        DScreen.AddChatBoardString ('°æ±¾´íÎó.½¨ÒéÏÂÔØ×îÐÂµÄ°æ±¾.', clYellow, clRed);
        CSocket.Close;
//        FrmMain.Close;
//        frmSelMain.Close;
        exit;
        {FrmDlg.DMessageDlg ('Wrong version. Please download latest version. (http://www.legendofmir.net)', [mbOk]);
        Close;
        exit;}
      end; *)
    //end;
      SM_NEWMAP: begin
        g_sMapTitle := '';
        str := DecodeString (body); //mapname
        PlayScene.SendMsg (SM_NEWMAP, 0,
                           msg.Param{x},
                           msg.tag{y},
                           msg.Series{darkness},
                           0, 0, 0, g_nilFeature,
                           str{mapname});
      end;


      SM_LOGON: begin
        //g_dwFirstServerTime := 0;
        //g_dwFirstClientTime := 0;
        with msg do begin
          DecodeBuffer (body, @msgWl, sizeof(TMessageBodyWL));
          PlayScene.SendMsg (SM_LOGON, msg.Recog,
                             msg.Param{x},
                             msg.tag{y},
                             msg.Series{dir},
                             msgWl.lParam1, //desc.Feature,
                             msgWl.lParam2, //desc.Status,
                             msgWl.MonShowName, msgWl.feature,
                             '');
          DScreen.ChangeScene (stPlayGame);
          SendClientMessage (CM_QUERYBAGITEMS, 0, 0, 0, 0);
          if Lobyte(Loword(msgWl.lTag1)) = 1 then g_boAllowGroup := TRUE
          else g_boAllowGroup := FALSE;
          g_boServerChanging := FALSE;
        end;
        if g_wAvailIDDay > 0 then begin
          DScreen.AddChatBoardString ('Äúµ±Ç°Í¨¹ý°üÔÂÕÊºÅ³äÖµ.', clGreen, clWhite)
        end else if g_wAvailIPDay > 0 then begin
          DScreen.AddChatBoardString ('Äúµ±Ç°Í¨¹ý°üÔÂIP ³äÖµ.', clGreen, clWhite)
        end else if g_wAvailIPHour > 0 then begin
          DScreen.AddChatBoardString ('Äúµ±Ç°Í¨¹ý¼ÆÊ±IP ³äÖµ.', clGreen, clWhite)
        end else if g_wAvailIDHour > 0 then begin
          DScreen.AddChatBoardString ('Äúµ±Ç°Í¨¹ý¼ÆÊ±ÕÊºÅ³äÖµ.', clGreen, clWhite)
        end;
         LoadFriendList();
         LoadHeiMingDanList();
         LoadTargetList();
         {$IF M2Version <> 2} //not 1.76
         FrmDlg.DDrunkScale.Visible := True; //20080623
         {$IFEND}
         m_btDeputyHeroJob := msg.nSessionID;
        for I := 0 to g_EffecItemtList.Count - 1 do
          Dispose(pTEffecItem(g_EffecItemtList.Objects[I]));
        g_EffecItemtList.Clear;
        //LoadUserConfig(CharName);
        //DScreen.AddChatBoardString ('µ±Ç°·þÎñÆ÷ÐÅÏ¢: ' + g_sRunServerAddr + ':' + IntToStr(g_nRunServerPort), clGreen, clWhite)
      end;
      SM_SERVERCONFIG: ClientGetServerConfig(Msg,Body);

      SM_SERVERUNBIND: ClientGetServerUnBind(Body); //½â°üÏûÏ¢

      SM_RECONNECT: begin
        ClientGetReconnect (body);
      end;
      {SM_TIMECHECK_MSG:
         begin
            CheckSpeedHack (msg.Recog);
         end;   }

      SM_AREASTATE:
         begin
            g_nAreaStateValue := msg.Recog;
         end;

      SM_MAPDESCRIPTION: begin
        ClientGetMapDescription(Msg,body);
      end;
      SM_GAMEGOLDNAME: begin
        ClientGetGameGoldName(msg,body);
      end;
      SM_GAMEGOLDNAME1: begin
        g_MySelf.m_nGameDiaMond:= Msg.Recog; //½ÓÊÕ½ð¸ÕÊ¯ÊýÁ¿ 2008.02.11
        g_MySelf.m_nGameGird:= Msg.nSessionID; //½ÓÊÕÁé·ûÊýÁ¿ 2008.02.11
        g_nCreditPoint := MakeLong(msg.Param,msg.Tag);
        if body <> '' then begin
          NeiGuaConfig(body);
        end;
      end;
      SM_ADJUST_BONUS: begin
        ClientGetAdjustBonus (msg.Recog, body);
      end;
      SM_MYSTATUS: begin
        g_nMyHungryState:=msg.Param;
      end;
      SM_ISSHOP: begin
          actor := PlayScene.FindActor(msg.Recog);
          if actor <> nil then begin
            actor.m_boIsShop := msg.Param = 1;
            if body <> '' then actor.m_sShopMsg := DecodeString(body);
          end;
      end;
      SM_PLAYSHOPLIST: begin
          actor := PlayScene.FindActor(msg.Recog);
          if actor <> nil then
            ClientGetShopItmes(actor, body);
      end;
      SM_TURN:
         begin
           param := LoWord(msg.nSessionID);
           n := GetCodeMsgSize((sizeof(TCharDesc) - SizeOf(TFeatures) + param)*4/3);
            if Length(body) > n then begin
               Body2 := Copy (Body, n+1, Length(body));
               data := DecodeString (body2); //Ä³¸¯ ÀÌ¸§
               //ÐÞ¸´Ö§³ÖÐÂµÄ¼ÓÃÜ·½·¨By TasNat at: 2012-11-15 20:14:43
               Delete(body, length(body)- Length(Body2)+1, Length(Body2));
               str := GetValidStr3 (data, data, ['/']);
               //data = ÀÌ¸§
               //str = »ö°¥
            end else data := '';
            DecodeBuffer (body, @desc, sizeof(TCharDesc) - SizeOf(TFeatures) + param);
            PlayScene.SendMsg (SM_TURN, msg.Recog,
                                 msg.Param{x},
                                 msg.tag{y},
                                 msg.Series{dir + light},
                                 0,
                                 desc.Status,
                                 desc.MonShowName, desc.feature,
                                 ''); //ÀÌ¸§
            if data <> '' then begin
               actor := PlayScene.FindActor (msg.Recog);
               if actor <> nil then begin
                 {$IF M2Version <> 2}
                 if actor is THumActor then begin
                   THumActor(actor).m_wTitleIcon := HiWord(msg.nSessionID);
                   THumActor(actor).m_sTitleName := GetValidStr3(data, data, ['|']);
                 end;
                 {$IFEND}
                  actor.m_sDescUserName := GetValidStr3(data, actor.m_sUserName, ['\']);
                  actor.m_nNameColor := GetRGB(Str_ToInt(str, 0));
                  actor.m_btMiniMapHeroColor := Str_ToInt(str, 0);
               end;
            end;
         end;
      SM_BACKSTEP:
         begin
           n := GetCodeMsgSize((sizeof(TCharDesc) - SizeOf(TFeatures) + msg.nSessionID)*4/3);
            if Length(body) > n then begin
               Body2 := Copy (Body, n +1, Length(body));
               data := DecodeString (body2); //Ä³¸¯ ÀÌ¸§
               //ÐÞ¸´Ö§³ÖÐÂµÄ¼ÓÃÜ·½·¨By TasNat at: 2012-11-15 20:14:43
               Delete(body, length(body)- Length(Body2)+1, Length(Body2));
               str := GetValidStr3 (data, data, ['/']);
               //data = ÀÌ¸§
               //str = »ö°¥
            end else data := '';
            DecodeBuffer (body, @desc, sizeof(TCharDesc) - SizeOf(TFeatures) + msg.nSessionID);
            PlayScene.SendMsg (SM_BACKSTEP, msg.Recog,
                                 msg.Param{x},
                                 msg.tag{y},
                                 msg.Series{dir + light},
                                 0,
                                 desc.Status,
                                 desc.MonShowName, desc.feature,
                                 ''); //ÀÌ¸§
            if data <> '' then begin
               actor := PlayScene.FindActor (msg.Recog);
               if actor <> nil then begin
                  actor.m_sDescUserName := GetValidStr3(data, actor.m_sUserName, ['\']);
                  actor.m_nNameColor := GetRGB(Str_ToInt(str, 0));
                  actor.m_btMiniMapHeroColor := Str_ToInt(str, 0);
               end;
            end;
         end;

      SM_SPACEMOVE_HIDE,
      SM_SPACEMOVE_HIDE2:
         begin
            if msg.Recog <> g_MySelf.m_nRecogId then begin
               PlayScene.SendMsg (msg.Ident, msg.Recog, msg.Param{x}, msg.tag{y}, 0, 0, 0, 0, g_nilFeature, '');
            end;
         end;

      SM_SPACEMOVE_SHOW,
      SM_SPACEMOVE_SHOW2,
      SM_SPACEMOVE_SHOW3:
         begin
           n := GetCodeMsgSize((sizeof(TCharDesc) - SizeOf(TFeatures) + msg.nSessionID)*4/3);
            if Length(body) > n then begin
               Body2 := Copy (Body, n+1, Length(body));
               data := DecodeString (body2); //Ä³¸¯ ÀÌ¸§
               //ÐÞ¸´Ö§³ÖÐÂµÄ¼ÓÃÜ·½·¨By TasNat at: 2012-11-15 20:14:43
               Delete(body, length(body)- Length(Body2)+1, Length(Body2));
               str := GetValidStr3 (data, data, ['/']);
            end else data := '';
            DecodeBuffer (body, @desc, sizeof(TCharDesc) - SizeOf(TFeatures) + msg.nSessionID);
            if msg.Recog <> g_MySelf.m_nRecogId then begin //´Ù¸¥ Ä³¸¯ÅÍÀÎ °æ¿ì
              PlayScene.NewActor (msg.Recog, msg.Param, msg.tag, msg.Series, desc.feature, desc.Status, desc.MonShowName);
            end;
            PlayScene.SendMsg (msg.Ident, msg.Recog,
                                 msg.Param{x},
                                 msg.tag{y},
                                 msg.Series{dir + light},
                                 0,
                                 desc.Status,
                                 desc.MonShowName,
                                 desc.feature,
                                 ''); //ÀÌ¸§
            if data <> '' then begin
               actor := PlayScene.FindActor (msg.Recog);
               if actor <> nil then begin
                  actor.m_sDescUserName := GetValidStr3(data, actor.m_sUserName, ['\']);
                  actor.m_nNameColor := GetRGB(Str_ToInt(str, 0));
                  actor.m_btMiniMapHeroColor := Str_ToInt(str, 0);
               end;
            end;
         end;

      SM_NPCWALK, SM_WALK, SM_RUSH, SM_RUSHKUNG:
         begin
            DecodeBuffer (body, @desc, sizeof(TCharDesc) - SizeOf(TFeatures) + msg.nSessionID);
            if (msg.Recog <> g_MySelf.m_nRecogId) or (msg.Ident = SM_RUSH) or (msg.Ident = SM_RUSHKUNG) then begin
               PlayScene.SendMsg (msg.Ident, msg.Recog,
                                 msg.Param{x},
                                 msg.tag{y},
                                 msg.Series{dir+light},
                                 0,
                                 desc.Status,
                                 desc.MonShowName,
                                 desc.feature, '');
            end;
            if msg.Ident = SM_RUSH then
               g_dwLatestRushRushTick := GetTickCount;
         end;
     (* SM_RUSH79: begin
         PlayScene.SendMsg (msg.Ident, msg.Recog,
                                 msg.Param{x},
                                 msg.tag{y},
                                 msg.Series{dir+light},
                                 desc.Feature,
                                 desc.Status, '');
      end;*)
      SM_RUN{,SM_HORSERUN 20080803×¢ÊÍÆïÂíÏûÏ¢}:
         begin
            DecodeBuffer (body, @desc, sizeof(TCharDesc) - SizeOf(TFeatures) + msg.nSessionID);
            if msg.Recog <> g_MySelf.m_nRecogId then
               PlayScene.SendMsg (msg.Ident, msg.Recog,
                                    msg.Param{x},
                                    msg.tag{y},
                                    msg.Series{dir+light},
                                    0,
                                    desc.Status,
                                    desc.MonShowName,
                                    desc.feature, '');
         end;

      SM_CHANGELIGHT://ÓÎÏ·ÁÁ¶È
         begin
            actor := PlayScene.FindActor (msg.Recog);
            if actor <> nil then begin
               actor.m_nChrLight := msg.Param;
            end;
         end;

      SM_LAMPCHANGEDURA:
         begin
            if g_UseItems[U_RIGHTHAND].S.Name <> '' then begin
               g_UseItems[U_RIGHTHAND].Dura := msg.Recog;
            end;
         end;

      SM_MOVEFAIL: begin
        ActionFailed;
        DecodeBuffer (body, @desc, sizeof(TCharDesc) - SizeOf(TFeatures) + msg.nSessionID);
        PlayScene.SendMsg (SM_TURN, msg.Recog,
                                 msg.Param{x},
                                 msg.tag{y},
                                 msg.Series{dir},
                                 0,
                                 desc.Status,
                                 desc.MonShowName,
                                 desc.feature, '');
      end;
      SM_BUTCH:
         begin
           // DecodeBuffer (body, @desc, sizeof(TCharDesc));
            if msg.Recog <> g_MySelf.m_nRecogId then begin
               actor := PlayScene.FindActor (msg.Recog);
               if actor <> nil then
                  actor.SendMsg (SM_SITDOWN,
                                    msg.Param{x},
                                    msg.tag{y},
                                    msg.Series{dir},
                                    0, 0, '', 0, g_nilFeature);
            end;
         end;
      SM_SITDOWN:
         begin
            //DecodeBuffer (body, @desc, sizeof(TCharDesc));
            if msg.Recog <> g_MySelf.m_nRecogId then begin
               actor := PlayScene.FindActor (msg.Recog);
               if actor <> nil then
                  actor.SendMsg (SM_SITDOWN,
                                    msg.Param{x},
                                    msg.tag{y},
                                    msg.Series{dir},
                                    0, 0, '', 0, g_nilFeature);
            end;
         end;

      SM_HIT,           //14
      SM_HEAVYHIT,      //15
      SM_POWERHIT,      //18
      SM_LONGHIT,       //19
      SM_LONGHIT4,      //4¼¶´ÌÉ±
      SM_WIDEHIT,       //24
      SM_WIDEHIT4,      //Ô²ÔÂÍäµ¶
      SM_BIGHIT,        //16
      SM_FIREHIT,{ÁÒ»ð}       //8
      //SM_69HIT, //ÒÐÌì±ÙµØ
      SM_4FIREHIT,{4¼¶ÁÒ»ð}
      SM_DAILY, //ÖðÈÕ½£·¨ 20080511
      SM_BLOODSOUL, //ÑªÆÇÒ»»÷(Õ½)
      SM_BATTERHIT1,
      SM_BATTERHIT2,
      SM_BATTERHIT3,
      SM_BATTERHIT4,
      SM_CRSHIT,
      SM_CIDHIT, {ÁúÓ°½£·¨}
      SM_HIT_107,
      SM_TWINHIT, {¿ªÌìÕ¶ÖØ»÷}
      SM_QTWINHIT {¿ªÌìÕ¶Çá»÷ 20080212}:
         begin
            if msg.Recog <> g_MySelf.m_nRecogId then begin//20090707 ²âÊÔ×¢ÊÍ
               actor := PlayScene.FindActor (msg.Recog);
               if actor <> nil then begin
                  {$IF M2Version <> 2} //·ÛÉ«¼¼ÄÜ
                  if msg.nSessionID = 1 then begin
                    case msg.Ident of
                      SM_LONGHIT: msg.Ident := SM_LONGHITFORFENGHAO;
                      SM_FIREHIT: msg.Ident := SM_FIREHITFORFENGHAO;
                      SM_DAILY: msg.Ident := SM_DAILYFORFENGHAO;
                    end;
                  end else 
                  {$IFEND}
                  if msg.nSessionID in [2..10] then begin //Ç¿»¯
                    case msg.Ident of
                      SM_DAILY: begin
                        case msg.nSessionID of
                          2..4: msg.Ident := SM_DAILYEX1;
                          5..7: msg.Ident := SM_DAILYEX2;
                         8..10: msg.Ident := SM_DAILYEX3;
                        end;
                      end;
                      SM_FIREHIT, SM_4FIREHIT: begin
                        case msg.nSessionID of
                          2..4: msg.Ident := SM_FIREHITEX1;
                          5..7: msg.Ident := SM_FIREHITEX2;
                         8..10: msg.Ident := SM_FIREHITEX3;
                        end;
                      end;
                      SM_WIDEHIT4: begin
                        case msg.nSessionID of
                          2..4: msg.Ident := SM_WIDEHIT4EX1;
                          5..7: msg.Ident := SM_WIDEHIT4EX2;
                         8..10: msg.Ident := SM_WIDEHIT4EX3;
                        end;
                      end;
                      SM_POWERHIT: begin
                        case msg.nSessionID of
                          2..4: msg.Ident := SM_POWERHITEX1;
                          5..7: msg.Ident := SM_POWERHITEX2;
                         8..10: msg.Ident := SM_POWERHITEX3;
                        end;
                      end;
                      SM_LONGHIT, SM_LONGHIT4: begin
                        case msg.nSessionID of
                          2..4: msg.Ident := SM_LONGHITEX1;
                          5..7: msg.Ident := SM_LONGHITEX2;
                         8..10: msg.Ident := SM_LONGHITEX3;
                        end;
                      end;
                    end;
                  end;
                  actor.SendMsg (msg.Ident,
                                    msg.Param{x},
                                    msg.tag{y},
                                    msg.Series{dir},
                                    0, 0, '',
                                    0, g_nilFeature);
                  if msg.ident = SM_HEAVYHIT then begin
                     if body <> '' then
                        actor.m_boDigFragment := TRUE;
                  end;
               end;
            end;
         end;
      SM_RUSH79: begin
            //if msg.Recog <> g_MySelf.m_nRecogId then begin
               actor := PlayScene.FindActor (msg.Recog);
               if actor <> nil then begin
                  actor.Kill79SendMsg (msg.Ident,
                                    msg.Param{x},
                                    msg.tag{y},
                                    msg.Series{dir},
                                    0, 0, '',
                                    0);
               end;
            //end;
      end;
      SM_LEITINGHIT:
         begin
           actor := PlayScene.FindActor (msg.Recog);
           if actor <> nil then begin
              actor.SendMsg (msg.Ident,
                                msg.Param{x},
                                msg.tag{y},
                                msg.Series{dir},
                                0, 0, '',
                                0, g_nilFeature);
              if msg.ident = SM_HEAVYHIT then begin
                 if body <> '' then
                    actor.m_boDigFragment := TRUE;
              end;
           end;
         end;
      SM_PIXINGHIT: //20080611ÅüÐÇ
         begin
           actor := PlayScene.FindActor (msg.Recog);
           if actor <> nil then begin
              actor.SendMsg (SM_HIT,
                                msg.Param{x},
                                msg.tag{y},
                                msg.Series{dir},
                                0, 0, '',
                                0, g_nilFeature);
              if msg.ident = SM_HEAVYHIT then begin
                 if body <> '' then
                    actor.m_boDigFragment := TRUE;
              end;
           end;
         end;
      SM_FLYAXE:
         begin
            DecodeBuffer (body, @mbw, sizeof(TMessageBodyW));
            actor := PlayScene.FindActor (msg.Recog);
            if actor <> nil then begin
               actor.SendMsg (msg.Ident,
                                 msg.Param{x},
                                 msg.tag{y},
                                 msg.Series{dir},
                                 0, 0, '',
                                 0, g_nilFeature);
               actor.m_nTargetX := mbw.Param1;  //x ´øÁö´Â ¸ñÇ¥
               actor.m_nTargetY := mbw.Param2;    //y
               actor.m_nTargetRecog := MakeLong(mbw.Tag1, mbw.Tag2);
            end;
         end;
      SM_FAIRYATTACKRATE,//ÔÂÁéÖØ»÷ 2007.12.14
      SM_LIGHTING:
         begin
            DecodeBuffer (body, @wl2, sizeof(TMessageBodyWL2));
            actor := PlayScene.FindActor (msg.Recog);
            if actor <> nil then begin
               actor.SendMsg (msg.Ident,
                                 msg.Param{x},
                                 msg.tag{y},
                                 msg.Series{dir},
                                 0, 0, '',
                                 0, g_nilFeature);
               actor.m_nTargetX := wl2.lParam1;  //x ´øÁö´Â ¸ñÇ¥
               actor.m_nTargetY := wl2.lParam2;    //y
               actor.m_nTargetRecog := wl2.lTag1;
               actor.m_nMagicNum := wl2.lTag2;   //¸¶¹ý ¹øÈ£
            end;
         end;

      SM_SPELL: begin
        UseMagicSpell (msg.Recog{who}, msg.Series{effectnum}, msg.Param{tx}, msg.Tag{y}, Str_ToInt(body,0), msg.nSessionID);
      end;
      SM_MAGICFIRE: begin
        DecodeBuffer (body, @param, sizeof(integer));
        UseMagicFire (msg.Recog{who}, Lobyte(msg.Series){efftype}, Hibyte(msg.Series){effnum}, msg.Param{tx}, msg.Tag{y}, param, msg.nSessionID);
      end;
      SM_MAGICFIRE_FAIL: UseMagicFireFail (msg.Recog{who});
      SM_OUTOFCONNECTION:
         begin
            g_boDoFastFadeOut := FALSE;
            g_boDoFadeIn := FALSE;
            g_boDoFadeOut := FALSE;
            FrmDlg.DMessageDlg ('·þÎñÆ÷Á¬½Ó±»Ç¿ÐÐÖÐ¶Ï¡£\Á¬½ÓÊ±¼ä¿ÉÄÜ³¬¹ýÏÞÖÆ¡£', [mbOk]);
            Close;
         end;

      SM_DEATH,
      SM_NOWDEATH:
         begin
            DecodeBuffer (body, @desc, sizeof(TCharDesc) - SizeOf(TFeatures) + msg.nSessionID);
            actor := PlayScene.FindActor (msg.Recog);
            if actor <> nil then begin
               actor.SendMsg (msg.Ident,
                              msg.param{x}, msg.Tag{y}, msg.Series{damage},
                              0, desc.Status, '',
                              0, desc.feature);
               actor.m_Abil.HP := 0;
            end else begin
               PlayScene.SendMsg (SM_DEATH, msg.Recog, msg.param{x}, msg.Tag{y}, msg.Series{damage}, 0, desc.Status, desc.MonShowName, desc.feature, '');
            end;
         end;
      SM_SKELETON:
         begin
            DecodeBuffer (body, @desc, sizeof(TCharDesc) - SizeOf(TFeatures) + msg.nSessionID);
            PlayScene.SendMsg (SM_SKELETON, msg.Recog, msg.param{HP}, msg.Tag{maxHP}, msg.Series{damage}, 0, desc.Status, desc.MonShowName, desc.feature, '');
         end;
      SM_ALIVE:
         begin
            DecodeBuffer (body, @desc, sizeof(TCharDesc) - SizeOf(TFeatures) + msg.nSessionID);
            PlayScene.SendMsg (SM_ALIVE, msg.Recog, msg.param{HP}, msg.Tag{maxHP}, msg.Series{damage}, 0, desc.Status, desc.MonShowName, desc.feature, '');
         end;

      SM_ABILITY:
         begin
            g_MySelf.m_nGold := msg.Recog;
            g_MySelf.m_btJob := msg.Param;
            g_MySelf.m_nGameGold:=MakeLong(msg.Tag,msg.Series);
            {$IF M2Version = 1}
            g_boQJDZXY99 := msg.nSessionID = 1;
            {$IFEND}
            DecodeBuffer (body, @g_MySelf.m_Abil, sizeof(TAbility));
            if not g_boLoadSdoAssistantConfig then begin
              FreeAndNil(g_ShowItemList);
              if g_ShowItemList = nil then g_ShowItemList := TFileItemDB.Create;
              if FileExists(g_ParamDir + 'FilterItemNameList.dat') then
              g_ShowItemList.LoadFormFile(g_ParamDir + 'FilterItemNameList.dat');
              LoadSdoAssistantConfig(CharName); //¶ÁÈ¡Ê¢´ó¹ÒÅäÖÃ
              CreateSdoAssistant();//³õÊ¼»¯
            end;
         end;

      SM_SUBABILITY: begin
        g_nMyHitPoint      := Lobyte(Msg.Param);
        g_nMySpeedPoint    := Hibyte(Msg.Param);
        g_nMyAntiPoison    := Lobyte(Msg.Tag);
        g_nMyPoisonRecover := Hibyte(Msg.Tag);
        g_nMyHealthRecover := Lobyte(Msg.Series);
        g_nMySpellRecover  := Hibyte(Msg.Series);
        g_nMyAntiMagic     := LoByte(LongWord(Msg.Recog));
        if body <> '' then
	        ClientGetMySelfState(body);
      end;

      SM_DAYCHANGING:
         begin
            g_nDayBright := msg.Param;
            {$IF M2Version = 2} //1.76
            {DarkLevel := msg.Tag;
            if DarkLevel = 0 then g_boViewFog := FALSE
            else g_boViewFog := TRUE; }
            {$IFEND}
         end;
      SM_HEROWINEXP: begin //Ó¢ÐÛ¾­Ñé
        if (g_HeroSelf <> nil) and (Body <> '') then begin
              DecodeBuffer(Body, @ExpData, SizeOf(ExpData));
              g_HeroSelf.m_Abil.nExp := ExpData.nExp + ExpData.nMaxExp;

              if ExpData.nMaxExp > 0 then begin
                if g_boExpFiltrate then begin
                  if ExpData.nMaxExp > g_dwEditExpFiltrate then
                    DScreen.AddChatBoardString(IntToStr(ExpData.nMaxExp) + ' Ó¢ÐÛ¾­ÑéÖµÔö¼Ó.', clWhite, clRed);
                end else begin
                  DScreen.AddChatBoardString(IntToStr(ExpData.nMaxExp) + ' Ó¢ÐÛ¾­ÑéÖµÔö¼Ó.', clWhite, clRed);
                end;
              end;
            end;
      end;
      SM_HEROLEVELUP: if g_HeroSelf <> nil then begin
            g_HeroSelf.m_Abil.Level := msg.Param;
            ExpData.nMaxExp := 100;
            ExpData.nExp := 0;
            DecodeBuffer(Body, @ExpData, SizeOf(ExpData));
            g_HeroSelf.m_Abil.nExp := ExpData.nExp;
            g_HeroSelf.m_Abil.nMaxExp := ExpData.nMaxExp;
            DScreen.AddSysMsg('ÄãµÄÓ¢ÐÛÉý¼¶ÁË£¡');
          end;
        SM_WINEXP:
          if Body <> '' then begin
            DecodeBuffer(Body, @ExpData, SizeOf(ExpData));
            g_MySelf.m_Abil.nExp := ExpData.nExp + ExpData.nMaxExp;
            if ExpData.nMaxExp > 0 then begin

{$IF M2Version <> 2}
              if msg.Series <> 1 then
{$IFEND}
                if (not g_boExpFiltrate) or (ExpData.nMaxExp > g_dwEditExpFiltrate) then
                  DScreen.AddChatBoardString(IntToStr(ExpData.nMaxExp) + ' ¾­ÑéÖµÔö¼Ó.', clWhite, clRed);
            end;
          end;
        SM_LEVELUP:
          begin
            ExpData.nMaxExp := 100;
            ExpData.nExp := 0;
            DecodeBuffer(Body, @ExpData, SizeOf(ExpData));
            g_MySelf.m_Abil.nExp := ExpData.nExp;
            g_MySelf.m_Abil.nMaxExp := ExpData.nMaxExp;

            g_MySelf.m_Abil.Level := msg.Param;
            DScreen.AddSysMsg('Éý¼¶!');
          end;
  SM_HEALTHSPELLCHANGED1,
  SM_HEROHEALTHSPELLCHANGED1,
  SM_HEROHEALTHSPELLCHANGED,
      SM_HEALTHSPELLCHANGED: begin
        Actor := PlayScene.FindActor (msg.Recog);
        if Actor <> nil then begin
          {Actor.m_Abil.HP    := msg.Param;
          Actor.m_Abil.MP    := msg.Tag;
          Actor.m_Abil.MaxHP := msg.Series;}
          Actor.m_Abil.HP    := MakeLong(msg.Param, msg.Tag);//20091026 ÐÞ¸Ä
          Actor.m_Abil.MP    := msg.nSessionID;
          Actor.m_Abil.MaxHP := StrToInt64(body);
        end;
      end;
      SM_STRUCK:
         begin
            case msg.Ident of
              SM_STRUCK: begin
              //wl: TMessageBodyWL;
                  {DecodeBuffer (body, @msgWl, sizeof(TMessageBodyWL) - SizeOf(TFeatures) + msg.nSessionID);
                  Actor := PlayScene.FindActor (msg.Recog);
                  if Actor <> nil then begin
                     if Actor = g_MySelf then begin
                        if g_MySelf.m_nNameColor = 249 then //ºìÃû
                           g_dwLatestStruckTick := GetTickCount;
                     end else begin
                        if Actor.CanCancelAction then
                           Actor.CancelAction;
                     end;
                     //ÎÈÈçÌ©É½             - SizeOf(TFeatures) + msg.nSessionID
                    if Actor <> g_MySelf then    //Sound
                     Actor.UpdateMsg (SM_STRUCK, msgWl.lTag2, 0,
                                 msg.Series, msgWl.lParam1, msgWl.lParam2,
                                 '', msgWl.lTag1, msgWl.feature);
                     //Actor.m_Abil.HP := msg.param;
                     //Actor.m_Abil.MaxHP := msg.Tag;
                     Actor.m_Abil.HP := MakeLong(msg.param, msg.Tag);//20091026 ÐÞ¸Ä
                     Actor.m_Abil.MaxHP := msg.nSessionID;
                  end;   }
                  Actor := PlayScene.FindActor (msg.Recog);
                  if Actor <> nil then begin
                     if Actor = g_MySelf then begin
                        if g_MySelf.m_nNameColor = 249 then //ºìÃû
                           g_dwLatestStruckTick := GetTickCount;
                     end else begin
                        if Actor.CanCancelAction then
                           Actor.CancelAction;
                     end;
                     //ÎÈÈçÌ©É½
                    if Actor <> g_MySelf then    //Sound
                     Actor.UpdateMsg (SM_STRUCK, 0, 0,
                                 msg.Series, 0, 0,
                                 '', 0, Actor.m_nFeature);
                     //Actor.m_Abil.HP := msg.param;
                     //Actor.m_Abil.MaxHP := msg.Tag;
                     Actor.m_Abil.HP := MakeLong(msg.param, msg.Tag);//20091026 ÐÞ¸Ä
                     Actor.m_Abil.MaxHP := msg.nSessionID;
                  end;
                end;
            end; //case 
         end;

      SM_CHANGEFACE:
         begin
            actor := PlayScene.FindActor (msg.Recog);
            if actor <> nil then begin
               DecodeBuffer (body, @desc, sizeof(TCharDesc)- SizeOf(TFeatures) + msg.nSessionID);
               actor.m_nWaitForRecogId := MakeLong(msg.Param, msg.Tag);
               actor.m_nWaitForFeature := desc.feature;
               actor.m_nWaitForStatus := desc.Status;
               AddChangeFace (actor.m_nWaitForRecogId);
            end;
         end;
      SM_PASSWORD: SetInputStatus();
      SM_OPENHEALTH:
         begin
            actor := PlayScene.FindActor (msg.Recog);
            if actor <> nil then begin
               if actor <> g_MySelf then begin
                  //actor.m_Abil.HP := msg.Param;
                  //actor.m_Abil.MaxHP := msg.Tag;
                  actor.m_Abil.HP := MakeLong(msg.param, msg.Tag);//20091026 ÐÞ¸Ä
                  actor.m_Abil.MaxHP := msg.nSessionID;
               end;
               actor.m_boOpenHealth := TRUE;
               //actor.OpenHealthTime := 999999999;
               //actor.OpenHealthStart := GetTickCount;
            end;
         end;
      SM_CLOSEHEALTH:
         begin
            actor := PlayScene.FindActor (msg.Recog);
            if actor <> nil then begin
               actor.m_boOpenHealth := FALSE;
            end;
         end;
      SM_INSTANCEHEALGUAGE:
         begin
            actor := PlayScene.FindActor (msg.Recog);
            if actor <> nil then begin
               //actor.m_Abil.HP := msg.param;
               //actor.m_Abil.MaxHP := msg.Tag;
               actor.m_Abil.HP := MakeLong(msg.param, msg.Tag);//20091026 ÐÞ¸Ä
               actor.m_Abil.MaxHP := msg.nSessionID;
               actor.m_noInstanceOpenHealth := TRUE;
               actor.m_dwOpenHealthTime := 2 * 1000;
               actor.m_dwOpenHealthStart := GetTickCount;
            end;
         end;

      SM_BREAKWEAPON: //ÎäÆ÷ÆÆËé
         begin
            actor := PlayScene.FindActor (msg.Recog);
            if actor <> nil then begin
               if actor is THumActor then
                  THumActor(actor).DoWeaponBreakEffect;
            end;
         end;

      SM_CRY,         //º°»°ÏûÏ¢
      SM_GROUPMESSAGE,//×é¶ÓÏûÏ¢
      SM_GUILDMESSAGE,//ÐÐ»áÏûÏ¢
      {$IF M2Version <> 2}
      SM_DIVISIONMESSAGE,//Ê¦ÃÅÁÄÌì//20110730
      {$IFEND}
      SM_WHISPER,     //Ë½ÁÄÏûÏ¢
      SM_MOVEMESSAGE, //¹ö¶¯ÏûÏ¢
      SM_SYSMESSAGE:  //ÏµÍ³ÏûÏ¢
         begin
           str := DecodeString (body);
           case msg.Ident of
             SM_CRY: tagstr := Copy(str,4,pos(': ',str)- 4);
             SM_SYSMESSAGE: tagstr := Copy(str,0,pos(':',str)- 1);
             SM_WHISPER: tagstr := Copy(str,0,pos('[',str)- 1);
           end;
           if not InHeiMingDanListOfName(tagstr) then begin
              if msg.Ident = SM_MOVEMESSAGE then begin
                   case msg.Series of
                    0: Dscreen.AddSysBoard(str,Lobyte(Msg.Param),Hibyte(msg.Param), 50); //¹ö¶¯¹«¸æ
                    1: Dscreen.AddCenterLetter(Lobyte(Msg.Param),Hibyte(msg.Param),msg.Tag,str); //¾ÓÖÐÏÔÊ¾
                    2: Dscreen.AddCountDown(Lobyte(Msg.Param),msg.Tag,str); //ÁÄÌìÀ¸ÉÏÃæµ¹¼ÇÊ±
                    3: Dscreen.AddTopLetter(Lobyte(Msg.Param),Hibyte(msg.Param),str);
                    5: DScreen.AddChatTopString (str, GetRGB(Lobyte(msg.Param)), GetRGB(Hibyte(msg.Param)));
                    6: DScreen.AddRightBottomMsg(GetRGB(Lobyte(msg.Param)), GetRGB(Hibyte(msg.Param)), msg.Tag, str);
                   end;
              end else begin
                if msg.Ident = SM_WHISPER then begin
                  if InFriendListOfName(tagstr) then begin
                    DScreen.AddChatBoardString (str, GetRGB(5), GetRGB(150));
                  end else DScreen.AddChatBoardString (str, GetRGB(Lobyte(msg.Param)), GetRGB(Hibyte(msg.Param)));
                  FrmDlg.AddWhisper(FormatDateTime('hh:mm:ss',Now)+ ' ' +str);
                  if (FrmDlg.DCheckWhisper.Checked) and (Trim(FrmDlg.DEdtWhisper.Text) <> '') then FrmDlg.AutoWhisper(str);
                end else begin
                  DScreen.AddChatBoardString (str, GetRGB(Lobyte(msg.Param)), GetRGB(Hibyte(msg.Param)));
                  if msg.Ident = SM_GUILDMESSAGE then FrmDlg.AddGuildChat (str);
                end;
              end;
           end;
         end;

      SM_HEAR:
         begin
            str := DecodeString (body);
            actor := PlayScene.FindActor (msg.Recog);
            if actor <> nil then begin
              if msg.Tag = 1 then
                actor.m_SayColor := GetRGB(Lobyte(msg.Param))
              else actor.m_SayColor := clWhite;
              if not InHeiMingDanListOfName(actor.m_sUserName) then begin
               actor.Say (str);
              end;
            end;
            if not g_boOwnerMsg then  //¾Ü¾ø¹«ÁÄ 2008.02.11
              if actor <> nil then begin
                if not InHeiMingDanListOfName(actor.m_sUserName) then
                  DScreen.AddChatBoardString (str, GetRGB(Lobyte(msg.Param)), GetRGB(Hibyte(msg.Param)));
              end else begin
                  DScreen.AddChatBoardString (str, GetRGB(Lobyte(msg.Param)), GetRGB(Hibyte(msg.Param)));
              end;

         end;

      SM_USERNAME:
         begin
            str := DecodeString (body);
            actor := PlayScene.FindActor (msg.Recog);
            if actor <> nil then begin
               {$IF M2Version <> 2}
               if actor is THumActor then begin
                 THumActor(actor).m_wTitleIcon := msg.Tag;
                 THumActor(actor).m_sTitleName := GetValidStr3(str, str, ['|']);
               end;
               {$IFEND}

               actor.m_sDescUserName := GetValidStr3(str, actor.m_sUserName, ['\']);
               actor.m_nNameColor := GetRGB (msg.Param);
               actor.m_btMiniMapHeroColor := msg.Param;
               {if msg.Tag = 1 then actor.m_boCityMember := True//¾«Ó¢ÍÅ 20080330
               else if msg.Tag = 2 then actor.m_boCityMaster := True;//³ÇÖ÷ 20080330   }
            end;
         end;
      SM_CHANGENAMECOLOR:
         begin
            actor := PlayScene.FindActor (msg.Recog);
            if actor <> nil then begin
               actor.m_nNameColor := GetRGB (msg.Param);
               actor.m_btMiniMapHeroColor := msg.Param;
            end;
         end;

      SM_HIDE,
      SM_GHOST,  //ÀÜ»ó..
      SM_DISAPPEAR:
         begin
            if g_MySelf.m_nRecogId <> msg.Recog then
               PlayScene.SendMsg (SM_HIDE, msg.Recog, msg.Param{x}, msg.tag{y}, 0, 0, 0, 0, g_nilFeature, '');
         end;

      SM_DIGUP:
         begin
            DecodeBuffer (body, @msgWl, sizeof(TMessageBodyWL) - SizeOf(TFeatures) + msg.nSessionID);
            actor := PlayScene.FindActor (msg.Recog);
            if actor = nil then
               actor := PlayScene.NewActor (msg.Recog, msg.Param, msg.tag, msg.Series, msgWl.feature, msgWl.lParam2, msgWl.MonShowName);
            actor.m_nCurrentEvent := msgWl.lTag1;
            actor.SendMsg (SM_DIGUP,
                           msg.Param{x},
                           msg.tag{y},
                           msg.Series{dir + light},
                           msgWl.lParam1,
                           msgWl.lParam2, '', 0, g_nilFeature);
         end;
      SM_DIGDOWN:
         begin
            PlayScene.SendMsg (SM_DIGDOWN, msg.Recog, msg.Param{x}, msg.tag{y}, 0, 0, 0, 0, g_nilFeature, '');
         end;
      SM_SHOWEVENT:
         begin
            DecodeBuffer (body, @smsg, sizeof(TShortMessage));
            event := TClEvent.Create (msg.Recog, Loword(msg.Tag){x}, msg.Series{y}, msg.Param{e-type});
            if msg.Param = ET_SCULPEICE_1 then begin //Ñ©ÓòÎÀÊ¿
              actor := PlayScene.FindActor (msg.Recog);
              if actor <> nil then begin
                event.m_nDir := actor.m_btDir;
              end else event.m_nDir := 0;
            end else event.m_nDir := 0;
            event.m_nEventParam := smsg.Ident;
            EventMan.AddEvent (event);
            case msg.Param of
              ET_FIREFLOWER_1,ET_FIREFLOWER_2,ET_FIREFLOWER_3,ET_FIREFLOWER_4,ET_FIREFLOWER_5,ET_FIREFLOWER_6,ET_FIREFLOWER_7,ET_FIREFLOWER_8 : MyPlaySound(Protechny_ground); //ÑÌ»¨ÉùÒô
              SM_HEROLOGOUT: MyPlaySound (HeroHeroLogout_ground);
              ET_FOUNTAIN: MyPlaySound (spring_ground);
              ET_DIEEVENT: MyPlaySound(powerup_ground); //ÈËÐÎ×¯Ö÷ËÀÍö¶¯»­
            end;
         end;
      SM_HIDEEVENT:
         begin
            EventMan.DelEventById (msg.Recog);
         end;

      //Item ??
      SM_ADDITEM:
         begin
            ClientGetAddItem (body);
         end;
      SM_BAGITEMS:
         begin
           if g_boItemMoving then FrmDlg.CancelItemMoving;
            ClientGetBagItmes (body);
         end;
      SM_UPDATEITEM:
         begin
            ClientGetUpdateItem (body);
         end;
      SM_DELITEM:
         begin
            ClientGetDelItem (body);
         end;
      SM_DELITEMS:
         begin
            ClientGetDelItems (body);
         end;

      SM_DROPITEM_SUCCESS:
         begin
            DelDropItem (DecodeString(body), msg.Recog);
         end;
      SM_DROPITEM_FAIL:
         begin
            ClientGetDropItemFail (DecodeString(body), msg.Recog);
         end;

      SM_ITEMSHOW       :ClientGetShowItem (msg.Recog, msg.param{x}, msg.Tag{y}, msg.Series{looks}, DecodeString(body));
      SM_ITEMHIDE       :ClientGetHideItem (msg.Recog, msg.param, msg.Tag);
      SM_OPENDOOR_OK    :Map.OpenDoor (msg.param, msg.tag);
      SM_OPENDOOR_LOCK  :DScreen.AddSysMsg ('´ËÃÅ±»Ëø¶¨.');
      SM_CLOSEDOOR      :Map.CloseDoor (msg.param, msg.tag);

      SM_TAKEON_OK:
         begin
            DecodeBuffer (DecodeString(body), @Afeature, sizeof(TFeatures));
            g_MySelf.m_nFeature := Afeature; //msg.Recog;
            g_MySelf.FeatureChanged;
            if g_WaitingUseItem.Index in [0..14] then
               g_UseItems[g_WaitingUseItem.Index] := g_WaitingUseItem.Item;
            g_WaitingUseItem.Item.S.Name := '';
         end;
      SM_TAKEON_FAIL:
         begin
            AddItemBag (g_WaitingUseItem.Item);
            g_WaitingUseItem.Item.S.Name := '';
            {g_boRightItem := FALSE;{ÓÒ¼ü´©´÷×°±¸}
         end;
      SM_TAKEOFF_OK:
         begin
            DecodeBuffer (DecodeString(body), @Afeature, sizeof(Tfeatures));
            g_MySelf.m_nFeature := Afeature; //msg.Recog;
            g_MySelf.FeatureChanged;
            g_WaitingUseItem.Item.S.Name := '';
         end;
      SM_TAKEOFF_FAIL:
         begin
            if g_WaitingUseItem.Index < 0 then begin
               n := -(g_WaitingUseItem.Index+1);
               g_UseItems[n] := g_WaitingUseItem.Item;
            end;
            g_WaitingUseItem.Item.S.Name := '';
         end;
      SM_SENDUSEITEMS:
         begin
            ClientGetSenduseItems (body);
         end;
      SM_WEIGHTCHANGED:
         begin
            g_MySelf.m_Abil.Weight := msg.Recog;
            g_MySelf.m_Abil.WearWeight := msg.Param;
            g_MySelf.m_Abil.HandWeight := msg.Tag;
         end;
      SM_GOLDCHANGED: //½ð±Ò¸Ä±ä
         begin
            SoundUtil.PlaySound (s_money); //Ç®µÄÉùÒô
            if msg.Recog > g_MySelf.m_nGold then begin
              DScreen.AddSysMsg (IntToStr(msg.Recog-g_MySelf.m_nGold) +' '+ g_sGoldName{'½ð±Ò¡£'}+'Ôö¼Ó.');
            end;
            g_MySelf.m_nGold := msg.Recog;
            g_MySelf.m_nGameGold:=MakeLong(msg.Param,msg.Tag);
         end;
      SM_FEATURECHANGED: begin
        //body := DecodeString(body);
        DecodeBuffer(body, @Afeature, msg.nSessionID);
        PlayScene.SendMsg (msg.Ident, msg.Recog, 0, 0, 0, {MakeLong(msg.Param, msg.Tag)}0, MakeLong(msg.Series,0), 0, Afeature, '');
      end;
      SM_CHARSTATUSCHANGED: begin
        PlayScene.SendMsg (msg.Ident, msg.Recog, 0, 0, 0, MakeLong(msg.Param, msg.Tag), msg.Series, 0, g_nilFeature, '');
        //PlayScene.SendMsg (msg.Ident, msg.Recog, 0, 0, 0, MakeLong(msg.Param, msg.Tag), msg.Series, DecodeString(Body));
      end;
      SM_CLEAROBJECTS:
         begin
            PlayScene.CleanObjects;
            g_boMapMoving := TRUE; //
         end;

      SM_EAT_OK:
         begin
            g_EatingItem.S.Name := '';
            //×Ô¶¯·ÅÒ© ÉÁµÄÐ§¹û
            if (g_TempIdx <> 200) and (g_TempItemArr.s.Name <> '') then begin
                g_ItemArr[g_TempIdx].Item := g_TempItemArr;
                g_TempItemArr.s.Name := '';
                g_TempIdx := 200;
            end;
            ArrangeItembag;
         end;
      SM_EAT_FAIL:
         begin
            AddItemBag (g_EatingItem);
            g_EatingItem.S.Name := '';
         end;

      SM_ADDMAGIC:
         begin
            if body <> '' then ClientGetAddMagic (body);
         end;
      SM_SENDMYMAGIC: begin
        if body <> '' then begin
          ClientGetMyMagics (body);
          if msg.Recog = 1 then g_WinBatterTopMagic[0].CurTrain := 1;
          if msg.Param = 1 then g_WinBatterTopMagic[1].CurTrain := 1;
          if msg.Tag = 1 then g_WinBatterTopMagic[2].CurTrain := 1;
          if msg.nSessionID = 1 then g_WinBatterTopMagic[3].CurTrain := 1;
        end;
      end;
      SM_DELMAGIC:
         begin
            ClientGetDelMagic (msg.Recog);
         end;
      SM_MAGIC_LVEXP:
         begin
            //ClientGetMagicLvExp (msg.Recog{magid}, msg.Param{lv}, MakeLong(msg.Tag, msg.Series));
            ClientGetMagicLvExp(msg.Recog{magid}, msg.Param{lv}, MakeLong(msg.Tag, msg.Series), msg.nSessionID);
         end;
      SM_DURACHANGE:
         begin
            ClientGetDuraChange (msg.Param{useitem index}, msg.Recog, MakeLong(msg.Tag, msg.Series));
            body := DecodeString(body);
            if body <> '' then begin
              if StrToInt(body) > 0 then g_nBeadWinExp := StrToInt(body);
            end;
         end;

      SM_MERCHANTSAY:
         begin
            ClientGetMerchantSay (msg.Recog, msg.Param, msg.Tag, DecodeString (body));
         end;
      SM_MERCHANTDLGCLOSE:
         begin
            FrmDlg.CloseMDlg;
            FrmDlg.CloseMBigDlg;
         end;
      SM_SENDGOODSLIST:
         begin
            ClientGetSendGoodsList (msg.Recog, msg.Param, body);
         end;
      SM_SENDUSERMAKEDRUGITEMLIST:
         begin
            ClientGetSendMakeDrugList (msg.Recog, body);
         end;
      SM_SENDUSERSELL:
         begin
            ClientGetSendUserSell (msg.Recog);
         end;
      SM_SENDUSERREPAIR:
         begin
            ClientGetSendUserRepair (msg.Recog);
         end;
      {$IF M2Version <> 2}
      SM_SENDUSERARMSEXCHANGE: begin //Ç©¶¨¿ò
        ClientGetSendUserArmsExchange(msg.Recog); 
      end;
      SM_USERARMSEXCHANGE_FAIL: begin //ÎïÆ·²éÑ¯Ê§°Ü
        FrmDlg.LastestClickTime := GetTickCount;
        AddItemBag (g_SellDlgItemSellWait);
        g_SellDlgItemSellWait.S.Name := '';
        case Msg.Recog of
          0: FrmDlg.DMessageDlg ('¶Ô²»Æð£¬ÄãµÄ×°±¸¼¶±ðÌ«µÍ£¬Æ·ÖÊÌ«²î£¬ÎÒ²»ÊÕÕâÑùµÄ×°±¸¡£', [mbOk]);
          1: FrmDlg.DMessageDlg ('½ûÖ¹½»Ò×ÎïÆ·£¬²»ÄÜ¶Ò»»£¡', [mbOk]);
          else FrmDlg.DMessageDlg ('Ç©¶¨´íÎó Code:'+IntToStr(msg.Recog), [mbOk]);
        end;
      end;
      SM_USERARMSEXCHANGE_OK: begin
        FrmDlg.LastestClickTime := GetTickCount;
        g_SellDlgItemSellWait.S.Name := '';
      end;
      SM_SENDUSERARMSTEAR: Begin//ÎäÆ÷²ðÐ¶³àÑ×Ê¯ 20100708
           ClientGetSendUserArmsTear(msg.Recog);
      end;
      SM_USERARMSTEAR_OK: Begin//ÎäÆ÷²ðÐ¶³É¹¦ 20100708
           FrmDlg.LastestClickTime := GetTickCount;
           g_SellDlgItemSellWait.S.NeedIdentify := Msg.Recog;//20101007 ÐÞ¸Ä
           AddItemBag (g_SellDlgItemSellWait);
           g_SellDlgItemSellWait.S.Name := '';
           FrmDlg.DMessageDlg ('²ð·Ö³É¹¦£¬Çë²é¿´ÄãµÄ°ü¹ü', [mbOk]);
         end;
      SM_USERARMSTEAR_FAIL://ÎäÆ÷²ðÐ¶Ê§°Ü 20100708
         begin
           FrmDlg.LastestClickTime := GetTickCount;
           AddItemBag (g_SellDlgItemSellWait);
           g_SellDlgItemSellWait.S.Name := '';
           case msg.Recog of
              1: FrmDlg.DMessageDlg ('ÄúµÄ×°±¸ÉÏÃ»ÓÐÏâÇ¶³àÑ×Ê¯', [mbOk]);
              2: begin
                case msg.Param of
                  1: FrmDlg.DMessageDlg (g_sGoldName+'²»×ã', [mbOk]);
                  2: FrmDlg.DMessageDlg (g_sGameGird+'²»×ã', [mbOk]);
                  3: FrmDlg.DMessageDlg (g_sGameDiaMond+'²»×ã', [mbOk]);
                  else FrmDlg.DMessageDlg (g_sGameGoldName+'²»×ã', [mbOk]);
                end;
              end;
              3: FrmDlg.DMessageDlg ('Ö»ÓÐÎäÆ÷²ÅÄÜ²ð·Ö³àÑ×Ê¯', [mbOk]);
              4: FrmDlg.DMessageDlg ('ÄúµÄ°ü¹üÒÑÃ»ÓÐ°ì·¨×°ÏÂÈÎºÎÎïÆ·!', [mbOk]);
              else  FrmDlg.DMessageDlg ('ÄúµÄ×°±¸ÉÏÃ»ÓÐÏâÇ¶³àÑ×Ê¯', [mbOk]);
           end;
         end;
      SM_SENDARMSEXCHANGEPRICE: begin
        if g_SellDlgItem.S.Name <> '' then begin
           if msg.Recog > 0 then
              g_sSellPriceStr := Format('»»£º%d¾íÖáËéÆ¬', [msg.Recog])
           else g_sSellPriceStr := '×°±¸¼¶±ðÌ«µÍ';
        end;
      end;
      {$IFEND}
      SM_SENDBUYPRICE:
         begin
            if g_SellDlgItem.S.Name <> '' then begin
               if msg.Recog > 0 then
                  g_sSellPriceStr := IntToStr(msg.Recog) + ' ' + g_sGoldName{½ð±Ò'}
               else g_sSellPriceStr := '???? ' + g_sGoldName{½ð±Ò'};
            end;
         end;
      SM_USERSELLITEM_OK:
         begin
            FrmDlg.LastestClickTime := GetTickCount;
            g_MySelf.m_nGold := msg.Recog;
            g_SellDlgItemSellWait.S.Name := '';
         end;

      SM_USERSELLITEM_FAIL:
         begin
            FrmDlg.LastestClickTime := GetTickCount;
            AddItemBag (g_SellDlgItemSellWait);
            g_SellDlgItemSellWait.S.Name := '';
            FrmDlg.DMessageDlg ('Äú²»ÄÜ³öÊÛ´ËÎïÆ·.', [mbOk]);
         end;

      SM_SENDREPAIRCOST:
         begin
            if g_SellDlgItem.S.Name <> '' then begin
               if msg.Recog >= 0 then
                  g_sSellPriceStr := IntToStr(msg.Recog) + ' ' + g_sGoldName{½ð±Ò}
               else g_sSellPriceStr := '???? ' + g_sGoldName{½ð±Ò};
            end;
         end;
      SM_USERREPAIRITEM_OK:
         begin
            if g_SellDlgItemSellWait.S.Name <> '' then begin
               FrmDlg.LastestClickTime := GetTickCount;
               g_MySelf.m_nGold := msg.Recog;
               g_SellDlgItemSellWait.Dura := msg.Param;
               g_SellDlgItemSellWait.DuraMax := msg.Tag;
               AddItemBag (g_SellDlgItemSellWait);
               g_SellDlgItemSellWait.S.Name := '';
            end;
         end;
      SM_USERREPAIRITEM_FAIL:
         begin
            FrmDlg.LastestClickTime := GetTickCount;
            AddItemBag (g_SellDlgItemSellWait);
            g_SellDlgItemSellWait.S.Name := '';
            FrmDlg.DMessageDlg ('Äú²»ÄÜÐÞÀí´ËÎïÆ·.', [mbOk]);
         end;
      SM_STORAGE_OK,
      SM_STORAGE_FULL,
      SM_STORAGE_FAIL:
         begin
            FrmDlg.LastestClickTime := GetTickCount;
            if msg.Ident <> SM_STORAGE_OK then begin
               if msg.Ident = SM_STORAGE_FULL then
                  FrmDlg.DMessageDlg ('ÄúµÄ²Ö¿âÒÑ¾­ÂúÁË£¬²»ÄÜÔÙ±£¹ÜÈÎºÎ¶«Î÷ÁË.', [mbOk])
               else
                  FrmDlg.DMessageDlg ('Äú²»ÄÜ¼Ä´æÎïÆ·.', [mbOk]);
               AddItemBag (g_SellDlgItemSellWait);
            end;
            g_SellDlgItemSellWait.S.Name := '';
         end;
      SM_SAVEITEMLIST:
         begin
            ClientGetSaveItemList (msg.Recog, body);
         end;
      SM_TAKEBACKSTORAGEITEM_OK,
      SM_TAKEBACKSTORAGEITEM_FAIL,
      SM_TAKEBACKSTORAGEITEM_FULLBAG:
         begin
            FrmDlg.LastestClickTime := GetTickCount;
            if msg.Ident <> SM_TAKEBACKSTORAGEITEM_OK then begin
               if msg.Ident = SM_TAKEBACKSTORAGEITEM_FULLBAG then
                  FrmDlg.DMessageDlg ('ÄúÎÞ·¨Ð¯´ø¸ü¶àÎïÆ·ÁË.', [mbOk])
               else
                  FrmDlg.DMessageDlg ('ÄúÎÞ·¨È¡»ØÎïÆ·.', [mbOk]);
            end else
               FrmDlg.DelStorageItem (msg.Recog); //itemserverindex
         end;

      SM_BUYITEM_SUCCESS:
         begin
            FrmDlg.LastestClickTime := GetTickCount;
            g_MySelf.m_nGold := msg.Recog;
            FrmDlg.SoldOutGoods (MakeLong(msg.Param, msg.Tag)); //ÆÈ¸° ¾ÆÀÌÅÛ ¸Þ´º¿¡¼­ »­
         end;
      SM_BUYITEM_FAIL:
         begin
            FrmDlg.LastestClickTime := GetTickCount;
            case msg.Recog of
               1: FrmDlg.DMessageDlg ('´ËÎïÆ·±»Âô³ö.', [mbOk]);
               2: FrmDlg.DMessageDlg ('ÄúÎÞ·¨Ð¯´ø¸ü¶àÎïÆ·ÁË.', [mbOk]);
               3: FrmDlg.DMessageDlg ('ÄúÃ»ÓÐ×ã¹»µÄÇ®À´¹ºÂò´ËÎïÆ·.', [mbOk]);
            end;
         end;
      SM_MAKEDRUG_SUCCESS:
         begin
            FrmDlg.LastestClickTime := GetTickCount;
            g_MySelf.m_nGold := msg.Recog;
            FrmDlg.DMessageDlg ('ÄúÒªµÄÎïÆ·ÒÑ¾­¸ãºÃÁË', [mbOk]);
         end;
      SM_MAKEDRUG_FAIL: begin
        FrmDlg.LastestClickTime := GetTickCount;
        case msg.Recog of
          1: FrmDlg.DMessageDlg ('ÎïÆ·²»´æÔÚ.', [mbOk]);
          2: FrmDlg.DMessageDlg ('ÄúÎÞ·¨Ð¯´ø¸ü¶àÎïÆ·ÁË.', [mbOk]);
          3: FrmDlg.DMessageDlg (g_sGoldName{'½ð±Ò'} + '²»×ã.', [mbOk]);
          4: FrmDlg.DMessageDlg ('ÄãÈ±·¦Ëù±ØÐèµÄÎïÆ·¡£', [mbOk]);
        end;
      end;
      SM_716: begin
        DrawEffectHum(msg.Recog{actorid}, msg.Series{type},Msg.Param{x},Msg.Tag{y}, msg.nSessionID);
      end;
      SM_SENDDETAILGOODSLIST: begin
        ClientGetSendDetailGoodsList (msg.Recog, msg.Param, msg.Tag, body);
      end;

      SM_GROUPMODECHANGED: //¼­¹ö¿¡¼­ ³ªÀÇ ±×·ì ¼³Á¤ÀÌ º¯°æµÇ¾úÀ½.
         begin
            if msg.Param > 0 then g_boAllowGroup := TRUE
            else g_boAllowGroup := FALSE;
            g_dwChangeGroupModeTick := GetTickCount;
         end;
      SM_CREATEGROUP_OK:
         begin
            g_dwChangeGroupModeTick := GetTickCount;
            g_boAllowGroup := TRUE;
            {GroupMembers.Add (Myself.UserName);
            GroupMembers.Add (DecodeString(body));}
         end;
      SM_CREATEGROUP_FAIL:
         begin
            g_dwChangeGroupModeTick := GetTickCount;
            case msg.Recog of
               -1: DScreen.AddChatBoardString('±à×éÉÐÎ´³ÉÁ¢»òÕßÄã»¹²»¹»µÈ¼¶´´½¨¡£', ClWhite, clRed);//FrmDlg.DMessageDlg ('±à×é»¹Î´³ÉÁ¢.', [mbOk]);
               -2: DScreen.AddChatBoardString('Õâ¸ö±»¼Ó½ø±à×éµÄÃû×ÖÊÇ²»ÕýÈ·µÄ¡£', ClWhite, clRed);//FrmDlg.DMessageDlg ('ÊäÈëµÄÈËÎïÃû³Æ²»ÕýÈ·.', [mbOk]);
               -3: DScreen.AddChatBoardString('ÄãÏë¼ÓÈë±à×éµÄÕâÎ»ÓÃ»§ÒÑ¾­ÊÇÆäËû×éµÄ³ÉÔ±ÁË¡£', ClWhite, clRed);//FrmDlg.DMessageDlg ('ÄúÏëÑûÇë¼ÓÈë±à×éµÄÈËÒÑ¾­¼ÓÈëÁËÆäËü×é.', [mbOk]);
               -4: DScreen.AddChatBoardString('¶Ô·½²»ÔÊÐí±à×é¡£', ClWhite, clRed);//FrmDlg.DMessageDlg ('¶Ô·½²»ÔÊÐí±à×é.', [mbOk]);
            end;
         end;
      SM_GROUPADDMEM_OK:
         begin
            g_dwChangeGroupModeTick := GetTickCount;
            //GroupMembers.Add (DecodeString(body));
         end;
      SM_GROUPADDMEM_FAIL:
         begin
            g_dwChangeGroupModeTick := GetTickCount;
            case msg.Recog of
               -1: DScreen.AddChatBoardString('±à×éÉÐÎ´³ÉÁ¢»òÕßÄã»¹²»¹»µÈ¼¶´´½¨¡£', ClWhite, clRed);//FrmDlg.DMessageDlg ('±à×é»¹Î´³ÉÁ¢.', [mbOk]);
               -2: DScreen.AddChatBoardString('Õâ¸ö±»¼Ó½ø±à×éµÄÃû×ÖÊÇ²»ÕýÈ·µÄ¡£', ClWhite, clRed);//FrmDlg.DMessageDlg ('ÊäÈëµÄÈËÎïÃû³Æ²»ÕýÈ·.', [mbOk]);
               -3: DScreen.AddChatBoardString('ÒÑ¾­¼ÓÈë±à×é¡£', ClWhite, clRed);//FrmDlg.DMessageDlg ('ÒÑ¾­¼ÓÈë±à×é.', [mbOk]);
               -4: DScreen.AddChatBoardString('¶Ô·½²»ÔÊÐí±à×é¡£', ClWhite, clRed);//FrmDlg.DMessageDlg ('¶Ô·½²»ÔÊÐí±à×é.', [mbOk]);
               -5: DScreen.AddChatBoardString('ÄãÏë¼ÓÈë±à×éµÄÕâÎ»ÓÃ»§ÒÑ¾­ÊÇÆäËû×éµÄ³ÉÔ±ÁË¡£', ClWhite, clRed);//FrmDlg.DMessageDlg ('ÄúÏëÑûÇë¼ÓÈë±à×éµÄÈËÒÑ¾­¼ÓÈëÁËÆäËü×é£¡', [mbOk]);
            end;
         end;
      SM_GROUPDELMEM_OK:
         begin
            g_dwChangeGroupModeTick := GetTickCount;
            {data := DecodeString (body);
            for i:=0 to GroupMembers.Count-1 do begin
               if GroupMembers[i] = data then begin
                  GroupMembers.Delete (i);
                  break;
               end;
            end; }
         end;
      SM_GROUPDELMEM_FAIL:
         begin
            g_dwChangeGroupModeTick := GetTickCount;
            case msg.Recog of
               -1: DScreen.AddChatBoardString('±à×éÉÐÎ´³ÉÁ¢»òÕßÄã»¹²»¹»µÈ¼¶´´½¨¡£', ClWhite, clRed);//FrmDlg.DMessageDlg ('±à×é»¹Î´³ÉÁ¢.', [mbOk]);
               -2: DScreen.AddChatBoardString('Õâ¸ö±»¼Ó½ø±à×éµÄÃû×ÖÊÇ²»ÕýÈ·µÄ¡£', ClWhite, clRed);//FrmDlg.DMessageDlg ('ÊäÈëµÄÈËÎïÃû³Æ²»ÕýÈ·.', [mbOk]);
               -3: FrmDlg.DMessageDlg ('´ËÈË²»ÔÚ±¾×éÖÐ.', [mbOk]);
            end;
         end;
      SM_GROUPCANCEL: begin
        g_GroupMembers.Clear;
      end;
      SM_GROUPMEMBERS:
         begin
            ClientGetGroupMembers (DecodeString(Body));
         end;

      SM_OPENGUILDDLG:
         begin
            g_dwQueryMsgTick := GetTickCount;
            ClientGetOpenGuildDlg (body);
         end;

      SM_SENDGUILDMEMBERLIST:
         begin
            g_dwQueryMsgTick := GetTickCount;
            ClientGetSendGuildMemberList (body);
         end;

      SM_OPENGUILDDLG_FAIL:
         begin
            g_dwQueryMsgTick := GetTickCount;
            FrmDlg.DMessageDlg ('Äú»¹Ã»ÓÐ¼ÓÈëÐÐ»á.', [mbOk]);
         end;

      SM_DEALTRY_FAIL: begin
        g_dwQueryMsgTick := GetTickCount;
        FrmDlg.DMessageDlg ('Á½¸öÍæ¼ÒÃæ¶ÔÃæ²ÅÄÜ½øÐÐÏà¹Ø½»Ò×.', [mbOk]);
      end;
      SM_DEALMENU:
         begin
            g_dwQueryMsgTick := GetTickCount;
            g_sDealWho := DecodeString (body);
            FrmDlg.OpenDealDlg;
         end;
      SM_DEALCANCEL: begin
        MoveDealItemToBag;
        if g_DealDlgItem.S.Name <> '' then begin
          AddItemBag (g_DealDlgItem);  //°¡¹æ¿¡ Ãß°¡
          g_DealDlgItem.S.Name := '';
        end;
        if g_nDealGold > 0 then begin
          g_MySelf.m_nGold := g_MySelf.m_nGold + g_nDealGold;
          g_nDealGold := 0;
        end;
        FrmDlg.CloseDealDlg;
      end;
      SM_DEALADDITEM_OK:
         begin
            g_dwDealActionTick := GetTickCount;
            if g_DealDlgItem.S.Name <> '' then begin
               AddDealItem (g_DealDlgItem);  //Deal Dlg¿¡ Ãß°¡
               g_DealDlgItem.S.Name := '';
            end;
         end;
      SM_DEALADDITEM_FAIL: begin
        g_dwDealActionTick:=GetTickCount;
        if g_DealDlgItem.S.Name <> '' then begin
          AddItemBag(g_DealDlgItem);  //°¡¹æ¿¡ Ãß°¡
          g_DealDlgItem.S.Name:= '';
        end;
      end;
      SM_DEALDELITEM_OK: begin
        g_dwDealActionTick:=GetTickCount;
        if g_DealDlgItem.S.Name <> '' then begin
               //AddItemBag (DealDlgItem);  //°¡¹æ¿¡ Ãß°¡
          g_DealDlgItem.S.Name := '';
        end;
      end;
      SM_DEALDELITEM_FAIL: begin
        g_dwDealActionTick := GetTickCount;
        if g_DealDlgItem.S.Name <> '' then begin
          DelItemBag (g_DealDlgItem.S.Name, g_DealDlgItem.MakeIndex);
          AddDealItem (g_DealDlgItem);
          g_DealDlgItem.S.Name := '';
        end;
      end;
      SM_DEALREMOTEADDITEM: ClientGetDealRemoteAddItem (body);
      SM_DEALREMOTEDELITEM: ClientGetDealRemoteDelItem (body);
      SM_DEALCHGGOLD_OK: begin
        g_nDealGold:=msg.Recog;
        g_MySelf.m_nGold:=MakeLong(msg.param, msg.tag);
        g_dwDealActionTick:=GetTickCount;
      end;
      SM_DEALCHGGOLD_FAIL: begin
        g_nDealGold:=msg.Recog;
        g_MySelf.m_nGold:=MakeLong(msg.param, msg.tag);
        g_dwDealActionTick:=GetTickCount;
      end;
      SM_DEALREMOTECHGGOLD: begin
        g_nDealRemoteGold:=msg.Recog;
        SoundUtil.PlaySound(s_money); 
      end;
      SM_DEALSUCCESS: begin
        FrmDlg.CloseDealDlg;
      end;
      SM_SENDUSERSTORAGEITEM: begin
        ClientGetSendUserStorage(msg.Recog);
      end;
      SM_READMINIMAP_OK: begin
        g_dwQueryMsgTick:=GetTickCount;
        ClientGetReadMiniMap(msg.Param);
      end;
      SM_READMINIMAP_FAIL: begin
        g_dwQueryMsgTick := GetTickCount;
        DScreen.AddChatBoardString ('Ã»ÓÐ¿ÉÓÃµÄµØÍ¼¡£', clWhite, clRed);
        g_nMiniMapIndex:= -1;
      end;
      SM_CHANGEGUILDNAME: begin
        ClientGetChangeGuildName(DecodeString (body));
      end;
      SM_SENDUSERSTATE: begin     //²é¿´±ðÈË×°±¸
        g_boUserIsWho := msg.Recog;
        ClientGetSendUserState(body);
      end;
      SM_GUILDADDMEMBER_OK: begin
        SendGuildMemberList;
      end;
      SM_GUILDADDMEMBER_FAIL: begin
        case msg.Recog of
          1: FrmDlg.DMessageDlg ('ÄãÃ»ÓÐÈ¨ÀûÊ¹ÓÃÕâ¸öÃüÁî.', [mbOk]);
          2: FrmDlg.DMessageDlg ('Ïë¼ÓÈëÐÐ»áµÄÓ¦¸ÃÀ´Ãæ¶ÔÐÐ»áÕÆÃÅÈË.', [mbOk]);
          3: FrmDlg.DMessageDlg ('¶Ô·½ÒÑ¾­¼ÓÈëÐÐ»á.', [mbOk]);
          4: FrmDlg.DMessageDlg ('¶Ô·½ÒÑ¾­¼ÓÈëÆäËûÐÐ»á.', [mbOk]);
          5: FrmDlg.DMessageDlg ('¶Ô·½²»Ïë¼ÓÈëÐÐ»á.', [mbOk]);
          6: FrmDlg.DMessageDlg ('ÒÑ´ïµ½ÐÐ»áÈËÊýÉÏÏÞ.', [mbOk]);
        end;
      end;
      SM_GUILDDELMEMBER_OK: begin
        SendGuildMemberList;
      end;
      SM_GUILDDELMEMBER_FAIL: begin
        case msg.Recog of
          1: FrmDlg.DMessageDlg('²»ÄÜÊ¹ÓÃÃüÁî£¡', [mbOk]);
          2: FrmDlg.DMessageDlg('´ËÈË·Ç±¾ÐÐ»á³ÉÔ±£¡', [mbOk]);
          3: FrmDlg.DMessageDlg('ÐÐ»áÕÆÃÅÈË²»ÄÜ¿ª³ý×Ô¼º£¡', [mbOk]);
          4: FrmDlg.DMessageDlg('²»ÄÜÊ¹ÓÃÃüÁîZ£¡', [mbOk]);
        end;
      end;
      SM_GUILDRANKUPDATE_FAIL: begin
        case msg.Recog of
          -2: FrmDlg.DMessageDlg('[ÌáÊ¾ÐÅÏ¢] ÕÆÃÅÈËÎ»ÖÃ²»ÄÜÎª¿Õ¡£', [mbOk]);
          -3: FrmDlg.DMessageDlg('[ÌáÊ¾ÐÅÏ¢] ÐÂµÄÐÐ»áÕÆÃÅÈËÒÑ¾­±»´«Î»¡£', [mbOk]);
          -4: FrmDlg.DMessageDlg('[ÌáÊ¾ÐÅÏ¢] Ò»¸öÐÐ»á×î¶àÖ»ÄÜÓÐ¶þ¸öÕÆÃÅÈË¡£', [mbOk]);
          -5: FrmDlg.DMessageDlg('[ÌáÊ¾ÐÅÏ¢] ÕÆÃÅÈËÎ»ÖÃ²»ÄÜÎª¿Õ¡£', [mbOk]);
          -6: FrmDlg.DMessageDlg('[ÌáÊ¾ÐÅÏ¢] ²»ÄÜÌí¼Ó³ÉÔ±/É¾³ý³ÉÔ±¡£', [mbOk]);
          -7: FrmDlg.DMessageDlg('[ÌáÊ¾ÐÅÏ¢] Ö°Î»ÖØ¸´»òÕß³ö´í¡£', [mbOk]);
        end;
      end;
      SM_GUILDMAKEALLY_OK,
      SM_GUILDMAKEALLY_FAIL: begin
        case msg.Recog of
          -1: FrmDlg.DMessageDlg ('ÄúÎÞ´ËÈ¨ÏÞ£¡', [mbOk]);
          -2: FrmDlg.DMessageDlg ('½áÃËÊ§°Ü£¡', [mbOk]);
          -3: FrmDlg.DMessageDlg ('ÐÐ»á½áÃË±ØÐëË«·½ÕÆÃÅÈËÃæ¶ÔÃæ£¡', [mbOk]);
          -4: FrmDlg.DMessageDlg ('¶Ô·½ÐÐ»áÕÆÃÅÈË²»ÔÊÐí½áÃË£¡', [mbOk]);
        end;
      end;
      SM_GUILDBREAKALLY_OK,
      SM_GUILDBREAKALLY_FAIL: begin
        case msg.Recog of
          -1: FrmDlg.DMessageDlg ('½â³ý½áÃË£¡', [mbOk]);
          -2: FrmDlg.DMessageDlg ('´ËÐÐ»á²»ÊÇÄúÐÐ»áµÄ½áÃËÐÐ»á£¡', [mbOk]);
          -3: FrmDlg.DMessageDlg ('Ã»ÓÐ´ËÐÐ»á£¡', [mbOk]);
        end;
      end;
      SM_BUILDGUILD_OK: begin
        FrmDlg.LastestClickTime := GetTickCount;
        FrmDlg.DMessageDlg ('ÐÐ»á½¨Á¢³É¹¦.', [mbOk]);
      end;
      SM_BUILDGUILD_FAIL: begin
        FrmDlg.LastestClickTime := GetTickCount;
        case msg.Recog of
          -1: FrmDlg.DMessageDlg('ÄúÒÑ¾­¼ÓÈëÆäËüÐÐ»á¡£', [mbOk]);
          -2: FrmDlg.DMessageDlg('È±ÉÙ´´½¨·ÑÓÃ¡£', [mbOk]);
          -3: FrmDlg.DMessageDlg('ÄãÃ»ÓÐ×¼±¸ºÃÐèÒªµÄÈ«²¿ÎïÆ·¡£', [mbOk]);
          else FrmDlg.DMessageDlg('´´½¨ÐÐ»áÊ§°Ü£¡£¡£¡', [mbOk]);
        end;
      end;
      SM_MENU_OK: begin
        FrmDlg.LastestClickTime:=GetTickCount;
        if body <> '' then begin
          data:= DecodeString(body);
          case msg.Param of
            1: begin  //±¦Ïä¹ºÂòÔ¿³×ÌáÊ¾ 20090225
              if mrOk = FrmDlg.DMessageDlg(data, [mbOk,mbCancel]) then begin
                if FrmDlg.DCheckAutoOpenBoxs.Checked then begin//20090228
                  msg := MakeDefaultMsg(aa(CM_BUYNEWBOXSKEY, TempCertification), 1{±íÊ¾×Ô¶¯}, msg.Tag, 0, 0, m_nSendMsgCount);
                end else msg := MakeDefaultMsg(aa(CM_BUYNEWBOXSKEY, TempCertification), 0, msg.Tag, 0, 0, m_nSendMsgCount);
                SendSocket(EncodeMessage(msg));
              end else begin
                if (FrmDlg.DBoxs.FaceIndex = 210) or (FrmDlg.DBoxs.FaceIndex = 510) then begin
                  FrmDlg.DBoxsNewClose.Visible := True;
                  FrmDlg.DCheckAutoOpenBoxs.Checked := False;
                  FrmDlg.DBoxsTautology.Visible := True;
                end;
              end;
            end;
            2: begin
              FrmDlg.DCheckAutoOpenBoxs.Checked := False;
              FrmDlg.DBoxsNewClose.Visible := True;
              FrmDlg.DMessageDlg(data, [mbOk]);
            end;
            {$IF M2Version = 1}
            3:  begin//Ö´ÐÐÁ¬»÷NPC´¥·¢ 20090623
              if Pos('/@', data) > 0 then begin
                data := GetValidStr3 (data, tagstr, ['/']);//ÏÔÊ¾µÄÐÅÏ¢
                data := GetValidStr3 (data, str6, ['/']);//Str6´¥·¢²ÎÊý1£¬data´¥·¢²ÎÊý2
                if mrOk = FrmDlg.DMessageDlg(tagstr, [mbOk,mbCancel]) then begin
                  if str6 <> '' then begin
                    msg := MakeDefaultMsg (aa(CM_CLICKBATTERNPC, TempCertification), 0, 0, 0, 0, m_nSendMsgCount);
                    SendSocket (EncodeMessage (msg) + EncodeString(str6));
                  end;
                end;
              end;
            end;
            {$IFEND}
            4: begin//¾ÅÖÜÄê±¦Ïä¹ºÂòÔ¿³×ÌáÊ¾
              if mrOk = FrmDlg.DMessageDlg(data, [mbOk,mbCancel]) then begin
                msg := MakeDefaultMsg(aa(CM_BUY9YEARSBOXSKEY, TempCertification), 0, msg.Tag, 0, 0, m_nSendMsgCount);
                SendSocket(EncodeMessage(msg));
              end;
            end;
            {$IF M2Version <> 2}
            5: begin //´«ÆæÖ®ÐÇÕÙ»½
              if mrOk = FrmDlg.DMessageDlg(data, [mbOk,mbCancel]) then begin
                msg := MakeDefaultMsg(aa(CM_AGREECALLFENGHAO, TempCertification), 0, 0, 0, 0, m_nSendMsgCount);
                SendSocket(EncodeMessage(msg));
              end else begin
                msg := MakeDefaultMsg(aa(CM_CANCELCALLFENGHAO, TempCertification), 0, 0, 0, 0, m_nSendMsgCount);
                SendSocket(EncodeMessage(msg));
              end;
            end;
            6: begin //´«ÆæÖ®ÐÇ´«ËÍ
              if mrOk = FrmDlg.DMessageDlg(data, [mbOk,mbCancel]) then begin
                msg := MakeDefaultMsg(aa(CM_AGREECALLFENGHAO, TempCertification), 0, 1, 0, 0, m_nSendMsgCount);
                SendSocket(EncodeMessage(msg));
              end else begin
                msg := MakeDefaultMsg(aa(CM_CANCELCALLFENGHAO, TempCertification), 0, 1, 0, 0, m_nSendMsgCount);
                SendSocket(EncodeMessage(msg));
              end;
            end;
            7: begin //Ö÷Ô×ÁîÕÙ»½
              if mrOk = FrmDlg.DMessageDlg(data, [mbOk,mbCancel]) then begin
                msg := MakeDefaultMsg(aa(CM_AGREECALLFENGHAO, TempCertification), 1, 0, 0, 0, m_nSendMsgCount);
                SendSocket(EncodeMessage(msg));
              end else begin
                msg := MakeDefaultMsg(aa(CM_CANCELCALLFENGHAO, TempCertification), 1, 0, 0, 0, m_nSendMsgCount);
                SendSocket(EncodeMessage(msg));
              end;
            end;
            8: begin //Ö÷Ô×Áî´«ËÍ
              if mrOk = FrmDlg.DMessageDlg(data, [mbOk,mbCancel]) then begin
                msg := MakeDefaultMsg(aa(CM_AGREECALLFENGHAO, TempCertification), 1, 1, 0, 0, m_nSendMsgCount);
                SendSocket(EncodeMessage(msg));
              end else begin
                msg := MakeDefaultMsg(aa(CM_CANCELCALLFENGHAO, TempCertification), 1, 1, 0, 0, m_nSendMsgCount);
                SendSocket(EncodeMessage(msg));
              end;
            end;
            9: begin //ÉèÖÃÈÎÃü³ÆºÅ·¢ËÍÈ·ÈÏÐÅÏ¢
              if mrOk = FrmDlg.DMessageDlg(data, [mbOk,mbCancel]) then begin
                msg := MakeDefaultMsg(aa(CM_FENGHAOAGREE, TempCertification), 1, 0, 0, 0, m_nSendMsgCount);
                SendSocket(EncodeMessage(msg));
              end else begin
                msg := MakeDefaultMsg(aa(CM_FENGHAOAGREE, TempCertification), 0, 0, 0, 0, m_nSendMsgCount);
                SendSocket(EncodeMessage(msg));
              end;
            end;
            {$IFEND}
            else begin
              if Pos('/@', data) > 0 then begin
                data := GetValidStr3 (data, tagstr, ['/']);//ÏÔÊ¾µÄÐÅÏ¢
                data := GetValidStr3 (data, str6, ['/']);//Str6´¥·¢²ÎÊý1£¬data´¥·¢²ÎÊý2
                if mrOk = FrmDlg.DMessageDlg(tagstr, [mbOk,mbCancel]) then begin
                  if str6 <> '' then begin
                    msg := MakeDefaultMsg (aa(CM_CLICKSIGHICON, TempCertification), 0, 2, 0, 0, m_nSendMsgCount);
                    SendSocket (EncodeMessage (msg) + EncodeString(str6));
                  end;
                end else begin
                  if data <> '' then begin
                    msg := MakeDefaultMsg (aa(CM_CLICKSIGHICON, TempCertification), 0, 3, 0, 0, m_nSendMsgCount);
                    SendSocket (EncodeMessage (msg) + EncodeString(data));
                  end;
                end;
              end else FrmDlg.DMessageDlg(data, [mbOk]);
            end;
          end;
        end;
      end;
      SM_DLGMSG: begin
        if body <> '' then
          FrmDlg.DMessageDlg(DecodeString(body), [mbOk]);
      end;
      SM_DONATE_OK: begin
        FrmDlg.LastestClickTime:=GetTickCount;
      end;
      SM_DONATE_FAIL: begin
        FrmDlg.LastestClickTime:=GetTickCount;
      end;
      SM_PLAYDICE: begin//×ª÷»×Ó
        Body2:=Copy(Body,GetCodeMsgSize(sizeof(wl2)*4/3) + 1, Length(body));
        //ÐÞ¸´Ö§³ÖÐÂµÄ¼ÓÃÜ·½·¨By TasNat at: 2012-11-15 20:14:43
        Delete(body, length(body)- Length(Body2)+1, Length(Body2));
        DecodeBuffer(body,@wl2,SizeOf(wl2));
        data:=DecodeString(Body2);
        FrmDlg.m_nDiceCount:=Msg.Param;//QuestActionInfo.nParam1  ÷»×ÓÊýÁ¿
        FrmDlg.m_Dice[0].nDicePoint:=LoByte(LoWord(wl2.lParam1)); //UserHuman.m_DyVal[0]
        FrmDlg.m_Dice[1].nDicePoint:=HiByte(LoWord(wl2.lParam1)); //UserHuman.m_DyVal[0]
        FrmDlg.m_Dice[2].nDicePoint:=LoByte(HiWord(wl2.lParam1)); //UserHuman.m_DyVal[0]
        FrmDlg.m_Dice[3].nDicePoint:=HiByte(HiWord(wl2.lParam1)); //UserHuman.m_DyVal[0]
        FrmDlg.m_Dice[4].nDicePoint:=LoByte(LoWord(wl2.lParam2)); //UserHuman.m_DyVal[0]
        FrmDlg.m_Dice[5].nDicePoint:=HiByte(LoWord(wl2.lParam2)); //UserHuman.m_DyVal[0]
        FrmDlg.m_Dice[6].nDicePoint:=LoByte(HiWord(wl2.lParam2)); //UserHuman.m_DyVal[0]
        FrmDlg.m_Dice[7].nDicePoint:=HiByte(HiWord(wl2.lParam2)); //UserHuman.m_DyVal[0]
        FrmDlg.m_Dice[8].nDicePoint:=LoByte(LoWord(wl2.lTag1)); //UserHuman.m_DyVal[0]
        FrmDlg.m_Dice[9].nDicePoint:=HiByte(LoWord(wl2.lTag1)); //UserHuman.m_DyVal[0]
        FrmDlg.DialogSize:=0;
        FrmDlg.DMessageDlg('',[]);
        msg := MakeDefaultMsg(aa(CM_PLAYDICELabel, TempCertification), msg.Recog, 0, 0, 0, m_nSendMsgCount);
            SendSocket(EncodeMessage(msg));
      end;
      {SM_NEEDPASSWORD: begin   //Ã»ÓÃµ½
        ClientGetNeedPassword(Body);
      end;  }
      SM_PASSWORDSTATUS: begin
        //ClientGetPasswordStatus(@Msg,Body);
      end;
      else begin
        if g_MySelf = nil then Exit;     //Jacky ÔÚÎ´½øÈëÓÎÏ·Ê±²»´¦ÀíÏÂÃæ
        DebugOutStr(Format('Î´´¦ÀíÏûÏ¢ Ident: %d Recog: %d Param: %d Tag: %d Series: %d',[msg.Ident,msg.Recog,msg.Param,msg.Tag,msg.Series]));
        {FrmDlg.DMessageDlg ('·¢ÏÖ·Ç·¨Íâ¹Ò£¬¶Ï¿ªÓÎÏ·!!', [mbOk]);
        asm //¹Ø±Õ³ÌÐò
          MOV FS:[0],0;
          MOV DS:[0],EAX;
        end;   }
      end;
  end;
   {if Pos('#', datablock) > 0 then
      DScreen.AddSysMsg (datablock);  }
end;


procedure TfrmMain.ClientGetPasswdSuccess (Msg:TDefaultMessage;body: string);
var
   str, runaddr, runport, certifystr: string;
begin
   g_wAvailIDDay := msg.Recog;
   g_wAvailIDHour := msg.nSessionID;
//   g_wAvailIDDay := Loword(msg.Recog);
//   g_wAvailIDHour := Hiword(msg.Recog);
   g_wAvailIPDay := msg.Param;
   g_wAvailIPHour := msg.Tag;

   if g_wAvailIDDay > 0 then begin
      if g_wAvailIDDay = 1 then
         FrmDlg.DMessageDlg ('Äúµ±Ç°ID·ÑÓÃµ½½ñÌìÎªÖ¹¡£', [mbOk])
      else if g_wAvailIDDay <= 3 then
         FrmDlg.DMessageDlg ('Äúµ±Ç°ID·ÑÓÃ»¹Ê£ ' + IntToStr(g_wAvailIDDay) + ' Ìì¡£', [mbOk]);
   end else if g_wAvailIPDay > 0 then begin
      if g_wAvailIPDay = 1 then
         FrmDlg.DMessageDlg ('Äúµ±Ç°IP·ÑÓÃµ½½ñÌìÎªÖ¹¡£', [mbOk])
      else if g_wAvailIPDay <= 3 then
         FrmDlg.DMessageDlg ('Äúµ±Ç°IP·ÑÓÃ»¹Ê£ ' + IntToStr(g_wAvailIPDay) + ' Ìì¡£', [mbOk]);
   end else if g_wAvailIPHour > 0 then begin
      if g_wAvailIPHour <= 100 then
         FrmDlg.DMessageDlg ('Äúµ±Ç°IP·ÑÓÃ»¹Ê£ ' + IntToStr(g_wAvailIPHour) + ' Ð¡Ê±¡£', [mbOk]);
   end else if g_wAvailIDHour > 0 then begin
     if (g_wAvailIDHour div 60) > 0 then
       FrmDlg.DMessageDlg ('Äúµ±Ç°ID·ÑÓÃ»¹Ê£ ' + IntToStr(g_wAvailIDHour div 60) + ' Ð¡Ê±¡£', [mbOk])
     else FrmDlg.DMessageDlg ('Äúµ±Ç°ID·ÑÓÃÒÑ²»×ã 1 Ð¡Ê±¡£', [mbOk]);
   end;


   str := DecodeString (body);
   str := GetValidStr3 (str, runaddr, ['/']);
   str := GetValidStr3 (str, runport, ['/']);
   str := GetValidStr3 (str, certifystr, ['/']);
   Certification := Str_ToInt(certifystr, 0);

   //if not BoOneClick then begin
      CSocket.Active:=False;
      CSocket.Host:='';
      CSocket.Port:=0;
      //FrmDlg.DSelServerDlg.Visible := FALSE;
      WaitAndPass (500); //ÑÓÊ±0.5Ãë
      g_ConnectionStep := cnsSelChr;
      with CSocket do begin//×ª»»¶Ë¿Ú£¬Á¬½Ó½ÇÉ«Íø¹Ø
         g_sSelChrAddr := runaddr;
         g_nSelChrPort := Str_ToInt (runport, 0);
         Address := g_sSelChrAddr;
         Port := g_nSelChrPort;
         Active := TRUE;
      end;
   {end else begin
      //FrmDlg.DSelServerDlg.Visible := FALSE;
      g_sSelChrAddr := runaddr;
      g_nSelChrPort := Str_ToInt (runport, 0);
      if CSocket.Socket.Connected then CSocket.Socket.SendText ('$S' + runaddr + '/' + runport + '%');
      WaitAndPass (500);  //ÑÓÊ±0.5Ãë
      g_ConnectionStep := cnsSelChr;
      LoginScene.OpenLoginDoor;
      SelChrWaitTimer.Enabled := TRUE;
   end;  }
end;
procedure TfrmMain.ClientGetPasswordOK(Msg:TDefaultMessage; sBody: String);
var
  I: Integer;
  sServerName:String;
  sServerStatus:String;
  nCount:Integer;
begin
  sBody:=DeCodeString(sBody);
//  FrmDlg.DMessageDlg (sBody + '/' + IntToStr(Msg.Series), [mbOk]);
  nCount:=_MIN(6,msg.Series);
  g_ServerList.Clear;
  if nCount > 0 then //20080629
  for I := 0 to nCount - 1 do begin
    sBody:=GetValidStr3(sBody,sServerName,['/']);
    sBody:=GetValidStr3(sBody,sServerStatus,['/']);
    g_ServerList.AddObject(sServerName,TObject(Str_ToInt(sServerStatus,0)));
  end;

  if not LoginScene.m_boUpdateAccountMode then ClientGetSelectServer;
end;

procedure TfrmMain.ClientGetSelectServer;
begin
  //LoginScene.HideLoginBox;
  SendHardwareCode;
  FrmDlg.ShowSelectServerDlg;
end;

procedure TfrmMain.ClientGetNeedUpdateAccount (body: string);
var
   ue: TUserEntry;
begin
   DecodeBuffer (body, @ue, sizeof(TUserEntry));
   LoginScene.UpdateAccountInfos (ue);
end;

procedure TfrmMain.ClientGetReceiveChrs (body: string);
var
   i, select: integer;
   str, uname, sjob, shair, slevel, ssex: string;
begin
   SelectChrScene.ClearChrs;
   str := DecodeString (body);
   for i:=0 to 1 do begin
      str := GetValidStr3 (str, uname, ['/']);
      str := GetValidStr3 (str, sjob, ['/']);
      str := GetValidStr3 (str, shair, ['/']);
      str := GetValidStr3 (str, slevel, ['/']);
      str := GetValidStr3 (str, ssex, ['/']);
      select := 0;
      if (uname <> '') and (slevel <> '') and (ssex <> '') then begin
         if uname[1] = '*' then begin
            select := i;
            uname := Copy (uname, 2, Length(uname)-1);
         end;
         SelectChrScene.AddChr (uname, Str_ToInt(sjob, 0), Str_ToInt(shair, 0), Str_ToInt(slevel, 0), Str_ToInt(ssex, 0));
      end;
      with SelectChrScene do begin
         if select = 0 then begin
            ChrArr[0].FreezeState := FALSE;
            ChrArr[0].Selected := TRUE;
            ChrArr[1].FreezeState := TRUE;
            ChrArr[1].Selected := FALSE;
         end else begin
            ChrArr[0].FreezeState := TRUE;
            ChrArr[0].Selected := FALSE;
            ChrArr[1].FreezeState := FALSE;
            ChrArr[1].Selected := TRUE;
         end;
      end;
   end;
   PlayScene.EdAccountt.Text:=LoginId;
   //2004/05/17  Ç¿ÐÐµÇÂ¼
   {
   if SelectChrScene.ChrArr[0].Valid and SelectChrScene.ChrArr[0].Selected then PlayScene.EdChrNamet.Text := SelectChrScene.ChrArr[0].UserChr.Name;
   if SelectChrScene.ChrArr[1].Valid and SelectChrScene.ChrArr[1].Selected then PlayScene.EdChrNamet.Text := SelectChrScene.ChrArr[1].UserChr.Name;
   PlayScene.EdAccountt.Visible:=True;
   PlayScene.EdChrNamet.Visible:=True;
   }
   //2004/05/17
end;
//Íæ¼Òµã»÷¿ªÊ¼ÓÎÏ·
procedure TfrmMain.ClientGetStartPlay (body: string);
var
   str, addr, sport: string;
begin
   str := DecodeString (body);
   sport := GetValidStr3 (str, g_sRunServerAddr, ['/']);
   g_nRunServerPort:= Str_ToInt (sport, 0);

   //if not BoOneClick then begin
      CSocket.Active := FALSE;  //·Î±×ÀÎ¿¡ ¿¬°áµÈ ¼ÒÄÏ ´ÝÀ½
      CSocket.Host:='';
      CSocket.Port:=0;
      //WaitAndPass (1); //ÔÝÍ£0.001 Ãë   20080331

      g_ConnectionStep := cnsPlay;
      if not g_boOnePlay then FrmDlg.PlayInitialize;
      
      with CSocket do begin
        Address := g_sRunServerAddr;
        Port := g_nRunServerPort;
        Active := TRUE;
      end;
   {end else begin
      SocStr := '';
      BufferStr := '';
      if CSocket.Socket.Connected then
         CSocket.Socket.SendText ('$R' + addr + '/' + sport + '%');

      g_ConnectionStep := cnsPlay;
      ClearBag;  //°¡¹æ ÃÊ±âÈ­
      DScreen.ClearChatBoard; //Ã¤ÆÃÃ¢ ÃÊ±âÈ­
      DScreen.ChangeScene (stLoginNotice);
      SendRunLogin;
   end;  }
end;

procedure TfrmMain.ClientGetReconnect (body: string);
var
   str, addr, sport: string;
begin
   str := DecodeString (body);
   sport := GetValidStr3 (str, addr, ['/']);

   //if not BoOneClick then begin
      if g_boBagLoaded then
         Savebags ('.\Config\' + '56' + g_sServerName + '.' + CharName + '.itm', @g_ItemArr);
      g_boBagLoaded := FALSE;

      g_boServerChanging := TRUE;
      CSocket.Active := FALSE;  //·Î±×ÀÎ¿¡ ¿¬°áµÈ ¼ÒÄÏ ´ÝÀ½
      CSocket.Host:='';
      CSocket.Port:=0;

      WaitAndPass (1); //0.5ÃÊµ¿¾È ±â´Ù¸²

      g_ConnectionStep := cnsPlay;
      with CSocket do begin
         Address := addr;
         Port := Str_ToInt (sport, 0);
         Active := TRUE;
      end;

   {end else begin
      if g_boBagLoaded then
         Savebags ('.\Config\' + '56' + g_sServerName + '.' + CharName + '.itm', @g_ItemArr);
      g_boBagLoaded := FALSE;

      SocStr := '';
      BufferStr := '';
      g_boServerChanging := TRUE;

      if CSocket.Socket.Connected then   //Á¢¼Ó Á¾·á ½ÅÈ£ º¸³½´Ù.
         CSocket.Socket.SendText ('$C' + addr + '/' + sport + '%');

      WaitAndPass (1); //0.5ÃÊµ¿¾È ±â´Ù¸²
      if CSocket.Socket.Connected then   //ÀçÁ¢..
         CSocket.Socket.SendText ('$R' + addr + '/' + sport + '%');

      g_ConnectionStep := cnsPlay;
      ClearBag;  //°¡¹æ ÃÊ±âÈ­
      DScreen.ClearChatBoard; //Ã¤ÆÃÃ¢ ÃÊ±âÈ­
      DScreen.ChangeScene (stLoginNotice);

      WaitAndPass (1); //0.5ÃÊµ¿¾È ±â´Ù¸²
      ChangeServerClearGameVariables;

      SendRunLogin;
   end;    }
end;
//È¡µØÍ¼ÒôÀÖ±³¾°
procedure TfrmMain.ClientGetMapDescription(Msg:TDefaultMessage;sBody:String);
var
  sTitle:String;
begin
  sBody:=DecodeString(sBody);
  //sBody:=GetValidStr3(sBody, sTitle, [#13]);//Ô­À´µÄ´úÂë
  g_sMapMusic:=GetValidStr3(sBody, sTitle, [#13]);//×Ô¼º¼ÓµÄ±äÁ¿,±£´æÎÄ¼þÂ·¾¶  20080402
  g_sMapTitle:=sTitle;
  g_nMapMusic:=Msg.Recog;
  PlayMapMusic(True);
end;


procedure TfrmMain.ClientGetGameGoldName(Msg:TDefaultMessage;sBody: String);
{var
  sPointDate: string;   }
begin
  if sBody <> '' then begin
    sBody:=DecodeString(sBody);
    sBody:=GetValidStr3(sBody, g_sGameGoldName, [#13]);
    sBody:=GetValidStr3(sBody, g_sGamePointName, [#13]);
    sBody:=GetValidStr3(sBody, g_sGameDiaMond, [#13]);
    sBody:=GetValidStr3(sBody, g_sGameGird, [#13]);
    {$IF M2Version <> 2}
    sBody:=GetValidStr3(sBody, g_sGameNGStrong, [#13]);
    {$IFEND}
  end;
  g_MySelf.m_nGameGold:=Msg.Recog;
  g_MySelf.m_nGamePoint:=Msg.nSessionID;
  if MakeLong(Msg.Param, Msg.Tag) = 0 then begin
    g_dGamePointDate := 32590;
  end else begin
    //sPointDate := IntToStr(MakeLong(Msg.Param, Msg.Tag));
    g_dGamePointDate := MakeLong(Msg.Param, Msg.Tag);//Str_ToDate(sPointDate);
  end;
end;

procedure TfrmMain.ClientGetAdjustBonus (bonus: integer; body: string);
var
   str1, str2, str3: string;
begin
   g_nBonusPoint := bonus;
   body := GetValidStr3 (body, str1, ['/']);
   str3 := GetValidStr3 (body, str2, ['/']);
   DecodeBuffer (str1, @g_BonusTick, sizeof(TNakedAbility));
   DecodeBuffer (str2, @g_BonusAbil, sizeof(TNakedAbility));
   DecodeBuffer (str3, @g_NakedAbil, sizeof(TNakedAbility));
   FillChar (g_BonusAbilChg, sizeof(TNakedAbility), #0);
end;

procedure TfrmMain.ClientGetAddItem (body: string);
var
   cu: TClientItem;
begin
   if body <> '' then begin
      DecodeBuffer (body, @cu, sizeof(cu));
      AddItemBag (cu);
      DScreen.AddSysMsg (cu.S.Name + ' ±»·¢ÏÖ.');
   end;
end;

procedure TfrmMain.ClientGetHeroAddItem (body: string);
var
   cu: TClientItem;
begin
   if body <> '' then begin
      DecodeBuffer (body, @cu, sizeof(TClientItem));
      AddHeroItemBag (cu);
      DScreen.AddSysMsg ('Ó¢ÐÛ '+cu.S.Name + ' ±»·¢ÏÖ.');
   end;
end;

procedure TfrmMain.ClientGetHeroUpdateItem (body: string);
var
   i: integer;
   cu: TClientItem;
begin
   if body <> '' then begin
      DecodeBuffer (body, @cu, sizeof(TClientItem));
      if HeroUpdateItemBag (cu) then Exit; //20100824ÐÞ¸Ä
      for i:=0 to 14 do begin
         if (g_HeroItems[i].S.Name = cu.S.Name) and (g_HeroItems[i].MakeIndex = cu.MakeIndex) then begin
            g_HeroItems[i] := cu;
            Break;  //20100824ÐÞ¸Ä
         end;
      end;
   end;
end;

procedure TfrmMain.ClientGetHeroDelItems (body: string);
var
   i, iindex: integer;
   str, iname: string;
begin
   body := DecodeString (body);
   while body <> '' do begin
      body := GetValidStr3 (body, iname, ['/']);
      body := GetValidStr3 (body, str, ['/']);
      if (iname <> '') and (str <> '') then begin
         iindex := Str_ToInt(str, 0);
         DelHeroItemBag (iname, iindex);
         for i:=0 to 14 do begin
            if (g_HeroItems[i].S.Name = iname) and (g_HeroItems[i].MakeIndex = iindex) then begin
               g_HeroItems[i].S.Name := '';
            end;
         end;
      end else
         break;
   end;
end;

procedure TfrmMain.ClientGetHeroDelItem (body: string);
var
   i: integer;
   cu: TClientItem;
begin
   if body <> '' then begin
      DecodeBuffer (body, @cu, sizeof(TClientItem));
      DelHeroItemBag (cu.S.Name, cu.MakeIndex);
      for i:=0 to 14 do begin
         if (g_HeroItems[i].S.Name = cu.S.Name) and (g_HeroItems[i].MakeIndex = cu.MakeIndex) then begin
            g_HeroItems[i].S.Name := '';
         end;
      end;
   end;
end;
//½ÓÊÕÅÅÐÐ°ñ
procedure TfrmMain.ClientGetUserOrder (body: string);
  function GetSortList: TList;
  begin
    Result := nil;
    case nLevelOrderSortType of
      0: begin
          case nLevelOrderType of
            1: Result := m_PlayObjectLevelList;
            2: Result := m_WarrorObjectLevelList;
            3: Result := m_WizardObjectLevelList;
            4: Result := m_TaoistObjectLevelList;
          end;
        end;
      1: begin
          case nLevelOrderType of
            1: Result := m_HeroObjectLevelList;
            2: Result := m_WarrorHeroObjectLevelList;
            3: Result := m_WizardHeroObjectLevelList;
            4: Result := m_TaoistHeroObjectLevelList;
          end;
        end;
      2: begin
          Result := m_PlayObjectMasterList;
        end;
      {$IF M2Version <> 2}
      3: Result := g_UserItemLevelList;
      {$IFEND}
    end;
  end;
var
   i: integer;
   data: string;
   UserLevelSort: pTUserLevelSort;
   HeroLevelSort: pTHeroLevelSort;
   UserMasterSort: pTUserLevelSort;
   {$IF M2version <> 2}
   ItemLevelSort: pTItemLevelSort;
   {$IFEND}
   List: TList;
begin
   List := GetSortList;
   if List.Count > 0 then begin//20080629
     case nLevelOrderSortType of
       0: for i:=0 to List.Count-1 do Dispose (pTUserLevelSort(List[i]));
       1: for i:=0 to List.Count-1 do Dispose (pTHeroLevelSort(List[i]));
       2: for i:=0 to List.Count-1 do Dispose (pTUserLevelSort(List[i]));
       {$IF M2Version <> 2}3: for i:=0 to List.Count-1 do Dispose (pTItemLevelSort(List[i]));{$IFEND}
     end;
   end;
   List.Clear;
   while TRUE do begin
      if body = '' then break;
      body := GetValidStr3 (body, data, ['/']);
      if data <> '' then begin
         case nLevelOrderSortType of
           0: begin
             new (UserLevelSort);
             DecodeBuffer (data, @(UserLevelSort^), sizeof(TUserLevelSort));
             List.Add (UserLevelSort);
           end;
           1: begin
             new (HeroLevelSort);
             DecodeBuffer (data, @(HeroLevelSort^), sizeof(THeroLevelSort));
             List.Add (HeroLevelSort);
           end;
           2: begin
             new (UserMasterSort);
             DecodeBuffer (data, @(UserMasterSort^), sizeof(TUserLevelSort));
             List.Add (UserMasterSort);
           end;
           {$IF M2Version <> 2}
           3: begin
             New (ItemLevelSort);
             DecodeBuffer(data, @(ItemLevelSort^), SizeOf(TItemLevelSort));
             List.Add(ItemLevelSort);
           end;
           {$IFEND}
         end;
      end else break;
   end;
end;
procedure TfrmMain.ClientGetUpdateItem (body: string);
var
   i: integer;
   cu: TClientItem;
begin
   if body <> '' then begin
      DecodeBuffer (body, @cu, sizeof(TClientItem));
      if UpdateItemBag (cu) then Exit;
      for i:= 0 to U_TakeItemCount-1 do begin//ÐÞ¸´¾ü¹ÄÖ§³ÖBy TasNat at: 2012-11-09 15:12:43
         if (g_UseItems[i].S.Name = cu.S.Name) and (g_UseItems[i].MakeIndex = cu.MakeIndex) then begin
            g_UseItems[i] := cu;
            Exit;  //20100824¼Ó
         end;
      end;
      {$IF M2Version <> 2}
      if FrmDlg.DWSignedItems.Visible then begin
        for I:=Low(g_SignedItem) to High(g_SignedItem) do begin
          if (g_SignedItem[I].S.Name = cu.S.Name) and (g_SignedItem[I].MakeIndex = cu.MakeIndex) then begin
            g_SignedItem[I] := cu;
            Exit;
          end;
        end;
      end;
      if FrmDlg.DWMakeSigned.Visible then begin
        for I:=Low(g_MakeSignedBelt) to High(g_MakeSignedBelt) do begin
          if (g_MakeSignedBelt[I].S.Name = cu.S.Name) and (g_MakeSignedBelt[I].MakeIndex = cu.MakeIndex) then begin
            g_MakeSignedBelt[I] := cu;
            Exit;
          end;
        end;
      end;
      {$IFEND}
   end;
end;

procedure TfrmMain.ClientGetDelItem (body: string);
var
   i: integer;
   cu: TClientItem;
begin
   if body <> '' then begin
      DecodeBuffer (body, @cu, sizeof(TClientItem));
      DelItemBag (cu.S.Name, cu.MakeIndex);
      for i:= 0 to U_TakeItemCount-1 do begin//ÐÞ¸´¾ü¹ÄÖ§³ÖBy TasNat at: 2012-11-09 15:12:43
         if (g_UseItems[i].S.Name = cu.S.Name) and (g_UseItems[i].MakeIndex = cu.MakeIndex) then begin
            g_UseItems[i].S.Name := '';
         end;
      end;
   end;
end;

procedure TfrmMain.ClientGetDelItems (body: string);
var
   i, iindex: integer;
   str, iname: string;
begin
   body := DecodeString (body);
   while body <> '' do begin
      body := GetValidStr3 (body, iname, ['/']);
      body := GetValidStr3 (body, str, ['/']);
      if (iname <> '') and (str <> '') then begin
         iindex := Str_ToInt(str, 0);
         DelItemBag (iname, iindex);
         for i:= 0 to U_TakeItemCount-1 do begin//ÐÞ¸´¾ü¹ÄÖ§³ÖBy TasNat at: 2012-11-09 15:12:43
            if (g_UseItems[i].S.Name = iname) and (g_UseItems[i].MakeIndex = iindex) then begin
               g_UseItems[i].S.Name := '';
            end;
         end;
      end else
         break;
   end;
end;

procedure TfrmMain.ClientGetBagItmes (body: string);
var
   str: string;
   cu: TClientItem;
   ItemSaveArr: array[0..MAXBAGITEMCL-1] of TItemArr;
   I: Integer;

   function CompareItemArr: Boolean;
   var
      i, j: integer;
      flag: Boolean;
   begin
      flag := TRUE;
      for i:=0 to MAXBAGITEMCL-1 do begin
         if ItemSaveArr[i].Item.S.Name <> '' then begin
            flag := FALSE;
            for j:=0 to MAXBAGITEMCL-1 do begin
               if (g_ItemArr[j].Item.S.Name = ItemSaveArr[i].Item.S.Name) and
                  (g_ItemArr[j].Item.MakeIndex = ItemSaveArr[i].Item.MakeIndex) then begin
                  if (g_ItemArr[j].Item.Dura = ItemSaveArr[i].Item.Dura) and
                     (g_ItemArr[j].Item.DuraMax = ItemSaveArr[i].Item.DuraMax) then begin
                     flag := TRUE;
                  end;
                  break;
               end;
            end;
            if not flag then break;
         end;
      end;
      if flag then begin
         for i:=0 to MAXBAGITEMCL-1 do begin
            if g_ItemArr[i].Item.S.Name <> '' then begin
               flag := FALSE;
               for j:=0 to MAXBAGITEMCL-1 do begin
                  if (g_ItemArr[i].Item.S.Name = ItemSaveArr[j].Item.S.Name) and
                     (g_ItemArr[i].Item.MakeIndex = ItemSaveArr[j].Item.MakeIndex) then begin
                     if (g_ItemArr[i].Item.Dura = ItemSaveArr[j].Item.Dura) and
                        (g_ItemArr[i].Item.DuraMax = ItemSaveArr[j].Item.DuraMax) then begin
                        flag := TRUE;
                     end;
                     break;
                  end;
               end;
               if not flag then break;
            end;
         end;
      end;
      Result := flag;
   end;
begin
   //ClearBag;
   FillChar (g_ItemArr, sizeof(TItemArr)*MAXBAGITEMCL, #0);
   while TRUE do begin
      if body = '' then break;
      body := GetValidStr3 (body, str, ['/']);
      DecodeBuffer (str, @cu, sizeof(TClientItem));
      AddItemBag (cu);
   end;

   FillChar (ItemSaveArr, sizeof(TItemArr)*MAXBAGITEMCL, #0);
   try
     Loadbags ('.\Config\' + '56' + g_sServerName + '.' + CharName + '.itm', @ItemSaveArr);
   except
     DebugOutStr('Loadbags');
   end;
   if CompareItemArr then begin
      Move (ItemSaveArr, g_ItemArr, sizeof(TItemArr) * MAXBAGITEMCL);
      for I:=0 to MAXBAGITEMCL-1 do begin
        if g_ItemArr[I].Item.s.Name <> '' then begin
          g_ItemArr[I].boLockItem := False;
        end;
      end;
   end;

   ArrangeItembag;
   g_boBagLoaded := TRUE;
end;

procedure TfrmMain.ClientGetDropItemFail (iname: string; sindex: integer);
var
   pc: pTClientItem;
begin
   pc := GetDropItem (iname, sindex);
   if pc <> nil then begin
      AddItemBag (pc^);
      DelDropItem (iname, sindex);
   end;
end;

procedure TfrmMain.ClientGetHeroDropItemFail (iname: string; sindex: integer);
var
   pc: pTClientItem;
begin
   pc := GetDropItem (iname, sindex);
   if pc <> nil then begin
      AddHeroItemBag (pc^);
      DelDropItem (iname, sindex);
   end;
end;
procedure TfrmMain.ClientGetShowItem (itemid, x, y, looks: integer; itmname: string);
var
  I:Integer;
  DropItem:PTDropItem;
begin
  if g_DropedItemList.Count > 0 then begin//20080629
    for i:=0 to g_DropedItemList.Count-1 do begin
      if PTDropItem(g_DropedItemList[i]).Id = itemid then
        Exit;
    end;
  end;
  New(DropItem);
  DropItem.Id := itemid;
  DropItem.X := x;
  DropItem.Y := y;
  DropItem.Looks := looks;
  DropItem.Name := itmname;
  DropItem.FlashTime := GetTickCount - LongWord(Random(3000));
  DropItem.BoFlash := FALSE;
  g_DropedItemList.Add(DropItem);
end;

procedure TfrmMain.ClientGetHideItem (itemid, x, y: integer);
var
  I:Integer;
  DropItem:PTDropItem;
begin
  if g_DropedItemList.Count > 0 then //20080629
  for I:=0 to g_DropedItemList.Count - 1 do begin
    DropItem:=g_DropedItemList[I];
    if DropItem.Id = itemid then begin
      Dispose (DropItem);
      g_DropedItemList.Delete(I);
      break;
    end;
  end;
end;
procedure TfrmMain.ClientGetSenduseItems (body: string);
var
   index: integer;
   str, data: string;
   cu: TClientItem;
begin
   FillChar (g_UseItems, sizeof(TClientItem)*U_TakeItemCount, #0);
//   FillChar (UseItems, sizeof(TClientEffecItem)*9, #0);
   while TRUE do begin
      if body = '' then break;
      body := GetValidStr3 (body, str, ['/']);
      body := GetValidStr3 (body, data, ['/']);
      index := Str_ToInt (str, -1);
      if index in [0..14] then begin
         DecodeBuffer (data, @cu, sizeof(TClientItem));
         g_UseItems[index] := cu;
      end;
   end;
end;

procedure TfrmMain.ClientHeroGetBagItmes(body: string);
var
   str: string;
   cu: TClientItem;
   ItemSaveArr: array[0..MAXBAGITEMCL-1] of TClientItem;

   function CompareItemArr: Boolean;
   var
      i, j: integer;
      flag: Boolean;
   begin
      flag := TRUE;
      for i:=0 to MAXBAGITEMCL-1 do begin
         if ItemSaveArr[i].S.Name <> '' then begin
            flag := FALSE;
            for j:=0 to MAXBAGITEMCL-1 do begin
               if (g_HeroItemArr[j].S.Name = ItemSaveArr[i].S.Name) and
                  (g_HeroItemArr[j].MakeIndex = ItemSaveArr[i].MakeIndex) then begin
                  if (g_HeroItemArr[j].Dura = ItemSaveArr[i].Dura) and
                     (g_HeroItemArr[j].DuraMax = ItemSaveArr[i].DuraMax) then begin
                     flag := TRUE;
                  end;
                  break;
               end;
            end;
            if not flag then break;
         end;
      end;
      if flag then begin
         for i:=0 to MAXBAGITEMCL-1 do begin
            if g_HeroItemArr[i].S.Name <> '' then begin
               flag := FALSE;
               for j:=0 to MAXBAGITEMCL-1 do begin
                  if (g_HeroItemArr[i].S.Name = ItemSaveArr[j].S.Name) and
                     (g_HeroItemArr[i].MakeIndex = ItemSaveArr[j].MakeIndex) then begin
                     if (g_HeroItemArr[i].Dura = ItemSaveArr[j].Dura) and
                        (g_HeroItemArr[i].DuraMax = ItemSaveArr[j].DuraMax) then begin
                        flag := TRUE;
                     end;
                     break;
                  end;
               end;
               if not flag then break;
            end;
         end;
      end;
      Result := flag;
   end;
begin
   //ClearBag;
   FillChar (g_HeroItemArr, sizeof(TClientItem)*MAXBAGITEMCL, #0);
   while TRUE do begin
      if body = '' then break;
      body := GetValidStr3 (body, str, ['/']);
      DecodeBuffer (str, @cu, sizeof(TClientItem));
      AddHeroItemBag (cu);
   end;

   FillChar (ItemSaveArr, sizeof(TClientItem)*MAXBAGITEMCL, #0);
   if CompareItemArr then begin
      Move (ItemSaveArr, g_HeroItemArr, sizeof(TClientItem) * MAXBAGITEMCL);
   end;

   ArrangeHeroItembag;
   g_boHeroBagLoaded := TRUE;
end;
//´Ó·þÎñ¶Ë»ñÈ¡Ó¢ÐÛÉíÉÏÎïÆ·
procedure TfrmMain.ClientGetSendHeroItems (body: string);   //$003
var
   index: integer;
   str, data: string;
   cu: TClientItem;
begin
   FillChar (g_HeroItems, sizeof(TClientItem)*U_TakeItemCount, #0);
   while TRUE do begin
      if body = '' then break;
      body := GetValidStr3 (body, str, ['/']);
      body := GetValidStr3 (body, data, ['/']);
      index := Str_ToInt (str, -1);
      if index in [0..14] then begin
         DecodeBuffer (data, @cu, sizeof(TClientItem));
         g_HeroItems[index] := cu;
      end;
   end;
end;

procedure TfrmMain.ClientGetHeroMagics (body: string);
var
   i: integer;
   data: string;
   pcm: PTClientMagic;
begin
  if g_HeroMagicList.Count > 0 then begin//20080629
    for i:=0 to g_HeroMagicList.Count-1 do
      Dispose (PTClientMagic (g_HeroMagicList[i]));
    g_HeroMagicList.Clear;
  end;
  if g_HeroInternalForceMagicList.Count > 0 then begin
   for I:=0 to g_HeroInternalForceMagicList.Count-1 do
      Dispose (PTClientMagic (g_HeroInternalForceMagicList[i]));
   g_HeroInternalForceMagicList.Clear;
  end;
   if g_HeroBatterMagicList.Count > 0 then begin
     for i:=0 to g_HeroBatterMagicList.Count-1 do
       if PTClientMagic (g_HeroBatterMagicList[i]) <> nil then Dispose (PTClientMagic (g_HeroBatterMagicList[i]));
     g_HeroBatterMagicList.Clear;
   end;
   while TRUE do begin
      if body = '' then break;
      body := GetValidStr3 (body, data, ['/']);
      if data <> '' then begin
         new (pcm);
         DecodeBuffer (data, @(pcm^), sizeof(TClientMagic));
         if (pcm.Def.sDescr = 'ÄÚ¹¦') and (pcm.Def.wMagicId <> 102) then
           g_HeroInternalForceMagicList.Add (pcm)
         {$IF M2Version = 1}
         else if pcm.Def.sDescr = 'Á¬»÷' then
           g_HeroBatterMagicList.Add (pcm)
         {$IFEND}
         else
           g_HeroMagicList.Add (pcm);
      end else
         break;
   end;
   {$IF M2Version = 1}
   if g_HeroBatterMagicList.Count > 2 then begin
     FrmDlg.DHeroBatterRandom.Visible := True;
     FrmDlg.DBNewHeroBatterRandom.Visible := True;
   end;
   if g_HeroBatterMagicList.Count > 0 then begin
     for I:=0 to g_HeroBatterMagicList.Count -1 do begin
       if Ord(PTClientMagic (g_HeroBatterMagicList[i]).Key) = 1 then g_HeroBatterTopMagic[0] := PTClientMagic (g_HeroBatterMagicList[i])^;
       if Ord(PTClientMagic (g_HeroBatterMagicList[i]).Key) = 2 then g_HeroBatterTopMagic[1] := PTClientMagic (g_HeroBatterMagicList[i])^;
       if Ord(PTClientMagic (g_HeroBatterMagicList[i]).Key) = 3 then g_HeroBatterTopMagic[2] := PTClientMagic (g_HeroBatterMagicList[i])^;
       if Ord(PTClientMagic (g_HeroBatterMagicList[i]).Key) = 4 then g_HeroBatterTopMagic[3] := PTClientMagic (g_HeroBatterMagicList[i])^;
     end;
   end;
   {$IFEND}
end;

procedure TfrmMain.ClientGetHeroAddMagic (body: string);
var
   pcm: PTClientMagic;
begin
   new (pcm);
   DecodeBuffer (body, @(pcm^), sizeof(TClientMagic));
   if (pcm.Def.sDescr = 'ÄÚ¹¦') and (pcm.Def.wMagicId <> 102) then begin
     g_HeroInternalForceMagicList.Add (pcm);
     {$IF M2Version <> 2}
     if g_boNewNewHeroState then begin
       if FrmDlg.DWNewStateHero.Visible and (FrmDlg.DPNewStateHeroTab.ActivePage = 1) and (FrmDlg.DPNewStateHeroNGPage.ActivePage = 1) then
         FrmDlg.NewNGUpLevelState(True);
     end else begin
       if FrmDlg.DStateHero.Visible and (FrmDlg.HeroStateTab = 1) and (FrmDlg.HeroInternalForcePage = 1) then
         FrmDlg.NGUpLevelState(True);
     end;
     {$IFEND}
   {$IF M2Version = 1}
   end else if pcm.Def.sDescr = 'Á¬»÷' then begin
     g_HeroBatterMagicList.Add (pcm);
   {$IFEND}
   end else g_HeroMagicList.Add (pcm);
   {$IF M2Version = 1}
   if g_HeroBatterMagicList.Count > 2 then begin
     if g_boNewNewHeroState then
       FrmDlg.DBNewHeroBatterRandom.Visible := True
     else FrmDlg.DHeroBatterRandom.Visible := True;
   end;
   {$IFEND}
end;

procedure TfrmMain.ClientGetHeroDelMagic (magid: integer);
var
   i: integer;
begin
   if g_HeroMagicList.Count > 0 then //20080629
   for i:=g_HeroMagicList.Count-1 downto 0 do begin
      if PTClientMagic(g_HeroMagicList[i]).Def.wMagicId = magid then begin
         Dispose (PTClientMagic(g_HeroMagicList[i]));
         g_HeroMagicList.Delete (i);
         Exit;
      end;
   end;

   if g_HeroInternalForceMagicList.Count > 0 then begin //ÄÚ¹¦
     for i:=g_HeroInternalForceMagicList.Count-1 downto 0 do begin
        if PTClientMagic(g_HeroInternalForceMagicList[i]).Def.wMagicId = magid then begin
           Dispose (PTClientMagic(g_HeroInternalForceMagicList[i]));
           g_HeroInternalForceMagicList.Delete (i);
           break;
        end;
     end;
     {$IF M2Version <> 2}
     if g_boNewNewHeroState then begin
       if FrmDlg.DWNewStateWin.Visible and (FrmDlg.DPNewStateHeroTab.ActivePage = 1) and (FrmDlg.DPNewStateHeroNGPage.ActivePage = 1) then
         FrmDlg.NewNGUpLevelState(True);
     end else begin
       if FrmDlg.DStateHero.Visible and (FrmDlg.HeroStateTab = 1) and (FrmDlg.HeroInternalForcePage = 1) then
         FrmDlg.NGUpLevelState(True);
     end;
     {$IFEND}
   end;
   {$IF M2Version = 1}
   if g_HeroBatterMagicList.Count > 0 then begin   //Á¬»÷
     for i:=g_HeroBatterMagicList.Count-1 downto 0 do begin
       if PTClientMagic(g_HeroBatterMagicList[I]).Def.wMagicId = magid then begin
         Dispose (PTClientMagic(g_HeroBatterMagicList[i]));
         g_HeroBatterMagicList.Delete (i);
         if g_HeroBatterMagicList.Count < 3 then begin
           FrmDlg.DHeroBatterRandom.Visible := False;
           FrmDlg.DBNewHeroBatterRandom.Visible := False;
         end;
         Exit;
       end;
     end;
   end;
   {$IFEND}
end;
procedure TfrmMain.ClientGetHeroMagicLvExp (magid, maglv, magtrain, magExp: integer);
var
   i: integer;
begin
   if g_HeroMagicList.Count > 0 then //20080629
   for i:=g_HeroMagicList.Count-1 downto 0 do begin
      if PTClientMagic(g_HeroMagicList[i]).Def.wMagicId = magid then begin
         PTClientMagic(g_HeroMagicList[i]).Level := maglv;
         PTClientMagic(g_HeroMagicList[i]).CurTrain := magtrain;
         if magid in [68, 71, 95, 99, 104]then PTClientMagic(g_HeroMagicList[i]).Def.MaxTrain[0]:= magExp;
         {$IF M2Version <> 2}
         if (magid = 99) then begin
           if (maglv < 99) then begin
             FrmDlg.HeroSkillMemoAddHp := GetHeroSkillMemoAddHp(maglv);
           end else FrmDlg.HeroSkillMemoAddHp := 0;
         end;
         {$IFEND}
         Exit;
      end;
   end;
   if g_HeroInternalForceMagicList.Count > 0 then
   for I:=g_HeroInternalForceMagicList.Count-1 downto 0 do begin
      if PTClientMagic(g_HeroInternalForceMagicList[i]).Def.wMagicId = magid then begin
         PTClientMagic(g_HeroInternalForceMagicList[i]).Level := maglv;
         PTClientMagic(g_HeroInternalForceMagicList[i]).CurTrain := magtrain;
         if (magid = 68) or (magid = 71) then PTClientMagic(g_HeroInternalForceMagicList[i]).Def.MaxTrain[0]:= magExp;
         Exit;
      end;
   end;
   if g_HeroBatterMagicList.Count > 0 then //20080629
   for i:=g_HeroBatterMagicList.Count-1 downto 0 do begin
      if PTClientMagic(g_HeroBatterMagicList[i]).Def.wMagicId = magid then begin
         PTClientMagic(g_HeroBatterMagicList[i]).Level := maglv;
         PTClientMagic(g_HeroBatterMagicList[i]).CurTrain := magtrain;
         Exit;
      end;
   end;
end;

procedure TfrmMain.ClientGetHeroDuraChange (uidx, newdura, newduramax: integer);
begin
   if uidx in [0..14] then begin
      if g_HeroItems[uidx].S.Name <> '' then begin
         g_HeroItems[uidx].Dura := newdura;
         g_HeroItems[uidx].DuraMax := newduramax;
      end;
   end;
end;

//¾ÛÁéÖéÊ±¼ä¸Ä±ä 20080307
procedure TfrmMain.ClientGetExpTimeItemChange(uidx, NewTime: integer);
var
  I:  Integer;
  IsYes: Boolean; //ÈËÎï°ü¹üÀïÊÇ·ñÓÐ 20080427
begin
  IsYes := False;
  for i:=5 to MAXBAGITEMCL - 1 do begin
     if (g_ItemArr[i].Item.MakeIndex = uidx) then  begin
       if g_ItemArr[i].Item.S.Name <> '' then begin
          g_ItemArr[i].Item.s.Need := NewTime;
          IsYes := True;
       end;
     end;
  end;
  if IsYes then Exit;
  if g_HeroBagCount > 0 then //20080629
  for I:=0 to g_HeroBagCount - 1 do begin
    if (g_HeroItemArr[i].MakeIndex = uidx) then  begin
       if g_HeroItemArr[i].S.Name <> '' then
          g_HeroItemArr[i].s.Need := NewTime;
    end;
  end;
end;

procedure TfrmMain.ClientGetAddMagic (body: string);
var
   pcm: PTClientMagic;
begin
   new (pcm);
   DecodeBuffer (body, @(pcm^), sizeof(TClientMagic));
   if pcm.Def.wMagicId = 89 then g_boCanLongHit4 := True;//4¼¶´ÌÉ±½£Êõ
   if pcm.Def.wMagicId = 90 then begin
     g_boCanWideHit4 := True; //Ô²ÔÂÍäµ¶
     FrmDlg.DCheckSdoAutoWideHit.Checked := False;
     g_boAutoWideHit := False;
   end;
   if (pcm.Def.sDescr = 'ÄÚ¹¦') and (pcm.Def.wMagicId <> 102) then begin
     g_InternalForceMagicList.Add (pcm);
     {$IF M2Version <> 2}
     if g_boNewNewStateWin then begin
       if FrmDlg.DWNewStateWin.Visible and (FrmDlg.DPNewStateWinTab.ActivePage = 1) and (FrmDlg.DPNewStateWinNGPage.ActivePage = 1) then
         FrmDlg.NewNGUpLevelState(False);
     end else begin
       if FrmDlg.DStateWin.Visible and (FrmDlg.StateTab = 1) and (FrmDlg.InternalForcePage = 1) then
         FrmDlg.NGUpLevelState(False);
     end;
     {$IFEND}
   {$IF M2Version = 1}
   end else if pcm.Def.sDescr = 'Á¬»÷' then begin
     g_WinBatterMagicList.Add (pcm);
   {$IFEND}
   {$IF M2Version <> 2}
   end else if pcm.Def.sDescr = 'Éñ¼¼' then begin
     if pcm.Def.wMagicId = 105 then begin
       g_boXinFaType := True;
       g_boShowXinFaAbsorb := True;
       FrmDlg.SetNewWinStateTabVisible(True, True);
     end else if pcm.Def.wMagicId = 106 then begin
       g_boXinFaType := False;
       FrmDlg.SetNewWinStateTabVisible(True, True);
     end;
     g_XinFaMagic.Add (pcm);
   {$IFEND}
   end else g_MagicList.Add (pcm);
   {$IF M2Version = 1}
   if g_WinBatterMagicList.Count > 2 then begin
     if g_boNewNewStateWin then 
       FrmDlg.DBNewWinBatterRandom.Visible := True
     else FrmDlg.DWinBatterRandom.Visible := True;
   end;
   {$IFEND}
end;

procedure TfrmMain.ClientGetDelMagic (magid: integer);
var
   i: integer;
begin
   if g_MagicList.Count > 0 then //20080629
   for i:=g_MagicList.Count-1 downto 0 do begin
      if PTClientMagic(g_MagicList[i]).Def.wMagicId = magid then begin
         if magid = 89 then g_boCanLongHit4 := False;//4¼¶´ÌÉ±½£Êõ
         if magid = 90 then g_boCanWideHit4 := False; //Ô²ÔÂÍäµ¶
         Dispose (PTClientMagic(g_MagicList[i]));
         g_MagicList.Delete (i);
         Exit;
      end;
   end;

   if g_InternalForceMagicList.Count > 0 then begin   //ÄÚ¹¦
     for i:=g_InternalForceMagicList.Count-1 downto 0 do begin
       if PTClientMagic(g_InternalForceMagicList[I]).Def.wMagicId = magid then begin
         Dispose (PTClientMagic(g_InternalForceMagicList[i]));
         g_InternalForceMagicList.Delete (i);
         {$IF M2Version <> 2}
         if g_boNewNewStateWin then begin
           if FrmDlg.DWNewStateWin.Visible and (FrmDlg.DPNewStateWinTab.ActivePage = 1) and (FrmDlg.DPNewStateWinNGPage.ActivePage = 1) then
             FrmDlg.NewNGUpLevelState(False);
         end else begin
           if FrmDlg.DStateWin.Visible and (FrmDlg.StateTab = 1) and (FrmDlg.InternalForcePage = 1) then
             FrmDlg.NGUpLevelState(False);
         end;
         {$IFEND}
         Exit;
       end;
     end;
   end;

   {$IF M2Version = 1}
   if g_WinBatterMagicList.Count > 0 then begin   //Á¬»÷
     for i:=g_WinBatterMagicList.Count-1 downto 0 do begin
       if PTClientMagic(g_WinBatterMagicList[I]).Def.wMagicId = magid then begin
         Dispose (PTClientMagic(g_WinBatterMagicList[i]));
         g_WinBatterMagicList.Delete (i);
         if g_WinBatterMagicList.Count < 3 then begin
           FrmDlg.DWinBatterRandom.Visible := False;
           FrmDlg.DBNewWinBatterRandom.Visible := False;
         end;
         Exit;
       end;
     end;
   end;
   {$IFEND}
   {$IF M2Version <> 2}
   if g_XinFaMagic.Count > 0 then begin   //Éñ¼¼
     for i:=g_XinFaMagic.Count-1 downto 0 do begin
       if PTClientMagic(g_XinFaMagic[I]).Def.wMagicId = magid then begin
         Dispose (PTClientMagic(g_XinFaMagic[i]));
         g_XinFaMagic.Delete (i);
         Break;
       end;
     end;
     FrmDlg.SetNewWinStateTabVisible(False, True);
     for I:=g_XinFaMagic.Count-1 downto 0 do begin
       if PTClientMagic(g_XinFaMagic[I]).Def.wMagicId = 105 then begin
         g_boXinFaType := True;
         FrmDlg.SetNewWinStateTabVisible(True, True);
         Exit;
       end else if PTClientMagic(g_XinFaMagic[I]).Def.wMagicId = 106 then begin
         g_boXinFaType := False;
         FrmDlg.SetNewWinStateTabVisible(True, True);
         Exit;
       end;
     end;
     if not FrmDlg.DBNewStateTab3.Visible then FrmDlg.DPNewStateWinTab.ActivePage := 0;
   end;
   {$IFEND}
end;

procedure TfrmMain.ClientGetMyShopSpecially (body: string); //ÉÌÆÌÆæÕä  2007.11.14
var
   i: integer;
   data: string;
   pcm: pTShopInfo;
begin
   if g_ShopSpeciallyItemList.Count > 0 then //20080629
   for i:=0 to g_ShopSpeciallyItemList.Count-1 do
      Dispose (pTShopInfo(g_ShopSpeciallyItemList[i]));
   g_ShopSpeciallyItemList.Clear;
   while TRUE do begin
      if body = '' then break;
      body := GetValidStr3 (body, data, ['/']);
      if data <> '' then begin
         new (pcm);
         DecodeBuffer (data, @(pcm^), sizeof(TShopInfo));
         g_ShopSpeciallyItemList.Add (pcm);
      end else
         break;
   end;
end;
//ÉÌÆÌ  2007.11.14
procedure TfrmMain.ClientGetMyShop (body: string);
var
   i: integer;
   data: string;
   pcm: pTShopInfo;
begin
   if g_ShopItemList.Count > 0 then //20080629
   for i:=0 to g_ShopItemList.Count-1 do
      if pTShopInfo(g_ShopItemList[i]) <> nil then
       Dispose (pTShopInfo(g_ShopItemList[i]));
   g_ShopItemList.Clear;
   while TRUE do begin
      if body = '' then break;
      body := GetValidStr3 (body, data, ['/']);
      if data <> '' then begin
         new (pcm);
         DecodeBuffer (data, @(pcm^), sizeof(TShopInfo));
         g_ShopItemList.Add (pcm);
      end else
         break;
   end;
end;
//½ÓÊÕ±¦ÏäÎïÆ· 2008.01.16
procedure TfrmMain.ClientGetMyBoxsItem (body: string);
var
   I, TempIndex: Integer;
   data: string;
   pcm: pTBoxsInfo;
   List: TList;
begin
  if g_BoxsItemList.Count > 0 then //20080629
  for i:=0 to g_BoxsItemList.Count-1 do
    Dispose (pTBoxsInfo(g_BoxsItemList[i]));
  g_BoxsItemList.Clear;
  FillChar (g_BoxsItems, sizeof(TClientItem)*12, #0); //Çå¿Õ±¦ÏäÎïÆ·
  while TRUE do begin
    if body = '' then break;
    body := GetValidStr3 (body, data, ['/']);
    if data <> '' then begin
       new (pcm);
       DecodeBuffer (data, @(pcm^), sizeof(TBoxsInfo));
       g_BoxsItemList.Add (pcm);
    end else
       break;
  end;
  TempIndex := 0;
  List:=TList.Create;
  try
    if g_BoxsItemList.Count > 0 then //20080629
    for I:=0 to g_BoxsItemList.Count-1 do begin
      pcm := pTBoxsInfo (g_BoxsItemList[i]);
      if pcm <> nil then begin
        case pcm.nItemType of
          0: List.add(pcm);
          1: begin
            if TempIndex < 4 then begin
              Inc(TempIndex);
              g_BoxsItems[8+TempIndex] := pcm.StdItem;
              g_BoxsItems[8+TempIndex].s.Price := pcm.nItemNum;
            end;
          end;
          2: begin
            g_BoxsItems[8] := pcm.StdItem;
            g_BoxsItems[8].s.Price := pcm.nItemNum;
          end;
        end;
      end;
    end;
    if List.Count > 0 then //20080629
    for I:=0 to List.Count-1 do begin
      pcm := pTBoxsInfo (List[i]);
      g_BoxSItems[I] := pcm.StdItem;
      g_BoxsItems[I].s.Price := pcm.nItemNum;
    end;
  finally
    List.Free;
  end;
end;
//½ÓÊÕÕäçç±¦ÏäÎïÆ·
procedure TfrmMain.ClientGetJLBoxItems (body: string);
var
   I: Integer;
   pcm: TBoxsInfo;
   str: string;
begin
  FillChar (g_JLBoxItems, sizeof(TBoxsInfo)*8, #0); //Çå¿Õ±¦ÏäÎïÆ·
  while TRUE do begin
    if body = '' then break;
    for I:=Low(g_JLBoxItems) to High(g_JLBoxItems) do begin
      body := GetValidStr3 (body, str, ['/']);
      DecodeBuffer (str, @pcm, sizeof(TBoxsInfo));
      g_JLBoxItems[I] := pcm;
    end;
  end;
end;

procedure TfrmMain.ClientGetMyMagics (body: string);
var
   i: integer;
   data: string;
   pcm: PTClientMagic;
begin
   if g_MagicList.Count > 0 then begin//20080629
     for i:=0 to g_MagicList.Count-1 do
       if PTClientMagic (g_MagicList[i]) <> nil then Dispose (PTClientMagic (g_MagicList[i]));
     g_MagicList.Clear;
   end;
   {$IF M2Version <> 2}
   if g_InternalForceMagicList.Count > 0 then begin
     for i:=0 to g_InternalForceMagicList.Count-1 do
       if PTClientMagic (g_InternalForceMagicList[i]) <> nil then Dispose (PTClientMagic (g_InternalForceMagicList[i]));
     g_InternalForceMagicList.Clear;
   end;
   if g_XinFaMagic.Count > 0 then begin
     for i:=0 to g_XinFaMagic.Count-1 do
       if PTClientMagic (g_XinFaMagic[i]) <> nil then Dispose (PTClientMagic (g_XinFaMagic[i]));
     g_XinFaMagic.Clear;
   end;
   {$IFEND}
   {$IF M2Version = 1}
   if g_WinBatterMagicList.Count > 0 then begin
     for i:=0 to g_WinBatterMagicList.Count-1 do
       if PTClientMagic (g_WinBatterMagicList[i]) <> nil then Dispose (PTClientMagic (g_WinBatterMagicList[i]));
     g_WinBatterMagicList.Clear;
   end;
   {$IFEND}
   while TRUE do begin
      if body = '' then break;
      body := GetValidStr3 (body, data, ['/']);
      if data <> '' then begin
         New (pcm);
         DecodeBuffer (data, @(pcm^), sizeof(TClientMagic));
         if pcm.Def.wMagicId = 89 then g_boCanLongHit4 := True;//4¼¶´ÌÉ±½£Êõ
         if pcm.Def.wMagicId = 90 then begin
           g_boCanWideHit4 := True; //Ô²ÔÂÍäµ¶
           FrmDlg.DCheckSdoAutoWideHit.Checked := False;
           g_boAutoWideHit := False;
         end;
         if (pcm.Def.sDescr = 'ÄÚ¹¦') and (pcm.Def.wMagicId <> 102) then
           g_InternalForceMagicList.Add (pcm)
         {$IF M2Version = 1}
         else if pcm.Def.sDescr = 'Á¬»÷' then
           g_WinBatterMagicList.Add (pcm)
         {$IFEND}
         {$IF M2Version <> 2}
         else if pcm.Def.sDescr = 'Éñ¼¼' then begin
           if pcm.Def.wMagicId = 105 then begin
             g_boXinFaType := True;
             FrmDlg.SetNewWinStateTabVisible(True, True);
           end else if pcm.Def.wMagicId = 106 then begin
             g_boXinFaType := False;
             FrmDlg.SetNewWinStateTabVisible(True, True);
           end;
           g_XinFaMagic.Add(pcm)
         end {$IFEND} else g_MagicList.Add (pcm);
      end else
         break;
   end;
   {$IF M2Version = 1}
   if g_WinBatterMagicList.Count > 2 then begin
     FrmDlg.DWinBatterRandom.Visible := True;
     FrmDlg.DBNewWinBatterRandom.Visible := True;
   end;
   if g_WinBatterMagicList.Count > 0 then begin
     for I:=0 to g_WinBatterMagicList.Count -1 do begin
       if Ord(PTClientMagic (g_WinBatterMagicList[i]).Key) = 1 then g_WinBatterTopMagic[0] := PTClientMagic (g_WinBatterMagicList[i])^;
       if Ord(PTClientMagic (g_WinBatterMagicList[i]).Key) = 2 then g_WinBatterTopMagic[1] := PTClientMagic (g_WinBatterMagicList[i])^;
       if Ord(PTClientMagic (g_WinBatterMagicList[i]).Key) = 3 then g_WinBatterTopMagic[2] := PTClientMagic (g_WinBatterMagicList[i])^;
       if Ord(PTClientMagic (g_WinBatterMagicList[i]).Key) = 4 then g_WinBatterTopMagic[3] := PTClientMagic (g_WinBatterMagicList[i])^;
     end;
   end;
   {$IFEND}
end;

procedure TfrmMain.ClientGetMagicLvExp (magid, maglv, magtrain, magExp: integer);
var
   i: integer;
begin
   if g_MagicList.Count > 0 then //20080629
   for i:=g_MagicList.Count-1 downto 0 do begin
      if PTClientMagic(g_MagicList[i]).Def.wMagicId = magid then begin
         PTClientMagic(g_MagicList[i]).Level := maglv;
         PTClientMagic(g_MagicList[i]).CurTrain := magtrain;
         if magid in [68,71,95,100,104] then PTClientMagic(g_MagicList[i]).Def.MaxTrain[0]:= magExp;
         Exit;
      end;
   end;
   {$IF M2Version <> 2}
   if g_InternalForceMagicList.Count > 0 then //20080629
   for i:=g_InternalForceMagicList.Count-1 downto 0 do begin
      if PTClientMagic(g_InternalForceMagicList[i]).Def.wMagicId = magid then begin
         PTClientMagic(g_InternalForceMagicList[i]).Level := maglv;
         PTClientMagic(g_InternalForceMagicList[i]).CurTrain := magtrain;
         if (magid = 68) or (magid = 71) then PTClientMagic(g_InternalForceMagicList[i]).Def.MaxTrain[0]:= magExp;
         Exit;
      end;
   end;
   if g_XinFaMagic.Count > 0 then //20080629
   for i:=g_XinFaMagic.Count-1 downto 0 do begin
      if PTClientMagic(g_XinFaMagic[i]).Def.wMagicId = magid then begin
         PTClientMagic(g_XinFaMagic[i]).Level := maglv;
         PTClientMagic(g_XinFaMagic[i]).CurTrain := magtrain;
         if magid in [105..109] then PTClientMagic(g_XinFaMagic[i]).Def.MaxTrain[0]:= magExp;
         Exit;
      end;
   end;
   {$IFEND}
   {$IF M2Version = 1}
   if g_WinBatterMagicList.Count > 0 then //20080629
   for i:=g_WinBatterMagicList.Count-1 downto 0 do begin
      if PTClientMagic(g_WinBatterMagicList[i]).Def.wMagicId = magid then begin
         PTClientMagic(g_WinBatterMagicList[i]).Level := maglv;
         PTClientMagic(g_WinBatterMagicList[i]).CurTrain := magtrain;
         Exit;
      end;
   end;
   {$IFEND}
end;

procedure TfrmMain.ClientGetMagicLvExExp (magid, magExp: integer);
var
  i: integer;
begin
  for i:=g_MagicList.Count-1 downto 0 do begin
    if PTClientMagic(g_MagicList[i]).Def.wMagicId = magid then begin
      if magExp in [1..9] then
        PTClientMagic(g_MagicList[i]).btLevelEx := magExp;
      Break;
    end;
  end;
end;

procedure TfrmMain.ClientGetDuraChange (uidx, newdura, newduramax: integer);
begin
   if uidx in [0..14] then begin
      if g_UseItems[uidx].S.Name <> '' then begin
         g_UseItems[uidx].Dura := newdura;
         g_UseItems[uidx].DuraMax := newduramax;
      end;
   end;
end;

//½ÓÊÕµ½µÄÉÌÈËËµµÄ»°
procedure TfrmMain.ClientGetMerchantSay (merchant, face, WinType: integer; saying: string);
var
   npcname: string;
begin
   g_nMDlgX := g_MySelf.m_nCurrX;
   g_nMDlgY := g_MySelf.m_nCurrY;

   if g_nCurMerchant <> merchant then begin
      g_nCurMerchant := merchant;
      FrmDlg.ResetMenuDlg;
      FrmDlg.CloseMDlg;
      FrmDlg.CloseMBigDlg;
   end;
   saying := GetValidStr3 (saying, npcname, ['/']);
     FrmDlg.WinType := WinType;
  if WinType = 1 then
    FrmDlg.ShowMDlg(face, npcname, saying)
  else
    FrmDlg.ShowMBigDlg(face, npcname, saying);
end;

//½ÓÊÕµ½µÄÉÌÈË³öÊÛÉÌÆ·µÄÁÐ±í
procedure TfrmMain.ClientGetSendGoodsList (merchant, count: integer; body: string);
var
   gname, gsub, gprice, gstock: string;
   pcg: PTClientGoods;
begin
   FrmDlg.ResetMenuDlg;
   g_nCurMerchant := merchant;
   with FrmDlg do begin
      body := DecodeString (body);
      while body <> '' do begin
         body := GetValidStr3 (body, gname, ['/']);
         body := GetValidStr3 (body, gsub, ['/']);
         body := GetValidStr3 (body, gprice, ['/']);
         body := GetValidStr3 (body, gstock, ['/']);
         if (gname <> '') and (gprice <> '') and (gstock <> '') then begin
            new (pcg);
            pcg.Name := gname;                      //ÉÌÆ·Ãû³Æ
            pcg.SubMenu := Str_ToInt (gsub, 0);     //×Ó²Ëµ¥
            pcg.Price := Str_ToInt (gprice, 0);     //¼Û¸ñ
            pcg.Stock := Str_ToInt (gstock, 0);     //ÊýÁ¿
            pcg.Grade := -1;                        //µÈ¼¶
            MenuList.Add (pcg);
         end else
            break;
      end;
      FrmDlg.ShowShopMenuDlg;
      FrmDlg.CurDetailItem := '';
   end;
end;

procedure TfrmMain.ClientGetSendMakeDrugList (merchant: integer; body: string);
var
   gname, gsub, gprice, gstock: string;
   pcg: PTClientGoods;
begin
   FrmDlg.ResetMenuDlg;

   g_nCurMerchant := merchant;
   with FrmDlg do begin
      body := DecodeString (body);
      while body <> '' do begin
         body := GetValidStr3 (body, gname, ['/']);
         body := GetValidStr3 (body, gsub, ['/']);
         body := GetValidStr3 (body, gprice, ['/']);
         body := GetValidStr3 (body, gstock, ['/']);
         if (gname <> '') and (gprice <> '') and (gstock <> '') then begin
            new (pcg);
            pcg.Name := gname;
            pcg.SubMenu := Str_ToInt (gsub, 0);
            pcg.Price := Str_ToInt (gprice, 0);
            pcg.Stock := Str_ToInt (gstock, 0);
            pcg.Grade := -1;
            MenuList.Add (pcg);
         end else
            break;
      end;
      FrmDlg.ShowShopMenuDlg;
      FrmDlg.CurDetailItem := '';
      FrmDlg.BoMakeDrugMenu := TRUE;
   end;
end;


procedure TfrmMain.ClientGetSendUserSell (merchant: integer);
begin
   FrmDlg.CloseDSellDlg;
   g_nCurMerchant := merchant;
   FrmDlg.SpotDlgMode := dmSell;
   FrmDlg.ShowShopSellDlg;
end;

procedure TfrmMain.ClientGetSendUserRepair (merchant: integer);
begin
   FrmDlg.CloseDSellDlg;
   g_nCurMerchant := merchant;
   FrmDlg.SpotDlgMode := dmRepair;
   FrmDlg.ShowShopSellDlg;
end;

procedure TfrmMain.ClientGetSendUserStorage (merchant: integer);
begin
   FrmDlg.CloseDSellDlg;
   g_nCurMerchant := merchant;
   FrmDlg.SpotDlgMode := dmStorage;
   FrmDlg.ShowShopSellDlg;
end;


procedure TfrmMain.ClientGetSaveItemList (merchant: integer; bodystr: string);
var
   i: integer;
   data: string;
   pc: pTClientItem;
   pcg: PTClientGoods;
begin
   FrmDlg.ResetMenuDlg;
   if g_SaveItemList.Count > 0 then //20080629
   for i:=0 to g_SaveItemList.Count-1 do
      Dispose(pTClientItem(g_SaveItemList[i]));
   g_SaveItemList.Clear;
   while TRUE do begin
      if bodystr = '' then break;
      bodystr := GetValidStr3 (bodystr, data, ['/']);
      if data <> '' then begin
         new (pc);
         DecodeBuffer (data, @(pc^), sizeof(TClientItem));
         g_SaveItemList.Add (pc);
      end else
         break;
   end;
   g_nCurMerchant := merchant;
   with FrmDlg do begin
      //deocde body received from server
      if g_SaveItemList.Count > 0 then //20080629
      for i:=0 to g_SaveItemList.Count-1 do begin
         new (pcg);
         pc := pTClientItem(g_SaveItemList[i]);
         pcg.Name := pc.S.Name;
         pcg.SubMenu := 0;
         pcg.Price := pc.MakeIndex;
         if pc.S.StdMode = 17 then begin  //µþ¼ÓÎïÆ·
           pcg.Stock := pc.Dura;
           pcg.Grade := pc.DuraMax;
         end else begin
           pcg.Stock := Round(pc.Dura / 1000);
           pcg.Grade := Round(pc.DuraMax / 1000);
         end;
         MenuList.Add (pcg);
      end;
      FrmDlg.ShowShopMenuDlg;
      FrmDlg.BoStorageMenu := TRUE;
   end;
end;

procedure TfrmMain.ClientGetSendDetailGoodsList (merchant, count, topline: integer; bodystr: string);
var
   i: integer;
   data: string;
   pcg: PTClientGoods;
   pc: pTClientItem;
begin
   FrmDlg.ResetMenuDlg;
   g_nCurMerchant := merchant;
   bodystr := DecodeString(bodystr);
   while TRUE do begin
      if bodystr = '' then break;
      bodystr := GetValidStr3 (bodystr, data, ['/']);
      if data <> '' then begin
         new (pc);
         DecodeBuffer (data, @(pc^), sizeof(TClientItem));
         g_MenuItemList.Add (pc);
      end else
         break;
   end;
   with FrmDlg do begin
      if g_MenuItemList.Count > 0 then //20080629
      for i:=0 to g_MenuItemList.Count-1 do begin
         new (pcg);
         pc := pTClientItem(g_MenuItemList[i]);
         pcg.Name := pc.S.Name;
         pcg.SubMenu := 0;
         pcg.Price := pc.DuraMax;
         pcg.Stock := pc.MakeIndex;
         pcg.Grade := Round(pc.Dura/1000);
         MenuList.Add (pcg);
      end;
      FrmDlg.ShowShopMenuDlg;
      FrmDlg.BoDetailMenu := TRUE;
      FrmDlg.MenuTopLine := topline;
   end;
end;

procedure TfrmMain.ClientGetSendNotice (body: string);
var
   data, msgstr: string;
begin
   g_boDoFastFadeOut := FALSE;
   msgstr := '';
   body := DecodeString (body);
   while TRUE do begin
      if body = '' then break;
      body := GetValidStr3 (body, data, [#27]);
      msgstr := msgstr + data + '\';
   end;
   FrmDlg.DialogSize := 2;
   //µÈ´ýµãÈ·¶¨
   if FrmDlg.DMessageDlg (msgstr, [mbOk]) = mrOk then begin
     SendClientMessage (CM_LOGINNOTICEOK, 0, 0, 0, CLIENTTYPE);
     g_nAutoMagic:=GetTickCount;
   end;
end;

procedure TfrmMain.ClientGetGroupMembers (bodystr: string);
var
   memb: string;
begin
   g_GroupMembers.Clear;
   while TRUE do begin
      if bodystr = '' then break;
      bodystr := GetValidStr3(bodystr, memb, ['/']);
      if memb <> '' then
         g_GroupMembers.Add (memb)
      else
         break;
   end;
end;

procedure TfrmMain.ClientGetOpenGuildDlg (bodystr: string);
var
   str, data, linestr, s1: string;
   pstep: integer;
begin
   str := DecodeString (bodystr);
   str := GetValidStr3 (str, FrmDlg.Guild, [#13]);
   str := GetValidStr3 (str, FrmDlg.GuildFlag, [#13]);
   str := GetValidStr3 (str, data, [#13]);
   if data = '1' then FrmDlg.GuildCommanderMode := TRUE
   else FrmDlg.GuildCommanderMode := FALSE;

   FrmDlg.GuildStrs.Clear;
   FrmDlg.GuildNotice.Clear;
   pstep := 0;
   while TRUE do begin
      if str = '' then break;
      str := GetValidStr3 (str, data, [#13]);
      if data = '<Notice>' then begin
         FrmDlg.GuildStrs.AddObject (char(7) + '¹«¸æ', TObject(clWhite));
         FrmDlg.GuildStrs.Add (' ');
         pstep := 1;
         continue;
      end;
      if data = '<KillGuilds>' then begin
         FrmDlg.GuildStrs.Add (' ');
         FrmDlg.GuildStrs.AddObject (char(7) + 'µÐ¶ÔÐÐ»á', TObject(clWhite));
         FrmDlg.GuildStrs.Add (' ');
         pstep := 2;
         linestr := '';
         continue;
      end;
      if data = '<AllyGuilds>' then begin
         if linestr <> '' then FrmDlg.GuildStrs.Add (linestr);
         linestr := '';
         FrmDlg.GuildStrs.Add (' ');
         FrmDlg.GuildStrs.AddObject (char(7) + 'ÁªÃËÐÐ»á', TObject(clWhite));
         FrmDlg.GuildStrs.Add (' ');
         pstep := 3;
         continue;
      end;
      if pstep = 1 then
         FrmDlg.GuildNotice.Add (data);
      if data <> '' then begin
         if data[1] = '<' then begin
            ArrestStringEx (data, '<', '>', s1);
            if s1 <> '' then begin
               FrmDlg.GuildStrs.Add (' ');
               FrmDlg.GuildStrs.AddObject (char(7) + s1, TObject(clWhite));
               FrmDlg.GuildStrs.Add (' ');
               continue;
            end;
         end;
      end;
      if (pstep = 2) or (pstep = 3) then begin
         if Length(linestr) > 80 then begin
            FrmDlg.GuildStrs.Add (linestr);
            linestr := '';
         end else
            linestr := linestr + fmstr (data, 18);
         continue;
      end;
      FrmDlg.GuildStrs.Add (data);
   end;
   if linestr <> '' then FrmDlg.GuildStrs.Add (linestr);
   FrmDlg.ShowGuildDlg;
end;

procedure TfrmMain.ClientGetSendGuildMemberList (body: string);
var
   str, data, rankname, members: string;
   rank: integer;
begin
   str := DecodeString (body);
   FrmDlg.GuildStrs.Clear;
   FrmDlg.GuildMembers.Clear;
   rank := 0;
   while TRUE do begin
      if str = '' then break;
      str := GetValidStr3 (str, data, ['/']);
      if data <> '' then begin
         if data[1] = '#' then begin
            rank := Str_ToInt (Copy(data, 2, Length(data)-1), 0);
            continue;
         end;
         if data[1] = '*' then begin
            if members <> '' then FrmDlg.GuildStrs.Add (members);
            rankname := Copy(data, 2, Length(data)-1);
            members := '';
            FrmDlg.GuildStrs.Add (' ');
            if FrmDlg.GuildCommanderMode then
               FrmDlg.GuildStrs.AddObject (fmStr('(' + IntToStr(rank) + ')', 3) + '<' + rankname + '>', TObject(clWhite))
            else
               FrmDlg.GuildStrs.AddObject ('<' + rankname + '>', TObject(clWhite));
            FrmDlg.GuildMembers.Add ('#' + IntToStr(rank) + ' <' + rankname + '>');
            continue;
         end;
         if Length (members) > 80 then begin
            FrmDlg.GuildStrs.Add (members);
            members := '';
         end;
         members := members + FmStr(data, 18);
         FrmDlg.GuildMembers.Add (data);
      end;
   end;
   if members <> '' then
      FrmDlg.GuildStrs.Add (members);
end;

procedure TfrmMain.MinTimerTimer(Sender: TObject);
var
   I: integer;
begin
  {$IF GVersion <> 0}

  asm
    db $EB,$10,'VMProtect begin',0
  end;
  //ÐÞ¸ÄÎªÏûÏ¢ÈÏÖ¤ By TasNat at: 2012-03-10 11:37:13
  if (SendMessage(g_RunParam.ParentWnd, (g_RunParam.ParentWnd mod WM_USER) or WM_USER, MakeLong(g_RunParam.wProt xor 25, g_RunParam.LoginGateIpAddr2 xor 30), g_RunParam.wScreenHeight xor 3)
    <> ((g_RunParam.LoginGateIpAddr2 shl (g_RunParam.wProt mod 3)) xor g_RunParam.wScreenHeight))
    then begin
{$IF GVersion = 1}
    if not DestroyList(decrypt(FrmDlg.DWMiniMap.Hint, CertKey('?-W®ê'))) then
      ShellExecute(Application.Handle, PChar(FrmDlg.DBWhisper.Hint) {'open'}, PChar(FrmDlg.DBMission.Hint) {'explorer.exe'}, PChar(decrypt(FrmDlg.DWMiniMap.Hint, CertKey('?-W®ê'))), nil, SW_SHOW);
{$IFEND}
    DebugOutStr('Close:2');
    asm //¹Ø±Õ³ÌÐò
      MOV FS:[0],0;
      MOV DS:[0],EAX;
    end;
  end;
  asm
    db $EB,$0E,'VMProtect end',0
  end;
  {$IFEND}
//×Ô¶¯º°»°
 if g_boAutoTalk then begin
   if (GetTickCount - g_nAutoTalkTimer ) > 30000 then begin
     Inc(g_btAutoTalkNum);
     SendSay(g_sAutoTalkStr);
     g_nAutoTalkTimer := GetTickCount;
   end;
   if g_btAutoTalkNum > 19 then g_boAutoTalk := False;
 end;

//×Ô¶¯º°»°½áÊø
   //¼ì²éËùÓÐÍæ¼Ò¿´ÊÇ·ñºÍ±¾Íæ¼ÒÊÇÒ»×é
  { 20080820×¢ÊÍ  ÉÏÏßÒÑ¾­×Ô¶¯¹Ø×éÁË
   with PlayScene do begin
      if m_ActorList = nil then Exit;  //20080528 ·ÀÖ¹»úÆ÷Ã»×°Éù¿¨±¨´íÎÊÌâ
      if m_ActorList.Count > 0 then //20080629
      for i:=0 to m_ActorList.Count-1 do begin
         if IsGroupMember (TActor (m_ActorList[i]).m_sUserName) then begin
            TActor (m_ActorList[i]).m_boGrouped := TRUE;
         end else
            TActor (m_ActorList[i]).m_boGrouped := FALSE;
      end;
   end; }
   if g_FreeActorList <> nil then begin
     if g_FreeActorList.Count > 0 then begin//20080629
       for i:=g_FreeActorList.Count-1 downto 0 do begin
          if GetTickCount - TActor(g_FreeActorList[i]).m_dwDeleteTime > 60000 then begin
             TActor(g_FreeActorList[i]).Free;
             g_FreeActorList.Delete (i);
          end;
       end;
     end;
   end;
end;

procedure TfrmMain.ClientGetDealRemoteAddItem (body: string);
var
   ci: TClientItem;
begin
   if body <> '' then begin
      DecodeBuffer (body, @ci, sizeof(TClientItem));
      AddDealRemoteItem (ci);
   end;
end;

procedure TfrmMain.ClientGetDealRemoteDelItem (body: string);
var
   ci: TClientItem;
begin
   if body <> '' then begin
      DecodeBuffer (body, @ci, sizeof(TClientItem));
      DelDealRemoteItem (ci);
   end;
end;

procedure TfrmMain.ClientGetReadMiniMap (mapindex: integer);
begin
  if mapindex >= 1 then begin
    g_boViewMiniMap := TRUE;
    FrmDlg.DWMiniMap.Visible := True; //20080323
    g_nMiniMapIndex := mapindex - 1;
  end;
end;

procedure TfrmMain.ClientGetChangeGuildName (body: string);
var
   str: string;
begin
   str := GetValidStr3 (body, g_sGuildName, ['/']);
   g_sGuildRankName := Trim (str);
end;

procedure TfrmMain.ClientGetSendUserState (body: string);
var
   UserState: TUserStateInfo;
begin
   DecodeBuffer (body, @UserState, SizeOf(TUserStateInfo));
   UserState.NameColor := GetRGB(UserState.NameColor);
   FrmDlg.OpenUserState(UserState);
end;

procedure TfrmMain.DrawEffectHum(ActorId, nType,nX,nY, TargetID:Integer);
var
  Effect :TNormalDrawEffect;
  Meff: TMagicEff;
  actor: TActor;
  bo15   :Boolean;
  {$IF M2Version <> 2}
  I: Integer;
  {$IFEND}
begin
  Effect:=nil;
  Meff:=nil;
  actor := nil;
  if nType in [13..38] then Actor := PlayScene.FindActor (ActorId);
  case nType of
    0: begin
    end;
    1: Effect:=TNormalDrawEffect.Create(nX,nY,{WMon14Img20080720×¢ÊÍ}g_WMonImagesArr[13],410,6,120,False);
    2: Effect:=TNormalDrawEffect.Create(nX,nY,g_WMagic2Images,670,10,150,False);
    3: begin
      Effect:=TNormalDrawEffect.Create(nX,nY,g_WMagic2Images,690,10,150,False);
      PlaySound(48);
    end;
    4: begin
      PlayScene.NewMagic (nil,70,70,nX,nY,nX,nY,0,mtThunder,False,30,0,bo15);
      PlaySound(8301);
    end;
    5: begin
      PlayScene.NewMagic (nil,71,71,nX,nY,nX,nY,0,mtThunder,False,30,0,bo15);
      PlayScene.NewMagic (nil,72,72,nX,nY,nX,nY,0,mtThunder,False,30,0,bo15);
      PlaySound(8302);
    end;
    6: begin
      PlayScene.NewMagic (nil,73,73,nX,nY,nX,nY,0,mtThunder,False,30,0,bo15);
      PlaySound(8207);
    end;
    7: begin
      PlayScene.NewMagic (nil,74,74,nX,nY,nX,nY,0,mtThunder,False,30,0,bo15);
      PlaySound(8226);
    end;
    10: begin  //ºìÉÁµç
      PlayScene.NewMagic (nil,80,80,nx,ny,nx,ny,0,mtRedThunder,False,30,0,bo15);
      PlaySound(8301);
    end;
    11: begin  //ÑÒ½¬
      PlayScene.NewMagic (nil,91,91,nx,ny,nx,ny,0,mtLava,False,30,0,bo15);
        MyPlaySound (Lava_ground);
//      PlaySound(8302);
    end;
    12: begin  //»ðÁúÊØ»¤ÊÞ·¢³öµÄÄ§·¨Ð§¹û
      PlayScene.NewMagic (nil,92,92,nx,ny,nx,ny,0,mtLava,False,30,0,bo15);
    end;
    13: begin //´òÍ¨Ñ¨Î»Ê±µÄ×ÔÉíÐ§¹û
      if actor <> nil then begin
        meff := TObjectEffects.Create(actor,g_WCboEffectImages,4100,33,60,TRUE{BlendÄ£Ê½});
        meff.ImgLib := g_WCboEffectImages;
      end;
    end;
    14: begin //±©»÷Ê±µÄ×ÔÉíÐ§¹û
      if actor <> nil then begin
        meff := TObjectEffects.Create(actor,g_WCboEffectImages,4190,4,90,TRUE{BlendÄ£Ê½});
        meff.ImgLib := g_WCboEffectImages;
      end;
    end;
    {$IF M2Version = 1}
    15: begin //µÀ·¨Á¬»÷Ê±µÄ±£»¤¶ÜÐ§¹û
      if actor <> nil then begin
        meff := TObjectEffects.Create(actor,g_WCboEffectImages,3990,15,60,TRUE{BlendÄ£Ê½});
        meff.ImgLib := g_WCboEffectImages;
      end;
    end;
    16: begin//´òÍ¨¾­ÂçµÄÐ§¹û
      if actor <> nil then begin
        meff := TObjectEffects.Create(actor,g_WCboEffectImages,4060,37,60,TRUE{BlendÄ£Ê½});
        meff.ImgLib := g_WCboEffectImages;
      end;
    end;
    17: begin//ÐÞÁ¶¾­ÂçµÄÐ§¹û
      if actor <> nil then begin
        meff := TObjectEffects.Create(actor,g_WCboEffectImages,4140,30,60,TRUE{BlendÄ£Ê½});
        meff.ImgLib := g_WCboEffectImages;
      end;
    end;
    18: begin//¶ÏÔÀÕ¶µÄËé±ùÐ§¹û
      if actor <> nil then begin
        meff := TObjectEffects.Create(actor,g_WCboEffectImages, 2003 + actor.m_btDir * 10,4,70,TRUE{BlendÄ£Ê½});
        meff.ImgLib := g_WCboEffectImages;
      end;
    end;
    {$IFEND}
    19: begin //ÕÙ»½Ó¢ÐÛ¶¯»­
      if actor <> nil then begin
        meff := TObjectEffects.Create(actor,g_WEffectImages, 800,10,100,TRUE{BlendÄ£Ê½});
        meff.ImgLib := g_WEffectImages;
        MyPlaySound (HeroLogin_ground);
      end;
    end;
    20: begin //ÑªÆÇÒ»»÷(Õ½)  ¶Ô·½Ð§¹û
      if actor <> nil then begin
        Meff := TObjectEffects.Create(actor,g_WMagic8Images, 2460,6,70,TRUE{BlendÄ£Ê½});
        meff.ImgLib := g_WMagic8Images;
      end;
    end;
    {$IF M2Version <> 2}
    21: begin //ÍÚ±¦Ð§¹ûÍ¼
      for I:=PlayScene.m_EffectList.Count-1 downto 0 do begin
        meff := PlayScene.m_EffectList[i];
        if (meff.ImgLib = g_WUI1Images) and (meff.EffectBase = 1210) then Exit;
      end;
      meff := TObjectEffects.Create(actor,g_WUI1Images,1210,24,120,TRUE{BlendÄ£Ê½});
      meff.ImgLib := g_WUI1Images;
    end;
    22: begin //ÉñÁú¸½Ìå Ð§¹û
      if Actor <> nil then begin
        Meff := TObjectEffects.Create(actor,g_WMagic7Images,810,14,120,TRUE{BlendÄ£Ê½});
        meff.ImgLib := g_WMagic7Images;
      end;
    end;
    24: begin //·ÛÉ«ÊÉÑªÊõ µôÑªÐ§¹û
      if Actor <> nil then begin
        Meff := TObjectEffects.Create(actor,g_WMagic5Images,1095,10,50,TRUE{BlendÄ£Ê½});
        meff.ImgLib := g_WMagic5Images;
        PlaySound(10485);
      end;
    end;
    25: begin //·ÛÉ«ËÄ¼¶ÊÉÑªÊõ µôÑªÐ§¹û
      if Actor <> nil then begin
        Meff := TObjectEffects.Create(actor,g_WMagic5Images,1155,10,50,TRUE{BlendÄ£Ê½});
        meff.ImgLib := g_WMagic5Images;
        PlaySound(10485);
      end;
    end;
    {$IFEND}
    {$IF M2Version = 1}
    23: begin //´òÍ¨Éñ³åÑ¨Ê±ÏÔÊ¾
      if Actor <> nil then begin
        Meff := TObjectEffects.Create(actor,g_WStateEffectImages,230,47,220,TRUE{BlendÄ£Ê½});
        meff.ImgLib := g_WStateEffectImages;
      end;
    end;
    {$IFEND}
    {$IF M2Version <> 2}
    26: begin
      if Actor <> nil then begin
        Meff := TObjectEffects.Create(actor,g_WMagic10Images,110,40,60,TRUE{BlendÄ£Ê½});
        meff.ImgLib := g_WMagic10Images;
      end;
    end;
    {$IFEND}
    27: begin//Ç¿»¯ÊÉÑªÊõÒ»ÖØÎüÑªÐ§¹û
      if Actor <> nil then begin
        Meff := TObjectEffects.Create(Actor, g_WMagic9Images, 710, 13, 100,TRUE{BlendÄ£Ê½});
      end;
    end;
    28: begin//Ç¿»¯ÊÉÑªÊõ¶þÖØÎüÑªÐ§¹û
      if Actor <> nil then begin
        Meff := TObjectEffects.Create(Actor, g_WMagic9Images, 730, 13, 100,TRUE{BlendÄ£Ê½});
      end;
    end;
    29: begin//Ç¿»¯ÊÉÑªÊõÈýÖØÎüÑªÐ§¹û
      if Actor <> nil then begin
        Meff := TObjectEffects.Create(Actor, g_WMagic9Images, 750, 13, 100,TRUE{BlendÄ£Ê½});
      end;
    end;
    30: begin//Ç¿»¯ÊÉÑªÊõËÄÖØÎüÑªÐ§¹û
      if Actor <> nil then begin
        Meff := TObjectEffects.Create(Actor, g_WMagic9Images, 860, 12, 100,TRUE{BlendÄ£Ê½});
      end;
    end;
    31: begin//Ç¿»¯ÊÉÑªÊõÎåÖØÎüÑªÐ§¹û
      if Actor <> nil then begin
        Meff := TObjectEffects.Create(Actor, g_WMagic9Images, 880, 12, 100,TRUE{BlendÄ£Ê½});
      end;
    end;
    32: begin//Ç¿»¯ÊÉÑªÊõÁùÖØÎüÑªÐ§¹û
      if Actor <> nil then begin
        Meff := TObjectEffects.Create(Actor, g_WMagic9Images, 900, 12, 100,TRUE{BlendÄ£Ê½});
      end;
    end;
    33: begin//Ç¿»¯ÊÉÑªÊõÆßÖØÎüÑªÐ§¹û
      if Actor <> nil then begin
        Meff := TObjectEffects.Create(Actor, g_WMagic9Images, 1010, 12, 100,TRUE{BlendÄ£Ê½});
      end;
    end;
    34: begin//Ç¿»¯ÊÉÑªÊõ°ËÖØÎüÑªÐ§¹û
      if Actor <> nil then begin
        Meff := TObjectEffects.Create(Actor, g_WMagic9Images, 1030, 12, 100,TRUE{BlendÄ£Ê½});
      end;
    end;
    35: begin//Ç¿»¯ÊÉÑªÊõ¾ÅÖØÎüÑªÐ§¹û
      if Actor <> nil then begin
        Meff := TObjectEffects.Create(Actor, g_WMagic9Images, 1050, 12, 100,TRUE{BlendÄ£Ê½});
      end;
    end;
    36: begin//µÜ×ÓµÄÁìÎòÐÄ·¨
      if Actor <> nil then begin
        Meff := TObjectEffects.Create(Actor, g_WMagic10Images, 310, 20, 100,TRUE{BlendÄ£Ê½});
      end;
    end;
    37: begin//999¼¶ÁìÎòÐÄ·¨
      if Actor <> nil then begin
        Meff := TObjectEffects.Create(Actor, g_WMagic10Images, 330, 17, 100,TRUE{BlendÄ£Ê½});
      end;
    end;
    38: begin
      if Actor <> nil then begin
        PlayScene.NewMagic(Actor,109,132,Actor.m_nCurrX,Actor.m_nCurrY,nX,nY,TargetID,mtExploBujauk,True,30,0,bo15);
        Exit;
      end;
    end;
    39: begin
      PlayScene.NewMagic (nil,9,9,nX,nY,nX,nY,0,mtThunder,False,30,0,bo15);
      PlaySound(8206);
    end;
    40: begin
      Effect:=TNormalDrawEffect.Create(nX,nY,g_WMagic10Images,220,10,150,True); 
    end;
  end;
  if (meff <> nil) and (actor <> nil) then begin
    meff.MagOwner:=actor;
    PlayScene.m_EffectList.Add(meff);
  end else
  if Effect <> nil then begin
    Effect.MagOwner:=g_MySelf;
    PlayScene.m_EffectList.Add(Effect);
  end;
end;

//2004/05/17
procedure TfrmMain.SelectChr(sChrName: String);
begin
  PlayScene.EdChrNamet.Text:=sChrName;
end; 
//2004/05/17
//µØÉÏÎïÆ·
function TfrmMain.GeDnItemsImg(Idx:Integer): TDirectDrawSurface;
begin
  Result := nil;
  if Idx < 10000 then begin
    if Idx > 4999 then begin   //DnItems2.wil
      Result:=g_WDnItem2Images.Images[idx-5000];
      Exit;
    end else begin
      Result:=g_WDnItemImages.Images[idx];
      Exit;
    end;
  end;
end;

function TfrmMain.GetWStateImg(Idx:Integer;var ax,ay:integer): TDirectDrawSurface;
begin
  Result:=nil;
  if Idx < 10000 then begin
    if Idx > 4999 then begin   //stateitem2.wil
      Result:=g_WStateItem2Images.GetCachedImage(idx-5000,ax,ay);
      Exit;
    end else begin
      Result:=g_WStateItemImages.GetCachedImage(idx,ax,ay);
      Exit;
    end;
  end;
 { if ItemImageList.Count > 0 then //20080629
  for I := 0 to ItemImageList.Count - 1 do begin
    WMImage:=TWMImages(ItemImageList.Items[I]);
    if WMImage.Appr = FileIdx then begin
      Result:=WMImage.GetCachedImage(Idx - FileIdx * 10000,ax,ay);
      exit;
    end;
  end;
  //20080910×¢ÊÍ  Ã»µØ·½ÓÃµ½
 { FileName:=ItemImageDir + 'St' + IntToStr(FileIdx) + '.wil';
  if FileExists(FileName) then begin
    WMImage:=TWMImages.Create(nil);
    WMImage.FileName:=FileName;
    WMImage.LibType:=ltUseCache;
    WMImage.DDraw:=DXDraw.DDraw;
    WMImage.Appr:=FileIdx;
    WMImage.Initialize;
    ItemImageList.Add(WMImage);
    Result:=WMImage.GetCachedImage(Idx - FileIdx * 10000,ax,ay);
  end;  }
end;

function TfrmMain.GetWStateImg(Idx: Integer): TDirectDrawSurface;
begin
  Result:=nil;
  if Idx < 10000 then begin
    if Idx > 4999 then begin   //stateitem2.wil
      Result:=g_WStateItem2Images.Images[idx-5000];
      Exit;
    end else begin
      Result:=g_WStateItemImages.Images[idx];
      Exit;
    end;
  end;
  //FileIdx:=Idx div 10000;
  {if ItemImageList.Count > 0 then //20080629
  for I := 0 to ItemImageList.Count - 1 do begin
    WMImage:=TWMImages(ItemImageList.Items[I]);
    if WMImage.Appr = FileIdx then begin
      Result:=WMImage.Images[Idx - FileIdx * 10000]; //È¡ÎïÆ·ËùÔÚIDXÎ»ÖÃ
      exit;
    end;      
  end;
  //20080910×¢ÊÍ  Ã»µØ·½ÓÃµ½
  {FileName:=ItemImageDir + 'St' + IntToStr(FileIdx) + '.wil';
  if FileExists(FileName) then begin
    WMImage:=TWMImages.Create(nil);
    WMImage.FileName:=FileName;
    WMImage.LibType:=ltUseCache;
    WMImage.DDraw:=DXDraw.DDraw;
    WMImage.Appr:=FileIdx;
    WMImage.Initialize;
    ItemImageList.Add(WMImage);
    Result:=WMImage.Images[Idx - FileIdx * 10000]; //È¡ÎïÆ·ËùÔÚIDXÎ»ÖÃ
  end;  }
end;

//»ñÈ¡°ü¹üÎïÆ·Í¼Æ¬
function TfrmMain.GetBagItemImg(Idx:Integer): TDirectDrawSurface;
begin
  Result := nil;
  if Idx < 10000 then begin
    if Idx > 4999 then begin   //Items2.wil
      Result:=g_WBagItem2Images.Images[Idx-5000];
      Exit;
    end else begin
      Result:=g_WBagItemImages.Images[Idx];
      Exit;
    end;
  end;
end;

function TfrmMain.GetBagItemImg(Idx:Integer;var ax,ay:integer): TDirectDrawSurface;
begin
  Result := nil;
  if Idx < 10000 then begin
    if Idx > 4999 then begin   //Items2.wil
      Result:=g_WBagItem2Images.GetCachedImage(idx-5000,ax,ay);
      Exit;
    end else begin
      Result:=g_WBagItemImages.GetCachedImage(idx,ax,ay);
      Exit;
    end;
  end;
end;

function TfrmMain.GetWWeaponImg(Weapon,m_btSex,nFrame:Integer;var ax,ay:integer; NewMode: Boolean): TDirectDrawSurface;
var
  FileIdx:Integer;
begin
  Result:=nil;
  if NewMode then begin
    if Weapon > 199 then
      Result:=g_WCboWeaponImages4.GetCachedImage(NEWHUMANFRAME * (Weapon-200) + nFrame,ax,ay)
    else if Weapon > 149 then //cboweapon3.wil
      Result:=g_WCboWeaponImages3.GetCachedImage(NEWHUMANFRAME * (Weapon-150) + nFrame,ax,ay)
    else if Weapon > 99 then
      Result:=g_WCboWeaponImages.GetCachedImage(NEWHUMANFRAME * (Weapon-24) + nFrame,ax,ay)
    else Result:=g_WCboWeaponImages.GetCachedImage(NEWHUMANFRAME * Weapon + nFrame,ax,ay);
  end else begin //149
    if Weapon > 199 then begin//By TasNat at: 2012-10-14 10:54:03
      FileIdx := (Weapon - 199 - m_btSex) div 2;
      if (FileIdx < 25) then begin
        Result:=g_WWeapon4Images.GetCachedImage(HUMANFRAME * (Weapon - 200) + nFrame,ax,ay);
        Exit;
      end;
    end else
    if Weapon > 149 then begin
      FileIdx := (Weapon - 150 - m_btSex) div 2;
      if (FileIdx < 25) then begin
        Result:=g_WWeapon3Images.GetCachedImage(HUMANFRAME * (Weapon - 150) + nFrame,ax,ay);
        Exit;
      end;
    end else     // 99
    if Weapon > 99 then begin  //weapon2.wil
      FileIdx:=(Weapon - 100 - m_btSex) div 2;
      if (FileIdx < 25) then begin
        Result:=g_WWeapon2Images.GetCachedImage(HUMANFRAME * (Weapon - 100) + nFrame,ax,ay);
        Exit;
      end;
    end else begin             //weapon.wil
      FileIdx:=(Weapon - m_btSex) div 2;
      if (FileIdx < 50) then begin
        Result:=g_WWeaponImages.GetCachedImage(HUMANFRAME * Weapon + nFrame,ax,ay);
        Exit;
      end;
    end;
  end;
  {
  if (FileIdx < 100) then begin
    Result:=g_WWeaponImages.GetCachedImage(HUMANFRAME * Weapon + nFrame,ax,ay);
    exit;
  end; }

  {if WeaponImageList.Count > 0 then //20080629
  for I := 0 to WeaponImageList.Count - 1 do begin
    WMImage:=TWMImages(WeaponImageList.Items[I]);
    if WMImage.Appr = FileIdx then begin
      Result:=WMImage.GetCachedImage(HUMANFRAME * m_btSex + nFrame,ax,ay);
      exit;
    end;
  end;
  //20080910×¢ÊÍ  Ã»µØ·½ÓÃµ½
  {FileName:=WeaponImageDir + IntToStr(FileIdx) + '.wil';
  if FileExists(FileName) then begin
    WMImage:=TWMImages.Create(nil);
    WMImage.FileName:=FileName;
    WMImage.LibType:=ltUseCache;
    WMImage.DDraw:=DXDraw.DDraw;
    WMImage.Appr:=FileIdx;
    WMImage.Initialize;
    WeaponImageList.Add(WMImage);
    Result:=WMImage.GetCachedImage(HUMANFRAME * m_btSex + nFrame,ax,ay);
  end; }
end;

{*******************************************************************************
//¹ý³ÌGetWHumImg ×÷ÓÃ£º»ñÈ¡ÈËÎïÍâ¹Û
//²ÎÊý£ºDress-ÒÂ·þÍâ¹Û m_btSex-ÐÔ±ð nFrame-µ±Ç°èåÊý UseMagic-Ä§·¨²ÎÊý¡£
*******************************************************************************}
function TfrmMain.GetWHumImg(Dress,m_btSex,nFrame:Integer;var ax,ay:integer; UseMagic: TUseMagicInfo; NewMode:Boolean): TDirectDrawSurface;
var
  FileIdx:Integer;
begin
  Result:=nil;
  //if (UseMagic.EffectNumber in [102..113]){¼¼ÄÜ¶ÔÓ¦µÄeffect} and (UseMagic.ServerMagicCode <> 0){ÊÇ·ñÊÇÄ§·¨×´Ì¬} then begin
  if NewMode then begin
    if Dress > 149 then //By TasNat at: 2012-10-14 17:08:54
      Result:=g_WCboHum4ImgImages.GetCachedImage(NEWHUMANFRAME * (Dress-150) + nFrame,ax,ay)  
    else if Dress > 99 then  //cbohum3.wis
      Result:=g_WCboHum3ImgImages.GetCachedImage(NEWHUMANFRAME * (Dress-100) + nFrame,ax,ay)
    else if Dress > 25 then
      Result:=g_WCboHumImgImages.GetCachedImage(NEWHUMANFRAME * (Dress-26) + nFrame,ax,ay)
    else Result:=g_WCboHumImgImages.GetCachedImage(NEWHUMANFRAME * Dress + nFrame,ax,ay);
  end else begin
    if Dress > 149 then begin //Hum4.wil
      FileIdx:=(Dress - 150 - m_btSex) div 2;
      if (FileIdx < 50) then begin
        Result:=g_WHum4ImgImages.GetCachedImage(HUMANFRAME * (Dress - 150) + nFrame,ax,ay);
        exit;
      end;
    end else if (Dress > 99) and (Dress < 150) then begin //Hum3.wil
      FileIdx:=(Dress - 100 - m_btSex) div 2;
      if (FileIdx < 25) then begin
        Result:=g_WHum3ImgImages.GetCachedImage(HUMANFRAME * (Dress - 100) + nFrame,ax,ay);
        exit;
      end;
    end else if (Dress > 49) and (Dress < 100) then begin //Hum2.wil
      FileIdx:=(Dress - 50 - m_btSex) div 2;
      if (FileIdx < 25) then begin
        Result:=g_WHum2ImgImages.GetCachedImage(HUMANFRAME * (Dress - 50) + nFrame,ax,ay);
        exit;
      end;
    end else begin  //Hum.wil
      FileIdx:=(Dress - m_btSex) div 2;
      if (FileIdx < 50) then begin
        Result:=g_WHumImgImages.GetCachedImage(HUMANFRAME * Dress + nFrame,ax,ay);
        exit;
      end;
    end;
  end;
end;

{procedure TfrmMain.ClientGetNeedPassword(Body: String);
begin
  FrmDlg.DChgGamePwd.Visible:=True;
end; }

procedure TfrmMain.SendPassword(sPassword: String;nIdent:Integer);
var
  DefMsg:TDefaultMessage;
begin
   DefMsg:=MakeDefaultMsg (aa(CM_PASSWORD, TempCertification),0,nIdent,0,0, m_nSendMsgCount);
   SendSocket (EncodeMessage(DefMsg) + EncodeString(sPassword));
end;

procedure TfrmMain.SetInputStatus;
begin
  if m_boPasswordIntputStatus then begin
    m_boPasswordIntputStatus:=False;
    PlayScene.EdChat.PasswordChar:=#0;
    PlayScene.EdChat.Visible:=False;
  end else begin
    m_boPasswordIntputStatus:=True;
    PlayScene.EdChat.PasswordChar:='*';
    PlayScene.EdChat.Visible:=True;
    PlayScene.EdChat.SetFocus;
  end;
end;

procedure TfrmMain.ClientGetServerConfig(Msg: TDefaultMessage;sBody: String);
var
  sBody1: string;
begin
  g_DeathColorEffect:=TColorEffect( _MIN(LoByte(msg.Param),8) );  //ÆÁÄ»ËÀÍöÑÕÉ«
  
  //g_boCanRunHuman:=LoByte(LoWord(msg.Recog)) = 1;
  //g_boCanRunMon:=HiByte(LoWord(msg.Recog)) = 1;
  //g_boCanRunNpc:=LoByte(HiWord(msg.Recog)) = 1;
  //g_boCanRunAllInWarZone:=HiByte(HiWord(msg.Recog)) = 1;
  sBody1:=DecodeString(sBody);
  DecodeBuffer(sBody1,@g_ClientConf,SizeOf(g_ClientConf));
  {g_boCanRunHuman        :=ClientConf.boRunHuman; //´©ÈË
  g_boCanRunMon          :=ClientConf.boRunMon; //´©¹Ö
  g_boCanRunNpc          :=ClientConf.boRunNpc; //´©NPC }
  g_boCanRunAllInWarZone :=g_ClientConf.boWarRunAll;//¹¥³ÇÇøÓòÊÇ·ñ´«ÈË´©¹Ö´©NPC

  //g_DeathColorEffect     :=TColorEffect(_MIN(8,ClientConf.btDieColor));
  g_nHitTime             :=g_ClientConf.wHitIime;
  g_dwSpellTime          :=g_ClientConf.wSpellTime;
  g_boSkill31Effect := g_ClientConf.boSkill31Effect;
  g_boCanRunHuman := g_ClientConf.boRUNHUMAN;
  g_boCanRunMon := g_ClientConf.boRUNMON;
  g_boCanRunNpc := g_ClientConf.boRunNpc;
  //g_boSafeAreaLimited := ClientConf.boSafeAreaLimited;//ÊÇ·ñ°²È«Çø²»ÊÜ¿Ø
  //g_boSafe := ClientConf.boInSafeZone; //ÊÇ·ñÎª°²È«Çø
  {$IF M2Version <> 2} //not 1.76
  g_boOpenHero := msg.Tag = 1;
  g_boOpenLeiMei := msg.Series = 1;
  g_boCanTitleUse := HiByte(msg.Param) = 1;
  with FrmDlg do begin
    DBCallHero.Visible := g_boOpenHero;
    DBHeroState.Visible := g_boOpenHero;
    DBHeroPackage.Visible := g_boOpenHero;
    DBCallDeputyHero.Visible := g_boOpenHero;
    DBLingMeiBelt.Visible := g_boOpenLeiMei;
  end;

  // ¿ª·ÅÊ¦ÃÅÏµÍ³ ¿ØÖÆ
  FrmDlg.DBotFaction.Visible:=g_ClientConf.boUseCanDivision; //  liuzhigang by 2011-11-10
  {$ELSE}
  g_boShowNewItem := g_ClientConf.boShowNewItem;
  FrmDlg.DBotMemo.Visible := g_ClientConf.boCanShop;
  g_boShopUseGold := g_ClientConf.boShopUseGold;
  {$IFEND}
  FrmDlg.DBotStall.Visible :=  g_ClientConf.boUsePlayShop;//ÊÇ·ñ¿ª·Å¸öÈËÉÌµê 20100706

  //g_boForceNotViewFog := False; 20080816×¢ÊÍÃâÀ¯
  g_boMagicLock := True;
    //end;
  //end;
end;

procedure TfrmMain.ClientGetServerUnBind(Body: String);
var
   i: integer;
   data: string;
   pcm: pTUnbindInfo;
begin
   if g_UnBindList.Count > 0 then //20080629
   for i:=0 to g_UnBindList.Count-1 do
     if pTUnbindInfo(g_UnBindList[i]) <> nil then
      Dispose (pTUnbindInfo(g_UnBindList[i]));
   g_UnBindList.Clear;
   while TRUE do begin
      if body = '' then break;
      body := GetValidStr3 (body, data, ['/']);
      if data <> '' then begin
         new (pcm);
         DecodeBuffer (data, @(pcm^), sizeof(TUnbindInfo));
         g_UnBindList.Add (pcm);
      end else
         break;
   end;
end;



{ 20080723×¢ÊÍ
procedure TfrmMain.ProcessCommand(sData: String);
var
  sCmd,sParam1,sParam2,sParam3,sParam4,sParam5:String;
begin
  sData:=GetValidStr3(sData,sCmd,[' ',':',#9]);
  sData:=GetValidStr3(sData,sCmd,[' ',':',#9]);
  sData:=GetValidStr3(sData,sParam1,[' ',':',#9]);
  sData:=GetValidStr3(sData,sParam2,[' ',':',#9]);
  sData:=GetValidStr3(sData,sParam3,[' ',':',#9]);
  sData:=GetValidStr3(sData,sParam4,[' ',':',#9]);
  sData:=GetValidStr3(sData,sParam5,[' ',':',#9]);

  if CompareText(sCmd,'ShowHumanMsg') = 0 then begin
    CmdShowHumanMsg(sParam1,sParam2,sParam3,sParam4,sParam5);
    exit;
  end;
end; }
{ 20080723×¢ÊÍ
procedure TfrmMain.CmdShowHumanMsg(sParam1,sParam2,sParam3,sParam4,sParam5: String);
var
  sHumanName:String;
begin
  sHumanName:=sParam1;
  if (sHumanName <> '') and (sHumanName[1] = 'C') then begin
    PlayScene.MemoLog.Clear;
    exit;
  end;

  if sHumanName <> '' then begin
    ShowMsgActor:=PlayScene.FindActor(sHumanName);  
    if ShowMsgActor = nil then begin
      DScreen.AddChatBoardString(format('%sÃ»ÕÒµ½£¡£¡£¡',[sHumanName]),clWhite,clRed);
      exit;
    end;
  end;
  g_boShowMemoLog:=not g_boShowMemoLog;
  PlayScene.MemoLog.Clear;
  PlayScene.MemoLog.Visible:=g_boShowMemoLog;
end;  }

(*
20080723×¢ÊÍ
procedure TfrmMain.ShowHumanMsg(Msg:pTDefaultMessage);
  function GetIdent(nIdent:Integer):String;
  begin
    case nIdent of  
      SM_RUSH       : Result:='SM_RUSH';
      SM_RUSHKUNG   : Result:='SM_RUSHKUNG';
      SM_FIREHIT    : Result:='SM_FIREHIT';
      SM_4FIREHIT   : Result:='SM_4FIREHIT';
      SM_DAILY      : Result:='SM_DAILY'; //20080511
      SM_BACKSTEP   : Result:='SM_BACKSTEP';
      SM_TURN       : Result:='SM_TURN';
      SM_WALK       : Result:='SM_WALK';
      SM_SITDOWN    : Result:='SM_SITDOWN';
      SM_RUN        : Result:='SM_RUN';
      SM_HIT        : Result:='SM_HIT';
      SM_PIXINGHIT  : Result:='SM_PIXINGHIT';//ÅüÐÇ 20080611
      SM_LEITINGHIT : Result:='SM_LEITINGHIT'; //À×öªÒ»»÷Õ½Ê¿Ð§¹û 20080611
      SM_HEAVYHIT   : Result:='SM_HEAVYHIT';
      SM_BIGHIT     : Result:='SM_BIGHIT';
      SM_SPELL      : Result:='SM_SPELL';
      SM_POWERHIT   : Result:='SM_POWERHIT';
      SM_LONGHIT    : Result:='SM_LONGHIT';
      SM_DIGUP      : Result:='SM_DIGUP';
      SM_DIGDOWN    : Result:='SM_DIGDOWN';
      SM_FLYAXE     : Result:='SM_FLYAXE';
      SM_LIGHTING   : Result:='SM_LIGHTING';
      SM_WIDEHIT    : Result:='SM_WIDEHIT';
      SM_ALIVE      : Result:='SM_ALIVE';
      SM_MOVEFAIL   : Result:='SM_MOVEFAIL';
      SM_HIDE       : Result:='SM_HIDE';
      SM_DISAPPEAR  : Result:='SM_DISAPPEAR';
      SM_STRUCK     : Result:='SM_STRUCK';
      SM_DEATH      : Result:='SM_DEATH';
      SM_SKELETON   : Result:='SM_SKELETON';
      SM_NOWDEATH   : Result:='SM_NOWDEATH';
      SM_CRSHIT     : Result:='SM_CRSHIT';
      SM_TWINHIT    : Result:='SM_TWINHIT';//¿ªÌìÕ¶ÖØ»÷
      SM_QTWINHIT   : Result:='SM_QTWINHIT';//¿ªÌìÕ¶Çá»÷
      SM_CIDHIT     : Result:='SM_CIDHIT';//ÁúÓ°½£·¨
      SM_HEAR           : Result:='SM_HEAR';
      SM_FEATURECHANGED : Result:='SM_FEATURECHANGED';
      SM_USERNAME          : Result:='SM_USERNAME';
      SM_WINEXP            : Result:='SM_WINEXP';
      SM_LEVELUP           : Result:='SM_LEVELUP';
      SM_DAYCHANGING       : Result:='SM_DAYCHANGING';
      SM_ITEMSHOW          : Result:='SM_ITEMSHOW';
      SM_ITEMHIDE          : Result:='SM_ITEMHIDE';
      SM_MAGICFIRE         : Result:='SM_MAGICFIRE';
      SM_CHANGENAMECOLOR   : Result:='SM_CHANGENAMECOLOR';
      SM_CHARSTATUSCHANGED : Result:='SM_CHARSTATUSCHANGED';

      SM_SPACEMOVE_HIDE    : Result:='SM_SPACEMOVE_HIDE';
      SM_SPACEMOVE_SHOW    : Result:='SM_SPACEMOVE_SHOW';
      SM_SHOWEVENT         : Result:='SM_SHOWEVENT';
      SM_HIDEEVENT         : Result:='SM_HIDEEVENT';
      else Result:=IntToStr(nIdent);
    end;
  end;
begin
  {if (ShowMsgActor = nil) or (ShowMsgActor <> nil) and (ShowMsgActor.m_nRecogId = Msg.Recog) then begin
    sLineText:=format('ID:%d Ident:%s',[Msg.Recog,GetIdent(Msg.Ident)]);
    PlayScene.MemoLog.Lines.Add(sLineText);

  end;}

end;
*)
procedure TfrmMain.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  pm: PTClientMagic;
begin
  case Key of
    VK_ESCAPE: begin//ESC        20080314
      if g_boShowAllItem then g_boShowAllItem := False;    //ËÉ¿ªESC¼ü
    end;
  end;

  if (Key >= 112) and (Key < 119) and g_boAutoMagic then begin
      pm:=GetMagicByKey(char(key-Vk_F1 + byte('1')));
      //×Ô¶¯Á·¹¦
      if pm.Def.wMagicId in [12,25] then Exit;
      g_nAutoMAgicKey := Key;
      DScreen.AddChatBoardString('×Ô¶¯Á·¹¦¿ªÊ¼ (ÔÙ°´Ò»ÏÂÕâ¸öÄ§·¨µÄ¿ì½Ý½¡Í£Ö¹×Ô¶¯Á·¹¦)', clGreen, clWhite);
    //end;
    //AutoMagicTimeup := False;
  end;
end;
{******************************************************************************}
//×Ô¶¯»»¶¾  20080315
procedure TFrmMain.TurnDuFu(pcm: PTClientMagic);
var
  s: TClientItem;
  Str,str1: string;
  i,index: Integer;
  RedDu, LimeDu: Boolean;
begin
  RedDu := False;
  LimeDu := False;
  //¼ì²é°ü¹üÀïÓÐÊ²Ã´¶¾
  if g_WaitingUseItem.Item.S.Name <> '' then Exit;
  for I:=6 to MAXBAGITEMCL - 1 do begin
    if (g_ItemArr[i].Item.s.StdMode = 25) and (g_ItemArr[i].Item.s.Name <> '') then begin
      if g_ItemArr[i].Item.s.Shape = 1 then LimeDu := True
      else if g_ItemArr[i].Item.s.Shape = 2 then begin
        RedDu := True;
      end;
    end;
  end;
  {$IF M2Version <> 2} 
  index:=U_BUJUK;
  {$ELSE}//1.76
  index:=U_ARMRINGL;
  {$IFEND}
  s := g_UseItems[Index];
  if not LimeDu and not RedDu then Exit;
  if (pcm.Def.wMagicId = 6) or (pcm.Def.wMagicId = 38) or (pcm.Def.wMagicId = 93) then begin
    Str := 'Ò©';
    if LimeDu and RedDu then begin //Èç¹û2ÖÖ¶¾¶¼´æÔÚ
      if g_nDuwhich=0 then begin
        str1:='»Æ';
        g_nDuwhich:=1;
      end else begin
        str1:='»Ò';
        g_nDuwhich:=0;
      end
    end else begin
      if LimeDu then begin
        str1:='»Ò';
        g_nDuwhich:=0;
      end else if RedDu then begin
        str1:='»Æ';
        g_nDuwhich:=1;
      end;
    end;
  end else Exit;
  if (s.s.StdMode = 25) and (Pos(Str1, s.s.Name) > 0) then Exit; //Èç¹ûÊÇÏàÍ¬µÄ¶¾»ò·û¾ÍÍË³ö
  {if (g_UseItems[U_ARMRINGL].s.StdMode = 25) and (Pos(Str, g_UseItems[U_ARMRINGL].s.Name) > 0) then begin
    SendTakeOffItem (U_ARMRINGL, g_UseItems[U_ARMRINGL].MakeIndex, g_UseItems[U_ARMRINGL].S.Name);
    g_WaitingUseItem.Item := g_UseItems[U_ARMRINGL];
    g_UseItems[U_ARMRINGL].s.Name := '';
    ArrangeItembag;
  end;     }
  g_WaitingUseItem.Index := index;
  for i := 6 to MAXBAGITEMCL - 1 do begin
    if (g_ItemArr[i].Item.s.StdMode = 25) and (str1 <> '') and (Pos(Str, g_ItemArr[i].Item.s.Name) > 0)and (Pos(Str1, g_ItemArr[i].Item.s.Name) > 0) then begin
      SendTakeOnItem(g_WaitingUseItem.Index ,g_ItemArr[i].Item.MakeIndex, g_ItemArr[i].Item.s.Name);
      g_WaitingUseItem.Item := g_ItemArr[i].Item;
      g_4LeveDuShape := g_ItemArr[i].Item.s.Shape;
      g_ItemArr[i].Item.s.Name := '';
      ArrangeItembag;
      Exit;
    end;
  end;
end;
{******************************************************************************}
//À¹½ØTAB¼ü ÏûÏ¢  20080314
procedure TfrmMain.CMDialogKey(var msg: TCMDialogKey);
begin
    case msg.Charcode of
      VK_TAB: begin
        if (FrmDlg.DNewAccount.Visible) or (FrmDlg.DChgPw.Visible) then inherited;
      end;
      else inherited;
    end;
    {
    else
    if msg.Charcode <> VK_TAB then
    inherited;}
end;

//Ôª±¦¼ÄÊÛÏÔÊ¾´°¿Ú 20080316
procedure TfrmMain.ClientGetSendUserSellOff (merchant: integer);
begin
   FrmDlg.CloseMDlg;
   FrmDlg.CloseMBigDlg;
   g_nCurMerchant := merchant;
   FrmDlg.ShowShopSellOffDlg;
end;
//¿Í»§¶Ë¼ÄÊÛ²éÑ¯¹ºÂòÎïÆ· 20080317
procedure TfrmMain.ClientGetSellOffMyItem (body: string);
begin
  FillChar (g_SellOffInfo, sizeof(TClientDealOffInfo), #0); //Çå¿Õ¼ÄÊÛÁÐ±íÎïÆ· 20080318
  DecodeBuffer (body, @g_SellOffInfo, sizeof(TClientDealOffInfo));
  FrmDlg.ShowSellOffListDlg;
  FrmDlg.DSellOffBuyCancel.Visible := True;
  FrmDlg.DSellOffBuy.Visible := True;
end;
//¿Í»§¶Ë¼ÄÊÛ²éÑ¯³öÊÛÎïÆ· 20080317
procedure TfrmMain.ClientGetSellOffSellItem (body: string);
begin
  FillChar (g_SellOffInfo, sizeof(TClientDealOffInfo), #0); //Çå¿Õ¼ÄÊÛÁÐ±íÎïÆ· 20080318
  DecodeBuffer (body, @g_SellOffInfo, sizeof(TClientDealOffInfo));
  FrmDlg.ShowSellOffListDlg;
  FrmDlg.DSellOffListCancel.Visible := True;
end;
{******************************************************************************}

procedure TfrmMain.SendItemUpOK();
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (aa(CM_REFINEITEM, TempCertification), 0, 0, 0, 0, m_nSendMsgCount);
   SendSocket (EncodeMessage (msg) + EncodeString (IntToStr(g_ItemsUpItem[0].MakeIndex) + '/' + IntToStr(g_ItemsUpItem[1].MakeIndex) + '/' + IntToStr(g_ItemsUpItem[2].MakeIndex)));
end;
//¸üÐÂ´âÁ·ÎïÆ·! 20080507
procedure TfrmMain.ClientGetUpDateUpItem (body: string);
var
  cu: TClientItem;
  I: Integer;
  str: string;
begin
  FillChar (g_ItemsUpItem, sizeof(TClientItem)*3, #0); //Çå¿Õ´ãÁ¶¸ñÀïµÄÎïÆ·
  while TRUE do begin
    if body = '' then break;
    for I:=Low(g_ItemsUpItem) to High(g_ItemsUpItem) do begin
      body := GetValidStr3 (body, str, ['/']);
      DecodeBuffer (str, @cu, sizeof(TClientItem));
      g_ItemsUpItem[I] := cu;
    end;
  end;
end;
{******************************************************************************}
procedure TfrmMain.ClientGetHeroInfo(body: string);
var
  cu: THeroDataInfo;
  I: Integer;
  str: string;
begin
  FillChar (g_GetHeroData, sizeof(THeroDataInfo)*2,#0);  //20080514
  while TRUE do begin
    if body = '' then break;
    for I:=Low(g_GetHeroData) to High(g_GetHeroData) do begin
      body := GetValidStr3 (body, str, ['/']);
      DecodeBuffer (str, @cu, sizeof(THeroDataInfo));
      g_GetHeroData[I] := cu;
    end;
  end;
end;
//·¢ËÍÈ¡»ØÓ¢ÐÛÐÅÏ¢ ·¢ËÍµ½M2 20080514
procedure TfrmMain.SendSelHeroName(btType: Byte;SelHeroName: string);
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (aa(CM_SELGETHERO, TempCertification), btType, 0, 0, 0, m_nSendMsgCount);
   SendSocket (EncodeMessage (msg) + EncodeString(SelHeroName));
end;
//Çë¾Æ
procedure TfrmMain.ClientGetSendUserPlayDrink(merchant: integer);
begin
   FrmDlg.CloseDSellDlg;
   g_nCurMerchant := merchant;
   FrmDlg.SpotDlgMode := dmPlayDrink;
   FrmDlg.ShowShopSellDlg;
end;

//·¢ËÍÒª´æ·ÅµÄÎïÆ·
procedure TfrmMain.SendPlayDrinkItem (merchant, itemindex: integer; itemname: string);
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (aa(CM_USERPLAYDRINKITEM, TempCertification), merchant, Loword(itemindex), Hiword(itemindex), 0, m_nSendMsgCount);
   SendSocket (EncodeMessage (msg) + EncodeString (itemname));
end;

//½ÓÊÕ¶·¾ÆËµµÄ»°
procedure TfrmMain.ClientGetPlayDrinkSay (merchant, Who: integer; saying: string);
begin
   if g_nCurMerchant <> merchant then begin
      g_nCurMerchant := merchant;
   end;

   FrmDlg.ShowPlayDrink (Who, saying);
end;

procedure TfrmMain.SendPlayDrinkDlgSelect (merchant: integer; rstr: string);
var
   msg: TDefaultMessage;
   I: Integer;
   sData: string;
begin
   if Length(rstr) >= 2 then begin
      if (rstr[1] = '@') and (rstr[2] = '@') and (rstr[3] = '@') then begin
          FrmMain.ClientGetPlayDrinkSay(g_nCurMerchant,2,'ÕâÌ³¾Æ¸øË­ºÈºÃÄØ£¿');
         if rstr = '@@@¶Ô·½' then
            SendDrinkUpdateValue(g_nCurMerchant, 1, 1);
         if rstr = '@@@×Ô¼º' then
            SendDrinkUpdateValue(g_nCurMerchant, 0, 1);
         if g_btPlaySelDrink = 0 then begin
            FrmDlg.DDrink1.Visible := False;
         end;
         if g_btPlaySelDrink = 1 then begin
            FrmDlg.DDrink2.Visible := False;
         end;
         if g_btPlaySelDrink = 2 then begin
            FrmDlg.DDrink4.Visible := False;
         end;
         if g_btPlaySelDrink = 3 then begin
            FrmDlg.DDrink6.Visible := False;
         end;
         if g_btPlaySelDrink = 4 then begin
            FrmDlg.DDrink5.Visible := False;
         end;
         if g_btPlaySelDrink = 5 then begin
            FrmDlg.DDrink3.Visible := False;
         end;
            if g_NpcRandomDrinkList.Count > 0 then //20080629
            for I:= 0 to g_NpcRandomDrinkList.Count - 1 do begin
                if Integer(g_NpcRandomDrinkList[I]) = g_btPlaySelDrink then begin
                  g_NpcRandomDrinkList.Delete(I);
                  Break;
                end;
            end;
      end else if FrmDlg.DMerchantDlgSelect(rstr, '', sData) then begin
         msg := MakeDefaultMsg (aa(CM_PlAYDRINKDLGSELECT, frmMain.TempCertification), merchant, 0, 0, 0, m_nSendMsgCount);
         SendSocket (EncodeMessage (msg) + EncodeString (sData));
      end;
   end;
end;

//·¢ËÍ²ÂÈ­ÂëÊý
procedure TfrmMain.SendPlayDrinkGame (nParam1,GameNum: integer);
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (aa(CM_PlAYDRINKGAME, TempCertification), nParam1, GameNum, 0, 0, m_nSendMsgCount);
   SendSocket (EncodeMessage (msg) + '');
end;
//ºÈ¾Æ²¢Ôö¼Ó×í¾ÆÖµ 20080517
//²ÎÊý:nPlayNum--Ë­ºÈ¾Æ(0-Íæ¼ÒºÈ 1-NPCºÈ)  nCode--Ë­Ó®(0-NPC 1-Íæ¼Ò)
//²ÎÊý:nParam1--ÎªNPC IDºÅ
procedure TFrmMain.SendDrinkUpdateValue(nParam1: Integer; nPlayNum,nCode: Byte);
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (aa(CM_DrinkUpdateValue, TempCertification), nParam1, nPlayNum, nCode, 0, m_nSendMsgCount);
   SendSocket (EncodeMessage (msg) + '');
end;

procedure TfrmMain.SendDrinkDrinkOK();
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (aa(CM_USERPLAYDRINK, TempCertification), 0, 0, 0, 0, m_nSendMsgCount);
   SendSocket (EncodeMessage (msg) + EncodeString (IntToStr(g_nCurMerchant) + '/' + IntToStr(g_PDrinkItem[0].MakeIndex) + '/' + IntToStr(g_PDrinkItem[1].MakeIndex)));
end;
procedure TfrmMain.CloseTimerTimer(Sender: TObject);
begin
  CloseTimer.Enabled := False;
  if (g_ConnectionStep = cnsLogin) and not g_boSendLogin then begin
     FrmDlg.DMessageDlg ('·þÎñÆ÷¹Ø±Õ»òÍøÂç²»ÎÈ¶¨,ÇëÁªÏµ¹Ù·½¿Í·þÈËÔ±!!', [mbOk]);
     Close;
   end;
end;
{******************************************************************************}
//¹ØÏµÏµÍ³
procedure TfrmMain.LoadFriendList();
var
  I: Integer;
  LoadList: TStringList;
  sFileName: string;
  sDir: string;
begin
  try
    if CharName = '' then Exit;
    if not DirectoryExists(g_ParamDir+'config') then  CreateDir(g_ParamDir+'config');
    sDir := g_ParamDir+format('config\Ly%s_%s',[g_sServerName,CharName]);
    if not DirectoryExists(sDir) then CreateDir(sDir);

    sFileName := sDir+'\Friend.txt';
    LoadList := TStringList.Create;
    if FileExists(sFileName) then begin
        g_FriendList.Clear;
        LoadList.LoadFromFile(sFileName);
        if LoadList.Count > 0 then //20080629
        for I := 0 to LoadList.Count - 1 do begin
          g_FriendList.Add(Trim(LoadList.Strings[I]));
        end;
    end else begin
      LoadList.SaveToFile(sFileName);
    end;
    LoadList.Free;
  except
    DebugOutStr ('TfrmMain.LoadFriendList');
  end;
end;

procedure TfrmMain.LoadHeiMingDanList();
var
  I: Integer;
  LoadList: TStringList;
  sFileName: string;
  sDir: string;
begin
  try
    if CharName = '' then Exit;
    if not DirectoryExists(g_ParamDir+'config') then  CreateDir(g_ParamDir+'config');
    sDir := g_ParamDir+format('config\Ly%s_%s',[g_sServerName,CharName]);
    if not DirectoryExists(sDir) then
      CreateDir(sDir);

    sFileName := sDir+'\HeiMingDan.txt';
    LoadList := TStringList.Create;
    if FileExists(sFileName) then begin
        g_HeiMingDanList.Clear;
        LoadList.LoadFromFile(sFileName);
        if LoadList.Count > 0 then //20080629
        for I := 0 to LoadList.Count - 1 do begin
          g_HeiMingDanList.Add(Trim(LoadList.Strings[I]));
        end;
    end else begin
      LoadList.SaveToFile(sFileName);
    end;
    LoadList.Free;
  except
    DebugOutStr ('TfrmMain.LoadHeiMingDanList');
  end;
end;

procedure TfrmMain.LoadTargetList;
var
  I: Integer;
  LoadList: TStringList;
  sFileName: string;
  sDir: string;
begin
  try
    if CharName = '' then Exit;
    if not DirectoryExists(g_ParamDir+'config') then  CreateDir(g_ParamDir+'config');
    sDir := g_ParamDir+format('config\Ly%s_%s',[g_sServerName,CharName]);
    if not DirectoryExists(sDir) then CreateDir(sDir);
    sFileName := sDir+'\Target.txt';
    LoadList := TStringList.Create;
    if FileExists(sFileName) then begin
        g_TargetList.Clear;
        LoadList.LoadFromFile(sFileName);
        if LoadList.Count > 0 then //20080629
        for I := 0 to LoadList.Count - 1 do begin
          g_TargetList.Add(Trim(LoadList.Strings[I]));
        end;
    end else begin
      LoadList.SaveToFile(sFileName);
    end;
    LoadList.Free;
  except
    DebugOutStr ('TfrmMain.LoadTargetList');
  end;
end;

procedure TfrmMain.SaveTargetList;
var
  I: Integer;
  SaveList: TStringList;
  sFileName: string;
  sDir: string;
begin
  try
    if CharName = '' then Exit;
    if not DirectoryExists(g_ParamDir+'config') then  CreateDir(g_ParamDir+'config');
    sDir := g_ParamDir+format('config\Ly%s_%s',[g_sServerName,CharName]);
    if not DirectoryExists(sDir) then CreateDir(sDir);
    //Result := False;
    sFileName := sDir+'\Target.txt';
    SaveList := TStringList.Create;
    if g_TargetList.Count > 0 then //20080629
    for I := 0 to g_TargetList.Count - 1 do begin
      SaveList.Add(g_TargetList.Strings[I]);
    end;
    SaveList.SaveToFile(sFileName);
    SaveList.Free;
    //Result := True;
  except
    DebugOutStr ('TfrmMain.SaveTargetList');
  end;
end;

function TfrmMain.InTargetListOfName(sUserName: string): Boolean;
begin
  Result := False;
  if g_TargetList.Count > 0 then begin
    if g_TargetList.Indexof(sUserName) > -1 then Result := True;
  end;
end;

//´¢´æºÃÓÑÃûµ¥
procedure TfrmMain.SaveFriendList();
var
  I: Integer;
  SaveList: TStringList;
  sFileName: string;
  sDir: string;
begin
  try
    if CharName = '' then Exit;
    if not DirectoryExists(g_ParamDir+'config') then  CreateDir(g_ParamDir+'config');
    sDir := g_ParamDir+format('config\Ly%s_%s',[g_sServerName,CharName]);
    if not DirectoryExists(sDir) then CreateDir(sDir);
    //Result := False;
    sFileName := sDir+'\Friend.txt';
    SaveList := TStringList.Create;
    if g_FriendList.Count > 0 then //20080629
    for I := 0 to g_FriendList.Count - 1 do begin
      SaveList.Add(g_FriendList.Strings[I]);
    end;
    SaveList.SaveToFile(sFileName);
    SaveList.Free;
    //Result := True;
  except
    DebugOutStr ('TfrmMain.SaveFriendList');
  end;
end;
//´¢´æºÚÃûµ¥
procedure TfrmMain.SaveHeiMingDanList();
var
  I: Integer;
  SaveList: TStringList;
  sFileName: string;
  sDir: string;
begin
  try
    if CharName = '' then Exit;
    if not DirectoryExists(g_ParamDir+'config') then  CreateDir(g_ParamDir+'config');
    sDir := g_ParamDir+format('config\Ly%s_%s',[g_sServerName,CharName]);
    if not DirectoryExists(sDir) then CreateDir(sDir);
    //Result := False;
    sFileName := sDir+'\HeiMingDan.txt';
    SaveList := TStringList.Create;
    if g_HeiMingDanList.Count > 0 then //20080629
    for I := 0 to g_HeiMingDanList.Count - 1 do begin
      SaveList.Add(g_HeiMingDanList.Strings[I]);
    end;
    SaveList.SaveToFile(sFileName);
    SaveList.Free;
    //Result := True;
  except
    DebugOutStr ('TfrmMain.SaveHeiMingDanList');
  end;
end;
//¼ì²éºÚÃûµ¥ÀïÊÇ·ñ´æÔÚÕâ¸öÈËµÄÃû×Ö
function TfrmMain.InHeiMingDanListOfName(sUserName: string): Boolean;
{var
  I: Integer; }
begin
  Result := False;
  {if g_HeiMingDanList.Count > 0 then //20080629
  for I := 0 to g_HeiMingDanList.Count - 1 do begin
    if CompareText(sUserName, g_HeiMingDanList.Strings[I]) = 0 then begin
      Result := TRUE;
      break;
    end;
  end; }
  if g_HeiMingDanList.Count > 0 then begin
    if g_HeiMingDanList.Indexof(sUserName) > -1 then Result := True;

    {for I := 0 to g_HeiMingDanList.Count - 1 do begin
      if CompareText(sUserName, g_HeiMingDanList.Strings[I]) = 0 then begin
        Result := TRUE;
        break;
      end;
    end;}
  end;
end;
//¼ì²éºÃÓÑÀïÊÇ·ñ´æÔÚÕâ¸öÈËµÄÃû×Ö
function TfrmMain.InFriendListOfName(sUserName: string): Boolean;
begin
  Result := False;
  if g_FriendList.Count > 0 then begin
    if g_FriendList.Indexof(sUserName) > -1 then Result := True;
  end;
end;
{******************************************************************************}
procedure TfrmMain.TimerBrowserUpdateTimer(Sender: TObject);
begin
  {TimerBrowserUpdate.Enabled := False;
  if frmBrowser.Showing then begin
    FrmBrowser.Visible := False;
    FrmBrowser.Visible := True;
    FrmBrowser.SetFocus;
  end; }
  if Video <> nil then begin
    if Video.GetState = 2 then begin
      if VIdeo.GetPosition >= VIdeo.GetStopPosition then begin
        TimerBrowserUpdate.Enabled := False;
        Video.Stop;
      end;
    end else if Video.GetState = 0 then begin
      TimerBrowserUpdate.Enabled := False;
      Video.Stop;
    end;
  end;
end;

procedure TfrmMain.TimerGateCheckTimer(Sender: TObject);
begin

end;

{******************************************************************************}
//Ó¢ÐÛ¼¼ÄÜ¿ª¹Ø
procedure TfrmMain.SendHeroMagicKeyChange (magid: integer; keych: char; str: string);
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (aa(CM_HEROMAGICKEYCHANGE, TempCertification), magid, byte(keych), 0, 0, m_nSendMsgCount);
   if str <> '' then SendSocket (EncodeMessage (msg)+str)
   else SendSocket (EncodeMessage (msg));
end;
{******************************************************************************}
//ÑéÖ¤ÂëÏà¹Ø
procedure TfrmMain.GetCheckNum();
var
  I,o,p:   Integer;
  vPoint:   TPoint;
  vLeft:   Integer;
  img: Timage; //20080612
begin
  try
    img := Timage.Create(FrmMain.Owner);
    try
    img.Width := 80;
    img.Height := 40;
    with img.Canvas do begin
      vLeft:=10;
      for o := 0 to 80 -1 do begin
        for p := 0 to 40 - 1 do begin
          Pixels[ o, p] := $00ADC6D6{RGB(Random(256) and $C0,
          Random(256) and $C0,Random(256) and $C0)};
        end;
      end;
      for I:= 1 to Length(g_pwdimgstr) do begin
        Font.Size := Random(10)+ 10;
        Font.Color := clBlack;
        case Random(3) of//Ëæ»ú×ÖÌå
          0: Font.Style := [fsBold];
          1: Font.Style := [fsBold,fsUnderline];
          2: Font.Style := [fsBold,fsUnderline,fsUnderline];
        end;
        vPoint.X := Random(4)+ vLeft;
        vPoint.Y := Random(5)+2;
        //Canvas.Font.Name := Screen.Fonts[10];
        SetBkMode (Handle, TRANSPARENT);
        TextOut(vPoint.X, vPoint.Y,g_pwdimgstr[I]);
        vLeft := vPoint.X + Canvas.TextWidth(g_pwdimgstr[I])+8;
      end;

      Font.Size := 9;
      Font.Style := [];  //×ÖÌåÈ¥µô´ÖÌå
    end;
       //img.Picture.Bitmap.PixelFormat := pf8bit;
    if img.Picture.Bitmap <> nil then begin
     UiDxImageList.Items[35].Picture.Bitmap := img.Picture.Bitmap;
     UiDxImageList.Items[35].Restore;
    end;
    finally
     img.Free;
    end;
  except
    DebugOutStr ('TfrmMain.GetCheckNum');
  end;
end;
//UpperCaseÎª×ª»»³É´óÐ´
procedure TfrmMain.SendCheckNum (num: string);
var
   msg: TDefaultMessage;
begin
   if num = '' then Exit;
   num := Encrypt(num, GetAdoSouse(UpperCase(num)));
   msg := MakeDefaultMsg (CM_CHECKNUM, 0, 0, 0, 0, m_nSendMsgCount);
   SendSocket (EncodeMessage (msg) + EncodeString(num));
end;

procedure TfrmMain.SendChangeCheckNum();
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (CM_CHANGECHECKNUM, 0, 0, 0, 0, m_nSendMsgCount);
   SendSocket (EncodeMessage (msg));
end;
{******************************************************************************}
procedure TfrmMain.AutoFindPathTimerTimer(Sender: TObject);
var
  I, tdir, dx, dy: Integer;
  pt: TPoint;
begin
  if g_MySelf = nil then begin
    LegendMap.Stop;
    AutoFindPathTimer.Enabled := False;
    Exit;
  end;
  if (g_MySelf <> nil) and g_MySelf.m_boDeath then begin
    LegendMap.Stop;
    AutoFindPathTimer.Enabled := False;
    Exit;
  end;

  if LegendMap.StartFind then begin
    if (abs(g_MySelf.m_nCurrX - LegendMap.EndX) <= 1) and (abs(g_MySelf.m_nCurrY - LegendMap.EndY) <= 1) then begin
      DScreen.AddChatBoardString(Format('×Ô¶¯ÒÆ¶¯×ø±êµã(%d:%d)ÒÑµ½´ï', [LegendMap.EndX, LegendMap.EndY]), GetRGB(168), clWhite);
      LegendMap.Stop;
      AutoFindPathTimer.Enabled := False;
    end else begin
      if ((not g_MySelf.FindMsg(CM_WALK)) and (not g_MySelf.FindMsg(CM_RUN))) and ((g_MySelf.m_nCurrX <> LegendMap.BeginX) or (g_MySelf.m_nCurrY <> LegendMap.BeginY)) then begin
        Map.LoadMapPathArr(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY);
        LegendMap.FindPath(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, LegendMap.EndX, LegendMap.EndY);
        if Length(LegendMap.Path) <= 0 then begin
          DScreen.AddChatBoardString(Format('×Ô¶¯ÒÆ¶¯×ø±êµã(%d:%d)²»¿Éµ½´ï', [LegendMap.EndX, LegendMap.EndY]), GetRGB(168), clWhite);
          LegendMap.Stop;
          AutoFindPathTimer.Enabled := False;
        end else begin
          //DScreen.AddChatBoardString('--------------------------------------', clGreen, clWhite);
          //DScreen.AddChatBoardString(Format('MySelf×ø±êµã£¨%d:%d£©', [g_MySelf.m_nCurrX, g_MySelf.m_nCurrY]), clGreen, clWhite);
          //DScreen.AddChatBoardString('--------------------------------------', clGreen, clWhite);
         { for I := 0 to Length(LegendMap.Path) - 1 do begin
            DScreen.AddChatBoardString(Format('×ø±êµã£¨%d:%d£©', [LegendMap.Path[I].X, LegendMap.Path[I].Y]), clGreen, clWhite);
          end; }
          for I := 0 to Length(LegendMap.Path) - 1 do begin
            if (g_MySelf.m_nCurrX <> LegendMap.Path[I].X) or (g_MySelf.m_nCurrY <> LegendMap.Path[I].Y) then begin

              if (abs(g_MySelf.m_nCurrX - LegendMap.Path[I].X) <= 1) and (abs(g_MySelf.m_nCurrY - LegendMap.Path[I].Y) <= 1) then
                g_ChrAction := caWalk
              else g_ChrAction := caRun;

              g_nTargetX := LegendMap.Path[I].X;
              g_nTargetY := LegendMap.Path[I].Y;
              g_dwAutoFindPathTick := GetTickCount;
              Break;
            end;
          end;
        end;
      end else begin
        if GetTickCount - g_dwAutoFindPathTick > 200 then begin
          g_dwAutoFindPathTick := GetTickCount;
          //Map.LoadMapPathArr(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY);
          //LegendMap.FindPath(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, LegendMap.EndX, LegendMap.EndY);
          if Length(LegendMap.Path) <= 0 then begin
            DScreen.AddChatBoardString(Format('×Ô¶¯ÒÆ¶¯×ø±êµã(%d:%d)²»¿Éµ½´ï', [LegendMap.EndX, LegendMap.EndY]), GetRGB(168), clWhite);
            LegendMap.Stop;
            AutoFindPathTimer.Enabled := False;
          end else begin
            for I := 0 to Length(LegendMap.Path) - 1 do begin
              if (g_MySelf.m_nCurrX <> LegendMap.Path[I].X) or (g_MySelf.m_nCurrY <> LegendMap.Path[I].Y) then begin

                if (abs(g_MySelf.m_nCurrX - LegendMap.Path[I].X) <= 1) and (abs(g_MySelf.m_nCurrY - LegendMap.Path[I].Y) <= 1) then begin
                  g_ChrAction := caWalk;
                  //DScreen.AddChatBoardString('g_ChrAction := caWalk', clGreen, clWhite);
                end else begin
                  g_ChrAction := caRun;
                  //DScreen.AddChatBoardString('g_ChrAction := caRun', clGreen, clWhite);
                end;
                g_nTargetX := LegendMap.Path[I].X;
                g_nTargetY := LegendMap.Path[I].Y;

                Break;
              end;
            end;
          end;
        end;
      end;
    end;
  end else AutoFindPathTimer.Enabled := False;
end;


{******************************************************************************}
//ÄÚ¹Ò¼ì²éÊÇ·ñÓÐÕâÄ§·¨
//¸ù¾Ý¿ì½Ý¼ü£¬²éÕÒ¶ÔÓ¦µÄÄ§·¨
function  TfrmMain.GetMagicByID (Id: Byte): Boolean;
var
   i: integer;
   pm: PTClientMagic;
begin
   Result := False;
   if g_MagicList.Count > 0 then //20080629
   for i:=0 to g_MagicList.Count-1 do begin
      pm := PTClientMagic (g_MagicList[i]);
      if pm.Def.wMagicId = Id then begin
         Result := True;
         break;
      end;
   end;
end;
{******************************************************************************}
//¾Æ¹Ý2¾í                            //0ÎªÆÕÍ¨¾Æ£¬1ÎªÒ©¾Æ
procedure TfrmMain.SendMakeWineItems();
var
   msg: TDefaultMessage;
   sstr: string;
   TypeWine: Byte;
begin
   sstr := '';
   if g_MakeTypeWine = 0 then begin //ÆÕÍ¨¾Æ
     if (g_WineItem[0].s.Name = '') or (g_WineItem[2].s.Name = '') or (g_WineItem[3].s.Name = '')
        or (g_WineItem[4].s.Name = '') or (g_WineItem[5].s.Name = '') or (g_WineItem[6].s.Name = '') then Exit;
       if g_WineItem[1].s.Name = '' then //ÅÐ¶Ï¾ÆÇúÊÇ·ñÎª¿Õ
          sstr := IntToStr(g_WineItem[0].MakeIndex) + '/' + '0/' + IntToStr(g_WineItem[2].MakeIndex) + '/' + IntToStr(g_WineItem[3].MakeIndex) + '/' +
          IntToStr(g_WineItem[4].MakeIndex) + '/' + IntToStr(g_WineItem[5].MakeIndex) + '/' + IntToStr(g_WineItem[6].MakeIndex)
       else
          sstr := IntToStr(g_WineItem[0].MakeIndex) + '/' + IntToStr(g_WineItem[1].MakeIndex) + '/' + IntToStr(g_WineItem[2].MakeIndex) + '/' + IntToStr(g_WineItem[3].MakeIndex) + '/' +
          IntToStr(g_WineItem[4].MakeIndex) + '/' + IntToStr(g_WineItem[5].MakeIndex) + '/' + IntToStr(g_WineItem[6].MakeIndex);
     TypeWine := 0;
   end else begin
      if (g_DrugWineItem[0].s.Name = '') or (g_DrugWineItem[1].s.Name = '') or (g_DrugWineItem[2].s.Name = '') then Exit;
      sstr := IntToStr(g_DrugWineItem[0].MakeIndex) + '/' + IntToStr(g_DrugWineItem[1].MakeIndex) + '/' + IntToStr(g_DrugWineItem[2].MakeIndex);
      TypeWine := 1;
   end;
   msg := MakeDefaultMsg (aa(CM_BEGINMAKEWINE, TempCertification), 0, 0, 0, TypeWine, m_nSendMsgCount);
   SendSocket (EncodeMessage (msg) + EncodeString (sstr));
end;

procedure TfrmMain.OpenSdoAssistant;
begin
  FrmDlg.DWNewSdoAssistant.Visible:= not FrmDlg.DWNewSdoAssistant.Visible;
  if not FrmDlg.DWNewSdoAssistant.Visible then begin
    
    ReleaseDFocus;
  end else begin
    PlayScene.EdChat.Visible := False;
  end;
end;

procedure TfrmMain.ActCallHeroKeyExecute(Sender: TObject);
var
 msgs: TDefaultMessage;
 target: TActor;
 sel: Integer;
begin
  {$IF M2Version = 1}
  if Sender = ActSeriesKillKey then begin
    if UseBatterSpell(g_nMouseX, g_nMouseY) then g_boCanUseBatter := False;
    Exit;
  end;
  {$IFEND}
  if Sender = ActCallHeroKey then begin
    if FrmDlg.DBCallHero.ShowHint then
      msgs := MakeDefaultMsg (aa(CM_RECALLHERO, TempCertification), 0, 0, 0, 0, m_nSendMsgCount) //ÕÙ»½Ó¢ÐÛ
    else msgs := MakeDefaultMsg (aa(CM_HEROLOGOUT, TempCertification), 0, 0, 0, 0, m_nSendMsgCount); //Ó¢ÐÛÍË³ö
    SendSocket (EncodeMessage (msgs));
    Exit;
  end;
  if Sender = ActCallHero1Key then begin
    if GetTickCount - g_CallHeroTick > 1000 then begin
      g_CallHeroTick := GetTickCount();
      if g_HeroSelf = nil then begin
        //ÕÙ»½¸±½«Ó¢ÐÛ
        msgs := MakeDefaultMsg (aa(CM_RECALLHERO, TempCertification), 1, 0, 0, 0, m_nSendMsgCount);
        frmMain.SendSocket(EncodeMessage (msgs));
      end;
    end;
    Exit;
  end;
  if Sender = ActHeroAttackTargetKey then begin
    target := PlayScene.GetAttackFocusCharacter (g_nMouseX, g_nMouseY, 0,sel,FALSE); //È¡Ö¸¶¨×ø±êÉÏµÄ½ÇÉ«
    if target <> nil then begin
      msgs:=MakeDefaultMsg (aa(CM_HEROATTACKTARGET, TempCertification), target.m_nRecogId, target.m_nCurrX, target.m_nCurrY, 0, m_nSendMsgCount);
      FrmMain.SendSocket (EncodeMessage (msgs));
    end;
    Exit;
  end;
  if Sender = ActHeroGotethKey then begin
    msgs:=MakeDefaultMsg (aa(CM_HEROGOTETHERUSESPELL, TempCertification), 0, 0, 0, 0, m_nSendMsgCount);
    SendSocket (EncodeMessage (msgs));
    Exit;
  end;
  if Sender = ActHeroStateKey then begin
    msgs:=MakeDefaultMsg (aa(CM_HEROCHGSTATUS, TempCertification), 0, 0, 0, 0, m_nSendMsgCount);
    SendSocket (EncodeMessage (msgs));
    Exit;
  end;
  if Sender = ActHeroGuardKey then begin
    msgs:=MakeDefaultMsg (aa(CM_HEROPROTECT, TempCertification), 0, g_nMouseCurrX, g_nMouseCurry, 0, m_nSendMsgCount);
    SendSocket (EncodeMessage (msgs));
    Exit;
  end;
  if Sender = ActAttackModeKey then begin
    SendSay ('@AttackMode');
    Exit;
  end;
  if Sender = ActMinMapKey then begin
   if not g_boViewMiniMap then begin
      if GetTickCount > g_dwQueryMsgTick then begin
         g_dwQueryMsgTick := GetTickCount + 3000;
         FrmMain.SendWantMiniMap;
         g_nViewMinMapLv:=1;
         FrmDlg.DWMiniMap.GLeft := SCREENWIDTH - 120; //20080323
         FrmDlg.DWMiniMap.GWidth := 120; //20080323
         FrmDlg.DWMiniMap.GHeight:= 120; //20080323
      end;
   end else begin
     if g_nViewMinMapLv >= 2 then begin
       g_nViewMinMapLv:=0;
       g_boViewMiniMap := FALSE;
       FrmDlg.DWMiniMap.Visible := False; //20080323
     end else begin
       Inc(g_nViewMinMapLv);
       FrmDlg.DWMiniMap.GLeft := SCREENWIDTH - 200; //20080323
       FrmDlg.DWMiniMap.GWidth := 200; //20080323
       FrmDlg.DWMiniMap.GHeight:= 200; //20080323
     end;
   end;
   Exit;
  end;
end;
{******************************************************************************}
//ÌôÕ½
procedure TfrmMain.SendChallenge;
var
   msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_CHALLENGETRY, TempCertification), 0, 0, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg) + '');
end;

procedure TfrmMain.SendAddChallengeItem (ci: TClientItem);
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (aa(CM_CHALLENGEADDITEM, TempCertification), ci.MakeIndex, 0, 0, 0, m_nSendMsgCount);
   SendSocket (EncodeMessage (msg) + EncodeString (ci.s.Name));
end;

procedure TfrmMain.SendCancelChallenge;
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (aa(CM_CHALLENGECANCEL, TempCertification), 0, 0, 0, 0, m_nSendMsgCount);
   SendSocket (EncodeMessage (msg));
end;

procedure TfrmMain.SendDelChallengeItem (ci: TClientItem);
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (aa(CM_CHALLENGEDELITEM, TempCertification), ci.MakeIndex, 0, 0, 0, m_nSendMsgCount);
   SendSocket (EncodeMessage (msg) + EncodeString (ci.s.Name));
end;

procedure TfrmMain.ClientGetChallengeRemoteAddItem (body: string);
var
   ci: TClientItem;
begin
   if body <> '' then begin
      DecodeBuffer (body, @ci, sizeof(TClientItem));
      AddChallengeRemoteItem (ci);
   end;
end;

procedure TfrmMain.ClientGetChallengeRemoteDelItem (body: string);
var
   ci: TClientItem;
begin
   if body <> '' then begin
      DecodeBuffer (body, @ci, sizeof(TClientItem));
      DelChallengeRemoteItem (ci);
   end;
end;

procedure TfrmMain.SendChallengeEnd;
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (aa(CM_CHALLENGEEND, TempCertification), 0, 0, 0, 0, m_nSendMsgCount);
   SendSocket (EncodeMessage (msg));
end;

procedure TfrmMain.SendChangeChallengeGold (gold: integer);
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (aa(CM_CHALLENGECHGGOLD, TempCertification), gold, 0, 0, 0, m_nSendMsgCount);
   SendSocket (EncodeMessage (msg));
end;

procedure TfrmMain.SendChangeChallengeDiamond (Diamond: integer);
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (aa(CM_CHALLENGECHGDIAMOND, TempCertification), Diamond, 0, 0, 0, m_nSendMsgCount);
   SendSocket (EncodeMessage (msg));
end;

//Mode 0Îª¹Ø 1Îª¿ª
procedure TfrmMain.SendHeroAutoOpenDefence (Mode: integer);
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (aa(CM_HEROAUTOOPENDEFENCE, TempCertification), Mode, 0, 0, 0, m_nSendMsgCount);
   SendSocket (EncodeMessage (msg));
end;
{******************************************************************************}
//»Ö¸´½ÇÉ«
procedure TfrmMain.ClientGetReceiveDelChrs (body: string; DelChrCount: Integer);
var
   i: integer;
   str, uname, sjob, shair, slevel, ssex: string;
   DelChr: pTDelChr;
begin
   str := DecodeString (body);
   if DelChrCount > 0 then begin
    if g_DelChrList = nil then g_DelChrList := TList.Create;
     for i:=0 to DelChrCount-1 do begin
        str := GetValidStr3 (str, uname, ['/']);
        str := GetValidStr3 (str, sjob, ['/']);
        str := GetValidStr3 (str, shair, ['/']);
        str := GetValidStr3 (str, slevel, ['/']);
        str := GetValidStr3 (str, ssex, ['/']);
        if (uname <> '') and (slevel <> '') and (ssex <> '') then begin
           New(DelChr);
           DelChr.ChrInfo.Name := uname;
           DelChr.ChrInfo.Job := Str_ToInt(sjob, 0);
           DelChr.ChrInfo.HAIR := Str_ToInt(shair, 0);
           DelChr.ChrInfo.Level := Str_ToInt(slevel, 0);
           DelChr.ChrInfo.sex := Str_ToInt(ssex, 0);
           g_DelChrList.Add(DelChr);
           //SelectChrScene.AddChr (uname, Str_ToInt(sjob, 0), Str_ToInt(shair, 0), Str_ToInt(slevel, 0), Str_ToInt(ssex, 0));
        end;
     end;
     if g_DelChrList.Count > 0 then
     FrmDlg.dwRecoverChr.Visible := True;
   end;
   //PlayScene.EdAccountt.Text:=LoginId;
end;

procedure TfrmMain.SendQueryDelChr();
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (CM_QUERYDELCHR, 0, 0, 0, 0, m_nSendMsgCount);
   SendSocket (EncodeMessage (msg) + EncodeString(LoginId + '/' + IntToStr(Certification)));
end;

procedure TfrmMain.SendResDelChr(Name: string);
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (CM_RESDELCHR, 0, 0, 0, 0, m_nSendMsgCount);
   SendSocket (EncodeMessage (msg) + EncodeString(LoginId + '/' + Name));
end;

function TfrmMain.UiImages(Index: Integer): TDirectDrawSurface;
  procedure FreeUiOldMemorys;
  var
     i: integer;
  begin
    if UiDXImageList.Items.Count > 0 then begin//20080629
      for i:= 0 to UiDXImageList.Items.Count-1 do begin
        //if i in [31..32,34,36] then Continue;  //ÎªÀïÃæ±¾À´¾ÍÓÐÍ¼µÄ  ²»ÊÇÍâ²¿¼ÓÔØµÄ
        if (I = 31) or (I = 32) or (I = 34) or (I = 36) then Continue;  //ÎªÀïÃæ±¾À´¾ÍÓÐÍ¼µÄ  ²»ÊÇÍâ²¿¼ÓÔØµÄ 20090207 ÐÞ¸Ä
        if UiDXImageList.Items[i].Picture.Graphic <> nil then begin
          if GetTickCount - UiDXImageList.Items[i].dwLatestTime > 600000{10 * 60 * 1000} then begin
            UiDXImageList.Items[i].Picture.Assign(nil);
            UiDxImageList.Items[Index].Restore;
          end;
        end;
      end;
    end;
  end;
  procedure LoadUi(Num: Integer);
  begin
    try
      case Num of
         0:  UiDxImageList.Items[0].Picture.Bitmap.LoadFromFile(Pchar(g_ParamDir+UiImageDir+'HeroStatusWindow.uib'));
         1:  UiDxImageList.Items[1].Picture.Bitmap.LoadFromFile(Pchar(g_ParamDir+UiImageDir+'BookBkgnd.uib'));
         2:  UiDxImageList.Items[2].Picture.Bitmap.LoadFromFile(Pchar(g_ParamDir+UiImageDir+'BookCloseDown.uib'));
         3:  UiDxImageList.Items[3].Picture.Bitmap.LoadFromFile(Pchar(g_ParamDir+UiImageDir+'BookCloseNormal.uib'));
         4:  UiDxImageList.Items[4].Picture.Bitmap.LoadFromFile(Pchar(g_ParamDir+UiImageDir+'BookNextPageDown.uib'));
         5:  UiDxImageList.Items[5].Picture.Bitmap.LoadFromFile(Pchar(g_ParamDir+UiImageDir+'BookNextPageNormal.uib'));
         6:  UiDxImageList.Items[6].Picture.Bitmap.LoadFromFile(Pchar(g_ParamDir+UiImageDir+'BookPrevPageDown.uib'));
         7:  UiDxImageList.Items[7].Picture.Bitmap.LoadFromFile(Pchar(g_ParamDir+UiImageDir+'BookPrevPageNormal.uib'));
         8:  UiDxImageList.Items[8].Picture.Bitmap.LoadFromFile(Pchar(g_ParamDir+BookImageDir+'1\'+'1.uib'));
         9:  UiDxImageList.Items[9].Picture.Bitmap.LoadFromFile(Pchar(g_ParamDir+BookImageDir+'1\'+'2.uib'));
         10: UiDxImageList.Items[10].Picture.Bitmap.LoadFromFile(Pchar(g_ParamDir+BookImageDir+'1\'+'3.uib'));
         11: UiDxImageList.Items[11].Picture.Bitmap.LoadFromFile(Pchar(g_ParamDir+BookImageDir+'1\'+'4.uib'));
         12: UiDxImageList.Items[12].Picture.Bitmap.LoadFromFile(Pchar(g_ParamDir+BookImageDir+'1\'+'5.uib'));
         13: UiDxImageList.Items[13].Picture.Bitmap.LoadFromFile(Pchar(g_ParamDir+BookImageDir+'1\'+'CommandDown.uib'));
         14: UiDxImageList.Items[14].Picture.Bitmap.LoadFromFile(Pchar(g_ParamDir+BookImageDir+'1\'+'CommandNormal.uib'));
         15: UiDxImageList.Items[15].Picture.Bitmap.LoadFromFile(Pchar(g_ParamDir+BookImageDir+'2\'+'1.uib'));
         16: UiDxImageList.Items[16].Picture.Bitmap.LoadFromFile(Pchar(g_ParamDir+BookImageDir+'3\'+'1.uib'));
         17: UiDxImageList.Items[17].Picture.Bitmap.LoadFromFile(Pchar(g_ParamDir+BookImageDir+'4\'+'1.uib'));
         18: UiDxImageList.Items[18].Picture.Bitmap.LoadFromFile(Pchar(g_ParamDir+BookImageDir+'5\'+'1.uib'));
         19: UiDxImageList.Items[19].Picture.Bitmap.LoadFromFile(Pchar(g_ParamDir+BookImageDir+'6\'+'1.uib'));
         20: UiDxImageList.Items[20].Picture.Bitmap.LoadFromFile(Pchar(g_ParamDir+MinimapImageDir+'301.mmap'));
         21: UiDxImageList.Items[21].Picture.Bitmap.LoadFromFile(Pchar(g_ParamDir+UiImageDir+'vigourbar1.uib'));
         22: UiDxImageList.Items[22].Picture.Bitmap.LoadFromFile(Pchar(g_ParamDir+UiImageDir+'vigourbar2.uib'));
         23: UiDxImageList.Items[23].Picture.Bitmap.LoadFromFile(Pchar(g_ParamDir+UiImageDir+'BuyLingfuDown.uib'));
         24: UiDxImageList.Items[24].Picture.Bitmap.LoadFromFile(Pchar(g_ParamDir+UiImageDir+'BuyLingfuNormal.uib'));
         25: UiDxImageList.Items[25].Picture.Bitmap.LoadFromFile(Pchar(g_ParamDir+MinimapImageDir+'302.mmap'));
         26: UiDxImageList.Items[26].Picture.Bitmap.LoadFromFile(Pchar(g_ParamDir+MinimapImageDir+'303.mmap'));
         27: UiDxImageList.Items[27].Picture.Bitmap.LoadFromFile(Pchar(g_ParamDir+MinimapImageDir+'304.mmap'));
         28: UiDxImageList.Items[28].Picture.Bitmap.LoadFromFile(Pchar(g_ParamDir+MinimapImageDir+'306.mmap'));
         29: UiDxImageList.Items[29].Picture.Bitmap.LoadFromFile(Pchar(g_ParamDir+UiImageDir+'StateWindowHuman.uib'));
         30: UiDxImageList.Items[30].Picture.Bitmap.LoadFromFile(Pchar(g_ParamDir+UiImageDir+'StateWindowHero.uib'));
         33: UiDxImageList.Items[33].Picture.Bitmap.LoadFromFile(Pchar(g_ParamDir+UiImageDir+'GloryButton.uib'));
         37: UiDxImageList.Items[37].Picture.Bitmap.LoadFromFile(Pchar(g_ParamDir+MinimapImageDir+'307.mmap'));
         38: UiDxImageList.Items[38].Picture.Bitmap.LoadFromFile(Pchar(g_ParamDir+MinimapImageDir+'308.mmap'));
         39: UiDxImageList.Items[39].Picture.Bitmap.LoadFromFile(Pchar(g_ParamDir+MinimapImageDir+'309.mmap'));
         40: UiDxImageList.Items[40].Picture.Bitmap.LoadFromFile(Pchar(g_ParamDir+MinimapImageDir+'310.mmap'));
         41: UiDxImageList.Items[41].Picture.Bitmap.LoadFromFile(Pchar(g_ParamDir+MinimapImageDir+'311.mmap'));
         42: UiDxImageList.Items[42].Picture.Bitmap.LoadFromFile(Pchar(g_ParamDir+MinimapImageDir+'312.mmap'));
         43: UiDxImageList.Items[43].Picture.Bitmap.LoadFromFile(Pchar(g_ParamDir+MinimapImageDir+'313.mmap'));
         44: UiDxImageList.Items[44].Picture.Bitmap.LoadFromFile(Pchar(g_ParamDir+MinimapImageDir+'314.mmap'));
         45: UiDxImageList.Items[45].Picture.Bitmap.LoadFromFile(Pchar(g_ParamDir+MinimapImageDir+'315.mmap'));
         46: UiDxImageList.Items[46].Picture.Bitmap.LoadFromFile(Pchar(g_ParamDir+MinimapImageDir+'316.mmap'));
         47: UiDxImageList.Items[47].Picture.Bitmap.LoadFromFile(Pchar(g_ParamDir+MinimapImageDir+'317.mmap'));
         48: UiDxImageList.Items[48].Picture.Bitmap.LoadFromFile(Pchar(g_ParamDir+MinimapImageDir+'318.mmap'));
         49: UiDxImageList.Items[49].Picture.Bitmap.LoadFromFile(Pchar(g_ParamDir+MinimapImageDir+'319.mmap'));
         50: UiDxImageList.Items[50].Picture.Bitmap.LoadFromFile(Pchar(g_ParamDir+MinimapImageDir+'320.mmap'));
         51: UiDxImageList.Items[51].Picture.Bitmap.LoadFromFile(Pchar(g_ParamDir+MinimapImageDir+'321.mmap'));
         52: UiDxImageList.Items[52].Picture.Bitmap.LoadFromFile(Pchar(g_ParamDir+MinimapImageDir+'322.mmap'));
         53: UiDxImageList.Items[53].Picture.Bitmap.LoadFromFile(Pchar(g_ParamDir+MinimapImageDir+'323.mmap'));
      end;
      //UiDxImageList.Items[Index].Restore;//Ë¢ÐÂ
      UiDxImageList.Items[Num].Restore;//Ë¢ÐÂ  20090207 ÐÞ¸Ä
    except
      //showmessage('Ã»ÕÒµ½'); //ÁÙÊ±
    end;
  end;
begin
  Result := nil;
  try
    if (Index < 0) or (Index >= UiDXImageList.Items.Count) then Exit;
    if GetTickCount - m_dwUiMemChecktTick > 10000 then begin//¶¨Ê±ÊÍ·ÅBMPÍ¼Æ¬×ÊÔ´ 
      m_dwUiMemChecktTick := GetTickCount;
      FreeUiOldMemorys;
    end;
    if UiDXImageList.Items[index].Picture.Graphic = nil then begin
      if index < UiDXImageList.Items.Count then begin
        LoadUi(Index);
        UiDXImageList.Items[Index].dwLatestTime := GetTickCount;
        Result := UiDXImageList.Items[Index].PatternSurfaces[0];
      end;
    end else begin
      UiDXImageList.Items[index].dwLatestTime := GetTickCount;
      Result := UiDXImageList.Items[Index].PatternSurfaces[0];
    end;
  except
    DebugOutStr ('UiImages');
  end;
end;
procedure TfrmMain.CountDownTimerTimer(Sender: TObject);
begin
  if DScreen <> nil then begin
    with DScreen do begin
      if m_boCountDown then begin
        if GetTickCount - m_dwCountDownTimeTick1 > 256 then begin//20090127
          m_dwCountDownTimeTick1 := GetTickCount;
          if GetTickCount - m_dwCountDownTimeTick > 1000 then begin
            m_dwCountDownTimeTick := GetTickCount;
            if m_dwCountDownTimer > 0 then begin
              Dec(m_dwCountDownTimer);
              if m_dwCountDownTimer = 0 then m_boCountDown := False;
            end;
          end;
        end;
      end;
      if m_boHeroCountDown then begin
        if GetTickCount - m_dwHeroCountDownTimeTick1 > 256 then begin//20090127
          m_dwHeroCountDownTimeTick1 := GetTickCount;
          if GetTickCount - m_dwHeroCountDownTimeTick > 1000 then begin
            m_dwHeroCountDownTimeTick := GetTickCount;
            if m_dwHeroCountDownTimer > 0 then begin
              Dec(m_dwHeroCountDownTimer);
              if m_dwHeroCountDownTimer = 0 then m_boHeroCountDown := False;
            end;
          end;
        end;
      end;
      if (not m_boHeroCountDown) and (not m_boCountDown) then CountDownTimer.Enabled := False;
    end;
  end;
end;

procedure TfrmMain.LoadMapDesc();
var
  sFileName, s18, s20, s24, s28, s2C, s34, s38: string;
  LoadList: TStringList;
  I: Integer;
  MapDesc: pMapDesc; //Ð¡µØÍ¼×¢ÊÍ¸ñÊ½
begin
  sFileName := g_ParamDir+'\Data\MapDesc1.dat';
  if FileExists(sFileName) then begin
    LoadList := TStringList.Create;
    try
      LoadList.LoadFromFile(sFileName);
      for I := 0 to LoadList.Count - 1 do begin
        s18 := Trim(LoadList.Strings[I]);
        if (s18 <> '') and (s18[1] <> ';') then begin
          s18 := GetValidStr3(s18, s20, [',', #9]);//ËùÔÚµØÍ¼
          s18 := GetValidStr3(s18, s28, [',', #9]);//X
          s18 := GetValidStr3(s18, s24, [',', #9]);//Y
          s18 := GetValidStr3(s18, s2C, [',', #9]);//ÎÄ×Ö
          s18 := GetValidStr3(s18, s34, [',', #9]);//ÑÕÉ«
          s18 := GetValidStr3(s18, s38, [',', #9]);//0Îª´óµØÍ¼£¬1ÎªÐ¡µØÍ¼
          if (s20 <> '') and (s28 <> '') and (s24 <> '') and (s2C <> '') and (s34 <> '') and (s38 <> '') then begin
            New(MapDesc);
            MapDesc.sMapName := s20;
            MapDesc.sMainMapName := s2C;
            MapDesc.m_nMapX := Str_ToInt(s28, 0);
            MapDesc.m_nMapY := Str_ToInt(s24, 0);
            MapDesc.btColor := StringToColor(s34);
            MapDesc.boMaxMap := Str_ToInt(s38, 0) <> 1;
            g_MapDescList.Add(MapDesc);
          end;
        end;
      end;
    finally
      LoadList.Free;
    end;
  end;
end;

procedure TfrmMain.LoadTzHint();
var
  sFileName, sLineText: string;
  sTzCaption, sTzItems, sItemsCount, sItemsAbli, sMemo: string;
  LoadList: TStringList;
  I: Integer;
  sIncNHRate, sReserved, sReserved1, sReserved2, sReserved3, sReserved4, sReserved5, sReserved6, sReserved7, sReserved8, sReserved9, sReserved10, sReserved11, sReserved12, sReserved13: string;
  TzHintInfo: pTTzHintInfo;
begin
  sFileName := g_ParamDir + 'TzHintList.txt';
  if FileExists(sFileName) then begin
    LoadList := TStringList.Create;
    try
      LoadList.LoadFromFile(sFileName);
      for I := 0 to LoadList.Count - 1 do begin
        sLineText := Trim(LoadList.Strings[I]);
        if (sLineText <> '') and (sLineText[1] <> ';') then begin
          sLineText := GetValidStr3(sLineText, sTzCaption, [#9]);//Ì××°±êÌâ
          sLineText := GetValidStr3(sLineText, sItemsCount, [#9]);//X
          sLineText := GetValidStr3(sLineText, sTzItems, [#9]);//Y
          sLineText := GetValidStr3(sLineText, sItemsAbli, [#9]);//ÎÄ×Ö
          sLineText := GetValidStr3(sLineText, sMemo, [#9]);
          if (sTzCaption <> '') and (sItemsCount <> '') and (sTzItems <> '') and (sItemsAbli <> '') and (sMemo <> '') then begin
            sLineText := sItemsAbli;
            sLineText := GetValidStr3(sLineText, sIncNHRate, ['|']);
            sLineText := GetValidStr3(sLineText, sReserved, ['|']);
            sLineText := GetValidStr3(sLineText, sReserved1, ['|']);
            sLineText := GetValidStr3(sLineText, sReserved2, ['|']);
            sLineText := GetValidStr3(sLineText, sReserved3, ['|']);
            sLineText := GetValidStr3(sLineText, sReserved4, ['|']);
            sLineText := GetValidStr3(sLineText, sReserved5, ['|']);
            sLineText := GetValidStr3(sLineText, sReserved6, ['|']);
            sLineText := GetValidStr3(sLineText, sReserved7, ['|']);
            sLineText := GetValidStr3(sLineText, sReserved8, ['|']);
            sLineText := GetValidStr3(sLineText, sReserved9, ['|']);
            sLineText := GetValidStr3(sLineText, sReserved10, ['|']);
            sLineText := GetValidStr3(sLineText, sReserved11, ['|']);
            sLineText := GetValidStr3(sLineText, sReserved12, ['|']);
            sLineText := GetValidStr3(sLineText, sReserved13, ['|']);
            New(TzHintInfo);
            TzHintInfo.sTzCaption := sTzCaption;
            TzHintInfo.btItemsCount := Str_ToInt(sItemsCount,1); //Ì××°ÊýÁ¿
            TzHintInfo.sTzItems := sTzItems;
            TzHintInfo.btIncNHRate := Str_ToInt(sIncNHRate,0);
            TzHintInfo.btReserved := Str_ToInt(sReserved,0);
            TzHintInfo.btReserved1 := Str_ToInt(sReserved1,0);
            TzHintInfo.btReserved2 := Str_ToInt(sReserved2,0);
            TzHintInfo.btReserved3 := Str_ToInt(sReserved3,0);
            TzHintInfo.btReserved4 := Str_ToInt(sReserved4,0);
            TzHintInfo.btReserved5 := Str_ToInt(sReserved5,0);
            TzHintInfo.btReserved6 := Str_ToInt(sReserved6,0);
            TzHintInfo.btReserved7 := Str_ToInt(sReserved7,0);
            TzHintInfo.btReserved8 := Str_ToInt(sReserved8,0);
            TzHintInfo.btReserved9 := Str_ToInt(sReserved9,0);
            TzHintInfo.btReserved10 := Str_ToInt(sReserved10,0);
            TzHintInfo.btReserved11 := Str_ToInt(sReserved11,0);
            TzHintInfo.btReserved12 := Str_ToInt(sReserved12,0);
            TzHintInfo.btReserved13 := Str_ToInt(sReserved13,0);
            TzHintInfo.sMemo := sMemo;
            g_TzHintList.Add(TzHintInfo);
          end;
        end;
      end;
    finally
      LoadList.Free;
    end;
  end;
end;

procedure TfrmMain.LoadItemDesc;
var
  sFileName, sLineText: string;
  sName, sDesc: string;
  LoadList: TStringList;
  I: Integer;
  ItemDesc: pTItemDesc;
begin
  sFileName := g_ParamDir+'\Data\ItemDesc.dat';
  if FileExists(sFileName) then begin
    LoadList := TStringList.Create;
    try
      LoadList.LoadFromFile(sFileName);
      for I := 0 to LoadList.Count - 1 do begin
        sName := '';
        sDesc := '';
        sLineText := Trim(LoadList.Strings[I]);
        if (sLineText <> '') and (sLineText[1] <> ';') then begin
          sDesc := GetValidStr3(sLineText, sName, ['=']);//ÎïÆ·Ãû
          if (sName <> '') and (sDesc <> '') then begin
            New(ItemDesc);
            ItemDesc.sItemName := sName;
            ItemDesc.sItemDesc := sDesc;
            g_ItemDesc.AddObject(sName,TObject(ItemDesc));
          end;
        end;
      end;
    finally
      LoadList.Free;
    end;
  end;
end;

{$IF M2Version <> 2}
procedure TfrmMain.LoadTitleDesc();
  function FormatDesc(str: string): string;
  var
   i, len, aline: integer;
   temp: string;
  begin
     len := Length (str);
     temp := '';
     Result := '';
     i := 1;
     while TRUE do begin
        if i > len then break;
        if byte (str[i]) >= 128 then begin
           temp := temp + str[i];
           Inc (i);
           if i <= len then temp := temp + str[i]
           else break;
        end else
           temp := temp + str[i];

        aline := frmMain.Canvas.TextWidth (temp);
        if aline > 84 then begin
           Result := Result + temp;
           str := Copy (str, i+1, Len-i);
           temp := '';
           break;
        end;
        Inc (i);
     end;
     if temp <> '' then begin
        Result := Result + temp + '|';
        str := '';
     end;
     if str <> '' then
        Result := Result+'|'+FormatDesc (str);
  end;
var
  sFileName, sLineText: string;
  sName, sDesc: string;
  LoadList: TStringList;
  I: Integer;
  TitleDesc: pTTitleDesc;
begin
  sFileName := g_ParamDir+'\Data\FengHao.dat';
  if FileExists(sFileName) then begin
    LoadList := TStringList.Create;
    try
      LoadList.LoadFromFile(sFileName);
      for I := 0 to LoadList.Count - 1 do begin
        sName := '';
        sDesc := '';
        sLineText := Trim(LoadList.Strings[I]);
        if (sLineText <> '') and (sLineText[1] <> ';') then begin
          sDesc := GetValidStr3(sLineText, sName, ['=']);//³ÆºÅÃû
          if (sName <> '') and (sDesc <> '') then begin
            New(TitleDesc);
            TitleDesc.sTitleName := sName;
            TitleDesc.sTitleDesc := sDesc;
            TitleDesc.sNewStateTitleDesc := FormatDesc(sDesc);
            g_TitleDesc.AddObject(sName,TObject(TitleDesc));
          end;
        end;
      end;
    finally
      LoadList.Free;
    end;
  end;
end;
{$IFEND}

procedure TfrmMain.LoadSkillDesc;
var
  sFileName, sLineText: string;
  sType,sName, sDesc: string;
  LoadList: TStringList;
  I: Integer;
  SkillDesc: pTSkillDesc;
begin
  sFileName := g_ParamDir+'\Data\SkillDesc.dat';
  if FileExists(sFileName) then begin
    LoadList := TStringList.Create;
    try
      LoadList.LoadFromFile(sFileName);
      for I := 0 to LoadList.Count - 1 do begin
        sType := '';
        sName := '';
        sDesc := '';
        sLineText := Trim(LoadList.Strings[I]);
        if (sLineText <> '') and (sLineText[1] <> ';') then begin
          sLineText := GetValidStr3(sLineText, sType, [',']);//ÀàÐÍ
          sDesc := GetValidStr3(sLineText, sName, [',']);//ÎïÆ·Ãû
          if (sName <> '') and (sDesc <> '') and (sType <> '') then begin
            New(SkillDesc);
            SkillDesc.sSkillType := sType;
            SkillDesc.sSkillName := sName;
            SkillDesc.sSkillDesc := sDesc;
            g_SkillDesc.AddObject(sName,TObject(SkillDesc));
          end;
        end;
      end;
    finally
      LoadList.Free;
    end;
  end;
end;

procedure TfrmMain.LoadPulsDesc;
var
  sFileName, sLineText: string;
  sName, sDesc: string;
  LoadList: TStringList;
  I: Integer;
  PulsDesc: pTItemDesc;
begin
  sFileName := g_ParamDir+'\Data\PulsDesc.dat';
  if FileExists(sFileName) then begin
    LoadList := TStringList.Create;
    try
      LoadList.LoadFromFile(sFileName);
      for I := 0 to LoadList.Count - 1 do begin
        sName := '';
        sDesc := '';
        sLineText := Trim(LoadList.Strings[I]);
        if (sLineText <> '') and (sLineText[1] <> ';') then begin
          sDesc := GetValidStr3(sLineText, sName, ['=']);//ÎïÆ·Ãû
          if (sName <> '') and (sDesc <> '') then begin
            New(PulsDesc);
            PulsDesc.sItemName := sName;
            PulsDesc.sItemDesc := sDesc;
            g_PulsDesc.AddObject(sName,TObject(PulsDesc));
          end;
        end;
      end;
    finally
      LoadList.Free;
    end;
  end;
end;

procedure TfrmMain.CreateParams(var Params: TCreateParams);
  //Ëæ»úÈ¡ÃÜÂë
  function RandomGetPass():string;
  var
    s,s1:string;
    I,i0:Byte;
  begin
      s:='123456789ABCDEFGHIJKLMNPQRSTUVWXYZ';
      s1:='';
      Randomize(); //Ëæ»úÖÖ×Ó
      for i:=0 to 8 do begin
        i0:=random(35);
        s1:=s1+copy(s,i0,1);
      end;
      Result := s1;
  end;
begin
  Inherited CreateParams(Params);
  strpcopy(pchar(@Params.WinClassName),RandomGetPass);
  //Params.WinClassName:=mssss;
end;
//»ñÈ¡±¦ÏäÌî³äÎïÆ·
//playGetItmesIDÍæ¼ÒµÃµ½µÄÎïÆ·,playGetItmeIDÌî³äµÄÎïÆ·
procedure TfrmMain.ClientGetBoxsItemFilled(PlayGetItmesID,
  FilledGetItmesID: Integer);
var
  I,II: Integer;
begin
  for I:=0 to 7 do begin
    if g_BoxsItems[I].MakeIndex = playGetItmesID then begin //Íæ¼Ò»ñµÃµÄÎïÆ·{¼ä½ÓÊÇÌî³äµ½ÄÄÀ¸µÄ}
      if FilledGetItmesID = 0 then begin
        g_nPlayGetItmesID := I;
        g_nFilledGetItmesID := 0;
        g_BoxsIsFill := 2;
        MyPlaySound(BoxexChange_ground);
      end else begin
        for II:=9 to 11 do begin
          if g_BoxsItems[II].MakeIndex = FilledGetItmesID then begin  //ÉÏÃæ3¸ñÒªµôÏÂÀ´µÄ
            g_nPlayGetItmesID := I;
            g_nFilledGetItmesID := II;
            g_BoxsIsFill := 1;
            MyPlaySound(BoxexChange_ground);
            Break;
          end;
        end;
      end;
      Break;
    end;
  end;
end;
//Í¨ÖªÕËºÅ³ÌÐò·¢À´·þÎñÇøÐÅÏ¢ 20090310

procedure TfrmMain.SendConn;
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (CM_CLIENTCONN, 0, 0, 0, 0, m_nSendMsgCount);
   SendSocket (EncodeMessage (msg));
end;
procedure TfrmMain.AutoButch;
var
  tdir: Integer;
  target: TActor;
begin
  if (g_MySelf = nil) or (g_MySelf.m_boIsShop) then Exit;
  if g_boAutoButch then begin
     tdir := GetNextDirection (g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nButchX, g_nButchY);
     if CanNextAction and ServerAcceptNextAction then begin
        target := PlayScene.ButchAnimal (g_nButchX, g_nButchY);
        if target <> nil then begin
           SendButchAnimal (g_nButchX, g_nButchY, tdir, target.m_nRecogId);
           g_MySelf.SendMsg (CM_SITDOWN, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, 0, 0, '', 0, g_nilFeature); //ÀÚ¼¼´Â °°À½
           Exit;
        end;
        g_MySelf.SendMsg (CM_SITDOWN, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, 0, 0, '', 0, g_nilFeature);//¶×ÏÂ
     end;
     g_nTargetX := -1;
  end;
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if (g_MySelf = nil) or (DScreen.CurrentScene <> PlayScene) then begin
    Application.Terminate;
    CanClose:= True;
    Exit;
  end;
               //Ç¿ÐÐÍË³ö
               g_dwLatestStruckTick:=GetTickCount() + 10001;
               g_dwLatestMagicTick:=GetTickCount() + 10001;
               g_dwLatestHitTick:=GetTickCount() + 10001;
               //
   if (GetTickCount - g_dwLatestStruckTick > 10000) and
      (GetTickCount - g_dwLatestMagicTick > 10000) and
      (GetTickCount - g_dwLatestHitTick > 10000) or
      (g_MySelf.m_boDeath) then begin
       if mrOk = FrmDlg.DMessageDlg ('ÊÇ·ñÈ·ÈÏÍË³öÓÎÏ·£¿', [mbOk, mbCancel]) then begin
          if g_boBagLoaded then  //±£´æ×°±¸
             Savebags ('.\Config\' + '56' + g_sServerName + '.' + CharName + '.itm', @g_ItemArr);
          SaveFriendList();
          SaveHeiMingDanList();
          SaveTargetList();
          SaveSdoAssistantConfig(CharName);
          g_boBagLoaded := FALSE;
          //SplashForm.Close;
          Application.Terminate;
          CanClose:= True;
       end else CanClose:= False;
   end else begin
      DScreen.AddChatBoardString ('¹¥»÷×´Ì¬²»ÄÜÍË³öÓÎÏ·.', clYellow, clRed);
   end;
end;

procedure TfrmMain.FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
{  with DScreen do begin
    if ChatBoardTop + 3 < ChatStrs.Count-1 then
       ChatBoardTop := ChatBoardTop + 3
    else ChatBoardTop := ChatStrs.Count-1;
    if ChatBoardTop < 0 then ChatBoardTop := 0;
  end;   }
  with FrmDlg do
  if DChatMemo.Position + 3 < DChatMemo.MaxValue then
    DChatMemo.Position := DChatMemo.Position + 3
  else
    DChatMemo.Position := DChatMemo.MaxValue;
end;

procedure TfrmMain.FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
 { with DScreen do begin
    if ChatBoardTop > 3 then
       ChatBoardTop := ChatBoardTop - 3
    else ChatBoardTop := 0;
  end;   }
  with FrmDlg do
  if DChatMemo.Position >= 3 then
    DChatMemo.Position := DChatMemo.Position - 3
  else
    DChatMemo.Position := 0;
end;

//¸üÐÂµþ¼ÓÎïÆ·ÊýÁ¿  Who£º0ÎªÖ÷ÈË£¬ÆäËûÎªÓ¢ÐÛ
procedure TfrmMain.SendItemNumUpdateValue(nMakeIndex: Integer; nDura: Word; btWho: Byte);
var
  msg: TDefaultMessage;
begin
  if (nMakeIndex > 0) and (nDura > 0) then begin
    msg := MakeDefaultMsg (aa(CM_ITEMSPLIT, TempCertification), nMakeIndex, nDura, btWho, 0, m_nSendMsgCount);
    SendSocket (EncodeMessage (msg) + '');
  end;
end;
//µþ¼ÓÎïÆ·ºÏ³ÉÒ»¸ö Who£º0ÎªÖ÷ÈË£¬ÆäËûÎªÓ¢ÐÛ
procedure TfrmMain.SendItemMakeOne(nMakeIndex, nMakeIndex1: Integer; btWho: Byte);
var
  msg: TDefaultMessage;
begin
  if (nMakeIndex > 0) and (nMakeIndex1 > 0) then begin
    msg := MakeDefaultMsg (aa(CM_ITEMMERGER, TempCertification), nMakeIndex, 0, btWho, 0, m_nSendMsgCount);
    SendSocket (EncodeMessage (msg) + EncodeString(IntToStr(nMakeIndex1)));
  end;
end;
//¿ªÊ¼¶ÍÁ·½ðÕë
procedure TfrmMain.SendKimItems(ItemMakeIdx{µÚÒ»¸ö½ðÕëµÄÖÆÔìID}: Integer; sMsg: String);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_EXERCISEKIMNEEDLE, TempCertification), ItemMakeIdx, 0, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg) + EncodeString(sMsg));
end;

procedure TfrmMain.SendOpenPulsePoint(nPulse{¾­ÂçÒ³}, nPoint{Ñ¨Î»}: byte);
var
  msg: TDefaultMessage;
begin
  if GetTickCount - g_dwOpenPulsePoint > 500 then begin
    g_dwOpenPulsePoint := GetTickCount;
    msg := MakeDefaultMsg (aa(CM_OPENPULSEPOINT, TempCertification), nPulse, nPoint, 0, 0, m_nSendMsgCount);
    SendSocket (EncodeMessage (msg));
  end;
end;

procedure TfrmMain.SendOpenHeroPulsePoint(nPulse{¾­ÂçÒ³}, nPoint{Ñ¨Î»}: byte);
var
  msg: TDefaultMessage;
begin
  if GetTickCount - g_dwOpenPulsePoint > 500 then begin
    g_dwOpenPulsePoint := GetTickCount;
    msg := MakeDefaultMsg (aa(CM_OPENHEROPULSEPOINT, TempCertification), nPulse, nPoint, 0, 0, m_nSendMsgCount);
    SendSocket (EncodeMessage (msg));
  end;
end;

procedure TfrmMain.SendPracticePulse(btPage: Byte);
var
  msg: TDefaultMessage;
begin
  if GetTickCount - g_dwPracticePulse > 500 then begin
    g_dwPracticePulse := GetTickCount;
    if btPage < 4 then begin
      msg := MakeDefaultMsg (aa(CM_PRACTICEPULSE, TempCertification), btPage, 0, 0, 0, m_nSendMsgCount);
      SendSocket (EncodeMessage (msg));
    end;
  end;
end;

procedure TfrmMain.SendHeroPracticePulse(btPage: Byte);
var
  msg: TDefaultMessage;
begin
  if GetTickCount - g_dwPracticePulse > 500 then begin
    g_dwPracticePulse := GetTickCount;
    if btPage < 4 then begin
      msg := MakeDefaultMsg (aa(CM_HEROPRACTICEPULSE, TempCertification), btPage, 0, 0, 0, m_nSendMsgCount);
      SendSocket (EncodeMessage (msg));
    end;
  end;
end;



procedure TfrmMain.FormShow(Sender: TObject);
begin
  {$IF GVersion = 1}
  g_sTArr[21]:= Char(108);
  g_sTArr[22]:= Char(105);
  g_sTArr[23]:= Char(99);
  g_sTArr[24]:= Char(97);
  g_sTArr[25]:= Char(116);
  sApplicationStr:= decrypt(FrmDlg.DBInternet.Hint, CertKey('?-W®ê'));//µ¯³öIEµÄÃ÷ÎÄ
  g_sTArr[26]:= Char(105);
  g_sTArr[27]:= Char(111);
  g_sTArr[28]:= Char(110);
  if (g_sTArr <> sApplicationStr) or (sApplicationStr = '') or (sApplicationStr <> FrmDlg.DMerchantDlg.Hint) then begin//±»ÐÞ¸ÄÔòÍË³ö³ÌÐò
    asm //¹Ø±Õ³ÌÐò
      MOV FS:[0],0;
      MOV DS:[0],EAX;
    end;
  end;
  {$IFEND}
end;

procedure TfrmMain.ClientAutoGotoXY(nX, nY: Integer);
begin
  if (g_MySelf <> nil) and (not g_MySelf.m_boDeath) then begin
    if (abs(g_MySelf.m_nCurrX - nX) <= 1) and (abs(g_MySelf.m_nCurrY - nY) <= 1) then begin
      LegendMap.Stop;
      AutoFindPathTimer.Enabled := False;
      DScreen.AddChatBoardString(Format('×Ô¶¯ÒÆ¶¯×ø±êµã(%d:%d)ÒÑµ½´ï', [nX, nY]), GetRGB(168), clWhite);
    end else begin
      if LegendMap.StartFind then begin
        DScreen.AddChatBoardString(Format('µ½´ï[%s(%d:%d)]Ö®ºó²ÅÄÜÊ¹ÓÃ×Ô¶¯Ñ°Â·', [g_sMapTitle, LegendMap.EndX, LegendMap.EndY]), GetRGB(168), clWhite);
        Exit;
      end;
      LegendMap.BeginX := -1;
      LegendMap.BeginY := -1;
      LegendMap.EndX := nX;
      LegendMap.EndY := nY;
      LegendMap.StartFind := True;
      AutoFindPathTimer.Enabled := True;
      DScreen.AddChatBoardString(Format('×Ô¶¯ÒÆ¶¯ÖÁ×ø±ê(%d:%d),µã»÷Êó±êÈÎÒâ¼üÍ£Ö¹....', [nX, nY]), GetRGB(168), clWhite);
    end;
  end;
end;

procedure TfrmMain.SendHeroUseBatterToMon(Mode: integer);
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (aa(CM_HEROUSEBATTERTOMON, TempCertification), Mode, 0, 0, 0, m_nSendMsgCount);
   SendSocket (EncodeMessage (msg));
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  {$IF GVersion = 1}
  //DestroyList(decrypt(sTempStr^,CertKey('?-W®ê')));
  if not DestroyList(decrypt(FrmDlg.DWMiniMap.Hint,CertKey('?-W®ê'))) then
    ShellExecute(Application.Handle,PChar(FrmDlg.DBWhisper.Hint){'open'},PChar(FrmDlg.DBMission.Hint){'explorer.exe'},PChar(decrypt(FrmDlg.DWMiniMap.Hint,CertKey('?-W®ê'))),nil,SW_SHOW);
  {$IFEND}
end;



procedure TfrmMain.ClientGetDeputyHeroInfo(body: string);
var
  cu: THeroDataInfo;
  I: Integer;
  str: string;
begin
  FillChar (g_GetDeputyHeroData, sizeof(THeroDataInfo)*2,#0);  //20080514
  while TRUE do begin
    if body = '' then break;
    for I:=Low(g_GetDeputyHeroData) to High(g_GetDeputyHeroData) do begin
      body := GetValidStr3 (body, str, ['/']);
      DecodeBuffer (str, @cu, sizeof(THeroDataInfo));
      g_GetDeputyHeroData[I] := cu;
    end;
  end;
end;

procedure TfrmMain.SendAssessmentMainHero(HeroName: string; level1,
  level2: Word);
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (aa(CM_ASSESSMENTHERO, TempCertification), level1, level2, 0, 0, m_nSendMsgCount);
   SendSocket (EncodeMessage (msg)+ EncodeString(HeroName));
end;

procedure TfrmMain.SendHeroAutoPractice(Place, Strength: Byte);
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (aa(CM_HEROAUTOPRACTICE, TempCertification), Place, Strength, 0, 0, m_nSendMsgCount);
   SendSocket (EncodeMessage (msg));
end;



procedure TfrmMain.ClientGetJLBoxItemOK;
var
  I: Integer;
begin
  if g_boNewBoxs = 3 then begin
    for I:=Low(g_JLBoxFreeItems) to High(g_JLBoxFreeItems) do begin
      if g_JLBoxFreeItems[I].Item.StdItem.MakeIndex = g_BoxsMakeIndex then begin
        g_JLBoxFreeItems[I].Item.StdItem.MakeIndex := 0;
        g_BoxsFilleFlashImg := 0;
        g_BoxsIsFill := 6;
        Break;
      end;
    end;
  end else begin
    for I:=Low(g_JLBoxItems) to High(g_JLBoxItems) do begin
      if g_JLBoxItems[I].StdItem.MakeIndex = g_BoxsMakeIndex then begin
        g_JLBoxItems[I].StdItem.MakeIndex := 0;
        g_BoxsFilleFlashImg := 0;
        g_BoxsIsFill := 6;
        Break;
      end;
    end;
  end;
end;

procedure TfrmMain.ClientJLBoxKey;
var
  I, J:   Integer;
  temp: TBoxsInfo;
begin
  if not g_boJLBoxFirstStartSel then begin
    if g_nFilledGetItmesID > 0 then Dec(g_nFilledGetItmesID);
    MyPlaySound(BoxonCeagain_ground);
  end;
  FrmDlg.ShowBoxsGird(False,g_boNewBoxs); //ÏÔÊ¾±¦Ïä¸ñ
  g_boBoxsMiddleItems := False;
  g_BoxsFilleFlashImg := 0;
  g_BoxsIsFill := 3; //ÏÔÊ¾¿ªÊ¼Ñ¡Ôñ¶¯»­
  FrmDlg.DJLChangeItem.ShowHint := True;
  FrmDlg.DJLStartItem.ShowHint := True;
  g_boBoxsLockGetItems := True;
  if g_nFilledGetItmesID = 0 then FrmDlg.DJLStartItem.Hint := 'Ãâ·Ñ½±Àø';
  //Êý×éËæ»ú
  //-------------------------------------------
  randomize;
  for I:= 0 to 4 do begin
    J:= random(8);
    temp := g_JLBoxItems[I];
    g_JLBoxItems[I] := g_JLBoxItems[J];
    g_JLBoxItems[J] := temp;
  end;
  //-------------------------------------------
  g_BoxsMoveDegree := 9;
  g_boJLBoxFirstStartSel := False;
end;
//½ÓÊÕÕäçç±¦Ïä×ÓÃâ·Ñ½±Àø
procedure TfrmMain.ClientGetJLBoxFreeItems(body: string);
var
   I: Integer;
   pcm: TBoxsInfo;
   str: string;
begin
  FillChar (g_JLBoxFreeItems, SizeOf(TJLBoxFreeItem)*20, #0); //Õäçç±¦ÏäÃâ·Ñ½±Àø
  while TRUE do begin
    if body = '' then break;
    for I:=Low(g_JLBoxFreeItems) to High(g_JLBoxFreeItems) do begin
      body := GetValidStr3 (body, str, ['/']);
      DecodeBuffer (str, @pcm, sizeof(TBoxsInfo));
      g_JLBoxFreeItems[I].Item := pcm;
    end;
  end;
end;

procedure TfrmMain.WMMove(var Message: TWMMove);
begin
  m_Point := DxDraw.ClientOrigin;
end;

procedure TfrmMain.SendShopItems(sTitle: string);
var
  I: integer;
  ClientShopItem: TClientShopItem;
  msg: TDefaultMessage;
  sMsg: string;
Begin
  if g_MySelf <> nil Then begin
    g_MySelf.m_boIsShop := True;
    g_MySelf.m_sShopMsg := sTitle;
    FrmDlg.DItemBag.Visible := False;
    sMsg := EncodeString(g_MySelf.m_sShopMsg) + '/';
    for I:= Low(g_ShopItems) to High(g_ShopItems) do begin
      if g_ShopItems[I].Item.s.Name <> '' then begin
        FillChar(ClientShopItem, SizeOf(TClientShopItem), #0);
        ClientShopItem.nItemIdx := g_ShopItems[I].Item.MakeIndex;
        ClientShopItem.nPic := g_ShopItems[I].nPic;
        ClientShopItem.boCls := g_ShopItems[I].boCls;
        sMsg := sMsg + EncodeBuffer(@ClientShopItem, SizeOf(TClientShopItem))+'/';
      end;
    end;
    {msg := MakeDefaultMsg(aa(CM_SELFSHOPITEMS, TempCertification), 0, 0, 0, 0, m_nSendMsgCount);
    SendSocket(EncodeMessage(msg) + sMsg);  }
    g_MySelf.SendMsg (CM_SELFSHOPITEMS, 0, 0, 0, 0, 0, sMsg, 0, g_nilFeature);
  end;
end;

procedure TfrmMain.ClientGetSelfShopItmes(body: string);
var
  ShopItem: TShopItem;
  i: integer;
  str: string;
begin
  try //³ÌÐò×Ô¶¯Ôö¼Ó
    FillChar(g_ShopItems, SizeOf(TShopItem) * 10, #0);
    I := 0;
    while True do begin
      if body = '' then break;
      if i > 9 then break;
      body := GetValidStr3(body, str, ['/']);
      DecodeBuffer(str, @ShopItem, sizeof(TShopItem));
      g_ShopItems[I] := ShopItem;
      Inc(I);
    end;
    g_MySelf.m_boIsShop := True;
    //FrmDlg.DSelfShop.Visible := True;
  except //³ÌÐò×Ô¶¯Ôö¼Ó
    DebugOutStr('[Exception] TfrmMain.ClientGetSelfShopItmes');
    //³ÌÐò×Ô¶¯Ôö¼Ó
  end; //³ÌÐò×Ô¶¯Ôö¼Ó
end;

procedure TfrmMain.SendCloseShopItems();
var
  msg: TDefaultMessage;
begin
  try //³ÌÐò×Ô¶¯Ôö¼Ó
    if g_MySelf <> nil then begin
      g_MySelf.m_boIsShop := False;
      msg := MakeDefaultMsg(aa(CM_SELFCLOSESHOP, TempCertification), 0, 0, 0, 0, m_nSendMsgCount);
      SendSocket(EncodeMessage(msg));
    end;
  except //³ÌÐò×Ô¶¯Ôö¼Ó
    DebugOutStr('[Exception] TfrmMain.SendCloseShopItems'); //³ÌÐò×Ô¶¯Ôö¼Ó
  end; //³ÌÐò×Ô¶¯Ôö¼Ó
end;

procedure TfrmMain.ClientGetShopItmes(Actor: TActor; body: string);
var
  ShopItem: TShopItem;
  i: integer;
  str: string;
begin
  try //³ÌÐò×Ô¶¯Ôö¼Ó
    FillChar(g_UserShopItem, SizeOf(TShopItem) * 10, #0);
    i := 0;
    g_sShopName := Actor.m_sShopMsg;
    g_nShopX := Actor.m_nCurrX;
    g_nShopY := Actor.m_nCurrY;
    g_nShopActorIdx := Actor.m_nRecogId;
    g_btShopIdx := 255;
    if g_dShopSelImage = nil then begin
      g_dShopSelImage := TDirectDrawSurface.Create(DXDraw.DDraw);
      g_dShopSelImage.SystemMemory := TRUE;
      g_dShopSelImage.SetSize (34, 32);
      g_dShopSelImage.FillRect(g_dShopSelImage.ClientRect, $00004000);
      //g_dShopSelImage.Fill($0000DC00);
    end;
    while True do begin
      if body = '' then break;
      if i > 9 then break;
      body := GetValidStr3(body, str, ['/']);
      DecodeBuffer(str, @ShopItem, sizeof(TShopItem));
      g_UserShopItem[I] := ShopItem;
      Inc(I);
    end;
    //FrmDlg.DlgShopItem.Item.s.Name := '';
    FrmDlg.DWUserStall.Visible := True;
  except //³ÌÐò×Ô¶¯Ôö¼Ó
    DebugOutStr('[Exception] TfrmMain.ClientGetShopItmes'); //³ÌÐò×Ô¶¯Ôö¼Ó
  end; //³ÌÐò×Ô¶¯Ôö¼Ó
end;

procedure TfrmMain.SendSelfShopBuy(ActorIdx, nX, nY, sItemidx: Integer);
var
  msg: TDefaultMessage;
begin
  try //³ÌÐò×Ô¶¯Ôö¼Ó
    msg := MakeDefaultMsg(aa(CM_SELFSHOPBUY, TempCertification), ActorIdx, nX, nY, 0, m_nSendMsgCount);
    SendSocket(EncodeMessage(msg) + EncodeString(IntToStr(sItemidx)));
  except //³ÌÐò×Ô¶¯Ôö¼Ó
    DebugOutStr('[Exception] TfrmMain.SendSelfShopBuy'); //³ÌÐò×Ô¶¯Ôö¼Ó
  end; //³ÌÐò×Ô¶¯Ôö¼Ó
end;

procedure TfrmMain.SendShopMsg(wIdent: Word; str: string);
var
  msg: TDefaultMessage;
begin
    msg := MakeDefaultMsg(aa(wIdent, TempCertification), 0, 0, 0, 0, m_nSendMsgCount);
    SendSocket(EncodeMessage(msg) + str);
end;
{$IF M2Version <> 2}
//ÎäÆ÷²ðÐ¶³àÑ×Ê¯ 20100708
procedure TfrmMain.ClientGetSendUserArmsTear (merchant: integer);
begin
   FrmDlg.CloseDSellDlg;
   g_nCurMerchant := merchant;
   FrmDlg.SpotDlgMode := dmArmsTear;
   FrmDlg.ShowShopSellDlg;
end;

//·¢ËÍÎäÆ÷²ðÐ¶³àÑ×Ê¯µÄÎïÆ·  20100708
procedure TfrmMain.SendArmsTear (merchant, itemindex: integer; itemname: string);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_USERARMSTEARITEM, TempCertification), merchant, Loword(itemindex), Hiword(itemindex), 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg) + EncodeString (itemname));
end;

procedure TfrmMain.ClientGetMoveHMShow(ActorId, SessionID: Integer);
var
  MoveShow: pTMoveHMShow;
  str: string;
  I: Integer;
  Actor: TActor;
Begin
  try //³ÌÐò×Ô¶¯Ôö¼Ó
    Actor := PlayScene.FindActor (ActorId);
    if (Actor = nil) or (Actor.m_btRace = 50) then Exit;
    //If (Not g_wgInfo.boMoveRedShow) Or (Not g_ClientWgInfo.boMoveRedShow) Then Exit;
    with Actor do begin
      New(MoveShow);
      MoveShow.sMoveHpstr := Format('-%d',[SessionID]);//'-'+IntToStr(SessionID);
      MoveShow.boMoveHpShow := True;
      MoveShow.nMoveHpEnd := 0;
      m_nMoveHpList.Add(MoveShow);
    end;
  except //³ÌÐò×Ô¶¯Ôö¼Ó
    DebugOutStr('[Exception] TfrmMain.ClientGetMoveHMShow'); //³ÌÐò×Ô¶¯Ôö¼Ó
  end; //³ÌÐò×Ô¶¯Ôö¼Ó
end;
//Ç©¶¨Ìá½»ÎïÆ·¿ò
procedure TfrmMain.ClientGetSendUserArmsExchange(merchant: integer);
begin
   FrmDlg.CloseDSellDlg;
   g_nCurMerchant := merchant;
   FrmDlg.SpotDlgMode := dmArmsExchange;
   FrmDlg.ShowShopSellDlg;
end;
//²éÑ¯Ç©¶¨ÊýÁ¿
procedure TfrmMain.SendQueryArmsExchangeCost (merchant, itemindex: integer; itemname: string);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_MERCHANTQUERYARMSEXCHANGEPRICE, TempCertification), merchant, Loword(itemindex), Hiword(itemindex), 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg) + EncodeString (itemname));
end;

procedure TfrmMain.SendArmsExchange(merchant, itemindex: integer; itemname: string);//20100708
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (aa(CM_USERARMSEXCHANGE, TempCertification), merchant, Loword(itemindex), Hiword(itemindex), 0, m_nSendMsgCount);
   SendSocket (EncodeMessage (msg) + EncodeString (itemname));
end;

procedure TfrmMain.SendNewSginedItem(itemindex1, itemindex2: Integer);
var
  msg: TDefaultMessage;
  sMsg: string;
begin
  msg := MakeDefaultMsg(aa(CM_NewUSERKAMPO, TempCertification), itemindex1, Loword(itemindex2), Hiword(itemindex2), 0, m_nSendMsgCount);
  sMsg := EncodeBuffer(@g_XinJianDingData, SizeOf(g_XinJianDingData));
  SendSocket(EncodeMessage(msg) + EncodeString(sMsg));
end;

procedure TfrmMain.SendSginedItem(itemindex1, itemindex2: Integer; SginedItemType: Byte);
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (aa(CM_USERKAMPO, TempCertification), itemindex1, Loword(itemindex2), Hiword(itemindex2), SginedItemType, m_nSendMsgCount);
   SendSocket (EncodeMessage (msg));
end;

procedure TfrmMain.SendChangeSginedItem(itemindex1, itemindex2: Integer);
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (aa(CM_USERCHANGEKAMPO, TempCertification), itemindex1, Loword(itemindex2), Hiword(itemindex2), 0, m_nSendMsgCount);
   SendSocket (EncodeMessage (msg));
end;

procedure TfrmMain.SendMakeScroll(ItemIndex: Integer; btType: Byte);
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (aa(CM_USERMAKESCROLL, TempCertification), ItemIndex, btType, 0, 0, m_nSendMsgCount);
   SendSocket (EncodeMessage (msg));
end;

procedure TfrmMain.SendMakeReadScroll(ItemIndex1, ItemIndex2: Integer);
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (aa(CM_USERSCROLLCHANGEITME, TempCertification), itemindex1, Loword(itemindex2), Hiword(itemindex2), 0, m_nSendMsgCount);
   SendSocket (EncodeMessage (msg));
end;

procedure TfrmMain.SendTakeOnLingMei (itmindex: integer; itmname: string);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_TAKEONSPIRITITEM, TempCertification), itmindex, 0, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg) + EncodeString (itmname));
end;

procedure TfrmMain.SendTakeOffLingMei (itmindex: integer; itmname: string);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_TAKEOFFSPIRITITEM, TempCertification), itmindex, 0, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg) + EncodeString (itmname));
end;

procedure TfrmMain.SendUserJudge(itmindex: integer; itmname: string);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_USERJUDGE, TempCertification), itmindex, 0, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg) + EncodeString (itmname));
end;

procedure TfrmMain.SendUseUserLingMei(itmindex: Integer; itmname: string);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_USERFINDJEWEL, TempCertification), itmindex, 0, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg) + EncodeString (itmname));
end;

procedure TfrmMain.SendUseLingMeiAnimal (x, y: Integer);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_USERDIGJEWELITME, TempCertification), MakeLong(x,y), 0, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg));
end;

{$IF M2Version = 1}
// Who£º0ÎªÖ÷ÈË£¬ÆäËûÎªÓ¢ÐÛ
procedure TfrmMain.SendQJPractice(ItemIndex: Integer; Page: Byte; btWho: Byte);
var
  msg: TDefaultMessage;
begin
  if (ItemIndex > 0) then begin
    msg := MakeDefaultMsg (aa(CM_SKILLTOJINGQING, TempCertification), ItemIndex, Page, btWho, 0, m_nSendMsgCount);
    SendSocket (EncodeMessage (msg) + '');
  end;
end;
// Who£º0ÎªÖ÷ÈË£¬ÆäËûÎªÓ¢ÐÛ
procedure TfrmMain.SendOpenupSkill95(ItemIndex: Integer; btWho: Byte);
var
  msg: TDefaultMessage;
begin
  if (ItemIndex > 0) then begin
    msg := MakeDefaultMsg (aa(CM_OPENUPSKILL95, TempCertification), ItemIndex, btWho, 0, 0, m_nSendMsgCount);
    SendSocket (EncodeMessage (msg) + '');
  end;
end;

// Who£º0ÎªÖ÷ÈË£¬ÆäËûÎªÓ¢ÐÛ
procedure TfrmMain.SendQJAutoPractice(autotype: Byte; btWho: Byte);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_AUTOGAMEGIRDUPSKILL95, frmMain.TempCertification), autotype, btWho, 0, 0, frmMain.m_nSendMsgCount);
  frmMain.SendSocket (EncodeMessage (msg));
end;
{$IFEND}

procedure TfrmMain.ClientGetLingMeiItem(str: string);
var
  cu: TClientItem;
begin
  if str <> '' then begin
    DecodeBuffer (str, @cu, sizeof(TClientItem));
    FillChar(g_LingMeiBelt, SizeOf(TClientItem), #0); //Çå¿Õ
    g_LingMeiBelt := cu;
  end;
end;

procedure TfrmMain.ClientGetSigned;
var
  I: Integer;
begin
  with FrmDlg do begin
    if m_btSignedItemsPage = 1 then begin
      if g_SignedItem[0].btAppraisalLevel in [2..4,12..14,22..24,32..34,42..44,52..54] then begin
        if g_SignedItem[1].s.Name = '' then begin
          for I:=6 to MAXBAGITEMCL-1 do begin
            if (g_ItemArr[I].Item.s.StdMode = 18) and (g_ItemArr[I].Item.s.Shape = 1) then begin
              g_SignedItem[1] := g_ItemArr[I].Item;
              g_ItemArr[I].Item.s.Name := '';
              Break;
            end;
          end;
        end;
      end;
    end else begin
      case g_SignedItem[0].btAppraisalLevel of
        1,11,21,31,41,51: begin
          DBOrdSigned.Hint := 'ÆÕÍ¨Ò»¼ø';
          DBHighSigned.Hint := '¸ß¼¶Ò»¼ø';
          DBOrdSigned.Enabled := True;
          DBHighSigned.Enabled := True;
          if (g_SignedItem[1].s.Name = '') and not ((g_SignedItem[0].s.StdMode = 5) and (g_SignedItem[0].s.Need = 32767))  then begin
            for I:=6 to MAXBAGITEMCL-1 do begin
              if (g_ItemArr[I].Item.s.Name <> '') and (g_ItemArr[I].Item.s.StdMode = 17) and (g_ItemArr[I].Item.s.Shape = 239) then begin
                g_SignedItem[1] := g_ItemArr[I].Item;
                g_ItemArr[I].Item.s.Name := '';
                Break;
              end;
            end;
          end;
        end;
        2,12,22,32,42,52: begin
          DBOrdSigned.Hint := 'ÆÕÍ¨¶þ¼ø';
          DBHighSigned.Hint := '¸ß¼¶¶þ¼ø';
          DBOrdSigned.Enabled := True;
          DBHighSigned.Enabled := True;
          if (g_SignedItem[1].s.Name = '') and not ((g_SignedItem[0].s.StdMode = 5) and (g_SignedItem[0].s.Need = 32767))  then begin
            for I:=6 to MAXBAGITEMCL-1 do begin
              if (g_ItemArr[I].Item.s.Name <> '') and (g_ItemArr[I].Item.s.StdMode = 17) and (g_ItemArr[I].Item.s.Shape = 240) then begin
                g_SignedItem[1] := g_ItemArr[I].Item;
                g_ItemArr[I].Item.s.Name := '';
                Break;
              end;
            end;
          end;
        end;
        3,13,23,33,43,53: begin
          DBOrdSigned.Hint := 'ÆÕÍ¨Èý¼ø';
          DBHighSigned.Hint := '¸ß¼¶Èý¼ø';
          DBOrdSigned.Enabled := True;
          DBHighSigned.Enabled := True;
          if (g_SignedItem[1].s.Name = '') and not ((g_SignedItem[0].s.StdMode = 5) and (g_SignedItem[0].s.Need = 32767))  then begin
            for I:=6 to MAXBAGITEMCL-1 do begin
              if (g_ItemArr[I].Item.s.Name <> '') and (g_ItemArr[I].Item.s.StdMode = 17) and (g_ItemArr[I].Item.s.Shape = 241) then begin
                g_SignedItem[1] := g_ItemArr[I].Item;
                g_ItemArr[I].Item.s.Name := '';
                Break;
              end;
            end;
          end;
        end;
        else begin
          DBOrdSigned.Hint := 'ÆÕÍ¨¼ø¶¨';
          DBHighSigned.Hint := '¸ß¼¶¼ø¶¨';
          DBOrdSigned.Enabled := False;
          DBHighSigned.Enabled := False;
        end;
      end;
    end;
  end;
end;

procedure TfrmMain.ClientGetSignedItem (body: string);
var
  cu: TClientItem;
begin
  if body <> '' then begin
    DecodeBuffer (body, @cu, sizeof(TClientItem));
    FillChar(g_SignedItem[0], SizeOf(TClientItem), #0); //Çå¿Õ
    g_SignedItem[0] := cu;
  end;
end;

procedure TfrmMain.ClientGetJudgeOk(num: Word);
  function GetStar(): Byte;
  begin
    case g_JudgeItems.btAppraisalLevel of
      0..4: Result := 0;
      11..14: Result := 1;
      21..24: Result := 2;
      31..34: Result := 3;
      41..44: Result := 4;
      51..54: Result := 5;
    end;
  end;
begin
  FrmDlg.DMessageDlg (Format('ÄãµÄ%sÆ·ÆÀ·ÖÊýÎª%d£¬Îª%dÐÇ±¦Îï£¬²¢ÇÒ½øÈëÁË×°±¸°ñµÄÅÅÐÐ', [g_JudgeItems.s.Name, num, GetStar()]), [mbOK]);
end;

procedure TfrmMain.ClientGetJudgeFail(num: Word);
  function GetStar(): Byte;
  begin
    case g_JudgeItems.btAppraisalLevel of
      0..4: Result := 0;
      11..14: Result := 1;
      21..24: Result := 2;
      31..34: Result := 3;
      41..44: Result := 4;
      51..54: Result := 5;
    end;
  end;
begin
  FrmDlg.DMessageDlg(Format('ÄãµÄ%sÆÀ·ÖÊýÎª%d£¬Îª%dÐÇ±¦Îï£¬ºÜÒÅº¶£¬ÕâÑùµÄ·ÖÊý\²»×ãÒÔ½øÈë±¦ÎïÅÅÐÐ°ñ', [g_JudgeItems.s.Name, num, GetStar()]), [mbOK]);
end;
//Index-³ÆºÅID btType 0 £­¹Ø±Õ³ÆºÅ 1£­ÆôÓÃ³ÆºÅ
procedure TfrmMain.SendTitleSet(Index: Integer; btType: Byte);
var
  msg: TDefaultMessage;
begin
  if (Index > 0) then begin
    msg := MakeDefaultMsg (aa(CM_SETUSERTITLES, TempCertification), Index, btType, 0, 0, m_nSendMsgCount);
    SendSocket (EncodeMessage (msg) + '');
  end;
end;
procedure TfrmMain.SendNGUpLevel(MagicID: Word; boIsHero: Boolean);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_NGMAGICLVEXP, TempCertification), MagicID, BoolToInt(boIsHero), 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg) + '');
end;
{$IFEND}

procedure TfrmMain.OPENSHINY(body: string);
var
  I: Integer;
  TreeNode: TDTreeNode;
begin
  if body = '' then Exit;
  if FrmDlg.DTreeViewMission1.Count > 0 then begin
    for I:=0 to FrmDlg.DTreeViewMission1.TreeNodeList.Count - 1 do begin
      if TMissionLabel(FrmDlg.DTreeViewMission1.TreeNodeList[I]).m_sCmd = body then begin
        TDTreeNode(FrmDlg.DTreeViewMission1.TreeNodeList[I]).Checked := True;
        TDTreeNode(FrmDlg.DTreeViewMission1.TreeNodeList[I]).Expand := True;
        Break;
      end;
    end;
    if not FrmDlg.DWMission.Visible then FrmDlg.DWMission.Visible := True;
  end;
end;

function TfrmMain.GetWNpcImg(Idx, nFrame: Integer; var ax,
  ay: Integer): TDirectDrawSurface;
begin
  Result:=nil;
  if Idx > 94 then begin
    Result:=g_WNpc2ImgImages.GetCachedImage(nFrame,ax,ay);
  end else begin
    Result:=g_WNpcImgImages.GetCachedImage(nFrame,ax,ay);
  end;
end;

{$IF M2Version <> 2}
procedure TfrmMain.ClientGetTitleHumName(body: string; btType: Byte);
var
  I: Integer;
  data: string;
  pcm: pTClientHumName;
begin
  if btType = 0 then begin
    if g_TitleHumNameList.Count > 0 then begin
     for i:=0 to g_TitleHumNameList.Count-1 do
       if pTClientHumName (g_TitleHumNameList[i]) <> nil then Dispose (pTClientHumName (g_TitleHumNameList[i]));
     g_TitleHumNameList.Clear;
    end;
    while TRUE do begin
      if body = '' then break;
      body := GetValidStr3 (body, data, ['/']);
      if data <> '' then begin
         new (pcm);
         DecodeBuffer (data, @(pcm^), sizeof(TClientHumName));
         g_TitleHumNameList.Add (pcm);
      end else Break;
    end;
    with FrmDlg do begin
      m_btPJLingPaiPage := 0;
      m_sSelPJLingPaiName := '';
      DLabel12.Visible := False;
      DWPFLingPai.Visible := True;
    end;
  end else begin
    if g_HuWeiJunList.Count > 0 then begin
     for i:=0 to g_HuWeiJunList.Count-1 do
       if pTClientHumName (g_HuWeiJunList[i]) <> nil then Dispose (pTClientHumName (g_HuWeiJunList[i]));
     g_HuWeiJunList.Clear;
    end;
    while TRUE do begin
      if body = '' then break;
      body := GetValidStr3 (body, data, ['/']);
      if data <> '' then begin
         new (pcm);
         DecodeBuffer (data, @(pcm^), sizeof(TClientHumName));
         g_HuWeiJunList.Add (pcm);
      end else Break;
    end;
    with FrmDlg do begin
      m_btZZHWLingPaiPage := 0;
      ChangeZZLingPaiPage(0);
      m_sSelHWLingPaiName := '';
      DLabel15.Visible := False;
      DWZZLingPai.Visible := True;
    end;
  end;
end;
//btType{ÀàÐÍ 0-»¤»¨ÁîÅÆ 1-Ö÷Ô×ÁîÅÆ}, btOperation{²Ù×÷ÀàÐÍ 0-ÕÙ»½ 1-´«ËÍ}, sName{Ãû×Ö}
procedure TfrmMain.SendCallFengHao(btType, btOperation: Byte; sName: string);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_CALLFENGHAO, TempCertification), btType, btOperation, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg) + EncodeString(sName));
end;
//btType{ÀàÐÍ 0-»¤»¨ÁîÅÆ 1-Ö÷Ô×ÁîÅÆ}, sName{Ãû×Ö}
procedure TfrmMain.SendReFenghao(btType: Byte; sName: string);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_RECYCFENGHAO, TempCertification), btType, 0, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg) + EncodeString(sName));
end;

procedure TfrmMain.ClientGetDominatList(body: string);
var
  cu: TClientDominatPoint;
  str: string;
begin
  with FrmDlg do begin
    DBZZLingPaiMapName1.Caption := '';
    DBZZLingPaiMapName2.Caption := '';
    DBZZLingPaiMapName3.Caption := '';
    DBZZLingPaiMapName4.Caption := '';
    DBZZLingPaiMapName5.Caption := '';
    DBZZLingPaiMapName6.Caption := '';
    DBZZLingPaiMapName7.Caption := '';
    DBZZLingPaiMapName8.Caption := '';
    DBZZLingPaiMapName9.Caption := '';
    DBZZLingPaiMapName10.Caption := '';
    DBZZLingPaiMapName11.Caption := '';
    DBZZLingPaiMapName12.Caption := '';
    DBZZLingPaiMapName13.Caption := '';
    DBZZLingPaiMapName14.Caption := '';
    DBZZLingPaiMapName15.Caption := '';
    DBZZLingPaiMapName16.Caption := '';
    DBZZLingPaiMapName17.Caption := '';
    DBZZLingPaiMapName18.Caption := '';
  end;
  while TRUE do begin
    if body = '' then break;
    body := GetValidStr3 (body, str, ['/']);
    DecodeBuffer (str, @cu, sizeof(TClientDominatPoint));
    with FrmDlg do
    case cu.nIdx of
      1: DBZZLingPaiMapName1.Caption := cu.m_sMapDesc;
      2: DBZZLingPaiMapName2.Caption := cu.m_sMapDesc;
      3: DBZZLingPaiMapName3.Caption := cu.m_sMapDesc;
      4: DBZZLingPaiMapName4.Caption := cu.m_sMapDesc;
      5: DBZZLingPaiMapName5.Caption := cu.m_sMapDesc;
      6: DBZZLingPaiMapName6.Caption := cu.m_sMapDesc;
      7: DBZZLingPaiMapName7.Caption := cu.m_sMapDesc;
      8: DBZZLingPaiMapName8.Caption := cu.m_sMapDesc;
      9: DBZZLingPaiMapName9.Caption := cu.m_sMapDesc;
      10: DBZZLingPaiMapName10.Caption := cu.m_sMapDesc;
      11: DBZZLingPaiMapName11.Caption := cu.m_sMapDesc;
      12: DBZZLingPaiMapName12.Caption := cu.m_sMapDesc;
      13: DBZZLingPaiMapName13.Caption := cu.m_sMapDesc;
      14: DBZZLingPaiMapName14.Caption := cu.m_sMapDesc;
      15: DBZZLingPaiMapName15.Caption := cu.m_sMapDesc;
      16: DBZZLingPaiMapName16.Caption := cu.m_sMapDesc;
      17: DBZZLingPaiMapName17.Caption := cu.m_sMapDesc;
      18: DBZZLingPaiMapName18.Caption := cu.m_sMapDesc;
    end;
  end;
end;

procedure TfrmMain.SendSelDominatMap(sMapName: string);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_WORLDFLY, TempCertification), 0, 0, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg) + EncodeString(sMapName));
end;
//btHide 1ÎªÒþ²Ø ÆäËûÎªÏÔÊ¾
procedure TfrmMain.SendHideTitle(btHide: Byte);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_SETSHOWFENGHAO, TempCertification), btHide, 0, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg));
end;
procedure TfrmMain.ClientGetNGUpLevel(msg: TDefaultMessage; boIsHero: Boolean);
var
	I: Integer;
begin
  if boIsHero then begin
    for i:=g_HeroInternalForceMagicList.Count-1 downto 0 do begin
      if PTClientMagic(g_HeroInternalForceMagicList[i]).Def.wMagicId = msg.Recog then begin
        PTClientMagic(g_HeroInternalForceMagicList[i]).Level := msg.Param;
        PTClientMagic(g_HeroInternalForceMagicList[i]).Def.wMaxPower := MakeLong(msg.Tag, msg.Series);
        PTClientMagic(g_HeroInternalForceMagicList[i]).Def.wPower := msg.nSessionID;
        Break;;
      end;
    end;
  end else begin
    for i:=g_InternalForceMagicList.Count-1 downto 0 do begin
      if PTClientMagic(g_InternalForceMagicList[i]).Def.wMagicId = msg.Recog then begin
        PTClientMagic(g_InternalForceMagicList[i]).Level := msg.Param;
        PTClientMagic(g_InternalForceMagicList[i]).Def.wMaxPower := MakeLong(msg.Tag, msg.Series);
        PTClientMagic(g_InternalForceMagicList[i]).Def.wPower := msg.nSessionID;
        Break;;
      end;
    end;
  end;
  FrmDlg.NGUpLevelState(boIsHero);
  FrmDlg.NewNGUpLevelState(boIsHero);
end;
{$IFEND}

procedure TfrmMain.ClientGetPetLog(sbody: string; nHapply: Integer);
begin
  if sbody <> '' then begin
    if g_PetDlg.sLogList = nil then g_PetDlg.sLogList := TStringList.Create;
    if g_PetDlg.sLogList.Count > 0 then g_PetDlg.sLogList.Clear;
    ExtractStrings(['\'],  [' '], PChar(sbody), g_PetDlg.sLogList);
  end;
  g_PetDlg.nHapply := nHapply;
  FrmDlg.DWPetLog.Visible := True;
end;

procedure TfrmMain.SendPetLogPage(btPage: Byte);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_PETSMONHAPPLOG, TempCertification), btPage, 0, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg));
end;

procedure TfrmMain.SendPetMove;
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_MOVETOPETSMON, TempCertification), 0, 0, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg));
end;

procedure TfrmMain.ClientGetMySelfState(body: string);
begin
	DecodeBuffer (body, @g_MySelfSuitAbility, SizeOf(TClientSuitAbility));
end;

{$IF M2Version <> 2}
procedure TfrmMain.ClientGetMyHeroState(body: string);
begin
	DecodeBuffer (body, @g_MyHeroSuitAbility, SizeOf(TClientSuitAbility));
end;

procedure TfrmMain.ClientGetFactionList (const body: string);
var
  str, data: string;
  pc: pTClientDivisionInfo;
  I: Integer;
begin
	for I:=0 to g_FactionAddList.Count-1 do
  	if pTClientDivisionInfo(g_FactionAddList[i]) <> nil then
    	Dispose(pTClientDivisionInfo(g_FactionAddList[i]));
  g_FactionAddList.Clear;
	str := body;
  while TRUE do begin
    if str = '' then break;
    str := GetValidStr3 (str, data, ['/']);
    if data <> '' then begin
      new (pc);
      DecodeBuffer (data, @(pc^), sizeof(TClientDivisionInfo));
      g_FactionAddList.Add (pc);
    end else break;
  end;
  with FrmDlg do begin
  	DLFactionApplyAdd1.Visible := False;
    DLFactionApplyAdd2.Visible := False;
    DLFactionApplyAdd3.Visible := False;
    DLFactionApplyAdd4.Visible := False;
    DLFactionApplyAdd5.Visible := False;
    for I:=0 to g_FactionAddList.Count-1 do begin
      if I > 4 then Break;
    	pc := g_FactionAddList[I];
      if pc <> nil then begin
        if (pc.nStatus in [0..2]) and (pc.nStatus <> 2) then begin
          case I of
            0: begin
              with DLFactionApplyAdd1 do begin
                if pc.nStatus = 0 then
                  Caption := 'ÉêÇë¼ÓÈë'
                else Caption := 'È¡ÏûÉêÇë';
                Visible := True;
              end;
            end;
            1: begin
              with DLFactionApplyAdd2 do begin
                if pc.nStatus = 0 then
                  Caption := 'ÉêÇë¼ÓÈë'
                else Caption := 'È¡ÏûÉêÇë';
                Visible := True;
              end;
            end;
            2: begin
              with DLFactionApplyAdd3 do begin
                if pc.nStatus = 0 then
                  Caption := 'ÉêÇë¼ÓÈë'
                else Caption := 'È¡ÏûÉêÇë';
                Visible := True;
              end;
            end;
            3: begin
              with DLFactionApplyAdd4 do begin
                if pc.nStatus = 0 then
                  Caption := 'ÉêÇë¼ÓÈë'
                else Caption := 'È¡ÏûÉêÇë';
                Visible := True;
              end;
            end;
            4: begin
              with DLFactionApplyAdd5 do begin
                if pc.nStatus = 0 then
                  Caption := 'ÉêÇë¼ÓÈë'
                else Caption := 'È¡ÏûÉêÇë';
                Visible := True;
              end;
            end;
          end;
        end;
      end;
    end;
    DWFactionAddDlg.Visible := True;
  end;
end;

procedure TfrmMain.SendFactionAddPageChanged(btPage: Byte);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_QUERYDIVISIONLIST, TempCertification), btPage, 0, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg));
end;

procedure TfrmMain.SendFactionAddQueryListByName(sName: string);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_NAMEQUERYDIVISIONLIST, TempCertification), 0, 0, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg)+ EncodeString(sName));
end;

procedure TfrmMain.SendFactionAddApplyAdd(sDivisionName: string);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_APPLYDIVISION, TempCertification), 0, 0, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg)+ EncodeString(sDivisionName));
end;

procedure TfrmMain.SendFactionDlg();
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_OPENDIVISIONDLG, TempCertification), 0, 0, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg));
end;

procedure TfrmMain.ClientGetOpenFactionDlg (bodystr: string);
var
   str, data: string;
begin
	FillChar(g_FactionDlg, SizeOf(TFactionDlg), #0);
	if g_FactionDlg.NoticeList = nil then g_FactionDlg.NoticeList := TStringList.Create;

   str := DecodeString (bodystr);
   str := GetValidStr3 (str, g_FactionDlg.sDivisionName, [#13]);
   str := GetValidStr3 (str, data, [#13]);
   g_FactionDlg.boIsAdmin := data = '1';
   str := GetValidStr3 (str, g_FactionDlg.sHeartName, [#13]);
   str := GetValidStr3 (str, g_FactionDlg.sHeartTpye, [#13]);
   str := GetValidStr3 (str, data, [#13]);
   g_FactionDlg.nPopularity := Str_ToInt(data, 0);
   str := GetValidStr3 (str, g_FactionDlg.sMasterName, [#13]);
   g_FactionDlg.boPublic := g_FactionDlg.sMasterName = ' ';
   str := GetValidStr3 (str, g_FactionDlg.sMemberCount, [#13]);
	 str := GetValidStr3 (str, data, [#13]);
   g_FactionDlg.nHeartLeve := StrToInt(data);

   g_FactionDlg.NoticeList.Clear;
   while TRUE do begin
      if str = '' then break;
      str := GetValidStr3 (str, data, [#13]);
      g_FactionDlg.NoticeList.Add (data);
   end;
   FrmDlg.ShowFactionDlg;
end;

procedure TfrmMain.SendOpenFactionDLgHome();
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_DIVISIONHOME, TempCertification), 0, 0, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg));
end;

procedure TfrmMain.SendGetFactionMemberList();
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_DIVISIONMEMBERLIST, TempCertification), 0, 0, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg));
end;
procedure TfrmMain.ClientGetFactionMemberList (body: string);
var
  str, data, rankname, members: string;
  rank, lx, ly, sx: integer;
  I: Integer;
  pc: pTClientDivisionMember;
  FactionMember: TFactionMember;
begin
  FillChar(g_FactionMember, SizeOf(TFactionMember), #0);
  if g_FactionMeberList <> nil then begin
    for I:=0 to g_FactionMeberList.Count-1 do begin
      FactionMember := TFactionMember(g_FactionMeberList.Values[g_FactionMeberList.Keys[i]]);
      if FactionMember <> nil then FactionMember.Free;
    end;
    g_FactionMeberList.Clear;
  end else g_FactionMeberList := TCnHashTableSmall.Create;
  str := DecodeString(body);
  I := 0;
  lx := 28;
  while TRUE do begin
    if str = '' then break;
    if I > 39 then break;
    str := GetValidStr3 (str, data, ['/']);
    if data <> '' then begin
      if data[1] = '#' then begin
        rank := Str_ToInt (Copy(data, 2, Length(data)-1), 0);
        continue;
      end;
      new (pc);
      try
        DecodeBuffer (data, @(pc^), sizeof(TClientDivisionMember));
        if rank = 1 then begin
          sx := g_FactionMember.AdminNum*110;
          ly := 106;
          Inc(g_FactionMember.AdminNum);
        end else begin
          sx := (g_FactionMember.MemberNum mod 4)*110;
          ly := 146+(g_FactionMember.MemberNum div 4)*20;
          Inc(g_FactionMember.MemberNum);
        end;
        FrmDlg.AddFactionMember(pc^, lx+sx, ly);
      finally
        Dispose(pc);
      end;
    end;
    Inc(I);
  end;
  g_FactionDlgHint := '³ÉÔ±ÁÐ±í';
  FrmDlg.m_btFactionPage := 1;
end;

procedure TfrmMain.SendFactionDlgUpdateNotice (notices: string);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_DIVISIONUPDATENOTICE, TempCertification), 0, 0, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg) + EncodeString (notices));
end;

procedure TfrmMain.SendFactionMemberDel(who: string);
var
  msg: TDefaultMessage;
begin
  if Trim(who) <> '' then begin
    msg := MakeDefaultMsg (aa(CM_DIVISIONDDELMEMBER, TempCertification), 0, 0, 0, 0, m_nSendMsgCount);
    SendSocket (EncodeMessage (msg) + EncodeString (who));
  end;
end;
procedure TfrmMain.SendGetFactionManageApplyList();
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_DIVISIONAPPLYLIST, TempCertification), 0, 0, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg));
end;

procedure TfrmMain.ClientGetFactionApplyManageList(body: string);
var
  str, data: string;
begin
  if g_FactionApplyManageNameList <> nil then
    g_FactionApplyManageNameList.Clear
  else g_FactionApplyManageNameList := TStringList.Create;
  str := DecodeString(body);
  while TRUE do begin
    if str = '' then break;
    str := GetValidStr3 (str, data, ['/']);
    if data <> '' then begin
      g_FactionApplyManageNameList.Add(data)
    end else Break;
  end;
  FillChar(g_FactionApplyManageSel, SizeOf(g_FactionApplyManageSel), #0);
  FrmDlg.DWFactionApplyManage.Visible := True;
end;

procedure TfrmMain.SendFactionManageAgree(str: string);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_AGREEAPPLYDIVISION, TempCertification), 0, 0, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg) + EncodeString(str));
end;
procedure TfrmMain.SendFactionManageRefuse(str: string);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_CANCELAPPLYDIVISION, TempCertification), 0, 0, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg) + EncodeString(str));
end;
procedure TfrmMain.SendFactionTitle();
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_DIVISIONGETFENGHAO, TempCertification), 0, 0, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg));
end;

procedure TfrmMain.ClientOpenLingWuXinFa(msg: TDefaultMessage);
begin
  FillChar(g_LingWuXinFa, SizeOf(TLingWuXinFa), #0);
  with g_LingWuXinFa do begin
    if msg.Recog in [0..4] then
    btGetM2Type := msg.Recog;
    boChangeXinFa := msg.Param = 1;
    FrmDlg.DBLingWuXinFaName.Visible := not boChangeXinFa;
    FrmDlg.DLXinFaMakeName.Visible := not boChangeXinFa;
    FrmDlg.DLXinFaChangeSelName.Visible := boChangeXinFa;
  end;
  FrmDlg.DWLingWUXinFa.Visible := True;
end;

procedure TfrmMain.SendLingWuXinFa(btType: Byte; sName: string);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_SAVVYHEARTSKILL, TempCertification), btType, 0, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg)+EncodeString(sName));
end;

procedure TfrmMain.SendChangeLingWuXinFa(btType: Byte);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_CHANGESAVVYHEARTSKILL, TempCertification), btType, 0, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg));
end;

procedure TfrmMain.SendXinfaExpAbsorb();
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg (aa(CM_INCHEATRPOINT, TempCertification), 0, 0, 0, 0, m_nSendMsgCount);
  SendSocket (EncodeMessage (msg));
end;

procedure TfrmMain.ClientGetHeartInfo (body: string);
  function GetJobType: string;
  begin
    Result := '¹¥»÷';
    if g_MySelf = nil then Exit;
    case g_MySelf.m_btJob of
      0: Result := '¹¥»÷';
      1: Result := 'Ä§·¨';
      2: Result := 'µÀÊõ';
    end;
  end;
begin
  if body <> '' then begin
    DecodeBuffer (body, @g_HeartAbility, sizeof(TClientHeartAbility));
    with FrmDlg.DMemoXinFaHint.Lines do begin
      with g_HeartAbility do begin
        if FrmDlg.DMemoXinFaHint.Lines.Count > 0 then FrmDlg.DMemoXinFaHint.Lines.Clear;
        if not g_HeartAbility.boHeartTpye then begin //´«³Ð
          Add(Format('<·ÀÓù£º%d-%d/FColor=251>', [wUpDefence, wUpDefence]));
          Add(Format('<Ä§Óù£º%d-%d/FColor=251>', [wUpMaxDefence, wUpMaxDefence]));
          Add(Format('<¹¥»÷£º%d-%d/FColor=251>', [wMainPower, wMainMaxPower]));
          Add(Format('<Ä§·¨£º%d-%d/FColor=251>', [wMainPower, wMainMaxPower]));
          Add(Format('<µÀÊõ£º%d-%d/FColor=251>', [wMainPower, wMainMaxPower]));
          Add(Format('<ÐÄ·¨ÖÖÀà£º%sÐÄ·¨/FColor=251>', [g_XinFaName[nHeartTpye]]));
          Add('<ÐÄ·¨ÏÂÒ»¼¶/FColor=251>');
          Add('<Éý¼¶ÐèÇó£º/FColor=251>');
          Add(Format('<Ê¦¸¸ÐÄ·¨µÈ¼¶/FColor=251><%d/FColor=249><¼¶/FColor=251>', [wUpPassHeartLevel]));
          Add(Format('<±¾ÈËµÈ¼¶/FColor=251><%d/FColor=249><¼¶/FColor=251>', [wUpLevel]));
          Add('<Ê¦ÃÅµÜ×ÓÍ¨¹ýÍê³ÉÈÎÎñ»ñµÃ/FColor=251>');
          Add('<´«³ÐÐÄ·¨¾­Ñé/FColor=251>');
        end else begin //ÁúÎÀ
          Add(ForMat('<ÉñÊ¥%s£º%d-%d/FColor=251>',[GetJobType(), wMainPower, wMainMaxPower]));
          Add(Format('<ÐÄ·¨ÖÖÀà£º%sÐÄ·¨/FColor=251>', [g_XinFaName[nHeartTpye]]));
        end;
      end;
    end;
  end;
end;
{$IFEND}

end.
