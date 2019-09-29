unit Guild;
{行会单元}
interface
uses
  Windows, SysUtils, Classes, IniFiles, ObjBase;
type
  TGuildRank = record
    nRankNo: Integer;//排名
    sRankName: string;//职务
    MemberList: TStringList;
  end;
  pTGuildRank = ^TGuildRank;
  TWarGuild = record
    Guild: TObject;
    dwWarTick: LongWord;
    dwWarTime: LongWord;
  end;
  pTWarGuild = ^TWarGuild;
  TGUild = class
    sGuildName: string;//行会名称
    NoticeList: TStringList;//行会公告
    GuildWarList: TStringList;//敌对行会列表
    GuildAllList: TStringList;//行会联盟列表
    m_RankList: TList; //职位列表
    nContestPoint: Integer;
    boTeamFight: Boolean;
    TeamFightDeadList: TStringList;
    m_boEnableAuthAlly: Boolean;//是否允许行会联盟 
    dwSaveTick: LongWord;//数据保存间隔
    boChanged: Boolean;//是否改变
    m_DynamicVarList: TList;//变量列表
    m_nGuildFountain: Integer;//行会泉水仓库 20080625
    boGuildFountainOpen: Boolean;//行会仓库是否开启 20080625
    m_nGuildMemberCount: Word;//行会成员上限 20090115
    m_GuildStarDate: TDateTime;//授给行会之星的日期
  private
    m_Config: TIniFile;
    m_nBuildPoint: Integer; //建筑度
    m_nAurae: Integer; //人气度
    m_nStability: Integer; //安定度
    m_nFlourishing: Integer; //繁荣度
    m_nChiefItemCount: Integer; //行会领取装备数量

    function SetGuildInfo(sChief: string): Boolean;
    procedure ClearRank();
    procedure SaveGuildFile(sFileName: string);
    procedure SaveGuildConfig(sFileName: string);
    function GetMemberCount(): Integer;//行会人数
    function GetMemgerIsFull(): Boolean;//行会是否满员
    procedure SetAuraePoint(nPoint: Integer);
    procedure SetBuildPoint(nPoint: Integer);
    procedure SetStabilityPoint(nPoint: Integer);
    procedure SetFlourishPoint(nPoint: Integer);
    procedure SetChiefItemCount(nPoint: Integer);
  public
    constructor Create(sName: string);
    destructor Destroy; override;
    procedure SaveGuildInfoFile();
    function LoadGuild(): Boolean;
    function LoadGuildFile(sGuildFileName: string): Boolean;
    function LoadGuildConfig(sGuildFileName: string): Boolean;
    procedure UpdateGuildFile;
    procedure CheckSaveGuildFile;
    function IsMember(sName: string): Boolean;
    function IsAllyGuild(Guild: TGUild): Boolean;
    function IsWarGuild(Guild: TGUild): Boolean;
    function DelAllyGuild(Guild: TGUild): Boolean;
    procedure TeamFightWhoDead(sName: string);
    procedure TeamFightWhoWinPoint(sName: string; nPoint: Integer);
    procedure SendGuildMsg(sMsg: string);//行会聊天
    procedure SendGuildMsg1(sMsg: string; FColor, BColor: Byte);//行会聊天2 (供NPC命令-SendMsg使用) 20081214
    procedure RefMemberName();
    function GetRankName(PlayObject: TPlayObject; var nRankNo: Integer): string;
    function DelMember(sHumName: string): Boolean;
    function UpdateRank(sRankData: string): Integer;
    function CancelGuld(sHumName: string): Boolean;
    function IsNotWarGuild(Guild: TGUild): Boolean;
    function AllyGuild(Guild: TGUild): Boolean;
    function AddMember(PlayObject: TPlayObject): Boolean;
    procedure DelHumanObj(PlayObject: TPlayObject);
    function GetChiefName(): string;//取行会老大名字
    procedure BackupGuildFile();
    procedure sub_499B4C(Guild: TGUild);
    function AddWarGuild(Guild: TGUild): pTWarGuild;
    procedure StartTeamFight();
    procedure EndTeamFight();
    procedure AddTeamFightMember(sHumanName: string);
    property Count: Integer read GetMemberCount;
    property IsFull: Boolean read GetMemgerIsFull;
    property nBuildPoint: Integer read m_nBuildPoint write SetBuildPoint;
    property nAurae: Integer read m_nAurae write SetAuraePoint;
    property nStability: Integer read m_nStability write SetStabilityPoint;
    property nFlourishing: Integer read m_nFlourishing write SetFlourishPoint;
    property nChiefItemCount: Integer read m_nChiefItemCount write SetChiefItemCount;
  end;
  TGuildManager = class//行会管理类
    GuildList: TList;//行会列表
  private
  public
    constructor Create();
    destructor Destroy; override;
    procedure LoadGuildInfo();
    procedure SaveGuildList();
    function MemberOfGuild(sName: string): TGUild;
    function AddGuild(sGuildName, sChief: string): Boolean;
    function FindGuild(sGuildName: string): TGUild;
    function DELGUILD(sGuildName: string): Boolean;
    procedure ClearGuildInf();
    procedure Run();
  end;
implementation

uses M2Share, HUtil32, Grobal2, StrUtils;

{ TGuildManager }
//新建行会
function TGuildManager.AddGuild(sGuildName, sChief: string): Boolean;
var
  Guild: TGUild;
begin
  Result := False;
  if CheckGuildName(sGuildName) and (FindGuild(sGuildName) = nil) then begin
    Guild := TGUild.Create(sGuildName);
    Guild.SetGuildInfo(sChief);
    Guild.m_nGuildMemberCount:= g_Config.nGuildMemberCount;//行会成员上限 20090115
    GuildList.Add(Guild);
    SaveGuildList();
    Result := True;
  end;
end;
//删除行会
function TGuildManager.DELGUILD(sGuildName: string): Boolean;
var
  I: Integer;
  Guild: TGUild;
begin
  Result := False;
  for I := 0 to GuildList.Count - 1 do begin//20080917 修改
    if GuildList.Count <= 0 then Break;//20080917
    Guild := TGUild(GuildList.Items[I]);
    if CompareText(Guild.sGuildName, sGuildName) = 0 then begin
      if Guild.m_RankList.Count > 1 then Break;
      Guild.BackupGuildFile();
      GuildList.Delete(I);
      SaveGuildList();
      Result := True;
      Break;
    end;
  end;
