unit Envir;
{地图场景}
interface

uses
  Windows, SysUtils, Classes, SDK, Grobal2;
type
  {TMapHeader = packed record//20110428 修改
    wWidth: Word;
    wHeight: Word;
    sTitle: string[16];
    UpdateDate: TDateTime;
    Reserved: array[0..22] of Char;
  end; }
  //.MAP文件头  52字节
  TMapHeader = packed record
    wWidth: Word; //宽度       2
    wHeight: Word; //高度       2
    sTitle: array[0..15] of Char; //标题      16
    UpdateDate: TDateTime; //更新日期     8
    Logo: Byte; //标识(新的格式为02 旧格式地图元素12字节 新格式地图元素14字节)           1
    Reserved: array[0..22] of Char; //保留      23
  end;

  //地图文件一个元素的定义(旧12字节)
  TMapUnitInfo = packed record
    wBkImg: Word; //为禁止移动区域(表示地图的图片)
    wMidImg: Word;
    wFrImg: Word;
    btDoorIndex: Byte;
    btDoorOffset: Byte;
    btAniFrame: Byte;
    btAniTick: Byte;
    btArea: Byte;
    btLight: Byte;
  end;
  TMap = array[0..1000 * 1000 - 1] of TMapUnitInfo;
  pTMap = ^TMap;
  //地图文件一个元素的定义(新14字节)
  TNewMapUnitInfo = packed record
    wBkImg: Word; //为禁止移动区域(表示地图的图片)
    wMidImg: Word;
    wFrImg: Word;
    btDoorIndex: Byte;
    btDoorOffset: Byte;
    btAniFrame: Byte;
    btAniTick: Byte;
    btArea: Byte;
    btLight: Byte;
    btNew: Word; //新格式多出2字节部分
  end;
  TNewMap = array[0..1000 * 1000 - 1] of TNewMapUnitInfo;
  pTNewMap = ^TNewMap;

  TMapCellinfo = record
    chFlag: Byte; //标志
    ObjList: TList;
  end;
  pTMapCellinfo = ^TMapCellinfo;
  PTEnvirnoment = ^TEnvirnoment;
  TEnvirnoment = class
    sMapName: string; //地图ID
    sMapDesc: string; //地图名称
    sMainMapName: string; //重载地图ID
    m_boMainMap: Boolean; //
    MapCellArray: array of TMapCellinfo; //
    nMinMap: Integer; //小地图数量
    nServerIndex: Integer; //0x14
    nRequestLevel: Integer; //进入本地图所需等级
    m_nWidth: Integer; //地图宽度
    m_nHeight: Integer; //地图高度
    m_boDARK: Boolean; //免蜡(T-地图全暗)
    m_boDAY: Boolean; //地图全亮
    m_boDarkness: Boolean;
    m_boDayLight: Boolean;
    m_DoorList: TList; //门列表
    bo2C: Boolean;
    m_boSAFE: Boolean; //安全区
    m_boSafeNoRun: Boolean; //安全区人物不能穿
    m_boSAFEHERONORUN: Boolean; //英雄安全区不能穿
    m_boFightZone: Boolean; //PK地图
    m_boFight2Zone: Boolean; //PK掉装备地图
    m_boFight3Zone: Boolean; //行会战争地图
    m_boFight4Zone: Boolean; //挑战地图
    m_boNoFight4Zone: Boolean; //禁止挑战地图
    m_boFight5Zone: Boolean; //不同行会名字变不同颜色 20090318
    m_boQUIZ: Boolean; //0x30
    m_boNORECONNECT: Boolean; //0x31
    m_boNEEDHOLE: Boolean; //进入需要洞
    m_boNORECALL: Boolean; //0x33
    m_boNOGUILDRECALL: Boolean;
    m_boNODEARRECALL: Boolean;
    m_boNOMASTERRECALL: Boolean;
    m_boNORANDOMMOVE: Boolean; //0x34
    m_boNODRUG: Boolean; //地图不允许使用任何药品
    m_boMINE: Boolean; //可以挖矿
    m_boDigJewel: Boolean; //可以挖宝 20100902
    m_boSHOP: Boolean; //个人商店
    m_boNOPOSITIONMOVE: Boolean; //0x37
    sNoReconnectMap: string; //0x38
    m_boHitMon: Boolean; //攻击怪触发 20110114
    sHitMonScript: string;
    QuestNPC: TObject; //0x3C
    nNEEDSETONFlag: Integer; //0x40
    nNeedONOFF: Integer; //0x44
    m_QuestList: TList; //任务地图触发
    m_boNoManNoMon: Boolean; //无人不刷怪
    m_boRUNHUMAN: Boolean; //可以穿人
    m_boRUNMON: Boolean; //可以穿怪
    m_boINCHP: Boolean; //自动加HP值
    m_boIncGameGold: Boolean; //自动减游戏币
    m_boINCGAMEPOINT: Boolean; //自动加点
    m_boDECGAMEPOINT: Boolean; //自动减游戏点
    m_boNEEDLEVELTIME: Boolean; //雪域地图传送,判断等级 20081228
    m_nNEEDLEVELPOINT: Integer; //进雪域地图最低等级
    m_boNOCALLHERO: Boolean; //禁止召唤英雄 20080124
    m_boNOHEROPROTECT: Boolean; //禁止英雄守护 20080629
    m_boNODROPITEM: Boolean; //禁止死亡掉物品 20080503
    m_boKILLFUNC: Boolean; //地图杀人触发 20080415
    m_nKILLFUNC: Integer; //地图杀人触发  20080415
    m_boMISSION: Boolean; //不允许使用任何物品和技能
    m_boNOSKILL: Boolean; //不允许使用任何技能,召唤的宝宝消失
    m_boDECHP: Boolean; //自动减HP值
    m_boDecGameGold: Boolean; //自动减游戏币
    m_boMUSIC: Boolean; //音乐
    m_boEXPRATE: Boolean; //杀怪经验倍数
    m_boCRIT: Boolean; //暴击等级
    m_nCRIT: Integer;
    m_boPeak: Boolean; //巅峰状态(提高攻击倍率)
    m_nPeakMinRate: Integer; //最低攻击倍率
    m_nPeakMaxRate: Integer; //最高攻击倍率
    m_boPKWINLEVEL: Boolean; //PK得等级
    m_boPKWINEXP: Boolean; //PK得经验
    m_boPKLOSTLEVEL: Boolean; //PK丢等级
    m_boPKLOSTEXP: Boolean; //PK丢经验
    m_nPKWINLEVEL: Integer; //PK得等级数
    m_nPKLOSTLEVEL: Integer; //PK丢等级
    m_nPKWINEXP: Integer; //PK得经验数
    m_nPKLOSTEXP: Integer; //PK丢经验
    m_nDECHPTIME: Integer; //减HP间隔时间
    m_nDECHPPOINT: Integer; //一次减点数
    m_nINCHPTIME: Integer; //加HP间隔时间
    m_nINCHPPOINT: Integer; //一次加点数
    m_nDECGAMEGOLDTIME: Integer; //减游戏币间隔时间
    m_nDecGameGold: Integer; //一次减数量
    m_nINCGAMEGOLDTIME: Integer; //加游戏币间隔时间
    m_nIncGameGold: Integer; //一次加数量
    m_nINCGAMEPOINTTIME: Integer; //加游戏币间隔时间
    m_nINCGAMEPOINT: Integer; //一次加数量
    m_nDECGAMEPOINTTIME: Integer; //减游戏币间隔时间
    m_nDECGAMEPOINT: Integer; //一次减数量
    m_boDECEXPRATETIME: Boolean; //减双倍经验时间 20090206
    m_nDECEXPRATETIME: Integer; //一次减双倍经验值 20090206
    m_boPULSEXPRATE: Boolean; //地图杀怪英雄经验倍数 20091029
    m_nPULSEXPRATE: Integer; //地图杀怪英雄经验倍数 20091029
    m_boNGEXPRATE: Boolean; //地图杀怪内功经验倍数 20091029
    m_nNGEXPRATE: Integer; //地图杀怪内功经验倍数 20091029
    m_nMUSICID: Integer; //音乐ID
    m_sMUSICName: string; //音乐ID
    m_nEXPRATE: Integer; //经验倍率
    m_nMonCount: Integer; //地图上怪物的数量
    m_nHumCount: Integer; //地图上人物的数量
    m_nHumAICount: Integer; //地图上假人的数量
    m_boUnAllowStdItems: Boolean; //是否不允许使用物品
    m_UnAllowStdItemsList: TGStringList; //不允许使用物品列表
    m_boUnAllowMagics: Boolean; //是否不允许使用魔法
    m_UnAllowMagicList: TGStringList; //不允许使用魔法列表
    m_boChangMapDrops: Boolean; //换地图掉指定物品
    m_ChangMapDropsList: TGStringList; //换地图掉指定物品列表
    m_boFIGHTPK: Boolean; //PK可以爆装备不红名
    nThunder: Integer; //雷电 地图参数 20080327
    nLava: Integer; //地上冒岩浆 地图参数  20080327
    boLimitLevel: Boolean; //当角色超过指定等级1时，按等级2值计算HP MP 地图参数
    nLimitLevel1: Integer; //指定等级1
    nLimitLevel2: Integer; //指定等级2
    nLimitLevelHero: Integer; //指定英雄等级
    nLimitLevelHero1: Integer; //指定英雄等级
    m_PointList: TList; //挂机点列表

    m_boMirrorMap: Boolean; //镜像地图
    m_boMirrorMaping: Boolean; //正在删除镜像地图
    m_dwMirrorMapTick: LongWord; //镜像地图有效时长
    sMirrorHomeMap: string; //删除镜像地图人物回城地图
  private
    procedure Initialize(nWidth, nHeight: Integer);
  public
    constructor Create();
    destructor Destroy; override;
    function AddToMap(nX, nY: Integer; btType: Byte; pRemoveObject: TObject): Pointer; //增加到地图上
    function ClearItem(nX, nY, nRage: Integer): Boolean;
    function CanWalk(nX, nY: Integer; boFlag: Boolean): Boolean;
    function CanWalkOfItem(nX, nY: Integer; boFlag, boItem: Boolean): Boolean;
    function CanWalkEx(nX, nY: Integer; boFlag: Boolean): Boolean;
    function CanFly(nSX, nSY, nDX, nDY: Integer): Boolean;
    function MoveToMovingObject(nCX, nCY: Integer; Cert: TObject; nX, nY: Integer; boFlag: Boolean): Integer;
    function GetItem(nX, nY: Integer): PTMapItem; //取地图物品
    function DeleteFromMap(nX, nY: Integer; btType: Byte; pRemoveObject: TObject): Integer; //从地图上删除
    function IsCheapStuff(): Boolean; //是否有任务地图触发
    procedure AddDoorToMap; //增加门到地图上
    //function AddToMapMineEvent(nX, nY: Integer; nType: Integer; Event: TObject): TObject; //20101025 注释
    function LoadMapData(sMapFile: string): Boolean; //读取地图数据
    function CreateQuest(nFlag, nValue: Integer; s24, s28, s2C: string; boGrouped: Boolean): Boolean;
    function GetMapCellInfo(nX, nY: Integer; var MapCellInfo: pTMapCellinfo): Boolean;
    function GetXYObjCount(nX, nY: Integer): Integer;
    function GetNextPosition(sX, sY, nDir, nFlag: Integer; var snx: Integer; var sny: Integer): Boolean;
    function sub_4B5FC8(nX, nY: Integer): Boolean;
    procedure VerifyMapTime(nX, nY: Integer; BaseObject: TObject);
    function CanSafeWalk(nX, nY: Integer): Boolean;
    function ArroundDoorOpened(nX, nY: Integer): Boolean;
    function GetMovingObject(nX, nY: Integer; boFlag: Boolean): Pointer; overload;
    function GetMovingObject(nX, nY: Integer; AObject: TObject; boFlag: Boolean): Pointer; overload;
    function GetQuestNPC(BaseObject: TObject; sCharName, sStr: string; boFlag: Boolean): TObject;
    function GetItemEx(nX, nY: Integer; var nCount: Integer): Pointer;
    function GetDoor(nX, nY: Integer): pTDoorInfo;
    function IsValidObject(nX, nY: Integer; nRage: Integer; BaseObject: TObject): Boolean; //有效的对象
    function GetRangeBaseObject(nX, nY: Integer; nRage: Integer; boFlag: Boolean; BaseObjectList: TList): Integer; //取范围内的对像
    function GeTBaseObjects(nX, nY: Integer; boFlag: Boolean; BaseObjectList: TList): Integer; //取对像
    function GetMapBaseObjects(nX, nY, nRage: Integer; rList: TList; btType: Byte = OS_MOVINGOBJECT): Boolean;
    function GetEvent(nX, nY: Integer): TObject;
    procedure SetMapXYFlag(nX, nY: Integer; boFlag: Boolean);
    function GetXYHuman(nMapX, nMapY: Integer): Boolean;
    function GetEnvirInfo(): string; //取地图信息
    function AllowStdItems(sItemName: string): Boolean; overload; //是否允许使用物品
    function AllowStdItems(nItemIdx: Integer): Boolean; overload; //是否允许使用物品
    function AllowMagics(sMagName: string): Boolean; overload; //是否允许使用魔法
    function AllowMagics(nMagIdx: Integer; tyte: Byte): Boolean; overload; //是否允许使用魔法
    function ChangMapDropStdItems(sItemName: string): Boolean; //换地图是否掉指定物品
    procedure AddObject(nType: Integer);
    procedure DelObjectCount(BaseObject: TObject);
    property MonCount: Integer read m_nMonCount; //怪物数量
    property HumCount: Integer read m_nHumCount; //当前地图人物数量
    property HumAICount: Integer read m_nHumAICount; //地图上假人的数量
    function GetMainMap(): string;
    property MapName: string read GetMainMap;
    function GetMapItem(nX, nY, nRage: Integer; BaseObjectList: TList): Integer; //20080124 取指定地图范围内里的物品
  end;
  TMapManager = class(TGList)
    m_dwRunTick: LongWord;
    nMirrorMapsIndx: Integer; //循环处理镜像索引
    m_MirrorMaps: TList; //镜像地图列表
  private
  public
    constructor Create();
    destructor Destroy; override;
    procedure LoadMapDoor();
    function AddMapInfo(sMapName, sMainMapName, sMapDesc: string; nServerNumber: Integer; MapFlag: pTMapFlag; QuestNPC: TObject): TEnvirnoment;
    function AddMapInfoEx(sMapName, sMapDesc, sMirrorHomeMap: string; nTime: Integer; MapEnvir: TEnvirnoment): TEnvirnoment; //增加镜像地图
    function GetMapInfo(nServerIdx: Integer; sMapName: string): TEnvirnoment;
    function AddMapRoute(sSMapNO: string; nSMapX, nSMapY: Integer; sDMapNO: string; nDMapX, nDMapY: Integer): Boolean;
    function GetMapOfServerIndex(sMapName: string): Integer;
    function FindMap(sMapName: string): TEnvirnoment; //查找地图
    function DelMap(sMapName: string): Boolean; //删除地图
    function GetMainMap(Envir: TEnvirnoment): string;
    procedure ReSetMinMap();
    procedure Run();
    procedure ProcessMapDoor();
    procedure MakeSafePkZone();
  end;
