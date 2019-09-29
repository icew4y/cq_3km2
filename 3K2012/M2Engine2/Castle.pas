unit Castle;  // liuzhigang 城堡的相关代码

interface
uses
  Windows, Classes, SysUtils, IniFiles, Grobal2, ObjBase, ObjMon2, Guild, Envir;
const
  MAXCASTLEARCHER = {12}24;//弓箭手数量
  MAXCALSTEGUARD = {4}8;//守卫数量
type
  TDefenseUnit = record
    nMainDoorX: Integer; //0x00
    nMainDoorY: Integer; //0x04
    sMainDoorName: string; //0x08
    boXXX: Boolean; //0x0C
    wMainDoorHP: Word; //0x10
    MainDoor: TBaseObject;
    LeftWall: TBaseObject;
    CenterWall: TBaseObject;
    RightWall: TBaseObject;
    Archer: TBaseObject;
  end;
  pTDefenseUnit = ^TDefenseUnit;
  TObjUnit = record
    nX: Integer; //0x0
    nY: Integer; //0x4
    sName: string; //0x8
    nStatus: Boolean; //0x0C
    nHP: Integer; //0x10
    BaseObject: TBaseObject; //0x14
  end;
  pTObjUnit = ^TObjUnit;
  TAttackerInfo = record
    AttackDate: TDateTime;
    sGuildName: string;
    Guild: TGUild;
  end;
  pTAttackerInfo = ^TAttackerInfo;
  TUserCastle = class
    m_MapCastle: TEnvirnoment; //城堡所在地图
    m_MapPalace: TEnvirnoment; //皇宫所在地图
    m_MapSecret: TEnvirnoment; //密道所在地图
    m_DoorStatus: pTDoorStatus; //皇宫门状态
    m_sMapName: string; //城堡所在地图名
    m_sName: string; //城堡名称
    m_sOwnGuild: string; //管理行会名称
    m_MasterGuild: TGUild; //所属行会
    m_OldGuild: TGUild;//以前占领的行会 20090304
    m_sHomeMap: string; //守方行会回城点地图
    m_nHomeX: Integer; //守方行会回城点X
    m_nHomeY: Integer; //守方行会回城点Y
    m_sWarAreaHomeMap: string; //攻方行会回城点地图 20090527
    m_nWarAreaHomeX: Integer; //攻方行会回城点X 20090527
    m_nWarAreaHomeY: Integer; //攻方行会回城点Y 20090527
    m_ChangeDate: TDateTime; //占领日期
    m_WarDate: TDateTime; //攻城日期
    m_boStartWar: Boolean; //是否开始攻城
    m_boUnderWar: Boolean; //是否正在攻城
    m_boShowOverMsg: Boolean; //是否已显示攻城结束信息
    m_dwStartCastleWarTick: LongWord; //0x44
    m_dwSaveTick: LongWord; //保存间隔
    m_AttackWarList: TList; //攻城列表
    m_AttackGuildList: TList; //攻城行会列表
    m_MainDoor: TObjUnit; //城门
    m_LeftWall: TObjUnit; //皇宫门
    m_CenterWall: TObjUnit; //皇宫门
    m_RightWall: TObjUnit; //皇宫门
    m_Guard: array[0..MAXCALSTEGUARD - 1] of TObjUnit; //守卫
    m_Archer: array[0..MAXCASTLEARCHER - 1] of TObjUnit; //弓箭手
    m_IncomeToday: TDateTime; //0x238
    m_nTotalGold: Integer; //0x240
    m_nTodayIncome: Integer; //0x244
    m_nWarRangeX: Integer; //攻城区域范围X
    m_nWarRangeY: Integer; //攻城区域范围Y
    m_sPalaceMap: string; //皇宫所在地图
    m_sSecretMap: string; //密道所在地图
    m_nPalaceDoorX: Integer; //皇宫座标X
    m_nPalaceDoorY: Integer; //皇宫座标Y
    m_sConfigDir: string;
    m_EnvirList: TStringList;

    m_nTechLevel: Integer; //科技等级
    m_nPower: Integer; //电力量
  private
    procedure SaveConfigFile();
    procedure LoadConfig(IsReLoad: Boolean);
    procedure SaveAttackSabukWall();
    function InAttackerList(Guild: TGUild): Boolean;
    procedure SetTechLevel(nLevel: Integer);
    procedure SetPower(nPower: Integer);
  public
    constructor Create(sCastleDir: string);
    destructor Destroy; override;
    procedure Initialize();
    procedure Run();
    procedure Save();
    procedure LoadAttackSabukWall();
    function InCastleWarArea(Envir: TEnvirnoment; nX, nY: Integer): Boolean;
    function IsMember(Cert: TBaseObject): Boolean;
    function IsMasterGuild(Guild: TGUild): Boolean;
    function IsAttackGuild(Guild: TGUild): Boolean;
    function IsAttackAllyGuild(Guild: TGUild): Boolean;
    function IsDefenseGuild(Guild: TGUild): Boolean;
    function IsDefenseAllyGuild(Guild: TGUild): Boolean;

    function CanGetCastle(Guild: TGUild): Boolean;
    procedure GetCastle(Guild: TGUild);
    procedure StartWallconquestWar;
    procedure StopWallconquestWar();
    function InPalaceGuildCount(): Integer;
    function GetHomeX(): Integer;
    function GetHomeY(): Integer;
    function GetMapName(): string;
    function GetWarAreaHomeX: Integer;
    function GetWarAreaHomeY: Integer;
    function GetWarAreaHomeName: string;
    function AddAttackerInfo(Guild: TGUild; nCode: Byte): Boolean;
    function CheckInPalace(nX, nY: Integer; Cert: TBaseObject): Boolean;
    function GetWarDate(): string;
    function GetAttackWarList(): string;
    procedure IncRateGold(nGold: Integer);
    function WithDrawalGolds(PlayObject: TPlayObject; nGold: Integer): Integer;
    function ReceiptGolds(PlayObject: TPlayObject; nGold: Integer): Integer;
    procedure MainDoorControl(boClose: Boolean);
    function RepairDoor(): Boolean;
    function RepairWall(nWallIndex: Integer): Boolean;
    property nTechLevel: Integer read m_nTechLevel write SetTechLevel;
    property nPower: Integer read m_nPower write SetPower;
  end;

  TCastleManager = class
  private
    CriticalSection: TRTLCriticalSection;
  protected
  public
    m_CastleList: TList;//城堡列表
    constructor Create();
    destructor Destroy; override;
    procedure LoadCastleList();
    procedure SaveCastleList();
    procedure Initialize();
    procedure Lock;
    procedure UnLock;
    procedure Run();
    procedure Save();
    function Find(sCASTLENAME: string): TUserCastle;
    function GetCastle(nIndex: Integer): TUserCastle;
    function InCastleWarArea(BaseObject: TBaseObject): TUserCastle; overload;
    function InCastleWarArea(Envir: TEnvirnoment; nX, nY: Integer): TUserCastle; overload;
    function IsCastleMember(BaseObject: TBaseObject): TUserCastle;
    function IsCastlePalaceEnvir(Envir: TEnvirnoment): TUserCastle;
    function IsCastleEnvir(Envir: TEnvirnoment): TUserCastle;
    procedure GetCastleGoldInfo(List: TStringList);
    procedure GetCastleNameList(List: TStringList);
    procedure IncRateGold(nGold: Integer);

    procedure ReLoadCastle();
  end;
implementation

uses UsrEngn, M2Share, HUtil32;

{ TUserCastle }
constructor TUserCastle.Create(sCastleDir: string);
begin
  m_MasterGuild := nil;
  m_OldGuild := nil;//以前占领的行会 20090304
  m_sHomeMap := g_Config.sCastleHomeMap {'3'};
  m_nHomeX := g_Config.nCastleHomeX {644};
  m_nHomeY := g_Config.nCastleHomeY {290};
  m_sName := g_Config.sCASTLENAME {'沙巴克'};

  m_sWarAreaHomeMap:= '3'; //攻方行会回城点地图 20090527
  m_nWarAreaHomeX:= 330; //攻方行会回城点X 20090527
  m_nWarAreaHomeY:= 330; //攻方行会回城点Y 20090527

  m_sConfigDir := sCastleDir;
  m_sPalaceMap := '0150';
  m_sSecretMap := 'D701';
  m_MapCastle := nil;
  m_DoorStatus := nil;
  m_boStartWar := False;
  m_boUnderWar := False;
  m_boShowOverMsg := False;
  m_AttackWarList := TList.Create;
  m_AttackGuildList := TList.Create;
  m_dwSaveTick := 0;
  m_nWarRangeX := g_Config.nCastleWarRangeX;
  m_nWarRangeY := g_Config.nCastleWarRangeY;
  m_EnvirList := TStringList.Create;

  m_Archer[0].nX:= 662;
  m_Archer[0].nY:= 333;
  m_Archer[1].nX:= 664;
  m_Archer[1].nY:= 331;
  m_Archer[2].nX:= 666;
  m_Archer[2].nY:= 329;
  m_Archer[3].nX:= 676;
  m_Archer[3].nY:= 319;
  m_Archer[4].nX:= 678;
  m_Archer[4].nY:= 317;
  m_Archer[5].nX:= 681;
  m_Archer[5].nY:= 314;
  m_Archer[6].nX:= 628;
  m_Archer[6].nY:= 271;
  m_Archer[7].nX:= 632;
  m_Archer[7].nY:= 267;
  m_Archer[8].nX:= 670;
  m_Archer[8].nY:= 335;
  m_Archer[9].nX:= 671;
  m_Archer[9].nY:= 334;
  m_Archer[10].nX:= 675;
  m_Archer[10].nY:= 330;
  m_Archer[11].nX:= 676;
  m_Archer[11].nY:= 329;

  m_Archer[12].nX:= 583;
  m_Archer[12].nY:= 335;
  m_Archer[13].nX:= 584;
  m_Archer[13].nY:= 335;
  m_Archer[14].nX:= 585;
  m_Archer[14].nY:= 336;
  m_Archer[15].nX:= 581;
  m_Archer[15].nY:= 332;
  m_Archer[16].nX:= 580;
  m_Archer[16].nY:= 331;
  m_Archer[17].nX:= 581;
  m_Archer[17].nY:= 333;

  m_Archer[18].nX:= 677;
  m_Archer[18].nY:= 239;
  m_Archer[19].nX:= 676;
  m_Archer[19].nY:= 238;
  m_Archer[20].nX:= 675;
  m_Archer[20].nY:= 237;
  m_Archer[21].nX:= 674;
  m_Archer[21].nY:= 236;
  m_Archer[22].nX:= 673;
  m_Archer[22].nY:= 235;
  m_Archer[23].nX:= 672;
  m_Archer[23].nY:= 234;

  m_Guard[0].nX:= 652;
  m_Guard[0].nY:= 323;
  m_Guard[1].nX:= 665;
  m_Guard[1].nY:= 310;
  m_Guard[2].nX:= 657;
  m_Guard[2].nY:= 306;
  m_Guard[3].nX:= 650;
  m_Guard[3].nY:= 315;

  m_Guard[4].nX:= 666;
  m_Guard[4].nY:= 246;
  m_Guard[5].nX:= 668;
  m_Guard[5].nY:= 247;
  m_Guard[6].nX:= 591;
  m_Guard[6].nY:= 324;
  m_Guard[7].nX:= 589;
  m_Guard[7].nY:= 322;
