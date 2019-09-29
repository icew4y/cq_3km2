unit Division;
{师门单元}
interface
uses
  Windows, SysUtils, Classes, IniFiles, ObjBase;

type
  TDivisionRank = record
    nRankNo: Integer;//排名
    sRankName: string;//职务(掌门、师门弟子)
    MemberList: TStringList;//成员列表
  end;
  pTDivisionRank = ^TDivisionRank;

  TDivision = class//师门类
    nDivisonType: Byte;//师门类型(0-普通师门 1-公共师门)
    sDivisionName: string;//师门名称
    NoticeList: TStringList;//师门公告
    ApplyList: TStringList;//申请列表
    m_RankList: TList; //职位列表
    dwSaveTick: LongWord;//数据保存间隔
    boChanged: Boolean;//是否改变
    m_nDivisionMemberCount: Word;//成员上限
    sHeartName: String;//心法名称
    nHeartTpye: Byte;//心法类型 0-紫金 1-乙木 2-大地 3-葵水 4-阳炎
  private
    m_Config: TIniFile;
    nDivisionPopularity: Integer;//人气值
    nPassHeartLevel: Byte;//传承心法等级
    procedure ClearRank();
    function SetDivisionInfo(PlayObject: TPlayObject; nType: byte): Boolean;//设置师门信息
    function GetMemberCount(): Integer;//取师门人数
    function GetMemgerIsFull(): Boolean;//师门是否满员
    procedure SetChiefPopularity(nPoint: Integer);//设置人气值
    procedure SetChiefPassHeartLevel(nPoint: Byte);//设置心法等级
    procedure SaveDivisionFile(sFileName: string);//保存师门txt文件
  public
    constructor Create(sName: string; nType: Byte);
    destructor Destroy; override;
    function IsMember(sName: string): Boolean;//是否是师门成员
    function LoadDivision(): Boolean;//读取师门数据
    function LoadDivisionConfig(sDivisionFileName: string): Boolean;
    function LoadDivisionFile(sDivisionFileName: string): Boolean;//读取行会文件
    procedure RefMemberName(ssName: String);//刷新成员列表数据
    procedure SaveDivisionInfoFile;//保存师门相关数据
    procedure SaveDivisionConfig(sFileName: string);//保存师门Ini文件
    procedure SendDivisionMsg(sMsg: string);//师门聊天
    function GetChiefName: string;//取师门老大名字
    procedure CheckSaveDivisionFile();//定时保存师门数据
    procedure UpdateDivisionFile();//更新师门数据
    procedure BackupDivisionFile;
    function IsApplyUser(sCharName: String): Boolean;//是否为正在申请过的角色
    function ApplyMember(PlayObject: TPlayObject): Byte;//申请入师门
    function DelApplyMember(sCharName: String): Boolean;//取消门派申请
    function AddMember(PlayObject: TPlayObject;sUserName: String): Boolean;//师门增加成员
    function DelMember(sHumName: string): Boolean;//师门删除成员(成员心法消失)
    function GetMemberContribution(sHumName: string): LongWord;//取玩家门派人气值
    function CancelDivision(sHumName: string): Boolean;//取消门派
    procedure ActivMemberHeart(sUserName: String);//弟子心法激活
    procedure CloseMemberHeart(sUserName: String);//关闭弟子心法
    property Count: Integer read GetMemberCount;
    property IsFull: Boolean read GetMemgerIsFull;
    property nPopularity: Integer read nDivisionPopularity write SetChiefPopularity;
    property nHeartLevel: Byte read nPassHeartLevel write SetChiefPassHeartLevel;
  end;
  TDivisionManager = class//师门管理类
    DivisionList: TList;//行会列表
  private
  public
    constructor Create();
    destructor Destroy; override;
    procedure LoadDivisionInfo();
    procedure SaveDivisionList();
    function LoadUserApplyInfo(sUserName: String):String;//读取玩家正在申请入门的师门名
    procedure SaveUserApplyList(sUserName, sDivisionName: String);//保存申请入门的名单
    function MemberOfDivision(sName: string): TDivision;//查找所属的门派
    function AddDivision(sDivisionName: string;PlayObject: TPlayObject): Boolean;
    function FindDivision(sDivisionName: string): TDivision;//根据门派名查找
    function FindDivisionEx(sChiefName: string): TDivision;//根据宗师名找查门派
    function UpDivisionInfo(sDivisionName: String; HeartTpye, PassHeartLevel: Byte; Popularity: Integer): Boolean;//更新门派相关数据
    function DelDivision(sDivisionName: string): Boolean;
    procedure ClearDivisionInf();
    procedure Run();
  end;
implementation

uses M2Share, HUtil32, StrUtils, Grobal2;

constructor TDivision.Create(sName: string; nType: Byte);
var
  sFileName: string;
begin
  try
    nDivisonType:= nType;
    sDivisionName := sName;
    NoticeList := TStringList.Create;
    ApplyList := TStringList.Create;//申请列表
    m_RankList := TList.Create;
    dwSaveTick := 0;
    boChanged := False;
    nDivisionPopularity:= 0;//人气值
    {$IF M2Version <> 2}
    if nDivisonType = 0 then begin
      m_nDivisionMemberCount:= g_Config.nDivisionMemberCount;//成员上限
      sHeartName:= '';//心法名称
      nHeartTpye:= 0;//心法类型
      nPassHeartLevel:= 1;//传承心法等级
    end else Begin
      m_nDivisionMemberCount:= 65535;//公共师门成员上限
      sHeartName:= '龙卫心法';//心法名称
      nHeartTpye:= 0;//心法类型
      nPassHeartLevel:= g_Config.nPublicHeartLevel;//传承心法等级
    end;
    {$IFEND}
    sFileName := g_Config.sDivisionDir + sName + '.ini';
    if not DirectoryExists(g_Config.sDivisionDir) then ForceDirectories(g_Config.sDivisionDir); //目录不存在,则创建
    m_Config := TIniFile.Create(sFileName);
    if not FileExists(sFileName) then begin
      m_Config.WriteString('Division', 'DivisionName', sName);
    end;
  except
    MainOutMessage(format('{%s} TDivision.Create',[g_sExceptionVer]));
  end;
