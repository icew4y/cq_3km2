unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Login,   ComCtrls,Printers,
  Grids, DBGrids, StdCtrls,  ExtCtrls, DBCtrls,
  bsSkinData, BusinessSkinForm, bsSkinTabs, bsSkinGrids, bsDBGrids,
  bsSkinCtrls, bsSkinBoxCtrls, bsdbctrls, Mask, DBTables, DB, bsMessages,DM,Inifiles,
  RzLabel, DBGridEh, Buttons, bsSkinShellCtrls, Menus, bsSkinMenus,
  RzPrgres, RzEdit, PrnDbgeh,  bsColorCtrls, FFPBox,mywil, bsDialogs,ADODB,
  GridsEh;

type
  TFrmMain = class(TForm)
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    bsSkinData1: TbsSkinData;
    bsCompressedStoredSkin1: TbsCompressedStoredSkin;
    bsSkinMessage1: TbsSkinMessage;
    OpenDialog1: TbsSkinOpenDialog;
    SaveDialog1: TbsSkinSaveDialog;
    bsSkinPopupMenu3: TbsSkinPopupMenu;
    N5: TMenuItem;
    PrintDBGridEh1: TPrintDBGridEh;
    bsSkinPanel17: TbsSkinPanel;
    bsSkinStdLabel7: TbsSkinStdLabel;
    LabelProductName: TbsSkinStdLabel;
    bsSkinLinkLabel1: TbsSkinLinkLabel;
    bsSkinButtonLabel1: TbsSkinButtonLabel;
    bsSkinStdLabel17: TbsSkinStdLabel;
    LabelVersion: TbsSkinStdLabel;
    bsSkinPageControl1: TbsSkinPageControl;
    bsSkinTabSheet1: TbsSkinTabSheet;
    bsSkinPageControl2: TbsSkinPageControl;
    bsSkinTabSheet4: TbsSkinTabSheet;
    bsSkinSplitter1: TbsSkinSplitter;
    bsSkinPanel1: TbsSkinPanel;
    bsSkinStdLabel1: TbsSkinStdLabel;
    bsSkinStdLabel2: TbsSkinStdLabel;
    BtnMagicBaseBak: TbsSkinButton;
    BtnMagicBaseRestore: TbsSkinButton;
    bsSkinCheckRadioBox1: TbsSkinCheckRadioBox;
    bsSkinCheckRadioBox2: TbsSkinCheckRadioBox;
    bsSkinCheckRadioBox3: TbsSkinCheckRadioBox;
    EditMagName: TbsSkinEdit;
    bsSkinSpinEdit1: TbsSkinSpinEdit;
    BtnFindMagName: TbsSkinButton;
    BtnAlterMagicExp: TbsSkinButton;
    bsSkinButton12: TbsSkinButton;
    bsSkinButton15: TbsSkinButton;
    bsSkinDBNavigator1: TbsSkinDBNavigator;
    bsSkinExPanel1: TbsSkinExPanel;
    bsSkinMemo1: TbsSkinMemo;
    bsSkinPanel2: TbsSkinPanel;
    MagicDBGrid: TDBGridEh;
    bsSkinTabSheet5: TbsSkinTabSheet;
    bsSkinSplitter2: TbsSkinSplitter;
    bsSkinPanel3: TbsSkinPanel;
    bsSkinStdLabel3: TbsSkinStdLabel;
    BtnMobBaseBak: TbsSkinButton;
    BtnMobBaseRestore: TbsSkinButton;
    EditMobName: TbsSkinEdit;
    BtnFindMonName: TbsSkinButton;
    bsSkinButton11: TbsSkinButton;
    bsSkinButton14: TbsSkinButton;
    bsSkinDBNavigator2: TbsSkinDBNavigator;
    bsSkinExPanel2: TbsSkinExPanel;
    bsSkinMemo2: TbsSkinMemo;
    bsSkinPanel4: TbsSkinPanel;
    MobDBGrid: TDBGridEh;
    bsSkinTabSheet6: TbsSkinTabSheet;
    bsSkinSplitter3: TbsSkinSplitter;
    bsSkinPanel5: TbsSkinPanel;
    bsSkinStdLabel5: TbsSkinStdLabel;
    BtnItemsBaseBak: TbsSkinButton;
    BtnItemsBaseRestore: TbsSkinButton;
    BtnFindItemName: TbsSkinButton;
    EditItemsName: TbsSkinEdit;
    bsSkinGroupBox1: TbsSkinGroupBox;
    bsSkinStdLabel4: TbsSkinStdLabel;
    ComboBoxFilterItemsMode: TbsSkinComboBox;
    bsSkinButton7: TbsSkinButton;
    bsSkinButton13: TbsSkinButton;
    bsSkinDBNavigator3: TbsSkinDBNavigator;
    bsSkinExPanel3: TbsSkinExPanel;
    bsSkinSplitter4: TbsSkinSplitter;
    MemoItemsHint: TbsSkinMemo;
    ListBoxItemsHint: TbsSkinListBox;
    bsSkinScrollBar4: TbsSkinScrollBar;
    bsSkinPanel6: TbsSkinPanel;
    bsSkinScrollBar5: TbsSkinScrollBar;
    ItemsDBGrid: TDBGridEh;
    bsSkinTabSheet2: TbsSkinTabSheet;
    bsSkinGroupBox2: TbsSkinGroupBox;
    RzLabel1: TRzLabel;
    bsSkinPanel7: TbsSkinPanel;
    TrackEditColor1: TbsSkinTrackEdit;
    TrackEditColor2: TbsSkinTrackEdit;
    bsSkinTabSheet3: TbsSkinTabSheet;
    bsSkinPanel8: TbsSkinPanel;
    bsSkinSplitter5: TbsSkinSplitter;
    bsSkinPanel9: TbsSkinPanel;
    bsSkinGroupBox3: TbsSkinGroupBox;
    bsSkinGroupBox4: TbsSkinGroupBox;
    checkboxTransparent: TbsSkinCheckRadioBox;
    CheckBoxjump: TbsSkinCheckRadioBox;
    CheckBoxzuobiao: TbsSkinCheckRadioBox;
    checkboxXY: TbsSkinCheckRadioBox;
    Rb50: TbsSkinCheckRadioBox;
    rb100: TbsSkinCheckRadioBox;
    rb200: TbsSkinCheckRadioBox;
    rb400: TbsSkinCheckRadioBox;
    rb800: TbsSkinCheckRadioBox;
    rbauto: TbsSkinCheckRadioBox;
    btnx: TbsSkinButton;
    btny: TbsSkinButton;
    bsSkinPanel10: TbsSkinPanel;
    bsSkinStdLabel6: TbsSkinStdLabel;
    Label3: TbsSkinStdLabel;
    Label2: TbsSkinStdLabel;
    Label7: TbsSkinStdLabel;
    btnup: TbsSkinButton;
    btndelete: TbsSkinButton;
    BtnAutoPlay: TbsSkinButton;
    btninput: TbsSkinButton;
    btnAdd: TbsSkinButton;
    btnallinput: TbsSkinButton;
    btndown: TbsSkinButton;
    BtnJump: TbsSkinButton;
    btnstop: TbsSkinButton;
    BtnOut: TbsSkinButton;
    btnCreate: TbsSkinButton;
    btnallOut: TbsSkinButton;
    bsSkinPanel11: TbsSkinPanel;
    bsSkinPanel12: TbsSkinPanel;
    bsSkinSplitter6: TbsSkinSplitter;
    DrawGrid1: TDrawGrid;
    Image1: TImage;
    ScrollBox1: TScrollBox;
    PaintBox1: TFlickerFreePaintBox;
    SavePictureDialog1: TbsSkinSavePictureDialog;
    OpenPictureDialog1: TbsSkinOpenPictureDialog;
    Labeltype: TbsSkinStdLabel;
    LabelSize: TbsSkinStdLabel;
    LabelIndex: TbsSkinStdLabel;
    LabelX: TbsSkinStdLabel;
    LabelY: TbsSkinStdLabel;
    InputDialog: TbsSkinInputDialog;
    Timer1: TTimer;
    EditFileName: TbsSkinFileEdit;
    bsSkinGroupBox5: TbsSkinGroupBox;
    bsSkinCheckRadioBox4: TbsSkinCheckRadioBox;
    bsSkinFileEdit1: TbsSkinFileEdit;
    bsSkinStdLabel8: TbsSkinStdLabel;
    bsSkinSelectDirectoryDialog1: TbsSkinSelectDirectoryDialog;
    bsSkinButton1: TbsSkinButton;
    LabelColorCount: TbsSkinStdLabel;
    bsSkinGroupBox6: TbsSkinGroupBox;
    bsSkinStdLabel9: TbsSkinStdLabel;
    bsSkinFileEdit2: TbsSkinFileEdit;
    bsSkinButton2: TbsSkinButton;
    bsSkinButton3: TbsSkinButton;
    bsSkinButton4: TbsSkinButton;
    bsSkinButton5: TbsSkinButton;
    bsSkinGroupBox7: TbsSkinGroupBox;
    bsSkinStdLabel10: TbsSkinStdLabel;
    bsSkinFileEdit3: TbsSkinFileEdit;
    bsSkinButton6: TbsSkinButton;
    bsSkinTabSheet7: TbsSkinTabSheet;
    bsSkinPanel13: TbsSkinPanel;
    bsSkinStdLabel11: TbsSkinStdLabel;
    BtnFongHaoBaseBak: TbsSkinButton;
    BtnFongHaoRestore: TbsSkinButton;
    bsSkinButton10: TbsSkinButton;
    bsSkinEdit1: TbsSkinEdit;
    bsSkinGroupBox8: TbsSkinGroupBox;
    bsSkinStdLabel12: TbsSkinStdLabel;
    ComboBoxFilterFongHaoMode: TbsSkinComboBox;
    bsSkinButton16: TbsSkinButton;
    bsSkinButton17: TbsSkinButton;
    bsSkinButton18: TbsSkinButton;
    bsSkinDBNavigator4: TbsSkinDBNavigator;
    bsSkinExPanel4: TbsSkinExPanel;
    bsSkinSplitter7: TbsSkinSplitter;
    MemoFongHaoHint: TbsSkinMemo;
    ListBoxFongHaoHint: TbsSkinListBox;
    bsSkinScrollBar1: TbsSkinScrollBar;
    bsSkinSplitter8: TbsSkinSplitter;
    FongHaoDBGrid: TDBGridEh;
    procedure BtnFindMagNameClick(Sender: TObject);
    procedure BtnFindMonNameClick(Sender: TObject);
    procedure BtnFindItemNameClick(Sender: TObject);
    procedure ComboBoxFilterItemsModeChange(Sender: TObject);
    procedure TrackEditColor1Change(Sender: TObject);
    procedure TrackEditColor2Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bsSkinButton7Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure bsSkinButton12Click(Sender: TObject);
    procedure bsSkinButton11Click(Sender: TObject);
    procedure bsSkinButton15Click(Sender: TObject);
    procedure bsSkinButton14Click(Sender: TObject);
    procedure bsSkinButton13Click(Sender: TObject);
    procedure BtnMagicBaseBakClick(Sender: TObject);
    procedure BtnMagicBaseRestoreClick(Sender: TObject);
    procedure bsSkinButtonLabel1Click(Sender: TObject);
    procedure BtnAlterMagicExpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject; Canvas: TCanvas);
    Function Extractrec(Restype,ResName,ResNewNAme:string):boolean;
    procedure FillInfo(index:Integer);
    procedure DrawGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure btnupClick(Sender: TObject);
    procedure btndownClick(Sender: TObject);
    procedure btnxClick(Sender: TObject);
    procedure btnyClick(Sender: TObject);
    procedure Rb50Click(Sender: TObject);
    procedure BtnJumpClick(Sender: TObject);
    procedure BtnAutoPlayClick(Sender: TObject);
    procedure btnstopClick(Sender: TObject);
    procedure btninputClick(Sender: TObject);
    procedure BtnOutClick(Sender: TObject);
    procedure btndeleteClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnCreateClick(Sender: TObject);
    procedure btnallinputClick(Sender: TObject);
    procedure btnallOutClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure EditFileNameButtonClick(Sender: TObject);
    procedure bsSkinFileEdit1ButtonClick(Sender: TObject);
    procedure bsSkinButton1Click(Sender: TObject);
    procedure bsSkinCheckRadioBox4Click(Sender: TObject);
    procedure bsSkinTabSheet2Show(Sender: TObject);
    procedure bsSkinButton2Click(Sender: TObject);
    procedure bsSkinFileEdit2ButtonClick(Sender: TObject);
    procedure bsSkinButton3Click(Sender: TObject);
    procedure bsSkinButton4Click(Sender: TObject);
    procedure bsSkinButton5Click(Sender: TObject);
    procedure bsSkinButton6Click(Sender: TObject);
    procedure bsSkinFileEdit3ButtonClick(Sender: TObject);
    procedure bsSkinButton16Click(Sender: TObject);
    procedure bsSkinButton18Click(Sender: TObject);
    procedure bsSkinButton17Click(Sender: TObject);
    procedure bsSkinButton10Click(Sender: TObject);
    procedure ComboBoxFilterFongHaoModeChange(Sender: TObject);
    procedure bsSkinTabSheet7Show(Sender: TObject);
  private
    Function ExportTxt(DBGridEh:TDBGrideh;Var TextName:string):BooLean;//导出TXT
    Function ExportTxt1(DBGridEh:TDBGrideh;Var TextName:string):BooLean;
    procedure BeforePrint();
  public
    procedure LoadConfig(); //读入配置
    procedure Open();
  end;

var
  FrmMain: TFrmMain;
  boDelDenyChr: Boolean;
  boSellOffItem: Boolean;
  boBigStorage: Boolean;
  Wil:TWil;
  Bmpx,bmpy: Integer;
  BmpIndex,BmpWidth,BmpHeight: Integer;
  BmpZoom: Real;
  BmpTran: Boolean;
  MainBitMap:TBitMap;
  Stop:Boolean;
  boIsSort: Boolean;//物品数据库是否排序
implementation

uses EGameToolsShare,EDcodeUnit,AboutUnit, DelWil, AddOneWil, NewWil, AddWil,
  OutWil;

{$R *.dfm}

procedure TFrmMain.LoadConfig; //读入配置
var
  MyIni: TIniFile;
begin
  MyIni := TIniFile.Create(ConfigFileName);
  DBEName := MyIni.ReadString('SYSTEM','DBEName',DBEName);
  sGameDirectory := MyIni.ReadString('SYSTEM','ServerDir',sGameDirectory);
  sWilDirectory:= MyIni.ReadString('SYSTEM','WilDirectory',sWilDirectory);
  MyIni.Free;
end;