end;

procedure TGuildManager.ClearGuildInf;
var
  I: Integer;
begin
  if GuildList.Count > 0 then begin
    for I := 0 to GuildList.Count - 1 do begin
      TGUild(GuildList.Items[I]).Free;
    end;
  end;
  GuildList.Clear;
end;

constructor TGuildManager.Create;
begin
  GuildList := TList.Create;
end;

destructor TGuildManager.Destroy;
begin
  ClearGuildInf;//20110731 增加
  GuildList.Free;
  inherited;
end;
//查找行会
function TGuildManager.FindGuild(sGuildName: string): TGUild;
var
  I: Integer;
begin
  Result := nil;
  if GuildList.Count > 0 then begin
    for I := 0 to GuildList.Count - 1 do begin
      if TGUild(GuildList.Items[I]).sGuildName = sGuildName then begin
        Result := TGUild(GuildList.Items[I]);
        Break;
      end;
    end;
  end;
end;

procedure TGuildManager.LoadGuildInfo;
var
  LoadList: TStringList;
  Guild: TGUild;
  sGuildName: string;
  I: Integer;
begin
  if FileExists(g_Config.sGuildFile) then begin
    try
      LoadList := TStringList.Create;
      try
        LoadList.LoadFromFile(g_Config.sGuildFile);
        if LoadList.Count > 0 then begin//20080630
          for I := 0 to LoadList.Count - 1 do begin
            sGuildName := Trim(LoadList.Strings[I]);
            if sGuildName <> '' then begin
              Guild := TGUild.Create(sGuildName);
              GuildList.Add(Guild);
            end;
          end;
        end;
      finally
        LoadList.Free;
      end;
      for I := GuildList.Count - 1 downto 0 do begin
        if GuildList.Count <= 0 then Break;//20080917
        Guild := GuildList.Items[I];
        if not Guild.LoadGuild() then begin
          MainOutMessage(Guild.sGuildName + ' 读取出错！！！');
          Guild.Free;
          GuildList.Delete(I);
          SaveGuildList();
        end;
      end;
      MainOutMessage('已读取 ' + IntToStr(GuildList.Count) + '个行会信息...');
    except
      on E: Exception do MainOutMessage('读取行会信息文件['+g_Config.sGuildFile+']异常！'+ E.Message);
    end;
  end else begin
    MainOutMessage('行会信息文件未找到！！！['+ g_Config.sGuildFile +']');
  end;
end;
//取玩家所属的行会
function TGuildManager.MemberOfGuild(sName: string): TGUild;
var
  I: Integer;
begin
  Result := nil;
  if GuildList.Count > 0 then begin//20080630
    for I := 0 to GuildList.Count - 1 do begin
      if TGUild(GuildList.Items[I]).IsMember(sName) then begin
        Result := TGUild(GuildList.Items[I]);
        Break;
      end;
    end;
  end;
end;

procedure TGuildManager.SaveGuildList;
var
  I: Integer;
  SaveList: TStringList;
begin
  if nServerIndex <> 0 then Exit;
  SaveList := TStringList.Create;
  if GuildList.Count > 0 then begin//20080630
    for I := 0 to GuildList.Count - 1 do begin
      SaveList.Add(TGUild(GuildList.Items[I]).sGuildName);
    end; // for
  end;
  try
    SaveList.SaveToFile(g_Config.sGuildFile);
  except
    MainOutMessage('行会信息保存失败！！！');
  end;
  SaveList.Free;
end;

procedure TGuildManager.Run;
var
  I: Integer;
  II: Integer;
  Guild: TGUild;
  boChanged: Boolean;
  WarGuild: pTWarGuild;
begin
  try
    if GuildList.Count > 0 then begin//20080630
      for I := 0 to GuildList.Count - 1 do begin
        Guild := TGUild(GuildList.Items[I]);
        boChanged := False;
        for II := Guild.GuildWarList.Count - 1 downto 0 do begin
          if Guild.GuildWarList.Count <= 0 then Break;//20080917
          WarGuild := pTWarGuild(Guild.GuildWarList.Objects[II]);
          if (GetTickCount - WarGuild.dwWarTick) > WarGuild.dwWarTime then begin//删除行会战争时间的对像
            Guild.sub_499B4C(TGUild(WarGuild.Guild));//提示行会战争结束
            Guild.GuildWarList.Delete(II);
            Dispose(WarGuild);
            boChanged := True;
          end;
        end;
        if boChanged then Guild.UpdateGuildFile();
        Guild.CheckSaveGuildFile;
      end;
    end;
  except
    MainOutMessage(Format('{%s} TGuildManager.Run', [g_sExceptionVer]));
  end;
end;

{ TGuild }
//清除行会
procedure TGUild.ClearRank;
var
  I: Integer;
  GuildRank: pTGuildRank;
begin
  if m_RankList.Count > 0 then begin//20080630
    for I := 0 to m_RankList.Count - 1 do begin
      GuildRank := m_RankList.Items[I];
      GuildRank.MemberList.Free;
      Dispose(GuildRank);
    end; // for
  end;
  m_RankList.Clear;
end;

constructor TGUild.Create(sName: string);
var
  sFileName: string;
begin
  sGuildName := sName;
  NoticeList := TStringList.Create;
  GuildWarList := TStringList.Create;
  GuildAllList := TStringList.Create;
  m_RankList := TList.Create;
  TeamFightDeadList := TStringList.Create;
  dwSaveTick := 0;
  boChanged := False;
  nContestPoint := 0;
  boTeamFight := False;
  m_boEnableAuthAlly := False;

  sFileName := g_Config.sGuildDir + sName + '.ini';
  if not DirectoryExists(g_Config.sGuildDir) then CreateDir(g_Config.sGuildDir); //目录不存在,则创建 20090319
  m_Config := TIniFile.Create(sFileName);
  if not FileExists(sFileName) then begin
    m_Config.WriteString('Guild', 'GuildName', sName);
  end;

  m_nBuildPoint := 0;
  m_nAurae := 0;
  m_nStability := 0;
  m_nFlourishing := 0;
  m_nChiefItemCount := 0;
  m_nGuildFountain:= 0;//行会泉水仓库 20080625
  boGuildFountainOpen:= False;//行会仓库是否开启 20080625
  m_nGuildMemberCount:= g_Config.nGuildMemberCount;//行会成员上限 20090115
  m_DynamicVarList := TList.Create;
  m_GuildStarDate:= Now();