end;

destructor TDivision.Destroy;
var
  I:Integer;
begin
  NoticeList.Free;
  for I := 0 to ApplyList.Count - 1 do begin
    if pTApplyDivision(ApplyList.Objects[I]) <> nil then Dispose(pTApplyDivision(ApplyList.Objects[I]));
  end;
  ApplyList.Free;//申请列表
  ClearRank();
  m_RankList.Free;
  m_Config.Free;
  inherited;
end;

//清除行会
procedure TDivision.ClearRank;
var
  I, K: Integer;
  DivisionRank: pTDivisionRank;
  DivisionMember: pTDivisionMember;
begin
  try
    if m_RankList.Count > 0 then begin
      for I := 0 to m_RankList.Count - 1 do begin
        DivisionRank := m_RankList.Items[I];
        for K := 0 to DivisionRank.MemberList.Count - 1 do begin
          DivisionMember:= pTDivisionMember(DivisionRank.MemberList.Objects[K]);
          if DivisionMember <> nil then Dispose(DivisionMember);
        end;
        DivisionRank.MemberList.Free;
        Dispose(DivisionRank);
      end; // for
    end;
    m_RankList.Clear;
  except
    MainOutMessage(format('{%s} TDivision.ClearRank',[g_sExceptionVer]));
  end;
end;

//是否是师门成员
function TDivision.IsMember(sName: string): Boolean;
var
  I, II: Integer;
  DivisionRank: pTDivisionRank;
begin
  try
    Result := False;
    for I := 0 to m_RankList.Count - 1 do begin
      DivisionRank := m_RankList.Items[I];
      II:= DivisionRank.MemberList.IndexOf(sName);
      if II > -1 then begin
        Result := True;
        Exit;
      end;
    end;
  except
    MainOutMessage(format('{%s} TDivision.IsMember',[g_sExceptionVer]));
  end;
end;
//读取师门数据
function TDivision.LoadDivision(): Boolean;
var
  sFileName: string;
begin
  try
    sFileName := sDivisionName + '.txt';
    Result := LoadDivisionFile(sFileName);
    LoadDivisionConfig(sDivisionName + '.ini');
  except
    MainOutMessage(format('{%s} TDivision.LoadDivision',[g_sExceptionVer]));
  end;
end;

function TDivision.LoadDivisionConfig(sDivisionFileName: string): Boolean;
begin
  try
    m_nDivisionMemberCount:= m_Config.ReadInteger('Division', 'DivisionMemberCount', m_nDivisionMemberCount);//成员上限
    sHeartName:= m_Config.ReadString('Division', 'HeartName', sHeartName);//心法名称
    nHeartTpye:= m_Config.ReadInteger('Division', 'HeartTpye', nHeartTpye);//心法类型
    nDivisionPopularity:= m_Config.ReadInteger('Division', 'Popularity', nDivisionPopularity);//人气值
    nPassHeartLevel:= m_Config.ReadInteger('Division', 'PassHeartLevel', nPassHeartLevel);//传承心法等级
    Result := True;
  except
    MainOutMessage(format('{%s} TDivision.LoadDivisionConfig',[g_sExceptionVer]));
  end;
end;

//读取师门文件
function TDivision.LoadDivisionFile(sDivisionFileName: string): Boolean;
var
  I, n28, n2C: Integer;
  LoadList: TStringList;
  s18, s1C, s24, sFileName: string;
  DivisionRank: pTDivisionRank;
  DivisionMember: pTDivisionMember;
  ApplyDivision: pTApplyDivision;
  sGender, sJob, sLevel, sContribution, sLogonTime: string;
begin
  Result := False;
  try
    {$IF M2Version <> 2}
    DivisionRank := nil;
    sFileName := g_Config.sDivisionDir + sDivisionFileName;
    if not FileExists(sFileName) then Exit;
    ClearRank();
    NoticeList.Clear;
    ApplyList.Clear;
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
          if s18 = g_Config.sDivisionNotice then n28 := 1;//师门公告
          if s18 = g_Config.sDivisionMember then n28 := 2;//师门成员信息
          if s18 = g_Config.sApplyDivision then n28 := 3;//申请入门
          if s18[1] = '#' then begin
            s18 := Copy(s18, 2, Length(s18) - 1);
            s18 := GetValidStr3(s18, s1C, [' ', ',']);
            n2C := Str_ToInt(s1C, 0);//排名
            s24 := Trim(s18);//职务
            DivisionRank := nil;
          end;
          Continue;
        end;
        s18 := Copy(s18, 2, Length(s18) - 1);
        case n28 of
          1: NoticeList.Add(s18);//师门公告
          2: begin
              if (n2C > 0) and (s24 <> '') then begin
                if Length(s24) > 30 then s24 := Copy(s24, 1, 30);//限制职务的长度
                if Pos('|',s24) > 0 then s24 := AnsiReplaceText(s24, '|', '');//过滤职务带|符号
                if DivisionRank = nil then begin
                  New(DivisionRank);
                  DivisionRank.nRankNo := n2C;
                  DivisionRank.sRankName := s24;
                  DivisionRank.MemberList := TStringList.Create;
                  m_RankList.Add(DivisionRank);
                end;
                if (s18 <> '') then begin
                  s18 := GetValidStr3(s18, s1C, ['|']);//姓名
                  s18 := GetValidStr3(s18, sGender, ['|']);
                  s18 := GetValidStr3(s18, sJob, ['|']);
                  s18 := GetValidStr3(s18, sLevel, ['|']);
                  s18 := GetValidStr3(s18, sContribution, ['|']);
                  s18 := GetValidStr3(s18, sLogonTime, ['|']);
                  if s1C <> '' then begin
                    New(DivisionMember);
                    DivisionMember.btGender:= Str_ToInt(sGender, 0);
                    DivisionMember.btJob:= Str_ToInt(sJob, 0);
                    DivisionMember.nLevel:= Str_ToInt(sLevel, 0);
                    DivisionMember.nContribution:= Str_ToInt(sContribution, 0);
                    DivisionMember.dLogonTime:= Str_ToDate(sLogonTime);
                    DivisionMember.boStatus:= False;
                    DivisionRank.MemberList.AddObject(s1C, TObject(DivisionMember));
                  end;
                end;
              end;
            end;
            3: begin//申请成员
              if (s18 <> '') then begin
                s18 := GetValidStr3(s18, s1C, ['|']);//姓名
                s18 := GetValidStr3(s18, sGender, ['|']);
                s18 := GetValidStr3(s18, sJob, ['|']);
                s18 := GetValidStr3(s18, sLevel, ['|']);
                if s1C <> '' then begin
                  New(ApplyDivision);
                  ApplyDivision.sChrName:= s1C;
                  ApplyDivision.btGender:= Str_ToInt(sGender, 0);
                  ApplyDivision.btJob:= Str_ToInt(sJob, 0);
                  ApplyDivision.nLevel:= Str_ToInt(sLevel, 0);
                  ApplyList.AddObject(s1C, TObject(ApplyDivision));
                end;
              end;
            end;//3
        end; // case
      end;
    finally
      LoadList.Free;
    end;
    Result := True;
    {$IFEND}
  except
    MainOutMessage(format('{%s} TDivision.LoadDivisionFile',[g_sExceptionVer]));
  end;
