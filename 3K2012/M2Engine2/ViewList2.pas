unit ViewList2;

interface

uses
  Windows, SysUtils,  Forms,Dialogs, Spin, Classes, Controls, ComCtrls, StdCtrls,
  ExtCtrls, Grobal2;

type
  TfrmViewList2 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    ListView1: TListView;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    SpinEdtMaxHP: TSpinEdit;
    SpinEdtMaxMP: TSpinEdit;
    SpinEdit2: TSpinEdit;
    Label4: TLabel;
    SpinEdit3: TSpinEdit;
    Label5: TLabel;
    SpinEdit4: TSpinEdit;
    Label6: TLabel;
    SpinEdit5: TSpinEdit;
    Label7: TLabel;
    SpinEdit6: TSpinEdit;
    Label8: TLabel;
    SpinEdit7: TSpinEdit;
    Label9: TLabel;
    SpinEdit8: TSpinEdit;
    Label10: TLabel;
    SpinEdit9: TSpinEdit;
    Label11: TLabel;
    SpinEdit10: TSpinEdit;
    Label12: TLabel;
    SpinEdit11: TSpinEdit;
    Label13: TLabel;
    SpinEdit12: TSpinEdit;
    Label14: TLabel;
    SpinEdit13: TSpinEdit;
    Label15: TLabel;
    SpinEdit14: TSpinEdit;
    SpinEdit15: TSpinEdit;
    Label16: TLabel;
    SpinEdit16: TSpinEdit;
    Label17: TLabel;
    SpinEdit17: TSpinEdit;
    Label18: TLabel;
    Label19: TLabel;
    SpinEdit18: TSpinEdit;
    Label20: TLabel;
    SpinEdit19: TSpinEdit;
    Label21: TLabel;
    SpinEdit20: TSpinEdit;
    SpinEdit21: TSpinEdit;
    Label22: TLabel;
    SpinEdit22: TSpinEdit;
    Label23: TLabel;
    Label24: TLabel;
    SpinEdit23: TSpinEdit;
    Label27: TLabel;
    Label28: TLabel;
    SpinEdit26: TSpinEdit;
    SpinEdit24: TSpinEdit;
    Label29: TLabel;
    Label30: TLabel;
    SpinEdit28: TSpinEdit;
    SpinEdit25: TSpinEdit;
    Label31: TLabel;
    SpinEdit30: TSpinEdit;
    Label32: TLabel;
    Edit1: TEdit;
    Label33: TLabel;
    Edit2: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Label34: TLabel;
    TabSheet2: TTabSheet;
    Label35: TLabel;
    Label36: TLabel;
    ListView2: TListView;
    ListView3: TListView;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    TabSheet3: TTabSheet;
    Label37: TLabel;
    RefineItemListBox: TListBox;
    Label38: TLabel;
    ListView4: TListView;
    Label39: TLabel;
    GroupBox3: TGroupBox;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    GroupBox4: TGroupBox;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Label43: TLabel;
    Edit6: TEdit;
    Label44: TLabel;
    SpinEdit1: TSpinEdit;
    Label45: TLabel;
    SpinEdit31: TSpinEdit;
    Label46: TLabel;
    SpinEdit32: TSpinEdit;
    Label47: TLabel;
    SpinEdit33: TSpinEdit;
    GroupBox5: TGroupBox;
    Label48: TLabel;
    SpinEdit34: TSpinEdit;
    Label49: TLabel;
    SpinEdit36: TSpinEdit;
    Label50: TLabel;
    SpinEdit37: TSpinEdit;
    Label51: TLabel;
    SpinEdit38: TSpinEdit;
    SpinEdit39: TSpinEdit;
    SpinEdit40: TSpinEdit;
    SpinEdit41: TSpinEdit;
    SpinEdit42: TSpinEdit;
    SpinEdit43: TSpinEdit;
    SpinEdit44: TSpinEdit;
    SpinEdit45: TSpinEdit;
    SpinEdit46: TSpinEdit;
    SpinEdit47: TSpinEdit;
    SpinEdit48: TSpinEdit;
    SpinEdit35: TSpinEdit;
    SpinEdit49: TSpinEdit;
    SpinEdit50: TSpinEdit;
    SpinEdit51: TSpinEdit;
    SpinEdit52: TSpinEdit;
    SpinEdit53: TSpinEdit;
    SpinEdit54: TSpinEdit;
    SpinEdit55: TSpinEdit;
    SpinEdit56: TSpinEdit;
    SpinEdit57: TSpinEdit;
    SpinEdit58: TSpinEdit;
    SpinEdit59: TSpinEdit;
    SpinEdit60: TSpinEdit;
    SpinEdit61: TSpinEdit;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    Label69: TLabel;
    Label70: TLabel;
    Label71: TLabel;
    Label72: TLabel;
    Label73: TLabel;
    Label74: TLabel;
    Label75: TLabel;
    Label76: TLabel;
    Label77: TLabel;
    Label78: TLabel;
    TabSheet5: TTabSheet;
    GroupBox6: TGroupBox;
    ListBoxUserCommand: TListBox;
    Label79: TLabel;
    Label81: TLabel;
    SpinEditCommandIdx: TSpinEdit;
    EditCommandName: TEdit;
    ButtonUserCommandAdd: TButton;
    ButtonUserCommandDel: TButton;
    ButtonUserCommandChg: TButton;
    ButtonLoadUserCommandList: TButton;
    ButtonUserCommandSave: TButton;
    TabSheet6: TTabSheet;
    GroupBox7: TGroupBox;
    ListBoxDisallow: TListBox;
    GroupBox21: TGroupBox;
    ListBoxitemList: TListBox;
    GroupBox8: TGroupBox;
    Label89: TLabel;
    EditItemName: TEdit;
    GroupBox9: TGroupBox;
    BtnDisallowSelAll: TButton;
    BtnDisallowCancelAll: TButton;
    CheckBoxDisallowDrop: TCheckBox;
    CheckBoxDisallowDeal: TCheckBox;
    CheckBoxDisallowStorage: TCheckBox;
    CheckBoxDisallowRepair: TCheckBox;
    CheckBoxDisallowDropHint: TCheckBox;
    CheckBoxDisallowOpenBoxsHint: TCheckBox;
    CheckBoxDisallowNoDropItem: TCheckBox;
    CheckBoxDisallowButchHint: TCheckBox;
    CheckBoxDisallowHeroUse: TCheckBox;
    CheckBoxDisallowPickUpItem: TCheckBox;
    CheckBoxDieDropItems: TCheckBox;
    CheckBoxBuyShopItemGive: TCheckBox;
    CheckBoxButchItem: TCheckBox;
    CheckBoxRefineItem: TCheckBox;
    CheckBoxNpcGiveItem: TCheckBox;
    CheckBoxDigJewelHint: TCheckBox;
    CheckBox24HourDisap: TCheckBox;
    CheckBoxPermanentBind: TCheckBox;
    CheckBox48HourUnBind: TCheckBox;
    CheckBox12: TCheckBox;
    BtnDisallowAdd: TButton;
    BtnDisallowDel: TButton;
    BtnDisallowAddAll: TButton;
    BtnDisallowDelAll: TButton;
    BtnDisallowChg: TButton;
    BtnDisallowSave: TButton;
    Label92: TLabel;
    TabSheet7: TTabSheet;
    GroupBox22: TGroupBox;
    ListViewMsgFilter: TListView;
    GroupBox23: TGroupBox;
    Label93: TLabel;
    Label94: TLabel;
    EditFilterMsg: TEdit;
    EditNewMsg: TEdit;
    ButtonMsgFilterAdd: TButton;
    ButtonMsgFilterDel: TButton;
    ButtonMsgFilterChg: TButton;
    ButtonMsgFilterSave: TButton;
    ButtonLoadMsgFilterList: TButton;
    TabSheet8: TTabSheet;
    GroupBox10: TGroupBox;
    ListViewItemList: TListView;
    GroupBox11: TGroupBox;
    ListBoxItemListShop: TListBox;
    Label103: TLabel;
    Panel1: TPanel;
    SpinEditPrice: TSpinEdit;
    SpinEditGameGird: TSpinEdit;
    ShopTypeBoBox: TComboBox;
    Memo1: TMemo;
    Label99: TLabel;
    Label98: TLabel;
    Label97: TLabel;
    Label96: TLabel;
    Label95: TLabel;
    Label100: TLabel;
    GroupBox12: TGroupBox;
    Label101: TLabel;
    Label102: TLabel;
    EditShopImgBegin: TEdit;
    EditShopImgEnd: TEdit;
    EditShopItemName: TEdit;
    EditShopItemIntroduce: TEdit;
    CheckBoxBuyGameGird: TCheckBox;
    ButtonSaveShopItemList: TButton;
    ButtonLoadShopItemList: TButton;
    ButtonDelShopItem: TButton;
    ButtonChgShopItem: TButton;
    ButtonAddShopItem: TButton;
    Label82: TLabel;
    SpinEdit27: TSpinEdit;
    Label83: TLabel;
    SpinEdit29: TSpinEdit;
    CheckBoxTeleport: TCheckBox;
    CheckBoxParalysis: TCheckBox;
    CheckBoxRevival: TCheckBox;
    CheckBoxMagicShield: TCheckBox;
    CheckBoxUnParalysis: TCheckBox;
    Label25: TLabel;
    SpinEditShopItemCount: TSpinEdit;
    CheckBoxUnRevival: TCheckBox;
    CheckBoxUnMagicShield: TCheckBox;
    Label26: TLabel;
    SpinEdit62: TSpinEdit;
    Label80: TLabel;
    SpinEdit63: TSpinEdit;
    Label84: TLabel;
    SpinEdit64: TSpinEdit;
    CheckBoxCanShop: TCheckBox;
    RadioButtonShopGameGold: TRadioButton;
    RadioButtonShopUseGold: TRadioButton;
    Label85: TLabel;
    SpinEdit65: TSpinEdit;
    Label86: TLabel;
    SpinEdit66: TSpinEdit;
    Label87: TLabel;
    SpinEdit67: TSpinEdit;
    Label88: TLabel;
    SpinEditLimitItemTime: TSpinEdit;
    TabSheet4: TTabSheet;
    GroupBox13: TGroupBox;
    ItemEffectList: TListBox;
    GroupBox14: TGroupBox;
    EffecItemtList: TListBox;
    GroupBox15: TGroupBox;
    Button16: TButton;
    Button17: TButton;
    Button18: TButton;
    Label90: TLabel;
    Edit7: TEdit;
    GroupBox16: TGroupBox;
    Label91: TLabel;
    SpinEdit68: TSpinEdit;
    Label104: TLabel;
    SpinEdit69: TSpinEdit;
    Label105: TLabel;
    ComboBox1: TComboBox;
    Label106: TLabel;
    SpinEdit70: TSpinEdit;
    Label107: TLabel;
    SpinEdit71: TSpinEdit;
    GroupBox17: TGroupBox;
    Label108: TLabel;
    Label110: TLabel;
    SpinEdit72: TSpinEdit;
    ComboBox2: TComboBox;
    GroupBox18: TGroupBox;
    Label113: TLabel;
    Label114: TLabel;
    Label115: TLabel;
    Label116: TLabel;
    Label117: TLabel;
    SpinEdit76: TSpinEdit;
    SpinEdit77: TSpinEdit;
    ComboBox3: TComboBox;
    SpinEdit78: TSpinEdit;
    SpinEdit79: TSpinEdit;
    Label118: TLabel;
    Button19: TButton;
    CheckBoxboShopGamePoint: TCheckBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBoxCanBuyShopItemGive: TCheckBox;
    CheckBox4: TCheckBox;
    procedure ListView1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ListView2DblClick(Sender: TObject);
    procedure ListView3DblClick(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure TabSheet3Show(Sender: TObject);
    procedure RefineItemListBoxDblClick(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure ListView4Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure ButtonUserCommandAddClick(Sender: TObject);
    procedure ButtonUserCommandDelClick(Sender: TObject);
    procedure ButtonUserCommandChgClick(Sender: TObject);
    procedure ButtonUserCommandSaveClick(Sender: TObject);
    procedure ButtonLoadUserCommandListClick(Sender: TObject);
    procedure TabSheet5Show(Sender: TObject);
    procedure ListBoxUserCommandClick(Sender: TObject);
    procedure BtnDisallowSelAllClick(Sender: TObject);
    procedure BtnDisallowCancelAllClick(Sender: TObject);
    procedure ListBoxitemListClick(Sender: TObject);
    procedure ListBoxitemListKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnDisallowAddClick(Sender: TObject);
    procedure BtnDisallowDelClick(Sender: TObject);
    procedure BtnDisallowAddAllClick(Sender: TObject);
    procedure BtnDisallowDelAllClick(Sender: TObject);
    procedure BtnDisallowChgClick(Sender: TObject);
    procedure BtnDisallowSaveClick(Sender: TObject);
    procedure TabSheet6Show(Sender: TObject);
    procedure ListBoxDisallowClick(Sender: TObject);
    procedure CheckBoxDisallowNoDropItemClick(Sender: TObject);
    procedure CheckBoxDieDropItemsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ListViewMsgFilterClick(Sender: TObject);
    procedure ButtonMsgFilterAddClick(Sender: TObject);
    procedure ButtonMsgFilterDelClick(Sender: TObject);
    procedure ButtonMsgFilterChgClick(Sender: TObject);
    procedure ButtonMsgFilterSaveClick(Sender: TObject);
    procedure ButtonLoadMsgFilterListClick(Sender: TObject);
    procedure TabSheet7Show(Sender: TObject);
    procedure ListViewItemListClick(Sender: TObject);
    procedure ListBoxItemListShopClick(Sender: TObject);
    procedure ListBoxItemListShopKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CheckBoxBuyGameGirdClick(Sender: TObject);
    procedure SpinEditGameGirdChange(Sender: TObject);
    procedure ButtonDelShopItemClick(Sender: TObject);
    procedure ButtonChgShopItemClick(Sender: TObject);
    procedure ButtonAddShopItemClick(Sender: TObject);
    procedure ButtonSaveShopItemListClick(Sender: TObject);
    procedure ButtonLoadShopItemListClick(Sender: TObject);
    procedure TabSheet8Show(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure CheckBoxButchItemClick(Sender: TObject);
    procedure CheckBoxDisallowButchHintClick(Sender: TObject);
    procedure CheckBoxCanShopClick(Sender: TObject);
    procedure RadioButtonShopGameGoldClick(Sender: TObject);
    procedure RadioButtonShopUseGoldClick(Sender: TObject);
    procedure CheckBox24HourDisapClick(Sender: TObject);
    procedure CheckBoxPermanentBindClick(Sender: TObject);
    procedure CheckBox48HourUnBindClick(Sender: TObject);
    procedure SpinEditLimitItemTimeChange(Sender: TObject);
    procedure ItemEffectListKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TabSheet4Show(Sender: TObject);
    procedure Button19Click(Sender: TObject);
    procedure EffecItemtListClick(Sender: TObject);
    procedure ItemEffectListClick(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure CheckBoxboShopGamePointClick(Sender: TObject);
    procedure CheckBoxCanBuyShopItemGiveClick(Sender: TObject);
  private
    procedure LoadSuitItem;
    procedure ClearEdt;
    procedure LoadGlobalVal;//读取全局变量 20080426
    procedure LoadGlobalAVal;//读取全局字符型变量 20080426
    {$IF M2Version <> 2}
    procedure ClearEdt1;
    procedure LoadRefineItem;//读取淬练配置 20080508
    procedure SaveRefineItemInfo; //保存淬练配置
    {$IFEND}
    function InCommandListOfName(sCommandName: string): Boolean;
    function InCommandListOfIndex(nIndex: Integer): Boolean;
    procedure DisallowSelAll(SelAll: Boolean);
    procedure RefLoadDisallowStdItems();
    procedure RefLoadEffecItems();
    function InFilterMsgList(sFilterMsg: string): Boolean;
    procedure RefLoadMsgFilterList();
    function InListViewItemList(sItemName: string): Boolean;
    procedure RefLoadShopItemList();
    //procedure LoadWilFileToBox();
    { Private declarations }
  public
    procedure Open;
    { Public declarations }
  end;

var
  frmViewList2: TfrmViewList2;

implementation
uses M2Share, LocalDB, HUtil32;
{$R *.dfm}

function IsChar(str:string):integer;//判断有几个'|'号
var I:integer;
begin
Result:=0;
  for I:=1 to length(str) do
    if (str[I] in ['|']) then begin
      Inc(Result);
    end;
end;

procedure TfrmViewList2.ClearEdt;
begin
  Edit2.Text:= '';
  Edit1.Text:= '';
  SpinEdtMaxHP.Value := 0;
  SpinEdtMaxMP.Value := 0;
  SpinEdit3.Value := 0;
  SpinEdit4.Value := 0;
  SpinEdit6.Value := 0;
  SpinEdit7.Value := 0;
  SpinEdit9.Value := 0;
  SpinEdit10.Value := 0;
  SpinEdit12.Value := 0;
  SpinEdit13.Value := 0;
  SpinEdit17.Value := 0;
  SpinEdit16.Value := 0;
  SpinEdit18.Value := 0;
  SpinEdit19.Value := 0;
  SpinEdit23.Value := 0;
  SpinEdit22.Value := 0;
  SpinEdit26.Value := 0;
  SpinEdit2.Value := 0;
  SpinEdit5.Value := 0;
  SpinEdit8.Value := 0;
  SpinEdit11.Value := 0;
  SpinEdit14.Value := 0;
  SpinEdit15.Value := 0;
  SpinEdit20.Value := 0;
  SpinEdit21.Value := 0;
  SpinEdit28.Value := 0;
  SpinEdit30.Value := 0;
  CheckBoxTeleport.Checked:= False;//传送  20080824
  CheckBoxParalysis.Checked:= False;//麻痹
  CheckBoxRevival.Checked:= False;//复活
  CheckBoxMagicShield.Checked:= False;//护身
  CheckBoxUnParalysis.Checked:= False;//防麻痹
  CheckBoxUnRevival.Checked:= False;//防复活
  CheckBoxUnMagicShield.Checked:= False;//防护身
end;

procedure TfrmViewList2.LoadSuitItem;
var
  ListItem: TListItem;
  I: Integer;
  SuitItem: pTSuitItem;
begin
  ListView1.Clear;
  if g_SuitItemList.Count > 0 then begin//20080630
    for I := 0 to g_SuitItemList.Count - 1 do begin
      SuitItem:=pTSuitItem(g_SuitItemList.Items[I]);
      if SuitItem <> nil then  begin
        ListItem := ListView1.Items.Add;
        ListItem.Caption := Inttostr(I);
        ListItem.SubItems.Add(SuitItem.Note);
        ListItem.SubItems.Add(IntToStr(SuitItem.ItemCount));
        ListItem.SubItems.Add(SuitItem.Name);
        ListItem.SubItems.Add(IntToStr(SuitItem.MaxHP)+'|'+IntToStr(SuitItem.MaxMP)+'|'+
                              IntToStr(SuitItem.DC)+'|'+IntToStr(SuitItem.MaxDC)+'|'+
                              IntToStr(SuitItem.MC)+'|'+IntToStr(SuitItem.MaxMC)+'|'+
                              IntToStr(SuitItem.SC)+'|'+IntToStr(SuitItem.MaxSC)+'|'+
                              IntToStr(SuitItem.AC)+'|'+IntToStr(SuitItem.MaxAC)+'|'+
                              IntToStr(SuitItem.MAC)+'|'+IntToStr(SuitItem.MaxMAC)+'|'+
                              IntToStr(SuitItem.HitPoint)+'|'+IntToStr(SuitItem.SpeedPoint)+'|'+
                              IntToStr(SuitItem.HealthRecover)+'|'+IntToStr(SuitItem.SpellRecover)+'|'+
                              IntToStr(SuitItem.RiskRate)+'|'+IntToStr(SuitItem.btReserved)+'|'+
                              IntToStr(SuitItem.btReserved1)+'|'+IntToStr(SuitItem.btReserved2)+'|'+
                              IntToStr(SuitItem.btReserved3)+'|'+IntToStr(SuitItem.nEXPRATE)+'|'+
                              IntToStr(SuitItem.nPowerRate)+'|'+IntToStr(SuitItem.nMagicRate)+'|'+
                              IntToStr(SuitItem.nSCRate)+'|'+IntToStr(SuitItem.nACRate)+'|'+
                              IntToStr(SuitItem.nMACRate)+'|'+IntToStr(SuitItem.nAntiMagic)+'|'+
                              IntToStr(SuitItem.nAntiPoison)+'|'+IntToStr(SuitItem.nPoisonRecover));
      end;
    end;
  end;
end;

procedure TfrmViewList2.Open;
begin
  LoadSuitItem;
  LoadGlobalVal;//读取全局变量 20080426
  LoadGlobalAVal;//读取全局字符型变量 20080426
  {$IF M2Version = 1}
  Label26.Enabled := True;
  SpinEdit62.Enabled := True;
  {$ELSEIF M2Version = 2}
  Label30.Caption:='保        留:';
  Label30.Enabled:= False;
  Label80.Caption:='保        留:';
  Label80.Enabled:= False;
  SpinEdit25.Enabled:= False;
  SpinEdit25.ShowHint:= False;
  SpinEdit63.Enabled:= False;
  SpinEdit63.ShowHint:= False;
  CheckBoxRefineItem.Caption:='预留位置';
  CheckBoxRefineItem.Enabled:= False;
  CheckBoxRefineItem.ShowHint:= False;
  CheckBoxDigJewelHint.Caption:='预留位置';
  CheckBoxDigJewelHint.Enabled:= False;
  CheckBoxDigJewelHint.ShowHint:= False;
  {$IFEND}
  {$IF HEROVERSION <> 1}
  Label82.Caption:='保        留:';
  Label82.Enabled:= False;
  SpinEdit27.Enabled:= False;
  SpinEdit27.Enabled:= False;
  Label86.Caption:='保        留:';
  Label86.Enabled:= False;
  SpinEdit66.Enabled:= False;
  SpinEdit66.Enabled:= False;
  CheckBoxDisallowHeroUse.Caption:='预留位置';
  CheckBoxDisallowHeroUse.Enabled:= False;
  CheckBoxDisallowHeroUse.ShowHint:= False;
  {$IFEND}
  ShowModal;
end;

procedure TfrmViewList2.ListView1Click(Sender: TObject);
var
  SuitItem: pTSuitItem;
  nIndex: Integer;
begin
  nIndex := ListView1.ItemIndex;
  //if nIndex < 0 then Exit;
  //if (nIndex < 0) and (nIndex >= g_SuitItemList.Count) then Exit;
  if (nIndex < 0) or (nIndex > g_SuitItemList.Count) then Exit;//楼上人才...By TasNat at: 2012-04-07 15:19:10
  SuitItem := pTSuitItem(g_SuitItemList.Items[nIndex]);
  Edit2.Text:= SuitItem.Name;
  Edit1.Text:= SuitItem.Note;
  SpinEdtMaxHP.Value := SuitItem.MaxHP;
  SpinEdtMaxMP.Value := SuitItem.MaxMP;
  SpinEdit3.Value := SuitItem.DC;
  SpinEdit4.Value := SuitItem.MaxDC;
  SpinEdit6.Value := SuitItem.MC;
  SpinEdit7.Value := SuitItem.MaxMC;
  SpinEdit9.Value := SuitItem.SC;
  SpinEdit10.Value := SuitItem.MaxSC;
  SpinEdit12.Value := SuitItem.AC;
  SpinEdit13.Value := SuitItem.MaxAC;
  SpinEdit17.Value := SuitItem.MAC;
  SpinEdit16.Value := SuitItem.MaxMAC;
  SpinEdit18.Value := SuitItem.HitPoint;
  SpinEdit19.Value := SuitItem.SpeedPoint;
  SpinEdit23.Value := SuitItem.HealthRecover;
  SpinEdit22.Value := SuitItem.SpellRecover;
  SpinEdit26.Value := SuitItem.RiskRate;
  SpinEdit2.Value := SuitItem.nEXPRATE;
  SpinEdit5.Value := SuitItem.nPowerRate;
  SpinEdit8.Value := SuitItem.nMagicRate;
  SpinEdit11.Value := SuitItem.nSCRate;
  SpinEdit14.Value := SuitItem.nACRate;
  SpinEdit15.Value := SuitItem.nMACRate;
  SpinEdit20.Value := SuitItem.nAntiMagic;
  SpinEdit21.Value := SuitItem.nAntiPoison;
  SpinEdit28.Value := SuitItem.nPoisonRecover;
  SpinEdit30.Value := SuitItem.ItemCount;
  SpinEdit24.Value := SuitItem.btReserved;//吸血(虹吸)

  CheckBoxTeleport.Checked := SuitItem.boTeleport;//传送  20080824
  CheckBoxParalysis.Checked := SuitItem.boParalysis;//麻痹
  CheckBoxRevival.Checked := SuitItem.boRevival;//复活
  CheckBoxMagicShield.Checked := SuitItem.boMagicShield;//护身
  CheckBoxUnParalysis.Checked := SuitItem.boUnParalysis;//防麻痹
  {$IF M2Version <> 2}
  SpinEdit25.Value := SuitItem.nIncNHRate;//内力恢复(增加) 20090330
  SpinEdit63.Value := SuitItem.btReserved1; //减内力值
  {$IFEND}
  {$IF HEROVERSION = 1}
  SpinEdit27.Value := SuitItem.nIncDragonRate;//合击伤害(增加) 20090330
  SpinEdit66.Value := SuitItem.nIncDragon;//合击伤害点数
  {$IFEND}
  SpinEdit67.Value := SuitItem.nMasterAbility;//主属性
  CheckBoxUnRevival.Checked := SuitItem.boUnRevival;//防复活 20090909
  CheckBoxUnMagicShield.Checked := SuitItem.boUnMagicShield; //防护身
  SpinEdit29.Value := SuitItem.nUnBurstRate;//防爆
  {$IF M2Version = 1}
  SpinEdit62.Value := SuitItem.nVampirePoint;//吸血点数(虎威装备)
  {$IFEND}
  SpinEdit64.Value := SuitItem.nCallTrollLevel;//召唤巨魔等级(传奇套装)
  SpinEdit65.Value := SuitItem.nJob;
  CheckBox1.Checked := SuitItem.boParalysis1;//战意麻痹
  CheckBox2.Checked := SuitItem.boParalysis2;//魔道麻痹
  CheckBox3.Checked := SuitItem.boParalysis3;//魔意麻痹
  CheckBox4.Checked := SuitItem.boNewHPMPAdd;//加血方式
  Button2.Enabled := True;
  Button3.Enabled := True;
end;

procedure TfrmViewList2.Button1Click(Sender: TObject);
var
  SuitItem: pTSuitItem;
begin
  if IsChar(Edit2.text) <= 0 then begin
    Application.MessageBox('套装名字输入不正确,格式:XXX|XXX|！！！', '提示信息', MB_OK + MB_ICONERROR);
    Edit2.SetFocus;
    Exit;
  end;
  if SpinEdit30.Value <= 0 then begin//20090413
    Application.MessageBox('套装数量不能为0！！！', '提示信息', MB_OK + MB_ICONERROR);
    SpinEdit30.SetFocus;
    Exit;
  end;   
  New(SuitItem);
  SuitItem.ItemCount := SpinEdit30.Value;
  if Edit1.text <> '' then
    SuitItem.Note := Edit1.text
  else SuitItem.Note := '????';
  SuitItem.Name := Edit2.text;
  SuitItem.MaxHP:= SpinEdtMaxHP.Value;
  SuitItem.MaxMP:= SpinEdtMaxMP.Value;
  SuitItem.DC:= SpinEdit3.Value ;//攻击力
  SuitItem.MaxDC:= SpinEdit4.Value ;
  SuitItem.MC:= SpinEdit6.Value ;//魔法
  SuitItem.MaxMC:= SpinEdit7.Value;
  SuitItem.SC:= SpinEdit9.Value;//道术
  SuitItem.MaxSC:= SpinEdit10.Value;
  SuitItem.AC:= SpinEdit12.Value;//防御
  SuitItem.MaxAC:= SpinEdit13.Value;
  SuitItem.MAC:= SpinEdit17.Value;//魔防
  SuitItem.MaxMAC:= SpinEdit16.Value;
  SuitItem.HitPoint:= SpinEdit18.Value;//精确度
  SuitItem.SpeedPoint:= SpinEdit19.Value;//敏捷度
  SuitItem.HealthRecover:= SpinEdit23.Value; //体力恢复
  SuitItem.SpellRecover:= SpinEdit22.Value; //魔法恢复
  SuitItem.RiskRate:= SpinEdit26.Value; //幸运值
  SuitItem.btReserved:= SpinEdit24.Value;//吸血(虹吸)
  SuitItem.btReserved1:= SpinEdit63.Value;//减内力值
  SuitItem.btReserved2:= 0; //保留
  SuitItem.btReserved3:= 0; //保留
  SuitItem.nEXPRATE:= SpinEdit2.Value;//经验倍数
  SuitItem.nPowerRate:= SpinEdit5.Value;//攻击倍数
  SuitItem.nMagicRate:= SpinEdit8.Value;//魔法倍数
  SuitItem.nSCRate:= SpinEdit11.Value;//道术倍数
  SuitItem.nACRate:= SpinEdit14.Value;//防御倍数
  SuitItem.nMACRate:= SpinEdit15.Value;//魔御倍数
  SuitItem.nAntiMagic:= SpinEdit20.Value; //魔法躲避
  SuitItem.nAntiPoison:= SpinEdit21.Value; //毒物躲避
  SuitItem.nPoisonRecover:= SpinEdit28.Value;//中毒恢复
  SuitItem.boTeleport := CheckBoxTeleport.Checked;//传送  20080824
  SuitItem.boParalysis := CheckBoxParalysis.Checked;//麻痹
  SuitItem.boRevival := CheckBoxRevival.Checked;//复活
  SuitItem.boMagicShield := CheckBoxMagicShield.Checked;//护身
  SuitItem.boUnParalysis := CheckBoxUnParalysis.Checked;//防麻痹
  SuitItem.nIncDragonRate:= SpinEdit27.Value;//合击伤害(增加) 20090330
  SuitItem.nIncNHRate:= SpinEdit25.Value;//内力恢复(增加) 20090330
  SuitItem.boUnRevival := CheckBoxUnRevival.Checked;//防复活 20090909
  SuitItem.boUnMagicShield := CheckBoxUnMagicShield.Checked; //防护身
  SuitItem.nUnBurstRate := SpinEdit29.Value;//防爆
  SuitItem.nVampirePoint := SpinEdit62.Value;//吸血点数(虎威装备)
  SuitItem.nCallTrollLevel := SpinEdit64.Value;//召唤巨魔等级(传奇套装)
  SuitItem.nJob:= SpinEdit65.Value;
  SuitItem.nIncDragon:= SpinEdit66.Value;//合击伤害点数
  SuitItem.nMasterAbility:= SpinEdit67.Value;//主属性
  SuitItem.boParalysis1 := CheckBox1.Checked;//战意麻痹
  SuitItem.boParalysis2 := CheckBox2.Checked;//魔道麻痹
  SuitItem.boParalysis3 := CheckBox3.Checked;//魔意麻痹
  SuitItem.boNewHPMPAdd := CheckBox4.Checked;//加血方式

  g_SuitItemList.Add(SuitItem);
  LoadSuitItem;
  Button4.Enabled:= True;
end;

procedure TfrmViewList2.Button3Click(Sender: TObject);
var
  nIndex: Integer;
  SuitItem: pTSuitItem;
begin
  nIndex := ListView1.ItemIndex;
  //if nIndex < 0 then Exit;
  //if (nIndex < 0) and (nIndex >= g_SuitItemList.Count) then Exit;
  if (nIndex < 0) or (nIndex > g_SuitItemList.Count) then Exit;//楼上人才...By TasNat at: 2012-04-07 15:19:10

  if IsChar(Edit2.text) <= 0 then begin
    Application.MessageBox('套装名字输入不正确,格式:XXX|XXX|！！！', '提示信息', MB_OK + MB_ICONERROR);
    Edit2.SetFocus;
    Exit;
  end;
  if SpinEdit30.Value <= 0 then begin//20090413
    Application.MessageBox('套装数量不能为0！！！', '提示信息', MB_OK + MB_ICONERROR);
    SpinEdit30.SetFocus;
    Exit;
  end;
  SuitItem := pTSuitItem(g_SuitItemList.Items[nIndex]);
  SuitItem.ItemCount := SpinEdit30.Value;
  SuitItem.Note := Edit1.text;
  SuitItem.Name := Edit2.text;
  SuitItem.MaxHP:= SpinEdtMaxHP.Value;
  SuitItem.MaxMP:= SpinEdtMaxMP.Value;
  SuitItem.DC:= SpinEdit3.Value ;//攻击力
  SuitItem.MaxDC:= SpinEdit4.Value;
  SuitItem.MC:= SpinEdit6.Value ;//魔法
  SuitItem.MaxMC:= SpinEdit7.Value;
  SuitItem.SC:= SpinEdit9.Value;//道术
  SuitItem.MaxSC:= SpinEdit10.Value;
  SuitItem.MaxAC:= SpinEdit13.Value;//防御
  SuitItem.AC:= SpinEdit12.Value;
  SuitItem.MaxMAC:= SpinEdit16.Value;//魔防
  SuitItem.MAC:= SpinEdit17.Value;
  SuitItem.HitPoint:= SpinEdit18.Value;//精确度
  SuitItem.SpeedPoint:= SpinEdit19.Value;//敏捷度
  SuitItem.HealthRecover:= SpinEdit23.Value; //体力恢复
  SuitItem.SpellRecover:= SpinEdit22.Value; //魔法恢复
  SuitItem.RiskRate:= SpinEdit26.Value; //幸运值
  SuitItem.btReserved:= SpinEdit24.Value;//吸血(虹吸)
  SuitItem.btReserved1:= SpinEdit63.Value;//减内力值
  SuitItem.btReserved2:= 0; //保留
  SuitItem.btReserved3:= 0; //保留
  SuitItem.nEXPRATE:= SpinEdit2.Value;//经验倍数
  SuitItem.nPowerRate:= SpinEdit5.Value;//攻击倍数
  SuitItem.nMagicRate:= SpinEdit8.Value;//魔法倍数
  SuitItem.nSCRate:= SpinEdit11.Value;//道术倍数
  SuitItem.nACRate:= SpinEdit14.Value;//防御倍数
  SuitItem.nMACRate:= SpinEdit15.Value;//魔御倍数
  SuitItem.nAntiMagic:= SpinEdit20.Value; //魔法躲避
  SuitItem.nAntiPoison:= SpinEdit21.Value; //毒物躲避
  SuitItem.nPoisonRecover:= SpinEdit28.Value;//中毒恢复
  SuitItem.boNewHPMPAdd := CheckBox4.Checked;//传送  20080824
  SuitItem.boTeleport := CheckBoxTeleport.Checked;//传送  20080824
  SuitItem.boParalysis := CheckBoxParalysis.Checked;//麻痹
  SuitItem.boRevival := CheckBoxRevival.Checked;//复活
  SuitItem.boMagicShield := CheckBoxMagicShield.Checked;//护身
  SuitItem.boUnParalysis := CheckBoxUnParalysis.Checked;//防麻痹
  SuitItem.nIncDragonRate:= SpinEdit27.Value;//合击伤害(增加) 20090330
  SuitItem.nIncNHRate:= SpinEdit25.Value;//内力恢复(增加) 20090330
  SuitItem.boUnRevival := CheckBoxUnRevival.Checked;//防复活 20090909
  SuitItem.boUnMagicShield := CheckBoxUnMagicShield.Checked; //防护身
  SuitItem.nUnBurstRate := SpinEdit29.Value;//防爆
  SuitItem.nVampirePoint := SpinEdit62.Value;//吸血点数(虎威装备)
  SuitItem.nCallTrollLevel := SpinEdit64.Value;//召唤巨魔等级(传奇套装)
  SuitItem.nJob:= SpinEdit65.Value;
  SuitItem.nIncDragon:= SpinEdit66.Value;//合击伤害点数
  SuitItem.nMasterAbility:= SpinEdit67.Value;//主属性
  SuitItem.boParalysis1 := CheckBox1.Checked;//战意麻痹
  SuitItem.boParalysis2 := CheckBox2.Checked;//魔道麻痹
  SuitItem.boParalysis3 := CheckBox3.Checked;//魔意麻痹
  SuitItem.boNewHPMPAdd := CheckBox4.Checked;//加血方式
  LoadSuitItem;
  ClearEdt;
  Button4.Enabled:= True;
  Button2.Enabled:= False;
  Button3.Enabled:= False;
end;

procedure TfrmViewList2.Button2Click(Sender: TObject);
var
  nIndex: Integer;
begin
  nIndex := ListView1.ItemIndex;
  //if nIndex < 0 then Exit;
  //if (nIndex < 0) and (nIndex >= g_SuitItemList.Count) then Exit;
  if (nIndex < 0) or (nIndex > g_SuitItemList.Count) then Exit;//楼上人才...By TasNat at: 2012-04-07 15:19:10
  Dispose(pTSuitItem(g_SuitItemList.Items[nIndex]));
  g_SuitItemList.Delete(nIndex);
  LoadSuitItem;
  ClearEdt;
  Button4.Enabled:= True;
  Button2.Enabled:= False;
  Button3.Enabled:= False;
end;

procedure TfrmViewList2.Button4Click(Sender: TObject);
var
  I: Integer;
  sFileName: string;
  SaveList: TStringList;
  SuitItem: pTSuitItem;
begin
  sFileName := g_Config.sEnvirDir + 'SuitItemList.txt';
  SaveList := TStringList.Create;
  if g_SuitItemList.Count > 0 then begin//20080630
    for I := 0 to g_SuitItemList.Count - 1 do begin
      SuitItem := pTSuitItem(g_SuitItemList.Items[I]);
      SaveList.Add(IntTostr(SuitItem.ItemCount)+' '+SuitItem.Note+' '+SuitItem.Name+' '+
                   IntTostr(SuitItem.MaxHP)+' '+IntTostr(SuitItem.MaxMP)+' '+
                   IntToStr(SuitItem.DC)+' '+IntToStr(SuitItem.MaxDC)+' '+
                   IntToStr(SuitItem.MC)+' '+IntToStr(SuitItem.MaxMC)+' '+
                   IntToStr(SuitItem.SC)+' '+IntToStr(SuitItem.MaxSC)+' '+
                   IntToStr(SuitItem.AC)+' '+IntToStr(SuitItem.MaxAC)+' '+
                   IntToStr(SuitItem.MAC)+' '+IntToStr(SuitItem.MaxMAC)+' '+
                   IntToStr(SuitItem.HitPoint)+' '+IntToStr(SuitItem.SpeedPoint)+' '+
                   IntToStr(SuitItem.HealthRecover)+' '+IntToStr(SuitItem.SpellRecover)+' '+
                   IntToStr(SuitItem.RiskRate)+' '+IntToStr(SuitItem.btReserved)+' '+
                   IntToStr(SuitItem.btReserved1)+' '+IntToStr(SuitItem.btReserved2)+' '+
                   IntToStr(SuitItem.btReserved3)+' '+IntToStr(SuitItem.nEXPRATE)+' '+
                   IntToStr(SuitItem.nPowerRate)+' '+IntToStr(SuitItem.nMagicRate)+' '+
                   IntToStr(SuitItem.nSCRate)+' '+IntToStr(SuitItem.nACRate)+' '+
                   IntToStr(SuitItem.nMACRate)+' '+IntToStr(SuitItem.nAntiMagic)+' '+
                   IntToStr(SuitItem.nAntiPoison)+' '+IntToStr(SuitItem.nPoisonRecover)+' '+
                   BoolToIntStr(SuitItem.boTeleport)+' '+BoolToIntStr(SuitItem.boParalysis)+' '+
                   BoolToIntStr(SuitItem.boRevival)+' '+BoolToIntStr(SuitItem.boMagicShield)+' '+
                   BoolToIntStr(SuitItem.boUnParalysis)+' '+IntToStr(SuitItem.nIncDragonRate)+' '+IntToStr(SuitItem.nIncNHRate)+' '+
                   BoolToIntStr(SuitItem.boUnRevival)+' '+BoolToIntStr(SuitItem.boUnMagicShield)+' '+IntToStr(SuitItem.nUnBurstRate)+' '+
                   IntToStr(SuitItem.nVampirePoint)+' '+IntToStr(SuitItem.nCallTrollLevel)+' '+IntToStr(SuitItem.nJob)+' '+
                   IntToStr(SuitItem.nIncDragon)+' '+IntToStr(SuitItem.nMasterAbility)+' '+BoolToIntStr(SuitItem.boParalysis1)+' '+
                   BoolToIntStr(SuitItem.boParalysis2)+' '+BoolToIntStr(SuitItem.boParalysis3)+' '+BoolToIntStr(SuitItem.boNewHPMPAdd));
    end;
  end;
  SaveList.SaveToFile(sFileName);
  SaveList.Free;//20080529
  Button2.Enabled:= False;
  Button3.Enabled:= False;
  Button4.Enabled:= False;
  Button7.Enabled:= True;
end;
//读取全局数值变量 20080426
procedure TfrmViewList2.LoadGlobalVal;
var
  ListItem: TListItem;
  I:integer;
begin
  ListView2.Items.BeginUpdate;
  try
    for I := Low(g_Config.GlobalVal) to High(g_Config.GlobalVal) do begin
      ListItem := ListView2.Items.Add;
      ListItem.Caption := Inttostr(I);
      ListItem.SubItems.Add(Inttostr(g_Config.GlobalVal[I]));
    end;
  finally
    ListView2.Items.EndUpdate;
  end;
end;

//读取全局字符型变量 20080426
procedure TfrmViewList2.LoadGlobalAVal;
var
  ListItem: TListItem;
  I:integer;
begin
  ListView3.Items.BeginUpdate;
  try
    for I := Low(g_Config.GlobalAVal) to High(g_Config.GlobalAVal) do begin
      ListItem := ListView3.Items.Add;
      ListItem.Caption := Inttostr(I);
      ListItem.SubItems.Add(g_Config.GlobalAVal[I]);
    end;
  finally
    ListView3.Items.EndUpdate;
  end;
end;

procedure TfrmViewList2.ListView2DblClick(Sender: TObject);
  function IsNum(str:string):boolean;
  var
     i:integer;
  begin
     for i:=1 to length(str) do
     if not (str[i] in ['0'..'9']) then begin
       result:=false;
       exit;
     end;
     result:=true;
  end;
var
  ListItem: TListItem;
  str :string;
begin
  ListItem := ListView2.Selected;
  str := InputBox('设置变量','数值变量',ListItem.SubItems.Strings[0]);
  if IsNum(str) then begin
    g_Config.GlobalVal[ListItem.Index]:=Str_ToInt(Str, 0);
    ListItem.SubItems.Strings[0] := IntToStr(g_Config.GlobalVal[ListItem.Index]);
  end;
end;


procedure TfrmViewList2.ListView3DblClick(Sender: TObject);
var
  ListItem: TListItem;
  str :string;
begin
  ListItem := ListView3.Selected;
  str := InputBox('设置变量','字符变量',ListItem.SubItems.Strings[0]);
  ListItem.SubItems.Strings[0] := str;
  g_Config.GlobalAVal[ListItem.Index]:=Str;
end;

procedure TfrmViewList2.Button5Click(Sender: TObject);
var
  I:integer;
begin
  if Application.MessageBox(Pchar('是否真的要清空所有数值变量的值?'),'提示信息',MB_ICONQUESTION+MB_YESNO)=IDYES then Begin
    Try
      for I := Low(g_Config.GlobalVal) to High(g_Config.GlobalVal) do begin
        g_Config.GlobalVal[I]:= 0;
        Config.WriteInteger('Setup', 'GlobalVal' + IntToStr(I), g_Config.GlobalVal[I]); //保存系统变量
        Application.ProcessMessages;//20110613
      end;
      ListView2.Clear;
      LoadGlobalVal;
    except
      MainOutMessage(Format('{%s} TfrmViewList2.Button5Click',[g_sExceptionVer]));
    end;
  end;
end;

procedure TfrmViewList2.Button6Click(Sender: TObject);
var
  I:integer;
begin
  if Application.MessageBox(Pchar('是否真的要清空所有字符变量的值?'),'提示信息',MB_ICONQUESTION+MB_YESNO)=IDYES then Begin
    Try
      for I := Low(g_Config.GlobalAVal) to High(g_Config.GlobalAVal) do begin
        g_Config.GlobalAVal[I]:= '';
        Config.WriteString('Setup', 'GlobalStrVal' + IntToStr(I), g_Config.GlobalAVal[I]);//保存系统变量
        Application.ProcessMessages;//20110613
      end;
      ListView3.Clear;
      LoadGlobalAVal;
    except
      MainOutMessage(Format('{%s} TfrmViewList2.Button6Click',[g_sExceptionVer]));
    end;
  end;
end;

procedure TfrmViewList2.Button7Click(Sender: TObject);
begin
  FrmDB.LoadSuitItemList();//读取套装装备数据 20080506
  Button7.Enabled:= False;
end;

procedure TfrmViewList2.TabSheet3Show(Sender: TObject);
begin
  {$IF M2Version <> 2}
  LoadRefineItem;//读取淬练配置
  {$IFEND}
end;
procedure TfrmViewList2.TabSheet4Show(Sender: TObject);
var
  I: Integer;
  StdItem: pTStdItem;
begin
  ItemEffectList.Items.Clear;
  if UserEngine.StdItemList <> nil then begin
    if UserEngine.StdItemList.Count > 0 then begin
      for I := 0 to UserEngine.StdItemList.Count - 1 do begin
        StdItem:= pTStdItem(UserEngine.StdItemList.Items[I]);
        ItemEffectList.Items.Add(StdItem.Name);
      end;
    end;
  end;
  //LoadWilFileToBox();
  RefLoadEffecItems();
end;

{$IF M2Version <> 2}
//读取淬练配置
procedure TfrmViewList2.LoadRefineItem;
var
  I:integer;
begin
 if g_RefineItemList.Count > 0 then begin
   RefineItemListBox.Clear;
   if g_RefineItemList.Count > 0 then begin//20080630
     for I:= 0 to g_RefineItemList.Count -1 do begin
       RefineItemListBox.Items.Add(g_RefineItemList.Strings[I]);
     end;
   end;
 end;
end;

//取淬练列表物品的名称
procedure GetBackRefineItemName(ItmeStr:string ;var sItemName, sItemName1, sItemName2: string);
var
  str: String;
begin
  str:= ItmeStr;
  if str <> '' then begin
    str := GetValidStr3(str, sItemName,  ['+']);
    str := GetValidStr3(str, sItemName1, ['+']);
    str := GetValidStr3(str, sItemName2, ['+']);
  end;
end;

//判断增加,修改的材料名称是否重复
function IsRefineItemInfo(sItemName,sItemName1,sItemName2: string): Boolean;
  function InStr(Str,sItemName, sItemName1, sItemName2: string):Boolean;
  begin
    Result := False;
    if length(Str)= length(sItemName+'+'+sItemName1+'+'+sItemName2) then begin
      if pos(sItemName,Str) > 0 then begin
        Str:= copy(Str,0,pos(sItemName,Str))+ copy(Str,pos(sItemName,Str)+length(sItemName),length(str));
        if pos(sItemName1,Str) > 0 then begin
          Str:= copy(Str,0,pos(sItemName1,Str))+ copy(Str,pos(sItemName1,Str)+length(sItemName1),length(str));
          if pos(sItemName2,Str) > 0 then  Result := True;
        end;
      end;
    end;
  end;
var
  I: Integer;
  Str: String;
begin
  Result := True;
  if g_RefineItemList.Count > 0 then begin//20080630
    for I := 0 to g_RefineItemList.Count - 1 do begin
      Str:= g_RefineItemList.Strings[I];
      if InStr(Str,sItemName, sItemName1, sItemName2) then begin
        Result := False;
        Break;
      end;
    end;
  end;
end;

//保存淬练配置
procedure TfrmViewList2.SaveRefineItemInfo;
var
  I,K,J:Integer;
  ItemList:TList;
  sFileName,str ,str1 : string;
  SaveList: TStringList;
  TRefineItemInfo:pTRefineItemInfo;
begin
  sFileName := g_Config.sEnvirDir +'RefineItem.txt';
  SaveList := TStringList.Create();
  try
    SaveList.Add(';配置文件');
    SaveList.Add(';淬炼后的物品 淬炼成功几率 失败还原几率 火云石是否消失 淬炼极品属性几率 淬炼极品属性设置');
    SaveList.Add(';[火云石碎片+魔龙冰晶+弩牌]');
    SaveList.Add(';光芒项链 60 0 0 1 2-6,2-6,0-5,0-5,4-5,0-5,0-5,0-5,0-5,0-5,0-5,0-5,0-5,0-5,');
    if g_RefineItemList.Count > 0 then begin//20080630
      for I := 0 to g_RefineItemList.Count - 1 do begin
        SaveList.Add('['+g_RefineItemList.Strings[I]+']');
        ItemList := TList(g_RefineItemList.Objects[I]);
        if ItemList.Count > 0 then begin
           for K := 0 to ItemList.Count - 1 do begin
             TRefineItemInfo:=pTRefineItemInfo(ItemList.Items[K]);
             str:=TRefineItemInfo.sItemName+' '+inttostr(TRefineItemInfo.nRefineRate)+' '+
                  inttostr(TRefineItemInfo.nReductionRate)+' '+BoolToIntStr(not TRefineItemInfo.boDisappear)+' '+ inttostr(TRefineItemInfo.nNeedRate);
             str1:='';
             for J:=0 to 13 do begin
               if str1 <> '' then str1:=str1+',';
               str1:=str1+inttostr(TRefineItemInfo.nAttribute[J].nPoints)+'-'+ inttostr(TRefineItemInfo.nAttribute[J].nDifficult);
             end;
             str:=str+' '+str1;
             SaveList.Add(str);
           end;
        end;
      end;
    end;
    SaveList.SaveToFile(sFileName);
  finally
    SaveList.Free;
  end;
end;

procedure TfrmViewList2.ClearEdt1;
begin
  Edit6.Text:= '';
  SpinEdit1.Value := 0;
  SpinEdit31.Value := 0;
  SpinEdit32.Value := 0;
  SpinEdit33.Value := 0;
  SpinEdit34.Value:= 0;
  SpinEdit35.Value:= 0;
  SpinEdit36.Value:=0;
  SpinEdit49.Value:=0;
  SpinEdit37.Value:=0;
  SpinEdit50.Value:=0;
  SpinEdit38.Value:=0;
  SpinEdit51.Value:=0;
  SpinEdit40.Value:=0;
  SpinEdit52.Value:=0;
  SpinEdit41.Value:=0;
  SpinEdit53.Value:=0;
  SpinEdit42.Value:=0;
  SpinEdit54.Value:=0;
  SpinEdit39.Value:=0;
  SpinEdit55.Value:=0;
  SpinEdit43.Value:=0;
  SpinEdit56.Value:=0;
  SpinEdit44.Value:=0;
  SpinEdit57.Value:=0;
  SpinEdit45.Value:=0;
  SpinEdit58.Value:=0;
  SpinEdit46.Value:=0;
  SpinEdit59.Value:=0;
  SpinEdit47.Value:=0;
  SpinEdit60.Value:=0;
  SpinEdit48.Value:=0;
  SpinEdit61.Value:=0;
end;
{$IFEND}
procedure TfrmViewList2.RefineItemListBoxDblClick(Sender: TObject);
var str,str1:string;
    ItemList:TList;
    I, K:integer;
    TRefineItemInfo:pTRefineItemInfo;
    ListItem: TListItem;
    str2,str3,str4:string;
begin
{$IF M2Version <> 2}
if RefineItemListBox.ItemIndex >=0 then begin
  ListView4.Clear;
  str:= RefineItemListBox.Items.Strings[RefineItemListBox.ItemIndex];//取得材料名称:火云石+黑铁头盔+雷霆战戒
  Label78.Caption := Str;
  GetBackRefineItemName(str,str2,str3,str4);
  Edit3.text:=Str2;
  Edit4.text:=Str3;
  Edit5.text:=Str4;
  Button9.Enabled:= True;
  Button10.Enabled:= True;
  ItemList:= nil;//20080522
  if g_RefineItemList.Count > 0 then begin//20080630
    for I := 0 to g_RefineItemList.Count - 1 do begin
      if CompareText(g_RefineItemList.Strings[I],str)=0 then begin
        ItemList := TList(g_RefineItemList.Objects[I]);
        Break;
      end;
    end;
  end;
  if ItemList <> nil then begin
    if ItemList.Count > 0 then begin
      for I := 0 to ItemList.Count - 1 do begin
        TRefineItemInfo:=pTRefineItemInfo(ItemList.Items[I]);
        ListView4.Items.BeginUpdate;
        try
          ListItem := ListView4.Items.Add;
          ListItem.Caption := TRefineItemInfo.sItemName;
          ListItem.SubItems.Add(inttostr(TRefineItemInfo.nRefineRate));
          ListItem.SubItems.Add(inttostr(TRefineItemInfo.nReductionRate));
          if TRefineItemInfo.boDisappear then
            ListItem.SubItems.Add(inttostr(0))
          else  ListItem.SubItems.Add(inttostr(1));
          ListItem.SubItems.Add(inttostr(TRefineItemInfo.nNeedRate));
          str1:='';
          for K:=0 to 13 do begin
            if str1 <> '' then str1:=str1+',';
            str1:=str1+inttostr(TRefineItemInfo.nAttribute[K].nPoints)+'-'+ inttostr(TRefineItemInfo.nAttribute[K].nDifficult);
          end;
          ListItem.SubItems.Add(Str1);
        finally
          ListView4.Items.EndUpdate;
        end;
      end;
    end;
  end;
end;
{$IFEND}
end;
//增加淬练材料
procedure TfrmViewList2.Button8Click(Sender: TObject);
var List28: TList;
begin
{$IF M2Version <> 2}
  if IsRefineItemInfo(Trim(Edit3.text),Trim(Edit4.text),Trim(Edit5.text)) then begin
     List28 := TList.Create;
     if List28 <> nil then begin
       g_RefineItemList.AddObject(Trim(Edit3.text)+'+'+Trim(Edit4.text)+'+'+Trim(Edit5.text), List28);
       RefineItemListBox.Items.Add(Trim(Edit3.text)+'+'+Trim(Edit4.text)+'+'+Trim(Edit5.text));
       Button11.Enabled:=True;
       Edit3.Text:='';
       Edit4.Text:='';
       Edit5.Text:='';
       Label78.Caption := '';
     end;
  end else Application.MessageBox('此物品淬练配方已存在！' ,'提示信息',MB_ICONQUESTION+MB_OK);
{$IFEND}
end;
//修改淬练材料
procedure TfrmViewList2.Button9Click(Sender: TObject);
begin
{$IF M2Version <> 2}
  if RefineItemListBox.ItemIndex >= 0 then begin
    if IsRefineItemInfo(Trim(Edit3.text),Trim(Edit4.text),Trim(Edit5.text)) then begin
      g_RefineItemList.Strings[RefineItemListBox.ItemIndex]:=Trim(Edit3.text)+'+'+Trim(Edit4.text)+'+'+Trim(Edit5.text);
      Button11.Enabled:=True;
      Button10.Enabled:=False;
      Edit3.Text:='';
      Edit4.Text:='';
      Edit5.Text:='';
      Label78.Caption := '';
      LoadRefineItem;//读取淬练配置
    end  else Application.MessageBox('此物品淬练配方已存在！' ,'提示信息',MB_ICONQUESTION+MB_OK);
  end;
{$IFEND}
end;

procedure TfrmViewList2.Button10Click(Sender: TObject);
begin
{$IF M2Version <> 2}
  if RefineItemListBox.ItemIndex >= 0 then begin
    g_RefineItemList.Delete(RefineItemListBox.ItemIndex);
    Button9.Enabled:=False;
    Button11.Enabled:=True;
    Edit3.Text:='';
    Edit4.Text:='';
    Edit5.Text:='';
    Label78.Caption := '';
    RefineItemListBox.DeleteSelected;
  end;
{$IFEND}
end;

procedure TfrmViewList2.Button11Click(Sender: TObject);
begin
{$IF M2Version <> 2}
  SaveRefineItemInfo;
  Button9.Enabled:=False;
  Button10.Enabled:=False;
  Button11.Enabled:=False;
  Edit3.Text:='';
  Edit4.Text:='';
  Edit5.Text:='';
  Label78.Caption := '';
{$IFEND}
end;

procedure TfrmViewList2.ListView4Click(Sender: TObject);
var
  ListItem: TListItem;
  s18: String;
  n1,n11,n2,n22,n3,n33,n4,n44,n5,n55,n6,n66,n7,n77,n8,n88,n9,n99,nA,nAA,nB,nBB,nC,nCC,nD,nDD,nE,nEE: string;
begin
  if ListView4.ItemIndex >= 0 then begin
    ListItem := ListView4.Items.Item[ListView4.ItemIndex];
    Edit6.text:= ListItem.Caption;
    SpinEdit1.Value := Str_ToInt(ListItem.SubItems.Strings[0], 0);
    SpinEdit31.Value := Str_ToInt(ListItem.SubItems.Strings[1], 0);
    SpinEdit32.Value := Str_ToInt(ListItem.SubItems.Strings[2], 0);
    SpinEdit33.Value := Str_ToInt(ListItem.SubItems.Strings[3], 0);
    s18 := ListItem.SubItems.Strings[4];

    s18 := GetValidStr3(s18, n1,  ['-',',', #9]);//各属性值及难度
    s18 := GetValidStr3(s18, n11, ['-',',', #9]);
    s18 := GetValidStr3(s18, n2,  ['-',',', #9]);
    s18 := GetValidStr3(s18, n22, ['-',',', #9]);
    s18 := GetValidStr3(s18, n3,  ['-',',', #9]);
    s18 := GetValidStr3(s18, n33, ['-',',', #9]);
    s18 := GetValidStr3(s18, n4,  ['-',',', #9]);
    s18 := GetValidStr3(s18, n44, ['-',',', #9]);
    s18 := GetValidStr3(s18, n5,  ['-',',', #9]);
    s18 := GetValidStr3(s18, n55, ['-',',', #9]);
    s18 := GetValidStr3(s18, n6,  ['-',',', #9]);
    s18 := GetValidStr3(s18, n66, ['-',',', #9]);
    s18 := GetValidStr3(s18, n7,  ['-',',', #9]);
    s18 := GetValidStr3(s18, n77, ['-',',', #9]);
    s18 := GetValidStr3(s18, n8,  ['-',',', #9]);
    s18 := GetValidStr3(s18, n88, ['-',',', #9]);
    s18 := GetValidStr3(s18, n9,  ['-',',', #9]);
    s18 := GetValidStr3(s18, n99, ['-',',', #9]);
    s18 := GetValidStr3(s18, nA,  ['-',',', #9]);
    s18 := GetValidStr3(s18, nAA, ['-',',', #9]);
    s18 := GetValidStr3(s18, nB,  ['-',',', #9]);
    s18 := GetValidStr3(s18, nBB, ['-',',', #9]);
    s18 := GetValidStr3(s18, nC,  ['-',',', #9]);
    s18 := GetValidStr3(s18, nCC, ['-',',', #9]);
    s18 := GetValidStr3(s18, nD,  ['-',',', #9]);
    s18 := GetValidStr3(s18, nDD, ['-',',', #9]);
    s18 := GetValidStr3(s18, nE,  ['-',',', #9]);
    s18 := GetValidStr3(s18, nEE, ['-',',', #9]);

    SpinEdit34.Value:= Str_ToInt(Trim(n1), 0);
    SpinEdit35.Value:= Str_ToInt(Trim(n11), 0);
    SpinEdit36.Value:=Str_ToInt(Trim(n2), 0);
    SpinEdit49.Value:=Str_ToInt(Trim(n22), 0);
    SpinEdit37.Value:=Str_ToInt(Trim(n3), 0);
    SpinEdit50.Value:=Str_ToInt(Trim(n33), 0);
    SpinEdit38.Value:=Str_ToInt(Trim(n4), 0);
    SpinEdit51.Value:=Str_ToInt(Trim(n44), 0);
    SpinEdit40.Value:=Str_ToInt(Trim(n5), 0);
    SpinEdit52.Value:=Str_ToInt(Trim(n55), 0);
    SpinEdit41.Value:=Str_ToInt(Trim(n6), 0);
    SpinEdit53.Value:=Str_ToInt(Trim(n66), 0);
    SpinEdit42.Value:=Str_ToInt(Trim(n7), 0);
    SpinEdit54.Value:=Str_ToInt(Trim(n77), 0);
    SpinEdit39.Value:=Str_ToInt(Trim(n8), 0);
    SpinEdit55.Value:=Str_ToInt(Trim(n88), 0);
    SpinEdit43.Value:=Str_ToInt(Trim(n9), 0);
    SpinEdit56.Value:=Str_ToInt(Trim(n99), 0);
    SpinEdit44.Value:=Str_ToInt(Trim(nA), 0);
    SpinEdit57.Value:=Str_ToInt(Trim(nAA), 0);
    SpinEdit45.Value:=Str_ToInt(Trim(nB), 0);
    SpinEdit58.Value:=Str_ToInt(Trim(nBB), 0);
    SpinEdit46.Value:=Str_ToInt(Trim(nC), 0);
    SpinEdit59.Value:=Str_ToInt(Trim(nCC), 0);
    SpinEdit47.Value:=Str_ToInt(Trim(nD), 0);
    SpinEdit60.Value:=Str_ToInt(Trim(nDD), 0);
    SpinEdit48.Value:=Str_ToInt(Trim(nE), 0);
    SpinEdit61.Value:=Str_ToInt(Trim(nEE), 0);
    Button13.Enabled:=True;
    Button14.Enabled:=True;
  end;
end;

procedure TfrmViewList2.Button12Click(Sender: TObject);
var
  I, k:Integer;
  ItemList:TList;
  sItemName, sItemName1, sItemName2: string;
  TRefineItemInfo:pTRefineItemInfo;
  boAdd:boolean;
  str1:string;
  ListItem: TListItem;
begin
{$IF M2Version <> 2}
  if Label78.Caption <> '' then begin
    boAdd:= True;
    GetBackRefineItemName(Label78.Caption,sItemName, sItemName1, sItemName2);
    ItemList:=GetRefineItemInfo(sItemName,sItemName1,sItemName2);
    if ItemList.Count > 0 then begin//20080630
      for I:=0 to ItemList.Count-1 do begin
         TRefineItemInfo:=pTRefineItemInfo(ItemList.Items[I]);
         if CompareText(Trim(Edit6.text),TRefineItemInfo.sItemName)= 0 then begin
           boAdd:= False;//不能存在同名物品
           Break;
         end;
      end;
    end;
    if boAdd then begin
      New(TRefineItemInfo);
      TRefineItemInfo.sItemName:= Trim(Edit6.text);
      TRefineItemInfo.nRefineRate:= SpinEdit1.Value;
      TRefineItemInfo.nReductionRate:= SpinEdit31.Value;
      TRefineItemInfo.boDisappear:= SpinEdit32.Value = 0;//0-减持久 1-消失
      TRefineItemInfo.nNeedRate:= SpinEdit33.Value;
      TRefineItemInfo.nAttribute[0].nPoints:= SpinEdit34.Value;;
      TRefineItemInfo.nAttribute[0].nDifficult:= SpinEdit35.Value;
      TRefineItemInfo.nAttribute[1].nPoints:= SpinEdit36.Value;;
      TRefineItemInfo.nAttribute[1].nDifficult:= SpinEdit49.Value;
      TRefineItemInfo.nAttribute[2].nPoints:= SpinEdit37.Value;
      TRefineItemInfo.nAttribute[2].nDifficult:= SpinEdit50.Value;
      TRefineItemInfo.nAttribute[3].nPoints:= SpinEdit38.Value;
      TRefineItemInfo.nAttribute[3].nDifficult:= SpinEdit51.Value;
      TRefineItemInfo.nAttribute[4].nPoints:= SpinEdit40.Value;
      TRefineItemInfo.nAttribute[4].nDifficult:= SpinEdit52.Value;
      TRefineItemInfo.nAttribute[5].nPoints:= SpinEdit41.Value;
      TRefineItemInfo.nAttribute[5].nDifficult:= SpinEdit53.Value;
      TRefineItemInfo.nAttribute[6].nPoints:= SpinEdit42.Value;
      TRefineItemInfo.nAttribute[6].nDifficult:= SpinEdit54.Value;
      TRefineItemInfo.nAttribute[7].nPoints:= SpinEdit39.Value;
      TRefineItemInfo.nAttribute[7].nDifficult:= SpinEdit55.Value;
      TRefineItemInfo.nAttribute[8].nPoints:= SpinEdit43.Value;
      TRefineItemInfo.nAttribute[8].nDifficult:= SpinEdit56.Value;
      TRefineItemInfo.nAttribute[9].nPoints:= SpinEdit44.Value;
      TRefineItemInfo.nAttribute[9].nDifficult:= SpinEdit57.Value;
      TRefineItemInfo.nAttribute[10].nPoints:= SpinEdit45.Value;
      TRefineItemInfo.nAttribute[10].nDifficult:= SpinEdit58.Value;
      TRefineItemInfo.nAttribute[11].nPoints:= SpinEdit46.Value;
      TRefineItemInfo.nAttribute[11].nDifficult:= SpinEdit59.Value;
      TRefineItemInfo.nAttribute[12].nPoints:= SpinEdit47.Value;
      TRefineItemInfo.nAttribute[12].nDifficult:= SpinEdit60.Value;
      TRefineItemInfo.nAttribute[13].nPoints:= SpinEdit48.Value;
      TRefineItemInfo.nAttribute[13].nDifficult:= SpinEdit61.Value;
      ItemList.Add(TRefineItemInfo);

      ListView4.Items.BeginUpdate;
      try
        ListItem := ListView4.Items.Add;
        ListItem.Caption := TRefineItemInfo.sItemName;
        ListItem.SubItems.Add(inttostr(TRefineItemInfo.nRefineRate));
        ListItem.SubItems.Add(inttostr(TRefineItemInfo.nReductionRate));
        if TRefineItemInfo.boDisappear then
          ListItem.SubItems.Add(inttostr(0))
        else  ListItem.SubItems.Add(inttostr(1));
        ListItem.SubItems.Add(inttostr(TRefineItemInfo.nNeedRate));
        str1:='';
        for K:=0 to 13 do begin
          if str1 <> '' then str1:=str1+',';
          str1:=str1+inttostr(TRefineItemInfo.nAttribute[K].nPoints)+'-'+ inttostr(TRefineItemInfo.nAttribute[K].nDifficult);
        end;
        ListItem.SubItems.Add(Str1);
      finally
        ListView4.Items.EndUpdate;
      end;

      Button13.Enabled:=False;
      Button14.Enabled:=False;
      Button15.Enabled:=True;
      ClearEdt1;
    end else  Application.MessageBox('该配方已存在此物品,不能再重复增加！' ,'提示信息',MB_ICONQUESTION+MB_OK);
  end else Application.MessageBox('请从淬练材料列表中选择要增加物品的配方名！' ,'提示信息',MB_ICONQUESTION+MB_OK);
{$IFEND}
end;

procedure TfrmViewList2.Button13Click(Sender: TObject);
var
  I, K:Integer;
  ItemList:TList;
  sItemName, sItemName1, sItemName2: string;
  TRefineItemInfo:pTRefineItemInfo;
  str,str1:string;
  ListItem: TListItem;
begin
{$IF M2Version <> 2}
if ListView4.ItemIndex >= 0 then begin
  if Label78.Caption <> '' then begin
  str:= ListView4.Items[ListView4.ItemIndex].Caption;//物品名称
  if (str <> '') then begin
    GetBackRefineItemName(Label78.Caption ,sItemName, sItemName1, sItemName2);
    ItemList:=GetRefineItemInfo(sItemName,sItemName1,sItemName2);
    if ItemList.Count > 0 then begin
      for I := 0 to ItemList.Count - 1 do begin
         TRefineItemInfo:=pTRefineItemInfo(ItemList.Items[I]);
         if CompareText(str,TRefineItemInfo.sItemName)= 0 then begin
            TRefineItemInfo.nRefineRate:= SpinEdit1.Value;
            TRefineItemInfo.nReductionRate:= SpinEdit31.Value;
            TRefineItemInfo.boDisappear:= SpinEdit32.Value = 0;//(T)0-减持久 (F)1-消失
            TRefineItemInfo.nNeedRate:= SpinEdit33.Value;
            TRefineItemInfo.nAttribute[0].nPoints:= SpinEdit34.Value;;
            TRefineItemInfo.nAttribute[0].nDifficult:= SpinEdit35.Value;
            TRefineItemInfo.nAttribute[1].nPoints:= SpinEdit36.Value;;
            TRefineItemInfo.nAttribute[1].nDifficult:= SpinEdit49.Value;
            TRefineItemInfo.nAttribute[2].nPoints:= SpinEdit37.Value;
            TRefineItemInfo.nAttribute[2].nDifficult:= SpinEdit50.Value;
            TRefineItemInfo.nAttribute[3].nPoints:= SpinEdit38.Value;
            TRefineItemInfo.nAttribute[3].nDifficult:= SpinEdit51.Value;
            TRefineItemInfo.nAttribute[4].nPoints:= SpinEdit40.Value;
            TRefineItemInfo.nAttribute[4].nDifficult:= SpinEdit52.Value;
            TRefineItemInfo.nAttribute[5].nPoints:= SpinEdit41.Value;
            TRefineItemInfo.nAttribute[5].nDifficult:= SpinEdit53.Value;
            TRefineItemInfo.nAttribute[6].nPoints:= SpinEdit42.Value;
            TRefineItemInfo.nAttribute[6].nDifficult:= SpinEdit54.Value;
            TRefineItemInfo.nAttribute[7].nPoints:= SpinEdit39.Value;
            TRefineItemInfo.nAttribute[7].nDifficult:= SpinEdit55.Value;
            TRefineItemInfo.nAttribute[8].nPoints:= SpinEdit43.Value;
            TRefineItemInfo.nAttribute[8].nDifficult:= SpinEdit56.Value;
            TRefineItemInfo.nAttribute[9].nPoints:= SpinEdit44.Value;
            TRefineItemInfo.nAttribute[9].nDifficult:= SpinEdit57.Value;

            TRefineItemInfo.nAttribute[10].nPoints:= SpinEdit45.Value;
            TRefineItemInfo.nAttribute[10].nDifficult:= SpinEdit58.Value;

            TRefineItemInfo.nAttribute[11].nPoints:= SpinEdit46.Value;
            TRefineItemInfo.nAttribute[11].nDifficult:= SpinEdit59.Value;

            TRefineItemInfo.nAttribute[12].nPoints:= SpinEdit47.Value;
            TRefineItemInfo.nAttribute[12].nDifficult:= SpinEdit60.Value;

            TRefineItemInfo.nAttribute[13].nPoints:= SpinEdit48.Value;
            TRefineItemInfo.nAttribute[13].nDifficult:= SpinEdit61.Value;

            ListItem := ListView4.Items.Item[ListView4.ItemIndex];
            ListItem.Caption := TRefineItemInfo.sItemName;
            ListItem.SubItems.Strings[0] :=inttostr(TRefineItemInfo.nRefineRate);
            ListItem.SubItems.Strings[1] :=inttostr(TRefineItemInfo.nReductionRate);
            ListItem.SubItems.Strings[2] :=inttostr(SpinEdit32.Value);
            ListItem.SubItems.Strings[3] :=inttostr(TRefineItemInfo.nNeedRate);
            str1:='';
            for K:=0 to 13 do begin
              if str1 <> '' then str1:=str1+',';
              str1:=str1+inttostr(TRefineItemInfo.nAttribute[K].nPoints)+'-'+ inttostr(TRefineItemInfo.nAttribute[K].nDifficult);
            end;
            ListItem.SubItems.Strings[4] :=Str1;

            Button13.Enabled:=False;
            Button14.Enabled:=False;
            Button15.Enabled:=True;
            ClearEdt1;
            break;
         end;
      end;
    end;
  end;
 end else Application.MessageBox('请从淬练材料列表中选择要修改物品的配方名！' ,'提示信息',MB_ICONQUESTION+MB_OK);
end;
{$IFEND}
end;

procedure TfrmViewList2.Button14Click(Sender: TObject);
var
 I:Integer;
  ItemList:TList;
  sItemName, sItemName1, sItemName2: string;
  TRefineItemInfo:pTRefineItemInfo;
  str:string;
begin
{$IF M2Version <> 2}
if ListView4.ItemIndex >= 0 then begin
  if Label78.Caption <> '' then begin
    str:= ListView4.Items[ListView4.ItemIndex].Caption;//物品名称
    ListView4.Items.BeginUpdate;
    try
      ListView4.DeleteSelected;
    finally
      ListView4.Items.EndUpdate;
    end;

    if str <> '' then begin
      GetBackRefineItemName(Label78.Caption ,sItemName, sItemName1, sItemName2);
      ItemList:=GetRefineItemInfo(sItemName,sItemName1,sItemName2);
      if ItemList.Count > 0 then begin
        for I := 0 to ItemList.Count - 1 do begin
           TRefineItemInfo:=pTRefineItemInfo(ItemList.Items[I]);
           if CompareText(str,TRefineItemInfo.sItemName)= 0 then begin
              ItemList.Delete(I);
              Button13.Enabled:=False;
              Button14.Enabled:=False;
              Button15.Enabled:=True;
              ClearEdt1;
              break;
           end;
        end;
      end;
    end;
  end else Application.MessageBox('请从淬练材料列表中选择要删除物品的配方名！' ,'提示信息',MB_ICONQUESTION+MB_OK);
end;
{$IFEND}
end;

procedure TfrmViewList2.Button15Click(Sender: TObject);
begin
{$IF M2Version <> 2}
  SaveRefineItemInfo;
  Button13.Enabled:=False;
  Button14.Enabled:=False;
  Button15.Enabled:=False;
{$IFEND}
end;

procedure TfrmViewList2.Button16Click(Sender: TObject);
var
  EffecItem: pTEffecItem;
  sItemName: string;
  I: Integer;
begin
  Try
    sItemName := Trim(Edit7.Text);
    if ComboBox3.text = '' then begin
      Application.MessageBox('包裹资源文件不能为空！', '错误信息', MB_OK + MB_ICONERROR);
      Exit;
    end;
    if ComboBox1.text = '' then begin
      Application.MessageBox('内观资源文件不能为空！', '错误信息', MB_OK + MB_ICONERROR);
      Exit;
    end;
    if ComboBox2.text = '' then begin
      Application.MessageBox('外观资源文件不能为空！', '错误信息', MB_OK + MB_ICONERROR);
      Exit;
    end;
    if EffecItemtList.Items.Count > 0 then begin//20080629
      for I := 0 to EffecItemtList.Items.Count - 1 do begin
        if CompareText(EffecItemtList.Items.Strings[I], sItemName)= 0 then begin
          Application.MessageBox('此物品已在列表中！！！', '错误信息', MB_OK + MB_ICONERROR);
          Exit;
        end;
      end;
    end;
    New(EffecItem);
    EffecItem.wBagIndex:= SpinEdit76.Value;//包裹开始图片
    EffecItem.btBagCount:= SpinEdit77.Value;//包裹播放数量
    EffecItem.nBagX:= SpinEdit78.Value;//包裹X坐标修正
    EffecItem.nBagY:= SpinEdit79.Value;//包裹Y坐标修正
    EffecItem.btBagWilIndex:= ComboBox3.ItemIndex;//包裹Wil索引

    EffecItem.wShapeIndex:= SpinEdit68.Value;//内观开始图片
    EffecItem.btShapeCount:= SpinEdit69.Value;//内观播放数量
    EffecItem.nShapeX:= SpinEdit70.Value;//内观X坐标修正
    EffecItem.nShapeY:= SpinEdit71.Value;//内观Y坐标修正
    EffecItem.btShapeWilIndex:= ComboBox1.ItemIndex;//内观Wil索引

    EffecItem.wLookIndex:= SpinEdit72.Value;//外观开始图片
    //EffecItem.btLookCount:= SpinEdit73.Value;//外观播放数量
    //EffecItem.nLookX:= SpinEdit74.Value;//外观X坐标修正
    //EffecItem.nLookY:= SpinEdit75.Value;//外观Y坐标修正
    EffecItem.btLookWilIndex:= ComboBox2.ItemIndex;//外观Wil索引

    EffecItemtList.AddItem(sItemName, Tobject(EffecItem));
    Button19.Enabled := True;
    Button16.Enabled:= False;
  except
    MainOutMessage(Format('{%s} TfrmViewList2.Button16Click',[g_sExceptionVer]));
  end;
end;

procedure TfrmViewList2.Button17Click(Sender: TObject);
begin
  try
    EffecItemtList.DeleteSelected;
    Button19.Enabled := True;
  except
    Button19.Enabled := False;
  end;
end;

procedure TfrmViewList2.Button18Click(Sender: TObject);
var
  EffecItem: pTEffecItem;
  nItemIndex: Integer;
begin
  Try
    nItemIndex := EffecItemtList.ItemIndex;
    if nItemIndex < 0 then begin
      Application.MessageBox('未选择需要修改的目标', '错误信息', MB_OK + MB_ICONERROR);
      Exit;
    end;
    if ComboBox3.text = '' then begin
      Application.MessageBox('包裹资源文件不能为空！', '错误信息', MB_OK + MB_ICONERROR);
      Exit;
    end;
    if ComboBox1.text = '' then begin
      Application.MessageBox('内观资源文件不能为空！', '错误信息', MB_OK + MB_ICONERROR);
      Exit;
    end;
    if ComboBox2.text = '' then begin
      Application.MessageBox('外观资源文件不能为空！', '错误信息', MB_OK + MB_ICONERROR);
      Exit;
    end;  

    EffecItem:= pTEffecItem(EffecItemtList.Items.Objects[nItemIndex]);
    if EffecItem <> nil then begin
      EffecItem.wBagIndex:= SpinEdit76.Value;//包裹开始图片
      EffecItem.btBagCount:= SpinEdit77.Value;//包裹播放数量
      EffecItem.nBagX:= SpinEdit78.Value;//包裹X坐标修正
      EffecItem.nBagY:= SpinEdit79.Value;//包裹Y坐标修正
      EffecItem.btBagWilIndex:= ComboBox3.ItemIndex;//包裹Wil索引

      EffecItem.wShapeIndex:= SpinEdit68.Value;//内观开始图片
      EffecItem.btShapeCount:= SpinEdit69.Value;//内观播放数量
      EffecItem.nShapeX:= SpinEdit70.Value;//内观X坐标修正
      EffecItem.nShapeY:= SpinEdit71.Value;//内观Y坐标修正
      EffecItem.btShapeWilIndex:= ComboBox1.ItemIndex;//内观Wil索引

      EffecItem.wLookIndex:= SpinEdit72.Value;//外观开始图片
      //EffecItem.btLookCount:= SpinEdit73.Value;//外观播放数量
      //EffecItem.nLookX:= SpinEdit74.Value;//外观X坐标修正
      //EffecItem.nLookY:= SpinEdit75.Value;//外观Y坐标修正
      EffecItem.btLookWilIndex:= ComboBox2.ItemIndex;//外观Wil索引
      Button19.Enabled := True;
      Button18.Enabled := False;
    end;
  except
    MainOutMessage(Format('{%s} TfrmViewList2.Button18Click',[g_sExceptionVer]));
  end;
end;

procedure TfrmViewList2.Button19Click(Sender: TObject);
var
  I: Integer;
  SaveList: TStringList;
  sFileName, sLineText, sItemName: string;
  sPackLook, sPackPlay,sPackX,sPackY,sPackWilName: string;
  sWithinLook,sWithinPlay,sWithinX,sWithinY,sWithinWilName: string;
  sOutsideLook,{sOutsidePlay,sOutsideX,sOutsideY,}sOutsideWilName: string;
begin
  Try
    Button19.Enabled := False;
    sFileName := g_Config.sEnvirDir + 'EffectItemList.txt';
    SaveList := TStringList.Create;
    try
       SaveList.Add(';物品特效配置文件');
       SaveList.Add(';物品名称'#9'包裹图片'#9'包裹播放'#9'包裹X'#9'包裹Y'#9'包裹Wil'#9'内观图片'#9'内观播放'#9'内观X'#9'内观Y'#9'内观Wil'#9'外观图片'#9'外观播放'#9'外观X'#9'外观Y'#9'外观Wil');
      if EffecItemtList.Items.Count > 0 then begin//20080629
        for I := 0 to EffecItemtList.Items.Count - 1 do begin
          sItemName := EffecItemtList.Items.Strings[I];
          sPackLook:= IntToStr(pTEffecItem(EffecItemtList.Items.Objects[I]).wBagIndex);
          sPackPlay:= IntToStr(pTEffecItem(EffecItemtList.Items.Objects[I]).btBagCount);
          sPackX:= IntToStr(pTEffecItem(EffecItemtList.Items.Objects[I]).nBagX);
          sPackY:= IntToStr(pTEffecItem(EffecItemtList.Items.Objects[I]).nBagY);
          sPackWilName:= IntToStr(pTEffecItem(EffecItemtList.Items.Objects[I]).btBagWilIndex);

          sWithinLook:= IntToStr(pTEffecItem(EffecItemtList.Items.Objects[I]).wShapeIndex);
          sWithinPlay:= IntToStr(pTEffecItem(EffecItemtList.Items.Objects[I]).btShapeCount);
          sWithinX:= IntToStr(pTEffecItem(EffecItemtList.Items.Objects[I]).nShapeX);
          sWithinY:= IntToStr(pTEffecItem(EffecItemtList.Items.Objects[I]).nShapeY);
          sWithinWilName:= IntToStr(pTEffecItem(EffecItemtList.Items.Objects[I]).btShapeWilIndex);

          sOutsideLook:=IntToStr(pTEffecItem(EffecItemtList.Items.Objects[I]).wLookIndex);
          {sOutsidePlay:=IntToStr(pTEffecItem(EffecItemtList.Items.Objects[I]).btLookCount);
          sOutsideX:=IntToStr(pTEffecItem(EffecItemtList.Items.Objects[I]).nLookX);
          sOutsideY:=IntToStr(pTEffecItem(EffecItemtList.Items.Objects[I]).nLookY);   }
          sOutsideWilName:=IntToStr(pTEffecItem(EffecItemtList.Items.Objects[I]).btLookWilIndex);

          sLineText := sItemName + #9 +
                       sPackLook + #9 + sPackPlay + #9 + sPackX + #9 + sPackY + #9 +sPackWilName + #9 +
                       sWithinLook + #9 + sWithinPlay + #9 + sWithinX + #9 + sWithinY + #9 + sWithinWilName+ #9 +
                       sOutsideLook + #9 {+ sOutsidePlay + #9 + sOutsideX + #9 + sOutsideY + #9} + sOutsideWilName;
          SaveList.Add(sLineText);
        end;
      end;
      SaveList.SaveToFile(sFileName);
    finally
      SaveList.Free;
    end;

    //LoadEffecItemList();
    //RefLoadEffecItems();
    //ShowMessage('保存成功.请将 ' +sFileName+' 更新到客户端');

    if Application.MessageBox('此设置必须重新加载物品特效配置才能生效，是否重新加载？', '确认信息', MB_YESNO + MB_ICONQUESTION) = mrYes then begin
      LoadEffecItemList();
      RefLoadEffecItems();
    end else begin
      Button19.Enabled := True;
      Exit;
    end;
    Button19.Enabled := False;
  except
    MainOutMessage(Format('{%s} TfrmViewList2.Button19Click',[g_sExceptionVer]));
  end;
end;

//------------------------自定义命令---------------------------------
function TfrmViewList2.InCommandListOfName(sCommandName: string): Boolean;
var
  I: Integer;
begin
  Result := False;
  if ListBoxUserCommand.Items.Count > 0 then begin//20080629
    for I := 0 to ListBoxUserCommand.Items.Count - 1 do begin
      if CompareText(sCommandName, ListBoxUserCommand.Items.Strings[I]) = 0 then begin
        Result := TRUE;
        break;
      end;
    end;
  end;
end;

function TfrmViewList2.InCommandListOfIndex(nIndex: Integer): Boolean;
var
  I: Integer;
begin
  Result := False;
  if ListBoxUserCommand.Items.Count > 0 then begin//20080629
    for I := 0 to ListBoxUserCommand.Items.Count - 1 do begin
      if nIndex = Integer(ListBoxUserCommand.Items.Objects[I]) then begin
        Result := TRUE;
        break;
      end;
    end;
  end;
end;

procedure TfrmViewList2.ButtonUserCommandAddClick(Sender: TObject);
var
  sCommandName: string;
  nCommandIndex: Integer;
begin
  sCommandName := Trim(EditCommandName.Text);
  nCommandIndex := SpinEditCommandIdx.Value;
  if sCommandName = '' then begin
    Application.MessageBox('请输入命令！！！', '提示信息', MB_ICONQUESTION);
    Exit;
  end;
  if InCommandListOfName(sCommandName) then begin
    Application.MessageBox('输入的命令已经存在，请选择其他命令！！！', '提示信息', MB_ICONQUESTION);
    Exit;
  end;
  if InCommandListOfIndex(nCommandIndex) then begin
    Application.MessageBox('输入的命令编号已经存在，请选择其他命令编号！！！', '提示信息', MB_ICONQUESTION);
    Exit;
  end;
  ListBoxUserCommand.Items.AddObject(sCommandName, TObject(nCommandIndex));
end;

procedure TfrmViewList2.ButtonUserCommandDelClick(Sender: TObject);
begin
  if Application.MessageBox('是否确认删除此命令？', '确认信息', MB_YESNO + MB_ICONQUESTION) = mrYes then begin
    try
      ListBoxUserCommand.DeleteSelected;
    except
    end;
  end;
end;

procedure TfrmViewList2.ButtonUserCommandChgClick(Sender: TObject);
var
  sCommandName: string;
  nCommandIndex: Integer;
  nItemIndex: Integer;
begin
  sCommandName := Trim(EditCommandName.Text);
  nCommandIndex := SpinEditCommandIdx.Value;
  if sCommandName = '' then begin
    Application.MessageBox('请输入命令！！！', '提示信息', MB_ICONQUESTION);
    Exit;
  end;
  if InCommandListOfName(sCommandName) then begin
    Application.MessageBox('你要修改的命令已经存在，请选择其他命令！！！', '提示信息', MB_ICONQUESTION);
    Exit;
  end;
  if InCommandListOfIndex(nCommandIndex) then begin
    Application.MessageBox('你要修改的命令编号已经存在，请选择其他命令编号！！！', '提示信息', MB_ICONQUESTION);
    Exit;
  end;
  nItemIndex := ListBoxUserCommand.ItemIndex;
  try
    ListBoxUserCommand.Items.Strings[nItemIndex] := sCommandName;
    ListBoxUserCommand.Items.Objects[nItemIndex] := TObject(nCommandIndex);
    Application.MessageBox('修改完成！！！', '提示信息', MB_ICONQUESTION);
  except
    Application.MessageBox('修改失败！！！', '提示信息', MB_ICONQUESTION);
  end;
end;

procedure TfrmViewList2.ButtonUserCommandSaveClick(Sender: TObject);
var
  sFileName: string;
  I: Integer;
  sCommandName: string;
  nCommandIndex: Integer;
  SaveList: TStringList;
begin
  ButtonUserCommandSave.Enabled := False;
  sFileName := '.\UserCmd.txt';
  SaveList := TStringList.Create;
  SaveList.Add(';引擎插件配置文件');
  SaveList.Add(';命令名称'#9'对应编号');
  if ListBoxUserCommand.Items.Count > 0 then begin//20080629
    for I := 0 to ListBoxUserCommand.Items.Count - 1 do begin
      sCommandName := ListBoxUserCommand.Items.Strings[I];
      nCommandIndex := Integer(ListBoxUserCommand.Items.Objects[I]);
      SaveList.Add(sCommandName + #9 + IntToStr(nCommandIndex));
    end;
  end;
  SaveList.SaveToFile(sFileName);
  SaveList.Free;
  Application.MessageBox('保存完成！！！', '提示信息', MB_ICONQUESTION);
  ButtonUserCommandSave.Enabled := TRUE;
end;

procedure TfrmViewList2.ButtonLoadUserCommandListClick(Sender: TObject);
begin
  ButtonLoadUserCommandList.Enabled := False;
  LoadUserCmdList();
  ListBoxUserCommand.Items.Clear;
  ListBoxUserCommand.Items.AddStrings(g_UserCmdList);
  Application.MessageBox('重新加载自定义命令列表完成！！！', '提示信息', MB_ICONQUESTION);
  ButtonLoadUserCommandList.Enabled := TRUE;
end;

procedure TfrmViewList2.TabSheet5Show(Sender: TObject);
begin
  ListBoxUserCommand.Items.Clear;
  ListBoxUserCommand.Items.AddStrings(g_UserCmdList);
end;

procedure TfrmViewList2.ListBoxUserCommandClick(Sender: TObject);
begin
  try
    EditCommandName.Text := ListBoxUserCommand.Items.Strings[ListBoxUserCommand.ItemIndex];
    SpinEditCommandIdx.Value := Integer(ListBoxUserCommand.Items.Objects[ListBoxUserCommand.ItemIndex]);
    ButtonUserCommandDel.Enabled := TRUE;
    ButtonUserCommandChg.Enabled := TRUE;
  except
    EditCommandName.Text := '';
    SpinEditCommandIdx.Value := 0;
    ButtonUserCommandDel.Enabled := False;
    ButtonUserCommandChg.Enabled := False;
  end;
end;

//-------------------------禁止物品设置------------------------------
procedure TfrmViewList2.DisallowSelAll(SelAll: Boolean);
begin
  if SelAll then begin
    CheckBoxDisallowDrop.Checked         := True;
    CheckBoxDisallowDeal.Checked         := True;
    CheckBoxDisallowStorage.Checked      := True;
    CheckBoxDisallowRepair.Checked       := True;
    CheckBoxDisallowDropHint.Checked     := True;
    CheckBoxDisallowOpenBoxsHint.Checked := True;
    CheckBoxDisallowNoDropItem.Checked   := True;
    CheckBoxDisallowButchHint.Checked    := True;
    CheckBoxDisallowHeroUse.Checked      := True;
    CheckBoxDisallowPickUpItem.Checked:= True;
    CheckBoxDieDropItems.Checked := True;
    CheckBoxBuyShopItemGive.Checked := True;
    CheckBoxButchItem.Checked := True;
    CheckBoxRefineItem.Checked := True;
    CheckBoxNpcGiveItem.Checked := True;
    CheckBoxDigJewelHint.Checked := True;
    CheckBox24HourDisap.Checked := True;
  end else begin
    CheckBoxDisallowDrop.Checked         := False;
    CheckBoxDisallowDeal.Checked         := False;
    CheckBoxDisallowStorage.Checked      := False;
    CheckBoxDisallowRepair.Checked       := False;
    CheckBoxDisallowDropHint.Checked     := False;
    CheckBoxDisallowOpenBoxsHint.Checked := False;
    CheckBoxDisallowNoDropItem.Checked   := False;
    CheckBoxDisallowButchHint.Checked    := False;
    CheckBoxDisallowHeroUse.Checked      := False;
    CheckBoxDisallowPickUpItem.Checked:= False;
    CheckBoxDieDropItems.Checked := False;
    CheckBoxBuyShopItemGive.Checked := False;
    CheckBoxButchItem.Checked := False;
    CheckBoxRefineItem.Checked := False;
    CheckBoxNpcGiveItem.Checked := False;
    CheckBoxDigJewelHint.Checked := False;
    CheckBox24HourDisap.Checked := False;
  end;
end;

procedure TfrmViewList2.EffecItemtListClick(Sender: TObject);
begin
  try
    Edit7.Text := EffecItemtList.Items.Strings[EffecItemtList.ItemIndex];
    SpinEdit76.Value := pTEffecItem(EffecItemtList.Items.Objects[EffecItemtList.ItemIndex]).wBagIndex;
    SpinEdit77.Value := pTEffecItem(EffecItemtList.Items.Objects[EffecItemtList.ItemIndex]).btBagCount;
    SpinEdit78.Value := pTEffecItem(EffecItemtList.Items.Objects[EffecItemtList.ItemIndex]).nBagX;
    SpinEdit79.Value := pTEffecItem(EffecItemtList.Items.Objects[EffecItemtList.ItemIndex]).nBagY;
    //ComboBox3.text := ComboBox3.Items[pTEffecItem(EffecItemtList.Items.Objects[EffecItemtList.ItemIndex]).btBagWilIndex];
    ComboBox3.ItemIndex:= pTEffecItem(EffecItemtList.Items.Objects[EffecItemtList.ItemIndex]).btBagWilIndex;

    SpinEdit68.Value := pTEffecItem(EffecItemtList.Items.Objects[EffecItemtList.ItemIndex]).wShapeIndex;
    SpinEdit69.Value := pTEffecItem(EffecItemtList.Items.Objects[EffecItemtList.ItemIndex]).btShapeCount;
    SpinEdit70.Value := pTEffecItem(EffecItemtList.Items.Objects[EffecItemtList.ItemIndex]).nShapeX;
    SpinEdit71.Value := pTEffecItem(EffecItemtList.Items.Objects[EffecItemtList.ItemIndex]).nShapeY;
    //ComboBox1.text := ComboBox1.Items[pTEffecItem(EffecItemtList.Items.Objects[EffecItemtList.ItemIndex]).btShapeWilIndex];
    ComboBox1.ItemIndex:= pTEffecItem(EffecItemtList.Items.Objects[EffecItemtList.ItemIndex]).btShapeWilIndex;

    SpinEdit72.Value := pTEffecItem(EffecItemtList.Items.Objects[EffecItemtList.ItemIndex]).wLookIndex;
    //SpinEdit73.Value := pTEffecItem(EffecItemtList.Items.Objects[EffecItemtList.ItemIndex]).btLookCount;
    //SpinEdit74.Value := pTEffecItem(EffecItemtList.Items.Objects[EffecItemtList.ItemIndex]).nLookX;
    //SpinEdit75.Value := pTEffecItem(EffecItemtList.Items.Objects[EffecItemtList.ItemIndex]).nLookY;
    //ComboBox2.text := ComboBox2.Items[pTEffecItem(EffecItemtList.Items.Objects[EffecItemtList.ItemIndex]).btLookWilIndex];
    ComboBox2.ItemIndex:= pTEffecItem(EffecItemtList.Items.Objects[EffecItemtList.ItemIndex]).btLookWilIndex;

    Button17.Enabled := True;
    Button18.Enabled := True;
    Button16.Enabled := False;
  except
    Edit7.Text := '';
  end;
end;

procedure TfrmViewList2.RefLoadDisallowStdItems();
var
  I: Integer;
  CheckItem: pTCheckItem;
  sItemName: string;
  DisallowInfo: pTDisallowInfo;
begin
  Try
    if ListBoxDisallow.Items.count > 0 then begin
      for I:= 0 to ListBoxDisallow.Items.count -1 do begin
        Dispose(pTDisallowInfo(ListBoxDisallow.Items.objects[I]));
      end;
      ListBoxDisallow.Items.Clear;
    end;
    if g_CheckItemList.Count > 0 then begin//20080629
      for I := 0 to g_CheckItemList.Count - 1 do begin
        CheckItem := pTCheckItem(g_CheckItemList.Objects[I]);
        if CheckItem <> nil then begin//20090205
          sItemName := CheckItem.szItemName;
          New(DisallowInfo);
          DisallowInfo.boDrop := CheckItem.boCanDrop;
          DisallowInfo.boDeal := CheckItem.boCanDeal;
          DisallowInfo.boStorage := CheckItem.boCanStorage;
          DisallowInfo.boRepair := CheckItem.boCanRepair;
          DisallowInfo.boDropHint := CheckItem.boCanDropHint;
          DisallowInfo.boOpenBoxsHint := CheckItem.boCanOpenBoxsHint;
          DisallowInfo.boNoDropItem := CheckItem.boCanNoDropItem;
          DisallowInfo.boButchHint := CheckItem.boCanButchHint;
          DisallowInfo.boHeroUse := CheckItem.boCanHeroUse;
          DisallowInfo.boPickUpItem := CheckItem.boPickUpItem;//禁止捡起(除GM外) 20080611
          DisallowInfo.boDieDropItems := CheckItem.boDieDropItems;//死亡掉落 20080614
          DisallowInfo.boBuyShopItemGive := CheckItem.boBuyShopItemGive;//禁止商铺赠送 20090205
          DisallowInfo.boButchItem := CheckItem.boButchItem;//禁止挖 20090221
          DisallowInfo.boRefineItem := CheckItem.boRefineItem;//淬练提示 20100405
          DisallowInfo.boNpcGiveItem := CheckItem.boNpcGiveItem;//一定时间才能捡起 20100530
          DisallowInfo.boCanDigJewelHint := CheckItem.boCanDigJewelHint;//挖宝提示
          DisallowInfo.bo24HourDisap := CheckItem.bo24HourDisap;//24时消失
          DisallowInfo.boPermanentBind := CheckItem.boPermanentBind;//永久绑定
          DisallowInfo.bo48HourUnBind := CheckItem.bo48HourUnBind;//绑定48时
          
          ListBoxDisallow.AddItem(sItemName, TObject(DisallowInfo));
        end;
      end;
    end;
  except
    MainOutMessage(Format('{%s} TfrmViewList2.RefLoadDisallowStdItems',[g_sExceptionVer]));
  end;
end;


procedure TfrmViewList2.BtnDisallowSelAllClick(Sender: TObject);
begin
  DisallowSelAll(True);
end;

procedure TfrmViewList2.BtnDisallowCancelAllClick(Sender: TObject);
begin
  DisallowSelAll(False);
end;

procedure TfrmViewList2.ListBoxitemListClick(Sender: TObject);
begin
  try
    EditItemName.Text := ListBoxitemList.Items.Strings[ListBoxitemList.ItemIndex];
    DisallowSelAll(False);
    BtnDisallowAdd.Enabled := True;
    BtnDisallowDel.Enabled := False;
    BtnDisallowChg.Enabled := False;
  except
    EditItemName.Text := '';
    BtnDisallowAdd.Enabled := False;
  end;
end;

procedure TfrmViewList2.ListBoxitemListKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  s: string;
  I: Integer;
begin
  if Key = Word('F') then begin
   if ssCtrl in Shift then begin
      s := inputBox('查找物品','请输入要查找的物品名字:','');
      if ListBoxitemList.Count > 0 then begin//20080629
        for I:=0 to ListBoxitemList.Count - 1 do begin
          if CompareText(ListBoxItemList.Items.Strings[I],s) = 0 then begin
             ListBoxItemList.ItemIndex:=I;
             Exit;
          end;
        end;
      end;
   end;
  end;
end;

procedure TfrmViewList2.BtnDisallowAddClick(Sender: TObject);
var
  DisallowInfo: pTDisallowInfo;
  sItemName: string;
  I: Integer;
begin
  Try
    sItemName := Trim(EditItemName.Text);
    if ListBoxDisallow.Items.Count > 0 then begin//20080629
      for I := 0 to ListBoxDisallow.Items.Count - 1 do begin
        if CompareText(ListBoxDisallow.Items.Strings[I], sItemName)= 0 then begin
          Application.MessageBox('此物品已在列表中！！！', '错误信息', MB_OK + MB_ICONERROR);
          Exit;
        end;
      end;
    end;
    New(DisallowInfo);
    DisallowInfo.boDrop := CheckBoxDisallowDrop.Checked; //禁止丢弃
    DisallowInfo.boDeal := CheckBoxDisallowDeal.Checked; //禁止交易
    DisallowInfo.boStorage := CheckBoxDisallowStorage.Checked; //禁止存仓
    DisallowInfo.boRepair := CheckBoxDisallowRepair.Checked; //禁止修理
    DisallowInfo.boDropHint := CheckBoxDisallowDropHint.Checked; //掉落提示
    DisallowInfo.boOpenBoxsHint := CheckBoxDisallowOpenBoxsHint.Checked; //宝箱提示
    DisallowInfo.boNoDropItem := CheckBoxDisallowNoDropItem.Checked; //永不爆出
    DisallowInfo.boButchHint := CheckBoxDisallowButchHint.Checked; //挖取提示
    DisallowInfo.boHeroUse := CheckBoxDisallowHeroUse.Checked; //禁止英雄使用
    DisallowInfo.boPickUpItem := CheckBoxDisallowPickUpItem.Checked;//禁止捡起(除GM外) 20080611
    DisallowInfo.boDieDropItems := CheckBoxDieDropItems.Checked;//死亡掉落 20080614
    DisallowInfo.boBuyShopItemGive := CheckBoxBuyShopItemGive.Checked;//禁止商铺赠送 20090205
    DisallowInfo.boButchItem := CheckBoxButchItem.Checked;//禁止挖 20090221
    DisallowInfo.boRefineItem := CheckBoxRefineItem.Checked;//淬练提示 20100405
    DisallowInfo.boNpcGiveItem := CheckBoxNpcGiveItem.Checked;//一定时间才能捡起 20100530
    DisallowInfo.boCanDigJewelHint := CheckBoxDigJewelHint.Checked;//挖宝提示
    DisallowInfo.bo24HourDisap := CheckBox24HourDisap.Checked;//24时消失
    DisallowInfo.boPermanentBind := CheckBoxPermanentBind.Checked;//永久绑定
    DisallowInfo.bo48HourUnBind := CheckBox48HourUnBind.Checked;//绑定48时
    ListBoxDisallow.AddItem(sItemName, Tobject(DisallowInfo));
    BtnDisallowSave.Enabled := True;
  except
    MainOutMessage(Format('{%s} TfrmViewList2.BtnDisallowAddClick',[g_sExceptionVer]));
  end;
end;

procedure TfrmViewList2.BtnDisallowDelClick(Sender: TObject);
begin
  try
    ListBoxDisallow.DeleteSelected;
    BtnDisallowSave.Enabled := True;
  except
    BtnDisallowSave.Enabled := False;
  end;
end;

procedure TfrmViewList2.BtnDisallowAddAllClick(Sender: TObject);
var
  DisallowInfo: pTDisallowInfo;
  I: Integer;
begin
  Try
    ListBoxDisallow.Items.Clear;
    if ListBoxitemList.Items.Count > 0 then begin//20080629
      for I := 0 to ListBoxitemList.Items.Count - 1 do begin
        New(DisallowInfo);
        DisallowInfo.boDrop := CheckBoxDisallowDrop.Checked; //禁止丢弃
        DisallowInfo.boDeal := CheckBoxDisallowDeal.Checked; //禁止交易
        DisallowInfo.boStorage := CheckBoxDisallowStorage.Checked; //禁止存仓
        DisallowInfo.boRepair := CheckBoxDisallowRepair.Checked; //禁止修理
        DisallowInfo.boDropHint := CheckBoxDisallowDropHint.Checked; //掉落提示
        DisallowInfo.boOpenBoxsHint := CheckBoxDisallowOpenBoxsHint.Checked; //宝箱提示
        DisallowInfo.boNoDropItem := CheckBoxDisallowNoDropItem.Checked; //永不爆出
        DisallowInfo.boButchHint := CheckBoxDisallowButchHint.Checked; //挖取提示
        DisallowInfo.boHeroUse := CheckBoxDisallowHeroUse.Checked; //禁止英雄使用
        DisallowInfo.boPickUpItem := CheckBoxDisallowPickUpItem.Checked;//禁止捡起(除GM外) 20080611
        DisallowInfo.boDieDropItems := CheckBoxDieDropItems.Checked;//死亡掉落 20080614
        DisallowInfo.boBuyShopItemGive := CheckBoxBuyShopItemGive.Checked;//禁止商铺赠送 20090205
        DisallowInfo.boButchItem := CheckBoxButchItem.Checked;//禁止挖 20090221
        DisallowInfo.boRefineItem := CheckBoxRefineItem.Checked;//淬练提示 20100407
        DisallowInfo.boNpcGiveItem := CheckBoxNpcGiveItem.Checked;//一定时间才能捡起 20100530
        DisallowInfo.boCanDigJewelHint := CheckBoxDigJewelHint.Checked;//挖宝提示
        DisallowInfo.bo24HourDisap := CheckBox24HourDisap.Checked;//24时消失
        DisallowInfo.boPermanentBind := CheckBoxPermanentBind.Checked;//永久绑定
        DisallowInfo.bo48HourUnBind := CheckBox48HourUnBind.Checked;//绑定48时
        ListBoxDisallow.AddItem(ListBoxitemList.Items[I], Tobject(DisallowInfo));
      end;
    end;
    BtnDisallowSave.Enabled := True;
  except
    MainOutMessage(Format('{%s} TfrmViewList2.BtnDisallowAddAllClick',[g_sExceptionVer]));
  end;
end;

procedure TfrmViewList2.BtnDisallowDelAllClick(Sender: TObject);
begin
  ListBoxDisallow.Items.Clear;
  BtnDisallowSave.Enabled := True;
end;

procedure TfrmViewList2.BtnDisallowChgClick(Sender: TObject);
var
  DisallowInfo: pTDisallowInfo;
  nItemIndex: Integer;
begin
  Try
    nItemIndex := ListBoxDisallow.ItemIndex;
    DisallowInfo:= pTDisallowInfo(ListBoxDisallow.Items.Objects[nItemIndex]);
    if DisallowInfo <> nil then begin
      DisallowInfo.boDrop := CheckBoxDisallowDrop.Checked; //禁止丢弃
      DisallowInfo.boDeal := CheckBoxDisallowDeal.Checked; //禁止交易
      DisallowInfo.boStorage := CheckBoxDisallowStorage.Checked; //禁止存仓
      DisallowInfo.boRepair := CheckBoxDisallowRepair.Checked; //禁止修理
      DisallowInfo.boDropHint := CheckBoxDisallowDropHint.Checked; //掉落提示
      DisallowInfo.boOpenBoxsHint := CheckBoxDisallowOpenBoxsHint.Checked; //宝箱提示
      DisallowInfo.boNoDropItem := CheckBoxDisallowNoDropItem.Checked; //永不爆出
      DisallowInfo.boButchHint := CheckBoxDisallowButchHint.Checked; //挖取提示
      DisallowInfo.boHeroUse := CheckBoxDisallowHeroUse.Checked; //禁止英雄使用
      DisallowInfo.boPickUpItem := CheckBoxDisallowPickUpItem.Checked;//禁止捡起(除GM外) 20080611
      DisallowInfo.boDieDropItems := CheckBoxDieDropItems.Checked;//死亡掉落 20080614
      DisallowInfo.boBuyShopItemGive := CheckBoxBuyShopItemGive.Checked;//禁止商铺赠送 20090205
      DisallowInfo.boButchItem := CheckBoxButchItem.Checked;//禁止挖 20090221
      DisallowInfo.boRefineItem := CheckBoxRefineItem.Checked;//淬练提示 20100407
      DisallowInfo.boNpcGiveItem := CheckBoxNpcGiveItem.Checked;//一定时间才能捡起 20100530
      DisallowInfo.boCanDigJewelHint := CheckBoxDigJewelHint.Checked;//挖宝提示
      DisallowInfo.bo24HourDisap := CheckBox24HourDisap.Checked;//24时消失
      DisallowInfo.boPermanentBind := CheckBoxPermanentBind.Checked;//永久绑定
      DisallowInfo.bo48HourUnBind := CheckBox48HourUnBind.Checked;//绑定48时
      BtnDisallowSave.Enabled := True;
      BtnDisallowChg.Enabled := False;
    end;
  except
    MainOutMessage(Format('{%s} TfrmViewList2.BtnDisallowChgClick',[g_sExceptionVer]));
  end;
end;

procedure TfrmViewList2.BtnDisallowSaveClick(Sender: TObject);
var
  I: Integer;
  SaveList: TStringList;
  sFileName, sLineText, sItemName, sCanDigJewelHint, s24HourDisap, sPermanentBind, s48HourUnBind: string;
  sCanDrop, sCanDeal, sCanStorage, sCanRepair, sCanDropHint, sCanOpenBoxsHint, sNpcGiveItem: string;
  sCanNoDropItem, sCanButchHint, sCanHeroUse, sCanPickUpItem, sCanDieDropItems, sCanBuyShopItemGive, sCanButchItem, sCanRefineItem: string;
begin
  Try
    Config.WriteInteger('Setup', 'LimitItemTime', g_Config.nLimitItemTime);
    BtnDisallowSave.Enabled := False;
    sFileName := '.\CheckItemList.txt';
    SaveList := TStringList.Create;
    try
      SaveList.Add(';引擎插件禁止物品配置文件');
      SaveList.Add(';物品名称'#9'丢弃'#9'交易'#9'存仓'#9'修理'#9'掉落提示'#9'开宝箱提示'#9'永不暴出'#9'挖取提示');
      if ListBoxDisallow.Items.Count > 0 then begin//20080629
        for I := 0 to ListBoxDisallow.Items.Count - 1 do begin
          sItemName := ListBoxDisallow.Items.Strings[I];
          sCanDrop := BoolToIntStr(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boDrop);
          sCanDeal := BoolToIntStr(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boDeal);
          sCanStorage := BoolToIntStr(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boStorage);
          sCanRepair := BoolToIntStr(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boRepair);
          sCanDropHint := BoolToIntStr(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boDropHint);
          sCanOpenBoxsHint := BoolToIntStr(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boOpenBoxsHint);
          sCanNoDropItem := BoolToIntStr(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boNoDropItem);
          sCanButchHint := BoolToIntStr(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boButchHint);
          sCanHeroUse := BoolToIntStr(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boHeroUse);
          sCanPickUpItem := BoolToIntStr(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boPickUpItem);//是否禁止捡起(除GM外) 20080611
          sCanDieDropItems:= BoolToIntStr(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boDieDropItems);//死亡掉落 20080614
          sCanBuyShopItemGive:= BoolToIntStr(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boBuyShopItemGive);//禁止商铺赠送 20090205
          sCanButchItem:= BoolToIntStr(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boButchItem);//禁止挖 20090221
          sCanRefineItem:= BoolToIntStr(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boRefineItem);//淬练提示 20100407
          sNpcGiveItem:= BoolToIntStr(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boNpcGiveItem);//一定时间才能捡起 20100530
          sCanDigJewelHint:= BoolToIntStr(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boCanDigJewelHint);//挖宝提示
          s24HourDisap:= BoolToIntStr(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).bo24HourDisap);//24时消失
          sPermanentBind:= BoolToIntStr(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boPermanentBind);//永久绑定
          s48HourUnBind:= BoolToIntStr(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).bo48HourUnBind);//绑定48时

          sLineText := sItemName + #9 + sCanDrop + #9 + sCanDeal + #9 + sCanStorage + #9 +
                       sCanRepair + #9 +sCanDropHint + #9 + sCanOpenBoxsHint + #9 + sCanNoDropItem + #9 +
                       sCanButchHint + #9 + sCanHeroUse + #9 + sCanPickUpItem+ #9 +sCanDieDropItems + #9 +
                       sCanBuyShopItemGive + #9 + sCanButchItem + #9 + sCanRefineItem + #9 + sNpcGiveItem + #9 +
                       sCanDigJewelHint + #9 + s24HourDisap + #9 + sPermanentBind + #9 + s48HourUnBind;
          SaveList.Add(sLineText);
        end;
      end;
      SaveList.SaveToFile(sFileName);
    finally
      SaveList.Free;
    end;
    if Application.MessageBox('此设置必须重新加载物品配置才能生效，是否重新加载？', '确认信息', MB_YESNO + MB_ICONQUESTION) = mrYes then begin
      LoadCheckItemList();
      RefLoadDisallowStdItems();
    end else begin
      BtnDisallowSave.Enabled := True;
      Exit;
    end;
    BtnDisallowSave.Enabled := False;
  except
    MainOutMessage(Format('{%s} TfrmViewList2.BtnDisallowSaveClick',[g_sExceptionVer]));
  end;
end;

procedure TfrmViewList2.TabSheet6Show(Sender: TObject);
var
  I: Integer;
  StdItem: pTStdItem;
begin
  SpinEditLimitItemTime.Value := g_Config.nLimitItemTime;
  ListBoxitemList.Items.Clear;
  ListBoxitemList.Items.Add('经验');
  ListBoxitemList.Items.Add('经验(大量)');
  ListBoxitemList.Items.Add('经验(海量)');
  ListBoxitemList.Items.Add('声望');
  ListBoxitemList.Items.Add(g_Config.sGameDiaMond);//金刚石
  ListBoxitemList.Items.Add(g_Config.sGameGird); //灵符
  ListBoxitemList.Items.Add(Format('%s(大量)',[g_Config.sGameGird]));//灵符(大量)
  ListBoxitemList.Items.Add(Format('%s(海量)',[g_Config.sGameGird]));//灵符(海量)
  {$IF M2Version <> 2}
  ListBoxitemList.Items.Add('内功');
  ListBoxitemList.Items.Add('内功(大量)');
  ListBoxitemList.Items.Add('内功(海量)');
  {$IFEND}
  if UserEngine.StdItemList <> nil then begin
    if UserEngine.StdItemList.Count > 0 then begin//20080629
      for I := 0 to UserEngine.StdItemList.Count - 1 do begin
        StdItem:= pTStdItem(UserEngine.StdItemList.Items[I]);
        //ListBoxitemList.Items.AddObject(StdItem.Name, TObject(StdItem));
        ListBoxitemList.Items.Add(StdItem.Name);
      end;
    end;
  end;
  RefLoadDisallowStdItems();
end;

procedure TfrmViewList2.ListBoxDisallowClick(Sender: TObject);
begin
  try
    EditItemName.Text := ListBoxDisallow.Items.Strings[ListBoxDisallow.ItemIndex];
    CheckBoxDisallowDrop.Checked := pTDisallowInfo(ListBoxDisallow.Items.Objects[ListBoxDisallow.ItemIndex]).boDrop;
    CheckBoxDisallowDeal.Checked := pTDisallowInfo(ListBoxDisallow.Items.Objects[ListBoxDisallow.ItemIndex]).boDeal;
    CheckBoxDisallowStorage.Checked := pTDisallowInfo(ListBoxDisallow.Items.Objects[ListBoxDisallow.ItemIndex]).boStorage;
    CheckBoxDisallowRepair.Checked := pTDisallowInfo(ListBoxDisallow.Items.Objects[ListBoxDisallow.ItemIndex]).boRepair;
    CheckBoxDisallowDropHint.Checked := pTDisallowInfo(ListBoxDisallow.Items.Objects[ListBoxDisallow.ItemIndex]).boDropHint;
    CheckBoxDisallowOpenBoxsHint.Checked := pTDisallowInfo(ListBoxDisallow.Items.Objects[ListBoxDisallow.ItemIndex]).boOpenBoxsHint;
    CheckBoxDisallowNoDropItem.Checked := pTDisallowInfo(ListBoxDisallow.Items.Objects[ListBoxDisallow.ItemIndex]).boNoDropItem;
    CheckBoxDisallowButchHint.Checked := pTDisallowInfo(ListBoxDisallow.Items.Objects[ListBoxDisallow.ItemIndex]).boButchHint;
    {$IF HEROVERSION = 1}
    CheckBoxDisallowHeroUse.Checked := pTDisallowInfo(ListBoxDisallow.Items.Objects[ListBoxDisallow.ItemIndex]).boHeroUse;
    {$IFEND}
    CheckBoxDisallowPickUpItem.Checked := pTDisallowInfo(ListBoxDisallow.Items.Objects[ListBoxDisallow.ItemIndex]).boPickUpItem;//禁止捡起(除GM外) 20080611
    CheckBoxDieDropItems.Checked :=  pTDisallowInfo(ListBoxDisallow.Items.Objects[ListBoxDisallow.ItemIndex]).boDieDropItems;//死亡掉落 20080614
    CheckBoxBuyShopItemGive.Checked := pTDisallowInfo(ListBoxDisallow.Items.Objects[ListBoxDisallow.ItemIndex]).boBuyShopItemGive;//禁止商铺赠送 20090205
    CheckBoxButchItem.Checked := pTDisallowInfo(ListBoxDisallow.Items.Objects[ListBoxDisallow.ItemIndex]).boButchItem;//禁止挖 20090221
    CheckBoxRefineItem.Checked := pTDisallowInfo(ListBoxDisallow.Items.Objects[ListBoxDisallow.ItemIndex]).boRefineItem;//淬练提示 20100407
    CheckBoxNpcGiveItem.Checked := pTDisallowInfo(ListBoxDisallow.Items.Objects[ListBoxDisallow.ItemIndex]).boNpcGiveItem;//一定时间才能捡起 20100530
    CheckBoxDigJewelHint.Checked := pTDisallowInfo(ListBoxDisallow.Items.Objects[ListBoxDisallow.ItemIndex]).boCanDigJewelHint;//挖宝提示
    CheckBox24HourDisap.Checked := pTDisallowInfo(ListBoxDisallow.Items.Objects[ListBoxDisallow.ItemIndex]).bo24HourDisap;//24时消失
    CheckBoxPermanentBind.Checked := pTDisallowInfo(ListBoxDisallow.Items.Objects[ListBoxDisallow.ItemIndex]).boPermanentBind;//永久绑定
    CheckBox48HourUnBind.Checked := pTDisallowInfo(ListBoxDisallow.Items.Objects[ListBoxDisallow.ItemIndex]).bo48HourUnBind;//绑定48时
    BtnDisallowChg.Enabled := True;
    BtnDisallowDel.Enabled := True;
    BtnDisallowAdd.Enabled := False;
  except
    EditItemName.Text := '';
    CheckBoxDisallowDrop.Checked := False;
    CheckBoxDisallowDeal.Checked := False;
    CheckBoxDisallowStorage.Checked := False;
    CheckBoxDisallowRepair.Checked := False;
    CheckBoxDisallowDropHint.Checked := False;
    CheckBoxDisallowOpenBoxsHint.Checked := False;
    CheckBoxDisallowNoDropItem.Checked := False;
    CheckBoxDisallowButchHint.Checked := False;
    CheckBoxDisallowHeroUse.Checked := False;
    CheckBoxDisallowPickUpItem.Checked := False;
    CheckBoxBuyShopItemGive.Checked := False;
    CheckBoxButchItem.Checked := False;
  end;
end;

procedure TfrmViewList2.CheckBoxDisallowNoDropItemClick(Sender: TObject);
begin
  CheckBoxDieDropItems.Checked := False;
end;

procedure TfrmViewList2.CheckBoxPermanentBindClick(Sender: TObject);
begin
  if CheckBoxPermanentBind.Checked then begin
    CheckBox24HourDisap.Checked := False;
    CheckBox48HourUnBind.Checked := False;
    CheckBox24HourDisap.Enabled := False;
    CheckBox48HourUnBind.Enabled := False;
  end else begin
    CheckBox24HourDisap.Enabled := True;
    CheckBox48HourUnBind.Enabled := True;
  end;
end;

procedure TfrmViewList2.CheckBoxDieDropItemsClick(Sender: TObject);
begin
  CheckBoxDisallowNoDropItem.Checked := False;
end;

procedure TfrmViewList2.FormShow(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 0;
{$IF M2Version = 2}
  TabSheet3.TabVisible:= False;
  CheckBoxCanShop.Visible:= True;
  RadioButtonShopGameGold.Visible := True;
  RadioButtonShopUseGold.Visible := True;

  CheckBoxBuyGameGird.Visible := False;
  SpinEditGameGird.Visible := False;
  Label100.Visible := False;
{$IFEND}
end;

procedure TfrmViewList2.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  I: Integer;
begin
  Try
    if ListBoxDisallow.Items.count > 0 then begin
      for I:= 0 to ListBoxDisallow.Items.count -1 do begin
        Dispose(pTDisallowInfo(ListBoxDisallow.Items.objects[I]));
      end;
    end;
  except
  end;
end;

//--------------------------消息过滤------------------
function TfrmViewList2.InFilterMsgList(sFilterMsg: string): Boolean;
var
  I: Integer;
  ListItem: TListItem;
begin
  Result := False;
Try
  ListViewMsgFilter.Items.BeginUpdate;
  try
    if ListViewMsgFilter.Items.Count > 0 then begin//20080629
      for I := 0 to ListViewMsgFilter.Items.Count - 1 do begin
        ListItem := ListViewMsgFilter.Items.Item[I];
        if CompareText(sFilterMsg, ListItem.Caption) = 0 then begin
          Result := TRUE;
          break;
        end;
      end;
    end;
  finally
    ListViewMsgFilter.Items.EndUpdate;
  end;
  except
    MainOutMessage(Format('{%s} TfrmViewList2.InFilterMsgList',[g_sExceptionVer]));
  end;
end;

procedure TfrmViewList2.RefLoadMsgFilterList();
var
  I: Integer;
  ListItem: TListItem;
  FilterMsg: pTFilterMsg;
begin
  ListViewMsgFilter.Items.Clear;
  try
    if g_MsgFilterList.Count > 0 then begin//20080629
      for I := 0 to g_MsgFilterList.Count - 1 do begin
        ListItem := ListViewMsgFilter.Items.Add;
        FilterMsg := g_MsgFilterList.Items[I];
        ListItem.Caption := FilterMsg.sFilterMsg;
        ListItem.SubItems.Add(FilterMsg.sNewMsg);
      end;
    end;
  except
    MainOutMessage(Format('{%s} TfrmViewList2.RefLoadMsgFilterList',[g_sExceptionVer]));
  end;
end;

procedure TfrmViewList2.ListViewMsgFilterClick(Sender: TObject);
var
  ListItem: TListItem;
  nItemIndex: Integer;
begin
  try
    nItemIndex := ListViewMsgFilter.ItemIndex;
    ListItem := ListViewMsgFilter.Items.Item[nItemIndex];
    EditFilterMsg.Text := ListItem.Caption;
    EditNewMsg.Text := ListItem.SubItems.Strings[0];
    ButtonMsgFilterDel.Enabled := TRUE;
    ButtonMsgFilterChg.Enabled := TRUE;
  except
    EditFilterMsg.Text := '';
    EditNewMsg.Text := '';
    ButtonMsgFilterDel.Enabled := False;
    ButtonMsgFilterChg.Enabled := False;
  end;
end;

procedure TfrmViewList2.ButtonMsgFilterAddClick(Sender: TObject);
var
  sFilterMsg: string;
  sNewMsg: string;
  ListItem: TListItem;
begin
  sFilterMsg := Trim(EditFilterMsg.Text);
  sNewMsg := Trim(EditNewMsg.Text);
  if sFilterMsg = '' then begin
    Application.MessageBox('请输入过滤消息！！！', '提示信息', MB_ICONQUESTION);
    Exit;
  end;
  if InFilterMsgList(sFilterMsg) then begin
    Application.MessageBox('你输入的过滤消息已经存在！！！', '提示信息', MB_ICONQUESTION);
    Exit;
  end;
  ListViewMsgFilter.Items.BeginUpdate;
  try
    ListItem := ListViewMsgFilter.Items.Add;
    ListItem.Caption := sFilterMsg;
    ListItem.SubItems.Add(sNewMsg);
    EditFilterMsg.Text:= '';
    EditNewMsg.Text:='';
  finally
    ListViewMsgFilter.Items.EndUpdate;
  end;
end;

procedure TfrmViewList2.ButtonMsgFilterDelClick(Sender: TObject);
begin
  try
    ListViewMsgFilter.DeleteSelected;
  except
  end;
end;

procedure TfrmViewList2.ButtonMsgFilterChgClick(Sender: TObject);
var
  sFilterMsg: string;
  sNewMsg: string;
  ListItem: TListItem;
begin
  sFilterMsg := Trim(EditFilterMsg.Text);
  sNewMsg := Trim(EditNewMsg.Text);
  if sFilterMsg = '' then begin
    Application.MessageBox('请输入过滤消息！！！', '提示信息', MB_ICONQUESTION);
    Exit;
  end;
  if InFilterMsgList(sFilterMsg) then begin
    Application.MessageBox('你输入的过滤消息已经存在！！！', '提示信息', MB_ICONQUESTION);
    Exit;
  end;
  ListViewMsgFilter.Items.BeginUpdate;
  try
    ListItem := ListViewMsgFilter.Items.Item[ListViewMsgFilter.ItemIndex];
    ListItem.Caption := sFilterMsg;
    ListItem.SubItems.Strings[0] := sNewMsg;
    EditFilterMsg.Text:= '';
    EditNewMsg.Text:='';    
  finally
    ListViewMsgFilter.Items.EndUpdate;
  end;
end;

procedure TfrmViewList2.ButtonMsgFilterSaveClick(Sender: TObject);
var
  I: Integer;
  ListItem: TListItem;
  SaveList: TStringList;
  sFilterMsg: string;
  sNewMsg: string;
  sFileName: string;
begin
Try
  ButtonMsgFilterSave.Enabled := False;
  sFileName := '.\MsgFilterList.txt';
  SaveList := TStringList.Create;
  SaveList.Add(';引擎插件消息过滤配置文件');
  SaveList.Add(';过滤消息'#9'替换消息');
  ListViewMsgFilter.Items.BeginUpdate;
  try
    if ListViewMsgFilter.Items.Count > 0 then begin//20080629
      for I := 0 to ListViewMsgFilter.Items.Count - 1 do begin
        ListItem := ListViewMsgFilter.Items.Item[I];
        sFilterMsg := ListItem.Caption;
        sNewMsg := ListItem.SubItems.Strings[0];
        SaveList.Add(sFilterMsg + #9 + sNewMsg);
      end;
    end;
  finally
    ListViewMsgFilter.Items.EndUpdate;
  end;
  SaveList.SaveToFile(sFileName);
  SaveList.Free;
  Application.MessageBox('保存完成！！！', '提示信息', MB_ICONQUESTION);
  ButtonMsgFilterSave.Enabled := TRUE;
  except
    MainOutMessage(Format('{%s} TfrmViewList2.ButtonMsgFilterSaveClick',[g_sExceptionVer]));
  end;
end;

procedure TfrmViewList2.ButtonLoadMsgFilterListClick(Sender: TObject);
begin
  ButtonLoadMsgFilterList.Enabled := False;
  LoadMsgFilterList();
  RefLoadMsgFilterList();
  Application.MessageBox('重新加载消息过滤列表完成！！！', '提示信息', MB_ICONQUESTION);
  ButtonLoadMsgFilterList.Enabled := TRUE;
end;

procedure TfrmViewList2.TabSheet7Show(Sender: TObject);
begin
  RefLoadMsgFilterList();
end;
//-----------------------------商铺设置-----------------------------------
function TfrmViewList2.InListViewItemList(sItemName: string): Boolean;
var
  I: Integer;
  ListItem: TListItem;
begin
  Result := False;
  ListViewItemList.Items.BeginUpdate;
  try
    for I := 0 to ListViewItemList.Items.Count - 1 do begin
      ListItem := ListViewItemList.Items.Item[I];
      if CompareText(sItemName, ListItem.Caption) = 0 then begin
        Result := True;
        Break;
      end;
    end;
  finally
    ListViewItemList.Items.EndUpdate;
  end;
end;

procedure TfrmViewList2.ItemEffectListClick(Sender: TObject);
begin
  try
    Edit7.Text := ItemEffectList.Items.Strings[ItemEffectList.ItemIndex];
    {SpinEdit76.Value := 0;
    SpinEdit77.Value := 0;
    SpinEdit78.Value := 0;
    SpinEdit79.Value := 0;
    ComboBox3.text := '';

    SpinEdit68.Value := 0;
    SpinEdit69.Value := 0;
    SpinEdit70.Value := 0;
    SpinEdit71.Value := 0;
    ComboBox1.text := '';

    SpinEdit72.Value := 0;
    SpinEdit73.Value := 0;
    SpinEdit74.Value := 0;
    SpinEdit75.Value := 0;
    ComboBox2.text := ''; }
    SpinEdit72.Value := 65535;
    Button16.Enabled := True;
    Button17.Enabled := False;
    Button18.Enabled := False;
  except
    Edit7.Text := '';
    Button16.Enabled := False;
  end;
end;

procedure TfrmViewList2.ItemEffectListKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  s: string;
  I: Integer;
begin
  if Key = Word('F') then begin
    if ssCtrl in Shift then begin
      s := inputBox('查找物品','请输入要查找的物品名字:','');
      if ItemEffectList.Count > 0 then begin
        for I:=0 to ItemEffectList.Count - 1 do begin
          if CompareText(ItemEffectList.Items.Strings[I],s) = 0 then begin
             ItemEffectList.ItemIndex:=I;
             ItemEffectList.OnClick(Sender);
             Exit;
          end;
        end;
      end;
    end;
  end;
end;

procedure TfrmViewList2.RefLoadShopItemList();
var
  I: Integer;
  ListItem: TListItem;
  ShopInfo: pTShopInfo;
begin
  Try
    ListViewItemList.Clear;
    if g_ShopItemList <> nil then begin
      if g_ShopItemList.Count > 0 then begin//20080629
        for I := 0 to g_ShopItemList.Count - 1 do begin
          ShopInfo := pTShopInfo(g_ShopItemList.Items[I]);
          ListViewItemList.Items.BeginUpdate;
          try
            ListItem := ListViewItemList.Items.Add;
            ListItem.Caption := ShopInfo.StdItem.Name;
            ListItem.SubItems.Add(ShopInfo.Idx);
            ListItem.SubItems.Add(IntToStr(ShopInfo.StdItem.Price div 100));
            ListItem.SubItems.Add(ShopInfo.ImgBegin);
            ListItem.SubItems.Add(ShopInfo.Imgend);
            ListItem.SubItems.Add(IntToStr(ShopInfo.StdItem.NeedLevel));//购买的数量
            ListItem.SubItems.Add(ShopInfo.Introduce1);
            ListItem.SubItems.Add(StrPas(@ShopInfo.sIntroduce));
          finally
            ListViewItemList.Items.EndUpdate;
          end;
        end;//for
      end;
      CheckBoxboShopGamePoint.Caption:= '开启'+g_Config.sGamePointName+'购买功能';
      CheckBoxboShopGamePoint.Checked := g_Config.g_boShopGamePoint;
      CheckBoxCanBuyShopItemGive.Checked := g_Config.boCanBuyShopItemGive;
      {$IF M2Version <> 2}
      CheckBoxBuyGameGird.Checked :=g_Config.g_boGameGird;//20080808
      SpinEditGameGird.Value := g_Config.g_nGameGold;//20080808
      {$ELSEIF M2Version = 2}
      CheckBoxCanShop.Checked :=g_Config.g_boCanShop;//开启商铺功能 20100630
      RadioButtonShopGameGold.Checked := not g_Config.g_boShopUseGold;//商铺使用金币交易 20100630
      RadioButtonShopUseGold.Checked := g_Config.g_boShopUseGold;//商铺使用金币交易 20100630
      {$IFEND}
    end;
  except
    MainOutMessage(Format('{%s} TfrmViewList2.RefLoadShopItemList',[g_sExceptionVer]));
  end;
end;

procedure TfrmViewList2.ListViewItemListClick(Sender: TObject);
var
  nItemIndex: Integer;
  ListItem: TListItem;
begin
  try
    nItemIndex := ListViewItemList.ItemIndex;
    ListItem := ListViewItemList.Items.Item[nItemIndex];
    EditShopItemName.Text := ListItem.Caption;
    SpinEditPrice.Value := Str_ToInt(ListItem.SubItems.Strings[1], 0);
    SpinEditShopItemCount.Value:=  Str_ToInt(ListItem.SubItems.Strings[4], 1);//购买的数量
    EditShopImgBegin.Text :=ListItem.SubItems.Strings[2];
    EditShopImgEnd.Text :=ListItem.SubItems.Strings[3];
    EditShopItemIntroduce.Text := ListItem.SubItems.Strings[5];
    ShopTypeBoBox.ItemIndex := Str_ToInt(ListItem.SubItems.Strings[0], 0);
    Memo1.Text := ListItem.SubItems.Strings[6];
    ButtonChgShopItem.Enabled := True;
    ButtonDelShopItem.Enabled := True;
  except
    ButtonChgShopItem.Enabled := False;
    ButtonDelShopItem.Enabled := False;
  end;
end;

procedure TfrmViewList2.ListBoxItemListShopClick(Sender: TObject);
begin
  try
    EditShopItemName.Text := ListBoxItemListShop.Items.Strings[ListBoxItemListShop.ItemIndex];
    ButtonAddShopItem.Enabled := True;
    ButtonChgShopItem.Enabled := False;
    ButtonDelShopItem.Enabled := False;
    EditShopItemIntroduce.Text:='';
    Memo1.Text:='';
  except
    ButtonAddShopItem.Enabled := False;
  end;
end;

procedure TfrmViewList2.ListBoxItemListShopKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  s: string;
  I: Integer;
begin
  if Key = Word('F') then begin
   if ssCtrl in Shift then begin
      s := inputBox('查找物品','请输入要查找的物品名字:','');
      for I:=0 to ListBoxItemListShop.Count - 1 do begin
        if CompareText(ListBoxItemListShop.Items.Strings[I],s) = 0 then begin
           ListBoxItemListShop.ItemIndex:=I;
           Exit;
        end;
      end;
   end;
  end;
end;

procedure TfrmViewList2.CheckBoxBuyGameGirdClick(Sender: TObject);
begin
  g_Config.g_boGameGird := CheckBoxBuyGameGird.Checked;
  ButtonSaveShopItemList.Enabled := True;
end;

procedure TfrmViewList2.SpinEditGameGirdChange(Sender: TObject);
begin
  g_Config.g_nGameGold := SpinEditGameGird.Value;
  ButtonSaveShopItemList.Enabled := True;
end;

procedure TfrmViewList2.SpinEditLimitItemTimeChange(Sender: TObject);
begin
  g_Config.nLimitItemTime := SpinEditLimitItemTime.Value;
end;

procedure TfrmViewList2.ButtonDelShopItemClick(Sender: TObject);
begin
  ListViewItemList.Items.BeginUpdate;
  try
    ListViewItemList.DeleteSelected;
    ButtonSaveShopItemList.Enabled:= True;//20080320
  finally
    ListViewItemList.Items.EndUpdate;
  end;
end;

procedure TfrmViewList2.ButtonChgShopItemClick(Sender: TObject);
var
  nItemIndex: Integer;
  ListItem: TListItem;
begin
  try
    nItemIndex := ListViewItemList.ItemIndex;
    ListItem := ListViewItemList.Items.Item[nItemIndex];
    ListItem.SubItems.Strings[0] := IntToStr(ShopTypeBoBox.ItemIndex);
    ListItem.SubItems.Strings[1] := IntToStr(SpinEditPrice.Value);
    ListItem.SubItems.Strings[2] := Trim(EditShopImgBegin.Text);
    ListItem.SubItems.Strings[3] := Trim(EditShopImgEnd.Text);
    ListItem.SubItems.Strings[4] := IntToStr(SpinEditShopItemCount.Value);
    ListItem.SubItems.Strings[5] := Trim(EditShopItemIntroduce.Text);
    ListItem.SubItems.Strings[6] := Trim(Memo1.Text);
    ButtonSaveShopItemList.Enabled:= True;
  except
  end;
end;

procedure TfrmViewList2.ButtonAddShopItemClick(Sender: TObject);
var
  ListItem: TListItem;
  sItemName: string;
begin
  Try
    sItemName := Trim(EditShopItemName.Text);
    if sItemName = '' then begin
      Application.MessageBox('请选择你要添加的商品！！！', '提示信息', MB_ICONQUESTION);
      Exit;
    end;
    if Memo1.Text = '' then begin
      Application.MessageBox('请输入商品描述！！！', '提示信息', MB_ICONQUESTION);
      Memo1.SetFocus;
      Exit;
    end;
    if InListViewItemList(sItemName) then begin
      Application.MessageBox('你要添加的商品已经存在，请选择其他商品！！！', '提示信息', MB_ICONQUESTION);
      Exit;
    end;
    ListViewItemList.Items.BeginUpdate;
    try
      ListItem := ListViewItemList.Items.Add;
      ListItem.SubItems.Add(IntToStr(ShopTypeBoBox.ItemIndex));
      ListItem.Caption := sItemName;
      ListItem.SubItems.Add(IntToStr(SpinEditPrice.Value));
      ListItem.SubItems.Add(Trim(EditShopImgBegin.Text));
      ListItem.SubItems.Add(Trim(EditShopImgEnd.Text));
      ListItem.SubItems.Add(IntToStr(SpinEditShopItemCount.Value));
      ListItem.SubItems.Add(Trim(EditShopItemIntroduce.Text));
      ListItem.SubItems.Add(Trim(Memo1.Text));
      ButtonSaveShopItemList.Enabled:= True;
    finally
      ListViewItemList.Items.EndUpdate;
    end;
  except
    MainOutMessage(Format('{%s} TfrmViewList2.ButtonAddShopItemClick',[g_sExceptionVer]));
  end;
end;

procedure TfrmViewList2.ButtonSaveShopItemListClick(Sender: TObject);
var
  I: Integer;
  ListItem: TListItem;
  SaveList: TStringList;
  sIdx, sImgBegin, sImgEnd, sIntroduce, sLineText, sFileName, sItemName, sPrice, sMemo, sCount: string;
begin
  Try
    sFileName := '.\BuyItemList.txt';
    SaveList := TStringList.Create();
    try
      SaveList.Add(';引擎插件商铺配置文件');
      SaveList.Add(';商品分类'#9'商品名称'#9'出售价格'#9'图片开始'#9'图片结束'#9'简单介绍'#9'商品描述');
      ListViewItemList.Items.BeginUpdate;
      try
        if ListViewItemList.Items.Count > 0 then begin//20090526 增加
          for I := 0 to ListViewItemList.Items.Count - 1 do begin
            ListItem := ListViewItemList.Items.Item[I];
            sIdx := ListItem.SubItems.Strings[0];
            sItemName := ListItem.Caption;
            sPrice := ListItem.SubItems.Strings[1];
            sImgBegin := ListItem.SubItems.Strings[2];
            sImgEnd := ListItem.SubItems.Strings[3];
            sCount:= ListItem.SubItems.Strings[4];
            sIntroduce := ListItem.SubItems.Strings[5];
            sMemo := ListItem.SubItems.Strings[6];
            sLineText := sIdx + #9 + sItemName + #9 + sPrice + #9 + sImgBegin + #9 + sImgEnd + #9 + sIntroduce + #9 + sMemo + #9 + sCount;
            SaveList.Add(sLineText);
          end;
        end;
      finally
        ListViewItemList.Items.EndUpdate;
      end;
      SaveList.SaveToFile(sFileName);
    finally
      SaveList.Free;
    end;
    Application.MessageBox('保存完成！！！', '提示信息', MB_ICONQUESTION);
    ButtonSaveShopItemList.Enabled := False;
  {******************************************************************************}
    {$IF M2Version <> 2}
  //以下为灵符兑换保存代码
    Config.WriteBool('Shop','ShopBuyGameGird',g_Config.g_boGameGird);
    Config.WriteInteger('Shop','GameGold',g_Config.g_nGameGold);
    {$ELSEIF M2Version = 2}
    Config.WriteBool('Shop','boCanShop', g_Config.g_boCanShop);//开启商铺功能 20100630
    Config.WriteBool('Shop','ShopUseGold', g_Config.g_boShopUseGold);//商铺使用金币交易 20100630
    {$IFEND}
    Config.WriteBool('Shop','ShopGamePoint', g_Config.g_boShopGamePoint);
    Config.WriteBool('Shop','CanBuyShopItemGive', g_Config.boCanBuyShopItemGive);
  {******************************************************************************}
  except
    MainOutMessage(Format('{%s} PlugOfShop.ButtonSaveShopItemListClick',[g_sExceptionVer]));
  end;
end;

procedure TfrmViewList2.ButtonLoadShopItemListClick(Sender: TObject);
begin
  ButtonLoadShopItemList.Enabled := False;
  LoadShopItemList();
  RefLoadShopItemList();
  Application.MessageBox('重新加载商列表完成！！！', '提示信息', MB_ICONQUESTION);
  ButtonLoadShopItemList.Enabled := True;
end;

procedure TfrmViewList2.TabSheet8Show(Sender: TObject);
var
  I: Integer;
  StdItem: pTStdItem;
begin
  ButtonChgShopItem.Enabled := False;
  ButtonDelShopItem.Enabled := False;
  ButtonAddShopItem.Enabled := False;
  ListBoxItemListShop.Items.Clear;
  if UserEngine.StdItemList <> nil then begin
    if UserEngine.StdItemList.Count > 0 then begin//20080629
      for I := 0 to UserEngine.StdItemList.Count - 1 do begin
        StdItem:= pTStdItem(UserEngine.StdItemList.Items[I]);
        ListBoxItemListShop.Items.Add(StdItem.Name);
      end;
    end;
  end;
  RefLoadShopItemList();
end;

procedure TfrmViewList2.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmViewList2.FormDestroy(Sender: TObject);
begin
  frmViewList2:= nil;
end;

procedure TfrmViewList2.CheckBox24HourDisapClick(Sender: TObject);
begin
  if CheckBox24HourDisap.Checked then begin
    CheckBoxPermanentBind.Enabled:= False;
    CheckBoxPermanentBind.Checked := False;
    CheckBox48HourUnBind.Checked := False;
    CheckBox48HourUnBind.Enabled:= False;
  end else begin
    CheckBoxPermanentBind.Enabled:= True;
    CheckBox48HourUnBind.Enabled:= True;
  end;
end;

procedure TfrmViewList2.CheckBox48HourUnBindClick(Sender: TObject);
begin
  if CheckBox48HourUnBind.Checked then begin
    CheckBoxPermanentBind.Checked := False;
    CheckBox24HourDisap.Checked := False;
    CheckBoxPermanentBind.Enabled := False;
    CheckBox24HourDisap.Enabled := False;
  end else begin
    CheckBoxPermanentBind.Enabled := True;
    CheckBox24HourDisap.Enabled := True;
  end;
end;

procedure TfrmViewList2.CheckBoxboShopGamePointClick(Sender: TObject);
begin
  g_Config.g_boShopGamePoint := CheckBoxboShopGamePoint.Checked;
  ButtonSaveShopItemList.Enabled := True;
end;

procedure TfrmViewList2.CheckBoxButchItemClick(Sender: TObject);
begin
  CheckBoxDisallowButchHint.Checked := False;
end;

procedure TfrmViewList2.CheckBoxDisallowButchHintClick(Sender: TObject);
begin
  CheckBoxButchItem.Checked := False;
end;

procedure TfrmViewList2.CheckBoxCanBuyShopItemGiveClick(Sender: TObject);
begin
  g_Config.boCanBuyShopItemGive := CheckBoxCanBuyShopItemGive.Checked;
  ButtonSaveShopItemList.Enabled := True;
end;

procedure TfrmViewList2.CheckBoxCanShopClick(Sender: TObject);
begin
  {$IF M2Version = 2}
  g_Config.g_boCanShop := CheckBoxCanShop.Checked;
  ButtonSaveShopItemList.Enabled := True;
  {$IFEND}
end;

procedure TfrmViewList2.RadioButtonShopGameGoldClick(Sender: TObject);
begin
  {$IF M2Version = 2}
  g_Config.g_boShopUseGold := not RadioButtonShopGameGold.Checked;
  ButtonSaveShopItemList.Enabled := True;
  {$IFEND}
end;

procedure TfrmViewList2.RadioButtonShopUseGoldClick(Sender: TObject);
begin
  {$IF M2Version = 2}
  g_Config.g_boShopUseGold := RadioButtonShopUseGold.Checked;
  ButtonSaveShopItemList.Enabled := True;
  {$IFEND}
end;
(*
procedure TfrmViewList2.LoadWilFileToBox();
var
  I: Integer;
  LoadList: TStringList;
  sFileName, sWilName: string;
begin
  sFileName := g_Config.sEnvirDir + 'WilList.txt';
  LoadList := TStringList.Create;
  ComboBox1.Clear;
  ComboBox2.Clear;
  ComboBox3.Clear;
  try
    if FileExists(sFileName) then begin
      LoadList.LoadFromFile(sFileName);
      for I := 0 to LoadList.Count - 1 do begin
        sWilName := Trim(LoadList.Strings[I]);
        if (sWilName <> '') and (Length(sWilName) < 30) then begin
          ComboBox1.Items.Add(sWilName);
          ComboBox2.Items.Add(sWilName);
          ComboBox3.Items.Add(sWilName);
        end;
      end;
    end else begin
      LoadList.Add('Prguse1.wil');
      ComboBox1.Items.Add('Prguse1.wil');
      ComboBox2.Items.Add('Prguse1.wil');
      ComboBox3.Items.Add('Prguse1.wil');
      LoadList.Add('Prguse2.wil');
      ComboBox1.Items.Add('Prguse2.wil');
      ComboBox2.Items.Add('Prguse2.wil');
      ComboBox3.Items.Add('Prguse2.wil');
      LoadList.Add('Prguse3.wil');
      ComboBox1.Items.Add('Prguse3.wil');
      ComboBox2.Items.Add('Prguse3.wil');
      ComboBox3.Items.Add('Prguse3.wil');
      LoadList.Add('ui1.wil');
      ComboBox1.Items.Add('ui1.wil');
      ComboBox2.Items.Add('ui1.wil');
      ComboBox3.Items.Add('ui1.wil');
      LoadList.Add('Effect.wil');
      ComboBox1.Items.Add('Effect.wil');
      ComboBox2.Items.Add('Effect.wil');
      ComboBox3.Items.Add('Effect.wil');
      LoadList.Add('StateEffect.wil');
      ComboBox1.Items.Add('StateEffect.wil');
      ComboBox2.Items.Add('StateEffect.wil');
      ComboBox3.Items.Add('StateEffect.wil');
      LoadList.Add('HumEffect.wil');
      ComboBox1.Items.Add('HumEffect.wil');
      ComboBox2.Items.Add('HumEffect.wil');
      ComboBox3.Items.Add('HumEffect.wil');
      LoadList.Add('HumEffect2.wil');
      ComboBox1.Items.Add('HumEffect2.wil');
      ComboBox2.Items.Add('HumEffect2.wil');
      ComboBox3.Items.Add('HumEffect2.wil');
      LoadList.Add('stateitem.wil');
      ComboBox1.Items.Add('stateitem.wil');
      ComboBox2.Items.Add('stateitem.wil');
      ComboBox3.Items.Add('stateitem.wil');
      LoadList.SaveToFile(sFileName);
    end;
  finally
    LoadList.Free;
  end;
end; *)

procedure TfrmViewList2.RefLoadEffecItems();
var
  I: Integer;
  sItemName: string;
  EffecItem, EffecItem1: pTEffecItem;
begin
  Try
    if EffecItemtList.Items.count > 0 then begin
      for I:= 0 to EffecItemtList.Items.count -1 do begin
        Dispose(pTEffecItem(EffecItemtList.Items.objects[I]));
      end;
      EffecItemtList.Items.Clear;
    end;
    if g_EffecItemtList.Count > 0 then begin
      for I := 0 to g_EffecItemtList.Count - 1 do begin
        EffecItem := pTEffecItem(g_EffecItemtList.Objects[I]);
        sItemName := g_EffecItemtList.Strings[I];
        if (EffecItem <> nil) and (sItemName <> '') then begin
          New(EffecItem1);
          Move(EffecItem^, EffecItem1^, SizeOf(TEffecItem));
          EffecItemtList.AddItem(sItemName, TObject(EffecItem1));
        end;
      end;
    end;
  except
    MainOutMessage(Format('{%s} TfrmViewList2.RefLoadEffecItems',[g_sExceptionVer]));
  end;
end;

end.