end;
//删除联盟
function TGUild.DelAllyGuild(Guild: TGUild): Boolean;
var
  I: Integer;
  AllyGuild: TGUild;
begin
  Result := False;
  for I := 0 to GuildAllList.Count - 1 do begin//20080917 修改
    if GuildAllList.Count <= 0 then Break;//20080917
    AllyGuild := TGUild(GuildAllList.Objects[I]);
    if AllyGuild <> nil then begin//20090213
      if AllyGuild = Guild then begin
        GuildAllList.Delete(I);
        Result := True;
        Break;
      end;
    end;
  end; // for
  SaveGuildInfoFile();
end;

destructor TGUild.Destroy;
var
  I: Integer;
begin
  NoticeList.Free;
  GuildWarList.Free;
  GuildAllList.Free;
  ClearRank();
  m_RankList.Free;
  TeamFightDeadList.Free;
  m_Config.Free;
  if m_DynamicVarList.Count > 0 then begin//20080630
    for I := 0 to m_DynamicVarList.Count - 1 do begin
      if pTDynamicVar(m_DynamicVarList.Items[I]) <> nil then
         Dispose(pTDynamicVar(m_DynamicVarList.Items[I]));
    end;
  end;
  m_DynamicVarList.Free;
  inherited;
end;
//检查是否是联盟行会
function TGUild.IsAllyGuild(Guild: TGUild): Boolean;
var
  I: Integer;
  AllyGuild: TGUild;
begin
  Result := False;
  for I := 0 to GuildAllList.Count - 1 do begin
    AllyGuild := TGUild(GuildAllList.Objects[I]);
    if AllyGuild <> nil then begin//20090213
      if AllyGuild = Guild then begin
        Result := True;
        Break;
      end;
    end;
  end;
end;
//是否是行会成员
function TGUild.IsMember(sName: string): Boolean;
var
  I, II: Integer;
  GuildRank: pTGuildRank;
begin
  Result := False;
  for I := 0 to m_RankList.Count - 1 do begin
    GuildRank := m_RankList.Items[I];
    for II := 0 to GuildRank.MemberList.Count - 1 do begin
      if GuildRank.MemberList.Strings[II] = sName then begin
        Result := True;
        Exit;
      end;
    end;
  end;
end;
//检查是否是敌对行会
function TGUild.IsWarGuild(Guild: TGUild): Boolean;
var
  I: Integer;
begin
  Result := False;
  if GuildWarList.Count > 0 then begin//20080630
    for I := 0 to GuildWarList.Count - 1 do begin
      if pTWarGuild(GuildWarList.Objects[I]).Guild = Guild then begin
        Result := True;
        Break;
      end;
    end; // for
  end;
end;

function TGUild.LoadGuild(): Boolean;
var
  sFileName: string;
begin
  sFileName := sGuildName + '.txt';
  Result := LoadGuildFile(sFileName);
  LoadGuildConfig(sGuildName + '.ini');
end;

function TGUild.LoadGuildConfig(sGuildFileName: string): Boolean;
begin
  m_nBuildPoint := m_Config.ReadInteger('Guild', 'BuildPoint', m_nBuildPoint);
  m_nAurae := m_Config.ReadInteger('Guild', 'Aurae', m_nAurae);
  m_nStability := m_Config.ReadInteger('Guild', 'Stability', m_nStability);
  m_nFlourishing := m_Config.ReadInteger('Guild', 'Flourishing', m_nFlourishing);
  m_nChiefItemCount := m_Config.ReadInteger('Guild', 'ChiefItemCount', m_nChiefItemCount);
  m_nGuildFountain := m_Config.ReadInteger('Guild', 'GuildFountain', m_nGuildFountain);//行会泉水仓库 20080625
  boGuildFountainOpen := m_Config.ReadBool('Guild', 'GuildFountainOpen', boGuildFountainOpen);//行会仓库是否开启 20080625
  m_nGuildMemberCount:=  m_Config.ReadInteger('Guild', 'GuildMemberCount', m_nGuildMemberCount);//行会成员上限 20090115
  m_GuildStarDate:= m_Config.ReadDateTime('Guild', 'GuildStarDate', Now());//授给行会之星的日期
  Result := True;
end;
//读取行会文件
function TGUild.LoadGuildFile(sGuildFileName: string): Boolean;
var
  I: Integer;
  LoadList: TStringList;
  s18, s1C, s20, s24, sFileName: string;
  n28, n2C: Integer;
  GuildWar: pTWarGuild;
  GuildRank: pTGuildRank;
  Guild: TGUild;