end;
//弟子心法激活
procedure TDivision.ActivMemberHeart(sUserName: String);
var
  I, II: Integer;
  DivisionRank: pTDivisionRank;
  nCode: Byte;
  PlayObject: TPlayObject;
  sName: String;
begin
  {$IF M2Version <> 2}
  try
    if m_RankList.Count > 0 then begin
      nCode:=1;
      for I := 0 to m_RankList.Count - 1 do begin
        nCode:= 2;
        DivisionRank := m_RankList.Items[I];
        nCode:=3;
        if DivisionRank <> nil then begin
          nCode:=4;
          if DivisionRank.MemberList.Count > 0 then begin
            nCode:=5;
            for II := DivisionRank.MemberList.Count - 1 downto 0 do begin
              sName:= DivisionRank.MemberList.Strings[II];
              if CompareText(sUserName, sName) <> 0 then begin
                PlayObject := UserEngine.GetPlayObjectEx1(sName);
                nCode:=6;
                if PlayObject <> nil then begin
                  if (PlayObject.m_MagicSkill_106 <> nil) and (PlayObject.m_MagicSkill_105 = nil)
                    and (PlayObject.m_wStatusArrValue[21] = 0) then begin
                    PlayObject.DiscipleHeartUpAbility();//弟子心法激活
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  except
    MainOutMessage(Format('{%s} TDivision.ActivMemberHeart Code:%d', [g_sExceptionVer, nCode]));
  end;
  {$IFEND}
end;

//关闭弟子心法
procedure TDivision.CloseMemberHeart(sUserName: String);
var
  I, II: Integer;
  DivisionRank: pTDivisionRank;
  nCode: Byte;
  PlayObject: TPlayObject;
  sName: String;
begin
  {$IF M2Version <> 2}
  try
    if m_RankList.Count > 0 then begin
      nCode:=1;
      for I := 0 to m_RankList.Count - 1 do begin
        nCode:= 2;
        DivisionRank := m_RankList.Items[I];
        nCode:=3;
        if DivisionRank <> nil then begin
          nCode:=4;
          if DivisionRank.MemberList.Count > 0 then begin
            nCode:=5;
            for II :=DivisionRank.MemberList.Count - 1 downto 0 do begin
              sName:= DivisionRank.MemberList.Strings[II];
              if CompareText(sUserName, sName) <> 0 then begin
                PlayObject := UserEngine.GetPlayObjectEx1(sName);
                nCode:=6;
                if PlayObject <> nil then begin
                  if (PlayObject.m_MagicSkill_106 <> nil) and (PlayObject.m_MagicSkill_105 = nil)
                    and (PlayObject.m_wStatusArrValue[21] > 0) then begin
                    PlayObject.m_dwStatusArrTimeOutTick[21]:= 0;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  except
    MainOutMessage(Format('{%s} TDivision.CloseMemberHeart Code:%d', [g_sExceptionVer, nCode]));
  end;
  {$IFEND}
end;

//刷新成员列表数据
procedure TDivision.RefMemberName(ssName: String);
var
  I, II: Integer;
  DivisionRank: pTDivisionRank;
  DivisionMember: pTDivisionMember;
  nCode: Byte;
  sName: String;
  PlayObject: TPlayObject;
begin
  nCode:=0;
  {$IF M2Version <> 2}
  try
    if m_RankList.Count > 0 then begin
      nCode:=1;
      for I := 0 to m_RankList.Count - 1 do begin
        nCode:= 2;
        DivisionRank := m_RankList.Items[I];
        nCode:=3;
        if DivisionRank <> nil then begin
          nCode:=4;
          if DivisionRank.MemberList.Count > 0 then begin
            nCode:=5;
            if sName = '' then begin//全部更新
              for II := 0 to DivisionRank.MemberList.Count - 1 do begin
                sName:= DivisionRank.MemberList.Strings[II];
                PlayObject := UserEngine.GetPlayObjectEx1(sName);
                nCode:=6;
                if PlayObject <> nil then begin
                  if not PlayObject.m_boGhost then begin
                    DivisionMember:= pTDivisionMember(DivisionRank.MemberList.Objects[II]);
                    nCode:=7;
                    DivisionMember.btGender:= PlayObject.m_btGender;
                    DivisionMember.btJob:= PlayObject.m_btJob;
                    DivisionMember.nLevel:= PlayObject.m_Abil.Level;
                    DivisionMember.nContribution:= PlayObject.m_Contribution;//贡献值
                    DivisionMember.dLogonTime:= Date();
                    DivisionMember.boStatus:= True;
                  end else begin
                    DivisionMember:= pTDivisionMember(DivisionRank.MemberList.Objects[II]);
                    DivisionMember.boStatus:= False;
                  end;
                end else begin
                  DivisionMember:= pTDivisionMember(DivisionRank.MemberList.Objects[II]);
                  DivisionMember.boStatus:= False;
                end;
              end;
              UpdateDivisionFile();
            end else begin
              II:= DivisionRank.MemberList.IndexOf(ssName);
              if II > -1 then begin
                UpdateDivisionFile();
                PlayObject := UserEngine.GetPlayObjectEx1(ssName);
                if PlayObject <> nil then begin
                  if not PlayObject.m_boGhost then begin
                    DivisionMember:= pTDivisionMember(DivisionRank.MemberList.Objects[II]);
                    nCode:=7;
                    DivisionMember.btGender:= PlayObject.m_btGender;
                    DivisionMember.btJob:= PlayObject.m_btJob;
                    DivisionMember.nLevel:= PlayObject.m_Abil.Level;
                    DivisionMember.nContribution:= PlayObject.m_Contribution;//贡献值
                    DivisionMember.dLogonTime:= Date();
                    DivisionMember.boStatus:= True;
                  end else begin
                    DivisionMember:= pTDivisionMember(DivisionRank.MemberList.Objects[II]);
                    DivisionMember.boStatus:= False;
                  end;
                end else begin
                  DivisionMember:= pTDivisionMember(DivisionRank.MemberList.Objects[II]);
                  DivisionMember.boStatus:= False;
                end;
                Break;
              end;
            end;
          end;
        end;
      end;
    end;
  except
    MainOutMessage(Format('{%s} TDivision.RefMemberName Code:%d', [g_sExceptionVer, nCode]));
  end;
  {$IFEND}
