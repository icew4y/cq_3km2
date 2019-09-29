unit HumanInfo;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms,
  ObjBase, StdCtrls, Spin, ComCtrls, ExtCtrls, Grids,ObjHero;

type
  TfrmHumanInfo = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    EditName: TEdit;
    EditMap: TEdit;
    EditXY: TEdit;
    EditAccount: TEdit;
    EditIPaddr: TEdit;
    EditLogonTime: TEdit;
    EditLogonLong: TEdit;
    GroupBox2: TGroupBox;
    Label12: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    EditLevel: TSpinEdit;
    EditGold: TSpinEdit;
    EditPKPoint: TSpinEdit;
    EditExp: TSpinEdit;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    GroupBox3: TGroupBox;
    Label11: TLabel;
    EditAC: TEdit;
    Label13: TLabel;
    EditMAC: TEdit;
    Label14: TLabel;
    EditDC: TEdit;
    EditMC: TEdit;
    Label15: TLabel;
    EditSC: TEdit;
    Label16: TLabel;
    EditHP: TEdit;
    Label17: TLabel;
    Label18: TLabel;
    EditMP: TEdit;
    Timer: TTimer;
    GroupBox4: TGroupBox;
    CheckBoxMonitor: TCheckBox;
    GroupBox5: TGroupBox;
    EditHumanStatus: TEdit;
    GroupBox6: TGroupBox;
    CheckBoxGameMaster: TCheckBox;
    CheckBoxSuperMan: TCheckBox;
    CheckBoxObserver: TCheckBox;
    ButtonKick: TButton;
    GroupBox7: TGroupBox;
    GroupBox9: TGroupBox;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    EditGameGold: TSpinEdit;
    EditGamePoint: TSpinEdit;
    EditCreditPoint: TSpinEdit;
    EditBonusPoint: TSpinEdit;
    Label19: TLabel;
    EditEditBonusPointUsed: TSpinEdit;
    ButtonSave: TButton;
    GridUserItem: TStringGrid;
    GroupBox8: TGroupBox;
    GridBagItem: TStringGrid;
    GroupBox10: TGroupBox;
    GridStorageItem: TStringGrid;
    GroupBox11: TGroupBox;
    Label20: TLabel;
    EditSayMsg: TEdit;
    Label21: TLabel;
    EditMaxExp: TSpinEdit;
    TabSheet7: TTabSheet;
    TabSheet8: TTabSheet;
    TabSheet9: TTabSheet;
    GroupBox12: TGroupBox;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    EditHeroName: TEdit;
    EditHeroMap: TEdit;
    EditHeroXY: TEdit;
    GroupBox13: TGroupBox;
    Label33: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    EditHeroLevel: TSpinEdit;
    EditHeroPKPoint: TSpinEdit;
    EditHeroExp: TSpinEdit;
    EditHeroMaxExp: TSpinEdit;
    GroupBox14: TGroupBox;
    GridHeroUserItem: TStringGrid;
    GroupBox15: TGroupBox;
    GridHeroBagItem: TStringGrid;
    EditGameGird: TSpinEdit;
    Label25: TLabel;
    Label30: TLabel;
    EditGameDiaMond: TSpinEdit;
    Label31: TLabel;
    EditHeroLoyal: TSpinEdit;
    Label32: TLabel;
    EditNGLevel: TSpinEdit;
    Label34: TLabel;
    EditExpSkill69: TSpinEdit;
    Label38: TLabel;
    EditHeroNGLevel: TSpinEdit;
    Label39: TLabel;
    EditHeroExpSkill69: TSpinEdit;
    EditHCode: TEdit;
    Label40: TLabel;
    procedure TimerTimer(Sender: TObject);
    procedure CheckBoxMonitorClick(Sender: TObject);
    procedure ButtonKickClick(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure RefHumanInfo();
    { Private declarations }
  public
    PlayObject: TPlayObject;
    procedure Open(nCode: Byte);
    { Public declarations }
  end;

var
  frmHumanInfo: TfrmHumanInfo;

implementation

uses UsrEngn, M2Share, Grobal2, HUtil32;

{$R *.dfm}

var
  boRefHuman: Boolean = False;
  { TfrmHumanInfo }

procedure TfrmHumanInfo.FormCreate(Sender: TObject);
begin
  GridUserItem.Cells[0, 0] := '装备位置';
  GridUserItem.Cells[1, 0] := '装备名称';
  GridUserItem.Cells[2, 0] := '系列号';
  GridUserItem.Cells[3, 0] := '持久';
  GridUserItem.Cells[4, 0] := '攻';
  GridUserItem.Cells[5, 0] := '魔';
  GridUserItem.Cells[6, 0] := '道';
  GridUserItem.Cells[7, 0] := '防';
  GridUserItem.Cells[8, 0] := '魔防';
  GridUserItem.Cells[9, 0] := '附加属性';

  GridUserItem.Cells[0, 1] := '衣服';
  GridUserItem.Cells[0, 2] := '武器';
  GridUserItem.Cells[0, 3] := '照明物';
  GridUserItem.Cells[0, 4] := '项链';
  GridUserItem.Cells[0, 5] := '头盔';
  GridUserItem.Cells[0, 6] := '左手镯';
  GridUserItem.Cells[0, 7] := '右手镯';
  GridUserItem.Cells[0, 8] := '左戒指';
  GridUserItem.Cells[0, 9] := '右戒指';
  {$IF M2Version <> 2}
  GridUserItem.Cells[0, 10] := '物品';
  GridUserItem.Cells[0, 11] := '腰带';
  GridUserItem.Cells[0, 12] := '鞋子';
  GridUserItem.Cells[0, 13] := '宝石';
  {$ELSE}
  GridUserItem.RowCount:= 10;
  {$IFEND}
  GridBagItem.Cells[0, 0] := '序号';
  GridBagItem.Cells[1, 0] := '装备名称';
  GridBagItem.Cells[2, 0] := '系列号';
  GridBagItem.Cells[3, 0] := '持久';
  GridBagItem.Cells[4, 0] := '攻';
  GridBagItem.Cells[5, 0] := '魔';
  GridBagItem.Cells[6, 0] := '道';
  GridBagItem.Cells[7, 0] := '防';
  GridBagItem.Cells[8, 0] := '魔防';
  GridBagItem.Cells[9, 0] := '附加属性';

  GridStorageItem.Cells[0, 0] := '序号';
  GridStorageItem.Cells[1, 0] := '装备名称';
  GridStorageItem.Cells[2, 0] := '系列号';
  GridStorageItem.Cells[3, 0] := '持久';
  GridStorageItem.Cells[4, 0] := '攻';
  GridStorageItem.Cells[5, 0] := '魔';
  GridStorageItem.Cells[6, 0] := '道';
  GridStorageItem.Cells[7, 0] := '防';
  GridStorageItem.Cells[8, 0] := '魔防';
  GridStorageItem.Cells[9, 0] := '附加属性';

  GridHeroUserItem.Cells[0, 0] := '装备位置';
  GridHeroUserItem.Cells[1, 0] := '装备名称';
  GridHeroUserItem.Cells[2, 0] := '系列号';
  GridHeroUserItem.Cells[3, 0] := '持久';
  GridHeroUserItem.Cells[4, 0] := '攻';
  GridHeroUserItem.Cells[5, 0] := '魔';
  GridHeroUserItem.Cells[6, 0] := '道';
  GridHeroUserItem.Cells[7, 0] := '防';
  GridHeroUserItem.Cells[8, 0] := '魔防';
  GridHeroUserItem.Cells[9, 0] := '附加属性';

  GridHeroUserItem.Cells[0, 1] := '衣服';
  GridHeroUserItem.Cells[0, 2] := '武器';
  GridHeroUserItem.Cells[0, 3] := '照明物';
  GridHeroUserItem.Cells[0, 4] := '项链';
  GridHeroUserItem.Cells[0, 5] := '头盔';
  GridHeroUserItem.Cells[0, 6] := '左手镯';
  GridHeroUserItem.Cells[0, 7] := '右手镯';
  GridHeroUserItem.Cells[0, 8] := '左戒指';
  GridHeroUserItem.Cells[0, 9] := '右戒指';
  {$IF M2Version <> 2}
  GridHeroUserItem.Cells[0, 10] := '物品';
  GridHeroUserItem.Cells[0, 11] := '腰带';
  GridHeroUserItem.Cells[0, 12] := '鞋子';
  GridHeroUserItem.Cells[0, 13] := '宝石';
  {$ELSE}
  GridHeroUserItem.RowCount:= 10;
  {$IFEND}
  GridHeroBagItem.Cells[0, 0] := '序号';
  GridHeroBagItem.Cells[1, 0] := '装备名称';
  GridHeroBagItem.Cells[2, 0] := '系列号';
  GridHeroBagItem.Cells[3, 0] := '持久';
  GridHeroBagItem.Cells[4, 0] := '攻';
  GridHeroBagItem.Cells[5, 0] := '魔';
  GridHeroBagItem.Cells[6, 0] := '道';
  GridHeroBagItem.Cells[7, 0] := '防';
  GridHeroBagItem.Cells[8, 0] := '魔防';
  GridHeroBagItem.Cells[9, 0] := '附加属性';

  PageControl1.ActivePageIndex := 0;
{$IF HEROVERSION = 1}
  PageControl1.Pages[6].TabVisible := True;
  PageControl1.Pages[7].TabVisible := True;
  PageControl1.Pages[8].TabVisible := True;
{$ELSE}
  PageControl1.Pages[6].TabVisible := False;
  PageControl1.Pages[7].TabVisible := False;
  PageControl1.Pages[8].TabVisible := False;
{$IFEND}
end;

procedure TfrmHumanInfo.Open(nCode: Byte);
begin
{$IF M2Version = 2}
  Label38.Visible:= False;
  Label39.Visible:= False;
  EditHeroNGLevel.Visible:= False;
  EditHeroExpSkill69.Visible:= False;
{$IFEND}
  if nCode = 1 then
    PageControl1.ActivePage:=TabSheet7
  else PageControl1.ActivePage:=TabSheet1;//20080901 增加
  RefHumanInfo();
  ButtonKick.Enabled := True;
  Timer.Enabled := True;
  ShowModal;
  CheckBoxMonitor.Checked := False;
  Timer.Enabled := False;
end;

procedure TfrmHumanInfo.RefHumanInfo;
var
  I: Integer;
  nTotleUsePoint: Integer;
  StdItem: pTStdItem;
  Item: TStdItem;
  UserItem: pTUserItem;
begin
  if (PlayObject = nil) then begin
    Exit;
  end;
  if PlayObject.m_boNotOnlineAddExp then EditSayMsg.Enabled := True else EditSayMsg.Enabled := False;
  EditSayMsg.Text := PlayObject.m_sAutoSendMsg;
  EditName.Text := PlayObject.m_sCharName;
  EditMap.Text := PlayObject.m_sMapName;
  if PlayObject.m_PEnvir <> nil then
    EditMap.Text := EditMap.Text + '(' + PlayObject.m_PEnvir.sMapDesc + ')';

  EditXY.Text := IntToStr(PlayObject.m_nCurrX) + ':' + IntToStr(PlayObject.m_nCurrY);
  EditAccount.Text := PlayObject.m_sUserID;
  EditIPaddr.Text := PlayObject.m_sIPaddr;
  EditHCode.Text := '$' + IntToHex(PlayObject.m_dwHCode, 8);
  EditLogonTime.Text := DateTimeToStr(PlayObject.m_dLogonTime);
  EditLogonLong.Text := IntToStr((GetTickCount - PlayObject.m_dwLogonTick) div 60000{(60 * 1000)}) + ' 分钟';
  EditLevel.Value := PlayObject.m_Abil.Level;
  EditGold.Value := PlayObject.m_nGold;
  EditPKPoint.Value := PlayObject.m_nPkPoint;
  EditExp.Value := PlayObject.m_Abil.nExp;
  EditMaxExp.Value := PlayObject.m_Abil.nMaxExp;
{$IF M2Version <> 2}
  if PlayObject.m_boTrainingNG then begin
    EditNGLevel.Enabled:= True;
    EditExpSkill69.Enabled:= True;
    EditNGLevel.Value := PlayObject.m_NGLevel;//20081005 内功等级
    EditExpSkill69.Value := PlayObject.m_ExpSkill69;//20081005 内功心法当前经验
  end;
{$IFEND}
  EditAC.Text := IntToStr(LoWord(PlayObject.m_WAbil.AC)) + '/' + IntToStr(HiWord(PlayObject.m_WAbil.AC));//防御
  EditMAC.Text := IntToStr(LoWord(PlayObject.m_WAbil.MAC)) + '/' + IntToStr(HiWord(PlayObject.m_WAbil.MAC));//魔防
  EditDC.Text := IntToStr(LoWord(PlayObject.m_WAbil.DC)) + '/' + IntToStr(HiWord(PlayObject.m_WAbil.DC));//攻击力
  EditMC.Text := IntToStr(LoWord(PlayObject.m_WAbil.MC)) + '/' + IntToStr(HiWord(PlayObject.m_WAbil.MC));//魔法
  EditSC.Text := IntToStr(LoWord(PlayObject.m_WAbil.SC)) + '/' + IntToStr(HiWord(PlayObject.m_WAbil.SC));//道术
  EditHP.Text := IntToStr(PlayObject.m_WAbil.HP) + '/' + IntToStr(PlayObject.m_WAbil.MaxHP);
  EditMP.Text := IntToStr(PlayObject.m_WAbil.MP) + '/' + IntToStr(PlayObject.m_WAbil.MaxMP);

  EditGameGold.Value := PlayObject.m_nGameGold;
  EditGameDiaMond.Value := PlayObject.m_nGameDiaMond;//金刚石
  EditGameGird.Value := PlayObject.m_nGameGird;//灵符
  EditGamePoint.Value := PlayObject.m_nGamePoint;
  EditCreditPoint.Value := PlayObject.m_btCreditPoint;
  EditBonusPoint.Value := PlayObject.m_nBonusPoint;

  nTotleUsePoint := PlayObject.m_BonusAbil.DC +
    PlayObject.m_BonusAbil.MC +
    PlayObject.m_BonusAbil.SC +
    PlayObject.m_BonusAbil.AC +
    PlayObject.m_BonusAbil.MAC +
    PlayObject.m_BonusAbil.HP +
    PlayObject.m_BonusAbil.MP +
    PlayObject.m_BonusAbil.Hit +
    PlayObject.m_BonusAbil.Speed +
    PlayObject.m_BonusAbil.X2;

  EditEditBonusPointUsed.Value := nTotleUsePoint;

  CheckBoxGameMaster.Checked := PlayObject.m_boAdminMode;
  CheckBoxSuperMan.Checked := PlayObject.m_boSuperMan;
  CheckBoxObserver.Checked := PlayObject.m_boObMode;

  if PlayObject.m_boDeath then begin
    EditHumanStatus.Text := '死亡';
  end else
    if PlayObject.m_boGhost then begin
    EditHumanStatus.Text := '下线';
    PlayObject := nil;
  end else EditHumanStatus.Text := '在线';
  for I := Low(PlayObject.m_UseItems) to High(PlayObject.m_UseItems) do begin
    UserItem := @PlayObject.m_UseItems[I];
    StdItem := UserEngine.GetStdItem(UserItem.wIndex);
    if StdItem = nil then begin
      GridUserItem.Cells[1, I + 1] := '';
      GridUserItem.Cells[2, I + 1] := '';
      GridUserItem.Cells[3, I + 1] := '';
      GridUserItem.Cells[4, I + 1] := '';
      GridUserItem.Cells[5, I + 1] := '';
      GridUserItem.Cells[6, I + 1] := '';
      GridUserItem.Cells[7, I + 1] := '';
      GridUserItem.Cells[8, I + 1] := '';
      GridUserItem.Cells[9, I + 1] := '';
      Continue;
    end;
    Item := StdItem^;
    ItemUnit.GetItemAddValue(UserItem, Item);

    GridUserItem.Cells[1, I + 1] := Item.Name;
    GridUserItem.Cells[2, I + 1] := IntToStr(UserItem.MakeIndex);
    GridUserItem.Cells[3, I + 1] := Format('%d/%d', [UserItem.Dura, UserItem.DuraMax]);
    GridUserItem.Cells[4, I + 1] := Format('%d/%d', [LoWord(Item.DC), HiWord(Item.DC)]);
    GridUserItem.Cells[5, I + 1] := Format('%d/%d', [LoWord(Item.MC), HiWord(Item.MC)]);
    GridUserItem.Cells[6, I + 1] := Format('%d/%d', [LoWord(Item.SC), HiWord(Item.SC)]);
    GridUserItem.Cells[7, I + 1] := Format('%d/%d', [LoWord(Item.AC), HiWord(Item.AC)]);
    GridUserItem.Cells[8, I + 1] := Format('%d/%d', [LoWord(Item.MAC), HiWord(Item.MAC)]);
    GridUserItem.Cells[9, I + 1] := Format('%d/%d/%d/%d/%d/%d/%d', [UserItem.btValue[0],
        UserItem.btValue[1],
        UserItem.btValue[2],
        UserItem.btValue[3],
        UserItem.btValue[4],
        UserItem.btValue[5],
        UserItem.btValue[6]]);
  end;

  if PlayObject.m_ItemList.Count <= 0 then GridBagItem.RowCount := 2
  else GridBagItem.RowCount := PlayObject.m_ItemList.Count + 1;

  if PlayObject.m_ItemList.Count > 0 then begin//20080630
    for I := 0 to PlayObject.m_ItemList.Count - 1 do begin
      UserItem := PlayObject.m_ItemList.Items[I];
      StdItem := UserEngine.GetStdItem(UserItem.wIndex);
      if StdItem = nil then begin
        GridBagItem.Cells[1, I + 1] := '';
        GridBagItem.Cells[2, I + 1] := '';
        GridBagItem.Cells[3, I + 1] := '';
        GridBagItem.Cells[4, I + 1] := '';
        GridBagItem.Cells[5, I + 1] := '';
        GridBagItem.Cells[6, I + 1] := '';
        GridBagItem.Cells[7, I + 1] := '';
        GridBagItem.Cells[8, I + 1] := '';
        GridBagItem.Cells[9, I + 1] := '';
        Continue;
      end;
      Item := StdItem^;
      ItemUnit.GetItemAddValue(UserItem, Item);
      GridBagItem.Cells[0, I + 1] := IntToStr(I);
      GridBagItem.Cells[1, I + 1] := Item.Name;
      GridBagItem.Cells[2, I + 1] := IntToStr(UserItem.MakeIndex);
      GridBagItem.Cells[3, I + 1] := Format('%d/%d', [UserItem.Dura, UserItem.DuraMax]);
      GridBagItem.Cells[4, I + 1] := Format('%d/%d', [LoWord(Item.DC), HiWord(Item.DC)]);
      GridBagItem.Cells[5, I + 1] := Format('%d/%d', [LoWord(Item.MC), HiWord(Item.MC)]);
      GridBagItem.Cells[6, I + 1] := Format('%d/%d', [LoWord(Item.SC), HiWord(Item.SC)]);
      GridBagItem.Cells[7, I + 1] := Format('%d/%d', [LoWord(Item.AC), HiWord(Item.AC)]);
      GridBagItem.Cells[8, I + 1] := Format('%d/%d', [LoWord(Item.MAC), HiWord(Item.MAC)]);
      GridBagItem.Cells[9, I + 1] := Format('%d/%d/%d/%d/%d/%d/%d', [UserItem.btValue[0],
        UserItem.btValue[1],
          UserItem.btValue[2],
          UserItem.btValue[3],
          UserItem.btValue[4],
          UserItem.btValue[5],
          UserItem.btValue[6]]);
    end;
  end;

  if PlayObject.m_StorageItemList.Count <= 0 then GridStorageItem.RowCount := 2
  else GridStorageItem.RowCount := PlayObject.m_StorageItemList.Count + 1;

  if PlayObject.m_StorageItemList.Count > 0 then begin//20080630
    for I := 0 to PlayObject.m_StorageItemList.Count - 1 do begin
      UserItem := PlayObject.m_StorageItemList.Items[I];
      StdItem := UserEngine.GetStdItem(UserItem.wIndex);
      if StdItem = nil then begin
        GridStorageItem.Cells[1, I + 1] := '';
        GridStorageItem.Cells[2, I + 1] := '';
        GridStorageItem.Cells[3, I + 1] := '';
        GridStorageItem.Cells[4, I + 1] := '';
        GridStorageItem.Cells[5, I + 1] := '';
        GridStorageItem.Cells[6, I + 1] := '';
        GridStorageItem.Cells[7, I + 1] := '';
        GridStorageItem.Cells[8, I + 1] := '';
        GridStorageItem.Cells[9, I + 1] := '';
        Continue;
      end;
      Item := StdItem^;
      ItemUnit.GetItemAddValue(UserItem, Item);

      GridStorageItem.Cells[0, I + 1] := IntToStr(I);
      GridStorageItem.Cells[1, I + 1] := Item.Name;
      GridStorageItem.Cells[2, I + 1] := IntToStr(UserItem.MakeIndex);
      GridStorageItem.Cells[3, I + 1] := Format('%d/%d', [UserItem.Dura, UserItem.DuraMax]);
      GridStorageItem.Cells[4, I + 1] := Format('%d/%d', [LoWord(Item.DC), HiWord(Item.DC)]);
      GridStorageItem.Cells[5, I + 1] := Format('%d/%d', [LoWord(Item.MC), HiWord(Item.MC)]);
      GridStorageItem.Cells[6, I + 1] := Format('%d/%d', [LoWord(Item.SC), HiWord(Item.SC)]);
      GridStorageItem.Cells[7, I + 1] := Format('%d/%d', [LoWord(Item.AC), HiWord(Item.AC)]);
      GridStorageItem.Cells[8, I + 1] := Format('%d/%d', [LoWord(Item.MAC), HiWord(Item.MAC)]);
      GridStorageItem.Cells[9, I + 1] := Format('%d/%d/%d/%d/%d/%d/%d', [UserItem.btValue[0],
        UserItem.btValue[1],
          UserItem.btValue[2],
          UserItem.btValue[3],
          UserItem.btValue[4],
          UserItem.btValue[5],
          UserItem.btValue[6]]);
    end;
  end;

{$IF HEROVERSION = 1}
  try
    if PlayObject.m_MyHero = nil then Exit;

    EditHeroName.Text := PlayObject.m_MyHero.m_sCharName;
    EditHeroMap.Text := PlayObject.m_MyHero.m_sMapName + '(' + PlayObject.m_PEnvir.sMapDesc + ')';
    EditHeroXY.Text := IntToStr(PlayObject.m_MyHero.m_nCurrX) + ':' + IntToStr(PlayObject.m_MyHero.m_nCurrY);

    EditHeroLevel.Value := PlayObject.m_MyHero.m_Abil.Level;
    EditHeroPKPoint.Value := PlayObject.m_MyHero.m_nPkPoint;
    EditHeroExp.Value := PlayObject.m_MyHero.m_Abil.nExp;
    EditHeroMaxExp.Value := PlayObject.m_MyHero.m_Abil.nMaxExp;
    EditHeroLoyal.Value :=THeroObject(PlayObject.m_MyHero).m_nLoyal;//英雄的忠诚度(20080110)

    if THeroObject(PlayObject.m_MyHero).m_boTrainingNG then begin
      EditHeroNGLevel.Enabled:= True;
      EditHeroExpSkill69.Enabled:= True;
      EditHeroNGLevel.Value := THeroObject(PlayObject.m_MyHero).m_NGLevel;//20081005 内功等级
      EditHeroExpSkill69.Value := THeroObject(PlayObject.m_MyHero).m_ExpSkill69;//20081005 内功心法当前经验
    end;

    for I := Low(PlayObject.m_MyHero.m_UseItems) to High(PlayObject.m_MyHero.m_UseItems) do begin
      UserItem := @PlayObject.m_MyHero.m_UseItems[I];
      StdItem := UserEngine.GetStdItem(UserItem.wIndex);
      if StdItem = nil then begin
        GridHeroUserItem.Cells[1, I + 1] := '';
        GridHeroUserItem.Cells[2, I + 1] := '';
        GridHeroUserItem.Cells[3, I + 1] := '';
        GridHeroUserItem.Cells[4, I + 1] := '';
        GridHeroUserItem.Cells[5, I + 1] := '';
        GridHeroUserItem.Cells[6, I + 1] := '';
        GridHeroUserItem.Cells[7, I + 1] := '';
        GridHeroUserItem.Cells[8, I + 1] := '';
        GridHeroUserItem.Cells[9, I + 1] := '';
        Continue;
      end;
      Item := StdItem^;
      ItemUnit.GetItemAddValue(UserItem, Item);

      GridHeroUserItem.Cells[1, I + 1] := Item.Name;
      GridHeroUserItem.Cells[2, I + 1] := IntToStr(UserItem.MakeIndex);
      GridHeroUserItem.Cells[3, I + 1] := Format('%d/%d', [UserItem.Dura, UserItem.DuraMax]);
      GridHeroUserItem.Cells[4, I + 1] := Format('%d/%d', [LoWord(Item.DC), HiWord(Item.DC)]);
      GridHeroUserItem.Cells[5, I + 1] := Format('%d/%d', [LoWord(Item.MC), HiWord(Item.MC)]);
      GridHeroUserItem.Cells[6, I + 1] := Format('%d/%d', [LoWord(Item.SC), HiWord(Item.SC)]);
      GridHeroUserItem.Cells[7, I + 1] := Format('%d/%d', [LoWord(Item.AC), HiWord(Item.AC)]);
      GridHeroUserItem.Cells[8, I + 1] := Format('%d/%d', [LoWord(Item.MAC), HiWord(Item.MAC)]);
      GridHeroUserItem.Cells[9, I + 1] := Format('%d/%d/%d/%d/%d/%d/%d', [UserItem.btValue[0],
        UserItem.btValue[1],
          UserItem.btValue[2],
          UserItem.btValue[3],
          UserItem.btValue[4],
          UserItem.btValue[5],
          UserItem.btValue[6]]);
    end;

    if PlayObject.m_MyHero.m_ItemList.Count <= 0 then GridBagItem.RowCount := 2
    else GridBagItem.RowCount := PlayObject.m_MyHero.m_ItemList.Count + 1;

    if PlayObject.m_MyHero.m_ItemList.Count > 0 then begin//20080630
      for I := 0 to PlayObject.m_MyHero.m_ItemList.Count - 1 do begin
        UserItem := PlayObject.m_MyHero.m_ItemList.Items[I];
        StdItem := UserEngine.GetStdItem(UserItem.wIndex);
        if StdItem = nil then begin
          GridHeroBagItem.Cells[1, I + 1] := '';
          GridHeroBagItem.Cells[2, I + 1] := '';
          GridHeroBagItem.Cells[3, I + 1] := '';
          GridHeroBagItem.Cells[4, I + 1] := '';
          GridHeroBagItem.Cells[5, I + 1] := '';
          GridHeroBagItem.Cells[6, I + 1] := '';
          GridHeroBagItem.Cells[7, I + 1] := '';
          GridHeroBagItem.Cells[8, I + 1] := '';
          GridHeroBagItem.Cells[9, I + 1] := '';
          Continue;
        end;
        Item := StdItem^;
        ItemUnit.GetItemAddValue(UserItem, Item);
        GridHeroBagItem.Cells[0, I + 1] := IntToStr(I);
        GridHeroBagItem.Cells[1, I + 1] := Item.Name;
        GridHeroBagItem.Cells[2, I + 1] := IntToStr(UserItem.MakeIndex);
        GridHeroBagItem.Cells[3, I + 1] := Format('%d/%d', [UserItem.Dura, UserItem.DuraMax]);
        GridHeroBagItem.Cells[4, I + 1] := Format('%d/%d', [LoWord(Item.DC), HiWord(Item.DC)]);
        GridHeroBagItem.Cells[5, I + 1] := Format('%d/%d', [LoWord(Item.MC), HiWord(Item.MC)]);
        GridHeroBagItem.Cells[6, I + 1] := Format('%d/%d', [LoWord(Item.SC), HiWord(Item.SC)]);
        GridHeroBagItem.Cells[7, I + 1] := Format('%d/%d', [LoWord(Item.AC), HiWord(Item.AC)]);
        GridHeroBagItem.Cells[8, I + 1] := Format('%d/%d', [LoWord(Item.MAC), HiWord(Item.MAC)]);
        GridHeroBagItem.Cells[9, I + 1] := Format('%d/%d/%d/%d/%d/%d/%d', [UserItem.btValue[0],
          UserItem.btValue[1],
            UserItem.btValue[2],
            UserItem.btValue[3],
            UserItem.btValue[4],
            UserItem.btValue[5],
            UserItem.btValue[6]]);
      end;
    end;
  except
  end;
{$IFEND}
end;

procedure TfrmHumanInfo.TimerTimer(Sender: TObject);
begin
  if PlayObject = nil then Exit;
  if PlayObject.m_boGhost then begin
    EditHumanStatus.Text := '下线';
    PlayObject := nil;
    Exit;
  end;
  if boRefHuman then RefHumanInfo();
end;

procedure TfrmHumanInfo.CheckBoxMonitorClick(Sender: TObject);
begin
  boRefHuman := CheckBoxMonitor.Checked;
  ButtonSave.Enabled := not boRefHuman;
end;

procedure TfrmHumanInfo.ButtonKickClick(Sender: TObject);
begin
  if PlayObject = nil then Exit;
  PlayObject.m_boEmergencyClose := True;
  PlayObject.m_boNotOnlineAddExp := False;
  PlayObject.m_boPlayOffLine := False;
  ButtonKick.Enabled := False;
end;

procedure TfrmHumanInfo.ButtonSaveClick(Sender: TObject);
var
  nLevel: Integer;
  nGold: Integer;
  nPKPOINT: Integer;
  nGameGold: Integer;
  nGameDiaMond: Integer;//20071226 金刚石
  nGameGird: Integer;//20071226 灵符
  nLoyal:Integer;//英雄的忠诚度(20080109)
  nGamePoint: Integer;
  nCreditPoint: Integer;
  nBonusPoint: Integer;
  boGameMaster: Boolean;
  boObServer: Boolean;
  boSuperman: Boolean;
  sAutoSendMsg: string;
  nCode: Byte;
begin
  nCode:= 0;
  try
    if PlayObject = nil then Exit;
    sAutoSendMsg := Trim(EditSayMsg.Text);
    nCode:= 1;
    nLevel := EditLevel.Value;
    nGold := EditGold.Value;
    nPKPOINT := EditPKPoint.Value;
    nGameGold := EditGameGold.Value;
    nGameDiaMond:= EditGameDiaMond.Value;//20071226 金刚石
    nGameGird:= EditGameGird.Value;//20071226 灵符
    nLoyal:= EditHeroLoyal.Value;//英雄的忠诚度(20080109)
    nGamePoint := EditGamePoint.Value;
    nCreditPoint := EditCreditPoint.Value;
    nBonusPoint := EditBonusPoint.Value;
    boGameMaster := CheckBoxGameMaster.Checked;
    boObServer := CheckBoxObserver.Checked;
    boSuperman := CheckBoxSuperMan.Checked;
    nCode:= 2;
    if (nLevel < 0) or (nLevel > High(Word)) or (nGold < 0) or (nGold > 200000000) or (nPKPOINT < 0) or
      (nPKPOINT > 2000000) or (nCreditPoint < 0) or (nCreditPoint > High(Integer)) or (nBonusPoint < 0) or
      (nBonusPoint > 20000000) or (nLoyal>10000) then begin
      MessageBox(Handle, '输入数据不正确！！！', '错误信息', MB_OK);
      Exit;
    end;
    nCode:= 3;
    PlayObject.m_sAutoSendMsg := sAutoSendMsg;
    if PlayObject.m_Abil.Level <> nLevel then begin
      AddGameDataLog('17' + #9 + PlayObject.m_sMapName + #9 + //等级调整记录日志 20081102
      IntToStr(PlayObject.m_nCurrX) + #9 +
      IntToStr(PlayObject.m_nCurrY)+ #9 +
      PlayObject.m_sCharName + #9 +
      IntToStr(PlayObject.m_Abil.Level) + #9 +
      '0' + #9 +
      '调整('+IntToStr(nLevel)+')' + #9 +
      '在线人物窗口');
    end;
    nCode:= 4;
    PlayObject.m_Abil.Level := nLevel;
    PlayObject.m_nGold := nGold;
    PlayObject.m_nPkPoint := nPKPOINT;
    if nGameGold > 0 then begin
      if PlayObject.m_nGameGold <> nGameGold then begin//增加元宝调整记录日志 
        if g_boGameLogGameGold then
          AddGameDataLog(Format(g_sGameLogMsg1, [LOG_GAMEGOLD,
              PlayObject.m_sMapName,
              PlayObject.m_nCurrX,
              PlayObject.m_nCurrY,
              PlayObject.m_sCharName,
              g_Config.sGameGoldName,
              PlayObject.m_nGameGold,
              '调整为'+'('+inttostr(nGameGold)+')',
              '在线人物窗口']));
      end;
      PlayObject.m_nGameGold := nGameGold//20090705 修改
    end else PlayObject.m_nGameGold := 0;
    nCode:= 5;
    PlayObject.m_nGameDiaMond := nGameDiaMond;//20071226 金刚石
    PlayObject.m_nGameGird := nGameGird; //20071226 灵符

    PlayObject.m_nGamePoint := nGamePoint;
    PlayObject.m_btCreditPoint := nCreditPoint;
    PlayObject.m_nBonusPoint := nBonusPoint;
    PlayObject.m_boAdminMode := boGameMaster;
    PlayObject.m_boObMode := boObServer;
    PlayObject.m_boSuperMan := boSuperman;
    {$IF M2Version <> 2}
    nCode:= 6;
    if PlayObject.m_boTrainingNG then begin
      PlayObject.m_NGLevel := _MIN(g_Config.nLimitExpNGLevel, EditNGLevel.Value);//20081005 内功等级
      PlayObject.m_ExpSkill69 := EditExpSkill69 .Value;//20081005 内功心法当前经验
      PlayObject.SendNGData;//发送内功数据 20081005
    end;
    {$IFEND}
    nCode:= 7; 
    PlayObject.GoldChanged;
    PlayObject.GameGoldChanged;//20080211
    PlayObject.HasLevelUp(0{1});//20091022 修改
    if not PlayObject.m_boNotOnlineAddExp then PlayObject.SendMsg(PlayObject, RM_LEVELUP, 0, 0, 0, 0, '');//更新客户端 20091026
    {$IF HEROVERSION = 1}
    nCode:= 8;
    if PlayObject.m_MyHero <> nil then begin
      nLevel := EditHeroLevel.Value;
      nPKPOINT := EditHeroPKPoint.Value;
      if PlayObject.m_MyHero.m_Abil.Level <> nLevel then begin
        AddGameDataLog('17' + #9 + PlayObject.m_MyHero.m_sMapName + #9 + //等级调整记录日志 20081102
        IntToStr(PlayObject.m_MyHero.m_nCurrX) + #9 +
        IntToStr(PlayObject.m_MyHero.m_nCurrY)+ #9 +
        PlayObject.m_MyHero.m_sCharName + #9 +
        IntToStr(PlayObject.m_MyHero.m_Abil.Level) + #9 +
        '0' + #9 +
        '调整('+IntToStr(nLevel)+')' + #9 +
        '在线人物窗口');
      end;
      nCode:= 9;
      PlayObject.m_MyHero.m_Abil.Level := nLevel;
      PlayObject.m_MyHero.m_nPkPoint := nPKPOINT;
      with THeroObject(PlayObject.m_MyHero) do begin
        m_nLoyal:= nLoyal;//英雄的忠诚度(20080110)
        {$IF M2Version <> 2}
        if m_boTrainingNG then begin
          m_NGLevel := _MIN(g_Config.nLimitExpNGLevel, EditHeroNGLevel.Value);//20081005 内功等级
          m_ExpSkill69 := EditHeroExpSkill69.Value;//20081005 内功心法当前经验
          SendNGData;//发送内功数据 20081005
        end;
        {$IFEND}
      end;
      nCode:= 10;
      PlayObject.m_MyHero.HasLevelUp({1}0);//20091022 修改
      if not PlayObject.m_boNotOnlineAddExp then THeroObject(PlayObject.m_MyHero).SendMsg(PlayObject, RM_HEROLEVELUP, 0, 0, 0, 0, '');//更新客户端 20091026
    end;
  {$IFEND}
    MessageBox(Handle, '人物数据已保存。', '提示信息', MB_OK);
  except
    MainOutMessage(Format('{%s} HumanInfo Code:%d', [g_sExceptionVer, nCode]));
  end;
end;

end.