procedure TFrmMain.Open;
begin
  FrmDM.TableMagic.DatabaseName := DBEName;
  FrmDM.TableMagic.Active := True;
       MagicDBGrid.Columns[0].Title.Caption := '序号';
       MagicDBGrid.Columns[1].Title.Caption := '名称';
       MagicDBGrid.Columns[2].Title.Caption := '动作效果';
       MagicDBGrid.Columns[3].Title.Caption := '魔法效果';
       MagicDBGrid.Columns[4].Title.Caption := '魔法消耗';
       MagicDBGrid.Columns[5].Title.Caption := '基本威力';
       MagicDBGrid.Columns[6].Title.Caption := '最大威力';
       MagicDBGrid.Columns[7].Title.Caption := '升级魔法';
       MagicDBGrid.Columns[8].Title.Caption := '升级威力';
       MagicDBGrid.Columns[9].Title.Caption := '升级最大威力';
       MagicDBGrid.Columns[10].Title.Caption := '职业';
       MagicDBGrid.Columns[11].Title.Caption := '1级等级';
       MagicDBGrid.Columns[12].Title.Caption := '1级经验';
       MagicDBGrid.Columns[13].Title.Caption := '2级等级';
       MagicDBGrid.Columns[14].Title.Caption := '2级经验';
       MagicDBGrid.Columns[15].Title.Caption := '3级等级';
       MagicDBGrid.Columns[16].Title.Caption := '3级经验';
       MagicDBGrid.Columns[17].Title.Caption := '技能延时';
       MagicDBGrid.Columns[18].Title.Caption := '备注说明';
  FrmDM.TableMonster.DatabaseName := DBEName;
  FrmDM.TableMonster.Active := True;
       MobDBGrid.Columns[0].Title.Caption := '名称';
       MobDBGrid.Columns[1].Title.Caption := '种族';
       MobDBGrid.Columns[2].Title.Caption := '种族图象';
       MobDBGrid.Columns[3].Title.Caption := '形象代码';
       MobDBGrid.Columns[4].Title.Caption := '等级';
       MobDBGrid.Columns[5].Title.Caption := '不死系';
       MobDBGrid.Columns[6].Title.Caption := '视觉范围';
       MobDBGrid.Columns[7].Title.Caption := '经验值';
       MobDBGrid.Columns[8].Title.Caption := '生命值';
       MobDBGrid.Columns[9].Title.Caption := '魔法值';
       MobDBGrid.Columns[10].Title.Caption := '防御力';
       MobDBGrid.Columns[11].Title.Caption := '魔御力';
       MobDBGrid.Columns[12].Title.Caption := '攻击力';
       MobDBGrid.Columns[13].Title.Caption := '最大攻击力';
       MobDBGrid.Columns[14].Title.Caption := '魔法力';
       MobDBGrid.Columns[15].Title.Caption := '道术力';
       MobDBGrid.Columns[16].Title.Caption := '敏捷';
       MobDBGrid.Columns[17].Title.Caption := '命中率';
       MobDBGrid.Columns[18].Title.Caption := '行走速度';
       MobDBGrid.Columns[19].Title.Caption := '行走步伐';
       MobDBGrid.Columns[20].Title.Caption := '行走等待';
       MobDBGrid.Columns[21].Title.Caption := '攻击速度';
  FrmDM.TableStdItems.DatabaseName := DBEName;
  FrmDM.TableStdItems.Active := True;
       ItemsDBGrid.Columns[0].Title.Caption := '序号';
       ItemsDBGrid.Columns[1].Title.Caption := '名称';
       ItemsDBGrid.Columns[2].Title.Caption := '分类号';
       ItemsDBGrid.Columns[3].Title.Caption := '装配外观';
       ItemsDBGrid.Columns[4].Title.Caption := '重量';
       ItemsDBGrid.Columns[5].Title.Caption := 'Anicount';
       ItemsDBGrid.Columns[6].Title.Caption := '源动力';
       ItemsDBGrid.Columns[7].Title.Caption := '保留';
       ItemsDBGrid.Columns[8].Title.Caption := '物品外观';
       ItemsDBGrid.Columns[9].Title.Caption := '持久力';
       ItemsDBGrid.Columns[10].Title.Caption := 'HP上限加量';
       ItemsDBGrid.Columns[11].Title.Caption := '攻击加速';
       ItemsDBGrid.Columns[12].Title.Caption := 'MP上限加量';
       ItemsDBGrid.Columns[13].Title.Caption := '作用延时';
       ItemsDBGrid.Columns[14].Title.Caption := '最低攻击力';
       ItemsDBGrid.Columns[15].Title.Caption := '最高攻击力';
       ItemsDBGrid.Columns[16].Title.Caption := '最低魔法力';
       ItemsDBGrid.Columns[17].Title.Caption := '最高魔法力';
       ItemsDBGrid.Columns[18].Title.Caption := '最低道术力';
       ItemsDBGrid.Columns[19].Title.Caption := '最高道术力';
       ItemsDBGrid.Columns[20].Title.Caption := '附加条件';
       ItemsDBGrid.Columns[21].Title.Caption := '需要等级';
       ItemsDBGrid.Columns[22].Title.Caption := '售价';
       ItemsDBGrid.Columns[23].Title.Caption := '库存量';

  FrmDM.TableFongHao.DatabaseName := DBEName;
  FrmDM.TableFongHao.Active := True;
end;
//查找技能书
procedure TFrmMain.BtnFindMagNameClick(Sender: TObject);
begin
  if EditMagName.Text = '' then Exit;
  with FrmDM.TableMagic do begin
    if not Eof then begin
      EditKey;
      DisableControls;
      while not Eof do begin
        if pos(Trim(EditMagName.Text), FieldByName('MagName').AsString)   <=   0   then Next
        else Break;
      end;
      EnableControls;
    end;
  end;
end;
//查找怪物
procedure TFrmMain.BtnFindMonNameClick(Sender: TObject);
begin
  if EditMobName.Text = '' then Exit;
  with FrmDM.TableMonster do begin
    if not Eof then begin
      EditKey;
      DisableControls;
      while not Eof do begin
        if pos(Trim(EditMobName.Text), FieldByName('Name').AsString)   <=   0   then Next
        else Break;
      end;
      EnableControls;
    end;
  end;
end;
//查找物品名
procedure TFrmMain.BtnFindItemNameClick(Sender: TObject);
begin
  if EditItemsName.Text = '' then Exit;
  with FrmDM.TableStdItems do begin
    if not Eof then begin
      EditKey;
      DisableControls;
      while not Eof do begin
        if pos(Trim(EditItemsName.Text), FieldByName('Name').AsString)   <=   0   then Next
        else Break;
      end;
      EnableControls;
    end;
  end;
end;
//过滤物品
procedure TFrmMain.ComboBoxFilterFongHaoModeChange(Sender: TObject);
  function FilterItems(Num: string):Boolean;
  begin
    Result := False;
    FrmDM.TableFongHao.Close;
    FrmDM.TableFongHao.Filter := 'Stdmode = '+Num;
    FrmDM.TableFongHao.Filtered := True;
    FrmDM.TableFongHao.Open;
    Result := True;
  end;
  function NoFilterItems():Boolean;
  begin
    Result := False;
    FrmDM.TableFongHao.Close;
    FrmDM.TableFongHao.Filter := '';
    FrmDM.TableFongHao.Filtered := False;
    FrmDM.TableFongHao.Open;
    Result := True;
  end;
begin
  case ComboBoxFilterFongHaoMode.ItemIndex of
    0: begin
        if NoFilterItems() then begin
          ListBoxFongHaoHint.Clear;
          MemoFongHaoHint.Clear;
          ListBoxFongHaoHint.Items.Add('0=一般称号');
          ListBoxFongHaoHint.Items.Add('1=水晶之星(免费千里传音)');
          ListBoxFongHaoHint.Items.Add('2=主宰龙卫');
          ListBoxFongHaoHint.Items.Add('3=护花使者');
          ListBoxFongHaoHint.Items.Add('4=不动如山(冲撞技能+10级)');
          ListBoxFongHaoHint.Items.Add('5=巅峰勇士(随机攻击倍数,死亡3次或0点时状态消失');
          ListBoxFongHaoHint.Items.Add('           时间设置无效 DC=最低倍数 DC2-最高倍数)');
          ListBoxFongHaoHint.Items.Add('6=热血使者(玩家(为队长),同地图时所有队员打怪经验翻倍)');
          ListBoxFongHaoHint.Items.Add('7=传奇之星(魔法盾,烈火剑法,神圣战甲术,幽灵盾变成粉红色)');
          ListBoxFongHaoHint.Items.Add('8=行会之星(退出行会称号消失)');
          ListBoxFongHaoHint.Items.Add('9=玛法主宰者(随意传送地图)');
          ListBoxFongHaoHint.Items.Add('10=高级巅峰勇士(随机攻击倍数,不受死亡次数限制');
          ListBoxFongHaoHint.Items.Add('                DC=最低倍数 DC2-最高倍数)');
          ListBoxFongHaoHint.Items.Add('11=0点消失称号(时间设置无效)');
        end;
    end;
    1: begin
        if FilterItems('0') then begin
          ListBoxFongHaoHint.Clear;
          ListBoxFongHaoHint.Items.Add('0=一般称号');
          ListBoxFongHaoHint.Items.Add('1=水晶之星(免费千里传音)');
          ListBoxFongHaoHint.Items.Add('2=主宰龙卫');
          ListBoxFongHaoHint.Items.Add('3=护花使者');
          ListBoxFongHaoHint.Items.Add('4=不动如山(冲撞技能+10级)');
          ListBoxFongHaoHint.Items.Add('5=巅峰勇士(随机攻击倍数,死亡3次或0点时状态消失');
          ListBoxFongHaoHint.Items.Add('           时间设置无效 DC=最低倍数 DC2-最高倍数)');
          ListBoxFongHaoHint.Items.Add('6=热血使者(玩家(为队长),同地图时所有队员打怪经验翻倍)');
          ListBoxFongHaoHint.Items.Add('7=传奇之星(魔法盾,烈火剑法,神圣战甲术,幽灵盾变成粉红色)');
          ListBoxFongHaoHint.Items.Add('8=行会之星(退出行会称号消失)');
          ListBoxFongHaoHint.Items.Add('9=玛法主宰者(随意传送地图)');
          ListBoxFongHaoHint.Items.Add('10=高级巅峰勇士(随机攻击倍数,不受死亡次数限制');
          ListBoxFongHaoHint.Items.Add('                DC=最低倍数 DC2-最高倍数)');
          ListBoxFongHaoHint.Items.Add('11=0点消失称号(时间设置无效)');
          MemoFongHaoHint.Clear;
          MemoFongHaoHint.Lines.Text := 'Shape  =预留'+#13+
                                        'Anicount=称号特殊效果'+#13+
                                        'nHours =称号时限(小时) 65535-永久'+#13+
                                        'Looks  =称号的内观'+#13+
                                        'AC     =体力上限'+#13+
                                        'AC2    =强身等级'+#13+
                                        'MAC    =内伤等级'+#13+
                                        'MAC2   =暴击等级'+#13+
                                        'DC     =麻痹抗性'+#13+
                                        'DC2    =攻击上限'+#13+
                                        'MC     =聚魔等级'+#13+
                                        'MC2    =魔法上限'+#13+
                                        'SC     =合击威力'+#13+
                                        'SC2    =道术上限'+#13+#13+
                                        'Need(附加条件)'+#13+
                                        '0:需等级   NeedLevel=等级'+#13+
                                        '1:需攻击力 NeedLevel=攻击力'+#13+
                                        '2:需魔法   NeedLevel=魔法'+#13+
                                        '3:需道术   NeedLevel=道术';
        end;
    end;
    2: begin
        if FilterItems('1') then begin
          ListBoxFongHaoHint.Clear;
          ListBoxFongHaoHint.Items.Add('0=一般称号');
          ListBoxFongHaoHint.Items.Add('1=水晶之星(免费千里传音)');
          ListBoxFongHaoHint.Items.Add('2=主宰龙卫');
          ListBoxFongHaoHint.Items.Add('3=护花使者');
          ListBoxFongHaoHint.Items.Add('4=不动如山(冲撞技能+10级)');
          ListBoxFongHaoHint.Items.Add('5=巅峰勇士(随机攻击倍数,死亡3次或0点时状态消失');
          ListBoxFongHaoHint.Items.Add('           时间设置无效 DC=最低倍数 DC2-最高倍数)');
          ListBoxFongHaoHint.Items.Add('6=热血使者(玩家(为队长),同地图时所有队员打怪经验翻倍)');
          ListBoxFongHaoHint.Items.Add('7=传奇之星(魔法盾,烈火剑法,神圣战甲术,幽灵盾变成粉红色)');
          ListBoxFongHaoHint.Items.Add('8=行会之星(退出行会称号消失)');
          ListBoxFongHaoHint.Items.Add('9=玛法主宰者(随意传送地图)');
          ListBoxFongHaoHint.Items.Add('10=高级巅峰勇士(随机攻击倍数,不受死亡次数限制');
          ListBoxFongHaoHint.Items.Add('                DC=最低倍数 DC2-最高倍数)');
          ListBoxFongHaoHint.Items.Add('11=0点消失称号(时间设置无效)');
          MemoFongHaoHint.Clear;
          MemoFongHaoHint.Lines.Text := 'Anicount=决定称号的作用效果'+#13+
                                        'Looks=称号的外观'+#13+#13+
                                        'Need(附加条件)'+#13+
                                        '0:需等级   NeedLevel=等级'+#13+
                                        '1:需攻击力 NeedLevel=攻击力'+#13+
                                        '2:需魔法   NeedLevel=魔法'+#13+
                                        '3:需道术   NeedLevel=道术';
        end;
    end;
  end;
end;

procedure TFrmMain.ComboBoxFilterItemsModeChange(Sender: TObject);
  function FilterItems(Num: string):Boolean;
  begin
    Result := False;
    FrmDM.TableStdItems.Close;
    FrmDM.TableStdItems.Filter := 'Stdmode = '+Num;
    FrmDM.TableStdItems.Filtered := True;
    FrmDM.TableStdItems.Open;
    Result := True;
  end;
  function NoFilterItems():Boolean;
  begin
    Result := False;
    FrmDM.TableStdItems.Close;
    FrmDM.TableStdItems.Filter := '';
    FrmDM.TableStdItems.Filtered := False;
    FrmDM.TableStdItems.Open;
    Result := True;
  end;    