end;

procedure TDivision.SaveDivisionInfoFile;
begin
  try
    SaveDivisionFile(g_Config.sDivisionDir + sDivisionName + '.txt');
    SaveDivisionConfig(g_Config.sDivisionDir + sDivisionName + '.ini');
  except
    MainOutMessage(format('{%s} TDivision.SaveDivisionInfoFile',[g_sExceptionVer]));
  end;
end;

procedure TDivision.SaveDivisionConfig(sFileName: string);
begin
  try
    m_Config.WriteString('Division', 'DivisionName', sDivisionName);
    m_Config.WriteInteger('Division', 'DivisionMemberCount', m_nDivisionMemberCount);//成员上限
    m_Config.WriteString('Division', 'HeartName', sHeartName);//心法名称
    m_Config.WriteInteger('Division', 'HeartTpye', nHeartTpye);//心法类型
    m_Config.WriteInteger('Division', 'Popularity', nDivisionPopularity);//人气值
    m_Config.WriteInteger('Division', 'PassHeartLevel', nPassHeartLevel);//传承心法等级
  except
    MainOutMessage(format('{%s} TDivision.SaveDivisionConfig',[g_sExceptionVer]));
  end;
end;

procedure TDivision.SaveDivisionFile(sFileName: string);
var
  SaveList: TStringList;
  I, II: Integer;
  DivisionRank: pTDivisionRank;
  DivisionMember: pTDivisionMember;
  ApplyDivision: pTApplyDivision;
begin
  try
    {$IF M2Version <> 2}
    SaveList := TStringList.Create;
    try
      SaveList.Add(g_Config.sDivisionNotice);//师门公告
      for I := 0 to NoticeList.Count - 1 do begin
        SaveList.Add('+' + NoticeList.Strings[I]);
      end;
      SaveList.Add(' ');
      SaveList.Add(g_Config.sDivisionMember);

      for I := 0 to m_RankList.Count - 1 do begin
        DivisionRank := m_RankList.Items[I];
        SaveList.Add('#' + IntToStr(DivisionRank.nRankNo) + ' ' + DivisionRank.sRankName);
        for II := 0 to DivisionRank.MemberList.Count - 1 do begin
          DivisionMember:= pTDivisionMember(DivisionRank.MemberList.Objects[II]);
          if DivisionMember <> nil then
            SaveList.Add(Format('+%s|%d|%d|%d|%d|%s|',[DivisionRank.MemberList.Strings[II],
                         DivisionMember.btGender, DivisionMember.btJob, DivisionMember.nLevel,
                         DivisionMember.nContribution, {DateToStr(DivisionMember.dLogonTime)}
                         FormatDatetime('yyyy-mm-dd',DivisionMember.dLogonTime)]));
        end;
      end;

      SaveList.Add(' ');
      SaveList.Add(g_Config.sApplyDivision);
      for I := 0 to ApplyList.Count - 1 do begin
        ApplyDivision:= pTApplyDivision(ApplyList.Objects[I]);
        if ApplyDivision <> nil then
          SaveList.Add(Format('+%s|%d|%d|%d|',[ApplyDivision.sChrName,
                       ApplyDivision.btGender, ApplyDivision.btJob, ApplyDivision.nLevel]));
      end;
      try
        SaveList.SaveToFile(sFileName);
      except
        MainOutMessage('保存师门信息失败！！！ ' + sFileName);
      end;
    finally
      SaveList.Free;
    end;
    {$IFEND}
  except
    MainOutMessage(format('{%s} TDivision.SaveDivisionFile',[g_sExceptionVer]));
  end;
end;

//师门聊天
procedure TDivision.SendDivisionMsg(sMsg: string);
var
  I, II: Integer;
  DivisionRank: pTDivisionRank;
  PlayObject: TPlayObject;
  nCheckCode: Integer;
  sName: String;
begin
  {$IF M2Version <> 2}
  nCheckCode := 0;
  try
    if g_Config.boShowPreFixMsg then sMsg := g_Config.sDivisionMsgPreFix + sMsg;
    nCheckCode := 1;
    if m_RankList.Count > 0 then begin
      for I := 0 to m_RankList.Count - 1 do begin
        DivisionRank := m_RankList.Items[I];
        nCheckCode := 2;
        if DivisionRank.MemberList = nil then Continue;
        if DivisionRank.MemberList.Count > 0 then begin
          for II := 0 to DivisionRank.MemberList.Count - 1 do begin
            nCheckCode := 3;
            sName:= DivisionRank.MemberList.Strings[II];
            PlayObject := UserEngine.GetPlayObjectEx1(sName);
            if (PlayObject = nil) or (PlayObject.m_boNotOnlineAddExp) or (PlayObject.m_boAI) then Continue;
            nCheckCode := 4;
            PlayObject.SendMsg(PlayObject, RM_DIVISIONMESSAGE, 0, g_Config.btDivisionMsgFColor, g_Config.btDivisionMsgBColor, 0, sMsg);
          end;//for
        end;
      end;
    end;
  except
    on E: Exception do begin
      MainOutMessage(Format('{%s} TDivision.SendDivisionMsg CheckCode:%d DivisionName:%s Msg:%s', [g_sExceptionVer, nCheckCode, sDivisionName, sMsg]));
    end;
  end;
  {$IFEND}
