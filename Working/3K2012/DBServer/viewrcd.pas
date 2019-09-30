unit viewrcd;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, TabNotBk, Grids, ExtCtrls, Buttons,
  ComCtrls, HumDB, Grobal2, DBShare;
type
  TFrmFDBViewer = class(TForm)
    TabbedNotebook1: TTabbedNotebook;
    HumanGrid: TStringGrid;
    UseMagicGrid: TStringGrid;
    BagItemGrid: TStringGrid;
    SaveItemGrid: TStringGrid;
    procedure FormCreate(Sender: TObject);
  private
    procedure sub_49A0C0();
    procedure sub_49A9DC();
    procedure sub_49AA84();
    procedure sub_49AB10();
    procedure ShowBagItem(nIndex: Integer; sName: string; Item: TUserItem);

    procedure ShowBagItems();
    procedure ShowUseMagic();
    procedure ShowSaveItem();
    procedure ShowHumanInfo();
    { Private declarations }
  public
    n2F8: Integer;
    s2FC: string;
    ChrRecord: THumDataInfo;
    procedure ShowHumData();
    { Public declarations }
  end;

var
  FrmFDBViewer: TFrmFDBViewer;

implementation
{$R *.DFM}

procedure TFrmFDBViewer.FormCreate(Sender: TObject);
begin
  sub_49A0C0();
  sub_49A9DC();
  sub_49AA84();
  sub_49AB10();
end;

procedure TFrmFDBViewer.ShowHumData();
begin
  if HumanGrid.Visible then ShowHumanInfo();
  if BagItemGrid.Visible then ShowBagItems();
  if UseMagicGrid.Visible then ShowUseMagic();
  if SaveItemGrid.Visible then ShowSaveItem();
end;

procedure TFrmFDBViewer.sub_49A0C0();
begin
  HumanGrid.Cells[0, 1] := '索引号';
  HumanGrid.Cells[1, 1] := '名称';
  HumanGrid.Cells[2, 1] := '地图';
  HumanGrid.Cells[3, 1] := 'CX';
  HumanGrid.Cells[4, 1] := 'CY';
  HumanGrid.Cells[5, 1] := '方向';
  HumanGrid.Cells[6, 1] := '职业';
  HumanGrid.Cells[7, 1] := '性别';
  HumanGrid.Cells[8, 1] := '头发';
  HumanGrid.Cells[9, 1] := '金币数';
  HumanGrid.Cells[10, 1] := '别名';
  HumanGrid.Cells[11, 1] := 'Home';

  HumanGrid.Cells[0, 3] := 'HomeX';
  HumanGrid.Cells[1, 3] := 'HomeY';
  HumanGrid.Cells[2, 3] := '等级';
  HumanGrid.Cells[3, 3] := '内功等级';
  HumanGrid.Cells[4, 3] := 'HP';
  HumanGrid.Cells[5, 3] := 'MaxHP';
  HumanGrid.Cells[6, 3] := 'MP';
  HumanGrid.Cells[7, 3] := 'MaxMP';
  HumanGrid.Cells[8, 3] := '出师徒弟数';
  HumanGrid.Cells[9, 3] := '当前经验';
  HumanGrid.Cells[10, 3] := '升级经验';
  HumanGrid.Cells[11, 3] := 'PK点数';

  HumanGrid.Cells[0, 5] := '配偶';
  HumanGrid.Cells[1, 5] := '师徒';
  HumanGrid.Cells[2, 5] := '仓库密码';
  HumanGrid.Cells[3, 5] := '声望点';
  HumanGrid.Cells[4, 5] := '是否英雄';
  HumanGrid.Cells[5, 5] := '金刚石';
  HumanGrid.Cells[6, 5] := '灵符';
  HumanGrid.Cells[7, 5] := '游戏币';
  HumanGrid.Cells[8, 5] := '英雄忠诚度';
  HumanGrid.Cells[9, 5] := '英雄名';
  HumanGrid.Cells[10, 5] := '登录帐号';
  HumanGrid.Cells[11, 5] := '最后登录时间';
end;

procedure TFrmFDBViewer.sub_49A9DC();
begin
  BagItemGrid.Cells[0, 0] := '物品号';
  BagItemGrid.Cells[1, 0] := '物品ID';
  BagItemGrid.Cells[2, 0] := '物品号';
  BagItemGrid.Cells[3, 0] := '持久';
  BagItemGrid.Cells[4, 0] := '物品名称';
end;

procedure TFrmFDBViewer.sub_49AA84();
begin
  SaveItemGrid.Cells[0, 0] := '序号';
  SaveItemGrid.Cells[1, 0] := '物品系列号';
  SaveItemGrid.Cells[2, 0] := '物品号';
  SaveItemGrid.Cells[3, 0] := '持久';
  SaveItemGrid.Cells[4, 0] := '物品名称';
end;

procedure TFrmFDBViewer.sub_49AB10();
begin
  UseMagicGrid.Cells[0, 0] := '技能ID';
  UseMagicGrid.Cells[1, 0] := '快捷键';
  UseMagicGrid.Cells[2, 0] := '修练状态';
  UseMagicGrid.Cells[3, 0] := '技能名称';
  UseMagicGrid.Cells[4, 0] := '技能等级';