implementation

uses ObjBase, ObjNpc, M2Share, Event, ObjMon, HUtil32, Castle;

{ TEnvirList }
//安全区光圈

procedure TMapManager.MakeSafePkZone();
var
  nX, nY: Integer;
  SafeEvent: TSafeEvent;
  nMinX, nMaxX, nMinY, nMaxY: Integer;
  I: Integer;
  StartPoint: pTStartPoint;
  Envir: TEnvirnoment;
begin
  g_StartPointList.Lock;
  if g_StartPointList.Count > 0 then begin
    for I := 0 to g_StartPointList.Count - 1 do begin
      StartPoint := pTStartPoint(g_StartPointList.Objects[I]);
      if (StartPoint <> nil) then begin
        if (StartPoint.m_nType > 0) then begin
          Envir := FindMap(StartPoint.m_sMapName);
          if Envir <> nil then begin
            nMinX := StartPoint.m_nCurrX - StartPoint.m_nRange;
            nMaxX := StartPoint.m_nCurrX + StartPoint.m_nRange;
            nMinY := StartPoint.m_nCurrY - StartPoint.m_nRange;
            nMaxY := StartPoint.m_nCurrY + StartPoint.m_nRange;
            for nX := nMinX to nMaxX do begin
              for nY := nMinY to nMaxY do begin
                if ((nX < nMaxX) and (nY = nMinY)) or
                  ((nY < nMaxY) and (nX = nMinX)) or
                  (nX = nMaxX) or (nY = nMaxY) then begin
                  SafeEvent := TSafeEvent.Create(Envir, nX, nY, StartPoint.m_nType);
                  g_EventManager.AddEvent(SafeEvent);
                end;
              end;
            end;
          end;
        end;
      end;
    end; //for
  end;
end;
//增加地图

function TMapManager.AddMapInfo(sMapName, sMainMapName, sMapDesc: string; nServerNumber: Integer; MapFlag: pTMapFlag; QuestNPC: TObject): TEnvirnoment;
var
  Envir: TEnvirnoment;
  I: Integer;
  nStd: Integer;
  TempList: TStringList;
  sTemp: string;