end;

//设置师门信息
function TDivision.SetDivisionInfo(PlayObject: TPlayObject; nType: byte): Boolean;
var
  DivisionRank: pTDivisionRank;
  DivisionMember: pTDivisionMember;
begin
  try
    if m_RankList.Count = 0 then begin
      New(DivisionRank);
      DivisionRank.nRankNo := 1;//老大
      {$IF M2Version <> 2}
      DivisionRank.sRankName := g_Config.sDivisionChief;//掌门
      {$IFEND}
      DivisionRank.MemberList := TStringList.Create;
      if nType = 0 then begin
        New(DivisionMember);
        DivisionMember.btGender:= PlayObject.m_btGender;
        DivisionMember.btJob:= PlayObject.m_btJob;
        DivisionMember.nLevel:= PlayObject.m_Abil.Level;
        DivisionMember.nContribution:= 0;//贡献值
        DivisionMember.dLogonTime:= Date();
        DivisionMember.boStatus:= True;
        DivisionRank.MemberList.AddObject(PlayObject.m_sCharName, TObject(DivisionMember));
      end else begin
        New(DivisionMember);
        DivisionMember.btGender:= 0;
        DivisionMember.btJob:= 0;
        DivisionMember.nLevel:= 65535;
        DivisionMember.nContribution:= 0;//贡献值
        DivisionMember.dLogonTime:= Date();
        DivisionRank.MemberList.AddObject('*公共师门', TObject(DivisionMember));
      end;
      m_RankList.Add(DivisionRank);
      SaveDivisionInfoFile();
    end;
    Result := True;
  except
    MainOutMessage(format('{%s} TDivision.SetDivisionInfo',[g_sExceptionVer]));
  end;
end;

//取师门老大名字
function TDivision.GetChiefName: string;
var
  DivisionRank: pTDivisionRank;
begin
  Result := '';
  try
    if m_RankList.Count <= 0 then Exit;
    DivisionRank := m_RankList.Items[0];
    if DivisionRank.MemberList.Count <= 0 then Exit;
    Result := DivisionRank.MemberList.Strings[0];
  except
    MainOutMessage(format('{%s} TDivision.GetChiefName',[g_sExceptionVer]));
  end;
end;
//定时保存师门数据
procedure TDivision.CheckSaveDivisionFile();
begin
  if boChanged and ((GetTickCount - dwSaveTick) > 30000{30 * 1000}) then begin
    boChanged := False;
    SaveDivisionInfoFile();
  end;
end;

//更新师门数据
procedure TDivision.UpdateDivisionFile();
begin
  boChanged := True;
  dwSaveTick := GetTickCount();
  //SaveDivisionInfoFile();
end;

procedure TDivision.BackupDivisionFile;
var
  I, II: Integer;
  PlayObject: TPlayObject;
  DivisionRank: pTDivisionRank;
  sName: String;
begin
  try
    if nServerIndex = 0 then
      SaveDivisionFile(g_Config.sDivisionDir + sDivisionName + '.' + IntToStr(GetTickCount) + '.bak');
    if m_RankList.Count > 0 then begin
      for I := 0 to m_RankList.Count - 1 do begin
        DivisionRank := m_RankList.Items[I];
        if DivisionRank.MemberList.Count > 0 then begin
          for II := 0 to DivisionRank.MemberList.Count - 1 do begin
            sName:= DivisionRank.MemberList.Strings[II];
            PlayObject := UserEngine.GetPlayObjectEx1(sName);
            if PlayObject <> nil then begin
              {$IF M2Version <> 2}
              PlayObject.m_MyDivision := nil;
              {$IFEND}
            end;
          end;
        end;
        DivisionRank.MemberList.Free;
        Dispose(DivisionRank);
      end;
    end;
    m_RankList.Clear;
    NoticeList.Clear;
    ApplyList.Clear;
    SaveDivisionInfoFile();
  except
    MainOutMessage(format('{%s} TDivision.BackupDivisionFile',[g_sExceptionVer]));
  end;
end;
//是否为正在申请过的角色
function TDivision.IsApplyUser(sCharName: String): Boolean;
begin
  Result := ApplyList.IndexOf(sCharName) > -1;
end;
//申请入师门
function TDivision.ApplyMember(PlayObject: TPlayObject): Byte;
var
  I: Integer;
  ApplyDivision: pTApplyDivision;
begin
  Result := 0;
  try
    {$IF M2Version <> 2}
    if nDivisonType <> 1 then begin//不是公共门派
      I:= ApplyList.IndexOf(PlayObject.m_sCharName);
      if I = -1 then begin
        New(ApplyDivision);
        ApplyDivision.sChrName:= PlayObject.m_sCharName;
        ApplyDivision.btGender:= PlayObject.m_btGender;
        ApplyDivision.btJob:= PlayObject.m_btJob;
        ApplyDivision.nLevel:= PlayObject.m_Abil.Level;
        ApplyList.AddObject(ApplyDivision.sChrName, TObject(ApplyDivision));
        SaveDivisionFile(g_Config.sDivisionDir + sDivisionName + '.txt');
        Result := 1;
      end;
    end else begin//公共门派直接加入门派
      if AddMember(PlayObject, PlayObject.m_sCharName) then begin
        Result := 2;
        PlayObject.m_MyDivision := Self;
        PlayObject.SysMsg(Format('%s同意了你的入派的请求',[sDivisionName]), c_Green, t_Hint);
      end;
    end;
    {$IFEND}
  except
    MainOutMessage(format('{%s} TDivision.ApplyMember',[g_sExceptionVer]));
  end;