end;

procedure TFrmFDBViewer.ShowBagItem(nIndex: Integer; sName: string; Item: TUserItem);
begin
  if Item.wIndex > 0 then begin
    BagItemGrid.Cells[0, nIndex] := sName;
    BagItemGrid.Cells[1, nIndex] := IntToStr(Item.MakeIndex);
    BagItemGrid.Cells[2, nIndex] := IntToStr(Item.wIndex);
    BagItemGrid.Cells[3, nIndex] := IntToStr(Item.Dura) + '/' + IntToStr(Item.DuraMax);
    BagItemGrid.Cells[4, nIndex] := GetStdItemName(Item.wIndex);
  end else begin
    BagItemGrid.Cells[0, nIndex] := sName;
    BagItemGrid.Cells[1, nIndex] := '';
    BagItemGrid.Cells[2, nIndex] := '';
    BagItemGrid.Cells[3, nIndex] := '';
    BagItemGrid.Cells[4, nIndex] := '';
  end;
end;

procedure TFrmFDBViewer.ShowHumanInfo();
var
  HumData: pTHumData;
  IsOrNotHero:string;
begin
  HumData := @ChrRecord.Data;
  HumanGrid.Cells[0, 2] := IntToStr(n2F8);
  HumanGrid.Cells[1, 2] := HumData.sChrName;
  HumanGrid.Cells[2, 2] := HumData.sCurMap;
  HumanGrid.Cells[3, 2] := IntToStr(HumData.wCurX);
  HumanGrid.Cells[4, 2] := IntToStr(HumData.wCurY);
  HumanGrid.Cells[5, 2] := IntToStr(HumData.btDir);
  HumanGrid.Cells[6, 2] := IntToStr(HumData.btJob);
  HumanGrid.Cells[7, 2] := IntToStr(HumData.btSex);
  HumanGrid.Cells[8, 2] := IntToStr(HumData.btHair);
  if not HumData.boIsHero then begin
    HumanGrid.Cells[9, 2] := IntToStr(HumData.nGold);//20080419 是英雄则不显示金币值,因为用来保存怒气值
    HumanGrid.Cells[1, 5] := '师徒';
  end else HumanGrid.Cells[1, 5] := '主人';
  HumanGrid.Cells[10, 2] := HumData.sDearName;
  HumanGrid.Cells[11, 2] := HumData.sHomeMap;

  HumanGrid.Cells[0, 4] := IntToStr(HumData.wHomeX);
  HumanGrid.Cells[1, 4] := IntToStr(HumData.wHomeY);
  HumanGrid.Cells[2, 4] := IntToStr(HumData.Abil.Level);
  HumanGrid.Cells[3, 4] := IntToStr({HumData.UnKnow[7]}MakeWord(HumData.UnKnow[7],HumData.UnKnow[33]));//20110127
  HumanGrid.Cells[4, 4] := IntToStr(MakeLong(HumData.Abil.HP, HumData.Abil.AC));//20091026 修改
  HumanGrid.Cells[5, 4] := IntToStr(MakeLong(HumData.Abil.MaxHP, HumData.Abil.DC));
  HumanGrid.Cells[6, 4] := IntToStr(MakeLong(HumData.Abil.MP, HumData.Abil.MAC));
  HumanGrid.Cells[7, 4] := IntToStr(MakeLong(HumData.Abil.MaxMP, HumData.Abil.MC));
  HumanGrid.Cells[8, 4] := IntToStr(HumData.wMasterCount);//20080219 出师徒弟数
  HumanGrid.Cells[9, 4] := IntToStr(HumData.Abil.nExp);
  HumanGrid.Cells[10, 4] := IntToStr(HumData.Abil.nMaxExp);
  HumanGrid.Cells[11, 4] := IntToStr(HumData.nPKPoint);

  HumanGrid.Cells[0, 6] := HumData.sDearName;
  HumanGrid.Cells[1, 6] := HumData.sMasterName;//师傅名字
  HumanGrid.Cells[2, 6] := HumData.sStoragePwd;
  HumanGrid.Cells[3, 6] := IntToStr(HumData.btCreditPoint);
  if HumData.boIsHero then IsOrNotHero:='是' else IsOrNotHero:='否';
  HumanGrid.Cells[4, 6] := IsOrNotHero;
  HumanGrid.Cells[5, 6] := IntToStr(HumData.nGameDiaMond); //金刚石 20071226
  HumanGrid.Cells[6, 6] := IntToStr(HumData.nGameGird);//灵符 20071226
  HumanGrid.Cells[7, 6] := IntToStr(HumData.nGameGold);//游戏币 20071226
  HumanGrid.Cells[8, 6] := FloatToStr(HumData.nLoyal / 100)+'%';//英雄的忠诚度(20080109)
  HumanGrid.Cells[9, 6] := HumData.sHeroChrName;//20080813 英雄名称
  HumanGrid.Cells[10, 6] := HumData.sAccount;
  HumanGrid.Cells[11, 6] := DateTimeToStr(ChrRecord.Header.dCreateDate);