begin
  Result := False;
  GuildRank := nil;
  sFileName := g_Config.sGuildDir + sGuildFileName;
  if not FileExists(sFileName) then Exit;
  ClearRank();
  NoticeList.Clear;
  if GuildWarList.Count > 0 then begin//20080630
    for I := 0 to GuildWarList.Count - 1 do begin
      if pTWarGuild(GuildWarList.Objects[I]) <> nil then
         Dispose(pTWarGuild(GuildWarList.Objects[I]));
    end; // for
  end;
  GuildWarList.Clear;
  GuildAllList.Clear;
  n28 := 0;
  n2C := 0;
  s24 := '';
  LoadList := TStringList.Create;
  try
    LoadList.LoadFromFile(sFileName);
    for I := 0 to LoadList.Count - 1 do begin
      s18 := LoadList.Strings[I];
      if (s18 = '') or (s18[1] = ';') then Continue;
      if s18[1] <> '+' then begin
        if s18 = g_Config.sGuildNotice then n28 := 1;//行会公告
        if s18 = g_Config.sGuildWar then n28 := 2;
        if s18 = g_Config.sGuildAll then n28 := 3;
        if s18 = g_Config.sGuildMember then n28 := 4;
        if s18[1] = '#' then begin
          s18 := Copy(s18, 2, Length(s18) - 1);
          s18 := GetValidStr3(s18, s1C, [' ', ',']);
          n2C := Str_ToInt(s1C, 0);//排名
          s24 := Trim(s18);//职务
          GuildRank := nil;
        end;
        Continue;
      end;
      s18 := Copy(s18, 2, Length(s18) - 1);
      case n28 of
        1: NoticeList.Add(s18);//行会公告
        2: begin//敌对行会
            while (s18 <> '') do begin
              s18 := GetValidStr3(s18, s1C, [' ', ',']);
              if s1C = '' then Break;
              New(GuildWar);
              GuildWar.Guild := g_GuildManager.FindGuild(s1C);
              if GuildWar.Guild <> nil then begin
                GuildWar.dwWarTick := GetTickCount();
                GuildWar.dwWarTime := Str_ToInt(Trim(s20), 0);
                GuildWarList.AddObject(TGUild(GuildWar.Guild).sGuildName, TObject(GuildWar));
              end else begin
                Dispose(GuildWar);
              end;
            end;
          end;
        3: begin//行会联盟
            while (s18 <> '') do begin
              s18 := GetValidStr3(s18, s1C, [' ', ',']);
              s18 := GetValidStr3(s18, s20, [' ', ',']);
              if s1C = '' then Break;
              Guild := g_GuildManager.FindGuild(s1C);
              if Guild <> nil then GuildAllList.AddObject(s1C, Guild);
            end;
          end;
        4: begin
            if (n2C > 0) and (s24 <> '') then begin
              if Length(s24) > 30 then //限制职务的长度
                s24 := Copy(s24, 1, g_Config.nGuildRankNameLen {30});
              if Pos('|',s24) > 0 then s24 := AnsiReplaceText(s24, '|', '');//20110402 过滤封号带|符号
              if GuildRank = nil then begin
                New(GuildRank);
                GuildRank.nRankNo := n2C;
                GuildRank.sRankName := s24;
                GuildRank.MemberList := TStringList.Create;
                m_RankList.Add(GuildRank);
              end;
              while (s18 <> '') do begin
                s18 := GetValidStr3(s18, s1C, [' ', ',']);
                if s1C = '' then Break;
                GuildRank.MemberList.Add(s1C);
              end;
            end;
          end;
      end; // case
    end;
  finally
    LoadList.Free;
  end;
  Result := True;
end;

procedure TGUild.RefMemberName;
var
  I, II: Integer;
  GuildRank: pTGuildRank;
  BaseObject: TBaseObject;
  nCode: Byte;//20080806
begin
  nCode:=0;
  try
    if m_RankList.Count > 0 then begin//20080630
      nCode:=1;
      for I := 0 to m_RankList.Count - 1 do begin
        nCode:= 2;
        GuildRank := m_RankList.Items[I];
        nCode:=3;
        if GuildRank <> nil then begin//20080806 增加
          nCode:=4;
          if GuildRank.MemberList.Count > 0 then begin//20080630
            nCode:=5;
            for II := 0 to GuildRank.MemberList.Count - 1 do begin
              nCode:=6;
              BaseObject := TBaseObject(GuildRank.MemberList.Objects[II]);
              nCode:=7;
              if BaseObject <> nil then BaseObject.RefShowName;
            end;
          end;
        end;
      end;
    end;
  except
    MainOutMessage(Format('{%s} TGUild.RefMemberName Code:%d', [g_sExceptionVer, nCode]));
  end;
end;

procedure TGUild.SaveGuildInfoFile;
begin
  if nServerIndex = 0 then begin
    SaveGuildFile(g_Config.sGuildDir + sGuildName + '.txt');
    SaveGuildConfig(g_Config.sGuildDir + sGuildName + '.ini');
  end else begin
    SaveGuildFile(g_Config.sGuildDir + sGuildName + '.' + IntToStr(nServerIndex));
  end;
end;

procedure TGUild.SaveGuildConfig(sFileName: string);
begin
  m_Config.WriteString('Guild', 'GuildName', sGuildName);
  m_Config.WriteInteger('Guild', 'BuildPoint', m_nBuildPoint);
  m_Config.WriteInteger('Guild', 'Aurae', m_nAurae);
  m_Config.WriteInteger('Guild', 'Stability', m_nStability);
  m_Config.WriteInteger('Guild', 'Flourishing', m_nFlourishing);
  m_Config.WriteInteger('Guild', 'ChiefItemCount', m_nChiefItemCount);
  m_Config.WriteInteger('Guild', 'GuildFountain', m_nGuildFountain);//行会泉水仓库 20080625
  m_Config.WriteBool('Guild', 'GuildFountainOpen', boGuildFountainOpen);//行会仓库是否开启 20080625
  m_Config.WriteInteger('Guild', 'GuildMemberCount', m_nGuildMemberCount);//行会成员上限 20090115
  m_Config.WriteDateTime('Guild', 'GuildStarDate', m_GuildStarDate);//授给行会之星的日期
end;

procedure TGUild.SaveGuildFile(sFileName: string);
var
  SaveList: TStringList;
  I, II: Integer;
  WarGuild: pTWarGuild;
  GuildRank: pTGuildRank;
  n14: Integer;
begin
  SaveList := TStringList.Create;
  try
    SaveList.Add(g_Config.sGuildNotice);
    for I := 0 to NoticeList.Count - 1 do begin
      SaveList.Add('+' + NoticeList.Strings[I]);
    end;
    SaveList.Add(' ');
    SaveList.Add(g_Config.sGuildWar);
    for I := 0 to GuildWarList.Count - 1 do begin
      WarGuild := pTWarGuild(GuildWarList.Objects[I]);
      n14 := WarGuild.dwWarTime - (GetTickCount - WarGuild.dwWarTick);
      if n14 <= 0 then Continue;
      SaveList.Add('+' + GuildWarList.Strings[I] + ' ' + IntToStr(n14));
    end;
    SaveList.Add(' ');
    SaveList.Add(g_Config.sGuildAll);
    for I := 0 to GuildAllList.Count - 1 do begin
      SaveList.Add('+' + GuildAllList.Strings[I]);
    end;
    SaveList.Add(' ');
    SaveList.Add(g_Config.sGuildMember);

    for I := 0 to m_RankList.Count - 1 do begin
      GuildRank := m_RankList.Items[I];
      SaveList.Add('#' + IntToStr(GuildRank.nRankNo) + ' ' + GuildRank.sRankName);
      for II := 0 to GuildRank.MemberList.Count - 1 do begin
        SaveList.Add('+' + GuildRank.MemberList.Strings[II]);
      end;
    end;
    try
      SaveList.SaveToFile(sFileName);
    except
      MainOutMessage('保存行会信息失败！！！ ' + sFileName);
    end;
  finally
    SaveList.Free;
  end;
