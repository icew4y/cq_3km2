unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, StrUtils, Mask, RzEdit, RzBtnEdt,
  RzLabel, RzShellDialogs, Mudutil, ImageHlp, DB, DBTables;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label1: TLabel;
    Edit1: TEdit;
    SpeedButton1: TSpeedButton;
    GroupBox3: TGroupBox;
    Label9: TLabel;
    SpeedButton4: TSpeedButton;
    Mir_db1: TEdit;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label6: TLabel;
    Memo1: TMemo;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    Label15: TLabel;
    Button1: TButton;
    RzSelectFolderDialog1: TRzSelectFolderDialog;
    Label2: TLabel;
    Edit2: TEdit;
    SpeedButton2: TSpeedButton;
    Button3: TButton;
    Label4: TLabel;
    procedure SpeedButton1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure TabSheet1ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure MirAllone;//转换人物数据
    procedure HeroMirAllone;//转换副将数据
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses FileCtrl, MirDB, UniTypes;
{$R *.dfm}

procedure TForm1.SpeedButton1Click(Sender: TObject);
var
  s: string;
begin
  if SelectDirectory('选择路径...', '', S) then
    Edit1.Text  := S;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
  opendialog1.filter:='数据文件(*.DB)|*.DB';
  if opendialog1.Execute then begin
   Edit2.Text:=opendialog1.filename;
  end;
end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
begin
  opendialog1.filter:='数据文件(*.DB)|*.DB';
  if opendialog1.Execute then begin
   Mir_db1.Text:=opendialog1.filename;
  end;
end;

procedure TForm1.TabSheet1ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin

end;

//查找指定文件 20080912
function FindFile2(AList: TStrings; const APath: TFileName;
  const Ext: String; const Recurisive: Boolean): Integer;
var
  FSearchRec: TSearchRec;
  FPath: TFileName;
begin
  Result := -1;
  application.ProcessMessages;
  if Assigned(AList) then
  try
    FPath := IncludeTrailingPathDelimiter(APath);
    if FindFirst(FPath + '*.*', faAnyFile, FSearchRec) = 0 then
      repeat
        if (FSearchRec.Attr and faDirectory) = faDirectory then begin
          if Recurisive and (FSearchRec.Name <> '.') and (FSearchRec.Name <> '..') then
            FindFile2(AList, FPath + FSearchRec.Name, Ext, Recurisive);
          if SameText(Ext, FSearchRec.Name) then begin
            AList.Add(FPath + FSearchRec.Name);
          end;
        end else
        if SameText(LowerCase(Ext), LowerCase(ExtractFileName(FSearchRec.Name))) then begin
          AList.Add(FPath + FSearchRec.Name);
        end;
      until FindNext(FSearchRec) <> 0;
  finally
    SysUtils.FindClose(FSearchRec);
    Result := AList.Count;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if (trim(edit1.text)='') or (trim(Mir_db1.text)='')  then begin
    Application.MessageBox('请把相关的文件路径选择好！','提示信息',MB_ICONASTERISk+MB_OK);
    Exit;
  end;
  if trim(Mir_db1.text) <> '' then begin
    if not AnsiContainsText(Mir_db1.text,'Mir.db') then begin
      Application.MessageBox('Mir.db文件选择错误！','提示信息',MB_ICONASTERISk+MB_OK);
      Exit;
    end;
  end;
  if Application.MessageBox('是否确定已经将原数据备份并准备好了转换吗？', '提示', mb_YESNO + mb_IconQuestion) = ID_NO then Exit;
  Edit1.Enabled := False;
  SpeedButton1.Enabled := False;
  Mir_db1.Enabled := False;
  SpeedButton4.Enabled := False;
  Edit2.Enabled := False;
  SpeedButton2.Enabled := False;

  Button1.Enabled := False;
  //创建指定目录
  if not DirectoryExists(Edit1.Text+'\DBServer\FDB') then ForceDirectories(Edit1.Text+'\DBServer\FDB');

  MirAllone;//转换人物数据
  HeroMirAllone;//转换副将数据
  Edit1.Enabled := True;
  Edit2.Enabled := True;
  SpeedButton2.Enabled := True;
  SpeedButton1.Enabled := True;
  Mir_db1.Enabled := True;
  SpeedButton4.Enabled := True;
  Button1.Enabled := True;
  Memo1.Lines.add('数据转换已经完成!');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  application.Terminate;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  ShowMessage(IntToStr(SizeOf(TUserItem)));
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Caption := Caption +
  {$if Version = 0}
  '[MMX->D3D]'
  {$else}
  '[D3D 0404->0424]'
  {$ifend}
  ;