end;

destructor TUserCastle.Destroy;
var
  I: Integer;
begin
  if m_AttackWarList.Count > 0 then begin//20080630
    for I := 0 to m_AttackWarList.Count - 1 do begin
      if pTAttackerInfo(m_AttackWarList.Items[I]) <> nil then
         Dispose(pTAttackerInfo(m_AttackWarList.Items[I]));
    end;
  end;
  m_AttackWarList.Free;
  m_AttackGuildList.Free;
  m_EnvirList.Free;
  inherited;
end;
procedure TUserCastle.Initialize;
var
  I: Integer;
  ObjUnit: pTObjUnit;
  Door: pTDoorInfo;
begin
  LoadConfig(False);
  LoadAttackSabukWall();
  if g_MapManager.GetMapOfServerIndex(m_sMapName) = nServerIndex then begin
    //m_MapPalace:=EnvirList.FindMap('0150');
    m_MapPalace := g_MapManager.FindMap(m_sPalaceMap);
    if m_MapPalace = nil then begin
      MainOutMessage(Format('皇宫地图%s没找到！！！', [m_sPalaceMap]));
    end;
    m_MapSecret := g_MapManager.FindMap(m_sSecretMap);
    if m_MapSecret = nil then begin
      MainOutMessage(Format('密道地图%s没找到！！！', [m_sSecretMap]));
    end;
    m_MapCastle := g_MapManager.FindMap(m_sMapName);
    if m_MapCastle <> nil then begin
      m_MapCastle.SetMapXYFlag(m_MainDoor.nX, m_MainDoor.nY, True);//20090509 增加
      m_MapCastle.SetMapXYFlag(m_LeftWall.nX, m_LeftWall.nY, True);//20090509 增加
      m_MapCastle.SetMapXYFlag(m_CenterWall.nX, m_CenterWall.nY, True);//20090509 增加
      m_MapCastle.SetMapXYFlag(m_RightWall.nX, m_RightWall.nY, True);//20090509 增加
      m_MainDoor.BaseObject := UserEngine.RegenMonsterByName(m_sMapName, m_MainDoor.nX, m_MainDoor.nY, m_MainDoor.sName);
      if m_MainDoor.BaseObject <> nil then begin
        m_MainDoor.BaseObject.m_WAbil.HP := m_MainDoor.nHP;
        m_MainDoor.BaseObject.m_Castle := Self;
        //if MainDoor.nStatus <> 0 then begin
        if m_MainDoor.nStatus then begin
          TCastleDoor(m_MainDoor.BaseObject).Open;
        end;
      end else begin
        MainOutMessage('[错误信息] 城堡初始化城门失败，检查怪物数据库里有没城门的设置: ' + m_MainDoor.sName);
      end;

      m_LeftWall.BaseObject := UserEngine.RegenMonsterByName(m_sMapName, m_LeftWall.nX, m_LeftWall.nY, m_LeftWall.sName);
      if m_LeftWall.BaseObject <> nil then begin
        m_LeftWall.BaseObject.m_WAbil.HP := m_LeftWall.nHP;
        m_LeftWall.BaseObject.m_Castle := Self;
      end else begin
        MainOutMessage('[错误信息] 城堡初始化左城墙失败，检查怪物数据库里有没左城墙的设置: ' + m_LeftWall.sName);
      end;

      m_CenterWall.BaseObject := UserEngine.RegenMonsterByName(m_sMapName, m_CenterWall.nX, m_CenterWall.nY, m_CenterWall.sName);
      if m_CenterWall.BaseObject <> nil then begin
        m_CenterWall.BaseObject.m_WAbil.HP := m_CenterWall.nHP;
        m_CenterWall.BaseObject.m_Castle := Self;
      end else begin
        MainOutMessage('[错误信息] 城堡初始化中城墙失败，检查怪物数据库里有没中城墙的设置: ' + m_CenterWall.sName);
      end;

      m_RightWall.BaseObject := UserEngine.RegenMonsterByName(m_sMapName, m_RightWall.nX, m_RightWall.nY, m_RightWall.sName);
      if m_RightWall.BaseObject <> nil then begin
        m_RightWall.BaseObject.m_WAbil.HP := m_RightWall.nHP;
        m_RightWall.BaseObject.m_Castle := Self;
      end else begin
        MainOutMessage('[错误信息] 城堡初始化右城墙失败，检查怪物数据库里有没右城墙的设置: ' + m_RightWall.sName);
      end;

      for I := Low(m_Archer) to High(m_Archer) do begin
        ObjUnit := @m_Archer[I];
        if ObjUnit.nHP <= 0 then Continue;
        ObjUnit.BaseObject := UserEngine.RegenMonsterByName(m_sMapName, ObjUnit.nX, ObjUnit.nY, ObjUnit.sName);
        if ObjUnit.BaseObject <> nil then begin
          ObjUnit.BaseObject.m_WAbil.HP := m_Archer[I].nHP;
          ObjUnit.BaseObject.m_Castle := Self;
          TGuardUnit(ObjUnit.BaseObject).m_nX550 := ObjUnit.nX;
          TGuardUnit(ObjUnit.BaseObject).m_nY554 := ObjUnit.nY;
          TGuardUnit(ObjUnit.BaseObject).m_nDirection := 3;
        end else begin
          MainOutMessage('[错误信息] 城堡初始化弓箭手失败，检查怪物数据库里有没弓箭手的设置: ' + ObjUnit.sName);
        end;
      end;
      for I := Low(m_Guard) to High(m_Guard) do begin
        ObjUnit := @m_Guard[I];
        if ObjUnit.nHP <= 0 then Continue;
        ObjUnit.BaseObject := UserEngine.RegenMonsterByName(m_sMapName, ObjUnit.nX, ObjUnit.nY, ObjUnit.sName);
        if ObjUnit.BaseObject <> nil then begin
          ObjUnit.BaseObject.m_Castle := Self;//20090629 增加
          ObjUnit.BaseObject.m_WAbil.HP := m_Guard[I].nHP;
        end else begin
          MainOutMessage('[错误信息] 城堡初始化守卫失败(检查怪物数据库里有没守卫怪物)');
        end;
      end;
      if m_MapCastle.m_DoorList.Count > 0 then begin//20080630
        for I := 0 to m_MapCastle.m_DoorList.Count - 1 do begin
          Door := m_MapCastle.m_DoorList.Items[I];
          if (abs(Door.nX - m_nPalaceDoorX {631}) <= 3) and (abs(Door.nY - m_nPalaceDoorY {274}) <= 3) then begin
            m_DoorStatus := Door.Status;
          end;
        end;
      end;
    end else begin
      MainOutMessage(Format('[错误信息] 城堡所在地图不存在(检查地图配置文件里是否有地图%s的设置)', [m_sMapName]));
    end;
  end;
end;

procedure TUserCastle.LoadConfig(IsReLoad: Boolean); //读取沙巴克配置文件
var
  sFileName, sConfigFile: string;
  CastleConf: TIniFile;
  I: Integer;
  ObjUnit: pTObjUnit;
  sMapList, sMAP: string;