end;
//取消门派申请
function TDivision.DelApplyMember(sCharName: String): Boolean;
var
  I: Integer;
  ApplyDivision: pTApplyDivision;
begin
  Result := False;
  try
    if nDivisonType <> 1 then begin//不是公共门派
      I:= ApplyList.IndexOf(sCharName);
      if I > -1 then begin
        ApplyDivision:= pTApplyDivision(ApplyList.Objects[I]);
        if ApplyDivision <> nil then begin
          ApplyList.Delete(I);
          Dispose(ApplyDivision);
          Result := True;
        end;
        SaveDivisionFile(g_Config.sDivisionDir + sDivisionName + '.txt');
      end;
    end;
  except
    MainOutMessage(format('{%s} TDivision.DelApplyMember',[g_sExceptionVer]));
  end;
end;
//师门增加成员
function TDivision.AddMember(PlayObject: TPlayObject;sUserName: String): Boolean;
var
  I: Integer;
  DivisionRank, DivisionRank18: pTDivisionRank;
  DivisionMember: pTDivisionMember;
  ApplyDivision: pTApplyDivision;
begin
  Result := False;
  try
    DivisionRank18 := nil;
    if m_RankList.Count > 0 then begin
      for I := 0 to m_RankList.Count - 1 do begin
        DivisionRank := m_RankList.Items[I];
        if DivisionRank.nRankNo = 99 then begin
          DivisionRank18 := DivisionRank;
          Break;
        end;
      end;
    end;
    if DivisionRank18 = nil then begin
      New(DivisionRank18);
      DivisionRank18.nRankNo := 99;
      {$IF M2Version <> 2}
      DivisionRank18.sRankName := g_Config.sDivisionMember;
      {$IFEND}
      DivisionRank18.MemberList := TStringList.Create;
      m_RankList.Add(DivisionRank18);
    end;

    if PlayObject <> nil then begin
      New(DivisionMember);
      DivisionMember.btGender:= PlayObject.m_btGender;
      DivisionMember.btJob:= PlayObject.m_btJob;
      DivisionMember.nLevel:= PlayObject.m_Abil.Level;
      DivisionMember.nContribution:= 0;//贡献值
      DivisionMember.dLogonTime:= Date();
      DivisionMember.boStatus:= True;
      DivisionRank18.MemberList.AddObject(sUserName, TObject(DivisionMember));
      SaveDivisionInfoFile();//更新师门文件
      Result := True;
    end else begin//角色未在线
      I:= ApplyList.IndexOf(sUserName);
      if I > -1 then begin
        ApplyDivision:= pTApplyDivision(ApplyList.Objects[I]);
        if ApplyDivision <> nil then begin
          New(DivisionMember);
          DivisionMember.btGender:= ApplyDivision.btGender;
          DivisionMember.btJob:= ApplyDivision.btJob;
          DivisionMember.nLevel:= ApplyDivision.nLevel;
          DivisionMember.nContribution:= 0;//贡献值
          DivisionMember.dLogonTime:= Date();
          DivisionMember.boStatus:= False;
          DivisionRank18.MemberList.AddObject(sUserName, TObject(DivisionMember));
          SaveDivisionInfoFile();//更新师门文件
          Result := True;
        end;
      end;
    end;
  except
    MainOutMessage(format('{%s} TDivision.AddMember',[g_sExceptionVer]));
  end;
end;

//师门删除成员
function TDivision.DelMember(sHumName: string): Boolean;
var
  I, II: Integer;
  DivisionRank: pTDivisionRank;
  DivisionMember: pTDivisionMember;
begin
  Result := False;
  try
    for I := 0 to m_RankList.Count - 1 do begin
      DivisionRank := m_RankList.Items[I];
      II:= DivisionRank.MemberList.IndexOf(sHumName);
      if II > -1 then begin
        DivisionMember:= pTDivisionMember(DivisionRank.MemberList.Objects[II]);
        DivisionRank.MemberList.Delete(II);
        if DivisionMember <> nil then Dispose(DivisionMember);
        Result := True;
        Break;
      end;
      {for II := DivisionRank.MemberList.Count - 1 downto 0 do begin
        if DivisionRank.MemberList.Count <= 0 then Break;
        if DivisionRank.MemberList.Strings[II] = sHumName then begin
          DivisionMember:= pTDivisionMember(DivisionRank.MemberList.Objects[II]);
          DivisionRank.MemberList.Delete(II);
          if DivisionMember <> nil then Dispose(DivisionMember);
          Result := True;
          Break;
        end;
      end;
      if Result then Break; }
    end;
    if Result then UpdateDivisionFile;
  except
    MainOutMessage(format('{%s} TDivision.DelMember',[g_sExceptionVer]));
  end;
end;
//取玩家门派人气值
function TDivision.GetMemberContribution(sHumName: string): LongWord;
var
  I, II: Integer;
  DivisionRank: pTDivisionRank;
  DivisionMember: pTDivisionMember;
begin
  Result := 0;
  try
    for I := 0 to m_RankList.Count - 1 do begin
      DivisionRank := m_RankList.Items[I];
      II:= DivisionRank.MemberList.IndexOf(sHumName);
      if II > -1 then begin
        DivisionMember:= pTDivisionMember(DivisionRank.MemberList.Objects[II]);
        if DivisionMember <> nil then Result := DivisionMember.nContribution;
        Exit;
      end;
    end;
  except
    MainOutMessage(format('{%s} TDivision.GetMemberContribution',[g_sExceptionVer]));
  end;
end;
//取消门派
function TDivision.CancelDivision(sHumName: string): Boolean;
var
  DivisionRank: pTDivisionRank;
begin
  Result := False;
  try
    if GetMemberCount <> 1 then Exit;//人员大于1人则不能解散
    DivisionRank := m_RankList.Items[0];
    if DivisionRank.MemberList.Strings[0] = sHumName then begin
      Result := True;
    end;
  except
    MainOutMessage(format('{%s} TDivision.CancelDivision',[g_sExceptionVer]));
  end;