begin
  case ComboBoxFilterItemsMode.ItemIndex of
    0: begin
        if NoFilterItems() then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
        end;
    end;
    1: begin
        if FilterItems('0') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          ListBoxItemsHint.Items.Add('0=慢速添加型');
          ListBoxItemsHint.Items.Add('1=快速添加型');
          ListBoxItemsHint.Items.Add('2=（神水）型');
          ListBoxItemsHint.Items.Add('3=（药瓶1）型');
          ListBoxItemsHint.Items.Add('4=（药瓶2）型');
          MemoItemsHint.Lines.Text := '装配外观(Shape)=决定了药品的作用效果'+#13+
                                      'HP增加量(Ac)=生命值增加量'+#13+
                                      'MP增加量(Mac)=魔法值增加量'+#13+
                                      '作用延时(Mac2)=作用有效时间，单位为秒';
        end;
    end;
    2: begin
        if FilterItems('1') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
        end;
    end;
    3: begin
        if FilterItems('2') then begin
          ListBoxItemsHint.Clear;
          ListBoxItemsHint.Items.Add('附加条件=1,物品不能放于6格快捷框上');
          ListBoxItemsHint.Items.Add('Anicount=21 为祝福罐类物品');
          MemoItemsHint.Clear;
          MemoItemsHint.Lines.Text := '装配外观：'+#13+
                                      '   Shape=1,召唤强化卷'+#13+
                                      '   Shape=2,随机传送石'+#13+
                                      '   Shape=4,沙巴克随机石'+#13+
                                      '   Shape=5,朱火鼎'+#13+
                                      '   Shape=9,修复神水'+#13+
                                      '   Shape=10,霹雳弹、天雷弹'+#13+
                                      '   Shape=11,胡萝卜(宠物相关)'+#13+
                                      '   Shape=12,新年鞭炮(宠物相关)'+#13+
                                      '   Shape=253,护花令牌(不掉持久)'+#13+
                                      '   Shape=254,主宰令牌(不掉持久)'+#13+
                                      '   Shape=255,灵气神水';
        end;
    end;
    4: begin
        if FilterItems('3') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          ListBoxItemsHint.Items.Add('1=（地牢逃脱卷）');
          ListBoxItemsHint.Items.Add('2=（随机传送卷）');
          ListBoxItemsHint.Items.Add('3=（回城卷）');
          ListBoxItemsHint.Items.Add('4=（祝福油）');
          ListBoxItemsHint.Items.Add('5=（行会回城卷）');
          ListBoxItemsHint.Items.Add('9=修复油等油类');
          ListBoxItemsHint.Items.Add('10=（战神油）');
          ListBoxItemsHint.Items.Add('11=（彩票）');
          ListBoxItemsHint.Items.Add('12=攻、魔、道等各类药水');
          ListBoxItemsHint.Items.Add('13=除魔攻击药剂');
          ListBoxItemsHint.Items.Add('14=除魔防御药剂');
          MemoItemsHint.Lines.Text := '装配外观(Shape)=等于12时，为特殊药水类物品'+#13+
                                      'shape=12的特殊药品：'+#13+
                                      '　攻击力药水：作用延时(Mac2)=180，最低攻击力(Dc)=5，则攻击力增加5，作用延时180秒；'+#13+
                                      '　疾风药水：作用延时(Mac2)=180，攻击加速(Ac2)=1，则攻击速度瞬间提高180秒；'+#13+
                                      '　HP强化水：作用延时(Mac2)=120，HP上限加量(Ac)=50，则HP上限增加50，作用延时120秒'+#13+#13+
                                      'shape=13 除魔攻击药剂'+#13+
                                      '  作用延时(Mac2)=3600，HP上限加量(Ac)=10 使用时根据职业，随机增加10对应属性，时间3600秒'+#13+#13+
                                      'shape=14 除魔防御药剂'+#13+
                                      '  作用延时(Mac2)=3600，HP上限加量(Ac)=10 使用时，随机增加防御或魔防，随机增加10对应属性，时间3600秒'+#13+#13+
                                      '不等于12时，为一般的卷书、油、彩票物品；';
       end;
    end;


    5: begin
        if FilterItems('4') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          ListBoxItemsHint.Items.Add('字段装备外观:');
          ListBoxItemsHint.Items.Add('0=战士职业用');
          ListBoxItemsHint.Items.Add('1=法师职业用');
          ListBoxItemsHint.Items.Add('2=道士职业用');
          ListBoxItemsHint.Items.Add('99=(通用)');

          MemoItemsHint.Lines.Text := '学习等级(DuraMax)=为修习时所需要的等级，而不是“需要等级(NeedLevel)”！'+#13+
                                      'Source=127时,可以增加火龙之心的怒气(Reserved*100=增加怒气值)'+#13+
                                      'Anicount(0-普通书 1-内功书)'+#13+
                                      '四级技能书(AC 0-主体书 1-英雄书)';
        end;
    end;
    6: begin
        if FilterItems('5') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          ListBoxItemsHint.Items.Add('0=为新武器保留');
          ListBoxItemsHint.Items.Add('1=（木剑、乌木剑）');
          ListBoxItemsHint.Items.Add('2=（铁剑、青铜剑）');
          ListBoxItemsHint.Items.Add('3=（青铜斧）');
          ListBoxItemsHint.Items.Add('4=（短剑）');
          ListBoxItemsHint.Items.Add('5=（凌风）');
          ListBoxItemsHint.Items.Add('6=（破魂、匕首）');
          ListBoxItemsHint.Items.Add('7=（修罗）');
          ListBoxItemsHint.Items.Add('9=（银蛇）');
          ListBoxItemsHint.Items.Add('10=（斩马刀）');
          ListBoxItemsHint.Items.Add('13=（凝霜）');
          ListBoxItemsHint.Items.Add('14=（降魔）');
          ListBoxItemsHint.Items.Add('15=（八荒）');
          ListBoxItemsHint.Items.Add('16=（半月）');
          ListBoxItemsHint.Items.Add('17=（井中月、斩月刀）');
          ListBoxItemsHint.Items.Add('21=（无极棍）');
          ListBoxItemsHint.Items.Add('22=（血饮）');
          ListBoxItemsHint.Items.Add('23=（祈祷之刃）');
          ListBoxItemsHint.Items.Add('25=（龙纹剑、龙骨剑）');
          ListBoxItemsHint.Items.Add('26=（屠龙、GM屠龙）');
          ListBoxItemsHint.Items.Add('29=（命运之刃）');
          ListBoxItemsHint.Items.Add('30=（赤血魔剑、GM剑）');
          ListBoxItemsHint.Items.Add('31=（统帅之刃）');
          ListBoxItemsHint.Items.Add('32=（疆域之杖）');
          ListBoxItemsHint.Items.Add('33=（玉竹扇）');
          ListBoxItemsHint.Items.Add('75=（乌金铲）');
          ListBoxItemsHint.Items.Add('76=（金刚铲）');
          ListBoxItemsHint.Items.Add('77=（新手铲、铁铲）');
          MemoItemsHint.Lines.Text := '攻击加速是准确'+#13+
                                      '作用延时是敏捷'+#13+
                                      '源动力是神圣强度'+#13+
                                      '装配外观(Shape)=人物装配外观，该数值相同的物品，在人物外观上看也相同'+#13+
                                      '强度神圣(Source)=正：强度（建议值：0~100）；负：神圣（建议值：-100~0）'+#13+
                                      '物品外观(Looks)=该数值相同的物品，在物品栏中外观也相同'+#13+
                                      '持久度(DuraMax)=以1000为单位，1000即为1个点的持久'+#13+
                                      '幸运(AC)=（建议值：0~100）'+#13+
                                      '准确(AC2)=（建议值：0~200）'+#13+
                                      '诅咒(Mac)=（建议值：0~100）'+#13+
                                      '攻击速度(Mac2)=计算公式：攻击速度=246+X，X为所填数值，必须为负数，如：攻击速度+6，则设Mac2=-240；建议值：-236~0'+#13+
                                      '需要等级(Need)与附加条件(NeedLevel)=需要配合使用，'+#13+
                                      '  Need=0时NeedLevel为所需等级；'+#13+
                                      '  Need=1时NeedLevel为所需攻击力；'+#13+
                                      '  Need=2时NeedLevel为所需魔法力；'+#13+
                                      '  Need=3时NeedLevel为所需道术力';
        end;
    end;
    7: begin
        if FilterItems('6') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          ListBoxItemsHint.Items.Add('8=（海魂）');
          ListBoxItemsHint.Items.Add('11=（炼狱、斩天）');
          ListBoxItemsHint.Items.Add('12=（魔杖、法杖）');
          ListBoxItemsHint.Items.Add('18=（偃月）');
          ListBoxItemsHint.Items.Add('19=（鹤嘴锄）');
          ListBoxItemsHint.Items.Add('24=（裁决之杖）');
          ListBoxItemsHint.Items.Add('27=（嗜魂法杖、GM权杖）');
          ListBoxItemsHint.Items.Add('28=（骨玉权杖、碧玉权杖）');
          MemoItemsHint.Lines.Text := '装配外观(Shape)=人物装配外观，该数值相同的物品，在人物外观上看也相同'+#13+
                                      '强度神圣(Source)=正：强度（建议值：0~100）；负：神圣（建议值：-100~0）'+#13+
                                      '物品外观(Looks)=该数值相同的物品，在物品栏中外观也相同'+#13+
                                      '持久度(DuraMax)=以1000为单位，1000即为1个点的持久'+#13+
                                      '幸运(AC)=（建议值：0~100）'+#13+
                                      '准确(AC2)=（建议值：0~200）'+#13+
                                      '诅咒(Mac)=（建议值：0~100）'+#13+
                                      '攻击速度(Mac2)=计算公式：攻击速度=246+X，X为所填数值，必须为负数，如：攻击速度+6，则设Mac2=-240；建议值：-236~0'+#13+
                                      '需要等级(Need)与附加条件(NeedLevel)=需要配合使用，Need=0时NeedLevel为所需等级；Need=1时NeedLevel为所需攻击力；Need=2时NeedLevel为所需魔法力；Need=3时NeedLevel为所需道术力';
        end;
    end;

    8: begin
        if FilterItems('7') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          MemoItemsHint.Lines.Text := '装配外观(Shape) 0 千里传单'+#13+
                                      '                1 气血石'+#13+
                                      '                2 幻魔石'+#13+
                                      '                3 魔血石'+#13+
                                      '                4 传音筒'+#13+
                                      '                5 天龙印、火龙印';
        end;
    end;
    9:begin
        if FilterItems('8') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          MemoItemsHint.Lines.Text := '装配外观(Shape)=0-普通材料 1-精制材料'+#13+
                                      'Anicount=酒(Shape)时才能酿造出酒,'+#13+
                                      '保留(Reserved)=材料所具有的酒精度'+#13+
                                      'HP上限加量(AC)=精制材料所具有的品质';
        end;
    end;
    10:begin
        if FilterItems('9') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
        end;
    end;
    11: begin
        if FilterItems('10') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          ListBoxItemsHint.Items.Add('1=布衣');
          ListBoxItemsHint.Items.Add('2=轻盔');
          ListBoxItemsHint.Items.Add('3=重盔');
          ListBoxItemsHint.Items.Add('4=魔法长袍');
          ListBoxItemsHint.Items.Add('5=灵魂战衣');
          MemoItemsHint.Lines.Text := 'HP上限和攻击加速是防御上限和下限'+#13+
                                      'MP上限和作用延时是魔御上限和下限';
        end;
    end;
    12: begin
        if FilterItems('11') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          ListBoxItemsHint.Items.Add('1=布衣');
          ListBoxItemsHint.Items.Add('2=轻盔');
          ListBoxItemsHint.Items.Add('3=重盔');
          ListBoxItemsHint.Items.Add('4=魔法长袍');
          ListBoxItemsHint.Items.Add('5=灵魂战衣');
          MemoItemsHint.Lines.Text := 'HP上限和攻击加速是防御上限和下限'+#13+
                                      'MP上限和作用延时是魔御上限和下限';
        end;
    end;
    13:begin
        if FilterItems('12') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          MemoItemsHint.Lines.Text := '装配外观(Shape) 0-普通酒使用 1-药酒使用';
        end;
    end;
    14:begin
        if FilterItems('13') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          MemoItemsHint.Lines.Text := '装配外观(Shape)=主材料的AniCount,加品质+1';
        end;
    end;
    15:begin
        if FilterItems('14') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          MemoItemsHint.Lines.Text := 'Anicount对应酒(Shape)时才能酿造出酒';
        end;
    end;
    16: begin
        if FilterItems('15') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          ListBoxItemsHint.Items.Add('0=普通头盔');
          ListBoxItemsHint.Items.Add('125=记忆头盔');
          ListBoxItemsHint.Items.Add('129=祈祷头盔');
          ListBoxItemsHint.Items.Add('132=神秘头盔');
          MemoItemsHint.Lines.Text := 'HP上限和攻击加速是防御上限和下限'+#13+
                                      'MP上限和作用延时是魔御上限和下限';
        end;
    end;
    17: begin
        if FilterItems('16') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          ListBoxItemsHint.Items.Add('普通斗笠(Shape为0)可控制显示神秘人');
          ListBoxItemsHint.Items.Add('王者斗笠(Shape为1)可控制显示神秘人');
          ListBoxItemsHint.Items.Add('黑    巾(Shape为2)不显示神秘人');
          ListBoxItemsHint.Items.Add('必杀斗笠(Shape为3)可控制显示神秘人');
          ListBoxItemsHint.Items.Add('金牛斗笠(Shape为4)可控制显示神秘人');
          ListBoxItemsHint.Items.Add('主宰斗笠(Shape为5)可控制显示神秘人');
          ListBoxItemsHint.Items.Add('传奇斗笠(Shape为6)可控制显示神秘人');
          ListBoxItemsHint.Items.Add('皓月斗笠(Shape为7)可控制显示神秘人');
          MemoItemsHint.Lines.Text := '穿戴控制：'+#13+
                                      'Anicount 0-主体英雄全可带'+#13+
                                      '         1-主体可带'+#13+
                                      '         2-英雄可带'+#13+
                                      '源动力(0-125) 击杀对手时，对手爆率增加';
        end;
    end;
    18: begin
      if FilterItems('17') then begin
        ListBoxItemsHint.Clear;
        MemoItemsHint.Clear;
        ListBoxItemsHint.Items.Add('Shape:');
        ListBoxItemsHint.Items.Add('  0-6 金针类,表示等级(对应符等级)');
        ListBoxItemsHint.Items.Add('  237 药品(双击使用)');
        ListBoxItemsHint.Items.Add('  238 为奇经培元丹');
        ListBoxItemsHint.Items.Add('  239-241 为1-3卷轴(鉴定)');
        ListBoxItemsHint.Items.Add('  242 为赤炎石碎片');
        ListBoxItemsHint.Items.Add('  243-252 为1-10级赤炎石');
        ListBoxItemsHint.Items.Add('  253-255 为英雄经络丸');

        MemoItemsHint.Lines.Text := '源动力 0-显示重量'+#13+
                                    'DuraMax(持久)-可叠加上限值'+#13+
                                    'Anicount:'+#13+
                                    '  (针)-合成成功率'+#13+
                                    '  (英雄经络丸)-英雄经络经验'+#13+
                                    '  (奇经培元丹)-奇经经验 1:1000'+#13+
                                    '  (药品)0-慢速型 1-快速型'+#13+
                                    'Reserved-合成后给物品的标识,例2'+#13+
                                    '   ,合成成功给针(分类17,外观2)'+#13+
                                    'Ac--(药品类)生命值增加量'+#13+
                                    'Mac-(药品类)魔法值增加量'+#13+
                                    'Dc--(药品类)>0时可进行吸收心法经验';
      end;
    end;
    19: begin
      if FilterItems('18') then begin
        ListBoxItemsHint.Clear;
        MemoItemsHint.Clear;
        ListBoxItemsHint.Items.Add('Shape--表示等级(与针的等级对应)');
        ListBoxItemsHint.Items.Add('源动力 0-显示重量');
        ListBoxItemsHint.Items.Add('DuraMax(持久)--可叠加上限值');
        ListBoxItemsHint.Items.Add('Anicount--合成成功率');
        MemoItemsHint.Lines.Text := '锻炼金针所需幸运符物品';
      end;
    end;
    20: begin
        if FilterItems('19') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          ListBoxItemsHint.Items.Add('0=灯笼、白色虎齿、水域');
          ListBoxItemsHint.Items.Add('123=记忆项链');
          MemoItemsHint.Lines.Text := '作用延时 为 幸运 '+#13+
                                      '攻击加速 为 魔法躲避'+#13+
                                      '装配外观(Shape)=人物装配外观，该数值相同的物品，在人物外观上看也相同'+#13+
                                      '源动力(0-125) 击杀对手时，对手爆率增加'+#13+
                                      '物品外观(Looks)=该数值相同的物品，在物品栏中外观也相同'+#13+
                                      '持久度(DuraMax)=以1000为单位，1000即为1个点的持久'+#13+
                                      '魔法躲避(Ac2)=（1＝10%，2＝20%，…，建议值：0~100）'+#13+
                                      '诅咒(Mac)=（建议值：0~100）'+#13+
                                      '幸运(Mac2)=（建议值：0~100）'+#13+
                                      '最低与最高攻击力(Dc、Dc2)=（建议值：0~200）'+#13+
                                      '最低与最高魔法力(Mc、Mc2)=（建议值：0~200）'+#13+
                                      '最低与最高道术力(Sc、Sc2)=（建议值：0~200）'+#13+
                                      '需要等级(Need)与附加条件(NeedLevel)=需要配合使用，Need=0时NeedLevel为所需等级；Need=1时NeedLevel为所需攻击力；Need=2时NeedLevel为所需魔法力；Need=3时NeedLevel为所需道术力';
        end;
    end;
    21: begin
        if FilterItems('20') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          ListBoxItemsHint.Items.Add('0=普通项链');
          ListBoxItemsHint.Items.Add('113=浮幽项链');
          ListBoxItemsHint.Items.Add('120=技巧项链');
          ListBoxItemsHint.Items.Add('121=探测项链');
          ListBoxItemsHint.Items.Add('135=兰花项链');
          ListBoxItemsHint.Items.Add('138=敌难项链');
          MemoItemsHint.Lines.Text := '攻击加速是准确'+#13+
                                      '作用延时是敏捷'+#13+
                                      '装配外观(Shape)=人物装配外观，该数值相同的物品，在人物外观上看也相同'+#13+
                                      '物品外观(Looks)=该数值相同的物品，在物品栏中外观也相同'+#13+
                                      '持久度(DuraMax)=以1000为单位，1000即为1个点的持久'+#13+
                                      '准确(Ac2)=（建议值：0~100）'+#13+
                                      '敏捷(Mac2)=（建议值：0~100）'+#13+
                                      '最低与最高攻击力(Dc、Dc2)=（建议值：0~200）'+#13+
                                      '最低与最高魔法力(Mc、Mc2)=（建议值：0~200）'+#13+
                                      '最低与最高道术力(Sc、Sc2)=（建议值：0~200）'+#13+
                                      '需要等级(Need)与附加条件(NeedLevel)=需要配合使用，Need=0时NeedLevel为所需等级；Need=1时NeedLevel为所需攻击力；Need=2时NeedLevel为所需魔法力；Need=3时NeedLevel为所需道术力';
        end;
    end;
    22: begin
        if FilterItems('21') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          ListBoxItemsHint.Items.Add('0=狂风项链');
          ListBoxItemsHint.Items.Add('113=祈祷项链');
          ListBoxItemsHint.Items.Add('127=GM项链');
          MemoItemsHint.Lines.Text := 'HP上限 应该是攻击加速'+#13+
                                      '攻击加速应该是体力恢复'+#13+
                                      '作用延时应该是魔法恢复'+#13+
                                      '装配外观(Shape)=人物装配外观，该数值相同的物品，在人物外观上看也相同'+#13+
                                      '物品外观(Looks)=该数值相同的物品，在物品栏中外观也相同'+#13+
                                      '持久度(DuraMax)=以1000为单位，1000即为1个点的持久'+#13+
                                      '＋攻击速度(Ac)=（建议值：0~10）'+#13+
                                      '体力恢复(Ac2)=（1＝10%，2＝20%，…，建议值：0~100）'+#13+
                                      '－攻击速度(Mac)=（建议值：0~10）'+#13+
                                      '魔法恢复(Mac2)=（1＝10%，2＝20%，…，建议值：0~100）'+#13+
                                      '最低与最高攻击力(Dc、Dc2)=（建议值：0~200）'+#13+
                                      '最低与最高魔法力(Mc、Mc2)=（建议值：0~200）'+#13+
                                      '最低与最高道术力(Sc、Sc2)=（建议值：0~200）'+#13+
                                      '需要等级(Need)与附加条件(NeedLevel)=需要配合使用，Need=0时NeedLevel为所需等级；Need=1时NeedLevel为所需攻击力；Need=2时NeedLevel为所需魔法力；Need=3时NeedLevel为所需道术力';
        end;
    end;
    23: begin
        if FilterItems('22') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          ListBoxItemsHint.Items.Add('0=普通戒指');
          ListBoxItemsHint.Items.Add('111=隐身戒指');
          ListBoxItemsHint.Items.Add('112=传送戒指');
          ListBoxItemsHint.Items.Add('113=麻痹戒指');
          ListBoxItemsHint.Items.Add('114=复活戒指');
          ListBoxItemsHint.Items.Add('115=火焰戒指');
          ListBoxItemsHint.Items.Add('116=治愈戒指');
          ListBoxItemsHint.Items.Add('117=愤怒戒指');
          ListBoxItemsHint.Items.Add('118=护身戒指');
          ListBoxItemsHint.Items.Add('119=超负载戒指');
          ListBoxItemsHint.Items.Add('122,123,124,125=记忆戒指');
          ListBoxItemsHint.Items.Add('130,131,132=神秘戒指');
          ListBoxItemsHint.Items.Add('133=兰花戒指');
          ListBoxItemsHint.Items.Add('136=敌难戒指');
          ListBoxItemsHint.Items.Add('169=流星火雨戒指');
          ListBoxItemsHint.Items.Add('189=聚魔护身戒指');
          ListBoxItemsHint.Items.Add('190=战意麻痹戒指');
          ListBoxItemsHint.Items.Add('191=魔道麻痹戒指');
          ListBoxItemsHint.Items.Add('192=倚天辟地技能');
          ListBoxItemsHint.Items.Add('197=重生戒指');
          MemoItemsHint.Lines.Text := 'HP上限和攻击加速是防御上限和防御下限'+#13+
                                      'MP上限和作用延时应该是魔御上限和下限'+#13+
                                      '装配外观(Shape)=人物装配外观，该数值相同的物品，在人物外观上看也相同'+#13+
                                      '物品外观(Looks)=该数值相同的物品，在物品栏中外观也相同'+#13+
                                      '持久度(DuraMax)=以1000为单位，1000即为1个点的持久'+#13+
                                      '最低与最高攻防(Ac、Ac2)=（建议值：0~200）'+#13+
                                      '最低与最高魔御(Mac、Mac2)=（建议值：0~200）'+#13+
                                      '最低与最高攻击力(Dc、Dc2)=（建议值：0~200）'+#13+
                                      '最低与最高魔法力(Mc、Mc2)=（建议值：0~200）'+#13+
                                      '最低与最高道术力(Sc、Sc2)=（建议值：0~200）'+#13+
                                      '需要等级(Need)与附加条件(NeedLevel)=需要配合使用，Need=0时NeedLevel为所需等级；Need=1时NeedLevel为所需攻击力；Need=2时NeedLevel为所需魔法力；Need=3时NeedLevel为所需道术力';
        end;
    end;
    24: begin
        if FilterItems('23') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          ListBoxItemsHint.Items.Add('0=魅力、道德、狂风戒指');
          ListBoxItemsHint.Items.Add('113=考斯戒指');
          ListBoxItemsHint.Items.Add('114=贝斯戒指');
          ListBoxItemsHint.Items.Add('119=宙斯戒指');
          ListBoxItemsHint.Items.Add('128=祈祷戒指');
          MemoItemsHint.Lines.Text := 'HP上限是攻击加速'+#13+
                                      '攻击速度是毒物躲避'+#13+
                                      '作用延时是中毒恢复'+#13+
                                      '装配外观(Shape)=人物装配外观，该数值相同的物品，在人物外观上看也相同'+#13+
                                      '物品外观(Looks)=该数值相同的物品，在物品栏中外观也相同'+#13+
                                      '持久度(DuraMax)=以1000为单位，1000即为1个点的持久'+#13+
                                      '＋攻击速度(Ac)=（建议值：0~10）'+#13+
                                      '毒物躲避(Ac2)=（1＝10%，2＝20%，…，建议值：0~100）'+#13+
                                      '－攻击速度(Mac)=（建议值：0~10）'+#13+
                                      '中毒恢复(Mac2)=（1＝10%，2＝20%，…，建议值：0~100）'+#13+
                                      '最低与最高攻击力(Dc、Dc2)=（建议值：0~200）'+#13+
                                      '最低与最高魔法力(Mc、Mc2)=（建议值：0~200）'+#13+
                                      '最低与最高道术力(Sc、Sc2)=（建议值：0~200）'+#13+
                                      '需要等级(Need)与附加条件(NeedLevel)=需要配合使用，Need=0时NeedLevel为所需等级；Need=1时NeedLevel为所需攻击力；Need=2时NeedLevel为所需魔法力；Need=3时NeedLevel为所需道术力';

        end;
    end;
    25: begin
        if FilterItems('24') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          ListBoxItemsHint.Items.Add('0=铁、银、夏普儿、避邪、银域手镯');
          ListBoxItemsHint.Items.Add('124=记忆手镯');
          MemoItemsHint.Lines.Text := '攻击加速是准确'+#13+
                                      '作用延时是敏捷'+#13+
                                      '装配外观(Shape)=人物装配外观，该数值相同的物品，在人物外观上看也相同'+#13+
                                      '物品外观(Looks)=该数值相同的物品，在物品栏中外观也相同'+#13+
                                      '持久度(DuraMax)=以1000为单位，1000即为1个点的持久'+#13+
                                      '准确(Ac2)=（建议值：0~100）'+#13+
                                      '敏捷(Mac2)=（建议值：0~100）'+#13+
                                      '最低与最高攻击力(Dc、Dc2)=（建议值：0~200）'+#13+
                                      '最低与最高魔法力(Mc、Mc2)=（建议值：0~200）'+#13+
                                      '最低与最高道术力(Sc、Sc2)=（建议值：0~200）'+#13+
                                      '需要等级(Need)与附加条件(NeedLevel)=需要配合使用，Need=0时NeedLevel为所需等级；Need=1时NeedLevel为所需攻击力；Need=2时NeedLevel为所需魔法力；Need=3时NeedLevel为所需道术力';

        end;
    end;
    26: begin
        if FilterItems('25') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          ListBoxItemsHint.Items.Add('0=超级蓝毒');
          ListBoxItemsHint.Items.Add('1=灰色药粉');
          ListBoxItemsHint.Items.Add('2=黄色药粉');
          ListBoxItemsHint.Items.Add('5=护身符');
        end;
    end;
    27: begin
        if FilterItems('26') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          ListBoxItemsHint.Items.Add('0=普通型');
          ListBoxItemsHint.Items.Add('126=祈祷手镯');
          ListBoxItemsHint.Items.Add('131=神秘手镯');
          ListBoxItemsHint.Items.Add('134=兰花手镯');
          ListBoxItemsHint.Items.Add('137=敌难手镯');
          MemoItemsHint.Lines.Text := 'HP上限和攻击加速是防御上限和下限'+#13+
                                      'MP上限和作用延时是魔御上限和下限'+#13+
                                      '装配外观(Shape)=人物装配外观，该数值相同的物品，在人物外观上看也相同'+#13+
                                      '物品外观(Looks)=该数值相同的物品，在物品栏中外观也相同'+#13+
                                      '持久度(DuraMax)=以1000为单位，1000即为1个点的持久'+#13+
                                      '最低与最高攻防(Ac、Ac2)=（建议值：0~200）'+#13+
                                      '最低与最高魔御(Mac、Mac2)=（建议值：0~200）'+#13+
                                      '最低与最高攻击力(Dc、Dc2)=（建议值：0~200）'+#13+
                                      '最低与最高魔法力(Mc、Mc2)=（建议值：0~200）'+#13+
                                      '最低与最高道术力(Sc、Sc2)=（建议值：0~200）'+#13+
                                      '需要等级(Need)与附加条件(NeedLevel)=需要配合使用，Need=0时NeedLevel为所需等级；Need=1时NeedLevel为所需攻击力；Need=2时NeedLevel为所需魔法力；Need=3时NeedLevel为所需道术力';

        end;
    end;
    28:begin
      if FilterItems('27') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          MemoItemsHint.Lines.Text := '攻击加速是准确'+#13+
                                      '作用延时是敏捷'+#13+
                                      '装配外观(Shape)=人物装配外观，该数值相同的物品，在人物外观上看也相同'+#13+
                                      '物品外观(Looks)=该数值相同的物品，在物品栏中外观也相同'+#13+
                                      '持久度(DuraMax)=以1000为单位，1000即为1个点的持久'+#13+
                                      '准确(Ac2)=（建议值：0~100）'+#13+
                                      '敏捷(Mac2)=（建议值：0~100）';
      end;
    end;
    29:begin
      if FilterItems('28') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          MemoItemsHint.Lines.Text := '作用延时 为 幸运 '+#13+
                                      '攻击加速 为 准确'+#13+
                                      '装配外观(Shape)=人物装配外观，该数值相同的物品，在人物外观上看也相同'+#13+
                                      '源动力(0-125) 击杀对手时，对手爆率增加'+#13+
                                      '物品外观(Looks)=该数值相同的物品，在物品栏中外观也相同'+#13+
                                      '持久度(DuraMax)=以1000为单位，1000即为1个点的持久'+#13+
                                      '准确(Ac2)=（建议值：0~100）'+#13+
                                      '诅咒(Mac)=（建议值：0~100）'+#13+
                                      '幸运(Mac2)=（建议值：0~100）';
      end;
    end;
    30: begin
      if FilterItems('29') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          MemoItemsHint.Lines.Text := '作用延时 为 幸运 '+#13+
                                      '攻击加速 为 敏捷'+#13+
                                      '装配外观(Shape)=人物装配外观，该数值相同的物品，在人物外观上看也相同'+#13+
                                      '源动力(0-125) 击杀对手时，对手爆率增加'+#13+
                                      '物品外观(Looks)=该数值相同的物品，在物品栏中外观也相同'+#13+
                                      '持久度(DuraMax)=以1000为单位，1000即为1个点的持久'+#13+
                                      '敏捷(Ac2)=（建议值：0~100）'+#13+
                                      '诅咒(Mac)=（建议值：0~100）'+#13+
                                      '幸运(Mac2)=（建议值：0~100）';
      end;
    end;
    31: begin
        if FilterItems('30') then begin
          ListBoxItemsHint.Clear;
          ListBoxItemsHint.Items.Add('Source=0 随时间减持久');//20090416
          MemoItemsHint.Clear;
          MemoItemsHint.Lines.Text := '源动力是幸运'+#13+
                                      'HP上限和攻击加速是防御上限和下限'+#13+
                                      'MP上限和作用延时是魔御上限和下限'+#13+#13+
                                      'Anicount=202 球王勋章(麻痹、护身、重生属性)';

        end;
    end;
    32: begin
        if FilterItems('31') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          ListBoxItemsHint.Items.Add('98=打捆超强金创药');
          ListBoxItemsHint.Items.Add('99=打捆超强魔法药');
          ListBoxItemsHint.Items.Add('100=超级金创药');
          ListBoxItemsHint.Items.Add('101=超级魔法药');
          ListBoxItemsHint.Items.Add('102=金创药（小）包');
          ListBoxItemsHint.Items.Add('103=魔法药（小）包');
          ListBoxItemsHint.Items.Add('104=金创药（中）包');
          ListBoxItemsHint.Items.Add('105=魔法药（中）包');
          ListBoxItemsHint.Items.Add('106=地牢逃脱卷包');
          ListBoxItemsHint.Items.Add('107=随机传送卷包');
          ListBoxItemsHint.Items.Add('108=回城卷包');
          ListBoxItemsHint.Items.Add('109=行会回城卷包');
          ListBoxItemsHint.Items.Add('110=筹码包');
          ListBoxItemsHint.Items.Add('111=超级符身符');
          ListBoxItemsHint.Items.Add('112=雪霜包');
          ListBoxItemsHint.Items.Add('113=红木包');
          ListBoxItemsHint.Items.Add('114=蓝木包');
          ListBoxItemsHint.Items.Add('115=打捆超红毒');
          ListBoxItemsHint.Items.Add('116=打捆超蓝毒');
          MemoItemsHint.Lines.Text := '装配外观是药品解捆码'+#13+
                                      'Anicount是脚本触发码';
        end;
    end;
    33:begin
        if FilterItems('36') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          ListBoxItemsHint.Items.Add('1=书信、灰木、红木、蓝木等');
        end;
    end;
    34: begin
        if FilterItems('40') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
        end;
    end;
    35: begin
        if FilterItems('41') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          ListBoxItemsHint.Items.Add('0=命运之书、结婚证书');
          ListBoxItemsHint.Items.Add('1=血剑块');
        end;
    end;
    36: begin
        if FilterItems('42') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
        end;
    end;
    37: begin
        if FilterItems('43') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
        end;
    end;
    38: begin
        if FilterItems('44') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          ListBoxItemsHint.Items.Add('0=沃玛号角');
          ListBoxItemsHint.Items.Add('1=祖玛头像、水晶等');

          MemoItemsHint.Lines.Text := '248=斗转灵丹'+#13+
                                      '249=一级见习卷轴'+#13+
                                      '250=二级见习卷轴'+#13+
                                      '251=三级见习卷轴'+#13+
                                      '252=见习神秘卷轴'+#13+
                                      '253=除魔灵媒(品质：保留[Reserved]不能大于228)'+#13+
                                      '254=羊皮卷'+#13+
                                      '255=神秘卷轴';
        end;
    end;
    39: begin
        if FilterItems('45') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          ListBoxItemsHint.Items.Add('0=白菊花');
          ListBoxItemsHint.Items.Add('2=佛牌');
          ListBoxItemsHint.Items.Add('6=骰子');
        end;
    end;
    40: begin
        if FilterItems('46') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          ListBoxItemsHint.Items.Add('0=凭证');
          ListBoxItemsHint.Items.Add('1=筹码、药剂师的信等');
        end;
    end;
    41: begin
        if FilterItems('47') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          MemoItemsHint.Lines.Text := 'Source=127时,可以增加火龙之心的怒气(Reserved*100=增加怒气值)';
        end;
    end;
    42: begin
      if FilterItems('48') then begin
        ListBoxItemsHint.Clear;
        MemoItemsHint.Clear;
        MemoItemsHint.Lines.Text := 'Reserved 0=旧宝箱'+#13+
                                    '         1=新宝箱'+#13+
                                    '         2-九周年宝箱'+#13+#13+
                                    'Source   箱子对应的配置文件名'+#13+#13+
                                    'AniCount 对应钥匙的Shape';
      end;
    end;
    43: begin
      if FilterItems('49') then begin
        ListBoxItemsHint.Clear;
        MemoItemsHint.Clear;
        MemoItemsHint.Lines.Text := 'Reserved 表示购买所需在的元宝数[只能设置0-255]'+#13+#13+
                                    'Anicount 表示一次可以购买的物品个数(天赐类除外)'+#13+#13+
                                    'Shape    对应宝箱的AniCount,才可打开宝箱';
      end;
    end;
    44: begin
        if FilterItems('50') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
        end;
    end;
    45: begin
        if FilterItems('51') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          ListBoxItemsHint.Items.Add('聚灵珠 持久值1=1W');
          ListBoxItemsHint.Items.Add('内功珠 持久值1=1000');
          ListBoxItemsHint.Items.Add('       持久值1-65535');
          ListBoxItemsHint.Items.Add('灵  珠 持久值1=1W');
          ListBoxItemsHint.Items.Add('NeedLevel--为可使用聚集物品的等级');
          ListBoxItemsHint.Items.Add('Need--0-等级达到NeedLevel值后可使用');
          ListBoxItemsHint.Items.Add('      1-等级小于NeedLevel值时可使用');
          MemoItemsHint.Lines.Text := '装配外观=0 聚灵珠(聚集经验) Anicount=1 代表天数'+#13+#13+
                                      '装配外观=1 内功珠(聚集内功经验)'+#13+#13+
                                      '装配外观=2 英雄聚灵珠(聚集经验,双击英雄得经验)'+#13+#13+
                                      '装配外观=3 主宰灵珠(无需聚集,无时间限制,双击英雄得经验,不受英雄等级上限限制) Anicount字段代表使用所需的元宝数 Reserved=255(启用等级限制分配控制)';
        end;
    end;
    46: begin
        if FilterItems('52') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
        end;
    end;
    47: begin
        if FilterItems('53') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
        end;
    end;
    48: begin
        if FilterItems('54') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
        end;
    end;
    49:begin
        if FilterItems('60') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          ListBoxItemsHint.Items.Add('DC1和DC2为酒精度范围(酿酒无效)');
          MemoItemsHint.Lines.Text := 'Anicount 1-普通酒 2-药酒'+#13+
                                      '装配外观(Shape)=酒曲(Shape),酿酒时'+#13+
                                      '才会有可能获得对应的酒曲'+#13+
                                      'NeedLevel--药酒使用所需的酒量值'+#13+#13+
                                      'Shape  0--烧酒'+#13+
                                      '       1-7--普通酒'+#13+
                                      '       8--虎骨酒'+#13+
                                      '       9--金箔酒'+#13+
                                      '       10--活脉酒'+#13+
                                      '       11--玄参酒'+#13+
                                      '       12--蛇胆酒'+#13+
                                      '       13--醉八打'+#13+
                                      '       14--何首养气酒'+#13+
                                      '       15--何首凝神酒'+#13+
                                      '       16--培元酒';
        end;
    end;
    50: begin
        if FilterItems('62') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
        end;
    end;
    51: begin
        if FilterItems('63') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
        end;
    end;
    52: begin
        if FilterItems('64') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
        end;
    end;
  end;