begin
  Result := nil;
  Envir := TEnvirnoment.Create;
  Envir.sMapName := sMapName;
  Envir.sMainMapName := sMainMapName;
  //Envir.sSubMapName := sMapName;//未使用 20080723
  Envir.sMapDesc := sMapDesc;
  if sMainMapName <> '' then Envir.m_boMainMap := True;
  Envir.nServerIndex := nServerNumber;
  Envir.m_boSAFE := MapFlag.boSAFE; //安全区
  Envir.m_boSafeNoRun := MapFlag.boSafeNoRun; //安全区人物不能穿
  Envir.m_boSAFEHERONORUN := MapFlag.boSAFEHERONORUN; //英雄安全区不能穿 20090525
  Envir.m_boFightZone := MapFlag.boFIGHT;
  Envir.m_boFight2Zone := MapFlag.boFIGHT2; //PK掉装备地图 20080525
  Envir.m_boFight3Zone := MapFlag.boFIGHT3;
  Envir.m_boFight4Zone := MapFlag.boFIGHT4; //挑战地图 20080706
  Envir.m_boNoFight4Zone := MapFlag.boNoFIGHT4; //禁止挑战地图
  Envir.m_boFight5Zone := MapFlag.boFIGHT5; //不同行会名字变不同颜色 20090318
  Envir.m_boDARK := MapFlag.boDARK;
  Envir.m_boDAY := MapFlag.boDAY;
  Envir.m_boQUIZ := MapFlag.boQUIZ;
  Envir.m_boNORECONNECT := MapFlag.boNORECONNECT;
  Envir.m_boNEEDHOLE := MapFlag.boNEEDHOLE;
  Envir.m_boNORECALL := MapFlag.boNORECALL;
  Envir.m_boNOGUILDRECALL := MapFlag.boNOGUILDRECALL;
  Envir.m_boNODEARRECALL := MapFlag.boNODEARRECALL;
  Envir.m_boNOMASTERRECALL := MapFlag.boNOMASTERRECALL;
  Envir.m_boNORANDOMMOVE := MapFlag.boNORANDOMMOVE;
  Envir.m_boNODRUG := MapFlag.boNODRUG;
  Envir.m_boMINE := MapFlag.boMINE;
  Envir.m_boDigJewel := MapFlag.boDigJewel; //可以挖宝 20100902
  Envir.m_boSHOP := MapFlag.boSHOP;
  Envir.m_boNOPOSITIONMOVE := MapFlag.boNOPOSITIONMOVE;
  Envir.m_boNoManNoMon := MapFlag.boNoManNoMon; //无人不刷怪
  Envir.m_boRUNHUMAN := MapFlag.boRUNHUMAN; //可以穿人
  Envir.m_boRUNMON := MapFlag.boRUNMON; //可以穿怪
  Envir.m_boNOSKILL := MapFlag.boNOSKILL;
  Envir.m_boDECHP := MapFlag.boDECHP; //自动减HP值
  Envir.m_boINCHP := MapFlag.boINCHP; //自动加HP值
  Envir.m_boDecGameGold := MapFlag.boDECGAMEGOLD; //自动减游戏币
  Envir.m_boDECGAMEPOINT := MapFlag.boDECGAMEPOINT; //自动减游戏点
  Envir.m_boIncGameGold := MapFlag.boINCGAMEGOLD; //自动加游戏币
  Envir.m_boINCGAMEPOINT := MapFlag.boINCGAMEPOINT; //自动加游戏点
  Envir.m_boNEEDLEVELTIME := MapFlag.boNEEDLEVELTIME; //雪域地图传送,判断等级 20081228
  Envir.m_nNEEDLEVELPOINT := MapFlag.nNEEDLEVELPOINT; //进雪域地图最低等级
  Envir.m_boNOCALLHERO := MapFlag.boNOCALLHERO; //禁止召唤英雄  20080124
  Envir.m_boNOHEROPROTECT := MapFlag.boNOHEROPROTECT; //禁止英雄守护  20080629
  Envir.m_boNODROPITEM := MapFlag.boNODROPITEM; //禁止死亡掉物品  20080503
  Envir.m_boKILLFUNC := MapFlag.boKILLFUNC; //地图杀人触发  20080415
  Envir.m_nKILLFUNC := MapFlag.nKILLFUNC; //地图杀人触发  20080415
  Envir.m_boMISSION := MapFlag.boMISSION; //不允许使用任何物品和技能  20080124
  Envir.m_boMUSIC := MapFlag.boMUSIC; //音乐
  Envir.m_boEXPRATE := MapFlag.boEXPRATE; //杀怪经验倍数
  Envir.m_boCRIT := MapFlag.boCRIT; //暴击等级
  Envir.m_nCRIT := MapFlag.nCRIT;
  Envir.m_boPeak := MapFlag.boPeak; //巅峰状态(提高攻击倍率)
  Envir.m_nPeakMinRate := MapFlag.nPeakMinRate; //最低攻击倍率
  Envir.m_nPeakMaxRate := MapFlag.nPeakMaxRate; //最高攻击倍率
  Envir.m_boDECEXPRATETIME := MapFlag.boDECEXPRATETIME; //减双倍经验时间 20090206
  Envir.m_nDECEXPRATETIME := MapFlag.nDECEXPRATETIME; //一次减双倍经验值 20090206
  Envir.m_boPULSEXPRATE := MapFlag.boPULSEXPRATE; //地图杀怪英雄经验倍数 20091029
  Envir.m_nPULSEXPRATE := MapFlag.nPULSEXPRATE; //地图杀怪英雄经验倍数 20091029
  Envir.m_boNGEXPRATE := MapFlag.boNGEXPRATE; //地图杀怪内功经验倍数 20091029
  Envir.m_nNGEXPRATE := MapFlag.nNGEXPRATE; //地图杀怪内功经验倍数 20091029
  Envir.m_boPKWINLEVEL := MapFlag.boPKWINLEVEL; //PK得等级
  Envir.m_boPKWINEXP := MapFlag.boPKWINEXP; //PK得经验
  Envir.m_boPKLOSTLEVEL := MapFlag.boPKLOSTLEVEL;
  Envir.m_boPKLOSTEXP := MapFlag.boPKLOSTEXP;
  Envir.m_nPKWINLEVEL := MapFlag.nPKWINLEVEL; //PK得等级数
  Envir.m_nPKWINEXP := MapFlag.nPKWINEXP; //PK得经验数
  Envir.m_nPKLOSTLEVEL := MapFlag.nPKLOSTLEVEL;
  Envir.m_nPKLOSTEXP := MapFlag.nPKLOSTEXP;
  Envir.m_nPKWINEXP := MapFlag.nPKWINEXP; //PK得经验数
  Envir.m_nDECHPTIME := MapFlag.nDECHPTIME; //减HP间隔时间
  Envir.m_nDECHPPOINT := MapFlag.nDECHPPOINT; //一次减点数
  Envir.m_nINCHPTIME := MapFlag.nINCHPTIME; //加HP间隔时间
  Envir.m_nINCHPPOINT := MapFlag.nINCHPPOINT; //一次加点数
  Envir.m_nDECGAMEGOLDTIME := MapFlag.nDECGAMEGOLDTIME; //减游戏币间隔时间
  Envir.m_nDecGameGold := MapFlag.nDECGAMEGOLD; //一次减数量
  Envir.m_nINCGAMEGOLDTIME := MapFlag.nINCGAMEGOLDTIME; //减游戏币间隔时间
  Envir.m_nIncGameGold := MapFlag.nINCGAMEGOLD; //一次减数量
  Envir.m_nINCGAMEPOINTTIME := MapFlag.nINCGAMEPOINTTIME; //加游戏点间隔时间
  Envir.m_nINCGAMEPOINT := MapFlag.nINCGAMEPOINT; //一次减数量
  Envir.m_nDECGAMEPOINTTIME := MapFlag.nDECGAMEPOINTTIME; //减游戏点间隔时间
  Envir.m_nDECGAMEPOINT := MapFlag.nDECGAMEPOINT; //一次减数量
  Envir.m_nMUSICID := MapFlag.nMUSICID; //音乐ID
  Envir.m_sMUSICName := MapFlag.sMUSICName; //音乐名称
  Envir.m_nEXPRATE := MapFlag.nEXPRATE; //经验倍率
  Envir.m_boHitMon := MapFlag.boHitMon; //攻击怪触发 20110114
  Envir.sHitMonScript := MapFlag.sHitMonScript;
  Envir.sNoReconnectMap := MapFlag.sReConnectMap;
  Envir.QuestNPC := QuestNPC;
  Envir.nNEEDSETONFlag := MapFlag.nNEEDSETONFlag;
  Envir.nNeedONOFF := MapFlag.nNeedONOFF;
  Envir.m_boUnAllowStdItems := MapFlag.boUnAllowStdItems;
  Envir.m_boUnAllowMagics := MapFlag.boNOTALLOWUSEMAGIC;
  Envir.m_boChangMapDrops := MapFlag.boChangMapDrops;
  Envir.m_boFIGHTPK := MapFlag.boFIGHTPK; //PK可以爆装备不红名
  Envir.nThunder := MapFlag.nThunder;
  Envir.nLava := MapFlag.nLava;
  Envir.boLimitLevel := MapFlag.boLimitLevel; //当角色超过指定等级1时，按等级2值计算HP MP 地图参数
  Envir.nLimitLevel1 := MapFlag.nLimitLevel1; //指定等级1
  Envir.nLimitLevel2 := MapFlag.nLimitLevel2; //指定等级2
  Envir.nLimitLevelHero := MapFlag.nLimitLevelHero; //指定英雄等级
  Envir.nLimitLevelHero1 := MapFlag.nLimitLevelHero1; //指定英雄等级

  if (Envir.m_boUnAllowStdItems) and (MapFlag.sUnAllowStdItemsText <> '') then begin
    TempList := TStringList.Create;
    try
      ExtractStrings(['|', '\', '/'], [], PChar(Trim(MapFlag.sUnAllowStdItemsText)), TempList);
      if TempList.Count > 0 then begin
        for I := 0 to TempList.Count - 1 do begin
          nStd := UserEngine.GetStdItemIdx(Trim(TempList.Strings[I]));
          if nStd >= 0 then
            Envir.m_UnAllowStdItemsList.AddObject(Trim(TempList.Strings[I]), TObject(nStd));
        end;
      end;
    finally
      TempList.Free;
    end;
  end;

  if (Envir.m_boChangMapDrops) and (MapFlag.sChangMapDropsText <> '') then begin //20110301
    TempList := TStringList.Create;
    try
      ExtractStrings(['|', '\', '/'], [], PChar(Trim(MapFlag.sChangMapDropsText)), TempList);
      if TempList.Count > 0 then begin
        for I := 0 to TempList.Count - 1 do begin
          nStd := UserEngine.GetStdItemIdx(Trim(TempList.Strings[I]));
          if nStd >= 0 then
            Envir.m_ChangMapDropsList.AddObject(Trim(TempList.Strings[I]), TObject(nStd));
        end;
      end;
    finally
      TempList.Free;
    end;
  end;

  if (Envir.m_boUnAllowMagics) and (MapFlag.sUnAllowMagicText <> '') then begin
    TempList := TStringList.Create;
    try
      ExtractStrings(['|', '\', '/'], [], PChar(Trim(MapFlag.sUnAllowMagicText)), TempList);
      if TempList.Count > 0 then begin
        for I := 0 to TempList.Count - 1 do begin
          sTemp := Trim(TempList.Strings[I]);
          if sTemp <> '' then Envir.m_UnAllowMagicList.Add(sTemp);
        end;
      end;
    finally
      TempList.Free;
    end;
  end;

  if MiniMapList.Count > 0 then begin
    for I := 0 to MiniMapList.Count - 1 do begin
      if CompareText(MiniMapList.Strings[I], Envir.sMapName) = 0 then begin
        Envir.nMinMap := Integer(MiniMapList.Objects[I]);
        Break;
      end;
    end;
  end;
  if sMainMapName <> '' then begin
    if Envir.LoadMapData(g_Config.sMapDir + sMainMapName + '.map') then begin
      Result := Envir;
      Self.Add(Envir);
    end else begin
      MainOutMessage('地图文件 ' + g_Config.sMapDir + sMainMapName + '.map' + ' 未找到！！！');
    end;
  end else begin
    if Envir.LoadMapData(g_Config.sMapDir + sMapName + '.map') then begin
      Result := Envir;
      Self.Add(Envir);
    end else begin
      MainOutMessage('地图文件 ' + g_Config.sMapDir + sMapName + '.map' + ' 未找到！！！');
    end;
  end;
end;
//增加镜像地图

function TMapManager.AddMapInfoEx(sMapName, sMapDesc, sMirrorHomeMap: string; nTime: Integer; MapEnvir: TEnvirnoment): TEnvirnoment;
var
  Envir: TEnvirnoment;
  I: Integer;
  nStd: Integer;
  sTemp: string;
  QuestNPC: TMerchant;
begin
  Result := nil;
  Envir := TEnvirnoment.Create;
  Envir.sMapName := sMapName;
  Envir.sMapDesc := sMapDesc;
  if MapEnvir.sMainMapName <> '' then Envir.sMainMapName := MapEnvir.sMainMapName //20111005 增加
  else Envir.sMainMapName := MapEnvir.sMapName {sMainMapName}; //20110924 修改
  if Envir.sMainMapName <> '' then Envir.m_boMainMap := True;
  Envir.nServerIndex := MapEnvir.nServerIndex;
  Envir.m_boSAFE := MapEnvir.m_boSAFE; //安全区
  Envir.m_boSafeNoRun := MapEnvir.m_boSafeNoRun; //安全区人物不能穿
  Envir.m_boSAFEHERONORUN := MapEnvir.m_boSAFEHERONORUN; //英雄安全区不能穿
  Envir.m_boFightZone := MapEnvir.m_boFightZone;
  Envir.m_boFight2Zone := MapEnvir.m_boFight2Zone; //PK掉装备地图 20080525
  Envir.m_boFight3Zone := MapEnvir.m_boFight3Zone;
  Envir.m_boFight4Zone := MapEnvir.m_boFight4Zone; //挑战地图 20080706
  Envir.m_boNoFight4Zone := MapEnvir.m_boNoFight4Zone; //禁止挑战地图
  Envir.m_boFight5Zone := MapEnvir.m_boFight5Zone; //不同行会名字变不同颜色 20090318
  Envir.m_boDARK := MapEnvir.m_boDARK;
  Envir.m_boDAY := MapEnvir.m_boDAY;
  Envir.m_boQUIZ := MapEnvir.m_boQUIZ;
  Envir.m_boNORECONNECT := MapEnvir.m_boNORECONNECT;
  Envir.m_boNEEDHOLE := MapEnvir.m_boNEEDHOLE;
  Envir.m_boNORECALL := MapEnvir.m_boNORECALL;
  Envir.m_boNOGUILDRECALL := MapEnvir.m_boNOGUILDRECALL;
  Envir.m_boNODEARRECALL := MapEnvir.m_boNODEARRECALL;
  Envir.m_boNOMASTERRECALL := MapEnvir.m_boNOMASTERRECALL;
  Envir.m_boNORANDOMMOVE := MapEnvir.m_boNORANDOMMOVE;
  Envir.m_boNODRUG := MapEnvir.m_boNODRUG;
  Envir.m_boMINE := MapEnvir.m_boMINE;
  Envir.m_boDigJewel := MapEnvir.m_boDigJewel; //可以挖宝
  Envir.m_boSHOP := MapEnvir.m_boSHOP;
  Envir.m_boNOPOSITIONMOVE := MapEnvir.m_boNOPOSITIONMOVE;
  Envir.m_boNoManNoMon := MapEnvir.m_boNoManNoMon; //无人不刷怪
  Envir.m_boRUNHUMAN := MapEnvir.m_boRUNHUMAN; //可以穿人
  Envir.m_boRUNMON := MapEnvir.m_boRUNMON; //可以穿怪
  Envir.m_boNOSKILL := MapEnvir.m_boNOSKILL;
  Envir.m_boDECHP := MapEnvir.m_boDECHP; //自动减HP值
  Envir.m_boINCHP := MapEnvir.m_boINCHP; //自动加HP值
  Envir.m_boDecGameGold := MapEnvir.m_boDecGameGold; //自动减游戏币
  Envir.m_boDECGAMEPOINT := MapEnvir.m_boDECGAMEPOINT; //自动减游戏点
  Envir.m_boIncGameGold := MapEnvir.m_boIncGameGold; //自动加游戏币
  Envir.m_boINCGAMEPOINT := MapEnvir.m_boINCGAMEPOINT; //自动加游戏点
  Envir.m_boNEEDLEVELTIME := MapEnvir.m_boNEEDLEVELTIME; //雪域地图传送,判断等级 20081228
  Envir.m_nNEEDLEVELPOINT := MapEnvir.m_nNEEDLEVELPOINT; //进雪域地图最低等级
  Envir.m_boNOCALLHERO := MapEnvir.m_boNOCALLHERO; //禁止召唤英雄  20080124
  Envir.m_boNOHEROPROTECT := MapEnvir.m_boNOHEROPROTECT; //禁止英雄守护  20080629
  Envir.m_boNODROPITEM := MapEnvir.m_boNODROPITEM; //禁止死亡掉物品  20080503
  Envir.m_boKILLFUNC := MapEnvir.m_boKILLFUNC; //地图杀人触发  20080415
  Envir.m_nKILLFUNC := MapEnvir.m_nKILLFUNC; //地图杀人触发  20080415
  Envir.m_boMISSION := MapEnvir.m_boMISSION; //不允许使用任何物品和技能  20080124
  Envir.m_boMUSIC := MapEnvir.m_boMUSIC; //音乐
  Envir.m_boEXPRATE := MapEnvir.m_boEXPRATE; //杀怪经验倍数
  Envir.m_boCRIT := MapEnvir.m_boCRIT; //暴击等级
  Envir.m_nCRIT := MapEnvir.m_nCRIT;
  Envir.m_boPeak := MapEnvir.m_boPeak; //巅峰状态(提高攻击倍率)
  Envir.m_nPeakMinRate := MapEnvir.m_nPeakMinRate; //最低攻击倍率
  Envir.m_nPeakMaxRate := MapEnvir.m_nPeakMaxRate; //最高攻击倍率
  Envir.m_boDECEXPRATETIME := MapEnvir.m_boDECEXPRATETIME; //减双倍经验时间 20090206
  Envir.m_nDECEXPRATETIME := MapEnvir.m_nDECEXPRATETIME; //一次减双倍经验值 20090206
  Envir.m_boPULSEXPRATE := MapEnvir.m_boPULSEXPRATE; //地图杀怪英雄经验倍数 20091029
  Envir.m_nPULSEXPRATE := MapEnvir.m_nPULSEXPRATE; //地图杀怪英雄经验倍数 20091029
  Envir.m_boNGEXPRATE := MapEnvir.m_boNGEXPRATE; //地图杀怪内功经验倍数 20091029
  Envir.m_nNGEXPRATE := MapEnvir.m_nNGEXPRATE; //地图杀怪内功经验倍数 20091029
  Envir.m_boPKWINLEVEL := MapEnvir.m_boPKWINLEVEL; //PK得等级
  Envir.m_boPKWINEXP := MapEnvir.m_boPKWINEXP; //PK得经验
  Envir.m_boPKLOSTLEVEL := MapEnvir.m_boPKLOSTLEVEL;
  Envir.m_boPKLOSTEXP := MapEnvir.m_boPKLOSTEXP;
  Envir.m_nPKWINLEVEL := MapEnvir.m_nPKWINLEVEL; //PK得等级数
  Envir.m_nPKWINEXP := MapEnvir.m_nPKWINEXP; //PK得经验数
  Envir.m_nPKLOSTLEVEL := MapEnvir.m_nPKLOSTLEVEL;
  Envir.m_nPKLOSTEXP := MapEnvir.m_nPKLOSTEXP;
  Envir.m_nPKWINEXP := MapEnvir.m_nPKWINEXP; //PK得经验数
  Envir.m_nDECHPTIME := MapEnvir.m_nDECHPTIME; //减HP间隔时间
  Envir.m_nDECHPPOINT := MapEnvir.m_nDECHPPOINT; //一次减点数
  Envir.m_nINCHPTIME := MapEnvir.m_nINCHPTIME; //加HP间隔时间
  Envir.m_nINCHPPOINT := MapEnvir.m_nINCHPPOINT; //一次加点数
  Envir.m_nDECGAMEGOLDTIME := MapEnvir.m_nDECGAMEGOLDTIME; //减游戏币间隔时间
  Envir.m_nDecGameGold := MapEnvir.m_nDECGAMEGOLD; //一次减数量
  Envir.m_nINCGAMEGOLDTIME := MapEnvir.m_nINCGAMEGOLDTIME; //减游戏币间隔时间
  Envir.m_nIncGameGold := MapEnvir.m_nINCGAMEGOLD; //一次减数量
  Envir.m_nINCGAMEPOINTTIME := MapEnvir.m_nINCGAMEPOINTTIME; //加游戏点间隔时间
  Envir.m_nINCGAMEPOINT := MapEnvir.m_nINCGAMEPOINT; //一次减数量
  Envir.m_nDECGAMEPOINTTIME := MapEnvir.m_nDECGAMEPOINTTIME; //减游戏点间隔时间
  Envir.m_nDECGAMEPOINT := MapEnvir.m_nDECGAMEPOINT; //一次减数量
  Envir.m_nMUSICID := MapEnvir.m_nMUSICID; //音乐ID
  Envir.m_sMUSICName := MapEnvir.m_sMUSICName; //音乐名称
  Envir.m_nEXPRATE := MapEnvir.m_nEXPRATE; //经验倍率
  Envir.m_boHitMon := MapEnvir.m_boHitMon; //攻击怪触发 20110114
  Envir.sHitMonScript := MapEnvir.sHitMonScript;
  Envir.sNoReconnectMap := MapEnvir.sNoReconnectMap;
  Envir.boLimitLevel := MapEnvir.boLimitLevel; //当角色超过指定等级1时，按等级2值计算HP MP 地图参数
  Envir.nLimitLevel1 := MapEnvir.nLimitLevel1; //指定等级1
  Envir.nLimitLevel2 := MapEnvir.nLimitLevel2; //指定等级2
  Envir.nLimitLevelHero := MapEnvir.nLimitLevelHero; //指定英雄等级
  Envir.nLimitLevelHero1 := MapEnvir.nLimitLevelHero1; //指定英雄等级

  if MapEnvir.QuestNPC <> nil then begin
    QuestNPC := TMerchant.Create;
    QuestNPC.m_sMapName := '0';
    QuestNPC.m_nCurrX := 0;
    QuestNPC.m_nCurrY := 0;
    QuestNPC.m_sCharName := TMerchant(MapEnvir.QuestNPC).m_sCharName;
    QuestNPC.m_nFlag := 0;
    QuestNPC.m_wAppr := 0;
    QuestNPC.m_sFilePath := 'MapQuest_def\';
    QuestNPC.m_boIsHide := True;
    QuestNPC.m_boIsQuest := False;
    UserEngine.QuestNPCList.Add(QuestNPC);
    Envir.QuestNPC := QuestNPC;
  end;

  Envir.nNEEDSETONFlag := MapEnvir.nNEEDSETONFlag;
  Envir.nNeedONOFF := MapEnvir.nNeedONOFF;
  Envir.m_boUnAllowStdItems := MapEnvir.m_boUnAllowStdItems;
  Envir.m_boUnAllowMagics := MapEnvir.m_boUnAllowMagics;
  Envir.m_boChangMapDrops := MapEnvir.m_boChangMapDrops;
  Envir.m_boFIGHTPK := MapEnvir.m_boFIGHTPK; //PK可以爆装备不红名
  Envir.nThunder := MapEnvir.nThunder;
  Envir.nLava := MapEnvir.nLava;

  if (Envir.m_boUnAllowStdItems) then begin
    if MapEnvir.m_UnAllowStdItemsList.Count > 0 then begin
      for I := 0 to MapEnvir.m_UnAllowStdItemsList.Count - 1 do begin
        nStd := UserEngine.GetStdItemIdx(Trim(MapEnvir.m_UnAllowStdItemsList.Strings[I]));
        if nStd >= 0 then
          Envir.m_UnAllowStdItemsList.AddObject(Trim(MapEnvir.m_UnAllowStdItemsList.Strings[I]), TObject(nStd));
      end;
    end;
  end;

  if (Envir.m_boChangMapDrops) then begin
    if MapEnvir.m_ChangMapDropsList.Count > 0 then begin
      for I := 0 to MapEnvir.m_ChangMapDropsList.Count - 1 do begin
        nStd := UserEngine.GetStdItemIdx(Trim(MapEnvir.m_ChangMapDropsList.Strings[I]));
        if nStd >= 0 then
          Envir.m_ChangMapDropsList.AddObject(Trim(MapEnvir.m_ChangMapDropsList.Strings[I]), TObject(nStd));
      end;
    end;
  end;

  if (Envir.m_boUnAllowMagics) then begin
    if MapEnvir.m_UnAllowMagicList.Count > 0 then begin
      for I := 0 to MapEnvir.m_UnAllowMagicList.Count - 1 do begin
        sTemp := Trim(MapEnvir.m_UnAllowMagicList.Strings[I]);
        if sTemp <> '' then Envir.m_UnAllowMagicList.Add(sTemp);
      end;
    end;
  end;

  Envir.nMinMap := MapEnvir.nMinMap; //小地图
  Envir.m_boMirrorMap := True;
  Envir.m_boMirrorMaping := False;
  Envir.m_dwMirrorMapTick := GetTickCount + nTime * 1000;
  Envir.sMirrorHomeMap := sMirrorHomeMap;
  if MapEnvir.sMainMapName <> '' then begin
    if Envir.LoadMapData(g_Config.sMapDir + MapEnvir.sMainMapName + '.map') then begin
      Result := Envir;
      Self.Add(Envir);
      Self.m_MirrorMaps.Add(Envir); //镜像地图
    end else begin
      MainOutMessage('地图文件 ' + g_Config.sMapDir + MapEnvir.sMainMapName + '.map' + ' 未找到！！！');
    end;
  end else begin
    if Envir.LoadMapData(g_Config.sMapDir + MapEnvir.sMapName + '.map') then begin
      Result := Envir;
      Self.Add(Envir);
      Self.m_MirrorMaps.Add(Envir); //镜像地图
    end else begin
      MainOutMessage('地图文件 ' + g_Config.sMapDir + MapEnvir.sMapName + '.map' + ' 未找到！！！');
    end;
  end;
end;

//增加地图连接点

function TMapManager.AddMapRoute(sSMapNO: string; nSMapX, nSMapY: Integer; sDMapNO: string; nDMapX, nDMapY: Integer): Boolean;
var
  GateObj: pTGateObj;
  SEnvir: TEnvirnoment;
  DEnvir: TEnvirnoment;
begin
  Result := False;
  SEnvir := FindMap(sSMapNO);
  DEnvir := FindMap(sDMapNO);
  if (SEnvir <> nil) and (DEnvir <> nil) then begin
    New(GateObj);
    //GateObj.boFlag := False;//20090503 注释，未使用
    GateObj.DEnvir := DEnvir;
    GateObj.nDMapX := nDMapX;
    GateObj.nDMapY := nDMapY;
    Result := SEnvir.AddToMap(nSMapX, nSMapY, OS_GATEOBJECT, TObject(GateObj)) = GateObj;
    if not Result then //修复内存泄露 By TasNat at: 2012-05-26 19:02:28
      Dispose(GateObj);
  end;
end;

//将对像加入地图

function TEnvirnoment.AddToMap(nX, nY: Integer; btType: Byte; pRemoveObject: TObject): Pointer;
var
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  MapItem: PTMapItem;
  I: Integer;
  nGoldCount: Integer;
  bo1E: Boolean;
  btRaceServer: Byte;
  nCode: Byte;
resourcestring
  sExceptionMsg = '{%s} TEnvirnoment::AddToMap Code:%d';
begin
  Result := nil;
  if m_boMirrorMaping then Exit;
  nCode := 0;
  try
    bo1E := False;
    if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.chFlag = 0) then begin
      if MapCellInfo.ObjList = nil then begin
        MapCellInfo.ObjList := TList.Create;
      end else begin
        if btType = OS_ITEMOBJECT then begin
          if PTMapItem(pRemoveObject).Name = sSTRING_GOLDNAME then begin
            if MapCellInfo.ObjList.Count > 0 then begin
              for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
                OSObject := MapCellInfo.ObjList.Items[I];
                if (OSObject <> nil) then begin
                  if (OSObject.btType = OS_ITEMOBJECT) and (not OSObject.boObjectDispose) then begin //20090510 增加
                    MapItem := PTMapItem(pTOSObject(MapCellInfo.ObjList.Items[I]).CellObj);
                    if MapItem <> nil then begin
                      if MapItem.Name = sSTRING_GOLDNAME then begin
                        nGoldCount := MapItem.Count + PTMapItem(pRemoveObject).Count;
                        if nGoldCount <= 2000 then begin
                          MapItem.Count := nGoldCount;
                          MapItem.Looks := GetGoldShape(nGoldCount);
                          MapItem.AniCount := 0;
                          MapItem.Reserved := 0;
                          OSObject.dwAddTime := GetTickCount();
                          Result := MapItem;
                          bo1E := True;
                        end;
                      end;
                    end;
                  end;
                end;
              end; //for
            end;
          end;
          if not bo1E and (MapCellInfo.ObjList.Count >= 5) then begin
            Result := nil;
            bo1E := True;
          end;
        end;
      end;
      if not bo1E then begin
        New(OSObject);
        OSObject.btType := btType;
        OSObject.CellObj := pRemoveObject;
        OSObject.dwAddTime := GetTickCount();
        OSObject.boObjectDisPose := False; //20090510 增加
        nCode := 1;
        if MapCellInfo.ObjList = nil then begin
          MapCellInfo.ObjList := TList.Create;
        end;
        nCode := 4;
        if MapCellInfo.ObjList <> nil then begin //20090803 增加
          nCode := 5;
          try
            MapCellInfo.ObjList.Add(OSObject);
          except
            nCode := 6;
            Dispose(OSObject);
            Exit;
          end;
          nCode := 2;
          Result := Pointer(pRemoveObject);

          if (btType = OS_MOVINGOBJECT) and (not TBaseObject(pRemoveObject).m_boAddToMaped) then begin
            TBaseObject(pRemoveObject).m_boDelFormMaped := False;
            TBaseObject(pRemoveObject).m_boAddToMaped := True;
            btRaceServer := TBaseObject(pRemoveObject).m_btRaceServer;
            nCode := 3;
            if btRaceServer = RC_PLAYOBJECT then begin
              Inc(m_nHumCount);
              if TBaseObject(pRemoveObject).m_boAI then Inc(m_nHumAICount);
            end;
            if btRaceServer >= RC_ANIMAL then Inc(m_nMonCount);
          end;
        end;
      end;
    end;
  except
    MainOutMessage(format(sExceptionMsg, [g_sExceptionVer, nCode]));
  end;
end;
//地图是否允许使用物品

function TEnvirnoment.AllowStdItems(sItemName: string): Boolean;
var
  I: Integer;
begin
  Result := True;
  try
    if m_boMirrorMaping then Exit;
    if (not m_boUnAllowStdItems) or (m_UnAllowStdItemsList = nil) then Exit; //20080930 增加
    if m_UnAllowStdItemsList.Count > 0 then begin
      I := m_UnAllowStdItemsList.IndexOf(sItemName);
      if I > -1 then Result := False;
    end;
  except
    MainOutMessage(format('{%s} TEnvirnoment.AllowStdItems1', [g_sExceptionVer]));
  end;
end;
//地图是否允许使用物品

function TEnvirnoment.AllowStdItems(nItemIdx: Integer): Boolean;
var
  I: Integer;
begin
  Result := True;
  try
    if m_boMirrorMaping then Exit;
    if (not m_boUnAllowStdItems) or (m_UnAllowStdItemsList = nil) then Exit; //20080930 增加
    if m_UnAllowStdItemsList.Count > 0 then begin //20080630
      for I := 0 to m_UnAllowStdItemsList.Count - 1 do begin
        if Integer(m_UnAllowStdItemsList.Objects[I]) = nItemIdx then begin
          Result := False;
          Break;
        end;
      end;
    end;
  except
    MainOutMessage(format('{%s} TEnvirnoment.AllowStdItems2', [g_sExceptionVer]));
  end;
end;

function TEnvirnoment.GetMainMap(): string;
begin
  if m_boMainMap then Result := sMainMapName
  else Result := sMapName;
end;
//换地图掉落指定物品

function TEnvirnoment.ChangMapDropStdItems(sItemName: string): Boolean;
var
  I: Integer;
begin
  Result := True;
  try
    if m_boMirrorMaping then Exit;
    if (not m_boChangMapDrops) or (m_ChangMapDropsList = nil) then Exit;
    if m_ChangMapDropsList.Count > 0 then begin
      I := m_ChangMapDropsList.IndexOf(sItemName);
      if I > -1 then Result := False;
    end;
  except
    MainOutMessage(format('{%s} TEnvirnoment.ChangMapDropStdItems1', [g_sExceptionVer]));
  end;
end;

//地图是否允许使用魔法

function TEnvirnoment.AllowMagics(sMagName: string): Boolean;
var
  I: Integer;
begin
  Result := True;
  if m_boMirrorMaping then Exit;
  if not m_boUnAllowMagics then Exit;
  if m_UnAllowMagicList.Count > 0 then begin
    I := m_UnAllowMagicList.IndexOf(sMagName);
    if I > -1 then Result := False;
  end;
end;
//是否允许使用魔法  tyte 0-主体 1-英雄

function TEnvirnoment.AllowMagics(nMagIdx: Integer; tyte: Byte): Boolean;
var
  I: Integer;
  sName: string;
  Magic: pTMagic;
begin
  Result := True;
  if m_boMirrorMaping then Exit;
  if (not m_boUnAllowMagics) or (nMagIdx < 0) then Exit;
  case tyte of
    0: begin
        Magic := UserEngine.FindMagic(nMagIdx);
        if Magic <> nil then sName := Magic.sMagicName;
      end;
    1: begin
        Magic := UserEngine.FindHeroMagic(nMagIdx);
        if Magic <> nil then sName := Magic.sMagicName;
      end;
  end;
  if (m_UnAllowMagicList.Count > 0) and (sName <> '') then begin
    I := m_UnAllowMagicList.IndexOf(sName);
    if I > -1 then Result := False;
  end;
  {if m_UnAllowMagicList.Count > 0 then begin
    for I := 0 to m_UnAllowMagicList.Count - 1 do begin
      if Integer(m_UnAllowMagicList.Objects[I]) = nMagIdx then begin
        Result := False;
        Break;
      end;
    end;
  end; }
end;

procedure TEnvirnoment.AddDoorToMap();
var
  I: Integer;
  Door: pTDoorInfo;
begin
  if m_boMirrorMaping then Exit;
  if m_DoorList.Count > 0 then begin
    for I := 0 to m_DoorList.Count - 1 do begin
      Door := m_DoorList.Items[I];
      AddToMap(Door.nX, Door.nY, OS_DOOR, TObject(Door));
    end;
  end;
end;

function TEnvirnoment.GetMapCellInfo(nX, nY: Integer; var MapCellInfo: pTMapCellinfo): Boolean;
begin
  Result := False;
  MapCellInfo := nil; //加上是不是保险点呢 By TasNat at: 2012-03-13 22:44:05
  try
    if m_boMirrorMaping then Exit;
    if (nX >= 0) and (nX < m_nWidth) and (nY >= 0) and (nY < m_nHeight) then begin
      MapCellInfo := @MapCellArray[nX * m_nHeight + nY]; // liuzhigang 这个是一个一维数组
      Result := True;
    end;
  except
  end;
end;

//对像移动

function TEnvirnoment.MoveToMovingObject(nCX, nCY: Integer; Cert: TObject; nX, nY: Integer; boFlag: Boolean): Integer;
var
  MapCellInfo: pTMapCellinfo;
  BaseObject: TBaseObject;
  OSObject: pTOSObject;
  I: Integer;
  bo1A: Boolean;
  nCode: Byte; //20080702
//label //20080727 未使用的标签
//  Loop, Over;
begin
  Result := 0;
  nCode := 0;
  try
    bo1A := True;
    if not boFlag and GetMapCellInfo(nX, nY, MapCellInfo) then begin
      nCode := 12;
      if MapCellInfo.chFlag = 0 then begin
        nCode := 13;
        if MapCellInfo.ObjList <> nil then begin
          if MapCellInfo.ObjList.Count > 0 then begin //20080630
            nCode := 14;
            for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
              nCode := 141;
              try //20090716 增加
                OSObject := pTOSObject(MapCellInfo.ObjList.Items[I]);
              except
                OSObject := nil;
              end;
              try //20090817 增加
                {if OSObject <> nil then begin//20090716
                  if (not pTOSObject(MapCellInfo.ObjList.Items[I]).boObjectDisPose) then begin//20090605 增加 not boObjectDisPose
                    if (pTOSObject(MapCellInfo.ObjList.Items[I]).btType = OS_MOVINGOBJECT) then begin
                      BaseObject := TBaseObject(pTOSObject(MapCellInfo.ObjList.Items[I]).CellObj);
                      if BaseObject <> nil then begin //检测移动地点是否有人物
                        if not BaseObject.m_boGhost and BaseObject.bo2B9 and not BaseObject.m_boDeath
                          and not BaseObject.m_boFixedHideMode and not BaseObject.m_boObMode then begin
                          bo1A := False;
                          Break;
                        end;
                      end;
                    end;
                  end;
                end; }
                //20110908 修改
                if OSObject <> nil then begin //20090716
                  if (not OSObject.boObjectDisPose) then begin //20090605 增加 not boObjectDisPose
                    case OSObject.btType of
                      OS_MOVINGOBJECT: begin
                          BaseObject := TBaseObject(OSObject.CellObj);
                          if BaseObject <> nil then begin //检测移动地点是否有人物
                            if not BaseObject.m_boGhost and BaseObject.bo2B9 and not BaseObject.m_boDeath
                              and not BaseObject.m_boFixedHideMode and not BaseObject.m_boObMode then begin
                              bo1A := False;
                              Break;
                            end;
                          end;
                        end;
                      OS_EVENTOBJECT: begin //天雷乱舞 场景，不可穿过
                          if TEvent(OSObject.CellObj).m_nEventType = ET_NOTGOTO then begin
                            bo1A := False;
                            Break;
                          end;
                        end;
                    end; //case
                  end;
                end;
              except
              end;
            end; //for
          end;
        end;
      end else begin //if MapCellInfo.chFlag = 0 then begin
        Result := -1;
        bo1A := False;
      end;
    end;
    if bo1A then begin
      if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.chFlag <> 0) then begin
        Result := -1;
      end else begin
        if GetMapCellInfo(nCX, nCY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
          I := 0;
          nCode := 1;
          while (True) do begin
            nCode := 19;
            if MapCellInfo.ObjList.Count <= I then Break;
            nCode := 2;
            try //20090705 增加
              OSObject := MapCellInfo.ObjList.Items[I];
            except
              OSObject := nil; //20090705 增加
            end;
            nCode := 3;
            if (OSObject <> nil) then begin
              if (OSObject.btType = OS_MOVINGOBJECT) and (not OSObject.boObjectDisPose) then begin //20090510 修改
                if TBaseObject(OSObject.CellObj) = TBaseObject(Cert) then begin
                  //try//20090722  20101126 注释
                  if MapCellInfo.ObjList <> nil then MapCellInfo.ObjList.Delete(I); //20090713 修改
                  if (OSObject <> nil) then begin
                    OSObject.boObjectDisPose := True; //20990510 增加
                    Dispose(OSObject); //20090103 修改
                  end;
                  //except
                  //end;
                  if MapCellInfo.ObjList.Count > 0 then Continue;
                  if MapCellInfo.ObjList.Count <= 0 then begin //20090315 修改
                    try //20090512 增加
                      if MapCellInfo.ObjList <> nil then FreeAndNil(MapCellInfo.ObjList); //20090115 修改
                    except
                    end;
                    break;
                  end;
                end;
              end;
            end;
            Inc(I);
          end; //while
        end;
        if GetMapCellInfo(nX, nY, MapCellInfo) then begin
          try
            New(OSObject);
            OSObject.btType := OS_MOVINGOBJECT;
            OSObject.CellObj := Cert;
            OSObject.dwAddTime := GetTickCount;
            OSObject.boObjectDisPose := False; //20090510 增加
            nCode := 11;
            if (MapCellInfo.ObjList = nil) then begin
              MapCellInfo.ObjList := TList.Create;
            end;
            nCode := 10;
            MapCellInfo.ObjList.Add(OSObject);
            Result := 1; //20090525 换位置
          except
            Dispose(OSObject); //20090103 防止内存泄露
            Result := -1; //20090525 增加
          end;
        end;
      end;
    end;
  except
    on E: Exception do begin
      MainOutMessage(Format('{%s} TEnvirnoment::MoveToMovingObject Code:%d', [g_sExceptionVer, nCode]));
    end;
  end;
end;

//======================================================================
//检查地图指定座标是否可以移动
//boFlag  如果为TRUE 则忽略座标上是否有角色
//返回值 True 为可以移动，False 为不可以移动
//======================================================================1

function TEnvirnoment.CanWalk(nX, nY: Integer; boFlag: Boolean): Boolean;
var
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
  I: Integer;
begin
  Result := False;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.chFlag = 0) then begin
    Result := True;
    if not boFlag and (MapCellInfo.ObjList <> nil) then begin
      if MapCellInfo.ObjList.Count > 0 then begin //20080630
        for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
          OSObject := MapCellInfo.ObjList.Items[I];
          if (OSObject <> nil) then begin
            if (not OSObject.boObjectDisPose) then begin //20090510 增加
              case OSObject.btType of
                OS_MOVINGOBJECT: begin
                    BaseObject := TBaseObject(OSObject.CellObj);
                    if BaseObject <> nil then begin
                      if not BaseObject.m_boGhost
                        and BaseObject.bo2B9
                        and not BaseObject.m_boDeath
                        and not BaseObject.m_boFixedHideMode
                        and not BaseObject.m_boObMode then begin
                        Result := False;
                        Break;
                      end;
                    end;
                  end;
                OS_EVENTOBJECT: begin //天雷乱舞 场景，不可穿过
                    if TEvent(OSObject.CellObj).m_nEventType = ET_NOTGOTO then begin
                      Result := False;
                      Break;
                    end;
                  end;
              end;
            end;
          end;
        end; //for
      end;
    end;
  end;
end;

//======================================================================
//检查地图指定座标是否可以移动
//boFlag  如果为TRUE 则忽略座标上是否有角色
//返回值 True 为可以移动，False 为不可以移动
//======================================================================

function TEnvirnoment.CanWalkOfItem(nX, nY: Integer; boFlag, boItem: Boolean): Boolean;
var
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
  I: Integer;
begin
  Result := True;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.chFlag = 0) then begin
    if (MapCellInfo.ObjList <> nil) then begin
      if MapCellInfo.ObjList.Count > 0 then begin //20080630
        for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
          OSObject := MapCellInfo.ObjList.Items[I];
          if (OSObject <> nil) then begin //20090430 修改
            if not boFlag and (OSObject.btType = OS_MOVINGOBJECT) and (not OSObject.boObjectDisPose) then begin //20090510 增加
              BaseObject := TBaseObject(OSObject.CellObj);
              if BaseObject <> nil then begin
                if not BaseObject.m_boGhost and BaseObject.bo2B9
                  and not BaseObject.m_boDeath and not BaseObject.m_boFixedHideMode
                  and not BaseObject.m_boObMode then begin
                  Result := False;
                  Break;
                end;
              end;
            end;
            if not boItem and (OSObject.btType = OS_ITEMOBJECT) and (not OSObject.boObjectDisPose) then begin //20090510 增加
              Result := False;
              Break;
            end;
          end;
        end; //for
      end;
    end;
  end;
end;

function TEnvirnoment.CanWalkEx(nX, nY: Integer; boFlag: Boolean): Boolean;
var
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
  I: Integer;
  Castle: TUserCastle;
begin
  Result := False;
  try
    if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.chFlag = 0) then begin
      Result := True;
      if not boFlag and (MapCellInfo.ObjList <> nil) then begin
        if MapCellInfo.ObjList.Count > 0 then begin //20080630
          for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
            OSObject := MapCellInfo.ObjList.Items[I];
            if OSObject <> nil then begin
              if (not OSObject.boObjectDisPose) then begin //20090510 增加
                case OSObject.btType of
                  OS_MOVINGOBJECT: begin
                      BaseObject := TBaseObject(OSObject.CellObj);
                      if BaseObject <> nil then begin
                        Castle := g_CastleManager.InCastleWarArea(BaseObject);
                        if g_Config.boWarDisHumRun and (Castle <> nil) and (Castle.m_boUnderWar) then begin
                        end else begin
                          if not m_boSafeNoRun then begin //安全区禁止穿
                            if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
                              if g_Config.boRUNHUMAN or m_boRUNHUMAN then Continue;
                            end else begin
                              if BaseObject.m_btRaceServer = RC_NPC then begin
                                if g_Config.boRunNpc then Continue;
                              end else begin
                                if (BaseObject.m_btRaceServer = RC_GUARD) or (BaseObject.m_btRaceServer = RC_ARCHERGUARD) then begin //20090903 修改
                                  if g_Config.boRunGuard then Continue;
                                end else begin
                                  if BaseObject.m_btRaceServer <> 55 then begin //不允许穿过练功师
                                    if g_Config.boRUNMON or m_boRUNMON then Continue;
                                  end;
                                end;
                              end;
                            end;
                          end;
                        end;
                        if not BaseObject.m_boGhost and BaseObject.bo2B9 and not BaseObject.m_boDeath
                          and not BaseObject.m_boFixedHideMode and not BaseObject.m_boObMode then begin
                          Result := False;
                          Break;
                        end;
                      end;
                    end;
                  OS_EVENTOBJECT: begin //天雷乱舞 场景，不可穿过
                      if TEvent(OSObject.CellObj).m_nEventType = ET_NOTGOTO then begin
                        Result := False;
                        Break;
                      end;
                    end;
                end; //case
              end;
            end;
          end; //for
        end;
      end;
    end;
  except
  end;
end;

constructor TMapManager.Create;
begin
  nMirrorMapsIndx := 0;
  m_MirrorMaps := TList.Create; //镜像地图列表
  inherited Create;
end;

destructor TMapManager.Destroy;
var
  I: Integer;
begin
  m_MirrorMaps.Free;
  if Count > 0 then begin
    for I := 0 to Count - 1 do begin
      try
        TEnvirnoment(Items[I]).Free; //出现异常
      except
      end;
    end;
  end;
  inherited;
end;

function TMapManager.GetMainMap(Envir: TEnvirnoment): string;
begin
  if Envir.m_boMainMap then Result := Envir.sMainMapName
  else Result := Envir.sMapName;
end;

function TMapManager.FindMap(sMapName: string): TEnvirnoment;
var
  Map: TEnvirnoment;
  I: Integer;
begin
  Result := nil;
  try //20100110 增加
    Lock;
    try
      if Count > 0 then begin //20090430 增加
        for I := 0 to Count - 1 do begin
          Map := TEnvirnoment(Items[I]);
          if Map <> nil then begin //20090128
            if (CompareText(Map.sMapName, sMapName) = 0) and (not Map.m_boMirrorMaping) then begin
              Result := Map;
              Break;
            end;
          end;
        end;
      end;
    finally
      UnLock;
    end;
  except
    Result := nil;
  end;
end;

function TMapManager.GetMapInfo(nServerIdx: Integer; sMapName: string): TEnvirnoment;
var
  I: Integer;
  Envir: TEnvirnoment;
begin
  Result := nil;
  Lock;
  try
    if Count > 0 then begin
      for I := 0 to Count - 1 do begin
        Envir := Items[I];
        if (Envir.nServerIndex = nServerIdx) and (CompareText(Envir.sMapName, sMapName) = 0) then begin
          Result := Envir;
          Break;
        end;
      end;
    end;
  finally
    UnLock;
  end;
end;

function TEnvirnoment.DeleteFromMap(nX, nY: Integer; btType: Byte;
  pRemoveObject: TObject): Integer;
var
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  n18: Integer;
  btRaceServer: Byte;
resourcestring
  //sExceptionMsg1 = '{%s} TEnvirnoment::DeleteFromMap -> Except 1 ** %d';
  sExceptionMsg2 = '{%s} TEnvirnoment::DeleteFromMap -> Except 2 ** %d';
begin
  Result := -1;
  try
    if GetMapCellInfo(nX, nY, MapCellInfo) then begin
      if MapCellInfo <> nil then begin
        try
          if MapCellInfo.ObjList <> nil then begin
            n18 := 0;
            while (True) do begin
              if MapCellInfo.ObjList.Count <= n18 then Break;
              OSObject := MapCellInfo.ObjList.Items[n18];
              if OSObject <> nil then begin
                if (OSObject.btType = btType) and (OSObject.CellObj = pRemoveObject) and (not OSObject.boObjectDisPose) then begin //20090510 修改
                  MapCellInfo.ObjList.Delete(n18);
                  OSObject.boObjectDisPose := True; //20090510 增加
                  Dispose(OSObject);
                  Result := 1;
                  //减地图人物怪物计数
                  if (btType = OS_MOVINGOBJECT) and (not TBaseObject(pRemoveObject).m_boDelFormMaped) then begin
                    TBaseObject(pRemoveObject).m_boDelFormMaped := True;
                    TBaseObject(pRemoveObject).m_boAddToMaped := False;
                    btRaceServer := TBaseObject(pRemoveObject).m_btRaceServer;
                    if btRaceServer = RC_PLAYOBJECT then begin
                      Dec(m_nHumCount);
                      if TBaseObject(pRemoveObject).m_boAI then Dec(m_nHumAICount);
                    end;
                    if btRaceServer >= RC_ANIMAL then Dec(m_nMonCount);
                  end;
                  if MapCellInfo.ObjList.Count <= 0 then begin
                    FreeAndNil(MapCellInfo.ObjList);
                    Break;
                  end;
                  Continue;
                end
              end else begin
                if MapCellInfo.ObjList <> nil then begin //20090412
                  MapCellInfo.ObjList.Delete(n18);
                  if MapCellInfo.ObjList.Count > 0 then Continue;
                  if MapCellInfo.ObjList.Count <= 0 then begin
                    FreeAndNil(MapCellInfo.ObjList);
                    Break;
                  end;
                end else Break;
              end;
              Inc(n18);
            end;
          end else begin
            Result := -2;
          end;
        except
          OSObject := nil;
          MapCellInfo.ObjList := nil; //20100913 按JS增加
          //MainOutMessage(Format(sExceptionMsg1, [btType]));//20090705 注释
        end;
      end else Result := -3;
    end else Result := 0;
  except
    MainOutMessage(Format(sExceptionMsg2, [g_sExceptionVer, btType]));
  end;
end;

function TEnvirnoment.GetItem(nX, nY: Integer): PTMapItem;
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
begin
  Result := nil;
  bo2C := False;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.chFlag = 0) then begin
    bo2C := True;
    if MapCellInfo.ObjList <> nil then begin
      if MapCellInfo.ObjList.Count > 0 then begin //20080630
        for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
          OSObject := MapCellInfo.ObjList.Items[I];
          if OSObject <> nil then begin
            if (not OSObject.boObjectDisPose) then begin //20090510 增加
              {if OSObject.btType = OS_ITEMOBJECT then begin
                Result := PTMapItem(OSObject.CellObj);
                Exit;
              end;
              if OSObject.btType = OS_GATEOBJECT then bo2C := False;
              if OSObject.btType = OS_MOVINGOBJECT then begin
                BaseObject := TBaseObject(OSObject.CellObj);
                if not BaseObject.m_boDeath then bo2C := False;
              end;}
              case OSObject.btType of //20090811 修改
                OS_ITEMOBJECT: begin
                    Result := PTMapItem(OSObject.CellObj);
                    Exit;
                  end;
                OS_GATEOBJECT: bo2C := False;
                OS_MOVINGOBJECT: begin
                    BaseObject := TBaseObject(OSObject.CellObj);
                    if not BaseObject.m_boDeath then bo2C := False;
                  end;
              end; //case
            end;
          end;
        end; //for
      end;
    end;
  end;
end;

function TMapManager.GetMapOfServerIndex(sMapName: string): Integer;
var
  I: Integer;
  Envir: TEnvirnoment;
begin
  Result := 0;
  Lock;
  try
    if Count > 0 then begin //20080630
      for I := 0 to Count - 1 do begin
        Envir := Items[I];
        if (CompareText(Envir.sMapName, sMapName) = 0) then begin
          Result := Envir.nServerIndex;
          Break;
        end;
      end;
    end;
  finally
    UnLock;
  end;
end;

procedure TMapManager.LoadMapDoor;
var
  I: Integer;
begin
  if Count > 0 then begin
    for I := 0 to Count - 1 do begin
      TEnvirnoment(Items[I]).AddDoorToMap;
    end;
  end;
end;

procedure TMapManager.ProcessMapDoor;
begin

end;
//重新设置小地图

procedure TMapManager.ReSetMinMap;
var
  I, II: Integer;
  Envirnoment: TEnvirnoment;
begin
  if Count > 0 then begin
    for I := 0 to Count - 1 do begin
      Envirnoment := TEnvirnoment(Items[I]);
      if MiniMapList.Count > 0 then begin
        for II := 0 to MiniMapList.Count - 1 do begin
          if CompareText(MiniMapList.Strings[II], Envirnoment.sMapName) = 0 then begin
            Envirnoment.nMinMap := Integer(MiniMapList.Objects[II]);
            Break;
          end;
        end;
      end;
    end;
  end;
end;

function TEnvirnoment.IsCheapStuff: Boolean;
begin
  if m_QuestList.Count > 0 then Result := True
  else Result := False;
end;
(*//增加矿石场景   //20101025 注释
function TEnvirnoment.AddToMapMineEvent(nX, nY: Integer; nType: Integer; Event: TObject): TObject;
var
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  bo19: Boolean;
resourcestring
  sExceptionMsg = '{%s} TEnvirnoment::AddToMapMineEvent ';
begin
  Result := nil;
  try
    bo19 := GetMapCellInfo(nX, nY, MapCellInfo);
    if bo19 and (MapCellInfo.chFlag <> 0) then begin
      if MapCellInfo.ObjList = nil then MapCellInfo.ObjList := TList.Create;
      New(OSObject);
      OSObject.btType := nType;
      OSObject.CellObj := Event;
      OSObject.dwAddTime := GetTickCount();
      OSObject.boObjectDisPose:= False;//20090510 增加
      MapCellInfo.ObjList.Add(OSObject);
      Result := Event;
    end;
  except
    MainOutMessage(format(sExceptionMsg,[g_sExceptionVer]));
  end;
end;   *)
//验证地图时间

procedure TEnvirnoment.VerifyMapTime(nX, nY: Integer; BaseObject: TObject);
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  boVerify: Boolean;
//  nCode: Byte;
//resourcestring
//  sExceptionMsg = '{%s} TEnvirnoment::VerifyMapTime Code:%d';
begin
//  nCode:= 0;
  try
    if m_boMirrorMaping then Exit;
    //nCode:= 7;
    boVerify := False;
    //nCode:= 8;
    if GetMapCellInfo(nX, nY, MapCellInfo) then begin
      //nCode:= 9;
      if (MapCellInfo <> nil) and (MapCellInfo.ObjList <> nil) then begin
        //nCode:= 1;
        if MapCellInfo.ObjList.Count > 0 then begin
          //nCode:= 2;
          for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
            //nCode:= 3;
            try
              OSObject := MapCellInfo.ObjList.Items[I];
            except
              OSObject := nil; //20091102增加
            end;
           // nCode:= 32;
            try //20090815 增加
              if (OSObject <> nil) then begin
                //nCode:= 4;
                if (OSObject.btType = OS_MOVINGOBJECT) and (OSObject.CellObj = BaseObject) and (not OSObject.boObjectDisPose) then begin //20090510 增加
                  //nCode:= 5;
                  OSObject.dwAddTime := GetTickCount();
                  boVerify := True;
                  Break;
                end;
              end;
            except
            end;
          end; //for
        end;
      end;
    end;
    //nCode:= 6;
    if not boVerify then AddToMap(nX, nY, OS_MOVINGOBJECT, BaseObject);
  except
    //MainOutMessage(format(sExceptionMsg,[g_sExceptionVer{, nCode}]));
  end;
end;

constructor TEnvirnoment.Create;
begin
  Pointer(MapCellArray) := nil;
  sMapName := '';
  //sSubMapName := '';
  sMainMapName := '';
  m_boMainMap := False;
  nServerIndex := 0;
  nMinMap := 0;
  m_nWidth := 0;
  m_nHeight := 0;
  m_boDARK := False;
  m_boDAY := False;
  m_nMonCount := 0;
  m_nHumCount := 0;
  m_nHumAICount := 0;
  m_DoorList := TList.Create;
  m_QuestList := TList.Create;
  m_UnAllowStdItemsList := TGStringList.Create;
  m_UnAllowMagicList := TGStringList.Create;
  m_ChangMapDropsList := TGStringList.Create;
  m_PointList := TList.Create;
end;

destructor TEnvirnoment.Destroy;
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  nX, nY: Integer;
  DoorInfo: pTDoorInfo;
begin
  for nX := 0 to m_nWidth - 1 do begin
    for nY := 0 to m_nHeight - 1 do begin
      if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
        if MapCellInfo.ObjList.Count > 0 then begin
          for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
            OSObject := MapCellInfo.ObjList.Items[I];
            if OSObject <> nil then begin
              case OSObject.btType of
                OS_ITEMOBJECT: if PTMapItem(OSObject.CellObj) <> nil then Dispose(PTMapItem(OSObject.CellObj));
                OS_GATEOBJECT: if pTGateObj(OSObject.CellObj) <> nil then
                Dispose(pTGateObj(OSObject.CellObj));
                OS_EVENTOBJECT: TEvent(OSObject.CellObj).Free;
              end;
              Dispose(OSObject);
            end;
          end; //for
        end;
        FreeAndNil(MapCellInfo.ObjList);
      end;
    end;
  end;
  if m_DoorList.Count > 0 then begin
    for I := 0 to m_DoorList.Count - 1 do begin
      DoorInfo := m_DoorList.Items[I];
      if DoorInfo <> nil then begin
        if DoorInfo.Status <> nil then begin
          Dec(DoorInfo.Status.nRefCount);
          if DoorInfo.Status.nRefCount <= 0 then Dispose(DoorInfo.Status);
        end;
        Dispose(DoorInfo);
      end;
    end;
  end;
  m_DoorList.Free;
  if m_QuestList.Count > 0 then begin
    for I := 0 to m_QuestList.Count - 1 do begin
      if pTMapQuestInfo(m_QuestList.Items[I]) <> nil then
        Dispose(pTMapQuestInfo(m_QuestList.Items[I]));
    end;
  end;
  m_QuestList.Free;
  //if MapCellArray <> nil then begin//20080723
  if Pointer(MapCellArray) <> nil then begin
    FreeMem(Pointer(MapCellArray));
    Pointer(MapCellArray) := nil;
  end;
  m_UnAllowStdItemsList.Free;
  m_UnAllowMagicList.Free;
  m_ChangMapDropsList.Free;
  m_PointList.Free;
  inherited;
end;
//读取地图Map文件数据

function TEnvirnoment.LoadMapData(sMapFile: string): Boolean;
var
  fHandle: Integer;
  Header: TMapHeader;
  nMapSize: Integer;
  n24, nW, nH: Integer;
  MapBuffer: pTMap;
  NewMapBuffer: pTNewMap;
  Point: Integer;
  Door: pTDoorInfo;
  I: Integer;
  MapCellInfo: pTMapCellinfo;

  sFileName: string;
  sLineText, sX, sY: string;
  LoadList: TStringList;
  nX, nY: Integer;
begin
  Result := False;
  if FileExists(sMapFile) then begin
    fHandle := FileOpen(sMapFile, fmOpenRead or fmShareExclusive);
    if fHandle > 0 then begin
      FileRead(fHandle, Header, SizeOf(TMapHeader));
      m_nWidth := Header.wWidth;
      m_nHeight := Header.wHeight;
      Initialize(m_nWidth, m_nHeight);
      if Header.Logo = 2 then begin //新地图格式(地图元素14字节) 20110428
        nMapSize := m_nWidth * SizeOf(TNewMapUnitInfo) * m_nHeight;
        NewMapBuffer := AllocMem(nMapSize);
        FileRead(fHandle, NewMapBuffer^, nMapSize);

        for nW := 0 to m_nWidth - 1 do begin
          n24 := nW * m_nHeight;
          for nH := 0 to m_nHeight - 1 do begin
            if (NewMapBuffer[n24 + nH].wBkImg) and $8000 <> 0 then begin
              MapCellInfo := @MapCellArray[n24 + nH];
              MapCellInfo.chFlag := 1;
            end;
            if NewMapBuffer[n24 + nH].wFrImg and $8000 <> 0 then begin
              MapCellInfo := @MapCellArray[n24 + nH];
              MapCellInfo.chFlag := 2;
            end;

            if NewMapBuffer[n24 + nH].btDoorIndex and $80 <> 0 then begin
              Point := (NewMapBuffer[n24 + nH].btDoorIndex and $7F);
              if (Point > 0) then begin
                if (sMapName = '3') and (nW = 619) and ((nH = 265) or (nH = 266) or (nH = 267) or (nH = 268)) then Continue; //继续,过滤掉两个坐标识,以避免影响右门打坏后无法进入房间 20110503
                New(Door);
                Door.nX := nW;
                Door.nY := nH;
                Door.n08 := Point;
                Door.Status := nil;
                if m_DoorList.Count > 0 then begin
                  for I := 0 to m_DoorList.Count - 1 do begin
                    if abs(pTDoorInfo(m_DoorList.Items[I]).nX - Door.nX) <= 10 then begin
                      if abs(pTDoorInfo(m_DoorList.Items[I]).nY - Door.nY) <= 10 then begin
                        if pTDoorInfo(m_DoorList.Items[I]).n08 = Point then begin
                          Door.Status := pTDoorInfo(m_DoorList.Items[I]).Status;
                          Inc(Door.Status.nRefCount);
                          Break;
                        end;
                      end;
                    end;
                  end; //for
                end;
                if Door.Status = nil then begin
                  New(Door.Status);
                  Door.Status.boOpened := False;
                  Door.Status.bo01 := False;
                  Door.Status.n04 := 0;
                  Door.Status.dwOpenTick := 0;
                  Door.Status.nRefCount := 1;
                end;
                m_DoorList.Add(Door);
              end;
            end;
          end;
        end;
        FreeMem(NewMapBuffer);
      end else begin //旧地图格式，地图元素12字节
        nMapSize := m_nWidth * SizeOf(TMapUnitInfo) * m_nHeight;
        MapBuffer := AllocMem(nMapSize);
        FileRead(fHandle, MapBuffer^, nMapSize);

        for nW := 0 to m_nWidth - 1 do begin
          n24 := nW * m_nHeight;
          for nH := 0 to m_nHeight - 1 do begin
            if (MapBuffer[n24 + nH].wBkImg) and $8000 <> 0 then begin
              MapCellInfo := @MapCellArray[n24 + nH];
              MapCellInfo.chFlag := 1;
            end;
            if MapBuffer[n24 + nH].wFrImg and $8000 <> 0 then begin
              MapCellInfo := @MapCellArray[n24 + nH];
              MapCellInfo.chFlag := 2;
            end;
            if MapBuffer[n24 + nH].btDoorIndex and $80 <> 0 then begin
              Point := (MapBuffer[n24 + nH].btDoorIndex and $7F);
              if Point > 0 then begin
                New(Door);
                Door.nX := nW;
                Door.nY := nH;
                Door.n08 := Point;
                Door.Status := nil;
                if m_DoorList.Count > 0 then begin //20080630
                  for I := 0 to m_DoorList.Count - 1 do begin
                    if abs(pTDoorInfo(m_DoorList.Items[I]).nX - Door.nX) <= 10 then begin
                      if abs(pTDoorInfo(m_DoorList.Items[I]).nY - Door.nY) <= 10 then begin
                        if pTDoorInfo(m_DoorList.Items[I]).n08 = Point then begin
                          Door.Status := pTDoorInfo(m_DoorList.Items[I]).Status;
                          Inc(Door.Status.nRefCount);
                          Break;
                        end;
                      end;
                    end;
                  end; //for
                end;
                if Door.Status = nil then begin
                  New(Door.Status);
                  Door.Status.boOpened := False;
                  Door.Status.bo01 := False;
                  Door.Status.n04 := 0;
                  Door.Status.dwOpenTick := 0;
                  Door.Status.nRefCount := 1;
                end;
                m_DoorList.Add(Door);
              end;
            end;
          end;
        end;
        FreeMem(MapBuffer);
      end;
      FileClose(fHandle);
      Result := True;
    end;
{--------------------------------加载挂机点-------------------------------------}
    sFileName := g_Config.sEnvirDir + 'Point\' + MapName + '.txt';
    if FileExists(sFileName) then begin
      LoadList := TStringList.Create;
      try
        try
          LoadList.LoadFromFile(sFileName);
        except
        end;
        for I := 0 to LoadList.Count - 1 do begin
          sLineText := Trim(LoadList.Strings[I]);
          if (sLineText = '') or (sLineText[1] = ';') then Continue;
          sLineText := GetValidStr3(sLineText, sX, [',', #9]);
          sLineText := GetValidStr3(sLineText, sY, [',', #9]);
          nX := Str_ToInt(sX, -1);
          nY := Str_ToInt(sY, -1);
          if (nX >= 0) and (nY >= 0) and (nX < m_nWidth) and (nY < m_nHeight) then begin
            m_PointList.Add(Pointer(MakeLong(nX, nY)));
          end;
        end;
      finally
        LoadList.Free;
      end;
    end;
  end;
end;

procedure TEnvirnoment.Initialize(nWidth, nHeight: Integer);
var
  nW, nH: Integer;
  MapCellInfo: pTMapCellinfo;
begin
  if (nWidth > 1) and (nHeight > 1) then begin
    if MapCellArray <> nil then begin
      for nW := 0 to m_nWidth - 1 do begin
        for nH := 0 to m_nHeight - 1 do begin
          MapCellInfo := @MapCellArray[nW * m_nHeight + nH];
          if MapCellInfo.ObjList <> nil then begin
            FreeAndNil(MapCellInfo.ObjList);
          end;
        end;
      end;
      FreeMem(Pointer(MapCellArray));
      Pointer(MapCellArray) := nil;
    end;
    m_nWidth := nWidth;
    m_nHeight := nHeight;
    Pointer(MapCellArray) := AllocMem((m_nWidth * m_nHeight) * SizeOf(TMapCellinfo));
  end;
  m_PointList.Clear;
end;

//nFlag,boFlag,Monster,Item,Quest,boGrouped

function TEnvirnoment.CreateQuest(nFlag, nValue: Integer; s24, s28, s2C: string;
  boGrouped: Boolean): Boolean;
var
  MapQuest: pTMapQuestInfo;
  MapMerchant: TMerchant;
begin
  Result := False;
  if nFlag < 0 then Exit;
  New(MapQuest);
  MapQuest.nFlag := nFlag;
  if nValue > 1 then nValue := 1;
  MapQuest.nValue := nValue;
  if s24 = '*' then s24 := '';
  MapQuest.s08 := s24;
  if s28 = '*' then s28 := '';
  MapQuest.s0C := s28;
  if s2C = '*' then s2C := '';

  MapQuest.bo10 := boGrouped;
  MapMerchant := TMerchant.Create;
  MapMerchant.m_sMapName := '0';
  MapMerchant.m_nCurrX := 0;
  MapMerchant.m_nCurrY := 0;
  MapMerchant.m_sCharName := s2C;
  MapMerchant.m_nFlag := 0;
  MapMerchant.m_wAppr := 0;
  MapMerchant.m_sFilePath := 'MapQuest_def\';
  MapMerchant.m_boIsHide := True;
  MapMerchant.m_boIsQuest := False;

  UserEngine.QuestNPCList.Add(MapMerchant);
  MapQuest.NPC := MapMerchant;
  m_QuestList.Add(MapQuest);
  Result := True;
end;

function TEnvirnoment.GetXYObjCount(nX, nY: Integer): Integer;
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
  nCode: byte; //20090406
begin
  Result := 0;
  nCode := 0;
  try
    if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
      if MapCellInfo.ObjList.Count > 0 then begin //20080630
        nCode := 1;
        for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
          try
            nCode := 2;
            OSObject := MapCellInfo.ObjList.Items[I];
          except
            OSObject := nil; //20090705 增加
          end;
          nCode := 4;
          try //20090814 增加
            if (OSObject <> nil) then begin
              if (OSObject.btType = OS_MOVINGOBJECT) and (not OSObject.boObjectDisPose) then begin //20090510 增加
                nCode := 5;
                BaseObject := TBaseObject(OSObject.CellObj);
                if BaseObject <> nil then begin
                  nCode := 6;
                  if not BaseObject.m_boGhost and
                    BaseObject.bo2B9 and
                    not BaseObject.m_boDeath and
                    not BaseObject.m_boFixedHideMode and
                    not BaseObject.m_boObMode then begin
                    Inc(Result);
                  end;
                end;
              end;
            end;
          except
          end;
        end; //for
      end;
    end;
  except
    MainOutMessage(format('{%s} TEnvirnoment.GetXYObjCount Code:%d', [g_sExceptionVer, nCode]));
  end;
end;

function TEnvirnoment.GetNextPosition(sX, sY, nDir, nFlag: Integer; var snx: Integer; var sny: Integer): Boolean;
begin
  snx := sX;
  sny := sY;
  case nDir of
    DR_UP {0}: if sny > nFlag - 1 then Dec(sny, nFlag);
    DR_DOWN {4}: if sny < (m_nHeight - nFlag) then Inc(sny, nFlag);
    DR_LEFT {6}: if snx > nFlag - 1 then Dec(snx, nFlag);
    DR_RIGHT {2}: if snx < (m_nWidth - nFlag) then Inc(snx, nFlag);
    DR_UPLEFT {7}: begin
        if (snx > nFlag - 1) and (sny > nFlag - 1) then begin
          Dec(snx, nFlag);
          Dec(sny, nFlag);
        end;
      end;
    DR_UPRIGHT {1}: begin
        if (snx > nFlag - 1) and (sny < (m_nHeight - nFlag)) then begin
          Inc(snx, nFlag);
          Dec(sny, nFlag);
        end;
      end;
    DR_DOWNLEFT {5}: begin
        if (snx < (m_nWidth - nFlag)) and (sny > nFlag - 1) then begin
          Dec(snx, nFlag);
          Inc(sny, nFlag);
        end;
      end;
    DR_DOWNRIGHT {3}: begin
        if (snx < (m_nWidth - nFlag)) and (sny < (m_nHeight - nFlag)) then begin
          Inc(snx, nFlag);
          Inc(sny, nFlag);
        end;
      end;
  end;
  if (snx = sX) and (sny = sY) then Result := False
  else Result := True;
end;
//能安全的走

function TEnvirnoment.CanSafeWalk(nX, nY: Integer): Boolean;
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
begin
  Result := True;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
    if MapCellInfo.ObjList.Count > 0 then begin //20080630
      for I := MapCellInfo.ObjList.Count - 1 downto 0 do begin
        OSObject := MapCellInfo.ObjList.Items[I];
        if (OSObject <> nil) then begin
          if (OSObject.btType = OS_EVENTOBJECT) and (not OSObject.boObjectDisPose) then begin
            if (TEvent(OSObject.CellObj).m_nDamage > 0) or
              (TEvent(OSObject.CellObj).m_nEventType = ET_NOTGOTO) then begin
              Result := False;
              Break;
            end;
          end;
        end;
      end;
    end;
  end;
end;

function TEnvirnoment.ArroundDoorOpened(nX, nY: Integer): Boolean;
var
  I: Integer;
  Door: pTDoorInfo;
resourcestring
  sExceptionMsg = '{%s} TEnvirnoment::ArroundDoorOpened ';
begin
  Result := True;
  try
    if m_DoorList.Count > 0 then begin
      for I := 0 to m_DoorList.Count - 1 do begin
        Door := m_DoorList.Items[I];
        if (abs(Door.nX - nX) <= 1) and ((abs(Door.nY - nY) <= 1)) then begin
          if not Door.Status.boOpened then begin
            Result := False;
            Break;
          end;
        end;
      end;
    end;
  except
    MainOutMessage(format(sExceptionMsg, [g_sExceptionVer]));
  end;
end;
//取移动对像

function TEnvirnoment.GetMovingObject(nX, nY: Integer; boFlag: Boolean): Pointer;
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
begin
  Result := nil;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
    if MapCellInfo.ObjList.Count > 0 then begin
      for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
        OSObject := MapCellInfo.ObjList.Items[I];
        if (OSObject <> nil) then begin
          if (OSObject.btType = OS_MOVINGOBJECT) and (not OSObject.boObjectDisPose) then begin //20090510 增加
            BaseObject := TBaseObject(OSObject.CellObj);
            if ((BaseObject <> nil) and (not BaseObject.m_boGhost) and (BaseObject.bo2B9)) and ((not boFlag) or (not BaseObject.m_boDeath)) then begin
              Result := BaseObject;
              Break;
            end;
          end;
        end;
      end;
    end;
  end;
end;

function TEnvirnoment.GetMovingObject(nX, nY: Integer; AObject: TObject; boFlag: Boolean): Pointer;
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  ActorObject: TBaseObject;
begin
  Result := nil;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
    for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
      OSObject := MapCellInfo.ObjList.Items[I];
      if (OSObject <> nil) then begin
        if (OSObject.btType = OS_MOVINGOBJECT) and (not OSObject.boObjectDisPose) then begin
          ActorObject := TBaseObject(OSObject.CellObj);
          if ((not ActorObject.m_boGhost) and (ActorObject.bo2B9) and (not ActorObject.m_boFixedHideMode)) and
            ((not boFlag) or (not ActorObject.m_boDeath)) and (ActorObject = AObject) then begin
            Result := ActorObject;
            Break;
          end;
        end;
      end;
    end;
  end;
end;
//取地图任务NPC

function TEnvirnoment.GetQuestNPC(BaseObject: TObject; sCharName, sStr: string; boFlag: Boolean): TObject;
var
  I: Integer;
  MapQuestFlag: pTMapQuestInfo;
  nFlagValue: Integer;
  bo1D: Boolean;
begin
  Result := nil;
  try
    if m_QuestList.Count > 0 then begin
      for I := 0 to m_QuestList.Count - 1 do begin
        MapQuestFlag := m_QuestList.Items[I];
        if MapQuestFlag <> nil then begin
          nFlagValue := TBaseObject(BaseObject).GetQuestFalgStatus(MapQuestFlag.nFlag);
          if nFlagValue = MapQuestFlag.nValue then begin
            if (boFlag = MapQuestFlag.bo10) or (not boFlag) then begin
              bo1D := False;
              if (MapQuestFlag.s08 <> '') and (MapQuestFlag.s0C <> '') then begin
                if (MapQuestFlag.s08 = sCharName) and (MapQuestFlag.s0C = sStr) then bo1D := True;
              end;
              if (MapQuestFlag.s08 <> '') and (MapQuestFlag.s0C = '') then begin
                if (MapQuestFlag.s08 = sCharName) and (sStr = '') then bo1D := True;
              end;
              if (MapQuestFlag.s08 = '') and (MapQuestFlag.s0C <> '') then begin
                if (MapQuestFlag.s0C = sStr) then bo1D := True;
              end;
              if bo1D then begin
                Result := MapQuestFlag.NPC;
                Break;
              end;
            end;
          end;
        end;
      end;
    end;
  except
  end;
end;

function TEnvirnoment.GetItemEx(nX, nY: Integer; var nCount: Integer): Pointer;
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
begin
  Result := nil;
  nCount := 0;
  bo2C := False;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.chFlag = 0) then begin
    bo2C := True;
    if MapCellInfo.ObjList <> nil then begin
      if MapCellInfo.ObjList.Count > 0 then begin //20080630
        for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
          OSObject := MapCellInfo.ObjList.Items[I];
          if OSObject <> nil then begin
            if (not OSObject.boObjectDisPose) then begin //20090510 增加
              if OSObject.btType = OS_ITEMOBJECT then begin
                Result := Pointer(OSObject.CellObj);
                Inc(nCount);
              end;
              if OSObject.btType = OS_GATEOBJECT then begin
                bo2C := False;
              end;
              if OSObject.btType = OS_MOVINGOBJECT then begin
                BaseObject := TBaseObject(OSObject.CellObj);
                if BaseObject <> nil then begin
                  if not BaseObject.m_boDeath then bo2C := False;
                end;
              end;
            end;
          end;
        end; //for
      end;
    end;
  end;
end;

function TEnvirnoment.GetDoor(nX, nY: Integer): pTDoorInfo;
var
  I: Integer;
  Door: pTDoorInfo;
begin
  Result := nil;
  if m_DoorList.Count > 0 then begin //20080630
    for I := 0 to m_DoorList.Count - 1 do begin
      Door := m_DoorList.Items[I];
      if (Door.nX = nX) and (Door.nY = nY) then begin
        Result := Door;
        Exit;
      end;
    end;
  end;
end;
//判断目标是否有效果(用于挖尸体时的判断)

function TEnvirnoment.IsValidObject(nX, nY, nRage: Integer; BaseObject: TObject): Boolean;
var
  nXX, nYY, I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
begin
  Result := False;
  for nXX := nX - nRage to nX + nRage do begin
    for nYY := nY - nRage to nY + nRage do begin
      if GetMapCellInfo(nXX {nX}, nYY {nY}, MapCellInfo) then begin //20090103 修正挖普通怪，无法挖到
        if (MapCellInfo.ObjList <> nil) then begin //20090103
          if MapCellInfo.ObjList.Count > 0 then begin //20080630
            for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
              OSObject := MapCellInfo.ObjList.Items[I];
              if (OSObject <> nil) then begin
                if (not OSObject.boObjectDisPose) then begin //20090510 增加
                  if (OSObject.CellObj = BaseObject) then begin
                    Result := True;
                    Exit;
                  end;
                end;
              end;
            end; //for
          end;
        end;
      end;
    end;
  end;
end;

function TEnvirnoment.GetRangeBaseObject(nX, nY, nRage: Integer; boFlag: Boolean;
  BaseObjectList: TList): Integer;
var
  nXX, nYY: Integer;
begin
  for nXX := nX - nRage to nX + nRage do begin
    for nYY := nY - nRage to nY + nRage do begin
      GeTBaseObjects(nXX, nYY, boFlag, BaseObjectList);
    end;
  end;
  Result := BaseObjectList.Count;
end;
//boFlag 是否包括死亡对象
//FALSE 包括死亡对象
//TRUE  不包括死亡对象

function TEnvirnoment.GeTBaseObjects(nX, nY: Integer; boFlag: Boolean;
  BaseObjectList: TList): Integer;
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
begin
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
    if MapCellInfo.ObjList.Count > 0 then begin //20080630
      for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
        OSObject := MapCellInfo.ObjList.Items[I];
        if (OSObject <> nil) then begin
          if (OSObject.btType = OS_MOVINGOBJECT) and (not OSObject.boObjectDisPose) then begin //20090510 增加
            BaseObject := TBaseObject(OSObject.CellObj);
            if BaseObject <> nil then begin
              if not BaseObject.m_boGhost and BaseObject.bo2B9 then begin
                if not boFlag or not BaseObject.m_boDeath then BaseObjectList.Add(BaseObject);
              end;
            end;
          end;
        end;
      end;
    end;
  end;
  Result := BaseObjectList.Count;
end;

//清理指定范围内物品 By TasNat at: 2012-03-17 11:14:18

function TEnvirnoment.ClearItem(nX, nY, nRage: Integer): Boolean;
var
  III, I: Integer;
  x, y: Integer;
  nStartX, nStartY, nEndX, nEndY, nCode: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
  MapItem: PTMapItem;
  rList: TList;
resourcestring
  sExceptionMsg = '{%s} TEnvirnoment::ClearItem Code:%d.%p';
begin
  Result := False;
  nCode := 0;
  try
    rList := TList.Create;
    try
      nCode := 1;
      GetMapBaseObjects(nX, nY, nRage + 5, rList);
      nCode := 2;
    except
      nCode := 3;
      rList.Free;
      nCode := 4;
      rList := nil;
    end;

    nCode := 5;
    nStartX := nX - nRage;
    nEndX := nX + nRage;
    nStartY := nY - nRage;
    nEndY := nY + nRage;
    for x := nStartX to nEndX do begin
      for y := nStartY to nEndY do begin
        if GetMapCellInfo(x, y, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
          nCode := 51;
          if MapCellInfo.ObjList.Count > 0 then begin
            nCode := 52;
            for III := MapCellInfo.ObjList.Count - 1 downto 0 do begin
              if MapCellInfo.ObjList.Count < 1 then Break;

              nCode := 53;
              OSObject := pTOSObject(MapCellInfo.ObjList.Items[III]);
              nCode := 54;
              if (OSObject <> nil) then begin
                nCode := 56;
                if (OSObject.btType = OS_ITEMOBJECT) and (not OSObject.boObjectDisPose) then begin
                  nCode := 57;
                  //DisPoseAndNil(PTMapItem(OSObject.CellObj));
                  DisPose(PTMapItem(OSObject.CellObj));//DisPoseAndNil是个不可能实现的函数 用得不好还会产生幻觉 这里就有 By TasNat at: 2012-03-17 17:47:42
                  PTMapItem(OSObject.CellObj):= nil;
                  nCode := 58;
                  MapCellInfo.ObjList.Delete(III);
                  nCode := 59;
                  if (OSObject <> nil) then begin
                    nCode := 510;
                    OSObject.boObjectDisPose := True; //20990510 增加
                    nCode := 511;
                    Dispose(OSObject); //20090103 修改
                  end;
                  nCode := 512;
                  if MapCellInfo.ObjList.Count <= 0 then begin
                    nCode := 513;
                    try //20090512 增加
                      nCode := 514;
                      if MapCellInfo.ObjList <> nil then FreeAndNil(MapCellInfo.ObjList); //20090115 修改
                    except
                    end;
                    break;
                  end;
                end;
              end;
            end; //for
          end;
        end;
      end;
    end;
    nCode := 25;
   //通知玩家物品删除
    try
      if rList <> nil then
        for I := 0 to rList.Count - 1 do begin
          nCode := 26;
          BaseObject := TBaseObject(rList[I]);
          nCode := 27;
          BaseObject.SearchViewRange;
        end;
    except
      rList.Free;
    end;

  except
    MainOutMessage(format(sExceptionMsg, [g_sExceptionVer, nCode, ExceptAddr]));
  end;
  Result := True;
end;
//取地图坐标范围内的怪

function TEnvirnoment.GetMapBaseObjects(nX, nY, nRage: Integer; rList: TList; btType: Byte = OS_MOVINGOBJECT): Boolean;
var
  III: Integer;
  x, y: Integer;
  nStartX, nStartY, nEndX, nEndY: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
resourcestring
  sExceptionMsg = '{%s} TEnvirnoment::GetMapBaseObjects';
begin
  Result := False;
  if rList = nil then Exit;
  try
    nStartX := nX - nRage;
    nEndX := nX + nRage;
    nStartY := nY - nRage;
    nEndY := nY + nRage;
    for x := nStartX to nEndX do begin
      for y := nStartY to nEndY do begin
        if GetMapCellInfo(x, y, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
          if MapCellInfo.ObjList.Count > 0 then begin //20080629
            for III := 0 to MapCellInfo.ObjList.Count - 1 do begin
              OSObject := pTOSObject(MapCellInfo.ObjList.Items[III]);
              if (OSObject <> nil) then begin //20090328
                if (OSObject.btType = btType) and (not OSObject.boObjectDisPose) and (OSObject.CellObj <> nil) then begin //20090510 增加
                  case btType of
                    OS_MOVINGOBJECT: begin
                        BaseObject := TBaseObject(OSObject.CellObj);
                        if (not BaseObject.m_boDeath) and (not BaseObject.m_boGhost) then rList.Add(BaseObject);
                      end;
                    OS_ITEMOBJECT: begin
                        rList.Add(OSObject.CellObj);
                      end;
                  end;
                end;
              end;
            end; //for
          end;
        end;
      end;
    end;
  except
    MainOutMessage(format(sExceptionMsg, [g_sExceptionVer]));
  end;
  Result := True;
end;
//------------------------------------------------------------------------------
//20080124 取指定地图范围内里的物品

function TEnvirnoment.GetMapItem(nX, nY, nRage: Integer; BaseObjectList: TList): Integer;
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  MapItem: PTMapItem;
  nXX, nYY: Integer;
begin
  for nXX := nX - nRage to nX + nRage do begin
    for nYY := nY - nRage to nY + nRage do begin
      if GetMapCellInfo(nXX, nYY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
        if MapCellInfo.ObjList.Count > 0 then begin //20080630
          for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
            OSObject := MapCellInfo.ObjList.Items[I];
            if (OSObject <> nil) then begin
              if (OSObject.btType = OS_ITEMOBJECT) and (not OSObject.boObjectDisPose) then begin //20090510 增加
                MapItem := PTMapItem(pTOSObject(MapCellInfo.ObjList.Items[I]).CellObj);
                if MapItem <> nil then begin
                  if MapItem.Name <> '' then BaseObjectList.Add(MapItem);
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
  Result := BaseObjectList.Count;
end;
//------------------------------------------------------------------------------

function TEnvirnoment.GetEvent(nX, nY: Integer): TObject;
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
begin
  Result := nil;
  bo2C := False;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
    if MapCellInfo.ObjList.Count > 0 then begin
      for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
        OSObject := MapCellInfo.ObjList.Items[I];
        if (OSObject <> nil) then begin
          if (OSObject.btType = OS_EVENTOBJECT) and (not OSObject.boObjectDisPose) then begin //20090510 增加
            Result := OSObject.CellObj;
          end;
        end;
      end;
    end;
  end;
end;
//设置地图指定XY坐标的标志

procedure TEnvirnoment.SetMapXYFlag(nX, nY: Integer; boFlag: Boolean);
var
  MapCellInfo: pTMapCellinfo;
begin
  if GetMapCellInfo(nX, nY, MapCellInfo) then begin
    if boFlag then MapCellInfo.chFlag := 0
    else MapCellInfo.chFlag := 2;
  end;
end;

function TEnvirnoment.CanFly(nSX, nSY, nDX, nDY: Integer): Boolean;
var
  r28, r30: real;
  n14, n18, n1C: Integer;
begin
  Result := True;
  r28 := (nDX - nSX) / 1.0E1;
  r30 := (nDY - nDX) / 1.0E1;
  n14 := 0;
  while (True) do begin
    try //20101126 防止死循环
      n18 := Round(nSX + r28);
      n1C := Round(nSY + r30);
      if not CanWalk(n18, n1C, True) then begin
        Result := False;
        Break;
      end;
    except
    end;
    Inc(n14);
    if n14 >= 10 then Break;
  end;
end;

function TEnvirnoment.GetXYHuman(nMapX, nMapY: Integer): Boolean;
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
begin
  Result := False;
  if GetMapCellInfo(nMapX, nMapY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
    if MapCellInfo.ObjList.Count > 0 then begin //20080630
      for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
        OSObject := MapCellInfo.ObjList.Items[I];
        if (OSObject <> nil) then begin
          if (OSObject.btType = OS_MOVINGOBJECT) and (not OSObject.boObjectDisPose) then begin //20090510 增加
            BaseObject := TBaseObject(OSObject.CellObj);
            if BaseObject <> nil then begin
              if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
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

function TEnvirnoment.sub_4B5FC8(nX, nY: Integer): Boolean;
var
  MapCellInfo: pTMapCellinfo;
begin
  Result := True;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.chFlag = 2) then Result := False;
end;
//取地图信息

function TEnvirnoment.GetEnvirInfo: string;
var
  sMsg: string;
begin
  sMsg := '地图名:%s(%s) DAY:%s DARK:%s SAFE:%s FIGHT:%s FIGHT3:%s QUIZ:%s NORECONNECT:%s(%s) MUSIC:%s(%d) EXPRATE:%s(%f) PKWINLEVEL:%s(%d) PKLOSTLEVEL:%s(%d) PKWINEXP:%s(%d) PKLOSTEXP:%s(%d) DECHP:%s(%d/%d) INCHP:%s(%d/%d)';
  sMsg := sMsg + ' DECGAMEGOLD:%s(%d/%d) INCGAMEGOLD:%s(%d/%d) INCGAMEPOINT:%s(%d/%d) DECGAMEPOINT:%s(%d/%d) RUNHUMAN:%s RUNMON:%s NEEDHOLE:%s NORECALL:%s NOGUILDRECALL:%s NODEARRECALL:%s NOMASTERRECALL:%s NODRUG:%s MINE:%s NOPOSITIONMOVE:%s NOCALLHERO:%s MISSION:%s';
  Result := Format(sMsg, [sMapName, sMapDesc,
    BoolToCStr(m_boDAY),
      BoolToCStr(m_boDARK),
      BoolToCStr(m_boSAFE),
      BoolToCStr(m_boFightZone),
      BoolToCStr(m_boFight3Zone),
      BoolToCStr(m_boQUIZ),
      BoolToCStr(m_boNORECONNECT), sNoReconnectMap,
      BoolToCStr(m_boMUSIC), m_nMUSICID,
      BoolToCStr(m_boEXPRATE), m_nEXPRATE / 100,
      BoolToCStr(m_boPKWINLEVEL), m_nPKWINLEVEL,
      BoolToCStr(m_boPKLOSTLEVEL), m_nPKLOSTLEVEL,
      BoolToCStr(m_boPKWINEXP), m_nPKWINEXP,
      BoolToCStr(m_boPKLOSTEXP), m_nPKLOSTEXP,
      BoolToCStr(m_boDECHP), m_nDECHPTIME, m_nDECHPPOINT,
      BoolToCStr(m_boINCHP), m_nINCHPTIME, m_nINCHPPOINT,
      BoolToCStr(m_boDecGameGold), m_nDECGAMEGOLDTIME, m_nDecGameGold,
      BoolToCStr(m_boIncGameGold), m_nINCGAMEGOLDTIME, m_nIncGameGold,
      BoolToCStr(m_boINCGAMEPOINT), m_nINCGAMEPOINTTIME, m_nINCGAMEPOINT,
      BoolToCStr(m_boDECGAMEPOINT), m_nDECGAMEPOINTTIME, m_nDECGAMEPOINT,
      BoolToCStr(m_boRUNHUMAN),
      BoolToCStr(m_boRUNMON),
      BoolToCStr(m_boNEEDHOLE),
      BoolToCStr(m_boNORECALL),
      BoolToCStr(m_boNOGUILDRECALL),
      BoolToCStr(m_boNODEARRECALL),
      BoolToCStr(m_boNOMASTERRECALL),
      BoolToCStr(m_boNODRUG),
      BoolToCStr(m_boMINE),
      BoolToCStr(m_boNOPOSITIONMOVE),
      BoolToCStr(m_boNOCALLHERO), //20080124 禁止召唤英雄
      BoolToCStr(m_boMISSION) //20080124 不允许使用任何物品和技能
      ]);
end;

procedure TEnvirnoment.AddObject(nType: Integer);
begin
  case nType of
    0: Inc(m_nHumCount);
    1: Inc(m_nMonCount);
  end;
end;

procedure TEnvirnoment.DelObjectCount(BaseObject: TObject);
var
  btRaceServer: Byte;
begin
  btRaceServer := TBaseObject(BaseObject).m_btRaceServer;
  if btRaceServer = RC_PLAYOBJECT then begin
    Dec(m_nHumCount);
    if TBaseObject(BaseObject).m_boAI then Dec(m_nHumAICount);
  end;
  if btRaceServer >= RC_ANIMAL then Dec(m_nMonCount);
end;
//删除地图

function TMapManager.DelMap(sMapName: string): Boolean;
var
  Map: TEnvirnoment;
  I: Integer;
begin
  Result := False;
  try
    Lock;
    try
      if Count > 0 then begin
        for I := 0 to Count - 1 do begin
          Map := TEnvirnoment(Items[I]);
          if Map <> nil then begin
            if CompareText(Map.sMapName, sMapName) = 0 then begin
              Self.Delete(I);
              Map.Free;
              Result := True;
              Break;
            end;
          end;
        end;
      end;
    finally
      UnLock;
    end;
  except
    Result := False;
  end;
end;

procedure TMapManager.Run;
var
  I, II: Integer;
  Envir: TEnvirnoment;
  BaseObject: TBaseObject;
  BaseObjectList: TList;
  nCode: Byte;
  boProcessLimit: Boolean;
begin
  if GetTickCount - m_dwRunTick > 10000 then begin
    m_dwRunTick := GetTickCount;
    try
      if m_MirrorMaps.Count > 0 then begin
        for I := nMirrorMapsIndx to m_MirrorMaps.Count - 1 do begin
          if I >= m_MirrorMaps.Count then Break;
          Envir := m_MirrorMaps.Items[I];
          nCode := 1;
          if Envir <> nil then begin
            nCode := 2;
            if Envir.m_boMirrorMap and (not Envir.m_boMirrorMaping)
              and (GetTickCount >= Envir.m_dwMirrorMapTick) and (Envir.sMirrorHomeMap <> '') then begin
              BaseObjectList := TList.Create; //清除地图的人物
              nCode := 3;
              try
                Envir.GetRangeBaseObject(Envir.m_nWidth div 2, Envir.m_nHeight div 2, _MAX(Envir.m_nWidth div 2, Envir.m_nHeight div 2), True, BaseObjectList);
                Envir.m_boMirrorMaping := True;
                if BaseObjectList.Count > 0 then begin
                  nCode := 4;
                  for II := 0 to BaseObjectList.Count - 1 do begin
                    BaseObject := TBaseObject(BaseObjectList.Items[II]);
                    if BaseObject <> nil then begin
                      nCode := 5;
                      if (not BaseObject.m_boDeath) and (not BaseObject.m_boGhost) then begin
                        case BaseObject.m_btRaceServer of
                          RC_PLAYOBJECT: begin
                              nCode := 6;
                              BaseObject.SendRefMsg(RM_SPACEMOVE_FIRE, 0, 0, 0, 0, '');
                              BaseObject.MapRandomMove(Envir.sMirrorHomeMap, 0); //移动到指定地图
                            end;
                          RC_HEROOBJECT: begin
                              nCode := 7;
                              BaseObject.SendRefMsg(RM_SPACEMOVE_FIRE, 0, 0, 0, 0, '');
                              BaseObject.MapRandomMove(Envir.sMirrorHomeMap, 0); //移动到指定地图
                            end;
                        else begin
                            if BaseObject.m_Master <> nil then begin
                              nCode := 8;
                              if BaseObject.m_Master.m_btRaceServer in [RC_PLAYOBJECT, RC_HEROOBJECT] then begin
                                nCode := 9;
                                BaseObject.SendRefMsg(RM_SPACEMOVE_FIRE, 0, 0, 0, 0, '');
                                BaseObject.MapRandomMove(Envir.sMirrorHomeMap, 0); //移动到指定地图
                              end else begin
                                nCode := 10;
                                BaseObject.m_boDeath := True;
                                BaseObject.m_boGhost := True;
                                //BaseObject.m_dwGhostTick := GetTickCount();
                              end;
                            end else begin
                              nCode := 11;
                              BaseObject.m_boDeath := True;
                              BaseObject.m_boGhost := True;
                              //BaseObject.m_dwGhostTick := GetTickCount();
                            end;
                          end;
                        end;
                      end;
                    end;
                  end;
                end;
              finally
                BaseObjectList.Free;
              end;
              nCode := 9;
              m_MirrorMaps.Delete(I);
              nCode := 10;
              DelMap(Envir.sMapName);
              Break;
            end;
          end;
          if ((GetTickCount - m_dwRunTick) > 10) and (I < (m_MirrorMaps.Count - 1)) then begin
            nMirrorMapsIndx := I + 1;
            boProcessLimit := True;
            Break;
          end;
        end;
      end;
      if not boProcessLimit then nMirrorMapsIndx := 0;
    except
      MainOutMessage(Format('{%s} TMapManager.Run Code:%d', [g_sExceptionVer, nCode]));
    end;
  end;
end;

end.