end;

function TDivision.GetMemberCount: Integer;
var
  I: Integer;
  DivisionRank: pTDivisionRank;
begin
  Result := 0;
  try
    if m_RankList.Count > 0 then begin
      for I := 0 to m_RankList.Count - 1 do begin
        DivisionRank := m_RankList.Items[I];
        Inc(Result, DivisionRank.MemberList.Count);
      end;
    end;
  except
    MainOutMessage(format('{%s} TDivision.GetMemberCount',[g_sExceptionVer]));
  end;
end;
//判断是否超过人数上限
function TDivision.GetMemgerIsFull: Boolean;
begin
  Result := False;
  if GetMemberCount >= m_nDivisionMemberCount then begin
    Result := True;
  end;
end;

procedure TDivision.SetChiefPopularity(nPoint: Integer);
begin
  nDivisionPopularity := nPoint;
  boChanged := True;
end;

procedure TDivision.SetChiefPassHeartLevel(nPoint: Byte);
begin
  nPassHeartLevel := nPoint;
  boChanged := True;
end;

{ TDivisionManager }
//新建师门
function TDivisionManager.AddDivision(sDivisionName: string; PlayObject: TPlayObject): Boolean;
var
  Division: TDivision;
begin
  Result := False;
  try
    if CheckGuildName(sDivisionName) and (FindDivision(sDivisionName) = nil) and (sDivisionName <> '') then begin
      Division := TDivision.Create(sDivisionName, 0);
      Division.SetDivisionInfo(PlayObject, 0);
      {$IF M2Version <> 2}
      Division.m_nDivisionMemberCount:= g_Config.nDivisionMemberCount;//成员上限
      if PlayObject.m_MagicSkill_105 <> nil then begin
        if PlayObject.m_sHeartName <> '' then
          Division.sHeartName:= PlayObject.m_sHeartName
        else Division.sHeartName:= PlayObject.m_MagicSkill_105.MagicInfo.sMagicName;//心法名称
        Division.nHeartTpye:= PlayObject.m_nHeartType;//心法类型 0-紫金 1-乙木 2-大地 3-葵水 4-阳炎
        Case PlayObject.m_MagicSkill_105.btLevel of //传承心法等级
          1..4: Division.nHeartLevel:= 1;
          5..9: Division.nHeartLevel:= 2;
          10..19: Division.nHeartLevel:= 3;
          20..29: Division.nHeartLevel:= 4;
          30..39: Division.nHeartLevel:= 5;
          40..49: Division.nHeartLevel:= 6;
          50..59: Division.nHeartLevel:= 7;
          60..69: Division.nHeartLevel:= 8;
          70..100: Division.nHeartLevel:= 9;
        end;
      end;
      {$IFEND}
      DivisionList.Add(Division);
      SaveDivisionList();
      Result := True;
    end;
  except
    MainOutMessage(format('{%s} TDivisionManager.AddDivision',[g_sExceptionVer]));
  end;
end;
//删除行会
function TDivisionManager.DelDivision(sDivisionName: string): Boolean;
var
  I: Integer;
  Division: TDivision;
begin
  Result := False;
  try
    for I := DivisionList.Count - 1 downto 0 do begin
      if DivisionList.Count <= 0 then Break;
      Division := TDivision(DivisionList.Items[I]);
      if CompareText(Division.sDivisionName, sDivisionName) = 0 then begin
        //if Division.m_RankList.Count > 1 then Break;
        Division.BackupDivisionFile();
        DivisionList.Delete(I);
        Division.Free;
        SaveDivisionList();
        Result := True;
        Break;
      end;
    end;
  except
    MainOutMessage(format('{%s} TDivisionManager.DelDivision',[g_sExceptionVer]));
  end;
end;

procedure TDivisionManager.ClearDivisionInf;
var
  I: Integer;
begin
  try
    if DivisionList.Count > 0 then begin
      for I := 0 to DivisionList.Count - 1 do begin
        TDivision(DivisionList.Items[I]).Free;
      end;
    end;
    DivisionList.Clear;
  except
    MainOutMessage(format('{%s} TDivisionManager.ClearDivisionInf',[g_sExceptionVer]));
  end;
end;

constructor TDivisionManager.Create;
begin
  DivisionList:= TList.Create;
end;

destructor TDivisionManager.Destroy;
begin
  ClearDivisionInf;
  DivisionList.Free;
  inherited;
end;
//更新门派相关数据
function TDivisionManager.UpDivisionInfo(sDivisionName: String; HeartTpye, PassHeartLevel: Byte; Popularity: Integer): Boolean;
var
  Division: TDivision;
begin
  Result := False;
  try
    Division:= FindDivision(sDivisionName);
    if Division <> nil then begin
      Division.nHeartTpye:= HeartTpye;
      Division.nHeartLevel:= PassHeartLevel;
      Division.nPopularity:= Popularity;
      Division.SaveDivisionConfig(g_Config.sDivisionDir + Division.sDivisionName + '.ini');
      Result := True;
    end;
  except
    MainOutMessage(format('{%s} TDivisionManager.UpDivisionInfo',[g_sExceptionVer]));
  end;
end;
//查找师门
function TDivisionManager.FindDivision(sDivisionName: string): TDivision;
var
  I: Integer;
begin
  Result := nil;
  try
    if DivisionList.Count > 0 then begin
      for I := 0 to DivisionList.Count - 1 do begin
        if TDivision(DivisionList.Items[I]).sDivisionName = sDivisionName then begin
          Result := TDivision(DivisionList.Items[I]);
          Break;
        end;
      end;
    end;
  except
    MainOutMessage(format('{%s} TDivisionManager.FindDivision',[g_sExceptionVer]));
  end;
end;
//根据宗师名找查门派
function TDivisionManager.FindDivisionEx(sChiefName: string): TDivision;
var
  I: Integer;