end;
//备份库
procedure TFrmMain.BtnMagicBaseBakClick(Sender: TObject);
begin
  SaveDialog1.Filter := '数据库(*.DB)|*.DB';
  if Sender = BtnMagicBaseBak then begin
     if not FileExists(sGameDirectory + 'Mud2\DB\Magic.DB') then begin
       FrmMain.bsSkinMessage1.MessageDlg('在你的版本目录下没有找到魔法数据库!!',mtInformation,[mbOK],0);
       Exit;
     end;
     if SaveDialog1.Execute then
     CopyFile(PChar(sGameDirectory + 'Mud2\DB\Magic.DB'),PChar(SaveDialog1.FileName),False);
  end;
  if Sender = BtnMobBaseBak then begin
     if not FileExists(sGameDirectory + 'Mud2\DB\Monster.DB') then begin
       FrmMain.bsSkinMessage1.MessageDlg('在你的版本目录下没有找到怪物数据库!!',mtInformation,[mbOK],0);
       Exit;
     end;
     if SaveDialog1.Execute then
     CopyFile(PChar(sGameDirectory + 'Mud2\DB\Monster.DB'),PChar(SaveDialog1.FileName),False);
  end;
  if Sender = BtnItemsBaseBak then begin
     if not FileExists(sGameDirectory + 'Mud2\DB\StdItems.DB') then begin
       FrmMain.bsSkinMessage1.MessageDlg('在你的版本目录下没有找到物品数据库!!',mtInformation,[mbOK],0);
       Exit;
     end;
     if SaveDialog1.Execute then
     CopyFile(PChar(sGameDirectory + 'Mud2\DB\StdItems.DB'),PChar(SaveDialog1.FileName),False);
  end;
  if Sender = BtnFongHaoBaseBak then begin
     if not FileExists(sGameDirectory + 'Mud2\DB\FengHaos.DB') then begin
       FrmMain.bsSkinMessage1.MessageDlg('在你的版本目录下没有找到称号数据库!!',mtInformation,[mbOK],0);
       Exit;
     end;
     if SaveDialog1.Execute then
     CopyFile(PChar(sGameDirectory + 'Mud2\DB\FengHaos.DB'),PChar(SaveDialog1.FileName),False);
  end;