end;

//转换人物数据
procedure TForm1.MirAllone;
var
  OldMirInfo: THumDataInfo;
  NewMirInfo: TNewHumDataInfo;//新的结构
  FDBRecord, FNewDBRecord: TMirRecord;
  I, nRecordCount, H: Integer;
  DBHeader: TDBHeader1;
  sFileName : string;
begin
  if FileExists(Mir_db1.Text) then
    FDBRecord := TMirRecord.Create(Mir_db1.Text, fmShareDenyNone)
  else begin
    Memo1.Lines.add('Mir数据库不存在!');
    Exit;
  end;
  sFileName := Edit1.Text+'\DBServer\FDB\Mir.DB';
  ForceDirectories(ExtractFilePath(sFileName));//创建目录 By TasNat at: 2012-04-24 20:15:11

  
  if FileExists(sFileName) then DeleteFile(sFileName); //如果文件存在则先删除
  FNewDBRecord := TMirRecord.Create(sFileName, fmCreate);
  try
    FNewDBRecord.RecSize := SizeOf(NewMirInfo);
    FNewDBRecord.HeaderSize := SizeOf(DBHeader);
    try
      FDBRecord.RecSize := SizeOf(OldMirInfo);
      FDBRecord.HeaderSize := SizeOf(DBHeader);
      FDBRecord.Seek(0, 0);
      FDBRecord.Read(DBHeader, SizeOf(DBHeader));
      DBHeader.sDesc := DBFileDesc;//标识
      DBHeader.n70 := nDBVersion;//DB版本号
      FNewDBRecord.Seek(0, 0);
      FNewDBRecord.Write(DBHeader, SizeOf(DBHeader));
      nRecordCount := FDBRecord.NumRecs;
      FDBRecord.First;
      Memo1.Lines.add('正在把Mir写入新库');
      Label6.caption := '';
      Application.ProcessMessages;
      for i := 1 to nRecordCount do begin
        FDBRecord.ReadRec(OldMirInfo);
        FillChar(NewMirInfo, SizeOf(NewMirInfo), #0);//清空结构
        NewMirInfo.Header:= OldMirInfo.Header;

        NewMirInfo.Data.sChrName:= OldMirInfo.Data.sChrName;//姓名
        NewMirInfo.Data.sCurMap:= OldMirInfo.Data.sCurMap;//地图
        NewMirInfo.Data.wCurX:= OldMirInfo.Data.wCurX; //坐标X
        NewMirInfo.Data.wCurY:= OldMirInfo.Data.wCurY; //坐标Y
        NewMirInfo.Data.btDir:= OldMirInfo.Data.btDir; //方向
        NewMirInfo.Data.btHair:= OldMirInfo.Data.btHair;//头发
        NewMirInfo.Data.btSex:= OldMirInfo.Data.btSex; //性别(0-男 1-女)
        NewMirInfo.Data.btJob:= OldMirInfo.Data.btJob;//职业 0-战 1-法 2-道 3-刺客
        NewMirInfo.Data.nGold:= OldMirInfo.Data.nGold;//金币数(人物) 英雄怒气值(英雄)

        //NewMirInfo.Data.Abil:= OldMirInfo.Data.Abil;//+40 人物其它属性
        //By TasNat at: 2012-04-24 19:56:50
        NewMirInfo.Data.Abil.Level:=OldMirInfo.Data.Abil.Level;//等级
        NewMirInfo.Data.Abil.AC:=OldMirInfo.Data.Abil.AC;//HP 上限 20091026
        NewMirInfo.Data.Abil.MAC:=OldMirInfo.Data.Abil.MAC;//MP 上限 20091026
        NewMirInfo.Data.Abil.DC:=OldMirInfo.Data.Abil.DC;//MaxHP 上限 20091026
        NewMirInfo.Data.Abil.MC:=OldMirInfo.Data.Abil.MC;//MaxMP 上限 20091026
        NewMirInfo.Data.Abil.SC:=OldMirInfo.Data.Abil.SC;//LoByte()-自动修炼修炼场所 HiByte()-自动修炼修炼强度(主体)
        NewMirInfo.Data.Abil.HP:=OldMirInfo.Data.Abil.HP;//-AC,HP下限
        NewMirInfo.Data.Abil.MP:=OldMirInfo.Data.Abil.MP;//-MAC,Mp下限
        NewMirInfo.Data.Abil.MaxHP:=OldMirInfo.Data.Abil.MaxHP;//-DC,MaxHP下限
        NewMirInfo.Data.Abil.MaxMP:=OldMirInfo.Data.Abil.MaxMP;//-MC,MaxMP下限
        NewMirInfo.Data.Abil.NG:=OldMirInfo.Data.Abil.NG;//当前内力值
        NewMirInfo.Data.Abil.MaxNG:=OldMirInfo.Data.Abil.MaxNG;//内力值上限
        NewMirInfo.Data.Abil.Exp:=OldMirInfo.Data.Abil.Exp;//当前经验
        NewMirInfo.Data.Abil.MaxExp:=OldMirInfo.Data.Abil.MaxExp;//升级经验
        NewMirInfo.Data.Abil.Weight:=OldMirInfo.Data.Abil.Weight;
        NewMirInfo.Data.Abil.MaxWeight:=OldMirInfo.Data.Abil.MaxWeight;//最大重量
        NewMirInfo.Data.Abil.WearWeight:=OldMirInfo.Data.Abil.WearWeight;
        NewMirInfo.Data.Abil.MaxWearWeight:=OldMirInfo.Data.Abil.MaxWearWeight;//最大负重
        NewMirInfo.Data.Abil.HandWeight:=OldMirInfo.Data.Abil.HandWeight;
        NewMirInfo.Data.Abil.MaxHandWeight:=OldMirInfo.Data.Abil.MaxHandWeight;//腕力

        NewMirInfo.Data.wStatusTimeArr:= OldMirInfo.Data.wStatusTimeArr; //+24 人物状态属性值，一般是持续多少秒
        NewMirInfo.Data.sHomeMap:= OldMirInfo.Data.sHomeMap;//Home 家(主体),用于是否第一次召唤(英雄)
        NewMirInfo.Data.wHomeX:= OldMirInfo.Data.wHomeX;//Home X
        NewMirInfo.Data.wHomeY:= OldMirInfo.Data.wHomeY;//Home Y
        NewMirInfo.Data.sDearName:= OldMirInfo.Data.sDearName; //别名(配偶)
        NewMirInfo.Data.sMasterName:= OldMirInfo.Data.sMasterName;//人物-师傅名字 英雄-主体名字
        NewMirInfo.Data.boMaster:= OldMirInfo.Data.boMaster;//是否有徒弟
        NewMirInfo.Data.btCreditPoint:= OldMirInfo.Data.btCreditPoint;//声望点
        NewMirInfo.Data.btDivorce:= OldMirInfo.Data.btDivorce; //(主体)喝酒时间,计算长时间没使用喝酒(btDivorce与UnKnow[25]组合成word)
        NewMirInfo.Data.btMarryCount:= OldMirInfo.Data.btMarryCount; //结婚次数
        NewMirInfo.Data.sStoragePwd:= OldMirInfo.Data.sStoragePwd;//仓库密码
        NewMirInfo.Data.btReLevel:= OldMirInfo.Data.btReLevel;//转生等级

        NewMirInfo.Data.btUnKnow2[0]:= OldMirInfo.Data.btUnKnow2[0];
        NewMirInfo.Data.btUnKnow2[1]:= OldMirInfo.Data.btUnKnow2[1];
        NewMirInfo.Data.btUnKnow2[2]:= OldMirInfo.Data.btUnKnow2[2];//0-是否开通元宝寄售(1-开通) 1-是否寄存英雄(1-存有英雄) 2-饮酒时酒的品质

        NewMirInfo.Data.BonusAbil:= OldMirInfo.Data.BonusAbil; //+20 分配的属性值
        NewMirInfo.Data.nBonusPoint:= OldMirInfo.Data.nBonusPoint;//奖励点
        NewMirInfo.Data.nGameGold:= OldMirInfo.Data.nGameGold;//游戏币(元宝)
        NewMirInfo.Data.nGameDiaMond:= OldMirInfo.Data.nGameDiaMond;//金刚石
        NewMirInfo.Data.nGameGird:= OldMirInfo.Data.nGameGird;//灵符
        NewMirInfo.Data.nGamePoint:= OldMirInfo.Data.nGamePoint;//游戏点
        NewMirInfo.Data.btGameGlory:= OldMirInfo.Data.btGameGlory; //荣誉
        NewMirInfo.Data.nPayMentPoint:= OldMirInfo.Data.nPayMentPoint; //充值点
        NewMirInfo.Data.nLoyal:= OldMirInfo.Data.nLoyal;//忠诚度(英雄) 主将累计经验(主体)
        NewMirInfo.Data.nPKPOINT:= OldMirInfo.Data.nPKPOINT;//PK点数
        NewMirInfo.Data.btAllowGroup:= OldMirInfo.Data.btAllowGroup;//允许组队
        NewMirInfo.Data.btF9:= OldMirInfo.Data.btF9;
        NewMirInfo.Data.btAttatckMode:= OldMirInfo.Data.btAttatckMode;//攻击模式
        NewMirInfo.Data.btIncHealth:= OldMirInfo.Data.btIncHealth;//增加健康数
        NewMirInfo.Data.btIncSpell:= OldMirInfo.Data.btIncSpell;//增加攻击点
        NewMirInfo.Data.btIncHealing:= OldMirInfo.Data.btIncHealing;//增加治愈点
        NewMirInfo.Data.btFightZoneDieCount:= OldMirInfo.Data.btFightZoneDieCount;//在行会占争地图中死亡次数
        NewMirInfo.Data.sAccount:= OldMirInfo.Data.sAccount;//登录帐号
        NewMirInfo.Data.btEF:= OldMirInfo.Data.btEF;//英雄类型 0-白日门英雄 1-卧龙英雄 2-主将英雄 3-副将英雄
        NewMirInfo.Data.boLockLogon:= OldMirInfo.Data.boLockLogon;//是否锁定登陆
        NewMirInfo.Data.wContribution:= OldMirInfo.Data.wContribution;//贡献值(主体) 喝酒时间,计算长时间没使用喝酒(英雄)
        NewMirInfo.Data.nHungerStatus:= OldMirInfo.Data.nHungerStatus;//饥饿状态(主体)
        NewMirInfo.Data.boAllowGuildReCall:= OldMirInfo.Data.boAllowGuildReCall;//是否允许行会合一
        NewMirInfo.Data.wGroupRcallTime:= OldMirInfo.Data.wGroupRcallTime; //队传送时间
        NewMirInfo.Data.dBodyLuck:= OldMirInfo.Data.dBodyLuck; //幸运度  8
        NewMirInfo.Data.boAllowGroupReCall:= OldMirInfo.Data.boAllowGroupReCall; //是否允许天地合一
        NewMirInfo.Data.nEXPRATE:= OldMirInfo.Data.nEXPRATE; //经验倍数
        NewMirInfo.Data.nExpTime:= OldMirInfo.Data.nExpTime; //经验倍数时间
        NewMirInfo.Data.btLastOutStatus:= OldMirInfo.Data.btLastOutStatus; //退出状态 1为死亡退出
        NewMirInfo.Data.wMasterCount:= OldMirInfo.Data.wMasterCount; //出师徒弟数
        NewMirInfo.Data.boHasHero:= OldMirInfo.Data.boHasHero; //是否有白日门英雄(主体使用)
        NewMirInfo.Data.boIsHero:= OldMirInfo.Data.boIsHero; //是否是英雄
        NewMirInfo.Data.btStatus:= OldMirInfo.Data.btStatus; //英雄状态(英雄) 所选副将职业(主体)
        NewMirInfo.Data.sHeroChrName:= OldMirInfo.Data.sHeroChrName;//英雄名称, size=15
        NewMirInfo.Data.sHeroChrName1:= OldMirInfo.Data.sHeroChrName1;//卧龙英雄名(size=15) 20110130
        NewMirInfo.Data.UnKnow:= OldMirInfo.Data.UnKnow;//44
        NewMirInfo.Data.QuestFlag:= OldMirInfo.Data.QuestFlag; //脚本变量
        NewMirInfo.Data.HumItems:= OldMirInfo.Data.HumItems; //9格装备 衣服  武器  蜡烛 头盔 项链 手镯 手镯 戒指 戒指
        NewMirInfo.Data.BagItems:= OldMirInfo.Data.BagItems; //包裹装备

        for H:= 0 to 34 do begin//普通魔法
          if OldMirInfo.Data.HumMagics[H].wMagIdx > 0 then begin
            NewMirInfo.Data.HumMagics[H].wMagIdx:=OldMirInfo.Data.HumMagics[H].wMagIdx;
            NewMirInfo.Data.HumMagics[H].btLevel:=OldMirInfo.Data.HumMagics[H].btLevel;
            NewMirInfo.Data.HumMagics[H].btKey:=OldMirInfo.Data.HumMagics[H].btKey;
            NewMirInfo.Data.HumMagics[H].nTranPoint:=OldMirInfo.Data.HumMagics[H].nTranPoint;
            NewMirInfo.Data.HumMagics[H].btLevelEx:= 0;
          end;
        end;

        NewMirInfo.Data.StorageItems:= OldMirInfo.Data.StorageItems;//仓库物品
        NewMirInfo.Data.HumAddItems:= OldMirInfo.Data.HumAddItems;//新增4格 护身符 腰带 鞋子 宝石
        NewMirInfo.Data.n_WinExp:= OldMirInfo.Data.n_WinExp;//累计经验
        NewMirInfo.Data.n_UsesItemTick:= OldMirInfo.Data.n_UsesItemTick;//聚灵珠聚集时间
        NewMirInfo.Data.nReserved:= OldMirInfo.Data.nReserved; //(人物)酿酒的时间,即还有多长时间可以取回酒 (英雄)经络修炼经验
        NewMirInfo.Data.nReserved1:= OldMirInfo.Data.nReserved1; //当前药力值
        NewMirInfo.Data.nReserved2:= OldMirInfo.Data.nReserved2; //药力值上限
        NewMirInfo.Data.nReserved3:= OldMirInfo.Data.nReserved3; //使用药酒时间,计算长时间没使用药酒
        NewMirInfo.Data.n_Reserved:= OldMirInfo.Data.n_Reserved;   //当前酒量值
        NewMirInfo.Data.n_Reserved1:= OldMirInfo.Data.n_Reserved1;  //酒量上限
        NewMirInfo.Data.n_Reserved2:= OldMirInfo.Data.n_Reserved2;  //当前醉酒度
        NewMirInfo.Data.n_Reserved3:= OldMirInfo.Data.n_Reserved3;  //药力值等级
        NewMirInfo.Data.boReserved:= OldMirInfo.Data.boReserved; //是否请过酒 T-请过酒(主体)
        NewMirInfo.Data.boReserved1:= OldMirInfo.Data.boReserved1;//是否有卧龙英雄(主体)
        NewMirInfo.Data.boReserved2:= OldMirInfo.Data.boReserved2;//是否酿酒 T-正在酿酒 (主体)
        NewMirInfo.Data.boReserved3:= OldMirInfo.Data.boReserved3;//人是否喝酒醉了(主体)
        NewMirInfo.Data.m_GiveDate:= OldMirInfo.Data.m_GiveDate;//人物领取行会酒泉日期(主体)
        NewMirInfo.Data.MaxExp68:= OldMirInfo.Data.MaxExp68;//自动修炼累计时长(主体)
        NewMirInfo.Data.nExpSkill69:= OldMirInfo.Data.nExpSkill69;//内功当前经验
        NewMirInfo.Data.HumNGMagics:= OldMirInfo.Data.HumNGMagics;//内功技能
        NewMirInfo.Data.HumTitles:= OldMirInfo.Data.HumTitles;//称号数据  20110130
        NewMirInfo.Data.m_nReserved1:= OldMirInfo.Data.m_nReserved1;//吸伤属性
        NewMirInfo.Data.m_nReserved2:= OldMirInfo.Data.m_nReserved2;//主将英雄等级(主体)
        NewMirInfo.Data.m_nReserved3:= OldMirInfo.Data.m_nReserved3;//副将英雄等级(主体)
        NewMirInfo.Data.m_nReserved4:= OldMirInfo.Data.m_nReserved4;//真视秘籍使用时间
        NewMirInfo.Data.m_nReserved5:= OldMirInfo.Data.m_nReserved5;//使用物品(玄绿,玄紫,玄褐)改变说话颜色的使用时间(主体)
        NewMirInfo.Data.m_nReserved6:= OldMirInfo.Data.m_nReserved6;//主将累计内功经验(主体)
        NewMirInfo.Data.m_nReserved7:= OldMirInfo.Data.m_nReserved7;//主将英雄内功等级(主体)
        NewMirInfo.Data.m_nReserved8:= OldMirInfo.Data.m_nReserved8;//副将英雄内功等级(主体)
        NewMirInfo.Data.Proficiency:= OldMirInfo.Data.Proficiency;//熟练度(制造神秘卷轴)
        NewMirInfo.Data.Reserved2:= OldMirInfo.Data.Reserved2;//人物排名(主体)
        NewMirInfo.Data.Reserved3:= OldMirInfo.Data.Reserved3;//当前精元值(主体)
        NewMirInfo.Data.Reserved4:= OldMirInfo.Data.Reserved4;//当前斗转值
        NewMirInfo.Data.Exp68:= OldMirInfo.Data.Exp68;//人物初始精元值的日期
        NewMirInfo.Data.sHeartName:= OldMirInfo.Data.sHeartName;//龙卫自定义心法名称 20110808
        NewMirInfo.Data.SpiritMedia:= OldMirInfo.Data.SpiritMedia;//灵媒装备位
        NewMirInfo.Data.UnKnow1:= OldMirInfo.Data.UnKnow1;//预留6个Word变量

        FNewDBRecord.AppendRec(NewMirInfo);
        Label6.caption := '已完成' + inttostr(round((i / nRecordCount) * 100)) + '%';
        Application.ProcessMessages;
        FDBRecord.NextRec;
      end;
    finally
      FDBRecord.Free;
    end;
  finally
    FNewDBRecord.Free;
  end;
end;


//转换副将数据
procedure TForm1.HeroMirAllone;
var
  FMirInfo: THeroDataInfo;
  NewMirInfo: TNewHeroDataInfo;//新的结构
  FDBRecord, FNewDBRecord: TMirRecord;
  I, nRecordCount, H: Integer;
  DBHeader: TDBHeader1;
  sFileName : string;
begin
  if FileExists(Edit2.Text) then
    FDBRecord := TMirRecord.Create(Edit2.Text, fmShareDenyNone)
  else begin
    Memo1.Lines.add('Mir数据库不存在!');
    Exit;
  end;
  sFileName := Edit1.Text+'\DBServer\FDB\HeroMir.DB';
  ForceDirectories(ExtractFilePath(sFileName));//创建目录 By TasNat at: 2012-04-24 20:15:11

  if FileExists(sFileName) then DeleteFile(sFileName); //如果文件存在则先删除
  FNewDBRecord := TMirRecord.Create(sFileName, fmCreate);
  try
    FNewDBRecord.RecSize := SizeOf(NewMirInfo);
    FNewDBRecord.HeaderSize := SizeOf(DBHeader);
    try
      FDBRecord.RecSize := SizeOf(FMirInfo);
      FDBRecord.HeaderSize := SizeOf(DBHeader);
      FDBRecord.Seek(0, 0);
      FDBRecord.Read(DBHeader, SizeOf(DBHeader));
      DBHeader.sDesc := DBFileDesc;//标识
      DBHeader.n70 := nDBVersion;//DB版本号
      FNewDBRecord.Seek(0, 0);
      FNewDBRecord.Write(DBHeader, SizeOf(DBHeader));
      nRecordCount := FDBRecord.NumRecs;
      FDBRecord.First;
      Memo1.Lines.add('正在把HeroMir写入新库');
      Label6.Caption := '';
      Application.ProcessMessages;
      for i := 1 to nRecordCount do begin
        FDBRecord.ReadRec(FMirInfo);

        FillChar(NewMirInfo, SizeOf(NewMirInfo), #0);
        NewMirInfo.Header.boDeleted:= FMirInfo.Header.boDeleted;
        NewMirInfo.Header.dCreateDate:= FMirInfo.Header.dCreateDate;

        NewMirInfo.Data.sHeroChrName:= FMirInfo.Data.sHeroChrName;//英雄名称
        NewMirInfo.Data.btJob:= FMirInfo.Data.btJob;//职业 0-战 1-法 2-道 3-刺客
        NewMirInfo.Data.nHP:= FMirInfo.Data.nHP;//当前HP值
        NewMirInfo.Data.nMP:= FMirInfo.Data.nMP;//当前MP值

        for H:= 0 to 29 do begin//普通魔法
          if FMirInfo.Data.HumMagics[H].wMagIdx > 0 then begin
            NewMirInfo.Data.HumMagics[H].wMagIdx:=FMirInfo.Data.HumMagics[H].wMagIdx;
            NewMirInfo.Data.HumMagics[H].btLevel:=FMirInfo.Data.HumMagics[H].btLevel;
            NewMirInfo.Data.HumMagics[H].btKey:=FMirInfo.Data.HumMagics[H].btKey;
            NewMirInfo.Data.HumMagics[H].nTranPoint:=FMirInfo.Data.HumMagics[H].nTranPoint;
            NewMirInfo.Data.HumMagics[H].btLevelEx:= 0;
          end;
        end;

        NewMirInfo.Data.HumNGMagics:= FMirInfo.Data.HumNGMagics;//内功技能

        NewMirInfo.Data.HumItems:= FMirInfo.Data.HumItems;
        NewMirInfo.Data.BagItems:=FMirInfo.Data.BagItems;
        NewMirInfo.Data.HumAddItems:=FMirInfo.Data.HumAddItems;

        FNewDBRecord.AppendRec(NewMirInfo);
        Label6.Caption := '已完成' + inttostr(round((i / nRecordCount) * 100)) + '%';
        Application.ProcessMessages;
        FDBRecord.NextRec;
      end;
    finally
      FDBRecord.Free;
    end;
  finally
    FNewDBRecord.Free;
  end;
end;
end.