begin
  Result := nil;
  try
    if DivisionList.Count > 0 then begin
      for I := 0 to DivisionList.Count - 1 do begin
        if TDivision(DivisionList.Items[I]).GetChiefName = sChiefName then begin
          Result := TDivision(DivisionList.Items[I]);
          Break;
        end;
      end;
    end;
  except
    MainOutMessage(format('{%s} TDivisionManager.FindDivisionEx',[g_sExceptionVer]));
  end;
end;

procedure TDivisionManager.LoadDivisionInfo;
var
  LoadList: TStringList;
  Division: TDivision;
  sDivisionName: string;
  I: Integer;
begin
  try
    {$IF M2Version <> 2}
    if FileExists(g_Config.sDivisionFile) then begin
      try
        LoadList := TStringList.Create;
        try
          LoadList.LoadFromFile(g_Config.sDivisionFile);
          if LoadList.Count > 0 then begin
            for I := 0 to LoadList.Count - 1 do begin
              sDivisionName := Trim(LoadList.Strings[I]);
              if sDivisionName <> '' then begin
                if CompareText(sDivisionName, '公共师门')= 0 then
                  Division := TDivision.Create(sDivisionName, 1)
                else Division := TDivision.Create(sDivisionName, 0);
                DivisionList.Add(Division);
              end;
            end;
          end else begin//20111006 增加
            Division := TDivision.Create('公共师门', 1);
            Division.SetDivisionInfo(nil, 1);
            Division.sHeartName:= '龙卫心法';//心法名称
            Division.nHeartTpye:= 0;//心法类型 0-紫金 1-乙木 2-大地 3-葵水 4-阳炎
            Division.nHeartLevel:= g_Config.nPublicHeartLevel;//传承心法等级
            DivisionList.Add(Division);
            SaveDivisionList;
            MainOutMessage('已读取 ' + IntToStr(DivisionList.Count) + '个师门信息...');
          end;
        finally
          LoadList.Free;
        end;
        for I := DivisionList.Count - 1 downto 0 do begin
          if DivisionList.Count <= 0 then Break;
          Division := DivisionList.Items[I];
          if not Division.LoadDivision() then begin
            MainOutMessage(Division.sDivisionName + ' 读取出错！！！');
            Division.Free;
            DivisionList.Delete(I);
            SaveDivisionList();
          end;
        end;
        MainOutMessage('已读取 ' + IntToStr(DivisionList.Count) + '个师门信息...');
      except
        on E: Exception do MainOutMessage('读取师门信息文件['+g_Config.sDivisionFile+']异常！'+ E.Message);
      end;
    end else begin
      Division := TDivision.Create('公共师门', 1);
      Division.SetDivisionInfo(nil, 1);
      Division.sHeartName:= '龙卫心法';//心法名称
      Division.nHeartTpye:= 0;//心法类型 0-紫金 1-乙木 2-大地 3-葵水 4-阳炎
      Division.nHeartLevel:= g_Config.nPublicHeartLevel;//传承心法等级
      DivisionList.Add(Division);
      SaveDivisionList;
      MainOutMessage('已读取 ' + IntToStr(DivisionList.Count) + '个师门信息...');
    end;
    {$IFEND}
  except
    MainOutMessage(format('{%s} TDivisionManager.LoadDivisionInfo',[g_sExceptionVer]));
  end;
end;
//取玩家所属的师门
function TDivisionManager.MemberOfDivision(sName: string): TDivision;
var
  I: Integer;
begin
  Result := nil;
  try
    if DivisionList.Count > 0 then begin
      for I := 0 to DivisionList.Count - 1 do begin
        if TDivision(DivisionList.Items[I]).IsMember(sName) then begin
          Result := TDivision(DivisionList.Items[I]);
          Break;
        end;
      end;
    end;
  except
    MainOutMessage(format('{%s} TDivisionManager.MemberOfDivision',[g_sExceptionVer]));
  end;
end;

procedure TDivisionManager.SaveDivisionList;
var
  I: Integer;
  SaveList: TStringList;
begin
  try
    if nServerIndex <> 0 then Exit;
    SaveList := TStringList.Create;
    try
      if DivisionList.Count > 0 then begin
        for I := 0 to DivisionList.Count - 1 do begin
          SaveList.Add(TDivision(DivisionList.Items[I]).sDivisionName);
        end; // for
      end;
      try
        SaveList.SaveToFile(g_Config.sDivisionFile);
      except
        MainOutMessage('师门信息保存失败！！！');
      end;
    finally
      SaveList.Free;
    end;
  except
    MainOutMessage(format('{%s} TDivisionManager.SaveDivisionList',[g_sExceptionVer]));
  end;
end;
//读取玩家正在申请入门的师门名
function TDivisionManager.LoadUserApplyInfo(sUserName: String):String;
var
  IniFile: TIniFile;
  Division: TDivision;
  nName: String;
begin
  Result := '';
  try
    if FileExists(g_Config.sApplyDivisionFile) then begin
      IniFile := TIniFile.Create(g_Config.sApplyDivisionFile);
      try
        nName:= IniFile.ReadString(sUserName,'申请入门', '');
        if nName <> '' then begin
          Division:= FindDivision(nName);
          if Division <> nil then Result := nName;
        end;
      finally
        IniFile.free;
      end;
    end;
  except
    MainOutMessage(format('{%s} TDivisionManager.LoadUserApplyInfo',[g_sExceptionVer]));
  end;
end;
//保存申请入门的名单
procedure TDivisionManager.SaveUserApplyList(sUserName, sDivisionName: String);
var
  IniFile: TIniFile;
begin
  IniFile := TIniFile.Create(g_Config.sApplyDivisionFile);
  try
    IniFile.WriteString(sUserName, '申请入门', sDivisionName);
  finally
    IniFile.Free;
  end;
end;

procedure TDivisionManager.Run;
var
  I: Integer;
  Division: TDivision;
begin
  try
    if DivisionList.Count > 0 then begin
      for I := 0 to DivisionList.Count - 1 do begin
        Division := TDivision(DivisionList.Items[I]);
        if Division <> nil then Division.CheckSaveDivisionFile;
      end;
    end;
  except
    MainOutMessage(Format('{%s} TDivisionManager.Run', [g_sExceptionVer]));
  end;
end;

end.