begin
  if not DirectoryExists(g_Config.sCastleDir + m_sConfigDir) then begin
    CreateDir(g_Config.sCastleDir + m_sConfigDir);
  end;
  sConfigFile := 'SabukW.txt';
  sFileName := g_Config.sCastleDir + m_sConfigDir + '\' + sConfigFile;
  CastleConf := TIniFile.Create(sFileName);
  if CastleConf <> nil then begin
    m_sName := CastleConf.ReadString('Setup', 'CastleName', m_sName);
    m_sOwnGuild := CastleConf.ReadString('Setup', 'OwnGuild', '');
    m_ChangeDate := CastleConf.ReadDateTime('Setup', 'ChangeDate', Now);
    m_WarDate := CastleConf.ReadDateTime('Setup', 'WarDate', Now);
    m_IncomeToday := CastleConf.ReadDateTime('Setup', 'IncomeToday', Now);
    m_nTotalGold := CastleConf.ReadInteger('Setup', 'TotalGold', 0);
    m_nTodayIncome := CastleConf.ReadInteger('Setup', 'TodayIncome', 0);

    sMapList := CastleConf.ReadString('Defense', 'CastleMapList', '');
    if sMapList <> '' then begin
      m_EnvirList.Clear;//20090304 修改
      while (sMapList <> '') do begin
        sMapList := GetValidStr3(sMapList, sMAP, [',']);
        if sMAP = '' then Break;
        m_EnvirList.Add(sMAP);
      end;
    end;
    if m_EnvirList.Count > 0 then begin//20080630
      for I := 0 to m_EnvirList.Count - 1 do begin
        m_EnvirList.Objects[I] := g_MapManager.FindMap(m_EnvirList.Strings[I]);
      end;
    end;

    m_sMapName := CastleConf.ReadString('Defense', 'CastleMap', '3');
    m_sHomeMap := CastleConf.ReadString('Defense', 'CastleHomeMap', m_sHomeMap);
    m_nHomeX := CastleConf.ReadInteger('Defense', 'CastleHomeX', m_nHomeX);
    m_nHomeY := CastleConf.ReadInteger('Defense', 'CastleHomeY', m_nHomeY);

    m_sWarAreaHomeMap := CastleConf.ReadString('Defense', 'CastleWarAreaHomeMap', m_sWarAreaHomeMap); //攻方行会回城点地图 20090527
    m_nWarAreaHomeX := CastleConf.ReadInteger('Defense', 'CastleWarAreaHomeX', m_nWarAreaHomeX);//攻方行会回城点X 20090527
    m_nWarAreaHomeY := CastleConf.ReadInteger('Defense', 'CastleWarAreaHomeY', m_nWarAreaHomeY);//攻方行会回城点Y 20090527

    m_nWarRangeX := CastleConf.ReadInteger('Defense', 'CastleWarRangeX', m_nWarRangeX);
    m_nWarRangeY := CastleConf.ReadInteger('Defense', 'CastleWarRangeY', m_nWarRangeY);
    m_sPalaceMap := CastleConf.ReadString('Defense', 'CastlePlaceMap', m_sPalaceMap);
    m_sSecretMap := CastleConf.ReadString('Defense', 'CastleSecretMap', m_sSecretMap);
    m_nPalaceDoorX := CastleConf.ReadInteger('Defense', 'CastlePalaceDoorX', 631);
    m_nPalaceDoorY := CastleConf.ReadInteger('Defense', 'CastlePalaceDoorY', 274);

    m_MainDoor.nX := CastleConf.ReadInteger('Defense', 'MainDoorX', 672);
    m_MainDoor.nY := CastleConf.ReadInteger('Defense', 'MainDoorY', 330);
    m_MainDoor.sName := CastleConf.ReadString('Defense', 'MainDoorName', '城门');
    m_MainDoor.nStatus := CastleConf.ReadBool('Defense', 'MainDoorOpen', True);
    m_MainDoor.nHP := CastleConf.ReadInteger('Defense', 'MainDoorHP', 2000);
    if m_MainDoor.nHP <= 0 then m_MainDoor.nHP := 2000;
    if not IsReLoad then m_MainDoor.BaseObject := nil
    else begin//重载则把怪物清除
      if m_MapCastle <> nil then m_MapCastle.SetMapXYFlag(m_MainDoor.nX, m_MainDoor.nY, True);//不重新设置地图XY场景的标志将不能创建怪到指定位置 20090506
      if m_MainDoor.BaseObject <> nil then begin
        m_MainDoor.BaseObject.m_boGhost := True;
        m_MainDoor.BaseObject.m_dwGhostTick:= 0;
        m_MainDoor.BaseObject.DisappearA();
        m_MainDoor.BaseObject := nil;
      end;
    end;

    m_LeftWall.nX := CastleConf.ReadInteger('Defense', 'LeftWallX', 624);
    m_LeftWall.nY := CastleConf.ReadInteger('Defense', 'LeftWallY', 278);
    m_LeftWall.sName := CastleConf.ReadString('Defense', 'LeftWallName', '左城墙');
    m_LeftWall.nHP := CastleConf.ReadInteger('Defense', 'LeftWallHP', 2000);
    if m_LeftWall.nHP <= 0 then m_LeftWall.nHP := 2000;
    if not IsReLoad then m_LeftWall.BaseObject := nil
    else begin
      if m_MapCastle <> nil then m_MapCastle.SetMapXYFlag(m_LeftWall.nX, m_LeftWall.nY, True);//不重新设置地图XY场景的标志将不能创建怪到指定位置 20090506
      if m_LeftWall.BaseObject <> nil then begin
        m_LeftWall.BaseObject.m_boGhost := True;
        m_LeftWall.BaseObject.m_dwGhostTick:= 0;
        m_LeftWall.BaseObject.DisappearA();
        m_LeftWall.BaseObject := nil;
      end;
    end;

    m_CenterWall.nX := CastleConf.ReadInteger('Defense', 'CenterWallX', 627);
    m_CenterWall.nY := CastleConf.ReadInteger('Defense', 'CenterWallY', 278);
    m_CenterWall.sName := CastleConf.ReadString('Defense', 'CenterWallName', '中城墙');
    m_CenterWall.nHP := CastleConf.ReadInteger('Defense', 'CenterWallHP', 2000);
    if m_CenterWall.nHP <= 0 then m_CenterWall.nHP := 2000;
    if not IsReLoad then m_CenterWall.BaseObject := nil
    else begin
      if m_MapCastle <> nil then m_MapCastle.SetMapXYFlag(m_CenterWall.nX, m_CenterWall.nY, True);//不重新设置地图XY场景的标志将不能创建怪到指定位置 20090506
      if m_CenterWall.BaseObject <> nil then begin
        m_CenterWall.BaseObject.m_boGhost := True;
        m_CenterWall.BaseObject.m_dwGhostTick:= 0;
        m_CenterWall.BaseObject.DisappearA();
        m_CenterWall.BaseObject := nil
      end;
    end;

    m_RightWall.nX := CastleConf.ReadInteger('Defense', 'RightWallX', 634);
    m_RightWall.nY := CastleConf.ReadInteger('Defense', 'RightWallY', 271);
    m_RightWall.sName := CastleConf.ReadString('Defense', 'RightWallName', '右城墙');
    m_RightWall.nHP := CastleConf.ReadInteger('Defense', 'RightWallHP', 2000);
    if m_RightWall.nHP <= 0 then m_RightWall.nHP := 2000;
    if not IsReLoad then m_RightWall.BaseObject := nil
    else begin
      if m_MapCastle <> nil then m_MapCastle.SetMapXYFlag(m_RightWall.nX, m_RightWall.nY, True);//不重新设置地图XY场景的标志将不能创建怪到指定位置 20090506
      if m_RightWall.BaseObject <> nil then begin
        m_RightWall.BaseObject.m_boGhost := True;
        m_RightWall.BaseObject.m_dwGhostTick:= 0;
        m_RightWall.BaseObject.DisappearA();
        m_RightWall.BaseObject := nil
      end;
    end;

    for I := Low(m_Archer) to High(m_Archer) do begin
      ObjUnit := @m_Archer[I];
      ObjUnit.nX := CastleConf.ReadInteger('Defense', 'Archer_' + IntToStr(I + 1) + '_X', {0}ObjUnit.nX);//20090628 修改
      ObjUnit.nY := CastleConf.ReadInteger('Defense', 'Archer_' + IntToStr(I + 1) + '_Y', {0}ObjUnit.nY);//20090628 修改
      ObjUnit.sName := CastleConf.ReadString('Defense', 'Archer_' + IntToStr(I + 1) + '_Name', '弓箭手');
      ObjUnit.nHP := CastleConf.ReadInteger('Defense', 'Archer_' + IntToStr(I + 1) + '_HP', 2000);
      if not IsReLoad then ObjUnit.BaseObject := nil;
    end;

    for I := Low(m_Guard) to High(m_Guard) do begin
      ObjUnit := @m_Guard[I];
      ObjUnit.nX := CastleConf.ReadInteger('Defense', 'Guard_' + IntToStr(I + 1) + '_X', {0}ObjUnit.nX);//20090628 修改
      ObjUnit.nY := CastleConf.ReadInteger('Defense', 'Guard_' + IntToStr(I + 1) + '_Y', {0}ObjUnit.nY);//20090628 修改
      ObjUnit.sName := CastleConf.ReadString('Defense', 'Guard_' + IntToStr(I + 1) + '_Name', '守卫');
      ObjUnit.nHP := CastleConf.ReadInteger('Defense', 'Guard_' + IntToStr(I + 1) + '_HP', 2000);
      if not IsReLoad then ObjUnit.BaseObject := nil;
    end;
    CastleConf.Free;
  end;
  m_MasterGuild := g_GuildManager.FindGuild(m_sOwnGuild);
end;

procedure TUserCastle.SaveConfigFile();//保存沙巴克配置文件
var
  CastleConf: TIniFile;
  ObjUnit: pTObjUnit;
  sFileName, sConfigFile: string;
  sMapList: string;
  I: Integer;
  nCode:Byte;
begin
  nCode:= 0;
  try
    if not DirectoryExists(g_Config.sCastleDir + m_sConfigDir) then begin
      CreateDir(g_Config.sCastleDir + m_sConfigDir);
    end;
    nCode:= 1;
    if g_MapManager.GetMapOfServerIndex(m_sMapName) <> nServerIndex then Exit;
    sConfigFile := 'SabukW.txt';
    sFileName := g_Config.sCastleDir + m_sConfigDir + '\' + sConfigFile;
    CastleConf := TIniFile.Create(sFileName);
    nCode:= 2;
    if CastleConf <> nil then begin
      try
        if m_sName <> '' then CastleConf.WriteString('Setup', 'CastleName', m_sName);
        nCode:= 21;
        if m_sOwnGuild <> '' then CastleConf.WriteString('Setup', 'OwnGuild', m_sOwnGuild);
        nCode:= 3;
        CastleConf.WriteDateTime('Setup', 'ChangeDate', m_ChangeDate);
        CastleConf.WriteDateTime('Setup', 'WarDate', m_WarDate);
        CastleConf.WriteDateTime('Setup', 'IncomeToday', m_IncomeToday);
        if m_nTotalGold >= 0 then CastleConf.WriteInteger('Setup', 'TotalGold', m_nTotalGold);//修改等于0时也要保存 20090403
        if m_nTodayIncome >= 0 then CastleConf.WriteInteger('Setup', 'TodayIncome', m_nTodayIncome);//修改等于0时也要保存 20090403

        if m_EnvirList.Count > 0 then begin//20080630
          nCode:= 4;
          for I := 0 to m_EnvirList.Count - 1 do begin
            sMapList := sMapList + m_EnvirList.Strings[I] + ',';
          end;
        end;
        if sMapList <> '' then CastleConf.WriteString('Defense', 'CastleMapList', sMapList);

        if m_sMapName <> '' then CastleConf.WriteString('Defense', 'CastleMap', m_sMapName);
        if m_sHomeMap <> '' then CastleConf.WriteString('Defense', 'CastleHomeMap', m_sHomeMap);
        if m_nHomeX <> 0 then CastleConf.WriteInteger('Defense', 'CastleHomeX', m_nHomeX);
        if m_nHomeY <> 0 then CastleConf.WriteInteger('Defense', 'CastleHomeY', m_nHomeY);
        if m_sWarAreaHomeMap <> '' then CastleConf.WriteString('Defense', 'CastleWarAreaHomeMap', m_sWarAreaHomeMap); //攻方行会回城点地图 20090527
        if m_nWarAreaHomeX <> 0 then CastleConf.WriteInteger('Defense', 'CastleWarAreaHomeX', m_nWarAreaHomeX);//攻方行会回城点X 20090527
        if m_nWarAreaHomeY <> 0 then CastleConf.WriteInteger('Defense', 'CastleWarAreaHomeY', m_nWarAreaHomeY);//攻方行会回城点Y 20090527

        if m_nWarRangeX <> 0 then CastleConf.WriteInteger('Defense', 'CastleWarRangeX', m_nWarRangeX);
        if m_nWarRangeY <> 0 then CastleConf.WriteInteger('Defense', 'CastleWarRangeY', m_nWarRangeY);

        if m_sPalaceMap <> '' then CastleConf.WriteString('Defense', 'CastlePlaceMap', m_sPalaceMap);
        if m_sSecretMap <> '' then CastleConf.WriteString('Defense', 'CastleSecretMap', m_sSecretMap);
        if m_nPalaceDoorX <> 0 then CastleConf.WriteInteger('Defense', 'CastlePalaceDoorX', m_nPalaceDoorX);
        if m_nPalaceDoorY <> 0 then CastleConf.WriteInteger('Defense', 'CastlePalaceDoorY', m_nPalaceDoorY);

        if m_MainDoor.nX <> 0 then CastleConf.WriteInteger('Defense', 'MainDoorX', m_MainDoor.nX);
        if m_MainDoor.nY <> 0 then CastleConf.WriteInteger('Defense', 'MainDoorY', m_MainDoor.nY);
        if m_MainDoor.sName <> '' then CastleConf.WriteString('Defense', 'MainDoorName', m_MainDoor.sName);
        nCode:= 5;
        if m_MainDoor.BaseObject <> nil then begin
          nCode:= 6;
          CastleConf.WriteBool('Defense', 'MainDoorOpen', m_MainDoor.nStatus);
          CastleConf.WriteInteger('Defense', 'MainDoorHP', m_MainDoor.BaseObject.m_WAbil.HP);
        end;
        nCode:= 22;
        if m_LeftWall.nX <> 0 then CastleConf.WriteInteger('Defense', 'LeftWallX', m_LeftWall.nX);
        if m_LeftWall.nY <> 0 then CastleConf.WriteInteger('Defense', 'LeftWallY', m_LeftWall.nY);
        if m_LeftWall.sName <> '' then CastleConf.WriteString('Defense', 'LeftWallName', m_LeftWall.sName);
        nCode:= 7;
        if m_LeftWall.BaseObject <> nil then begin
          CastleConf.WriteInteger('Defense', 'LeftWallHP', m_LeftWall.BaseObject.m_WAbil.HP);
        end;
        nCode:= 8;
        if m_CenterWall.nX <> 0 then CastleConf.WriteInteger('Defense', 'CenterWallX', m_CenterWall.nX);
        if m_CenterWall.nY <> 0 then CastleConf.WriteInteger('Defense', 'CenterWallY', m_CenterWall.nY);
        if m_CenterWall.sName <> '' then CastleConf.WriteString('Defense', 'CenterWallName', m_CenterWall.sName);
        nCode:= 9;
        if m_CenterWall.BaseObject <> nil then begin
          CastleConf.WriteInteger('Defense', 'CenterWallHP', m_CenterWall.BaseObject.m_WAbil.HP);
        end;
        nCode:= 10;
        if m_RightWall.nX <> 0 then CastleConf.WriteInteger('Defense', 'RightWallX', m_RightWall.nX);
        if m_RightWall.nY <> 0 then CastleConf.WriteInteger('Defense', 'RightWallY', m_RightWall.nY);
        if m_RightWall.sName <> '' then CastleConf.WriteString('Defense', 'RightWallName', m_RightWall.sName);
        nCode:= 11;
        if m_RightWall.BaseObject <> nil then begin
          CastleConf.WriteInteger('Defense', 'RightWallHP', m_RightWall.BaseObject.m_WAbil.HP);
        end;
        nCode:= 12;
        for I := Low(m_Archer) to High(m_Archer) do begin
          ObjUnit := @m_Archer[I];
          nCode:= 13;
          if ObjUnit.nX <> 0 then CastleConf.WriteInteger('Defense', 'Archer_' + IntToStr(I + 1) + '_X', ObjUnit.nX);
          if ObjUnit.nY <> 0 then CastleConf.WriteInteger('Defense', 'Archer_' + IntToStr(I + 1) + '_Y', ObjUnit.nY);
          if ObjUnit.sName <> '' then CastleConf.WriteString('Defense', 'Archer_' + IntToStr(I + 1) + '_Name', ObjUnit.sName);
          nCode:= 14;
          if ObjUnit.BaseObject <> nil then begin
            CastleConf.WriteInteger('Defense', 'Archer_' + IntToStr(I + 1) + '_HP', ObjUnit.BaseObject.m_WAbil.HP);
          end else begin
            CastleConf.WriteInteger('Defense', 'Archer_' + IntToStr(I + 1) + '_HP', 0);
          end;
        end;
        nCode:= 15;
        for I := Low(m_Guard) to High(m_Guard) do begin
          ObjUnit := @m_Guard[I];
          nCode:= 16;
          if ObjUnit.nX <> 0 then CastleConf.WriteInteger('Defense', 'Guard_' + IntToStr(I + 1) + '_X', ObjUnit.nX);
          if ObjUnit.nY <> 0 then CastleConf.WriteInteger('Defense', 'Guard_' + IntToStr(I + 1) + '_Y', ObjUnit.nY);
          if ObjUnit.sName <> '' then CastleConf.WriteString('Defense', 'Guard_' + IntToStr(I + 1) + '_Name', ObjUnit.sName);
          nCode:= 17;
          if ObjUnit.BaseObject <> nil then begin
            CastleConf.WriteInteger('Defense', 'Guard_' + IntToStr(I + 1) + '_HP', ObjUnit.BaseObject.m_WAbil.HP);
          end else begin
            CastleConf.WriteInteger('Defense', 'Guard_' + IntToStr(I + 1) + '_HP', 0);
          end;
        end;
        nCode:= 24;
      finally
        CastleConf.Free;
      end;
    end;
  except
    MainOutMessage(format('{%s} TUserCastle.SaveConfigFile Code:%d',[g_sExceptionVer, nCode]));
  end;