end;
//行会聊天
procedure TGUild.SendGuildMsg(sMsg: string);
var
  I: Integer;
  II: Integer;
  GuildRank: pTGuildRank;
  PlayObject: TPlayObject;
  nCheckCode: Integer;
begin
  nCheckCode := 0;
  try
    if g_Config.boShowPreFixMsg then sMsg := g_Config.sGuildMsgPreFix + sMsg;
    //if RankList = nil then exit;
    nCheckCode := 1;
    if m_RankList.Count > 0 then begin//20080630
      if g_Config.boRecordClientMsg and (sMsg <> '') then begin//记录行会聊天信息 20090211
        if g_Config.boShowPreFixMsg then MainOutMessage(sGuildName+':'+ sMsg)
        else MainOutMessage('[行会]'+ sGuildName+':'+ sMsg);
      end;
      for I := 0 to m_RankList.Count - 1 do begin
        GuildRank := m_RankList.Items[I];
        nCheckCode := 2;
        if GuildRank.MemberList = nil then Continue;
        if GuildRank.MemberList.Count > 0 then begin//20080630
          for II := 0 to GuildRank.MemberList.Count - 1 do begin
            nCheckCode := 3;
            PlayObject := TPlayObject(GuildRank.MemberList.Objects[II]);              //挂机不接收行会信息
            if (PlayObject = nil) or (UserEngine.GetPlayObject(PlayObject) = nil) or (PlayObject.m_boNotOnlineAddExp) then Continue; {2007-01-27 增加}
            nCheckCode := 4;
            if PlayObject.m_boBanGuildChat then begin
              nCheckCode := 5;
              PlayObject.SendMsg(PlayObject, RM_GUILDMESSAGE, 0, g_Config.btGuildMsgFColor, g_Config.btGuildMsgBColor, 0, sMsg);
              nCheckCode := 6;
            end;
          end;//for
        end;
      end;
    end;
  except
    on E: Exception do begin
      MainOutMessage(Format('{%s} TGuild.SendGuildMsg CheckCode:%d GuildName:%s Msg:%s', [g_sExceptionVer, nCheckCode, sGuildName, sMsg]));
      //MainOutMessage(E.Message);
    end;
  end;
end;

//行会聊天2 (供NPC命令-SendMsg使用) 20081214
procedure TGUild.SendGuildMsg1(sMsg: string; FColor, BColor: Byte);
var
  I: Integer;
  II: Integer;
  GuildRank: pTGuildRank;
  PlayObject: TPlayObject;
  nCheckCode: Integer;
begin
  nCheckCode := 0;
  try
    if g_Config.boShowPreFixMsg then sMsg := g_Config.sGuildMsgPreFix + sMsg;
    //if RankList = nil then exit;
    nCheckCode := 1;
    if m_RankList.Count > 0 then begin
      for I := 0 to m_RankList.Count - 1 do begin
        GuildRank := m_RankList.Items[I];
        nCheckCode := 2;
        if GuildRank.MemberList = nil then Continue;
        if GuildRank.MemberList.Count > 0 then begin
          nCheckCode := 6;
          for II := 0 to GuildRank.MemberList.Count - 1 do begin
            nCheckCode := 3;
            PlayObject := TPlayObject(GuildRank.MemberList.Objects[II]);              //挂机不接收行会信息
            if (PlayObject = nil) or (UserEngine.GetPlayObject(PlayObject) = nil) or (PlayObject.m_boNotOnlineAddExp) then Continue; {2007-01-27 增加}
            nCheckCode := 4;
            if PlayObject.m_boBanGuildChat then begin
              nCheckCode := 5;
              PlayObject.SendMsg(PlayObject, RM_GUILDMESSAGE, 0, FColor, BColor, 0, sMsg);
            end;
          end;//for
        end;
      end;
    end;
  except
    on E: Exception do begin
      MainOutMessage(Format('{%s} TGuild.SendGuildMsg1 CheckCode:%d GuildName:%s Msg:%s', [g_sExceptionVer, nCheckCode, sGuildName, sMsg]));
      //MainOutMessage(E.Message);
    end;
  end;
end;
//设置城堡信息
function TGUild.SetGuildInfo(sChief: string): Boolean;
var
  GuildRank: pTGuildRank;
begin
  if m_RankList.Count = 0 then begin
    New(GuildRank);
    GuildRank.nRankNo := 1;//老大
    GuildRank.sRankName := g_Config.sGuildChief;//掌门人
    GuildRank.MemberList := TStringList.Create;
    GuildRank.MemberList.Add(sChief);
    m_RankList.Add(GuildRank);
    SaveGuildInfoFile();
  end;
  Result := True;
end;
//取行会封号
function TGUild.GetRankName(PlayObject: TPlayObject; var nRankNo: Integer): string;
var
  I, II: Integer;
  GuildRank: pTGuildRank;
begin
  Result := '';
  if m_RankList.Count > 0 then begin//20080630
    for I := 0 to m_RankList.Count - 1 do begin
      GuildRank := m_RankList.Items[I];
      if GuildRank.MemberList.Count > 0 then begin//20080630
        for II := 0 to GuildRank.MemberList.Count - 1 do begin
          if GuildRank.MemberList.Strings[II] = PlayObject.m_sCharName then begin
            GuildRank.MemberList.Objects[II] := PlayObject;
            nRankNo := GuildRank.nRankNo;
            Result := GuildRank.sRankName;
            //PlayObject.RefShowName();
            PlayObject.SendMsg(PlayObject, RM_CHANGEGUILDNAME, 0, 0, 0, 0, '');
            Exit;
          end;
        end;
      end;
    end;
  end;
end;
//取行会老大名字
function TGUild.GetChiefName: string;
var
  GuildRank: pTGuildRank;
begin
  Result := '';
  if m_RankList.Count <= 0 then Exit;
  GuildRank := m_RankList.Items[0];
  if GuildRank.MemberList.Count <= 0 then Exit;
  Result := GuildRank.MemberList.Strings[0];