end;
//恢复库
procedure TFrmMain.BtnMagicBaseRestoreClick(Sender: TObject);
begin
  SaveDialog1.Filter := '数据库(*.DB)|*.DB';
  OpenDialog1.Filter := '数据库(*.DB)|*.DB';
  if Sender = BtnMagicBaseRestore then begin
     if OpenDialog1.Execute then
     if bsSkinMessage1.MessageDlg('确定所选文件是你所需的数据库吗？'+#13+'(所选的库将替代现有的库)' ,mtInformation,[mbYes,mbNo],0) = ID_NO then Exit;
     FrmDM.TableMagic.Active := False;
     CopyFile(PChar(OpenDialog1.FileName),PChar(sGameDirectory + 'Mud2\DB\Magic.DB'),False);
     FrmDM.TableMagic.Active := True;
  end;
  if Sender = BtnMobBaseRestore then begin
     if OpenDialog1.Execute then
     if bsSkinMessage1.MessageDlg('确定所选文件是你所需的数据库吗？'+#13+'(所选的库将替代现有的库)' ,mtInformation,[mbYes,mbNo],0) = ID_NO then Exit;
     FrmDM.TableMonster.Active := False;
     CopyFile(PChar(OpenDialog1.FileName),PChar(sGameDirectory + 'Mud2\DB\Monster.DB'),False);
     FrmDM.TableMonster.Active := True;
  end;
  if Sender = BtnItemsBaseRestore then begin
     if OpenDialog1.Execute then
     if bsSkinMessage1.MessageDlg('确定所选文件是你所需的数据库吗？'+#13+'(所选的库将替代现有的库)' ,mtInformation,[mbYes,mbNo],0) = ID_NO then Exit;
     FrmDM.TableStdItems.Active := False;
     CopyFile(PChar(OpenDialog1.FileName),PChar(sGameDirectory + 'Mud2\DB\StdItems.DB'),False);
     FrmDM.TableStdItems.Active := True;
  end;
  if Sender = BtnFongHaoRestore then begin
     if OpenDialog1.Execute then
     if bsSkinMessage1.MessageDlg('确定所选文件是你所需的数据库吗？'+#13+'(所选的库将替代现有的库)' ,mtInformation,[mbYes,mbNo],0) = ID_NO then Exit;
     FrmDM.TableStdItems.Active := False;
     CopyFile(PChar(OpenDialog1.FileName),PChar(sGameDirectory + 'Mud2\DB\FengHaos.DB'),False);
     FrmDM.TableStdItems.Active := True;
  end;
end;
{******************************************************************************}
//以下是颜色配置器代码
function GetRGB(c256: Byte): TColor;
begin
  Move(ColorArray, ColorTable, SizeOf(ColorArray));
  Result := RGB(ColorTable[c256].rgbRed, ColorTable[c256].rgbGreen, ColorTable[c256].rgbBlue);
end;

procedure TFrmMain.TrackEditColor1Change(Sender: TObject);
begin
  RzLabel1.Color := GetRGB(TrackEditColor1.Value);
end;

procedure TFrmMain.TrackEditColor2Change(Sender: TObject);
begin
   RzLabel1.Font.Color := GetRGB(TrackEditColor2.Value);
end;

procedure TFrmMain.FormShow(Sender: TObject);
var
  sProductName: string;
  sVersion: string;
  sBbsSite: string;
begin
  Decode(g_sProductName, sProductName);
  Decode(g_sVersion, sVersion);
  Decode(g_sBbsSite, sBbsSite);
  LabelProductName.Caption := sProductName;
  LabelVersion.Caption := sVersion;
  bsSkinLinkLabel1.Caption := sBbsSite;
  bsSkinLinkLabel1.URL := sBbsSite;
  bsSkinPageControl1.ActivePage:= bsSkinTabSheet1;
end;
{******************************************************************************}
//文本导出函数
Function TFrmMain.ExportTxt(DBGridEh:TDBGrideh;Var TextName:string):BooLean;
Var F:TextFile;
    I:Integer;
    LStrField:String;
    Field: Array of String;
begin
   if DBGridEh.DataSource.DataSet.IsEmpty then
      Raise Exception.Create('没有数据记录无须导出！');
   DBGridEh.DataSource.DataSet.First;
   SetLength(Field,DBGridEh.DataSource.DataSet.FieldCount);
   if FileExists(TextName) then
      if bsSkinMessage1.MessageDlg('该文件已存在,是否覆盖',mtInformation,[mbOK,mbCancel],0) = IdCancel then Abort;
   DBGridEh.DataSource.DataSet.DisableControls;
   AssignFile(F,TextName);
   ReWrite(F);
   try
     try
       While Not DBGridEh.DataSource.DataSet.Eof do begin
         LStrField:='';
         For I:=0 to DBGridEh.DataSource.DataSet.FieldCount-1 do begin
           IF DBGridEh.Columns[I].Visible then  Field[I]:=Trim(DBGridEh.DataSource.DataSet.Fields[I].AsString)+';';
           LStrField:=LStrField+Trim(Field[I]);
         end;
         WriteLn(F,LStrField);
         DBGridEh.DataSource.DataSet.Next;
       end;
       Result:=True;
     Except
       Result:=False;
     end;
   finally
     CloseFile(F);
     DBGridEh.DataSource.DataSet.EnableControls;
   end;
end;
//文本单行导出
Function TFrmMain.ExportTxt1(DBGridEh:TDBGrideh;Var TextName:string):BooLean;
var J:integer;
    S:string;
    F:TextFile;
begin
  if DBGridEh.SelectedField = nil then
    Raise Exception.Create('没有数据记录无须导出！');

   AssignFile(F,TextName);
   ReWrite(F);
   try
     try
      with DBGridEh.DataSource.DataSet do begin
        for J := 0 to DBGridEh.FieldCount-1 do begin
          S:= S + DBGridEh.Fields[J].AsString+';';
        end;
        WriteLn(F,S);
      end;
     Result:=True;
     Except
       Result:=False;
     end;
   finally
     CloseFile(F);
   end;
end;

procedure TFrmMain.bsSkinButton7Click(Sender: TObject);
var
  Filename: STRING;
begin
  if FrmDM.TableStdItems.RecordCount = 0 then
  Begin
   //Application.MessageBox(#13'没有可导出的数据,请复核!!!', MBInfo, 16+MB_OK);
   bsSkinMessage1.MessageDlg('没有可导出的数据,请复核!!!',mtInformation,[mbOK],0);
   Exit;
  end;
  SaveDialog1.Filter:='文本文件(*.txt)|*.txt';
  if Not SaveDialog1.Execute then Exit;
  Filename:=SaveDialog1.FileName ;
  if ExportTxt(ItemsDBGrid,Filename) then
    bsSkinMessage1.MessageDlg('物品数据导出成功!!!',mtInformation,[mbOK],0);//Application.MessageBox('物品数据导出成功!!!', MBInfo, 64+MB_OK);
end;

procedure TFrmMain.N5Click(Sender: TObject);
var
  Filename: STRING;
begin
  IF ItemsDBGrid.DataSource=nil then Exit;
  SaveDialog1.Filter:='文本文件(*.txt)|*.txt';
  if Not SaveDialog1.Execute then Exit;
  Filename:=SaveDialog1.FileName ;

  case bsSkinPageControl2.TabIndex of
    0:begin
       if FrmDM.TableMagic.RecordCount = 0 then
          Begin
           //Application.MessageBox(#13'没有可导出的数据,请复核!!!', MBInfo, 16+MB_OK);
           bsSkinMessage1.MessageDlg('没有可导出的数据,请复核!!!',mtInformation,[mbOK],0);
           Exit;
          end;
       if ExportTxt1(MagicDBGrid,Filename) then bsSkinMessage1.MessageDlg('技能数据导出成功!!!',mtInformation,[mbOK],0);//Application.MessageBox('技能数据导出成功!!!', MBInfo, 64+MB_OK);
      end;
    1:begin
        if FrmDM.TableMonster.RecordCount = 0 then
          Begin
           //Application.MessageBox(#13'没有可导出的数据,请复核!!!', MBInfo, 16+MB_OK);
           bsSkinMessage1.MessageDlg('没有可导出的数据,请复核!!!',mtInformation,[mbOK],0);
           Exit;
          end;
       if ExportTxt1(MobDBGrid,Filename) then
          bsSkinMessage1.MessageDlg('物怪数据导出成功!!!',mtInformation,[mbOK],0);//Application.MessageBox('物怪数据导出成功!!!', MBInfo, 64+MB_OK);
      end;
    2:begin
        if FrmDM.TableStdItems.RecordCount = 0 then
          Begin
           //Application.MessageBox(#13'没有可导出的数据,请复核!!!', MBInfo, 16+MB_OK);
           bsSkinMessage1.MessageDlg('没有可导出的数据,请复核!!!',mtInformation,[mbOK],0);
           Exit;
          end;
       if ExportTxt1(ItemsDBGrid,Filename) then
          bsSkinMessage1.MessageDlg('物品数据导出成功!!!',mtInformation,[mbOK],0);//Application.MessageBox('物品数据导出成功!!!', MBInfo, 64+MB_OK);
      end;
    3: begin
        if FrmDM.TableFongHao.RecordCount = 0 then Begin
          //Application.MessageBox(#13'没有可导出的数据,请复核!!!', MBInfo, 16+MB_OK);
          bsSkinMessage1.MessageDlg('没有可导出的数据,请复核!!!',mtInformation,[mbOK],0);
          Exit;
        end;
        if ExportTxt1(FongHaoDBGrid,Filename) then
          bsSkinMessage1.MessageDlg('称号数据导出成功!!!',mtInformation,[mbOK],0);//Application.MessageBox('物品数据导出成功!!!', MBInfo, 64+MB_OK);
      end;
  end;
end;

procedure TFrmMain.bsSkinButton12Click(Sender: TObject);
var
  Filename: STRING;
begin
  IF MagicDBGrid.DataSource=nil then Exit;
  if FrmDM.TableMagic.RecordCount = 0 then
  Begin
   bsSkinMessage1.MessageDlg('没有可导出的数据,请复核!!!',mtInformation,[mbOK],0);
   Exit;
  end;
  SaveDialog1.Filter:='文本文件(*.txt)|*.txt';
  if Not SaveDialog1.Execute then Exit;
  Filename:=SaveDialog1.FileName ;
  if ExportTxt(MagicDBGrid,Filename) then
     bsSkinMessage1.MessageDlg('技能数据导出成功!!!',mtInformation,[mbOK],0);//Application.MessageBox('技能数据导出成功!!!', MBInfo, 64+MB_OK);
end;

procedure TFrmMain.bsSkinButton10Click(Sender: TObject);
begin
  if bsSkinEdit1.Text = '' then Exit;
  with FrmDM.TableFongHao do begin
    if not Eof then begin
      EditKey;
      DisableControls;
      while not Eof do begin
        if pos(Trim(bsSkinEdit1.Text), FieldByName('Name').AsString)   <=   0   then Next
        else Break;
      end;
      EnableControls;
    end;
  end;
end;

procedure TFrmMain.bsSkinButton11Click(Sender: TObject);
var
  Filename: STRING;
begin
  IF MobDBGrid.DataSource=nil then Exit;
  if FrmDM.TableMonster.RecordCount = 0 then
  Begin
   bsSkinMessage1.MessageDlg('没有可导出的数据,请复核!!!',mtInformation,[mbOK],0);
   Exit;
  end;
  SaveDialog1.Filter:='文本文件(*.txt)|*.txt';
  if Not SaveDialog1.Execute then Exit;
  Filename:=SaveDialog1.FileName ;
  if ExportTxt(MobDBGrid,Filename) then
     bsSkinMessage1.MessageDlg('物怪数据导出成功!!!',mtInformation,[mbOK],0);
end;
{******************************************************************************}
//以下是报表代码
procedure TFrmMain.BeforePrint();
begin
 {if Printer.Printers.Count = 0 then begin
   bsSkinMessage1.MessageDlg('需要安装打印机才能打印!!!',mtInformation,[mbOK],0);
   Abort;
  end; }
  PrintDBGridEh1.PageFooter.CenterText.Add('第&[Page]页 共&[Pages]页');
  PrintDBGridEh1.PageHeader.CenterText.Clear;
  {标题的字体设置}
  PrintDBGridEh1.PageHeader.Font.Size:=16;                //大小
  PrintDBGridEh1.PageHeader.Font.Name:='宋体';            //字体
  PrintDBGridEh1.PageHeader.Font.Charset:=GB2312_CHARSET; //字符集
  PrintDBGridEh1.PageHeader.Font.Style:=[fsBold];         //字体加粗
end;

procedure TFrmMain.bsSkinButton15Click(Sender: TObject);
begin
  PrintDBGridEh1.DBGridEh:=MagicDBGrid;
  BeforePrint();
  PrintDBGridEh1.PageHeader.CenterText.Add('3K科技--技能数据');
  PrintDBGridEh1.Preview;
end;

procedure TFrmMain.bsSkinButton16Click(Sender: TObject);
var
  Filename: STRING;
begin
  if FrmDM.TableFongHao.RecordCount = 0 then Begin
   bsSkinMessage1.MessageDlg('没有可导出的数据,请复核!!!',mtInformation,[mbOK],0);
   Exit;
  end;
  SaveDialog1.Filter:='文本文件(*.txt)|*.txt';
  if Not SaveDialog1.Execute then Exit;
  Filename:=SaveDialog1.FileName ;
  if ExportTxt(FongHaoDBGrid,Filename) then
    bsSkinMessage1.MessageDlg('称号数据导出成功!!!',mtInformation,[mbOK],0);//Application.MessageBox('物品数据导出成功!!!', MBInfo, 64+MB_OK);
end;

procedure TFrmMain.bsSkinButton17Click(Sender: TObject);
begin
  PrintDBGridEh1.DBGridEh:=FongHaoDBGrid;
  BeforePrint();
  PrintDBGridEh1.PageHeader.CenterText.Add('3K科技--称号数据');
  PrintDBGridEh1.Preview;
end;

procedure TFrmMain.bsSkinButton14Click(Sender: TObject);
begin
  PrintDBGridEh1.DBGridEh:=MobDBGrid;
  BeforePrint();
  PrintDBGridEh1.PageHeader.CenterText.Add('3K科技--怪物数据');
  PrintDBGridEh1.Preview;
end;

procedure TFrmMain.bsSkinButton13Click(Sender: TObject);
begin
  PrintDBGridEh1.DBGridEh:=ItemsDBGrid;
  BeforePrint();
  PrintDBGridEh1.PageHeader.CenterText.Add('3K科技--物品数据');
  PrintDBGridEh1.Preview;
end;
{******************************************************************************}



procedure TFrmMain.bsSkinButtonLabel1Click(Sender: TObject);
begin
  FrmAbout := TFrmAbout.Create(Owner);
  FrmAbout.Open();
  FrmAbout.Free;
end;

procedure TFrmMain.BtnAlterMagicExpClick(Sender: TObject);
var
  str,SQLstr: string;
begin
  if bsSkinCheckRadioBox1.Checked then str:=' L1Train='+ FloatToStr(bsSkinSpinEdit1.Value)
  else if bsSkinCheckRadioBox2.Checked then str:=' L2Train='+ FloatToStr(bsSkinSpinEdit1.Value)
  else if bsSkinCheckRadioBox3.Checked then str:=' L3Train='+ FloatToStr(bsSkinSpinEdit1.Value);
  SQLstr:='Update Magic set '+ str;
  with FrmDM.Query1 do begin
    close;
    Sql.Clear;
    sql.Add(Sqlstr);
    ExecSql;
  end;
  FrmDM.TableMagic.Refresh;
end;
//----------------------------------------------------------------------------
//Wil编辑器
function TFrmMain.Extractrec(Restype,ResName,ResNewNAme:string):boolean;
var
  Res:TResourceStream;
Begin
  Res:=TResourceStream.Create(HinStance,ResName,Pchar(ResType));
  Res.SaveToFile(ResNewName);
  Res.Free;
  Result:=True;
End;

procedure TFrmMain.FillInfo(index:Integer);
var
  Width1,Height1:Integer;
  zoom,zoom1:real;
begin
  zoom:= 0;
  zoom1:=0;
  if Wil.Stream<>nil then begin
      BMpIndex:=Index;
      BmpTran:=checkboxTransparent.Checked;
      MainBitMap:=Wil.Bitmaps[index];
      Width1:=Wil.Width;
      Height1:=WIl.Height;
      if CheckBoxjump.Checked then begin
        While ((Width1<=1) or (Height1<=1))and (BmpIndex<Wil.ImageCount-1) do Begin
          Inc(BmpIndex);
          Width1:=Wil.Bitmaps[Bmpindex].Width;
          Height1:=WIl.Bitmaps[Bmpindex].Height;
        End;
      End;
      if RbAuto.Checked then Begin
        if (Width1<PaintBox1.Width) and (Height1<Paintbox1.Height) then Begin
         BmpZoom:=1;
         if checkboxXY.Checked then Begin
           Bmpx:=Paintbox1.Width div 2 +WIl.px;
           Bmpy:=PaintBox1.Height div 2+Wil.py;
         End Else Begin
           Bmpx:=(Paintbox1.Width-Width1) div 2;
           Bmpy:=(Paintbox1.Height-Height1) div 2;
         end;
        End else Begin
          if Width1>PaintBox1.Width then Zoom:=Width1/PaintBox1.Width;
          if Height1>PaintBox1.Height then Zoom1:=Height1/PaintBox1.Height;
          if zoom>zoom1 then BmpZoom:=Zoom
          else Bmpzoom:=Zoom1;
          bmpx:=1;
          Bmpy:=1;
        End;
      End else Begin
         if Rb50.Checked then BmpZoom:=0.5;
         if Rb100.Checked then BmpZoom:=1;
         if Rb200.Checked then BmpZoom:=2;
         if Rb400.Checked then BmpZoom:=4;
         if Rb800.Checked then BmpZoom:=8;
         bmpx:=1;
         Bmpy:=1;
        Paintbox1.Width:=ScrollBox1.Width-5;
        PaintBox1.Height:=ScrollBox1.Height-5;
        Width1:=Round(Width1*BMpZoom);
        Height1:=Round(Height1*BmpZoom);
        if (Width1<PaintBox1.Width) and (Height1<Paintbox1.Height) then Begin
         if checkboxXY.Checked then Begin
           Bmpx:=Paintbox1.Width div 2 +WIl.px;
           Bmpy:=PaintBox1.Height div 2+Wil.py;
         End Else Begin
           Bmpx:=(Paintbox1.Width-width1) div 2;
           Bmpy:=(Paintbox1.Height-Height1) div 2;
         end;
        End else Begin
          PaintBox1.Width:=Width1;
          PaintBox1.Height:=Height1;
        End;
      End;

      Labelx.Caption:=InttoStr(Wil.px);
      Labely.Caption:=InttoStr(Wil.py);
      LabelSize.Caption:=Inttostr(Width1)+'*'+Inttostr(Height1);
      LabelIndex.Caption:=Inttostr(Index)+'/'+Inttostr(WIl.ImageCount-1);
      case WIl.FileType of
       0: LabelType.Caption:='MIR2 格式(1)';
       1: LabelType.Caption:='MIR2 格式(2)';
       2:Begin
         if WIl.OffSet=0 then LabelType.Caption:='EI3 格式(1)'
         else LabelType.Caption:='EI3 格式(2)';
       End;
      end;
      LabelColorCount.Caption := '颜色('+ IntToStr(Wil.FileColorCount)+')';
      PaintBox1.Refresh;
      if Wil.FileType=2 then Begin
        BtnAllInput.Enabled:=False;
        BtnAllOut.Enabled:=True;
        Btnout.Enabled:=True;
        BtnInput.Enabled:=False;
        BtnAdd.Enabled:=False;
        BtnUp.Enabled:=True;
        BtnDown.Enabled:=True;
        BtnJump.Enabled:=True;
        BtnStop.Enabled:=True;
        BtnAutoPlay.Enabled:=True;
        BtnCreate.Enabled:=True;
        BtnStop.Enabled:=True;
        btndelete.Enabled:=False;
        btnx.Enabled:=False;
        Btny.Enabled:=False;
      End else Begin
        Btnx.Enabled:=True;
        Btny.Enabled:=True;
        btndelete.Enabled:=True;
        BtnUp.Enabled:=True;
        BtnDown.Enabled:=True;
        BtnJump.Enabled:=True;
        BtnStop.Enabled:=True;
        BtnAdd.Enabled:=True;
        BtnAllInput.Enabled:=True;
        BtnAllOut.Enabled:=True;
        BtnAutoPlay.Enabled:=True;
        BtnCreate.Enabled:=True;
        Btnout.Enabled:=True;
        BtnStop.Enabled:=True;
        BtnInput.Enabled:=True;
      End;

      if Index=(WIl.ImageCount-1) then Begin
        BtnDown.Enabled:=False;
        BtnUp.Enabled:=True;
      End;
      if Index=0 then  BtnUp.Enabled:=False;
      DrawGrid1.Row:=BmpIndex div 6;
      Drawgrid1.Col:=BmpIndex mod 6;
  End;
End;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  Wil:=TWil.Create(self);
end;

procedure TFrmMain.FormPaint(Sender: TObject);
begin
  PaintBox1.Refresh;
end;

procedure TFrmMain.PaintBox1Paint(Sender: TObject; Canvas: TCanvas);
begin
 if Wil.Stream<>nil then
 Begin
   Wil.DrawZoom(Canvas,Bmpx,Bmpy,BmpINdex,BmpZoom,BmpTran,false);

 End;
 if CheckBoxzuobiao.Checked then
 Begin
   Canvas.Pen.Style:=psDot;
   Canvas.MoveTo(0,Paintbox1.Height div 2);
   Canvas.LineTo(Paintbox1.Width,Paintbox1.Height div 2);
   Canvas.MoveTo(Paintbox1.Width div 2,0);
   Canvas.LineTo(Paintbox1.Width div 2,Paintbox1.Height);
 End;
end;

procedure TFrmMain.DrawGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  Index:integer;
  w,h:integer;
  str:string;
begin
  index:=ARow*6+ACol;
  if (Wil.Stream<>nil) and (Index<wil.ImageCount) then Begin
    Wil.DrawZoomEx(DrawGrid1.Canvas,Rect,index,true);
    Str:=format('%.5d',[index]);
    DrawGrid1.Canvas.Brush.Style:=bsclear;
    w:=DrawGrid1.Canvas.TextWidth(str);
    h:=DrawGrid1.Canvas.TextHeight(str);
    DrawGrid1.Canvas.TextOut(Rect.Right-w-1,Rect.Bottom-h-1,str);
    if State<>[] then FillInfo(Index);
  End;
end;

procedure TFrmMain.btnupClick(Sender: TObject);
begin
 if Wil.Stream<>nil then Begin
   Dec(BmpIndex);
   if BmpIndex < 0 then BmpIndex:=0;
   FillInfo(BmpIndex);
 end;
end;

procedure TFrmMain.btndownClick(Sender: TObject);
begin
 if Wil.Stream <> nil then Begin
   Inc(BmpIndex);
   if BmpIndex > Wil.ImageCount then  BmpIndex:=Wil.ImageCount;
   FillInfo(BmpIndex);
 End;
end;

procedure TFrmMain.btnxClick(Sender: TObject);
var
  x:smallint;
  code:Integer;
  Str:string;
Begin
  str:= InputDialog.InputBox('更改图片横坐标','请输入图片横坐标：','1');
  if str='' then exit;
  val(str,x,code);
  if code > 0 then Begin
     bsSkinMessage1.MessageDlg('请输入正确的格式',mtInformation,[mbOK],0);
     exit;
  End;
  Wil.Changex(BmpIndex,x);
  FillInfo(BmpIndex);
end;

procedure TFrmMain.btnyClick(Sender: TObject);
var
  x:smallint;
  code:Integer;
  Str:string;
Begin
  str:= InputDialog.InputBox('更改图片横坐标','请输入图片横坐标：','1');
  if str='' then exit;
  val(str,x,code);
  if code > 0 then Begin
     bsSkinMessage1.MessageDlg('请输入正确的格式',mtInformation,[mbOK],0);
     exit;
  End;
  Wil.Changey(BmpIndex,x);
  FillInfo(BmpIndex);
end;

procedure TFrmMain.Rb50Click(Sender: TObject);
begin
  FillInfo(BmpIndex);
end;

procedure TFrmMain.BtnJumpClick(Sender: TObject);
var
  Index,Code:Integer;
  str:string;
begin
  if Wil.Stream <> nil then Begin
    str:= InputDialog.InputBox('跳转','请输入图片索引号：','');
    if str=''	then exit;
    val(str,index,code);
    if (Index>=0) and (Index<Wil.ImageCount) then FillInfo(Index);
  end;
end;

procedure TFrmMain.BtnAutoPlayClick(Sender: TObject);
begin
  Stop:=False;
  Timer1.Enabled:= True;
end;

procedure TFrmMain.btnstopClick(Sender: TObject);
begin
  Stop:= True;
  Timer1.Enabled:= False;
end;

procedure TFrmMain.btninputClick(Sender: TObject);
var
  FileName:String;
  BitMap:TBitMap;
begin
  if OpenPictureDialog1.Execute then FileName:=OpenPictureDialog1.FileName;
  Application.ProcessMessages;

  if (FileName<>'') then Begin
    Image1.Picture.LoadFromFile(FileName);
    BitMap:=Image1.Picture.Bitmap;
  if WIl.ReplaceBitMap(BmpIndex,BitMap) then
     bsSkinMessage1.MessageDlg('导入图片成功！',mtInformation,[mbOK],0)
  else
    bsSkinMessage1.MessageDlg('导入图片失败！',mtInformation,[mbOK],0);
  end Else bsSkinMessage1.MessageDlg('导入图片失败！',mtInformation,[mbOK],0);
end;

procedure TFrmMain.BtnOutClick(Sender: TObject);
var
  FileName:String;
begin
  if WIl.Stream <> nil then Begin
    SavePictureDialog1.FileName:=format('%.6d.bmp',[BmpIndex]);
    if SavePictureDialog1.Execute then FileName:=SavePictureDialog1.FileName;
    if FileName<>'' then Begin
      Wil.Bitmaps[BmpIndex].SaveToFile(FileName);
      bsSkinMessage1.MessageDlg('导出图片成功！',mtInformation,[mbOK],0)
    end;
  end;
end;

procedure TFrmMain.btndeleteClick(Sender: TObject);
begin
  FormDel := TFormDel.Create(Owner);
  FormDel.ShowModal;
  FormDel.Free;
end;

procedure TFrmMain.btnAddClick(Sender: TObject);
begin
  if Wil.Stream <> nil then begin
    FrmAddOneWil := TFrmAddOneWil.Create(Owner);
    FrmAddOneWil.ShowModal;
    FrmAddOneWil.Free;
  end;
end;

procedure TFrmMain.btnCreateClick(Sender: TObject);
begin
  FrmNewWil := TFrmNewWil.Create(Owner);
  FrmNewWil.ShowModal;
  FrmNewWil.Free;
end;

procedure TFrmMain.btnallinputClick(Sender: TObject);
begin
  if WIl.Stream <> nil then begin
     FrmAddWil := TFrmAddWil.Create(Owner);
     FrmAddWil.EditEnd.Text:=Inttostr(Wil.ImageCount-1);
     FrmAddWil.EditPicPath.Text:='';
     FrmAddWil.ShowModal;
     FrmAddWil.Free;
  end;
end;

procedure TFrmMain.btnallOutClick(Sender: TObject);
begin
 if WIl.Stream <> nil then Begin
    FrmOutWil := TFrmOutWil.Create(Owner);
    FrmOutWil.EditPicPath.Text:='';
    FrmOutWil.editBegin.Text:='0';
    FrmOutWil.EditEnd.Text:=Inttostr(wil.ImageCount-1);
    FrmOutWil.ShowModal;
    FrmOutWil.Free;
 end;
end;

procedure TFrmMain.Timer1Timer(Sender: TObject);
begin
  if (BmpIndex >= WIl.ImageCount-1) or Stop then Timer1.Enabled:=False;
  Inc(BmpIndex);
  FillInfo(BmpIndex);
end;

procedure TFrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  application.Terminate;
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
  FrmMain:= nil;
  application.Terminate;
end;

procedure TFrmMain.EditFileNameButtonClick(Sender: TObject);
  function SaveConfig: Boolean;
  var
    MyIni: TIniFile;
  begin
    Result := False;
    MyIni:= TIniFile.Create(ConfigFileName);
    MyIni.WriteString('SYSTEM','WilDirectory',sWilDirectory);
    MyIni.Free;
    Result := True;
  end;
begin
  OpenDialog1.Filter := 'Wil文件(*.Wil)|*.Wil';
  OpenDialog1.InitialDir := sWilDirectory;
  if OpenDialog1.Execute then begin
    EditFileName.Text:= OPenDialog1.FileName;
    sWilDirectory:= ExtractFilePath(EditFileName.Text);
    SaveConfig;
    if FileExists(EditFileName.Text) then begin
      if Wil.Stream<>nil then Wil.Finalize;
      Wil.FileName:=EditFileName.Text;
      Wil.Initialize;
      if wil.Stream= nil then begin
         bsSkinMessage1.MessageDlg('WIl文件已经被破坏或不是wil文件！',mtInformation,[mbOK],0);
         Exit;
      end;
      BmpIndex:=0;
      DrawGrid1.RowCount:=(Wil.ImageCount div 6)+1;
      DrawGrid1.Refresh;
      FillInfo(BmpIndex);
    end;
  end;
end;

procedure TFrmMain.bsSkinFileEdit1ButtonClick(Sender: TObject);
begin
  if bsSkinSelectDirectoryDialog1.Execute then begin
    bsSkinFileEdit1.Text:= bsSkinSelectDirectoryDialog1.Directory;
    if bsSkinFileEdit1.Text <> '' then bsSkinButton1.Enabled:= True;
  end;
end;
//物品数据库扩展 20080619
procedure TFrmMain.bsSkinButton1Click(Sender: TObject);
  function GetParadoxConnectionString(Path: string; Password: string): string;
  var
    s: string;
  begin
    s := 'Provider=Microsoft.Jet.OLEDB.4.0;';
    s := s + 'Data Source=' + Path + ';';
    s := s + 'Extended Properties=Paradox 7.x;Persist Security Info=False;';
    s := s + 'Mode=Share Deny None;';
    if Password <> '' then
      s := s + 'Jet OLEDB:Database Password=' + Password;
    Result := s;
  end;
var
  DestTable:TTable;
  ADOA: TAdoquery;
  I: Integer;
begin
  bsSkinCheckRadioBox4.Enabled := False;
  DestTable:=TTable.Create(Application);
  try
    FrmDM.TableStdItems.Open;
    with DestTable do begin
      FieldDefs.Assign(FrmDM.TableStdItems.FieldDefs);//复制表结构
      DataBaseName:= bsSkinFileEdit1.text;//保存路径
      TableName:='NewStdItems';//数据库名
      TableType:=ttParadox;//数据库类型
      CreateTable;//创建新的数据表
    end;

    if FrmDM.TableStdItems.findfield('Desc') = nil  then begin//判断字段是否存在
      ADOA:=TADOQUERY.Create(nil);
      with ADOA do begin
        ConnectionString:=GetParadoxConnectionString(bsSkinFileEdit1.text,'');
        SQL.Add('ALTER TABLE NewStdItems ADD [Desc] CHAR(80)');
        ExecSQL;
      end;
      ADOA.Free;
    end;

    DestTable.Open;
    FrmDM.Query1.DataBaseName:=DBEName;
    with FrmDM.Query1 do begin
      close;
      sql.Clear ;
      sql.add('select * from StdItems order by idx  DESC');
      open;
      First;
      I:= FrmDM.Query1.RecordCount - 1;
      while not FrmDM.Query1.Eof do begin
        with DestTable  do begin
          Insert;
          if boIsSort then FieldByName('Idx').AsInteger:= I
          else FieldByName('Idx').AsInteger:= FrmDM.Query1.FieldByName('Idx').AsInteger;
          FieldByName('Name').AsString:=FrmDM.Query1.FieldByName('Name').AsString;
          FieldByName('StdMode').AsInteger:=FrmDM.Query1.FieldByName('StdMode').AsInteger;
          FieldByName('Shape').AsInteger:=FrmDM.Query1.FieldByName('Shape').AsInteger;//装备外观
          FieldByName('Weight').AsInteger:=FrmDM.Query1.FieldByName('Weight').AsInteger;//重量
          FieldByName('AniCount').AsInteger:= FrmDM.Query1.FieldByName('AniCount').AsInteger;
          FieldByName('Source').AsInteger:= FrmDM.Query1.FieldByName('Source').AsInteger;
          FieldByName('Reserved').AsInteger:= FrmDM.Query1.FieldByName('Reserved').AsInteger;//保留
          FieldByName('Looks').AsInteger:= FrmDM.Query1.FieldByName('Looks').AsInteger;//物品外观
          FieldByName('DuraMax').AsInteger:= FrmDM.Query1.FieldByName('DuraMax').AsInteger;
          FieldByName('Ac').AsInteger:=FrmDM.Query1.FieldByName('Ac').AsInteger;
          FieldByName('Ac2').AsString:=FrmDM.Query1.FieldByName('Ac2').AsString;
          FieldByName('Mac').AsInteger:=FrmDM.Query1.FieldByName('Mac').AsInteger;
          FieldByName('Mac2').AsInteger:=FrmDM.Query1.FieldByName('Mac2').AsInteger;
          FieldByName('Dc').AsInteger:=FrmDM.Query1.FieldByName('Dc').AsInteger;
          FieldByName('DC2').AsInteger:= FrmDM.Query1.FieldByName('DC2').AsInteger;
          FieldByName('Mc').AsInteger:= FrmDM.Query1.FieldByName('Mc').AsInteger;
          FieldByName('Mc2').AsInteger:= FrmDM.Query1.FieldByName('Mc2').AsInteger;
          FieldByName('Sc').AsInteger:= FrmDM.Query1.FieldByName('Sc').AsInteger;
          FieldByName('Sc2').AsInteger:= FrmDM.Query1.FieldByName('Sc2').AsInteger;
          FieldByName('Need').AsInteger:= FrmDM.Query1.FieldByName('Need').AsInteger;
          FieldByName('NeedLevel').AsInteger:= FrmDM.Query1.FieldByName('NeedLevel').AsInteger;
          FieldByName('Stock').AsInteger:= FrmDM.Query1.FieldByName('Stock').AsInteger;
          FieldByName('Price').AsInteger:= FrmDM.Query1.FieldByName('Price').AsInteger;
          post;
          if boIsSort then Dec(I);
        end;
        FrmDM.Query1.Next;
      end;
    end;
  finally
    DestTable.Free;
  end;
  bsSkinMessage1.MessageDlg('物品数据库扩展完成！'+bsSkinFileEdit1.text+'\NewStdItems.db',mtInformation,[mbOK],0);
  bsSkinButton1.Enabled:= False;
  bsSkinCheckRadioBox4.Enabled := True;
end;

procedure TFrmMain.bsSkinCheckRadioBox4Click(Sender: TObject);
begin
  boIsSort:= bsSkinCheckRadioBox4.Checked;
end;

procedure TFrmMain.bsSkinTabSheet2Show(Sender: TObject);
begin
  boIsSort:= bsSkinCheckRadioBox4.Checked;
end;

procedure TFrmMain.bsSkinTabSheet7Show(Sender: TObject);
begin
          ListBoxFongHaoHint.Clear;
          ListBoxFongHaoHint.Items.Add('0=一般称号');
          ListBoxFongHaoHint.Items.Add('1=水晶之星(免费千里传音)');
          ListBoxFongHaoHint.Items.Add('2=主宰龙卫');
          ListBoxFongHaoHint.Items.Add('3=护花使者');
          ListBoxFongHaoHint.Items.Add('4=不动如山(冲撞技能+10级)');
          ListBoxFongHaoHint.Items.Add('5=巅峰勇士(随机攻击倍数,死亡3次或0点时状态消失');
          ListBoxFongHaoHint.Items.Add('           时间设置无效 DC=最低倍数 DC2-最高倍数)');
          ListBoxFongHaoHint.Items.Add('6=热血使者(玩家(为队长),同地图时所有队员打怪经验翻倍)');
          ListBoxFongHaoHint.Items.Add('7=传奇之星(魔法盾,烈火剑法,神圣战甲术,幽灵盾变成粉红色)');
          ListBoxFongHaoHint.Items.Add('8=行会之星(退出行会称号消失)');
          ListBoxFongHaoHint.Items.Add('9=玛法主宰者(随意传送地图)');
          ListBoxFongHaoHint.Items.Add('10=高级巅峰勇士(随机攻击倍数,不受死亡次数限制');
          ListBoxFongHaoHint.Items.Add('                DC=最低倍数 DC2-最高倍数)');
          ListBoxFongHaoHint.Items.Add('11=0点消失称号(时间设置无效)');
          MemoFongHaoHint.Clear;
          MemoFongHaoHint.Lines.Text := 'Shape  =预留'+#13+
                                        'Anicount=称号特殊效果'+#13+
                                        'nHours =称号时限(小时) 65535-永久'+#13+
                                        'Looks  =称号的内观'+#13+
                                        'AC     =体力上限'+#13+
                                        'AC2    =强身等级'+#13+
                                        'MAC    =内伤等级'+#13+
                                        'MAC2   =暴击等级'+#13+
                                        'DC     =麻痹抗性'+#13+
                                        'DC2    =攻击上限'+#13+
                                        'MC     =聚魔等级'+#13+
                                        'MC2    =魔法上限'+#13+
                                        'SC     =合击威力'+#13+
                                        'SC2    =道术上限'+#13+#13+
                                        'Need(附加条件)'+#13+
                                        '0:需等级   NeedLevel=等级'+#13+
                                        '1:需攻击力 NeedLevel=攻击力'+#13+
                                        '2:需魔法   NeedLevel=魔法'+#13+
                                        '3:需道术   NeedLevel=道术';
end;

procedure TFrmMain.bsSkinButton2Click(Sender: TObject);
  function GetParadoxConnectionString(Path: string; Password: string): string;
  var
    s: string;
  begin
    s := 'Provider=Microsoft.Jet.OLEDB.4.0;';
    s := s + 'Data Source=' + Path + ';';
    s := s + 'Extended Properties=Paradox 7.x;Persist Security Info=False;';
    s := s + 'Mode=Share Deny None;';
    if Password <> '' then
      s := s + 'Jet OLEDB:Database Password=' + Password;
    Result := s;
  end;
var
  DestTable:TTable;
  KK: TFieldDef;
begin
  DestTable:=TTable.Create(Application);
  try
    FrmDM.TableMonster.Open;
    with DestTable do begin
      FieldDefs.Assign(FrmDM.TableMonster.FieldDefs);//复制表结构
      DataBaseName:= bsSkinFileEdit2.text;//保存路径
      KK:= FieldDefs.Find('HP');
      KK.DataType:= ftInteger;//修改HP为Integer类型
      TableName:='NewMonster';//数据库名
      TableType:=ttParadox;//数据库类型
      CreateTable;//创建新的数据表
    end;

    DestTable.Open;
    FrmDM.Query1.DataBaseName:=DBEName;
    with FrmDM.Query1 do begin
      close;
      sql.Clear ;
      sql.add('select * from Monster order by Name DESC');
      open;
      First;
      //I:= FrmDM.Query1.RecordCount - 1;
      while not FrmDM.Query1.Eof do begin
        with DestTable  do begin
          Insert;
          FieldByName('Name').AsString:=FrmDM.Query1.FieldByName('Name').AsString;
          FieldByName('Race').AsInteger:=FrmDM.Query1.FieldByName('Race').AsInteger;
          FieldByName('RaceImg').AsInteger:=FrmDM.Query1.FieldByName('RaceImg').AsInteger;
          FieldByName('Appr').AsInteger:=FrmDM.Query1.FieldByName('Appr').AsInteger;
          FieldByName('Lvl').AsInteger:= FrmDM.Query1.FieldByName('Lvl').AsInteger;
          FieldByName('Undead').AsInteger:= FrmDM.Query1.FieldByName('Undead').AsInteger;
          FieldByName('CoolEye').AsInteger:= FrmDM.Query1.FieldByName('CoolEye').AsInteger;
          FieldByName('Exp').AsInteger:= FrmDM.Query1.FieldByName('Exp').AsInteger;
          FieldByName('HP').AsInteger:= FrmDM.Query1.FieldByName('HP').AsInteger;
          FieldByName('MP').AsInteger:=FrmDM.Query1.FieldByName('MP').AsInteger;
          FieldByName('AC').AsString:=FrmDM.Query1.FieldByName('AC').AsString;
          FieldByName('MAC').AsInteger:=FrmDM.Query1.FieldByName('MAC').AsInteger;
          FieldByName('DC').AsInteger:=FrmDM.Query1.FieldByName('DC').AsInteger;
          FieldByName('DCMAX').AsInteger:=FrmDM.Query1.FieldByName('DCMAX').AsInteger;
          FieldByName('MC').AsInteger:= FrmDM.Query1.FieldByName('MC').AsInteger;
          FieldByName('SC').AsInteger:= FrmDM.Query1.FieldByName('SC').AsInteger;
          FieldByName('SPEED').AsInteger:= FrmDM.Query1.FieldByName('SPEED').AsInteger;
          FieldByName('HIT').AsInteger:= FrmDM.Query1.FieldByName('HIT').AsInteger;
          FieldByName('WALK_SPD').AsInteger:= FrmDM.Query1.FieldByName('WALK_SPD').AsInteger;
          FieldByName('WalkStep').AsInteger:= FrmDM.Query1.FieldByName('WalkStep').AsInteger;
          FieldByName('WalkWait').AsInteger:= FrmDM.Query1.FieldByName('WalkWait').AsInteger;
          FieldByName('ATTACK_SPD').AsInteger:= FrmDM.Query1.FieldByName('ATTACK_SPD').AsInteger;
          post;
        end;
        FrmDM.Query1.Next;
      end;
    end;
  finally
    DestTable.Free;
  end;
  bsSkinMessage1.MessageDlg('数据库扩展完成！'+bsSkinFileEdit2.text+'\NewMonster.db',mtInformation,[mbOK],0);

end;

procedure TFrmMain.bsSkinFileEdit2ButtonClick(Sender: TObject);
begin
  if bsSkinSelectDirectoryDialog1.Execute then begin
    bsSkinFileEdit2.Text:= bsSkinSelectDirectoryDialog1.Directory;
    if bsSkinFileEdit2.Text <> '' then bsSkinButton2.Enabled:= True;
  end;
end;

function GetValidStr3(Str: string; var Dest: string; const Divider: array of Char): string;
const
  BUF_SIZE = 20480; //$7FFF;
var
  buf: array[0..BUF_SIZE] of Char;
  BufCount, Count, srclen, I, ArrCount: LongInt;
  Ch: Char;
label
  CATCH_DIV;
begin
  Ch := #0; //Jacky
  try
    srclen := Length(Str);
    BufCount := 0;
    Count := 1;

    if srclen >= BUF_SIZE - 1 then begin
      Result := '';
      Dest := '';
      Exit;
    end;

    if Str = '' then begin
      Dest := '';
      Result := Str;
      Exit;
    end;
    ArrCount := SizeOf(Divider) div SizeOf(Char);

    while True do begin
      if Count <= srclen then begin
        Ch := Str[Count];
        for I := 0 to ArrCount - 1 do
          if Ch = Divider[I] then
            goto CATCH_DIV;
      end;
      if (Count > srclen) then begin
        CATCH_DIV:
        if (BufCount > 0) then begin
          if BufCount < BUF_SIZE - 1 then begin
            buf[BufCount] := #0;
            Dest := string(buf);
            Result := Copy(Str, Count + 1, srclen - Count);
          end;
          Break;
        end else begin
          if (Count > srclen) then begin
            Dest := '';
            Result := Copy(Str, Count + 2, srclen - 1);
            Break;
          end;
        end;
      end else begin
        if BufCount < BUF_SIZE - 1 then begin
          buf[BufCount] := Ch;
          Inc(BufCount);
        end;
      end;
      Inc(Count);
    end;
  except
    Dest := '';
    Result := '';
  end;
end;

function Str_ToInt(Str: string; Def: LongInt): LongInt;
begin
  Result := Def;
  if Str <> '' then begin
    if ((Word(Str[1]) >= Word('0')) and (Word(Str[1]) <= Word('9'))) or
      (Str[1] = '+') or (Str[1] = '-') then try
      Result := StrToInt64(Str);
    except
    end;
  end;
end;

procedure TFrmMain.bsSkinButton3Click(Sender: TObject);
var
  LoadList:TStringList;
  sLineText:String;
  sIdx, sName, sStdMode, sShape, sWeight, sAniCount, sSource, sReserved, sLooks: string;
  sDuraMax, sAc, sAc2, sMac, sMac2, sDc, sDC2, sMc, sMc2, sSc, sSc2, sNeed, sNeedLevel, sStock, sPrice:string;
  I, Idx:integer;
begin
  OpenDialog1.Filter := 'Text文件(*.txt)|*.txt';
  with OpenDialog1 do begin
    if Execute then begin
      if FileExists(FileName) then begin
        LoadList:=TStringList.Create;
        LoadList.LoadFromFile(FileName);
        try
          Idx:= FrmDM.TableStdItems.RecordCount;
          for I := 0 to LoadList.Count - 1 do begin
            sLineText:= Trim(LoadList.Strings[I]);
            if (sLineText <> '') and (sLineText[1] <> ';') then begin
              sLineText := GetValidStr3(sLineText, sIdx, [';']);
              sLineText := GetValidStr3(sLineText, sName, [';']);
              sLineText := GetValidStr3(sLineText, sStdMode, [';']);
              sLineText := GetValidStr3(sLineText, sShape, [';']);
              sLineText := GetValidStr3(sLineText, sWeight, [';']);
              sLineText := GetValidStr3(sLineText, sAniCount, [';']);
              sLineText := GetValidStr3(sLineText, sSource, [';']);
              sLineText := GetValidStr3(sLineText, sReserved, [';']);
              sLineText := GetValidStr3(sLineText, sLooks, [';']);
              sLineText := GetValidStr3(sLineText, sDuraMax, [';']);
              sLineText := GetValidStr3(sLineText, sAc, [';']);
              sLineText := GetValidStr3(sLineText, sAc2, [';']);
              sLineText := GetValidStr3(sLineText, sMac, [';']);
              sLineText := GetValidStr3(sLineText, sMac2, [';']);
              sLineText := GetValidStr3(sLineText, sDc, [';']);
              sLineText := GetValidStr3(sLineText, sDC2, [';']);
              sLineText := GetValidStr3(sLineText, sMc, [';']);
              sLineText := GetValidStr3(sLineText, sMc2, [';']);
              sLineText := GetValidStr3(sLineText, sSc, [';']);
              sLineText := GetValidStr3(sLineText, sSc2, [';']);
              sLineText := GetValidStr3(sLineText, sNeed, [';']);
              sLineText := GetValidStr3(sLineText, sNeedLevel, [';']);
              sLineText := GetValidStr3(sLineText, sPrice, [';']);
              sLineText := GetValidStr3(sLineText, sStock, [';']);


              if sName <> '' then begin
                with FrmDM.TableStdItems do begin//写入数据库
                  Append;
                  FieldByName('Idx').AsInteger:= Idx;
                  FieldByName('Name').AsString:= sName;
                  FieldByName('StdMode').AsInteger:=Str_ToInt( sStdMode, 0);
                  FieldByName('Shape').AsInteger:=Str_ToInt( sShape, 0);//装备外观
                  FieldByName('Weight').AsInteger:=Str_ToInt( sWeight, 0);//重量
                  FieldByName('AniCount').AsInteger:= Str_ToInt( sAniCount, 0);
                  FieldByName('Source').AsInteger:= Str_ToInt( sSource, 0);
                  FieldByName('Reserved').AsInteger:= Str_ToInt( sReserved, 0);//保留
                  FieldByName('Looks').AsInteger:= Str_ToInt( sLooks, 0);//物品外观
                  FieldByName('DuraMax').AsInteger:= Str_ToInt( sDuraMax, 0);
                  FieldByName('Ac').AsInteger:= Str_ToInt( sAc, 0);
                  FieldByName('Ac2').AsInteger:= Str_ToInt( sAc2, 0);
                  FieldByName('Mac').AsInteger:= Str_ToInt( sMac, 0);
                  FieldByName('Mac2').AsInteger:= Str_ToInt( sMac2, 0);
                  FieldByName('Dc').AsInteger:= Str_ToInt( sDc, 0);
                  FieldByName('DC2').AsInteger:= Str_ToInt( sDC2, 0);
                  FieldByName('Mc').AsInteger:= Str_ToInt( sMc, 0);
                  FieldByName('Mc2').AsInteger:= Str_ToInt( sMc2, 0);
                  FieldByName('Sc').AsInteger:= Str_ToInt( sSc, 0);
                  FieldByName('Sc2').AsInteger:= Str_ToInt( sSc2, 0);
                  FieldByName('Need').AsInteger:= Str_ToInt( sNeed, 0);
                  FieldByName('NeedLevel').AsInteger:= Str_ToInt( sNeedLevel, 0);
                  FieldByName('Stock').AsInteger:= Str_ToInt( sStock, 0);
                  FieldByName('Price').AsInteger:= Str_ToInt( sPrice, 0);
                  post;
                  Inc(Idx);
                  Application.ProcessMessages;//出让控制权，让windows做其它事
                end;
              end;
            end;
          end;
        finally
          LoadList.Free;
        end;
      end;
    end;
  end;
end;

procedure TFrmMain.bsSkinButton18Click(Sender: TObject);
var
  LoadList:TStringList;
  sLineText:String;
  sIdx, sName, sStdMode, sShape, sAniCount, sHours, sLooks: string;
  sDuraMax, sAc, sAc2, sMac, sMac2, sDc, sDC2, sMc, sMc2, sSc, sSc2, sNeed, sNeedLevel, sStock:string;
  I, Idx:integer;
begin
  OpenDialog1.Filter := 'Text文件(*.txt)|*.txt';
  with OpenDialog1 do begin
    if Execute then begin
      if FileExists(FileName) then begin
        LoadList:=TStringList.Create;
        LoadList.LoadFromFile(FileName);
        try
          Idx:= FrmDM.TableFongHao.RecordCount;
          for I := 0 to LoadList.Count - 1 do begin
            sLineText:= Trim(LoadList.Strings[I]);
            if (sLineText <> '') and (sLineText[1] <> ';') then begin
              sLineText := GetValidStr3(sLineText, sIdx, [';']);
              sLineText := GetValidStr3(sLineText, sName, [';']);
              sLineText := GetValidStr3(sLineText, sStdMode, [';']);
              sLineText := GetValidStr3(sLineText, sShape, [';']);
              sLineText := GetValidStr3(sLineText, sAniCount, [';']);
              sLineText := GetValidStr3(sLineText, sHours, [';']);
              sLineText := GetValidStr3(sLineText, sLooks, [';']);
              sLineText := GetValidStr3(sLineText, sDuraMax, [';']);
              sLineText := GetValidStr3(sLineText, sAc, [';']);
              sLineText := GetValidStr3(sLineText, sAc2, [';']);
              sLineText := GetValidStr3(sLineText, sMac, [';']);
              sLineText := GetValidStr3(sLineText, sMac2, [';']);
              sLineText := GetValidStr3(sLineText, sDc, [';']);
              sLineText := GetValidStr3(sLineText, sDC2, [';']);
              sLineText := GetValidStr3(sLineText, sMc, [';']);
              sLineText := GetValidStr3(sLineText, sMc2, [';']);
              sLineText := GetValidStr3(sLineText, sSc, [';']);
              sLineText := GetValidStr3(sLineText, sSc2, [';']);
              sLineText := GetValidStr3(sLineText, sNeed, [';']);
              sLineText := GetValidStr3(sLineText, sNeedLevel, [';']);
              sLineText := GetValidStr3(sLineText, sStock, [';']);

              if sName <> '' then begin
                with FrmDM.TableFongHao do begin//写入数据库
                  Append;
                  FieldByName('Idx').AsInteger:= Idx;
                  FieldByName('Name').AsString:= sName;
                  FieldByName('StdMode').AsInteger:=Str_ToInt( sStdMode, 0);
                  FieldByName('Shape').AsInteger:=Str_ToInt( sShape, 0);//装备外观
                  FieldByName('AniCount').AsInteger:= Str_ToInt( sAniCount, 0);
                  FieldByName('Hours').AsInteger:= Str_ToInt( sHours, 0);//使用期(小时)
                  FieldByName('Looks').AsInteger:= Str_ToInt( sLooks, 0);//物品外观
                  FieldByName('DuraMax').AsInteger:= Str_ToInt( sDuraMax, 0);
                  FieldByName('Ac').AsInteger:= Str_ToInt( sAc, 0);
                  FieldByName('Ac2').AsInteger:= Str_ToInt( sAc2, 0);
                  FieldByName('Mac').AsInteger:= Str_ToInt( sMac, 0);
                  FieldByName('Mac2').AsInteger:= Str_ToInt( sMac2, 0);
                  FieldByName('Dc').AsInteger:= Str_ToInt( sDc, 0);
                  FieldByName('DC2').AsInteger:= Str_ToInt( sDC2, 0);
                  FieldByName('Mc').AsInteger:= Str_ToInt( sMc, 0);
                  FieldByName('Mc2').AsInteger:= Str_ToInt( sMc2, 0);
                  FieldByName('Sc').AsInteger:= Str_ToInt( sSc, 0);
                  FieldByName('Sc2').AsInteger:= Str_ToInt( sSc2, 0);
                  FieldByName('Need').AsInteger:= Str_ToInt( sNeed, 0);
                  FieldByName('NeedLevel').AsInteger:= Str_ToInt( sNeedLevel, 0);
                  FieldByName('Stock').AsInteger:= Str_ToInt( sStock, 0);
                  post;
                  Inc(Idx);
                  Application.ProcessMessages;//出让控制权，让windows做其它事
                end;
              end;
            end;
          end;
        finally
          LoadList.Free;
        end;
      end;
    end;
  end;
end;

procedure TFrmMain.bsSkinButton4Click(Sender: TObject);
var
  LoadList:TStringList;
  sLineText:String;
  sName, sRace, sRaceImg, sAppr, sLvl, sUndead, sCoolEye, sExp, sHP, sMP, sAC: string;
  sMAC, sDC, sDCMAX, sMC, sSC, sSPEED, sHIT, sWALK_SPD, sWalkStep, sWalkWait, sATTACK_SPD: string;
  I:integer;
begin
  OpenDialog1.Filter := 'Text文件(*.txt)|*.txt';
  with OpenDialog1 do begin
    if Execute then begin
      if FileExists(FileName) then begin
        LoadList:=TStringList.Create;
        LoadList.LoadFromFile(FileName);
        try
          for I := 0 to LoadList.Count - 1 do begin
            sLineText:= Trim(LoadList.Strings[I]);
            if (sLineText <> '') and (sLineText[1] <> ';') then begin
              sLineText := GetValidStr3(sLineText, sName, [';']);
              sLineText := GetValidStr3(sLineText, sRace, [';']);
              sLineText := GetValidStr3(sLineText, sRaceImg, [';']);
              sLineText := GetValidStr3(sLineText, sAppr, [';']);
              sLineText := GetValidStr3(sLineText, sLvl, [';']);
              sLineText := GetValidStr3(sLineText, sUndead, [';']);
              sLineText := GetValidStr3(sLineText, sCoolEye, [';']);
              sLineText := GetValidStr3(sLineText, sExp, [';']);
              sLineText := GetValidStr3(sLineText, sHP, [';']);
              sLineText := GetValidStr3(sLineText, sMP, [';']);
              sLineText := GetValidStr3(sLineText, sAC, [';']);
              sLineText := GetValidStr3(sLineText, sMAC, [';']);
              sLineText := GetValidStr3(sLineText, sDC, [';']);
              sLineText := GetValidStr3(sLineText, sDCMAX, [';']);
              sLineText := GetValidStr3(sLineText, sMC, [';']);
              sLineText := GetValidStr3(sLineText, sSC, [';']);
              sLineText := GetValidStr3(sLineText, sSPEED, [';']);
              sLineText := GetValidStr3(sLineText, sHIT, [';']);
              sLineText := GetValidStr3(sLineText, sWALK_SPD, [';']);
              sLineText := GetValidStr3(sLineText, sWalkStep, [';']);
              sLineText := GetValidStr3(sLineText, sWalkWait, [';']);
              sLineText := GetValidStr3(sLineText, sATTACK_SPD, [';']);

              if sName <> '' then begin
                with FrmDM.TableMonster do begin//写入数据库
                  Append;
                  FieldByName('Name').AsString:= sName;
                  FieldByName('Race').AsInteger:= Str_ToInt( sRace, 0);
                  FieldByName('RaceImg').AsInteger:= Str_ToInt( sRaceImg, 0);
                  FieldByName('Appr').AsInteger:= Str_ToInt( sAppr, 0);
                  FieldByName('Lvl').AsInteger:= Str_ToInt( sLvl, 0);
                  FieldByName('Undead').AsInteger:= Str_ToInt( sUndead, 0);
                  FieldByName('CoolEye').AsInteger:= Str_ToInt( sCoolEye, 0);
                  FieldByName('Exp').AsInteger:= Str_ToInt( sExp, 0);
                  FieldByName('HP').AsInteger:= Str_ToInt( sHP, 0);
                  FieldByName('MP').AsInteger:= Str_ToInt( sMP, 0);
                  FieldByName('AC').AsInteger:= Str_ToInt( sAC, 0);
                  FieldByName('MAC').AsInteger:= Str_ToInt( sMAC, 0);
                  FieldByName('DC').AsInteger:= Str_ToInt( sDC, 0);
                  FieldByName('DCMAX').AsInteger:= Str_ToInt( sDCMAX, 0);
                  FieldByName('MC').AsInteger:= Str_ToInt( sMC, 0);
                  FieldByName('SC').AsInteger:= Str_ToInt( sSC, 0);
                  FieldByName('SPEED').AsInteger:= Str_ToInt( sSPEED, 0);
                  FieldByName('HIT').AsInteger:= Str_ToInt( sHIT, 0);
                  FieldByName('WALK_SPD').AsInteger:= Str_ToInt( sWALK_SPD, 0);
                  FieldByName('WalkStep').AsInteger:= Str_ToInt( sWalkStep, 0);
                  FieldByName('WalkWait').AsInteger:= Str_ToInt( sWalkWait, 0);
                  FieldByName('ATTACK_SPD').AsInteger:= Str_ToInt( sATTACK_SPD, 0);
                  post;
                  Application.ProcessMessages;//出让控制权，让windows做其它事
                end;
              end;
            end;
          end;
        finally
          LoadList.Free;
        end;
      end;
    end;
  end;
end;

procedure TFrmMain.bsSkinButton5Click(Sender: TObject);
var
  LoadList:TStringList;
  sLineText:String;
  sMagId,sMagName,sEffectType,sEffect,sSpell,sPower,sMaxPower,sJob: string;
  sNeedL1,sNeedL2,sNeedL3,sL1Train,sL2Train,sL3Train,sDelay,sDefSpell,sDefPower,sDefMaxPower,sDescr: string;
  I:integer;
begin
  OpenDialog1.Filter := 'Text文件(*.txt)|*.txt';
  with OpenDialog1 do begin
    if Execute then begin
      if FileExists(FileName) then begin
        LoadList:=TStringList.Create;
        LoadList.LoadFromFile(FileName);
        try
          for I := 0 to LoadList.Count - 1 do begin
            sLineText:= Trim(LoadList.Strings[I]);
            if (sLineText <> '') and (sLineText[1] <> ';') then begin
              sLineText := GetValidStr3(sLineText, sMagId, [';']);
              sLineText := GetValidStr3(sLineText, sMagName, [';']);
              sLineText := GetValidStr3(sLineText, sEffectType, [';']);
              sLineText := GetValidStr3(sLineText, sEffect, [';']);
              sLineText := GetValidStr3(sLineText, sSpell, [';']);
              sLineText := GetValidStr3(sLineText, sPower, [';']);
              sLineText := GetValidStr3(sLineText, sMaxPower, [';']);
              sLineText := GetValidStr3(sLineText, sDefSpell, [';']);
              sLineText := GetValidStr3(sLineText, sDefPower, [';']);
              sLineText := GetValidStr3(sLineText, sDefMaxPower, [';']);
              sLineText := GetValidStr3(sLineText, sJob, [';']);
              sLineText := GetValidStr3(sLineText, sNeedL1, [';']);
              sLineText := GetValidStr3(sLineText, sL1Train, [';']);
              sLineText := GetValidStr3(sLineText, sNeedL2, [';']);
              sLineText := GetValidStr3(sLineText, sL2Train, [';']);
              sLineText := GetValidStr3(sLineText, sNeedL3, [';']);
              sLineText := GetValidStr3(sLineText, sL3Train, [';']);
              sLineText := GetValidStr3(sLineText, sDelay, [';']);
              sLineText := GetValidStr3(sLineText, sDescr, [';']);

              if sMagName <> '' then begin
                with FrmDM.TableMagic do begin//写入数据库
                  Append;
                  FieldByName('MagId').AsInteger:= Str_ToInt( sMagId, 0);
                  FieldByName('MagName').AsString:= sMagName;
                  FieldByName('EffectType').AsInteger:= Str_ToInt( sEffectType, 0);
                  FieldByName('Effect').AsInteger:= Str_ToInt( sEffect, 0);
                  FieldByName('Spell').AsInteger:= Str_ToInt( sSpell, 0);
                  FieldByName('Power').AsInteger:= Str_ToInt( sPower, 0);
                  FieldByName('MaxPower').AsInteger:= Str_ToInt( sMaxPower, 0);


                  FieldByName('Job').AsInteger:= Str_ToInt( sJob, 0);
                  FieldByName('NeedL1').AsInteger:= Str_ToInt( sNeedL1, 0);
                  FieldByName('NeedL2').AsInteger:= Str_ToInt( sNeedL2, 0);
                  FieldByName('NeedL3').AsInteger:= Str_ToInt( sNeedL3, 0);
                  FieldByName('L1Train').AsInteger:= Str_ToInt( sL1Train, 0);
                  FieldByName('L2Train').AsInteger:= Str_ToInt( sL2Train, 0);
                  FieldByName('L3Train').AsInteger:= Str_ToInt( sL3Train, 0);
                  FieldByName('Delay').AsInteger:= Str_ToInt( sDelay, 0);
                  FieldByName('DefSpell').AsInteger:= Str_ToInt( sDefSpell, 0);
                  FieldByName('DefPower').AsInteger:= Str_ToInt( sDefPower, 0);
                  FieldByName('DefMaxPower').AsInteger:= Str_ToInt( sDefMaxPower, 0);
                  FieldByName('Descr').AsString:= sDescr;
                  post;
                  Application.ProcessMessages;//出让控制权，让windows做其它事
                end;
              end;
            end;
          end;
        finally
          LoadList.Free;
        end;
      end;
    end;
  end;
end;

procedure TFrmMain.bsSkinButton6Click(Sender: TObject);
  function GetParadoxConnectionString(Path: string; Password: string): string;
  var
    s: string;
  begin
    s := 'Provider=Microsoft.Jet.OLEDB.4.0;';
    s := s + 'Data Source=' + Path + ';';
    s := s + 'Extended Properties=Paradox 7.x;Persist Security Info=False;';
    s := s + 'Mode=Share Deny None;';
    if Password <> '' then
      s := s + 'Jet OLEDB:Database Password=' + Password;
    Result := s;
  end;
var
  DestTable:TTable;
  KK: TFieldDef;
begin
  DestTable:= TTable.Create(Application);
  try
    FrmDM.TableMagic.Open;
    with DestTable do begin
      FieldDefs.Assign(FrmDM.TableMagic.FieldDefs);//复制表结构
      DataBaseName:= bsSkinFileEdit3.text;//保存路径
      KK:= FieldDefs.Find('MagName');
      KK.DataType:= ftString;//修改MagName为string类型
      KK.Size:= 18;//扩展数量
      TableName:='NewMagic';//数据库名
      TableType:=ttParadox;//数据库类型
      CreateTable;//创建新的数据表
    end;

    DestTable.Open;
    FrmDM.Query1.DataBaseName:=DBEName;
    with FrmDM.Query1 do begin
      close;
      sql.Clear ;
      sql.add('select * from Magic order by Descr,MagId DESC');
      open;
      First;
      while not FrmDM.Query1.Eof do begin
        with DestTable do begin
          Insert;
          FieldByName('MagId').AsInteger := FrmDM.Query1.FieldByName('MagId').AsInteger;
          FieldByName('MagName').AsString := FrmDM.Query1.FieldByName('MagName').AsString;
          FieldByName('EffectType').AsInteger := FrmDM.Query1.FieldByName('EffectType').AsInteger;
          FieldByName('Effect').AsInteger := FrmDM.Query1.FieldByName('Effect').AsInteger;
          FieldByName('Spell').AsInteger := FrmDM.Query1.FieldByName('Spell').AsInteger;
          FieldByName('Power').AsInteger := FrmDM.Query1.FieldByName('Power').AsInteger;
          FieldByName('MaxPower').AsInteger := FrmDM.Query1.FieldByName('MaxPower').AsInteger;
          FieldByName('DefSpell').AsInteger := FrmDM.Query1.FieldByName('DefSpell').AsInteger;
          FieldByName('DefPower').AsInteger := FrmDM.Query1.FieldByName('DefPower').AsInteger;
          FieldByName('DefMaxPower').AsInteger := FrmDM.Query1.FieldByName('DefMaxPower').AsInteger;
          FieldByName('Job').AsInteger := FrmDM.Query1.FieldByName('Job').AsInteger;
          FieldByName('NeedL1').AsInteger := FrmDM.Query1.FieldByName('NeedL1').AsInteger;
          FieldByName('L1Train').AsInteger := FrmDM.Query1.FieldByName('L1Train').AsInteger;
          FieldByName('NeedL2').AsInteger := FrmDM.Query1.FieldByName('NeedL2').AsInteger;
          FieldByName('L2Train').AsInteger := FrmDM.Query1.FieldByName('L2Train').AsInteger;
          FieldByName('NeedL3').AsInteger := FrmDM.Query1.FieldByName('NeedL3').AsInteger;
          FieldByName('L3Train').AsInteger := FrmDM.Query1.FieldByName('L3Train').AsInteger;
          FieldByName('Delay').AsInteger := FrmDM.Query1.FieldByName('Delay').AsInteger;
          FieldByName('Descr').AsString := FrmDM.Query1.FieldByName('Descr').AsString;
          post;
        end;
        FrmDM.Query1.Next;
      end;
    end;
  finally
    DestTable.Free;
  end;
  bsSkinMessage1.MessageDlg('数据库扩展完成！'+bsSkinFileEdit3.text+'\NewMagic.DB',mtInformation,[mbOK],0);
end;

procedure TFrmMain.bsSkinFileEdit3ButtonClick(Sender: TObject);
begin
  if bsSkinSelectDirectoryDialog1.Execute then begin
    bsSkinFileEdit3.Text:= bsSkinSelectDirectoryDialog1.Directory;
    if bsSkinFileEdit3.Text <> '' then bsSkinButton6.Enabled:= True;
  end;
end;

end.