end;

//0049B295
procedure TFrmFDBViewer.ShowBagItems();
var
  i, ii: Integer;
begin
  for i := 1 to BagItemGrid.RowCount - 1 do begin
    for ii := 0 to BagItemGrid.ColCount - 1 do begin
      BagItemGrid.Cells[ii, i] := '';
    end;
  end;
  ShowBagItem(1, '衣服', ChrRecord.Data.HumItems[0]);
  ShowBagItem(2, '武器', ChrRecord.Data.HumItems[1]);
  ShowBagItem(3, '照明物', ChrRecord.Data.HumItems[2]);
  ShowBagItem(4, '头盔', ChrRecord.Data.HumItems[3]);
  ShowBagItem(5, '项链', ChrRecord.Data.HumItems[4]);
  ShowBagItem(6, '手镯左', ChrRecord.Data.HumItems[5]);
  ShowBagItem(7, '手镯右', ChrRecord.Data.HumItems[6]);
  ShowBagItem(8, '戒指左', ChrRecord.Data.HumItems[7]);
  ShowBagItem(9, '戒指右', ChrRecord.Data.HumItems[8]);
  for i := Low(ChrRecord.Data.BagItems) to High(ChrRecord.Data.BagItems) do begin
    ShowBagItem(i + 10, IntToStr(i + 1), ChrRecord.Data.BagItems[i]);
  end;
end;

procedure TFrmFDBViewer.ShowUseMagic();
//0x0049B4D8
var
  i, ii, K: Integer;
begin
  for i := 1 to UseMagicGrid.RowCount - 1 do begin
    for ii := 0 to UseMagicGrid.ColCount - 1 do begin
      UseMagicGrid.Cells[ii, i] := '';
    end;
  end;
  if ChrRecord.Data.boIsHero then K:=1;
  for i := Low(ChrRecord.Data.HumMagics) to High(ChrRecord.Data.HumMagics) do begin
    if ChrRecord.Data.HumMagics[i].wMagIdx <= 0 then break;
    UseMagicGrid.Cells[0, i + 1] := IntToStr(ChrRecord.Data.HumMagics[i].wMagIdx);
    UseMagicGrid.Cells[1, i + 1] := IntToStr(ChrRecord.Data.HumMagics[i].btKey);
    UseMagicGrid.Cells[2, i + 1] := IntToStr(ChrRecord.Data.HumMagics[i].nTranPoint);
    UseMagicGrid.Cells[3, i + 1] := GetMagicName(ChrRecord.Data.HumMagics[i].wMagIdx, K);
    UseMagicGrid.Cells[4, i + 1] := IntToStr(ChrRecord.Data.HumMagics[i].btLevel);
    ii:= I+1;
  end;
  for i := Low(ChrRecord.Data.HumNGMagics) to High(ChrRecord.Data.HumNGMagics) do begin//内功技能 20081003
    if ChrRecord.Data.HumNGMagics[i].wMagIdx <= 0 then break;
    UseMagicGrid.Cells[0, ii + i + 1] := IntToStr(ChrRecord.Data.HumNGMagics[i].wMagIdx);
    UseMagicGrid.Cells[1, ii + i + 1] := IntToStr(ChrRecord.Data.HumNGMagics[i].btKey);
    UseMagicGrid.Cells[2, ii + i + 1] := IntToStr(ChrRecord.Data.HumNGMagics[i].nTranPoint);
    UseMagicGrid.Cells[3, ii + i + 1] := GetMagicName(ChrRecord.Data.HumNGMagics[i].wMagIdx, 2);
    UseMagicGrid.Cells[4, ii + i + 1] := IntToStr(ChrRecord.Data.HumNGMagics[i].btLevel);
  end;
end;

procedure TFrmFDBViewer.ShowSaveItem();
//0x0049B628
var
  i, ii: Integer;
  nCount: Integer;
begin
  for i := 1 to SaveItemGrid.RowCount - 1 do begin
    for ii := 0 to SaveItemGrid.ColCount - 1 do begin
      SaveItemGrid.Cells[ii, i] := '';
    end;
  end;
  nCount := 0;
  for i := Low(ChrRecord.Data.StorageItems) to High(ChrRecord.Data.StorageItems) do begin
    if ChrRecord.Data.StorageItems[i].wIndex <= 0 then Continue;
    SaveItemGrid.Cells[0, i + 1] := IntToStr(nCount);
    SaveItemGrid.Cells[1, i + 1] := IntToStr(ChrRecord.Data.StorageItems[i].MakeIndex);
    SaveItemGrid.Cells[2, i + 1] := IntToStr(ChrRecord.Data.StorageItems[i].wIndex);
    SaveItemGrid.Cells[3, i + 1] := IntToStr(ChrRecord.Data.StorageItems[i].Dura) + '/' +
      IntToStr(ChrRecord.Data.StorageItems[i].DuraMax);
    SaveItemGrid.Cells[4, i + 1] := GetStdItemName(ChrRecord.Data.StorageItems[i].wIndex);
    Inc(nCount);
  end;
end;

end.