end;

procedure TGUild.CheckSaveGuildFile();
begin
  if boChanged and ((GetTickCount - dwSaveTick) > 30000{30 * 1000}) then begin
    boChanged := False;
    SaveGuildInfoFile();
  end;
end;

procedure TGUild.DelHumanObj(PlayObject: TPlayObject);
var
  I, II: Integer;
  GuildRank: pTGuildRank;
begin
  CheckSaveGuildFile();
  if m_RankList.Count > 0 then begin//20080630
    for I := 0 to m_RankList.Count - 1 do begin
      GuildRank := m_RankList.Items[I];
      if GuildRank.MemberList.Count > 0 then begin//20080630
        for II := 0 to GuildRank.MemberList.Count - 1 do begin
          if TPlayObject(GuildRank.MemberList.Objects[II]) = PlayObject then begin
            GuildRank.MemberList.Objects[II] := nil;
            Exit;
          end;
        end;
      end;
    end;
  end;
end;

procedure TGUild.TeamFightWhoDead(sName: string);
var
  I, n10: Integer;
begin
  if not boTeamFight then Exit;
  if TeamFightDeadList.Count > 0 then begin//20080630
    for I := 0 to TeamFightDeadList.Count - 1 do begin
      if TeamFightDeadList.Strings[I] = sName then begin
        n10 := Integer(TeamFightDeadList.Objects[I]);
        TeamFightDeadList.Objects[I] := TObject(MakeLong(LoWord(n10) + 1, HiWord(n10)));
      end;
    end;
  end;
end;

procedure TGUild.TeamFightWhoWinPoint(sName: string; nPoint: Integer);
var
  I, n14: Integer;
begin
  if not boTeamFight then Exit;
  Inc(nContestPoint, nPoint);
  if TeamFightDeadList.Count > 0 then begin//20080630
    for I := 0 to TeamFightDeadList.Count - 1 do begin
      if TeamFightDeadList.Strings[I] = sName then begin
        n14 := Integer(TeamFightDeadList.Objects[I]);
        TeamFightDeadList.Objects[I] := TObject(MakeLong(LoWord(n14), HiWord(n14) + nPoint));
      end;
    end;
  end;
end;

procedure TGUild.UpdateGuildFile();
begin
  boChanged := True;
  dwSaveTick := GetTickCount();
  SaveGuildInfoFile();
end;
procedure TGUild.BackupGuildFile;
var
  I, II: Integer;
  PlayObject: TPlayObject;
  GuildRank: pTGuildRank;
begin
  if nServerIndex = 0 then
    SaveGuildFile(g_Config.sGuildDir + sGuildName + '.' + IntToStr(GetTickCount) + '.bak');
  if m_RankList.Count > 0 then begin//20080630
    for I := 0 to m_RankList.Count - 1 do begin
      GuildRank := m_RankList.Items[I];
      if GuildRank.MemberList.Count > 0 then begin//20080630
        for II := 0 to GuildRank.MemberList.Count - 1 do begin
          PlayObject := TPlayObject(GuildRank.MemberList.Objects[II]);
          if PlayObject <> nil then begin
            PlayObject.m_MyGuild := nil;
            PlayObject.RefRankInfo(0, '');
            PlayObject.RefShowName(); //10/31
          end;
        end;
      end;
      GuildRank.MemberList.Free;
      Dispose(GuildRank);
    end;
  end;
  m_RankList.Clear;
  NoticeList.Clear;
  if GuildWarList.Count > 0 then begin//20080630
    for I := 0 to GuildWarList.Count - 1 do begin
      if pTWarGuild(GuildWarList.Objects[I]) <> nil then
        Dispose(pTWarGuild(GuildWarList.Objects[I]));
    end;
  end;
  GuildWarList.Clear;
  GuildAllList.Clear;
  SaveGuildInfoFile();
end;
//行会增加成员
function TGUild.AddMember(PlayObject: TPlayObject): Boolean;
var
  I: Integer;
  GuildRank: pTGuildRank;
  GuildRank18: pTGuildRank;
begin
  Result := False;
  GuildRank18 := nil;
  if m_RankList.Count > 0 then begin//20080630
    for I := 0 to m_RankList.Count - 1 do begin
      GuildRank := m_RankList.Items[I];
      if GuildRank.nRankNo = 99 then begin
        GuildRank18 := GuildRank;
        Break;
      end;
    end;
  end;
  if GuildRank18 = nil then begin
    New(GuildRank18);
    GuildRank18.nRankNo := 99;
    GuildRank18.sRankName := g_Config.sGuildMemberRank;
    GuildRank18.MemberList := TStringList.Create;
    m_RankList.Add(GuildRank18);
  end;
  GuildRank18.MemberList.AddObject(PlayObject.m_sCharName, TObject(PlayObject));
  UpdateGuildFile();//更新行会文件
  Result := True;
end;
//行会删除成员
function TGUild.DelMember(sHumName: string): Boolean;
var
  I, II: Integer;
  GuildRank: pTGuildRank;
begin
  Result := False;
  for I := 0 to m_RankList.Count - 1 do begin
    GuildRank := m_RankList.Items[I];
    for II := GuildRank.MemberList.Count - 1 downto 0 do begin//20080917 修改
      if GuildRank.MemberList.Count <= 0 then Break;//20080917
      if GuildRank.MemberList.Strings[II] = sHumName then begin
        GuildRank.MemberList.Delete(II);
        Result := True;
        Break;
      end;
    end;
    if Result then Break;
  end;
  if Result then UpdateGuildFile;
end;

function TGUild.CancelGuld(sHumName: string): Boolean;
var
  GuildRank: pTGuildRank;
begin
  Result := False;
  if m_RankList.Count <> 1 then Exit;
  GuildRank := m_RankList.Items[0];
  if GuildRank.MemberList.Count <> 1 then Exit;
  if GuildRank.MemberList.Strings[0] = sHumName then begin
    BackupGuildFile();
    Result := True;
  end;