end;
//读取攻击列表
procedure TUserCastle.LoadAttackSabukWall();
var
  I: Integer;
  sFileName, sConfigFile, s20, sGuildName, sData: string;
  LoadList: TStringList;
  Guild: TGUild;
  AttackerInfo: pTAttackerInfo;
//  fs:TFormatSettings;//转换日期格式，WIN7下不转换会异常
begin
//  fs.ShortDateFormat:='yyyy-mm-dd';
//  fs.DateSeparator:='-';
  //  sFileName:=g_Config.sCastleDir + 'AttackSabukWall.txt';
  if not DirectoryExists(g_Config.sCastleDir + m_sConfigDir) then begin
    CreateDir(g_Config.sCastleDir + m_sConfigDir);
  end;
  sConfigFile := 'AttackSabukWall.txt';
  sFileName := g_Config.sCastleDir + m_sConfigDir + '\' + sConfigFile;
  if FileExists(sFileName) then begin
    LoadList := TStringList.Create;
    try
      LoadList.LoadFromFile(sFileName);
      if m_AttackWarList.Count > 0 then begin//20080630
        for I := 0 to m_AttackWarList.Count - 1 do begin
          if pTAttackerInfo(m_AttackWarList.Items[I]) <> nil then
             Dispose(pTAttackerInfo(m_AttackWarList.Items[I]));
        end;
      end;
      m_AttackWarList.Clear;
      if LoadList.Count > 0 then begin//20080630
        for I := 0 to LoadList.Count - 1 do begin
          sData := LoadList.Strings[I];
          s20 := GetValidStr3(sData, sGuildName, [' ', #9]);
          Guild := g_GuildManager.FindGuild(sGuildName);
          if Guild <> nil then begin
            New(AttackerInfo);
            ArrestStringEx(s20, '"', '"', s20);
            try
              AttackerInfo.AttackDate := StrToDate(s20{, Fs});//20110722 修改
            except
              AttackerInfo.AttackDate := Now();
            end;
            AttackerInfo.sGuildName := sGuildName;
            AttackerInfo.Guild := Guild;
            m_AttackWarList.Add(AttackerInfo);
          end;
        end;//for
      end;
    except
      MainOutMessage('读取攻城文件失败:'+ sFileName);
    end;
    LoadList.Free;
  end;
end;
//保存攻城列表
procedure TUserCastle.SaveAttackSabukWall();
var
  I: Integer;
  sFileName, sConfigFile: string;
  LoadLis: TStringList;
  AttackerInfo: pTAttackerInfo;
begin
  if not DirectoryExists(g_Config.sCastleDir + m_sConfigDir) then begin
    CreateDir(g_Config.sCastleDir + m_sConfigDir);
  end;
  sConfigFile := 'AttackSabukWall.txt';
  sFileName := g_Config.sCastleDir + m_sConfigDir + '\' + sConfigFile;
  LoadLis := TStringList.Create;
  try
    if m_AttackWarList.Count > 0 then begin//20080630
      for I := 0 to m_AttackWarList.Count - 1 do begin
        AttackerInfo := m_AttackWarList.Items[I];
        LoadLis.Add(AttackerInfo.sGuildName + '       "' + DateToStr(AttackerInfo.AttackDate) + '"');
      end;
    end;
    try
      LoadLis.SaveToFile(sFileName);
    except
      MainOutMessage('保存攻城信息失败: ' + sFileName);
    end;
  finally
    LoadLis.Free;
  end;
end;
procedure TUserCastle.Run; 
{$IF SoftVersion <> VERDEMO}
var
  I: Integer;
  Year, Month, Day, Hour, Min, Sec, MSec: Word;
  wYear, wMonth, wDay: Word;
  AttackerInfo: pTAttackerInfo;
  s20: string;
{$IFEND}
resourcestring
  sWarStartMsg = '[%s 攻城战已经开始]';
  sWarStopTimeMsg = '[%s 攻城战离结束还有%d分钟]';
  sExceptionMsg = '{%s} TUserCastle::Run';
begin
  try
    if nServerIndex <> g_MapManager.GetMapOfServerIndex(m_sMapName) then Exit;
{$IF SoftVersion <> VERDEMO}
    DecodeDate(Now, Year, Month, Day);
    DecodeDate(m_IncomeToday, wYear, wMonth, wDay);
    if (Year <> wYear) or (Month <> wMonth) or (Day <> wDay) then begin
      m_nTodayIncome := 0;
      m_IncomeToday := Now();
      m_boStartWar := False;
    end;
    if not m_boStartWar and (not m_boUnderWar) then begin
      DecodeTime(Time, Hour, Min, Sec, MSec);
      if Hour = g_Config.nStartCastlewarTime {20} then begin
        m_boStartWar := True; ;
        m_AttackGuildList.Clear;
        for I := m_AttackWarList.Count - 1 downto 0 do begin
          if m_AttackWarList.Count <= 0 then Break;
          AttackerInfo := m_AttackWarList.Items[I];
          if AttackerInfo <> nil then begin//20090304 增加
            DecodeDate(AttackerInfo.AttackDate, wYear, wMonth, wDay);
            if (Year = wYear) and (Month = wMonth) and (Day = wDay) then begin
              m_boUnderWar := True;
              m_boShowOverMsg := False;
              m_WarDate := Now();
              m_dwStartCastleWarTick := GetTickCount();
              m_AttackGuildList.Add(AttackerInfo.Guild);
              Dispose(AttackerInfo);
              m_AttackWarList.Delete(I);
            end;
          end;
        end;
        if m_boUnderWar then begin//开始攻城
          m_AttackGuildList.Add(m_MasterGuild);
          m_OldGuild:= m_MasterGuild;//以前占领的行会 20090304
          StartWallconquestWar();
          SaveAttackSabukWall();
          //UserEngine.SendServerGroupMsg(SS_212, nServerIndex, ''); //20101022 注释
          s20 := Format(sWarStartMsg, [m_sName]);
          UserEngine.SendBroadCastMsgExt(s20, t_System);
          //UserEngine.SendServerGroupMsg(SS_204, nServerIndex, s20);//20101022 注释
          MainOutMessage(s20);
          MainDoorControl(True);
        end;
      end;
    end;
    for I := Low(m_Guard) to High(m_Guard) do begin
      if (m_Guard[I].BaseObject <> nil) then begin
        if m_Guard[I].BaseObject.m_boGhost then m_Guard[I].BaseObject := nil;
      end;
    end;
    for I := Low(m_Archer) to High(m_Archer) do begin
      if (m_Archer[I].BaseObject <> nil) then begin
        if (m_Archer[I].BaseObject.m_boGhost) then m_Archer[I].BaseObject := nil;
      end;
    end;
    if m_boUnderWar then begin//正在攻城
      if m_LeftWall.BaseObject <> nil then m_LeftWall.BaseObject.m_boStoneMode := False;
      if m_CenterWall.BaseObject <> nil then m_CenterWall.BaseObject.m_boStoneMode := False;
      if m_RightWall.BaseObject <> nil then m_RightWall.BaseObject.m_boStoneMode := False;
      if not m_boShowOverMsg then begin
        if (GetTickCount - m_dwStartCastleWarTick) > (g_Config.dwCastleWarTime - g_Config.dwShowCastleWarEndMsgTime) {3 * 60 * 60 * 1000 - 10 * 60 * 1000} then begin
          m_boShowOverMsg := True;
          s20 := Format(sWarStopTimeMsg, [m_sName, g_Config.dwShowCastleWarEndMsgTime div 60000{(60 * 1000)}]);
          UserEngine.SendBroadCastMsgExt(s20, t_System);
          //UserEngine.SendServerGroupMsg(SS_204, nServerIndex, s20);//20101022 注释
          MainOutMessage(s20);
        end;
      end;
      if (GetTickCount - m_dwStartCastleWarTick) > g_Config.dwCastleWarTime {3 * 60 * 60 * 1000} then begin
        StopWallconquestWar();//停止攻城
      end;
    end else begin//停止攻城
      {if m_LeftWall.BaseObject <> nil then m_LeftWall.BaseObject.m_boStoneMode := True;
      if m_CenterWall.BaseObject <> nil then m_CenterWall.BaseObject.m_boStoneMode := True;
      if m_RightWall.BaseObject <> nil then m_RightWall.BaseObject.m_boStoneMode := True;}
      if (m_MainDoor.BaseObject <> nil) then begin//20090304 如果怪的名与设置不对应，则重建
        if (CompareText(m_MainDoor.BaseObject.m_sCharName, m_MainDoor.sName) <> 0) then begin
          if m_MapCastle <> nil then m_MapCastle.SetMapXYFlag(m_MainDoor.nX, m_MainDoor.nY, True);
          if m_MainDoor.BaseObject <> nil then begin
            m_MainDoor.BaseObject.m_boGhost := True;
            m_MainDoor.BaseObject.m_dwGhostTick:= 0;
            m_MainDoor.BaseObject.DisappearA();
            m_MainDoor.BaseObject := nil;
          end;
          m_MainDoor.BaseObject := UserEngine.RegenMonsterByName(m_sMapName, m_MainDoor.nX, m_MainDoor.nY, m_MainDoor.sName);
          if m_MainDoor.BaseObject <> nil then begin
            m_MainDoor.BaseObject.m_WAbil.HP := m_MainDoor.nHP;
            m_MainDoor.BaseObject.m_Castle := self;
            MainDoorControl(False);
          end;
        end;
        if (m_MainDoor.BaseObject <> nil) then begin
          if m_MainDoor.BaseObject.m_boDeath then begin
            m_MainDoor.BaseObject.m_WAbil.HP := _MAX(50,Round(m_MainDoor.nHP * 0.05));
            m_MainDoor.BaseObject.ReAlive;
            m_MainDoor.BaseObject.m_Castle := self;
            MainDoorControl(False);
          end;
        end;
      end;

      if m_LeftWall.BaseObject <> nil then begin
        if (CompareText(m_LeftWall.BaseObject.m_sCharName, m_LeftWall.sName) <> 0) then begin
          if m_MapCastle <> nil then m_MapCastle.SetMapXYFlag(m_LeftWall.nX, m_LeftWall.nY, True);
          if m_LeftWall.BaseObject <> nil then begin
            m_LeftWall.BaseObject.m_boGhost := True;
            m_LeftWall.BaseObject.m_dwGhostTick:= 0;
            m_LeftWall.BaseObject.DisappearA();
            m_LeftWall.BaseObject := nil;
          end;
          m_LeftWall.BaseObject := UserEngine.RegenMonsterByName(m_sMapName, m_LeftWall.nX, m_LeftWall.nY, m_LeftWall.sName);
          if m_LeftWall.BaseObject <> nil then begin
            m_LeftWall.BaseObject.m_WAbil.HP := m_LeftWall.nHP;
            m_LeftWall.BaseObject.m_Castle := self;
          end;
        end;
        if m_LeftWall.BaseObject <> nil then begin
          if m_LeftWall.BaseObject.m_boDeath then begin
            m_LeftWall.BaseObject.m_WAbil.HP := _MAX(50,Round(m_LeftWall.nHP * 0.05));
            m_LeftWall.BaseObject.ReAlive;
            m_LeftWall.BaseObject.m_Castle := self;
          end;
          m_LeftWall.BaseObject.m_boStoneMode := True;
        end;
      end;

      if m_CenterWall.BaseObject <> nil then begin
        if (CompareText(m_CenterWall.BaseObject.m_sCharName, m_CenterWall.sName) <> 0) then begin
          if m_MapCastle <> nil then m_MapCastle.SetMapXYFlag(m_CenterWall.nX, m_CenterWall.nY, True);
          if m_CenterWall.BaseObject <> nil then begin
            m_CenterWall.BaseObject.m_boGhost := True;
            m_CenterWall.BaseObject.m_dwGhostTick:= 0;
            m_CenterWall.BaseObject.DisappearA();
            m_CenterWall.BaseObject := nil;
          end;
          m_CenterWall.BaseObject := UserEngine.RegenMonsterByName(m_sMapName, m_CenterWall.nX, m_CenterWall.nY, m_CenterWall.sName);
          if m_CenterWall.BaseObject <> nil then begin
            m_CenterWall.BaseObject.m_WAbil.HP := m_CenterWall.nHP;
            m_CenterWall.BaseObject.m_Castle := self;
          end;
        end;
        if m_CenterWall.BaseObject <> nil then begin
          if m_CenterWall.BaseObject.m_boDeath then begin
            m_CenterWall.BaseObject.m_WAbil.HP := _MAX(50,Round(m_CenterWall.nHP * 0.05));
            m_CenterWall.BaseObject.ReAlive;
            m_CenterWall.BaseObject.m_Castle := self;
          end;
          m_CenterWall.BaseObject.m_boStoneMode := True;
        end;
      end;

      if m_RightWall.BaseObject <> nil then begin
        if (CompareText(m_RightWall.BaseObject.m_sCharName, m_RightWall.sName) <> 0) then begin//20081201
          if m_MapCastle <> nil then m_MapCastle.SetMapXYFlag(m_RightWall.nX, m_RightWall.nY, True);
          if m_RightWall.BaseObject <> nil then begin
            m_RightWall.BaseObject.m_boGhost := True;
            m_RightWall.BaseObject.m_dwGhostTick:= 0;
            m_RightWall.BaseObject.DisappearA();
            m_RightWall.BaseObject := nil;
          end;
          m_RightWall.BaseObject := UserEngine.RegenMonsterByName(m_sMapName, m_RightWall.nX, m_RightWall.nY, m_RightWall.sName);
          if m_CenterWall.BaseObject <> nil then begin
            m_RightWall.BaseObject.m_WAbil.HP := m_RightWall.nHP;
            m_RightWall.BaseObject.m_Castle := self;
          end;
        end;
        if m_RightWall.BaseObject <> nil then begin
          if m_RightWall.BaseObject.m_boDeath then begin
            m_RightWall.BaseObject.m_WAbil.HP := _MAX(50,Round(m_RightWall.nHP * 0.05));
            m_RightWall.BaseObject.ReAlive;
            m_RightWall.BaseObject.m_Castle := self;
          end;
          m_RightWall.BaseObject.m_boStoneMode := True;
        end;
      end;

    end;
{$IFEND}
  except
    MainOutMessage(format(sExceptionMsg,[g_sExceptionVer]));
  end;
end;

procedure TUserCastle.Save;
begin
  SaveConfigFile();
  SaveAttackSabukWall();
end;
//是否在攻城区域
function TUserCastle.InCastleWarArea(Envir: TEnvirnoment; nX, nY: Integer): Boolean; //004910F4
var
  I: Integer;
begin
  Result := False;
  if (Envir = m_MapCastle) and
    (abs(m_nHomeX - nX) < m_nWarRangeX {100}) and
    (abs(m_nHomeY - nY) < m_nWarRangeY {100}) then begin
    Result := True;
    Exit;
  end;
  if (Envir = m_MapPalace) or (Envir = m_MapSecret) then begin
    Result := True;
    Exit;
  end;
  //增加取得城堡所有地图列表
  if m_EnvirList.Count > 0 then begin//20080630
    for I := 0 to m_EnvirList.Count - 1 do begin
      if m_EnvirList.Objects[I] = Envir then begin
        Result := True;
        Break;
      end;
    end;
  end;
end;
//城的会员
function TUserCastle.IsMember(Cert: TBaseObject): Boolean; //00490438
begin
  Result := IsMasterGuild(TGUild(Cert.m_MyGuild));
end;

//检查是否为攻城方行会的联盟行会
function TUserCastle.IsAttackAllyGuild(Guild: TGUild): Boolean;
var
  I: Integer;
  AttackGuild: TGUild;
begin
  Result := False;
  if m_AttackGuildList.Count > 0 then begin//20080630
    for I := 0 to m_AttackGuildList.Count - 1 do begin
      AttackGuild := TGUild(m_AttackGuildList.Items[I]);
      if (AttackGuild <> m_MasterGuild) and AttackGuild.IsAllyGuild(Guild) then begin
        Result := True;
        Break;
      end;
    end;
  end;
end;
//检查是否为攻城方行会
function TUserCastle.IsAttackGuild(Guild: TGUild): Boolean; //00491160
var
  I: Integer;
  AttackGuild: TGUild;
begin
  Result := False;
  if m_AttackGuildList.Count > 0 then begin//20080630
    for I := 0 to m_AttackGuildList.Count - 1 do begin
      AttackGuild := TGUild(m_AttackGuildList.Items[I]);
      if (AttackGuild <> m_MasterGuild) and (AttackGuild = Guild) then begin
        Result := True;
        Break;
      end;
    end;
  end;
end;

function TUserCastle.CanGetCastle(Guild: TGUild): Boolean; //004911D0
var
  I: Integer;
  List14: TList;
  PlayObject: TPlayObject;
begin
  Result := False;
  if (GetTickCount - m_dwStartCastleWarTick) > g_Config.dwGetCastleTime {10 * 60 * 1000} then begin
    List14 := TList.Create;
    Try
      UserEngine.GetMapRageHuman(m_MapPalace, 0, 0, 1000, List14);
      Result := True;
      if List14.Count > 0 then begin//20080630
        for I := 0 to List14.Count - 1 do begin
          PlayObject := TPlayObject(List14.Items[I]);
          if not PlayObject.m_boDeath and (PlayObject.m_MyGuild <> Guild) then begin
            Result := False;
            Break;
          end;
        end;
      end;
    Finally
      List14.Free;
    End;
  end;
end;
//沙城被占领
procedure TUserCastle.GetCastle(Guild: TGUild);
var
  OldGuild: TGUild;
  s10: string;
  nCode: Byte;
resourcestring
  sGetCastleMsg = '[%s 已被 %s 占领]';
begin
  nCode:= 0;
  try  
    OldGuild := m_MasterGuild;
    nCode:= 1;
    m_MasterGuild := Guild;
    nCode:= 2;
    m_sOwnGuild := Guild.sGuildName;
    nCode:= 3;
    //m_ChangeDate := Now();//20090304
    SaveConfigFile();
    nCode:= 5;
    if OldGuild <> nil then OldGuild.RefMemberName;
    nCode:= 6;
    if m_MasterGuild <> nil then m_MasterGuild.RefMemberName;
    nCode:= 7;
    s10 := Format(sGetCastleMsg, [m_sName, m_sOwnGuild]);
    nCode:= 8;
    UserEngine.SendBroadCastMsgExt(s10, t_System);
    //nCode:= 9;
    //UserEngine.SendServerGroupMsg(SS_204, nServerIndex, s10);//20101022 注释
    nCode:= 10;
    MainOutMessage(s10);
  except
    MainOutMessage(format('{%s} TUserCastle.GetCastle Code:%d',[g_sExceptionVer, nCode]));
  end;
end;

procedure TUserCastle.StartWallconquestWar; //00491074
var
  ListC: TList;
  I: Integer;
  PlayObject: TPlayObject;
begin
  ListC := TList.Create;
  try
    UserEngine.GetMapRageHuman(m_MapPalace, m_nHomeX, m_nHomeY, 100, ListC);
    if ListC.Count > 0 then begin//20080630
      for I := 0 to ListC.Count - 1 do begin
        PlayObject := TPlayObject(ListC.Items[I]);
        PlayObject.RefShowName();
      end;
    end;
  finally
    ListC.Free;
  end;
end;
//攻城战结束
procedure TUserCastle.StopWallconquestWar;
var s14: string;
resourcestring
  sWallWarStop = '[%s 攻城战已经结束]';
begin
  m_boUnderWar := False;
  if m_OldGuild <> m_MasterGuild then begin//20090304 城堡被其它行会占领时，初始占领日期
    m_ChangeDate := Now();//20090304
    SaveConfigFile();//20090305
  end;
  m_AttackGuildList.Clear;
  s14 := Format(sWallWarStop, [m_sName]);
  UserEngine.SendBroadCastMsgExt(s14, t_System);
  //UserEngine.SendServerGroupMsg(SS_204, nServerIndex, s14);//20101022 注释
  MainOutMessage(s14);
  m_OldGuild:= nil;//20090304
end;
//取攻击行会数量
function TUserCastle.InPalaceGuildCount: Integer;
begin
  Result := m_AttackGuildList.Count;
end;

function TUserCastle.IsDefenseAllyGuild(Guild: TGUild): Boolean;
begin
  Result := False;
  if not m_boUnderWar then Exit; //如果未开始攻城，则无效
  if m_MasterGuild <> nil then Result := m_MasterGuild.IsAllyGuild(Guild);
end;

//检查是否为守城方行会
function TUserCastle.IsDefenseGuild(Guild: TGUild): Boolean;
begin
  Result := False;
  if not m_boUnderWar then Exit; //如果未开始攻城，则无效
  if Guild = m_MasterGuild then Result := True;
end;
//检查是否为沙城所属行会
function TUserCastle.IsMasterGuild(Guild: TGUild): Boolean; 
begin
  Result := False;
  if (m_MasterGuild <> nil) then begin
    if (m_MasterGuild = Guild) then Result := True;
  end;
end;

function TUserCastle.GetHomeX: Integer; //004902B0
begin
  Result := (m_nHomeX - 4) + Random(9);
end;

function TUserCastle.GetHomeY: Integer; //004902D8
begin
  Result := (m_nHomeY - 4) + Random(9);
end;

function TUserCastle.GetMapName: string; //00490290
begin
  Result := m_sMapName;
end;

function TUserCastle.GetWarAreaHomeX: Integer;
begin
  Result := (m_nWarAreaHomeX - 4) + Random(9);
end;

function TUserCastle.GetWarAreaHomeY: Integer;
begin
  Result := (m_nWarAreaHomeY - 4) + Random(9);
end;

function TUserCastle.GetWarAreaHomeName: string;
begin
  Result := m_sWarAreaHomeMap;
end;

function TUserCastle.CheckInPalace(nX, nY: Integer; Cert: TBaseObject): Boolean;
var
  ObjUnit: pTObjUnit;
begin
  Result := IsMasterGuild(TGUild(Cert.m_MyGuild));
  if Result then Exit;
  ObjUnit := @m_LeftWall;
  if (ObjUnit.BaseObject <> nil) and
    (ObjUnit.BaseObject.m_boDeath) and
    (ObjUnit.BaseObject.m_nCurrX = nX) and
    (ObjUnit.BaseObject.m_nCurrY = nY) then begin
    Result := True;
  end;
  ObjUnit := @m_CenterWall;
  if (ObjUnit.BaseObject <> nil) and
    (ObjUnit.BaseObject.m_boDeath) and
    (ObjUnit.BaseObject.m_nCurrX = nX) and
    (ObjUnit.BaseObject.m_nCurrY = nY) then begin
    Result := True;
  end;
  ObjUnit := @m_RightWall;
  if (ObjUnit.BaseObject <> nil) and
    (ObjUnit.BaseObject.m_boDeath) and
    (ObjUnit.BaseObject.m_nCurrX = nX) and
    (ObjUnit.BaseObject.m_nCurrY = nY) then begin
    Result := True;
  end;
end;
//取攻城日期
function TUserCastle.GetWarDate: string;
var
  AttackerInfo: pTAttackerInfo;
  Year: Word;
  Month: Word;
  Day: Word;
resourcestring
  sMsg = '%d年%d月%d日';
begin
  Result := '';
  if m_AttackWarList.Count <= 0 then Exit;
  AttackerInfo := m_AttackWarList.Items[0];
  DecodeDate(AttackerInfo.AttackDate, Year, Month, Day);
  Result := Format(sMsg, [Year, Month, Day]);
end;

function TUserCastle.GetAttackWarList: string;
var
  I, n10: Integer;
  AttackerInfo: pTAttackerInfo;
  Year, Month, Day: Word;
  wYear, wMonth, wDay: Word;
  s20: string;
begin
  Result := '';
  wYear := 0;
  wMonth := 0;
  wDay := 0;
  n10 := 0;
  if m_AttackWarList.Count > 0 then begin//20080630
    for I := 0 to m_AttackWarList.Count - 1 do begin
      AttackerInfo := m_AttackWarList.Items[I];
      DecodeDate(AttackerInfo.AttackDate, Year, Month, Day);
      if (Year <> wYear) or (Month <> wMonth) or (Day <> wDay) then begin
        wYear := Year;
        wMonth := Month;
        wDay := Day;
        if Result <> '' then
          Result := Result + '\';
        Result := Result + IntToStr(wYear) + '年' + IntToStr(wMonth) + '月' + IntToStr(wDay) + '日\';
        n10 := 0;
      end;
      if n10 > 40 then begin
        Result := Result + '\';
        n10 := 0;
      end;
      s20 := '"' + AttackerInfo.sGuildName + '"';
      Inc(n10, Length(s20));
      Result := Result + s20;
    end; // for
  end;
end;

procedure TUserCastle.IncRateGold(nGold: Integer); //004904C4
var
  nInGold: Integer;
begin
  nInGold := Round(nGold * (g_Config.nCastleTaxRate / 100) {0.05});
  if (m_nTodayIncome + nInGold) <= g_Config.nCastleOneDayGold then begin
    Inc(m_nTodayIncome, nInGold);
  end else begin
    if m_nTodayIncome >= g_Config.nCastleOneDayGold then begin
      nInGold := 0;
    end else begin
      nInGold := g_Config.nCastleOneDayGold - m_nTodayIncome;
      m_nTodayIncome := g_Config.nCastleOneDayGold;
    end;
  end;
  if nInGold > 0 then begin
    if (m_nTotalGold + nInGold) < g_Config.nCastleGoldMax then begin
      Inc(m_nTotalGold, nInGold);
    end else begin
      m_nTotalGold := g_Config.nCastleGoldMax;
    end;
  end;
  if (GetTickCount - m_dwSaveTick) > 600000{10 * 60 * 1000} then begin
    m_dwSaveTick := GetTickCount();
    if g_boGameLogGold then
      AddGameDataLog('23' + #9 +
        '0' + #9 +
        '0' + #9 +
        '0' + #9 +
        'autosave' + #9 +
        sSTRING_GOLDNAME + #9 +
        IntToStr(m_nTotalGold) + #9 +
        '1' + #9 +
        '0');
  end;
end;
//取回金币
function TUserCastle.WithDrawalGolds(PlayObject: TPlayObject; nGold: Integer): Integer; //0049066C
begin
  Result := -1;
  if nGold <= 0 then begin
    Result := -4;
    Exit;
  end;
  if (m_MasterGuild = PlayObject.m_MyGuild) and (PlayObject.m_nGuildRankNo = 1) and (nGold > 0) then begin
    if (nGold > 0) and (nGold <= m_nTotalGold) then begin
      if (PlayObject.m_nGold + nGold) <= PlayObject.m_nGoldMax then begin
        Dec(m_nTotalGold, nGold);
        PlayObject.IncGold(nGold);
        if g_boGameLogGold then
          AddGameDataLog('22' + #9 +
            PlayObject.m_sMapName + #9 +
            IntToStr(PlayObject.m_nCurrX) + #9 +
            IntToStr(PlayObject.m_nCurrY) + #9 +
            PlayObject.m_sCharName + #9 +
            sSTRING_GOLDNAME + #9 +
            IntToStr(nGold) + #9 +
            '1' + #9 +
            '0');
        PlayObject.GoldChanged;
        Result := 1;
      end else Result := -3;
    end else Result := -2;
  end;
end;
//沙巴克存资金
function TUserCastle.ReceiptGolds(PlayObject: TPlayObject; nGold: Integer): Integer; //00490864
begin
  Result := -1;
  if nGold <= 0 then begin
    Result := -4;
    Exit;
  end;
  if (m_MasterGuild = PlayObject.m_MyGuild) and (PlayObject.m_nGuildRankNo = 1) and (nGold > 0) then begin
    if (nGold <= PlayObject.m_nGold) then begin
      if (m_nTotalGold + nGold) <= g_Config.nCastleGoldMax then begin
        Dec(PlayObject.m_nGold, nGold);
        Inc(m_nTotalGold, nGold);
        if g_boGameLogGold then
          AddGameDataLog('23' + #9 +
            PlayObject.m_sMapName + #9 +
            IntToStr(PlayObject.m_nCurrX) + #9 +
            IntToStr(PlayObject.m_nCurrY) + #9 +
            PlayObject.m_sCharName + #9 +
            sSTRING_GOLDNAME + #9 +
            IntToStr(nGold) + #9 +
            '1' + #9 +
            '0');
        PlayObject.GoldChanged;
        Result := 1;
      end else Result := -3;
    end else Result := -2;
  end;
end;

procedure TUserCastle.MainDoorControl(boClose: Boolean); //00490460
begin
  if (m_MainDoor.BaseObject <> nil) and not m_MainDoor.BaseObject.m_boGhost then begin
    if boClose then begin
      if TCastleDoor(m_MainDoor.BaseObject).m_boOpened then TCastleDoor(m_MainDoor.BaseObject).Close;
    end else begin
      if not TCastleDoor(m_MainDoor.BaseObject).m_boOpened then TCastleDoor(m_MainDoor.BaseObject).Open;
    end;
  end;
end;
//修复城门
function TUserCastle.RepairDoor(): Boolean; //00490A70
var
  CastleDoor: pTObjUnit;
begin
  Result := False;
  CastleDoor := @m_MainDoor;
  if (CastleDoor.BaseObject = nil) or (m_boUnderWar) or
    (CastleDoor.BaseObject.m_WAbil.HP >= CastleDoor.BaseObject.m_WAbil.MaxHP) then begin
    Exit;
  end;
  if not CastleDoor.BaseObject.m_boDeath then begin
    if (GetTickCount - CastleDoor.BaseObject.m_dwStruckTick) > 60000{60 * 1000} then begin
      CastleDoor.BaseObject.m_WAbil.HP := CastleDoor.BaseObject.m_WAbil.MaxHP;
      TCastleDoor(CastleDoor.BaseObject).RefStatus();
      Result := True;
    end;
  end else begin
    if (GetTickCount - CastleDoor.BaseObject.m_dwStruckTick) > 60000{60 * 1000} then begin
      CastleDoor.BaseObject.m_WAbil.HP := CastleDoor.BaseObject.m_WAbil.MaxHP;
      CastleDoor.BaseObject.m_boDeath := False;
      TCastleDoor(CastleDoor.BaseObject).m_boOpened := False;
      TCastleDoor(CastleDoor.BaseObject).RefStatus();
      Result := True;
    end;
  end;
end;
//修复城墙
function TUserCastle.RepairWall(nWallIndex: Integer): Boolean; //00490B78
var
  Wall: TBaseObject;
begin
  Result := False;
  Wall := nil;
  case nWallIndex of
    1: Wall := m_LeftWall.BaseObject;//左
    2: Wall := m_CenterWall.BaseObject;//中
    3: Wall := m_RightWall.BaseObject;//右
  end;
  if (Wall = nil) or (m_boUnderWar) or (Wall.m_WAbil.HP >= Wall.m_WAbil.MaxHP) then begin
    Exit;
  end;
  if not Wall.m_boDeath then begin
    if (GetTickCount - Wall.m_dwStruckTick) > 60000{60 * 1000} then begin
      Wall.m_WAbil.HP := Wall.m_WAbil.MaxHP;
      TWallStructure(Wall).RefStatus();
      Result := True;
    end;
  end else begin
    if (GetTickCount - Wall.m_dwStruckTick) > 60000{60 * 1000} then begin
      Wall.m_WAbil.HP := Wall.m_WAbil.MaxHP;
      Wall.m_boDeath := False;
      TWallStructure(Wall).RefStatus();
      Result := True;
    end;
  end;
end;
//增加攻城行会信息
function TUserCastle.AddAttackerInfo(Guild: TGUild; nCode: Byte): Boolean; //00490CD8
var
  AttackerInfo: pTAttackerInfo;
begin
  Result := False;
  if InAttackerList(Guild) then Exit;
  New(AttackerInfo);
  if nCode = 0 then
    AttackerInfo.AttackDate := AddDateTimeOfDay(Now, g_Config.nStartCastleWarDays)
  else AttackerInfo.AttackDate := Now;//当前
  AttackerInfo.sGuildName := Guild.sGuildName;
  AttackerInfo.Guild := Guild;
  m_AttackWarList.Add(AttackerInfo);
  SaveAttackSabukWall();
  //UserEngine.SendServerGroupMsg(SS_212, nServerIndex, '');//20101022 注释
  Result := True;
end;
//在攻城列表中
function TUserCastle.InAttackerList(Guild: TGUild): Boolean; //00490C84
var
  I: Integer;
begin
  Result := False;
  if m_AttackWarList.Count > 0 then begin//20080630
    for I := 0 to m_AttackWarList.Count - 1 do begin
      if pTAttackerInfo(m_AttackWarList.Items[I]).Guild = Guild then begin
        Result := True;
        Break;
      end;
    end;
  end;
end;

procedure TUserCastle.SetPower(nPower: Integer);
begin
  m_nPower := nPower;
end;

procedure TUserCastle.SetTechLevel(nLevel: Integer);
begin
  m_nTechLevel := nLevel;
end;

{ TCastleManager }



constructor TCastleManager.Create;
begin
  m_CastleList := TList.Create;
  InitializeCriticalSection(CriticalSection);
end;


destructor TCastleManager.Destroy;
var
  I: Integer;
  UserCastle: TUserCastle;
begin
  if m_CastleList.Count > 0 then begin//20080630
    for I := 0 to m_CastleList.Count - 1 do begin
      UserCastle := TUserCastle(m_CastleList.Items[I]);
      UserCastle.Save;
      UserCastle.Free;
    end;
  end;
  m_CastleList.Free;
  DeleteCriticalSection(CriticalSection);
  inherited;
end;


function TCastleManager.Find(sCASTLENAME: string): TUserCastle;
var
  I: Integer;
  Castle: TUserCastle;
begin
  Result := nil;
  if m_CastleList.Count > 0 then begin//20080630
    for I := 0 to m_CastleList.Count - 1 do begin
      Castle := TUserCastle(m_CastleList.Items[I]);
      if CompareText(Castle.m_sName, sCASTLENAME) = 0 then begin
        Result := Castle;
        Break;
      end;
    end;
  end;
end;

//取得角色所在座标的城堡
function TCastleManager.InCastleWarArea(BaseObject: TBaseObject): TUserCastle;
var
  I: Integer;
  Castle: TUserCastle;
begin
  Result := nil;
  if m_CastleList.Count > 0 then begin//20080630
    for I := 0 to m_CastleList.Count - 1 do begin
      Castle := TUserCastle(m_CastleList.Items[I]);
      if Castle.InCastleWarArea(BaseObject.m_PEnvir, BaseObject.m_nCurrX, BaseObject.m_nCurrY) then begin
        Result := Castle;
        Break;
      end;
    end;
  end;
end;

function TCastleManager.InCastleWarArea(Envir: TEnvirnoment; nX,
  nY: Integer): TUserCastle;
var
  I: Integer;
  Castle: TUserCastle;
begin
  Result := nil;
  if m_CastleList.Count > 0 then begin//20080630
    for I := 0 to m_CastleList.Count - 1 do begin
      Castle := TUserCastle(m_CastleList.Items[I]);
      if Castle.InCastleWarArea(Envir, nX, nY) then begin
        Result := Castle;
        Break;
      end;
    end;
  end;
end;

procedure TCastleManager.Initialize;
var
  I: Integer;
  Castle: TUserCastle;
begin
  if m_CastleList.Count <= 0 then begin
    Castle := TUserCastle.Create(g_Config.sCastleDir);
    m_CastleList.Add(Castle);
    Castle.Initialize;
    Castle.m_sConfigDir := '0';
    Castle.m_EnvirList.Add('0151');
    Castle.m_EnvirList.Add('0152');
    Castle.m_EnvirList.Add('0153');
    Castle.m_EnvirList.Add('0154');
    Castle.m_EnvirList.Add('0155');
    Castle.m_EnvirList.Add('0156');
    if Castle.m_EnvirList.Count > 0 then begin//20080630
      for I := 0 to Castle.m_EnvirList.Count - 1 do begin
        Castle.m_EnvirList.Objects[I] := g_MapManager.FindMap(Castle.m_EnvirList.Strings[I]);
      end;
    end;
    Save();
    Exit;
  end;

  for I := 0 to m_CastleList.Count - 1 do begin
    Castle := TUserCastle(m_CastleList.Items[I]);
    Castle.Initialize;
  end;
end;

//重载相关设置 20081013
procedure TCastleManager.ReLoadCastle();
var
  I, K: Integer;
  Castle: TUserCastle;
  ObjUnit: pTObjUnit;
  Door: pTDoorInfo;
  boUnderWar: Boolean;//20081019
begin
  g_Config.sGuildNotice := StringConf.ReadString('Guild', 'GuildNotice', g_Config.sGuildNotice);
  g_Config.sGuildWar := StringConf.ReadString('Guild', 'GuildWar', g_Config.sGuildWar);
  g_Config.sGuildAll := StringConf.ReadString('Guild', 'GuildAll', g_Config.sGuildAll);
  g_Config.sGuildMember := StringConf.ReadString('Guild', 'GuildMember', g_Config.sGuildMember);
  g_Config.sGuildMemberRank := StringConf.ReadString('Guild', 'GuildMemberRank', g_Config.sGuildMemberRank);
  g_Config.sGuildChief := StringConf.ReadString('Guild', 'GuildChief', g_Config.sGuildChief);

  if m_CastleList.Count <= 0 then begin
    Castle := TUserCastle.Create(g_Config.sCastleDir);
    m_CastleList.Add(Castle);
    Castle.Initialize;
    Castle.m_sConfigDir := '0';
    Castle.m_EnvirList.Add('0151');
    Castle.m_EnvirList.Add('0152');
    Castle.m_EnvirList.Add('0153');
    Castle.m_EnvirList.Add('0154');
    Castle.m_EnvirList.Add('0155');
    Castle.m_EnvirList.Add('0156');
    if Castle.m_EnvirList.Count > 0 then begin//20080630
      for I := 0 to Castle.m_EnvirList.Count - 1 do begin
        Castle.m_EnvirList.Objects[I] := g_MapManager.FindMap(Castle.m_EnvirList.Strings[I]);
      end;
    end;
    Save();
    Exit;
  end;

  for I := 0 to m_CastleList.Count - 1 do begin
    Castle := TUserCastle(m_CastleList.Items[I]);
    with Castle do begin
      boUnderWar:= m_boUnderWar;//20081019
      m_boUnderWar:= False;//20081126 先初始状态
      LoadConfig(True);
      LoadAttackSabukWall();
      if g_MapManager.GetMapOfServerIndex(m_sMapName) = nServerIndex then begin
        m_MapPalace := g_MapManager.FindMap(Castle.m_sPalaceMap);
        if m_MapPalace = nil then begin
          MainOutMessage(Format('皇宫地图%s没找到！！！', [m_sPalaceMap]));
        end;
        m_MapSecret := g_MapManager.FindMap(m_sSecretMap);
        if Castle.m_MapSecret = nil then begin
          MainOutMessage(Format('密道地图%s没找到！！！', [m_sSecretMap]));
        end;
        m_MapCastle := g_MapManager.FindMap(m_sMapName);
        if m_MapCastle <> nil then begin
          if m_MainDoor.BaseObject = nil then begin
            m_MainDoor.BaseObject := UserEngine.RegenMonsterByName(m_sMapName, m_MainDoor.nX, m_MainDoor.nY, m_MainDoor.sName);
            if m_MainDoor.BaseObject <> nil then begin
              m_MainDoor.BaseObject.m_WAbil.HP := m_MainDoor.nHP;
              m_MainDoor.BaseObject.m_Castle := Castle;
              MainOutMessage('[城堡重载A] ' + m_MainDoor.BaseObject.m_sCharName +' '+ m_sMapName +'-'+ m_MainDoor.BaseObject.m_PEnvir.sMapName);
            end else begin
              MainOutMessage('[错误信息] 城堡初始化城门失败，检查怪物数据库里有没城门的设置: ' + m_MainDoor.sName);
            end;
          end;  

          if m_LeftWall.BaseObject = nil then begin
            m_LeftWall.BaseObject:= UserEngine.RegenMonsterByName(m_sMapName, m_LeftWall.nX, m_LeftWall.nY, m_LeftWall.sName);
            if m_LeftWall.BaseObject <> nil then begin
              m_LeftWall.BaseObject.m_WAbil.HP := m_LeftWall.nHP;
              m_LeftWall.BaseObject.m_Castle := Castle;
              MainOutMessage('[城堡重载B] ' + m_LeftWall.BaseObject.m_sCharName +' '+ m_sMapName +'-'+ m_LeftWall.BaseObject.m_PEnvir.sMapName);
            end else begin
              MainOutMessage('[错误信息] 城堡初始化左城墙失败，检查怪物数据库里有没左城墙的设置: ' + m_LeftWall.sName);
            end;
          end;

          if m_CenterWall.BaseObject = nil then begin
            m_CenterWall.BaseObject := UserEngine.RegenMonsterByName(m_sMapName, m_CenterWall.nX, m_CenterWall.nY, m_CenterWall.sName);
            if m_CenterWall.BaseObject <> nil then begin
              m_CenterWall.BaseObject.m_WAbil.HP := m_CenterWall.nHP;
              m_CenterWall.BaseObject.m_Castle := Castle;
              MainOutMessage('[城堡重载C] ' + m_CenterWall.BaseObject.m_sCharName +' '+ m_sMapName +'-'+ m_CenterWall.BaseObject.m_PEnvir.sMapName);
            end else begin
              MainOutMessage('[错误信息] 城堡初始化中城墙失败，检查怪物数据库里有没中城墙的设置: ' + m_CenterWall.sName);
            end;
          end;

          if m_RightWall.BaseObject = nil then begin
            m_RightWall.BaseObject := UserEngine.RegenMonsterByName(m_sMapName, m_RightWall.nX, m_RightWall.nY, m_RightWall.sName);
            if m_RightWall.BaseObject <> nil then begin
              m_RightWall.BaseObject.m_WAbil.HP := m_RightWall.nHP;
              m_RightWall.BaseObject.m_Castle := Castle;
              MainOutMessage('[城堡重载D] ' + m_RightWall.BaseObject.m_sCharName +' '+ m_sMapName +'-'+ m_RightWall.BaseObject.m_PEnvir.sMapName);
            end else begin
              MainOutMessage('[错误信息] 城堡初始化右城墙失败，检查怪物数据库里有没右城墙的设置: ' + m_RightWall.sName);
            end;
          end;

          for K := Low(m_Archer) to High(m_Archer) do begin
            ObjUnit := @m_Archer[K];
            if ObjUnit.nHP <= 0 then Continue;
            if ObjUnit.BaseObject <> nil then begin
              ObjUnit.BaseObject.m_WAbil.HP := m_Archer[K].nHP;
              ObjUnit.BaseObject.m_Castle := Castle;
              TGuardUnit(ObjUnit.BaseObject).m_nX550 := ObjUnit.nX;
              TGuardUnit(ObjUnit.BaseObject).m_nY554 := ObjUnit.nY;
              TGuardUnit(ObjUnit.BaseObject).m_nDirection := 3;
            end else begin
              MainOutMessage('[错误信息] 城堡初始化弓箭手失败，检查怪物数据库里有没弓箭手的设置: ' + ObjUnit.sName);
            end;
          end;
          for K := Low(m_Guard) to High(m_Guard) do begin
            ObjUnit := @m_Guard[K];
            if ObjUnit.nHP <= 0 then Continue;
            if ObjUnit.BaseObject <> nil then begin
              ObjUnit.BaseObject.m_Castle := Castle;//20090629 增加
              ObjUnit.BaseObject.m_WAbil.HP := m_Guard[K].nHP;
            end else begin
              MainOutMessage('[错误信息] 城堡初始化守卫失败(检查怪物数据库里有没守卫怪物)');
            end;
          end;
          if m_MapCastle.m_DoorList.Count > 0 then begin
            for K := 0 to m_MapCastle.m_DoorList.Count - 1 do begin
              Door := m_MapCastle.m_DoorList.Items[K];
              if (abs(Door.nX - m_nPalaceDoorX {631}) <= 3) and (abs(Door.nY - m_nPalaceDoorY {274}) <= 3) then begin
                m_DoorStatus := Door.Status;
              end;
            end;
          end;
        end else begin
          MainOutMessage(Format('[错误信息] 城堡所在地图不存在(检查地图配置文件里是否有地图%s的设置)', [m_sMapName]));
        end;        
      end;
      m_boUnderWar:= boUnderWar;//20081019
      if m_boUnderWar then begin
        if m_MainDoor.BaseObject <> nil then begin
          if TCastleDoor(m_MainDoor.BaseObject).m_boOpened then TCastleDoor(m_MainDoor.BaseObject).Close;//20081202 关闭城门
        end;
        if m_LeftWall.BaseObject <> nil then m_LeftWall.BaseObject.m_boStoneMode := False;//20090102
        if m_CenterWall.BaseObject <> nil then m_CenterWall.BaseObject.m_boStoneMode := False;//20090102
        if m_RightWall.BaseObject <> nil then m_RightWall.BaseObject.m_boStoneMode := False;//20090102
      end;
    end;//with
  end;
end;

//城堡皇宫所在地图
function TCastleManager.IsCastlePalaceEnvir(Envir: TEnvirnoment): TUserCastle;
var
  I: Integer;
  Castle: TUserCastle;
begin
  Result := nil;
  if m_CastleList.Count > 0 then begin//20080630
    for I := 0 to m_CastleList.Count - 1 do begin
      Castle := TUserCastle(m_CastleList.Items[I]);
      if Castle.m_MapPalace = Envir then begin
        Result := Castle;
        Break;
      end;
    end;
  end;
end;
//城堡所在地图
function TCastleManager.IsCastleEnvir(Envir: TEnvirnoment): TUserCastle;
var
  I: Integer;
  Castle: TUserCastle;
begin
  Result := nil;
  if m_CastleList.Count > 0 then begin//20080630
    for I := 0 to m_CastleList.Count - 1 do begin
      Castle := TUserCastle(m_CastleList.Items[I]);
      if Castle.m_MapCastle = Envir then begin
        Result := Castle;
        Break;
      end;
    end;
  end;
end;
//是城堡成员(守方)
function TCastleManager.IsCastleMember(BaseObject: TBaseObject): TUserCastle;
var
  I: Integer;
  Castle: TUserCastle;
begin
  Result := nil;
  if m_CastleList.Count > 0 then begin//20080630
    for I := 0 to m_CastleList.Count - 1 do begin
      Castle := TUserCastle(m_CastleList.Items[I]);
      if Castle <> nil then begin//20090107 增加
        if Castle.IsMember(BaseObject) then begin
          Result := Castle;
          Break;
        end;
      end;
    end;
  end;
end;

procedure TCastleManager.Run;
var
  I: Integer;
  UserCastle: TUserCastle;
begin
  Lock;
  try
    Try
      if m_CastleList.Count > 0 then begin//20080630
        for I := 0 to m_CastleList.Count - 1 do begin
          UserCastle := TUserCastle(m_CastleList.Items[I]);
          UserCastle.Run;
        end;
      end;
    except
      MainOutMessage(format('{%s} TCastleManager.Run',[g_sExceptionVer]));
    end;
  finally
    UnLock;
  end;
end;

procedure TCastleManager.GetCastleGoldInfo(List: TStringList);
var
  I: Integer;
  Castle: TUserCastle;
begin
  if  m_CastleList.Count > 0 then begin//20080630
    for I := 0 to m_CastleList.Count - 1 do begin
      Castle := TUserCastle(m_CastleList.Items[I]);
      List.Add(Format_ToStr(g_sGameCommandSbkGoldShowMsg, [Castle.m_sName, Castle.m_nTotalGold, Castle.m_nTodayIncome]));
    end;
  end;
end;

procedure TCastleManager.Save;
var
  I: Integer;
 //Castle: TUserCastle;
begin
  SaveCastleList();
  if m_CastleList.Count > 0 then begin//20080630
    for I := 0 to m_CastleList.Count - 1 do begin
      //Castle := TUserCastle(m_CastleList.Items[I]);
      //Castle.Save;
      TUserCastle(m_CastleList.Items[I]).Save;
    end;
  end;
end;

procedure TCastleManager.LoadCastleList;
var
  LoadList: TStringList;
  Castle: TUserCastle;
  sCastleDir: string;
  I: Integer;
begin
  if FileExists(g_Config.sCastleFile) then begin
    LoadList := TStringList.Create;
    try
      LoadList.LoadFromFile(g_Config.sCastleFile);
      if LoadList.Count > 0 then begin//20080630
        for I := 0 to LoadList.Count - 1 do begin
          sCastleDir := Trim(LoadList.Strings[I]);
          if sCastleDir <> '' then begin
            Castle := TUserCastle.Create(sCastleDir);
            m_CastleList.Add(Castle);
          end;
        end;
      end;
    finally
      LoadList.Free;
    end;
    MainOutMessage('已读取 ' + IntToStr(m_CastleList.Count) + '个城堡信息...');
  end else begin
    MainOutMessage('城堡列表文件未找到！！！');
  end;
end;

procedure TCastleManager.SaveCastleList;
var
  I: Integer;
  LoadList: TStringList;
begin
  Try
    if not DirectoryExists(g_Config.sCastleDir) then CreateDir(g_Config.sCastleDir);

    if m_CastleList.Count > 0 then begin//20080630
      LoadList := TStringList.Create;
      try
        for I := 0 to m_CastleList.Count - 1 do begin
          LoadList.Add(IntToStr(I));
        end;
        LoadList.SaveToFile(g_Config.sCastleFile);
      finally
        LoadList.Free;
      end;
    end;
  except
    MainOutMessage(format('{%s} CastleManager.SaveCastleList...%s',[g_sExceptionVer, g_Config.sCastleFile]));
  end;
end;

function TCastleManager.GetCastle(nIndex: Integer): TUserCastle;
begin
  Result := nil;
  if (nIndex >= 0) and (nIndex < m_CastleList.Count) then
    Result := TUserCastle(m_CastleList.Items[nIndex]);
end;

procedure TCastleManager.GetCastleNameList(List: TStringList);
var
  I: Integer;
  Castle: TUserCastle;
begin
  if m_CastleList.Count > 0 then begin//20080630
    for I := 0 to m_CastleList.Count - 1 do begin
      Castle := TUserCastle(m_CastleList.Items[I]);
      List.Add(Castle.m_sName);
    end;
  end;
end;

procedure TCastleManager.IncRateGold(nGold: Integer);
var
  I: Integer;
  Castle: TUserCastle;
begin
  Lock;
  try
    if  m_CastleList.Count > 0 then begin//20080630
      for I := 0 to m_CastleList.Count - 1 do begin
        Castle := TUserCastle(m_CastleList.Items[I]);
        Castle.IncRateGold(nGold);
      end;
    end;
  finally
    UnLock;
  end;
end;

procedure TCastleManager.Lock;
begin
  EnterCriticalSection(CriticalSection);
end;

procedure TCastleManager.UnLock;
begin
  LeaveCriticalSection(CriticalSection);
end;

end.
