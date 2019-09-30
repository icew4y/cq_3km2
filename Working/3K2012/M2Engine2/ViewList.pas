unit ViewList;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms,
  ComCtrls, StdCtrls, Grids, Spin, Grobal2;

type
  TfrmViewList = class(TForm)
    PageControlViewList: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    GroupBox2: TGroupBox;
    ListBoxItemList: TListBox;
    GroupBox1: TGroupBox;
    ListBoxEnableMakeList: TListBox;
    ButtonEnableMakeAdd: TButton;
    ButtonEnableMakeDelete: TButton;
    ButtonEnableMakeSave: TButton;
    GroupBox3: TGroupBox;
    ListBoxDisableMakeList: TListBox;
    GroupBox4: TGroupBox;
    ListBoxitemList1: TListBox;
    ButtonDisableMakeAdd: TButton;
    ButtonDisableMakeDelete: TButton;
    ButtonDisableMakeSave: TButton;
    ButtonEnableMakeAddAll: TButton;
    ButtonEnableMakeDeleteAll: TButton;
    ButtonDisableMakeAddAll: TButton;
    ButtonDisableMakeDeleteAll: TButton;
    GridItemBindAccount: TStringGrid;
    GridItemBindCharName: TStringGrid;
    GridItemBindIPaddr: TStringGrid;
    GroupBox5: TGroupBox;
    ListBoxDisableMoveMap: TListBox;
    ButtonDisableMoveMapAdd: TButton;
    ButtonDisableMoveMapDelete: TButton;
    ButtonDisableMoveMapAddAll: TButton;
    ButtonDisableMoveMapDeleteAll: TButton;
    ButtonDisableMoveMapSave: TButton;
    GroupBox6: TGroupBox;
    ListBoxMapList: TListBox;
    TabSheetMonDrop: TTabSheet;
    StringGridMonDropLimit: TStringGrid;
    GroupBox7: TGroupBox;
    ButtonMonDropLimitSave: TButton;
    Label29: TLabel;
    EditDropCount: TSpinEdit;
    Label1: TLabel;
    EditCountLimit: TSpinEdit;
    EditNoDropCount: TSpinEdit;
    Label2: TLabel;
    Label3: TLabel;
    EditItemName: TEdit;
    TabSheet8: TTabSheet;
    GroupBox8: TGroupBox;
    ListBoxGameLogList: TListBox;
    ButtonGameLogAdd: TButton;
    ButtonGameLogDel: TButton;
    ButtonGameLogAddAll: TButton;
    ButtonGameLogDelAll: TButton;
    ButtonGameLogSave: TButton;
    GroupBox9: TGroupBox;
    ListBoxitemList2: TListBox;
    TabSheet9: TTabSheet;
    GroupBox10: TGroupBox;
    ListBoxDisableTakeOffList: TListBox;
    ButtonDisableTakeOffAdd: TButton;
    ButtonDisableTakeOffDel: TButton;
    ButtonDisableTakeOffAddAll: TButton;
    ButtonDisableTakeOffDelAll: TButton;
    ButtonDisableTakeOffSave: TButton;
    GroupBox11: TGroupBox;
    ListBoxitemList3: TListBox;
    TabSheet10: TTabSheet;
    GroupBox12: TGroupBox;
    ListBoxAdminList: TListBox;
    TabSheet11: TTabSheet;
    GroupBox13: TGroupBox;
    ListBoxNoClearMonList: TListBox;
    ButtonNoClearMonAdd: TButton;
    ButtonNoClearMonDel: TButton;
    ButtonNoClearMonAddAll: TButton;
    ButtonNoClearMonDelAll: TButton;
    ButtonNoClearMonSave: TButton;
    GroupBox14: TGroupBox;
    ListBoxMonList: TListBox;
    GroupBox15: TGroupBox;
    Label4: TLabel;
    EditAdminName: TEdit;
    EditAdminPremission: TSpinEdit;
    Label5: TLabel;
    ButtonAdminListAdd: TButton;
    ButtonAdminListChange: TButton;
    ButtonAdminListDel: TButton;
    ButtonAdminLitsSave: TButton;
    ButtonMonDropLimitAdd: TButton;
    ButtonMonDropLimitRef: TButton;
    ButtonMonDropLimitDel: TButton;
    GroupBox16: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    ButtonItemBindAcountMod: TButton;
    EditItemBindAccountItemIdx: TSpinEdit;
    EditItemBindAccountItemMakeIdx: TSpinEdit;
    EditItemBindAccountItemName: TEdit;
    ButtonItemBindAcountAdd: TButton;
    ButtonItemBindAcountRef: TButton;
    ButtonItemBindAcountDel: TButton;
    EditItemBindAccountName: TEdit;
    GroupBox17: TGroupBox;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    ButtonItemBindCharNameMod: TButton;
    EditItemBindCharNameItemIdx: TSpinEdit;
    EditItemBindCharNameItemMakeIdx: TSpinEdit;
    EditItemBindCharNameItemName: TEdit;
    ButtonItemBindCharNameAdd: TButton;
    ButtonItemBindCharNameRef: TButton;
    ButtonItemBindCharNameDel: TButton;
    EditItemBindCharNameName: TEdit;
    GroupBox18: TGroupBox;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    ButtonItemBindIPaddrMod: TButton;
    EditItemBindIPaddrItemIdx: TSpinEdit;
    EditItemBindIPaddrItemMakeIdx: TSpinEdit;
    EditItemBindIPaddrItemName: TEdit;
    ButtonItemBindIPaddrAdd: TButton;
    ButtonItemBindIPaddrRef: TButton;
    ButtonItemBindIPaddrDel: TButton;
    EditItemBindIPaddrName: TEdit;
    TabSheet12: TTabSheet;
    GridItemNameList: TStringGrid;
    GroupBox19: TGroupBox;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    ButtonItemNameMod: TButton;
    EditItemNameIdx: TSpinEdit;
    EditItemNameMakeIndex: TSpinEdit;
    EditItemNameOldName: TEdit;
    ButtonItemNameAdd: TButton;
    ButtonItemNameRef: TButton;
    ButtonItemNameDel: TButton;
    EditItemNameNewName: TEdit;
    LabelAdminIPaddr: TLabel;
    EditAdminIPaddr: TEdit;
    TabSheet13: TTabSheet;
    GroupBox20: TGroupBox;
    ListBoxSellOffList: TListBox;
    GroupBox21: TGroupBox;
    ListBoxitemList4: TListBox;
    ButtonSellOffAdd: TButton;
    ButtonSellOffDel: TButton;
    ButtonSellOffAddAll: TButton;
    ButtonSellOffDelAll: TButton;
    ButtonSellOffSave: TButton;
    TabSheet14: TTabSheet;
    GroupBox22: TGroupBox;
    ListBoxAllowPickUpItem: TListBox;
    GroupBox23: TGroupBox;
    ListBoxitemList5: TListBox;
    ButtonPickItemAdd: TButton;
    ButtonPickItemDel: TButton;
    ButtonPickItemAddAll: TButton;
    ButtonPickItemDelAll: TButton;
    ButtonPickItemSave: TButton;
    GroupBox24: TGroupBox;
    ListBoxDisableSendMsg: TListBox;
    GroupBox25: TGroupBox;
    Label22: TLabel;
    DisableSendMsg_Edt: TEdit;
    ListBoxDisableSendMsgAdd: TButton;
    ListBoxDisableSendMsgDelete: TButton;
    ts1: TTabSheet;
    GridITemBindDieName: TStringGrid;
    grp1: TGroupBox;
    lbl1: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    ButtonItemBindDieNameMod: TButton;
    EditItemBindDieNameItemIdx: TSpinEdit;
    EditItemBindDieNameItemName: TEdit;
    ButtonItemBindDieNameAdd: TButton;
    ButtonItemBindDieNameRef: TButton;
    ButtonItemBindDieNameDel: TButton;
    EditItemBindDieNameName: TEdit;
    ButtonMonDropLimitClear: TButton;
    TabSheet15: TTabSheet;
    GroupBox26: TGroupBox;
    ListBoxArmsExchangeList: TListBox;
    ButtonEnableArmsExchangeAdd: TButton;
    ButtonEnableArmsExchangeDelete: TButton;
    ButtonEnableArmsExchangeSave: TButton;
    GroupBox27: TGroupBox;
    ListBoxItemList6: TListBox;
    Edit1: TEdit;
    Label23: TLabel;
    Label24: TLabel;
    SpinEdit1: TSpinEdit;
    TabSheet16: TTabSheet;
    GroupBox28: TGroupBox;
    ListBoxAllowAIPickUpItem: TListBox;
    GroupBox29: TGroupBox;
    ListBoxitemList7: TListBox;
    ButtonAIPickItemAdd: TButton;
    ButtonAIPickItemDel: TButton;
    ButtonAIPickItemAddAll: TButton;
    ButtonAIPickItemDelAll: TButton;
    ButtonAIPickItemSave: TButton;
    TabSheet17: TTabSheet;
    GroupBox30: TGroupBox;
    ListBoxLimitItemList: TListBox;
    GroupBox31: TGroupBox;
    ListBoxItemList8: TListBox;
    Edit2: TEdit;
    Label25: TLabel;
    Label26: TLabel;
    SpinEdit2: TSpinEdit;
    ButtonLimitItemListAdd: TButton;
    ButtonLimitItemListDelete: TButton;
    ButtonLimitItemListSave: TButton;
    TabSheet18: TTabSheet;
    GroupBox32: TGroupBox;
    ListBoxitemList9: TListBox;
    GroupBox33: TGroupBox;
    ListBoxAllowShopItem: TListBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    procedure FormCreate(Sender: TObject);
    procedure ListBoxItemListClick(Sender: TObject);
    procedure ListBoxEnableMakeListClick(Sender: TObject);
    procedure ButtonEnableMakeAddClick(Sender: TObject);
    procedure ButtonEnableMakeDeleteClick(Sender: TObject);
    procedure ButtonEnableMakeSaveClick(Sender: TObject);
    procedure ButtonDisableMakeAddAllClick(Sender: TObject);
    procedure ButtonDisableMakeDeleteAllClick(Sender: TObject);
    procedure ButtonEnableMakeAddAllClick(Sender: TObject);
    procedure ButtonEnableMakeDeleteAllClick(Sender: TObject);
    procedure ListBoxitemList1Click(Sender: TObject);
    procedure ListBoxDisableMakeListClick(Sender: TObject);
    procedure ButtonDisableMakeAddClick(Sender: TObject);
    procedure ButtonDisableMakeDeleteClick(Sender: TObject);
    procedure ButtonDisableMakeSaveClick(Sender: TObject);
    procedure ButtonDisableMoveMapAddClick(Sender: TObject);
    procedure ButtonDisableMoveMapDeleteClick(Sender: TObject);
    procedure ButtonDisableMoveMapAddAllClick(Sender: TObject);
    procedure ButtonDisableMoveMapSaveClick(Sender: TObject);
    procedure ButtonDisableMoveMapDeleteAllClick(Sender: TObject);
    procedure ListBoxMapListClick(Sender: TObject);
    procedure ListBoxDisableMoveMapClick(Sender: TObject);
    procedure ButtonMonDropLimitRefClick(Sender: TObject);
    procedure StringGridMonDropLimitClick(Sender: TObject);
    procedure EditDropCountChange(Sender: TObject);
    procedure EditCountLimitChange(Sender: TObject);
    procedure EditNoDropCountChange(Sender: TObject);
    procedure ButtonMonDropLimitSaveClick(Sender: TObject);
    procedure ListBoxGameLogListClick(Sender: TObject);
    procedure ListBoxitemList2Click(Sender: TObject);
    procedure ButtonGameLogAddClick(Sender: TObject);
    procedure ButtonGameLogDelClick(Sender: TObject);
    procedure ButtonGameLogAddAllClick(Sender: TObject);
    procedure ButtonGameLogDelAllClick(Sender: TObject);
    procedure ButtonGameLogSaveClick(Sender: TObject);
    procedure ButtonDisableTakeOffAddClick(Sender: TObject);
    procedure ButtonDisableTakeOffDelClick(Sender: TObject);
    procedure ListBoxDisableTakeOffListClick(Sender: TObject);
    procedure ListBoxitemList3Click(Sender: TObject);
    procedure ButtonDisableTakeOffAddAllClick(Sender: TObject);
    procedure ButtonDisableTakeOffDelAllClick(Sender: TObject);
    procedure ButtonDisableTakeOffSaveClick(Sender: TObject);
    procedure ButtonNoClearMonAddClick(Sender: TObject);
    procedure ButtonNoClearMonDelClick(Sender: TObject);
    procedure ButtonNoClearMonAddAllClick(Sender: TObject);
    procedure ButtonNoClearMonDelAllClick(Sender: TObject);
    procedure ButtonNoClearMonSaveClick(Sender: TObject);
    procedure ListBoxNoClearMonListClick(Sender: TObject);
    procedure ListBoxMonListClick(Sender: TObject);
    procedure ButtonAdminLitsSaveClick(Sender: TObject);
    procedure ListBoxAdminListClick(Sender: TObject);
    procedure ButtonAdminListChangeClick(Sender: TObject);
    procedure ButtonAdminListAddClick(Sender: TObject);
    procedure ButtonAdminListDelClick(Sender: TObject);
    procedure ButtonMonDropLimitAddClick(Sender: TObject);
    procedure ButtonMonDropLimitDelClick(Sender: TObject);
    procedure GridItemBindAccountClick(Sender: TObject);
    procedure EditItemBindAccountItemIdxChange(Sender: TObject);
    procedure EditItemBindAccountItemMakeIdxChange(Sender: TObject);
    procedure ButtonItemBindAcountModClick(Sender: TObject);
    procedure EditItemBindAccountNameChange(Sender: TObject);
    procedure ButtonItemBindAcountRefClick(Sender: TObject);
    procedure ButtonItemBindAcountAddClick(Sender: TObject);
    procedure ButtonItemBindAcountDelClick(Sender: TObject);
    procedure GridItemBindCharNameClick(Sender: TObject);
    procedure EditItemBindCharNameItemIdxChange(Sender: TObject);
    procedure EditItemBindCharNameItemMakeIdxChange(Sender: TObject);
    procedure EditItemBindCharNameNameChange(Sender: TObject);
    procedure ButtonItemBindCharNameAddClick(Sender: TObject);
    procedure ButtonItemBindCharNameModClick(Sender: TObject);
    procedure ButtonItemBindCharNameDelClick(Sender: TObject);
    procedure ButtonItemBindCharNameRefClick(Sender: TObject);
    procedure GridItemBindIPaddrClick(Sender: TObject);
    procedure EditItemBindIPaddrItemIdxChange(Sender: TObject);
    procedure EditItemBindIPaddrItemMakeIdxChange(Sender: TObject);
    procedure EditItemBindIPaddrNameChange(Sender: TObject);
    procedure ButtonItemBindIPaddrAddClick(Sender: TObject);
    procedure ButtonItemBindIPaddrModClick(Sender: TObject);
    procedure ButtonItemBindIPaddrDelClick(Sender: TObject);
    procedure ButtonItemBindIPaddrRefClick(Sender: TObject);
    procedure EditItemNameIdxChange(Sender: TObject);
    procedure EditItemNameMakeIndexChange(Sender: TObject);
    procedure EditItemNameNewNameChange(Sender: TObject);
    procedure ButtonItemNameAddClick(Sender: TObject);
    procedure ButtonItemNameModClick(Sender: TObject);
    procedure ButtonItemNameDelClick(Sender: TObject);
    procedure GridItemNameListClick(Sender: TObject);
    procedure ButtonItemNameRefClick(Sender: TObject);
    procedure ListBoxitemList4Click(Sender: TObject);
    procedure ButtonSellOffDelClick(Sender: TObject);
    procedure ListBoxSellOffListClick(Sender: TObject);
    procedure ButtonSellOffAddAllClick(Sender: TObject);
    procedure ButtonSellOffDelAllClick(Sender: TObject);
    procedure ButtonSellOffSaveClick(Sender: TObject);
    procedure ButtonSellOffAddClick(Sender: TObject);
    procedure ListBoxAllowPickUpItemClick(Sender: TObject);
    procedure ListBoxitemList5Click(Sender: TObject);
    procedure ButtonPickItemAddAllClick(Sender: TObject);
    procedure ButtonPickItemDelAllClick(Sender: TObject);
    procedure ButtonPickItemSaveClick(Sender: TObject);
    procedure ButtonPickItemAddClick(Sender: TObject);
    procedure ButtonPickItemDelClick(Sender: TObject);
    procedure ListBoxDisableSendMsgClick(Sender: TObject);
    procedure ListBoxDisableSendMsgAddClick(Sender: TObject);
    procedure DisableSendMsg_EdtChange(Sender: TObject);
    procedure ListBoxDisableSendMsgDeleteClick(Sender: TObject);
    procedure EditItemBindDieNameItemIdxChange(Sender: TObject);
    procedure GridITemBindDieNameClick(Sender: TObject);
    procedure ButtonItemBindDieNameModClick(Sender: TObject);
    procedure ButtonItemBindDieNameDelClick(Sender: TObject);
    procedure ButtonItemBindDieNameAddClick(Sender: TObject);
    procedure ButtonItemBindDieNameRefClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure ButtonMonDropLimitClearClick(Sender: TObject);
    procedure ButtonEnableArmsExchangeSaveClick(Sender: TObject);
    procedure ListBoxItemList6Click(Sender: TObject);
    procedure ButtonEnableArmsExchangeDeleteClick(Sender: TObject);
    procedure ButtonEnableArmsExchangeAddClick(Sender: TObject);
    procedure ListBoxArmsExchangeListClick(Sender: TObject);
    procedure ListBoxitemList7Click(Sender: TObject);
    procedure ButtonAIPickItemAddClick(Sender: TObject);
    procedure ButtonAIPickItemDelClick(Sender: TObject);
    procedure ButtonAIPickItemAddAllClick(Sender: TObject);
    procedure ButtonAIPickItemDelAllClick(Sender: TObject);
    procedure ButtonAIPickItemSaveClick(Sender: TObject);
    procedure ListBoxAllowAIPickUpItemClick(Sender: TObject);
    procedure ButtonLimitItemListAddClick(Sender: TObject);
    procedure ButtonLimitItemListDeleteClick(Sender: TObject);
    procedure ButtonLimitItemListSaveClick(Sender: TObject);
    procedure ListBoxLimitItemListClick(Sender: TObject);
    procedure ListBoxItemList8Click(Sender: TObject);
    procedure ListBoxitemList9Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ListBoxAllowShopItemClick(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    boOpened: Boolean;
    boModValued: Boolean;

    procedure ModValue();
    procedure uModValue();
    procedure RefMonDropLimit();
    procedure RefAdminList;
    procedure RefNoClearMonList();
    procedure RefItemBindAccount();
    procedure RefItemBindCharName();
    procedure RefItemBindDieNoDropName();//刷新人物装备死亡不爆列表 20081127
    procedure RefItemBindIPaddr();
    procedure RefItemCustomNameList();
    procedure RefMsgFilterList();
    { Private declarations }
  public
    procedure Open();
    { Public declarations }
  end;

var
  frmViewList: TfrmViewList;

implementation

uses M2Share, UsrEngn, Envir, HUtil32, LocalDB;

{$R *.dfm}

{ TfrmViewList }

procedure TfrmViewList.ModValue;
begin
  boModValued := True;
  ButtonEnableMakeSave.Enabled := True;
  ButtonDisableMakeSave.Enabled := True;
  ButtonDisableMoveMapSave.Enabled := True;
  ButtonGameLogSave.Enabled := True;
  ButtonDisableTakeOffSave.Enabled := True;
  ButtonNoClearMonSave.Enabled := True;
  ButtonSellOffSave.Enabled := True;
  ButtonPickItemSave.Enabled := True;
  ButtonAIPickItemSave.Enabled := True;
  ButtonLimitItemListSave.Enabled := True;
  Button5.Enabled := True;
end;

procedure TfrmViewList.uModValue;
begin
  boModValued := False;
  ButtonEnableMakeSave.Enabled := False;
  ButtonDisableMakeSave.Enabled := False;
  ButtonDisableMoveMapSave.Enabled := False;
  ButtonGameLogSave.Enabled := False;
  ButtonDisableTakeOffSave.Enabled := False;
  ButtonNoClearMonSave.Enabled := False;
  ButtonSellOffSave.Enabled := False;
  ButtonPickItemSave.Enabled := False;
  ButtonAIPickItemSave.Enabled := False;
  ButtonLimitItemListSave.Enabled := False;
  Button5.Enabled := False;
end;

procedure TfrmViewList.Open;
var
  I: Integer;
  StdItem: pTStdItem;
  Envir: TEnvirnoment;
begin
  boOpened := False;
  uModValue();
  {$IF HEROVERSION = 1}
  TabSheet14.Caption:='允许分身(英雄)捡取物品';
  {$ELSE}
  TabSheet14.Caption:='允许分身捡取物品';
  {$IFEND}
  ListBoxDisableMakeList.Items.Clear;
  ListBoxEnableMakeList.Items.Clear;
  ListBoxItemList.Items.Clear;
  ListBoxitemList1.Items.Clear;
  ListBoxitemList4.Items.Clear;
  ListBoxitemList5.Items.Clear;
  ListBoxitemList6.Items.Clear;
  ListBoxitemList7.Items.Clear;
  ListBoxitemList8.Items.Clear;
  ListBoxitemList9.Items.Clear;
  EnterCriticalSection(ProcessHumanCriticalSection);
  try
    ListBoxitemList2.Items.Add(g_sHumanDieEvent);
    ListBoxitemList2.Items.Add(sSTRING_GOLDNAME);
    ListBoxitemList2.Items.Add(g_Config.sGameGoldName);
    ListBoxitemList2.Items.Add(g_Config.sGamePointName);
    ListBoxitemList2.Items.Add(g_Config.sGameDiaMond); //金刚石
    ListBoxitemList2.Items.Add(g_Config.sGameGird); //灵符
    ListBoxitemList2.Items.Add(g_Config.sGameGlory);//荣誉值 20080809
    if UserEngine.StdItemList.Count > 0 then begin//20080630
      for I := 0 to UserEngine.StdItemList.Count - 1 do begin
        StdItem := UserEngine.StdItemList.Items[I];
        ListBoxItemList.Items.Add(StdItem.Name);//20080731 修改
        ListBoxitemList1.Items.Add(StdItem.Name);
        ListBoxitemList2.Items.Add(StdItem.Name);
        ListBoxitemList3.Items.Add(StdItem.Name);
        ListBoxitemList4.Items.Add(StdItem.Name);
        ListBoxitemList5.Items.Add(StdItem.Name);
        ListBoxitemList6.Items.Add(StdItem.Name);
        ListBoxitemList7.Items.Add(StdItem.Name);
        ListBoxitemList8.Items.Add(StdItem.Name);
        ListBoxitemList9.Items.Add(StdItem.Name);
      end;
    end;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
  if g_MapManager.Count > 0 then begin//20080630
    for I := 0 to g_MapManager.Count - 1 do begin
      Envir := TEnvirnoment(g_MapManager.Items[I]);
      ListBoxMapList.Items.Add(Envir.sMapName);
    end;
  end;
  g_LimitItemList.Lock;
  try
    if g_LimitItemList.Count > 0 then begin
      for I := 0 to g_LimitItemList.Count - 1 do begin
        ListBoxLimitItemList.Items.Add(g_LimitItemList.Strings[I]+'-'+inttostr(Integer(g_LimitItemList.Objects[I])));
      end;
    end;
  finally
    g_LimitItemList.UnLock;
  end;
  {$IF M2Version <> 2}
  g_EnableArmsExchangeList.Lock;
  try
    if g_EnableArmsExchangeList.Count > 0 then begin
      for I := 0 to g_EnableArmsExchangeList.Count - 1 do begin
        ListBoxArmsExchangeList.Items.Add(g_EnableArmsExchangeList.Strings[I]+'-'+inttostr(Integer(g_EnableArmsExchangeList.Objects[I])));
      end;
    end;
  finally
    g_EnableArmsExchangeList.UnLock;
  end;
  {$IFEND}
  g_EnableMakeItemList.Lock;
  try
    if g_EnableMakeItemList.Count > 0 then begin//20080630
      for I := 0 to g_EnableMakeItemList.Count - 1 do begin
        ListBoxEnableMakeList.Items.Add(g_EnableMakeItemList.Strings[I]);
      end;
    end;
  finally
    g_EnableMakeItemList.UnLock;
  end;

  g_DisableMakeItemList.Lock;
  try
    if g_DisableMakeItemList.Count > 0 then begin//20080630
      for I := 0 to g_DisableMakeItemList.Count - 1 do begin
        ListBoxDisableMakeList.Items.Add(g_DisableMakeItemList.Strings[I]);
      end;
    end;
  finally
    g_DisableMakeItemList.UnLock;
  end;

  g_GameLogItemNameList.Lock;
  try
    if g_GameLogItemNameList.Count > 0 then begin//20080630
      for I := 0 to g_GameLogItemNameList.Count - 1 do begin
        ListBoxGameLogList.Items.Add(g_GameLogItemNameList.Strings[I]);
      end;
    end;
  finally
    g_GameLogItemNameList.UnLock;
  end;

  g_DisableTakeOffList.Lock;
  try
    if g_DisableTakeOffList.Count > 0 then begin//20080630
      for I := 0 to g_DisableTakeOffList.Count - 1 do begin
        ListBoxDisableTakeOffList.Items.AddObject(IntToStr(Integer(g_DisableTakeOffList.Objects[I])) + '  ' + g_DisableTakeOffList.Strings[I], g_DisableTakeOffList.Objects[I]);
      end;
    end;
  finally
    g_DisableTakeOffList.UnLock;
  end;

 { g_AllowSellOffItemList.Lock;  //20080416 去掉拍卖功能
  try
    for I := 0 to g_AllowSellOffItemList.Count - 1 do begin
      ListBoxSellOffList.Items.Add(g_AllowSellOffItemList.Strings[I]);
    end;
  finally
    g_AllowSellOffItemList.UnLock;
  end; }

//加载禁止发信息名称列表
  g_DisableSendMsgList.Lock;
  try
    if g_DisableSendMsgList.Count > 0 then begin//20080630
      for I := 0 to g_DisableSendMsgList.Count - 1 do begin
        ListBoxDisableSendMsg.Items.Add(g_DisableSendMsgList.Strings[I]);
      end;
    end;
  finally
    g_DisableSendMsgList.UnLock;
  end;

  if g_AllowPickUpItemList <> nil then begin
    ListBoxAllowPickUpItem.Items.Clear;
    g_AllowPickUpItemList.Lock;
    try
      if g_AllowPickUpItemList.Count > 0 then begin//20080630
        for I := 0 to g_AllowPickUpItemList.Count - 1 do begin
          ListBoxAllowPickUpItem.Items.Add(g_AllowPickUpItemList.Strings[I]);
        end;
      end;
    finally
      g_AllowPickUpItemList.UnLock;
    end;
  end;

  if g_AllowAIPickUpItemList <> nil then begin
    ListBoxAllowAIPickUpItem.Items.Clear;
    g_AllowAIPickUpItemList.Lock;
    try
      if g_AllowAIPickUpItemList.Count > 0 then begin//20080630
        for I := 0 to g_AllowAIPickUpItemList.Count - 1 do begin
          ListBoxAllowAIPickUpItem.Items.Add(g_AllowAIPickUpItemList.Strings[I]);
        end;
      end;
    finally
      g_AllowAIPickUpItemList.UnLock;
    end;
  end;
  if g_DisableGamePointShopItemList <> nil then begin
    ListBoxAllowShopItem.Items.Clear;
    g_DisableGamePointShopItemList.Lock;
    try
      if g_DisableGamePointShopItemList.Count > 0 then begin//20080630
        for I := 0 to g_DisableGamePointShopItemList.Count - 1 do begin
          ListBoxAllowShopItem.Items.Add(g_DisableGamePointShopItemList.Strings[I]);
        end;
      end;
    finally
      g_DisableGamePointShopItemList.UnLock;
    end;
  end;
  g_DisableMoveMapList.Lock;
  try
    if g_DisableMoveMapList.Count > 0 then begin//20080630
      for I := 0 to g_DisableMoveMapList.Count - 1 do begin
        ListBoxDisableMoveMap.Items.Add(g_DisableMoveMapList.Strings[I]);
      end;
    end;
  finally
    g_DisableMoveMapList.UnLock;
  end;

  RefItemBindAccount();

  RefItemBindCharName();
  RefItemBindDieNoDropName();//刷新人物装备死亡不爆列表 20081127
  RefItemBindIPaddr();

  RefMonDropLimit();
  RefAdminList();
  RefNoClearMonList();
  RefItemCustomNameList();
  RefMsgFilterList();

  boOpened := True;
  PageControlViewList.ActivePageIndex := 0;
  TabSheet13.TabVisible:= False;//隐藏状态控制页面 20091123
  {$IF M2Version = 2}
  TabSheet15.TabVisible:= False;//隐藏状态控制页面
  {$ELSE}
  TabSheet15.Caption:= '可兑换'+ g_Config.sArmsExchangeItme;
  GroupBox26.Caption:= '可兑换'+ g_Config.sArmsExchangeItme+'列表';
  {$IFEND}
  ShowModal;
end;

procedure TfrmViewList.FormCreate(Sender: TObject);
begin
  GridItemBindAccount.Cells[0, 0] := '物品名称';
  GridItemBindAccount.Cells[1, 0] := '物品IDX';
  GridItemBindAccount.Cells[2, 0] := '物品系列号';
  GridItemBindAccount.Cells[3, 0] := '绑定帐号';

  GridItemBindCharName.Cells[0, 0] := '物品名称';
  GridItemBindCharName.Cells[1, 0] := '物品IDX';
  GridItemBindCharName.Cells[2, 0] := '物品系列号';
  GridItemBindCharName.Cells[3, 0] := '绑定人物';

  GridItemBindIPaddr.Cells[0, 0] := '物品名称';
  GridItemBindIPaddr.Cells[1, 0] := '物品IDX';
  GridItemBindIPaddr.Cells[2, 0] := '物品系列号';
  GridItemBindIPaddr.Cells[3, 0] := '绑定IP';

  StringGridMonDropLimit.Cells[0, 0] := '物品名称';
  StringGridMonDropLimit.Cells[1, 0] := '爆数量';
  StringGridMonDropLimit.Cells[2, 0] := '限制数量';
  StringGridMonDropLimit.Cells[3, 0] := '未爆数量';

  GridItemNameList.Cells[0, 0] := '原始名称';
  GridItemNameList.Cells[1, 0] := '物品编号';
  GridItemNameList.Cells[2, 0] := '自定义名称';

  GridITemBindDieName.Cells[0, 0] := '物品名称';
  GridITemBindDieName.Cells[1, 0] := '物品IDX';
  GridITemBindDieName.Cells[2, 0] := '绑定人物';

  TabSheetMonDrop.TabVisible := True;

  ButtonEnableMakeAdd.Enabled := False;
  ButtonEnableMakeDelete.Enabled := False;
  ButtonDisableMakeAdd.Enabled := False;
  ButtonDisableMakeDelete.Enabled := False;
  ButtonDisableMoveMapAdd.Enabled := False;
  ButtonDisableMoveMapDelete.Enabled := False;
  ButtonGameLogAdd.Enabled := False;
  ButtonGameLogDel.Enabled := False;

  ButtonNoClearMonAdd.Enabled := False;
  ButtonDisableTakeOffDel.Enabled := False;

  ButtonDisableTakeOffAdd.Enabled := False;
  ButtonNoClearMonDel.Enabled := False;

  ButtonSellOffAdd.Enabled := False;
  ButtonSellOffDel.Enabled := False;
  ButtonPickItemAdd.Enabled := False;
  ButtonPickItemDel.Enabled := False;
  ButtonAIPickItemAdd.Enabled := False;
  ButtonAIPickItemDel.Enabled := False;
  Button2.Enabled := False;
{$IF SoftVersion = VERDEMO}
  Caption := '查看列表信息[演示版本，所有设置调整有效，但不能保存]';
{$IFEND}

{$IF VEROWNER = WL}
  EditAdminIPaddr.Visible := True;
  LabelAdminIPaddr.Visible := True;
{$ELSE}
  EditAdminIPaddr.Visible := False;
  LabelAdminIPaddr.Visible := False;
{$IFEND}
end;

procedure TfrmViewList.ListBoxItemList6Click(Sender: TObject);
begin
  if not boOpened then Exit;
  if ListBoxItemList6.ItemIndex >= 0 then begin
    Edit1.text:= ListBoxItemList6.Items.Strings[ListBoxItemList6.ItemIndex];
    ButtonEnableArmsExchangeAdd.Enabled := True;
  end;
end;

procedure TfrmViewList.ListBoxitemList7Click(Sender: TObject);
begin
  if not boOpened then Exit;
  if ListBoxitemList7.ItemIndex >= 0 then
    ButtonAIPickItemAdd.Enabled := True;
end;

procedure TfrmViewList.ListBoxItemList8Click(Sender: TObject);
begin
  if not boOpened then Exit;
  if ListBoxItemList8.ItemIndex >= 0 then begin
    Edit2.text:= ListBoxItemList8.Items.Strings[ListBoxItemList8.ItemIndex];
    ButtonLimitItemListAdd.Enabled := True;
  end;
end;

procedure TfrmViewList.ListBoxitemList9Click(Sender: TObject);
begin
  if not boOpened then Exit;
  if ListBoxitemList9.ItemIndex >= 0 then
    Button1.Enabled := True;
end;

procedure TfrmViewList.ListBoxItemListClick(Sender: TObject);
begin
  if not boOpened then Exit;
  if ListBoxItemList.ItemIndex >= 0 then
    ButtonEnableMakeAdd.Enabled := True;
end;

procedure TfrmViewList.ListBoxLimitItemListClick(Sender: TObject);
begin
  if not boOpened then Exit;
  if ListBoxLimitItemList.ItemIndex >= 0 then
    ButtonLimitItemListDelete.Enabled := True;
end;

procedure TfrmViewList.ListBoxEnableMakeListClick(Sender: TObject);
begin
  if not boOpened then Exit;
  if ListBoxEnableMakeList.ItemIndex >= 0 then
    ButtonEnableMakeDelete.Enabled := True;
end;

procedure TfrmViewList.ButtonEnableMakeAddClick(Sender: TObject);
var
  I: Integer;
begin
  if ListBoxItemList.ItemIndex >= 0 then begin
    if ListBoxEnableMakeList.Items.Count > 0 then begin//20080630
      for I := 0 to ListBoxEnableMakeList.Items.Count - 1 do begin
        if ListBoxEnableMakeList.Items.Strings[I] = ListBoxItemList.Items.Strings[ListBoxItemList.ItemIndex] then begin
          Application.MessageBox('此物品已在列表中！！！', '错误信息', MB_OK + MB_ICONERROR);
          Exit;
        end;
      end;
    end;
    ListBoxEnableMakeList.Items.Add(ListBoxItemList.Items.Strings[ListBoxItemList.ItemIndex]);
    ModValue();
  end;
end;

procedure TfrmViewList.ButtonEnableArmsExchangeAddClick(Sender: TObject);
var
  n10: Integer;
  sItmeName: String;
begin
  if Edit1.text <> '' then begin
    {$IF M2Version <> 2}
    if CanArmsExchangeItem(Edit1.text) then begin
      Application.MessageBox('此物品已在列表中！！！', '错误信息', MB_OK + MB_ICONERROR);
      Exit;
    end;
    sItmeName:= Edit1.text;
    n10:= SpinEdit1.Value;
    g_EnableArmsExchangeList.Lock;
    try
      g_EnableArmsExchangeList.AddObject(sItmeName, TObject(n10));
    finally
      g_EnableArmsExchangeList.UnLock;
    end;
    ListBoxArmsExchangeList.Items.Add(sItmeName+'-'+inttostr(n10));
    Edit1.text:='';
    ModValue();
    {$IFEND}
  end;
end;

procedure TfrmViewList.ButtonEnableArmsExchangeDeleteClick(Sender: TObject);
begin
  {$IF M2Version <> 2}
  if ListBoxArmsExchangeList.ItemIndex >= 0 then begin
    g_EnableArmsExchangeList.Lock;
    try
      g_EnableArmsExchangeList.Delete(ListBoxArmsExchangeList.ItemIndex);
    finally
      g_EnableArmsExchangeList.UnLock;
    end;
    ListBoxArmsExchangeList.Items.Delete(ListBoxArmsExchangeList.ItemIndex);
    ModValue();
  end;
  if ListBoxArmsExchangeList.ItemIndex < 0 then ButtonEnableArmsExchangeDelete.Enabled := False;
  {$IFEND}
end;

procedure TfrmViewList.ButtonEnableArmsExchangeSaveClick(Sender: TObject);
begin
  {$IF M2Version <> 2}
  SaveEnableArmsExchangeItem();
  uModValue();
  {$IFEND}
end;

procedure TfrmViewList.ButtonEnableMakeAddAllClick(Sender: TObject);
var
  I: Integer;
begin
  ListBoxEnableMakeList.Items.Clear;
  if ListBoxItemList.Items.Count > 0 then begin//20080630
    for I := 0 to ListBoxItemList.Items.Count - 1 do begin
      ListBoxEnableMakeList.Items.Add(ListBoxItemList.Items.Strings[I]);
    end;
  end;
  ModValue();
end;

procedure TfrmViewList.ButtonEnableMakeDeleteAllClick(Sender: TObject);
begin
  ListBoxEnableMakeList.Items.Clear;
  ButtonEnableMakeDelete.Enabled := False;
  ModValue();
end;

procedure TfrmViewList.ButtonEnableMakeDeleteClick(Sender: TObject);
begin
  if ListBoxEnableMakeList.ItemIndex >= 0 then begin
    ListBoxEnableMakeList.Items.Delete(ListBoxEnableMakeList.ItemIndex);
    ModValue();
  end;
  if ListBoxEnableMakeList.ItemIndex < 0 then
    ButtonEnableMakeDelete.Enabled := False;
end;


procedure TfrmViewList.ButtonEnableMakeSaveClick(Sender: TObject);
var
  I: Integer;
begin
  g_EnableMakeItemList.Lock;
  try
    g_EnableMakeItemList.Clear;
    if ListBoxEnableMakeList.Items.Count > 0 then begin//20080630
      for I := 0 to ListBoxEnableMakeList.Items.Count - 1 do begin
        g_EnableMakeItemList.Add(ListBoxEnableMakeList.Items.Strings[I])
      end;
    end;
  finally
    g_EnableMakeItemList.UnLock;
  end;
  SaveEnableMakeItem();
  uModValue();
end;

procedure TfrmViewList.ListBoxitemList1Click(Sender: TObject);
begin
  if not boOpened then Exit;
  if ListBoxitemList1.ItemIndex >= 0 then
    ButtonDisableMakeAdd.Enabled := True;
end;

procedure TfrmViewList.ListBoxDisableMakeListClick(Sender: TObject);
begin
  if not boOpened then Exit;
  if ListBoxDisableMakeList.ItemIndex >= 0 then
    ButtonDisableMakeDelete.Enabled := True;
end;

procedure TfrmViewList.ButtonDisableMakeAddClick(Sender: TObject);
var
  I: Integer;
begin
  if ListBoxitemList1.ItemIndex >= 0 then begin
    if ListBoxDisableMakeList.Items.Count > 0 then begin//20080630
      for I := 0 to ListBoxDisableMakeList.Items.Count - 1 do begin
        if ListBoxDisableMakeList.Items.Strings[I] = ListBoxitemList1.Items.Strings[ListBoxitemList1.ItemIndex] then begin
          Application.MessageBox('此物品已在列表中！！！', '错误信息', MB_OK + MB_ICONERROR);
          Exit;
        end;
      end;
    end;
    ListBoxDisableMakeList.Items.Add(ListBoxitemList1.Items.Strings[ListBoxitemList1.ItemIndex]);
    ModValue();
  end;
end;

procedure TfrmViewList.ButtonDisableMakeDeleteClick(Sender: TObject);
begin
  if ListBoxDisableMakeList.ItemIndex >= 0 then begin
    ListBoxDisableMakeList.Items.Delete(ListBoxDisableMakeList.ItemIndex);
    ModValue();
  end;
  if ListBoxDisableMakeList.ItemIndex < 0 then
    ButtonDisableMakeDelete.Enabled := False;
end;

procedure TfrmViewList.ButtonDisableMakeAddAllClick(Sender: TObject);
var
  I: Integer;
begin
  ListBoxDisableMakeList.Items.Clear;
  if ListBoxitemList1.Items.Count > 0 then begin//20080630
    for I := 0 to ListBoxitemList1.Items.Count - 1 do begin
      ListBoxDisableMakeList.Items.Add(ListBoxitemList1.Items.Strings[I]);
    end;
  end;
  ModValue();
end;

procedure TfrmViewList.ButtonDisableMakeDeleteAllClick(Sender: TObject);
begin
  ListBoxDisableMakeList.Items.Clear;
  ButtonDisableMakeDelete.Enabled := False;
  ModValue();
end;



procedure TfrmViewList.ButtonDisableMakeSaveClick(Sender: TObject);
var
  I: Integer;
begin
  g_DisableMakeItemList.Lock;
  try
    g_DisableMakeItemList.Clear;
    if ListBoxDisableMakeList.Items.Count > 0 then begin//20080630
      for I := 0 to ListBoxDisableMakeList.Items.Count - 1 do begin
        g_DisableMakeItemList.Add(ListBoxDisableMakeList.Items.Strings[I])
      end;
    end;
  finally
    g_DisableMakeItemList.UnLock;
  end;
  SaveDisableMakeItem();
  uModValue();
end;

procedure TfrmViewList.ButtonDisableMoveMapAddClick(Sender: TObject);
var
  I: Integer;
begin
  if ListBoxMapList.ItemIndex >= 0 then begin
    if ListBoxDisableMoveMap.Items.Count > 0 then begin//20080630
      for I := 0 to ListBoxDisableMoveMap.Items.Count - 1 do begin
        if ListBoxDisableMoveMap.Items.Strings[I] = ListBoxMapList.Items.Strings[ListBoxMapList.ItemIndex] then begin
          Application.MessageBox('此地图已在列表中！！！', '错误信息', MB_OK + MB_ICONERROR);
          Exit;
        end;
      end;
    end;
    ListBoxDisableMoveMap.Items.Add(ListBoxMapList.Items.Strings[ListBoxMapList.ItemIndex]);
    ModValue();
  end;
end;

procedure TfrmViewList.ButtonDisableMoveMapDeleteClick(Sender: TObject);
begin
  if ListBoxDisableMoveMap.ItemIndex >= 0 then begin
    ListBoxDisableMoveMap.Items.Delete(ListBoxDisableMoveMap.ItemIndex);
    ModValue();
  end;
  if ListBoxDisableMoveMap.ItemIndex < 0 then
    ButtonDisableMoveMapDelete.Enabled := False;
end;

procedure TfrmViewList.ButtonDisableMoveMapAddAllClick(Sender: TObject);
var
  I: Integer;
begin
  ListBoxDisableMoveMap.Items.Clear;
  if ListBoxMapList.Items.Count > 0 then begin//20080630
    for I := 0 to ListBoxMapList.Items.Count - 1 do begin
      ListBoxDisableMoveMap.Items.Add(ListBoxMapList.Items.Strings[I]);
    end;
  end;
  ModValue();
end;

procedure TfrmViewList.ButtonDisableMoveMapSaveClick(Sender: TObject);
var
  I: Integer;
begin
  g_DisableMoveMapList.Lock;
  try
    g_DisableMoveMapList.Clear;
    if ListBoxDisableMoveMap.Items.Count > 0 then begin//20080630
      for I := 0 to ListBoxDisableMoveMap.Items.Count - 1 do begin
        g_DisableMoveMapList.Add(ListBoxDisableMoveMap.Items.Strings[I])
      end;
    end;
  finally
    g_DisableMoveMapList.UnLock;
  end;
  SaveDisableMoveMap();
  uModValue();
end;

procedure TfrmViewList.ButtonDisableMoveMapDeleteAllClick(Sender: TObject);
begin
  ListBoxDisableMoveMap.Items.Clear;
  ButtonDisableMoveMapDelete.Enabled := False;
  ModValue();
end;

procedure TfrmViewList.ListBoxMapListClick(Sender: TObject);
begin
  if not boOpened then Exit;
  if ListBoxMapList.ItemIndex >= 0 then
    ButtonDisableMoveMapAdd.Enabled := True;
end;

procedure TfrmViewList.ListBoxDisableMoveMapClick(Sender: TObject);
begin
  if not boOpened then Exit;
  if ListBoxDisableMoveMap.ItemIndex >= 0 then
    ButtonDisableMoveMapDelete.Enabled := True;
end;

procedure TfrmViewList.RefMsgFilterList;
begin

end;

procedure TfrmViewList.RefMonDropLimit;
var
  I: Integer;
  MonDrop: pTMonDrop;
begin
  g_MonDropLimitLIst.Lock;
  try
    StringGridMonDropLimit.RowCount := g_MonDropLimitLIst.Count + 1;
    if StringGridMonDropLimit.RowCount > 1 then StringGridMonDropLimit.FixedRows := 1;

    if  g_MonDropLimitLIst.Count > 0 then begin//20080630
      for I := 0 to g_MonDropLimitLIst.Count - 1 do begin
        MonDrop := pTMonDrop(g_MonDropLimitLIst.Objects[I]);
        StringGridMonDropLimit.Cells[0, I + 1] := MonDrop.sItemName;
        StringGridMonDropLimit.Cells[1, I + 1] := IntToStr(MonDrop.nDropCount);
        StringGridMonDropLimit.Cells[2, I + 1] := IntToStr(MonDrop.nCountLimit);
        StringGridMonDropLimit.Cells[3, I + 1] := IntToStr(MonDrop.nNoDropCount);
      end;
    end;
  finally
    g_MonDropLimitLIst.UnLock;
  end;
end;

procedure TfrmViewList.ButtonMonDropLimitRefClick(Sender: TObject);
begin
  RefMonDropLimit();
end;

procedure TfrmViewList.StringGridMonDropLimitClick(Sender: TObject);
var
  nItemIndex: Integer;
  MonDrop: pTMonDrop;
begin
  nItemIndex := StringGridMonDropLimit.Row - 1;
  if nItemIndex < 0 then Exit;

  g_MonDropLimitLIst.Lock;
  try
    if nItemIndex >= g_MonDropLimitLIst.Count then Exit;
    MonDrop := pTMonDrop(g_MonDropLimitLIst.Objects[nItemIndex]);
    EditItemName.Text := MonDrop.sItemName;
    EditDropCount.Value := MonDrop.nDropCount;
    EditCountLimit.Value := MonDrop.nCountLimit;
    EditNoDropCount.Value := MonDrop.nNoDropCount;
  finally
    g_MonDropLimitLIst.UnLock;
  end;
end;

procedure TfrmViewList.EditDropCountChange(Sender: TObject);
begin
  if EditDropCount.Text = '' then begin
    EditDropCount.Text := '0';
    Exit;
  end;

end;

procedure TfrmViewList.EditCountLimitChange(Sender: TObject);
begin
  if EditCountLimit.Text = '' then begin
    EditCountLimit.Text := '0';
    Exit;
  end;
end;

procedure TfrmViewList.EditNoDropCountChange(Sender: TObject);
begin
  if EditNoDropCount.Text = '' then begin
    EditNoDropCount.Text := '0';
    Exit;
  end;
end;

procedure TfrmViewList.ButtonMonDropLimitSaveClick(Sender: TObject);
var
  sItemName: string;
  nNoDropCount: Integer;
  nDropCount: Integer;
  nDropLimit: Integer;
  nSelIndex: Integer;
  MonDrop: pTMonDrop;
begin
  sItemName := Trim(EditItemName.Text);
  nDropCount := EditDropCount.Value;
  nDropLimit := EditCountLimit.Value;
  nNoDropCount := EditNoDropCount.Value;

  nSelIndex := StringGridMonDropLimit.Row - 1;
  if nSelIndex < 0 then Exit;
  g_MonDropLimitLIst.Lock;
  try
    if nSelIndex >= g_MonDropLimitLIst.Count then Exit;
    MonDrop := pTMonDrop(g_MonDropLimitLIst.Objects[nSelIndex]);
    MonDrop.sItemName := sItemName;
    MonDrop.nDropCount := nDropCount;
    MonDrop.nNoDropCount := nNoDropCount;
    MonDrop.nCountLimit := nDropLimit;
  finally
    g_MonDropLimitLIst.UnLock;
  end;
  SaveMonDropLimitList();
  RefMonDropLimit();
end;

procedure TfrmViewList.ButtonMonDropLimitAddClick(Sender: TObject);
var
  I: Integer;
  sItemName: string;
  nNoDropCount: Integer;
  nDropCount: Integer;
  nDropLimit: Integer;
  MonDrop: pTMonDrop;
begin
  sItemName := Trim(EditItemName.Text);
  nDropCount := EditDropCount.Value;
  nDropLimit := EditCountLimit.Value;
  nNoDropCount := EditNoDropCount.Value;

  g_MonDropLimitLIst.Lock;
  try
    if g_MonDropLimitLIst.Count > 0 then begin//20080630
      I:= g_MonDropLimitLIst.IndexOf(sItemName);//20110518修改
      if I > -1 then begin
        Application.MessageBox('输入的物品名已经在列表中！！！', '提示信息', MB_OK + MB_ICONERROR);
        Exit;
      end;
     { for I := 0 to g_MonDropLimitLIst.Count - 1 do begin
        MonDrop := pTMonDrop(g_MonDropLimitLIst.Objects[I]);
        if CompareText(MonDrop.sItemName, sItemName) = 0 then begin
          Application.MessageBox('输入的物品名已经在列表中！！！', '提示信息', MB_OK + MB_ICONERROR);
          Exit;
        end;
      end;  }
    end;
    New(MonDrop);
    MonDrop.sItemName := sItemName;
    MonDrop.nDropCount := nDropCount;
    MonDrop.nNoDropCount := nNoDropCount;
    MonDrop.nCountLimit := nDropLimit;
    g_MonDropLimitLIst.AddObject(sItemName, TObject(MonDrop));
  finally
    g_MonDropLimitLIst.UnLock;
  end;
  SaveMonDropLimitList();
  RefMonDropLimit();
end;


procedure TfrmViewList.ButtonMonDropLimitDelClick(Sender: TObject);
var
  nSelIndex: Integer;
  MonDrop: pTMonDrop;
begin
  nSelIndex := StringGridMonDropLimit.Row - 1;
  if nSelIndex < 0 then Exit;
  g_MonDropLimitLIst.Lock;
  try
    if nSelIndex >= g_MonDropLimitLIst.Count then Exit;
    MonDrop := pTMonDrop(g_MonDropLimitLIst.Objects[nSelIndex]);
    Dispose(MonDrop);
    g_MonDropLimitLIst.Delete(nSelIndex);
  finally
    g_MonDropLimitLIst.UnLock;
  end;
  SaveMonDropLimitList();
  RefMonDropLimit();
end;

procedure TfrmViewList.ListBoxGameLogListClick(Sender: TObject);
begin
  if not boOpened then Exit;
  if ListBoxGameLogList.ItemIndex >= 0 then
    ButtonGameLogDel.Enabled := True;
end;

procedure TfrmViewList.ListBoxitemList2Click(Sender: TObject);
begin
  if not boOpened then Exit;
  if ListBoxitemList2.ItemIndex >= 0 then
    ButtonGameLogAdd.Enabled := True;
end;

procedure TfrmViewList.ButtonGameLogAddClick(Sender: TObject);
var
  I: Integer;
begin
  if ListBoxitemList2.ItemIndex >= 0 then begin
    if ListBoxGameLogList.Items.Count > 0 then begin//20080630
      for I := 0 to ListBoxGameLogList.Items.Count - 1 do begin
        if ListBoxGameLogList.Items.Strings[I] = ListBoxitemList2.Items.Strings[ListBoxitemList2.ItemIndex] then begin
          Application.MessageBox('此物品已在列表中！！！', '错误信息', MB_OK + MB_ICONERROR);
          Exit;
        end;
      end;
    end;
    ListBoxGameLogList.Items.Add(ListBoxitemList2.Items.Strings[ListBoxitemList2.ItemIndex]);
    ModValue();
  end;
end;

procedure TfrmViewList.ButtonGameLogDelClick(Sender: TObject);
begin
  if ListBoxGameLogList.ItemIndex >= 0 then begin
    ListBoxGameLogList.Items.Delete(ListBoxGameLogList.ItemIndex);
    ModValue();
  end;
  if ListBoxGameLogList.ItemIndex < 0 then
    ButtonGameLogDel.Enabled := False;
end;

procedure TfrmViewList.ButtonGameLogAddAllClick(Sender: TObject);
var
  I: Integer;
begin
  ListBoxGameLogList.Items.Clear;
  if ListBoxitemList2.Items.Count > 0 then begin//20080630
    for I := 0 to ListBoxitemList2.Items.Count - 1 do begin
      ListBoxGameLogList.Items.Add(ListBoxitemList2.Items.Strings[I]);
    end;
  end;
  ModValue();
end;

procedure TfrmViewList.ButtonGameLogDelAllClick(Sender: TObject);
begin
  ListBoxGameLogList.Items.Clear;
  ButtonGameLogDel.Enabled := False;
  ModValue();
end;

procedure TfrmViewList.ButtonGameLogSaveClick(Sender: TObject);
var
  I: Integer;
begin

  g_GameLogItemNameList.Lock;
  try
    g_GameLogItemNameList.Clear;
    if ListBoxGameLogList.Items.Count > 0 then begin//20080630
      for I := 0 to ListBoxGameLogList.Items.Count - 1 do begin
        g_GameLogItemNameList.Add(ListBoxGameLogList.Items.Strings[I])
      end;
    end;
  finally
    g_GameLogItemNameList.UnLock;
  end;
  uModValue();
{$IF SoftVersion <> VERDEMO}
  SaveGameLogItemNameList();
{$IFEND}
  if Application.MessageBox('此设置必须重新加载物品数据库才能生效，是否重新加载？', '确认信息', MB_YESNO + MB_ICONQUESTION) = mrYes then begin
    FrmDB.LoadItemsDB();
  end;
end;

procedure TfrmViewList.ButtonDisableTakeOffAddClick(Sender: TObject);
var
  I: Integer;
begin
  if ListBoxitemList3.ItemIndex >= 0 then begin
    if ListBoxDisableTakeOffList.Items.Count > 0 then begin//20080630
      for I := 0 to ListBoxDisableTakeOffList.Items.Count - 1 do begin
        if ListBoxDisableTakeOffList.Items.Strings[I] = (IntToStr(ListBoxitemList3.ItemIndex) + '  ' +ListBoxitemList3.Items.Strings[ListBoxitemList3.ItemIndex]) then begin
          Application.MessageBox('此物品已在列表中！！！', '错误信息', MB_OK + MB_ICONERROR);
          Exit;
        end;
      end;
    end;
    ListBoxDisableTakeOffList.Items.AddObject(IntToStr(ListBoxitemList3.ItemIndex) + '  ' + ListBoxitemList3.Items.Strings[ListBoxitemList3.ItemIndex], TObject(ListBoxitemList3.ItemIndex));
    ModValue();
  end;
end;

procedure TfrmViewList.ButtonDisableTakeOffDelClick(Sender: TObject);
begin
  if ListBoxDisableTakeOffList.ItemIndex >= 0 then begin
    ListBoxDisableTakeOffList.Items.Delete(ListBoxDisableTakeOffList.ItemIndex);
    ModValue();
  end;
  if ListBoxDisableTakeOffList.ItemIndex < 0 then
    ButtonDisableTakeOffDel.Enabled := False;
end;

procedure TfrmViewList.ListBoxDisableTakeOffListClick(Sender: TObject);
begin
  if not boOpened then Exit;
  if ListBoxDisableTakeOffList.ItemIndex >= 0 then
    ButtonDisableTakeOffDel.Enabled := True;
end;

procedure TfrmViewList.ListBoxitemList3Click(Sender: TObject);
begin
  if not boOpened then Exit;
  if ListBoxitemList3.ItemIndex >= 0 then
    ButtonDisableTakeOffAdd.Enabled := True;
end;

procedure TfrmViewList.ButtonDisableTakeOffAddAllClick(Sender: TObject);
var
  I: Integer;
begin
  ListBoxDisableTakeOffList.Items.Clear;
  if ListBoxitemList3.Items.Count > 0 then begin//20080630
    for I := 0 to ListBoxitemList3.Items.Count - 1 do begin
      ListBoxDisableTakeOffList.Items.AddObject(IntToStr(I) + '  ' + ListBoxitemList3.Items.Strings[I], TObject(I));
    end;
  end;
  ModValue();
end;

procedure TfrmViewList.ButtonDisableTakeOffDelAllClick(Sender: TObject);
begin
  ListBoxDisableTakeOffList.Items.Clear;
  ButtonDisableTakeOffDel.Enabled := False;
  ModValue();
end;

procedure TfrmViewList.ButtonDisableTakeOffSaveClick(Sender: TObject);
var
  I: Integer;
  sItemIdx: string;
begin
  g_DisableTakeOffList.Lock;
  try
    g_DisableTakeOffList.Clear;
    if ListBoxDisableTakeOffList.Items.Count > 0 then begin//20080630
      for I := 0 to ListBoxDisableTakeOffList.Items.Count - 1 do begin
        g_DisableTakeOffList.AddObject(Trim(GetValidStr3(ListBoxDisableTakeOffList.Items.Strings[I], sItemIdx, [' ', '/', ',', #9])), ListBoxDisableTakeOffList.Items.Objects[I]);
      end;
    end;
  finally
    g_DisableTakeOffList.UnLock;
  end;
  SaveDisableTakeOffList();
  uModValue();
end;
procedure TfrmViewList.RefAdminList();
var
  I: Integer;
  AdminInfo: pTAdminInfo;
begin
  ListBoxAdminList.Clear;
  EditAdminName.Text := '';
  EditAdminIPaddr.Text := '';
  EditAdminPremission.Value := 0;
  ButtonAdminListChange.Enabled := False;
  ButtonAdminListDel.Enabled := False;
  UserEngine.m_AdminList.Lock;
  try
    if UserEngine.m_AdminList.Count > 0 then begin//20080630
      for I := 0 to UserEngine.m_AdminList.Count - 1 do begin
        AdminInfo := pTAdminInfo(UserEngine.m_AdminList.Items[I]);
{$IF VEROWNER = WL}
        ListBoxAdminList.Items.Add(AdminInfo.sChrName + ' - ' + IntToStr(AdminInfo.nLv) + ' - ' + AdminInfo.sIPaddr)
{$ELSE}
        ListBoxAdminList.Items.Add(AdminInfo.sChrName + ' - ' + IntToStr(AdminInfo.nLv))
{$IFEND}
      end;
    end;
  finally
    UserEngine.m_AdminList.UnLock;
  end;
end;
procedure TfrmViewList.RefNoClearMonList;
var
  MonInfo: pTMonInfo;
  I: Integer;
begin
  EnterCriticalSection(ProcessHumanCriticalSection);
  try
    if UserEngine.MonsterList.Count > 0 then begin//20080630
      for I := 0 to UserEngine.MonsterList.Count - 1 do begin
        MonInfo := UserEngine.MonsterList.Items[I];
        //ListBoxMonList.Items.AddObject(MonInfo.sName, TObject(MonInfo));
        ListBoxMonList.Items.Add(MonInfo.sName);//20080731 修改
      end;
    end;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;

  g_NoClearMonList.Lock;
  try
    if g_NoClearMonList.Count > 0 then begin//20080630
      for I := 0 to g_NoClearMonList.Count - 1 do begin
        ListBoxNoClearMonList.Items.Add(g_NoClearMonList.Strings[I]);
      end;
    end;
  finally
    g_NoClearMonList.UnLock;
  end;
end;

procedure TfrmViewList.ButtonNoClearMonAddClick(Sender: TObject);
var
  I: Integer;
begin
  if ListBoxMonList.ItemIndex >= 0 then begin
    if ListBoxNoClearMonList.Items.Count > 0 then begin//20080630
      for I := 0 to ListBoxNoClearMonList.Items.Count - 1 do begin
        if ListBoxNoClearMonList.Items.Strings[I] = ListBoxMonList.Items.Strings[ListBoxMonList.ItemIndex] then begin
          Application.MessageBox('此物品已在列表中！！！', '错误信息', MB_OK + MB_ICONERROR);
          Exit;
        end;
      end;
    end;
    ListBoxNoClearMonList.Items.Add(ListBoxMonList.Items.Strings[ListBoxMonList.ItemIndex]);
    ModValue();
  end;
end;

procedure TfrmViewList.ButtonNoClearMonDelClick(Sender: TObject);
begin
  if ListBoxNoClearMonList.ItemIndex >= 0 then begin
    ListBoxNoClearMonList.Items.Delete(ListBoxNoClearMonList.ItemIndex);
    ModValue();
  end;
  if ListBoxNoClearMonList.ItemIndex < 0 then
    ButtonNoClearMonDel.Enabled := False;
end;

procedure TfrmViewList.ButtonNoClearMonAddAllClick(Sender: TObject);
var
  I: Integer;
begin
  ListBoxNoClearMonList.Items.Clear;
  if ListBoxMonList.Items.Count > 0 then begin//20080630
    for I := 0 to ListBoxMonList.Items.Count - 1 do begin
      ListBoxNoClearMonList.Items.Add(ListBoxMonList.Items.Strings[I]);
    end;
  end;
  ModValue();
end;

procedure TfrmViewList.ButtonNoClearMonDelAllClick(Sender: TObject);
begin
  ListBoxNoClearMonList.Items.Clear;
  ButtonNoClearMonDel.Enabled := False;
  ModValue();
end;

procedure TfrmViewList.ButtonNoClearMonSaveClick(Sender: TObject);
var
  I: Integer;
begin
  g_NoClearMonList.Lock;
  try
    g_NoClearMonList.Clear;
    if ListBoxNoClearMonList.Items.Count > 0 then begin//20080630
      for I := 0 to ListBoxNoClearMonList.Items.Count - 1 do begin
        g_NoClearMonList.Add(ListBoxNoClearMonList.Items.Strings[I]);
      end;
    end;
  finally
    g_NoClearMonList.UnLock;
  end;
  SaveNoClearMonList();
  uModValue();
end;

procedure TfrmViewList.ListBoxNoClearMonListClick(Sender: TObject);
begin
  if not boOpened then Exit;
  if ListBoxNoClearMonList.ItemIndex >= 0 then
    ButtonNoClearMonDel.Enabled := True;
end;

procedure TfrmViewList.ListBoxMonListClick(Sender: TObject);
begin
  if not boOpened then Exit;
  if ListBoxMonList.ItemIndex >= 0 then
    ButtonNoClearMonAdd.Enabled := True;
end;

procedure TfrmViewList.ButtonAdminLitsSaveClick(Sender: TObject);
begin
  SaveAdminList();
  ButtonAdminLitsSave.Enabled := False;
end;

procedure TfrmViewList.ButtonAIPickItemAddAllClick(Sender: TObject);
var
  I: Integer;
  str: String;
begin
  ListBoxAllowAIPickUpItem.Items.Clear;
  if ListBoxitemList7.Items.Count > 0 then begin//20080630
    for I := 0 to ListBoxitemList7.Items.Count - 1 do begin
      str:= ListBoxitemList7.Items.Strings[I];
      if GetCheckItemList(17, str) or GetCheckItemList(18, str) then Continue;
      ListBoxAllowAIPickUpItem.Items.Add(str);
    end;
  end;
  ModValue();
end;

procedure TfrmViewList.ButtonAIPickItemAddClick(Sender: TObject);
var
  I: Integer;
  str: String;
begin
  if ListBoxitemList7.ItemIndex >= 0 then begin
    if ListBoxAllowAIPickUpItem.Items.Count > 0 then begin//20080630
      for I := 0 to ListBoxAllowAIPickUpItem.Items.Count - 1 do begin
        if ListBoxAllowAIPickUpItem.Items.Strings[I] = ListBoxitemList7.Items.Strings[ListBoxitemList7.ItemIndex] then begin
          Application.MessageBox('此物品已在列表中！！！', '错误信息', MB_OK + MB_ICONERROR);
          Exit;
        end;
      end;
    end;
    str:= ListBoxitemList7.Items.Strings[ListBoxitemList7.ItemIndex];
    if GetCheckItemList(17, str) or GetCheckItemList(18, str) then begin
      Application.MessageBox('设置的绑定物品不能捡起！', '错误信息', MB_OK + MB_ICONERROR);
      Exit;
    end;
    ListBoxAllowAIPickUpItem.Items.Add(str);
    ModValue();
  end;
end;

procedure TfrmViewList.ButtonAIPickItemDelAllClick(Sender: TObject);
begin
  ListBoxAllowAIPickUpItem.Items.Clear;
  ButtonAIPickItemDelAll.Enabled := False;
  ModValue();
end;

procedure TfrmViewList.ButtonAIPickItemDelClick(Sender: TObject);
begin
  if ListBoxAllowAIPickUpItem.ItemIndex >= 0 then begin
    ListBoxAllowAIPickUpItem.Items.Delete(ListBoxAllowAIPickUpItem.ItemIndex);
    ModValue();
  end;
  if ListBoxAllowAIPickUpItem.ItemIndex < 0 then
    ButtonAIPickItemDel.Enabled := False;
end;

procedure TfrmViewList.ButtonAIPickItemSaveClick(Sender: TObject);
var
  I: Integer;
  sFileName: string;
begin
  sFileName := g_Config.sEnvirDir + 'AllowAIPickUpItemList.txt';
  g_AllowAIPickUpItemList.Lock;
  try
    g_AllowAIPickUpItemList.Clear;
    if ListBoxAllowAIPickUpItem.Items.Count > 0 then begin
      for I := 0 to ListBoxAllowAIPickUpItem.Items.Count - 1 do begin
        g_AllowAIPickUpItemList.Add(Trim(ListBoxAllowAIPickUpItem.Items.Strings[I]));
      end;
    end;
  finally
    g_AllowAIPickUpItemList.UnLock;
  end;
  try
    g_AllowAIPickUpItemList.SaveToFile(sFileName);
  except
  end;
  uModValue();
end;

procedure TfrmViewList.ListBoxAdminListClick(Sender: TObject);
var
  nIndex: Integer;
  AdminInfo: pTAdminInfo;
begin
  nIndex := ListBoxAdminList.ItemIndex;
  UserEngine.m_AdminList.Lock;
  try
    if (nIndex < 0) and (nIndex >= UserEngine.m_AdminList.Count) then Exit;
    ButtonAdminListChange.Enabled := True;
    ButtonAdminListDel.Enabled := True;
    AdminInfo := UserEngine.m_AdminList.Items[nIndex];
    EditAdminName.Text := AdminInfo.sChrName;
    EditAdminIPaddr.Text := AdminInfo.sIPaddr;
    EditAdminPremission.Value := AdminInfo.nLv;
  finally
    UserEngine.m_AdminList.UnLock;
  end;
end;

procedure TfrmViewList.Button1Click(Sender: TObject);
var
  I: Integer;
  str: String;
begin
  if ListBoxitemList9.ItemIndex >= 0 then begin
    if ListBoxAllowShopItem.Items.Count > 0 then begin
      for I := 0 to ListBoxAllowShopItem.Items.Count - 1 do begin
        if ListBoxAllowShopItem.Items.Strings[I] = ListBoxitemList9.Items.Strings[ListBoxitemList9.ItemIndex] then begin
          Application.MessageBox('此物品已在列表中！！！', '错误信息', MB_OK + MB_ICONERROR);
          Exit;
        end;
      end;
    end;
    str:= ListBoxitemList9.Items.Strings[ListBoxitemList9.ItemIndex];
    ListBoxAllowShopItem.Items.Add(str);
    ModValue();
  end;
end;

procedure TfrmViewList.Button2Click(Sender: TObject);
begin
  if ListBoxAllowShopItem.ItemIndex >= 0 then begin
    ListBoxAllowShopItem.Items.Delete(ListBoxAllowShopItem.ItemIndex);
    ModValue();
  end;
  if ListBoxAllowShopItem.ItemIndex < 0 then
    Button2.Enabled := False;
end;

procedure TfrmViewList.Button3Click(Sender: TObject);
var
  I: Integer;
  str: String;
begin
  ListBoxAllowShopItem.Items.Clear;
  if ListBoxitemList9.Items.Count > 0 then begin
    for I := 0 to ListBoxitemList9.Items.Count - 1 do begin
      str:= ListBoxitemList9.Items.Strings[I];
      ListBoxAllowShopItem.Items.Add(str);
    end;
  end;
  ModValue();
end;

procedure TfrmViewList.Button4Click(Sender: TObject);
begin
  ListBoxAllowShopItem.Items.Clear;
  Button4.Enabled := False;
  ModValue();
end;

procedure TfrmViewList.Button5Click(Sender: TObject);
var
  I: Integer;
  sFileName: string;
begin
  sFileName := g_Config.sEnvirDir + 'DisableGamePointShopItemList.txt';
  g_DisableGamePointShopItemList.Lock;
  try
    g_DisableGamePointShopItemList.Clear;
    if ListBoxAllowShopItem.Items.Count > 0 then begin
      for I := 0 to ListBoxAllowShopItem.Items.Count - 1 do begin
        g_DisableGamePointShopItemList.Add(Trim(ListBoxAllowShopItem.Items.Strings[I]));
      end;
    end;
  finally
    g_DisableGamePointShopItemList.UnLock;
  end;
  try
    g_DisableGamePointShopItemList.SaveToFile(sFileName);
  except
  end;
  uModValue();
end;

procedure TfrmViewList.ButtonAdminListAddClick(Sender: TObject);
var
  I: Integer;
  sAdminName: string;
  sAdminIPaddr: string;
  nAdminPerMission: Integer;
  AdminInfo: pTAdminInfo;
begin
  sAdminName := Trim(EditAdminName.Text);
  sAdminIPaddr := Trim(EditAdminIPaddr.Text);
  nAdminPerMission := EditAdminPremission.Value;
  if (nAdminPerMission < 1) or (sAdminName = '') or not (nAdminPerMission in [0..10]) then begin
    Application.MessageBox('输入不正确！！！', '提示信息', MB_OK + MB_ICONERROR);
    EditAdminName.SetFocus;
    Exit;
  end;
{$IF VEROWNER = WL}
  if (sAdminIPaddr = '') then begin
    Application.MessageBox('登录IP输入不正确！！！', '提示信息', MB_OK + MB_ICONERROR);
    EditAdminIPaddr.SetFocus;
    Exit;
  end;
{$IFEND}

  UserEngine.m_AdminList.Lock;
  try
    if UserEngine.m_AdminList.Count > 0 then begin//20080630
      for I := 0 to UserEngine.m_AdminList.Count - 1 do begin
        if CompareText(pTAdminInfo(UserEngine.m_AdminList.Items[I]).sChrName, sAdminName) = 0 then begin
          Application.MessageBox('输入的角色名已经在GM列表中！！！', '提示信息', MB_OK + MB_ICONERROR);
          Exit;
        end;
      end;
    end;
    New(AdminInfo);
    AdminInfo.nLv := nAdminPerMission;
    AdminInfo.sChrName := sAdminName;
    AdminInfo.sIPaddr := sAdminIPaddr;
    UserEngine.m_AdminList.Add(AdminInfo);
  finally
    UserEngine.m_AdminList.UnLock;
  end;
  RefAdminList();
  ButtonAdminLitsSave.Enabled := True;
end;

procedure TfrmViewList.ButtonAdminListChangeClick(Sender: TObject);
var
  nIndex: Integer;
  sAdminName: string;
  sAdminIPaddr: string;
  nAdminPerMission: Integer;
  AdminInfo: pTAdminInfo;
begin
  nIndex := ListBoxAdminList.ItemIndex;
  if nIndex < 0 then Exit;

  sAdminName := Trim(EditAdminName.Text);
  sAdminIPaddr := Trim(EditAdminIPaddr.Text);
  nAdminPerMission := EditAdminPremission.Value;
  if (nAdminPerMission < 1) or (sAdminName = '') or not (nAdminPerMission in [0..10]) then begin
    Application.MessageBox('输入不正确！！！', '提示信息', MB_OK + MB_ICONERROR);
    EditAdminName.SetFocus;
    Exit;
  end;
{$IF VEROWNER = WL}
  if (sAdminIPaddr = '') then begin
    Application.MessageBox('登录IP输入不正确！！！', '提示信息', MB_OK + MB_ICONERROR);
    EditAdminIPaddr.SetFocus;
    Exit;
  end;
{$IFEND}
  UserEngine.m_AdminList.Lock;
  try
    if (nIndex < 0) and (nIndex >= UserEngine.m_AdminList.Count) then Exit;
    AdminInfo := UserEngine.m_AdminList.Items[nIndex];
    AdminInfo.sChrName := sAdminName;
    AdminInfo.nLv := nAdminPerMission;
    AdminInfo.sIPaddr := sAdminIPaddr;
  finally
    UserEngine.m_AdminList.UnLock;
  end;
  RefAdminList();
  ButtonAdminLitsSave.Enabled := True;
end;


procedure TfrmViewList.ButtonAdminListDelClick(Sender: TObject);
var
  nIndex: Integer;
begin
  nIndex := ListBoxAdminList.ItemIndex;
  if nIndex < 0 then Exit;
  UserEngine.m_AdminList.Lock;
  try
    if (nIndex < 0) and (nIndex >= UserEngine.m_AdminList.Count) then Exit;
    Dispose(pTAdminInfo(UserEngine.m_AdminList.Items[nIndex]));
    UserEngine.m_AdminList.Delete(nIndex);
  finally
    UserEngine.m_AdminList.UnLock;
  end;
  RefAdminList();
  ButtonAdminLitsSave.Enabled := True;
end;


procedure TfrmViewList.RefItemBindAccount;
var
  I: Integer;
  ItemBind: pTItemBind;
begin
  GridItemBindAccount.RowCount := 2;
  GridItemBindAccount.Cells[0, 1] := '';
  GridItemBindAccount.Cells[1, 1] := '';
  GridItemBindAccount.Cells[2, 1] := '';
  GridItemBindAccount.Cells[3, 1] := '';
  ButtonItemBindAcountMod.Enabled := False;
  ButtonItemBindAcountDel.Enabled := False;

  g_ItemBindAccount.Lock;
  try
    GridItemBindAccount.RowCount := g_ItemBindAccount.Count + 1;
    if g_ItemBindAccount.Count > 0 then begin//20080630
      for I := 0 to g_ItemBindAccount.Count - 1 do begin
        ItemBind := g_ItemBindAccount.Items[I];
        if ItemBind <> nil then begin
          GridItemBindAccount.Cells[0, I + 1] := UserEngine.GetStdItemName(ItemBind.nItemIdx);
          GridItemBindAccount.Cells[1, I + 1] := IntToStr(ItemBind.nItemIdx);
          GridItemBindAccount.Cells[2, I + 1] := IntToStr(ItemBind.nMakeIdex);
          GridItemBindAccount.Cells[3, I + 1] := ItemBind.sBindName;
        end;
      end;
    end;
  finally
    g_ItemBindAccount.UnLock;
  end;
end;

procedure TfrmViewList.GridItemBindAccountClick(Sender: TObject);
var
  nIndex: Integer;
  ItemBind: pTItemBind;
begin

  nIndex := GridItemBindAccount.Row - 1;
  if nIndex < 0 then Exit;

  g_ItemBindAccount.Lock;
  try
    if nIndex >= g_ItemBindAccount.Count then Exit;
    ItemBind := pTItemBind(g_ItemBindAccount.Items[nIndex]);
    EditItemBindAccountItemName.Text := UserEngine.GetStdItemName(ItemBind.nItemIdx);
    EditItemBindAccountItemIdx.Value := ItemBind.nItemIdx;
    EditItemBindAccountItemMakeIdx.Value := ItemBind.nMakeIdex;
    EditItemBindAccountName.Text := ItemBind.sBindName;
  finally
    g_ItemBindAccount.UnLock;
  end;
  ButtonItemBindAcountDel.Enabled := True;
end;

procedure TfrmViewList.EditItemBindAccountItemIdxChange(Sender: TObject);
begin
  if EditItemBindAccountItemIdx.Text = '' then begin
    EditItemBindAccountItemIdx.Text := '0';
    Exit;
  end;
  EditItemBindAccountItemName.Text := UserEngine.GetStdItemName(EditItemBindAccountItemIdx.Value);
  ButtonItemBindAcountMod.Enabled := True;
end;

procedure TfrmViewList.EditItemBindAccountItemMakeIdxChange(
  Sender: TObject);
begin
  if EditItemBindAccountItemIdx.Text = '' then begin
    EditItemBindAccountItemIdx.Text := '0';
    Exit;
  end;
  ButtonItemBindAcountMod.Enabled := True;
end;


procedure TfrmViewList.EditItemBindAccountNameChange(Sender: TObject);
begin
  ButtonItemBindAcountMod.Enabled := True;
end;

procedure TfrmViewList.ButtonItemBindAcountModClick(Sender: TObject);
var
  nSelIndex: Integer;
  nMakeIdex: Integer;
  nItemIdx: Integer;
  sBindName: string;
  ItemBind: pTItemBind;
begin
  nItemIdx := EditItemBindAccountItemIdx.Value;
  nMakeIdex := EditItemBindAccountItemMakeIdx.Value;
  sBindName := Trim(EditItemBindAccountName.Text);
  nSelIndex := GridItemBindAccount.Row - 1;
  if nSelIndex < 0 then Exit;
  g_ItemBindAccount.Lock;
  try
    if nSelIndex >= g_ItemBindAccount.Count then Exit;
    ItemBind := g_ItemBindAccount.Items[nSelIndex];
    ItemBind.nItemIdx := nItemIdx;
    ItemBind.nMakeIdex := nMakeIdex;
    ItemBind.sBindName := sBindName;
  finally
    g_ItemBindAccount.UnLock;
  end;
  SaveItemBindAccount();
  RefItemBindAccount();

end;


procedure TfrmViewList.ButtonItemBindAcountRefClick(Sender: TObject);
begin
  RefItemBindAccount();
end;


procedure TfrmViewList.ButtonItemBindAcountAddClick(Sender: TObject);
var
  I: Integer;
  nMakeIdex: Integer;
  nItemIdx: Integer;
  sBindName: string;
  ItemBind: pTItemBind;
begin
  nItemIdx := EditItemBindAccountItemIdx.Value;
  nMakeIdex := EditItemBindAccountItemMakeIdx.Value;
  sBindName := Trim(EditItemBindAccountName.Text);

  if (nItemIdx <= 0) or (nMakeIdex < 0) or (sBindName = '') then begin
    Application.MessageBox('输入的信息不正确！！！', '提示信息', MB_OK + MB_ICONERROR);
    Exit;
  end;

  g_ItemBindAccount.Lock;
  try
    if g_ItemBindAccount.Count > 0 then begin//20080630
      for I := 0 to g_ItemBindAccount.Count - 1 do begin
        ItemBind := g_ItemBindAccount.Items[I];
        if (ItemBind.nItemIdx = nItemIdx) and (ItemBind.nMakeIdex = nMakeIdex) then begin
          Application.MessageBox('此物品已经绑定到其他的帐号了！！！', '提示信息', MB_OK + MB_ICONERROR);
          Exit;
        end;
      end;
    end;
    New(ItemBind);
    ItemBind.nItemIdx := nItemIdx;
    ItemBind.nMakeIdex := nMakeIdex;
    ItemBind.sBindName := sBindName;
    g_ItemBindAccount.Insert(0, ItemBind);
  finally
    g_ItemBindAccount.UnLock;
  end;
  SaveItemBindAccount();
  RefItemBindAccount();
end;


procedure TfrmViewList.ButtonItemBindAcountDelClick(Sender: TObject);
var
  ItemBind: pTItemBind;
  nSelIndex: Integer;
begin

  nSelIndex := GridItemBindAccount.Row - 1;
  if nSelIndex < 0 then Exit;
  g_ItemBindAccount.Lock;
  try
    if nSelIndex >= g_ItemBindAccount.Count then Exit;
    ItemBind := g_ItemBindAccount.Items[nSelIndex];
    Dispose(ItemBind);
    g_ItemBindAccount.Delete(nSelIndex);
  finally
    g_ItemBindAccount.UnLock;
  end;
  SaveItemBindAccount();
  RefItemBindAccount();
end;

procedure TfrmViewList.RefItemBindCharName;
var
  I: Integer;
  ItemBind: pTItemBind;
begin
  GridItemBindCharName.RowCount := 2;
  GridItemBindCharName.Cells[0, 1] := '';
  GridItemBindCharName.Cells[1, 1] := '';
  GridItemBindCharName.Cells[2, 1] := '';
  GridItemBindCharName.Cells[3, 1] := '';
  ButtonItemBindCharNameMod.Enabled := False;
  ButtonItemBindCharNameDel.Enabled := False;
  g_ItemBindCharName.Lock;
  try
    GridItemBindCharName.RowCount := g_ItemBindCharName.Count + 1;
    if g_ItemBindCharName.Count > 0 then begin//20080630
      for I := 0 to g_ItemBindCharName.Count - 1 do begin
        ItemBind := g_ItemBindCharName.Items[I];
        if ItemBind <> nil then begin
          GridItemBindCharName.Cells[0, I + 1] := UserEngine.GetStdItemName(ItemBind.nItemIdx);
          GridItemBindCharName.Cells[1, I + 1] := IntToStr(ItemBind.nItemIdx);
          GridItemBindCharName.Cells[2, I + 1] := IntToStr(ItemBind.nMakeIdex);
          GridItemBindCharName.Cells[3, I + 1] := ItemBind.sBindName;
        end;
      end;
    end;
  finally
    g_ItemBindCharName.UnLock;
  end;
end;
//刷新人物装备死亡不爆列表 20081127
procedure TfrmViewList.RefItemBindDieNoDropName;
var
  I: Integer;
  ItemBind: pTItemBind;
begin
  GridITemBindDieName.RowCount := 2;
  GridITemBindDieName.Cells[0, 1] := '';
  GridITemBindDieName.Cells[1, 1] := '';
  GridITemBindDieName.Cells[2, 1] := '';
  ButtonItemBindDieNameMod.Enabled := False;
  ButtonItemBindDieNameDel.Enabled := False;
  g_ItemBindDieNoDropName.Lock;
  try
    GridITemBindDieName.RowCount := g_ItemBindDieNoDropName.Count + 1;
    if g_ItemBindDieNoDropName.Count > 0 then begin
      for I := 0 to g_ItemBindDieNoDropName.Count - 1 do begin
        ItemBind := g_ItemBindDieNoDropName.Items[I];
        if ItemBind <> nil then begin
          GridITemBindDieName.Cells[0, I + 1] := UserEngine.GetStdItemName(ItemBind.nItemIdx);
          GridITemBindDieName.Cells[1, I + 1] := IntToStr(ItemBind.nItemIdx);
          GridITemBindDieName.Cells[2, I + 1] := ItemBind.sBindName;
        end;
      end;
    end;
  finally
    g_ItemBindDieNoDropName.UnLock;
  end;
end;

procedure TfrmViewList.GridItemBindCharNameClick(Sender: TObject);
var
  nIndex: Integer;
  ItemBind: pTItemBind;
begin
  nIndex := GridItemBindCharName.Row - 1;
  if nIndex < 0 then Exit;

  g_ItemBindCharName.Lock;
  try
    if nIndex >= g_ItemBindCharName.Count then Exit;
    ItemBind := pTItemBind(g_ItemBindCharName.Items[nIndex]);
    EditItemBindCharNameItemName.Text := UserEngine.GetStdItemName(ItemBind.nItemIdx);
    EditItemBindCharNameItemIdx.Value := ItemBind.nItemIdx;
    EditItemBindCharNameItemMakeIdx.Value := ItemBind.nMakeIdex;
    EditItemBindCharNameName.Text := ItemBind.sBindName;
  finally
    g_ItemBindCharName.UnLock;
  end;
  ButtonItemBindCharNameDel.Enabled := True;
end;

procedure TfrmViewList.EditItemBindCharNameItemIdxChange(Sender: TObject);
begin
  if EditItemBindCharNameItemIdx.Text = '' then begin
    EditItemBindCharNameItemIdx.Text := '0';
    Exit;
  end;
  EditItemBindCharNameItemName.Text := UserEngine.GetStdItemName(EditItemBindCharNameItemIdx.Value);
  ButtonItemBindCharNameMod.Enabled := True;
end;

procedure TfrmViewList.EditItemBindCharNameItemMakeIdxChange(
  Sender: TObject);
begin
  if EditItemBindCharNameItemMakeIdx.Text = '' then begin
    EditItemBindCharNameItemMakeIdx.Text := '0';
    Exit;
  end;
  ButtonItemBindCharNameMod.Enabled := True;
end;

procedure TfrmViewList.EditItemBindCharNameNameChange(Sender: TObject);
begin
  ButtonItemBindCharNameMod.Enabled := True;
end;

procedure TfrmViewList.ButtonItemBindCharNameAddClick(Sender: TObject);
var
  I: Integer;
  nMakeIdex: Integer;
  nItemIdx: Integer;
  sBindName: string;
  ItemBind: pTItemBind;
begin
  nItemIdx := EditItemBindCharNameItemIdx.Value;
  nMakeIdex := EditItemBindCharNameItemMakeIdx.Value;
  sBindName := Trim(EditItemBindCharNameName.Text);

  if (nItemIdx <= 0) or (nMakeIdex < 0) or (sBindName = '') then begin
    Application.MessageBox('输入的信息不正确！！！', '提示信息', MB_OK + MB_ICONERROR);
    Exit;
  end;

  g_ItemBindCharName.Lock;
  try
    if g_ItemBindCharName.Count > 0 then begin//20080630
      for I := 0 to g_ItemBindCharName.Count - 1 do begin
        ItemBind := g_ItemBindCharName.Items[I];
        if (ItemBind.nItemIdx = nItemIdx) and (ItemBind.nMakeIdex = nMakeIdex) then begin
          Application.MessageBox('此物品已经绑定到其他的角色上了！！！', '提示信息', MB_OK + MB_ICONERROR);
          Exit;
        end;
      end;
    end;
    New(ItemBind);
    ItemBind.nItemIdx := nItemIdx;
    ItemBind.nMakeIdex := nMakeIdex;
    ItemBind.sBindName := sBindName;
    g_ItemBindCharName.Insert(0, ItemBind);
  finally
    g_ItemBindCharName.UnLock;
  end;
  SaveItemBindCharName();
  RefItemBindCharName();
end;

procedure TfrmViewList.ButtonItemBindCharNameModClick(Sender: TObject);
var
  nSelIndex: Integer;
  nMakeIdex: Integer;
  nItemIdx: Integer;
  sBindName: string;
  ItemBind: pTItemBind;
begin

  nItemIdx := EditItemBindCharNameItemIdx.Value;
  nMakeIdex := EditItemBindCharNameItemMakeIdx.Value;
  sBindName := Trim(EditItemBindCharNameName.Text);
  nSelIndex := GridItemBindCharName.Row - 1;
  if nSelIndex < 0 then Exit;

  g_ItemBindCharName.Lock;
  try
    if nSelIndex >= g_ItemBindCharName.Count then Exit;
    ItemBind := g_ItemBindCharName.Items[nSelIndex];
    ItemBind.nItemIdx := nItemIdx;
    ItemBind.nMakeIdex := nMakeIdex;
    ItemBind.sBindName := sBindName;
  finally
    g_ItemBindCharName.UnLock;
  end;

  SaveItemBindCharName();
  RefItemBindCharName();
end;

procedure TfrmViewList.ButtonItemBindCharNameDelClick(Sender: TObject);
var
  ItemBind: pTItemBind;
  nSelIndex: Integer;
begin
  nSelIndex := GridItemBindCharName.Row - 1;
  if nSelIndex < 0 then Exit;
  g_ItemBindCharName.Lock;
  try
    if nSelIndex >= g_ItemBindCharName.Count then Exit;
    ItemBind := g_ItemBindCharName.Items[nSelIndex];
    Dispose(ItemBind);
    g_ItemBindCharName.Delete(nSelIndex);
  finally
    g_ItemBindCharName.UnLock;
  end;
  SaveItemBindCharName();
  RefItemBindCharName();
end;

procedure TfrmViewList.ButtonItemBindCharNameRefClick(Sender: TObject);
begin
  RefItemBindCharName();
end;


procedure TfrmViewList.RefItemBindIPaddr;
var
  I: Integer;
  ItemBind: pTItemBind;
begin
  GridItemBindIPaddr.RowCount := 2;
  GridItemBindIPaddr.Cells[0, 1] := '';
  GridItemBindIPaddr.Cells[1, 1] := '';
  GridItemBindIPaddr.Cells[2, 1] := '';
  GridItemBindIPaddr.Cells[3, 1] := '';
  ButtonItemBindIPaddrMod.Enabled := False;
  ButtonItemBindIPaddrDel.Enabled := False;
  g_ItemBindIPaddr.Lock;
  try
    GridItemBindIPaddr.RowCount := g_ItemBindIPaddr.Count + 1;
    if g_ItemBindIPaddr.Count > 0 then begin//20080630
      for I := 0 to g_ItemBindIPaddr.Count - 1 do begin
        ItemBind := g_ItemBindIPaddr.Items[I];
        if ItemBind <> nil then begin
          GridItemBindIPaddr.Cells[0, I + 1] := UserEngine.GetStdItemName(ItemBind.nItemIdx);
          GridItemBindIPaddr.Cells[1, I + 1] := IntToStr(ItemBind.nItemIdx);
          GridItemBindIPaddr.Cells[2, I + 1] := IntToStr(ItemBind.nMakeIdex);
          GridItemBindIPaddr.Cells[3, I + 1] := ItemBind.sBindName;
        end;
      end;
    end;
  finally
    g_ItemBindIPaddr.UnLock;
  end;
end;
procedure TfrmViewList.GridItemBindIPaddrClick(Sender: TObject);
var
  nIndex: Integer;
  ItemBind: pTItemBind;
begin

  nIndex := GridItemBindIPaddr.Row - 1;
  if nIndex < 0 then Exit;

  g_ItemBindIPaddr.Lock;
  try
    if nIndex >= g_ItemBindIPaddr.Count then Exit;
    ItemBind := pTItemBind(g_ItemBindIPaddr.Items[nIndex]);
    EditItemBindIPaddrItemName.Text := UserEngine.GetStdItemName(ItemBind.nItemIdx);
    EditItemBindIPaddrItemIdx.Value := ItemBind.nItemIdx;
    EditItemBindIPaddrItemMakeIdx.Value := ItemBind.nMakeIdex;
    EditItemBindIPaddrName.Text := ItemBind.sBindName;
  finally
    g_ItemBindIPaddr.UnLock;
  end;
  ButtonItemBindIPaddrDel.Enabled := True;
end;

procedure TfrmViewList.EditItemBindIPaddrItemIdxChange(Sender: TObject);
begin
  if EditItemBindIPaddrItemIdx.Text = '' then begin
    EditItemBindIPaddrItemIdx.Text := '0';
    Exit;
  end;
  EditItemBindIPaddrItemName.Text := UserEngine.GetStdItemName(EditItemBindIPaddrItemIdx.Value);
  ButtonItemBindIPaddrMod.Enabled := True;
end;

procedure TfrmViewList.EditItemBindIPaddrItemMakeIdxChange(
  Sender: TObject);
begin
  if EditItemBindIPaddrItemMakeIdx.Text = '' then begin
    EditItemBindIPaddrItemMakeIdx.Text := '0';
    Exit;
  end;
  ButtonItemBindIPaddrMod.Enabled := True;
end;

procedure TfrmViewList.EditItemBindIPaddrNameChange(Sender: TObject);
begin
  ButtonItemBindIPaddrMod.Enabled := True;
end;

procedure TfrmViewList.ButtonItemBindIPaddrAddClick(Sender: TObject);
var
  I: Integer;
  nMakeIdex: Integer;
  nItemIdx: Integer;
  sBindName: string;
  ItemBind: pTItemBind;
begin
  nItemIdx := EditItemBindIPaddrItemIdx.Value;
  nMakeIdex := EditItemBindIPaddrItemMakeIdx.Value;
  sBindName := Trim(EditItemBindIPaddrName.Text);

  if not IsIPaddr(sBindName) then begin
    Application.MessageBox('IP地址格式输入不正确！！！', '提示信息', MB_OK + MB_ICONERROR);
    EditItemBindIPaddrName.SetFocus;
    Exit;
  end;


  if (nItemIdx <= 0) or (nMakeIdex < 0) then begin
    Application.MessageBox('输入的信息不正确！！！', '提示信息', MB_OK + MB_ICONERROR);
    Exit;
  end;

  g_ItemBindIPaddr.Lock;
  try
    if g_ItemBindIPaddr.Count > 0 then begin//20080630
      for I := 0 to g_ItemBindIPaddr.Count - 1 do begin
        ItemBind := g_ItemBindIPaddr.Items[I];
        if (ItemBind.nItemIdx = nItemIdx) and (ItemBind.nMakeIdex = nMakeIdex) then begin
          Application.MessageBox('此物品已经绑定到其他的IP地址上了！！！', '提示信息', MB_OK + MB_ICONERROR);
          Exit;
        end;
      end;
    end;
    New(ItemBind);
    ItemBind.nItemIdx := nItemIdx;
    ItemBind.nMakeIdex := nMakeIdex;
    ItemBind.sBindName := sBindName;
    g_ItemBindIPaddr.Insert(0, ItemBind);
  finally
    g_ItemBindIPaddr.UnLock;
  end;
  SaveItemBindIPaddr();
  RefItemBindIPaddr();
end;

procedure TfrmViewList.ButtonItemBindIPaddrModClick(Sender: TObject);
var
  nSelIndex: Integer;
  nMakeIdex: Integer;
  nItemIdx: Integer;
  sBindName: string;
  ItemBind: pTItemBind;
begin

  nItemIdx := EditItemBindIPaddrItemIdx.Value;
  nMakeIdex := EditItemBindIPaddrItemMakeIdx.Value;
  sBindName := Trim(EditItemBindIPaddrName.Text);
  if not IsIPaddr(sBindName) then begin
    Application.MessageBox('IP地址格式输入不正确！！！', '提示信息', MB_OK + MB_ICONERROR);
    EditItemBindIPaddrName.SetFocus;
    Exit;
  end;
  nSelIndex := GridItemBindIPaddr.Row - 1;
  if nSelIndex < 0 then Exit;

  g_ItemBindIPaddr.Lock;
  try
    if nSelIndex >= g_ItemBindIPaddr.Count then Exit;
    ItemBind := g_ItemBindIPaddr.Items[nSelIndex];
    ItemBind.nItemIdx := nItemIdx;
    ItemBind.nMakeIdex := nMakeIdex;
    ItemBind.sBindName := sBindName;
  finally
    g_ItemBindIPaddr.UnLock;
  end;
  SaveItemBindIPaddr();
  RefItemBindIPaddr();
end;

procedure TfrmViewList.ButtonItemBindIPaddrDelClick(Sender: TObject);
var
  ItemBind: pTItemBind;
  nSelIndex: Integer;
begin

  nSelIndex := GridItemBindIPaddr.Row - 1;
  if nSelIndex < 0 then Exit;
  g_ItemBindIPaddr.Lock;
  try
    if nSelIndex >= g_ItemBindIPaddr.Count then Exit;
    ItemBind := g_ItemBindIPaddr.Items[nSelIndex];
    Dispose(ItemBind);
    g_ItemBindIPaddr.Delete(nSelIndex);
  finally
    g_ItemBindIPaddr.UnLock;
  end;
  SaveItemBindIPaddr();
  RefItemBindIPaddr();
end;

procedure TfrmViewList.ButtonItemBindIPaddrRefClick(Sender: TObject);
begin
  RefItemBindIPaddr();
end;

procedure TfrmViewList.RefItemCustomNameList;
var
  I: Integer;
  ItemName: pTItemName;
begin
  //  GridItemNameList.RowCount:=2;
  GridItemNameList.Cells[0, 1] := '';
  GridItemNameList.Cells[1, 1] := '';
  GridItemNameList.Cells[2, 1] := '';

  ButtonItemNameMod.Enabled := False;
  ButtonItemNameDel.Enabled := False;
  ItemUnit.m_ItemNameList.Lock;
  try
    GridItemNameList.RowCount := ItemUnit.m_ItemNameList.Count + 1;
    if ItemUnit.m_ItemNameList.Count > 0 then begin//20080630
      for I := 0 to ItemUnit.m_ItemNameList.Count - 1 do begin
        ItemName := ItemUnit.m_ItemNameList.Items[I];
        if ItemName <> nil then begin
          GridItemNameList.Cells[0, I + 1] := UserEngine.GetStdItemName(ItemName.nItemIndex);
          GridItemNameList.Cells[1, I + 1] := IntToStr(ItemName.nMakeIndex);
          GridItemNameList.Cells[2, I + 1] := ItemName.sItemName;
        end;
      end;
    end;
  finally
    ItemUnit.m_ItemNameList.UnLock;
  end;
end;

procedure TfrmViewList.GridItemNameListClick(Sender: TObject);
var
  nIndex: Integer;
  ItemName: pTItemName;
begin

  nIndex := GridItemNameList.Row - 1;
  if nIndex < 0 then Exit;

  ItemUnit.m_ItemNameList.Lock;
  try
    if nIndex >= ItemUnit.m_ItemNameList.Count then Exit;
    ItemName := pTItemName(ItemUnit.m_ItemNameList.Items[nIndex]);
    EditItemNameOldName.Text := UserEngine.GetStdItemName(ItemName.nItemIndex);
    EditItemNameIdx.Value := ItemName.nItemIndex;
    EditItemNameMakeIndex.Value := ItemName.nMakeIndex;
    EditItemNameNewName.Text := ItemName.sItemName;
  finally
    ItemUnit.m_ItemNameList.UnLock;
  end;
  ButtonItemNameDel.Enabled := True;
end;

procedure TfrmViewList.EditItemNameIdxChange(Sender: TObject);
begin
  EditItemNameOldName.Text := UserEngine.GetStdItemName(EditItemNameIdx.Value);
  ButtonItemNameMod.Enabled := True;
end;

procedure TfrmViewList.EditItemNameMakeIndexChange(Sender: TObject);
begin
  ButtonItemNameMod.Enabled := True;
end;

procedure TfrmViewList.EditItemNameNewNameChange(Sender: TObject);
begin
  ButtonItemNameMod.Enabled := True;
end;

procedure TfrmViewList.ButtonItemNameAddClick(Sender: TObject);
var
  I: Integer;
  nMakeIdex: Integer;
  nItemIdx: Integer;
  sNewName: string;
  ItemName: pTItemName;
begin
  nItemIdx := EditItemNameIdx.Value;
  nMakeIdex := EditItemNameMakeIndex.Value;
  sNewName := Trim(EditItemNameNewName.Text);

  if (nItemIdx <= 0) or (nMakeIdex < 0) or (sNewName = '') then begin
    Application.MessageBox('输入的信息不正确！！！', '提示信息', MB_OK + MB_ICONERROR);
    Exit;
  end;

  ItemUnit.m_ItemNameList.Lock;
  try
    if ItemUnit.m_ItemNameList.Count > 0 then begin//20080630
      for I := 0 to ItemUnit.m_ItemNameList.Count - 1 do begin
        ItemName := ItemUnit.m_ItemNameList.Items[I];
        if (ItemName.nItemIndex = nItemIdx) and (ItemName.nMakeIndex = nMakeIdex) then begin
          Application.MessageBox('此物品已经自定义过名称了！！！', '提示信息', MB_OK + MB_ICONERROR);
          Exit;
        end;
      end;
    end;
    New(ItemName);
    ItemName.nItemIndex := nItemIdx;
    ItemName.nMakeIndex := nMakeIdex;
    ItemName.sItemName := sNewName;
    ItemUnit.m_ItemNameList.Insert(0, ItemName);
  finally
    ItemUnit.m_ItemNameList.UnLock;
  end;
  ItemUnit.SaveCustomItemName();
  RefItemCustomNameList();
end;

procedure TfrmViewList.ButtonItemNameModClick(Sender: TObject);
var
  nSelIndex: Integer;
  nMakeIdex: Integer;
  nItemIdx: Integer;
  sNewName: string;
  ItemName: pTItemName;
begin
  nItemIdx := EditItemNameIdx.Value;
  nMakeIdex := EditItemNameMakeIndex.Value;
  sNewName := Trim(EditItemNameNewName.Text);
  nSelIndex := GridItemNameList.Row - 1;
  if nSelIndex < 0 then Exit;
  ItemUnit.m_ItemNameList.Lock;
  try
    if nSelIndex >= ItemUnit.m_ItemNameList.Count then Exit;
    ItemName := ItemUnit.m_ItemNameList.Items[nSelIndex];
    ItemName.nItemIndex := nItemIdx;
    ItemName.nMakeIndex := nMakeIdex;
    ItemName.sItemName := sNewName;
  finally
    ItemUnit.m_ItemNameList.UnLock;
  end;
  ItemUnit.SaveCustomItemName();
  RefItemCustomNameList();
end;

procedure TfrmViewList.ButtonItemNameDelClick(Sender: TObject);
var
  ItemName: pTItemName;
  nSelIndex: Integer;
begin

  nSelIndex := GridItemNameList.Row - 1;
  if nSelIndex < 0 then Exit;
  ItemUnit.m_ItemNameList.Lock;
  try
    if nSelIndex >= ItemUnit.m_ItemNameList.Count then Exit;
    ItemName := ItemUnit.m_ItemNameList.Items[nSelIndex];
    Dispose(ItemName);
    ItemUnit.m_ItemNameList.Delete(nSelIndex);
  finally
    ItemUnit.m_ItemNameList.UnLock;
  end;
  ItemUnit.SaveCustomItemName();
  RefItemCustomNameList();
end;


procedure TfrmViewList.ButtonItemNameRefClick(Sender: TObject);
begin
  RefItemCustomNameList();
end;

procedure TfrmViewList.ButtonLimitItemListAddClick(Sender: TObject);
var
  n10: Integer;
  sItmeName: String;
begin
  if Edit2.text <> '' then begin
    if CanLimitItem(Edit2.text) then begin
      Application.MessageBox('此物品已在列表中！', '错误信息', MB_OK + MB_ICONERROR);
      Exit;
    end;
    if GetCheckItemList(16, Edit2.text) then begin
      Application.MessageBox('此物品已设置为24时消失物品，不能再设置限时物品！', '错误信息', MB_OK + MB_ICONERROR);
      Exit;
    end;
    if GetCheckItemList(17, Edit2.text) then begin
      Application.MessageBox('此物品已设置为永久绑定物品，不能再设置限时物品！', '错误信息', MB_OK + MB_ICONERROR);
      Exit;
    end;
    if GetCheckItemList(18, Edit2.text) then begin
      Application.MessageBox('此物品已设置为绑定48时物品，不能再设置限时物品！', '错误信息', MB_OK + MB_ICONERROR);
      Exit;
    end;
    sItmeName:= Edit2.text;
    n10:= SpinEdit2.Value;
    g_LimitItemList.Lock;
    try
      g_LimitItemList.AddObject(sItmeName, TObject(n10));
    finally
      g_LimitItemList.UnLock;
    end;
    ListBoxLimitItemList.Items.Add(sItmeName+'-'+inttostr(n10));
    Edit2.text:='';
    ModValue();
  end;
end;

procedure TfrmViewList.ButtonLimitItemListDeleteClick(Sender: TObject);
begin
  if ListBoxLimitItemList.ItemIndex >= 0 then begin
    g_LimitItemList.Lock;
    try
      g_LimitItemList.Delete(ListBoxLimitItemList.ItemIndex);
    finally
      g_LimitItemList.UnLock;
    end;
    ListBoxLimitItemList.Items.Delete(ListBoxLimitItemList.ItemIndex);
    ModValue();
  end;
  if ListBoxLimitItemList.ItemIndex < 0 then ButtonLimitItemListDelete.Enabled := False;
end;

procedure TfrmViewList.ButtonLimitItemListSaveClick(Sender: TObject);
begin
  SaveLimitItemList();
  uModValue();
end;

procedure TfrmViewList.ListBoxitemList4Click(Sender: TObject);
begin
  if not boOpened then Exit;
  if ListBoxitemList4.ItemIndex >= 0 then
    ButtonSellOffAdd.Enabled := True;
end;

procedure TfrmViewList.ButtonSellOffDelClick(Sender: TObject);
begin
  if ListBoxSellOffList.ItemIndex >= 0 then begin
    ListBoxSellOffList.Items.Delete(ListBoxSellOffList.ItemIndex);
    ModValue();
  end;
  if ListBoxSellOffList.ItemIndex < 0 then
    ButtonSellOffDel.Enabled := False;
end;

procedure TfrmViewList.ListBoxSellOffListClick(Sender: TObject);
begin
  if not boOpened then Exit;
  if ListBoxSellOffList.ItemIndex >= 0 then
    ButtonSellOffDel.Enabled := True;
end;

procedure TfrmViewList.ButtonSellOffAddAllClick(Sender: TObject);
var
  I: Integer;
begin
  ListBoxSellOffList.Items.Clear;
  if ListBoxitemList4.Items.Count > 0 then begin//20080630
    for I := 0 to ListBoxitemList4.Items.Count - 1 do begin
      ListBoxSellOffList.Items.Add(ListBoxitemList4.Items.Strings[I]);
    end;
  end;
  ModValue();
end;

procedure TfrmViewList.ButtonSellOffDelAllClick(Sender: TObject);
begin
  ListBoxSellOffList.Items.Clear;
  ButtonSellOffDelAll.Enabled := False;
  ModValue();
end;

procedure TfrmViewList.ButtonSellOffSaveClick(Sender: TObject);
//var
//  I: Integer;
//  sItemIdx: string;
begin
{  g_AllowSellOffItemList.Lock; //20080416 去掉拍卖功能
  try
    g_AllowSellOffItemList.Clear;
    for I := 0 to ListBoxSellOffList.Items.Count - 1 do begin
      g_AllowSellOffItemList.Add(Trim(ListBoxSellOffList.Items.Strings[I]));
    end;
  finally
    g_AllowSellOffItemList.UnLock;
  end;
  SaveAllowSellOffItemList();
  uModValue(); }
end;

procedure TfrmViewList.ButtonSellOffAddClick(Sender: TObject);
var
  I: Integer;
begin
  if ListBoxitemList4.ItemIndex >= 0 then begin
    if ListBoxSellOffList.Items.Count > 0 then begin//20080630
      for I := 0 to ListBoxSellOffList.Items.Count - 1 do begin
        if ListBoxSellOffList.Items.Strings[I] = ListBoxitemList4.Items.Strings[ListBoxitemList4.ItemIndex] then begin
          Application.MessageBox('此物品已在列表中！！！', '错误信息', MB_OK + MB_ICONERROR);
          Exit;
        end;
      end;
    end;
    ListBoxSellOffList.Items.Add(ListBoxitemList4.Items.Strings[ListBoxitemList4.ItemIndex]);
    ModValue();
  end;
end;

procedure TfrmViewList.ListBoxAllowAIPickUpItemClick(Sender: TObject);
begin
  if not boOpened then Exit;
  if ListBoxAllowAIPickUpItem.ItemIndex >= 0 then
    ButtonAIPickItemDel.Enabled := True;
end;

procedure TfrmViewList.ListBoxAllowPickUpItemClick(Sender: TObject);
begin
  if not boOpened then Exit;
  if ListBoxAllowPickUpItem.ItemIndex >= 0 then
    ButtonPickItemDel.Enabled := True;
end;

procedure TfrmViewList.ListBoxAllowShopItemClick(Sender: TObject);
begin
  if not boOpened then Exit;
  if ListBoxAllowShopItem.ItemIndex >= 0 then
    Button2.Enabled := True;
end;

procedure TfrmViewList.ListBoxArmsExchangeListClick(Sender: TObject);
begin
  if not boOpened then Exit;
  if ListBoxArmsExchangeList.ItemIndex >= 0 then
    ButtonEnableArmsExchangeDelete.Enabled := True;
end;

procedure TfrmViewList.ListBoxitemList5Click(Sender: TObject);
begin
  if not boOpened then Exit;
  if ListBoxitemList5.ItemIndex >= 0 then
    ButtonPickItemAdd.Enabled := True;
end;

procedure TfrmViewList.ButtonPickItemAddAllClick(Sender: TObject);
var
  I: Integer;
  str:string;
begin
  ListBoxAllowPickUpItem.Items.Clear;
  if ListBoxitemList5.Items.Count > 0 then begin//20080630
    for I := 0 to ListBoxitemList5.Items.Count - 1 do begin
      str:= ListBoxitemList5.Items.Strings[I];
      if GetCheckItemList(17, str) or GetCheckItemList(18, str) then Continue;
      ListBoxAllowPickUpItem.Items.Add(str);
    end;
  end;
  ModValue();
end;

procedure TfrmViewList.ButtonPickItemDelAllClick(Sender: TObject);
begin
  ListBoxAllowPickUpItem.Items.Clear;
  ButtonPickItemDelAll.Enabled := False;
  ModValue();
end;

procedure TfrmViewList.ButtonPickItemSaveClick(Sender: TObject);
var
  I: Integer;
  sFileName: string;
begin
  sFileName := g_Config.sEnvirDir + 'AllowPickUpItemList.txt';
  g_AllowPickUpItemList.Lock;
  try
    g_AllowPickUpItemList.Clear;
    if ListBoxAllowPickUpItem.Items.Count > 0 then begin
      for I := 0 to ListBoxAllowPickUpItem.Items.Count - 1 do begin
        g_AllowPickUpItemList.Add(Trim(ListBoxAllowPickUpItem.Items.Strings[I]));
      end;
    end;
  finally
    g_AllowPickUpItemList.UnLock;
  end;
  try
    g_AllowPickUpItemList.SaveToFile(sFileName);
  except
  end;
  uModValue();
end;

procedure TfrmViewList.ButtonPickItemAddClick(Sender: TObject);
var
  I: Integer;
  str: String;
begin
  if ListBoxitemList5.ItemIndex >= 0 then begin
    if ListBoxAllowPickUpItem.Items.Count > 0 then begin//20080630
      for I := 0 to ListBoxAllowPickUpItem.Items.Count - 1 do begin
        if ListBoxAllowPickUpItem.Items.Strings[I] = ListBoxitemList5.Items.Strings[ListBoxitemList5.ItemIndex] then begin
          Application.MessageBox('此物品已在列表中！！！', '错误信息', MB_OK + MB_ICONERROR);
          Exit;
        end;
      end;
    end;
    str:= ListBoxitemList5.Items.Strings[ListBoxitemList5.ItemIndex];
    if GetCheckItemList(17, str) or GetCheckItemList(18, str) then begin
      Application.MessageBox('设置的绑定物品不能捡起！', '错误信息', MB_OK + MB_ICONERROR);
      Exit;
    end;
    ListBoxAllowPickUpItem.Items.Add(str);
    ModValue();
  end;
end;

procedure TfrmViewList.ButtonPickItemDelClick(Sender: TObject);
begin
  if ListBoxAllowPickUpItem.ItemIndex >= 0 then begin
    ListBoxAllowPickUpItem.Items.Delete(ListBoxAllowPickUpItem.ItemIndex);
    ModValue();
  end;
  if ListBoxAllowPickUpItem.ItemIndex < 0 then
    ButtonPickItemDel.Enabled := False;
end;
{20071112 增加 begin}
procedure TfrmViewList.ListBoxDisableSendMsgClick(Sender: TObject);
begin
  if not boOpened then Exit;
  if ListBoxDisableSendMsg.ItemIndex >= 0 then
    ListBoxDisableSendMsgDelete.Enabled := True;
end;

procedure TfrmViewList.ListBoxDisableSendMsgAddClick(Sender: TObject);
var
  I: Integer;
  K: Integer;
  sFileName: string;
begin
  if ListBoxDisableSendMsg.Items.Count > 0 then begin//20080630
    K:= ListBoxDisableSendMsg.Items.IndexOf(Trim(DisableSendMsg_Edt.text));
    if K > -1 then begin
      Application.MessageBox('此角色名称已在列表中！！！', '错误信息', MB_OK + MB_ICONERROR);
      Exit;
    end;
  end;
  ListBoxDisableSendMsg.Items.Add(Trim(DisableSendMsg_Edt.text));

//保存增加的信息到文件里
  sFileName := g_Config.sEnvirDir + 'DisableSendMsgList.txt';
  g_DisableSendMsgList.Lock;
  try
    g_DisableSendMsgList.Clear;
    if ListBoxDisableSendMsg.Items.Count > 0 then begin//20080630
      for I := 0 to ListBoxDisableSendMsg.Items.Count - 1 do begin
        g_DisableSendMsgList.Add(Trim(ListBoxDisableSendMsg.Items.Strings[I]));
      end;
    end;
  finally
    g_DisableSendMsgList.UnLock;
  end;
  try
    g_DisableSendMsgList.SaveToFile(sFileName);
  except
  end;
  ListBoxDisableSendMsgAdd.Enabled:=False;
end;

procedure TfrmViewList.DisableSendMsg_EdtChange(Sender: TObject);
begin
  ListBoxDisableSendMsgAdd.Enabled:=True;
end;

procedure TfrmViewList.ListBoxDisableSendMsgDeleteClick(Sender: TObject);
var
  I: Integer;
  sFileName: string;
begin
  if ListBoxDisableSendMsg.ItemIndex >= 0 then 
    ListBoxDisableSendMsg.Items.Delete(ListBoxDisableSendMsg.ItemIndex);

//保存删除的信息到文件里
  sFileName := g_Config.sEnvirDir + 'DisableSendMsgList.txt';
  g_DisableSendMsgList.Lock;
  try
    g_DisableSendMsgList.Clear;
    if ListBoxDisableSendMsg.Items.Count > 0 then begin//20080630
      for I := 0 to ListBoxDisableSendMsg.Items.Count - 1 do begin
        g_DisableSendMsgList.Add(Trim(ListBoxDisableSendMsg.Items.Strings[I]));
      end;
    end;
  finally
    g_DisableSendMsgList.UnLock;
  end;
  try
    g_DisableSendMsgList.SaveToFile(sFileName);
  except
  end;
end;
{20071112 增加 end}

procedure TfrmViewList.EditItemBindDieNameItemIdxChange(Sender: TObject);
begin
  if EditItemBindDieNameItemIdx.Text = '' then begin
    EditItemBindDieNameItemIdx.Text := '0';
    Exit;
  end;
  EditItemBindDieNameItemName.Text := UserEngine.GetStdItemName(EditItemBindDieNameItemIdx.Value);
  ButtonItemBindDieNameMod.Enabled := True;
end;

procedure TfrmViewList.GridITemBindDieNameClick(Sender: TObject);
var
  nIndex: Integer;
  ItemBind: pTItemBind;
begin
  nIndex := GridITemBindDieName.Row - 1;
  if nIndex < 0 then Exit;

  g_ItemBindDieNoDropName.Lock;
  try
    if nIndex >= g_ItemBindDieNoDropName.Count then Exit;
    ItemBind := pTItemBind(g_ItemBindDieNoDropName.Items[nIndex]);
    EditItemBindDieNameItemName.Text := UserEngine.GetStdItemName(ItemBind.nItemIdx);
    EditItemBindDieNameItemIdx.Value := ItemBind.nItemIdx;
    EditItemBindDieNameName.Text := ItemBind.sBindName;
  finally
    g_ItemBindDieNoDropName.UnLock;
  end;
  ButtonItemBindDieNameDel.Enabled := True;
end;

procedure TfrmViewList.ButtonItemBindDieNameModClick(Sender: TObject);
var
  nSelIndex: Integer;
  nItemIdx: Integer;
  sBindName: string;
  ItemBind: pTItemBind;
begin
  nItemIdx := EditItemBindDieNameItemIdx.Value;
  sBindName := Trim(EditItemBindDieNameName.Text);
  nSelIndex := GridITemBindDieName.Row - 1;
  if nSelIndex < 0 then Exit;

  g_ItemBindDieNoDropName.Lock;
  try
    if nSelIndex >= g_ItemBindDieNoDropName.Count then Exit;
    ItemBind := g_ItemBindDieNoDropName.Items[nSelIndex];
    ItemBind.nItemIdx := nItemIdx;
    ItemBind.sBindName := sBindName;
  finally
    g_ItemBindDieNoDropName.UnLock;
  end;

  SaveItemBindDieNoDropName();//保存人物装备死亡不爆列表 20081127
  RefItemBindDieNoDropName();
end;

procedure TfrmViewList.ButtonItemBindDieNameDelClick(Sender: TObject);
var
  ItemBind: pTItemBind;
  nSelIndex: Integer;
begin
  nSelIndex := GridITemBindDieName.Row - 1;
  if nSelIndex < 0 then Exit;
  g_ItemBindDieNoDropName.Lock;
  try
    if nSelIndex >= g_ItemBindDieNoDropName.Count then Exit;
    ItemBind := g_ItemBindDieNoDropName.Items[nSelIndex];
    Dispose(ItemBind);
    g_ItemBindDieNoDropName.Delete(nSelIndex);
  finally
    g_ItemBindDieNoDropName.UnLock;
  end;
  SaveItemBindDieNoDropName();//保存人物装备死亡不爆列表 20081127
  RefItemBindDieNoDropName();
end;

procedure TfrmViewList.ButtonItemBindDieNameAddClick(Sender: TObject);
var
  I: Integer;
  nItemIdx: Integer;
  sBindName: string;
  ItemBind: pTItemBind;
begin
  nItemIdx := EditItemBindDieNameItemIdx.Value;
  sBindName := Trim(EditItemBindDieNameName.Text);

  if (nItemIdx <= 0) or (sBindName = '') then begin
    Application.MessageBox('输入的信息不正确！！！', '提示信息', MB_OK + MB_ICONERROR);
    Exit;
  end;

  g_ItemBindDieNoDropName.Lock;
  try
    if g_ItemBindDieNoDropName.Count > 0 then begin
      for I := 0 to g_ItemBindDieNoDropName.Count - 1 do begin
        ItemBind := g_ItemBindDieNoDropName.Items[I];
        if (ItemBind.nItemIdx = nItemIdx) and (ItemBind.sBindName = sBindName) then begin
          Application.MessageBox('此物品已经绑定到角色上了,不能重复绑定！！！', '提示信息', MB_OK + MB_ICONERROR);
          Exit;
        end;
      end;
    end;
    New(ItemBind);
    ItemBind.nItemIdx := nItemIdx;
    ItemBind.nMakeIdex := 0;
    ItemBind.sBindName := sBindName;
    g_ItemBindDieNoDropName.Insert(0, ItemBind);
  finally
    g_ItemBindDieNoDropName.UnLock;
  end;
  SaveItemBindDieNoDropName();//保存人物装备死亡不爆列表 20081127
  RefItemBindDieNoDropName();
end;

procedure TfrmViewList.ButtonItemBindDieNameRefClick(Sender: TObject);
begin
  RefItemBindDieNoDropName();
end;

procedure TfrmViewList.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmViewList.FormDestroy(Sender: TObject);
begin
  frmViewList:= nil;
end;

procedure TfrmViewList.ButtonMonDropLimitClearClick(Sender: TObject);
var
  I: Integer;
  MonDrop: pTMonDrop;
begin
  g_MonDropLimitLIst.Lock;
  try
    if g_MonDropLimitLIst.Count > 0 then begin
      for I := 0 to g_MonDropLimitLIst.Count - 1 do begin
        MonDrop := pTMonDrop(g_MonDropLimitLIst.Objects[I]);
        if MonDrop <> nil then begin
          MonDrop.nDropCount := 0;
          MonDrop.nNoDropCount := 0;
        end;
      end;
    end;
  finally
    g_MonDropLimitLIst.UnLock;
  end;
  SaveMonDropLimitList();
  RefMonDropLimit();
end;

end.