end;
//修改行会封号
function TGUild.UpdateRank(sRankData: string): Integer;
  procedure ClearRankList(var RankList: TList);
  var
    I: Integer;
    GuildRank: pTGuildRank;
  begin
    if RankList.Count > 0 then begin//20080630
      for I := 0 to RankList.Count - 1 do begin
        GuildRank := RankList.Items[I];
        GuildRank.MemberList.Free;
        Dispose(GuildRank);
      end;
    end;
    RankList.Free;
  end;
var
  I: Integer;
  II: Integer;
  III: Integer;
  GuildRankList: TList;
  GuildRank: pTGuildRank;
  NewGuildRank: pTGuildRank;
  sRankInfo: string;
  sRankNo: string;
  sRankName: string;
  sMemberName: string;
  n28: Integer;
  n2C: Integer;
  n30: Integer;
  boCheckChange: Boolean;
  PlayObject: TPlayObject;
begin
  Result := -1;
  Try
    if Pos('|',sRankData) > 0 then begin//不能包含|符号，会影响称号显示 20110402
      Result := -7;
      Exit;
    end;
    GuildRankList := TList.Create;
    GuildRank := nil;
    while (True) do begin
      if sRankData = '' then Break;
      sRankData := GetValidStr3(sRankData, sRankInfo, [#$0D]);
      sRankInfo := Trim(sRankInfo);
      if sRankInfo = '' then Continue;
      if sRankInfo[1] = '#' then begin //取得职称的名称
        sRankInfo := Copy(sRankInfo, 2, Length(sRankInfo) - 1);
        sRankInfo := GetValidStr3(sRankInfo, sRankNo, [' ', '<']);
        sRankInfo := GetValidStr3(sRankInfo, sRankName, ['<', '>']);
        if Length(sRankName) > 30 then //Jacky 限制职称的长度
          sRankName := Copy(sRankName, 1, 30);
        if GuildRank <> nil then begin
          GuildRankList.Add(GuildRank);
        end;
        New(GuildRank);
        GuildRank.nRankNo := Str_ToInt(sRankNo, 99);
        GuildRank.sRankName := Trim(sRankName);
        GuildRank.MemberList := TStringList.Create;
        Continue;
      end;

      if GuildRank = nil then Continue;
      I := 0;
      while (True) do begin //将成员名称加入职称表里
        if sRankInfo = '' then Break;
        sRankInfo := GetValidStr3(sRankInfo, sMemberName, [' ', ',']);
        if sMemberName <> '' then GuildRank.MemberList.Add(sMemberName);
        Inc(I);
        if I > g_Config.nGuildMemberMaxLimit then Break; //限制成员数量
      end;
    end;

    if GuildRank <> nil then begin
      GuildRankList.Add(GuildRank);
    end;

    //校验成员列表是否有改变，如果未修改则退出
    boCheckChange := False;
    if m_RankList.Count = GuildRankList.Count then begin
      boCheckChange := True;
      for I := 0 to m_RankList.Count - 1 do begin
        GuildRank := m_RankList.Items[I];
        NewGuildRank := GuildRankList.Items[I];
        if (GuildRank.nRankNo = NewGuildRank.nRankNo) and
          (GuildRank.sRankName = NewGuildRank.sRankName) and
          (GuildRank.MemberList.Count = NewGuildRank.MemberList.Count) then begin
            for II := 0 to GuildRank.MemberList.Count - 1 do begin
              if GuildRank.MemberList.Strings[II] <> NewGuildRank.MemberList.Strings[II] then begin
                boCheckChange := False; //如果有改变则将其置为FALSE
                Break;
              end;
            end;
        end else begin
          boCheckChange := False;
          Break;
        end;
      end;//for
      if boCheckChange then begin
        Result := -1;
        ClearRankList(GuildRankList);
        Exit;
      end;
    end;

    //检查行会掌门职业是否为空
    Result := -2;
    if (GuildRankList.Count > 0) then begin
      GuildRank := GuildRankList.Items[0];
      if GuildRank.nRankNo = 1 then begin
        if GuildRank.sRankName <> '' then begin
          Result := 0;
        end else begin
          Result := -3;
        end;
      end;
    end;

    //检查行会掌门人是否在线(？？？)
    if Result = 0 then begin
      GuildRank := GuildRankList.Items[0];
      if GuildRank.MemberList.Count <= 2 then begin
        n28 := GuildRank.MemberList.Count;
        for I := 0 to GuildRank.MemberList.Count - 1 do begin
          if UserEngine.GetPlayObject(GuildRank.MemberList.Strings[I]) = nil then begin
            Dec(n28);
            Break;
          end;
        end;
        if n28 <= 0 then Result := -5;
      end else begin
        Result := -4;
      end;
    end;

    if Result = 0 then begin
      n2C:=0;
      n30:=0;
      for I := 0 to m_RankList.Count - 1 do begin
        GuildRank := m_RankList.Items[I];
        boCheckChange := True;
        for II := 0 to GuildRank.MemberList.Count - 1 do begin
          boCheckChange := False;
          sMemberName := GuildRank.MemberList.Strings[II];
          Inc(n2C);
          for III := 0 to GuildRankList.Count - 1 do begin //搜索新列表
            NewGuildRank := GuildRankList.Items[III];
            for n28 := 0 to NewGuildRank.MemberList.Count - 1 do begin
              if NewGuildRank.MemberList.Strings[n28] = sMemberName then begin
                boCheckChange := True;
                Break;
              end;
            end;
            if boCheckChange then Break;
          end;//for

          if not boCheckChange then begin //原列表中的人物名称是否在新的列表中
            Result := -6;
            Break;
          end;
        end;//for
        if not boCheckChange then Break;
      end;//for

      for I := 0 to GuildRankList.Count - 1 do begin
        GuildRank := GuildRankList.Items[I];
        boCheckChange := True;
        for II := 0 to GuildRank.MemberList.Count - 1 do begin
          boCheckChange := False;
          sMemberName := GuildRank.MemberList.Strings[II];
          Inc(n30);
          for III := 0 to GuildRankList.Count - 1 do begin
            NewGuildRank := GuildRankList.Items[III];
            for n28 := 0 to NewGuildRank.MemberList.Count - 1 do begin
              if NewGuildRank.MemberList.Strings[n28] = sMemberName then begin
                boCheckChange := True;
                Break;
              end;
            end;
            if boCheckChange then Break;
          end;//for
          if not boCheckChange then begin
            Result := -6;
            Break;
          end;
        end;//for
        if not boCheckChange then Break;
      end;//for
      if (Result = 0) and (n2C <> n30) then begin//n2c n30 用于比较修改过后的人数
        Result := -6;
      end;
    end;

    if Result = 0 then begin //检查掌门数量
      n2C := 0;
      for I := 0 to GuildRankList.Count - 1 do begin
        n28 := pTGuildRank(GuildRankList.Items[I]).nRankNo;
        if n28 = 1 then begin
          Inc(n2C);
          if n2C > 1 then begin
            Result := -4;
            Break;
          end;
        end;
      end;
    end;

    if Result = 0 then begin //检查职位号是否重复及非法
      for I := 0 to GuildRankList.Count - 1 do begin
        n28 := pTGuildRank(GuildRankList.Items[I]).nRankNo;
        for III := I + 1 to GuildRankList.Count - 1 do begin
          if (pTGuildRank(GuildRankList.Items[III]).nRankNo = n28) or (n28 <= 0) or (n28 > 99) then begin
            Result := -7;
            Break;
          end;
        end;
        if Result <> 0 then Break;
      end;//for
    end;

    if Result = 0 then begin
      ClearRankList(m_RankList);
      m_RankList := GuildRankList;
      //更新在线人物职位表
      for I := 0 to m_RankList.Count - 1 do begin
        GuildRank := m_RankList.Items[I];
        for III := 0 to GuildRank.MemberList.Count - 1 do begin
          PlayObject := UserEngine.GetPlayObject(GuildRank.MemberList.Strings[III]);
          if PlayObject <> nil then begin
            GuildRank.MemberList.Objects[III] := TObject(PlayObject);
            PlayObject.RefRankInfo(GuildRank.nRankNo, GuildRank.sRankName);
            PlayObject.RefShowName(); //10/31
          end;
        end;
      end;//for
      UpdateGuildFile();
    end else begin
      ClearRankList(GuildRankList);
    end;
  except
    MainOutMessage(Format('{%s} TGUild.UpdateRank',[g_sExceptionVer]));
  end;
end;

function TGUild.IsNotWarGuild(Guild: TGUild): Boolean;
var
  I: Integer;
begin
  Result := False;
  if GuildWarList.Count > 0 then begin//20080630
    for I := 0 to GuildWarList.Count - 1 do begin
      if pTWarGuild(GuildWarList.Objects[I]).Guild = Guild then begin
        Exit;
      end;
    end;
  end;
  Result := True;
end;
//进行行会联盟
function TGUild.AllyGuild(Guild: TGUild): Boolean; //00499C2C
var
  I: Integer;
begin
  Result := False;
  if GuildAllList.Count > 0 then begin//20080630
    for I := 0 to GuildAllList.Count - 1 do begin
      if GuildAllList.Objects[I] = Guild then begin
        Exit;
      end;
    end;
  end;
  GuildAllList.AddObject(Guild.sGuildName, Guild);
  SaveGuildInfoFile();
  Result := True;
end;
//增加行会战
function TGUild.AddWarGuild(Guild: TGUild): pTWarGuild;
var
  I: Integer;
  WarGuild: pTWarGuild;
begin
  Result := nil;
  if Guild <> nil then begin
    if not IsAllyGuild(Guild) then begin
      WarGuild := nil;
      if GuildWarList.Count > 0 then begin//20080630
        for I := 0 to GuildWarList.Count - 1 do begin
          if pTWarGuild(GuildWarList.Objects[I]).Guild = Guild then begin
            WarGuild := pTWarGuild(GuildWarList.Objects[I]);
            WarGuild.dwWarTick := GetTickCount();
            WarGuild.dwWarTime := g_Config.dwGuildWarTime {10800000};
            SendGuildMsg('==行会信息==：' + Guild.sGuildName + '行会战争将持续三个小时。');
            Break;
          end;
        end;
      end;
      if WarGuild = nil then begin
        New(WarGuild);
        WarGuild.Guild := Guild;
        WarGuild.dwWarTick := GetTickCount();
        WarGuild.dwWarTime := g_Config.dwGuildWarTime {10800000};
        GuildWarList.AddObject(Guild.sGuildName, TObject(WarGuild));
        SendGuildMsg('==行会信息==：' + Guild.sGuildName + '行会战争将持续三个小时。');
      end;
      Result := WarGuild;
    end;
  end;
  RefMemberName();
  UpdateGuildFile();
end;

procedure TGUild.sub_499B4C(Guild: TGUild);
begin
  SendGuildMsg('==行会信息==：' + Guild.sGuildName + '行会战争结束');
end;

function TGUild.GetMemberCount: Integer;
var
  I: Integer;
  GuildRank: pTGuildRank;
begin
  Result := 0;
  if m_RankList.Count > 0 then begin//20080630
    for I := 0 to m_RankList.Count - 1 do begin
      GuildRank := m_RankList.Items[I];
      Inc(Result, GuildRank.MemberList.Count);
    end;
  end;
end;
//判断是否超过行会人数上限
function TGUild.GetMemgerIsFull: Boolean;
begin
  Result := False;
  if GetMemberCount >= m_nGuildMemberCount then begin
    Result := True;
  end;
end;

procedure TGUild.StartTeamFight;
begin
  nContestPoint := 0;
  boTeamFight := True;
  TeamFightDeadList.Clear;
end;

procedure TGUild.EndTeamFight;
begin
  boTeamFight := False;
end;

procedure TGUild.AddTeamFightMember(sHumanName: string);
begin
  TeamFightDeadList.Add(sHumanName);
end;


procedure TGUild.SetAuraePoint(nPoint: Integer);
begin
  m_nAurae := nPoint;
  boChanged := True;
end;

procedure TGUild.SetBuildPoint(nPoint: Integer);
begin
  m_nBuildPoint := nPoint;
  boChanged := True;
end;

procedure TGUild.SetFlourishPoint(nPoint: Integer);
begin
  m_nFlourishing := nPoint;
  boChanged := True;
end;

procedure TGUild.SetStabilityPoint(nPoint: Integer);
begin
  m_nStability := nPoint;
  boChanged := True;
end;
procedure TGUild.SetChiefItemCount(nPoint: Integer);
begin
  m_nChiefItemCount := nPoint;
  boChanged := True;
end;

end.
